# HWRM_FSFC — AI Agent Instructions

This is a **Homeworld Remastered** total conversion mod (FreeSpace: Fleet Command).

## Quick Context

- **Engine**: Lua 4.0 scripting on top of the HWRM engine
- **Races**: Terran (`ter_`), Vasudan (`vas_`), Shivan (`shiv_`)
- **Mod source**: `source/` — all game-affecting files
- **FSFC Knowledge base**: `resources/fsfc-knowledge/` — 2 structured reference documents
- **HWRM Wiki Reference**: `resources/hwrm-wiki/` — structured modding documentation (functions, variables, rules, tutorials)
- **Vanilla reference**: Sibling workspace `HWRM/` — original game scripts (read-only)
- **Templates**: `resources/script_templates/` — canonical file templates
- **Original Mod Resources (Extracted BIG)**: `/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld 347380/GBXTools/WorkshopTool/uncompressed_bigs/freespace_remastered` - for any missing references in local knowledge base that could be added, these are the original mod files where I'm fixing and remastering from (read only)
- **Original Game Resources (Extracted BIG)**: `/run/media/system/Data/SteamLibrary/steamapps/common/Homeworld 347380/GBXTools/WorkshopTool/uncompressed_bigs/HWRM` - for any missing references in local knowledge base that could be added (read only), these are the original files of the game. if a ship or script is missing from the mod files, check here for the original file.

## Before Coding

1. Read the relevant Knowledge Item from `resources/fsfc-knowledge/`
2. Check existing mod files for naming conventions and patterns
3. Verify family names against `source/scripts/familylist.lua`
4. When uncertain, cross-reference with vanilla files in `HWRM/`

## Critical Rules

- **Check Gotchas First**: Read `resources/hwrm-wiki/reference/lua_40_gotchas.md` before writing SCAR or AI code.
- `.ship` file variable order matters — wrong order = crash (see `resources/hwrm-wiki/reference/ship_order.md`)
- `LoadModel()` MUST precede weapon/hardpoint configs
- **Innate Hardpoints**: Subsystems must be in the 7th parameter (Default Slot) of `StartShipHardPointConfig` to load at spawn.

- All family names must exist in `familylist.lua`
- Use `data:` prefix for file paths (e.g., `data:scripts/custom_scripts/myfile.lua`)
- **No `format`**: This is Lua 4.0: no `#table`, no `string.len()`, no `table.insert()`, no `_G` (use `getglobal()`), no `local function` (use `function Name()`), and **NO `format()`** — use `getn()`, `strlen()`, `tinsert()`, and concatenation (`..`).
- **Ship Counting**: Use `SobGroup_Count("Player_Ships" .. i)` for total fleet counts in rules.
- **AI Scoping**: In custom race `ai_build.lua` scripts, use `s_enemyIndex` and `player_max` for `PlayersUnitTypeCount`. Standard variables like `player_enemy` are often nil.
- **Weapon Burst Bug**: Always set `fireTime` to at least `0.1s` in `.wepn` files. A `0` fireTime with non-zero burst causes infinite fire rates.
- **No Closures in Lua 4.0**: `foreach` callbacks CANNOT capture outer `local` variables (upvalues). This causes a load-time crash: `cannot access a variable in outer scope`. Use `next(table)` / `next(table, key)` loops instead. See gotcha #9 and `.agents/skills/lua_40_closure_restriction/`.
- **Knowledge Integrity**: When discovering new engine quirks or tactical patterns, update `resources/hwrm-wiki/` and `resources/fsfc-knowledge/` immediately. Also add any necessary references to this instruction file, `AGENTS.md`, and the `rules` and `gotchas` markdown files in `resources/hwrm-wiki/`. Including `.agents/rules/code-style-guide.md` and `.agents/skills/skill_name/` if this will make any future agent more efficient and aware of common development mistakes.

## Skills & Automation

