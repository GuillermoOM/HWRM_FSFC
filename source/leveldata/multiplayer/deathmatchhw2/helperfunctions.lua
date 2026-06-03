----------------------------------------------------------------------------------------------------
-- HELPERFUNCTIONS
----------------------------------------------------------------------------------------------------


----------------------------------------------------------------------------------------------------
-- CONSTANTS
----------------------------------------------------------------------------------------------------
PI = 3.1415926535897932384626433832795


----------------------------------------------------------------------------------------------------
-- SOBGROUPS
----------------------------------------------------------------------------------------------------
function SobGroup_GetMeanPosition(tSobGroupTable)
	local meanPosition = {0, 0, 0}
	for i = 1, getn(tSobGroupTable) do
		meanPosition = vaddV(meanPosition, SobGroup_GetPosition(tSobGroupTable[i]))
	end
	return vdivide(meanPosition, getn(tSobGroupTable))
end


----------------------------------------------------------------------------------------------------
-- MISCELLANEOUS
----------------------------------------------------------------------------------------------------
function DegToRad(tAngle)
	return tAngle/(360)*(2*PI)
end

function RadToDeg(tAngle)
	return tAngle/(2*PI)*(360)
end

-- Rounds a number to the nearest integer.
function round(fVal)
	if(fVal >= 0) then
		return floor(fVal + 0.5)
	else
		return floor(fVal - 0.5)
	end
end

-- Rounds each component of a vector to the nearest integers.
function vround(tVec)
	local tmpVec = {}
	for i, tTab in tVec do
		tmpVec[i] = round(tTab)
	end
	return tmpVec
end


----------------------------------------------------------------------------------------------------
-- VECTORS
----------------------------------------------------------------------------------------------------
-- implemented by Mikail
-- edited by Stargazer

-- returns the normalized form of a vector
function vnormalize(tVec)
	local tmpVal = vlength(tVec)
	local tmpVec = vdivide(tVec, tmpVal)
	return tmpVec
end

-- returns the length of a vector
function vlength(tVec)
	local tmpVal = sqrt(vsum(vpower(tVec, 2)))
	return tmpVal
end

-- returns the distance between two vectors
function vdistance(tVec1, tVec2)
	local tmpVal = vlength(vsubtractV(tVec2, tVec1))
	return tmpVal
end

-- returns the dot product of two vectors
function vdot(tVec1, tVec2)
	local tmpVal = vsum(vmultiplyV(tVec1, tVec2))
	return tmpVal
end

-- returns the angle between two vectors
function vangle(tVec1, tVec2)
	local tmpVal = acos(vdot(vnormalize(tVec1), vnormalize(tVec2)))
	return tmpVal
end

-- returns the cross product of two vectors as a new vector
function vcross(tVec1, tVec2)
	local tmpVec =
	{
		tVec1[2] * tVec2[3] - tVec1[3] * tVec2[2],
		tVec1[3] * tVec2[1] - tVec1[1] * tVec2[3],
		tVec1[1] * tVec2[2] - tVec1[2] * tVec2[1],
	}
	return tmpVec
end

-- adds "fVal" to each vector component, then returns the resulting vector.
function vadd(tVec, fVal)
	local tmpVec = {}
	for i, tTab in tVec do
		tmpVec[i] = tVec[i] + fVal
	end
	return tmpVec
end

-- adds the components of vector 2 to the components of vector 1, then returns the resulting vector.
function vaddV(tVec1, tVec2)
	local tmpVec = {}
	for i, tTab in tVec2 do
		tmpVec[i] = tVec1[i] + tTab
	end
	return tmpVec
end

-- subtracts "fVal" from each vector component, then returns the resulting vector.
function vsubtract(tVec, fVal)
	local tmpVec = {}
	for i, tTab in tVec do
		tmpVec[i] = tVec[i] - fVal
	end
	return tmpVec
end

-- subtracts the components of vector 2 from the components of vector 1, then returns the resulting vector.
function vsubtractV(tVec1, tVec2)
	local tmpVec = {}
	for i, tTab in tVec2 do
		tmpVec[i] = tVec1[i] - tTab -- MODIFIED BY STARGAZER; old one was: tmpVec[i] = tVec1[i] + tTab
	end
	return tmpVec
end

-- multiplies each vector component by "fVal", then returns the resulting vector.
function vmultiply(tVec, fVal)
	local tmpVec = {}
	for i, tTab in tVec do
		tmpVec[i] = tTab * fVal
	end
	return tmpVec
