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
		ThingToBuild = "hol_seth",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "PVF Seth - Assault <c=12AB06>36s</c>",
		Description =
		"<b>Description:</b> As the slowest fighter in the PVN, the Seth has earned itself a reputation as the Turtle of the Vasudan fleet. Even though it is quite compact in size, the Seth can carry a massive payload, and has a lot of shielding. Its standard impulse engines aren't very powerful, but the Seth gains an incredible speed boost when using its afterburners. The Seth is primarily used is convoy attacks and capital ship escort duties. \n\n<b>Prerequisites:</b> Fighter Design, Multi-Role Swarm Missiles. \n\n<b>Armaments:</b> 4x GVW-5 Prometheus, 1x PVM-MX50, 2x PVM-4 Hornet.",
	},

	{
		Type = Ship,
		ThingToBuild = "hol_thoth",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "PVF Thoth - Adv. Space Superiority <c=12AB06>39s</c>",
		Description =
		"<b>Description:</b> The Thoth is the most dangerous ship to be created by the PVN. When the Altairian Yards defected to the Hammer of Light rebels, the production of Thoths by the PVN dropped to nil. What makes the Thoth so versatile is its small size, extremely high maneuverability, and advanced weapon systems. It is extremely difficult to hit, in the hands of a skilled pilot. The design for the Thoth was simultaneous with the design for the Ulysses, and these two ships were designed by some of the same technicians. \n\n<b>Prerequisites:</b> Fighter Design, Anti-Fighter Missiles. \n\n<b>Armaments:</b> 4x PVW-15 Avenger (Rapid Fire), 2x PVM-9 Interceptor.",
	},


	-- Bombers --------------




	-- Cruisers ---------------




	-- Capital Ships ----------

	{
		Type = Ship,
		ThingToBuild = "vas_typhon",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "GVD Typhon - Destroyer <c=12AB06>175s</c>",
		Description =
		"<b>Description:</b> The GVD Typhon was the height of Vasudan military technology when it appeared to face Terran forces during the early days of the Terran-Vasudan War. The first Typhon was sighted at the Vega Engagement and quickly destroyed the GTD Eisenhower and much of the 4th fleet. The more recent Hatshepsut class of destroyers is larger and wields a deadlier array of armaments, but the Typhon is still a match for almost any foe. Up to 30 wings of fighters or bombers can be housed within its docking bays, ready to engage at a moment's notice. \n\n<b>Prerequisites:</b> Capital Ship Design, Medium Photon Beams. \n\n<b>Armaments:</b> 2x Heavy Beam, 2x Anti-Fighter Beam, 5x Flak Turret, 4x Harpoon Missile Launcher, 5x Huge Turret, 9x Turret.",
	},



	-- Platforms --------------




	-- Utility ----------------




}
