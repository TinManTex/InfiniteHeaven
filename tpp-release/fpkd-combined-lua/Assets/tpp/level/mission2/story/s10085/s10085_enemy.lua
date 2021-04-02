local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local NULL_ID = GameObject.NULL_ID

this.requires = {}





this.CHECKPOINT_REINFORCE_SOLDIER_1_NAME = "sol_checkpoint_0000"
this.CHECKPOINT_REINFORCE_SOLDIER_2_NAME = "sol_checkpoint_0001"

this.TENT_GUARD_SOLDIER_1_NAME = "sol_tentGuard_0000"
this.TENT_GUARD_SOLDIER_2_NAME = "sol_tentGuard_0001"
this.TENT_BACK_SOLDIER_NAME = "sol_factorySouth_tentBack"

this.INTERROGATOR_SOLDIER_1_NAME = "sol_interrogator_0000"
this.INTERROGATOR_SOLDIER_2_NAME = "sol_interrogator_0001"
this.HILL_GUARD_CONV_SOLDIER_NAME = "sol_hillGuard_conversation"

local HILL_VEHICLE_NAME		= "veh_s10085_LV1"
local CHECKPOINT_VEHICLE_NAME = "veh_s10085_LV2"

this.TRAVEL_TYPE = { HILL_TO_WAIT = 0, WAIT_TO_FACTORYSOUTH =  1, FACTORYSOUTH_TO_HILL = 2 }


local FLEE_HOSTAGE_NAME = "hos_target_0000"
local CONVOY_HOSTAGE_NAME = "hos_target_0001"


this.INTERROGATION_TYPE = {
	CONVOY = "enqt1000_096344",		
	NUBIAN = "enqt1000_107057",		
	PLANT = "enqt1000_107051",		
	BIRD = "enqt1000_107048",		
}





this.soldierDefine = {
	
	mafr_hillNorth_ob = {
		"sol_hillNorth_0000",
		"sol_hillNorth_0001",
		"sol_hillNorth_0002",
		"sol_hillNorth_0003",
		"sol_hillNorth_0004",
		"sol_hillNorth_0005",
		nil,
	},
	
	mafr_hillWest_ob = {
		"sol_hillWest_0000",
		"sol_hillWest_0001",
		"sol_hillWest_0002",
		"sol_hillWest_0003",
		"sol_hillWest_0004",
		"sol_hillWest_0005",
		nil,
	},
	
	mafr_hill_cp = {
		"sol_hill_0000",
		"sol_hill_0001",
		"sol_hill_0002",
		"sol_hill_0003",
		"sol_hill_0004",
		"sol_hill_0005",
		"sol_hill_0006",
		"sol_hill_0007",
		"sol_hill_0008",
		"sol_hill_0009",
		this.INTERROGATOR_SOLDIER_1_NAME,
		this.INTERROGATOR_SOLDIER_2_NAME,
		this.HILL_GUARD_CONV_SOLDIER_NAME,
		nil,
	},
	
	mafr_hillWestNear_ob = {
		"sol_hillWestNear_0000",
		"sol_hillWestNear_0001",
		"sol_hillWestNear_0002",
		"sol_hillWestNear_0003",
		"sol_hillWestNear_0004",
		"sol_hillWestNear_0005",
		nil,
	},
	
	
	s10085_interrogator_cp = {
		"sol_factorySouth_0000",
		"sol_factorySouth_0001",
		"sol_factorySouth_0002",
		"sol_factorySouth_0003",
		"sol_factorySouth_0004",
		this.TENT_BACK_SOLDIER_NAME,
		this.TENT_GUARD_SOLDIER_1_NAME,
		this.TENT_GUARD_SOLDIER_2_NAME,
		this.CHECKPOINT_REINFORCE_SOLDIER_1_NAME,
		this.CHECKPOINT_REINFORCE_SOLDIER_2_NAME,
		nil,
	},
	
	
	mafr_17_27_lrrp = {
		nil,
	},
	mafr_27_30_lrrp = {
		nil,
	},

	nil,
}


this.soldierSubTypes = {
	
	PF_C = {
		this.soldierDefine.s10085_interrogator_cp,
	},
}





