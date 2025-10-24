----------------------------------------------------------------------------------------------------
-- GLOBAL SOB-GROUP SPLITTING ROUTINE
----------------------------------------------------------------------------------------------------
-- This routine will give you a table of all ingame ships seperated into single SobGroups. The
-- structure is as follows:
--
--                          globalShipTable[i][j][k]
--
-- where i is the playerindex (i = 0..Universe_PlayerCount()-1 ),
--       j the shipindex (j = 1..getn(globalShipTable[i])),
--       k the statindex (k = 1..getn(globalShipTable[i][j])).
--
-- A player i owns a ship j with stat k.
-- Access the ship's SobGroup using: globalShipTable[i][j][SobGroup]
--
-- The stats are as follows:
-- [1] - SobGroup-Index
-- [2] - Race: Needed for warp that a captured ship keeps it's warp flash colour
-- [3] - IsAtWarp: 0 = not at warp, 1 = preparing for warp, 2 = at warp, 3 = leaving warp
-- [4] - WarpTimer: 0 = previous warp move completely finished
-- [5] - Strength
-- [6] - Experience
-- [7] - Rank - we start with rank = 1
-- [8] - Shield: 0 = shield off, 1 = shield on, -1 = no shield
-- [9] - Cloak: 0 = cloak off, 1 = cloak on, 2 = cloak detected
-- [10] - ShieldHealth
-- [11] - CloakTimer
-- [12] - ExplosionDamageTimer: -2 = ship deals no explosion damage, -1 = ship is dead (damage dealt), > 0 = explosion damage countdown set, 0 = deal explosion damage
-- To add more values modify the function "createShipSpecificTable(...)".
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
SobGroupIndex = 1
SobGroup      = 14
ShipClass     = 13
Race          = 2
IsMilitary    = 15
IsAtWarp      = 3
WarpTimer     = 4
Strength      = 5
Experience    = 6
Rank          = 7
Shield        = 8
Cloak         = 9
ShieldHealth  = 10
CloakTimer    = 11
DeathTimer    = 12
List          = 16

-- globalShipTable          : contains all single-ship-filled SobGroups of every player
-- globalFreeShipIndexTable : contains unused SobGroup indices (some will get unused, because ships get destroyed)
globalShipTable = {}
globalFreeShipIndexTable = {}

-- Initialization
sob_reference = "sob_reference"
function sobSplitter_Init()
	-- Fill the GST with an empty ship-table for each player.
	-- Create a table for all already splitted ships. The plan is to split only the ships we haven't split yet.
	for i = 0, Universe_PlayerCount()-1 do
		globalShipTable[i] = {}
		globalFreeShipIndexTable[i] = {}
		
		SobGroup_Create("Player"..i.."_alreadySplittedShips")
		SobGroup_Clear("Player"..i.."_alreadySplittedShips")
	end
	
	-- Create an empty SobGoup for reference for the split function. It'll have the position {0,0,0}
	SobGroup_Create(sob_reference)
	SobGroup_Clear(sob_reference)
end

-- Main Rule: will update all splitted sobgroups
function sobSplitterRule()
	-- update the GST: for each player: check for ship deaths and births
	for i = 0, Universe_PlayerCount()-1 do
		if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
			checkForDeaths(i)
			checkForBirths(i)
		end
	end
end

-- Deaths check: - loop throug all splitted ships and check if a SobGroup is empty
--               - if a ship got lost: remove it from GST and add the index to the pool
function checkForDeaths(i)
	local size = getn(globalShipTable[i])
	local j = 1
	while( j <= size ) do	
		if(SobGroup_Empty(globalShipTable[i][j][SobGroup]) == 1) then
			addFreeShipIndex(i, globalShipTable[i][j][SobGroupIndex])
			tremove(globalShipTable[i], j)
			j = j - 1
			size = size - 1 -- this doesn't work with a for loop
		end
		j = j + 1
	end
end

