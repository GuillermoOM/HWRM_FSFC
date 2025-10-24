LoadingScreen = {
	size = {0, 0, 800, 600},
	stylesheet = "HW2StyleSheet",
	
	-- Flags
	pixelUVCoords = 1, -- Enter pixel coords for texture coords
	
	RootElementSettings = {
		backgroundColor = {0,0,0,255}, -- black background for letterbox effect
	},
	
	onShow = [[
		-- pass number of background pics to random(X) function
		UI_SetElementVisible("LoadingScreen", "background"..random(5), 1)

		quotations = {
			---=== Tactical Tips ===---
			{"Tactical Tip",		"Subspace nodes decrease the cost to make jumps, and ships can travel between nodes without Navigation or a Jump Charge."},
			{"Tactical Tip",		"Interceptors are armed with a loadout that makes them excellent at taking down bombers."},
			{"Tactical Tip",		"Superiority fighters excel in manuverability, resulting in superb performance against most fighters."},
			{"Tactical Tip",		"Assault fighters can take down targets from fighters and bombers to cruisers."},
			{"Tactical Tip",     		"Strike bombers can be armed with Stiletto missiles to knock out subsystems from a distance."},
			{"Tactical Tip",             	"Advanced cruisers mount the latest in death-dealing beam cannons, flak, and antifighter beams."},
			{"Tactical Tip",             	"Heavy cruisers have heavy armor and can outlast other types of cruisers easily in a firefight."},
			{"Tactical Tip",           	"Larger ships recharge their jump engines more slowly than smaller ones. Shivan Subspace Mastery research speeds up the recharge."},
			{"Tactical Tip",              	"Cargo depots can yield a very high volume of RU's quickly, but are sometimes defended by sentry guns."},
			{"Tactical Tip",		"The Subach HL-7 and Mekhu HL-7 are supreme dogfighting weapons."},
			{"Tactical Tip",		"The Prometheus S's shield crushing power allows it to take down bombers with ease."},
			{"Tactical Tip",		"The Prometheus R (Retrofit) cannon is specialized to shred cruiser hulls."},
			{"Tactical Tip",		"Inspired by Shivan weaponry, the UD-8 Kayser is the most powerful primary weapon."},
			{"Tactical Tip",     		"Use the Maxim cannon to snipe turrets off ships from long range."},
			{"Tactical Tip",             	"Trebuchet missiles have an exceptional range to hit bombers or turrets for a safe distance."},
			{"Tactical Tip",             	"Try defending your expand with Mjolnir Remote Beam Cannons to give your opponent something to think about."},
			{"Tactical Tip",           	"Remember to build AWACS vessels increase your situational awareness in a nebula."},
			{"Tactical Tip",              	"Argo or Satis class ships can be upgraded to capture ships, but Shivan ships cannot be captured - they are disabled instead."},
			{"Tactical Tip",              	"Ships cannot engage their Subspace drives while being captured."},
			{"Tactical Tip",		"Disable your opponent's communications to stop them from building additional warships."},
			{"Tactical Tip",		"Knock out the fighterbays to stop your opponent from building and repairing strike craft."},
			{"Tactical Tip",             	"Larger vessels can have their Navigation subsystem destroyed, prohibiting Subspace jumps until it is repaired."},
			{"Tactical Tip",             	"When a ship loses Engines, it may no longer move, and it stops charging its subspace drive while disabled."},
			{"Tactical Tip",             	"Damaging sensors on an enemy warship limits their line of sight until the subsystem is repaired."},
			{"Tactical Tip",             	"Weapons subsystems are responsible for fire control. Taking out enemy weapons reduces both accuracy and damage significantly."},
			{"Tactical Tip",             	"Cruisers can bring their subsystems back online quickly. Larger ships require more time."},
			{"Tactical Tip",             	"Most fighters and bombers have an afterburner- giving them a few seconds of greatly increased speed."},
			{"Tactical Tip",             	"Corvettes can be upgraded with Sprint drives, allowing their Subspace drives to charge much more quickly."},
			{"Tactical Tip",		"Shivan ships have a natural advantage with cheaper subspace jumps, and can further improve them through research."},
			{"Tactical Tip",     		"The GTD Orion has a different set of fighters it can build compared to the GTD Hecate."},
			{"Tactical Tip",             	"The GVD Typhon only needs Medium photon beam tech to be constructed."},
			{"Tactical Tip",             	"The Maxim cannon can knock out turrets, but the Ankheton SDG and Stiletto II missiles can take out most subsystems more effectively."},
			{"Tactical Tip",     		"The Flail rifle and GTW-70 Morning Star are kinetic weapons; they knock enemy fighters and bombers out of formation, disrupting them."},
			{"Tactical Tip",             	"The GTW-19 Circe and the GTW-99 Shield Breaker are highly effective against Fighters and Bombers, vaporizing their shields, but are useless against larger targets."},
			{"Tactical Tip",             	"The GTW-83 Lamprey and GTW-43 Leech cannon shut down engines and weapons of fighters and bombers, much like the EMP missile."},
			{"Tactical Tip",             	"Interceptors are capable of shooting down bombs. They will automatically shoot down bombs when ordered to guard friendly warships."},
			{"Tactical Tip",             	"EMP missiles temporarily disable targets caught in the blast radius. They also destroy all bombs within the blast."},
			{"Tactical Tip",             	"Some Hammer of Light ships are loaded with bombs and can be used as kamikaze craft."},
			{"Tactical Tip",             	"Stiletto and Stiletto II Bombs have a shielded warhead, and are more resistant to being shot down compared to other bombs."},
			{"Tactical Tip",             	"Use Support Ships to repair friendly fighters in the field and to increase their damage."},
			{"Tactical Tip",             	"The SCv Moloch, the Shivan Corvette, is capable of holding a small number of craft in its fighterbay."},
			{"Tactical Tip",             	"The GTM-10 Pihrana deploys fifteen smaller missiles that seek and destroy enemy fighters and bombers."},
			{"Tactical Tip",             	"The GTM-11 Infyrno bomb creates a massive field of fire, pulverizing formations of fighters and bombers."},
			{"Tactical Tip",             	"In the Freespace 1 era, Science vessels are required to unlock advanced weaponry research for Fighters and Bombers."},
			{"Tactical Tip",             	"Slashing beams do heavy damage, but are innacurate against smaller vessels."},
			{"Tactical Tip",             	"Ships have two alternate sensor ranges; visual range is short and reveals concealed targets. Secondary sensors pick up large targets like Destroyers from long range."},
			{"Tactical Tip",             	"Silent Threat era games unlock the GTF Loki, GTB Zeus, GTD Hades, PVB Sekhmet, SF Gorgon, and SB Seraphim ships."},
			{"Tactical Tip",             	"Support Ships and Resource Drop-Offs have a larger than normal explosion for ships of their size."},
			{"Tactical Tip",             	"Ships are immobilized when they are being boarded, and at 50% capture they can no longer fire weapons."},
			{"Tactical Tip",             	"Defensive AWACS Electonic Warfare will help conceal your fleet against prying enemy eyes."},
			{"Tactical Tip",             	"Offensive AWACS Electonic Warfare will jam enemy targeting, reducing their accuracy."},
			{"Tactical Tip",             	"A fighter's shields will start to regenerate after they are out of combat."},
			{"-Alpha 3, 53rd Hammerheads", 	"Why did we attack the Iceni? Why did we destroy that cargo? I can live with being a pawn if the game makes sense!"},
			{"-Lt. Commander Snipes",        "What, do I look Shivan to you?"},
			{"-Lt. Commander Snipes",        "Outstanding job. Most pilots fly only one suicide mission."},
			{"-Lt. Commander Snipes",	"Of course that's if they don't hang us for failing the mission. We might be pushing our luck here, but what the hell."},
			{"-Admiral Petrarch",		"This is our Alamo, pilots. We hold them here, or we die trying."},
			{"-Zeta 4, 107th Ravens",	"Don't kid yourself pilot. We're the ones being hunted."},
			{"-Allied Command",		"Avoid the beams and you won't get hit, pilot."},
			{"Colossus briefing",    	"The Colossus is the most powerful space faring warship ever constructed. Spanning 6 kilometres from bow to stern, the Colossus has taken over 20 years to complete."},
			{"-Admiral Bosch",        	"Your efforts to intercept us have failed, pilots. You would be well advised to question the wisdom of your leaders. Helm, engage subspace drive."},
			{"-Admiral Bosch",             	"How close did we come to being a footnote in the history of a future species, that would happen upon our ruins 10,000 years from now?"},
			{"-Admiral Bosch",           	"And like the 9 cities of Troy, each civilization had been built on the rubble of one that came before, each annihilated by the Shivans."},
			{"-Admiral Bosch",              	"Ignorance is the greatest weapon of tyranny and old wounds open all too easily."},
			{"-Admiral Bosch",		"And so I will play my role to the bloody end. I have given the Lost Generation something to die for, and now my legacy will be crowned with infamy."},
			{"-Admiral Bosch",		"Why does the ancient portal lead us here? Have the Shivans been waiting for us for thousands of years?"},
			{"-Admiral Bosch",		"This odyssey, this exodus. Do we journey toward the promised land, or into the valley of the kings?"},
			{"-Admiral Bosch",     		"I must find the Destroyers that lurk behind this veil of clouds, or I must wait for the Destroyers to find me."},
			{"-Admiral Bosch",             	"Our encounter with the Shivans has vindicated all I have fought for these past thirty years. My life's work has been achieved."},
			{"-Admiral Bosch",             	"Although our first contact was rudimentary and crude, I have initiated the first phase of a new alliance with the Destroyers, an alliance upon which the fate of humanity depends."},
			{"-Admiral Bosch", 		"On this day, for the first time in my life, I am filled with joy."},
			{"-GVCv Nebtuu",           	"We die for nothing if we do not win the day. Avenge us!"},
			{"-Shakespeare",     	   	"There are more things in heaven and earth, than are dreamt of in your philosiphies."},
			{"-Admiral Koth, NTD Repulse",   "Your cynisism appalls me, Colossus, I have 10,000 officers and crew willing to die for Neo-Terra!"},
			{"-Lt. Commander Snipes",        "Those detonators were a piece of junk.  I even followed the directions."},
			{"-NTCv Belisarius CO",          "Your posturing insults us both, Vasudan! I will NOT give up my ship!"},
			{"-GVD Psamtik",			"Belisarius, you are ordered to power down and surrender."},
			{"-Allied Command",		"Kappa wing, this is Allied Command. Please respond."},
			{"-Arthur Romeig, NTC Trinity",	"This is captain Arthur Romeig of the GTC Trinity. We have sustained heavy damage and our jump drive is inoperative. We need immediate assistance."},
			{"-Zeta 1, 107th Ravens",    	"There's gotta be a base, or destroyer out here somewhere. These fighters couldn't survive out here on their own."},
			{"-GTCv Actium CO",             	"The Shivans fought nothing but Great War relics. We'll show them what firepower is all about."},
			{"-GTFr Calypso",             	"NTF fighters, you are firing on a civillian vessel, break off your attack!"},
			{"-GTVA Colossus", 		"Admiral Koth, you are ordered to power down your vessel immediately and surrender. The Polaris jump node is blockaded, there is no escape."},
			{"-GTVA Colossus",           	"Monitor, you are relieved. Great job holding down the Knossos, Captain."},
			{"-Alpha 2, 203rd Scorpions",    "You must order the Phonecia to withdraw, Command, the Destroyer will not survive the engagement!"},
			{"-GTD Phonecia CO",        	"This is the Phonecia, we've got a hull breach on 12 decks, 25% of our crew is down. Authorization or not, we're getting out of here Command."},
			{"-Victor 3, NTF Iceni Boarding party",             	"We've entered a slaughterhouse command. Casualties are in the thousands. Shivan bodies are among the dead. Proceeding to deck 7."},
			{"-GVD Psamtik",			"Affirmative, Sathanas configuration. I repeat, Sathanas configuration."},
			{"-Lt. Rusk, NTF Iceni",		"The Shivans boarded us, they killed everyone! I've got 33 survivors on deck 7, there's got to be more below."},
			{"-Lt. Rusk, NTF Iceni",		"LISTEN TO ME! Bosch initiated the self-destruct sequence, we only have a few minutes left!"},
			{"-Beta 1, 70th Blue Lions",    	"You call that a fleet, Command? We could use some more help out here!"},
			{"-Allied Command",             	"1000 meters to go. 30 seconds and counting."},
			{"-GVD Psamtik CO",             	"At 0345 hours, the GTVA Colossus destroyed the Shivan Juggernaut Sathanas near the Gamma Draconis Jump node in Capella."},
			{"-GVD Psamtik CO", 		"This victory proves without a doubt our technological superiority over our great war nemesis."},
			{"-GVD Psamtik CO",           	"For the second time, the Alliance defeated a species which has annihilated entire civilizations across the galaxy. With the Colossus, we will have nothing more to fear."},
			{"And we subdued it or we crushed it. With subspace, our empire would surely know no boundaries.",             	"And we discovered subspace. It gave us our galaxy and it gave us the universe. And we saw other advanced life."},
			{"-Ancients",             	"Only these were not like the others. They did not die. We made our first retreat. We could forgo one system. We left it to the Destroyers and went elsewhere. But they followed."},
			{"-Ancients", 			"We believed at home we would be safe, for they are not a terrestrial species. We know when we entered subspace we were trespassers. But our planet is our home, and yet still they came, and our world is gone."},
			{"-Ancients",           		"When we conquered and colonized in galaxies where we had no place, the destruction and the anguish and the loss were the clarion call of our doom, and so the Destroyers came for us."},
			{"-Ancients",           		"The Destroyers that darkened our skies like a plague can be harmed. But we have no way to deliver the hurt. We have the knowledge, but not the means."},
			{"I'm told we can expect them again, but not in my lifetime ... such is liberation.",        "We learned how to survive, and so we did. All the jump points from Earth are gone, but the Shivans can rebuild them."},
			{"Now we forge a new alliance to guard the tomb of space, and to find within its cold expanse the salvation of our race.",        	"They say our people have no present, only a past filled with horror, and a future they can only dream of"},
			{"- Someone",        	"The Shivans vanished half a lifetime ago. And now we live in the mosoleum of history. We inherit the legacy of ghosts who haunt these ruins. The elders call us the lost generation."},
			{"Of children who saw in the embers of dying stars the destiny of their race. And they hurled themselves into the void of space with no fear.",        	"I remember stories of a glorious civilization. Of cities with spires that reached the sun. The blue planet with vast seas. Of people with myths of humanity everlasting."},
				
}
		
		local randomInteger = random(getn(quotations))
		UI_SetTextLabelText("LoadingScreen", "quotation1", quotations[randomInteger][2])
		UI_SetTextLabelText("LoadingScreen", "quotation2", quotations[randomInteger][1])
		
	]],
	
	;
	
	-- background pics
	-- naming must be "background"..i, starting with 1. Increment the parameter of the random function in the onShow section above, otherwise the new pics won't show up.
	-- aspect ratio is 2:1, crop your pics and save your pics as DXT1 without mipmaps(!)
	{
		type = "Frame",
		name = "background1",
		visible = 0,
			Layout = {
				pos_XY = { x = 0, y = 0.15, xr = "par", yr = "par" },
				size_WH = { w = 1, h = 0.7, wr = "par", hr = "par" },
			},
		BackgroundGraphic = {
			size = { 0, 0 },
			texture = "DATA:UI/NewUI/Background/sexyshivan.tga",
			textureUV = { 0, 0, 1920, 960, },
		},
	},
	{
		type = "Frame",
		name = "background2",
		visible = 0,
			Layout = {
				pos_XY = { x = 0, y = 0.15, xr = "par", yr = "par" },
				size_WH = { w = 1, h = 0.7, wr = "par", hr = "par" },
			},
		BackgroundGraphic = {
			size = { 0, 0 },
			texture = "DATA:UI/NewUI/Background/sexyterrans.tga",
			textureUV = { 0, 0, 1920, 960, },
		},
	},
	{
		type = "Frame",
		name = "background3",
		visible = 0,
			Layout = {
				pos_XY = { x = 0, y = 0.15, xr = "par", yr = "par" },
				size_WH = { w = 1, h = 0.7, wr = "par", hr = "par" },
			},
		BackgroundGraphic = {
			size = { 0, 0 },
			texture = "DATA:UI/NewUI/Background/sexytoth.tga",
			textureUV = { 0, 0, 1920, 960, },
		},
	},
	{
		type = "Frame",
		name = "background4",
		visible = 0,
			Layout = {
				pos_XY = { x = 0, y = 0.15, xr = "par", yr = "par" },
				size_WH = { w = 1, h = 0.7, wr = "par", hr = "par" },
			},
		BackgroundGraphic = {
			size = { 0, 0 },
			texture = "DATA:UI/NewUI/Background/sexyravana.tga",
			textureUV = { 0, 0, 1920, 960, },
		},
	},
	{
		type = "Frame",
		name = "background5",
		visible = 0,
			Layout = {
				pos_XY = { x = 0, y = 0.15, xr = "par", yr = "par" },
				size_WH = { w = 1, h = 0.7, wr = "par", hr = "par" },
			},
		BackgroundGraphic = {
			size = { 0, 0 },
			texture = "DATA:UI/NewUI/Background/sexydeimos.tga",
			textureUV = { 0, 0, 1920, 960, },
		},
	},
	
	
	-- border for background pic
	{
		type = "Frame",
		visible = 0,
		position = {0, 96},
		size = {800, 400},
		outerBorderWidth = 1,
		borderColor = { 175, 120, 50, 255},
		backgroundColor = {0,0,0,0},
	},
	
	

	-- loading bar
	{
		type = "Frame",
		visible = 1,
		position = { 0, 450 },
		size = { 800, 128 },
		name = "bgImage",

		;
			

		
		-- progress
		{
			type = "ProgressBar",
			
			Layout = {
				pos_XY = { x = 0.5, y = 0.1, xr = "par", yr = "par" },
				size_WH = { w = 1000, h = 32, wr = "px", hr = "px" },
				pivot_XY = { 0.5, 0.5 },
			},

			progressColor = {240, 170, 0, 255},
			name = "loadingProgress",
				
			filledTextColor			= {235,235,192,255},
			emptyTextColor			= {101,198,194,255},
				
			Text = 
			{
				font = "ButtonFont",
				dropShadow = 1,
				pixels = 24,
				vAlign = "Middle",
				hAlign = "Center",
				rel=0,
			},
				
			frameOfs = { 0.0, 16/64 },
			frameCells = { 0, 1, 2, 3 },
				
			frameArt = {
				size = {0, 0},
				texture = "DATA:UI\\NewUI\\Styles\\Progress_Lines.dds",
				uvRect = { 2/128, 2/128, 62/128, 30/128 },
				patch_X = { 8, -18, 8, -18, 8, 0 },
				patch_Y = { 13, -2, 13, 0 },
				patch_Scale = 1,
				--patch_AutoScale = 1,
				
				Surface = {
					surface = "ui_multistate";
					{ prop = "state0", float3 = { 0.0, 0.0, 1.0 } },
					{ prop = "state1", float3 = { 0.0, 0.0, 0.0 } },
					{ prop = "state2", float3 = { 0.0, 0.0, 0.0 } },
					{ prop = "decal", float3 = { 0.0, 0.0, 0.0 } },
				},
			},
				
			coreOfs = { 0.0, 32/128 },
			coreCells = { 0, 1, 2, 3 },
				
			coreArt = {
				size = {0, 0},
				texture = "DATA:UI\\NewUI\\Styles\\Progress_Lines.dds",
				uvRect = { 66/128, 2/128, 126/128, 30/128 },
				patch_X = { 12, -36, 12, 0 },
				patch_Y = { 6, -2, 4, -4, 4, -2, 6, 0 },
				patch_Scale = 1,
				patch_AutoScale = 1,
					
				fill = "DATA:UI\\NewUI\\Styles\\Fill_DotNoise01.tga",
				
				Surface = {
					surface = "ui_multistate";
					{ prop = "state0", float3 = { 0.0, 0.0, 1.0 } },
					{ prop = "state1", float3 = { 0.0, 0.0, 0.0 } },
					{ prop = "state2", float3 = { 0.0, 0.0, 0.0 } },
					{ prop = "decal", float3 = { 0.0, 0.0, 0.0 } },
				},
			},
		},
	},
	{
		type = "Frame",
		name = "logo",
		visible = 1,
		position = { 0, 40, },
		size = { 200, 50, },
		BackgroundGraphic = {
			size = { 200, 50, },
			texture = "DATA:UI/NewUI/Background/load_logo.tga",
			textureUV = { 0, 0, 500, 125, },
		},
	},

	
	-- text label for printing current module
	{
		type = "TextLabel",
		name = "moduleLabel",
		position = {0, 550},
		size = {800, 50},
		Text = {
			textStyle = "FEButtonTextStyle",
			color = {255,255,255,255},
			vAlign = "Middle",
			hAlign = "Center",
		},
	},
	
	
	-- text labels for random quotations
	{
		type = "TextLabel",
		name = "quotation1",
		position = {0, 520},
		size = {800, 20},
		Text = {
			textStyle = "FEButtonTextStyle",
			color = { 240, 240, 240, 255}, 
			vAlign = "Middle",
			hAlign = "Center",
		},
	},
	{
		type = "TextLabel",
		name = "quotation2",
		position = {0, 540},
		size = {800, 20},
		Text = {
			textStyle = "FEButtonTextStyle",
			color = { 240, 240, 240, 255}, 
			vAlign = "Middle",
			hAlign = "Center",
		},
	},
	
	
	-- text label for campaign title1
	{
		type = "TextLabel",
		name = "titleLabel1",
		visible = 0,
		size = {800, 50},
		Text = {
			textStyle = "FEButtonTextStyle",
			color = {255,255,255,255},
			vAlign = "Middle",
			hAlign = "Left",
		},
	},
	-- text label for campaign title2
	{
		type = "TextLabel",
		name = "titleLabel2",
		position = {0, 50},
		size = {800, 50},
		visible = 0,
		Text = {
			textStyle = "FEButtonTextStyle",
			color = {255,255,255,255},
			vAlign = "Middle",
			hAlign = "Left",
		},
	},

}