-- This is our FSFC Afterburner code. To control the animations more carefully, we assign a flag called "Afterburner" that mirrors when the animations are playing. The
-- Default HW2RM idea behind their scout speed burst did not allow for more careful effect scripting, so here it is. Basically, we have our primary AB FX called "SpeedBurst".
-- "SpeedBurst" includes the AB trigger and a burn for the duration of the FX. ABStop is the termination of the afterburner; it plays when you stop moving or the afterburner is
-- out of gas. If the fighter stops during the FX, we have to stop the Afterburner FX and play the stop FX. If the fighter was stopped and moves again, we do the reverse. 

----------------------------------------------------------------------------------------------------
-- AFTERBURNER SETTINGS
----------------------------------------------------------------------------------------------------
-- Afterburner Table
-- Every entry contains of:
-- [ShipName], [Multiplier]
-- 
AfterburnerTable = {
-- If we cannot find a ship in the AfterburnerTable (see above) these are the default settings: we use 0 to quickly identify problems.
default = {0,},
}

----------------------------------------------------------------------------------------------------
AfterburnerTable["ter_pegasus"                   ]={1.2,}
AfterburnerTable["ter_loki"                      ]={1.4117647059,}
AfterburnerTable["ter_hercules"                  ]={1.5789473684,}
AfterburnerTable["ter_herculesmk2"               ]={1.5,}
AfterburnerTable["ter_perseus"                   ]={1.1666666667,}
AfterburnerTable["ter_ulysses"                   ]={1.3719512195,}
AfterburnerTable["ter_myrmidon"                  ]={1.1911764706,}
AfterburnerTable["ter_ares"                      ]={1.6071428571,}
AfterburnerTable["ter_erinyes"                   ]={1.4444444444}
AfterburnerTable["ter_apollo"                    ]={1.478873239,}
AfterburnerTable["ter_valkyrie"                  ]={1.3378378378,}
AfterburnerTable["ter_herculesfs1"               ]={1.5,}
AfterburnerTable["ter_lokifs1"                   ]={1.4117647059,}
AfterburnerTable["ter_ulyssesfs1"                ]={1.3719512195,}
AfterburnerTable["ter_dragonfs1"                 ]={1.3636363636,}
AfterburnerTable["ter_athena"                    ]={1.333333333,}
AfterburnerTable["ter_zeusfs1"                   ]={1.2692307692,}
AfterburnerTable["ter_medusafs1"                 ]={1.3043478261,}
AfterburnerTable["ter_ursafs1"                   ]={1.2857142857,}
AfterburnerTable["ter_zeus"                      ]={1.2692307692,}
AfterburnerTable["ter_artemis"                   ]={1.2692307692,}
AfterburnerTable["ter_artemisdh"                 ]={1.2,}
AfterburnerTable["ter_medusa"                    ]={1.3043478261,}
AfterburnerTable["ter_ursa"                      ]={1.2857142857,}
AfterburnerTable["ter_boanerges"                 ]={1.0625}
AfterburnerTable["ter_mara"                      ]={1.1911764706,}

AfterburnerTable["ntf_loki"                      ]={1.4117647059,}
AfterburnerTable["ntf_hercules"                  ]={1.5789473684,}
AfterburnerTable["ntf_herculesmk2"               ]={1.5,}
AfterburnerTable["ntf_perseus"                   ]={1.1666666667,}
AfterburnerTable["ntf_ulysses"                   ]={1.3719512195,}
AfterburnerTable["ntf_myrmidon"                  ]={1.1911764706,}
AfterburnerTable["ntf_zeus"                      ]={1.2692307692,}
AfterburnerTable["ntf_medusa"                    ]={1.3043478261,}
AfterburnerTable["ntf_ursa"                      ]={1.2857142857,}
                                                  
AfterburnerTable["vas_ptah"                  ]={1.2,}
AfterburnerTable["vas_seth"                  ]={1.5354330709,}
AfterburnerTable["vas_horus"                 ]={1.275,}
AfterburnerTable["vas_thoth"                 ]={1.3636363636,}
AfterburnerTable["vas_serapis"               ]={1.3235294118,}
AfterburnerTable["vas_tauret"                ]={1.4464285714,}
AfterburnerTable["vas_bakha"                 ]={1.2115384615,}
AfterburnerTable["vas_osiris"                ]={1.3157894737,}
AfterburnerTable["vas_sehkmet"               ]={1.2096774194,}

