# Skill: AI Research Progression Balancing

## Overview
AI research progression in HWRM often stalls if prerequisites are too rigid. This skill outlines how to move from "Ship-Count Gating" to "Tech-Gating" to ensure the AI remains competitive even after losing its fleet.

## Pattern: Tech-Gating vs. Ship-Gating

### 1. The Problem: Ship-Gating
Gating research behind a ship count (e.g., `NumSquadrons(kCruiser) > 0`) is dangerous. If the AI loses its only cruiser in combat, it can NO LONGER research advanced tech, causing total fleet stagnation.

### 2. The Solution: Tech-Gating
Gate research behind previous technology milestones using `FSFC_IsResearchDone` or `Util_CheckResearch`.

```lua
-- INSTEAD OF THIS (Fragile):
if (NumSquadrons(kCruiser) > 0) then
    Util_CheckResearch(P1_ADVANCED_CRUISERS)
end

-- DO THIS (Robust):
if (FSFC_IsResearchDone(P1_CRUISER_TECH)) then
    Util_CheckResearch(P1_ADVANCED_CRUISERS)
end
```

## Implementation in `ai_upgrades.lua`

1.  **Define Dependency Variables**: Ensure all research IDs are mapped to uppercase constants.
2.  **Use Robust Checks**:
    *   **Tier 1**: Always researchable.
    *   **Tier 2**: Requires Tier 1 Research.
    *   **Tier 3**: Requires Tier 2 Research.
3.  **Military Thresholds**: Use `TotalNumShips` or `TotalRUs` as broad gates instead of specific unit counts.

### Example: Tiered Capital Progression
```lua
-- Research Destroyer Tech if Frigate Tech is done AND we have enough RUs
if (FSFC_IsResearchDone(P1_FRIGATE_TECH)) then
    if (TotalRUs > 20000) then
        ResearchDemandSet(P1_DESTROYER_TECH, 10)
    end
end
```

## Best Practices
- **Never String-Reference**: Always use variables (e.g., `TER_ORION_TECH`) instead of strings (`"ter_orion_tech"`).
- **Check Readiness First**: Always use `Util_CheckResearch` before setting demand to ensure prerequisites in `research.lua` are satisfied.
- **Difficulty Scaling**: Adjust demand multipliers based on `s_race` and `iDifficulty`.
