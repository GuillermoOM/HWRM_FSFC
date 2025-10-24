----------------------------------------------------------------------------------------------------
-- SHIELD & CLOAK FX ROUTINE
----------------------------------------------------------------------------------------------------

-- Origionally by the STC team. This function has been hijacked to move the shield mesh layer away for ships that lose
-- their shields. Also, in the FS1 era, we should be able to force factions to not get this shit until a research
-- if we want. We're switching to a more brute force method of tracking weather the shields are up via the hardpoint
-- health instead of using the global ship table value for shields because I'm lazy and don't want to make an array
-- for each flight of fighters (since only fighters have shields). I may just be an idiot. 
-- calculate shield
function shieldRule(i, j)
	
	-- we need the ship name quite often
	sob_ship = globalShipTable[i][j][SobGroup]
	SobGroup_Create(shield_ship)
	SobGroup_Create(shield_temp)
	SobGroup_Clear(shield_ship)
	SobGroup_Clear(shield_temp)
	local numships = SobGroup_Count(sob_ship)
	-- SHIELD DEACTIVATION
	-- check: for each craft in the wave, has it lost or regained shields? We are going to have to loop through the different craft in a wave.
	-- So: IS THE SHIELD HARDPOINT AT 0? AND IF SO, DOES THE SHIP EVEN HAVE SHIELDS?
	if globalShipTable[i][j][Shield] == 1 then
		
		if SobGroup_HealthPercentage(shield_ship, "Shield") <= 0 then
			-- deactivate shield!
	  		SobGroup_SetMadState(sob_ship, "HyperspaceGateDeActivate")
			--globalShipTable[i][j][Shield] = 0
		elseif SobGroup_HealthPercentage(shield_ship, "Shield") > 0 then
			-- reactivate shield!
	  		SobGroup_SetMadState(sob_ship, "HyperspaceGateActivate")
			--globalShipTable[i][j][Shield] = 1
		end
	end
	
end

function cloakFXRule(i, j)

	-- we need the ship name quite often
	sob_ship = globalShipTable[i][j][SobGroup]
	
	local IsDoingCloakAbility = SobGroup_IsDoingAbility(sob_ship, AB_Cloak)
	local IsCloaked = SobGroup_IsCloaked(sob_ship)
	
	-- CLOAK ACTIVATION
	if( IsDoingCloakAbility == 1 and IsCloaked == 1 and globalShipTable[i][j][Cloak] ~= 1 ) then
		globalShipTable[i][j][Cloak] = 1
		if( globalShipTable[i][j][CloakTimer] == 0 ) then
			globalShipTable[i][j][ShieldHealth] = SobGroup_HealthPercentage(sob_ship) - ShieldHealthPercentage
			if( globalShipTable[i][j][ShieldHealth] < 0 ) then
				globalShipTable[i][j][ShieldHealth] = 0
			else
				SobGroup_SetHealth(sob_ship, ShieldHealthPercentage)
			end
		end
		globalShipTable[i][j][CloakTimer] = 0
		
		if( cloakDisplayed == 1 ) then
			-- print(">> CLOAK >> | RULE: cloak displayed")
			FX_StopEvent(sob_ship, "cloak_detected")
			FX_StartEvent(sob_ship, "cloak")
			FX_PlayEffect("shield_cloak_restored_flash", sob_ship, 1)
		end
		soundposition = SobGroup_GetPosition(sob_ship)
		if( globalShipTable[i][j][Race] == "kng") then
			Sound_SFXPlay3DPos("data:sound/sfx/etg/special/"..globalShipTable[i][j][Race].."_cloak_on", soundposition)
		else
			Sound_SFXPlay3DPos("data:sound/sfx/etg/special/cloak_on", soundposition)
		end
		
	-- CLOAK DEACTIVATION
	elseif( ( IsDoingCloakAbility == 0 or ( IsCloaked == 0 and ( SobGroup_UnderAttack(sob_ship) == 1 or SobGroup_IsDoingAbility(sob_ship, AB_Attack) == 1 ) ) ) and globalShipTable[i][j][Cloak] == 1 ) then
		globalShipTable[i][j][Cloak] = 2
		globalShipTable[i][j][CloakTimer] = cloakTimerTable[globalShipTable[i][j][Race]]
		
		if( cloakDisplayed == 1 ) then
			-- print(">> CLOAK >> | RULE: cloak detected displayed")
			FX_StopEvent(sob_ship, "cloak")
			FX_StartEvent(sob_ship, "cloak_detected")
			FX_PlayEffect("shield_cloak_detected_flash", sob_ship, 1)
		end
		soundposition = SobGroup_GetPosition(sob_ship)
		if( globalShipTable[i][j][Race] == "kng") then
			Sound_SFXPlay3DPos("data:sound/sfx/etg/special/"..globalShipTable[i][j][Race].."_cloak_off", soundposition)
		else
			Sound_SFXPlay3DPos("data:sound/sfx/etg/special/cloak_off", soundposition)
		end

	-- SHIELD REACTIVATION
	elseif( globalShipTable[i][j][CloakTimer] == 0 and globalShipTable[i][j][Cloak] == 2) then
		if( SobGroup_HealthPercentage(sob_ship) > 0) then
			local newHealth = SobGroup_HealthPercentage(sob_ship) + globalShipTable[i][j][ShieldHealth]
			if( newHealth > 1) then
				SobGroup_SetHealth(sob_ship, 1)
			else
				SobGroup_SetHealth(sob_ship, newHealth)
			end
		end
		globalShipTable[i][j][CloakTimer] = 0
		globalShipTable[i][j][ShieldHealth] = 0
		globalShipTable[i][j][Cloak] = 0
		
		if( cloakDisplayed == 1 ) then
			FX_StopEvent(sob_ship, "cloak_detected")
		end

	-- SHIELD REACTIVATION TIMER
	elseif( globalShipTable[i][j][CloakTimer] > 0 ) then
		globalShipTable[i][j][CloakTimer] = globalShipTable[i][j][CloakTimer] - 1
		
	-- CLOAK ACTIVATION TIMER
	-- elseif( globalShipTable[i][j][CloakTimer] < 0 ) then
		-- globalShipTable[i][j][CloakTimer] = globalShipTable[i][j][CloakTimer] + 1
		
	end
	

	-- HULL HEALTH KEEPER
	if( globalShipTable[i][j][Cloak] >= 1 or globalShipTable[i][j][CloakTimer] > 0 ) then
		if( SobGroup_HealthPercentage(sob_ship) > ShieldHealthPercentage) then
			SobGroup_SetHealth(sob_ship, ShieldHealthPercentage )
		end
	end
	
	
