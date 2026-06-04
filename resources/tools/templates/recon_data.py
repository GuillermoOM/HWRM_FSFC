NON_NEGOTIABLES = {
    "sections" : [
        "Tactics and Multipliers",
        "Main Ship Data",
        "Formations",
        "Docking",
        "Death Tumble",
        "Swaying",
        "Families",
        "Special Flight Maneuvers",
        "Supply",
        "Ship Counter Rating",
        "Sensors",
        "Tactical Overlay Icon",
        "Overlays",
        "Non linear Scaling",
        "Rendering",
        "Selection",
        "Abilities",
        "Launching",
        "Alternative Hyperspace Gate",
        "Load Model",
        "Engines",
        "Scuttle",
    ],
    "variables" : [
        "sobDescription",
        "maxhealth",
        "sideArmourDamage",
        "rearArmourDamage",
        "buildBatch",

    ],
    "functions": ["loadShipPatchList"],
    "addAbilityFunction": [
        "CanAttack"
    ]
}

TEMPLATE = {
    "Ship info": {
        "variables": {"displayedName": '"Ship Name"', "sobDescription": '"Recon"'},
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": 'getShipNum(NewShipType, "maxhealth", 90)',
            "regentime": "0",
            "minRegenTime": "0",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.0)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.0)',
        },
        "functions": [],
    },
    "Tactics And Multipliers": {
        "variables": {"defaultROE": '"Defensive"', "defaultStance": '"Aggressive"'},
        "functions": [
            {"name": "setTacticsMults", "args": ["MAXSPEED", "1.0", "1.10", "1.0"]},
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
            {"name": "setTacticsMults", "args": ["BULLETSPEED", "1.15", "1.0", "1.0"]},
            {
                "name": "setTacticsMults",
                "args": ["DAMAGEAPPLIED", "1.10", "0.90", "1.0"],
            },
            {"name": "setTacticsMults", "args": ["FIRERATE", "1.0", "1.25", "1.0"]},
        ],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "0.25",
            "accelerationAngle": "175",
            "mirrorAngle": "30",
            "secondaryTurnAngle": "90",
            "maxBankingAmount": "85",
            "descendPitch": "0",
            "goalReachEpsilon": "5",
            "slideMoveRange": "0",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "6",
            "agileFlight": "1",
            "homingDistance": "2000",
            "homingDelay": "0.5",
        },
        "functions": [
            {
                "name": "setSpeedvsAccuracyApplied",
                "args": ["100.0", "5.0", "250", "1.0", "409", "1.0", "563", "0.90"],
            }
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "1"}, "functions": []},
    "Formations": {
        "variables": {
            "SquadronSize": 'getShipNum(NewShipType, "SquadronSize", 1)',
            "formationSpacing": "30",
            "batchFormation": '"Batch_delta"',
            "strikeGroupSpeed": "5000",
            "canSurround": "0",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildBatch": 'getShipNum(NewShipType, "buildBatch", 4)',
            "buildCost": "430",
            "buildTime": "28",
            "buildPriorityOrder": "10",
        },
        "functions": [],
    },
    "Docking": {
        "variables": {
            "holdSlots": "4",
            "dockTimeBetweenTwoFormations": "0.5",
            "dockTimeBeforeStart": "0.5",
            "dockNrOfShipsInDockFormation": "1",
            "dockFormation": '"dockline"',
            "queueFormation": '"n_delta"',
            "ignoreRaceWhenDocking": "0",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "10",
            "thrusterMaxSpeed": "284",
            "mainEngineMaxSpeed": "284",
            "rotationMaxSpeed": "180",
            "thrusterAccelTime": "3",
            "thrusterBrakeTime": "1.5",
            "mainEngineAccelTime": "3",
            "mainEngineBrakeTime": "1.5",
            "rotationAccelTime": "0.6",
            "rotationBrakeTime": "0.3",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "160",
            "nebulaDamageTime": "80",
            "battleScarCoverage": "0",
            "sobDieTime": "0.1",
            "sobSpecialDieTime": "2",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0.5",
            "deadSobFadeTime": "0",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "10",
            "tumbleStaticY": "20",
            "tumbleStaticZ": "5",
            "tumbleDynamicX": "100",
            "tumbleDynamicY": "200",
            "tumbleDynamicZ": "50",
            "tumbleSpecialDynamicX": "600",
            "tumbleSpecialDynamicY": "800",
            "tumbleSpecialDynamicZ": "500",
        },
        "functions": [],
    },
    "Swaying": {
        "variables": {
            "swayUpdateTime": "2",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0.05",
            "swayRotateFactor": "0.1",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"SuperCap"',
            "BuildFamily": '"Fighter_Hgn"',
            "AttackFamily": '"Fighter"',
            "DockFamily": '"Fighter"',
            "AvoidanceFamily": '"Strikecraft"',
            "DisplayFamily": '"Fighter"',
            "AutoFormationFamily": '"Fighter"',
            "CollisionFamily": '"Small"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "Unarmoured")',
            "CombatFamily": '"Fighter_EMPScout"',
        },
        "functions": [],
    },
    "Special Flight Maneuvers": {
        "variables": {
            "mirrorAboveManeuver": '"ImmelMann_speedy, OneEightyDegRightTurn, OneEightyDegLeftTurn, ImmelMann_speedy, ImmelMann_speedy, ImmelMann_speedy"',
            "mirrorBelowManeuver": '"Split_S_speedy, OneEightyDegRightTurn, OneEightyDegLeftTurn, Split_S_speedy, Split_S_speedy, Split_S_speedy"',
            "specialTurnLeftManeuver": '"NinetyDegLeftTurn, None, None"',
            "specialTurnRightManeuver": '"NinetyDegRightTurn, None, None"',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [
            {"name": "setSupplyValue", "args": ["Fighter", "4.0"]},
            {"name": "setSupplyValue", "args": ["Scout", "4.0"]},
            {"name": "setSupplyValue", "args": ["LayoutFighter", "4.0"]},
        ],
    },
    "Ship Counter Rating": {
        "variables": {
            "fighterValue": "8",
            "corvetteValue": "0",
            "frigateValue": "0",
            "neutralValue": "0",
            "antiFighterValue": "0",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "8",
        },
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "4800",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1500",
            "prmSensorRange": "9000",
            "secSensorRange": "11000",
            "detectionStrength": "1",
        },
        "functions": [],
    },
    "Tactical Overlay Icon": {
        "variables": {
            "TOIcon": '"Triangle"',
            "TOScale": "1",
            "TODistanceFade0": "7000",
            "TODistanceDisappear0": "5000",
            "TODistanceFade1": "2500",
            "TODistanceDisappear1": "2000",
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
            "healthBarStyle": "0",
            "SMRepresentation": '"HardDot"',
            "hideNormalAttackUICooldown": "1",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.0008",
            "nlipsRange": "6000",
            "nlipsFar": "0.0003",
            "nlipsFarRange": "10000",
        },
        "functions": [],
    },
    "Rendering": {
        "variables": {
            "meshRenderLimit": "11000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "0",
            "goblinsStartFade": "210",
            "goblinsOff": "210",
            "minimumZoomFactor": "0.68",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"minLOD": "0.25", "upLOD": "700", "downLOD": "500"},
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
            {"name": "addAbility", "args": ["MoveCommand", "1", "0"]},
            {"name": "addAbility", "args": ["CanDock", "1", "1"]},
            {"name": "addAbility", "args": ["CanLaunch"]},
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {"name": "addAbility", "args": ["WaypointMove"]},
            {
                "name": "addAbility",
                "args": [
                    "CanAttack",
                    "1",
                    "2",
                    "1",
                    "0",
                    "0.35",
                    "1",
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1,,,,, Frigate, SmallCapitalShip, BigCapitalShip, Mothership",
                    "FlyBy_Interceptor_vs_Frigate",
                    '{ Fighter = "Fighter_vs_Fighter" }',
                    '{ Fighter_hw1 = "Fighter_vs_Fighter" }',
                    '{ Corvette = "Fighter_vs_Corvette" }',
                    '{ Corvette_hw1 = "Fighter_vs_Corvette" }',
                    '{ Frigate = "Fighter_vs_Frigate" }',
                    '{ SubSystem = "TopAttack_Interceptor_vs_Subsystem" }',
                    '{ SmallCapitalShip = "Fighter_vs_CapShip" }',
                    '{ BigCapitalShip = "Fighter_vs_CapShip" }',
                    '{ Mothership = "Fighter_vs_Mothership" }',
                    '{ ResourceLarge = "Fighter_vs_ResourceLarge" }',
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "500"]},
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
            {"name": "addAbility", "args": ["SensorPing", "0", "1", "10", "2.5"]},
            {"name": "addAbility", "args": ["RetireAbility", "1", "0"]},
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
    "Alternative Hyperspace Gate": {
        "variables": {
            "alternativeHyperspaceV": '"subspace_gate_small"',
            "alternativeHyperspaceA": '"etg/misc/small_subspace"',
            "alternativeHyperspaceTime": "7",
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
        ],
    },
    "Engines": {
        "variables": {},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["15", "0.5", "1", "15", "0", "0.7", "0.1", "25"],
            },
        ],
    },
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": ["data:sound/sfx/ship/", "0", "", "", "1", "sf_old", "", "3", "", "Root"],
            }
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "100", "20"]}],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "15",
            "maxFalloffDamageDist": "15 * 3",
            "maxFalloffScuttleDamageDist": "15 * 6",
            "explosiveScuttleDamageOnDeath": "15",
            "maxFalloffForce": "15 * 10",
            "explosiveDamageOnDeath": "3.4",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
}

