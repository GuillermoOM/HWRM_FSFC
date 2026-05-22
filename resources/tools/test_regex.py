import re
content = 'supplyLimit("Aeolus", 5)'
matches = re.findall(r'supplyLimit\(\s*"([^"]+)"\s*,\s*(\d+)\s*\)', content)
print(matches)
