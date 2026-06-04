import re

filepath = '/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/resources/fsfc-knowledge/fsfc_ship_balance_sheet.md'

with open(filepath, 'r') as f:
    content = f.read()

# Terran replacements
content = re.sub(r'(\|\s*\*\*T3\*\*\s*\|\s*\*\*Cruiser Design\*\*.*?\|\s*)8000(\s*\|\s*)120s(\s*\|)', r'\g<1>4000\g<2>120s\g<3>', content)
content = re.sub(r'(\|\s*\*\*T4\*\*\s*\|\s*\*\*Capital Ship Design\*\*.*?\|\s*)5000(\s*\|\s*)180s(\s*\|)', r'\g<1>8000\g<2>150s\g<3>', content)
content = re.sub(r'(\|\s*\*\*T5\*\*\s*\|\s*\*\*SuperDestroyer\*\*.*?\|\s*8000\s*\|\s*)150s(\s*\|)', r'\g<1>180s\g<2>', content)
content = re.sub(r'(\|\s*\*\*T6\*\*\s*\|\s*\*\*Juggernaut\*\*.*ter_colossus.*?\|\s*)12000(\s*\|\s*)200s(\s*\|)', r'\g<1>12000\g<2>240s\g<3>', content)

# Vasudan replacements
content = re.sub(r'(\|\s*\*\*T3\*\*\s*\|\s*\*\*Cruiser Design\*\*.*vas_aten.*?\|\s*)8000(\s*\|\s*)120s(\s*\|)', r'\g<1>4000\g<2>120s\g<3>', content)
content = re.sub(r'(\|\s*\*\*T4\*\*\s*\|\s*\*\*Capital Ship Design\*\*.*vas_typhon.*?\|\s*)5000(\s*\|\s*)180s(\s*\|)', r'\g<1>8000\g<2>150s\g<3>', content)
content = re.sub(r'(\|\s*\*\*T5\*\*\s*\|\s*\*\*Super Capital Ship Design\*\*.*vas_hatshepsut_fs1.*?\|\s*)6000(\s*\|\s*)120s(\s*\|)', r'\g<1>8000\g<2>180s\g<3>', content)
content = re.sub(r'(\|\s*\*\*T5\*\*\s*\|\s*\*\*Juggernaut\*\*.*vas_colossus.*?\|\s*)12000(\s*\|\s*)200s(\s*\|)', r'\g<1>20000\g<2>240s\g<3>', content)

# Shivan replacements
content = re.sub(r'(\|\s*\*\*T3\*\*\s*\|\s*\*\*Cruiser Design\*\*.*shi_cain_fs1.*?\|\s*)8000(\s*\|\s*)120s(\s*\|)', r'\g<1>4000\g<2>120s\g<3>', content)
content = re.sub(r'(\|\s*\*\*T4\*\*\s*\|\s*\*\*Capital Ship Design\*\*.*shi_demon.*?\|\s*)5000(\s*\|\s*)180s(\s*\|)', r'\g<1>8000\g<2>150s\g<3>', content)
content = re.sub(r'(\|\s*\*\*T5\*\*\s*\|\s*\*\*Super Capital Ship Design\*\*.*shi_lucifer.*?\|\s*)8000(\s*\|\s*)150s(\s*\|)', r'\g<1>8000\g<2>180s\g<3>', content)
content = re.sub(r'(\|\s*\*\*T6\*\*\s*\|\s*\*\*Juggernaut\*\*.*shi_sathanas.*?\|\s*)12000(\s*\|\s*)200s(\s*\|)', r'\g<1>12000\g<2>240s\g<3>', content)

with open(filepath, 'w') as f:
    f.write(content)

