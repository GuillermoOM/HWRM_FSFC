----------------------------------------------------------------------------------------------------
-- SOK - controls SOK class carrier drones
----------------------------------------------------------------------------------------------------
-- 
----------------------------------------------------------------------------------------------------

SOK_ShipTable = {}
SOK_DroneCount = 4
DRONE_Timer = 100
DOORS_Timer = 40

SOK_Status_Launch = 0
SOK_Status_Dock = 1

DRONE_Status_Docked = 0
DRONE_Status_Launching = 1
DRONE_Status_Guarding = 2
DRONE_Status_Parade = 3
DRONE_Status_ParadeLost = 4
DRONE_Status_Docking = 5

TACTICS_Aggressive = 0
TACTICS_Defensive = 1
TACTICS_Passive = 2

DOORS_Open = 0
DOORS_Closed = 1

-- Initialization
function SOK_Init()
	Volume_AddSphere("SOK_Volume", {0, 10^9, 0,}, 1000)
end

function SOKRule()
	-- loop through all SOK classes
	local size = getn(SOK_ShipTable)
	local k = 1
	while( k <= size ) do
	
		------------------------------------------------------------------------------------------------
		-- if SOK has been destroyed
		if( SobGroup_Empty(SOK_ShipTable[k].sob) == 1 or SobGroup_HealthPercentage(SOK_ShipTable[k].sob) <= 0 ) then
			-- destroy drones
			for m = 1, SOK_DroneCount do
				if( SOK_ShipTable[k].drones[m] ) then
					SobGroup_SetHealth(SOK_ShipTable[k].drones[m].sob, 0)
				end
			end
			-- remove SOK
			tremove(SOK_ShipTable, k)
			k = k - 1
			size = size - 1
		
		-- otherwise
		else
			
			----------------------------------------------------------------------------------------------
			-- UPDATE DOOR TIMER
			
			if( SOK_ShipTable[k].timer >= 0 ) then
				SOK_ShipTable[k].timer = SOK_ShipTable[k].timer - 1
				--print(">> SOK >> | Door timer is "..SOK_ShipTable[k].timer)
			end
			
			----------------------------------------------------------------------------------------------
			-- UPDATE SOK STATUS
			
			-- get current tactics
			local tactics = SobGroup_GetTactics(SOK_ShipTable[k].sob)
			-- has the tactic changed since last check?
			if( tactics ~= SOK_ShipTable[k].lasttactics ) then
				-- set autolaunch setting depending on tactics
				if( tactics == TACTICS_Aggressive ) then
					-- launch drones
					SobGroup_SetAutoLaunch(SOK_ShipTable[k].sob, ShipHoldLaunch)
					-- set status
					SOK_ShipTable[k].status = SOK_Status_Launch
					--print(">> SOK >> | Launching drones")
					
				else
					-- return all drones
					SobGroup_SetAutoLaunch(SOK_ShipTable[k].sob, ShipHoldStayDockedAlways)
					-- set status
					SOK_ShipTable[k].status = SOK_Status_Dock
					--print(">> SOK >> | Ordering drones to return to ship")
				end
				-- save last tactics
				SOK_ShipTable[k].lasttactics = tactics
			end
			
			
			----------------------------------------------------------------------------------------------
			-- DOOR ANIMATIONS
			-- do this before the drone update
			
			--print(">> SOK >> | STATUS = "..SOK_ShipTable[k].status)
			if( SOK_ShipTable[k].status == SOK_Status_Launch ) then
				
				if( SOK_ShipTable[k].doors == DOORS_Closed ) then
					--print(">> SOK >> | 1 Doors are closed, check if should open them")
					local open = 0
					-- loop through all drones
					for m = 1, SOK_DroneCount do
						-- if at least one drones is docked open doors
						if( SOK_ShipTable[k].drones[m] ) then
							if( SobGroup_IsDocked(SOK_ShipTable[k].drones[m].sob) == 1 ) then
								open = 1
								--print(">> SOK >> | Drone is inside shiphold")
								break
							end
						end
					end
					
					if( open == 1 ) then
						-- open doors
						SobGroup_SetMadState(SOK_ShipTable[k].sob, "ResourceStart")
						SOK_ShipTable[k].doors = DOORS_Open
						SOK_ShipTable[k].timer = DOORS_Timer
						SobGroup_SetSpeed(SOK_ShipTable[k].sob, 0.2)
						--print(">> SOK >> | Opening doors")
					end
					
				elseif( SOK_ShipTable[k].doors == DOORS_Open and SOK_ShipTable[k].timer <= 0 ) then
				
					local close = 1
					-- loop through all drones
					for m = 1, SOK_DroneCount do
						-- if drones exists
						if( SOK_ShipTable[k].drones[m] ) then
							-- if one ship is not launched keep doors open
							if( SobGroup_IsDocked(SOK_ShipTable[k].drones[m].sob) == 1 ) then
								close = 0
								--print(">> SOK >> | Can't close doors, one drone is still inside!")
								break
							end
						end
					end
					
					if( close == 1 ) then
						-- close doors
						SobGroup_SetMadState(SOK_ShipTable[k].sob, "ResourceEnd")
						SOK_ShipTable[k].doors = DOORS_Closed
						SobGroup_SetSpeed(SOK_ShipTable[k].sob, 1.0)
						--print(">> SOK >> | Closing doors")
					end
				end
				
			else
				
				if( SOK_ShipTable[k].doors == DOORS_Closed ) then
					--print(">> SOK >> | 2 Doors are closed, check if should open them")
					-- open doors
					local open = 0
					-- loop through all drones
					for m = 1, SOK_DroneCount do
						-- if at least one drones is not docked open doors
						if( SOK_ShipTable[k].drones[m] ) then
							if( SobGroup_IsDocked(SOK_ShipTable[k].drones[m].sob) == 0 ) then
								open = 1
								--print(">> SOK >> | Drones are outside")
								break
							end
						end
					end
					
					if( open == 1 ) then
						-- open doors
						SobGroup_SetMadState(SOK_ShipTable[k].sob, "ResourceStart")
						SOK_ShipTable[k].doors = DOORS_Open
						SOK_ShipTable[k].timer = DOORS_Timer
						SobGroup_SetSpeed(SOK_ShipTable[k].sob, 0.2)
						--print(">> SOK >> | Opening doors")
					end
				
				elseif( SOK_ShipTable[k].doors == DOORS_Open and SOK_ShipTable[k].timer <= 0 ) then
				
					local close = 1
					-- loop through all drones
					for m = 1, SOK_DroneCount do
						-- if drones exists
						if( SOK_ShipTable[k].drones[m] ) then
							-- if one drone is not docked keep doors open
							if( SobGroup_IsDocked(SOK_ShipTable[k].drones[m].sob) == 0 ) then
								close = 0
								--print(">> SOK >> | Can't close doors, one drone is still outside!")
								break
							end
						end
					end
					
					if( close == 1 ) then
						-- close doors
						SobGroup_SetMadState(SOK_ShipTable[k].sob, "ResourceEnd")
						SOK_ShipTable[k].doors = DOORS_Closed
						SobGroup_SetSpeed(SOK_ShipTable[k].sob, 1.0)
						--print(">> SOK >> | Closing doors")
					end
				
				end
				
			end
			
			
			----------------------------------------------------------------------------------------------
			-- UPDATE DRONES
			
			-- loop through all drones
			for m = 1, SOK_DroneCount do
				-- if drones exists
				if( SOK_ShipTable[k].drones[m] ) then
					-- if drone is dead
					if( SobGroup_Empty(SOK_ShipTable[k].drones[m].sob) == 1
						or SobGroup_HealthPercentage(SOK_ShipTable[k].drones[m].sob) <= 0 ) then
						-- remove drone, destroy subsystem
						SOK_ShipTable[k].drones[m] = nil
						SobGroup_SetHardPointHealth(SOK_ShipTable[k].sob, "kng_TMP_dronesubs"..m, 0)
						--print(">> SOK >> | Drone destroyed")
						
					-- otherwise
					else
						-- update timers
						if( SOK_ShipTable[k].drones[m].timer >= 0 ) then
							SOK_ShipTable[k].drones[m].timer = SOK_ShipTable[k].timer - 1
							--print(">> SOK >> | Drone timer is "..SOK_ShipTable[k].drones[m].timer)
						end
						
						if( SOK_ShipTable[k].status == SOK_Status_Launch ) then
							-- if drone is in shiphold: launch!
							if( SobGroup_IsDocked(SOK_ShipTable[k].drones[m].sob) == 1
								and SOK_ShipTable[k].drones[m].status ~= DRONE_Status_Launching ) then
								
								SobGroup_Launch(SOK_ShipTable[k].drones[m].sob, SOK_ShipTable[k].sob)
								SOK_ShipTable[k].drones[m].status = DRONE_Status_Launching
								SOK_ShipTable[k].drones[m].timer = DRONE_Timer
								
							-- once launched: parade formation!
							elseif( SobGroup_IsDocked(SOK_ShipTable[k].drones[m].sob) == 0
								and (SOK_ShipTable[k].drones[m].status == DRONE_Status_Launching
								or SOK_ShipTable[k].drones[m].status == DRONE_Status_Docking)
								and SOK_ShipTable[k].drones[m].timer <= 0 ) then
								
								SobGroup_ParadeSobGroup(SOK_ShipTable[k].drones[m].sob, SOK_ShipTable[k].sob, 0)
								SOK_ShipTable[k].drones[m].status = DRONE_Status_Parade
								
							-- if SOK is under attack: guard it!
							elseif( SOK_ShipTable[k].drones[m].status == DRONE_Status_Parade
								and SobGroup_UnderAttack(SOK_ShipTable[k].sob) == 1 ) then
								SobGroup_GuardSobGroup(SOK_ShipTable[k].drones[m].sob, SOK_ShipTable[k].sob)
								SOK_ShipTable[k].drones[m].status = DRONE_Status_Guarding
								
							-- if SOK is not under attack anymore: back into parade formation
							elseif( SOK_ShipTable[k].drones[m].status == DRONE_Status_Guarding
								and ( SobGroup_UnderAttack(SOK_ShipTable[k].sob) == 0
								or SobGroup_IsDoingAbility(SOK_ShipTable[k].drones[m].sob, AB_Guard) == 0 ) ) then
								SobGroup_ParadeSobGroup(SOK_ShipTable[k].drones[m].sob, SOK_ShipTable[k].sob, 0)
								SOK_ShipTable[k].drones[m].status = DRONE_Status_Parade
								
							-- if SOK warps away: parade is lost, bring drones into hyperspace off map
							elseif( ( SOK_ShipTable[k].drones[m].status == DRONE_Status_Parade
								or SOK_ShipTable[k].drones[m].status == DRONE_Status_Guarding )
								and SobGroup_AreAllInHyperspace(SOK_ShipTable[k].sob) == 1 ) then
								SobGroup_EnterHyperSpaceOffMap(SOK_ShipTable[k].drones[m].sob)
								SOK_ShipTable[k].drones[m].status = DRONE_Status_ParadeLost
								SOK_ShipTable[k].drones[m].timer = DRONE_Timer
								
							-- once SOK reappears: reenter map and go into parade formation!
							elseif( SOK_ShipTable[k].drones[m].status == DRONE_Status_ParadeLost
								and SobGroup_AreAllInHyperspace(SOK_ShipTable[k].sob) == 0
								and SOK_ShipTable[k].drones[m].timer <= 0 ) then
								SobGroup_ExitHyperSpaceSobGroup(SOK_ShipTable[k].drones[m].sob, SOK_ShipTable[k].sob, 2000)
								SobGroup_ParadeSobGroup(SOK_ShipTable[k].drones[m].sob, SOK_ShipTable[k].sob, 0)
								SOK_ShipTable[k].drones[m].status = DRONE_Status_Parade
								
							end
							
						else
							-- if drone is outside: order to return to SOK
							if( SobGroup_IsDocked(SOK_ShipTable[k].drones[m].sob) == 0
								and SOK_ShipTable[k].drones[m].status ~= DRONE_Status_Docking
								and SOK_ShipTable[k].drones[m].timer <= 0 ) then
								
								SobGroup_DockSobGroup(SOK_ShipTable[k].drones[m].sob, SOK_ShipTable[k].sob)
								SOK_ShipTable[k].drones[m].status = DRONE_Status_Docking
								
							end
						end
						
					end
					
				-- if subsystem is build and drone doesn't exist
				elseif( SobGroup_GetHardPointHealth(SOK_ShipTable[k].sob, "kng_TMP_dronesubs"..m) > 0 ) then
					-- create new drone in shiphold
					local i = SobGroup_OwnedBy(SOK_ShipTable[k].sob)
					local j = getFreeShipIndex(i)
					SobGroup_Create("sob_drone")
					SobGroup_Clear("sob_drone")
					SobGroup_SpawnNewShipInSobGroup(i, "kng_TMP_drone"..m, "MySquadron1", "sob_drone", "MVAM_Volume")
					SobGroup_DockSobGroupInstant("sob_drone", SOK_ShipTable[k].sob)
					createShipSpecificTable(i, j, "sob_drone")
					-- add drone to SOK table
					SOK_ShipTable[k].drones[m] = {sob = "Player"..i.."_ship"..j, status = DRONE_Status_Docked, timer = -1}
					-- disable selection
					SobGroup_MakeSelectable("Player"..i.."_ship"..j, 0)
					--print(">> SOK >> | Drone build")
					
				end
				
			end
			
		
		end
		
		k = k + 1
	end
end


function SOKInitial(i, index)
	local sob = "Player"..i.."_ship"..index
	if( SobGroup_AreAnyOfTheseTypes(sob, "kng_TMP_swordofkahless") == 1 ) then
		tinsert(SOK_ShipTable, {sob = sob, status = SOK_Status_Dock, doors = DOORS_Closed, timer = -1, lasttactics = -1, drones = {}})
	end
end
