import re
import sys
from collections import defaultdict

def analyze_timeline(log_path):
    events = []
    current_time = 0
    player_stats = defaultdict(lambda: {
        'rus': [], 
        'total_rus': [], 
        'fleet_size': [], 
        'classes': {},
        'research': {}, # name: time
        'builds': {},   # name: time
        'wants': defaultdict(list), # name: [(time, demand)]
        'threats': [], # (time, self, enemy)
        'fleet_snapshots': {} # time: ship_string
    })

    # Match patterns (Optional timestamp prefix support)
    re_telemetry = re.compile(r"--- Match Telemetry @ (\d+)s ---")
    re_player_rus = re.compile(r"(?:\[(\d+)s\] )?\[DIAG\] (P\d) \([\w_]+\) \| Fleet: (\d+) \| RUs: (\d+) \| TotalRUs: (\d+)")
    re_classes = re.compile(r"(?:\[(\d+)s\] )?\[DIAG\] (P\d) CLASSES \| F: (\d+) \| B: (\d+) \| C: (\d+) \| Fr: (\d+) \| Cap: (\d+)")
    re_ships = re.compile(r"(?:\[(\d+)s\] )?\[DIAG\] (P\d) SHIPS \| (.*)")
    
    re_research = re.compile(r"(?:\[(\d+)s\] )?\[AI_DIAG\] (P\d) \| RESEARCH \| Target: ([\w\s&]+)")
    re_want = re.compile(r"(?:\[(\d+)s\] )?\[AI_DIAG\] (P\d) \| WANT \| ([\w\s&]+) \| Demand: ([\d.]+)")
    re_threat = re.compile(r"(?:\[(\d+)s\] )?\[AI_DIAG\] (P\d) \| THREAT \| Self: (\d+) \| EnemyTotal: (\d+)")

    with open(log_path, 'r', errors='ignore') as f:
        for line in f:
            # Time tracking from telemetry header
            tm = re_telemetry.search(line)
            if tm:
                current_time = int(tm.group(1))
                continue

            # Helper to get time from line or fallback to current_time
            def get_time(match, idx=1):
                if match.group(idx):
                    return int(match.group(idx))
                return current_time

            # Resource and Fleet tracking
            rus = re_player_rus.search(line)
            if rus:
                line_time = get_time(rus)
                p = rus.group(2)
                player_stats[p]['rus'].append((line_time, int(rus.group(4))))
                player_stats[p]['total_rus'].append((line_time, int(rus.group(5))))
                player_stats[p]['fleet_size'].append((line_time, int(rus.group(3))))
                continue

            # Detailed Ship Tracking
            shp = re_ships.search(line)
            if shp:
                line_time = get_time(shp)
                p = shp.group(2)
                ship_data = shp.group(3).strip()
                
                # Snapshot every 120s or so to avoid spam, but structured
                if line_time % 120 == 0 or line_time == current_time:
                    player_stats[p]['fleet_snapshots'][line_time] = ship_data

                for ship_entry in ship_data.split():
                    if ':' in ship_entry:
                        ship_name, count = ship_entry.split(':')
                        count_str = re.sub(r'\D', '', count)
                        if count_str and int(count_str) > 0 and ship_name not in player_stats[p]['builds']:
                            player_stats[p]['builds'][ship_name] = line_time
                            events.append({'time': line_time, 'player': p, 'type': 'BUILD', 'target': ship_name})
                continue

            # Class counts
            cls = re_classes.search(line)
            if cls:
                line_time = get_time(cls)
                p = cls.group(2)
                player_stats[p]['classes'][line_time] = {
                    'F': int(cls.group(3)),
                    'B': int(cls.group(4)),
                    'C': int(cls.group(5)),
                    'Fr': int(cls.group(6)),
                    'Cap': int(cls.group(7))
                }
                continue

            # Research tracking
            res = re_research.search(line)
            if res:
                line_time = get_time(res)
                p = res.group(2)
                target = res.group(3).strip()
                if target not in player_stats[p]['research']:
                    player_stats[p]['research'][target] = line_time
                    events.append({'time': line_time, 'player': p, 'type': 'RESEARCH', 'target': target})
                continue
            
            # Demand tracking
            wnt = re_want.search(line)
            if wnt:
                line_time = get_time(wnt)
                p = wnt.group(2)
                target = wnt.group(3).strip()
                demand = float(wnt.group(4))
                player_stats[p]['wants'][target].append((line_time, demand))
                continue

            # Threat tracking
            thr = re_threat.search(line)
            if thr:
                line_time = get_time(thr)
                p = thr.group(2)
                self_t = int(thr.group(3))
                enem_t = int(thr.group(4))
                player_stats[p]['threats'].append((line_time, self_t, enem_t))
                continue

    # Sort events by time
    events.sort(key=lambda x: (x['time'], x['player'], x['type']))

    print("====================================================")
    print("      FSFC MATCH TIMELINE ANALYSIS REPORT")
    print("====================================================\n")

    print("--- CHRONOLOGICAL MILESTONES ---")
    for e in events:
        mins = e['time'] // 60
        secs = e['time'] % 60
        time_str = f"{mins:02d}:{secs:02d}"
        if e['type'] == 'RESEARCH':
            print(f"[{time_str}] [{e['player']}] TECH: {e['target']} researched.")
        else:
            print(f"[{time_str}] [{e['player']}] UNIT: First {e['target']} deployed.")

    print("\n--- FLEET EVOLUTION (Interval Snapshots) ---")
    for p in sorted(player_stats.keys()):
        print(f"\n[{p}] Fleet History:")
        snapshots = sorted(player_stats[p]['fleet_snapshots'].keys())
        # Filter to show every ~3 mins or key changes
        last_shown = -999
        for t in snapshots:
            if t - last_shown >= 180 or t == snapshots[-1]:
                mins = t // 60
                time_str = f"{mins:02d}m"
                ships = player_stats[p]['fleet_snapshots'][t]
                print(f"  {time_str:4}: {ships}")
                last_shown = t

    print("\n--- ECONOMY EVOLUTION (Interval Snapshots) ---")
    for p in sorted(player_stats.keys()):
        print(f"\n[{p}] Economy History:")
        history = sorted(player_stats[p]['total_rus'])
        last_shown = -999
        for t, total in history:
            if t - last_shown >= 300 or t == history[-1][0]:
                mins = t // 60
                time_str = f"{mins:02d}m"
                # Find current RUs for this time
                current_ru = next((r[1] for r in reversed(player_stats[p]['rus']) if r[0] <= t), 0)
                income_rate = total / (t / 60) if t > 0 else 0
                print(f"  {time_str:4}: Current RU: {current_ru:5} | Lifetime: {total:6} | Avg: {income_rate:6.1f} RU/min")
                last_shown = t

    print("\n--- STRATEGIC EVOLUTION (Interval Snapshots) ---")
    for p in sorted(player_stats.keys()):
        print(f"\n[{p}] Status History:")
        threats = sorted(player_stats[p]['threats'])
        last_shown = -999
        for t, self_t, enem_t in threats:
            if t - last_shown >= 300 or t == threats[-1][0]:
                mins = t // 60
                time_str = f"{mins:02d}m"
                # Get top demand at this time
                p_wants = []
                for target, history in player_stats[p]['wants'].items():
                    d_at_t = next((h[1] for h in reversed(history) if h[0] <= t), 0)
                    if d_at_t > 0: p_wants.append((target, d_at_t))
                
                top_want = "None"
                if p_wants:
                    top_want = sorted(p_wants, key=lambda x: x[1], reverse=True)[0][0]
                
                print(f"  {time_str:4}: Threat: {self_t:3} vs {enem_t:3} | Top Want: {top_want}")
                last_shown = t

    print("\n--- TECH VELOCITY (Interval Snapshots) ---")
    for p in sorted(player_stats.keys()):
        print(f"\n[{p}] Tech Growth:")
        researches = sorted(player_stats[p]['research'].items(), key=lambda x: x[1])
        last_shown = -999
        count = 0
        for target, t in researches:
            count += 1
            if t - last_shown >= 300 or target == researches[-1][0]:
                mins = t // 60
                time_str = f"{mins:02d}m"
                print(f"  {time_str:4}: {count} Technologies unlocked.")
                last_shown = t

    print("\n====================================================")

if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: python3 timeline_analysis.py <path_to_HwRM.log>")
    else:
        analyze_timeline(sys.argv[1])
