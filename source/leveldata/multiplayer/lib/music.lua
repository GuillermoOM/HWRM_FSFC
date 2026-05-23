-- These functions are called and will play random tracks from the selection. When combat starts, they'll switch to
-- "Combat Intro" music, play combat music as long as fighting happens, then switch to combat outro music and resume
-- the ambient playlist. By Tempest. NOTE THAT IN REMASTERED, TIMES ARE IN 1/20 s, NOT 1/10 s
playedBin = {}
m_timer = 0
c_timer = 0
kickoff = 0
incombat = 0
--the Music type tells us which type of track is currently being played. 0 is ambient, 1 is combat,
--2 is enemy arrival (start of combat), and 3 is friendly arrival (end of combat)
musictype = 0
--this is how long we wait before deciding to switch tracks, to make sure it's not too abrupt. Again, in 1/20 s.
timeout_threshold = 50

if (MUS_Ambient == nil) then
	MUS_Ambient = 0
end
if (MUS_Staging == nil) then
	MUS_Staging = 1
end
if (MUS_Battle == nil) then
	MUS_Battle = 2
end

function RandomMusicRuleFS2()
	-- first we define our playlist and the length of each track.
	local PlayList = {
		"Data:sound/music/fs2_aquitaine",
		"Data:sound/music/fs2_brief1",
		"Data:sound/music/fs2_brief2",
		"Data:sound/music/fs2_brief3",
		"Data:sound/music/fs2_brief4",
		"Data:sound/music/fs2_brief5",
		"Data:sound/music/fs2_exodus",
		"Data:sound/music/fs2_genesis",
		"Data:sound/music/fs2_leviticus",
		"Data:sound/music/fs2_menu",
		"Data:sound/music/fs2_revelation",
	}
	--This is the time of each track, in 1/10 s
	local LengthList = {
		1280,
		610,
		570,
		430,
		950,
		480,
		610,
		620,
		350,
		1360,
		280,
	}
	local CombatList = {
		"Data:sound/music/battle/fs2_deuteronomybattle",
		"Data:sound/music/battle/fs2_exodusbattle",
		"Data:sound/music/battle/fs2_genesisbattle",
		"Data:sound/music/battle/fs2_joshuabattle",
		"Data:sound/music/battle/fs2_leviticusbattle",
		"Data:sound/music/battle/fs2_numbersbattle",
		"Data:sound/music/battle/fs2_revelationbattle",
	}

	local CombatLengthList = {
		1670,
		2340,
		2090,
		1620,
		1700,
		1740,
		2130,
	}
	local FList = {
		"Data:sound/music/friendly/fs2_F1",
		"Data:sound/music/friendly/fs2_F2",
	}

	local FLengthList = {
		40,
		60,
	}
	local EList = {
		"Data:sound/music/enemy/fs2_E1",
		"Data:sound/music/enemy/fs2_E2",
		"Data:sound/music/enemy/fs2_E3",
		"Data:sound/music/enemy/fs2_E4",
		"Data:sound/music/enemy/fs2_E5",
		"Data:sound/music/enemy/fs2_E6",
		"Data:sound/music/enemy/fs2_E7",
		"Data:sound/music/enemy/fs2_E8",
		"Data:sound/music/enemy/fs2_E9",
		"Data:sound/music/enemy/fs2_E10",
		"Data:sound/music/enemy/fs2_E11",
	}

	local ELengthList = {
		90,
		90,
		70,
		70,
		70,
		150,
		80,
		100,
		70,
		80,
		180,
	}

	--the first time we call this script, we have to generate our first track title/length and play it
	if kickoff == 0 then
		kickoff = 1
		randNum = random(getn(PlayList))
		track_title = PlayList[randNum]
		track_length = LengthList[randNum]
		PlayMusicRule(track_title, MUS_Ambient)
		print("Playing initial track with track title: " .. track_title .. " and track length: " .. track_length .. ".")
	end
	--the clock now tells us what is going on with the gamespace.
	Rule_clock()
	--If we're not fighting right now, and the last song we played was calm too.
	if incombat == 0 and (musictype == 0 or musictype == 3) then
		--Once we've reached the end of our track, we generate a new track, play it, and reset our timer to 0.
		if m_timer > track_length then
			randNum = random(getn(PlayList))
			track_title = PlayList[randNum]
			track_length = tonumber(LengthList[randNum])
			PlayMusicRule(track_title, MUS_Ambient)
			m_timer = 0
			musictype = 0
			print(
				"Now continuing ambient music with track title: "
					.. track_title
					.. " and track length: "
					.. track_length
					.. "."
			)
		end
	elseif incombat == 0 and musictype == 1 then
		--We're no longer in combat, so switch to happy music before returning to ambient.
		--WE FORCE THIS CHANGE EVEN IF THE CURRENT TRACK IS STILL PLAYING
		randNum = random(getn(FList))
		track_title = FList[randNum]
		track_length = tonumber(FLengthList[randNum])
		PlayMusicRule(track_title, MUS_Ambient)
		m_timer = 0
		musictype = 3
		print(
			"Now playing victory music with track title: "
				.. track_title
				.. " and track length: "
				.. track_length
				.. "."
		)
	elseif incombat == 1 and (musictype == 1 or musictype == 2 or musictype == 3) then
		--We're still in combat, so play a new combat track.
		if m_timer > track_length then
			randNum = random(getn(CombatList))
			track_title = CombatList[randNum]
			track_length = tonumber(CombatLengthList[randNum])
			PlayMusicRule(track_title, MUS_Battle)
			m_timer = 0
			musictype = 1
			print(
				"Now continuing battle music with track title: "
					.. track_title
					.. " and track length: "
					.. track_length
					.. "."
			)
		end
	elseif incombat == 1 and musictype == 0 then
		--We're now in combat, so play the appopriate enemy arrival music.
		randNum = random(getn(EList))
		track_title = EList[randNum]
		track_length = tonumber(ELengthList[randNum])
		PlayMusicRule(track_title, MUS_Battle)
		m_timer = 0
		musictype = 2
		print(
			"now playing combat start music with track title: "
				.. track_title
				.. " and track length: "
				.. track_length
				.. "."
		)
	end
