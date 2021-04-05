local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}

this.DEBUG_strCode32List = {
	
		
		"afgh_enemyBase_cp",
		
		"afgh_enemyEast_ob",
		"afgh_slopedWest_ob",
		"afgh_villageWest_ob",
		"afgh_tentEast_ob",
		
		"afgh_04_36_lrrp",
		"afgh_15_36_lrrp",
		"afgh_06_36_lrrp",
		"afgh_36_38_lrrp",
		"in_lrrpHold_E",
		"in_lrrpHold_W",
		"in_lrrpHold_S",
		"in_lrrpHold_N",
		"out_lrrpHold_E",
		"out_lrrpHold_W",
		"out_lrrpHold_S",
		"out_lrrpHold_N",
	
		"groupA",
		"groupF",
		"groupB",
		"groupC",
		"groupD",
		"groupE",
}






this.USE_COMMON_REINFORCE_PLAN = true





this.VEHICLE_SPAWN_LIST = {
	{ id = "Spawn", locator = "veh_s10033_0000", type = Vehicle.type.EASTERN_LIGHT_VEHICLE, },
}

this.vehicleDefine = {
	instanceCount = #this.VEHICLE_SPAWN_LIST + 1,
}





this.soldierDefine = {
	
	afgh_enemyBase_cp = {
		"sol_enemyBase_0000",
		"sol_enemyBase_0001",
		"sol_enemyBase_0002",
		"sol_enemyBase_0003",
		"sol_enemyBase_0004",
		"sol_enemyBase_0005",
		"sol_enemyBase_0006",
		"sol_enemyBase_0007",
		"sol_enemyBase_0008",
		"sol_enemyBase_0009",
		"sol_enemyBase_0010",
		"sol_enemyBase_0011",
		"sol_enemyBase_0012",
		"sol_enemyBase_0013",
		"sol_enemyBase_0014",
		"sol_enemyBase_0015",
		nil
	},
	
	afgh_slopedTown_cp = {
	},
	
	afgh_enemyEast_ob = {
		"sol_enemyEast_0000",
		"sol_enemyEast_0001",
		"sol_enemyEast_0002",
		"sol_enemyEast_0003",
		nil
	},
	
	afgh_slopedWest_ob = {
		"sol_slopedWest_0000",
		"sol_slopedWest_0001",
		"sol_slopedWest_0002",
		nil
	},
	
	afgh_villageWest_ob = {
		"sol_villageWest_0000",
		"sol_villageWest_0001",
		"sol_villageWest_0002",
		"sol_villageWest_0003",
		nil
	},
	
	afgh_tentEast_ob = {
		"sol_tentEast_0000",
		"sol_tentEast_0001",
		"sol_tentEast_0002",
		"sol_tentEast_0003",
		nil
	},

	
	
	

	
	
	afgh_04_36_lrrp = {
		"sol_36_04_0000",
		"sol_36_04_0001",
		lrrpTravelPlan = "travelEnemyBase01", 
		nil
	},
	afgh_15_36_lrrp = {
		"sol_s_06_38_0000",	
		lrrpTravelPlan = "travelEnemyBase03", 
		nil
	},
	afgh_06_36_lrrp = {
	},
	afgh_36_38_lrrp = {
		"sol_36_15_0000",
		"sol_36_15_0001",
		lrrpTravelPlan = "travelEnemyBase02", 
		nil
	},
	afgh_04_32_lrrp = {
	},
	afgh_15_35_lrrp = {
	},
	nil
}


this.taskTargetList = {
	"hos_s10033_0000",
	"hos_s10033_0001",
	"veh_s10033_0000",
}





