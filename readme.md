# Homeworld Remastered Mod: Freespace Fleet Command

This is the remaster of an existing and abandoned mod for Homeworld Remastered based of the Freespace series of games.

[Gameplay Video](https://www.youtube.com/watch?v=w_qDnGNCQX4)

[Link to the original mod this is based off](https://steamcommunity.com/sharedfiles/filedetails/?id=408410200)

## What happened to the original mod?

The main issue was with one of the updates for Homeworld Remastered that modified the way the HODs worked, the internal structure of the files changed, so the game isn't able to load old versions of HOD files anymore (which is the case of the current mod on steam). With the mod abandoned by it's creator, it was left unplayable.

## How do you play this mod?

Either install the current version in the [Steam Workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=3586658386)

Or run from the sourcecode:

1. Download the repository Zip file (click on the greed code button above and click on "download .zip")
2. Extract the main directory and change its name to "HWRM_FSFC"
3. Place the directory inside your Homeworld install directory (the one that contains all the homeworld games directories)
4. Edit the game launch parameters (via steam or a game shortcut) to have the following:

```
-moddatapath HWRM_FSFC\source
```

Launch the game, no matter which version of homeworld RM you choose (1 or 2), it will load the mod.

## Latest Changes:

- **AI Economic Revolution**: Implemented dynamic demand scaling and "Panic Spending" logic. AI now utilizes up to 100% of income and supports "True Huge" matches (300+ fighters).
- **Era-Aware Intelligence**: AI now intelligently swaps fleet rosters between FS1 (Great War) and FS2 (Second Great War) eras.
- **Shivan Economic Rebalancing**: Resolved the 11,000 RU Demon bottleneck; Shivans now scale naturally with Cain/Lilith cruisers.
- **Universal Telemetry**: New real-time census system tracks every ship in the mod (100+ hulls) for post-match data analysis.
- **AA Beam Precision**: Tuned AA Beam weaponry to prioritize point-defense roles, preventing capital ship "sniping" by anti-fighter turrets.

## What Works

- Integration with HW ships on the same game
- Terran Race:
  - All ships Migrated
  - AI
  - working fleet chatter
- Shivan Race:
  - All ships available
  - AI
  - working fleet chatter
- Vasudan Race:
  - All ships available
  - AI
  - working fleet chatter

## Current Issues

- Audio Balancing
- Weapons Balancing (ongoing fine-tuning)
- Minor Effects improvements
- Ship health Balancing
- Subsystem Hardpoint Stability (especially for FS1 variants)

## What's missing

- Original Mod Maps
- Research (might have to change some bits)
- Original Mod Gametypes
- Multiplayer (possible, untested)
- Ships subsystems (will depend on what the ship can do)
- Ship's shield effects (Reaaaaally hard thing to do)

## Current Roadmap

1. [DONE] Add Vasudan Race and Ships
2. [DONE] Add AI to Vasudans
3. Enable Multiplayer (possible, requires testing)
4. Stabilize capital ship subsystems (Alignment of FS1/FS2 hardpoints)
5. Reintegrate Research (Ship-by-ship progression)
6. Add FS Gametypes (Gauntlet, Beam-War)
7. Add FS Maps

## Brainstorming...

- Possibly add BP? (Earth Federation race/ships)
- Integrate player's patch mod for balancing (some files overlap, so I'd need to add it manually and carefully)
- Proper subspace animation (kinda impossible to do, probably wont be a thing)
- ???

## Removing unnecesary bits?

- Shields.... makes ships a bit OP? and doesn't feel easy to balance gameplay wise
- Weapon subsystems on fighters and bombers... Supposed to improve ships weapons and damage output, being that there are so many ship variances of these classes. Maybe research on unlocking the ships is enough.

## Match Analysis Tools

For developers and advanced users, the mod includes a built-in telemetry and analysis suite:

- **telemetry.lua**: A custom SCAR rule that logs real-time ship counts, economic throughput, and tactical class distribution every 30 seconds to the `HwRM.log`.
- **analyze_match.py**: Located in `resources/tools/`. A Python script that parses the match logs to generate detailed reports on AI spending, production bottlenecks, and unit survival rates.
