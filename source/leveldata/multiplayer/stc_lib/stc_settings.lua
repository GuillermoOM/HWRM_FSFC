----------------------------------------------------------------------------------------------------
-- SETTINGS - The Magic Land of All Global Constants
----------------------------------------------------------------------------------------------------
-- 
----------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------
-- RACE ASSIGNMENT
----------------------------------------------------------------------------------------------------
Terran = 1
Vasudan = 2
Shivan = 3
UEF = 4
Random = 5
Observer = 6
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
-- Time needed to recover warp AFTER the warp jump has been finished (in 1/20 seconds now apparently.)
WARP_RecoveryTime = 1200


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
	"ter_poseidon",
	"ter_poseidonfs1",
	"ter_charybdis",

	"vas_bes",
	"vas_maat",
	"vas_setekh",

	"shi_mephisto",
	"shi_mephistofs1",
	"shi_commnode",
}
-- No Real Ship Table
-- List of ship classes that can exist for a player, but we don't want it counting as a ship per win conditions.
noRealShipTable = 
{
	"ter_pharos",
	"ter_pegasus",

	"vas_geb",
	"vas_ptah",

	"subspacenode",
	"subspacenodefs1",
	"knossosdummy",
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
	{"ter_amazon", 6},
	{"ter_pegasus", 2},
	{"ter_perseus", 4},
	{"ter_myrmidon", 4},
	{"ter_ulysses", 4},
	{"ter_hercules", 4},
	{"ter_herculesmk2", 4},	
	{"ter_erinyes", 4},	
	{"ter_ares", 4},	
	{"ter_loki", 4},
	{"ter_mara", 4},

	{"ntf_zeus", 3},
	{"ntf_medusa", 2},
	{"ntf_perseus", 4},
	{"ntf_myrmidon", 4},
	{"ntf_ulysses", 4},
	{"ntf_hercules", 4},
	{"ntf_herculesmk2", 4},	
	{"ntf_ursa", 2},		
	{"ntf_loki", 4},

	{"ter_apollo", 4},	
	{"ter_valkyrie", 4},	
	{"ter_herculesfs1", 4},	
	{"ter_lokifs1", 4},
	{"ter_ulyssesfs1", 4},
	{"ter_dragonfs1", 4},
	
	{"ter_zeus", 3},	
	{"ter_artemis", 3},	
	{"ter_medusa", 2},	
	{"ter_ursa", 2},
	{"ter_boanerges", 2},	
	{"ter_artemisDH", 3},

	{"ter_zeusfs1", 3},	
	{"ter_athena", 3},	
	{"ter_medusafs1", 3},	
	{"ter_ursafs1", 2},

	{"vas_ptah", 2},
	{"vas_seth", 4},	
	{"vas_tauret", 4},
	{"vas_serapis", 4},
	{"vas_thoth", 4},
	{"vas_horus", 4},

	{"hol_anubis", 4},
	{"hol_anubisram", 4},
	{"hol_seth", 4},	
	{"hol_thoth", 4},
	{"hol_horus", 4},
	{"vas_ulyssesfs1", 4},

	{"vas_osiris", 3},
	{"vas_bakha", 3},	
	{"vas_sehkmet", 2},

	{"hol_osiris", 3},	
	{"hol_amun", 2},
	{"vas_sekhmetfs1", 2},	
	{"vas_sekhmet", 2},

	{"shi_dragon", 4},
	{"shi_mara", 4},
	{"shi_aeshma", 4},
	{"shi_basilisk", 4},
	{"shi_manticore", 4},
	{"shi_astaroth", 4},

	{"shi_dragonfs1", 4},
	{"shi_scorpion", 4},
	{"shi_basiliskfs1", 4},
	{"shi_manticorefs1", 4},
	{"shi_gorgon", 3},


	{"shi_nahema", 3},
	{"shi_taurvi", 3},
	{"shi_nephilim", 2},
	{"shi_seraphim", 2},

	{"shi_shaitan", 3},
	{"shi_nephilimfs1", 2},
	{"shi_seraphimfs1", 2},

	{"ter_cerberus", 4},
	{"ter_alastor", 4},
	{"vas_ankh", 4},
	{"vas_edjo", 4},
	{"shi_trident", 4},
	{"shi_belial", 4},

}


