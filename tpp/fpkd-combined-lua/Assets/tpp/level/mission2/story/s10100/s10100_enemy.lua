local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}
this.lrrpHoldTime = 15





this.USE_COMMON_REINFORCE_PLAN = true




local spawnList = {
	{ id="Spawn", locator="veh_s10100_0000", type = Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE, subType = Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON, paintType = Vehicle.paintType.FOVA_0, },
	{ id="Spawn", locator="veh_s10100_0001", type = Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE, subType = Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON, paintType = Vehicle.paintType.FOVA_0, },
	{ id="Spawn", locator="veh_s10100_0002", type = Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE, subType = Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON, paintType = Vehicle.paintType.FOVA_0, },
}
this.vehicleDefine = {
        instanceCount   = #spawnList,
}
this.SpawnVehicleOnInitialize = function()
        TppEnemy.SpawnVehicles( spawnList )
end




this.soldierDefine = {
	
	
	
	s10100_sniperA_cp = {
		"sol_sniperA_0000",
		"sol_sniperA_0001",
		"sol_sniperA_0002",
		nil
	},
	s10100_sniperB_cp = {
		"sol_sniperB_0000",
		"sol_sniperB_0001",
		nil
	},
	
	
	
	
	mafr_banana_cp = {
		"sol_target_0000",	
		"sol_banana_0001",
		"sol_banana_0002",
		"sol_banana_0003",
		"sol_banana_0004",
		"sol_banana_0005",
		"sol_banana_0006",
		"sol_banana_0007",
		"sol_banana_0008",
		"sol_banana_0009",
		"sol_banana_0010",
		nil
	},
	
	mafr_diamond_cp = {
		"sol_diamond_0000",
		"sol_diamond_0001",
		"sol_diamond_0002",
		"sol_diamond_0003",
		"sol_diamond_0004",
		"sol_diamond_0005",
		"sol_diamond_0006",
		"sol_diamond_0007",
		"sol_diamond_0008",
		"sol_diamond_0009",
		"sol_diamond_0010",
		"sol_diamond_0011",
		nil
	},
	
	mafr_diamondSwamp_cp = {
		"sol_diamondSwamp_0000",
		"sol_diamondSwamp_0001",
		"sol_diamondSwamp_0002",
		"sol_diamondSwamp_0003",
		nil
	},
	
	mafr_diamondRiver_cp = {
		"sol_diamondRiver_0000",
		"sol_diamondRiver_0001",
		"sol_diamondRiver_0002",
		"sol_diamondRiver_0003",
		"sol_diamondRiver_0004",
		"sol_diamondRiver_0005",
		"sol_diamondRiver_0006",
		"sol_diamondRiver_0007",
		"sol_tracking_A_0000",
		"sol_tracking_A_0001",
		"sol_tracking_A_0002",
		"sol_tracking_A_0003",
		nil
	},
	
	mafr_tracking_cp = {
		"sol_diamondHill_0000",
		"sol_diamondHill_0001",
		"sol_diamondHill_0002",
		"sol_diamondHill_0003",
		"sol_diamondHill_0005",
		"sol_diamondHill_0006",
		"sol_diamondHill_0008",
		"sol_diamondHill_0009",
		nil
	},
	
	
	
	
	mafr_bananaEast_ob = {
		"sol_bananaEast_0000",
		"sol_bananaEast_0001",
		"sol_bananaEast_0002",
		"sol_bananaEast_0003",
		nil
	},
	
	mafr_bananaSouth_ob = {
		"sol_bananaSouth_0000",
		"sol_bananaSouth_0001",
		"sol_bananaSouth_0002",
		"sol_bananaSouth_0003",
		"sol_bananaSouth_0004",
		"sol_bananaSouth_0005",
		nil
	},
	
	mafr_diamondNorth_ob = {
		"sol_diamondNorth_0000",
		"sol_diamondNorth_0001",
		"sol_diamondNorth_0002",
		"sol_diamondNorth_0003",
		"sol_s10100_0002",			
		nil
	},
	
	mafr_diamondSouth_ob = {
		"sol_diamondSouth_0000",
		"sol_diamondSouth_0001",
		"sol_diamondSouth_0002",
		"sol_diamondSouth_0003",
		"sol_diamondSouth_0004",
		"sol_diamondSouth_0005",
		nil
	},
	
	mafr_diamondWest_ob = {
		"sol_diamondWest_0000",
		"sol_diamondWest_0001",
		"sol_diamondWest_0002",
		"sol_diamondWest_0003",
		"sol_diamondWest_0004",
		"sol_diamondWest_0005",
		"sol_s10100_0000",	
		nil
	},
	
	mafr_savannahNorth_ob = {
		"sol_savannahNorth_0000",
		"sol_savannahNorth_0001",
		"sol_savannahNorth_0002",
		"sol_savannahNorth_0003",
		nil
	},
	
	mafr_savannahWest_ob = {
		"sol_savannahWest_0000",
		"sol_savannahWest_0001",
		"sol_savannahWest_0002",
		"sol_savannahWest_0003",
		nil
	},
	
	
	
	mafr_04_25_lrrp = { nil },
	mafr_04_07_lrrp = { nil },
	mafr_04_09_lrrp = { "sol_s10100_0001",nil },
	mafr_07_09_lrrp = { nil },
	mafr_08_10_lrrp = { nil },
	mafr_08_25_lrrp = { nil },
	mafr_09_25_lrrp = { nil },
	mafr_10_11_lrrp = { nil },
	mafr_10_26_lrrp = { nil },
	mafr_18_26_lrrp = { nil },
	s10100_wavAreaOut_cp = { nil },
	nil
}



