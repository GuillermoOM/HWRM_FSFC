# AI & CPU Functions

> Functions used in `ai/` scripts to control computer player behavior, production demands, and military threat analysis. These functions operate in the **AI** scope.

---

## CPU Player Control

### CPU_Enable
```lua
CPU_Enable(playerIndex, enabled)
```
Enables or disables the AI for a specific player.

### CPU_EnableAll
```lua
CPU_EnableAll(enabled)
```
Enables or disables all AI players.

### CPU_Exist
```lua
result = CPU_Exist(playerIndex)
```
Returns `1` if the player has an active AI component.

### CPU_AddDefendTarget
```lua
targetIndex = CPU_AddDefendTarget(playerIndex, volumeName, priority)
```
Tells the AI to defend a volume with a specific priority level. Returns an index that can be used to remove the target later.

### CPU_RemoveDefendTarget
```lua
CPU_RemoveDefendTarget(playerIndex, targetIndex)
```

### CPU_SetDefendTargetRadius
```lua
CPU_SetDefendTargetRadius(playerIndex, targetIndex, radius)
```

### CPU_SetDefendTargetPriority
```lua
CPU_SetDefendTargetPriority(playerIndex, targetIndex, priority)
```

### CPU_AddDefendSobGroup
```lua
CPU_AddDefendSobGroup(playerIndex, groupName, priority)
```
Tells the AI to defend a specific SobGroup.

### CPU_AddSobGroup / CPU_RemoveSobGroup
```lua
CPU_AddSobGroup(playerIndex, groupName)
CPU_RemoveSobGroup(playerIndex, groupName)
```
Adds or removes a SobGroup from the AI's internal tracking system.

### CPU_RemoveResourceBlob
```lua
CPU_RemoveResourceBlob(playerIndex, volumeName)
```
Tells the AI to stop gathering resources in the specified volume.

### CPU_SetAttackTargetPriority
```lua
CPU_SetAttackTargetPriority(playerIndex, attackGroupIndex, priority)
```
Adjusts the AI's priority for a specific attack group.

---

## AI Demand System

The AI decides what to build by accumulating "demand" for different ship classes, types, and research items.

### Class Demand
Used for general fleet composition.
```lua
ShipDemandAddByClass(shipClass, amount)
ShipDemandSetByClass(shipClass, amount)
```

*Valid Classes: `eFighter`, `eCorvette`, `eFrigate`, `eDestroyer`, `eBattleCruiser`, `eBuilder`, `eAntiFighter`, `eAntiCorvette`, `eAntiFrigate`, `eCapitalShip`, `eNonCombat`*

### Ship-Specific Demand
Used to request specific units.
```lua
ShipDemandAdd(shipType, amount)
ShipDemandSet(shipType, amount)
ShipDemandClear(shipType)
demand = ShipDemandGet(shipType)
```

### Subsystem Demand
```lua
SubSystemDemandAdd(subsystemType, amount)
SubSystemDemandSet(subsystemType, amount)
SubSystemDemandClear(subsystemType)
demand = SubSystemDemandGet(subsystemType)
```

### Research Demand
```lua
ResearchDemandAdd(researchName, amount)
ResearchDemandClear(researchName)
```

**Common Pattern:**
```lua
-- In AI logic:
if (s_selfTotalValue > 75) and (numEnemyCarriers > 1) then
    ShipDemandAdd(eDestroyer, 4.5)
end

if (numResourcers > 9) then
    ShipDemandAdd(kRefinery, 0.5)
end
```

---

## Military Analysis

These functions calculate the threat values of fleets.

### PlayersMilitaryPopulation
```lua
value = PlayersMilitaryPopulation(playerIndex, maxDistance)
```
Returns total military population of a player within a distance (usually `player_enemy` and `player_max`).

### PlayersMilitary_Total
```lua
value = PlayersMilitary_Total(playerIndex, maxDistance)
```

### Specific Threat Analysis
```lua
threat = PlayersMilitary_AntiFighter(playerIndex, maxDistance)
threat = PlayersMilitary_AntiCorvette(playerIndex, maxDistance)
threat = PlayersMilitary_AntiFrigate(playerIndex, maxDistance)
threat = PlayersMilitary_Fighter(playerIndex, maxDistance)
threat = PlayersMilitary_Corvette(playerIndex, maxDistance)
threat = PlayersMilitary_Frigate(playerIndex, maxDistance)
```

---

## Build System Queries

### BuildShipCount
```lua
count = BuildShipCount()
```

### FindHighDemandShip
```lua
shipTypeID = FindHighDemandShip()
```
Returns the ID of the ship with the highest accumulated demand score.

### Build
```lua
Build(shipTypeID)
```
Orders the AI to build the specified ship.

### IsResearchDone
```lua
result = IsResearchDone(researchName)
```

### IsResearchAvailable
```lua
result = IsResearchAvailable(researchName)
```

### IsResearchBusy
```lua
result = IsResearchBusy()
```
Returns `1` if the AI is currently researching something.

---

## KAS (Legacy HW1 Campaign AI)

*These functions were used in Homeworld 1 and are rarely used in modern HWRM skirmish AI, but still exist in the engine.*

```lua
KAS_Attack(tIndex, tParameter)
KAS_AttackFlank(tIndex, tParameter)
KAS_AttackHarrass(tIndex)
KAS_AttackPlayerMothership(tIndex)
KAS_AttackSpecial(tIndex, tParameter)
KAS_BuildControl(bValue)
KAS_BulgeAttack(tParameter, sName, sName, sName, iNumber)
KAS_GrantResearchOption(iNumber, sName)
KAS_UnrestrictResearchOption(tParameter, tString)
```
