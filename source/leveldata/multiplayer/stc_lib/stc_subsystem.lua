----------------------------------------------------------------------------------------------------
-- SUBSYSTEM - plays hardpoint connected Mad animations
----------------------------------------------------------------------------------------------------
-- 
----------------------------------------------------------------------------------------------------

subsystemAnimShipTable = {}
subsystemAbilityShipTable = {}
subsystemWeaponShipTable = {}

-- Initialization
function subsystem_Init()
	for k = 1, getn(subsystemAnimTable) do
		subsystemAnimShipTable[k] = {}
	end
	for k = 1, getn(subsystemAbilityTable) do
		subsystemAbilityShipTable[k] = {}
	end
	for k = 1, getn(subsystemWeaponTable) do
		subsystemWeaponShipTable[k] = {}
	end
end

function subsystemRule()
	subsystemAnimRule()
	subsystemAbilityRule()
	subsystemWeaponRule()
end

function subsystemAnimRule()
	-- loop through all subsystems
	for k = 1, getn(subsystemAnimShipTable) do
		-- loop through all ships, which can build this subsystem
		local size = getn(subsystemAnimShipTable[k])
		local i = 1
		while( i <= size ) do	
			-- has build the subsystem
			if( SobGroup_GetHardPointHealth(subsystemAnimShipTable[k][i][1], subsystemAnimTable[k][1]) > 0 and subsystemAnimShipTable[k][i][2] == 0) then
				SobGroup_SetMadState(subsystemAnimShipTable[k][i][1], subsystemAnimTable[k][2])
				subsystemAnimShipTable[k][i][2] = 1
			
			-- has lost the subsystem
			elseif( SobGroup_GetHardPointHealth(subsystemAnimShipTable[k][i][1], subsystemAnimTable[k][1]) <= 0 and subsystemAnimShipTable[k][i][2] == 1 ) then
				-- reset ALL subsystem animations
				SobGroup_SetMadState(subsystemAnimShipTable[k][i][1], subsystemAnimResetMadstate)
				-- loop through all subsystems
				for m = 1, getn(subsystemAnimShipTable) do
					-- loop through all ships, which can build this subsystem
					for n = 1, getn(subsystemAnimShipTable[m]) do
						-- if equal to current ship
						if( subsystemAnimShipTable[m][n][1] == subsystemAnimShipTable[k][i][1]) then
							-- check if it has a subsystem to set
							if( SobGroup_GetHardPointHealth(subsystemAnimShipTable[m][n][1], subsystemAnimTable[m][1]) > 0) then
								SobGroup_SetMadState(subsystemAnimShipTable[m][n][1], subsystemAnimTable[m][2])
								subsystemAnimShipTable[m][n][2] = 1
							else
								subsystemAnimShipTable[m][n][2] = 0
							end
						end
					end
				end
			
			-- ship is dead
			elseif( SobGroup_Empty(subsystemAnimShipTable[k][i][1]) == 1 or SobGroup_HealthPercentage(subsystemAnimShipTable[k][i][1]) <= 0) then
				tremove(subsystemAnimShipTable[k], i)
				i = i - 1
				size = size - 1
			end
			
			i = i + 1
		end
		
	end
end

