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
	kInterceptor = kFighterInterceptor -- Fixed deadlock: point to basic interceptor
	kBomberStrike = FSFC_PickBestShip(kBomberStrikeFS2, kBomberStrikeFS1)
	kBomberMedium = FSFC_PickBestShip(kBomberMediumFS2, kBomberMediumFS1)
	kBomberHeavy = FSFC_PickBestShip(kBomberHeavyFS2, kBomberHeavyFS1)
	kBomber = kBomberStrike -- Fixed deadlock: point to basic strike bomber
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
	local carrierGoal = 4
	local shipyardGoal = 1
	
	-- Expert Overdrive: Scale factories with wealth
	if (GetRU() > 100000) then
		carrierGoal = 8
		shipyardGoal = 2
	end

	if (numBuilders < carrierGoal) then
		local demand = 3.0
		if (numBuilders > 1) then
			demand = 1.5
		end
		FSFC_ShipDemandAdd(kCarrier, demand)
	end

	-- Wealth Boost (Spend excess RUs)
	if (GetRU() > 50000) then
		FSFC_ShipDemandAddByClass(eFighter, 3.0)
		FSFC_ShipDemandAddByClass(eCorvette, 3.0)
		FSFC_ShipDemandAdd(kCarrier, 5.0)
		
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
		if (numC >= maxC and numHC >= maxHC and numBC >= maxBC) then
			FSFC_ShipDemandAddByClass(eFrigate, -30)
			FSFC_ShipDemandAddByClass(eFighter, 12.0)
			FSFC_ShipDemandAddByClass(eCorvette, 8.0)
		end

		-- Only add demand if under the caps
		if (numC < maxC or (kHeavyCruiser ~= nil and numHC < maxHC)) then
			if (kHeavyCruiser ~= nil and numHC * 2 < numC and numHC < maxHC) then
				if (numC < maxC) then
					FSFC_ShipDemandAdd(kCruiser, 5.0, "shi_cruiser_force")
				end
				FSFC_ShipDemandAdd(kHeavyCruiser, 15.0, "shi_heavycruiser_force")
			else
				if (numC < maxC) then
					FSFC_ShipDemandAdd(kCruiser, 15.0, "shi_cruiser_force")
				end
				if (kHeavyCruiser ~= nil and numHC < maxHC) then
					FSFC_ShipDemandAdd(kHeavyCruiser, 5.0, "shi_heavycruiser_force")
				end
			end
		end

		if (kBattleCruiser ~= nil and numBC < maxBC) then
			FSFC_ShipDemandAdd(kBattleCruiser, 10.0, "shi_battlecruiser_force")
		end
	elseif (GetRU() > 10000) then
		FSFC_ShipDemandAddByClass(eFighter, 1.5)
		FSFC_ShipDemandAddByClass(eCorvette, 1.0)
		FSFC_ShipDemandAdd(kCarrier, 1.0)
		
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
					FSFC_ShipDemandAdd(kCruiser, 1.0, "shi_cruiser_mid")
				end
				FSFC_ShipDemandAdd(kHeavyCruiser, 3.0, "shi_heavycruiser_mid")
			else
				if (numC < maxC) then
					FSFC_ShipDemandAdd(kCruiser, 3.0, "shi_cruiser_mid")
				end
			end
		end
	end

	-- 4. Class-specific "Best Ship" Nudges (Occasional era-favors)
	if (kFighterSuperiority ~= nil) then FSFC_ShipDemandAdd(kFighterSuperiority, 0.3, "FighterSup") end
	if (kBomberHeavy ~= nil) then FSFC_ShipDemandAdd(kBomberHeavy, 0.2, "BomberHeavy") end
	if (FSFC_NumSquadrons(kCarrier) >= 2) then
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