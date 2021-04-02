local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}


local spawnList = {
       { id = "Spawn", locator = "veh_s10082_0000", type = Vehicle.type.WESTERN_TRUCK,
		subType = Vehicle.subType.WESTERN_TRUCK_CARGO_ITEM_BOX, paintType=Vehicle.paintType.FOVA_0 },		
}
local WalkerGearList = {"wkr_WalkerGear_0000", "wkr_WalkerGear_0001", "wkr_WalkerGear_0002", "wkr_WalkerGear_0003",}
local HOSTAGE_00 = "hos_s10082_0000"
local HOSTAGE_01 = "hos_s10082_0001"





this.WALKERGEAR_NAME = { 
	TARGET_WALKERGEAR00 = "wkr_WalkerGear_0000",	
	TARGET_WALKERGEAR01 = "wkr_WalkerGear_0001",	
	TARGET_WALKERGEAR02 = "wkr_WalkerGear_0002",	
	TARGET_WALKERGEAR03 = "wkr_WalkerGear_0003",	
}


this.vehicleDefine = {
       instanceCount   = #spawnList,
}





this.soldierDefine = {
		
	mafr_savannah_cp = {
		"sol_savannah_0000",
		"sol_savannah_0001",
		"sol_savannah_0002",
		"sol_savannah_0003",
		"sol_savannah_0004",
		"sol_savannah_0005",
		"sol_savannah_0006",
		"sol_savannah_0007",
		"sol_savannah_0008",
		"sol_savannah_0009",
		"sol_savannah_0010",
		"sol_savannah_0011",
		"sol_savannah_0012",
		"sol_savannah_0013",
		nil
	},
	
	mafr_savannahEast_ob = {
		"sol_savannahEast_0000",
		"sol_savannahEast_0001",
		"sol_savannahEast_0002",
		"sol_savannahEast_0003",
		"sol_savannahEast_0004",
		nil
	},
	
	mafr_savannahWest_ob = {
		"sol_savannahWest_0000",
		"sol_savannahWest_0001",
		"sol_savannahWest_0002",
		"sol_savannahWest_0003",
		"sol_savannahWest_0004",
		"sol_savannahWest_0005",
		nil
	},
	
	mafr_swampEast_ob = {
		"sol_swampEast_0000",
		"sol_swampEast_0001",
		"sol_swampEast_0002",
		"sol_swampEast_0003",
		"sol_swampEast_0004",
		"sol_swampEast_0005",
		"sol_swampEast_0006",
		nil
	},
	
	mafr_pfCampNorth_ob = {
		"sol_pfCampNorth_0000",
		"sol_pfCampNorth_0001",
		"sol_pfCampNorth_0002",
		nil
	},
	
	
	mafr_06_16_lrrp = {
		"sol_06_16_0000",
		"sol_06_16_0001",
		lrrpTravelPlan = "travel_swampEast_pfCampNorth",	
		nil
	},
	
		
	mafr_06_24_lrrp = {
		nil
	},
	
	
	mafr_07_24_lrrp = {
		"sol_07_24_0000",
		"sol_07_24_0001",
		lrrpTravelPlan = "travel_savannahWest_savannah", 
		nil
	},
	
	
	mafr_13_24_lrrp = {
		"sol_13_24_0000",
		"sol_13_24_0001",
		lrrpTravelPlan = "travel_savannahEast_savannah", 
		nil
	},
	nil
}







this.USE_COMMON_REINFORCE_PLAN = true





this.routeSets = {

		
	

		
	mafr_savannah_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rts_sol_WG_guard0000",
				"rts_sol_WG_guard0001",
				"rt_savannah_d_0012",
				"rt_savannah_d_0013",
				"rt_savannah_d_0000",
				"rt_savannah_d_0001",
				"rt_savannah_d_0002",
				"rt_savannah_d_0003",
			},
			groupB = {
				"rt_savannah_d_0004",
				"rt_savannah_d_0005",
				"rt_savannah_d_0006",
				"rt_savannah_d_0007",
			},
			groupC = {
				"rt_savannah_d_0008",
				"rt_savannah_d_0009",
				"rt_savannah_d_0010",
				"rt_savannah_d_0011",
			},
		},
		sneak_night = {
			groupA = {
				"rts_sol_WG_guard_n_0000",
				"rts_sol_WG_guard_n_0001",
				"rt_savannah_n_0012",
				"rt_savannah_n_0013",
				"rt_savannah_n_0000_sub",
				"rt_savannah_n_0001",
				"rt_savannah_n_0002",
				"rt_savannah_n_0003",
			},
			groupB = {
				"rt_savannah_n_0004",
				"rt_savannah_n_0005",
				"rt_savannah_n_0006_sub",
				"rt_savannah_n_0007_sub",
			},
			groupC = {
				"rt_savannah_n_0008",
				"rt_savannah_n_0009",
				"rt_savannah_n_0010",
				"rt_savannah_n_0011_sub",
			},
		},
		caution = {
			groupA = {
				"rts_sol_WG_guard0000",
				"rts_sol_WG_guard0001",
				"rt_savannah_c_0000",
				"rt_savannah_c_0001",
				"rt_savannah_c_0002",
				"rt_savannah_c_0003",
				"rt_savannah_c_0004",
				"rt_savannah_c_0005",
				"rt_savannah_c_0006",
				"rt_savannah_c_0007",
				"rt_savannah_c_0008",
				"rt_savannah_c_0009",
				"rt_savannah_c_0010",
				"rt_savannah_c_0011",
				"rt_savannah_c_0012",
				"rt_savannah_c_0013",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
				"rt_savannah_h_0000",
				"rt_savannah_h_0001",
				"rt_savannah_h_0002",
				"rt_savannah_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_savannah_s_0000",
				"rt_savannah_s_0001",
				"rt_savannah_s_0002",
				"rt_savannah_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_savannah_l_0000",
				"rt_savannah_l_0001",
			},
		},
		walkergearpark = {
				"rts_savannah_walkergearpark0000",
				"rts_savannah_walkergearpark0001",
				"rts_savannah_walkergearpark0002",
				"rts_savannah_walkergearpark0003",
		},
		nil
	},
	
	mafr_savannahEast_ob = { USE_COMMON_ROUTE_SETS = true,	},
	mafr_savannahWest_ob = { USE_COMMON_ROUTE_SETS = true,	},
	mafr_swampEast_ob =	{ USE_COMMON_ROUTE_SETS = true,	},
	mafr_pfCampNorth_ob = { USE_COMMON_ROUTE_SETS = true, },
	mafr_06_16_lrrp = { USE_COMMON_ROUTE_SETS = true, },
	mafr_06_24_lrrp = { USE_COMMON_ROUTE_SETS = true, },
	mafr_07_24_lrrp = { USE_COMMON_ROUTE_SETS = true, },
	mafr_13_24_lrrp = { USE_COMMON_ROUTE_SETS = true, },
    nil
}





