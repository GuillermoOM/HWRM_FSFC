aitrace("LOADING TERRAN SUBSYSTEM INFO")

function DoSubSystemDemand_Vasudan()
	-- local FighterDemand = ShipDemandMaxByClass( eCorvette ) + ShipDemandMaxByClass( eFighter )
	-- local CapitalDemand = ShipDemandMaxByClass( eFrigate ) + ShipDemandMaxByClass( eCapital )
	-- SubSystemDemandSet(FIGHTERBAY, FighterDemand )
	-- SubSystemDemandSet(COMMUNICATION, CapitalDemand )
	-- SubSystemDemandSet(NAVIGATION, 10 )
end

CpuBuildSS_DefaultSubSystemDemandRules = DoSubSystemDemand_Vasudan
