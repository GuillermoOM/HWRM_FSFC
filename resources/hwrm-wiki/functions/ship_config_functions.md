# Ship Configuration Functions

> Functions used in `.ship` files to define ship properties, load models, attach weapons/subsystems, configure abilities, and set visual effects. All functions operate in the **Object** and **Ship** scopes.

---

## StartShipConfig

Instantiates and returns a ship object table. This must always be the first non-comment line in a `.ship` file.

```lua
NewShipType = StartShipConfig()
```

**Returns**: `userdata` — The ship configuration table.

**Notes**:
- The returned table is conventionally named `NewShipType`.
- All subsequent ship property assignments and function calls reference this table.

**See also**: [StartMissileConfig](#), [StartSubSystemConfig](#)

---

## LoadModel

Loads the HOD (model) file with the same name and directory as the `.ship` file.

```lua
LoadModel(shipRef, enable)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference (`NewShipType`) |
| `enable` | int | `1` = load model, `0` = skip |

> ⚠️ **CRITICAL**: `LoadModel` must be called **after** all variable assignments and `addAbility` calls, but **before** any `StartShipWeaponConfig` or `StartShipHardPointConfig` calls. Incorrect placement causes docking path errors and crashes.

**Example**:
```lua
LoadModel(NewShipType, 1)
```

---

## LoadSharedModel

Loads a HOD file from a different ship's directory instead of using its own.

```lua
LoadSharedModel(shipRef, sourceShipName)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference (`NewShipType`) |
| `sourceShipName` | string | Name of the ship whose HOD to use |

**Example** (from vanilla):
```lua
-- hgn_targetdrone shares the Hgn_Probe model
LoadSharedModel(NewShipType, "Hgn_Probe")

-- tai_researchship_2 shares the tai_researchship_1 model
LoadSharedModel(NewShipType, "Tai_ResearchShip_1")
```

---

## addAbility

Attaches a functional behavior to a ship. See the dedicated [addAbility reference](../reference/addability_reference.md) for all ability types.

```lua
addAbility(shipRef, abilityName, ...)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference (`NewShipType`) |
| `abilityName` | string | Ability type name |
| `...` | varies | Ability-specific parameters |

### Common Abilities Quick Reference

| Ability | Signature | Purpose |
|---------|-----------|---------|
| `MoveCommand` | `(ship, "MoveCommand", active, oneShot)` | Basic movement |
| `CanDock` | `(ship, "CanDock", active, byPlayer)` | Docking capability |
| `CanLaunch` | `(ship, "CanLaunch")` | Launch docked ships |
| `CanAttack` | `(ship, "CanAttack", active, microFormSize, kamikaze, interpolate, splitDelay, distMult, families, defaultStyle, {overrides...})` | Combat |
| `CanBuildShips` | `(ship, "CanBuildShips", active, buildFamilies, displayFamilies)` | Ship production |
| `ShipHold` | `(ship, "ShipHold", active, dropoffRate, holdSize, rallyEffect, dockFamilies, repairRate, {rateOverrides...})` | Docking bay |
| `HyperSpaceCommand` | `(ship, "HyperSpaceCommand", active, costFactor, costMin, costMax, recoveryTime, transitTime)` | Hyperspace |
| `GuardCommand` | `(ship, "GuardCommand", active, range, minRange)` | Guard behavior |
| `ParadeCommand` | `(ship, "ParadeCommand", active)` | Parade formation |
| `WaypointMove` | `(ship, "WaypointMove")` | Waypoint pathing |
| `RetireAbility` | `(ship, "RetireAbility", active, refundPercent)` | Retire for RU |
| `CustomCommand` | `(ship, "CustomCommand", enabled, name, unk1, unk2, capacity, cutoff, cost, regen, minReactivate, scriptPath, startFn, doFn, finishFn, groupName, interval, iconIndex, latent)` | Custom scripted ability |
| `CloakAbility` | `(ship, "CloakAbility", active, strength, radius, cutoff, usage, cost, regen, minEnergy)` | Cloaking |
| `DefenseFieldAbility` | `(ship, "DefenseFieldAbility", active, engaged, radius, usage, cutoff, cost, regen, minimum, effect)` | Defense field |
| `CaptureCommand` | `(ship, "CaptureCommand", active)` | Capture enemies |
| `SalvageCommand` | `(ship, "SalvageCommand", active)` | Salvage wrecks |
| `Harvest` | `(ship, "Harvest", active)` | Resource collection |
| `SensorPing` | `(ship, "SensorPing", active)` | Sensor ping |
| `MinelayerAbility` | `(ship, "MinelayerAbility", active, ...)` | Mine deployment |

---

## addCustomCode

Attaches a custom Lua script to a ship type, allowing lifecycle hooks (load, create, update, destroy) to run custom logic.

```lua
addCustomCode(shipRef, scriptPath, loadFn, createFn, updateFn, destroyFn, groupName, updateInterval)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference (`NewShipType`) |
| `scriptPath` | string | Path to Lua script (use `data:` prefix) |
| `loadFn` | string | Function called during loading screen (no params). Use `""` to skip |
| `createFn` | string | Function called when ship spawns. Receives `(sobGroup, playerIndex, shipID)`. Use `""` to skip |
| `updateFn` | string | Function called periodically for every living squadron. Same params as create. Use `""` to skip |
| `destroyFn` | string | Function called when ship dies. Same params as create. Use `""` to skip |
| `groupName` | string | Name of the SobGroup passed as first param to hooks. If `""`, defaults to `Player_Ships#` |
| `updateInterval` | float | Seconds between `updateFn` calls. Minimum `0.1` |

> ⚠️ **This function may only be called once per `.ship` file.** To run multiple scripts, create a wrapper script that uses `dofilepath()` to import others.

**Example** (repair corvette with proximity healing):
```lua
-- In kus_repaircorvette.ship:
addCustomCode(NewShipType, "data:ship/kus_repaircorvette/kus_repaircorvette.lua",
    "", "", "update", "", "kus_repaircorvette", 1)

-- In kus_repaircorvette.lua:
function update(group, player_index, ship_id)
    SobGroup_CreateIfNotExist("closeby_player_ships")
    Player_FillProximitySobGroup("closeby_player_ships", 0, group, 2000)
    SobGroup_RepairSobGroup(group, "closeby_player_ships")
end
```

**Vanilla examples**:
```lua
-- Bentusi exchange ship
addCustomCode(NewShipType, "data:Ship/Ben_BentusiExchange/Ben_BentusiExchange.lua",
    "", "", "Update_Ben_BentusiExchange", "", "Ben_BentusiExchange", 30)

-- Kadeshi multibeam frigate
addCustomCode(NewShipType, "data:ship/Kad_MultiBeamFrigate/Kad_MultiBeamFrigate.lua",
    "", "", "updateKad_MultiBeamFrigate", "", "Kad_MultiBeamFrigate", 1.25)
```

---

## setTacticsMults

Sets multipliers applied to a stat when the ship is in Aggressive, Evasive, or Neutral stance.

```lua
setTacticsMults(shipRef, modifier, aggressive, evasive, neutral)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference (`NewShipType`) |
| `modifier` | string | Stat to modify (see table below) |
| `aggressive` | float | Multiplier in Aggressive stance |
| `evasive` | float | Multiplier in Evasive stance |
| `neutral` | float | Multiplier in Neutral stance (usually `1.0`) |

### Valid Modifier Values

| Modifier | Effect |
|----------|--------|
| `MAXSPEED` | Maximum movement speed |
| `ENGINEACCEL` | Engine acceleration |
| `ENGINEBRAKE` | Engine braking |
| `THRUSTER` | Thruster speed |
| `THRUSTERACCEL` | Thruster acceleration |
| `THRUSTERBRAKE` | Thruster braking |
| `ROTATION` | Rotation speed |
| `ROTATIONACCEL` | Rotation acceleration |
| `ROTATIONBRAKE` | Rotation braking |
| `WEAPONACCURACY` | Weapon accuracy |
| `WEAPONDAMAGE` | Weapon damage output |
| `BULLETSPEED` | Projectile speed |
| `DAMAGEAPPLIED` | Damage received (>1 = take more) |
| `FIRERATE` | Rate of fire |
| `EXPIRETIME` | Missile/projectile lifetime |

**Notes**:
- Missiles inherit the launching ship's current stance at launch time.
- Typical pattern: Aggressive boosts damage, Evasive boosts speed/reduces damage taken.

**Example**:
```lua
setTacticsMults(NewShipType, "MAXSPEED",       1.0,  1.10, 1.0)
setTacticsMults(NewShipType, "WEAPONDAMAGE",   1.20, 0.95, 1.0)
setTacticsMults(NewShipType, "DAMAGEAPPLIED",  1.10, 0.85, 1.0)
```

---

## setSpeedvsAccuracyApplied

Configures how the ship's own movement speed affects incoming weapon accuracy against it.

```lua
setSpeedvsAccuracyApplied(shipRef, enabled, speed1, acc1, speed2, acc2, ...)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference |
| `enabled` | int | `1` = enabled, `0` = disabled |
| `speedN` | float | Speed threshold (m/s) |
| `accN` | float | Accuracy multiplier at that speed |

Speed/accuracy pairs define a curve: faster ship = harder to hit.

**Example** (from vanilla interceptor):
```lua
setSpeedvsAccuracyApplied(NewShipType, 1, 0.0, 1.0, 0.5, 0.95, 1.0, 0.85, 1.5, 0.60)
```

---

## setSupplyValue

Sets the unit cap supply value for a ship within a given cap family.

```lua
setSupplyValue(shipRef, capFamily, value)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference |
| `capFamily` | string | Unit cap family name (from `unitcapsaliases.lua`) |
| `value` | float | Supply cost |

**Example**:
```lua
setSupplyValue(NewShipType, "Fighter", 5.0)
setSupplyValue(NewShipType, "LayoutFighter", 5.0)
```

---

## StartShipWeaponConfig

Mounts a weapon on a ship hardpoint.

```lua
StartShipWeaponConfig(shipRef, weaponName, hardpointName, fireAnimation)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference (`NewShipType`) |
| `weaponName` | string | Base name of the `.wepn` file (without extension) |
| `hardpointName` | string | Hardpoint joint name from the HOD model |
| `fireAnimation` | string | Animation name from the `.events` file |

> ⚠️ Must be called **after** `LoadModel()`. Multiple weapons can share the same hardpoint only if they are `Gimble` or `Fixed` type.

**Notes**:
- Turrets with two barrels should only call this once — the turret handles both barrels.
- Do not mount multiple `AnimatedTurret` weapons on the same hardpoint.

**Example**:
```lua
StartShipWeaponConfig(NewShipType, "Hgn_KineticAutoGun", "Weapon_FrontGun", "Fire")
```

**Subsystem variant** (used in `.subs` files):
```lua
StartSubSystemWeaponConfig(NewSubSystemType, "Hgn_BattleCruiserTurretedIonCannon", "Weapon_IonCan1", "Weapon_IonCan1")
```

---

## StartShipHardPointConfig

Defines a hardpoint slot on a ship for mounting subsystems.

```lua
StartShipHardPointConfig(shipRef, hardpointName, jointName, hardpointType,
    hardpointFamily, healthType, defaultSubsystem,
    fittingSS1, fittingSS2, fittingSS3, fittingSS4,
    fittingSS5, fittingSS6, fittingSS7, fittingSS8)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference |
| `hardpointName` | string | Name of the hardpoint |
| `jointName` | string | Joint name in the HOD model |
| `hardpointType` | string | `"Weapon"`, `"Production"`, or `"System"` |
| `hardpointFamily` | string | `"Innate"`, `"Production"`, `"Sensors"`, or `"Generic"` |
| `healthType` | string | `"Indestructible"`, `"Damageable"`, or `"Destroyable"` |
| `defaultSubsystem` | string | Subsystem present when ship is built (`""` for none) |
| `fittingSS1-8` | string | Subsystems that can be built on this hardpoint (`""` for unused slots) |

> ⚠️ Must be called **after** `LoadModel()`. The hardpoint joint should exist in the HOD file.

**Example** (Vaygr carrier production hardpoint):
```lua
StartShipHardPointConfig(NewShipType, "Production 1", "HardPoint_Production1",
    "System", "Production", "Destroyable", "",
    "Vgr_C_Production_Fighter", "Vgr_C_Production_Corvette",
    "Vgr_C_Production_Frigate", "", "", "", "", "")
```

---

## addShield

Adds a shield to a ship.

```lua
addShield(shipRef, shieldType, hitpoints, regenRate)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference |
| `shieldType` | string | Shield type: `"EMP"`, `"Defence"`, or other |
| `hitpoints` | int | Shield HP |
| `regenRate` | float | HP regenerated per second |

**Example**:
```lua
addShield(NewShipType, "EMP", 75, 20)
```

---

## setTargetBox

Defines a targeting box for precise hit detection on a ship or subsystem.

```lua
setTargetBox(shipRef, index, xMin, yMin, zMin, xMax, yMax, zMax)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship/subsystem table reference |
| `index` | int | Target box index (0-7, up to 8 per ship) |
| `xMin/yMin/zMin` | float | Min corner (-1 to 1, proportional to collision mesh bounding box) |
| `xMax/yMax/zMax` | float | Max corner (-1 to 1) |

**Scope**: Object, Ship, SubSystem

**Example**:
```lua
setTargetBox(NewShipType, 0, -0.32, -0.95, -0.75, 0.33, 0.001, 0.7)
```

---

## setConcurrentBuildLimit

Sets how many build queues a production ship can run simultaneously.

```lua
setConcurrentBuildLimit(shipRef, buildType, queueCount)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference |
| `buildType` | int | `0` = can build multiple ships, `1` = cannot |
| `queueCount` | int | Number of concurrent build queues |

**Example** (carrier with 2 queues):
```lua
setConcurrentBuildLimit(NewShipType, 0, 2)
```

---

## setEngineTrail

Configures ribbon trail effects behind engines.

```lua
setEngineTrail(shipRef, index, lingerTime, textureName, bulgeFreq, scrollFactor, scaleFactor, diameterFactor)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship or missile table reference |
| `index` | int | Trail index (0-based, one per engine nozzle) |
| `lingerTime` | float | How long the trail persists (seconds) |
| `textureName` | string | Texture file from `effect/trails/` |
| `bulgeFreq` | float | Frequency of trail pulsing |
| `scrollFactor` | float | Texture scroll speed |
| `scaleFactor` | float | Texture scale |
| `diameterFactor` | float | Trail thickness |

**Scope**: Object, Ship, Missile

> ⚠️ The HOD joint must start at `EngineNozzle1` (not `EngineNozzle0`).

**Example** (fighter trail):
```lua
setEngineTrail(NewShipType, 0, 4, "trail_ribbon.tga", 0.001, 0.5, 0.025, 6)
setEngineTrail(NewShipType, 1, 4, "trail_ribbon.tga", 0.001, 0.5, 0.025, 6)
```

---

## setEngineBurn

Configures engine burn flare effects (sparks and corona at nozzle).

```lua
setEngineBurn(shipRef, sparksPerPath, speedLow, speedHigh, sparkSize, speedSparkSize, flareMin, flarePos, flareSize)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship or missile table reference |
| `sparksPerPath` | int | Number of flare particles forming the jet |
| `speedLow` | float | Jet opacity when using thrusters |
| `speedHigh` | float | Jet opacity when using main engines |
| `sparkSize` | float | Diameter of individual spark particles |
| `speedSparkSize` | float | Diameter of speed pulse traveling down jet (multiplier of `sparkSize`, e.g. `1.1` = 10% larger) |
| `flareMin` | float | Unknown effect (changing shows no visible difference) |
| `flarePos` | float | Offset distance from engine nozzle in HOD (≥0) |
| `flareSize` | float | Diameter of static corona flare |

**Scope**: Object, Ship, Missile

**Example** (fighter):
```lua
setEngineBurn(NewShipType, 15, 0.5, 1, 15, 0, 0.7, 0.1, 25)
```

**Example** (capital ship):
```lua
setEngineBurn(NewShipType, 9, 0.2, 0.5, 300, 1.02, 0.1, 0.25, 380)
```

---

## setEngineGlow

Configures engine glow mesh effect (typically used on capital ships).

```lua
setEngineGlow(shipRef, maxTranslation, flickerMin, flickerMax, flickerFreq, blurStartDist, blurFullDist, maxBlur, glowColour)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference |
| `maxTranslation` | float | Maximum translation offset |
| `flickerMin` | float | Minimum flicker intensity |
| `flickerMax` | float | Maximum flicker intensity |
| `flickerFreq` | float | Flicker frequency |
| `blurStartDist` | float | Distance at which blur begins |
| `blurFullDist` | float | Distance at which blur is at maximum |
| `maxBlur` | float | Maximum blur amount |
| `glowColour` | table | `{R, G, B, A}` color values (0-1) |

> ℹ️ Parameter names sourced from EXE disassembly — not all are fully verified.

**Example** (blue glow for Hiigaran-style ships):
```lua
setEngineGlow(NewShipType, 1, 1, 1.02, 20, 300, 50, 1.5, {0.27, 0.47, 0.69, 0.25})
```

**Example** (orange glow for Kadeshi ships):
```lua
setEngineGlow(NewShipType, 1, 1, 1.02, 20, 300, 50, 1.5, {0.95, 0.35, 0.18, 0.10})
```

---

## SpawnSalvageOnDeath

Spawns debris objects when a ship is destroyed.

```lua
SpawnSalvageOnDeath(shipRef, debrisName, chunkCount, ruPercent,
    spawnX, spawnY, spawnZ,
    spawnRandX, spawnRandY, spawnRandZ, spawnRand,
    rotX, rotY, rotZ, rotRand,
    tumbleX, tumbleY, tumbleZ, tumbleRand)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference |
| `debrisName` | string | Debris type from `Data/Resource/Salvage/` |
| `chunkCount` | int | Number of debris objects to spawn |
| `ruPercent` | float | Percentage of ship's RU value in this debris (governed by `buildCost` × multiplier in `tuning.lua`) |
| `spawnX/Y/Z` | float | Spawn offset from ship center |
| `spawnRandX/Y/Z` | float | Random spawn position variation |
| `spawnRand` | float | General random spawn factor |
| `rotX/Y/Z` | float | Initial rotation |
| `rotRand` | float | Random rotation variation |
| `tumbleX/Y/Z` | float | Tumble spin rates |
| `tumbleRand` | float | Random tumble variation |

> ℹ️ The engine applies randomization to all parameters. If all chunks' `ruPercent` values don't sum to 100%, the engine redistributes evenly.

**Example**:
```lua
SpawnSalvageOnDeath(NewShipType, "Slv_Chunk_Lrg03", 1, 0.40, 0,0,0, 0,0,0,50, 0,0,0,200, 0,0,0,50)
SpawnSalvageOnDeath(NewShipType, "Slv_Chunk_Lrg02", 1, 0.05, 0,0,0, 30,-20,200,25, 300,150,85,50, 0,0,0,85)
```

---

## loadShipPatchList

Loads ship sound effect patches.

```lua
loadShipPatchList(shipRef, soundPath, unknown, engineSound, ambientSound)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference |
| `soundPath` | string | Path to sound directory (with `data:` prefix) |
| `unknown` | int | Typically `0` |
| `engineSound` | string | Engine sound patch name |
| `ambientSound` | string | Ambient sound patch name (often `""`) |

**Example**:
```lua
loadShipPatchList(NewShipType, "data:sound/sfx/ship/Hiigaran/Fighter/", 0, "HScoutEng", "")
```

---

## setSpecialDieTime

Sets the death animation time for a specific cause of death.

```lua
setSpecialDieTime(shipRef, cause, time)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference |
| `cause` | string | Death cause (e.g., `"BIGROCK"` for asteroid collision) |
| `time` | float | Death animation duration (seconds) |

**Example** (from vanilla mothership):
```lua
setSpecialDieTime(NewShipType, "BIGROCK", 3)
```

---

## loadLatchPointList

Defines latch points for salvage/repair operations on a ship.

```lua
loadLatchPointList(shipRef, latchType, point1, point2, ...)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference |
| `latchType` | string | `"SalCap"` (salvage capture) or `"RepCap"` (repair capture) |
| `pointN` | string | Joint names from the HOD model |

**Example** (resource collector with repair and salvage points):
```lua
loadLatchPointList(NewShipType, "RepCap", "RepairPoint1", "RepairPoint2")
loadLatchPointList(NewShipType, "SalCap", "SalvagePoint1", "SalvagePoint2")
```

---

## getShipNum / getShipStr

Retrieves numeric or string values from external configuration, with a default fallback.

```lua
value = getShipNum(shipRef, paramName, defaultValue)
value = getShipStr(shipRef, paramName, defaultString)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `shipRef` | userdata | Ship table reference |
| `paramName` | string | Parameter name to look up |
| `defaultValue` | number/string | Fallback if not found |

**Common usage** (allowing external override of squadron size):
```lua
NewShipType.SquadronSize = getShipNum(NewShipType, "SquadronSize", 1)
NewShipType.buildBatch = getShipNum(NewShipType, "buildBatch", 5)
```

---

## addShaderProp / setShaderChannels

Configure shader properties on a ship model.

```lua
addShaderProp(shipRef, propertyName, value1, value2)
setShaderChannels(shipRef, channel, r, g, b, a)
```

**Example**:
```lua
addShaderProp(NewShipType, "SOB_surfGlow", 2, 2)
```

---

## Function Call Order in .ship Files

The order of function calls matters. Follow this sequence to avoid crashes:

```
1.  StartShipConfig()
2.  setTacticsMults() / setSpeedvsAccuracyApplied()
3.  Variable assignments (health, speed, families, etc.)
4.  setSupplyValue()
5.  addAbility() calls
6.  ═══ LoadModel() ═══  ← CRITICAL BOUNDARY
7.  StartShipWeaponConfig()
8.  addShield()
9.  StartShipHardPointConfig()
10. SpawnSalvageOnDeath()
11. setEngineTrail() / setEngineBurn() / setEngineGlow()
12. loadShipPatchList()
13. addCustomCode()
14. addShaderProp() / setShaderChannels()
```
