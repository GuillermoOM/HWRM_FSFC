dofilepath("data:scripts/custom_scripts/ai_telemetry.lua")
aitrace("LOADING VASUDAN BUILD INFO")

kCollector = VAS_ISIS
kCollectorFS1 = VAS_ISIS
kRefinery  = VAS_ANUKET

-- Era Counterparts
kScoutFS2 = VAS_PTAH
kScoutFS1 = VAS_HORUS
kInterceptorFS2 = VAS_SERAPIS
kInterceptorFS1 = VAS_HORUS
kHeavyFighterFS2 = VAS_TAURET
kHeavyFighterFS1 = VAS_THOTH
kBomberFS2 = VAS_SEHKMET
kBomberFS1 = VAS_OSIRIS
kDestroyerFS2 = VAS_SOBEK
kDestroyerFS1 = VAS_ATEN_FS1
kMissileDestroyerFS2 = VAS_ATEN
kMissileDestroyerFS1 = VAS_ATEN_FS1
kBattleCruiserFS2 = VAS_HATSHEPSUT
kBattleCruiserFS1 = VAS_TYPHON_FS1

function CpuBuild_UpdateRaceVariables()
	kScout = Util_PickBestShip(kScoutFS2, kScoutFS1)
	kInterceptor = Util_PickBestShip(kInterceptorFS2, kInterceptorFS1)
	kBomber = Util_PickBestShip(kBomberFS2, kBomberFS1)
	kDestroyer = Util_PickBestShip(kDestroyerFS2, kDestroyerFS1)
	kMissileDestroyer = Util_PickBestShip(kMissileDestroyerFS2, kMissileDestroyerFS1)
	kBattleCruiser = Util_PickBestShip(kBattleCruiserFS2, kBattleCruiserFS1)
	kCarrier = Util_PickBestShip(VAS_TYPHON, VAS_TYPHON_FS1)
	kResearch = VAS_IMHOTEP
	kAWACS = VAS_SETEKH
end

function DetermineDemandWithNoCounterInfo_Vasudan()
	local fighterDemand = 0.4
	local corvetteDemand = 0.3
	local frigateDemand = 0.3
	
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
		ShipDemandAdd(kDestroyer, 0.25)
	end
	if (g_LOD >= 2) then
		ShipDemandAdd(kBattleCruiser, 0.5)
	end
end

function DetermineSpecialDemand_Vasudan()
	local currentRU = GetRU()
	
	-- Dynamic scaling for "True Huge" caps (Vasudan Bomber flavor)
	local fighterTarget = 35
	local bomberTarget = 30
	local carrierTarget = 4
	local capDemand = 0.5

	if (currentRU > 10000) then
		fighterTarget = 100
		bomberTarget = 120
		carrierTarget = 6
		capDemand = 1.0
	end
	
	if (currentRU > 50000) then
		fighterTarget = 180
		bomberTarget = 200
		carrierTarget = 12
		capDemand = 2.0
	end

	-- Panic Spending Mode
	if (currentRU > 150000) then
		fighterTarget = 280
		bomberTarget = 300
		carrierTarget = 18
		capDemand = 4.0
	end

	if (currentRU > 2000) then
		if (NumSquadrons(kInterceptor) + NumSquadronsQ(kInterceptor) < fighterTarget) then
			ShipDemandAdd(kInterceptor, 1.5)
			FSFC_Log_Demand("Interceptors", 1.5)
		end
		if (NumSquadrons(kBomber) + NumSquadronsQ(kBomber) < bomberTarget) then
			ShipDemandAdd(kBomber, 2.0)
			FSFC_Log_Demand("Bombers", 2.0)
		end

		-- Vasudans stop scouting and start bombing when rich
		if (currentRU < 100000) then
			if (NumSquadrons(kScout) + NumSquadronsQ(kScout) < 5) then
				ShipDemandAdd(kScout, 0.5)
			end
		end

		if (NumSquadrons(kCarrier) + NumSquadronsQ(kCarrier) < carrierTarget) then
			ShipDemandAdd(kCarrier, 1.1)
			FSFC_Log_Demand("Carriers", 1.1)
		end

		-- High resource aggression
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

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Vasudan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Vasudan
