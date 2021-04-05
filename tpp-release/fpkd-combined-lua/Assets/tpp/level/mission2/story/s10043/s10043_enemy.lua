local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local IsTypeFunc = Tpp.IsTypeFunc
local IsTypeTable = Tpp.IsTypeTable
local IsTypeString = Tpp.IsTypeString
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_ID

this.requires = {}






this.ENEMY_NAME = {
	VEHICLE					= "sol_vehicle_0000",					
	LRRP_01					= "sol_13_34_0000",						
	LRRP_02					= "sol_13_34_0001"						
}


this.ENEMY_LRRP_NAME_LIST = {
	this.ENEMY_NAME.LRRP_01,
	this.ENEMY_NAME.LRRP_02,
}


this.CP_NAME = {
	COMMFACILITY			= "afgh_commFacility_cp",
}


this.VEHICLE_NAME = {
	TRUCK					= "veh_truck_0000",						
}


this.UNIQUE_INTER_LIST = {
	LRRP_01					= "enqt1000_1f1k10",
	LRRP_02					= "enqt1000_1f1e10",
}


this.VEHICLE_SPAWN_LIST = {
	{ id = "Spawn", locator = this.VEHICLE_NAME.TRUCK, type = Vehicle.type.EASTERN_TRUCK, subType = Vehicle.subType.EASTERN_TRUCK_CARGO_MATERIAL, },
}






this.USE_COMMON_REINFORCE_PLAN = true


this.vehicleDefine = { instanceCount = 2 }


this.soldierPowerSettings = {
	sol_13_34_0000 = { "RADIO" },
	sol_13_34_0001 = { "RADIO" },
}





this.soldierDefine = {
	
	
	
	
	
	ms_13_34_ob = {
		this.ENEMY_NAME.LRRP_01,
		this.ENEMY_NAME.LRRP_02,
	},
	
	
	
	
	afgh_commFacility_cp = {
		"sol_commFacility_0000",
		"sol_commFacility_0001",
		"sol_commFacility_0002",
		"sol_commFacility_0003",
		"sol_commFacility_0004",
		"sol_commFacility_0005",
		"sol_commFacility_0006",
		"sol_commFacility_0007",
		"sol_commFacility_0008",
	},
	
	afgh_village_cp = {
		"sol_village_0000",
		"sol_village_0001",
		"sol_village_0002",
		"sol_village_0003",
		"sol_village_0004",
		"sol_village_0005",
		"sol_village_0006",
		"sol_village_0007",
	},
	
	
	
	
	
	afgh_ruinsNorth_ob = {
		"sol_ruinsNorth_0000",
		"sol_ruinsNorth_0001",
	},
	
	afgh_villageEast_ob = {
		"sol_villageEast_0000",
		"sol_villageEast_0001",
		"sol_villageEast_0002",
		"sol_villageEast_0003",
	},
	
	afgh_villageNorth_ob = {
		"sol_villageNorth_0000",
		"sol_villageNorth_0001",
		"sol_villageNorth_0002",
		"sol_villageNorth_0003",
	},
	
	afgh_commWest_ob = {
		"sol_commWest_0000",
		"sol_commWest_0001",
		"sol_commWest_0002",
		"sol_commWest_0003",
	},
	
	
	
	
	
	afgh_02_14_lrrp = {
		"sol_02_14_0000",
		"sol_02_14_0001",
		lrrpTravelPlan = "travelcommWest",
	},
	
	afgh_01_13_lrrp = {
		nil
	},
	
	afgh_01_32_lrrp = {
		"sol_01_32_0000",
		"sol_01_32_0001",
		lrrpTravelPlan = "travelvillageEast",
	},
	
	afgh_14_32_lrrp = {
		nil
	},
	
	afgh_02_34_lrrp = {
		nil
	},
	
	afgh_13_34_lrrp = {
		this.ENEMY_NAME.VEHICLE,
		lrrpTravelPlan	= "travelVehicle_",
		lrrpVehicle		= "veh_truck_0000",
	},
	
	
	
	
	
	quest_cp = {
		"sol_quest_0000",
		"sol_quest_0001",
		"sol_quest_0002",
		"sol_quest_0003",
		"sol_quest_0004",
		"sol_quest_0005",
		"sol_quest_0006",
		"sol_quest_0007",
		nil
	},
	
	nil
}





