local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local IsTypeFunc = Tpp.IsTypeFunc
local IsTypeTable = Tpp.IsTypeTable
local IsTypeString = Tpp.IsTypeString
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_ID

this.requires = {}





this.VEHICLE_SPAWN_LIST = {
	{ id = "Spawn", locator = "Vehicle2Locator0000", type = Vehicle.type.WESTERN_TRUCK, subType = Vehicle.subType.WESTERN_TRUCK_CARGO_ITEM_BOX, paintType=Vehicle.paintType.FOVA_0, },
	{ id = "Spawn", locator = "Vehicle2Locator0001", type = Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0, },
	{ id = "Spawn", locator = "Vehicle2Locator0002", type = Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0, },
}





this.USE_COMMON_REINFORCE_PLAN = true





this.soldierDefine = {
	mafr_factory_cp = {
		nil,
	},
	mafr_factoryWest_ob = {
		"sol_mis_factoryWest_0000",
		"sol_mis_factoryWest_0001",
		"sol_mis_factoryWest_0002",
		"sol_mis_factoryWest_0003",
		"sol_mis_factoryWest_0004",
		"sol_mis_factoryWest_0005",
		"sol_mis_factoryWest_0006",
		"sol_mis_factoryWest_0007",
		nil,
	},
	mafr_factorySouth_ob = {
		"sol_mis_factorySouth_0000",
		"sol_mis_factorySouth_0001",
		"sol_mis_factorySouth_0002",
		"sol_mis_factorySouth_0003",
		"sol_mis_factorySouth_0004",
		"sol_mis_factorySouth_0005",
		nil,
	},
	mafr_hill_cp = {
		"sol_mis_hill_0000",
		"sol_mis_hill_0001",
		"sol_mis_hill_0002",
		"sol_mis_hill_0003",
		"sol_mis_hill_0004",
		"sol_mis_hill_0005",
		"sol_mis_hill_0006",
		"sol_mis_hill_0007",
		"sol_mis_hill_0008",
		"sol_vip_lrrp_0000",
		nil,
	},
	mafr_hillNorth_ob = {
		"sol_mis_hillNorth_0000",
		"sol_mis_hillNorth_0001",
		"sol_mis_hillNorth_0002",
		"sol_mis_hillNorth_0003",
		"sol_mis_hillNorth_0004",
		"sol_mis_hillNorth_0005",
		"sol_mis_hillNorth_0006",
		"sol_mis_hillNorth_0007",
		nil,
	},
	
	
	mafr_17_27_lrrp = {
		nil
	},	
	
	mafr_17_28_lrrp = {
		nil
	},
	
	mafr_14_27_lrrp = {
		nil
	},
	
	mafr_27_30_lrrp = { 
		nil
	},		
	nil,
}













