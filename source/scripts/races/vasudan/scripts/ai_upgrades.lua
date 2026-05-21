dofilepath("data:scripts/custom_scripts/ai_telemetry.lua")
aitrace("LOADING VASUDAN UPGRADE INFO")

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
if (VAS_HATSHEPSUT_FS1 == nil) then VAS_HATSHEPSUT_FS1 = -1 end
if (HATSHEPSUT_FS1 == nil) then HATSHEPSUT_FS1 = -1 end
if (CPUPLAYERS_AGGRESSIVE == nil) then CPUPLAYERS_AGGRESSIVE = getglobal("cpuplayers_aggressive") or -1 end
if (CPUPLAYERS_DYNAMIC == nil) then CPUPLAYERS_DYNAMIC = getglobal("cpuplayers_dynamic") or -1 end
if (CPUPLAYERS_DEFENSIVE == nil) then CPUPLAYERS_DEFENSIVE = getglobal("cpuplayers_defensive") or -1 end

function NumSquadrons_Vasudan(id)
	return FSFC_NumSquadrons(id)
end

function ResearchDemandSet_Vasudan(id_or_name, demand)
	local id = FSFC_ResolveID(id_or_name)
	if (id) then
		ResearchDemandSet(id, demand)
	end
end

function ResearchDemandAdd_Vasudan(id_or_name, demand)
	local id = FSFC_ResolveID(id_or_name)
	if (id) then
		ResearchDemandAdd(id, demand)
	end
end

-- 1. ERA INDEPENDENT TECH
rt_vasudan_core = {
	{ id = "FS1", priority = 4.0, name = "FS1" },
	{ id = "FS2", priority = 4.0, name = "FS2" },
	{ id = "TacticsDynamic", priority = 3.0, name = "TacticsDynamic" },
}

-- 2. FS1 ERA SHIP UNLOCKS
rt_vasudan_fs1 = {
	-- Fighters
	{ id = "HORUS", priority = 1.0, name = "Horus", class = eFighter, shipID = VAS_HORUS },
	{ id = "SETH", priority = 1.1, name = "Seth", class = eFighter, shipID = VAS_SETH },
	{ id = "THOTH", priority = 1.2, name = "Thoth", class = eFighter, shipID = VAS_THOTH },
	-- Bombers
	{ id = "OSIRIS", priority = 1.0, name = "Osiris", class = eCorvette, shipID = VAS_OSIRIS },
	{ id = "Amun", priority = 1.3, name = "Amun", class = eCorvette, shipID = VAS_AMUN },
}

-- 3. FS2 ERA SHIP UNLOCKS
rt_vasudan_fs2 = {
	-- Fighters
	{ id = "PTAH", priority = 1.0, name = "Ptah", class = eFighter, shipID = VAS_PTAH },
	{ id = "SERAPIS", priority = 1.3, name = "Serapis", class = eFighter, shipID = VAS_SERAPIS },
	{ id = "TAURET", priority = 1.5, name = "Tauret", class = eFighter, shipID = VAS_TAURET },
	-- Bombers
	{ id = "BAKHA", priority = 1.2, name = "Bakha", class = eCorvette, shipID = VAS_BAKHA },
	{ id = "SEHKMET", priority = 1.5, name = "Sehkmet", class = eCorvette, shipID = VAS_SEHKMET },
}

-- 4. CAPITAL/CRUISER TECH (Class-shared)
rt_vasudan_tech = {
	{ id = "CRUISERDESIGN", priority = 1.1, name = "CruiserDesign", class = eFrigate },
	{ id = "ATEN", priority = 1.0, name = "Aten", class = eFrigate, shipID = VAS_ATEN },
	{ id = "MENTU", priority = 1.0, name = "Mentu", class = eFrigate, shipID = VAS_MENTU },
	{ id = "SOBEK", priority = 1.0, name = "Sobek", class = eFrigate, shipID = VAS_SOBEK },
	
	{ id = "CAPITALSHIPDESIGN", priority = 1.1, name = "CapitalShipDesign", class = eCapital },
	{ id = "TYPHON", priority = 1.0, name = "Typhon", class = eCapital, shipID = VAS_TYPHON },
	{ id = "INSTALLATION", priority = 0.5, name = "Installation", class = eCapital },
	{ id = "HATSHEPSUT", priority = 1.0, name = "Hatshepsut", class = eCapital, shipID = VAS_HATSHEPSUT },
	{ id = "HATSHEPSUT_FS1", priority = 1.0, name = "Hatshepsut_FS1", class = eCapital, shipID = VAS_HATSHEPSUT_FS1 },
	{ id = "SUPERCAPITALSHIPDESIGN", priority = 1.0, name = "SuperCapitalDesign", class = eCapital },
	{ id = "COLOSSUS", priority = 1.0, name = "Colossus", class = eCapital, shipID = VAS_COLOSSUS },
}

