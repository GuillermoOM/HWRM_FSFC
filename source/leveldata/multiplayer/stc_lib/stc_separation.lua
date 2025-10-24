----------------------------------------------------------------------------------------------------
-- SAUCER SEPARATION ROUTINE
----------------------------------------------------------------------------------------------------

SEPARATION_GalaxyShipTable = {}
SEPARATION_StardriveShipTable = {}
SEPARATION_SaucerShipTable = {}

SEPARATION_Status_Docking = 1
SEPARATION_Status_Docked = 2
SEPARATION_Status_Launching = 3
SEPARATION_Status_Booked = 4
SEPARATION_Status_Separating = 5
SEPARATION_Status_Separated = 6
SEPARATION_Status_Integrated = 7

function SEPARATION_Initial(i, j)
	-- check if the newly added ship is a galaxy class. If true instantly dock a stardrive and a saucer to it
	if( SobGroup_AreAnyOfTheseTypes("Player"..i.."_ship"..j, "fed_TNG_galaxy") == 1
			and SEPARATION_IsAlreadyKnown(SEPARATION_GalaxyShipTable[i], j) == 0) then
		-- print(">> MVAM >> | Added Galaxy class with stardrive and saucer Section docked")
		
		local j_A = getFreeShipIndex(i)
		local stardrive = {
			ship   = j_A,
			timer  = 0,
			status = SEPARATION_Status_Integrated,
		}
		tinsert(SEPARATION_StardriveShipTable[i], stardrive)
		SobGroup_Create("sob_stardrive")
		SobGroup_Clear("sob_stardrive")
		SobGroup_SpawnNewShipInSobGroup(i, "fed_TNG_galaxy_stardrive", "MySquadron1", "sob_stardrive", "SEPARATION_Volume")
		SobGroup_DockSobGroupInstant("sob_stardrive", "Player"..i.."_ship"..j)
		createShipSpecificTable(i, j_A, "sob_stardrive")
		globalShipTable[i][getn(globalShipTable[i])][IsAtWarp] = 0
		
		local j_B = getFreeShipIndex(i)
		local saucer = {
			ship      = j_B,
			timer     = 0,
			status    = SEPARATION_Status_Integrated,
			stardrive = getn(SEPARATION_StardriveShipTable[i]),
			galaxy    = getn(SEPARATION_GalaxyShipTable[i]) + 1,
		}
		tinsert(SEPARATION_SaucerShipTable[i], saucer)
		SobGroup_Create("sob_saucer")
		SobGroup_Clear("sob_saucer")
		SobGroup_SpawnNewShipInSobGroup(i, "fed_TNG_galaxy_saucer", "MySquadron2", "sob_saucer", "SEPARATION_Volume")
		SobGroup_DockSobGroupInstant("sob_saucer", "Player"..i.."_ship"..j)
		createShipSpecificTable(i, j_B, "sob_saucer")
		globalShipTable[i][getn(globalShipTable[i])][IsAtWarp] = 0
		
		-- SobGroup_AbilityActivate("sob_saucer", AB_AcceptDocking, 0)
		
		local Galaxy = {
			ship      = j,
			status    = SEPARATION_Status_Integrated,
			timer     = 0,
			stardrive = getn(SEPARATION_StardriveShipTable[i]),
			saucer    = getn(SEPARATION_SaucerShipTable[i]),
		}
		tinsert(SEPARATION_GalaxyShipTable[i], Galaxy)
	
	-- if the newly added ship is a saucer section, add a galaxa class off the map
	elseif( SobGroup_AreAnyOfTheseTypes("Player"..i.."_ship"..j, "fed_TNG_galaxy_saucer") == 1
					and SEPARATION_IsAlreadyKnown(SEPARATION_SaucerShipTable[i], j) == 0) then
		-- print(">> MVAM >> | Added saucer Section and spawned a Galaxy class off the map")
		
		local j_B = getFreeShipIndex(i)
		local Galaxy = {
			ship      = j_B,
			status    = SEPARATION_Status_Separated,
			timer     = 0,
			stardrive = -1,
			saucer    = getn(SEPARATION_SaucerShipTable[i]) + 1,
		}
		tinsert(SEPARATION_GalaxyShipTable[i], Galaxy)
		SobGroup_Create("sob_galaxy")
		SobGroup_Clear("sob_galaxy")
		SobGroup_SpawnNewShipInSobGroup(i, "fed_TNG_galaxy", "MySquadron2", "sob_galaxy", "SEPARATION_Volume")
		SobGroup_Despawn("sob_galaxy")
		createShipSpecificTable(i, j_B, "sob_galaxy")
		globalShipTable[i][getn(globalShipTable[i])][IsAtWarp] = 0
		
		local saucer = {
			ship      = j,
			timer     = 0,
			status    = SEPARATION_Status_Separated,
			stardrive = -1,
			galaxy    = getn(SEPARATION_GalaxyShipTable[i]),
		}
		tinsert(SEPARATION_SaucerShipTable[i], saucer)
		
	-- newly added ship is a stardrive
	elseif( SobGroup_AreAnyOfTheseTypes("Player"..i.."_ship"..j, "fed_TNG_galaxy_stardrive") == 1
					and SEPARATION_IsAlreadyKnown(SEPARATION_StardriveShipTable[i], j) == 0) then
		-- print(">> MVAM >> | Added stardrive Section")
		
		local stardrive = {
			ship   = j,
			timer  = 0,
			status = SEPARATION_Status_Separated,
		}
		tinsert(SEPARATION_StardriveShipTable[i], stardrive)
		
	end
