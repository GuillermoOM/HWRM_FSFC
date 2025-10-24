----------------------------------------------------------------------------------------------------
-- WIN CONDITIONS - rules, which kill players under specific conditions
----------------------------------------------------------------------------------------------------
AnyPlayerIndex = 0

----------------------------------------------------------------------------------------------------
-- Kills a player if the player has no production capability
--
function CheckPlayerProductionShipsLeftRule()
	
	for AnyPlayerIndex = 0, (Universe_PlayerCount() - 1) do
		if ((Player_IsAlive(AnyPlayerIndex) == 1) and (Player_HasRealBuilder(AnyPlayerIndex) == 0)) then
			Player_Kill(AnyPlayerIndex)
		end
	end
end

----------------------------------------------------------------------------------------------------
-- Kills a player if no team member has any production capability
--
function CheckTeamProductionShipsLeftRule()
	if (Player_IsAlive(AnyPlayerIndex) == 1) then
		local bDead = 1
		for otherPlayerIndex = 0, (Universe_PlayerCount() - 1) do
			if ((AreAllied(AnyPlayerIndex, otherPlayerIndex) == 1) and (Player_IsAlive(otherPlayerIndex) == 1)) and ((Player_HasRealBuilder(otherPlayerIndex) == 1) or (Player_HasRealBuilder(AnyPlayerIndex) == 1)) then
				bDead = 0
				break
			end
		end
		if (bDead == 1) then
			Player_Kill(AnyPlayerIndex)
		end
	end
	
	if (AnyPlayerIndex == (Universe_PlayerCount() - 1)) then
		AnyPlayerIndex = 0
	else
		AnyPlayerIndex = AnyPlayerIndex + 1
	end
end

----------------------------------------------------------------------------------------------------
-- Kills a player if no team member has any ships
--
function CheckTeamAnyShipsLeftRule()
	if (Player_IsAlive(AnyPlayerIndex) == 1) then
		local bDead = 1
		for otherPlayerIndex = 0, (Universe_PlayerCount() - 1) do
			--if ((AreAllied(AnyPlayerIndex, otherPlayerIndex) == 1) and (Player_IsAlive(otherPlayerIndex) == 1) and (SobGroup_Count("Player_Ships"..otherPlayerIndex) > 0 or getn(globalShipTable[otherPlayerIndex]) > 0)) then
			if ((AreAllied(AnyPlayerIndex, otherPlayerIndex) == 1) and (Player_IsAlive(otherPlayerIndex) == 1)) and ((Player_HasRealShip(AnyPlayerIndex) == 1) or (Player_HasRealShip(otherPlayerIndex) == 1)) then

				bDead = 0
				break
			end
		end
		if (bDead == 1) then
			Player_Kill(AnyPlayerIndex)
		end
	end
	
	if (AnyPlayerIndex == (Universe_PlayerCount() - 1)) then
		AnyPlayerIndex = 0
	else
		AnyPlayerIndex = AnyPlayerIndex + 1
	end
end


----------------------------------------------------------------------------------------------------
-- Stops the game from terminating even when all enemies are gone
--
function DoNotQuit()
end

----------------------------------------------------------------------------------------------------
-- Kills only player 1 for single player gauntlet.
--
function CheckPlayer1ProductionShipsLeftRule()
	AnyPlayerIndex = 0
	if ((Player_IsAlive(AnyPlayerIndex) == 1) and (Player_HasRealBuilder(AnyPlayerIndex) == 0)) then
		Player_Kill(AnyPlayerIndex)
	end
end

----------------------------------------------------------------------------------------------------
-- Helper function to determine if a player has no ships with 'real' build cabilities anymore
--
function Player_HasRealBuilder(i)
	SobGroup_Create("sob_tmp_realBuilder")
	SobGroup_Clear("sob_tmp_realBuilder")
	SobGroup_FillUnion("sob_tmp_realBuilder", "Player_Ships"..i, "Player"..i.."_alreadySplittedShips")
	
	for k = 1, getn(noRealBuilderTable) do
		SobGroup_RemoveType("sob_tmp_realBuilder", noRealBuilderTable[k])
	end
	
	if (SobGroup_CanDoAbility("sob_tmp_realBuilder", AB_Builder) == 1) then
		return 1
	else
		return 0
	end
end

-- Helper function to determine if a player has no "real" ships anymore- stealth fighters and subspace nodes...
--

function Player_HasRealShip(i)
	SobGroup_Create("sob_tmp_realShip")
	SobGroup_Clear("sob_tmp_realShip")
	SobGroup_FillUnion("sob_tmp_realShip", "Player_Ships"..i, "Player"..i.."_alreadySplittedShips")
	
	for k = 1, getn(noRealShipTable) do
		SobGroup_RemoveType("sob_tmp_realShip", noRealShipTable[k])
	end
	
	if (SobGroup_Count("sob_tmp_realShip") > 0) then
		return 1
	else
		return 0
	end
end
