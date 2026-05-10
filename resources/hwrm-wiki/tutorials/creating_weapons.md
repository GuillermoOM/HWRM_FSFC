# Creating a New Weapon

> A step-by-step guide to configuring, balancing, and attaching custom weapons to ships using `.wepn` and `.weaponfire` scripts.

---

## 1. Defining the Weapon

Weapon parameters govern range, damage, rate of fire, and targeting behavior. They are defined in `.wepn` files located in `Data/Weapon/`.

1. Create a new directory and file for your weapon: `my_mod\weapon\my_custom_laser\my_custom_laser.wepn`
2. Open the file and start with the core initialization function:
   ```lua
   StartWeaponConfig(NewWeaponType, "Fixed", "Sphere", "Laser", "Normal", 0, 4500, 0, 0.1, 0, 0, 1, 0, 1, 3, 0, 0, 1, 1, 120, 120, 0.1, "Normal", 1, 0, 0);
   ```

### Core Configuration Arguments
Due to the strict nature of `StartWeaponConfig`, the arguments **must** follow exact positional mapping. Key parameters include:
- **Arg 2 (Weapon Type)**: `"Fixed"` (fires straight), `"Gimbal"` (turreted), or `"AnimatedTurret"`.
- **Arg 3 (Activation Type)**: `"Sphere"` (fires if target is within range) or `"Cone"` (target must be within a firing arc).
- **Arg 4 (Family)**: e.g., `"Laser"`, `"Kinetic"`, `"Missile"`. Must match an effects family.
- **Arg 5 (Armor Penetration)**: `"Normal"`, `"Enhanced"`, or `"Bypass"`.
- **Arg 7 (Max Range)**: The maximum firing distance in meters.
- **Arg 10 (Fire Rate)**: Firing delay in seconds.
- **Arg 15 (Damage)**: Base damage per shot.

### Penetration Multipliers
After initializing the weapon, append penetration rules to define how effective the weapon is against specific armor types defined in `familylist.lua`:
```lua
AddWeaponPenetrationRule(NewWeaponType, "HeavyArmour", 0.50);
AddWeaponPenetrationRule(NewWeaponType, "Unarmoured", 1.20);
```

### Accuracy Multipliers
Define how accurately the weapon tracks and hits specific ship types:
```lua
AddWeaponAccuracyRule(NewWeaponType, "Fighter", 0.10);
AddWeaponAccuracyRule(NewWeaponType, "Corvette", 0.35);
AddWeaponAccuracyRule(NewWeaponType, "Capital", 0.99);
```

## 2. Defining the Visuals (WeaponFire)

A weapon needs visual and auditory effects to render in the game engine. This is handled by `.weaponfire` files located in `Data/Scripts/WeaponFire/`.

1. Create a matching file: `my_mod\scripts\weaponfire\my_custom_laser\my_custom_laser.wf`
2. Define the impact and beam effects:
   ```lua
   hitfx = "hit_generic"
   bulletfx = "beam_laser_blue"
   nopenetratefx = "hit_ricochet"
   scartype = "Plasma_Hit"
   hit_sfx = "WEAPON/FIGHTER/IMPACT/WEAPON_FIGHTER_PLASMA_CANNON_BEAM_HIT"
   ```

*Note: The `.wf` file name MUST exactly match the Weapon Family parameter provided in `StartWeaponConfig` or the specific weapon name itself.*

## 3. Attaching the Weapon to a Ship

Now that the weapon exists, you must mount it to a ship using `StartShipWeaponConfig()` in the ship's `.ship` file.

1. Open the target ship file, e.g., `my_mod\ship\hgn_interceptor\hgn_interceptor.ship`
2. **Crucial Engine Rule**: `LoadModel()` **MUST** be called before `StartShipWeaponConfig()`.
3. Add the weapon mount line:
   ```lua
   StartShipWeaponConfig(NewShipType, "my_custom_laser", "Weapon_HullDefense", "Weapon_HullDefense");
   ```
   - **Arg 1**: The global `NewShipType` object.
   - **Arg 2**: The name of your weapon (`my_custom_laser.wepn`).
   - **Arg 3 & 4**: The `.hod` joint names on the 3D model where the weapon physically fires from.

## 4. Troubleshooting Weapons

- **Weapon won't fire**: Check the ship's `AttackStyles`. If the ship never maneuvers to place the target within the weapon's cone or range, the weapon will never trigger.
- **Game crashes immediately**: You likely placed `StartShipWeaponConfig` above `LoadModel` in the `.ship` file, or missed a parameter in the `StartWeaponConfig` definition.
- **Invisible lasers**: Check your `.wf` script and ensure the `bulletfx` string points to a valid `.fx` effect.
