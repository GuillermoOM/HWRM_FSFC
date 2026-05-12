dofilepath("data:scripts/custom_scripts/ai_telemetry.lua")
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

-- Global variables like kBomber, kInterceptor etc are set by ai_build.lua

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
	if fighterdemand > 0 then
		if Util_CheckResearch_Terran(FIGHTERDESIGN) then
			ResearchDemandSet_Terran(FIGHTERDESIGN, fighterdemand + 1.0)
		end

		-- Era-aware Tier 1
		local baseFighter = kInterceptor -- Usually Apollo (FS1) or Perseus (FS2)
		if Util_CheckResearch_Terran(FIGHTERDESIGN) == nil then -- Already done
			if IsResearchDone(FS2) == 1 then
				if Util_CheckResearch_Terran(PERSEUS) then
					ResearchDemandSet_Terran(PERSEUS, fighterdemand + 1.0)
				end
			else
				if Util_CheckResearch_Terran(APOLLO) then
					ResearchDemandSet_Terran(APOLLO, fighterdemand + 1.0)
				end
			end
		end

		-- Tier 2+
		local numFighters = NumSquadrons_Terran(kInterceptor)
		if numFighters > 0 then
			if Util_CheckResearch_Terran(VALKYRIE) then
				ResearchDemandSet_Terran(VALKYRIE, fighterdemand + 1.0)
			end
			if Util_CheckResearch_Terran(HERCULES) then
				ResearchDemandSet_Terran(HERCULES, fighterdemand + 1.0)
			end
			if Util_CheckResearch_Terran(ULYSSES) then
				ResearchDemandSet_Terran(ULYSSES, fighterdemand + 1.0)
			end
		end

		if IsResearchDone(FS2) == 1 then
			local numHercules = NumSquadrons_Terran(TER_HERCULES)
			if numHercules > 0 then
				if Util_CheckResearch_Terran(HERCULESMK2) then
					ResearchDemandSet_Terran(HERCULESMK2, fighterdemand + 1.0)
				end
			end
		end
	end

	local bomberdemand = ShipDemandMaxByClass(eCorvette) * 2
	if bomberdemand > 0 then
		if Util_CheckResearch_Terran(BOMBERDESIGN) then
			ResearchDemandSet_Terran(BOMBERDESIGN, bomberdemand + 1.0)
		end

		-- Era-aware progression
		if IsResearchDone(FS2) == 1 then
			-- FS2 Branch
			if Util_CheckResearch_Terran(ZEUS) then
				ResearchDemandSet_Terran(ZEUS, bomberdemand + 1.0)
			end
			local numZeus = NumSquadrons_Terran(TER_ZEUS)
			if numZeus > 0 then
				if Util_CheckResearch_Terran(ARTEMIS) then
					ResearchDemandSet_Terran(ARTEMIS, bomberdemand + 1.0)
				end
			end
			local numArtemis = NumSquadrons_Terran(TER_ARTEMIS)
			if numArtemis > 0 then
				if Util_CheckResearch_Terran(MEDUSA) then
					ResearchDemandSet_Terran(MEDUSA, bomberdemand + 1.5)
				end
				if Util_CheckResearch_Terran(URSA) then
					ResearchDemandSet_Terran(URSA, bomberdemand + 1.2)
				end
			end
		else
			-- FS1 Branch: Medusa is a direct upgrade or available earlier
			if Util_CheckResearch_Terran(ZEUS) then
				ResearchDemandSet_Terran(ZEUS, bomberdemand + 1.0)
			end
			local numZeus = NumSquadrons_Terran(TER_ZEUS)
			if numZeus > 0 or Util_CheckResearch_Terran(ZEUS) == nil then
				if Util_CheckResearch_Terran(MEDUSA) then
					ResearchDemandSet_Terran(MEDUSA, bomberdemand + 1.5)
				end
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
			FSFC_Log_Research("Deimos")
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
				FSFC_Log_Research("Orion")
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

	local numDestroyers = NumSquadrons_Terran(TER_DEIMOS)
	if numDestroyers > 0 then
		ResearchDemandAdd_Terran(DEIMOSARMOR, numDestroyers * 2)
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
