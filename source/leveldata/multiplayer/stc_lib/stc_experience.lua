----------------------------------------------------------------------------------------------------
-- EXPERIENCE ROUTINE
----------------------------------------------------------------------------------------------------
-- How it works: We check if a ship dies and add XP to all its attackers. The XP of a ship
-- determines its rank. And depending on the rank the health of an invisible subsystems (with
-- linear mutlipliers) is set. This will boost promoted ships.
-- The XP that a diing ship gives to its attackers equals with the total ship strength
-- (strength*RankMultiplier) of the diing ship. Once a ship gained a multiple of its own strength
-- it will rank up. Ranks are defined in "stc_settings.lua".
--
-- We split the XP of a diing ship on all attackers. Heavier ships will gain more xp than weaker
-- ships.
-- Example:
--      We have two attackers:
--         (1) Rank = 1 (no Rank), strength = 2
--         (2) Rank = 1 (no Rank), strength = 3
--      They both attack a ship with Rank = 1, strength = 1. The ship gets destroyed.
--      XP_to_gain = diing_ship_strength * RankMultiplier = 1 * 1 = 1
--      Ship (1) gains
--         ship1_strength*RankMultiplier * XP_to_gain / (ship1_strength*RankMultiplier + ship2_strength*RankMultiplier)
--            = 2*1/(2+3) = 2/5
--      and Ship (2) gains
--              3*1/(2+3) = 3/5
--      experience.
--      We do this because obviously the heavier ship did most work and therefore should gain more
--      XP. It also needs more XP for the next Rank.
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
-- TODO: Include subsystem enhancements (e.g. extra torpedo launchers or heavy disruptor pulses)
--       for ships strength calculation
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------
dofilepath("data:soundscripts/speechlogic/status.lua")
dofilepath("data:soundscripts/speechlogic/commands.lua")
dofilepath("data:soundscripts/speechlogic/chatter.lua")
function experience_Init()
	SobGroup_Create("sob_attackers")
	SobGroup_Clear("sob_attackers")
	
	SobGroup_Create("sob_tempAttacker")
	SobGroup_Clear("sob_tempAttacker")
	print("EXPERIENCE INIT")
	--displayExperience()
	--HitCounter_tab = 0
end

sob_ship = ""
attackerTable = {}
xp = 0
totalAttackerStrength = 0



-- we do the experience thing for ship j of player i
function experienceRule(i, j)				
	-- we need the ship name a few times...
	sob_ship = globalShipTable[i][j][SobGroup]
	--print("EXPERIENCE RULE")
	-- Check if 
	-- 1. the ship has died
	-- 2. we have done the xp procedure before
	if( SobGroup_HealthPercentage(sob_ship) <= 0 and globalShipTable[i][j][Experience] ~= -1 ) then
		
		-- if not get all the attackers
		SobGroup_GetAttackers( sob_ship, "sob_attackers")
		
		--print(">> EXPERIENCE >> | ------------------------------------------------------ ")
		--print(">> EXPERIENCE >> | >> Ship destroyed: P"..i.." S"..j)
		--print(">> EXPERIENCE >> | >> Xp value is: "..globalShipTable[i][j][Experience])
		--print(">> EXPERIENCE >> | >> No of Attackers: "..SobGroup_Count( "sob_attackers" ))
		-- if we had at least one
		if( SobGroup_Count("sob_attackers") >= 1) then
			-- find out who attacked us
			attackerTable = specifyAttackers()
			
			-- calculate the XP we have to split on all attackers and norm it to the total attackstrength
			xp = (globalShipTable[i][j][Strength] * rankInfoTable[globalShipTable[i][j][Rank]][2] / totalAttackerStrength)
			
			--print(">> EXPERIENCE >> | total amount of XP to gain: "..globalShipTable[i][j][Strength] * rankInfoTable[globalShipTable[i][j][Rank]][2])
			--print(">> EXPERIENCE >> | total amount of attacker strenght is: "..totalAttackerStrength)
			--print(">> EXPERIENCE >> | this means: "..xp)
			
			-- now add experience to every attacker 
			for k = 1, getn(attackerTable) do
				print(">> EXPERIENCE >> | >> add Xp to ship: "..k.." | i = "..attackerTable[k][1].." | j = "..attackerTable[k][2])				
				print(">> EXPERIENCE >> | XP old was: "..globalShipTable[attackerTable[k][1]][attackerTable[k][2]][Experience])
				
				-- set the new experience:
				-- attacker_XP = attacker_XP + xp * attacker_Strength * attacker_RankMultiplier
				globalShipTable[attackerTable[k][1]][attackerTable[k][2]][Experience] = globalShipTable[attackerTable[k][1]][attackerTable[k][2]][Experience] + xp * globalShipTable[attackerTable[k][1]][attackerTable[k][2]][Strength] * rankInfoTable[ globalShipTable[attackerTable[k][1]][attackerTable[k][2]][Rank] ][2]
				
				print(">> EXPERIENCE >> | XP is now: "..globalShipTable[attackerTable[k][1]][attackerTable[k][2]][Experience])
				
				-- check for a RankUp
				XP_CheckForRankUp(attackerTable[k][1], attackerTable[k][2])
				
			end
			
		end
		
		-- mark that we did the rank procedure
		globalShipTable[i][j][Experience] = -1
		
	end
	
