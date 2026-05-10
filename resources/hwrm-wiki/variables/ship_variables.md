# Ship & Subsystem Variables

> These variables define the core statistics, behavior, and visual properties of ships, subsystems, and missiles in `.ship`, `.subs`, and `.miss` files.

---

## Ship Variables (`.ship`)

Defined on the `NewShipType` table created by `StartShipConfig()`.

### General & Display
- **displayedName**: Language string ID (e.g., `"$1234"`) or plaintext name.
- **sobDescription**: Localization ID for the brief unit description.
- **buildCost**: RU cost to build.
- **buildTime**: Seconds to build.
- **buildBatch**: Number of ships built at once in a batch.
- **SquadronSize**: Default number of ships in the squadron when built.
- **isTransferable**: `1` = can be transferred to allies in multiplayer, `0` = cannot.
- **militaryUnit**: `1` = military unit, `0` = civilian (harvester/utility).

### Health & Armor
- **maxhealth**: Maximum hitpoints.
- **regentime**: Time (seconds) to regenerate from 0 to full HP. `0` = no regen.
- **minRegenTime**: Hard minimum cap for regeneration time multipliers.
- **sideArmourDamage**: Multiplier for damage taken on the side (e.g., `1.2`).
- **rearArmourDamage**: Multiplier for damage taken on the rear.
- **ArmourFamily**: Armor classification (e.g., `Unarmoured`, `HeavyArmour`).
- **battleScarCoverage**: Number of visual battle scars.

### Movement & Flight
- **mass**: Mass in kg (determines collision damage).
- **mainEngineMaxSpeed**: Maximum forward speed (m/s).
- **thrusterMaxSpeed**: Speed when turning/strafing.
- **rotationMaxSpeed**: Turning speed (deg/s).
- **mainEngineAccelTime / mainEngineBrakeTime**: Seconds to reach max speed / stop.
- **rotationAccelTime / rotationBrakeTime**: Seconds to reach max rotation.
- **accelerationAngle**: Forward cone angle (degrees). Ship must turn within this cone before engaging main engines.
- **maxBankingAmount**: Maximum roll/bank angle when turning.
- **descendPitch**: Maximum pitch angle.
- **goalReachEpsilon**: Distance (m) to consider a movement goal reached.

### Combat & Targeting
- **AttackPriorityMultiplier**: Threat scaling.
- **retaliationRange**: Distance to engage enemies automatically when in defensive/aggressive stance.
- **AttackFamily / CombatFamily**: Classifications for AI targeting prioritization.
- **defaultROE**: `Offensive`, `Defensive`, or `Passive`.
- **defaultStance**: `Aggressive`, `Evasive`, or `Neutral`.

### Sensors & Visibility
- **prmSensorRange**: Primary sensor radius (blue sphere in Sensor Manager).
- **secSensorRange**: Secondary sensor radius (detects but doesn't reveal in SM).
- **visualRange**: Range at which meshes render.
- **detectionStrength**: Anti-cloak detection value.
- **AlwaysInRenderList**: `1` = Always visible to all players.
- **SMRepresentation**: `HardDot` or `Mesh`.
- **SMHighlightDistMin / SMHighlightDistMax**: Range for Sensor Manager highlighting.

### Death & Scuttle
- **sobDieTime**: Seconds between hitting 0 HP and disappearing.
- **chanceOfSpecialDeath**: `0.0` to `1.0` chance of playing special death animation.
- **tumbleStaticX / Y / Z**: Pitch, heading, and roll spin rates on death.
- **allowScuttle**: `1` = can self-destruct.
- **explosiveDamageOnDeath / explosiveScuttleDamageOnDeath**: AoE damage on death.
- **minFalloffDamageDist / maxFalloffDamageDist**: AoE damage radii.

---

## Subsystem Variables (`.subs`)

Defined on the `NewSubSystemType` table created by `StartSubSystemConfig()`.
Subsystems act like attached miniature ships.

- **armourClass**: Armor type (usually `SubSystemArmour`).
- **type / typeString**: Classification (e.g., `System`, `Research`, `Weapon`).
- **costToBuild / timeToBuild**: Production stats.
- **maxNumberBuildable**: Cap per ship.
- **collateralDamage**: Damage dealt to the parent ship when subsystem is destroyed.
- **inactiveTimeAfterDamage**: Seconds the subsystem is disabled after taking damage.
- **activateHealthPercentage**: HP threshold required to reactivate after being disabled.
- **innate**: `1` = built instantly with the ship.

---

## Missile Variables (`.miss`)

Defined on the `NewMissileType` table created by `StartMissileConfig()`.
Missiles are technically ships with flight logic.

- **weaponName**: The name of the weapon that fired it.
- **lifeTime**: Seconds before the missile disappears/detonates.
- **launchTime**: Seconds of 'dumb fire' before tracking begins.
- **detectionDistance**: Max range to acquire targets.
- **clusterDistance**: Distance from target to deploy submunitions.
- **numberSubMunitions / subMunitionName**: For cluster torpedoes/MIRVs.
- **trackingSpeedMultiplier**: Steering scale.
- **spiralsPerSecondMin / Max**: Visual corkscrew effect.

---

## Shared Enumerations

### Abilities (`AB_*`)
Used in `SobGroup_AbilityActivate` and `SobGroup_CanDoAbility`.
- `AB_Move = 1`
- `AB_Attack = 2`
- `AB_Guard = 3`
- `AB_Repair = 4`
- `AB_Cloak = 5`
- `AB_Harvest = 6`
- `AB_Mine = 7`
- `AB_Capture = 8`
- `AB_Dock = 9`
- `AB_AcceptDocking = 10`
- `AB_Builder = 11`
- `AB_Hyperspace = 13`
- `AB_SensorPing = 17`
- `AB_SpecialAttack = 18`
- `AB_DefenseField = 20`
- `AB_Targeting = 27` (Disables weapons without disabling attack movement)

### Armour & Shields Penetration
Used in penetration arrays:
- `None = 0`
- `Normal = 1`
- `Enhanced = 2`
- `Bypass = -1`

---

## Visuals & Effects

### NavLights
Defined in `navlights.lua`.
- **lightTextureName**: Usually `"effect/textures/navlight.tga"`
- **lightPointSize**: Base size of the sprite.

### Lensflare
Defined in `lensflare.lua`.
- **fadetimes**: `{ fadeUpHi, fadeUpLo, fadeDownHi, fadeDownLo }` in seconds.
- **washoutColour**: `{r, g, b, alpha}` fullscreen tint.
- **washoutStrength**: Intensity when looking at the flare.
- **hotspots**: Table defining the individual flare textures along the view line.
