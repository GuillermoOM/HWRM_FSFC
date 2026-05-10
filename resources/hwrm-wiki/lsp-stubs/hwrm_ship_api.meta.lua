---@meta
-- Homeworld Remastered - Ship API Stub
-- Use this file with LuaLS in VS Code to enable autocompletion and linting for .ship files.

---@class ShipType
NewShipType = {}

---Initializes a new ship configuration.
---@param ShipType ShipType
---@param EngineType "Engine_Fighter" | "Engine_Corvette" | "Engine_Frigate" | "Engine_CapShip"
---@param CombatType "Combat_Fighter" | "Combat_Corvette" | "Combat_Frigate" | "Combat_CapShip"
---@param DeathType "Death_Fighter" | "Death_Corvette" | "Death_Frigate" | "Death_CapShip"
---@param SelectionType "Selection_Fighter" | "Selection_Corvette" | "Selection_Frigate" | "Selection_CapShip"
function StartShipConfig(ShipType, EngineType, CombatType, DeathType, SelectionType) end

---Loads the 3D model for the ship. MUST BE CALLED BEFORE WEAPONS/HARDPOINTS.
---@param ShipType ShipType
---@param Unknown number Usually 1
function LoadModel(ShipType, Unknown) end

---Adds a tactical multiplier to the ship (e.g. higher speed in Aggressive tactics).
---@param ShipType ShipType
---@param Tactic "TacticsConfig"
---@param Stance "Aggressive" | "Defensive" | "Passive"
---@param Property "Speed" | "WeaponAccuracy" | "WeaponDamage"
---@param Multiplier number
function setTacticsMults(ShipType, Tactic, Stance, Property, Multiplier) end

---Initializes a weapon hardpoint on the ship.
---@param ShipType ShipType
---@param HardpointName string
---@param WeaponFileName string
---@param WeaponLocation string
function StartShipWeaponConfig(ShipType, HardpointName, WeaponFileName, WeaponLocation) end

---Initializes a subsystem hardpoint on the ship.
---@param ShipType ShipType
---@param HardpointName string
---@param SubSystemFileName string
---@param SubSystemLocation string
function StartShipHardPointConfig(ShipType, HardpointName, SubSystemFileName, SubSystemLocation) end

---Adds a standard ability to the ship.
---@param ShipType ShipType
---@param Ability "MoveCommand" | "AttackCommand" | "DockCommand" | "ParadeCommand" | "HyperspaceCommand"
---@param ... any Additional parameters depending on the ability
function addAbility(ShipType, Ability, ...) end

---Spawns salvage/debris when the ship dies.
---@param ShipType ShipType
---@param SalvageName string
---@param Probability number
---@param Count number
---@param OffsetX number
---@param OffsetY number
---@param OffsetZ number
function SpawnSalvageOnDeath(ShipType, SalvageName, Probability, Count, OffsetX, OffsetY, OffsetZ) end
