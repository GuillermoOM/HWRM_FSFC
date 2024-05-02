--============================================================
-- lua functions for generating speech when a command is given
-- functions available from the game:
--	getFamily(shipName)				- return the DisplayFamily for shipName (displayFamily defined in data\scripts\FamilyList.lua) in upper case
--	playSpeech(speechName)				- speechName is the name of the all ships speech to play without path up to the _
--									  (so to play one of data/sound/speech/AllShips/CHATTER_CarrierOrMShipConstruction_1.mp3
--									   to data/sound/speech/AllShips/CHATTER_CarrierOrMShipConstruction_1.mp3 you'd use
--									   "CHATTER_CarrierOrMShipConstruction")
--	playSpeechFreq(speechName, frequency)	- speechName - same as above
--									- frequency is the minimum amount of time, in seconds, before this event will be played again.
--============================================================

-- move command issued to a ship with the given name

-- DEFINED IN TABLE (see Chatter.lua)
--~ function CommandMoveGiven(shipname, targetname)
--~ 	playSpeech( "COMMAND_Move" )
--~ end




-- DEFINED IN TABLE (see Chatter.lua)
--~ function CommandIdleGiven(shipname, targetname)
--~ 	playSpeech( "COMMAND_MoveCancelled" )
--~ end

--DefensefieldStatus types
DEF_on = 0
DEF_off = 1
DEF_out = 2
DEF_low = 3

-- ShipTypes (return values)
Resource = 2
Fighter = 3
Corvette = 4
Support = 5
MISC = 6
Capital = 7
Frigate = 8
SubSystem = 9
Platform = 10
Megalith = 11
Flagship = 12
AWACS = 13

-- Number of Actors per Actor type
NumAllPilots = 5
NumCapPilots = 4
NumFighterPilots = 3
NumInfiltratorPilots = 2
NumMarinePilots = 2
NumSupportPilots = 3
NumSalCapPilots = 3


-- Text for Actor folder names
NameAllPilot = "All_"
NameCapPilot = "Cap_"
NameFighterPilot = "Fighter_"
NameInfiltratorPilot = "Infiltrator_"
NameMarinePilot = "Marine_"
NameSupportPilot = "Support_"
NameFleetCommand = "Fleet"
NameMakaan = "Makaan"
NameEmperor = "Emperor"
NameSalCap = "SalCap_"

NameTerPilot = "TerPilot_"
NameTerCruiser = "TerCruiser_"
NameTerAwacs = "TerAwacs_"
NameTerCapital = "TerCapital_"
NameTerCommand = "TerCommand_"

NameShiCommand = "Shi_"

-- timeout values for speech events
Frequency_Command = 0.5
Frequency_Status = 2.0
Frequency_Chatter = 5.0

-- Race IDs
Hiigaran = 1
Vaygr = 2
Taiidan = 6

Terran = 10
Shivan = 11

function raceHelper()
	if (currentRace == Vaygr) then
		return NameMakaan
	elseif (currentRace == Taiidan) then
		return NameEmperor
	elseif (currentRace == Terran) then
		return NameTerCommand
	elseif (currentRace == Shivan) then
		return NameShiCommand
	else
		return NameFleetCommand
	end
end

function getType(shipname)
	--first takes care of these special cases for which we don't want to use the AttackFamily

	-- print("GETTING TYPE for SHIP: "..shipname.. " with FAMILY: "..familyName .. " Of Race: " .. currentRace)

	if (shipname == 'Hgn_MotherShip' or shipname == 'Vgr_MotherShip') then
		return Flagship
	end

	shipnameU = strupper(shipname)

	if ((strfind(shipnameU, "PLATFORM") ~= nil) or (strfind(shipnameU, "TURRET") ~= nil)) then
		return Platform
	end

	if (strfind(shipnameU, "DEBRIS") ~= nil) then
		return MISC
	end

	if (strfind(shipnameU, "KPR_") ~= nil) then
		return MISC
	end

	if (strfind(shipnameU, "STRIKE") ~= nil) then
		return Fighter
	end

	if (strfind(shipnameU, "AWACS") ~= nil) then
		return AWACS
	end

	familyName = "" .. getFamily(shipname)

	if (familyName == "CAPITAL" or familyName == "SUPERCAP" or familyName == "SMALLCAPITALSHIP" or familyName == "BIGCAPITALSHIP") then
		return Capital
	end

	if (familyName == "FRIGATE" or familyName == "CAPTURER" or familyName == "CRUISER") then
		return Frigate
	end

	if (familyName == "UTILITY" or familyName == "RESOURCE" or familyName == "RESOURCELARGE") then
		return Resource
	end

	if (familyName == "CORVETTE" or familyName == "BOMBER") then
		return Corvette
	end

	if (familyName == "FIGHTER" or familyName == "STRIKE") then
		return Fighter
	end

	if (familyName == "MEGALITH") then
		return Megalith
	end

	if (familyName == "FLAGSHIP" or familyName == "MOTHERSHIP") then
		return Flagship
	end

	if (familyName == "SUBSYSTEM" or familyName == "SUBSYSTEMMODULE" or (strfind(shipnameU, "MODULE") ~= nil)) then
		return SubSystem
	end

	if (familyName == "PLATFORM") then
		return Platform
	end

	-- print("COULDNT ASSIGN FAMILY: "..familyName.." for ship:"..shipname)

	return 0
end

function GiveFSCommand(commandname, shiptype)
	-- print("Executing Command: " .. commandname .. " For Ship Type: " .. shiptype .. " Of Race: " .. currentRace)

	if currentRace == Terran then
		if shiptype == AWACS then
			playSpeechActor(commandname, NameTerAwacs, NumCapPilots, Frequency_Command)
		elseif shiptype == Frigate then
			playSpeechActor(commandname, NameTerCruiser, NumCapPilots, Frequency_Command)
		elseif shiptype == Capital or shiptype == Flagship then
			playSpeechActor(commandname, NameTerCapital, NumCapPilots, Frequency_Command)
		elseif shiptype == Fighter or shiptype == Corvette or shiptype == Resource then
			playSpeechActor(commandname, NameTerPilot, NumFighterPilots, Frequency_Command)
		end
	elseif (currentRace == Shivan) then
		playSpeechActor(commandname, NameShiCommand, NumCapPilots, Frequency_Command)
	end
end

function CommandMoveToSobGiven(shipname, targetname)
	--print ("movetosob targetname = "..targetname)

	if (strfind(strupper(targetname), "NEBULA") ~= nil) then
		playSpeechActor("COMMAND_OrderedToEnterNebula", NameAllPilot, NumAllPilots, Frequency_Command)
		return
	end

	CommandMoveGiven(shipname, targetname)
end

function isCapital(shipname)
	if (getType(shipname) == Capital) then
		return 1
	end

	return 0
end

function CommandWayPointMoveGiven(shipname, targetname)
	shiptype = getType(shipname)
	genericShipName = strsub(shipname, 5)

	if (genericShipName == "ProximitySensor" or genericShipName == "SensorArray") then
		playSpeechActor("Command_Probe_Selected", NameAllPilot, 1, Frequency_Command)
		return
	end

	if (shiptype == Flagship and genericShipName ~= "Dreadnaught") then
		playSpeechActor("COMMAND_Waypoint_1", raceHelper(), 0, Frequency_Command)
		return
	end

	if (strsub(shipname, 0, 4) == "Kpr_") then
		playSpeechActor("Command_MoverSelected", NameAllPilot, 1, Frequency_Command)
		return
	end
	if currentRace > Taiidan then
		GiveFSCommand("COMMAND_Acknowledge", shiptype)
		return
	end

	playSpeechActor("COMMAND_WAYPOINT", NameAllPilot, NumAllPilots, Frequency_Command)
end

