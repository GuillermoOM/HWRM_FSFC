# HWRM Lua 4.0 & SCAR Gotchas

This document tracks engine-specific constraints discovered during development to prevent recurring diagnostic errors.

## 1. Lua 4.0 Compatibility
Homeworld Remastered uses a restricted Lua 4.0 environment.

| Missing/Prohibited | Use Instead |
| :--- | :--- |
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

## 2. SCAR (Rule) Environment
Functions available in `OnInit` or `Rule_` calls are often different from AI or Ship scripts.

### Ship Counting
- **Prohibited**: `Player_GetNumberOfShips`, `Stats_TotalShipsCount` (Context-dependent/Nil in some modes).
- **Canonical**: `SobGroup_Count("Player_Ships" .. playerIndex)`. The engine automatically maintains these groups for all players.

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
