dofilepath("data:scripts/custom_scripts/ai_telemetry.lua")
aitrace("LOADING SHIVAN BUILD INFO")

kCollector = SHI_AZRAEL
kCollectorFS1 = SHI_AZRAEL
kRefinery = SHI_RAHU

-- Era Counterparts
kScoutFS2 = SHI_SCORPION
kScoutFS1 = SHI_SCORPION
kInterceptorFS2 = SHI_ASTAROTH
kInterceptorFS1 = SHI_MANTICORE
kHeavyFighterFS2 = SHI_MARA
kHeavyFighterFS1 = SHI_DRAGON
kBomberFS2 = SHI_NAHEMA
kBomberFS1 = SHI_SHAITAN
kDestroyerFS2 = SHI_MOLOCH
kDestroyerFS1 = SHI_DEMON_FS1
kMissileDestroyerFS2 = SHI_MOLOCH
kMissileDestroyerFS1 = SHI_DEMON_FS1
kBattleCruiserFS2 = SHI_RAVANA
kBattleCruiserFS1 = SHI_LUCIFER

function CpuBuild_UpdateRaceVariables()
	kScout = Util_PickBestShip(kScoutFS2, kScoutFS1)
	kInterceptor = Util_PickBestShip(kInterceptorFS2, kInterceptorFS1)
	kBomber = Util_PickBestShip(kBomberFS2, kBomberFS1)
	kDestroyer = Util_PickBestShip(kDestroyerFS2, kDestroyerFS1)
	kMissileDestroyer = Util_PickBestShip(kMissileDestroyerFS2, kMissileDestroyerFS1)
	kBattleCruiser = Util_PickBestShip(kBattleCruiserFS2, kBattleCruiserFS1)
	kCarrier = Util_PickBestShip(SHI_DEMON, SHI_DEMON_FS1)
	kResearch = SHI_COMMNODE
	kAWACS = SHI_COMMNODE
end

function DetermineDemandWithNoCounterInfo_Shivan()
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
	
	FSFC_Log_Demand("Fighters", fighterDemand)
	FSFC_Log_Demand("Corvettes", corvetteDemand)
	FSFC_Log_Demand("Frigates", frigateDemand)
	
	if (g_LOD >= 1) then
		ShipDemandAdd(kDestroyer, 0.25)
	end
	if (g_LOD >= 2) then
		ShipDemandAdd(kBattleCruiser, 0.5)
	end
end

function DetermineSpecialDemand_Shivan()
	local currentRU = GetRU()
	if (currentRU > 2000) then
		-- Shivans should be more swarming
		if (NumSquadrons(kInterceptor) + NumSquadronsQ(kInterceptor) < 40) then
			ShipDemandAdd(kInterceptor, 1.8)
		end
		if (NumSquadrons(kBomber) + NumSquadronsQ(kBomber) < 25) then
			ShipDemandAdd(kBomber, 1.5)
		end

		-- Production capacity
		if (currentRU > 10000) then
			if (NumSquadrons(kCarrier) + NumSquadronsQ(kCarrier) < 4) then
				ShipDemandAdd(kCarrier, 1.2)
			end
		end

		-- High resource aggression
		if (currentRU > 50000) then
			ShipDemandAdd(kDestroyer, 0.6)
			ShipDemandAdd(kBattleCruiser, 0.6)
		end
	end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Shivan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Shivan