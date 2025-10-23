RECON: list[str] = ["ter_loki", "shi_scorpion"]
STEALTH_RECON: list[str] = ["ter_pegasus", "vas_ptah"]
SUP_FIGHTER: list[str] = [
    "ter_apollo",
    "ter_ulysses",
    "vas_anubis",
    "vas_thoth",
    "shi_dragon",
    "ter_myrmidon",
    "shi_mara",
    "shi_gorgon"
]
INT_FIGHTER: list[str] = [
    "ter_perseus",
    "ter_valkyrie",
    "vas_serapis",
    "vas_horus",
    "shi_astaroth",
    "shi_manticore",
]
ASSAULT_FIGHTER: list[str] = [
    "ter_ares",
    "ter_erinyes",
    "ter_hercules",
    "ter_herculesmk2",
    "vas_seth",
    "vas_tauret",
    "shi_aeshma",
    "shi_basilisk",
]
LIGHT_BOMBER: list[str] = ["ter_athena", "shi_nahema", "shi_shaitan"]
MEDIUM_BOMBER: list[str] = [
    "ter_artemis",
    "ter_artemisdh",
    "ter_zeus",
    "vas_bakha",
    "vas_osiris",
    "shi_taurvi",
]
HEAVY_BOMBER: list[str] = ["ter_boanerges", "ter_medusa", "vas_amun", "vas_sehkmet"]
ASSAULT_BOMBER: list[str] = ["ter_ursa", "shi_nephilim", "shi_seraphim"]
CRUISER: list[str] = ["ter_fenris", "vas_aten", "shi_cain"]
HEAVY_CRUISER: list[str] = ["ter_leviathan", "shi_lilith"]
ADVANCED_CRUISER: list[str] = ["ter_aeolus", "vas_mentu", "shi_rakshasa"]
CORVETTE: list[str] = ["ter_deimos", "ter_iceni", "vas_sobek", "shi_moloch"]
DESTROYER: list[str] = [
    "ter_orion",
    "ter_hecate",
    "vas_hatshepsut",
    "vas_typhon",
    "shi_demon",
    "shi_ravana",
]
SUPER_DESTROYER: list[str] = ["ter_hades", "shi_lucifer"]
JUGGERNAUT: list[str] = ["ter_colossus", "vas_colossus", "shi_sathanas"]
PLATFORM: list[str] = [
    "ter_alastor",
    "ter_cerberus",
    "vas_edjo",
    "vas_ankh",
    "shi_belial",
    "shi_trident",
    "ter_mjolnir"
]
PROBE: list[str] = ["ter_pharos", "vas_geb"]
INSTALLATION: list[str] = ["ter_arcadia", "vas_karnak", "shi_commnode"]
RESOURCE_CONTROLLER: list[str] = [
    "ter_chronos",
    "ter_zephyrus",
    "vas_anuket",
    "vas_maat",
    "shi_rahu",
]
RESOURCE_COLLECTOR: list[str] = [
    "ter_elysium",
    "vas_isis",
    "shi_azrael",
]
DEPLOYER: list[str] = ["ter_poseidon", "vas_bast", "vas_bes", "shi_mephisto"]
REPAIR_FRIGATE: list[str] = ["ter_argo", "vas_satis", "shi_asmodeus"]
SUPPORT_SHIP: list[str] = [
    "ter_centaur",
    "ter_hygeia",
    "vas_scarab",
    "vas_nephthys",
]
AWACS: list[str] = ["ter_charybdis", "vas_setekh"]
RESEARCH: list[str] = ["ter_faustus", "vas_imhotep"]

TERRAN: str = "Ter"
SHIVAN: str = "Shi"
VASUDAN: str = "Vas"

