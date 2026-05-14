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
	kShipyard = kBattleCruiser -- Map shipyard demand to Ravana/Lucifer
	kResearch = SHI_COMMNODE
	kAWACS = kScout
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
	
	FSFC_ShipDemandAddByClass(eFighter, fighterDemand)
	FSFC_ShipDemandAddByClass(eCorvette, corvetteDemand)
	FSFC_ShipDemandAddByClass(eFrigate, frigateDemand)
	
	FSFC_Log_Demand("Fighters", fighterDemand)
	FSFC_Log_Demand("Corvettes", corvetteDemand)
	FSFC_Log_Demand("Frigates", frigateDemand)
	
	if (g_LOD >= 1 and kDestroyer ~= nil) then
		ShipDemandAdd(kDestroyer, 0.25)
	end
	if (g_LOD >= 2 and kBattleCruiser ~= nil) then
		ShipDemandAdd(kBattleCruiser, 0.5)
	end
end

function DetermineSpecialDemand_Shivan()
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
	local numFSup = FSFC_NumSquadrons(kFighterSuperiority)
	local numCain = FSFC_NumSquadrons(kCruiser)
	local numLilith = FSFC_NumSquadrons(kHeavyCruiser)
	local numJugg = FSFC_NumSquadrons(SHI_SATHANAS)
	
	-- PRODUCTION ESCALATION (User Strategy)
	if (numCollectors < 12) then
		ShipDemandAdd(kCollector, 1.5)
	end
	
	if (numRefineries < 1) then
		ShipDemandAdd(kRefinery, 1.5)
	elseif (numRefineries < 2 and currentRU > 1000) then
		ShipDemandAdd(kRefinery, 1.2) -- Aggressive 2nd refinery for economic parity
	end
	
	if (numCarriers < 1 and currentRU > 6000) then
		ShipDemandAdd(kCarrier, 3.0) -- Gentle rush for first SD Demon
		FSFC_Log_Demand("CarrierRush", 3.0)
	end

	-- SHIVAN SWARM LOGIC (Aggressive Tiering)
	local fighterTarget = 30
	local bomberTarget = 20
	local carrierTarget = 4
	local capDemand = 0.8
	local fighterDemand = 1.8
	local bomberDemand = 1.5

	-- Strategic Analysis: Are the Terrans "Going Big"?
	local enemyCapCount = 0
	if (s_enemyIndex ~= -1) then
		enemyCapCount = (PlayersUnitTypeCount(s_enemyIndex, player_max, eFrigate) + PlayersUnitTypeCount(s_enemyIndex, player_max, eCapital))
	end
	
	if (currentRU > 5000) then
		fighterTarget = 80
		bomberTarget = 60
		carrierTarget = 6
		capDemand = 2.5
		-- Throttle fighters if we need capitals to counter enemy cruisers
		if (enemyCapCount > 10) then
			fighterDemand = 1.0 -- Don't drop too low, need screens
			capDemand = 4.0
			bomberDemand = 3.5 -- Shivans should swarm with bombers
		end
		-- High RU: The Shivan Swarm
		if (currentRU > 8000) then
			fighterTarget = 120
			fighterDemand = 2.5
		end
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

	-- Capital Supremacy
	if (currentRU > 40000) then
		fighterTarget = 180
		bomberTarget = 120
		carrierTarget = 10
		capDemand = 4.5
	end

	-- Panic Spending Mode (The Swarm never stops)
	if (currentRU > 120000) then
		fighterTarget = 300
		bomberTarget = 280
		carrierTarget = 18
		capDemand = 7.0
		fighterDemand = 2.5
	end

	-- Elite Suppression: Throttle Dragon (FS1 Elite) if we lack backbone
	local suppression = 1.0
	if (kFighterSuperiority == SHI_DRAGON and numFSup < 12) then
		suppression = 0.7 -- Softened suppression to maintain fleet backbone
	end

	-- Class-Based Fighter Doctrine
	FSFC_ShipDemandAddByClass(eFighter, fighterDemand)
	-- Minor nudges for era-appropriate best ships
	if (kFighterSuperiority ~= nil) then ShipDemandAdd(kFighterSuperiority, 0.2) end
	if (kFighterInterceptor ~= nil) then ShipDemandAdd(kFighterInterceptor, 0.1) end
	
	-- Diversified Shivan Swarm: Using Class Demand
	FSFC_ShipDemandAddByClass(eCorvette, 1.0) -- General bomber demand
	if (kBomberHeavy ~= nil) then
		ShipDemandAdd(kBomberHeavy, 0.5) -- Nudge for Seraphim/Nephilim
	end

	if (kCarrier ~= nil and FSFC_NumSquadrons(kCarrier) < carrierTarget) then
		local demonDemand = 1.0
		if (capDemand > 1.5) then
			demonDemand = capDemand * 0.8
		end
		if (currentRU > 20000) then
			demonDemand = demonDemand + 1.0
		end
		ShipDemandAdd(kCarrier, demonDemand)
	end

	-- Persistent Destroyer/Battlecruiser demand
	if (kDestroyer ~= nil) then ShipDemandAdd(kDestroyer, capDemand) end
	
	-- Shipyard Escalation: Build more production ships if rich
	if (currentRU > 30000 and numShipyards < 2) then
		ShipDemandAdd(kShipyard, 2.0)
	elseif (currentRU > 60000 and numShipyards < 4) then
		ShipDemandAdd(kShipyard, 1.0)
	end
	
	-- Shivan Cruiser Backbone (Using Class Demand)
	FSFC_ShipDemandAddByClass(eFrigate, 1.5)
	if (kCruiser ~= nil) then ShipDemandAdd(kCruiser, 0.5) end
	if (kHeavyCruiser ~= nil) then ShipDemandAdd(kHeavyCruiser, 0.4) end
	if (kAdvancedCruiser ~= nil) then ShipDemandAdd(kAdvancedCruiser, 0.3) end

	if (enemyCapCount > 8) then
		-- Force cruiser response to match Terran Deimos/Fenris
		FSFC_ShipDemandAddByClass(eFrigate, capDemand * 1.5)
		FSFC_Log_Demand("Cruiser Response", capDemand * 1.5)
	end
	
	-- Safety gate for the ultra-expensive Lucifer (21,500 RUs)
	if (kBattleCruiser ~= nil and kBattleCruiser == SHI_LUCIFER and currentRU < 30000) then
		ShipDemandSet(SHI_LUCIFER, -10)
	end

	-- Juggernaut Doctrine: The Sathanas
	if (SHI_SATHANAS ~= nil and FSFC_CheckResearch(SATHANAS)) then
		if (numJugg < 1 and currentRU > 60000) then
			ShipDemandAdd(SHI_SATHANAS, 10.0)
			FSFC_Log_Demand("Sathanas", 10.0)
		elseif (numJugg < 2 and currentRU > 120000) then
			ShipDemandAdd(SHI_SATHANAS, 5.0)
		end
	end

	if (capDemand > 2.0) then
		FSFC_Log_Demand("Capitals", capDemand)
	end
	
	-- Prevent Comm Node spam (limit to 2 for Research/AWACS)
	if (SHI_COMMNODE ~= nil and (FSFC_NumSquadrons(SHI_COMMNODE) >= 2)) then
		ShipDemandSet(SHI_COMMNODE, -10)
	end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Shivan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Shivan