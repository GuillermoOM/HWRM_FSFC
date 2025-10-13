import os


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

h_ships = [
    "ter_perseus",
    "ter_perseus",
    "ter_perseus",
    "ter_perseus",
    "ter_fenris",
    "ter_orion",
    "ter_fenris",
    "ter_perseus",
    "ter_perseus",
    "ter_perseus",
    "ter_perseus",
]

p_ships = [
    "ter_arcadia",
    "vas_sehkmet",
    "vas_setekh",
    "vas_setekh",
    "vas_typhon",
    "ter_faustus",
    "vas_setekh",
    "vas_sehkmet",
    "vas_sehkmet",
]

ships_list = []
ship_directory = os.path.join(os.curdir, "./../../source", "ship")
ships_list = os.listdir(ship_directory)

ship_number = 0

vas_ships = [s for s in ships_list if "vas" in s]
shi_ships = [s for s in ships_list if "shi" in s]
ter_ships = [s for s in ships_list if "ter" in s]

player_ships = shi_ships
player_half = int(len(player_ships) / 2)
for n, d in enumerate(player_ships):
    params = params + f"\n-Spawn_Ship_{ship_number}={d}\n"
    params = (
        params
        + f"-Spawn_Pos_{ship_number}=-3000,0,{(1000*(n-player_half))}\n"
        + f"-Spawn_Rot_{ship_number}=0,90,0\n"
        + f"-Spawn_Team_{ship_number}=0\n"
    )
    ship_number += 1

hostile_ships = ter_ships
hostile_half: int = int(len(hostile_ships) / 2)
for n, d in enumerate(hostile_ships):
    params = params + f"\n-Spawn_Ship_{ship_number}={d}\n"
    params = (
        params
        + f"-Spawn_Pos_{ship_number}=3000,0,{(1000*(n-hostile_half))}\n"
        + f"-Spawn_Rot_{ship_number}=0,-90,0\n"
        + f"-Spawn_Team_{ship_number}=1\n"
    )
    ship_number += 1


print(params)

with open(".\\..\\..\\params.txt", "w") as params_file:
    _ = params_file.write(params)
