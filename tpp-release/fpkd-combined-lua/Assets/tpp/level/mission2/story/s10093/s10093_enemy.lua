local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.DEBUG_strCode32List = {
	"sol_lab_0001",
	"sol_lab_0002",
	"sol_lab_0003",
	"sol_lab_0004",
	"sol_lab_0005",
	"sol_lab_0006",
	"sol_lab_0007",
	"sol_lab_0008",
	"sol_lab_0009",
	"sol_lab_0010",
	"sol_lab_0011",
	"sol_lab_0012",
	"sol_lab_0013",
	"sol_lab_0014",
	"sol_lab_0015",
	"sol_lab_0016",
	"sol_labWest_0001",
	"sol_labWest_0002",
	"sol_labWest_0003",
	"sol_labWest_0004",
	"sol_labWest_0005",
	"sol_labWest_0006",
	"sol_19_29_0001",
	"sol_19_29_0002",
	"groupA",
	"groupB",
}


local HELI_ROUTE_PATROL = "rts_s10093_heli_0000"


local BIRD_OBJECT_ID01 = "s10093_rvn_0000"






this.USE_COMMON_REINFORCE_PLAN = true





this.VEHICLE_SPAWN_LIST = {
	{ id = "Spawn", locator = "veh_s10093_0000", type = Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType = Vehicle.paintType.FOVA_0, },
}

this.vehicleDefine = {
	instanceCount = #this.VEHICLE_SPAWN_LIST + 1,
}





this.soldierDefine = {
	
	mafr_lab_cp = {
		"sol_vip_0000",
		"sol_lab_0001",
		"sol_lab_0002",
		"sol_lab_0003",
		"sol_lab_0004",
		"sol_lab_0005",
		"sol_lab_0006",
		"sol_lab_0007",
		"sol_lab_0008",
		"sol_lab_0009",
		"sol_lab_0010",
		"sol_lab_0011",
		"sol_lab_0012",
		"sol_lab_0013",
		"sol_lab_0014",
		"sol_lab_0015",
		"sol_lab_0016",
		nil
	},
	mafr_labJungle_cp = {
		"sol_labJungle_0001",
		"sol_labJungle_0002",
		"sol_labJungle_0003",
		"sol_labJungle_0004",
		"sol_labJungle_0005",
		"sol_labJungle_0006",
		"sol_labJungle_0007",
		"sol_labJungle_0008",
		nil
	},
	
	mafr_labWest_ob = {
		"sol_labWest_0001",
		"sol_labWest_0002",
		"sol_labWest_0003",
		"sol_labWest_0004",
		"sol_labWest_0005",
		"sol_labWest_0006",
		nil
	},
	mafr_diamondNorth_ob = {
		nil
	},
	
	mafr_19_29_lrrp = {
		"sol_19_29_0001",
		"sol_19_29_0002",
		lrrpTravelPlan = "travelLab01", 
		lrrpVehicle = "veh_s10093_0000", 
		nil
	},
	
	mafr_18_19_lrrp = {
		nil
	},

	nil
}

this.soldierPowerSettings = {
	sol_vip_0000 = { },
	sol_labJungle_0001 = { "ARMOR" },
	sol_labJungle_0002 = { "ARMOR" },
	sol_labJungle_0003 = { "ARMOR" },
	sol_labJungle_0004 = { "ARMOR" },
	sol_labJungle_0005 = { "ARMOR" },
	sol_labJungle_0006 = { "ARMOR" },
	sol_labJungle_0007 = { "ARMOR" },
	sol_labJungle_0008 = { "ARMOR" },
	sol_lab_0013 = { "ARMOR" },
	sol_lab_0014 = { "ARMOR" },
	sol_lab_0015 = { "ARMOR" },
	sol_lab_0016 = { "ARMOR" },
}


this.soldierSubTypes = {
	
	PF_B = {
		this.soldierDefine.mafr_labJungle_cp,	
	},
}


this.taskTargetList = {
	"sol_vip_0000",
}


