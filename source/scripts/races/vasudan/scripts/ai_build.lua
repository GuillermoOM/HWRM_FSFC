aitrace("LOADING VASUDAN BUILD INFO")

kCollector = VAS_ISIS
kRefinery  = VAS_ANUKET
kScout = VAS_HORUS
kInterceptor = VAS_SERAPIS
kBomber = VAS_SETH
kCarrier = VAS_TYPHON
kDestroyer = VAS_SOBEK
kResearch = VAS_IMHOTEP
kMissileDestroyer = VAS_ATEN
kBattleCruiser = VAS_HATSHEPSUT
kAWACS = VAS_SETEKH

function DetermineDemandWithNoCounterInfo_Vasudan()
	if (sg_randFavorShipType < 45) then
		ShipDemandAddByClass( eFighter, 1 )
	elseif (sg_randFavorShipType < 75) then
		ShipDemandAddByClass( eCorvette, 1 )
	else
		ShipDemandAddByClass( eFrigate, 1 )
	end
end

function DetermineSpecialDemand_Vasudan()

end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Vasudan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Vasudan
