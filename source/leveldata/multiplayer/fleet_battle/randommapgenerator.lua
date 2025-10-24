dustCloudColourTable = {(random()), (random()), (random()), 1.0}
--This file is designed to vomit out a non-random map so we don't have to rely on those all the time. 
function STC_DetermChunk()
	
	------------------------------------------------------------------------------------------------
	-- global map settings
	-- average number of clusters
	cluster_count = sqrt(map_size*1.15)/20
	-- average number of asteroid per cluster
	cluster_asteroidcount = 1.5
	-- average minimum number of pebbles per cluster
	cluster_pebblecount = 3
	-- cluster radius
	cluster_radius = 1000
	-- average number of children per point
	cluster_children = 0.96
	-- minimum allowed RU asteroid distance
	asteroid_distance_min = 500
	-- minimum allowed cargo distance
	cargo_distance_min = 250


	
	------------------------------------------------------------------------------------------------
	-- add starting points
	StartPos = {}
	for i = 0, maxPlayers-1 do
		-- calculate symetric positions with a pinch of randomness
		local x = {}
		x[1] = 0.6*map_size*cos(i*360/maxPlayers) + 0.15*map_size*rand()
		x[2] = 0.6*map_size*sin(i*360/maxPlayers) + 0.15*map_size*rand()
		x[3] = 0.2*map_size*rand()
		-- add starting point
		addPoint("StartPos"..i, {x[1], x[3], x[2]}, {0, -i*360/maxPlayers-90, 0})
		StartPos[i] = x
		local startrot = -i*360/maxPlayers-90
		print("addPoint('StartPos"..i.."', {"..x[1]..", "..x[3]..", "..x[2].."}, {0, "..(-i*360/maxPlayers-90)..", 0})")
		-- add starting point RU asteroid
		-- We want to make this fair. At the beginning everyone should have an RU source close to his/her starting point
		local pos = vaddV(x, vmultiply(vnormalize(rand3()), 5000))
		local asteroid_count = 2
		local pebble_count = randPoiss((cluster_pebblecount*(1 + asteroid_count)))
		addAsteroidBlopStartingPoint(pos, asteroid_count, pebble_count, cluster_radius)
	end
	-- add safe dustclouds and nebulas.
	addNebula("Nebula", "M08_NoDamage_Radiation", {0.0, 0.0, 0.0,}, {0, 0, 0, 0,}, 0.0, 0.1)
	addDustCloud("dustcloud", "DustCloud_0", {0.0, 0.0, 0.0,}, {0, 0, 0, 0,}, 0.0, 0.1)
	------------------------------------------------------------------------------------------------
	-- calculate actual number of clusters
	N = randPoiss(cluster_count)
	-- generate cluster positions
	cluster_coord = {}
	local i = 1
	-- draw uniformly in a ball via accept-reject
	while i <= N do
		-- candidate point
		local x = vmultiply(rand3(), map_size)
		-- if inside ball and y coordinate is not too extrem
		if vlength(x) < 0.9*map_size and abs(x[3]) < 0.5*map_size then
			-- add cluster coordinate
			cluster_coord[i] = x
			i = i + 1
		end
	end
	
	------------------------------------------------------------------------------------------------
	-- add resource blop at every cluster position
	for i = 1, N do
		local asteroid_count = randPoiss(cluster_asteroidcount)
		local pebble_count = randPoiss((cluster_pebblecount*(1 + asteroid_count)))
		-- addAsteroidBlop(vPos, iAsteroids, iPebbles, fRadius)
		addAsteroidBlop(cluster_coord[i], asteroid_count, pebble_count, cluster_radius)
	end
	
	
	------------------------------------------------------------------------------------------------
	-- generate trees evolving from cluster centres
	
	-- initialise the points
	-- N = floor(N*random())
	-- coordinates
	X = cluster_coord
	-- directions, make all cluster centres close to the center point to the center, all else can be random
	Dir = copyTable(X)
	for i = 1, N do
		if vlength(Dir[i]) > 0.5*map_size then
			Dir[i] = rand3()
		end
	end
	-- Dir = {}
	-- for i = 1, N do
		-- Dir[i] = rand3()
	-- end
	-- Dir2 = copyTable(Dir)
	-- normalize directions
	for i = 1, N do
		Dir[i] = vnormalize(Dir[i])
		-- Dir[i + N] = vmultiply(vnormalize(Dir2[i]), -1)
	end
	-- for i = 1, N do
		-- X[i + N] = X[i]
	-- end
	-- N = 2*N
	
	-- total number of points generated
	total_so_far = N
	i = 1
	while i <= total_so_far do
		-- select next point
		nextX = X[i]
		nextDir = Dir[i]
		-- number of children
		children_count = randPoiss(cluster_children)
		
		-- for all children
		for k = 1, children_count do
			total_so_far = total_so_far + 1
			-- get new position
			NewX = vaddV(nextX, vmultiply(nextDir, 5000))
			X[total_so_far] = NewX
			-- get new direction + randomness
			Dir[total_so_far] = vaddV(nextDir, vmultiply({rand(), rand(), rand(),}, 0.3))
			Dir[total_so_far] = vnormalize(Dir[total_so_far])
			
			-- add some randomness to the exact position
			NewX = vaddV(NewX, vmultiply({rand(), rand(), rand(),}, 2000))
			
			-- create dustcloud
			if random() < 0.15 then
				addDustCloud("dustcloud", "DustCloud_NoRes_NoCharge", {NewX[1], NewX[3], NewX[2]}, vmultiplyV(dustCloudColourTable, {1.00, 1.00, 1.00, 0.5*(1 + 0.5*rand())}), 0.0, 3500*(1+0.75*random()))
				print("addDustCloud('dustcloud', 'DustCloud_NoRes_NoCharge', {"..NewX[1]..", "..NewX[3]..", "..NewX[2].."}, {1, 1, 1, 1}, 0, "..(3500*(1+0.75*random()))..")")
			end
			
			-- add chance for a pebble
			if random() < 0.15 then
				addPebble("pebble_"..random(0, 2), {NewX[1], NewX[3], NewX[2]}, 0, 0, 0)
				print("addPebble('pebble_"..random(0,2).."', {"..NewX[1]..", "..NewX[3]..", "..NewX[2].."}, 0, 0, 0)")
			end
			
			-- add chance for another RU blop
			if random() < 0.015 and vlength(NewX) < map_size then
				local asteroid_count = random(1, 2)
				local pebble_count = randPoiss((cluster_pebblecount*(1 + asteroid_count)))
				addAsteroidBlop(NewX, asteroid_count, pebble_count, cluster_radius)
			end
			
			
			-----------------------------------------------------------------------------------
			-- update point list
			if i <= N then
				nextDir = vmultiply(nextDir, -1)
				total_so_far = total_so_far + 1
				-- get new position
				NewX = vaddV(nextX, vmultiply(nextDir, 5000))
				X[total_so_far] = NewX
				-- get new direction + randomness
				Dir[total_so_far] = vaddV(nextDir, vmultiply({rand(), rand(), rand(),}, 0.3))
				Dir[total_so_far] = vnormalize(Dir[total_so_far])
				
				-- add some randomness to the exact position
				NewX = vaddV(NewX, vmultiply({rand(), rand(), rand(),}, 2000))
				
				-- create dustcloud
				if random() < 0.15 then
					addDustCloud("dustcloud", "DustCloud_NoRes_NoCharge", {NewX[1], NewX[3], NewX[2]}, vmultiplyV(dustCloudColourTable, {1.00, 1.00, 1.00, 0.5*(1 + 0.5*rand())}), 0.0, 3500*(1+0.75*random()))
					print("addDustCloud('dustcloud', 'DustCloud_NoRes_NoCharge', {"..NewX[1]..", "..NewX[3]..", "..NewX[2].."}, {1, 1, 1, 1}, 0, "..(3500*(1+0.75*random()))..")")
				end
				
				-- add chance for a pebble
				if random() < 0.15 then
					addPebble("pebble_"..random(0, 2), {NewX[1], NewX[3], NewX[2]}, 0, 0, 0)
					print("addPebble('pebble_"..random(0,2).."', {"..NewX[1]..", "..NewX[3]..", "..NewX[2].."}, 0, 0, 0)")
				end
			end
			
		end
		
		-- stop creating trees if we have created this many children
		if i == 2000 then
			cluster_children = 0
		end
		
		i = i + 1
	end
	
	-- print("i = "..i)
	
	-- add chance for some dangerous nebula and/or an Arcadia installation.
	-- place them between player star positions to avoid any starting point contamination
	arc = 0
	for i = 0, maxPlayers-1 do
		if random() < 0.5 then
			-- if i reached maxplay value the next player is the first player
			if i == maxPlayers-1 then
				j = 0
			else
				j = i+1
			end
			-- radius of the nebula formation
			radius = 0.2*vdistance(StartPos[i], StartPos[j])
			-- positon of the nebula formation:
			-- > center between player A and B
			-- > position vector randomly multiplied (closer or further away from map centre)
			-- > add random to z coorrdinate
			-- this way we avoid any player start position contamination
			vPos = vaddV(vmultiply(vaddV(StartPos[j], vmultiply(vsubtractV(StartPos[i], StartPos[j]), 0.5)), (1 + 0.5*rand())), {0, 0.25*map_size*rand(), 0})
			-- now add some nebula objects
			for k = 1, floor(radius/5000) do
				-- get random position around centre
				local x = vmultiply(randPoiss3(), radius)
				x = vaddV(vPos, x)

				-- maybe add nebula
				if random() < 0.2 then
					addNebula("Nebula", "m07_foundry_radiation", {x[1], x[3], x[2]}, {1.00, 0.20, 0.10, 1}, 0.0, 0.5*radius*(1+0.75*random()))
					print("addNebula('Nebula', 'm07_foundry_radiation', {"..x[1]..", "..x[3]..", "..x[2].."}, {1.00, 0.20, 0.10, 1}, 0, "..(0.5*radius*(1+0.75*random()))..")")
				end
				-- add some derelicts
				local debrisrace = random(1,3)
				for m = 1, random(1, 20) do
					local y = vmultiply(randPoiss3(), radius)
					y = vaddV(x, y)
					
					if debrisrace == 1 then
						if random() < 0.7 then
							addSalvage("debris_chunk_0"..random(1, 2), {y[1], y[3], y[2]}, 0, 0, 0, 0, 0)
							print("addSalvage('debris_chunk_0"..random(1, 2).."', {"..y[1]..", "..y[3]..", "..y[2].."}, 0, 0, 0, 0, 0)")
						else
							addSalvage("debris_chunk_03", {y[1], y[3], y[2]}, 0, 0, 0, 0, 0)
							print("addSalvage('debris_chunk_0"..random(3, 3).."', {"..y[1]..", "..y[3]..", "..y[2].."}, 0, 0, 0, 0, 0)")
						end
					elseif debrisrace == 2 then
						if random() < 0.7 then
							addSalvage("debris_chunk_0"..random(4, 5), {y[1], y[3], y[2]}, 0, 0, 0, 0, 0)
							print("addSalvage('debris_chunk_0"..random(4, 5).."', {"..y[1]..", "..y[3]..", "..y[2].."}, 0, 0, 0, 0, 0)")
						else
							addSalvage("debris_chunk_06", {y[1], y[3], y[2]}, 0, 0, 0, 0, 0)
							print("addSalvage('debris_chunk_0"..random(6, 6).."', {"..y[1]..", "..y[3]..", "..y[2].."}, 0, 0, 0, 0, 0)")
						end
					else
						if random() < 0.7 then
							addSalvage("debris_chunk_0"..random(7, 8), {y[1], y[3], y[2]}, 0, 0, 0, 0, 0)
							print("addSalvage('debris_chunk_0"..random(7, 8).."', {"..y[1]..", "..y[3]..", "..y[2].."}, 0, 0, 0, 0, 0)")
						else
							addSalvage("debris_chunk_09", {y[1], y[3], y[2]}, 0, 0, 0, 0, 0)
							print("addSalvage('debris_chunk_0"..random(9, 9).."', {"..y[1]..", "..y[3]..", "..y[2].."}, 0, 0, 0, 0, 0)")
						end
					end
				end
			end	
			
		elseif random() < .1 then
			-- if i reached maxplay value the next player is the first player
			if i == maxPlayers-1 then
				j = 0
			else
				j = i+1
			end
			-- radius of the nebula formation
			radius = 0.2*vdistance(StartPos[i], StartPos[j])
			vPos = vaddV(vmultiply(vaddV(StartPos[j], vmultiply(vsubtractV(StartPos[i], StartPos[j]), 0.5)), (1 + 0.5*rand())), {0, 0.25*map_size*rand(), 0})
			
				-- get random position around centre
			local x = vmultiply(randPoiss3(), radius)
			x = vaddV(vPos, x)
			if arc == 0 then
				-- add debris
				if random(0,1) == 0 then
					addSquadron("ter_arcadia", "ter_arcadia", {x[1], x[3], x[2]}, -1, {0, (random(1,360)), 0}, 0, 0)
					print("addSquadron('ter_arcadia', 'ter_arcadia', {"..x[1]..", "..x[3]..", "..x[2].."}, -1 , {0, "..(random(1,360)).." , 0}, 0, 0)")
				else
					addSquadron("vas_typhonwreck", "vas_typhonwreck", {x[1], x[3], x[2]}, -1, {(random(1,360)), (random(1,360)), (random(1,360))}, 0, 0)
					print("addSquadron('vas_typhonwreck', 'vas_typhonwreck', {"..x[1]..", "..x[3]..", "..x[2].."}, -1 , {0, "..(random(1,360)).." , 0}, 0, 0)")
				end
				arc = 1
			end
		
		elseif random() < .5 and mapName == 1 then
			-- if i reached maxplay value the next player is the first player
			if i == maxPlayers-1 then
				j = 0
			else
				j = i+1
			end
			-- radius of the nebula formation
			radius = 0.2*vdistance(StartPos[i], StartPos[j])
			vPos = vaddV(vmultiply(vaddV(StartPos[j], vmultiply(vsubtractV(StartPos[i], StartPos[j]), 0.5)), (1 + 0.5*rand())), {0, 0.25*map_size*rand(), 0})
			-- get random position around centre
			local x = vmultiply(randPoiss3(), radius)
			x = vaddV(vPos, x)
			if arc == 0 then
				-- add knossos
				addSquadron("knossos", "knossos", {x[1], x[3], x[2]}, -1, {0, (random(1,360)), 0}, 0, 0)
				print("addSquadron('knossos', 'knossos', {"..x[1]..", "..x[3]..", "..x[2].."}, -1, {0, "..(random(1,360)).." , 0}, 0, 0)")
				arc = 1
				for k = 0, maxPlayers-1 do -- we need to make a node for every player. it can be linked to other nodes.
					-- add the node
					addSquadron("knossosdummy", "knossosdummy", {x[1], x[3], x[2]}, k, {0, 0, 0}, 0, 0)
					print("addSquadron('knossosdummy', 'knossosdummy', {"..x[1]..", "..x[3]..", "..x[2].."}, "..k..", {0, "..(random(1,360)).." , 0}, 0, 0)")
				end	
			end
		
		end
				
		
		
		
	end
	-- Here we will add subspace nodes.
	--nodez = GetGameSettingAsNumber("subspace")
	for i= 0, ceil(maxPlayers/2) do
		if random() < .65 then
			-- if i reached maxplay value the next player is the first player
			if i == maxPlayers-1 then
				j = 0
			else
				j = i+1
			end
			-- radius of the nebula formation
			radius = 0.4*vdistance(StartPos[i], StartPos[j])
			-- positon of the subspace node:
			-- > center between player A and B
			-- > position vector randomly multiplied (closer or further away from map centre)
			-- > add random to z coorrdinate
			-- this way we avoid any player start position contamination
			vPos = vaddV(vmultiply(vaddV(StartPos[j], vmultiply(vsubtractV(StartPos[i], StartPos[j]), 0.5)), (1 + 0.5*rand())), {0, 0.25*map_size*rand(), 0})
			-- get random position around centre
			local x = vmultiply(randPoiss3(), radius)
			x = vaddV(vPos, x)
			y = random(1,360)
			for k = 0, maxPlayers-1 do -- we need to make a node for every player. the node projects an aura for friendly ships.
				-- add the node
				addSquadron("subspacenode", "subspacenode", {x[1], x[3], x[2]}, k, {0, y, 0}, 0, 0)
				print("addSquadron('subspacenode', 'subspacenode', {"..x[1]..", "..x[3]..", "..x[2].."}, "..k..", {0, "..y.." , 0}, 0, 0)")
			end
		end
	end		
	setWorldBoundsInner({0, 0, 0}, {map_size, map_size, map_size})
	print("setWorldBoundsInner({0, 0, 0}, {"..map_size..", "..map_size..", "..map_size.."})")
