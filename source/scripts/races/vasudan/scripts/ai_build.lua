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
kFighterAssaultFS1 = VAS_ANUBIS
kHeavyFighterFS2 = VAS_TAURET
kHeavyFighterFS1 = VAS_THOTH
kBomberStrikeFS2 = VAS_BAKHA
kBomberStrikeFS1 = VAS_OSIRIS
kBomberMediumFS2 = VAS_OSIRIS
kBomberMediumFS1 = VAS_OSIRIS
kBomberHeavyFS2 = VAS_SEHKMET
kBomberHeavyFS1 = VAS_AMUN
kDestroyerFS2 = VAS_SOBEK
kDestroyerFS1 = nil -- No dedicated destroyer in FS1 era; Aten serves as kCruiser
kMissileDestroyerFS2 = VAS_SOBEK -- Upgraded from Aten (3000 RU vs 600 RU) to match Aeolus weight
kMissileDestroyerFS1 = VAS_ATEN_FS1 -- Replaced era-locked Mentu with Aten FS1
kBattleCruiserFS2 = VAS_HATSHEPSUT
kBattleCruiserFS1 = VAS_HATSHEPSUT_FS1

function CpuBuild_UpdateRaceVariables()
	kScout = FSFC_PickBestShip(kScoutFS2, kScoutFS1)
	kFighterInterceptor = FSFC_PickBestShip(kFighterInterceptorFS2, kFighterInterceptorFS1)
	kFighterSuperiority = FSFC_PickBestShip(kFighterSuperiorityFS2, kFighterSuperiorityFS1)
	kFighterAssault = FSFC_PickBestShip(kFighterAssaultFS2, kFighterAssaultFS1)
	kInterceptor = FSFC_PickBestShip(kFighterSuperiorityFS2, kFighterInterceptorFS1) -- Use Horus in FS1, Seth/Serapis in FS2
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
	kAWACS = VAS_SETEKH
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

	local numD = 0
	local maxD = 6
	if (kDestroyer ~= nil) then
		numD = FSFC_NumSquadrons(kDestroyer) + FSFC_NumSquadronsQ(kDestroyer)
	end

	-- 1. Gating heavy ships by time (Vanilla style)
	if (gameTime() < 120) then
		FSFC_ShipDemandAddByClass(eDestroyer, -10)
		FSFC_ShipDemandAddByClass(eBattleCruiser, -10)
		FSFC_ShipDemandAddByClass(eMotherShip, -10)
	end

	-- Apply caps by setting negative demand if reached
	if (kDestroyer ~= nil and numD >= maxD) then
		FSFC_ShipDemandSet(kDestroyer, -100)
	end

	-- Nudge FS1 bomber production to counter cruisers/destroyers
	if (FSFC_IsResearchDone("FS2") == 0) then
		FSFC_ShipDemandAddByClass(eCorvette, 0.75)
	end

	-- 2. Resource Management (Scaled for FSFC Costs)
	local numCollectors = FSFC_NumSquadrons(kCollector)
	local collectorGoal = 10
	
	-- Scale economy with tech (Stay within unit caps)
	if (FSFC_IsResearchDone("CapitalShipDesign") == 1) then
		collectorGoal = 20
	elseif (FSFC_IsResearchDone("CruiserDesign") == 1) then
		collectorGoal = 18
	end
	
	if (numCollectors < collectorGoal) then
		local demand = 0.5
		if (numCollectors < 4) then
			demand = 4.0 -- Emergency start
		elseif (numCollectors < 10) then
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
	if (kCarrier2 ~= nil) then
		numCarriers = numCarriers + FSFC_NumSquadrons(kCarrier2)
	end
	local carrierGoal = 2
	if (GetRU() > 100000) then
		carrierGoal = 8
	end
	
	if (numCarriers < carrierGoal) then
		local demand = 3.5
		if (numCarriers > 0) then
			demand = 1.0
		end
		local c1Demand = demand
		local c2Demand = demand
		if (kCarrier ~= nil and kCarrier2 ~= nil and kCarrier ~= kCarrier2) then
			local count1 = FSFC_NumSquadrons(kCarrier) + FSFC_NumSquadronsQ(kCarrier)
			local count2 = FSFC_NumSquadrons(kCarrier2) + FSFC_NumSquadronsQ(kCarrier2)
			if (count1 > count2) then
				c1Demand = demand * 0.1
			elseif (count2 > count1) then
				c2Demand = demand * 0.1
			end
		end
		if (kCarrier ~= nil) then
			FSFC_ShipDemandAdd(kCarrier, c1Demand)
		end
		if (kCarrier2 ~= nil and kCarrier2 ~= kCarrier) then
			FSFC_ShipDemandAdd(kCarrier2, c2Demand)
		end
	end

	-- Wealth Boost (Spend excess RUs)
	if (GetRU() > 10000) then
		FSFC_ShipDemandAddByClass(eFighter, 1.5)
		FSFC_ShipDemandAddByClass(eCorvette, 1.0)
		
		local c1DemandMid = 1.0
		local c2DemandMid = 1.0
		if (kCarrier ~= nil and kCarrier2 ~= nil and kCarrier ~= kCarrier2) then
			local count1 = FSFC_NumSquadrons(kCarrier) + FSFC_NumSquadronsQ(kCarrier)
			local count2 = FSFC_NumSquadrons(kCarrier2) + FSFC_NumSquadronsQ(kCarrier2)
			if (count1 > count2) then
				c1DemandMid = 0.1
			elseif (count2 > count1) then
				c2DemandMid = 0.1
			end
		end
		if (kCarrier ~= nil) then
			FSFC_ShipDemandAdd(kCarrier, c1DemandMid)
		end
		if (kCarrier2 ~= nil and kCarrier2 ~= kCarrier) then
			FSFC_ShipDemandAdd(kCarrier2, c2DemandMid)
		end
		
		local numC = FSFC_NumSquadrons(kCruiser) + FSFC_NumSquadronsQ(kCruiser)
		local numHC = 0
		if (kHeavyCruiser ~= nil) then
			numHC = FSFC_NumSquadrons(kHeavyCruiser) + FSFC_NumSquadronsQ(kHeavyCruiser)
		end
		local numBC = 0
		if (kBattleCruiser ~= nil) then
			numBC = FSFC_NumSquadrons(kBattleCruiser) + FSFC_NumSquadronsQ(kBattleCruiser)
		end
		local maxC = 12
		local maxHC = 4
		local maxBC = 4

		if (numC < maxC) then
			FSFC_ShipDemandAdd(kCruiser, 3.0, "vas_cruiser_mid")
		else
			FSFC_ShipDemandSet(kCruiser, -100)
		end
		if (kHeavyCruiser ~= nil and numHC >= maxHC) then
			FSFC_ShipDemandSet(kHeavyCruiser, -100)
		end
		if (kBattleCruiser ~= nil and numBC >= maxBC) then
			FSFC_ShipDemandSet(kBattleCruiser, -100)
		end
		if (kDestroyer ~= nil and numD >= maxD) then
			FSFC_ShipDemandSet(kDestroyer, -100)
		end

		-- When ALL caps are saturated: nuke residual eFrigate/eDestroyer class demand and force strike craft
		if (numC >= maxC and numHC >= maxHC and numBC >= maxBC and (kDestroyer == nil or numD >= maxD)) then
			FSFC_ShipDemandAddByClass(eFrigate, -30)
			FSFC_ShipDemandAddByClass(eDestroyer, -30)
			FSFC_ShipDemandAddByClass(eFighter, 8.0)
			FSFC_ShipDemandAddByClass(eCorvette, 6.0)
		end

		if (kDestroyer ~= nil and numD < maxD) then
			FSFC_ShipDemandAdd(kDestroyer, 3.0, "vas_destroyer_mid")
		end
	end
	
	-- Expert Overdrive (Massive spending for late-game surplus)
	if (GetRU() > 50000) then
		FSFC_ShipDemandAddByClass(eFighter, 3.0)
		FSFC_ShipDemandAddByClass(eCorvette, 3.0)
		
		local c1DemandForce = 5.0
		local c2DemandForce = 5.0
		if (kCarrier ~= nil and kCarrier2 ~= nil and kCarrier ~= kCarrier2) then
			local count1 = FSFC_NumSquadrons(kCarrier) + FSFC_NumSquadronsQ(kCarrier)
			local count2 = FSFC_NumSquadrons(kCarrier2) + FSFC_NumSquadronsQ(kCarrier2)
			if (count1 > count2) then
				c1DemandForce = 0.5
			elseif (count2 > count1) then
				c2DemandForce = 0.5
			end
		end
		if (kCarrier ~= nil) then
			FSFC_ShipDemandAdd(kCarrier, c1DemandForce)
		end
		if (kCarrier2 ~= nil and kCarrier2 ~= kCarrier) then
			FSFC_ShipDemandAdd(kCarrier2, c2DemandForce)
		end
		
		local numC = FSFC_NumSquadrons(kCruiser) + FSFC_NumSquadronsQ(kCruiser)
		local numHC = 0
		if (kHeavyCruiser ~= nil) then
			numHC = FSFC_NumSquadrons(kHeavyCruiser) + FSFC_NumSquadronsQ(kHeavyCruiser)
		end
		local numBC = 0
		if (kBattleCruiser ~= nil) then
			numBC = FSFC_NumSquadrons(kBattleCruiser) + FSFC_NumSquadronsQ(kBattleCruiser)
		end

		-- Cap definitions
		local maxC = 12
		local maxHC = 4
		local maxBC = 4

		-- Apply caps by setting negative demand if reached
		if (numC >= maxC) then
			FSFC_ShipDemandSet(kCruiser, -100)
		end
		if (kHeavyCruiser ~= nil and numHC >= maxHC) then
			FSFC_ShipDemandSet(kHeavyCruiser, -100)
		end
		if (kBattleCruiser ~= nil and numBC >= maxBC) then
			FSFC_ShipDemandSet(kBattleCruiser, -100)
		end
		if (kDestroyer ~= nil and numD >= maxD) then
			FSFC_ShipDemandSet(kDestroyer, -100)
		end

		-- When ALL caps are saturated: nuke residual eFrigate/eDestroyer class demand and force strike craft
		if (numC >= maxC and numHC >= maxHC and numBC >= maxBC and (kDestroyer == nil or numD >= maxD)) then
			FSFC_ShipDemandAddByClass(eFrigate, -30)
			FSFC_ShipDemandAddByClass(eDestroyer, -30)
			FSFC_ShipDemandAddByClass(eFighter, 12.0)
			FSFC_ShipDemandAddByClass(eCorvette, 8.0)
		end

		-- Add demand only if under the caps
		if (numC < maxC) then
			FSFC_ShipDemandAdd(kCruiser, 15.0, "vas_cruiser_force")
		end
		if (kHeavyCruiser ~= nil and numHC < maxHC) then
			FSFC_ShipDemandAdd(kHeavyCruiser, 10.0, "vas_heavycruiser_force")
		end
		if (kDestroyer ~= nil and numD < maxD) then
			FSFC_ShipDemandAdd(kDestroyer, 10.0, "vas_destroyer_force")
		end
		if (kBattleCruiser ~= nil and numBC < maxBC) then
			FSFC_ShipDemandAdd(kBattleCruiser, 10.0, "vas_battlecruiser_force")
		end
	end

	local numShipyards = FSFC_NumSquadrons(kShipyard)
	local shipyardGoal = 1
	if (GetRU() > 100000) then
		shipyardGoal = 2
	end
	
	if (numShipyards < shipyardGoal) then
		if (numShipyards == 0 and (s_selfTotalValue > 30 or numCarriers > 0)) then
			local shipyardDemand = 0.5
			if (GetRU() > 30000) then
				shipyardDemand = 15.0
			end
			FSFC_ShipDemandAdd(kShipyard, shipyardDemand, "Shipyard")
		elseif (numShipyards > 0) then
			local secondShipyardDemand = 1.0
			if (GetRU() > 100000) then
				secondShipyardDemand = 15.0
			end
			FSFC_ShipDemandAdd(kShipyard, secondShipyardDemand, "SecondShipyard")
		end
	else
		FSFC_ShipDemandSet(kShipyard, -100)
	end


	-- 4. Class-specific "Best Ship" Nudges (Occasional era-favors)
	if (kFighterSuperiority ~= nil) then FSFC_ShipDemandAdd(kFighterSuperiority, 0.3, "FighterSup") end
	if (kBomberHeavy ~= nil) then FSFC_ShipDemandAdd(kBomberHeavy, 0.2, "BomberHeavy") end
	
	local numCarrierCounts = FSFC_NumSquadrons(kCarrier)
	if (kCarrier2 ~= nil) then
		numCarrierCounts = numCarrierCounts + FSFC_NumSquadrons(kCarrier2)
	end
	if (numCarrierCounts >= 1 or GetRU() > 20000) then
		local numC = FSFC_NumSquadrons(kCruiser) + FSFC_NumSquadronsQ(kCruiser)
		local numHC = 0
		if (kHeavyCruiser ~= nil) then
			numHC = FSFC_NumSquadrons(kHeavyCruiser) + FSFC_NumSquadronsQ(kHeavyCruiser)
		end

		local maxC = 12
		local maxHC = 4

		if (numC < maxC and kCruiser ~= nil) then FSFC_ShipDemandAdd(kCruiser, 0.4, "Cruiser") end
		if (kHeavyCruiser ~= nil and numHC < maxHC) then FSFC_ShipDemandAdd(kHeavyCruiser, 0.6, "HeavyCruiser") end
		if (kDestroyer ~= nil and numD < maxD) then FSFC_ShipDemandAdd(kDestroyer, 1.5, "Destroyer") end
	end
	
	-- Strict cap on Osiris bombers (max 20) to prevent queue saturation
	local numOsiris = FSFC_NumSquadrons(VAS_OSIRIS)
	if (numOsiris >= 20) then
		FSFC_ShipDemandSet(VAS_OSIRIS, -100)
	end
	
	-- Strict cap on Amun heavy bombers (max 20) to prevent queue saturation
	local numAmun = FSFC_NumSquadrons(VAS_AMUN)
	if (numAmun >= 20) then
		FSFC_ShipDemandSet(VAS_AMUN, -100)
	end
	
	-- 5. Elite/Endgame Logic (The Colossus)
	local numJ = 0
	local maxJ = 1
	if (GetRU() > 80000) then
		maxJ = 2
	end
	if (kJuggernaut ~= nil) then
		numJ = FSFC_NumSquadrons(kJuggernaut) + FSFC_NumSquadronsQ(kJuggernaut)
	end
	if (kJuggernaut ~= nil and FSFC_IsResearchDone("Juggernaut") == 1) then
		if (numJ >= maxJ) then
			FSFC_ShipDemandSet(kJuggernaut, -100)
		elseif (GetRU() > 40000) then
			FSFC_ShipDemandAdd(kJuggernaut, 30.0, "vas_colossus")
		end
	end

	-- 6. Support/Utility
	if (kResearch ~= nil and FSFC_NumSquadrons(kResearch) < 2) then
		FSFC_ShipDemandAdd(kResearch, 0.5, "vas_imhotep")
	end
	if (kAWACS ~= nil and FSFC_NumSquadrons(kAWACS) < 2) then
		FSFC_ShipDemandAdd(kAWACS, 0.5, "vas_setekh")
	end

	-- Write demand snapshot for global telemetry
	FSFC_WriteDemandSnapshot()
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Vasudan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Vasudan