this.routeSets = {

	



	
	mafr_17_27_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night= {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			groupA = {
			},
		},
		travel = {
			lrrp_v_17to27 = {
				"rt_v_17to27_0000",
			},
			lrrp_17to27 = {
				"rt_17to27_0000",
				"rt_17to27_0000",
			},
			lrrp_27to17 = {
				"rt_27to17_0000",
				"rt_27to17_0000",
			},
			rp_17to27 = {
				"rt_17to27_0000",
				"rt_17to27_0000",
				"rt_17to27_0000",
				"rt_17to27_0000",
			},
			rp_27to17 = {
				"rt_27to17_0000",
				"rt_27to17_0000",
				"rt_27to17_0000",
				"rt_27to17_0000",
			},
		},
		nil
	},

	mafr_17_28_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night= {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			groupA = {
			},
		},
		travel = {
			lrrp_v_17to28 = {
				"rt_v_17to28_0000",
			},
		},
		nil
	},		

	mafr_factoryWest_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		sneak_day = {
			groupA = {
				"rt_factoryWest_d_0004",
				"rt_factoryWest_d_0006",
			},
			groupB = {
				"rt_factoryWest_d_0003",
				"rt_factoryWest_d_0000",
			},
			groupC = {
				"rt_factoryWest_d_0002",
				"rt_factoryWest_d_0001",
			},
			groupD = {
				"rt_factoryWest_d_0005",
				"rt_factoryWest_d_0007",
			},
		},
		sneak_night = {
			groupA = {
				"rt_factoryWest_n_0004",
				"rt_factoryWest_n_0006",
			},
			groupB = {
				"rt_factoryWest_n_0000",
				"rt_factoryWest_n_0001",
			},
			groupC = {
				"rt_factoryWest_n_0003",
				"rt_factoryWest_n_0002",
			},
			groupD = {
				"rt_factoryWest_n_0005",
				"rt_factoryWest_n_0007",
			},
		},
		caution = {
			groupA = {
				"rt_factoryWest_c_0003",
				"rt_factoryWest_c_0004",
				"rt_factoryWest_c_0000",
				"rt_factoryWest_c_0001",
				"rt_factoryWest_c_0002",
				"rt_factoryWest_c_0005",
				"rt_factoryWest_c_0006",
				"rt_factoryWest_c_0007",
			},
			nil
		},
		hold = {
			default = {
				"rt_factoryWest_h_0000",
				"rt_factoryWest_h_0001",
			},
		},
		sleep = {
			default = {
				"rt_factoryWest_s_0000",
				"rt_factoryWest_s_0001",	
			},
		},
		travel = {
			lrrp_factory1 = {
				"rt_lrrp_factory",
			},
			lrrp_factory2 = {
				"rt_lrrp_factory_back",
			},
			lrrp_factory3 = {
				"rt_lrrp_factory_change",
			},
		},
		outofrain = {
			"rt_factoryWest_r_0000",
			"rt_factoryWest_r_0001",
			"rt_factoryWest_r_0002",
			"rt_factoryWest_r_0003",
			"rt_factoryWest_r_0004",
			"rt_factoryWest_r_0005",
        },		
		nil
	},
	mafr_factorySouth_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_factorySouth_d_0000_sub",
				"rt_factorySouth_d_0001",
			},
			groupB = {
				"rt_factorySouth_d_0002",
				"rt_factorySouth_d_0003",
			},
			groupC = {
				"rt_factorySouth_d_0004",
				"rt_factorySouth_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_factorySouth_n_0000_sub",
				"rt_factorySouth_n_0001",
			},
			groupB = {
				"rt_factorySouth_n_0002",
				"rt_factorySouth_n_0003",
			},
			groupC = {
				"rt_factorySouth_n_0004",
				"rt_factorySouth_n_0004",
			},
		},
		caution = {
			groupA = {
				"rt_factorySouth_c_0000_sub",
				"rt_factorySouth_c_0001",
				"rt_factorySouth_c_0002",
				"rt_factorySouth_c_0003",
				"rt_factorySouth_c_0004",
				"rt_factorySouth_c_0004",
				"rt_factorySouth_c_0005",
				"rt_factorySouth_c_0005",
			},
			groupB = {
			},
			groupC = {
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_factorySouth_s_0000",
				"rt_factorySouth_s_0001",			
			},
		},
		travel = {
			lrrp_factorySouth1 = {
				"rt_lrrp_factorySouth",
			},
			lrrp_factorySouth2 = {
				"rt_lrrp_factorySouth_back",
			},
		},
		outofrain = {
			"rt_factorySouth_r_0000",
			"rt_factorySouth_r_0001",
			"rt_factorySouth_r_0002",
			"rt_factorySouth_r_0003",
			"rt_factorySouth_r_0004",
			"rt_factorySouth_r_0005",
        },	
		nil,
	},
	mafr_hill_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_hill_d_0001",
				"rt_hill_d_0007",
				"rt_hill_d_0004",
			},
			groupB = {
				"rt_hill_d_0000",
				"rt_hill_d_0002",
				"rt_hill_d_0010",
			},
			groupC = {
				"rt_hill_d_0006",
				"rt_hill_d_0009",
				"rt_hill_d_0003",
			},
		},
		sneak_night = {
			groupA = {
				"rt_hill_n_0001_sub",
				"rt_hill_n_0007",
				"rt_hill_n_0010",
			},
			groupB = {
				"rt_hill_n_0000_sub",
				"rt_hill_n_0002",
				"rt_hill_n_0009",
			},
			groupC = {
				"rt_hill_n_0008",
				"rt_hill_n_0004",
				"rt_hill_n_0003",
			},
		},
		caution = {
			groupA = {
				"rt_hill_c_0001",
				"rt_hill_c_0000",
				"rt_hill_c_0002",
				"rt_hill_c_0003",
				"rt_hill_c_0004",
				"rt_hill_c_0006",
				"rt_hill_c_0007",
				"rt_hill_c_0009",
				"rt_hill_c_0010",
				"rt_hill_c_0011",
			},
			groupB = {},
			groupC = {},
			nil
		},
		hold = {
			default = {
				"rt_hill_h_0000",
				"rt_hill_h_0001",
				"rt_hill_h_0002",
			},
		},
		sleep = {
			default = {
				"rt_hill_s_0000",
				"rt_hill_s_0001",
				"rt_hill_s_0002",
			},
		},
		travel = {
			lrrp_hill = {
				"rt_lrrp_hill",
			},
		},
		outofrain = {
			"rt_hill_r_0000",
			"rt_hill_r_0001",
			"rt_hill_r_0002",
			"rt_hill_r_0003",
			"rt_hill_r_0004",
			"rt_hill_r_0005",
			"rt_hill_r_0006",
			"rt_hill_r_0007",
			"rt_hill_r_0008",
			"rt_hill_r_0009",
			"rt_hill_r_0010",
			"rt_hill_r_0011",
        },		
		nil,
	},
	mafr_hillNorth_ob = {
		priority = {
			"groupA"
		},
		sneak_day = {
			groupA = {
				"rt_hillNorth_d_0000",
				"rt_hillNorth_d_0001",
				"rt_hillNorth_d_0002",
				"rt_hillNorth_d_0003",
				"rt_hillNorth_d_0004",
				"rt_hillNorth_d_0005",
				"rt_hillNorth_d_0006",
				"rt_hillNorth_d_0007",
			},
			nil
		},
		sneak_night = {
			groupA = {
				"rt_hillNorth_n_0000",
				"rt_hillNorth_n_0001",
				"rt_hillNorth_n_0002",
				"rt_hillNorth_n_0003",
				"rt_hillNorth_n_0004",
				"rt_hillNorth_n_0005",
				"rt_hillNorth_n_0006",
				"rt_hillNorth_n_0007",
			},
			nil
		},
		caution = {
			groupA = {
				"rt_hillNorth_c_0000",
				"rt_hillNorth_c_0001",
				"rt_hillNorth_c_0002",
				"rt_hillNorth_c_0003",
				"rt_hillNorth_c_0004",
				"rt_hillNorth_c_0005",
				"rt_hillNorth_c_0006",
				"rt_hillNorth_c_0007",
			},
			nil
		},
		hold = {
			default = {
			},
		},
		nil,
	},
	mafr_14_27_lrrp = { USE_COMMON_ROUTE_SETS = true,	},
	
	mafr_27_30_lrrp = { USE_COMMON_ROUTE_SETS = true,	},
	nil,
}

