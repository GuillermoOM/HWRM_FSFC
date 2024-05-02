--
-- Finds and attacks missiles of any player not us.
-- Maybe scan for enemy missiles instead of disregarding player missiles.
function findAndAttackEnemyMissiles(CustomGroup, playerID, shipID)
    local numberEnemyMissiles = 0
    local friendlyplayers = {}
    local numplayers = Universe_PlayerCount() - 1
    for x = 0, numplayers, 1 do
        if (AreAllied(playerID, x) == 1) then
            friendlyplayers[x] = 1
        else
            friendlyplayers[x] = 0
        end
    end
    friendlyplayers[playerID] = 1
    Selection_Create("AllMissiles")
    if (Selection_GetMissiles("AllMissiles") > 0) then
        --get nearby missiles
        Selection_Create("IncomingMissiles")
        --...should not attack allied missiles either
        for x = 0, numplayers, 1 do
            if (Selection_FilterInclude("IncomingMissiles", "AllMissiles", "PlayerOwner", "" .. x, "") > 0) and friendlyplayers[x] == 0 then
                local defensePoint = SobGroup_GetPosition(CustomGroup)
                local defensePointString = defensePoint[1] .. "," .. defensePoint[2] .. "," .. defensePoint[3]
                Selection_Create("IncomingMissiles")
                numberEnemyMissiles = Selection_FilterInclude("IncomingMissiles", "IncomingMissiles", "NearPoint",
                    defensePointString, "" .. 5000)

                --We only attack enemy missiles when the selection of nearby missiles changes.
                --Rather than compare the list of local missiles, just cache the number of local missiles.
                if (numberEnemyMissiles > 0) then
                    --print("updateDefenseFighterAttack: shipID "..shipID.." "..numberEnemyMissiles.." missiles nearby")
                    if (defenseFighterMissileTargets[shipID] ~= numberEnemyMissiles) then
                        --print("updateDefenseFighterAttack: shipID "..shipID.." attacking "..numberEnemyMissiles.." missiles")
                        defenseFighterMissileTargets[shipID] = numberEnemyMissiles
                        SobGroup_AttackSelection(playerID, CustomGroup, "IncomingMissiles")
                        break
                    end
                end
            end
        end
    end
    return numberEnemyMissiles
end

--
-- Update a defense fighter that's guarding someone.
--
function updateDefenseFighterDefense(CustomGroup, playerID, shipID)
    --print("updateDefenseFighterDefense: shipID "..shipID)
    local guardGroup = "defenseFighterGuardTargets"
    local guardGroupPlusMe = "defenseFighterGuardTargetsPlusMe"
    local guardGroupAttackers = "defenseFighterGuardTargetAttackers"
    SobGroup_CreateIfNotExist(guardGroup)
    SobGroup_CreateIfNotExist(guardGroupAttackers)

    Selection_Create("AllMissiles")
    if (Selection_GetMissiles("AllMissiles") > 0) then
        --print("updateDefenseFighterDefense: DETECTED missiles")
        SobGroup_GetCommandTargets(guardGroup, CustomGroup, COMMAND_Guard)
        if (SobGroup_Count(guardGroup) > 0) then
            SobGroup_CreateIfNotExist(guardGroupPlusMe)
            SobGroup_Copy(guardGroupPlusMe, guardGroup)
            SobGroup_SobGroupAdd(guardGroupPlusMe, CustomGroup)

            --print("updateDefenseFighterDefense: we're guarding someone")
            SobGroup_GetAttackers(guardGroupPlusMe, guardGroupAttackers)
            if (SobGroup_Count(guardGroupAttackers) > 0) then
                local enemyPlayerID = SobGroup_GetPlayerOwner(guardGroupAttackers);
                --print("updateDefenseFighterDefense: player "..enemyPlayerID.." is attacking")
                --
                --somebody's attacking our guard target: find their missiles and kill them
                --
                Selection_Create("IncomingMissiles")
                if (Selection_FilterInclude("IncomingMissiles", "AllMissiles", "PlayerOwner", "" .. enemyPlayerID, "") > 0) then
                    --print("updateDefenseFighterDefense: attacking INCOMING missiles.")
                    -- Save the current guard targets for later use
                    SobGroup_CreateIfNotExist("DefenseFighterGuardTargets" .. shipID)
                    SobGroup_Copy("DefenseFighterGuardTargets" .. shipID, guardGroup)
                    SobGroup_AttackSelection(playerID, CustomGroup, "IncomingMissiles")
                end
            else
                --
                -- nobody attacking: see if there are missiles or mines in the area
                --
                local numberEnemyMissiles = findAndAttackEnemyMissiles(CustomGroup, playerID, shipID)
                if (numberEnemyMissiles == 0) then
                    --
                    -- no nearby missiles: just defend our defend target
                    --
                    if (SobGroup_Count("DefenseFighterGuardTargets" .. shipID) > 0) then
                        SobGroup_GuardSobGroup(CustomGroup, "DefenseFighterGuardTargets" .. shipID)
                        SobGroup_Clear("DefenseFighterGuardTargets" .. shipID)
                    end
                end
            end
        end
    end
end

--
-- Interceptor bomb prosecution logic.
-- If attacking ships, find neadby missiles.  If missiles changed, attack them.
-- If no missiles, try to go to guarding those who aree being attacked.
--
defenseFighterMissileTargets = {}
function updateDefenseFighterAttack(CustomGroup, playerID, shipID)
    --print("updateDefenseFighterAttack: shipID "..shipID)

    --get attack targets
    local attackGroup = "defenseFighterAttackTargets"
    SobGroup_CreateIfNotExist(attackGroup)
    SobGroup_GetCommandTargets(attackGroup, CustomGroup, COMMAND_Attack)
    if (SobGroup_Count(attackGroup) == 0) then
        --print("updateDefenseFighterAttack: shipID "..shipID.." attacking nobody.  Maybe attacking missiles?")
        return
    end
    local numberEnemyMissiles = findAndAttackEnemyMissiles(CustomGroup, playerID, shipID)
end

dofilepath([[data:scripts/custom_scripts/ABFix.lua]])
i = 0
function updateInterceptor(CustomGroup, playerID, shipID)
    --print("updateInterceptor: shipID "..shipID.."CurrentOrder = "..SobGroup_GetCurrentOrder(CustomGroup))
    if SobGroup_GetROE(CustomGroup) == 1 then
        if (SobGroup_GetCurrentOrder(CustomGroup) == COMMAND_Guard) then
            updateDefenseFighterDefense(CustomGroup, playerID, shipID)
        else
            updateDefenseFighterAttack(CustomGroup, playerID, shipID)
        end
    end
    i = i + 1
    if i >= 3 then
        AfterburnerFix(CustomGroup, playerID, shipID)
        i = 0
    end
end
