# Modifiable Values Reference

> A list of hardcoded engine strings that can be utilized in the `research.lua` Tech Tree as `UpgradeName` modifiers, or dynamically modified in gamerules via the `SobGroup_SetModifier` and `setTacticsMults` functions.

---

## Combat & Health
| String Name | Effect |
|-------------|--------|
| `MAXHEALTH` | Multiplier for the ship's maximum hitpoints. |
| `HEALTHREGENERATIONRATE` | Multiplier for the speed at which HP regenerates. |
| `WEAPONACCURACY` | Global multiplier for weapon hit chance. |
| `WEAPONDAMAGE` | Global multiplier for weapon base damage. |
| `MAXSHIELD` | Multiplier for Defense Field/Shield capacity. |
| `SHIELDREGENERATIONRATE` | Multiplier for shield regeneration rate. |
| `DAMAGEAPPLIED` | (Unconfirmed) Modification to incoming damage. |
| `ACCURACYAPPLIED` | (Unconfirmed) Modification to incoming hit chance. |

## Speed & Movement
| String Name | Effect |
|-------------|--------|
| `MAXSPEED` | Base multiplier for forward engine movement. Also seems to affect thrusters. |
| `SPEED` | Similar to MAXSPEED. |
| `ROTATION` | Multiplier for turn speed. |
| `ROTATIONACCEL` / `ROTATIONBRAKE` | Multipliers for turn acceleration/deceleration time. |
| `THRUSTER` | Multiplier for strafing/up-down movement. |
| `THRUSTERACCEL` / `THRUSTERBRAKE` | Multipliers for strafe acceleration/deceleration. |
| `ENGINEACCEL` / `ENGINEBRAKE` | Multipliers for forward acceleration/deceleration. |

## Production & Economy
| String Name | Effect |
|-------------|--------|
| `BUILDSPEED` | Multiplier for how fast ships are constructed. |
| `SHIPHOLDREPAIRSPEED` | Multiplier for how fast docked ships are repaired inside the carrier/mothership. |
| `RESOURCECOLLECTIONRATE` | Multiplier for harvesting speed. |
| `RESOURCEDROPOFFRATE` | Multiplier for drop-off animation/processing speed. |
| `RESOURCECAPACITY` | Multiplier for how many RUs a collector can hold before returning. |

## Sensors & Abilities
| String Name | Effect |
|-------------|--------|
| `PRIMARYSENSORSRANGE` | Multiplier for the radius of the primary (blue) sensor sphere. |
| `SECONDARYSENSORSRANGE` | Multiplier for the radius of the secondary (hidden) sensor sphere. |
| `VISUALRANGE` | Multiplier for the rendering distance of ships. |
| `CLOAKINGTIME` | Multiplier for how long a cloak can remain active. |
| `CLOAKINGSTRENGTH` | Modifier for the power of the cloak field against detection. |
| `CLOAKDETECTION` | Modifier for anti-cloak sensor strength. |
| `SENSORDISTORTION` | Modifier to scramble enemy sensors. Takes 3 arguments (min, max, radius). |
| `HYPERSPACERECOVERYTIME` | Multiplier for the cooldown time after an automated jump. |
| `HYPERSPACETIME` | Multiplier for the time it takes to enter the hyperspace window. |
| `HYPERSPACECOST` | Multiplier for RU cost to jump. |
| `CAPTURE` | Multiplier for Marine/Infiltrator capture speed. |
| `DEFENSEFIELDTIME` | Multiplier for Defense Field active duration. |
