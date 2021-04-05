local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}


this.SPENEMYNAME = {
	INTR_FAR01 = "sol_outland_0000",
	INTR_FAR02 = "sol_outland_0001",
	INTR_FAR03 = "sol_outland_0002",
}

this.INTERROGATE_HOSTAGE = {
	"enqt1000_271b10",
}




this.soldierDefine = {

	mafr_outland_cp = {
		"sol_outland_0000",
		"sol_outland_0001",
		"sol_outland_0002",
		"sol_outland_0003",
		"sol_outland_0004",
		"sol_outland_0005",
		"sol_outland_0006",
		"sol_outland_0007",
		"sol_outland_0008",
		"sol_outland_0009",
		"sol_outland_0010",
		"sol_outland_0011",
		nil
	},

	mafr_outlandNorth_ob = {
		"sol_outlandNorth_0000",
		"sol_outlandNorth_0001",
		"sol_outlandNorth_0002",
		"sol_outlandNorth_0003",
		"sol_outlandNorth_0004",
		"sol_outlandNorth_0005",
		"sol_outlandNorth_0006",
		"sol_outlandNorth_0007",
		nil
	},

	
	mafr_01_20_lrrp = { nil },
	
	nil
}


this.AllChildSoldier = {
	"sol_outland_0000",
	"sol_outland_0001",
	"sol_outland_0002",
	"sol_outland_0003",
	"sol_outland_0004",
	"sol_outland_0005",
	"sol_outland_0006",
	"sol_outland_0007",
	"sol_outland_0008",
	"sol_outland_0009",
	"sol_outland_0010",
	"sol_outland_0011",
	"sol_outlandNorth_0000",
	"sol_outlandNorth_0001",
	"sol_outlandNorth_0002",
	"sol_outlandNorth_0003",
	"sol_outlandNorth_0004",
	"sol_outlandNorth_0005",
	"sol_outlandNorth_0006",
	"sol_outlandNorth_0007",
}

this.childSoldiersInTown = {
	"sol_outland_0000",
	"sol_outland_0001",
	"sol_outland_0002",
	"sol_outland_0003",
	"sol_outland_0004",
	"sol_outland_0005",
	"sol_outland_0006",
	"sol_outland_0007",
	"sol_outland_0008",
	"sol_outland_0009",
	"sol_outland_0010",
	"sol_outland_0011",
}

this.AllCps = {
	"mafr_outland_cp",
	"mafr_outlandNorth_ob",
}


this.kidFightRoutes = {
	"rts_s10120_fight_0000",
	"rts_s10120_fight_0001",
	"rts_s10120_fight_0002",
	"rts_s10120_fight_0003",
	"rts_s10120_fight_0004",
	"rts_s10120_fight_0005",
	"rts_s10120_fight_0006",
	"rts_s10120_fight_0007",
	"rts_s10120_fight_0008",
	"rts_s10120_fight_0009",
	"rts_s10120_fight_0010",
	"rts_s10120_fight_0011",
}


this.kidEscapeRoutes = {
	"rts_s10120_escape_0000",
	"rts_s10120_escape_0001",
	"rts_s10120_escape_0002",
	"rts_s10120_escape_0003",
	"rts_s10120_escape_0004",
	"rts_s10120_escape_0005",
	"rts_s10120_escape_0006",
	"rts_s10120_escape_0007",
	"rts_s10120_escape_0008",
	"rts_s10120_escape_0009",
	"rts_s10120_escape_0010",
	"rts_s10120_escape_0011",
}




this.soldierTypes = {
        CHILD = {
                this.soldierDefine.mafr_outland_cp, this.soldierDefine.mafr_outlandNorth_ob
        },
}





