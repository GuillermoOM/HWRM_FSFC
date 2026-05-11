aitrace("LOADING SHIVAN BUILD INFO")

kCollector = SHI_AZRAEL
kCollectorFS1 = SHI_AZRAEL
kRefinery = SHI_RAHU
kScout = SHI_SCORPION
kInterceptor = SHI_ASTAROTH
kBomber = SHI_AESHMA
kCarrier = SHI_DEMON
kDestroyer = SHI_MOLOCH
kResearch = SHI_COMMNODE
kMissileDestroyer = SHI_MOLOCH
kBattleCruiser = SHI_RAVANA
kAWACS = SHI_COMMNODE

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