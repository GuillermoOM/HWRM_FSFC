-- VASUDAN BUILD

Ship = 0
SubSystem = 1
build = {


	{
		Type = SubSystem,
		ThingToBuild = "awacs_1",
		RequiredResearch = "AWACSLVL2",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "AWACS Level II - Defensive EW",
		Description = "<b>Decreases Enemy Detection Range</b> \n\n<b>Description:</b> Enhanced defensive Electronic Warfare (EW) suite for GTA Charybids AWACS. Friendly ships are are detected in 70% of normal range while in AWACS area. \n\n<b>Prerequisites:</b> AWACS Level II.",
	},
	{
		Type = SubSystem,
		ThingToBuild = "awacs_2",
		RequiredResearch = "AWACSLVL3",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "AWACS Level III - Offensive EW ",
		Description = "<b>Decreases Enemy Accuracy</b> \n\n<b>Description:</b> Enhanced offensive Electronic Warfare (EW) suite for GTA Charybids AWACS. Enemy vessels have 30% reduced accuracy while in friendly AWACS range. \n\n<b>Prerequisites:</b> AWACS Level III.",
	},

	{
		Type = Ship,
		ThingToBuild = "vas_ptah",
		RequiredResearch = "Ptah & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 10,
		DisplayedName = "GVF Ptah - Stealth Recon <c=12AB06>65s</c>",
		Description =
		"<b>Description:</b> The stealth prototype GVF Ptah was a top-secret development project assigned to Vasudan conglomerate Akheton Corp. Designed to be invisible to standard detection arrays mounted on combat craft, Ptahs have performed admirably during their OpEval period. The masking materials and blending technologies used across their outer surfaces seem to confuse Shivan detection systems as well. The Ptah is currently available only to select fighter units in the Vasudan navy, with no word on when they will be more widely distributed. \n\n<b>Prerequisites:</b> Fighter Design, Ptah. \n\n<b>Armaments:</b> 2x Mekhu HL-7 (Rapid Fire), 1x GTM-19 Harpoon, 1x GTM 43a Stiletto II (Upgrade)",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_seth",
		RequiredResearch = "Seth & FS1",
		RequiredShipSubSystems = "",
		DisplayPriority = 7,
		DisplayedName = "GVF Seth - Assault <c=12AB06>35s</c>",
		Description =
		"<b>Description:</b> The solidly built GVF Seth is a versatile Great War-era fighter that still performs dual roles as bomber escort and bomber interceptor. The Seth's relatively slow cruising speed is deceptive, as its Mekhu-Sahr plasma powerplant can give it an incredible afterburner boost, more than doubling its velocity. A total of six weapon banks and a wide variety of loadouts give the Seth the needed punch to eliminate incoming bombers quickly. \n\n<b>Prerequisites:</b> Fighter Design, Seth. \n\n<b>Armaments:</b> 4x Prometheus R, 2x GTM-4 Hornet (Tornado Upgrade), 1x GTM-MX6 Tempest.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_anubis",
		RequiredResearch = "Anubis & FS1",
		RequiredShipSubSystems = "",
		DisplayPriority = 8,
		DisplayedName = "PVF Anubis - Space Superiority <c=12AB06>24s</c>",
		Description =
		"<b>Description:</b> The PVF Anubis is a Great War-era Space Superiority fighter of the Vasudan Navy. Boasting high speed and maneuverability, the Anubis is capable of engaging and eliminating any Shivan fighter threat. Equipped with an afterburner and robust weapons mounts, it is a versatile assault platform. \n\n<b>Prerequisites:</b> Fighter Design, Anubis. \n\n<b>Armaments:</b> Vasudan Laser, Rockeye Missiles.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_horus",
		RequiredResearch = "FighterDesign",
		RequiredShipSubSystems = "",
		DisplayPriority = 1,
		DisplayedName = "GVF Horus - Interceptor <c=12AB06>32s</c>",
		Description =
		"<b>Description:</b> The GVF Horus was the fastest fighter class during the Great War and it's still the fastest fighter in the GTVA fleet. Its weapon capacity is average for a fighter, with four primary banks and two missile bays. The Horus pays for its speed and maneuverability with thin armor and relatively weak shields. The Horus shines as a bomber interceptor, a role Allied Command puts it in as often as possible. For offensive operations against well-defended targets, however, the Horus is a poor choice. \n\n<b>Prerequisites:</b> Fighter Design, Horus. \n\n<b>Armaments:</b> 2x Prometheus S, 2x GTW ML-70 Morning Star, 1x GTM-55 Trebuchet, 1x GTM-MX64 Rockeye.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_thoth",
		RequiredResearch = "Thoth",
		RequiredShipSubSystems = "",
		DisplayPriority = 4,
		DisplayedName = "GVF Thoth - Superiority <c=12AB06>36s</c>",
		Description =
		"<b>Description:</b> The GVF Thoth has been manufactured exclusively in the Sahr Corp.'s shipyards at Altair for over 40 years. During the heyday of the Hammer of Light, the HoL captured these yards and the Thoth became a primary fighter among HoL forces. When these shipyards were recaptured, the Thoth once again became an important component of the Vasudan navy. In the hands of a skilled pilot, the Thoth's maneuverability and small size make it a hard target to hit. A single missile bank means that a Thoth pilot relies on his primary weapons to make most kills. \n\n<b>Prerequisites:</b> Fighter Design, Thoth. \n\n<b>Armaments:</b> 4x Mekhu HL-7 (Rapid Fire), 2x GTM-19 Harpoon.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_serapis",
		RequiredResearch = "Serapis & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 2,
		DisplayedName = "GVF Serapis - Adv. Interceptor <c=12AB06>40s</c>",
		Description =
		"<b>Description:</b> Fast and highly maneuverable, the GVF Serapis is primarily used as a bomber interceptor. Its thin armor and weak shields give it a low survival rate in dogfights against more heavily armored fighters. Despite having only two primary and secondary weapon banks, the Serapis has been retrofitted to accommodate almost any loadout in the GTVA arsenal. Veteran Vasudan pilots love the Serapis for its agility and loadout options. \n\n<b>Prerequisites:</b> Fighter Design, Serapis. \n\n<b>Armaments:</b> 2x GTW-66 Maxim, 2x Mekhu HL-7 , 1x GTM-19 Harpoon, 1x GTM-14 EMP Advanced (Upgrade).",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_tauret",
		RequiredResearch = "Tauret & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 8,
		DisplayedName = "GVF Tauret - Heavy Assault <c=12AB06>49s</c>",
		Description =
		"<b>Description:</b> While integrating cutting-edge technology developed in collaboration with the Terrans, the Tauret boasts a distinctly Vasudan design. Its unusual configuration was inspired by the Apsu-Hek, a creature that once inhabited the deserts of Vasuda Prime. The Apsu-Hek has become an emblem of the Vasudan diaspora, and the Tauret continues the tradition of symbolic design. Armed with six gun mounts and two large missile banks, the Tauret has the speed and firepower to challenge both fighters and warships. \n\n<b>Prerequisites:</b> Fighter Design, Tauret. \n\n<b>Armaments:</b> 4x GTW-5 Prometheus S, 2x UD-8 Kayser, 2x GTM-MX64 Rockeye, 2x GTM-4a Tornado",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_osiris",
		RequiredResearch = "BomberDesign",
		RequiredShipSubSystems = "",
		DisplayPriority = 101,
		DisplayedName = "GVB Osiris - Reserve Bomber <c=12AB06>40s</c>",
		Description =
		"<b>Description:</b> The GVB Osiris was the primary bomber of the PVN during the Great War. It is showing its age during the current conflict, as the more advanced Bakha and Sekhmet bombers have replaced it on the front lines in most theatres of conflict. Osiris bombers still in service have been retrofitted to make them compatible with most GTVA missiles and bombs. If well-protected by fighter escorts, a wing of Osiris bombers can still wreak havoc on enemy cruisers and corvettes. \n\n<b>Prerequisites:</b> Bomber Design, Osiris. \n\n<b>Armaments:</b> 2x Prometheus R (2x Prometheus S turret), 1x GTM-12 Cyclops, 1x GTM-10 Pihrana (Upgrade)",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_bakha",
		RequiredResearch = "Bakha & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 105,
		DisplayedName = "GVB Bakha - Strike Bomber <c=12AB06>34s</c>",
		Description =
		"<b>Description:</b> Learning a lesson from the bomber losses of the Great War, Vasudan defense contractor Akheton designed the GVB Bakha, a fast, agile bomber that could still deliver a warship-shattering payload. The Bakha's dual Akh-12 engines are baffled and masked, giving it a small profile for heat-seeking missiles. The bomber's speed and maneuverability make it the craft of choice for taking out destroyers and corvettes with multiple flak, AAA, and anti-ship beam turrets. Over 6,000 Bakhas have been produced in the orbiting shipyards around Vasuda Prime. \n\n<b>Prerequisites:</b> Bomber Design, Bakha. \n\n<b>Armaments:</b> 2x Mekhu HL-7, 2x GTW Akheton SDG, 1x GTM-12 Cyclops, 1x GTM 43a Stiletto II (Upgrade)",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_sehkmet",
		RequiredResearch = "Sehkmet & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 106,
		DisplayedName = "GVB Sehkmet - Heavy Bomber <c=12AB06>46s</c>",
		Description =
		"<b>Description:</b> The GVB Sekhmet is a Shivan design that was initially adapted to Vasudan needs by Hammer of Light engineers. The version currently in use was further modified by technicians at Mekhu Enterprises. Sporting four primary weapon banks and three missile/bomb bays, the Sekhmet packs a massive punch. Add in a top speed that surpasses that of some fighters and an ultra-fast molybdenum armor plating, and it's easy to see why the Sekhmet is the favorite bomber among Vasudan pilots. \n\n<b>Prerequisites:</b> Bomber Design, Sehkmet. \n\n<b>Armaments:</b> 4x Prometheus S, 1x GTM-13 Helios, 1x GTM-11 Infyrno (Upgrade).",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_amun",
		RequiredResearch = "Amun & FS1",
		RequiredShipSubSystems = "",
		DisplayPriority = 107,
		DisplayedName = "PVB Amun - Heavy Bomber <c=12AB06>50s</c>",
		Description =
		"<b>Description:</b> The PVB Amun is the primary heavy bombing platform of the Vasudan fleet during the Great War (FS1). Packing extremely thick molybdenum armor, it can absorb enormous defensive fire while delivering devastating payloads to enemy warships. Though slow and lacking agility, the Amun's multiple missile and bomb bays make it a feared weapon on any capital ship battleline. \n\n<b>Prerequisites:</b> Bomber Design, Amun. \n\n<b>Armaments:</b> 2x Prometheus R, 2x GTM-12 Cyclops, 1x GTM-10 Pihrana.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_aten",
		RequiredResearch = "CruiserDesign & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 220,
		DisplayedName = "GVC Aten - Reserve Cruiser <c=12AB06>30s</c>",
		Description =
		"<b>Description:</b> The GVC Aten is among the smallest and weakest of the GTVA's cruiser classes, with thin armor and only a few, relatively weak turrets. Terran fighters and bombers exploited these weaknesses during the early years of the Great War, when the Terran and Vasudans were still enemies. The Aten is most often seen in the current conflict as a rear guard defense for convoys or installations, backing up wings of fighters and bombers. \n\n<b>Prerequisites:</b> Cruiser Design \n\n<b>Armaments:</b> 4x Turret, 2x Mekhu HL-7 Turret, 2x Anti-Fighter Beam (Upgrade)",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_aten_fs1",
		RequiredResearch = "CruiserDesign & FS1",
		RequiredShipSubSystems = "",
		DisplayPriority = 220,
		DisplayedName = "GVC Aten (FS1) - Reserve Cruiser <c=12AB06>30s</c>",
		Description =
		"<b>Description:</b> The GVC Aten is among the smallest and weakest of the GTVA's cruiser classes, with thin armor and only a few, relatively weak turrets. Terran fighters and bombers exploited these weaknesses during the early years of the Great War, when the Terran and Vasudans were still enemies. The Aten is most often seen in the current conflict as a rear guard defense for convoys or installations, backing up wings of fighters and bombers. \n\n<b>Prerequisites:</b> Cruiser Design \n\n<b>Armaments:</b> 4x Turret, 2x Mekhu HL-7 Turret, 2x Vasudan Laser.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_mentu",
		RequiredResearch = "Mentu & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 225,
		DisplayedName = "GVC Mentu - Advanced Cruiser <c=12AB06>70s</c>",
		Description =
		"<b>Description:</b> The GVC Mentu cruiser is the lightest of the new Vasudan warships. Following the Great War, allied scientists developed the beam cannons that now serve as the primary armaments of today's GTVA warships. Rather than modify existing ships, the Vasudans developed new designs to mount these weapons. The Mentu's 16 turrets include heavy beam cannons for duking it out with other warships, as well as AAA and flak turrets to fend off smaller craft. \n\n<b>Prerequisites:</b> Cruiser Design, Mentu. \n\n<b>Armaments:</b> 2x Light Beam, 1x Anti-Fighter Beams, 1x Flak Turret, 2x Huge Turret, 10x Turret.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_sobek",
		RequiredResearch = "Sobek & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 300,
		DisplayedName = "GVCv Sobek - Corvette <c=12AB06>110s</c>",
		Description =
		"<b>Description:</b> Design of the GVCv Sobek began in the dark days after the destruction of Vasuda Prime by the Shivans in the Great War. The Vasudan navy wanted a vessel that could single-handedly counter powerful Shivan cruisers and provide critical support to Vasudan destroyers in battles against Shivan capital ships. The Sobek class fills those requirements admirably. Bristling with almost two dozen turrets, these corvettes are a terror to all vessels of cruiser size and below, while presenting a dire threat even to ships far larger than themselves. \n\n<b>Prerequisites:</b> Capital Ship Design, Sobek. \n\n<b>Armaments:</b> 2x Slashing Beam, 4x Anti-Fighter Beam, 4x Flak Turret, 4x Huge Turret, 8x Turret.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_typhon",
		RequiredResearch = "CapitalShipDesign & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 310,
		DisplayedName = "GVD Typhon - Destroyer <c=12AB06>175s</c>",
		Description =
		"<b>Description:</b> The GVD Typhon was the height of Vasudan military technology when it appeared to face Terran forces during the early days of the Terran-Vasudan War. The first Typhon was sighted at the Vega Engagement and quickly destroyed the GTD Eisenhower and much of the 4th fleet. The more recent Hatshepsut class of destroyers is larger and wields a deadlier array of armaments, but the Typhon is still a match for almost any foe. Up to 30 wings of fighters or bombers can be housed within its docking bays, ready to engage at a moment's notice. \n\n<b>Prerequisites:</b> Capital Ship Design, Typhon. \n\n<b>Armaments:</b> 2x Heavy Beam, 2x Anti-Fighter Beam, 5x Flak Turret, 4x Harpoon Missile Launcher, 5x Huge Turret, 9x Turret.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_typhon_fs1",
		RequiredResearch = "CapitalShipDesign & FS1",
		RequiredShipSubSystems = "",
		DisplayPriority = 310,
		DisplayedName = "GVD Typhon (FS1) - Destroyer <c=12AB06>175s</c>",
		Description =
		"<b>Description:</b> The GVD Typhon was the height of Vasudan military technology when it appeared to face Terran forces during the early days of the Terran-Vasudan War. The first Typhon was sighted at the Vega Engagement and quickly destroyed the GTD Eisenhower and much of the 4th fleet. The more recent Hatshepsut class of destroyers is larger and wields a deadlier array of armaments, but the Typhon is still a match for almost any foe. Up to 30 wings of fighters or bombers can be housed within its docking bays, ready to engage at a moment's notice. \n\n<b>Prerequisites:</b> Capital Ship Design, Typhon. \n\n<b>Armaments:</b> 2x Heavy Turret, 5x Flak Turret, 4x Harpoon Missile Launcher, 5x Huge Turret, 11x Turret.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_hatshepsut",
		RequiredResearch = "Hatshepsut & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 330,
		DisplayedName = "GVD Hatshepsut - Destroyer <c=12AB06>240s</c>",
		Description =
		"<b>Description:</b> In 2360, Allied Command commissioned the first of the GVD Hatshepsut-class destroyers. The Vasudan contractor Akheton designed the Hatshepsut to efficiently integrate the new beam cannon. Though a handful of modified Typhons remain in service, the Hatshepsut has taken over as the primary Vasudan destroyer. With 26 turrets, 4 beam cannons, and 2 fighterbays, destroyers such as GVD Psamtik of Deneb's 13th Battle Group serve at the vanguard of the modern Vasudan fleet. \n\n<b>Prerequisites:</b> Capital Ship Design, Hatshepsut. \n\n<b>Armaments:</b> 3x Heavy Beam, 1x Light Beam, 4x Anti-Fighter Beam, 11x Flak Turret, 6x Huge Turret, 5x Flux Torpedo.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_hatshepsut_fs1",
		RequiredResearch = "SuperCapitalShipDesign & FS1",
		RequiredShipSubSystems = "",
		DisplayPriority = 331,
		DisplayedName = "GVD Hatshepsut (FS1) - Flagship <c=12AB06>240s</c>",
		Description =
		"<b>Description:</b> The Great War (FS1) variant of the GVD Hatshepsut class flagship, commissioned to serve as the ultimate Vasudan command ship during the conflict against the Shivans. Lacking the beam technology of the later reconstruction era, this massive vessel relies on an extensive network of heavy kinetic turrets, rapid-fire lasers, flak guns, and blue flux torpedoes. It is a direct match for the heaviest Terran and Shivan capital threats. \n\n<b>Prerequisites:</b> Capital Ship Design, Hatshepsut (FS1). \n\n<b>Armaments:</b> 3x Heavy Turret, 1x Light Turret, 4x Rapid Laser, 11x Flak Turret, 6x Huge Turret, 5x Flux Torpedo.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_colossus",
		RequiredResearch = "Juggernaut & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 340,
		DisplayedName = "GTVA Colossus <c=12AB06>500s</c>",
		Description =
		"<b>Description:</b> The GTVA Colossus resulted from an endeavor unprecedented in Terran or Vasudan history. This 6-kilometer-long behemoth is the result of 20 years of joint effort from dozens of contractors of both races. The Colossus is the most powerful space-faring warship ever made, bristling with over 60 weapon turrets. It also houses 60 fighter and bomber wings and requires a crew of over 30,000. The firepower of the Colossus is greater than that of most GTVA battle groups. \n\n<b>Prerequisites:</b> Super Capital Ship Design, Colossus. \n\n<b>Armaments:</b> 13x Heavy Beam, 10x Anti-Fighter Beam, 8x Flak Turret, 2x Piranha Missile Launcher, 10x Huge Turret, 20x Turret.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_isis",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 500,
		DisplayedName = "GVT Isis - Collector <c=12AB06>25s</c>",
		Description =
		"<b>Description:</b> The GVT Isis is most often used as a military personnel transport but also occasionally serves as a repair ship or even a tugboat, helping to maneuver large vessels into docking bays. Two cannon turrets and thick molybdenum plating serve to protect its cargo. Magnetic cargo locks located on the Isis's undercarriage enable it to transport small cargo containers of supplies and munitions in emergencies. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> None.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_anuket",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 501,
		DisplayedName = "GVG Anuket - Drop-off <c=12AB06>30s</c>",
		Description =
		"<b>Description:</b> The GVG Anuket was originally designed for resource extraction in the volatile environment of gas giants. More recently, the Anuket has been modified for nebular operations. The Anuket has the most sophisticated sensor array available, enabling it to navigate the intense EM maelstroms of supernova remnants. In the nebula, the Anuket plays two important roles. First, the miner collects samples for scientific analysis and serves as a laboratory for field experiments. Second, the Anuket gathers deuterium-rich gas for use in the fusion drives that power the allied fleet. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> 2x Turret, 2x Mekhu Turret, 1x Flak Turret.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_satis",
		RequiredResearch = "RepairSatis & FS1",
		RequiredShipSubSystems = "",
		DisplayPriority = 511,
		DisplayedName = "GVFr Satis - Repair <c=12AB06>35s</c>",
		Description =
		"<b>Description:</b> When the first Satis-class freighter was encountered by Terran forces during the Terran-Vasudan War, its firepower led Terran Command to classify it as a light cruiser. Only after a disabled Satis was captured did its true nature become known. Now designated the GVFr Satis class, these freighters still serve as an iron fist within the velvet glove of a freighter convoy. Few enemy fighters who mistake a Satis for a Ma'at or Bes live to regret their error. \n\n<b>Prerequisites:</b> Repair Satis. \n\n<b>Armaments:</b> 5x Turret, Capture ability (Upgrade)",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_bes",
		RequiredResearch = "SentryAndMineDeployer",
		RequiredShipSubSystems = "",
		DisplayPriority = 512,
		DisplayedName = "GVFr Bes - Sentry Builder <c=12AB06>25s</c>",
		Description =
		"<b>Description:</b> For the past 20 years, the GVFr Bes has been the mainstay of Vasudan shipping fleets. While some Terran systems languished in the post-war era, the Vasudans experienced an economic recovery that was miraculous, given the annihilation of their home planet. Experts credit the policies of the restored Imperial government that emerged following Khonsu II's dissolution of the Vasudan parliament. As commerce among the Vasudan systems resumed and expanded into Terran worlds, a new generation of space-faring cargo vessels was required to meet the needs of this burgeoning economy. \n\n<b>Prerequisites:</b> Sentry and Mine Deployer. \n\n<b>Armaments:</b> 2x Turret.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_maat",
		RequiredResearch = "SentryAndMineDeployer & FS1",
		RequiredShipSubSystems = "",
		DisplayPriority = 310,
		DisplayedName = "PVFr Ma'at - Sentry Builder <c=12AB06>30s</c>",
		Description =
		"<b>Description:</b> With three turrets, the Ma'at is a hairy target for GTA pilots to attack. However, it is slow enough that it can be destroyed with enough patience. As always, supply ships for the PVN are considered to be valid targets. \n\n<b>Prerequisites:</b> Sentry and Mine Deployer. \n\n<b>Armaments:</b> 3x Turret.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_edjo",
		RequiredResearch = "SentryGun",
		RequiredShipSubSystems = "",
		DisplayPriority = 513,
		DisplayedName = "GVSG Edjo - Sentry Gun <c=12AB06>6s</c>",
		Description =
		"<b>Description:</b> When the GTVA asked the Vasudan navy to upgrade the Great War-era Ankh sentry gun platform, the GVSG Edjo was the Vasudans' answer. The Edjo has significantly more armor plating than the Ankh, improving its survivability, but the Vasudans placed only one small cannon turret on the new platform, giving it half the punch of the Ankh. After seeing the Edjo, the Terrans quietly began developing their own advanced sentry gun platforms. The Vasudan navy seems content to leave this aspect of military technology to the Terrans. \n\n<b>Prerequisites:</b> Sentry Gun. \n\n<b>Armaments:</b> 2x Mekhu.",
	},
	{
		Type = Ship,
		ThingToBuild = "ter_mjolnir",
		RequiredResearch = "BeamSentry & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 515,
		DisplayedName = "GTSG Mjolnir - Beam Cannon <c=12AB06>120s</c>",
		Description =
		"<b>Description:</b> The GTSG Mjolnir is the most advanced sentry gun device known. The Mjolnir mounts a single, powerful beam cannon and can do heavy damage to enemy warships before they come in range. Mjolnirs are also referred to as RBCs (remote beam cannons). They are used to help protect the most vital front-line Alliance installations. \n\n<b>Prerequisites:</b> Beam Sentry. \n\n<b>Armaments:</b> 1x Mjolnir Beam.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_setekh",
		RequiredResearch = "AWACS & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 515,
		DisplayedName = "GVA Setekh - AWACS <c=12AB06>78s</c>",
		Description =
		"<b>Description:</b> The GVA Setekh is the Vasudan class of AWACS vessels, comparable to the Terran GTA Charybdis class. Setekhs are smaller, less heavily armored, and have half the turrets of Charybdis ships. Despite these shortcomings, the Vasudan navy insists upon deploying Setekhs in Vasudan battle groups, claiming the Vasudan versions are more appropriate for their fleets. Setekhs' crystalline detection arrays provide their fleets with doubled radar range within the nebular region. Every Vasudan battle group operating in this theatre has a wing of Setekhs attached to it. \n\n<b>Prerequisites:</b> AWACS. \n\n<b>Armaments:</b> 3x Turret.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_nephthys",
		RequiredResearch = "FighterDesign & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 502,
		DisplayedName = "GVS Nephthys - Support Ship <c=12AB06>9s</c>",
		Description =
		"<b>Description:</b> The GVS Nephtys is the Vasudans' new support ship. It is fast and maneuverable, a necessity when trying to dock with fighters in the heat of battle. Mekhu Enterprises built a cargo bay into the rear of the ship, enabling it to carry extra supplies and munitions during emergencies. Mekhu Enterprises licensed the GTS Hygeia's magnetic-stasis delivery system from Triton Dynamics, so both ships are equally adept at re-supplying combat craft with missiles and bombs. The high number of warheads carried by the Nephtys makes it a dangerous ship to be near when it blows up. \n\n<b>Prerequisites:</b> Fighter Design. \n\n<b>Armaments:</b> None.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_geb",
		RequiredResearch = "",
		RequiredShipSubSystems = "",
		DisplayPriority = 514,
		DisplayedName = "PVNB Geb - Sensor Bouy <c=12AB06>20s</c>",
		Description =
		"<b>Description:</b> Long range sensor device. Can be deployed to a specific location once after construction. \n\n<b>Prerequisites:</b> None. \n\n<b>Armaments:</b> None.",
	},


	{
		Type = Ship,
		ThingToBuild = "vas_bast",
		RequiredResearch = "RepairBast & FS2",
		RequiredShipSubSystems = "",
		DisplayPriority = 311,
		DisplayedName = "PVFr Bast - Repair Frigate <c=12AB06>22s</c>",
		Description =
		"<b>Description:</b> The Bast is a support frigate. It is primarily used for repairing allied vessels, but can be used for other support roles. \n\n<b>Prerequisites:</b> Repair Bast. \n\n<b>Armaments:</b> None.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_ankh",
		RequiredResearch = "SentryGun",
		RequiredShipSubSystems = "",
		DisplayPriority = 513,
		DisplayedName = "PVSG Ankh - Sentry  Gun <c=12AB06>4s</c>",
		Description =
		"<b>Description:</b> The Ankh is the standard Vasudan sentry gun. Its most common usage is guarding supply depots. However, since the development of the Anubis, its usage has dropped off significantly. \n\n<b>Prerequisites:</b> Sentry Gun. \n\n<b>Armaments:</b> 2x Turret.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_scarab",
		RequiredResearch = "FighterDesign & FS1",
		RequiredShipSubSystems = "",
		DisplayPriority = 313,
		DisplayedName = "PVS Scarab - Support Ship <c=12AB06>9s</c>",
		Description =
		"<b>Description:</b> The Scarab is very similar to our Centaur: We believe the Vasudans stole the design of this ship from us. It is used for in flight rearming of fighters and bombers. In longer engagements, these ships can mean the difference between victory and defeat. The major difference between this ship and the Centaur is that the Scarab is unmanned. \n\n<b>Prerequisites:</b> Fighter Design. \n\n<b>Armaments:</b> None.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_imhotep",
		RequiredResearch = "ScienceVessel",
		RequiredShipSubSystems = "",
		DisplayPriority = 314,
		DisplayedName = "PVSC Imhotep - Science Vessel <c=12AB06>35s</c>",
		Description =
		"<b>Description:</b> The PVSC Imhotep is a state-of-the-art deep space laboratory and research vessel. Designed to maximise adaptability, the Imhotep's modular laboratories can be quickly reconfigured with scientific equipment suited to the task at hand. Since less laboratory space is required, internal volume is freed up on the lower decks for a small podbay housing four remote research pods. Not unexpectedly, Imhotep class vessels are poorly armed and fragile, requiring assiduous protection if they should ever be found in a battle zone. \n\n<b>Prerequisites:</b> Science Vessel. \n\n<b>Armaments:</b> 2x Turret, 2x Avenger, 1x Fighterkiller.",
	},
	{
		Type = Ship,
		ThingToBuild = "vas_karnak",
		RequiredResearch = "Installation",
		RequiredShipSubSystems = "",
		DisplayPriority = 312,
		DisplayedName = "PVI Karnak - Installation <c=12AB06>200s</c>",
		Description =
		"<b>Description:</b> The gargantuan Karnak installation is the Vasudans' answer to the GTI Arcadia.  This monstrous facility bristles with dozens of turrets and can house up to two full squadrons of fighters.  Its primary purpose is to serve as a construction and maintenance yard for the Vasudan fleets. \n\n<b>Prerequisites:</b> Installation. \n\n<b>Armaments:</b> 20x Turret, 17x Fighterkiller.",
	},
}
