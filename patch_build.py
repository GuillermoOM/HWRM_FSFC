import os
import re

md_path = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/resources/fsfc-knowledge/fsfc_ship_balance_sheet.md'
with open(md_path, 'r') as f:
    md = f.read()

expected = {}
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
        
        internal_node = node.replace(' ', '')
        if current_race in exceptions and node in exceptions[current_race]:
            internal_node = exceptions[current_race][node]
            
        ships = ships_str.split(',')
        for s in ships:
            s_match = re.search(r'(ter_|vas_|shi_)[a-z0-9_]+', s)
            if s_match:
                ship_id = s_match.group(0)
                req = internal_node
                
                # If Univ, we check if the ship has a specific era lock
                if era == 'Univ':
                    if 'FS1' in s: req += " & FS1"
                    elif 'FS2' in s: req += " & FS2"
                # If node is already FS1 or FS2, we don't strictly need to append it, but HWRM usually does
                else:
                    req += f" & {era}"
                
                expected[ship_id] = req

workspace = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source'
races = {'ter': 'terran', 'vas': 'vasudan', 'shi': 'shivan'}

for prefix, race in races.items():
    build_path = os.path.join(workspace, f'scripts/races/{race}/scripts/def_build.lua')
    if not os.path.exists(build_path): continue
    
    with open(build_path, 'r') as f:
        content = f.read()
        
    blocks = re.split(r'(\t*\{\s*Type\s*=\s*Ship,)', content)
    
    new_content = ""
    if len(blocks) > 0:
        new_content += blocks[0]
        
    for i in range(1, len(blocks), 2):
        header = blocks[i]
        body = blocks[i+1]
        
        thing_match = re.search(r'ThingToBuild\s*=\s*"([^"]+)"', body)
        if thing_match:
            ship_id = thing_match.group(1)
            
            if ship_id in expected:
                req = expected[ship_id]
                # Replace the RequiredResearch line
                body = re.sub(r'RequiredResearch\s*=\s*"[^"]*"', f'RequiredResearch = "{req}"', body)
                
        new_content += header + body
        
    with open(build_path, 'w') as f:
        f.write(new_content)

print("def_build.lua files patched successfully!")
