aitrace("LOADING VASUDAN BUILD INFO")

kCollector = VAS_ISIS
kCollectorFS1 = VAS_ISIS
kRefinery  = VAS_ANUKET

-- Era Counterparts
kScoutFS2 = VAS_PTAH
kScoutFS1 = VAS_HORUS
kInterceptorFS2 = VAS_SERAPIS
kInterceptorFS1 = VAS_HORUS
kHeavyFighterFS2 = VAS_TAURET
kHeavyFighterFS1 = VAS_THOTH
kBomberFS2 = VAS_SEHKMET
kBomberFS1 = VAS_SETH
kDestroyerFS2 = VAS_SOBEK
kDestroyerFS1 = VAS_ATEN
kMissileDestroyerFS2 = VAS_ATEN
kMissileDestroyerFS1 = VAS_ATEN
kBattleCruiserFS2 = VAS_HATSHEPSUT
kBattleCruiserFS1 = VAS_TYPHON

function CpuBuild_UpdateRaceVariables()
	kScout = Util_PickBestShip(kScoutFS2, kScoutFS1)
	kInterceptor = Util_PickBestShip(kInterceptorFS2, kInterceptorFS1)
	kBomber = Util_PickBestShip(kBomberFS2, kBomberFS1)
	kDestroyer = Util_PickBestShip(kDestroyerFS2, kDestroyerFS1)
	kMissileDestroyer = Util_PickBestShip(kMissileDestroyerFS2, kMissileDestroyerFS1)
	kBattleCruiser = Util_PickBestShip(kBattleCruiserFS2, kBattleCruiserFS1)
	kCarrier = VAS_TYPHON
	kResearch = VAS_IMHOTEP
	kAWACS = VAS_SETEKH
end



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