this.routeSets = {
	
	afgh_enemyBase_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		sneak_day = {
			groupA = {
				"rts_enemyBase_d_0000",
				"rt_enemyBase_d_0004",
				"rt_enemyBase_d_0008",
				"rt_enemyBase_d_0012",
			},
			groupB = {
				"rt_enemyBase_d_0001",
				"rt_enemyBase_d_0005",
				"rt_enemyBase_d_0009",
				"rt_enemyBase_d_0014",
			},
			groupC = {
				"rt_enemyBase_d_0002_sub",
				"rt_enemyBase_d_0006",	
				"rt_enemyBase_d_0010",
				"rt_enemyBase_d_0007",	
			},
			groupD = {
				"rt_enemyBase_d_0003",
				"rt_enemyBase_d_0007",	
				"rt_enemyBase_d_0011",
				"rt_enemyBase_d_0017",
			},
			nil
		},
		sneak_night = {
			groupA = {
				"rts_enemyBase_n_0000",
				"rt_enemyBase_n_0005_sub",
				"rt_enemyBase_n_0009_sub",
				"rt_enemyBase_n_0015",
			},
			groupB = {
				"rt_enemyBase_n_0001",
				"rt_enemyBase_n_0006",
				"rt_enemyBase_n_0012_sub",
				"rt_enemyBase_n_0016",
			},
			groupC = {
				"rt_enemyBase_n_0002",
				"rt_enemyBase_n_0007",
				"rt_enemyBase_n_0013",
				"rt_enemyBase_n_0017",
			},
			groupD = {
				"rt_enemyBase_n_0004",
				"rt_enemyBase_n_0008",
				"rt_enemyBase_n_0014",
				"rt_enemyBase_n_0019",
			},
			nil
		},
		caution = {
			groupA = {
				"rt_enemyBase_c_0000",	
				"rt_enemyBase_c_0000",	
				"rt_enemyBase_c_0001",
				"rt_enemyBase_c_0002",	
				"rt_enemyBase_c_0002",	
				"rt_enemyBase_c_0003",
				"rt_enemyBase_c_0004",
				"rt_enemyBase_c_0005",
				"rt_enemyBase_c_0006",	
				"rt_enemyBase_c_0006",	
				"rt_enemyBase_c_0007",
				"rt_enemyBase_c_0008",
				"rt_enemyBase_c_0009",
				"rt_enemyBase_c_0010",
				"rt_enemyBase_c_0011",
				"rt_enemyBase_c_0012",
				"rt_enemyBase_c_0013",
				"rt_enemyBase_c_0014",
				"rt_enemyBase_c_0015",
				"rt_enemyBase_c_0016",
				"rt_enemyBase_c_0017",	
				"rt_enemyBase_c_0017",	
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
				"rt_enemyBase_h_0000",
				"rt_enemyBase_h_0001",
				"rt_enemyBase_h_0002",
				"rt_enemyBase_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_enemyBase_s_0000",
				"rt_enemyBase_s_0001",
				"rt_enemyBase_s_0002",
				"rt_enemyBase_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_enemyBase_l_0000",
				"rt_enemyBase_l_0001",
			},
			
			in_lrrpHold_S = {
				"rts_enemyBase_lin_S",
				"rts_enemyBase_lin_S",
			},
			in_lrrpHold_N = {
				"rts_enemyBase_lin_N",
				"rts_enemyBase_lin_N",
			},
			
			out_lrrpHold_S = {
				"rts_enemyBase_lout_S",
				"rts_enemyBase_lout_S",
			},
			out_lrrpHold_N = {
				"rts_enemyBase_lout_N",
				"rts_enemyBase_lout_N",
			},
		},
		nil
	},
	afgh_slopedTown_cp	 = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrpHold = {
				"rt_slopedTown_l_0000",
				"rt_slopedTown_l_0001",
			},
			in_lrrpHold_W = {
				"rts_slopedTown_lin_W",
				"rts_slopedTown_lin_W",
			},
			out_lrrpHold_W = {
				"rts_slopedTown_lout_W",
				"rts_slopedTown_lout_W",
			},
		},
		nil
	},

	afgh_enemyEast_ob	 = { USE_COMMON_ROUTE_SETS = true,	},

	afgh_slopedWest_ob	 = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrpHold = {
				"rt_slopedWest_l_0000",
				"rt_slopedWest_l_0001",
			},
			
			in_lrrpHold_E = {
				"rts_slopedWest_lin_E",
				"rts_slopedWest_lin_E",
			},
			in_lrrpHold_W = {
				"rts_slopedWest_lin_W",
				"rts_slopedWest_lin_W",
			},
			
			out_lrrpHold_E = {
				"rts_slopedWest_lout_E",
				"rts_slopedWest_lout_E",
			},
			out_lrrpHold_W = {
				"rts_slopedWest_lout_W",
				"rts_slopedWest_lout_W",
			},
		},
	},
	afgh_villageWest_ob	 = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrpHold = {
				"rt_villageWest_l_0000",
				"rt_villageWest_l_0001",
			},
			
			in_lrrpHold_E = {
				"rts_villageWest_lin_E",
				"rts_villageWest_lin_E",
			},
			in_lrrpHold_W = {
				"rts_villageWest_lin_W",
				"rts_villageWest_lin_W",
			},
			
			out_lrrpHold_E = {
				"rts_villageWest_lout_E",
				"rts_villageWest_lout_E",
			},
			out_lrrpHold_W = {
				"rts_villageWest_lout_W",
				"rts_villageWest_lout_W",
			},
		},
	},
	afgh_tentEast_ob	 = { USE_COMMON_ROUTE_SETS = true,	},

	
	
	

	
	afgh_04_32_lrrp		 = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_04to32 = {
				"rts_04to32_0000",
				"rts_04to32_0000",
			},
			lrrp_32to04 = {
				"rts_32to04_0000",
				"rts_32to04_0000",
			},
			rp_04to32 = {
				"rts_04to32_0000",
				"rts_04to32_0000",
				"rts_04to32_0000",
				"rts_04to32_0000",
			},
			rp_32to04 = {
				"rts_32to04_0000",
				"rts_32to04_0000",
				"rts_32to04_0000",
				"rts_32to04_0000",
			},
		},
	},
	
	afgh_04_36_lrrp		 = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_04to36 = {
				"rts_04to36_0000",
				"rts_04to36_0000",
			},
			lrrp_36to04 = {
				"rts_36to04_0000",
				"rts_36to04_0000",
			},
			rp_04to36 = {
				"rts_04to36_0000",
				"rts_04to36_0000",
				"rts_04to36_0000",
				"rts_04to36_0000",
			},
			rp_36to04 = {
				"rts_36to04_0000",
				"rts_36to04_0000",
				"rts_36to04_0000",
				"rts_36to04_0000",
			},
		},
	},
	
	afgh_06_36_lrrp		 = {	USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_15_35_lrrp		 = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_15to35 = {
				"rts_15to35_0000",
				"rts_15to35_0000",
			},
			lrrp_35to15 = {
				"rts_35to15_0000",
				"rts_35to15_0000",
			},
			rp_15to35 = {
				"rts_15to35_0000",
				"rts_15to35_0000",
				"rts_15to35_0000",
				"rts_15to35_0000",
			},
			rp_35to15 = {
				"rts_35to15_0000",
				"rts_35to15_0000",
				"rts_35to15_0000",
				"rts_35to15_0000",
			},
		},
	},
	
	afgh_15_36_lrrp		 = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_15to36 = {
				"rts_15to36_0000",
				"rts_15to36_0000",
			},
			lrrp_36to15 = {
				"rts_36to15_0000",
				"rts_36to15_0000",
			},
			rp_15to36 = {
				"rts_15to36_0000",
				"rts_15to36_0000",
				"rts_15to36_0000",
				"rts_15to36_0000",
			},
			rp_36to15 = {
				"rts_36to15_0000",
				"rts_36to15_0000",
				"rts_36to15_0000",
				"rts_36to15_0000",
			},
		},
	},
	
	afgh_36_38_lrrp		 = {	USE_COMMON_ROUTE_SETS = true,	},

	nil
}






