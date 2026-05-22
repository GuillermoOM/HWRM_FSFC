# Skill: Race Assignment Verification

## Symptom
Custom research nodes fail to grant (`unable to grant`), or build menus for custom races are empty/defaulted to Hiigaran.

## Root Cause: The "Unknown Race" Fallback
Check `HwRM.log` for this specific entry:
`Level Load - Player [0] - Unknown Race [Hiigaran]`

This means the engine found no match between the player's lobby selection and the game rules' allowed races. It defaults to index 0 (Hiigaran).

## The Mapping Chain
For a race to load correctly, these three strings MUST be synchronized:
1. **Directory Name**: The folder in `source/scripts/races/` (e.g., `terran`).
2. **`Path_Name`**: Defined inside the race's `.lua` file (e.g., `source/scripts/races/terran.lua`).
3. **`Race_Paths`**: Defined in the game rules file (e.g., `source/scripts/rules/fs1_deathmatch.lua`).

## The Fix: Case Consistency
The engine is extremely sensitive to casing in these mappings. **Always use lowercase** for folder names and their corresponding strings in `Path_Name` and `Race_Paths`.

### Correct Configuration Example
```lua
-- 1. Folder: source/scripts/races/terran/

-- 2. source/scripts/races/terran.lua
Path_Name = "terran"
Symbolic_Name = "terran"

-- 3. source/scripts/rules/fs1_deathmatch.lua
Race_Paths = "terran,vasudan,shivan,observer"
```

## Verification
Successful assignment will look like this in the log:
`Level Load - Player [0] - terran` (or the specific name you used).
Once this is correct, `PlayerRace_GetString(i, "path_research", "")` will correctly point to the mod's research tree.
