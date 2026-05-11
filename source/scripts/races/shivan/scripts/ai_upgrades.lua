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

function DoResearchTechDemand_Shivan()
	local fighterdemand = ShipDemandMaxByClass(eFighter) * 2
	if (fighterdemand > 0) then
		if (Util_CheckResearch(FIGHTERDESIGN)) then
			ResearchDemandSet(FIGHTERDESIGN, fighterdemand + 1.0)
		end
		if (Util_CheckResearch(MANTICORE)) then
			ResearchDemandSet(MANTICORE, fighterdemand + 1.0)
		end
		if (Util_CheckResearch(ASTAROTH)) then
			ResearchDemandSet(ASTAROTH, fighterdemand + 1.0)
		end
		if (Util_CheckResearch(DRAGON)) then
			ResearchDemandSet(DRAGON, fighterdemand + 1.0)
		end
		if (Util_CheckResearch(BASILISK)) then
			ResearchDemandSet(BASILISK, fighterdemand + 1.0)
		end
		if (Util_CheckResearch(AESHMA)) then
			ResearchDemandSet(AESHMA, fighterdemand + 1.0)
		end
		if (Util_CheckResearch(MARA)) then
			ResearchDemandSet(MARA, fighterdemand + 1.0)
		end
		if (Util_CheckResearch(GORGON)) then
			ResearchDemandSet(GORGON, fighterdemand + 1.0)
		end
	end

	local bomberdemand = ShipDemandMaxByClass(eCorvette) * 2
	if (bomberdemand > 0) then
		if (Util_CheckResearch(BOMBERDESIGN)) then
			ResearchDemandSet(BOMBERDESIGN, bomberdemand + 1.0)
		end
		if (Util_CheckResearch(SHAITAN)) then
			ResearchDemandSet(SHAITAN, bomberdemand + 1.0)
		end
		if (Util_CheckResearch(NAHEMA)) then
			ResearchDemandSet(NAHEMA, bomberdemand + 1.0)
		end
		if (Util_CheckResearch(TAURVI)) then
			ResearchDemandSet(TAURVI, bomberdemand + 1.0)
		end
		if (Util_CheckResearch(NEPHILIM)) then
			ResearchDemandSet(NEPHILIM, bomberdemand + 1.0)
		end
		if (Util_CheckResearch(SERAPHIM)) then
			ResearchDemandSet(SERAPHIM, bomberdemand + 1.0)
		end
	end

	local cruiserdemand = ShipDemandMaxByClass(eFrigate) * 2
	if (cruiserdemand > 0) then
		if (Util_CheckResearch(CRUISERDESIGN)) then
			ResearchDemandSet(CRUISERDESIGN, cruiserdemand + 1.0)
		end
		if (Util_CheckResearch(CAIN)) then
			ResearchDemandSet(CAIN, cruiserdemand + 1.0)
		end
		if (Util_CheckResearch(RAKSHASA)) then
			ResearchDemandSet(RAKSHASA, cruiserdemand + 1.0)
		end
		if (Util_CheckResearch(LILITH)) then
			ResearchDemandSet(LILITH, cruiserdemand + 1.0)
		end
	end

	local capitaldemand = ShipDemandMaxByClass(eCapital)
	if (capitaldemand > 0) then
		if (Util_CheckResearch(CAPITALSHIPDESIGN)) then
			ResearchDemandSet(CAPITALSHIPDESIGN, capitaldemand + 1.0)
		end
		if (Util_CheckResearch(MOLOCH)) then
			ResearchDemandSet(MOLOCH, capitaldemand + 1.0)
		end
		if (Util_CheckResearch(DEMON)) then
			ResearchDemandSet(DEMON, capitaldemand + 1.0)
		end
		if (Util_CheckResearch(RAVANA)) then
			ResearchDemandSet(RAVANA, capitaldemand + 1.0)
		end
		if (Util_CheckResearch(LUCIFER)) then
			ResearchDemandSet(LUCIFER, capitaldemand + 2.0)
		end
		if (Util_CheckResearch(SUPERCAPITALSHIPDESIGN)) then
			ResearchDemandSet(SUPERCAPITALSHIPDESIGN, capitaldemand + 3.0)
		end
		if (Util_CheckResearch(SATHANAS)) then
			ResearchDemandSet(SATHANAS, capitaldemand + 5.0)
		end
	end

	-- Utility
	if (Util_CheckResearch(SENTRYGUN)) then
		ResearchDemandSet(SENTRYGUN, 0.5)
	end
	if (Util_CheckResearch(ADVANCEDSENSORS)) then
		ResearchDemandSet(ADVANCEDSENSORS, 0.5)
	end
end

function DoUpgradeDemand_Shivan()
	local numDestroyers = NumSquadrons(SHI_MOLOCH)
	if (numDestroyers > 0) then
		if (Util_CheckResearch(MOLOCHARMOR)) then
			ResearchDemandAdd(MOLOCHARMOR, numDestroyers * 2)
		end
		if (Util_CheckResearch(MOLOCHSPRINT)) then
			ResearchDemandAdd(MOLOCHSPRINT, numDestroyers * 1.5)
		end
	end
end

DoUpgradeDemand = DoUpgradeDemand_Shivan
DoResearchTechDemand = DoResearchTechDemand_Shivan
