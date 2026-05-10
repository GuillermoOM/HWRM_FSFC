-- Vasudan AI Upgrades and Research Progression

-- Legacy Compatibility Layer
if (CPUPLAYERS_NORUSHTIME5 == nil) then CPUPLAYERS_NORUSHTIME5 = -1 end
if (CPUPLAYERS_NORUSHTIME10 == nil) then CPUPLAYERS_NORUSHTIME10 = -1 end
if (CPUPLAYERS_NORUSHTIME15 == nil) then CPUPLAYERS_NORUSHTIME15 = -1 end

function Util_CheckResearch_Vasudan(id)
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

function ResearchDemandSet_Vasudan(id, demand)
	if (id ~= nil and type(id) == "number" and id ~= -1) then
		ResearchDemandSet(id, demand)
	end
end

function DoResearchTechDemand_Vasudan()
	local fighterdemand = ShipDemandMaxByClass(eFighter) * 2
	if fighterdemand > 0 then
		if Util_CheckResearch_Vasudan(FIGHTERDESIGN) then
			ResearchDemandSet_Vasudan(FIGHTERDESIGN, fighterdemand + 1.0)
		end

		-- Tier 2
		if NumSquadrons(VAS_HORUS) > 0 then
			if Util_CheckResearch_Vasudan(SETH) then
				ResearchDemandSet_Vasudan(SETH, fighterdemand + 1.0)
			end
			if Util_CheckResearch_Vasudan(THOTH) then
				ResearchDemandSet_Vasudan(THOTH, fighterdemand + 1.0)
			end
		end

		-- Tier 3
		if NumSquadrons(VAS_SETH) > 0 or NumSquadrons(VAS_THOTH) > 0 then
			if Util_CheckResearch_Vasudan(SERAPIS) then
				ResearchDemandSet_Vasudan(SERAPIS, fighterdemand + 1.0)
			end
			if Util_CheckResearch_Vasudan(PTAH) then
				ResearchDemandSet_Vasudan(PTAH, fighterdemand + 1.0)
			end
		end

		-- Tier 4
		if NumSquadrons(VAS_SERAPIS) > 0 then
			if Util_CheckResearch_Vasudan(TAURET) then
				ResearchDemandSet_Vasudan(TAURET, fighterdemand + 1.0)
			end
		end
	end

	local bomberdemand = ShipDemandMaxByClass(eCorvette) * 2
	if bomberdemand > 0 then
		if Util_CheckResearch_Vasudan(BOMBERDESIGN) then
			ResearchDemandSet_Vasudan(BOMBERDESIGN, bomberdemand + 1.0)
		end

		-- Tier 2
		if NumSquadrons(VAS_OSIRIS) > 0 then
			if Util_CheckResearch_Vasudan(BAKHA) then
				ResearchDemandSet_Vasudan(BAKHA, bomberdemand + 1.0)
			end
		end

		-- Tier 3
		if NumSquadrons(VAS_BAKHA) > 0 then
			if Util_CheckResearch_Vasudan(SEHKMET) then
				ResearchDemandSet_Vasudan(SEHKMET, bomberdemand + 1.0)
			end
		end
	end

	local cruiserdemand = ShipDemandMaxByClass(eFrigate) * 2
	if cruiserdemand > 0 then
		if Util_CheckResearch_Vasudan(CRUISERDESIGN) then
			ResearchDemandSet_Vasudan(CRUISERDESIGN, cruiserdemand + 1.0)
		end

		if Util_CheckResearch_Vasudan(ATEN) then
			ResearchDemandSet_Vasudan(ATEN, cruiserdemand + 1.0)
		end

		if NumSquadrons(VAS_ATEN) > 0 then
			if Util_CheckResearch_Vasudan(MENTU) then
				ResearchDemandSet_Vasudan(MENTU, cruiserdemand + 1.0)
			end
			if Util_CheckResearch_Vasudan(SCIENCEVESSEL) then
				ResearchDemandSet_Vasudan(SCIENCEVESSEL, cruiserdemand + 0.5)
			end
		end
	end

	local capitaldemand = ShipDemandMaxByClass(eCapital)
	if capitaldemand > 0 then
		if Util_CheckResearch_Vasudan(CAPITALSHIPDESIGN) then
			ResearchDemandSet_Vasudan(CAPITALSHIPDESIGN, capitaldemand + 1.0)
		end

		if Util_CheckResearch_Vasudan(TYPHON) then
			ResearchDemandSet_Vasudan(TYPHON, capitaldemand + 1.0)
		end

		if NumSquadrons(VAS_TYPHON) > 0 then
			if Util_CheckResearch_Vasudan(SOBEK) then
				ResearchDemandSet_Vasudan(SOBEK, capitaldemand + 1.0)
			end
			if Util_CheckResearch_Vasudan(INSTALLATION) then
				ResearchDemandSet_Vasudan(INSTALLATION, capitaldemand + 0.5)
			end
		end

		if NumSquadrons(VAS_SOBEK) > 0 then
			if Util_CheckResearch_Vasudan(HATSHEPSUT) then
				ResearchDemandSet_Vasudan(HATSHEPSUT, capitaldemand + 1.0)
			end
		end

		if NumSquadrons(VAS_HATSHEPSUT) > 0 then
			if Util_CheckResearch_Vasudan(SUPERCAPITALSHIPDESIGN) then
				ResearchDemandSet_Vasudan(SUPERCAPITALSHIPDESIGN, capitaldemand + 2.0)
			end
		end

		if IsResearchDone(SUPERCAPITALSHIPDESIGN) == 1 then
			if Util_CheckResearch_Vasudan(COLOSSUS) then
				ResearchDemandSet_Vasudan(COLOSSUS, capitaldemand + 5.0)
			end
		end
	end
end

function DoUpgradeDemand_Vasudan()
	if NumSquadrons(VAS_SOBEK) > 0 then
		if Util_CheckResearch_Vasudan(SOBEKARMOR) then
			ResearchDemandSet_Vasudan(SOBEKARMOR, 1.5)
		end
		if Util_CheckResearch_Vasudan(SOBEKSPRINT) then
			ResearchDemandSet_Vasudan(SOBEKSPRINT, 1.5)
		end
	end
end

DoUpgradeDemand = DoUpgradeDemand_Vasudan
DoResearchTechDemand = DoResearchTechDemand_Vasudan
