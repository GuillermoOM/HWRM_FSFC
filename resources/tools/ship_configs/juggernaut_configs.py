TER_COLOSSUS = {
    "Ship info": {
        "variables": {
            "displayedName": '"GTVA Colossus"',
            "sobDescription": '"Juggernaut"',
            "blobName": "GTVA Colossus",
            "blobNamePriority": "75",
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "1000000",
            "regentime": "2450",
            "minRegenTime": "2450",
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
    "Main Ship Data": {"variables": {"isTransferable": "0"}, "functions": []},
    "Formations": {
        "variables": {
            "paradeData": '"terran_parade"',
            "strikeGroupRadius": "200",
            "noCombatGrouping": "1",
            "canSurround": "1",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "10000000",
            "thrusterMaxSpeed": "125",
            "mainEngineMaxSpeed": "125",
            "rotationMaxSpeed": "3",
            "thrusterAccelTime": "20",
            "thrusterBrakeTime": "10",
            "mainEngineAccelTime": "20",
            "mainEngineBrakeTime": "10",
            "rotationAccelTime": "10",
            "rotationBrakeTime": "5",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "280",
            "nebulaDamageTime": "1500",
            "battleScarCoverage": "4",
            "battleScarBudgetLow": "1200",
            "battleScarBudgetNext": "1800",
            "sobDieTime": "16",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "0.1",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "1",
            "accelerationAngle": "30",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "40",
            "descendPitch": "40",
            "goalReachEpsilon": "25",
            "slideMoveRange": "600",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "1",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "2",
            "tumbleStaticY": "4",
            "tumbleStaticZ": "3",
            "tumbleDynamicX": "1",
            "tumbleDynamicY": "2",
            "tumbleDynamicZ": "2",
            "tumbleSpecialDynamicX": "1",
            "tumbleSpecialDynamicY": "2",
            "tumbleSpecialDynamicZ": "2",
        },
        "functions": [],
    },
    "Layout Boundary": {
        "variables": {},
        "functions": [
            {
                "name": "setTargetBox",
                "args": ["0", "-0.55", "0.35", "0.25", "0.55", "0.65", "0.8"],
            },
            {
                "name": "setTargetBox",
                "args": ["1", "-0.85", "0.1", "-0.35", "0.85", "0.85", "0.25"],
            },
            {
                "name": "setTargetBox",
                "args": ["2", "-0.7", "0.15", "-0.95", "0.7", "0.8", "-0.35"],
            },
            {
                "name": "setTargetBox",
                "args": ["3", "-0.4", "-0.95", "-0.2", "0.4", "0.1", "-0.1"],
            },
        ],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"SuperCap_Ter"',
            "AttackFamily": '"BigCapitalShip"',
            "DockFamily": '"Shipyard"',
            "AvoidanceFamily": '"SuperPriority"',
            "DisplayFamily": '"Capital"',
            "AutoFormationFamily": '"SuperCap"',
            "CollisionFamily": '"Big"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "HeavyArmour")',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [
            {"name": "setSupplyValue", "args": ["Capital", "1.0"]},
            {"name": "setSupplyValue", "args": ["Colossus", "1.0"]},
            {"name": "setSupplyValue", "args": ["LayoutBattleCruiser", "1.0"]},
        ],
    },
    "Ship Counter Rating": {
        "variables": {
            "AttackPriorityMultiplier": "0.94",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "80",
            "neutralValue": "30",
            "antiFighterValue": "0",
            "antiCorvetteValue": "5",
            "antiFrigateValue": "60",
            "totalValue": "110",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "50000",
            "buildTime": "500",
            "buildPriorityOrder": "20",
        },
        "functions": [{"name": "setConcurrentBuildLimit", "args": ["0", "2"]}],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "16800",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "5000",
            "prmSensorRange": "18000",
            "secSensorRange": "20000",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOScale": "1",
            "TOGroupScale": "1",
            "TOGroupMergeSize": "0",
        },
        "functions": [],
    },
    "Overlays": {
        "variables": {
            "mouseOverMinFadeSize": "0.045",
            "mouseOverMaxFadeSize": "0.1",
            "healthBarStyle": "2",
            "SMRepresentation": '"Mesh"',
            "SMHighlightDistMin": "15000",
            "SMHighlightDistMax": "25000",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0",
            "nlipsRange": "75000",
            "nlipsFar": "0",
            "nlipsFarRange": "0",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "AlwaysInRenderList": "1",
            "meshRenderLimit": "32500000000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "3200",
            "goblinsOff": "3200",
            "minimumZoomFactor": "0.5",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"minLOD": "0.25", "upLOD": "50000", "downLOD": "50015"},
        "functions": [],
    },
    "Selection": {
        "variables": {
            "selectionLimit": "150000",
            "preciseSelectionLimit": "7500",
            "preciseATILimit": "7000",
            "selectionPriority": "75",
            "militaryUnit": "1",
        },
        "functions": [],
    },
    "Alternative Hyperspace Gate": {
        "variables": {
            "alternativeHyperspaceV": "subspace_gate",
            "alternativeHyperspaceA": "etg/misc/large_subspace",
            "alternativeHyperspaceTime": "12",
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
                "args": [
                    "ShipHold",
                    "1",
                    "1000",
                    "60",
                    "rallypoint",
                    "Fighter, Utility",
                    "100",
                ],
            },
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {"name": "addAbility", "args": ['WaypointMove"']},
            {
                "name": "addAbility",
                "args": ["HyperSpaceCommand", "1", "1", "2500", "3750", "0", "0"],
            },
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "1",
                    "0",
                    "1",
                    "0.35",
                    "1.5",
                    "Capturer,Frigate,SmallCapitalShip,BigCapitalShip,Mothership,Utility,,,,,Corvette, Corvette_hw1,Fighter, Fighter_hw1",
                    "Frontal",
                    '{ Fighter = "MoveToTargetAndShoot" }',
                    '{ Fighter_hw1 = "MoveToTargetAndShoot" }',
                    '{ Corvette = "MoveToTargetAndShoot" }',
                    '{ Corvette_hw1 = "MoveToTargetAndShoot" }',
                    '{ Frigate = "MoveToTargetAndShoot" }',
                    '{ Munition = "MoveToTargetAndShoot" }',
                    '{ SubSystem = "MoveToTargetAndShoot" }',
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "1000"]},
            {
                "name": "addAbility",
                "args": [
                    "CanBuildShips",
                    "1",
                    "Fighter_Ter, Bomber_Ter, Cruiser_Ter, SuperCap_Ter, Utility_Ter, Platform_Ter, Battlecruiser_Ter, Shipyard_Ter, Probe_Ter",
                    "Utility, Fighter, Bomber, Cruiser, Capital, Platform",
                ],
            },
            {"name": "addAbility", "args": ["CanBeCaptured", "250", "0.5", 'CapCap"']},
            {"name": "addAbility", "args": ["CanBeRepaired", 'RepCap"']},
            
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
    "HardPoints": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Ter_BFGreen1",
                    "Weapon_Weapon_53",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_colbeam",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Ter_BFGreen2",
                    "Weapon_Weapon_54",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_colbeam",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Ter_BFGreen3",
                    "Weapon_Weapon_57",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_colbeam",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Ter_BFGreen4",
                    "Weapon_Weapon_58",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_colbeam",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Ter_BFGreen5",
                    "Weapon_Weapon_59",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_colbeam",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Ter_BFGreen6",
                    "Weapon_Weapon_60",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_colbeam",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
        ],
    },
    "Weapons": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_1", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_2", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_3", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_4", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_5", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_6", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_7", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_8", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_9", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_10", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_11", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_12", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_13", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_14", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_15", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_16", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_17", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_18", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_19", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_20", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_21", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_22", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_23", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_24", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_25", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_26", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_27", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_28", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_29", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_30", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_31", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_33", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_33", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_34", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_35", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_36", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_37", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_pihrana", "Weapon_Weapon_38", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_39", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_40", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_41", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_42", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_43", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_44", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_45", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_46", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_pihrana", "Weapon_Weapon_47", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_48", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_49", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_50", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_slashgreen", "Weapon_Weapon_51", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_slashgreen", "Weapon_Weapon_52", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_slashgreen", "Weapon_Weapon_55", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_slashgreen", "Weapon_Weapon_56", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_slashgreen", "Weapon_Weapon_61", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_slashgreen", "Weapon_Weapon_62", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_slashgreen", "Weapon_Weapon_63", ""],
            },
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "10000", "20"]}],
    },
    "Engines": {
        "variables": {"trailLinger": "2"},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["7", "0.5", "1", "15", "0", "0.7", "0.1", "1000"],
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
                    "TerranSuperCapital",
                    "",
                    "3",
                    "",
                    "Root",
                ],
            }
        ],
    },
    "Latch Points": {
        "variables": {},
        "functions": [
            {
                "name": "loadLatchPointList",
                "args": [
                    "CapCap",
                    "CapturePoint0",
                    "CapturePoint1",
                    "CapturePoint2",
                    'CapturePoint3"',
                    'CapturePoint4"',
                    "CapturePoint5",
                    "CapturePoint6",
                    "CapturePoint7",
                ],
            },
            {
                "name": "loadLatchPointList",
                "args": [
                    "RepCap",
                    "RepairPoint0",
                    "RepairPoint1",
                    "RepairPoint2",
                    "RepairPoint3",
                    "RepairPoint4",
                    "RepairPoint5",
                    "RepairPoint6",
                    "RepairPoint7",
                ],
            },
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "425",
            "maxFalloffDamageDist": "425 * 1.5",
            "maxFalloffScuttleDamageDist": "575 * 3",
            "explosiveScuttleDamageOnDeath": "3725",
            "maxFalloffForce": "500 * 10",
            "explosiveDamageOnDeath": "745",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
}
VAS_COLOSSUS = {
    "Ship info": {
        "variables": {
            "displayedName": '"GTVA Colossus"',
            "sobDescription": '"Juggernaut"',
            "blobName": "GTVA Colossus",
            "blobNamePriority": "75",
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "1000000",
            "regentime": "2450",
            "minRegenTime": "2450",
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
    "Main Ship Data": {"variables": {"isTransferable": "0"}, "functions": []},
    "Formations": {
        "variables": {
            "paradeData": '"vas_mothership_parade"',
            "strikeGroupRadius": "200",
            "noCombatGrouping": "1",
            "canSurround": "1",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "10000000",
            "thrusterMaxSpeed": "125",
            "mainEngineMaxSpeed": "125",
            "rotationMaxSpeed": "3",
            "thrusterAccelTime": "20",
            "thrusterBrakeTime": "10",
            "mainEngineAccelTime": "20",
            "mainEngineBrakeTime": "10",
            "rotationAccelTime": "10",
            "rotationBrakeTime": "5",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "280",
            "nebulaDamageTime": "1500",
            "battleScarCoverage": "4",
            "battleScarBudgetLow": "1200",
            "battleScarBudgetNext": "1800",
            "sobDieTime": "16",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "0.1",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "1",
            "accelerationAngle": "30",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "40",
            "descendPitch": "40",
            "goalReachEpsilon": "25",
            "slideMoveRange": "600",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "1",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "2",
            "tumbleStaticY": "4",
            "tumbleStaticZ": "3",
            "tumbleDynamicX": "1",
            "tumbleDynamicY": "2",
            "tumbleDynamicZ": "2",
            "tumbleSpecialDynamicX": "1",
            "tumbleSpecialDynamicY": "2",
            "tumbleSpecialDynamicZ": "2",
        },
        "functions": [],
    },
    "Layout Boundary": {
        "variables": {},
        "functions": [
            {
                "name": "setTargetBox",
                "args": ["0", "-0.55", "0.35", "0.25", "0.55", "0.65", "0.8"],
            },
            {
                "name": "setTargetBox",
                "args": ["1", "-0.85", "0.1", "-0.35", "0.85", "0.85", "0.25"],
            },
            {
                "name": "setTargetBox",
                "args": ["2", "-0.7", "0.15", "-0.95", "0.7", "0.8", "-0.35"],
            },
            {
                "name": "setTargetBox",
                "args": ["3", "-0.4", "-0.95", "-0.2", "0.4", "0.1", "-0.1"],
            },
        ],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"SuperCap_Vas"',
            "AttackFamily": '"BigCapitalShip"',
            "DockFamily": '"Shipyard"',
            "AvoidanceFamily": '"SuperPriority"',
            "DisplayFamily": '"Capital"',
            "AutoFormationFamily": '"SuperCap"',
            "CollisionFamily": '"Big"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "HeavyArmour")',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [
            {"name": "setSupplyValue", "args": ["Capital", "1.0"]},
            {"name": "setSupplyValue", "args": ["Colossus", "1.0"]},
            {"name": "setSupplyValue", "args": ["LayoutBattleCruiser", "1.0"]},
        ],
    },
    "Ship Counter Rating": {
        "variables": {
            "AttackPriorityMultiplier": "0.94",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "80",
            "neutralValue": "30",
            "antiFighterValue": "0",
            "antiCorvetteValue": "5",
            "antiFrigateValue": "60",
            "totalValue": "110",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "50000",
            "buildTime": "500",
            "buildPriorityOrder": "20",
        },
        "functions": [{"name": "setConcurrentBuildLimit", "args": ["0", "2"]}],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "16800",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "5000",
            "prmSensorRange": "18000",
            "secSensorRange": "20000",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOScale": "1",
            "TOGroupScale": "1",
            "TOGroupMergeSize": "0",
        },
        "functions": [],
    },
    "Overlays": {
        "variables": {
            "mouseOverMinFadeSize": "0.045",
            "mouseOverMaxFadeSize": "0.1",
            "healthBarStyle": "2",
            "SMRepresentation": '"Mesh"',
            "SMHighlightDistMin": "15000",
            "SMHighlightDistMax": "25000",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0",
            "nlipsRange": "75000",
            "nlipsFar": "0",
            "nlipsFarRange": "0",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "AlwaysInRenderList": "1",
            "meshRenderLimit": "32500000000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "3200",
            "goblinsOff": "3200",
            "minimumZoomFactor": "0.5",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"minLOD": "0.25", "upLOD": "50000", "downLOD": "50015"},
        "functions": [],
    },
    "Selection": {
        "variables": {
            "selectionLimit": "150000",
            "preciseSelectionLimit": "7500",
            "preciseATILimit": "7000",
            "selectionPriority": "75",
            "militaryUnit": "1",
        },
        "functions": [],
    },
    "Alternative Hyperspace Gate": {
        "variables": {
            "alternativeHyperspaceV": "subspace_gate",
            "alternativeHyperspaceA": "etg/misc/large_subspace",
            "alternativeHyperspaceTime": "12",
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
                "args": [
                    "ShipHold",
                    "1",
                    "1000",
                    "60",
                    "rallypoint",
                    "Fighter, Utility",
                    "100",
                ],
            },
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {"name": "addAbility", "args": ['WaypointMove"']},
            {
                "name": "addAbility",
                "args": ["HyperSpaceCommand", "1", "1", "2500", "3750", "0", "0"],
            },
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "1",
                    "0",
                    "1",
                    "0.35",
                    "1.5",
                    "Capturer,Frigate,SmallCapitalShip,BigCapitalShip,Mothership,Utility,,,,,Corvette, Corvette_hw1,Fighter, Fighter_hw1",
                    "Frontal",
                    '{ Fighter = "MoveToTargetAndShoot" }',
                    '{ Fighter_hw1 = "MoveToTargetAndShoot" }',
                    '{ Corvette = "MoveToTargetAndShoot" }',
                    '{ Corvette_hw1 = "MoveToTargetAndShoot" }',
                    '{ Frigate = "MoveToTargetAndShoot" }',
                    '{ Munition = "MoveToTargetAndShoot" }',
                    '{ SubSystem = "MoveToTargetAndShoot" }',
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "1000"]},
            {
                "name": "addAbility",
                "args": [
                    "CanBuildShips",
                    "1",
                    "Fighter_Vas, Bomber_Vas, Cruiser_Vas, SuperCap_Vas, Utility_Vas, Platform_Vas, Battlecruiser_Vas, Shipyard_Vas, Probe_Vas",
                    "Utility, Fighter, Bomber, Cruiser, Capital, Platform",
                ],
            },
            {"name": "addAbility", "args": ["CanBeCaptured", "250", "0.5", 'CapCap"']},
            {"name": "addAbility", "args": ["CanBeRepaired", 'RepCap"']},
            
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
    "HardPoints": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Ter_BFGreen1",
                    "Weapon_Weapon_53",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_colbeam",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Ter_BFGreen2",
                    "Weapon_Weapon_54",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_colbeam",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Ter_BFGreen3",
                    "Weapon_Weapon_57",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_colbeam",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Ter_BFGreen4",
                    "Weapon_Weapon_58",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_colbeam",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Ter_BFGreen5",
                    "Weapon_Weapon_59",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_colbeam",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Ter_BFGreen6",
                    "Weapon_Weapon_60",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_colbeam",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
        ],
    },
    "Weapons": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_1", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_2", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_3", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_4", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_5", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_6", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_7", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_8", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_9", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_Weapon_10", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_11", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_12", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_13", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_14", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_15", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_16", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_17", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_18", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_19", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_20", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_21", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_22", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_23", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_24", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_25", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_26", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_27", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Weapon_28", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_29", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Weapon_30", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_31", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_33", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_33", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_34", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_35", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_36", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_37", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_pihrana", "Weapon_Weapon_38", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_39", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_40", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_41", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_42", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Weapon_43", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_44", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_45", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_46", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_pihrana", "Weapon_Weapon_47", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_48", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_49", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_rockeye", "Weapon_Weapon_50", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_slashgreen", "Weapon_Weapon_51", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_slashgreen", "Weapon_Weapon_52", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_slashgreen", "Weapon_Weapon_55", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_slashgreen", "Weapon_Weapon_56", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_slashgreen", "Weapon_Weapon_61", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_slashgreen", "Weapon_Weapon_62", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_slashgreen", "Weapon_Weapon_63", ""],
            },
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "10000", "20"]}],
    },
    "Engines": {
        "variables": {"trailLinger": "2"},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["7", "0.5", "1", "15", "0", "0.7", "0.1", "1000"],
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
                    "TerranSuperCapital",
                    "",
                    "3",
                    "",
                    "Root",
                ],
            }
        ],
    },
    "Latch Points": {
        "variables": {},
        "functions": [
            {
                "name": "loadLatchPointList",
                "args": [
                    "CapCap",
                    "CapturePoint0",
                    "CapturePoint1",
                    "CapturePoint2",
                    'CapturePoint3"',
                    'CapturePoint4"',
                    "CapturePoint5",
                    "CapturePoint6",
                    "CapturePoint7",
                ],
            },
            {
                "name": "loadLatchPointList",
                "args": [
                    "RepCap",
                    "RepairPoint0",
                    "RepairPoint1",
                    "RepairPoint2",
                    "RepairPoint3",
                    "RepairPoint4",
                    "RepairPoint5",
                    "RepairPoint6",
                    "RepairPoint7",
                ],
            },
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "425",
            "maxFalloffDamageDist": "425 * 1.5",
            "maxFalloffScuttleDamageDist": "575 * 3",
            "explosiveScuttleDamageOnDeath": "3725",
            "maxFalloffForce": "500 * 10",
            "explosiveDamageOnDeath": "745",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
}
SHI_SATHANAS = {
    "Ship info": {
        "variables": {
            "displayedName": '"SJ Sathanas"',
            "sobDescription": '"Juggernaut"',
            "blobName": '"SJ Sathanas"',
            "blobNamePriority": "75",
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "1000000",
            "regentime": "2450",
            "minRegenTime": "2450",
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
    "Main Ship Data": {"variables": {"isTransferable": "0"}, "functions": []},
    "Formations": {
        "variables": {
            "paradeData": '"shi_build_parade"',
            "strikeGroupRadius": "200",
            "noCombatGrouping": "1",
            "canSurround": "1",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "10000000",
            "thrusterMaxSpeed": "120",
            "mainEngineMaxSpeed": "120",
            "rotationMaxSpeed": "3",
            "thrusterAccelTime": "20",
            "thrusterBrakeTime": "10",
            "mainEngineAccelTime": "20",
            "mainEngineBrakeTime": "10",
            "rotationAccelTime": "10",
            "rotationBrakeTime": "5",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "280",
            "nebulaDamageTime": "1500",
            "battleScarCoverage": "4",
            "battleScarBudgetLow": "1200",
            "battleScarBudgetNext": "1800",
            "sobDieTime": "16",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "0.1",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "1",
            "accelerationAngle": "30",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "40",
            "descendPitch": "40",
            "goalReachEpsilon": "25",
            "slideMoveRange": "600",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "1",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "2",
            "tumbleStaticY": "4",
            "tumbleStaticZ": "3",
            "tumbleDynamicX": "1",
            "tumbleDynamicY": "2",
            "tumbleDynamicZ": "2",
            "tumbleSpecialDynamicX": "1",
            "tumbleSpecialDynamicY": "2",
            "tumbleSpecialDynamicZ": "2",
        },
        "functions": [],
    },
    "Layout Boundary": {
        "variables": {
        },
        "functions": [
            {
                "name": "setTargetBox",
                "args": ["0", "-0.55", "-0.4", "-0.65", "0.55", "0.45", "0.05"],
            },
            {
                "name": "setTargetBox",
                "args": ["1", "-0.15", "-0.45", "0.3", "0.15", "-0.05", "0.45"],
            },

        ],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"SuperCap_Shi"',
            "AttackFamily": '"BigCapitalShip"',
            "DockFamily": '"Shipyard"',
            "AvoidanceFamily": '"SuperPriority"',
            "DisplayFamily": '"Capital"',
            "AutoFormationFamily": '"SuperCap"',
            "CollisionFamily": '"Big"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "HeavyArmour")',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [
            {"name": "setSupplyValue", "args": ["Capital", "1.0"]},
            {"name": "setSupplyValue", "args": ["Sathanas", "1.0"]},
            {"name": "setSupplyValue", "args": ["LayoutBattleCruiser", "1.0"]},
        ],
    },
    "Ship Counter Rating": {
        "variables": {
            "AttackPriorityMultiplier": "0.94",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "80",
            "neutralValue": "30",
            "antiFighterValue": "0",
            "antiCorvetteValue": "5",
            "antiFrigateValue": "60",
            "totalValue": "110",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "55000",
            "buildTime": "550",
            "buildPriorityOrder": "20",
        },
        "functions": [{"name": "setConcurrentBuildLimit", "args": ["0", "2"]}],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "16800",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "5000",
            "prmSensorRange": "18000",
            "secSensorRange": "20000",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {"TOScale": "1", "TOGroupScale": "1", "TOGroupMergeSize": "0"},
        "functions": [],
    },
    "Overlays": {
        "variables": {
            "mouseOverMinFadeSize": "0.045",
            "mouseOverMaxFadeSize": "0.1",
            "healthBarStyle": "2",
            "SMRepresentation": '"Mesh"',
            "SMHighlightDistMin": "20000",
            "SMHighlightDistMax": "50000",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0",
            "nlipsRange": "10000",
            "nlipsFar": "0",
            "nlipsFarRange": "0",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "AlwaysInRenderList": "1",
            "meshRenderLimit": "32500000000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "10000",
            "goblinsOff": "12000",
            "minimumZoomFactor": "0.5",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"minLOD": "0.25", "upLOD": "22000", "upLOD": "55000","downLOD": "22015",  "downLOD": "55015"},
        "functions": [],
    },
    "Selection": {
        "variables": {
            "selectionLimit": "150000",
            "preciseSelectionLimit": "7500",
            "preciseATILimit": "7000",
            "selectionPriority": "75",
            "militaryUnit": "1",
        },
        "functions": [],
    },
    "Alternative Hyperspace Gate": {
        "variables": {
            "alternativeHyperspaceV": "subspace_gate",
            "alternativeHyperspaceA": "etg/misc/large_subspace",
            "alternativeHyperspaceTime": "12",
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
                "args": [
                    "ShipHold",
                    "1",
                    "1000",
                    "60",
                    "rallypoint",
                    "Fighter, Utility",
                    "60",
                    '{Frigate = "800"}',
                    '{Fighter = "100"}',
                ],
            },
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {"name": "addAbility", "args": ['WaypointMove"']},
            {
                "name": "addAbility",
                "args": ["HyperSpaceCommand", "1", "1", "2000", "3000", "0", "0"],
            },
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "1",
                    "0",
                    "1",
                    "0.35",
                    "1.5",
                    "Capturer,Frigate,SmallCapitalShip,BigCapitalShip,Mothership,Utility,,,,,Corvette, Corvette_hw1,Fighter, Fighter_hw1",
                    "Frontal",
                    '{ Fighter = "MoveToTargetAndShoot" }',
                    '{ Fighter_hw1 = "MoveToTargetAndShoot" }',
                    '{ Corvette = "MoveToTargetAndShoot" }',
                    '{ Corvette_hw1 = "MoveToTargetAndShoot" }',
                    '{ Frigate = "MoveToTargetAndShoot" }',
                    '{ Munition = "MoveToTargetAndShoot" }',
                    '{ SubSystem = "MoveToTargetAndShoot" }',
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "1000"]},
            {
                "name": "addAbility",
                "args": [
                    "CanBuildShips",
                    "1",
                    "Fighter_Shi, Bomber_Shi, Cruiser_Shi, SuperCap_Shi, Utility_Shi, Platform_Shi, Battlecruiser_Shi, Shipyard_Shi, Probe_Shi",
                    "Utility, Fighter, Bomber, Cruiser, Capital, Platform",
                ],
            },
            {"name": "addAbility", "args": ["CanBeRepaired", 'RepCap"']},
            
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
    "HardPoints": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Shi_BFRed1",
                    "Weapon_1",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "Shi_sath1",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Shi_BFRed2",
                    "Weapon_2",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "Shi_sath2",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Shi_BFRed3",
                    "Weapon_3",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "Shi_sath3",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Shi_BFRed4",
                    "Weapon_4",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "Shi_sath4",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "Shi_Butt",
                    "Weapon_51",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "Shi_sathbutt",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "AWACS",
                    "Hardpoint_Sensors",
                    "System",
                    "Innate",
                    "Indestructible",
                    "awacs_0",
                    "awacs_0",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            },
        ],
    },
    "Weapons": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_5", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_6", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_7", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_8", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_9", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_10", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_11", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_12", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_13", ""],
            },
            {"name": "StartShipWeaponConfig", "args": ["beam_AARed", "Weapon_14", ""]},
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_15", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_16", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_17", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_18", ""],
            },
            {"name": "StartShipWeaponConfig", "args": ["beam_AARed", "Weapon_19", ""]},
            {"name": "StartShipWeaponConfig", "args": ["beam_AARed", "Weapon_20", ""]},
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_21", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_22", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_23", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_24", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_25", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_26", ""],
            },
            {"name": "StartShipWeaponConfig", "args": ["beam_AARed", "Weapon_27", ""]},
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_28", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_29", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_30", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_31", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_32", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_33", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_34", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_35", ""],
            },
            {"name": "StartShipWeaponConfig", "args": ["beam_AARed", "Weapon_36", ""]},
            {"name": "StartShipWeaponConfig", "args": ["beam_AARed", "Weapon_37", ""]},
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_pihrana", "Weapon_38", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_39", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_pihrana", "Weapon_40", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_41", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_pihrana", "Weapon_42", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_43", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_44", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_pihrana", "Weapon_45", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_pihrana", "Weapon_46", ""],
            },
            {"name": "StartShipWeaponConfig", "args": ["beam_AARed", "Weapon_47", ""]},
            {"name": "StartShipWeaponConfig", "args": ["beam_AARed", "Weapon_48", ""]},
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_longrangeflak_turret", "Weapon_49", "Fire1"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_longrangeflak_turret", "Weapon_50", "Fire2"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_52", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_53", ""],
            },
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "50000", "500"]}],
    },
    "Engines": {
        "variables": {"trailLinger": "2"},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["7", "0.5", "1", "15", "0", "0.7", "0.1", "1800"],
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
                    "ShivanSuperCapital",
                    "",
                    "3",
                    "",
                    "Root",
                ],
            }
        ],
    },
    "Latch Points": {
        "variables": {},
        "functions": [
            {
                "name": "loadLatchPointList",
                "args": [
                    "RepCap",
                    "RepairPoint0",
                    "RepairPoint1",
                    "RepairPoint2",
                    "RepairPoint3",
                    "RepairPoint4",
                    "RepairPoint5",
                    "RepairPoint6",
                ],
            },
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "425",
            "maxFalloffDamageDist": "425 * 1.5",
            "maxFalloffScuttleDamageDist": "575 * 3",
            "explosiveScuttleDamageOnDeath": "3725",
            "maxFalloffForce": "500 * 10",
            "explosiveDamageOnDeath": "745",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
}
