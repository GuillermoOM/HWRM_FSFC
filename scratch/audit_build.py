import os
import re

md_path = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/resources/fsfc-knowledge/fsfc_ship_balance_sheet.md'
with open(md_path, 'r') as f:
    md = f.read()

# Map ships to their expected research
expected = {}

# Node name exceptions per race
exceptions = {
    'vas': {'Juggernaut': 'Colossus'},
    'shi': {'Super Capital Ship Design': 'Lucifer', 'Juggernaut': 'Sathanas'}
}

current_race = None
for line in md.split('\n'):
    if 'TERRAN' in line: current_race = 'ter'
    elif 'VASUDAN' in line: current_race = 'vas'
    elif 'SHIVAN' in line: current_race = 'shi'
    
    match = re.match(r'\|\s*\*\*T\d+\*\*\s*\|\s*\*\*([^*]+)\*\*\s*\|\s*(Univ|FS1|FS2)\s*\|\s*([^|]+)\|', line)
    if match and current_race:
        node = match.group(1).strip()
        era = match.group(2).strip()
        ships_str = match.group(3).strip()
        
        # Resolve internal node name
        internal_node = node.replace(' ', '')
        if current_race in exceptions and node in exceptions[current_race]:
            internal_node = exceptions[current_race][node]
            
        ships = ships_str.split(',')
        for s in ships:
            s_match = re.search(r'(ter_|vas_|shi_)[a-z0-9_]+', s)
            if s_match:
                ship_id = s_match.group(0)
                
                req = internal_node
                if '(FS1)' in s and era == 'Univ': req += " & FS1"
                elif '(FS2)' in s and era == 'Univ': req += " & FS2"
                
                # Special cases where the node is missing in table or just hardcoded
                expected[ship_id] = req

# Now parse def_build.lua
workspace = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source'
races = {'ter': 'terran', 'vas': 'vasudan', 'shi': 'shivan'}

mismatches = []

for prefix, race in races.items():
    build_path = os.path.join(workspace, f'scripts/races/{race}/scripts/def_build.lua')
    if not os.path.exists(build_path): continue
    
    with open(build_path, 'r') as f:
        content = f.read()
        
    blocks = re.findall(r'{(.*?)}', content, re.DOTALL)
    for block in blocks:
        thing_match = re.search(r'ThingToBuild\s*=\s*"([^"]+)"', block)
        req_match = re.search(r'RequiredResearch\s*=\s*"([^"]*)"', block)
        
        if thing_match and req_match:
            ship_id = thing_match.group(1)
            actual_req = req_match.group(1)
            
            if ship_id in expected:
                if expected[ship_id] != actual_req:
                    # Ignore 'awacs_1' logic for now
                    if 'awacs' not in ship_id:
                        mismatches.append(f"{ship_id}: Expected '{expected[ship_id]}', but found '{actual_req}'")

for m in mismatches:
    print(m)
if not mismatches:
    print("Audit perfectly clean!")
