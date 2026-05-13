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
```

## Best Practices
- **Queue Headroom**: Avoid clogging the queue with cheap units if high-tier tech is available (see [Elite Suppression Skill](../ai_fleet_diversification/how_to_implement.md)).
- **Liquidity**: If the AI has > 10,000 RUs and is not building, check for unit cap lockouts or missing `k*` variable assignments.
- **Scaling**: In late-game, increase the backbone caps to allow the AI to scale its economy into a massive fleet.
- **Removing Economic Gates**: (CRITICAL) Never use `currentRU > 2000` checks in `ai_build.lua` for primary unit production. This causes the AI to stall during combat when RU income is erratic, leading to a death spiral. Rely on the engine's internal budgeter instead.
