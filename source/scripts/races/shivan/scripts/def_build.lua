--Type => SubSystem
--ThingToBuild => name of subsystem to build
--RequiredResearch => global research dependencies
--RequiredShipSubSystems => subsystems dependencies for local to the ship
--RequiredFleetSubSystems => Fleet wide subsystem dependencies
--DisplayPriority => Order in UI lists
--DisplayedName => Localized name for UI
--Description => Description for UI


Ship = 0
SubSystem = 1

build =
{

	-------------------------------------------------------------------------------
	-- PRODUCTION MODULE SUBSYSTEMS



	-------------------------------------------------------------------------------
	-- ABILITY MODULES


	-------------------------------------------------------------------------------
	-- SENSOR MODULES


	-------------------------------------------------------------------------------
	-- SHIPS


	-- Fighters ---------------

	{
		Type = Ship,
		ThingToBuild = "shi_astaroth",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "SF Astaroth - Interceptor",
		Description =
		"<b>Description:</b> First encountered in Gamma Draconis, the SF Astaroth is a fast, agile fighter that appears to have achieved its maneuverability at the expense of its armor and weaponry. Once the shields of an Astaroth are down, the fighter can be dispatched quickly. \n\n<b>Prerequisites:</b> Fighter Design, Anti-Bomber Missiles. \n\n<b>Armaments:</b> 2x Anti-Bomber Laser, 1x Shivan Heatseeker, 1x Shivan EMP (Upgrade)",
	},

	-- Bombers --------------




	-- Frigates ---------------



	-- Capital Ships ----------

	{
		Type = Ship,
		ThingToBuild = "shi_demon",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "SD Demon - Destroyer",
		Description =
		"<b>Description:</b> The SD Demon class of Shivan destroyers is much smaller than the Lucifer class but very heavily armed and extremely dangerous. Demons are known to carry numerous wings of fighters and bombers. \n\n<b>Prerequisites:</b> Capital Ship Design, Heavy Photon Beams. \n\n<b>Armaments:</b> 2x Heavy Beam, 1x Medium Beam, 2x Anti-Fighter Beam, 4x Flak Turret, 10x Turret Laser, 2x Huge Turret, 5x Missile Launcher.",
	},


	-- Platforms --------------




	-- Utility ----------------



}
