local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}





this.soldierDefine = {
	
	afgh_citadel_cp = {
		"sol_citadel_0000",
		"sol_citadel_0001",
		"sol_citadel_0002",
		"sol_citadel_0003",
		"sol_citadel_0004",
		"sol_citadel_0005",
		"sol_citadel_0006",
		"sol_citadel_0007",
		"sol_citadel_0008",
		"sol_citadel_0009",
		"sol_citadel_0010",
		"sol_citadel_0011",
		"sol_citadel_0012",
		"sol_citadel_0013",
		"sol_citadel_0014",
		"sol_citadel_0015",
		"sol_citadel_0016",
		"sol_citadel_0017",
		"sol_citadel_0018",
		"sol_citadel_0019",
		"sol_citadel_0020",
		"sol_citadel_0021",
		"sol_citadel_0022",
		"sol_citadel_0023",
		"sol_citadel_0024",
		"sol_citadel_0025",
		"sol_citadel_0026",
		"sol_citadel_0027",
		"sol_citadel_0028",
		"sol_citadel_0029",
		"sol_citadel_0030",	
		"sol_citadel_0031",	
		"sol_citadel_0032",	
		"sol_citadel_0033",	
		"sol_citadel_0034",
		"sol_citadel_0035",	
		nil
	},
	nil
}

this.soldierPowerSettings = {

	sol_citadel_0000 = {"SNIPER"},
	sol_citadel_0006 = {"SNIPER"},
	sol_citadel_0012 = {"SNIPER"},
	sol_citadel_0018 = {"SNIPER"},	
	sol_citadel_0024 = {"SNIPER"},	


	sol_citadel_0022 = {"SHOTGUN"},
	

	sol_citadel_0031 = {"MISSILE"},
	sol_citadel_0029 = {"MG"},
	
	sol_citadel_0021 = {"MG"},
	sol_citadel_0015 = {"SHOTGUN"},


	sol_citadel_0002 = {"SHOTGUN"},
	sol_citadel_0020 = {"SHOTGUN"},


	sol_citadel_0007 = {"MISSILE"},
	sol_citadel_0001 = {"SHOTGUN"},
	sol_citadel_0019 = {"SHOTGUN"},
	sol_citadel_0013 = {"MISSILE"},
	

}






