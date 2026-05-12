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
	kCarrier = FSFC_PickBestShip(SHI_DEMON, SHI_DEMON_FS1)
	kResearch = SHI_COMMNODE
	kAWACS = SHI_COMMNODE
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
	
	ShipDemandAddByClass(eFighter, fighterDemand)
	ShipDemandAddByClass(eCorvette, corvetteDemand)
	ShipDemandAddByClass(eFrigate, frigateDemand)
	
	FSFC_Log_Demand("Fighters", fighterDemand)
	FSFC_Log_Demand("Corvettes", corvetteDemand)
	FSFC_Log_Demand("Frigates", frigateDemand)
	
	if (g_LOD >= 1) then
		ShipDemandAdd(kDestroyer, 0.25)
	end
	if (g_LOD >= 2) then
		ShipDemandAdd(kBattleCruiser, 0.5)
	end
end

function DetermineSpecialDemand_Shivan()
	local currentRU = GetRU()
	
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
	
	if (currentRU > 8000) then
		fighterTarget = 80
		bomberTarget = 60
		carrierTarget = 6
		capDemand = 2.5
		-- Throttle fighters if we need capitals to counter enemy cruisers
		if (enemyCapCount > 10) then
			fighterDemand = 0.5
			capDemand = 4.0
		end
		-- High RU: The Shivan Swarm
		if (currentRU > 10000) then
			fighterTarget = 120
			fighterDemand = 2.5
		end
	end
	
	-- Recon Doctrine: Always have eyes on the field
	local numScouts = NumSquadrons(kScout) + NumSquadronsQ(kScout)
	if (s_militaryPop > 10 and numScouts < 1) then
		ShipDemandAdd(kScout, 2.5)
	elseif (s_militaryPop > 30 and numScouts < 2) then
		ShipDemandAdd(kScout, 2.0)
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

	-- Only build fighters if we aren't "Cap-Starved" against Terran beams
	-- Diversified Fighter Wing: Split target across roles
	local numFInt = NumSquadrons(kFighterInterceptor) + NumSquadronsQ(kFighterInterceptor)
	local numFSup = NumSquadrons(kFighterSuperiority) + NumSquadronsQ(kFighterSuperiority)
	local numFAss = NumSquadrons(kFighterAssault) + NumSquadronsQ(kFighterAssault)
	local totalFighters = numFInt + numFSup + numFAss

	if (totalFighters < fighterTarget) then
		-- Shivans prioritize overwhelming numbers of Superiority (Mara) and Assault (Basilisk)
		if (numFSup < fighterTarget * 0.4) then
			ShipDemandAdd(kFighterSuperiority, fighterDemand)
		end
		if (numFInt < fighterTarget * 0.3) then
			ShipDemandAdd(kFighterInterceptor, fighterDemand * 0.8)
		end
		if (numFAss < fighterTarget * 0.3) then
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
		if (numBStrike < bomberTarget * 0.4) then
			ShipDemandAdd(kBomberStrike, 1.8)
		end
		if (numBMedium < bomberTarget * 0.4) then
			ShipDemandAdd(kBomberMedium, 1.6)
		end
		if (numBHeavy < bomberTarget * 0.2) then
			ShipDemandAdd(kBomberHeavy, 1.4)
		end
		FSFC_Log_Demand("Shivan Bomber Swarm", 1.8)
	end

	if (NumSquadrons(kCarrier) + NumSquadronsQ(kCarrier) < carrierTarget) then
		ShipDemandAdd(kCarrier, 1.5)
		FSFC_Log_Demand("Demons", 1.5)
	end

	-- Persistent Destroyer/Battlecruiser demand
	ShipDemandAdd(kDestroyer, capDemand)
	ShipDemandAdd(kBattleCruiser, capDemand)
	
	-- Shivan Cruiser-Specific Aggression (Rakshasa/Lilith/Cain)
	if (enemyCapCount > 8) then
		-- Force cruiser response to match Terran Deimos/Fenris
		ShipDemandAddByClass(eFrigate, capDemand * 1.5)
		FSFC_Log_Demand("Cruisers", capDemand * 1.5)
	end
	
	-- Safety gate for the ultra-expensive Lucifer (21,500 RUs)
	if (kBattleCruiser == SHI_LUCIFER and currentRU < 45000) then
		ShipDemandSet(SHI_LUCIFER, -10)
	end

	if (capDemand > 2.0) then
		FSFC_Log_Demand("Capitals", capDemand)
	end
	
	-- Prevent Comm Node spam (limit to 2 for Research/AWACS)
	if (NumSquadrons(SHI_COMMNODE) + NumSquadronsQ(SHI_COMMNODE) >= 2) then
		ShipDemandSet(SHI_COMMNODE, -10)
	end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Shivan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Shivan