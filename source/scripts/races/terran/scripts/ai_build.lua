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
kBomberFS2 = TER_MEDUSA -- Upgraded from Artemis (212 DPS vs 108 DPS)
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
	
	-- Dynamic scaling for "True Huge" caps
	local fighterTarget = 30
	local bomberTarget = 20
	local carrierTarget = 4
	local capDemand = 0.5

	if (currentRU > 10000) then
		fighterTarget = 100
		bomberTarget = 80
		carrierTarget = 6
		capDemand = 1.0
	end
	
	if (currentRU > 50000) then
		fighterTarget = 200
		bomberTarget = 150
		carrierTarget = 10
		capDemand = 2.0
	end

	-- Panic Spending Mode
	if (currentRU > 150000) then
		fighterTarget = 300
		bomberTarget = 250
		carrierTarget = 15
		capDemand = 4.0
	end

	if (currentRU > 2000) then
		if (NumSquadrons(kInterceptor) + NumSquadronsQ(kInterceptor) < fighterTarget) then
			ShipDemandAdd(kInterceptor, 1.5)
			FSFC_Log_Demand("Interceptors", 1.5)
		end
		if (NumSquadrons(kBomber) + NumSquadronsQ(kBomber) < bomberTarget) then
			ShipDemandAdd(kBomber, 1.8)
			FSFC_Log_Demand("Bombers", 1.8)
		end
		
		-- Only build scouts if not in panic mode to avoid "standing still" clustering
		if (currentRU < 100000) then
			if (NumSquadrons(kScout) + NumSquadronsQ(kScout) < 5) then
				ShipDemandAdd(kScout, 0.5)
			end
		end

		if (NumSquadrons(kCarrier) + NumSquadronsQ(kCarrier) < carrierTarget) then
			ShipDemandAdd(kCarrier, 1.2)
			FSFC_Log_Demand("Carriers", 1.2)
		end

		-- Persistent Destroyer/Battlecruiser demand if rich
		ShipDemandAdd(kDestroyer, capDemand)
		ShipDemandAdd(kBattleCruiser, capDemand)
		if (capDemand > 1.5) then
			FSFC_Log_Demand("Capitals", capDemand)
		end

		-- Prevent AWACS spam
		if (NumSquadrons(kAWACS) + NumSquadronsQ(kAWACS) >= 2) then
			ShipDemandSet(kAWACS, -10)
		end
	end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Terran
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Terran
