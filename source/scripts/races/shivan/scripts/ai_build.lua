dofilepath("data:scripts/custom_scripts/ai_telemetry.lua")
aitrace("LOADING SHIVAN BUILD INFO")

kCollector = SHI_AZRAEL
kCollectorFS1 = SHI_AZRAEL
kRefinery = SHI_RAHU

-- Era Counterparts
kScoutFS2 = SHI_ASTAROTH   -- Promoted to modern scout (380 m/s)
kScoutFS1 = SHI_SCORPION
kInterceptorFS2 = SHI_ASTAROTH   -- Promoted to modern scout (380 m/s)
kInterceptorFS1 = SHI_MANTICORE
kFighterInterceptorFS2 = SHI_ASTAROTH
kFighterInterceptorFS1 = SHI_MANTICORE
kFighterSuperiorityFS2 = SHI_MARA
kFighterSuperiorityFS1 = SHI_DRAGON
kFighterAssaultFS2 = SHI_AESHMA
kFighterAssaultFS1 = SHI_BASILISK
kHeavyFighterFS2 = SHI_MARA
kHeavyFighterFS1 = SHI_DRAGON
kBomberStrikeFS2 = SHI_TAURVI
kBomberStrikeFS1 = SHI_SHAITAN
kBomberMediumFS2 = SHI_NAHEMA
kBomberMediumFS1 = SHI_SHAITAN
kBomberHeavyFS2 = SHI_SERAPHIM
kBomberHeavyFS1 = SHI_NEPHILIM

kDestroyerFS2 = SHI_MOLOCH
kDestroyerFS1 = SHI_CAIN_FS1      -- Realigned with Fenris tier (Cost 600)
kMissileDestroyerFS2 = SHI_MOLOCH
kMissileDestroyerFS1 = SHI_LILITH_FS1 -- Realigned with Leviathan tier (Cost 4000)
kBattleCruiserFS2 = SHI_RAVANA
kBattleCruiserFS1 = SHI_LUCIFER

-- Cruiser Classes (Backbone)
kCruiserFS2 = SHI_CAIN
kCruiserFS1 = SHI_CAIN_FS1
kHeavyCruiserFS2 = SHI_LILITH
kHeavyCruiserFS1 = SHI_LILITH_FS1
kAdvancedCruiser = SHI_RAKSHASA

function CpuBuild_UpdateRaceVariables()
	kScout = FSFC_PickBestShip(kScoutFS2, kScoutFS1)
	kFighterInterceptor = FSFC_PickBestShip(kFighterInterceptorFS2, kFighterInterceptorFS1)
	kFighterSuperiority = FSFC_PickBestShip(kFighterSuperiorityFS2, kFighterSuperiorityFS1)
	kFighterAssault = FSFC_PickBestShip(kFighterAssaultFS2, kFighterAssaultFS1)
	kInterceptor = kFighterSuperiority -- Backward compatibility
	kBomberStrike = FSFC_PickBestShip(kBomberStrikeFS2, kBomberStrikeFS1)
	kBomberMedium = FSFC_PickBestShip(kBomberMediumFS2, kBomberMediumFS1)
	kBomberHeavy = FSFC_PickBestShip(kBomberHeavyFS2, kBomberHeavyFS1)
	kBomber = kBomberMedium -- Backward compatibility
	kDestroyer = FSFC_PickBestShip(kDestroyerFS2, kDestroyerFS1)
	kMissileDestroyer = FSFC_PickBestShip(kMissileDestroyerFS2, kMissileDestroyerFS1)
	kBattleCruiser = FSFC_PickBestShip(kBattleCruiserFS2, kBattleCruiserFS1)
	
	-- Backbone Cruiser resolution
	kCruiser = FSFC_PickBestShip(kCruiserFS2, kCruiserFS1)
	kHeavyCruiser = FSFC_PickBestShip(kHeavyCruiserFS2, kHeavyCruiserFS1)
	
	kCarrier = FSFC_PickBestShip(SHI_DEMON, SHI_DEMON_FS1)
	kResearch = SHI_COMMNODE
	kAWACS = SHI_COMMNODE
end

function DetermineDemandWithNoCounterInfo_Shivan()
	local fighterDemand = 0.5
	local corvetteDemand = 0.4
	local frigateDemand = 0.3
	
	if (sg_randFavorShipType < 45) then
		fighterDemand = fighterDemand + 1.0
	elseif (sg_randFavorShipType < 75) then
		corvetteDemand = corvetteDemand + 1.0
	else
		frigateDemand = frigateDemand + 1.0
	end
	
	FSFC_ShipDemandAddByClass(eFighter, fighterDemand)
	FSFC_ShipDemandAddByClass(eCorvette, corvetteDemand)
	FSFC_ShipDemandAddByClass(eFrigate, frigateDemand)
	
	-- Occasional chance for heavier hulls if tech allows
	if (g_LOD >= 1) then
		FSFC_ShipDemandAddByClass(eDestroyer, 0.4)
	end
	if (g_LOD >= 2) then
		FSFC_ShipDemandAddByClass(eBattleCruiser, 0.3)
	end
