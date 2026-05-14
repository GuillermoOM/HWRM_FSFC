---
description: Perform a comprehensive post-match timeline analysis by correlating game logs, AI demand telemetry, and balance sheet statistics.
---

# FSFC Post-Match Analysis Workflow

To provide a professional analysis of AI behavior and balancing, follow these steps:

## 1. Data Collection
Run the following tools to gather the necessary metrics from the `HwRM.log`:

```bash
# Generate the chronological timeline and economic/strategic reports
python3 resources/tools/timeline_analysis.py ../HomeworldRM/Bin/Release/HwRM.log > artifacts/match_timeline.txt

# Extract current ship/weapon stats for balance reference
python3 resources/tools/extract_ship_stats.py artifacts/match_balance_context.csv
```

## 2. Analysis Checklist
Correlate the gathered data against the following FSFC standards:

- [ ] **Tech Pacing**: Did any faction reach Tier 3 (Cruisers) before 8 mins or Tier 4 (Capitals) before 15 mins?
- [ ] **Elite Suppression**: For P1 (Terran), check if standard fighter production (Pegasus/Artemis) ceased once elite variants (Erinyes/Ares) were unlocked.
- [ ] **Economic Equity**: Compare `Avg RU/min`. If one faction is significantly lower, check for harvester losses or "Build Stalls" (current RU > 5000 with low fleet).
- [ ] **Combat Effectiveness**: Look at `Threat Evolution`. Identify if a faction's fleet strength collapsed suddenly without inflicting equivalent damage.
- [ ] **AI Deadlocks**: Search for repeating `WANT` lines with high demand that never result in a `BUILD` event (indicates missing prerequisites or cost issues).

## 3. Match Report Template

Use the following structure for your final report:

# FSFC Match Analysis Report: [Match ID/Date]

## Executive Summary
[Brief overview: Who won, match duration, and key balancing takeaway]

## 1. Tactical Milestones
| Milestone | Player 1 (Terran) | Player 2 (Shivan) | Player 3 (Vasudan) |
| :--- | :--- | :--- | :--- |
| First Engagement | [00:00] | [00:00] | [00:00] |
| Destroyer Era | [00:00] | [00:00] | [00:00] |
| Capital Era | [00:00] | [00:00] | [00:00] |
| **Pacing Verdict** | [Target Met/Too Fast/Stalled] | ... | ... |

## 2. Fleet & Doctrine Analysis
### Terran (P1)
- **Elite Status**: [Successful/Failed] - Erinyes deployment observed at [Time].
- **Capital Pacing**: [e.g., Consistent Orion production vs Over-production of Hecates]

### Shivan (P2)
- **Aggression Profile**: [e.g., High early fighter pressure, stalled on Lilith research]
- **Unit Diversity**: [Review mix of Astaroth, Mara, and Moloch]

### Vasudan (P3)
- **Swarm Density**: [Bomber count peak]
- **Research Path**: [Targeted Hatshepsut at X mins]

## 3. Economic Performance
| Metric | P1 (TER) | P2 (SHI) | P3 (VAS) |
| :--- | :--- | :--- | :--- |
| Peak Income | [RU/min] | [RU/min] | [RU/min] |
| Build Efficiency | [% of RUs spent] | ... | ... |
| Harvester Safety | [Killed/Safe] | ... | ... |

## 4. Balancing & AI Recommendations
### Critical Issues
- **Issue 1**: [Describe issue and evidence from logs]
- **Recommendation**: [e.g., Increase `ter_hecate` build time by 20%]

### Minor Tweaks
- **Tweak 1**: [Describe issue]
- **Recommendation**: [e.g., Adjust `DetermineSpecialDemand` multiplier for `shi_mara`]

## 5. Diagnostic Log Review
[List any engine errors or AI warnings found in `HwRM.log` during this session]

---
**Verification**: Ensure all recommendations are cross-referenced with `resources/fsfc-knowledge/fsfc_ship_balance_sheet.md` before implementation.
