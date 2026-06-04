# HOD Weapon Joint Hierarchy

The Homeworld Remastered engine uses a flexible, keyword-based joint hierarchy in the `.hod` file to determine how weapons fire and how turrets animate. The Inverse Kinematics (IK) solver looks for specific suffixes to construct the turret mechanics dynamically.

## The Joint Roles

- **Position** *(Obligatory)*
  - The root anchor of the weapon on the hull.
  - If no `Muzzle` joint is present, the engine spawns the projectile from this joint along its `+Z` axis. If the weapon is a `"Gimbal"`, it shoots in a cone relative to this `+Z` vector.
- **Muzzle** *(Optional)*
  - The exact point where projectiles spawn and weapon fire (`.wf`) effects are rendered.
  - Normally positioned at `+Z` (forward) relative to the `Position` node. The projectile fires along the `+Z` axis of the Muzzle joint.
- **Direction** *(Optional)*
  - Handles the **Yaw** (horizontal tracking).
  - Typically placed at `+Y` relative to the `Position` node to provide a vertical rotation axis for the turret base mesh.
- **Latitude** *(Optional)*
  - Handles the **Pitch** (vertical tracking).
  - Typically placed at `+Y` of the `Position` node, matching the physical "hinges" or trunnions of the turret.
  - **Hierarchy Rule**: If present, it MUST be the parent of the `Muzzle` joint, so the muzzle correctly elevates and depresses with the pitch rotation.
- **Rest** *(Optional)*
  - Defines the idle or "home" orientation of the turret when it is not actively tracking an enemy.
  - Placed at `+Z` of the `Position` node to establish the default forward vector.

## Slave Weapons

If you want a single weapon script (a single hardpoint entry in the `.ship` file) to command multiple synchronized visual turrets on the hull simultaneously, you can use **Slave Weapons**. 

Slave weapons use a separate, parallel node tree in the HOD. The root joint must follow the exact name of the primary weapon, with `Slave` appended to the name (e.g. `Weapon_NameSlave_Position`). 

*Example:*
- Primary Turret Root: `Weapon_HeavyTurret_Position`
- Linked Slave Turret Root: `Weapon_HeavyTurretSlave_Position`

The engine will automatically bind the Slave hierarchy to the primary weapon's targeting logic without requiring an additional `StartShipWeaponConfig` call.
