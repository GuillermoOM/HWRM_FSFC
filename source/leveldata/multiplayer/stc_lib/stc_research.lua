----------------------------------------------------------------------------------------------------
-- RESEARCH - playes research connected Mad animations + either/or research
----------------------------------------------------------------------------------------------------
-- How it works: We check every game cycle, whether any research of the researchAnimTable in
-- STC_SETTINGA.LUA has been done. If so, we loop through the whole ship list and set the NIS02
-- state for all ships, which are of the shiptype specified in the researchAnimTable. The animation
-- played by the ship, when the NIS02 state is set, has to be defined in the madstate file of the
-- ship itself (NOTE: NIS00 and NIS01 are used for warp).
-- When a research is done by a player and the connected animation has been played, we remember
-- this by setting the researchAnimDoneTable[i][k] entry to 1 (we only want to play the 
-- animation once).
-- When a ship is built, it could be that we've already done the research animation and therefore 
-- won't play it for the new ship. That's why we  have to do an initial check for a new ship,
-- whether a research with an animation has been done, which affects the new ship (researchAnimInitial).
----------------------------------------------------------------------------------------------------

-- researchAnimDoneTable : contains information for every player whether a certain research
--                         animation has been done.
--
-- usage:
--
--                          researchAnimDoneTable[i][k]
--
-- where i is the playerindex (i = 0..Universe_PlayerCount()-1 ),
--       k the researchindex (k = 1..getn(researchAnimTable) ).
--
researchAnimDoneTable = {}

-- Initialization
function research_Init()
	-- Fill the RADT (for every player and every research the entry 0)
	for i = 0, Universe_PlayerCount()-1 do
		researchAnimDoneTable[i] = {}
		for k = 1, getn(researchAnimTable) do
			researchAnimDoneTable[i][k] = 0 -- 0 = research not done
		end
	end
end

function researchRule()
	researchEitherOr()
	
	-- loop through all Players
	for i = 0, Universe_PlayerCount()-1 do
		if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
			
			-- loop through all research with an animation
			for k = 1, getn(researchAnimTable) do
				-- check if
				-- 1. the player has the research
				-- 2. we haven't already done the animation before
				if( Player_HasResearch(i, researchAnimTable[k][1]) == 1 and researchAnimDoneTable[i][k] == 0 ) then
					researchAnimDoneTable[i][k] = 1
					
					-- play the animation for every ship of the certain shiptype
					for j = 1, getn(globalShipTable[i]) do
						if( SobGroup_AreAnyOfTheseTypes(globalShipTable[i][j][SobGroup], researchAnimTable[k][2]) == 1 ) then
							SobGroup_SetMadState(globalShipTable[i][j][SobGroup], "NIS02")
						end
					end
					
				end
			end
			
		end
	end
	
end

function researchRule2(i)
	if Player_GetRace(i) == 11 then
		if Player_HasResearch(i, "AdvDestroyerDrive") == 1 and Player_HasResearch(i, "AdvDestroyerDrive1") == 0 then
			Player_GrantResearchOption(i, "AdvDestroyerDrive1")
			Player_GrantResearchOption(i, "AdvDestroyerDrive2")
		end
	end
end

-- initial research Animation: called when a ship is built. If the player has done a certain reserach
-- the research animation will be played.
function researchAnimInitial(i, index)
	-- loop through all research
	for k = 1, getn(researchAnimTable) do
		-- check: is the new ship one, which has an animation?
		if( SobGroup_AreAnyOfTheseTypes("Player"..i.."_ship"..index, researchAnimTable[k][2]) == 1 ) then
			-- play the anmination when the player has the research alredy
			if( Player_HasResearch(i, researchAnimTable[k][1]) == 1 ) then
				SobGroup_SetMadState("Player"..i.."_ship"..index, "NIS02")				
			end
			break
		end
	end
end


----------------------------------------------------------------------------------------------------
-- Either/Or-Research
-- Will force the player to only research one research of each couple defined in the researchEitherOrTable (--> settings.lua)
--
function researchEitherOr()
	-- loop through all Players
	for i = 0, Universe_PlayerCount()-1 do
		if(Player_IsAlive(i) == 1) then
			
			for k = 1, getn(researchEitherOrTable[Player_GetRace(i)]) do
				if( Player_HasResearch(i, researchEitherOrTable[Player_GetRace(i)][k][1]) == 1 and Player_HasQueuedResearch(i, researchEitherOrTable[Player_GetRace(i)][k][2]) == 1 ) then
					Player_CancelResearch(i, researchEitherOrTable[Player_GetRace(i)][k][2])
				elseif( Player_HasResearch(i, researchEitherOrTable[Player_GetRace(i)][k][2]) == 1 and Player_HasQueuedResearch(i, researchEitherOrTable[Player_GetRace(i)][k][1]) == 1 ) then
					Player_CancelResearch(i, researchEitherOrTable[Player_GetRace(i)][k][1])
				end

			end
			
		end
	end
	
end

