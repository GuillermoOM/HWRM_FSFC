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

```
-- Research Destroyer Tech if Frigate Tech is done AND we have enough RUs
if (FSFC_IsResearchDone(P1_FRIGATE_TECH)) then
    if (TotalRUs > 20000) then
        ResearchDemandSet(P1_DESTROYER_TECH, 10)
    end
end
```

## Pattern: Decoupling Ships from Tech Nodes
Avoid bundling expensive capital ships directly into "Gateway" research nodes. This hides the true economic cost from the AI and makes balancing difficult.

### 1. The Gateway Tech
Research node that unlocks the *capability* to build a class (e.g., `CapitalShipDesign`).
- **Cost**: Moderate (~5,000 RU).
- **Function**: Prerequisites for multiple ship-specific nodes.

### 2. The Ship Node
Individual research nodes for high-value ships (e.g., `GTD Orion`, `SD Demon`).
- **Cost**: High (2,000 - 5,000 RU).
- **Prerequisite**: The Gateway Tech.

### Benefits
- **AI Intent**: The AI engine can evaluate the cost of the *ship* independently of the *class capability*.
- **Pacing**: Prevents "Tech Rushing" where a race gets a top-tier ship immediately upon finishing a gateway node.

## Pattern: Economic Parity (Tiered Pricing)
Standardize research costs across all factions to ensure no race has a "Cheap Research" advantage.

| Tier | Role | Research Cost | Research Time |
| :--- | :--- | :--- | :--- |
| **Tier 1** | Fighters / Corvettes | 500 - 1,000 RU | 30 - 45s |
| **Tier 2** | Frigates / Cruisers | 1,500 - 2,500 RU | 60 - 90s |
| **Tier 3** | Destroyers / Carriers | 4,000 - 6,000 RU | 120 - 150s |
| **Tier 4** | Juggernauts / SuperCaps | 15,000 - 25,000 RU | 200 - 300s |

## Pattern: Automated Research Auditing
To maintain parity across races, use the `extract_ship_stats.py` tool to generate a global research table.

### 1. Execute Extraction
Run the tool from the root directory to update the Master Balance Sheet:
```bash
python3 resources/tools/extract_ship_stats.py
```

### 2. Audit the Master Balance Sheet
Review `resources/fsfc-knowledge/fsfc_ship_balance_sheet.md`. 
- Check the **Research Tree Cost Matrix** for outliers.
- Ensure Tier 3 and Tier 4 costs align with the target pricing table above.
- Verify that FS1 and FS2 variants are consistently priced across factions.

## Best Practices
- **Never String-Reference**: Always use variables (e.g., `TER_ORION_TECH`) instead of strings (`"ter_orion_tech"`).
- **Check Readiness First**: Always use `Util_CheckResearch` before setting demand to ensure prerequisites in `research.lua` are satisfied.
- **Difficulty Scaling**: Adjust demand multipliers based on `s_race` and `iDifficulty`.
- **Vasudan Research Trap**: Be wary of factions with large research trees. If a faction is stalling, check if they are over-researching low-priority nodes at the expense of fleet production. Use `ai_upgrades.lua` to throttle non-essential tech.
