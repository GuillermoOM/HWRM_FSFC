import os
import re
import time
import sys
import select
import termios
import tty
from rich.console import Console
from rich.layout import Layout
from rich.panel import Panel
from rich.table import Table
from rich.live import Live
from rich.text import Text
from rich import box

# Path to the HwRM.log file
LOG_PATH = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HomeworldRM/Bin/Release/HwRM.log"

console = Console()

class MatchData:
    def __init__(self):
        self.era = "Unknown"
        self.game_time = 0
        self.players = {
            1: {"race": "UNK", "fleet": 0, "rus": 0, "total_rus": 0, "threat_self": 0, "threat_enemy": 0, "target": -1, "research": "None", "res_history": [], "targeted_res": [], "completed_res": [], "stance": "Dynamic", "demand_snapshot": {}, "research_demand": [], "classes": {}},
            2: {"race": "UNK", "fleet": 0, "rus": 0, "total_rus": 0, "threat_self": 0, "threat_enemy": 0, "target": -1, "research": "None", "res_history": [], "targeted_res": [], "completed_res": [], "stance": "Dynamic", "demand_snapshot": {}, "research_demand": [], "classes": {}},
            3: {"race": "UNK", "fleet": 0, "rus": 0, "total_rus": 0, "threat_self": 0, "threat_enemy": 0, "target": -1, "research": "None", "res_history": [], "targeted_res": [], "completed_res": [], "stance": "Dynamic", "demand_snapshot": {}, "research_demand": [], "classes": {}},
        }
        self.history = []
        self.current_graph = 0 

data = MatchData()



def get_braille_char(bits):
    base = 0x2800
    res = 0
    remap = [0, 1, 2, 6, 3, 4, 5, 7]
    for i in range(8):
        if bits & (1 << i):
            res |= (1 << remap[i])
    return chr(base + res)

class BrailleGraph:
    def __init__(self, metrics, colors):
        self.metrics = metrics
        self.colors = colors

    def __rich_console__(self, console, options):
        width = options.max_width
        height = options.max_height
        if len(data.history) < 2:
            yield Text("Collecting tactical data...", justify="center", style="dim italic")
            return

        num_cols = width * 2
        hist_len = len(data.history)
        h_res = height * 4
        
        all_vals = []
        for m in self.metrics:
            all_vals.extend([h[m] for h in data.history])
        max_v = max(max(all_vals or [1]), 1)

        def normalize(m):
            if hist_len < 2: return [0] * num_cols
            step = (hist_len - 1) / (num_cols - 1)
            stretched = []
            for i in range(num_cols):
                idx = int(i * step)
                v = data.history[idx][m]
                stretched.append(int((v / max_v) * (h_res - 1)))
            return stretched
        
        pts_list = [normalize(m) for m in self.metrics]

        combined_lines = []
        for y_char in range(height - 1, -1, -1):
            line = Text()
            for x_char in range(0, num_cols, 2):
                char_bits = [0, 0, 0]
                for m_idx in range(len(self.metrics)):
                    pts = pts_list[m_idx]
                    for dx in range(2):
                        for dy in range(4):
                            ty = y_char * 4 + dy
                            xi = x_char + dx
                            if xi < len(pts) and pts[xi] == ty:
                                char_bits[m_idx] |= (1 << (dx * 4 + dy))
                
                if char_bits[0]: line.append(get_braille_char(char_bits[0]), style=self.colors[0])
                elif char_bits[1]: line.append(get_braille_char(char_bits[1]), style=self.colors[1])
                elif char_bits[2]: line.append(get_braille_char(char_bits[2]), style=self.colors[2])
                else: line.append(" ")
            combined_lines.append(line)
        for line in combined_lines:
            yield line

