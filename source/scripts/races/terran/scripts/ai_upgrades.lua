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

-- AI Ship Variable Mappings (Engine provided)

-- AI Research Variable Mappings (Engine provided)

kCollector = TER_ELYSIUM
kRefinery = TER_ZEPHYRUS
kInterceptor = TER_VALKYRIE
kBomber = TER_ZEUS
kDestroyer = TER_DEIMOS
kBattleCruiser = TER_ORION
kCarrier = TER_HECATE

function Util_CheckResearch_Terran(id)
	if (id == nil or id == -1) then
		return nil
	end
	if (type(id) ~= "number") then
		return nil
	end
	if (IsResearchDone(id) == 0 and IsResearchAvailable(id) == 1) then
		return 1
	end
	return nil
end

function NumSquadrons_Terran(id)
	if (id ~= nil) then
		return NumSquadrons(id)
	end
	return 0
end

function ResearchDemandSet_Terran(id, demand)
	if (id ~= nil and id ~= -1 and type(id) == "number") then
		ResearchDemandSet(id, demand)
	end
end

function ResearchDemandAdd_Terran(id, demand)
	if (id ~= nil and id ~= -1 and type(id) == "number") then
		ResearchDemandAdd(id, demand)
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
				local scoutdemand = ShipDemandMaxByClass(eFighter)
				if scoutdemand > 0 then
					ResearchDemandSet_Terran(PEGASUS, scoutdemand + 1.0)
				end
			end
		end

		local numHercules = NumSquadrons_Terran(TER_HERCULES)
		if numHercules > 0 then
			if Util_CheckResearch_Terran(HERCULESMK2) then
				ResearchDemandSet_Terran(HERCULESMK2, fighterdemand + 1.0)
			end
		end

		-- Tier 4 (Requires Perseus or Mk2)
		local numPerseus = NumSquadrons_Terran(TER_PERSEUS)
		if numPerseus > 0 then
			if Util_CheckResearch_Terran(ARES) then
				ResearchDemandSet_Terran(ARES, fighterdemand + 1.0)
			end
		end

		local numMk2 = NumSquadrons_Terran(TER_HERCULESMK2)
		if numMk2 > 0 then
			if Util_CheckResearch_Terran(ERINYES) then
				ResearchDemandSet_Terran(ERINYES, fighterdemand + 1.0)
			end
		end
	end

	local bomberdemand = ShipDemandMaxByClass(eCorvette) * 2
	if bomberdemand > 0 then
		if Util_CheckResearch_Terran(BOMBERDESIGN) then
			ResearchDemandSet_Terran(BOMBERDESIGN, bomberdemand + 1.0)
		end

		-- Tier 2
		local numZeus = NumSquadrons_Terran(TER_ZEUS)
		if numZeus > 0 then
			if Util_CheckResearch_Terran(ARTEMIS) then
				ResearchDemandSet_Terran(ARTEMIS, bomberdemand + 1.0)
			end
		end

		-- Tier 3
		local numArtemis = NumSquadrons_Terran(TER_ARTEMIS)
		if numArtemis > 0 then
			if Util_CheckResearch_Terran(MEDUSA) then
				ResearchDemandSet_Terran(MEDUSA, bomberdemand + 1.0)
			end
			if Util_CheckResearch_Terran(URSA) then
				ResearchDemandSet_Terran(URSA, bomberdemand + 1.0)
			end
			if Util_CheckResearch_Terran(BOANERGES) then
				ResearchDemandSet_Terran(BOANERGES, bomberdemand + 1.0)
			end
			if Util_CheckResearch_Terran(ARTEMISDH) then
				ResearchDemandSet_Terran(ARTEMISDH, bomberdemand + 1.0)
			end
		end
	end

	local cruiserdemand = ShipDemandMaxByClass(eFrigate) * 2
	if cruiserdemand > 0 then
		if Util_CheckResearch_Terran(CRUISERDESIGN) then
			ResearchDemandSet_Terran(CRUISERDESIGN, cruiserdemand + 1.0)
		end

		if Util_CheckResearch_Terran(REPAIRARGO) then
			ResearchDemandSet_Terran(REPAIRARGO, cruiserdemand + 0.5)
		end
		if Util_CheckResearch_Terran(REPAIRCHRONOS) then
			ResearchDemandSet_Terran(REPAIRCHRONOS, cruiserdemand + 0.5)
		end

		local numFenris = NumSquadrons_Terran(TER_FENRIS) + NumSquadrons_Terran(TER_FENRIS_FS1)
		if numFenris > 0 then
			if Util_CheckResearch_Terran(HEAVYCRUISER) then
				ResearchDemandSet_Terran(HEAVYCRUISER, cruiserdemand + 1.0)
			end
		end
		local numLeviathan = NumSquadrons_Terran(TER_LEVIATHAN) + NumSquadrons_Terran(TER_LEVIATHAN_FS1)
		if numLeviathan > 0 then
			if Util_CheckResearch_Terran(ADVANCEDCRUISER) then
				ResearchDemandSet_Terran(ADVANCEDCRUISER, cruiserdemand + 1.0)
			end
		end
	end

	local capitaldemand = ShipDemandMaxByClass(eCapital)
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
			if Util_CheckResearch_Terran(SUPERDESTROYER) then
				ResearchDemandSet_Terran(SUPERDESTROYER, capitaldemand + 1.0)
			end
		end

		local numOrion = NumSquadrons_Terran(TER_ORION) + NumSquadrons_Terran(TER_ORION_FS1)
		if numOrion > 0 then
			if Util_CheckResearch_Terran(JUGGERNAUT) then
				ResearchDemandSet_Terran(JUGGERNAUT, capitaldemand + 1.0)
			end
		end
	end
