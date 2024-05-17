aitrace("LOADING TERRAN BUILD INFO")

kCollector        = TER_ELYSIUM
kRefinery         = TER_ZEPHYRUS
kScout            = TER_LOKI
kDefender         = TER_FENRIS
kHeavyVette       = TER_URSA
kInterceptor      = TER_PERSEUS
kBomber           = TER_ATHENA
kMgun             = TER_ATHENA
kSpecFighter      = TER_PEGASUS
kCarrier          = TER_HECATE
kDestroyer        = TER_DEIMOS
kMissileDestroyer = TER_AEOLUS
kBattleCruiser    = TER_COLOSSUS

function DetermineDemandWithNoCounterInfo_Terran()
	if (sg_randFavorShipType < 55) then
		ShipDemandAddByClass(eFighter, 1)
	elseif (sg_randFavorShipType < 85) then
		ShipDemandAddByClass(eCorvette, 1)
	elseif (g_LOD < 2 and sg_randFavorShipType < 95) then
		ShipDemandAddByClass(eFrigate, 1)
	else
		ShipDemandAdd(kDestroyer, 1.0)
	end
end

function DetermineSpecialDemand_Terran()
	local numCarriers = NumSquadrons(kCarrier) + NumSquadronsQ(kCarrier)
	local numCruisers = NumSquadrons(kBattleCruiser) + NumSquadronsQ(kBattleCruiser)

	local numEnemyFighters = numActiveOfClass(s_enemyIndex, eFighter)
	local numEnemyVettes = numActiveOfClass(s_enemyIndex, eCorvette)
	local numEnemyFrigates = numActiveOfClass(s_enemyIndex, eFrigate)
	local numEnemyDestroyers = numActiveOfClass(s_enemyIndex, eDestroyer)
	local numEnemyCarriers = numActiveOfClass(s_enemyIndex, eBuilder)
	local numEnemyCruisers = numActiveOfClass(s_enemyIndex, eBattleCruiser)

	local numEnemyAntiFighter = numActiveOfClass(s_enemyIndex, eAntiFighter)
	local numEnemyAntiVettes = numActiveOfClass(s_enemyIndex, eAntiCorvette)
	local numEnemyAntiFrigates = numActiveOfClass(s_enemyIndex, eAntiFrigate)
	local numEnemyAntiCruisers = numActiveOfClass(s_enemyIndex, eSubSystemAttackers)

	local numActiveFighters = numActiveOfClass(s_playerIndex, eFighter)
	local numActiveVettes = numActiveOfClass(s_playerIndex, eCorvette)
	local numActiveFrigates = numActiveOfClass(s_playerIndex, eFrigate)
	local numActiveDestroyers = numActiveOfClass(s_playerIndex, eDestroyer)
	local numActiveCarriers = numActiveOfClass(s_playerIndex, eBuilder)

	local numTotalFighters = PlayersUnitTypeCount(player_enemy, player_total, eFighter)
	local numTotalVettes = PlayersUnitTypeCount(player_enemy, player_total, eCorvette)
	local numTotalFrigs = PlayersUnitTypeCount(player_enemy, player_total, eFrigate)
	local numTotalDestroyers = PlayersUnitTypeCount(player_enemy, player_total, eDestroyer)

	local numMissileDestroyers = NumSquadrons(kMissileDestroyer) + NumSquadronsQ(kMissileDestroyer)

	local FighterDemand = numActiveOfClass(s_enemyIndex, eFighter)
	local CorvetteDemand = numActiveOfClass(s_enemyIndex, eCorvette)
	local FrigateDemand = numActiveOfClass(s_enemyIndex, eFrigate)
	local DestroyerDemand = numActiveOfClass(s_enemyIndex, eDestroyer)
	local CruiserDemand = numActiveOfClass(s_enemyIndex, eBattleCruiser)

	local AssaultFrigateDemand = ShipDemandGet(TER_FENRIS)

	local FighterThresh = 0
	local CorvetteThresh = 0
	local FrigateThresh = 0
	local DestroyerThresh = 0

	if (numEnemyFighters > 5) and (numActiveFighters < numEnemyFighters) then
		FighterThresh = 1
	else
		FighterThresh = 0
	end

	if (numEnemyVettes > 5) and (numActiveVettes < numEnemyVettes) then
		CorvetteThresh = 1
	else
		CorvetteThresh = 0
	end

	if (numEnemyFrigates > 5) and (numActiveFrigates < numEnemyFrigates) then
		FrigateThresh = 1
	else
		FrigateThresh = 0
	end


	local shipId       = FindHighDemandShip()
	local BestTarget   = HighestPriorityShip()

	local totalProd    = numActiveCarriers
	s_militaryPop      = PlayersMilitaryPopulation(s_playerIndex, player_total);
	s_selfTotalValue   = PlayersMilitary_Total(s_playerIndex, player_total);
	s_enemyTotalValue  = PlayersMilitary_Total(player_enemy, player_max);
	s_militaryStrength = PlayersMilitary_Threat(player_enemy, player_min);
	s_enemyIndex       = GetChosenEnemy()


	if (s_selfTotalValue > 5) and (numEnemyFighters > 5) and (FighterThresh ~= 0) then
		ShipDemandAddByClass(eAntiFighter, 0.5)
		ShipDemandAdd(kMgun, 0.5)
		ShipDemandAdd(kDefender, AssaultFrigateDemand + 0.5)
		ShipDemandAddByClass(eCorvette, 0.5)
		ShipDemandAdd(kMissileDestroyer, 0.5)
		Build(shipId)
	else
		if (FighterThresh == 1) then
			ShipDemandAddByClass(eAntiFighter, -0.15)
			ShipDemandAdd(kMgun, -0.15)
			ShipDemandAdd(kDefender, -0.15)
			ShipDemandAddByClass(eCorvette, -0.15)
			ShipDemandAdd(kMissileDestroyer, -0.15)
		end
	end

	if (s_selfTotalValue > 10) and (numEnemyVettes > 5) and (CorvetteThresh ~= 0) then
		ShipDemandAddByClass(eAntiCorvette, 0.5)
		ShipDemandAddByClass(eCorvette, 0.5)
		ShipDemandAdd(kMissileDestroyer, 0.5)
		Build(shipId)
	else
		if (CorvetteThresh == 1) then
			ShipDemandAddByClass(eAntiFighter, -0.15)
			ShipDemandAdd(kMgun, -0.15)
			ShipDemandAdd(kDefender, -0.15)
			ShipDemandAddByClass(eCorvette, -0.15)
			ShipDemandAdd(kMissileDestroyer, -0.15)
		end
	end

	if (s_selfTotalValue > 120) then
		local additionalFrigDemand = 0.5
		ShipDemandAddByClass(eFrigate, additionalFrigDemand)
		ShipDemandAddByClass(eFighter, 0.65)
		Build(shipId)
	end


	if (numEnemyFrigates > 10) and (numActiveFrigates / numActiveVettes + numActiveFighters > 0.4) then
		ShipDemandAddByClass(eFighter, 0.95)
		ShipDemandAddByClass(eCorvette, 0.95)
		ShipDemandAddByClass(eFrigate, -3.0)
	end


	if (s_selfTotalValue > 75) and (numEnemyVettes > 5) and (numActiveVettes < numEnemyVettes) then
		ShipDemandAddByClass(eFighter, 0.15)
		ShipDemandAddByClass(eCorvette, 0.45)
		ShipDemandAddByClass(eAntiCorvette, 0.35)
	end

	if (s_selfTotalValue > 75) and (numEnemyFrigates > 5) then
		ShipDemandAddByClass(eFighter, 0.35)
		ShipDemandAddByClass(eCorvette, 0.25)
		ShipDemandAddByClass(eAntiFrigate, 0.35)
	else
		if (s_selfTotalValue > 75) and (numEnemyFrigates > 10) then
			ShipDemandAddByClass(eAntiFrigate, 0.5)
			ShipDemandAddByClass(eFighter, 0.35)
			ShipDemandAddByClass(eCorvette, 0.45)
			ShipDemandAdd(kDestroyer, 0.75)
		else
			if (s_selfTotalValue > 75) and (numEnemyFrigates > 15) then
				ShipDemandAdd(kDestroyer, 1.75)
			else
				if (s_selfTotalValue > 75) and (numEnemyFrigates > 18) then
					ShipDemandAdd(kBattleCruiser, 2.5)
				else
					if (s_selfTotalValue > 75) and (numEnemyFrigates > 10) and (numActiveFrigates < numEnemyFrigates) then
						ShipDemandAddByClass(eCorvette, FrigateDemand)
					end
				end
			end
		end
	end

	if (numActiveFrigates > numActiveVettes + numActiveFighters) then
		ShipDemandAddByClass(eCorvette, FrigateDemand)
		ShipDemandAddByClass(eFighter, FrigateDemand)
	end

	controller = TER_ZEPHYRUS
	local numControllers = NumSquadrons(controller) + NumSquadronsQ(kRefinery)
	if (numControllers > 5) then
		ShipDemandSet(kRefinery, 0)
	else
		resourcers = TER_ELYSIUM
		local numResourcers = NumSquadrons(kCollector) + NumSquadronsQ(kCollector)
		if (numResourcers > 9) then
			ShipDemandAdd(kRefinery, 0.5)
		end
	end

	if (numEnemyFrigates < 5) then
		ShipDemandSet(kBomber, 0)
		ShipDemandAdd(kBomber, -10.5)
	end

	if (numEnemyFrigates > 5) then
		ShipDemandSet(kBomber, 3)
		ShipDemandAdd(kBomber, 3.5)
	end

	if numTotalDestroyers > 0 then
		ShipDemandAdd(kDestroyer, DestroyerDemand)
		ShipDemandAdd(kMissileDestroyer, DestroyerDemand + (numTotalDestroyers / 2 - numMissileDestroyers))
	else
		ShipDemandAdd(kDestroyer, 0.05)
		ShipDemandAddByClass(eBuilder, DestroyerDemand + 20.0)
	end

	if numEnemyFighters > 10 then
		ShipDemandAdd(kMgun, FighterDemand + (numEnemyFighters + numActiveFighters))
	end

	if (s_selfTotalValue > 75) and (numEnemyCarriers > 1) and (GetRU() > 2800) then
		ShipDemandAddByClass(eBuilder, FrigateDemand + 20.0)
		Build(TER_HECATE)
	end

	if (s_selfTotalValue > 75) and (numEnemyCarriers > 1) and (CanBuild(TER_HECATE) == 1 and GetRU() > 2800) then
		ShipDemandAddByClass(eBuilder, FrigateDemand + 20.0)
		Build(TER_HECATE)
	end


	kushancarrier = TER_HECATE
	if (numCarriers == 2) then
		ShipDemandSet(TER_HECATE, 0)
	end


	if (numCarriers > 2) and (numCruisers < 3) and (numEnemyDestroyers > 2) and (GetRU() > 2800) then
		ShipDemandAdd(kBattleCruiser, 12.5)
		Build(TER_DEIMOS)
	else
		if (numCarriers > 2) and (numCruisers == 2) then
			ShipDemandSet(TER_DEIMOS, 0)
		end
	end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Terran
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Terran
