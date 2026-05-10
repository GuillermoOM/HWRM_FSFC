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

function Util_CheckResearch_Terran(id)
	if (id == nil) then
		aitrace("Util_CheckResearch_Terran: id is nil")
		return nil
	end

	if (type(id) == "number") then
		if (IsResearchDone(id) == 0 and IsResearchAvailable(id) == 1) then
			return 1
		end
	else
		aitrace("Util_CheckResearch_Terran: id is NOT a number: " .. tostring(id))
	end

	return nil
end

function NumSquadrons_Terran(id)
	if (id ~= nil and type(id) == "number") then
		return NumSquadrons(id)
	end
	return 0
end

function ResearchDemandSet_Terran(id, demand)
	if (id ~= nil and type(id) == "number") then
		ResearchDemandSet(id, demand)
	else
		aitrace("ResearchDemandSet_Terran: invalid id " .. tostring(id))
	end
end

function ResearchDemandAdd_Terran(id, demand)
	if (id ~= nil and type(id) == "number") then
		ResearchDemandAdd(id, demand)
	else
		aitrace("ResearchDemandAdd_Terran: invalid id " .. tostring(id))
	end
end

function DoResearchTechDemand_Terran()
	aitrace("DoResearchTechDemand_Terran start")
	--we start each category by asking how much it wants to build each class, then subdividing based off what other shit it wants.
	local fighterdemand = ShipDemandMaxByClass(eFighter) * 2
	aitrace("  Fighter class demand: " .. tostring(fighterdemand))
	--print("Fighter demand is "..fighterdemand)
	if fighterdemand > 0 then
		if Util_CheckResearch_Terran(FIGHTERDESIGN) then
			aitrace("    Setting demand for FighterDesign")
			ResearchDemandSet_Terran(FIGHTERDESIGN, fighterdemand + 1.0)
		end
		-- Tier 1 is FighterDesign (unblocks Apollo)

		-- Tier 2 (Requires Apollo)
		local numApollo = NumSquadrons_Terran(TER_APOLLO)
		if numApollo > 0 then
			if Util_CheckResearch_Terran(VALKYRIE) then
				local antifighterdemand = ShipDemandMaxByClass(eAntiFighter)
				if antifighterdemand > 0 then
					ResearchDemandSet_Terran(VALKYRIE, fighterdemand + antifighterdemand + 1.0)
				end
			end
			if Util_CheckResearch_Terran(HERCULES) then
				ResearchDemandSet_Terran(HERCULES, fighterdemand + 1.0)
			end
			if Util_CheckResearch_Terran(ULYSSES) then
				ResearchDemandSet_Terran(ULYSSES, fighterdemand + 1.0)
			end
		end

		-- Tier 3 (Requires Valkyrie, Hercules, or Ulysses)
		local numValkyrie = NumSquadrons_Terran(TER_VALKYRIE)
		if numValkyrie > 0 then
			if Util_CheckResearch_Terran(PERSEUS) then
				local antifighterdemand = ShipDemandMaxByClass(eAntiFighter)
				if antifighterdemand > 0 then
					ResearchDemandSet_Terran(PERSEUS, fighterdemand + antifighterdemand + 1.0)
				end
			end
			if Util_CheckResearch_Terran(PEGASUS) then
				local scoutdemand = ShipDemandGet(eScout)
				if scoutdemand > 0 then
					ResearchDemandSet_Terran(PEGASUS, fighterdemand + scoutdemand + 1.0)
				end
			end
		end

		local numHercules = NumSquadrons_Terran(TER_HERCULES)
		if numHercules > 0 then
			if Util_CheckResearch_Terran(HERCULESMK2) then
				ResearchDemandSet_Terran(HERCULESMK2, fighterdemand + 1.0)
			end
		end

		local numUlysses = NumSquadrons_Terran(TER_ULYSSES)
		if numUlysses > 0 then
			if Util_CheckResearch_Terran(MYRMIDON) then
				ResearchDemandSet_Terran(MYRMIDON, fighterdemand + 1.0)
			end
		end

		-- Tier 4
		local numHerculesMk2 = NumSquadrons_Terran(TER_HERCULESMK2)
		if numHerculesMk2 > 0 then
			if Util_CheckResearch_Terran(ARES) then
				ResearchDemandSet_Terran(ARES, fighterdemand + 1.0)
			end
		end

		-- Tier 5
		local numAres = NumSquadrons_Terran(TER_ARES)
		if numAres > 0 then
			if Util_CheckResearch_Terran(ERINYES) then
				ResearchDemandSet_Terran(ERINYES, fighterdemand + 1.0)
			end
		end
	end

	local bomberdemand = ShipDemandMaxByClass(eCorvette) * 2
	--print("Bomber demand is "..bomberdemand)
	if bomberdemand > 0 then
		if Util_CheckResearch_Terran(BOMBERDESIGN) then
			ResearchDemandSet_Terran(BOMBERDESIGN, bomberdemand + 1.0)
		end

		-- Tier 2
		local numAthena = NumSquadrons_Terran(TER_ATHENA)
		if numAthena > 0 then
			if Util_CheckResearch_Terran(ZEUS) then
				ResearchDemandSet_Terran(ZEUS, bomberdemand + 1.0)
			end
		end

		-- Tier 3
		local numZeus = NumSquadrons_Terran(TER_ZEUS)
		if numZeus > 0 then
			local anticapitaldemand = ShipDemandMaxByClass(eAntiFrigate)
			if Util_CheckResearch_Terran(ARTEMIS) then
				ResearchDemandSet_Terran(ARTEMIS, bomberdemand + anticapitaldemand + 1.0)
			end
			if Util_CheckResearch_Terran(MEDUSA) then
				ResearchDemandSet_Terran(MEDUSA, bomberdemand + anticapitaldemand + 1.0)
			end
		end

		-- Tier 4
		local numArtemis = NumSquadrons_Terran(TER_ARTEMIS)
		if numArtemis > 0 then
			local anticapitaldemand = ShipDemandMaxByClass(eAntiFrigate)
			if Util_CheckResearch_Terran(ARTEMISDH) then
				ResearchDemandSet_Terran(ARTEMISDH, bomberdemand + anticapitaldemand + 1.0)
			end
		end

		-- Check for Medusa or MedusaFS1 to be safe
		local numMedusa = NumSquadrons_Terran(TER_MEDUSA) or 0
		if type(TER_MEDUSAFS1) ~= "nil" and numMedusa == 0 then
			numMedusa = NumSquadrons_Terran(TER_MEDUSAFS1)
		end

		if numMedusa > 0 then
			local anticapitaldemand = ShipDemandMaxByClass(eAntiFrigate)
			if Util_CheckResearch_Terran(BOANERGES) then
				ResearchDemandSet_Terran(BOANERGES, bomberdemand + anticapitaldemand + 1.0)
			end
		end

		-- Tier 5
		local numBoanerges = NumSquadrons_Terran(TER_BOANERGES)
		if numBoanerges > 0 then
			local anticapitaldemand = ShipDemandMaxByClass(eAntiFrigate)
			if Util_CheckResearch_Terran(URSA) then
				ResearchDemandSet_Terran(URSA, bomberdemand + anticapitaldemand + 1.0)
			end
		end
	end
	local cruiserdemand = ShipDemandMaxByClass(eFrigate) * 2
	--print("Cruiser demand is "..cruiserdemand)
	if cruiserdemand > 0 then
		if Util_CheckResearch_Terran(CRUISERDESIGN) then
			ResearchDemandSet_Terran(CRUISERDESIGN, cruiserdemand + 1.0)
		end

		if Util_CheckResearch_Terran(REPAIRFRIGATE) then
			ResearchDemandSet_Terran(REPAIRFRIGATE, cruiserdemand + 1.0)
		end

		local numFenris = NumSquadrons_Terran(TER_FENRIS)
		if numFenris > 0 then
			if Util_CheckResearch_Terran(HEAVYCRUISER) then
				ResearchDemandSet_Terran(HEAVYCRUISER, cruiserdemand + 1.0)
			end
		end

		local numLeviathan = NumSquadrons_Terran(TER_LEVIATHAN)
		if numLeviathan > 0 then
			if Util_CheckResearch_Terran(ADVANCEDCRUISER) then
				ResearchDemandSet_Terran(ADVANCEDCRUISER, cruiserdemand + 1.0)
			end
		end
	end

	local capitaldemand = ShipDemandMaxByClass(eCapital)
	--print("Capital demand is "..capitaldemand)
	if capitaldemand > 0 then
		if Util_CheckResearch_Terran(CAPITALSHIPDESIGN) then
			ResearchDemandSet_Terran(CAPITALSHIPDESIGN, capitaldemand + 1.0)
		end

		if Util_CheckResearch_Terran(CORVETTE) then
			ResearchDemandSet_Terran(CORVETTE, capitaldemand + 1.0)
		end

		local numDeimos = NumSquadrons_Terran(TER_DEIMOS)
		if numDeimos > 0 then
			if Util_CheckResearch_Terran(COMMANDCORVETTE) then
				ResearchDemandSet_Terran(COMMANDCORVETTE, capitaldemand + 1.0)
			end
		end

		local numOrion = NumSquadrons_Terran(TER_ORION)
		local numHecate = NumSquadrons_Terran(TER_HECATE)
		if numOrion > 0 or numHecate > 0 then
			if Util_CheckResearch_Terran(SUPERDESTROYER) then
				ResearchDemandSet_Terran(SUPERDESTROYER, capitaldemand + 1.0)
			end
		end

		local numHades = NumSquadrons_Terran(TER_HADES)
		if numHades > 0 then
			if Util_CheckResearch_Terran(JUGGERNAUT) then
				ResearchDemandSet_Terran(JUGGERNAUT, capitaldemand + 1.0)
			end
		end
	end
