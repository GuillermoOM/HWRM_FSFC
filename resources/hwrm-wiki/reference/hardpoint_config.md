# Reference: Hardpoint Configuration

The `StartShipHardPointConfig` function is used to attach subsystems to a ship. These subsystems can be weapons (turrets), systems (like sensors or cloaking), or generic modules.

## Function Signature

```lua
StartShipHardPointConfig(
    NewShipType,      -- The ship object
    HardpointName,    -- String: Unique name for this hardpoint on the ship
    JointName,        -- String: Name of the joint in the .hod file where this attaches
    Type,             -- String: "Weapon", "System", "Generic", "Hardpoint"
    DisplayType,      -- String: "Innate", "Generic", "System", "Weapon"
    Damageable,       -- String: "Damageable", "Indestructible", "Destroyable"
    DefaultSubsystem, -- String: ID of the subsystem mounted by default (CRITICAL)
    AltSubsystem1,    -- String: ID of alternative subsystem (optional)
    AltSubsystem2,    -- ...
    ...
)
```

## Critical Rules

### 1. The Default Slot (7th Parameter)
The engine uses the **7th parameter** to determine what is mounted on the ship when it first spawns. 
- If the `DisplayType` is **`Innate`**, the engine **must** find a valid subsystem ID in this 7th parameter slot to load it.
- If this slot is an empty string `''`, the hardpoint will be empty at spawn, even if alternative subsystems are provided in later slots.

### 2. Loading Order
In the `.ship` file, `LoadModel()` must be called **BEFORE** `StartShipHardPointConfig()`. If the model is not loaded first, the engine will crash because it cannot find the `JointName` on a null model.

### 3. Display Types
- **`Innate`**: The subsystem is part of the ship's base loadout and cannot be swapped in the build menu. It spawns automatically.
- **`Generic` / `System` / `Weapon`**: The subsystem must be built or researched. It will not spawn automatically unless listed in `DefaultSubsystem` and granted by a script or start-ship rule.

### 4. Destruction Behavior
- **`Indestructible`**: The subsystem cannot be targeted or damaged separately from the ship.
- **`Destroyable`**: The subsystem can be targeted and destroyed. If destroyed, the `Innate` turret will disappear visually and stop functioning.

## Common Errors

| Error in Log | Potential Cause |
| :--- | :--- |
| `Joint not found: [Name]` | The `JointName` does not exist in the ship's `.hod` file. |
| `Subsystem not found: [ID]` | The subsystem ID (filename) is misspelled or the file is missing from `data:subsystem/`. |
| Silent Missing Turret | Subsystem ID is in an alternative slot instead of the 7th parameter slot. |
