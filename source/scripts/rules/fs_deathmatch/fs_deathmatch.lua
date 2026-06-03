dofilepath("data:scripts/SCAR/SCAR_Util.lua")
dofilepath("data:scripts/scar/restrict.lua")
dofilepath("data:leveldata/multiplayer/lib/lib.lua")
dofilepath("data:leveldata/multiplayer/lib/crates.lua")
dofilepath("data:leveldata/multiplayer/lib/relics.lua")
dofilepath("data:leveldata/multiplayer/lib/challenges.lua")
dofilepath("data:leveldata/multiplayer/lib/norushtime.lua")
dofilepath("data:leveldata/multiplayer/lib/research.lua")

-- Override vanilla research_init to prevent it from force-granting restricted/pre-managed era nodes
function fsfc_research_init()
	local playerIndex = 0
	local isAI = 0
	local grantThis = 1
	for playerIndex = 0, Universe_PlayerCount() - 1, 1 do
		if Player_IsAlive(playerIndex) == 1 then
			if Player_HasShipWithBuildQueue(playerIndex) == 1 then
				isAI = Player_GetLevelOfDifficulty(playerIndex)
				Player_RestrictBuildOption(
					playerIndex,
					PlayerRace_GetString(playerIndex, "dm_allresearch_build_restrict", "")
				)
				research = nil

				dofilepath(PlayerRace_GetString(playerIndex, "path_research", ""))

				for z, iCount in research do
					grantThis = 1

					if iCount.DoNotGrant ~= nil then
						grantThis = 0
					end
					if (iCount.AIOnly ~= nil) and (isAI <= 0) then
						grantThis = 0
					end
					if (iCount.HumanOnly ~= nil) and (isAI > 0) then
						grantThis = 0
					end
					
					-- Era nodes FS1 and FS2 are programmatically managed by the match settings.
					-- Granting them via All Research Granted will conflict with the chosen Era and cause engine errors.
					if (iCount.Name == "FS1" or iCount.Name == "FS2") then
						grantThis = 0
					end

					if grantThis == 1 then
						Player_GrantResearchOption(playerIndex, iCount.Name)
					end
				end
				Subtitle_Message_Handler("$14760", 2, "data:sound\\sfx\\ui\\frontend\\CHATMESSAGERECEIVED", playerIndex)
			end
		end
	end
	Rule_Remove("fsfc_research_init")
end
dofilepath("data:leveldata/multiplayer/lib/ruinjections.lua")
dofilepath("data:leveldata/multiplayer/lib/bounties.lua")
dofilepath("data:leveldata/multiplayer/lib/cpuplayers.lua")
dofilepath("data:leveldata/multiplayer/lib/ui.lua")
dofilepath("data:leveldata/multiplayer/lib/dev.lua")
dofilepath("data:leveldata/multiplayer/lib/main.lua")
dofilepath("data:leveldata/multiplayer/lib/carriersonly.lua")
dofilepath("data:leveldata/multiplayer/lib/nocruisers.lua")
dofilepath("data:leveldata/multiplayer/lib/strikecraftgamemode.lua")
dofilepath("data:leveldata/multiplayer/lib/music.lua")
dofilepath("data:scripts/scar/fsfc_ui.lua")

function OnInit()
	Volume_AddSphere("centre", { -11111, 11111, 11111 }, 10)
	Rule_Add("Rule_GrantEraBySetting")
	MPRestrict()
	nocruisers = GetGameSettingAsNumber("nocruisers")
	strikecraftgamemode = GetGameSettingAsNumber("strikecraftgamemode")
	cpuplayers = GetGameSettingAsNumber("cpuplayers")
	bounties = GetGameSettingAsNumber("bounties")
	research = GetGameSettingAsNumber("research")
	ruinjections = GetGameSettingAsNumber("ruinjections")
	challenges = GetGameSettingAsNumber("challenges")
	relics = GetGameSettingAsNumber("relics")
	crates = GetGameSettingAsNumber("crates")
	carriersonly = GetGameSettingAsNumber("carriersonly")
	norushtime = GetGameSettingAsNumber("norushtime")
	era_setting = GetGameSettingAsNumber("era")  -- 0: FS1, 1: FS2, 2: Both
	carriersonly = GetGameSettingAsNumber("carriersonly")
	resources = GetGameSettingAsNumber("resources") -- starting resources

	-- Suffix priority
	local suffix = ""
	if (carriersonly == 1) then
		suffix = "carriersonly"
	elseif (carriersonly == 2) then
		suffix = "carriersonly1"
	elseif (era_setting == 0) then
		suffix = "fs1"
		RandomMusicRuleFS1()
		Rule_Add("RandomMusicRuleFS1")
	elseif (era_setting == 1) then
		suffix = "fs2"
		RandomMusicRuleFS2()
		Rule_Add("RandomMusicRuleFS2")
	else
		RandomMusicRuleFS2()
		Rule_Add("RandomMusicRuleFS2")
	end
	SetStartFleetSuffix(suffix)

	if (carriersonly > 0) then
		Rule_AddInterval("carriersonly_init", 2)
	end

	UI_SetElementEnabled("NewTaskbar", "btnObjectives", 0)
	UI_SetElementEnabled("NewTaskbar", "btnRecall", 0)
	UI_SetElementEnabled("NewTaskbar", "btnBuild", 0)
	UI_SetElementEnabled("NewTaskbar", "btnResearch", 0)
	UI_SetElementEnabled("NewTaskbar", "btnLaunch", 0)

	if norushtime > 0 then
		UI_TimerStop("NewTaskbar", "GameTimer")
	end

	Rule_AddInterval("timer_updating", 1.02) --timed with doai
