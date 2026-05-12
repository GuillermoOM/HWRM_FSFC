-- FSFC Global Telemetry & Balance Diagnostic Script
-- This script provides high-level match data for post-game analysis.

-- Stats Persistence
Stats_AccumulatedRUs = { 0, 0, 0, 0, 0, 0, 0, 0 }
Stats_LastRUs = { 0, 0, 0, 0, 0, 0, 0, 0 }
Stats_MatchEndLogged = 0

-- Ship Roster for detailed tracking
-- Universal Master Roster (Extracted from Balance Sheet & Classdef)
MASTER_ROSTER = {
	"ter_apollo", "ter_valkyrie", "ter_athena", "ter_medusa", "ter_medusa_fs1", "ter_ursa", "ter_ursa_fs1",
	"ter_hercules", "ter_herculesmk2", "ter_myrmidon", "ter_perseus", "ter_erinyes", "ter_ares",
	"ter_loki", "ter_pegasus", "ter_artemis", "ter_artemisdh", "ter_boanerges", "ter_pharos",
	"ter_fenris", "ter_fenris_fs1", "ter_leviathan", "ter_leviathan_fs1", "ter_aeolus", "ter_deimos",
	"ter_orion", "ter_orion_fs1", "ter_hecate", "ter_hades", "ter_colossus", "ter_iceni",
	"ter_chronos", "ter_zephyrus", "ter_elysium", "ter_argo", "ter_hygeia", "ter_poseidon", "ter_alastor", "ter_faustus",
	"ter_mjolnir", "ter_charybdis", "ter_zeus",
	"vas_seth", "vas_horus", "vas_thoth", "vas_serapis", "vas_tauret", "vas_ptah",
	"vas_osiris", "vas_bakha", "vas_sehkmet", "vas_amun",
	"vas_aten", "vas_aten_fs1", "vas_mentu", "vas_sobek", "vas_typhon", "vas_typhon_fs1",
	"vas_hatshepsut", "vas_colossus", "vas_karnak",
	"vas_satis", "vas_bes", "vas_ankh", "vas_scarab", "vas_nephthys", "vas_imhotep", "vas_isis", "vas_maat", "vas_anuket",
	"vas_geb", "vas_setekh", "vas_edjo",
	"shi_manticore", "shi_basilisk", "shi_dragon", "shi_astaroth", "shi_mara", "shi_aeshma",
	"shi_shaitan", "shi_taurvi", "shi_nephilim", "shi_seraphim", "shi_nahema",
	"shi_cain", "shi_cain_fs1", "shi_lilith", "shi_lilith_fs1", "shi_rakshasa",
	"shi_moloch", "shi_demon", "shi_demon_fs1", "shi_ravana", "shi_lucifer", "shi_sathanas",
	"shi_azrael", "shi_mephisto", "shi_asmodeus", "shi_rahu", "shi_commnode", "shi_scorpion", "shi_belial", "shi_trident"
}

function Rule_TrackEconomy()
	for i = 0, Universe_PlayerCount() - 1 do
		if (Player_IsAlive(i) == 1) then
			local current = Player_GetRU(i)
			if (current > Stats_LastRUs[i + 1]) then
				Stats_AccumulatedRUs[i + 1] = Stats_AccumulatedRUs[i + 1] + (current - Stats_LastRUs[i + 1])
			end
			Stats_LastRUs[i + 1] = current
		end
	end
end