this.routeSets = {
	
	afgh_citadel_cp = {
		priority = {
			"groupSniper",
			"stage4th",
			"stage3rd",
			"stage2nd",
			"stage1st",
			"groupWalkerGear",
		},
		
		fixedShiftChangeGroup = {
			"groupSniper",
			"stage1st",
			"stage2nd",
			"stage3rd",
			"stage4th",
			"groupWalkerGear",
		},	
		
		sneak_day = {
			groupSniper = {
				{ "rt_citadel_snp_0000", attr = "SNIPER" },
				{ "rt_citadel_d_0026", attr = "SNIPER" },
				{ "rt_citadel_d_0020", attr = "SNIPER" },
				{ "rt_citadel_d_0031", attr = "SNIPER" },
				{ "rts_citadel_snp_0000", attr = "SNIPER" },
			},
		
			
			stage1st = {
				
				"rt_citadel_d_0000",
				"rt_citadel_d_0002",
				"rt_citadel_d_0003",
				"rt_citadel_d_0032",
				
			
			},
			
			stage2nd = {
				
				"rt_citadel_d_0010",
				"rt_citadel_d_0013",				
			
				"rt_citadel_d_0007",
				"rt_citadel_d_0011",
				"rt_citadel_d_0008",
				"rt_citadel_d_0004",
				"rt_citadel_d_0012",
				"rt_citadel_d_0009",	
			},
			
			stage3rd = {
				
				"rt_citadel_d_0019",
				"rt_citadel_d_0016",
				"rt_citadel_d_0018",				
				"rt_citadel_d_0035",
				"rt_citadel_d_0015",
				"rt_citadel_d_0017",
				"rt_citadel_d_0022",	
				"rt_citadel_d_0023",
				"rt_citadel_d_0033",
				"rt_citadel_d_0034",	
			},
			
			
			stage4th = {				
				
				"rt_citadel_d_0027",
				"rt_citadel_d_0024",
				"rt_citadel_d_0028",
				"rt_citadel_d_0029",
				"rt_citadel_d_0030",
			},
			groupWalkerGear={
				"rt_citadel_d_0025",	
				"rt_citadel_d_0021",	
				"rt_citadel_d_0006",	
				"rt_citadel_d_0014",	
			},
			nil
		},
		sneak_night = {
			groupSniper = {
				{ "rt_citadel_snp_0000", attr = "SNIPER" },
				{ "rt_citadel_d_0026", attr = "SNIPER" },
				{ "rt_citadel_d_0020", attr = "SNIPER" },
				{ "rt_citadel_d_0031", attr = "SNIPER" },
				{ "rts_citadel_snp_0000", attr = "SNIPER" },
			},
			stage1st = {
				
				"rt_citadel_n_0001_sub",
				"rt_citadel_n_0000",
				"rt_citadel_n_0002_sub",
				"rt_citadel_n_0005",
				
			
			},
			stage2nd = {
				
				"rt_citadel_n_0006_sub",
				"rt_citadel_d_0008",
				"rt_citadel_n_0007_sub",
				"rt_citadel_d_0007",
				"rt_citadel_d_0008",
				"rt_citadel_n_0008_sub",
				"rt_citadel_d_0007",
			
				"rt_citadel_n_0009",
			
			
			},
			stage3rd = {
				
				"rt_citadel_n_0012",
				"rt_citadel_n_0011_sub",
				"rt_citadel_n_0012",
				"rt_citadel_n_0016",
				"rt_citadel_n_0017",
				"rt_citadel_n_0016",
				"rt_citadel_n_0017",
				"rt_citadel_n_0013",
				"rt_citadel_n_0014",
			
				"rt_citadel_n_0022",
			
			},
			stage4th = {
				"rt_citadel_d_0029",
				"rt_citadel_n_0018_sub",
				"rt_citadel_n_0020",
			
				"rt_citadel_d_0029",
				"rt_citadel_n_0021",
			
			},
			groupWalkerGear={
				"rt_citadel_d_0025",	
				"rt_citadel_d_0021",	
				"rt_citadel_d_0006",	
				"rt_citadel_d_0014",	
			},
			nil
		},
		caution = {
			groupSniper = {
				{ "rt_citadel_snp_0000", attr = "SNIPER" },	
				{ "rt_citadel_c_0034", attr = "SNIPER" },	
				{ "rt_citadel_c_0023", attr = "SNIPER" },	
				{ "rt_citadel_c_0011", attr = "SNIPER" },	
				{ "rts_citadel_snp_0000", attr = "SNIPER" }, 
			},
			stage1st = {
				
				"rt_citadel_c_0000",
				"rt_citadel_c_0001",
			
				"rt_citadel_c_0003",
				"rt_citadel_c_0004",
				
			},
			stage2nd = {
				
				"rt_citadel_c_0007",	
			
				"rt_citadel_c_0009",
				"rt_citadel_c_0005",	
				"rt_citadel_c_0010",
			
				"rt_citadel_c_0012",
				"rt_citadel_c_0013",
				"rt_citadel_c_0014",
			
				"rt_citadel_c_0016",
			},
			stage3rd = {
				
				"rt_citadel_c_0017",
				"rt_citadel_c_0018",
				"rt_citadel_c_0019",
			
				"rt_citadel_c_0021",
				"rt_citadel_c_0022",
			
				"rt_citadel_c_0024",
				"rt_citadel_c_0025",
				"rt_citadel_c_0026",
				"rt_citadel_c_0027",
				"rt_citadel_c_0028",
			},
			stage4th = {
				
				"rt_citadel_c_0029",
				"rt_citadel_c_0030",
				"rt_citadel_c_0031",
			
				"rt_citadel_c_0033",
			
				"rt_citadel_c_0035",				
			},
			groupWalkerGear={
				"rt_citadel_c_0032",	
				"rt_citadel_c_0020",	
				"rt_citadel_c_0008",	
				"rt_citadel_c_0002",	
			},
	
			nil
		},

		hold = {
		},
		sleep = {
			default = {},
			stage1st = {
				"rt_citadel_s_0000",
				"rt_citadel_s_0001",
			},
			stage2nd = {
				"rt_citadel_s_0002",
				"rt_citadel_s_0003",
				"rt_citadel_s_0004",
			},
			stage3rd = {
				"rt_citadel_s_0005",
				"rt_citadel_s_0006",
				"rt_citadel_s_0007",
			},
			stage4th = {
				"rt_citadel_s_0008",
				"rt_citadel_s_0009",
			},
		},
		outofrain = {
			"rt_citadel_r_0000",
			"rt_citadel_r_0001",
			"rt_citadel_r_0002",
			"rt_citadel_r_0003",
			"rt_citadel_r_0004",
			"rt_citadel_r_0005",
			"rt_citadel_r_0006",
			"rt_citadel_r_0007",
			"rt_citadel_r_0008",
			"rt_citadel_r_0009",
			"rt_citadel_r_0010",
			"rt_citadel_r_0011",
		},
		nil
	},

}








