# Ship File Variable Order

> **CRITICAL**: The Homeworld Remastered engine parses `.ship` files sequentially. Defining variables or calling initialization functions out of order will result in immediate hard crashes to desktop during loading screens. When in doubt, follow this exact structure.

---

## 1. General Info & Stats
- `displayedName`
- `sobDescription`
- `maxhealth`
- `regentime` / `minRegenTime`
- `sideArmourDamage` / `rearArmourDamage`
- `setTacticsMults()`

## 2. Construction & Classification
- `isTransferable`
- `SquadronSize`
- `buildBatch`
- `formationSpacing`
- `defaultROE`
- `defaultStance`

## 3. Movement & Physics
- `mass`
- `mainEngineMaxSpeed`
- `rotationMaxSpeed`
- Acceleration / Brake timings
- `accelerationAngle`
- `tumbleStatic...` / `swayOffset...`

## 4. Visual Layout Bounds
- `setTargetBox()`
- `layoutBoundX` / `layoutBoundY` / `layoutBoundZ`
- `layoutCenterX` / `layoutCenterY` / `layoutCenterZ`

## 5. Engine Families
- `MinimalFamilyToFindPathAround`
- `BuildFamily`
- `AttackFamily`
- `DockFamily`
- `AvoidanceFamily`
- `DisplayFamily`
- `AutoFormationFamily`
- `CollisionFamily`
- `ArmourFamily`
- `CombatFamily`

## 6. Sensor & Threat Values
- `AttackPriorityMultiplier`
- Value identifiers (`fighterValue`, `frigateValue`, etc.)
- `buildCost`
- `buildTime`
- `retaliationRange`
- `visualRange`
- `prmSensorRange`
- `secSensorRange`

## 7. UI Rendering & LODs
- `TOIcon` / `TOScale` / `TODistanceFade` parameters
- `nlips` / `nlipsRange`
- `SMRepresentation`
- `AlwaysInRenderList`
- `meshRenderLimit` / `dotRenderLimit`
- `minLOD` / `upLOD` / `downLOD`
- `selectionPriority`

## 8. Abilities & Docking
- `nbRestrictedHardpoints`
- `addAbility(NewShipType, ...)` for all abilities (Move, Attack, Guard, Dock, etc.)
- Docking & Launching formation timings

## 9. Structural Initializers (CRITICAL ORDER)
**These three lines must appear exactly in this sequence, after abilities:**
1. `LoadModel(NewShipType, 1)`
2. `StartShipWeaponConfig(...)`
3. `StartShipHardPointConfig(...)`
*(Failure to load the model before attaching weapons/hardpoints causes a fatal engine exception).*

## 10. Death & FX
- `SpawnSalvageOnDeath()`
- `battleScarCoverage`
- `sobDieTime`
- `setEngineTrail()` / `setEngineBurn()` / `setEngineGlow()`
- Scuttle parameters & radius damage logic
