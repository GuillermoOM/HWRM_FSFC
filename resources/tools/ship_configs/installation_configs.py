TER_ARCADIA = {
    "Ship info": {
        "variables": {
            "displayedName": '"GTI Arcadia"',
            "sobDescription": '"Installation"',
            "blobName": '"GTI Arcadia"',
            "blobNamePriority": "75",
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "200000",
            "regentime": "1465",
            "minRegenTime": "1465",
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
    "Formations": {
        "variables": {
            "paradeData": '"terran_parade"',
            "canJoinStrikeGroup": "0",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "10000000",
            "thrusterMaxSpeed": "0",
            "mainEngineMaxSpeed": "0",
            "rotationMaxSpeed": "5",
            "thrusterAccelTime": "1",
            "thrusterBrakeTime": "1",
            "mainEngineAccelTime": "1",
            "mainEngineBrakeTime": "1",
            "rotationAccelTime": "10",
            "rotationBrakeTime": "5",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "0",
            "nebulaDamageTime": "0",
            "battleScarCoverage": "4",
            "battleScarBudgetLow": "1200",
            "battleScarBudgetNext": "1800",
            "sobDieTime": "8",
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
            "accelerationAngle": "60",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "10",
            "descendPitch": "40",
            "goalReachEpsilon": "50",
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
            "swayUpdateTime": "2",
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
        "functions": [{"name": "setSupplyValue", "args": ["Installation", "1.0"]}],
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
            "buildCost": "6000",
            "buildTime": "100",
            "buildPriorityOrder": "40",
        },
        "functions": [{"name": "setConcurrentBuildLimit", "args": ["0", "2"]}],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "7000",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "2050",
            "prmSensorRange": "10000",
            "secSensorRange": "18000",
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
            "SMHighlightDistMin": "400000",
            "SMHighlightDistMax": "500000",
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
            "meshRenderLimit": "5000000000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "15000",
            "goblinsOff": "30000",
            "minimumZoomFactor": "0.5",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"upLOD": "50000", "downLOD": "50015"},
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
                    "100",
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
            {"name": "addAbility", "args": ["CanBeCaptured", "300", "0.1", 'CapCap"']},
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
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_01", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_02", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_03", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_04", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_05", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_06", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_07", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_08", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_09", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_10", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_11", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_12", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_13", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_14", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_15", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_16", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_17", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_18", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_19", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_20", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_21", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_22", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_23", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_terlaser_turret", "Weapon_24", ""],
            },
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "10000", "100"]}],
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
                "args": ["CapCap", "CapturePoint1", "CapturePoint2"],
            },
            {
                "name": "loadLatchPointList",
                "args": ["RepCap", "RepairPoint1", "RepairPoint2"],
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
VAS_KARNAK = {
    "Ship info": {
        "variables": {
            "displayedName": '"PVI Karnak"',
            "sobDescription": '"Installation"',
            "blobName": '"PVI Karnak"',
            "blobNamePriority": "75",
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "400000",
            "regentime": "1788",
            "minRegenTime": "1788",
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
    "Formations": {
        "variables": {
            "paradeData": '"vas_mothership_parade"',
            "canJoinStrikeGroup": "0",
        },
        "functions": [],
    },
    "Movement": {
        "variables": {
            "mass": "10000000",
            "thrusterMaxSpeed": "0",
            "mainEngineMaxSpeed": "0",
            "rotationMaxSpeed": "5",
            "thrusterAccelTime": "1",
            "thrusterBrakeTime": "1",
            "mainEngineAccelTime": "1",
            "mainEngineBrakeTime": "1",
            "rotationAccelTime": "10",
            "rotationBrakeTime": "5",
        },
        "functions": [],
    },
    "Damage & Death": {
        "variables": {
            "collisionMultiplier": "1",
            "dustCloudDamageTime": "0",
            "nebulaDamageTime": "0",
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
            "accelerationAngle": "60",
            "mirrorAngle": "0",
            "secondaryTurnAngle": "0",
            "maxBankingAmount": "10",
            "descendPitch": "40",
            "goalReachEpsilon": "50",
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
            "swayUpdateTime": "2",
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
            "BuildFamily": '"Shipyard_Vas"',
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
        "functions": [{"name": "setSupplyValue", "args": ["Installation", "1.0"]}],
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
            "buildCost": "10000",
            "buildTime": "200",
            "buildPriorityOrder": "40",
        },
        "functions": [{"name": "setConcurrentBuildLimit", "args": ["0", "2"]}],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "7000",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "2050",
            "prmSensorRange": "10000",
            "secSensorRange": "18000",
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
            "SMHighlightDistMin": "400000",
            "SMHighlightDistMax": "500000",
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
            "meshRenderLimit": "5000000000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "15000",
            "goblinsOff": "30000",
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
                    "100",
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
                    "Fighter_vas, Bomber_vas, Cruiser_vas, SuperCap_vas, Utility_vas, Platform_vas, Battlecruiser_vas, Shipyard_vas, Probe_vas",
                    "Utility, Fighter, Bomber, Cruiser, Capital, Platform",
                ],
            },
            {"name": "addAbility", "args": ["CanBeCaptured", "300", "0.1", 'CapCap"']},
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
        "functions": [
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret01", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret02", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret03", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret04", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret05", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret06", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret07", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret08", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret09", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret10", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret11", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret12", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret13", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret14", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret15", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret16", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret17", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret18", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret19", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret20", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret21", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret22", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret23", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret24", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret25", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret26", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret27", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret28", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret29", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret30", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret31", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret32", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret33", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret34", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret35", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["miss_fighterkiller", "Weapon_turret36", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret37", ""],
            },
            {
                "name": "StartShipWeaponConfig",
                "args": ["gun_vaslaser_gimble", "Weapon_turret38", ""],
            },
        ],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "10000", "100"]}],
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
                "args": ["CapCap", "CapturePoint1", "CapturePoint2"],
            },
            {
                "name": "loadLatchPointList",
                "args": ["RepCap", "RepairPoint1", "RepairPoint2"],
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
SHI_COMMNODE = {
    "Ship info": {
        "variables": {
            "displayedName": '"Shivan Comm Node"',
            "sobDescription": '"Communications Node"',
            "blobName": '"Shivan Comm Node"',
            "blobNamePriority": "75",
        },
        "functions": [],
    },
    "Health and Armour": {
        "variables": {
            "maxhealth": "40000",
            "regentime": "450",
            "minRegenTime": "350",
            "sideArmourDamage": 'getShipNum(NewShipType, "sideArmourDamage", 1.0)',
            "rearArmourDamage": 'getShipNum(NewShipType, "rearArmourDamage", 1.0)',
        },
        "functions": [],
    },
    "Main Ship Data": {"variables": {"isTransferable": "0"}, "functions": []},
    "Movement": {
        "variables": {
            "mass": "115000",
            "thrusterMaxSpeed": "0",
            "mainEngineMaxSpeed": "0",
            "rotationMaxSpeed": "5",
            "thrusterAccelTime": "8",
            "thrusterBrakeTime": "4",
            "mainEngineAccelTime": "8",
            "mainEngineBrakeTime": "4",
            "rotationAccelTime": "0.4",
            "rotationBrakeTime": "0.2",
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
            "sobDieTime": "8",
            "sobSpecialDieTime": "1",
            "specialDeathSpeed": "40",
            "chanceOfSpecialDeath": "0",
            "deadSobFadeTime": "0",
        },
        "functions": [],
    },
    "Advanced Movement": {
        "variables": {
            "thrusterUsage": "0.25",
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
            "BuildFamily": '"Utility_Shi"',
            "AttackFamily": '"BigCapitalShip"',
            "DockFamily": '"Shipyard"',
            "AvoidanceFamily": '"MotherShip"',
            "DisplayFamily": '"Platform"',
            "AutoFormationFamily": '"SuperCap"',
            "CollisionFamily": '"Big"',
            "ArmourFamily": 'getShipStr(NewShipType, "ArmourFamily", "HeavyArmour")',
        },
        "functions": [],
    },
    "Supply": {
        "variables": {},
        "functions": [
            {"name": "setSupplyValue", "args": ["Utility", "1.0"]},
            {"name": "setSupplyValue", "args": ["AWACS", "1.0"]},
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
            "buildCost": "1000",
            "buildTime": "70",
            "buildPriorityOrder": "30",
        },
        "functions": [],
    },
    "Sensors": {
        "variables": {
            "retaliationRange": "5500",
            "retaliationDistanceFromGoal": "160",
            "visualRange": "5000",
            "prmSensorRange": "15000",
            "secSensorRange": "30000",
            "detectionStrength": "4",
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
            "healthBarStyle": "1",
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
            "AlwaysInRenderList": "1",
            "meshRenderLimit": "130000000",
            "dotRenderLimit": "10",
            "visibleInSecondary": "1",
            "goblinsStartFade": "1500",
            "goblinsOff": "1500",
            "minimumZoomFactor": "0.6",
        },
        "functions": [],
    },
    "Level of Detail": {
        "variables": {"minLOD": "0.25", "upLOD": "5500", "downLOD": "5515"},
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
            "alternativeHyperspaceV": "subspace_gate_small",
            "alternativeHyperspaceA": "etg/misc/small_subspace",
            "alternativeHyperspaceTime": "7",
        },
        "functions": [],
    },
    "Abilities": {
        "variables": {},
        "functions": [
            {"name": "addAbility", "args": ['SensorPing"', '1', '0', '15', '4']},
        ],
    },
    "Load Model": {
        "variables": {},
        "functions": [{"name": "LoadModel", "args": ["1"]}],
    },
    "Shields": {
        "variables": {},
        "functions": [{"name": "addShield", "args": ["EMP", "310", "17"]}],
    },
    "HardPoints": {
        "variables": {"canRetireSubSystems": "1"},
        "functions": [
            {
                "name": "StartShipHardPointConfig",
                "args": [
                    "AWACS0",
                    "HardpointAWACS",
                    "System",
                    "Generic",
                    "Indestructible",
                    "awacs_0",
                    "",
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
                    "AWACS1",
                    "HardpointAWACS2",
                    "System",
                    "Generic",
                    "Indestructible",
                    "awacs_1",
                    "",
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
                    "AWACS2",
                    "HardpointAWACS3",
                    "System",
                    "Generic",
                    "Indestructible",
                    "awacs_2",
                    "",
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
                    "ShivanCommNode",
                    "",
                    "3",
                    "",
                    'Root"',
                ],
            }
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
