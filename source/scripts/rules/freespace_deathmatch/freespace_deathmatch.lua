dofilepath("data:scripts/SCAR/SCAR_Util.lua")
dofilepath("data:scripts/scar/restrict.lua")
dofilepath("data:leveldata/multiplayer/lib/lib.lua")
dofilepath("data:leveldata/multiplayer/lib/research.lua")
dofilepath("data:leveldata/multiplayer/lib/main.lua")
dofilepath("data:scripts/scar/fsfc_ui.lua")
dofilepath("data:leveldata/multiplayer/lib/ruinjections.lua")
dofilepath("data:leveldata/multiplayer/lib/music.lua")
dofilepath("data:scripts/rules/telemetry.lua")

function OnInit()
	Volume_AddSphere("centre", { -11111, 11111, 11111 }, 10)
	Rule_Add("RandomMusicRuleFS2")
	Rule_AddInterval("Rule_GlobalTelemetry", 15)
	MPRestrict()
	research = GetGameSettingAsNumber("research")
	era_setting = GetGameSettingAsNumber("era") -- 0: FS1, 1: FS2, 2: Both
	carriersonly = GetGameSettingAsNumber("carriersonly")
	ruinjections = GetGameSettingAsNumber("ruinjections")
	bounties = GetGameSettingAsNumber("bounties")

	-- RU Injection Stats initialization
	Stats_RUInjectionRUs = { 0, 0, 0, 0, 0, 0, 0, 0 }

	-- Starting fleet suffix priority
	local suffix = ""
	if (carriersonly == 1) then
		suffix = "carriersonly"
	elseif (carriersonly == 2) then
		suffix = "carriersonly1"
	elseif (era_setting == 0) then
		suffix = "fs1"
	elseif (era_setting == 1) then
		suffix = "fs2"
	end
	SetStartFleetSuffix(suffix)

	if (era_setting == 0) then
		FREESPACE_ERA = 1
		Rule_Add("Rule_GrantFS1Era")
	elseif (era_setting == 1) then
		FREESPACE_ERA = 2
		Rule_Add("Rule_GrantFS2Era")
	else
		FREESPACE_ERA = 3
		Rule_Add("Rule_GrantBothEras")
	end

	UI_SetElementEnabled("NewTaskbar", "btnObjectives", 0)
	UI_SetElementEnabled("NewTaskbar", "btnRecall", 0)
	UI_SetElementEnabled("NewTaskbar", "btnBuild", 0)
	UI_SetElementEnabled("NewTaskbar", "btnResearch", 0)
	UI_SetElementEnabled("NewTaskbar", "btnLaunch", 0)

	timer_timing = 1
	timer_interval = 5.1
	Rule_AddInterval("timer_updating_fsfc", 1.02)
	LogMatchSettings()
end

function Rule_GrantFS1Era()
	for i = 0, Universe_PlayerCount() - 1 do
		if (Player_IsAlive(i) == 1) then
			local racePrefix = strsub(PlayerRace_GetString(i, "Prefix", ""), 1, 3)
			if (racePrefix == "TER" or racePrefix == "VAS" or racePrefix == "SHI") then
				Player_GrantResearchOption(i, "FS1")
				Player_RestrictResearchOption(i, "FS2")
			end
		end
	end
	Rule_Remove("Rule_GrantFS1Era")
end

function Rule_GrantFS2Era()
	for i = 0, Universe_PlayerCount() - 1 do
		if (Player_IsAlive(i) == 1) then
			local racePrefix = strsub(PlayerRace_GetString(i, "Prefix", ""), 1, 3)
			if (racePrefix == "TER" or racePrefix == "VAS" or racePrefix == "SHI") then
				Player_GrantResearchOption(i, "FS2")
				Player_RestrictResearchOption(i, "FS1")
			end
		end
	end
	Rule_Remove("Rule_GrantFS2Era")
end

function Rule_GrantBothEras()
	for i = 0, Universe_PlayerCount() - 1 do
		if (Player_IsAlive(i) == 1) then
			local racePrefix = strsub(PlayerRace_GetString(i, "Prefix", ""), 1, 3)
			if (racePrefix == "TER" or racePrefix == "VAS" or racePrefix == "SHI") then
				Player_GrantResearchOption(i, "FS1")
				Player_GrantResearchOption(i, "FS2")
			end
		end
	end
	Rule_Remove("Rule_GrantBothEras")
