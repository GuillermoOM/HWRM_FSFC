----------------------------------------------------------------------------------------------------
-- MAIN ROUTINE - initializates all subroutines
----------------------------------------------------------------------------------------------------
-- Camera shake is disabled. Need to look into trilateration again, because (0,0,0) is a bad point
-- for a reference ship. Also disabled 'f' hitcounter.
---------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------------------------------
-- Header
----------------------------------------------------------------------------------------------------
dofilepath("data:leveldata/multiplayer/stc_lib/stc_settings.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_sobSplitter.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_warp.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_experience.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_research.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_subsystem.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_keeper.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_blackhole.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_shield.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_explosion.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_espionage.lua")
-- dofilepath("data:leveldata/multiplayer/stc_lib/stc_ati.lua")
-- dofilepath("data:leveldata/multiplayer/stc_lib/stc_camera.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_helperfunctions.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_keybindings.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_mvam.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_separation.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_midway.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_SOK.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_ui.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_alliance.lua")

SAFE_warp       = 1
SAFE_experience = 1
SAFE_shield     = 1
SAFE_explosions = 1
SAFE_espionage  = 1
SAFE_mvam       = 1
SAFE_drones     = 1
SAFE_keepers    = 1
SAFE_research   = 1
SAFE_subsystems = 1
SAFE_alliance   = 1


----------------------------------------------------------------------------------------------------
-- Init all subroutines
----------------------------------------------------------------------------------------------------

STC_seedvalue = 0

function stc_Main_Init()
	-- ensure that random numbers are synced in multiplayer
	STC_seedvalue = random(1, 1000000)
	
	if( GetGameSettingAsNumber("scripts") == 0 ) then
		sobSplitter_Init()
		
		-- Change UI elements depending on race
		ChangeUIForPlayerByRace()
		
	else
		SAFE_warp       = GetGameSettingAsNumber("warp")
		SAFE_experience = GetGameSettingAsNumber("experience")
		SAFE_shield     = GetGameSettingAsNumber("shield")
		SAFE_explosions = GetGameSettingAsNumber("explosions")
		SAFE_espionage  = GetGameSettingAsNumber("espionage")
		SAFE_mvam       = GetGameSettingAsNumber("mvam")
		SAFE_drones     = GetGameSettingAsNumber("drones")
		SAFE_keepers    = GetGameSettingAsNumber("keepers")
		SAFE_research   = GetGameSettingAsNumber("research")
		SAFE_subsystems = GetGameSettingAsNumber("subsystems")
		SAFE_alliance   = GetGameSettingAsNumber("alliance")
		
		bindKeyEvents()
		
		sobSplitter_Init()
		
		if( SAFE_experience == 1 ) then
			experience_Init()
		end
		
		if( SAFE_research == 1 ) then
			research_Init()
		end
		
		if( SAFE_subsystems == 1 ) then
			subsystem_Init()
		end
		
		if( SAFE_keepers == 1 ) then
			keeper_Init()
			blackhole_Init()
		end
		
		if( SAFE_espionage == 1 ) then
			espionage_Init()
		end
		
		if( SAFE_explosions == 1 ) then
			explosion_Init()
		end
		
		if( SAFE_mvam == 1 ) then
			SEPARATION_Init()
			mvam_Init()
		end
		
		if( SAFE_drones == 1 ) then
			midway_Init()
			SOK_Init()
		end
		
		if( SAFE_alliance == 1 ) then
			ALLIANCE_Init()
		end
		
		-- camera_Init()
		-- ati_Init()
		
		-- Change UI elements depending on race
		ChangeUIForPlayerByRace()
		
		Rule_Add("stc_mainRule")
		
	end
end

----------------------------------------------------------------------------------------------------
-- Main rule
----------------------------------------------------------------------------------------------------
function stc_mainRule()
	-- ensure that random numbers are synced in multiplayer
	randomseed(STC_seedvalue)
	STC_seedvalue = random(1, 1000000)
	
	-- update globalShipTable
	sobSplitterRule()
	
	-- loop through all known ships and calculate warp and XP
	for i = 0, Universe_PlayerCount()-1 do
		if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
			for j = 1, getn(globalShipTable[i]) do
				
				if( SAFE_warp == 1 ) then
					WARP_Rule(i, j)
				end
				
				if( SAFE_experience == 1 ) then
					experienceRule(i, j)
				end
				
				if( SAFE_shield == 1 ) then
					shieldRule(i, j)
				elseif( SAFE_shield == 2 ) then
					shieldRule_onlyFX(i, j)
				end
				
				if( SAFE_explosions == 1 ) then
					explosionRule(i, j)
				elseif( SAFE_explosions == 2 ) then
					explosionRule_onlyFX(i, j)
				end
				
			end
		end
	end
	
	
	if( SAFE_explosions == 1 ) then
		-- update explosion shockwaves
		explosionShockwaveRule()
	end
	
	if( SAFE_keepers == 1 ) then
		-- update Keepers
		keeperRule()
		blackholeRule()
	end
	
	if( SAFE_research == 1 ) then
		-- do special research stuff
		researchRule()
	end
	
	if( SAFE_subsystems == 1 ) then
		-- do special subsystem stuff
		subsystemRule()
	end
	
	if( SAFE_espionage == 1 ) then
		-- Romulan espionage
		espionageRule()
	end
	
	if( SAFE_mvam == 1 ) then
		-- Galaxy MVAM
		SEPARATION_Rule()
		mvamRule()
	end
	
	if( SAFE_drones == 1 ) then
		-- Midway Drones
		midwayRule()
		-- Drones for the Sword of Kahless
		SOKRule()
	end
	
	-- cameraRule()
	-- atiRule()
	
end

-- re-initiate all effects and key bindings
function OnStartOrLoad()
	-- Change UI elements depending on race
	ChangeUIForPlayerByRace()
	
	bindKeyEvents()
	
	cloakDisplayed = 0
	displayCloak()
	experienceDisplayed = 0
	displayExperience()
	
	if(BlackholeCount > 0) then
		SobGroup_SetMadState("sob_AllBlackholes", "Launched")
	end
end