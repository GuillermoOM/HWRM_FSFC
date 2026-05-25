-- Dynamic Ambient Music Player for FreeSpace: Fleet Command.
-- This script manages the ambient music playlist during the match.
-- Native FMOD threat-based crossfading is handled automatically by the HWRM engine
-- using the randomized default/battle music registered in the level files.

m_timer = 0
kickoff = 0

if (MUS_Ambient == nil) then
	MUS_Ambient = 0
end

-------------------------------------------------------------------------------
-- Plays the selected music track.
--
function PlayMusicRule(track_title, typeIndex)
	local playType = typeIndex or MUS_Ambient
	Sound_MusicPlayType(track_title, playType)
end

-------------------------------------------------------------------------------
-- FS2 Ambient Music Rule
--
function RandomMusicRuleFS2()
	local PlayList = {
		"data:sound/music/fs2_aquitaine",
		"data:sound/music/fs2_brief1",
		"data:sound/music/fs2_brief2",
		"data:sound/music/fs2_brief3",
		"data:sound/music/fs2_brief4",
		"data:sound/music/fs2_brief5",
		"data:sound/music/fs2_exodus",
		"data:sound/music/fs2_genesis",
		"data:sound/music/fs2_leviticus",
		"data:sound/music/fs2_menu",
		"data:sound/music/fs2_revelation",
	}
	-- Time of each track in 1/10 s
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

	if kickoff == 0 then
		kickoff = 1
		randNum = random(getn(PlayList))
		track_title = PlayList[randNum]
		track_length = LengthList[randNum]
		PlayMusicRule(track_title, MUS_Ambient)
		print("Playing initial FS2 track: " .. track_title .. " (" .. track_length .. "s)")
	end

	m_timer = m_timer + 0.5

	if m_timer > track_length then
		randNum = random(getn(PlayList))
		track_title = PlayList[randNum]
		track_length = tonumber(LengthList[randNum])
		PlayMusicRule(track_title, MUS_Ambient)
		m_timer = 0
		print("Playing next FS2 track: " .. track_title .. " (" .. track_length .. "s)")
	end
end

-------------------------------------------------------------------------------
-- FS1 Ambient Music Rule
--
function RandomMusicRuleFS1()
	local PlayList = {
		"data:sound/music/fs1_brief1",
		"data:sound/music/fs1_brief2",
		"data:sound/music/fs1_chaser",
		"data:sound/music/fs1_fortress",
		"data:sound/music/fs1_haunted",
		"data:sound/music/fs1_marauder",
		"data:sound/music/fs1_march",
		"data:sound/music/fs1_menu",
		"data:sound/music/fs1_monolith",
		"data:sound/music/fs1_spook",
		"data:sound/music/fs1_strike",
		"data:sound/music/fs1_threat",
		"data:sound/music/fs1_worldsapart",
		"data:sound/music/fs1_worldsapartalt",
	}
	-- Time of each track in 1/10 s
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

	if kickoff == 0 then
		kickoff = 1
		randNum = random(getn(PlayList))
		track_title = PlayList[randNum]
		track_length = LengthList[randNum]
		PlayMusicRule(track_title, MUS_Ambient)
		print("Playing initial FS1 track: " .. track_title .. " (" .. track_length .. "s)")
	end

	m_timer = m_timer + 0.5

	if m_timer > track_length then
		randNum = random(getn(PlayList))
		track_title = PlayList[randNum]
		track_length = tonumber(LengthList[randNum])
		PlayMusicRule(track_title, MUS_Ambient)
		m_timer = 0
		print("Playing next FS1 track: " .. track_title .. " (" .. track_length .. "s)")
	end
end
