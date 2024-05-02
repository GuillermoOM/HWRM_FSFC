dofilepath("data:scripts/custom_scripts/interceptor.lua")

function updatePDS(CustomGroup, playerID, shipID)
	--Here we check to see what class of ship the player's working with, and that they've researched the appropriate upgrade.
    if SobGroup_AreAnyFromTheseAttackFamilies(CustomGroup, "SmallCapitalShip, BigCapitalShip, Mothership")==1 and Player_HasResearch(playerID, "CapitalPDS")==1 then
	--oh and if we broke weapons this doesn't work
  	if SobGroup_GetROE(CustomGroup) == 1 and (SobGroup_GetHardPointHealth(CustomGroup, "Weapons") > 0) then
		updateDefenseFighterAttack(CustomGroup, playerID, shipID)
    	end
    elseif SobGroup_AreAnyFromTheseAttackFamilies(CustomGroup, "Frigate, Capturer")==1 and Player_HasResearch(playerID, "CruiserPDS")==1 then
    	if SobGroup_GetROE(CustomGroup) == 1 then
		updateDefenseFighterAttack(CustomGroup, playerID, shipID)
    	end
   end
end



