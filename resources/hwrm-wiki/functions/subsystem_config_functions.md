# Subsystem Configuration Functions

> Functions used in `.subs` files to define subsystem behavior, weapons, multipliers, and granted abilities. All functions operate in the **SubSystem** scope.

---

## StartSubSystemConfig

The primary function for configuring a subsystem. Called once per `.subs` file. This must always be the first non-comment line.

```lua
NewSubSystemType = StartSubSystemConfig()
```

**Returns**: `userdata` — The subsystem configuration table.

**Notes**:
- The returned table is conventionally named `NewSubSystemType`.
- All subsequent subsystem property assignments and function calls reference this table.
- Subsystems are functionally very similar to ships, but are mounted on ship hardpoints.

---

## LoadModel

Loads the HOD (model) file with the same name and directory as the `.subs` file.

```lua
LoadModel(subsystemRef, enable)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `subsystemRef` | userdata | Subsystem table reference (`NewSubSystemType`) |
| `enable` | int | `1` = load model, `0` = skip |

> ⚠️ **CRITICAL**: Similar to ships, `LoadModel` must be called **before** any weapon configs.

---

## LoadSharedModel

Loads a HOD file from a different subsystem's directory.

```lua
LoadSharedModel(subsystemRef, sourceSubsystemName)
```

---

## StartSubSystemWeaponConfig

Mounts a weapon on a subsystem hardpoint. Works exactly identically to `StartShipWeaponConfig`.

```lua
StartSubSystemWeaponConfig(subsystemRef, weaponName, hardpointName, fireAnimation)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `subsystemRef` | userdata | Subsystem table reference (`NewSubSystemType`) |
| `weaponName` | string | Base name of the `.wepn` file |
| `hardpointName` | string | Hardpoint joint name from the HOD model |
| `fireAnimation` | string | Animation name from the `.events` file |

**Example** (from vanilla Hiigaran minelayer turret):
```lua
StartSubSystemWeaponConfig(NewSubSystemType, "Hgn_MinelayerKineticTurret", "Weapon_TurretBottom", "Weapon_TurretBottom")
StartSubSystemWeaponConfig(NewSubSystemType, "Hgn_MineSweeperBurstCannon", "Weapon_TurretBottom", "Weapon_TurretBottom")
```

---

## AddSubSystemMultiplier / AddShipMultiplier

Grants the ship or subsystem the ability to multiply a specific statistic for itself, friendly ships, or enemies within a radius.

```lua
AddSubSystemMultiplier(subsystemRef, modifierType, targetScope, scaleType, minMult, maxMult, radius)
-- OR
AddShipMultiplier(shipRef, modifierType, targetScope, scaleType, minMult, maxMult, radius)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `subsystemRef` | userdata | Subsystem (or ship) table reference |
| `modifierType` | string | Statistic to modify (e.g., `"PrimarySensorsRange"`, `"Speed"`, `"WeaponAccuracy"`) |
| `targetScope` | string | `"ThisShipOnly"`, `"OwnShipsWithinRadius"`, `"OwnShipsWithinRadiusExcludingThisShip"`, or `"EnemyShipsWithinRadius"` |
| `scaleType` | string | `"Linear"` (scales based on subsystem health) or `"None"` (always applies `maxMult`) |
| `minMult` | float | Multiplier applied if scale is `Linear` and subsystem is at 0 health |
| `maxMult` | float | Multiplier applied at 100% health, or always if scale is `None` |
| `radius` | float | Radius in meters. `0` if target is `"ThisShipOnly"` |

**Example** (Advanced sensor array subsystem extending sensor range):
```lua
AddSubSystemMultiplier(NewSubSystemType, "PrimarySensorsRange", "ThisShipOnly", "Linear", 2, 2, 0)
AddSubSystemMultiplier(NewSubSystemType, "SecondarySensorsRange", "ThisShipOnly", "Linear", 2, 2, 0)
```

**Example** (Fleet speed boosting module):
```lua
AddSubSystemMultiplier(NewSubSystemType, "Speed", "OwnShipsWithinRadius", "None", 1.15, 1.15, 4500)
```

---

## AddSubSystemAbility

Grants a specific ability (like Hyperspace or Cloak) to the ship this subsystem is attached to, or to ships within a radius.

```lua
AddSubSystemAbility(subsystemRef, abilityName, enabled, targetScope, radius)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `subsystemRef` | userdata | Subsystem table reference |
| `abilityName` | string | `"Hyperspace"`, `"HyperspaceInhibitor"`, `"Cloak"`, `"DefenseField"` |
| `enabled` | int | `1` = active, `0` = inactive |
| `targetScope` | string | `"ThisShipOnly"` or `"OwnShipsWithinRadius"` |
| `radius` | float | Radius in meters. `0` if target is `"ThisShipOnly"` |

> ⚠️ Note that the ability names here differ slightly from the `addAbility()` function used in `.ship` files.

**Example** (Hyperspace module granting jump capability to nearby ships):
```lua
AddSubSystemAbility(NewSubSystemType, "Hyperspace", 1, "OwnShipsWithinRadius", 3500)
```

**Example** (Hyperspace Inhibitor module):
```lua
AddSubSystemAbility(NewSubSystemType, "HyperspaceInhibitor", 1, "ThisShipOnly", 0)
```

---

## setTargetBox

Defines a targeting box for precise hit detection on the subsystem. Identical to the ship variant.

```lua
setTargetBox(subsystemRef, index, xMin, yMin, zMin, xMax, yMax, zMax)
```
