import os, re

md_path = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/resources/fsfc-knowledge/fsfc_ship_balance_sheet.md'
with open(md_path, 'r') as f:
    md_content = f.read()

workspace = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source'
races = {'ter': 'terran', 'vas': 'vasudan', 'shi': 'shivan'}

lua_prereqs = {}

for prefix, race in races.items():
    lua_prereqs[prefix] = {}
    
    # Read def_build
    bld_path = os.path.join(workspace, f'scripts/races/{race}/scripts/def_build.lua')
    if os.path.exists(bld_path):
        with open(bld_path, 'r') as f:
            bld_content = f.read()
            bld_blocks = re.findall(r'(\t*\{\s*Type\s*=\s*Ship,(?:.*?\n)*?\t*\})', bld_content)
            for b in bld_blocks:
                thing_m = re.search(r'ThingToBuild\s*=\s*"([^"]+)"', b)
                req_m = re.search(r'RequiredResearch\s*=\s*"([^"]*)"', b)
                if thing_m and req_m:
                    lua_prereqs[prefix][thing_m.group(1)] = req_m.group(1)
                    
    # Read def_research
    res_path = os.path.join(workspace, f'scripts/races/{race}/scripts/def_research.lua')
    if os.path.exists(res_path):
        with open(res_path, 'r') as f:
            res_content = f.read()
            blocks = re.findall(r'(\t\{\s*\n(?:.*?\n)*?\t\},)', res_content)
            for b in blocks:
                name_m = re.search(r'Name\s*=\s*"([^"]+)"', b)
                req_m = re.search(r'RequiredResearch\s*=\s*"([^"]*)"', b)
                if name_m and req_m:
                    lua_prereqs[prefix][name_m.group(1)] = req_m.group(1)

# Now iterate over MD and update
new_md_lines = []
current_race = None

for line in md_content.split('\n'):
    if 'TERRAN' in line: current_race = 'ter'
    elif 'VASUDAN' in line: current_race = 'vas'
    elif 'SHIVAN' in line: current_race = 'shi'
    
    match = re.match(r'(\|\s*\*\*T\d+\*\*\s*\|\s*\*\*([^*]+)\*\*\s*\|\s*(Univ|FS1|FS2)\s*\|\s*([^|]+)\|)\s*([^|]+)(\|\s*(\d+)\s*\|\s*(\d+)s\s*\|)', line)
    if match and current_race:
        prefix_part = match.group(1)
        node_name = match.group(2).strip()
        internal_name = node_name.replace(' ', '')
        ships_str = match.group(4).strip()
        old_prereq = match.group(5).strip()
        suffix_part = match.group(6)
        
        # Determine new prereq
        new_prereq = old_prereq
        ships = [s.strip() for s in ships_str.split(',')]
        found = False
        
        # Check if it unlocks a ship first
        for s in ships:
            s_match = re.search(r'(ter_|vas_|shi_)[a-z0-9_]+', s)
            if s_match:
                ship_id = s_match.group(0)
                if ship_id in lua_prereqs[current_race]:
                    new_prereq = lua_prereqs[current_race][ship_id]
                    found = True
                    break
        
        # If not found or not a ship, check research nodes
        if not found and internal_name in lua_prereqs[current_race]:
            new_prereq = lua_prereqs[current_race][internal_name]
            
        if not new_prereq: new_prereq = "-"
        
        new_line = f"{prefix_part} {new_prereq} {suffix_part}"
        new_md_lines.append(new_line)
    else:
        new_md_lines.append(line)
        
with open(md_path, 'w') as f:
    f.write('\n'.join(new_md_lines))
    
print("Markdown Prereqs synced with Lua files!")
