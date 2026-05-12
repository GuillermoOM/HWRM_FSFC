# Skill: Role-Based Fleet Diversification

## Overview
Standard HWRM AI build logic often relies on a single variable (e.g., `kInterceptor`) for an entire class, leading to fleet stagnation where only the "best" unit is built. This skill implements a role-based split to ensure fleet variety.

## Pattern: The 40/30/30 Split
Divide a unit class (e.g., Fighters) into three distinct roles:
1.  **Space Superiority (40%)**: The main line dogfighter (e.g., Myrmidon, Thoth, Mara).
2.  **Interceptor (30%)**: Fast, light craft for anti-bomber work (e.g., Perseus, Serapis, Astaroth).
3.  **Assault (30%)**: Heavy fighters for anti-subsystem/anti-corvette work (e.g., Hercules Mk2, Tauret, Aeshma).

## Implementation in `ai_build.lua`

### 1. Define Role Variables
```lua
-- Define era-specific variants
kFighterInterceptorFS2 = TER_PERSEUS
kFighterInterceptorFS1 = TER_VALKYRIE
kFighterSuperiorityFS2 = TER_MYRMIDON
kFighterSuperiorityFS1 = TER_APOLLO
kFighterAssaultFS2 = TER_HERCULESMK2
kFighterAssaultFS1 = TER_HERCULES

-- Initialize in CpuBuild_UpdateRaceVariables()
function CpuBuild_UpdateRaceVariables()
    kFighterInterceptor = Util_PickBestShip(kFighterInterceptorFS2, kFighterInterceptorFS1)
    kFighterSuperiority = Util_PickBestShip(kFighterSuperiorityFS2, kFighterSuperiorityFS1)
    kFighterAssault = Util_PickBestShip(kFighterAssaultFS2, kFighterAssaultFS1)
    
    -- Maintain backward compatibility for other scripts
    kInterceptor = kFighterSuperiority 
end
```

### 2. Distribute Demand in `DetermineSpecialDemand`
```lua
local numFInt = NumSquadrons(kFighterInterceptor) + NumSquadronsQ(kFighterInterceptor)
local numFSup = NumSquadrons(kFighterSuperiority) + NumSquadronsQ(kFighterSuperiority)
local numFAss = NumSquadrons(kFighterAssault) + NumSquadronsQ(kFighterAssault)
local totalFighters = numFInt + numFSup + numFAss

if (totalFighters < fighterTarget) then
    if (numFSup < fighterTarget * 0.4) then
        ShipDemandAdd(kFighterSuperiority, fighterDemand)
    end
    if (numFInt < fighterTarget * 0.3) then
        ShipDemandAdd(kFighterInterceptor, fighterDemand * 0.8)
    end
    if (numFAss < fighterTarget * 0.3) then
        ShipDemandAdd(kFighterAssault, fighterDemand * 0.7)
    end
end
```

## Pattern: Smart Caps for Elite Units
For units that are powerful but should not be mass-produced (e.g., GTF Erinyes, GTC Aeolus), implement a script-level "soft cap" in `DetermineSpecialDemand`.

### Implementation
```lua
-- Elite Fighter Cap (e.g., Erinyes)
local numErinyes = NumSquadrons(TER_ERINYES) + NumSquadronsQ(TER_ERINYES)
if (numErinyes >= 12) then
    ShipDemandSet(TER_ERINYES, -100) -- Effectively stops AI from building more
end

-- Anti-Fighter Specialist Cap (e.g., Aeolus)
local numAeolus = NumSquadrons(TER_AEOLUS) + NumSquadronsQ(TER_AEOLUS)
if (numAeolus >= 8) then
    ShipDemandSet(TER_AEOLUS, -50) -- Drastically reduces desire
end
```

## Best Practices
- **Use Uppercase Constants**: Always refer to ship names as uppercase variables (e.g., `TER_PERSEUS`). These are mapped to internal engine IDs.
- **Throttled Logging**: Use `FSFC_Log_Demand` to track these splits in `HwRM.log` without flooding.
- **Combine with Unitcaps**: Use script-level caps for the AI's "desire" and engine-level `unitcaps` for the hard physical limit.