-- Births check: - split all new ships (temp = all - splitted) 
function checkForBirths(i)
	SobGroup_Create("temp")
	SobGroup_Clear("temp")
	SobGroup_FillSubstract("temp", "Player_Ships"..i, "Player"..i.."_alreadySplittedShips")
	
	-- if any new ships...
	if(SobGroup_Empty("temp") == 0) then
		-- it turned out that it is wise to choose a random ship of a player as reference and not {0,0,0}
		if( getn(globalShipTable[i]) > 0 ) then
			SobGroup_Clear(sob_reference)
			SobGroup_SobGroupAdd(sob_reference, globalShipTable[i][random(getn(globalShipTable[i]))][SobGroup])
		end
		
		splitSobGroup("temp", SOB_maximumSpan, i)
	end
	
end

----------------------------------------------------------------------------------------------------
-- Main SobGroup Splitting Method
-- Parameters: sob_toSplit   : SobGroup, which should be splitted into single ships
--             span          : float, which determines the distance at which we split the sobgroup
--             i             : Player Index
-- our reference for splitting is sob_reference; see init function for more information
SOB_heap = {}
function splitSobGroup(sob_toSplit, span, i)
	local sob = sob_toSplit
	local origin = 0
	local span = span
	tinsert(SOB_heap, {sob, origin, span})
	
	while( getn(SOB_heap) > 0 ) do
		local tmp = tremove(SOB_heap)
		sob = tmp[1]
		origin = tmp[2]
		span = 0.5*tmp[3]
		
		if SobGroup_Count(sob) == 1 then
			createShipSpecificTable(i, getFreeShipIndex(i), sob)
			
		elseif SobGroup_Count(sob) > 1 and span > SOB_minimumSpan then
			local sob_lower = SOB_getGenericSobGroup()
			SobGroup_FillProximitySobGroup(sob_lower, sob, sob_reference, origin + span)
			tinsert(SOB_heap, {sob_lower, origin, span})
			
			local sob_upper = SOB_getGenericSobGroup()
			SobGroup_FillSubstract(sob_upper, sob, sob_lower)
			tinsert(SOB_heap, {sob_upper, origin+span, span})
			
		elseif span <= SOB_minimumSpan then
			for k = 1, getn(SOB_SquadronTable) do
				if( SobGroup_Count(sob) == SOB_SquadronTable[k][2] and SobGroup_AreAnyOfTheseTypes(sob, SOB_SquadronTable[k][1]) == 1) then
					createShipSpecificTable(i, getFreeShipIndex(i), sob)
					break
				end
			end
		end
	end
	
end

-- returns a generic SobGroup
SOB_genericSobGroupCounter = 0
function SOB_getGenericSobGroup()
	SOB_genericSobGroupCounter = SOB_genericSobGroupCounter + 1
	local sobgroup = "SOB_genericGroup"..SOB_genericSobGroupCounter
	SobGroup_Create(sobgroup)
	SobGroup_Clear(sobgroup)
	return sobgroup
end


----------------------------------------------------------------------------------------------------
-- returns the next free SobGroup index.
function getFreeShipIndex(i)
	local j = 1
	-- do we have old ship indices?
	if( getn(globalFreeShipIndexTable[i]) > 0 ) then
		j = tremove(globalFreeShipIndexTable[i])
	-- if not create a new one
	else
		j = 1 + getn(globalShipTable[i])
	end
	return j
end

-- adds an index to the pool
function addFreeShipIndex(i, j)
	tinsert(globalFreeShipIndexTable[i], j)
end

