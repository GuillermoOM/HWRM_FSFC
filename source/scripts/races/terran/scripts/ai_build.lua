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
	kResearch = TER_FAUSTUS
	kAWACS = TER_CHARYBDIS
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
	
	ShipDemandAddByClass(eFighter, fighterDemand)
	ShipDemandAddByClass(eCorvette, corvetteDemand)
	ShipDemandAddByClass(eFrigate, frigateDemand)
	
	if (g_LOD >= 1) then
		ShipDemandAdd(kDestroyer, destroyerDemand + 0.25)
	end
	if (g_LOD >= 2) then
		ShipDemandAdd(kBattleCruiser, 0.5)
	end
end

function DetermineSpecialDemand_Terran()
	local currentRU = GetRU()
	
	-- TERRAN AEGIS LOGIC (Reactive Defense)
	local fighterTarget = 30
	local bomberTarget = 20
	local carrierTarget = 4
	local capDemand = 0.5
	local fighterDemand = 1.8 -- Added missing fighterDemand
	local interceptorDemand = 1.5

	-- Detect Swarm Threats
	local enemyFighterCount = 0
	local enemyBomberCount = 0
	if (s_enemyIndex ~= -1) then
		enemyFighterCount = PlayersUnitTypeCount(s_enemyIndex, player_max, eFighter)
		enemyBomberCount = PlayersUnitTypeCount(s_enemyIndex, player_max, eCorvette) -- Bombers are in eCorvette class in FSFC
	end
	
	if (currentRU > 10000) then
		fighterTarget = 100
		bomberTarget = 80
		carrierTarget = 6
		capDemand = 2.5
		-- Reactive Interceptor Surge
		if (enemyBomberCount > 30 or enemyFighterCount > 50) then
			interceptorDemand = 3.5 -- Clear the skies
			capDemand = 4.0
		elseif (enemyBomberCount > 15 or enemyFighterCount > 20) then
			interceptorDemand = 2.2 -- Moderate response
			capDemand = 3.0
		end
		
		-- Recon Doctrine: Always have eyes on the field
		local numScouts = NumSquadrons(kScout) + NumSquadronsQ(kScout)
		if (s_militaryPop > 10 and numScouts < 1) then
			ShipDemandAdd(kScout, 2.5)
		elseif (s_militaryPop > 30 and numScouts < 2) then
			ShipDemandAdd(kScout, 2.0)
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

	-- Diversified Fighter Wing: Split target across roles
	local numFInt = NumSquadrons(kFighterInterceptor) + NumSquadronsQ(kFighterInterceptor)
	local numFSup = NumSquadrons(kFighterSuperiority) + NumSquadronsQ(kFighterSuperiority)
	local numFAss = NumSquadrons(kFighterAssault) + NumSquadronsQ(kFighterAssault)
	local totalFighters = numFInt + numFSup + numFAss
	local numErinyes = NumSquadrons(kFighterSpecial1) + NumSquadronsQ(kFighterSpecial1)
	local numAres = NumSquadrons(kFighterSpecial2) + NumSquadronsQ(kFighterSpecial2)

	-- Elite Suppression: If we have the tech but are understrength, throttle standard fighter demand to clear queue space
	local suppression = 1.0
	if (FSFC_CheckResearch(ERINYES) or FSFC_CheckResearch(ARES)) then
		if (numErinyes < 8 or numAres < 4) then
			suppression = 0.4 -- Heavy suppression to force elite wing priority
		end
	end

	if (totalFighters < fighterTarget) then
		-- Prioritize roles based on target count (40% Sup, 30% Int, 30% Ass)
		if (numFSup < fighterTarget * 0.4) then
			ShipDemandAdd(kFighterSuperiority, fighterDemand * suppression)
		end
		if (numFInt < fighterTarget * 0.3) then
			ShipDemandAdd(kFighterInterceptor, fighterDemand * 0.8 * suppression)
		end
		if (numFAss < fighterTarget * 0.3) then
			ShipDemandAdd(kFighterAssault, fighterDemand * 0.7 * suppression)
		end
		if (fighterDemand > 2.0) then FSFC_Log_Demand("Fighter Diversification", fighterDemand) end
	end
		-- Diversified Bomber Strike: Split target across roles
		local numBStrike = NumSquadrons(kBomberStrike) + NumSquadronsQ(kBomberStrike)
		local numBMedium = NumSquadrons(kBomberMedium) + NumSquadronsQ(kBomberMedium)
		local numBHeavy = NumSquadrons(kBomberHeavy) + NumSquadronsQ(kBomberHeavy)
		local totalBombers = numBStrike + numBMedium + numBHeavy

		if (totalBombers < bomberTarget) then
			-- Prioritize roles based on target count
			if (numBStrike < bomberTarget * 0.4) then
				ShipDemandAdd(kBomberStrike, 1.8)
			end
			if (numBMedium < bomberTarget * 0.4) then
				ShipDemandAdd(kBomberMedium, 1.6)
			end
			if (numBHeavy < bomberTarget * 0.2) then
				ShipDemandAdd(kBomberHeavy, 1.4)
			end
			FSFC_Log_Demand("Bomber Diversification", 1.8)
		end
		
		-- Aeolus Anti-Fighter Priority
		if (enemyFighterCount > 20 or enemyBomberCount > 10) then
			ShipDemandAdd(TER_AEOLUS, 3.5)
			FSFC_Log_Demand("Aeolus Guard", 3.5)
		end

		-- Standard Fleet Cruiser Backbone (Fenris/Leviathan)
		-- These units have higher caps (25) and form the main escort fleet
		local numCruisers = NumSquadrons(kCruiser) + NumSquadronsQ(kCruiser)
		local numHCruisers = NumSquadrons(kHeavyCruiser) + NumSquadronsQ(kHeavyCruiser)
		
		if (numCruisers < 10) then
			ShipDemandAdd(kCruiser, 2.0)
		end
		if (numHCruisers < 6) then
			ShipDemandAdd(kHeavyCruiser, 1.8)
		end

		if (NumSquadrons(kCarrier) + NumSquadronsQ(kCarrier) < carrierTarget) then
			ShipDemandAdd(kCarrier, 1.2)
			FSFC_Log_Demand("Hecates", 1.2)
		end

		-- Persistent Destroyer/Battlecruiser demand if rich
		ShipDemandAdd(kDestroyer, capDemand)
		ShipDemandAdd(kBattleCruiser, capDemand)

		-- Orion Anti-Capital Priority: If enemy has capital ships, the Orion is preferred.
		if (s_enemyIndex ~= -1) then
			local enemyCapCount = PlayersUnitTypeCount(s_enemyIndex, player_max, eFrigate) + PlayersUnitTypeCount(s_enemyIndex, player_max, eCapital)
			if (enemyCapCount > 0) then
				ShipDemandAdd(TER_ORION, capDemand * 2.0)
				FSFC_Log_Demand("Orion Beam Suppression", capDemand * 2.0)
			end
		end

		-- Elite Fighter Demand (Erinyes)
		if (totalFighters < fighterTarget) then
			if (numErinyes < 8) then
				ShipDemandAdd(kFighterSpecial1, 2.5)
				FSFC_Log_Demand("Erinyes Elite Wing", 2.5)
			end
		end

		if (capDemand > 1.5) then
			FSFC_Log_Demand("Capitals", capDemand)
		end

		-- Prevent Special Fighter Spam (Erinyes/Ares)
		if (numErinyes >= 12) then
			ShipDemandSet(kFighterSpecial1, -100)
		end
		if (numAres >= 12) then
			ShipDemandSet(kFighterSpecial2, -100)
		end

		-- Prevent Aeolus spam (Elite Flak Cruiser)
		local numAeolus = NumSquadrons(TER_AEOLUS) + NumSquadronsQ(TER_AEOLUS)
		if (numAeolus >= 8) then
			ShipDemandSet(TER_AEOLUS, -50)
		end

		-- Prevent AWACS spam
		if (NumSquadrons(kAWACS) + NumSquadronsQ(kAWACS) >= 2) then
			ShipDemandSet(kAWACS, -10)
		end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Terran
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Terran