function CommandCancelOrder(shipname, prevOrders)
	local MoveOrder = 0
	local AttackOrder = 1

	if (strsub(shipname, 0, 4) == "Kpr_") then
		playSpeechActor("Command_MoverSelected", NameAllPilot, 1, Frequency_Command)
		return
	end

	shiptype = getType(shipname)
	genericShipName = strsub(shipname, 5)

	if currentRace > Taiidan then
		GiveFSCommand("COMMAND_Acknowledge", shiptype)
	elseif (prevOrders == AttackOrder) then
		if (shiptype == Flagship and genericShipName ~= "Dreadnaught") then
			playSpeechActor("COMMAND_Attack_Cancelled_1", raceHelper(), 0, Frequency_Command)
			return
		end

		if (shiptype == Capital) then
			playSpeechActor("COMMAND_CAP_ATTACK_CANCELLED", NameCapPilot, NumCapPilots, Frequency_Command)
		else
			playSpeechActor("COMMAND_ATTACK_CANCELLED", NameFighterPilot, NumFighterPilots, Frequency_Command)
		end
	else
		if (shiptype == Flagship and genericShipName ~= "Dreadnaught") then
			playSpeechActor("COMMAND_MoveCancelled_1", raceHelper(), 0, Frequency_Command)
			return
		end
		playSpeechActor("COMMAND_MoveCancelled", NameAllPilot, NumAllPilots, Frequency_Command)
	end
end

function CommandDefenseFieldChanged(shipname, defenseType)
	if (defenseType == DEF_on) then
		playSpeechActor("COMMAND_DEFENSEFIELDON", NameCapPilot, NumCapPilots, Frequency_Command)
	elseif (defenseType == DEF_off) then
		playSpeechActor("COMMAND_DEFENSEFIELDOFF", NameCapPilot, NumCapPilots, Frequency_Command)
	elseif (defenseType == DEF_out) then
		playSpeechActor("STATUS_DEFENCEFIELDOUTOFPOWER", NameCapPilot, NumCapPilots, Frequency_Command)
	elseif (defenseType == DEF_low) then
		--no speech
	end
end

-- resource command issued with a target of the given name
function CommandResourceGiven(shipname, targetname)
	--if (targetname == "Container") then
	-- string library not available in luaconfig, so can't use strfind, strlower, strsub

	shiptype = getType(shipname)

	if (targetname == "StaticContainer") then
		if currentRace > Taiidan then
			GiveFSCommand("COMMAND_Acknowledge", shiptype)
		else
			playSpeechActor("COMMAND_ResourceSalvage", NameSupportPilot, NumSupportPilots, Frequency_Command)
		end
	else
		if currentRace > Taiidan then
			GiveFSCommand("COMMAND_Acknowledge", shiptype)
		else
			playSpeechActor("COMMAND_ResourceCollectorHarvest", NameSupportPilot, NumSupportPilots, Frequency_Command)
		end
	end
end

MP_AllianceRequested = 0
MP_AllianceFormed = 1
MP_AllianceBroken = 2
MP_RUsTransferred = 3
MP_ShipsTransferred = 4

function CommandMultiplay(shipname, event)
	if (event == MP_AllianceRequested) then
		playSpeechActor("COMMAND_AllianceRequested_1", raceHelper(), 0, Frequency_Command)
	elseif (event == MP_AllianceFormed) then
		playSpeechActor("COMMAND_AllianceFormed_1", raceHelper(), 0, Frequency_Command)
	elseif (event == MP_AllianceBroken) then
		playSpeechActor("COMMAND_AllianceBroken_1", raceHelper(), 0, Frequency_Command)
	elseif (event == MP_RUsTransferred) then
		playSpeechActor("COMMAND_RUs_Transferred", raceHelper(), 0, Frequency_Command)
	elseif (event == MP_ShipsTransferred) then
		playSpeechActor("COMMAND_Ships_Transferred", raceHelper(), 0, Frequency_Command)
	end
end

-- capture command issued to a ship with the given name
function CommandCaptureGiven(shipname, targetname)
	shiptype = getType(shipname)

	if (shipname == "Hgn_MarineFrigate") then
		playSpeechActor("COMMAND_MarineFrigate_Capture", NameMarinePilot, NumMarinePilots, Frequency_Command)
	else
		if currentRace > Taiidan then
			GiveFSCommand("COMMAND_DockGiven", shiptype)
		else
			playSpeechActor("COMMAND_INFILTRATORFRIGATE_CAPTURE", NameInfiltratorPilot, NumInfiltratorPilots,
				Frequency_Command)
		end
	end
end

function CommandAttackGiven(shipname, targetname, attackType)
	print("******** COMMAND ATTACK: shipname, targetname, attackType = " .. shipname .. "," ..
		targetname .. "," .. attackType)

	-- if special_attack given
	if (attackType == 3) then
		if (shipname == "Hgn_Dreadnaught") then
			playSpeechActor("COMMAND_Dreadnaught_BigGun", NameCapPilot, NumCapPilots, Frequency_Command)
			return
		elseif (shipname == "Hgn_Scout") then
			playSpeechActor("COMMAND_ScoutEmp", NameSupportPilot, NumSupportPilots, Frequency_Command)
			return
		end
	end

	if (strsub(shipname, 0, 4) == "Kpr_") then
		playSpeechActor("Command_MoverSelected", NameAllPilot, 1, Frequency_Command)
		return
	end

	local targetShipType = getType(targetname)
	local shiptype = getType(shipname)


	genericShipName = strsub(shipname, 5)
	genericTargetName = strsub(targetname, 0, 3)

	print("******2- COMMAND ATTACK: shiptype, targetShipType, genericShipName = " ..
		shiptype .. "," .. targetShipType .. "," .. genericShipName)

	if (attackType == 0 or attackType == 3) then
		if currentRace > Taiidan then
			if targetShipType == "SubSystem" and genericTargetName == "SUB" and targetname ~= "SUB_WEAPONS" then
				GiveFSCommand("Command_Disarm", shiptype)
			elseif targetShipType == "SubSystem" then
				GiveFSCommand("Command_Disable", shiptype)
			else
				GiveFSCommand("COMMAND_Attack", shiptype)
			end
		else
			if (shiptype == Flagship and genericShipName ~= "Dreadnaught") then
				playSpeechActor("COMMAND_Attack", raceHelper(), 0, Frequency_Command)
				return
			end
			-- check if we can play Target-relevant speech first
			if (targetShipType == Capital) then
				playSpeechActor("COMMAND_Attack_CapShip", NameCapPilot, NumCapPilots, Frequency_Command)
			elseif (targetShipType == SubSystem and targetname ~= "VGR_HYPERSPACEINHIBITOR") then
				playSpeechActor("COMMAND_BOMBERSUBSYSTEMATTACK", NameFighterPilot, NumFighterPilots, Frequency_Command)
			else
				if (shiptype == Capital) then
					playSpeechActor("COMMAND_CAPSHIP_TO_ATTACK", NameCapPilot, NumCapPilots, Frequency_Command)
				elseif (shipname == "STRIKE") then
					playSpeechActor("COMMAND_StrikeGroup_Attack", NameAllPilot, NumAllPilots, Frequency_Command)
				else
					playSpeechActor("COMMAND_Attack", NameFighterPilot, NumFighterPilots, Frequency_Command)
				end
			end
		end
	elseif (attackType == 1) then
		if currentRace > Taiidan then
			GiveFSCommand("COMMAND_ForceAttack", shiptype)
		else
			if (shiptype == Flagship and genericShipName ~= "Dreadnaught") then
				playSpeechActor("COMMAND_ForceAttackFriendly_1", raceHelper(), 0, Frequency_Command)
				return
			end
			playSpeechActor("COMMAND_ForceAttackFriendly", NameCapPilot, NumCapPilots, Frequency_Command)
		end
	elseif (attackType == 2) then
		if currentRace > Taiidan then
			GiveFSCommand("COMMAND_ForceAttack", shiptype)
		else
			if (targetShipType == Resource) then
				if (shiptype == Flagship) then
					playSpeechActor("COMMAND_CombatMan_1", raceHelper(), 0, Frequency_Command)
				elseif (shiptype == Capital) then
					playSpeechActor("COMMAND_ForceAttack", NameCapPilot, NumCapPilots, Frequency_Command)
				else
					playSpeechActor("COMMAND_Attack", NameFighterPilot, NumFighterPilots, Frequency_Command)
				end
			elseif (shiptype == Flagship and genericShipName ~= "Dreadnaught") then
				--if (shiptype == Flagship and genericShipName~="Dreadnaught" ) then	
				playSpeechActor("COMMAND_ForceAttack_1", raceHelper(), 0, Frequency_Command)
			else
				playSpeechActor("COMMAND_ForceAttack", NameCapPilot, NumCapPilots, Frequency_Command)
			end
		end
	end
end

