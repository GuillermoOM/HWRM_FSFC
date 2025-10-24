----------------------------------------------------------------------------------------------------
-- CAMERA - shakes the camera when close to explosions
----------------------------------------------------------------------------------------------------
-- How this works: The camera can only be moved by focussing a sobgroup or volume. If we want to
-- simulate a camera shake we'd have to create a sobgroup or volume near the camera's current
-- focal point and force the camera to focus the new sobgroup or volume. By creating several new
-- focal points randomly around the old focal point (with decreasing distance) and zooming on each
-- after a specific time intervall, we could simulate a camera shake.
-- But how can we calculate the focal point of the camera? HW2 only allows us to
--   1) get the distance to a sobgroup
--   2) find out if the camera has rotated
--   3) find out if the camera has panned
--   4) find out if the camera is focused on a sobgroup
--   5) find out if a sobgroup is currently on screen
-- 
-- The plan is to calculate the camera position, determine the camera direction and from this
-- calculate the focal point by multipying the camera direction with the zoom distance (distance 
-- between camera position and focal point) and adding this vector to the camera position:
-- 
--                    Focal_Point = Camera_Position + Zoom * Direction
-- 
-- The camera position can be calculated by Trilateration (see Camera_CalculateCameraPosition()).
-- 
-- The camera direction can be determined by checking which sobgroups are currently visible on 
-- screen. By creating evenly distributed refernce points on a large(!) sphere around the world
-- center and checking which are visible and which are not, we can calculate the camera direction: 
-- 
--                     Direction = Mean(visible Sobgroups) - Camera_Position
-- 
-- The change of the zoom distance can be calculated by assuming no vertical camera panning (see 
-- Camera_CalculateFocalPoint()).
-- Total zoom distance:
-- If the camera is focused on a ship, the ship position is the focal point and we can calculate
-- the total zoom distance as the distance between camera position and ship position.
----------------------------------------------------------------------------------------------------
-- Bugs and issues:
--   1) vertical panning WHILE zooming in and out cannot be tracked
--   2) zooms on map objects cannot be tracked
----------------------------------------------------------------------------------------------------

camera_AngleRefCount = 600 -- reference point count for direction determination
camera_AngleRefRadius = 10000000 -- reference sphere radius
camera_TrilatRefOffset = 1000000 -- reference point offset for trilateration

