dofilepath("data:scripts/custom_scripts/ai_telemetry.lua")
aitrace("LOADING SHIVAN UPGRADE INFO")

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

-- AI Research Variable Mappings (Engine provided from def_research.lua Name fields)
-- Ensure common variables exist to avoid 'nil value' errors during script parsing
if (FIGHTERDESIGN == nil) then FIGHTERDESIGN = -1 end
if (BOMBERDESIGN == nil) then BOMBERDESIGN = -1 end
if (CRUISERDESIGN == nil) then CRUISERDESIGN = -1 end
if (CAPITALSHIPDESIGN == nil) then CAPITALSHIPDESIGN = -1 end
if (FS1 == nil) then FS1 = -1 end
if (FS2 == nil) then FS2 = -1 end
if (CPUPLAYERS_AGGRESSIVE == nil) then CPUPLAYERS_AGGRESSIVE = getglobal("cpuplayers_aggressive") or -1 end
if (CPUPLAYERS_DYNAMIC == nil) then CPUPLAYERS_DYNAMIC = getglobal("cpuplayers_dynamic") or -1 end
if (CPUPLAYERS_DEFENSIVE == nil) then CPUPLAYERS_DEFENSIVE = getglobal("cpuplayers_defensive") or -1 end

function NumSquadrons_Shivan(id)
	return FSFC_NumSquadrons(id)
end

function ResearchDemandSet_Shivan(id_or_name, demand)
	local id = FSFC_ResolveID(id_or_name)
	if (id) then
		ResearchDemandSet(id, demand)
	end
end

function ResearchDemandAdd_Shivan(id_or_name, demand)
	local id = FSFC_ResolveID(id_or_name)
	if (id) then
		ResearchDemandAdd(id, demand)
	end
end

-- 1. ERA INDEPENDENT TECH
rt_shivan_core = {
	{ id = "FS1", priority = 4.0, name = "FS1" },
	{ id = "FS2", priority = 4.0, name = "FS2" },
	{ id = "TacticsDynamic", priority = 3.0, name = "TacticsDynamic" },
}

-- 2. FS1 ERA SHIP UNLOCKS
rt_shivan_fs1 = {
	-- Fighters
	{ id = "MANTICORE", priority = 1.0, name = "Manticore", class = eFighter, shipID = SHI_MANTICORE },
	{ id = "DRAGON", priority = 1.2, name = "Dragon", class = eFighter, shipID = SHI_DRAGON },
	{ id = "BASILISK", priority = 1.3, name = "Basilisk", class = eFighter, shipID = SHI_BASILISK },
	{ id = "GORGON", priority = 1.6, name = "Gorgon", class = eFighter, shipID = SHI_GORGON },
	-- Bombers
	{ id = "SHAITAN", priority = 1.0, name = "Shaitan", class = eCorvette, shipID = SHI_SHAITAN },
	{ id = "NEPHILIM", priority = 1.0, name = "Nephilim", class = eCorvette, shipID = SHI_NEPHILIM },
}

-- 3. FS2 ERA SHIP UNLOCKS
rt_shivan_fs2 = {
	-- Fighters
	{ id = "AESHMA", priority = 1.4, name = "Aeshma", class = eFighter, shipID = SHI_AESHMA },
	{ id = "MARA", priority = 1.5, name = "Mara", class = eFighter, shipID = SHI_MARA },
	{ id = "ASTAROTH", priority = 2.0, name = "Astaroth", class = eFighter, shipID = SHI_ASTAROTH },
	-- Bombers
	{ id = "TAURVI", priority = 1.2, name = "Taurvi", class = eCorvette, shipID = SHI_TAURVI },
	{ id = "NAHEMA", priority = 1.5, name = "Nahema", class = eCorvette, shipID = SHI_NAHEMA },
	{ id = "SERAPHIM", priority = 1.5, name = "Seraphim", class = eCorvette, shipID = SHI_SERAPHIM },
}

-- 4. CAPITAL/CRUISER TECH (Class-shared)
rt_shivan_tech = {
	{ id = "CRUISERDESIGN", priority = 1.1, name = "CruiserDesign", class = eFrigate },
	{ id = "CAIN", priority = 1.0, name = "Cain", class = eFrigate, shipID = SHI_CAIN },
	{ id = "LILITH", priority = 1.0, name = "Lilith", class = eFrigate, shipID = SHI_LILITH },
	{ id = "RAKSHASA", priority = 1.0, name = "Rakshasa", class = eFrigate, shipID = SHI_RAKSHASA },
	
	{ id = "CAPITALSHIPDESIGN", priority = 1.1, name = "CapitalShipDesign", class = eCapital },
	{ id = "MOLOCH", priority = 1.0, name = "Moloch", class = eCapital, shipID = SHI_MOLOCH },
	{ id = "RAVANA", priority = 1.5, name = "Ravana", class = eCapital, shipID = SHI_RAVANA },
	{ id = "SUPERCAPITALSHIPDESIGN", priority = 1.0, name = "SuperCapitalShipDesign", class = eCapital },
	{ id = "SUPERCAPITALSHIPDESIGN", priority = 1.0, name = "SuperCapitalShipDesign", class = eCapital, shipID = SHI_LUCIFER },
	{ id = "JUGGERNAUT", priority = 1.0, name = "Juggernaut", class = eCapital, shipID = SHI_SATHANAS },
}

