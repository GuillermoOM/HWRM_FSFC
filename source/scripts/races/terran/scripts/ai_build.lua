dofilepath("data:scripts/custom_scripts/ai_telemetry.lua")
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
kBomberFS2 = TER_ARTEMIS
kBomberFS1 = TER_ZEUS
kDestroyerFS2 = TER_DEIMOS
kDestroyerFS1 = TER_FENRIS_FS1
kMissileDestroyerFS2 = TER_AEOLUS
kMissileDestroyerFS1 = TER_LEVIATHAN_FS1
kBattleCruiserFS2 = TER_HECATE
kBattleCruiserFS1 = TER_ORION_FS1

function CpuBuild_UpdateRaceVariables()
	kScout = Util_PickBestShip(kScoutFS2, kScoutFS1)
	kInterceptor = Util_PickBestShip(kInterceptorFS2, kInterceptorFS1)
	kBomber = Util_PickBestShip(kBomberFS2, kBomberFS1)
	kDestroyer = Util_PickBestShip(kDestroyerFS2, kDestroyerFS1)
	kMissileDestroyer = Util_PickBestShip(kMissileDestroyerFS2, kMissileDestroyerFS1)
	kBattleCruiser = Util_PickBestShip(kBattleCruiserFS2, kBattleCruiserFS1)
	kCarrier = Util_PickBestShip(TER_HECATE, TER_ORION_FS1)
	kResearch = TER_FAUSTUS
	kAWACS = TER_CHARYBDIS
end

function DetermineDemandWithNoCounterInfo_Terran()
	local fighterDemand = 0.5
	local corvetteDemand = 0.3
	local frigateDemand = 0.15
	local destroyerDemand = 0.05
	
	if (sg_randFavorShipType < 40) then
		fighterDemand = fighterDemand + 0.5
	elseif (sg_randFavorShipType < 70) then
		corvetteDemand = corvetteDemand + 0.5
	else
		frigateDemand = frigateDemand + 0.5
	end
	
	ShipDemandAddByClass(eFighter, fighterDemand)
	ShipDemandAddByClass(eCorvette, corvetteDemand)
	ShipDemandAddByClass(eFrigate, frigateDemand)
	
	if (g_LOD >= 1) then
		ShipDemandAdd(kDestroyer, destroyerDemand + 0.25)
	end
	if (g_LOD >= 2) then
		ShipDemandAdd(kBattleCruiser, 0.5)
	end
end

function DetermineSpecialDemand_Terran()
	local currentRU = GetRU()
	if (currentRU > 2000) then
		-- Increase fighter/bomber caps for "Expert" feel
		if (NumSquadrons(kInterceptor) + NumSquadronsQ(kInterceptor) < 30) then
			ShipDemandAdd(kInterceptor, 1.5)
		end
		if (NumSquadrons(kBomber) + NumSquadronsQ(kBomber) < 20) then
			ShipDemandAdd(kBomber, 1.8)
		end
		
		-- Alleviate production bottleneck by demanding more carriers
		if (currentRU > 10000) then
			if (NumSquadrons(kCarrier) + NumSquadronsQ(kCarrier) < 4) then
				ShipDemandAdd(kCarrier, 1.0)
			end
		end

		-- Persistent Destroyer/Battlecruiser demand if rich
		if (currentRU > 50000) then
			ShipDemandAdd(kDestroyer, 0.5)
			ShipDemandAdd(kBattleCruiser, 0.5)
		end
	end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Terran
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Terran