end

-- is processed before NonDetermChunk
function STC_NonDetermChunk()
	
	------------------------------------------------------------------------------------------------
	-- add some randomness to map size
	map_size = 15000 + 5000*rand()*maxPlayers + 7000*maxPlayers
	-- the name of the map
	mapName = random(1, 9)	
	fogSetActive(0)
	setGlareIntensity(0.10)
	setLevelShadowColour(0,0,0,1)

	SkyboxTable =	{
		"gammadraconis",
		"altair",
		"betacygni",
		"capella",
		"deltaserpentis",
		"deneb",
		"epsilonpegasi",
		"polaris", 
		"alphacentauri",

	}
	
	print(SkyboxTable[mapName])
	loadBackground(SkyboxTable[mapName]) 

	setSensorsManagerCameraDistances(map_size/10, map_size*1.5)

end

dofilepath("data:leveldata/multiplayer/deathmatch/helperfunctions.lua")

-- returns a random number between -1 and 1
function rand()
	return 2*(random() - 0.5)
end

function rand3()
	return {rand(), rand(), rand()}
end

-- returns a poisson distributed random variable
-- http://en.wikipedia.org/wiki/Poisson_distribution#Generating_Poisson-distributed_random_variables
-- Generating Poisson-distributed random variables
-- Knuth Algorithm
function randPoiss(lambda)
	
	k = 0
	target = exp(-lambda)
	p = 1
	while (p > target) do
		p = p * random()
		k = k + 1
	end
	k = k - 1
	
	return k
