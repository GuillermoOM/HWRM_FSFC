----------------------------------------------------------------------------------------------------
-- MVAM ROUTINE
----------------------------------------------------------------------------------------------------

MVAM_PromShipTable = {}
MVAM_PromAlphaShipTable = {}
MVAM_PromBetaShipTable = {}
MVAM_PromGammaShipTable = {}

MVAM_Status_Docking = 1
MVAM_Status_Docked = 2
MVAM_Status_Launching = 3
MVAM_Status_Booked = 4
MVAM_Status_Separating = 5
MVAM_Status_Separated = 6
MVAM_Status_Integrated = 7

function mvamInitial(i, j)
	local sob_ship = "Player"..i.."_ship"..j
	
	-- check if the newly added ship is a prometheus class. If true instantly dock the seperate sections to it
	if( SobGroup_AreAnyOfTheseTypes(sob_ship, "fed_TNG_prometheus") == 1
			and MVAM_IsAlreadyKnown(MVAM_PromShipTable[i], j) == 0) then
		-- print(">> MVAM >> | Added prom class with alpha, beta and gamma Section docked")
		
		local j_A = getFreeShipIndex(i)
		local alpha = {
			ship   = j_A,
			timer  = 0,
			status = MVAM_Status_Integrated,
		}
		tinsert(MVAM_PromAlphaShipTable[i], alpha)
		SobGroup_Create("sob_alpha")
		SobGroup_Clear("sob_alpha")
		SobGroup_SpawnNewShipInSobGroup(i, "fed_TNG_prometheus_alpha", "MySquadron1", "sob_alpha", "MVAM_Volume")
		SobGroup_DockSobGroupInstant("sob_alpha", sob_ship)
		createShipSpecificTable(i, j_A, "sob_alpha")
		globalShipTable[i][getn(globalShipTable[i])][IsAtWarp] = 0
		
		local j_G = getFreeShipIndex(i)
		local gamma = {
			ship   = j_G,
			timer  = 0,
			status = MVAM_Status_Integrated,
		}
		tinsert(MVAM_PromGammaShipTable[i], gamma)
		SobGroup_Create("sob_gamma")
		SobGroup_Clear("sob_gamma")
		SobGroup_SpawnNewShipInSobGroup(i, "fed_TNG_prometheus_gamma", "MySquadron3", "sob_gamma", "MVAM_Volume")
		SobGroup_DockSobGroupInstant("sob_gamma", sob_ship)
		createShipSpecificTable(i, j_G, "sob_gamma")
		globalShipTable[i][getn(globalShipTable[i])][IsAtWarp] = 0
		
		
		local j_B = getFreeShipIndex(i)
		local beta = {
			ship   = j_B,
			timer  = 0,
			status = MVAM_Status_Integrated,
			alpha  = getn(MVAM_PromAlphaShipTable[i]),
			gamma  = getn(MVAM_PromGammaShipTable[i]),
			prom   = getn(MVAM_PromShipTable[i]) + 1,
		}
		tinsert(MVAM_PromBetaShipTable[i], beta)
		SobGroup_Create("sob_beta")
		SobGroup_Clear("sob_beta")
		SobGroup_SpawnNewShipInSobGroup(i, "fed_TNG_prometheus_beta", "MySquadron2", "sob_beta", "MVAM_Volume")
		SobGroup_DockSobGroupInstant("sob_beta", sob_ship)
		createShipSpecificTable(i, j_B, "sob_beta")
		globalShipTable[i][getn(globalShipTable[i])][IsAtWarp] = 0
		
		local prom = {
			ship   = j,
			timer  = 0,
			status = MVAM_Status_Integrated,
			alpha  = getn(MVAM_PromAlphaShipTable[i]),
			beta   = getn(MVAM_PromBetaShipTable[i]),
			gamma  = getn(MVAM_PromGammaShipTable[i]),
		}
		tinsert(MVAM_PromShipTable[i], prom)
	
		
	-- if the newly added ship is a beta section, add a prometheus class off the map
	elseif( SobGroup_AreAnyOfTheseTypes(sob_ship, "fed_TNG_prometheus_beta") == 1
					and MVAM_IsAlreadyKnown(MVAM_PromBetaShipTable[i], j) == 0) then
		-- print(">> MVAM >> | Added beta Section and spawned a prometheus class off the map")
		
		local j_B = getFreeShipIndex(i)
		local prom = {
			ship   = j_B,
			timer  = 0,
			status = MVAM_Status_Separated,
			alpha  = -1,
			beta   = getn(MVAM_PromBetaShipTable[i]) + 1,
			gamma  = -1,
		}
		tinsert(MVAM_PromShipTable[i], prom)
		SobGroup_Create("sob_prom")
		SobGroup_Clear("sob_prom")
		SobGroup_SpawnNewShipInSobGroup(i, "fed_TNG_prometheus", "MySquadron2", "sob_prom", "MVAM_Volume")
		SobGroup_Despawn("sob_prom")
		createShipSpecificTable(i, j_B, "sob_prom")
		globalShipTable[i][getn(globalShipTable[i])][IsAtWarp] = 0
		
		local beta = {
			ship   = j,
			timer  = 0,
			status = MVAM_Status_Separated,
			alpha  = -1,
			gamma  = -1,
			prom   = getn(MVAM_PromShipTable[i]),
		}
		tinsert(MVAM_PromBetaShipTable[i], beta)
		
	-- newly added ship is a alpha
	elseif( SobGroup_AreAnyOfTheseTypes(sob_ship, "fed_TNG_prometheus_alpha") == 1
					and MVAM_IsAlreadyKnown(MVAM_PromAlphaShipTable[i], j) == 0) then
		-- print(">> MVAM >> | Added alpha Section")
		
		local alpha = {
			ship   = j,
			timer  = 0,
			status = MVAM_Status_Separated,
		}
		tinsert(MVAM_PromAlphaShipTable[i], alpha)
		
	-- newly added ship is a gamma
	elseif( SobGroup_AreAnyOfTheseTypes(sob_ship, "fed_TNG_prometheus_gamma") == 1
					and MVAM_IsAlreadyKnown(MVAM_PromGammaShipTable[i], j) == 0) then
		-- print(">> MVAM >> | Added gamma Section")
		
		local gamma = {
			ship   = j,
			timer  = 0,
			status = MVAM_Status_Separated,
		}
		tinsert(MVAM_PromGammaShipTable[i], gamma)
		
	end