this.routeSets = {
	
	
	
	mafr_lab_cp			= { USE_COMMON_ROUTE_SETS = true,
		priority = {
			"vip",		
			"groupA",
			"groupB",
			"groupC",
			"groupD",
			"groupE",
			nil
		},
		fixedShiftChangeGroup = {
			"vip",
		},
		sneak_day = {
			vip = {
				{ "rts_10093_d_0000", attr = "VIP" },
			},
		},
		sneak_night= {
			vip = {
				{ "rts_10093_n_0000", attr = "VIP" },
			},
		},
		caution = {
			vip = {
				{ "rts_10093_c_0000", attr = "VIP" },
			},
		},
		hold = {
			default = {
				{ "rts_10093_h_0000", attr = "VIP" },
				"rt_lab_h_0000",
				"rt_lab_h_0001",
				"rt_lab_h_0002",
				"rt_lab_h_0003",
			},
		},
		sleep = {
			default = {
				{ "rts_10093_s_0000", attr = "VIP" },
				"rt_lab_s_0000",
				"rt_lab_s_0001",
				"rt_lab_s_0002",
				"rt_lab_s_0003",
			},
		},
		travel = {
			MovingSupportOut = {
				"rts_labJungle_Out_0000",
				"rts_labJungle_Out_0001",
				"rts_labJungle_Out_0002",
				"rts_labJungle_Out_0003",
			},
		},
		nil
	},
	mafr_labJungle_cp = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rts_lab_a_010_0007",
				"rts_lab_a_020_0017",
				"rts_lab_a_030_0014",
				"rts_lab_a_040_0008",
				"rts_lab_a_050_0016",
				"rts_lab_a_060_0015",
			},
			groupB = {
				"rts_lab_a_015_0009",
				"rts_lab_a_025_0010",
				"rts_lab_a_035_0021",
				"rts_lab_a_045_0018",
				"rts_lab_a_055_0019",
				"rts_lab_a_065_0020",
			},
		},
		sneak_night = {
			groupA = {
				"rts_lab_a_010_0007",
				"rts_lab_a_020_0017",
				"rts_lab_a_030_0014",
				"rts_lab_a_04x_0001",
				"rts_lab_a_050_0016",
				"rts_lab_a_060_0015",
			},
			groupB = {
				"rts_lab_a_015_0009",
				"rts_lab_a_025_0010",
				"rts_lab_a_035_0021",
				"rts_lab_a_04x_0001",
				"rts_lab_a_055_0019",
				"rts_lab_a_065_0020",
			},
		},
		caution = {
			groupA = {
				"rts_lab_c_010_0008",
				"rts_lab_c_015_0000",
				"rts_lab_c_020_0015",
				"rts_lab_c_025_0008",
				"rts_lab_c_040_0000",
				"rts_lab_c_045_0001",
				"rts_lab_c_050_0014",
				"rts_lab_c_055_0001",
				"rts_lab_c_060_0013",
				"rts_lab_c_065_0016",
				"rts_lab_c_030_0012",
				"rts_lab_c_035_0017",
			},
			groupB = {
			},
		},
		hold = {
			default = {
				"rts_lab_h_900_0000",
				"rts_lab_h_900_0001",
				"rts_lab_h_900_0002",
				"rts_lab_h_900_0003",
				"rts_lab_h_900_0000",
				"rts_lab_h_900_0001",
				"rts_lab_h_900_0002",
				"rts_lab_h_900_0003",
				"rts_lab_h_900_0000",
				"rts_lab_h_900_0001",
				"rts_lab_h_900_0002",
				"rts_lab_h_900_0003",
			},
		},
		travel = {
			MovingSupportIn = {
				"rts_labJungle_In_0000",
				"rts_labJungle_In_0001",
				"rts_labJungle_In_0002",
				"rts_labJungle_In_0003",
			},
		},
		nil
	},

	
	mafr_labWest_ob			= { USE_COMMON_ROUTE_SETS = true,	},
	mafr_diamondNorth_ob	= { USE_COMMON_ROUTE_SETS = true,	},

	
	mafr_19_29_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	mafr_18_19_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
}


