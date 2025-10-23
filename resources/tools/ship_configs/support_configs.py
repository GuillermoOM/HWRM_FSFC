TER_CENTAUR = {
    "Ship info": {
        "variables": {
            "displayedName": '"GTS Centaur"',
            "sobDescription": '"Support Ship"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "2000",
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
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.05", "0.95", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.05", "0.95", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATION", "0.95", "1.05", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.05", "0.95", "1.0"],
            },
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Docking": {
        "variables": {
            "holdSlots": "1",
            "dockTimeBetweenTwoFormations": "1",
            "dockTimeBeforeStart": "1",
            "dockNrOfShipsInDockFormation": "1",
            "dockFormation": '"delta"',
            "queueFormation": '"dockline"',
            "dontDockWithOtherRaceShips": "1",
            "ignoreRaceWhenDocking": "0",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "400",
            "thrusterMaxSpeed": "295",
            "mainEngineMaxSpeed": "295",
            "rotationMaxSpeed": "95",
            "thrusterAccelTime": "4",
            "thrusterBrakeTime": "2",
            "mainEngineAccelTime": "4",
            "mainEngineBrakeTime": "2",
            "rotationAccelTime": "0.6",
            "rotationBrakeTime": "0.3",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "3",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "100",
            "battleScarCoverage": "1",
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
            "thrusterUsage": "0.25",
            "accelerationAngle": "170",
            "mirrorAngle": "30",
            "secondaryTurnAngle": "90",
            "maxBankingAmount": "85",
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
            "swayUpdateTime": "5",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0.35",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"SuperCap"',
            "BuildFamily": '"Utility_Ter"',
            "AttackFamily": '"Resource"',
            "DockFamily": '"Corvette"',
            "AvoidanceFamily": '"StrikeCraft"',
            "DisplayFamily": '"Utility"',
            "AutoFormationFamily": '"Corvette"',
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
            "AttackPriorityMultiplier": "0.92",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "0",
            "antiFighterValue": "0",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "0",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {"buildCost": "150", "buildTime": "9", "buildPriorityOrder": "20"},
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "4800",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "3500",
            "secSensorRange": "4500",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"InvertedPentagon"',
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
            "hideNormalAttackUICooldown": "1",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.00045",
            "nlipsRange": "6000",
            "nlipsFar": "0.0002",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "13000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "660",
            "goblinsOff": "660",
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
            "militaryUnit": "0",
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
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "500"]},
            {
                "name": "addAbility",
                "args": ["HyperSpaceCommand", "1", "1", "25", "175", "0", "3"],
            },
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
            {"name": "addAbility", "args": ["RetireAbility", "1", "0"]},
            {
                "name": "addAbility",
                "args": [
                    "RepairCommand",
                    "1",
                    "400",
                    "0",
                    "0",
                    "",
                    '{Fighter = "20"}',
                    '{Corvette = "20"}',
                ],
            },
        ],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "1",
            "launchTimeBeforeStart": "1.5",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"delta"',
        },
        "functions": [],
    },
    "Load Model": {
        "variables": {},
        "functions": [{"name": "LoadModel", "args": ["1"]}],
    },
    "Weapons": {"variables": {}, "functions": []},
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "100", "10"]}],
    },
    "Engines": {
        "variables": {},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["7", "0.5", "1", "15", "0", "0.7", "0.1", "32"],
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
                    "supportambient",
                    "",
                ],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "15",
            "maxFalloffDamageDist": "15*3",
            "maxFalloffScuttleDamageDist": "15*6",
            "explosiveScuttleDamageOnDeath": "15",
            "maxFalloffForce": "15*10",
            "explosiveDamageOnDeath": "3.4",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
    "Formations": {"variables": {"strikeGroupSpeed": "5000"}, "functions": []},
}
TER_HYGEIA = {
    "Ship info": {
        "variables": {
            "displayedName": '"GTS Hygeia"',
            "sobDescription": '"Support Ship"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "1000",
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
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.05", "0.95", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.05", "0.95", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATION", "0.95", "1.05", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.05", "0.95", "1.0"],
            },
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Docking": {
        "variables": {
            "holdSlots": "1",
            "dockTimeBetweenTwoFormations": "1",
            "dockTimeBeforeStart": "1",
            "dockNrOfShipsInDockFormation": "1",
            "dockFormation": '"delta"',
            "queueFormation": '"dockline"',
            "dontDockWithOtherRaceShips": "1",
            "ignoreRaceWhenDocking": "0",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "410",
            "thrusterMaxSpeed": "280",
            "mainEngineMaxSpeed": "280",
            "rotationMaxSpeed": "95",
            "thrusterAccelTime": "4",
            "thrusterBrakeTime": "2",
            "mainEngineAccelTime": "4",
            "mainEngineBrakeTime": "2",
            "rotationAccelTime": "0.6",
            "rotationBrakeTime": "0.3",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "3",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "100",
            "battleScarCoverage": "1",
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
            "thrusterUsage": "0.25",
            "accelerationAngle": "170",
            "mirrorAngle": "30",
            "secondaryTurnAngle": "90",
            "maxBankingAmount": "85",
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
            "swayUpdateTime": "5",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0.35",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"SuperCap"',
            "BuildFamily": '"Utility_Ter"',
            "AttackFamily": '"Resource"',
            "DockFamily": '"Corvette"',
            "AvoidanceFamily": '"StrikeCraft"',
            "DisplayFamily": '"Utility"',
            "AutoFormationFamily": '"Corvette"',
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
            "AttackPriorityMultiplier": "0.92",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "0",
            "antiFighterValue": "0",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "0",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {"buildCost": "150", "buildTime": "9", "buildPriorityOrder": "20"},
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "4800",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "3500",
            "secSensorRange": "4500",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"InvertedPentagon"',
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
            "hideNormalAttackUICooldown": "1",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.00045",
            "nlipsRange": "6000",
            "nlipsFar": "0.0002",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "13000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "660",
            "goblinsOff": "660",
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
            "militaryUnit": "0",
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
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "500"]},
            {"name": "addAbility", "args": ["RetireAbility", "1", "0"]},
            {
                "name": "addAbility",
                "args": ["HyperSpaceCommand", "1", "1", "25", "175", "0", "3"],
            },
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
            {
                "name": "addAbility",
                "args": [
                    "RepairCommand",
                    "1",
                    "400",
                    "0",
                    "0",
                    "",
                    "{Fighter = '20'}",
                    "{Corvette = '20'}",
                ],
            },
        ],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "1",
            "launchTimeBeforeStart": "1.5",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"delta"',
        },
        "functions": [],
    },
    "Load Model": {
        "variables": {},
        "functions": [{"name": "LoadModel", "args": ["1"]}],
    },
    "Weapons": {"variables": {}, "functions": []},
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "100", "10"]}],
    },
    "Engines": {
        "variables": {},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["7", "0.5", "1", "15", "0", "0.7", "0.1", "32"],
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
                    "supportambient",
                    "",
                ],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "15",
            "maxFalloffDamageDist": "15*3",
            "maxFalloffScuttleDamageDist": "15*6",
            "explosiveScuttleDamageOnDeath": "15",
            "maxFalloffForce": "15*10",
            "explosiveDamageOnDeath": "3.4",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
    "Formations": {"variables": {"strikeGroupSpeed": "5000"}, "functions": []},
}
VAS_SCARAB = {
    "Ship info": {
        "variables": {
            "displayedName": '"PVS Scarab"',
            "sobDescription": '"Support Ship"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "1000",
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
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.05", "0.95", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.05", "0.95", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATION", "0.95", "1.05", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.05", "0.95", "1.0"],
            },
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Docking": {
        "variables": {
            "holdSlots": "1",
            "dockTimeBetweenTwoFormations": "1",
            "dockTimeBeforeStart": "1",
            "dockNrOfShipsInDockFormation": "1",
            "dockFormation": '"delta"',
            "queueFormation": '"dockline"',
            "dontDockWithOtherRaceShips": "1",
            "ignoreRaceWhenDocking": "0",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "410",
            "thrusterMaxSpeed": "295",
            "mainEngineMaxSpeed": "295",
            "rotationMaxSpeed": "95",
            "thrusterAccelTime": "4",
            "thrusterBrakeTime": "2",
            "mainEngineAccelTime": "4",
            "mainEngineBrakeTime": "2",
            "rotationAccelTime": "0.6",
            "rotationBrakeTime": "0.3",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "3",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "80",
            "battleScarCoverage": "1",
            "sobDieTime": "0.5",
            "sobSpecialDieTime": "2",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0.25",
            "deadSobFadeTime": "0",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "0.25",
            "accelerationAngle": "170",
            "mirrorAngle": "30",
            "secondaryTurnAngle": "90",
            "maxBankingAmount": "85",
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
            "swayUpdateTime": "5",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0.35",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"SuperCap"',
            "BuildFamily": '"Utility_Vas"',
            "AttackFamily": '"Resource"',
            "DockFamily": '"Corvette"',
            "AvoidanceFamily": '"StrikeCraft"',
            "DisplayFamily": '"Utility"',
            "AutoFormationFamily": '"Corvette"',
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
            "AttackPriorityMultiplier": "0.92",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "0",
            "antiFighterValue": "0",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "0",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {"buildCost": "150", "buildTime": "9", "buildPriorityOrder": "20"},
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "4800",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "3500",
            "secSensorRange": "4500",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"InvertedPentagon"',
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
            "hideNormalAttackUICooldown": "1",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.00045",
            "nlipsRange": "6000",
            "nlipsFar": "0.0002",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "13000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "660",
            "goblinsOff": "660",
            "minimumZoomFactor": "0.75",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"minLOD": "0.25", "upLOD": "3500", "downLOD": "3515"},
        "functions": [],
    },
    "Selection": {
        "variables": {
            "selectionLimit": "150000",
            "preciseATILimit": "0",
            "selectionPriority": "75",
            "militaryUnit": "0",
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
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "500"]},
            {
                "name": "addAbility",
                "args": ["HyperSpaceCommand", "1", "1", "25", "175", "0", "3"],
            },
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
            {"name": "addAbility", "args": ["RetireAbility", "1", "0"]},
            {
                "name": "addAbility",
                "args": [
                    "RepairCommand",
                    "1",
                    "400",
                    "0",
                    "0",
                    "",
                    "{ Fighter = '50'}",
                    "{ Corvette = '50' }",
                ],
            },
        ],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "1",
            "launchTimeBeforeStart": "1.5",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"delta"',
        },
        "functions": [],
    },
    "Load Model": {
        "variables": {},
        "functions": [{"name": "LoadModel", "args": ["1"]}],
    },
    "Weapons": {"variables": {}, "functions": []},
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "75", "9"]}],
    },
    "Engines": {
        "variables": {},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["7", "0.5", "1", "15", "0", "0.7", "0.1", "28"],
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
                    "supportambient",
                    "",
                ],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "15",
            "maxFalloffDamageDist": "15*3",
            "maxFalloffScuttleDamageDist": "15*6",
            "explosiveScuttleDamageOnDeath": "15",
            "maxFalloffForce": "15*10",
            "explosiveDamageOnDeath": "3.4",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
    "Formations": {"variables": {"strikeGroupSpeed": "5000"}, "functions": []},
}
VAS_NEPHTHYS = {
    "Ship info": {
        "variables": {
            "displayedName": '"GVS Nephthys"',
            "sobDescription": '"Support Ship"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "1000",
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
            {"name": "setTacticsMults", "args": ["ENGINEACCEL", "1.05", "0.95", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["THRUSTERACCEL", "1.05", "0.95", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["ROTATION", "0.95", "1.05", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["ROTATIONACCEL", "1.05", "0.95", "1.0"],
            },
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Docking": {
        "variables": {
            "holdSlots": "1",
            "dockTimeBetweenTwoFormations": "1",
            "dockTimeBeforeStart": "1",
            "dockNrOfShipsInDockFormation": "1",
            "dockFormation": '"delta"',
            "queueFormation": '"dockline"',
            "dontDockWithOtherRaceShips": "1",
            "ignoreRaceWhenDocking": "0",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "410",
            "thrusterMaxSpeed": "280",
            "mainEngineMaxSpeed": "280",
            "rotationMaxSpeed": "95",
            "thrusterAccelTime": "4",
            "thrusterBrakeTime": "2",
            "mainEngineAccelTime": "4",
            "mainEngineBrakeTime": "2",
            "rotationAccelTime": "0.6",
            "rotationBrakeTime": "0.3",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "3",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "80",
            "battleScarCoverage": "1",
            "sobDieTime": "0.5",
            "sobSpecialDieTime": "2",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0.25",
            "deadSobFadeTime": "0",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "0.25",
            "accelerationAngle": "170",
            "mirrorAngle": "30",
            "secondaryTurnAngle": "90",
            "maxBankingAmount": "85",
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
            "swayUpdateTime": "5",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0.35",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"SuperCap"',
            "BuildFamily": '"Utility_Vas"',
            "AttackFamily": '"Resource"',
            "DockFamily": '"Corvette"',
            "AvoidanceFamily": '"StrikeCraft"',
            "DisplayFamily": '"Utility"',
            "AutoFormationFamily": '"Corvette"',
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
            "AttackPriorityMultiplier": "0.92",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "0",
            "antiFighterValue": "0",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "0",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {"buildCost": "150", "buildTime": "9", "buildPriorityOrder": "20"},
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "4800",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "3500",
            "secSensorRange": "4500",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"InvertedPentagon"',
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
            "hideNormalAttackUICooldown": "1",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.00045",
            "nlipsRange": "6000",
            "nlipsFar": "0.0002",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "13000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "660",
            "goblinsOff": "660",
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
            "militaryUnit": "0",
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
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "500"]},
            {
                "name": "addAbility",
                "args": ["HyperSpaceCommand", "1", "1", "25", "175", "0", "3"],
            },
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
            {"name": "addAbility", "args": ["RetireAbility", "1", "0"]},
            {
                "name": "addAbility",
                "args": [
                    "RepairCommand",
                    "1",
                    "400",
                    "0",
                    "0",
                    "",
                    "{ Fighter = '50'}",
                    "{ Corvette = '50' }",
                ],
            },
        ],
    },
    "Launching": {
        "variables": {
            "launchTimeBetweenTwoFormations": "1",
            "launchTimeBeforeStart": "1.5",
            "launchNrOfShipsInDockFormation": "1",
            "launchFormation": '"delta"',
        },
        "functions": [],
    },
    "Load Model": {
        "variables": {},
        "functions": [{"name": "LoadModel", "args": ["1"]}],
    },
    "Weapons": {"variables": {}, "functions": []},
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "75", "9"]}],
    },
    "Engines": {
        "variables": {},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["7", "0.5", "1", "15", "0", "0.7", "0.1", "28"],
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
                    "supportambient",
                    "",
                ],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "15",
            "maxFalloffDamageDist": "15*3",
            "maxFalloffScuttleDamageDist": "15*6",
            "explosiveScuttleDamageOnDeath": "15",
            "maxFalloffForce": "15*10",
            "explosiveDamageOnDeath": "3.4",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
    "Formations": {"variables": {"strikeGroupSpeed": "5000"}, "functions": []},
}
