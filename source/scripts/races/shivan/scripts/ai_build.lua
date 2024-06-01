aitrace("LOADING SHIVAN BUILD INFO")

kCollector = SHI_AZRAEL
kRefinery  = SHI_DEMON
kScout     = SHI_ASTAROTH
kCarrier   = SHI_RAVANA
kDestroyer = SHI_LILITH
kBattleCruiser = SHI_LUCIFER

function DetermineDemandWithNoCounterInfo_Shivan()
	if (sg_randFavorShipType < 55) then
		ShipDemandAddByClass(eFighter, 1)
	elseif (sg_randFavorShipType < 85) then
		ShipDemandAddByClass(eCorvette, 0.6)
	elseif (g_LOD < 2 and sg_randFavorShipType < 95) then
		ShipDemandAddByClass(eFrigate, 0.4)
	else
		ShipDemandAdd(eDestroyer, 0.2)
	end
end

function DetermineSpecialDemand_Shivan()
	local numEnemyCarriers  = numActiveOfClass(s_enemyIndex, eBuilder)
	local numActiveCarriers = numActiveOfClass(s_playerIndex, eBuilder)

	local FrigateDemand     = numActiveOfClass(s_enemyIndex, eFrigate)

	local shipId = FindHighDemandShip()

	if (gameTime() < 2 * 60) then
		ShipDemandSetByClass(eBattleCruiser, 0)
	end

	controller = kRefinery
	local numControllers = NumSquadrons(controller) + NumSquadronsQ(kRefinery)
	if (numControllers > 5) then
		ShipDemandSet(kRefinery, 0)
	end

	resourcers = kCollector
	local numResourcers = NumSquadrons(kCollector) + NumSquadronsQ(kCollector)
	if (numResourcers > 9) then
		ShipDemandAdd(kRefinery, 0.5)
	end

	if (s_selfTotalValue > 75) and (numEnemyCarriers > 1) then
		ShipDemandAdd(eDestroyer, 4.5)
	end

	if (s_selfTotalValue > 75) and (numEnemyCarriers > 1) and (GetRU() > 2800) then
		ShipDemandAddByClass(eBuilder, FrigateDemand + 20.0)
		shipId = FindHighDemandShip()
		Build(shipId)
	end

	if (numActiveCarriers == 3) then
		ShipDemandSetByClass(eBuilder, 0)
		ShipDemandAdd(eDestroyer, 7.5)
	end

	if (s_militaryStrength > 25 * sg_moreEnemies) then
		ShipDemandAddByClass(ePlatform, -2)
	end

	if (numActiveOfClass(s_enemyIndex, eFighter) > 0 and numActiveOfClass(s_playerIndex, eFighter) < 7 and s_militaryPop < 22) then
		ShipDemandAddByClass(eFighter, 1)
	end

	
	if ((GetNumCollecting() > 9 or GetRU() > 3500) and s_militaryPop > 15 and UnderAttackThreat() < -75) then
		ShipDemandAdd(SHI_DEMON, 2.5)
	end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Shivan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Shivan