this.cpGroups = {
	group_Area2 = {
		
		"afgh_enemyBase_cp",
		"afgh_slopedTown_cp",
		
		"afgh_enemyEast_ob",
		"afgh_slopedWest_ob",
		"afgh_villageWest_ob",
		"afgh_tentEast_ob",
		
		"afgh_04_32_lrrp",
		"afgh_04_36_lrrp",
		"afgh_06_36_lrrp",
		"afgh_15_35_lrrp",
		"afgh_15_36_lrrp",
		"afgh_36_38_lrrp",
	},
}






this.lrrpHoldTime = 15

this.travelPlans = {

	
	
	travelEnemyBase01 = {
	
		{ base = "afgh_villageWest_ob"},
		{ base = "afgh_enemyBase_cp"},
		{ base = "afgh_enemyEast_ob"},
		{ base = "afgh_enemyBase_cp"},
	},

	
	
	travelEnemyBase02 = {
		{ base = "afgh_enemyEast_ob"},
		{ base = "afgh_enemyBase_cp"},
		{ base = "afgh_tentEast_ob"},
		{ base = "afgh_enemyBase_cp"},
	},

	
	
	travelEnemyBase03 = {
		{ cp="afgh_slopedWest_ob", 		routeGroup={ "travel", "out_lrrpHold_W" } },	
		{ cp="afgh_15_36_lrrp", 		routeGroup={ "travel", "lrrp_15to36" } },	
		{ cp="afgh_enemyBase_cp", 		routeGroup={ "travel", "in_lrrpHold_N" } },	
		{ cp="afgh_enemyBase_cp", 		routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime },	
		{ cp="afgh_enemyBase_cp", 		routeGroup={ "travel", "out_lrrpHold_S" } },	
		{ cp="afgh_04_36_lrrp", 		routeGroup={ "travel", "lrrp_36to04" } },	
		{ cp="afgh_villageWest_ob",		routeGroup={ "travel", "in_lrrpHold_W" } },	
		{ cp="afgh_villageWest_ob", 	routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime },	
		{ cp="afgh_villageWest_ob",		routeGroup={ "travel", "out_lrrpHold_E" } },	
		{ cp="afgh_04_32_lrrp", 		routeGroup={ "travel", "lrrp_04to32" } },	
		{ cp="afgh_04_32_lrrp", 		routeGroup={ "travel", "lrrp_32to04" } },	
		{ cp="afgh_villageWest_ob",		routeGroup={ "travel", "in_lrrpHold_E" } },	
		{ cp="afgh_villageWest_ob", 	routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime },	
		{ cp="afgh_villageWest_ob",		routeGroup={ "travel", "out_lrrpHold_W" } },	
		{ cp="afgh_04_36_lrrp", 		routeGroup={ "travel", "lrrp_04to36" } },	
		{ cp="afgh_enemyBase_cp", 		routeGroup={ "travel", "in_lrrpHold_S" } },	
		{ cp="afgh_enemyBase_cp", 		routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime },	
		{ cp="afgh_enemyBase_cp", 		routeGroup={ "travel", "out_lrrpHold_N" } },	
		{ cp="afgh_15_36_lrrp", 		routeGroup={ "travel", "lrrp_36to15" } },	
		{ cp="afgh_slopedWest_ob", 		routeGroup={ "travel", "in_lrrpHold_W" } },	
		{ cp="afgh_slopedWest_ob", 		routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime },	
		{ cp="afgh_slopedWest_ob", 		routeGroup={ "travel", "out_lrrpHold_E" } },	
		{ cp="afgh_15_35_lrrp", 		routeGroup={ "travel", "lrrp_15to35" } },	
		{ cp="afgh_slopedTown_cp", 		routeGroup={ "travel", "in_lrrpHold_W" } },	
		{ cp="afgh_slopedTown_cp", 		routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime },	
		{ cp="afgh_slopedTown_cp", 		routeGroup={ "travel", "out_lrrpHold_W" } },	
		{ cp="afgh_15_35_lrrp", 		routeGroup={ "travel", "lrrp_35to15" } },	
		{ cp="afgh_slopedWest_ob", 		routeGroup={ "travel", "in_lrrpHold_E" } },	
		{ cp="afgh_slopedWest_ob", 		routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime },	

	},

	
	
	rp_enemyBase_From_slopedWest ={
		{ cp="afgh_15_36_lrrp", 		routeGroup={ "travel", "rp_15to36" } },	
		{ cp="afgh_enemyBase_cp", finishTravel=true },	
	},
	rp_enemyBase_From_villageWest ={
		{ cp="afgh_04_36_lrrp", 		routeGroup={ "travel", "rp_04to36" } },	
		{ cp="afgh_enemyBase_cp", finishTravel=true },	
	},

}






