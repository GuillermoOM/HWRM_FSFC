----------------------------------------------------------------------------------------------------
-- ESPIONAGE ROUTINE
----------------------------------------------------------------------------------------------------
-- This script allows romulan players to activate a screen with detailed information about other
-- players and a special ability, which reveals the position of all uncloaked enemy ships. The
-- script uses a custom screen: "EspionagePanel". The Spy ability is done by spawning a ship with
-- (almost) unlimited secondary sensor range (rom_TNG_spy).
-- The abilities described above can be gained by research. There are 4 levels:
-- 0 : nothing
-- 1 : race + RU information
-- 2 : race + RU + ship count + detailed reserach information
-- 3 : spy ability
----------------------------------------------------------------------------------------------------

-- this is a helper that we only need to use one varialbe to calculate. The Spy is ready when the
-- timer variable is at 'espionageReady'
espionageReady = 1000000

-- contains Timers for duration and recharge
espionageTimerTable = {}
-- contains race specific research names
espionageRaceResearch = {}
-- contains player specific espionage levels
espionageLevel = {}

espionageRomulanPlayerCount = 0

function espionage_Init()
		-- this is where the spy is spawned
		Volume_AddSphere("vol_spy", {0, 1000000, 0,}, 1000)
	-- loop through all players
	for i = 0, Universe_PlayerCount()-1 do
		espionageLevel[i] = 0
		espionageTimerTable[i] = espionageReady
		if( Player_GetRace(i) == Romulan ) then
			SobGroup_Create("sob_spy"..i)
			SobGroup_Clear("sob_spy"..i)
			SobGroup_SpawnNewShipInSobGroup(i, "rom_TNG_spy", "sqd_"..i, "sob_spy"..i, "vol_spy")
			SobGroup_Despawn("sob_spy"..i)
			espionageRomulanPlayerCount = espionageRomulanPlayerCount + 1
		end
	end
	
	-- only calculate if romulan players are available
	if( espionageRomulanPlayerCount > 0) then

		
		dofilepath("data:scripts\\race.lua")
		dofilepath("data:scripts\\building and research\\Federation\\research.lua")
		addResearchToRaceResearchTable(Federation)
		dofilepath("data:scripts\\building and research\\Klingon\\research.lua")
		addResearchToRaceResearchTable(Klingon)
		dofilepath("data:scripts\\building and research\\Romulan\\research.lua")
		addResearchToRaceResearchTable(Romulan)
		dofilepath("data:scripts\\building and research\\Auxiliary\\research.lua")
		addResearchToRaceResearchTable(Auxiliary)
		
		UI_SetElementPosition("EspionagePanel","Frame_Buttons", -100, 1)
		Rule_Add("checkEspionageResearch")
		
	end
	
end

-- helper function which adds the researches to the espionage tables
function addResearchToRaceResearchTable(race)
	espionageRaceResearch[race] = {}
	for j = 1, getn(research) do
		if( research[j].DisplayedName ~= "TNG" and research[j].DisplayedName ~= "ENT" and research[j].DisplayedName ~= "TOS" and research[j].DisplayedName ~= "TMP" and research[j].DisplayedName ~= "N/A") then
			tinsert(espionageRaceResearch[race], { Name = research[j].Name, DisplayedName = research[j].DisplayedName })
		end
	end
end

-- rule which checks for espionage upgrades
function checkEspionageResearch()
	for i = 0, Universe_PlayerCount()-1 do
		if( Player_IsAlive(i) == 1 and Player_GetRace(i) == Romulan ) then
			
			if( Player_HasResearch(i, "rom_tng_Espionage3") == 1 and espionageLevel[i] < 3 ) then
				espionageLevel[i] = 3
				if( i == FE_GetCurrentPlayerIndex() ) then
					UI_SetTextLabelText("EspionagePanel", "Label_Espionage", "Espionage: Ready")
				end
				
			elseif( Player_HasResearch(i, "rom_tng_Espionage2") == 1 and espionageLevel[i] < 2 ) then
				espionageLevel[i] = 2
				if( i == FE_GetCurrentPlayerIndex() ) then
					UI_FlashButton("EspionagePanel", "Button_EspionageInfo", 3)
				end
				
			elseif( Player_HasResearch(i, "rom_tng_Espionage1") == 1 and espionageLevel[i] < 1 ) then
				espionageLevel[i] = 1
				if( i == FE_GetCurrentPlayerIndex() ) then
					UI_ShowScreen("EspionagePanel", ePopup)
					UI_FlashButton("EspionagePanel", "Button_EspionageInfo", 3)
				end
			end
			
		end
	end
