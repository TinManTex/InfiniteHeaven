local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}

local CONVOY_STATUS = Tpp.Enum{
	"CONVOY_OK",
}


this.USE_COMMON_REINFORCE_PLAN = true


this.SPENEMYNAME = {
	INTR_FAR01 = "sol_cliffTown_0000",
	INTR_FAR02 = "sol_cliffTown_0005",
	INTR_FAR03 = "sol_cliffTown_0010",
	
	
	INTR_FAR06 = "sol_cliffTown_0001",
	INTR_FAR07 = "sol_cliffTown_0006",
	
	INTR_FAR09 = "sol_cliffTown_0009",
	INTR_FAR10 = "sol_cliffTown_0002",
	INTR_FAR11 = "sol_cliffTown_0011",

	INTR_NEAR01 = "sol_cliffTown_0003",
	INTR_NEAR02 = "sol_cliffTown_0008",
}


this.INTERROGATE_FARPOINT = {
	"enqt1000_241a10",
	"enqt1000_251a10",
}


this.INTERROGATE_NEARPOINT = {
	"enqt1000_221a10",
	"enqt1000_231a10",
}

local spawnList_normal = {
		{ id="Spawn", locator="veh_truck", type=Vehicle.type.EASTERN_TRUCK, },
		{ id="Spawn", locator="veh_sensha", type=Vehicle.type.EASTERN_TRACKED_TANK, class = Vehicle.class.DEFAULT, },
		{ id="Spawn", locator="veh_sensha0000", type=Vehicle.type.EASTERN_TRACKED_TANK, class = Vehicle.class.DEFAULT, },
		{ id="Spawn", locator="veh_wheeledarmored", type=Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, subType=Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY, },
}

local spawnList_subsistence = {
		{ id="Spawn", locator="veh_truck", type=Vehicle.type.EASTERN_TRUCK, },
		{ id="Spawn", locator="veh_sensha", type=Vehicle.type.EASTERN_TRACKED_TANK, class = Vehicle.class.DEFAULT, },
		{ id="Spawn", locator="veh_sensha0000", type=Vehicle.type.EASTERN_TRACKED_TANK, class = Vehicle.class.DARK_GRAY, },
		{ id="Spawn", locator="veh_wheeledarmored", type=Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, subType=Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY, },
}

this.vehicleDefine = {
		instanceCount	= #spawnList_normal + 1,
}

this.SpawnVehicleOnInitialize = function()
		local missionName = TppMission.GetMissionName()

		if missionName == "s10044"	then
			TppEnemy.SpawnVehicles( spawnList_normal )
		elseif missionName == "s11044"	then
			TppEnemy.SpawnVehicles( spawnList_subsistence )
		end
end

this.soldierPowerSettings = {
		sol_enemyNorth_lvVIP = { "HELMET", "MG", "SOFT_ARMOR" },
}