-- creates a shipstats table. This table will contain all information about a ship: SobGroup-index, warp-timer, XP, etc.
----------------------------------------------------------------------------------------------------
-- adding a ship properly: - get an index for the ship specific SobGroup
--                         - create a SobGroup with the index as suffix
--                         - fill the ship into the new SobGroup
--                         - add a new entry to the GST
function createShipSpecificTable(i, j, sob_newship)
	
	SobGroup_Create("Player"..i.."_ship"..j)
	SobGroup_Clear("Player"..i.."_ship"..j)
	SobGroup_SobGroupAdd("Player"..i.."_ship"..j, sob_newship)
	SobGroup_SobGroupAdd("Player"..i.."_alreadySplittedShips", "Player"..i.."_ship"..j)
	
	--------------------------------------------------------------------------------------------------
	
	-- create default ship specific table
	local shipSpecificTable = {}
	shipSpecificTable[SobGroupIndex] = j
	shipSpecificTable[SobGroup]      = "Player"..i.."_ship"..j
	shipSpecificTable[ShipClass]     = "default"
	-- shipSpecificTable[Race]          = "fed"
	-- shipSpecificTable[IsMilitary]     = 0
	-- shipSpecificTable[IsAtWarp]      = 0
	shipSpecificTable[WarpTimer]     = 0
	-- shipSpecificTable[Strength]      = 1
	shipSpecificTable[Experience]    = 0
	shipSpecificTable[Rank]          = 1
	-- shipSpecificTable[Shield]        = 1
	shipSpecificTable[Cloak]         = 0
	shipSpecificTable[ShieldHealth]  = 0
	shipSpecificTable[CloakTimer]    = 0
	-- shipSpecificTable[DeathTimer]    = -1
	shipSpecificTable[List]          = {}
	
	-- search in the shipClassTable for the new ship
	for k = 1, getn(shipClassTable) do
		if( SobGroup_AreAnyOfTheseTypes("Player"..i.."_ship"..j, shipClassTable[k]) == 1) then
			shipSpecificTable[ShipClass] = shipClassTable[k]
			break
		end
	end
	
	-- not found? Then note this in the log
	if( shipSpecificTable[ShipClass] == "default" ) then
		print(">> SOB SPLITTER >> | WARNING! SHIP CLASS NOT FOUND! Using default settings.")
	end
	
	-- set ship specific values from the shipClassStatsTable
	shipSpecificTable[Race]          = shipClassStatsTable[shipSpecificTable[ShipClass]][1]
	shipSpecificTable[IsMilitary]    = shipClassStatsTable[shipSpecificTable[ShipClass]][2]
	shipSpecificTable[IsAtWarp]      = shipClassStatsTable[shipSpecificTable[ShipClass]][3] * 2
	shipSpecificTable[Strength]      = shipClassStatsTable[shipSpecificTable[ShipClass]][5]
	shipSpecificTable[Shield]        = shipClassStatsTable[shipSpecificTable[ShipClass]][4]
	shipSpecificTable[DeathTimer]    = shipClassStatsTable[shipSpecificTable[ShipClass]][6]
	
	-- check if new ship was a keeper, set to no warp, if true
	-- ERROR: somehow a keeper is added several times???!!!
	for k = 1, KeeperCount do
		if( SobGroup_GroupInGroup("sob_Keeper"..k, "Player"..i.."_ship"..j) == 1 ) then
			shipSpecificTable[IsAtWarp] = 0
			break
		end
	end
	
	--------------------------------------------------------------------------------------------------
	-- MODIFICATIONS FOR INVASION GAME MODE
	
	-- manually defined warp in
	-- if( GetGameSettingAsNumber("startingfleetoption")  ~= 1
	-- and GetGameSettingAsNumber("startingfleetoption")  ~= 4
	-- and SobGroup_AreAnyOfTheseTypes("Player"..i.."_ship"..j, "fed_TMP_resourcecollector,fed_TNG_resourcecollector,kng_TNG_resourcecollector,rom_TNG_resourcecollector") == 0
	-- and SobGroup_AreAnyOfTheseTypes("Player"..i.."_ship"..j, "fed_TMP_drone1,fed_TMP_drone2,fed_TMP_drone3,fed_TMP_drone4,fed_TMP_drone5,fed_TMP_drone6,kng_TMP_drone1,kng_TMP_drone2,kng_TMP_drone3,kng_TMP_drone4") == 0) then
		-- shipSpecificTable[IsAtWarp] = 2
	-- end
	
	if( i == 1 ) then
		shipSpecificTable[IsAtWarp] = 2
	end
	
	if( i == ALLIANCE_playerSlot ) then
		shipSpecificTable[IsAtWarp] = 0
	end
	
	-- MODIFICATIONS FOR INVASION GAME MODE
	--------------------------------------------------------------------------------------------------
	
	tinsert(globalShipTable[i], shipSpecificTable)
	
	--------------------------------------------------------------------------------------------------
	
	-- set XP hardpoint health to 0.5 --> BOOST = 1
	SobGroup_SetHardPointHealth("Player"..i.."_ship"..j, "XP", 0.5)
	
	-- do research connected animations if necessary (deploy weapons etc.)
	researchAnimInitial(i, j)
	
	-- checks for ships with subsystem connected animations and abilities
	subsystemInitial(i, j)
	

end