HYP_Entering = 0
HYP_EnteringGate = 1
HYP_Exiting = 2
HYP_Interrupted = 3
HYP_GateFormed = 4
HYP_EnteredInhibitorVolume = 5
HYP_NotEnoughCash = 6

function CommandHyperspaceGiven(shipname, code)
	print("** CommandHyperspaceGiven: shipname = " .. shipname .. " code = " .. code)
	genericShipName = strsub(shipname, 5)

	--special case for intteruption (same priority)
	if (code == HYP_Interrupted) then
		if (genericShipName == "MotherShip") then
			playSpeechActor("STATUS_HyperspaceInterupted_1", raceHelper(), 0, Frequency_Command)
		else
			playSpeechActor("STATUS_OutofHS", NameCapPilot, NumCapPilots, Frequency_Command)
		end
		return
	end

	--special case for intteruption due to inhibitor(same priority)
	if (code == HYP_EnteredInhibitorVolume) then
		playSpeechActor("STATUS_HyperSpaceInhib_Detected", NameSupportPilot, NumSupportPilots, Frequency_Command)
		return
	end

	if (code == HYP_NotEnoughCash) then
		playSpeechActor("STATUS_HYPERSPACEINSUFFICENT_1", raceHelper(), 0, Frequency_Command)
		return
	end

	if (code == HYP_EnteringGate) then
		playSpeechActor("STATUS_HyperspaceGateJump_1", raceHelper(), 0, Frequency_Command)
		return
	end

	shiptype = getType(shipname)

	if currentRace > Taiidan then
		GiveFSCommand("COMMAND_Jump", shiptype)
	else
		if (shiptype == Flagship) then
			playSpeechActor("COMMAND_HS", raceHelper(), 0, Frequency_Command)
			return
		end

		if (shiptype == Capital) then
			playSpeechActor("COMMAND_CAPHS", NameCapPilot, NumCapPilots, Frequency_Command)
		else
			playSpeechActor("COMMAND_HS", NameCapPilot, NumCapPilots, Frequency_Command)
		end
	end
end

function CommandCombatMan(shipname, targetname)
	shiptype = getType(shipname)
	genericShipName = strsub(shipname, 5)

	if (shiptype == Flagship and genericShipName ~= "Dreadnaught") then
		playSpeechActor("COMMAND_CombatMan_1", raceHelper(), 0, Frequency_Command)
		return
	end

	if currentRace > Taiidan then
		GiveFSCommand("COMMAND_Attack", shiptype)
	else
		if (shiptype == Capital) then
			playSpeechActor("COMMAND_CAP_COMBATMAN", NameCapPilot, NumCapPilots, Frequency_Command)
		else
			playSpeechActor("COMMAND_COMBATMAN", NameFighterPilot, NumFighterPilots, Frequency_Command)
		end
	end
end

function CommandMoveAttackGiven(shipname, targetname)
	shiptype = getType(shipname)
	genericShipName = strsub(shipname, 5)

	if (shiptype == Flagship and genericShipName ~= "Dreadnaught") then
		playSpeechActor("COMMAND_MoveAttack_1", raceHelper(), 0, Frequency_Command)
		return
	end

	if currentRace > Taiidan then
		GiveFSCommand("COMMAND_Attack", shiptype)
	else
		if (shiptype == Capital) then
			playSpeechActor("COMMAND_CAP_MOVEATTACK", NameCapPilot, NumCapPilots, Frequency_Command)
		else
			playSpeechActor("COMMAND_MOVEATTACK", NameFighterPilot, NumFighterPilots, Frequency_Command)
		end
	end
end

function CommandLaunchGiven(shipname, targetname)
	if (shipname == "Hgn_Probe") then
		--playSpeechActor( "COMMAND_ProbeLaunched",raceHelper(), 0)
		return
	end

	shipFamily = getFamily(shipname)
	shiptype = getType(shipname)
	if currentRace > Taiidan then
		GiveFSCommand("COMMAND_Acknowledge", shiptype)
	else
		if (shipFamily == "FIGHTER" or shipFamily == "CORVETTE") then
			-- can't find in new speech
			playSpeechActor("COMMAND_StrikeCraftLaunch", NameSupportPilot, NumSupportPilots, Frequency_Command)
		elseif (shipFamily == "CAPITAL" or shipFamily == "SUPERCAP") then
			playSpeechActorLinked("STATUS_CARRIERORMSHIPCAPITALSHIPLAUNCHED", NameSupportPilot, NumSupportPilots,
				Frequency_Command, CE_STS_CAPWELCOME)
		end
	end
end

-- DEFINED IN TABLE (see Chatter.lua)
function CommandGuardGiven(shipname, targetname)
	shiptype = getType(shipname)
	genericShipName = strsub(shipname, 5)

	if (shiptype == Flagship and genericShipName ~= "Dreadnaught") then
		playSpeechActor("COMMAND_Guard_1", raceHelper(), 0, Frequency_Command)
		return
	end

	if (strsub(shipname, 0, 4) == "Kpr_") then
		playSpeechActor("Command_MoverSelected", NameAllPilot, 1, Frequency_Command)
		return
	end

	if currentRace > Taiidan then
		GiveFSCommand("COMMAND_Acknowledge", shiptype)
	else
		if (shiptype == Capital) then
			playSpeechActor("COMMAND_CAP_GUARD", NameCapPilot, NumCapPilots, Frequency_Command)
		elseif (shiptype == Fighter) then
			playSpeechActor("COMMAND_Guard", NameFighterPilot, NumFighterPilots, Frequency_Command)
		else
			playSpeechActor("COMMAND_Guard", NameAllPilot, NumAllPilots, Frequency_Command)
		end
	end
end

function CommandMoveGiven(shipname, targetnm)
	--print("** CommandMoveGiven: shipname="..shipname)

	local shiptype = getType(shipname)
	genericShipName = strsub(shipname, 5)

	if (shiptype == Flagship and genericShipName ~= "Dreadnaught") then
		playSpeechActor("COMMAND_MOVE_1", raceHelper(), 0, Frequency_Command)
		return
	end

	if (genericShipName == "ProximitySensor" or genericShipName == "SensorArray") then
		playSpeechActor("Command_Probe_Selected", NameAllPilot, NumAllPilots, Frequency_Command)
		return
	end

	genericShipName = strsub(shipname, 5)

	if currentRace > Taiidan then
		GiveFSCommand("COMMAND_Acknowledge", shiptype)
	else
		if (strfind(strupper(shipname), "PROBE") ~= nil) then
			playSpeechActor("COMMAND_ProbeLaunched", raceHelper(), 0, Frequency_Command)
			return
		end

		if (strsub(shipname, 0, 4) == "Kpr_") then
			playSpeechActor("Command_MoverSelected", NameAllPilot, 1, Frequency_Command)
			return
		end

		if (genericShipName == "GunTurret" or genericShipName == "GunPlatform" or genericShipName == "IonTurret" or genericShipName == "WeaponPlatform_gun" or genericShipName == "WeaponPlatform_missile") then
			playSpeechActor("COMMAND_Turret_Fold", NameSupportPilot, NumSupportPilots, Frequency_Command)
		elseif (shipname == "STRIKE") then
			playSpeechActor("COMMAND_StrikeGroup_Move", NameAllPilot, NumAllPilots, Frequency_Command)
		else
			playSpeechActor("COMMAND_Move", NameAllPilot, NumAllPilots, Frequency_Command)
		end
	end
end

function CommandStrikeGroupFormed(shipname, code)
	if (shipname ~= nil) then
		if (strfind(shipname, "Kpr_") ~= nil) then
			playSpeechActor("Command_MoverSelected", NameAllPilot, 1, Frequency_Command)
			return
		end
	end

	if (code == 1) then
		playSpeechActor("COMMAND_STRIKEGROUP_FORM_RESPONSE", NameAllPilot, NumAllPilots, Frequency_Command)
	elseif (code == 2) then
		playSpeechActor("COMMAND_STRIKEGROUP_FORMATIONSET", NameAllPilot, NumAllPilots, Frequency_Command)
	elseif (code == 3) then
		playSpeechActor("COMMAND_STRIKEGROUP_DISBAND", NameAllPilot, NumAllPilots, Frequency_Command)
	end
end

