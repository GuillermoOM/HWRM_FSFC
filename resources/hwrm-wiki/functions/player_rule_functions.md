# Player & Rule Functions

> Player functions manage player state (RU, research, ships, alliances). Rule functions create timed callbacks — the core of game logic scripting. Available in **Gamerule**, **Autoexec**, and related scopes.

---

## Rule System

The Rule system provides timed callbacks that drive all game logic.

### Rule_Add
```lua
Rule_Add(functionName)
```
Adds a rule that runs **every game tick** (~0.1s). Use sparingly — prefer `Rule_AddInterval`.

### Rule_AddInterval
```lua
Rule_AddInterval(functionName, interval)
```
Adds a rule that runs every `interval` seconds.

| Parameter | Type | Description |
|-----------|------|-------------|
| `functionName` | string | Name of a globally-defined function |
| `interval` | float | Seconds between calls |

### Rule_Remove
```lua
Rule_Remove(functionName)
```
Removes a running rule. Safe to call from within the rule itself.

### Rule_Exists
```lua
result = Rule_Exists(functionName)
```
Returns `1` if the rule is currently active.

**Pattern — self-removing interval rule:**
```lua
Rule_AddInterval("CheckWinCondition", 5.0)

function CheckWinCondition()
    if SobGroup_Count("EnemyShips") == 0 then
        Rule_Remove("CheckWinCondition")
        -- Victory logic here
    end
end
```

---

## Player — Resources

### Player_GetRU
```lua
ru = Player_GetRU(playerIndex)
```
Returns current RU amount.

### Player_SetRU
```lua
Player_SetRU(playerIndex, amount)
```
Sets RU to exact amount.

### Player_SetBounty
```lua
Player_SetBounty(playerIndex, multiplier)
```
Sets resource bounty multiplier.

### Player_InstantlyGatherAllResources
```lua
Player_InstantlyGatherAllResources(playerIndex)
```
Instantly collects all resources on the map for this player.

---

## Player — Research

### Player_HasResearch
```lua
result = Player_HasResearch(playerIndex, researchName)
```
Returns `1` if research is completed.

### Player_CanResearch
```lua
result = Player_CanResearch(playerIndex, researchName)
```
Returns `1` if prerequisites are met.

### Player_Research
```lua
Player_Research(playerIndex, researchName)
```
Starts researching (must have prerequisites).

### Player_CancelResearch
```lua
Player_CancelResearch(playerIndex, researchName)
```

### Player_HasQueuedResearch
```lua
result = Player_HasQueuedResearch(playerIndex, researchName)
```

### Player_GrantResearchOption
```lua
Player_GrantResearchOption(playerIndex, researchName)
```
Instantly grants a research (completed, no cost).

### Player_GrantAllResearch
```lua
Player_GrantAllResearch(playerIndex)
```
Grants all research for this player.

### Player_RestrictResearchOption / UnrestrictResearchOption
```lua
Player_RestrictResearchOption(playerIndex, researchName)
Player_UnrestrictResearchOption(playerIndex, researchName)
```
Prevents/allows a specific research.

---

## Player — Ships & Build

### Player_FillShipsByType
```lua
Player_FillShipsByType(outputGroup, playerIndex, shipType)
```
Fills a SobGroup with all ships of `shipType` owned by `playerIndex`. Includes docked and hyperspace ships.

### Player_GetShipsByType
```lua
count = Player_GetShipsByType(playerIndex, shipType)
```
Returns count of a ship type.

### Player_GetNumberOfSquadronsOfTypeAwakeOrSleeping
```lua
count = Player_GetNumberOfSquadronsOfTypeAwakeOrSleeping(playerIndex, shipType)
```

### Player_NumberOfAwakeShips
```lua
count = Player_NumberOfAwakeShips(playerIndex)
```
Returns total active ship count.

### Player_FillProximitySobGroup
```lua
Player_FillProximitySobGroup(outputGroup, playerIndex, sourceGroup, distance)
```
Fills `outputGroup` with player's ships within `distance` of `sourceGroup`.

### Player_FillSobGroupInVolume
```lua
Player_FillSobGroupInVolume(outputGroup, playerIndex, volumeName)
```

