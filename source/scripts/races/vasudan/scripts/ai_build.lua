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
	
	FSFC_ShipDemandAddByClass(eFighter, fighterDemand)
	FSFC_ShipDemandAddByClass(eCorvette, corvetteDemand)
	FSFC_ShipDemandAddByClass(eFrigate, frigateDemand)
	
	if (g_LOD >= 1 and kDestroyer ~= nil) then
		ShipDemandAdd(kDestroyer, 0.25)
	end
	if (g_LOD >= 2 and kBattleCruiser ~= nil) then
		ShipDemandAdd(kBattleCruiser, 0.5)
	end
end

function DetermineSpecialDemand_Vasudan()
	local currentRU = GetRU()

	-- Safety initialization for custom race environment
	if (s_enemyIndex == nil) then s_enemyIndex = -1 end
	if (player_max == nil) then player_max = 0 end

	-- SHIP COUNTS (Standardized for logic gates)
	local numCollectors = FSFC_NumSquadrons(kCollector)
	local numRefineries = FSFC_NumSquadrons(kRefinery)
	local numCarriers = FSFC_NumSquadrons(kCarrier)
	local numScouts = FSFC_NumSquadrons(kScout)
	local numShipyards = FSFC_NumSquadrons(kShipyard)
	local numFInt = FSFC_NumSquadrons(kFighterInterceptor)
	local numAten = FSFC_NumSquadrons(kCruiser)
	local numMentu = FSFC_NumSquadrons(kHeavyCruiser)
	local numJugg = FSFC_NumSquadrons(kJuggernaut)
	
	-- PRODUCTION ESCALATION (User Strategy)
	if (numCollectors < 12) then
		ShipDemandAdd(kCollector, 1.5)
	end
	
	if (numRefineries < 1) then
		ShipDemandAdd(kRefinery, 1.5)
	elseif (numRefineries < 2 and currentRU > 1000) then
		ShipDemandAdd(kRefinery, 1.2)
	end
	
	if (numCarriers < 1 and currentRU > 6000) then
		ShipDemandAdd(kCarrier, 3.0) -- Gentle rush for first GVD Typhon
		FSFC_Log_Demand("CarrierRush", 3.0)
	end

	-- VASUDAN ELITE LOGIC (Modernized Response)
	local fighterTarget = 30
	local bomberTarget = 40 -- Increased base bomber focus
	local carrierTarget = 4
	local capDemand = 0.8
	local fighterDemand = 1.8
	local bomberDemand = 2.0 -- Vasudans love their bombers

	-- Facing the Terran "Wall of Steel"?
	local enemyCapCount = 0
	if (s_enemyIndex ~= -1) then
		enemyCapCount = (PlayersUnitTypeCount(s_enemyIndex, player_max, eFrigate) + PlayersUnitTypeCount(s_enemyIndex, player_max, eCapital))
	end
	
	if (currentRU > 10000) then
		fighterTarget = 100
		bomberTarget = 120 -- Massive bomber surge
		carrierTarget = 6
		capDemand = 2.5
		-- If Terrans are going big, we MUST have Sobeks AND Bombers
		if (enemyCapCount > 8) then
			fighterDemand = 1.0 -- Vasudans need screens too
			bomberDemand = 4.0 -- Elite Bomber Rush
			capDemand = 5.0
		end
	end
	
	if (currentRU > 50000) then
		fighterTarget = 150
		bomberTarget = 220 	-- High RU: The Cloud of Death
	end
	
	if (currentRU > 12000) then
		bomberTarget = 150
		bomberDemand = 3.5
	end

	-- Recon Doctrine: High persistence scouting
	if (kScout ~= nil) then
		if (numScouts < 2) then
			ShipDemandAdd(kScout, 2.0)
			FSFC_Log_Demand("Scouts", 2.0)
			-- Early game queue management: Throttle harvesters slightly if we have NO scouts
			if (gameTime() < 120 and kCollector ~= nil) then
				ShipDemandAdd(kCollector, -1.0)
			end
		elseif (numScouts < 4) then
			ShipDemandAdd(kScout, 1.0)
		end
	end

	-- Panic Spending Mode (Preserve the Imperium)
	if (currentRU > 150000) then
		fighterTarget = 250
		bomberTarget = 350 -- End-game bomber swarm
		carrierTarget = 18
		capDemand = 6.5
		fighterDemand = 2.5
	end

	-- Elite Suppression: Throttle Thoth/Tauret if we lack backbone Interceptors
	local suppression = 1.0
	if (numFInt < 12) then
		suppression = 0.4 -- Force Horus/Serapis
	end

	-- Class-Based Fighter Doctrine
	FSFC_ShipDemandAddByClass(eFighter, fighterDemand * suppression)
	-- Minor nudges for era-appropriate best ships
	if (kFighterSuperiority ~= nil) then ShipDemandAdd(kFighterSuperiority, 0.2) end
	if (kFighterInterceptor ~= nil) then ShipDemandAdd(kFighterInterceptor, 0.1) end
	
	-- Diversified Bomber Swarm: Using Class Demand
	FSFC_ShipDemandAddByClass(eCorvette, 1.0) -- General bomber demand
	if (kBomberHeavy ~= nil) then
		ShipDemandAdd(kBomberHeavy, 0.5) -- Nudge for Sehkmet
	end

	if (kCarrier ~= nil and FSFC_NumSquadrons(kCarrier) < carrierTarget) then
		local typhonDemand = 1.0
		if (capDemand > 1.5) then
			typhonDemand = capDemand * 0.8
		end
		if (currentRU > 20000) then
			typhonDemand = typhonDemand + 1.0
		end
		ShipDemandAdd(kCarrier, typhonDemand)
	end

	-- Shipyard Escalation: PVI Karnak
	if (kShipyard ~= nil and numShipyards < 1 and currentRU > 15000) then
		ShipDemandAdd(kShipyard, 2.0)
		FSFC_Log_Demand("Karnaks", 2.0)
	elseif (kShipyard ~= nil and numShipyards < 3 and currentRU > 40000) then
		ShipDemandAdd(kShipyard, 1.0)
	end

	-- Juggernaut Doctrine: The Colossus (Alliance Asset)
	if (kJuggernaut ~= nil and FSFC_CheckResearch(COLOSSUS)) then
		if (numJugg < 1 and currentRU > 80000) then
			ShipDemandAdd(kJuggernaut, 10.0)
			FSFC_Log_Demand("Colossus", 10.0)
		end
	end

	-- Vasudan Cruiser Backbone (Using Class Demand)
	FSFC_ShipDemandAddByClass(eFrigate, 1.5)
	if (kCruiser ~= nil) then ShipDemandAdd(kCruiser, 0.5) end
	if (kHeavyCruiser ~= nil) then ShipDemandAdd(kHeavyCruiser, 0.4) end
	if (kDestroyer ~= nil) then ShipDemandAdd(kDestroyer, 0.3) end

	if (capDemand > 2.0) then
		FSFC_Log_Demand("Capitals", capDemand)
	end

	-- Prevent AWACS spam
	if (kAWACS ~= nil and (FSFC_NumSquadrons(kAWACS) >= 2)) then
		ShipDemandSet(kAWACS, -10)
	end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Vasudan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Vasudan