function CommandDockGiven(shipname, targetname)
	shiptype = getType(shipname)

	--eliminate race
	genericShipName = strlower(strsub(targetname, 5))

	--~ 	-- this can get WAY too annoying (happens constantly, latch=dock in code), so disable
	--~ 	if (shiptype==Resource and genericShipName == "ResourceController") then
	--~ 		return
	--~ 	end

	if (strsub(shipname, 0, 4) == "Kpr_") then
		playSpeechActor("Command_MoverSelected", NameAllPilot, 1, Frequency_Command)
		return
	end

	--if (shiptype == Fighter or shiptype == Corvette) then
	--	playSpeechActor("COMMAND_StrikeCraftDock", NameFighterPilot, NumFighterPilots, Frequency_Command )
	--	return
	--end
	if currentRace > Taiidan then
		GiveFSCommand("COMMAND_Dock", shiptype)
	else
		if (genericShipName == "carrier") then
			playSpeechActor("COMMAND_AnyShipGenericDockCarrier_1", NameAllPilot, NumAllPilots, Frequency_Command)
		elseif (genericShipName == "mothership") then
			playSpeechActor("COMMAND_AnyShipGenericDockMothership_1", NameAllPilot, NumAllPilots, Frequency_Command)
		elseif (genericShipName == "shipyard") then
			playSpeechActor("COMMAND_AnyShipGenericDockShipyard_1", NameAllPilot, NumAllPilots, Frequency_Command)
		elseif (genericShipName == "supportfrigate") then
			playSpeechActor("COMMAND_AnyShipGenericDockSupportFrigate_1", NameAllPilot, NumAllPilots, Frequency_Command)
		elseif (genericShipName == "battlecruiser") then
			playSpeechActor("COMMAND_AnyShipGenericDockBattlecruiser_1", NameAllPilot, NumAllPilots, Frequency_Command)
		elseif (genericShipName == "resourcecontroller") then
			playSpeechActor("COMMAND_AnyShipGenericDockResourceController_1", NameAllPilot, NumAllPilots,
				Frequency_Command)
		else
			playSpeechActor("COMMAND_StrikeCraftDock", NameFighterPilot, NumFighterPilots, Frequency_Command)
		end
	end
end

function CommandParadeGiven(shipname, targetname)
	shiptype = getType(shipname)
	if currentRace > Taiidan then
		GiveFSCommand("COMMAND_Dock", shiptype)
	else
		if (shipname == "STRIKE") then
			-- can't find in new speech
			playSpeech("STATUS_StrikeCraftNowFollowing")
			return
		end
		familyName = getFamily(shipname)
		if (familyName == "FIGHTER" or familyName == "CORVETTE") then
			-- can't find in new speech
			playSpeechFreq("STATUS_StrikeCraftNowFollowing", 15)
		end
	end
end

function CommandRetireGiven(shipname, targetname)
	local shiptype = getType(shipname)
	if currentRace > Taiidan then
		GiveFSCommand("COMMAND_Dock", shiptype)
	else
		if (shiptype == Capital) then
			playSpeechActor("COMMAND_CapitalShipRetire", NameCapPilot, NumCapPilots, Frequency_Command)
		elseif (shiptype == Frigate) then
			playSpeechActor("COMMAND_FrigateRetire", NameCapPilot, NumCapPilots, Frequency_Command)
		elseif (shiptype == Fighter) then
			playSpeechActor("COMMAND_FighterRetire", NameFighterPilot, NumFighterPilots, Frequency_Command)
		elseif (shiptype == Support) then
			playSpeechActor("COMMAND_SupportShipRetire", NameSupportPilot, NumSupportPilots, Frequency_Command)
		else
			playSpeechActor("COMMAND_FighterRetire", NameFighterPilot, NumFighterPilots, Frequency_Command)
		end
	end
end

-- DEFINED IN TABLE (see Chatter.lua)

--~ function CommandCouldNotBeIssued(shipname)
--~ 	playSpeech( "COMMAND_CANNOT" )
--~ end

--~ function CommandCloakTurnedOn(shipname)
--~ 	playSpeech( "COMMAND_CloakingShipsCloakingOn_Report" )
--~ end

--~ function CommandCloakTurnedOff(shipname)
--~ 	playSpeech( "COMMAND_CloakingShipsDeCloak" )
--~ end

--~ function CommandCloakOutOfPower(shipname)
--~ 		-- can't find in new speech
--~ 	playSpeech( "COMMAND_CloakingShipsInsufficientPowerToCloak" )
--~ end

AggressiveTactics = 0
DefensiveTactics = 1
PassiveTactics = 2

function CommandTacticsChanged(shipname, newSetting)
	local drone = strfind(strlower(shipname), "kus_drone")
	local dronefrigate = strfind(strlower(shipname), "kus_dronefrigate")
	if drone == nil or dronefrigate ~= nil then
		if (newSetting == AggressiveTactics) then
			playSpeechActor("COMMAND_SetTacticsAggressive", NameAllPilot, NumAllPilots, Frequency_Command)
		elseif (newSetting == DefensiveTactics) then
			playSpeechActor("COMMAND_SetTacticsDefensive", NameAllPilot, NumAllPilots, Frequency_Command)
		elseif (newSetting == PassiveTactics) then
			playSpeechActor("COMMAND_SetTacticsPassive", NameAllPilot, NumAllPilots, Frequency_Command)
		end
	end
end

CloseRange = 0
MediumRange = 1
LongRange = 2

function CommandEngagementRangeChanged(shipname, newSetting)
	if (newSetting == CloseRange) then
		playSpeechActor("COMMAND_SetRangeShort", NameAllPilot, NumAllPilots, Frequency_Command)
	elseif (newSetting == MediumRange) then
		playSpeechActor("COMMAND_SetRangeMedium", NameAllPilot, NumAllPilots, Frequency_Command)
	elseif (newSetting == LongRange) then
		playSpeechActor("COMMAND_SetRangeLong", NameAllPilot, NumAllPilots, Frequency_Command)
	end
end

function CommandEngagementRangeForceChanged(shipname, force)
	if (force == 1) then
		playSpeechActor("COMMAND_SetRangeForce", NameAllPilot, NumAllPilots, Frequency_Command)
	end
end

ACT_Selected = 1
ACT_Created = 2
ACT_Reinforced = 3

function CommandHotKeyGroupSelected(shipname, groupNumber, keyAction)
	if (strfind(shipname, "Kpr_") ~= nil) then
		return
	end

	if (keyAction == ACT_Created) then
		if (groupNumber == 10) then
			playSpeechActor("COMMAND_GROUP_Assigned_10", raceHelper(), 0, Frequency_Command)
		else
			playSpeechActor("COMMAND_GROUP_Assigned_0" .. groupNumber, raceHelper(), 0, Frequency_Command)
		end

		return
	end

	if (keyAction == ACT_Reinforced) then
		if (groupNumber == 10) then
			playSpeechActor("STATUS_HotkeyGroup_Added_20_2", raceHelper(), 0, Frequency_Command)
		else
			playSpeechActor("STATUS_HotkeyGroup_Added_0" .. groupNumber .. "_2", raceHelper(), 0, Frequency_Command)
		end

		return
	end

	if (groupNumber == 10) then
		playSpeechActor("COMMAND_SelectGroup10", NameCapPilot, NumCapPilots, Frequency_Command)
	else
		playSpeechActor("COMMAND_SelectGroup0" .. groupNumber, NameCapPilot, NumCapPilots, Frequency_Command)
	end
end

-- was DEFINED IN TABLE (see Chatter.lua)
function CommandShipsSelected(shipname)
	--print("**** CommandShipsSelected = "..shipname)

	genericShipName = strsub(shipname, 5)

	if (strfind(strupper(shipname), "PROBE") ~= nil or genericShipName == "ProximitySensor" or genericShipName == "SensorArray" or genericShipName == "CryoTray" or genericShipName == "CryoTray_M03") then
		playSpeechActor("Command_Probe_Selected", NameAllPilot, 1, Frequency_Command)
		return
	end

	if (strfind(shipname, "Kpr_") ~= nil) then
		playSpeechActor("Command_MoverSelected", NameAllPilot, 1, Frequency_Command)
		return
	end

	--NOTE TODO: for selecting mothership, play shipname (SHIPNAME_Pride_1 or SHIPNAME_Mothership_1)
	shiptype = getType(shipname)


	if (shiptype == Flagship and shipname ~= "Hgn_Dreadnaught" and shipname ~= "Vgr_Dreadnaught") then
		playSpeechActor("COMMAND_SELECTED_1", raceHelper(), 0, Frequency_Command)
		return
	end

	familyName = getFamily(shipname)

	if currentRace > Taiidan then
		GiveFSCommand("COMMAND_Acknowledge", shiptype)
	else
		if (familyName == "FRIGATE" or familyName == "CAPITAL" or familyName == "SUPERCAP") then
			playSpeechActor("COMMAND_CAPITALSELECTED", NameCapPilot, NumCapPilots, Frequency_Command)
		else
			playSpeechActor("COMMAND_Selected", NameFighterPilot, NumFighterPilots, Frequency_Command)
		end
	end
