import sys
import re

def analyze_log(log_path):
    print(f"--- FSFC Match Analysis Report: {log_path} ---")
    
    player_stats = {}
    ai_demands = {}
    
    with open(log_path, 'r', errors='ignore') as f:
        for line in f:
            # Match Settings
            match = re.search(r'\[DIAG\] (Era Setting|Resources|Unit Caps): (.*)', line)
            if match:
                print(f"Setting Found: {match.group(1)} = {match.group(2)}")

            # Combat Telemetry
            match = re.search(r'\[DIAG\] P(\d+) \((.*?)\) \| Fleet: (\d+) \| RUs: (\d+) \| TotalRUs: (\d+)', line)
            if match:
                pid, race, squads, rus, total_rus = match.groups()
                if pid not in player_stats: player_stats[pid] = {"race": race, "history": []}
                player_stats[pid]["history"].append({"squads": int(squads), "rus": int(rus), "total_rus": int(total_rus)})
            
            # Detailed Ship Counts
            match = re.search(r'\[DIAG\] P(\d+) SHIPS \| (.*)', line)
            if match:
                pid, ships_str = match.groups()
                if pid not in player_stats: player_stats[pid] = {"race": "UNK", "history": []} # Fallback
                if "ship_counts" not in player_stats[pid]: player_stats[pid]["ship_counts"] = {}
                
                for entry in ships_str.strip().split():
                    if ":" in entry:
                        s_name, s_count = entry.split(":")
                        player_stats[pid]["ship_counts"][s_name] = int(s_count)
            
            # AI Demands & Research
            match = re.search(r'\[AI_DIAG\] P(\d+) \| (RESEARCH|WANT) \| (?:Target: )?(.*?)(?: \| Demand: ([\d\.]+))?$', line)
            if match:
                pid, action, item, demand = match.groups()
                key = f"P{pid}_{action}_{item.strip()}"
                ai_demands[key] = ai_demands.get(key, 0) + 1
    
    print("\n[ECONOMY & FLEET SUMMARY]")
    for pid, data in player_stats.items():
        history = data.get("history", [])
        if not history: continue
        last = history[-1]
        peak_fleet = max(h['squads'] for h in history)
        print(f"Player {pid} ({data['race']}): Current Fleet: {last['squads']} | Total Collected RUs: {last.get('total_rus', 0)} | Peak Fleet Size: {peak_fleet}")
        
        # Display top ships if available
        if "ship_counts" in data:
            top_ships = sorted(data["ship_counts"].items(), key=lambda x: x[1], reverse=True)[:5]
            ship_summary = ", ".join([f"{n}: {c}" for n, c in top_ships])
            print(f"  - Top Units: {ship_summary}")
    
    print("\n[AI PRIORITY ANALYSIS (High Demand/Research Events)]")
    sorted_demands = sorted(ai_demands.items(), key=lambda x: x[1], reverse=True)
    for key, count in sorted_demands[:15]:
        print(f"{key}: AI triggered this {count} times.")

    print("\n--- End of Report ---")

if __name__ == "__main__":
    if len(sys.argv) > 1:
        analyze_log(sys.argv[1])
    else:
        print("Usage: python3 analyze_match.py <path_to_HwRM.log>")
