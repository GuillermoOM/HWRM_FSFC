# Weapon Configuration Functions

> Functions used in `.wepn` files to define weapon behavior, damage, penetration, accuracy, and projectile properties. All functions operate in the **Object** and **Weapon** scopes unless noted.

---

## StartWeaponConfig

The primary function for configuring a weapon. Called once per `.wepn` file.

```lua
StartWeaponConfig(weaponRef, weaponType, fireType, fireEffectName, activation,
    fireSpeed, fireRange, fireRadius, fireLifetime, fireMisc1, fireAxis,
    maxEffectsSpawned, useVelocityPred, checkLineOfFire,
    fireTime, burstFireTime, burstWaitTime,
    shootAtSecondaries, shootAtSurroundings,
    maxAzimuthSpeed, maxDeclinationSpeed,
    speedMultWhenPointing, shieldPenetration,
    trackOutsideRange, waitForCodeRed, instantHitThreshold)
```

### Parameters

| # | Parameter | Type | Description |
|---|-----------|------|-------------|
| 1 | `weaponRef` | userdata | Weapon table (`NewWeaponType`) |
| 2 | `weaponType` | string | Aiming method: `"Gimble"` (cone aiming), `"AnimatedTurret"` (visible turret rotation), `"Fixed"` (fires straight ahead) |
| 3 | `fireType` | string | Projectile type: `"Bullet"` (unguided), `"InstantHit"` (beam), `"Missile"` (guided), `"Mine"` (dropped), `"SphereBurst"` (AoE) |
| 4 | `fireEffectName` | string | Name of the `.wf` file for visual/audio effects |
| 5 | `activation` | string | When weapon fires: `"Normal"` (always), `"Special Attack"` (ability-gated), `"Normal Only"` (replaced by special), `"Dropped"` (mines) |
| 6 | `fireSpeed` | float | Projectile velocity in m/s. `0` for beams/bursts |
| 7 | `fireRange` | float | Maximum firing range in meters |
| 8 | `fireRadius` | float | Blast radius for SphereBurst weapons. `0` for non-AoE |
| 9 | `fireLifetime` | float | Duration in seconds (beams only). `0` for bullets/missiles |
| 10 | `fireMisc1` | float | Beam anticipation time in seconds |
| 11 | `fireAxis` | int | Missile ejection direction: `0`=Forward, `1`=Left, `2`=Up |
| 12 | `maxEffectsSpawned` | int | Maximum hit effects per projectile lifetime |
| 13 | `useVelocityPred` | int | `1` = lead target prediction, `0` = fire at current position |
| 14 | `checkLineOfFire` | int | `1` = check for friendlies in line of fire |
| 15 | `fireTime` | float | Delay between shots in seconds |
| 16 | `burstFireTime` | float | Duration of burst fire window. `0` = no burst mode |
| 17 | `burstWaitTime` | float | Delay between bursts. `0` = no burst mode |
| 18 | `shootAtSecondaries` | int | `1` = fire at secondary targets when primary is obstructed |
| 19 | `shootAtSurroundings` | int | `1` = scan for nearby enemies. **Warning: performance-heavy** |
| 20 | `maxAzimuthSpeed` | float | Horizontal turret tracking speed (degrees/sec) |
| 21 | `maxDeclinationSpeed` | float | Vertical turret tracking speed (degrees/sec) |
| 22 | `speedMultWhenPointing` | float | Speed multiplier when beam is aimed at target (< 1.0 = slow sweep) |
| 23 | `shieldPenetration` | string | `"Normal"`, `"Enhanced"`, or `"Bypass"` |
| 24 | `trackOutsideRange` | int | `1` = track targets beyond weapon range |
| 25 | `waitForCodeRed` | float | Wait time for code-red animation before firing |
| 26 | `instantHitThreshold` | int | Beam passes through if target HP is below this value |

### DPS Calculation
```
shots_per_burst = floor(burstFireTime / fireTime)
burst_cycle = burstFireTime + burstWaitTime
shots_per_second = shots_per_burst / burst_cycle
DPS = damage_per_shot × shots_per_second
```
If `burstFireTime` is `0`: `DPS = damage_per_shot / fireTime`

---

## AddWeaponResult

Defines the damage or effect that occurs when a weapon hits or misses.

```lua
AddWeaponResult(weaponRef, condition, effect, target, minValue, maxValue, subWeapon)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `weaponRef` | userdata | Weapon table (`NewWeaponType`) |
| `condition` | string | `"Hit"` or `"Miss"` |
| `effect` | string | `"DamageHealth"`, `"SpawnWeaponFire"`, `"Push"` |
| `target` | string | `"Target"` or `"Self"` |
| `minValue` | float | Minimum damage per hit |
| `maxValue` | float | Maximum damage per hit |
| `subWeapon` | string | Sub-weapon name for `SpawnWeaponFire`. `""` for standard damage |

**Example**:
```lua
AddWeaponResult(NewWeaponType, "Hit", "DamageHealth", "Target", 135.6, 136.8, "")
```

---

## setPenetration

Defines damage multipliers against different armour types.

```lua
setPenetration(weaponRef, numLevels, defaultMult, {ArmourFamily = mult}, ...)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `weaponRef` | userdata | Weapon table |
| `numLevels` | int | Number of penetration levels |
| `defaultMult` | float | Default multiplier for unlisted armour types |
| `{Family = mult}` | table pairs | Per-family multiplier overrides |

