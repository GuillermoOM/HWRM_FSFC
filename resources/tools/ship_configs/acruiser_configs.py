TER_AEOLUS = {
    "Ship info": {
        "variables": {
            "displayedName": '"GTC Aeolus"',
            "sobDescription": '"AdvancedCruiser"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": 'getShipNum(NewShipType, "maxhealth", 18000)',
            "regentime": "550",
            "minRegenTime": "550",
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
            "thrusterMaxSpeed": "140",
            "mainEngineMaxSpeed": "140",
            "rotationMaxSpeed": "15",
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
            {"name": "setSupplyValue", "args": ["AdvancedCruiser", "1.0"]},
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
            "buildCost": "1050",
            "buildTime": "47",
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
                    "Sgreen1",
                    "Weapon_Beam1",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_aeolusbeam2",
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
                    "Sgreen2",
                    "Weapon_Beam2",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "ter_aeolusbeam1",
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
                "args": ["beam_AABlue", "Weapon_Gun1", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_Flak_Gimble", "Weapon_Gun2", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AABlue", "Weapon_Gun3", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_Flak_Gimble", "Weapon_Gun4", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_TurretLaser1", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_TurretLaser2", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terhuge_turret2", "Weapon_TurretLaser3", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_TurretLaser4", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_FlakTurret1", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_FlakTurret2", ""],
            },
        ],
    },
    "Latch Points": {
        "variables": {},
        "functions": [
            {
                "name": "loadLatchPointList",
                "args": ["CapCap", "CapturePoint0", "CapturePoint1"],
            },
            {
                "name": "loadLatchPointList",
                "args": ["RepCap", "RepairPoint0", "RepairPoint1"],
            },
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
SHI_RAKSHASA = {
    "Ship info": {
        "variables": {
            "displayedName": '"SC Rakshasa"',
            "sobDescription": '"AdvancedCruiser"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": 'getShipNum(NewShipType, "maxhealth", 18000)',
            "regentime": "565",
            "minRegenTime": "565",
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
            "thrusterMaxSpeed": "80",
            "mainEngineMaxSpeed": "80",
            "rotationMaxSpeed": "15",
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
            {"name": "setSupplyValue", "args": ["AdvancedCruiser", "1.0"]},
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
            "buildCost": "1250",
            "buildTime": "60",
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
                    "SRED1",
                    "Weapon_Beam1",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "shi_rakshasabeam1",
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
                    "SRED2",
                    "Weapon_Beam2",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "shi_rakshasabeam2",
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
                    "SRED3",
                    "Weapon_Beam3",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "shi_rakshasabeam3",
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
                "args": ["data:sound/sfx/ship", "0", "", "", "1", "ShivanCruiser", ""],
            }
        ],
    },
    "Weapons": {
        "variables": {},
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivsuperlaser_turret", "Weapon_Gun1", "Weapon_Gun1"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivsuperlaser_turret", "Weapon_Gun2", "Weapon_Gun2"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivsuperlaser_turret", "Weapon_Gun3", "Weapon_Gun3"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivsuperlaser_turret", "Weapon_Gun4", "Weapon_Gun4"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivsuperlaser_turret", "Weapon_Gun5", "Weapon_Gun5"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["beam_AARed", "Weapon_Gun6", "Weapon_Gun6"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivsuperlaser_turret", "Weapon_Gun7", "Weapon_Gun7"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivheavylaser_turret", "Weapon_Gun8", "Weapon_Gun8"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivheavylaser_turret", "Weapon_Gun9", "Weapon_Gun9"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivsuperlaser_turret", "Weapon_Gun10", "Weapon_Gun10"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_shivsuperlaser_turret", "Weapon_Gun11", "Weapon_Gun11"],
            },
        ],
    },
    "Latch Points": {
        "variables": {},
        "functions": [
            {"name": "loadLatchPointList", "args": ["CapCap", "CapturePoint0"]},
            {"name": "loadLatchPointList", "args": ["RepCap", "RepairPoint0"]},
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
VAS_MENTU = {
    "Ship info": {
        "variables": {
            "displayedName": '"GVC Mentu"',
            "sobDescription": '"AdvancedCruiser"',
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": 'getShipNum(NewShipType, "maxhealth", 18000)',
            "regentime": "600",
            "minRegenTime": "600",
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
            "accelerationAngle": "70",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "50",
            "descendPitch": "50",
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
            "thrusterMaxSpeed": "140",
            "mainEngineMaxSpeed": "140",
            "rotationMaxSpeed": "12",
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
            {"name": "setSupplyValue", "args": ["AdvancedCruiser", "1.0"]},
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
            "buildCost": "1475",
            "buildTime": "70",
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
                    "Svas1",
                    "Weapon_B1",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "vas_mentubeam",
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
                    "Svas2",
                    "Weapon_B2",
                    "Weapon",
                    "Innate",
                    "Damageable",
                    "vas_mentubeam",
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
                "args": ["gun_vaslaser_gimble", "Weapon_Laser1", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_Laser2", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_Laser3", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_Laser4", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_Laser5", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_Laser6", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_Laser7", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_Laser8", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_flak_turret", "Weapon_Flak1", ""],
            },
            {"name": "StartShipWeaponConfig", "args": ["beam_AABlue", "Weapon_AFB1", ""]},
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vashuge_turret", "Weapon_HugeLaser1", "Fire1"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vashuge_turret", "Weapon_HugeLaser2", "Fire2"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_turret", "Weapon_HugeLaser3", "Fire3"],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_turret", "Weapon_HugeLaser4", "Fire4"],
            },
        ],
    },
    "Latch Points": {
        "variables": {},
        "functions": [
            {"name": "loadLatchPointList", "args": ["CapCap", "CapturePoint0", "CapturePoint1"]},
            {"name": "loadLatchPointList", "args": ["RepCap", "RepairPoint0", "RepairPoint1"]},
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