-- 5. UTILITY/SPECIAL
rt_shivan_utility = {
	{ id = "SENTRYGUN", priority = 0.5, name = "SentryGun" },
	{ id = "AWACS", priority = 0.5, name = "AWACS", shipID = SHI_COMMNODE },
}

function DoResearchTechDemand_Shivan()
	-- A. Core Demand (Eras and Tactics)
	FSFC_ProcessResearchTable(rt_shivan_core, 1.0)

	-- B. Era-Specific Ship Demand
	local fighterDemand = ShipDemandMaxByClass(eFighter) * 2
	local bomberDemand = ShipDemandMaxByClass(eCorvette) * 2
	
	local tbl_ships = rt_shivan_fs1
	if (FSFC_IsResearchDone("FS2") == 1) then
		tbl_ships = rt_shivan_fs2
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
	
	-- Design Bases (always log these — they fire even with 0 fleet demand)
	if (FSFC_CheckResearch("FIGHTERDESIGN")) then
		local base = fighterDemand > 0 and fighterDemand or 1.5
		ResearchDemandSet(FSFC_ResolveID("FIGHTERDESIGN"), base + 1.1)
		FSFC_Log_Research("FighterDesign", base + 1.1)
	else
		FSFC_Log_Completed("FIGHTERDESIGN", "FighterDesign")
	end
	if (FSFC_CheckResearch("BOMBERDESIGN")) then
		local base = bomberDemand > 0 and bomberDemand or 1.5
		ResearchDemandSet(FSFC_ResolveID("BOMBERDESIGN"), base + 1.1)
		FSFC_Log_Research("BomberDesign", base + 1.1)
	else
		FSFC_Log_Completed("BOMBERDESIGN", "BomberDesign")
	end
	if (FSFC_CheckResearch("CRUISERDESIGN")) then
		local base = frigateDemand > 0 and frigateDemand or 1.5
		ResearchDemandSet(FSFC_ResolveID("CRUISERDESIGN"), base + 1.1)
		FSFC_Log_Research("CruiserDesign", base + 1.1)
	end
	if (FSFC_CheckResearch("CAPITALSHIPDESIGN")) then
		local base = capitalDemand > 0 and capitalDemand or 1.5
		ResearchDemandSet(FSFC_ResolveID("CAPITALSHIPDESIGN"), base + 1.1)
		FSFC_Log_Research("CapShipDesign", base + 1.1)
	end

	-- Iterate tech table
	local m = getn(rt_shivan_tech)
	for i=1, m do
		local item = rt_shivan_tech[i]
		local baseDemand = 0
		if (item.class == eFrigate) then baseDemand = frigateDemand
		elseif (item.class == eCapital) then baseDemand = capitalDemand end
		
		if (baseDemand <= 0) then
			-- Baseline fallback to prevent starting flagship deadlock
			if ((item.id == "LUCIFER" or item.id == "SUPERCAPITALSHIPDESIGN") and FSFC_IsResearchDone("CapitalShipDesign") == 1) then
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
	FSFC_ProcessResearchTable(rt_shivan_utility, 1.0)

	-- Write research snapshot after accumulator is fully populated this cycle
	FSFC_WriteResearchSnapshot()
end

function DoUpgradeDemand_Shivan()
	local numCollectors = NumSquadrons_Shivan(kCollector)
	if (numCollectors > 0 and COLLECTORHP ~= nil and FSFC_CheckResearch(COLLECTORHP)) then
		ResearchDemandAdd_Shivan(COLLECTORHP, numCollectors * .1)
	end
	local numRefinery = NumSquadrons_Shivan(kRefinery)
	if (numRefinery > 0 and DROPOFFHP ~= nil and FSFC_CheckResearch(DROPOFFHP)) then
		ResearchDemandAdd_Shivan(DROPOFFHP, numRefinery * .1)
	end

	-- (snapshot moved to end of DoResearchTechDemand_Shivan)
end

DoUpgradeDemand = DoUpgradeDemand_Shivan
DoResearchTechDemand = DoResearchTechDemand_Shivan