end

function timer_updating_fsfc()
	if timer_timing == 1 then
		for playerIndex = 0, Universe_PlayerCount() - 1, 1 do
			if Player_IsAlive(playerIndex) == 1 then
				if Player_HasShipWithBuildQueue(playerIndex) == 1 then
					if (era_setting == 0) then -- FS1 Only, hide FS2
						local fs2_ships_to_hide = {
							"ter_herculesmk2", "ter_perseus", "ter_myrmidon", "ter_ares", "ter_erinyes",
							"ter_artemis", "ter_artemisdh", "ter_boanerges", "ter_aeolus", "ter_deimos",
							"ter_hecate", "ter_colossus", "ter_mjolnir", "ter_charybdis", "ter_pegasus",
							"ter_hygeia", "ter_argo",
							"vas_ptah", "vas_serapis", "vas_tauret", "vas_bakha", "vas_sehkmet", "vas_mentu",
							"vas_sobek", "vas_hatshepsut", "vas_colossus", "vas_setekh", "vas_nephthys", "vas_bast",
							"shi_mara", "shi_aeshma", "shi_nahema", "shi_taurvi",
							"shi_seraphim", "shi_rakshasa", "shi_ravana", "shi_moloch", "shi_sathanas",
							"shi_gorgon", "shi_astaroth"
						}
						for i, ship in fs2_ships_to_hide do
							Player_RestrictBuildOption(playerIndex, ship)
						end
					elseif (era_setting == 1) then -- FS2 Only, hide FS1
						local fs1_ships_to_hide = {
							"ter_apollo", "ter_valkyrie", "ter_athena", "ter_cerberus", "ter_chronos",
							"vas_seth", "vas_horus", "vas_thoth", "vas_scarab", "vas_bes", "shi_shaitan",
						}
						for i, ship in fs1_ships_to_hide do
							Player_RestrictBuildOption(playerIndex, ship)
						end
					end

					-- Carriers Only restrictions for FS races
					if (carriersonly > 0) then
						local super_ships_to_hide = {
							"ter_hades", "ter_colossus",
							"vas_colossus",
							"shi_lucifer", "shi_sathanas"
						}
						for i, ship in super_ships_to_hide do
							Player_RestrictBuildOption(playerIndex, ship)
						end
					end

					local restrictString = PlayerRace_GetString(playerIndex, "dm_build_restrict", "")
					if restrictString ~= "" then
						Player_RestrictBuildOption(playerIndex, restrictString)
					end
				end
			end
		end

		if research == 0 then
			Rule_AddInterval("research_init", timer_interval)
		end

		Rule_AddInterval("UI_init_fsfc", 0.1)
		Rule_AddInterval("cpuplayers_updating", 0.1)
		Rule_AddInterval("sobgroups_init", 1)
		Rule_AddInterval("mainrule_updating", timer_interval * 3)

		if bounties > 0 then
			Rule_AddInterval("bounties_updating", timer_interval * 2)
		end
	elseif timer_timing == 2 then
		for i = 0, Universe_PlayerCount() - 1 do
			if (Player_IsAlive(i) == 1) then
				if (era_setting == 0) then
					Player_RestrictResearchOption(i, "FS2")
				elseif (era_setting == 1) then
					Player_RestrictResearchOption(i, "FS1")
				end
			end
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
	end

	timer_timing = timer_timing + 1
	if timer_timing > 6 then
		Rule_Remove("timer_updating_fsfc")
	end
end

function UI_init_fsfc()
	UI_SetElementEnabled("NewTaskbar", "btnObjectives", 1)
	UI_SetElementEnabled("NewTaskbar", "btnRecall", 1)
	UI_SetElementEnabled("NewTaskbar", "btnBuild", 1)
	if research == 1 then
		UI_SetElementEnabled("NewTaskbar", "btnResearch", 1)
	end
	UI_SetElementEnabled("NewTaskbar", "btnLaunch", 1)
	FSFC_UpdateUIForRace()
	Rule_Remove("UI_init_fsfc")
end

Events = {}
Events.endGame = { { { "wID = Wait_Start(5)", "Wait_End(wID)" } } }
