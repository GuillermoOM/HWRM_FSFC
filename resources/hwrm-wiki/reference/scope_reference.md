# Function Scope Reference

> Homeworld Remastered uses separate Lua environments (Scopes) for different systems. Functions available in one scope are often completely restricted from others to maintain sync and engine stability.

---

## GameType & Rules
**Scopes:** `GameType`, `Gamerule`, `Level`
- **Purpose**: Defines win/loss conditions, starting logic, hyperspace events, and general map state.
- **Allowed Logic**: Can use full Lua standard library. Uses `Rule_Add` and `Rule_Remove`.
- **Restrictions**: Cannot directly manipulate AI variables or UI displays.

## Artificial Intelligence (AI)
**Scopes:** `AI`, `CPU`
- **Purpose**: Governs computer player logic, ship building prioritization (demand), and research choices.
- **Allowed Logic**: Uses engine-restricted Lua 4.0. Contains unique functions like `ShipDemandAdd` and `Build`.
- **Restrictions**: `math.random` and `print` are disabled. Must use `sg_random` and `aitrace`. Strict deterministic execution.

## User Interface (UI)
**Scopes:** `UI`, `Autoexec`, `MainUI`
- **Purpose**: Handles rendering, screen state, button presses, and localized strings.
- **Allowed Logic**: `UI_` prefixed functions. Can bind commands to hotkeys.
- **Restrictions**: Extremely isolated. Cannot read ship health or game state directly without specific bridging hooks.

## Entity Configuration
**Scopes:** `Ship`, `Weapon`, `SubSystem`, `Missile`, `Resource`
- **Purpose**: Defines the stats and visual representation of objects in the game engine.
- **Allowed Logic**: Strict structural initialization functions (e.g., `StartShipConfig`).
- **Restrictions**: These scripts are read exactly once when the game loads. You cannot run dynamic update logic here; logic must be run via `addCustomCode` in gamerules or ship custom scripts.

## Visual & Audio Logic
**Scopes:** `SpeechLogic`, `Subtitle`, `Event`, `Madstate`, `FX`
- **Purpose**: Triggers chatter, subtitle displays, and engine-driven animations (opening doors, deploying weapons).
- **Allowed Logic**: Timing-based execution (`getTime`, `startAnim`).
