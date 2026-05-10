# SobGroup Functions

> SobGroups (Ship-or-Object Groups) are the fundamental unit of fleet management in HWRM scripting. These functions are available in **Gamerule**, **Autoexec**, and related scopes.

---

## Group Management

### SobGroup_Create
```lua
SobGroup_Create(groupName)
```
Creates a new, empty SobGroup. No-op if group already exists.

### SobGroup_CreateIfNotExist
```lua
SobGroup_CreateIfNotExist(groupName)
```
Creates a group only if it doesn't exist. Identical to `SobGroup_Create` in practice.

### SobGroup_Clear
```lua
SobGroup_Clear(groupName)
```
Removes all ships from the group (group still exists, just empty).

### SobGroup_SobGroupAdd
```lua
SobGroup_SobGroupAdd(targetGroup, sourceGroup)
```
Adds all ships from `sourceGroup` into `targetGroup`. Ships remain in both groups.

### SobGroup_Copy
```lua
SobGroup_Copy(targetGroup, sourceGroup)
```
Copies all ships from `sourceGroup` to `targetGroup`, replacing its contents.

### SobGroup_Count
```lua
count = SobGroup_Count(groupName)
```
Returns the number of ships in the group.

### SobGroup_CountByPlayer
```lua
count = SobGroup_CountByPlayer(groupName, playerIndex)
```
Returns count of ships owned by a specific player.

### SobGroup_Empty
```lua
isEmpty = SobGroup_Empty(groupName)
```
Returns `1` if group has no ships, `0` otherwise.

### SobGroup_GroupInGroup
```lua
result = SobGroup_GroupInGroup(subGroup, superGroup)
```
Returns `1` if all ships in `subGroup` are also in `superGroup`.

### SobGroup_OwnedBy
```lua
playerIndex = SobGroup_OwnedBy(groupName)
```
Returns the player index of the group's owner.

### SobGroup_Despawn
```lua
SobGroup_Despawn(groupName)
```
Removes all ships in the group from the game entirely.

### SobGroup_MakeDead
```lua
SobGroup_MakeDead(groupName)
```
Kills all ships in the group (triggers death animations/effects).

---

## Filling / Filtering Groups

### SobGroup_FillShipsByType
```lua
SobGroup_FillShipsByType(outputGroup, sourceGroup, shipType)
```
Fills `outputGroup` with ships of `shipType` from `sourceGroup`. Includes inactive ships (docked/hyperspace), except when using `"Player_Ships"` which only contains active ships.

### SobGroup_FillProximitySobGroup
```lua
SobGroup_FillProximitySobGroup(outputGroup, sourceGroup, proximityGroup, radius)
```
Fills `outputGroup` with ships from `sourceGroup` within `radius` of `proximityGroup`.

### SobGroup_FillSobGroupInVolume
```lua
SobGroup_FillSobGroupInVolume(outputGroup, sourceGroup, volumeName)
```
Fills `outputGroup` with ships from `sourceGroup` inside the named volume.

### SobGroup_FillShipsByIndexRange
```lua
SobGroup_FillShipsByIndexRange(targetGroup, sourceGroup, startIndex, count)
```
Fills `targetGroup` with a slice of ships from `sourceGroup`.

### SobGroup_FillSubtract / SobGroup_FillSubstract
```lua
SobGroup_FillSubtract(outputGroup, sourceGroup, subtractGroup)
```
Fills `outputGroup` with ships in `sourceGroup` that are NOT in `subtractGroup`. (Both spellings exist for compatibility.)

### SobGroup_FillUnion
```lua
SobGroup_FillUnion(outputGroup, group1, group2)
```
Fills `outputGroup` with the union of `group1` and `group2`.

### SobGroup_FillCompare
```lua
SobGroup_FillCompare(outputGroup, group1, group2)
```
Fills `outputGroup` with ships present in both `group1` and `group2` (intersection).

### SobGroup_FillBattleScar
```lua
SobGroup_FillBattleScar(groupName, scarType)
```
Fills group with battle-scarred ships of the given type.

### SobGroup_FilterInclude
```lua
SobGroup_FilterInclude(outputGroup, sourceGroup, filterType, filterParam)
```
Keeps only ships matching the filter. Filter types include ship type names and attack families.