end

timer_timing = 1
timer_interval = 5.1

function timer_updating()
	if timer_timing == 1 then
		for playerIndex = 0, Universe_PlayerCount() - 1, 1 do
			if Player_IsAlive(playerIndex) == 1 then
				if Player_HasShipWithBuildQueue(playerIndex) == 1 then
					local restrictString = PlayerRace_GetString(playerIndex, "dm_build_restrict", "")
					if restrictString ~= "" then
						Player_RestrictBuildOption(playerIndex, restrictString)
					end

					-- Era-based ship hiding for FS races
					local racePrefix = strsub(PlayerRace_GetString(playerIndex, "Prefix", ""), 1, 3)
					if (racePrefix == "TER" or racePrefix == "VAS" or racePrefix == "SHI") then
						if (era_setting == 0) then -- FS1 Only
							local fs2_ships_to_hide = {
								"ter_herculesmk2", "ter_perseus", "ter_myrmidon", "ter_ares", "ter_erinyes","ter_alastor",
								"ter_artemis", "ter_artemisdh", "ter_boanerges", "ter_aeolus", "ter_deimos",
								"ter_hecate", "ter_colossus", "ter_mjolnir", "ter_charybdis", "ter_pegasus",
								"ter_hygeia", "ter_argo", "ter_fenris", "ter_leviathan", "ter_orion", "ter_ulysses",
								"ter_medusa", "ter_ursa", "ter_iceni", "ter_zeus",
								"vas_ptah", "vas_serapis", "vas_tauret", "vas_bakha", "vas_sehkmet", "vas_mentu",
								"vas_sobek", "vas_hatshepsut", "vas_colossus", "vas_setekh", "vas_nephthys", "vas_bast",
								"vas_aten", "vas_typhon", "vas_bes",
								"shi_mara", "shi_aeshma", "shi_nahema", "shi_taurvi",
								"shi_seraphim", "shi_rakshasa", "shi_ravana", "shi_moloch", "shi_sathanas",
								"shi_gorgon", "shi_astaroth", "shi_cain", "shi_lilith", "shi_demon"
							}
							for i, ship in fs2_ships_to_hide do
								Player_RestrictBuildOption(playerIndex, ship)
							end
						elseif (era_setting == 1) then -- FS2 Only
							local fs1_ships_to_hide = {
								"ter_apollo", "ter_valkyrie", "ter_athena", "ter_cerberus", "ter_chronos","ter_centaur",
								"ter_fenris_fs1", "ter_leviathan_fs1", "ter_orion_fs1", "ter_ulysses_fs1",
								"ter_medusa_fs1", "ter_ursa_fs1",
								"vas_seth", "vas_thoth", "vas_scarab", "vas_aten_fs1", "vas_typhon_fs1","vas_hatshepsut_fs1", "vas_amun", "vas_anubis", "vas_maat",
								"shi_basilisk", "shi_shaitan", "shi_cain_fs1", "shi_lilith_fs1", "shi_demon_fs1", "shi_scorpion"
							}
							for i, ship in fs1_ships_to_hide do
								Player_RestrictBuildOption(playerIndex, ship)
							end
						end
					end

					-- Carriers Only restrictions for FS races
					if (carriersonly > 0) then
						if (racePrefix == "TER" or racePrefix == "VAS" or racePrefix == "SHI") then
							local super_ships_to_hide = {
								"ter_hades", "ter_colossus",
								"vas_colossus","vas_hatshepsut_fs1",
								"shi_lucifer", "shi_sathanas"
							}
							for i, ship in super_ships_to_hide do
								Player_RestrictBuildOption(playerIndex, ship)
							end
						end
					end
				end
			end
		end
		Rule_AddInterval("sobgroups_init", 1)
		--Rule_AddInterval("sobgroups_updating",1)
		Rule_AddInterval("UI_init", 0.1)
		--Rule_AddInterval("UI_updating",0.5)
		Rule_AddInterval("cpuplayers_updating", 0.1)
		--Rule_AddInterval("balancing_updating",0.25) --dev. to remove

		if nocruisers == 1 then
			Rule_AddInterval("nocruisers_init", timer_interval)
		end
		if strikecraftgamemode == 1 then
			Rule_AddInterval("strikecraftgamemode_init", timer_interval)
		end

		if research == 0 then
			Rule_AddInterval("fsfc_research_init", timer_interval)
		end
		if bounties > 0 then
			Rule_AddInterval("bounties_updating", timer_interval * 2)
		end
		if norushtime > 0 then
			Rule_AddInterval("norushtime_updating", timer_interval * 2)
		end
		Rule_AddInterval("mainrule_updating", timer_interval * 3)
	elseif timer_timing == 2 then
		if relics > 0 then
			relics_init()
			Rule_AddInterval("relics_updating", timer_interval * 4)
		end
	elseif timer_timing == 3 then
		if challenges > 0 then
			Rule_AddInterval("challenges_updating", timer_interval)
		end
	elseif timer_timing == 4 then
		if crates > 0 then
			crates_init()
			Rule_AddInterval("CheckCratesRule", timer_interval)
			Rule_AddInterval("SpawnCratesRule", timer_interval * 60)
		end
	elseif timer_timing == 5 then
		if ruinjections > 0 then
			Rule_AddInterval("ruinjections_updating", timer_interval * 48)
		end
	elseif timer_timing == 6 then
		UI_SetElementEnabled("NewTaskbar", "btnObjectives", 1)
		UI_SetElementEnabled("NewTaskbar", "btnRecall", 1)
		UI_SetElementEnabled("NewTaskbar", "btnBuild", 1)
		if research == 1 then
			UI_SetElementEnabled("NewTaskbar", "btnResearch", 1)
		end
		UI_SetElementEnabled("NewTaskbar", "btnLaunch", 1)
		FSFC_UpdateUIForRace()
	end
	timer_timing = timer_timing + 1
	if timer_timing > 6 then
		Rule_Remove("timer_updating")
	end
