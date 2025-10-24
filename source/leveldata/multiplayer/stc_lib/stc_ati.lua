----------------------------------------------------------------------------------------------------
-- ATI
----------------------------------------------------------------------------------------------------

ati_ItemTable = {}

function ati_Init()
	-- load ATI templates
	ATI_LoadTemplates("data:LevelData\\Multiplayer\\stc_lib\\ATI.lua")
	
end

function ati_AddValue(tPrefix, fValue)
	if(HitCounter_F == 2) then
		tinsert(ati_ItemTable, tPrefix.." = "..round(fValue))
	end
end

function ati_AddVector(tPrefix, tVec)
	if(HitCounter_F == 2) then
		sTemp = tPrefix.." = ( "
		for i, tTab in tVec do
			sTemp = sTemp..round(tTab)..", "
		end
		tinsert(ati_ItemTable, sTemp..")")
	end
end

function atiRule()
	if(HitCounter_F == 2) then
		ATI_Clear()
		
		for i = 1, getn(ati_ItemTable) do
			ATI_CreateParameters(1)
			ATI_AddString(0, ati_ItemTable[i])
			ATI_Display2D("debugOutput", {-0.48, 0.48 - i*0.02, 1.0, 1.0} , 0)
		end
		
		ati_ItemTable = {}
	end
	
end

