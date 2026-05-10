# Weapon & Combat Variables

> Variables and settings that dictate how weapons fire, how ships maneuver in combat, and how formations behave. Found in `weaponfire`, `attack styles`, and `strike groups` lua scripts.

---

## Weapon Fire (`.weaponfire` / `.wepn`)

Defines the visual and audio effects that trigger when a weapon fires, hits, or misses.

- **hitfx**: The `.wf` visual effect to play upon a successful hit.
- **blowthroughfx**: Effect played if the projectile penetrates and exits the target.
- **bulletfx**: The `.wf` effect attached to the projectile itself in flight.
- **nopenetratefx**: Effect played if the weapon hits but fails to penetrate armor.
- **scartype**: The type of battle scar to leave on the target's hull (e.g., `"Plasma_Hit"`, `"Kinetic_Hit"`).
- **deathtype**: Specific death sequence trigger if this weapon deals the killing blow.
- **hit_sfx**: Audio path for the impact sound.
- **nopentrate_sfx**: Audio path for a ricochet/deflection sound.
- **hit_clamp**: Table defining min/max scales for the hit effect.

---

## Behavior & Logic

### Rules of Engagement (ROE)

Defines a ship's auto-acquire and retaliation behavior. 
*Note: HWRM splits Homeworld 2's "Tactics" system into ROE and Stance.*

| State | Value | Description |
|-------|-------|-------------|
| `OffensiveROE` | `0` | Immediately seek out and attack any enemies within retaliation range. |
| `DefensiveROE` | `1` | Only retaliate against enemies that attack the ship or nearby allies. |
| `PassiveROE` | `2` | Never attack unless explicitly ordered. |

### Stance

Dictates formation spacing, flight behavior, and stat multipliers (defined via `setTacticsMults`).

| State | Value | Description |
|-------|-------|-------------|
| `AggressiveStance` | `0` | Formations pack tightly. Ships prioritize damage over survival. Often grants bonus damage/fire rate but reduces evasion. Formations rarely break. |
| `NeutralStance` | `1` | Standard spacing. No specific stat modifiers applied by default. |
| `EvasiveStance` | `2` | Loose formations. Ships prioritize survival, often breaking formation into small sub-groups under fire. Grants evasion/speed bonuses but reduces damage/fire rate. |

---

## Attack Styles

Scripts in `Data/Scripts/AttackStyles/` define exactly how a ship flies while attacking.

### Basic Identifiers
- **AttackStyleName**: e.g., `FaceTarget`, `AttackRun`, `CircleStrafe`, `DogFight`, `Kamikaze`.

### Action Variables
These variables control the timing and probability of specific combat maneuvers.
- **Type**: The specific maneuver (e.g., `PickNewTarget`, `FlightManuever`, `StrafeReRange`).
- **Weighting**: Probability weight of this action occurring.
- **FlightManeuverName**: Specific `.lua` maneuver from the `flightmaneuvers` folder.
- **heatCost / heatThresh**: Cooldown mechanics for how often the action can trigger.
- **stance**: Associates the action with a specific stance (`Ag`, `Ev`, `Pa`).

### Movement Parameters
- **distanceFromTarget**: Base orbit/attack distance (often has `Ag` and `Ev` variants like `distanceFromTargetAg`).
- **distanceFromTargetToBreak**: At what range to abort an attack run.
- **circleHeight / circleSegmentAngle**: Parameters for `FlyRound` and `CircleStrafe` styles.
- **minSpeedFraction**: The lowest percentage of max speed a ship will drop to during a dogfight.
- **faceTarget**: `1` = Ship must face the target horizontally and vertically.
- **safeDistanceFromTargetToDoActions**: Range threshold before the ship considers itself "in combat" for maneuvers.

---

## Strike Groups

Scripts in `Data/Scripts/StrikeGroups/` define formation shapes and stance modifiers.

### Hierarchy
- **Name**: The internal identifier (e.g., `"Batch_Dart"`).
- **Title / Hint**: Localization IDs for UI display.
- **StanceGrouping**: How the group breaks up based on stance (`Ag`, `Ev`, `Pa`).
- **UnitLimit**: Max number of ships allowed in the formation.

### Formation Nodes
- **Children**: Nested tables defining `OffsetFromParent {x, y, z}` to create the physical 3D shape of the formation.
- **SpacingRange**: Base multiplier for spacing between ships, interpolated by collision size. Has stance variants (`SpacingRangeAg`, `SpacingRangeEv`).

### Multipliers
Strike groups can dynamically alter the stats of the ships within them based on ship type and stance. Tables include:
- `MAXSPEED`
- `ENGINEACCEL / ENGINEBRAKE`
- `ROTATION / ROTATIONACCEL / ROTATIONBRAKE`
- `WEAPONCONE`
- `WEAPONDAMAGE`
- `FIRERATE`
- `BULLETSPEED`

*Example Syntax:*
```lua
{ "Vgr_Interceptor", AggressiveStance, "Graph", 1, 1.01, 7, 1.01 }
```