def parse_line(line):
    era_match = re.search(r"\[DIAG\] Era Setting: (.+)", line)
    if era_match: data.era = era_match.group(1)
    
    # Extract timestamp if available
    ts_match = re.search(r"\[(\d+)s\]", line)
    line_ts = int(ts_match.group(1)) if ts_match else data.game_time

    telemetry_time = re.search(r"--- Match Telemetry @ (\d+)s ---", line)
    if telemetry_time: data.game_time = int(telemetry_time.group(1))
    
    p_basics = re.search(r"\[DIAG\] P(\d) \((.+)\) \| Fleet: (\d+) \| RUs: (\d+) \| TotalRUs: (\d+)", line)
    if p_basics:
        p_id = int(p_basics.group(1))
        if p_id in data.players:
            data.players[p_id].update({"race": p_basics.group(2), "fleet": int(p_basics.group(3)), "rus": int(p_basics.group(4)), "total_rus": int(p_basics.group(5))})
    p_classes = re.search(r"\[DIAG\] P(\d) CLASSES \| F: (\d+) \| B: (\d+) \| C: (\d+) \| Fr: (\d+) \| Cap: (\d+) \| U: (\d+) \| P: (\d+)", line)
    if p_classes:
        p_id = int(p_classes.group(1))
        if p_id in data.players:
            data.players[p_id]["classes"] = {
                "F": p_classes.group(2), "B": p_classes.group(3), "C": p_classes.group(4), 
                "Fr": p_classes.group(5), "Cap": p_classes.group(6), "U": p_classes.group(7),
                "P": p_classes.group(8)
            }
    p_threat = re.search(r"\[AI_DIAG\] P(\d) \| THREAT \| Self: (\d+) \| EnemyTotal: (\d+) \| TargetP: (-?\d+)", line)
    if p_threat:
        p_id = int(p_threat.group(1))
        if p_id in data.players:
            data.players[p_id].update({"threat_self": int(p_threat.group(2)), "threat_enemy": int(p_threat.group(3)), "target": int(p_threat.group(4))})
    
    # Centralized demand snapshot: [Ns] [AI_DIAG] Px DEMAND | F:X B:X Fr:X De:X Ca:X Cv:X Bc:X Co:X Re:X
    # Printed directly from AI script context (every ~10s, throttled per player)
    if "DEMAND |" in line and "AI_DIAG" in line and "RESEARCH_DEMAND" not in line:
        m = re.search(r"\[AI_DIAG\] P(\d) DEMAND \| F:([\d\.-]+) B:([\d\.-]+) Fr:([\d\.-]+) De:([\d\.-]+) Ca:([\d\.-]+) Cv:([\d\.-]+) Bc:([\d\.-]+) Co:([\d\.-]+) Re:([\d\.-]+)", line)
        if m:
            p_id = int(m.group(1))
            if p_id in data.players:
                data.players[p_id]["demand_snapshot"] = {
                    "Fighter":   float(m.group(2)),
                    "Bomber":    float(m.group(3)),
                    "Cruiser":   float(m.group(4)),
                    "Destroyer": float(m.group(5)),
                    "Capital":   float(m.group(6)),
                    "Carrier":   float(m.group(7)),
                    "BattleCr":  float(m.group(8)),
                    "Collector": float(m.group(9)),
                    "Refinery":  float(m.group(10)),
                }

    # Research demand snapshot: [Ns] [AI_DIAG] Px RESEARCH_DEMAND | NodeA:X.X NodeB:X.X ...
    # Printed directly from AI script context after each DoUpgradeDemand cycle
    if "RESEARCH_DEMAND |" in line and "AI_DIAG" in line:
        m = re.search(r"\[AI_DIAG\] P(\d) RESEARCH_DEMAND \| (.+)", line)
        if m:
            p_id = int(m.group(1))
            if p_id in data.players:
                entries = []
                for pair in m.group(2).strip().split():
                    if ":" in pair:
                        parts = pair.split(":", 1)
                        try:
                            entries.append({"name": parts[0], "demand": float(parts[1])})
                        except ValueError:
                            pass
                data.players[p_id]["research_demand"] = entries

    if "RESEARCH |" in line:
        # Target Logging (for progress)
        m_target = re.search(r"P(\d) \| RESEARCH \| Target: (.+)", line)
        if m_target:
            p_id = int(m_target.group(1))
            if p_id in data.players:
                res_name = m_target.group(2).strip()
                if "Tactics" in res_name:
                    data.players[p_id]["stance"] = res_name.replace("Tactics", "")
        m = re.search(r"P(\d) \| RESEARCH \|", line)
        if m:
            p_id = int(m.group(1))
            # Tactics
            m_tactics = re.search(r"P\d \| RESEARCH \| Target: (.+) Tactics", line)
            if m_tactics:
                data.players[p_id]["stance"] = m_tactics.group(1)
            
            # Target Logging
            res_target_match = re.search(r'RESEARCH \| Target: (.*)', line)
            if res_target_match:
                res_name = res_target_match.group(1).strip()
                # Normalize to handle MANTICORE vs Manticore
                res_name = res_name.capitalize()
                if "Tactics" not in res_name:
                    data.players[p_id]["research"] = res_name
                    if res_name not in data.players[p_id]["targeted_res"]:
                        data.players[p_id]["targeted_res"].append(res_name)
            
            # Completed Logging
            res_done_match = re.search(r'RESEARCH \| Completed: (.*)', line)
            if res_done_match:
                res_name = res_done_match.group(1).strip().capitalize()
                if res_name not in data.players[p_id]["completed_res"]:
                    data.players[p_id]["completed_res"].append(res_name)
                if res_name in data.players[p_id]["targeted_res"]:
                    data.players[p_id]["targeted_res"].remove(res_name)
                if data.players[p_id]["research"] == res_name:
                    data.players[p_id]["research"] = "None"
                
    if "----------------------------------" in line and data.game_time > 0:
        if not data.history or data.history[-1]["time"] != data.game_time:
            data.history.append({
                "time": data.game_time,
                "p1_f": data.players[1]["fleet"], "p2_f": data.players[2]["fleet"], "p3_f": data.players[3]["fleet"],
                "p1_ru": data.players[1]["total_rus"], "p2_ru": data.players[2]["total_rus"], "p3_ru": data.players[3]["total_rus"],
                "p1_avail": data.players[1]["rus"], "p2_avail": data.players[2]["rus"], "p3_avail": data.players[3]["rus"],
                "p1_spent": data.players[1]["total_rus"] - data.players[1]["rus"],
                "p2_spent": data.players[2]["total_rus"] - data.players[2]["rus"],
                "p3_spent": data.players[3]["total_rus"] - data.players[3]["rus"],
                "p1_p": data.players[1]["threat_self"], "p2_p": data.players[2]["threat_self"], "p3_p": data.players[3]["threat_self"]
            })

