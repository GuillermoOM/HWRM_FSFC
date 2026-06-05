import re

dels = {
    'terran': ['Zeus', 'AdvancedCruiser'],
    'vasudan': ['Anubis', 'Bakha'],
    'shivan': ['Astaroth', 'Cain', 'Nahema', 'Shaitan']
}

for race, nodes in dels.items():
    path = f'source/scripts/races/{race}/scripts/ai_upgrades.lua'
    with open(path, 'r') as f: lines = f.read().split('\n')
    
    new_lines = []
    for line in lines:
        keep = True
        for n in nodes:
            if f'name = "{n}"' in line:
                keep = False
                break
        if keep: new_lines.append(line)
        
    with open(path, 'w') as f: f.write('\n'.join(new_lines))

print("Pruned obsolete nodes from AI scripts.")
