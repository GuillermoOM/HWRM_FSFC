----------------------------------------------------------------------------------------------------
-- WARP ROUTINE
----------------------------------------------------------------------------------------------------
-- The main idea behind warp is to check, whether a ship wants to hyperspace or falls out of 
-- hyperspace and manually play hyperspace animations.
--
-- We use the Madstates NIS00 for warp in (appear) and NIS01 for warp out (disappear).
-- They we're originally used by the Hiigaran mothership in a mission to open the large side door
-- wide enough for the core.
-- All timers have to be multiplied by 10! We calculate in 1/10 seconds.
-- Don't use decimals, for some reasons we don't get exact values in calculations!
--
----------------------------------------------------------------------------------------------------
--
-- It's all a bit tricky. Simply checking SobGroup_IsDoingAbility to trigger the warp out effect
-- doesn't work in every case. If we're in an inhibitor field SobGroup_IsDoingAbility can be true,
-- although we're not going to jump.
-- There's another thing we could check: SobGroup_AreAllInHyperspace. Sadly we cannot start a
-- Madstate animation once SobGroup_AreAllInHyperspace becomes true. So utilizing 
-- SobGroup_IsDoingAbility AND SobGroup_AreAllInHyperspace == true as a trigger for the warp out 
-- animation won't work.
-- But luckily: if SobGroup_AreAllInHyperspace isn't true after ~2/10 seconds, we will not
-- hyperspace.
--
-- When we try to hyperspace (SobGroup_IsDoingAbility) set the warp variable to 1 (prepare for 
-- warp). Then increment the timer variable and if we reach 2 we play the FX, if not set both
-- variables to standard again.
-- Play the warp in FX once SobGroup_IsDoingAbility (finished complete hyperspace jump) or 
-- SobGroup_AreAllInHyperspace (fallen out of hyperspace) is false.
----------------------------------------------------------------------------------------------------
-- 
-- Known bugs and issues:
-- A ship, which is ordered to hyperspace while ships are launching from it, will play the warp out
-- animation too early.
-- 
----------------------------------------------------------------------------------------------------
Recharge_Fighter = 1
Recharge_Bomber = 0.9
Recharge_Cruiser = 0.8
Recharge_Corvette = 0.7
Recharge_Destroyer = 0.4
Recharge_Juggernaut = 0.3

--We need to be particular about how quickly ships recharge their jump drives. These are the base values for ships. Subspace mastery can increase this rate.
Recharge = 1

--This is the increase a ship gets from Sprint Drive research.
Recharge_Sprint = 0.5

--These are level 1 and level 2 subspace mastery researches for Shivans. These values are cumulative.
Recharge_Mastery1 = 0.15
Recharge_Mastery2 = 0.2

WARP_Status_Idle = 0
WARP_Status_Engaging = 1
WARP_Status_AtWarp = 2
WARP_Status_Leaving = 3
WARP_Status_Recovering = 4