this.routeSets01 = {
	
	mafr_labJungle_cp = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rts_lab_a_010_0007",
				"rts_lab_a_020_0017",
				"rts_lab_a_030_0014",
				"rts_lab_a_040_0008",
				"rts_lab_a_050_0016",
				"rts_lab_a_060_0015",
			},
			groupB = {
				"rts_lab_a_015_0009",
				"rts_lab_a_025_0010",
				"rts_lab_a_035_0021",
				"rts_lab_a_045_0018",
				"rts_lab_a_055_0019",
				"rts_lab_a_065_0020",
			},
		},
		sneak_night= {
			groupA = {
				"rts_lab_a_010_0007",
				"rts_lab_a_020_0017",
				"rts_lab_a_030_0014",
				"rts_lab_a_04x_0001",
				"rts_lab_a_050_0016",
				"rts_lab_a_060_0015",
			},
			groupB = {
				"rts_lab_a_015_0009",
				"rts_lab_a_025_0010",
				"rts_lab_a_035_0021",
				"rts_lab_a_04x_0001",
				"rts_lab_a_055_0019",
				"rts_lab_a_065_0020",
			},
		},
		caution = {
			groupA = {
				"rts_lab_c_010_0008",
				"rts_lab_c_015_0000",
				"rts_lab_c_020_0015",
				"rts_lab_c_025_0008",
				"rts_lab_c_040_0000",
				"rts_lab_c_045_0001",
				"rts_lab_c_050_0014",
				"rts_lab_c_055_0001",
				"rts_lab_c_060_0013",
				"rts_lab_c_065_0016",
				"rts_lab_c_030_0012",
				"rts_lab_c_035_0017",
			},
			groupB = {
			},
		},
		hold = {
			default = {
				"rts_lab_h_900_0000",
				"rts_lab_h_900_0001",
				"rts_lab_h_900_0002",
				"rts_lab_h_900_0003",
				"rts_lab_h_900_0000",
				"rts_lab_h_900_0001",
				"rts_lab_h_900_0002",
				"rts_lab_h_900_0003",
				"rts_lab_h_900_0000",
				"rts_lab_h_900_0001",
				"rts_lab_h_900_0002",
				"rts_lab_h_900_0003",
			},
		},
		travel = {
			MovingSupportIn = {
				"rts_labJungle_In_0000",
				"rts_labJungle_In_0001",
				"rts_labJungle_In_0002",
				"rts_labJungle_In_0003",
			},
		},
		nil
	},

}


this.routeSets02 = {
	
	mafr_labJungle_cp = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rts_lab_a_015_0009",
				"rts_lab_a_030_0014",
				"rts_lab_a_045_0018",
				"rts_lab_a_065_0020",
				"rts_lab_a_085_0008",
				"rts_lab_a_105_0010",
			},
			groupB = {
				"rts_lab_a_025_0010",
				"rts_lab_a_035_0021",
				"rts_lab_a_055_0019",
				"rts_lab_a_075_0007",
				"rts_lab_a_095_0009",
				"rts_lab_a_115_0014",
			},
		},
		sneak_night= {
			groupA = {
				"rts_lab_a_015_0009",
				"rts_lab_a_030_0014",
				"rts_lab_a_045_0018",
				"rts_lab_a_065_0020",
				"rts_lab_a_085_0008",
				"rts_lab_a_105_0010",
			},
			groupB = {
				"rts_lab_a_025_0010",
				"rts_lab_a_035_0021",
				"rts_lab_a_055_0019",
				"rts_lab_a_075_0007",
				"rts_lab_a_095_0009",
				"rts_lab_a_115_0014",
			},
		},
		caution = {
			groupA = {
				"rts_lab_c_015_0000",
				"rts_lab_c_025_0008",
				"rts_lab_c_045_0001",
				"rts_lab_c_055_0001",
				"rts_lab_c_065_0016",
				"rts_lab_c_075_0008",
				"rts_lab_c_085_0000",
				"rts_lab_c_095_0000",
				"rts_lab_c_105_0008",
				"rts_lab_c_115_0012",
				"rts_lab_c_030_0012",
				"rts_lab_c_035_0017",
			},
			groupB = {
			},
		},
		hold = {
			default = {
				"rts_lab_h_900_0000",
				"rts_lab_h_900_0001",
				"rts_lab_h_900_0002",
				"rts_lab_h_900_0003",
				"rts_lab_h_900_0000",
				"rts_lab_h_900_0001",
				"rts_lab_h_900_0002",
				"rts_lab_h_900_0003",
				"rts_lab_h_900_0000",
				"rts_lab_h_900_0001",
				"rts_lab_h_900_0002",
				"rts_lab_h_900_0003",
			},
		},
		travel = {
			MovingSupportIn = {
				"rts_labJungle_In_0000",
				"rts_labJungle_In_0001",
				"rts_labJungle_In_0002",
				"rts_labJungle_In_0003",
			},
		},
		nil
	},

}