this.soldierDefine = {
	
	afgh_cliffTown_cp = {
		"sol_cliffTown_0000",
		"sol_cliffTown_0001",
		"sol_cliffTown_0002",
		"sol_cliffTown_0003",
		"sol_cliffTown_0004",
		"sol_cliffTown_0005",
		"sol_cliffTown_0006",
		"sol_cliffTown_0007",
		"sol_cliffTown_0008",
		"sol_cliffTown_0009",
		"sol_cliffTown_0010",
		"sol_cliffTown_0011",
		"sol_cliffTown_0012",
		"sol_cliffTown_0013",
		nil
	},

	afgh_fort_cp = {
		"sol_fort_0000",
		"sol_fort_0001",
		"sol_fort_0002",
		"sol_fort_0003",
		"sol_fort_0004",
		"sol_fort_0005",
		"sol_fort_0006",
		"sol_fort_0007",
		nil
	},

	afgh_cliffWest_ob = {
		"sol_cliffWest_0000",
		"sol_cliffWest_0001",
		"sol_cliffWest_0002",
		"sol_cliffWest_0003",
		nil
	},

	afgh_cliffEast_ob = {
		"sol_cliffEast_0000",
		"sol_cliffEast_0001",
		"sol_cliffEast_0002",
		"sol_cliffEast_0003",
		nil
	},

	afgh_fortWest_ob = {
		"sol_fortWest_0000",
		"sol_fortWest_0001",
		"sol_fortWest_0002",
		"sol_fortWest_0003",
		nil
	},

	afgh_fortSouth_ob = {
		"sol_fortSouth_0000",
		"sol_fortSouth_0001",
		"sol_fortSouth_0002",
		"sol_fortSouth_0003",
		nil
	},

	afgh_enemyNorth_ob = {
		"sol_enemyNorth_0000",
		"sol_enemyNorth_0001",
		"sol_enemyNorth_0002",
		"sol_enemyNorth_0003",
		"sol_enemyNorth_lv0000",
		"sol_enemyNorth_lvVIP",
		"sol_enemyNorth_sensha",
		"sol_enemyNorth_sensha0000",
		nil
	},

	
	afgh_07_08_lrrp = { nil },
	afgh_08_23_lrrp = { nil },
	afgh_09_10_lrrp = { nil },
	afgh_09_23_lrrp = { nil },
	afgh_10_31_lrrp = { nil },
	afgh_12_31_lrrp = { nil },
	nil
}





this.routeSets = {

	afgh_enemyNorth_ob = {
		USE_COMMON_ROUTE_SETS = true,
	},
	afgh_07_08_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_cliffTown_rts_01 = {
				"rts_v_01_enemyNorth7_cliffWest8",
				"rts_v_01_enemyNorth7_cliffWest8",
				"rts_v_01_enemyNorth7_cliffWest8",
				"rts_v_01_enemyNorth7_cliffWest8",
				"rts_v_01_enemyNorth7_cliffWest8",
				"rts_v_01_enemyNorth7_cliffWest8",
			},
		},
	},
	afgh_cliffWest_ob = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_cliffTown_rts_01 = {
				"rts_v_02cliffWest8",
				"rts_v_02cliffWest8",
				"rts_v_02cliffWest8",
				"rts_v_02cliffWest8",
				"rts_v_02cliffWest8",
				"rts_v_02cliffWest8",
			},
		},
	},
	afgh_08_23_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_cliffTown_rts_01 = {
				"rts_v_03cliffWest8_cliffTown0023",
				"rts_v_03cliffWest8_cliffTown0023",
				"rts_v_03cliffWest8_cliffTown0023",
				"rts_v_03cliffWest8_cliffTown0023",
				"rts_v_03cliffWest8_cliffTown0023",
				"rts_v_03cliffWest8_cliffTown0023",
				"rts_v_03cliffWest8_cliffTown0023",
			},
		},
	},
	afgh_cliffTown_cp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_fort_rts_01 = {
				"rts_v_04cliffTown23",
				"rts_v_04cliffTown23",
				"rts_v_04cliffTown23",
				"rts_v_04cliffTown23",
				"rts_v_04cliffTown23",
				"rts_v_04cliffTown23",
			},
		},
	},
	afgh_09_23_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_fort_rts_01 = {
				"rts_v_05cliffTown23_cliffEast9",
				"rts_v_05cliffTown23_cliffEast9",
				"rts_v_05cliffTown23_cliffEast9",
				"rts_v_05cliffTown23_cliffEast9",
				"rts_v_05cliffTown23_cliffEast9",
				"rts_v_05cliffTown23_cliffEast9",
			},
		},
	},
	afgh_cliffEast_ob = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_fort_rts_01 = {
				"rts_v_06cliffEast9",
				"rts_v_06cliffEast9",
				"rts_v_06cliffEast9",
				"rts_v_06cliffEast9",
				"rts_v_06cliffEast9",
				"rts_v_06cliffEast9",
			},
		},
	},
	afgh_09_10_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_fort_rts_01 = {
				"rts_v_07cliffEast9_fortWest10",
				"rts_v_07cliffEast9_fortWest10",
				"rts_v_07cliffEast9_fortWest10",
				"rts_v_07cliffEast9_fortWest10",
				"rts_v_07cliffEast9_fortWest10",
				"rts_v_07cliffEast9_fortWest10",
			},
		},
	},
	afgh_fortWest_ob = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_fort_rts_01 = {
				"rts_v_08fortWest10",
				"rts_v_08fortWest10",
				"rts_v_08fortWest10",
				"rts_v_08fortWest10",
				"rts_v_08fortWest10",
				"rts_v_08fortWest10",
			},
		},
	},
	afgh_10_31_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_fort_rts_01 = {
				"rts_v_09fortWest10_fort31",
				"rts_v_09fortWest10_fort31",
				"rts_v_09fortWest10_fort31",
				"rts_v_09fortWest10_fort31",
				"rts_v_09fortWest10_fort31",
				"rts_v_09fortWest10_fort31",
			},
		},
	},
	afgh_fort_cp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_fort_rts_01 = {
				"rts_v_10fort31",
				"rts_v_10fort31",
				"rts_v_10fort31",
				"rts_v_10fort31",
				"rts_v_10fort31",
				"rts_v_10fort31",
			},
		},
	},
	afgh_fortSouth_ob = {
		USE_COMMON_ROUTE_SETS = true,
	},
	afgh_12_31_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
	},
	nil
}





