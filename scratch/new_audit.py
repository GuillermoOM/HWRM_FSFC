import os, re

md_path = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/resources/fsfc-knowledge/fsfc_ship_balance_sheet.md'
with open(md_path, 'r') as f:
    md = f.read()

nodes_md = {'ter': {}, 'vas': {}, 'shi': {}}
current_race = None

for line in md.split('\n'):
    if 'TERRAN' in line: current_race = 'ter'
    elif 'VASUDAN' in line: current_race = 'vas'
    elif 'SHIVAN' in line: current_race = 'shi'
    
    match = re.match(r'\|\s*\*\*T\d+\*\*\s*\|\s*\*\*([^*]+)\*\*\s*\|\s*(Univ|FS1|FS2)\s*\|\s*([^|]+)\|\s*([^|]+)\|\s*(\d+)\s*\|\s*(\d+)s', line)
    if match and current_race:
        node_name = match.group(1).strip()
        internal_name = node_name.replace(' ', '')
        era = match.group(2).strip()
        ships = match.group(3).strip()
        prereq = match.group(4).strip()
        cost = int(match.group(5).strip())
        time = int(match.group(6).strip())
        if prereq == '-': prereq = ''
        
        nodes_md[current_race][internal_name] = {
            'display': node_name, 'cost': cost, 'time': time, 'prereq': prereq, 'era': era, 'ships': ships
        }

workspace = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source'
races = {'ter': 'terran', 'vas': 'vasudan', 'shi': 'shivan'}

print("=== AUDIT RESULTS ===")
for prefix, race in races.items():
    print(f"\n--- {race.upper()} ---")
    res_path = os.path.join(workspace, f'scripts/races/{race}/scripts/def_research.lua')
    if not os.path.exists(res_path): continue
    
    with open(res_path, 'r') as f: res_content = f.read()
    
    # Check research nodes in lua vs md
    blocks = re.findall(r'(\t\{\s*\n(?:.*?\n)*?\t\},)', res_content)
    lua_nodes = {}
    for b in blocks:
        name_m = re.search(r'Name\s*=\s*"([^"]+)"', b)
        if name_m:
            req_m = re.search(r'RequiredResearch\s*=\s*"([^"]*)"', b)
            cost_m = re.search(r'Cost\s*=\s*(\d+)', b)
            time_m = re.search(r'Time\s*=\s*(\d+)', b)
            name = name_m.group(1)
            # Skip global non-ship nodes like FS1, FS2, etc if not in MD, but let's check what's in MD.
            if name in nodes_md[prefix]:
                lua_nodes[name] = {
                    'prereq': req_m.group(1) if req_m else "",
                    'cost': int(cost_m.group(1)) if cost_m else 0,
                    'time': int(time_m.group(1)) if time_m else 0
                }
    
    for n_name, n_data in nodes_md[prefix].items():
        if n_name not in lua_nodes:
            print(f"MISSING in def_research.lua: {n_name}")
        else:
            ln = lua_nodes[n_name]
            if ln['prereq'] != n_data['prereq']: print(f"MISMATCH def_research Prereq for {n_name}: MD='{n_data['prereq']}', LUA='{ln['prereq']}'")
            if ln['cost'] != n_data['cost']: print(f"MISMATCH def_research Cost for {n_name}: MD={n_data['cost']}, LUA={ln['cost']}")
            if ln['time'] != n_data['time']: print(f"MISMATCH def_research Time for {n_name}: MD={n_data['time']}, LUA={ln['time']}")
            
    # Check build file
    bld_path = os.path.join(workspace, f'scripts/races/{race}/scripts/def_build.lua')
    with open(bld_path, 'r') as f: bld_content = f.read()
    bld_blocks = re.findall(r'(\t*\{\s*Type\s*=\s*Ship,(?:.*?\n)*?\t*\})', bld_content)
    bld_ships = {}
    for b in bld_blocks:
        thing_m = re.search(r'ThingToBuild\s*=\s*"([^"]+)"', b)
        req_m = re.search(r'RequiredResearch\s*=\s*"([^"]*)"', b)
        if thing_m: bld_ships[thing_m.group(1)] = req_m.group(1) if req_m else ""
        
    for n_name, n_data in nodes_md[prefix].items():
        ships = [s.strip() for s in n_data['ships'].split(',')]
        for s in ships:
            s_match = re.search(r'(ter_|vas_|shi_)[a-z0-9_]+', s)
            if s_match:
                ship_id = s_match.group(0)
                expected_req = n_name
                if n_data['era'] == 'Univ':
                    if 'FS1' in s: expected_req += " & FS1"
                    elif 'FS2' in s: expected_req += " & FS2"
                else:
                    expected_req += f" & {n_data['era']}"
                    
                if ship_id in bld_ships:
                    if bld_ships[ship_id] != expected_req:
                        print(f"MISMATCH def_build Prereq for {ship_id}: MD='{expected_req}', LUA='{bld_ships[ship_id]}'")
                else:
                    pass # Ship might not be implemented yet
                    
    # Check AI logic
    upg_path = os.path.join(workspace, f'scripts/races/{race}/scripts/ai_upgrades.lua')
    ai_bld_path = os.path.join(workspace, f'scripts/races/{race}/scripts/ai_build.lua')
    with open(upg_path, 'r') as f: upg = f.read()
    with open(ai_bld_path, 'r') as f: aibld = f.read()
    
    # Get all known nodes
    all_known_nodes = set(lua_nodes.keys())
    # Add non-ship nodes that are typically valid
    for b in blocks:
        name_m = re.search(r'Name\s*=\s*"([^"]+)"', b)
        if name_m: all_known_nodes.add(name_m.group(1))
        
    upg_names = set(re.findall(r'name\s*=\s*"([^"]+)"', upg))
    bld_names = set(re.findall(r'FSFC_IsResearchDone\("([^"]+)"\)', aibld))
    
    for n in upg_names:
        if n not in all_known_nodes: print(f"UNKNOWN in ai_upgrades.lua: {n}")
    for n in bld_names:
        if n not in all_known_nodes: print(f"UNKNOWN in ai_build.lua: {n}")

print("=== AUDIT COMPLETE ===")