this.voiceCall_enemyTable = {
	
	"sol_diamond_0000",
	"sol_diamond_0001",
	"sol_diamond_0002",
	"sol_diamond_0003",
	"sol_diamond_0004",
	"sol_diamond_0005",
	"sol_diamond_0006",
	"sol_diamond_0007",
	"sol_diamond_0008",
	"sol_diamond_0009",
	"sol_diamond_0010",
	"sol_diamond_0011",
	
	"sol_diamondSwamp_0000",
	"sol_diamondSwamp_0001",
	"sol_diamondSwamp_0002",
	"sol_diamondSwamp_0003",
	
	"sol_diamondRiver_0000",
	"sol_diamondRiver_0001",
	"sol_diamondRiver_0002",
	"sol_diamondRiver_0003",
	"sol_diamondRiver_0004",
	"sol_diamondRiver_0005",
	"sol_diamondRiver_0006",
	"sol_diamondRiver_0007",
	"sol_tracking_A_0000",
	"sol_tracking_A_0001",
	"sol_tracking_A_0002",
	"sol_tracking_A_0003",
	
	"sol_diamondHill_0000",
	"sol_diamondHill_0001",
	"sol_diamondHill_0002",
	"sol_diamondHill_0003",
	"sol_diamondHill_0005",
	"sol_diamondHill_0006",
	"sol_diamondHill_0008",
	"sol_diamondHill_0009",
}



this.soldierPowerSettings = {
		sol_target_0000 = {},	
		sol_sniperA_0000 = { "SNIPER", },
		sol_sniperA_0001 = { "SNIPER", },
		sol_sniperA_0002 = { "SNIPER", },
		sol_sniperB_0000 = { "SNIPER", },
		sol_sniperB_0001 = { "SNIPER", },
}



this.soldierSubTypes = {
        PF_C = {
			"sol_sniperA_0000",
			"sol_sniperA_0001",
			"sol_sniperA_0002",
			"sol_sniperB_0000",
			"sol_sniperB_0001",
			"sol_s10100_0000",
			"sol_s10100_0001",
			"sol_s10100_0002",
			"sol_diamondSwamp_0000",
			"sol_diamondSwamp_0001",
			"sol_diamondSwamp_0002",
			"sol_diamondSwamp_0003",
			"sol_diamondSwamp_0004",
			"sol_diamondSwamp_0005",
			"sol_diamondRiver_0000",
			"sol_diamondRiver_0001",
			"sol_diamondRiver_0002",
			"sol_diamondRiver_0003",
			"sol_diamondRiver_0004",
			"sol_diamondRiver_0005",
			"sol_diamondRiver_0006",
			"sol_diamondRiver_0007",
			"sol_tracking_A_0000",
			"sol_tracking_A_0001",
			"sol_tracking_A_0002",
			"sol_tracking_A_0003",
			"sol_diamondHill_0000",
			"sol_diamondHill_0001",
			"sol_diamondHill_0002",
			"sol_diamondHill_0003",
			"sol_diamondHill_0005",
			"sol_diamondHill_0006",
			"sol_diamondHill_0008",
			"sol_diamondHill_0009",
			nil
        },
}





