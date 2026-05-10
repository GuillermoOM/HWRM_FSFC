---@meta
-- Homeworld Remastered - AI API Stub
-- Use this file with LuaLS in VS Code to enable autocompletion and linting for AI scripts.

---@param msg string Debug message to print to HwRM.log
function aitrace(msg) end

---Gets the current game time in seconds.
---@return number
function gameTime() end

---Returns random number between min and max.
---@param min number
---@param max number
---@return number
function sg_random(min, max) end

---Adds demand to build a specific ship.
---@param shipName string | number The all-caps global ID or string name
---@param amount number
function ShipDemandAdd(shipName, amount) end

---Adds demand to build ships of a specific class.
---@param className "Fighter" | "Corvette" | "Frigate" | "Capital"
---@param amount number
function ShipDemandAddByClass(className, amount) end

---Gets current demand value for a ship.
---@param shipName string | number
---@return number
function ShipDemandGet(shipName) end

---Checks if a specific research is complete. Will crash if ID is invalid.
---@param researchId number
---@return number 1 if done, 0 if not
function IsResearchDone(researchId) end

---Checks if a specific research is available to start. Will crash if ID is invalid.
---@param researchId number
---@return number 1 if available, 0 if not
function IsResearchAvailable(researchId) end

---Adds demand to research an upgrade.
---@param researchId number
---@param amount number
function ResearchDemandAdd(researchId, amount) end

---Gets number of active squadrons of a given type.
---@param shipId number | string
---@return number
function NumSquadrons(shipId) end

---Returns the AI player's index.
---@return number
function Player_Self() end

---Returns current difficulty level (0=Easy, 1=Medium, 2=Hard).
---@return number
function getLevelOfDifficulty() end
