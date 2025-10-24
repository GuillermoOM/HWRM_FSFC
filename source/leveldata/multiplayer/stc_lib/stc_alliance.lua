----------------------------------------------------------------------------------------------------
-- ALLIANCE ROUTINE
----------------------------------------------------------------------------------------------------

-- player slot to use for the alliance (must be empty)
ALLIANCE_playerSlot = -1
-- sobgroup to put alliance ships into
ALLIANCE_sobgroup = "ALLIANCE_sobgroup"
-- sobgroup to add new alliance ships to, which still need to be brought out of hyperspace
ALLIANCE_sobgroup_tmp = "ALLIANCE_sobgroup_tmp"
-- player with which the alliance is established (-1 no alliance)
ALLIANCE_player = -1
-- table which stores if a player already had the alliance established (0 no alliance)
ALLIANCE_playerTable = {}
-- amount of RU spent in total
ALLIANCE_feeTotalSpent = 0
-- amount of penalty RU the player has to pay this cycle
ALLIANCE_feePenalty = 0
-- mutliplier for the fee
ALLIANCE_feeMultiplier = 1.0
-- maximum enemy threat (determines how many ships to add for the player)
ALLIANCE_enemyThreat = 0
-- Table containing the current level settings
ALLIANCE_currentLevel = {}
-- Table which contains all dominions ships
ALLIANCE_shipTable = {}
-- Table containing free ship indices
ALLIANCE_shipIndexTable = {}


function ALLIANCE_Init()
	-- only proceed if era is TNG
	if( eraoption == 4 ) then
		--print(">> ALLIANCE >> | Init...")
		-- calculate accumulated distribution of class probabilites for all alliance levels
		-- for all alliance levels
		for i = 1, getn(ALLIANCE_levels) do
			-- for all probabilites
			for j = 2, getn(ALLIANCE_levels[i].classProb) do
				-- calc accumulated probability
				ALLIANCE_levels[i].classProb[j] = ALLIANCE_levels[i].classProb[j] + ALLIANCE_levels[i].classProb[j-1]
			end
		end
		
		for i = 0, Universe_PlayerCount()-1 do
			ALLIANCE_playerTable[i] = 0
		end
		
		-- search for an empty player slot (need to add this as a rule, because empty player slots
		-- are killed the beginning of a match (after 1/10 seconds) and thus only then accessable
		-- for us)
		Rule_Add("ALLIANCE_FindPlayerSlot")
		
	end
end


-- searches for an empty player slot to be used by the alliance (needed for when the dom ships change sides)
function ALLIANCE_FindPlayerSlot()
	
	-- find an empty player slot
	-- loop over all players
	for i = 0, Universe_PlayerCount()-1 do
		-- if there's a dead player, we've found an empty player slot!
		if(Player_IsAlive(i) == 0) then
			-- set player slot to empty player
			ALLIANCE_playerSlot = i
			break
		end
	end
	
	-- add a volume for every player to add alliance ships to
	-- loop over all players
	for i = 0, Universe_PlayerCount()-1 do
		-- if alive
		if(Player_IsAlive(i) == 1) then
			-- add volume at presumed starting position
			Volume_AddSphere("ALLIANCE_Volume"..i, SobGroup_GetPosition("Player_Ships"..i), 1000)
		end
	end
	
	-- if we have found an empty player slot
	if( ALLIANCE_playerSlot ~= -1 ) then
		-- reset all alliance variables
		ALLIANCE_reset()
		-- add main alliance rule
		Rule_Add("ALLIANCE_Rule_Idle")
		--print(">> ALLIANCE >> | using empty player slot "..ALLIANCE_playerSlot)
		
	-- if we haven't found an emty player slot
	else
		-- restrict alliance option for all other players
		for i = 0, Universe_PlayerCount()-1 do
			if(Player_IsAlive(i) == 1 and Player_HasResearch(i, ALLIANCE_research) == 0 and Player_CanResearch(i, ALLIANCE_research) == 1) then
				Player_RestrictResearchOption(i, ALLIANCE_research)
			end
		end
		--print(">> ALLIANCE >> | cannot find any empty player slot")
		--print(">> ALLIANCE >> | Dominion Alliance system disabled.")
	end
	
	-- remove current rule
	Rule_Remove("ALLIANCE_FindPlayerSlot")
end

