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
	
	-- PRODUCTION ESCALATION (User Strategy)
	local numCollectors = NumSquadrons(kCollector) + NumSquadronsQ(kCollector)
	if (numCollectors < 12) then
		ShipDemandAdd(kCollector, 4.5)
	end
	
	local numRefineries = NumSquadrons(kRefinery) + NumSquadronsQ(kRefinery)
	if (numRefineries < 1) then
		ShipDemandAdd(kRefinery, 5.5)
	elseif (numRefineries < 2 and currentRU > 5000) then
		ShipDemandAdd(kRefinery, 2.5)
	end
	
	local numCarriers = NumSquadrons(kCarrier) + NumSquadronsQ(kCarrier)
	if (numCarriers < 1 and currentRU > 6000) then
		ShipDemandAdd(kCarrier, 15.0) -- Priority rush for first SD Demon
		FSFC_Log_Demand("CarrierRush", 15.0)
	end

	-- SHIVAN SWARM LOGIC (Aggressive Tiering)
	local fighterTarget = 30
	local bomberTarget = 20
	local carrierTarget = 4
	local capDemand = 0.8
	local fighterDemand = 1.8
	local bomberDemand = 1.5

	-- Safety initialization for custom race environment
	if (s_enemyIndex == nil) then s_enemyIndex = -1 end
	if (player_max == nil) then player_max = 0 end

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
	local numScouts = 0
	if (kScout ~= nil) then
		numScouts = NumSquadrons(kScout) + NumSquadronsQ(kScout)
		if (numScouts < 2) then
			ShipDemandAdd(kScout, 10.0)
			FSFC_Log_Demand("Scouts", 10.0)
			-- Early game queue management: Throttle harvesters slightly if we have NO scouts
			if (gameTime() < 120 and kCollector ~= nil) then
				ShipDemandAdd(kCollector, -2.0)
			end
		elseif (numScouts < 4) then
			ShipDemandAdd(kScout, 4.5)
			FSFC_Log_Demand("Scouts", 4.5)
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
		suppression = 0.5 -- Force backbone Interceptors (Manticore)
	end

	-- Only build fighters if we aren't "Cap-Starved" against Terran beams
	-- Diversified Fighter Wing: Split target across roles
	local numFInt = NumSquadrons(kFighterInterceptor) + NumSquadronsQ(kFighterInterceptor)
	local numFSup = NumSquadrons(kFighterSuperiority) + NumSquadronsQ(kFighterSuperiority)
	local numFAss = NumSquadrons(kFighterAssault) + NumSquadronsQ(kFighterAssault)
	local totalFighters = numFInt + numFSup + numFAss

	if (totalFighters < fighterTarget) then
		-- Shivans prioritize overwhelming numbers of Superiority (Mara) and Assault (Basilisk)
		if (kFighterSuperiority ~= nil and numFSup < fighterTarget * 0.4) then
			ShipDemandAdd(kFighterSuperiority, fighterDemand * suppression)
		end
		if (kFighterInterceptor ~= nil and numFInt < fighterTarget * 0.3) then
			ShipDemandAdd(kFighterInterceptor, fighterDemand * 0.8)
		end
		if (kFighterAssault ~= nil and numFAss < fighterTarget * 0.3) then
			ShipDemandAdd(kFighterAssault, fighterDemand * 0.9)
		end
		if (fighterDemand > 1.0) then FSFC_Log_Demand("Fighter Diversification", fighterDemand) end
	end
	
	-- Diversified Shivan Swarm: Split target across roles
	local numBStrike = NumSquadrons(kBomberStrike) + NumSquadronsQ(kBomberStrike)
	local numBMedium = NumSquadrons(kBomberMedium) + NumSquadronsQ(kBomberMedium)
	local numBHeavy = NumSquadrons(kBomberHeavy) + NumSquadronsQ(kBomberHeavy)
	local totalBombers = numBStrike + numBMedium + numBHeavy

	if (totalBombers < bomberTarget) then
		-- Shivans prioritize overwhelming numbers (Strike/Medium)
		if (kBomberStrike ~= nil and numBStrike < bomberTarget * 0.4) then
			ShipDemandAdd(kBomberStrike, bomberDemand)
		end
		if (kBomberMedium ~= nil and numBMedium < bomberTarget * 0.4) then
			ShipDemandAdd(kBomberMedium, bomberDemand * 0.9)
		end
		if (kBomberHeavy ~= nil and numBHeavy < bomberTarget * 0.2) then
			ShipDemandAdd(kBomberHeavy, bomberDemand * 0.8)
		end
		FSFC_Log_Demand("Shivan Bomber Swarm", bomberDemand)
	end

	if (kCarrier ~= nil and NumSquadrons(kCarrier) + NumSquadronsQ(kCarrier) < carrierTarget) then
		local demonDemand = 2.5
		if (capDemand > 1.5) then
			demonDemand = capDemand * 1.5
		end
		if (currentRU > 20000) then
			demonDemand = demonDemand + 2.0 -- High interest in production when rich
		end
		ShipDemandAdd(kCarrier, demonDemand)
		FSFC_Log_Demand("Demons", demonDemand)
	end

	-- Persistent Destroyer/Battlecruiser demand
	if (kDestroyer ~= nil) then ShipDemandAdd(kDestroyer, capDemand) end
	
	-- Shipyard Escalation: Build more production ships if rich
	local numShipyards = NumSquadrons(kShipyard) + NumSquadronsQ(kShipyard)
	if (currentRU > 30000 and numShipyards < 2) then
		ShipDemandAdd(kShipyard, 10.0)
	elseif (currentRU > 60000 and numShipyards < 4) then
		ShipDemandAdd(kShipyard, 5.0)
	end
	
	-- Shivan Cruiser-Specific Aggression (Rakshasa/Lilith/Cain)
	-- Backbone Logic: Ensure a minimum fleet presence for standard cruisers
	local numCain = NumSquadrons(kCruiser) + NumSquadronsQ(kCruiser)
	local numLilith = NumSquadrons(kHeavyCruiser) + NumSquadronsQ(kHeavyCruiser)

	-- Ravana Anti-Capital Priority: If enemy has capital ships, the Ravana is preferred.
	if (s_enemyIndex ~= -1 and kBattleCruiser ~= nil) then
		if (enemyCapCount > 0) then
			-- Throttled by Backbone
			if (numCain >= 4) then
				ShipDemandAdd(kBattleCruiser, capDemand * 2.5)
				FSFC_Log_Demand("Ravana Suppression", capDemand * 2.5)
			else
				ShipDemandAdd(kBattleCruiser, 0.5)
			end
		else
			-- Persistent Battlecruiser demand
			ShipDemandAdd(kBattleCruiser, capDemand)
		end
	end
	
	-- Cain Baseline (Swarm Escort - 12 wings)
	if (kCruiser ~= nil and numCain < 12) then
		ShipDemandAdd(kCruiser, 3.5) -- High priority backbone
	end
	
	-- Lilith Baseline (Heavy Swarm - 8 wings)
	if (kHeavyCruiser ~= nil and numLilith < 8) then
		ShipDemandAdd(kHeavyCruiser, 2.5)
	end
	
	-- Rakshasa Elite Demand (Throttled by Backbone)
	if (kAdvancedCruiser ~= nil) then
		if (currentRU > 12000 and numCain >= 6) then
			ShipDemandAdd(kAdvancedCruiser, 2.8)
		elseif (currentRU > 12000) then
			ShipDemandAdd(kAdvancedCruiser, 0.5) -- Suppress if backbone is missing
		end
	end

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
		local numSath = NumSquadrons(SHI_SATHANAS) + NumSquadronsQ(SHI_SATHANAS)
		if (numSath < 1 and currentRU > 60000) then
			ShipDemandAdd(SHI_SATHANAS, 20.0)
			FSFC_Log_Demand("Sathanas", 20.0)
		elseif (numSath < 2 and currentRU > 120000) then
			ShipDemandAdd(SHI_SATHANAS, 10.0)
		end
	end

	if (capDemand > 2.0) then
		FSFC_Log_Demand("Capitals", capDemand)
	end
	
	-- Prevent Comm Node spam (limit to 2 for Research/AWACS)
	if (SHI_COMMNODE ~= nil and (NumSquadrons(SHI_COMMNODE) + NumSquadronsQ(SHI_COMMNODE) >= 2)) then
		ShipDemandSet(SHI_COMMNODE, -10)
	end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Shivan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Shivan