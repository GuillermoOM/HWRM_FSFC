# Skill: Batch Updating Build Prerequisites

This skill provides a reusable Python template for synchronizing ship build requirements in `def_build.lua` when the research tree in `def_research.lua` undergoes a significant restructure.

## The Problem
Manually updating `RequiredResearch` and the `<b>Prerequisites:</b>` string in the ship's description across dozens of units is error-prone and tedious.

## The Solution
Use a regex-based Python script to iterate through the build file and apply a mapping.

### Python Template
Save this as a scratch script and run it via terminal.

```python
import re

# Mapping: ship_id -> (new_research_node_name, human_readable_prereq_name)
mapping = {
    "ter_valkyrie": ("Valkyrie", "Apollo"),
    "ter_perseus": ("Perseus", "Valkyrie"),
    # ... add all ships
}

filepath = "source/scripts/races/terran/scripts/def_build.lua"

with open(filepath, "r") as f:
    lines = f.readlines()

current_ship = None
for i in range(len(lines)):
    line = lines[i]
    # Identify which ship block we are in
    m = re.search(r'ThingToBuild\s*=\s*"([^"]+)"', line)
    if m:
        current_ship = m.group(1)
        
    if current_ship in mapping:
        new_req, prereq_desc = mapping[current_ship]
        
        # Update the engine requirement tag
        if "RequiredResearch =" in line:
            lines[i] = re.sub(r'(RequiredResearch\s*=\s*")[^"]*(")', 
                              r'\g<1>' + new_req + r'\g<2>', line)
            
        # Update the UI description string
        if "<b>Prerequisites:</b>" in line:
            lines[i] = re.sub(r'<b>Prerequisites:</b>[^.]*\.', 
                              '<b>Prerequisites:</b> ' + prereq_desc + '.', line)

with open(filepath, "w") as f:
    f.writelines(lines)
```

## Best Practices
- **Verify Names**: Ensure the `new_research_node_name` matches the `Name` field in `def_research.lua` exactly.
- **Backups**: Always run a `git status` or keep a backup of the build file before running the script.
- **Validation**: After running, grep for `RequiredResearch` to ensure all `DONOTSHOW` or old family tags have been replaced.
