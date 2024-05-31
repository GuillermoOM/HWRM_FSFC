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
	{
		Type = Ship,
		ThingToBuild = "shi_dragon",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 3,
		DisplayedName = "SF Dragon - Interceptor <c=12AB06>39s</c>",
		Description =
		"<b>Description:</b> The Shivan fighter class SF Dragon is a fast, extremely agile craft. Its five lasers pack a deadly punch. The Dragon's weakness seems to be a thin hull. The trouble is that their speed and maneuverability make them extremely difficult to hit. \n\n<b>Prerequisites:</b> Fighter Design, Anti-Fighter Missiles. \n\n<b>Armaments:</b> 5x Anti-Fighter Laser, 1x Anti-Fighter Missile.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_basilisk",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 4,
		DisplayedName = "SF Basilisk - Strike Fighter <c=12AB06>37s</c>",
		Description =
		"<b>Description:</b> The SF Basilisk is a Shivan heavy attack fighter. Slow but heavily armed and well-protected, the Basilisk targets slower-moving vessels, such as bombers, freighters, and gas miners. Their powerful lasers make them a danger to all such craft, so they must be engaged and destroyed as quickly as possible. \n\n<b>Prerequisites:</b> Fighter Design, Multi-Role Missiles. \n\n<b>Armaments:</b> 4x Anti-Cruiser Laser, 2x Swarm Missile, 2x Shivan Rockets.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_mara",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 5,
		DisplayedName = "SF Mara - Space Superiority <c=12AB06>47s</c>",
		Description =
		"<b>Description:</b> The SF Mara class of Shivan fighters was first encountered by the GTC Vigilant while patrolling the Gamma Draconis jump node in the Capella system. All other information concerning the Mara is classified level Psi. \n\n<b>Prerequisites:</b> Fighter Design, Anti-Fighter Missiles. \n\n<b>Armaments:</b> 4x Anti-Fighter Laser, 2x Anti-Fighter missile, 2x Shivan Heatseekers.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_scorpion",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 6,
		DisplayedName = "SF Scorpion - Recon <c=12AB06>28s</c>",
		Description =
		"<b>Description:</b> We originally thought the Scorpion was the Shivans' best fighter.  However, we now believe that the Scorpion is nothing more than a Shivan scout ship.  Their vast numbers and seeming unimportance to the Shivan war effort leads us to this belief.  Regardless of its purpose, the Scorpion is highly maneuverable, fast, and difficult to destroy.  It can also do damage equivalent to our space superiority fighters. \n\n<b>Prerequisites:</b> Fighter Design. \n\n<b>Armaments:</b> 4x Shivan Medium Laser, 1x Shivan Heatseeker.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_aeshma",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 7,
		DisplayedName = "SF Aeshma - Strike Fighter <c=12AB06>35s</c>",
		Description =
		"<b>Description:</b> The SF Aeshma is a relatively rare, and only recently encountered, class of Shivan fighter. It appears to be a heavy attack fighter, like the Basilisk. With a low known top speed, Aeshmas seem to target slower-moving vessels, such as bombers, freighters, and gas miners. Their powerful lasers make them a danger to all such craft, so they must be engaged and destroyed as quickly as possible. \n\n<b>Prerequisites:</b> Fighter Design, Multi-Role Missiles. \n\n<b>Armaments:</b> 4x Anti-Cruiser Laser, 2x Swarm Missile (Advanced Upgrade).",
	},
	{

		Type = Ship,
		ThingToBuild = "shi_gorgon",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 8,
		DisplayedName = "SF Gorgon - Space Superiority <c=12AB06>45s</c>",
		Description =
		"<b>Description:</b> The first encounter with the SF Gorgon was made by the GTD Saratoga in the Ikeya system.  We are uncertain if this is a new design or if the Shivans have held this particular ship back for the majority of the war. The ship's unusual design not only provides it with exceptional maneuverability, but also allows it to generate an extremely powerful shield.  So far these ships have only been sighted leading wings of lesser fighters, but there have been reports of entire wings of Gorgons in larger forces. \n\n<b>Prerequisites:</b> Fighter Design, Anti-Fighter Missiles, Silent Threat. \n\n<b>Armaments:</b> 4x Medium Laser, 3x Heavy Laser, 1x Anti-Fighter Missile, 1x Swarm Missile.",
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
	{
		Type = Ship,
		ThingToBuild = "shi_nahema",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "SB Nahema - Strike Bomber <c=12AB06>34s</c>",
		Description =
		"<b>Description:</b> Either the SB Nahema class is a new Shivan bomber design, or the Shivans are finally taking the GTVA seriously and bringing in their best ships. The Nahema is considered to be the Shivan's most dangerous bomber. It has demonstrated the ability to outrun virtually every fighter in the GTVA fleet. Its powerful laser banks and high-capacity missile bays make it a threat to combat craft of all types, as well as to capital ships. \n\n<b>Prerequisites:</b> Bomber Design, Anti-Cruiser Bombs. \n\n<b>Armaments:</b> 2x Anti-Cruiser Laser, 2x Shivan Disruptor, 1x Anti-Subsystem Missle (Upgrade), 1x Shivan Bomb Launcher.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_seraphim",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 3,
		DisplayedName = "SB Seraphim - Heavy Bomber <c=12AB06>45s</c>",
		Description =
		"<b>Description:</b> The SB Seraphim is a familiar foe to GTVA forces. They appear to be similar to Nephilims in speed, armor, and shield strength, but have demonstrated a larger bomb capacity. \n\n<b>Prerequisites:</b> Bomber Design, Anti-Capital Bombs. \n\n<b>Armaments:</b> 6x Anti-Bomber Laser, 2x Anti-Bomber Turret, 1x Shivan Megabomb.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_shaitan",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 4,
		DisplayedName = "SB Shaitan - Strike Bomber <c=12AB06>48s</c>",
		Description =
		"<b>Description:</b> The Shaitan bomber is only slightly superior to our own bombers - its shielding is better, but its capacity seems to be far worse.  Perhaps the Shivans were confident that they would only need one payload to destroy a target. \n\n<b>Prerequisites:</b> Bomber Design \n\n<b>Armaments:</b> 2x Shivan Light Laser, 1x Disruptor, 1x Shivan Bomb Launcher, 1x Stiletto (Upgrade).",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_taurvi",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 41,
		DisplayedName = "SB Taurvi - Medium Bomber <c=12AB06>34s</c>",
		Description =
		"<b>Description:</b> The SB Taurvi is a Shivan vessel that has only recently been encountered. The Taurvi is one of the weaker Shivan bomber classes, but still the equal of every bomber in the GTVA arsenal. Not as maneuverable as a Nahema, nor as tough as a Seraphim or Nephilim, the Taurvi appears to be a Shivan compromise between speed and power. \n\n<b>Prerequisites:</b> Bomber Design, Anti-Cruiser Bombs. \n\n<b>Armaments:</b> 2x Anti-Cruiser Laser, 2x Anti-Fighter Laser, 1x Shivan Cluster Swarmer (Upgrade), 1x Shivan Bomb Launcher.",
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
	{
		Type = Ship,
		ThingToBuild = "shi_ravana",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "SD Ravana - Destroyer <c=12AB06>225s</c>",
		Description =
		"<b>Description:</b> The SD Ravana is a destroyer class GTVA forces have only recently encountered. It appears to be tasked with clearing out smaller foes, a mission for which it is well suited. It eagerly wipes out wings of fighters and bombers and also overwhelms cruisers and corvettes. \n\n<b>Prerequisites:</b> Capital Ship Design, Heavy Photon Beams. \n\n<b>Armaments:</b> 2x Heavy Beam, 2x Medium Beam, 2x Anti-Fighter Beam, 5x Flak Turret, 17x Turrets, 1x Cluster Missile Launcher, 1x Missile Launcher.",
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
