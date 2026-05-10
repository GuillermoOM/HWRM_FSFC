-- FSFC UI Management
-- Handles hiding/showing UI elements based on race and game state

function FSFC_UpdateUIForRace()
    local playerIndex = Universe_CurrentPlayer()
    if (playerIndex == -1) then return end

    local racePrefix = strsub(PlayerRace_GetString(playerIndex, "Prefix", ""), 1, 3)

    -- FS Races (Terran, Vasudan, Shivan) use consolidated categories:
    -- Fighter, Bomber, Cruiser, Capital, Utility, NonCombat
    -- Legacy HWRM categories like Corvette, Frigate, and Platform are unused.

    if (racePrefix == "TER" or racePrefix == "VAS" or racePrefix == "SHI") then
        UI_SetElementVisible("NewBuildMenu", "Corvette", 0)
        UI_SetElementVisible("NewResearchMenu", "Corvette", 0)
        UI_SetElementVisible("NewBuildMenu", "Frigate", 0)
        UI_SetElementVisible("NewResearchMenu", "Frigate", 0)
    end
end