end

function DetermineSpecialDemand_Shivan()
	-- Safety initialization
	if (s_enemyIndex == nil) then s_enemyIndex = -1 end
	if (player_max == nil) then player_max = 0 end

	-- 1. Gating heavy ships by time (Vanilla style)
	if (gameTime() < 120) then
		FSFC_ShipDemandAddByClass(eDestroyer, -10)
		FSFC_ShipDemandAddByClass(eBattleCruiser, -10)
		FSFC_ShipDemandAddByClass(eMotherShip, -10)
	end

	-- 2. Resource Management (Scaled for FSFC Costs)
	local numCollectors = FSFC_NumSquadrons(kCollector)
	local collectorGoal = 10
	
	-- Scale economy with tech
	if (FSFC_IsResearchDone("CapitalShipDesign") == 1) then
		collectorGoal = 28
	elseif (FSFC_IsResearchDone("CruiserDesign") == 1) then
		collectorGoal = 18
	end
	
	if (numCollectors < collectorGoal) then
		local demand = 0.5
		if (numCollectors < 6) then
			demand = 4.0 -- Emergency start
		elseif (numCollectors < 12) then
			demand = 2.0 -- Solid base
		end
		FSFC_ShipDemandAdd(kCollector, demand, "shi_azrael")
	end
	
	-- Refinery scaling (1 per 7 resourcers)
	local numResourcers = numCollectors + FSFC_NumSquadrons(kRefinery)
	if (numResourcers > 7 and FSFC_NumSquadrons(kRefinery) * 7 < numResourcers) then
		FSFC_ShipDemandAdd(kRefinery, 1.5, "shi_rahu")
	end

	-- 3. Production Escalation (Builders)
	local numBuilders = FSFC_NumSquadrons(kCarrier)
	if (numBuilders < 4) then
		local demand = 3.0
		if (numBuilders > 1) then
			demand = 1.5
		end
		FSFC_ShipDemandAdd(kCarrier, demand)
	end

	-- Wealth Boost (Spend excess RUs)
	if (GetRU() > 15000) then
		if (s_ru_high_time == nil) then
			s_ru_high_time = gameTime()
		end
		if (gameTime() - s_ru_high_time > 300) then
			FSFC_ShipDemandAdd(kCruiser, 4.0, "shi_cruiser_force")
			FSFC_ShipDemandAdd(kBattleCruiser, 4.0, "shi_battlecruiser_force")
			FSFC_ShipDemandAdd(kCarrier, 4.5, "shi_builder_force")
		end
	else
		s_ru_high_time = nil
	end

	if (GetRU() > 10000) then
		FSFC_ShipDemandAddByClass(eFighter, 1.5)
		FSFC_ShipDemandAddByClass(eCorvette, 1.0)
		FSFC_ShipDemandAdd(kCarrier, 1.0)
		FSFC_ShipDemandAdd(kBattleCruiser, 1.0)
	end

	-- 4. Class-specific "Best Ship" Nudges (Occasional era-favors)
	if (kFighterSuperiority ~= nil) then FSFC_ShipDemandAdd(kFighterSuperiority, 0.3, "FighterSup") end
	if (kBomberHeavy ~= nil) then FSFC_ShipDemandAdd(kBomberHeavy, 0.2, "BomberHeavy") end
	if (FSFC_NumSquadrons(kCarrier) >= 2) then
		if (kCruiser ~= nil) then FSFC_ShipDemandAdd(kCruiser, 0.3, "Cruiser") end
		if (kHeavyCruiser ~= nil) then FSFC_ShipDemandAdd(kHeavyCruiser, 0.45, "HeavyCruiser") end
		if (kAdvancedCruiser ~= nil) then FSFC_ShipDemandAdd(kAdvancedCruiser, 0.5, "AdvancedCruiser") end
		if (kDestroyer ~= nil) then FSFC_ShipDemandAdd(kDestroyer, 0.45, "Destroyer") end
	end
	
	-- 5. Elite/Endgame Logic (The Sathanas)
	if (SHI_SATHANAS ~= nil and FSFC_IsResearchDone("Sathanas") == 1) then
		if (GetRU() > 20000) then
			FSFC_ShipDemandAdd(SHI_SATHANAS, 1.0, "shi_sathanas")
		end
	end

	-- 6. Support/Utility
	if (kResearch ~= nil and FSFC_NumSquadrons(kResearch) < 2) then
		FSFC_ShipDemandAdd(kResearch, 0.5, "shi_commnode")
	end

	-- Write demand snapshot for global telemetry
	FSFC_WriteDemandSnapshot()
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Shivan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Shivan