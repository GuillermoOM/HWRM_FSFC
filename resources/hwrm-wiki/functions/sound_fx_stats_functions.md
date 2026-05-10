# Sound, FX, & Stats Functions

> Functions for managing audio, visual effects, subtitles, scripted events, and post-game statistics. Available in **Gamerule**, **Autoexec**, and related scopes.

---

## Sound & Audio

### Music & Speech

#### Sound_MusicPlay
```lua
Sound_MusicPlay(fileName)
```
Plays a background music track.

#### Sound_MusicPlayType
```lua
Sound_MusicPlayType(fileName, typeIndex)
```

#### Sound_SpeechPlay
```lua
Sound_SpeechPlay(fileName)
```
Plays a voice/speech file.

#### Sound_StingerPlay
```lua
Sound_StingerPlay(fileName)
```
Plays a short music "stinger" (e.g., mission complete sound).

#### Sound_EnableAllSpeech
```lua
Sound_EnableAllSpeech(enable)
```
Enables or disables all voice chatter.

#### Sound_SpeechSubtitlePath
```lua
Sound_SpeechSubtitlePath(speechFolderPath)
```
Sets the path where the engine looks for subtitle localization text matching speech files.

#### Sound_SetMuteActor
```lua
Sound_SetMuteActor(actorName)
```
Mutes a specific voice actor type.

### Intel Events
These functions duck the background audio to prioritize incoming Intel messages.

#### Sound_EnterIntelEvent / Sound_ExitIntelEvent
```lua
Sound_EnterIntelEvent()
Sound_ExitIntelEvent()
```

---

## FX (Visual Effects)

### World Effects

#### FX_PlayEffect
```lua
FX_PlayEffect(effectName, volumeName, scale)
```
Plays an effect `.wf` file at the specified volume location.

#### FX_PlayEffectBetweenPoints
```lua
FX_PlayEffectBetweenPoints(effectName, volumeName1, volumeName2, scale)
```
Stretches an effect (like a beam or hyperspace window) between two volumes.

#### FX_StopEffect
```lua
FX_StopEffect(index)
```

### Background Effects

#### FX_PlayEffectOnBackground
```lua
FX_PlayEffectOnBackground(effectName, directionVector, scale)
```

#### FX_PlayEffectOnBackgroundVolume
```lua
FX_PlayEffectOnBackgroundVolume(effectName, volumeName, scale)
```

#### FX_StopEffectOnBackground / FX_DestroyEffectOnBackground
```lua
FX_StopEffectOnBackground(index)
FX_DestroyEffectOnBackground(index)
```

### Ship Events

#### FX_StartEvent / FX_StopEvent
```lua
FX_StartEvent(groupName, eventName)
FX_StopEvent(groupName, eventName)
```
Triggers a visual/audio event defined in a ship's `.events` file (e.g., weapon fire, death explosion).

---

## Subtitles

Subtitles are used for in-game dialog and Intel reports.

### Subtitle_Message
```lua
Subtitle_Message(messageString, duration)
```
Displays a text message on screen for the specified duration.

### Subtitle_Message_Handler
```lua
Subtitle_Message_Handler(textString, time, soundPath, playerIndex)
```
Displays a subtitle synced with an audio file.

### Subtitle_Add
```lua
Subtitle_Add(actorIndex, textString, time)
```

### Subtitle_IsMessageDone / Subtitle_IsDone
```lua
result = Subtitle_IsMessageDone()
result = Subtitle_IsDone(actorIndex)
```
Returns `1` if the current message/actor is finished speaking.

### Subtitle_TimeCounter / Subtitle_TimeCounterEnd
```lua
Subtitle_TimeCounter(index, localizedString)
Subtitle_TimeCounterEnd()
```
Displays a countdown timer on the screen.

---

## NIS Events

Functions for controlling scripted sequences defined in `.events` files.

### Event_Start
```lua
Event_Start(eventName)
```
Starts a scripted sequence.

### Event_Stop
```lua
Event_Stop(eventName)
```
Stops a currently running sequence.

### Event_IsDone
```lua
result = Event_IsDone(eventName)
```
Returns `1` if the event sequence has finished.

---

## Post-Game Statistics

These functions are primarily used internally by the engine at the end of a game to populate the stats screen, but can be queried in scripts.

> ℹ️ *Note: Many of these are hardcoded engine callbacks rather than functions you call directly. They return integer values or RUs.*

### Ships & Combat
```lua
count = Stats_TotalShipsBuilt(playerIndex)
ru    = Stats_TotalShipsBuiltInRUs(playerIndex)

count = Stats_TotalKills(playerIndex)
ru    = Stats_TotalKillsInRUs(playerIndex)

count = Stats_TotalLosses(playerIndex)
ru    = Stats_TotalLossesInRUs(playerIndex)

count = Stats_HarvestersBuilt(playerIndex)
count = Stats_ShipsCreated(playerIndex, shipTypeNumber)
count = Stats_SquadronsActive(playerIndex, shipTypeNumber)
count = Stats_SquadronsMax(playerIndex, shipTypeNumber)
```

### General
```lua
time = Stats_TotalDuration()
```
Returns total game duration.
