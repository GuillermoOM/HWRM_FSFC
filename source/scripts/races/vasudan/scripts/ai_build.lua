dofilepath("data:scripts/custom_scripts/ai_telemetry.lua")
aitrace("LOADING VASUDAN BUILD INFO")

kCollector = VAS_ISIS
kCollectorFS1 = VAS_ISIS
kRefinery  = VAS_ANUKETBase

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
	kBattleCruiser = FSFC_PickBestShip(kBattleCruiserFS2, kBattleCruiserFS1)
	kCarrier = FSFC_PickBestShip(VAS_TYPHON, VAS_TYPHON_FS1)
	kResearch = VAS_IMHOTEP
	kAWACS = VAS_SETEKH
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
	
	ShipDemandAddByClass(eFighter, fighterDemand)
	ShipDemandAddByClass(eCorvette, corvetteDemand)
	ShipDemandAddByClass(eFrigate, frigateDemand)
	
	if (g_LOD >= 1) then
		ShipDemandAdd(kDestroyer, 0.25)
	end
	if (g_LOD >= 2) then
		ShipDemandAdd(kBattleCruiser, 0.5)
	end
end

function DetermineSpecialDemand_Vasudan()
	local currentRU = GetRU()
	
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
		fighterTarget = 80
		bomberTarget = 120 -- Massive bomber surge
		carrierTarget = 6
		capDemand = 2.5
		-- If Terrans are going big, we MUST have Sobeks AND Bombers
		if (enemyCapCount > 8) then
			fighterDemand = 0.4
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

	-- Recon Doctrine: Always have eyes on the field
	local numScouts = NumSquadrons(kScout) + NumSquadronsQ(kScout)
	if (s_militaryPop > 10 and numScouts < 1) then
		ShipDemandAdd(kScout, 2.5)
	elseif (s_militaryPop > 30 and numScouts < 2) then
		ShipDemandAdd(kScout, 2.0)
	end

	-- Panic Spending Mode (Preserve the Imperium)
	if (currentRU > 150000) then
		fighterTarget = 250
		bomberTarget = 350 -- End-game bomber swarm
		carrierTarget = 18
		capDemand = 6.5
		fighterDemand = 2.5
	end

	-- Diversified Fighter Wing: Split target across roles
	local numFInt = NumSquadrons(kFighterInterceptor) + NumSquadronsQ(kFighterInterceptor)
	local numFSup = NumSquadrons(kFighterSuperiority) + NumSquadronsQ(kFighterSuperiority)
	local numFAss = NumSquadrons(kFighterAssault) + NumSquadronsQ(kFighterAssault)
	local totalFighters = numFInt + numFSup + numFAss

	if (totalFighters < fighterTarget) then
		-- Vasudans favor their unique Space Superiority (Thoth) and Heavy Assault (Tauret)
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
	
	-- Diversified Bomber Swarm: Split target across roles
	local numBStrike = NumSquadrons(kBomberStrike) + NumSquadronsQ(kBomberStrike)
	local numBMedium = NumSquadrons(kBomberMedium) + NumSquadronsQ(kBomberMedium)
	local numBHeavy = NumSquadrons(kBomberHeavy) + NumSquadronsQ(kBomberHeavy)
	local totalBombers = numBStrike + numBMedium + numBHeavy

	if (totalBombers < bomberTarget) then
		-- Vasudans prioritize Medium/Heavy for their high-payload doctrine
		if (numBStrike < bomberTarget * 0.3) then
			ShipDemandAdd(kBomberStrike, 1.8)
		end
		if (numBMedium < bomberTarget * 0.4) then
			ShipDemandAdd(kBomberMedium, 1.6)
		end
		if (numBHeavy < bomberTarget * 0.3) then
			ShipDemandAdd(kBomberHeavy, 1.4)
		end
		FSFC_Log_Demand("Vasudan Bomber Swarm", 2.0)
	end

	if (NumSquadrons(kCarrier) + NumSquadronsQ(kCarrier) < carrierTarget) then
		ShipDemandAdd(kCarrier, 1.5)
		FSFC_Log_Demand("Typhons", 1.5)
	end

	-- Sobek/Hatshepsut Aggression
	ShipDemandAdd(kDestroyer, capDemand)
	ShipDemandAdd(kBattleCruiser, capDemand)
	
	-- Special Sobek hunter priority (Tank for the bombers)
	if (enemyCapCount > 10 and kDestroyer == VAS_SOBEK) then
		ShipDemandAdd(VAS_SOBEK, 3.5)
	end

	if (capDemand > 2.0) then
		FSFC_Log_Demand("Capitals", capDemand)
	end

	-- Prevent AWACS spam
	if (NumSquadrons(kAWACS) + NumSquadronsQ(kAWACS) >= 2) then
		ShipDemandSet(kAWACS, -10)
	end
end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Vasudan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Vasudan
