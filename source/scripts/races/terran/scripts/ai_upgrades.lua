dofilepath("data:scripts/custom_scripts/ai_telemetry.lua")
-- Terran AI Upgrades and Research Progression

-- Legacy Compatibility Layer for Vanilla AI Scripts
if (BATTLECRUISERIONWEAPONS == nil) then BATTLECRUISERIONWEAPONS = -1 end
if (HEAVYGUNS == nil) then HEAVYGUNS = -1 end
if (FIGHTERDRIVE == nil) then FIGHTERDRIVE = -1 end
if (ADVANCEDRESEARCH == nil) then ADVANCEDRESEARCH = -1 end
if (FIGHTERPRODUCTION == nil) then FIGHTERPRODUCTION = -1 end
if (CORVETTEPRODUCTION == nil) then CORVETTEPRODUCTION = -1 end
if (FRIGATEPRODUCTION == nil) then FRIGATEPRODUCTION = -1 end
if (CPUPLAYERS_NORUSHTIME5 == nil) then CPUPLAYERS_NORUSHTIME5 = -1 end
if (CPUPLAYERS_NORUSHTIME10 == nil) then CPUPLAYERS_NORUSHTIME10 = -1 end
if (CPUPLAYERS_NORUSHTIME15 == nil) then CPUPLAYERS_NORUSHTIME15 = -1 end

-- AI Ship Variable Mappings (Engine provided)

-- AI Research Variable Mappings (Engine provided from def_research.lua Name fields)
-- If any of these are missing in the current engine state, they will be nil.
-- The FSFC_ wrappers handle nil values safely.

-- Ensure common variables exist to avoid 'nil value' errors during script parsing
if (FIGHTERDESIGN == nil) then FIGHTERDESIGN = -1 end
if (BOMBERDESIGN == nil) then BOMBERDESIGN = -1 end
if (CRUISERDESIGN == nil) then CRUISERDESIGN = -1 end
if (CAPITALSHIPDESIGN == nil) then CAPITALSHIPDESIGN = -1 end
if (FS1 == nil) then FS1 = -1 end
if (FS2 == nil) then FS2 = -1 end

-- Global variables like kBomber, kInterceptor etc are set by ai_build.lua

-- Global safe Util_CheckResearch is provided by ai_telemetry.lua

function NumSquadrons_Terran(id)
	if (id ~= nil) then
		return NumSquadrons(id)
	end
	return 0
end

function ResearchDemandSet_Terran(id_or_name, demand)
	local id = FSFC_ResolveID(id_or_name)
	if (id) then
		ResearchDemandSet(id, demand)
	end
end

function ResearchDemandAdd_Terran(id_or_name, demand)
	local id = FSFC_ResolveID(id_or_name)
	if (id) then
		ResearchDemandAdd(id, demand)
	end
end

