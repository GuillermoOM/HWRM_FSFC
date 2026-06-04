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
if (CPUPLAYERS_AGGRESSIVE == nil) then CPUPLAYERS_AGGRESSIVE = getglobal("cpuplayers_aggressive") or -1 end
if (CPUPLAYERS_DYNAMIC == nil) then CPUPLAYERS_DYNAMIC = getglobal("cpuplayers_dynamic") or -1 end
if (CPUPLAYERS_DEFENSIVE == nil) then CPUPLAYERS_DEFENSIVE = getglobal("cpuplayers_defensive") or -1 end

-- AI Ship Variable Mappings (Engine provided)

-- AI Research Variable Mappings (Engine provided from def_research.lua Name fields)
print("[AI_DIAG] Tactics IDs | Agg: " .. (CPUPLAYERS_AGGRESSIVE or "nil") .. " | Dyn: " .. (CPUPLAYERS_DYNAMIC or "nil") .. " | Def: " .. (CPUPLAYERS_DEFENSIVE or "nil"))
-- If any of these are missing in the current engine state, they will be nil.
-- The FSFC_ wrappers handle nil values safely.

-- Ensure common variables exist to avoid 'nil value' errors during script parsing
if (FIGHTERDESIGN == nil) then FIGHTERDESIGN = -1 end
if (BOMBERDESIGN == nil) then BOMBERDESIGN = -1 end
if (CRUISERDESIGN == nil) then CRUISERDESIGN = -1 end
if (CAPITALSHIPDESIGN == nil) then CAPITALSHIPDESIGN = -1 end
if (FS1 == nil) then FS1 = -1 end
if (FS2 == nil) then FS2 = -1 end
if (ORION == nil) then ORION = -1 end
if (DEIMOS == nil) then DEIMOS = -1 end
if (INSTALLATION == nil) then INSTALLATION = -1 end
if (SUPERDESTROYER == nil) then SUPERDESTROYER = -1 end
if (HECATE == nil) then HECATE = -1 end
if (TER_HADES == nil) then TER_HADES = -1 end
if (TER_HECATE == nil) then TER_HECATE = -1 end


-- Global variables like kBomber, kInterceptor etc are set by ai_build.lua

-- Global safe Util_CheckResearch is provided by ai_telemetry.lua

function NumSquadrons_Terran(id)
	return FSFC_NumSquadrons(id)
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

-- 1. ERA INDEPENDENT TECH
rt_terran_core = {
	{ id = "FS1", priority = 4.0, name = "FS1" },
	{ id = "FS2", priority = 4.0, name = "FS2" },
	{ id = "TacticsDynamic", priority = 3.0, name = "TacticsDynamic" },
}

-- 2. FS1 ERA SHIP UNLOCKS
rt_terran_fs1 = {
	-- Fighters
	{ id = "APOLLO", priority = 1.0, name = "Apollo", class = eFighter, shipID = TER_APOLLO },
	{ id = "VALKYRIE", priority = 1.2, name = "Valkyrie", class = eFighter, shipID = TER_VALKYRIE },
	{ id = "HERCULES", priority = 1.3, name = "Hercules", class = eFighter, shipID = TER_HERCULES },
	{ id = "ULYSSES", priority = 1.1, name = "Ulysses", class = eFighter, shipID = TER_ULYSSES },
	-- Bombers
	{ id = "ATHENA", priority = 1.0, name = "BomberDesign", class = eCorvette, shipID = TER_ATHENA },
	{ id = "ZEUS", priority = 1.2, name = "Zeus", class = eCorvette, shipID = TER_ZEUS },
	{ id = "MEDUSA", priority = 1.5, name = "Medusa", class = eCorvette, shipID = TER_MEDUSA },
	{ id = "URSA", priority = 1.0, name = "Ursa", class = eCorvette, shipID = TER_URSA },
}