this.routeSets = {
	
	
	mafr_banana_cp = {
		
		
		
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
			"groupE",
			"groupF",
		},
		fixedShiftChangeGroup = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_target_d_0000",
			},
			groupB = {
				"rt_banana_d_0000",
				"rt_banana_d_0005",
			},
			groupC = {
				"rt_banana_d_0001",
				"rt_banana_d_0006",
			},
			groupD = {
				"rt_banana_d_0002",
				"rt_banana_d_0007",
			},
			groupE = {
				"rt_banana_d_0004_sub",
				"rt_banana_d_0008",
			},
			groupF = {
				"rt_banana_d_0005",
				"rt_banana_d_0009",
			}
		},
		sneak_night= {
			groupA = {
				"rts_target_n_0000",
			},
			groupB = {
				"rt_banana_n_0000",
				"rt_banana_n_0005_sub",
			},
			groupC = {
				"rt_banana_n_0001",
				"rt_banana_n_0006",
			},
			groupD = {
				"rt_banana_n_0002",
				"rt_banana_n_0007_sub",
			},
			groupE = {
				"rt_banana_n_0003",
				"rt_banana_n_0008",
			},
			groupF = {
				"rt_banana_n_0004_sub",
				"rt_banana_n_0009",
			}
		},
		caution = {
			groupA = {
				"rts_target_c_0000",	
				"rt_banana_c_0000",
				"rt_banana_c_0001",		
				"rt_banana_c_0001",		
				"rt_banana_c_0002",
				"rt_banana_c_0003",
				"rt_banana_c_0004",
				"rt_banana_c_0005",
				"rt_banana_c_0006",
				"rt_banana_c_0007",
				"rt_banana_c_0008",
				"rt_banana_c_0009",
				"rt_banana_c_0010",
			},
			groupB = {
			},
			groupC = {
			},
			groupD = {
			},
			groupE = {
			},
			groupF = {
			},
		},
		hold = {
			
			
			groupA = {
				"rts_target_h_0000",
			},
			default = {
				"rt_banana_h_0000",
				"rt_banana_h_0001",
			},
		},
		sleep = {
			groupA = {
				"rts_target_s_0000",
			},
			default = {
				"rt_banana_s_0000",
				"rt_banana_s_0001",
			}
		},
		travel = {
			lrrp_diamondWest_to_banana_wav	= { "rts_wav0000_0004", },
			lrrp_diamondWest_to_banana_wav_back	= { "rts_wav0000_00045", },
			lrrp_banana_to_diamondWest_wav	= { "rts_wav0000_0005", },
		},
		nil
	},
	
	
	mafr_diamond_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_diamond_d_0000",
				"rt_diamond_d_0003",
				"rt_diamond_d_0005",
				"rt_diamond_d_0008",
			},
			groupB = {
				"rt_diamond_d_0001",
				"rt_diamond_d_0004",	
				"rt_diamond_d_0006",
				"rt_diamond_d_0009",
			},
			groupC = {
				"rt_diamond_d_0002",
				"rt_diamond_d_0004",	
				"rt_diamond_d_0007",
				"rt_diamond_d_0010",
			},
		},
		sneak_night= {
			groupA = {
				"rt_diamond_n_0000_sub",
				"rt_diamond_n_0003",
				"rt_diamond_n_0006",
				"rt_diamond_n_0009",
			},
			groupB = {
				"rt_diamond_n_0001_sub",
				"rt_diamond_n_0004",
				"rt_diamond_n_0007",
				"rt_diamond_n_0010",
			},
			groupC = {
				"rt_diamond_n_0002_sub",
				"rt_diamond_n_0005",
				"rt_diamond_n_0008_sub",
				"rt_diamond_n_0011",
			},
		},
		caution = {
			groupA = {
				"rt_diamond_c_0000",
				"rt_diamond_c_0001",
				"rt_diamond_c_0002",
				"rt_diamond_c_0003",
				"rt_diamond_c_0004",
				"rt_diamond_c_0005",
				"rt_diamond_c_0006",
				"rt_diamond_c_0007",
				"rt_diamond_c_0008",
				"rt_diamond_c_0009",
				"rt_diamond_c_0010",
				"rt_diamond_c_0011",
				"rt_diamond_c_0012",	
				"rt_diamond_c_0012",	
			},
			groupB = {
				
			},
			groupC = {
				
			},
		},
		hold = {
			default = {
				"rt_diamond_h_0000",
				"rt_diamond_h_0001",
				"rt_diamond_h_0002",
				"rt_diamond_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_diamond_s_0000",
				"rt_diamond_s_0001",
				"rt_diamond_s_0002",
				"rt_diamond_s_0003",
			},
		},
		travel = {
				lrrp_diamondNorth_to_diamondSouth_wav	= { "rts_wav0002_0002", },
				lrrp_diamondSouth_to_diamondNorth_wav	= { "rts_wav0002_0009", },
		},
		nil
	},
	
	
	mafr_diamondSwamp_cp = {
		
		
		
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rt_diamondSwamp_d_0000",
				"rt_diamondSwamp_d_0002",
			},
			groupB = {
				"rt_diamondSwamp_d_0001",
				"rt_diamondSwamp_d_0003",
			}
		},
		sneak_night= {
			groupA = {
				"rt_diamondSwamp_n_0000",
				"rt_diamondSwamp_n_0002",
			},
			groupB = {
				"rt_diamondSwamp_n_0001",
				"rt_diamondSwamp_n_0003",
			}
		},
		caution = {
			groupA = {
				"rt_diamondSwamp_c_0000",
				"rt_diamondSwamp_c_0000",
				"rt_diamondSwamp_c_0001",
				"rt_diamondSwamp_c_0001",
			},
			groupB = {
			}
		},
		hold = {
			
			
			default = {
			},
		},
		sleep = {
			default = {
				"rt_diamondSwamp_s_0000",
				"rt_diamondSwamp_s_0001",
			},
		},
		outofrain = {
			"rt_diamondSwamp_r_0000",
			"rt_diamondSwamp_r_0001",
		},
		nil
	},
	
	
	mafr_diamondRiver_cp = {
		
		
		
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		sneak_day = {
			groupA = {
				"rt_diamondRiver_d_0000",
				"rt_diamondRiver_d_0003",
			},
			groupB = {
				"rt_diamondRiver_d_0001",
				"rt_diamondRiver_d_0004",
			},
			groupC = {
				"rt_diamondRiver_d_0002",
				"rt_diamondRiver_d_0005",
			},
			groupD = {
				"rt_diamondRiver_d_0002",
				"rt_diamondRiver_d_0006",
			}
		},
		sneak_night= {
			groupA = {
				"rt_diamondRiver_n_0000",
				"rt_diamondRiver_n_0003",
			},
			groupB = {
				"rt_diamondRiver_n_0001",
				"rt_diamondRiver_n_0004",
			},
			groupC = {
				"rt_diamondRiver_n_0002",
				"rt_diamondRiver_n_0005",
			},
			groupD = {
				"rt_diamondRiver_n_0006",
				"rt_diamondRiver_n_0007",
			}
		},
		caution = {
			groupA = {
				"rt_diamondRiver_c_0000",
				"rt_diamondRiver_c_0001",	
				"rt_diamondRiver_c_0001",	
				"rt_diamondRiver_c_0002",
				"rt_diamondRiver_c_0003",
				"rt_diamondRiver_c_0004",
				"rt_diamondRiver_c_0005",
				"rt_diamondRiver_c_0006",
			},
			groupB = {
			},
			groupC = {
			},
			groupD = {
			},
			groupE = {
			},
		},
		hold = {
			
			
			default = {
			},
		},
		sleep = {
			default = {
				"rt_diamondRiver_s_0000",
				"rt_diamondRiver_s_0001",
			},
		},
		outofrain = {
			"rt_diamondRiver_r_0000",
			"rt_diamondRiver_r_0001",
			"rt_diamondRiver_r_0002",
			"rt_diamondRiver_r_0003",
		},
		nil
	},
	
	
	s10100_sniperA_cp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_sniperA_s_0000",
				"rts_sniperA_s_0001",
				"rts_sniperA_s_0002",
			}
		},
		sneak_night= {
			groupA = {
				"rts_sniperA_s_0000",
				"rts_sniperA_s_0001",
				"rts_sniperA_s_0002",
			}
		},
		caution = {
			groupA = {
				"rts_sniperA_c_0000",
				"rts_sniperA_c_0001",
				"rts_sniperA_c_0002",
			}
		},
		hold = {
			default = {
			},
		},
		nil
	},
	s10100_sniperB_cp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_sniperB_s_0000",
				"rts_sniperB_s_0001",
			}
		},
		sneak_night= {
			groupA = {
				"rts_sniperB_s_0000",
				"rts_sniperB_s_0001",
			}
		},
		caution = {
			groupA = {
				"rts_sniperB_c_0000",
				"rts_sniperB_c_0001",
			}
		},
		hold = {
			default = {
			},
		},
		nil
	},
	
	
	mafr_tracking_cp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			}
		},
		sneak_night= {
			groupA = {
			}
		},
		caution = {
			groupA = {
			}
		},
		hold = {
			default = {
			},
		},
		nil
	},
	
	
	mafr_bananaSouth_ob = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_savannahNorth_to_savannahWest_wav	= { "rts_wav0001_0001", },
		},
	},
	
	
	mafr_bananaEast_ob = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_diamondWest_to_banana_wav	= { "rts_wav0000_0002", },
			lrrp_banana_to_diamondWest_wav	= { "rts_wav0000_0007", },
		},
	},
	
	
	mafr_diamondWest_ob = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_diamondWest_to_banana_wav	= { "rts_wav0000_0000", },
			lrrp_banana_to_diamondWest_wav	= { "rts_wav0000_0009", },
			lrrp_banana_to_diamondWest_wav2	= { "rts_wav0000_000a", },
			lrrp_diamondNorth_to_diamondSouth_wav	= { "rts_wav0002_0003", },
			lrrp_diamondSouth_to_diamondNorth_wav	= { "rts_wav0002_0008", },
		},
	},
	
	
	mafr_diamondNorth_ob = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_diamondNorth_to_diamondSouth_wav	= { "rts_wav0002_0000", },
			lrrp_diamondSouth_to_diamondNorth_wav	= { "rts_wav0002_0011", },
			lrrp_diamondSouth_to_diamondNorth_wav_back	= { "rts_wav0002_0012", },
		},
	},
	
	
	mafr_diamondSouth_ob = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_diamondNorth_to_diamondSouth_wav	= { "rts_wav0002_0005", },
			lrrp_diamondNorth_to_diamondSouth_wav_back	= { "rts_wav0002_0005_back", },
			lrrp_diamondSouth_to_diamondNorth_wav	= { "rts_wav0002_0006", },
		},
	},
	
	
	mafr_savannahNorth_ob = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_savannahWest_to_savannahNorth_wav	= { "rts_wav0001_0005", },
		},
	},
	
	
	mafr_savannahWest_ob = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_savannahWest_to_savannahNorth_wav	= { "rts_wav0001_0003", },
		},
	},
	
	
	mafr_04_25_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
		},
	},
	
	
	mafr_04_07_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_savannahNorth_to_savannahWest_wav	= { "rts_wav0001_0002", },
		},
	},
	
	
	mafr_04_09_lrrp = {
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
		travel = {
			lrrp_savannahNorth_to_savannahWest_wav	= { "rts_wav0001_0000", },
		},
	},
	
	
	mafr_07_09_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_savannahWest_to_savannahNorth_wav	= { "rts_wav0001_0004", },
		},
	},
	
	
	mafr_08_10_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_diamondWest_to_banana_wav	= { "rts_wav0000_0001", },
			lrrp_banana_to_diamondWest_wav	= { "rts_wav0000_0008", },
		},
	},
	
	
	mafr_08_25_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_diamondWest_to_banana_wav	= { "rts_wav0000_0003", },
			lrrp_banana_to_diamondWest_wav	= { "rts_wav0000_0006", },
		},
	},
	
	
	mafr_09_25_lrrp = { USE_COMMON_ROUTE_SETS = true,	},
	
	
	mafr_18_26_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_diamondNorth_to_diamondSouth_wav	= { "rts_wav0002_0001", },
			lrrp_diamondSouth_to_diamondNorth_wav	= { "rts_wav0002_0010", },
		},
	},
	
	
	mafr_10_26_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
		},
	},
	
	
	mafr_10_11_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_diamondNorth_to_diamondSouth_wav	= { "rts_wav0002_0004", },
			lrrp_diamondSouth_to_diamondNorth_wav	= { "rts_wav0002_0007", },
		},
	},
	
	
	s10100_wavAreaOut_cp = {
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
		travel = {
		},
	},
}




