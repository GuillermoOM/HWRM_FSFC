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
	{
		Type = SubSystem,
		ThingToBuild = "ter_orion_nameplate_bastion",
		RequiredResearch = "DONOTSHOW",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "GTD Orion",
		Description = "GTD Orion",
	},
	{
		Type = SubSystem,
		ThingToBuild = "ter_orion_nameplate_carthage",
		RequiredResearch = "DONOTSHOW",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "GTD Orion",
		Description = "GTD Orion",
	},
	{
		Type = SubSystem,
		ThingToBuild = "ter_orion_nameplate_delacroix",
		RequiredResearch = "DONOTSHOW",
		RequiredShipSubSystems = "",
		DisplayPriority = 3,
		DisplayedName = "GTD Orion",
		Description = "GTD Orion",
	},
	{
		Type = SubSystem,
		ThingToBuild = "ter_orion_nameplate_intrepid",
		RequiredResearch = "DONOTSHOW",
		RequiredShipSubSystems = "",
		DisplayPriority = 4,
		DisplayedName = "GTD Orion",
		Description = "GTD Orion",
	},
	{
		Type = SubSystem,
		ThingToBuild = "ter_orion_nameplate_messana",
		RequiredResearch = "DONOTSHOW",
		RequiredShipSubSystems = "",
		DisplayPriority = 5,
		DisplayedName = "GTD Orion",
		Description = "GTD Orion",
	},
	{
		Type = SubSystem,
		ThingToBuild = "ter_orion_nameplate_minnow",
		RequiredResearch = "DONOTSHOW",
		RequiredShipSubSystems = "",
		DisplayPriority = 6,
		DisplayedName = "GTD Orion",
		Description = "GTD Orion",
	},
	{
		Type = SubSystem,
		ThingToBuild = "ter_orion_nameplate_nereid",
		RequiredResearch = "DONOTSHOW",
		RequiredShipSubSystems = "",
		DisplayPriority = 7,
		DisplayedName = "GTD Orion",
		Description = "GTD Orion",
	},
	{
		Type = SubSystem,
		ThingToBuild = "ter_orion_nameplate_orion",
		RequiredResearch = "DONOTSHOW",
		RequiredShipSubSystems = "",
		DisplayPriority = 8,
		DisplayedName = "GTD Orion",
		Description = "GTD Orion",
	},
	{
		Type = SubSystem,
		ThingToBuild = "ter_orion_nameplate_soyakaze",
		RequiredResearch = "DONOTSHOW",
		RequiredShipSubSystems = "",
		DisplayPriority = 9,
		DisplayedName = "GTD Orion",
		Description = "GTD Orion",
	},
	{
		Type = SubSystem,
		ThingToBuild = "ter_orion_nameplate_galatea",
		RequiredResearch = "DONOTSHOW",
		RequiredShipSubSystems = "",
		DisplayPriority = 10,
		DisplayedName = "GTD Orion",
		Description = "GTD Orion",
	},
	{
		Type = SubSystem,
		ThingToBuild = "ter_orion_nameplate_myrmidon",
		RequiredResearch = "DONOTSHOW",
		RequiredShipSubSystems = "",
		DisplayPriority = 11,
		DisplayedName = "GTD Orion",
		Description = "GTD Orion",
	},
	{
		Type = SubSystem,
		ThingToBuild = "ter_orion_nameplate_amadeus",
		RequiredResearch = "DONOTSHOW",
		RequiredShipSubSystems = "",
		DisplayPriority = 12,
		DisplayedName = "GTD Orion",
		Description = "GTD Orion",
	},
	{
		Type = SubSystem,
		ThingToBuild = "ter_orion_nameplate_eisenhower",
		RequiredResearch = "DONOTSHOW",
		RequiredShipSubSystems = "",
		DisplayPriority = 13,
		DisplayedName = "GTD Orion",
		Description = "GTD Orion",
	},
	{
		Type = SubSystem,
		ThingToBuild = "ter_orion_nameplate_goliath",
		RequiredResearch = "DONOTSHOW",
		RequiredShipSubSystems = "",
		DisplayPriority = 14,
		DisplayedName = "GTD Orion",
		Description = "GTD Orion",
	},
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
		ThingToBuild = "ter_loki",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "GTF Loki - Recon",
		Description =
		"<b>Description:</b> The GTF Loki is designated as a fighter, but it's more of a heavy reconnaissance craft. The Loki's micro-roughened hull and shielded exhaust chamber give it an extremely reduced profile to detection sensors. This makes it ideal for reconnaissance and infiltration missions that rely on stealth rather than firepower. Lacking the weaponry and armor to survive prolonged battles, the Loki can usually stay alive long enough for its high maneuverability and speed to discourage pursuers. Lokis are widely used by NTF forces. \n\n<b>Prerequisites:</b> Fighter Design, Anti-Bomber missiles. \n\n<b>Armaments:</b> 2x GTW Subach HL-7, 2x GTW-83 Lamprey, 1x GTM-19 Harpoon, 1x GTM-41 EMP Adv (Upgrade)",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_perseus",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "GTF Perseus - Interceptor",
		Description =
		"<b>Description:</b> The GTF Perseus is the newest fighter in the GTVA's arsenal. Slated to replace the aging Valkyrie as the Alliance's primary interceptor, the Perseus's high max speed and maneuverability make it ideal to hunt and destroy enemy bombers. Perseus fighters have been assigned to the 3rd Battle Group on a trial basis, with wide deployment expected after the OpEval period. Primary weapons include the Subach HL-7 and Prometheus cannon, with secondary loads of Harpoon and Hornet missiles. Preliminary results have shown the Perseus to be a superb fighter. \n\n<b>Prerequisites:</b> Fighter Design, Anti-Bomber Missiles. \n\n<b>Armaments:</b> 2x GTW-5 Prometheus S, 2x GTW Subach HL-7, 1x GTM-55 Trebuchet, 1x GTM-19 Harpoon.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_apollo",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 3,
		DisplayedName = "GTF Apollo - Space Superiority",
		Description =
		"<b>Description:</b> The Apollo is the most common GTA fighter.  It is highly versatile and can perform multiple roles, including space superiority, interception and assault. \n\n<b>Prerequisites:</b> Fighter Design \n\n<b>Armaments:</b> 4x ML-16 Laser, 4x GTW-15 Avenger (Upgrade), 1x GTM-MX50, 1x GTM-2 Fury.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_myrmidon",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 4,
		DisplayedName = "GTF Myrmidon - Adv. Superiority",
		Description =
		"<b>Description:</b> RNI Systems' GTF Myrmidon replaces the Ulysses as the Alliance's primary space superiority fighter. The Myrmidon has received high marks for speed, maneuverability, armor, and loadout. An ultra-efficient hull configuration provides space for three secondary weapon systems, a first for Terran-Vasudan fighters. This versatility enables Myrmidon squadrons to fulfill a range of combat roles, from light assault to heavy reconnaissance. \n\n<b>Prerequisites:</b> Fighter Design, Anti-Fighter Missiles. \n\n<b>Armaments:</b> 4x GTW Subach HL-7, 2x GTW-5a Prometheus R, 2x GTM-MX64 Rockeye, 1x GTM-MX6 Tempest.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_ares",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 5,
		DisplayedName = "GTF Ares - Strategic Assault",
		Description =
		"<b>Description:</b> The GTF Ares class of fighters is a radical upgrade of the Hercules II fighter. The power plant has been completely replaced with the newer, more powerful Nankam NA-27f model. Depleted uranium shielding has been added atop critical subsystems, making the Ares harder to incapacitate. Two primary weapon banks have been added, for greater firepower than the Herc II. This greater punch and protection come at a cost, however, as the Ares handles like a potato. \n\n<b>Prerequisites:</b> Fighter Design, Anti-Bomber Missiles, Tornado missiles. \n\n<b>Armaments:</b> 2x GTW-66 Maxim, 4x Prometheus S, 2x GTM-55 Trebuchet, 2x GTM-4a Tornado.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_erinyes",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 6,
		DisplayedName = "GTF Erinyes - Heavy Assault",
		Description =
		"<b>Description:</b> GTF Erinyes craft are fresh off the drawing boards of Triton Dynamics. Though fast and heavily armored, their main attraction is firepower. With eight primary banks and two secondary weapon bays, Erinyes are at the top of the combat craft food chain. Both sets of weapon banks have been designed to maximize compatibility with the greatest possible number of weapon system. Erinyes-class ships are being evenly distributed through the GTVA fleet, but only elite pilots are currently authorized to fly them. \n\n<b>Prerequisites:</b> Fighter Design, Multi-Role Missiles, Anti-Fighter Missiles. \n\n<b>Armaments:</b> 4x UD-8 Kayser, 4x GTW-19 Circe, 1x GTM-19 Harpoon, 1x GTM-4a Tornado.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_hercules",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 7,
		DisplayedName = "GTF Hercules - Assault",
		Description =
		"<b>Description:</b> The Hercules is the slowest and most unmanageable fighter in the fleet.  This is offset, however, by its overpowering weaponry and shielding.  It carries six primary weapons, as well as two full secondary banks.  This heavy assault fighter is best suited for small target attacks and bomber escort. \n\n<b>Prerequisites:</b> Fighter Design, Multi-Role Swarm Missiles. \n\n<b>Armaments:</b> 2x GTW-5 Prometheus, 4x GTW-15 Avenger, 2x GTM-4 Hornet, 2x GTM-2 Fury.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_herculesmk2",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 8,
		DisplayedName = "GTF Hercules Mk. II - Assault",
		Description =
		"<b>Description:</b> The GTF Hercules Mark II is the next generation of Terran heavy assault fighter. Introduced during the Great War, the original Herc's balance of firepower and maneuverability made it the most versatile strike fighter in the fleet. Some military historians have claimed the Hercules won the Great War, citing its deployment in key battles near the end of the Shivan conflict. Implementing recent advances in fusion drive technology, the Mark II improves the assault fighter's speed and maneuverability without sacrificing loadout capacity. \n\n<b>Prerequisites:</b> Fighter Design, Multi-Role Swarm Missiles. \n\n<b>Armaments:</b> 2x GTW-5a Prometheus R, 2x GTW Subach HL-7, 2x GTM-4 Hornet (Tornado Upgrade), 2x GTM-MX6 Tempest.",
	},


	{
		Type = Ship,
		ThingToBuild = "ter_pegasus",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 9,
		DisplayedName = "GTF Pegasus - Stealth Recon",
		Description =
		"<b>Description:</b> The Pegasus is used almost exclusively for reconnaissance missions. It's the fastest, most maneuverable ship in the Terran arsenal. The craft's contours and hull materials were carefully designed to minimize its profile to detection sensors. It is woefully armored and packs only minimal weaponry, making it a death box in a firefight. Pegasus pilots are a special breed of daredevils who pride themselves on getting into and out of situations that would be the death of other pilots, all without firing a shot. \n\n<b>Prerequisites:</b> Fighter Design, Stealth Technology. \n\n<b>Armaments:</b> 2x Subach HL-7 (Rapid Fire), GTM-19 Harpoon, 1x GTM 43a Stiletto II (Upgrade).",
	},


	{
		Type = Ship,
		ThingToBuild = "ter_valkyrie",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 10,
		DisplayedName = "GTF Valkyrie - Interceptor",
		Description =
		"<b>Description:</b> Using the old GTF Angel scout fighter as a template, the GTA created the Valkyrie interceptor fighter.  It has two additional engines, as well as an additional set of primary hardpoints.  This makes the Valkyrie the best bomber interceptor in the fleet.  Its speed is unmatched in the GTA, and its maneuverability is above average.  Its only drawbacks are a small secondary payload and a weak hull. \n\n<b>Prerequisites:</b> Fighter Design, Anti-Bomber Missiles \n\n<b>Armaments:</b> 4x GTW-7 Banshee, 2x GTW-65 Railgun (Silent Threat Upgrade), 2x GTM Phoenix-V.",
	},


	{
		Type = Ship,
		ThingToBuild = "ter_ulysses",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 11,
		DisplayedName = "GTF Ulysses - Adv. Space Superiority",
		Description =
		"<b>Description:</b> Developed in a joint operation by the Vasudan and Terran governments, the GTF Ulysses is an excellent all-around fighter. It offers superior maneuverability and a high top speed. \n\n<b>Prerequisites:</b> Fighter Design, Anti-Fighter Missiles. \n\n<b>Armaments:</b> 4x GTW-15 Avenger, 2x GTW-99 Shield Breaker (Silent Threat Upgrade), 1x GTM-9 Interceptor.",
	},


	-- Bombers --------------

	{
		Type = Ship,
		ThingToBuild = "ter_athena",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "GTB Athena - Light Bomber",
		Description =
		"<b>Description:</b> The smallest bomber in the fleet, the Athena has oftentimes been mistaken for a fighter.  However, one should not be fooled by its small size.  The Athena can carry light bombs and most missiles.  It also has the ability to dogfight well.  Its strong shielding and hull make it the favored ''Lightning Bomber'' of the GTA. \n\n<b>Prerequisites:</b> Bomber Design \n\n<b>Armaments:</b> 2x GTW-15 Avenger, 2x GTW-41 Disruptor, 2x GTW-32 Flail (Upgrade), 2x GTM-9 Interceptor, 2x GTM-11 EM Pulse.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_zeus",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "GTB Zeus - Strike Bomber",
		Description =
		"<b>Description:</b> Another product of GTI R&D, the Zeus strike bomber is a worthy successor to the Athena.  Its balanced design and increased reactor capacity give it remarkable speed for a bomber, yet it still remains capable of carrying the powerful Tsunami bombs.  These features will make the Zeus a versatile and effective weapon against capital ships. \n\n<b>Prerequisites:</b> Bomber Design, Anti-Cruiser Bombs. \n\n<b>Armaments:</b> 2x GTW-15 Avenger, 2x GTW-41 Disruptor, 1x GTM-43 Stiletto (Upgrade), 1x GTM-3 Tsunami.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_medusa",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 3,
		DisplayedName = "GTB Medusa - Medium Bomber",
		Description =
		"<b>Description:</b> The Medusa is the standard attack bomber in the GTA.  Its strong shielding and large secondary capacity make it the favored attack craft against cruiser class targets.  As the first bomber to carry the Tsunami bomb, the Medusa is considered the staple of any bomber pilot's career. \n\n<b>Prerequisites:</b> Bomber Design, Anti-Cruiser Bombs. \n\n<b>Armaments:</b> 2x GTW-15 Avenger, 1x Avenger turret, 2x GTM-3 Tsunami, 1x GTM-1 Synaptic (Upgrade).",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_ursa",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 4,
		DisplayedName = "GTB Ursa - Heavy Bomber",
		Description =
		"<b>Description:</b> The Ursa is the first bomber designed specifically for the purpose of annihilating capital ships. It carries a massive payload and is the only bomber in the GTA which can equip the Harbinger Bomb. Strong shielding and hull make the Ursa very difficult to destroy. \n\n<b>Prerequisites:</b> Bomber Design, Anti Capital Bombs. \n\n<b>Armaments:</b> 5x GTW-5 Prometheus, 1x Banshee turret, 1x GTM-N1 Harbinger, 1x GTM-86 Cluster Bomb (Silent Threat Upgrade).",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_artemis",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 5,
		DisplayedName = "GTB Artemis - Medium Bomber",
		Description =
		"<b>Description:</b> The GTB Artemis is the most agile bomber in the GTVA fleet, which makes it ideal for quick-hitting missions against warships and other slow targets. Of the same technological generation as the Boanerges class, the Artemis is less heavily armed and carries a lighter weapon payload, but it is significantly more maneuverable. While the Boanerges can inflict more damage, the Artemis can undertake (and return from) missions the slower Boanerges would have no hope of surviving. \n\n<b>Prerequisites:</b> Bomber Design, Anti-Cruiser Bombs. \n\n<b>Armaments:</b> 4x Subach HL-7 (Rapid Fire), 1x GTM-10 Pihrana (Upgrade), 1x GTM-12 Cyclops.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_artemisdh",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 6,
		DisplayedName = "GTB Artemis D.H. - Adv. Bomber",
		Description =
		"<b>Description:</b> The Artemis D.H. is an experimental variant of the standard Artemis. The most notable change is the Artemis's factory-issued Han-Ronald engines have been replaced by the Nankam NA-27f powerplant found in GTF Ares fightercraft. The D.H. is faster and more maneuverable than the standard Artemis bomber, at no cost to armor or armament. During the OpEval period, Artemis D.H. bombers are being deployed in only select squadrons in different theatres of the war. \n\n<b>Prerequisites:</b> Bomber Design, Anti-Cruiser Bombs, Anti-Fighter upgrade, Artemis D.H. Upgrade. \n\n<b>Armaments:</b> 4x UD-8 Kayser (Rapid Fire), 1x GTM-10 Pihrana, 1x GTM-12 Cyclops.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_boanerges",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 7,
		DisplayedName = "GTB Boanerges - Heavy Bomber",
		Description =
		"<b>Description:</b> The new GTB Boanerges has been assigned to elite bomber squadrons in the 3rd, 4th, and 5th Terran battle groups. The challenge of maintaining an aging fleet has motivated the GTVA to develop a new generation of ships able to withstand long-term abuse in the field. By maximizing shielding and payload (while offering enough maneuverability to make it a viable tactical unit), the Boanerges promises to remain in service for decades to come. One test pilot observed that the Boanerges handles better than any other bomber and has enough firepower to make it a formidable anti-capship weapon. \n\n<b>Prerequisites:</b> Bomber Design, Anti-Capital Bombs. \n\n<b>Armaments:</b> 2x GTW-66 Maxim, 1x GTM-13 Helios, 1x GTM-11 Infyrno (Upgrade).",
	},



	-- Frigates ---------------

	{
		Type = Ship,
		ThingToBuild = "ter_fenris",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "GTC Fenris - Light Cruiser",
		Description =
		"<b>Description:</b> The Fenris class is the aging stalwart among the Alliance's warships. Before the Great War, the Fenris was the GTA's only class of cruisers. During the war, Terran Command decided to build a second line of cruisers, the Leviathans, to free the Fenris from escort and guard duties. Fenris cruisers have fought in virtually every theatre of operation. These fast, versatile cruisers pack enough punch in their 260-meter-long hulls to go toe-to-toe with any enemy cruiser, and it's speed and maneuverability make it a good choice for strike missions. \n\n<b>Prerequisites:</b> Cruiser Design, Light Photon Beams. \n\n<b>Armaments:</b> 1x Slashing Beam, 1x Fusion Mortar, 2x Anti-Fighter Beam, 5x Turret.",
	},


	{
		Type = Ship,
		ThingToBuild = "ter_leviathan",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "GTC Leviathan - Heavy Cruiser",
		Description =
		"<b>Description:</b> The Leviathan is much heavier armed and armored than the Fenris, but also much slower and less maneuverable. Leviathan cruisers are used to guard critical installations, such as permanent jump nodes, deep-space factories, and gas-mining operations, where firepower is king and speed is of little importance. They're also well-suited to escorting slow-moving freighters or transports. The Fenris is good for fast-moving operations, but when you need some muscle, call in a Leviathan. \n\n<b>Prerequisites:</b> Cruiser Design, Cruiser Armor, Light Photon Beams. \n\n<b>Armaments:</b> 1x Light Beam, 1x Pihrana Turret, 4x Anti-Fighter Beam, 3x Turret.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_aeolus",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 3,
		DisplayedName = "GTC Aeolus - Adv. Cruiser",
		Description =
		"<b>Description:</b> The GTC Aeolus is the first cruiser class ever produced by the RNI shipyards orbiting Laramis II. Only two dozen of these cruisers were put into service in GTVA fleets, with production ending in 2365. Allied Command assigns Aeolus-class ships primarily to guard slow-moving convoys against fighter and bomber wings, as these cruisers are severely out-gunned by most capital ships in service today. Their flak and AAA turrets serve as marvelous deterrents to smaller craft, however. \n\n<b>Prerequisites:</b> Cruiser Design, Medium Photon Beams. \n\n<b>Armaments:</b> 2x Light Beam, 2x Anti-Fighter Beam, 6x Flak Turret, 2x Huge Turret.",
	},


	-- Capital Ships ----------

	{
		Type = Ship,
		ThingToBuild = "ter_deimos",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "GTCv Deimos - Corvette",
		Description =
		"<b>Description:</b> Deimos-class corvettes, such as the GTCv Actium and the GTCv Lysander, are the newest addition to the Terran fleet. These sleek, ultra-modern warships are the products of a new era of ship design, maximizing maneuverability and firepower. Their hulls are strengthened with collapsed-core molybdenum sheathing for better protection against beam fire, and their Vasudan-designed reactor core provides more energy per ton than any other allied ship class. \n\n<b>Prerequisites:</b> Capital Ship Design, Medium Photon Beams. \n\n<b>Armaments:</b> 4x Slashing Beam, 4x Anti-Fighter Beam, 6x Flak Turret, 2x Piranha Missile Launcher, 4x Huge Turret, 6x Turret.",
	},
	{
		Type = Ship,
		ThingToBuild = "ter_orion",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "GTD Orion - Destroyer",
		Description =
		"<b>Description:</b> For over 30 years, the GTD Orion class was the largest ship in the Terran-Vasudan armada. Over two kilometers in length, bristling with dozens of death-dealing turrets, the Orion is as awesome in repose as it is in battle. All GTVA Orions have been retrofitted with the latest anti-warship beam weapons, as well as flak and AAA turrets for dealing with fighters and bombers. The Orion's cavernous hangar bays easily accommodate more than two dozen fighter or bomber wings. \n\n<b>Prerequisites:</b> Capital Ship Design, Heavy Photon Beams. \n\n<b>Armaments:</b> 3x Heavy Beam, 3x Slashing Beam, 3x Anti-Fighter Beam, 4x Huge Turret, 3x Turret.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_hecate",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 3,
		DisplayedName = "GTD Hecate - Destroyer",
		Description =
		"<b>Description:</b> The new GTD Hecate class of destroyers is replacing the Orion class as the flagship of Terran battle groups. More heavily armed than the Orion, the Hecate also carries over 150 combat spacecraft and a crew of 10,000. The GTD Aquitaine is a superb example of this new ship class, serving as the flagship of the Capella-based 3rd Fleet. \n\n<b>Prerequisites:</b> Capital Ship Design, Heavy Photon Beams. \n\n<b>Armaments:</b> 1x Heavy Beam, 4x Slashing Beam, 6x Anti-Fighter Beam, 4x Flak Turret, 6x Long Range Flak Turret, 6x Turret.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_colossus",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 4,
		DisplayedName = "GTVA Colossus",
		Description =
		"<b>Description:</b> The GTVA Colossus resulted from an endeavor unprecedented in Terran or Vasudan history. This 6-kilometer-long behemoth is the result of 20 years of joint effort from dozens of contractors of both races. The Colossus is the most powerful space-faring warship ever made, bristling with over 60 weapon turrets. It also houses 60 fighter and bomber wings and requires a crew of over 30,000. The firepower of the Colossus is greater than that of most GTVA battle groups. \n\n<b>Prerequisites:</b> Super Capital Ship Design \n\n<b>Armaments:</b> 6x Heavy Beams, 7x Slashing Beams, 10x Anti-Fighter Beams, 12x Flak Turret, 2x Piranha, 8x FighterKiller, 10x Huge Turret, 8x Turret.",
	},
	{
		Type = Ship,
		ThingToBuild = "ter_hades",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 340,
		DisplayedName = "GTD Hades - Super Destroyer",
		Description =
		"<b>Description:</b> The GTD Hades was a fusion of Terran and Shivan military technologies. It was constructed by Galactic Terran Intelligence (GTI), a rogue branch of the GTA. After the defeat of the GTI and the destruction of the Hades, the GTA classified the details of this research at level Omega. There are rumors that the Alliance has attempted to reconstruct the Hades to learn more about the GTI's activities. These reports have yet to be confirmed by government sources. \n\n<b>Prerequisites:</b> Capital Ship Design, Shivan Hybrid Beams. \n\n<b>Armaments:</b> 2x Super Heavy Beam, 2x Heavy Beam, 4x Piranha Missile Launcher, 5x Huge Turret, 7x Turret.",
	},


	-- Platforms --------------


	{
		Type = Ship,
		ThingToBuild = "ter_alastor",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "GTSG Alastor - Sentry Gun",
		Description =
		"<b>Description:</b> GTSG Alastor sentry gun platforms can be dropped by warships to cover a retreat, or they can be used to strengthen firepower around strategic locations. While Alastors alone cannot hold a position against more than a few fighters, complementing them with a warship and several wings of fighters presents an exemplary defense against all but the most determined foes. Two Bessmer-Kohn cannon turrets on opposing sides of the platform give the Alastor a full field of fire. The turrets are controlled by the latest neural-net cyber-AI to track multiple targets simultaneously. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> 2x Subach.",
	},
	{
		Type = Ship,
		ThingToBuild = "ter_cerberus",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "GTSG Cerberus - Sentry Gun",
		Description =
		"<b>Description:</b> The Cerberus is an advanced version of the Watchdog, with stronger weaponry and the ability to withstand more damage. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> 2x GTW-15 Avenger.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_mjolnir",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 3,
		DisplayedName = "GTSG Mjolnir - Beam Sentry",
		Description =
		"<b>Description:</b> The GTSG Mjolnir is the most advanced sentry gun device known. The Mjolnir mounts a single, powerful beam cannon and can do heavy damage to enemy warships before they come in range. Mjolnirs are also referred to as RBCs (remote beam cannons). They are used to help protect the most vital front-line Alliance installations. \n\n<b>Prerequisites:</b> Heavy Photon Beams. \n\n<b>Armaments:</b> 1x Mjolnir Beam.",
	},


	-- Utility ----------------

	{
		Type = Ship,
		ThingToBuild = "ter_elysium",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "GTT Elysium - Collector",
		Description =
		"<b>Description:</b> The GTT Elysium class of transports has been in service for over 40 years. Its mission hasn't changed from the time of the Great War - to transport civilian and military personnel from one star system to another. The Elysium is very poorly armed, with a single Subach HL-7 cannon, and also suffers from thin armor plating. Only desperate circumstances find Elysiums anywhere near the front lines. Assaults and dangerous transport missions handled almost exclusively by the much tougher GTT Argo class. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> None.",
	},
	{
		Type = Ship,
		ThingToBuild = "ter_zephyrus",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "GTG Zephyrus - Drop-off",
		Description =
		"<b>Description:</b> When a fighter pilot sees a ship of the GTG Zephyrus class, one thought flashes through his or her mind: Thank God I don't have to fly that tub! The Zephyrus is a gas miner designed to harvest the gases of interstellar nebulae. It's the largest non-combatant ship in the GTVA fleet. The Zephyrus's thin armor, weak weaponry, and poor speed give it a very low survival rate in combat, so these ships stay well back from the front lines. Despite these weaknesses, the Zephyrus plays a critical role in the operation of the GTVA fleet. The deuterium gathered by Zephyrus ships powers the fleet's fusion drives. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> 2x Turret, 2x Subach HL-7, 1x Flak.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_charybdis",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 3,
		DisplayedName = "GTA Charybdis - AWACS",
		Description =
		"<b>Description:</b> Ships of the GTA Charybdis class have been packed with the latest tachyon-enabled AWACS equipment from GTVI labs. Each GTVA battle group has a squadron of Charybdis-class ships assigned to it. These ships double the range of the group's standard detection arrays. Charybdis ships' thin armor and weak defenses make them easy victims for enemy bombers. They have proven indispensable, however, in forays into the nebula beyond the Knossos portal. Charybdis-class ships are very vulnerable in this environment, as witnessed by the recent loss of the GTA Panopticon from the 3rd Battle Group. \n\n<b>Prerequisites:</b> AWACS Level I \n\n<b>Armaments:</b> 6x Turret.",
	},
	{
		Type = Ship,
		ThingToBuild = "ter_argo",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 4,
		DisplayedName = "GTT Argo - Repair",
		Description =
		"<b>Description:</b> The GTT Argo has become the standard military transport vehicle for the Terran fleet. Argos sometimes carry new weapon and combat craft prototypes to and from testing grounds or to front-line deployment positions. Military VIPs occasionally commandeer Argos to travel from star system to star system in some semblance of comfort. Argos are most often used as assault transports, carrying squads of Marines through heavy flak to board enemy vessels that Command has decided to capture rather than destroy. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> 2x Flak, Capture ability (Upgrade)",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_hygeia",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 5,
		DisplayedName = "GTS Hygeia - Support Ship",
		Description =
		"<b>Description:</b> The GTS Hygeia is the fleet's newest Terran support ship. It is fast and maneuverable, a necessity when trying to dock with fighters in the heat of battle. Triton Dynamics designed the Hygeia class with huge cargo bays for munitions storage, plus the latest magnetic-stasis delivery system for quickly re-supplying combat craft with missiles and bombs. The Hygeia's repair facilities are driven by neural-net AI, for ultra-fast system diagnostics and repair. The high number of warheads carried by the Hygeia makes it a dangerous ship to be near when it blows up. \n\n<b>Prerequisites:</b> Fighter Design or Bomber design \n\n<b>Armaments:</b> None.",
	},

	{
		Type = Ship,
		ThingToBuild = "ter_centaur",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 6,
		DisplayedName = "GTS Centaur - Support Ship",
		Description =
		"<b>Description:</b> The Centaur support ship is designed to get in and out of battle as quick as possible. It is fast, and quite maneuverable, allowing it to dock with fighters in a minimum amount of time. Most notable about the Centaur, however, is its extremely large explosion radius. The amount of warheads carried on a support ship makes it very dangerous to be close to an exploding Centaur. \n\n<b>Prerequisites:</b> Fighter Design or Bomber design \n\n<b>Armaments:</b> None.",
	},
	{
		Type = Ship,
		ThingToBuild = "ter_pharos",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 7,
		DisplayedName = "GTNB Pharos - Sensor Bouy",
		Description =
		"<b>Description:</b> Long range sensor device. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> None.",
	},
	{
		Type = Ship,
		ThingToBuild = "ter_poseidon",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 8,
		DisplayedName = "GTFr Poseidon - Sentry Builder",
		Description =
		"<b>Description:</b> The GTFr Poseidon is the smaller of the two standard Terran military freighters. Though it carries only half as much cargo as the Triton, the Poseidon is more often chosen for dangerous missions. Its greater speed gives it better survivability on the front lines, as does the fact that it has four weapon turrets, compared to the Triton's two. When Allied Command sends supplies and munitions that have to get through, a Poseidon is usually chosen to transport them. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> 4x Turret.",
	},

}
