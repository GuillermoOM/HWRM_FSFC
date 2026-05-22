# Custom Races & Game Rules Setup

When adding custom races or new game rules (Eras, game modes) to Homeworld Remastered, there are several engine quirks that can cause silent failures, "Unknown Race" warnings, and Lua script crashes.

## 1. The UI-to-Engine Race Index Bug

**Symptom:** You select your custom race in the multiplayer lobby, but the game loads you as `Unknown Race [Hiigaran]` and none of your custom scripts/build menus work.
**Cause:** The multiplayer lobby UI does not send the actual "Name" or "ID" of the race to the engine. It sends the **raw index position** of your selection in the dropdown menu.
- The Engine discovers all races (vanilla + modded) and builds a global absolute array (e.g., 16 total races). In this global array, index `0` is always `Hiigaran`.
- If your custom game rule uses an `ExtFilter` that hides vanilla races from the UI lobby, the dropdown menu shrinks (e.g., only 4 modded races).
- When you select the first race in that small dropdown, the UI sends `0` to the engine. The engine interprets `0` as `Hiigaran`!

**The Fix:**
You must ensure the UI dropdown matches the Engine's global race array. 
The standard workaround is to set `ExtFilter = "rules_dm"` in your `.lua` rule config file. This forces the UI to display all available vanilla and modded races, meaning the dropdown index you select will perfectly align with the engine's absolute array index.
*(Note: To protect against users selecting vanilla races, you should add safety checks to your rule initialization scripts, checking the `Prefix` of the race and restricting/skipping custom logic for vanilla races.)*

## 2. PlayerRace_GetString and String Properties

When referencing a player's custom properties from a Rule script (e.g., `PlayerRace_GetString(playerIndex, "Prefix", "")`), the engine does NOT look inside the core `.race` or `.lua` race definition file.

Instead, the engine strictly queries the `props/default.lua` file of the selected race.
**The Fix:**
Any custom variables your UI or Game Rule scripts need must be added to the `String_Properties` or `Number_Properties` arrays inside `[race_folder]/props/default.lua`.
```lua
String_Properties = {
	Prefix = "TER_", -- Required for race validation in scripts
	path_build = [[data:scripts/races/terran/scripts/def_build.lua]],
}
```

## 3. The "Research: Off" Crash with Era/Dummy Nodes

**Symptom:** `luaplayer 300: Player_GrantResearchOption: unable to grant (EraNode)`
**Cause:** If a player starts a game with the lobby setting "Research: Off", the vanilla `lib/research.lua` script runs `research_init` at `t=5.1s`. This script loops through the entire `def_research.lua` file and attempts to grant **every** node that has no prerequisites (`RequiredResearch = ""`).
If your mod uses custom "Era" nodes (like `FS1` and `FS2`) that have no prerequisites but are manually `Restricted` by your game rule, the vanilla `research_init` script will crash when it tries to force-grant them, or it will override your restrictions and grant both eras!

**The Fix:**
You must implement a delayed re-restriction timer in your game rule logic. Allow `research_init` to execute, and then use an interval timer to explicitly re-restrict the unwanted era shortly after.
```lua
	elseif timer_timing == 2 then
		-- After research_init has run, we MUST re-restrict the unwanted era
		for i = 0, Universe_PlayerCount() - 1 do
			local racePrefix = strsub(PlayerRace_GetString(i, "Prefix", ""), 1, 3)
			if (racePrefix == "TER" or racePrefix == "VAS" or racePrefix == "SHI") then
				Player_RestrictResearchOption(i, "FS2") -- Restrict the unused era
			end
		end
```

## 4. Empty String API Lockouts

**Symptom:** All build or research options are permanently greyed out and the menu is completely frozen.
**Cause:** Calling engine restriction APIs like `Player_RestrictBuildOption` or `Player_RestrictResearchOption` with an empty string (`""`) triggers a silent engine fault that completely locks the UI queue.
**The Fix:**
Always check that your custom restriction string is not empty before passing it to the engine. Additionally, remember that `Player_RestrictBuildOption` **only accepts a single string argument** (one ship or subsystem). It does not parse comma-separated lists. If you need to hide multiple ships (like an entire era's roster), you must iterate over a Lua table and restrict them individually:
```lua
local ships_to_hide = {"ter_ares", "ter_erinyes"}
for i, ship in ships_to_hide do
	Player_RestrictBuildOption(playerIndex, ship)
end

-- Safely process a dynamic restriction variable
local restrictString = PlayerRace_GetString(playerIndex, "dm_build_restrict", "")
if restrictString ~= "" then
	Player_RestrictBuildOption(playerIndex, restrictString)
end
```

## 5. Unit Capacity & Build Lockouts

**Symptom:** A ship appears in the build menu, but the build button is greyed out or shows "0/0" capacity, even if you haven't built anything.
**Cause:** Homeworld Remastered uses a hierarchical unit cap system defined in `familylist.lua` (see `unitcapsFamily`) and configured in `scripts/rules/[mode]/unitcaps/*.lua`.
- Every family assigned to a ship via `setSupplyValue(NewShipType, 'FamilyName', 1.0)` must have a corresponding `supplyLimit("FamilyName", X)` entry in the active unit cap file.
- If a ship uses multiple families (e.g., GTF Loki uses both `Fighter` and `Scout`), **both** families must have a limit > 0 defined. If even one family has a limit of 0 (or is undefined), the ship cannot be built.

**The Fix:**
Ensure all families used by your mod's ships are declared in the game mode's `unitcaps/` folder (`small.lua`, `normal.lua`, `large.lua`, `huge.lua`, and `default.lua`).
```lua
-- Generic families
supplyLimit("Fighter", 135)
supplyLimit("Scout", 135) -- Missing Scout will lock out Loki/Pegasus!

-- Custom Freespace families
supplyLimit("Cruiser", 25)
supplyLimit("AdvancedCruiser", 5)

-- Indents for UI organization
supplyIndent("Scout", 1) -- Indents Scout under Fighter in the cap menu
```
**Note on Race-Specific Caps:**
Individual race folders also contain `unitcaps/` definitions (e.g., `scripts/races/terran/deathmatch/unitcaps/`). If your game mode relies on these race-specific files, they must also be updated to include all custom families used by that race's roster.