this.travelPlans = {

	travel_tofort = {
		ONE_WAY = true,
		{ cp = "afgh_07_08_lrrp",			routeGroup={ "travel", "lrrp_cliffTown_rts_01" } },
		{ cp = "afgh_cliffWest_ob",			routeGroup={ "travel", "lrrp_cliffTown_rts_01" } },
		{ cp = "afgh_08_23_lrrp",			routeGroup={ "travel", "lrrp_cliffTown_rts_01" } },
		{ cp = "afgh_cliffTown_cp",			routeGroup={ "travel", "lrrp_fort_rts_01" } },
		{ cp = "afgh_09_23_lrrp",			routeGroup={ "travel", "lrrp_fort_rts_01" } },
		{ cp = "afgh_cliffEast_ob",			routeGroup={ "travel", "lrrp_fort_rts_01" } },
		{ cp = "afgh_09_10_lrrp",			routeGroup={ "travel", "lrrp_fort_rts_01" } },
		{ cp = "afgh_fortWest_ob",			routeGroup={ "travel", "lrrp_fort_rts_01" } },
		{ cp = "afgh_10_31_lrrp",			routeGroup={ "travel", "lrrp_fort_rts_01" } },
		{ cp = "afgh_fort_cp",				routeGroup={ "travel", "lrrp_fort_rts_01" } },
		{ cp="afgh_fort_cp",		finishTravel = true },		
	},
	travel_infort = {
		ONE_WAY = true,
		{ cp="afgh_fort_cp",		finishTravel = true },		
	},
}

this.StartConvoyTofort = function()

	if svars.isFlagForC == true then	
		return
	end
	svars.isFlagForC = true	

	
	local ConvoyGroup = {
		"sol_enemyNorth_sensha",
		"sol_enemyNorth_sensha0000",
		"sol_enemyNorth_lv0000",
		"sol_enemyNorth_lvVIP",
	}

	for i,enemyName in pairs (ConvoyGroup) do
		local command = { id = "StartTravel", travelPlan = "travel_tofort", keepInAlert=true }
		local gameObjectId = GameObject.GetGameObjectId(enemyName)
		GameObject.SendCommand( gameObjectId, command )
		TppEnemy.UnsetSneakRoute( gameObjectId )
	end

end





