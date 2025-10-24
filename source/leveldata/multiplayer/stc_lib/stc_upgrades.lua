-- This hodge podge of functions was created to enable, fix, or otherwise do things that seemingly aren't possible anywhere else.
-- we do the upgrade thing for ship j of player i

--The idea here is that this table is global. We strip names from the table, until there are none left. Then we just have the ship be GTD Orion.
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
FS1OrionNameplateTable = 
{
	"ter_orion_nameplate_bastion",
	"ter_orion_nameplate_galatea",
	"ter_orion_nameplate_myrmidon",
	"ter_orion_nameplate_intrepid",
	"ter_orion_nameplate_amadeus",
	"ter_orion_nameplate_eisenhower",
	"ter_orion_nameplate_goliath",
	"ter_orion_nameplate_soyakaze",
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
NTFOrionNameplateTable = 
{
	"ter_orion_nameplate_alsace",
	"ter_orion_nameplate_andronicus",
	"ter_orion_nameplate_cyrene",
	"ter_orion_nameplate_jacobus",
	"ter_orion_nameplate_repulse",
	"ter_orion_nameplate_uhuru",
	"ter_orion_nameplate_vasa",
	"ter_orion_nameplate_vindicator",
}
NTFHecateNameplateTable = 
{
	"ter_hecate_nameplate_corduene",
	"ter_hecate_nameplate_corsica",
	"ter_hecate_nameplate_habsburg",
	"ter_hecate_nameplate_laertis",
	"ter_hecate_nameplate_provincia",
	"ter_hecate_nameplate_rhodes",
	"ter_hecate_nameplate_thracia",
	"ter_hecate_nameplate_titus",
}

NTFactor = random(0,1)
function UPGRADE_Rule(i, j)
	--we check to see if we're even for assigning NTF. NTF is odd. 

	--Shivan ships should be disabled when successfully captured. This needs to be updated if we ever mess with race.lua
	if Player_GetRace(i) == 3 then
		SobGroup_SetCaptureAlwaysDisables(sob_ship, 1)
	end
	-- AWACS should automatically get its' subsystems built when upgrades are completed.
	if SobGroup_AreAnyOfTheseTypes(sob_ship, "ter_charybdis, vas_setekh, shi_commnode")==1 then
		if Player_HasResearch(i, "AWACS2") == 1 then
			SobGroup_CreateSubSystem(sob_ship, "awacs_1")
		end
		if Player_HasResearch(i, "AWACS3") == 1 then
			SobGroup_CreateSubSystem(sob_ship, "awacs_2")
		end
	end
	if SobGroup_AreAnyOfTheseTypes(sob_ship, "knossos, subspacenode, subspacenodefs1")==1 then
		SobGroup_AbilityActivate(sob_ship, AB_Scuttle, 0)
		SobGroup_AbilityActivate(sob_ship, AB_Stop, 0)
	end
	--if we have an orion, it has the old weapons, and we have the flak upgrade then
	if SobGroup_AreAnyOfTheseTypes(sob_ship, "ter_orion") == 1 and Player_HasResearch(i, "OrionFlak") == 1 and SobGroup_GetHardPointHealth(sob_ship, "Ter_OrionTurret1") > 0 then
		print("we're doing the thing")
		SobGroup_SetHardPointHealth(sob_ship, "Ter_OrionTurret1", 0)
		SobGroup_SetHardPointHealth(sob_ship, "Ter_OrionTurret2", 0)
		SobGroup_SetHardPointHealth(sob_ship, "Ter_OrionTurret3", 0)
		SobGroup_SetHardPointHealth(sob_ship, "Ter_OrionTurret4", 0)
		SobGroup_CreateSubSystem(sob_ship, "ter_orionhugeflak")
		SobGroup_CreateSubSystem(sob_ship, "ter_orionhugeflak1")
		SobGroup_CreateSubSystem(sob_ship, "ter_orionhugeflak2")
		SobGroup_CreateSubSystem(sob_ship, "ter_orionhugeflak3")
		print("we're doing the thing")
	end
	--This is our nameplate code. We have switched to a pseudo-random method of assigning nameplates, to possibly avoid OOS.
	--nameplatenum = (numberofships) mod (length of list)
	
	if ((i+NTFactor)/2) == ceil ((i+NTFactor)/2) then
		if SobGroup_AreAnyOfTheseTypes(sob_ship, "ter_orion") == 1 and SobGroup_GetHardPointHealth(sob_ship, "Nameplate") == 0 then
			nameplate = FS2OrionNameplateTable[mod(Player_NumberOfAwakeShips(i),getn(FS2OrionNameplateTable))]
			SobGroup_CreateSubSystem(sob_ship, nameplate)
		end
		if SobGroup_AreAnyOfTheseTypes(sob_ship, "ter_hecate") == 1 and SobGroup_GetHardPointHealth(sob_ship, "Nameplate") == 0 then
			nameplate = HecateNameplateTable[mod(Player_NumberOfAwakeShips(i),getn(HecateNameplateTable))]
			SobGroup_CreateSubSystem(sob_ship, nameplate)
		end
	else
		if SobGroup_AreAnyOfTheseTypes(sob_ship, "ter_orion") == 1 and SobGroup_GetHardPointHealth(sob_ship, "NameplateNTF") == 0 then
			nameplate = NTFOrionNameplateTable[mod(Player_NumberOfAwakeShips(i),getn(NTFOrionNameplateTable))]
			SobGroup_CreateSubSystem(sob_ship, nameplate)
		end
		if SobGroup_AreAnyOfTheseTypes(sob_ship, "ter_hecate") == 1 and SobGroup_GetHardPointHealth(sob_ship, "NameplateNTF") == 0 then
			nameplate = NTFHecateNameplateTable[mod(Player_NumberOfAwakeShips(i),getn(NTFHecateNameplateTable))]
			SobGroup_CreateSubSystem(sob_ship, nameplate)
		end
	end

	if SobGroup_AreAnyOfTheseTypes(sob_ship, "ter_orionfs1") == 1 and SobGroup_GetHardPointHealth(sob_ship, "Nameplate") == 0 then
		nameplate = FS1OrionNameplateTable[mod(Player_NumberOfAwakeShips(i),getn(FS1OrionNameplateTable))]
		SobGroup_CreateSubSystem(sob_ship, nameplate)
	end
end

function NOBUILD_Rule(i, j)
	
	sob_ship = globalShipTable[i][j][SobGroup]
	if SobGroup_CanDoAbility(sob_ship, AB_Builder) == 1 then
		--print("FUCK")
		SobGroup_AbilityActivate(sob_ship, AB_Builder, 0)
	end
end

function FASTBUILD_Rule(i, j)
	
	sob_ship = globalShipTable[i][j][SobGroup]
	if SobGroup_CanDoAbility(sob_ship, AB_Builder) == 1 then
		--print("FUCK")
		SobGroup_SetBuildSpeedMultiplier(sob_ship, 10)
	end
end
