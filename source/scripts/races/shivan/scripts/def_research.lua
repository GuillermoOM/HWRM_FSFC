Icon_Speed = "data:ui/newui/research/icons/speed.mres"
Icon_Health = "data:ui/newui/research/icons/health.mres"
Icon_Tech = "data:ui/newui/research/icons/tech.mres"
Icon_Ability = "data:ui/newui/research/icons/ability.mres"
Icon_Build = "data:ui/newui/research/icons/build.mres"

Modifier = 0
Ability = 1
AllShips = 0
Family = 1
Ship = 2

research = {
	-- Era Switches (Hidden) ---
	{
		Name = "FS1",
		DoNotGrant = (FREESPACE_ERA == 2),
		RequiredResearch = "",
		RequiredSubSystems = "",
		Cost = 0,
		Time = 0,
		DisplayedName = "FreeSpace 1 Era",
		DisplayPriority = 0,
		Description = "Activates FreeSpace 1 ships and technology.",
		Icon = Icon_Tech,
		ShortDisplayedName = "FS1 Era",
		UpgradeType = Modifier,
		TargetType = AllShips,
		UpgradeName = "BUILDSPEED",
		UpgradeValue = 1.0,
	},
	{
		Name = "FS2",
		DoNotGrant = (FREESPACE_ERA == 1),
		RequiredResearch = "",
		RequiredSubSystems = "",
		Cost = 0,
		Time = 0,
		DisplayedName = "FreeSpace 2 Era",
		DisplayPriority = 0,
		Description = "Activates FreeSpace 2 ships and technology.",
		Icon = Icon_Tech,
		ShortDisplayedName = "FS2 Era",
		UpgradeType = Modifier,
		TargetType = AllShips,
		UpgradeName = "BUILDSPEED",
		UpgradeValue = 1.0,
	},
}
res_index = 1

doscanpath("data:Scripts/Races/shivan/Scripts/Research", "*.lua")


