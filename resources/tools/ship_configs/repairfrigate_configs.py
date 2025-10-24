TER_ARGO = {
    "Ship info": {
        "variables": {
            "displayedName": '"GTT Argo"',
            "sobDescription": '"Repair Frigate"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "13500",
            "regentime": "330",
            "minRegenTime": "330",
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
    "Movement": {
        "variables": {
            "mass": "20000",
            "thrusterMaxSpeed": "35",
            "mainEngineMaxSpeed": "140",
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
            "sobDieTime": "2",
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
    "Layout Boundary": {
        "variables": {
            "useLayoutBounds": "1",
            "layoutBoundX": "60",
            "layoutBoundY": "55",
            "layoutBoundZ": "100",
            "layoutCenterX": "0",
            "layoutCenterY": "10",
            "layoutCenterZ": "10",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"Utility_Ter"',
            "AttackFamily": '"Frigate"',
            "DockFamily": '"Frigate"',
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
        "functions": [{"name": "setSupplyValue", "args": ["Utility", "1.0"]}],
    },
    "Ship Counter Rating": {
        "variables": {
            "AttackPriorityMultiplier": "0.95",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "8",
            "neutralValue": "0",
            "antiFighterValue": "0",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "8",
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
            {"name": "addAbility", "args": ["WaypointMove"]},
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
                    "1",
                    "0.35",
                    "1.5",
                    "Capturer, Frigate, SmallCapitalShip, BigCapitalShip, Mothership, Utility, Corvette, Corvette_hw1, Fighter, Fighter_hw1",
                    "Frontal_SupportFrigate",
                    '{Fighter="movetotargetandshoot_Frigate_vs_Fighters"}',
                    '{Fighter_hw1="movetotargetandshoot_Frigate_vs_Fighters"}',
                    '{Corvette="movetotargetandshoot_Frigate_vs_Corvettes"}',
                    '{Corvette_hw1="movetotargetandshoot_Frigate_vs_Corvettes"}',
                    '{Munition="Frontal_SupportFrigate"}',
                    '{SubSystem="FrontalVsSubSystem"}',
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "600"]},
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
            {
                "name": "addAbility",
                "args": [
                    "RepairCommand",
                    "1",
                    "0",
                    "25",
                    "1",
                    "Frontal_SupportFrigate",
                    "{Fighter = 0}",
                    "{Corvette = 0}",
                ],
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
    "HardPoints": {"variables": {}, "functions": []},
    "Weapons": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Bottom", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Top", ""],
            },
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
                "args": [
                    "data:sound/sfx/ship/",
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
    "Latch Points": {"variables": {}, "functions": []},
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "100",
            "maxFalloffDamageDist": "100*2",
            "maxFalloffScuttleDamageDist": "100*4",
            "explosiveScuttleDamageOnDeath": "1125",
            "maxFalloffForce": "500*10",
            "explosiveDamageOnDeath": "225",
        },
        "functions": [],
    },
}
VAS_SATIS = {
    "Ship info": {
        "variables": {
            "displayedName": '"GVFr Satis"',
            "sobDescription": '"Repair Frigate"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "10000",
            "regentime": "245",
            "minRegenTime": "245",
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
    "Movement": {
        "variables": {
            "mass": "20000",
            "thrusterMaxSpeed": "55",
            "mainEngineMaxSpeed": "220",
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
    "Layout Boundary": {
        "variables": {
            "useLayoutBounds": "1",
            "layoutBoundX": "60",
            "layoutBoundY": "55",
            "layoutBoundZ": "100",
            "layoutCenterX": "0",
            "layoutCenterY": "10",
            "layoutCenterZ": "10",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"Utility_Vas"',
            "AttackFamily": '"Frigate"',
            "DockFamily": '"Frigate"',
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
        "functions": [{"name": "setSupplyValue", "args": ["Utility", "1.0"]}],
    },
    "Ship Counter Rating": {
        "variables": {
            "AttackPriorityMultiplier": "0.95",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "8",
            "neutralValue": "0",
            "antiFighterValue": "0",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "8",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "550",
            "buildTime": "35",
            "buildPriorityOrder": "40",
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
            {"name": "addAbility", "args": ["WaypointMove"]},
            {
                "name": "addAbility",
                "args": ["HyperSpaceCommand", "1", "1", "50", "300", "0", "3"],
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
                    "Capturer, Frigate, SmallCapitalShip, BigCapitalShip, Mothership, Utility, Corvette, Corvette_hw1, Fighter, Fighter_hw1",
                    "Frontal_SupportFrigate",
                    '{Fighter="movetotargetandshoot_Frigate_vs_Fighters"}',
                    '{Fighter_hw1="movetotargetandshoot_Frigate_vs_Fighters"}',
                    '{Corvette="movetotargetandshoot_Frigate_vs_Corvettes"}',
                    '{Corvette_hw1="movetotargetandshoot_Frigate_vs_Corvettes"}',
                    '{Munition="Frontal_SupportFrigate"}',
                    '{SubSystem="FrontalVsSubSystem"}',
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "600"]},
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
            {
                "name": "addAbility",
                "args": [
                    "RepairCommand",
                    "1",
                    "0",
                    "25",
                    "1",
                    "Frontal_SupportFrigate",
                    "{Fighter=0}",
                    "{Corvette=0}",
                ],
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
    "HardPoints": {"variables": {}, "functions": []},
    "Weapons": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vashuge_turret", "Weapon_Bottom", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_Top", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_Back", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_Left", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_Right", ""],
            },
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "310", "17"]}],
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
    "Latch Points": {"variables": {}, "functions": []},
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "100",
            "maxFalloffDamageDist": "100*2",
            "maxFalloffScuttleDamageDist": "100*4",
            "explosiveScuttleDamageOnDeath": "1125",
            "maxFalloffForce": "500*10",
            "explosiveDamageOnDeath": "225",
        },
        "functions": [],
    },
}
SHI_ASMODEUS = {
    "Ship info": {
        "variables": {
            "displayedName": '"SFr Asmodeus"',
            "sobDescription": '"Repair Frigate"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "8000",
            "regentime": "260",
            "minRegenTime": "260",
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
    "Movement": {
        "variables": {
            "mass": "20000",
            "thrusterMaxSpeed": "210",
            "mainEngineMaxSpeed": "210",
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
    "Layout Boundary": {
        "variables": {
            "useLayoutBounds": "1",
            "layoutBoundX": "60",
            "layoutBoundY": "55",
            "layoutBoundZ": "100",
            "layoutCenterX": "0",
            "layoutCenterY": "10",
            "layoutCenterZ": "10",
        },
        "functions": [],
    },
    "Families": {
        "variables": {
            "MinimalFamilyToFindPathAround": '"MotherShip"',
            "BuildFamily": '"Utility_Shi"',
            "AttackFamily": '"Frigate"',
            "DockFamily": '"Frigate"',
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
        "functions": [{"name": "setSupplyValue", "args": ["Utility", "1.0"]}],
    },
    "Ship Counter Rating": {
        "variables": {
            "AttackPriorityMultiplier": "0.95",
            "fighterValue": "0",
            "corvetteValue": "0",
            "frigateValue": "8",
            "neutralValue": "0",
            "antiFighterValue": "0",
            "antiCorvetteValue": "0",
            "antiFrigateValue": "0",
            "totalValue": "8",
        },
        "functions": [],
    },
    "Construction": {
        "variables": {
            "buildCost": "550",
            "buildTime": "35",
            "buildPriorityOrder": "40",
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
            {"name": "addAbility", "args": ["WaypointMove"]},
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
                    "1",
                    "0.35",
                    "1.5",
                    "Capturer, Frigate, SmallCapitalShip, BigCapitalShip, Mothership, Utility, Corvette, Corvette_hw1, Fighter, Fighter_hw1",
                    "Frontal_SupportFrigate",
                    '{Fighter="movetotargetandshoot_Frigate_vs_Fighters"}',
                    '{Fighter_hw1="movetotargetandshoot_Frigate_vs_Fighters"}',
                    '{Corvette="movetotargetandshoot_Frigate_vs_Corvettes"}',
                    '{Corvette_hw1="movetotargetandshoot_Frigate_vs_Corvettes"}',
                    '{Munition="Frontal_SupportFrigate"}',
                    '{SubSystem="FrontalVsSubSystem"}',
                ],
            },
            {"name": "addAbility", "args": ["GuardCommand", "1", "3000", "600"]},
            {
                "name": "addAbility",
                "args": ["HyperspaceViaGateCommand", "1", "3", "1", "0.3"],
            },
            {
                "name": "addAbility",
                "args": [
                    "RepairCommand",
                    "1",
                    "0",
                    "25",
                    "1",
                    "Frontal_SupportFrigate",
                ],
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
    "HardPoints": {"variables": {}, "functions": []},
    "Weapons": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Top", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivheavylaser_gimble", "Weapon_Back", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivheavylaser_gimble", "Weapon_Left", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivheavylaser_gimble", "Weapon_Right", ""],
            },
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
                "args": ["7", "0.5", "1", "15", "0", "0.7", "0.1", "80"],
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
    "Latch Points": {"variables": {}, "functions": []},
    "Scuttle": {
        "variables": {
            "minFalloffDamageDist": "100",
            "maxFalloffDamageDist": "100*2",
            "maxFalloffScuttleDamageDist": "100*4",
            "explosiveScuttleDamageOnDeath": "1125",
            "maxFalloffForce": "500*10",
            "explosiveDamageOnDeath": "225",
        },
        "functions": [],
    },
}
