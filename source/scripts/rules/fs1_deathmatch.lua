GUID = { 110, 91, 157, 190, 18, 23, 250, 78, 144, 20, 41, 246, 181, 128, 214, 13 }
GameRulesName = "Freespace 1 Era Only"
Description = "Freespace Mod: Only FS1 era ships are available. HWRM races are disabled."
SaveGameVersion = 1.0
SinglePlayer = 0

ExtFilter = "rules_dm"

Race_Paths = "terran,vasudan,shivan,observer"

Level_Pass_Tags = "dm"
Race_Pass_Tags = "race_ter,race_shi,race_vas,race_random_fs,race_obs"

GameSetupOptions = {
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
			"Big AF",
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
			"3000",
			"$3208",
			"10000",
			"$3209",
			"0",
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
}

dofilepath("data:scripts/rules/fs1_deathmatch/fs1_deathmatch.lua")
