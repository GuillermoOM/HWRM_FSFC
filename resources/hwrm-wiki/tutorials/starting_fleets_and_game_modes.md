# Starting Fleets & Game Modes

> Documentation for the engine's starting fleet system and how to integrate era-specific configurations for custom game modes.

---

## 1. The Starting Fleet Suffix System

The HWRM engine uses a suffix-based system to load different starting ship configurations based on the active game mode. This is controlled in the game rule script (`.lua` or `.scar`) using the `SetStartFleetSuffix` command.

### How it works:
1. The rule script calls `SetStartFleetSuffix("mysuffix")`.
2. The engine looks for files in `scripts/startingfleets/` matching the pattern: `<race_path_name>00<suffix>.lua`.
3. If the file is found, it loads the ships defined in `PersistantData.Squadrons`.
4. If no suffix is set (or empty string), it defaults to `<race_path_name>00.lua`.

### Example:
If you are playing as **Terran** (Path_Name = `terran`) and the rule script calls:
```lua
SetStartFleetSuffix("fs1")
```
The engine will look for:
`scripts/startingfleets/terran00fs1.lua`

**CRITICAL**: If this file is missing for a race, **NO starting ships will spawn** for that race when that mode is selected.

---

## 2. Configuration File Structure

The starting fleet files use the following format:

```lua
PersistantData = {
    StrikeGroups = {},
    Squadrons = {
        {
            type = "ter_orion", -- Ship class name from .ship file
            subsystems = {},
            shiphold = {},
            name = "",
            size = 1,
            number = 1, -- Number of ships of this type
        },
        {
            type = "ter_elysium",
            subsystems = {},
            shiphold = {},
            name = "",
            size = 1,
            number = 6,
        },
    },
}
```

---

When creating era-specific game modes, it is recommended to use a single game mode with a **GameSetupOption** for the era, rather than separate `.lua` rule files. This reduces maintenance and allows for "Both Eras" play.

### A. Game Setup Option
Define the era choice in the Gamerule's `GameSetupOptions` table:
```lua
GameSetupOptions = {
    {
        name = "era",
        locName = "Era",
        choices = { "FS1", "0", "FS2", "1", "Both", "2" },
    },
}
```

### B. Dynamic Initialization
In the SCAR `OnInit` function, read the setting and apply restrictions:
```lua
local era = GetGameSettingAsNumber("era")
if (era == 0) then
    SetStartFleetSuffix("fs1")
    Player_GrantResearchOption(player, "FS1")
elseif (era == 1) then
    SetStartFleetSuffix("fs2")
    Player_GrantResearchOption(player, "FS2")
end
```

### C. Starting Fleets
Create a `<race>00fs1.lua` and `<race>00fs2.lua` for every playable race in the `startingfleets/` directory.

### B. Build Restrictions
In the game rule script, use a timer loop to periodically restrict build options that don't belong in the current era:

```lua
local fs2_ships_to_hide = { "ter_perseus", "vas_sobek", "shi_ravana" }
for i, ship in fs2_ships_to_hide do
    Player_RestrictBuildOption(playerIndex, ship)
end
```

### C. Research Grants
Use the `FS1` and `FS2` research nodes to "soft-gate" technology. The rule script should grant the appropriate era node on initialization:

```lua
Player_GrantResearchOption(player, "FS1")
Player_RestrictResearchOption(player, "FS2")
```