### Player_IsShipInVolume
```lua
result = Player_IsShipInVolume(playerIndex, volumeName)
```

### Player_HasShipWithBuildQueue
```lua
result = Player_HasShipWithBuildQueue(playerIndex)
```
Returns `1` if player has any ship capable of building.

### Player_HasQueuedBuild
```lua
result = Player_HasQueuedBuild(playerIndex, shipType)
```

### Player_RestrictBuildOption / UnrestrictBuildOption
```lua
Player_RestrictBuildOption(playerIndex, buildOption)
Player_UnrestrictBuildOption(playerIndex, buildOption)
```

### Player_AllowDockFromUIOverride
```lua
Player_AllowDockFromUIOverride(playerIndex, shipType)
```

### Player_InstantDockAndParade
```lua
Player_InstantDockAndParade(playerIndex, sobGroupName, useHyperspaceEffect)
```

---

## Player — Identity & State

### Player_GetRace
```lua
raceName = Player_GetRace(playerIndex)
```
Returns race string (e.g., `"Hiigaran"`, `"Vaygr"`, `"Terran"`).

### Player_GetName
```lua
name = Player_GetName(playerIndex)
```

### Player_IsAlive
```lua
result = Player_IsAlive(playerIndex)
```

### Player_Kill
```lua
Player_Kill(playerIndex)
```
Eliminates the player.

### Player_SetPlayerName
```lua
Player_SetPlayerName(playerIndex, name)
```

### Player_SetBadgeTexture
```lua
Player_SetBadgeTexture(playerIndex, textureName)
```

### Player_SetTeamColours
```lua
Player_SetTeamColours(playerIndex, baseColour, stripeColour)
```
`baseColour` and `stripeColour` are `{r, g, b}` tables.

### Player_SetDefaultShipTactic
```lua
Player_SetDefaultShipTactic(playerIndex, tacticIndex)
```

### Player_ShareVision
```lua
Player_ShareVision(player1, player2, visible)
```
Enables/disables vision sharing between players.

### Player_AddLocalChatMessage
```lua
Player_AddLocalChatMessage(templateString, replacement)
```
Displays a chat message locally.

---

## Alliance Functions

### AreAllied
```lua
result = AreAllied(player1, player2)
```

### SetAlliance
```lua
SetAlliance(player1, player2)
```

### BreakAlliance
```lua
BreakAlliance(player1, player2)
```

---

## Universe Functions

### Universe_GameTime
```lua
time = Universe_GameTime()
```
Returns elapsed game time in seconds.

### Universe_PlayerCount
```lua
count = Universe_PlayerCount()
```

### Universe_CurrentPlayer
```lua
index = Universe_CurrentPlayer()
```

### Universe_Pause
```lua
Universe_Pause(paused)
```

### Universe_AllowPlayerOrders
```lua
Universe_AllowPlayerOrders(allowed)
```

### Universe_EnableSkip
```lua
Universe_EnableSkip(enabled)
```

### Universe_Fade
```lua
Universe_Fade(r, g, b, a, duration)
```
Fades screen to color over duration.

### Universe_EnableCmd
```lua
Universe_EnableCmd(cmdName, enabled)
```
Enables/disables specific player commands.

---

## Volume Functions

### Volume_AddSphere
```lua
Volume_AddSphere(name, {x,y,z}, radius)
```

### Volume_AddCube
```lua
Volume_AddCube(name, {x,y,z}, size)
```

### Volume_Delete
```lua
Volume_Delete(name)
```

---

## Objective Functions

### Objective_Add
```lua
Objective_Add(objectiveID, title, complete)
```

### Objective_AddDescription
```lua
Objective_AddDescription(objectiveID, description)
```

### Objective_SetState
```lua
Objective_SetState(objectiveID, state)
```
States: `"Active"`, `"Complete"`, `"Incomplete"`.

### Objective_GetState
```lua
state = Objective_GetState(objectiveID)
```

---

## Ping Functions

### Ping_AddSobGroup
```lua
Ping_AddSobGroup(pingID, label, groupName)
```

### Ping_AddPoint
```lua
Ping_AddPoint(pingID, label, {x,y,z})
```

### Ping_Remove
```lua
Ping_Remove(pingID)
```