end

function RandomMusicRuleFS1()
	-- function created by Mikail, EvilleJedi, modified by Bacchi
	-- first we define our playlist and the length of each track.
	local PlayList = {
		"Data:sound/music/fs1_brief1",
		"Data:sound/music/fs1_brief2",
		"Data:sound/music/fs1_chaser",
		"Data:sound/music/fs1_fortress",
		"Data:sound/music/fs1_haunted",
		"Data:sound/music/fs1_marauder",
		"Data:sound/music/fs1_march",
		"Data:sound/music/fs1_menu",
		"Data:sound/music/fs1_monolith",
		"Data:sound/music/fs1_spook",
		"Data:sound/music/fs1_strike",
		"Data:sound/music/fs1_threat",
		"Data:sound/music/fs1_worldsapart",
		"Data:sound/music/fs1_worldsapartalt",
	}

	local LengthList = {
		1260,
		1650,
		840,
		1090,
		2420,
		2300,
		1900,
		2330,
		1650,
		1770,
		2020,
		4210,
		1140,
		1160,
	}
	local CombatList = {
		"Data:sound/music/battle/fs1_chaserbattle",
		"Data:sound/music/battle/fs1_fortressbattle",
		"Data:sound/music/battle/fs1_hauntedbattle",
		"Data:sound/music/battle/fs1_marauderbattle",
		"Data:sound/music/battle/fs1_marchbattle",
		"Data:sound/music/battle/fs1_monolithbattle",
		"Data:sound/music/battle/fs1_spookbattle",
		"Data:sound/music/battle/fs1_strikebattle",
		"Data:sound/music/battle/fs1_threatbattle",
		"Data:sound/music/battle/fs1_worldsapartbattle",
	}

	local CombatLengthList = {
		1100,
		1110,
		940,
		1700,
		850,
		2180,
		950,
		1190,
		1600,
		1430,
	}
	local FList = {
		"Data:sound/music/friendly/fs1_chaserF1",
		"Data:sound/music/friendly/fs1_chaserF2",
		"Data:sound/music/friendly/fs1_fortressF1",
		"Data:sound/music/friendly/fs1_fortressF2",
		"Data:sound/music/friendly/fs1_hauntedF1",
		"Data:sound/music/friendly/fs1_hauntedF2",
		"Data:sound/music/friendly/fs1_marauderF1",
		"Data:sound/music/friendly/fs1_marauderF2",
		"Data:sound/music/friendly/fs1_marchF1",
		"Data:sound/music/friendly/fs1_marchF2",
		"Data:sound/music/friendly/fs1_monolithF1",
		"Data:sound/music/friendly/fs1_monolithF2",
		"Data:sound/music/friendly/fs1_spookF1",
		"Data:sound/music/friendly/fs1_spookF2",
		"Data:sound/music/friendly/fs1_strikeF1",
		"Data:sound/music/friendly/fs1_strikeF2",
		"Data:sound/music/friendly/fs1_threatF1",
		"Data:sound/music/friendly/fs1_threatF2",
		"Data:sound/music/friendly/fs1_worldsapartF1",
		"Data:sound/music/friendly/fs1_worldsapartF2",
	}

	local FLengthList = {
		90,
		70,
		80,
		70,
		100,
		90,
		160,
		160,
		100,
		70,
		80,
		70,
		100,
		100,
		80,
		70,
		130,
		130,
		60,
		80,
	}
	local EList = {
		"Data:sound/music/enemy/fs1_chaserE1",
		"Data:sound/music/enemy/fs1_chaserE2",
		"Data:sound/music/enemy/fs1_fortressE1",
		"Data:sound/music/enemy/fs1_fortressE2",
		"Data:sound/music/enemy/fs1_hauntedE1",
		"Data:sound/music/enemy/fs1_hauntedE2",
		"Data:sound/music/enemy/fs1_marauderE1",
		"Data:sound/music/enemy/fs1_marauderE2",
		"Data:sound/music/enemy/fs1_marchE1",
		"Data:sound/music/enemy/fs1_marchE2",
		"Data:sound/music/enemy/fs1_monolithE1",
		"Data:sound/music/enemy/fs1_monolithE2",
		"Data:sound/music/enemy/fs1_spookE1",
		"Data:sound/music/enemy/fs1_spookE2",
		"Data:sound/music/enemy/fs1_strikeE1",
		"Data:sound/music/enemy/fs1_strikeE2",
		"Data:sound/music/enemy/fs1_threatE1",
		"Data:sound/music/enemy/fs1_threatE2",
		"Data:sound/music/enemy/fs1_worldsapartE1",
		"Data:sound/music/enemy/fs1_worldsapartE2",
	}

	local ELengthList = {
		90,
		40,
		80,
		70,
		110,
		80,
		160,
		160,
		110,
		70,
		80,
		60,
		100,
		100,
		80,
		70,
		150,
		130,
		70,
		90,
	}

	--the first time we call this script, we have to generate our first track title/length and play it
	if kickoff == 0 then
		kickoff = 1
		randNum = random(getn(PlayList))
		track_title = PlayList[randNum]
		track_length = LengthList[randNum]
		PlayMusicRule(track_title, MUS_Ambient)
		print("Playing initial track with track title: " .. track_title .. " and track length: " .. track_length .. ".")
	end
	--the clock now tells us what is going on with the gamespace.
	Rule_clock()
	--If we're not fighting right now, and the last song we played was calm too.
	if incombat == 0 and (musictype == 0 or musictype == 3) then
		--Once we've reached the end of our track, we generate a new track, play it, and reset our timer to 0.
		if m_timer > track_length then
			randNum = random(getn(PlayList))
			track_title = PlayList[randNum]
			track_length = tonumber(LengthList[randNum])
			PlayMusicRule(track_title, MUS_Ambient)
			m_timer = 0
			musictype = 0
			print(
				"Now continuing ambient music with track title: "
					.. track_title
					.. " and track length: "
					.. track_length
					.. "."
			)
		end
	elseif incombat == 0 and musictype == 1 then
		--We're no longer in combat, so switch to happy music before returning to ambient.
		--WE FORCE THIS CHANGE EVEN IF THE CURRENT TRACK IS STILL PLAYING
		randNum = random(getn(FList))
		track_title = FList[randNum]
		track_length = tonumber(FLengthList[randNum])
		PlayMusicRule(track_title, MUS_Ambient)
		m_timer = 0
		musictype = 3
		print(
			"Now playing victory music with track title: "
				.. track_title
				.. " and track length: "
				.. track_length
				.. "."
		)
	elseif incombat == 1 and (musictype == 1 or musictype == 2 or musictype == 3) then
		--We're still in combat, so play a new combat track.
		if m_timer > track_length then
			randNum = random(getn(CombatList))
			track_title = CombatList[randNum]
			track_length = tonumber(CombatLengthList[randNum])
			PlayMusicRule(track_title, MUS_Battle)
			m_timer = 0
			musictype = 1
			print(
				"Now continuing battle music with track title: "
					.. track_title
					.. " and track length: "
					.. track_length
					.. "."
			)
		end
	elseif incombat == 1 and musictype == 0 then
		--We're now in combat, so play the appopriate enemy arrival music.
		randNum = random(getn(EList))
		track_title = EList[randNum]
		track_length = tonumber(ELengthList[randNum])
		PlayMusicRule(track_title, MUS_Battle)
		m_timer = 0
		musictype = 2
		print(
			"now playing combat start music with track title: "
				.. track_title
				.. " and track length: "
				.. track_length
				.. "."
		)
	end
