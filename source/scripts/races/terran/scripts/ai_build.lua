dofilepath("data:scripts/custom_scripts/ai_telemetry.lua")
aitrace("LOADING TERRAN BUILD INFO")

kCollector = TER_ELYSIUM
kCollectorFS1 = TER_ELYSIUM
kRefinery = TER_ZEPHYRUS

-- Era Counterparts
kScoutFS2 = TER_PEGASUS
kScoutFS1 = TER_LOKI
kFighterInterceptorFS2 = TER_PERSEUS
kFighterInterceptorFS1 = TER_VALKYRIE
kFighterSuperiorityFS2 = TER_MYRMIDON
kFighterSuperiorityFS1 = TER_APOLLO
kFighterAssaultFS2 = TER_HERCULESMK2
kFighterAssaultFS1 = TER_HERCULES
kInterceptorFS2 = TER_PERSEUS
kInterceptorFS1 = TER_APOLLO
kHeavyFighterFS2 = TER_MYRMIDON
kHeavyFighterFS1 = TER_VALKYRIE
kBomberStrikeFS2 = TER_ARTEMIS
kBomberStrikeFS1 = TER_ATHENA
kBomberMediumFS2 = TER_MEDUSA
kBomberMediumFS1 = TER_ZEUS
kBomberHeavyFS2 = TER_BOANERGES
kBomberHeavyFS1 = TER_URSA_FS1
kDestroyerFS2 = TER_DEIMOS
kDestroyerFS1 = TER_FENRIS_FS1
kMissileDestroyerFS2 = TER_AEOLUS
kMissileDestroyerFS1 = TER_LEVIATHAN_FS1
kCruiserFS2 = TER_FENRIS
kCruiserFS1 = TER_FENRIS_FS1
kHeavyCruiserFS2 = TER_LEVIATHAN
kHeavyCruiserFS1 = TER_LEVIATHAN_FS1
kFighterSpecial1 = TER_ERINYES
kFighterSpecial2 = TER_ARES

function CpuBuild_UpdateRaceVariables()
	kScout = FSFC_PickBestShip(kScoutFS2, kScoutFS1)
	kFighterInterceptor = FSFC_PickBestShip(kFighterInterceptorFS2, kFighterInterceptorFS1)
	kFighterSuperiority = FSFC_PickBestShip(kFighterSuperiorityFS2, kFighterSuperiorityFS1)
	kFighterAssault = FSFC_PickBestShip(kFighterAssaultFS2, kFighterAssaultFS1)
	kInterceptor = kFighterInterceptor -- Fixed deadlock: point to basic interceptor
	kBomberStrike = FSFC_PickBestShip(kBomberStrikeFS2, kBomberStrikeFS1)
	kBomberMedium = FSFC_PickBestShip(kBomberMediumFS2, kBomberMediumFS1)
	kBomberHeavy = FSFC_PickBestShip(kBomberHeavyFS2, kBomberHeavyFS1)
	kBomber = kBomberStrike -- Fixed deadlock: point to basic strike bomber
	kDestroyer = FSFC_PickBestShip(kDestroyerFS2, kDestroyerFS1)
	kMissileDestroyer = FSFC_PickBestShip(kMissileDestroyerFS2, kMissileDestroyerFS1)
	kCruiser = FSFC_PickBestShip(kCruiserFS2, kCruiserFS1)
	kHeavyCruiser = FSFC_PickBestShip(kHeavyCruiserFS2, kHeavyCruiserFS1)
	kAdvancedCruiser = TER_AEOLUS
	kBattleCruiser = TER_HADES
	kCarrier = FSFC_PickBestShip(TER_ORION, TER_ORION_FS1)
	kCarrier2 = FSFC_PickBestShip(TER_HECATE, TER_ORION_FS1)
	kShipyard = TER_ARCADIA
	kJuggernaut = TER_COLOSSUS
	kResearch = TER_FAUSTUS
	kAWACS = TER_CHARYBDIS
end

function DetermineDemandWithNoCounterInfo_Terran()
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

