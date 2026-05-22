# Skill: Balancing Elite vs. Standard Units (Backbone Philosophy)

## Overview
In the FSFC mod, elite ships (e.g., GTCv Deimos, GTC Aeolus) are extremely powerful but limited by low unit caps. To prevent the AI from stopping production once these caps are hit, or from building too few escort ships, we use a "Backbone vs. Elite" demand pattern.

## Pattern: Era-Aware Ship Mapping
Use era-specific constants and the `FSFC_PickBestShip` wrapper in `ai_build.lua` to ensure the AI selects the correct "Backbone" and "Elite" units for the current match era.

### Example: Defining Cruiser Classes
```lua
-- Era Counterparts
kDestroyerFS2 = TER_DEIMOS        -- Elite
kDestroyerFS1 = TER_FENRIS_FS1    -- Standard
kCruiserFS2 = TER_FENRIS          -- Standard Backbone
kCruiserFS1 = TER_FENRIS_FS1      -- Standard Backbone

function CpuBuild_UpdateRaceVariables()
    -- Resolve Class Constants
    kDestroyer = FSFC_PickBestShip(kDestroyerFS2, kDestroyerFS1)
    kCruiser = FSFC_PickBestShip(kCruiserFS2, kCruiserFS1)
end
```

## Pattern: Layered Demand Logic
In `DetermineSpecialDemand`, implement demand for both classes. Set higher multipliers for Elites to ensure they are built first, but maintain a persistent baseline for Backbone units.

### Implementation Logic
```lua
function DetermineSpecialDemand_Terran()
    -- 1. Elite Demand (High Priority, Low Cap)
    -- The AI will prioritize these until the 5-ship cap is hit
    local capDemand = 3.5
    if (GetPlayerResource(s_playerIndex) > 5000) then
        ShipDemandAdd(kDestroyer, capDemand)
    end

    -- 2. Backbone Demand (Medium Priority, High Cap)
    -- Ensures a steady escort fleet of 10-15 ships
    local numCruisers = NumSquadrons(kCruiser) + NumSquadronsQ(kCruiser)
    if (numCruisers < 10) then
        ShipDemandAdd(kCruiser, 2.0)
    end
end
```

## Debugging & Verification
- **Check Unit Caps**: Verify `setSupplyValue` in the `.ship` file matches the family used in `unitcaps/default.lua`.
- **Monitor Telemetry**: Use `/analyse-match-timeline` to check if the AI successfully switches to Backbone units after Elites reach their cap.
- **Log Demands**: Use `FSFC_Log_Demand("Label", value)` to verify the demand logic is firing in `HwRM.log`.

## Best Practices
- **Quota Safety**: Always use `NumSquadrons + NumSquadronsQ` (Queued) to avoid over-ordering units and clogging the build queue.
- **Role Differentiation**: Ensure Backbone units have a clear role (e.g., Fenris = Kinetic Escort, Leviathan = Heavy Escort) to justify their build slots.
- **Anti-Passivity**: Never use `if currentRU > X` gates alone; always provide a baseline demand so the AI stays militarily active.