this.combatSetting = {
	afgh_enemyBase_cp = {
		"gt_enemyBase_0000",
		"gt_enemyBase_0001",
		"cs_enemyBase_0000",
		"cs_enemyBase_0001",
		combatAreaList = {
			area1 = {	
					{ guardTargetName = "gt_enemyBase_0000", locatorSetName = "cs_enemyBase_0000", },
			},
			area2 = {	
					{ guardTargetName = "gt_enemyBase_0001", locatorSetName = "cs_enemyBase_0001", },
			},
		},
	},
	afgh_enemyEast_ob = {
		"gt_enemyEast_0000",
	},
	afgh_slopedWest_ob = {
		"gt_slopedWest_0000",
	},
	afgh_villageWest_ob = {
		"gt_villageWest_0000",
	},
	afgh_tentEast_ob = {
		"gt_tentEast_0000",
	},

	nil
}






this.useGeneInter = {
	
	afgh_enemyBase_cp = false,
	afgh_enemyEast_ob = true,
	afgh_slopedWest_ob = true,
	afgh_villageWest_ob = true,
	afgh_tentEast_ob = true,
	nil
}


this.InterCall_hostage_pos01 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_hostage_pos01")
	
	TppMission.UpdateObjective{
		radio = {
			radioGroups = "f1000_rtrg3170",
		},
		objectives = { "marker_area_Target" },
	}
