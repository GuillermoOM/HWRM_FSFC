import re

shivan_path = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/scripts/races/shivan/scripts/def_research.lua'
with open(shivan_path, 'r') as f:
    content = f.read()

# Fix Lucifer (Shivan)
content = re.sub(r'(Name\s*=\s*"Lucifer".*?Cost\s*=\s*)\d+', r'\g<1>8000', content, flags=re.DOTALL)
content = re.sub(r'(Name\s*=\s*"Lucifer".*?Time\s*=\s*)\d+', r'\g<1>180', content, flags=re.DOTALL)
content = re.sub(r'(Name\s*=\s*"Lucifer".*?DisplayedName\s*=\s*"[^"]+?)\(\d+s\)', r'\g<1>(180s)', content, flags=re.DOTALL)

# Fix Sathanas (Shivan)
content = re.sub(r'(Name\s*=\s*"Sathanas".*?Cost\s*=\s*)\d+', r'\g<1>12000', content, flags=re.DOTALL)
content = re.sub(r'(Name\s*=\s*"Sathanas".*?Time\s*=\s*)\d+', r'\g<1>240', content, flags=re.DOTALL)
content = re.sub(r'(Name\s*=\s*"Sathanas".*?DisplayedName\s*=\s*"[^"]+?)\(\d+s\)', r'\g<1>(240s)', content, flags=re.DOTALL)

with open(shivan_path, 'w') as f:
    f.write(content)

vasudan_path = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source/scripts/races/vasudan/scripts/def_research.lua'
with open(vasudan_path, 'r') as f:
    content = f.read()

# Fix Colossus (Vasudan)
content = re.sub(r'(Name\s*=\s*"Colossus".*?Cost\s*=\s*)\d+', r'\g<1>20000', content, flags=re.DOTALL)
content = re.sub(r'(Name\s*=\s*"Colossus".*?Time\s*=\s*)\d+', r'\g<1>240', content, flags=re.DOTALL)
content = re.sub(r'(Name\s*=\s*"Colossus".*?DisplayedName\s*=\s*"[^"]+?)\(\d+s\)', r'\g<1>(240s)', content, flags=re.DOTALL)

with open(vasudan_path, 'w') as f:
    f.write(content)

print("Fixed missed research nodes!")
