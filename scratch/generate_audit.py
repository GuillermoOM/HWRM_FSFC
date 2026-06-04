import re

md_path = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/resources/fsfc-knowledge/fsfc_ship_balance_sheet.md'
with open(md_path, 'r') as f:
    md_content = f.read()

# Extract ship lines
ship_lines = []
for line in md_content.split('\n'):
    if re.match(r'\|\s*([GgSs][a-zA-Z\s.-]+)\s*\|\s*\d+', line):
        ship_lines.append(line)

def categorize_ship(name, fam):
    name = name.lower()
    fam = fam.lower()
    
    if 'juggernaut' in fam or 'colossus' in name or 'sathanas' in name: return 'Juggernaut', 15000, 300
    if 'lucifer' in name or 'super' in name or 'hades' in name or 'hatshepsut' in name: return 'Super Destroyer', 8000, 240
    if 'destroyer' in name or 'orion' in name or 'typhon' in name or 'demon' in name or 'hecate' in name: return 'Destroyer', 5000, 180
    if 'corvette' in fam or 'deimos' in name or 'sobek' in name or 'moloch' in name or 'ravana' in name or 'iceni' in name: return 'FS Corvette', 2500, 120
    if 'cruiser' in fam or 'fenris' in name or 'leviathan' in name or 'aeolus' in name or 'aten' in name or 'mentu' in name or 'cain' in name or 'lilith' in name or 'rakshasa' in name: return 'FS Cruiser', 1500, 80
    if 'bomber' in fam: return 'FS Bomber', 650, 50
    if 'fighter' in fam or 'interceptor' in name or 'scout' in name: return 'FS Fighter', 450, 40
    if 'installation' in name or 'arcadia' in name or 'karnak' in name: return 'Installation', 5000, 180
    if 'awacs' in fam or 'science' in name or 'repair' in name or 'sentry' in name or 'deployer' in fam: return 'Utility/Platform', 1000, 50
    return 'Unknown', 1000, 50

out = "# Balancing Audit & Proposed Costs\n\n"
out += "| Ship Name | Current Cost | Current Time | Proposed Class | Proposed Cost | Proposed Time |\n"
out += "| :--- | :--- | :--- | :--- | :--- | :--- |\n"

for line in ship_lines:
    parts = [p.strip() for p in line.split('|')]
    if len(parts) > 5:
        name = parts[1]
        hp = parts[2]
        fam = parts[3]
        cost = parts[4]
        time = parts[5]
        
        p_class, p_cost, p_time = categorize_ship(name, fam)
        out += f"| {name} | {cost} | {time} | {p_class} | {p_cost} | {p_time}s |\n"
        
with open('/home/guillermo/.gemini/antigravity-cli/brain/658f4796-efe1-48b8-8985-b0002a010f39/balancing_audit.md', 'w') as f:
    f.write(out)

