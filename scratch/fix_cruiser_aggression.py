import os
import re

ships_to_fix = [
    "vas_aten",
    "vas_mentu",
    "shi_cain",
    "shi_lilith",
    "ter_leviathan",
    "ter_aeolus",
    "shi_rakshasa",
    "vas_sobek",
    "ter_deimos" # Adding Deimos too as it's a "Corvette" class cruiser
]

base_dir = "/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/ship/"

for ship in ships_to_fix:
    ship_file = os.path.join(base_dir, f"{ship}/{ship}.ship")
    if not os.path.exists(ship_file):
        print(f"File not found: {ship_file}")
        continue
    
    with open(ship_file, 'r') as f:
        content = f.read()
    
    # Target the CanAttack ability line
    # Example: addAbility(NewShipType, 'CanAttack', 1, 1, 0, 1, 0.35, 1.5, '...', 'MoveToTargetAndShoot', ...)
    
    # Regex to find the CanAttack ability and replace the default attack style (9th parameter after 'CanAttack')
    # Note: addAbility(NewShipType, 'CanAttack', p1, p2, p3, p4, p5, p6, 'Families', 'Style', ...)
    
    pattern = r"(addAbility\(NewShipType,\s*'CanAttack',[^']*'[^']*',\s*)'[^']*'(\s*,)"
    
    new_content = re.sub(pattern, r"\1'frontal_frigate'\2", content)
    
    if new_content != content:
        with open(ship_file, 'w') as f:
            f.write(new_content)
        print(f"Updated {ship_file}")
    else:
        print(f"No changes needed for {ship_file} or pattern not matched.")
