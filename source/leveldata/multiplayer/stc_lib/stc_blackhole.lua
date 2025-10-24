----------------------------------------------------------------------------------------------------
-- BLACK HOLE ROUTINE - "Oh shit! I divided by zero"
----------------------------------------------------------------------------------------------------
-- A black hole has a 10km warp inhibitor field.
--
----------------------------------------------------------------------------------------------------
-- FOR THE LEVEL FILES:
-- 
-- To add black holes to a map, you need a global SobGroup for all black holes first:
--
--                          createSOBGroup("sob_AllBlackholes")
--
-- To add black holes to a map use the following lines:
-- 
-- addSquadron("sqd_Blackhole1", "zzz_blackhole", {0, 0, 0}, -1, {5, 0, 0}, 0, 0)
-- createSOBGroup("sob_Blackhole1")
-- addToSOBGroup("sqd_Blackhole1", "sob_Blackhole1")
-- addToSOBGroup("sqd_Blackhole1", "sob_AllBlackholes")
-- 
----------------------------------------------------------------------------------------------------

-- BlackholeUpdateCycle      : Counts game cycles, if 'BlackholeUpdateCycle' == 'BlackholeUpdateCycles' Blackholes are updated
-- BlackholeCount            : Number of Blackholes
BlackholeUpdateCycle = 0
BlackholeCount = 0

-- Initialization
function blackhole_Init()
	-- Only if a map has no Blackholes 'sob_AllBlackholes' is created here. We need this SobGorup because we
	-- get the BlackholeCount from this SobGroup
	SobGroup_Create("sob_AllBlackholes")
	BlackholeCount = SobGroup_Count("sob_AllBlackholes")
	
	-- 'sob_All' will contain all ships of all Players
	-- 'sob_BlackholeEnemies' will contain all ships the Blackhole should attack
	SobGroup_Create("sob_All")
	SobGroup_Clear("sob_All")
	SobGroup_Create("sob_BlackholeEnemies")
	SobGroup_Clear("sob_BlackholeEnemies")
end

-- Main Blackhole Rule
function blackholeRule()
	-- Only process Blackholes, if any Blackholes exist
	if(BlackholeCount > 0) then
		-- Only update Blackholes every 'BlackholeUpdateCycles' game cycles
		if(BlackholeUpdateCycle == BlackholeUpdateCycles) then
			BlackholeUpdateCycle = 0
			-- loop through all Blackholes
			for k = 1, BlackholeCount do
				updateBlackhole(k)
			end
		else
			BlackholeUpdateCycle = BlackholeUpdateCycle + 1
		end
	end
end

-- Update Blackhole 'k'
function updateBlackhole(k)
	-- Scan for enemies:
	-- 1. Clear old SobGroup
	-- 2. Get all ships of all Players
	-- 3. Get all ships within the maximum damage radius --> enemies
	SobGroup_Clear("sob_All")
	for i = 0, Universe_PlayerCount()-1 do
		if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
			SobGroup_SobGroupAdd("sob_All", "Player_Ships"..i)
		end
	end
	SobGroup_FillProximitySobGroup("sob_BlackholeEnemies", "sob_All", "sob_Blackhole"..k, BlackholeDamageRadii[1][1])
	
	-- Check:
	-- 1. Are there any enemies within range?
	if(SobGroup_Empty("sob_BlackholeEnemies") == 0) then
		if(SobGroup_IsDoingAbility("sob_Blackhole"..k, AB_Attack) ~= 1) then
			SobGroup_Attack(0, "sob_Blackhole"..k, "sob_BlackholeEnemies")
		end
		
		-- calculate correct damage
		for j = 1, getn(BlackholeDamageRadii) do
			local BlackholeDamage = BlackholeDamageRadii[j][2]
			for l = 1, j-1 do
				BlackholeDamage = BlackholeDamage - BlackholeDamageRadii[l][2]
			end
			-- we have to loop through all players, because the 'SobGroup_DoDamageProximitySobGroup' only
			-- damages ships of a specific player
			for i = 0, Universe_PlayerCount()-1 do
				if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
					-- deal damage
					SobGroup_DoDamageProximitySobGroup("sob_Blackhole"..k, i, BlackholeDamage, BlackholeDamageRadii[j][1])
				end
			end
		end
	end
	
end
