# Command Line Parameters (Launch Options)

> These parameters can be added to your Steam Launch Options (Right Click HWRM -> Properties -> General -> Launch Options) or appended to a Windows desktop shortcut to modify how the engine boots, renders, and logs data.

---

## Mod Loading
- **`-moddatapath <path>`**: Loads uncompressed loose files from `HomeworldRM\<path>` to overwrite the base game `.big` files. **This is the primary method for local mod development.** (Example: `-moddatapath GBXTools\WorkshopTool\my_mod`).
- **`-mod <mod.big>`**: Loads a packed `.big` mod file located in the `HomeworldRM\Data\` directory.
- **`-workshopmod <path\mod.big>`**: Loads a packed `.big` file downloaded from the Steam Workshop. You can chain multiple mods using commas.

## Graphics & Window Management
- **`-windowed`** or **`-window`**: Launches the game in a standard window.
- **`-fakeFullscreen`**: Borderless Windowed mode. Highly recommended for modders who need to Alt+Tab frequently.
- **`-forceResolution -w <width> -h <height>`**: Forces a specific resolution (e.g., `-forceResolution -w 1920 -h 1080`).
- **`-noPause`**: Prevents the game from automatically pausing when you Alt+Tab out of the window.

## Debugging & Logging
- **`-luatrace`**: Enables verbose Lua tracing in `HwRM.log`. **Crucial for identifying script syntax errors.**
- **`-traceHODs`**: Dumps detailed information regarding 3D model `.HOD` files into the log. Useful if a ship model is crashing the game.
- **`-logfilename=<path>`**: Overrides the default log location.
- **`-textfeedback`**: Dumps all UI text feedback into a text file in the main directory.
- **`-aiplayerlog`**: Outputs detailed AI decision-making (Demand levels, fleet composition goals) to text files for debugging AI scripts.

## Developer & Testing
- **`-nomovies`**: Skips the Gearbox intro logos and loads directly to the main menu.
- **`-superTurbo`**: Radically accelerates the game simulation speed. Highly useful for testing long-term AI behavior or slow unit paths.
- **`-load <mapname>`**: Bypasses the main menu and loads directly into a specific map.
- **`-developer`**: Enables internal developer UI menus in-game.
- **`-balance`**: Enables the internal balance test screen on the main menu, allowing rapid generation of specific unit match-ups.

## Audio & Interface
- **`-nosound`**: Completely disables the audio engine. Useful to rule out sound-buffer related crashes.
- **`-closeCaptioned`**: Forces subtitles in cutscenes.
- **`-uiLeft=<pos>` / `-uiRight=<pos>`**: Forces the UI boundaries, useful for clamping the UI to the center monitor on ultra-wide or triple-monitor setups.