this.wav0000_GO_01 = function()
	Fox.Log(" taravelPlan START : wav0000_GO_01 ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10100_0000") , { id = "StartTravel", travelPlan = "travel_diamondWest_to_banana_wav" , keepInAlert = false } )
end
this.wav0000_GO_02 = function()
	Fox.Log(" taravelPlan START : wav0000_GO_02 ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10100_0000") , { id = "StartTravel", travelPlan = "travel_banana_to_diamondWest_wav" , keepInAlert = false } )
end

this.wav0001_GO_01 = function()
	Fox.Log(" taravelPlan START : wav0001_GO_01 ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10100_0001") , { id = "StartTravel", travelPlan = "travel_savannahNorth_to_savannahWest_wav" , keepInAlert = false } )
end
this.wav0001_GO_02 = function()
	Fox.Log(" taravelPlan START : wav0001_GO_02 ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10100_0001") , { id = "StartTravel", travelPlan = "travel_savannahWest_to_savannahNorth_wav" , keepInAlert = false } )
end

this.wav0002_GO_01 = function()
	Fox.Log(" taravelPlan START : wav0002_GO_01 ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10100_0002") , { id = "StartTravel", travelPlan = "travel_diamondNorth_to_diamondSouth_wav" , keepInAlert = false } )
end
this.wav0002_GO_02 = function()
	Fox.Log(" taravelPlan START : wav0002_GO_02 ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10100_0002") , { id = "StartTravel", travelPlan = "travel_diamondSouth_to_diamondNorth_wav" , keepInAlert = false } )
