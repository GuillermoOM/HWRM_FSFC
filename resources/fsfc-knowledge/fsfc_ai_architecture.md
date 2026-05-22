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

## 2. Telemetry and Diagnostic Logging Pattern
To monitor AI progress, military priority shifts, and tech pacing without scope-crossing bugs, the FSFC mod uses a direct, log-based IPC model in `data:scripts/custom_scripts/ai_telemetry.lua`.

Because the HWRM engine isolates AI and SCAR/level scopes, we print formatted, prefix-tagged diagnostics directly to standard output:

- **FSFC_Log_Research(techName, demand)**: Logs a research priority shift, feeding the highest demand value seen in the current cycle into the research accumulator `FSFC_ResearchAccum[techName]`.
- **FSFC_WriteDemandSnapshot()**: serializes and prints current build demand classes (e.g. `DEMAND | F:2 B:1 Fr:1 ...`) directly from the AI script thread, throttled to once per 10s per player.
- **FSFC_WriteResearchSnapshot()**: serializes and prints accumulated research demands (e.g. `RESEARCH_DEMAND | CruiserDesign:5.6 Zeus:4.9 ...`) directly from the upgrades loop using a `next()`-based table loop.

```lua
-- Example: Accumulating research demand in ai_upgrades.lua
if (FSFC_CheckResearch("FighterDesign")) then
    local d = 5.0
    ResearchDemandSet(getglobal("FighterDesign"), d)
    FSFC_Log_Research("FighterDesign", d)  -- Feeds telemetry accumulator
end
```


## 3. Ship Selection & Era Parity
FSFC uses `FSFC_PickBestShip(fs2_variant, fs1_variant)` to handle build logic across match eras. This allows the same AI script to function in both FS1 and FS2 scenarios.

- **Era 1 (FS1)**: AI builds the `fs1_variant`.
- **Era 2 (FS2)**: AI builds the `fs2_variant`.
- **Robustness**: The function includes a safety fallback that ensures a valid ship ID is returned even if research prerequisites are not yet met, or if the primary variant is unavailable.

> [!WARNING]
> Do not use `Util_PickBestShip`. This is a vanilla-style name that is overwritten by the engine in `cpubuild.lua` with a version that only checks `CanBuild()`. This can return `nil` if neither ship is buildable yet, causing fatal `parameter:` engine crashes in `ShipDemandAdd` or `NumSquadrons`. Use `FSFC_PickBestShip` instead.

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

- **Numeric IDs**: All engine-linked functions (`NumSquadrons`, `ResearchDemandSet`) require integer IDs (e.g., `VAS_HORUS`), never string ship names.

## 5. Safe Ship Counting & Parameter Validation

A critical engine quirk in HWRM is that `NumSquadrons(id)` will crash the game with a `parameter:` error if the ID is `nil` or an invalid type.

- **The Solution**: Use the safe wrapper `FSFC_NumSquadrons(id)` defined in `ai_telemetry.lua`. 
- **Gotcha - Initialization Order**: Within `DetermineSpecialDemand`, all ship-count assignments MUST occur at the top of the function. Accessing an unassigned local variable (e.g., `if (num < 10)`) results in a `nil` comparison crash.

```lua
function DetermineSpecialDemand_Terran()
    -- 1. Initialize Counts First
    local numFighters = FSFC_NumSquadrons(kInterceptor)
    
    -- 2. Logic Second
    if (numFighters < 10) then
        ShipDemandAdd(kInterceptor, 1.5)
    end
end
```

## 6. The getglobal Shadowing Trap
A critical pitfall in HWRM AI modding is overwriting engine-provided global variables with strings.

- **The Trap**: If you define `FIGHTERDESIGN = "FighterDesign"` in your script, you are destroying the numeric ID that the engine assigned to that global variable. 
- **The Consequence**: Functions like `ResearchDemandSet(FIGHTERDESIGN, 1.0)` will fail because they receive a string instead of a number.
- **The Solution**: Never assign strings to variables that match research node names. Use safe wrappers and only initialize variables if they are nil.

```lua
-- DO NOT DO THIS:
FIGHTERDESIGN = "FighterDesign" 

-- DO THIS INSTEAD:
if (FIGHTERDESIGN == nil) then FIGHTERDESIGN = -1 end
-- The engine will provide the correct ID if the research exists.
```