end

function Rule_GrantEraBySetting()
	local era = GetGameSettingAsNumber("era")
	for i = 0, Universe_PlayerCount() - 1 do
		if (Player_IsAlive(i) == 1) then
			local racePrefix = strsub(PlayerRace_GetString(i, "Prefix", ""), 1, 3)
			if (racePrefix == "TER" or racePrefix == "VAS" or racePrefix == "SHI") then
				if (era == 0) then
					Player_GrantResearchOption(i, "FS1")
					Player_RestrictResearchOption(i, "FS2")
				elseif (era == 1) then
					Player_GrantResearchOption(i, "FS2")
					Player_RestrictResearchOption(i, "FS1")
				else
					Player_GrantResearchOption(i, "FS1")
					Player_GrantResearchOption(i, "FS2")
				end
			end
		end
	end
	Rule_Remove("Rule_GrantEraBySetting")
end

Events = {}
Events.endGame = {
	{
		{ "wID = Wait_Start(5)", "Wait_End(wID)" },
	},
}
Events.startcinematic = {
	{ HW2_Letterbox(1) },
	{
		{ "Camera_AllowControl(0)",        "" },
		{ "Universe_EnableSkip(0)",        "" },
		{ "Universe_AllowPlayerOrders(0)", "" },
		{ "SobGroup_DeSelectAll()",        "" },
		{ "Sensors_Toggle(0)",             "" },
	},
}
Events.startcinematic_focusrestore = {
	{ HW2_Letterbox(1) },
	{
		{ "Camera_AllowControl(0)",        "" },
		{ "Universe_EnableSkip(0)",        "" },
		{ "Universe_AllowPlayerOrders(0)", "" },
		{ "SobGroup_DeSelectAll()",        "" },
		{ "Camera_FocusSave()",            "" },
		{ "Sensors_Toggle(0)",             "" },
	},
}
Events.stopcinematic = {
	{ HW2_Letterbox(0) },
	{
		{ "Universe_AllowPlayerOrders(1)", "" },
		{ "Camera_AllowControl(1)",        "" },
	},
}
Events.stopcinematic_focusrestore = {
	{ HW2_Letterbox(0) },
	{
		{ "Universe_AllowPlayerOrders(1)", "" },
		{ "Camera_FocusRestore()",         "" },
		{ "Camera_AllowControl(1)",        "" },
	},
}