this.routeSets = {
	
	mafr_outland_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rts_s10120_d_0000", 
				"rts_s10120_d_0006", 
				"rts_s10120_d_0003", 
				"rts_s10120_d_0010", 
			},
			groupB = {
				"rts_s10120_d_0001", 
				"rts_s10120_d_0007", 
				"rts_s10120_d_0004", 
				"rts_s10120_d_0005", 
			},
			groupC = {
				"rts_s10120_d_0002", 
				"rts_s10120_d_0009", 
				"rts_s10120_d_0011", 
				"rts_s10120_d_0008", 
			},
		},
		sneak_night = {
			groupA = {
				"rts_s10120_n_0000", 
				"rts_s10120_n_0008", 
				"rts_s10120_n_0007", 
				"rts_s10120_n_0007",						
			},
			groupB = {
				"rts_s10120_n_0002", 
				"rts_s10120_n_0001", 
				"rts_s10120_n_0006", 
				"rts_s10120_n_0005", 
			},
			groupC = {
				"rts_s10120_n_0003", 
				
				"rts_s10120_n_0005", 
				"rts_s10120_n_0004", 
				"rts_s10120_n_0004", 
			},
		},
		caution = {
			groupA = { 
				"rts_s10120_c_0000", 
				"rts_s10120_c_0001",
				"rts_s10120_c_0002",
				"rts_s10120_c_0002",
				"rts_s10120_c_0003",
				"rts_s10120_c_0003",
				"rts_s10120_c_0004",
				"rts_s10120_c_0004",
				"rts_s10120_c_0005",
				"rts_s10120_c_0006",
				"rts_s10120_c_0006",
				"rts_s10120_c_0007",
			},
			groupB = { 
			},
			groupC = { 
			},
		},
		hold = {
			default = {
				"rts_s10120_h_0000",
				"rts_s10120_h_0001",
				"rts_s10120_h_0002",
				"rts_s10120_h_0003",
			},
		},
		sleep = { 
			default = {
				"rts_s10120_s_0000",
				"rts_s10120_s_0001",	
				"rts_s10120_s_0002",
				"rts_s10120_s_0003",
			},
		},	
	},
	
	mafr_outlandNorth_ob = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rts_s10120_outlandNorth_d_0000", 
				"rts_s10120_outlandNorth_d_0001", 
				"rts_s10120_outlandNorth_d_0002", 
				"rts_s10120_outlandNorth_d_0003", 
			},
			groupB = {
				"rts_s10120_outlandNorth_d_0004",
				"rts_s10120_outlandNorth_d_0005",
				"rts_s10120_outlandNorth_d_0006",
				"rts_s10120_outlandNorth_d_0007", 
			},
		},
		sneak_night = {
			groupA = {
				"rts_s10120_outlandNorth_n_0000", 
				"rts_s10120_outlandNorth_n_0001", 
				"rts_s10120_outlandNorth_n_0002", 
				"rts_s10120_outlandNorth_d_0003", 
			},
			groupB = {
				"rts_s10120_outlandNorth_n_0004", 
				"rts_s10120_outlandNorth_n_0005", 
				"rts_s10120_outlandNorth_n_0006", 
				"rts_s10120_outlandNorth_d_0007", 
			},
		},
		caution = {
			groupA = {
				"rts_s10120_outlandNorth_c_0000", 
				"rts_s10120_outlandNorth_c_0000",
				"rts_s10120_outlandNorth_c_0001",
				"rts_s10120_outlandNorth_c_0001",
				"rts_s10120_outlandNorth_c_0002",
				"rts_s10120_outlandNorth_c_0002",
				"rts_s10120_outlandNorth_c_0003",
				"rts_s10120_outlandNorth_c_0003",
			},
			groupB = {
			},
			groupC = {
			},
			groupD = {
			},
		},
		hold = {
			default = {
				"rts_s10120_outlandNorth_h_0000",
				"rts_s10120_outlandNorth_h_0001",
				"rts_s10120_outlandNorth_h_0002",
				"rts_s10120_outlandNorth_h_0003",
			},
		},
		sleep = { 
			default = {
				"rts_s10120_outlandNorth_s_0000",
			},
		},	
	},
		
	
	mafr_01_20_lrrp = {
		USE_COMMON_ROUTE_SETS = true,	
	},	
	nil
}











this.combatSetting = {
	mafr_outland_cp = {
		"gts_outland_0000",
		"css_outland_0000",
	},
	mafr_outlandNorth_ob = {
		"gts_outlandNorth_0000",
		"css_outlandNorth_0000",
	},
	nil
}






this.useGeneInter = {
	mafr_outland_cp = true,
	mafr_outlandNorth_ob = true,
	nil
}

this.InterCall_Hostage = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("inter: hostage :"..soldier2GameObjectId )
	TppMission.UpdateObjective{
		objectives = { "marker_info_hostage" }
	}
end

this.interrogation = {
	
	mafr_outland_cp = {
		high = {
			{ name = this.INTERROGATE_HOSTAGE[1], func = this.InterCall_Hostage, },
			nil
		},
		normal = {
			nil
		},
		nil
	},
	nil
}
this.HighInterrogation = function()
	Fox.Log("*** HighInterrogation ***")
	TppInterrogation.AddHighInterrogation(
		GameObject.GetGameObjectId( "mafr_outland_cp" ),
		{ 
			{ name = this.INTERROGATE_HOSTAGE[1], func = this.InterCall_Hostage, },
		}
	)
