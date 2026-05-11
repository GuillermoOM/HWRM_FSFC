aitrace("LOADING TERRAN BUILD INFO")

kCollector = TER_ELYSIUM
kCollectorFS1 = TER_ELYSIUM
kRefinery = TER_ZEPHYRUS

-- Era Counterparts
kScoutFS2 = TER_PEGASUS
kScoutFS1 = TER_LOKI
kInterceptorFS2 = TER_PERSEUS
kInterceptorFS1 = TER_APOLLO
kHeavyFighterFS2 = TER_MYRMIDON
kHeavyFighterFS1 = TER_VALKYRIE
kBomberFS2 = TER_HERCULESMK2
kBomberFS1 = TER_ATHENA
kDestroyerFS2 = TER_DEIMOS
kDestroyerFS1 = TER_FENRIS
kMissileDestroyerFS2 = TER_AEOLUS
kMissileDestroyerFS1 = TER_LEVIATHAN
kBattleCruiserFS2 = TER_HECATE
kBattleCruiserFS1 = TER_ORION

function CpuBuild_UpdateRaceVariables()
	kScout = Util_PickBestShip(kScoutFS2, kScoutFS1)
	kInterceptor = Util_PickBestShip(kInterceptorFS2, kInterceptorFS1)
	kBomber = Util_PickBestShip(kBomberFS2, kBomberFS1)
	kDestroyer = Util_PickBestShip(kDestroyerFS2, kDestroyerFS1)
	kMissileDestroyer = Util_PickBestShip(kMissileDestroyerFS2, kMissileDestroyerFS1)
	kBattleCruiser = Util_PickBestShip(kBattleCruiserFS2, kBattleCruiserFS1)
	kCarrier = kBattleCruiserFS1 -- Defaults
	kResearch = TER_FAUSTUS
	kAWACS = TER_CHARYBDIS
end

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

end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Terran
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Terran