this.routeSets = {
	
	
	
	
	
	ms_13_34_ob = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_d_ene01_13to34_0000",
				"rts_d_ene02_13to34_0000",
			},
		},
		sneak_night = {
			groupA = {
				"rts_n_ene01_13to34_0000",
				"rts_n_ene02_13to34_0000",
			},
		},
		caution = {
			groupA = {
				"rts_d_ene01_13to34_0000",
				"rts_d_ene01_13to34_0000",
			},
		},
		hold = {
			default = {
			},
		},
		nil
	},
	
	
	
	
	
	afgh_village_cp = {
		USE_COMMON_ROUTE_SETS = true,
		sneak_day = {
			groupC = {
				"rts_village_d_0000",
				"rts_village_d_0001",
			},
		},
	},
	
	afgh_commFacility_cp = {
		USE_COMMON_ROUTE_SETS = true,
	},
	
	
	
	
	afgh_villageEast_ob = {
		USE_COMMON_ROUTE_SETS = true,
	},
	
	afgh_villageNorth_ob = {
		USE_COMMON_ROUTE_SETS = true,
	},
	
	afgh_commWest_ob = {
		USE_COMMON_ROUTE_SETS = true,
	},
	
	afgh_ruinsNorth_ob = {
		USE_COMMON_ROUTE_SETS = true,
	},
	
	
	
	
	
	afgh_01_13_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
	},
	
	afgh_01_32_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
	},
	
	afgh_14_32_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
	},
	
	afgh_02_14_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
	},
	
	afgh_02_34_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
	},
	
	afgh_13_34_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
	},
	
	
	
	
	
	quest_cp = {
		USE_COMMON_ROUTE_SETS = true,
	},
	
}