SECTION_ASSIGNMENT = {
    # Ship info
    "displayedName": "Ship info",
    "sobDescription": "Ship info",
    "blobName": "Ship info",
    "blobNamePriority": "Ship info",
    # Main Ship Data
    "isTransferable": "Main Ship Data",
    "unavailableWhenCaptured": "Main Ship Data",
    "disableOnRaceChange": "Main Ship Data",
    # Families
    "MinimalFamilyToFindPathAround": "Families",
    "BuildFamily": "Families",
    "AttackFamily": "Families",
    "DockFamily": "Families",
    "AvoidanceFamily": "Families",
    "DisplayFamily": "Families",
    "AutoFormationFamily": "Families",
    "CollisionFamily": "Families",
    "ArmourFamily": "Families",
    "CombatFamily": "Families",
    # Supply
    "setSupplyValue": "Supply",
    # Construction
    "buildBatch": "Construction",
    "buildCost": "Construction",
    "buildTime": "Construction",
    "buildPriorityOrder": "Construction",
    "setConcurrentBuildLimit": "Construction",
    # Health and Armour
    "maxhealth": "Health and Armour",
    "regentime": "Health and Armour",
    "minRegenTime": "Health and Armour",
    "frontArmourDamage": "Health and Armour",
    "sideArmourDamage": "Health and Armour",
    "rearArmourDamage": "Health and Armour",
    # Shields
    "addShield": "Shields",
    # Sensors
    "retaliationRange": "Sensors",
    "retaliationDistanceFromGoal": "Sensors",
    "visualRange": "Sensors",
    "prmSensorRange": "Sensors",
    "secSensorRange": "Sensors",
    "detectionStrength": "Sensors",
    # Movement
    "mass": "Movement",
    "thrusterMaxSpeed": "Movement",
    "thrusterAccelTime": "Movement",
    "thrusterBrakeTime": "Movement",
    "mainEngineMaxSpeed": "Movement",
    "mainEngineAccelTime": "Movement",
    "mainEngineBrakeTime": "Movement",
    "rotationMaxSpeed": "Movement",
    "rotationAccelTime": "Movement",
    "rotationBrakeTime": "Movement",
    # Advanced Movement
    "controllerType": "Advanced Movement",
    "thrusterUsage": "Advanced Movement",
    "accelerationAngle": "Advanced Movement",
    "mirrorAngle": "Advanced Movement",
    "secondaryTurnAngle": "Advanced Movement",
    "maxBankingAmount": "Advanced Movement",
    "descendPitch": "Advanced Movement",
    "goalReachEpsilon": "Advanced Movement",
    "slideMoveRange": "Advanced Movement",
    "relativeMoveFactor": "Advanced Movement",
    "agileFlight": "Advanced Movement",
    "homingDistance": "Advanced Movement",
    "homingDelay": "Advanced Movement",
    "useEngagementRanges": "Advanced Movement",
    "setSpeedvsAccuracyApplied": "Advanced Movement",
    # Special Flight Maneuvers
    "mirrorAboveManeuver": "Special Flight Maneuvers",
    "mirrorBelowManeuver": "Special Flight Maneuvers",
    "specialTurnLeftManeuver": "Special Flight Maneuvers",
    "specialTurnRightManeuver": "Special Flight Maneuvers",
    # Swaying
    "swayUpdateTime": "Swaying",
    "swayOffsetRandomX": "Swaying",
    "swayOffsetRandomY": "Swaying",
    "swayOffsetRandomZ": "Swaying",
    "swayBobbingFactor": "Swaying",
    "swayRotateFactor": "Swaying",
    # Tactics And Multipliers
    "defaultStance": "Tactics And Multipliers",
    "defaultROE": "Tactics And Multipliers",
    "setTacticsMults": "Tactics And Multipliers",
    # Formations
    "paradeData": "Formations",
    "formationSpacing": "Formations",
    "batchFormation": "Formations",
    "canSurround": "Formations",
    "noCombatGrouping": "Formations",
    "canJoinStrikeGroup": "Formations",
    "strikeGroupRadius": "Formations",
    "strikeGroupSpeed": "Formations",
    "SquadronSize": "Formations",
    "unitCapsNumber": "Formations",
    # Launching
    "launchTimeBetweenTwoFormations": "Launching",
    "launchTimeBeforeStart": "Launching",
    "launchNrOfShipsInDockFormation": "Launching",
    "launchFormation": "Launching",
    # Docking
    "holdSlots": "Docking",
    "dockTimeBetweenTwoFormations": "Docking",
    "dockTimeBeforeStart": "Docking",
    "dockNrOfShipsInDockFormation": "Docking",
    "ignoreRaceWhenDocking": "Docking",
    "queueFormation": "Docking",
    "dockFormation": "Docking",
    "dontDockWithOtherRaceShips": "Docking",
    # Ship Counter Rating
    "AttackPriorityMultiplier": "Ship Counter Rating",
    "fighterValue": "Ship Counter Rating",
    "corvetteValue": "Ship Counter Rating",
    "frigateValue": "Ship Counter Rating",
    "neutralValue": "Ship Counter Rating",
    "antiFighterValue": "Ship Counter Rating",
    "antiCorvetteValue": "Ship Counter Rating",
    "antiFrigateValue": "Ship Counter Rating",
    "totalValue": "Ship Counter Rating",
    # Damage & Death
    "dustCloudDamageTime": "Damage & Death",
    "nebulaDamageTime": "Damage & Death",
    "collisionMultiplier": "Damage & Death",
    "normalCollisionDamageMultiplier": "Damage & Death",
    "battleScarCoverage": "Damage & Death",
    "battleScarBudgetLow": "Damage & Death",
    "battleScarBudgetNext": "Damage & Death",
    "sobDieTime": "Damage & Death",
    "sobSpecialDieTime": "Damage & Death",
    "specialDeathSpeed": "Damage & Death",
    "chanceOfSpecialDeath": "Damage & Death",
    "deadSobFadeTime": "Damage & Death",
    "setSpecialDieTime": "Damage & Death",
    # Scuttle
    "allowScuttle": "Scuttle",
    "minFalloffDamageDist": "Scuttle",
    "maxFalloffDamageDist": "Scuttle",
    "maxFalloffScuttleDamageDist": "Scuttle",
    "explosiveScuttleDamageOnDeath": "Scuttle",
    "maxFalloffForce": "Scuttle",
    "explosiveDamageOnDeath": "Scuttle",
    "radiusDamageEvadeMod": "Scuttle",
    # Death Tumble
    "tumbleStaticX": "Death Tumble",
    "tumbleStaticY": "Death Tumble",
    "tumbleStaticZ": "Death Tumble",
    "tumbleDynamicX": "Death Tumble",
    "tumbleDynamicY": "Death Tumble",
    "tumbleDynamicZ": "Death Tumble",
    "tumbleSpecialDynamicX": "Death Tumble",
    "tumbleSpecialDynamicY": "Death Tumble",
    "tumbleSpecialDynamicZ": "Death Tumble",
    # Debris
    "SpawnSalvageOnDeath": "Debris",
    # Layout Boundary
    "useLayoutBounds": "Layout Boundary",
    "layoutBoundX": "Layout Boundary",
    "layoutBoundY": "Layout Boundary",
    "layoutBoundZ": "Layout Boundary",
    "layoutCenterX": "Layout Boundary",
    "layoutCenterY": "Layout Boundary",
    "layoutCenterZ": "Layout Boundary",
    # Selection
    "militaryUnit": "Selection",
    "selectionLimit": "Selection",
    "preciseSelectionLimit": "Selection",
    "preciseATILimit": "Selection",
    "selectionPriority": "Selection",
    # Tactical Overlay Icon
    "canblink": "Tactical Overlay Icon",
    "TOIcon": "Tactical Overlay Icon",
    "TOScale": "Tactical Overlay Icon",
    "TODistanceFade0": "Tactical Overlay Icon",
    "TODistanceDisappear0": "Tactical Overlay Icon",
    "TODistanceFade1": "Tactical Overlay Icon",
    "TODistanceDisappear1": "Tactical Overlay Icon",
    "TODistanceFade2": "Tactical Overlay Icon",
    "TODistanceDisappear2": "Tactical Overlay Icon",
    "TOGroupScale": "Tactical Overlay Icon",
    "TOGroupMergeSize": "Tactical Overlay Icon",
    # Overlays
    "mouseOverMinFadeSize": "Overlays",
    "mouseOverMaxFadeSize": "Overlays",
    "healthBarStyle": "Overlays",
    "SMRepresentation": "Overlays",
    "pixelSize": "Overlays",
    "pixelColour": "Overlays",
    "SMFadeDistance": "Overlays",
    "SMFadeMinAlpha": "Overlays",
    "SMPixelSize": "Overlays",
    "SMHighlightDistMin": "Overlays",
    "SMHighlightDistMax": "Overlays",
    "hideNormalAttackUICooldown": "Overlays",
    "canBlink": "Overlays",
    "shipHoldActive": "Overlays",
    # Rendering
    "AlwaysInRenderList": "Rendering",
    "meshRenderLimit": "Rendering",
    "dotRenderLimit": "Rendering",
    "visibleInSecondary": "Rendering",
    "goblinsStartFade": "Rendering",
    "goblinsOff": "Rendering",
    "minimumZoomFactor": "Rendering",
    "shadowType": "Rendering",
    # Non linear Scaling
    "nlips": "Non linear Scaling",
    "nlipsRange": "Non linear Scaling",
    "nlipsFar": "Non linear Scaling",
    "nlipsFarRange": "Non linear Scaling",
    # Level of Detail
    "minLOD": "Level of Detail",
    "upLOD": "Level of Detail",
    "downLOD": "Level of Detail",
    # Alternative Hyperspace Gate
    "alternativeHyperspaceV": "Alternative Hyperspace Gate",
    "alternativeHyperspaceA": "Alternative Hyperspace Gate",
    "alternativeHyperspaceTime": "Alternative Hyperspace Gate",
    # Abilities
    "addAbility": "Abilities",
    # Load Model
    "LoadModel": "Load Model",
    "LoadSharedModel": "Load Model",
    # Weapons
    "StartShipWeaponConfig": "Weapons",
    # HardPoints
    "canRetireSubSystems": "HardPoints",
    "StartShipHardPointConfig": "HardPoints",
    # Latch Points
    "loadLatchPointList": "Latch Points",
    # Addendum
    "loadShipPatchList": "Addendum",
    # Shaders
    "addShaderProp": "Shaders",
    "setShaderChannels": "Shaders",
    # Engines
    "trailLinger": "Engines",
    "setEngineBurn": "Engines",
    "setEngineGlow": "Engines",
    "setEngineTrail": "Engines",
    # Custom Code
    "addCustomCode": "Custom Code",
    # Deprecated
    "unitCapsNumber": "Deprecated",
    "passiveFormation": "Deprecated",
    "aggressiveFormation": "Deprecated",
    "defensiveFormation": "Deprecated",
    "testManeuver1": "Deprecated",
    "testManeuver2": "Deprecated",
    "testManeuver3": "Deprecated",
    "UnitCapsFamily": "Deprecated",
    "UnitCapsShipType": "Deprecated",
    "density": "Deprecated",
    "useTargetRandom": "Deprecated",
    "targetRandomPointXMin": "Deprecated",
    "targetRandomPointXMax": "Deprecated",
    "targetRandomPointYMin": "Deprecated",
    "targetRandomPointYMax": "Deprecated",
    "targetRandomPointZMin": "Deprecated",
    "targetRandomPointZMax": "Deprecated",
    "addedUnitCaps": "Deprecated",
    "battleScarMaxTriBase": "Deprecated",
    "battleScarMaxTriInc": "Deprecated",
}