-- main rule which is executed as long as no alliance is established
function ALLIANCE_Rule_Idle()
	-- loop over all players
	for i = 0, Universe_PlayerCount()-1 do
		if(Player_IsAlive(i) == 1) then
			
			-- is one player starting alliance research?
			-- if Player_HasQueuedResearch(i, ALLIANCE_research) == 1 then
				-- show subtitle
				-- ALLIANCE_ShowSubtitle(i, ALLIANCE_subtitleTable.start[random(1, getn(ALLIANCE_subtitleTable.start))], 3)
				
			-- end
			
			-- if one has signed the contract and hasn't signed it before
			if ALLIANCE_playerTable[i] == 0 and Player_HasResearch(i, ALLIANCE_research) == 1 then
				-- show subtitle
				ALLIANCE_ShowSubtitle(i, ALLIANCE_subtitleTable.welcome[random(1, getn(ALLIANCE_subtitleTable.welcome))], 3)
				
				-- set alliance player
				ALLIANCE_player = i
				-- store that this player had the alliance
				ALLIANCE_playerTable[i] = 1
				-- restrict alliance option for all other players
				for j = 0, Universe_PlayerCount()-1 do
					if( Player_IsAlive(j) == 1 and Player_HasResearch(j, ALLIANCE_research) == 0 and Player_CanResearch(j, ALLIANCE_research) == 1 ) then
						Player_RestrictResearchOption(j, ALLIANCE_research)
					end
				end
				
				--print(">> ALLIANCE >> | Established alliance with player "..i)
				
				-- add taxes rule
				Rule_AddInterval("ALLIANCE_CollectTaxes", ALLIANCE_feeInterval)
				-- add ship adding rule
				Rule_AddInterval("ALLIANCE_Rule_Good_Loop", ALLIANCE_addShipInterval)
				-- remove current rule
				Rule_Remove("ALLIANCE_Rule_Idle")
				
				break
			end
		end
	end
end


-- rule which collects taxes every now and then
function ALLIANCE_CollectTaxes()
	-- if player has enough resources
	if Player_GetRU(ALLIANCE_player) >= ALLIANCE_feeMultiplier*ALLIANCE_fee + ALLIANCE_feePenalty then
		--print(">> ALLIANCE >> | Collecting taxes...")
		--print(">> ALLIANCE >> | Taxes:     "..ALLIANCE_feeMultiplier*ALLIANCE_fee)
		--print(">> ALLIANCE >> | Penalties: "..ALLIANCE_feePenalty)
		-- debit the fee
		Player_SetRU(ALLIANCE_player, Player_GetRU(ALLIANCE_player) - (ALLIANCE_feeMultiplier*ALLIANCE_fee + ALLIANCE_feePenalty))
		-- sum up total paid fee
		ALLIANCE_feeTotalSpent = ALLIANCE_feeTotalSpent + ALLIANCE_feeMultiplier*ALLIANCE_fee
		-- increase fee
		ALLIANCE_feeMultiplier = ALLIANCE_feeMultiplier*ALLIANCE_feeIncrease
		
		-- show subtitle
		ALLIANCE_ShowSubtitle(ALLIANCE_player, ALLIANCE_subtitleTable.collectFee[random(1, getn(ALLIANCE_subtitleTable.collectFee))], 1)
		
	-- if player has NOT enough resources
	else
		--print(">> ALLIANCE >> | Player has no money anymore... how bad for him :)")
		-- debit everything what's there
		Player_SetRU(ALLIANCE_player, 0)
		-- make dominion ships unselectable (so that the player cannot destroy them manually)
		SobGroup_MakeSelectable(ALLIANCE_sobgroup, 0)
		-- show subtitle
		ALLIANCE_ShowSubtitle(ALLIANCE_player, ALLIANCE_subtitleTable.notEnoughRU[random(1, getn(ALLIANCE_subtitleTable.notEnoughRU))], 5)
		
		-- add evil rule
		Rule_AddInterval("ALLIANCE_Rule_Evil", 10)
		-- remove current rule
		Rule_Remove("ALLIANCE_CollectTaxes")
		-- remove ship adding rule
		Rule_Remove("ALLIANCE_Rule_Good_Loop")
	end
end

