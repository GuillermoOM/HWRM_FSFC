# Creating a New Ship

> A step-by-step guide to adding a completely new ship to the game, rather than replacing an existing one.

---

## 1. File Structure Setup

Every ship requires a dedicated directory inside the `Data\Ship\` folder. The directory name, the `.ship` file name, the `.hod` (model) file name, and the `.events` file name must all be identical.

For this tutorial, we will create a new "Super Scout" by duplicating the vanilla Hiigaran Scout.

1. Extract the vanilla `hgn_scout` folder from the base game `.big` files.
2. Copy the entire folder to your mod's data directory: `my_mod\ship\hgn_scout\`
3. Rename the directory to `my_mod\ship\hgn_superscout\`
4. Rename the files inside the folder to match the new directory:
   - `hgn_scout.ship` -> `hgn_superscout.ship`
   - `hgn_scout.hod` -> `hgn_superscout.hod`
   - `hgn_scout.events` -> `hgn_superscout.events`
   - `hgn_scout.madstate` -> `hgn_superscout.madstate` *(if it exists)*

## 2. Modifying the Ship Definition

Now we need to update the ship script to reflect its new identity.

1. Open `hgn_superscout.ship` in your text editor.
2. The engine uses the filename automatically as the ship's internal class name, but we need to update the display name.
3. Find the line:
   ```lua
   NewShipType.displayedName = "$1500"
   ```
4. Change it to a plaintext string, or a new string ID from your localization files:
   ```lua
   NewShipType.displayedName = "Super Scout"
   ```
5. *(Optional)* Modify any other stats like `maxhealth` or `mainEngineMaxSpeed` to differentiate it from the base scout.

## 3. Adding to the Build Manager

If your ship is buildable by a Mothership or Carrier, the engine needs to know how much it costs, how long it takes, and what the prerequisites are.

1. Navigate to your mod's build scripts: `my_mod\scripts\building and research\hiigaran\`
2. Open `build.lua`.
3. Scroll to the bottom of the table and add a new entry:
   ```lua
   {
       Type = Ship,
       ThingToBuild = "Hgn_SuperScout",
       RequiredResearch = "",
       RequiredShipSubSystems = "",
       DisplayPriority = 11,
       DisplayedName = "Super Scout",
       Description = "<b>Description:</b> An advanced scouting vessel.\n\n<b>Prerequisites:</b> None.",
   },
   ```
*(Note: If the `ThingToBuild` does not exactly match the `.ship` filename, the game will crash when trying to render the build menu.)*

## 4. Fixing UI Icons

Without an explicit definition, the game will display a placeholder box or a derilect icon in the build menu and tactical overlay.

1. Navigate to `my_mod\ship\icons\`.
2. Open `shipicons.lua`.
3. Link the new ship to an existing icon set by adding a line at the bottom:
   ```lua
   Hgn_SuperScout = Hgn_Scout
   ```
   *(This tells the UI engine: "Whenever you need an icon for Hgn_SuperScout, use the definitions mapped for Hgn_Scout.")*

## 5. Scripting Constraints (Crucial)

When defining new ships, strictly follow these engine rules to prevent fatal crashes:

1. **Variable Ordering**: In the `.ship` file, `LoadModel()` **MUST** be called before `StartShipWeaponConfig()` or `StartShipHardPointConfig()`. Failure to adhere to this order guarantees a crash on load.
2. **Family Names**: Any string assigned to `NewShipType.AttackFamily`, `ArmourFamily`, `BuildFamily`, or `AvoidanceFamily` **must** exist in `scripts\familylist.lua`. If you define a new family on your ship, you must append it to the global family list.
3. **Paths**: Always use relative paths prefixed with `data:`, for example:
   ```lua
   NewShipType.customCodeString = "data:scripts/custom/superscout_logic.lua"
   ```

## 6. Placing the Ship in Custom Maps

If you want to spawn the ship directly via level scripts (e.g., in a custom map or campaign), use `addSquadron`:

```lua
addSquadron("MyScoutSquadron", "hgn_superscout", {0, 0, 0}, 0, {0, 0, 0}, 0, 0)
```
- Argument 2: The exact filename of the ship type (`"hgn_superscout"`).
- Argument 4: The player index (`0` for Player 1, `-1` for capturable/neutral).
