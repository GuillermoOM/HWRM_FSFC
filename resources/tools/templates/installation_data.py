NON_NEGOTIABLES = {
    "sections": [
        "Tactics and Multipliers",
        "Main Ship Data",
        "Docking",
        "Death Tumble",
        "Families",
        "Special Flight Maneuvers",
        "Supply",
        "Ship Counter Rating",
        "Selection",
        "Abilities",
        "Launching",
        "Load Model",
        "Scuttle",
    ],
    "variables": [
        "sobDescription",
        "sideArmourDamage",
        "rearArmourDamage",
        "buildBatch",
    ],
    "functions": ["loadShipPatchList"],
    "addAbilityFunction": [],
}

TEMPLATE = {
    "Ship info": {
        "variables": {
            "displayedName": '"$1544"',
            "sobDescription": '"Installation"',
            "blobName": '""',
            "blobNamePriority": "75",
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": 'getShipNum(NewShipType, "maxhealth", 175000)',
            "regentime": "2000",
            "minRegenTime": "2000",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.0)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.0)',
        },
        "functions": [],
    },
    "Tactics And Multipliers": {
        "variables": {"defaultROE": '"Defensive"', "defaultStance": '"Neutral"'},
        "functions": [
            {"name": "setTacticsMults", "args": ["FIRERATE", "0.98", "1.02", "1.0"]},
        ],
    },
    "Main Ship Data": {"variables": {"isTransferable": "0"}, "functions": []},
    "Deprecated": {"variables": {"addedUnitCaps": "101"}, "functions": []},
    "Formations": {
        "variables": {
            "paradeData": '"terran_parade"',
            "canJoinStrikeGroup": "0",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "2000",
            "thrusterMaxSpeed": "20",
            "mainEngineMaxSpeed": "20",
            "rotationMaxSpeed": "4",
            "thrusterAccelTime": "5",
            "thrusterBrakeTime": "2",
            "mainEngineAccelTime": "5",
            "mainEngineBrakeTime": "2",
            "rotationAccelTime": "0.7",
            "rotationBrakeTime": "0.3",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "280",
            "nebulaDamageTime": "500",
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
            "maxBankingAmount": "10",
            "descendPitch": "10",
            "goalReachEpsilon": "25",
            "slideMoveRange": "350",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "1",
        },
        "functions": [],
    },
    "Death Tumble": {
        "variables": {
            "tumbleStaticX": "2",
            "tumbleStaticY": "3",
            "tumbleStaticZ": "2",
            "tumbleDynamicX": "2",
            "tumbleDynamicY": "2",
            "tumbleDynamicZ": "2",
            "tumbleSpecialDynamicX": "2",
            "tumbleSpecialDynamicY": "2",
            "tumbleSpecialDynamicZ": "2",
        },
        "functions": [],
    },
    "Swaying": {
        "variables": {
            "swayUpdateTime": "10",
            "swayOffsetRandomX": "10",
            "swayOffsetRandomY": "10",
            "swayOffsetRandomZ": "10",
            "swayBobbingFactor": "0",
            "swayRotateFactor": "0",
        },
        "functions": [],
    },
    "Layout Boundary": {
        "variables": {
            "useLayoutBounds": "1",
            "layoutBoundX": "400",
            "layoutBoundY": "90",
            "layoutBoundZ": "1000",
            "layoutCenterX": "-20",
            "layoutCenterY": "0",
            "layoutCenterZ": "50",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"Shipyard_Ter"',
            "AttackFamily": '"BigCapitalShip"',
            "DockFamily": '"Shipyard"',
            "AvoidanceFamily": '"MotherShip"',
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
            {"name": "setSupplyValue", "args": ["Installation", "1.0"]},
        ],
    },
    "Ship Counter Rating": {
        "variables": {
            "AttackPriorityMultiplier": "0.96",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "15",
            "neutralValue": "5",
            "antiFighterValue": "5",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "20",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "3500",
            "buildTime": "75",
            "buildPriorityOrder": "20",
        },
        "functions": [{"name": "setConcurrentBuildLimit", "args": ["0", "2"]}],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "6500",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "5000",
            "secSensorRange": "6000",
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
            "mouseOverMinFadeSize": "0.085",
            "mouseOverMaxFadeSize": "0.15",
            "healthBarStyle": "2",
            "SMRepresentation": '"Mesh"',
            "SMHighlightDistMin": "30000",
            "SMHighlightDistMax": "50000",
            "hideNormalAttackUICooldown": "1",
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
            "meshRenderLimit": "35000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "3200",
            "goblinsOff": "3200",
            "minimumZoomFactor": "0.5",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"upLOD": "6150", "downLOD": "6165"},
        "functions": [],
    },
    "Selection": {
        "variables": {
            "selectionLimit": "150000",
            "preciseSelectionLimit": "15000",
            "preciseATILimit": "0",
            "selectionPriority": "75",
            "militaryUnit": "0",
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
            {"name": "addAbility", "args": ["CanDock", "1", "0"]},
            {"name": "addAbility", "args": ['CanLaunch"']},
            {
                "name": "addAbility",
                "args": [
                    "ShipHold",
                    "1",
                    "1000",
                    "16",
                    "rallypoint",
                    "Fighter, Utility",
                    "40",
                ],
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
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Frigate, Utility, Resource,,,,SmallCapitalShip, BigCapitalShip",
                    'JustShoot"',
                ],
            },
            {
                "name": "addAbility",
                "args": [
                    "CanBuildShips",
                    "1",
                    "Fighter_Ter, Bomber_Ter, Cruiser_Ter, SuperCap_Ter, Utility_Ter, Platform_Ter, Battlecruiser_Ter, Shipyard_Ter, Probe_Ter",
                    "Utility, Fighter, Bomber, Cruiser, Capital, Platform",
                ],
            },
            {
                "name": "addAbility",
                "args": ["CanBeCaptured", "300", "0.1", 'CapCap"'],
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
    "Weapons": {
        "variables": {},
        "functions": [],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "10000", "20"]}],
    },
    "HardPoints": {
        "variables": {"canRetireSubSystems": "1"},
        "functions": [],
    },
    "Engines": {
        "variables": {"trailLinger": "2"},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["9", "0.2", "0.5", "300", "1.02", "0.1", "0.25", "380"],
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
                    "inst2",
                    "",
                    "3",
                    "",
                    'Root"',
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
                    "CapturePoint1",
                    "CapturePoint2",
                ],
            },
            {
                "name": "loadLatchPointList",
                "args": [
                    "RepCap",
                    "RepairPoint1",
                    "RepairPoint2",
                ],
            },
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "1075",
            "maxFalloffDamageDist": "1075*1.5",
            "maxFalloffScuttleDamageDist": "1075*3",
            "explosiveScuttleDamageOnDeath": "2820",
            "maxFalloffForce": "500*10",
            "explosiveDamageOnDeath": "564",
        },
        "functions": [],
    },
}
