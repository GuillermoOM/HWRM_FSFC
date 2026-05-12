# Skill: HWRM Engine Debugging & Crash Prevention

## 1. The "parameter:" Error (Runtime Crash)
The error `parameter:` followed by a stack traceback in `HwRM.log` almost always indicates a **nil argument passed to a C-side engine function**.

### Common Culprits
1.  **`ShipDemandAdd(nil, demand)`**: Happens if a ship variable (e.g., `kInterceptor`) is nil.
2.  **`ResearchDemandSet(nil, demand)`**: Happens if a research ID is nil.
3.  **`SobGroup_Count(nil)`**: Happens if a group name is nil.

### Knowledge: Uppercase Global Variables
In this project, ship names MUST be referred to as **uppercase variables** (e.g., `TER_PERSEUS`), not string literals. These variables are mapped to internal engine IDs.
- **The Risk**: If an uppercase variable is used but not defined (returning `nil`), the engine will crash with the `parameter:` error.
- **Verification**: Always ensure the uppercase variable is one of the recognized ship constants.

```lua
-- ✅ Correct Project Convention (Uppercase Variable)
kFighter = TER_PERSEUS 

-- ❌ Avoid (String literals are not used for ship IDs in this project)
kFighter = "ter_perseus" 
```

## 2. Silent FATAL EXIT (Build Menu Crash)
### Symptom
The game suffers a "FATAL EXIT" silently during the load screen or immediately upon skirmish start. The `HwRM.log` abruptly cuts off without a Lua error, usually following a `HOD Trace` for a ship.

### Root Cause
This is almost always caused by a **Subsystem ID Mismatch** in a build definition. If a ship in `def_build.lua` requires a subsystem (`RequiredSubSystems`) that does not exist in the ship's HOD or isn't registered in the subsystem database, the engine crashes while attempting to populate the build UI.

### How to Debug
1. **Trace the Log**: Look at the last `HOD Trace` entry in `HwRM.log`. The ship listed immediately after the trace is likely the culprit.
2. **Binary Search/Purge**: Temporarily clear all `RequiredSubSystems` strings in `def_build.lua`. If the game loads, the error is in one of those strings.
3. **Verify IDs**: Cross-reference the requirement with the `.subs` files and the ship's hardpoints.

## 3. Missing Innate Subsystems (Invisible Turrets)
### Symptom
A ship spawns, but its innate turrets or subsystems (e.g., Flak turrets, modules) are invisible or missing, even if they are defined in the `.ship` file.

### Root Cause
This is often caused by placing the subsystem ID in the **wrong parameter slot** in `StartShipHardPointConfig`. 
- The engine expects the default innate subsystem in the **7th parameter** (the "Default Slot").
- If the 7th parameter is `''`, the engine mounts nothing by default, even if the subsystem is listed in the 8th slot.

### How to Fix
Move the subsystem ID to the 7th parameter:
```lua
-- ✅ Correct
StartShipHardPointConfig(NewShipType, "Name", "Joint", "Type", "Innate", "Damageable", "subsystem_id", "", ...)
```
See the full [Hardpoint Configuration Skill](file:///run/media/system/Data/SteamLibrary/steamapps/common/Homeworld/HWRM_FSFC/.agents/skills/ship_subsystem_management/how_to_configure_hardpoints.md) for more details.


## 4. Unit Capacity Build Lockouts
### Symptom
A ship is researchable and appears in the build menu, but it cannot be built (button is greyed out) or it shows **0/0 capacity** despite no units being built.

### Root Cause
This occurs when one or more families assigned to the ship via `setSupplyValue` in its `.ship` file do NOT have a corresponding `supplyLimit` defined in the active game mode's unit cap files (`scripts/rules/[mode]/unitcaps/*.lua`).
- **Engine Logic**: If a ship has multiple family tags (e.g., `Fighter` and `Scout`), the engine requires a limit > 0 for **ALL** of them. If `Scout` is missing or set to 0, the ship is locked out even if `Fighter` has plenty of capacity.

### How to Fix
1. **Identify Families**: Check the ship's `.ship` file for all `setSupplyValue` calls.
2. **Define Limits**: Ensure every family found is declared in the unit cap files for the current lobby setting (Small, Normal, Large, Huge, and Default).
3. **Verify Indents**: Use `supplyIndent("SubFamily", 1)` to ensure the sub-family correctly nests under its parent in the UI.

```lua
-- Fix for lockout
supplyLimit("Scout", 135)
supplyIndent("Scout", 1)
```

## 5. Best Practices & Logging
- **Case Sensitivity**: Ship IDs in `def_build.lua` are case-sensitive. `vas_tauret` is NOT `vas_Tauret`.
- **Diagnostics**: Use `print()` or `aitrace()` to verify variables before passing them to engine functions.
- **Telemetry**: Check `HwRM.log` for `[AI_DIAG]` tags to see which demand rules are firing before a crash.

```lua
if (kFighter == nil) then
    print("[AI_ERR] kFighter is nil in P" .. s_playerIndex)
else
    ShipDemandAdd(kFighter, demand)
end
```
