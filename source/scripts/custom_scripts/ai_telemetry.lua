-- FSFC AI Telemetry Helper
-- Engine functions AI_Log_Demand/Research are protected and internally broken (use nil 'format').
-- We use FSFC_ prefixed versions to avoid conflicts.

if not AI_Telemetry_Loaded then
    AI_Telemetry_Loaded = 1

    FSFC_ResearchLogged = {}
    
    function FSFC_Log_Demand(label, demand)
        -- Throttled: Only log high-priority build desires
        if (demand > 2.5) then
            print("[AI_DIAG] P" .. s_playerIndex .. " | WANT | " .. label .. " | Demand: " .. demand)
        end
    end

    function FSFC_Log_Research(researchName)
        if (FSFC_ResearchLogged[researchName] == nil) then
            print("[AI_DIAG] P" .. s_playerIndex .. " | RESEARCH | Target: " .. researchName)
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
end
