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
if (CPUPLAYERS_AGGRESSIVE == nil) then CPUPLAYERS_AGGRESSIVE = -1 end
if (CPUPLAYERS_DYNAMIC == nil) then CPUPLAYERS_DYNAMIC = -1 end
if (CPUPLAYERS_DEFENSIVE == nil) then CPUPLAYERS_DEFENSIVE = -1 end

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

function DoResearchTechDemand_Vasudan()
	-- 1. ERA SELECTION
	local eraDemand = 4.0
	if (FSFC_CheckResearch(FS1)) then
		ResearchDemandSet_Vasudan(FS1, eraDemand)
		FSFC_Log_Research("FS1", eraDemand)
	end
	if (FSFC_CheckResearch(FS2)) then
		ResearchDemandSet_Vasudan(FS2, eraDemand)
		FSFC_Log_Research("FS2", eraDemand)
	end

	-- 2. TACTICS
	if (FSFC_CheckResearch(CPUPLAYERS_DYNAMIC)) then
		ResearchDemandSet_Vasudan(CPUPLAYERS_DYNAMIC, 3.0)
		FSFC_Log_Research("TacticsDynamic", 3.0)
	end

	local fighterdemand = ShipDemandMaxByClass(eFighter) * 2
	if (fighterdemand > 0) then
		print("[AI_DIAG] P" .. s_playerIndex .. " | WANT | FighterClass | Demand: " .. fighterdemand)
		if (FSFC_CheckResearch(FIGHTERDESIGN)) then
			ResearchDemandSet_Vasudan(FIGHTERDESIGN, fighterdemand + 1.1)
			FSFC_Log_Research("FighterDesign", fighterdemand + 1.1)
		end
		-- Era-aware parallel research
		if (FSFC_CheckResearch(HORUS)) then
			ResearchDemandSet_Vasudan(HORUS, fighterdemand + 1.0)
			FSFC_Log_Research("Horus", fighterdemand + 1.0)
		end
		if (FSFC_CheckResearch(SETH)) then
			ResearchDemandSet_Vasudan(SETH, fighterdemand + 1.1)
			FSFC_Log_Research("Seth", fighterdemand + 1.1)
		end
		if (FSFC_CheckResearch(THOTH)) then
			ResearchDemandSet_Vasudan(THOTH, fighterdemand + 1.2)
			FSFC_Log_Research("Thoth", fighterdemand + 1.2)
		end
		if (FSFC_CheckResearch(PTAH)) then
			ResearchDemandSet_Vasudan(PTAH, fighterdemand + 1.0)
			FSFC_Log_Research("Ptah", fighterdemand + 1.0)
		end
		if (FSFC_CheckResearch(SERAPIS)) then
			ResearchDemandSet_Vasudan(SERAPIS, fighterdemand + 1.3)
			FSFC_Log_Research("Serapis", fighterdemand + 1.3)
		end
		if (FSFC_CheckResearch(TAURET)) then
			ResearchDemandSet_Vasudan(TAURET, fighterdemand + 1.5)
			FSFC_Log_Research("Tauret", fighterdemand + 1.5)
		end

		-- Recon Doctrine: Scouts
		if (FSFC_CheckResearch(HORUS)) then
			ResearchDemandSet_Vasudan(HORUS, fighterdemand + 2.0)
			FSFC_Log_Research("Horus", fighterdemand + 2.0)
		end
		if (FSFC_CheckResearch(PTAH)) then
			ResearchDemandSet_Vasudan(PTAH, fighterdemand + 2.0)
			FSFC_Log_Research("Ptah", fighterdemand + 2.0)
		end
	end

	local bomberdemand = ShipDemandMaxByClass(eCorvette) * 2
	if (bomberdemand > 0) then
		if (FSFC_CheckResearch(BOMBERDESIGN)) then
			ResearchDemandSet_Vasudan(BOMBERDESIGN, bomberdemand + 1.1)
			FSFC_Log_Research("BomberDesign", bomberdemand + 1.1)
		end
		-- Era-aware parallel research
		if (FSFC_CheckResearch(OSIRIS)) then
			ResearchDemandSet_Vasudan(OSIRIS, bomberdemand + 1.0)
			FSFC_Log_Research("Osiris", bomberdemand + 1.0)
		end
		if (FSFC_CheckResearch(BAKHA)) then
			ResearchDemandSet_Vasudan(BAKHA, bomberdemand + 1.2)
			FSFC_Log_Research("Bakha", bomberdemand + 1.2)
		end
		if (FSFC_CheckResearch(SEHKMET)) then
			ResearchDemandSet_Vasudan(SEHKMET, bomberdemand + 1.5)
			FSFC_Log_Research("Sehkmet", bomberdemand + 1.5)
		end
		-- Amun is often an upgrade or variant, ensure it's prioritized if available
		if (FSFC_CheckResearch("Amun")) then
			ResearchDemandSet_Vasudan("Amun", bomberdemand + 1.3)
		end
	end

	local cruiserdemand = ShipDemandMaxByClass(eFrigate) * 2
	if (cruiserdemand > 0) then
		if (FSFC_CheckResearch(CRUISERDESIGN)) then
			ResearchDemandSet_Vasudan(CRUISERDESIGN, cruiserdemand + 1.1)
			FSFC_Log_Research("CruiserDesign", cruiserdemand + 1.1)
		end
		if (FSFC_CheckResearch(ATEN)) then
			ResearchDemandSet_Vasudan(ATEN, cruiserdemand + 1.0)
			FSFC_Log_Research("Aten", cruiserdemand + 1.0)
		end
		if (FSFC_CheckResearch(MENTU)) then
			ResearchDemandSet_Vasudan(MENTU, cruiserdemand + 1.0)
			FSFC_Log_Research("Mentu", cruiserdemand + 1.0)
		end
		if (FSFC_CheckResearch(SOBEK)) then
			ResearchDemandSet_Vasudan(SOBEK, cruiserdemand + 1.0)
			FSFC_Log_Research("Sobek", cruiserdemand + 1.0)
		end
	end

	local capitaldemand = ShipDemandMaxByClass(eCapital) * 2.5
	-- Research Trap Prevention: Throttle demand if we already have the base capital tech
	if (FSFC_IsResearchDone(CAPITALSHIPDESIGN) == 1) then
		capitaldemand = capitaldemand * 0.5
	end
	if (capitaldemand > 0) then
		if (FSFC_CheckResearch(CAPITALSHIPDESIGN)) then
			ResearchDemandSet_Vasudan(CAPITALSHIPDESIGN, capitaldemand + 1.1)
			FSFC_Log_Research("CapitalShipDesign", capitaldemand + 1.1)
		end
		if (FSFC_CheckResearch(TYPHON)) then
			ResearchDemandSet_Vasudan(TYPHON, capitaldemand + 1.0)
			FSFC_Log_Research("Typhon", capitaldemand + 1.0)
		end
		if (FSFC_CheckResearch(INSTALLATION)) then
			ResearchDemandSet_Vasudan(INSTALLATION, capitaldemand + 0.5)
			FSFC_Log_Research("Installation", capitaldemand + 0.5)
		end
		if (FSFC_CheckResearch(HATSHEPSUT)) then
			ResearchDemandSet_Vasudan(HATSHEPSUT, capitaldemand + 1.0)
			FSFC_Log_Research("Hatshepsut", capitaldemand + 1.0)
		end
		if (FSFC_CheckResearch(SUPERCAPITALSHIPDESIGN)) then
			ResearchDemandSet_Vasudan(SUPERCAPITALSHIPDESIGN, capitaldemand + 1.0)
			FSFC_Log_Research("SuperCapitalDesign", capitaldemand + 1.0)
		end
		if (FSFC_CheckResearch(COLOSSUS)) then
			ResearchDemandSet_Vasudan(COLOSSUS, capitaldemand + 1.0)
			FSFC_Log_Research("Colossus", capitaldemand + 1.0)
		end
	end

	-- Utility
	-- Utility
	if (FSFC_CheckResearch(SENTRYGUN)) then
		ResearchDemandSet_Vasudan(SENTRYGUN, 0.5)
		FSFC_Log_Research("SentryGun", 0.5)
	end
	if (FSFC_CheckResearch(SENTRYANDMINEDEPLOYER)) then
		ResearchDemandSet_Vasudan(SENTRYANDMINEDEPLOYER, 0.5)
		FSFC_Log_Research("SentryAndMineDeployer", 0.5)
	end
	if (FSFC_CheckResearch(REPAIRSATIS)) then
		ResearchDemandSet_Vasudan(REPAIRSATIS, 0.5)
		FSFC_Log_Research("RepairSatis", 0.5)
	end
	if (FSFC_CheckResearch(REPAIRBAST)) then
		ResearchDemandSet_Vasudan(REPAIRBAST, 0.5)
		FSFC_Log_Research("RepairBast", 0.5)
	end
end

function DoUpgradeDemand_Vasudan()
	if (s_militaryStrength > 10 or g_LOD == 0) then
		local numCollectors = NumSquadrons(kCollector)
		if (numCollectors > 0 and COLLECTORHP ~= nil and FSFC_CheckResearch(COLLECTORHP)) then
			ResearchDemandAdd_Vasudan(COLLECTORHP, numCollectors * .1)
		end
		local numRefinery = NumSquadrons(kRefinery)
		if (numRefinery > 0 and DROPOFFHP ~= nil and FSFC_CheckResearch(DROPOFFHP)) then
			ResearchDemandAdd_Vasudan(DROPOFFHP, numRefinery * .1)
		end
	end
	local numDestroyers = NumSquadrons(kDestroyer)
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
end

DoUpgradeDemand = DoUpgradeDemand_Vasudan
DoResearchTechDemand = DoResearchTechDemand_Vasudan
