# FSFC Stabilization & Diagnostics Guide

This document covers best practices for maintaining engine stability and accurate performance tracking in the FreeSpace: Fleet Command mod.

## 1. Subsystem Hardening
Internal research and logic subsystems (like the flagship research modules) must be protected from user interaction and AI targeting without causing engine crashes.

### The "Ghost Subsystem" Pattern
To make a subsystem completely invisible and non-selectable:
1. **`showInManager = 0`**: Prevents it from appearing in the build/research manager.
2. **`selectionPriority = -1`**: Disables mouse-picking and UI targeting.
3. **Avoid `Inert` flag**: Setting a subsystem to `Inert` in `.subs` will crash the engine if that subsystem contains weapons, nodes, or joints.

```subs
-- Correct hardening in .subs file
showInManager = 0
selectionPriority = -1
```

## 2. Telemetry & Performance Monitoring
Diagnostic logging is handled by `scripts/rules/telemetry.lua`. This script provides a heartbeat of the match status every 30 seconds.

### 3. Dynamic Research Resolution
To prevent engine crashes caused by rigid numeric ID dependencies, always use the `FSFC_CheckResearch` and `FSFC_IsResearchDone` wrappers.

- **Lua 4.0 Warning**: Never use `_G[var]`. Use `getglobal("var")`.
- **Dynamic Lookup**: Research nodes are resolved from strings at runtime to ensure the engine has fully initialized the tech tree.
- **Era Gating**: Use `Util_PickBestShip(fs2_variant, fs1_variant)` for construction. It automatically handles era-based selection via research status or `era_setting` fallbacks.

```lua
-- Correct Usage
if (FSFC_CheckResearch("FighterDesign")) then
    ResearchDemandSet(getglobal("FighterDesign"), 1.5)
end
```

### 4. Common Engine Gotchas (Lua 4.0)
- **No Table Length Operator**: Use `getn(mytable)` instead of `#mytable`.
- **No string.len**: Use `strlen(mystr)`.
- **No format**: Use string concatenation `..`.
- **Global Access**: Use `getglobal()` and `setglobal()`.

### SobGroup Filter Casing
Engine-native filter functions in `telemetry.lua` are strictly case-sensitive for the filter type argument.
- **Display Family**: Must use **`"displayFamily"`**.
- **Attack Family**: Must use **`"attackFamily"`**.
- **Consequence**: Using `"DisplayFamily"` (PascalCase) will cause a fatal runtime exception.

### Unit Class Tracking
To track resource units accurately in telemetry, include the following classes in `SobGroup_FilterInclude`:
- `Utility` (Resource Collectors)
- `Platform` (Repair Satellites/Mines)

## 3. Engine Exception Troubleshooting
Common fatal errors encountered during FSFC stabilization:

| Error String | Cause | Resolution |
| :--- | :--- | :--- |
| `then expected` | `local` declared inside `if` block | Move `local` to function start |
| `bad filter type` | Incorrect casing in `SobGroup_FilterInclude` | Use `displayFamily` (camelCase) |
| `parameter:` | `nil` passed to `NumSquadrons` | Ensure `k*` variables are assigned early |
| `HOD: path not found` | Missing `.hod` file or pathing error | Check `LoadModel()` path in `.ship` |
