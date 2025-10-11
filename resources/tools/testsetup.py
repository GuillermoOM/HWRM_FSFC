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
-Camera_Eye=8000,0,0
-Spawn_Back=ez01
"""

# ships_list = os.listdir(ship_directory)
h_ships = [
    "ter_perseus",
    "ter_perseus",
    "ter_perseus",
    "ter_perseus",
    "ter_perseus",
    "ter_perseus",
    "ter_orion",
    "ter_perseus",
    "ter_perseus",
    "ter_perseus",
    "ter_perseus",
    "ter_perseus",
    "ter_perseus",
]

p_ships = [
    "shi_trident",
    "shi_trident",
    "shi_mephisto",
    "shi_ravana",
    "shi_mephisto",
    "shi_trident",
    "shi_trident",
]

# ships_list.remove("icons")

ship_number = 0

for n, d in enumerate(p_ships):
    params = params + f"\n-Spawn_Ship_{ship_number}={d}\n"
    params = (
        params
        + f"-Spawn_Pos_{ship_number}=-3000,0,{(1000*n)}\n"
        + f"-Spawn_Rot_{ship_number}=0,90,0\n"
        + f"-Spawn_Team_{ship_number}=0\n"
    )
    ship_number += 1

for n, d in enumerate(h_ships):
    params = params + f"\n-Spawn_Ship_{ship_number}={d}\n"
    params = (
        params
        + f"-Spawn_Pos_{ship_number}=3000,0,{(1000*n)}\n"
        + f"-Spawn_Rot_{ship_number}=0,-90,0\n"
        + f"-Spawn_Team_{ship_number}=1\n"
    )
    ship_number += 1

print(params)

with open(".\\..\\..\\params.txt", "w") as params_file:
    _ = params_file.write(params)