-- determines how many ships to add to the player from the alliance
function ALLIANCE_Rule_Good_Loop()
	
	-- determine penalties
	ALLIANCE_feePenalty = 0
	-- check for dead alliance ships
	local size = getn(ALLIANCE_shipTable)
	local i = 1
	while( i <= size ) do	
		-- if there's a dead ship
		if( SobGroup_Empty(ALLIANCE_shipTable[i].sob) == 1
			or SobGroup_HealthPercentage(ALLIANCE_shipTable[i].sob) <= 0 ) then
			-- increase penatly value
			ALLIANCE_feePenalty = ALLIANCE_feePenalty + ALLIANCE_shipTable[i].penalty
			-- add a free ship index
			ALLIANCE_addFreeShipIndex(ALLIANCE_shipTable[i].sobIndex)
			-- remove entry from shipTable
			tremove(ALLIANCE_shipTable, i)
			i = i - 1
			size = size - 1 -- this doesn't work with a for loop
		end
		i = i + 1
	end
	
	-- calculate own strength and strength of the strongest enemy
	ALLIANCE_playerStrengths = ALLIANCE_CalcStrengths()
	--print("Strength of enemy: "..ALLIANCE_playerStrengths[2])
	
	-- determine current level depending on total number of fees paid and enemy threat
	for i = getn(ALLIANCE_levels), 1, -1 do
		if( ALLIANCE_feeTotalSpent >= ALLIANCE_levels[i].feeSpent
			or ALLIANCE_playerStrengths[2] - ALLIANCE_playerStrengths[1] >= ALLIANCE_levels[i].enemyThreat ) then
			ALLIANCE_currentLevel = ALLIANCE_levels[i]
			--print(">> ALLIANCE >> | Alliance level is "..i)
			break
		end
	end
	
	
	-- determine current level depending on total number of fees paid
	for i = getn(ALLIANCE_levels), 1, -1 do
		if( ALLIANCE_feeTotalSpent >= ALLIANCE_levels[i].feeSpent ) then
			ALLIANCE_enemyThreat = ALLIANCE_levels[i].enemyStrengthMultiplier*ALLIANCE_playerStrengths[2] - ALLIANCE_playerStrengths[1]
			--print(">> ALLIANCE >> | Alliance fee level is "..i)
			break
		end
	end
	
	-- calculate effective threat aka help to be send out by the alliance
	-- ALLIANCE_enemyThreat = ALLIANCE_currentLevel.enemyStrengthMultiplier*ALLIANCE_playerStrengths[2] - ALLIANCE_playerStrengths[1]
	--print("Threat: "..ALLIANCE_enemyThreat)
	
	--print(">> ALLIANCE >> | Enemy threat is "..ALLIANCE_enemyThreat)
	
	-- if there's the need of help by the alliance
	if ALLIANCE_enemyThreat > 0 then
		-- add ships until there's no need anymore
		while ALLIANCE_enemyThreat > 0 do
			ALLIANCE_AddShip()
		end
		-- return new ships out of hyperspace
		Rule_AddInterval("ALLIANCE_ReturnOutOfHyperspace", 1)
	end
	
end

-- randomly adds an alliance ship to the player
function ALLIANCE_AddShip()
	
	-- throw dice to determine out of which group we want to add a ship
	local randNum = random()
	--print(">> ALLIANCE >> | Throwing dice... "..randNum)
	for i = 1, getn(ALLIANCE_currentLevel.classProb) do
		if randNum <= ALLIANCE_currentLevel.classProb[i] then
			randNum = i
			break
		end
	end
	
	
	-- throw dice to determine which ship out of this group we want to add
	
	local rand = random(1, getn(ALLIANCE_shipClasses[randNum]))
	--print(">> ALLIANCE >> | Throwing dice again... "..rand)
	local randClass = ALLIANCE_shipClasses[randNum][rand]
	
	-- add ship class specific values to ship table
	local tmpTable = {}
	tmpTable.class = randClass.class
	tmpTable.penalty = randClass.penalty
	tmpTable.sobIndex = ALLIANCE_getFreeShipIndex()
	tmpTable.sob = "ALLIANCE_ship"..tmpTable.sobIndex
	
	tinsert(ALLIANCE_shipTable, tmpTable)
	
	--print(">> ALLIANCE >> | Adding ship "..randClass.class)
	
	-- create sob for the new ship
	SobGroup_Create(tmpTable.sob)
	SobGroup_Clear(tmpTable.sob)
	
	-- spawn new ship and bring it in hyperspace
	SobGroup_SpawnNewShipInSobGroup(ALLIANCE_player, tmpTable.class, "MySquadron", tmpTable.sob, "ALLIANCE_Volume"..ALLIANCE_player)
	SobGroup_Despawn(tmpTable.sob)
	
	-- add new ship to default sobgroups
	SobGroup_SobGroupAdd(ALLIANCE_sobgroup, tmpTable.sob)
	SobGroup_SobGroupAdd(ALLIANCE_sobgroup_tmp, tmpTable.sob)
	
	-- calculate new enemy threat
	ALLIANCE_enemyThreat = ALLIANCE_enemyThreat - shipClassStatsTable[tmpTable.class][5]
	
	--print(">> ALLIANCE >> | New Threat is "..ALLIANCE_enemyThreat)