end

function XP_CheckForRankUp(i, j)
	sob_ship = globalShipTable[i][j][SobGroup]
	shipName = globalShipTable[i][j][ShipClass]
	--if random() < 0.5 and i == FE_GetCurrentPlayerIndex() then
	-- 	StatusKill(shipName)
	--end
	--print("CHECKING FOR RANK UP")
	-- check for a RankUp (we go through the rankInfoTable from bottom to top)
	for k = getn(rankInfoTable), globalShipTable[i][j][Rank] + 1, -1 do
		-- check if:
		-- 1. the attacker's experience normed on it's strength is equal or greater than the experience needed for the highest rank
		if( rankInfoTable[k][1] <= globalShipTable[i][j][Experience] / globalShipTable[i][j][Strength] ) then
			print(">> EXPERIENCE >> | THIS MEANS A RANK UP! YEAH! RANK is: "..globalShipTable[i][j][Rank])
			
			-- if xp is displayed, stop the loop event of the old rank and start the loop event of the new rank
			--if( experienceDisplayed == 1 ) then
			--	FX_StopEvent(globalShipTable[i][j][SobGroup], rankInfoTable[globalShipTable[i][j][Rank]][3].."_loop" )
			--	FX_StartEvent(globalShipTable[i][j][SobGroup], rankInfoTable[k][3].."_loop" )
			--end
			
			-- set the rank, start an FX to show it ingame and set the Hardpointshealth to increase the ships efficiency
			globalShipTable[i][j][Rank] = k
			--FX_StartEvent(globalShipTable[i][j][SobGroup], rankInfoTable[k][3] )
			--SobGroup_SetHardPointHealth(globalShipTable[i][j][SobGroup], "XP", 0.5 * rankInfoTable[k][2])
			
			-- We go from bottom to top through the rankInfoTable. That's why we don't need to check lower ranks
			if i == FE_GetCurrentPlayerIndex() then
				StatusKill(shipName)
			end
			break
			
		end
	end
end

-- 
-- returns a table consisting all attackers of sob_ship and also calculates the total attacker strength
-- 
--      attackerTable[i][j]
-- 
-- where i = 1..#attackers
--       j = 1 : PlayerIndex of the attacking ship
--           2 : ShipIndex of the attacker
--
-- access the ship's stat no. k using: globalShipTable[attackerTable[k][1]][attackerTable[k][2]][k]
-- 
function specifyAttackers()	
	local attackerTable = {}
	totalAttackerStrength = 0
	
	-- loop through all known ships
	for i = 0, Universe_PlayerCount()-1 do
		if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
			for j = 1, getn(globalShipTable[i]) do
				
				-- check if the current ship belongs to the attackers
				-- AND:
				-- Check if the attacker is still alive! Dead/Diing ships can be attackers, but they are not
				-- allowed to gain XP! Otherwise it could happen that attackers gain an incredible amount
				-- of experience, when a friendly and an enemy ship die at the same time!
				SobGroup_Clear("sob_tempAttacker")
				SobGroup_FillCompare("sob_tempAttacker", globalShipTable[i][j][SobGroup], "sob_attackers")
				if( SobGroup_Count("sob_tempAttacker") > 0 and SobGroup_HealthPercentage("sob_tempAttacker") > 0 ) then
					-- if so:
					-- 1. add its Player- and ShipIndex to the attackerTable
					-- 2. add the ships attackstrength (attacker_Strength * attacker_RankMultiplier) to the total attackstrength
					tinsert(attackerTable, {i, j})
					totalAttackerStrength = totalAttackerStrength + globalShipTable[i][j][Strength] * rankInfoTable[globalShipTable[i][j][Rank]][2]
					--print(">> Living Attacker found!")
				end
				
			end
		end
	end
	
	return attackerTable
end


----------------------------------------------------------------------------------------------------
experienceDisplayed = 1

function displayExperience()
	
	if( HitCounter_F9 == 0 and experienceDisplayed == 0 ) then
		experienceDisplayed = 1
		for i = 0, Universe_PlayerCount()-1 do
			if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
				for j = 1, getn(globalShipTable[i]) do
					FX_StartEvent(globalShipTable[i][j][SobGroup], rankInfoTable[globalShipTable[i][j][Rank]][3].."_loop" )
				end
			end
		end
		
	elseif( HitCounter_F9 == 1 and experienceDisplayed == 1 ) then
		experienceDisplayed = 0
		for i = 0, Universe_PlayerCount()-1 do
			if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
				for j = 1, getn(globalShipTable[i]) do
					FX_StopEvent(globalShipTable[i][j][SobGroup], rankInfoTable[globalShipTable[i][j][Rank]][3].."_loop" )
				end
			end
		end
		
	end
end