end

----------------------------------------------------------------------------------------------------
cloakDisplayed = 1

function displayCloak()
	
	if( (HitCounter_tab == 0 or HitCounter_tab == 1) and cloakDisplayed == 0 ) then
		cloakDisplayed = 1
		for i = 0, Universe_PlayerCount()-1 do
			if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
				for j = 1, getn(globalShipTable[i]) do
					if( globalShipTable[i][j][Cloak] == 1 and globalShipTable[i][j][CloakTimer] == 0 ) then
						-- print(">> CLOAK >> | cloak displayed")
						FX_StopEvent(globalShipTable[i][j][SobGroup], "cloak_detected")
						FX_StartEvent(globalShipTable[i][j][SobGroup], "cloak")
					elseif( globalShipTable[i][j][Cloak] == 2 and globalShipTable[i][j][CloakTimer] > 0 ) then
						-- print(">> CLOAK >> | cloak detected displayed")
						FX_StopEvent(globalShipTable[i][j][SobGroup], "cloak")
						FX_StartEvent(globalShipTable[i][j][SobGroup], "cloak_detected")
					end
				end
			end
		end
		
	elseif( HitCounter_tab == 2 and cloakDisplayed == 1 ) then
		cloakDisplayed = 0
		-- print(">> CLOAK >> | cloak un-displayed")
		for i = 0, Universe_PlayerCount()-1 do
			if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
				for j = 1, getn(globalShipTable[i]) do
					FX_StopEvent(globalShipTable[i][j][SobGroup], "cloak")
					FX_StopEvent(globalShipTable[i][j][SobGroup], "cloak_detected")
				end
			end
		end
		
	end
end


----------------------------------------------------------------------------------------------------
-- ONLY FX FUNCTIONS FOR SAFE DEATHMATCH
----------------------------------------------------------------------------------------------------

function shieldRule_onlyFX(i, j)
	
	-- we need the ship name quite often
	sob_ship = globalShipTable[i][j][SobGroup]
	
	-- do some cloaking stuff
	-- DO THIS BEFORE SHIELD ACTIVATION AND DEACTIVATION!
	cloakFXRule_onlyFX(i, j)

	
	-- SHIELD DEACTIVATION
	-- check:
	-- 1. Health < ShieldHealthPercentage
	-- 2. Shields were online
	if( SobGroup_HealthPercentage(sob_ship) <= ShieldHealthPercentage and globalShipTable[i][j][Shield] == 1) then
		-- deactivate shield!
	  SobGroup_SetMadState(sob_ship, "HyperspaceGateDeActivate")
		globalShipTable[i][j][Shield] = 0
		
	-- SHIELD ACTIVATION
	-- check:
	-- 1. Health > ShieldHealthPercentage
	-- 2. Shields were offline
	elseif( SobGroup_HealthPercentage(sob_ship) > ShieldHealthPercentage and globalShipTable[i][j][Shield] == 0) then
		-- reactivate shield!
	  SobGroup_SetMadState(sob_ship, "HyperspaceGateActivate")
		globalShipTable[i][j][Shield] = 1
		
	end
	