this.routeSets03 = {
	
	mafr_labJungle_cp = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rts_lab_a_010_0007",
				"rts_lab_a_030_0014",
				"rts_lab_a_040_0008",
				"rts_lab_a_060_0015",
				"rts_lab_a_080_0008",
				"rts_lab_a_100_0010",
			},
			groupB = {
				"rts_lab_a_020_0017",
				"rts_lab_a_035_0021",
				"rts_lab_a_050_0016",
				"rts_lab_a_070_0007",
				"rts_lab_a_090_0009",
				"rts_lab_a_110_0014",
			},
		},
		sneak_night= {
			groupA = {
				"rts_lab_a_010_0007",
				"rts_lab_a_030_0014",
				"rts_lab_a_040_0008",
				"rts_lab_a_060_0015",
				"rts_lab_a_080_0008",
				"rts_lab_a_100_0010",
			},
			groupB = {
				"rts_lab_a_020_0017",
				"rts_lab_a_035_0021",
				"rts_lab_a_050_0016",
				"rts_lab_a_070_0007",
				"rts_lab_a_090_0009",
				"rts_lab_a_110_0014",
			},
		},
		caution = {
			groupA = {
				"rts_lab_c_010_0008",
				"rts_lab_c_020_0015",
				"rts_lab_c_040_0000",
				"rts_lab_c_050_0014",
				"rts_lab_c_060_0013",
				"rts_lab_c_070_0008",
				"rts_lab_c_080_0000",
				"rts_lab_c_090_0000",
				"rts_lab_c_100_0008",
				"rts_lab_c_110_0011",
				"rts_lab_c_030_0012",
				"rts_lab_c_035_0017",
			},
			groupB = {
			},
		},
		hold = {
			default = {
				"rts_lab_h_900_0000",
				"rts_lab_h_900_0001",
				"rts_lab_h_900_0002",
				"rts_lab_h_900_0003",
				"rts_lab_h_900_0000",
				"rts_lab_h_900_0001",
				"rts_lab_h_900_0002",
				"rts_lab_h_900_0003",
				"rts_lab_h_900_0000",
				"rts_lab_h_900_0001",
				"rts_lab_h_900_0002",
				"rts_lab_h_900_0003",
			},
		},
		travel = {
			MovingSupportIn = {
				"rts_labJungle_In_0000",
				"rts_labJungle_In_0001",
				"rts_labJungle_In_0002",
				"rts_labJungle_In_0003",
			},
		},
		nil
	},

}


this.routeSets04 = {
	
	mafr_labJungle_cp = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rts_lab_a_010_0015",
				"rts_lab_a_020_0019",
				"rts_lab_a_030_0020",
				"rts_lab_a_010_0015",
				"rts_lab_a_020_0019",
				"rts_lab_a_030_0020",
			},
			groupB = {
				"rts_lab_a_015_0018",
				"rts_lab_a_025_0021",
				"rts_lab_a_035_0022",
				"rts_lab_a_015_0018",
				"rts_lab_a_025_0021",
				"rts_lab_a_035_0022",
			},
		},
		sneak_night= {
			groupA = {
				"rts_lab_a_010_0015",
				"rts_lab_a_020_0019",
				"rts_lab_a_030_0020",
				"rts_lab_a_010_0015",
				"rts_lab_a_020_0019",
				"rts_lab_a_030_0020",
			},
			groupB = {
				"rts_lab_a_015_0018",
				"rts_lab_a_025_0021",
				"rts_lab_a_035_0022",
				"rts_lab_a_015_0018",
				"rts_lab_a_025_0021",
				"rts_lab_a_035_0022",
			},
		},
		caution = {
			groupA = {
				"rts_lab_a_010_0015",
				"rts_lab_a_015_0018",
				"rts_lab_a_020_0019",
				"rts_lab_a_025_0021",
				"rts_lab_a_010_0015",
				"rts_lab_a_015_0018",
				"rts_lab_a_020_0019",
				"rts_lab_a_025_0021",
				"rts_lab_a_030_0020",
				"rts_lab_a_035_0022",
				"rts_lab_a_030_0020",
				"rts_lab_a_035_0022",
			},
			groupB = {
			},
		},
		hold = {
		},
		travel = {
			MovingSupportIn = {
				"rts_labJungle_In_0000",
				"rts_labJungle_In_0001",
				"rts_labJungle_In_0002",
				"rts_labJungle_In_0003",
			},
		},
		nil
	},

}