this.syncRouteTable = {
        SyncRoute = {
                "rts_Fire_fW",
                "rts_Fire_fW2",
        },
}






this.routeTable = {
	factorySouth = {
		conversationTable = { "rt_factorySouth_d_0004",	"rt_factorySouth_n_0003", },
	},
	factory_gate = {
		conversationTable = { "rt_factoryWest_d_0005",		"rt_factoryWest_n_0005", },
	},
	factory_tunnel = {
		conversationTable = { "rt_factoryWest_d_0000",		"rt_factoryWest_n_0000", },
	},
}




this.combatSetting = {
	mafr_hill_cp = {
		USE_COMMON_COMBAT = true,
	},
	mafr_factoryWest_ob = {
		
		"gt_factoryWest_0000",
		
		"gt_factoryWest_0001",
		
		"gt_factoryWest_0002",
	},
	mafr_factorySouth_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_hillNorth_ob = {
		USE_COMMON_COMBAT = true,
	},
}





this.UniqueInterStart_sol_mis_hill_0005 = function( soldier2GameObjectId, cpID )
	Fox.Log("CallBack : Unique : start "..svars.hill_JinmonNum )
	
	svars.hill_JinmonNum = svars.hill_JinmonNum + 1
	if svars.hill_JinmonNum > 2 then 
		svars.hill_JinmonNum = 3
	end
	if svars.hill_JinmonNum == 1 then
		TppInterrogation.UniqueInterrogation( cpID, "enqt1000_100546")
	elseif svars.hill_JinmonNum == 2 then
		TppInterrogation.UniqueInterrogation( cpID, "enqt1000_100545")
	else
		return false
	end

	return true
