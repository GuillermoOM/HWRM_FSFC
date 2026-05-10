dofilepath("data:scripts/SCAR/SCAR_Util.lua")
dofilepath("data:scripts/scar/restrict.lua")
dofilepath("data:leveldata/multiplayer/lib/lib.lua")
dofilepath("data:leveldata/multiplayer/lib/research.lua")
dofilepath("data:leveldata/multiplayer/lib/main.lua")

function OnInit()
	FREESPACE_ERA = 1
	MPRestrict()
	research = GetGameSettingAsNumber("research")
	
	SetStartFleetSuffix("fs1")
	
	-- Era Activation
	Rule_Add("Rule_GrantFS1Era")
	
	UI_SetElementEnabled("NewTaskbar", "btnObjectives", 0)
	UI_SetElementEnabled("NewTaskbar", "btnRecall", 0)
	UI_SetElementEnabled("NewTaskbar", "btnBuild", 0)
	UI_SetElementEnabled("NewTaskbar", "btnResearch", 0)
	UI_SetElementEnabled("NewTaskbar", "btnLaunch", 0)
	
	Rule_AddInterval("timer_updating_fs1", 1.02)
end

timer_timing = 1
timer_interval = 5.1

function Rule_GrantFS1Era()
	for i = 0, Universe_PlayerCount() - 1 do
		if (Player_IsAlive(i) == 1) then
			Player_UnrestrictResearchOption(i, "FS1")
			Player_GrantResearchOption(i, "FS1")
			-- Explicitly restrict the other era to be sure
			Player_RestrictResearchOption(i, "FS2")
		end
	end
	Rule_Remove("Rule_GrantFS1Era")
end

function timer_updating_fs1()
	if timer_timing == 1 then
		for playerIndex = 0, Universe_PlayerCount() - 1, 1 do
			if Player_IsAlive(playerIndex) == 1 then
				if Player_HasShipWithBuildQueue(playerIndex) == 1 then
					Player_RestrictBuildOption(playerIndex, PlayerRace_GetString(playerIndex, "dm_build_restrict", ""))
				end
			end
		end
		
		if research == 0 then
			Rule_AddInterval("research_init", timer_interval)
		end
		
		Rule_AddInterval("UI_init_fs1", 0.1)
		
	elseif timer_timing == 2 then
		-- After research_init has run, we MUST re-restrict the unwanted era
		for i = 0, Universe_PlayerCount() - 1 do
			if (Player_IsAlive(i) == 1) then
				Player_RestrictResearchOption(i, "FS2")
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
		Rule_Remove("timer_updating_fs1")
	end
end

function UI_init_fs1()
	UI_SetElementEnabled("NewTaskbar", "btnObjectives", 1)
	UI_SetElementEnabled("NewTaskbar", "btnRecall", 1)
	UI_SetElementEnabled("NewTaskbar", "btnBuild", 1)
	if research == 1 then
		UI_SetElementEnabled("NewTaskbar", "btnResearch", 1)
	end
	UI_SetElementEnabled("NewTaskbar", "btnLaunch", 1)
	Rule_Remove("UI_init_fs1")
end

Events = {}
Events.endGame = { { { "wID = Wait_Start(5)", "Wait_End(wID)" } } }