this.lrrpHoldTime = 15

this.travelPlans = {
	
	
	travelLab01 = {
		{ cp="mafr_lab_cp", 			routeGroup={ "travel", "out_lrrpHold_W" }, },	
		{ cp="mafr_19_29_lrrp", 		routeGroup={ "travel", "lrrp_29to19" }, },	
		{ cp="mafr_labWest_ob", 		routeGroup={ "travel", "in_lrrpHold_W" }, },	
		{ cp="mafr_labWest_ob", 		routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime },	
		{ cp="mafr_labWest_ob", 		routeGroup={ "travel", "out_lrrpHold_E" }, },	
		{ cp="mafr_18_19_lrrp", 		routeGroup={ "travel", "lrrp_19to18" }, },	
		{ cp="mafr_diamondNorth_ob", 	routeGroup={ "travel", "in_lrrpHold_W" }, },	
		{ cp="mafr_diamondNorth_ob", 	routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime },	
		{ cp="mafr_diamondNorth_ob", 	routeGroup={ "travel", "out_lrrpHold_W" }, },	
		{ cp="mafr_18_19_lrrp", 		routeGroup={ "travel", "lrrp_18to19" }, },	
		{ cp="mafr_labWest_ob", 		routeGroup={ "travel", "in_lrrpHold_E" }, },	
		{ cp="mafr_labWest_ob", 		routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime },	
		{ cp="mafr_labWest_ob", 		routeGroup={ "travel", "out_lrrpHold_W" }, },	
		{ cp="mafr_19_29_lrrp", 		routeGroup={ "travel", "lrrp_19to29" }, },	
		{ cp="mafr_lab_cp", 			routeGroup={ "travel", "in_lrrpHold_W" }, },	
		{ cp="mafr_lab_cp", 			routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime },	
	},
	
	
	travelLab02 = {
		ONE_WAY = true,
		{ cp="mafr_lab_cp", 			routeGroup={ "travel", "MovingSupportOut" }, },
		{ cp="mafr_labJungle_cp",		routeGroup={ "travel", "MovingSupportIn" }, },
		{ cp="mafr_labJungle_cp",		finishTravel = true },
	},

}




this.combatSetting = {
	mafr_lab_cp = {
		"gt_lab_0000",
		"cs_lab_0000",
	},
	mafr_labJungle_cp = {
		"gts_lab_0000",
		"gts_lab_0001",
		"css_lab_0000",
	},
	mafr_labWest_ob = {
		"gt_labWest_0000",
		"cs_labWest_0000",
	},
	nil
}
this.combatSetting01 = {
	mafr_labJungle_cp = {
		"gts_lab_0001",
		"css_lab_0000",
	},
	nil
}
this.combatSetting02 = {
	mafr_labJungle_cp = {
		"gts_lab_0000",
		"css_lab_0000",
	},
	nil
}
this.combatSetting03 = {
	mafr_labJungle_cp = {
		"gts_lab_0002",
		"gts_lab_0003",
		"css_lab_0000",
	},
	nil
}





this.UniqueInterEnd_sol_vip_0000 = function( soldier2GameObjectId, cpID )
	Fox.Log("CallBack : Unique : End")
	
end


this.UniqueInterStart_sol_vip_0000 = function( soldier2GameObjectId, cpID )
	Fox.Log("CallBack : Unique : start ")
	TppInterrogation.UniqueInterrogation( cpID, "enqt1000_106976" ) 
	return true
end


this.InterCall_container_pos01 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_container_pos01")

	
	this.InterStop_container_pos01()

	
	s10093_sequence.commonEnemyInterrogation()

end

this.InterCall_captain_pos01 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_captain_pos01")

	
	svars.PreliminaryFlag03 = true

	
	this.InterStop_captain_pos01()

	
	s10093_sequence.EnemyInterrogationCaptain()

end


this.uniqueInterrogation = {
	unique = {
		{ name = "enqt1000_106976", func = this.UniqueInterEnd_sol_vip_0000, },
		nil
	},
	uniqueChara = {
		{ name = "sol_vip_0000", func = this.UniqueInterStart_sol_vip_0000, },
		nil
	},
	nil
}


