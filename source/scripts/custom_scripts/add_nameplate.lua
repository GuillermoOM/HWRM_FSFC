-- Adding Nameplates to Orion and Hecate

FS2OrionNameplateTable =
{
	"ter_orion_nameplate_bastion",
	"ter_orion_nameplate_carthage",
	"ter_orion_nameplate_delacroix",
	"ter_orion_nameplate_intrepid",
	"ter_orion_nameplate_messana",
	"ter_orion_nameplate_minnow",
	"ter_orion_nameplate_nereid",
	"ter_orion_nameplate_soyakaze",
}

REST = {
	"ter_orion_nameplate_galatea",
	"ter_orion_nameplate_myrmidon",
	"ter_orion_nameplate_amadeus",
	"ter_orion_nameplate_eisenhower",
	"ter_orion_nameplate_goliath",
}

HecateNameplateTable =
{
	"ter_hecate_nameplate_aquitaine",
	"ter_hecate_nameplate_hood",
	"ter_hecate_nameplate_meridian",
	"ter_hecate_nameplate_morgain",
	"ter_hecate_nameplate_phonecia",
	"ter_hecate_nameplate_requiem",
	"ter_hecate_nameplate_tempest",
	"ter_hecate_nameplate_warlock",
}

function onLoad()
end

function onCreate(group, player_index, ship_id)
end

function updateNameplate(group, player_index, ship_id)
	if (Player_GetRace(player_index) ~= 10) then
		return nil;
	end
	
	if SobGroup_GetHardPointHealth(group, "Nameplate") == 0 then
		if SobGroup_AreAnyOfTheseTypes(group, "ter_orion") == 1 then
			print("Adding nameplate to ter_orion ship in group " .. group)
			local nameplate = FS2OrionNameplateTable
				[mod(Player_NumberOfAwakeShips(player_index), getn(FS2OrionNameplateTable))]
			print("Nameplate Chosen: " .. nameplate)
			SobGroup_CreateSubSystem(group, nameplate)
		end
		if SobGroup_AreAnyOfTheseTypes(group, "ter_hecate") == 1 then
			print("Adding nameplate to ter_hecate ship in group " .. group)
			local nameplate = HecateNameplateTable
				[mod(Player_NumberOfAwakeShips(player_index), getn(HecateNameplateTable))]
			print("Nameplate Chosen: " .. nameplate)
			SobGroup_CreateSubSystem(group, nameplate)
		end
	end
end

-- function updateNameplate(CustomGroup, playerIndex, shipID)
-- 	local global_orion = "global_orion_" .. playerIndex
-- 	local global_hecate = "global_hecate_" .. playerIndex
-- 	SobGroup_CreateIfNotExist(global_orion)
-- 	Player_FillShipsByType(global_orion, playerIndex, "Ter_orion")
-- 	SobGroup_CreateIfNotExist(global_hecate)
-- 	Player_FillShipsByType(global_hecate, playerIndex, "Ter_hecate")

-- 	local created_group = CustomGroup .. "_" .. shipID
-- 	SobGroup_CreateIfNotExist(created_group)

-- 	if SobGroup_Count(created_group) == 0 then
-- 		print("Created new Group: " .. created_group)
-- 		if created_group == ("orion" .. "_" .. shipID) then
-- 			SobGroup_FillShipsByIndexRange(created_group, global_orion, SobGroup_Count(global_orion) - 1, 1)
-- 			print("Added Ter_orion to group, ships in group: " .. SobGroup_Count(created_group))
-- 		end
-- 		if created_group == ("hecate" .. "_" .. shipID) then
-- 			print("Added Ter_hecate to group, ships in group: " .. SobGroup_Count(created_group))
-- 			SobGroup_FillShipsByIndexRange(created_group, global_hecate, SobGroup_Count(global_hecate) - 1, 1)
-- 		end
-- 	else
-- 		if SobGroup_GetHardPointHealth(created_group, "Nameplate") == 0 then
-- 			if SobGroup_AreAnyOfTheseTypes(created_group, "ter_orion") == 1 then
-- 				print("Adding nameplate to ter_orion ship in group " .. created_group)
-- 				local nameplate = FS2OrionNameplateTable
-- 					[mod(Player_NumberOfAwakeShips(playerIndex), getn(FS2OrionNameplateTable))]
-- 				print("Nameplate Chosen: " .. nameplate)
-- 				SobGroup_CreateSubSystem(created_group, nameplate)
-- 			end
-- 			if SobGroup_AreAnyOfTheseTypes(created_group, "ter_hecate") == 1 then
-- 				print("Adding nameplate to ter_hecate ship in group " .. created_group)
-- 				local nameplate = HecateNameplateTable
-- 					[mod(Player_NumberOfAwakeShips(playerIndex), getn(HecateNameplateTable))]
-- 				print("Nameplate Chosen: " .. nameplate)
-- 				SobGroup_CreateSubSystem(created_group, nameplate)
-- 			end
-- 		end
-- 	end
-- end

function onDestroy(group, player_index, ship_id)
end