end

-------------------------------------------------------------------------------
-- Plays the selected music track.
--
function PlayMusicRule(track_title, typeIndex)
	local playType = typeIndex or MUS_Ambient
	Sound_MusicPlayType(track_title, playType)
end

function Rule_clock()
	Playernum = FE_GetCurrentPlayerIndex()
	--If we're in combat, increment the timer. If we pass a threshold, we'll turn incombat to 1, which should switch the music to an appropriately aggressive selection.
	if SobGroup_UnderAttack("Player_Ships" .. Playernum) == 1 and incombat == 0 then
		c_timer = c_timer + 0.5
		--print("I think we're now in combat")
		if c_timer >= 1.0 then
			incombat = 1
			c_timer = 0
			--print("Incombat variable has been set to 1")
		end
	elseif SobGroup_UnderAttack("Player_Ships" .. Playernum) == 0 and incombat == 1 then
		--We were in combat, but nobody's under attack, so party's over
		c_timer = c_timer + 0.5
		--print("I think we're not in combat anymore")
		if c_timer >= 200 then
			c_timer = 0
			incombat = 0
			--print("Incombat variable has been set to 0")
		end
	else
		c_timer = 0
	end
	m_timer = m_timer + 0.5
	--print("Music timer at: "..m_timer)
end