this.interrogation = {

	
	mafr_lab_cp = {
		
		high = {
			{ name = "enqt1000_106980", func = this.InterCall_container_pos01, },
			{ name = "enqt1000_106973", func = this.InterCall_captain_pos01, },
			nil
		},
		nil
	},
	mafr_labJungle_cp = {
		
		high = {
			{ name = "enqt1000_106980", func = this.InterCall_container_pos01, },
			{ name = "enqt1000_106973", func = this.InterCall_captain_pos01, },
			nil
		},
		nil
	},
	nil
}


this.useGeneInter = {
	
	mafr_lab_cp				= true,
	mafr_labJungle_cp		= false,
	mafr_labWest_ob			= true,
	mafr_diamondNorth_ob	= true,
	mafr_19_29_lrrp			= true,
	mafr_18_19_lrrp			= true,
	nil
}




this.cpGroups = {
	group_Area5 = {
		
		"mafr_lab_cp",
		
		"mafr_labWest_ob",
		"mafr_diamondNorth_ob",
		
		"mafr_19_29_lrrp",
		"mafr_18_19_lrrp",
		
		"mafr_labJungle_cp",
	},
}




this.SpawnVehicleOnInitialize = function()
	Fox.Log("*** SetVehicleSpawn ***")
	TppEnemy.SpawnVehicles( this.VEHICLE_SPAWN_LIST )
end


this.InitEnemy = function ()
	TppEnemy.NoShifhtChangeGruopSetting( "mafr_labJungle_cp", "groupA" )
	TppEnemy.NoShifhtChangeGruopSetting( "mafr_labJungle_cp", "groupB" )
end



this.SetUpEnemy = function ()

	
	this.SetVip()

	


	
	this.RegistHoldRecoveredStateForMissionTask( this.taskTargetList )

	
	this.SetAllEnemyStaffParam()

	
	local cpSetCommand = { id = "SetNormalCp" }
	GameObject.SendCommand( GameObject.GetGameObjectId( "mafr_labJungle_cp" ) , cpSetCommand )

	
	TppEnemy.RegisterCombatSetting( this.combatSetting )

	
	this.FormationLine()

	
	this.FlyingBird()

end


this.OnLoad = function ()
	Fox.Log("*** s10093 onload ***")
end









this.MissionInit = function ()
	TppEnemy.ChangeRouteSets( this.routeSets )
	TppEnemy.RegisterCombatSetting( this.combatSetting )
end


this.RegistHoldRecoveredStateForMissionTask = function( taskTargetList )
	Fox.Log("###*** MissionTask register beginning ***")
	for index, targetName in pairs(taskTargetList) do
		TppEnemy.RegistHoldRecoveredState( targetName )
	end
end


this.SetAllEnemyStaffParam = function ()
	Fox.Log("#### s10093_enemy.SetAllStaffParam ####")
	
	TppEnemy.AssignUniqueStaffType{
		locaterName = "sol_vip_0000",
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10093_ZRS_CAPTAIN,
		alreadyExistParam = { staffTypeId =2, randomRangeId =6, skill ="QuickReload" },
	}
end


this.RouteChangeOn = function ()

	if( svars.PreliminaryFlag01 == false )then
		svars.PreliminaryFlag01 = true

		TppEnemy.RegisterCombatSetting( this.combatSetting )
		
		this.MovinglabTolabJungle()

	end

end


this.ContainerAGetAfter = function ()
	TppEnemy.ChangeRouteSets( this.routeSets02 )
	TppEnemy.RegisterCombatSetting( this.combatSetting01 )
end


this.ContainerBGetAfter = function ()
	TppEnemy.ChangeRouteSets( this.routeSets03 )
	TppEnemy.RegisterCombatSetting( this.combatSetting02 )
end


this.ReadyToClear = function ()
	TppEnemy.ChangeRouteSets( this.routeSets04 )
	TppEnemy.RegisterCombatSetting( this.combatSetting03 )
end