end

-- construction map
sscMap = {}
sscMap["Battlecruiser"] = {}
sscMap["Carrier"] = {}
sscMap["Shipyard"] = {}
sscMap["MotherShip"] = {}

sscMap["Carrier"].C_PRODUCTION_FIGHTER = "STATUS_FighterFacilityConstructedFromCarrier_1"
sscMap["Carrier"].C_PRODUCTION_CORVETTE = "STATUS_CorvetteFacilityConstructedFromCarrier_1"
sscMap["Carrier"].C_PRODUCTION_FRIGATE = "STATUS_FrigateFacilityConstructedFromCarrier_1"
sscMap["Carrier"].C_PRODUCTION_FRIGATEADVANCED = "STATUS_AdvancedFrigateFacilityConstructedFromCarrier_1"
sscMap["Carrier"].C_MODULE_PLATFORMCONTROL = "STATUS_PlatformFacilityConstructedFromCarrier_1"
sscMap["Carrier"].C_MODULE_RESEARCH = "STATUS_ResearchModuleConstructedFromCarrier_1"
sscMap["Carrier"].C_MODULE_CLOAKGENERATOR = "STATUS_CloakGeneratorConstructedFromCarrier_1"
sscMap["Carrier"].C_MODULE_FIRECONTROL = "STATUS_FireControlTowerConstructedFromCarrier_1"
sscMap["Carrier"].C_SENSORS_ADVANCEDARRAY = "STATUS_SensorsArrayConstructedFromCarrier_1"
sscMap["Carrier"].C_MODULE_HYPERSPACE = "STATUS_HyperspaceCoreConstructedFromCarrier_1"

sscMap["Shipyard"].MS_PRODUCTION_FIGHTER = "STATUS_FighterFacilityConstructedFromShipyard_1"
sscMap["Shipyard"].MS_PRODUCTION_CORVETTE = "STATUS_CorvetteFacilityConstructedFromShipyard_1"
sscMap["Shipyard"].MS_PRODUCTION_FRIGATE = "STATUS_FrigateFacilityConstructedFromShipyard_1"
sscMap["Shipyard"].MS_PRODUCTION_FRIGATEADVANCED = "STATUS_AdvancedFrigateFacilityConstructedFromShipyard_1"
sscMap["Shipyard"].MS_MODULE_PLATFORMCONTROL = "STATUS_PlatformFacilityConstructedFromShipyard_1"
sscMap["Shipyard"].SY_PRODUCTION_CAPSHIP = "STATUS_CapitalShipFacilityConstructedFromShipyard_1"
sscMap["Shipyard"].MS_MODULE_RESEARCH = "STATUS_ResearchModuleConstructedFromShipyard_1"
sscMap["Shipyard"].MS_MODULE_CLOAKGENERATOR = "STATUS_CloakGeneratorConstructedFromShipyard_1"
sscMap["Shipyard"].MS_MODULE_HYPERSPACE = "STATUS_HyperspaceCoreConstructedFromShipyard_1"
sscMap["Shipyard"].MS_MODULE_FIRECONTROL = "STATUS_FireControlTowerConstructedFromShipyard_1"

sscMap["Battlecruiser"].C_MODULE_CLOAKGENERATOR = "STATUS_CloakGeneratorConstructedFromBattlecruiser_1"
sscMap["Battlecruiser"].C_MODULE_FIRECONTROL = "STATUS_FireControlTowerConstructedFromBattlecruiser_1"
sscMap["Battlecruiser"].C_MODULE_HYPERSPACE = "STATUS_HyperspaceCoreConstructedFromBattlecruiser_1"
sscMap["Battlecruiser"].C_MODULE_RESEARCH = "STATUS_ResearchModuleConstructedFromBattlecruiser_1"


sscMap["MotherShip"].MS_PRODUCTION_FIGHTER = "STATUS_FighterFacilityConstructedFromMothership_1"
sscMap["MotherShip"].MS_PRODUCTION_CORVETTE = "STATUS_CorvetteFacilityConstructedFromMothership_1"
sscMap["MotherShip"].MS_PRODUCTION_FRIGATE = "STATUS_FrigateFacilityConstructedFromMothership_1"
sscMap["MotherShip"].MS_PRODUCTION_FRIGATEADVANCED = "STATUS_AdvancedFrigateFacilityConstructedFromMothership_1"
sscMap["MotherShip"].MS_MODULE_PLATFORMCONTROL = "STATUS_PlatformFacilityConstructedFromMothership_1"
sscMap["MotherShip"].MS_MODULE_RESEARCH = "STATUS_ResearchModuleConstructedFromMothership_1"
sscMap["MotherShip"].MS_MODULE_CLOAKGENERATOR = "STATUS_CloakGeneratorConstructedFromMothership_1"
sscMap["MotherShip"].MS_MODULE_FIRECONTROL = "STATUS_FireControlTowerConstructedFromMothership_1"
sscMap["MotherShip"].MS_SENSORS_ADVANCEDARRAY = "STATUS_SensorsArrayConstructedFromMothership_1"
sscMap["MotherShip"].MS_MODULE_HYPERSPACE = "STATUS_HyperspaceCoreConstructedFromMothership_1"
sscMap["MotherShip"].MS_MODULE_RESEARCHADVANCED = "STATUS_AdvResearchModuleConstructedFromMothership_1"
sscMap["MotherShip"].MS_PRODUCTION_CAPSHIP = "STATUS_CapitalShipFacilityConstructedFromMothership_1"
sscMap["MotherShip"].MS_PRODUCTION_CAPSHIPADVANCED = "STATUS_AdvancedCapitalShipFacilityConstructedFromMothership_1"


--Makaaaaaaan
--sscMap["Vgr_MotherShip"].VGR_MS_MODULE_HYPERSPACEINHIBITOR = "STATUS_VHyperspaceInhibitorConstructed_1"


--STATUS_SensorsArrayConstructedFromShipyard_1
--STATUS_AdvancedCapitalShipFacilityConstructedFromShipyard_1
--STATUS_SensorsArrayConstructedFromBattlecruiser_1
stdCMap = {}
stdCMap["Hgn_Scout"] = "STATUS_ScoutConstructed_1"
stdCMap["Hgn_Interceptor"] = "STATUS_InterceptorConstructed_1"
stdCMap["Hgn_AttackBomber"] = "STATUS_BomberConstructed_1"
stdCMap["Hgn_AttackBomberElite"] = "STATUS_BomberConstructed_1"
stdCMap["Hgn_AssaultCorvette"] = "STATUS_AssaultCorvetteConstructed_1"
stdCMap["Hgn_AssaultCorvetteElite"] = "STATUS_AssaultCorvetteConstructed_1"
stdCMap["Hgn_PulsarCorvette"] = "STATUS_PulsarCorvetteConstructed_1"
stdCMap["Hgn_MinelayerCorvette"] = "STATUS_MinelayerCorvetteConstructed_1"
stdCMap["Hgn_AssaultFrigate"] = "STATUS_AssaultFrigateConstructed_1"
stdCMap["Hgn_TorpedoFrigate"] = "STATUS_TorpedoFrigateConstructed_1"
stdCMap["Hgn_TorpedoFrigateElite"] = "STATUS_TorpedoFrigateConstructed_1"
stdCMap["Hgn_IonCannonFrigate"] = "STATUS_IonBeamFrigateConstructed"
stdCMap["Hgn_SupportFrigate"] = "STATUS_SupportFrigateConstructed_1"
stdCMap["Hgn_MarineFrigate"] = "STATUS_MarineFrigateConstructed_1"
stdCMap["Hgn_DefenseFieldFrigate"] = "STATUS_DefenseFieldFrigateConstructed_1"
stdCMap["Hgn_Destroyer"] = "STATUS_DestroyerConstructed_1"
stdCMap["Hgn_Carrier"] = "STATUS_CarrierConstructed_1"
stdCMap["Hgn_Battlecruiser"] = "STATUS_BattlecruiserConstructed_1"
stdCMap["Kpr_Mover"] = "STATUS_MoverConstructed_1"
stdCMap["Hgn_Shipyard"] = "STATUS_ShipyardConstructed_1"
stdCMap["Hgn_GunTurret"] = "STATUS_GunTurretConstructed_1"
stdCMap["Hgn_IonTurret"] = "STATUS_IonBeamPlatformConstructed"
stdCMap["Hgn_ResourceCollector"] = "STATUS_ResourceCollectorConstructed_1"
stdCMap["Hgn_ResourceController"] = "STATUS_ResourceControllerConstructed_1"
stdCMap["Hgn_Probe"] = "STATUS_ProbeConstructed_1"
stdCMap["Hgn_ECMProbe"] = "STATUS_SensorsDistortionProbeConstructed_1"
stdCMap["Hgn_ProximitySensor"] = "STATUS_ProximitySensorConstructed_1"