-- Ship Class Table
-- List of the names from all ship class
shipClassTable = {
--FS1 TERRANS
"ter_herculesfs1",
"ter_lokifs1",
"ter_ulyssesfs1",
"ter_dragonfs1",
"ter_apollo",
"ter_valkyrie",
"ter_athena",
"ter_medusafs1",
"ter_ursafs1",
"ter_zeusfs1",
"ter_fenrisfs1",
"ter_leviathanfs1",
"ter_chronos",
"ter_faustus",
"ter_zephyrusfs1",
"ter_poseidonfs1",
"ter_elysiumfs1",
"ter_orionfs1",
"ter_hadesfs1",
"ter_centaur",
"ter_cerberus",
"ter_arcadia",
"ter_pharos",

--FS2 TERRANS
"ter_amazon",
"ter_hercules",
"ter_loki",
"ter_ulysses",
"ter_herculesmk2",
"ter_ares",
"ter_perseus",
"ter_pegasus",
"ter_erinyes",
"ter_myrmidon",
"ter_zeus",
"ter_artemis",
"ter_artemisDH",
"ter_medusa",
"ter_ursa",
"ter_boanerges",
"ter_fenris",
"ter_leviathan",
"ter_aeolus",
"ter_deimos",
"ter_orion",
"ter_argo",
"ter_hecate",
"ter_hades",
"ter_zephyrus",
"ter_elysium",
"ter_poseidon",
"ter_charybdis",
"ter_mara",
"ter_hygeia",
"ter_alastor",
"ter_mjolnir",
"ter_colossus",

--NTF TERRANS
"ntf_hercules",
"ntf_loki",
"ntf_ulysses",
"ntf_herculesmk2",
"ntf_perseus",
"ntf_myrmidon",
"ntf_zeus",
"ntf_medusa",
"ntf_ursa",
"ntf_fenris",
"ntf_leviathan",
"ntf_aeolus",
"ntf_deimos",
"ntf_orion",
"ntf_iceni",
"ntf_hecate",

--FS1 VASUDANS

"hol_amun",
"hol_anubis",
"hol_anubisram",
"hol_horus",
"hol_osiris",
"hol_seth",
"hol_thoth",
"vas_ulyssesfs1",
"vas_hol_typhon",
"vas_pvntyphon",
"vas_sehkmetfs1",
"vas_karnak",
"vas_satisfs1",
"vas_imhotep",
"vas_scarab",
"vas_ankh",
"vas_bast",
"vas_maat",
"vas_isisfs1",
"hol_aten",
"hol_atenram",
"hol_atenramram",
"vas_geb",

--FS2 VASUDANS


"vas_ptah",
"vas_seth",
"vas_horus",
"vas_thoth",
"vas_serapis",
"vas_tauret",
"vas_osiris",
"vas_bakha",
"vas_sehkmet",
"vas_aten",
"vas_mentu",
"vas_sobek",
"vas_typhon",
"vas_hatshepsut",
"vas_colossus",
"vas_isis",
"vas_anuket",
"vas_satis",
"vas_bes",
"vas_edjo",
"vas_mjolnir",
"vas_setekh",
"vas_nephthys",
"vas_colossus",

--SHIVAN FS1

"shi_scorpion",
"shi_dragonfs1",
"shi_gorgon",
"shi_manticorefs1",
"shi_basiliskfs1",
"shi_shaitan",
"shi_nephilimfs1",
"shi_seraphimfs1",
"shi_cainfs1",
"shi_lilithfs1",
"shi_demonfs1",
"shi_azraelfs1",
"shi_rahufs1",
"shi_mephistofs1",
"shi_trident",
"shi_asmodeusfs1",
"shi_luciferfs1",

--SHIVAN FS2

"shi_dragon",
"shi_manticore",
"shi_astaroth",
"shi_basilisk",
"shi_aeshma",
"shi_mara",
"shi_nahema",
"shi_taurvi",
"shi_nephilim",
"shi_seraphim",
"shi_rakshasa",
"shi_cain",
"shi_lilith",
"shi_moloch",
"shi_demon",
"shi_ravana",
"shi_sathanas",
"shi_lucifer",
"shi_azrael",
"shi_rahu",
"shi_mephisto",
"shi_belial",
"shi_asmodeus",
"shi_commnode",
"shi_sathanas",

"subspacenode",
"subspacenodefs1",
"knossos",
"knossosdummy",

}


