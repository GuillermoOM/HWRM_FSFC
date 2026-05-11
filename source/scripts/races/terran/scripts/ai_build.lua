aitrace("LOADING TERRAN BUILD INFO")

kCollector = TER_ELYSIUM
kRefinery = TER_ZEPHYRUS
kScout = TER_LOKI
kInterceptor = TER_VALKYRIE
kBomber = TER_HERCULESMK2
kCarrier = TER_HECATE
kResearch = TER_FAUSTUS
kDestroyer = TER_DEIMOS
kMissileDestroyer = TER_AEOLUS
kBattleCruiser = TER_ORION
kAWACS = TER_CHARYBDIS

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

end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Terran
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Terran