function DetermineSpecialDemand_Terran()
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
		FSFC_ShipDemandAdd(kCollector, demand, "ter_elysium")
	end
	
	-- Refinery scaling (1 per 7 resourcers)
	local numResourcers = numCollectors + FSFC_NumSquadrons(kRefinery)
	if (numResourcers > 7 and FSFC_NumSquadrons(kRefinery) * 7 < numResourcers) then
		FSFC_ShipDemandAdd(kRefinery, 1.5, "ter_zephyrus")
	end

	-- 3. Production Escalation
	local numCarriers = FSFC_NumSquadrons(kCarrier) + FSFC_NumSquadrons(kCarrier2)
	local carrierGoal = 4
	local shipyardGoal = 1
	
	-- Expert Overdrive: Scale factories with wealth
	if (GetRU() > 100000) then
		carrierGoal = 8
		shipyardGoal = 2
	end

	if (numCarriers < carrierGoal) then
		local demand = 3.0
		if (numCarriers > 1) then
			demand = 1.5
		end
		FSFC_ShipDemandAdd(kCarrier, demand)
		FSFC_ShipDemandAdd(kCarrier2, demand)
	end

	-- Wealth Boost (Spend excess RUs)
	if (GetRU() > 50000) then
		FSFC_ShipDemandAddByClass(eFighter, 3.0)
		FSFC_ShipDemandAddByClass(eCorvette, 3.0)
		FSFC_ShipDemandAdd(kCarrier, 5.0)
		FSFC_ShipDemandAdd(kCarrier2, 5.0)
		
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
		local maxC = 6
		local maxHC = 3
		local maxBC = 3

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

		-- When ALL caps are saturated: nuke residual eFrigate class demand and force strike craft
		-- (ShipDemandSet only caps individual ships; DetermineClassDemand still gives ~15-19 to the whole
		--  eFrigate class. ShipDemandAddByClass cancels that so fighters win the build queue.)
		if (numC >= maxC and numHC >= maxHC and numBC >= maxBC) then
			FSFC_ShipDemandAddByClass(eFrigate, -30)
			FSFC_ShipDemandAddByClass(eFighter, 12.0)
			FSFC_ShipDemandAddByClass(eCorvette, 8.0)
		end

		-- Only add demand if under the caps
		if (numC < maxC or (kHeavyCruiser ~= nil and numHC < maxHC)) then
			if (kHeavyCruiser ~= nil and numHC * 2 < numC and numHC < maxHC) then
				if (numC < maxC) then
					FSFC_ShipDemandAdd(kCruiser, 5.0, "ter_cruiser_force")
				end
				FSFC_ShipDemandAdd(kHeavyCruiser, 15.0, "ter_heavycruiser_force")
			else
				if (numC < maxC) then
					FSFC_ShipDemandAdd(kCruiser, 15.0, "ter_cruiser_force")
				end
				if (kHeavyCruiser ~= nil and numHC < maxHC) then
					FSFC_ShipDemandAdd(kHeavyCruiser, 5.0, "ter_heavycruiser_force")
				end
			end
		end

		if (kBattleCruiser ~= nil and numBC < maxBC) then
			FSFC_ShipDemandAdd(kBattleCruiser, 10.0, "ter_battlecruiser_force")
		end
	elseif (GetRU() > 10000) then
		FSFC_ShipDemandAddByClass(eFighter, 1.5)
		FSFC_ShipDemandAddByClass(eCorvette, 1.0)
		FSFC_ShipDemandAdd(kCarrier, 1.0)
		FSFC_ShipDemandAdd(kCarrier2, 1.0)
		
		local numC = FSFC_NumSquadrons(kCruiser) + FSFC_NumSquadronsQ(kCruiser)
		local numHC = 0
		if (kHeavyCruiser ~= nil) then
			numHC = FSFC_NumSquadrons(kHeavyCruiser) + FSFC_NumSquadronsQ(kHeavyCruiser)
		end
		local numBC = 0
		if (kBattleCruiser ~= nil) then
			numBC = FSFC_NumSquadrons(kBattleCruiser) + FSFC_NumSquadronsQ(kBattleCruiser)
		end
		
		local maxC = 6
		local maxHC = 3
		local maxBC = 3

		if (numC >= maxC) then
			FSFC_ShipDemandSet(kCruiser, -100)
		end
		if (kHeavyCruiser ~= nil and numHC >= maxHC) then
			FSFC_ShipDemandSet(kHeavyCruiser, -100)
		end
		if (kBattleCruiser ~= nil and numBC >= maxBC) then
			FSFC_ShipDemandSet(kBattleCruiser, -100)
		end

		-- When ALL caps are saturated: nuke residual eFrigate class demand and force strike craft
		if (numC >= maxC and numHC >= maxHC and numBC >= maxBC) then
			FSFC_ShipDemandAddByClass(eFrigate, -30)
			FSFC_ShipDemandAddByClass(eFighter, 8.0)
			FSFC_ShipDemandAddByClass(eCorvette, 6.0)
		end

		if (numC < maxC or (kHeavyCruiser ~= nil and numHC < maxHC)) then
			if (kHeavyCruiser ~= nil and numHC * 2 < numC and numHC < maxHC) then
				if (numC < maxC) then
					FSFC_ShipDemandAdd(kCruiser, 1.0, "ter_cruiser_mid")
				end
				FSFC_ShipDemandAdd(kHeavyCruiser, 3.0, "ter_heavycruiser_mid")
			else
				if (numC < maxC) then
					FSFC_ShipDemandAdd(kCruiser, 3.0, "ter_cruiser_mid")
				end
			end
		end
	end

	local numShipyards = FSFC_NumSquadrons(kShipyard)
	if (numShipyards < shipyardGoal and s_selfTotalValue > 60) then
		FSFC_ShipDemandAdd(kShipyard, 0.5, "ter_arcadia")
	elseif (numShipyards >= shipyardGoal) then
		FSFC_ShipDemandSet(kShipyard, -100)
	end


	-- 4. Class-specific "Best Ship" Nudges (Occasional era-favors)
	if (kFighterSuperiority ~= nil) then FSFC_ShipDemandAdd(kFighterSuperiority, 0.3, "FighterSup") end
	if (kBomberHeavy ~= nil) then FSFC_ShipDemandAdd(kBomberHeavy, 0.2, "BomberHeavy") end
	if (FSFC_NumSquadrons(kCarrier)+FSFC_NumSquadrons(kCarrier2) >= 2 or GetRU() > 20000) then
		local numC = FSFC_NumSquadrons(kCruiser) + FSFC_NumSquadronsQ(kCruiser)
		local numHC = 0
		if (kHeavyCruiser ~= nil) then
			numHC = FSFC_NumSquadrons(kHeavyCruiser) + FSFC_NumSquadronsQ(kHeavyCruiser)
		end
		
		local maxC = 6
		local maxHC = 3

		if (numC < maxC or (kHeavyCruiser ~= nil and numHC < maxHC)) then
			if (kHeavyCruiser ~= nil and numHC * 2 < numC and numHC < maxHC) then
				if (numC < maxC and kCruiser ~= nil) then FSFC_ShipDemandAdd(kCruiser, 0.15, "Cruiser") end
				FSFC_ShipDemandAdd(kHeavyCruiser, 0.8, "HeavyCruiser")
			else
				if (numC < maxC and kCruiser ~= nil) then FSFC_ShipDemandAdd(kCruiser, 0.45, "Cruiser") end
				if (kHeavyCruiser ~= nil and numHC < maxHC) then FSFC_ShipDemandAdd(kHeavyCruiser, 0.15, "HeavyCruiser") end
			end
		end
		
		if (kAdvancedCruiser ~= nil) then FSFC_ShipDemandAdd(kAdvancedCruiser, 0.5, "AdvancedCruiser") end
		if (kDestroyer ~= nil) then FSFC_ShipDemandAdd(kDestroyer, 0.45, "Destroyer") end
	end
	
	-- 5. Elite/Endgame Logic (The Colossus)
	if (kJuggernaut ~= nil and FSFC_IsResearchDone("Juggernaut") == 1) then
		if (GetRU() > 30000) then
			FSFC_ShipDemandAdd(kJuggernaut, 1.0, "ter_colossus")
		end
	end

	-- 6. Support/Utility
	if (kAWACS ~= nil and FSFC_NumSquadrons(kAWACS) < 2) then
		FSFC_ShipDemandAdd(kAWACS, 0.5, "ter_charybdis")
	end

	-- Write demand snapshot for global telemetry
	FSFC_WriteDemandSnapshot()
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Terran
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Terran
