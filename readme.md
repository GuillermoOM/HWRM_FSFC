# Homeworld Remastered Mod: Freespace Fleet Command

This is the remaster of an existing and abandoned mod for Homeworld Remastered based of the Freespace series of games.

[Gameplay Video](https://www.youtube.com/watch?v=w_qDnGNCQX4)

[Link to the original mod this is based off](https://steamcommunity.com/sharedfiles/filedetails/?id=408410200)

## What happened to the original mod?

The main issue was with one of the updates for Homeworld Remastered that modified the way the HODs worked, the internal structure of the files changed, so the game isn't able to load old versions of HOD files anymore (which is the case of the current mod on steam). With the mod abandoned by it's creator, it was left unplayable.

## How do you play this mod?

Releases are not there yet, but for now you can do the following:

1. Download the repository Zip file (click on the greed code button above and click on "download .zip")
2. Extract the main directory and change its name to "HWRM_FSFC"
3. Place the directory inside your Homeworld install directory (the one that contains all the homeworld games directories)
4. Edit the game launch parameters (via steam or a game shortcut) to have the following:

```
-moddatapath HWRM_FSFC\source
```

Launch the game, no matter which version of homeworld RM you choose (1 or 2), it will load the mod.

## Latest Changes:

- Full Vasudan Race Addition

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
- Weapons Balancing
- Minor Effects improvements
- Ship health Balancing
- AI Still needs some improvements

## What's missing

- Original Mod Maps
- Research (might have to change some bits)
- Original Mod Gametypes
- Multiplayer (possible, untested)
- Ships subsystems (will depend on what the ship can do)
- Ship's shield effects (Reaaaaally hard thing to do)

## Current Roadmap

1. Add Vasudan Race and Ships
2. Add AI to Vasudans
3. Enable Multiplayer (for testing purposes)
4. Add capital ships subsystems (missing on many ships, needed before implementing research)
5. Reintegrate Research
6. Add FS Gametypes
7. Add FS Maps
8. Add Gauntlet Gametype (From existing mod)

## Brainstorming...

- Possibly add BP? (Earth Federation race/ships)
- Integrate player's patch mod for balancing (some files overlap, so I'd need to add it manually and carefully)
- Proper subspace animation (kinda impossible to do, probably wont be a thing)
- ???

## Removing unnecesary bits?

- Shields.... makes ships a bit OP? and doesn't feel easy to balance gameplay wise
- Weapon subsystems on fighters and bombers... Supposed to improve ships weapons and damage output, being that there are so many ship variances of these classes. Maybe research on unlocking the ships is enough.
