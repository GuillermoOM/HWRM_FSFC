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
kFighterInterceptorFS2 = VAS_SERAPIS
kFighterInterceptorFS1 = VAS_HORUS
kFighterSuperiorityFS2 = VAS_THOTH
kFighterSuperiorityFS1 = VAS_SETH
kFighterAssaultFS2 = VAS_TAURET
kFighterAssaultFS1 = VAS_SETH
kHeavyFighterFS2 = VAS_TAURET
kHeavyFighterFS1 = VAS_THOTH
kBomberStrikeFS2 = VAS_BAKHA
kBomberStrikeFS1 = VAS_OSIRIS
kBomberMediumFS2 = VAS_OSIRIS
kBomberMediumFS1 = VAS_OSIRIS
kBomberHeavyFS2 = VAS_SEHKMET
kBomberHeavyFS1 = VAS_AMUN
kDestroyerFS2 = VAS_SOBEK
kDestroyerFS1 = VAS_ATEN_FS1
kMissileDestroyerFS2 = VAS_SOBEK -- Upgraded from Aten (3000 RU vs 600 RU) to match Aeolus weight
kMissileDestroyerFS1 = VAS_MENTU -- Replaced Aten for better FS1 mid-tier survivability
kBattleCruiserFS2 = VAS_HATSHEPSUT
kBattleCruiserFS1 = VAS_TYPHON_FS1

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
	-- Backbone Cruiser resolution
	kCruiser = FSFC_PickBestShip(VAS_ATEN, VAS_ATEN_FS1)
	kHeavyCruiser = VAS_MENTU
	
	kBattleCruiser = FSFC_PickBestShip(kBattleCruiserFS2, kBattleCruiserFS1)
	kCarrier = FSFC_PickBestShip(VAS_TYPHON, VAS_TYPHON_FS1)
	kShipyard = VAS_KARNAK
	kJuggernaut = VAS_COLOSSUS
	kResearch = VAS_IMHOTEP
	kAWACS = kScout
end

function DetermineDemandWithNoCounterInfo_Vasudan()
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

function DetermineSpecialDemand_Vasudan()
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
		FSFC_ShipDemandAdd(kCollector, demand, "vas_isis")
	end
	
	-- Refinery scaling (1 per 7 resourcers)
	local numResourcers = numCollectors + FSFC_NumSquadrons(kRefinery)
	if (numResourcers > 7 and FSFC_NumSquadrons(kRefinery) * 7 < numResourcers) then
		FSFC_ShipDemandAdd(kRefinery, 1.5, "vas_anuket")
	end

	-- 3. Production Escalation
	local numCarriers = FSFC_NumSquadrons(kCarrier)
	if (numCarriers < 4) then
		local demand = 3.0
		if (numCarriers > 1) then
			demand = 1.5
		end
		FSFC_ShipDemandAdd(kCarrier, demand)
		FSFC_ShipDemandAdd(kBattleCruiser, demand)
	end

	-- Wealth Boost (Spend excess RUs)
	if (GetRU() > 10000) then
		FSFC_ShipDemandAddByClass(eFighter, 1.5)
		FSFC_ShipDemandAddByClass(eCorvette, 1.0)
		FSFC_ShipDemandAdd(kCarrier, 1.0)
		FSFC_ShipDemandAdd(kBattleCruiser, 1.0)
	end

	local numShipyards = FSFC_NumSquadrons(kShipyard)
	if (numShipyards == 0 and s_selfTotalValue > 60) then
		FSFC_ShipDemandAdd(kShipyard, 0.5, "Shipyard")
	elseif (numShipyards > 0) then
		FSFC_ShipDemandSet(kShipyard, -100)
	end


	-- 4. Class-specific "Best Ship" Nudges (Occasional era-favors)
	if (kFighterSuperiority ~= nil) then FSFC_ShipDemandAdd(kFighterSuperiority, 0.3, "FighterSup") end
	if (kBomberHeavy ~= nil) then FSFC_ShipDemandAdd(kBomberHeavy, 0.2, "BomberHeavy") end
	if (kCruiser ~= nil) then FSFC_ShipDemandAdd(kCruiser, 0.3, "Cruiser") end
	
	-- 5. Elite/Endgame Logic (The Colossus)
	if (kJuggernaut ~= nil and FSFC_IsResearchDone("Colossus") == 1) then
		if (GetRU() > 40000) then
			FSFC_ShipDemandAdd(kJuggernaut, 1.0, "vas_colossus")
		end
	end

	-- 6. Support/Utility
	if (kResearch ~= nil and FSFC_NumSquadrons(kResearch) < 2) then
		FSFC_ShipDemandAdd(kResearch, 0.5, "vas_imhotep")
	end

	-- Write demand snapshot for global telemetry
	FSFC_WriteDemandSnapshot()
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Vasudan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Vasudan
