# Reference: AI Engine Overrides

This document explains how to safely override the default HWRM AI engine files to implement custom behavior and architectural improvements.

## 1. File Structure
The HWRM AI engine is primarily driven by three files in the `ai/default/` directory:
- `classdef.lua`: Defines the counters and classifications.
- `cpubuild.lua`: Handles military and subsystem construction.
- `cpuresource.lua`: Handles resourcing and economy.

Overriding these files allows a mod to completely redefine how the AI plays the game.

## 2. Best Practices for Overrides

### Maintaining Vanilla Compatibility
When overriding core files like `cpubuild.lua`, use race-specific checks to ensure that vanilla races (Hiigarans, Vaygr) still function correctly if they are included in the mod.
Example:
```lua
-- Check if the current race uses subsystems
if (SelfRace_GetNumber("cfg_buildable_subsystems", 1.0) >= 1.0) then
    -- Hiigaran/Vaygr logic
else
    -- Custom race logic
end
```

### Implementing Custom Hooks
A powerful pattern for engine overrides is adding "Hooks" that allow race-specific scripts to inject logic into the global engine loop.
Example (in `cpubuild.lua`):
```lua
function CpuBuild_Process()
    -- Check if the race script has defined an update hook
    if (CpuBuild_UpdateRaceVariables) then
        CpuBuild_UpdateRaceVariables()
    end
    -- Continue standard processing...
end
```

### Research Nil-Safety
The `IsResearchDone` and `Util_CheckResearch` functions will **crash the engine** if passed a `nil` variable.
- **Rule**: Always perform a nil-check before checking research availability.
```lua
if (MY_TECH_VAR ~= nil and Util_CheckResearch(MY_TECH_VAR)) then
    -- Do logic
end
```

## 3. Advanced resourcing
By overriding `cpuresource.lua`, you can implement custom fallback logic for collectors or refineries. This is essential for mods where resource craft might change based on tech level or era.
