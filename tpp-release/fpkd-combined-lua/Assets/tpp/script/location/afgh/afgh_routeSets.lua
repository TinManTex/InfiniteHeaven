-- DOBUILD: 0 --DEBUGNOW
-- ORIGINALQAR: chunk2
-- PACKPATH: \Assets\tpp\pack\location\afgh\pack_common\afgh_script.fpkd
local afgh_routeSets



--afgh_routeSets
--referenced via location script, /Assets/tpp/script/location/afgh/afgh.lua .requires
--this (or mafr equivalent) is merged with the mission routeset (if the cp has USE_COMMON_ROUTE_SETS = true)
--See header of InfRouteSet for more info on routesets
--See TppEnemy.RegisterRouteSet, UpdateRouteSet
--RouteSelector, GetPrioritizedRouteTable
--and see afgh_citadel_cp below for commented cp entry
afgh_routeSets = {

	
	
	
	
	
	afgh_field_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		sneak_day = {
			groupA = {
				"rt_field_d_0000", 
				"rt_field_d_0002", 
				"rt_field_d_0012", 
				"rt_field_d_0013", 
			},
			groupB = {
				"rt_field_d_0011",
				"rt_field_d_0010_sub", 
				"rt_field_d_0014", 
				"rt_field_d_0006", 
			},
			groupC = {
				"rt_field_d_0005", 
				"rt_field_d_0008", 
				"rt_field_d_0007", 
				"rt_field_d_0009", 
			},
			groupD = {
				"rt_field_d_0015", 
				"rt_field_d_0004", 
				"rt_field_d_0001", 
				"rt_field_d_0003", 
			},
		},
		sneak_night= {
			groupA = {
				"rt_field_n_0000", 
				"rt_field_n_0007_sub", 
				"rt_field_n_0006",
				"rt_field_n_0004", 
			},
			groupB = {
				"rt_field_n_0001_sub", 
				"rt_field_n_0004", 
				"rt_field_n_0008", 
				"rt_field_n_0004", 
			},
			groupC = {
				"rt_field_n_0005", 
				"rt_field_n_0010_sub", 
				"rt_field_n_0011", 
				"rt_field_n_0002", 
			},
			groupD = {
				"rt_field_n_0009_sub",
				"rt_field_n_0012", 
				"rt_field_n_0005", 
				"rt_field_n_0003", 
			},
		},
		caution = {
			groupA = {
				"rt_field_c_0011",
				"rt_field_c_0006",
				"rt_field_c_0003",
				"rt_field_c_0004",
				"rt_field_c_0005",
				"rt_field_c_0000",
				"rt_field_c_0001",
				"rt_field_c_0002",
				"rt_field_c_0009",
				"rt_field_c_0010",
				"rt_field_c_0007",
				"rt_field_c_0008",
				"rt_field_c_0011",
				"rt_field_c_0009",
				"rt_field_c_0010",
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
				"rt_field_h_0000",
				"rt_field_h_0001",
				"rt_field_h_0002",
				"rt_field_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_field_s_0000",
				"rt_field_s_0001",
				"rt_field_s_0002",
				"rt_field_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_field_l_0000",
				"rt_field_l_0001",
			},
			in_lrrpHold_E = {
				"rt_field_lin_E",
				"rt_field_lin_E",
			},
			out_lrrpHold_E = {
				"rt_field_lout_E",
				"rt_field_lout_E",
			},
			in_lrrpHold_W = {
				"rt_field_lin_W",
				"rt_field_lin_W",
			},
			out_lrrpHold_W = {
				"rt_field_lout_W",
				"rt_field_lout_W",
			},
		},
		outofrain = {
			"rt_field_r_0000",
			"rt_field_r_0001",
			"rt_field_r_0002",
			"rt_field_r_0003",
			"rt_field_r_0004",
			"rt_field_r_0005",
			"rt_field_r_0006",
			"rt_field_r_0007",
			"rt_field_r_0008",
			"rt_field_r_0009",
			"rt_field_r_0010",
			"rt_field_r_0011",
			"rt_field_r_0012",
			"rt_field_r_0013",
			"rt_field_r_0014",
			"rt_field_r_0015",
			"rt_field_r_0016",
		},
		nil
	},
	
	afgh_remnants_cp = {
		priority = {
			"groupSniper",
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		fixedShiftChangeGroup = {
			"groupSniper",
		},
		sneak_day = {
			groupSniper = {
				{ "rt_remnants_snp_0000", attr = "SNIPER" },
				{ "rt_remnants_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_remnants_d_0000",	
				"rt_remnants_d_0001",	
				"rt_remnants_d_0002",	
			},
			groupB = {
				"rt_remnants_d_0003",	
				"rt_remnants_d_0004",	
				"rt_remnants_d_0005",	
			},
			groupC = {
				"rt_remnants_d_0006",	
				"rt_remnants_d_0007",	
				"rt_remnants_d_0008",	
			},
			groupD = {
				"rt_remnants_d_0009",	
				"rt_remnants_d_0010",	
				"rt_remnants_d_0011",	


			},
		},
		sneak_night= {
			groupSniper = {
				{ "rt_remnants_snp_0000", attr = "SNIPER" },
				{ "rt_remnants_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_remnants_n_0000_sub",	
				"rt_remnants_n_0001_sub",	
				"rt_remnants_n_0002_sub",	
			},
			groupB = {
				"rt_remnants_n_0003",	
				"rt_remnants_n_0004",	
				"rt_remnants_n_0005",	
			},
			groupC = {
				"rt_remnants_n_0006_sub",	
				"rt_remnants_n_0007",	
				"rt_remnants_n_0008",	
			},
			groupD = {
				"rt_remnants_n_0009",	
				"rt_remnants_n_0010",	
				"rt_remnants_n_0011",	
			},
		},
		caution = {
			groupSniper = {
				{ "rt_remnants_snp_0000", attr = "SNIPER" },
				{ "rt_remnants_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_remnants_c_0000",	
				"rt_remnants_c_0001",	
				"rt_remnants_c_0002",	
				"rt_remnants_c_0006",	
				"rt_remnants_c_0007",	
				"rt_remnants_c_0008",	
				"rt_remnants_c_0009",	
				"rt_remnants_c_0010",	
				"rt_remnants_c_0011",	
				"rt_remnants_c_0003",	
				"rt_remnants_c_0004",	
				"rt_remnants_c_0005",	
				"rt_remnants_c_0012",	
				"rt_remnants_c_0013",	
				"rt_remnants_c_0014",	
				"rt_remnants_c_0015",	
			},
			groupB = {
			},
			groupC = {
			},
			groupD = {
			},
		},
		hold = {
			groupSniper = {
			},
			default = {
				"rt_remnants_h_0000",
				"rt_remnants_h_0001",
				"rt_remnants_h_0002",
				"rt_remnants_h_0003",
			},
		},
		sleep = {
			groupSniper = {
			},
			default = {
				"rt_remnants_s_0000",
				"rt_remnants_s_0001",
				"rt_remnants_s_0002",
				"rt_remnants_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_remnants_l_0000",
				"rt_remnants_l_0001",
			},
			in_lrrpHold_N = {
				"rt_remnants_lin_N",
				"rt_remnants_lin_N",
			},
			out_lrrpHold_B01 = {
				"rt_remnants_lout_B01",
				"rt_remnants_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_remnants_lout_B02",
				"rt_remnants_lout_B02",
			},
			out_lrrpHold_B03 = {
				"rt_remnants_lout_B03",
				"rt_remnants_lout_B03",
			},
		},
		outofrain = {
			"rt_remnants_r_0000",
			"rt_remnants_r_0001",
			"rt_remnants_r_0002",
			"rt_remnants_r_0003",
			"rt_remnants_r_0004",
			"rt_remnants_r_0005",
			"rt_remnants_r_0006",
			"rt_remnants_r_0007",
			"rt_remnants_r_0008",
			"rt_remnants_r_0009",
			"rt_remnants_r_0010",
			"rt_remnants_r_0011",
			"rt_remnants_r_0012",
			"rt_remnants_r_0013",
			"rt_remnants_r_0014",
			"rt_remnants_r_0015",
			"rt_remnants_r_0016",
			"rt_remnants_r_0017",
			"rt_remnants_r_0018",
			"rt_remnants_r_0019",
		},
		nil
	},
	
	afgh_tent_cp = {
		priority = {
			"groupSniper",
			"groupA",
			"groupB",
			"groupC",
			"groupD",
			"groupE",
		},
		fixedShiftChangeGroup = {
			"groupSniper",
		},
		sneak_day = {
			groupSniper = {
				{ "rt_tent_snp_0000", attr = "SNIPER" },
				{ "rt_tent_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_tent_d_0000",	
				"rt_tent_d_0001",	
				"rt_tent_d_0002",	
				"rt_tent_d_0003",	
			},
			groupB = {
				"rt_tent_d_0004",	
				"rt_tent_d_0005",	
				"rt_tent_d_0006",	
				"rt_tent_d_0007",	
			},
			groupC = {
				"rt_tent_d_0008_sub",	
				"rt_tent_d_0009",	
				"rt_tent_d_0010",	
				"rt_tent_d_0011",	
			},
			groupD = {
				"rt_tent_d_0012",	
				"rt_tent_d_0013",	
				"rt_tent_d_0014",	
				"rt_tent_d_0015",	
			},
			groupE = {
				"rt_tent_d_0016",	
				"rt_tent_d_0017",	
				"rt_tent_d_0018",	
				"rt_tent_d_0019",	
			},
		},
		sneak_night= {
			groupSniper = {
				{ "rt_tent_snp_0000", attr = "SNIPER" },
				{ "rt_tent_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_tent_n_0000",	
				"rt_tent_n_0001",	
				"rt_tent_n_0002",	
				"rt_tent_n_0003",	
			},
			groupB = {
				"rt_tent_n_0004_sub",	
				"rt_tent_n_0005_sub",	
				"rt_tent_n_0006",	
				"rt_tent_n_0007",	
			},
			groupC = {
				"rt_tent_n_0008_sub",	
				"rt_tent_n_0009",	
				"rt_tent_n_0010",	
				"rt_tent_n_0011",	
			},
			groupD = {
				"rt_tent_n_0012",	
				"rt_tent_n_0013",	
				"rt_tent_n_0014",	
				"rt_tent_n_0015",	
			},
			groupE = {
				"rt_tent_n_0016",	
				"rt_tent_n_0017",	
				"rt_tent_n_0018",	
				"rt_tent_n_0019",	
			},
		},
		caution = {
			groupSniper = {
				{ "rt_tent_snp_0000", attr = "SNIPER" },
				{ "rt_tent_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_tent_c_0000",	
				"rt_tent_c_0001",	
				"rt_tent_c_0002",	
				"rt_tent_c_0003",	
				"rt_tent_c_0004",	
				"rt_tent_c_0005",	
				"rt_tent_c_0006",	
				"rt_tent_c_0007",	
				"rt_tent_c_0008",	
				"rt_tent_c_0009",	
				"rt_tent_c_0010",	
				"rt_tent_c_0011",	
				"rt_tent_c_0012",	
				"rt_tent_c_0013",	
				"rt_tent_c_0014",	
				"rt_tent_c_0015",	
				"rt_tent_c_0016",	
				"rt_tent_c_0017",	
				"rt_tent_c_0018",	
				"rt_tent_c_0019",	
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
			groupSniper = {
			},
			default = {
				"rt_tent_h_0000",
				"rt_tent_h_0001",
				"rt_tent_h_0002",
				"rt_tent_h_0003",
			},
		},
		sleep = {
			groupSniper = {
			},
			default = {
				"rt_tent_s_0000",
				"rt_tent_s_0001",
				"rt_tent_s_0002",
				"rt_tent_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_tent_l_0000",
				"rt_tent_l_0001",
			},
			in_lrrpHold_S = {
				"rt_tent_lin_S",
				"rt_tent_lin_S",
			},
			out_lrrpHold_N = {
				"rt_tent_lout_N",
				"rt_tent_lout_N",
			},
		},
		outofrain = {
			"rt_tent_r_0000",
			"rt_tent_r_0001",
			"rt_tent_r_0002",
			"rt_tent_r_0003",
			"rt_tent_r_0004",
			"rt_tent_r_0005",
			"rt_tent_r_0006",
			"rt_tent_r_0007",
			"rt_tent_r_0008",
			"rt_tent_r_0009",
			"rt_tent_r_0010",
			"rt_tent_r_0011",
			"rt_tent_r_0012",
			"rt_tent_r_0013",
			"rt_tent_r_0014",
			"rt_tent_r_0015",
			"rt_tent_r_0016",
			"rt_tent_r_0017",
			"rt_tent_r_0018",
			"rt_tent_r_0019",
		},
		nil
	},
	
	
	
	
	afgh_fieldEast_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_fieldEast_d_0000",
				"rt_fieldEast_d_0003",
			},
			groupB = {
				"rt_fieldEast_d_0001",
				"rt_fieldEast_d_0003",
			},
			groupC = {
				"rt_fieldEast_d_0002",
			},
		},
		sneak_night = {
			groupA = {
				"rt_fieldEast_n_0000",
				"rt_fieldEast_n_0003",
			},
			groupB = {
				"rt_fieldEast_n_0001",
				"rt_fieldEast_n_0003",
			},
			groupC = {
				"rt_fieldEast_n_0002",
			},
		},
		caution = {
			groupA = {
				"rt_fieldEast_c_0000",
				"rt_fieldEast_c_0001",
				"rt_fieldEast_c_0002",
				"rt_fieldEast_c_0003",
				"rt_fieldEast_c_0003",
				"rt_fieldEast_c_0001",
				"rt_fieldEast_c_0002",
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
				"rt_fieldEast_s_0000",
				"rt_fieldEast_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_fieldEast_l_0000",
				"rt_fieldEast_l_0001",
			},
			in_lrrpHold_W = {
				"rt_fieldEast_lin_W",
				"rt_fieldEast_lin_W",
			},
			out_lrrpHold_W = {
				"rt_fieldEast_lout_W",
				"rt_fieldEast_lout_W",
			},
			out_lrrpHold_B01 = {
				"rt_fieldEast_lout_B01",
				"rt_fieldEast_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_fieldEast_lout_B02",
				"rt_fieldEast_lout_B02",
			},
		},
		outofrain = {
			"rt_fieldEast_r_0000",
			"rt_fieldEast_r_0001",
			"rt_fieldEast_r_0002",
			"rt_fieldEast_r_0003",
			"rt_fieldEast_r_0004",
			"rt_fieldEast_r_0005",
			"rt_fieldEast_r_0006",
			"rt_fieldEast_r_0007",
		},
		nil
	},

	
	afgh_remnantsNorth_ob = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rt_remnantsNorth_d_0000",
				"rt_remnantsNorth_d_0002",
			},
			groupB = {
				"rt_remnantsNorth_d_0001",
				"rt_remnantsNorth_d_0003",
			},
		},
		sneak_night= {
			groupA = {
				"rt_remnantsNorth_n_0000",
				"rt_remnantsNorth_n_0002",
			},
			groupB = {
				"rt_remnantsNorth_n_0001",
				"rt_remnantsNorth_n_0003",
			},
		},
		caution = {
			groupA = {
				"rt_remnantsNorth_c_0000",
				"rt_remnantsNorth_c_0001",
				"rt_remnantsNorth_c_0002",
				"rt_remnantsNorth_c_0002",
				"rt_remnantsNorth_c_0000",
				"rt_remnantsNorth_c_0001",
			},
			groupB = {
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_remnantsNorth_s_0000",
				"rt_remnantsNorth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_remnantsNorth_l_0000",
				"rt_remnantsNorth_l_0001",
			},
			in_lrrpHold_N = {
				"rt_remnantsNorth_lin_N",
				"rt_remnantsNorth_lin_N",
			},
			out_lrrpHold_N = {
				"rt_remnantsNorth_lout_N",
				"rt_remnantsNorth_lout_N",
			},
			in_lrrpHold_S = {
				"rt_remnantsNorth_lin_S",
				"rt_remnantsNorth_lin_S",
			},
			out_lrrpHold_S = {
				"rt_remnantsNorth_lout_S",
				"rt_remnantsNorth_lout_S",
			},
		},
		outofrain = {
			"rt_remnantsNorth_r_0000",
			"rt_remnantsNorth_r_0001",
			"rt_remnantsNorth_r_0002",
			"rt_remnantsNorth_r_0003",
			"rt_remnantsNorth_r_0004",
			"rt_remnantsNorth_r_0005",
			"rt_remnantsNorth_r_0006",
			"rt_remnantsNorth_r_0007",
		},
		nil
	},
	
	afgh_fieldWest_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_fieldWest_d_0000",
				"rt_fieldWest_d_0003",
				
			},
			groupB = {
				"rt_fieldWest_d_0001_sub",
				"rt_fieldWest_d_0004",
			},
			groupC = {
				"rt_fieldWest_d_0002",
				
			},
		},
		sneak_night= {
			groupA = {
				"rt_fieldWest_n_0000",
				"rt_fieldWest_n_0003",
				
			},
			groupB = {
				"rt_fieldWest_n_0001_sub",
				"rt_fieldWest_n_0004",
			},
			groupC = {
				"rt_fieldWest_n_0002",
				
			},
		},
		caution = {
			groupA = {
				"rt_fieldWest_c_0000",
				"rt_fieldWest_c_0001",
				"rt_fieldWest_c_0002",
				"rt_fieldWest_c_0003",
				"rt_fieldWest_c_0004",
				
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
				"rt_fieldWest_s_0000",
				"rt_fieldWest_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_fieldWest_l_0000",
				"rt_fieldWest_l_0001",
			},
			in_lrrpHold_S = {
				"rt_fieldWest_lin_S",
				"rt_fieldWest_lin_S",
			},
			out_lrrpHold_B01 = {
				"rt_fieldWest_lout_B01",
				"rt_fieldWest_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_fieldWest_lout_B02",
				"rt_fieldWest_lout_B02",
			},
			out_lrrpHold_B03 = {
				"rt_fieldWest_lout_B03",
				"rt_fieldWest_lout_B03",
			},
		},
		outofrain = {
			"rt_fieldWest_r_0000",
			"rt_fieldWest_r_0001",
			"rt_fieldWest_r_0002",
			"rt_fieldWest_r_0003",
			"rt_fieldWest_r_0004",
			"rt_fieldWest_r_0005",
			"rt_fieldWest_r_0006",
			"rt_fieldWest_r_0007",
		},
		nil
	},

	
	afgh_tentEast_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_tentEast_d_0000_sub",
				"rt_tentEast_d_0004",
			},
			groupB = {
				"rt_tentEast_d_0002",
				"rt_tentEast_d_0003",
			},
			groupC = {
				"rt_tentEast_d_0001",
				"rt_tentEast_d_0005",
			},
		},
		sneak_night= {
			groupA = {
				"rt_tentEast_n_0000_sub",
				"rt_tentEast_n_0004",
			},
			groupB = {
				"rt_tentEast_n_0002",
				"rt_tentEast_n_0003",
			},
			groupC = {
				"rt_tentEast_n_0001",
				"rt_tentEast_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_tentEast_c_0000",
				"rt_tentEast_c_0001",
				"rt_tentEast_c_0002",
				"rt_tentEast_c_0003",
				"rt_tentEast_c_0000",
				"rt_tentEast_c_0001",
				"rt_tentEast_c_0004",
				"rt_tentEast_c_0005",
				"rt_tentEast_c_0006",
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
				"rt_tentEast_s_0000",
				"rt_tentEast_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_tentEast_l_0000",
				"rt_tentEast_l_0001",
			},
		},
		outofrain = {
			"rt_tentEast_r_0000",
			"rt_tentEast_r_0001",
			"rt_tentEast_r_0002",
			"rt_tentEast_r_0003",
			"rt_tentEast_r_0004",
			"rt_tentEast_r_0005",
		},
		nil
	},

	
	afgh_tentNorth_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_tentNorth_d_0000",
				"rt_tentNorth_d_0001",
			},
			groupB = {
				"rt_tentNorth_d_0002",
				"rt_tentNorth_d_0003",
			},
			groupC = {
				"rt_tentNorth_d_0004",
				"rt_tentNorth_d_0005",
			},
		},
		sneak_night= {
			groupA = {
				"rt_tentNorth_n_0000",
				"rt_tentNorth_n_0001",
			},
			groupB = {
				"rt_tentNorth_n_0002",
				"rt_tentNorth_n_0003",
			},
			groupC = {
				"rt_tentNorth_n_0004",
				"rt_tentNorth_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_tentNorth_c_0000",
				"rt_tentNorth_c_0001",
				"rt_tentNorth_c_0002",
				"rt_tentNorth_c_0003",
				"rt_tentNorth_c_0004",
				"rt_tentNorth_c_0005",
				"rt_tentNorth_c_0006",
				"rt_tentNorth_c_0007",
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
				"rt_tentNorth_s_0000",
				"rt_tentNorth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_tentNorth_l_0000",
				"rt_tentNorth_l_0001",
			},
		},
		outofrain = {
			"rt_tentNorth_r_0000",
			"rt_tentNorth_r_0001",
			"rt_tentNorth_r_0002",
			"rt_tentNorth_r_0003",
			"rt_tentNorth_r_0004",
			"rt_tentNorth_r_0005",
			"rt_tentNorth_r_0006",
			"rt_tentNorth_r_0007",
		},
		nil
	},
	
	
	
	
	afgh_village_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		sneak_day = {
			groupA = {
				"rt_village_d_0000",
				"rt_village_d_0001",	
				"rt_village_d_0007",
			},
			groupB = {
				"rt_village_d_0002",
				"rt_village_d_0003",
				"rt_village_d_0004",
			},
			groupC = {
				"rt_village_d_0005",
				"rt_village_d_0006",
				"rt_village_d_0008",
			},
			groupD = {
				"rt_village_d_0009",
				"rt_village_d_0010",
				"rt_village_d_0001",	
			},
		},
		sneak_night= {
			groupA = {
				"rt_village_n_0000",
				"rt_village_n_0001",
				"rt_village_n_0002",
			},
			groupB = {
				"rt_village_n_0003",
				"rt_village_n_0004",	
				"rt_village_n_0005",
			},
			groupC = {
				"rt_village_n_0006",
				"rt_village_n_0007",
				"rt_village_n_0008",
			},
			groupD = {
				"rt_village_n_0009",
				"rt_village_n_0010",
				"rt_village_n_0004",	
			},
		},
		caution = {
			groupA = {
				"rt_village_c_0000",
				"rt_village_c_0003",
				"rt_village_c_0007",
				"rt_village_c_0004",	
				"rt_village_c_0004",	
				"rt_village_c_0006",	
				"rt_village_c_0006",	
				"rt_village_c_0005",
				"rt_village_c_0001",
				"rt_village_c_0002",
				"rt_village_c_0008",
				"rt_village_c_0009",
				"rt_village_c_0007",
				"rt_village_c_0008",
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
				"rt_village_h_0000",
				"rt_village_h_0001",
				"rt_village_h_0002",
				"rt_village_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_village_s_0000",
				"rt_village_s_0001",
				"rt_village_s_0002",
				"rt_village_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_village_l_0000",
				"rt_village_l_0001",
			},
			in_lrrpHold_E = {
				"rt_village_lin_E",
				"rt_village_lin_E",
			},
			out_lrrpHold_E = {
				"rt_village_lout_E",
				"rt_village_lout_E",
			},
			in_lrrpHold_W = {
				"rt_village_lin_W",
				"rt_village_lin_W",
			},
			out_lrrpHold_W = {
				"rt_village_lout_W",
				"rt_village_lout_W",
			},
		},
		outofrain = {
				"rt_village_r_0000",
				"rt_village_r_0001",
				"rt_village_r_0002",
				"rt_village_r_0003",
				"rt_village_r_0004",
				"rt_village_r_0005",
				"rt_village_r_0006",
		},

		nil
	},
	
	afgh_slopedTown_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				
				"rt_slopedTown_d_0006",
				"rt_slopedTown_d_0004",
				"rt_slopedTown_d_0000",
				"rt_slopedTown_d_0005",
			},
			groupB = {
				
				"rt_slopedTown_d_0002",
				"rt_slopedTown_d_0003",
				"rt_slopedTown_d_0010",
				"rt_slopedTown_d_0001",
			},
			groupC = {
				
				"rt_slopedTown_d_0008",
				"rt_slopedTown_d_0009",
				"rt_slopedTown_d_0011",
				"rt_slopedTown_d_0010",
			},
		},
		sneak_night= {
			groupA = {
				
				"rt_slopedTown_n_0000",
				"rt_slopedTown_n_0001",
				"rt_slopedTown_n_0006",
				"rt_slopedTown_n_0007",
			},
			groupB = {
				
				"rt_slopedTown_n_0002",
				"rt_slopedTown_n_0003",
				"rt_slopedTown_n_0004",
				"rt_slopedTown_n_0008",
			},
			groupC = {
				
				"rt_slopedTown_n_0009",
				"rt_slopedTown_n_0010",
				"rt_slopedTown_n_0008",
				"rt_slopedTown_n_0006",
			},
		},
		caution = {
			groupA = {
				"rt_slopedTown_c_0004",
				"rt_slopedTown_c_0009",
				"rt_slopedTown_c_0005",
				"rt_slopedTown_c_0006",
				"rt_slopedTown_c_0003",
				"rt_slopedTown_c_0000",
				"rt_slopedTown_c_0001",
				"rt_slopedTown_c_0002",
				"rt_slopedTown_c_0007",
				"rt_slopedTown_c_0008",
				"rt_slopedTown_c_0009",
				"rt_slopedTown_c_0005",
				"rt_slopedTown_c_0006",
			},
			groupB = {
			},
			groupC = {
			},
		},
		hold = {
			default = {
				"rt_slopedTown_h_0000",
				"rt_slopedTown_h_0001",
				"rt_slopedTown_h_0002",
				"rt_slopedTown_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_slopedTown_s_0000",
				"rt_slopedTown_s_0001",
				"rt_slopedTown_s_0002",
				"rt_slopedTown_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_slopedTown_l_0000",
				"rt_slopedTown_l_0001",
			},
			in_lrrpHold_W = {
				"rt_slopedTown_lin_W",
				"rt_slopedTown_lin_W",
			},
			out_lrrpHold_W = {
				"rt_slopedTown_lout_W",
				"rt_slopedTown_lout_W",
			},
			out_lrrpHold_B01 = {
				"rt_slopedTown_lout_B01",
				"rt_slopedTown_lout_B01",
			},
		},
		nil
	},
	
	afgh_commFacility_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
			"groupE",
		},
		sneak_day = {
			groupA = {
				"rt_commFacility_d_0000",
				"rt_commFacility_d_0007",
			},
			groupB = {
				"rt_commFacility_d_0003",
				"rt_commFacility_d_0001",
			},
			groupC = {
				"rt_commFacility_d_0006",
				"rt_commFacility_d_0005",
			},
			groupD = {
				"rt_commFacility_d_0000",
				"rt_commFacility_d_0002",
			},
			groupE = {
				"rt_commFacility_d_0004",
			},
		},
		sneak_night = {
			groupA = {
				"rt_commFacility_n_0000",
				"rt_commFacility_n_0007",
			},
			groupB = {
				"rt_commFacility_n_0003",
				"rt_commFacility_n_0002",
			},
			groupC = {
				"rt_commFacility_n_0006",
				"rt_commFacility_n_0005",
			},
			groupD = {
				"rt_commFacility_n_0001",
				"rt_commFacility_n_0008",
			},
			groupE = {
				"rt_commFacility_n_0004",
			},
		},
		caution = {
			groupA = {
				"rt_commFacility_c_0000",
				"rt_commFacility_c_0001",
				"rt_commFacility_c_0002",
				"rt_commFacility_c_0003",
				"rt_commFacility_c_0005",
				"rt_commFacility_c_0005",
				"rt_commFacility_c_0004",
				"rt_commFacility_c_0006",
				"rt_commFacility_c_0006",
				"rt_commFacility_c_0005",
				"rt_commFacility_c_0006",
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
				"rt_commFacility_h_0000",
				"rt_commFacility_h_0001",
				"rt_commFacility_h_0002",
				"rt_commFacility_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_commFacility_s_0000",
				"rt_commFacility_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_commFacility_l_0000",
				"rt_commFacility_l_0001",
			},
			in_lrrpHold_E = {
				"rt_commFacility_lin_E",
				"rt_commFacility_lin_E",
			},
			out_lrrpHold_E = {
				"rt_commFacility_lout_E",
				"rt_commFacility_lout_E",
			},
			in_lrrpHold_W = {
				"rt_commFacility_lin_W",
				"rt_commFacility_lin_W",
			},
			out_lrrpHold_W = {
				"rt_commFacility_lout_W",
				"rt_commFacility_lout_W",
			},
		},
		outofrain = {
			"rt_commFacility_r_0000",
			"rt_commFacility_r_0001",
			"rt_commFacility_r_0002",
			"rt_commFacility_r_0003",
			"rt_commFacility_r_0004",
			"rt_commFacility_r_0005",
			"rt_commFacility_r_0006",
			"rt_commFacility_r_0007",
			"rt_commFacility_r_0008",
			"rt_commFacility_r_0009",
			"rt_commFacility_r_0010",
		},
		nil
	},
	
	afgh_enemyBase_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
			"groupE",
		},
		sneak_day = {
			groupA = {
				"rt_enemyBase_d_0000",
				"rt_enemyBase_d_0005",
				"rt_enemyBase_d_0008",
				"rt_enemyBase_d_0013",
			},
			groupB = {
				"rt_enemyBase_d_0001",
				"rt_enemyBase_d_0006",	
				"rt_enemyBase_d_0009",
				"rt_enemyBase_d_0014",
			},
			groupC = {
				"rt_enemyBase_d_0002_sub",
				"rt_enemyBase_d_0006",	
				"rt_enemyBase_d_0010",
				"rt_enemyBase_d_0015",
			},
			groupD = {
				"rt_enemyBase_d_0003",
				"rt_enemyBase_d_0007",	
				"rt_enemyBase_d_0011",
				"rt_enemyBase_d_0016",
			},
			groupE = {
				"rt_enemyBase_d_0004",
				"rt_enemyBase_d_0007",	
				"rt_enemyBase_d_0012",
				"rt_enemyBase_d_0017",
			},
			nil
		},
		sneak_night = {
			groupA = {
				"rt_enemyBase_n_0000",
				"rt_enemyBase_n_0005_sub",
				"rt_enemyBase_n_0010",
				"rt_enemyBase_n_0015",
			},
			groupB = {
				"rt_enemyBase_n_0001",
				"rt_enemyBase_n_0006",
				"rt_enemyBase_n_0011",
				"rt_enemyBase_n_0016",
			},
			groupC = {
				"rt_enemyBase_n_0002",
				"rt_enemyBase_n_0007",
				"rt_enemyBase_n_0012_sub",
				"rt_enemyBase_n_0017",
			},
			groupD = {
				"rt_enemyBase_n_0003",
				"rt_enemyBase_n_0008",
				"rt_enemyBase_n_0013",
				"rt_enemyBase_n_0018",
			},
			groupE = {
				"rt_enemyBase_n_0004",
				"rt_enemyBase_n_0009_sub",
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
			groupE = {
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
				"rt_enemyBase_lin_S",
				"rt_enemyBase_lin_S",
			},
			in_lrrpHold_N = {
				"rt_enemyBase_lin_N",
				"rt_enemyBase_lin_N",
			},
			
			out_lrrpHold_S = {
				"rt_enemyBase_lout_S",
				"rt_enemyBase_lout_S",
			},
			out_lrrpHold_N = {
				"rt_enemyBase_lout_N",
				"rt_enemyBase_lout_N",
			},
		},
		outofrain = {
			"rt_enemyBase_r_0000",
			"rt_enemyBase_r_0001",
			"rt_enemyBase_r_0002",
			"rt_enemyBase_r_0003",
			"rt_enemyBase_r_0004",
			"rt_enemyBase_r_0005",
			"rt_enemyBase_r_0006",
			"rt_enemyBase_r_0007",
			"rt_enemyBase_r_0008",
			"rt_enemyBase_r_0009",
			"rt_enemyBase_r_0010",
			"rt_enemyBase_r_0011",
			"rt_enemyBase_r_0012",
			"rt_enemyBase_r_0013",
			"rt_enemyBase_r_0014",
			"rt_enemyBase_r_0015",
			"rt_enemyBase_r_0016",
			"rt_enemyBase_r_0017",
			"rt_enemyBase_r_0018",
			"rt_enemyBase_r_0019",
		},
		nil
	},
	
	
	
	
	afgh_commWest_ob = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rt_commWest_d_0000",
				"rt_commWest_d_0002",
			},
			groupB = {
				"rt_commWest_d_0001_sub",
				"rt_commWest_d_0003",
			},
		},
		sneak_night = {
			groupA = {
				"rt_commWest_n_0000",
				"rt_commWest_n_0002_sub",
			},
			groupB = {
				"rt_commWest_n_0001",
				"rt_commWest_n_0003",
			},
		},
		caution = {
			groupA = {
				"rt_commWest_c_0000",
				"rt_commWest_c_0001",
				"rt_commWest_c_0002",
				"rt_commWest_c_0003",
				"rt_commWest_c_0002",
				"rt_commWest_c_0003",
			},
			groupB = {
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_commWest_s_0000",
				"rt_commWest_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_commWest_l_0000",
				"rt_commWest_l_0001",
			},
			in_lrrpHold_E = {
				"rt_commWest_lin_E",
				"rt_commWest_lin_E",
			},
			out_lrrpHold_E = {
				"rt_commWest_lout_E",
				"rt_commWest_lout_E",
			},
			in_lrrpHold_W = {
				"rt_commWest_lin_W",
				"rt_commWest_lin_W",
			},
			out_lrrpHold_W = {
				"rt_commWest_lout_W",
				"rt_commWest_lout_W",
			},
			in_lrrpHold_S_E = {
				"rt_commWest_lin_S_E",
				"rt_commWest_lin_S_E",
			},
			in_lrrpHold_S_W = {
				"rt_commWest_lin_S_W",
				"rt_commWest_lin_S_W",
			},
			out_lrrpHold_E_S = {
				"rt_commWest_lout_E_S",
				"rt_commWest_lout_E_S",
			},
			out_lrrpHold_E_W = {
				"rt_commWest_lout_E_W",
				"rt_commWest_lout_E_W",
			},
			out_lrrpHold_W_E = {
				"rt_commWest_lout_W_E",
				"rt_commWest_lout_W_E",
			},
			out_lrrpHold_W_S = {
				"rt_commWest_lout_W_S",
				"rt_commWest_lout_W_S",
			},
		},
		outofrain = {
			"rt_commWest_r_0000",
			"rt_commWest_r_0001",
			"rt_commWest_r_0002",
			"rt_commWest_r_0003",
			"rt_commWest_r_0004",
			"rt_commWest_r_0005",
			"rt_commWest_r_0006",
			"rt_commWest_r_0007",
		},
		nil
	},
	
	afgh_ruinsNorth_ob = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rt_ruinsNorth_d_0000",
				"rt_ruinsNorth_d_0002",
			},
			groupB = {
				"rt_ruinsNorth_d_0001",
			},
		},
		sneak_night = {
			groupA = {
				"rt_ruinsNorth_n_0000",
				"rt_ruinsNorth_n_0002",
			},
			groupB = {
				"rt_ruinsNorth_n_0001",
			},
		},
		caution = {
			groupA = {
				"rt_ruinsNorth_c_0000",
				"rt_ruinsNorth_c_0001",
				"rt_ruinsNorth_c_0002",
				"rt_ruinsNorth_c_0003",
				"rt_ruinsNorth_c_0004",
			},
			groupB = {
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_ruinsNorth_s_0000",
				"rt_ruinsNorth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_ruinsNorth_l_0000",
				"rt_ruinsNorth_l_0001",
			},
			in_lrrpHold_N = {
				"rt_ruinsNorth_lin_N",
				"rt_ruinsNorth_lin_N",
			},
			out_lrrpHold_N = {
				"rt_ruinsNorth_lout_N",
				"rt_ruinsNorth_lout_N",
			},
			in_lrrpHold_S = {
				"rt_ruinsNorth_lin_S",
				"rt_ruinsNorth_lin_S",
			},
			out_lrrpHold_S = {
				"rt_ruinsNorth_lout_S",
				"rt_ruinsNorth_lout_S",
			},
		},
		outofrain = {
			"rt_ruinsNorth_r_0000",
		},
		nil
	},
	
	afgh_slopedWest_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_slopedWest_d_0000_sub",
				"rt_slopedWest_d_0004",
			},
			groupB = {
				"rt_slopedWest_d_0003",
				"rt_slopedWest_d_0002",
			},
			groupC = {
				"rt_slopedWest_d_0001",
				"rt_slopedWest_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_slopedWest_n_0000",
				"rt_slopedWest_n_0004",
			},
			groupB = {
				"rt_slopedWest_n_0003",
				"rt_slopedWest_n_0002",
			},
			groupC = {
				"rt_slopedWest_n_0001",
				"rt_slopedWest_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_slopedWest_c_0000",
				"rt_slopedWest_c_0003",
				"rt_slopedWest_c_0001",
				"rt_slopedWest_c_0004",
				"rt_slopedWest_c_0002",
				"rt_slopedWest_c_0004",
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
				"rt_slopedWest_s_0000",
				"rt_slopedWest_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_slopedWest_l_0000",
				"rt_slopedWest_l_0001",
			},
			in_lrrpHold_E = {
				"rt_slopedWest_lin_E",
				"rt_slopedWest_lin_E",
			},
			out_lrrpHold_E = {
				"rt_slopedWest_lout_E",
				"rt_slopedWest_lout_E",
			},
			in_lrrpHold_W = {
				"rt_slopedWest_lin_W",
				"rt_slopedWest_lin_W",
			},
			out_lrrpHold_W = {
				"rt_slopedWest_lout_W",
				"rt_slopedWest_lout_W",
			},
		},
		outofrain = {
			"rt_slopedWest_r_0000",
			"rt_slopedWest_r_0001",
		},
		nil
	},

	
	afgh_villageEast_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		sneak_day = {
			groupA = {
				"rt_villageEast_d_0000_no_watchtower_sub",	
				"rt_villageEast_d_0004",
			},
			groupB = {
				"rt_villageEast_d_0001",
				"rt_villageEast_d_0005",
			},
			groupC = {
				"rt_villageEast_d_0002",
				"rt_villageEast_d_0006",
			},
			groupD = {
				"rt_villageEast_d_0003",
				"rt_villageEast_d_0007",
			},
		},
		sneak_night = {
			groupA = {
				"rt_villageEast_n_0000_no_watchtower_sub",
				"rt_villageEast_n_0004",
			},
			groupB = {
				"rt_villageEast_n_0001",
				"rt_villageEast_n_0005",
			},
			groupC = {
				"rt_villageEast_n_0002",
				"rt_villageEast_n_0006",
			},
			groupD = {
				"rt_villageEast_n_0003",
				"rt_villageEast_n_0007",
			},
		},
		caution = {
			groupA = {
				"rt_villageEast_c_0000_watchtower",
				"rt_villageEast_c_0001",
				"rt_villageEast_c_0002",
				"rt_villageEast_c_0003",
				"rt_villageEast_c_0004",
				"rt_villageEast_c_0005",
				"rt_villageEast_c_0006",
				"rt_villageEast_c_0007",
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
			},
		},
		sleep = {
			default = {
				"rt_villageEast_s_0000",
				"rt_villageEast_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_villageEast_l_0000",
				"rt_villageEast_l_0001",
			},
			in_lrrpHold_E = {
				"rt_villageEast_lin_E",
				"rt_villageEast_lin_E",
			},
			out_lrrpHold_E = {
				"rt_villageEast_lout_E",
				"rt_villageEast_lout_E",
			},
			in_lrrpHold_W = {
				"rt_villageEast_lin_W",
				"rt_villageEast_lin_W",
			},
			out_lrrpHold_W = {
				"rt_villageEast_lout_W",
				"rt_villageEast_lout_W",
			},
		},
		outofrain = {
			"rt_villageEast_r_0000",
			"rt_villageEast_r_0001",
		},
		nil
	},

	
	afgh_villageNorth_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_villageNorth_d_0000",
				"rt_villageNorth_d_0003",
			},
			groupB = {
				"rt_villageNorth_d_0001",
				"rt_villageNorth_d_0004",
			},
			groupC = {
				"rt_villageNorth_d_0002",
				"rt_villageNorth_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_villageNorth_n_0000",
				"rt_villageNorth_n_0003",
			},
			groupB = {
				"rt_villageNorth_n_0001",
				"rt_villageNorth_n_0004",
			},
			groupC = {
				"rt_villageNorth_n_0002",
				"rt_villageNorth_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_villageNorth_c_0000",
				"rt_villageNorth_c_0001",
				"rt_villageNorth_c_0002",
				"rt_villageNorth_c_0002",
				"rt_villageNorth_c_0003",
				"rt_villageNorth_c_0004",
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
				"rt_villageNorth_s_0000",
				"rt_villageNorth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_villageNorth_l_0000",
				"rt_villageNorth_l_0001",
			},
			in_lrrpHold_E = {
				"rt_villageNorth_lin_E",
				"rt_villageNorth_lin_E",
			},
			out_lrrpHold_E = {
				"rt_villageNorth_lout_E",
				"rt_villageNorth_lout_E",
			},
			in_lrrpHold_W = {
				"rt_villageNorth_lin_W",
				"rt_villageNorth_lin_W",
			},
			out_lrrpHold_W = {
				"rt_villageNorth_lout_W",
				"rt_villageNorth_lout_W",
			},
			in_lrrpHold_S_E = {
				"rt_villageNorth_lin_S_E",
				"rt_villageNorth_lin_S_E",
			},
			in_lrrpHold_S_W = {
				"rt_villageNorth_lin_S_W",
				"rt_villageNorth_lin_S_W",
			},
			out_lrrpHold_E_S = {
				"rt_villageNorth_lout_E_S",
				"rt_villageNorth_lout_E_S",
			},
			out_lrrpHold_E_W = {
				"rt_villageNorth_lout_E_W",
				"rt_villageNorth_lout_E_W",
			},
			out_lrrpHold_W_E = {
				"rt_villageNorth_lout_W_E",
				"rt_villageNorth_lout_W_E",
			},
			out_lrrpHold_W_S = {
				"rt_villageNorth_lout_W_S",
				"rt_villageNorth_lout_W_S",
			},
		},
		outofrain = {
			"rt_villageNorth_r_0000",
			"rt_villageNorth_r_0001",
		},
		nil
	},
	
	afgh_villageWest_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_villageWest_d_0000",
				"rt_villageWest_d_0003",
			},
			groupB = {
				"rt_villageWest_d_0001_sub",
				"rt_villageWest_d_0004",
			},
			groupC = {
				"rt_villageWest_d_0002",
				"rt_villageWest_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_villageWest_n_0000_sub",
				"rt_villageWest_n_0003",
			},
			groupB = {
				"rt_villageWest_n_0001",
				"rt_villageWest_n_0004",
			},
			groupC = {
				"rt_villageWest_n_0002",
				"rt_villageWest_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_villageWest_c_0000",
				"rt_villageWest_c_0001",
				"rt_villageWest_c_0002",
				"rt_villageWest_c_0002",
				"rt_villageWest_c_0003",
				"rt_villageWest_c_0004",
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
				"rt_villageWest_s_0000",
				"rt_villageWest_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_villageWest_l_0000",
				"rt_villageWest_l_0001",
			},
			in_lrrpHold_E = {
				"rt_villageWest_lin_E",
				"rt_villageWest_lin_E",
			},
			out_lrrpHold_E = {
				"rt_villageWest_lout_E",
				"rt_villageWest_lout_E",
			},
			out_lrrpHold_B = {
				"rt_villageWest_lout_B",
				"rt_villageWest_lout_B",
			},
		},
		outofrain = {
			"rt_villageWest_r_0000",
			"rt_villageWest_r_0001",
		},
		nil
	},
	
	afgh_enemyEast_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_enemyEast_d_0000",
				"rt_enemyEast_d_0003",
			},
			groupB = {
				"rt_enemyEast_d_0001",
				"rt_enemyEast_d_0004",
			},
			groupC = {
				"rt_enemyEast_d_0002",
				"rt_enemyEast_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_enemyEast_n_0000",
				"rt_enemyEast_n_0003",
			},
			groupB = {
				"rt_enemyEast_n_0001",
				"rt_enemyEast_n_0004",
			},
			groupC = {
				"rt_enemyEast_n_0002",
				"rt_enemyEast_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_enemyEast_c_0000",
				"rt_enemyEast_c_0001",
				"rt_enemyEast_c_0002",
				"rt_enemyEast_c_0003",
				"rt_enemyEast_c_0004",	
				"rt_enemyEast_c_0004",	
				"rt_enemyEast_c_0005",
				"rt_enemyEast_c_0006",
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
				"rt_enemyEast_s_0000",
				"rt_enemyEast_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_enemyEast_l_0000",
				"rt_enemyEast_l_0001",
			},
		},
		outofrain = {
			"rt_enemyEast_r_0000",
			"rt_enemyEast_r_0001",
			"rt_enemyEast_r_0002",
			"rt_enemyEast_r_0003",
			"rt_enemyEast_r_0004",
			"rt_enemyEast_r_0005",
		},
		nil
	},

	
	
	
	
	afgh_bridge_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_bridge_d_0003",
				"rt_bridge_d_0004",
				"rt_bridge_d_0002",
				"rt_bridge_d_0006",
			},
			groupB = {
				"rt_bridge_d_0000_sub",
				"rt_bridge_d_0001",
				"rt_bridge_d_0005",
			},
			groupC = {
				"rt_bridge_d_0009",
				"rt_bridge_d_0007",
				"rt_bridge_d_0008",
			},
		},
		sneak_night= {
			groupA = {
				"rt_bridge_n_0000",
				"rt_bridge_n_0001",
				"rt_bridge_n_0006_sub",
				"rt_bridge_n_0007",
			},
			groupB = {
				"rt_bridge_n_0002",
				"rt_bridge_n_0003_sub",
				"rt_bridge_n_0008",
			},
			groupC = {
				"rt_bridge_n_0004",
				"rt_bridge_n_0005",
				"rt_bridge_n_0009",
			},
		},
		caution = {
			groupA = {
				"rt_bridge_c_0005",
				"rt_bridge_c_0006",
				"rt_bridge_c_0004",
				"rt_bridge_c_0004",
				"rt_bridge_c_0002",
				"rt_bridge_c_0003",
				"rt_bridge_c_0007",
				"rt_bridge_c_0000",
				"rt_bridge_c_0001",
				"rt_bridge_c_0008",
				"rt_bridge_c_0009",
				"rt_bridge_c_0010",
			},
			groupB = {
			},
			groupC = {
			},
		},
		hold = {
			default = {
				"rt_bridge_h_0000",
				"rt_bridge_h_0001",
				"rt_bridge_h_0002",
				"rt_bridge_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_bridge_s_0000",
				"rt_bridge_s_0001",
				"rt_bridge_s_0002",
				"rt_bridge_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_bridge_l_0000",
				"rt_bridge_l_0001",
			},
			in_lrrpHold_N = {
				"rt_bridge_lin_N",
				"rt_bridge_lin_N",
			},
			out_lrrpHold_S = {
				"rt_bridge_lout_S",
				"rt_bridge_lout_S",
			},
		},
		outofrain = {
			"rt_bridge_r_0000",
			"rt_bridge_r_0001",
			"rt_bridge_r_0002",
			"rt_bridge_r_0003",
			"rt_bridge_r_0004",
			"rt_bridge_r_0005",
			"rt_bridge_r_0006",
			"rt_bridge_r_0007",
			"rt_bridge_r_0008",
			"rt_bridge_r_0009",
			"rt_bridge_r_0010",
			"rt_bridge_r_0011",
			"rt_bridge_r_0012",
		},
		nil
	},
	
	afgh_cliffTown_cp = {
		priority = {
			"groupSniper",
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		fixedShiftChangeGroup = {
			"groupSniper",
		},
		sneak_day = {
			groupSniper = {
				{ "rt_cliffTown_snp_0000", attr = "SNIPER" },
				{ "rt_cliffTown_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_cliffTown_d_0010",
				"rt_cliffTown_d_0009",
				"rt_cliffTown_d_0002",
				"rt_cliffTown_d_0002",
			},
			groupB = {
				"rt_cliffTown_d_0006",
				"rt_cliffTown_d_0008",
				"rt_cliffTown_d_0003",
				"rt_cliffTown_d_0012",
			},
			groupC = {
				"rt_cliffTown_d_0007",
				"rt_cliffTown_d_0005",
				"rt_cliffTown_d_0004",
				"rt_cliffTown_d_0013", 
			},
			groupD = {
				"rt_cliffTown_d_0001_no_tower_sub",
				"rt_cliffTown_d_0011",
				"rt_cliffTown_d_0000",
				"rt_cliffTown_d_0014", 
			},
		},
		sneak_night= {
			groupSniper = {
				{ "rt_cliffTown_snp_0000", attr = "SNIPER" },
				{ "rt_cliffTown_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_cliffTown_n_0001_no_search_light_sub",
				"rt_cliffTown_n_0012",
				"rt_cliffTown_n_0011",
				"rt_cliffTown_n_0010",
			},
			groupB = {
				"rt_cliffTown_n_0000_no_search_light_sub",
				"rt_cliffTown_n_0009",
				"rt_cliffTown_n_0003",
				"rt_cliffTown_n_0013",
			},
			groupC = {
				"rt_cliffTown_n_0008",
				"rt_cliffTown_n_0006",
				"rt_cliffTown_n_0002",
				"rt_cliffTown_n_0014", 
			},
			groupD = {
				"rt_cliffTown_n_0005_no_search_light_sub",
				"rt_cliffTown_n_0007",
				"rt_cliffTown_n_0004_no_search_light_sub",
				"rt_cliffTown_n_0015", 
			},
		},
		caution = {
			groupSniper = {
				{ "rt_cliffTown_snp_0000", attr = "SNIPER" },
				{ "rt_cliffTown_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_cliffTown_c_0000",
				"rt_cliffTown_c_0000",
				"rt_cliffTown_c_0001",
				"rt_cliffTown_c_0001",
				"rt_cliffTown_c_0002",
				"rt_cliffTown_c_0002",
				"rt_cliffTown_c_0003",
				"rt_cliffTown_c_0003",
				"rt_cliffTown_c_0004",
				"rt_cliffTown_c_0004",
				"rt_cliffTown_c_0005",
				"rt_cliffTown_c_0005",
				"rt_cliffTown_c_0006",
				"rt_cliffTown_c_0006",
				"rt_cliffTown_c_0001",
				"rt_cliffTown_c_0004",
			},
			groupB = {
			},
			groupC = {
			},
			groupD = {
			},
		},
		hold = {
			groupSniper = {
			},
			default = {
				"rt_cliffTown_h_0000", 
				"rt_cliffTown_h_0001", 
				"rt_cliffTown_h_0002", 
				"rt_cliffTown_h_0003", 
			},
		},
		sleep = {
			groupSniper = {
			},
			default = {
				"rt_cliffTown_s_0000",
				"rt_cliffTown_s_0001",
				"rt_cliffTown_s_0002",
				"rt_cliffTown_s_0003",
			},
		},
		travel = {
			lrrp_cliffTown = {
				"rt_cliffTown_l_0000",
				"rt_cliffTown_l_0001",
			},
			lrrpHold = {
				"rt_cliffTown_l_0000",
				"rt_cliffTown_l_0001",
			},
			lrrpHold_01 = {
				"rt_cliffTown_l_0002",
				"rt_cliffTown_l_0003",
			},
			in_lrrpHold_W = {
				"rt_cliffTown_lin_W",
				"rt_cliffTown_lin_W",
			},
			out_lrrpHold_N = {
				"rt_cliffTown_lout_N",
				"rt_cliffTown_lout_N",
			},
		},
		outofrain = {
			"rt_cliffTown_r_0000",
			"rt_cliffTown_r_0001",
			"rt_cliffTown_r_0002",
			"rt_cliffTown_r_0003",
			"rt_cliffTown_r_0004",
			"rt_cliffTown_r_0005",
			"rt_cliffTown_r_0006",
			"rt_cliffTown_r_0007",
			"rt_cliffTown_r_0008",
			"rt_cliffTown_r_0009",
			"rt_cliffTown_r_0010",
			"rt_cliffTown_r_0011",
			"rt_cliffTown_r_0012",
			"rt_cliffTown_r_0013",
		},
		nil
	},
	
	afgh_fort_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_fort_d_0001",
				"rt_fort_d_0002",
				"rt_fort_d_0004_sub",
				"rt_fort_d_0005",
			},
			groupB = {
				"rt_fort_d_0000",
				"rt_fort_d_0006",
				"rt_fort_d_0007",
				"rt_fort_d_0010",
			},
			groupC = {
				"rt_fort_d_0003_sub",
				"rt_fort_d_0008",
				"rt_fort_d_0009",
				"rt_fort_d_0011",
			},
		},
		sneak_night = {
			groupA = {
				"rt_fort_n_0000",
				"rt_fort_n_0001",
				"rt_fort_n_0002",
				"rt_fort_n_0005",
			},
			groupB = {
				"rt_fort_n_0003_sub",
				"rt_fort_n_0006",
				"rt_fort_n_0004",
				"rt_fort_n_0010",
			},
			groupC = {
				"rt_fort_n_0007",
				"rt_fort_n_0009",
				"rt_fort_n_0008_sub",
				"rt_fort_n_0011",
			},
		},
		caution = {
			groupA = {
				"rt_fort_c_0001",
				"rt_fort_c_0008",
				"rt_fort_c_0002",
				"rt_fort_c_0002",
				"rt_fort_c_0003",
				"rt_fort_c_0004",
				"rt_fort_c_0005",
				"rt_fort_c_0000",
				"rt_fort_c_0006",
				"rt_fort_c_0007",
				"rt_fort_c_0010",
				"rt_fort_c_0010",
			},
			groupB = {
			},
			groupC = {
			},
		},
		hold = {
			default = {
				"rt_fort_h_0000",
				"rt_fort_h_0001",
				"rt_fort_h_0002",
				"rt_fort_h_0003",
				"rt_fort_h_0004",
				"rt_fort_h_0005",
			},
		},
		sleep = {
			default = {
				"rt_fort_s_0000",
				"rt_fort_s_0001",
				"rt_fort_s_0002",
				"rt_fort_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_fort_l_0000",
				"rt_fort_l_0001",
			},
			in_lrrpHold_W = {
				"rt_fort_lin_W",
				"rt_fort_lin_W",
			},
			out_lrrpHold_S = {
				"rt_fort_lout_S",
				"rt_fort_lout_S",
			},
		},
		outofrain = {
			"rt_fort_r_0000",
			"rt_fort_r_0001",
			"rt_fort_r_0002",
			"rt_fort_r_0003",
			"rt_fort_r_0004",
			"rt_fort_r_0005",
		},
		nil
	},
	
	
	

	afgh_bridgeNorth_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_bridgeNorth_d_0000",
				"rt_bridgeNorth_d_0003",
			},
			groupB = {
				"rt_bridgeNorth_d_0001",
				"rt_bridgeNorth_d_0004",
			},
			groupC = {
				"rt_bridgeNorth_d_0002",
				"rt_bridgeNorth_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_bridgeNorth_n_0000",
				"rt_bridgeNorth_n_0003",
			},
			groupB = {
				"rt_bridgeNorth_n_0001",
				"rt_bridgeNorth_n_0004",
			},
			groupC = {
				"rt_bridgeNorth_n_0002",
				"rt_bridgeNorth_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_bridgeNorth_c_0000",
				"rt_bridgeNorth_c_0001",
				"rt_bridgeNorth_c_0002",
				"rt_bridgeNorth_c_0003",
				"rt_bridgeNorth_c_0004",
				"rt_bridgeNorth_c_0005",
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
				"rt_bridgeNorth_s_0000",
				"rt_bridgeNorth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_bridgeNorth_l_0000",
				"rt_bridgeNorth_l_0001",
			},
			in_lrrpHold_N = {
				"rt_bridgeNorth_lin_N",
				"rt_bridgeNorth_lin_N",
			},
			out_lrrpHold_S = {
				"rt_bridgeNorth_lout_S",
				"rt_bridgeNorth_lout_S",
			},
		},
		outofrain = {
			"rt_bridgeNorth_r_0000",
			"rt_bridgeNorth_r_0001",
			"rt_bridgeNorth_r_0002",
			"rt_bridgeNorth_r_0003",
			"rt_bridgeNorth_r_0004",
			"rt_bridgeNorth_r_0005",
			"rt_bridgeNorth_r_0006",
			"rt_bridgeNorth_r_0007",
		},
		nil
	},

	
	afgh_bridgeWest_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_bridgeWest_d_0000_no_watchtower_sub",	
				"rt_bridgeWest_d_0003",
			},
			groupB = {
				"rt_bridgeWest_d_0001",
				"rt_bridgeWest_d_0004",
			},
			groupC = {
				"rt_bridgeWest_d_0002",
				"rt_bridgeWest_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_bridgeWest_n_0000_no_searchlight_sub",	
				"rt_bridgeWest_n_0003",
			},
			groupB = {
				"rt_bridgeWest_n_0001_no_searchlight_sub",	
				"rt_bridgeWest_n_0004",
			},
			groupC = {
				"rt_bridgeWest_n_0002",
				"rt_bridgeWest_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_bridgeWest_c_0000_searchlight",
				"rt_bridgeWest_c_0001_searchlight",
				"rt_bridgeWest_c_0002",
				"rt_bridgeWest_c_0003",
				"rt_bridgeWest_c_0004",
				"rt_bridgeWest_c_0005",
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
				"rt_bridgeWest_s_0000",
				"rt_bridgeWest_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_bridgeWest_l_0000",
				"rt_bridgeWest_l_0001",
			},
			in_lrrpHold_N = {
				"rt_bridgeWest_lin_N",
				"rt_bridgeWest_lin_N",
			},
			out_lrrpHold_N = {
				"rt_bridgeWest_lout_N",
				"rt_bridgeWest_lout_N",
			},
			in_lrrpHold_S = {
				"rt_bridgeWest_lin_S",
				"rt_bridgeWest_lin_S",
			},
			out_lrrpHold_S = {
				"rt_bridgeWest_lout_S",
				"rt_bridgeWest_lout_S",
			},
		},
		outofrain = {
			"rt_bridgeWest_r_0000",
			"rt_bridgeWest_r_0001",
			"rt_bridgeWest_r_0002",
			"rt_bridgeWest_r_0003",
			"rt_bridgeWest_r_0004",
			"rt_bridgeWest_r_0005",
			"rt_bridgeWest_r_0006",
			"rt_bridgeWest_r_0007",
		},
		nil
	},

	
	afgh_cliffEast_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",

		},
		sneak_day = {
			groupA = {
				"rt_cliffEast_d_0000",
				"rt_cliffEast_d_0001",
			},
			groupB = {
				"rt_cliffEast_d_0002_sub",
				"rt_cliffEast_d_0004",
			},
			groupC = {
				"rt_cliffEast_d_0003",
				"rt_cliffEast_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_cliffEast_n_0000",
				"rt_cliffEast_n_0005",

			},
			groupB = {
				"rt_cliffEast_d_0002_sub",
				"rt_cliffEast_d_0004",
			},
			groupC = {
				"rt_cliffEast_n_0003",
				"rt_cliffEast_n_0001",
			},
		},
		caution = {
			groupA = {
				"rt_cliffEast_c_0000",
				"rt_cliffEast_c_0001",
				"rt_cliffEast_c_0002",
				"rt_cliffEast_c_0003",
				"rt_cliffEast_c_0004",
				"rt_cliffEast_c_0005",
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
				"rt_cliffEast_s_0000",
				"rt_cliffEast_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_cliffEast_l_0000",
				"rt_cliffEast_l_0001",
			},
			in_lrrpHold_W = {
				"rt_cliffEast_lin_W",
				"rt_cliffEast_lin_W",
			},
			out_lrrpHold_E = {
				"rt_cliffEast_lout_E",
				"rt_cliffEast_lout_E",
			},
		},
		outofrain = {
			"rt_cliffEast_r_0000",
			"rt_cliffEast_r_0001",
			"rt_cliffEast_r_0002",
			"rt_cliffEast_r_0003",
			"rt_cliffEast_r_0004",
			"rt_cliffEast_r_0005",
			"rt_cliffEast_r_0006",
			"rt_cliffEast_r_0007",
		},
		nil
	},
	
	afgh_cliffSouth_ob = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rt_cliffSouth_d_0000_sub",
				"rt_cliffSouth_d_0002",
			},
			groupB = {
				"rt_cliffSouth_d_0001",
				"rt_cliffSouth_d_0003",
			},
		},
		sneak_night = {
			groupA = {
				"rt_cliffSouth_n_0000",
				"rt_cliffSouth_n_0002_sub",
			},
			groupB = {
				"rt_cliffSouth_n_0001",
				"rt_cliffSouth_n_0003",
			},
		},
		caution = {
			groupA = {
				"rt_cliffSouth_c_0000",
				"rt_cliffSouth_c_0001",
				"rt_cliffSouth_c_0002",
				"rt_cliffSouth_c_0003",
				"rt_cliffSouth_c_0004",
				"rt_cliffSouth_c_0005",
			},
			groupB = {
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_cliffSouth_s_0000",
				"rt_cliffSouth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_cliffSouth_l_0000",
				"rt_cliffSouth_l_0001",
			},
			in_lrrpHold_S = {
				"rt_cliffSouth_lin_S",
				"rt_cliffSouth_lin_S",
			},
			out_lrrpHold_E = {
				"rt_cliffSouth_lout_E",
				"rt_cliffSouth_lout_E",
			},
		},
		outofrain = {
			"rt_cliffSouth_r_0000",
			"rt_cliffSouth_r_0001",
			"rt_cliffSouth_r_0002",
			"rt_cliffSouth_r_0003",
			"rt_cliffSouth_r_0004",
			"rt_cliffSouth_r_0005",
			"rt_cliffSouth_r_0006",
			"rt_cliffSouth_r_0007",
		},
		nil
	},
	
	afgh_cliffWest_ob = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rt_cliffWest_d_0000",
				"rt_cliffWest_d_0002",
			},
			groupB = {
				"rt_cliffWest_d_0001_sub",
				"rt_cliffWest_d_0003",
			},
		},
		sneak_night = {
			groupA = {
				"rt_cliffWest_n_0000",
				"rt_cliffWest_n_0002",
			},
			groupB = {
				"rt_cliffWest_n_0001_sub",
				"rt_cliffWest_n_0003",
			},
		},
		caution = {
			groupA = {
				"rt_cliffWest_c_0000",
				"rt_cliffWest_c_0000",
				"rt_cliffWest_c_0001",
				"rt_cliffWest_c_0001",
				"rt_cliffWest_c_0000",
				"rt_cliffWest_c_0001",
			},
			groupB = {
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_cliffWest_s_0000",
				"rt_cliffWest_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_cliffWest_l_0000",
				"rt_cliffWest_l_0001",
			},
			in_lrrpHold_S = {
				"rt_cliffWest_lin_S",
				"rt_cliffWest_lin_S",
			},
			out_lrrpHold_N = {
				"rt_cliffWest_lout_N",
				"rt_cliffWest_lout_N",
			},
		},
		outofrain = {
			"rt_cliffWest_r_0000",
			"rt_cliffWest_r_0001",
			"rt_cliffWest_r_0002",
			"rt_cliffWest_r_0003",
		},
		nil
	},
	
	afgh_enemyNorth_ob = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rt_enemyNorth_d_0000",
				"rt_enemyNorth_d_0001_sub",
				"rt_enemyNorth_d_0004",
				"rt_enemyNorth_d_0005",
			},
			groupB = {
				"rt_enemyNorth_d_0002",
				"rt_enemyNorth_d_0003",
				"rt_enemyNorth_d_0006",
				"rt_enemyNorth_d_0007",
			},
		},
		sneak_night = {
			groupA = {
				"rt_enemyNorth_n_0000",
				"rt_enemyNorth_n_0001",
				"rt_enemyNorth_n_0004",
				"rt_enemyNorth_n_0005",
			},
			groupB = {
				"rt_enemyNorth_n_0002",
				"rt_enemyNorth_n_0003",
				"rt_enemyNorth_n_0006",
				"rt_enemyNorth_n_0007",
			},
		},
		caution = {
			groupA = {
				"rt_enemyNorth_c_0000",
				"rt_enemyNorth_c_0001",
				"rt_enemyNorth_c_0002",
				"rt_enemyNorth_c_0003",
				"rt_enemyNorth_c_0004",
				"rt_enemyNorth_c_0005",
				"rt_enemyNorth_c_0006",
				"rt_enemyNorth_c_0007",
			},
			groupB = {
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_enemyNorth_s_0000",
				"rt_enemyNorth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_enemyNorth_l_0000",
				"rt_enemyNorth_l_0001",
			},
		},
		outofrain = {
			"rt_enemyNorth_r_0000",
			"rt_enemyNorth_r_0001",
			"rt_enemyNorth_r_0002",
			"rt_enemyNorth_r_0003",
			"rt_enemyNorth_r_0004",
			"rt_enemyNorth_r_0005",
			"rt_enemyNorth_r_0006",
			"rt_enemyNorth_r_0007",
		},
		nil
	},
	
	afgh_fortSouth_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC"
		},
		sneak_day = {
			groupA = {
				"rt_fortSouth_d_0000",
				"rt_fortSouth_d_0003",

			},
			groupB = {
				"rt_fortSouth_d_0001",
				"rt_fortSouth_d_0004",
			},
			groupC = {
				"rt_fortSouth_d_0002",
				"rt_fortSouth_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_fortSouth_n_0000",
				"rt_fortSouth_n_0003",
			},
			groupB = {
				"rt_fortSouth_n_0001",
				"rt_fortSouth_n_0004",
			},
			groupC = {
				"rt_fortSouth_n_0002",
				"rt_fortSouth_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_fortSouth_c_0000",
				"rt_fortSouth_c_0001",
				"rt_fortSouth_c_0002",
				"rt_fortSouth_c_0003",
				"rt_fortSouth_c_0000",
				"rt_fortSouth_c_0001",
				"rt_fortSouth_c_0004",
				"rt_fortSouth_c_0005",
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
				"rt_fortSouth_s_0000",
				"rt_fortSouth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_fortSouth_l_0000",
				"rt_fortSouth_l_0001",
			},
			in_lrrpHold_N = {
				"rt_fortSouth_lin_N",
				"rt_fortSouth_lin_N",
			},
			out_lrrpHold_S = {
				"rt_fortSouth_lout_S",
				"rt_fortSouth_lout_S",
			},
		},
		outofrain = {
			"rt_fortSouth_r_0000",
			"rt_fortSouth_r_0001",
			"rt_fortSouth_r_0002",
			"rt_fortSouth_r_0003",
			"rt_fortSouth_r_0004",
			"rt_fortSouth_r_0005",
			"rt_fortSouth_r_0006",
			"rt_fortSouth_r_0007",
		},
		nil
	},
	
	afgh_fortWest_ob = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rt_fortWest_d_0000",
				"rt_fortWest_d_0002",
			},
			groupB = {
				"rt_fortWest_d_0001",
				"rt_fortWest_d_0003",
			},
		},
		sneak_night = {
			groupA = {
				"rt_fortWest_n_0000",
				"rt_fortWest_n_0002",
			},
			groupB = {
				"rt_fortWest_n_0001",
				"rt_fortWest_n_0003",
			},
		},
		caution = {
			groupA = {
				"rt_fortWest_c_0000",
				"rt_fortWest_c_0001",
				"rt_fortWest_c_0002",
				"rt_fortWest_c_0003",
				"rt_fortWest_c_0000",
				"rt_fortWest_c_0002",
			},
			groupB = {
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_fortWest_s_0000",
				"rt_fortWest_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_fortWest_l_0000",
				"rt_fortWest_l_0001",
			},
			in_lrrpHold_W = {
				"rt_fortWest_lin_W",
				"rt_fortWest_lin_W",
			},
			out_lrrpHold_E = {
				"rt_fortWest_lout_E",
				"rt_fortWest_lout_E",
			},
		},
		outofrain = {
			"rt_fortWest_r_0000",
			"rt_fortWest_r_0001",
			"rt_fortWest_r_0002",
			"rt_fortWest_r_0003",
			"rt_fortWest_r_0004",
			"rt_fortWest_r_0005",
			"rt_fortWest_r_0006",
			"rt_fortWest_r_0007",
		},
		nil
	},
	
	afgh_slopedEast_ob = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rt_slopeEast_d_0000",
				"rt_slopeEast_d_0002",
				"rt_slopeEast_d_0004",
			},
			groupB = {
				"rt_slopeEast_d_0001_sub",
				"rt_slopeEast_d_0003",
				"rt_slopeEast_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_slopeEast_n_0000",
				"rt_slopeEast_n_0002",
				"rt_slopeEast_n_0004",
			},
			groupB = {
				"rt_slopeEast_n_0001",
				"rt_slopeEast_n_0003",
				"rt_slopeEast_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_slopeEast_c_0000_sub",
				"rt_slopeEast_c_0001",
				"rt_slopeEast_c_0002",
				"rt_slopeEast_c_0003",
				"rt_slopeEast_c_0004",
				"rt_slopeEast_c_0005",
			},
			groupB = {
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_slopeEast_s_0000",
				"rt_slopeEast_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_slopeEast_l_0000",
				"rt_slopeEast_l_0001",
			},
			in_lrrpHold_W = {
				"rt_slopedEast_lin_W",
				"rt_slopedEast_lin_W",
			},
			out_lrrpHold_N = {
				"rt_slopedEast_lout_N",
				"rt_slopedEast_lout_N",
			},
		},
		outofrain = {
			"rt_slopedEast_r_0000",
			"rt_slopedEast_r_0001",
		},
		nil
	},
	
	
	
	
	afgh_powerPlant_cp = {
		priority = {
			"groupSniper",
			"groupA",
			"groupB",
			"groupC",
			"groupD",
			"groupE",
		},
		fixedShiftChangeGroup = {
			"groupSniper",
		},
		sneak_day = {
			groupSniper = {
				{ "rt_powerPlant_snp_0000", attr = "SNIPER" },
				{ "rt_powerPlant_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_powerPlant_d_0000",
				"rt_powerPlant_d_0005",
			},
			groupB = {
				"rt_powerPlant_d_0001",
				"rt_powerPlant_d_0006",
			},
			groupC = {
				"rt_powerPlant_d_0002",
				"rt_powerPlant_d_0007",
			},
			groupD = {
				"rt_powerPlant_d_0003",
				"rt_powerPlant_d_0008",
			},
			groupE = {
				"rt_powerPlant_d_0004",
				"rt_powerPlant_d_0009",
			},
		},
		sneak_night= {
			groupSniper = {
				{ "rt_powerPlant_snp_0001", attr = "SNIPER" },
				{ "rt_powerPlant_snp_0000", attr = "SNIPER" },
			},
			groupA = {
				"rt_powerPlant_n_0000",
				"rt_powerPlant_n_0005",
			},
			groupB = {
				"rt_powerPlant_n_0001_sub",
				"rt_powerPlant_n_0006",
			},
			groupC = {
				"rt_powerPlant_n_0002",
				"rt_powerPlant_n_0007",
			},
			groupD = {
				"rt_powerPlant_n_0003",
				"rt_powerPlant_n_0008",
			},
			groupE = {
				"rt_powerPlant_n_0004",
				"rt_powerPlant_n_0009",
			},
		},
		caution = {
			groupSniper = {
				{ "rt_powerPlant_snp_0000c", attr = "SNIPER" },
				{ "rt_powerPlant_snp_0001c", attr = "SNIPER" },
			},
			groupA = {
				"rt_powerPlant_c_0004",
				"rt_powerPlant_c_0005",
				"rt_powerPlant_c_0000",
				"rt_powerPlant_c_0001",
				"rt_powerPlant_c_0002",
				"rt_powerPlant_c_0003",
				"rt_powerPlant_c_0006",
				"rt_powerPlant_c_0007",
				"rt_powerPlant_c_0008_sub",
				"rt_powerPlant_c_0009",
				"rt_powerPlant_c_0000",
				"rt_powerPlant_c_0001",
				"rt_powerPlant_c_0002",
				"rt_powerPlant_c_0003",
				"rt_powerPlant_c_0009",
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
				"rt_powerPlant_h_0000",
				"rt_powerPlant_h_0001",
				"rt_powerPlant_h_0002",
				"rt_powerPlant_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_powerPlant_s_0000",
				"rt_powerPlant_s_0001",
				"rt_powerPlant_s_0002",
				"rt_powerPlant_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_powerPlant_l_0000",
				"rt_powerPlant_l_0001",
			},
			in_lrrpHold_S = {
				"rt_powerPlant_lin_S",
				"rt_powerPlant_lin_S",
			},
			out_lrrpHold_B01 = {
				"rt_powerPlant_lout_B01",
				"rt_powerPlant_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_powerPlant_lout_B02",
				"rt_powerPlant_lout_B02",
			},
			out_lrrpHold_B03 = {
				"rt_powerPlant_lout_B03",
				"rt_powerPlant_lout_B03",
			},
		},
		outofrain = {
			"rt_powerPlant_r_0000",
			"rt_powerPlant_r_0001",
			"rt_powerPlant_r_0002",
			"rt_powerPlant_r_0003",
			"rt_powerPlant_r_0004",
			"rt_powerPlant_r_0005",
			"rt_powerPlant_r_0006",
			"rt_powerPlant_r_0007",
			"rt_powerPlant_r_0008",
			"rt_powerPlant_r_0009",
			"rt_powerPlant_r_0010",
			"rt_powerPlant_r_0011",
			"rt_powerPlant_r_0012",
			"rt_powerPlant_r_0013",
			"rt_powerPlant_r_0014",
			"rt_powerPlant_r_0015",
		},
		nil
	},
	
	afgh_sovietBase_cp = {
		priority = {
			"groupSniper",
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		fixedShiftChangeGroup = {
			"groupSniper",
		},
		sneak_day = {
			groupSniper = {
				{ "rt_sovietBase_snp_0000", attr = "SNIPER" },
				{ "rt_sovietBase_snp_0001", attr = "SNIPER" },
				{ "rt_sovietBase_snp_0002", attr = "SNIPER" },
			},
			groupA = {
				"rt_sovietBase_d_0000",
				"rt_sovietBase_d_0001",
				"rt_sovietBase_d_0002",
				"rt_sovietBase_d_0003",
			},
			groupB = {
				"rt_sovietBase_d_0004",
				"rt_sovietBase_d_0005_sub",
				"rt_sovietBase_d_0006",
				"rt_sovietBase_d_0007",
			},
			groupC = {
				"rt_sovietBase_d_0008",
				"rt_sovietBase_d_0009",
				"rt_sovietBase_d_0010",
				"rt_sovietBase_d_0011",
			},
			groupD = {
				"rt_sovietBase_d_0012",
				"rt_sovietBase_d_0013",
				"rt_sovietBase_d_0014",
				"rt_sovietBase_d_0015",
			},
		},
		sneak_night= {
			groupSniper = {
				{ "rt_sovietBase_snp_0000", attr = "SNIPER" },
				{ "rt_sovietBase_snp_0001", attr = "SNIPER" },
				{ "rt_sovietBase_snp_0002n", attr = "SNIPER" },
			},
			groupA = {
				"rt_sovietBase_n_0000",
				"rt_sovietBase_n_0001",
				"rt_sovietBase_n_0002",
				"rt_sovietBase_n_0003",
			},
			groupB = {
				"rt_sovietBase_n_0004",
				"rt_sovietBase_n_0005_sub",
				"rt_sovietBase_n_0006",
				"rt_sovietBase_n_0007",
			},
			groupC = {
				"rt_sovietBase_n_0008",
				"rt_sovietBase_n_0009",
				"rt_sovietBase_n_0010",
				"rt_sovietBase_n_0011",
			},
			groupD = {
				"rt_sovietBase_n_0012",
				"rt_sovietBase_n_0013",
				"rt_sovietBase_n_0014",
				"rt_sovietBase_n_0015",
			},
		},
		caution = {
			groupSniper = {
				{ "rt_sovietBase_snp_0000c", attr = "SNIPER" },
				{ "rt_sovietBase_snp_0001c", attr = "SNIPER" },
				{ "rt_sovietBase_snp_0002c", attr = "SNIPER" },
			},
			groupA = {
				"rt_sovietBase_c_0002",
				"rt_sovietBase_c_0017",
				"rt_sovietBase_c_0018",
				"rt_sovietBase_c_0003",
				"rt_sovietBase_c_0004",
				"rt_sovietBase_c_0000",
				"rt_sovietBase_c_0006",
				"rt_sovietBase_c_0007",
				"rt_sovietBase_c_0001",
				"rt_sovietBase_c_0013",
				"rt_sovietBase_c_0012",
				"rt_sovietBase_c_0009",
				"rt_sovietBase_c_0011",
				"rt_sovietBase_c_0014",
				"rt_sovietBase_c_0015",
				"rt_sovietBase_c_0008",
				"rt_sovietBase_c_0005",
				"rt_sovietBase_c_0010",
				"rt_sovietBase_c_0019",
				"rt_sovietBase_c_0016",
				"rt_sovietBase_c_0013",
				"rt_sovietBase_c_0012",
				"rt_sovietBase_c_0011",
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
				"rt_sovietBase_h_0000",
				"rt_sovietBase_h_0001",
				"rt_sovietBase_h_0002",
				"rt_sovietBase_h_0003",
				"rt_sovietBase_h_0004",
			},
		},
		sleep = {
			default = {
				"rt_sovietBase_s_0000",
				"rt_sovietBase_s_0001",
				"rt_sovietBase_s_0002",
				"rt_sovietBase_s_0003",
				"rt_sovietBase_s_0004",
			},
		},
			travel = {
			lrrpHold = {
				"rt_sovietBase_l_0000",
				"rt_sovietBase_l_0001",
			},
			in_lrrpHold_S = {
				"rt_sovietBase_lin_S",
				"rt_sovietBase_lin_S",
			},
			out_lrrpHold_S = {
				"rt_sovietBase_lout_S",
				"rt_sovietBase_lout_S",
			},
		},
		outofrain = {
			"rt_sovietBase_r_0000",
			"rt_sovietBase_r_0001",
			"rt_sovietBase_r_0002",
			"rt_sovietBase_r_0003",
			"rt_sovietBase_r_0004",
			"rt_sovietBase_r_0005",
			"rt_sovietBase_r_0006",
			"rt_sovietBase_r_0007",
			"rt_sovietBase_r_0008",
			"rt_sovietBase_r_0009",
			"rt_sovietBase_r_0010",
			"rt_sovietBase_r_0011",
			"rt_sovietBase_r_0012",
			"rt_sovietBase_r_0013",
			"rt_sovietBase_r_0014",
			"rt_sovietBase_r_0015",
			"rt_sovietBase_r_0016",
			"rt_sovietBase_r_0017",
			"rt_sovietBase_r_0018",
			"rt_sovietBase_r_0019",
		},
		nil
	},
	
	
	
	
	afgh_plantSouth_ob = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rt_plantSouth_d_0000",
				"rt_plantSouth_d_0001",
				"rt_plantSouth_d_0002",
				"rt_plantSouth_d_0003",
			},
		},
		sneak_night = {
			groupA = {
				"rt_plantSouth_n_0000",
				"rt_plantSouth_n_0001",
				"rt_plantSouth_n_0002",
				"rt_plantSouth_n_0003",
			},
		},
		caution = {
			groupA = {
				"rt_plantSouth_c_0000",
				"rt_plantSouth_c_0001",
				"rt_plantSouth_c_0002",
				"rt_plantSouth_c_0003",
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_plantSouth_s_0000",
				"rt_plantSouth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_plantSouth_l_0000",
				"rt_plantSouth_l_0001",
			},
		},
		nil
	},
	
	afgh_plantWest_ob = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rt_plantWest_d_0000",
				"rt_plantWest_d_0002",
				"rt_plantWest_d_0004",

			},
			groupB = {
				"rt_plantWest_d_0001",
				"rt_plantWest_d_0003",
				"rt_plantWest_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_plantWest_n_0000",
				"rt_plantWest_n_0002",
				"rt_plantWest_n_0004",
			},
			groupB = {
				"rt_plantWest_n_0001",
				"rt_plantWest_n_0003",
				"rt_plantWest_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_plantWest_c_0000",
				"rt_plantWest_c_0001",
				"rt_plantWest_c_0002",
				"rt_plantWest_c_0001",	
				"rt_plantWest_c_0002",	
				"rt_plantWest_c_0003",
			},
			groupB = {
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_plantWest_s_0000",
				"rt_plantWest_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_plantWest_l_0000",
				"rt_plantWest_l_0001",
			},
			in_lrrpHold_N = {
				"rt_plantWest_lin_N",
				"rt_plantWest_lin_N",
			},
			out_lrrpHold_N = {
				"rt_plantWest_lout_N",
				"rt_plantWest_lout_N",
			},
			in_lrrpHold_S = {
				"rt_plantWest_lin_S",
				"rt_plantWest_lin_S",
			},
			out_lrrpHold_S = {
				"rt_plantWest_lout_S",
				"rt_plantWest_lout_S",
			},
		},
		outofrain = {
			"rt_plantWest_r_0000",
			"rt_plantWest_r_0001",
			"rt_plantWest_r_0002",
			"rt_plantWest_r_0003",
			"rt_plantWest_r_0004",
			"rt_plantWest_r_0005",
			"rt_plantWest_r_0006",
			"rt_plantWest_r_0007",
		},
		nil
	},
	
	afgh_sovietSouth_ob = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rt_sovietSouth_d_0000",
				"rt_sovietSouth_d_0002",
				"rt_sovietSouth_d_0003",
			},
			groupB = {
				"rt_sovietSouth_d_0001",
				"rt_sovietSouth_d_0004",
				"rt_sovietSouth_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_sovietSouth_n_0000",
				"rt_sovietSouth_n_0002",
				"rt_sovietSouth_n_0004",
			},
			groupB = {
				"rt_sovietSouth_n_0001",
				"rt_sovietSouth_n_0003",
				"rt_sovietSouth_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_sovietSouth_c_0000",
				"rt_sovietSouth_c_0001",
				"rt_sovietSouth_c_0002",
				"rt_sovietSouth_c_0004",
				"rt_sovietSouth_c_0002",
				"rt_sovietSouth_c_0003",
				"rt_sovietSouth_c_0000",
			},
			groupB = {
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_sovietSouth_s_0000",
				"rt_sovietSouth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_sovietSouth_l_0000",
				"rt_sovietSouth_l_0001",
			},
			in_lrrpHold_N = {
				"rt_sovietSouth_lin_N",
				"rt_sovietSouth_lin_N",
			},
			out_lrrpHold_N = {
				"rt_sovietSouth_lout_N",
				"rt_sovietSouth_lout_N",
			},
			in_lrrpHold_E = {
				"rt_sovietSouth_lin_E",
				"rt_sovietSouth_lin_E",
			},
			out_lrrpHold_E = {
				"rt_sovietSouth_lout_E",
				"rt_sovietSouth_lout_E",
			},
		},
		outofrain = {
			"rt_sovietSouth_r_0000",
			"rt_sovietSouth_r_0001",
			"rt_sovietSouth_r_0002",
			"rt_sovietSouth_r_0003",
			"rt_sovietSouth_r_0004",
			"rt_sovietSouth_r_0005",
		},
		nil
	},

	
	afgh_waterwayEast_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_waterwayEast_d_0000",
				"rt_waterwayEast_d_0003",
			},
			groupB = {
				"rt_waterwayEast_d_0001_sub",
				"rt_waterwayEast_d_0004",
			},
			groupC = {
				"rt_waterwayEast_d_0002",
				"rt_waterwayEast_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_waterwayEast_n_0000",
				"rt_waterwayEast_n_0003",
			},
			groupB = {
				"rt_waterwayEast_n_0001_sub",
				"rt_waterwayEast_n_0004",
			},
			groupC = {
				"rt_waterwayEast_n_0002",
				"rt_waterwayEast_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_waterwayEast_c_0000",
				"rt_waterwayEast_c_0001",
				"rt_waterwayEast_c_0002",
				"rt_waterwayEast_c_0003",
				"rt_waterwayEast_c_0002",	
				"rt_waterwayEast_c_0004",
				"rt_waterwayEast_c_0003",
				"rt_waterwayEast_c_0004",
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
				"rt_waterwayEast_s_0000",
				"rt_waterwayEast_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_waterwayEast_l_0000",
				"rt_waterwayEast_l_0001",
			},
		},
		outofrain = {
			"rt_waterwayEast_r_0000",
			"rt_waterwayEast_r_0001",
			"rt_waterwayEast_r_0002",
			"rt_waterwayEast_r_0003",
		},
		nil
	},

	
	
	
	--tex commented probably the largest cp
	afgh_citadel_cp = {
    --tex most other cps have more generically named groupA, groupB etc
    --approx ~2-5 groups for a cp
    --see GetPrioritizedRouteTable which
    --returns a list of routes by adding a route for each group in priority order till all routes are added
    --DEBUGNOW figure out how soldiers are assigned across the route table
		priority = {
			"groupSniper",
			"stage4th",
			"stage3rd",
			"stage2nd",
			"stage1st",
			"groupWalkerGear",
		},
    --tex mostly just groupSniper in other cps (not all cps have groupSnipe), 
    --but afgh_citadel_cp has all groups, and mtbs likewise
		fixedShiftChangeGroup = {
			"groupSniper",
			"stage1st",
			"stage2nd",
			"stage3rd",
			"stage4th",
			"groupWalkerGear",
		},

		sneak_day = {
		  --tex groups with table entries are added (in the same priority order till all done) before groups with regular lists
			groupSniper = {
			 --tex attr SNIPER, or VIP, 
			 --only reference to attr in lua is in mtbs_enemy.GetRouteSetPriority (verify)
			 --however since RouteSelector is called by the exe it could be doing something there
				{ "rt_citadel_snp_0000", attr = "SNIPER" },
				{ "rt_citadel_d_0026", attr = "SNIPER" },
				{ "rt_citadel_d_0020", attr = "SNIPER" },
				{ "rt_citadel_d_0031", attr = "SNIPER" },
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
				"rt_citadel_d_0005",
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
				"rt_citadel_n_0010",
			
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
			nil--tex GOTCHA: watch out for the nils on these route type,routesets when iterating via pairs (shows up as [1]/first array entry)
			--i think the idea is to iterate via priority
		},
		--tex pretty much every other cp just dumps every route into (apart from groupSniper) into first group/groupA
		caution = {
			groupSniper = {
				{ "rt_citadel_snp_0000", attr = "SNIPER" },	
				{ "rt_citadel_c_0034", attr = "SNIPER" },	
				{ "rt_citadel_c_0023", attr = "SNIPER" },	
				{ "rt_citadel_c_0011", attr = "SNIPER" },	
			},
			--tex some of the 'missing routes are just in groupWalkerGear -v-
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
				"rt_citadel_c_0015",
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
    --tex generally cps have hold, ob does not
    --there are actually hold routes for citadel, it just doesnt use them?
    --both hold and sleep are used to hold soldiers for shift changes
    --See TppEnemy.MakeShiftChangeTable
		hold = {
        --tex REF, original is just an empty table
--		    default = {
--      		"rt_citadel_h_0000",
--          "rt_citadel_h_0001",
--          "rt_citadel_h_0002",
--          "rt_citadel_h_0003",
--          "rt_citadel_h_0004",
--          "rt_citadel_h_0005",
--          "rt_citadel_h_0006",
--          "rt_citadel_h_0007",
--          "rt_citadel_h_0008",
--          "rt_citadel_h_0009",
--        },
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
		--tex REF just copied from another cp as example
    --citadel doesnt have travel entry otherwise
    --DEBUGNOW descripe use of travel
    --[[
    travel = {
      lrrpHold = {
        "rt_villageEast_l_0000",
        "rt_villageEast_l_0001",
      },
      in_lrrpHold_E = {
        "rt_villageEast_lin_E",
        "rt_villageEast_lin_E",
      },
      out_lrrpHold_E = {
        "rt_villageEast_lout_E",
        "rt_villageEast_lout_E",
      },
      in_lrrpHold_W = {
        "rt_villageEast_lin_W",
        "rt_villageEast_lin_W",
      },
      out_lrrpHold_W = {
        "rt_villageEast_lout_W",
        "rt_villageEast_lout_W",
      },
    },
    --]]
    --tex GOTCHA: currently doesnt work for addon missions that dont have a location loc_locationCommonRouteSets
    --See TppEnemy.MergeRouteSetDefine
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

	
	
	
	
	afgh_citadelSouth_ob = {
		priority = {
			"groupA",
			"groupB",
		},
		sneak_day = {
			groupA = {
				"rt_citadelSouth_d_0000",
				"rt_citadelSouth_d_0001",
			},
			groupB = {
				"rt_citadelSouth_d_0002",
				"rt_citadelSouth_d_0003",
			},
		},
		sneak_night = {
			groupA = {
				"rt_citadelSouth_n_0000",
				"rt_citadelSouth_n_0001",
			},
			groupB = {
				"rt_citadelSouth_n_0002",
				"rt_citadelSouth_n_0003",
			},
		},
		caution = {
			groupA = {
				"rt_citadelSouth_c_0000",
				"rt_citadelSouth_c_0001",
				"rt_citadelSouth_c_0002",
				"rt_citadelSouth_c_0003",
				"rt_citadelSouth_c_0004",
				"rt_citadelSouth_c_0001",
			},
			groupB = {
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_citadelSouth_s_0000",
				"rt_citadelSouth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_citadelSouth_l_0000",
				"rt_citadelSouth_l_0001",
			},
		},
		
		outofrain = {
			"rt_citadelSouth_r_0000",
			"rt_citadelSouth_r_0001",
			"rt_citadelSouth_r_0002",
			"rt_citadelSouth_r_0003",
		},
		nil
	},
	
	
	

	
	afgh_01_13_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_01to13 = {
				"rt_01to13_0000",
				"rt_01to13_0000",
			},
			lrrp_13to01 = {
				"rt_13to01_0000",
				"rt_13to01_0000",
			},
			rp_01to13 = {
				"rt_01to13_0000",
				"rt_01to13_0000",
				"rt_01to13_0000",
				"rt_01to13_0000",
			},
			rp_13to01 = {
				"rt_13to01_0000",
				"rt_13to01_0000",
				"rt_13to01_0000",
				"rt_13to01_0000",
			},
		},
		nil
	},

	
	afgh_01_32_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_01to32 = {
				"rt_01to32_0000",
				"rt_01to32_0000",
			},
			lrrp_32to01 = {
				"rt_32to01_0000",
				"rt_32to01_0000",
			},
			rp_01to32 = {
				"rt_01to32_0000",
				"rt_01to32_0000",
				"rt_01to32_0000",
				"rt_01to32_0000",
			},
			rp_32to01 = {
				"rt_32to01_0000",
				"rt_32to01_0000",
				"rt_32to01_0000",
				"rt_32to01_0000",
			},
		},
		nil
	},

	
	afgh_02_14_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_02to14 = {
				"rt_02to14_0000",
				"rt_02to14_0000",
			},
			lrrp_14to02 = {
				"rt_14to02_0000",
				"rt_14to02_0000",
			},
			rp_02to14 = {
				"rt_02to14_0000",
				"rt_02to14_0000",
				"rt_02to14_0000",
				"rt_02to14_0000",
			},
			rp_14to02 = {
				"rt_14to02_0000",
				"rt_14to02_0000",
				"rt_14to02_0000",
				"rt_14to02_0000",
			},
		},
		nil
	},

	
	afgh_02_34_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_02to34 = {
				"rt_02to34_0000",
				"rt_02to34_0000",
			},
			lrrp_34to02 = {
				"rt_34to02_0000",
				"rt_34to02_0000",
			},
			rp_02to34 = {
				"rt_02to34_0000",
				"rt_02to34_0000",
				"rt_02to34_0000",
				"rt_02to34_0000",
			},
			rp_34to02 = {
				"rt_34to02_0000",
				"rt_34to02_0000",
				"rt_34to02_0000",
				"rt_34to02_0000",
			},
		},
		nil
	},

	
	afgh_02_35_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_02to35 = {
				"rt_02to35_0000",
				"rt_02to35_0000",
			},
			lrrp_35to02 = {
				"rt_35to02_0000",
				"rt_35to02_0000",
			},
			rp_35to02 = {
				"rt_35to02_0000",
				"rt_35to02_0000",
				"rt_35to02_0000",
				"rt_35to02_0000",
			},
			rp_02to35 = {
				"rt_02to35_0000",
				"rt_02to35_0000",
				"rt_02to35_0000",
				"rt_02to35_0000",
			},
		},
		nil
	},

	
	afgh_03_08_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_03to08 = {
				"rt_03to08_0000",
				"rt_03to08_0000",
			},
			lrrp_08to03 = {
				"rt_08to03_0000",
				"rt_08to03_0000",
			},
			rp_03to08 = {
				"rt_03to08_0000",
				"rt_03to08_0000",
				"rt_03to08_0000",
				"rt_03to08_0000",
			},
			rp_08to03 = {
				"rt_08to03_0000",
				"rt_08to03_0000",
				"rt_08to03_0000",
				"rt_08to03_0000",
			},
		},
		nil
	},

	
	afgh_03_11_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_03to11 = {
				"rt_03to11_0000",
				"rt_03to11_0000",
			},
			lrrp_11to03 = {
				"rt_11to03_0000",
				"rt_11to03_0000",
			},
			rp_03to11 = {
				"rt_03to11_0000",
				"rt_03to11_0000",
				"rt_03to11_0000",
				"rt_03to11_0000",
			},
			rp_11to03 = {
				"rt_11to03_0000",
				"rt_11to03_0000",
				"rt_11to03_0000",
				"rt_11to03_0000",
			},
		},
		nil
	},

	--tex no other references
	afgh_03_23_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_03to23 = {
				"rt_03to23_0000",
				"rt_03to23_0000",
			},
			lrrp_23to03 = {
				"rt_23to03_0000",
				"rt_23to03_0000",
			},

			lrrp_v_03to23 = {
				"rt_03to23_0000",
				"rt_03to23_0000",
				"rt_03to23_0000",
				"rt_03to23_0000",
			},

			rp_03to23 = {
				"rt_03to23_0000",
				"rt_03to23_0000",
				"rt_03to23_0000",
				"rt_03to23_0000",
			},
			rp_23to03 = {
				"rt_23to03_0000",
				"rt_23to03_0000",
				"rt_23to03_0000",
				"rt_23to03_0000",
			},
		},
		nil
	},

	
	afgh_04_32_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_04to32 = {
				"rt_04to32_0000",
				"rt_04to32_0000",
			},
			lrrp_32to04 = {
				"rt_32to04_0000",
				"rt_32to04_0000",
			},
			rp_04to32 = {
				"rt_04to32_0000",
				"rt_04to32_0000",
				"rt_04to32_0000",
				"rt_04to32_0000",
			},
			rp_32to04 = {
				"rt_32to04_0000",
				"rt_32to04_0000",
				"rt_32to04_0000",
				"rt_32to04_0000",
			},
		},
		nil
	},

	
	afgh_04_36_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_04to36 = {
				"rt_04to36_0000",
				"rt_04to36_0000",
			},
			lrrp_36to04 = {
				"rt_36to04_0000",
				"rt_36to04_0000",
			},
			rp_04to36 = {
				"rt_04to36_0000",
				"rt_04to36_0000",
				"rt_04to36_0000",
				"rt_04to36_0000",
			},
			rp_36to04 = {
				"rt_36to04_0000",
				"rt_36to04_0000",
				"rt_36to04_0000",
				"rt_36to04_0000",
			},
		},
		nil
	},

	
	afgh_05_11_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_05to11 = {
				"rt_05to11_0000",
				"rt_05to11_0000",
			},
			lrrp_11to05 = {
				"rt_11to05_0000",
				"rt_11to05_0000",
			},
			rp_05to11 = {
				"rt_05to11_0000",
				"rt_05to11_0000",
				"rt_05to11_0000",
				"rt_05to11_0000",
			},
			rp_11to05 = {
				"rt_11to05_0000",
				"rt_11to05_0000",
				"rt_11to05_0000",
				"rt_11to05_0000",
			},
		},
		nil
	},

	
	afgh_05_33_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_05to33 = {
				"rt_05to33_0000",
				"rt_05to33_0000",
			},
			lrrp_33to05 = {
				"rt_33to05_0000",
				"rt_33to05_0000",
			},
			rp_05to33 = {
				"rt_05to33_0000",
				"rt_05to33_0000",
				"rt_05to33_0000",
				"rt_05to33_0000",
			},
			rp_33to05 = {
				"rt_33to05_0000",
				"rt_33to05_0000",
				"rt_33to05_0000",
				"rt_33to05_0000",
			},
		},
		nil
	},

	
	afgh_06_24_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_06to24 = {
				"rt_06to24_0000",
				"rt_06to24_0000",
			},
			lrrp_24to06 = {
				"rt_24to06_0000",
				"rt_24to06_0000",
			},
			rp_06to24 = {
				"rt_06to24_0000",
				"rt_06to24_0000",
				"rt_06to24_0000",
				"rt_06to24_0000",
			},
			rp_24to06 = {
				"rt_24to06_0000",
				"rt_24to06_0000",
				"rt_24to06_0000",
				"rt_24to06_0000",
			},
		},
		nil
	},

	--tex a couple of missions only (not freeroam)
	afgh_06_36_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_06to36 = {
				"rt_06to36_0000",
				"rt_06to36_0000",
			},
			lrrp_36to06 = {
				"rt_36to06_0000",
				"rt_36to06_0000",
			},
			rp_06to36 = {
				"rt_06to36_0000",
				"rt_06to36_0000",
				"rt_06to36_0000",
				"rt_06to36_0000",
			},
			rp_36to06 = {
				"rt_36to06_0000",
				"rt_36to06_0000",
				"rt_36to06_0000",
				"rt_36to06_0000",
			},
		},
		nil
	},

	
	afgh_07_08_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_07to08 = {
				"rt_07to08_0000",
				"rt_07to08_0000",
			},
			lrrp_08to07 = {
				"rt_08to07_0000",
				"rt_08to07_0000",
			},
			rp_07to08 = {
				"rt_07to08_0000",
				"rt_07to08_0000",
				"rt_07to08_0000",
				"rt_07to08_0000",
			},
			rp_08to07 = {
				"rt_08to07_0000",
				"rt_08to07_0000",
				"rt_08to07_0000",
				"rt_08to07_0000",
			},
		},
		nil
	},

	--tex no other references
	afgh_07_23_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {

			lrrp_07to23 = {
				"rt_07to23_0000",
				"rt_07to23_0000",
			},
			lrrp_23to07 = {
				"rt_23to07_0000",
				"rt_23to07_0000",
			},

			lrrp_v_07to23 = {
				"rt_07to23_0000",
				"rt_07to23_0000",
				"rt_07to23_0000",
				"rt_07to23_0000",
				"rt_07to23_0000",
			},

			rp_07to23 = {
				"rt_07to23_0000",
				"rt_07to23_0000",
				"rt_07to23_0000",
				"rt_07to23_0000",
			},
			rp_23to07 = {
				"rt_23to07_0000",
				"rt_23to07_0000",
				"rt_23to07_0000",
				"rt_23to07_0000",
			},
		},
		nil
	},

	
	afgh_08_23_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_08to23 = {
				"rt_08to23_0000",
				"rt_08to23_0000",
			},
			lrrp_23to08 = {
				"rt_23to08_0000",
				"rt_23to08_0000",
			},
			rp_08to23 = {
				"rt_08to23_0000",
				"rt_08to23_0000",
				"rt_08to23_0000",
				"rt_08to23_0000",
			},
			rp_23to08 = {
				"rt_23to08_0000",
				"rt_23to08_0000",
				"rt_23to08_0000",
				"rt_23to08_0000",
			},
		},
		nil
	},

	
	afgh_09_10_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_09to10 = {
				"rt_09to10_0000",
				"rt_09to10_0000",
			},
			lrrp_10to09 = {
				"rt_10to09_0000",
				"rt_10to09_0000",
			},
			rp_09to10 = {
				"rt_09to10_0000",
				"rt_09to10_0000",
				"rt_09to10_0000",
				"rt_09to10_0000",
			},
			rp_10to09 = {
				"rt_10to09_0000",
				"rt_10to09_0000",
				"rt_10to09_0000",
				"rt_10to09_0000",
			},
		},
		nil
	},

	
	afgh_09_23_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_09to23 = {
				"rt_09to23_0000",
				"rt_09to23_0000",
			},
			lrrp_23to09 = {
				"rt_23to09_0000",
				"rt_23to09_0000",
			},
			rp_09to23 = {
				"rt_09to23_0000",
				"rt_09to23_0000",
				"rt_09to23_0000",
				"rt_09to23_0000",
			},
			rp_23to09 = {
				"rt_23to09_0000",
				"rt_23to09_0000",
				"rt_23to09_0000",
				"rt_23to09_0000",
			},
		},
		nil
	},

	
	afgh_10_31_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_10to31 = {
				"rt_10to31_0000",
				"rt_10to31_0000",
			},
			lrrp_31to10 = {
				"rt_31to10_0000",
				"rt_31to10_0000",
			},
			rp_10to31 = {
				"rt_10to31_0000",
				"rt_10to31_0000",
				"rt_10to31_0000",
				"rt_10to31_0000",
			},
			rp_31to10 = {
				"rt_31to10_0000",
				"rt_31to10_0000",
				"rt_31to10_0000",
				"rt_31to10_0000",
			},
		},
		nil
	},

	
	afgh_12_31_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_12to31 = {
				"rt_12to31_0000",
				"rt_12to31_0000",
			},
			lrrp_31to12 = {
				"rt_31to12_0000",
				"rt_31to12_0000",
			},
			rp_12to31 = {
				"rt_12to31_0000",
				"rt_12to31_0000",
				"rt_12to31_0000",
				"rt_12to31_0000",
			},
			rp_31to12 = {
				"rt_31to12_0000",
				"rt_31to12_0000",
				"rt_31to12_0000",
				"rt_31to12_0000",
			},
		},
		nil
	},

	
	afgh_12_37_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_12to37 = {
				"rt_12to37_0000",
				"rt_12to37_0000",
			},
			lrrp_37to12 = {
				"rt_37to12_0000",
				"rt_37to12_0000",
			},
			rp_12to37 = {
				"rt_12to37_0000",
				"rt_12to37_0000",
				"rt_12to37_0000",
				"rt_12to37_0000",
			},
			rp_37to12 = {
				"rt_37to12_0000",
				"rt_37to12_0000",
				"rt_37to12_0000",
				"rt_37to12_0000",
			},
		},
		nil
	},

	
	afgh_13_34_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_13to34 = {
				"rt_13to34_0000",
				"rt_13to34_0000",
			},
			lrrp_34to13 = {
				"rt_34to13_0000",
				"rt_34to13_0000",
			},
			rp_13to34 = {
				"rt_13to34_0000",
				"rt_13to34_0000",
				"rt_13to34_0000",
				"rt_13to34_0000",
			},
			rp_34to13 = {
				"rt_34to13_0000",
				"rt_34to13_0000",
				"rt_34to13_0000",
				"rt_34to13_0000",
			},
		},
		nil
	},

	
	afgh_14_32_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_14to32 = {
				"rt_14to32_0000",
				"rt_14to32_0000",
			},
			lrrp_32to14 = {
				"rt_32to14_0000",
				"rt_32to14_0000",
			},
			rp_14to32 = {
				"rt_14to32_0000",
				"rt_14to32_0000",
				"rt_14to32_0000",
				"rt_14to32_0000",
			},
			rp_32to14 = {
				"rt_32to14_0000",
				"rt_32to14_0000",
				"rt_32to14_0000",
				"rt_32to14_0000",
			},
		},
		nil
	},

	
	afgh_14_35_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_14to35 = {
				"rt_14to35_0000",
				"rt_14to35_0000",
			},
			lrrp_35to14 = {
				"rt_35to14_0000",
				"rt_35to14_0000",
			},
			rp_14to35 = {
				"rt_14to35_0000",
				"rt_14to35_0000",
				"rt_14to35_0000",
				"rt_14to35_0000",
			},
			rp_35to14 = {
				"rt_35to14_0000",
				"rt_35to14_0000",
				"rt_35to14_0000",
				"rt_35to14_0000",
			},
		},
		nil
	},

	
	afgh_15_35_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_15to35 = {
				"rt_15to35_0000",
				"rt_15to35_0000",
			},
			lrrp_35to15 = {
				"rt_35to15_0000",
				"rt_35to15_0000",
			},
			rp_15to35 = {
				"rt_15to35_0000",
				"rt_15to35_0000",
				"rt_15to35_0000",
				"rt_15to35_0000",
			},
			rp_35to15 = {
				"rt_35to15_0000",
				"rt_35to15_0000",
				"rt_35to15_0000",
				"rt_35to15_0000",
			},
		},
		nil
	},

	
	afgh_15_36_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_15to36 = {
				"rt_15to36_0000",
				"rt_15to36_0000",
			},
			lrrp_36to15 = {
				"rt_36to15_0000",
				"rt_36to15_0000",
			},
			rp_15to36 = {
				"rt_15to36_0000",
				"rt_15to36_0000",
				"rt_15to36_0000",
				"rt_15to36_0000",
			},
			rp_36to15 = {
				"rt_36to15_0000",
				"rt_36to15_0000",
				"rt_36to15_0000",
				"rt_36to15_0000",
			},
		},
		nil
	},

	
	afgh_16_29_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_16to29 = {
				"rt_16to29_0000",
				"rt_16to29_0000",
			},
			lrrp_29to16 = {
				"rt_29to16_0000",
				"rt_29to16_0000",
			},
			rp_16to29 = {
				"rt_16to29_0000",
				"rt_16to29_0000",
				"rt_16to29_0000",
				"rt_16to29_0000",
			},
			rp_29to16 = {
				"rt_29to16_0000",
				"rt_29to16_0000",
				"rt_29to16_0000",
				"rt_29to16_0000",
			},
		},
		nil
	},

	
	afgh_18_39_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_18to39 = {
				"rt_18to39_0000",
				"rt_18to39_0000",
			},
			lrrp_39to18 = {
				"rt_39to18_0000",
				"rt_39to18_0000",
			},
			rp_18to39 = {
				"rt_18to39_0000",
				"rt_18to39_0000",
				"rt_18to39_0000",
				"rt_18to39_0000",
			},
			rp_39to18 = {
				"rt_39to18_0000",
				"rt_39to18_0000",
				"rt_39to18_0000",
				"rt_39to18_0000",
			},
		},
		nil
	},

	
	afgh_19_26_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_19to26 = {
				"rt_19to26_0000",
				"rt_19to26_0000",
			},
			lrrp_26to19 = {
				"rt_26to19_0000",
				"rt_26to19_0000",
			},
			rp_19to26 = {
				"rt_19to26_0000",
				"rt_19to26_0000",
				"rt_19to26_0000",
				"rt_19to26_0000",
			},
			rp_26to19 = {
				"rt_26to19_0000",
				"rt_26to19_0000",
				"rt_26to19_0000",
				"rt_26to19_0000",
			},
		},
		nil
	},

	
	afgh_19_39_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_19to39 = {
				"rt_19to39_0000",
				"rt_19to39_0000",
			},
			lrrp_39to19 = {
				"rt_39to19_0000",
				"rt_39to19_0000",
			},
			rp_19to39 = {
				"rt_19to39_0000",
				"rt_19to39_0000",
				"rt_19to39_0000",
				"rt_19to39_0000",
			},
			rp_39to19 = {
				"rt_39to19_0000",
				"rt_39to19_0000",
				"rt_39to19_0000",
				"rt_39to19_0000",
			},
		},
		nil
	},

	
	afgh_20_21_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_20to21 = {
				"rt_20to21_0000",
				"rt_20to21_0000",
			},
			lrrp_21to20 = {
				"rt_21to20_0000",
				"rt_21to20_0000",
			},
			rp_20to21 = {
				"rt_20to21_0000",
				"rt_20to21_0000",
				"rt_20to21_0000",
				"rt_20to21_0000",
			},
			rp_21to20 = {
				"rt_21to20_0000",
				"rt_21to20_0000",
				"rt_21to20_0000",
				"rt_21to20_0000",
			},
		},
		nil
	},

	
	afgh_20_28_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_20to28 = {
				"rt_20to28_0000",
				"rt_20to28_0000",
			},
			lrrp_28to20 = {
				"rt_28to20_0000",
				"rt_28to20_0000",
			},
			rp_20to28 = {
				"rt_20to28_0000",
				"rt_20to28_0000",
				"rt_20to28_0000",
				"rt_20to28_0000",
			},
			rp_28to20 = {
				"rt_28to20_0000",
				"rt_28to20_0000",
				"rt_28to20_0000",
				"rt_28to20_0000",
			},
		},
		nil
	},

	
	afgh_20_29_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_20to29 = {
				"rt_20to29_0000",
				"rt_20to29_0000",
			},
			lrrp_29to20 = {
				"rt_29to20_0000",
				"rt_29to20_0000",
			},
			rp_20to29 = {
				"rt_20to29_0000",
				"rt_20to29_0000",
				"rt_20to29_0000",
				"rt_20to29_0000",
			},
			rp_29to20 = {
				"rt_29to20_0000",
				"rt_29to20_0000",
				"rt_29to20_0000",
				"rt_29to20_0000",
			},
		},
		nil
	},

	
	afgh_21_24_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_21to24 = {
				"rt_21to24_0000",
				"rt_21to24_0000",
			},
			lrrp_24to21 = {
				"rt_24to21_0000",
				"rt_24to21_0000",
			},
			rp_21to24 = {
				"rt_21to24_0000",
				"rt_21to24_0000",
				"rt_21to24_0000",
				"rt_21to24_0000",
			},
			rp_24to21 = {
				"rt_24to21_0000",
				"rt_24to21_0000",
				"rt_24to21_0000",
				"rt_24to21_0000",
			},
		},
		nil
	},

	
	afgh_21_28_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_21to28 = {
				"rt_21to28_0000",
				"rt_21to28_0000",
			},
			lrrp_28to21 = {
				"rt_28to21_0000",
				"rt_28to21_0000",
			},
			rp_21to28 = {
				"rt_21to28_0000",
				"rt_21to28_0000",
				"rt_21to28_0000",
				"rt_21to28_0000",
			},
			rp_28to21 = {
				"rt_28to21_0000",
				"rt_28to21_0000",
				"rt_28to21_0000",
				"rt_28to21_0000",
			},
		},
		nil
	},

	
	afgh_22_24_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_22to24 = {
				"rt_22to24_0000",
				"rt_22to24_0000",
			},
			lrrp_24to22 = {
				"rt_24to22_0000",
				"rt_24to22_0000",
			},
			rp_22to24 = {
				"rt_22to24_0000",
				"rt_22to24_0000",
				"rt_22to24_0000",
				"rt_22to24_0000",
			},
			rp_24to22 = {
				"rt_24to22_0000",
				"rt_24to22_0000",
				"rt_24to22_0000",
				"rt_24to22_0000",
			},
		},
		nil
	},

	
	afgh_27_39_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_27to39 = {
				"rt_27to39_0000",
				"rt_27to39_0000",
			},
			lrrp_39to27 = {
				"rt_39to27_0000",
				"rt_39to27_0000",
			},
			rp_27to39 = {
				"rt_27to39_0000",
				"rt_27to39_0000",
				"rt_27to39_0000",
				"rt_27to39_0000",
			},
			rp_39to27 = {
				"rt_39to27_0000",
				"rt_39to27_0000",
				"rt_39to27_0000",
				"rt_39to27_0000",
			},
		},
		nil
	},

	
	afgh_28_29_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_28to29 = {
				"rt_28to29_0000",
				"rt_28to29_0000",
			},
			lrrp_29to28 = {
				"rt_29to28_0000",
				"rt_29to28_0000",
			},
			rp_28to29 = {
				"rt_28to29_0000",
				"rt_28to29_0000",
				"rt_28to29_0000",
				"rt_28to29_0000",
			},
			rp_29to28 = {
				"rt_29to28_0000",
				"rt_29to28_0000",
				"rt_29to28_0000",
				"rt_29to28_0000",
			},
		},
		nil
	},

	
	afgh_33_37_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_33to37 = {
				"rt_33to37_0000",
				"rt_33to37_0000",
			},
			lrrp_37to33 = {
				"rt_37to33_0000",
				"rt_37to33_0000",
			},
			rp_33to37 = {
				"rt_33to37_0000",
				"rt_33to37_0000",
				"rt_33to37_0000",
				"rt_33to37_0000",
			},
			rp_37to33 = {
				"rt_37to33_0000",
				"rt_37to33_0000",
				"rt_37to33_0000",
				"rt_37to33_0000",
			},
		},
		nil
	},

	
	afgh_36_38_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
			groupA = {
			},
		},
		caution = {
			groupA = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_36to38 = {
				"rt_36to38_0000",
				"rt_36to38_0000",
			},
			lrrp_38to36 = {
				"rt_38to36_0000",
				"rt_38to36_0000",
			},
			rp_36to38 = {
				"rt_36to38_0000",
				"rt_36to38_0000",
				"rt_36to38_0000",
				"rt_36to38_0000",
			},
			rp_38to36 = {
				"rt_38to36_0000",
				"rt_38to36_0000",
				"rt_38to36_0000",
				"rt_38to36_0000",
			},
		},
		nil
	},

	quest_cp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
			},
		},
		sneak_night = {
			groupA = {
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
			},
		},
		caution = {
			groupA = {
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
				"rt_quest_dummy_0000",
			},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
			},
		},
		travel = {
			lrrpHold = {
			},
		},
		nil
	},

	nil
}


return afgh_routeSets
