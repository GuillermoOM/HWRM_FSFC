# Skill: Parallel AI Research Progression

## Overview
Vanilla HWRM AI often uses a strict sequential research chain (e.g., A -> B -> C). In FSFC, this causes the AI to stop teching if it cannot afford or fulfill a single prerequisite. This skill documents how to relax these constraints to allow parallel development of multiple unit roles.

## Pattern: The Multi-Check Block
Instead of a single `if/elseif` chain, use independent `if` blocks gated by the custom `FSFC_CheckResearch` wrapper.

## Implementation in `ai_upgrades.lua`

### 1. The Core Research Logic
```lua
function DoResearchTechDemand_Terran()
    local fighterdemand = ShipDemandGet(kInterceptor)
    
    -- Global Era Gates (Optional but recommended)
    local isFS2 = (FSFC_IsResearchDone("FS2") == 1)
    
    -- Independent checks allow the AI to research ANY available tech in the class
    if (FSFC_CheckResearch(FIGHTERDESIGN)) then
        ResearchDemandSet_Terran(FIGHTERDESIGN, fighterdemand + 1.0)
    end
    
    -- FS1 Parallel Branch
    if (not isFS2) then
        if (FSFC_CheckResearch(VALKYRIE)) then
            ResearchDemandSet_Terran(VALKYRIE, fighterdemand + 1.1)
        end
        if (FSFC_CheckResearch(APOLLO)) then
            ResearchDemandSet_Terran(APOLLO, fighterdemand + 1.2)
        end
    end
    
    -- FS2 Parallel Branch
    if (isFS2) then
        if (FSFC_CheckResearch(PERSEUS)) then
            ResearchDemandSet_Terran(PERSEUS, fighterdemand + 1.1)
        end
        if (FSFC_CheckResearch(MYRMIDON)) then
            ResearchDemandSet_Terran(MYRMIDON, fighterdemand + 1.3)
        end
    end
end
```

## Why This Works
1.  **Non-Blocking**: If the AI cannot build `Valkyrie`, it can still move on to `Apollo` research if the prerequisites are met.
2.  **Role Synergy**: High demand for a ship class (e.g., `kInterceptor`) automatically boosts demand for ALL available research in that class.
3.  **Safety**: `FSFC_CheckResearch` prevents crashes if the research ID is nil or the tech is already being researched.

## Best Practices
- **Multiplier Staggering**: Use slightly different offsets (e.g., +1.1, +1.2, +1.3) to give the AI a preferred order while still allowing parallel selection if the preferred one is blocked.
- **Era Throttling**: Use `isFS2` or similar flags to prevent the AI from wasting RUs on obsolete tech (unless desired for variety).