### SobGroup_FilterExclude
```lua
SobGroup_FilterExclude(outputGroup, sourceGroup, filterType, filterParam)
```
Removes ships matching the filter.

### SobGroup_RemoveType
```lua
SobGroup_RemoveType(groupName, shipType)
```
Removes all ships of the given type from the group.

---

## Commands

### SobGroup_Attack
```lua
SobGroup_Attack(playerIndex, attackerGroup, targetGroup)
```
Orders `attackerGroup` (owned by `playerIndex`) to attack `targetGroup`.

### SobGroup_AttackPlayer
```lua
SobGroup_AttackPlayer(groupName, targetPlayerIndex)
```
Orders group to attack all ships belonging to the target player.

### SobGroup_AttackSobGroupHardPoint
```lua
SobGroup_AttackSobGroupHardPoint(attackerGroup, targetGroup, hardpointName)
```
Orders attackers to target a specific hardpoint/subsystem.

### SobGroup_Move
```lua
SobGroup_Move(playerIndex, groupName, volumeName)
```
Orders group to move to the named volume.

### SobGroup_MoveToSobGroup
```lua
SobGroup_MoveToSobGroup(moversGroup, targetGroup)
```
Orders `moversGroup` to move to the location of `targetGroup`.

### SobGroup_GuardSobGroup
```lua
SobGroup_GuardSobGroup(guardGroup, targetGroup)
```
Orders `guardGroup` to guard `targetGroup`.

### SobGroup_IsGuardingSobGroup
```lua
result = SobGroup_IsGuardingSobGroup(guardGroup, targetGroup)
```
Returns `1` if `guardGroup` is guarding `targetGroup`.

### SobGroup_DockSobGroup
```lua
SobGroup_DockSobGroup(dockerGroup, dockTargetGroup)
```
Orders `dockerGroup` to dock with `dockTargetGroup`.

### SobGroup_DockSobGroupInstant
```lua
SobGroup_DockSobGroupInstant(dockerGroup, dockTargetGroup)
```
Instantly docks ships (no flight path).

### SobGroup_DockSobGroupAndStayDocked
```lua
SobGroup_DockSobGroupAndStayDocked(dockerGroup, dockTargetGroup)
```
Docks and prevents auto-launch.

### SobGroup_Launch
```lua
SobGroup_Launch(launchGroup, launchFromGroup)
```
Launches ships of `launchGroup` type from `launchFromGroup`.

### SobGroup_ParadeSobGroup
```lua
SobGroup_ParadeSobGroup(paradeGroup, targetGroup, paradeMode)
```
Orders `paradeGroup` into parade formation around `targetGroup`.

### SobGroup_FollowPath
```lua
SobGroup_FollowPath(groupName, pathName, forward, loop, attackMove)
```
Orders group to follow a named path. `forward` = direction, `loop` = repeat, `attackMove` = engage enemies.

### SobGroup_Stop
```lua
SobGroup_Stop(playerIndex, groupName)
```
Orders group to stop all current commands.

### SobGroup_Kamikaze
```lua
SobGroup_Kamikaze(attackerGroup, targetGroup)
```
Orders group to ram target.

### SobGroup_CaptureSobGroup
```lua
SobGroup_CaptureSobGroup(captureGroup, targetGroup)
```
Orders group to capture enemy ships.

### SobGroup_SalvageSobGroup
```lua
SobGroup_SalvageSobGroup(salvagerGroup, targetGroup)
```
Orders group to salvage target ships.

### SobGroup_RepairSobGroup
```lua
SobGroup_RepairSobGroup(repairGroup, targetGroup)
```
Orders repair ships to repair target group.

### SobGroup_FormStrikeGroup
```lua
SobGroup_FormStrikeGroup(groupName, strikeGroupType)
```
Forms a strike group.

### SobGroup_DeployMines
```lua
SobGroup_DeployMines(groupName, volumeName, density)
```
Deploy mines in a volume.

### SobGroup_FormHyperspaceGate
```lua
SobGroup_FormHyperspaceGate(gate1Group, gate2Group)
```
Forms a hyperspace gate between two gate ships.

### SobGroup_UseHyperspaceGate
```lua
SobGroup_UseHyperspaceGate(groupName, gateName)
```
Orders group to travel through a hyperspace gate.

---

## Hyperspace

### SobGroup_ExitHyperSpace
```lua
SobGroup_ExitHyperSpace(groupName, volumeName)
```
Ships exit hyperspace at the named volume.