end

this.UniqueInterStart_sol_mis_factorySouth_0004 = function( soldier2GameObjectId, cpID )
	Fox.Log("CallBack : Unique : start "..svars.fS_JinmonNum )
	
	svars.fS_JinmonNum = svars.fS_JinmonNum + 1
	if svars.isGetIntel == true then
		svars.fS_JinmonNum = 2
	end
	if svars.fS_JinmonNum > 1 then 
		svars.fS_JinmonNum = 2
	end
	if svars.fS_JinmonNum == 1 and svars.isGetIntel == false then
		TppInterrogation.UniqueInterrogation( cpID, "enqt1000_100542")
		TppMission.UpdateObjective{
				objectives = { "area_Intel_factorySouth" },
		}   
	else
		return false
	end

	return true
end


this.uniqueInterrogation = {
	unique = {
		{ name = "enqt1000_100546", func = this.UniqueInterEnd_sol_mis_hill_0005, },
		{ name = "enqt1000_100545", func = this.UniqueInterEnd_sol_mis_hill_0005, },
		{ name = "enqt1000_100542", func = this.UniqueInterEnd_sol_mis_factorySouth_0004, },		
		nil
	},
	uniqueChara = {
		{ name = "sol_mis_hill_0008", func = this.UniqueInterStart_sol_mis_hill_0005, },
		{ name = "sol_mis_factorySouth_0002", func = this.UniqueInterStart_sol_mis_factorySouth_0004, },
		nil
	},
	nil
}

















this.travelPlans = {

	lrrp_01 = {
		
		{ cp="mafr_hill_cp", 			routeGroup={ "travel", "lrrp_hill" } },
		{ cp="mafr_17_27_lrrp", 		routeGroup={ "travel", "lrrp_v_17to27" } },
		{ cp="mafr_factorySouth_ob", 	routeGroup={ "travel", "lrrp_factorySouth1" } },
	},
	lrrp_02 = {
		
		{ cp="mafr_factorySouth_ob", 	routeGroup={ "travel", "lrrp_factorySouth2" } },
		{ cp="mafr_17_28_lrrp", 		routeGroup={ "travel", "lrrp_v_17to28" } },
		{ cp="mafr_factoryWest_ob", 		routeGroup={ "travel", "lrrp_factory1" } },
	},
	lrrp_03 = {
		
		{ cp="mafr_factoryWest_ob", 		routeGroup={ "travel", "lrrp_factory2" } },
	},
	lrrp_04 = {
		
		{ cp="mafr_factoryWest_ob", 		routeGroup={ "travel", "lrrp_factory3" } },
	},
	
	













}




function this.Travel_hill_factorySouth()
	Fox.Log("Travel_hill_factorySouth")
	local gameObjectId = GameObject.GetGameObjectId("sol_vip_lrrp_0000")
	local cmdCP = { id = "StartTravel", travelPlan="lrrp_01", keepInAlert=true }
	GameObject.SendCommand( gameObjectId, cmdCP )
end

function this.Travel_factorySouth_factory()
	Fox.Log("Travel_factorySouth_factory")
	local gameObjectId = GameObject.GetGameObjectId("sol_vip_lrrp_0000")
	local cmdCP = { id = "StartTravel", travelPlan="lrrp_02", }
	GameObject.SendCommand( gameObjectId, cmdCP )
end

function this.Travel_factory()
	Fox.Log("Travel_factory")
	local gameObjectId = GameObject.GetGameObjectId("sol_vip_lrrp_0000")
	local cmdCP = { id = "StartTravel", travelPlan="lrrp_03", keepInAlert=true }
	GameObject.SendCommand( gameObjectId, cmdCP )
end

function this.Travel_factory_change_day()
	Fox.Log("Travel_factory_change")
	local friendenemyId = s10110_enemy.CheckRouteUsingSoldier("rt_factoryWest_d_0000")
	local cmdCP = { id = "StartTravel", travelPlan="lrrp_04", keepInAlert=true }
	GameObject.SendCommand( friendenemyId, cmdCP )
end

