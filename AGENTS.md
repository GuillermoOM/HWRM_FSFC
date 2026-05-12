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
- All family names must exist in `familylist.lua`
- Use `data:` prefix for file paths (e.g., `data:scripts/custom_scripts/myfile.lua`)
- **No `format`**: This is Lua 4.0: no `#table`, no `string.len()`, no `table.insert()`, and **NO `format()`** — use `getn()`, `strlen()`, `tinsert()`, and concatenation (`..`).
- **Ship Counting**: Use `SobGroup_Count("Player_Ships" .. i)` for total fleet counts in rules.

## Full Agent Instructions

See `.gemini/styleguide.md` for the complete system prompt.
