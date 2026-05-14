import os
import re

# Valid families from FamilyList.lua (Avoidance list is the most restrictive)
VALID_AVOIDANCE = ["None", "DontAvoid", "Strikecraft", "Utility", "Frigate", "SmallRock", "Capital", "SuperCap", "BattleCruiser", "MotherShip", "BigRock", "SuperPriority"]
VALID_ATTACK = ["Fighter", "Fighter_hw1", "Corvette", "Corvette_hw1", "Frigate", "Utility", "Munition", "SmallCapitalShip", "BigCapitalShip", "Mothership", "Emplacement", "SubSystem", "Resource", "ResourceLarge", "Capturer"]
VALID_DISPLAY = ["Fighter", "Bomber", "Corvette", "Frigate", "Cruiser", "Capital", "Flagship", "Platform", "Utility", "Resource", "NonCombat", "Munition"]

SHIP_DIR = "source/ship/"

def audit_ships():
    issues = []
    for root, dirs, files in os.walk(SHIP_DIR):
        for file in files:
            if file.endswith(".ship"):
                path = os.path.join(root, file)
                with open(path, 'r') as f:
                    content = f.read()
                    
                    # Extract families
                    avoidance = re.search(r"AvoidanceFamily\s*=\s*['\"]([^']+)['\"]", content)
                    attack = re.search(r"AttackFamily\s*=\s*['\"]([^']+)['\"]", content)
                    display = re.search(r"DisplayFamily\s*=\s*['\"]([^']+)['\"]", content)
                    
                    file_issues = []
                    if avoidance:
                        val = avoidance.group(1)
                        if val not in VALID_AVOIDANCE:
                            file_issues.append(f"Invalid Avoidance: {val}")
                    if attack:
                        val = attack.group(1)
                        if val not in VALID_ATTACK:
                            file_issues.append(f"Invalid Attack: {val}")
                    if display:
                        val = display.group(1)
                        if val not in VALID_DISPLAY:
                            file_issues.append(f"Invalid Display: {val}")
                            
                    if file_issues:
                        issues.append(f"{path}:\n  " + "\n  ".join(file_issues))
                        
    return issues

if __name__ == "__main__":
    results = audit_ships()
    if results:
        print("\n".join(results))
    else:
        print("No invalid families found!")