end

-- returns a random number poisson distributed around 0.5
function randPoiss3()
	local dir = vnormalize(rand3())
	return vmultiply(dir, 0.05*randPoiss(10))
end

function copyTable(t)
  local t2 = {}
  for k,v in t do
    t2[k] = v
  end
  return t2
end

-- generates a RU asteroid blop at position vPos with iAsteroids Asteroids, iPebbles Pebbles and a radius of fRadius
function addAsteroidBlop(vPos, iAsteroids, iPebbles, fRadius)
	cargo = random(0, 2)
	cargorace = random(1,3)	
	--if SpawnCargoOption() == 0 then 
	--	cargo = 0
	--end
if cargo < 2 then
	-- asteroids
	asteroidtype = random(0, 2)
	local radius = iAsteroids/3*fRadius
	local k = 1
	local y_Table = {} -- stores positions of previously generated asteroids to ensure minimum asteroid distance
	local counter = 0 -- to avoid an endless loop
	
	-- draw uniformly in the ball via accept-reject
	while k <= iAsteroids and counter < 10 do
		-- candidate point
		local y = vmultiply(rand3(), radius)
		-- inside ball?
		if vlength(y) < radius then
			-- check if it closer than the minimum distance to existing asteroids in this cluster
			local goon = 1
			for i = 1, k-1 do
				-- if it is closer: break, get a new candidate
				if vdistance(y_Table[i], y) < asteroid_distance_min then
					goon = 0
					counter = counter + 1
					break
				end
			end
			-- if everything is ok add another asteroid
			if goon == 1 then
				y_Table[k] = y
				local x = vaddV(vPos, y)
				local asteroidnum = 5
				if random() < 0.20 then
					asteroidnum = 5
				else
					asteroidnum = random(3,4)
				end
				--Do we want to add some random rotations for the asteroids? Probably.
				if asteroidtype == 0 then
					addAsteroid("Asteroid_"..asteroidnum, {x[1], x[3], x[2]}, 100, 0, 0, 0, 0)
					print("addAsteroid('Asteroid_"..asteroidnum.."', {"..x[1]..", "..x[3]..", "..x[2].."}, 100, 0, 0, 0, 0)")
				elseif asteroidtype == 1 then
					addAsteroid("Asteroid_"..asteroidnum.."_grey", {x[1], x[3], x[2]}, 100, 0, 0, 0, 0)
					print("addAsteroid('Asteroid_"..asteroidnum.."_grey', {"..x[1]..", "..x[3]..", "..x[2].."}, 100, 0, 0, 0, 0)")
				else
					addAsteroid("Asteroid_"..asteroidnum.."_ice", {x[1], x[3], x[2]}, 100, 0, 0, 0, 0)
					print("addAsteroid('Asteroid_"..asteroidnum.."_ice', {"..x[1]..", "..x[3]..", "..x[2].."}, 100, 0, 0, 0, 0)")
				end
				
				counter = 0
				k = k + 1
			end
		end
	end
	
	-- pebbles
	radius = iPebbles/5*fRadius;
	k = 1;
	-- draw uniformly in the n-ball via accept-reject
	while k <= iPebbles do
		-- candidate point
		local y = vmultiply(randPoiss3(), radius)
		if vlength(y) < radius then
			local x = vaddV(vPos, y)
			
			addPebble("pebble_"..random(0, 2), {x[1], x[3], x[2]}, 0, 0, 0)
			print("addPebble('pebble_"..random(0,2).."', {"..x[1]..", "..x[3]..", "..x[2].."}, 0, 0, 0)")
			k = k + 1
		end
	end
