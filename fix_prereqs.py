import re

vasudan_path = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/scripts/races/vasudan/scripts/def_research.lua'
with open(vasudan_path, 'r') as f:
    content = f.read()

content = re.sub(r'(Name\s*=\s*"Colossus".*?RequiredResearch\s*=\s*")SuperCapitalShipDesign\s*&\s*FS2(")', r'\g<1>Installation & FS2\g<2>', content, flags=re.DOTALL)

with open(vasudan_path, 'w') as f:
    f.write(content)


shivan_path = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/scripts/races/shivan/scripts/def_research.lua'
with open(shivan_path, 'r') as f:
    content = f.read()

content = re.sub(r'(Name\s*=\s*"Sathanas".*?RequiredResearch\s*=\s*")SuperCapitalShipDesign\s*&\s*FS2(")', r'\g<1>Lucifer & FS2\g<2>', content, flags=re.DOTALL)

with open(shivan_path, 'w') as f:
    f.write(content)

print("Fixed prerequisites!")
