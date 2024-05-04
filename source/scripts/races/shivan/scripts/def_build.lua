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
	{
		Type = Ship,
		ThingToBuild = "shi_manticore",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "SF Manticore - Interceptor <c=12AB06>31s</c>",
		Description =
		"<b>Description:</b> The Manticore fighter is the fastest known craft in the Shivan armada. With a single, powerful laser and two missile banks, it is a dangerous offensive weapon. Its Achilles' heel lies in its thin hull and weak shields. Manticores do not last long in dogfights against other fighters. They prefer to target bombers, which are nearly helpless against the Manticore's speed and weaponry. \n\n<b>Prerequisites:</b> Fighter Design, Anti-Fighter Missiles. \n\n<b>Armaments:</b> 2x Anti-Bomber Laser, 1x Anti-Bomber Missile, 1x Anti-Fighter missile.",
	},


	-- Bombers --------------

	{
		Type = Ship,
		ThingToBuild = "shi_nephilim",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "SB Nephilim - Heavy Bomber <c=12AB06>44s</c>",
		Description =
		"<b>Description:</b> The SB Nephilim is the slowest of the Shivan bomber classes. These craft were first encountered during the Great War and are still found in many Shivan attack formations. Nephilims are heavily armored and shielded, enabling them to deliver their devastating payloads despite their lack of speed. \n\n<b>Prerequisites:</b> Bomber Design, Anti-Cruiser Bombs. \n\n<b>Armaments:</b> 2x Anti-Bomber Laser, 2x Anti-Bomber Turret, 2x Shivan Bomb Launcher, 1x Shivan Cluster Bomb (Upgrade).",
	},


	-- Cruisers ---------------
	{
		Type = Ship,
		ThingToBuild = "shi_cain",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "SC Cain - Strike Cruiser <c=12AB06>34s</c>",
		Description =
		"<b>Description:</b> The weakest of the Shivan cruiser classes is designated SC Cain. These vessels were commonly encountered during Great War battles. Cains are considered to be slightly stronger than the GTC Fenris cruiser class. \n\n<b>Prerequisites:</b> Cruiser Design, Light Photon Beams. \n\n<b>Armaments:</b> 1x Light Beam, 1x Anti-Fighter Beam, 5x Turret Laser, 2x Missile Launcher.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_lilith",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "SC Lilith - Heavy Cruiser <c=12AB06>140s</c>",
		Description =
		"<b>Description:</b> The SC Lilith class of Shivan cruisers is a far-deadlier foe than the Cain class. Nearly impenetrable armor plating enables it to withstand tremendous punishment, enabling its nine turrets to lash out at warships and combat spacecraft with impunity. \n\n<b>Prerequisites:</b> Cruiser Design, Heavy Photon Beams. \n\n<b>Armaments:</b> 1x Heavy Beam, 1x Anti-Fighter Beam, 5x Turret Laser, 2x Shivan Cluster Missile Launcher.",
	},

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

	{
		Type = Ship,
		ThingToBuild = "shi_azrael",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "ST Azrael - Collector <c=12AB06>25s</c>",
		Description =
		"<b>Description:</b> Encountered on rare occasions since the Shivans first entered the Great War, the ST Azrael is the only known class of Shivan transport. Little is known about it even now, but it is believed to house many Shivans within its thin hulls. Since Azraels might be carrying Shivan pilots or other skilled crew members, it is always worthwhile to eliminate these lightly defended ships. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> 3x Light Turret.",
	},


}