RACE_NAMES = {"TER_": "Terran", "SHI_": "Shivan", "VAS_": "Vasudan", "UNK": "Unknown"}

def get_race_name(prefix):
    return RACE_NAMES.get(prefix, prefix)

def make_player_panel(p_id):
    p = data.players[p_id]
    if p["race"] == "UNK": return Panel(Text("\nWaiting...", justify="center", style="dim"), title=f"P{p_id}", border_style="dim")
    color = "cyan" if "TER" in p["race"] else "red" if "SHI" in p["race"] else "yellow"
    content = Text()
    
    # Header Stats
    content.append(f"F: {p['fleet']} | RU: {p['rus']:,} | Pwr: {p['threat_self']}\n", style="white")
    
    # Target and Stance
    target_p = p['target']
    target_race = get_race_name(data.players[target_p]['race']) if target_p in data.players else "None"
    target_str = f"P{target_p} ({target_race})" if target_p != -1 else "None"
    content.append("Tgt: ", style="red")
    content.append(f"{target_str} ", style="bold red")
    content.append(f"({p['threat_enemy']}) ", style="red")
    content.append(f"| {p['stance']}\n", style="cyan")
    
    # Demand Snapshot
    content.append("\nDEMAND SNAPSHOT:\n", style="bold yellow")
    ds = p.get("demand_snapshot", {})
    if not ds:
        content.append(" • No data yet\n", style="italic dim yellow")
    else:
        # Combat demand row
        DEMAND_FIELDS = [
            ("Fighter",   "Fighter  "),
            ("Bomber",    "Bomber   "),
            ("Cruiser",   "Frigate  "),
            ("Destroyer", "Destroyer"),
            ("Capital",   "Capital  "),
            ("Carrier",   "Carrier  "),
            ("BattleCr",  "BattleCr "),
            ("Collector", "Collector"),
            ("Refinery",  "Refinery "),
        ]
        for label, full in DEMAND_FIELDS:
            val = ds.get(label, 0.0)
            if val <= -7:
                continue  # suppressed — skip to reduce noise
            bar_len = min(max(int(val * 2), 0), 14)
            bar = "█" * bar_len
            style = "bright_red" if val >= 4.0 else "yellow" if val >= 1.0 else "dim white"
            content.append(f" {full}: ", style="white")
            content.append(f"{val:>5} ", style=style)
            content.append(f"{bar}\n", style=style)
    
    # Research Activity
    res_done = p['completed_res']
    targeted = p['targeted_res']
    rd = p.get("research_demand", [])
    content.append("\nRESEARCH DEMAND:\n", style="bold white")

    if rd:
        # Show demanded research nodes with bar — all entries, not just top
        max_d = max((e["demand"] for e in rd), default=1)
        for entry in rd:
            name = entry["name"]
            val = entry["demand"]
            bar_len = min(int((val / max(max_d, 1)) * 16), 16)
            bar = "▪" * bar_len
            style = "bright_red" if val >= max_d * 0.9 else "yellow" if val >= max_d * 0.5 else "dim"
            disp = name[:20] + ".." if len(name) > 22 else name
            is_targeted = any(disp.lower() in t.lower() or t.lower() in disp.lower() for t in targeted)
            prefix = "[>]" if is_targeted else "   "
            content.append(f" {prefix} {disp:<22} ", style="bold yellow" if is_targeted else "white")
            content.append(f"{val:>5.1f} {bar}\n", style=style)
        content.append("\n", style="")

    # Show last 8 completed
    content.append("COMPLETED:\n", style="bold green")
    if not res_done and not rd:
        content.append(" • Idle\n", style="dim")
    elif res_done:
        for res in res_done[-8:]:
            content.append(f" [x] {res}\n", style="green")
        if len(res_done) > 8:
            content.append(f" ... +{len(res_done)-8} earlier\n", style="dim green")
    
    panel_title = f"P{p_id} ({get_race_name(p['race'])})"
    return Panel(content, title=panel_title, border_style=color)

