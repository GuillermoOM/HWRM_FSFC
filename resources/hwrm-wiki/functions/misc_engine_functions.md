# Miscellaneous Engine & SCAR Functions

> Functions for managing cutscenes (NIS), front-end menus, SCAR (Scripting at Relic) utilities, and standard Lua/engine built-ins. Available primarily in **Gamerule** and **UI** scopes.

---

## SCAR Utilities (HW2_)

These functions are defined in `Data/Scripts/Scar/scar_util.lua` and provide high-level wrappers around complex engine functions for single-player campaign scripting.

### Cinematic Wrappers
```lua
HW2_Fade(state)
HW2_Letterbox(switch)
HW2_Pause(onOff)
HW2_Wait(time)
```

### Event Pointers
Creates 3D UI indicators pointing at objects in the world.
```lua
HW2_CreateEventPointerSobGroup(groupName)
HW2_CreateEventPointerSubSystem(subsystemType, groupName)
HW2_CreateEventPointerVolume(volumeName)
```

### Dialogue & Info
```lua
HW2_LocationCardEvent(textString, time)
HW2_SubTitleEvent(actorIndex, textString, time)
```

---

## Non-Interactive Sequences (NIS)

Functions for controlling pre-rendered or engine-rendered cutscenes.

### NISLoad
```lua
NISLoad(nisPath)
```
Loads a NIS file into memory.

### NISPlay / NISPlayFromGroup
```lua
NISPlay(nisPath)
NISPlayFromGroup(nisPath, groupName)
```
Plays a NIS, optionally anchoring it to the position of a specific SobGroup.

### NISComplete
```lua
NISComplete(nisIndex)
```
Called when a NIS finishes.

### NISSetSkippable
```lua
NISSetSkippable(skippable)
```
Allows the player to press ESC to skip the cutscene.

---

## Front-End Menus (FE_)

Functions triggered by UI buttons to manage game state transitions.

### FE_LoadGameScreen / FE_SaveGameScreen
```lua
FE_LoadGameScreen()
FE_LoadGameScreen_Campaign()
FE_LoadGameScreen_RecordedGame()
FE_SaveGameScreen()
FE_SaveGameScreen_Campaign()
```
Opens the respective load/save UI dialogues.

### FE_RestartGame
```lua
FE_RestartGame(confirmFlag)
```

### FE_Retire
```lua
FE_Retire(stringToEvaluate)
```
Retires the local player and brings up the game over screen.

### FE_ExitToMainMenu / FE_ExitToWindows
```lua
FE_ExitToMainMenu()
FE_ExitToWindows()
```

---

## ATI (Advanced Text Interface)

The ATI system renders dynamic text and graphics directly to the screen HUD without using the standard UI `.lua` screen system. Often used for debug info or custom HUD elements.

### Setup & Rendering
```lua
ATI_LoadTemplates(fileName)
ATI_Display2D(templateName, rectangle, visibility)
ATI_Display3D(templateName, position, scale, screenSize, visibility)
```

### Passing Parameters
Used to feed data into ATI templates before drawing them.
```lua
ATI_CreateParameters(length)
ATI_AddString(index, parameterString)
ATI_AddWString(index, wideString)
ATI_AddFloat(index, parameterFloat)
ATI_AddColour(index, colorTable)
ATI_AddPosition(index, positionTable)
ATI_AddGraphic2D(index, paramString)
ATI_AddGraphic3D(index, paramString)
ATI_Clear()
```

---

## Profile Management

Functions interacting with the player's saved profile (e.g., campaign progress).

```lua
Profile_SetMissionsComplete(campaignName, missionIndex)
Profile_SetSingleMissionComplete(campaignName, missionIndex)
Profile_UnlockAll()
Profile_UnlockMovies()
```

---

## Engine Built-ins & Debug

### aitrace
```lua
aitrace(messageString)
```
Prints a debug string to the AI trace log (`HwRM.log` when running with `-traceAI`). This is the primary debugging tool for AI scripts.

### Lua Standards
HWRM uses Lua 4.0. Standard functions available include:
- `strlen(string)`: Returns string length (do not use `string.len`).
- `strsub(string, start, end)`: Substring.
- `deg(radians)` / `rad(degrees)`: Math conversions.
- `print(message)`: Outputs to `HwRM.log`.
- `getglobal(name)`: Retrieves global variable by string name.
- `type(variable)`: Returns string type ("number", "string", "table").

### LOD & Rendering
```lua
LOD_SetDesiredFPS(fpsTarget)
setDetailLevel(level)
toggleNavLights()
```
