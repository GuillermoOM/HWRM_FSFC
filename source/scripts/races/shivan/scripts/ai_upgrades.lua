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
if (FS2 == nil) then FS2 = -1 end

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

function DoResearchTechDemand_Shivan()
	local fighterdemand = ShipDemandMaxByClass(eFighter) * 2
	if (fighterdemand > 0) then
		print("[AI_DIAG] P" .. s_playerIndex .. " | WANT | FighterClass | Demand: " .. fighterdemand)
		if (FSFC_CheckResearch(FIGHTERDESIGN)) then
			ResearchDemandSet_Shivan(FIGHTERDESIGN, fighterdemand + 1.1)
			FSFC_Log_Research("FighterDesign", fighterdemand + 1.1)
		end
		-- Era-aware parallel research
		if (FSFC_CheckResearch(MANTICORE)) then
			ResearchDemandSet_Shivan(MANTICORE, fighterdemand + 1.0)
			FSFC_Log_Research("Manticore", fighterdemand + 1.0)
		end
		if (FSFC_CheckResearch(DRAGON)) then
			ResearchDemandSet_Shivan(DRAGON, fighterdemand + 1.2)
			FSFC_Log_Research("Dragon", fighterdemand + 1.2)
		end
		if (FSFC_CheckResearch(BASILISK)) then
			ResearchDemandSet_Shivan(BASILISK, fighterdemand + 1.3)
			FSFC_Log_Research("Basilisk", fighterdemand + 1.3)
		end
		if (FSFC_CheckResearch(AESHMA)) then
			ResearchDemandSet_Shivan(AESHMA, fighterdemand + 1.4)
			FSFC_Log_Research("Aeshma", fighterdemand + 1.4)
		end
		if (FSFC_CheckResearch(MARA)) then
			ResearchDemandSet_Shivan(MARA, fighterdemand + 1.5)
			FSFC_Log_Research("Mara", fighterdemand + 1.5)
		end
		if (FSFC_CheckResearch(GORGON)) then
			ResearchDemandSet_Shivan(GORGON, fighterdemand + 1.6)
			FSFC_Log_Research("Gorgon", fighterdemand + 1.6)
		end
		-- Recon Doctrine: Scouts
		if (FSFC_CheckResearch(ASTAROTH)) then
			ResearchDemandSet_Shivan(ASTAROTH, fighterdemand + 1.0)
			FSFC_Log_Research("Astaroth", fighterdemand + 1.0)
		end
	end

	local bomberdemand = ShipDemandMaxByClass(eCorvette) * 2
	if (bomberdemand > 0) then
		if (FSFC_CheckResearch(BOMBERDESIGN)) then
			ResearchDemandSet_Shivan(BOMBERDESIGN, bomberdemand + 1.1)
			FSFC_Log_Research("BomberDesign", bomberdemand + 1.1)
		end
		-- Era-aware parallel research
		if (FSFC_CheckResearch(SHAITAN)) then
			ResearchDemandSet_Shivan(SHAITAN, bomberdemand + 1.0)
			FSFC_Log_Research("Shaitan", bomberdemand + 1.0)
		end
		if (FSFC_CheckResearch(TAURVI)) then
			ResearchDemandSet_Shivan(TAURVI, bomberdemand + 1.2)
			FSFC_Log_Research("Taurvi", bomberdemand + 1.2)
		end
		if (FSFC_CheckResearch(NAHEMA)) then
			ResearchDemandSet_Shivan(NAHEMA, bomberdemand + 1.5)
			FSFC_Log_Research("Nahema", bomberdemand + 1.5)
		end
		if (FSFC_CheckResearch(NEPHILIM)) then
			ResearchDemandSet_Shivan(NEPHILIM, bomberdemand + 1.0)
			FSFC_Log_Research("Nephilim", bomberdemand + 1.0)
		end
		if (FSFC_CheckResearch(SERAPHIM)) then
			ResearchDemandSet_Shivan(SERAPHIM, bomberdemand + 1.5)
			FSFC_Log_Research("Seraphim", bomberdemand + 1.5)
		end
	end

	local cruiserdemand = ShipDemandMaxByClass(eFrigate) * 2
	if (cruiserdemand > 0) then
		if (FSFC_CheckResearch(CRUISERDESIGN)) then
			ResearchDemandSet_Shivan(CRUISERDESIGN, cruiserdemand + 1.1)
			FSFC_Log_Research("CruiserDesign", cruiserdemand + 1.1)
		end
		if (FSFC_CheckResearch(CAIN)) then
			ResearchDemandSet_Shivan(CAIN, cruiserdemand + 1.0)
			FSFC_Log_Research("Cain", cruiserdemand + 1.0)
		end
		if (FSFC_CheckResearch(LILITH)) then
			ResearchDemandSet_Shivan(LILITH, cruiserdemand + 1.0)
			FSFC_Log_Research("Lilith", cruiserdemand + 1.0)
		end
		if (FSFC_CheckResearch(RAKSHASA)) then
			ResearchDemandSet_Shivan(RAKSHASA, cruiserdemand + 1.0)
			FSFC_Log_Research("Rakshasa", cruiserdemand + 1.0)
		end
	end

	local capitaldemand = ShipDemandMaxByClass(eCapital) * 2.5
	if (capitaldemand > 0) then
		if (FSFC_CheckResearch(CAPITALSHIPDESIGN)) then
			ResearchDemandSet_Shivan(CAPITALSHIPDESIGN, capitaldemand + 1.1)
			FSFC_Log_Research("CapitalShipDesign", capitaldemand + 1.1)
		end
		if (FSFC_CheckResearch(MOLOCH)) then
			ResearchDemandSet_Shivan(MOLOCH, capitaldemand + 1.0)
			FSFC_Log_Research("Moloch", capitaldemand + 1.0)
		end
		if (FSFC_CheckResearch(COMMNODE)) then
			ResearchDemandSet_Shivan(COMMNODE, capitaldemand + 0.5)
			FSFC_Log_Research("CommNode", capitaldemand + 0.5)
		end
		if (FSFC_CheckResearch(DEMON)) then
			ResearchDemandSet_Shivan(DEMON, capitaldemand + 1.0)
			FSFC_Log_Research("Demon", capitaldemand + 1.0)
		end
		if (FSFC_CheckResearch(SUPERCAPITALSHIPDESIGN)) then
			ResearchDemandSet_Shivan(SUPERCAPITALSHIPDESIGN, capitaldemand + 1.0)
			FSFC_Log_Research("SuperCapitalDesign", capitaldemand + 1.0)
		end
		if (FSFC_CheckResearch(LUCIFER)) then
			ResearchDemandSet_Shivan(LUCIFER, capitaldemand + 1.0)
			FSFC_Log_Research("Lucifer", capitaldemand + 1.0)
		end
		if (FSFC_CheckResearch(SATHANAS)) then
			ResearchDemandSet_Shivan(SATHANAS, capitaldemand + 1.0)
			FSFC_Log_Research("Sathanas", capitaldemand + 1.0)
		end
	end

	-- Utility
	if (FSFC_CheckResearch(SCORPION)) then
		ResearchDemandSet_Shivan(SCORPION, 0.5)
		FSFC_Log_Research("Scorpion", 0.5)
	end
	if (FSFC_CheckResearch(MEPHISTO)) then
		ResearchDemandSet_Shivan(MEPHISTO, 0.5)
		FSFC_Log_Research("Mephisto", 0.5)
	end
end

function DoUpgradeDemand_Shivan()
	local numCollectors = NumSquadrons(kCollector)
	if (numCollectors > 0 and COLLECTORHP ~= nil and FSFC_CheckResearch(COLLECTORHP)) then
		ResearchDemandAdd_Shivan(COLLECTORHP, numCollectors * .1)
	end
	local numRefinery = NumSquadrons(kRefinery)
	if (numRefinery > 0 and DROPOFFHP ~= nil and FSFC_CheckResearch(DROPOFFHP)) then
		ResearchDemandAdd_Shivan(DROPOFFHP, numRefinery * .1)
	end
end

DoUpgradeDemand = DoUpgradeDemand_Shivan
DoResearchTechDemand = DoResearchTechDemand_Shivan
