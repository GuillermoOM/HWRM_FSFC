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
--dofilepath("data:leveldata/multiplayer/lib/clock.lua")
--dofilepath("data:leveldata/multiplayer/stc_lib/stc_shield.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_explosion.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_midway.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_seperation.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_helperfunctions.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_keybindings.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_upgrades.lua")
dofilepath("data:leveldata/multiplayer/stc_lib/stc_ui.lua")
dofilepath("data:leveldata/multiplayer/lib/kamikaze.lua")
dofilepath("data:leveldata/multiplayer/lib/sobgroupfunctions.lua")
SEPARATION_Initial = " "

----------------------------------------------------------------------------------------------------
-- Init all subroutines
----------------------------------------------------------------------------------------------------
initialrun = 0
STC_seedvalue = 0

function stc_Main_Init()
	-- ensure that random numbers are synced in multiplayer
	STC_seedvalue = random(1, 1000000)
	experience_Init()
	sobSplitter_Init()

	explosion_Init()

	Rule_Add("stc_mainRule")

	
	
end

----------------------------------------------------------------------------------------------------
-- Main rule
----------------------------------------------------------------------------------------------------
function stc_mainRule()
	-- we use the mode to denote what gametype we're playing.
	-- ensure that random numbers are synced in multiplayer
	randomseed(STC_seedvalue)
	STC_seedvalue = random(1, 1000000)
	
	-- update globalShipTable
	sobSplitterRule()
	-- replace incorrect nodes.
	if initialrun == 0 then
		for i = 0, Universe_PlayerCount()-1 do
			if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
				for j = 1, getn(globalShipTable[i]) do
					midway_replace(i, j)

				end
			end
		end
		initialrun = 1
	end
	-- loop through all known ships and calculate warp and shields
	for i = 0, Universe_PlayerCount()-1 do
		if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
			for j = 1, getn(globalShipTable[i]) do
				WARP_Rule(i, j)
				explosionRule(i, j)
				UPGRADE_Rule(i, j)
				experienceRule(i, j)
			end
		researchRule2(i)
		end
	end
	-- update explosion shockwaves
	explosionShockwaveRule()

	--Rule_AddInterval("updateTimer", 1)

	
end

-- re-initiate all effects and key bindings
function OnStartOrLoad()
	-- Change UI elements depending on race
	--ChangeUIForPlayerByRace()
	
	--bindKeyEvents()
	
	--cloakDisplayed = 0
	--displayCloak()
	--experienceDisplayed = 0
	--displayExperience()

end