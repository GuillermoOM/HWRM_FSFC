TER_ALASTOR = {
    "Ship info": {
        "variables": {
            "displayedName": '"GTSG Alastor"',
            "sobDescription": '"Sentry Gun"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "250",
            "regentime": "120",
            "minRegenTime": "120",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.0)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.0)',
        },
        "functions": [],
    },
    "Tactics And Multipliers": {
        "variables": {"defaultROE": '"Defensive"', "defaultStance": '"Neutral"'},
        "functions": [
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.10", "0.90", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATION", "0.95", "1.05", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["FIRERATE", "0.98", "1.02", "1.0"]},
            {"name": "setTacticsMults", "args": ["TURRETSPEED", "1.02", "0.98", "1.0"]},
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"formationSpacing": "45", "canJoinStrikeGroup": "0"},
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "100",
            "thrusterMaxSpeed": "0",
            "mainEngineMaxSpeed": "0",
            "rotationMaxSpeed": "120",
            "thrusterAccelTime": "0.11",
            "thrusterBrakeTime": "0.1",
            "mainEngineAccelTime": "0.11",
            "mainEngineBrakeTime": "0.1",
            "rotationAccelTime": "0.11",
            "rotationBrakeTime": "0.1",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "35",
            "battleScarCoverage": "0",
            "sobDieTime": "1",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "1",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "1",
            "accelerationAngle": "90",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "15",
            "descendPitch": "0",
            "goalReachEpsilon": "5",
            "slideMoveRange": "0",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "6",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "10",
            "tumbleStaticY": "20",
            "tumbleStaticZ": "5",
            "tumbleDynamicX": "2",
            "tumbleDynamicY": "10",
            "tumbleDynamicZ": "5",
            "tumbleSpecialDynamicX": "2",
            "tumbleSpecialDynamicY": "10",
            "tumbleSpecialDynamicZ": "5",
        },
        "functions": [],
    },
    "Swaying": {
        "variables": {
            "swayUpdateTime": "2",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"SuperCap"',
            "BuildFamily": '"Platform_Ter"',
            "AttackFamily": '"Frigate"',
            "DockFamily": '"Platform"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Platform"',
            "AutoFormationFamily": '"Fighter"',
            "CollisionFamily": '"Small"',
            "ArmourFamily": '"TurretArmour"',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [{"name": "setSupplyValue", "args": ["Platform", "1.0"]}],
    },
    "Ship Counter Rating": {
        "variables": {
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "8",
            "antiFighterValue": "8",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "8",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {"buildCost": "60", "buildTime": "7", "buildPriorityOrder": "10"},
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "5500",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "2000",
            "secSensorRange": "2000",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"Hexagon"',
            "TOScale": "1",
            "TODistanceFade0": "7000",
            "TODistanceDisappear0": "5000",
            "TODistanceFade1": "350",
            "TODistanceDisappear1": "300",
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
            "hideNormalAttackUICooldown": "1",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.0001",
            "nlipsRange": "6000",
            "nlipsFar": "0.000015",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "104000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "0",
            "goblinsStartFade": "400",
            "goblinsOff": "400",
            "minimumZoomFactor": "1",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"upLOD": "1300", "downLOD": "1315"},
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
    "Abilities": {
        "variables": {},
        "functions": [
            {"name": "addAbility", "args": ["MoveCommand", "1", "1"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "1",
                    "0",
                    "0",
                    "0.35",
                    "1",
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Capturer, Frigate, Utility, Resource,,,,SmallCapitalShip,BigCapitalShip",
                    'justshoot"',
                ],
            },
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
        ],
    },
    "Docking": {
        "variables": {"dontDockWithOtherRaceShips": "0", "ignoreRaceWhenDocking": "0"},
        "functions": [],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "1",
            "launchTimeBeforeStart": "2",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"delta"',
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
                "args": ["gun_sentrylaser_turret", "Weapon_Top", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_sentrylaser_turret", "Weapon_Bottom", ""],
            },
        ],
    },
    "HardPoints": {"variables": {}, "functions": []},
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "40", "20"]}],
    },
    "Engines": {"variables": {"trailLinger": "2"}, "functions": []},
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": [
                    "data:sound/sfx/Ship/Vaygr/NonMilitary/",
                    "0",
                    "Engines/VWeaponPlatformEng",
                    "",
                    "1",
                    "Ambience/VWEAPONPLATFORMAMB",
                    "",
                ],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "25",
            "maxFalloffDamageDist": "25*3",
            "maxFalloffScuttleDamageDist": "25*6",
            "explosiveScuttleDamageOnDeath": "563",
            "maxFalloffForce": "20*10",
            "explosiveDamageOnDeath": "113",
        },
        "functions": [],
    },
}
TER_CERBERUS = {
    "Ship info": {
        "variables": {
            "displayedName": '"GTSG Cerberus"',
            "sobDescription": '"Sentry Gun"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "150",
            "regentime": "120",
            "minRegenTime": "120",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.0)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.0)',
        },
        "functions": [],
    },
    "Tactics And Multipliers": {
        "variables": {"defaultROE": '"Defensive"', "defaultStance": '"Neutral"'},
        "functions": [
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.10", "0.90", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATION", "0.95", "1.05", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["FIRERATE", "0.98", "1.02", "1.0"]},
            {"name": "setTacticsMults", "args": ["TURRETSPEED", "1.02", "0.98", "1.0"]},
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"formationSpacing": "45", "canJoinStrikeGroup": "0"},
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "100",
            "thrusterMaxSpeed": "0",
            "mainEngineMaxSpeed": "0",
            "rotationMaxSpeed": "120",
            "thrusterAccelTime": "0.11",
            "thrusterBrakeTime": "0.1",
            "mainEngineAccelTime": "0.11",
            "mainEngineBrakeTime": "0.1",
            "rotationAccelTime": "0.11",
            "rotationBrakeTime": "0.1",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "35",
            "battleScarCoverage": "0",
            "sobDieTime": "1",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "1",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "1",
            "accelerationAngle": "90",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "15",
            "descendPitch": "0",
            "goalReachEpsilon": "5",
            "slideMoveRange": "0",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "6",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "10",
            "tumbleStaticY": "20",
            "tumbleStaticZ": "5",
            "tumbleDynamicX": "2",
            "tumbleDynamicY": "10",
            "tumbleDynamicZ": "5",
            "tumbleSpecialDynamicX": "2",
            "tumbleSpecialDynamicY": "10",
            "tumbleSpecialDynamicZ": "5",
        },
        "functions": [],
    },
    "Swaying": {
        "variables": {
            "swayUpdateTime": "2",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"SuperCap"',
            "BuildFamily": '"Platform_Ter"',
            "AttackFamily": '"Frigate"',
            "DockFamily": '"Platform"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Platform"',
            "AutoFormationFamily": '"Fighter"',
            "CollisionFamily": '"Small"',
            "ArmourFamily": '"TurretArmour"',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [{"name": "setSupplyValue", "args": ["Platform", "1.0"]}],
    },
    "Ship Counter Rating": {
        "variables": {
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "8",
            "antiFighterValue": "8",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "8",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {"buildCost": "40", "buildTime": "5", "buildPriorityOrder": "10"},
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "5500",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "2000",
            "secSensorRange": "2000",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"Hexagon"',
            "TOScale": "1",
            "TODistanceFade0": "7000",
            "TODistanceDisappear0": "5000",
            "TODistanceFade1": "350",
            "TODistanceDisappear1": "300",
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
            "hideNormalAttackUICooldown": "1",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.0001",
            "nlipsRange": "6000",
            "nlipsFar": "0.000015",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "104000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "0",
            "goblinsStartFade": "400",
            "goblinsOff": "400",
            "minimumZoomFactor": "1",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"upLOD": "1300", "downLOD": "1315"},
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
    "Abilities": {
        "variables": {},
        "functions": [
            {"name": "addAbility", "args": ["MoveCommand", "1", "1"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "1",
                    "0",
                    "0",
                    "0.35",
                    "1",
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Capturer, Frigate, Utility, Resource,,,,SmallCapitalShip,BigCapitalShip",
                    'justshoot"',
                ],
            },
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
        ],
    },
    "Docking": {
        "variables": {"dontDockWithOtherRaceShips": "0", "ignoreRaceWhenDocking": "0"},
        "functions": [],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "1",
            "launchTimeBeforeStart": "2",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"delta"',
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
                "args": ["gun_avenger_turret", "Weapon_Top", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_avenger_turret", "Weapon_Bottom", ""],
            },
        ],
    },
    "HardPoints": {"variables": {}, "functions": []},
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "40", "20"]}],
    },
    "Engines": {"variables": {"trailLinger": "2"}, "functions": []},
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": [
                    "data:sound/sfx/Ship/Vaygr/NonMilitary/",
                    "0",
                    "Engines/VWeaponPlatformEng",
                    "",
                    "1",
                    "Ambience/VWEAPONPLATFORMAMB",
                    "",
                ],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "25",
            "maxFalloffDamageDist": "25*3",
            "maxFalloffScuttleDamageDist": "25*6",
            "explosiveScuttleDamageOnDeath": "563",
            "maxFalloffForce": "20*10",
            "explosiveDamageOnDeath": "113",
        },
        "functions": [],
    },
}
VAS_EDJO = {
    "Ship info": {
        "variables": {"displayedName": '"GVSG Edjo"', "sobDescription": '"Sentry Gun"'},
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "70",
            "regentime": "120",
            "minRegenTime": "120",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.0)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.0)',
        },
        "functions": [],
    },
    "Tactics And Multipliers": {
        "variables": {"defaultROE": '"Defensive"', "defaultStance": '"Neutral"'},
        "functions": [
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.10", "0.90", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATION", "0.95", "1.05", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["FIRERATE", "0.98", "1.02", "1.0"]},
            {"name": "setTacticsMults", "args": ["TURRETSPEED", "1.02", "0.98", "1.0"]},
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"formationSpacing": "45", "canJoinStrikeGroup": "0"},
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "100",
            "thrusterMaxSpeed": "0",
            "mainEngineMaxSpeed": "0",
            "rotationMaxSpeed": "120",
            "thrusterAccelTime": "0.11",
            "thrusterBrakeTime": "0.1",
            "mainEngineAccelTime": "0.11",
            "mainEngineBrakeTime": "0.1",
            "rotationAccelTime": "0.11",
            "rotationBrakeTime": "0.1",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "35",
            "battleScarCoverage": "0",
            "sobDieTime": "1",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "1",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "1",
            "accelerationAngle": "90",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "15",
            "descendPitch": "0",
            "goalReachEpsilon": "5",
            "slideMoveRange": "0",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "6",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "10",
            "tumbleStaticY": "20",
            "tumbleStaticZ": "5",
            "tumbleDynamicX": "2",
            "tumbleDynamicY": "10",
            "tumbleDynamicZ": "5",
            "tumbleSpecialDynamicX": "2",
            "tumbleSpecialDynamicY": "10",
            "tumbleSpecialDynamicZ": "5",
        },
        "functions": [],
    },
    "Swaying": {
        "variables": {
            "swayUpdateTime": "2",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"SuperCap"',
            "BuildFamily": '"Platform_Vas"',
            "AttackFamily": '"Frigate"',
            "DockFamily": '"Platform"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Platform"',
            "AutoFormationFamily": '"Fighter"',
            "CollisionFamily": '"Small"',
            "ArmourFamily": '"TurretArmour"',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [{"name": "setSupplyValue", "args": ["Platform", "1.0"]}],
    },
    "Ship Counter Rating": {
        "variables": {
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "8",
            "antiFighterValue": "8",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "8",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {"buildCost": "45", "buildTime": "6", "buildPriorityOrder": "10"},
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "5500",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "2000",
            "secSensorRange": "2000",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"Hexagon"',
            "TOScale": "1",
            "TODistanceFade0": "7000",
            "TODistanceDisappear0": "5000",
            "TODistanceFade1": "350",
            "TODistanceDisappear1": "300",
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
            "hideNormalAttackUICooldown": "1",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.0001",
            "nlipsRange": "6000",
            "nlipsFar": "0.000015",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "104000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "0",
            "goblinsStartFade": "400",
            "goblinsOff": "400",
            "minimumZoomFactor": "1",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"upLOD": "1300", "downLOD": "1315"},
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
    "Abilities": {
        "variables": {},
        "functions": [
            {"name": "addAbility", "args": ["MoveCommand", "1", "1"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "1",
                    "0",
                    "0",
                    "0.35",
                    "1",
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Capturer, Frigate, Utility, Resource,,,,SmallCapitalShip,BigCapitalShip",
                    'justshoot"',
                ],
            },
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
        ],
    },
    "Docking": {
        "variables": {"dontDockWithOtherRaceShips": "0", "ignoreRaceWhenDocking": "0"},
        "functions": [],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "1",
            "launchTimeBeforeStart": "2",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"delta"',
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
                "args": ["gun_avenger_turret", "Weapon_Bottom", ""],
            }
        ],
    },
    "HardPoints": {"variables": {}, "functions": []},
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "40", "20"]}],
    },
    "Engines": {"variables": {"trailLinger": "2"}, "functions": []},
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": [
                    "data:sound/sfx/Ship/Vaygr/NonMilitary/",
                    "0",
                    "Engines/VWeaponPlatformEng",
                    "",
                    "1",
                    "Ambience/VWEAPONPLATFORMAMB",
                    "",
                ],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "25",
            "maxFalloffDamageDist": "25*3",
            "maxFalloffScuttleDamageDist": "25*6",
            "explosiveScuttleDamageOnDeath": "563",
            "maxFalloffForce": "20*10",
            "explosiveDamageOnDeath": "113",
        },
        "functions": [],
    },
}
VAS_ANKH = {
    "Ship info": {
        "variables": {"displayedName": '"PVSG Ankh"', "sobDescription": '"Sentry Gun"'},
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "60",
            "regentime": "120",
            "minRegenTime": "120",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.0)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.0)',
        },
        "functions": [],
    },
    "Tactics And Multipliers": {
        "variables": {"defaultROE": '"Defensive"', "defaultStance": '"Neutral"'},
        "functions": [
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.10", "0.90", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATION", "0.95", "1.05", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["FIRERATE", "0.98", "1.02", "1.0"]},
            {"name": "setTacticsMults", "args": ["TURRETSPEED", "1.02", "0.98", "1.0"]},
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"formationSpacing": "45", "canJoinStrikeGroup": "0"},
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "100",
            "thrusterMaxSpeed": "0",
            "mainEngineMaxSpeed": "0",
            "rotationMaxSpeed": "120",
            "thrusterAccelTime": "0.11",
            "thrusterBrakeTime": "0.1",
            "mainEngineAccelTime": "0.11",
            "mainEngineBrakeTime": "0.1",
            "rotationAccelTime": "0.11",
            "rotationBrakeTime": "0.1",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "35",
            "battleScarCoverage": "0",
            "sobDieTime": "1",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "1",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "1",
            "accelerationAngle": "90",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "15",
            "descendPitch": "0",
            "goalReachEpsilon": "5",
            "slideMoveRange": "0",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "6",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "10",
            "tumbleStaticY": "20",
            "tumbleStaticZ": "5",
            "tumbleDynamicX": "2",
            "tumbleDynamicY": "10",
            "tumbleDynamicZ": "5",
            "tumbleSpecialDynamicX": "2",
            "tumbleSpecialDynamicY": "10",
            "tumbleSpecialDynamicZ": "5",
        },
        "functions": [],
    },
    "Swaying": {
        "variables": {
            "swayUpdateTime": "2",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"SuperCap"',
            "BuildFamily": '"Platform_Vas"',
            "AttackFamily": '"Frigate"',
            "DockFamily": '"Platform"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Platform"',
            "AutoFormationFamily": '"Fighter"',
            "CollisionFamily": '"Small"',
            "ArmourFamily": '"TurretArmour"',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [{"name": "setSupplyValue", "args": ["Platform", "1.0"]}],
    },
    "Ship Counter Rating": {
        "variables": {
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "8",
            "antiFighterValue": "8",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "8",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {"buildCost": "30", "buildTime": "4", "buildPriorityOrder": "10"},
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "5500",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "2000",
            "secSensorRange": "2000",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"Hexagon"',
            "TOScale": "1",
            "TODistanceFade0": "7000",
            "TODistanceDisappear0": "5000",
            "TODistanceFade1": "350",
            "TODistanceDisappear1": "300",
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
            "hideNormalAttackUICooldown": "1",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.0001",
            "nlipsRange": "6000",
            "nlipsFar": "0.000015",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "104000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "0",
            "goblinsStartFade": "400",
            "goblinsOff": "400",
            "minimumZoomFactor": "1",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"upLOD": "1300", "downLOD": "1315"},
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
    "Abilities": {
        "variables": {},
        "functions": [
            {"name": "addAbility", "args": ["MoveCommand", "1", "1"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "1",
                    "0",
                    "0",
                    "0.35",
                    "1",
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Capturer, Frigate, Utility, Resource,,,,SmallCapitalShip,BigCapitalShip",
                    'justshoot"',
                ],
            },
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
        ],
    },
    "Docking": {
        "variables": {"dontDockWithOtherRaceShips": "0", "ignoreRaceWhenDocking": "0"},
        "functions": [],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "1",
            "launchTimeBeforeStart": "2",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"delta"',
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
                "args": ["gun_avenger_turret", "Weapon_Bottom", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_avenger_turret", "Weapon_Top", ""],
            },
        ],
    },
    "HardPoints": {"variables": {}, "functions": []},
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "40", "20"]}],
    },
    "Engines": {"variables": {"trailLinger": "2"}, "functions": []},
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": [
                    "data:sound/sfx/Ship/Vaygr/NonMilitary/",
                    "0",
                    "Engines/VWeaponPlatformEng",
                    "",
                    "1",
                    "Ambience/VWEAPONPLATFORMAMB",
                    "",
                ],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "25",
            "maxFalloffDamageDist": "25*3",
            "maxFalloffScuttleDamageDist": "25*6",
            "explosiveScuttleDamageOnDeath": "563",
            "maxFalloffForce": "20*10",
            "explosiveDamageOnDeath": "113",
        },
        "functions": [],
    },
}
SHI_BELIAL = {
    "Ship info": {
        "variables": {
            "displayedName": '"SSG Belial"',
            "sobDescription": '"Sentry Gun"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "160",
            "regentime": "120",
            "minRegenTime": "120",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.0)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.0)',
        },
        "functions": [],
    },
    "Tactics And Multipliers": {
        "variables": {"defaultROE": '"Defensive"', "defaultStance": '"Neutral"'},
        "functions": [
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.10", "0.90", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATION", "0.95", "1.05", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["FIRERATE", "0.98", "1.02", "1.0"]},
            {"name": "setTacticsMults", "args": ["TURRETSPEED", "1.02", "0.98", "1.0"]},
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"formationSpacing": "45", "canJoinStrikeGroup": "0"},
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "100",
            "thrusterMaxSpeed": "0",
            "mainEngineMaxSpeed": "0",
            "rotationMaxSpeed": "120",
            "thrusterAccelTime": "0.11",
            "thrusterBrakeTime": "0.1",
            "mainEngineAccelTime": "0.11",
            "mainEngineBrakeTime": "0.1",
            "rotationAccelTime": "0.11",
            "rotationBrakeTime": "0.1",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "35",
            "battleScarCoverage": "0",
            "sobDieTime": "1",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "1",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "1",
            "accelerationAngle": "90",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "15",
            "descendPitch": "0",
            "goalReachEpsilon": "5",
            "slideMoveRange": "0",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "6",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "10",
            "tumbleStaticY": "20",
            "tumbleStaticZ": "5",
            "tumbleDynamicX": "2",
            "tumbleDynamicY": "10",
            "tumbleDynamicZ": "5",
            "tumbleSpecialDynamicX": "2",
            "tumbleSpecialDynamicY": "10",
            "tumbleSpecialDynamicZ": "5",
        },
        "functions": [],
    },
    "Swaying": {
        "variables": {
            "swayUpdateTime": "2",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"SuperCap"',
            "BuildFamily": '"Platform_Shi"',
            "AttackFamily": '"Frigate"',
            "DockFamily": '"Platform"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Platform"',
            "AutoFormationFamily": '"Fighter"',
            "CollisionFamily": '"Small"',
            "ArmourFamily": '"TurretArmour"',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [{"name": "setSupplyValue", "args": ["Platform", "1.0"]}],
    },
    "Ship Counter Rating": {
        "variables": {
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "8",
            "antiFighterValue": "8",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "8",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {"buildCost": "75", "buildTime": "8", "buildPriorityOrder": "10"},
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "5500",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "2000",
            "secSensorRange": "2000",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"Hexagon"',
            "TOScale": "1",
            "TODistanceFade0": "7000",
            "TODistanceDisappear0": "5000",
            "TODistanceFade1": "350",
            "TODistanceDisappear1": "300",
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
            "hideNormalAttackUICooldown": "1",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.0001",
            "nlipsRange": "6000",
            "nlipsFar": "0.000015",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "104000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "0",
            "goblinsStartFade": "400",
            "goblinsOff": "400",
            "minimumZoomFactor": "1",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"upLOD": "5300", "downLOD": "5315"},
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
    "Abilities": {
        "variables": {},
        "functions": [
            {"name": "addAbility", "args": ["MoveCommand", "1", "1"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "1",
                    "0",
                    "0",
                    "0.35",
                    "1",
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Capturer, Frigate, Utility, Resource,,,,SmallCapitalShip,BigCapitalShip",
                    'justshoot"',
                ],
            },
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
        ],
    },
    "Docking": {
        "variables": {"dontDockWithOtherRaceShips": "0", "ignoreRaceWhenDocking": "0"},
        "functions": [],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "1",
            "launchTimeBeforeStart": "2",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"delta"',
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
                "args": ["gun_shivsentry_turret", "Weapon_Top", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivsentry_turret", "Weapon_Bottom", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivsentry_turret", "Weapon_Left", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivsentry_turret", "Weapon_Right", ""],
            },
        ],
    },
    "HardPoints": {"variables": {}, "functions": []},
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "40", "20"]}],
    },
    "Engines": {"variables": {"trailLinger": "2"}, "functions": []},
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": [
                    "data:sound/sfx/Ship/Vaygr/NonMilitary/",
                    "0",
                    "Engines/VWeaponPlatformEng",
                    "",
                    "1",
                    "Ambience/VWEAPONPLATFORMAMB",
                    "",
                ],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "25",
            "maxFalloffDamageDist": "25*3",
            "maxFalloffScuttleDamageDist": "25*6",
            "explosiveScuttleDamageOnDeath": "563",
            "maxFalloffForce": "20*10",
            "explosiveDamageOnDeath": "113",
        },
        "functions": [],
    },
}
SHI_TRIDENT = {
    "Ship info": {
        "variables": {
            "displayedName": '"SSG Trident"',
            "sobDescription": '"Sentry Gun"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "100",
            "regentime": "120",
            "minRegenTime": "120",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.0)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.0)',
        },
        "functions": [],
    },
    "Tactics And Multipliers": {
        "variables": {"defaultROE": '"Defensive"', "defaultStance": '"Neutral"'},
        "functions": [
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.10", "0.90", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATION", "0.95", "1.05", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["FIRERATE", "0.98", "1.02", "1.0"]},
            {"name": "setTacticsMults", "args": ["TURRETSPEED", "1.02", "0.98", "1.0"]},
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"formationSpacing": "45", "canJoinStrikeGroup": "0"},
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "100",
            "thrusterMaxSpeed": "0",
            "mainEngineMaxSpeed": "0",
            "rotationMaxSpeed": "120",
            "thrusterAccelTime": "0.11",
            "thrusterBrakeTime": "0.1",
            "mainEngineAccelTime": "0.11",
            "mainEngineBrakeTime": "0.1",
            "rotationAccelTime": "0.11",
            "rotationBrakeTime": "0.1",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "35",
            "battleScarCoverage": "0",
            "sobDieTime": "1",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "1",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "1",
            "accelerationAngle": "90",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "15",
            "descendPitch": "0",
            "goalReachEpsilon": "5",
            "slideMoveRange": "0",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "6",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "10",
            "tumbleStaticY": "20",
            "tumbleStaticZ": "5",
            "tumbleDynamicX": "2",
            "tumbleDynamicY": "10",
            "tumbleDynamicZ": "5",
            "tumbleSpecialDynamicX": "2",
            "tumbleSpecialDynamicY": "10",
            "tumbleSpecialDynamicZ": "5",
        },
        "functions": [],
    },
    "Swaying": {
        "variables": {
            "swayUpdateTime": "2",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"SuperCap"',
            "BuildFamily": '"Platform_Shi"',
            "AttackFamily": '"Frigate"',
            "DockFamily": '"Platform"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Platform"',
            "AutoFormationFamily": '"Fighter"',
            "CollisionFamily": '"Small"',
            "ArmourFamily": '"TurretArmour"',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [{"name": "setSupplyValue", "args": ["Platform", "1.0"]}],
    },
    "Ship Counter Rating": {
        "variables": {
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "8",
            "antiFighterValue": "8",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "8",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {"buildCost": "50", "buildTime": "6", "buildPriorityOrder": "10"},
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "5500",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "2000",
            "secSensorRange": "2000",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"Hexagon"',
            "TOScale": "1",
            "TODistanceFade0": "7000",
            "TODistanceDisappear0": "5000",
            "TODistanceFade1": "350",
            "TODistanceDisappear1": "300",
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
            "hideNormalAttackUICooldown": "1",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.0001",
            "nlipsRange": "6000",
            "nlipsFar": "0.000015",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "104000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "0",
            "goblinsStartFade": "400",
            "goblinsOff": "400",
            "minimumZoomFactor": "1",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"upLOD": "5300", "downLOD": "5315"},
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
    "Abilities": {
        "variables": {},
        "functions": [
            {"name": "addAbility", "args": ["MoveCommand", "1", "1"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "1",
                    "0",
                    "0",
                    "0.35",
                    "1",
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Capturer, Frigate, Utility, Resource,,,,SmallCapitalShip,BigCapitalShip",
                    'justshoot"',
                ],
            },
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
        ],
    },
    "Docking": {
        "variables": {"dontDockWithOtherRaceShips": "0", "ignoreRaceWhenDocking": "0"},
        "functions": [],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "1",
            "launchTimeBeforeStart": "2",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"delta"',
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
                "args": ["gun_shivsentry_turret", "Weapon_Top", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivsentry_turret", "Weapon_Bottom", ""],
            },
        ],
    },
    "HardPoints": {"variables": {}, "functions": []},
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "40", "20"]}],
    },
    "Engines": {"variables": {"trailLinger": "2"}, "functions": []},
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": [
                    "data:sound/sfx/Ship/Vaygr/NonMilitary/",
                    "0",
                    "Engines/VWeaponPlatformEng",
                    "",
                    "1",
                    "Ambience/VWEAPONPLATFORMAMB",
                    "",
                ],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "25",
            "maxFalloffDamageDist": "25*3",
            "maxFalloffScuttleDamageDist": "25*6",
            "explosiveScuttleDamageOnDeath": "563",
            "maxFalloffForce": "20*10",
            "explosiveDamageOnDeath": "113",
        },
        "functions": [],
    },
}
TER_MJOLNIR = {
    "Ship info": {
        "variables": {
            "displayedName": '"GTSG Mjolnir"',
            "sobDescription": '"Range: 16000m \\nDamage per Shot: 73150 \\nDPS: 2090 (Sustained) \\nCycle Time: 35"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": 'getShipNum(NewShipType, "maxhealth", 5000)',
            "regentime": "0",
            "minRegenTime": "0",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.0)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.0)',
        },
        "functions": [],
    },
    "Tactics And Multipliers": {
        "variables": {"defaultROE": '"Defensive"', "defaultStance": '"Neutral"'},
        "functions": [
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.10", "0.90", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATION", "0.95", "1.05", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["FIRERATE", "0.98", "1.02", "1.0"]},
            {"name": "setTacticsMults", "args": ["TURRETSPEED", "1.02", "0.98", "1.0"]},
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"formationSpacing": "45", "canJoinStrikeGroup": "0"},
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "15000",
            "thrusterMaxSpeed": "0",
            "mainEngineMaxSpeed": "0",
            "rotationMaxSpeed": "10",
            "thrusterAccelTime": "7",
            "thrusterBrakeTime": "2",
            "mainEngineAccelTime": "8",
            "mainEngineBrakeTime": "2",
            "rotationAccelTime": "2",
            "rotationBrakeTime": "0.7",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "200",
            "battleScarCoverage": "2",
            "sobDieTime": "2",
            "sobSpecialDieTime": "2",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "0",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "0.5",
            "accelerationAngle": "90",
            "mirrorAngle": "90",
            "secondaryTurnAngle": "90",
            "maxBankingAmount": "90",
            "descendPitch": "90",
            "goalReachEpsilon": "30",
            "slideMoveRange": "0",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "6",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "10",
            "tumbleStaticY": "20",
            "tumbleStaticZ": "5",
            "tumbleDynamicX": "2",
            "tumbleDynamicY": "10",
            "tumbleDynamicZ": "5",
            "tumbleSpecialDynamicX": "2",
            "tumbleSpecialDynamicY": "10",
            "tumbleSpecialDynamicZ": "5",
        },
        "functions": [],
    },
    "Swaying": {
        "variables": {
            "swayUpdateTime": "2",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"SuperCap"',
            "BuildFamily": '"Platform_Ter"',
            "AttackFamily": '"Frigate"',
            "DockFamily": '"Platform"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Platform"',
            "AutoFormationFamily": '"Fighter"',
            "CollisionFamily": '"Small"',
            "ArmourFamily": '"TurretArmour"',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [{"name": "setSupplyValue", "args": ["Platform", "1.0"]}],
    },
    "Ship Counter Rating": {
        "variables": {
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "8",
            "antiFighterValue": "8",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "8",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "3000",
            "buildTime": "120",
            "buildPriorityOrder": "30",
        },
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "16000",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "0",
            "prmSensorRange": "0",
            "secSensorRange": "0",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"Hexagon"',
            "TOScale": "1",
            "TODistanceFade0": "7000",
            "TODistanceDisappear0": "5000",
            "TODistanceFade1": "350",
            "TODistanceDisappear1": "300",
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
            "hideNormalAttackUICooldown": "1",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.0001",
            "nlipsRange": "6000",
            "nlipsFar": "0.000015",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "130000000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "0",
            "goblinsStartFade": "1500",
            "goblinsOff": "1500",
            "minimumZoomFactor": "0.6",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"upLOD": "12500", "downLOD": "12515"},
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
    "Abilities": {
        "variables": {},
        "functions": [
            {"name": "addAbility", "args": ["MoveCommand", "1", "1"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "1",
                    "0",
                    "0",
                    "0.35",
                    "1",
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Capturer, Frigate, Utility, Resource,,,,SmallCapitalShip,BigCapitalShip",
                    'justshoot"',
                ],
            },
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
        ],
    },
    "Docking": {
        "variables": {"dontDockWithOtherRaceShips": "0", "ignoreRaceWhenDocking": "0"},
        "functions": [],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "1",
            "launchTimeBeforeStart": "2",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"delta"',
        },
        "functions": [],
    },
    "Load Model": {
        "variables": {},
        "functions": [{"name": "LoadModel", "args": ["1"]}],
    },
    "Weapons": {"variables": {}, "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["Beam_MjolnirBeam", "Weapon_Beam", ""],
            },
    ]},
    "HardPoints": {
        "variables": {},
        "functions": [
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "310", "20"]}],
    },
    "Engines": {"variables": {"trailLinger": "4"}, "functions": []},
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": [
                    "data:sound/sfx/Ship/Vaygr/NonMilitary/",
                    "0",
                    "Engines/VWeaponPlatformEng",
                    "",
                    "1",
                    "Ambience/VWEAPONPLATFORMAMB",
                    "",
                ],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "25",
            "maxFalloffDamageDist": "25*3",
            "maxFalloffScuttleDamageDist": "25*6",
            "explosiveScuttleDamageOnDeath": "563",
            "maxFalloffForce": "20*10",
            "explosiveDamageOnDeath": "113",
        },
        "functions": [],
    },
}
