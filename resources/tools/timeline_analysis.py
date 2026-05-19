import re
import sys
from collections import defaultdict

DEMAND_KEY_MAP = {
    "F":  "Fighter",
    "B":  "Bomber",
    "Fr": "Frigate",
    "De": "Destroyer",
    "Ca": "Capital",
    "Cv": "Carrier",
    "Bc": "BattleCr",
    "Co": "Collector",
    "Re": "Refinery",
}

def analyze_timeline(log_path):
    events = []
    current_time = 0
    player_stats = defaultdict(lambda: {
        'race': 'UNK',
        'rus': [],
        'total_rus': [],
        'fleet_size': [],
        'classes': {},
        'research_completed': {},   # name: time_first_targeted
        'research_targeted': {},    # name: time_first_targeted
        'builds': {},               # name: time_first_seen
        'demand_snapshots': [],     # (time, {Fighter: val, ...})
        'research_demand_snapshots': [],  # (time, [(name, val), ...])
        'threats': [],              # (time, self, enemy, target_p)
        'fleet_snapshots': {}       # time: ship_string
    })

    re_telemetry      = re.compile(r"--- Match Telemetry @ (\d+)s ---")
    re_player_basics  = re.compile(r"(?:\[(\d+)s\] )?\[DIAG\] (P\d) \(([\w_]+)\) \| Fleet: (\d+) \| RUs: (\d+) \| TotalRUs: (\d+)")
    re_classes        = re.compile(r"(?:\[(\d+)s\] )?\[DIAG\] (P\d) CLASSES \| F: (\d+) \| B: (\d+) \| C: (\d+) \| Fr: (\d+) \| Cap: (\d+)")
    re_ships          = re.compile(r"(?:\[(\d+)s\] )?\[DIAG\] (P\d) SHIPS \| (.*)")
    re_research_tgt   = re.compile(r"(?:\[(\d+)s\] )?\[AI_DIAG\] (P\d) \| RESEARCH \| Target: ([\w\s&]+)")
    re_research_done  = re.compile(r"(?:\[(\d+)s\] )?\[AI_DIAG\] (P\d) \| RESEARCH \| Completed: ([\w\s&]+)")
    re_threat         = re.compile(r"(?:\[(\d+)s\] )?\[AI_DIAG\] (P\d) \| THREAT \| Self: (\d+) \| EnemyTotal: (\d+) \| TargetP: (-?\d+)")
    # New: DEMAND snapshot
    re_demand         = re.compile(r"\[(\d+)s\] \[AI_DIAG\] (P\d) DEMAND \| F:([\d.\-]+) B:([\d.\-]+) Fr:([\d.\-]+) De:([\d.\-]+) Ca:([\d.\-]+) Cv:([\d.\-]+) Bc:([\d.\-]+) Co:([\d.\-]+) Re:([\d.\-]+)")
    # New: RESEARCH_DEMAND snapshot
    re_res_demand     = re.compile(r"\[(\d+)s\] \[AI_DIAG\] (P\d) RESEARCH_DEMAND \| (.+)")

    def get_time(match, idx=1):
        g = match.group(idx)
        return int(g) if g else current_time

    with open(log_path, 'r', errors='ignore') as f:
        for line in f:
            tm = re_telemetry.search(line)
            if tm:
                current_time = int(tm.group(1))
                continue

            # --- DEMAND snapshot ---
            if "DEMAND |" in line and "AI_DIAG" in line and "RESEARCH_DEMAND" not in line:
                m = re_demand.search(line)
                if m:
                    t = int(m.group(1))
                    p = m.group(2)
                    snap = {
                        "Fighter":   float(m.group(3)),
                        "Bomber":    float(m.group(4)),
                        "Frigate":   float(m.group(5)),
                        "Destroyer": float(m.group(6)),
                        "Capital":   float(m.group(7)),
                        "Carrier":   float(m.group(8)),
                        "BattleCr":  float(m.group(9)),
                        "Collector": float(m.group(10)),
                        "Refinery":  float(m.group(11)),
                    }
                    player_stats[p]['demand_snapshots'].append((t, snap))
                continue

            # --- RESEARCH_DEMAND snapshot ---
            if "RESEARCH_DEMAND |" in line and "AI_DIAG" in line:
                m = re_res_demand.search(line)
                if m:
                    t = int(m.group(1))
                    p = m.group(2)
                    entries = []
                    for pair in m.group(3).strip().split():
                        if ":" in pair:
                            name, val_str = pair.split(":", 1)
                            try:
                                entries.append((name, float(val_str)))
                            except ValueError:
                                pass
                    player_stats[p]['research_demand_snapshots'].append((t, entries))
                continue

            # --- Player basics ---
            basics = re_player_basics.search(line)
            if basics:
                t = get_time(basics)
                p = basics.group(2)
                player_stats[p]['race'] = basics.group(3)
                player_stats[p]['rus'].append((t, int(basics.group(5))))
                player_stats[p]['total_rus'].append((t, int(basics.group(6))))
                player_stats[p]['fleet_size'].append((t, int(basics.group(4))))
                continue

            # --- Ship snapshots + first-build events ---
            shp = re_ships.search(line)
            if shp:
                t = get_time(shp)
                p = shp.group(2)
                ship_data = shp.group(3).strip()
                if t % 120 == 0 or t == current_time:
                    player_stats[p]['fleet_snapshots'][t] = ship_data
                for entry in ship_data.split():
                    if ':' in entry:
                        ship_name, count = entry.split(':')
                        count_clean = re.sub(r'\D', '', count)
                        if count_clean and int(count_clean) > 0 and ship_name not in player_stats[p]['builds']:
                            player_stats[p]['builds'][ship_name] = t
                            events.append({'time': t, 'player': p, 'type': 'BUILD', 'target': ship_name})
                continue

            # --- Class counts ---
            cls = re_classes.search(line)
            if cls:
                t = get_time(cls)
                p = cls.group(2)
                player_stats[p]['classes'][t] = {
                    'F': int(cls.group(3)), 'B': int(cls.group(4)),
                    'C': int(cls.group(5)), 'Fr': int(cls.group(6)),
                    'Cap': int(cls.group(7))
                }
                continue

            # --- Research: Target ---
            res = re_research_tgt.search(line)
            if res:
                t = get_time(res)
                p = res.group(2)
                target = res.group(3).strip()
                if "Tactics" not in target and target not in player_stats[p]['research_targeted']:
                    player_stats[p]['research_targeted'][target] = t
                    events.append({'time': t, 'player': p, 'type': 'RESEARCH_START', 'target': target})
                continue

            # --- Research: Completed ---
            done = re_research_done.search(line)
            if done:
                t = get_time(done)
                p = done.group(2)
                target = done.group(3).strip()
                if target not in player_stats[p]['research_completed']:
                    player_stats[p]['research_completed'][target] = t
                    events.append({'time': t, 'player': p, 'type': 'RESEARCH_DONE', 'target': target})
                continue

            # --- Threats ---
            thr = re_threat.search(line)
            if thr:
                t = get_time(thr)
                p = thr.group(2)
                player_stats[p]['threats'].append((t, int(thr.group(3)), int(thr.group(4)), int(thr.group(5))))
                continue

    events.sort(key=lambda x: (x['time'], x['player'], x['type']))

    # -------------------------------------------------------------------------
    # REPORT
    # -------------------------------------------------------------------------
    sep = "=" * 60

    print(sep)
    print("       FSFC MATCH TIMELINE ANALYSIS REPORT")
    print(sep)

    # --- 1. Chronological Milestones ---
    print("\n--- 1. CHRONOLOGICAL MILESTONES ---")
    for e in events:
        mins, secs = e['time'] // 60, e['time'] % 60
        ts = f"{mins:02d}:{secs:02d}"
        if e['type'] == 'RESEARCH_DONE':
            print(f"  [{ts}] [{e['player']}] TECH DONE : {e['target']}")
        elif e['type'] == 'RESEARCH_START':
            print(f"  [{ts}] [{e['player']}] TECH START: {e['target']}")
        else:
            print(f"  [{ts}] [{e['player']}] UNIT FIRST: {e['target']}")

    # --- 2. Fleet Evolution ---
    print("\n--- 2. FLEET EVOLUTION (every ~2 min) ---")
    for p in sorted(player_stats.keys()):
        race = player_stats[p]['race']
        print(f"\n  [{p}] ({race})")
        snaps = sorted(player_stats[p]['fleet_snapshots'].keys())
        last = -999
        for t in snaps:
            if t - last >= 120 or t == snaps[-1]:
                print(f"    {t//60:02d}m: {player_stats[p]['fleet_snapshots'][t]}")
                last = t

    # --- 3. Economy Evolution ---
    print("\n--- 3. ECONOMY EVOLUTION (every ~5 min) ---")
    for p in sorted(player_stats.keys()):
        race = player_stats[p]['race']
        print(f"\n  [{p}] ({race})")
        history = sorted(player_stats[p]['total_rus'])
        last = -999
        for t, total in history:
            if t - last >= 300 or t == history[-1][0]:
                current_ru = next((r[1] for r in reversed(player_stats[p]['rus']) if r[0] <= t), 0)
                rate = total / (t / 60) if t > 0 else 0
                spent = total - current_ru
                print(f"    {t//60:02d}m: Avail={current_ru:5,}  Spent={spent:6,}  Lifetime={total:6,}  Rate={rate:5.0f}/min")
                last = t

    # --- 4. Build Demand Evolution ---
    print("\n--- 4. BUILD DEMAND EVOLUTION (every ~5 min) ---")
    ACTIVE_THRESHOLD = -7  # values at or below this are suppressed
    for p in sorted(player_stats.keys()):
        race = player_stats[p]['race']
        print(f"\n  [{p}] ({race})")
        snaps = player_stats[p]['demand_snapshots']
        if not snaps:
            print("    (no demand data)")
            continue
        last = -999
        for t, snap in snaps:
            if t - last >= 300:
                active = {k: v for k, v in snap.items() if v > ACTIVE_THRESHOLD}
                if not active:
                    last = t
                    continue
                parts = "  ".join(f"{k}:{v:+.0f}" for k, v in active.items())
                print(f"    {t//60:02d}m:{t%60:02d}s: {parts}")
                last = t
        # Always show last snapshot
        t, snap = snaps[-1]
        active = {k: v for k, v in snap.items() if v > ACTIVE_THRESHOLD}
        if active:
            parts = "  ".join(f"{k}:{v:+.0f}" for k, v in active.items())
            print(f"    {t//60:02d}m:{t%60:02d}s: {parts}  [FINAL]")

    # --- 5. Research Demand Evolution ---
    print("\n--- 5. RESEARCH DEMAND EVOLUTION (every ~3 min) ---")
    for p in sorted(player_stats.keys()):
        race = player_stats[p]['race']
        print(f"\n  [{p}] ({race})")
        snaps = player_stats[p]['research_demand_snapshots']
        if not snaps:
            print("    (no research demand data)")
            continue
        last = -999
        for t, entries in snaps:
            if t - last >= 180:
                parts = "  ".join(f"{name}:{val:.1f}" for name, val in entries)
                print(f"    {t//60:02d}m:{t%60:02d}s: {parts}")
                last = t
        # Always print final snapshot
        t, entries = snaps[-1]
        parts = "  ".join(f"{name}:{val:.1f}" for name, val in entries)
        print(f"    {t//60:02d}m:{t%60:02d}s: {parts}  [FINAL]")

    # --- 6. Strategic Evolution ---
    print("\n--- 6. STRATEGIC EVOLUTION (threat + demand, every ~5 min) ---")
    for p in sorted(player_stats.keys()):
        race = player_stats[p]['race']
        print(f"\n  [{p}] ({race})")
        threats = sorted(player_stats[p]['threats'])
        if not threats:
            print("    (no threat data)")
            continue
        last = -999
        for t, self_t, enem_t, target_p in threats:
            if t - last >= 300 or (t, self_t, enem_t, target_p) == threats[-1]:
                # Find closest demand snapshot at or before t
                demand_snaps = player_stats[p]['demand_snapshots']
                top_demand = "None"
                if demand_snaps:
                    snap = next((s for s in reversed(demand_snaps) if s[0] <= t), None)
                    if snap:
                        _, d = snap
                        active = {k: v for k, v in d.items() if v > 0}
                        if active:
                            top_k = max(active, key=active.get)
                            top_demand = f"{top_k}:{active[top_k]:+.0f}"
                # Find closest research demand snapshot
                res_snaps = player_stats[p]['research_demand_snapshots']
                top_res = "None"
                if res_snaps:
                    rsnap = next((s for s in reversed(res_snaps) if s[0] <= t), None)
                    if rsnap and rsnap[1]:
                        top_res = f"{rsnap[1][0][0]}:{rsnap[1][0][1]:.1f}"
                tgt_str = f"P{target_p}" if target_p != -1 else "None"
                print(f"    {t//60:02d}m: Pwr={self_t:3} vs {enem_t:3}  Tgt={tgt_str}  TopBuild={top_demand}  TopResearch={top_res}")
                last = t

    # --- 7. Tech Summary ---
    print("\n--- 7. TECH SUMMARY ---")
    for p in sorted(player_stats.keys()):
        race = player_stats[p]['race']
        done = sorted(player_stats[p]['research_completed'].items(), key=lambda x: x[1])
        pending = set(player_stats[p]['research_targeted']) - set(player_stats[p]['research_completed'])
        print(f"\n  [{p}] ({race}) — {len(done)} completed, {len(pending)} in-progress")
        for name, t in done:
            print(f"    [{t//60:02d}m:{t%60:02d}s] ✓ {name}")
        for name in sorted(pending):
            t = player_stats[p]['research_targeted'].get(name, 0)
            print(f"    [{t//60:02d}m:{t%60:02d}s] … {name}  (in progress)")

    print(f"\n{sep}\n")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        log_default = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HomeworldRM/Bin/Release/HwRM.log"
        print(f"Usage: python3 timeline_analysis.py <path_to_HwRM.log>")
        print(f"       (defaulting to {log_default})")
        analyze_timeline(log_default)
    else:
        analyze_timeline(sys.argv[1])