this.travelPlans = {
	
	
	travelCommFacility = {
		{ cp = "afgh_commFacility_cp",		routeGroup = { "travel", 					"in_lrrpHold_E" }, },
		{ cp = "afgh_commFacility_cp", 		routeGroup = { "travel", "lrrpHold" }		},
		{ cp = "afgh_commFacility_cp",		routeGroup = { "travel", 					"out_lrrpHold_W" }, },
		{ cp = "afgh_02_34_lrrp", 			routeGroup = { "travel", "lrrp_34to02" }	},
		{ cp = "afgh_commWest_ob", 			routeGroup = { "travel", "lrrpHold" }		},
		{ cp = "afgh_02_34_lrrp", 			routeGroup = { "travel", "lrrp_02to34" }	},
		{ cp = "afgh_commFacility_cp",		routeGroup = { "travel", 					"in_lrrpHold_W" }, },
		{ cp = "afgh_commFacility_cp", 		routeGroup = { "travel", "lrrpHold" }		},
		{ cp = "afgh_commFacility_cp",		routeGroup = { "travel", 					"out_lrrpHold_E" }, },
		{ cp = "afgh_13_34_lrrp", 			routeGroup = { "travel", "lrrp_34to13" }	},
		{ cp = "afgh_ruinsNorth_ob", 		routeGroup = { "travel", "lrrpHold" }		},
		{ cp = "afgh_13_34_lrrp", 			routeGroup = { "travel", "lrrp_13to34" }	},
	},
	
	
	travelVehicle_= {
		{ cp="afgh_13_34_lrrp",				routeGroup={ "travel", "lrrp_34to13" }, },
		{ cp="afgh_ruinsNorth_ob",			routeGroup={ "travel", 					"in_lrrpHold_N" }, },
		{ cp="afgh_ruinsNorth_ob",			routeGroup={ "travel", 					"out_lrrpHold_S" }, },
		{ cp="afgh_01_13_lrrp", 			routeGroup={ "travel", "lrrp_13to01" }, },
		{ cp="afgh_villageEast_ob", 		routeGroup={ "travel", 					"in_lrrpHold_E" }, },
		{ cp="afgh_villageEast_ob", 		routeGroup={ "travel", 					"out_lrrpHold_W" }, },
		{ cp="afgh_01_32_lrrp", 			routeGroup={ "travel", "lrrp_01to32" }, },
		{ cp="afgh_village_cp", 			routeGroup={ "travel", 					"in_lrrpHold_E" }, },
		{ cp="afgh_village_cp", 			routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_village_cp", 			routeGroup={ "travel", 					"out_lrrpHold_W" }, },
		{ cp="afgh_14_32_lrrp", 			routeGroup={ "travel", "lrrp_32to14" }, },
		{ cp="afgh_villageNorth_ob",		routeGroup={ "travel", 					"in_lrrpHold_S_E" }, },
		{ cp="afgh_villageNorth_ob",		routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_02_14_lrrp",				routeGroup={ "travel", "lrrp_14to02" }, },
		{ cp="afgh_commWest_ob",			routeGroup={ "travel", 					"in_lrrpHold_S_E" }, },
		{ cp="afgh_commWest_ob",			routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_02_34_lrrp",				routeGroup={ "travel", "lrrp_02to34" }, },
		{ cp="afgh_commFacility_cp",		routeGroup={ "travel", 					"in_lrrpHold_W" }, },
		{ cp="afgh_commFacility_cp",		routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_commFacility_cp",		routeGroup={ "travel", 					"out_lrrpHold_E" }, },
	},
	
	
	travelvillageEast = {
		{ base = "afgh_villageEast_ob", },
		{ base = "afgh_village_cp", },
		{ base = "afgh_villageNorth_ob", },
		{ base = "afgh_commWest_ob", },
		{ base = "afgh_villageNorth_ob", },
		{ base = "afgh_village_cp", },
	},
	
	
	travelcommWest = {
		{ base = "afgh_commWest_ob", },
		{ base = "afgh_villageNorth_ob", },
		{ base = "afgh_village_cp", },
		{ base = "afgh_villageEast_ob", },
		{ base = "afgh_village_cp", },
		{ base = "afgh_villageNorth_ob", },
	},
}





this.combatSetting = {
	
	ms_13_34_ob = {
		"gt_13_34_0000",
	},
	
	afgh_commFacility_cp = {
		USE_COMMON_COMBAT = true,
	},
	afgh_village_cp = {
		USE_COMMON_COMBAT = true,
	},
	
	afgh_ruinsNorth_ob = {
		USE_COMMON_COMBAT = true,
	},
	afgh_commWest_ob = {
		USE_COMMON_COMBAT = true,
	},
	afgh_villageEast_ob = {
		USE_COMMON_COMBAT = true,
	},
	afgh_villageNorth_ob = {
		USE_COMMON_COMBAT = true,
	},
	nil
}






this.cpGroups = {
	group_Area2 = {
		"ms_13_34_ob",
	}
}










this.UniqueInterStart_sol_lrrp_0000 = function( soldier2GameObjectId, cpID )
	Fox.Log("CallBack : UniqueInterStart_sol_lrrp_0000")
	if svars.isUniqueInterLrrp01 == false then
		svars.isUniqueInterLrrp01 = true
		TppInterrogation.UniqueInterrogation( cpID, "enqt1000_1f1k10" )
		return true
	end
	return false
end


this.UniqueInterEnd_sol_lrrp_0000 = function( soldier2GameObjectId, cpID )
	Fox.Log("CallBack : UniqueInterEnd_sol_lrrp_0000")
	TppMission.UpdateObjective{
		objectives = { "on_itm_s10043_diamond001" },
	}
end


this.UniqueInterStart_sol_lrrp_0001 = function( soldier2GameObjectId, cpID )
	Fox.Log("CallBack : UniqueInterStart_sol_lrrp_0001")
	if svars.isUniqueInterLrrp02 == false then
		svars.isUniqueInterLrrp02 = true
		TppInterrogation.UniqueInterrogation( cpID, "enqt1000_1f1e10" )
		return true
	end
	return false
end


this.UniqueInterEnd_sol_lrrp_0001 = function( soldier2GameObjectId, cpID )
	Fox.Log("CallBack : UniqueInterEnd_sol_lrrp_0001")
	if svars.isMarkCmmn == false then
		svars.isMarkCmmn = true
		local radioGroups = s10043_radio.GetInterrogationMarking()
		TppMission.UpdateObjective{
			radio = {
				radioGroups = radioGroups,
				radioOptions = { delayTime = "long" },
			},
			objectives = { "on_target_s10043_cmmn001" },
		}
	end
end






this.InterCall_hostage_001 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_hostage_001")
	TppMission.UpdateObjective{
		objectives = { "on_s10043_hostage001" },
	}
end


this.InterCall_hostage_002 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_hostage_002")
	TppMission.UpdateObjective{
		objectives = { "on_s10043_hostage002" },
	}
end


this.InterCall_ruinsNorth_grenade_001 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_ruins_north_grenade_001")
	TppMarker.Enable( "TppMarker2Locator_ms_ruinsNorth_grenade0001", 0, "none", "map_only_icon", 0, false, true )
end


this.InterCall_commFacility_grenade_001 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_commFacility_grenade_001")
	TppMarker.Enable( "TppMarker2Locator_ms_commFacility_grenade0001", 0, "none", "map_only_icon", 0, false, true )
end







this.uniqueInterrogation = {
	
	unique = {
		{ name = this.UNIQUE_INTER_LIST.LRRP_01,	func = this.UniqueInterEnd_sol_lrrp_0000,},			
		{ name = this.UNIQUE_INTER_LIST.LRRP_02,	func = this.UniqueInterEnd_sol_lrrp_0001,},			
	},
	
	uniqueChara = {
		{ name = this.ENEMY_NAME.LRRP_01,			func = this.UniqueInterStart_sol_lrrp_0000,},		
		{ name = this.ENEMY_NAME.LRRP_02,			func = this.UniqueInterStart_sol_lrrp_0001,},		
	},
}


this.interrogation = {
	
	afgh_commFacility_cp = {
		
		high = {
			nil
		},
		
		normal = {
			{ name = "enqt1000_1f1410",			func = this.InterCall_commFacility_grenade_001, },	
		},
		nil
	},
	afgh_village_cp = {
		
		high = {
			nil
		},
		
		normal = {
		},
		nil
	},
	
	afgh_ruinsNorth_ob = {
		
		high = {
			{ name = "enqt1000_1i1210",			func = this.InterCall_hostage_001, },				
			{ name = "enqt1000_1i1310",			func = this.InterCall_hostage_002, },				
		},
		
		normal = {
			nil
		},
		nil
	},
	nil
}


this.useGeneInter = {
	
	afgh_commFacility_cp		= true,
	afgh_village_cp				= true,
	
	afgh_ruinsNorth_ob			= true,
	afgh_commWest_ob			= true,
	afgh_villageEast_ob			= true,
	afgh_villageNorth_ob		= true,
	nil
}


this.HighInterrogation = function()
	Fox.Log("*** HighInterrogation ***")
	TppInterrogation.AddHighInterrogation(
		GameObject.GetGameObjectId( "afgh_ruinsNorth_ob" ),
		{ 
			{ name = "enqt1000_1i1210", func = this.InterCall_hostage_001, },
			{ name = "enqt1000_1i1310", func = this.InterCall_hostage_002, },
		}
	)
end

this.RemoveInterrogationHostage1 = function()
	TppInterrogation.RemoveHighInterrogation( 
		GameObject.GetGameObjectId("afgh_ruinsNorth_ob" ),
		{ 
			{ name = "enqt1000_1i1210", func = this.InterCall_hostage_001, },
		}
	)
end

this.RemoveInterrogationHostage2 = function()
	TppInterrogation.RemoveHighInterrogation( 
		GameObject.GetGameObjectId("afgh_ruinsNorth_ob" ),
		{ 
			{ name = "enqt1000_1i1310", func = this.InterCall_hostage_002, },
		}
	)
end




this.SpawnVehicleOnInitialize = function()
	Fox.Log("*** SetVehicleSpawn ***")
	TppEnemy.SpawnVehicles( this.VEHICLE_SPAWN_LIST )
end


this.InitEnemy = function()
	Fox.Log("*** s10043 InitEnemy ***")
end



this.SetUpEnemy = function()
	Fox.Log("*** s10043 SetUpEnemy ***")
	
	TppEnemy.RegisterCombatSetting( this.combatSetting )
	
	this.afgh_13_34_lrrp_Setup()
	
	this.HighInterrogation()
	
	this.SetUniqueStaffType()
	
	TppEnemy.SetupQuestEnemy()
	
	TppEnemy.RegistHoldRecoveredState( "hos_s10043_0000" )
	TppEnemy.RegistHoldRecoveredState( "hos_s10043_0001" )
end


this.OnLoad = function()
	Fox.Log("*** s10043 OnLoad ***")
end






this.afgh_13_34_lrrp_Setup = function()
	Fox.Log("*** afgh_13_34_lrrp_Setup ***")
	
	this.SetLrrp( this.ENEMY_LRRP_NAME_LIST )
	
	if svars.isMoveStart_afgh_13_34_lrrp == false then
		TppEnemy.SetDisable( this.ENEMY_NAME.LRRP_01 )
		TppEnemy.SetDisable( this.ENEMY_NAME.LRRP_02 )
	end
end


this.SetLrrp = function( enemyLrrpList )
	Fox.Log("*** SetLrrp ***")
	for j, enemyName in ipairs( enemyLrrpList ) do
		if IsTypeString( enemyName ) then
			enemyName = GetGameObjectId( enemyName )
		end
		local command = { id = "SetLrrp", }
		GameObject.SendCommand( enemyName, command )
	end
end





function this.CheckRouteChangecommFacility( param )
	Fox.Log("*** CheckRouteChangecommFacility ***")
	local routeName01 = "rt_commFacility_d_0006"
	local routeName02 = "rt_commFacility_d_0008"
	local gameObjectIdTable01 = s10043_enemy.GetGameObjectIdUsingRoute( routeName01 )
	local gameObjectIdTable02 = s10043_enemy.GetGameObjectIdUsingRoute( routeName02 )
	if #gameObjectIdTable01 > 0 and param == true then
		for i, soldier in ipairs(gameObjectIdTable01) do
			TppEnemy.SetSneakRoute( soldier, routeName02 )
		end
	elseif #gameObjectIdTable01 > 0 and param == false then
		for i, soldier in ipairs(gameObjectIdTable02) do
			TppEnemy.SetSneakRoute( soldier, routeName01 )
		end
	end
end






this.SetVehicleSpawn = function( spawnList )
	Fox.Log("*** SetVehicleSpawn ***")
	for i, command in ipairs( spawnList ) do
		GameObject.SendCommand( { type="TppVehicle2", }, command )
	end
end


this.SetRelativeVehicle = function( enemyName, vehicleName, isrideFromBeginning )
	Fox.Log("*** SetRelativeVehicle ***")
	if IsTypeString( enemyName ) then
		enemyName = GetGameObjectId( enemyName )
	end
	if enemyName == NULL_ID then
		Fox.Error("Cannot get gameObjectId. enemyName = " .. tostring(enemyName) )
		return
	end
	if IsTypeString( vehicleName ) then
		vehicleName = GetGameObjectId( vehicleName )
	end
	if vehicleName == NULL_ID then
		Fox.Error("Cannot get gameObjectId. vehicleName = " .. tostring(vehicleName) )
		return
	end
	isrideFromBeginning = isrideFromBeginning or false
	GameObject.SendCommand( enemyName, { id = "SetRelativeVehicle", targetId = vehicleName, rideFromBeginning = isrideFromBeginning } )
end


this.UnsetRelativeVehicle = function( enemyName )
	Fox.Log("*** UnsetRelativeVehicle ***")
	if IsTypeString( enemyName ) then
		enemyName = GetGameObjectId( enemyName )
	end
	if enemyName == NULL_ID then
		Fox.Error("Cannot get gameObjectId. enemyName = " .. tostring(enemyName) )
		return
	end
	GameObject.SendCommand( enemyName, { id = "UnsetRelativeVehicle" } )
end


this.SetUniqueStaffType = function()
	Fox.Log("*** SetUniqueStaffType ***")
	
	TppEnemy.AssignUniqueStaffType{
		locaterName			= "hos_s10043_0000",
		uniqueStaffTypeId	= TppDefine.UNIQUE_STAFF_TYPE_ID.S10043_HOSTAGE_A,
		alreadyExistParam	= { staffTypeId = 3, randomRangeId = 6, skill = "GunsmithShotGun" },
	}
	this.SetUpLanguage( "hos_s10043_0000", "pashto" )
	
	TppEnemy.AssignUniqueStaffType{
		locaterName			= "hos_s10043_0001",
		uniqueStaffTypeId	= TppDefine.UNIQUE_STAFF_TYPE_ID.S10043_HOSTAGE_B,
		alreadyExistParam	= { staffTypeId = 5, randomRangeId = 6, skill = "FultonExpert" },
	}
	this.SetUpLanguage( "hos_s10043_0001", "pashto" )
end


this.SetUpLanguage = function( s_gameObjectName, s_langType )
	local gameObjectId	= GameObject.GetGameObjectId( s_gameObjectName )
	local command		= { id = "SetLangType", langType = s_langType }
	GameObject.SendCommand( gameObjectId, command )
end






this.GetGameObjectIdUsingRoute = function( routeName )
	local gameObjectId = { type="TppSoldier2" } 
	local command = { id="GetGameObjectIdUsingRoute", route=routeName }
	local soldiers = GameObject.SendCommand( gameObjectId, command )
	Fox.Log( #soldiers )
	return soldiers
end




return this
