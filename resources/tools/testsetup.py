# import os

# ship_directory = os.path.join(os.curdir, "source", "ship")

params = """
-nomovies
-luatrace
-traceHODs
-moddatapath GBXTools\\WorkshopTool\\HWRM_FSFC\\source
-lvlPassTags=test
-load parkinglot_cmdline
-Camera_Target=0,0,0
-Camera_Eye=2000,2000,2000
-Spawn_Back=ez01
"""

# ships_list = os.listdir(ship_directory)
ships_list = ['ter_orion','ter_apollo','ter_apollo','vas_typhon','vas_seth','vas_horus']
# ships_list.remove("icons")
PLAYER_RACE = 'vas'

for n, d in enumerate(ships_list):
    params = params + f"\n-Spawn_Ship_{n}={d}\n"
    if PLAYER_RACE in d:
        params = params + f"-Spawn_Pos_{n}=-8000,0,{(1000*n)}\n" + f"-Spawn_Rot_{n}=0,90,0\n" + f"-Spawn_Team_{n}=0\n"
    else:
        params = params + f"-Spawn_Pos_{n}=8000,0,{(1000*n)}\n" + f"-Spawn_Rot_{n}=0,-90,0\n" + f"-Spawn_Team_{n}=1\n"

print(params)

with open(".\\..\\..\\params.txt","w") as params_file:
    params_file.write(params)
