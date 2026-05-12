# FSFC AI Architecture & Logic

The FreeSpace: Fleet Command AI uses a modular architecture that overrides vanilla HWRM behaviors to support era-aware fleet composition and sequential research progression.

## 1. Modular Script Structure
AI logic is split across multiple files to allow race-specific tuning while maintaining a shared engine core.

| File | Scope | Purpose |
| :--- | :--- | :--- |
| `cpubuild.lua` | Shared | Core build pipeline and demand management |
| `cpuresearch.lua` | Shared | Research execution and prerequisite checking |
| `ai_build.lua` | Race | Unit-specific demand multipliers and k* variable assignments |
| `ai_upgrades.lua` | Race | Research priorities and tech tree progression |

## 2. Research Logging Pattern
To monitor AI progress without flooding `HwRM.log`, we use a throttled/flagged logging system in `data:scripts/custom_scripts/ai_telemetry.lua`.

- **FSFC_Log_Research(techName)**: Logs the target name only once per player session using a state table.
- **FSFC_Log_Demand(label, demand)**: Logs build intent only if demand > 2.5 (High priority).

```lua
-- Example implementation in ai_upgrades.lua
if (Util_CheckResearch(FIGHTERDESIGN)) then
    ResearchDemandSet(FIGHTERDESIGN, fighterdemand + 1.0)
    FSFC_Log_Research("Apollo") -- Throttled internally
end
```

## 3. Ship Selection & Era Parity
FSFC uses `Util_PickBestShip(fs2_variant, fs1_variant)` to handle build logic across match eras. This allows the same AI script to function in both FS1 and FS2 scenarios.

- **Era 1 (FS1)**: AI builds the `fs1_variant`.
- **Era 2 (FS2)**: AI builds the `fs2_variant`.

These variables must be assigned in `CpuBuild_UpdateRaceVariables()` to ensure they are updated dynamically if the era changes.

## 4. Ship-Based Research Progression
Unlike vanilla HWRM, the FSFC mod strictly enforces sequential tech progression based on **military production** rather than just buying research nodes. 

In `ai_upgrades.lua`, the AI is gated from researching the next tier of tech until it actually produces units from the previous tier:

```lua
-- Only research corvette tech if we've actually built enough fighters to use the tech
local numFighters = NumSquadrons(kInterceptor)
if (numFighters > 3) then
    if (Util_CheckResearch(CORVETTEDESIGN)) then
        ResearchDemandSet(CORVETTEDESIGN, 1.0)
    end
end
```

## 5. Technical Constraints (Lua 4.0)
- **Local Scope**: Never declare `local` variables inside `if` blocks. Declare all locals at the start of functions to avoid parser crashes.
- **Numeric IDs**: All engine-linked functions (`NumSquadrons`, `ResearchDemandSet`) require integer IDs (e.g., `VAS_HORUS`), never string ship names.