### SobGroup_ExitHyperSpaceSobGroup
```lua
SobGroup_ExitHyperSpaceSobGroup(exitGroup, nearGroup, proximity)
```
Ships exit hyperspace near another group.

### SobGroup_EnterHyperSpaceOffMap
```lua
SobGroup_EnterHyperSpaceOffMap(groupName)
```
Ships enter hyperspace and leave the map.

### SobGroup_AreAllInHyperspace
```lua
result = SobGroup_AreAllInHyperspace(groupName)
```

### SobGroup_AreAllInRealSpace
```lua
result = SobGroup_AreAllInRealSpace(groupName)
```

---

## Properties — Get

### SobGroup_GetPosition
```lua
position = SobGroup_GetPosition(groupName)
```
Returns `{x, y, z}` position table.

### SobGroup_GetActualSpeed
```lua
speed = SobGroup_GetActualSpeed(groupName)
```
Returns current speed.

### SobGroup_GetSpeed
```lua
speed = SobGroup_GetSpeed(groupName)
```
Returns set speed.

### SobGroup_HealthPercentage
```lua
percent = SobGroup_HealthPercentage(groupName)
```
Returns health as 0.0-1.0.

### SobGroup_CurrentHealthTotal
```lua
total = SobGroup_CurrentHealthTotal(groupName)
```
Returns sum of all current HP.

### SobGroup_GetHardPointHealth
```lua
health = SobGroup_GetHardPointHealth(groupName, hardpointName)
```

### SobGroup_GetAttackers
```lua
SobGroup_GetAttackers(groupName, outputGroup)
```
Fills `outputGroup` with ships currently attacking this group.

### SobGroup_GetCommandTargets
```lua
SobGroup_GetCommandTargets(targetGroup, sourceGroup, commandIndex)
```
Fills `targetGroup` with the targets of `sourceGroup`'s current command.

### SobGroup_GetSobGroupDockedWithGroup
```lua
SobGroup_GetSobGroupDockedWithGroup(groupName, outputGroup)
```

### SobGroup_GetSobGroupCapturingGroup / GetSobGroupBeingCapturedGroup / GetSobGroupRepairingGroup / GetSobGroupSalvagingGroup
```lua
SobGroup_GetSobGroupCapturingGroup(groupName, outputGroup)
SobGroup_GetSobGroupBeingCapturedGroup(groupName, outputGroup)
SobGroup_GetSobGroupRepairingGroup(groupName, outputGroup)
SobGroup_GetSobGroupSalvagingGroup(groupName, outputGroup)
```

### SobGroup_GetStaticF
```lua
value = SobGroup_GetStaticF(shipType, staticName)
```
Returns a float value from ship static data.

### SobGroup_GetShipType
```lua
shipType = SobGroup_GetShipType(groupName)
```
Returns the ship type of the first ship in the group.

### SobGroup_GetSquadronsInsideDustCloud / InsideNebula
```lua
SobGroup_GetSquadronsInsideDustCloud(outputGroup, dustCloudName, playerIndex)
SobGroup_GetSquadronsInsideNebula(groupName, nebulaName, playerIndex)
```

---

## Properties — Set

### SobGroup_SetHealth
```lua
SobGroup_SetHealth(groupName, healthPercent)
```
Sets health (0.0-1.0).

### SobGroup_SetSpeed
```lua
SobGroup_SetSpeed(groupName, speed)
```
Sets absolute speed.

### SobGroup_SetMaxSpeedMultiplier
```lua
SobGroup_SetMaxSpeedMultiplier(groupName, multiplier)
```

### SobGroup_SetPosition
```lua
SobGroup_SetPosition(groupName, {x, y, z})
```

### SobGroup_SetROE
```lua
SobGroup_SetROE(groupName, roe)
```
Sets ROE: `"Offensive"`, `"Defensive"`, `"Passive"`.

### SobGroup_SetAutoLaunch
```lua
SobGroup_SetAutoLaunch(groupName, launchSetting)
```

### SobGroup_SetInvulnerability
```lua
SobGroup_SetInvulnerability(groupName, enabled)
```

### SobGroup_SetInvulnerabilityOfHardPoint
```lua
SobGroup_SetInvulnerabilityOfHardPoint(groupName, hardpointName, enabled)
```

