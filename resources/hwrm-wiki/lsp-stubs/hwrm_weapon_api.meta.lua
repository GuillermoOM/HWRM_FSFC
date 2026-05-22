---@meta
-- Homeworld Remastered - Weapon API Stub
-- Use this file with LuaLS in VS Code to enable autocompletion and linting for .wepn files.

---@class WeaponType
NewWeaponType = {}

---Initializes a new weapon configuration.
---@param WeaponType WeaponType The global weapon object
---@param Type "Gimbal" | "AnimatedTurret" | "Fixed"
---@param FireType "InstantHit" | "Bullet" | "Mine" | "Missile" | "SphereBurst"
---@param FireName string The weaponfire effect name
---@param Activation "Normal" | "Special Attack" | "Normal Only" | "Dropped"
---@param FireSpeed number
---@param FireRange number Maximum firing range
---@param FireRadius number
---@param FireLifetime number
---@param FireMisc number
---@param FireAxis "0" | "1" | "2"
---@param MaxEffectsSpawned number
---@param UseVelocityPred "1" | "0"
---@param CheckLineOfFire "1" | "0"
---@param FireTime number
---@param BurstFireTime number
---@param BurstWaitTime number
---@param ShootAtSecondaries "1" | "0"
---@param ShootAtSurroundings "1" | "0"
---@param MaxAzimuthSpeed number
---@param MaxDeclinationSpeed number
---@param SpeedMultiplierWhenPointingAtTarget number
---@param WeaponShieldPenetration "Normal" | "Enhanced" | "Bypass"
---@param TrackTargetsOutsideRange "1" | "0"
---@param WaitUntilCodeRedState "1" | "0"
---@param InstantHitThreshold number
function StartWeaponConfig(WeaponType, Type, FireType, FireName, Activation, FireSpeed, FireRange, FireRadius, FireLifetime, FireMisc, FireAxis, MaxEffectsSpawned, UseVelocityPred, CheckLineOfFire, FireTime, BurstFireTime, BurstWaitTime, ShootAtSecondaries, ShootAtSurroundings, MaxAzimuthSpeed, MaxDeclinationSpeed, SpeedMultiplierWhenPointingAtTarget, WeaponShieldPenetration, TrackTargetsOutsideRange, WaitUntilCodeRedState, InstantHitThreshold) end

---Adds an outcome to a weapon hit or miss.
---@param WeaponType WeaponType
---@param Condition "Hit" | "Miss"
---@param Effect "DamageHealth" | "Disable" | "Push" | "SpawnWeaponFire"
---@param Target "Target" | "Owner"
---@param MinimumEffect number
---@param MaximumEffect number
---@param SpawnedWeaponEffect string
function AddWeaponResult(WeaponType, Condition, Effect, Target, MinimumEffect, MaximumEffect, SpawnedWeaponEffect) end

---Sets the firing angles for a gimbal or turret weapon.
---@param WeaponType WeaponType
---@param TriggerHappy number Defaults to 90
---@param MinAzimuth number
---@param MaxAzimuth number
---@param MinDeclination number
---@param MaxDeclination number
function setAngles(WeaponType, TriggerHappy, MinAzimuth, MaxAzimuth, MinDeclination, MaxDeclination) end

---Sets recoil and slave delay for the weapon.
---@param WeaponType WeaponType
---@param RecoilDistance number
---@param SlaveFireDelay number
function setMiscValues(WeaponType, RecoilDistance, SlaveFireDelay) end

---Defines weapon penetration logic against armor types.
---@param WeaponType WeaponType
---@param Multiplier number Global modifier (usually 1)
---@param Unknown number Usually 1
---@param ... table Arrays of armor families and their penetration multiplier { LightArmour = 1.0 }
function setPenetration(WeaponType, Multiplier, Unknown, ...) end

---Defines weapon accuracy logic against armor types.
---@param WeaponType WeaponType
---@param Multiplier number Global modifier (usually 1)
---@param ... table Arrays of armor families and their hit chance { Fighter = 0.3 }
function setAccuracy(WeaponType, Multiplier, ...) end
