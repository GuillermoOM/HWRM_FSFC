# Skill: Era-Aware Ship Selection (FS1 vs FS2)

## Overview

FSFC spans two major eras (Great War and Second Great War). The AI must intelligently switch between ship variants (e.g., Orion FS1 vs Orion FS2) based on the game mode or research state.

## The `Util_PickBestShip` Wrapper

Located in `data:scripts/custom_scripts/ai_telemetry.lua`, this function handles the logic of selecting the appropriate variant.

### Implementation

```lua
function Util_PickBestShip(fs2_ship, fs1_ship)
    -- Check if FS2 tech has been reached
    if (FSFC_IsResearchDone("FS2") == 1) then
        return fs2_ship
    end
    -- Fallback to FS1
    return fs1_ship
end
```

## Pattern: Variable Pairing

In `ai_build.lua`, always define variables in FS2/FS1 pairs.

```lua
-- Definition Section
kFighterFS2 = TER_PERSEUS
kFighterFS1 = TER_APOLLO

-- Update Section
function CpuBuild_UpdateRaceVariables()
    kFighter = Util_PickBestShip(kFighterFS2, kFighterFS1)
end
```

## Advanced: Mixed Eras

If a ship should appear in BOTH eras, assign the same ID to both variables:

```lua
kScoutFS2 = TER_PEGASUS
kScoutFS1 = TER_PEGASUS
```

## Best Practices

- **Uppercase Consistency**: Use the standard uppercase variable names (e.g., `TER_PERSEUS`) for all ship references in `ai_build.lua`.
- **ID Safety**: Always verify that the string ID in `ai_build.lua` matches the `ThingToBuild` entry in the race's `def_build.lua`.
- **Dynamic Switching**: `CpuBuild_UpdateRaceVariables` is called every AI tick, so the AI will live-swap its production queue the moment the FS2 research completes.