Specialized patterns for common FSFC modding tasks:
- **Built-Ship Dependent Tech Tree**: Patterns for `def_research.lua` and `ai_upgrades.lua` to enforce ship-by-ship progression. [Skill](.agents/skills/ship_dependent_tech_tree/how_to_implement.md)
- **Batch Updating Prerequisites**: Python automation for `def_build.lua`. [Skill](.agents/skills/batch_update_build_prerequisites/script_template.md)
- **Hardpoint & Subsystem Management**: Patterns for `StartShipHardPointConfig` and innate loading. [Skill](.agents/skills/ship_subsystem_management/how_to_configure_hardpoints.md)
- **AI Reconnaissance Priority**: Ensuring map vision through high-priority early scouting and harvester throttling. [Skill](.agents/skills/ai_reconnaissance_priority/how_to_prioritize.md)
- **Unit Capacity Configuration**: Standardizing `getShipNum` wrappers and wing-based supply scaling. [Skill](.agents/skills/unit_capacity_configuration/how_to_configure.md)
- **AI Research Balancing**: Systematic auditing of tech pacing using the `extract_ship_stats.py` tool. [Skill](.agents/skills/ai_research_balancing/how_to_balance.md)
- **AI Research ID Resolution**: Patterns for mapping engine-provided tactical nodes and stance management. [Skill](.agents/skills/ai_research_id_resolution/resolution_patterns.md)
- **AI Production Optimization**: Patterns for preventing build-stalls and managing logistics scaling. [Skill](.agents/skills/ai_production_optimization/how_to_prevent_stalls.md)
- **Lua 4.0 String Limitations**: Workarounds for missing `strlower`/`strupper` and robust keyword detection. [Skill](.agents/skills/lua_40_string_limitations/string_patterns.md)
- **Lua 4.0 Closure Restriction**: No upvalue capture in `foreach` callbacks — use `next()` loops instead. [Skill](.agents/skills/lua_40_closure_restriction/no_upvalue_capture.md)
- **AI Telemetry Snapshot System**: Direct demand + research snapshot printing pattern for `ai_telemetry.lua` and parsing in `realtime_telemetry.py`/`timeline_analysis.py`. [Skill](.agents/skills/ai_telemetry_snapshot/how_to_implement.md)
- **Ship Sensor Standardization**: Synchronizing FSFC ship sensor ranges with HWRM vanilla equivalents using extraction tools. [Skill](.agents/skills/ship_sensor_standardization/how_to_standardize.md)
- **Era-Gated Research Management**: Safe granting of global era-nodes to specific factions without utilizing `DoNotGrant = 1` engine blocks. [Skill](.agents/skills/era_gated_research_management/how_to_implement.md)
- **AI Era Selection**: Selecting correct ship variants based on current active match era. [Skill](.agents/skills/ai_era_selection/how_to_implement.md)
- **AI Fleet Diversification**: Throttling fighter demand to enforce high-priority elite variants and balancing fleet composition. [Skill](.agents/skills/ai_fleet_diversification/how_to_implement.md)
- **AI HWRM Debugging**: Systematic identification and tracing of engine-level nil comparison and `parameter:` crashes. [Skill](.agents/skills/ai_hwrm_debugging/how_to_debug.md)
- **AI Parallel Research**: Implementing parallel queue pacing inside `ai_upgrades.lua`. [Skill](.agents/skills/ai_parallel_research/how_to_implement.md)
- **Era-Specific Ship Refactoring**: Step-by-step refactoring workflows for outdated ship configuration presets. [Skill](.agents/skills/era_specific_ship_refactoring/pattern_guide.md)
- **Game Mode Content Gating**: Mechanics for gating and locking custom content depending on active rule configurations. [Skill](.agents/skills/game_mode_exclusive_content_gating/how_to_gate.md)
- **Race Assignment Verification**: Validating custom race characteristics and script boundaries at match startup. [Skill](.agents/skills/race_assignment_verification/how_to_verify.md)



## Full Agent Instructions

See `.gemini/styleguide.md` for the complete system prompt.
