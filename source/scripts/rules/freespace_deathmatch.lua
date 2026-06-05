GUID = { 110, 91, 157, 190, 18, 23, 250, 78, 144, 20, 41, 246, 181, 128, 214, 15 }
GameRulesName = "FreeSpace Deathmatch"
Description = "Freespace Mod: Customize the era and settings. HWRM races are disabled."
SaveGameVersion = 1.0
SinglePlayer = 0

ExtFilter = "rules_dm"

Race_Paths = "terran,vasudan,shivan,observer"

Level_Pass_Tags = "dm"
Race_Pass_Tags = "race_ter,race_shi,race_vas,race_random_fs,race_obs"

GameSetupOptions = {
	{
		name = "era",
		locName = "Era",
		tooltip = "Select the FreeSpace era",
		default = 1, -- FS2
		visible = 1,
		choices = {
			"FreeSpace 1", "0",
			"FreeSpace 2", "1",
			"Both Eras", "2",
		},
	},
	{
		name = "resources",
		locName = "$3240",
		tooltip = "$3239",
		default = 1,
		visible = 1,
		choices = {
			"$3241",
			"0.5",
			"$3242",
			"1.0",
			"$3243",
			"2.0",
			"Big",
			"20.0",
		},
	},
	{
		name = "unitcaps",
		locName = "$3214",
		tooltip = "$3234",
		default = 1,
		visible = 1,
		choices = {
			"$3215",
			"Small",
			"$3216",
			"Normal",
			"$3217",
			"Large",
			"$4801",
			"Huge",
		},
	},
	{
		name = "resstart",
		locName = "$3205",
		tooltip = "$3232",
		default = 0,
		visible = 1,
		choices = {
			"$3206",
			"1000",
			"$3207",
			"10000",
			"$3208",
			"10000",
			"Absurd",
			"100000",
			"$3209",
			"0",
		},
	},
	{
		name = "carriersonly",
		locName = "Destroyers Only",
		tooltip = "Only allow destroyers as Capital Ships.",
		default = 0,
		visible = 1,
		choices = {
			"$3183",
			"0",
			"$3184",
			"1",
			"$4802",
			"2",
		},
	},
	{
		name = "bounties",
		locName = "$2987",
		tooltip = "$2988",
		default = 0,
		visible = 1,
		choices = {
			"$5455",
			"0",
			"$3215",
			"0.04",
			"$2989",
			"0.07",
			"$3217",
			"0.1",
		},
	},
	{
		name = "research",
		locName = "$2961",
		tooltip = "$2962",
		default = 1,
		visible = 1,
		choices = {
			"$3184",
			"0",
			"$3183",
			"1",
		},
	},
	{
		name = "ruinjections",
		locName = "$2990",
		tooltip = "$2991",
		default = 0,
		visible = 1,
		choices = {
			"$5455",
			"0",
			"1000",
			"1000",
			"2000",
			"2000",
			"3000",
			"3000",
			"50000",
		},
	},
}

dofilepath("data:scripts/rules/freespace_deathmatch/freespace_deathmatch.lua")