function this.Travel_factory_change_night()
	Fox.Log("Travel_factory_change")
	local friendenemyId = s10110_enemy.CheckRouteUsingSoldier("rt_factoryWest_n_0000")
	local cmdCP = { id = "StartTravel", travelPlan="lrrp_04", keepInAlert=true }
	GameObject.SendCommand( friendenemyId, cmdCP )
end



this.CheckRouteUsingSoldier = function( routeName )
	local gameObjectId = { type="TppSoldier2" } 
	local command = { id="GetGameObjectIdUsingRoute", route=routeName }
	local soldiers = GameObject.SendCommand( gameObjectId, command )
	return soldiers[1]
end






this.InitEnemy = function ()
	Fox.Log("*** s10110_enemy.InitEnemy() ***")
	
	
	TppEnemy.NoShifhtChangeGruopSetting( "mafr_factoryWest_ob", "groupB" )
	TppEnemy.NoShifhtChangeGruopSetting( "mafr_factoryWest_ob", "groupC" )
	

end



this.SetUpEnemy = function ()

	Fox.Log("*** s10110_enemy.SetUpEnemy() ***")	
	
	this.SetVehicleSpawn( this.VEHICLE_SPAWN_LIST )
	
	this.SetRelativeTruck()	
	
	local gameObjectId = { type="TppCommandPost2", index=0 }
	local routes = {
		"rt_factoryWest_d_0000",
		"rt_factoryWest_d_0001",
		"rt_factoryWest_d_0002",
		"rt_factoryWest_d_0003",
		"rt_factoryWest_d_0004",
		"rt_factoryWest_d_0005",
		"rt_factoryWest_d_0006",
		"rt_factoryWest_d_0007",
		"rt_factoryWest_n_0000",
		"rt_factoryWest_n_0001",
		"rt_factoryWest_n_0002",
		"rt_factoryWest_n_0003",
		"rt_factoryWest_n_0004",
		"rt_factoryWest_n_0005",
		"rt_factoryWest_n_0006",
		"rt_factoryWest_n_0007",
		"rts_Conversation_fS",
		"rts_Conversation_fW1",
		"rts_Conversation_fW2",
		"rt_lrrp_hill",
		"rt_v_17to27_0000",
		"rt_lrrp_factorySouth",
		"rt_lrrp_factorySouth_back",
		"rt_lrrp_factory",
		"rt_lrrp_factory_back",
		"rt_lrrp_factory_change",
	}
	local command = { id="SetRouteExcludeChat", routes=routes, enabled=false }
	GameObject.SendCommand( gameObjectId, command )
	
	TppPlaced.SetCorrelationValueByLocatorName( "itm_Decoy_fW_0000", 3 )
	TppPlaced.SetCorrelationValueByLocatorName( "itm_Decoy_fW_0001", 3 )
	TppPlaced.SetCorrelationValueByLocatorName( "itm_Decoy_fW_0002", 3 )
	TppPlaced.SetCorrelationValueByLocatorName( "itm_Decoy_fW_0003", 3 )
	
	
	TppEnemy.RegisterCombatSetting( this.combatSetting )
	
	this.RegisterCombatAreaSetting()

end


this.OnLoad = function ()

	Fox.Log("*** s10110_enemy.OnLoad() ***")

end






this.SetVehicleSpawn = function( spawnList )
	Fox.Log("*** SetVehicleSpawn ***")
	for i, command in ipairs( spawnList ) do
		GameObject.SendCommand( { type="TppVehicle2", }, command )
	end
end

this.SetRelativeTruck = function()
	local soldierName = "sol_vip_lrrp_0000"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "Vehicle2Locator0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false }
	GameObject.SendCommand( soldierId, command )
end


this.RegisterCombatAreaSetting = function ()
	local gameObjectId = { type="TppCommandPost2" } 
	local combatAreaList = {
		
		area1 = {
			{ guardTargetName="gt_factoryWest_0000", locatorSetName="",}, 
		},
		area2 = {
			{ guardTargetName="gt_factoryWest_0001", locatorSetName="",},
		},
		area3 = {
			{ guardTargetName="gt_factoryWest_0002", locatorSetName="",},
		},
	}
	local command = { id = "SetCombatArea", cpName="mafr_factoryWest_ob", combatAreaList=combatAreaList }
	GameObject.SendCommand( gameObjectId, command )
end




return this