-- 5. UTILITY/SPECIAL
rt_vasudan_utility = {
	{ id = "SENTRYGUN", priority = 0.5, name = "SentryGun" },
	{ id = "SENTRYANDMINEDEPLOYER", priority = 0.5, name = "SentryAndMineDeployer" },
	{ id = "BEAMSENTRY", priority = 0.5, name = "BeamSentry", shipID = TER_MJOLNIR },
	{ id = "REPAIRSATIS", priority = 0.5, name = "RepairSatis", shipID = VAS_SATIS },
	{ id = "REPAIRBAST", priority = 0.5, name = "RepairBast", shipID = VAS_BAST },
	{ id = "SCIENCEVESSEL", priority = 0.5, name = "ScienceVessel", shipID = VAS_IMHOTEP },
	{ id = "AWACS", priority = 0.5, name = "AWACS", shipID = VAS_SETEKH },
}

function DoResearchTechDemand_Vasudan()
	-- A. Core Demand (Eras and Tactics)
	FSFC_ProcessResearchTable(rt_vasudan_core, 1.0)

	-- B. Era-Specific Ship Demand
	local fighterDemand = ShipDemandMaxByClass(eFighter) * 2
	local bomberDemand = ShipDemandMaxByClass(eCorvette) * 2
	
	local tbl_ships = rt_vasudan_fs1
	if (FSFC_IsResearchDone("FS2") == 1) then
		tbl_ships = rt_vasudan_fs2
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
	local m = getn(rt_vasudan_tech)
	for i=1, m do
		local item = rt_vasudan_tech[i]
		local baseDemand = 0
		if (item.class == eFrigate) then baseDemand = frigateDemand
		elseif (item.class == eCapital) then baseDemand = capitalDemand end
		
		if (baseDemand <= 0) then
			-- Baseline fallback to prevent starting flagship deadlock
			if ((item.id == "HATSHEPSUT" or item.id == "HATSHEPSUT_FS1" or item.id == "SUPERCAPITALSHIPDESIGN") and FSFC_IsResearchDone("CapitalShipDesign") == 1) then
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
	FSFC_ProcessResearchTable(rt_vasudan_utility, 1.0)

	-- Write research snapshot after accumulator is fully populated this cycle
	FSFC_WriteResearchSnapshot()
end

function DoUpgradeDemand_Vasudan()
	if (s_militaryStrength > 10 or g_LOD == 0) then
		local numCollectors = NumSquadrons_Vasudan(kCollector)
		if (numCollectors > 0 and COLLECTORHP ~= nil and FSFC_CheckResearch(COLLECTORHP)) then
			ResearchDemandAdd_Vasudan(COLLECTORHP, numCollectors * .1)
		end
		local numRefinery = NumSquadrons_Vasudan(kRefinery)
		if (numRefinery > 0 and DROPOFFHP ~= nil and FSFC_CheckResearch(DROPOFFHP)) then
			ResearchDemandAdd_Vasudan(DROPOFFHP, numRefinery * .1)
		end
	end
	local numDestroyers = NumSquadrons_Vasudan(kDestroyer)
	if (numDestroyers > 0) then
		if (FSFC_CheckResearch(SOBEKARMOR)) then
			ResearchDemandAdd_Vasudan(SOBEKARMOR, numDestroyers * 2)
			FSFC_Log_Research("SobekArmor", numDestroyers * 2)
		end
		if (FSFC_CheckResearch(SOBEKSPRINT)) then
			ResearchDemandAdd_Vasudan(SOBEKSPRINT, numDestroyers * 1.5)
			FSFC_Log_Research("SobekSprint", numDestroyers * 1.5)
		end
	end

	-- (snapshot moved to end of DoResearchTechDemand_Vasudan)
end

DoUpgradeDemand = DoUpgradeDemand_Vasudan
DoResearchTechDemand = DoResearchTechDemand_Vasudan