end


this.interrogation = {

	
	afgh_enemyBase_cp = {
		
		high = {
			{ name = "enqt1000_1i1210", func = this.InterCall_hostage_pos01, },
			nil
		},
		nil
	},
	nil
}





this.SpawnVehicleOnInitialize = function()
	Fox.Log("*** SetVehicleSpawn ***")
	TppEnemy.SpawnVehicles( this.VEHICLE_SPAWN_LIST )
end


this.InitEnemy = function ()
end



this.SetUpEnemy = function ()

	
	this.SetAllEnemyStaffParam()

	
	this.RegistHoldRecoveredStateForMissionTask( this.taskTargetList )

	Fox.Log("Set up enemy")
	TppEnemy.RegisterCombatSetting( this.combatSetting )
	Fox.Log("SetVipHostage")
	TppEnemy.SetRescueTargets( { "hos_s10033_0000" } )

	
	this.RouteExcludeChat()

	
	local gameObjectId = { type="TppCommandPost2" } 
	local reinforcePlan = {

		
		rp_enemyBase_From_slopedWest = { 
			{ toCp="afgh_enemyBase_cp", fromCp="afgh_slopedWest_ob", type="respawn", }, 
		},
		rp_enemyBase_From_villageWest = {
			{ toCp="afgh_enemyBase_cp", fromCp="afgh_villageWest_ob", type="respawn", },
		},

	}
	local command = { id = "SetReinforcePlan", reinforcePlan=reinforcePlan }
	local position = GameObject.SendCommand( gameObjectId, command )

	
	this.VehicleIdSetting()

