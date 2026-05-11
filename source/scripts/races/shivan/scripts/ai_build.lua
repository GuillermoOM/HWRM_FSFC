aitrace("LOADING SHIVAN BUILD INFO")

kCollector = SHI_AZRAEL
kCollectorFS1 = SHI_AZRAEL
kRefinery = SHI_RAHU

-- Era Counterparts
kScoutFS2 = SHI_SCORPION
kScoutFS1 = SHI_SCORPION
kInterceptorFS2 = SHI_ASTAROTH
kInterceptorFS1 = SHI_SCORPION
kHeavyFighterFS2 = SHI_MARA
kHeavyFighterFS1 = SHI_SCORPION
kBomberFS2 = SHI_NAHEMA
kBomberFS1 = SHI_SHAITAN
kDestroyerFS2 = SHI_MOLOCH
kDestroyerFS1 = SHI_DEMON
kMissileDestroyerFS2 = SHI_MOLOCH
kMissileDestroyerFS1 = SHI_DEMON
kBattleCruiserFS2 = SHI_RAVANA
kBattleCruiserFS1 = SHI_LUCIFER

function CpuBuild_UpdateRaceVariables()
	kScout = Util_PickBestShip(kScoutFS2, kScoutFS1)
	kInterceptor = Util_PickBestShip(kInterceptorFS2, kInterceptorFS1)
	kBomber = Util_PickBestShip(kBomberFS2, kBomberFS1)
	kDestroyer = Util_PickBestShip(kDestroyerFS2, kDestroyerFS1)
	kMissileDestroyer = Util_PickBestShip(kMissileDestroyerFS2, kMissileDestroyerFS1)
	kBattleCruiser = Util_PickBestShip(kBattleCruiserFS2, kBattleCruiserFS1)
	kCarrier = SHI_DEMON
	kResearch = SHI_COMMNODE
	kAWACS = SHI_COMMNODE
end



function DetermineDemandWithNoCounterInfo_Shivan()
	if (sg_randFavorShipType < 35) then
		ShipDemandAddByClass( eFighter, 1 )
	elseif (sg_randFavorShipType < 65) then
		ShipDemandAddByClass( eCorvette, 1 )
	else
		ShipDemandAddByClass( eFrigate, 1 )
	end
end

function DetermineSpecialDemand_Shivan()

end

Proc_DetermineDemandWithNoCounterInfo = DetermineDemandWithNoCounterInfo_Shivan
Proc_DetermineSpecialDemand = DetermineSpecialDemand_Shivan