end


function SEPARATION_Init()
	Volume_AddSphere("SEPARATION_Volume", {0, 10^10, 0,}, 1000)
	
	for i = 0, Universe_PlayerCount()-1 do
		SEPARATION_StardriveShipTable[i] = {}
		SEPARATION_SaucerShipTable[i] = {}
		SEPARATION_GalaxyShipTable[i] = {}
	end
end


function SEPARATION_Rule()
	for i = 0, Universe_PlayerCount()-1 do
	
		------------------------------------------------------------------------------------------------
		-- remove empty groups out of lists (dead ships)
		-- Galaxy...
		local size = getn(SEPARATION_GalaxyShipTable[i])
		local j = 1
		while( j <= size ) do	
			if(SobGroup_Empty(SEPARATION_GetGalaxySob(i, j)) == 1) then
				for k = 1, getn(SEPARATION_SaucerShipTable[i]) do
					if(SEPARATION_SaucerShipTable[i][k].galaxy > j) then
						SEPARATION_SaucerShipTable[i][k].galaxy = SEPARATION_SaucerShipTable[i][k].galaxy - 1
					elseif(SEPARATION_SaucerShipTable[i][k].galaxy == j) then
						SEPARATION_SaucerShipTable[i][k].galaxy = -1
					end
				end
				tremove(SEPARATION_GalaxyShipTable[i], j)
				-- print(">> MVAM >> | Removing Galaxy section")
				j = j - 1
				size = size - 1 -- this doesn't work with a for loop
			end
			j = j + 1
		end
		
		-- stardrive...
		local size = getn(SEPARATION_StardriveShipTable[i])
		local j = 1
		while( j <= size ) do	
			if(SobGroup_Empty(SEPARATION_GetStardriveSob(i, j)) == 1) then
				for k = 1, getn(SEPARATION_SaucerShipTable[i]) do
					if(SEPARATION_SaucerShipTable[i][k].stardrive > j) then
						SEPARATION_SaucerShipTable[i][k].stardrive = SEPARATION_SaucerShipTable[i][k].stardrive - 1
					end
				end
				for k = 1, getn(SEPARATION_GalaxyShipTable[i]) do
					if(SEPARATION_GalaxyShipTable[i][k].stardrive > j) then
						SEPARATION_GalaxyShipTable[i][k].stardrive = SEPARATION_GalaxyShipTable[i][k].stardrive - 1
					end
				end
				tremove(SEPARATION_StardriveShipTable[i], j)
				-- print(">> MVAM >> | Removing stardrive section")
				j = j - 1
				size = size - 1 -- this doesn't work with a for loop
			end
			j = j + 1
		end
		
		-- saucer...
		local size = getn(SEPARATION_SaucerShipTable[i])
		local j = 1
		while( j <= size ) do	
			if(SobGroup_Empty(SEPARATION_GetSaucerSob(i, j)) == 1) then
				for k = 1, getn(SEPARATION_GalaxyShipTable[i]) do
					if(SEPARATION_GalaxyShipTable[i][k].saucer > j) then
						SEPARATION_GalaxyShipTable[i][k].saucer = SEPARATION_GalaxyShipTable[i][k].saucer - 1
					end
				end
				if(SEPARATION_SaucerShipTable[i][j].galaxy ~= -1) then
					SobGroup_SetHealth(SEPARATION_GetGalaxySob(i, SEPARATION_SaucerShipTable[i][j].galaxy), 0)
				end
				tremove(SEPARATION_SaucerShipTable[i], j)
				-- print(">> MVAM >> | Removing saucer section")
				j = j - 1
				size = size - 1 -- this doesn't work with a for loop
			end
			j = j + 1
		end
		
		------------------------------------------------------------------------------------------------
		-- MVAM
		
		
		-- Check if stardrive wants to dock at saucer --------------------------------------------------
		-- loop over all stardrives...
		for j = 1, getn(SEPARATION_StardriveShipTable[i]) do
			
			local sob_stardrive = SEPARATION_GetStardriveSob(i, j)
			
			-- does stardrive wants to dock?
			if( SEPARATION_StardriveShipTable[i][j].status == SEPARATION_Status_Separated
					and SobGroup_IsDoingAbility(sob_stardrive, AB_Dock) == 1 ) then
				
				-- find out at which Suacer it tries to dock...
				for k = 1, getn(SEPARATION_SaucerShipTable[i]) do
					local sob_saucer = SEPARATION_GetSaucerSob(i, k)
					
					-- if the distance between the ships is small enough we can be sure that they dock
					if( vdistance(SobGroup_GetPosition(sob_stardrive), SobGroup_GetPosition(sob_saucer)) <= 400 ) then
						-- print(">> MVAM >> | stardrive docking at saucer...")
						
						SEPARATION_SaucerShipTable[i][k].stardrive = j
						SEPARATION_SaucerShipTable[i][k].status = SEPARATION_Status_Docking
						SEPARATION_StardriveShipTable[i][j].status = SEPARATION_Status_Docking
						
						-- disable commands on the ships and stop the saucer section
						SobGroup_SetTactics(sob_saucer, PassiveTactics)
						SobGroup_Stop(i, sob_saucer)
						SobGroup_ForceStayDockedIfDocking(sob_stardrive)
						SobGroup_MakeSelectable(sob_stardrive, 0)
						SobGroup_MakeSelectable(sob_saucer, 0)
						
						break
					end
					
				end
				
			end
			
		end
		
		-- Perform Galaxy Integration ------------------------------------------------------------------
		-- loop over all saucers
		for k = 1, getn(SEPARATION_SaucerShipTable[i]) do
			
			-- update timer
			if( SEPARATION_SaucerShipTable[i][k].timer > 0 ) then
				SEPARATION_SaucerShipTable[i][k].timer = SEPARATION_SaucerShipTable[i][k].timer - 1
			end
			
			-- stardrive is docked at saucer
			if( SEPARATION_SaucerShipTable[i][k].status == SEPARATION_Status_Docking
				and SobGroup_IsDockedSobGroup(SEPARATION_GetStardriveSob(i, SEPARATION_SaucerShipTable[i][k].stardrive), SEPARATION_GetSaucerSob(i, k)) == 1 ) then
				-- print(">> MVAM >> | Preparing saucer for stardrive docking...")
				
				SEPARATION_SaucerShipTable[i][k].status = SEPARATION_Status_Docked
				SEPARATION_SaucerShipTable[i][k].timer = 15
				SEPARATION_StardriveShipTable[i][SEPARATION_SaucerShipTable[i][k].stardrive].status = SEPARATION_Status_Docked
				
				-- find a Galaxy sob that we can use and calculate its health and XP from the values of the
				-- stardrive and saucer section
				-- for l = 1, getn(SEPARATION_GalaxyShipTable[i]) do
					-- if( SEPARATION_GalaxyShipTable[i][l].status == SEPARATION_Status_Separated ) then
						-- SEPARATION_GalaxyShipTable[i][l].status = SEPARATION_Status_Booked
						-- SEPARATION_SaucerShipTable[i][k].galaxy = l
						-- break
					-- end
				-- end
				
				local sob_stardrive = SEPARATION_GetStardriveSob(i, SEPARATION_SaucerShipTable[i][k].stardrive)
				local sob_saucer = SEPARATION_GetSaucerSob(i, k)
				local sob_galaxy = SEPARATION_GetGalaxySob(i, SEPARATION_SaucerShipTable[i][k].galaxy)
				
				-- dock Galaxy at stardrive
				SobGroup_DockSobGroupInstant(sob_galaxy, sob_stardrive)
				
				-- calculate Health
				-- Galaxy = 0.5 * (stardrive + saucer)
				SobGroup_SetHealth(sob_galaxy, 0.5*(SobGroup_HealthPercentage(sob_stardrive) + SobGroup_HealthPercentage(sob_saucer)) )
				
				-- calculate XP
				for l = 1, getn(globalShipTable[i]) do
					if(globalShipTable[i][l][SobGroupIndex] == SEPARATION_SaucerShipTable[i][k].ship) then
						j_saucer = l
						-- print(">> MVAM >> | saucer")
					elseif(globalShipTable[i][l][SobGroupIndex] == SEPARATION_StardriveShipTable[i][SEPARATION_SaucerShipTable[i][k].stardrive].ship) then
						j_stardrive = l
						-- print(">> MVAM >> | stardrive")
					elseif(globalShipTable[i][l][SobGroupIndex] == SEPARATION_GalaxyShipTable[i][SEPARATION_SaucerShipTable[i][k].galaxy].ship) then
						j_galaxy = l
						-- print(">> MVAM >> | Galaxy")
					end
				end
				
				-- XP(Galaxy) = 0.5 * Strength(Galaxy) * ( XP(stardrive)/Strength(stardrive) + XP(saucer)/Strength(saucer) )
				globalShipTable[i][j_galaxy][Experience] = 0.5 * globalShipTable[i][j_galaxy][Strength] * ( globalShipTable[i][j_stardrive][Experience]/globalShipTable[i][j_stardrive][Strength] + globalShipTable[i][j_saucer][Experience]/globalShipTable[i][j_saucer][Strength] )
				XP_CheckForRankUp(i, j_galaxy)
				
				
			-- wait until docking process is *really* finished (->timer) and launch the integrated Galaxy
			elseif( SEPARATION_SaucerShipTable[i][k].status == SEPARATION_Status_Docked
					and SEPARATION_SaucerShipTable[i][k].timer <= 0 ) then
				-- print(">> MVAM >> | stardrive docked at saucer")
				
				SEPARATION_SaucerShipTable[i][k].status = SEPARATION_Status_Launching
				SEPARATION_SaucerShipTable[i][k].timer = 8
				
				local sob_stardrive = SEPARATION_GetStardriveSob(i, SEPARATION_SaucerShipTable[i][k].stardrive)
				-- local sob_saucer = SEPARATION_GetSaucerSob(i, k)
				local sob_galaxy = SEPARATION_GetGalaxySob(i, SEPARATION_SaucerShipTable[i][k].galaxy)
				
				SobGroup_Launch(sob_galaxy, sob_stardrive)
				
			-- once the Galaxy is launched, instantly dock the stardrive and saucer to the galaxy class
			elseif( SEPARATION_SaucerShipTable[i][k].status == SEPARATION_Status_Launching
					and SEPARATION_SaucerShipTable[i][k].timer <= 0 ) then
				-- print(">> MVAM >> | Completing integration...")
				
				SEPARATION_SaucerShipTable[i][k].status = SEPARATION_Status_Integrated
				SEPARATION_StardriveShipTable[i][SEPARATION_SaucerShipTable[i][k].stardrive].status = SEPARATION_Status_Integrated
				
				local sob_stardrive = SEPARATION_GetStardriveSob(i, SEPARATION_SaucerShipTable[i][k].stardrive)
				local sob_saucer = SEPARATION_GetSaucerSob(i, k)
				local sob_galaxy = SEPARATION_GetGalaxySob(i, SEPARATION_SaucerShipTable[i][k].galaxy)
				
				SobGroup_DockSobGroupInstant(sob_stardrive, sob_galaxy)
				SobGroup_DockSobGroupInstant(sob_saucer, sob_galaxy)
				
				SEPARATION_GalaxyShipTable[i][SEPARATION_SaucerShipTable[i][k].galaxy].status = SEPARATION_Status_Integrated
				SEPARATION_GalaxyShipTable[i][SEPARATION_SaucerShipTable[i][k].galaxy].stardrive = SEPARATION_SaucerShipTable[i][k].stardrive
				SEPARATION_GalaxyShipTable[i][SEPARATION_SaucerShipTable[i][k].galaxy].saucer = k
				
				SobGroup_Stop(i, sob_galaxy)
				-- print(">> MVAM >> | Integration completed")
			end
		end
		
		-- Perform Galaxy Separation -------------------------------------------------------------------
		-- loop over all galaxys
		for k = 1, getn(SEPARATION_GalaxyShipTable[i]) do
			
			-- update timer
			if( SEPARATION_GalaxyShipTable[i][k].timer > 0 ) then
				SEPARATION_GalaxyShipTable[i][k].timer = SEPARATION_GalaxyShipTable[i][k].timer - 1
			end
			
			-- check if one section want to launch from the Galaxy, if true, also launch the other section
			-- and calculate Health and XP of the sections
			if( SEPARATION_GalaxyShipTable[i][k].status == SEPARATION_Status_Integrated ) then
				
				local sob_stardrive = SEPARATION_GetStardriveSob(i, SEPARATION_GalaxyShipTable[i][k].stardrive)
				local sob_saucer = SEPARATION_GetSaucerSob(i, SEPARATION_GalaxyShipTable[i][k].saucer)
				local sob_galaxy = SEPARATION_GetGalaxySob(i, k)
				
				if( SobGroup_IsDockedSobGroup(sob_stardrive, sob_galaxy) == 0
						or SobGroup_IsDockedSobGroup(sob_saucer, sob_galaxy) == 0 ) then
					-- print(">> MVAM >> | Preparing Galaxy for separation...")
					
					SEPARATION_GalaxyShipTable[i][k].status = SEPARATION_Status_Separating
					SEPARATION_GalaxyShipTable[i][k].timer = 6
					
					-- launch both sections
					SobGroup_Launch(sob_stardrive, sob_galaxy)
					SobGroup_Launch(sob_saucer, sob_galaxy)
					
					-- calculate health
					local a = SobGroup_HealthPercentage(sob_stardrive)
					local b = SobGroup_HealthPercentage(sob_saucer)
					local c = SobGroup_HealthPercentage(sob_galaxy)
					local h = 0.5*(a + b)
					a = a + c - h
					b = b + c - h
					
					if a > 1 then
						b = b + a - 1
						a = 1
					elseif b > 1 then
						a = a + b - 1
						b = 1
					end
					
					if( a <= 0 or b <= 0) then
						a = c
						b = c
					end
					
					SobGroup_SetHealth(sob_stardrive, a)
					SobGroup_SetHealth(sob_saucer, b)
					
					-- calculate XP
					for l = 1, getn(globalShipTable[i]) do
						if(globalShipTable[i][l][SobGroupIndex] == SEPARATION_SaucerShipTable[i][SEPARATION_GalaxyShipTable[i][k].saucer].ship) then
							j_saucer = l
							-- print(">> MVAM >> | saucer")
						elseif(globalShipTable[i][l][SobGroupIndex] == SEPARATION_StardriveShipTable[i][SEPARATION_GalaxyShipTable[i][k].stardrive].ship) then
							j_stardrive = l
							-- print(">> MVAM >> | stardrive")
						elseif(globalShipTable[i][l][SobGroupIndex] == SEPARATION_GalaxyShipTable[i][k].ship) then
							j_galaxy = l
							-- print(">> MVAM >> | Galaxy")
						end
					end
					
					local XP_gained = globalShipTable[i][j_galaxy][Experience] - 0.5 * globalShipTable[i][j_galaxy][Strength] * ( globalShipTable[i][j_stardrive][Experience]/globalShipTable[i][j_stardrive][Strength] + globalShipTable[i][j_saucer][Experience]/globalShipTable[i][j_saucer][Strength] )
					-- XP(stardrive) = XP(stardrive) + Strength(stardrive)/Strength(saucer) * 0.5 * XP_gained
					globalShipTable[i][j_stardrive][Experience] = globalShipTable[i][j_stardrive][Experience] + globalShipTable[i][j_stardrive][Strength]/globalShipTable[i][j_galaxy][Strength] * XP_gained
					globalShipTable[i][j_saucer][Experience] = globalShipTable[i][j_saucer][Experience] + globalShipTable[i][j_saucer][Strength]/globalShipTable[i][j_galaxy][Strength] * XP_gained
					
					XP_CheckForRankUp(i, j_stardrive)
					XP_CheckForRankUp(i, j_saucer)
					
				end
				
			-- once the galaxy is separated, despawn galaxy
			elseif( SEPARATION_GalaxyShipTable[i][k].status == SEPARATION_Status_Separating
							and SEPARATION_GalaxyShipTable[i][k].timer <= 0 ) then
				-- print(">> MVAM >> | Completing separation")
				
				SEPARATION_GalaxyShipTable[i][k].status = SEPARATION_Status_Separated
				SEPARATION_StardriveShipTable[i][SEPARATION_GalaxyShipTable[i][k].stardrive].status = SEPARATION_Status_Separated
				SEPARATION_SaucerShipTable[i][SEPARATION_GalaxyShipTable[i][k].saucer].status = SEPARATION_Status_Separated
				
				local sob_stardrive = SEPARATION_GetStardriveSob(i, SEPARATION_GalaxyShipTable[i][k].stardrive)
				local sob_saucer = SEPARATION_GetSaucerSob(i, SEPARATION_GalaxyShipTable[i][k].saucer)
				local sob_galaxy = SEPARATION_GetGalaxySob(i, k)
				
				SobGroup_Despawn(sob_galaxy)
				
				-- re-allow control of sections
				SobGroup_MakeSelectable(sob_stardrive, 1)
				SobGroup_MakeSelectable(sob_saucer, 1)
				SobGroup_SetTactics(sob_stardrive, DefensiveTactics)
				SobGroup_SetTactics(sob_saucer, DefensiveTactics)
				SobGroup_Stop(i, sob_stardrive)
				SobGroup_Stop(i, sob_saucer)
				-- print(">> MVAM >> | Separation completed")
			end
			
		end
		
	end
end


-- returns the name of the sobgroup of a stardrive/saucer/Galaxy
function SEPARATION_GetStardriveSob(i, param)
	return "Player"..i.."_ship"..SEPARATION_StardriveShipTable[i][param].ship
end
function SEPARATION_GetSaucerSob(i, param)
	return "Player"..i.."_ship"..SEPARATION_SaucerShipTable[i][param].ship
end
function SEPARATION_GetGalaxySob(i, param)
	return "Player"..i.."_ship"..SEPARATION_GalaxyShipTable[i][param].ship
end
-- checks if a ship is already added to an MVAM tables
function SEPARATION_IsAlreadyKnown(mytable, j)
	for i = 1, getn(mytable) do
		if mytable[i].ship == j then
			-- print(">> MVAM >> | Known MVAM Ship")
			return 1
		end
	end
	-- print(">> MVAM >> | Unknown MVAM Ship")
	return 0
end