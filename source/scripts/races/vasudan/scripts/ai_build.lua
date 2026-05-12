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
	if (currentRU > 2000) then
		-- Vasudans love their bombers
		if (NumSquadrons(kInterceptor) + NumSquadronsQ(kInterceptor) < 35) then
			ShipDemandAdd(kInterceptor, 1.5)
		end
		if (NumSquadrons(kBomber) + NumSquadronsQ(kBomber) < 30) then
			ShipDemandAdd(kBomber, 2.0)
		end

		-- Production capacity
		if (currentRU > 10000) then
			if (NumSquadrons(kCarrier) + NumSquadronsQ(kCarrier) < 4) then
				ShipDemandAdd(kCarrier, 1.1)
			end
		end

		-- High resource aggression
		if (currentRU > 50000) then
			ShipDemandAdd(kDestroyer, 0.5)
			ShipDemandAdd(kBattleCruiser, 0.5)
		end
	end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Vasudan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Vasudan