end

-- MAIN espionage rule
function espionageRule()
	-- only calculate if romulan players are available
	if( espionageRomulanPlayerCount > 0) then
		for i = 0, Universe_PlayerCount()-1 do

			-- Level 1 & 2 Espionage
			-- only collect data, if the data should be displayed
			if( UI_IsNamedElementVisible("EspionagePanel", "Label_EspionageInfo") == 1 ) then
				local counter = 0
				local researchDone = ""
				local researchQueued = ""
				local espionageString = ""
				local raceIndex = Player_GetRace(i)
				local espionageString1 = ""
				local espionageString2 = ""
				
				if( Player_IsAlive(i) == 1 ) then
					-- check, which research has been done or is queued
					for j = 1, getn(espionageRaceResearch[raceIndex]) do
						if( Player_HasResearch(i, espionageRaceResearch[raceIndex][j].Name) == 1 and counter < 5) then
							researchDone = researchDone.." - "..espionageRaceResearch[raceIndex][j].DisplayedName.."\n"
							counter = counter + 1
						elseif( Player_HasQueuedResearch(i, espionageRaceResearch[raceIndex][j].Name) == 1 ) then
							researchQueued = researchQueued.." - "..espionageRaceResearch[raceIndex][j].DisplayedName.." ...being done or queued\n"
						end
					end
					-- Labels cannot handle too many letter
					if( counter >= 5 ) then
						researchDone = researchDone.." - ...\n"
					end
					
					espionageString1 = "Player "..i.."\nRace: "..races[raceIndex+1][1].."\n\nDilithium: "..Player_GetRU(i)
					espionageString2 = espionageString1.."\n\nActive Ships: "..Player_NumberOfAwakeShips(i).."\n\nResearchDone: "..counter.."\n"..researchQueued..researchDone
				else
					espionageString1 = "Player "..i.." is dead."
					espionageString2 = espionageString1
				end
				
				-- set displayed UI information depending on espionage level
				if( espionageLevel[FE_GetCurrentPlayerIndex()] >= 2 ) then
					UI_SetTextLabelText("EspionagePanel", "Label_EspionageInfoPlayer"..i, espionageString2)
				else
					UI_SetTextLabelText("EspionagePanel", "Label_EspionageInfoPlayer"..i, espionageString1)
				end
			end
			
			
			-- Level 3 Espionage
			if( Player_IsAlive(i) == 1 and Player_GetRace(i) == Romulan and espionageLevel[i] == 3 ) then
				
				-- ACTIVATE SPY: show enemy ships
				if( Player_HasQueuedResearch(i, "rom_tng_Espionage4") == 1 ) then
					Player_CancelResearch(i, "rom_tng_Espionage4")
					Player_RestrictResearchOption(i, "rom_tng_Espionage4")
					espionageTimerTable[i] = espionageDuration
					
					SobGroup_Spawn("sob_spy"..i, "vol_spy")
					espionageTimerTable[i] = espionageDuration - 1
					
				-- DEACTIVATE SPY: despawn spy
				elseif( espionageTimerTable[i] == 0 ) then
					SobGroup_Despawn("sob_spy"..i)
					espionageTimerTable[i] = -1
					
				-- recharge time is over, reactivate button
				elseif( espionageTimerTable[i] == -1 * espionageRechargeTime ) then
					Player_UnrestrictResearchOption(i, "rom_tng_Espionage4")
					espionageTimerTable[i] = espionageReady
					
					if( i == FE_GetCurrentPlayerIndex() ) then
						UI_SetTextLabelText("EspionagePanel", "Label_Espionage", "Espionage: Ready")
					end
					
				elseif( espionageTimerTable[i] == espionageReady ) then
					-- wait for player input
					
				else
					-- decrement and display timer
					if( espionageTimerTable[i] > 0 ) then
						if( i == FE_GetCurrentPlayerIndex() ) then
							UI_SetTextLabelText("EspionagePanel", "Label_Espionage", "Espionage: Active for "..floor(espionageTimerTable[i]*0.1).." seconds")
						end
					else
						if( i == FE_GetCurrentPlayerIndex() ) then
							UI_SetTextLabelText("EspionagePanel", "Label_Espionage", "Espionage: Ready in "..floor((espionageRechargeTime + espionageTimerTable[i])*0.1).." seconds")
						end
					end
					espionageTimerTable[i] = espionageTimerTable[i] - 1
				end
			
			end
			
		end
	end
end

