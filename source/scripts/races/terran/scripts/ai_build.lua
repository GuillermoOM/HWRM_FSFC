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
kBattleCruiserFS2 = TER_ORION
kBattleCruiserFS1 = TER_ORION_FS1
kFighterSpecial1 = TER_ERINYES
kFighterSpecial2 = TER_ARES

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
	kCruiser = FSFC_PickBestShip(kCruiserFS2, kCruiserFS1)
	kHeavyCruiser = FSFC_PickBestShip(kHeavyCruiserFS2, kHeavyCruiserFS1)
	kBattleCruiser = FSFC_PickBestShip(kBattleCruiserFS2, kBattleCruiserFS1)
	kCarrier = FSFC_PickBestShip(TER_HECATE, TER_ORION_FS1)
	kShipyard = TER_ARCADIA
	kJuggernaut = TER_COLOSSUS
	kResearch = TER_FAUSTUS
	kAWACS = kScout
end

function DetermineDemandWithNoCounterInfo_Terran()
	local fighterDemand = 0.5
	local corvetteDemand = 0.3
	local frigateDemand = 0.15
	local destroyerDemand = 0.05
	
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
		ShipDemandAdd(kDestroyer, destroyerDemand + 0.25)
	end
	if (g_LOD >= 2 and kBattleCruiser ~= nil) then
		ShipDemandAdd(kBattleCruiser, 0.5)
	end
end