end

-- multiplies the components of vector 1 by the components of vector 2, then returns the resulting vector.
function vmultiplyV(tVec1, tVec2)
	local tmpVec = {}
	for i, tTab in tVec2 do
		tmpVec[i] = tVec1[i] * tTab
	end
	return tmpVec
end

-- divides each vector component by "fVal", then returns the resulting vector.
function vdivide(tVec, fVal)
	local tmpVec = {}
	for i, tTab in tVec do
		tmpVec[i] = tTab / fVal
	end
	return tmpVec
end

-- divides the components of vector 1 by the components of vector 2, then returns the resulting vector.
function vdivideV(tVec1, tVec2)
	local tmpVec = {}
	for i, tTab in tVec2 do
		tmpVec[i] = tVec1[i] / tTab
	end
	return tmpVec
end

-- raises each vector component to the power "fVal", then returns the new vector.
function vpower(tVec, fVal)
	local tmpVec = {}
	for i, tTab in tVec do
		tmpVec[i] = tTab^fVal
	end
	return tmpVec
end

-- raises the components of vector 1 to the power specified using the components vector 2, then returns the new vector.
function vpowerV(tVec1, tVec2)
	local tmpVec = {}
	for i, tTab in tVec2 do
		tmpVec[i] = tVec1[i]^tTab
	end
	return tmpVec
end

-- returns the sum of all vector components
function vsum(tVec1)
	local tmpVal = 0
	for i, tTab in tVec1 do
		tmpVal = tmpVal + tTab
	end
	return tmpVal
end

-- rotates a vector around the origin by the specified Euler angles, then returns the new vector.
-- rotates around the Z-axis first, then the X-axis, then the Y-axis.
function vrotate(tVec, tAng)
	local phi, PosX, PosY, PosZ = 0, tVec[1], tVec[2], tVec[3]
	phi = tAng[3]
	local zPosX = PosX * cos(phi) - PosY * sin(phi)
	local zPosY = PosX * sin(phi) + PosY * cos(phi)
	local zPosZ = PosZ * 1
	phi = tAng[1]
	local xPosX = zPosX * 1
	local xPosY = zPosY * cos(phi) - zPosZ * sin(phi)
	local xPosZ = zPosY * sin(phi) + zPosZ * cos(phi)
	phi = tAng[2]
	local yPosX = xPosX * cos(phi) + xPosZ * sin(phi)
	local yPosY = xPosY * 1
	local yPosZ = xPosX * -1 * sin(phi) + xPosZ * cos(phi)
	local tmpVec = {yPosX, yPosY, yPosZ,}
	return tmpVec
end

-- returns a vector converted into a string
function vstr(tVec)
	local tmpStr = "{"
	for i, tTab in tVec do
		tmpStr = tmpStr .. tTab .. ", "
	end
	tmpStr = tmpStr .. "}\n"
	return tmpStr
end

-- returns an array containing the vector's Euler angles, relative to the Z-axis.
-- to reproduce the original vector, rotate a point on the Z-axis by these angles.
function vanglesXY(tVec2)
	local fSgnX, fSgnY = 1, 1
	local tPrjB1 = vnormalize({tVec2[1], 0, tVec2[3],})
	if (tPrjB1[1] ~= 0) then
		fSgnX = tPrjB1[1] / abs(tPrjB1[1]) * -1
	end
	local fAngY = acos(tPrjB1[3]) * fSgnX
	local tRotB1 = vrotate(tVec2, {0,fAngY,  0,})
	local tPrjB2 = vnormalize(tRotB1)
	if (tPrjB2[2] ~= 0) then
		fSgnY = tPrjB2[2] / abs(tPrjB2[2])
	end
	local fAngX = acos(tPrjB2[3]) * fSgnY
	return {fAngX, fAngY, 0,}
end

-- rotates vector 1 around vector 2 by the specified amount, then returns the new vector.
function vaxis_rotate(tVec1, tVec2, fAngZ)
	local tAng = vanglesXY(tVec2)
	local tRotA1 = vrotate(tVec1, {0, tAng[2], 0,})
	local tRotA2 = vrotate(tRotA1, {tAng[1], 0, 0,})
	local tRotC1 = vrotate(tRotA2, {0, 0, fAngZ,})
	local tRotC2 = vrotate(tRotC1, vmultiply(tAng, -1))
	return tRotC2
end

----------------------------------------------------------------------------------------------------