this.routeSets = {
	s10085_interrogator_cp = {
		priority = {
			"groupSniper",
			"groupA",
			"groupB",
			"groupC",
		},
		fixedShiftChangeGroup = {
			"groupSniper",          
		},
		sneak_day = {
			groupSniper = {
				{ "rts_factorySouth_snp_0000", attr = "SNIPER" },
				{ "rts_factorySouth_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rts_factorySouth_0000_sub",
				"rts_factorySouth_0001",
			},
			groupB = {
				"rts_factorySouth_0002",
				"rts_factorySouth_0003",
			},
			groupC = {
				"rts_factorySouth_0004",
				"rts_factorySouth_0000",
			},
			nil
		},
		sneak_night = {
			groupSniper = {
				{ "rts_factorySouth_snp_0000", attr = "SNIPER" },
				{ "rts_factorySouth_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rts_factorySouth_n_0000_sub",
				"rts_factorySouth_n_0001",
			},
			groupB = {
				"rts_factorySouth_n_0002",	
				"rts_factorySouth_n_0002",	
			},
			groupC = {
				"rts_factorySouth_n_0003",
				"rts_factorySouth_n_0002",
			},
			nil
		},
		caution = {
			groupSniper = {
				{ "rts_factorySouth_snp_0000", attr = "SNIPER" },
				{ "rts_factorySouth_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rts_factorySouth_c_0000_sub",
				"rts_factorySouth_c_0001",
				"rts_factorySouth_c_0002",
				"rts_factorySouth_c_0003",
				"rts_factorySouth_c_0004",
				"rts_factorySouth_c_0001",
			},
			groupB = {				
			},
			groupC = {				
			},
			nil
		},
		hold = {
			default = {
				"rt_factorySouth_h_0000",
				"rt_factorySouth_h_0001",			
			},
		},
		sleep = {
			default = {
				"rt_factorySouth_s_0000",
				"rt_factorySouth_s_0001",			
			},
		},
		travel = {
			lrrp_hillToFactorySouth = {
				"rts_veh_toFactorySouth",
				"rts_veh_toFactorySouth",
			},
			lrrp_factorySouthToHill = {
				"rts_veh_fromFactorySouth",
				"rts_veh_fromFactorySouth",
				"rts_veh_fromFactorySouth",
			},
		},
		nil
	},
	
	mafr_hillNorth_ob		= {
		USE_COMMON_ROUTE_SETS = true,
	},

	
	mafr_17_27_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_hillToFactorySouth = {
				"rts_veh_17_27_lrrp_factorySouth",
				"rts_veh_17_27_lrrp_factorySouth",
			},
			lrrp_factorySouthToHill = {
				"rts_veh_17_27_lrrp_Hill",
				"rts_veh_17_27_lrrp_Hill",
				"rts_veh_17_27_lrrp_Hill",
			},
		},
		nil,
	},

	mafr_hill_cp			= {
		
		outofrain = {
			"rt_hill_r_0000",
			"rt_hill_r_0001",
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
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_hillToFactorySouth = {
				"rts_veh_fromHill",
				"rts_veh_fromHill",
			},
			lrrp_factorySouthToHill = {
				"rts_veh_toHill",
				"rts_veh_toHill",
				"rts_veh_toHill",
			},
		},
	},
	
	mafr_hillWest_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	mafr_hillWestNear_ob	= { USE_COMMON_ROUTE_SETS = true,	},
	mafr_27_30_lrrp			= {	USE_COMMON_ROUTE_SETS = true,	},
	nil
}


this.USE_COMMON_REINFORCE_PLAN = true





this.travelPlans = {
	
	travel_hillToWaitBeforeFactorySouth = {
		ONE_WAY = true,
		{ cp = "mafr_hill_cp", 				routeGroup={ "travel", "lrrp_hillToFactorySouth" } },
		{ cp = "mafr_17_27_lrrp", 			routeGroup={ "travel", "lrrp_hillToFactorySouth" } },
		{ cp = "mafr_17_27_lrrp" },
	},
	
	travel_waitToFactorySouth = {
		ONE_WAY = true,
		{ cp = "s10085_interrogator_cp", 	routeGroup={ "travel", "lrrp_hillToFactorySouth" } },
		{ cp = "s10085_interrogator_cp" },
	},
	
	travel_factorySouthToHill = {
		ONE_WAY = true,
		{ cp = "s10085_interrogator_cp", 	routeGroup={ "travel", "lrrp_factorySouthToHill" } },
		{ cp = "mafr_17_27_lrrp", 			routeGroup={ "travel", "lrrp_factorySouthToHill" } },
		{ cp = "mafr_hill_cp", 				routeGroup={ "travel", "lrrp_factorySouthToHill" } },	
		{ cp = "mafr_hill_cp" },	
	},
}

this.StartTravelPlan = function( soldierTable, travelOption )
	local travelPlanName = "travel_factorySouthToHill"
	if travelOption == this.TRAVEL_TYPE.WAIT_TO_FACTORYSOUTH then
		travelPlanName = "travel_waitToFactorySouth"
	elseif travelOption == this.TRAVEL_TYPE.HILL_TO_WAIT then
		travelPlanName = "travel_hillToWaitBeforeFactorySouth"
	end
	local command = { id = "StartTravel", travelPlan = travelPlanName, keepInAlert=true }
	for i, soldierName in pairs( soldierTable ) do
		local gameObjectId = GameObject.GetGameObjectId( soldierName )
		if gameObjectId ~= NULL_ID then
			GameObject.SendCommand( gameObjectId, command )
		end
	end
end

this.FinishTravelPlan = function( soldierTable )
	local command = { id = "StartTravel", travelPlan = "", keepInAlert=false }
	for i, soldierName in pairs( soldierTable ) do
		local gameObjectId = GameObject.GetGameObjectId( soldierName )
		if gameObjectId ~= NULL_ID then
			GameObject.SendCommand( gameObjectId, command )
		end
	end
end





this.cpGroups = {
	group_Area3 = {
		
		"s10085_interrogator_cp",
	},
}





this.combatSetting = {
	s10085_interrogator_cp = {
		"gt_s10085_tent",
		"cs_s10085_tent",
	},
	mafr_hill_cp = {
		USE_COMMON_COMBAT = true,
	},
	mafr_hillNorth_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_hillWest_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_hillWestNear_ob = {
		USE_COMMON_COMBAT = true,
	},
	nil
}







this.InterCall_ConvoyPosition = function( soldier2GameObjectId, cpID, interName )	
	Fox.Log("CallBack : InterCall_ConvoyPosition")
	TppMission.UpdateObjective{
		objectives = { "Area_hosTarget_convoy", nil  },
	}
	
	if svars.isFleeHostageRescued then
		TppMission.UpdateObjective{
			objectives = { "clear_Area_hosTarget_flee" },
		}
	end
	
	svars.isConvoyPositionKnown = true
	
	s10085_radio.OptionalRadioRescueOneHostage()
	
	s10085_sequence.RemoveMissionInterrogation( this.INTERROGATION_TYPE.CONVOY, this.InterCall_ConvoyPosition )
	return true
end

this.InterCall_Nubian = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_Nubian")
	TppMission.UpdateObjective{
		objectives = { "Area_task_nubian", nil  },
	}
	
	s10085_sequence.RemoveMissionInterrogation( this.INTERROGATION_TYPE.NUBIAN, this.InterCall_Nubian )
	return true
end

this.InterCall_Plant = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_Plant")
	TppMission.UpdateObjective{
		objectives = { "Area_task_plant", nil  },
	}
	
	s10085_sequence.RemoveMissionInterrogation( this.INTERROGATION_TYPE.PLANT, this.InterCall_Plant )
	return true
end

this.InterCall_Bird = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_Bird")
	TppMission.UpdateObjective{
		objectives = { "Area_task_bird", nil  },
	}
	
	s10085_sequence.RemoveMissionInterrogation( this.INTERROGATION_TYPE.BIRD, this.InterCall_Bird )
	return true
end


this.interrogation = {
	s10085_interrogator_cp = {
		
		high = {
			{ name = this.INTERROGATION_TYPE.CONVOY, func = this.InterCall_ConvoyPosition, },		
			{ name = this.INTERROGATION_TYPE.NUBIAN, func = this.InterCall_Nubian, },				
			{ name = this.INTERROGATION_TYPE.PLANT, func = this.InterCall_Plant, },				
			{ name = this.INTERROGATION_TYPE.BIRD, func = this.InterCall_Bird, },					
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	mafr_hill_cp = {
		
		high = {
			{ name = this.INTERROGATION_TYPE.CONVOY, func = this.InterCall_ConvoyPosition, },		
			{ name = this.INTERROGATION_TYPE.NUBIAN, func = this.InterCall_Nubian, },				
			{ name = this.INTERROGATION_TYPE.PLANT, func = this.InterCall_Plant, },				
			{ name = this.INTERROGATION_TYPE.BIRD, func = this.InterCall_Bird, },					
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	mafr_hillNorth_ob = {
		
		high = {
			{ name = this.INTERROGATION_TYPE.CONVOY, func = this.InterCall_ConvoyPosition, },		
			{ name = this.INTERROGATION_TYPE.NUBIAN, func = this.InterCall_Nubian, },				
			{ name = this.INTERROGATION_TYPE.PLANT, func = this.InterCall_Plant, },				
			{ name = this.INTERROGATION_TYPE.BIRD, func = this.InterCall_Bird, },					
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	mafr_hillWest_ob = {
		
		high = {
			{ name = this.INTERROGATION_TYPE.CONVOY, func = this.InterCall_ConvoyPosition, },		
			{ name = this.INTERROGATION_TYPE.NUBIAN, func = this.InterCall_Nubian, },				
			{ name = this.INTERROGATION_TYPE.PLANT, func = this.InterCall_Plant, },				
			{ name = this.INTERROGATION_TYPE.BIRD, func = this.InterCall_Bird, },					
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	mafr_hillWestNear_ob = {
		
		high = {
			{ name = this.INTERROGATION_TYPE.CONVOY, func = this.InterCall_ConvoyPosition, },		
			{ name = this.INTERROGATION_TYPE.NUBIAN, func = this.InterCall_Nubian, },				
			{ name = this.INTERROGATION_TYPE.PLANT, func = this.InterCall_Plant, },				
			{ name = this.INTERROGATION_TYPE.BIRD, func = this.InterCall_Bird, },					
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	nil
}


this.useGeneInter = {
	s10085_interrogator_cp = true,	
	mafr_hill_cp = true,
	mafr_hillNorth_ob = true,
	mafr_hillWest_ob = true,
	mafr_hillWestNear_ob = true,
	nil
}





local spawnList = {
	{ id="Spawn", locator=HILL_VEHICLE_NAME, type=Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0 },
	{ id="Spawn", locator=CHECKPOINT_VEHICLE_NAME, type=Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0 },
}

this.vehicleDefine = {
	instanceCount = #spawnList + 1,	
}

this.SpawnVehicleOnInitialize = function()
        TppEnemy.SpawnVehicles( spawnList )
end






this.InitEnemy = function ()

	Fox.Log("*** s10085_enemy.InitEnemy() ***")

end



this.SetUpEnemy = function ()

	Fox.Log("*** s10085_enemy.SetUpEnemy() ***")

	TppEnemy.RegisterCombatSetting( this.combatSetting )
	
	
	TppEnemy.SetRescueTargets( { CONVOY_HOSTAGE_NAME, FLEE_HOSTAGE_NAME } )
	
	
	TppEnemy.RegistHoldRecoveredState( HILL_VEHICLE_NAME )
	TppEnemy.RegistHoldRecoveredState( CHECKPOINT_VEHICLE_NAME )
	
	
	TppEnemy.AssignUniqueStaffType{
		locaterName = FLEE_HOSTAGE_NAME,	
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10085_HOSTAGE,
		alreadyExistParam = { staffTypeId =61, randomRangeId =4, skill ="Physician" },
	}
	TppEnemy.AssignUniqueStaffType{
		locaterName = CONVOY_HOSTAGE_NAME,	
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10085_FEMALE_HOSTAGE,
		alreadyExistParam = { staffTypeId =61, randomRangeId =4, skill ="Counselor" },
	}
	
	
	this.SetHostageMovingNoticeTrap( CONVOY_HOSTAGE_NAME ) 
	
	
	
	s10085_sequence.SetSneakCautionRouteSoldier( this.INTERROGATOR_SOLDIER_1_NAME , "rts_veh_interrogator_idle_0000" )
	s10085_sequence.SetSneakCautionRouteSoldier( this.INTERROGATOR_SOLDIER_2_NAME , "rts_veh_interrogator_idle_0001" )
	
	TppEnemy.SetSneakRoute( this.TENT_GUARD_SOLDIER_1_NAME , "rts_tentGuard_0000" )
	TppEnemy.SetSneakRoute( this.TENT_GUARD_SOLDIER_2_NAME , "rts_tentGuard_0001" )
	TppEnemy.SetSneakRoute( this.TENT_BACK_SOLDIER_NAME , "rts_factorySouth_tentBack" )
	
	TppEnemy.SetCautionRouteSoldier( this.TENT_GUARD_SOLDIER_1_NAME , "rts_tentGuard_c_0000" )
	TppEnemy.SetCautionRouteSoldier( this.TENT_GUARD_SOLDIER_2_NAME , "rts_tentGuard_c_0001" )
	TppEnemy.SetCautionRouteSoldier( this.TENT_BACK_SOLDIER_NAME , "rts_factorySouth_tentBack_c" )
	
	s10085_sequence.SetSneakCautionRouteSoldier( this.CHECKPOINT_REINFORCE_SOLDIER_1_NAME , "rts_checkpoint_idle_0000" )
	s10085_sequence.SetSneakCautionRouteSoldier( this.CHECKPOINT_REINFORCE_SOLDIER_2_NAME , "rts_checkpoint_idle_0001" )
	
	TppEnemy.SetSneakRoute( this.HILL_GUARD_CONV_SOLDIER_NAME, "rts_hill_guardForConversation" )
	TppEnemy.SetCautionRoute( this.HILL_GUARD_CONV_SOLDIER_NAME, "rts_hill_guardForConversation_c" )

	
	this.SetEnemyVehicle( { this.INTERROGATOR_SOLDIER_1_NAME, this.INTERROGATOR_SOLDIER_2_NAME }, HILL_VEHICLE_NAME, true ) 
	this.SetEnemyVehicle( { this.CHECKPOINT_REINFORCE_SOLDIER_1_NAME, this.CHECKPOINT_REINFORCE_SOLDIER_2_NAME }, CHECKPOINT_VEHICLE_NAME, false )

	
	this.SetHostageLanguage( FLEE_HOSTAGE_NAME, "hostage_d" )
	this.SetHostageLanguage( CONVOY_HOSTAGE_NAME, "hostage_a" )
end


this.OnLoad = function ()

	Fox.Log("*** s10085_enemy.OnLoad() ***")

end


this.SetEnemyVehicle = function( soldierNameTable, vehicleName, isRideFromBegin )
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	for i, soldierName in pairs( soldierNameTable ) do
		local soldierId = GameObject.GetGameObjectId( soldierName )
		local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=isRideFromBegin }
		GameObject.SendCommand( soldierId, command )
	end
end


this.SetHostageMovingNoticeTrap = function( hostageName )
	local gameObjectId = GameObject.GetGameObjectId( hostageName )
	local command = { id = "SetMovingNoticeTrap", enable = true }
	GameObject.SendCommand( gameObjectId, command )
end


this.SetIgnoreNoticeExceptForPlayer = function( soldierName, isSet )
	local gameObjectId = GameObject.GetGameObjectId( soldierName )
	local command = { id="SetRestrictNotice", enabled = isSet }
	GameObject.SendCommand( gameObjectId, command )
end


this.SetHostageLanguage = function( hostageName, voiceTypeParam )
	local gameObjectId = GameObject.GetGameObjectId( hostageName )
	local langCommand = { id = "SetLangType", langType="english" }
	GameObject.SendCommand( gameObjectId, langCommand )
	local voiceCommand = { id = "SetVoiceType", voiceType = voiceTypeParam }
	GameObject.SendCommand( gameObjectId, voiceCommand )
end




return this
