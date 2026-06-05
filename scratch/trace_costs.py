import re

md_path = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/resources/fsfc-knowledge/fsfc_ship_balance_sheet.md'
with open(md_path, 'r') as f:
    lines = f.read().split('\n')

# Store nodes by race: {race: {node_name: {'cost': cost, 'prereqs': [list_of_prereqs]}}}
trees = {'Terran': {}, 'Vasudan': {}, 'Shivan': {}}

current_race = None

for line in lines:
    if 'TERRAN' in line: current_race = 'Terran'
    elif 'VASUDAN' in line: current_race = 'Vasudan'
    elif 'SHIVAN' in line: current_race = 'Shivan'
    
    # Safe splitting by ignoring escaped pipes `\|`
    safe_line = line.replace('\\|', '@@PIPE@@')
    if re.match(r'\|\s*\*\*T\d+\*\*', line):
        parts = [p.strip() for p in safe_line.split('|')]
        if len(parts) >= 8 and current_race:
            node_name = parts[2].replace('*', '').replace(' ', '')
            prereq_str = parts[5].replace('@@PIPE@@', '|').strip()
            try:
                res_cost = int(parts[6])
            except ValueError:
                continue
                
            # Parse prereqs
            # format: "NodeA & NodeB | NodeC"
            # We just want to extract all distinct node names it depends on. 
            # In HWRM logic, A & B means both. If there's an OR, we assume the cheapest path or just list it.
            # But the tech tree usually requires the main branch node. 
            # E.g., "CorvetteDesign & FS1" -> we only care about CorvetteDesign.
            
            # Remove parentheses and split by '&' or '|'
            clean_p = prereq_str.replace('(', '').replace(')', '')
            raw_prereqs = [x.strip() for x in re.split(r'[&|]', clean_p)]
            
            # Filter out Univ, FS1, FS2, None
            filtered_prereqs = [x.replace(' ', '') for x in raw_prereqs if x not in ['Univ', 'FS1', 'FS2', 'None', '', '-']]
            
            trees[current_race][node_name] = {
                'cost': res_cost,
                'prereqs': filtered_prereqs,
                'raw_name': parts[2].replace('*', '').strip()
            }

def get_cumulative_cost(race, node_id, visited=None):
    if visited is None: visited = set()
    if node_id in visited: return 0, [] # prevent loops
    visited.add(node_id)
    
    if node_id not in trees[race]:
        # Might be a typo in prereq name, try to find case-insensitive
        for k in trees[race].keys():
            if k.lower() == node_id.lower():
                node_id = k
                break
        else:
            return 0, []
            
    cost = trees[race][node_id]['cost']
    path = [trees[race][node_id]['raw_name']]
    
    # For simplicity, if a node has multiple prereqs, we add them all (assuming AND). 
    # If it's an OR path, this might overestimate, but usually the tree is linear.
    for p in trees[race][node_id]['prereqs']:
        p_cost, p_path = get_cumulative_cost(race, p, visited.copy())
        cost += p_cost
        # Add path elements not already in path
        for pp in p_path:
            if pp not in path:
                path.append(pp)
                
    return cost, path

# Targets for each race
targets = {
    'Terran': ['CapitalShipDesign', 'SuperCapitalShipDesign', 'Juggernaut'],
    'Vasudan': ['CapitalShipDesign', 'Hatshepsut', 'Juggernaut'],
    'Shivan': ['CapitalShipDesign', 'SuperCapitalShipDesign', 'Juggernaut']
}

print("# Cumulative Research Costs to Capital Tiers\n")
for race in ['Terran', 'Vasudan', 'Shivan']:
    print(f"### {race.upper()}")
    for t in targets[race]:
        # Some nodes might be named slightly differently
        target_id = t
        if t == 'SuperCapitalShipDesign' and race == 'Vasudan':
            target_id = 'Hatshepsut' # Because we deleted SuperCapitalShipDesign
        
        cost, path = get_cumulative_cost(race, target_id)
        
        # Reverse path for chronological order
        path.reverse()
        path_str = " -> ".join(path)
        
        print(f"**Target: {t}**")
        print(f"- **Cumulative Cost:** {cost:,} RU")
        print(f"- **Path:** {path_str}\n")

