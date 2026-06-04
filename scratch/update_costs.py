import os
import re

workspace = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source'

fighters = [
    'ter_loki', 'ter_apollo', 'ter_valkyrie', 'ter_hercules', 'ter_ulysses', 'ter_myrmidon', 'ter_perseus', 'ter_hercules_mk2', 'ter_ares', 'ter_erinyes', 'ter_pegasus',
    'vas_horus', 'vas_anubis', 'vas_seth', 'vas_thoth', 'vas_serapis', 'vas_tauret', 'vas_ptah',
    'shi_scorpion', 'shi_astaroth', 'shi_manticore', 'shi_dragon', 'shi_basilisk', 'shi_aeshma', 'shi_mara', 'shi_gorgon'
]

bombers = [
    'ter_athena', 'ter_zeus', 'ter_medusa', 'ter_ursa', 'ter_artemis', 'ter_artemisdh', 'ter_boanerges', 'ter_medusa_fs1', 'ter_ursa_fs1',
    'vas_osiris', 'vas_amun', 'vas_bakha', 'vas_sehkmet',
    'shi_shaitan', 'shi_nahema', 'shi_taurvi', 'shi_nephilim', 'shi_seraphim'
]

installations = ['ter_arcadia', 'vas_karnak']

# Update ship files
ship_dir = os.path.join(workspace, 'ship')
for root, dirs, files in os.walk(ship_dir):
    for file in files:
        if file.endswith('.ship'):
            ship_name = file.replace('.ship', '')
            filepath = os.path.join(root, file)
            
            with open(filepath, 'r') as f:
                content = f.read()
                
            old_cost_match = re.search(r'NewShipType\.buildCost\s*=\s*(\d+)', content)
            if not old_cost_match:
                continue
            
            old_cost = int(old_cost_match.group(1))
            new_cost = old_cost
            
            if ship_name in fighters:
                # Map [390, 1000] -> [390, 550]
                ratio = max(0, (old_cost - 390) / (1000 - 390))
                new_cost = int(390 + ratio * (550 - 390))
                if new_cost < 390: new_cost = 390
            elif ship_name in bombers:
                # Map [450, 1000] -> [550, 750]
                ratio = max(0, (old_cost - 450) / (1000 - 450))
                new_cost = int(550 + ratio * (750 - 550))
                if new_cost < 550: new_cost = 550
            elif ship_name in installations:
                new_cost = 4500
                
            if new_cost != old_cost:
                content = re.sub(r'(NewShipType\.buildCost\s*=\s*)\d+', f'\\g<1>{new_cost}', content)
                with open(filepath, 'w') as f:
                    f.write(content)
                print(f"Updated {ship_name}: {old_cost} -> {new_cost}")

