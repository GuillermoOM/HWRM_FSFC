import re, os

md_path = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/resources/fsfc-knowledge/fsfc_ship_balance_sheet.md'
with open(md_path, 'r') as f:
    lines = f.read().split('\n')

new_lines = []
for line in lines:
    if '| **T5** | **Super Capital Ship Design** | FS1 | `vas_hatshepsut` |' in line:
        continue
    new_lines.append(line)

with open(md_path, 'w') as f:
    f.write('\n'.join(new_lines))

# Now remove the node from def_research.lua
workspace = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/source'
vas_res_path = os.path.join(workspace, 'scripts/races/vasudan/scripts/def_research.lua')
if os.path.exists(vas_res_path):
    with open(vas_res_path, 'r') as f: content = f.read()
    
    # We will remove the entire Super Capital Ship Design block
    content = re.sub(r'\t\{\s*Name\s*=\s*"SuperCapitalShipDesign",.*?TargetName\s*=\s*"vas_hatshepsut",.*?\t\},', '', content, flags=re.DOTALL)
    
    with open(vas_res_path, 'w') as f: f.write(content)

