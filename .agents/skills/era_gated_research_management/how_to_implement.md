# Skill: Era-Gated Research Management

## Scenario
You need to grant a global era-node (e.g., `Freespace1`) to all players at the start of a match, but only if they are playing a specific faction (Terran, Vasudan, Shivan) to avoid breaking vanilla or other modded races.

## Implementation Pattern
Use `PlayerRace_GetString` with the `Prefix` key to identify the race family safely inside the rule loop.

### Safe Granting Template
```lua
function Rule_GrantEra()
    for i = 0, Universe_PlayerCount() - 1 do
        if (Player_IsAlive(i) == 1) then
            -- Get the race prefix (e.g., "TER_", "VAS_", "SHI_")
            local racePrefix = strsub(PlayerRace_GetString(i, "Prefix", ""), 1, 3)
            
            -- Only grant if they belong to the mod's race family
            if (racePrefix == "TER" or racePrefix == "VAS" or racePrefix == "SHI") then
                Player_UnrestrictResearchOption(i, "Freespace1")
                Player_GrantResearchOption(i, "Freespace1")
                
                -- Always explicitly restrict the opposing era
                Player_RestrictResearchOption(i, "Freespace2")
            end
        end
    end
    Rule_Remove("Rule_GrantEra")
end
```

## Why this is necessary
- **Cross-Mod Compatibility**: Without the prefix check, the engine will attempt to grant `Freespace1` to a Hiigaran player, which will throw an error in `HwRM.log` because the Hiigaran research tree lacks that node.
- **The DoNotGrant Trap (CRITICAL GOTCHA)**: Do NOT use `DoNotGrant = 1` in `def_research.lua` for research nodes that are intended to be granted programmatically (e.g. `FS1`, `FS2` eras). The HWRM engine treats `DoNotGrant = 1` as an absolute block, causing APIs like `Player_GrantResearchOption` to fail silently with `unable to grant (tech)` in `HwRM.log`.
- **Proper Hidden-Node Workaround**: To hide nodes from the player research menu while keeping them accessible to code rules, define them *without* `DoNotGrant = 1` in `def_research.lua`. Instead, restrict them immediately at match initialization using `Player_RestrictResearchOption`, and then grant them when needed using `Player_GrantResearchOption`.