### SobGroup_SetGhost
```lua
SobGroup_SetGhost(groupName, enabled)
```
Makes ships untargetable.

### SobGroup_SetHardPointHealth
```lua
SobGroup_SetHardPointHealth(groupName, hardpointName, health)
```

### SobGroup_SetDamageMultiplier
```lua
SobGroup_SetDamageMultiplier(groupName, multiplier)
```

### SobGroup_SetBuildSpeedMultiplier
```lua
SobGroup_SetBuildSpeedMultiplier(groupName, multiplier)
```

### SobGroup_SetCaptureState
```lua
SobGroup_SetCaptureState(groupName, state)
```

### SobGroup_SetCaptureAlwaysDisables
```lua
SobGroup_SetCaptureAlwaysDisables(groupName, alwaysDisable)
```

### SobGroup_SetTeamColours
```lua
SobGroup_SetTeamColours(groupName, baseColour, stripeColour, badgeName)
```

### SobGroup_SetMadState
```lua
SobGroup_SetMadState(groupName, stateName)
```
Sets mesh animation state.

### SobGroup_SetInherentVisibility
```lua
SobGroup_SetInherentVisibility(groupName, playerIndex, visibility)
```

### SobGroup_SetSwitchOwnerFlag
```lua
SobGroup_SetSwitchOwnerFlag(groupName, enabled)
```

### SobGroup_SetDisplayedRestrictedHardpoint
```lua
SobGroup_SetDisplayedRestrictedHardpoint(groupName, slot)
```

### SobGroup_SetShaderValues
```lua
SobGroup_SetShaderValues(groupName, scope, enable, subsystemFilter, baseChannel, value1, value2, ...)
```

### SobGroup_SetAsDeployed
```lua
SobGroup_SetAsDeployed(groupName)
```

---

## State Queries

### SobGroup_IsInVolume
```lua
result = SobGroup_IsInVolume(groupName, volumeName)
```

### SobGroup_IsShipNearPoint
```lua
result = SobGroup_IsShipNearPoint(groupName, volumeName, distance)
```

### SobGroup_IsDoingAbility
```lua
result = SobGroup_IsDoingAbility(groupName, abilityIndex)
```

### SobGroup_CanDoAbility
```lua
result = SobGroup_CanDoAbility(groupName, abilityIndex)
```

### SobGroup_AbilityActivate
```lua
SobGroup_AbilityActivate(groupName, abilityIndex, activate)
```

### SobGroup_IsDocked
```lua
result = SobGroup_IsDocked(groupName)
```

### SobGroup_IsDockedSobGroup
```lua
result = SobGroup_IsDockedSobGroup(groupName, dockedWithGroup)
```

### SobGroup_IsCloaked
```lua
result = SobGroup_IsCloaked(groupName)
```

### SobGroup_IsBuilding
```lua
result = SobGroup_IsBuilding(groupName, itemName)
```

### SobGroup_UnderAttack
```lua
result = SobGroup_UnderAttack(groupName)
```

### SobGroup_Selected
```lua
result = SobGroup_Selected(groupName)
```

### SobGroup_OnScreen
```lua
result = SobGroup_OnScreen(groupName)
```

### SobGroup_InWorldBound
```lua
result = SobGroup_InWorldBound(groupName, boundaries)
```

### SobGroup_InStrikeGroup
```lua
result = SobGroup_InStrikeGroup(groupName)
```

### SobGroup_IsSelectable
```lua
result = SobGroup_IsSelectable(groupName)
```

### SobGroup_PlayerIsInSensorRange
```lua
result = SobGroup_PlayerIsInSensorRange(groupName, playerIndex)
```

### SobGroup_HasUpgrade
```lua
result = SobGroup_HasUpgrade(groupName, upgradeName)
```

### SobGroup_HasSubsystem
```lua
result = SobGroup_HasSubsystem(groupName, subsystemName)
```

### SobGroup_HasFiredAtSobGroup
```lua
result = SobGroup_HasFiredAtSobGroup(firingGroup, targetGroup, weaponName)
```

### SobGroup_SalvagedByPlayer
```lua
result = SobGroup_SalvagedByPlayer(groupName, playerIndex)
```

### SobGroup_AreAnyOfTheseTypes
```lua
result = SobGroup_AreAnyOfTheseTypes(groupName, shipTypes)
```