## 6. Tactical Counter-Doctrines
The FSFC AI implements several "Elite" behaviors to handle FreeSpace-specific threats like bomber swarms or stealth scouts.

### 6.1 Aegis Doctrine (Reactive Defense)
To prevent the "Cloud of Death" (bomber swarms), the AI monitors enemy fleet composition using `PlayersUnitTypeCount`.
- **Logic**: If `enemyBomberCount` exceeds 20-30, the AI triggers an **Interceptor Surge**.
- **Implementation**: `interceptorDemand` is scaled to **3.5+**, forcing the carrier to prioritize high-performance interceptors (Perseus/Serapis/Manticore) over standard superiority craft.

### 6.2 Recon Doctrine (Battlefield Awareness)
On large ("True Huge") maps, the AI can become passive if it lacks detection.
- **Requirement**: The AI is forced to maintain at least 2 specialized scouts (`kScout`) once its fleet exceeds 10 ships.
- **Activation**: Scouts MUST have `defaultROE = 'Defensive'` and `defaultStance = 'Aggressive'` in their `.ship` file. Without this, the engine's reconnaissance manager will not deploy them for patrol/exploration tasks.
- **Mapping**: Map `kAWACS = kScout` in `CpuBuild_UpdateRaceVariables()`. This ensures the AI utilizes mobile scouts for tactical sensor coverage demand.
- **Implementation**: Explicitly checked in `DetermineSpecialDemand` using `NumSquadrons(kScout)`. This ensures stealth recon units like the **Pegasus** or **Scorpion** are always active and exploring.

### 6.3 Variable Scoping & Parameter Safety
When implementing tactical detection or demand in race scripts:
- **MUST**: Use `s_enemyIndex` and `player_max` for `PlayersUnitTypeCount`.
- **CRITICAL**: Always guard `PlayersUnitTypeCount` with `if (s_enemyIndex ~= -1)`. Passing `-1` to the engine-level counting function causes a fatal crash.
- **CRITICAL**: Ensure all demand variables (e.g., `fighterDemand`) are initialized to a default value before being passed to `ShipDemandAdd`. Passing a `nil` value to `ShipDemandAdd` causes a fatal engine crash.
- **AFFECTED**: `terran/ai_build.lua`, `vasudan/ai_build.lua`, `shivan/ai_build.lua`.

## 7. Logistics & Economic Scaling
To prevent late-game military stagnation, the AI must scale its resource drop-off points alongside its collector count, and utilize standardized wealth boosts to avoid RU hoarding.

- **Refinery Demand**: AI is forced to build at least 2 resource controllers (`kRefinery`) as the economy scales beyond 5,000 RU.
- **Threat Thresholds**: In `cpuresource.lua`, the `UnderAttackThreat()` threshold for building drop-offs is relaxed (e.g., from vanilla -75 to -20). This allows the AI to continue industrial growth during minor combat engagements.
- **Harvester Throttling**: During the first 120 seconds, the AI may slightly penalize `kCollector` demand if no `kScout` is present to ensure early reconnaissance precedes total economic saturation.
- **Standardized Wealth Boosts**: All factions implement a wealth boost at `10,000` RU. If a faction's RU wallet exceeds `10,000`, the AI injects additional demand for carrier (`kCarrier`), capital class, and combat wings (`eFighter`, `eCorvette`) to ensure high-liquidity spending.
- **Emergency builder threshold**: The Shivan emergency builder force-build threshold is standardized to `15,000` RU (down from `25,000` RU) to prevent long periods of lockouts before a builder spawns.

## 8. Game Mode Gating & the DoNotGrant Trap
Gating eras or gameplay-specific tech trees using code-level rules requires specific configuration in `def_research.lua`.

- **The Trap**: Setting `DoNotGrant = 1` on a research item in `def_research.lua` disables the ability for *both* the research interface and the code engine to grant the tech. Calling `Player_GrantResearchOption(playerIndex, node)` will fail silently with `unable to grant (tech)` in the log, permanently lock-out the AI or player from the tech tree, and cause late-game economic stagnation.
- **The Solution**: Comment out `DoNotGrant = 1` for nodes intended to be unlocked via match presets or code rules. Instead, lock or restrict the option initially at match initialization using `Player_RestrictResearchOption`, and subsequently lift the restriction and grant the option via code when the unlock conditions are met.