this.travelPlans = {
	
	travel_swampEast_pfCampNorth = {
		{ base = "mafr_swampEast_ob", },
		{ base = "mafr_pfCampNorth_ob", },
	},
	
	travel_savannahWest_savannah = {
		{ base = "mafr_savannah_cp", },
		{ base = "mafr_savannahWest_ob", },
	},
	
	travel_savannahEast_savannah = {
		{ base = "mafr_savannah_cp", },
		{ base = "mafr_savannahEast_ob", },
	},
}




this.combatSetting = {




	mafr_savannahEast_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_savannahWest_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_swampEast_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_pfCampNorth_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_savannah_cp = {
		"gts_s10082_0000",
		"cs_savannah_0000",
	},
	
	nil
}






this.InterCall_sol_savannah00 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_xxx")
	TppMission.UpdateObjective{
				
				objectives = { "on_hostage_00",}
			}
end


this.InterCall_sol_savannah01 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_xxx")
	TppMission.UpdateObjective{
				
				objectives = { "on_hostage_01",}
			}
end

this.interrogation = {
	
	mafr_savannah_cp = {
	
		high = {
			{ name = "enqt1000_1i1210", func = this.InterCall_sol_savannah00, },
			{ name = "enqt1000_1i1310", func = this.InterCall_sol_savannah01, },
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

mafr_savannah_cp = true, 
nil
}






this.InitEnemy = function ()
end



this.SetUpEnemy = function ()
	TppEnemy.RegisterCombatSetting( this.combatSetting )

	
	TppEnemy.SetEliminateTargets{ "wkr_WalkerGear_0000", "wkr_WalkerGear_0001", "wkr_WalkerGear_0002", "wkr_WalkerGear_0003" }
	
	TppEnemy.RegistHoldRecoveredState( "hos_s10082_0000" )
	TppEnemy.RegistHoldRecoveredState( "hos_s10082_0001" )
	TppEnemy.RegistHoldRecoveredState( "veh_s10082_0000" )

	
	this.SpawnVehicleOninitialize()
	
	this.SetColoringWalkerGear()
	
	this.SetAllEnemyStaffParam()
	
	this.SetHostageLangType00()
	this.SetHostageLangType01()
end


this.OnLoad = function ()
	Fox.Log("*** s10211 onload ***")
end






this.SpawnVehicleOninitialize = function()
        TppEnemy.SpawnVehicles( spawnList )
end

this.SetColoringWalkerGear = function()
	for i, walkergearName in pairs(WalkerGearList) do
		local walkergearid = GameObject.GetGameObjectId( "TppCommonWalkerGear2", walkergearName )
		local command = { id = "SetColoringType", type = 2 }
		GameObject.SendCommand( walkergearid, command )
	end
end


this.SetAllEnemyStaffParam = function ()
	TppEnemy.AssignUniqueStaffType{
		
        locaterName = "hos_s10082_0000",
        uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10082_HOSTAGE_B,
        alreadyExistParam = { staffTypeId =4, randomRangeId =6, skill ="HaulageEngineer" },
	}
	
	TppEnemy.AssignUniqueStaffType{
		
        locaterName = "hos_s10082_0001",
        uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10082_HOSTAGE_A,
        alreadyExistParam = { staffTypeId =3, randomRangeId =6, skill ="ElectricEngineer" },
	}
end


this.SetHostageLangType00 = function()
	local gameObjectId = GameObject.GetGameObjectId( "hos_s10082_0000" )
	local command = { id = "SetLangType", langType="afrikaans" }
	GameObject.SendCommand( gameObjectId, command )
end

this.SetHostageLangType01 = function()
	local gameObjectId = GameObject.GetGameObjectId( "hos_s10082_0001" )
	local command = { id = "SetLangType", langType="afrikaans" }
	GameObject.SendCommand( gameObjectId, command )
end



return this