-- we do the warp thing for ship j of player i
function WARP_Rule(i, j)
   if globalShipTable[i][j][Shield] ~= 0 then
	-- we need the ship name quite often
	sob_ship = globalShipTable[i][j][SobGroup]
	
	--we jump in to possibly modifying the recharge rate. We'll first set it to 1 in case we find that it isn't any of what we see here.
	Recharge = 1
	if SobGroup_AreAnyFromTheseAttackFamilies(sob_ship, "Fighter")==1 then
		Recharge = Recharge_Fighter
	elseif SobGroup_AreAnyFromTheseAttackFamilies(sob_ship, "Corvette")==1 then
		Recharge = Recharge_Bomber
	elseif SobGroup_AreAnyFromTheseAttackFamilies(sob_ship, "Frigate")==1 then
		Recharge = Recharge_Cruiser
	elseif SobGroup_AreAnyFromTheseAttackFamilies(sob_ship, "SmallCapitalShip")==1 then
		Recharge = Recharge_Corvette
		if Player_HasResearch(i, "CorvetteSprint") == 1 or SobGroup_AreAnyOfTheseTypes(sob_ship, "ntf_iceni") == 1 then
			Recharge = Recharge + Recharge_Sprint
		end		
	elseif SobGroup_AreAnyFromTheseAttackFamilies(sob_ship, "BigCapitalShip")==1 then
		Recharge = Recharge_Destroyer
		if SobGroup_AreAnyOfTheseTypes(sob_ship, "shi_ravana")==1 and Player_HasResearch(i, "RavanaSprint") == 1 then
			Recharge = Recharge + Recharge_Sprint
		end
	elseif SobGroup_AreAnyFromTheseAttackFamilies(sob_ship, "Mothership")==1 then
		Recharge = Recharge_Juggernaut
	end
	--if we have the subspace mastery research, boost the recharge rate. It's called twice if they have both researches, for a rather significant boost.
	if Player_HasResearch(i, "Subspace1") == 1 then
		Recharge = Recharge + Recharge_Mastery1
	end
	if Player_HasResearch(i, "Subspace2") == 1 then
		Recharge = Recharge + Recharge_Mastery2
	end
	if SobGroup_AreAnyFromTheseAttackFamilies(sob_ship, "SmallCapitalShip, BigCapitalShip, Mothership") == 1 then
		--If the Engine subsystem is damaged, it recharges more slowly.
		Recharge = Recharge * (SobGroup_GetHardPointHealth(sob_ship, "Engine"))
	end
	
		
	
	-- increment warp timer when we're on warp or prepare for warp
	if( globalShipTable[i][j][IsAtWarp] > 0 ) then
		globalShipTable[i][j][WarpTimer] = globalShipTable[i][j][WarpTimer] + Recharge
	end
	
	-- WARP OUT --------------------------------------------------------------------------------------
	-- Warp out of the screen
	if( globalShipTable[i][j][IsAtWarp] == WARP_Status_Idle ) then
	--we need to enable to the subspace drive if it isn't enabled. We moved it here, because it's possible for the subspace drive to be recharged without enabling jumps.
		if SobGroup_AreAnyFromTheseAttackFamilies(sob_ship, "SmallCapitalShip, BigCapitalShip, Mothership") == 0 then
			SobGroup_AbilityActivate(sob_ship, AB_Hyperspace, 1)
		else
		--If we're dealing with a Capital ship, it needs to have the ability if it is idling with a nav system, and lose it if it isn't.
			if SobGroup_GetHardPointHealth(sob_ship, "Navigation") > 0 then
				SobGroup_AbilityActivate(sob_ship, AB_Hyperspace, 1)
			else
				SobGroup_AbilityActivate(sob_ship, AB_Hyperspace, 0)
			end
		end
		--this tidbit of code will disable a ship's subspace drive if it was idling, but the ship is being captured. This replaces the old
		--system where we just sloppily had a hyperspace inhib field on the capture ships. This should be more reliable too.
		SobGroup_Create("sob_ship_captured")
		SobGroup_Clear("sob_ship_captured")
		SobGroup_GetSobGroupBeingCapturedGroup(sob_ship, "sob_ship_captured")
		if SobGroup_Empty("sob_ship_captured") == 0 then
			SobGroup_AbilityActivate(sob_ship, AB_Hyperspace, 0)
		end
		-- 1. Are we doing the hyperspace ability?
		if( SobGroup_IsDoingAbility(sob_ship, AB_Hyperspace) == 1 ) then
			
			globalShipTable[i][j][IsAtWarp] = WARP_Status_Engaging -- prepare for warp
			--globalShipTable[i][j][WarpTimer] = 0 -- reset timer
			
		end
	end
	
	
	-- no elseif here!
	if( globalShipTable[i][j][IsAtWarp] == WARP_Status_Engaging ) then
		-- play 'warp out' gfx, sfx and mad with offsets
		SobGroup_SetMadState(sob_ship, "NIS01")
		--if( globalShipTable[i][j][WarpTimer] == WARP_FXOffsetTable[globalShipTable[i][j][Race]][1]) then
			--SobGroup_SetMadState(sob_ship, "NIS01")
			--FX_StartEvent(sob_ship, "nacelleflash")
		--end
		if( globalShipTable[i][j][WarpTimer] == WARP_FXOffsetTable[globalShipTable[i][j][Race]][2] and globalShipTable[i][j][Cloak] == 0 ) then
			--FX_PlayEffect("warp_"..WARP_RaceFXTable[globalShipTable[i][j][Race]].."_warpflash_out", sob_ship, WARP_FXScale)
		end
		if( globalShipTable[i][j][WarpTimer] == WARP_FXOffsetTable[globalShipTable[i][j][Race]][3] ) then
			local WARP_SoundPosition = SobGroup_GetPosition(sob_ship)
			Sound_SFXPlay3DPos("data:sound/sfx/etg/special/"..WARP_RaceFXTable[globalShipTable[i][j][Race]].."_WARP_OUT", WARP_SoundPosition)
		end
		
		-- we're at warp if SobGroup_IsDoingAbility AND SobGroup_AreAllInHyperspace == true
		if( SobGroup_AreAllInHyperspace(sob_ship) == 1) then
			globalShipTable[i][j][IsAtWarp] = WARP_Status_AtWarp -- we're now at warp
		end
		
		
	-- WARP IN ---------------------------------------------------------------------------------------
	-- Warp back to the screen
	elseif( globalShipTable[i][j][IsAtWarp] == WARP_Status_AtWarp ) then
		
		-- 1. Did we finish hyperspace jump or did we fall out of hyperspace?
		if( SobGroup_IsDoingAbility(sob_ship, AB_Hyperspace) == 0
				or SobGroup_AreAllInHyperspace(sob_ship) == 0 ) then
			
			globalShipTable[i][j][IsAtWarp] = WARP_Status_Leaving -- we're not at warp anymore; the timer should increment further on, though.
			globalShipTable[i][j][WarpTimer] = 0 -- reset timer
			
		end
		
	end
	
	-- no elseif here!
	if( globalShipTable[i][j][IsAtWarp] == WARP_Status_Leaving ) then
		-- play 'warp in' gfx, sfx and mad with offsets
		if( globalShipTable[i][j][WarpTimer] == WARP_FXOffsetTable[globalShipTable[i][j][Race]][4]) then
			SobGroup_SetMadState(sob_ship, "NIS00")
		end
		if( globalShipTable[i][j][WarpTimer] == WARP_FXOffsetTable[globalShipTable[i][j][Race]][5] and globalShipTable[i][j][Cloak] == 0 ) then
			--FX_PlayEffect("warp_"..WARP_RaceFXTable[globalShipTable[i][j][Race]].."_warpflash_in", sob_ship, WARP_FXScale)
		end
		if( globalShipTable[i][j][WarpTimer] == WARP_FXOffsetTable[globalShipTable[i][j][Race]][6] ) then
			local WARP_SoundPosition = SobGroup_GetPosition(sob_ship)
			--Sound_SFXPlay3DPos("data:sound/sfx/etg/special/"..globalShipTable[i][j][Race].."_WARP_OUT", WARP_SoundPosition)
			Sound_SFXPlay3DPos("data:sound/sfx/etg/special/"..WARP_RaceFXTable[globalShipTable[i][j][Race]].."_WARP_IN", WARP_SoundPosition)
		end
		
		-- Finished whole hyperspace jump?
		if( SobGroup_IsDoingAbility(sob_ship, AB_Hyperspace) == 0 and SobGroup_AreAllInHyperspace(sob_ship) == 0) then
			
			globalShipTable[i][j][IsAtWarp] = WARP_Status_Recovering
			globalShipTable[i][j][WarpTimer] = 0
			
			-- disable warp ability
			SobGroup_AbilityActivate(sob_ship, AB_Hyperspace, 0)
			
			if( i == FE_GetCurrentPlayerIndex() ) then
				globalShipTable[i][j][List].ping_id = Ping_AddSobGroup("", "subspace", sob_ship)
			end
			
		end
		
		
	-- WARP RECOVERY ---------------------------------------------------------------------------------
	-- Recover warp engine
	elseif( globalShipTable[i][j][IsAtWarp] == WARP_Status_Recovering ) then
		--while the Subspace drive recovers, it should not be active.
		SobGroup_AbilityActivate(sob_ship, AB_Hyperspace, 0)
		--If the ship is yours, and isn't a turret or subspace node, and isn't something that can't or isn't charged, then
		if( i == FE_GetCurrentPlayerIndex() ) and (globalShipTable[i][j][WarpTimer]) > 0 then
			Ping_AddDescription(globalShipTable[i][j][List].ping_id, 0, floor(100 * globalShipTable[i][j][WarpTimer] / WARP_RecoveryTime).."%")
		end
		
		if( globalShipTable[i][j][WarpTimer] >= WARP_RecoveryTime ) then
			
			globalShipTable[i][j][IsAtWarp] = WARP_Status_Idle
			globalShipTable[i][j][WarpTimer] = 0
			
			if( i == FE_GetCurrentPlayerIndex() ) then
				Ping_Remove(globalShipTable[i][j][List].ping_id)
			end


			
		end
		
	end
    end	
end