-- 3. FS2 ERA SHIP UNLOCKS
rt_terran_fs2 = {
	-- Fighters
	{ id = "PERSEUS", priority = 1.0, name = "Perseus", class = eFighter, shipID = TER_PERSEUS },
	{ id = "MYRMIDON", priority = 1.2, name = "Myrmidon", class = eFighter, shipID = TER_MYRMIDON },
	{ id = "HERCULESMK2", priority = 1.3, name = "HerculesMk2", class = eFighter, shipID = TER_HERCULESMK2 },
	{ id = "ARES", priority = 1.5, name = "Ares", class = eFighter, shipID = TER_ARES },
	{ id = "ERINYES", priority = 1.5, name = "Erinyes", class = eFighter, shipID = TER_ERINYES },
	{ id = "PEGASUS", priority = 2.0, name = "Pegasus", class = eFighter, shipID = TER_PEGASUS },
	-- Bombers
	{ id = "ZEUS", priority = 1.0, name = "Zeus", class = eCorvette, shipID = TER_ZEUS },
	{ id = "ARTEMIS", priority = 1.2, name = "Artemis", class = eCorvette, shipID = TER_ARTEMIS },
	{ id = "MEDUSA", priority = 1.5, name = "Medusa", class = eCorvette, shipID = TER_MEDUSA },
	{ id = "BOANERGES", priority = 1.0, name = "Boanerges", class = eCorvette, shipID = TER_BOANERGES },
	{ id = "URSA", priority = 1.3, name = "Ursa", class = eCorvette, shipID = TER_URSA },
}

-- 4. CAPITAL/CRUISER TECH (Class-shared)
rt_terran_tech = {
	{ id = "CRUISERDESIGN", priority = 1.1, name = "CruiserDesign", class = eFrigate },
	{ id = "HEAVYCRUISER", priority = 1.0, name = "HeavyCruiser", class = eFrigate, shipID = TER_LEVIATHAN },
	{ id = "ADVANCEDCRUISER", priority = 1.2, name = "AdvancedCruiser", class = eFrigate, shipID = TER_AEOLUS },
	{ id = "REPAIRARGO", priority = 0.5, name = "RepairArgo", class = eFrigate, shipID = TER_ARGO },
	{ id = "REPAIRCHRONOS", priority = 0.5, name = "RepairChronos", class = eFrigate, shipID = TER_CHRONOS },
	
	{ id = "CAPITALSHIPDESIGN", priority = 1.1, name = "CapitalShipDesign", class = eCapital },
	{ id = "ORION", priority = 1.0, name = "CapitalShipDesign", class = eCapital, shipID = TER_ORION },
	{ id = "DEIMOS", priority = 1.0, name = "Deimos", class = eCapital, shipID = TER_DEIMOS },
	{ id = "COMMANDCORVETTE", priority = 1.0, name = "CommandCorvette", class = eCapital, shipID = TER_ICENI },
	{ id = "SUPERDESTROYER", priority = 1.2, name = "SuperDestroyer", class = eCapital, shipID = TER_HADES },
	{ id = "HECATE", priority = 1.2, name = "Hecate", class = eCapital, shipID = TER_HECATE },
	{ id = "JUGGERNAUT", priority = 1.3, name = "Juggernaut", class = eCapital, shipID = TER_COLOSSUS },
	{ id = "INSTALLATION", priority = 0.8, name = "Installation", class = eCapital, shipID = TER_ARCADIA },
}

-- 5. UTILITY/SPECIAL
rt_terran_utility = {
	{ id = "SENTRYGUN", priority = 0.5, name = "SentryGun" },
	{ id = "SENTRYANDMINEDEPLOYER", priority = 0.5, name = "SentryAndMineDeployer" },
	{ id = "BEAMSENTRY", priority = 0.5, name = "BeamSentry", shipID = TER_MJOLNIR },
	{ id = "SCIENCEVESSEL", priority = 0.5, name = "ScienceVessel", shipID = TER_FAUSTUS },
	{ id = "AWACS", priority = 0.5, name = "AWACS", shipID = TER_CHARYBDIS },
}


