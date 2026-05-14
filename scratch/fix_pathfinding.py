import os
import re

SHIP_DIR = 'source/ship'

# Mapping of ship types to their target pathfinding family
# Fighters/Utility should avoid everything from Capital up
# Cruisers (Frigate-sized) should avoid SuperCap up
# Destroyers should avoid other SuperCaps
PATHING_MAP = {
    'Scout': 'Capital',
    'Fighter': 'Capital',
    'Bomber': 'Capital',
    'Utility': 'Capital',
    'Resource': 'Capital',
    'Cruiser': 'SuperCap',
    'Frigate': 'SuperCap',
    'Destroyer': 'SuperCap',
    'Carrier': 'SuperCap',
    'Juggernaut': 'MotherShip'
}

def update_ship_file(file_path):
    with open(file_path, 'r') as f:
        content = f.read()

    # Determine ship class
    ship_class = None
    sob_match = re.search(r"NewShipType\.sobDescription = '(.*?)'", content)
    if sob_match:
        ship_class = sob_match.group(1)
    
    if not ship_class:
        # Try AttackFamily as fallback
        attack_match = re.search(r"NewShipType\.AttackFamily = '(.*?)'", content)
        if attack_match:
            ship_class = attack_match.group(1)

    if not ship_class:
        return

    target_family = None
    for key, value in PATHING_MAP.items():
        if key.lower() in ship_class.lower():
            target_family = value
            break
    
    if not target_family:
        return

    print(f"Updating {os.path.basename(file_path)} (Class: {ship_class}) -> PathAround: {target_family}")

    # Update MinimalFamilyToFindPathAround
    new_content = re.sub(
        r"NewShipType\.MinimalFamilyToFindPathAround = '.*?'",
        f"NewShipType.MinimalFamilyToFindPathAround = '{target_family}'",
        content
    )

    # For Utility ships, also ensure CollisionFamily = 'Small'
    if 'Utility' in ship_class or 'Resource' in ship_class:
        new_content = re.sub(
            r"NewShipType\.CollisionFamily = '.*?'",
            "NewShipType.CollisionFamily = 'Small'",
            new_content
        )

    if new_content != content:
        with open(file_path, 'w') as f:
            f.write(new_content)

def main():
    for root, dirs, files in os.walk(SHIP_DIR):
        for file in files:
            if file.endswith('.ship'):
                update_ship_file(os.path.join(root, file))

if __name__ == '__main__':
    main()
