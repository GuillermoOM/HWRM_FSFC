----------------------------------------------------------------------------------------------------
-- KEEPER ROUTINE - "make them harvestable, but you have to kill the Ogre first"
----------------------------------------------------------------------------------------------------
-- This routine will update Keepers. Keepers are ships, which defend an area on the map. They are
-- defined in the *.level files.
-- Keepers will scan for enemies within the 'KeeperRetaliationRange', which is defined in
-- STC_SETTINGS.lua along with other Keeper variables. If there are any enemies, the Keeper will
-- engage and attack them. If the Keeper moves outside his volume (defined in the *.level file),
-- it stops attacking and moves back to the volume. If the Keeper is not under attack anymore and is
-- inside his volume, it regenerates. If health is below a certain percentage in battle, the Keeper
-- starts a kamikaze attack at his attackers (ignoring the Keeper volume) or will change sides or
-- battle until death.
-- 
----------------------------------------------------------------------------------------------------
-- FOR THE LEVEL FILES:
-- 
-- To add Keepers to a map, you need a global SobGroup for all Keepers first:
--
--                          createSOBGroup("sob_AllKeepers")
--
-- To add Keepers to a map use the following lines:
-- 
-- addSphere("vol_Keeper1", {0, 0, 0,}, 5000)
-- addSquadron("sqd_Keeper1", "Kpr_Destroyer", { 0, 0, 0, }, -1, { 0, 0, 0, }, 0, 0)
-- createSOBGroup("sob_Keeper1")
-- addToSOBGroup("sqd_Keeper1", "sob_Keeper1")
-- addToSOBGroup("sqd_Keeper1", "sob_AllKeepers")
-- 
-- We start counting Keepers from 1. So the first Keeper has to be 'Keeper1', the second 'Keeper2'
-- and so on.
-- The lines above will create 'Keeper1'. 'Keeper1' will stay inside of 'vol_Keeper1'. The volume
-- is a shpere with radius 5000 at position {0, 0, 0,}. 'Keeper1' is a "Kpr_Destroyer", which is
-- spawned at { 0, 0, 0, } and owned by player "-1" (it's a map object).
----------------------------------------------------------------------------------------------------

KeeperTable = {}
RetaliationRange = 1
Kamikaze = 2
ChangeSide = 3
AtKamikaze = 4
KeeperAlive = 5

-- KeeperUpdateCycle : Counts game cycles, if 'KeeperUpdateCycle' == 'KeeperUpdateCycles' Keepers are updated
-- KeeperCount       : Number of Keepers
KeeperUpdateCycle = 0
KeeperCount = 0

-- Initialization
function keeper_Init()
	-- Only if a map has no Keepers 'sob_AllKeepers' is created here. We need this SobGorup because we
	-- get the KeeperCount from this SobGroup
	SobGroup_Create("sob_AllKeepers")
	KeeperCount = SobGroup_Count("sob_AllKeepers")
	
	if(KeeperCount > 0) then
		for k = 1, KeeperCount do
			tinsert(KeeperTable, getKeeperSpecificTable("sob_Keeper"..k))
			KeeperTable[k][4] = 0
			KeeperTable[k][5] = 1
		end
		
		-- 'sob_All' will contain all ships of all Players
		-- 'sob_KeeperEnemies' will contain all ships the Keeper should attack
		SobGroup_Create("sob_All")
		SobGroup_Clear("sob_All")
		SobGroup_Create("sob_KeeperEnemies")
		SobGroup_Clear("sob_KeeperEnemies")	
	end

end

-- Main Keeper Rule
function keeperRule()
	-- Only process Keepers, if any Keepers exist
	if(KeeperCount > 0) then
		-- Only update Keepers every 'KeeperUpdateCycles' game cycles
		if(KeeperUpdateCycle == KeeperUpdateCycles) then
			KeeperUpdateCycle = 0
			-- loop through all Keepers
			for k = 1, KeeperCount do
				-- Only update Keeper if he's still alive
				if(SobGroup_HealthPercentage("sob_Keeper"..k) > 0 and KeeperTable[k][KeeperAlive] == 1) then
					updateKeeper(k)
				end
			end
		else
			KeeperUpdateCycle = KeeperUpdateCycle + 1
		end
	end
end

-- Update Keeper 'k'
function updateKeeper(k)

	-- Shall we switch to kamikaze attack? (Ignores the Keeper volume)
	-- Check:
	-- 1. Health below 'KeeperKamikazeHealthPercentage'?
	-- 2. Are we under attack?
	if(SobGroup_HealthPercentage("sob_Keeper"..k) < KeeperKamikazeHealthPercentage and SobGroup_UnderAttack("sob_Keeper"..k) == 1 and (KeeperTable[k][Kamikaze] == 1 or KeeperTable[k][ChangeSide] == 1) ) then
		
		if( KeeperTable[k][AtKamikaze] == 1 ) then
		-- check for kamikaze
		elseif( (KeeperTable[k][Kamikaze] == 1 and KeeperTable[k][ChangeSide] == 0) or (KeeperTable[k][Kamikaze] == 1 and KeeperTable[k][ChangeSide] == 1 and random(2) == 1) ) then
			KeeperTable[k][AtKamikaze] = 1
			SobGroup_GetAttackers("sob_Keeper"..k, "sob_KeeperEnemies")
			--SobGroup_SetTactics("sob_KeeperEnemies", 1)
			SobGroup_Kamikaze("sob_Keeper"..k, "sob_KeeperEnemies")
			SobGroup_SetSpeed("sob_Keeper"..k, KeeperKamikazeSpeedBoost)
			
		-- else: change side
		else
			SobGroup_GetAttackers("sob_Keeper"..k, "sob_KeeperEnemies")
			SobGroup_SwitchOwner("sob_Keeper"..k, SobGroup_OwnedBy("sob_KeeperEnemies"))
			KeeperTable[k][KeeperAlive] = 0
		end
		
	else
		-- default Keeper update process:
		
		-- set speed to 1. Needed if we were on kamikaze attack before
		if( KeeperTable[k][AtKamikaze] == 1 ) then
			KeeperTable[k][AtKamikaze] = 0
			SobGroup_SetSpeed("sob_Keeper"..k, 1)
		end
		
		-- Scan for enemies:
		-- 1. Clear old SobGroups
		-- 2. Get all ships of all Players
		-- 3. Get all ships within 'KeeperRetaliationRange' --> enemies
		SobGroup_Clear("sob_All")
		SobGroup_Clear("sob_KeeperEnemies")
		for i = 0, Universe_PlayerCount()-1 do
			if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
				SobGroup_SobGroupAdd("sob_All", "Player_Ships"..i)
			end
		end
		SobGroup_FillProximitySobGroup("sob_KeeperEnemies", "sob_All", "sob_Keeper"..k, KeeperTable[k][RetaliationRange])
		
		-- Check:
		-- 1. Are there any enemies within range?
		-- 2. Are we in the volume that we want to defend?
		if(SobGroup_Empty("sob_KeeperEnemies") == 0 and SobGroup_IsInVolume("sob_Keeper"..k, "vol_Keeper"..k) == 1) then
			-- if so: ATTACK ENEMIES!
			-- Because the player cannot attack us manually, we have to set his tactics to defensive (Defensive! Agressive doesn't work correctly!)
			SobGroup_SetTactics("sob_KeeperEnemies", 1)
			if(SobGroup_IsDoingAbility("sob_Keeper"..k, AB_Attack) ~= 1) then
				SobGroup_Attack(0, "sob_Keeper"..k, "sob_KeeperEnemies")
			end
		
		else
			-- If there are no enemies: back to our origin
			if(SobGroup_IsDoingAbility("sob_Keeper"..k, AB_Move) ~= 1) then
				SobGroup_Move(0, "sob_Keeper"..k, "vol_Keeper"..k)
			end
			
			-- Regenerate ship, if we're not under attack and inside our volume
			if(SobGroup_UnderAttack("sob_Keeper"..k) == 0 and SobGroup_IsInVolume("sob_Keeper"..k, "vol_Keeper"..k) == 1) then
				local KeeperHealth = SobGroup_HealthPercentage("sob_Keeper"..k)
				if(KeeperHealth < 1) then
					if(KeeperHealth + KeeperRegenerationAmount > 1) then
						SobGroup_SetHealth("sob_Keeper"..k, 1)
					else
						SobGroup_SetHealth("sob_Keeper"..k, KeeperHealth + KeeperRegenerationAmount)
					end
				end
			end
			
		end
		
	end
end

----------------------------------------------------------------------------------------------------
function getKeeperSpecificTable(sob_ship)
	for k = 1, getn(KeeperInfoTable) do
		if( SobGroup_AreAnyOfTheseTypes(sob_ship, KeeperInfoTable[k][1]) == 1 ) then
			return KeeperInfoTable[k][2]
		end
	end
	
	return KeeperDefault
end