end

this.routeSets01 = {
	
	mafr_diamondRiver_cp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_diamondRiver_c_0000",
				"rts_diamondRiver_c_0001",
				"rts_diamondRiver_c_0002",
				"rts_diamondRiver_c_0003",
				"rts_diamondRiver_c_0004",
				"rts_diamondRiver_c_0005",
				"rts_diamondRiver_c_0006",
				"rts_diamondRiver_c_0007",
			},
		},
		sneak_night= {
			groupA = {
				"rts_diamondRiver_c_0000",
				"rts_diamondRiver_c_0001",
				"rts_diamondRiver_c_0002",
				"rts_diamondRiver_c_0003",
				"rts_diamondRiver_c_0004",
				"rts_diamondRiver_c_0005",
				"rts_diamondRiver_c_0006",
				"rts_diamondRiver_c_0007",
			},
		},
		caution = {
			groupA = {
				"rts_diamondRiver_c_0000",
				"rts_diamondRiver_c_0001",
				"rts_diamondRiver_c_0002",
				"rts_diamondRiver_c_0003",
				"rts_diamondRiver_c_0004",
				"rts_diamondRiver_c_0005",
				"rts_diamondRiver_c_0006",
				"rts_diamondRiver_c_0007",
			},
		},
		hold = {
			default = {
			},
		},
		nil
	},
}




this.travelPlans = {
	
	travel_diamondWest_to_banana_wav = {
		ONE_WAY = true,
		{ cp = "mafr_diamondWest_ob", 	routeGroup={ "travel", "lrrp_diamondWest_to_banana_wav" } },
		{ cp = "mafr_08_10_lrrp", 		routeGroup={ "travel", "lrrp_diamondWest_to_banana_wav" } },
		{ cp = "mafr_bananaEast_ob", 	routeGroup={ "travel", "lrrp_diamondWest_to_banana_wav" } },
		{ cp = "mafr_08_25_lrrp", 		routeGroup={ "travel", "lrrp_diamondWest_to_banana_wav" } },
		{ cp = "mafr_banana_cp", 		routeGroup={ "travel", "lrrp_diamondWest_to_banana_wav" } },
		{ cp = "mafr_banana_cp", 		routeGroup={ "travel", "lrrp_diamondWest_to_banana_wav_back" } },
		{ cp = "mafr_banana_cp" },
	},
	travel_banana_to_diamondWest_wav = {
		ONE_WAY = true,
		{ cp = "mafr_banana_cp", 		routeGroup={ "travel", "lrrp_banana_to_diamondWest_wav" } },
		{ cp = "mafr_08_25_lrrp", 		routeGroup={ "travel", "lrrp_banana_to_diamondWest_wav" } },
		{ cp = "mafr_bananaEast_ob", 	routeGroup={ "travel", "lrrp_banana_to_diamondWest_wav" } },
		{ cp = "mafr_08_10_lrrp", 		routeGroup={ "travel", "lrrp_banana_to_diamondWest_wav" } },
		{ cp = "mafr_diamondWest_ob", 	routeGroup={ "travel", "lrrp_banana_to_diamondWest_wav" } },
		{ cp = "mafr_diamondWest_ob", 	routeGroup={ "travel", "lrrp_banana_to_diamondWest_wav2" } },
		{ cp = "mafr_diamondWest_ob" },
	},
	
	travel_savannahNorth_to_savannahWest_wav = {
		ONE_WAY = true,
		{ cp = "mafr_04_09_lrrp", 		routeGroup={ "travel", "lrrp_savannahNorth_to_savannahWest_wav" } },
		{ cp = "mafr_bananaSouth_ob", 	routeGroup={ "travel", "lrrp_savannahNorth_to_savannahWest_wav" } },
		{ cp = "mafr_04_07_lrrp", 		routeGroup={ "travel", "lrrp_savannahNorth_to_savannahWest_wav" } },
		{ cp = "mafr_04_07_lrrp" },
	},
	travel_savannahWest_to_savannahNorth_wav = {
		ONE_WAY = true,
		{ cp = "mafr_savannahWest_ob", 	routeGroup={ "travel", "lrrp_savannahWest_to_savannahNorth_wav" } },
		{ cp = "mafr_07_09_lrrp", 		routeGroup={ "travel", "lrrp_savannahWest_to_savannahNorth_wav" } },
		{ cp = "mafr_savannahNorth_ob", routeGroup={ "travel", "lrrp_savannahWest_to_savannahNorth_wav" } },
		{ cp = "mafr_savannahNorth_ob" },
	},
	
	travel_diamondNorth_to_diamondSouth_wav = {
		ONE_WAY = true,
		{ cp = "mafr_diamondNorth_ob", 		routeGroup={ "travel", "lrrp_diamondNorth_to_diamondSouth_wav" } },
		{ cp = "mafr_18_26_lrrp", 			routeGroup={ "travel", "lrrp_diamondNorth_to_diamondSouth_wav" } },
		{ cp = "mafr_diamond_cp", 			routeGroup={ "travel", "lrrp_diamondNorth_to_diamondSouth_wav" } },
		{ cp = "mafr_diamondWest_ob", 		routeGroup={ "travel", "lrrp_diamondNorth_to_diamondSouth_wav" } },
		{ cp = "mafr_10_11_lrrp", 			routeGroup={ "travel", "lrrp_diamondNorth_to_diamondSouth_wav" } },
		{ cp = "mafr_diamondSouth_ob", 		routeGroup={ "travel", "lrrp_diamondNorth_to_diamondSouth_wav" } },
		{ cp = "mafr_diamondSouth_ob", 		routeGroup={ "travel", "lrrp_diamondNorth_to_diamondSouth_wav_back" } },
		{ cp = "mafr_diamondSouth_ob" },
	},
	travel_diamondSouth_to_diamondNorth_wav = {
		ONE_WAY = true,
		{ cp = "mafr_diamondSouth_ob", 		routeGroup={ "travel", "lrrp_diamondSouth_to_diamondNorth_wav" } },
		{ cp = "mafr_10_11_lrrp", 			routeGroup={ "travel", "lrrp_diamondSouth_to_diamondNorth_wav" } },
		{ cp = "mafr_diamondWest_ob", 		routeGroup={ "travel", "lrrp_diamondSouth_to_diamondNorth_wav" } },
		{ cp = "mafr_diamond_cp", 			routeGroup={ "travel", "lrrp_diamondSouth_to_diamondNorth_wav" } },
		{ cp = "mafr_18_26_lrrp", 			routeGroup={ "travel", "lrrp_diamondSouth_to_diamondNorth_wav" } },
		{ cp = "mafr_diamondNorth_ob", 		routeGroup={ "travel", "lrrp_diamondSouth_to_diamondNorth_wav" } },
		{ cp = "mafr_diamondNorth_ob", 		routeGroup={ "travel", "lrrp_diamondSouth_to_diamondNorth_wav_back" } },
		{ cp = "mafr_diamondNorth_ob" },
	},
}