Final damage = `base_damage × penetration_mult × accuracy × tactics_mult`

**Example**:
```lua
setPenetration(NewWeaponType, 5, 1,
    {Unarmoured = 1.0},
    {LightArmour = 0.85},
    {MediumArmour = 0.55},
    {HeavyArmour = 0.30},
    {SubSystemArmour = 2.5},
    {TurretArmour = 0.60},
    {ResArmour = 0.2})
```

---

## setAccuracy

Defines hit probability against different attack families.

```lua
setAccuracy(weaponRef, defaultAccuracy, {AttackFamily = accuracy}, ...)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `weaponRef` | userdata | Weapon table |
| `defaultAccuracy` | float | Default accuracy (0.0 - 1.0) for unlisted families |
| `{Family = acc}` | table pairs | Per-family accuracy overrides |

**Example** (anti-fighter weapon):
```lua
setAccuracy(NewWeaponType, 1,
    {Fighter = 0.10},
    {Corvette = 0.20},
    {Frigate = 0.60},
    {SmallCapitalShip = 0.88},
    {BigCapitalShip = 0.88})
```

---

## setAngles

Defines the firing cone and turret traversal limits.

```lua
setAngles(weaponRef, triggerHappy, minAzimuth, maxAzimuth, minDeclination, maxDeclination)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `weaponRef` | userdata | Weapon table |
| `triggerHappy` | float | Half-angle of firing cone (degrees). Actual coverage = 2× this value. `Gimble` weapons aim within this cone; `Fixed`/`AnimatedTurret` fire if targets are within it |
| `minAzimuth` | float | Minimum horizontal rotation (degrees, counterclockwise) |
| `maxAzimuth` | float | Maximum horizontal rotation (degrees, clockwise) |
| `minDeclination` | float | Minimum vertical angle (degrees, down) |
| `maxDeclination` | float | Maximum vertical angle (degrees, up) |

**Example** (full-rotation turret):
```lua
setAngles(NewWeaponType, 0, -180, 180, -5, 60)
```

**Example** (fixed forward gun):
```lua
setAngles(NewWeaponType, 15, 0, 0, 0, 0)
```

---

## setMissProperties

Controls bullet behavior when a shot is marked as a miss.

```lua
setMissProperties(weaponRef, coneHoriz, coneVert, loDamage, hiDamage, missSpeed, missLifetime)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `weaponRef` | userdata | Weapon table |
| `coneHoriz` | float | Horizontal deflection added to miss trajectory |
| `coneVert` | float | Vertical deflection added to miss trajectory |
| `loDamage` | float | Minimum damage multiplier if miss bullet hits target anyway |
| `hiDamage` | float | Maximum damage multiplier if miss bullet hits target |
| `missSpeed` | float | Speed multiplier for missed bullets (vs original speed) |
| `missLifetime` | float | Lifetime multiplier for missed bullets |

**Notes**: In HWRM's accuracy system, if a shot is marked as a miss, bullet steering is disabled and trajectory noise is added via the miss cone. If the deflected bullet still strikes a target, damage is scaled by `loDamage`-`hiDamage`.

**Example**:
```lua
setMissProperties(NewWeaponType, 0.02, 0.04, 0.20, 0.35, 0.55, 0.65)
```

---

## setSpeedvsAccuracyAgainst

Defines how target speed affects this weapon's accuracy.

```lua
setSpeedvsAccuracyAgainst(weaponRef, enabled, speed1, acc1, speed2, acc2, ...)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `weaponRef` | userdata | Weapon table |
| `enabled` | int | `1` = enabled |
| `speedN` | float | Speed threshold (m/s) |
| `accN` | float | Accuracy multiplier at that speed |

Pairs define a piecewise curve: faster targets are harder to hit.

**Example**:
```lua
setSpeedvsAccuracyAgainst(NewWeaponType, 1, 50.0, 1.5, 75, 1.0, 300, 1.0, 487, 0.90, 535, 0.60)
```

---

## setFrustratedTimers

Controls how long a weapon waits before giving up on an unreachable target.

```lua
setFrustratedTimers(weaponRef, minTime, maxTime)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `weaponRef` | userdata | Weapon table |
| `minTime` | float | Minimum frustrated time (seconds) |
| `maxTime` | float | Maximum frustrated time (seconds) |

**Example**:
```lua
setFrustratedTimers(NewWeaponType, 0.0, 10.0)
```

---

## setDamageFalloff

Reduces weapon damage over distance traveled.

```lua
setDamageFalloff(weaponRef, falloffRate, startPercent)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `weaponRef` | userdata | Weapon table |
| `falloffRate` | float | Damage lost per meter. Typically expressed as `fraction/range` (e.g., `0.15/2000.0`) |
| `startPercent` | float | Point where falloff begins (0-1 of total range). `0.1` = falloff starts at 10% of range |