end

-- returns own strength and strength of the strongest enemy
function ALLIANCE_CalcStrengths()
	-- calculate strengths of all player by summing over all their ships
	local strength = {}
	-- for all players
	for i = 0, Universe_PlayerCount()-1 do
		strength[i] = 0
		if(Player_IsAlive(i) == 1) then
			-- for all ships
			for j = 1, getn(globalShipTable[i]) do
				-- sum up strengths
				if globalShipTable[i][j][IsMilitary] == 1 then
					strength[i] = strength[i] + globalShipTable[i][j][Strength]
				end
			end
		end
	end
	
	-- calculate average enemy strength
	-- local strength_average = 0
	-- local Player_Alive = 0
	-- for i = 0, Universe_PlayerCount()-1 do
		-- if( Player_IsAlive(i) == 1 and i ~= ALLIANCE_player and AreAllied(i, ALLIANCE_player) == 0 ) then
			-- strength_average = strength_average + strength[i]
			-- Player_Alive = Player_Alive + 1
		-- end
	-- end
	-- return strength_average/Player_Alive - strength[ALLIANCE_player]
	
	-- calculate strength of the strongest enemy
	local strength_max = 0
	-- for all players
	for i = 0, Universe_PlayerCount()-1 do
		--print(">> ALLIANCE >> | Strength of player "..i.." : "..strength[i])
		-- if alive, not allied and not the player itself
		if( Player_IsAlive(i) == 1 and i ~= ALLIANCE_player and AreAllied(i, ALLIANCE_player) == 0 ) then
			-- if stronger than currently strongest known to us
			if strength_max < strength[i] then
				-- set maximum enemy strength
				strength_max = strength[i]
			end
		end
	end
	
	-- return own strength and strength of the strongest enemy
	return {strength[ALLIANCE_player], strength_max}
	
end

-- returns the next free SobGroup index.
function ALLIANCE_getFreeShipIndex()
	local i = 1
	-- do we have old ship indices?
	if( getn(ALLIANCE_shipIndexTable) > 0 ) then
		i = tremove(ALLIANCE_shipIndexTable)
	-- if not create a new one
	else
		i = 1 + getn(ALLIANCE_shipTable)
	end
	return i
end

-- adds an index to the pool
function ALLIANCE_addFreeShipIndex(i)
	tinsert(ALLIANCE_shipIndexTable, i)
end

-- returns newly added ships out of hyperspace
function ALLIANCE_ReturnOutOfHyperspace()
	-- if there are ships in hyperspace
	if SobGroup_Count(ALLIANCE_sobgroup_tmp) > 0 then
		
		--print(">> ALLIANCE >> | Returning ships out of hyperpspace...")
		
		-- exit hyperspace new the player fleet
		SobGroup_ExitHyperSpaceSobGroup(ALLIANCE_sobgroup_tmp, "Player_Ships"..ALLIANCE_player, 10000)
		-- clear sobgroup
		SobGroup_Clear(ALLIANCE_sobgroup_tmp)
		
		-- show subtitle
		ALLIANCE_ShowSubtitle(ALLIANCE_player, ALLIANCE_subtitleTable.addShips[random(1, getn(ALLIANCE_subtitleTable.addShips))], 5)
	end
	-- remove current rule
	Rule_Remove("ALLIANCE_ReturnOutOfHyperspace")
end

-- rule which determines behaviour when the player couldn't pay the fee
function ALLIANCE_Rule_Evil()
	-- make ships stay in this sobgroup if they change sides
	SobGroup_SetSwitchOwnerFlag(ALLIANCE_sobgroup, 0)
	-- change sides
	SobGroup_SwitchOwner(ALLIANCE_sobgroup, ALLIANCE_playerSlot)
	-- set to aggressive tactics
	SobGroup_SetTactics(ALLIANCE_sobgroup, 0)
	-- attack the foe!
	SobGroup_AttackPlayer(ALLIANCE_sobgroup, ALLIANCE_player)
	-- make dominion ships selectable again
	SobGroup_MakeSelectable(ALLIANCE_sobgroup, 1)
	
	-- show subtitle
	ALLIANCE_ShowSubtitle(ALLIANCE_player, ALLIANCE_subtitleTable.allianceBreak[random(1, getn(ALLIANCE_subtitleTable.allianceBreak))], 5)
	
	-- remove current rule
	Rule_Remove("ALLIANCE_Rule_Evil")
	-- add player crusher rule
	Rule_AddInterval("ALLIANCE_Rule_Evil_Loop", 20)