function this.VehicleIdSetting()
	local targetDriverId_01		= GameObject.GetGameObjectId("TppSoldier2", "sol_19_29_0001" )
	local targetDriverId_02		= GameObject.GetGameObjectId("TppSoldier2", "sol_19_29_0002" )
	local targetVehicleId_01	= GameObject.GetGameObjectId("TppVehicle2", "veh_s10093_0000" )
	local command_target01 		= { id="SetRelativeVehicle", targetId = targetVehicleId_01	, rideFromBeginning = false }
	GameObject.SendCommand( targetDriverId_01	, command_target01 )
	GameObject.SendCommand( targetDriverId_02	, command_target01 )
end



this.SetVip = function()
	Fox.Log("Initialize route set group,vip and near vip enemyes")
	TppEnemy.InitialRouteSetGroup{
		cpName = "mafr_lab_cp",
		soldierList = { "sol_vip_0000", },
		groupName = "vip",
	}

	
	local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", "sol_vip_0000" )
	local command = { id="SetDisableOccasionalChat", disable=true }
	GameObject.SendCommand( gameObjectId, command )

end


this.MovinglabTolabJungle = function()
	local MovingGroup = {
		"sol_lab_0013",
		"sol_lab_0014",
		"sol_lab_0015",
		"sol_lab_0016",
	}
	for i,enemyName in pairs (MovingGroup) do
		local command = { id = "StartTravel", travelPlan = "travelLab02", keepInAlert=false }
		local gameObjectId = GameObject.GetGameObjectId(enemyName)
		GameObject.SendCommand( gameObjectId, command )
		TppEnemy.UnsetSneakRoute( gameObjectId )	
	end
end


this.FormationLine = function()
	local j = 0
	local gameObjectId
	local command = { id="SetForceFormationLine", enable=true }

	for name, group in pairs( this.soldierDefine ) do
		j = j + 1
		for i = 1, #group do
			local EnemyTargetName = group[i]
			gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", EnemyTargetName )
			GameObject.SendCommand( gameObjectId, command )
		end
	end
end


this.EnemyHeliSetRoute = function(routeId)
	Fox.Log("change route Enemy Heli "..routeId )
	local gameObjectId =  GameObject.GetGameObjectId("TppEnemyHeli","EnemyHeli")
	GameObject.SendCommand(gameObjectId, { id="RequestRoute", 	route=routeId })
	GameObject.SendCommand(gameObjectId, { id="SetAlertRoute", 	route=routeId })
	GameObject.SendCommand(gameObjectId, { id="SetCautionRoute", 	route=routeId })
	GameObject.SendCommand(gameObjectId, { id="SetSneakRoute", 	route=routeId })
	GameObject.SendCommand(gameObjectId, { id="SetEyeMode", 	mode="Close" })
	GameObject.SendCommand(gameObjectId, { id="SetCombatEnabled", enabled=false })
end


this.EnemyHeliDisable = function()
	Fox.Log("EnemyHeliDisable")
	local gameObjectId =  GameObject.GetGameObjectId("TppEnemyHeli","EnemyHeli")
	GameObject.SendCommand(gameObjectId, { id="Unrealize" })
end


this.EnemyHeliAround = function()
	this.EnemyHeliSetRoute(HELI_ROUTE_PATROL)
end


this.FlyingBird = function()
	Fox.Log("Flying bird !!")
	local typeName = "TppCritterBird"
	local gameObjectId = {type = typeName, index = 0}
	local command = {
		id = "ForceFlying",
		name = BIRD_OBJECT_ID01,
	}
	GameObject.SendCommand(gameObjectId, command)

end


this.InterStop_container_pos01 = function ()
	TppInterrogation.RemoveHighInterrogation(
		GameObject.GetGameObjectId("mafr_lab_cp"),
		{
			{ name = "enqt1000_106980", func = this.InterCall_container_pos01, },
		}
	)
	TppInterrogation.RemoveHighInterrogation(
		GameObject.GetGameObjectId("mafr_labJungle_cp"),
		{
			{ name = "enqt1000_106980", func = this.InterCall_container_pos01, },
		}
	)
end


this.InterStop_captain_pos01 = function ()
	TppInterrogation.RemoveHighInterrogation(
		GameObject.GetGameObjectId("mafr_lab_cp"),
		{
			{ name = "enqt1000_106973", func = this.InterCall_captain_pos01, },
		}
	)
	TppInterrogation.RemoveHighInterrogation(
		GameObject.GetGameObjectId("mafr_labJungle_cp"),
		{
			{ name = "enqt1000_106973", func = this.InterCall_captain_pos01, },
		}
	)
end




return this
