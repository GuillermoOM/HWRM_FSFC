# Global Engine Variables

> Core system variables, engine enumerations, and tuning definitions used across the entire game engine. Found in `autoexec.lua`, `gametype.lua`, `tuning.lua`, and `familylist.lua`.

---

## Input IDs

Standard keyboard and mouse mappings available in UI and GameType scripts.

- `AKEY` through `ZKEY` (ASCII-like values, e.g. `AKEY = 65`)
- `ONEKEY` through `NINEKEY` (e.g. `ONEKEY = 49`)
- `F1KEY` through `F12KEY` (e.g. `F1KEY = 112`)
- `NUMPAD0` through `NUMPAD9`
- `CONTROLKEY`, `ALTKEY`, `SHIFTKEY`, `SPACEKEY`, `ENTERKEY`, `ESCKEY`, `TABKEY`
- `ARRUP`, `ARRDOWN`, `ARRLEFT`, `ARRRIGHT` (Arrow keys)
- `LMOUSE_BUTTON = 1`, `RMOUSE_BUTTON = 2`, `MMOUSE_BUTTON = 4`
- `LMOUSE_DOUBLE = 6`, `RMOUSE_DOUBLE = 7`
- `FLYWHEEL_UP = 3`, `FLYWHEEL_DOWN = 5`

---

## Event IDs

Predefined engine event triggers.

- `ePopup = 0`, `eTransition = 1`, `eCancelOrders = 2`, `eFocusHome = 4`
- `eTacticalOverlay = 5`, `eScuttle = 6`, `eMove = 9`, `eHarvest = 10`
- `eGuard = 11`, `eResearchManager = 12`, `eFocus = 13`
- `eSelectAllVisible = 14`, `eDock = 15`
- `eBuildManager = 19`, `eLaunchManager = 20`, `eMenu = 21`
- `eGroup = 22`, `eSelectGroup = 23`
- `eShiftModifier = 24`, `eControlModifier = 25`, `eFocusModifier = 26`
- `eWaypoint = 27`, `eZoom = 29`
- `eSensorsManager = 31`, `eHUD = 36`
- `ePause = 44`, `eTactics = 45`, `eHyperspace = 46`, `eSensorPing = 47`, `eRepair = 48`, `eSpecialAttack = 49`
- `eMoveAttack = 54`, `eMilitary = 55`
- `eCloak = 69`, `eCapture = 70`, `eDeployMines = 71`

---

## MainUI Command IDs

Used to issue commands directly through UI scripts.

- `MUI_CancelCommand = 0`, `MUI_WaypointCommand = 1`
- `MUI_FocusCommand = 4`, `MUI_NextFocusCommand = 5`
- `MUI_AttackCommand = 7`, `MUI_MoveCommand = 8`, `MUI_StopCommand = 9`, `MUI_CreateGroupCommand = 10`
- `MUI_TacticalOverlayToggleCommand = 13`, `MUI_DockCommand = 14`, `MUI_GuardCommand = 15`
- `MUI_HarvestCommand = 17`
- `MUI_ZoomCommand = 21`, `MUI_SensorsManagerToggleCommand = 22`
- `MUI_HyperspaceCommand = 26`, `MUI_RepairCommand = 27`, `MUI_SpecialAttackCommand = 28`
- `MUI_RetireCommand = 31`, `MUI_MoveAttackCommand = 33`, `MUI_MilitaryCommand = 34`
- `MUI_DefenseFieldCommand = 35`, `MUI_CloakCommand = 36`, `MUI_CaptureCommand = 37`, `MUI_SensorPingCommand = 38`
- `MUI_DeployMinesCommand = 39`, `MUI_ScuttleCommand = 40`

---

## Game State & Enums

### GameType
- `GR_CAMPAIGN = 1`
- `GR_SKIRMISH = 2`
- `GR_MULTIPLAYER = 3`

### Race IDs
- `Race_Hiigaran = 1`
- `Race_Vaygr = 2`

### Objective Status
- `OS_Off = 0`
- `OS_Incomplete = 1`
- `OS_Complete = 2`
- `OS_Failed = 3`

### Objective Type
- `OT_Primary = 0`
- `OT_Secondary = 1`

### Tactical Overlay (TO)
Bitmask values for customizing the Tactical Overlay.
- `TO_SphereModifiers = 1`, `TO_SelectionIcons = 2`, `TO_DistantTOs = 4`
- `TO_Friendly = 8`, `TO_Enemy = 16`, `TO_Resources = 32`, `TO_NoATIAtAll = 64`
- `TO_OrderFeedbackMouseOver = 128`, `TO_OrderFeedbackSelection = 256`, `TO_OrderFeedbackAlwaysOn = 512`
- `TO_RallyPointsSelected = 1024`, `TO_RallyPointsAll = 2048`

---

## FamilyList

Defined in `familylist.lua`. Used to classify ships into groups for AI, targeting, avoidance, and UI.

| Family Category | Description | Example Values |
|-----------------|-------------|----------------|
| `buildFamily` | Race-specific UI categories | `Fighter_Hgn`, `Corvette_Vgr` |
| `displayFamily` | Broad visual classes | `Fighter`, `Capital`, `Utility` |
| `attackFamily` | Target prioritization logic | `Fighter`, `UnArmoured`, `Mover` |
| `dockFamily` | Where a ship can dock | `Fighter`, `SuperCap` |
| `avoidanceFamily` | Collision avoidance logic | `Strikecraft`, `SuperCap`, `DontAvoid` |
| `armourFamily` | Damage calculation classes | `Unarmoured`, `LightArmour`, `HeavyArmour` |

---

## Tuning Values

Defined in `tuning.lua`. These globally modify the physical and gameplay logic of the engine.

### Global Multiplier Caps
Hard limits on modifiers to prevent infinite scaling.
- `WeaponDamage`, `WeaponAccuracy`, `VisualRange`, `PrimarySensorsRange`, `CloakDetection`

### Collision & Damage
- `kamikazeDamageMultiplier`
- `normalCollisionDamageMultiplier`
- `glancingBounceFactor`

### Movement & Pathfinding
- `RecalcPathTime`, `PathFollowRadius`
- `extraAvoidanceDistance`
- `capsuleLookAheadTime`

### Combat Logic
- `numberOfSecondsForDamageAssesment`
- `heavyDamageFraction`, `criticallyDamagedFraction` (thresholds for trailing smoke/fire)
- `battleTrackerReductionFraction`

---

## Upgrade IDs

In HWRM, the engine automatically generates integer hashes for every Research item, Ship, and Subsystem in the game. These are found in the generated `upgrade_ids.lua` or `UpgradeIDs` AI files and are used by the AI to uniquely identify entities when calling functions like `Build()` or `ResearchDemandAdd()`.

*Example:*
- `HGN_INTERCEPTOR = 1658044661`
- `HGN_BATTLECRUISER = 1399507285`
- `CLOAKGENERATOR = 1653337347`
