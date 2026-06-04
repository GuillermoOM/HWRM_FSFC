import re

shivan_path = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/scripts/races/shivan/scripts/def_research.lua'
with open(shivan_path, 'r') as f:
    content = f.read()

# Fix SuperCapitalShipDesign (Shivan)
content = re.sub(r'(Name\s*=\s*"SuperCapitalShipDesign".*?Cost\s*=\s*)\d+', r'\g<1>0', content, flags=re.DOTALL)
content = re.sub(r'(Name\s*=\s*"SuperCapitalShipDesign".*?Time\s*=\s*)\d+', r'\g<1>10', content, flags=re.DOTALL)
content = re.sub(r'(Name\s*=\s*"SuperCapitalShipDesign".*?DisplayedName\s*=\s*"[^"]+?)\(\d+s\)', r'\g<1>(10s)', content, flags=re.DOTALL)

with open(shivan_path, 'w') as f:
    f.write(content)

print("Fixed Shivan SuperCapitalShipDesign bridge node!")