### SobGroup_AreAnyFromTheseAttackFamilies
```lua
result = SobGroup_AreAnyFromTheseAttackFamilies(groupName, families)
```

### SobGroup_AreAnySquadronsInsideDustCloud / InsideNebula / OutsideDustCloud / OutsideNebula
```lua
result = SobGroup_AreAnySquadronsInsideDustCloud(groupName, dustCloudList)
result = SobGroup_AreAnySquadronsInsideNebula(groupName, nebulaName)
result = SobGroup_AreAnySquadronsOutsideDustCloud(groupName, dustCloudName)
result = SobGroup_AreAnySquadronsOutsideNebula(groupName, nebulaName)
```

---

## Miscellaneous

### SobGroup_TakeDamage
```lua
SobGroup_TakeDamage(groupName, damage)
```
Applies flat damage to all ships.

### SobGroup_DoDamageProximitySobGroup
```lua
SobGroup_DoDamageProximitySobGroup(groupName, playerIndex, damage, proximity)
```

### SobGroup_Spawn
```lua
SobGroup_Spawn(groupName, volumeName)
```
Spawns ships at a volume (from level-defined squadrons).

### SobGroup_SpawnNewShipInSobGroup
```lua
SobGroup_SpawnNewShipInSobGroup(playerIndex, shipType, squadName, addToGroup, volumeName)
```
Creates a new ship and adds it to the group.

### SobGroup_CreateShip
```lua
SobGroup_CreateShip(targetGroup, shipType)
```
Creates a new ship in the group.

### SobGroup_CreateSubSystem
```lua
SobGroup_CreateSubSystem(groupName, subsystemName)
```
Creates a subsystem on ships in the group.

### SobGroup_SwitchOwner
```lua
SobGroup_SwitchOwner(groupName, newPlayerIndex)
```
Transfers ownership.

### SobGroup_Disable
```lua
SobGroup_Disable(groupName, disabled)
```
Disables group (can't act).

### SobGroup_MakeSelectable
```lua
SobGroup_MakeSelectable(groupName, selectable)
```

### SobGroup_MakeUntargeted
```lua
SobGroup_MakeUntargeted(groupName)
```

### SobGroup_SelectSobGroup / DeSelectAll
```lua
SobGroup_SelectSobGroup(groupName)
SobGroup_DeSelectAll()
```

### SobGroup_RestrictBuildOption / UnRestrictBuildOption
```lua
SobGroup_RestrictBuildOption(groupName, buildType)
SobGroup_UnRestrictBuildOption(groupName, buildType)
```

### SobGroup_Tumble / ClearTumble
```lua
SobGroup_Tumble(groupName, tumbleVector)
SobGroup_ClearTumble(groupName)
```

### SobGroup_ManualEngineGlow / AutoEngineGlow
```lua
SobGroup_ManualEngineGlow(groupName, thrust)
SobGroup_AutoEngineGlow(groupName)
```

### SobGroup_AvoidanceIgnore / ResetAvoidanceIgnore
```lua
SobGroup_AvoidanceIgnore(group1, group2)
SobGroup_ResetAvoidanceIgnore(groupName)
```

### SobGroup_ChangePower
```lua
SobGroup_ChangePower(groupName, jointName, weaponPower)
```

### SobGroup_AllowPassiveActionsAlways
```lua
SobGroup_AllowPassiveActionsAlways(groupName, enabled)
```

### SobGroup_ForceStayDockedIfDocking
```lua
SobGroup_ForceStayDockedIfDocking(groupName)
```

### SobGroup_LoadPersistantData
```lua
SobGroup_LoadPersistantData(shipType)
```
Loads persistent fleet data (campaigns).

### SobGroup_ResearchModuleExistOrSelected
```lua
result = SobGroup_ResearchModuleExistOrSelected(groupName)
```

### SobGroup_IsInControlGroup
```lua
result = SobGroup_IsInControlGroup(ctrlGroupIndex, groupName)
```

### SobGroup_AssignedToGroup
```lua
SobGroup_AssignedToGroup(groupName, groupIndex)
```

### SobGroup_IsGateDeployed
```lua
result = SobGroup_IsGateDeployed(gate1, gate2)
```

> **Deprecated functions**: `SobGroup_GetTactics` and `SobGroup_SetTactics` no longer exist in HWRM. Use ROE/Stance variables instead.