this.combatSetting = {
	afgh_cliffTown_cp = {
		"gt_cliffTown_0000",
		"cs_cliffTown_0000",
	},
	afgh_enemyNorth_ob = {
		"gt_enemyNorth_0000",
	},
	afgh_cliffEast_ob = {
		"gt_cliffEast_0000",
	},
	afgh_cliffWest_ob = {
		"gt_cliffWest_0000",
	},
	afgh_fortSouth_ob = {
		"gt_fortSouth_0000",
	},
	afgh_fortWest_ob = {
		"gt_fortWest_0000",
	},
	afgh_fort_cp = {
		"gt_fort_0000",
		"cs_fort_0000",
	},
	nil
}




this.SetEnemyHelmet = function ( soldierName )
	local GetGameObjectId = GameObject.GetGameObjectId
	local gameObjectId = GetGameObjectId("TppSoldier2", soldierName)
	local command = { id = "SetWearEquip", flag = WearEquip.HELMET }
	local lifeState = 	GameObject.SendCommand( gameObjectId, command )
end





this.uniqueInterStart_Inter_Far = function( soldier2GameObjectId, cpID )
	Fox.Log("Interrogation:I don't know where VIP is. But Perhaps they know that.")

	svars.UniqueInterCount_FarPoint = svars.UniqueInterCount_FarPoint + 1
	local isNoMoreInter = false

	if svars.UniqueInterCount_FarPoint <= table.maxn(this.INTERROGATE_FARPOINT) then
		Fox.Log( "svars:"..svars.UniqueInterCount_FarPoint )
		Fox.Log( "table:"..table.maxn(this.INTERROGATE_FARPOINT) )
		Fox.Log( "string:"..this.INTERROGATE_FARPOINT[svars.UniqueInterCount_FarPoint])
		TppInterrogation.UniqueInterrogation( cpID, this.INTERROGATE_FARPOINT[svars.UniqueInterCount_FarPoint] )
		isNoMoreInter = true
	else
		isNoMoreInter = false
	end
	return isNoMoreInter
end


this.uniqueInterStart_Inter_Near = function( soldier2GameObjectId, cpID )
	Fox.Log("Interrogation:VIP isn't here.")

	svars.UniqueInterCount_NearPoint = svars.UniqueInterCount_NearPoint + 1
	local isNoMoreInter = false

	if svars.UniqueInterCount_NearPoint <= table.maxn(this.INTERROGATE_NEARPOINT) then
		TppInterrogation.UniqueInterrogation( cpID, this.INTERROGATE_NEARPOINT[svars.UniqueInterCount_NearPoint] )
		isNoMoreInter = true
	else
		isNoMoreInter = false
	end
	return isNoMoreInter
end

this.uniqueInterEnd_Inter_Far = function( soldier2GameObjectId, cpID, interName )
		Fox.Log("Update information. Perhaps he knows more information.")
end


this.uniqueInterEnd_Inter_Near = function( soldier2GameObjectId, cpID, interName )
		Fox.Log("Update information. VIP isn't here.")
end

this.uniqueInterEnd_Inter_Near_Finished = function( soldier2GameObjectId, cpID, interName )
		
		Fox.Log("Update information. VIP left from here for reinforcement.")
		TppRadio.SetOptionalRadio( "Set_s0044_oprg0030" )
end


this.useGeneInter = {
	afgh_fort_cp = true,
	afgh_cliffTown_cp = true,
	
	afgh_cliffEast_ob = true,
	afgh_cliffWest_ob = true,
	afgh_enemyNorth_ob = true,
	afgh_fortSouth_ob = true,
	afgh_fortWest_ob = true,
	nil
}

this.uniqueInterEnd_Inter_Far_Finished = function( soldier2GameObjectId, cpID, interName )
		
		Fox.Log("Update information. The VIP's house is obvious.")

		TppMission.UpdateObjective{
			objectives = { "marker_infomation_jinmon" }
		}
		TppRadio.ChangeIntelRadio( s10044_radio.intelRadioListAfterInterrogation )				
		
		
		

		TppRadioCommand.UnregisterRadioGroupFromActiveRadioGroupSet( "s0044_oprg0080" )	

		svars.isThisHappened01	=	true		
