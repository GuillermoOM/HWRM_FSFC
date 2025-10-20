NON_NEGOTIABLES = {
    "sections": [
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
        "Latch Points",
    ],
    "variables": [
        "sobDescription",
        "maxhealth",
        "sideArmourDamage",
        "rearArmourDamage",
        "buildBatch",
        "disableOnRaceChange",
    ],
    "functions": ["loadShipPatchList"],
    "addAbilityFunction": [""],
}

TEMPLATE = {
    "Ship info": {
        "variables": {
            "displayedName": '"Cruiser"',
            "sobDescription": '"Advanced Cruiser"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": 'getShipNum(NewShipType, "maxhealth", 18000)',
            "regentime": "1500",
            "minRegenTime": "1500",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.2)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.2)',
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
    "Advanced Movement": {
        "variables": {
            "useEngagementRanges": "1",
            "thrusterUsage": "0.5",
            "accelerationAngle": "40",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "10",
            "descendPitch": "35",
            "goalReachEpsilon": "300",
            "slideMoveRange": "100",
            "controllerType": '"Ship"',
            "relativeMoveFactor": "3",
        },
        "functions": [],
    },
    "Formations": {
        "variables": {
            "formationSpacing": "250",
            "strikeGroupRadius": "100",
            "canSurround": "1",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "100",
            "thrusterMaxSpeed": "178",
            "mainEngineMaxSpeed": "178",
            "rotationMaxSpeed": "22",
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
            "sobDieTime": "1.9",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "0",
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
    "Layout Boundary": {
        "variables": {
            "useLayoutBounds": "1",
            "layoutBoundX": "80",
            "layoutBoundY": "50",
            "layoutBoundZ": "100",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"Cruiser_Ter"',
            "AttackFamily": '"Frigate"',
            "DockFamily": '"Shipyard"',
            "AvoidanceFamily": '"Frigate"',
            "DisplayFamily": '"Cruiser"',
            "AutoFormationFamily": '"Frigate"',
            "CollisionFamily": '"Big"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "MediumArmour")',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [
            {"name": "setSupplyValue", "args": ["Advanced Cruiser", "1.0"]},
            {"name": "setSupplyValue", "args": ["LayoutCruiser", "1.0"]},
        ],
    },
    "Ship Counter Rating": {
        "variables": {
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "12",
            "neutralValue": "0",
            "antiFighterValue": "12",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "12",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "700",
            "buildTime": "50",
            "buildPriorityOrder": "10",
        },
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "5500",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "1000",
            "prmSensorRange": "5000",
            "secSensorRange": "6000",
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
            "hideNormalAttackUICooldown": "1",
        },
        "functions": [],
    },
    "Non linear Scaling": {
        "variables": {
            "nlips": "0.00015",
            "nlipsRange": "6000",
            "nlipsFar": "0.00015",
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
            "minimumZoomFactor": "0.63",
        },
        "functions": [],
    },
    "Level of Detail": {"variables": {"minLOD": "0.25"}, "functions": []},
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
            {"name": "addAbility", "args": ["ParadeCommand", "1"]},
            {"name": "addAbility", "args": ['WaypointMove"']},
            {
                "name": "addAbility",
                "args": ["HyperSpaceCommand", "1", "1", "70", "350", "0", "0"],
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
                    "Fighter, Fighter_hw1, Corvette, Corvette_hw1, Frigate, Utility,,,, SmallCapitalShip, BigCapitalShip",
                    "MoveToTargetAndShoot_Frigate",
                    '{Fighter="MoveToTargetAndShoot_Frigate"}',
                    '{Fighter_hw1="MoveToTargetAndShoot_Frigate"}',
                    '{Corvette="MoveToTargetAndShoot_Frigate"}',
                    '{Corvette_hw1="MoveToTargetAndShoot_Frigate"}',
                    '{Munition="MoveToTargetAndShoot_Frigate"}',
                    '{SmallCapitalShip="MoveToTargetAndShoot_Frigate"}',
                    '{BigCapitalShip="MoveToTargetAndShoot_Frigate"}',
                    '{SubSystem="MoveToTargetAndShootvsSubsystem"}',
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "600"]},
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", ".7", "0.3"],
            },
            {"name": "addAbility", "args": ["CanBeCaptured", "30", "0.1", 'CapCap"']},
            {
                "name": "addAbility",
                "args": ["CanBeSalvageCaptured", "0", "1", "0", "0", "1", 'SalCap"'],
            },
            {"name": "addAbility", "args": ["CanBeRepaired", 'RepCap"']},
            {"name": "addAbility", "args": ["RetireAbility", "1", "1"]},
        ],
    },
    "Load Model": {
        "variables": {},
        "functions": [{"name": "LoadModel", "args": ["1"]}],
    },
    "HardPoints": {
        "variables": {},
        "functions": [
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "310", "20"]}],
    },
    "Engines": {
        "variables": {"trailLinger": "4"},
        "functions": [
            {
                "name": "setEngineBurn",
                "args": ["6", "1", "1.5", "60", "1.1", "0.1", "0.25", "120"],
            },
        ],
    },
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": [
                    "data:sound/sfx/ship",
                    "0",
                    "",
                    "",
                    "1",
                    "TerranCruiser",
                    "",
                ],
            }
        ],
    },
    "Weapons": {
        "variables": {},
        "functions": [
        ],
    },
    "Latch Points": {
        "variables": {},
        "functions": [
            {
                "name": "loadLatchPointList",
                "args": ["CapCap", "CapturePoint0"],
            },
            {
                "name": "loadLatchPointList",
                "args": ["RepCap", "RepairPoint0"],
            }
        ],
    },
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "100",
            "maxFalloffDamageDist": "100*2",
            "maxFalloffScuttleDamageDist": "100*4",
            "explosiveScuttleDamageOnDeath": "945",
            "maxFalloffForce": "500*10",
            "explosiveDamageOnDeath": "125",
            "radiusDamageEvadeMod": "1.1",
        },
        "functions": [],
    },
}