function this.Messages()
	return
	StrCode32Table {
		Trap = {
			{ msg = "Enter", sender = "trap_battleAreaStage3", func = this.SetUpEnemyHeliBattle },
		},

		nil
	}
end










this.SetUpEnemyHeli = function()
	Fox.Log("_________________s10150_enemy.SetUpEnemyHeli")
	
	
	GameObject.SendCommand( { type="TppEnemyHeli" }, { id = "RestoreFromSVars" } )
	
	
	TppHelicopter.SetEnemyColoring( TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK )

	if svars.EnemyHeliState == s10150_sequence.HELI_STATE.DEFAULT then
		this.SetUpEnemyHeliDefault()
	else
		Fox.Log("___Auto RestoreFromSvars EnemyHeliRoute")
	end
end

this.SetUpEnemyHeliDefault = function()
	Fox.Log("_________________s10150_enemy.SetUpEnemyHeliDefault")
	
	local gameObjectId = GameObject.GetGameObjectId("EnemyHeli" )
	GameObject.SendCommand(gameObjectId, { id="SetSneakRoute", route="rts_ptr_e_citadel_W_0000" })
	GameObject.SendCommand(gameObjectId, { id="SetCautionRoute", route="rts_ptr_e_citadel_W_0000" })
	GameObject.SendCommand(gameObjectId, { id="SetAlertRoute", route="rts_ptr_e_citadel_W_0000" })
	GameObject.SendCommand(gameObjectId, { id="SetRestrictNotice", enabled = false })
	
	GameObject.SendCommand( gameObjectId, { id="SetCommandPost" , cp="afgh_citadel_cp"})	
end


this.SetUpEnemyHeliBattle = function()
	Fox.Log("_________________s10150_enemy.SetUpEnemyHeliBattle")
	
	if svars.EnemyHeliState	 < s10150_sequence.HELI_STATE.BATTLE then
	
		svars.EnemyHeliState = s10150_sequence.HELI_STATE.BATTLE
	
		
		local gameObjectId = GameObject.GetGameObjectId("EnemyHeli" )
		GameObject.SendCommand(gameObjectId, { id="SetCautionRoute", enabled = false })
		GameObject.SendCommand(gameObjectId, { id="SetAlertRoute", enabled = false })
		GameObject.SendCommand(gameObjectId, { id="SetRestrictNotice", enabled = false })
	end

end

this.SetUpEnemyHeliReturn = function()
	Fox.Log("_________________s10150_enemy.SetUpEnemyHeliReturn")
	
	if svars.EnemyHeliState	 < s10150_sequence.HELI_STATE.RETURN then
	
		svars.EnemyHeliState = s10150_sequence.HELI_STATE.RETURN
	
		
		local gameObjectId = GameObject.GetGameObjectId("EnemyHeli" )
		GameObject.SendCommand(gameObjectId, { id="SetSneakRoute", route="rts_ptr_e_citadel_W_Return" })
		GameObject.SendCommand(gameObjectId, { id="SetCautionRoute", route="rts_ptr_e_citadel_W_Return" })
		GameObject.SendCommand(gameObjectId, { id="SetAlertRoute", route="rts_ptr_e_citadel_W_Return" })
		GameObject.SendCommand(gameObjectId, { id="SetRestrictNotice", enabled = true })
	end
end





this.combatSetting = {
	afgh_citadel_cp = {
		"gt_citadel_01",
		"cs_citadel_01",
		"gt_citadel_02",
		"cs_citadel_02",
		"gt_citadel_03",
		"cs_citadel_03",
		"gt_citadel_04",
		"cs_citadel_04",
	},
	nil
}