def generate_layout():
    layout = Layout()
    # Give player panels ~70% height, graph ~25%, header+footer fixed
    layout.split_column(Layout(name="header", size=3), Layout(name="body"), Layout(name="history", size=25), Layout(name="footer", size=3))
    layout["body"].split_row(*[Layout(make_player_panel(i)) for i in [1, 2, 3]])
    titles = ["FLEET STRENGTH", "TOTAL RU ACCUMULATION", "MILITARY POWER", "AVAILABLE RUs", "SPENT RUs"]
    metrics = [
        ("p1_f", "p2_f", "p3_f"), 
        ("p1_ru", "p2_ru", "p3_ru"), 
        ("p1_p", "p2_p", "p3_p"),
        ("p1_avail", "p2_avail", "p3_avail"),
        ("p1_spent", "p2_spent", "p3_spent")
    ]
    m = metrics[data.current_graph]
    layout["history"].update(Panel(BrailleGraph(m, ["cyan", "red", "yellow"]), title=f"HISTORICAL: {titles[data.current_graph]}", subtitle="[bold white][1][/] FLEET [bold white][2][/] TOTAL RU [bold white][3][/] POWER [bold white][4][/] AVAIL [bold white][5][/] SPENT"))
    layout["header"].update(Panel(Text(f"FSFC TACTICAL SENSORS - {data.era}", justify="center", style="bold magenta"), border_style="magenta"))
    footer_text = Text.from_markup(f"Time: {data.game_time // 60}m {data.game_time % 60}s | Press [reverse bold red] Q [/] to exit tactical view")
    footer_text.justify = "center"
    layout["footer"].update(Panel(footer_text, border_style="dim"))
    return layout

def get_key():
    if select.select([sys.stdin], [], [], 0) == ([sys.stdin], [], []):
        return sys.stdin.read(1)
    return None

def main():
    if not os.path.exists(LOG_PATH):
        console.print(f"[bold red]Error:[/] Log file not found at {LOG_PATH}")
        return
    
    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    
    try:
        tty.setcbreak(fd)
        with open(LOG_PATH, "r", errors="ignore") as f:
            for line in f: parse_line(line)
        
        with open(LOG_PATH, "r", errors="ignore") as file:
            file.seek(0, 2)
            with Live(generate_layout(), refresh_per_second=4, screen=True) as live:
                while True:
                    key = get_key()
                    if key in ['1', '2', '3', '4', '5']:
                        data.current_graph = int(key) - 1
                        live.update(generate_layout())
                    elif key and key.lower() == 'q':
                        break

                    line = file.readline()
                    if not line:
                        time.sleep(0.05)
                        continue
                    parse_line(line)
                    live.update(generate_layout())
    except KeyboardInterrupt:
        pass # Graceful exit on Ctrl+C
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)
        console.clear()
        console.print("[bold magenta]FSFC Tactical Sensors Offline.[/]")

if __name__ == "__main__":
    main()
