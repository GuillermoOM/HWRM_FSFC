# fix_dae_file.py

This script does 2 things:

    1. Fixes all image textures so that they are all the same size.
    2. Fixes engine burns in DAE files after migrating from old HOD.

## Usage:

    1. Use RODOH and get the DAE file.
    2. Open the DAE file with DAEnerys. (if it shows an error, ignore it and click on continue).
    3. Find the Nav Lights related to the Engines and note their common name (i.e. 'e', 'EngineLight', etc.), same with the engine burns.
    4. Save the DAE file and overwrite.
    5. Edit the Script variables DAE_DIRS_PATH to link to the folder containing all ship folders with DAE files and SHIP_NAME to select the ship name/folder.
    6. in the 'fix_dae_engine_burns' method, edit the two variables 'engine_lights_name' and 'engine_burns_name' to have the common name for the engine nav lights and engine burns respectively with the type of joint ('NAVL[EngineNozzle' or 'BURN[EngineBurn')
    7. Run the Script.
    8. Once the script finishes, open the DAE file with a text editor and replace all 'ns0:' occurences with nothing ('').
    9. Open the file again with DAEnerys, it shouldn't have any texture errors and all engine burns should have their parent assigned to a joint not being Root.
    10. Save the file and then run HODOR to turn it into HOD2.0