end

function cloakFXRule_onlyFX(i, j)

	-- we need the ship name quite often
	sob_ship = globalShipTable[i][j][SobGroup]
	
	local IsDoingCloakAbility = SobGroup_IsDoingAbility(sob_ship, AB_Cloak)
	local IsCloaked = SobGroup_IsCloaked(sob_ship)
	
	-- CLOAK ACTIVATION
	if( IsDoingCloakAbility == 1 and IsCloaked == 1 and globalShipTable[i][j][Cloak] ~= 1 ) then
		globalShipTable[i][j][Cloak] = 1
		if( globalShipTable[i][j][CloakTimer] == 0 ) then
			globalShipTable[i][j][ShieldHealth] = SobGroup_HealthPercentage(sob_ship) - ShieldHealthPercentage
			if( globalShipTable[i][j][ShieldHealth] < 0 ) then
				globalShipTable[i][j][ShieldHealth] = 0
			end
		end
		globalShipTable[i][j][CloakTimer] = 0
		
		if( cloakDisplayed == 1 ) then
			-- print(">> CLOAK >> | RULE: cloak displayed")
			FX_StopEvent(sob_ship, "cloak_detected")
			FX_StartEvent(sob_ship, "cloak")
			FX_PlayEffect("shield_cloak_restored_flash", sob_ship, 1)
		end
		soundposition = SobGroup_GetPosition(sob_ship)
		if( globalShipTable[i][j][Race] == "kng") then
			Sound_SFXPlay3DPos("data:sound/sfx/etg/special/"..globalShipTable[i][j][Race].."_cloak_on", soundposition)
		else
			Sound_SFXPlay3DPos("data:sound/sfx/etg/special/cloak_on", soundposition)
		end
		
	-- CLOAK DEACTIVATION
	elseif( ( IsDoingCloakAbility == 0 or ( IsCloaked == 0 and ( SobGroup_UnderAttack(sob_ship) == 1 or SobGroup_IsDoingAbility(sob_ship, AB_Attack) == 1 ) ) ) and globalShipTable[i][j][Cloak] == 1 ) then
		globalShipTable[i][j][Cloak] = 2
		globalShipTable[i][j][CloakTimer] = cloakTimerTable[globalShipTable[i][j][Race]]
		
		if( cloakDisplayed == 1 ) then
			-- print(">> CLOAK >> | RULE: cloak detected displayed")
			FX_StopEvent(sob_ship, "cloak")
			FX_StartEvent(sob_ship, "cloak_detected")
			FX_PlayEffect("shield_cloak_detected_flash", sob_ship, 1)
		end
		soundposition = SobGroup_GetPosition(sob_ship)
		if( globalShipTable[i][j][Race] == "kng") then
			Sound_SFXPlay3DPos("data:sound/sfx/etg/special/"..globalShipTable[i][j][Race].."_cloak_off", soundposition)
		else
			Sound_SFXPlay3DPos("data:sound/sfx/etg/special/cloak_off", soundposition)
		end

	-- SHIELD REACTIVATION
	elseif( globalShipTable[i][j][CloakTimer] == 0 and globalShipTable[i][j][Cloak] == 2) then
		globalShipTable[i][j][CloakTimer] = 0
		globalShipTable[i][j][ShieldHealth] = 0
		globalShipTable[i][j][Cloak] = 0
		
		if( cloakDisplayed == 1 ) then
			FX_StopEvent(sob_ship, "cloak_detected")
		end

	-- SHIELD REACTIVATION TIMER
	elseif( globalShipTable[i][j][CloakTimer] > 0 ) then
		globalShipTable[i][j][CloakTimer] = globalShipTable[i][j][CloakTimer] - 1
		
	-- CLOAK ACTIVATION TIMER
	-- elseif( globalShipTable[i][j][CloakTimer] < 0 ) then
		-- globalShipTable[i][j][CloakTimer] = globalShipTable[i][j][CloakTimer] + 1
		
	end
	
end