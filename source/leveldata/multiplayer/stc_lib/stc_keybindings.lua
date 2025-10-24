----------------------------------------------------------------------------------------------------
-- KEY BINDINGS
----------------------------------------------------------------------------------------------------

function bindKeyEvents()
	UI_BindKeyEvent(TABKEY, "tabHit")
	UI_BindKeyEvent(F9KEY, "f9Hit")
	-- UI_BindKeyEvent(FKEY, "fHit")
end

HitCounter_tab = 0
function tabHit()
	HitCounter_tab = HitCounter_tab + 1
	if( HitCounter_tab >= 3) then
		HitCounter_tab = 0
	end
	
	displayCloak()
	
end

HitCounter_F9 = 0
function f9Hit()
	HitCounter_F9 = HitCounter_F9 + 1
	if( HitCounter_F9 >= 2) then
		HitCounter_F9 = 0
	end
	
	displayExperience()
	
end

HitCounter_F = 0
function fHit()
	HitCounter_F = HitCounter_F + 1
	if( HitCounter_F >= 3) then
		HitCounter_F = 0
	end
	
	ATI_Clear()
	
end