function DoResearchTechDemand_Terran()
	aitrace("DoResearchTechDemand_Terran start")
	-- 1. ERA SELECTION
	local demand = 4.0
	if (FSFC_CheckResearch(FS1)) then
		ResearchDemandSet_Terran(FS1, demand)
		FSFC_Log_Research("FS1")
	end
	if (FSFC_CheckResearch(FS2)) then
		ResearchDemandSet_Terran(FS2, demand)
		FSFC_Log_Research("FS2")
	end

	-- 2. UNIT CLASS TECH
	local fighterdemand = ShipDemandMaxByClass(eFighter) * 2
	if (fighterdemand > 0) then
		print("[AI_DIAG] P" .. s_playerIndex .. " | WANT | FighterClass | Demand: " .. fighterdemand)
		if (FSFC_CheckResearch(FIGHTERDESIGN)) then
			ResearchDemandSet_Terran(FIGHTERDESIGN, fighterdemand + 1.0)
			FSFC_Log_Research("FighterDesign")
		end
		-- Era-aware progression (Relaxed dependencies)
		if FSFC_IsResearchDone(FS2) == 1 then
			if FSFC_CheckResearch(PERSEUS) then
				ResearchDemandSet_Terran(PERSEUS, fighterdemand + 1.0)
				FSFC_Log_Research("Perseus")
			end
			if FSFC_CheckResearch(MYRMIDON) then
				ResearchDemandSet_Terran(MYRMIDON, fighterdemand + 1.2)
				FSFC_Log_Research("Myrmidon")
			end
			if FSFC_CheckResearch(HERCULESMK2) then
				ResearchDemandSet_Terran(HERCULESMK2, fighterdemand + 1.3)
				FSFC_Log_Research("HerculesMk2")
			end
			if FSFC_CheckResearch(ARES) then
				ResearchDemandSet_Terran(ARES, fighterdemand + 1.5)
				FSFC_Log_Research("Ares")
			end
			if FSFC_CheckResearch(ERINYES) then
				ResearchDemandSet_Terran(ERINYES, fighterdemand + 1.5)
				FSFC_Log_Research("Erinyes")
			end
		else
			-- FS1 Branch
			if FSFC_CheckResearch(APOLLO) then
				ResearchDemandSet_Terran(APOLLO, fighterdemand + 1.0)
				FSFC_Log_Research("Apollo")
			end
			if FSFC_CheckResearch(VALKYRIE) then
				ResearchDemandSet_Terran(VALKYRIE, fighterdemand + 1.2)
				FSFC_Log_Research("Valkyrie")
			end
			if FSFC_CheckResearch(HERCULES) then
				ResearchDemandSet_Terran(HERCULES, fighterdemand + 1.3)
				FSFC_Log_Research("Hercules")
			end
			if FSFC_CheckResearch(ULYSSES) then
				ResearchDemandSet_Terran(ULYSSES, fighterdemand + 1.1)
				FSFC_Log_Research("Ulysses")
			end
		end
	end

	local bomberdemand = ShipDemandMaxByClass(eCorvette) * 2
	if bomberdemand > 0 then
		if FSFC_CheckResearch(BOMBERDESIGN) then
			ResearchDemandSet_Terran(BOMBERDESIGN, bomberdemand + 1.0)
			FSFC_Log_Research("BomberDesign")
		end

		-- Era-aware progression (Relaxed dependencies)
		if FSFC_IsResearchDone(FS2) == 1 then
			-- FS2 Branch: Encourage parallel research of different roles
			if FSFC_CheckResearch(ZEUS) then
				ResearchDemandSet_Terran(ZEUS, bomberdemand + 1.0)
				FSFC_Log_Research("Zeus")
			end
			if FSFC_CheckResearch(ARTEMIS) then
				ResearchDemandSet_Terran(ARTEMIS, bomberdemand + 1.2)
				FSFC_Log_Research("Artemis")
			end
			if FSFC_CheckResearch(MEDUSA) then
				ResearchDemandSet_Terran(MEDUSA, bomberdemand + 1.5)
				FSFC_Log_Research("Medusa")
			end
			if FSFC_CheckResearch(BOANERGES) then
				ResearchDemandSet_Terran(BOANERGES, bomberdemand + 1.0)
				FSFC_Log_Research("Boanerges")
			end
			if FSFC_CheckResearch(URSA) then
				ResearchDemandSet_Terran(URSA, bomberdemand + 1.3)
				FSFC_Log_Research("Ursa")
			end
		else
			-- FS1 Branch
			if FSFC_CheckResearch(ATHENA) then
				ResearchDemandSet_Terran(ATHENA, bomberdemand + 1.0)
				FSFC_Log_Research("Athena")
			end
			if FSFC_CheckResearch(ZEUS) then
				ResearchDemandSet_Terran(ZEUS, bomberdemand + 1.2)
				FSFC_Log_Research("Zeus")
			end
			if FSFC_CheckResearch(MEDUSA) then
				ResearchDemandSet_Terran(MEDUSA, bomberdemand + 1.5)
				FSFC_Log_Research("Medusa")
			end
			if FSFC_CheckResearch(URSA) then
				ResearchDemandSet_Terran(URSA, bomberdemand + 1.0)
				FSFC_Log_Research("Ursa")
			end
		end
	end

	local cruiserdemand = ShipDemandMaxByClass(eFrigate) * 2
	if cruiserdemand > 0 then
		if FSFC_CheckResearch(CRUISERDESIGN) then
			ResearchDemandSet_Terran(CRUISERDESIGN, cruiserdemand + 1.0)
			FSFC_Log_Research("CruiserDesign")
		end

		if FSFC_CheckResearch(REPAIRARGO) then
			ResearchDemandSet_Terran(REPAIRARGO, cruiserdemand + 0.5)
			FSFC_Log_Research("RepairArgo")
		end
		if FSFC_CheckResearch(REPAIRCHRONOS) then
			ResearchDemandSet_Terran(REPAIRCHRONOS, cruiserdemand + 0.5)
			FSFC_Log_Research("RepairChronos")
		end

		if FSFC_IsResearchDone(CRUISERDESIGN) == 1 then
			if FSFC_CheckResearch(HEAVYCRUISER) then
				ResearchDemandSet_Terran(HEAVYCRUISER, cruiserdemand + 1.0)
				FSFC_Log_Research("HeavyCruiser")
			end
			if FSFC_CheckResearch(ADVANCEDCRUISER) then
				ResearchDemandSet_Terran(ADVANCEDCRUISER, cruiserdemand + 1.2)
				FSFC_Log_Research("AdvancedCruiser")
			end
		end
	end

	local capitaldemand = ShipDemandMaxByClass(eCapital)
	if capitaldemand > 0 then
		if FSFC_CheckResearch(CAPITALSHIPDESIGN) then
			ResearchDemandSet_Terran(CAPITALSHIPDESIGN, capitaldemand + 1.0)
			FSFC_Log_Research("CapitalShipDesign")
		end

		if FSFC_CheckResearch(CORVETTE) then
			ResearchDemandSet_Terran(CORVETTE, capitaldemand + 1.0)
			FSFC_Log_Research("Deimos")
		end

		if FSFC_IsResearchDone(CAPITALSHIPDESIGN) == 1 then
			if FSFC_CheckResearch(CORVETTE) then
				ResearchDemandSet_Terran(CORVETTE, capitaldemand + 1.0)
				FSFC_Log_Research("Deimos")
			end
			if FSFC_CheckResearch(COMMANDCORVETTE) then
				ResearchDemandSet_Terran(COMMANDCORVETTE, capitaldemand + 1.0)
				FSFC_Log_Research("Iceni")
			end
			if FSFC_CheckResearch(SUPERDESTROYER) then
				ResearchDemandSet_Terran(SUPERDESTROYER, capitaldemand + 1.2)
				FSFC_Log_Research("SuperDestroyer")
			end
			if FSFC_CheckResearch(JUGGERNAUT) then
				ResearchDemandSet_Terran(JUGGERNAUT, capitaldemand + 1.3)
				FSFC_Log_Research("Orion/Hecate")
			end
		end
	end
