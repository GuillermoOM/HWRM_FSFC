-- FSFC AI Telemetry Helper
-- Engine functions AI_Log_Demand/Research are protected and internally broken (use nil 'format').
-- We use FSFC_ prefixed versions to avoid conflicts.

if not AI_Telemetry_Loaded then
    AI_Telemetry_Loaded = 1

    FSFC_ResearchLogged = {}
    
    function FSFC_Log_Demand(label, demand)
        -- Throttled: Only log high-priority build desires
        if (demand > 1.5) then
            local time = gameTime() or 0
            print("[" .. floor(time) .. "s] [AI_DIAG] P" .. s_playerIndex .. " | WANT | " .. label .. " | Demand: " .. demand)
        end
    end

    function FSFC_ResolveID(id_or_name)
        if (id_or_name == nil) then
            return nil
        end
        if (type(id_or_name) == "number") then
            return id_or_name
        end
        local id = getglobal(id_or_name)
        -- Fallback to manual uppercase check for common names if first lookup fails
        if (id == nil) then
            if (id_or_name == "FighterDesign") then id = getglobal("FIGHTERDESIGN") end
            if (id == nil and id_or_name == "BomberDesign") then id = getglobal("BOMBERDESIGN") end
            if (id == nil and id_or_name == "CruiserDesign") then id = getglobal("CRUISERDESIGN") end
            if (id == nil and id_or_name == "CapitalShipDesign") then id = getglobal("CAPITALSHIPDESIGN") end
        end
        if (id == nil or type(id) ~= "number") then
            return nil
        end
        return id
    end

    function FSFC_IsResearchDone(id_or_name)
        local id = FSFC_ResolveID(id_or_name)
        if (id == nil) then return 0 end
        return IsResearchDone(id)
    end

    function FSFC_IsResearchAvailable(id_or_name)
        local id = FSFC_ResolveID(id_or_name)
        if (id == nil) then return 0 end
        return IsResearchAvailable(id)
    end

    function FSFC_CheckResearch(id_or_name)
        local id = FSFC_ResolveID(id_or_name)
        if (id == nil) then return nil end
        if (IsResearchDone(id) == 0 and IsResearchAvailable(id) == 1) then
            return id
        end
        return nil
    end

    -- Corrected order: FSFC_PickBestShip(fs2_variant, fs1_variant)
    function FSFC_PickBestShip(fs2_ship, fs1_ship)
        -- Fallback check for era_setting global which might be available in AI state
        local era = getglobal("era_setting")
        local picked = fs1_ship
        if (FSFC_IsResearchDone("FS2") == 1 or era == 1 or era == 2) then
            picked = fs2_ship
        end
        -- Final safety: if the picked one is nil, try the other one
        if (picked == nil) then
            picked = fs1_ship or fs2_ship
        end
        return picked
    end

    function FSFC_Log_Research(researchName)
        if (FSFC_ResearchLogged[researchName] == nil) then
            local time = gameTime() or 0
            print("[" .. floor(time) .. "s] [AI_DIAG] P" .. s_playerIndex .. " | RESEARCH | Target: " .. researchName)
            FSFC_ResearchLogged[researchName] = 1
        end
    end
    function FSFC_Log_Threat()
        if (FSFC_LastThreatTime == nil or gameTime() > FSFC_LastThreatTime + 30) then
            print("[AI_DIAG] P" .. s_playerIndex .. " | THREAT | Self: " .. s_selfTotalValue .. " | EnemyTotal: " .. s_enemyTotalValue .. " | TargetP: " .. s_enemyIndex)
            FSFC_LastThreatTime = gameTime()
        end
    end
    
    print("[AI_DIAG] Initialized for Player " .. s_playerIndex)

    -- Diagnostic: Dump numeric globals to find research IDs
    function FSFC_DumpGlobals()
        print("[AI_DIAG] Dumping numeric globals...")
        local count = 0
        local name, value = next(globals(), nil)
        while (name) do
            if (type(value) == "number" and value > 1000) then -- IDs are usually large numbers
                print("[AI_DIAG] G: " .. name .. " = " .. value)
                count = count + 1
            end
            if (count > 50) then break end -- Limit to avoid flooding
            name, value = next(globals(), name)
        end
    end
    -- FSFC_DumpGlobals() -- Uncommented for troubleshooting
end
