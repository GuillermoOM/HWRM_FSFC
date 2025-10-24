function ChangeUIForPlayerByRace()

local iPlayer	= 	FE_GetCurrentPlayerIndex()
local iRace 	= 	Player_GetRace(iPlayer)
local sRace	= 	""
			
		if (iRace == 3) then
			sRace = "fed"
		elseif (iRace == 4) then
			sRace = "kng"
		elseif (iRace == 6) then
			sRace = "rom"	
		else
			sRace = "aux"
		end

-- This first list is for customised items in the NewTaskbar.lua
		
		UI_SetElementVisible("NewTaskbar", sRace.."_bg", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_unitstats", 1)
		UI_SetElementVisible("NewTaskbar", sRace.."_btnHide1", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnHide2", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShipNext", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShipPrev", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShipBack", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnSpecial1", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnSpecial2", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShip01", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShip02", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShip03", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShip04", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShip05", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShip06", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShip07", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShip08", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShip09", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShip10", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShip11", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShip12", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShip13", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnShip14", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_maxspeedframe", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_attackdamageframe", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_shieldsframe", 1) 		
		UI_SetElementVisible("NewTaskbar", sRace.."_btnMove", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnAttack", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnAttackMove", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnGuard", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnDock", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnCancelOrders", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnWaypoint", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnResource", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnWarp", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnRetire", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnPing", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnEMP", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnDefenseField", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnCloak", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnPlaceHolder", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnRepair", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnMines", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnRally", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnRallyObject", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnScuttle", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnScuttleConfirm", 1) 
		UI_SetElementVisible("NewTaskbar", sRace.."_btnScuttleCancel", 1) 

end