AfterburnerTable["hol_seth"     		]={1.5354330709,}
AfterburnerTable["hol_horus"                 ]={1.275,}
AfterburnerTable["hol_thoth"                 ]={1.3636363636,}
AfterburnerTable["hol_osiris"                ]={1.3157894737,}
AfterburnerTable["hol_amun"                  ]={1.5,}
AfterburnerTable["vas_sehkmetfs1"            ]={1.2096774194,}
AfterburnerTable["vas_ulyssesfs1"            ]={1.3719512195,}

AfterburnerTable["shi_dragon"                    ]={1.3636363636,}
AfterburnerTable["shi_manticore"                 ]={1.1231884058,}
AfterburnerTable["shi_astaroth"                  ]={1.2236842105,}
AfterburnerTable["shi_basilisk"                  ]={1.3414634146,}
AfterburnerTable["shi_aeshma"                    ]={1.2132352941,}
AfterburnerTable["shi_mara"                      ]={1.2162162162,}
AfterburnerTable["shi_nahema"                    ]={1.3888888889,}

AfterburnerTable["shi_scorpion"                  ]={1.4788732394,}
AfterburnerTable["shi_dragonfs1"                 ]={1.3636363636,}
AfterburnerTable["shi_gorgon"                    ]={0,}                                                 
AfterburnerTable["shi_manticorefs1"              ]={1.1231884058,}
AfterburnerTable["shi_basiliskfs1"               ]={1.3414634146,}

Afterburner = {

}

function Start_Afterburner(CustomGroup, playerIndex, shipID)  
	FX_StartEvent(CustomGroup, "ABStart")
	Afterburner[shipID] = {1,}
end

function Do_Afterburner(CustomGroup, playerIndex, shipID)		
	SobGroup_SetMaxSpeedMultiplier(CustomGroup, 1)

	--if AfterburnerTable[CustomGroup][1] ~= nil then
	ABspeed = AfterburnerTable[CustomGroup][1]
	if Player_HasResearch(playerIndex, "StrikeBomberAfterburner")==1 and CustomGroup == "vas_bakha" or CustomGroup == "ter_zeus" or CustomGroup == "shi_nahema" then
		ABspeed = ABspeed * (4/3)
	end
	if (Player_HasResearch(playerIndex, "SethAfterburner")==1 or Player_HasResearch(playerIndex, "SethAfterburnerFS1")==1) and (CustomGroup == "vas_seth" or CustomGroup == "hol_seth") then
		ABspeed = ABspeed * (4/3)
	end
	--here we can put in afterburner recharge modifiers.
	if (SobGroup_IsDoingAbility(CustomGroup, AB_Move) == 1) or (SobGroup_IsDoingAbility(CustomGroup, AB_Attack) == 1) or (SobGroup_IsDoingAbility(CustomGroup, AB_Dock) == 1) or (SobGroup_IsDoingAbility(CustomGroup, AB_Guard) == 1) then  
		SobGroup_SetMaxSpeedMultiplier(CustomGroup, ABspeed)	
		if Afterburner[shipID][1] == 0 then
			FX_StartEvent(CustomGroup, "ABStart")	
			Afterburner[shipID] = {1,}
		elseif Afterburner[shipID][1] == 1 then
			FX_StartEvent(CustomGroup, "ABDo")
			Afterburner[shipID] = {2,}
		end		
	elseif Afterburner[shipID][1] >= 1 then
		SobGroup_SetMaxSpeedMultiplier(CustomGroup, 1)
		FX_StopEvent(CustomGroup, "ABDo")
		FX_StartEvent(CustomGroup, "ABStop")
		Afterburner[shipID] = {0,}
	else
		SobGroup_SetMaxSpeedMultiplier(CustomGroup, 1)
		FX_StopEvent(CustomGroup, "ABDo")
	end		
end

function Finish_Afterburner(CustomGroup, playerIndex, shipID)	
	SobGroup_SetMaxSpeedMultiplier(CustomGroup, 1)
	FX_StopEvent(CustomGroup, "ABDo")
	if Afterburner[shipID][1] >= 1 then  
		FX_StartEvent(CustomGroup, "ABStop")
	end
	Afterburner[shipID] = {0,}
end