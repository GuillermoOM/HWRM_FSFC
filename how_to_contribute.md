# How do I contribute to this mod?

If you'd like to contribute working on this mod, please reach me out on discord: `willywolfy` or go to the [Homewolrd Universe discord](https://discord.gg/homeworld) on the modding channel.

## Currently working on

- Migrating Shivan race to the new HOD versions.

# How do I?

This is a series of tutorials on the multiple jobs that have to be done to remaster this mod, either migrating ships to a new HOD version or working 

## What do I need to Mod HW:RM?

Main tools needed are:
- [Visual Studio Code](https://code.visualstudio.com/) (or any editor, this just helps with lua formatting)
- Homeworld Remastered Toolkit (installed on steam, look for it in your library of tools)
- [DAEnerys](https://bitbucket.org/PayDay_/daenerys/src/master/) (for editing DAE files)
- [CFHodED.Win10](https://github.com/Fallen-Angel/CFHodEd/releases) (for editing old HOD files)
- [FXToolRM](https://bitbucket.org/radar3301/fxtoolrm/downloads/) (helps with created fx lua files)
- [GIMP](https://www.gimp.org/downloads/) (For fixing TGA files / Textures)
- [Blender](https://www.blender.org/download/) (For fixing mesh issues)
- [MADEditor](https://www.mediafire.com/?rcgddvdwlnxku3l) (for creating animations, can also be done in blender)

You also need to perform some actions:
- Extract main HW .big files
- Configure DAEnerys

## How to extract the necessary big files

In order to work with some of the tools, like DAEnerys or CFHodED, [refer to this guide for that](https://discord.com/channels/128196211969753088/1197970354036027522)

## How to setup DAEnerys

https://discord.com/channels/128196211969753088/1198120423422959647

## How do I migrate a Ship?

Migrating a ship involves the following:
1. Copy the directory of the ship to the new one (except the HOD file)
2. Extract the HOD with RODOH (HOD to DAE extraction)
3. Open the DAE file with DAEnerys to verify everything is where it should and no errors are present.
4. Repack the file into HOD using HODOR
5. Place the new HOD to the ship's directory
6. Make sure the .events file has no references to non existing markers.
7. Make sure the .ship script contains the correct info on its properties and functions (family types, weapon names, subsystems, etc)
8. Making sure the subsystems HODs are migrated the same way
10. test!