-- creates reference points for camera position and direction calculations
function camera_Init()
	--------------------------------------------------------------------------------------------------
	-- Create Angle Reference Points
	-- 
	-- Evenly distributed points on sphere (http://cgafaq.info/wiki/Evenly_distributed_points_on_sphere)
	-- Access reference points (SobGroups) by
	-- 
	--                   "sob_AngleRef_"..k
	-- 
	-- where k is the reference point index (k = 1..camera_AngleRefCount)
	-- 
	local dlong = PI*(3 - sqrt(5)) -- ~2.39996323 <- Das ist der Goldene Schnitt
	local dz = 2.0/camera_AngleRefCount
	local long = 0
	local z = 1 - dz/2
	local node = {}
	
	-- create camera_AngleRefCount points for reference
	for k = 1, camera_AngleRefCount do
    local r = sqrt(1 - z^2)
    node[k] = {r*cos(RadToDeg(long)), r*sin(RadToDeg(long)), z}
    z = z - dz
    long = long + dlong
		
		Volume_AddSphere("vol_AngleRef_"..k, vmultiply(node[k], camera_AngleRefRadius), 100)
		SobGroup_Create("sob_AngleRef_"..k)
		SobGroup_Clear("sob_AngleRef_"..k)
		SobGroup_SpawnNewShipInSobGroup(-1, "zzz_camera", "sqd_AngleRef_"..k, "sob_AngleRef_"..k, "vol_AngleRef_"..k)
		SobGroup_SetInvulnerability("sob_AngleRef_"..k, 1)
		Volume_Delete("vol_AngleRef_"..k)
	end
	
	--------------------------------------------------------------------------------------------------
	-- Create Trilateration Reference Points
	-- 
	-- Access reference points (SobGroups) by
	-- 
	--                   "sob_TrilatRef_"..k
	-- 
	-- where k is the reference point index (k = 0..3)
	-- 
	
	-- create volumes for reference sobgroups
	Volume_AddSphere("vol_TrilatRef_0", {0, 0, 0}, 100)
	Volume_AddSphere("vol_TrilatRef_1", {camera_TrilatRefOffset, 0, 0}, 100)
	Volume_AddSphere("vol_TrilatRef_2", {0, camera_TrilatRefOffset, 0}, 100)
	Volume_AddSphere("vol_TrilatRef_3", {0, 0, camera_TrilatRefOffset}, 100)
	
	-- create sobgroups
	for k = 0, 3 do
		SobGroup_Create("sob_TrilatRef_"..k)
		SobGroup_Clear("sob_TrilatRef_"..k)
		SobGroup_SpawnNewShipInSobGroup(-1, "zzz_camera", "sqd_TrilatRef_"..k, "sob_TrilatRef_"..k, "vol_TrilatRef_"..k)
		SobGroup_SetInvulnerability("sob_TrilatRef_"..k, 1)
	end
	
	-- delete volumes again
	for k = 0, 3 do
		Volume_Delete("vol_TrilatRef_"..k)
	end
	
end

camera_TrilatDistances = {}
camera_OldPosition = {0,0,0}

camera_Position = {0,0,0}
camera_FocusPos = {0,0,0}
camera_Direction = {0,0,0}
camera_Distance = 10000
camera_DistanceMax = 20000
camera_DistanceMin = 10
camera_LastZoomAmount = 0

camera_ShakeTimer = 0
camera_ShakeDirection = {0,0,1}
camera_ShakeThreshold = 5
camera_ShakeNormFactor = 700

function cameraRule()
	if(HitCounter_F > 0) then
		-- calculate new camera position
		Camera_CalculateCameraPosition()
		
		-- Shake camera?
		if( camera_ShakeTimer > 0 ) then
			-- Only shake the camera if the sensor manager is not up
			if( Sensors_ManagerIsUp() == nil ) then
				camera_ShakeTimer = 0
			else
				
				-- if the camera has moved recalculate focal point
				if( Camera_PlayerHasRotated(1) == 1 or Camera_PlayerHasRotated(-1) == 0 or Camera_PlayerHasPanned(1) == 1 ) then
					Camera_CalculateFocalPoint()
				end
				
				-- move focal point
				-- F = F + (-1)^Timer * Threshold * Timer^2 * Direction
				--         |            |           |
				--         |            |           +-> shake strength scales with T^2
				--         |            +-> determines the strength of the shake
				--         +-> makes the camera move left, right, left, right, ...
				camera_FocusPos = vaddV(camera_FocusPos, vround(vmultiply(camera_ShakeDirection, (-1)^camera_ShakeTimer*camera_ShakeThreshold*camera_ShakeTimer^2)))
				
				-- focus on new (moved) focal point
				Volume_AddSphere("vol_Focus", camera_FocusPos, 100)
				SobGroup_Create("sob_Camera")
				Camera_AltFocusWithVolume("sob_Camera", 0, "vol_Focus")
				Volume_Delete("vol_Focus")
				
				-- decrement Timer
				camera_ShakeTimer = camera_ShakeTimer - 1
			end
			
		else
			-- if not: calculate focal point
			Camera_CalculateFocalPoint()
		end
		
		ati_AddVector("Camera Position (X,Y,Z)", camera_Position)
		ati_AddVector("Focal Point (x,y,z)", camera_FocusPos)
		ati_AddVector("Direction (u,v,w)", vmultiply(camera_Direction, 100))
		ati_AddValue("Distance", camera_Distance)
	end
end

-- function called by a dying ship to initiate camera shake
function Camera_InitiateShake(i, j)
	-- random shake direction (NO Y-DIRECTION!)
	camera_ShakeDirection = vnormalize({RandomRange(-1, 1), 0, RandomRange(-1, 1)})
	-- camera_ShakeDirection = vnormalize( vcross(camera_Direction, {0,1,0}))
	
	-- weightedDistance = |CameraPos - ShipPos| * NormFactor / ShipSize
	local weightedDistance = Camera_GetDistanceToSobGroup(globalShipTable[i][j][SobGroup]) * camera_ShakeNormFactor/shipClassStatsTable[globalShipTable[i][j][ShipClass]][8]
	-- calculate corresponding timer
	local camera_NewShakeTimer = 0
	if(weightedDistance < 1000) then
		camera_NewShakeTimer = 15
	elseif(weightedDistance < 15000) then
		camera_NewShakeTimer = round(1/950*(15000 - weightedDistance))
	end
	-- update timer if necessary
	if(camera_NewShakeTimer > camera_ShakeTimer) then
		camera_ShakeTimer = camera_NewShakeTimer
	end
end

-- calculates camera position (X,Y,Z) from the distances to reference points by trilateration
-- 
-- R_: Distance Camera-SphereCenterPoint = Sphere Radius
-- Sphere around (0,0,0) :  R0^2 = X^2 + Y^2 + Z^2
-- Sphere around (D,0,0) :  R1^2 = (X-D)^2 + Y^2 + Z^2
-- 	                   -->     X = R0^2 - R1^2 + D^2)/(2*D)
function Camera_CalculateCameraPosition()
	-- remember old position
	camera_OldPosition = vround(camera_Position)
	
	-- calcutale new position
	for k = 0, 3 do
		camera_TrilatDistances[k] = Camera_GetDistanceToSobGroup("sob_TrilatRef_"..k)
	end
	for k = 1, 3 do
		camera_Position[k] = round( (camera_TrilatDistances[0]^2 - camera_TrilatDistances[k]^2 + camera_TrilatRefOffset^2)/(2*camera_TrilatRefOffset) )
	end
