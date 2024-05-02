--This function has two purposes: Primarily, it displays the trails while ships are in nebula. duh.
--Two, it exists to correct if strike craft got stuck on afterburner speed or on the burn animation.
function AfterburnerFix(CustomGroup, playerID, shipID)
	SobGroup_SetMaxSpeedMultiplier(CustomGroup, 1)
	-- if (SobGroup_AreAnySquadronsInsideDustCloud(CustomGroup, "dustcloud") == 1) or (SobGroup_AreAnySquadronsInsideNebula(CustomGroup, "Nebula") == 1) then
	-- 	FX_StartEvent(CustomGroup, "Trail")
	-- else
	FX_StopEvent(CustomGroup, "Trail")
	-- end
end