end









this.GetSoldierNameFromGameObjectId = function( gameObjectId )
	Fox.Log("############# GetSoldierNameFromGameObjectId ##############")
	for cpName, soldierList in pairs( this.soldierDefine ) do
		for i, soldierName in pairs( soldierList ) do
			if gameObjectId == GameObject.GetGameObjectId( "TppSoldier2", soldierName ) then
				return soldierName
			end
		end
	end
end

function this.SetChildCP()
	Fox.Log("### SetChildCP ### SetChildCP ### SetChildCP ###")
	for i, cpName in ipairs(this.AllCps) do
		local gameObjectId = GameObject.GetGameObjectId( cpName )
		local command = { id = "SetChildCp" }
		GameObject.SendCommand( gameObjectId, command )
	end
end



function this.DisableDying()
	for i, enemyName in ipairs(this.AllChildSoldier) do
		local gameObjectId = GameObject.GetGameObjectId( enemyName )
		local command = { id = "SetEnableDyingState", enabled = false }
		GameObject.SendCommand( gameObjectId, command )
	end
end


function this.SetMaxLife()







end


function this.SetEnableSendMessageAimedFromPlayer()
	
	for i, enemyName in ipairs(this.AllChildSoldier) do
		local gameObjectId = GameObject.GetGameObjectId( enemyName )
		GameObject.SendCommand( gameObjectId, { id = "SetEnableSendMessageAimedFromPlayer", enabled=true } )
	end
	
	local liquidGameObjectId = GameObject.GetGameObjectId( "TppLiquid2" )
	GameObject.SendCommand( liquidGameObjectId, { id = "SetEnableSendMessageAimedFromPlayer", enabled=true } )
end



this.SetUpHostageLanguage = function ()
	Fox.Log("###***SetUpLanguage_for_Hostage! ENGLISH ####")
	local gameObjectId = GameObject.GetGameObjectId( "hos_mis_woman" )
	local setLanguage = { id = "SetLangType", langType="english" }
	local setVoiceType = { id = "SetVoiceType", voiceType = "hostage_b" }

	GameObject.SendCommand( gameObjectId, setLanguage )
	GameObject.SendCommand( gameObjectId, setVoiceType )
end


this.SetHostageStaffParam = function ()
	Fox.Log("#### s10120_enemy.SetAllStaffParam ####")
	
	TppEnemy.AssignUniqueStaffType{
		locaterName = "hos_mis_woman",
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10120_OUTLAND_HOSTAGE ,
		alreadyExistParam = { staffTypeId =2, randomRangeId =6, skill ="Reflex" }, 
	}
end
	






this.InitEnemy = function ()
end



this.SetUpEnemy = function ()
	Fox.Log("### s10120 SetUpEnemy !! ###")
	TppEnemy.RegisterCombatSetting( this.combatSetting )
	local gameObjectId = { type="TppLiquid2", index=0 }
	local command = {id="SetCommandPost", cp="cp"}
	command.cp  = "mafr_outland_cp"
	GameObject.SendCommand(gameObjectId, command)
	
	this.SetChildCP()
	
	this.SetHostageStaffParam()
	
	
	this.SetUpHostageLanguage()
	
	
	
	local targetList = {
		"TppLiquid2",
		"hos_mis_woman",
		"sol_outland_0000",
		"sol_outland_0001",
		"sol_outland_0002",
		"sol_outland_0003",
		"sol_outland_0004",
		"sol_outland_0005",
		"sol_outland_0006",
		"sol_outland_0007",
		"sol_outland_0008",
		"sol_outland_0009",
		"sol_outland_0010",
		"sol_outland_0011",
		"sol_outlandNorth_0000",
		"sol_outlandNorth_0001",
		"sol_outlandNorth_0002",
		"sol_outlandNorth_0003",
		"sol_outlandNorth_0004",
		"sol_outlandNorth_0005",
		"sol_outlandNorth_0006",
		"sol_outlandNorth_0007",
	}
	this.RegistHoldRecoveredStateForMissionTask( targetList )
	
	this.SetMaxLife() 
	this.DisableDying() 
	this.SetEnableSendMessageAimedFromPlayer()	
	this.HighInterrogation()
end


this.OnLoad = function ()
	Fox.Log("*** s10120 onload ***")
end


this.RegistHoldRecoveredStateForMissionTask = function( targetList )
	Fox.Log("###*** MissionTask register beginning ***")
	for index, targetName in pairs(targetList) do
		TppEnemy.RegistHoldRecoveredState( targetName )
	end
end




return this