end

function DoUpgradeDemand_Terran()
	-- Resource Upgrades
	local numCollectors = NumSquadrons_Terran(kCollector)
	if numCollectors > 3 then
		ResearchDemandAdd_Terran(COLLECTORHP, numCollectors * 2)
	end
	local numRefineries = NumSquadrons_Terran(kRefinery)
	if numRefineries > 0 then
		ResearchDemandAdd_Terran(DROPOFFHP, numRefineries * 3)
	end
	-- Carrier Build Speed
	local numCarriers = NumSquadrons_Terran(kCarrier)
	if numCarriers > 0 then
		ResearchDemandAdd_Terran(HECATEBUILDSPEED, numCarriers * 3)
	end
	-- Weapons
	local numFighters = numActiveOfClass(s_playerIndex, eFighter)
	if numFighters > 3 then
		local numMyrmidon = NumSquadrons_Terran(TER_MYRMIDON)
		if numMyrmidon > 2 then
			ResearchDemandAdd_Terran(EMPADV, numMyrmidon * 1.25)
		end
		local numAres = NumSquadrons_Terran(TER_ARES)
		if numAres > 1 then
			ResearchDemandAdd_Terran(TORNADOMISSILES, numAres * 1.5)
		end
		local numHercMk2 = NumSquadrons_Terran(TER_HERCULESMK2)
		if numHercMk2 > 2 then
			ResearchDemandAdd_Terran(AVENGER, numHercMk2 * 1.25)
		end
		local numErinyes = NumSquadrons_Terran(TER_ERINYES)
		if numErinyes > 2 then
			ResearchDemandAdd_Terran(RAILGUN, numErinyes * 1.25)
			ResearchDemandAdd_Terran(SBREAKER, numErinyes * 1.0)
		end
	end
	local numDestroyers = NumSquadrons_Terran(TER_DEIMOS)
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
		local numSynaptic = NumSquadrons_Terran(TER_MEDUSA_FS1)
		if numSynaptic > 2 then
			ResearchDemandAdd_Terran(SYNAPTIC, numSynaptic * 1.25)
		end
		local numClusterBombers = NumSquadrons_Terran(TER_URSA_FS1)
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
		local numFrigateCount = NumSquadrons_Terran(TER_FENRIS) + NumSquadrons_Terran(TER_FENRIS_FS1)
		if numFrigateCount > 1 then
			ResearchDemandAdd_Terran(CRUISERHEALTHUPGRADE, numFrigateCount * 5)
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
		ResearchDemandAdd_Terran(AWACS2, numAWACS * 3)
		ResearchDemandAdd_Terran(AWACS3, numAWACS * 3)
	end
end

function DoResearchTechDemand(playerIndex)
	DoResearchTechDemand_Terran()
end

function DoUpgradeDemand(playerIndex)
	DoUpgradeDemand_Terran()
end
