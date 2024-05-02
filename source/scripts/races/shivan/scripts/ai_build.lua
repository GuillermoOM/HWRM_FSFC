aitrace("LOADING TERRAN BUILD INFO")

kCollector = TER_ELYSIUM
kRefinery = TER_ZEPHYRUS
kScout = TER_PEGASUS
kInterceptor = TER_PERSEUS
kBomber = TER_URSA
kCarrier = TER_ORION
kShipYard = TER_ORION
kDestroyer = TER_DEIMOS
kBattleCruiser = TER_ORION

function DetermineDemandWithNoCounterInfo_Terran()
	if (sg_randFavorShipType < 55) then
		ShipDemandAddByClass( eFighter, 1 )
	elseif (sg_randFavorShipType < 85) then
		ShipDemandAddByClass( eCorvette, 1 )
	elseif (g_LOD < 2 and sg_randFavorShipType < 95) then
		ShipDemandAddByClass( eFrigate, 1 )
	else
		ShipDemandAdd( kDestroyer, 1.0 )
	end
end

function DetermineSpecialDemand_Terran()
	if (gameTime() < 2*60)  then
		ShipDemandSet( TER_ORION, 0)
		ShipDemandSet( TER_ORION, 0)		
	end
		resourcers = TER_ELYSIUM
		local numResourcers = NumSquadrons(kCollector) + NumSquadronsQ(kCollector)
		if (numResourcers > 9 ) then
		ShipDemandAdd( kRefinery, 0.5 )
	end

	local numCarriers = numActiveOfClass( s_enemyIndex, eBuilder )
	if (s_selfTotalValue > 75) and (numCarriers > 2 ) then
		ShipDemandAddByClass( eBuilder, 8.5 )
		end

	local torpedoDemand = -0.5		
	if (s_militaryStrength > 40 or GetRU() > 2500) then
		torpedoDemand = 0
	end
	ShipDemandAdd( TER_FENRIS, torpedoDemand )

	local numShipyards = NumSquadrons( kShipYard ) + NumSquadronsQ( kShipYard )
	if (numShipyards == 0 and UnderAttackThreat() < -75) then
		local bcDemand = ShipDemandGet( kBattleCruiser )
		if (bcDemand >= 0.5) then
			ShipDemandAdd( kShipYard, bcDemand-0.5 )
		end
	end
	if (s_militaryStrength > 25*sg_moreEnemies) then
		ShipDemandAddByClass( ePlatform, -2 )
	end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Terran
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Terran