end

function DoUpgradeDemand_Terran()
	-- Resource Upgrades
	local numCollectors = NumSquadrons_Terran(kCollector)
	if numCollectors > 3 then
		ResearchDemandAdd_Terran(COLLECTORHP, numCollectors * 2)
	end
	local numRefineries = NumSquadrons_Terran(kRefinery)
	if numRefineries > 0 then
		ResearchDemandAdd_Terran(DROPOFFHP, numRefineries * 3)
	end
	-- Carrier Build Speed
	local numCarriers = NumSquadrons_Terran(kCarrier)
	if numCarriers > 0 then
		ResearchDemandAdd_Terran(HECATEBUILDSPEED, numCarriers * 3)
	end

	local numDestroyers = NumSquadrons_Terran(TER_DEIMOS)
	if numDestroyers > 0 then
		ResearchDemandAdd_Terran(DEIMOSARMOR, numDestroyers * 2)
	end
	local numFrigate = numActiveOfClass(s_playerIndex, eFrigate)
	if numFrigate > 1 then
		local numFrigateCount = NumSquadrons_Terran(TER_FENRIS) + NumSquadrons_Terran(TER_FENRIS_FS1)
		if numFrigateCount > 1 then
			ResearchDemandAdd_Terran(CRUISERHEALTHUPGRADE, numFrigateCount * 5)
		end
		local numCapture = NumSquadrons_Terran(TER_ARGO)
		if numCapture > 1 then
			ResearchDemandAdd_Terran(CAPTUREABILITY, numCapture * 5)
		end
		local numCapture = NumSquadrons_Terran(TER_CHRONOS)
		if numCapture > 1 then
			ResearchDemandAdd_Terran(CAPTUREABILITYFS1, numCapture * 5)
		end
	end
	local numBattleCruiser = NumSquadrons_Terran(kBattleCruiser)
	if numBattleCruiser > 0 then
		ResearchDemandAdd_Terran(ORIONFLAK, numBattleCruiser * 5)
	end
	local numAWACS = NumSquadrons_Terran(TER_CHARYBDIS)
	if numAWACS > 0 then
		ResearchDemandAdd_Terran(AWACS2, numAWACS * 3)
		ResearchDemandAdd_Terran(AWACS3, numAWACS * 3)
	end
end

function DoResearchTechDemand(playerIndex)
	DoResearchTechDemand_Terran()
end

function DoUpgradeDemand(playerIndex)
	DoUpgradeDemand_Terran()
end
