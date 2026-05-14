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
            1: {"race": "UNK", "fleet": 0, "rus": 0, "total_rus": 0, "threat_self": 0, "threat_enemy": 0, "target": -1, "research": "None", "res_history": [], "stance": "Dynamic", "demands": {}, "last_demand_time": 0, "classes": {}},
            2: {"race": "UNK", "fleet": 0, "rus": 0, "total_rus": 0, "threat_self": 0, "threat_enemy": 0, "target": -1, "research": "None", "res_history": [], "stance": "Dynamic", "demands": {}, "last_demand_time": 0, "classes": {}},
            3: {"race": "UNK", "fleet": 0, "rus": 0, "total_rus": 0, "threat_self": 0, "threat_enemy": 0, "target": -1, "research": "None", "res_history": [], "stance": "Dynamic", "demands": {}, "last_demand_time": 0, "classes": {}},
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
    
    if "WANT |" in line:
        m = re.search(r"P(\d) \| WANT \| (.+) \| Demand: ([\d\.]+)", line)
        if m:
            p_id = int(m.group(1))
            if p_id in data.players:
                p = data.players[p_id]
                # If this is a new timestamp for this player, clear previous demands
                if line_ts > p["last_demand_time"]:
                    p["demands"] = {}
                    p["last_demand_time"] = line_ts
                p["demands"][m.group(2)] = float(m.group(3))

    if "RESEARCH | Target:" in line:
        m = re.search(r"P(\d) \| RESEARCH \| Target: (.+)", line)
        if m:
            p_id = int(m.group(1))
            if p_id in data.players:
                res_name = m.group(2).strip()
                if "Tactics" in res_name:
                    data.players[p_id]["stance"] = res_name.replace("Tactics", "")
                else:
                    data.players[p_id]["research"] = res_name
                    # Only add to history if it's different from the last entry
                    hist = data.players[p_id]["res_history"]
                    if not hist or hist[-1] != res_name:
                        hist.append(res_name)
                        if len(hist) > 5:
                            hist.pop(0)
                
    if "----------------------------------" in line and data.game_time > 0:
        if not data.history or data.history[-1]["time"] != data.game_time:
            data.history.append({
                "time": data.game_time,
                "p1_f": data.players[1]["fleet"], "p2_f": data.players[2]["fleet"], "p3_f": data.players[3]["fleet"],
                "p1_ru": data.players[1]["total_rus"], "p2_ru": data.players[2]["total_rus"], "p3_ru": data.players[3]["total_rus"],
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
    # Condensed Header Stats
    content.append(f"F: {p['fleet']} | RU: {p['rus']:,} | Pwr: {p['threat_self']}\n", style="white")
    
    # Target and Stance line
    target_p = p['target']
    target_race = get_race_name(data.players[target_p]['race']) if target_p in data.players else "None"
    target_str = f"P{target_p} ({target_race})" if target_p != -1 else "None"
    
    content.append("Tgt: ", style="red")
    content.append(f"{target_str} ", style="bold red")
    content.append(f"({p['threat_enemy']}) ", style="red")
    content.append(f"| {p['stance']}\n", style="cyan")
    
    content.append("\nBUILD PRIORITIES:\n", style="bold yellow")
    
    # Demand Reflection (Multi-Want List)
    demands = p['demands']
    if not demands:
        content.append(" • Idle (Ready for orders)\n", style="italic dim yellow")
    else:
        # Show top 3 demands to prevent vertical overflow
        count = 0
        for name, val in demands.items():
            if count >= 3:
                content.append(f" • ... and {len(demands)-3} more\n", style="dim yellow")
                break
            # Truncate long names to fit panel width
            display_name = name[:18] + ".." if len(name) > 20 else name
            content.append(f" • {display_name} ({val:.1f})\n", style="italic yellow")
            count += 1
    
    # Tech Reflection (History Chain)
    res_hist = p['res_history']
    content.append("\nTech: ", style="bold white")
    if not res_hist:
        content.append("None", style="dim")
    else:
        parts = [f"[bold cyan]{h[:8]}[/]" for h in res_hist]
        content.append(Text.from_markup(" ➔ ".join(parts)))
    
    panel_title = f"P{p_id} ({get_race_name(p['race'])})"
    return Panel(content, title=panel_title, border_style=color)

def generate_layout():
    layout = Layout()
    layout.split_column(Layout(name="header", size=3), Layout(name="body", size=13), Layout(name="history"), Layout(name="footer", size=3))
    layout["body"].split_row(*[Layout(make_player_panel(i)) for i in [1, 2, 3]])
    titles = ["FLEET STRENGTH", "TOTAL RU ACCUMULATION", "MILITARY POWER"]
    metrics = [("p1_f", "p2_f", "p3_f"), ("p1_ru", "p2_ru", "p3_ru"), ("p1_p", "p2_p", "p3_p")]
    m = metrics[data.current_graph]
    layout["history"].update(Panel(BrailleGraph(m, ["cyan", "red", "yellow"]), title=f"HISTORICAL: {titles[data.current_graph]}", subtitle="[bold white][1][/] FLEET  [bold white][2][/] RUs  [bold white][3][/] POWER"))
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
                    if key in ['1', '2', '3']:
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
