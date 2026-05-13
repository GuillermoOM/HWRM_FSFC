-- FSFC AI Telemetry Helper
-- Engine functions AI_Log_Demand/Research are protected and internally broken (use nil 'format').
-- We use FSFC_ prefixed versions to avoid conflicts.

if not AI_Telemetry_Loaded then
    AI_Telemetry_Loaded = 1

    FSFC_ResearchLogged = {}
    FSFC_LastLoggedName = "None"
    FSFC_LastEmitTime = 0
    FSFC_LastResearchTime = -100
    FSFC_TickHighestDemand = 0
    FSFC_TickHighestName = "None"
    
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

    function FSFC_Log_Research(researchName, demand)
        local time = gameTime() or 0
        local d = demand or 1.0
        
        -- If this is a new tick, reset the high watermark
        if (floor(time) ~= floor(FSFC_LastResearchTime)) then
            -- Log the winner of the PREVIOUS tick if it wasn't logged yet
            if (FSFC_TickHighestName ~= "None" and FSFC_TickHighestName ~= FSFC_LastLoggedName) then
                print("[" .. floor(FSFC_LastResearchTime) .. "s] [AI_DIAG] P" .. s_playerIndex .. " | RESEARCH | Target: " .. FSFC_TickHighestName)
                FSFC_LastLoggedName = FSFC_TickHighestName
            end
            
            FSFC_TickHighestDemand = d
            FSFC_TickHighestName = researchName
            FSFC_LastResearchTime = time
        elseif (d > FSFC_TickHighestDemand) then
            FSFC_TickHighestDemand = d
            FSFC_TickHighestName = researchName
        end

        -- Periodically emit current leader if enough time passed
        if (time > FSFC_LastEmitTime + 10) then
            if (FSFC_TickHighestName ~= "None") then
                print("[" .. floor(time) .. "s] [AI_DIAG] P" .. s_playerIndex .. " | RESEARCH | Target: " .. FSFC_TickHighestName)
                FSFC_LastLoggedName = FSFC_TickHighestName
                FSFC_LastEmitTime = time
            end
        end
    end

    function FSFC_Log_Threat()
        if (FSFC_LastThreatTime == nil or gameTime() > FSFC_LastThreatTime + 30) then
            print("[AI_DIAG] P" .. s_playerIndex .. " | THREAT | Self: " .. s_selfTotalValue .. " | EnemyTotal: " .. s_enemyTotalValue .. " | TargetP: -1")
            FSFC_LastThreatTime = gameTime()
        end
    end
    
    print("[AI_DIAG] Initialized for Player " .. s_playerIndex)
end
