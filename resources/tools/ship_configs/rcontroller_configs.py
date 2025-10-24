TER_ZEPHYRUS = {
    "Ship info": {
        "variables": {
            "displayedName": '"GTG Zephyrus"',
            "sobDescription": '"Resource Controller"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "10000",
            "regentime": "350",
            "minRegenTime": "300",
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
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"paradeData": '"dummy_parade"', "canSurround": "1"},
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "20000",
            "thrusterMaxSpeed": "80",
            "mainEngineMaxSpeed": "120",
            "rotationMaxSpeed": "20",
            "thrusterAccelTime": "7",
            "thrusterBrakeTime": "2",
            "mainEngineAccelTime": "8",
            "mainEngineBrakeTime": "2",
            "rotationAccelTime": "0.75",
            "rotationBrakeTime": "0.3",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "0",
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
            "thrusterUsage": "1",
            "accelerationAngle": "80",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "60",
            "descendPitch": "60",
            "goalReachEpsilon": "30",
            "slideMoveRange": "100",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "3",
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
            "swayBobbingFactor": "0.05",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Layout Boundary": {
        "variables": {
            "useLayoutBounds": "1",
            "layoutBoundX": "30",
            "layoutBoundY": "20",
            "layoutBoundZ": "70",
            "layoutCenterX": "0",
            "layoutCenterY": "0",
            "layoutCenterZ": "-10",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"Utility_Ter"',
            "AttackFamily": '"ResourceLarge"',
            "DockFamily": '"Controller"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Utility"',
            "AutoFormationFamily": '"Frigate"',
            "CollisionFamily": '"Big"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "MediumArmour")',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [
            {"name": "setSupplyValue", "args": ["Resource", "1.0"]},
            {"name": "setSupplyValue", "args": ["Utility", "1.0"]},
            {"name": "setSupplyValue", "args": ["ResourceController", "1.0"]},
            {"name": "setSupplyValue", "args": ["LayoutResource", "1.0"]},
        ],
    },
    "Ship Counter Rating": {
        "variables": {
            "AttackPriorityMultiplier": "0.92",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "5",
            "antiFighterValue": "5",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "5",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "800",
            "buildTime": "30",
            "buildPriorityOrder": "30",
        },
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
            "TOIcon": '"Diamond"',
            "TOScale": "1",
            "TODistanceFade0": "10000",
            "TODistanceDisappear0": "8000",
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
            "nlips": "0.000125",
            "nlipsRange": "6000",
            "nlipsFar": "0.0001",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "14000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "1540",
            "goblinsOff": "1540",
            "minimumZoomFactor": "0.5",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"minLOD": "0.25", "upLOD": "12500", "downLOD": "12515"},
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
            {"name": "addAbility", "args": ["CanDock", "1", "0"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {
                "name": "addAbility",
                "args": ["ShipHold", "1", "200", "0", "rallypoint", "", "0"],
            },
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {"name": "addAbility", "args": ['WaypointMove"']},
            {
                "name": "addAbility",
                "args": ["HyperSpaceCommand", "1", "1", "60", "360", "0", "3"],
            },
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
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Frigate, Utility, SmallCapitalShip, BigCapitalShip, Mothership",
                    'JustShoot"',
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "800"]},
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
        ],
    },
    "Docking": {
        "variables": {
            "dockTimeBetweenTwoFormations": "1",
            "dockTimeBeforeStart": "2",
            "dockNrOfShipsInDockFormation": "1",
            "dockFormation": '"delta"',
            "queueFormation": '"dockline"',
            "dontDockWithOtherRaceShips": "1",
            "ignoreRaceWhenDocking": "0",
        },
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
                "args": ["gun_terlaser_gimble", "Weapon_01", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_subach_turret", "Weapon_02", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_subach_turret", "Weapon_03", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_04", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_05", ""],
            },
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "220", "20"]}],
    },
    "Engines": {
        "variables": {"trailLinger": "2"},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["6", "1", "1.5", "10", "1.1", "0.1", "0.25", "90"],
            },
        ],
    },
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": ["data:sound/sfx/ship/", "0", "", "", "1", "terrancruiser", ""],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "125",
            "maxFalloffDamageDist": "125*3",
            "maxFalloffScuttleDamageDist": "125*6",
            "explosiveScuttleDamageOnDeath": "125",
            "maxFalloffForce": "15*10",
            "explosiveDamageOnDeath": "27",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
}
TER_CHRONOS = {
    "Ship info": {
        "variables": {
            "displayedName": '"GTFr Chronos"',
            "sobDescription": '"Resource Controller"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "20000",
            "regentime": "330",
            "minRegenTime": "330",
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
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"paradeData": '"dummy_parade"', "canSurround": "1"},
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "20000",
            "thrusterMaxSpeed": "190",
            "mainEngineMaxSpeed": "190",
            "rotationMaxSpeed": "40",
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
            "swayBobbingFactor": "0.05",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Layout Boundary": {
        "variables": {
            "useLayoutBounds": "1",
            "layoutBoundX": "30",
            "layoutBoundY": "20",
            "layoutBoundZ": "70",
            "layoutCenterX": "0",
            "layoutCenterY": "0",
            "layoutCenterZ": "-10",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"Utility_Ter"',
            "AttackFamily": '"ResourceLarge"',
            "DockFamily": '"Controller"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Utility"',
            "AutoFormationFamily": '"Frigate"',
            "CollisionFamily": '"Big"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "MediumArmour")',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [
            {"name": "setSupplyValue", "args": ["Resource", "1.0"]},
            {"name": "setSupplyValue", "args": ["Utility", "1.0"]},
            {"name": "setSupplyValue", "args": ["ResourceController", "1.0"]},
            {"name": "setSupplyValue", "args": ["LayoutResource", "1.0"]},
        ],
    },
    "Ship Counter Rating": {
        "variables": {
            "AttackPriorityMultiplier": "0.92",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "5",
            "antiFighterValue": "5",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "5",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "625",
            "buildTime": "37",
            "buildPriorityOrder": "40",
        },
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
            "TOIcon": '"Diamond"',
            "TOScale": "1",
            "TODistanceFade0": "10000",
            "TODistanceDisappear0": "8000",
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
            "nlips": "0.000125",
            "nlipsRange": "6000",
            "nlipsFar": "0.0001",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "14000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "1540",
            "goblinsOff": "1540",
            "minimumZoomFactor": "0.5",
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
            {"name": "addAbility", "args": ["CanDock", "1", "0"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {
                "name": "addAbility",
                "args": ["ShipHold", "1", "40", "0", "rallypoint", "", "35"],
            },
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {"name": "addAbility", "args": ['WaypointMove"']},
            {
                "name": "addAbility",
                "args": ["HyperSpaceCommand", "1", "1", "70", "350", "0", "3"],
            },
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
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Frigate, Utility, SmallCapitalShip, BigCapitalShip, Mothership",
                    'JustShoot"',
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "800"]},
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
        ],
    },
    "Docking": {
        "variables": {
            "dockTimeBetweenTwoFormations": "1",
            "dockTimeBeforeStart": "2",
            "dockNrOfShipsInDockFormation": "1",
            "dockFormation": '"delta"',
            "queueFormation": '"dockline"',
            "dontDockWithOtherRaceShips": "1",
            "ignoreRaceWhenDocking": "0",
        },
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
            }
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "310", "18"]}],
    },
    "Engines": {
        "variables": {"trailLinger": "4"},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["7", "0.5", "1", "15", "0", "0.7", "0.1", "90"],
            }
        ],
    },
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": ["data:sound/sfx/ship/", "0", "", "", "1", "gtc_old", ""],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "125",
            "maxFalloffDamageDist": "125*3",
            "maxFalloffScuttleDamageDist": "125*6",
            "explosiveScuttleDamageOnDeath": "125",
            "maxFalloffForce": "15*10",
            "explosiveDamageOnDeath": "27",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
}
VAS_ANUKET = {
    "Ship info": {
        "variables": {
            "displayedName": '"GVG Anuket"',
            "sobDescription": '"Resource Controller"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": 'getShipNum(NewShipType, "maxhealth", 18000)',
            "regentime": "850",
            "minRegenTime": "850",
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
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"paradeData": '"dummy_parade"', "canSurround": "1"},
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "100",
            "thrusterMaxSpeed": "225",
            "mainEngineMaxSpeed": "225",
            "rotationMaxSpeed": "18",
            "thrusterAccelTime": "7",
            "thrusterBrakeTime": "2",
            "mainEngineAccelTime": "8",
            "mainEngineBrakeTime": "2",
            "rotationAccelTime": "0.75",
            "rotationBrakeTime": "0.3",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "65",
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
            "thrusterUsage": "1",
            "accelerationAngle": "40",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "20",
            "descendPitch": "20",
            "goalReachEpsilon": "30",
            "slideMoveRange": "100",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "3",
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
            "swayBobbingFactor": "0.05",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Layout Boundary": {
        "variables": {
            "useLayoutBounds": "1",
            "layoutBoundX": "30",
            "layoutBoundY": "20",
            "layoutBoundZ": "70",
            "layoutCenterX": "0",
            "layoutCenterY": "0",
            "layoutCenterZ": "-10",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"Utility_Vas"',
            "AttackFamily": '"ResourceLarge"',
            "DockFamily": '"Controller"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Utility"',
            "AutoFormationFamily": '"Frigate"',
            "CollisionFamily": '"Big"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "MediumArmour")',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [
            {"name": "setSupplyValue", "args": ["Resource", "1.0"]},
            {"name": "setSupplyValue", "args": ["Utility", "1.0"]},
            {"name": "setSupplyValue", "args": ["ResourceController", "1.0"]},
            {"name": "setSupplyValue", "args": ["LayoutResource", "1.0"]},
        ],
    },
    "Ship Counter Rating": {
        "variables": {
            "AttackPriorityMultiplier": "0.92",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "5",
            "antiFighterValue": "5",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "5",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "800",
            "buildTime": "45",
            "buildPriorityOrder": "30",
        },
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
            "TOIcon": '"Diamond"',
            "TOScale": "1",
            "TODistanceFade0": "10000",
            "TODistanceDisappear0": "8000",
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
            "nlips": "0.000125",
            "nlipsRange": "6000",
            "nlipsFar": "0.0001",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "14000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "1540",
            "goblinsOff": "1540",
            "minimumZoomFactor": "0.5",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"minLOD": "0.25", "upLOD": "12500", "downLOD": "12515"},
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
            {"name": "addAbility", "args": ["CanDock", "1", "0"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {
                "name": "addAbility",
                "args": ["ShipHold", "1", "200", "0", "rallypoint", "", "0"],
            },
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {"name": "addAbility", "args": ['WaypointMove"']},
            {
                "name": "addAbility",
                "args": ["HyperSpaceCommand", "1", "1", "70", "350", "0", "3"],
            },
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
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Frigate, Utility, SmallCapitalShip, BigCapitalShip, Mothership",
                    'JustShoot"',
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "800"]},
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
        ],
    },
    "Docking": {
        "variables": {
            "dockTimeBetweenTwoFormations": "1",
            "dockTimeBeforeStart": "2",
            "dockNrOfShipsInDockFormation": "1",
            "dockFormation": '"delta"',
            "queueFormation": '"dockline"',
            "dontDockWithOtherRaceShips": "1",
            "ignoreRaceWhenDocking": "0",
        },
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
                "args": ["gun_vaslaser_gimble", "Weapon_HullDefense1", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_subach_turret", "Weapon_HullDefense2", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_HullDefense3", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_subach_turret", "Weapon_HullDefense4", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_HullDefense5", ""],
            },
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "220", "20"]}],
    },
    "Engines": {
        "variables": {"trailLinger": "4"},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["6", "1", "1.5", "10", "1.1", "0.1", "0.25", "90"],
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
            "minFalloffDamageDist": "125",
            "maxFalloffDamageDist": "125*3",
            "maxFalloffScuttleDamageDist": "125*6",
            "explosiveScuttleDamageOnDeath": "125",
            "maxFalloffForce": "15*10",
            "explosiveDamageOnDeath": "27",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
}
SHI_RAHU = {
    "Ship info": {
        "variables": {
            "displayedName": '"SG Rahu"',
            "sobDescription": '"Resource Controller"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": 'getShipNum(NewShipType, "maxhealth", 18000)',
            "regentime": "850",
            "minRegenTime": "850",
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
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"paradeData": '"dummy_parade"', "canSurround": "1"},
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "100",
            "thrusterMaxSpeed": "225",
            "mainEngineMaxSpeed": "225",
            "rotationMaxSpeed": "18",
            "thrusterAccelTime": "7",
            "thrusterBrakeTime": "2",
            "mainEngineAccelTime": "8",
            "mainEngineBrakeTime": "2",
            "rotationAccelTime": "0.75",
            "rotationBrakeTime": "0.3",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "65",
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
            "thrusterUsage": "1",
            "accelerationAngle": "40",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "20",
            "descendPitch": "20",
            "goalReachEpsilon": "30",
            "slideMoveRange": "100",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "3",
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
            "swayBobbingFactor": "0.05",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Layout Boundary": {
        "variables": {
            "useLayoutBounds": "1",
            "layoutBoundX": "30",
            "layoutBoundY": "20",
            "layoutBoundZ": "70",
            "layoutCenterX": "0",
            "layoutCenterY": "0",
            "layoutCenterZ": "-10",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"Utility_Shi"',
            "AttackFamily": '"ResourceLarge"',
            "DockFamily": '"Controller"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Utility"',
            "AutoFormationFamily": '"Frigate"',
            "CollisionFamily": '"Big"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "MediumArmour")',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [
            {"name": "setSupplyValue", "args": ["Resource", "1.0"]},
            {"name": "setSupplyValue", "args": ["Utility", "1.0"]},
            {"name": "setSupplyValue", "args": ["ResourceController", "1.0"]},
            {"name": "setSupplyValue", "args": ["LayoutResource", "1.0"]},
        ],
    },
    "Ship Counter Rating": {
        "variables": {
            "AttackPriorityMultiplier": "0.92",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "5",
            "antiFighterValue": "5",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "5",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "800",
            "buildTime": "45",
            "buildPriorityOrder": "30",
        },
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
            "TOIcon": '"Diamond"',
            "TOScale": "1",
            "TODistanceFade0": "10000",
            "TODistanceDisappear0": "8000",
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
            "nlips": "0.000125",
            "nlipsRange": "6000",
            "nlipsFar": "0.0001",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "14000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "1540",
            "goblinsOff": "1540",
            "minimumZoomFactor": "0.5",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"minLOD": "0.25", "upLOD": "2250", "downLOD": "2000"},
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
            {"name": "addAbility", "args": ["CanDock", "1", "0"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {
                "name": "addAbility",
                "args": ["ShipHold", "1", "200", "0", "rallypoint", "", "0"],
            },
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {"name": "addAbility", "args": ['WaypointMove"']},
            {
                "name": "addAbility",
                "args": ["HyperSpaceCommand", "1", "1", "55", "275", "0", "3"],
            },
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
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Frigate, Utility, SmallCapitalShip, BigCapitalShip, Mothership",
                    'JustShoot"',
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "800"]},
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
        ],
    },
    "Docking": {
        "variables": {
            "dockTimeBetweenTwoFormations": "1",
            "dockTimeBeforeStart": "2",
            "dockNrOfShipsInDockFormation": "1",
            "dockFormation": '"delta"',
            "queueFormation": '"dockline"',
            "dontDockWithOtherRaceShips": "1",
            "ignoreRaceWhenDocking": "0",
        },
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
                "args": ["gun_shivheavylaser_turret", "Weapon_HullDefense1", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivheavylaser_turret", "Weapon_HullDefense2", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivheavylaser_turret", "Weapon_HullDefense3", ""],
            },
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "220", "15"]}],
    },
    "Engines": {
        "variables": {"trailLinger": "4"},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["6", "1", "1.5", "10", "1.1", "0.1", "0.25", "100"],
            }
        ],
    },
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": ["data:sound/sfx/ship/", "0", "", "", "1", "shivanutility", ""],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "125",
            "maxFalloffDamageDist": "125*3",
            "maxFalloffScuttleDamageDist": "125*6",
            "explosiveScuttleDamageOnDeath": "125",
            "maxFalloffForce": "15*10",
            "explosiveDamageOnDeath": "27",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
}
VAS_MAAT = {
    "Ship info": {
        "variables": {
            "displayedName": '"PVFr Maat"',
            "sobDescription": '"Resource Controller"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": 'getShipNum(NewShipType, "maxhealth", 18000)',
            "regentime": "850",
            "minRegenTime": "850",
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
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {"paradeData": '"dummy_parade"', "canSurround": "1"},
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "100",
            "thrusterMaxSpeed": "225",
            "mainEngineMaxSpeed": "225",
            "rotationMaxSpeed": "18",
            "thrusterAccelTime": "7",
            "thrusterBrakeTime": "2",
            "mainEngineAccelTime": "8",
            "mainEngineBrakeTime": "2",
            "rotationAccelTime": "0.75",
            "rotationBrakeTime": "0.3",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "65",
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
            "thrusterUsage": "1",
            "accelerationAngle": "40",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "20",
            "descendPitch": "20",
            "goalReachEpsilon": "30",
            "slideMoveRange": "100",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "3",
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
            "swayBobbingFactor": "0.05",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Layout Boundary": {
        "variables": {
            "useLayoutBounds": "1",
            "layoutBoundX": "30",
            "layoutBoundY": "20",
            "layoutBoundZ": "70",
            "layoutCenterX": "0",
            "layoutCenterY": "0",
            "layoutCenterZ": "-10",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"Utility_Vas"',
            "AttackFamily": '"ResourceLarge"',
            "DockFamily": '"Controller"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Utility"',
            "AutoFormationFamily": '"Frigate"',
            "CollisionFamily": '"Big"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "MediumArmour")',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [
            {"name": "setSupplyValue", "args": ["Resource", "1.0"]},
            {"name": "setSupplyValue", "args": ["Utility", "1.0"]},
            {"name": "setSupplyValue", "args": ["ResourceController", "1.0"]},
            {"name": "setSupplyValue", "args": ["LayoutResource", "1.0"]},
        ],
    },
    "Ship Counter Rating": {
        "variables": {
            "AttackPriorityMultiplier": "0.92",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "5",
            "antiFighterValue": "5",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "5",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "800",
            "buildTime": "45",
            "buildPriorityOrder": "30",
        },
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
            "TOIcon": '"Diamond"',
            "TOScale": "1",
            "TODistanceFade0": "10000",
            "TODistanceDisappear0": "8000",
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
            "nlips": "0.000125",
            "nlipsRange": "6000",
            "nlipsFar": "0.0001",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "14000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "1540",
            "goblinsOff": "1540",
            "minimumZoomFactor": "0.5",
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
            {"name": "addAbility", "args": ["CanDock", "1", "0"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {
                "name": "addAbility",
                "args": ["ShipHold", "1", "200", "0", "rallypoint", "", "0"],
            },
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {"name": "addAbility", "args": ['WaypointMove"']},
            {
                "name": "addAbility",
                "args": ["HyperSpaceCommand", "1", "1", "70", "350", "0", "3"],
            },
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
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Frigate, Utility, SmallCapitalShip, BigCapitalShip, Mothership",
                    'JustShoot"',
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "800"]},
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
        ],
    },
    "Docking": {
        "variables": {
            "dockTimeBetweenTwoFormations": "1",
            "dockTimeBeforeStart": "2",
            "dockNrOfShipsInDockFormation": "1",
            "dockFormation": '"delta"',
            "queueFormation": '"dockline"',
            "dontDockWithOtherRaceShips": "1",
            "ignoreRaceWhenDocking": "0",
        },
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
                "args": ["gun_vaslaser_gimble", "Weapon_HullDefense1", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_HullDefense2", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_avenger_gimble", "Weapon_HullDefense3", ""],
            },
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "220", "20"]}],
    },
    "Engines": {
        "variables": {"trailLinger": "4"},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["6", "1", "1.5", "10", "1.1", "0.1", "0.25", "90"],
            }
        ],
    },
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": ["data:sound/sfx/ship/", "0", "", "", "1", "vasudancruiser", ""],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "125",
            "maxFalloffDamageDist": "125*3",
            "maxFalloffScuttleDamageDist": "125*6",
            "explosiveScuttleDamageOnDeath": "125",
            "maxFalloffForce": "15*10",
            "explosiveDamageOnDeath": "27",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
}