-- Makaan stuff
stdCMap["Vgr_Scout"] = "STATUS_VScoutConstructed_1"
stdCMap["Vgr_Interceptor"] = "STATUS_VAssaultCraftConstructed_1"
stdCMap["Vgr_Crusader"] = "STATUS_VCrusaderConstructed_1"
stdCMap["Vgr_LanceFighter"] = "STATUS_VLanceFighterConstructed_1"
stdCMap["Vgr_Bomber"] = "STATUS_VBomberConstructed_1"
stdCMap["Vgr_LaserCorvette"] = "STATUS_VLaserCorvetteConstructed_1"
stdCMap["Vgr_MissileCorvette"] = "STATUS_VMissileCorvetteConstructed_1"
stdCMap["Vgr_MinelayerCorvette"] = "STATUS_VMinelayerCorvetteConstructed_1"
stdCMap["Vgr_CommandCorvette"] = "STATUS_VCommandCorvetteConstructed_1"
stdCMap["Vgr_AssaultFrigate"] = "STATUS_VAssaultFrigateConstructed_1"
stdCMap["Vgr_InfiltratorFrigate"] = "STATUS_VInfiltratorFrigateConstructed_1"
stdCMap["Vgr_HeavyMissileFrigate"] = "STATUS_VHvyMissilFrigateConstructed_1"
stdCMap["Vgr_TransportFrigate"] = "STATUS_VTransportFrigateConstructed_1"
stdCMap["Vgr_ShipYard"] = "STATUS_VShipyardConstructed_1"
stdCMap["Vgr_Carrier"] = "STATUS_VCarrierConstructed_1"
stdCMap["Vgr_Battlecruiser"] = "STATUS_VBattleCruiserConstructed_1"
stdCMap["Vgr_Destroyer"] = "STATUS_VDestroyerConstructed_1"
stdCMap["Vgr_ResourceCollector"] = "STATUS_VResourceCollectorConstructed_1"
stdCMap["Vgr_ResourceController"] = "STATUS_VResourceControllerConstructed_1"
stdCMap["Vgr_Probe"] = "STATUS_VProbeConstructed_1"
stdCMap["Vgr_Probe_ECM"] = "STATUS_VSensorDistortionProbeConstructed_1"
stdCMap["Vgr_Probe_Prox"] = "STATUS_VProxProbeConstructed_1"
stdCMap["Vgr_HyperSpace_Platform"] = "STATUS_VHyperspacePlatformConstructed_1"

-- Kushan stuff
stdCMap["Kus_Scout"] = "STATUS_ScoutConstructed"
stdCMap["Kus_Interceptor"] = "STATUS_InterceptorConstructed"
stdCMap["Kus_AttackBomber"] = "STATUS_AttackBomberConstructed_1"
stdCMap["Kus_Defender"] = "STATUS_DefenderConstructed_1"
stdCMap["Kus_CloakedFighter"] = "STATUS_CloakedFighterConstructed_1"
stdCMap["Kus_LightCorvette"] = "STATUS_LightCorvetteConstructed_1"
stdCMap["Kus_HeavyCorvette"] = "STATUS_HeavyCorvetteConstructed_1"
stdCMap["Kus_MultiGunCorvette"] = "STATUS_MultiGunCorvetteConstructed_1"
stdCMap["Kus_MinelayerCorvette"] = "STATUS_MinelayerCorvetteConstructed_1"
stdCMap["Kus_RepairCorvette"] = "STATUS_RepairCorvetteConstructed_1"
stdCMap["Kus_SalvageCorvette"] = "STATUS_SalvageCorvetteConstructed_1"
stdCMap["Kus_SupportFrigate"] = "STATUS_SupportFrigateConstructed_1"
stdCMap["Kus_AssaultFrigate"] = "STATUS_AssaultFrigateConstructed"
stdCMap["Kus_IonCannonFrigate"] = "STATUS_IonCannonFrigateConstructed_1"
stdCMap["Kus_DroneFrigate"] = "STATUS_DroneFrigateConstructed_1"
stdCMap["Kus_Destroyer"] = "STATUS_DestroyerConstructed_1"
stdCMap["Kus_MissileDestroyer"] = "STATUS_MissileDestroyerConstructed_1"
stdCMap["Kus_Carrier"] = "STATUS_CarrierConstructed_1"
stdCMap["Kus_HeavyCruiser"] = "STATUS_HeavyCruiserConstructed_1"
stdCMap["Kus_ResourceCollector"] = "STATUS_ResourceCollectorConstructed_1"
stdCMap["Kus_ResourceController"] = "STATUS_ResourceControllerConstructed"
stdCMap["Kus_ResearchShip"] = "STATUS_ResearchShipConstructed_1"
stdCMap["Kus_Probe"] = "STATUS_ProbeConstructed_1"
stdCMap["Kus_ProximitySensor"] = "STATUS_ProximitySensorConstructed_1"
stdCMap["Kus_CloakGenerator"] = "STATUS_CloakGeneratorConstructed_1"
stdCMap["Kus_GravWellGenerator"] = "STATUS_GravWellGeneratorConstructed_1"
stdCMap["Kus_SensorArray"] = "STATUS_SensorsArrayConstructed_1"

-- Taiidan stuff
stdCMap["Tai_Scout"] = "STATUS_ScoutConstructed"
stdCMap["Tai_Interceptor"] = "STATUS_InterceptorConstructed"
stdCMap["Tai_AttackBomber"] = "STATUS_AttackBomberConstructed"
stdCMap["Tai_Defender"] = "STATUS_DefenderConstructed"
stdCMap["Tai_DefenseFighter"] = "STATUS_DefenseFighterConstructed"
stdCMap["Tai_LightCorvette"] = "STATUS_LightCorvetteConstructed"
stdCMap["Tai_HeavyCorvette"] = "STATUS_HeavyCorvetteConstructed"
stdCMap["Tai_MultiGunCorvette"] = "STATUS_MultiGunCorvetteConstructed"
stdCMap["Tai_MinelayerCorvette"] = "STATUS_MinelayerCorvetteConstructed_1"
stdCMap["Tai_RepairCorvette"] = "STATUS_RepairCorvetteConstructed"
stdCMap["Tai_SalvageCorvette"] = "STATUS_SalvageCorvetteConstructed"
stdCMap["Tai_SupportFrigate"] = "STATUS_SupportFrigateConstructed"
stdCMap["Tai_AssaultFrigate"] = "STATUS_AssaultFrigateConstructed"
stdCMap["Tai_IonCannonFrigate"] = "STATUS_IonCannonFrigateConstructed"
stdCMap["Tai_FieldFrigate"] = "STATUS_FieldFrigateConstructed"
stdCMap["Tai_Destroyer"] = "STATUS_DestroyerConstructed_1"
stdCMap["Tai_MissileDestroyer"] = "STATUS_MissileDestroyerConstructed"
stdCMap["Tai_Carrier"] = "STATUS_CarrierConstructed_1"
stdCMap["Tai_HeavyCruiser"] = "STATUS_HeavyCruiserConstructed"
stdCMap["Tai_ResourceCollector"] = "STATUS_ResourceCollectorConstructed_1"
stdCMap["Tai_ResourceController"] = "STATUS_ResourceControllerConstructed"
stdCMap["Tai_ResearchShip"] = "STATUS_ResearchShipConstructed"
stdCMap["Tai_Probe"] = "STATUS_ProbeConstructed_1"
stdCMap["Tai_ProximitySensor"] = "STATUS_ProxProbeConstructed_1"
stdCMap["Tai_CloakGenerator"] = "STATUS_CloakGeneratorConstructed"
stdCMap["Tai_GravWellGenerator"] = "STATUS_GravWellGeneratorConstructed"
stdCMap["Tai_SensorArray"] = "STATUS_SensorsArrayConstructed"

