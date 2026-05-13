# Skill: AI Reconnaissance Priority

This skill defines the standardized approach for ensuring early-game reconnaissance (scouting) in the FSFC mod.

## Core Logic

To ensure scouts are deployed before the 02:00 mark, a three-pronged priority system is used:

### 1. Build Demand Surge
In `ai_build.lua`, the demand for the primary scout ship is set to the maximum possible for the first two wings.

```lua
-- Recon Doctrine: Early and high persistence scouting
local numScouts = NumSquadrons(kScout) + NumSquadronsQ(kScout)
if (numScouts < 2) then
    ShipDemandAdd(kScout, 10.0)
elseif (numScouts < 4) then
    ShipDemandAdd(kScout, 4.5)
end
```

### 2. Research Priority Boost
In `ai_upgrades.lua`, the research node for the scout ship must have the highest priority in the fighter class to ensure it is researched immediately after `FighterDesign`.

```lua
-- Recon Doctrine: Scouts
if FSFC_IsResearchDone(FS2) == 1 then
    if (FSFC_CheckResearch(PEGASUS)) then
        ResearchDemandSet_Terran(PEGASUS, fighterdemand + 2.0)
    end
else
    if (FSFC_CheckResearch(LOKI)) then
        ResearchDemandSet_Terran(LOKI, fighterdemand + 2.0)
    end
end
```

### 3. Early Production Throttling
To prevent the AI from filling its build queue with resource collectors before the first scout is queued, a temporary penalty is applied to collectors if no scouts are present during the first 120 seconds.

```lua
-- Early game queue management: Throttle harvesters if we have NO scouts
if (gameTime() < 120 and kCollector ~= nil and numScouts < 1) then
    ShipDemandAdd(kCollector, -2.0)
end
```

## Implementation Checklist

- [x] Register `kScoutFS1` and `kScoutFS2` in `ai_build.lua`.
- [x] Apply `ShipDemandAdd(kScout, 10.0)` for `< 2` squadrons.
- [x] Apply `ShipDemandAdd(kCollector, -2.0)` if `gameTime() < 120` and `numScouts < 1`.
- [x] Set scout research demand to `fighterdemand + 2.0` in `ai_upgrades.lua`.
- [x] Ensure unit capacity for `Scout` class is at least 64 (4 wings) in `unitcaps` files.
