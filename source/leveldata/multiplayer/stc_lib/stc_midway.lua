-- We have hacked this to replace subspace nodes with their FS1 equivalent. We only call this if we need to do the replacement.
----------------------------------------------------------------------------------------------------

function midway_replace(i, j)
	-- we need the ship name quite often
	sob_ship = globalShipTable[i][j][SobGroup]
		sob_position = SobGroup_GetPosition(sob_ship)
		Volume_AddSphere("NODE_Volume"..i..j, sob_position, 1000)
	-- are we a subspace node?
	if SobGroup_AreAnyOfTheseTypes(sob_ship, "subspacenode")==1 and SobGroup_AreAnyOfTheseTypes("Player_Ships0", "ter_hecate, ter_orion, shi_demon, shi_ravana, vas_typhon, vas_hatshepsut")==0 then
		-- find the position of it, despawn the origional, and spawn a brand spankin' new one there.

		SobGroup_TakeDamage(sob_ship, 1)
		SobGroup_Create(sob_ship)
		SobGroup_SpawnNewShipInSobGroup(i, "subspacenodefs1", "subspacenodefs1", sob_ship, "NODE_Volume"..i..j)
		
	end
	Volume_Delete("NODE_Volume"..i..j)
end

function gauntlet_delete(i, j)
	-- we need the ship name quite often
	sob_ship = globalShipTable[i][j][SobGroup]
	if SobGroup_AreAnyFromTheseAttackFamilies(sob_ship, "BigCapitalShip")==1 then
		SobGroup_TakeDamage(sob_ship, 1)
	end

end