--Terran stuff
stdCMap["ter_elysium"] = "collectorcomplete_1"
stdCMap["ter_zephyrus"] = "dropoffcomplete_1"
stdCMap["ter_zeus"] = "STATUS_StrikebomberConstructed_1"
stdCMap["ter_artemis"] = "STATUS_MediumbomberConstructed_1"
stdCMap["ter_medusa"] = "STATUS_MediumbomberConstructed_1"
stdCMap["ter_ursa"] = "STATUS_HeavybomberConstructed_1"
stdCMap["ter_boanerges"] = "STATUS_HeavybomberConstructed_1"
stdCMap["ter_artemisdh"] = "STATUS_HeavybomberConstructed_1"
stdCMap["ter_loki"] = "STATUS_ReconConstructed_1"
stdCMap["ter_ulysses"] = "STATUS_SuperiorityConstructed_1"
stdCMap["ter_hercules"] = "STATUS_AssaultConstructed_1"
stdCMap["ter_herculesmk2"] = "STATUS_AssaultConstructed"
stdCMap["ter_perseus"] = "STATUS_InterceptorConstructed_1"
stdCMap["ter_pegasus"] = "STATUS_StealthReconConstructed_1"
stdCMap["ter_myrmidon"] = "STATUS_SuperiorityConstructed_1"
stdCMap["ter_ares"] = "STATUS_AssaultConstructed_1"
stdCMap["ter_erinyes"] = "STATUS_AssaultConstructed_1"
stdCMap["ter_fenris"] = "STATUS_StrikeCruiserConstructed_1"
stdCMap["ter_leviathan"] = "STATUS_HeavyCruiserConstructed_1"
stdCMap["ter_aeolus"] = "STATUS_AdvCruiserConstructed_1"
stdCMap["ter_deimos"] = "STATUS_CorvetteConstructed_1"
stdCMap["ter_orion"] = "STATUS_DestroyerConstructed_1"
stdCMap["ter_hecate"] = "STATUS_DestroyerConstructed_1"
stdCMap["ter_hades"] = "STATUS_SuperDestroyerConstructed_1"
stdCMap["ntf_iceni"] = "STATUS_CorvetteConstructed_1"
stdCMap["ter_colossus"] = "STATUS_ColossusConstructed_1"
stdCMap["ter_hygeia"] = "STATUS_SupportConstructed_1"
stdCMap["ter_argo"] = "STATUS_RepairConstructed_1"
stdCMap["ter_poseidon"] = "STATUS_SentryBuilderConstructed_1"
stdCMap["ter_charybdis"] = "STATUS_AWACSConstructed_1"
stdCMap["ter_alastor"] = "STATUS_SentryConstructed_1"
stdCMap["ter_pharos"] = "STATUS_SentryConstructed_1"
stdCMap["ter_mjolnir"] = "STATUS_MjolnirConstructed_1"

stdCMap["ter_elysiumfs1"] = "collectorcomplete_1"
stdCMap["ter_zephyrusfs1"] = "dropoffcomplete_1"
stdCMap["ter_zeusfs1"] = "STATUS_StrikebomberConstructed_1"
stdCMap["ter_athena"] = "STATUS_StrikebomberConstructed_1"
stdCMap["ter_medusafs1"] = "STATUS_MediumbomberConstructed_1"
stdCMap["ter_ursafs1"] = "STATUS_HeavybomberConstructed_1"
stdCMap["ter_lokifs1"] = "STATUS_StealthReconConstructed_1"
stdCMap["ter_ulyssesfs1"] = "STATUS_SuperiorityConstructed_1"
stdCMap["ter_herculesfs1"] = "STATUS_AssaultConstructed_1"
stdCMap["ter_valkyrie"] = "STATUS_InterceptorConstructed_1"
stdCMap["ter_apollo"] = "STATUS_SuperiorityConstructed_1"
stdCMap["ter_fenrisfs1"] = "STATUS_StrikeCruiserConstructed_1"
stdCMap["ter_leviathanfs1"] = "STATUS_HeavyCruiserConstructed_1"
stdCMap["ter_orionfs1"] = "STATUS_DestroyerConstructed_1"
stdCMap["ter_hadesfs1"] = "STATUS_SuperDestroyerConstructed_1"
stdCMap["ter_centuar"] = "STATUS_SupportConstructed_1"
stdCMap["ter_chronos"] = "STATUS_RepairConstructed_1"
stdCMap["ter_poseidonfs1"] = "STATUS_SentryBuilderConstructed_1"
stdCMap["ter_faustus"] = "STATUS_AWACSConstructed_1"
stdCMap["ter_cerberus"] = "STATUS_SentryConstructed_1"

-- Vasudan stuff
stdCMap["vas_horus"] = "STATUS_InterceptorConstructed_1"
stdCMap["vas_serapis"] = "STATUS_InterceptorConstructed_1"
stdCMap["vas_thoth"] = "STATUS_SuperiorityConstructed_1"
stdCMap["vas_seth"] = "STATUS_AssaultConstructed_1"
stdCMap["vas_tauret"] = "STATUS_AssaultConstructed_1"
stdCMap["vas_ptah"] = "STATUS_StealthConstructed_1"
stdCMap["vas_bakha"] = "STATUS_StrikebomberConstructed_1"
stdCMap["vas_osiris"] = "STATUS_MediumbomberConstructed_1"
stdCMap["vas_sehkmet"] = "STATUS_HeavybomberConstructed_1"
stdCMap["vas_aten"] = "STATUS_CruiserConstructed_1"
stdCMap["vas_mentu"] = "STATUS_AdvCruiserConstructed_1"
stdCMap["vas_sobek"] = "STATUS_CorvetteConstructed_1"
stdCMap["vas_typhon"] = "STATUS_DestroyerConstructed_1"
stdCMap["vas_hatshepsut"] = "STATUS_DestroyerConstructed_1"
stdCMap["vas_colossus"] = "STATUS_ColossusConstructed_1"
stdCMap["vas_isis"] = "STATUS_ResourceCollectorConstructed_1"
stdCMap["vas_anuket"] = "dropoffcomplete_1"
stdCMap["vas_nephthys"] = "STATUS_SupportConstructed_1"
stdCMap["vas_satis"] = "STATUS_RepairConstructed_1"
stdCMap["vas_bes"] = "STATUS_SentryBuilderConstructed_1"
stdCMap["vas_setekh"] = "STATUS_AWACSConstructed_1"
stdCMap["vas_edjo"] = "STATUS_SentryConstructed_1"
stdCMap["vas_geb"] = "STATUS_SentryConstructed_1"
stdCMap["vas_mjolnir"] = "STATUS_MjolnirConstructed_1"

stdCMap["hol_horus"] = "STATUS_InterceptorConstructed_1"
stdCMap["hol_anubis"] = "STATUS_InterceptorConstructed_1"
stdCMap["hol_thoth"] = "STATUS_SuperiorityConstructed_1"
stdCMap["hol_seth"] = "STATUS_AssaultConstructed_1"
stdCMap["hol_anubisram"] = "STATUS_AssaultConstructed_1"
stdCMap["hol_osiris"] = "STATUS_MediumbomberConstructed_1"
stdCMap["hol_amun"] = "STATUS_HeavybomberConstructed_1"
stdCMap["hol_aten"] = "STATUS_CruiserConstructed_1"
stdCMap["hol_atenram"] = "STATUS_AdvCruiserConstructed_1"
stdCMap["vas_hol_typhon"] = "STATUS_DestroyerConstructed_1"
stdCMap["vas_pvntyphon"] = "STATUS_DestroyerConstructed_1"
stdCMap["vas_isisfs1"] = "STATUS_ResourceCollectorConstructed_1"
stdCMap["vas_bast"] = "STATUS_SentryBuilderConstructed_1"
stdCMap["vas_scarab"] = "STATUS_SupportConstructed_1"
stdCMap["vas_satisfs1"] = "STATUS_RepairConstructed_1"
stdCMap["vas_maat"] = "dropoffcomplete_1"
stdCMap["vas_imhotep"] = "STATUS_AWACSConstructed_1"
stdCMap["vas_ankh"] = "STATUS_SentryConstructed_1"