end

-- player crusher rule. Executed every X seconds to maintain attacking the player
function ALLIANCE_Rule_Evil_Loop()
	-- if he's still alive and we still have ships in the sector
	if(getn(globalShipTable[ALLIANCE_player]) ~= 0 and Player_IsAlive(ALLIANCE_player) == 1 and SobGroup_Count(ALLIANCE_sobgroup) > 0) then
		
		--print(">> ALLIANCE >> | Attacking player "..ALLIANCE_player)
		-- attack the foe!
		SobGroup_AttackPlayer(ALLIANCE_sobgroup, ALLIANCE_player)
		-- show subtitle
		ALLIANCE_ShowSubtitle(ALLIANCE_player, ALLIANCE_subtitleTable.evilLoop[random(1, getn(ALLIANCE_subtitleTable.evilLoop))], 5)
		
	-- otherwise
	else
		-- if the alliance has no ships anymore = the player has defeated the alliance ships
		if SobGroup_Count(ALLIANCE_sobgroup) == 0 then
			-- show subtitle
			ALLIANCE_ShowSubtitle(ALLIANCE_player, ALLIANCE_subtitleTable.dominionDefeated[random(1, getn(ALLIANCE_subtitleTable.dominionDefeated))], 5)
			
			--print(">> ALLIANCE >> | The player defeated the Dominion!")
			
		-- if the player was defeated
		else
			-- get our ships out of here
			SobGroup_EnterHyperSpaceOffMap(ALLIANCE_sobgroup)
			-- show subtitle for all players
			Subtitle_Add(ALLIANCE_subtitleIcon, ALLIANCE_subtitleTable.dominionWon[random(1, getn(ALLIANCE_subtitleTable.dominionWon))], 5)
			
			--print(">> ALLIANCE >> | Dominion won.")
		end
		
		-- remove current rule
		Rule_Remove("ALLIANCE_Rule_Evil_Loop")
		-- add alliance end rule to reset alliance settings
		Rule_AddInterval("ALLIANCE_Rule_EndAlliance", 20)
	end
end

-- resets alliance settings and brings back alliance into idle modus
function ALLIANCE_Rule_EndAlliance()
	-- reset all alliance variables
	ALLIANCE_reset()
	
	-- go back to where we started
	Rule_Remove("ALLIANCE_Rule_EndAlliance")
	Rule_Add("ALLIANCE_Rule_Idle")
end

-- show subtitle to alliance player
function ALLIANCE_ShowSubtitle(player, message, time)
	if player == FE_GetCurrentPlayerIndex() then
		Subtitle_Add(ALLIANCE_subtitleIcon, message, time)
	end
end

-- resets all alliance variables and sobgroups
function ALLIANCE_reset()
	-- prepare sobgroup
	SobGroup_Create(ALLIANCE_sobgroup)
	-- kill our ships
	SobGroup_SetHealth(ALLIANCE_sobgroup, 0)
	-- clear sobgroup
	SobGroup_Clear(ALLIANCE_sobgroup)
	
	SobGroup_Create(ALLIANCE_sobgroup_tmp)
	SobGroup_Clear(ALLIANCE_sobgroup_tmp)
	
	-- reset variables
	ALLIANCE_enemyThreat = 0
	ALLIANCE_feeTotalSpent = 0
	ALLIANCE_feePenalty = 0
	ALLIANCE_shipTable = {}
	ALLIANCE_feeMultiplier = 1.0
	ALLIANCE_player = -1
	
	-- un-restrict alliance option for all players
	for i = 0, Universe_PlayerCount()-1 do
		if(Player_IsAlive(i) == 1 and Player_HasResearch(i, ALLIANCE_research) == 0 and Player_CanResearch(i, ALLIANCE_research) == 0) then
			Player_UnrestrictResearchOption(i, ALLIANCE_research)
		end
	end
	
	--print(">> ALLIANCE >> | All alliance options reseted")
end