function Rule_GlobalTelemetry()
	local time = Universe_GameTime()
	print("[DIAG] --- Match Telemetry @ " .. floor(time) .. "s ---")

	for i = 0, Universe_PlayerCount() - 1 do
		if Player_IsAlive(i) == 1 then
			local race = PlayerRace_GetString(i, "Prefix", "UNK")
			local totalShips = SobGroup_Count("Player_Ships" .. i)
			local rus = Player_GetRU(i)
			local accRus = Stats_AccumulatedRUs[i + 1]

			-- Class Totals
			SobGroup_CreateIfNotExist("temp_tele")

			SobGroup_Clear("temp_tele")
			SobGroup_FilterInclude("temp_tele", "Player_Ships" .. i, "displayFamily", "Fighter")
			local nF = SobGroup_Count("temp_tele")

			SobGroup_Clear("temp_tele")
			SobGroup_FilterInclude("temp_tele", "Player_Ships" .. i, "displayFamily", "Bomber")
			local nB = SobGroup_Count("temp_tele")

			SobGroup_Clear("temp_tele")
			SobGroup_FilterInclude("temp_tele", "Player_Ships" .. i, "displayFamily", "Corvette")
			local nC = SobGroup_Count("temp_tele")

			SobGroup_Clear("temp_tele")
			SobGroup_FilterInclude("temp_tele", "Player_Ships" .. i, "displayFamily", "Frigate")
			local nFr = SobGroup_Count("temp_tele")

			SobGroup_Clear("temp_tele")
			SobGroup_FilterInclude("temp_tele", "Player_Ships" .. i, "displayFamily", "Cruiser")
			nFr = nFr + SobGroup_Count("temp_tele")

			SobGroup_Clear("temp_tele")
			SobGroup_FilterInclude("temp_tele", "Player_Ships" .. i, "displayFamily", "Capital")
			local nCp = SobGroup_Count("temp_tele")

			SobGroup_Clear("temp_tele")
			SobGroup_FilterInclude("temp_tele", "Player_Ships" .. i, "displayFamily", "Utility")
			local nU = SobGroup_Count("temp_tele")

			SobGroup_Clear("temp_tele")
			SobGroup_FilterInclude("temp_tele", "Player_Ships" .. i, "displayFamily", "Platform")
			local nP = SobGroup_Count("temp_tele")

			-- Summary Log
			print("[" .. floor(time) .. "s] [DIAG] P" ..
				i .. " (" .. race .. ") | Fleet: " .. totalShips .. " | RUs: " .. rus .. " | TotalRUs: " .. accRus)
			print("[" .. floor(time) .. "s] [DIAG] P" ..
				i ..
				" CLASSES | F: " ..
				nF ..
				" | B: " ..
				nB .. " | C: " .. nC .. " | Fr: " .. nFr .. " | Cap: " .. nCp .. " | U: " .. nU .. " | P: " .. nP)

			-- Detailed Ship Tracking (Universal Roster)
			local shipCounts = ""
			local shipListCount = getn(MASTER_ROSTER)
			for j = 1, shipListCount do
				local ship = MASTER_ROSTER[j]
				SobGroup_Clear("temp_tele")
				Player_FillShipsByType("temp_tele", i, ship)
				local count = SobGroup_Count("temp_tele")
				if (count > 0) then
					shipCounts = shipCounts .. ship .. ":" .. count .. " "
				end
			end
			if (shipCounts ~= "") then
				print("[" .. floor(time) .. "s] [DIAG] P" .. i .. " SHIPS | " .. shipCounts)
			end
		end
	end
	print("[DIAG] ----------------------------------")
end

function Rule_CheckVictory()
	if (Stats_MatchEndLogged == 1) then return end

	local alivePlayers = 0
	for i = 0, Universe_PlayerCount() - 1 do
		if (Player_IsAlive(i) == 1) then
			alivePlayers = alivePlayers + 1
		end
	end

	-- In deathmatch, usually game ends when 1 player/alliance left
	-- We log if we are near the end or if the rule stops
	if (alivePlayers <= 1) then
		LogFinalStats()
		Stats_MatchEndLogged = 1
		Rule_Remove("Rule_CheckVictory")
	end
end

function LogFinalStats()
	print("[DIAG] ==================================")
	print("[DIAG] === FINAL MATCH DIAGNOSTICS === ")
	print("[DIAG] Match Duration: " .. floor(Universe_GameTime()) .. "s")

	for i = 0, Universe_PlayerCount() - 1 do
		local status = "DEFEATED"
		if (Player_IsAlive(i) == 1) then status = "VICTORIOUS" end

		local race = PlayerRace_GetString(i, "Prefix", "UNK")
		local accRus = Stats_AccumulatedRUs[i + 1]

		print("[DIAG] P" .. i .. " (" .. race .. ") | Status: " .. status .. " | Economy Score: " .. accRus)
	end
	print("[DIAG] ==================================")
end

function LogMatchSettings()
	print("[DIAG] --- Match Settings ---")
	local era_str = "Unknown"
	if (era_setting == 0) then
		era_str = "FS1 (Great War)"
	elseif (era_setting == 1) then
		era_str = "FS2 (Second Great War)"
	elseif (era_setting == 3) then
		era_str = "BOTH (All Eras)"
	end
	print("[DIAG] Era Setting: " .. era_str)
	if (resources) then print("[DIAG] Starting Resources: " .. resources) end
	if (ruinjections) then print("[DIAG] RU Injections: " .. ruinjections) end
	if (unitcaps) then print("[DIAG] Unit Caps: " .. (unitcaps or "Normal")) end
	print("[DIAG] ----------------------")

	-- Start auxiliary rules
	Rule_AddInterval("Rule_TrackEconomy", 1.0)
	Rule_AddInterval("Rule_CheckVictory", 5.0)
end
