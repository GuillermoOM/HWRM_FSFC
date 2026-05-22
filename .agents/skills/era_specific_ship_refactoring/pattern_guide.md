# Skill: Era-Specific Ship Refactoring (Separate Ship Pattern)

## Goal
Implement deep architectural changes (like replacing beam weaponry with ballistics) for shared ship classes across different eras (FS1 vs FS2) where research-based toggles are insufficient.

## The "Separate Ship" Pattern

When a ship (e.g., `ter_orion`) exists in both eras but requires fundamentally different hardpoint or weapon configurations that are hardcoded in the `.ship` file, use the **Separate Ship Pattern**.

### 1. Create the Era-Specific Variant
Create a new ship directory with the `_fs1` suffix.
- Folder: `source/ship/ter_orion_fs1/`
- Ship file: `ter_orion_fs1.ship`

### 2. Configure the `.ship` File
- Update `displayedName` to include the era: `NewShipType.displayedName = 'GTD Orion (FS1)'`.
- Replace modern FS2 weaponry (beams) with era-appropriate FS1 weaponry (blobs/lasers) using `StartShipWeaponConfig` or `StartShipHardPointConfig`.
- Ensure `LoadModel()` points to the correct shared or variant HOD.

### 3. Register in Build Menu (`def_build.lua`)
Add the variant to the race's `def_build.lua`.
```lua
{
    Type = Ship,
    ThingToBuild = "ter_orion_fs1",
    RequiredResearch = "Orion_FS1_Tech",
    -- ...
}
```

### 4. Era Gating (`fs_deathmatch.lua`)
Restrict the appropriate variant based on the active game mode.
```lua
-- In FS1 Mode:
Player_RestrictBuildOption(playerIndex, "ter_orion") -- Hide FS2 version
-- In FS2 Mode:
Player_RestrictBuildOption(playerIndex, "ter_orion_fs1") -- Hide FS1 version
```

### 5. AI Integration (`ai_build.lua` & `ai_upgrades.lua`)
Update the AI to recognize the variant.
- **`ai_build.lua`**: Map the era-appropriate constant.
  ```lua
  if (FS_ERA == 1) then
      kDestroyer = TER_ORION_FS1
  else
      kDestroyer = TER_ORION
  end
  ```
- **`classdef.lua`**: Register both variants in the same class (e.g., `ClassDestroyer`) so AI tactics and fleet demand logic apply to both.
- **`ai_upgrades.lua`**: Update research demand logic to check for the presence of either variant.

## Why use this instead of Subsystem Swapping?
- **Stability**: Hardcoded weapon configurations in `.ship` files are more stable than runtime subsystem attachments for core weaponry.
- **AI Intelligence**: AI can be explicitly told which variant to build for the current era without complex logic to "choose" the right subsystem.
- **UI Clarity**: Correct names (e.g., "GTD Orion (FS1)") appear in the build menu and overlays.

## Critical Gotchas
- **Family List**: Ensure both ship variants use valid families from `familylist.lua`.
- **Unit Caps**: Both variants must be registered in `unitcaps/normal.lua` to be buildable.
- **HOD Sharing**: If the models are identical, `ter_orion_fs1.ship` can point to `ter_orion.hod` to save space.