-- Ship Class Stats Table
-- Every entry contains of:
-- [RacePrefix], [IsMilitary], [WarpIn], [Shield], [ShipWorth], [DieTime], [Explosion], [ShipSize], [Shockwave], [Damage Radii Table]
-- 1             2             3         4         5            6          7            8           9            10
-- 
-- RacePrefix : "ter", "vas", "shi", ...
-- IsMilitary : 0 = is military unit, 1 = is not military unit
-- WarpIn     : 1 = warps in when built, 0 = doesn't warp in
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
shipClassStatsTable["ter_amazon"                    ]={"kng",0,0,1,     500, 00,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ter_pegasus"                   ]={"kng",0,0,1,     500, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_loki"                      ]={"kng",0,0,1,     500, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_hercules"                  ]={"kng",0,0,1,     600, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_herculesmk2"               ]={"kng",0,0,1,     600, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_perseus"                   ]={"kng",0,0,1,     600, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_ulysses"                   ]={"kng",0,0,1,     400, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_myrmidon"                  ]={"kng",0,0,1,     600, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_ares"                      ]={"kng",0,0,1,     800, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_erinyes"                   ]={"kng",0,0,1,     950, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_apollo"                    ]={"kng",0,0,1,     500, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_valkyrie"                  ]={"kng",0,0,1,     500, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_herculesfs1"               ]={"kng",0,0,1,     600, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_lokifs1"                   ]={"kng",0,0,1,     600, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_ulyssesfs1"                ]={"kng",0,0,1,     600, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_dragonfs1"                ]={"kng",0,0,1,     600, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_athena"                    ]={"kng",0,0,1,     400, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ter_zeusfs1"                   ]={"kng",0,0,1,     600, 00,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ter_medusafs1"                 ]={"kng",0,0,1,     800, 00,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ter_ursafs1"                   ]={"kng",0,0,1,     950, 00,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ter_zeus"                      ]={"kng",0,0,1,     600, 20,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ter_artemis"                   ]={"kng",0,0,1,     700, 20,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ter_artemisDH"                 ]={"kng",0,0,1,     950, 20,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ter_medusa"                    ]={"kng",0,0,1,     700, 20,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ter_ursa"                      ]={"kng",0,0,1,     950, 20,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ter_boanerges"                 ]={"kng",0,0,1,     950, 20,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ter_fenris"                    ]={"kng",0,1,-1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["ter_leviathan"                 ]={"kng",0,1,-1,     900, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["ter_fenrisfs1"                 ]={"kng",0,1,-1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["ter_leviathanfs1"              ]={"kng",0,1,-1,     900, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["ter_aeolus"                    ]={"kng",0,1,-1,    1000, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["ter_deimos"                    ]={"kng",0,1,-1,    3000, 60,"default_medium"    , 750, 1500,{{  3500,   15},{ 1500, 50},{ 750,  100},},}
shipClassStatsTable["ter_orion"                     ]={"kng",0,1,-1,   12500, 140,"default_large"     , 2000,3000,{{  5000,  25},{ 2500, 50},{ 1250, 100},{ 100, 1000},},}
shipClassStatsTable["ter_orionfs1"                  ]={"kng",0,1,-1,   12500, 140,"default_large"     , 2000,3000,{{  5000,  25},{ 2500, 50},{ 1250, 100},{ 100, 1000},},}
shipClassStatsTable["ter_hecate"                    ]={"kng",0,1,-1,   12500, 140,"default_large"     , 2000,3000,{{  5000,  25},{ 2500, 50},{ 1250, 100},{ 100, 1000},},}
shipClassStatsTable["ter_hades"                     ]={"kng",0,1,-1,   27500, 140,"default_large"     , 3000,3000,{{  6500,  75},{ 3000, 150},{ 1500, 300},{ 100, 1000},},}
shipClassStatsTable["ntf_iceni"                     ]={"kng",0,1,-1,   10000, 80,"default_large"     , 1000,1500,{{  5000,  25},{ 2500, 50},{ 1250, 100},},}
shipClassStatsTable["ter_hadesfs1"                  ]={"kng",0,1,-1,   27500, 140,"default_large"     , 3000,3000,{{  6500,  75},{ 3000, 150},{ 1500, 300},{ 100, 1000},},}
shipClassStatsTable["ter_arcadia"                   ]={"kng",0,1,0,   27500, 140,"default_large"     , 3000,3000,{{  6500,  75},{ 3000, 150},{ 1500, 300},{ 100, 1000},},}
shipClassStatsTable["ter_colossus"                  ]={"kng",0,1,-1,  150000, 280,"default_superlarge", 6000,5000,{{  8000,  75},{ 4000, 150},{ 2000, 300},{ 100, 1000},},}
shipClassStatsTable["ter_elysium"                   ]={"kng",1,0,-1,     250, 05,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ter_elysiumfs1"                ]={"kng",1,0,-1,     250, 05,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ter_zephyrus"                  ]={"kng",0,1,-1,     500, 10,"default_large"     , 450, 1500,{{  3000,  25},{ 1500, 50},{ 750,  100},},}
shipClassStatsTable["ter_zephyrusfs1"               ]={"kng",0,1,-1,     500, 10,"default_large"     , 450, 1500,{{  3000,  25},{ 1500, 50},{ 750,  100},},}
shipClassStatsTable["ter_faustus"                   ]={"kng",0,1,-1,     500, 10,"default_large"     , 450, 1500,{{  3000,  25},{ 1500, 50},{ 750,  100},},}
shipClassStatsTable["ter_argo"                      ]={"kng",1,1,-1,     600, 10,"default_medium"    , 284, 500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["ter_poseidon"                  ]={"kng",1,1,-1,     400, 10,"default_medium"    , 284, 500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["ter_chronos"                   ]={"kng",1,1,-1,     600, 10,"default_medium"    , 284, 500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["ter_poseidonfs1"               ]={"kng",1,1,-1,     400, 10,"default_medium"    , 284, 500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["ter_alastor"                   ]={"kng",0,0,0,     150, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["ter_cerberus"                  ]={"kng",0,0,0,     150, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["ter_pharos"                    ]={"kng",0,0,0,     150, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["ter_mjolnir"                   ]={"fed",0,1,0,    1400, 20,"fed_small"         ,  34,   0, {},}
shipClassStatsTable["ter_pharos"                    ]={"kng",1,0,0,      50, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["ter_charybdis"                 ]={"kng",1,1,-1,    1500, 20,"default_medium"    , 284, 500, {{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["ter_mara"                      ]={"kng",0,0,1,     950, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["ter_hygeia"                    ]={"kng",1,0, 1,     500, 5,"default_medium"    , 284, 500, {{  1000,  25},{ 500,  50},{ 250, 100},},}
shipClassStatsTable["ter_centaur"                   ]={"kng",1,0, 1,     500, 5,"default_medium"    , 284, 500, {{  1000,  25},{ 500,  50},{ 250, 100},},}


shipClassStatsTable["ntf_loki"                      ]={"kng",0,0,1,     500, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ntf_hercules"                  ]={"kng",0,0,1,     600, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ntf_herculesmk2"               ]={"kng",0,0,1,     600, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ntf_perseus"                   ]={"kng",0,0,1,     600, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ntf_ulysses"                   ]={"kng",0,0,1,     400, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ntf_myrmidon"                  ]={"kng",0,0,1,     600, 00,"default_small"     ,   20,   0, {},}
shipClassStatsTable["ntf_zeus"                      ]={"kng",0,0,1,     600, 20,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ntf_medusa"                    ]={"kng",0,0,1,     700, 20,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ntf_ursa"                      ]={"kng",0,0,1,     950, 20,"default_small"     ,   30,   0, {},}
shipClassStatsTable["ntf_fenris"                    ]={"kng",0,1,-1,     600, 5,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["ntf_leviathan"                 ]={"kng",0,1,-1,     900, 5,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["ntf_aeolus"                    ]={"kng",0,1,-1,    1000, 5,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["ntf_deimos"                    ]={"kng",0,1,-1,    3000, 60,"default_medium"    , 750, 1500,{{  3500,   15},{ 1500, 50},{ 750,  100},},}
shipClassStatsTable["ntf_orion"                     ]={"kng",0,1,-1,   12500, 140,"default_large"     , 2000,3000,{{  5000,  25},{ 2500, 50},{ 1250, 100},},}
shipClassStatsTable["ntf_hecate"                    ]={"kng",0,1,-1,   12500, 140,"default_large"     , 2000,3000,{{  5000,  25},{ 2500, 50},{ 1250, 100},},}


                                                  
shipClassStatsTable["vas_ptah"                  ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_seth"                  ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_horus"                 ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_thoth"                 ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_serapis"               ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_tauret"                ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_bakha"                 ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_osiris"                ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_sehkmet"               ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_aten"                  ]={"kng",0,1,-1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["vas_mentu"                 ]={"kng",0,1,-1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["vas_sobek"                 ]={"kng",0,1,-1,    3000, 60,"default_medium"    , 750, 1500,{{  3500,  25},{ 1500, 50},{ 750, 75},},}
shipClassStatsTable["vas_typhon"                ]={"kng",0,1,-1,   12500, 140,"default_large"     , 2000,3000,{{  5000,  25},{ 2500, 50},{ 1250, 100},{ 100, 1000},},}
shipClassStatsTable["vas_hatshepsut"            ]={"kng",0,1,-1,   12500, 140,"default_large"     , 2000,3000,{{  5000,  25},{ 2500, 50},{ 1250, 100},{ 100, 1000},},}
shipClassStatsTable["vas_colossus"              ]={"kng",0,1,-1,  150000, 280,"default_superlarge", 6000,5000,{{  8000,  75},{ 4000, 150},{ 2000, 300},{ 100, 1000},},}
shipClassStatsTable["vas_isis"                  ]={"kng",1,0,-1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_anuket"                ]={"kng",0,1,-1,     500, 10,"default_large"     , 450, 1500,{{  3000,  25},{ 1500, 50},{ 750,  100},},}
shipClassStatsTable["vas_satis"                 ]={"kng",0,1, 1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["vas_bes"                   ]={"kng",0,1, 1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["vas_edjo"                  ]={"kng",1,0,0,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_mjolnir"               ]={"kng",0,0,0,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_setekh"                ]={"kng",0,1, 1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["vas_nephthys"              ]={"kng",1,0,-1,     500, 5,"default_medium"    , 284, 500, {{  1000,  25},{ 500,  50},{ 250, 100},},}
shipClassStatsTable["vas_geb"                   ]={"kng",1,0,-1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["hol_anubis"                ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["hol_anubisram"             ]={"kng",1,0,1,     250, 01,"default_small"     ,   7,   0, {},}
shipClassStatsTable["hol_seth"     		]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["hol_horus"                 ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["hol_thoth"                 ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["hol_osiris"                ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["hol_amun"                  ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["hol_aten"                  ]={"kng",0,1,-1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["hol_atenram"               ]={"kng",0,1,-1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   25},{ 1000, 50},{ 500,  100},},}
shipClassStatsTable["hol_atenramram"            ]={"kng",0,1,-1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   25},{ 1000, 50},{ 500,  100},},}
shipClassStatsTable["vas_pvntyphon"             ]={"kng",0,1,-1,   12500, 140,"default_large"     , 2000,3000,{{  5000,  25},{ 2500, 50},{ 1250, 100},{ 100, 1000},},}
shipClassStatsTable["vas_hol_typhon"            ]={"kng",0,1,-1,   12500, 140,"default_large"     , 2000,3000,{{  5000,  25},{ 2500, 50},{ 1250, 100},{ 100, 1000},},}
shipClassStatsTable["vas_isisfs1"               ]={"kng",1,0,-1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_maat"                  ]={"kng",0,1,-1,     600, 10,"default_medium"    , 300, 1500,{{  3000,  25},{ 1500, 50},{ 750,  100},},}
shipClassStatsTable["vas_bast"                  ]={"kng",0,1,-1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["vas_ankh"                  ]={"kng",1,0,0,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_scarab"                ]={"kng",1,0, 1,     500, 3,"default_medium"    , 284, 500, {{  1000,  25},{ 500,  50},{ 250, 100},},}
shipClassStatsTable["vas_satisfs1"              ]={"rom",1,0, 1,   18500, 10,"rom_small"         ,  32,   0,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["vas_karnak"                ]={"kng",0,1,-1,  150000, 160,"default_superlarge", 6000,5000,{{  6500,  75},{ 3000, 150},{ 1500, 300},},}
shipClassStatsTable["vas_sehkmetfs1"            ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["vas_ulyssesfs1"            ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}

shipClassStatsTable["shi_dragon"                    ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_manticore"                 ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_astaroth"                  ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_basilisk"                  ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_aeshma"                    ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_mara"                      ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_nahema"                    ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_taurvi"                    ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_nephilim"                  ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_seraphim"                  ]={"kng",1,0,1,     250, 20,"default_small"     ,   7,   0, {},}

shipClassStatsTable["shi_rakshasa"                  ]={"kng",0,1,-1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}                                              
shipClassStatsTable["shi_cain"                      ]={"kng",0,1,-1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["shi_lilith"                    ]={"kng",0,1,-1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}

shipClassStatsTable["shi_moloch"                    ]={"kng",0,1,-1,    3000, 60,"default_medium"    , 750, 1500,{{  3500,  25},{ 1500, 50},{ 750, 75},{ 100, 1000},},}
shipClassStatsTable["shi_demon"                     ]={"kng",0,1,-1,   12500, 140,"default_large"     , 2000,3000,{{  5000,  25},{ 2500, 50},{ 1250, 100},{ 100, 1000},},}
shipClassStatsTable["shi_ravana"                    ]={"kng",0,1,-1,   12500, 140,"default_large"     , 2000,3000,{{  5000,  25},{ 2500, 50},{ 1250, 100},{ 100, 1000},},}
shipClassStatsTable["shi_sathanas"                  ]={"kng",0,1,-1,  150000, 280,"default_superlarge", 6000,5000,{{  8000,  75},{ 4000, 150},{ 2000, 300},{ 100, 1000},},}
shipClassStatsTable["shi_lucifer"                   ]={"kng",0,1,-1,   27500, 140,"default_large"     , 3000,3000,{{  6500,  75},{ 3000, 150},{ 1500, 300},{ 100, 1000},},}
                                                  
shipClassStatsTable["shi_luciferfs1"                ]={"kng",0,1,-1,   27500, 140,"default_large"     , 3000,3000,{{  6500,  75},{ 3000, 150},{ 1500, 300},{ 100, 1000},},}
shipClassStatsTable["shi_azrael"                    ]={"kng",0,0,-1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_rahu"                      ]={"kng",0,1,-1,     500, 10,"default_large"     , 450, 1500,{{  3000,  25},{ 1500, 50},{ 750,  100},},}
shipClassStatsTable["shi_mephisto"                  ]={"kng",0,1, 1,     600, 5,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["shi_belial"                    ]={"kng",0,0,0,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_asmodeus"                  ]={"kng",0,1, 1,     600, 5,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["shi_commnode"                  ]={"kng",0,1,0,    5000, 140,"default_superlarge", 6000,5000,{{ 10000,  25},{ 5000, 100},{ 2500, 300},},}
shipClassStatsTable["shi_scorpion"                  ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_dragonfs1"                 ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_gorgon"                    ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}                                                 
shipClassStatsTable["shi_manticorefs1"              ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_basiliskfs1"               ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_shaitan"                   ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_nephilimfs1"               ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_seraphimfs1"               ]={"kng",0,0,1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_cainfs1"                   ]={"kng",0,1,-1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["shi_lilithfs1"                 ]={"kng",0,1,-1,     600, 10,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["shi_demonfs1"                  ]={"kng",0,1,-1,   12500, 140,"default_large"     , 2000,3000,{{  5000,  25},{ 2500, 50},{ 1250, 100},{ 100, 1000},},}
shipClassStatsTable["shi_azraelfs1"                 ]={"kng",0,0,-1,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_rahufs1"                   ]={"kng",0,1,-1,     500, 05,"default_large"     , 450, 1500,{{  3000,  25},{ 1500, 50},{ 750,  100},},}
shipClassStatsTable["shi_mephistofs1"               ]={"kng",0,1, 1,     600, 5,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}
shipClassStatsTable["shi_trident"                   ]={"kng",0,0,0,     500, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["shi_asmodeusfs1"               ]={"kng",0,1, 1,     600, 5,"default_medium"    , 300, 1500,{{  2000,   10},{ 1000, 15},{ 500,  50},},}

shipClassStatsTable["subspacenode"                  ]={"kng",1,0,0,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["subspacenodefs1"               ]={"kng",1,0,0,     250, 20,"default_small"     ,   7,   0, {},}
shipClassStatsTable["knossos"                       ]={"kng",1,0,0,     150000, 190,"default_superlarge", 6000,5000,{{  10000,  75},{ 6000, 150},{ 4000, 300},{ 2000, 600},},}
shipClassStatsTable["knossosdummy"                  ]={"kng",1,0,0,     250, 20,"default_small"     ,   7,   0, {},}
