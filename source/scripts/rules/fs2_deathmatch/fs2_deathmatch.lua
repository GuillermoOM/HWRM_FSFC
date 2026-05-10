dofilepath("data:scripts/SCAR/SCAR_Util.lua")
dofilepath("data:scripts/scar/restrict.lua")
dofilepath("data:leveldata/multiplayer/lib/lib.lua")
dofilepath("data:leveldata/multiplayer/lib/research.lua")
dofilepath("data:leveldata/multiplayer/lib/main.lua")
dofilepath("data:scripts/scar/fsfc_ui.lua")

function OnInit()
	FREESPACE_ERA = 2
	MPRestrict()
	research = GetGameSettingAsNumber("research")

	SetStartFleetSuffix("fs2")

	-- Era Activation
	Rule_Add("Rule_GrantFS2Era")

	UI_SetElementEnabled("NewTaskbar", "btnObjectives", 0)
	UI_SetElementEnabled("NewTaskbar", "btnRecall", 0)
	UI_SetElementEnabled("NewTaskbar", "btnBuild", 0)
	UI_SetElementEnabled("NewTaskbar", "btnResearch", 0)
	UI_SetElementEnabled("NewTaskbar", "btnLaunch", 0)

	Rule_AddInterval("timer_updating_fs2", 1.02)
end

timer_timing = 1
timer_interval = 5.1

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

function timer_updating_fs2()
	if timer_timing == 1 then
		for playerIndex = 0, Universe_PlayerCount() - 1, 1 do
			if Player_IsAlive(playerIndex) == 1 then
				if Player_HasShipWithBuildQueue(playerIndex) == 1 then
					local fs1_ships_to_hide = {
						"ter_apollo", "ter_valkyrie",
						"vas_seth", "vas_horus", "vas_thoth", "shi_shaitan",
					}
					for i, ship in fs1_ships_to_hide do
						Player_RestrictBuildOption(playerIndex, ship)
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

		Rule_AddInterval("UI_init_fs2", 0.1)
	elseif timer_timing == 2 then
		-- After research_init has run, we MUST re-restrict the unwanted era
		for i = 0, Universe_PlayerCount() - 1 do
			if (Player_IsAlive(i) == 1) then
				Player_RestrictResearchOption(i, "FS1")
			end
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
		Rule_Remove("timer_updating_fs2")
	end
end

function UI_init_fs2()
	UI_SetElementEnabled("NewTaskbar", "btnObjectives", 1)
	UI_SetElementEnabled("NewTaskbar", "btnRecall", 1)
	UI_SetElementEnabled("NewTaskbar", "btnBuild", 1)
	if research == 1 then
		UI_SetElementEnabled("NewTaskbar", "btnResearch", 1)
	end
	UI_SetElementEnabled("NewTaskbar", "btnLaunch", 1)
	FSFC_UpdateUIForRace()
	Rule_Remove("UI_init_fs2")
end

Events = {}
Events.endGame = { { { "wID = Wait_Start(5)", "Wait_End(wID)" } } }