-- Shivan stuff
stdCMap["shi_aeshma"] = "STATUS_AssaultConstructed_1"
stdCMap["shi_astaroth"] = "STATUS_InterceptorConstructed_1"
stdCMap["shi_basilisk"] = "STATUS_AssaultConstructed_1"
stdCMap["shi_manticore"] = "STATUS_InterceptorConstructed_1"
stdCMap["shi_dragon"] = "STATUS_SuperiorityConstructed_1"
stdCMap["shi_mara"] = "STATUS_SuperiorityConstructed_1"
stdCMap["shi_nahema"] = "STATUS_StrikebomberConstructed_1"
stdCMap["shi_taurvi"] = "STATUS_MediumbomberConstructed_1"
stdCMap["shi_nephilim"] = "STATUS_HeavybomberConstructed_1"
stdCMap["shi_seraphim"] = "STATUS_HeavybomberConstructed_1"
stdCMap["shi_cain"] = "STATUS_StrikeCruiserConstructed_1"
stdCMap["shi_rakshasa"] = "STATUS_AdvCruiserConstructed_1"
stdCMap["shi_lilith"] = "STATUS_HeavyCruiserConstructed_1"
stdCMap["shi_moloch"] = "STATUS_CorvetteConstructed_1"
stdCMap["shi_demon"] = "STATUS_DestroyerConstructed_1"
stdCMap["shi_ravana"] = "STATUS_DestroyerConstructed_1"
stdCMap["shi_lucifer"] = "STATUS_SuperDestroyerConstructed_1"
stdCMap["shi_sathanas"] = "STATUS_SathanasConstructed_1"
stdCMap["shi_azrael"] = "collectorcomplete_1"
stdCMap["shi_rahu"] = "dropoffcomplete_1"
stdCMap["shi_asmodeus"] = "STATUS_RepairConstructed_1"
stdCMap["shi_commnode"] = "STATUS_AWACSConstructed_1"
stdCMap["shi_mephisto"] = "STATUS_SentryBuilderConstructed_1"
stdCMap["shi_belial"] = "STATUS_SentryConstructed_1"

stdCMap["shi_scorpion"] = "STATUS_ReconConstructed_1"
stdCMap["shi_basiliskfs1"] = "STATUS_AssaultConstructed_1"
stdCMap["shi_manticorefs1"] = "STATUS_InterceptorConstructed_1"
stdCMap["shi_dragonfs1"] = "STATUS_SuperiorityConstructed_1"
stdCMap["shi_shaitan"] = "STATUS_StrikebomberConstructed_1"
stdCMap["shi_nephilimfs1"] = "STATUS_HeavybomberConstructed_1"
stdCMap["shi_seraphimfs1"] = "STATUS_HeavybomberConstructed_1"
stdCMap["shi_cainfs1"] = "STATUS_StrikeCruiserConstructed_1"
stdCMap["shi_lilithfs1"] = "STATUS_HeavyCruiserConstructed_1"
stdCMap["shi_demonfs1"] = "STATUS_DestroyerConstructed_1"
stdCMap["shi_luciferfs1"] = "STATUS_SuperDestroyerConstructed_1"
stdCMap["shi_azraelfs1"] = "collectorcomplete_1"
stdCMap["shi_rahufs1"] = "dropoffcomplete_1"
stdCMap["shi_asmodeusfs1"] = "STATUS_RepairConstructed_1"
stdCMap["shi_mephistofs1"] = "STATUS_SentryBuilderConstructed_1"
stdCMap["shi_trident"] = "STATUS_SentryConstructed_1"


BUILD_Std = 1
BUILD_Subsystem = 2

function CommandConstructionComplete(buildingShip, builtItem, buildType)
	print("*****---- CommandConstructionComplete : buildingShip=" ..
		buildingShip .. ", builtItem=" .. builtItem .. ", buildType=" .. buildType)

	if (buildingShip == nil or builtItem == nil) then
		return
	end

	--eliminate race
	genericbuildingShipName = strsub(buildingShip, 5)
	genericbuiltItemName = strsub(builtItem, 5)

	if (buildType == BUILD_Subsystem) then
		--print("sscMap[''..buildingShip][''..builtItem]  = "..sscMap[""..buildingShip][""..builtItem])

		if (sscMap["" .. genericbuildingShipName] ~= nil and sscMap["" .. genericbuildingShipName]["" .. genericbuiltItemName] ~= nil) then
			if (strfind(strupper(builtItem), "INHIBITOR") ~= nil) then
				if (genericbuildingShipName == "Carrier") then
					playSpeechActorLinked("STATUS_HyperspaceInhibConstructedFromCarrier_1", NameCapPilot, NumCapPilots,
						Frequency_Command, CE_STS_INHIBITORONLINE)
				elseif (genericbuildingShipName == "Shipyard") then
					playSpeechActorLinked("STATUS_HyperspaceInhibConstructedFromShipyard_1", NameSupportPilot,
						NumSupportPilots, Frequency_Command, CE_STS_INHIBITORONLINE)
				elseif (genericbuildingShipName == "Battlecruiser") then
					playSpeechActorLinked("STATUS_HyperspaceInhibConstructedFromBattle_1", NameCapPilot, NumCapPilots,
						Frequency_Command, CE_STS_INHIBITORONLINE)
				else
					playSpeechActor("STATUS_HYPERSPACEINHIB_ON", NameSupportPilot, NumSupportPilots, Frequency_Command)
				end
			end

			if (genericbuildingShipName == "Shipyard") then
				playSpeechActor(sscMap["" .. genericbuildingShipName]["" .. genericbuiltItemName], NameSupportPilot,
					NumSupportPilots, Frequency_Command)
			elseif (genericbuildingShipName == "MotherShip") then
				playSpeechActor(sscMap["" .. genericbuildingShipName]["" .. genericbuiltItemName], raceHelper(), 0,
					Frequency_Command)
			else
				playSpeechActor(sscMap["" .. genericbuildingShipName]["" .. genericbuiltItemName], NameCapPilot,
					NumCapPilots, Frequency_Command)
			end
		else
			playSpeechActor("COMMAND_SubsystemConstructed", NameCapPilot, NumCapPilots, Frequency_Command)
		end
	elseif (buildType == BUILD_Std) then
		if (stdCMap["" .. builtItem] ~= nil) then
			playSpeechActor(stdCMap["" .. builtItem], raceHelper(), 0, Frequency_Command)
		end
	end
end

function CommandConstructionStarted(buildingShip, builtItem)
	--builtItemFamily = getFamily(builtItem)
	--if(builtItemFamily == "FRIGATE" or builtItemFamily == "CAPITAL" or builtItemFamily == "SUPERCAP") then
	--	playSpeechActor("COMMAND_CarrierOrMShipBuildCapitalShip", NameSupportPilot, NumSupportPilots, Frequency_Command )
	--	return
	--end

	genericbuildingShipName = strsub(buildingShip, 5)

	if (genericbuildingShipName == "MotherShip") then
		playSpeechActor("STATUS_ConstructionBegun_1", raceHelper(), 0, Frequency_Command)
	else
		playSpeechActor("COMMAND_CarrierOrMShipBuildCapitalShip", NameSupportPilot, NumSupportPilots, Frequency_Command)
	end
end

function CommandPaused(temp)
	--print("*** build paused")
	playSpeechActor("COMMAND_Build_Paused", raceHelper(), 0, Frequency_Command)
end

-- DEFINED IN TABLE (see Chatter.lua)

--~ function CommandResourcesDepleted(shipname)
--~ 	playSpeech("COMMAND_ResourceCollectorNoMoreRUs")
--~ end

--~ function CommandStrikeGroupFormed()
--~ 	playSpeech("COMMAND_StrikeGroup_Form_Report")
--~ end