this.SetUpCombat = function()

	local gameObjectId = { type="TppCommandPost2" } 

	local combatAreaList = {
		
		area1 = {
			{ guardTargetName="gt_citadel_01", locatorSetName="cs_citadel_01",}, 
		},
		area2 = {
			{ guardTargetName="gt_citadel_02", locatorSetName="cs_citadel_02",},
		},
		area3 = {
			{ guardTargetName="gt_citadel_03", locatorSetName="cs_citadel_03",},
		},
		area4 = {
			{ guardTargetName="gt_citadel_04", locatorSetName="cs_citadel_04",},
		},
	}
	local command = { id = "SetCombatArea", cpName="afgh_citadel_cp", combatAreaList=combatAreaList }
	GameObject.SendCommand( gameObjectId, command )



end

this.SpeakEnglishPfSoliders = function()
	




	
	local gameObjectId = { type="TppCommandPost2" } 
	local command = { id = "SetCpType", type = CpType.TYPE_AMERICA }
	GameObject.SendCommand( gameObjectId, command )
	
end

local scamera_citadel = {
	"scamera_citadel_0000",
	"scamera_citadel_0001",
	"scamera_citadel_0002",
	"scamera_citadel_0003",
	"scamera_citadel_0004",
}

this.SetUpSecurityCamera = function()
	
	for index, cameraName in pairs(scamera_citadel) do
		local gameObjectId = GameObject.GetGameObjectId(cameraName)
		if gameObjectId ~= GameObject.NULL_ID then
				GameObject.SendCommand( gameObjectId, { id="SetCommandPost" , cp="afgh_citadel_cp"})
		end
	end

end


local combatPositionList_original = {
	
	gt_citadel_03 = {
		x_pos = -1250.631,
		y_pos = 601.2391,
		z_pos = -3117.323,
		rad	  = 15,
	},

	gt_citadel_04 = {
		x_pos = -1263.417,
		y_pos = 601.778,
		z_pos = -3192.189,
		rad	  = 10,
	},

	cl_citadel_0021 = {
		x_pos = -1247.521,
		y_pos = 601.3549,
		z_pos = -3166.833,
		rad	  = 9,
	},
}


local combatPositionList = {
		
	gt_citadel_03 = {
		x_pos = -1253.959,
		y_pos = 598.4429,
		z_pos = -3051.638,
		rad	  = 15,
	},
	
	gt_citadel_04 = {
		x_pos = -1250.858,
		y_pos = 595.4069,
		z_pos = -3009.447,
		rad	  = 10,
	},

	cl_citadel_0021 = {
		x_pos = -1260.914,
		y_pos = 598.0626,
		z_pos = -3033.312,
		rad	  = 9,
	},
}


this.SetModeWelcome = function( isEnabled )
	Fox.Log("!!!! s10150_enemy.SetModeWelcome !!!!  :  " .. tostring(isEnabled))
	

	for i,enemyName in ipairs(this.soldierDefine.afgh_citadel_cp) do
		
		local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", enemyName )
		local command = { id="SetPuppet", enabled=isEnabled }
		GameObject.SendCommand( gameObjectId, command )
	end
	

	local cpId = { type="TppCommandPost2" } 
	local posList = {}
	
	if isEnabled then
		posList = combatPositionList
		
		GameObject.SendCommand( cpId, {id = "SetPhase",phase = TppGameObject.PHASE_CAUTION} )			
		GameObject.SendCommand( cpId, {id = "SetKeepCaution", enable=true} )	
		
	else	
		posList = combatPositionList_original

	end
	
	for locatorName,table in pairs(posList) do
		
		Fox.Log("locatorName : ".. tostring(locatorName) .. " / x :".. tostring(table.x_pos) .. " / y :".. tostring(table.y_pos) .. " / z :".. tostring(table.z_pos))
		local name = locatorName
		local command = { id = "SetLocatorPosition", name=name, x = table.x_pos, y = table.y_pos, z = table.z_pos, r = table.rad }
		GameObject.SendCommand( cpId, command )
	end
	

	
end