**Notes**: Falloff begins at `startPercent` of the weapon's range. Before that point, full damage is applied. Common pattern: `falloff/range` ensures the calculation scales with weapon range.

**Example** (falloff over full range):
```lua
setDamageFalloff(NewWeaponType, 0.15/2000.0, 0.1)
```

---

## setAccuracyFalloff

Reduces weapon accuracy over distance traveled (same mechanics as damage falloff).

```lua
setAccuracyFalloff(weaponRef, falloffRate, startPercent)
```

**Example**:
```lua
setAccuracyFalloff(NewWeaponType, 0.15/2000.0, 0.1)
```

---

## setBallistics

Enables or disables ballistic (non-steered) projectile mode.

```lua
setBallistics(weaponRef, enabled, fireAhead)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `weaponRef` | userdata | Weapon table |
| `enabled` | int | `0` = ballistics **enabled**, `1` = ballistics **disabled** (note: inverted logic) |
| `fireAhead` | float | Deflection amount (0-1). Controls how much the weapon leads the target |

**Notes**:
- **With steering** (ballistic disabled): The engine guarantees a hit percentage based on the accuracy table — the bullet physically steers toward the target.
- **Without steering** (ballistic enabled): The weapon aims at/ahead of the target and fires. Whether it hits depends on bullet speed, target speed, range, and target behavior. The accuracy table determines which shots are "aimed" (full damage on hit) vs. "unaimed" (subject to miss rules).

**Example** (non-ballistic, default):
```lua
setBallistics(NewWeaponType, 0, 0.0)
```

---

## setLifetimeMult

Multiplier for projectile lifetime (how long it exists before expiring).

```lua
setLifetimeMult(weaponRef, multiplier)
```

**Example**:
```lua
setLifetimeMult(NewWeaponType, 1.75)
```

---

## setDamageMultFactor / setFireMultFactor

Multipliers that can be modified by research upgrades.

```lua
setDamageMultFactor(weaponRef, multiplier)  -- Base damage multiplier (research scales this)
setFireMultFactor(weaponRef, multiplier)    -- Base fire rate multiplier (research scales this)
```

**Example**:
```lua
setDamageMultFactor(NewWeaponType, 1.0)
setFireMultFactor(NewWeaponType, 1.0)
```

---

## setRangeBoost / setRangeByStance

Modify weapon range via research upgrades or stance.

```lua
setRangeBoost(weaponRef, multiplier)                        -- Research range modifier
setRangeByStance(weaponRef, aggressive, evasive, neutral)   -- Stance-based range
```

**Example**:
```lua
setRangeBoost(NewWeaponType, 1.0)
setRangeByStance(NewWeaponType, 1.0, 1.0, 1.0)
```

---

## setMagneticFieldPenetration

Interaction with defense field abilities.

```lua
setMagneticFieldPenetration(weaponRef, value, {MagneticField, value})
```

**Example** (from vanilla battlecruiser weapon):
```lua
setMagneticFieldPenetration(NewWeaponType, -900, {MagneticField, -900})
```

---

## setMissileKiller

Enables this weapon to shoot down incoming missiles.

```lua
setMissileKiller(weaponRef, enabled)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `weaponRef` | userdata | Weapon table |
| `enabled` | int | `1` = can target missiles, `0` = cannot |

**Example**:
```lua
setMissileKiller(NewWeaponType, 1)
```

---

## setLeading

Controls weapon leading behavior (aiming ahead of moving targets).

```lua
setLeading(weaponRef, ...)
```

> ℹ️ Limited documentation. No vanilla usage found in HWRM scripts — may be engine-internal.

---

## addAnimTurretSound

Assigns a sound effect to turret rotation animation.

```lua
addAnimTurretSound(weaponRef, soundPath)
```

| Parameter | Type | Description |
|-----------|------|-------------|
| `weaponRef` | userdata | Weapon table |
| `soundPath` | string | Path to sound file (with `Data:` prefix) |

**Example**:
```lua
addAnimTurretSound(NewWeaponType, "Data:Sound/SFX/ETG/SPECIAL/SPECIAL_ABILITIES_TURRET_ON")
```

---

## StartMissileConfig

Initializes a missile configuration table. Used in `.miss` files (missiles are like mini-ships with guidance).

```lua
NewMissileType = StartMissileConfig()
```

**Returns**: `userdata` — The missile configuration table.

After calling this, set missile properties as variables on the returned table and then call `LoadModel()`.

```lua
NewMissileType = StartMissileConfig()
NewMissileType.displayedName = "Torpedo"
NewMissileType.maxhealth = 25
NewMissileType.weaponName = "Hgn_TorpedoLauncher"
-- ... movement, tracking properties ...
LoadModel(NewMissileType, 1)
```
