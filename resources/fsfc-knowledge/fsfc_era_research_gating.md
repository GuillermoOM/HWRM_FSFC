# HWRM_FSFC: Era Gating & Research Progression

This document outlines the standard implementation for era progression (FreeSpace 1 vs FreeSpace 2) and ship unlocking in the FreeSpace: Fleet Command mod.

## 1. Pure Research Escalation (No Subsystems)
To prevent engine-level build menu lockouts, the mod completely eschews the use of `RequiredShipSubSystems` in the `.ship` and `def_build.lua` configurations. 
* Do not require "Fighterbay", "Communication", or similar hardpoint subsystems to unlock ships.
* All progression is handled exclusively through `RequiredResearch` nodes.
* Each ship should have an exact corresponding research node mapping in `def_build.lua` (e.g., the `ter_valkyrie` ship requires the `"Valkyrie"` research node).

## 2. Era Nodes and the `def_research.lua` Tree
The progression tree utilizes explicit era-gating nodes: `FS1` and `FS2`.
* These nodes act as the primary foundation for the tech tree.
* Ships that are exclusive to a certain era append the era condition to their research node prerequisites using the logical AND operator (`&`) or the logical OR operator (`|`).
* Example: `RequiredResearch = "FighterDesign & FS1"` ensures the Valkyrie node can only be researched if the player is in the FS1 era.

## 3. Game Mode Rule Enforcement
The `fs1_deathmatch.lua` and `fs2_deathmatch.lua` game rules strictly govern the active era.
1. **Initial Granting:** Upon game start, the active rule explicitly grants the corresponding era (e.g., `Player_GrantResearchOption(i, "FS1")`) and restricts the unused era (e.g., `Player_RestrictResearchOption(i, "FS2")`).
2. **"Research: Off" Workaround:** If a lobby is created with "Research: Off", the vanilla `research_init` script will attempt to auto-grant both `FS1` and `FS2` because they have no prerequisites. To fix this, the custom rule utilizes a delayed timer (`timer_timing == 2`) to **re-restrict** the unwanted era immediately after the vanilla init script finishes.

## 4. API Safety Constraints
Never pass an empty string (`""`) to `Player_RestrictBuildOption` or `Player_RestrictResearchOption`. Doing so will permanently fault the build queue and lock the player out of the UI. Always validate that your restriction variables (like `dm_build_restrict` in `props/default.lua`) evaluate to a populated string before executing the API.

## 5. The "Research: Off" Bypass Bug
When a lobby is created with "Research: Off", the engine completely bypasses the `def_research.lua` tree logic for determining build requirements. It essentially auto-unlocks everything, unless a node is manually restricted.
* **The Pitfall:** If a ship's `RequiredResearch` in `def_build.lua` only points to its own node (e.g. `"Ares"`), and only the parent era node (`"FS2"`) is restricted by the game mode, the engine will still allow the player to build the Ares. It does not perform recursive prerequisite checks when research is off!
* **The Solution:** You MUST append the era tag directly onto the ship's build prerequisite in `def_build.lua` (e.g., `RequiredResearch = "Ares & FS2"`). When the engine sees `FS2` on the ship itself, and knows `FS2` is explicitly restricted by the game rule, it will properly enforce the lockout.

## 6. UI Organization & Hiding Ships
* **Hiding Out-of-Era Ships:** Merely restricting research will leave out-of-era ships visible in the UI, permanently grayed out. To completely hide them, your `fs1_deathmatch.lua` script must iterate through an array of those ships and explicitly call `Player_RestrictBuildOption(playerIndex, ship)`.
* **Ship Ordering:** The order ships appear in the build UI is controlled strictly by the `DisplayPriority` integer in `def_build.lua` (lower numbers appear higher in the list). Assign logical numbering blocks (e.g., Fighters 10-29, Bombers 30-49) to group ships chronologically by Era.
