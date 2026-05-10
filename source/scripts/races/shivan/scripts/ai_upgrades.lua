-- Shivan AI Upgrades and Research Progression

-- Legacy Compatibility Layer
if (CPUPLAYERS_NORUSHTIME5 == nil) then CPUPLAYERS_NORUSHTIME5 = -1 end
if (CPUPLAYERS_NORUSHTIME10 == nil) then CPUPLAYERS_NORUSHTIME10 = -1 end
if (CPUPLAYERS_NORUSHTIME15 == nil) then CPUPLAYERS_NORUSHTIME15 = -1 end

function Util_CheckResearch_Shivan(id)
	if (id == nil) then
		return nil
	end
	if (type(id) == "number") then
		if (IsResearchDone(id) == 0 and IsResearchAvailable(id) == 1) then
			return 1
		end
	end
	return nil
end

function ResearchDemandSet_Shivan(id, demand)
	if (id ~= nil and type(id) == "number" and id ~= -1) then
		ResearchDemandSet(id, demand)
	end
end

function DoResearchTechDemand_Shivan()
	local fighterdemand = ShipDemandMaxByClass(eFighter) * 2
	if fighterdemand > 0 then
		if Util_CheckResearch_Shivan(FIGHTERDESIGN) then
			ResearchDemandSet_Shivan(FIGHTERDESIGN, fighterdemand + 1.0)
		end

		-- Tier 2
		if NumSquadrons(SHI_SCORPION) > 0 then
			if Util_CheckResearch_Shivan(MANTICORE) then
				ResearchDemandSet_Shivan(MANTICORE, fighterdemand + 1.0)
			end
			if Util_CheckResearch_Shivan(ASTAROTH) then
				ResearchDemandSet_Shivan(ASTAROTH, fighterdemand + 1.0)
			end
			if Util_CheckResearch_Shivan(DRAGON) then
				ResearchDemandSet_Shivan(DRAGON, fighterdemand + 1.0)
			end
		end

		-- Tier 3
		if NumSquadrons(SHI_DRAGON) > 0 or NumSquadrons(SHI_ASTAROTH) > 0 then
			if Util_CheckResearch_Shivan(BASILISK) then
				ResearchDemandSet_Shivan(BASILISK, fighterdemand + 1.0)
			end
			if Util_CheckResearch_Shivan(AESHMA) then
				ResearchDemandSet_Shivan(AESHMA, fighterdemand + 1.0)
			end
		end

		-- Tier 4
		if NumSquadrons(SHI_BASILISK) > 0 or NumSquadrons(SHI_AESHMA) > 0 then
			if Util_CheckResearch_Shivan(MARA) then
				ResearchDemandSet_Shivan(MARA, fighterdemand + 1.0)
			end
		end
	end

	local bomberdemand = ShipDemandMaxByClass(eCorvette) * 2
	if bomberdemand > 0 then
		if Util_CheckResearch_Shivan(BOMBERDESIGN) then
			ResearchDemandSet_Shivan(BOMBERDESIGN, bomberdemand + 1.0)
		end

		-- Tier 2
		if NumSquadrons(SHI_SHAITAN) > 0 then
			if Util_CheckResearch_Shivan(NAHEMA) then
				ResearchDemandSet_Shivan(NAHEMA, bomberdemand + 1.0)
			end
			if Util_CheckResearch_Shivan(TAURVI) then
				ResearchDemandSet_Shivan(TAURVI, bomberdemand + 1.0)
			end
		end

		-- Tier 3
		if NumSquadrons(SHI_NAHEMA) > 0 or NumSquadrons(SHI_TAURVI) > 0 then
			if Util_CheckResearch_Shivan(NEPHILIM) then
				ResearchDemandSet_Shivan(NEPHILIM, bomberdemand + 1.0)
			end
		end

		-- Tier 4
		if NumSquadrons(SHI_NEPHILIM) > 0 then
			if Util_CheckResearch_Shivan(SERAPHIM) then
				ResearchDemandSet_Shivan(SERAPHIM, bomberdemand + 1.0)
			end
		end
	end

	local cruiserdemand = ShipDemandMaxByClass(eFrigate) * 2
	if cruiserdemand > 0 then
		if Util_CheckResearch_Shivan(CRUISERDESIGN) then
			ResearchDemandSet_Shivan(CRUISERDESIGN, cruiserdemand + 1.0)
		end

		if NumSquadrons(SHI_CAIN) > 0 then
			if Util_CheckResearch_Shivan(RAKSHASA) then
				ResearchDemandSet_Shivan(RAKSHASA, cruiserdemand + 1.0)
			end
			if Util_CheckResearch_Shivan(LILITH) then
				ResearchDemandSet_Shivan(LILITH, cruiserdemand + 1.0)
			end
		end
	end

	local capitaldemand = ShipDemandMaxByClass(eCapital)
	if capitaldemand > 0 then
		if Util_CheckResearch_Shivan(CAPITALSHIPDESIGN) then
			ResearchDemandSet_Shivan(CAPITALSHIPDESIGN, capitaldemand + 1.0)
		end

		if Util_CheckResearch_Shivan(MOLOCH) then
			ResearchDemandSet_Shivan(MOLOCH, capitaldemand + 1.0)
		end

		if NumSquadrons(SHI_MOLOCH) > 0 then
			if Util_CheckResearch_Shivan(DEMON) then
				ResearchDemandSet_Shivan(DEMON, capitaldemand + 1.0)
			end
			if Util_CheckResearch_Shivan(RAVANA) then
				ResearchDemandSet_Shivan(RAVANA, capitaldemand + 1.0)
			end
		end

		if NumSquadrons(SHI_DEMON) > 0 or NumSquadrons(SHI_RAVANA) > 0 then
			if Util_CheckResearch_Shivan(LUCIFER) then
				ResearchDemandSet_Shivan(LUCIFER, capitaldemand + 2.0)
			end
			if Util_CheckResearch_Shivan(SUPERCAPITALSHIPDESIGN) then
				ResearchDemandSet_Shivan(SUPERCAPITALSHIPDESIGN, capitaldemand + 3.0)
			end
		end

		if IsResearchDone(SUPERCAPITALSHIPDESIGN) == 1 then
			if Util_CheckResearch_Shivan(SATHANAS) then
				ResearchDemandSet_Shivan(SATHANAS, capitaldemand + 5.0)
			end
		end
	end
end

function DoUpgradeDemand_Shivan()
	if NumSquadrons(SHI_MOLOCH) > 0 then
		if Util_CheckResearch_Shivan(MOLOCHARMOR) then
			ResearchDemandSet_Shivan(MOLOCHARMOR, 1.5)
		end
		if Util_CheckResearch_Shivan(MOLOCHSPRINT) then
			ResearchDemandSet_Shivan(MOLOCHSPRINT, 1.5)
		end
	end
end

DoUpgradeDemand = DoUpgradeDemand_Shivan
DoResearchTechDemand = DoResearchTechDemand_Shivan
