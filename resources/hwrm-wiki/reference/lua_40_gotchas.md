# HWRM Lua 4.0 & SCAR Gotchas

This document tracks engine-specific constraints discovered during development to prevent recurring diagnostic errors.

## 1. Lua 4.0 Compatibility
Homeworld Remastered uses a restricted Lua 4.0 environment.

| Missing/Prohibited | Use Instead |
| :--- | :--- |
| `_G` | `getglobal(name)` |
| `local function Name()` | `function Name()` (Global) or `Name = function()` |
| `strupper(s)`, `strlower(s)`, `strfind(s)` | **NIL in AI Scripts**. Only available in SCAR/Speech. Use `s1 == s2` for direct comparison. |
| `format(str, ...)` | `str .. val .. str` (Concatenation) |
| `#table` | `getn(table)` |
| `string.len(s)` | `strlen(s)` |
| `table.insert(t, v)` | `tinsert(t, v)` |
| `%` (Modulo) | `mod(a, b)` |
| `math.X` | Often available as global `floor()`, `cos()`, etc. |

### 1.1 Local Variable Scope
The HWRM Lua 4.0 parser is extremely sensitive to block-scoped declarations.
- **CRITICAL**: Never declare a `local` variable inside an `if/then/else` block. It will frequently cause a `then expected` or `syntax error` even if the logic is valid.
- **Fix**: Declare all `local` variables at the top of the function or outside the conditional block.

```lua
-- WRONG (Causes Crash)
if (x == 1) then
    local y = 2
end

-- CORRECT
local y = 0
if (x == 1) then
    y = 2
end
```

### 1.2 Function Declarations
- **PROHIBITED**: `local function Name()`. The Lua 4.0 parser expects a variable name after `local` and will throw a syntax error (`<name> expected; last token read: function`).
- **Fix**: Use global `function Name()` or declare the variable first: `local Name; Name = function() ... end`.

## 2. SCAR (Rule) Environment
Functions available in `OnInit` or `Rule_` calls are often different from AI or Ship scripts.

### Ship Counting
- **Prohibited**: `Player_GetNumberOfShips`, `Stats_TotalShipsCount` (Context-dependent/Nil in some modes).
- **Canonical**: `SobGroup_Count("Player_Ships" .. playerIndex)`. The engine automatically maintains these groups for all players.
### 7. Research ID Variable Shadowing
Research IDs in HWRM are provided as global variables (e.g., `FighterDesign = 123`). 

**CRITICAL**: Overwriting these variables with strings (e.g., `FighterDesign = "FighterDesign"`) will break all engine functions that rely on that variable.
- Functions like `IsResearchDone(FighterDesign)` will receive the string and fail.
- Instead, use a safe lookup wrapper that handles both numbers and strings, and never shadow the global variable name.

```lua
-- Safe Initialization Pattern
if (FIGHTERDESIGN == nil) then FIGHTERDESIGN = -1 end
-- This avoids 'nil value' errors while letting the engine provide the correct ID.
```

### Research
- Use `Player_HasResearch(i, "TechName") == 1`.

    print("[AI_DIAG] Initialized for Player " .. s_playerIndex)
end

## 4. SobGroup Functions
- **Filter Case-Sensitivity**: `SobGroup_FilterInclude` and related functions are case-sensitive for the filter type string.
- **Canonical**: Always use camelCase **`"displayFamily"`** or **`"attackFamily"`**. Using PascalCase (`"DisplayFamily"`) will throw a fatal `bad filter type` engine exception.
- **Class Lists**: Use `SobGroup_CountByFilterInclude(group, "displayFamily", "Fighter")`. Valid families are defined in `familylist.lua`.
## 5. Finding Valid Functions (The Source of Truth)
If a function is causing a `nil value` error, check these vanilla files for the correct naming convention:

| Context | Reference File (in `GBXTools/WorkshopTool/uncompressed_bigs/HWRM`) |
| :--- | :--- |
| **Global Rules** | `leveldata/multiplayer/lib/lib.lua` |
| **Match Logic** | `leveldata/multiplayer/lib/main.lua` |
| **Research/RU** | `leveldata/multiplayer/lib/research.lua` |
| **AI Build** | `scripts/ai/default/build.lua` |
| **AI Tech** | `scripts/ai/default/upgrades.lua` |

## 6. Verified "Safe" Functions List

### SCAR (Rules/Levels)
- `Universe_GameTime()`: Returns current match time in seconds.
- `Universe_PlayerCount()`: Returns total players (including observers).
- `Player_IsAlive(i)`: Returns 1 if player is still in the game.
- `Player_GetRU(i)`: Returns current resource count.
- `SobGroup_Count(groupName)`: Returns ship count in a group.
- `PlayerRace_GetString(i, "Prefix", "Default")`: Gets faction prefix (TER, SHI, etc.).

### AI Build/Upgrade
- `ShipDemandMaxByClass(classID)`: Returns the highest demand for a unit type.
- `ResearchDemandSet(techID, demand)`: Manually sets AI priority for a technology.
- `Util_CheckResearch(techID)`: Safe wrapper for checking if research is available.

## 7. AI Script Scoping (Race-Specific Build Scripts)
In `source/scripts/races/[race]/scripts/ai_build.lua`, standard AI variables like `player_enemy` and `player_total` are **not reliably defined** or shared from `cpubuild.lua`.
- **CRITICAL**: Do NOT use `player_enemy` or `player_total` in custom race scripts.
- **Canonical**: Use engine-native globals **`s_enemyIndex`** and **`player_max`** when calling `PlayersUnitTypeCount`.
- **Safety**: Always check if `s_enemyIndex` is not `-1` before performing count logic.
- **Engine Crash**: Passing `nil` or an undefined class constant to `PlayersUnitTypeCount` or `ShipDemandAdd` will cause a fatal engine crash with a `parameter:` stack trace. Always initialize demand variables before use.

## 8. Weapon Tuning: The "Death Ray" Glitch
In `.wepn` files, the interaction between `fireTime` and `burstFireTime` is fragile.
- **BUG**: Setting `fireTime = 0` while having a non-zero `burstFireTime` can cause the engine to miscalculate the cooling cycle, resulting in infinite or glitchy high fire rates (the "Death Ray" effect).
- **Canonical**: Always set a non-zero `fireTime` (minimum `0.1s`) for all weapons, even if they use burst logic.
