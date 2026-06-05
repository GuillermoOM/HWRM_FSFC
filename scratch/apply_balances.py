import re

md_path = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/resources/fsfc-knowledge/fsfc_ship_balance_sheet.md'
with open(md_path, 'r') as f:
    lines = f.read().split('\n')

def get_ship_stats(name, fam):
    n = name.lower()
    f = fam.lower()
    
    # Utility / Platforms
    if 'awacs' in f or 'utility' in f or 'charybdis' in n or 'faustus' in n or 'setekh' in n or 'satis' in n or 'asmodeus' in n or 'comm node' in n or 'repair' in n:
        return 1000, 50
    if 'sentry' in n or 'platform' in f or 'mjolnir' in n or 'alastor' in n or 'poseidon' in n or 'belial' in n or 'mephisto' in n or 'edjo' in n or 'nephthys' in n:
        return 500, 20
    
    # Juggernaut
    if 'juggernaut' in f or 'colossus' in n or 'sathanas' in n:
        return 15000, 300
    
    # Super Destroyer
    if 'lucifer' in n or 'super' in n or 'hades' in n or 'hatshepsut' in n:
        return 8000, 240
    
    # Destroyer
    if 'destroyer' in n or 'orion' in n or 'typhon' in n or 'demon' in n or 'hecate' in n:
        return 5000, 180
    
    # Installation
    if 'installation' in n or 'arcadia' in n or 'karnak' in n:
        return 5000, 180
    
    # Corvette
    if 'corvette' in f or 'deimos' in n or 'sobek' in n or 'moloch' in n or 'ravana' in n or 'iceni' in n:
        if 'ravana' in n: return 3000, 140
        if 'iceni' in n: return 2000, 100
        return 2500, 120
    
    # Cruiser
    if 'cruiser' in f or 'fenris' in n or 'leviathan' in n or 'aeolus' in n or 'aten' in n or 'mentu' in n or 'cain' in n or 'lilith' in n or 'rakshasa' in n:
        if 'leviathan' in n or 'mentu' in n or 'lilith' in n or 'rakshasa' in n or 'aeolus' in n:
            return 1500, 80
        return 1000, 60
    
    # Bomber
    if 'bomber' in f or 'ursa' in n or 'boanerges' in n or 'artemis' in n or 'medusa' in n or 'athena' in n or 'sehkmet' in n or 'osiris' in n or 'amun' in n or 'nephilim' in n or 'seraphim' in n or 'taurvi' in n or 'shaitan' in n or 'nahema' in n:
        if 'ursa' in n or 'boanerges' in n or 'sehkmet' in n or 'seraphim' in n:
            return 800, 60
        return 650, 50
    
    # Fighter (Default)
    if 'ares' in n or 'erinyes' in n or 'tauret' in n or 'mara' in n or 'dragon' in n:
        return 550, 45
    if 'loki' in n or 'pegasus' in n or 'ptah' in n:
        return 300, 30
        
    return 450, 40

ship_costs = {}
ship_times = {}

new_lines = []
in_ship_table = False

for line in lines:
    # Check if we're in the Ship Table
    if re.match(r'\|\s*[GgSs][a-zA-Z\s.-]+\s*\|\s*\d+', line):
        parts = [p.strip() for p in line.split('|')]
        if len(parts) > 5:
            name = parts[1]
            fam = parts[3]
            if len(parts) > 13: # The big table
                cost_col = 4
                time_col = 5
            else: # Fallback
                cost_col = 4
                time_col = 5
            
            c, t = get_ship_stats(name, fam)
            
            # Map internal ship ID
            # very rough heuristic to map display name to ID
            internal_id = "ter_" + name.replace("GTF ", "").replace("GTB ", "").replace("GTC ", "").replace("GTCv ", "").replace("GTD ", "").replace("GTI ", "").replace("GTSG ", "").replace("GTFr ", "").replace("GTT ", "").replace("GTS ", "").replace("GTNB ", "").replace("GTVA ", "").replace(" ", "").replace(".", "").lower()
            if name.startswith('GV'): internal_id = "vas_" + name.replace("GVF ", "").replace("GVB ", "").replace("GVC ", "").replace("GVCv ", "").replace("GVD ", "").replace("GVFr ", "").replace("GVSG ", "").replace("GVS ", "").replace("GVA ", "").replace("GVG ", "").replace(" ", "").replace(".", "").lower()
            if name.startswith('S') and not name.startswith('SSG') and not name.startswith('Shivan'): internal_id = "shi_" + name.replace("SF ", "").replace("SB ", "").replace("SC ", "").replace("SCv ", "").replace("SD ", "").replace("SJ ", "").replace("SFr ", "").replace("SG ", "").replace("ST ", "").replace(" ", "").replace(".", "").lower()
            if 'Shivan Comm Node' in name: internal_id = 'shi_commnode'
            if 'SSG' in name: internal_id = 'shi_' + name.replace("SSG ", "").lower()
            if 'Hercules Mk. II' in name: internal_id = 'ter_herculesmk2'
            if 'Artemis D.H.' in name: internal_id = 'ter_artemisdh'
            
            ship_costs[internal_id] = c
            ship_times[internal_id] = t
            
            # Reconstruct line
            parts[cost_col] = str(c)
            parts[time_col] = f"{t}s"
            new_lines.append("|" + "|".join(parts[1:-1]) + "|")
        else:
            new_lines.append(line)
    else:
        new_lines.append(line)

# Now pass 2: Research Tree!
final_lines = []
for line in new_lines:
    match = re.match(r'(\|\s*\*\*T\d+\*\*\s*\|\s*\*\*([^*]+)\*\*\s*\|\s*(Univ|FS1|FS2)\s*\|\s*([^|]+)\|\s*([^|]+)\|)\s*([^|]+)(\|\s*([^|]+)\s*\|)', line)
    if match:
        prefix = match.group(1)
        node_name = match.group(2)
        ships_str = match.group(4).strip()
        
        # Calculate max cost and max time
        max_c = 0
        max_t = 0
        ships = [s.strip() for s in ships_str.split(',')]
        for s in ships:
            s_match = re.search(r'(ter_|vas_|shi_)[a-z0-9_]+', s)
            if s_match:
                sid = s_match.group(0)
                if sid in ship_costs:
                    if ship_costs[sid] > max_c: max_c = ship_costs[sid]
                    if ship_times[sid] > max_t: max_t = ship_times[sid]
        
        if max_c == 0:
            if 'Armor' in node_name or 'Sprint' in node_name:
                # 150% of 1000 = 1500
                res_cost = 1500
                res_time = 50
            elif 'LVL' in node_name:
                res_cost = 1500
                res_time = 50
            else:
                res_cost = 1500
                res_time = 50
        else:
            res_cost = int(max_c * 1.5)
            res_time = int(max_t * 1.0) # 100% of ship time
            
        final_lines.append(f"{prefix} {res_cost} | {res_time}s |")
    else:
        final_lines.append(line)

with open(md_path, 'w') as f:
    f.write('\n'.join(final_lines))

print("Applied balancing pass to Markdown!")
