import os
import re

SHIP_DIR = "source/ship/"

def fix_ship_families(path):
    with open(path, 'r') as f:
        content = f.read()

    # Find the display family to determine the class
    display_match = re.search(r"DisplayFamily\s*=\s*['\"]([^']+)['\"]", content)
    if not display_match:
        return False
    
    display_family = display_match.group(1)
    
    # Defaults
    avoidance = None
    collision = "Big"
    min_path = "MotherShip"
    
    if display_family in ["Fighter", "Bomber", "Corvette"]:
        avoidance = "Strikecraft"
        collision = "Small"
        min_path = "SuperCap"
    elif display_family in ["Frigate", "Cruiser"]:
        avoidance = "Capital"
        collision = "Big"
        min_path = "MotherShip"
    elif display_family == "Capital":
        avoidance = "SuperCap"
        collision = "Big"
        min_path = "MotherShip"
    elif display_family == "Flagship":
        avoidance = "MotherShip"
        collision = "Big"
        min_path = "MotherShip"
    elif display_family == "Utility":
        avoidance = "Utility"
        collision = "Big"
        min_path = "MotherShip"

    if avoidance:
        # Apply changes
        content = re.sub(r"AvoidanceFamily\s*=\s*['\"][^']*['\"]", f"AvoidanceFamily = '{avoidance}'", content)
        content = re.sub(r"CollisionFamily\s*=\s*['\"][^']*['\"]", f"CollisionFamily = '{collision}'", content)
        content = re.sub(r"MinimalFamilyToFindPathAround\s*=\s*['\"][^']*['\"]", f"MinimalFamilyToFindPathAround = '{min_path}'", content)
        
        with open(path, 'w') as f:
            f.write(content)
        return True
    return False

if __name__ == "__main__":
    count = 0
    for root, dirs, files in os.walk(SHIP_DIR):
        for file in files:
            if file.endswith(".ship"):
                if fix_ship_families(os.path.join(root, file)):
                    count += 1
    print(f"Fixed families for {count} ships.")
