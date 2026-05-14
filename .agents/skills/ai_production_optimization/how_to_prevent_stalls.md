# Skill: AI Production Optimization & Stall Prevention

## Overview
A common pitfall in HWRM modding is implementing "Economic Gates" (e.g., `if currentRU > 2000 then ...`) to ensure the AI has a reserve. In competitive mods like FSFC, these gates often lead to military stagnation and "build-stalls" where the AI hoards resources while being overwhelmed. This skill focuses on high-liquidity, demand-driven production.

## Pattern: Removing Economic Gates
Instead of checking for a minimum RU balance, rely on **Strategic Demand**. The AI should spend every RU it has if there is a perceived threat or a gap in its fleet composition.

### ❌ Old/Gate Pattern (Avoid)
```lua
function DetermineSpecialDemand_Terran()
    local currentRU = GetPlayerResource(s_playerIndex)
    if (currentRU > 2000) then -- ❌ Artificial gate causes stalls
        if (NumSquadrons(kDestroyer) < 2) then
            ShipDemandAdd(kDestroyer, 2.0)
        end
    end
end
```

### ✅ New/Optimized Pattern (Preferred)
```lua
function DetermineSpecialDemand_Terran()
    -- Always add demand based on fleet goals, regardless of current wallet
    -- The engine's internal build queue will handle the RU spending
    local numDestroyers = NumSquadrons(kDestroyer) + NumSquadronsQ(kDestroyer)
    if (numDestroyers < 2) then
        ShipDemandAdd(kDestroyer, 2.0)
    end
    
    -- Use multipliers for urgency rather than RU checks
    if (SelfSafeThreat() < EnemyTotalThreat() * 0.8) then
        ShipDemandAdd(kDestroyer, 1.5) -- Increase demand if outnumbered
    end
end
```

## Pattern: The "Backbone" vs "Elite" Philosophy
To maintain a high-liquidity fleet, the AI must differentiate between "Elite" high-cost units and "Backbone" mass-produced units.

1.  **Backbone Units**: High unit caps (e.g., 25), moderate cost, steady demand. (e.g., GTC Fenris, GVC Mentu).
2.  **Elite Units**: Low unit caps (e.g., 5), high cost, prioritized but restricted. (e.g., GTCv Deimos, GVCv Sobek).

### Implementation Logic
```lua
-- Backbone Cruiser Demand (Fenris/Leviathan)
local numCruisers = NumSquadrons(kCruiser) + NumSquadronsQ(kCruiser)
if (numCruisers < 10) then
    ShipDemandAdd(kCruiser, 2.0) -- Steady pressure
end

-- Elite Cruiser Demand (Deimos/Aeolus)
local numElite = NumSquadrons(kEliteCruiser) + NumSquadronsQ(kEliteCruiser)
if (numElite < 4) then
    ShipDemandAdd(kEliteCruiser, 3.5) -- High priority, but will hit low cap quickly
end
## Pattern: Logistics Escalation
Economic growth requires both collectors and resource drop-off points (Refineries/Controllers). If the AI fails to scale its drop-off points, it will hit a build bottleneck where collectors have long transit times, causing RU starvation even if total resources are high.

### Implementation Logic
In faction `ai_build.lua`:
```lua
-- Logistics Escalation
local numRefineries = NumSquadrons(kRefinery) + NumSquadronsQ(kRefinery)
if (numRefineries < 1) then
    ShipDemandAdd(kRefinery, 5.5)
elseif (numRefineries < 2 and currentRU > 5000) then
    ShipDemandAdd(kRefinery, 2.5) -- Ensure second drop-off as economy grows
end
```

## Pattern: Relaxing Threat Thresholds
The HWRM AI has a native "Under Attack" check that can suppress logistical production if it perceives too much threat. In high-aggression mods like FSFC, the default thresholds are often too conservative, causing the AI to stop building refineries during minor skirmishes.

### Implementation Logic
In `cpuresource.lua`:
```lua
-- Relax threat threshold from -75 (vanilla) to -20 (aggro)
if (UnderAttackThreat() > -20) then
    return 0 -- Still suppress if seriously overwhelmed, but allow minor combat
end
```

## Best Practices
- **Queue Headroom**: Avoid clogging the queue with cheap units if high-tier tech is available (see [Elite Suppression Skill](../ai_fleet_diversification/how_to_implement.md)).
- **Liquidity**: If the AI has > 10,000 RUs and is not building, check for unit cap lockouts or missing `k*` variable assignments.
- **Scaling**: In late-game, increase the backbone caps to allow the AI to scale its economy into a massive fleet.
- **Removing Economic Gates**: (CRITICAL) Never use `currentRU > 2000` checks in `ai_build.lua` for primary unit production. This causes the AI to stall during combat when RU income is erratic, leading to a death spiral. Rely on the engine's internal budgeter instead.
