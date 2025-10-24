TER_POSEIDON = {
    "Ship info": {
        "variables": {
            "displayedName": '"GTFr Poseidon"',
            "sobDescription": '"Sentry and Mine Deployer"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "4000",
            "regentime": "175",
            "minRegenTime": "175",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.0)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.0)',
        },
        "functions": [],
    },
    "Tactics And Multipliers": {
        "variables": {"defaultROE": '"Defensive"', "defaultStance": '"Aggressive"'},
        "functions": [
            {"name": "setTacticsMults", "args": ["MAXSPEED", "0.90", "1.10", "1.0"]},
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.20", "0.80", "1.0"]},
            {"name": "setTacticsMults", "args": ["ENGINEBRAKE", "1.0", "1.0", "1.0"]},
            {"name": "setTacticsMults", "args": ["THRUSTER", "1.0", "1.0", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.20", "0.80", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["THRUSTERBRAKE", "1.0", "1.0", "1.0"]},
            {"name": "setTacticsMults", "args": ["ROTATION", "1.0", "1.10", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.0", "1.10", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATIONBRAKE", "1.0", "1.0", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["WEAPONACCURACY", "1.0", "1.0", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["WEAPONDAMAGE", "1.20", "1.0", "1.0"]},
            {"name": "setTacticsMults", "args": ["BULLETSPEED", "1.10", "1.0", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["DAMAGEAPPLIED", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["FIRERATE", "1.0", "1.25", "1.0"]},
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"paradeData": '"terran_parade"',"formationSpacing": "45", "strikeGroupSpeed": "5000"},
        "functions": [],
    },
    "Docking": {
        "variables": {
            "holdSlots": "1",
            "dockTimeBetweenTwoFormations": "0.5",
            "dockTimeBeforeStart": "0.5",
            "dockNrOfShipsInDockFormation": "1",
            "dockFormation": '"n_delta"',
            "queueFormation": '"n_delta"',
            "ignoreRaceWhenDocking": "0",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "10000",
            "thrusterMaxSpeed": "200",
            "mainEngineMaxSpeed": "200",
            "rotationMaxSpeed": "50",
            "thrusterAccelTime": "7",
            "thrusterBrakeTime": "2",
            "mainEngineAccelTime": "8",
            "mainEngineBrakeTime": "2",
            "rotationAccelTime": "0.75",
            "rotationBrakeTime": "0.4",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "200",
            "battleScarCoverage": "2",
            "battleScarBudgetLow": "400",
            "battleScarBudgetNext": "600",
            "sobDieTime": "1",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "0",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "0.5",
            "accelerationAngle": "80",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "60",
            "descendPitch": "60",
            "goalReachEpsilon": "30",
            "slideMoveRange": "100",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "3",
            "agileFlight": "1",
            "homingDistance": "2000",
            "homingDelay": "0.5",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "10",
            "tumbleStaticY": "20",
            "tumbleStaticZ": "5",
            "tumbleDynamicX": "50",
            "tumbleDynamicY": "100",
            "tumbleDynamicZ": "25",
            "tumbleSpecialDynamicX": "2",
            "tumbleSpecialDynamicY": "10",
            "tumbleSpecialDynamicZ": "5",
        },
        "functions": [],
    },
    "Swaying": {
        "variables": {
            "swayUpdateTime": "3",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0.025",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"Utility_Ter"',
            "AttackFamily": '"ResourceLarge"',
            "DockFamily": '"Frigate"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Utility"',
            "AutoFormationFamily": '"Frigate"',
            "CollisionFamily": '"Small"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "LightArmour")',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [{"name": "setSupplyValue", "args": ["Utility", "1.0"]}],
    },
    "Ship Counter Rating": {
        "variables": {
            "fighterValue": "0",
            "corvetteValue": "10",
            "frigateValue": "0",
            "neutralValue": "0",
            "antiFighterValue": "0",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "10",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "400",
            "buildTime": "25",
            "buildPriorityOrder": "40",
        },
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "5500",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "4000",
            "secSensorRange": "5000",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"Diamond"',
            "TOScale": "1",
            "TODistanceFade0": "9000",
            "TODistanceDisappear0": "7000",
            "TODistanceFade1": "4500",
            "TODistanceDisappear1": "3500",
            "TODistanceFade2": "12000",
            "TODistanceDisappear2": "35000",
            "TOGroupScale": "1",
            "TOGroupMergeSize": "0",
        },
        "functions": [],
    },
    "Overlays": {
        "variables": {
            "mouseOverMinFadeSize": "0.045",
            "mouseOverMaxFadeSize": "0.1",
            "healthBarStyle": "1",
            "SMRepresentation": '"HardDot"',
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.00025",
            "nlipsRange": "10000",
            "nlipsFar": "0",
            "nlipsFarRange": "20000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "11000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "410",
            "goblinsOff": "410",
            "minimumZoomFactor": "0.75",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"minLOD": "0.25", "upLOD": "2500", "downLOD": "2515"},
        "functions": [],
    },
    "Selection": {
        "variables": {
            "selectionLimit": "150000",
            "preciseATILimit": "0",
            "selectionPriority": "75",
            "militaryUnit": "1",
        },
        "functions": [],
    },
    "Alternative Hyperspace Gate": {
        "variables": {
            "alternativeHyperspaceV": "subspace_gate_small",
            "alternativeHyperspaceA": "etg/misc/small_subspace",
            "alternativeHyperspaceTime": "7",
        },
        "functions": [],
    },
    "Abilities": {
        "variables": {},
        "functions": [
            {"name": "addAbility", "args": ["MoveCommand", "1", "0"]},
            {"name": "addAbility", "args": ["CanDock", "1", "1"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {"name": "addAbility", "args": ['WaypointMove"']},
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "1",
                    "1",
                    "0",
                    "0.35",
                    "1",
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Frigate, Utility, Resource,,,,SmallCapitalShip, BigCapitalShip",
                    "JustShoot",
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "500"]},
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
            {"name": "addAbility", "args": ["RetireAbility", "1", "0"]},
            {"name": "addAbility", "args": ["MinelayerAbility", "1", "3.5"]},
            {
                "name": "addAbility",
                "args": ["CanBuildShips", "1", "Platform_ter", "Platform"],
            },
            {
                "name": "addAbility",
                "args": [
                    "ShipHold",
                    "1",
                    "1000",
                    "1",
                    "rallypoint",
                    "Fighter, Utility",
                    "400",
                ],
            },
        ],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "0.5",
            "launchTimeBeforeStart": "1.5",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"n_delta"',
        },
        "functions": [],
    },
    "Load Model": {
        "variables": {},
        "functions": [{"name": "LoadModel", "args": ["1"]}],
    },
    "Weapons": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_subach_turret", "Weapon_Bottom", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_subach_turret", "Weapon_Top", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_subach_turret", "Weapon_Left", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_subach_turret", "Weapon_Right", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["Hgn_MineLayer", "Weapon_Bottom", ""],
            },
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "310", "20"]}],
    },
    "Engines": {
        "variables": {},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["7", "0.5", "1", "15", "0", "0.7", "0.1", "40"],
            }
        ],
    },
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": ["data:sound/sfx/ship/", "0", "", "", "1", "TerranCruiser", ""],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "25",
            "maxFalloffDamageDist": "25*3",
            "maxFalloffScuttleDamageDist": "25*4",
            "explosiveScuttleDamageOnDeath": "95",
            "maxFalloffForce": "25*10",
            "explosiveDamageOnDeath": "19",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
}
VAS_BAST = {
    "Ship info": {
        "variables": {
            "displayedName": '"PVFr Bast"',
            "sobDescription": '"Sentry and Mine Deployer"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "4000",
            "regentime": "225",
            "minRegenTime": "150",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.0)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.0)',
        },
        "functions": [],
    },
    "Tactics And Multipliers": {
        "variables": {"defaultROE": '"Defensive"', "defaultStance": '"Aggressive"'},
        "functions": [
            {"name": "setTacticsMults", "args": ["MAXSPEED", "0.90", "1.10", "1.0"]},
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.20", "0.80", "1.0"]},
            {"name": "setTacticsMults", "args": ["ENGINEBRAKE", "1.0", "1.0", "1.0"]},
            {"name": "setTacticsMults", "args": ["THRUSTER", "1.0", "1.0", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.20", "0.80", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["THRUSTERBRAKE", "1.0", "1.0", "1.0"]},
            {"name": "setTacticsMults", "args": ["ROTATION", "1.0", "1.10", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.0", "1.10", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATIONBRAKE", "1.0", "1.0", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["WEAPONACCURACY", "1.0", "1.0", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["WEAPONDAMAGE", "1.20", "1.0", "1.0"]},
            {"name": "setTacticsMults", "args": ["BULLETSPEED", "1.10", "1.0", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["DAMAGEAPPLIED", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["FIRERATE", "1.0", "1.25", "1.0"]},
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"paradeData": '"vas_mothership_parade"',"formationSpacing": "45", "strikeGroupSpeed": "5000"},
        "functions": [],
    },
    "Docking": {
        "variables": {
            "holdSlots": "1",
            "dockTimeBetweenTwoFormations": "0.5",
            "dockTimeBeforeStart": "0.5",
            "dockNrOfShipsInDockFormation": "1",
            "dockFormation": '"n_delta"',
            "queueFormation": '"n_delta"',
            "ignoreRaceWhenDocking": "0",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "20000",
            "thrusterMaxSpeed": "230",
            "mainEngineMaxSpeed": "230",
            "rotationMaxSpeed": "50",
            "thrusterAccelTime": "7",
            "thrusterBrakeTime": "2",
            "mainEngineAccelTime": "8",
            "mainEngineBrakeTime": "2",
            "rotationAccelTime": "0.75",
            "rotationBrakeTime": "0.4",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "200",
            "battleScarCoverage": "2",
            "battleScarBudgetLow": "400",
            "battleScarBudgetNext": "600",
            "sobDieTime": "1",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "0",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "0.5",
            "accelerationAngle": "80",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "60",
            "descendPitch": "60",
            "goalReachEpsilon": "30",
            "slideMoveRange": "100",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "3",
            "agileFlight": "1",
            "homingDistance": "2000",
            "homingDelay": "0.5",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "10",
            "tumbleStaticY": "20",
            "tumbleStaticZ": "5",
            "tumbleDynamicX": "50",
            "tumbleDynamicY": "100",
            "tumbleDynamicZ": "25",
            "tumbleSpecialDynamicX": "2",
            "tumbleSpecialDynamicY": "10",
            "tumbleSpecialDynamicZ": "5",
        },
        "functions": [],
    },
    "Swaying": {
        "variables": {
            "swayUpdateTime": "3",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0.025",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"Utility_Vas"',
            "AttackFamily": '"ResourceLarge"',
            "DockFamily": '"Frigate"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Utility"',
            "AutoFormationFamily": '"Frigate"',
            "CollisionFamily": '"Small"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "LightArmour")',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [{"name": "setSupplyValue", "args": ["Utility", "1.0"]}],
    },
    "Ship Counter Rating": {
        "variables": {
            "fighterValue": "0",
            "corvetteValue": "10",
            "frigateValue": "0",
            "neutralValue": "0",
            "antiFighterValue": "0",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "10",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "350",
            "buildTime": "22",
            "buildPriorityOrder": "40",
        },
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "5500",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "4000",
            "secSensorRange": "5000",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"Diamond"',
            "TOScale": "1",
            "TODistanceFade0": "9000",
            "TODistanceDisappear0": "7000",
            "TODistanceFade1": "4500",
            "TODistanceDisappear1": "3500",
            "TODistanceFade2": "12000",
            "TODistanceDisappear2": "35000",
            "TOGroupScale": "1",
            "TOGroupMergeSize": "0",
        },
        "functions": [],
    },
    "Overlays": {
        "variables": {
            "mouseOverMinFadeSize": "0.045",
            "mouseOverMaxFadeSize": "0.1",
            "healthBarStyle": "1",
            "SMRepresentation": '"HardDot"',
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.00025",
            "nlipsRange": "10000",
            "nlipsFar": "0",
            "nlipsFarRange": "20000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "11000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "410",
            "goblinsOff": "410",
            "minimumZoomFactor": "0.75",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"minLOD": "0.25", "upLOD": "2500", "downLOD": "2515"},
        "functions": [],
    },
    "Selection": {
        "variables": {
            "selectionLimit": "150000",
            "preciseATILimit": "0",
            "selectionPriority": "75",
            "militaryUnit": "1",
        },
        "functions": [],
    },
    "Alternative Hyperspace Gate": {
        "variables": {
            "alternativeHyperspaceV": "subspace_gate_small",
            "alternativeHyperspaceA": "etg/misc/small_subspace",
            "alternativeHyperspaceTime": "7",
        },
        "functions": [],
    },
    "Abilities": {
        "variables": {},
        "functions": [
            {"name": "addAbility", "args": ["MoveCommand", "1", "0"]},
            {"name": "addAbility", "args": ["CanDock", "1", "1"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {"name": "addAbility", "args": ['WaypointMove"']},
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "1",
                    "1",
                    "0",
                    "0.35",
                    "1",
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Frigate, Utility, Resource,,,,SmallCapitalShip, BigCapitalShip",
                    "JustShoot",
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "500"]},
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
            {"name": "addAbility", "args": ["RetireAbility", "1", "0"]},
            {"name": "addAbility", "args": ["MinelayerAbility", "1", "3.5"]},
            {
                "name": "addAbility",
                "args": ["CanBuildShips", "1", "Platform_vas", "Platform"],
            },
            {
                "name": "addAbility",
                "args": [
                    "ShipHold",
                    "1",
                    "1000",
                    "1",
                    "rallypoint",
                    "Fighter, Utility",
                    "400",
                ],
            },
        ],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "0.5",
            "launchTimeBeforeStart": "1.5",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"n_delta"',
        },
        "functions": [],
    },
    "Load Model": {
        "variables": {},
        "functions": [{"name": "LoadModel", "args": ["1"]}],
    },
    "Weapons": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_subach_turret", "Weapon_Bottom", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_subach_turret", "Weapon_Top", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_subach_turret", "Weapon_Front", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["Hgn_MineLayer", "Weapon_Bottom", ""],
            },
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "310", "20"]}],
    },
    "Engines": {
        "variables": {},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["7", "0.5", "1", "15", "0", "0.7", "0.1", "40"],
            }
        ],
    },
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": ["data:sound/sfx/ship/", "0", "", "", "1", "pvc_old", ""],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "25",
            "maxFalloffDamageDist": "25*3",
            "maxFalloffScuttleDamageDist": "25*4",
            "explosiveScuttleDamageOnDeath": "95",
            "maxFalloffForce": "25*10",
            "explosiveDamageOnDeath": "19",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
}
VAS_BES = {
    "Ship info": {
        "variables": {
            "displayedName": '"GVFr Bes"',
            "sobDescription": '"Sentry and Mine Deployer"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "4500",
            "regentime": "225",
            "minRegenTime": "150",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.0)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.0)',
        },
        "functions": [],
    },
    "Tactics And Multipliers": {
        "variables": {"defaultROE": '"Defensive"', "defaultStance": '"Aggressive"'},
        "functions": [
            {"name": "setTacticsMults", "args": ["MAXSPEED", "0.90", "1.10", "1.0"]},
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.20", "0.80", "1.0"]},
            {"name": "setTacticsMults", "args": ["ENGINEBRAKE", "1.0", "1.0", "1.0"]},
            {"name": "setTacticsMults", "args": ["THRUSTER", "1.0", "1.0", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.20", "0.80", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["THRUSTERBRAKE", "1.0", "1.0", "1.0"]},
            {"name": "setTacticsMults", "args": ["ROTATION", "1.0", "1.10", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.0", "1.10", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATIONBRAKE", "1.0", "1.0", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["WEAPONACCURACY", "1.0", "1.0", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["WEAPONDAMAGE", "1.20", "1.0", "1.0"]},
            {"name": "setTacticsMults", "args": ["BULLETSPEED", "1.10", "1.0", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["DAMAGEAPPLIED", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["FIRERATE", "1.0", "1.25", "1.0"]},
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"paradeData": '"vas_mothership_parade"',"formationSpacing": "45", "strikeGroupSpeed": "5000"},
        "functions": [],
    },
    "Docking": {
        "variables": {
            "holdSlots": "1",
            "dockTimeBetweenTwoFormations": "0.5",
            "dockTimeBeforeStart": "0.5",
            "dockNrOfShipsInDockFormation": "1",
            "dockFormation": '"n_delta"',
            "queueFormation": '"n_delta"',
            "ignoreRaceWhenDocking": "0",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "20000",
            "thrusterMaxSpeed": "210",
            "mainEngineMaxSpeed": "210",
            "rotationMaxSpeed": "50",
            "thrusterAccelTime": "7",
            "thrusterBrakeTime": "2",
            "mainEngineAccelTime": "8",
            "mainEngineBrakeTime": "2",
            "rotationAccelTime": "0.75",
            "rotationBrakeTime": "0.4",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "200",
            "battleScarCoverage": "2",
            "battleScarBudgetLow": "400",
            "battleScarBudgetNext": "600",
            "sobDieTime": "1",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "0",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "0.5",
            "accelerationAngle": "80",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "60",
            "descendPitch": "60",
            "goalReachEpsilon": "30",
            "slideMoveRange": "100",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "3",
            "agileFlight": "1",
            "homingDistance": "2000",
            "homingDelay": "0.5",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "10",
            "tumbleStaticY": "20",
            "tumbleStaticZ": "5",
            "tumbleDynamicX": "50",
            "tumbleDynamicY": "100",
            "tumbleDynamicZ": "25",
            "tumbleSpecialDynamicX": "2",
            "tumbleSpecialDynamicY": "10",
            "tumbleSpecialDynamicZ": "5",
        },
        "functions": [],
    },
    "Swaying": {
        "variables": {
            "swayUpdateTime": "3",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0.025",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"Utility_Vas"',
            "AttackFamily": '"ResourceLarge"',
            "DockFamily": '"Frigate"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Utility"',
            "AutoFormationFamily": '"Frigate"',
            "CollisionFamily": '"Small"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "LightArmour")',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [{"name": "setSupplyValue", "args": ["Utility", "1.0"]}],
    },
    "Ship Counter Rating": {
        "variables": {
            "fighterValue": "0",
            "corvetteValue": "10",
            "frigateValue": "0",
            "neutralValue": "0",
            "antiFighterValue": "0",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "10",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "400",
            "buildTime": "25",
            "buildPriorityOrder": "40",
        },
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "5500",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "4000",
            "secSensorRange": "5000",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"Diamond"',
            "TOScale": "1",
            "TODistanceFade0": "9000",
            "TODistanceDisappear0": "7000",
            "TODistanceFade1": "4500",
            "TODistanceDisappear1": "3500",
            "TODistanceFade2": "12000",
            "TODistanceDisappear2": "35000",
            "TOGroupScale": "1",
            "TOGroupMergeSize": "0",
        },
        "functions": [],
    },
    "Overlays": {
        "variables": {
            "mouseOverMinFadeSize": "0.045",
            "mouseOverMaxFadeSize": "0.1",
            "healthBarStyle": "1",
            "SMRepresentation": '"HardDot"',
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.00025",
            "nlipsRange": "10000",
            "nlipsFar": "0",
            "nlipsFarRange": "20000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "11000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "410",
            "goblinsOff": "410",
            "minimumZoomFactor": "0.75",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"minLOD": "0.25"},
        "functions": [],
    },
    "Selection": {
        "variables": {
            "selectionLimit": "150000",
            "preciseATILimit": "0",
            "selectionPriority": "75",
            "militaryUnit": "1",
        },
        "functions": [],
    },
    "Alternative Hyperspace Gate": {
        "variables": {
            "alternativeHyperspaceV": "subspace_gate_small",
            "alternativeHyperspaceA": "etg/misc/small_subspace",
            "alternativeHyperspaceTime": "7",
        },
        "functions": [],
    },
    "Abilities": {
        "variables": {},
        "functions": [
            {"name": "addAbility", "args": ["MoveCommand", "1", "0"]},
            {"name": "addAbility", "args": ["CanDock", "1", "1"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {"name": "addAbility", "args": ['WaypointMove"']},
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "1",
                    "1",
                    "0",
                    "0.35",
                    "1",
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Frigate, Utility, Resource,,,,SmallCapitalShip, BigCapitalShip",
                    "JustShoot",
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "500"]},
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
            {"name": "addAbility", "args": ["RetireAbility", "1", "0"]},
            {"name": "addAbility", "args": ["MinelayerAbility", "1", "3.5"]},
            {
                "name": "addAbility",
                "args": ["CanBuildShips", "1", "Platform_vas", "Platform"],
            },
            {
                "name": "addAbility",
                "args": [
                    "ShipHold",
                    "1",
                    "1000",
                    "1",
                    "rallypoint",
                    "Fighter, Utility",
                    "400",
                ],
            },
        ],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "0.5",
            "launchTimeBeforeStart": "1.5",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"n_delta"',
        },
        "functions": [],
    },
    "Load Model": {
        "variables": {},
        "functions": [{"name": "LoadModel", "args": ["1"]}],
    },
    "Weapons": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_Bottom", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_Top", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["Hgn_MineLayer", "Weapon_Bottom", ""],
            },
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "310", "20"]}],
    },
    "Engines": {
        "variables": {},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["7", "0.5", "1", "15", "0", "0.7", "0.1", "40"],
            }
        ],
    },
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": [
                    "data:sound/sfx/ship/",
                    "0",
                    "",
                    "",
                    "1",
                    "vasudancruiser",
                    "",
                ],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "25",
            "maxFalloffDamageDist": "25*3",
            "maxFalloffScuttleDamageDist": "25*4",
            "explosiveScuttleDamageOnDeath": "95",
            "maxFalloffForce": "25*10",
            "explosiveDamageOnDeath": "19",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
}
SHI_MEPHISTO = {
    "Ship info": {
        "variables": {
            "displayedName": '"SFr Mephisto"',
            "sobDescription": '"Sentry and Mine Deployer"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "10000",
            "regentime": "180",
            "minRegenTime": "180",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.0)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.0)',
        },
        "functions": [],
    },
    "Tactics And Multipliers": {
        "variables": {"defaultROE": '"Defensive"', "defaultStance": '"Aggressive"'},
        "functions": [
            {"name": "setTacticsMults", "args": ["MAXSPEED", "0.90", "1.10", "1.0"]},
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.20", "0.80", "1.0"]},
            {"name": "setTacticsMults", "args": ["ENGINEBRAKE", "1.0", "1.0", "1.0"]},
            {"name": "setTacticsMults", "args": ["THRUSTER", "1.0", "1.0", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.20", "0.80", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["THRUSTERBRAKE", "1.0", "1.0", "1.0"]},
            {"name": "setTacticsMults", "args": ["ROTATION", "1.0", "1.10", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.0", "1.10", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATIONBRAKE", "1.0", "1.0", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["WEAPONACCURACY", "1.0", "1.0", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["WEAPONDAMAGE", "1.20", "1.0", "1.0"]},
            {"name": "setTacticsMults", "args": ["BULLETSPEED", "1.10", "1.0", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["DAMAGEAPPLIED", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["FIRERATE", "1.0", "1.25", "1.0"]},
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"paradeData": '"shi_build_parade"',"formationSpacing": "45", "strikeGroupSpeed": "5000"},
        "functions": [],
    },
    "Docking": {
        "variables": {
            "holdSlots": "1",
            "dockTimeBetweenTwoFormations": "0.5",
            "dockTimeBeforeStart": "0.5",
            "dockNrOfShipsInDockFormation": "1",
            "dockFormation": '"n_delta"',
            "queueFormation": '"n_delta"',
            "ignoreRaceWhenDocking": "0",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "10000",
            "thrusterMaxSpeed": "210",
            "mainEngineMaxSpeed": "210",
            "rotationMaxSpeed": "50",
            "thrusterAccelTime": "7",
            "thrusterBrakeTime": "2",
            "mainEngineAccelTime": "8",
            "mainEngineBrakeTime": "2",
            "rotationAccelTime": "0.75",
            "rotationBrakeTime": "0.4",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "200",
            "battleScarCoverage": "2",
            "battleScarBudgetLow": "400",
            "battleScarBudgetNext": "600",
            "sobDieTime": "1",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "0",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "0.5",
            "accelerationAngle": "80",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "60",
            "descendPitch": "60",
            "goalReachEpsilon": "30",
            "slideMoveRange": "100",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "3",
            "agileFlight": "1",
            "homingDistance": "2000",
            "homingDelay": "0.5",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "10",
            "tumbleStaticY": "20",
            "tumbleStaticZ": "5",
            "tumbleDynamicX": "50",
            "tumbleDynamicY": "100",
            "tumbleDynamicZ": "25",
            "tumbleSpecialDynamicX": "2",
            "tumbleSpecialDynamicY": "10",
            "tumbleSpecialDynamicZ": "5",
        },
        "functions": [],
    },
    "Swaying": {
        "variables": {
            "swayUpdateTime": "3",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0.025",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"Utility_Shi"',
            "AttackFamily": '"ResourceLarge"',
            "DockFamily": '"Frigate"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Utility"',
            "AutoFormationFamily": '"Frigate"',
            "CollisionFamily": '"Small"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "LightArmour")',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [{"name": "setSupplyValue", "args": ["Utility", "1.0"]}],
    },
    "Ship Counter Rating": {
        "variables": {
            "fighterValue": "0",
            "corvetteValue": "10",
            "frigateValue": "0",
            "neutralValue": "0",
            "antiFighterValue": "0",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "10",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "400",
            "buildTime": "25",
            "buildPriorityOrder": "40",
        },
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "5500",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "4000",
            "secSensorRange": "5000",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"Diamond"',
            "TOScale": "1",
            "TODistanceFade0": "9000",
            "TODistanceDisappear0": "7000",
            "TODistanceFade1": "4500",
            "TODistanceDisappear1": "3500",
            "TODistanceFade2": "12000",
            "TODistanceDisappear2": "35000",
            "TOGroupScale": "1",
            "TOGroupMergeSize": "0",
        },
        "functions": [],
    },
    "Overlays": {
        "variables": {
            "mouseOverMinFadeSize": "0.045",
            "mouseOverMaxFadeSize": "0.1",
            "healthBarStyle": "1",
            "SMRepresentation": '"HardDot"',
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.00025",
            "nlipsRange": "10000",
            "nlipsFar": "0",
            "nlipsFarRange": "20000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "11000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "410",
            "goblinsOff": "410",
            "minimumZoomFactor": "0.75",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"minLOD": "0.25", "upLOD": "2500", "downLOD": "2515"},
        "functions": [],
    },
    "Selection": {
        "variables": {
            "selectionLimit": "150000",
            "preciseATILimit": "0",
            "selectionPriority": "75",
            "militaryUnit": "1",
        },
        "functions": [],
    },
    "Alternative Hyperspace Gate": {
        "variables": {
            "alternativeHyperspaceV": "subspace_gate_small",
            "alternativeHyperspaceA": "etg/misc/small_subspace",
            "alternativeHyperspaceTime": "7",
        },
        "functions": [],
    },
    "Abilities": {
        "variables": {},
        "functions": [
            {"name": "addAbility", "args": ["MoveCommand", "1", "0"]},
            {"name": "addAbility", "args": ["CanDock", "1", "1"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {"name": "addAbility", "args": ['WaypointMove"']},
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "1",
                    "1",
                    "0",
                    "0.35",
                    "1",
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Frigate, Utility, Resource,,,,SmallCapitalShip, BigCapitalShip",
                    "JustShoot",
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "500"]},
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
            {"name": "addAbility", "args": ["RetireAbility", "1", "0"]},
            {"name": "addAbility", "args": ["MinelayerAbility", "1", "3.5"]},
            {
                "name": "addAbility",
                "args": ["CanBuildShips", "1", "Platform_shi", "Platform"],
            },
            {
                "name": "addAbility",
                "args": [
                    "ShipHold",
                    "1",
                    "1000",
                    "1",
                    "rallypoint",
                    "Fighter, Utility",
                    "400",
                ],
            },
        ],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "0.5",
            "launchTimeBeforeStart": "1.5",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"n_delta"',
        },
        "functions": [],
    },
    "Load Model": {
        "variables": {},
        "functions": [{"name": "LoadModel", "args": ["1"]}],
    },
    "Weapons": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlightlaser_gimble", "Weapon_Bottom", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlightlaser_gimble", "Weapon_Top", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlightlaser_gimble", "Weapon_Left", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlightlaser_gimble", "Weapon_Right", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["Hgn_MineLayer", "Weapon_Bottom", ""],
            },
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "210", "15"]}],
    },
    "Engines": {
        "variables": {},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["7", "0.5", "1", "15", "0", "0.7", "0.1", "40"],
            }
        ],
    },
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": ["data:sound/sfx/ship/", "0", "", "", "1", "ShivanCruiser", ""],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "25",
            "maxFalloffDamageDist": "25*3",
            "maxFalloffScuttleDamageDist": "25*4",
            "explosiveScuttleDamageOnDeath": "95",
            "maxFalloffForce": "25*10",
            "explosiveDamageOnDeath": "19",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
}