else 
	-- makin' cargo depots.
	local radius = iAsteroids/3*fRadius + 500
	local k = 1
	local y_Table = {} -- stores positions of previously generated asteroids to ensure minimum asteroid distance
	local counter = 0 -- to avoid an endless loop
	local cargocount = iAsteroids*3
	cargocount = cargocount + random(1,5)

	-- draw uniformly in the ball via accept-reject
	while k <= cargocount and counter < 10 do
		-- candidate point
		local y = vmultiply(rand3(), radius)
		-- inside ball?
		if vlength(y) < radius then
			-- check if it closer than the minimum distance to existing asteroids in this cluster
			local goon = 1
			for i = 1, k-1 do
				-- if it is closer: break, get a new candidate
				if vdistance(y_Table[i], y) < cargo_distance_min then
					goon = 0
					counter = counter + 1
					break
				end
			end
			-- if everything is ok add another salvage chunk
			if goon == 1 then
				y_Table[k] = y
				local x = vaddV(vPos, y)
				
				if random() < 0.90 then
					if cargorace == 1 then --these functions ensure that the cargo depots all match race properly.
						addSalvage("Slv_Chunk_Sml0"..random(1, 3), {x[1], x[3], x[2]}, 100, 0, 0, 0, 0)
						print("addSalvage('Slv_Chunk_Sml0"..random(1, 3).."', {"..x[1]..", "..x[3]..", "..x[2].."}, 100, 0, 0, 0, 0)")
					elseif cargorace == 2 then 
						addSalvage("Slv_Chunk_Sml0"..random(4, 5), {x[1], x[3], x[2]}, 100, 0, 0, 0, 0)
						print("addSalvage('Slv_Chunk_Sml0"..random(1, 3).."', {"..x[1]..", "..x[3]..", "..x[2].."}, 100, 0, 0, 0, 0)")
					else
						addSalvage("Slv_Chunk_Sml0"..random(6, 7), {x[1], x[3], x[2]}, 100, 0, 0, 0, 0)
						print("addSalvage('Slv_Chunk_Sml0"..random(1, 3).."', {"..x[1]..", "..x[3]..", "..x[2].."}, 100, 0, 0, 0, 0)")
					end
				else
					if cargorace == 1 then 
						addSalvage("Slv_Chunk_lrg01", {x[1], x[3], x[2]}, 100, 0, 0, 0, 0)
						print("addSalvage('Slv_Chunk_lrg01', {"..x[1]..", "..x[3]..", "..x[2].."}, 100, 0, 0, 0, 0)")
					elseif cargorace == 2 then 
						addSalvage("Slv_Chunk_lrg02", {x[1], x[3], x[2]}, 100, 0, 0, 0, 0)
						print("addSalvage('Slv_Chunk_lrg02', {"..x[1]..", "..x[3]..", "..x[2].."}, 100, 0, 0, 0, 0)")
					else
						addSalvage("Slv_Chunk_lrg03", {x[1], x[3], x[2]}, 100, 0, 0, 0, 0)
						print("addSalvage('Slv_Chunk_lrg03', {"..x[1]..", "..x[3]..", "..x[2].."}, 100, 0, 0, 0, 0)")
					end
				end
				
				counter = 0
				k = k + 1
			end
		end
	end
	-- ACTIVE SENTRY GUNS
	radius = iPebbles/5*fRadius;
	sentryowner = (random(-1, maxPlayers-1)) --this gives ownership of the sentry guns to one of the players ingame.
	k = 1;
	-- draw uniformly in the n-ball via accept-reject
	if sentryowner == -1 then 
		k = iPebbles + 1
	end
	iPebbles = iPebbles
	turretera = random(0,1)
	while k <= iPebbles do
		-- candidate point
		local y = vmultiply(randPoiss3(), radius)
		if vlength(y) < radius then
			local x = vaddV(vPos, y)
			
			if cargorace == 1 then --these functions ensure that the cargo depots all match race properly.
				if turretera == 1 then
					addSquadron("ter_alastor", "ter_alastor", {x[1], x[3], x[2]}, sentryowner , {0, (random(1,360)), 0}, 0, 0)
					print("addSquadron('ter_alastor', 'ter_alastor', {"..x[1]..", "..x[3]..", "..x[2].."}, "..sentryowner.." , {0, "..(random(1,360))..", 0}, 0, 0)")
				else
					addSquadron("ter_cerberus", "ter_cerberus", {x[1], x[3], x[2]}, sentryowner , {0, (random(1,360)), 0}, 0, 0)
					print("addSquadron('ter_alastor', 'ter_alastor', {"..x[1]..", "..x[3]..", "..x[2].."}, "..sentryowner.." , {0, "..(random(1,360))..", 0}, 0, 0)")
				end
			elseif cargorace == 2 then 
				if turretera == 1 then
					addSquadron("vas_edjo", "vas_edjo", {x[1], x[3], x[2]}, sentryowner, {0, (random(1,360)), 0}, 0, 0)
					print("addSquadron('ter_alastor', 'ter_alastor', {"..x[1]..", "..x[3]..", "..x[2].."}, "..sentryowner.." , {0, "..(random(1,360))..", 0}, 0, 0)")
				else
					addSquadron("vas_ankh", "vas_ankh", {x[1], x[3], x[2]}, sentryowner , {0, (random(1,360)), 0}, 0, 0)
					print("addSquadron('ter_alastor', 'ter_alastor', {"..x[1]..", "..x[3]..", "..x[2].."}, "..sentryowner.." , {0, "..(random(1,360))..", 0}, 0, 0)")
				end
			else
				if turretera == 1 then
					addSquadron("shi_belial", "shi_belial", {x[1], x[3], x[2]}, sentryowner , {0, (random(1,360)), 0}, 0, 0)
					print("addSquadron('ter_alastor', 'ter_alastor', {"..x[1]..", "..x[3]..", "..x[2].."}, "..sentryowner.." , {0, "..(random(1,360))..", 0}, 0, 0)")
				else
					addSquadron("shi_trident", "shi_trident", {x[1], x[3], x[2]}, sentryowner , {0, (random(1,360)), 0}, 0, 0)
					print("addSquadron('ter_alastor', 'ter_alastor', {"..x[1]..", "..x[3]..", "..x[2].."}, "..sentryowner.." , {0, "..(random(1,360))..", 0}, 0, 0)")
				end
			end
			
			k = k + 1
		end
	end	