function DoResearchTechDemand_Terran()
	-- A. Core Demand (Eras and Tactics)
	FSFC_ProcessResearchTable(rt_terran_core, 1.0)

	-- B. Era-Specific Ship Demand
	local fighterDemand = ShipDemandMaxByClass(eFighter) * 2
	local bomberDemand = ShipDemandMaxByClass(eCorvette) * 2
	
	local tbl_ships = rt_terran_fs1
	if (FSFC_IsResearchDone("FS2") == 1) then
		tbl_ships = rt_terran_fs2
	end

	local n = getn(tbl_ships)
	for i=1, n do
		local item = tbl_ships[i]
		local baseDemand = 0
		if (item.class == eFighter) then baseDemand = fighterDemand
		elseif (item.class == eCorvette) then baseDemand = bomberDemand end
		
		if (baseDemand > 0) then
			local id = FSFC_CheckResearch(item.id, item.shipID)
			if (id) then
				ResearchDemandSet(id, baseDemand + item.priority)
				FSFC_Log_Research(item.name, baseDemand + item.priority)
			else
				FSFC_Log_Completed(item.id or item.name, item.name)
			end
		end
	end

	-- C. Capital and Cruiser Tech
	local frigateDemand = ShipDemandMaxByClass(eFrigate) * 2
	local capitalDemand = ShipDemandMaxByClass(eCapital) * 2.5
	
	-- We use a simple filter for tech that depends on base designs
	if (FSFC_CheckResearch("FIGHTERDESIGN")) then
		ResearchDemandSet(FSFC_ResolveID("FIGHTERDESIGN"), fighterDemand + 1.1)
		FSFC_Log_Research("FighterDesign", fighterDemand + 1.1)
	else
		FSFC_Log_Completed("FIGHTERDESIGN", "FighterDesign")
	end
	if (FSFC_CheckResearch("BOMBERDESIGN")) then
		ResearchDemandSet(FSFC_ResolveID("BOMBERDESIGN"), bomberDemand + 1.1)
		FSFC_Log_Research("BomberDesign", bomberDemand + 1.1)
	else
		FSFC_Log_Completed("BOMBERDESIGN", "BomberDesign")
	end
	
	-- Iterate tech table
	local n = getn(rt_terran_tech)
	for i=1, n do
		local item = rt_terran_tech[i]
		local baseDemand = 0
		if (item.class == eFrigate) then baseDemand = frigateDemand
		elseif (item.class == eCapital) then baseDemand = capitalDemand end
		
		if (baseDemand <= 0) then
			-- Baseline fallback to prevent starting flagship deadlock
			if ((item.id == "SUPERDESTROYER" or item.id == "HECATE") and FSFC_IsResearchDone("CapitalShipDesign") == 1) then
				baseDemand = 1.5
			end
		end
		
		if (baseDemand > 0) then
			local id = FSFC_CheckResearch(item.id, item.shipID)
			if (id) then
				ResearchDemandSet(id, baseDemand + item.priority)
				FSFC_Log_Research(item.name, baseDemand + item.priority)
			else
				FSFC_Log_Completed(item.id or item.name, item.name)
			end
		end
	end

	-- E. Utility
	FSFC_ProcessResearchTable(rt_terran_utility, 1.0)
end




function DoUpgradeDemand_Terran()
	-- Resource Upgrades
	local numCollectors = NumSquadrons_Terran(kCollector)
	if numCollectors > 3 and COLLECTORHP ~= nil then
		ResearchDemandAdd_Terran(COLLECTORHP, numCollectors * 2)
		FSFC_Log_Research("CollectorHP", numCollectors * 2)
	end
	local numRefineries = NumSquadrons_Terran(kRefinery)
	if numRefineries > 0 and DROPOFFHP ~= nil then
		ResearchDemandAdd_Terran(DROPOFFHP, numRefineries * 3)
		FSFC_Log_Research("RefineryHP", numRefineries * 3)
	end
	-- Carrier Build Speed
	local numCarriers = NumSquadrons_Terran(kCarrier) + NumSquadrons_Terran(kCarrier2)
	if numCarriers > 0 and HECATEBUILDSPEED ~= nil then
		ResearchDemandAdd_Terran(HECATEBUILDSPEED, numCarriers * 3)
		FSFC_Log_Research("HecateBuildSpeed", numCarriers * 3)
	end

	local numDestroyers = NumSquadrons_Terran(TER_DEIMOS)
	if numDestroyers > 0 then
		ResearchDemandAdd_Terran("DEIMOSARMOR", numDestroyers * 2)
	end
	local numFrigate = numActiveOfClass(s_playerIndex, eFrigate)
	if numFrigate > 0 then
		local numFrigateCount = NumSquadrons_Terran(TER_FENRIS) + NumSquadrons_Terran(TER_FENRIS_FS1)
		if numFrigateCount >= 1 then
			ResearchDemandAdd_Terran("CRUISERHEALTHUPGRADE", numFrigateCount * 5)
		end
	end
	local numBattleCruiser = NumSquadrons_Terran(kBattleCruiser)
	if numBattleCruiser > 0 and ORIONFLAK ~= nil then
		ResearchDemandAdd_Terran(ORIONFLAK, numBattleCruiser * 5)
	end
	local numAWACS = NumSquadrons_Terran(TER_CHARYBDIS)
	if numAWACS > 0 and AWACS2 ~= nil then
		ResearchDemandAdd_Terran(AWACS2, numAWACS * 3)
		ResearchDemandAdd_Terran(AWACS3, numAWACS * 3)
	end
end

function DoResearchTechDemand(playerIndex)
	DoResearchTechDemand_Terran()
	FSFC_WriteResearchSnapshot()
end

function DoUpgradeDemand(playerIndex)
	DoUpgradeDemand_Terran()
end