end

this.InterCall_Convoy = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("inter: Convoy :"..soldier2GameObjectId )
	s10044_radio.PlayAboutBattleVehicle()
	TppMission.UpdateObjective{
		objectives = { "marker_battleVehicle" }
	}
end

this.InterCall_Hostage = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("inter: hostage :"..soldier2GameObjectId )
	
	
	TppMission.UpdateObjective{
		objectives = {	"marker_hostage" },
	}
end

this.interrogation = {
	
	afgh_cliffTown_cp = {
		high = {
			{ name = this.INTERROGATE_FARPOINT[2], func = this.uniqueInterEnd_Inter_Far_Finished, }, 
			{ name = "enqt1000_1c1010", func = this.InterCall_Convoy, },
			{ name = "enqt1000_1i1210", func = this.InterCall_Hostage, },
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
	
	
	
	if TppMission.IsMissionStart() then
		TppInterrogation.AddHighInterrogation(GameObject.GetGameObjectId( "afgh_cliffTown_cp" ),
			{
				{ name = this.INTERROGATE_FARPOINT[2], func = this.uniqueInterEnd_Inter_Far_Finished, }, 
				{ name = "enqt1000_1c1010", func = this.InterCall_Convoy, },
				{ name = "enqt1000_1i1210", func = this.InterCall_Hostage, },
			}
		)
	end
end

this.RemoveInterrogation = function()
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("afgh_cliffTown_cp" ),
		{
			{ name = this.INTERROGATE_FARPOINT[2], func = this.uniqueInterEnd_Inter_Far_Finished, }, 
		}
	)
end

local VehicleGroup = {
	sol_enemyNorth_sensha	= "rts_enemyNorth_sensha",
	sol_enemyNorth_sensha0000	= "rts_enemyNorth_sensha0000",
	sol_enemyNorth_lv0000 = "rts_enemyNorth_lv0000",
	sol_enemyNorth_lvVIP	= "rts_enemyNorth_lv0001",
}
this.setUpEnemyNorth = function()

	for enemyName,routeName in pairs (VehicleGroup) do
		TppEnemy.SetSneakRoute(enemyName,routeName)
		TppEnemy.SetCautionRoute(enemyName,routeName)
	end
end


this.RegistHoldRecoveredStateForMissionTask = function( targetList )
	Fox.Log("###*** MissionTask register beginning ***")
	for index, targetName in pairs(targetList) do
		TppEnemy.RegistHoldRecoveredState( targetName )
	end
end

this.Escort = function(label)
		Fox.Log("#### Escort  ####")
		local soldierName = "sol_enemyNorth_sensha"
		local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
		local VehicleName = "veh_truck"
		local VehicleId = GameObject.GetGameObjectId("TppVehicle2", VehicleName )
		local command = { id="SetCommandAi", commandType = CommandAi.ESCORT, vehicle = VehicleId, formationIndex = 2 }
		GameObject.SendCommand( soldierId, command )

		local soldierName = "sol_enemyNorth_sensha0000"
		local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
		local command = { id="SetCommandAi", commandType = CommandAi.ESCORT, vehicle = VehicleId, formationIndex = 2 }
		GameObject.SendCommand( soldierId, command )

		local soldierName = "sol_enemyNorth_lv0000"
		local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
		local command = { id="SetCommandAi", commandType = CommandAi.ESCORT, vehicle = VehicleId, formationIndex = 2 }
		GameObject.SendCommand( soldierId, command )

		local soldierName = "sol_enemyNorth_lvVIP"
		local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
		local command = { id="SetCommandAi", commandType = CommandAi.ESCORT, vehicle = VehicleId, formationIndex = 2 }
		GameObject.SendCommand( soldierId, command )
end



this.SetUpHostageLanguage = function ()
	Fox.Log("###***SetUpLanguage_for_Hostage! RUSSIAN ####")
	local gameObjectId = GameObject.GetGameObjectId( "hos_s10044_0000" )
	local setLanguage = { id = "SetLangType", langType="russian" }
	

	GameObject.SendCommand( gameObjectId, setLanguage )
	
end






this.InitEnemy = function ()
end


this.SetAllEnemyStaffParam = function ()
	Fox.Log("#### s10044_enemy.SetAllStaffParam ####")

	TppEnemy.AssignUniqueStaffType{
		locaterName = "sol_enemyNorth_lvVIP",
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10044_CLIFFTOWN_VIP,
		alreadyExistParam = { staffTypeId =52, randomRangeId =4, skill ="Lucky" }, 
	}
	TppEnemy.AssignUniqueStaffType{
		locaterName = "hos_s10044_0000",
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10044_CLIFFTOWN_HOSTAGE,
		alreadyExistParam = { staffTypeId =2, randomRangeId =6, skill ="FultonExpert" }, 
	}
end

this.SetUpEnemy = function ()
		Fox.Log("############ s10044 SetUpEnemy ############")
		TppEnemy.RegisterCombatSetting( this.combatSetting )

		
		TppEnemy.SetEliminateTargets{ "sol_enemyNorth_lvVIP","veh_sensha","veh_sensha0000" }

		this.SetAllEnemyStaffParam()

		this.setUpEnemyNorth()

		this.HighInterrogation()

		
		
		local targetList = {
			"sol_enemyNorth_lvVIP",
			"hos_s10044_0000",
			"veh_sensha",
			"veh_sensha0000",
		}

		this.RegistHoldRecoveredStateForMissionTask( targetList )

			
		this.SetUpHostageLanguage()
			
		local soldierName = "sol_enemyNorth_sensha"
		local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
		local vehicleName = "veh_sensha"
		local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
		local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=true }
		GameObject.SendCommand( soldierId, command )

		local soldierName = "sol_enemyNorth_sensha0000"
		local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
		local vehicleName = "veh_sensha0000"
		local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
		local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=true }
		GameObject.SendCommand( soldierId, command )

		local soldierName = "sol_enemyNorth_lv0000"
		local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
		local vehicleName = "veh_truck"
		local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
		local command = { id="SetRelativeVehicle", targetId=vehicleId,	isVigilance=true }
		GameObject.SendCommand( soldierId, command )

		local soldierName = "sol_enemyNorth_lvVIP"
		local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
		local vehicleName = "veh_truck"
		local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
		local command = { id="SetRelativeVehicle", targetId=vehicleId,	isVigilance=true }
		GameObject.SendCommand( soldierId, command )

		local gameObjectId = { type="TppCommandPost2", index=0 }
		local routes = {
				"rt_cliffTown_d_0001",
				"rt_cliffTown_d_0001_no_tower_sub",
				"rt_cliffTown_d_0001_tower",
				"rt_cliffTown_d_0002",
				"rt_cliffTown_d_0012",
		}
		local command = { id="SetRouteExcludeChat", routes=routes, enabled=false }
		GameObject.SendCommand( gameObjectId, command )

		
		do
				
				local fovas = {
						{ name= "sol_enemyNorth_lvVIP", faceId=606, bodyId=258 }
				}

				
				for i,fova in ipairs(fovas) do
						local gameObjectId = GameObject.GetGameObjectId( fova.name )
						local command = { id = "ChangeFova", faceId = fova.faceId, bodyId = fova.bodyId }
						if gameObjectId ~= GameObject.NULL_ID then
								GameObject.SendCommand( gameObjectId, command )
						else
								Fox.Error( "Fova setting is failed. because " .. fova.name .. " is not found." )
						end
				end

		end
end


this.OnLoad = function ()
	Fox.Log("*** s10044 onload ***")
end




return this
