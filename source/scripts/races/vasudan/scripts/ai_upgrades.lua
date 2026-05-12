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

function DoResearchTechDemand_Vasudan()
	local fighterdemand = ShipDemandMaxByClass( eFighter ) * 2
	if (fighterdemand > 0) then
		if (Util_CheckResearch(FIGHTERDESIGN)) then
			ResearchDemandSet(FIGHTERDESIGN, fighterdemand + 1.0)
		end
		if (Util_CheckResearch(HORUS)) then
			ResearchDemandSet(HORUS, fighterdemand + 1.0)
			FSFC_Log_Research("Horus")
		end
		if (Util_CheckResearch(SETH)) then
			ResearchDemandSet(SETH, fighterdemand + 1.0)
			FSFC_Log_Research("Seth")
		end
		if (Util_CheckResearch(THOTH)) then
			ResearchDemandSet(THOTH, fighterdemand + 1.0)
			FSFC_Log_Research("Thoth")
		end
		if (Util_CheckResearch(PTAH)) then
			ResearchDemandSet(PTAH, fighterdemand + 1.0)
		end
		if (Util_CheckResearch(SERAPIS)) then
			ResearchDemandSet(SERAPIS, fighterdemand + 1.0)
		end
		if (Util_CheckResearch(TAURET)) then
			ResearchDemandSet(TAURET, fighterdemand + 1.0)
			FSFC_Log_Research("Tauret")
		end
	end

	local bomberdemand = ShipDemandMaxByClass( eCorvette ) * 2
	if (bomberdemand > 0) then
		if (Util_CheckResearch(BOMBERDESIGN)) then
			ResearchDemandSet(BOMBERDESIGN, bomberdemand + 1.0)
		end
		if (Util_CheckResearch(OSIRIS)) then
			ResearchDemandSet(OSIRIS, bomberdemand + 1.0)
			FSFC_Log_Research("Osiris")
		end
		if (Util_CheckResearch(BAKHA)) then
			ResearchDemandSet(BAKHA, bomberdemand + 1.0)
		end
		if (Util_CheckResearch(SEHKMET)) then
			ResearchDemandSet(SEHKMET, bomberdemand + 1.0)
			FSFC_Log_Research("Sehkmet")
		end
	end

	local cruiserdemand = ShipDemandMaxByClass( eFrigate ) * 2
	if (cruiserdemand > 0) then
		if (Util_CheckResearch(CRUISERDESIGN)) then
			ResearchDemandSet(CRUISERDESIGN, cruiserdemand + 1.0)
		end
		if (Util_CheckResearch(ATEN)) then
			ResearchDemandSet(ATEN, cruiserdemand + 1.0)
			FSFC_Log_Research("Aten")
		end
		if (Util_CheckResearch(MENTU)) then
			ResearchDemandSet(MENTU, cruiserdemand + 1.0)
		end
		if (Util_CheckResearch(SCIENCEVESSEL)) then
			ResearchDemandSet(SCIENCEVESSEL, cruiserdemand + 0.5)
		end
		if (Util_CheckResearch(AWACS)) then
			local scoutdemand = ShipDemandGet( eScout )
			if (scoutdemand > 0) then
				ResearchDemandSet(AWACS, cruiserdemand + scoutdemand)
			end
		end
	end

	local capitaldemand = ShipDemandMaxByClass( eCapital )
	if (capitaldemand > 0) then
		if (Util_CheckResearch(CAPITALSHIPDESIGN)) then
			ResearchDemandSet(CAPITALSHIPDESIGN, capitaldemand + 1.0)
		end
		if (Util_CheckResearch(TYPHON)) then
			ResearchDemandSet(TYPHON, capitaldemand + 1.0)
			FSFC_Log_Research("Typhon")
		end
		if (Util_CheckResearch(SOBEK)) then
			ResearchDemandSet(SOBEK, capitaldemand + 1.0)
			FSFC_Log_Research("Sobek")
		end
		if (Util_CheckResearch(INSTALLATION)) then
			ResearchDemandSet(INSTALLATION, capitaldemand + 0.5)
		end
		if (Util_CheckResearch(HATSHEPSUT)) then
			ResearchDemandSet(HATSHEPSUT, capitaldemand + 1.0)
			FSFC_Log_Research("Hatshepsut")
		end
		if (Util_CheckResearch(SUPERCAPITALSHIPDESIGN)) then
			ResearchDemandSet(SUPERCAPITALSHIPDESIGN, capitaldemand + 1.0)
		end
		if (Util_CheckResearch(COLOSSUS)) then
			ResearchDemandSet(COLOSSUS, capitaldemand + 1.0)
			FSFC_Log_Research("Colossus")
		end
	end

	-- Utility
	if (Util_CheckResearch(SENTRYGUN)) then
		ResearchDemandSet(SENTRYGUN, 0.5)
	end
	if (Util_CheckResearch(SENTRYANDMINEDEPLOYER)) then
		ResearchDemandSet(SENTRYANDMINEDEPLOYER, 0.5)
	end
	if (Util_CheckResearch(REPAIRSATIS)) then
		ResearchDemandSet(REPAIRSATIS, 0.5)
	end
	if (Util_CheckResearch(REPAIRBAST)) then
		ResearchDemandSet(REPAIRBAST, 0.5)
	end
end

function DoUpgradeDemand_Vasudan()
	if (s_militaryStrength > 10 or g_LOD == 0) then
		local numCollectors = NumSquadrons( kCollector )
		if (numCollectors > 0 and COLLECTORHP ~= nil and Util_CheckResearch(COLLECTORHP)) then
			ResearchDemandAdd(COLLECTORHP, numCollectors*.1)
		end
		local numRefinery = NumSquadrons( kRefinery )
		if (numRefinery > 0 and DROPOFFHP ~= nil and Util_CheckResearch(DROPOFFHP)) then
			ResearchDemandAdd(DROPOFFHP, numRefinery*.1)
		end
	end
	local numDestroyers = NumSquadrons( kDestroyer )
	if (numDestroyers > 0) then
		if (Util_CheckResearch(SOBEKARMOR)) then
			ResearchDemandAdd(SOBEKARMOR, numDestroyers*2)
		end
		if (Util_CheckResearch(SOBEKSPRINT)) then
			ResearchDemandAdd(SOBEKSPRINT, numDestroyers*1.5)
		end
	end
end

DoUpgradeDemand = DoUpgradeDemand_Vasudan
DoResearchTechDemand = DoResearchTechDemand_Vasudan
