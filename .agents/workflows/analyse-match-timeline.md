---
description: Perform a timeline analysis of the current match by reading the game logs, then provide a plan for recommendations by looking at AI behavior and balance sheets
---

I need you to run the tool "timeline_analysis.py" and create a report of AI behavior and balancing, comparing with the current AI scripting behavior and "fsfc_ship_balance_sheet.md" for any needed information, performing any actions before approving shouldn't be permitted, just present recommendations and maybe ask questions.

Give a full report stating timeline notes, highlights of the match, and any additional info that would help identify balancing issues or AI improvements.

# AI Match Analysis Template

## 1. Match Metadata

- **Date**: [YYYY-MM-DD]
- **Game Mode**: [e.g., FS2 Deathmatch]
- **Map**: [Map Name]
- **Factions**:
  - P1: [Race] (AI: [LOD])
  - P2: [Race] (AI: [LOD])
  - P3: [Race] (AI: [LOD])

## 2. Tech Progression (Minutes)

| Milestone     | Terran (P1) | Vasudan (P2) | Shivan (P3) |
| ------------- | ----------- | ------------ | ----------- |
| FighterDesign |             |              |             |
| BomberDesign  |             |              |             |
| CruiserDesign |             |              |             |
| CapitalDesign |             |              |             |

## 3. Fleet Composition Analysis

- **Terran Dominance**: [Main unit types produced]
- **Vasudan Swarm**: [Bomber count vs Interceptor count]
- **Shivan Aggression**: [Time of first major engagement]

## 4. Doctrine Verification

- **Recon Doctrine**: Did all factions maintain scouts? [Y/N]
- **Aegis Reactive**: Did AI respond to bomber threats with Interceptors? [Y/N]
- **Research Deadlock**: Did any race stall on research? [Y/N - Identify node]

## 5. Balance Observations

> [!NOTE]
> Summarize any "weird" behaviors or tactical advantages noticed.

- **Observed issue**: [e.g., Terran AI builds too many Deimos, ignores Fenris]
- **Observed issue**: [e.g., Shivan Dragons are too effective against capital ships]

## 6. Recommendations

- [ ] Increase/Decrease research time for [Node]
- [ ] Adjust `DetermineSpecialDemand` multiplier for [Ship Class]
- [ ] Tweak ship supply values in `.ship` files
