# UI & Camera Functions

> Functions used to manipulate the user interface, dialogs, cinematic black bars, and camera positioning. Available in **Gamerule**, **Autoexec**, and related scopes.

---

## UI Functions

### Element Visibility & State

#### UI_SetElementVisible
```lua
UI_SetElementVisible(screenName, elementName, visible)
```
Shows or hides a specific element on a screen. `visible` is `1` (show) or `0` (hide).

#### UI_SetElementEnabled
```lua
UI_SetElementEnabled(screenName, elementName, enabled)
```
Enables or disables (greys out) a specific element.

#### UI_ToggleScreenElement
```lua
UI_ToggleScreenElement(screenName1, elementName1, screenName2, elementName2)
```
Toggles the visibility of elements between two screens.

#### UI_IsNamedElementVisible
```lua
result = UI_IsNamedElementVisible(screenName, elementName)
```
Returns `1` if the element is currently visible.

#### UI_SetButtonPressed
```lua
UI_SetButtonPressed(screenName, buttonName, pressedState)
```

#### UI_SetTextLabelText / UI_SetLabelTextHotkey / UI_SetButtonTextHotkey
```lua
UI_SetTextLabelText(screenName, elementName, textString)
UI_SetLabelTextHotkey(screenName, elementName, textLabel, keyNumber)
UI_SetButtonTextHotkey(screenName, buttonName, buttonText, buttonNumber)
```
Dynamically updates the text content of UI elements.

#### UI_FlashButton / UI_StopFlashButton
```lua
UI_FlashButton(screenName, buttonName, numberOfTimes)
UI_StopFlashButton(screenName, buttonName)
```
Causes a button to flash to attract the player's attention.

---

### Screen Management

#### UI_ShowScreen / UI_HideScreen / UI_ToggleScreen
```lua
UI_ShowScreen(screenName, transitionType)
UI_HideScreen(screenName)
UI_ToggleScreen(screenName, toggle)
```
Controls the display of an entire UI screen (`.lua` file in `ui/newui/`).

#### UI_SetScreenVisible / UI_SetScreenEnabled
```lua
UI_SetScreenVisible(screenName, visible)
UI_SetScreenEnabled(screenName, enabled)
```

#### UI_NextScreen / UI_PreviousScreen
```lua
UI_NextScreen(transitionType)
UI_PreviousScreen(transitionType)
```

#### UI_SetNextScreen / UI_SetPreviousScreen
```lua
UI_SetNextScreen(nextScreenName, currentScreenName)
UI_SetPreviousScreen(currentScreenName, previousScreenName)
```

#### UI_GetScreenID / UI_GetCurrentScreenID
```lua
id = UI_GetScreenID(screenName)
id = UI_GetCurrentScreenID()
```

#### UI_IsScreenActive / UI_ScreenIsActive
```lua
result = UI_IsScreenActive(screenName)
result = UI_ScreenIsActive(screenName)
```

#### UI_ReloadScreen / UI_ReloadCurrentScreen / UI_ReloadAllScreens
```lua
UI_ReloadScreen(screenName)
UI_ReloadCurrentScreen()
UI_ReloadAllScreens()
```
Forces the engine to reload UI definitions (useful for modding/debugging).

---

### Dialogs & Event Screen

#### UI_ShowDialog
```lua
UI_ShowDialog(dialogName)
```

#### UI_DialogAccept / UI_DialogAcceptID
```lua
UI_DialogAccept()
UI_DialogAcceptID(screenIndex)
```

#### UI_DialogCancel / UI_DialogCancelID
```lua
UI_DialogCancel()
UI_DialogCancelID(screenIndex)
```

#### UI_AddToEventScreen / UI_ClearEventScreen
```lua
UI_AddToEventScreen(indexString)
UI_ClearEventScreen()
```

---

### Global UI State

#### UI_SetInterfaceVisible / UI_SetInterfaceEnabled
```lua
UI_SetInterfaceVisible(visible)
UI_SetInterfaceEnabled(enabled)
```
Hides or disables the entire game interface (e.g., during cutscenes).

#### UI_BindKeyEvent / UI_UnBindKeyEvent
```lua
UI_BindKeyEvent(key, functionName)
UI_UnBindKeyEvent(key)
```
Binds a keyboard key to a global lua function.

#### UI_GiveFocus
```lua
UI_GiveFocus(fieldName, screenName)
```

#### UI_SubtitleNarrow / UI_SubtitleWide
```lua
UI_SubtitleNarrow()
UI_SubtitleWide()
```

---

## Camera Functions

Camera functions are heavily used in single-player missions and NIS (Non-Interactive Sequences).

### Cinematic Controls

#### Camera_SetLetterboxState
```lua
Camera_SetLetterboxState(state, numSeconds)
```
Transitions cinematic black bars in (`1`) or out (`0`) over `numSeconds`.

#### Camera_SetLetterboxStateNoUI
```lua
Camera_SetLetterboxStateNoUI(state, numSeconds)
```
Same as above, but explicitly ensures the UI is hidden when bars are present.

#### Camera_AllowControl
```lua
Camera_AllowControl(enable)
```
Enables or disables player control over the camera.

### Focus & Tracking

#### Camera_FocusSobGroup
```lua
Camera_FocusSobGroup(groupName, closeZoom, distance, time)
```
Smoothly moves the camera to focus on a SobGroup over `time` seconds.

#### Camera_FocusVolume
```lua
Camera_FocusVolume(volumeName, closeZoom, distance, time)
```

#### Camera_FocusCameraPoint
```lua
Camera_FocusCameraPoint(cameraPointName, distance, time)
```

#### Camera_AltFocus
```lua
Camera_AltFocus(groupName, closeZoom)
```
Focuses on a group using an alternate camera angle.

#### Camera_FocusCancel / Camera_FocusSave / Camera_FocusRestore
```lua
Camera_FocusCancel()
Camera_FocusSave()
Camera_FocusRestore()
```

#### Camera_UseCameraPoint
```lua
Camera_UseCameraPoint(cameraName)
```

### Player Camera State

#### Camera_IsFocused
```lua
result = Camera_IsFocused(groupName)
```

#### Camera_PlayerHasFocused / Camera_PlayerHasPanned / Camera_PlayerHasRotated
```lua
result = Camera_PlayerHasFocused(groupName)
result = Camera_PlayerHasPanned(distance)
result = Camera_PlayerHasRotated(degree)
```
Used primarily in tutorials to detect player camera actions.

#### Camera_ResetFocused / Camera_ResetPanned / Camera_ResetRotated
```lua
Camera_ResetFocused()
Camera_ResetPanned()
Camera_ResetRotated()
```

#### Camera_GetDistanceToSobGroup
```lua
distance = Camera_GetDistanceToSobGroup(groupName)
```

#### Camera_GetLastZoomAmount
```lua
zoom = Camera_GetLastZoomAmount()
```

### Special Effects

#### Camera_Interpolate
```lua
Camera_Interpolate(fromCameraPoint, toCameraPoint, transitTime)
```
Creates a smooth camera sweep between two predefined camera points.
