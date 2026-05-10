# Getting Started with Homeworld Remastered Modding

> A concise guide to setting up your modding environment and running your first mod.

---

## 1. Prerequisites and Tooling

To mod Homeworld Remastered (HWRM), you need the official toolset provided by Gearbox.
1. Open Steam.
2. Navigate to **Library -> Tools**.
3. Locate and install the **Homeworld Remastered Toolkit**.
4. The tools will be installed to:  
   `C:\Program Files (x86)\Steam\steamapps\common\Homeworld\GBXTools\`

## 2. Extracting Game Data

HWRM stores all of its moddable assets (scripts, ships, UI) inside compressed `.big` files located in the `HomeworldRM\Data` directory. You use the `Archive.exe` command-line tool to extract them.

1. Open your Command Prompt or Terminal.
2. Navigate to the tool's directory:
   ```bash
   cd "C:\Program Files (x86)\Steam\steamapps\common\Homeworld\GBXTools\WorkshopTool"
   ```
3. Extract the contents of a `.big` file (for example, `HW2Ships.big`) into a new working folder (e.g., `my_mod`):
   ```bash
   Archive.exe -a "C:\...\Homeworld\HomeworldRM\Data\HW2Ships.big" -e my_mod
   ```
4. **Important Optimization**: Only keep the files you intend to modify in your `my_mod` folder. Delete everything else. The game engine will load the base game's `.big` files first, and then overwrite them with any loose files it finds in your mod directory. Keeping unnecessary files inflates your mod size and increases load times.

## 3. Creating Your First Mod

Every HWRM mod requires a specific file in its root directory to tell the engine that it is a valid data folder.

1. Navigate to the root of your `my_mod` folder.
2. Create an empty text file named `keeper.txt`. 

If you wanted to modify the speed of the Hiigaran Ion Cannon Frigate:
1. Ensure you kept `my_mod\ship\hgn_ioncannonfrigate\hgn_ioncannonfrigate.ship` from the extraction.
2. Open it in a text editor (like VS Code or Notepad++).
3. Find the lines:
   ```lua
   NewShipType.thrusterMaxSpeed=165
   NewShipType.mainEngineMaxSpeed=165
   ```
4. Change them to:
   ```lua
   NewShipType.thrusterMaxSpeed=330
   NewShipType.mainEngineMaxSpeed=330
   ```
5. Save the file.

## 4. Testing Your Mod Locally

You can test your mod without uploading it to the Steam Workshop by using launch parameters.

1. In Steam, right-click **Homeworld Remastered Collection** -> **Properties**.
2. In the **General** tab, find **Launch Options**.
3. Add the path to your mod using the `-moddatapath` argument:
   ```text
   -moddatapath GBXTools\WorkshopTool\my_mod
   ```
   *(Note: The game searches relative to the base `Homeworld` folder)*
4. Launch the game. The engine will load your modified files, and you'll see your changes reflected in-game!

## 5. Publishing to the Workshop

When you are ready to share your mod, you will use the `WorkshopTool.exe` included in the toolkit to compile your loose files back into a `.big` format and upload them directly to Steam.

---

### Additional Resources
- **Scripting Language**: HWRM uses **Lua 4.0**. Do not try to use Lua 5+ features (like `#table` or `table.insert`), as they will crash the engine. Use `getn(table)` and `tinsert(table, value)` instead.
- **Reference Vanilla**: Always extract the vanilla `.big` files to serve as a reference. If you don't know how a function works, grep the vanilla scripts to see how the original developers used it.
