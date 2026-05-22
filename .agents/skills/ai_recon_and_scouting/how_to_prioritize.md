# Skill: AI Recon and Scouting Prioritization

## Goal
Ensure the AI maintains continuous map vision by prioritizing scout production in the early game (0-3 minutes) and replacing losses immediately.

## Pattern: Un-gated Scouting
Scouts are low-cost units that provide high strategic value. They should never be gated by high resource thresholds (e.g., `currentRU > 10000`).

### Implementation in `ai_build.lua`
Place the scout demand logic **before** any major economic gates. Use a high initial priority to ensure the first few wings are built as soon as `FighterDesign` is complete.

```lua
function DetermineSpecialDemand_Terran()
    local currentRU = GetRU()
    
    -- Recon Doctrine: Early and high persistence scouting
    local numScouts = NumSquadrons(kScout) + NumSquadronsQ(kScout)
    if (kScout ~= nil) then
        if (numScouts < 3) then
            -- High priority for the first 3 wings to ensure early vision
            ShipDemandAdd(kScout, 4.5)
            FSFC_Log_Demand("Scouts", 4.5)
        elseif (numScouts < 6) then
            -- Lower priority for maintenance/redundancy
            ShipDemandAdd(kScout, 1.5)
        end
    end

    -- High-RU Elite/Capital gates follow below...
    if (currentRU > 10000) then
        -- ...
    end
end
```

## Critical Rules
- **Era Readiness**: Ensure `kScout` correctly resolves to the available era variant (e.g., `ter_pegasus` for FS2, `ter_loki` for FS1) via `FSFC_PickBestShip`.
- **Tech Gating**: While demand can be high, production is still gated by research in `def_research.lua`. Ensure scout tech (e.g., `Pegasus`) is accessible early in the tree (low cost/time).
- **Telemetry**: Always use `FSFC_Log_Demand("Scouts", priority)` to verify the logic is firing in `HwRM.log`.

## Pattern: AWACS Suppression
Unlike scouts, AWACS ships are expensive and should not be mass-produced. Use `ShipDemandSet(kAWACS, -10)` to hard-cap their production once a sufficient number (usually 2) is reached.

```lua
if (kAWACS ~= nil and (NumSquadrons(kAWACS) + NumSquadronsQ(kAWACS) >= 2)) then
    ShipDemandSet(kAWACS, -10)
end
```
