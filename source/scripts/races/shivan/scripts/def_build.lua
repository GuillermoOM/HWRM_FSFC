-- SHIVAN BUILD
Ship = 0
SubSystem = 1
build = {


	{
		Type = SubSystem,
		ThingToBuild = "awacs_1",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "AWACS Level II - Defensive EW",
		Description =
		"<b>Decreases Enemy Detection Range</b> \n\n<b>Description:</b> Enhanced defensive Electronic Warfare (EW) suite for Shivan Commnode AWACS. Friendly ships are are detected in 70% of normal range while in AWACS area. \n\n<b>Prerequisites:</b> AWACS Level II.",
	},
	{
		Type = SubSystem,
		ThingToBuild = "awacs_2",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "AWACS Level III - Offensive EW ",
		Description =
		"<b>Decreases Enemy Accuracy</b> \n\n<b>Description:</b> Enhanced offensive Electronic Warfare (EW) suite for Shivan Commnode AWACS. Enemy vessels have 30% reduced accuracy while in friendly AWACS range. \n\n<b>Prerequisites:</b> AWACS Level III.",
	},

	{
		Type = Ship,
		ThingToBuild = "shi_dragon",
		RequiredResearch = "Dragon",
		RequiredShipSubSystems = "",
		DisplayPriority = 4,
		DisplayedName = "SF Dragon - Superiority <c=12AB06>39s</c>",
		Description =
		"<b>Description:</b> The Shivan fighter class SF Dragon is a fast, extremely agile craft. Its five lasers pack a deadly punch. The Dragon's weakness seems to be a thin hull. The trouble is that their speed and maneuverability make them extremely difficult to hit. \n\n<b>Prerequisites:</b> Fighter Design, Dragon. \n\n<b>Armaments:</b> 5x Anti-Fighter Laser, 1x Anti-Fighter Missile.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_manticore",
		RequiredResearch = "Manticore",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "SF Manticore - Interceptor <c=12AB06>31s</c>",
		Description =
		"<b>Description:</b> The Manticore fighter is the fastest known craft in the Shivan armada. With a single, powerful laser and two missile banks, it is a dangerous offensive weapon. Its Achilles' heel lies in its thin hull and weak shields. Manticores do not last long in dogfights against other fighters. They prefer to target bombers, which are nearly helpless against the Manticore's speed and weaponry. \n\n<b>Prerequisites:</b> Fighter Design, Manticore. \n\n<b>Armaments:</b> 2x Anti-Bomber Laser, 1x Anti-Bomber Missile, 1x Anti-Fighter missile.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_astaroth",
		RequiredResearch = "FighterDesign & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "SF Astaroth - Scout <c=12AB06>30s</c>",
		Description =
		"<b>Description:</b> First encountered in Gamma Draconis, the SF Astaroth is a fast, agile fighter that appears to have achieved its maneuverability at the expense of its armor and weaponry. Once the shields of an Astaroth are down, the fighter can be dispatched quickly. \n\n<b>Prerequisites:</b> Fighter Design, Astaroth. \n\n<b>Armaments:</b> 2x Anti-Bomber Laser, 1x Shivan Heatseeker, 1x Shivan EMP (Upgrade)",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_basilisk",
		RequiredResearch = "Basilisk",
		RequiredShipSubSystems = "",
		DisplayPriority = 7,
		DisplayedName = "SF Basilisk - Assault <c=12AB06>37s</c>",
		Description =
		"<b>Description:</b> The SF Basilisk is a Shivan heavy attack fighter. Slow but heavily armed and well-protected, the Basilisk targets slower-moving vessels, such as bombers, freighters, and gas miners. Their powerful lasers make them a danger to all such craft, so they must be engaged and destroyed as quickly as possible. \n\n<b>Prerequisites:</b> Fighter Design, Basilisk. \n\n<b>Armaments:</b> 4x Anti-Cruiser Laser, 2x Swarm Missile, 2x Shivan Rockets.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_aeshma",
		RequiredResearch = "Aeshma & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 8,
		DisplayedName = "SF Aeshma - Assault <c=12AB06>35s</c>",
		Description =
		"<b>Description:</b> The SF Aeshma is a relatively rare, and only recently encountered, class of Shivan fighter. It appears to be a heavy attack fighter, like the Basilisk. With a low known top speed, Aeshmas seem to target slower-moving vessels, such as bombers, freighters, and gas miners. Their powerful lasers make them a danger to all such craft, so they must be engaged and destroyed as quickly as possible. \n\n<b>Prerequisites:</b> Fighter Design, Aeshma. \n\n<b>Armaments:</b> 4x Anti-Cruiser Laser, 2x Swarm Missile (Advanced Upgrade).",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_mara",
		RequiredResearch = "Mara & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 5,
		DisplayedName = "SF Mara - Adv. Superiority <c=12AB06>47s</c>",
		Description =
		"<b>Description:</b> The SF Mara class of Shivan fighters was first encountered by the GTC Vigilant while patrolling the Gamma Draconis jump node in the Capella system. All other information concerning the Mara is classified level Psi. \n\n<b>Prerequisites:</b> Fighter Design, Mara. \n\n<b>Armaments:</b> 4x Anti-Fighter Laser, 2x Anti-Fighter missile, 2x Shivan Heatseekers.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_nahema",
		RequiredResearch = "BomberDesign & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 40,
		DisplayedName = "SB Nahema - Strike Bomber <c=12AB06>34s</c>",
		Description =
		"<b>Description:</b> Either the SB Nahema class is a new Shivan bomber design, or the Shivans are finally taking the GTVA seriously and bringing in their best ships. The Nahema is considered to be the Shivan's most dangerous bomber. It has demonstrated the ability to outrun virtually every fighter in the GTVA fleet. Its powerful laser banks and high-capacity missile bays make it a threat to combat craft of all types, as well as to capital ships. \n\n<b>Prerequisites:</b> Bomber Design, Nahema. \n\n<b>Armaments:</b> 2x Anti-Cruiser Laser, 2x Shivan Disruptor, 1x Anti-Subsystem Missle (Upgrade), 1x Shivan Bomb Launcher.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_taurvi",
		RequiredResearch = "Taurvi & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 41,
		DisplayedName = "SB Taurvi - Medium Bomber <c=12AB06>34s</c>",
		Description =
		"<b>Description:</b> The SB Taurvi is a Shivan vessel that has only recently been encountered. The Taurvi is one of the weaker Shivan bomber classes, but still the equal of every bomber in the GTVA arsenal. Not as maneuverable as a Nahema, nor as tough as a Seraphim or Nephilim, the Taurvi appears to be a Shivan compromise between speed and power. \n\n<b>Prerequisites:</b> Bomber Design, Taurvi. \n\n<b>Armaments:</b> 2x Anti-Cruiser Laser, 2x Anti-Fighter Laser, 1x Shivan Cluster Swarmer (Upgrade), 1x Shivan Bomb Launcher.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_nephilim",
		RequiredResearch = "Nephilim",
		RequiredShipSubSystems = "",
		DisplayPriority = 43,
		DisplayedName = "SB Nephilim - Heavy Bomber <c=12AB06>44s</c>",
		Description =
		"<b>Description:</b> The SB Nephilim is the slowest of the Shivan bomber classes. These craft were first encountered during the Great War and are still found in many Shivan attack formations. Nephilims are heavily armored and shielded, enabling them to deliver their devastating payloads despite their lack of speed. \n\n<b>Prerequisites:</b> Bomber Design, Nephilim. \n\n<b>Armaments:</b> 2x Anti-Bomber Laser, 2x Anti-Bomber Turret, 2x Shivan Bomb Launcher, 1x Shivan Cluster Bomb (Upgrade).",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_seraphim",
		RequiredResearch = "Seraphim & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 44,
		DisplayedName = "SB Seraphim - Heavy Bomber <c=12AB06>45s</c>",
		Description =
		"<b>Description:</b> The SB Seraphim is a familiar foe to GTVA forces. They appear to be similar to Nephilims in speed, armor, and shield strength, but have demonstrated a larger bomb capacity. \n\n<b>Prerequisites:</b> Bomber Design, Seraphim. \n\n<b>Armaments:</b> 6x Anti-Bomber Laser, 2x Anti-Bomber Turret, 1x Shivan Megabomb.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_rakshasa",
		RequiredResearch = "Rakshasa & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 63,
		DisplayedName = "SC Rakshasa - Adv. Cruiser <c=12AB06>60s</c>",
		Description =
		"<b>Description:</b> Though not as thickly armored as the Lilith class, the SC Rakshasa class of Shivan cruisers is far deadlier. With over a dozen turrets, the Rakshasa is the most heavily armed Shivan cruiser class. It was a Rakshasa cruiser that destroyed the GTC Vigilant at the Gamma Draconis node in the Capella system. \n\n<b>Prerequisites:</b> Cruiser Design, Rakshasa. \n\n<b>Armaments:</b> 3x Light Beam, 1x Anti-Fighter Beam, 2x Heavy Laser, 8x Turret Laser.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_cain",
		RequiredResearch = "CruiserDesign & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 60,
		DisplayedName = "SC Cain - Strike Cruiser <c=12AB06>34s</c>",
		Description =
		"<b>Description:</b> The weakest of the Shivan cruiser classes is designated SC Cain. These vessels were commonly encountered during Great War battles. Cains are considered to be slightly stronger than the GTC Fenris cruiser class. \n\n<b>Prerequisites:</b> Cruiser Design, Cain. \n\n<b>Armaments:</b> 1x Light Beam, 1x Anti-Fighter Beam, 5x Turret Laser, 2x Missile Launcher.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_cain_fs1",
		RequiredResearch = "CruiserDesign & FS1",
		RequiredShipSubSystems = "",
		DisplayPriority = 60,
		DisplayedName = "SC Cain (FS1) - Strike Cruiser <c=12AB06>34s</c>",
		Description =
		"<b>Description:</b> The weakest of the Shivan cruiser classes is designated SC Cain. These vessels were commonly encountered during Great War battles. Cains are considered to be slightly stronger than the GTC Fenris cruiser class. \n\n<b>Prerequisites:</b> Cruiser Design, Cain. \n\n<b>Armaments:</b> 7x Turret Laser, 2x Missile Launcher.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_lilith",
		RequiredResearch = "HeavyCruiser & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 65,
		DisplayedName = "SC Lilith - Heavy Cruiser <c=12AB06>140s</c>",
		Description =
		"<b>Description:</b> The SC Lilith class of Shivan cruisers is a far-deadlier foe than the Cain class. Nearly impenetrable armor plating enables it to withstand tremendous punishment, enabling its nine turrets to lash out at warships and combat spacecraft with impunity. \n\n<b>Prerequisites:</b> Cruiser Design, Lilith. \n\n<b>Armaments:</b> 1x Heavy Beam, 1x Anti-Fighter Beam, 5x Turret Laser, 2x Shivan Cluster Missile Launcher.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_lilith_fs1",
		RequiredResearch = "HeavyCruiser & FS1",
		RequiredShipSubSystems = "",
		DisplayPriority = 65,
		DisplayedName = "SC Lilith (FS1) - Heavy Cruiser <c=12AB06>140s</c>",
		Description =
		"<b>Description:</b> The SC Lilith class of Shivan cruisers is a far-deadlier foe than the Cain class. Nearly impenetrable armor plating enables it to withstand tremendous punishment, enabling its nine turrets to lash out at warships and combat spacecraft with impunity. \n\n<b>Prerequisites:</b> Cruiser Design, Lilith. \n\n<b>Armaments:</b> 7x Turret Laser, 2x Shivan Cluster Missile Launcher.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_moloch",
		RequiredResearch = "Moloch & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 75,
		DisplayedName = "SCv Moloch - Corvette <c=12AB06>110s</c>",
		Description =
		"<b>Description:</b> Only one class of Shivan ship is classified as a corvette - the SCv Moloch class. Though they're physically as large as the GTCv Deimos class, Molochs do not seem to pack the same punch. They are far more deadly than any Shivan cruisers, however. \n\n<b>Prerequisites:</b> Capital Ship Design, Moloch. \n\n<b>Armaments:</b> 3x Medium Beam, 3x Flak, 1x Heavy Flak, 5x Turret, 4x Cluster Missile Launcher, 2x FighterKiller.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_demon",
		RequiredResearch = "CapitalShipDesign & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 110,
		DisplayedName = "SD Demon - Destroyer <c=12AB06>215s</c>",
		Description =
		"<b>Description:</b> The SD Demon class of Shivan destroyers is much smaller than the Lucifer class but very heavily armed and extremely dangerous. Demons are known to carry numerous wings of fighters and bombers. \n\n<b>Prerequisites:</b> Capital Ship Design, Demon. \n\n<b>Armaments:</b> 2x Heavy Beam, 1x Medium Beam, 2x Anti-Fighter Beam, 4x Flak Turret, 10x Turret Laser, 2x Huge Turret, 5x Missile Launcher.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_demon_fs1",
		RequiredResearch = "CapitalShipDesign & FS1",
		RequiredShipSubSystems = "",
		DisplayPriority = 110,
		DisplayedName = "SD Demon (FS1) - Destroyer <c=12AB06>215s</c>",
		Description =
		"<b>Description:</b> The SD Demon class of Shivan destroyers is much smaller than the Lucifer class but very heavily armed and extremely dangerous. Demons are known to carry numerous wings of fighters and bombers. \n\n<b>Prerequisites:</b> Capital Ship Design, Demon. \n\n<b>Armaments:</b> 5x Huge Turret, 4x Flak Turret, 10x Turret Laser, 5x Missile Launcher.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_ravana",
		RequiredResearch = "Ravana & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 116,
		DisplayedName = "SD Ravana - Destroyer <c=12AB06>225s</c>",
		Description =
		"<b>Description:</b> The SD Ravana is a destroyer class GTVA forces have only recently encountered. It appears to be tasked with clearing out smaller foes, a mission for which it is well suited. It eagerly wipes out wings of fighters and bombers and also overwhelms cruisers and corvettes. \n\n<b>Prerequisites:</b> Capital Ship Design, Ravana. \n\n<b>Armaments:</b> 2x Heavy Beam, 2x Medium Beam, 2x Anti-Fighter Beam, 5x Flak Turret, 17x Turrets, 1x Cluster Missile Launcher, 1x Missile Launcher.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_sathanas",
		RequiredResearch = "Sathanas & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 119,
		DisplayedName = "SJ Sathanas <c=12AB06>550s</c>",
		Description =
		"<b>Description:</b> Very little is known about the SJ Sathanas class. This juggernaut seems comparable in strength to the GTVA Colossus. All intelligence concerning the Sathanas has been classified level Upsilon. \n\n<b>Prerequisites:</b> Super Capital Ship Design, Sathanas. \n\n<b>Armaments:</b> 4x Super Heavy Beam, 1x Heavy Beam, 8x Anti-Fighter Beam, 10x Flak Turret (2x Triple Long Range), 24x Turret Laser, 4x Cluster Missile Launcher.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_lucifer",
		RequiredResearch = "Lucifer",
		RequiredShipSubSystems = "",
		DisplayPriority = 118,
		DisplayedName = "SD Lucifer - Super Destroyer <c=12AB06>305s</c>",
		Description =
		"<b>Description:</b> The SD Lucifer was a massive superdestroyer that led the Shivan armada in the Great War. No weapon in the allied arsenal could penetrate the Lucifer's shields. In the Altair system, Vasudan scientists uncovered ancient artifacts that explained how to track ships into subspace, where the Lucifer's shields would not function. A desperate mission to attack the Lucifer in subspace succeeded. But the explosion of the Lucifer collapsed the Sol jump node, severing all contact with Earth. \n\n<b>Prerequisites:</b> Capital Ship Design, Lucifer. \n\n<b>Armaments:</b> 2x Heavy Beam, 2x Bombardment Beam, 10x Shivan Turret Laser, 3x Cluster Missile Launcher.",
	},

	{
		Type = Ship,
		ThingToBuild = "shi_azrael",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 120,
		DisplayedName = "ST Azrael - Collector <c=12AB06>25s</c>",
		Description =
		"<b>Description:</b> Encountered on rare occasions since the Shivans first entered the Great War, the ST Azrael is the only known class of Shivan transport. Little is known about it even now, but it is believed to house many Shivans within its thin hulls. Since Azraels might be carrying Shivan pilots or other skilled crew members, it is always worthwhile to eliminate these lightly defended ships. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> 3x Light Turret.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_rahu",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 130,
		DisplayedName = "SG Rahu - Drop-off <c=12AB06>30s</c>",
		Description =
		"<b>Description:</b> Almost nothing is known of the Rahu line of gas miners. It is assumed that they function in much the same way as our Zephyrus miners, funneling nebular gas into internal machinery that fractionates it into its molecular components for further processing. Rahu miners are armed with heavy laser turrets, so care must be taken when attacking them. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> 3x Shivan Turret Laser.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_mephisto",
		RequiredResearch = "SentryAndMineDeployer",
		RequiredShipSubSystems = "",
		DisplayPriority = 131,
		DisplayedName = "SFr Mephisto - Sentry Builder <c=12AB06>25s</c>",
		Description =
		"<b>Description:</b> The SFr Mephisto class is equivalent to the Dis class in size and combat capabilities. Given their wildly different configurations, they must serve different purposes for the Shivans, but Allied Intelligence currently offers no further information on this matter. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> 4x Light Laser.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_belial",
		RequiredResearch = "SentryGun",
		RequiredShipSubSystems = "",
		DisplayPriority = 132,
		DisplayedName = "SSG Belial - Sentry Gun <c=12AB06>8s</c>",
		Description =
		"<b>Description:</b> The SSG Belial sentry gun platform appears to be a radical redesign of the Trident platform that was first encountered during the Great War. Pilots who have encountered both report that the Belial is harder to kill. It is reliably known that the Belial has twice as many laser turrets as the Trident sentry gun. Both types are used to guard storage depots, gas miners, and other Shivan installations. \n\n<b>Prerequisites:</b> Sentry Gun. \n\n<b>Armaments:</b> 4x Shivan Heavy Laser.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_asmodeus",
		RequiredResearch = "RepairFrigate",
		RequiredShipSubSystems = "",
		DisplayPriority = 133,
		DisplayedName = "SFr Asmodeus - Repair <c=12AB06>35s</c>",
		Description =
		"<b>Description:</b> Little is known about the SFr Asmodeus line of freighters. With a strong hull and four weapon turrets, they are the most dangerous Shivan freighters to attack. Nothing is known of the cargo Asmodeus freighters commonly carry. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> 2x Light Laser, 1x Heavy Laser, 1x Flak.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_commnode",
		RequiredResearch = "AWACS & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 134,
		DisplayedName = "Shivan Comm Node - AWACS <c=12AB06>70s</c>",
		Description =
		"<b>Description:</b> All details concerning this object have been classified level Omega, accessible only by those immediately authorized by the GTVA Security Council. \n\n<b>Prerequisites:</b> AWACS. \n\n<b>Armaments:</b> None.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_scorpion",
		RequiredResearch = "FighterDesign & FS1",
		RequiredShipSubSystems = "",
		DisplayPriority = 9,
		DisplayedName = "SF Scorpion - Recon <c=12AB06>28s</c>",
		Description =
		"<b>Description:</b> We originally thought the Scorpion was the Shivans' best fighter.  However, we now believe that the Scorpion is nothing more than a Shivan scout ship.  Their vast numbers and seeming unimportance to the Shivan war effort leads us to this belief.  Regardless of its purpose, the Scorpion is highly maneuverable, fast, and difficult to destroy.  It can also do damage equivalent to our space superiority fighters. \n\n<b>Prerequisites:</b> Fighter Design. \n\n<b>Armaments:</b> 4x Shivan Medium Laser, 1x Shivan Heatseeker.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_gorgon",
		RequiredResearch = "Gorgon",
		RequiredShipSubSystems = "",
		DisplayPriority = 13,
		DisplayedName = "SF Gorgon - Heavy Assault <c=12AB06>45s</c>",
		Description =
		"<b>Description:</b> The first encounter with the SF Gorgon was made by the GTD Saratoga in the Ikeya system.  We are uncertain if this is a new design or if the Shivans have held this particular ship back for the majority of the war. The ship's unusual design not only provides it with exceptional maneuverability, but also allows it to generate an extremely powerful shield.  So far these ships have only been sighted leading wings of lesser fighters, but there have been reports of entire wings of Gorgons in larger forces. \n\n<b>Prerequisites:</b> Fighter Design, Gorgon. \n\n<b>Armaments:</b> 4x Medium Laser, 3x Heavy Laser, 1x Anti-Fighter Missile, 1x Swarm Missile.",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_shaitan",
		RequiredResearch = "BomberDesign & FS1",
		RequiredShipSubSystems = "",
		DisplayPriority = 42,
		DisplayedName = "SB Shaitan - Strike Bomber <c=12AB06>48s</c>",
		Description =
		"<b>Description:</b> The Shaitan bomber is only slightly superior to our own bombers - its shielding is better, but its capacity seems to be far worse.  Perhaps the Shivans were confident that they would only need one payload to destroy a target. \n\n<b>Prerequisites:</b> Bomber Design, Shaitan. \n\n<b>Armaments:</b> 2x Shivan Light Laser, 1x Disruptor, 1x Shivan Bomb Launcher, 1x Stiletto (Upgrade).",
	},
	{
		Type = Ship,
		ThingToBuild = "shi_trident",
		RequiredResearch = "SentryGun",
		RequiredShipSubSystems = "",
		DisplayPriority = 132,
		DisplayedName = "SSG Trident - Sentry Gun <c=12AB06>6s</c>",
		Description =
		"<b>Description:</b> We believe that the sole purpose of the Trident is to guard Shivan repair and supply depots. It is not too strong, but in mass quantities, can be dangerous. \n\n<b>Prerequisites:</b> Sentry Gun. \n\n<b>Armaments:</b> 2x Shivan Heavy Laser.",
	}
}
