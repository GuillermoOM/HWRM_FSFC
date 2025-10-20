TER_FENRIS = {
    "Ship info": {
        "variables": {
            "displayedName": '"GTC Fenris"',
            "sobDescription": '"Light Cruiser"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": 'getShipNum(NewShipType, "maxhealth", 18000)',
            "regentime": "375",
            "minRegenTime": "375",
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
            "maxBankingAmount": "20",
            "descendPitch": "20",
            "goalReachEpsilon": "30",
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
            "mass": "25000",
            "thrusterMaxSpeed": "45",
            "mainEngineMaxSpeed": "90",
            "rotationMaxSpeed": "20",
            "thrusterAccelTime": "10",
            "thrusterBrakeTime": "5",
            "mainEngineAccelTime": "10",
            "mainEngineBrakeTime": "5",
            "rotationAccelTime": "5",
            "rotationBrakeTime": "2.5",
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
            {"name": "setSupplyValue", "args": ["Cruiser", "1.0"]},
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
            "buildCost": "500",
            "buildTime": "30",
            "buildPriorityOrder": "30",
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
                    "frontal_frigate",
                    '{Fighter="MoveToTargetAndShoot_Frigate"}',
                    '{Fighter_hw1="MoveToTargetAndShoot_Frigate"}',
                    '{Corvette="MoveToTargetAndShoot_Frigate"}',
                    '{Corvette_hw1="MoveToTargetAndShoot_Frigate"}',
                    '{Munition="MoveToTargetAndShoot_Frigate"}',
                    '{SmallCapitalShip="frontal_frigate"}',
                    '{BigCapitalShip="frontal_frigate"}',
                    '{SubSystem="FrontalVsSubSystem"}',
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
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "LtTerSlash",
                    "Weapon_Beam1",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_fenrisbeam",
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
                    "FusionMortar",
                    "Weapon_Missile",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_fenrismissile",
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
            }
        ],
    },
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": ["data:sound/sfx/ship", "0", "", "", "1", "TerranCruiser", ""],
            }
        ],
    },
    "Weapons": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Gun1", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Gun3", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Gun4", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["Beam_AABlue", "Weapon_Gun5", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Gun6", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_gimble", "Weapon_Gun7", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["Beam_AABlue", "Weapon_Gun8", ""],
            },
        ],
    },
    "Latch Points": {
        "variables": {},
        "functions": [
            {
                "name": "loadLatchPointList",
                "args": ["CapCap", "CapturePoint1"],
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
VAS_ATEN = {
    "Ship info": {
        "variables": {
            "displayedName": '"GVC Aten"',
            "sobDescription": '"Light Cruiser"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": 'getShipNum(NewShipType, "maxhealth", 18000)',
            "regentime": "465",
            "minRegenTime": "465",
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
            "mass": "27500",
            "thrusterMaxSpeed": "105",
            "mainEngineMaxSpeed": "105",
            "rotationMaxSpeed": "20",
            "thrusterAccelTime": "10",
            "thrusterBrakeTime": "5",
            "mainEngineAccelTime": "10",
            "mainEngineBrakeTime": "5",
            "rotationAccelTime": "5",
            "rotationBrakeTime": "2.5",
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
            "BuildFamily": '"Cruiser_Vas"',
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
            {"name": "setSupplyValue", "args": ["Cruiser", "1.0"]},
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
            "buildCost": "450",
            "buildTime": "30",
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
    "HardPoints": {"variables": {}, "functions": []},
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
            }
        ],
    },
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": ["data:sound/sfx/ship", "0", "", "", "1", "TerranCruiser", ""],
            }
        ],
    },
    "Weapons": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_turret", "Weapon_Top", "Weapon_Top"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_turret", "Weapon_Bottom", "Weapon_Bottom"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_B1", ""],
            },
            {"name": "StartShipWeaponConfig", "args": ["beam_aablue", "Weapon_B1", ""]},
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_B2", ""],
            },
            {"name": "StartShipWeaponConfig", "args": ["beam_aablue", "Weapon_B2", ""]},
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_mekhu_turret", "Weapon_Left", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_mekhu_turret", "Weapon_Right", ""],
            },
        ],
    },
    "Latch Points": {
        "variables": {},
        "functions": [
            {
                "name": "loadLatchPointList",
                "args": ["CapCap", "CapturePoint1"],
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
SHI_CAIN = {
    "Ship info": {
        "variables": {
            "displayedName": '"SC Cain"',
            "sobDescription": '"Light Cruiser"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": 'getShipNum(NewShipType, "maxhealth", 18000)',
            "regentime": "490",
            "minRegenTime": "490",
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
            "maxBankingAmount": "20",
            "descendPitch": "20",
            "goalReachEpsilon": "30",
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
            "mass": "27500",
            "thrusterMaxSpeed": "120",
            "mainEngineMaxSpeed": "120",
            "rotationMaxSpeed": "20",
            "thrusterAccelTime": "8",
            "thrusterBrakeTime": "4",
            "mainEngineAccelTime": "8",
            "mainEngineBrakeTime": "4",
            "rotationAccelTime": "4",
            "rotationBrakeTime": "2",
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
            "BuildFamily": '"Cruiser_Shi"',
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
            {"name": "setSupplyValue", "args": ["Cruiser", "1.0"]},
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
            "buildCost": "600",
            "buildTime": "34",
            "buildPriorityOrder": "30",
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
    "Layout Boundary": {
        "variables": {},
        "functions": [
            {
                "name": "setTargetBox",
                "args": ["0", "-0.25", "0.05", "-0.95", "0.75", "0.55", "0.95"],
            },
            {
                "name": "setTargetBox",
                "args": ["1", "-0.35", "0.55", "-0.85", "0.7", "0.95", "-0.55"],
            },
            {
                "name": "setTargetBox",
                "args": ["2", "-0.9", "0.08", "-0.9", "0.85", "0.05", "0.1"],
            },
            {
                "name": "setTargetBox",
                "args": ["3", "-0.75", "-0.3", "0.1", "0.5", "-0.25", "0.70"],
            },
        ],
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
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "SRED",
                    "Weapon_Beam1",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "shi_cainsred",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                    "",
                ],
            }
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
            }
        ],
    },
    "Addendum": {
        "variables": {},
        "functions": [
            {
                "name": "loadShipPatchList",
                "args": ["data:sound/sfx/ship", "0", "", "", "1", "ShivanCruiser", ""],
            }
        ],
    },
    "Weapons": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_Gun1", "Fire1"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_Gun2", "Fire2"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_Gun3", "Fire3"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_Gun4", "Fire4"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivlaser_turret", "Weapon_Gun5", "Fire5"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AARed", "Weapon_Gun6", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_Gun7", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_Gun8", ""],
            },
        ],
    },
    "Latch Points": {
        "variables": {},
        "functions": [
            {
                "name": "loadLatchPointList",
                "args": ["CapCap", "CapturePoint1"],
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