this.diamondRiver_RC_highLand = function()
	Fox.Log(" RouteChange : to higlLand ")
	TppEnemy.ChangeRouteSets( this.routeSets01 )
end




this.UniqueInterStart_TARGET = function( soldier2GameObjectId, cpID )

	local sequence = TppSequence.GetCurrentSequenceName()

	if svars.isReserveFlag_CNT_01 == 0	then
		TppInterrogation.UniqueInterrogation( cpID , "enqt1000_107041")
		
		if		sequence == "Seq_Game_BeforeRescueBoy"	then
			svars.isReserveFlag_CNT_01 = svars.isReserveFlag_CNT_01 + 1
		else
			svars.isReserveFlag_CNT_01 = svars.isReserveFlag_CNT_01 + 2
		end
		return true
	elseif svars.isReserveFlag_CNT_01 == 1	then
		if		sequence == "Seq_Game_BeforeRescueBoy"	then
			TppInterrogation.UniqueInterrogation( cpID , "enqt1000_101526")
		else
			TppInterrogation.UniqueInterrogation( cpID , "enqt1000_171010")
		end
		svars.isReserveFlag_CNT_01 = svars.isReserveFlag_CNT_01 + 1
		return true
	else
		return false
	
	end
end

this.UniqueInterEnd_TARGET_01 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : Unique : InterEnd_TARGET : InterName = " .. tostring(interName) )
end
this.UniqueInterEnd_TARGET_02 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : Unique : InterEnd_TARGET : InterName = " .. tostring(interName) )
	TppMission.UpdateObjective{ objectives = { "reduce_boySoldiers",}, }
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("mafr_diamond_cp"),
	{ 
		{ name = "enqt1000_1i1210",		func = s10100_enemy.InterCall_hostagePosition, },
	} )
end
this.UniqueInterEnd_TARGET_03 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : Unique : InterEnd_TARGET : InterName = " .. tostring(interName) )
end

this.uniqueInterrogation = {
	
	
	unique = {
		
		{ name = "enqt1000_107041",	func = this.UniqueInterEnd_TARGET_01, },	
		{ name = "enqt1000_101526",	func = this.UniqueInterEnd_TARGET_02, },	

		nil
	},
	
	uniqueChara = {
		{ name = "sol_target_0000", func = this.UniqueInterStart_TARGET, },
		nil
	},
	nil
}






this.InterCall_targetPosition = function( soldier2GameObjectId, cpID, interName )
	if svars.isTargetAttestation == false	then
		svars.isTargetInterrogation = true
		TppMission.UpdateObjective{				
			
			objectives = { "reduce_area_banana" },	
		}
		return true
	else
		
		Fox.Log(" isTargetHeadMarker == true ")
		return false	
	end
end

this.InterCall_acpPosition = function( soldier2GameObjectId, cpID, interName )
	TppMission.UpdateObjective{	 objectives = { "subTask_ACP01","subTask_ACP02","subTask_ACP03", },}
	svars.isReserveFlag_01 = true
	return true
end

this.InterCall_sniperA = function( soldier2GameObjectId, cpID, interName )
	TppMission.UpdateObjective{ objectives = { "snipaerA_Area", },}
	svars.isReserveFlag_03 = true
	return true
end

this.InterCall_sniperB = function( soldier2GameObjectId, cpID, interName )
	TppMission.UpdateObjective{ objectives = { "snipaerB_Area", },}
	svars.isReserveFlag_04 = true
	return true
end

this.InterCall_hostagePosition = function( soldier2GameObjectId, cpID, interName )
	TppMission.UpdateObjective{	objectives = { "reduce_boySoldiers_interro" },	}
	svars.isReserveFlag_02 = true
	return true
end