end


this.OnLoad = function ()
	Fox.Log("*** s10033 onload ***")
end






this.RegistHoldRecoveredStateForMissionTask = function( taskTargetList )
	Fox.Log("###*** MissionTask register beginning ***")
	for index, targetName in pairs(taskTargetList) do
		TppEnemy.RegistHoldRecoveredState( targetName )
	end
end


function this.UnlockedNormalHostage()

	local locatorName = "hos_s10033_0001"
	local gameObjectType = "TppHostage2"
	local gameObjectId = GameObject.GetGameObjectId(gameObjectType, locatorName)
	local command = {
		id = "SetHostage2Flag",
		
		flag = "unlocked",	
		on = true,
	}
	GameObject.SendCommand( gameObjectId, command )

	
	local command01 = { id = "SetMovingNoticeTrap", enable = true }
	GameObject.SendCommand( gameObjectId, command01 )

end


this.SetAllEnemyStaffParam = function ()

	Fox.Log("#### s10033_enemy.SetAllStaffParam ####")
	
	TppEnemy.AssignUniqueStaffType{
		
		locaterName = "hos_s10033_0000",
		
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10033_TARGET_HOSTAGE,
		
		alreadyExistParam = { staffTypeId =3, randomRangeId =6, skill ="MechanicalEngineer" },
	}
	
	local gameObjectId = GameObject.GetGameObjectId( "hos_s10033_0000" )
	local command = { id = "SetLangType", langType="russian" }
	GameObject.SendCommand( gameObjectId, command )
	local command01 = { id = "SetVoiceType", voiceType = "hostage_a" }
	GameObject.SendCommand( gameObjectId, command01 )

	
	TppEnemy.AssignUniqueStaffType{
		locaterName = "hos_s10033_0001",
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10033_HOSTAGE,
		alreadyExistParam = { staffTypeId =46, randomRangeId =4, skill =nil },
	}
	
	local gameObjectId01 = GameObject.GetGameObjectId( "hos_s10033_0001" )
	local command02 = { id = "SetLangType", langType="russian" }
	GameObject.SendCommand( gameObjectId01, command02 )

end


this.CallMonologueHostage = function( locatorName, labelName )

	local gameObjectType = "TppHostage2"
	local gameObjectId = GameObject.GetGameObjectId(gameObjectType, locatorName)
	local command = {
		id="CallMonologue",
		label = labelName,
		reset = true,
	}
	GameObject.SendCommand( gameObjectId, command )

end


this.VehicleIdSetting = function ()

	local targetDriverId_01		= GameObject.GetGameObjectId("TppSoldier2", "sol_s_06_38_0000" )
	local targetVehicleId_01	= GameObject.GetGameObjectId("TppVehicle2", "veh_s10033_0000" )
	local command_target01 		= { id="SetRelativeVehicle", targetId = targetVehicleId_01	, rideFromBeginning = false }
	GameObject.SendCommand( targetDriverId_01	, command_target01 )

end


this.InterStop_hostage_pos01 = function ()
	TppInterrogation.RemoveHighInterrogation(
		GameObject.GetGameObjectId("afgh_enemyBase_cp"),
		{
			{ name = "enqt1000_1i1210", func = this.InterCall_hostage_pos01, },
		}
	)

end


this.RouteExcludeChat = function ()

	local gameObjectId = GameObject.GetGameObjectId( "TppCommandPost2" , "afgh_enemyBase_cp" )
	local routes = {
		"rts_enemyBase_d_0000", 
		"rts_enemyBase_n_0000", 
	}
	local command = { id="SetRouteExcludeChat", routes=routes, enabled=false } 
	GameObject.SendCommand( gameObjectId, command )

end





return this
