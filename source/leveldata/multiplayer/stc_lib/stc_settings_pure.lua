----------------------------------------------------------------------------------------------------
-- SETTINGS - The Magic Land of All Global Constants
----------------------------------------------------------------------------------------------------
-- 
----------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------
-- RACE ASSIGNMENT
----------------------------------------------------------------------------------------------------
Hiigaran = 1
Vaygr = 2
Federation = 3
Klingon = 4
Random = 5
Romulan = 6
Auxiliary = 7


----------------------------------------------------------------------------------------------------
-- WARP FX SETTINGS
----------------------------------------------------------------------------------------------------
-- Race specific Warp FX assignment
-- Defines which FX and SFX to play when a ship of a certain race enters or leaves warp.
-- Every entry contains of:
-- [FX prefix]
-- 1
-- 
-- FX prefix : Can be one of the following: fed, kng, rom, brg, dom, car
-- NOTE: For every race prefix in shipClassStatsTable (see end of this file) there must be an entry here!
WARP_RaceFXTable = {
fed	= "fed",
kng	= "kng",
rom	= "rom",
brg	= "brg",
dom	= "dom",
car	= "car",
grn	= "car",
fer	= "car",
}

-- Warp FX Offsets
-- Homeworld 2 is a bit imprecise concerning hyperspace times... we have to trigger the different FX
-- at indvidual times that they match ingame.
-- For best results also adjust the hyperspace effects time in race.lua!
-- NOTE:
-- 1. We calculate in 1/10 seconds here, so for example 4 means 0.4 seconds.
-- 2. DO NOT USE DECIMALS HERE! Decimals are not calculated 100% correctly by HW2!
-- 3. 2 <= Offset_Out < 1000
--    0 <= Offset_In  < 1000
--    The warp out offets must be at least 2! Otherwise it could happen that the FX start when we
--    try to warp inside a hyperspace inhibitor field, although - of course - we cannot go at warp.
--    That's why the hyperspace effects time in race.lua is not set at 1 but slightly larger.
--
-- Access the offsets using: warpOffsetTable[globalShipTable["Player"..i][j][Race]][XXX]
--
-- The following table must contain a sub-table for every race specified in shipInfoTable. The
-- name has to be the race prefix. The values in the sub-table are:
-- [1] - mad_Offset_Out
-- [2] - gfx_Offset_Out
-- [3] - sfx_Offset_Out
-- [4] - mad_Offset_In -- this should be greater than 0 that the whole mesh animation can be seen ingame!
-- [5] - gfx_Offset_In
-- [6] - sfx_Offset_In
WARP_FXOffsetTable = {
fed = { 2, 9, 2, 0, 0, 0},
kng = { 2, 9, 9, 0, 0, 0},
rom = { 2, 9, 2, 0, 0, 0},
brg = { 2, 9, 2, 0, 0, 0},
dom = { 2, 9, 2, 0, 0, 0},
car = { 2, 9, 2, 0, 0, 0},
grn = { 2, 9, 2, 0, 0, 0},
fer = { 2, 9, 2, 0, 0, 0},
}

-- Warp FX Scale
-- Scales the visible effects played when warping
WARP_FXScale = 1.5

-- Warp Recovery Time
-- Time needed to recover warp AFTER the warp jump has been finished (in 1/10 seconds)
WARP_RecoveryTime = 600


----------------------------------------------------------------------------------------------------
-- SHIELD FX SETTINGS
----------------------------------------------------------------------------------------------------
-- shieldHealthPercentage : health percentage when shields are activated or deactivated / hull strength
-- cloakTimerTable        : contains race specific timers for shield reactivation after cloak (in 1/10 seconds)
ShieldHealthPercentage = 0.25
cloakTimerTable = {
fed	= 60,
kng	= 50,
rom	= 10,
}


----------------------------------------------------------------------------------------------------
-- KEEPER SETTINGS
----------------------------------------------------------------------------------------------------
-- KeeperUpdateCycles             : All Keepers are only updated every 'KeeperUpdateCycles' game cycles (1/10 seconds)
-- KeeperRegenerationAmount       : Percentage points (x100) that keepers will regenerate per keeper cycle (only if not under attack)
-- KeeperKamikazeHealthPercentage : Keepers will switch to kamikaze attack, if health is below this
-- KeeperKamikazeSpeedBoost       : Speed boost for Keepers when doing kamikaze attack
KeeperUpdateCycles = 20
KeeperRegenerationAmount = 0.1
KeeperKamikazeHealthPercentage = 0.2
KeeperKamikazeSpeedBoost = 5

-- Keeper Information Table
-- Every entry contains of:
-- [ShipName], { [RetaliationRange], [Kamikaze], [ChangeSide] }
-- RetaliationRange : Keepers will scan for enemies within this distance
-- Kamikaze         : If set to 1, a Keeper can do kamikaze attack
-- ChangeSide       : If set to 1, a Keeper can change sides
KeeperDefault = {15000,	0, 0}

KeeperInfoTable = {
{"aux_TNG_BRG_cube", {15000, 0, 0},},
{"aux_TNG_CAR_hutet", {15000, 1, 0},},
{"aux_TNG_CAR_galor", {15000, 1, 1},},
}


----------------------------------------------------------------------------------------------------
-- BLACK HOLE SETTINGS
----------------------------------------------------------------------------------------------------
-- BlackholeUpdateCycles : All black holes are only updated every 'BlackholeUpdateCycles' game cycles (1/10 seconds)
-- BlackholedamageRadii  : [1] = Radius, [2] = Damage
-- 
-- NOTE: The black hole attacks enemies within the first damage radius.
-- NOTE: 'BlackholedamageRadii' work differently to the old explosion damage script: The damages
--       aren't additive! All ships from 15 km to 10 km gain 1000 damage every second, all ships
--       from 10 km to 7.5 km gain 6000 damage, etc.
-- NOTE: 'BlackholedamageRadii' must be sortet! Largest radius first!
BlackholeUpdateCycles = 10
BlackholeDamageRadii = {
{ 35000,      50},
{ 25000,     100},
{ 20000,     200},
{ 16000,     400},
{ 12000,    8000},
{ 10000,   16000},
{  8000,   32000},
}


----------------------------------------------------------------------------------------------------
-- DOMINION ALLIANCE SETTINGS
----------------------------------------------------------------------------------------------------
-- Alliance research
-- Name of the research item which unlocks the Dominion Alliance.
-- NOTE: Needs to be identical and available to all races
ALLIANCE_research = "dominion_alliance"

-- Taxes settings
-- fee         : Basis amount of RU, which is debited every ALLIANCE_feeInterval
-- feeInterval : Time in seconds after which fee and penalties are taken from the player (only natural numbers, no floating-point)
-- feeIncrease : The fee will mutliplied by this factor each ALLIANCE_feeInterval. 1.00 means a constant fee.
ALLIANCE_fee = 100
ALLIANCE_feeInterval = 60
ALLIANCE_feeIncrease = 1.10

-- Add Ship Interval
-- Time in seconds after which ships are given to the player (only natural numbers, no floating-point)
-- NOTE: should be coprime to ALLIANCE_fee. Otherwise subtitles could be overwritten.
ALLIANCE_addShipInterval = 37

-- Alliance Ship Class Table
-- Determines ship classes and its penalties. Also allows to group ship classes for later use in
-- ALLIANCE_levels (see below).
-- Every entry contains of:
-- [class], [penalty]
-- 
-- class   : name of a ship class (e.g. aux_TNG_DOM_bugship)
-- penalty : amount of RU which is taken from the player on ship death
ALLIANCE_shipClasses = {}
ALLIANCE_shipClasses[1] = {
	{ class = "aux_TNG_DOM_fighter", penalty = 10 },
}
ALLIANCE_shipClasses[2] = {
	{ class = "aux_TNG_DOM_bugship", penalty = 50 },
	{ class = "aux_TNG_CAR_hideki", penalty = 50 },
}
ALLIANCE_shipClasses[3] = {
	{ class = "aux_TNG_BRN_warship", penalty = 100 },
	{ class = "aux_TNG_CAR_galor", penalty = 100 },
	{ class = "aux_TNG_CAR_keldon", penalty = 100 },
	{ class = "aux_TNG_DOM_warship", penalty = 100 },
}
ALLIANCE_shipClasses[4] = {
	{ class = "aux_TNG_DOM_carrier", penalty = 500 },
	{ class = "aux_TNG_DOM_dreadnought", penalty = 1000 },
	{ class = "aux_TNG_CAR_hutet", penalty = 1000 },
}