this.interrogation = {
	mafr_banana_cp = {		
		high = {	
			
			{ name = "enqt1000_101528",		func = this.InterCall_targetPosition, },
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	mafr_diamond_cp = {		
		high = {	
			
			{ name = "enqt1000_1i1210",		func = this.InterCall_hostagePosition, },
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	mafr_diamondWest_ob = {		
		high = {	
			
			{ name = "enqt1000_1c1010",		func = this.InterCall_acpPosition, },
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	mafr_diamondNorth_ob = {		
		high = {	
			
			{ name = "enqt1000_101521",		func = this.InterCall_sniperA, },
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	mafr_diamondSouth_ob = {		
		high = {	
			
			{ name = "enqt1000_101521",		func = this.InterCall_sniperB, },
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
	
	mafr_banana_cp			= true,
	mafr_diamond_cp			= true,
	mafr_diamondRiver_cp	= false,	
	mafr_diamondSwamp_cp	= false,	
	mafr_tracking_cp		= false,	
	s10100_sniperA_cp		= false,	
	s10100_sniperB_cp		= false,	
	mafr_savannahNorth_ob	= true,
	mafr_savannahWest_ob	= true,
	mafr_bananaEast_ob		= true,
	mafr_bananaSouth_ob		= true,
	mafr_diamondNorth_ob	= true,
	mafr_diamondSouth_ob	= true,
	mafr_diamondWest_ob		= true,
	nil
}




this.cpGroups = {
	group_Area3 = {
		
		"mafr_diamondSwamp_cp",
		"mafr_diamondRiver_cp",
		"mafr_tracking_cp",
		"s10100_wavAreaOut_cp",
		"s10100_sniperA_cp",
		"s10100_sniperB_cp",
	},
}



this.combatSetting = {
	mafr_banana_cp = {
		"gt_banana_0000",
		"cs_banana_0000",
	},
	mafr_diamond_cp = {
		"gt_diamond_0000",
		"cs_diamond_0000",
	},
	mafr_diamondSwamp_cp = {
		"gt_diamondSwamp_0000",
		"cs_diamondSwamp_0000",
	},
	mafr_diamondRiver_cp = {
		"gt_diamondRiver_0000",
		"cs_diamondRiver_0000",
	},
	mafr_tracking_cp = {
		"gt_diamondHill_0000",
		"cs_diamondHill_0000",
	},
	mafr_bananaEast_ob = {
		"gt_bananaEast_0000",
	},
	mafr_bananaSouth_ob = {
		"gt_bananaSouth_0000",
	},
	mafr_savannahNorth_ob = {
		"gt_savannahNorth_0000",
	},
	mafr_savannahWest_ob = {
		"gt_savannahWest_0000",
	},
	mafr_diamondNorth_ob = {
		"gt_diamondNorth_0000",
	},
	mafr_diamondWest_ob = {
		"gt_diamondWest_0000",
	},
	mafr_diamondSouth_ob = {
		"gt_diamondSouth_0000",
	},
	s10100_sniperA_cp = {
		"gt_sniperA_0000",
	},
	s10100_sniperB_cp = {
		"gt_sniperB_0000",
	},
	nil
}




function this.SetEnableSendMessageAimedFromPlayer()
	for i, enemyName in ipairs(this.voiceCall_enemyTable) do
		local gameObjectId = GameObject.GetGameObjectId( enemyName )
		GameObject.SendCommand( gameObjectId, { id = "SetEnableSendMessageAimedFromPlayer", enabled=true } )
	end
end





this.InitEnemy = function ()
end



this.SetUpEnemy = function ()

	
	local VoiceType_A		= { id = "SetVoiceType", voiceType = "chsol_a" }
	local VoiceType_B		= { id = "SetVoiceType", voiceType = "chsol_b" }
	local VoiceType_C		= { id = "SetVoiceType", voiceType = "chsol_c" }
	local VoiceType_D		= { id = "SetVoiceType", voiceType = "chsol_d" }
	
	local lrrpSetCommand	= { id = "SetLrrpCp" }
	local obSetCommand		= { id = "SetOuterBaseCp" }
	local command = {
			id = "SetHostage2Flag",
			flag = "commonNpc",
			on = false,
	}
	local boyLifeSetting	= { id = "SetMaxLife", life = 400, stamina = 800 }
	
	
	local wavDriverId_0000		= GameObject.GetGameObjectId("TppSoldier2", "sol_s10100_0000" )
	local wavDriverId_0001		= GameObject.GetGameObjectId("TppSoldier2", "sol_s10100_0001" )
	local wavDriverId_0002		= GameObject.GetGameObjectId("TppSoldier2", "sol_s10100_0002" )
	
	local wavVehicleId_0000		= GameObject.GetGameObjectId("TppVehicle2", "veh_s10100_0000" )
	local wavVehicleId_0001		= GameObject.GetGameObjectId("TppVehicle2", "veh_s10100_0001" )
	local wavVehicleId_0002		= GameObject.GetGameObjectId("TppVehicle2", "veh_s10100_0002" )
	
	local setWav_0000 			= { id="SetRelativeVehicle", targetId = wavVehicleId_0000	, rideFromBeginning = true }
	local setWav_0001 			= { id="SetRelativeVehicle", targetId = wavVehicleId_0001	, rideFromBeginning = true }
	local setWav_0002			= { id="SetRelativeVehicle", targetId = wavVehicleId_0002	, rideFromBeginning = true }
	
	GameObject.SendCommand( wavDriverId_0000	, setWav_0000 )
	GameObject.SendCommand( wavDriverId_0001	, setWav_0001 )
	GameObject.SendCommand( wavDriverId_0002	, setWav_0002 )
	
	this.wav0000_GO_01()
	this.wav0001_GO_01()
	this.wav0002_GO_01()
	
	TppEnemy.AssignUniqueStaffType{
        locaterName = "sol_target_0000",
        uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10100_BANANA_TARGET,	
        alreadyExistParam = { staffTypeId =58, randomRangeId =4, skill =nil },		
	}
	
	GameObject.SendCommand( GameObject.GetGameObjectId( "hos_diamond_0000" ) , command )
	
	GameObject.SendCommand( GameObject.GetGameObjectId( "hos_diamond_0000" ), boyLifeSetting )
	GameObject.SendCommand( GameObject.GetGameObjectId( "hos_diamond_0001" ), boyLifeSetting )
	GameObject.SendCommand( GameObject.GetGameObjectId( "hos_diamond_0002" ), boyLifeSetting )
	GameObject.SendCommand( GameObject.GetGameObjectId( "hos_diamond_0003" ), boyLifeSetting )
	GameObject.SendCommand( GameObject.GetGameObjectId( "hos_diamond_0004" ), boyLifeSetting )
	
	GameObject.SendCommand( GameObject.GetGameObjectId( "hos_diamond_0000" ), VoiceType_A )
	GameObject.SendCommand( GameObject.GetGameObjectId( "hos_diamond_0001" ), VoiceType_A )
	GameObject.SendCommand( GameObject.GetGameObjectId( "hos_diamond_0002" ), VoiceType_B )
	GameObject.SendCommand( GameObject.GetGameObjectId( "hos_diamond_0003" ), VoiceType_C )
	GameObject.SendCommand( GameObject.GetGameObjectId( "hos_diamond_0004" ), VoiceType_D )
	
	TppEnemy.RegisterCombatSetting( this.combatSetting )
	
	TppEnemy.SetEliminateTargets( { "sol_target_0000" } )
	TppEnemy.SetRescueTargets( { "hos_diamond_0000","hos_diamond_0001","hos_diamond_0002","hos_diamond_0003","hos_diamond_0004" }, { orCheck = true } )
	
	GameObject.SendCommand( GameObject.GetGameObjectId( "mafr_diamondSwamp_cp" ) , obSetCommand )
	GameObject.SendCommand( GameObject.GetGameObjectId( "mafr_diamondRiver_cp" ) , obSetCommand )
	GameObject.SendCommand( GameObject.GetGameObjectId( "mafr_tracking_cp" ) , obSetCommand )
	GameObject.SendCommand( GameObject.GetGameObjectId( "s10100_sniperA_cp" ) , obSetCommand )
	GameObject.SendCommand( GameObject.GetGameObjectId( "s10100_sniperB_cp" ) , obSetCommand )
	GameObject.SendCommand( GameObject.GetGameObjectId( "s10100_wavAreaOut_cp" ) , lrrpSetCommand )
	
	TppEnemy.SetSneakRoute( "sol_tracking_A_0000"  , "rts_tracking_A_default" )
	TppEnemy.SetCautionRoute( "sol_tracking_A_0000"  , "rts_tracking_A_default" )
	TppEnemy.SetSneakRoute( "sol_tracking_A_0001"  , "rts_tracking_A_default" )
	TppEnemy.SetCautionRoute( "sol_tracking_A_0001"  , "rts_tracking_A_default" )
	TppEnemy.SetSneakRoute( "sol_tracking_A_0002"  , "rts_tracking_A_default" )
	TppEnemy.SetCautionRoute( "sol_tracking_A_0002"  , "rts_tracking_A_default" )
	TppEnemy.SetSneakRoute( "sol_tracking_A_0003"  , "rts_tracking_A_default" )
	TppEnemy.SetCautionRoute( "sol_tracking_A_0003"  , "rts_tracking_A_default" )
	
	GameObject.SendCommand( GameObject.GetGameObjectId( "sol_diamondHill_0000" ) , { id="SetEnabled", enabled=false } )
	GameObject.SendCommand( GameObject.GetGameObjectId( "sol_diamondHill_0001" ) , { id="SetEnabled", enabled=false } )
	GameObject.SendCommand( GameObject.GetGameObjectId( "sol_diamondHill_0002" ) , { id="SetEnabled", enabled=false } )
	GameObject.SendCommand( GameObject.GetGameObjectId( "sol_diamondHill_0003" ) , { id="SetEnabled", enabled=false } )
	GameObject.SendCommand( GameObject.GetGameObjectId( "sol_diamondHill_0005" ) , { id="SetEnabled", enabled=false } )
	GameObject.SendCommand( GameObject.GetGameObjectId( "sol_diamondHill_0006" ) , { id="SetEnabled", enabled=false } )
	GameObject.SendCommand( GameObject.GetGameObjectId( "sol_diamondHill_0008" ) , { id="SetEnabled", enabled=false } )
	GameObject.SendCommand( GameObject.GetGameObjectId( "sol_diamondHill_0009" ) , { id="SetEnabled", enabled=false } )
	
	TppEnemy.RegistHoldRecoveredState("sol_sniperA_0000")
	TppEnemy.RegistHoldRecoveredState("sol_sniperA_0001")
	TppEnemy.RegistHoldRecoveredState("sol_sniperA_0002")
	TppEnemy.RegistHoldRecoveredState("sol_sniperB_0000")
	TppEnemy.RegistHoldRecoveredState("sol_sniperB_0001")
	TppEnemy.RegistHoldRecoveredState("veh_s10100_0000")
	TppEnemy.RegistHoldRecoveredState("veh_s10100_0001")
	TppEnemy.RegistHoldRecoveredState("veh_s10100_0002")
	
	this.SetEnableSendMessageAimedFromPlayer()	
end


this.OnLoad = function ()
	Fox.Log("*** s10100 onload ***")
end




return this