end


function mvam_Init()
	Volume_AddSphere("MVAM_Volume", {0, 10^1, 0,}, 1000)
	
	for i = 0, Universe_PlayerCount()-1 do
		MVAM_PromAlphaShipTable[i] = {}
		MVAM_PromBetaShipTable[i] = {}
		MVAM_PromGammaShipTable[i] = {}
		MVAM_PromShipTable[i] = {}
	end
end


function mvamRule()
	for i = 0, Universe_PlayerCount()-1 do
		
		------------------------------------------------------------------------------------------------
		-- remove empty groups out of lists (dead ships)
		-- prom...
		local size = getn(MVAM_PromShipTable[i])
		local j = 1
		while( j <= size ) do	
			if(SobGroup_Empty(MVAM_GetPromSob(i, j)) == 1) then
				for k = 1, getn(MVAM_PromBetaShipTable[i]) do
					if(MVAM_PromBetaShipTable[i][k].prom > j) then
						MVAM_PromBetaShipTable[i][k].prom = MVAM_PromBetaShipTable[i][k].prom - 1
					elseif(MVAM_PromBetaShipTable[i][k].prom == j) then
						MVAM_PromBetaShipTable[i][k].prom = -1
					end
				end
				tremove(MVAM_PromShipTable[i], j)
				-- print(">> MVAM >> | Removing prom section")
				j = j - 1
				size = size - 1 -- this doesn't work with a for loop
			end
			j = j + 1
		end
		
		-- alpha...
		local size = getn(MVAM_PromAlphaShipTable[i])
		local j = 1
		while( j <= size ) do	
			if(SobGroup_Empty(MVAM_GetAlphaSob(i, j)) == 1) then
				for k = 1, getn(MVAM_PromBetaShipTable[i]) do
					if(MVAM_PromBetaShipTable[i][k].alpha > j) then
						MVAM_PromBetaShipTable[i][k].alpha = MVAM_PromBetaShipTable[i][k].alpha - 1
					end
				end
				for k = 1, getn(MVAM_PromShipTable[i]) do
					if(MVAM_PromShipTable[i][k].alpha > j) then
						MVAM_PromShipTable[i][k].alpha = MVAM_PromShipTable[i][k].alpha - 1
					end
				end
				tremove(MVAM_PromAlphaShipTable[i], j)
				-- print(">> MVAM >> | Removing alpha section")
				j = j - 1
				size = size - 1 -- this doesn't work with a for loop
			end
			j = j + 1
		end
		
		-- beta...
		local size = getn(MVAM_PromBetaShipTable[i])
		local j = 1
		while( j <= size ) do	
			if(SobGroup_Empty(MVAM_GetBetaSob(i, j)) == 1) then
				for k = 1, getn(MVAM_PromShipTable[i]) do
					if(MVAM_PromShipTable[i][k].beta > j) then
						MVAM_PromShipTable[i][k].beta = MVAM_PromShipTable[i][k].beta - 1
					end
				end
				if(MVAM_PromBetaShipTable[i][j].prom ~= -1) then
					SobGroup_SetHealth(MVAM_GetPromSob(i, MVAM_PromBetaShipTable[i][j].prom), 0)
				end
				tremove(MVAM_PromBetaShipTable[i], j)
				-- print(">> MVAM >> | Removing beta section")
				j = j - 1
				size = size - 1 -- this doesn't work with a for loop
			end
			j = j + 1
		end
		
		-- gamma...
		local size = getn(MVAM_PromGammaShipTable[i])
		local j = 1
		while( j <= size ) do	
			if(SobGroup_Empty(MVAM_GetGammaSob(i, j)) == 1) then
				for k = 1, getn(MVAM_PromBetaShipTable[i]) do
					if(MVAM_PromBetaShipTable[i][k].gamma > j) then
						MVAM_PromBetaShipTable[i][k].gamma = MVAM_PromBetaShipTable[i][k].gamma - 1
					end
				end
				for k = 1, getn(MVAM_PromShipTable[i]) do
					if(MVAM_PromShipTable[i][k].gamma > j) then
						MVAM_PromShipTable[i][k].gamma = MVAM_PromShipTable[i][k].gamma - 1
					end
				end
				tremove(MVAM_PromGammaShipTable[i], j)
				-- print(">> MVAM >> | Removing gamma section")
				j = j - 1
				size = size - 1 -- this doesn't work with a for loop
			end
			j = j + 1
		end
		
		
		------------------------------------------------------------------------------------------------
		-- MVAM
		
		
		-- Check if alpha wants to dock at beta --------------------------------------------------
		-- loop over all alphas...
		for j = 1, getn(MVAM_PromAlphaShipTable[i]) do
			
			local sob_alpha = MVAM_GetAlphaSob(i, j)
			
			-- does alpha want to dock?
			if( MVAM_PromAlphaShipTable[i][j].status == MVAM_Status_Separated
					and SobGroup_IsDoingAbility(sob_alpha, AB_Dock) == 1 ) then
				
				-- find out at which beta it tries to dock...
				for k = 1, getn(MVAM_PromBetaShipTable[i]) do
					local sob_beta = MVAM_GetBetaSob(i, k)
					
					-- if the distance between the ships is small enough we can be sure that they dock
					if( vdistance(SobGroup_GetPosition(sob_alpha), SobGroup_GetPosition(sob_beta)) <= 400 ) then
						-- print(">> MVAM >> | alpha docking at beta...")
						
						
						if( getn(MVAM_PromGammaShipTable[i]) > 0 ) then
							local j_closest = -1
							
							-- find out if a Gamma section also tries to dock
							for l = 1, getn(MVAM_PromGammaShipTable[i]) do
								sob_gamma = MVAM_GetGammaSob(i, l)
								gamma_found = 0
								
								if( MVAM_PromGammaShipTable[i][l].status == MVAM_Status_Separated
										and SobGroup_IsDoingAbility(sob_gamma, AB_Dock) == 1) then
									
									if( vdistance(SobGroup_GetPosition(sob_gamma), SobGroup_GetPosition(sob_beta)) <= 400 ) then
										gamma_found = 1
										j_closest = l
										break
									end
								end
								
								if( gamma_found == 1 ) then
									-- print("MVAM >> | We found a gamma which docks!")
									break
								end
								
							end
							
							-- if there's no gamma which wants to dock, search for closest free gamma section
							-- available and dock it
							local gamma_distance = 1e10
							
							if( gamma_found == 0 ) then
								-- print("MVAM >> | No docking gamma found! Searching free one...")
							
								for l = 1, getn(MVAM_PromGammaShipTable[i]) do
									sob_gamma = MVAM_GetGammaSob(i, l)
									
									local dist = vdistance(SobGroup_GetPosition(sob_gamma), SobGroup_GetPosition(sob_beta))
									-- print(">> MVAM | Distance "..dist)
									
									if( MVAM_PromGammaShipTable[i][l].status == MVAM_Status_Separated
											and dist <= gamma_distance ) then
										gamma_distance = dist
										-- print(">> MVAM | gamma_distance "..dist)
										j_closest = l
									end
									
								end
								
								if(j_closest ~= -1) then
									sob_gamma = MVAM_GetGammaSob(i, j_closest)
									SobGroup_DockSobGroupAndStayDocked(sob_gamma, sob_beta)
								end
								
							end
							
							
							if(j_closest ~= -1) then
								MVAM_PromBetaShipTable[i][k].alpha = j
								MVAM_PromBetaShipTable[i][k].gamma = j_closest
								MVAM_PromBetaShipTable[i][k].status = MVAM_Status_Docking
								MVAM_PromAlphaShipTable[i][j].status = MVAM_Status_Docking
								MVAM_PromGammaShipTable[i][j_closest].status = MVAM_Status_Docking
								
								-- disable commands on the ships and stop the beta section
								SobGroup_SetTactics(sob_beta, PassiveTactics)
								SobGroup_Stop(i, sob_beta)
								SobGroup_ForceStayDockedIfDocking(sob_alpha)
								SobGroup_ForceStayDockedIfDocking(sob_gamma)
								SobGroup_MakeSelectable(sob_alpha, 0)
								SobGroup_MakeSelectable(sob_beta, 0)
								SobGroup_MakeSelectable(sob_gamma, 0)
								
							else
							
								SobGroup_Stop(i, sob_alpha)
							
							end
							
						else
							
							SobGroup_Stop(i, sob_alpha)
							
						end
						
						break
					end
					
				end
				
			end
			
		end
		
		
		-- Check if gamma wants to dock at beta --------------------------------------------------
		-- loop over all gammas...
		for j = 1, getn(MVAM_PromGammaShipTable[i]) do
			
			local sob_Gamma = MVAM_GetGammaSob(i, j)
			
			-- does Gamma want to dock?
			if( MVAM_PromGammaShipTable[i][j].status == MVAM_Status_Separated
					and SobGroup_IsDoingAbility(sob_Gamma, AB_Dock) == 1 ) then
				
				-- find out at which beta it tries to dock...
				for k = 1, getn(MVAM_PromBetaShipTable[i]) do
					local sob_beta = MVAM_GetBetaSob(i, k)
					
					-- if the distance between the ships is small enough we can be sure that they dock
					if( vdistance(SobGroup_GetPosition(sob_Gamma), SobGroup_GetPosition(sob_beta)) <= 400 ) then
						-- print(">> MVAM >> | Gamma docking at beta...")
						
						
						if( getn(MVAM_PromAlphaShipTable[i]) > 0 ) then
							local j_closest = -1
							
							-- find out if a Alpha section also tries to dock
							for l = 1, getn(MVAM_PromAlphaShipTable[i]) do
								sob_Alpha = MVAM_GetAlphaSob(i, l)
								Alpha_found = 0
								
								if( MVAM_PromAlphaShipTable[i][l].status == MVAM_Status_Separated
										and SobGroup_IsDoingAbility(sob_Alpha, AB_Dock) == 1) then
									
									if( vdistance(SobGroup_GetPosition(sob_Alpha), SobGroup_GetPosition(sob_beta)) <= 400 ) then
										Alpha_found = 1
										j_closest = l
										break
									end
								end
								
								if( Alpha_found == 1 ) then
									-- print("MVAM >> | We found a Alpha which docks!")
									break
								end
								
							end
							
							-- if there's no Alpha which wants to dock, search for closest free Alpha section
							-- available and dock it
							local Alpha_distance = 1e10
							
							if( Alpha_found == 0 ) then
								-- print("MVAM >> | No docking Alpha found! Searching free one...")
							
								for l = 1, getn(MVAM_PromAlphaShipTable[i]) do
									sob_Alpha = MVAM_GetAlphaSob(i, l)
									
									local dist = vdistance(SobGroup_GetPosition(sob_Alpha), SobGroup_GetPosition(sob_beta))
									-- print(">> MVAM | Distance "..dist)
									
									if( MVAM_PromAlphaShipTable[i][l].status == MVAM_Status_Separated
											and dist <= Alpha_distance ) then
										Alpha_distance = dist
										-- print(">> MVAM | Alpha_distance "..dist)
										j_closest = l
									end
									
								end
								
								if(j_closest ~= -1) then
									sob_Alpha = MVAM_GetAlphaSob(i, j_closest)
									SobGroup_DockSobGroupAndStayDocked(sob_Alpha, sob_beta)
								end
								
							end
							
							
							if(j_closest ~= -1) then
								MVAM_PromBetaShipTable[i][k].gamma = j
								MVAM_PromBetaShipTable[i][k].alpha = j_closest
								MVAM_PromBetaShipTable[i][k].status = MVAM_Status_Docking
								MVAM_PromGammaShipTable[i][j].status = MVAM_Status_Docking
								MVAM_PromAlphaShipTable[i][j_closest].status = MVAM_Status_Docking
								
								-- disable commands on the ships and stop the beta section
								SobGroup_SetTactics(sob_beta, PassiveTactics)
								SobGroup_Stop(i, sob_beta)
								SobGroup_ForceStayDockedIfDocking(sob_Gamma)
								SobGroup_ForceStayDockedIfDocking(sob_Alpha)
								SobGroup_MakeSelectable(sob_Gamma, 0)
								SobGroup_MakeSelectable(sob_beta, 0)
								SobGroup_MakeSelectable(sob_Alpha, 0)
								
							else
							
								SobGroup_Stop(i, sob_Gamma)
							
							end
							
						else
							
							SobGroup_Stop(i, sob_Gamma)
							
						end
						
						break
					end
					
				end
				
			end
			
		end
		
		
		-- Perform prom Integration ------------------------------------------------------------------
		-- loop over all betas
		for k = 1, getn(MVAM_PromBetaShipTable[i]) do
			
			-- update timer
			if( MVAM_PromBetaShipTable[i][k].timer > 0 ) then
				MVAM_PromBetaShipTable[i][k].timer = MVAM_PromBetaShipTable[i][k].timer - 1
			end
			
			-- alpha and gamma are docked at beta
			if( MVAM_PromBetaShipTable[i][k].status == MVAM_Status_Docking
				and SobGroup_IsDockedSobGroup(MVAM_GetAlphaSob(i, MVAM_PromBetaShipTable[i][k].alpha), MVAM_GetBetaSob(i, k)) == 1
				and SobGroup_IsDockedSobGroup(MVAM_GetGammaSob(i, MVAM_PromBetaShipTable[i][k].gamma), MVAM_GetBetaSob(i, k)) == 1) then
				-- print(">> MVAM >> | Preparing beta for alpha and gamma docking...")
				
				MVAM_PromBetaShipTable[i][k].status = MVAM_Status_Docked
				MVAM_PromBetaShipTable[i][k].timer = 15
				MVAM_PromAlphaShipTable[i][MVAM_PromBetaShipTable[i][k].alpha].status = MVAM_Status_Docked
				MVAM_PromGammaShipTable[i][MVAM_PromBetaShipTable[i][k].gamma].status = MVAM_Status_Docked
				
				-- find a prom sob that we can use and calculate its health and XP from the values of the
				-- alpha and beta section
				-- for l = 1, getn(MVAM_PromShipTable[i]) do
					-- if( MVAM_PromShipTable[i][l].status == MVAM_Status_Separated ) then
						-- MVAM_PromShipTable[i][l].status = MVAM_Status_Booked
						-- MVAM_PromBetaShipTable[i][k].prom = l
						-- break
					-- end
				-- end
				
				local sob_alpha = MVAM_GetAlphaSob(i, MVAM_PromBetaShipTable[i][k].alpha)
				local sob_beta  = MVAM_GetBetaSob(i, k)
				local sob_gamma = MVAM_GetGammaSob(i, MVAM_PromBetaShipTable[i][k].gamma)
				local sob_prom  = MVAM_GetPromSob(i, MVAM_PromBetaShipTable[i][k].prom)
				
				-- dock prom at beta
				SobGroup_DockSobGroupInstant(sob_prom, sob_alpha)
				
				-- calculate Health
				-- prom = 1/3 * (alpha + beta + gamma)
				SobGroup_SetHealth(sob_prom, 1.0/3.0*(SobGroup_HealthPercentage(sob_alpha) + SobGroup_HealthPercentage(sob_beta) + SobGroup_HealthPercentage(sob_gamma)) )
				
				-- calculate XP
				for l = 1, getn(globalShipTable[i]) do
					if(globalShipTable[i][l][SobGroupIndex] == MVAM_PromBetaShipTable[i][k].ship) then
						j_beta = l
						-- print(">> MVAM >> | beta")
					elseif(globalShipTable[i][l][SobGroupIndex] == MVAM_PromAlphaShipTable[i][MVAM_PromBetaShipTable[i][k].alpha].ship) then
						j_alpha = l
						-- print(">> MVAM >> | alpha")
					elseif(globalShipTable[i][l][SobGroupIndex] == MVAM_PromGammaShipTable[i][MVAM_PromBetaShipTable[i][k].gamma].ship) then
						j_gamma = l
						-- print(">> MVAM >> | gamma")
					elseif(globalShipTable[i][l][SobGroupIndex] == MVAM_PromShipTable[i][MVAM_PromBetaShipTable[i][k].prom].ship) then
						j_prom = l
						-- print(">> MVAM >> | prom")
					end
				end
				
				-- XP(prom) = 1/3 * Strength(prom) * ( XP(alpha)/Strength(alpha) + XP(beta)/Strength(beta) )
				globalShipTable[i][j_prom][Experience] = 1.0/3.0 * globalShipTable[i][j_prom][Strength] * ( globalShipTable[i][j_alpha][Experience]/globalShipTable[i][j_alpha][Strength] + globalShipTable[i][j_beta][Experience]/globalShipTable[i][j_beta][Strength] + globalShipTable[i][j_gamma][Experience]/globalShipTable[i][j_gamma][Strength])
				XP_CheckForRankUp(i, j_prom)
				
				-- play sound
				local MVAM_SoundPosition = SobGroup_GetPosition(sob_beta)
				Sound_SFXPlay3DPos("data:sound/sfx/etg/special/MVAM_Reintegration", MVAM_SoundPosition)
				
			-- wait until docking process is *really* finished (->timer) and launch the integrated prom
			elseif( MVAM_PromBetaShipTable[i][k].status == MVAM_Status_Docked
					and MVAM_PromBetaShipTable[i][k].timer <= 0 ) then
				-- print(">> MVAM >> | alpha docked at beta")
				
				MVAM_PromBetaShipTable[i][k].status = MVAM_Status_Launching
				MVAM_PromBetaShipTable[i][k].timer = 8
				
				local sob_alpha = MVAM_GetAlphaSob(i, MVAM_PromBetaShipTable[i][k].alpha)
				-- local sob_beta  = MVAM_GetBetaSob(i, k)
				-- local sob_gamma = MVAM_GetGammaSob(i, MVAM_PromBetaShipTable[i][k].gamma)
				local sob_prom  = MVAM_GetPromSob(i, MVAM_PromBetaShipTable[i][k].prom)
				
				SobGroup_Launch(sob_prom, sob_alpha)
				
			-- once the prom is launched, instantly dock the alpha, beta and gamma to the prom class
			elseif( MVAM_PromBetaShipTable[i][k].status == MVAM_Status_Launching
					and MVAM_PromBetaShipTable[i][k].timer <= 0 ) then
				-- print(">> MVAM >> | Completing integration...")
				
				MVAM_PromBetaShipTable[i][k].status = MVAM_Status_Integrated
				MVAM_PromAlphaShipTable[i][MVAM_PromBetaShipTable[i][k].alpha].status = MVAM_Status_Integrated
				MVAM_PromGammaShipTable[i][MVAM_PromBetaShipTable[i][k].gamma].status = MVAM_Status_Integrated
				
				local sob_alpha = MVAM_GetAlphaSob(i, MVAM_PromBetaShipTable[i][k].alpha)
				local sob_beta  = MVAM_GetBetaSob(i, k)
				local sob_gamma = MVAM_GetGammaSob(i, MVAM_PromBetaShipTable[i][k].gamma)
				local sob_prom  = MVAM_GetPromSob(i, MVAM_PromBetaShipTable[i][k].prom)
				
				SobGroup_DockSobGroupInstant(sob_alpha, sob_prom)
				SobGroup_DockSobGroupInstant(sob_beta, sob_prom)
				SobGroup_DockSobGroupInstant(sob_gamma, sob_prom)
				
				MVAM_PromShipTable[i][MVAM_PromBetaShipTable[i][k].prom].status = MVAM_Status_Integrated
				MVAM_PromShipTable[i][MVAM_PromBetaShipTable[i][k].prom].alpha = MVAM_PromBetaShipTable[i][k].alpha
				MVAM_PromShipTable[i][MVAM_PromBetaShipTable[i][k].prom].beta = k
				MVAM_PromShipTable[i][MVAM_PromBetaShipTable[i][k].prom].gamma = MVAM_PromBetaShipTable[i][k].gamma
				
				SobGroup_Stop(i, sob_prom)
				-- print(">> MVAM >> | Integration completed")
			end
		end
		
		-- Perform prom Separation -------------------------------------------------------------------
		-- loop over all proms
		for k = 1, getn(MVAM_PromShipTable[i]) do
			
			-- update timer
			if( MVAM_PromShipTable[i][k].timer > 0 ) then
				MVAM_PromShipTable[i][k].timer = MVAM_PromShipTable[i][k].timer - 1
			end
			
			-- check if one section wants to launch from the prom, if true, also launch the other section
			-- and calculate Health and XP of the sections
			if( MVAM_PromShipTable[i][k].status == MVAM_Status_Integrated ) then
				
				local sob_alpha = MVAM_GetAlphaSob(i, MVAM_PromShipTable[i][k].alpha)
				local sob_beta  = MVAM_GetBetaSob(i, MVAM_PromShipTable[i][k].beta)
				local sob_gamma = MVAM_GetGammaSob(i, MVAM_PromShipTable[i][k].gamma)
				local sob_prom  = MVAM_GetPromSob(i, k)
				
				if( SobGroup_IsDockedSobGroup(sob_alpha, sob_prom) == 0
						or SobGroup_IsDockedSobGroup(sob_beta, sob_prom) == 0 
						or SobGroup_IsDockedSobGroup(sob_gamma, sob_prom) == 0 ) then
					-- print(">> MVAM >> | Preparing prom for separation...")
					
					MVAM_PromShipTable[i][k].status = MVAM_Status_Separating
					MVAM_PromShipTable[i][k].timer = 6
					
					-- launch both sections
					SobGroup_Launch(sob_alpha, sob_prom)
					SobGroup_Launch(sob_beta, sob_prom)
					SobGroup_Launch(sob_gamma, sob_prom)
					
					-- calculate health
					local a = SobGroup_HealthPercentage(sob_alpha)
					local b = SobGroup_HealthPercentage(sob_beta)
					local g = SobGroup_HealthPercentage(sob_gamma)
					local c = SobGroup_HealthPercentage(sob_prom)
					local h = 1.0/3.0*(a + b + g)
					a = a + c - h
					b = b + c - h
					g = g + c - h
					
					if a > 1 then
						b = b + 0.5*(a - 1)
						g = g + 0.5*(a - 1)
						
						if b > 1 then
							g = g + (b - 1)
							b = 1
						end
						if g > 1 then
							b = b + (g - 1)
							g = 1
							if b > 0 then
								b = 1
							end
						end
						
						a = 1
						
					elseif b > 1 then
						a = a + 0.5*(b - 1)
						g = g + 0.5*(b - 1)
						
						if a > 1 then
							g = g + (a - 1)
							a = 1
						end
						if g > 1 then
							a = a + (g - 1)
							g = 1
							if a > 0 then
								a = 1
							end
						end
						
						b = 1
						
					elseif g > 1 then
						a = a + 0.5*(g - 1)
						b = b + 0.5*(g - 1)
						
						if a > 1 then
							b = b + (a - 1)
							a = 1
						end
						if b > 1 then
							a = a + (b - 1)
							b = 1
							if a > 0 then
								a = 1
							end
						end
						
						g = 1
						
					end
					
					if( a <= 0 or b <= 0 or g <= 0) then
						a = c
						b = c
						g = c
					end
					
					SobGroup_SetHealth(sob_alpha, a)
					SobGroup_SetHealth(sob_beta, b)
					SobGroup_SetHealth(sob_gamma, g)
					
					-- calculate XP
					for l = 1, getn(globalShipTable[i]) do
						if(globalShipTable[i][l][SobGroupIndex] == MVAM_PromBetaShipTable[i][MVAM_PromShipTable[i][k].beta].ship) then
							j_beta = l
							-- print(">> MVAM >> | beta")
						elseif(globalShipTable[i][l][SobGroupIndex] == MVAM_PromAlphaShipTable[i][MVAM_PromShipTable[i][k].alpha].ship) then
							j_alpha = l
							-- print(">> MVAM >> | alpha")
						elseif(globalShipTable[i][l][SobGroupIndex] == MVAM_PromGammaShipTable[i][MVAM_PromShipTable[i][k].gamma].ship) then
							j_gamma = l
							-- print(">> MVAM >> | gamma")
						elseif(globalShipTable[i][l][SobGroupIndex] == MVAM_PromShipTable[i][k].ship) then
							j_prom = l
							-- print(">> MVAM >> | prom")
						end
					end
					
					local XP_gained = globalShipTable[i][j_prom][Experience] - 1.0/3.0 * globalShipTable[i][j_prom][Strength] * ( globalShipTable[i][j_alpha][Experience]/globalShipTable[i][j_alpha][Strength] + globalShipTable[i][j_beta][Experience]/globalShipTable[i][j_beta][Strength] + globalShipTable[i][j_gamma][Experience]/globalShipTable[i][j_gamma][Strength])
					-- XP(alpha) = XP(alpha) + Strength(alpha)/Strength(beta) * 0.5 * XP_gained
					globalShipTable[i][j_alpha][Experience] = globalShipTable[i][j_alpha][Experience] + globalShipTable[i][j_alpha][Strength]/globalShipTable[i][j_prom][Strength] * XP_gained
					globalShipTable[i][j_beta][Experience] = globalShipTable[i][j_beta][Experience] + globalShipTable[i][j_beta][Strength]/globalShipTable[i][j_prom][Strength] * XP_gained
					globalShipTable[i][j_gamma][Experience] = globalShipTable[i][j_gamma][Experience] + globalShipTable[i][j_gamma][Strength]/globalShipTable[i][j_prom][Strength] * XP_gained
					
					XP_CheckForRankUp(i, j_alpha)
					XP_CheckForRankUp(i, j_beta)
					XP_CheckForRankUp(i, j_gamma)
					
					-- play sound
					local MVAM_SoundPosition = SobGroup_GetPosition(sob_beta)
					Sound_SFXPlay3DPos("data:sound/sfx/etg/special/MVAM_Separation", MVAM_SoundPosition)
					
				end
				
			-- once the prom is separated, despawn prom
			elseif( MVAM_PromShipTable[i][k].status == MVAM_Status_Separating
							and MVAM_PromShipTable[i][k].timer <= 0 ) then
				-- print(">> MVAM >> | Completing separation")
				
				MVAM_PromShipTable[i][k].status = MVAM_Status_Separated
				MVAM_PromAlphaShipTable[i][MVAM_PromShipTable[i][k].alpha].status = MVAM_Status_Separated
				MVAM_PromBetaShipTable[i][MVAM_PromShipTable[i][k].beta].status = MVAM_Status_Separated
				MVAM_PromGammaShipTable[i][MVAM_PromShipTable[i][k].gamma].status = MVAM_Status_Separated
				
				local sob_alpha = MVAM_GetAlphaSob(i, MVAM_PromShipTable[i][k].alpha)
				local sob_beta  = MVAM_GetBetaSob(i, MVAM_PromShipTable[i][k].beta)
				local sob_gamma = MVAM_GetGammaSob(i, MVAM_PromShipTable[i][k].gamma)
				local sob_prom  = MVAM_GetPromSob(i, k)
				
				SobGroup_Despawn(sob_prom)
				
				-- re-allow control of sections
				SobGroup_MakeSelectable(sob_alpha, 1)
				SobGroup_MakeSelectable(sob_beta, 1)
				SobGroup_MakeSelectable(sob_gamma, 1)
				SobGroup_SetTactics(sob_alpha, DefensiveTactics)
				SobGroup_SetTactics(sob_beta, DefensiveTactics)
				SobGroup_SetTactics(sob_gamma, DefensiveTactics)
				SobGroup_Stop(i, sob_alpha)
				SobGroup_Stop(i, sob_beta)
				SobGroup_Stop(i, sob_gamma)
				-- print(">> MVAM >> | Separation completed")
			end
			
		end
		
	end
end


-- returns the name of the sobgroup of a alpha/beta/prom
function MVAM_GetAlphaSob(i, param)
	return "Player"..i.."_ship"..MVAM_PromAlphaShipTable[i][param].ship
end
function MVAM_GetBetaSob(i, param)
	return "Player"..i.."_ship"..MVAM_PromBetaShipTable[i][param].ship
end
function MVAM_GetGammaSob(i, param)
	return "Player"..i.."_ship"..MVAM_PromGammaShipTable[i][param].ship
end
function MVAM_GetPromSob(i, param)
	return "Player"..i.."_ship"..MVAM_PromShipTable[i][param].ship
end
-- checks if a ship is already added to an MVAM tables
function MVAM_IsAlreadyKnown(mytable, j)
	for i = 1, getn(mytable) do
		if mytable[i].ship == j then
			-- print(">> MVAM >> | Known MVAM Ship")
			return 1
		end
	end
	-- print(">> MVAM >> | Unknown MVAM Ship")
	return 0
end