end

function DoUpgradeDemand_Terran()
	aitrace("DoUpgradeDemand_Terran start")
	if s_militaryStrength > 10 or g_LOD == 0 then
		local numCollectors = NumSquadrons_Terran(kCollector)
		if numCollectors > 0 then
			ResearchDemandAdd_Terran(COLLECTORHP, numCollectors * 0.1)
		end
		local numRefinery = NumSquadrons_Terran(kRefinery)
		if numRefinery > 0 then
			ResearchDemandAdd_Terran(DROPOFFHP, numCollectors * 0.1)
		end
		local numCarrier = NumSquadrons_Terran(kCarrier)
		if numCarrier > 0 then
			ResearchDemandAdd_Terran(HECATEBUILDSPEED, numCarrier * 4.25)
		end
	end
	local numFighter = numActiveOfClass(s_playerIndex, eFighter)
	if numFighter > 1 then
		local numInterceptors = NumSquadrons_Terran(kInterceptor) --This is our EMP upgrade.
		if numInterceptors > 1 then
			ResearchDemandAdd_Terran(EMPADV, numInterceptors * 1.5)
		end
		local numBombers = NumSquadrons_Terran(kBomber) --This is our Tornado upgrade.
		if numBombers > 1 then
			ResearchDemandAdd_Terran(TORNADOMISSILES, numBombers * 1.5)
		end
		local numAvengers = NumSquadrons_Terran(TER_APOLLO)
		if numAvengers > 1 then
			ResearchDemandAdd_Terran(AVENGER, numAvengers * 1.5)
		end
		local numRailguns = NumSquadrons_Terran(TER_VALKYRIE)
		if numRailguns > 1 then
			ResearchDemandAdd_Terran(RAILGUN, numRailguns * 1.5)
		end
		local numSbreakers = NumSquadrons_Terran(TER_ULYSSES)
		if numSbreakers > 1 then
			ResearchDemandAdd_Terran(SBREAKER, numSbreakers * 1.5)
		end
	end
	local numDestroyers = NumSquadrons_Terran(kDestroyer)
	if numDestroyers > 0 then
		ResearchDemandAdd_Terran(DEIMOSARMOR, numDestroyers * 2)
	end
	local numCorvette = numActiveOfClass(s_playerIndex, eCorvette)
	if numCorvette > 1 then
		local numStrikeBombers = NumSquadrons_Terran(TER_ZEUS)
		if numStrikeBombers > 2 then
			ResearchDemandAdd_Terran(STILETTOII, numStrikeBombers * 1.25)
		end
		local numMediumBombers = NumSquadrons_Terran(TER_ARTEMIS)
		if numMediumBombers > 2 then
			ResearchDemandAdd_Terran(PIHRANA, numMediumBombers * 1.25)
			ResearchDemandAdd_Terran(ARTEMISDH, numMediumBombers)
		end
		local numClusterBombers = NumSquadrons_Terran(TER_BOANERGES)
		if numClusterBombers > 2 then
			ResearchDemandAdd_Terran(INFYRNO, numClusterBombers * 1.25)
		end
		local numSynaptic = NumSquadrons_Terran(TER_MEDUSAFS1)
		if numSynaptic > 2 then
			ResearchDemandAdd_Terran(SYNAPTIC, numSynaptic * 1.25)
		end
		local numClusterBombers = NumSquadrons_Terran(TER_URSAFS1)
		if numClusterBombers > 2 then
			ResearchDemandAdd_Terran(CLUSTERBOMB, numClusterBombers * 1.25)
		end
		local numFlails = NumSquadrons_Terran(TER_ATHENA)
		if numFlails > 2 then
			ResearchDemandAdd_Terran(FLAIL, numFlails * 1.25)
		end
	end
	local numFrigate = numActiveOfClass(s_playerIndex, eFrigate)
	if numFrigate > 1 then
		local numFrigate = NumSquadrons_Terran(TER_FENRIS)
		if numFrigate > 1 then
			ResearchDemandAdd_Terran(CRUISERHEALTHUPGRADE, numFrigate * 5)
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
		ResearchDemandAdd_Terran(AWACS2, numAWACS * 5)
		ResearchDemandAdd_Terran(AWACS3, numAWACS * 10)
	end
end

DoUpgradeDemand = DoUpgradeDemand_Terran
DoResearchTechDemand = DoResearchTechDemand_Terran
