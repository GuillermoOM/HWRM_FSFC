import os
import re

workspace = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source'

def update_research_file(filepath, race):
    with open(filepath, 'r') as f:
        content = f.read()
        
    updates = {
        'CruiserDesign': {'Cost': 4000, 'Time': 120},
        'CapitalShipDesign': {'Cost': 8000, 'Time': 150},
        'SuperDestroyer': {'Cost': 8000, 'Time': 180},
        'SuperCapitalShipDesign': {'Cost': 8000, 'Time': 180},
        'Juggernaut': {'Cost': 12000, 'Time': 240}
    }
    
    if race == 'vasudan':
        updates['Juggernaut']['Cost'] = 20000
        
    # Split content by nodes
    nodes = re.split(r'(\t*\{\s*Name\s*=\s*"[^"]+",)', content)
    
    new_content = ""
    if len(nodes) > 0:
        new_content += nodes[0]
        
    for i in range(1, len(nodes), 2):
        header = nodes[i]
        body = nodes[i+1]
        
        name_match = re.search(r'Name\s*=\s*"([^"]+)"', header)
        if name_match:
            name = name_match.group(1)
            if name in updates:
                new_cost = updates[name]['Cost']
                new_time = updates[name]['Time']
                
                # Update Cost
                body = re.sub(r'Cost\s*=\s*\d+', f'Cost = {new_cost}', body)
                # Update Time
                body = re.sub(r'Time\s*=\s*\d+', f'Time = {new_time}', body)
                # Update DisplayedName
                body = re.sub(r'(DisplayedName\s*=\s*"[^"]+?)\(\d+s\)', f'\\g<1>({new_time}s)', body)
                
        new_content += header + body
        
    with open(filepath, 'w') as f:
        f.write(new_content)
    print(f"Updated {filepath}")

for race in ['terran', 'vasudan', 'shivan']:
    path = os.path.join(workspace, f'scripts/races/{race}/scripts/def_research.lua')
    if os.path.exists(path):
        update_research_file(path, race)

