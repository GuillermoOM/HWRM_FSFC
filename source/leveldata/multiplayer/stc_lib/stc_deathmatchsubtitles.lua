-- Deathmatch Subtitles
-- icon         : Icon to use for this subtitle (see DATA:/UI/Subtitle.lua)
-- welcome      : Message that appears at game start
-- welcome_time : The welcome message will be shown this long (in seconds)
-- victory      : Message that appears at victory
-- victory_time : The victory message will be shown this long (in seconds)
-- defeat       : Message that appears at defeat
-- defeat_time  : The defeat message will be shown this long (in seconds)

subtitles_deathmatch_default = { -- default subtitle item
	icon         = 1,
	welcome      = "Welcome Commander! Press F9 to toggle the experience overlay.",
	welcome_time = 3,
	victory      = "Victory!",
	victory_time = 3,
	defeat       = "We have been Defeated",
	defeat_time  = 3,
}

subtitles_deathmatch = {}
subtitles_deathmatch[1] = subtitles_deathmatch_default -- Hiigaran
subtitles_deathmatch[2] = subtitles_deathmatch_default -- Vaygr
subtitles_deathmatch[3] = { -- Federation
	icon         = 13,
	welcome      = "Welcome Captain! Press F9 to toggle the experience overlay.",
	welcome_time = 3,
	victory      = "Victory!",
	victory_time = 3,
	defeat       = "We have been Defeated",
	defeat_time  = 3,
}
subtitles_deathmatch[4] = { -- Klingon
	icon         = 14,
	welcome      = "Welcome Commander! Press F9 to toggle the experience overlay. Qapla'!",
	welcome_time = 3,
	victory      = "We are Victorious!",
	victory_time = 3,
	defeat       = "Defeat!",
	defeat_time  = 3,
}
subtitles_deathmatch[5] = subtitles_deathmatch_default -- Random (placeholder)
subtitles_deathmatch[6] = { -- Romulan
	icon         = 15,
	welcome      = "Welcome Centurion! Press F9 to toggle the experience overlay.",
	welcome_time = 3,
	victory      = "Victory for the Preator!",
	victory_time = 3,
	defeat       = "Defeated!",
	defeat_time  = 3,
}
subtitles_deathmatch[7] = subtitles_deathmatch_default -- Auxiliary


Events = {}
Events.STC_gameStart = 
{
	{
		-- start event, black out screen, activate letterbox
		{ "Sound_EnterIntelEvent()", "" },
		{ "Universe_Fade(1.0, 0)", "" },
		{ "Camera_SetLetterboxStateNoUI(1, 0)", "" },
	},
	{
		-- disable any player commands
		{ "Universe_EnableSkip(0)", "" },
		{ "Camera_AllowControl(0)", "" },
		{ "Camera_UsePanning(0)", "" },
		{ "Universe_AllowPlayerOrders(0)", "" },
	},
	{
		-- fade from black to letterbox
		{ "Universe_Fade(0.0, 0.5)", "" },
		{ "wID = Wait_Start( 0.5 )", "Wait_End( wID )" },
	},
	{
		-- display welcome message
		{ "Subtitle_Add(subtitles_deathmatch[currentPlayer_race].icon, subtitles_deathmatch[currentPlayer_race].welcome, subtitles_deathmatch[currentPlayer_race].welcome_time)", "" },
		{ "wID = Wait_Start( subtitles_deathmatch[currentPlayer_race].welcome_time + 0.5 )", "Wait_End( wID )" },
	},
	{
		-- reendable player commands
		{ "Camera_AllowControl(1)", "" },
		{ "Camera_UsePanning(1)", "" },
		{ "Universe_AllowPlayerOrders(1)", "" },
	},
	{
		-- end event, disable letterbox
		{ "Sound_ExitIntelEvent()", "" },
		{ "Camera_SetLetterboxStateNoUI(0, 2)", "" },
		{ "wID = Wait_Start( 2 )", "Wait_End( wID )" },
	},
}
Events.STC_victory = 
{
	{
		-- disable any player commands
		{ "Universe_EnableSkip(0)", "" },
		{ "Camera_AllowControl(0)", "" },
		{ "Camera_UsePanning(0)", "" },
		{ "Universe_AllowPlayerOrders(0)", "" },
	},
	{
		-- activate letterbox
		{ "Camera_SetLetterboxStateNoUI(1, 2)", "" },
		{ "wID = Wait_Start( 2 )", "Wait_End( wID )" },
	},
	{
		-- display victory message
		{ "Subtitle_Add(subtitles_deathmatch[currentPlayer_race].icon, subtitles_deathmatch[currentPlayer_race].victory, subtitles_deathmatch[currentPlayer_race].victory_time)", "" },
		{ "wID = Wait_Start( subtitles_deathmatch[currentPlayer_race].victory_time )", "Wait_End( wID )" },
	},
	{
		-- end game
		{ "setGameOver()", "" },
	},
}
Events.STC_defeat = 
{
	{
		-- disable any player commands
		{ "Universe_EnableSkip(0)", "" },
		{ "Camera_AllowControl(0)", "" },
		{ "Camera_UsePanning(0)", "" },
		{ "Universe_AllowPlayerOrders(0)", "" },
	},
	{
		-- activate letterbox
		{ "Camera_SetLetterboxStateNoUI(1, 2)", "" },
		{ "wID = Wait_Start( 2 )", "Wait_End( wID )" },
	},
	{
		-- display defeat message
		{ "Subtitle_Add(subtitles_deathmatch[currentPlayer_race].icon, subtitles_deathmatch[currentPlayer_race].defeat, subtitles_deathmatch[currentPlayer_race].defeat_time)", "" },
		{ "wID = Wait_Start( subtitles_deathmatch[currentPlayer_race].defeat_time )", "Wait_End( wID )" },
	},
	{
		-- end game
		{ "setGameOver()", "" },
	},
}