function subsystemAbilityRule()
	-- loop through all subsystems
	for k = 1, getn(subsystemAbilityShipTable) do
		-- loop through all ships, which can build this subsystem
		local size = getn(subsystemAbilityShipTable[k])
		local i = 1
		while( i <= size ) do
			
			-- has build the subsystem
			if( SobGroup_GetHardPointHealth(subsystemAbilityShipTable[k][i][1], subsystemAbilityTable[k][1]) > 0 and Player_HasResearch(subsystemAbilityShipTable[k][i][2], subsystemAbilityTable[k][4]) == 1 and SobGroup_CanDoAbility(subsystemAbilityShipTable[k][i][1], subsystemAbilityTable[k][2]) == 0 ) then
				SobGroup_AbilityActivate(subsystemAbilityShipTable[k][i][1], subsystemAbilityTable[k][2], 1)
			
			-- has lost the subsystem
			elseif( (SobGroup_GetHardPointHealth(subsystemAbilityShipTable[k][i][1], subsystemAbilityTable[k][1]) <= 0 or Player_HasResearch(subsystemAbilityShipTable[k][i][2], subsystemAbilityTable[k][4]) == 0) and SobGroup_CanDoAbility(subsystemAbilityShipTable[k][i][1], subsystemAbilityTable[k][2]) == 1 ) then
				SobGroup_AbilityActivate(subsystemAbilityShipTable[k][i][1], subsystemAbilityTable[k][2], 0)
			
			-- ship is dead
			elseif( SobGroup_Empty(subsystemAbilityShipTable[k][i][1]) == 1 or SobGroup_HealthPercentage(subsystemAbilityShipTable[k][i][1]) <= 0) then
				tremove(subsystemAbilityShipTable[k], i)
				i = i - 1
				size = size - 1
			end
			
			i = i + 1
		end
		
	end
end


function subsystemWeaponRule()
	-- loop through all subsystems
	for k = 1, getn(subsystemWeaponShipTable) do
		-- loop through all ships, which can build this subsystem
		local size = getn(subsystemWeaponShipTable[k])
		local i = 1
		while( i <= size ) do
			
			-- has build the subsystem
			if( SobGroup_GetHardPointHealth(subsystemWeaponShipTable[k][i][1], subsystemWeaponTable[k][1]) > 0 and subsystemWeaponShipTable[k][i][2] == 0 ) then
				for m = 1, getn(subsystemWeaponTable[k][2]) do
					-- print(">> SUBS >> | Activate weapon "..subsystemWeaponTable[k][2][m])
					SobGroup_ChangePower(subsystemWeaponShipTable[k][i][1], subsystemWeaponTable[k][2][m], 1)
				end
				subsystemWeaponShipTable[k][i][2] = 1
				
			-- has lost the subsystem
			elseif( SobGroup_GetHardPointHealth(subsystemWeaponShipTable[k][i][1], subsystemWeaponTable[k][1]) <= 0 and subsystemWeaponShipTable[k][i][2] == 1 ) then
				for m = 1, getn(subsystemWeaponTable[k][2]) do
					-- print(">> SUBS >> | Deactivate weapon "..subsystemWeaponTable[k][2][m])
					SobGroup_ChangePower(subsystemWeaponShipTable[k][i][1], subsystemWeaponTable[k][2][m], 0)
				end
				subsystemWeaponShipTable[k][i][2] = 0
			
			-- ship is dead
			elseif( SobGroup_Empty(subsystemWeaponShipTable[k][i][1]) == 1 or SobGroup_HealthPercentage(subsystemWeaponShipTable[k][i][1]) <= 0) then
				tremove(subsystemWeaponShipTable[k], i)
				i = i - 1
				size = size - 1
			end
			
			i = i + 1
		end
		
	end
end

-- initial: called when a ship is built. If the ship should have a subsystem connected animation/Ability
-- it'll be added to subsystemAnimShipTable/subsystemAbilityShipTable
function subsystemInitial(i, index)
	for k = 1, getn(subsystemAnimTable) do
		if( SobGroup_AreAnyOfTheseTypes("Player"..i.."_ship"..index, subsystemAnimTable[k][3]) == 1 ) then
			tinsert(subsystemAnimShipTable[k], {"Player"..i.."_ship"..index, 0})
		end
	end
	for k = 1, getn(subsystemAbilityTable) do
		if( SobGroup_AreAnyOfTheseTypes("Player"..i.."_ship"..index, subsystemAbilityTable[k][3]) == 1 ) then
			tinsert(subsystemAbilityShipTable[k], {"Player"..i.."_ship"..index, i})
		end
	end
	for k = 1, getn(subsystemWeaponTable) do
		if( SobGroup_AreAnyOfTheseTypes("Player"..i.."_ship"..index, subsystemWeaponTable[k][3]) == 1 ) then
			tinsert(subsystemWeaponShipTable[k], {"Player"..i.."_ship"..index, 1})
		end
	end
end
