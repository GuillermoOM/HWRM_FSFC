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
    FSFC_ResearchAccum = {}       -- scratch: name -> demand, cleared per snapshot
    FSFC_LastDemandPrint = {}     -- per-player throttle for demand snapshot prints
    
    function FSFC_ShipDemandAdd(id, demand, label)
        if (id == nil or id == -1 or type(id) ~= "number") then return end
        ShipDemandAdd(id, demand)
    end

    function FSFC_ShipDemandSet(id, demand, label)
        if (id == nil or id == -1 or type(id) ~= "number") then return end
        ShipDemandSet(id, demand)
    end


    -- Print a snapshot of current demand values directly to the log.
    -- Called at the END of DetermineSpecialDemand. Throttled to once per 10s per player.
    -- NOTE: AI scripts and SCAR/rule scripts run in SEPARATE Lua scopes.
    --       Globals set here are NOT visible to telemetry.lua. Use print() only.
    function FSFC_WriteDemandSnapshot()
        local time = gameTime() or 0
        local p = s_playerIndex
        -- Throttle: skip if we already printed within the last 10 seconds for this player
        if (FSFC_LastDemandPrint[p] ~= nil and time - FSFC_LastDemandPrint[p] < 10) then
            return
        end
        FSFC_LastDemandPrint[p] = time
        -- Industrial Census
        local numCarriers1 = (kCarrier ~= nil and kCarrier ~= -1) and FSFC_NumSquadrons(kCarrier) or 0
        local numCarriers2 = (kCarrier2 ~= nil and kCarrier2 ~= -1) and FSFC_NumSquadrons(kCarrier2) or 0
        local numCarriers = numCarriers1 + numCarriers2
        local numShipyards = (kShipyard ~= nil and kShipyard ~= -1) and FSFC_NumSquadrons(kShipyard) or 0
        local ru = GetRU()
        local status = "SPENDING"
        if (ShipDemandMaxByClass(eFrigate) < 0) then
            status = "CAP_HIT"   -- eFrigate class suppressed, strike craft should be building
        elseif (ru > 50000 and ShipDemandMaxByClass(eFighter) < 1) then
            status = "STALLED"
        end

        print("[" .. floor(time) .. "s] [AI_DIAG] P" .. p .. " | ECON | RU: " .. floor(ru) .. " | Factories: " .. (numCarriers + numShipyards) .. " | Status: " .. status)

        -- Inline tostring(floor(v)) — no helper function needed, and local function is banned in Lua 4.0
        local coline = (kCollector ~= nil and kCollector ~= -1) and ShipDemandGet(kCollector) or 0
        local refline = (kRefinery ~= nil and kRefinery ~= -1) and ShipDemandGet(kRefinery) or 0
        local cvline1  = (kCarrier ~= nil and kCarrier ~= -1) and ShipDemandGet(kCarrier) or 0
        local cvline2  = (kCarrier2 ~= nil and kCarrier2 ~= -1) and ShipDemandGet(kCarrier2) or 0
        local cvline = cvline1 + cvline2
        local bcline  = (kBattleCruiser ~= nil and kBattleCruiser ~= -1) and ShipDemandGet(kBattleCruiser) or 0
        print("[" .. floor(time) .. "s] [AI_DIAG] P" .. p .. " DEMAND |"
            .. " F:"  .. tostring(floor(ShipDemandMaxByClass(eFighter)))
            .. " B:"  .. tostring(floor(ShipDemandMaxByClass(eCorvette)))
            .. " Fr:" .. tostring(floor(ShipDemandMaxByClass(eFrigate)))
            .. " De:" .. tostring(floor(ShipDemandMaxByClass(eDestroyer)))
            .. " Ca:" .. tostring(floor(ShipDemandMaxByClass(eCapital)))
            .. " Cv:" .. tostring(floor(cvline))
            .. " Bc:" .. tostring(floor(bcline))
            .. " Co:" .. tostring(floor(coline))
            .. " Re:" .. tostring(floor(refline)))
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
            if (id == nil and id_or_name == "CruiserHealthUpgrade") then id = getglobal("CRUISERHEALTHUPGRADE") end
            if (id == nil and id_or_name == "DeimosArmor") then id = getglobal("DEIMOSARMOR") end
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

    function FSFC_CheckResearch(id_or_name, shipID)
        local id = FSFC_ResolveID(id_or_name)
        local isCapitalTech = nil
        if (id == nil) then return nil end
        
        -- Redundancy check: If we already have the ship, we don't need to research its unlock node
        -- Bypassed for major warships/carriers to ensure the AI can upgrade starting flagships
        if (shipID and shipID ~= -1) then
            isCapitalTech = (id_or_name == "RAVANA" or id_or_name == "HECATE" or id_or_name == "MOLOCH" or id_or_name == "SOBEK" or id_or_name == "DEIMOS" or id_or_name == "LUCIFER" or id_or_name == "SATHANAS" or id_or_name == "COLOSSUS" or id_or_name == "HATSHEPSUT" or id_or_name == "TYPHON" or id_or_name == "ORION" or id_or_name == "JUGGERNAUT")
            if (isCapitalTech == nil) then
                if (FSFC_NumSquadrons(shipID) > 0) then
                    return nil
                end
            end
        end

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

        -- Accumulate into per-player scratch table for snapshot
        if (researchName ~= nil and researchName ~= "None") then
            local existing = FSFC_ResearchAccum[researchName]
            if (existing == nil or d > existing) then
                FSFC_ResearchAccum[researchName] = d
            end
        end
        
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

        -- Periodically emit current leader if enough time passed (Skip for Tactics nodes to reduce noise)
        if (time > FSFC_LastEmitTime + 10 and FSFC_TickHighestName ~= "TacticsDynamic" and FSFC_TickHighestName ~= "TacticsAggressive" and FSFC_TickHighestName ~= "TacticsDefensive") then
            if (FSFC_TickHighestName ~= "None") then
                print("[" .. floor(time) .. "s] [AI_DIAG] P" .. s_playerIndex .. " | RESEARCH | Target: " .. FSFC_TickHighestName)
                FSFC_LastLoggedName = FSFC_TickHighestName
                FSFC_LastEmitTime = time
            end
        end
    end

    -- Print accumulated research demand directly to the log.
    -- Called at end of DoUpgradeDemand_* so it fires after all FSFC_Log_Research calls this cycle.
    -- NOTE: Prints directly — AI and SCAR scopes are separate, globals aren't shared.
    function FSFC_WriteResearchSnapshot()
        local time = gameTime() or 0
        local p = s_playerIndex
        local MAX_RES_ENTRIES = 5
        -- Build sorted list using next() (no closure/upvalue capture — Lua 4.0 safe)
        local sorted = {}
        local rname = next(FSFC_ResearchAccum)
        while (rname ~= nil) do
            local demand = FSFC_ResearchAccum[rname]
            local inserted = 0
            local n = getn(sorted)
            for i = 1, n do
                if (demand > sorted[i].demand) then
                    tinsert(sorted, i, {name=rname, demand=demand})
                    inserted = 1
                    break
                end
            end
            if (inserted == 0) then
                tinsert(sorted, {name=rname, demand=demand})
            end
            rname = next(FSFC_ResearchAccum, rname)
        end
        -- Clear accumulator for next cycle
        FSFC_ResearchAccum = {}
        -- Only print if there was something accumulated
        local n = getn(sorted)
        if (n == 0) then return end
        if (n > MAX_RES_ENTRIES) then n = MAX_RES_ENTRIES end
        local out = ""
        for i = 1, n do
            out = out .. sorted[i].name .. ":" .. tostring(floor(sorted[i].demand * 10) / 10) .. " "
        end
        print("[" .. floor(time) .. "s] [AI_DIAG] P" .. p .. " RESEARCH_DEMAND | " .. out)
    end

    function FSFC_Log_Threat()
        if (FSFC_LastThreatTime == nil or gameTime() > FSFC_LastThreatTime + 30) then
            local targetP = -1
            local bestEnemy = s_enemyIndex
            if (bestEnemy == nil or bestEnemy == -1) then
                bestEnemy = player_enemy
            end
            if (bestEnemy ~= nil and bestEnemy >= 0 and bestEnemy < 8) then
                targetP = bestEnemy
            end
            print("[AI_DIAG] P" .. s_playerIndex .. " | THREAT | Self: " .. (s_selfTotalValue or 0) .. " | EnemyTotal: " .. (s_enemyTotalValue or 0) .. " | TargetP: " .. targetP)
            FSFC_LastThreatTime = gameTime()
        end
    end
    
    function FSFC_NumSquadrons(shipID)
        if (shipID == nil or type(shipID) ~= "number") then return 0 end
        return NumSquadrons(shipID)
    end

    function FSFC_NumSquadronsQ(shipID)
        if (shipID == nil or type(shipID) ~= "number") then return 0 end
        return NumSquadronsQ(shipID)
    end

    function FSFC_Log_Completed(id_or_name, label)
        local name = label or id_or_name
        if (id_or_name == "FIGHTERDESIGN" or id_or_name == "BOMBERDESIGN") then
            local id = FSFC_ResolveID(id_or_name)
            local done = 0
            if (id) then done = IsResearchDone(id) end
            print("[AI_DIAG] P" .. s_playerIndex .. " | DEBUG_COMPLETED | Name: " .. name .. " | ID: " .. tostring(id) .. " | Done: " .. tostring(done))
        end
        if (FSFC_ResearchLogged[name] == nil and FSFC_IsResearchDone(id_or_name) == 1) then
            print("[" .. floor(gameTime() or 0) .. "s] [AI_DIAG] P" .. s_playerIndex .. " | RESEARCH | Completed: " .. name)
            FSFC_ResearchLogged[name] = 1
        end
    end

    -- Standardized table processor for AI research
    function FSFC_ProcessResearchTable(tbl, baseDemand)
        if (tbl == nil) then return end
        local n = getn(tbl)
        for i=1, n do
            local item = tbl[i]
            local id = FSFC_CheckResearch(item.id)
            if (id and baseDemand > 0) then
                local demand = baseDemand + (item.priority or 0)
                ResearchDemandSet(id, demand)
                if (item.name) then
                    FSFC_Log_Research(item.name, demand)
                end
            elseif (item.name) then
                -- If not available for research, check if it was completed
                FSFC_Log_Completed(item.id or item.name, item.name)
            end
        end
    end
    
    print("[AI_DIAG] Initialized for Player " .. s_playerIndex)
end