function DetermineSpecialDemand_Terran()
	local currentRU = GetRU()

	-- Safety initialization for custom race environment
	if (s_enemyIndex == nil) then s_enemyIndex = -1 end
	if (player_max == nil) then player_max = 0 end

	-- SHIP COUNTS (Standardized for logic gates)
	local numErinyes = FSFC_NumSquadrons(kFighterSpecial1)
	local numAres = FSFC_NumSquadrons(kFighterSpecial2)
	local numCruisers = FSFC_NumSquadrons(kCruiser)
	local numCollectors = FSFC_NumSquadrons(kCollector)
	local numRefineries = FSFC_NumSquadrons(kRefinery)
	local numCarriers = FSFC_NumSquadrons(kCarrier)
	local numScouts = FSFC_NumSquadrons(kScout)
	local numShipyards = FSFC_NumSquadrons(kShipyard)
	local numJugg = FSFC_NumSquadrons(kJuggernaut)
	
	-- TERRAN AEGIS LOGIC (Reactive Defense)
	local fighterTarget = 30
	local bomberTarget = 20
	local carrierTarget = 4
	local capDemand = 0.5
	local fighterDemand = 1.8 -- Added missing fighterDemand
	local interceptorDemand = 1.5

	-- Elite Suppression: If we have the tech but are understrength, throttle standard fighter demand
	local suppression = 1.0
	if (FSFC_CheckResearch(ERINYES) or FSFC_CheckResearch(ARES)) then
		if (numErinyes < 4 or numAres < 2) then
			suppression = 0.8 -- Softened suppression to maintain fleet backbone
		end
	end

	-- PRODUCTION ESCALATION (User Strategy)
	if (numCollectors < 12) then
		ShipDemandAdd(kCollector, 1.5)
	end
	
	if (numRefineries < 1) then
		ShipDemandAdd(kRefinery, 1.5)
	elseif (numRefineries < 2 and currentRU > 1000) then
		ShipDemandAdd(kRefinery, 1.2) -- Aggressive 2nd refinery for economic parity
	end
	
	if (numCarriers < 1 and currentRU > 8000) then
		ShipDemandAdd(kCarrier, 3.0) -- Gentle rush for first GTD Hecate
		FSFC_Log_Demand("CarrierRush", 3.0)
	end

	-- Detect Swarm Threats
	local enemyFighterCount = 0
	local enemyBomberCount = 0
	if (s_enemyIndex ~= -1) then
		enemyFighterCount = PlayersUnitTypeCount(s_enemyIndex, player_max, eFighter)
		enemyBomberCount = PlayersUnitTypeCount(s_enemyIndex, player_max, eCorvette) -- Bombers are in eCorvette class in FSFC
	end
	
	-- Recon Doctrine: Early and high persistence scouting
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

	if (currentRU > 10000) then
		fighterTarget = 100
		bomberTarget = 80
		carrierTarget = 6
		capDemand = 1.5
		-- Reactive Interceptor Surge
		if (enemyBomberCount > 30 or enemyFighterCount > 50) then
			interceptorDemand = 2.0 -- Clear the skies
			capDemand = 2.5
		elseif (enemyBomberCount > 15 or enemyFighterCount > 20) then
			interceptorDemand = 1.2 -- Moderate response
			capDemand = 2.0
		end
	end

	
	if (currentRU > 50000) then
		fighterTarget = 200
		bomberTarget = 150
		carrierTarget = 10
		capDemand = 2.0
	end

	-- Panic Spending Mode
	if (currentRU > 150000) then
		fighterTarget = 300
		bomberTarget = 250
		carrierTarget = 15
		capDemand = 4.0
	end

	-- Class-Based Fighter Doctrine
	FSFC_ShipDemandAddByClass(eFighter, fighterDemand * suppression)
	-- Minor nudges for era-appropriate best ships
	if (kFighterSuperiority ~= nil) then ShipDemandAdd(kFighterSuperiority, 0.2) end
	if (kFighterInterceptor ~= nil) then ShipDemandAdd(kFighterInterceptor, 0.1) end
	
	-- Diversified Bomber Strike: Using Class Demand
	FSFC_ShipDemandAddByClass(eCorvette, 1.0) -- General bomber demand
	if (kBomberHeavy ~= nil) then
		ShipDemandAdd(kBomberHeavy, 0.5) -- Nudge for Heavy Assault Bombers
	end
		
		-- Aeolus Anti-Fighter Priority
		if (TER_AEOLUS ~= nil and (enemyFighterCount > 20 or enemyBomberCount > 10)) then
			ShipDemandAdd(TER_AEOLUS, 1.5)
			FSFC_Log_Demand("Aeolus Guard", 1.5)
		end

		-- Standard Fleet Cruiser Backbone (Using Class Demand)
		FSFC_ShipDemandAddByClass(eFrigate, 1.5)
		if (kCruiser ~= nil) then ShipDemandAdd(kCruiser, 0.5) end
		if (kHeavyCruiser ~= nil) then ShipDemandAdd(kHeavyCruiser, 0.3) end

		if (kCarrier ~= nil and FSFC_NumSquadrons(kCarrier) < carrierTarget) then
			ShipDemandAdd(kCarrier, 1.2)
			FSFC_Log_Demand("Hecates", 1.2)
		end

		-- Persistent Destroyer/Battlecruiser demand if rich
		if (kDestroyer ~= nil) then 
			if (numCruisers >= 4) then
				ShipDemandAdd(kDestroyer, capDemand) 
			else
				ShipDemandAdd(kDestroyer, 0.5)
			end
		end
		if (kBattleCruiser ~= nil) then ShipDemandAdd(kBattleCruiser, capDemand) end
		
		-- Shipyard Escalation: GTI Arcadia
		if (kShipyard ~= nil and numShipyards < 1 and currentRU > 15000) then
			ShipDemandAdd(kShipyard, 2.0)
			FSFC_Log_Demand("Arcadias", 2.0)
		elseif (kShipyard ~= nil and numShipyards < 3 and currentRU > 40000) then
			ShipDemandAdd(kShipyard, 1.0)
		end
		
		if (kCarrier ~= nil and FSFC_NumSquadrons(kCarrier) < carrierTarget) then
			local hecateDemand = 1.0
			if (capDemand > 1.5) then
				hecateDemand = capDemand * 0.8
			end
			if (currentRU > 20000) then
				hecateDemand = hecateDemand + 1.0
			end
			ShipDemandAdd(kCarrier, hecateDemand)
		end

		-- Juggernaut Doctrine: The Colossus
		if (kJuggernaut ~= nil and FSFC_CheckResearch(COLOSSUS)) then
			if (numJugg < 1 and currentRU > 80000) then
				ShipDemandAdd(kJuggernaut, 20.0)
				FSFC_Log_Demand("Colossus", 20.0)
			end
		end

		if (s_enemyIndex ~= -1 and TER_ORION ~= nil) then
			local enemyCapCount = PlayersUnitTypeCount(s_enemyIndex, player_max, eFrigate) + PlayersUnitTypeCount(s_enemyIndex, player_max, eCapital)
			if (enemyCapCount > 0) then
				ShipDemandAdd(TER_ORION, 0.8)
			end
		end

		-- Elite Fighter Nudges (End-game favor)
		if (kFighterSpecial1 ~= nil) then
			if (numErinyes < 8) then
				ShipDemandAdd(kFighterSpecial1, 0.1)
			end
		end
		if (kFighterSpecial2 ~= nil) then
			if (numAres < 4) then
				ShipDemandAdd(kFighterSpecial2, 0.1)
			end
		end


		if (capDemand > 1.5) then
			FSFC_Log_Demand("Capitals", capDemand)
		end

		-- Prevent Special Fighter Spam (Erinyes/Ares)
		if (kFighterSpecial1 ~= nil and numErinyes >= 12) then
			ShipDemandSet(kFighterSpecial1, -100)
		end
		if (kFighterSpecial2 ~= nil and numAres >= 12) then
			ShipDemandSet(kFighterSpecial2, -100)
		end

		-- Prevent Aeolus spam (Elite Flak Cruiser)
		if (TER_AEOLUS ~= nil) then
			local numAeolus = FSFC_NumSquadrons(TER_AEOLUS)
			if (numAeolus >= 8) then
				ShipDemandSet(TER_AEOLUS, -50)
			end
		end

		-- Prevent AWACS spam
		if (kAWACS ~= nil and (FSFC_NumSquadrons(kAWACS) >= 2)) then
			ShipDemandSet(kAWACS, -10)
		end

		-- Lower Argo/Chronos interest and cap at 2 (Repair ships)
		if (TER_ARGO ~= nil and TER_CHRONOS ~= nil) then
			local numArgo = FSFC_NumSquadrons(TER_ARGO)
			local numChronos = FSFC_NumSquadrons(TER_CHRONOS)
			if (numArgo + numChronos < 2) then
				ShipDemandAdd(TER_ARGO, 0.5)
				ShipDemandAdd(TER_CHRONOS, 0.5)
			else
				ShipDemandSet(TER_ARGO, -50)
				ShipDemandSet(TER_CHRONOS, -50)
			end
		end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Terran
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Terran
