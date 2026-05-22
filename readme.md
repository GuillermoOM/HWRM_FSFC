# Homeworld Remastered Mod: Freespace Fleet Command

This is the remaster of an existing and abandoned mod for Homeworld Remastered based of the Freespace series of games.

[Gameplay Video](https://www.youtube.com/watch?v=w_qDnGNCQX4)

[Link to the original mod this is based off](https://steamcommunity.com/sharedfiles/filedetails/?id=408410200)

## What happened to the original mod?

The main issue was with one of the updates for Homeworld Remastered that modified the way the HODs worked, the internal structure of the files changed, so the game isn't able to load old versions of HOD files anymore (which is the case of the current mod on steam). With the mod abandoned by it's creator, it was left unplayable.

## How do you play this mod?

Either install the current version in the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3586658386)

Or run from the sourcecode:

1. Download the repository Zip file (click on the green code button above and click on "download .zip")
2. Extract the main directory and change its name to "HWRM_FSFC"
3. Place the directory inside your Homeworld install directory (the one that contains all the homeworld games directories)
4. Edit the game launch parameters (via steam or a game shortcut) to have the following:

```
-moddatapath HWRM_FSFC\source
```

Launch the game, no matter which version of homeworld RM you choose (1 or 2), it will load the mod.

## Latest Changes (Research Branch Overhaul):

- **Unified Game Rules & Match Rules**: Purged legacy, outdated STC library files and unified FS1 and FS2 rulesets into a single, highly polished `freespace_deathmatch` game mode. Included custom starting fleets, era gating rules, and unit capacity controls.
- **Advanced ship-dependent Tech Tree & Research**: Fully restored ship-by-ship progression research requirements, making unlock paths tactical, progressive, and highly rewarding.
- **AI Economic & Strategic Overhaul**: Implemented dynamic demand scaling and "Panic Spending" logic. AI now utilizes up to 100% of income, supports "True Huge" matches (300+ fighters), and prioritizes early-game scouting/reconnaissance.
- **Era-Aware Fleet Rosters & FS1 Variants**: Added fully-configured FS1-era capital ship and strike craft variants (such as GTD Orion FS1, GVD Hatshepsut FS1, GTC Fenris FS1, and SC Cain FS1) with proper innate subsystems and hardpoint spacing.
- **Universal Telemetry & Development Suite**: Real-time census and telemetry track ship counts and economics during play. Added custom Python scripts (`analyze_match.py`, `timeline_analysis.py`, etc.) for balancing, family auditing, and log parsing.
- **Engine-Level Stability & Lua 4.0 Compatibility**: Resolved critical Lua 4.0 gotchas such as the closure restriction (no upvalues in `foreach`) and the weapon burst infinite-fire-rate bug, resulting in a rock-solid, crash-free gameplay experience.

## What Works

- Integration with HW ships in the same game.
- **Terran Race**: All ships fully migrated, with robust AI, custom progression tech trees, and working ship chatter.
- **Shivan Race**: All ships migrated, custom AI, fully-integrated tech progression, and working chatter.
- **Vasudan Race**: All ships migrated, custom AI, fully-integrated tech progression, and working chatter.
- **Freespace Deathmatch Ruleset**: Consolidated gamemode including custom starting fleets, era gating rules, resource injection, and unit capacity controls.

## Current Issues / Tuning

- Ongoing fine-tuning of weapon/ship balance.
- Visual effect improvements for subspace jumps and shields.

## Match Analysis & Modding Tools

For developers and advanced users, the mod includes a built-in telemetry and analysis suite:

- **telemetry.lua / ai_telemetry.lua**: Custom SCAR rules that log real-time ship counts, economic throughput, and tactical class distribution every 30 seconds to the `HwRM.log`.
- **Python Tooling** (located in `resources/tools/`):
  - `analyze_match.py` / `timeline_analysis.py`: Generate detailed post-match reports on spending, production, and bottleneck metrics.
  - `realtime_telemetry.py`: Plots live graphs and stats.
  - `extract_ship_stats.py`: Automatically parses and generates ship/weapon balance statistics.
  - `audit_families.py` / `fix_families.py`: Ensures perfect alignment with family rules.

## Documentation & Developer Resources

This repository now contains a comprehensive, engine-specific knowledge base to make development easy and robust:
- **FSFC Knowledge Base** (`resources/fsfc-knowledge/`): Documents detailing the FSFC AI architecture, ship balance sheets, unit capacity guidelines, and era gating mechanics.
- **HWRM Wiki Reference** (`resources/hwrm-wiki/`): A complete reference of Homeworld Remastered Lua 4.0 gotchas, engine API functions, LSP-stubs, variable mappings, and step-by-step modding tutorials.

## Roadmap Progress

1. [DONE] Add Vasudan Race and Ships
2. [DONE] Add AI to Vasudans
3. [DONE] Reintegrate Research & Tech Trees (Ship-by-ship progression)
4. [DONE] Stabilize capital ship subsystems (Alignment and innate loading of FS1/FS2 hardpoints)
5. [DONE] Unify rules and game types into `freespace_deathmatch`
6. [DONE] Integrate advanced telemetry and developer tools
7. [PENDING] Add custom FS Maps
8. [PENDING] Multiplayer testing & verification
