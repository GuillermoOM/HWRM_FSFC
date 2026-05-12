dofilepath("data:scripts/custom_scripts/ai_telemetry.lua")
aitrace("LOADING SHIVAN BUILD INFO")

kCollector = SHI_AZRAEL
kCollectorFS1 = SHI_AZRAEL
kRefinery = SHI_RAHU

-- Era Counterparts
kScoutFS2 = SHI_ASTAROTH   -- Promoted to modern scout (380 m/s)
kScoutFS1 = SHI_SCORPION
kInterceptorFS2 = SHI_MANTICORE -- Upgraded to modern interceptor (414 m/s)
kInterceptorFS1 = SHI_MANTICORE
kHeavyFighterFS2 = SHI_MARA
kHeavyFighterFS1 = SHI_DRAGON
kBomberFS2 = SHI_NAHEMA
kBomberFS1 = SHI_SHAITAN
kDestroyerFS2 = SHI_MOLOCH
kDestroyerFS1 = SHI_CAIN_FS1      -- Realigned with Fenris tier (Cost 600)
kMissileDestroyerFS2 = SHI_MOLOCH
kMissileDestroyerFS1 = SHI_LILITH_FS1 -- Realigned with Leviathan tier (Cost 4000)
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
	
	-- Dynamic scaling for "True Huge" caps (Shivan Swarm flavor)
	local fighterTarget = 40
	local bomberTarget = 25
	local carrierTarget = 4
	local capDemand = 0.6

	if (currentRU > 10000) then
		fighterTarget = 120
		bomberTarget = 90
		carrierTarget = 6
		capDemand = 1.2
	end
	
	if (currentRU > 50000) then
		fighterTarget = 220
		bomberTarget = 160
		carrierTarget = 12
		capDemand = 2.5
	end

	-- Panic Spending Mode (The Swarm never stops)
	if (currentRU > 150000) then
		fighterTarget = 300
		bomberTarget = 280
		carrierTarget = 20
		capDemand = 5.0
	end

	if (currentRU > 2000) then
		if (NumSquadrons(kInterceptor) + NumSquadronsQ(kInterceptor) < fighterTarget) then
			ShipDemandAdd(kInterceptor, 1.8)
			FSFC_Log_Demand("Interceptors", 1.8)
		end
		if (NumSquadrons(kBomber) + NumSquadronsQ(kBomber) < bomberTarget) then
			ShipDemandAdd(kBomber, 1.5)
			FSFC_Log_Demand("Bombers", 1.5)
		end

		-- Shivans stop scouting and start swarming when rich
		if (currentRU < 100000) then
			if (NumSquadrons(kScout) + NumSquadronsQ(kScout) < 8) then
				ShipDemandAdd(kScout, 0.5)
			end
		end

		if (NumSquadrons(kCarrier) + NumSquadronsQ(kCarrier) < carrierTarget) then
			ShipDemandAdd(kCarrier, 1.2)
			FSFC_Log_Demand("Carriers", 1.2)
		end

		-- High resource aggression
		ShipDemandAdd(kDestroyer, capDemand)
		ShipDemandAdd(kBattleCruiser, capDemand)
		if (capDemand > 1.5) then
			FSFC_Log_Demand("Capitals", capDemand)
		end
		
		-- Prevent Comm Node spam (limit to 2 for Research/AWACS)
		if (NumSquadrons(SHI_COMMNODE) + NumSquadronsQ(SHI_COMMNODE) >= 2) then
			ShipDemandSet(SHI_COMMNODE, -10)
		end
	end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Shivan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Shivan