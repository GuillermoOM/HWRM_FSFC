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
If your mod uses custom "Era" nodes (like `Freespace1` and `Freespace2`) that have no prerequisites but are manually `Restricted` by your game rule, the vanilla `research_init` script will crash when it tries to force-grant them.

**The Fix:**
Add `DoNotGrant = 1` to any dummy/era research nodes in your `def_research.lua`. This flags the node so the vanilla script ignores it, preventing the crash while still allowing your custom game rules to manually unrestrict/grant them.
```lua
	{
		Name = "Freespace2",
		RequiredResearch = "",
		DoNotGrant = 1, -- CRITICAL: Prevents "Research Off" crashes
	}
```
