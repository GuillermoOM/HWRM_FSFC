# Skill: Lua 4.0 String Limitations & Detection

## 1. The `strlower` and `strupper` Trap
In Homeworld Remastered, the Lua 4.0 environment used by **AI Scripts** (`ai_build.lua`, `ai_upgrades.lua`, etc.) is more restricted than the one used by **SCAR/Speech Scripts**.

- **CRITICAL**: `strlower()` and `strupper()` are **NIL** in the AI script environment.
- **Symptom**: Calling `strlower(s)` results in a `parameter: attempt to call global 'strlower' (a nil value)` crash.

## 2. Case-Insensitive Keyword Detection
Since you cannot normalize a string or search for substrings, you must use direct string equality (`==`) or perform specific checks if you know the exact string used in the mod.

```lua
-- ✅ Correct (Uses direct equality)
if (researchName == "TacticsDynamic") then
    -- Logical block for tactical nodes
end

-- ❌ Wrong (Crashes AI scripts)
if (strfind(researchName, "actics") ~= nil) then
    -- Fatal Exit: attempt to call global 'strfind' (a nil value)
end
```

## 3. String Table Unavailability
Modern Lua syntax like `string.lower(s)` or `string.find(s, p)` is generally **unsupported** in all HWRM Lua 4.0 contexts. Always use the global functional form:
- `strlen(s)`
- `strsub(s, i, j)`
- `strfind(s, pattern)`
- `tinsert(table, value)`
- `getn(table)`

## 4. Multi-Keyword Detection
If you need to check for multiple possible cases (e.g., both "Aggressive" and "aggressive"), perform sequential `strfind` calls or use a single `strfind` on the unique suffix.

```lua
-- Robust keyword check
local isTactical = (strfind(name, "Tactics") or strfind(name, "tactics") or strfind(name, "cpuplayers"))
```