-- Alliance Levels
-- Allows to determine how many and which ship classes will be given to the player depending on the
-- amount of RU the player has given to the Dominion.
-- Every entry contains of:
-- [feeSpent], [enemyStrengthMultiplier], [classProb]
-- 
-- feeSpent                : amount of RU in total the player must have given to the Dominion to
--                           reach this level
-- enemyThreat             : how much enemy threat there must be that this level is reached
--                           (overwrites feeSpent). This is used if the alliance is engaged
--                           in late game, hence hundreds of figher craft would be added to 
--                           compensate for a single capital ship.
-- enemyStrengthMultiplier : factor to multiply enemy strength with. The Dominion will give the
--                           player ships until he is as strong as:
--                                       strongest_player * enemyStrengthMultiplier
--                           1.0 means the player will be made as strong as the strongest enemy
--                           player. The higher this value, the stronger is the player.
-- classProb               : Table of probabilities to add a ship out of the different groups
--                           defined in ALLIANCE_shipClasses (see above). The sum over all values
--                           must be 1.
-- NOTE: must be sorted in ascending order with respect to feeSpent!
ALLIANCE_levels = {
	{ feeSpent =      0, enemyThreat =       0, enemyStrengthMultiplier = 1.00, classProb = {0.50, 0.50, 0.00, 0.00} },
	{ feeSpent =   1000, enemyThreat =  250000, enemyStrengthMultiplier = 1.00, classProb = {0.40, 0.40, 0.20, 0.00} },
	{ feeSpent =  10000, enemyThreat =  800000, enemyStrengthMultiplier = 1.10, classProb = {0.30, 0.30, 0.30, 0.10} },
	{ feeSpent =  50000, enemyThreat = 2000000, enemyStrengthMultiplier = 1.20, classProb = {0.20, 0.25, 0.40, 0.15} },
	{ feeSpent = 100000, enemyThreat = 6000000, enemyStrengthMultiplier = 1.30, classProb = {0.10, 0.20, 0.50, 0.20} },
}

-- Alliance Subtitle Icon
-- Icon to be used for subtitles (see DATA:/UI/Subtitle.lua)
ALLIANCE_subtitleIcon = 12

