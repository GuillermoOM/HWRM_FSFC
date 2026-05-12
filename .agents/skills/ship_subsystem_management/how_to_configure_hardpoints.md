# Skill: Ship Hardpoint & Subsystem Configuration

## 1. Ensuring Subsystems Load at Spawn
For a subsystem (turret, module, or system) to appear on a ship immediately upon spawning, it must be defined as an **Innate** hardpoint and placed in the **Default Subsystem Slot**.

### Function Signature: `StartShipHardPointConfig`
```lua
StartShipHardPointConfig(
    NewShipType, 
    "HardpointName",     -- Internal name
    "JointName",         -- Name of the joint in the ship's .hod file
    "Type",              -- Weapon, System, Generic, etc.
    "Innate",            -- DisplayType (Innate = spawns with ship)
    "Damageable",        -- Damageable, Indestructible, etc.
    "DefaultSubsystem",  -- (7th param) The subsystem mounted by default
    "Alternative1",      -- (8th param) 1st replacement option
    "Alternative2",      -- (9th param) 2nd replacement option
    ...
)
```

### The "Empty Default" Pitfall
If the 7th parameter is set to an empty string `''`, the engine will mount **nothing** when the ship spawns, even if the DisplayType is set to `Innate` and there are valid subsystems listed in the alternative slots (8th parameter and beyond).

**❌ Incorrect (Will not load at spawn):**
```lua
StartShipHardPointConfig(NewShipType, 'Turret1', 'Joint1', 'Weapon', 'Innate', 'Destroyable', '', 'my_subsystem', '')
```

**✅ Correct (Spawns with subsystem):**
```lua
StartShipHardPointConfig(NewShipType, 'Turret1', 'Joint1', 'Weapon', 'Innate', 'Destroyable', 'my_subsystem', '', '')
```

## 2. Debugging Missing Turrets
If a turret or subsystem is not appearing on a ship:
1.  **Check the Slot**: Ensure the subsystem ID is in the 7th parameter slot of `StartShipHardPointConfig`.
2.  **Verify Innate Type**: Ensure the 5th parameter is `'Innate'`.
3.  **Check Load Order**: `LoadModel(NewShipType, 1)` **must** appear in the `.ship` file BEFORE any `StartShipHardPointConfig` calls.
4.  **Case Sensitivity**: Subsystem IDs (filenames) are case-sensitive.
5.  **Log Verification**: Check `HwRM.log` for `Joint not found` or `Subsystem not found` errors.

## 3. Advanced Pattern: Scripted Nameplates
For hardpoints that are swapped dynamically (like nameplates using `add_nameplate.lua`), it is common to leave the default slot empty (`''`) and list all possible names in the alternative slots. The script will then call `SwapSubsystem` to mount the correct one.
- **Warning**: Do NOT use this pattern for combat-critical turrets unless you have a script explicitly mounting them on spawn.
