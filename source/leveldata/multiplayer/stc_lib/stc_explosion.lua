----------------------------------------------------------------------------------------------------
-- EXPLOSION ROUTINE
----------------------------------------------------------------------------------------------------

function explosion_Init()
	Volume_AddSphere("vol_temp", {-1000000,-1000000,-1000000}, 100)
	FX_PlayEffect("xplosion_superlarge", "vol_temp", 0)
	FX_PlayEffect("xplosion_large", "vol_temp", 0)
	FX_PlayEffect("xplosion_medium", "vol_temp", 0)
	FX_PlayEffect("xplosion_small", "vol_temp", 0)
	FX_PlayEffect("xplosion_brg_superlarge", "vol_temp", 0)
	FX_PlayEffect("xplosion_brg_large", "vol_temp", 0)
	FX_PlayEffect("xplosion_brg_medium", "vol_temp", 0)
	FX_PlayEffect("xplosion_brg_small", "vol_temp", 0)
	FX_PlayEffect("xplosion_rom_large", "vol_temp", 0)
	Volume_Delete("vol_temp")	
end

-- calculate explosion damage
function explosionRule(i, j)
	
	-- we need the ship name quite often
	sob_ship = globalShipTable[i][j][SobGroup]

	-- Check:
	-- 1. is ship dying?
	if( SobGroup_HealthPercentage(sob_ship) <= 0 and globalShipTable[i][j][DeathTimer] > 0 ) then
		
		
		-- DEATH TIMER UPDATE
		globalShipTable[i][j][DeathTimer] = globalShipTable[i][j][DeathTimer] - 1
		--print(">> EXPLOSION >> | Death Time counter is at "..globalShipTable[i][j][DeathTimer])
		
		-- DEAL EXPLOSION DAMAGE
		if( globalShipTable[i][j][DeathTimer] == explosionEffectsTable[shipClassStatsTable[globalShipTable[i][j][ShipClass]][7]][6]) then
			-- for all damage radii deal the correct damage amount
			for l = 1, getn(shipClassStatsTable[globalShipTable[i][j][ShipClass]][10]) do
				-- calculate damage
				local explosionDamage = shipClassStatsTable[globalShipTable[i][j][ShipClass]][10][l][2]
				for m = 1, l-1 do
					explosionDamage = explosionDamage - shipClassStatsTable[globalShipTable[i][j][ShipClass]][10][m][2]
				end
				-- we have to loop through all players, because the 'SobGroup_DoDamageProximitySobGroup' only
				-- damages ships of a specific player
				for n = 0, Universe_PlayerCount()-1 do
					if(Player_IsAlive(n) == 1 or n == ALLIANCE_playerSlot) then
						-- deal explosion damage
						SobGroup_DoDamageProximitySobGroup(sob_ship, n, explosionDamage, shipClassStatsTable[globalShipTable[i][j][ShipClass]][10][l][1])
					end
				end

			end
		end

		
		-- INITIATE CAMERA SHAKE
		-- if( globalShipTable[i][j][DeathTimer] == explosionEffectsTable[shipClassStatsTable[globalShipTable[i][j][ShipClass]][7]][8] ) then
			-- Camera_InitiateShake(i, j)
		-- end
		
	end


end

----------------------------------------------------------------------------------------------------
-- SHOCKWAVE
----------------------------------------------------------------------------------------------------
shockwaveTable = {}

function explosionShockwaveRule()
	local size = getn(shockwaveTable)
	local i = 1
	while( i <= size ) do
		if( shockwaveTable[i][2] == 0 ) then
			-- remove shockwave object
			SobGroup_SetHealth(shockwaveTable[i][1], 0)
			tremove(shockwaveTable, i)
			i = i - 1
			size = size - 1 -- this doesn't work with a for loop
		else
			-- decrement countdown
			shockwaveTable[i][2] = shockwaveTable[i][2] - 1
		end
		i = i + 1
	end
end

function shockwaveCreate(sob_ship, shockwaveClass)
	-- create shockwave at ship position
	Volume_AddSphere("vol_"..sob_ship, SobGroup_GetPosition(sob_ship), 100)
	SobGroup_Create("sob_Shockwave_"..sob_ship)
	SobGroup_Clear("sob_Shockwave_"..sob_ship)
	SobGroup_SpawnNewShipInSobGroup(-1, "zzz_shockwave_"..shockwaveClass, "sqd_Shockwave", "sob_Shockwave_"..sob_ship, "vol_"..sob_ship)
	tinsert(shockwaveTable, {"sob_Shockwave_"..sob_ship, explosionShockwaveDuration})
	Volume_Delete("vol_"..sob_ship)
	
	-- Scan for enemies:
	-- 1. Clear old SobGroup
	-- 2. Get all ships of all Players
	-- 3. Get all ships within the maximum damage radius --> enemies
	SobGroup_Create("sob_All")
	SobGroup_Clear("sob_All")
	SobGroup_Create("sob_ShockwaveEnemies")
	SobGroup_Clear("sob_ShockwaveEnemies")
	for i = 0, Universe_PlayerCount()-1 do
		if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
			SobGroup_SobGroupAdd("sob_All", "Player_Ships"..i)
		end
	end
	SobGroup_FillProximitySobGroup("sob_ShockwaveEnemies", "sob_All", "sob_Shockwave_"..sob_ship, shockwaveClass)
	
	-- Check:
	-- 1. Are there any enemies within range?
	if(SobGroup_Empty("sob_ShockwaveEnemies") == 0) then
		SobGroup_Attack(0, "sob_Shockwave_"..sob_ship, "sob_ShockwaveEnemies")
	end
	
end


----------------------------------------------------------------------------------------------------
-- ONLY FX FUNCTIONS FOR SAFE DEATHMATCH
----------------------------------------------------------------------------------------------------

function explosionRule_onlyFX(i, j)
	
	-- we need the ship name quite often
	sob_ship = globalShipTable[i][j][SobGroup]

	-- Check:
	-- 1. is ship dying?
	if( SobGroup_HealthPercentage(sob_ship) <= 0 and globalShipTable[i][j][DeathTimer] > 0 ) then
		
		
		-- DEATH TIMER UPDATE
		globalShipTable[i][j][DeathTimer] = globalShipTable[i][j][DeathTimer] - 1
		-- print(">> EXPLOSION >> | Death Time counter is at "..globalShipTable[i][j][DeathTimer])
		
		-- PLAY GFX
		if( globalShipTable[i][j][DeathTimer] == explosionEffectsTable[shipClassStatsTable[globalShipTable[i][j][ShipClass]][7]][3] ) then
			-- scale = FX_scale * Shipsize * Norm
			local scale = explosionEffectsTable[shipClassStatsTable[globalShipTable[i][j][ShipClass]][7]][2] * shipClassStatsTable[globalShipTable[i][j][ShipClass]][8] * explosionNormFactor
			FX_PlayEffect(explosionEffectsTable[shipClassStatsTable[globalShipTable[i][j][ShipClass]][7]][1], sob_ship, scale)
			Sound_SFXPlay3DPos(explosionEffectsTable[shipClassStatsTable[globalShipTable[i][j][ShipClass]][7]][4], SobGroup_GetPosition(sob_ship))
		end
		
		-- PLAY SFX
		if( globalShipTable[i][j][DeathTimer] == explosionEffectsTable[shipClassStatsTable[globalShipTable[i][j][ShipClass]][7]][5] ) then
			Sound_SFXPlay3DPos(explosionEffectsTable[shipClassStatsTable[globalShipTable[i][j][ShipClass]][7]][4], SobGroup_GetPosition(sob_ship))
		end
		
	end

end