end

-- calculates camera focal point (x,y,z)
function Camera_CalculateFocalPoint()
	-- loop through all ships and check if any ship is focused
	local camera_FocusedShipTable = {}
	for i = 0, Universe_PlayerCount()-1 do
		if(Player_IsAlive(i) == 1 or i == ALLIANCE_playerSlot) then
			for j = 1, getn(globalShipTable[i]) do
				if(Camera_PlayerHasFocused("Player"..i.."_ship"..j) == 1) then
					tinsert(camera_FocusedShipTable, "Player"..i.."_ship"..j)
				end
			end
		end
	end
	
	-- if at least one ship is focused
	if( getn(camera_FocusedShipTable) > 0 ) then
		-- calculate camera properties
		camera_FocusPos = vround(SobGroup_GetMeanPosition(camera_FocusedShipTable))
		camera_Direction = vsubtractV(camera_FocusPos, camera_Position)
		camera_Distance = vlength(camera_Direction)
		camera_Direction = vnormalize(camera_Direction)
		
	-- if no ship is focused -> manually track focal point
	else
		-- if the camera has zoomed
		if( camera_LastZoomAmount ~= Camera_GetLastZoomAmount() ) then
			-- caclulate new camera zoom distance
			camera_Distance = camera_Distance + (camera_OldPosition[2] - camera_Position[2])/(vdot(camera_Direction, {0, 1, 0}))
			
			-- avoid unnrealistic values
			if( camera_Distance > camera_DistanceMax ) then
				camera_Distance = camera_DistanceMax
			elseif( camera_Distance < camera_DistanceMin ) then
				camera_Distance = camera_DistanceMin
			end
			
		-- if the camera hasn't rotated (Camera_PlayerHasRotated() is a weird function),
		--                      zoomed,
		--                   or panned
		-- elseif( Camera_PlayerHasRotated(1) == 0 and Camera_PlayerHasRotated(-1) == 1 and Camera_PlayerHasPanned(1) == 0 )
			
		end
		-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
		-- ATTENTION: Panning up and down WHILE zooming in and out cannot be tracked! Zooms on map objects, either!
		-- * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
		
		-- calculate camera direction (it's better to do this always)
		-- loop through all angle reference points and check which ones are visible
		local Angle_visibleShipTable = {}
		for k = 1, camera_AngleRefCount do
			if(SobGroup_OnScreen("sob_AngleRef_"..k) == 1) then
				tinsert(Angle_visibleShipTable, "sob_AngleRef_"..k)
			end
		end
		-- calculate mean position of all visible reference points
		Angle_MeanPosition = vround( SobGroup_GetMeanPosition(Angle_visibleShipTable) )
		-- because the reference points where evenly distributed on the sphere we can now calculate the
		-- camera direction
		camera_Direction = vnormalize(vsubtractV(Angle_MeanPosition, camera_Position))
		
		-- now calculate the new focal point
		camera_FocusPos = vround( vaddV(camera_Position, vmultiply(camera_Direction, camera_Distance)) )
	end
	
	-- reset camera functions
	Camera_ResetFocused()
	Camera_ResetPanned()
	Camera_ResetRotated()
	
	camera_LastZoomAmount = Camera_GetLastZoomAmount()
	
	-- create a target grid for the focal point
	Camera_CreateTargetGrid()
end

----------------------------------------------------------------------------------------------------
-- TARGET GRID
----------------------------------------------------------------------------------------------------
Camera_GridSize = 100 -- distance between grid points
Camera_GridPointCount = 10 -- nops on each axis
Camera_GridPointTable = {} -- table to store grid point ping IDs and volume names

-- creates a target grid around the Focal Point of the Camera
function Camera_CreateTargetGrid()
	if(HitCounter_F == 2) then
		-- remove old grid
		Camera_RemoveOldTargetGrid()
		
		-- create center point with description
		Volume_AddSphere("vol_Focus_0_0_0", camera_FocusPos, 100)
		local camera_GridPointPingID = Ping_AddPoint("", "STC_TragetGridPoint", "vol_Focus_0_0_0")
		Ping_AddDescription(camera_GridPointPingID, 0, ".______Target Point")
		tinsert(Camera_GridPointTable, {camera_GridPointPingID, "vol_Focus_0_0_0"})
		
		-- create grid points
		for i = 1, Camera_GridPointCount do
			Camera_CreateGridPoint({ i*Camera_GridSize,                  0,                  0})
			Camera_CreateGridPoint({-i*Camera_GridSize,                  0,                  0})
			Camera_CreateGridPoint({                 0,  i*Camera_GridSize,                  0})
			Camera_CreateGridPoint({                 0, -i*Camera_GridSize,                  0})
			Camera_CreateGridPoint({                 0,                  0,  i*Camera_GridSize})
			Camera_CreateGridPoint({                 0,                  0, -i*Camera_GridSize})
		end
	end
end

-- removes the old target grid
function Camera_RemoveOldTargetGrid()
	-- loop through all grid points
	for i = 1, getn(Camera_GridPointTable) do
		-- remove old ping and delete old volume
		Ping_Remove(Camera_GridPointTable[i][1])
		Volume_Delete(Camera_GridPointTable[i][2])
	end
	-- all grid points were removed --> reset table
	Camera_GridPointTable = {}
end

-- creates a dot at tPos (camera_FocusPos is reference)
function Camera_CreateGridPoint( tPos )
	-- create volume
	Volume_AddSphere("vol_Focus_"..tPos[1].."_"..tPos[2].."_"..tPos[3], vaddV(camera_FocusPos, tPos), 100)
	-- create ping
	local camera_GridPointPingID = Ping_AddPoint("", "STC_TragetGridPoint", "vol_Focus_"..tPos[1].."_"..tPos[2].."_"..tPos[3])
	-- add "." as visible text string (a dot)
	Ping_AddDescription(camera_GridPointPingID, 0, ".")
	-- store ping and volume
	tinsert(Camera_GridPointTable, {camera_GridPointPingID, "vol_Focus_"..tPos[1].."_"..tPos[2].."_"..tPos[3]})
end

