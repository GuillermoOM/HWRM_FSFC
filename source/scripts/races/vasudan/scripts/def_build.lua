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

build = {

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
		ThingToBuild = "vas_seth",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "PVF Seth - Assault <c=12AB06>36s</c>",
		Description = "<b>Description:</b> As the slowest fighter in the PVN, the Seth has earned itself a reputation as the Turtle of the Vasudan fleet. Even though it is quite compact in size, the Seth can carry a massive payload, and has a lot of shielding. Its standard impulse engines aren't very powerful, but the Seth gains an incredible speed boost when using its afterburners. The Seth is primarily used is convoy attacks and capital ship escort duties. \n\n<b>Prerequisites:</b> Fighter Design, Multi-Role Swarm Missiles. \n\n<b>Armaments:</b> 4x GVW-5 Prometheus, 1x PVM-MX50, 2x PVM-4 Hornet.",
	},

	{
		Type = Ship,
		ThingToBuild = "vas_thoth",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "PVF Thoth - Adv. Space Superiority <c=12AB06>39s</c>",
		Description = "<b>Description:</b> The Thoth is the most dangerous ship to be created by the PVN. When the Altairian Yards defected to the Hammer of Light rebels, the production of Thoths by the PVN dropped to nil. What makes the Thoth so versatile is its small size, extremely high maneuverability, and advanced weapon systems. It is extremely difficult to hit, in the hands of a skilled pilot. The design for the Thoth was simultaneous with the design for the Ulysses, and these two ships were designed by some of the same technicians. \n\n<b>Prerequisites:</b> Fighter Design, Anti-Fighter Missiles. \n\n<b>Armaments:</b> 4x PVW-15 Avenger (Rapid Fire), 2x PVM-9 Interceptor.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_horus",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 3,
		DisplayedName = "GVF Horus - Interceptor <c=12AB06>32s</c>",
		Description = "<b>Description:</b> The GVF Horus was the fastest fighter class during the Great War and it's still the fastest fighter in the GTVA fleet. Its weapon capacity is average for a fighter, with four primary banks and two missile bays. The Horus pays for its speed and maneuverability with thin armor and relatively weak shields. The Horus shines as a bomber interceptor, a role Allied Command puts it in as often as possible. For offensive operations against well-defended targets, however, the Horus is a poor choice. \n\n<b>Prerequisites:</b> Fighter Design, Anti-Bomber Missiles. \n\n<b>Armaments:</b> 2x Prometheus S, 2x GTW ML-70 Morning Star, 1x GTM-55 Trebuchet, 1x GTM-MX64 Rockeye.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_tauret",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 4,
		DisplayedName = "GVF Tauret - Heavy Assault <c=12AB06>49s</c>",
		Description = "<b>Description:</b> While integrating cutting-edge technology developed in collaboration with the Terrans, the Tauret boasts a distinctly Vasudan design. Its unusual configuration was inspired by the Apsu-Hek, a creature that once inhabited the deserts of Vasuda Prime. The Apsu-Hek has become an emblem of the Vasudan diaspora, and the Tauret continues the tradition of symbolic design. Armed with six gun mounts and two large missile banks, the Tauret has the speed and firepower to challenge both fighters and warships. \n\n<b>Prerequisites:</b> Fighter Design, Tornado Missiles or Anti-Fighter Missiles. \n\n<b>Armaments:</b> 4x GTW-5 Prometheus S, 2x UD-8 Kayser, 2x GTM-MX64 Rockeye, 2x GTM-4a Tornado",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_ptah",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 5,
		DisplayedName = "GVF Ptah - Stealth Recon <c=12AB06>65s</c>",
		Description = "<b>Description:</b> The stealth prototype GVF Ptah was a top-secret development project assigned to Vasudan conglomerate Akheton Corp. Designed to be invisible to standard detection arrays mounted on combat craft, Ptahs have performed admirably during their OpEval period. The masking materials and blending technologies used across their outer surfaces seem to confuse Shivan detection systems as well. The Ptah is currently available only to select fighter units in the Vasudan navy, with no word on when they will be more widely distributed. \n\n<b>Prerequisites:</b> Fighter Design, Stealth Technology. \n\n<b>Armaments:</b> 2x Mekhu HL-7 (Rapid Fire), 1x GTM-19 Harpoon, 1x GTM 43a Stiletto II (Upgrade)",
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
		Description = "<b>Description:</b> The GVD Typhon was the height of Vasudan military technology when it appeared to face Terran forces during the early days of the Terran-Vasudan War. The first Typhon was sighted at the Vega Engagement and quickly destroyed the GTD Eisenhower and much of the 4th fleet. The more recent Hatshepsut class of destroyers is larger and wields a deadlier array of armaments, but the Typhon is still a match for almost any foe. Up to 30 wings of fighters or bombers can be housed within its docking bays, ready to engage at a moment's notice. \n\n<b>Prerequisites:</b> Capital Ship Design, Medium Photon Beams. \n\n<b>Armaments:</b> 2x Heavy Beam, 2x Anti-Fighter Beam, 5x Flak Turret, 4x Harpoon Missile Launcher, 5x Huge Turret, 9x Turret.",
	},

	-- Platforms --------------

	-- Utility ----------------
}