end
end

-- generates a RU asteroid blop at position vPos with iAsteroids Asteroids, iPebbles Pebbles and a radius of fRadius
function addAsteroidBlopStartingPoint(vPos, iAsteroids, iPebbles, fRadius)
	
	-- asteroids
	local radius = iAsteroids/3*fRadius
	local k = 1
	local y_Table = {} -- stores positions of previously generated asteroids to ensure minimum asteroid distance
	local counter = 0 -- to avoid an endless loop
	asteroidtype = random(0, 2)

	-- draw uniformly in the ball via accept-reject
	while k <= iAsteroids and counter < 10 do
		-- candidate point
		local y = vmultiply(rand3(), radius)
		-- inside ball?
		if vlength(y) < radius then
			-- check if it closer than the minimum distance to existing asteroids in this cluster
			local goon = 1
			for i = 1, k-1 do
				-- if it is closer: break, get a new candidate
				if vdistance(y_Table[i], y) < asteroid_distance_min then
					goon = 0
					counter = counter + 1
					break
				end
			end
			-- if everything is ok add another asteroid
			if goon == 1 then
				y_Table[k] = y
				local x = vaddV(vPos, y)
				if asteroidtype == 0 then
					addAsteroid("Asteroid_4", {x[1], x[3], x[2]}, 100, 0, 0, 0, 0)
					print("addAsteroid('Asteroid_4', {"..x[1]..", "..x[3]..", "..x[2].."}, 100, 0, 0, 0, 0)")
				elseif asteroidtype == 1 then
					addAsteroid("Asteroid_4_grey", {x[1], x[3], x[2]}, 100, 0, 0, 0, 0)
					print("addAsteroid('Asteroid_4_grey', {"..x[1]..", "..x[3]..", "..x[2].."}, 100, 0, 0, 0, 0)")
				else
					addAsteroid("Asteroid_4_ice", {x[1], x[3], x[2]}, 100, 0, 0, 0, 0)
					print("addAsteroid('Asteroid_4_ice', {"..x[1]..", "..x[3]..", "..x[2].."}, 100, 0, 0, 0, 0)")
				end
				counter = 0
				k = k + 1
			end
		end
	end
	
	-- pebbles
	radius = iPebbles/5*fRadius;
	k = 1;
	-- draw uniformly in the n-ball via accept-reject
	while k <= iPebbles do
		-- candidate point
		local y = vmultiply(randPoiss3(), radius)
		if vlength(y) < radius then
			local x = vaddV(vPos, y)
			
			addPebble("pebble_"..random(0, 2), {x[1], x[3], x[2]}, 0, 0, 0)
			print("addPebble('pebble_"..random(0,2).."', {"..x[1]..", "..x[3]..", "..x[2].."}, 0, 0, 0)")
			k = k + 1
		end
	end
end

function setDustCloudColour(tVec)
	dustCloudColourTable = tVec
end