this.SetUpHeliSkull = function()
	Fox.Log("____s10150_enemy.SetUpHeliSkull()")

	local gameObjectId = GameObject.GetGameObjectId("WestHeli" )
	GameObject.SendCommand( gameObjectId, { id="SetMeshType" , typeName="uth_v01"})				
	
end
this.HeliRouteChange = function(heliName,routeName)
	local gameObjectId = GameObject.GetGameObjectId( heliName )
	GameObject.SendCommand( gameObjectId, { id="SetForceRoute" , route = routeName })	
end






























local WalkerGear_Ride_Group = {
	WalkerGearGameObjectLocator = { 
			solName = "sol_citadel_0023", 
			isBegining = true,
			sneakRouteName = "rt_citadel_d_0014",
			cautionRouteName = "rt_citadel_c_0002",
	},
	WalkerGearGameObjectLocator0000 = { 
			solName = "sol_citadel_0017", 
			isBegining = true,
			sneakRouteName = "rt_citadel_d_0006",
			cautionRouteName = "rt_citadel_c_0008",
	},
	WalkerGearGameObjectLocator0001 = { 
			solName = "sol_citadel_0011", 
			isBegining = true,
			sneakRouteName = "rt_citadel_d_0021",
			cautionRouteName = "rt_citadel_c_0020",
	},
	WalkerGearGameObjectLocator0002 = { 
			solName = "sol_citadel_0005", 
			isBegining = true,
			sneakRouteName = "rt_citadel_d_0025",
			cautionRouteName = "rt_citadel_c_0032",
	},	
}

this.SetUpWalkerGear = function()
	Fox.Log("____s10150_enemy.SetUpWalkerGear()")

	
	GameObject.SendCommand( { type="TppCommonWalkerGear2", }, { id="RestoreFromSVars", } )

	for i, wgName in pairs(WalkerGear_Ride_Group) do
		Fox.Log("____________________________________WalkerGearName is : "..tostring(i).."____________________________________")
		Fox.Log("solName : "..tostring(wgName["solName"]) .. " /isBeginning : " .. tostring(wgName["isBegining"])
			.." /sneakRouteName : "..tostring(wgName["sneakRouteName"]) .. " /cautionRouteName : " .. tostring(wgName["cautionRouteName"]))

		local soldierId = GameObject.GetGameObjectId(wgName["solName"])
		local isBeginning = wgName["isBegining"]
		local walkerId = GameObject.GetGameObjectId(i)
		local cmdSetRelativeVehicle = { id="SetRelativeVehicle", targetId=walkerId , rideFromBeginning = isBeginning }
		GameObject.SendCommand( soldierId, cmdSetRelativeVehicle )
		
		
		
		
		TppEnemy.RegistHoldRecoveredState(i)
	end

end






this.TankRegistHoldRecovered = function()
	TppEnemy.RegistHoldRecoveredState("vehs_citadel_tank_0000")
	TppEnemy.RegistHoldRecoveredState("vehs_citadel_tank_0001")
	TppEnemy.RegistHoldRecoveredState("vehs_citadel_tank_0002")
end






this.useGeneInter = {
	
	
	nil
}





this.vehicleDefine = { instanceCount = 4 }	

this.SpawnVehicleOnInitialize = function()
	
	local spawnList = {
		{ id="Spawn", locator="vehs_citadel_tank_0000", type=Vehicle.type.EASTERN_TRACKED_TANK,	index = 1 },
		{ id="Spawn", locator="vehs_citadel_tank_0001", type=Vehicle.type.EASTERN_TRACKED_TANK,	index = 2 },
		{ id="Spawn", locator="vehs_citadel_tank_0002", type=Vehicle.type.EASTERN_TRACKED_TANK,	index = 3 },
	
	}
	TppEnemy.SpawnVehicles( spawnList )

	
	







end


this.InitEnemy = function ()
end



this.SetUpEnemy = function ()

	TppEnemy.RegisterCombatSetting( this.combatSetting )

	
	this.SetUpCombat()

	
	
	this.TankRegistHoldRecovered()
	
	this.SpeakEnglishPfSoliders()

	this.SetUpSecurityCamera()
	
	TppEnemy.RegisterHoldTime( "afgh_citadel_cp", 10 )

end


this.OnLoad = function ()
	Fox.Log("*** s10150 onload ***")
end




return this

