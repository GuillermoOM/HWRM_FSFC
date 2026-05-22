# Skill: Faction Parity Benchmarking

## Overview
To ensure a balanced competitive environment in the FSFC mod, all factions must have synchronized research and production costs. This skill outlines how to audit and enforce this parity using the Master Balance Sheet.

## 1. The Research Parity Standard
All research trees should follow these standard cost/time tiers to prevent one race from "Tech Rushing" others.

| Tier | Example Tech | RU Cost | Time (s) |
| :--- | :--- | :--- | :--- |
| **Tier 1 (Fighter)** | Interceptor Design | 500 | 30 |
| **Tier 2 (Corvette)** | Bomber Design | 1,000 | 45 |
| **Tier 3 (Frigate)** | Frigate Design | 2,000 | 60 |
| **Tier 4 (Capital)** | Capital Ship Design | 5,000 | 120 |
| **Tier 5 (SuperCap)** | SuperCap Design | 20,000 | 300 |

### Auditing `def_research.lua`
- Check that `Cost` and `Time` values are consistent across `terran`, `vasudan`, and `shivan` directories.
- Ensure that ship-specific unlocks (e.g., `ORION_RESEARCH`) are separate from class-wide unlocks.

## 2. Using the Master Balance Sheet
The `Master Balance Sheet` ([FSFC Ship Balance Sheet](file:///run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/resources/fsfc-knowledge/fsfc_ship_balance_sheet.md)) is the ground truth for all unit stats.

### How to Benchmark
1.  **Extract Stats**: Run the automated extraction scripts to populate the sheet.
2.  **Compare Peer Units**: 
    - **GTD Orion** (Terran) vs. **GVD Typhon/Hatshepsut** (Vasudan) vs. **SD Demon/Ravana** (Shivan).
3.  **Audit DPS vs. Cost**: A ship with 5000 DPS should generally cost 50% more than a ship with 2500 DPS.
4.  **Audit HP vs. Role**: "Backbone" cruisers should have lower HP than "Elite" cruisers of the same era.

## 3. The "Elite Suppression" Check
Verify that the AI is correctly prioritized to build elite units until their cap is hit, but has enough "Backbone" units to maintain fleet density.

- **Check**: Is the AI sitting on > 2000 RUs while having empty build slots?
- **Check**: Are elite units (Aeolus, Sobek) appearing too early or in too many numbers?

## Best Practices
- **Standardized Time Units**: Always use multiples of 30s for research time to keep the game's "Tech Pacing" predictable.
- **Cost Scaling**: Increase research costs by ~2x for each subsequent tier.
- **Verification**: Always run a 30-minute AI vs. AI simulation after making research cost changes to check for "Research Stalls."