-- Alliance Subtitles
-- Allows to determine different subtitles at specific events. If there is more than one subtitle
-- per event it will be randomly chosen.
ALLIANCE_subtitleTable = {
	-- showed when the player has clicked on the alliance research item (DISABLED for now - Stargazer)
	-- start = {
		-- "An Alliance would be a wonderful idea!",
	-- },
	-- showed when the alliance research has finished/the alliance been established
	welcome = {
		"Welcome to the Dominion!",
	},
	-- showed when the fee and penalties are taken from the player
	collectFee = {
		"Time for your payments commander. It's worth it!",
		"For the Dominion.",
		"All hail the founders.",
		"The founders will be grateful for these resources.",
	},
	-- showed when the player doesn't have enough RU to pay the fee
	notEnoughRU = {
		"Hmm, that's... not the sum we agree upon. We do not take this sort of offense lightly.",
	},
	-- showed when ships are given to the player
	addShips = {
		"The founders are grateful for your contribution, and here is theirs.",
	},
	-- showed when the alliance breaks (shortly after there're not enough RU)
	allianceBreak = {
		"Feel the power of the Dominion!",
	},
	-- showed every now end then when the Dominion tries to eradicate the - now hostile - player
	evilLoop = {
		"Feel the power of the Dominion!",
		"Next time you will think twice!",
		"You are nothing!",
		"The founders are not amused!",
		"You will die!",
	},
	-- showed when the Dominion was defeated by the player
	dominionDefeated = {
		"The Dominion has endured for 2000 years! This is just a setback! We'll be back!",
	},
	-- showed (to all players) when the Dominion killed the player
	dominionWon = {
		"Never displease the founders.",
	},
}


----------------------------------------------------------------------------------------------------
-- SUBSYSTEM SETTINGS
----------------------------------------------------------------------------------------------------
-- Subsystem Animation Table
-- Every entry contains of:
-- [Hardpoint], [MadState], [ShipType]
-- 
-- If a ship of [ShipType] has built a subsystem mounted on [Hardpoint], the [MadState] is set for 
-- the ship.
-- NOTE: Each subsystem has to be mounted on an individual hardpoint to have subsystem specific 
--       Mad animations. Best to name the Hardpoint equal to the subsystem
-- NOTE: The shipType table entry can be a comma seperated list of shipTypes. Then all ships of
--       the list will play an animation when the subsystem is build.
subsystemAnimTable = 
{
	{"fed_TNG_nebula_sensordish", "ResourceStart", "fed_TNG_nebula"},
	{"fed_TNG_nebula_nacelles", "ResourceDo", "fed_TNG_nebula"},
	{"fed_TNG_nebula_torpbattery", "ResourceEnd", "fed_TNG_nebula"},
	{"fed_TMP_miranda_sensors", "ResourceStart", "fed_TMP_miranda"},
	{"fed_TMP_miranda_cannons", "ResourceDo", "fed_TMP_miranda"},
	{"fed_TMP_miranda_rollbar", "ResourceEnd", "fed_TMP_miranda"},
	{"fed_TMP_excelsior_refit", "ResourceStart", "fed_TMP_excelsior"},
}
-- if the subsystem is detroyed or retired this state is set to reset subsystems
subsystemAnimResetMadstate = "NIS02"

-- Subsystem Ability Table
-- Every entry contains of:
-- [Hardpoint], [Ability], [ShipType], [Research]
-- 
-- If a ship of [ShipType] has built a subsystem mounted on [Hardpoint] and completed [Research],
-- the [Ability] is activated for the ship.
-- NOTE: Each subsystem has to be mounted on an individual hardpoint to have subsystem specific 
--       Abilities. Best to name the Hardpoint equal to the subsystem
-- NOTE: The shipType table entry can be a comma seperated list of shipTypes. Then all ships of
--       the list will play an animation when the subsystem is build.
subsystemAbilityTable = 
{
	{"fed_TNG_nebula_nacelles", AB_Mine, "fed_TNG_nebula", "Antimatter_Mines"},
}

-- Subsystem Weapon Table
-- Every entry contains of:
-- [Hardpoint], [WeaponJointTable], [ShipType]
-- 
-- If a ship of [ShipType] has built a subsystem mounted on [Hardpoint], the weapons mounted on
-- [WeaponJointTable] are activated on the ship.
-- NOTE: Each subsystem has to be mounted on an individual hardpoint to have subsystem specific 
--       Abilities. Best to name the Hardpoint equal to the subsystem
-- NOTE: The shipType table entry can be a comma seperated list of shipTypes. Then all ships of
--       the list will play an animation when the subsystem is build.
subsystemWeaponTable = 
{
	{"fed_TMP_miranda_cannons", {"Weapon_Cannon_Port", "Weapon_Cannon_Starboard"}, "fed_TMP_miranda"},
}


----------------------------------------------------------------------------------------------------
-- RESEARCH SETTINGS
----------------------------------------------------------------------------------------------------
-- Research Animation Table
-- Every entry contains of:
-- [Research], [shipType]
--
-- NOTE: only one animation per shipType is allowed!
-- NOTE: the shipType table entry can be a comma seperated list of shipTypes! Then all ships of
--       the list will play an animation when the research is done.
researchAnimTable = 
{
	------------kng_TNG------------
	{"DisruptorAnim", "kng_TNG_ktochvah"},
	{"PulseAnim", "kng_TNG_neghvar"},
}

-- Research Either/Or Table
-- Every entry contains of:
-- [Research1], [Research2]
--
-- Only one research of each couple can be researched by the players.
-- NOTE: The table indices must correspond to the race indices:
--       Hiigaran = 1
--       Vaygr = 2
--       Federation = 3
--       Klingon = 4
--       Random = 5 (placeholder)
--       Romulan = 6
--       Auxiliary = 7
--
researchEitherOrTable = {}
researchEitherOrTable[1] = {} -- Hiigaran
researchEitherOrTable[2] = {} -- Vaygr
researchEitherOrTable[3] = { -- Federation
{ "fed_tng_DivertPowerToShields1", "fed_tng_DivertPowerToWeapons1" },
{ "fed_tng_DivertPowerToShields2", "fed_tng_DivertPowerToWeapons2" },
{ "fed_tng_DivertPowerToShields3", "fed_tng_DivertPowerToWeapons3" },
{ "fed_tng_DivertPowerToShields4", "fed_tng_DivertPowerToWeapons4" },
{ "fed_tng_DivertPowerToShields5", "fed_tng_DivertPowerToWeapons5" },
{ "fed_tng_DivertPowerToShields6", "fed_tng_DivertPowerToWeapons6" },
{ "fed_tng_DivertPowerToShields7", "fed_tng_DivertPowerToWeapons7" },
{ "fed_tng_DivertPowerToShields8", "fed_tng_DivertPowerToWeapons8" },
{ "fed_tng_DivertPowerToShields9", "fed_tng_DivertPowerToWeapons9" },
{ "fed_tng_DivertPowerToShields10", "fed_tng_DivertPowerToWeapons10" },
{ "fed_tng_DivertPowerToShields11", "fed_tng_DivertPowerToWeapons11" },
{ "fed_tng_EnhanceTargetting", "fed_tng_EnhanceSensitivity" },
}
researchEitherOrTable[4] = { -- Klingon
{ "kng_tng_DivertPowerToShields1", "kng_tng_DivertPowerToWeapons1" },
{ "kng_tng_DivertPowerToShields2", "kng_tng_DivertPowerToWeapons2" },
{ "kng_tng_DivertPowerToShields3", "kng_tng_DivertPowerToWeapons3" },
{ "kng_tng_DivertPowerToShields4", "kng_tng_DivertPowerToWeapons4" },
{ "kng_tng_DivertPowerToShields5", "kng_tng_DivertPowerToWeapons5" },
{ "kng_tng_DivertPowerToShields6", "kng_tng_DivertPowerToWeapons6" },
{ "kng_tng_DivertPowerToShields7", "kng_tng_DivertPowerToWeapons7" },
{ "kng_tng_DivertPowerToShields8", "kng_tng_DivertPowerToWeapons8" },
{ "kng_tng_DivertPowerToShields9", "kng_tng_DivertPowerToWeapons9" },
{ "kng_tng_DivertPowerToShields10", "kng_tng_DivertPowerToWeapons10" },
{ "kng_tng_DivertPowerToShields11", "kng_tng_DivertPowerToWeapons11" },
{ "kng_tng_EnhanceTargetting", "kng_tng_EnhanceSensitivity" },
}
researchEitherOrTable[5] = {} -- Random (placeholder)
researchEitherOrTable[6] = { -- Romulan
{ "rom_tng_DivertPowerToShields1", "rom_tng_DivertPowerToWeapons1" },
{ "rom_tng_DivertPowerToShields2", "rom_tng_DivertPowerToWeapons2" },
{ "rom_tng_DivertPowerToShields3", "rom_tng_DivertPowerToWeapons3" },
{ "rom_tng_DivertPowerToShields4", "rom_tng_DivertPowerToWeapons4" },
{ "rom_tng_DivertPowerToShields5", "rom_tng_DivertPowerToWeapons5" },
{ "rom_tng_DivertPowerToShields6", "rom_tng_DivertPowerToWeapons6" },
{ "rom_tng_DivertPowerToShields7", "rom_tng_DivertPowerToWeapons7" },
{ "rom_tng_DivertPowerToShields8", "rom_tng_DivertPowerToWeapons8" },
{ "rom_tng_DivertPowerToShields9", "rom_tng_DivertPowerToWeapons9" },
{ "rom_tng_DivertPowerToShields10", "rom_tng_DivertPowerToWeapons10" },
{ "rom_tng_DivertPowerToShields11", "rom_tng_DivertPowerToWeapons11" },
{ "rom_tng_EnhanceTargetting", "rom_tng_EnhanceSensitivity" },
}
researchEitherOrTable[7] = {} -- Auxiliary

----------------------------------------------------------------------------------------------------
-- ESPIONAGE SETTINGS
----------------------------------------------------------------------------------------------------
-- espionageDuration     : duration of the spy (displays all enemy ships for Romulans)
-- espionageRechargeTime : recharge time of the spy
espionageDuration = 300
espionageRechargeTime = 3000


----------------------------------------------------------------------------------------------------
-- EXPLOSION SETTINGS
----------------------------------------------------------------------------------------------------
-- explosionNormFactor        : factor which norms the ship size
-- explosionShockwaveDuration : this is how long the shockwave object will attack. Has to be > 0, because
--                              the shockwave object needs time to organize before it can attack
explosionNormFactor = 1/450
explosionShockwaveDuration = 4

-- Explosion Effects Table
-- Every entry contains of:
-- [FXFile], [Scale], [Offset], [SoundFile], [SoundOffset], [DamageOffset], [ShockwaveOffset]
-- 1         2        3         4            5              6               7
-- 
-- FXFile          : FX file to play
-- Scale           : factor to scale FX with
-- Offset          : time to play FX, before deathTime counter expires (1/10th seconds)
-- SoundFile       : SFX file to play
-- SoundOffset     : time to play SFX, before deathTime counter expires (1/10th seconds)
-- DamageOffset    : time to deal explosion damage, before deathTime counter expires (1/10th seconds)
-- ShockwaveOffset : time to create shockwave, before deathTime counter expires (1/10th seconds)
-- 
-- NOTE: Set offset to -1 that no FX, SFX, damage, shockwave is created
explosionEffectsTable = {
none = {"", 1, -1, "", -1, -1, -1, -1},
invisible = {"", 1, -1, "", -1, 0, 4, 0},
dummy = {"xplosion_dummy_boom", 4, 0, "", -1, 0, 2, 0},

-- default
default_superlarge = {"xplosion_superlarge", 0.7, 3, "data:sound/sfx/etg/explosion/large/etg_explode_large_plasma/etg_explode_large_plasma", 0, 0, 2, 0},
default_large = {"xplosion_large", 0.8, 1, "data:sound/sfx/etg/explosion/large/etg_explode_large_plasma/etg_explode_large_plasma", 0, 0, 2, 0},
default_medium = {"xplosion_medium", 1.0, 2, "data:sound/sfx/etg/explosion/large/etg_explode_large_plasma/etg_explode_large_plasma", 0, 0, 2, 0},
default_small = {"xplosion_small", 1.1, 1, "data:sound/sfx/etg/explosion/medium/etg_explode_medium_firey/etg_explode_medium_firey", 0, 0, 1, 0},

-- fed
fed_superlarge = {"xplosion_superlarge", 0.7, 3, "data:sound/sfx/etg/explosion/large/etg_explode_large_plasma/etg_explode_large_plasma", 0, 0, 2, 0},
fed_large = {"xplosion_fed_large", 0.9, 2, "data:sound/sfx/etg/explosion/large/etg_explode_large_plasma/etg_explode_large_plasma", 0, 0, 2, 0},
fed_medium = {"xplosion_fed_medium", 1.1, 2, "data:sound/sfx/etg/explosion/large/etg_explode_large_plasma/etg_explode_large_plasma", 0, 0, 2, 0},
fed_small = {"xplosion_fed_small", 1.3, 2, "data:sound/sfx/etg/explosion/medium/etg_explode_medium_firey/etg_explode_medium_firey", 0, 0, 1, 0},

-- brg
brg_superlarge = {"xplosion_brg_superlarge", 1.15, 3, "data:sound/sfx/etg/explosion/large/etg_explode_large_plasma/etg_explode_large_plasma", 0, 0, 2, 0},
brg_large = {"xplosion_brg_large", 1.0, 2, "data:sound/sfx/etg/explosion/large/etg_explode_large_plasma/etg_explode_large_plasma", 0, 0, 2, 0},
brg_medium = {"xplosion_brg_medium", 1.2, 2, "data:sound/sfx/etg/explosion/large/etg_explode_large_plasma/etg_explode_large_plasma", 0, 0, 2, 0},
brg_small = {"xplosion_brg_small", 1.2, 2, "data:sound/sfx/etg/explosion/medium/etg_explode_medium_firey/etg_explode_medium_firey", 0, 0, 1, 0},

--rom
rom_superlarge = {"xplosion_rom_superlarge", 0.8, 3, "data:sound/sfx/etg/explosion/large/etg_explode_large_plasma/etg_explode_large_plasma", 0, 0, 2, 0},
rom_large = {"xplosion_rom_large", 0.9, 1, "data:sound/sfx/etg/explosion/large/etg_explode_large_plasma/etg_explode_large_plasma", 0, 0, 2, 0},
rom_medium = {"xplosion_rom_medium", 1.0, 1, "data:sound/sfx/etg/explosion/large/etg_explode_large_plasma/etg_explode_large_plasma", 0, 0, 2, 0},
rom_small = {"xplosion_rom_small", 1.3, 1, "data:sound/sfx/etg/explosion/medium/etg_explode_medium_firey/etg_explode_medium_firey", 0, 0, 1, 0},
}

----------------------------------------------------------------------------------------------------
-- EXPERIENCE SETTINGS
----------------------------------------------------------------------------------------------------
-- Rank Table - this is where we get our information about ranks
-- NOTE: must be sorted! (Rank1, Rank2, Rank3, ...)
-- NOTE: first entry must be the NoRank entry (Multiplier = 1)
-- Every entry contains of:
-- [XpBorder], [Boost], [Animation]
-- 
-- XpBorder  : Number of ship equivalents which have to be destroyed to rank up. (decimals are allowed!)
--             Example: 2 means that we have to destroy two ships, which are equal in streangth to
--                      our ship. We will also rank up if we destroy one ship, which has two times
--                      the strength of our ship.
-- Boost     : Maximum boost is 2x!
-- Animation : Name of the event which is triggered when the ship ranks up. Also add an event with
--             the suffix "_loop". The "_loop" one will be played to display the current rank.
--             The standard animations are: xp_blue, xp_silver, xp_gold, xp_red, xp_blue_loop, ...
rankInfoTable =
{
{0, 1, ""},
{2, 1.25, "xp_blue"},
{4, 1.5, "xp_silver"},
{6, 1.75, "xp_gold"},
{8, 2.0, "xp_red"},
}


----------------------------------------------------------------------------------------------------
-- WIN CONDITION SETTINGS
----------------------------------------------------------------------------------------------------
-- No Real Builder Table
-- List of ship classes with the 'CanBuild' ability, which should be ignored by ProductionShipsLeft
-- win condition
noRealBuilderTable = 
{
	"fed_TNG_nebula",
	"fed_TMP_miranda",
	"fed_TMP_excelsior",
	"fed_TMP_midway",
	"kng_TMP_swordofkahless",
	
	"fed_TNG_resourcecontroller",
	"fed_TMP_resourcecontroller",
	"kng_TNG_resourcecontroller",
	"kng_TMP_resourcecontroller",
	"rom_TNG_resourcecontroller",
	"rom_TMP_resourcecontroller",
}


----------------------------------------------------------------------------------------------------
-- SOBSPLITTER SETTINGS
----------------------------------------------------------------------------------------------------
-- globalSplitStartValue   : the starting value for the splitting routine. Should be the maximum map size.
-- globalSplitBreakUpValue : splitSobGroup() will stop splitting when "span" is less than this (to avoid a possible endless loop).
SOB_maximumSpan = 1E6
SOB_minimumSpan = 1E-1
-- Squadron Table
-- Table containing all squadron ship classes
-- Every entry contains of:
-- [ship class], [number of ships in squadron]
SOB_SquadronTable = 
{
	{"fed_TMP_drone1", 3},
	{"fed_TMP_drone2", 3},
	{"fed_TMP_drone3", 3},
	{"fed_TMP_drone4", 3},
	{"fed_TMP_drone5", 3},
	{"fed_TMP_drone6", 3},	
	
	{"kng_TMP_drone1", 2},
	{"kng_TMP_drone2", 2},
	{"kng_TMP_drone3", 2},
	{"kng_TMP_drone4", 2},
}


-- Ship Class Table
-- List of the names from all ship class
shipClassTable = {

"fed_TNG_starbase",
"fed_TNG_outpost",
"fed_TNG_flagship",
"fed_TNG_shipyard",
"fed_TNG_shipyard_S",
"fed_TNG_drydock",
"fed_TNG_CIV_orbitaloffices",
"fed_TNG_CIV_tradingstation",
"fed_TNG_CIV_upgradestation",
"fed_TNG_venture",
"fed_TNG_fighter",
"fed_TNG_peregrine",
"fed_TNG_defiant",
"fed_TNG_nova",
"fed_TNG_sabre",
"fed_TNG_intrepid",
"fed_TNG_norway",
"fed_TNG_steamrunner",
"fed_TNG_akira",
"fed_TNG_nebula",
"fed_TNG_galaxy",
"fed_TNG_galaxy_saucer",
"fed_TNG_galaxy_stardrive",
"fed_TNG_sovereign",
"fed_TNG_prometheus",
"fed_TNG_prometheus_alpha",
"fed_TNG_prometheus_beta",
"fed_TNG_prometheus_gamma",
"fed_TNG_phaserturret",
"fed_TNG_torpedoturret",
"fed_TNG_resourcecollector",
"fed_TNG_resourcecontroller",
"fed_TNG_probe",


"kng_TNG_starbase",
"kng_TNG_outpost",
"kng_TNG_flagship",
"kng_TNG_shipyard",
"kng_TNG_shipyard_S",
"kng_TNG_drydock",
"kng_TNG_CIV_orbitalstation",
"kng_TNG_CIV_ordinancedepot",
"kng_TNG_CIV_tradingstation",
"kng_TNG_nuqduj",
"kng_TNG_fighter",
"kng_TNG_bomber",
"kng_TNG_E7",
"kng_TNG_kvort",
"kng_TNG_suqjagh",
"kng_TNG_fekhlr",
"kng_TNG_kron",
"kng_TNG_kvek",
"kng_TNG_vorcha",
"kng_TNG_ktochvah",
"kng_TNG_neghvar",
"kng_TNG_pulseturret",
"kng_TNG_torpedoturret",
"kng_TNG_resourcecollector",
"kng_TNG_resourcecontroller",
"kng_TNG_probe",


"rom_TNG_starbase",
"rom_TNG_outpost",
"rom_TNG_flagship",
"rom_TNG_shipyard",
"rom_TNG_shipyard_S",
"rom_TNG_drydock",
"rom_TNG_CIV_orbitaloffices",
"rom_TNG_CIV_researchstation",
"rom_TNG_CIV_tradingstation",
"rom_TNG_talon",
"rom_TNG_fighter",
-- "-PLACEHOLDER-",
"rom_TNG_shrike",
"rom_TNG_enarrain",
"rom_TNG_griffin",
"rom_TNG_raptor",
"rom_TNG_veles",
"rom_TNG_hatham",
"rom_TNG_norexan",
"rom_TNG_dderidex",
"rom_TNG_pulseturret",
"rom_TNG_torpedoturret",
"rom_TNG_resourcecollector",
"rom_TNG_resourcecontroller",
"rom_TNG_probe",


"aux_TNG_BRG_detector",
"aux_TNG_BRG_destroyer",
"aux_TNG_BRG_assimilator",
"aux_TNG_BRG_sphere",
"aux_TNG_BRG_diamond",
"aux_TNG_BRG_cube",
"aux_TNG_BRG_tacticalcube",


"aux_TNG_DOM_fighter",
"aux_TNG_DOM_bugship",
"aux_TNG_CAR_hideki",
"aux_TNG_BRN_warship",
"aux_TNG_CAR_galor",
"aux_TNG_CAR_keldon",
"aux_TNG_DOM_warship",
"aux_TNG_DOM_dreadnought",
"aux_TNG_DOM_carrier",
"aux_TNG_CAR_hutet",


"aux_TNG_FER_dkora",


"fed_TMP_flagship",
"fed_TMP_fighter",
"fed_TMP_drone1",
"fed_TMP_drone2",
"fed_TMP_drone3",
"fed_TMP_drone4",
"fed_TMP_drone5",
"fed_TMP_drone6",
"fed_TMP_oberth",
"fed_TMP_akula",
"fed_TMP_centaur",
"fed_TMP_miranda",
"fed_TMP_constitution",
"fed_TMP_constellation",
"fed_TMP_excelsior",
"fed_TMP_ambassador",
"fed_TMP_midway",
"fed_TMP_resourcecollector",
"fed_TMP_resourcecontroller",


"kng_TMP_flagship",
"kng_TMP_fighter",
"kng_TMP_bomber",
"kng_TMP_drone1",
"kng_TMP_drone2",
"kng_TMP_drone3",
"kng_TMP_drone4",
"kng_TMP_brel",
"kng_TMP_kleev",
"kng_TMP_ktinga",
"kng_TMP_bertaa",
"kng_TMP_vodleh",
"kng_TMP_swordofkahless",


"rom_TMP_flagship",
"rom_TMP_fighter",
"rom_TMP_bomber",
"rom_TMP_draconarius",
"rom_TMP_birdofprey",
"rom_TMP_stormbird",
"rom_TMP_firehawk",
"rom_TMP_dtalla",
"rom_TMP_resourcecontroller",


"aux_TMP_GRN_fighter",
"aux_TMP_GRN_grendel",

}


-- Ship Class Stats Table
-- Every entry contains of:
-- [RacePrefix], [IsMilitary], [WarpIn], [Shield], [ShipWorth], [DieTime], [Explosion], [ShipSize], [Shockwave], [Damage Radii Table]
-- 1             2             3         4         5            6          7            8           9            10
-- 
-- RacePrefix : "fed", "kng", "rom", ...
-- IsMilitary : 0 = is military unit, 1 = is no military unit
-- WarpIn     : 1 = warps in when buildt, 0 = doesn't warp in
-- Shield     : 1 = has shields, -1 = has no shields
-- ShipWorth  : abstract number of the ship's worth/value/strength. Don't set this to 0 -> we divide by this one!
-- DieTime    : time the ship needs to die, after loosing all health; set this to 0 for no special explosion scripting
-- Explosion  : String defining the explosion to use, see "explosionEffectsTable" for available names
-- ShipSize   : longest x/y/z dimension of the ship, needed to scale the explosion effect
-- Shockwave  : integer defining the 'real shockwave'
--              available shockwaves are: 500, 1000, 1500, 2000, 3000, 5000
--              no shockwave: 0
--              NOTE: The shockwave value indicates the range of the shockwave
--              NOTE: The shockwave weapons must have a fire time of 0.1
-- 
-- Damage Radii Table :
-- A Damage Radii Table contains of: [1] = Radius, [2] = Damage
-- NOTE: the radii must be sortet! Largest radius first!
-- NOTE: in contrast to the old explosion damage script: the damages are not additive!
shipClassStatsTable = {
-- If we cannot find a ship in the shipClassTable (see above) these are the default settings:
default = {"fed", 0, 0, 1, 1, 0, "none", 0, 0, {},},
}

----------------------------------------------------------------------------------------------------

shipClassStatsTable["fed_TNG_starbase"              ]={"fed",0,0,-1, 1020000,160,"fed_superlarge"    ,5000,5000,{{10000,100000},{5000,200000},{3000,300000},},}
shipClassStatsTable["fed_TNG_outpost"               ]={"fed",0,0,-1,  300000, 80,"fed_superlarge"    ,2000,3000,{{ 4000, 40000},{2000, 80000},{1200,120000},},}
shipClassStatsTable["fed_TNG_flagship"              ]={"fed",1,1, 1,  155000, 60,"fed_large"         , 694,1500,{{ 1400, 14000},{ 700, 28000},{ 420, 42000},},}
shipClassStatsTable["fed_TNG_shipyard"              ]={"fed",0,0,-1,  150000, 80,"fed_superlarge"    ,1000,2000,{{ 2000, 20000},{1000, 40000},{ 600, 60000},},}
shipClassStatsTable["fed_TNG_shipyard_S"            ]={"fed",0,0,-1,  120000, 80,"fed_superlarge"    , 800,2000,{{ 1600, 16000},{ 800, 32000},{ 480, 48000},},}
shipClassStatsTable["fed_TNG_drydock"               ]={"fed",0,0,-1,   67500, 80,"fed_large"         , 450,1500,{{  900,  9000},{ 450, 18000},{ 270, 27000},},}
shipClassStatsTable["fed_TNG_CIV_orbitaloffices"    ]={"fed",0,0,-1,  175000, 80,"fed_superlarge"    ,1200,2000,{{ 2400, 24000},{1200, 48000},{ 720, 72000},},}
shipClassStatsTable["fed_TNG_CIV_tradingstation"    ]={"fed",0,0,-1,  245000, 80,"fed_superlarge"    ,1766,3000,{{ 3600, 36000},{1800, 72000},{1080,108000},},}
shipClassStatsTable["fed_TNG_CIV_upgradestation"    ]={"fed",0,0,-1,  190000, 80,"fed_superlarge"    ,1284,3000,{{ 2600, 26000},{1300, 52000},{ 780, 78000},},}
shipClassStatsTable["fed_TNG_venture"               ]={"fed",0,0, 1,    3100, 20,"fed_small"         ,  25,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["fed_TNG_fighter"               ]={"fed",1,0, 1,   19000, 20,"fed_small"         ,  30,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["fed_TNG_peregrine"             ]={"fed",1,0, 1,   14000, 20,"fed_small"         ,  26,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["fed_TNG_defiant"               ]={"fed",1,0, 1,   67500, 20,"fed_small"         , 120, 500,{{  300,  3000},{ 150,  6000},{  90,  9000},},}
shipClassStatsTable["fed_TNG_nova"                  ]={"fed",1,0, 1,   75000, 20,"fed_small"         , 225, 500,{{  500,  5000},{ 250, 10000},{ 150, 15000},},}
shipClassStatsTable["fed_TNG_sabre"                 ]={"fed",1,0, 1,   77500, 20,"fed_small"         , 226, 500,{{  500,  5000},{ 250, 10000},{ 150, 15000},},}
shipClassStatsTable["fed_TNG_intrepid"              ]={"fed",1,0, 1,  102500, 40,"fed_medium"        , 348,1000,{{  700,  7000},{ 350, 14000},{ 210, 21000},},}
shipClassStatsTable["fed_TNG_norway"                ]={"fed",1,0, 1,  102500, 40,"fed_medium"        , 360,1000,{{  800,  8000},{ 400, 16000},{ 240, 24000},},}
shipClassStatsTable["fed_TNG_steamrunner"           ]={"fed",1,0, 1,   80000, 40,"fed_medium"        , 361,1000,{{  800,  8000},{ 400, 16000},{ 240, 24000},},}
shipClassStatsTable["fed_TNG_akira"                 ]={"fed",1,0, 1,  102500, 60,"fed_large"         , 448,1500,{{  900,  9000},{ 450, 18000},{ 270, 27000},},}
shipClassStatsTable["fed_TNG_nebula"                ]={"fed",1,0, 1,  110000, 60,"fed_large"         , 470,1500,{{ 1000, 10000},{ 500, 20000},{ 300, 30000},},}
shipClassStatsTable["fed_TNG_galaxy"                ]={"fed",1,0, 1,  145000, 60,"fed_large"         , 652,1500,{{ 1400, 14000},{ 700, 28000},{ 420, 42000},},}
shipClassStatsTable["fed_TNG_galaxy_saucer"         ]={"fed",1,0, 1,  100000, 60,"fed_large"         , 466,1500,{{ 1000, 10000},{ 500, 20000},{ 300, 30000},},}
shipClassStatsTable["fed_TNG_galaxy_stardrive"      ]={"fed",1,0, 1,   80000, 60,"fed_large"         , 401,1500,{{  900,  9000},{ 450, 18000},{ 270, 27000},},}
shipClassStatsTable["fed_TNG_sovereign"             ]={"fed",1,0, 1,  155000, 60,"fed_large"         , 694,1500,{{ 1400, 14000},{ 700, 28000},{ 420, 42000},},}
shipClassStatsTable["fed_TNG_prometheus"            ]={"fed",1,0, 1,  145000, 60,"fed_large"         , 415,1500,{{  900,  9000},{ 450, 18000},{ 270, 27000},},}
shipClassStatsTable["fed_TNG_prometheus_alpha"      ]={"fed",1,0, 1,  115000, 60,"fed_large"         , 246, 500,{{  500,  5000},{ 250, 10000},{ 150, 15000},},}
shipClassStatsTable["fed_TNG_prometheus_beta"       ]={"fed",1,0, 1,   92500, 60,"fed_large"         , 312,1000,{{  700,  7000},{ 350, 14000},{ 210, 21000},},}
shipClassStatsTable["fed_TNG_prometheus_gamma"      ]={"fed",1,0, 1,   92500, 60,"fed_large"         , 312,1000,{{  700,  7000},{ 350, 14000},{ 210, 21000},},}
shipClassStatsTable["fed_TNG_phaserturret"          ]={"fed",1,0, 1,   72500, 40,"fed_medium"        ,  96,   0,{{  200,  2000},{ 100,  4000},{  60,  6000},},}
shipClassStatsTable["fed_TNG_torpedoturret"         ]={"fed",1,0, 1,   41000, 40,"fed_medium"        , 135, 500,{{  300,  3000},{ 150,  6000},{  90,  9000},},}
shipClassStatsTable["fed_TNG_resourcecollector"     ]={"fed",0,0,-1,    3400, 20,"fed_small"         ,  34,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["fed_TNG_resourcecontroller"    ]={"fed",0,1,-1,   39000, 40,"fed_medium"        , 344,1000,{{  700,  7000},{ 350, 14000},{ 210, 21000},},}
shipClassStatsTable["fed_TNG_probe"                 ]={"fed",0,0,-1,     950, 20,"fed_small"         ,   9,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
                                                  
shipClassStatsTable["kng_TNG_starbase"              ]={"kng",0,0,-1,  820000,160,"default_superlarge",5000,5000,{{10000,100000},{5000,200000},{3000,300000},},}
shipClassStatsTable["kng_TNG_outpost"               ]={"kng",0,0,-1,  300000, 80,"default_superlarge",2000,3000,{{ 4000, 40000},{2000, 80000},{1200,120000},},}
shipClassStatsTable["kng_TNG_flagship"              ]={"kng",1,1, 1,  152500, 60,"default_large"     , 688,1500,{{ 1400, 14000},{ 700, 28000},{ 420, 42000},},}
shipClassStatsTable["kng_TNG_shipyard"              ]={"kng",0,0,-1,  150000, 80,"default_superlarge",1000,2000,{{ 2000, 20000},{1000, 40000},{ 600, 60000},},}
shipClassStatsTable["kng_TNG_shipyard_S"            ]={"kng",0,0,-1,  120000, 80,"default_superlarge", 800,2000,{{ 1600, 16000},{ 800, 32000},{ 480, 48000},},}
shipClassStatsTable["kng_TNG_drydock"               ]={"kng",0,0,-1,   67500, 80,"default_large"     , 450,1500,{{  900,  9000},{ 450, 18000},{ 270, 27000},},}
shipClassStatsTable["kng_TNG_CIV_orbitalstation"    ]={"kng",0,0,-1,  192500, 80,"default_superlarge",1391,3000,{{ 2800, 28000},{1400, 56000},{ 840, 84000},},}
shipClassStatsTable["kng_TNG_CIV_ordinancedepot"    ]={"kng",0,0,-1,  165000, 80,"default_superlarge",1178,2000,{{ 2400, 24000},{1200, 48000},{ 720, 72000},},}
shipClassStatsTable["kng_TNG_CIV_tradingstation"    ]={"kng",0,0,-1,  200000, 80,"default_superlarge",1429,3000,{{ 2900, 29000},{1450, 58000},{ 870, 87000},},}
shipClassStatsTable["kng_TNG_nuqduj"                ]={"kng",0,0, 1,   12000, 20,"default_small"     ,  31,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["kng_TNG_fighter"               ]={"kng",1,0, 1,   34000, 20,"default_small"     ,  33,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["kng_TNG_bomber"                ]={"kng",1,0, 1,   17000, 20,"default_small"     ,  39,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["kng_TNG_E7"                    ]={"kng",1,0, 1,   87500, 40,"default_small"     , 229, 500,{{  500,  5000},{ 250, 10000},{ 150, 15000},},}
shipClassStatsTable["kng_TNG_kvort"                 ]={"kng",1,0, 1,   75000, 20,"default_small"     , 193, 500,{{  400,  4000},{ 200,  8000},{ 120, 12000},},}
shipClassStatsTable["kng_TNG_suqjagh"               ]={"kng",1,0, 1,   62500, 40,"default_medium"    , 284, 500,{{  600,  6000},{ 300, 12000},{ 180, 18000},},}
shipClassStatsTable["kng_TNG_fekhlr"                ]={"kng",1,0, 1,  107500, 40,"default_medium"    , 385,1000,{{  800,  8000},{ 400, 16000},{ 240, 24000},},}
shipClassStatsTable["kng_TNG_kron"                  ]={"kng",1,0, 1,   70000, 40,"default_medium"    , 358,1000,{{  800,  8000},{ 400, 16000},{ 240, 24000},},}
shipClassStatsTable["kng_TNG_kvek"                  ]={"kng",1,0, 1,  102500, 40,"default_medium"    , 406,1500,{{  900,  9000},{ 450, 18000},{ 270, 27000},},}
shipClassStatsTable["kng_TNG_vorcha"                ]={"kng",1,0, 1,  107500, 60,"default_medium"    , 488,1500,{{ 1000, 10000},{ 500, 20000},{ 300, 30000},},}
shipClassStatsTable["kng_TNG_ktochvah"              ]={"kng",1,0, 1,  140000, 60,"default_large"     , 613,1500,{{ 1300, 13000},{ 650, 26000},{ 390, 39000},},}
shipClassStatsTable["kng_TNG_neghvar"               ]={"kng",1,0, 1,  160000, 60,"default_large"     , 688,1500,{{ 1400, 14000},{ 700, 28000},{ 420, 42000},},}
shipClassStatsTable["kng_TNG_pulseturret"           ]={"kng",1,0, 1,   35000, 40,"default_medium"    ,  68,   0,{{  200,  2000},{ 100,  4000},{  60,  6000},},}
shipClassStatsTable["kng_TNG_torpedoturret"         ]={"kng",1,0, 1,   34500, 40,"default_medium"    ,  79,   0,{{  200,  2000},{ 100,  4000},{  60,  6000},},}
shipClassStatsTable["kng_TNG_resourcecollector"     ]={"kng",0,0,-1,    1300, 20,"default_small"     ,  11,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["kng_TNG_resourcecontroller"    ]={"kng",0,1,-1,   28500, 40,"default_medium"    , 219, 500,{{  500,  5000},{ 250, 10000},{ 150, 15000},},}
shipClassStatsTable["kng_TNG_probe"                 ]={"kng",0,0,-1,     950, 20,"default_small"     ,   7,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
                                                  
shipClassStatsTable["rom_TNG_starbase"              ]={"rom",0,0,-1,  900000,160,"rom_superlarge"    ,5000,5000,{{10000,100000},{5000,200000},{3000,300000},},}
shipClassStatsTable["rom_TNG_outpost"               ]={"rom",0,0,-1,  300000, 80,"rom_superlarge"    ,2000,3000,{{ 4000, 40000},{2000, 80000},{1200,120000},},}
shipClassStatsTable["rom_TNG_flagship"              ]={"rom",1,1, 1,  152500, 60,"rom_large"         , 807,2000,{{ 1700, 17000},{ 850, 34000},{ 510, 51000},},}
shipClassStatsTable["rom_TNG_shipyard"              ]={"rom",0,0,-1,  150000, 80,"rom_superlarge"    ,1000,2000,{{ 2000, 20000},{1000, 40000},{ 600, 60000},},}
shipClassStatsTable["rom_TNG_shipyard_S"            ]={"rom",0,0,-1,  120000, 80,"rom_superlarge"    , 800,2000,{{ 1600, 16000},{ 800, 32000},{ 480, 48000},},}
shipClassStatsTable["rom_TNG_drydock"               ]={"rom",0,0,-1,   67500, 80,"rom_large"         , 450,1500,{{  900,  9000},{ 450, 18000},{ 270, 27000},},}
shipClassStatsTable["rom_TNG_CIV_orbitaloffices"    ]={"rom",0,0,-1,  222500, 80,"rom_superlarge"    ,1552,3000,{{ 3200, 32000},{1600, 64000},{ 960, 96000},},}
shipClassStatsTable["rom_TNG_CIV_researchstation"   ]={"rom",0,0,-1,  187500, 80,"rom_superlarge"    ,1256,3000,{{ 2600, 26000},{1300, 52000},{ 780, 78000},},}
shipClassStatsTable["rom_TNG_CIV_tradingstation"    ]={"rom",0,0,-1,  152500, 80,"rom_superlarge"    ,1084,2000,{{ 2200, 22000},{1100, 44000},{ 660, 66000},},}
shipClassStatsTable["rom_TNG_talon"                 ]={"rom",0,0, 1,   11500, 20,"rom_small"         ,  31,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["rom_TNG_fighter"               ]={"rom",1,0, 1,   18500, 20,"rom_small"         ,  32,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
--shipClassStatsTable["PLACEHOLDER"                 ]={"rom",1,0, 1,   13500, 20,"rom_small"         ,  22,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["rom_TNG_shrike"                ]={"rom",1,0, 1,   60000, 20,"rom_small"         , 114, 500,{{  300,  3000},{ 150,  6000},{  90,  9000},},}
shipClassStatsTable["rom_TNG_enarrain"              ]={"rom",1,0, 1,   50000, 20,"rom_small"         , 152, 500,{{  400,  4000},{ 200,  8000},{ 120, 12000},},}
shipClassStatsTable["rom_TNG_griffin"               ]={"rom",1,0, 1,   82500, 40,"rom_medium"        , 384,1000,{{  800,  8000},{ 400, 16000},{ 240, 24000},},}
shipClassStatsTable["rom_TNG_raptor"                ]={"rom",1,0, 1,   65000, 40,"rom_medium"        , 325,1000,{{  700,  7000},{ 350, 14000},{ 210, 21000},},}
shipClassStatsTable["rom_TNG_veles"                 ]={"rom",1,0, 1,  107500, 40,"rom_medium"        , 452,1500,{{ 1000, 10000},{ 500, 20000},{ 300, 30000},},}
shipClassStatsTable["rom_TNG_hatham"                ]={"rom",1,0, 1,  135000, 60,"rom_large"         , 526,1500,{{ 1100, 11000},{ 550, 22000},{ 330, 33000},},}
shipClassStatsTable["rom_TNG_norexan"               ]={"rom",1,0, 1,  152500, 60,"rom_large"         , 807,2000,{{ 1700, 17000},{ 850, 34000},{ 510, 51000},},}
shipClassStatsTable["rom_TNG_dderidex"              ]={"rom",1,0, 1,  197500, 60,"rom_superlarge"    ,1371,3000,{{ 2800, 28000},{1400, 56000},{ 840, 84000},},}
shipClassStatsTable["rom_TNG_pulseturret"           ]={"rom",1,0, 1,   48500, 40,"rom_medium"        ,  92,   0,{{  200,  2000},{ 100,  4000},{  60,  6000},},}
shipClassStatsTable["rom_TNG_torpedoturret"         ]={"rom",1,0, 1,   36500, 40,"rom_medium"        ,  95,   0,{{  200,  2000},{ 100,  4000},{  60,  6000},},}
shipClassStatsTable["rom_TNG_resourcecollector"     ]={"rom",0,0,-1,    4150, 20,"rom_small"         ,  39,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["rom_TNG_resourcecontroller"    ]={"rom",0,1,-1,   55000, 40,"rom_medium"        , 512,1500,{{ 1100, 11000},{ 550, 22000},{ 330, 33000},},}
shipClassStatsTable["rom_TNG_probe"                 ]={"rom",0,0,-1,    1350, 20,"rom_small"         ,   9,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
                                                  
shipClassStatsTable["aux_TNG_BRG_detector"          ]={"brg",1,1, 1,   26500, 20,"brg_small"         , 119, 500,{{  300,  3000},{ 150,  6000},{  90,  9000},},}
shipClassStatsTable["aux_TNG_BRG_destroyer"         ]={"brg",1,1, 1,   67500, 40,"brg_medium"        , 206, 500,{{  500,  5000},{ 250, 10000},{ 150, 15000},},}
shipClassStatsTable["aux_TNG_BRG_assimilator"       ]={"brg",1,1, 1,  200000, 60,"brg_medium"        , 444,1500,{{  900,  9000},{ 450, 18000},{ 270, 27000},},}
shipClassStatsTable["aux_TNG_BRG_sphere"            ]={"brg",1,1, 1,  160000, 60,"brg_large"         , 408,1500,{{  900,  9000},{ 450, 18000},{ 270, 27000},},}
shipClassStatsTable["aux_TNG_BRG_diamond"           ]={"brg",1,1, 1,  165000, 60,"brg_large"         , 488,1500,{{ 1000, 10000},{ 500, 20000},{ 300, 30000},},}
shipClassStatsTable["aux_TNG_BRG_cube"              ]={"brg",1,1, 1,  645000,200,"brg_superlarge"    ,2100,5000,{{ 4200, 42000},{2100, 84000},{1260,126000},},}
shipClassStatsTable["aux_TNG_BRG_tacticalcube"      ]={"brg",1,1, 1,  705000,200,"brg_superlarge"    ,2356,5000,{{ 4800, 48000},{2400, 96000},{1440,144000},},}
                                                  
shipClassStatsTable["aux_TNG_DOM_fighter"           ]={"dom",1,0, 1,   19500, 20,"default_small"     ,  29,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["aux_TNG_DOM_bugship"           ]={"dom",1,0, 1,   24500, 20,"default_small"     , 102, 500,{{  300,  3000},{ 150,  6000},{  90,  9000},},}
shipClassStatsTable["aux_TNG_CAR_hideki"            ]={"car",1,1, 1,   23500, 20,"default_small"     ,  98,   0,{{  200,  2000},{ 100,  4000},{  60,  6000},},}
shipClassStatsTable["aux_TNG_BRN_warship"           ]={"dom",1,1, 1,   87500, 40,"default_medium"    , 330,1000,{{  700,  7000},{ 350, 14000},{ 210, 21000},},}
shipClassStatsTable["aux_TNG_CAR_galor"             ]={"car",1,1, 1,   75000, 40,"default_medium"    , 481,1500,{{ 1000, 10000},{ 500, 20000},{ 300, 30000},},}
shipClassStatsTable["aux_TNG_CAR_keldon"            ]={"car",1,1, 1,   80000, 40,"default_medium"    , 481,1500,{{ 1000, 10000},{ 500, 20000},{ 300, 30000},},}
shipClassStatsTable["aux_TNG_DOM_warship"           ]={"dom",1,1, 1,  167500, 60,"default_large"     , 639,1500,{{ 1300, 13000},{ 650, 26000},{ 390, 39000},},}
shipClassStatsTable["aux_TNG_DOM_dreadnought"       ]={"dom",1,1, 1,  352500,200,"default_superlarge",1500,3000,{{ 3000, 30000},{1500, 60000},{ 900, 90000},},}
shipClassStatsTable["aux_TNG_DOM_carrier"           ]={"dom",1,1, 1,  207500, 60,"default_large"     ,1080,2000,{{ 2200, 22000},{1100, 44000},{ 660, 66000},},}
shipClassStatsTable["aux_TNG_CAR_hutet"             ]={"car",1,1, 1,  340000,200,"default_superlarge",1640,3000,{{ 3300, 33000},{1650, 66000},{ 990, 99000},},}
                                                  
shipClassStatsTable["aux_TNG_FER_dkora"             ]={"car",1,1, 1,   52500, 40,"default_large"     , 365,1000,{{  800,  8000},{ 400, 16000},{ 240, 24000},},}
                                                  
shipClassStatsTable["fed_TMP_flagship"              ]={"fed",1,1, 1,  107500, 60,"fed_large"         , 469,1500,{{ 1000, 10000},{ 500, 20000},{ 300, 30000},},}
shipClassStatsTable["fed_TMP_fighter"               ]={"fed",1,0, 1,   14500, 20,"fed_small"         ,  15,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["fed_TMP_drone1"                ]={"fed",1,0, 1,    6000, 20,"fed_small"         ,  15,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["fed_TMP_drone2"                ]={"fed",1,0, 1,    6000, 20,"fed_small"         ,  15,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["fed_TMP_drone3"                ]={"fed",1,0, 1,    6000, 20,"fed_small"         ,  15,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["fed_TMP_drone4"                ]={"fed",1,0, 1,    6000, 20,"fed_small"         ,  15,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["fed_TMP_drone5"                ]={"fed",1,0, 1,    6000, 20,"fed_small"         ,  15,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["fed_TMP_drone6"                ]={"fed",1,0, 1,    6000, 20,"fed_small"         ,  15,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["fed_TMP_oberth"                ]={"fed",0,0, 1,   27500, 20,"fed_small"         , 150, 500,{{  300,  3000},{ 150,  6000},{  90,  9000},},}
shipClassStatsTable["fed_TMP_akula"                 ]={"fed",1,0, 1,   67500, 20,"fed_small"         , 228, 500,{{  500,  5000},{ 250, 10000},{ 150, 15000},},}
shipClassStatsTable["fed_TMP_centaur"               ]={"fed",1,0, 1,   65000, 40,"fed_medium"        , 210, 500,{{  500,  5000},{ 250, 10000},{ 150, 15000},},}
shipClassStatsTable["fed_TMP_miranda"               ]={"fed",1,0, 1,   62500, 40,"fed_medium"        , 243, 500,{{  500,  5000},{ 250, 10000},{ 150, 15000},},}
shipClassStatsTable["fed_TMP_constitution"          ]={"fed",1,0, 1,   82500, 40,"fed_medium"        , 305,1000,{{  700,  7000},{ 350, 14000},{ 210, 21000},},}
shipClassStatsTable["fed_TMP_constellation"         ]={"fed",1,0, 1,   85000, 40,"fed_medium"        , 310,1000,{{  700,  7000},{ 350, 14000},{ 210, 21000},},}
shipClassStatsTable["fed_TMP_excelsior"             ]={"fed",1,0, 1,  115000, 60,"fed_large"         , 469,1500,{{ 1000, 10000},{ 500, 20000},{ 300, 30000},},}
shipClassStatsTable["fed_TMP_ambassador"            ]={"fed",1,0, 1,  122500, 60,"fed_large"         , 562,1500,{{ 1200, 12000},{ 600, 24000},{ 360, 36000},},}
shipClassStatsTable["fed_TMP_midway"                ]={"fed",1,0, 1,  147500, 60,"fed_large"         , 639,1500,{{ 1300, 13000},{ 650, 26000},{ 390, 39000},},}
shipClassStatsTable["fed_TMP_resourcecollector"     ]={"fed",0,0,-1,    1200, 20,"fed_small"         ,  12,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["fed_TMP_resourcecontroller"    ]={"fed",0,1,-1,   17000, 40,"fed_medium"        , 151, 500,{{  400,  4000},{ 200,  8000},{ 120, 12000},},}

                                                  
shipClassStatsTable["kng_TMP_flagship"              ]={"kng",1,1, 1,   92500, 40,"default_large"     , 361,1000,{{  800,  8000},{ 400, 16000},{ 240, 24000},},}
shipClassStatsTable["kng_TMP_fighter"               ]={"kng",1,0, 1,   14500, 20,"default_small"     ,  15,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["kng_TMP_bomber"                ]={"kng",1,0, 1,   23000, 20,"default_small"     ,  15,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["kng_TMP_drone1"                ]={"kng",1,0, 1,    8000, 20,"default_small"     ,  15,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["kng_TMP_drone2"                ]={"kng",1,0, 1,    8000, 20,"default_small"     ,  15,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["kng_TMP_drone3"                ]={"kng",1,0, 1,    8000, 20,"default_small"     ,  15,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["kng_TMP_drone4"                ]={"kng",1,0, 1,    8000, 20,"default_small"     ,  15,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["kng_TMP_brel"                  ]={"kng",1,0, 1,   43500, 20,"default_small"     , 148, 500,{{  300,  3000},{ 150,  6000},{  90,  9000},},}
shipClassStatsTable["kng_TMP_kleev"                 ]={"kng",1,0, 1,   45500, 20,"default_small"     , 182, 500,{{  400,  4000},{ 200,  8000},{ 120, 12000},},}
shipClassStatsTable["kng_TMP_ktinga"                ]={"kng",1,0, 1,  105000, 40,"default_medium"    , 219, 500,{{  500,  5000},{ 250, 10000},{ 150, 15000},},}
shipClassStatsTable["kng_TMP_bertaa"                ]={"kng",1,0, 1,  102500, 40,"default_medium"    , 264, 500,{{  600,  6000},{ 300, 12000},{ 180, 18000},},}
shipClassStatsTable["kng_TMP_vodleh"                ]={"kng",1,0, 1,  122500, 40,"default_large"     , 405,1500,{{  900,  9000},{ 450, 18000},{ 270, 27000},},}
shipClassStatsTable["kng_TMP_swordofkahless"        ]={"kng",1,0, 1,  277500, 60,"default_large"     , 561,1500,{{ 1200, 12000},{ 600, 24000},{ 360, 36000},},}
                                                  
shipClassStatsTable["rom_TMP_flagship"              ]={"rom",1,1, 1,   82500, 40,"default_large"     , 361,1000,{{  800,  8000},{ 400, 16000},{ 240, 24000},},}
shipClassStatsTable["rom_TMP_fighter"               ]={"rom",1,0, 1,    9000, 20,"default_small"     ,  17,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["rom_TMP_bomber"                ]={"rom",1,0, 1,   11500, 20,"default_small"     ,  22,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["rom_TMP_draconarius"           ]={"rom",1,0, 1,   43000, 20,"default_small"     , 188, 500,{{  400,  4000},{ 200,  8000},{ 120, 12000},},}
shipClassStatsTable["rom_TMP_birdofprey"            ]={"rom",1,0, 1,   50000, 20,"default_medium"    , 228, 500,{{  500,  5000},{ 250, 10000},{ 150, 15000},},}
shipClassStatsTable["rom_TMP_stormbird"             ]={"rom",1,0, 1,   92500, 40,"default_medium"    , 228, 500,{{  500,  5000},{ 250, 10000},{ 150, 15000},},}                                                                                                    
shipClassStatsTable["rom_TMP_firehawk"              ]={"rom",1,0, 1,   82500, 60,"default_large"     , 361,1000,{{  800,  8000},{ 400, 16000},{ 240, 24000},},}
shipClassStatsTable["rom_TMP_dtalla"                ]={"rom",1,0, 1,  120000, 60,"rom_large"         , 500,1500,{{ 1000, 10000},{ 500, 20000},{ 300, 30000},},}                                                  
shipClassStatsTable["rom_TMP_resourcecontroller"    ]={"rom",0,1,-1,   45000, 40,"default_medium"    , 360,1000,{{  800,  8000},{ 400, 16000},{ 240, 24000},},}
                                                  
shipClassStatsTable["aux_TMP_GRN_fighter"           ]={"grn",1,1, 1,   16000, 20,"default_small"     ,  20,   0,{{  100,  1000},{  50,  2000},{  30,  3000},},}
shipClassStatsTable["aux_TMP_GRN_grendel"           ]={"grn",1,1, 1,  172500, 40,"default_large"     , 500,1500,{{ 1000, 10000},{ 500, 20000},{ 300, 30000},},}
