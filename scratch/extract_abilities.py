import os
import re

ship_dir = "source/ship/"
output_file = "resources/fsfc-knowledge/abilities_table.md"

abilities_to_track = [
    "MoveCommand", "CanDock", "ShipHold", "HyperSpaceCommand", "CanAttack", 
    "GuardCommand", "CanBuildShips", "CanBeCaptured", "CanBeRepaired", 
    "CloakAbility", "SpecialAttack", "RepairCommand", "SalvageCommand",
    "DefenseFieldAbility", "HyperspaceInhibitorAbility"
]

results = []

for root, dirs, files in os.walk(ship_dir):
    for file in files:
        if file.endswith(".ship"):
            path = os.path.join(root, file)
            with open(path, 'r') as f:
                content = f.read()
                
                ship_name = ""
                display_name_match = re.search(r"NewShipType\.displayedName\s*=\s*'([^']+)'", content)
                if display_name_match:
                    ship_name = display_name_match.group(1)
                else:
                    ship_name = file.replace(".ship", "")
                
                # Extract abilities
                found_abilities = []
                for ab in abilities_to_track:
                    if ab in content:
                        found_abilities.append(ab)
                
                # Special check for Research (Hardcoded check for our recent injection or sub_research)
                has_research = "No"
                if "sub_research" in content or "Research" in content:
                     has_research = "Yes"
                
                # Check Hangar capacity
                hangar = "No"
                hangar_match = re.search(r"addAbility\(NewShipType,\s*'ShipHold',\s*\d+,\s*(\d+)", content)
                if hangar_match:
                    hangar = f"Yes ({hangar_match.group(1)})"

                # Check Hyperspace
                hyperspace = "No"
                if "HyperSpaceCommand" in content:
                    hyperspace = "Yes"
                    
                # Check Build
                build = "No"
                if "CanBuildShips" in content:
                    build = "Yes"

                # Check Repair
                repair = "No"
                if "RepairCommand" in content:
                    repair = "Yes"

                # Check Capture
                capture = "No"
                if "CanBeCaptured" in content:
                    capture = "Yes"

                results.append({
                    "name": ship_name,
                    "build": build,
                    "research": has_research,
                    "hangar": hangar,
                    "hyperspace": hyperspace,
                    "repair": repair,
                    "capture": capture,
                    "special": ", ".join([a for a in found_abilities if a not in ["MoveCommand", "CanDock", "CanAttack", "GuardCommand", "HyperSpaceCommand", "ShipHold", "CanBuildShips", "CanBeCaptured", "CanBeRepaired"]])
                })

# Sort by name
results.sort(key=lambda x: x['name'])

# Generate Markdown
with open(output_file, 'w') as f:
    f.write("| Ship | Build | Res | Hangar | H-Space | Rep | Cap | Special |\n")
    f.write("| :--- | :--- | :--- | :--- | :--- | :--- | :--- | :--- |\n")
    for r in results:
        f.write(f"| {r['name']} | {r['build']} | {r['research']} | {r['hangar']} | {r['hyperspace']} | {r['repair']} | {r['capture']} | {r['special']} |\n")

print(f"Table generated in {output_file}")
