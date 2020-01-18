local mafr_routeSets

mafr_routeSets = {

	
	
	

	
	
	
	
	mafr_outland_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_outland_d_0000_no_tower_sub",
				"rt_outland_d_0001_no_tower_sub",
				"rt_outland_d_0002",
				"rt_outland_d_0003",
			},
			groupB = {
				"rt_outland_d_0004",
				"rt_outland_d_0005",
				"rt_outland_d_0006",
				"rt_outland_d_0007",
			},
			groupC = {
				"rt_outland_d_0008",
				"rt_outland_d_0009",
				"rt_outland_d_0010",
				"rt_outland_d_0011",
			},
		},
		sneak_night= {
			groupA = {
				"rt_outland_n_0000_no_search_light_sub",
				"rt_outland_n_0001_no_search_light_sub",
				"rt_outland_n_0002",
				"rt_outland_n_0003",
			},
			groupB = {
				"rt_outland_n_0004",
				"rt_outland_n_0005",
				"rt_outland_n_0006",
				"rt_outland_n_0007",
			},
			groupC = {
				"rt_outland_n_0008",
				"rt_outland_n_0009",
				"rt_outland_n_0010",
				"rt_outland_n_0011",
			},
		},
		caution = {
			groupA = {
				"rt_outland_c_0000",
				"rt_outland_c_0000",
				"rt_outland_c_0001",
				"rt_outland_c_0001",
				"rt_outland_c_0002",
				"rt_outland_c_0002",
				"rt_outland_c_0003",
				"rt_outland_c_0003",
				"rt_outland_c_0004",
				"rt_outland_c_0004",
				"rt_outland_c_0005",
				"rt_outland_c_0005",
				"rt_outland_c_0006",
				"rt_outland_c_0006",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
				"rt_outland_h_0000",
				"rt_outland_h_0001",
				"rt_outland_h_0002",
				"rt_outland_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_outland_s_0000",
				"rt_outland_s_0001",
				"rt_outland_s_0002",
				"rt_outland_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_outland_l_0000",
				"rt_outland_l_0001",
			},
			in_lrrpHold_S = {
				"rt_outland_lin_S",
				"rt_outland_lin_S",
			},
			out_lrrpHold_S = {
				"rt_outland_lout_S",
				"rt_outland_lout_S",
			},
			in_lrrpHold_N = {
				"rt_outland_lin_N",
				"rt_outland_lin_N",
			},
			out_lrrpHold_N = {
				"rt_outland_lout_N",
				"rt_outland_lout_N",
			},
		},
		outofrain = {
			"rt_outland_r_0000",
			"rt_outland_r_0001",
			"rt_outland_r_0002",
			"rt_outland_r_0003",
			"rt_outland_r_0004",
			"rt_outland_r_0005",
			"rt_outland_r_0006",
			"rt_outland_r_0007",
			"rt_outland_r_0008",
			"rt_outland_r_0009",
			"rt_outland_r_0010",
			"rt_outland_r_0011",
			"rt_outland_r_0012",
			"rt_outland_r_0013",
			"rt_outland_r_0014",
			"rt_outland_r_0015",
			"rt_outland_r_0016",
			"rt_outland_r_0017",
			"rt_outland_r_0018",
			"rt_outland_r_0019",
		},
		nil
	},

	
	
	

	
	mafr_outlandEast_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_outlandEast_d_0000_sub",
				"rt_outlandEast_d_0003",
			},
			groupB = {
				"rt_outlandEast_d_0001",
				"rt_outlandEast_d_0004",
			},
			groupC = {
				"rt_outlandEast_d_0002",
				"rt_outlandEast_d_0005",
			},
		},
		sneak_night= {
			groupA = {
				"rt_outlandEast_n_0000_sub",
				"rt_outlandEast_n_0003",
			},
			groupB = {
				"rt_outlandEast_n_0001",
				"rt_outlandEast_n_0004",
			},
			groupC = {
				"rt_outlandEast_n_0002",
				"rt_outlandEast_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_outlandEast_c_0000",
				"rt_outlandEast_c_0001",	
				"rt_outlandEast_c_0001",	
				"rt_outlandEast_c_0002",
				"rt_outlandEast_c_0003",
				"rt_outlandEast_c_0004",
				"rt_outlandEast_c_0005",
				"rt_outlandEast_c_0006",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_outlandEast_s_0000",
				"rt_outlandEast_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_outlandEast_l_0000",
				"rt_outlandEast_l_0001",
			},
			in_lrrpHold_S = {
				"rt_outlandEast_lin_S",
				"rt_outlandEast_lin_S",
			},
			out_lrrpHold_B01 = {
				"rt_outlandEast_lout_B01",
				"rt_outlandEast_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_outlandEast_lout_B02",
				"rt_outlandEast_lout_B02",
			},
			out_lrrpHold_B03 = {
				"rt_outlandEast_lout_B03",
				"rt_outlandEast_lout_B03",
			},
		},
		outofrain = {
			"rt_outlandEast_r_0000",
			"rt_outlandEast_r_0001",
			"rt_outlandEast_r_0002",
			"rt_outlandEast_r_0003",
			"rt_outlandEast_r_0004",
			"rt_outlandEast_r_0005",
		},
		nil
	},

	
	mafr_outlandNorth_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_outlandNorth_d_0000_sub",
				"rt_outlandNorth_d_0001",
			},
			groupB = {
				"rt_outlandNorth_d_0002",
				"rt_outlandNorth_d_0003",
			},
			groupC = {
				"rt_outlandNorth_d_0004",
				"rt_outlandNorth_d_0005",
			},
		},
		sneak_night= {
			groupA = {
				"rt_outlandNorth_n_0000_sub",
				"rt_outlandNorth_n_0001",
			},
			groupB = {
				"rt_outlandNorth_n_0002",
				"rt_outlandNorth_n_0003",
			},
			groupC = {
				"rt_outlandNorth_n_0004",
				"rt_outlandNorth_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_outlandNorth_c_0000_sub",
				"rt_outlandNorth_c_0001",
				"rt_outlandNorth_c_0002",
				"rt_outlandNorth_c_0003",
				"rt_outlandNorth_c_0004",
				"rt_outlandNorth_c_0005",
				"rt_outlandNorth_c_0006",
				"rt_outlandNorth_c_0006",	
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
				"rt_outlandNorth_s_0000",
				"rt_outlandNorth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_outlandNorth_l_0000",
				"rt_outlandNorth_l_0001",
			},
			in_lrrpHold_S = {
				"rt_outlandNorth_lin_S",
				"rt_outlandNorth_lin_S",
			},
			out_lrrpHold_B01 = {
				"rt_outlandNorth_lout_B01",
				"rt_outlandNorth_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_outlandNorth_lout_B02",
				"rt_outlandNorth_lout_B02",
			},
			out_lrrpHold_B03 = {
				"rt_outlandNorth_lout_B03",
				"rt_outlandNorth_lout_B03",
			},
		},
		nil
	},

	
	
	
	
	
	
	
	mafr_flowStation_cp = {
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
				{ "rt_flowStation_snp_0000", attr = "SNIPER" },
				{ "rt_flowStation_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_flowStation_d_0000",
				"rt_flowStation_d_0001",
				"rt_flowStation_d_0002",
				"rt_flowStation_d_0003",
			},
			groupB = {
				"rt_flowStation_d_0004",
				"rt_flowStation_d_0005",
				"rt_flowStation_d_0006",
				"rt_flowStation_d_0007",
			},
			groupC = {
				"rt_flowStation_d_0008",
				"rt_flowStation_d_0009",
				"rt_flowStation_d_0010",
				"rt_flowStation_d_0011",
			},
		},
		sneak_night = {
			groupSniper = {
				{ "rt_flowStation_snp_0000", attr = "SNIPER" },
				{ "rt_flowStation_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_flowStation_n_0000",
				"rt_flowStation_n_0001",
				"rt_flowStation_n_0002",
				"rt_flowStation_n_0003",
			},
			groupB = {
				"rt_flowStation_n_0004",
				"rt_flowStation_n_0005",
				"rt_flowStation_n_0006",
				"rt_flowStation_n_0007",
			},
			groupC = {
				"rt_flowStation_n_0008",
				"rt_flowStation_n_0009",
				"rt_flowStation_n_0010",
				"rt_flowStation_n_0011",
			},
		},
		caution = {
			groupSniper = {
				{ "rt_flowStation_snp_0000", attr = "SNIPER" },
				{ "rt_flowStation_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_flowStation_c_0000",
				"rt_flowStation_c_0001",
				"rt_flowStation_c_0002",
				"rt_flowStation_c_0003",
				"rt_flowStation_c_0004",
				"rt_flowStation_c_0005",
				"rt_flowStation_c_0006",
				"rt_flowStation_c_0007",
				"rt_flowStation_c_0008",
				"rt_flowStation_c_0009",
				"rt_flowStation_c_0010",
				"rt_flowStation_c_0011",
				"rt_flowStation_c_0012",
				"rt_flowStation_c_0013",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			groupSniper = {		
			},
			default = {
				"rt_flowStation_h_0000",
				"rt_flowStation_h_0001",
				"rt_flowStation_h_0002",
				"rt_flowStation_h_0003",
			},
		},
		sleep = {
			groupSniper = {		
			},
			default = {
				"rt_flowStation_s_0000",
				"rt_flowStation_s_0001",
				"rt_flowStation_s_0002",
				"rt_flowStation_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_flowStation_l_0000",
				"rt_flowStation_l_0001",
			},
			in_lrrpHold_W = {
				"rt_flowStation_lin_W",
				"rt_flowStation_lin_W",
			},
			out_lrrpHold_B01 = {
				"rt_flowStation_lout_B01",
				"rt_flowStation_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_flowStation_lout_B02",
				"rt_flowStation_lout_B02",
			},
		},
		nil
	},

	
	mafr_swamp_cp = {
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
				{ "rt_swamp_snp_0000", attr = "SNIPER" },
				{ "rt_swamp_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_swamp_d_0000",
				"rt_SwampNear_d_0000",
				"rt_swamp_d_0007",
				"rt_swamp_d_0011",
			},
			groupB = {
				"rt_swamp_d_0001",
				"rt_SwampNear_d_0001",
				"rt_swamp_d_0008",
				"rt_swamp_d_0012",
			},
			groupC = {
				"rt_swamp_d_0002",
				"rt_SwampNear_d_0002_no_watchtower_sub",
				"rt_swamp_d_0009",
				"rt_SwampNear_d_0004",
			},
			groupD = {
				"rt_swamp_d_0003",
				"rt_swamp_d_0005",
				"rt_swamp_d_0010",
				"rt_swamp_d_0013",
			},
			groupE = {
				"rt_swamp_d_0004",
				"rt_swamp_d_0006",
				"rt_SwampNear_d_0003",
				"rt_swamp_d_0014",
			},
		},
		sneak_night = {
			groupSniper = {
				{ "rt_swamp_snp_0000", attr = "SNIPER" },
				{ "rt_swamp_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_swamp_n_0000",
				"rt_SwampNear_n_0000_no_searchlight_sub",
				"rt_swamp_n_0007",
				"rt_swamp_n_0011",
			},
			groupB = {
				"rt_swamp_n_0001_no_searchlight_sub",
				"rt_SwampNear_n_0001_no_searchlight_sub",
				"rt_swamp_n_0008_no_searchlight_sub",
				"rt_swamp_n_0012",
			},
			groupC = {
				"rt_swamp_n_0002",
				"rt_SwampNear_n_0002",
				"rt_swamp_n_0009_no_searchlight_sub",
				"rt_SwampNear_n_0004",
			},
			groupD = {
				"rt_swamp_n_0003_no_searchlight_sub",
				"rt_swamp_n_0005_no_searchlight_sub",
				"rt_swamp_n_0010",
				"rt_swamp_n_0013",
			},
			groupE = {
				"rt_swamp_n_0004",
				"rt_swamp_n_0006",
				"rt_SwampNear_n_0003",
				"rt_swamp_n_0014",
			},
		},
		caution = {
			groupSniper = {
				{ "rt_swamp_snp_0000", attr = "SNIPER" },
				{ "rt_swamp_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_swamp_c_0000",
				"rt_swamp_c_0001",
				"rt_swamp_c_0002",
				"rt_swamp_c_0003",
				"rt_swamp_c_0004_searchlight",
				"rt_SwampNear_c_0000",
				"rt_SwampNear_c_0001_searchlight",
				"rt_SwampNear_c_0002",
				"rt_swamp_c_0005",
				"rt_swamp_c_0006",
				"rt_swamp_c_0007",
				"rt_swamp_c_0008",
				"rt_swamp_c_0009",
				"rt_swamp_c_0010",
				"rt_SwampNear_c_0003",
				"rt_SwampNear_c_0004",
				"rt_swamp_c_0000",		
				"rt_swamp_c_0011",
				"rt_swamp_c_0012",
				"rt_swamp_c_0013",
				"rt_swamp_c_0014",
				"rt_swamp_c_0015",
			},
			groupB = {},
			groupC = {},
			groupD = {},
			groupE = {},
		},
		hold = {
			groupSniper = {		
			},
			default = {
				"rt_swamp_h_0000",
				"rt_swamp_h_0001",
				"rt_swampNear_h_0000",
				"rt_swamp_h_0002",
				"rt_swampNear_h_0001",
			},
		},
		sleep = {
			groupSniper = {		
			},
			default = {
				"rt_swamp_s_0000",
				"rt_swamp_s_0001",
				"rt_swampNear_s_0000",
				"rt_swamp_s_0002",
				"rt_swampNear_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_swamp_l_0000",
				"rt_swamp_l_0001",
			},
			lrrpHold_01 = {
				"rt_swamp_l_0002",
				"rt_swamp_l_0003",
			},
			in_lrrpHold_N = {
				"rt_swamp_lin_N",
				"rt_swamp_lin_N",
			},
			in_lrrpHold_E = {
				"rt_swamp_lin_E",
				"rt_swamp_lin_E",
			},
			out_lrrpHold_B01 = {
				"rt_swamp_lout_B01",
				"rt_swamp_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_swamp_lout_B02",
				"rt_swamp_lout_B02",
			},
			out_lrrpHold_B03 = {
				"rt_swamp_lout_B03",
				"rt_swamp_lout_B03",
			},
			out_lrrpHold_B04 = {
				"rt_swamp_lout_B04",
				"rt_swamp_lout_B04",
			},
		},
		outofrain = {
			"rt_swamp_r_0000",
			"rt_swamp_r_0001",
			"rt_swamp_r_0002",
			"rt_swamp_r_0003",
			"rt_swamp_r_0004",
			"rt_swamp_r_0005",
			"rt_swamp_r_0006",
			"rt_swamp_r_0007",
			"rt_swamp_r_0008",
			"rt_swamp_r_0009",
			"rt_swamp_r_0010",
			"rt_swamp_r_0011",
		},
		nil
	},

	
	mafr_savannah_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_savannah_d_0000",
				"rt_savannah_d_0007",
				"rt_savannah_d_0002",
				"rt_savannah_d_0003",
			},
			groupB = {
				"rt_savannah_d_0012",
				"rt_savannah_d_0005",
				"rt_savannah_d_0006",
				"rt_savannah_d_0001",
				"rt_savannah_d_0004",
			},
			groupC = {
				"rt_savannah_d_0013",
				"rt_savannah_d_0009",
				"rt_savannah_d_0010",
				"rt_savannah_d_0011",
				"rt_savannah_d_0008",
			},
		},
		sneak_night = {
			groupA = {
				"rt_savannah_n_0000_sub",
				"rt_savannah_n_0003",
				"rt_savannah_n_0002",
				"rt_savannah_n_0001",
			},
			groupB = {
				"rt_savannah_n_0012",
				"rt_savannah_n_0004",
				"rt_savannah_n_0005",
				"rt_savannah_n_0006_sub",
				"rt_savannah_n_0009",
			},
			groupC = {
				"rt_savannah_n_0011_sub",
				"rt_savannah_n_0007_sub",
				"rt_savannah_n_0010",
				"rt_savannah_n_0013",
				"rt_savannah_n_0008",
			},
		},
		caution = {
			groupA = {
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
			in_lrrpHold_E = {
				"rt_savannah_lin_E",
				"rt_savannah_lin_E",
			},
			out_lrrpHold_E = {
				"rt_savannah_lout_E",
				"rt_savannah_lout_E",
			},
			in_lrrpHold_W = {
				"rt_savannah_lin_W",
				"rt_savannah_lin_W",
			},
			out_lrrpHold_W = {
				"rt_savannah_lout_W",
				"rt_savannah_lout_W",
			},
		},
		outofrain = {
			"rt_savannah_r_0000",
			"rt_savannah_r_0001",
			"rt_savannah_r_0002",
			"rt_savannah_r_0003",
			"rt_savannah_r_0004",
			"rt_savannah_r_0005",
			"rt_savannah_r_0006",
			"rt_savannah_r_0007",
			"rt_savannah_r_0008",
			"rt_savannah_r_0009",
			"rt_savannah_r_0010",
			"rt_savannah_r_0011",
		},
		nil
	},

	
	mafr_pfCamp_cp = {
		priority = {
			"groupSniper",
			"groupA",
			"groupB",
			"groupC",
			"groupD",
			"groupE",
			"groupF",
		},

		fixedShiftChangeGroup = {
			"groupSniper",          
		},

		sneak_day = {
			groupSniper = {
				{ "rt_pfCamp_snp_0000", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0001", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0002", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0003", attr = "SNIPER", },
			},
			groupA = {
				"rt_pfCamp_d_0000",
				"rt_pfCamp_d_0001",
			},
			groupB = {
				"rt_pfCamp_d_0002",
				"rt_pfCamp_d_0003",
			},
			groupC = {
				"rt_pfCamp_d_0004",
				"rt_pfCamp_d_0005",
			},
			groupD = {
				"rt_pfCamp_d_0006",
				"rt_pfCamp_d_0007",
			},
			groupE = {
				"rt_pfCamp_d_0008",
				"rt_pfCamp_d_0009",
			},
			groupF = {
				"rt_pfCamp_d_0010",
				"rt_pfCamp_d_0011",
			},
		},
		sneak_night = {
			groupSniper = {
				{ "rt_pfCamp_snp_0000", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0001", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0002", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0003", attr = "SNIPER", },
			},
			groupA = {
				"rt_pfCamp_n_0000_sub",
				"rt_pfCamp_n_0001_sub",
			},
			groupB = {
				"rt_pfCamp_n_0002",
				"rt_pfCamp_n_0003",
			},
			groupC = {
				"rt_pfCamp_n_0004",
				"rt_pfCamp_n_0005",
			},
			groupD = {
				"rt_pfCamp_n_0006",
				"rt_pfCamp_n_0007",
			},
			groupE = {
				"rt_pfCamp_n_0008",
				"rt_pfCamp_n_0009",
			},
			groupF = {
				"rt_pfCamp_n_0010",
				"rt_pfCamp_n_0011",
			},
		},

		caution = {
			groupSniper = {
				{ "rt_pfCamp_snp_0000", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0001", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0002", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0003", attr = "SNIPER", },
			},
			groupA = {
				"rt_pfCamp_c_0002",
				"rt_pfCamp_c_0002",
				"rt_pfCamp_c_0003",
				"rt_pfCamp_c_0004",
				"rt_pfCamp_c_0005",
				"rt_pfCamp_c_0006",
				"rt_pfCamp_c_0007",
				"rt_pfCamp_c_0008",
				"rt_pfCamp_c_0008",
				"rt_pfCamp_c_0009",
				"rt_pfCamp_c_0010",
				"rt_pfCamp_c_0011",
				"rt_pfCamp_c_0000",
				"rt_pfCamp_c_0001",
			},
			groupB = {},
			groupC = {},
			groupD = {},
			groupE = {},
			groupF = {},
		},

		hold = {
            groupSniper = {         
            },
			default = {
				"rt_pfCamp_h_0000",
				"rt_pfCamp_h_0001",
			},
		},
		sleep = {
            groupSniper = {         
            },
			default = {
				"rt_pfCamp_s_0000",
				"rt_pfCamp_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_pfCamp_l_0000",
				"rt_pfCamp_l_0001",
			},
			in_lrrpHold_S = {
				"rt_pfCamp_lin_S",
				"rt_pfCamp_lin_S",
			},
			out_lrrpHold_S = {
				"rt_pfCamp_lout_S",
				"rt_pfCamp_lout_S",
			},
		},
		outofrain = {
			"rt_pfCamp_r_0000",
			"rt_pfCamp_r_0001",
			"rt_pfCamp_r_0002",
			"rt_pfCamp_r_0003",
			"rt_pfCamp_r_0004",
			"rt_pfCamp_r_0005",
			"rt_pfCamp_r_0006",
			"rt_pfCamp_r_0007",
			"rt_pfCamp_r_0008",
			"rt_pfCamp_r_0009",
			"rt_pfCamp_r_0010",
			"rt_pfCamp_r_0011",
			"rt_pfCamp_r_0012",
			"rt_pfCamp_r_0013",
			"rt_pfCamp_r_0014",
			"rt_pfCamp_r_0015",
			"rt_pfCamp_r_0016",
			"rt_pfCamp_r_0017",
			"rt_pfCamp_r_0018",
			"rt_pfCamp_r_0019",
		},
		nil
	},

	
	
	
	
	mafr_swampEast_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		sneak_day = {
			groupA = {
				"rt_swampEast_d_0000_sub",	
				"rt_swampEast_d_0001",
			},
			groupB = {
				"rt_swampEast_d_0002",
				"rt_swampEast_d_0003",
			},
			groupC = {
				"rt_swampEast_d_0004",
				"rt_swampEast_d_0005",
			},
			groupD = {
				"rt_swampEast_d_0006",
				"rt_swampEast_d_0007",
			},
		},
		sneak_night= {
			groupA = {
				"rt_swampEast_n_0000_sub",	
				"rt_swampEast_n_0002",
			},
			groupB = {
				"rt_swampEast_n_0001_sub",	
				"rt_swampEast_n_0003",
			},
			groupC = {
				"rt_swampEast_n_0004",
				"rt_swampEast_n_0005",
			},
			groupD = {
				"rt_swampEast_n_0006",
				"rt_swampEast_n_0007",
			},
		},
		caution = {
			groupA = {
				"rt_swampEast_c_0000",
				"rt_swampEast_c_0001_sub",
				"rt_swampEast_c_0002_sub",
				"rt_swampEast_c_0003",
				"rt_swampEast_c_0004",
				"rt_swampEast_c_0003",	
				"rt_swampEast_c_0000",	
				"rt_swampEast_c_0004",	
			},
			groupB = {},
			groupC = {},
			groupD = {},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_swampEast_s_0000",
				"rt_swampEast_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_swampEast_l_0000",
				"rt_swampEast_l_0001",
			},
			in_lrrpHold_E = {
				"rt_swampEast_lin_E",
				"rt_swampEast_lin_E",
			},
			out_lrrpHold_E = {
				"rt_swampEast_lout_E",
				"rt_swampEast_lout_E",
			},
			in_lrrpHold_W = {
				"rt_swampEast_lin_W",
				"rt_swampEast_lin_W",
			},
			out_lrrpHold_W = {
				"rt_swampEast_lout_W",
				"rt_swampEast_lout_W",
			},
		},
		outofrain = {
			"rt_swampEast_r_0000",
			"rt_swampEast_r_0001",
			"rt_swampEast_r_0002",
			"rt_swampEast_r_0003",
			"rt_swampEast_r_0004",
			"rt_swampEast_r_0005",
		},
		nil
	},

	
	mafr_swampSouth_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_swampSouth_d_0000",
				"rt_swampSouth_d_0001",
			},
			groupB = {
				"rt_swampSouth_d_0002",
				"rt_swampSouth_d_0003",
			},
			groupC = {
				"rt_swampSouth_d_0004",
				"rt_swampSouth_d_0005",
			},
		},
		sneak_night= {
			groupA = {
				"rt_swampSouth_n_0000",
				"rt_swampSouth_n_0001",
			},
			groupB = {
				"rt_swampSouth_n_0002",
				"rt_swampSouth_n_0003",
			},
			groupC = {
				"rt_swampSouth_n_0004",
				"rt_swampSouth_n_0004",
			},
		},
		caution = {
			groupA = {
				"rt_swampSouth_c_0000",
				"rt_swampSouth_c_0001",
				"rt_swampSouth_c_0002",
				"rt_swampSouth_c_0000",
				"rt_swampSouth_c_0003",
				"rt_swampSouth_c_0003",
				"rt_swampSouth_c_0004",
				"rt_swampSouth_c_0004",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_swampSouth_s_0000",
				"rt_swampSouth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_swampSouth_l_0000",
				"rt_swampSouth_l_0001",
			},
		},
		outofrain = {
			"rt_swampSouth_r_0000",
			"rt_swampSouth_r_0001",
			"rt_swampSouth_r_0002",
			"rt_swampSouth_r_0003",
			"rt_swampSouth_r_0004",
			"rt_swampSouth_r_0005",
			"rt_swampSouth_r_0006",
			"rt_swampSouth_r_0007",
		},
		nil
	},

	
	mafr_swampWest_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_swampWest_d_0000",
				"rt_swampWest_d_0001",
			},
			groupB = {
				"rt_swampWest_d_0002",
				"rt_swampWest_d_0003",
			},
			groupC = {
				"rt_swampWest_d_0004",
				"rt_swampWest_d_0005",
			},
		},
		sneak_night= {
			groupA = {
				"rt_swampWest_n_0000",
				"rt_swampWest_n_0001",
			},
			groupB = {
				"rt_swampWest_n_0002",
				"rt_swampWest_n_0002",
			},
			groupC = {
				"rt_swampWest_n_0003",
				"rt_swampWest_n_0004",
			},
		},
		caution = {
			groupA = {
				"rt_swampWest_c_0000",
				"rt_swampWest_c_0001",
				"rt_swampWest_c_0003",
				"rt_swampWest_c_0002",
				"rt_swampWest_c_0000",
				"rt_swampWest_c_0001",
				"rt_swampWest_c_0003",
				"rt_swampWest_c_0002",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_swampWest_s_0000",
				"rt_swampWest_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_swampWest_l_0000",
				"rt_swampWest_l_0001",
			},
			in_lrrpHold_N = {
				"rt_swampWest_lin_N",
				"rt_swampWest_lin_N",
			},
			out_lrrpHold_N = {
				"rt_swampWest_lout_N",
				"rt_swampWest_lout_N",
			},
			in_lrrpHold_S = {
				"rt_swampWest_lin_S",
				"rt_swampWest_lin_S",
			},
			out_lrrpHold_S = {
				"rt_swampWest_lout_S",
				"rt_swampWest_lout_S",
			},
		},
		outofrain = {
			"rt_swampWest_r_0000",
			"rt_swampWest_r_0001",
			"rt_swampWest_r_0002",
			"rt_swampWest_r_0003",
			"rt_swampWest_r_0004",
			"rt_swampWest_r_0005",
			"rt_swampWest_r_0006",
			"rt_swampWest_r_0007",
		},
		nil
	},

	
	mafr_pfCampNorth_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_pfCampNorth_d_0000_sub",
				"rt_pfCampNorth_d_0001",
			},
			groupB = {
				"rt_pfCampNorth_d_0002",
				"rt_pfCampNorth_d_0003",
			},
			groupC = {
				"rt_pfCampNorth_d_0004",
				"rt_pfCampNorth_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_pfCampNorth_n_0000",
				"rt_pfCampNorth_n_0001",
			},
			groupB = {
				"rt_pfCampNorth_n_0002",
				"rt_pfCampNorth_n_0002",
			},
			groupC = {
				"rt_pfCampNorth_n_0003",
				"rt_pfCampNorth_n_0004",
			},
		},
		caution = {
			groupA = {
				"rt_pfCampNorth_c_0000",
				"rt_pfCampNorth_c_0000",
				"rt_pfCampNorth_c_0001",
				"rt_pfCampNorth_c_0001",
				"rt_pfCampNorth_c_0002",
				"rt_pfCampNorth_c_0002",
				"rt_pfCampNorth_c_0003",
				"rt_pfCampNorth_c_0003",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_pfCampNorth_s_0000",
				"rt_pfCampNorth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_pfCampNorth_l_0000",
				"rt_pfCampNorth_l_0001",
			},
			in_lrrpHold_E = {
				"rt_pfCampNorth_lin_E",
				"rt_pfCampNorth_lin_E",
			},
			out_lrrpHold_W = {
				"rt_pfCampNorth_lout_W",
				"rt_pfCampNorth_lout_W",
			},
		},
		outofrain = {
			"rt_pfCampNorth_r_0000",
			"rt_pfCampNorth_r_0001",
			"rt_pfCampNorth_r_0002",
			"rt_pfCampNorth_r_0003",
			"rt_pfCampNorth_r_0004",
			"rt_pfCampNorth_r_0005",
		},
		nil
	},

	
	mafr_pfCampEast_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_pfCampEast_d_0000_sub",
				"rt_pfCampEast_d_0001",
			},
			groupB = {
				"rt_pfCampEast_d_0002_sub",
				"rt_pfCampEast_d_0003",
			},
			groupC = {
				"rt_pfCampEast_d_0004",
				"rt_pfCampEast_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_pfCampEast_n_0000",
				"rt_pfCampEast_n_0001",
			},
			groupB = {
				"rt_pfCampEast_n_0002_sub",
				"rt_pfCampEast_n_0003",
			},
			groupC = {
				"rt_pfCampEast_n_0004",
				"rt_pfCampEast_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_pfCampEast_c_0000",
				"rt_pfCampEast_c_0000",
				"rt_pfCampEast_c_0002",
				"rt_pfCampEast_c_0002",
				"rt_pfCampEast_c_0001",
				"rt_pfCampEast_c_0003",
				"rt_pfCampEast_c_0001",
				"rt_pfCampEast_c_0003",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_pfCampEast_s_0000",
				"rt_pfCampEast_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_pfCampEast_l_0000",
				"rt_pfCampEast_l_0001",
			},
			in_lrrpHold_E = {
				"rt_pfCampEast_lin_E",
				"rt_pfCampEast_lin_E",
			},
			out_lrrpHold_B01 = {
				"rt_pfCampEast_lout_B01",
				"rt_pfCampEast_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_pfCampEast_lout_B02",
				"rt_pfCampEast_lout_B02",
			},
		},
		outofrain = {
			"rt_pfCampEast_r_0000",
			"rt_pfCampEast_r_0001",
			"rt_pfCampEast_r_0002",
			"rt_pfCampEast_r_0003",
			"rt_pfCampEast_r_0004",
			"rt_pfCampEast_r_0005",
		},
		nil
	},

	
	mafr_savannahEast_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_savannahEast_d_0000_sub",
				"rt_savannahEast_d_0002",
			},
			groupB = {
				"rt_savannahEast_d_0001_sub",
				"rt_savannahEast_d_0003",
			},
			groupC = {
				"rt_savannahEast_d_0004",
				"rt_savannahEast_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_savannahEast_n_0000_sub",
				"rt_savannahEast_n_0002",
			},
			groupB = {
				"rt_savannahEast_n_0001_sub",
				"rt_savannahEast_n_0003",
			},
			groupC = {
				"rt_savannahEast_n_0004",
				"rt_savannahEast_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_savannahEast_c_0000_sub",
				"rt_savannahEast_c_0001_sub",
				"rt_savannahEast_c_0002",
				"rt_savannahEast_c_0003",
				"rt_savannahEast_c_0003",
				"rt_savannahEast_c_0004",
				"rt_savannahEast_c_0005",
				"rt_savannahEast_c_0006",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_savannahEast_s_0000",
				"rt_savannahEast_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_savannahEast_l_0000",
				"rt_savannahEast_l_0001",
			},
			in_lrrpHold_N = {
				"rt_savannahEast_lin_N",
				"rt_savannahEast_lin_N",
			},
			out_lrrpHold_W = {
				"rt_savannahEast_lout_W",
				"rt_savannahEast_lout_W",
			},
		},
		outofrain = {
			"rt_savannahEast_r_0000",
			"rt_savannahEast_r_0001",
			"rt_savannahEast_r_0002",
			"rt_savannahEast_r_0003",
			"rt_savannahEast_r_0004",
			"rt_savannahEast_r_0005",
		},
		nil
	},

	
	mafr_savannahWest_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
	
		},
		sneak_day = {
			groupA = {
				"rt_savannahWest_d_0000_sub",
				"rt_savannahWest_d_0003",
			},
			groupB = {
				"rt_savannahWest_d_0001",
				"rt_savannahWest_d_0004",
			},
			groupC = {
				"rt_savannahWest_d_0002",
				"rt_savannahWest_d_0005",
			},
	





		},
		sneak_night= {
			groupA = {
				"rt_savannahWest_n_0000_sub",
				"rt_savannahWest_n_0003",
			},
			groupB = {
				"rt_savannahWest_n_0001",
				"rt_savannahWest_n_0004",
			},
			groupC = {
				"rt_savannahWest_n_0002",
				"rt_savannahWest_n_0005",
			},
		





		},
		caution = {
			groupA = {
				"rt_savannahWest_c_0000",
				"rt_savannahWest_c_0001",	
				"rt_savannahWest_c_0001",	
				"rt_savannahWest_c_0002",
				"rt_savannahWest_c_0003",
				"rt_savannahWest_c_0004",
				"rt_savannahWest_c_0005",
				"rt_savannahWest_c_0006",
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
				"rt_savannahWest_s_0000",
				"rt_savannahWest_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_savannahWest_l_0000",
				"rt_savannahWest_l_0001",
			},
		},
		outofrain = {
			"rt_savannahWest_r_0000",
			"rt_savannahWest_r_0001",
			"rt_savannahWest_r_0002",
			"rt_savannahWest_r_0003",
			"rt_savannahWest_r_0004",
			"rt_savannahWest_r_0005",
			"rt_savannahWest_r_0006",
			"rt_savannahWest_r_0007",
		},
		nil
	},

	
	mafr_chicoVilWest_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_chicoVilWest_d_0000_sub",
				"rt_chicoVilWest_d_0003",
			},
			groupB = {
				"rt_chicoVilWest_d_0001",
				"rt_chicoVilWest_d_0004",
			},
			groupC = {
				"rt_chicoVilWest_d_0002",
				"rt_chicoVilWest_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_chicoVilWest_n_0000",
				"rt_chicoVilWest_n_0003",
			},
			groupB = {
				"rt_chicoVilWest_n_0001",
				"rt_chicoVilWest_n_0004",
			},
			groupC = {
				"rt_chicoVilWest_n_0002",
				"rt_chicoVilWest_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_chicoVilWest_c_0000",	
				"rt_chicoVilWest_c_0000",	
				"rt_chicoVilWest_c_0001",
				"rt_chicoVilWest_c_0002",
				"rt_chicoVilWest_c_0003",
				"rt_chicoVilWest_c_0004",
				"rt_chicoVilWest_c_0005",
				"rt_chicoVilWest_c_0006",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_chicoVilWest_s_0000",
				"rt_chicoVilWest_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_chicoVilWest_l_0000",
				"rt_chicoVilWest_l_0001",
			},
		},
		outofrain = {
			"rt_chicoVilWest_r_0000",
			"rt_chicoVilWest_r_0001",
			"rt_chicoVilWest_r_0002",
			"rt_chicoVilWest_r_0003",
			"rt_chicoVilWest_r_0004",
			"rt_chicoVilWest_r_0005",
			"rt_chicoVilWest_r_0006",
			"rt_chicoVilWest_r_0007",
		},
		nil
	},

	
	mafr_hillSouth_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_hillSouth_d_0000",
				"rt_hillSouth_d_0001",
			},
			groupB = {
				"rt_hillSouth_d_0002",
				"rt_hillSouth_d_0003",
			},
			groupC = {
				"rt_hillSouth_d_0004_sub",
				"rt_hillSouth_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_hillSouth_n_0000",
				"rt_hillSouth_n_0001",
			},
			groupB = {
				"rt_hillSouth_n_0002",
				"rt_hillSouth_n_0003",
			},
			groupC = {
				"rt_hillSouth_n_0004",
				"rt_hillSouth_n_0004",
			},
		},
		caution = {
			groupA = {
				"rt_hillSouth_c_0000",
				"rt_hillSouth_c_0001",
				"rt_hillSouth_c_0001",
				"rt_hillSouth_c_0003",
				"rt_hillSouth_c_0002",
				"rt_hillSouth_c_0002",
				"rt_hillSouth_c_0004",
				"rt_hillSouth_c_0004",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_hillSouth_s_0000",
				"rt_hillSouth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_hillSouth_l_0000",
				"rt_hillSouth_l_0001",
			},
		},
		outofrain = {
			"rt_hillSouth_r_0000",
			"rt_hillSouth_r_0001",
			"rt_hillSouth_r_0002",
			"rt_hillSouth_r_0003",
			"rt_hillSouth_r_0004",
			"rt_hillSouth_r_0005",
		},
		nil
	},

	
	
	
	
	
	
	
	mafr_banana_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_banana_d_0000",
				"rt_banana_d_0003",
				"rt_banana_d_0005",	
				"rt_banana_d_0008",
			},
			groupB = {
				"rt_banana_d_0001",
				"rt_banana_d_0004_sub",
				"rt_banana_d_0006",
				"rt_banana_d_0009",
			},
			groupC = {
				"rt_banana_d_0002",
				"rt_banana_d_0005",	
				"rt_banana_d_0007",
				"rt_banana_d_0010",
			},
		},
		sneak_night= {
			groupA = {
				"rt_banana_n_0000_sub",
				"rt_banana_n_0003",
				"rt_banana_n_0006",
				"rt_banana_n_0009",
			},
			groupB = {
				"rt_banana_n_0001",
				"rt_banana_n_0004_sub",
				"rt_banana_n_0007_sub",
				"rt_banana_n_0010",
			},
			groupC = {
				"rt_banana_n_0002",
				"rt_banana_n_0005_sub",
				"rt_banana_n_0008",
				"rt_banana_n_0011",
			},
		},
		caution = {
			groupA = {
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
				"rt_banana_c_0011",
				"rt_banana_c_0012",		
				"rt_banana_c_0012",		
			},
			groupB = {
				
			},
			groupC = {
				
			},
		},
		hold = {
			default = {
				"rt_banana_h_0000",
				"rt_banana_h_0001",
				"rt_banana_h_0002",
				"rt_banana_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_banana_s_0000",
				"rt_banana_s_0001",
				"rt_banana_s_0002",
				"rt_banana_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_banana_l_0000",
				"rt_banana_l_0001",
			},
			in_lrrpHold_N = {
				"rt_banana_lin_N",
				"rt_banana_lin_N",
			},
			out_lrrpHold_B01 = {
				"rt_banana_lout_B01",
				"rt_banana_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_banana_lout_B02",
				"rt_banana_lout_B02",
			},
		},
		outofrain = {
			"rt_banana_r_0000",
			"rt_banana_r_0001",
			"rt_banana_r_0002",
			"rt_banana_r_0003",
			"rt_banana_r_0004",
			"rt_banana_r_0005",
			"rt_banana_r_0006",
			"rt_banana_r_0007",
			"rt_banana_r_0008",
			"rt_banana_r_0009",
			"rt_banana_r_0010",
			"rt_banana_r_0011",
			"rt_banana_r_0012",
			"rt_banana_r_0013",
			"rt_banana_r_0014",
			"rt_banana_r_0015",
			"rt_banana_r_0016",
			"rt_banana_r_0017",
			"rt_banana_r_0018",
			"rt_banana_r_0019",
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
			lrrpHold = {
				"rt_diamond_l_0000",
				"rt_diamond_l_0001",
			},
			in_lrrpHold_S = {
				"rt_diamond_lin_S",
				"rt_diamond_lin_S",
			},
			out_lrrpHold_B01 = {
				"rt_diamond_lout_B01",
				"rt_diamond_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_diamond_lout_B02",
				"rt_diamond_lout_B02",
			},
			out_lrrpHold_B03 = {
				"rt_diamond_lout_B03",
				"rt_diamond_lout_B03",
			},
		},
		outofrain = {
			"rt_diamond_r_0000",
			"rt_diamond_r_0001",
			"rt_diamond_r_0002",
			"rt_diamond_r_0003",
			"rt_diamond_r_0004",
			"rt_diamond_r_0005",
			"rt_diamond_r_0006",
			"rt_diamond_r_0007",
			"rt_diamond_r_0008",
			"rt_diamond_r_0009",
			"rt_diamond_r_0010",
			"rt_diamond_r_0011",
			"rt_diamond_r_0012",
			"rt_diamond_r_0013",
			"rt_diamond_r_0014",
			"rt_diamond_r_0015",
			"rt_diamond_r_0016",
			"rt_diamond_r_0017",
			"rt_diamondSwamp_r_0000",
			"rt_diamondSwamp_r_0001",
		},
		nil
	},
	
	mafr_hill_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		sneak_day = {
			groupA = {
				"rt_hill_d_0002",
				"rt_hill_d_0010",
				"rt_hill_d_0000",
			},
			groupB = {
				"rt_hill_d_0009",
				"rt_hill_d_0003",
				"rt_hill_d_0008",
			},
			groupC = {
				"rt_hill_d_0006",
				"rt_hill_d_0007",
				"rt_hill_d_0011",
			},
			groupD = {
				"rt_hill_d_0004",
				"rt_hill_d_0001",
				"rt_hill_d_0005",
			},
		},
		sneak_night= {
			groupA = {
				"rt_hill_n_0002",
				"rt_hill_n_0011",
				"rt_hill_n_0000_sub",
			},
			groupB = {
				"rt_hill_n_0009",
				"rt_hill_n_0004",
				"rt_hill_n_0006",
			},
			groupC = {
				"rt_hill_n_0008",
				"rt_hill_n_0007",
				"rt_hill_n_0010",
			},
			groupD = {
				"rt_hill_n_0003",
				"rt_hill_n_0001_sub",
				"rt_hill_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_hill_c_0000",
				"rt_hill_c_0001",
				"rt_hill_c_0002",
				"rt_hill_c_0003",
				"rt_hill_c_0004",
				"rt_hill_c_0005",
				"rt_hill_c_0006",
				"rt_hill_c_0007",
				"rt_hill_c_0008",
				"rt_hill_c_0009",
				"rt_hill_c_0010",
				"rt_hill_c_0011",
				"rt_hill_c_0004",
				"rt_hill_c_0011",
			},
			groupB = {},
			groupC = {},
			groupD = {},
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
			lrrpHold = {
				"rt_hill_l_0000",
				"rt_hill_l_0001",
			},
			in_lrrpHold_S = {
				"rt_hill_lin_S",
				"rt_hill_lin_S",
			},
			out_lrrpHold_B01 = {
				"rt_hill_lout_B01",
				"rt_hill_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_hill_lout_B02",
				"rt_hill_lout_B02",
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
			groupB = {},
			groupC = {},
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
			lrrpHold = {
				"rt_factorySouth_l_0000",
				"rt_factorySouth_l_0001",
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
		nil
	},

	
	mafr_hillNorth_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		sneak_day = {
			groupA = {
				"rt_hillNorth_d_0000_sub",
				"rt_hillNorth_d_0001_sub",
			},
			groupB = {
				"rt_hillNorth_d_0002",
				"rt_hillNorth_d_0003",
			},
			groupC = {
				"rt_hillNorth_d_0004",
				"rt_hillNorth_d_0005",
			},
			groupD = {
				"rt_hillNorth_d_0006",
				"rt_hillNorth_d_0007",
			},
		},
		sneak_night = {
			groupA = {
				"rt_hillNorth_n_0000_sub",
				"rt_hillNorth_n_0001_sub",
			},
			groupB = {
				"rt_hillNorth_n_0002",
				"rt_hillNorth_n_0003",
			},
			groupC = {
				"rt_hillNorth_n_0004",
				"rt_hillNorth_n_0005",
			},
			groupD = {
				"rt_hillNorth_n_0006",
				"rt_hillNorth_n_0007",
			},
		},
		caution = {
			groupA = {
				"rt_hillNorth_c_0002",
				"rt_hillNorth_c_0003",
				"rt_hillNorth_c_0003",
				"rt_hillNorth_c_0004",
				"rt_hillNorth_c_0004",
				"rt_hillNorth_c_0005",
				"rt_hillNorth_c_0006",
				"rt_hillNorth_c_0007",
				"rt_hillNorth_c_0000",
				"rt_hillNorth_c_0001",
			},
			groupB = {},
			groupC = {},
			groupD = {},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_hillNorth_s_0000",
				"rt_hillNorth_s_0001",

			},
		},
		travel = {
			lrrpHold = {
				"rt_hillNorth_l_0000",
				"rt_hillNorth_l_0001",
			},
			in_lrrpHold_N = {
				"rt_hillNorth_lin_N",
				"rt_hillNorth_lin_N",
			},
			out_lrrpHold_N = {
				"rt_hillNorth_lout_N",
				"rt_hillNorth_lout_N",
			},
			in_lrrpHold_S = {
				"rt_hillNorth_lin_S",
				"rt_hillNorth_lin_S",
			},
			out_lrrpHold_S = {
				"rt_hillNorth_lout_S",
				"rt_hillNorth_lout_S",
			},
		},
		outofrain = {
			"rt_hillNorth_r_0000",
			"rt_hillNorth_r_0001",
			"rt_hillNorth_r_0002",
			"rt_hillNorth_r_0003",
			"rt_hillNorth_r_0004",
			"rt_hillNorth_r_0005",
			"rt_hillNorth_r_0006",
		},
		nil
	},
	
	mafr_hillWest_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_hillWest_d_0000",
				"rt_hillWest_d_0001_sub",
			},
			groupB = {
				"rt_hillWest_d_0002",
				"rt_hillWest_d_0003_sub",
			},
			groupC = {
				"rt_hillWest_d_0004",
				"rt_hillWest_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_hillWest_n_0003",
				"rt_hillWest_n_0001_sub",
			},
			groupB = {
				"rt_hillWest_n_0002",
				"rt_hillWest_n_0000_sub",
			},
			groupC = {
				"rt_hillWest_n_0004",
				"rt_hillWest_n_0003",
			},
		},
		caution = {
			groupA = {
				"rt_hillWest_c_0000",
				"rt_hillWest_c_0001_sub",
				"rt_hillWest_c_0002",
				"rt_hillWest_c_0003_sub",
				"rt_hillWest_c_0004",
				"rt_hillWest_c_0005",
				"rt_hillWest_c_0000",
				"rt_hillWest_c_0005",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_hillWest_s_0000",
				"rt_hillWest_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_hillWest_l_0000",
				"rt_hillWest_l_0001",
			},
			in_lrrpHold_N = {
				"rt_hillWest_lin_N",
				"rt_hillWest_lin_N",
			},
			out_lrrpHold_N = {
				"rt_hillWest_lout_N",
				"rt_hillWest_lout_N",
			},
			in_lrrpHold_S = {
				"rt_hillWest_lin_S",
				"rt_hillWest_lin_S",
			},
			out_lrrpHold_S = {
				"rt_hillWest_lout_S",
				"rt_hillWest_lout_S",
			},
		},
		outofrain = {
			"rt_hillWest_r_0000",
			"rt_hillWest_r_0001",
			"rt_hillWest_r_0002",
			"rt_hillWest_r_0003",
			"rt_hillWest_r_0004",
			"rt_hillWest_r_0005",
		},
		nil
	},

	
	mafr_hillWestNear_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_hillWestNear_d_0000",
				"rt_hillWestNear_d_0003",
			},
			groupB = {
				"rt_hillWestNear_d_0001",
				"rt_hillWestNear_d_0004",
			},
			groupC = {
				"rt_hillWestNear_d_0002",
				"rt_hillWestNear_d_0005",
			},
		},
		sneak_night= {
			groupA = {
				"rt_hillWestNear_n_0000",
				"rt_hillWestNear_n_0001",
			},
			groupB = {
				"rt_hillWestNear_n_0002",
				"rt_hillWestNear_n_0002",
			},
			groupC = {
				"rt_hillWestNear_n_0003",
				"rt_hillWestNear_n_0003",
			},
		},
		caution = {
			groupA = {
				"rt_hillWestNear_c_0002",
				"rt_hillWestNear_c_0003",
				"rt_hillWestNear_c_0000",
				"rt_hillWestNear_c_0001",
				"rt_hillWestNear_c_0004",
				"rt_hillWestNear_c_0004",
				"rt_hillWestNear_c_0005",
				"rt_hillWestNear_c_0005",
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
				"rt_hillWestNear_s_0000",
				"rt_hillWestNear_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_hillWestNear_l_0000",
				"rt_hillWestNear_l_0001",
			},
		},
		outofrain = {
			"rt_hillWestNear_r_0000",
			"rt_hillWestNear_r_0001",
			"rt_hillWestNear_r_0002",
			"rt_hillWestNear_r_0003",
			"rt_hillWestNear_r_0004",
			"rt_hillWestNear_r_0005",
		},
		nil
	},

	
	mafr_diamondSouth_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_diamondSouth_d_0000",
				"rt_diamondSouth_d_0001_sub",
			},
			groupB = {
				"rt_diamondSouth_d_0002",
				"rt_diamondSouth_d_0003_sub",
			},
			groupC = {
				"rt_diamondSouth_d_0004",
				"rt_diamondSouth_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_diamondSouth_n_0000",
				"rt_diamondSouth_n_0001_sub",
			},
			groupB = {
				"rt_diamondSouth_n_0002",
				"rt_diamondSouth_n_0003_sub",
			},
			groupC = {
				"rt_diamondSouth_n_0004",
				"rt_diamondSouth_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_diamondSouth_c_0000",
				"rt_diamondSouth_c_0001",
				"rt_diamondSouth_c_0002",
				"rt_diamondSouth_c_0003",
				"rt_diamondSouth_c_0004",
				"rt_diamondSouth_c_0005",
				"rt_diamondSouth_c_0006",
				"rt_diamondSouth_c_0006",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_diamondSouth_s_0000",
				"rt_diamondSouth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_diamondSouth_l_0000",
				"rt_diamondSouth_l_0001",
			},
			in_lrrpHold_W = {
				"rt_diamondSouth_lin_W",
				"rt_diamondSouth_lin_W",
			},
			out_lrrpHold_B01 = {
				"rt_diamondSouth_lout_B01",
				"rt_diamondSouth_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_diamondSouth_lout_B02",
				"rt_diamondSouth_lout_B02",
			},
		},
		
		outofrain = {
			"rt_diamondSouth_r_0000",
			"rt_diamondSouth_r_0001",
			"rt_diamondSouth_r_0002",
			"rt_diamondSouth_r_0003",
			"rt_diamondSouth_r_0004",
			"rt_diamondSouth_r_0005",
		},
		nil
	},

	
	mafr_diamondNorth_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",

		},
		sneak_day = {
			groupA = {
				"rt_diamondNorth_d_0000_sub",
				"rt_diamondNorth_d_0003",
			},
			groupB = {
				"rt_diamondNorth_d_0001",
				"rt_diamondNorth_d_0004",
			},
			groupC = {
				"rt_diamondNorth_d_0002",
				"rt_diamondNorth_d_0005",
			},
		





		},
		sneak_night= {
			groupA = {
				"rt_diamondNorth_n_0000_sub",
				"rt_diamondNorth_n_0003",
			},
			groupB = {
				"rt_diamondNorth_n_0001",
				"rt_diamondNorth_n_0004",
			},
			groupC = {
				"rt_diamondNorth_n_0002",
				"rt_diamondNorth_n_0005",
			},
		





		},
		caution = {
			groupA = {
				"rt_diamondNorth_c_0000",
				"rt_diamondNorth_c_0001",	
				"rt_diamondNorth_c_0001",	
				"rt_diamondNorth_c_0002",
				"rt_diamondNorth_c_0003",
				"rt_diamondNorth_c_0004",
				"rt_diamondNorth_c_0005",
				"rt_diamondNorth_c_0006",
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
				"rt_diamondNorth_s_0000",
				"rt_diamondNorth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_diamondNorth_l_0000",
				"rt_diamondNorth_l_0001",
			},
			
			in_lrrpHold_E = {
				"rt_diamondNorth_lin_E",
				"rt_diamondNorth_lin_E",
			},
			in_lrrpHold_W = {
				"rt_diamondNorth_lin_W",
				"rt_diamondNorth_lin_W",
			},
			
			out_lrrpHold_E = {
				"rt_diamondNorth_lout_E",
				"rt_diamondNorth_lout_E",
			},
			out_lrrpHold_W = {
				"rt_diamondNorth_lout_W",
				"rt_diamondNorth_lout_W",
			},
		},
		outofrain = {
			"rt_diamondNorth_r_0000",
			"rt_diamondNorth_r_0001",
			"rt_diamondNorth_r_0002",
			"rt_diamondNorth_r_0003",
			"rt_diamondNorth_r_0004",
			"rt_diamondNorth_r_0005",
		},
		nil
	},

	
	mafr_diamondWest_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_diamondWest_d_0000",
				"rt_diamondWest_d_0001",
			},
			groupB = {
				"rt_diamondWest_d_0002",
				"rt_diamondWest_d_0003",
			},
			groupC = {
				"rt_diamondWest_d_0004",
				"rt_diamondWest_d_0005_sub",
			},
		},
		sneak_night = {
			groupA = {
				"rt_diamondWest_n_0000",
				"rt_diamondWest_n_0001",
			},
			groupB = {
				"rt_diamondWest_n_0002",
				"rt_diamondWest_n_0003_sub",
			},
			groupC = {
				"rt_diamondWest_n_0004",
				"rt_diamondWest_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_diamondWest_c_0000",
				"rt_diamondWest_c_0001",
				"rt_diamondWest_c_0002",
				"rt_diamondWest_c_0003",
				"rt_diamondWest_c_0004",
				"rt_diamondWest_c_0005",
				"rt_diamondWest_c_0006",
				"rt_diamondWest_c_0003",
			},
			groupB = {},
			groupC = {},
		},
		sleep = {
			default = {
				"rt_diamondWest_s_0000",
				"rt_diamondWest_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_diamondWest_l_0000",
				"rt_diamondWest_l_0001",
			},
			in_lrrpHold_N = {
				"rt_diamondWest_lin_N",
				"rt_diamondWest_lin_N",
			},
			out_lrrpHold_N = {
				"rt_diamondWest_lout_N",
				"rt_diamondWest_lout_N",
			},
			in_lrrpHold_S = {
				"rt_diamondWest_lin_S",
				"rt_diamondWest_lin_S",
			},
			out_lrrpHold_S = {
				"rt_diamondWest_lout_S",
				"rt_diamondWest_lout_S",
			},
		},
		
		outofrain = {
			"rt_diamondWest_r_0000",
			"rt_diamondWest_r_0001",
			"rt_diamondWest_r_0002",
			"rt_diamondWest_r_0003",
			"rt_diamondWest_r_0004",
			"rt_diamondWest_r_0005",
		},
		nil
	},

	
	mafr_bananaEast_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_bananaEast_d_0000",
				"rt_bananaEast_d_0003",
			},
			groupB = {
				"rt_bananaEast_d_0001",
				"rt_bananaEast_d_0004",
			},
			groupC = {
				"rt_bananaEast_d_0002",
				"rt_bananaEast_d_0005",
			},
		},
		sneak_night= {
			groupA = {
				"rt_bananaEast_n_0000",
				"rt_bananaEast_n_0003",
			},
			groupB = {
				"rt_bananaEast_n_0001",
				"rt_bananaEast_n_0004",
			},
			groupC = {
				"rt_bananaEast_n_0002",
				"rt_bananaEast_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_bananaEast_c_0000",	
				"rt_bananaEast_c_0000",	
				"rt_bananaEast_c_0004",
				"rt_bananaEast_c_0001",
				"rt_bananaEast_c_0002",
				"rt_bananaEast_c_0003",
				"rt_bananaEast_c_0005",
				"rt_bananaEast_c_0006",
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
				"rt_bananaEast_s_0000",
				"rt_bananaEast_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_bananaEast_l_0000",
				"rt_bananaEast_l_0001",
			},
			in_lrrpHold_N = {
				"rt_bananaEast_lin_N",
				"rt_bananaEast_lin_N",
			},
			out_lrrpHold_N = {
				"rt_bananaEast_lout_N",
				"rt_bananaEast_lout_N",
			},
			in_lrrpHold_S = {
				"rt_bananaEast_lin_S",
				"rt_bananaEast_lin_S",
			},
			out_lrrpHold_S = {
				"rt_bananaEast_lout_S",
				"rt_bananaEast_lout_S",
			},
		},
		outofrain = {
			"rt_bananaEast_r_0000",
			"rt_bananaEast_r_0001",
			"rt_bananaEast_r_0002",
			"rt_bananaEast_r_0003",
			"rt_bananaEast_r_0004",
			"rt_bananaEast_r_0005",
		},
		nil
	},

	
	mafr_savannahNorth_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
	
		},
		sneak_day = {
			groupA = {
				"rt_savannahNorth_d_0000_sub",
				"rt_savannahNorth_d_0003",
			},
			groupB = {
				"rt_savannahNorth_d_0001",
				"rt_savannahNorth_d_0004",
			},
			groupC = {
				"rt_savannahNorth_d_0002",
				"rt_savannahNorth_d_0005",
			},






		},
		sneak_night= {
			groupA = {
				"rt_savannahNorth_n_0000_sub",
				"rt_savannahNorth_n_0003",
			},
			groupB = {
				"rt_savannahNorth_n_0001",
				"rt_savannahNorth_n_0004",
			},
			groupC = {
				"rt_savannahNorth_n_0002",
				"rt_savannahNorth_n_0005",
			},






		},
		caution = {
			groupA = {
				"rt_savannahNorth_c_0000",
				"rt_savannahNorth_c_0001",	
				"rt_savannahNorth_c_0001",	
				"rt_savannahNorth_c_0002",
				"rt_savannahNorth_c_0003",
				"rt_savannahNorth_c_0004",
				"rt_savannahNorth_c_0005",
				"rt_savannahNorth_c_0006",
		
		
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
				"rt_savannahNorth_s_0000",
				"rt_savannahNorth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_savannahNorth_l_0000",
				"rt_savannahNorth_l_0001",
			},
		},
		outofrain = {
			"rt_savannahNorth_r_0000",
			"rt_savannahNorth_r_0001",
			"rt_savannahNorth_r_0002",
			"rt_savannahNorth_r_0003",
			"rt_savannahNorth_r_0004",
			"rt_savannahNorth_r_0005",
			"rt_savannahNorth_r_0006",
			"rt_savannahNorth_r_0007",
		},
		nil
	},

	
	mafr_bananaSouth_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
	
		},
		sneak_day = {
			groupA = {
				"rt_bananaSouth_d_0000_sub",
				"rt_bananaSouth_d_0003",
			},
			groupB = {
				"rt_bananaSouth_d_0001",
				"rt_bananaSouth_d_0004",
			},
			groupC = {
				"rt_bananaSouth_d_0002",
				"rt_bananaSouth_d_0005",	
			},
	





		},
		sneak_night= {
			groupA = {
				"rt_bananaSouth_n_0000_sub",
				"rt_bananaSouth_n_0003",
			},
			groupB = {
				"rt_bananaSouth_n_0001",
				"rt_bananaSouth_n_0004",
			},
			groupC = {
				"rt_bananaSouth_n_0002",
				"rt_bananaSouth_n_0005",
			},
	





		},
		caution = {
			groupA = {
				"rt_bananaSouth_c_0000",
				"rt_bananaSouth_c_0002",
				"rt_bananaSouth_c_0001",	
				"rt_bananaSouth_c_0001",	
				"rt_bananaSouth_c_0003",
				"rt_bananaSouth_c_0004",
				"rt_bananaSouth_c_0005",
				"rt_bananaSouth_c_0006",
				"rt_bananaSouth_c_0007",
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
				"rt_bananaSouth_s_0000",
				"rt_bananaSouth_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_bananaSouth_l_0000",
				"rt_bananaSouth_l_0001",
			},
		},
		outofrain = {
			"rt_bananaSouth_r_0000",
			"rt_bananaSouth_r_0001",
			"rt_bananaSouth_r_0002",
			"rt_bananaSouth_r_0003",
			"rt_bananaSouth_r_0004",
			"rt_bananaSouth_r_0005",
			"rt_bananaSouth_r_0006",
			"rt_bananaSouth_r_0007",
		},
		nil
	},
	
	
	

	
	
	
	
	mafr_factory_cp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				nil,
			},
		},
		sneak_night = {
			groupA = {
				nil,
			},
		},
		caution = {
			groupA = {
				nil,
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

	
	
	

	
	mafr_factoryWest_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		sneak_day = {
			groupA = {
				"rt_factoryWest_d_0000",
				"rt_factoryWest_d_0001",
			},
			groupB = {
				"rt_factoryWest_d_0002",
				"rt_factoryWest_d_0007",
			},
			groupC = {
				"rt_factoryWest_d_0004",
				"rt_factoryWest_d_0005",
			},
			groupD = {
				"rt_factoryWest_d_0003",
				"rt_factoryWest_d_0006",
			},
		},
		sneak_night= {
			groupA = {
				"rt_factoryWest_n_0000",
				"rt_factoryWest_n_0001",
			},
			groupB = {
				"rt_factoryWest_n_0002",
				"rt_factoryWest_n_0003",
			},
			groupC = {
				"rt_factoryWest_n_0004",
				"rt_factoryWest_n_0005",
			},
			groupD = {
				"rt_factoryWest_n_0006",
				"rt_factoryWest_n_0007",
			},
		},
		caution = {
			groupA = {
				"rt_factoryWest_c_0000",
				"rt_factoryWest_c_0001",
				"rt_factoryWest_c_0002",
				"rt_factoryWest_c_0003",
				"rt_factoryWest_c_0004",
				"rt_factoryWest_c_0005",
				"rt_factoryWest_c_0006",
				"rt_factoryWest_c_0007",
			},
			groupB = {},
			groupC = {},
			groupD = {},
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
			lrrpHold = {
				"rt_factoryWest_l_0000",
				"rt_factoryWest_l_0001",
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
	
	
	

	
	
	
	
	mafr_lab_cp = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
			"groupE",
		},
		sneak_day = {
			groupA = {
				"rt_lab_d_0000",
				"rt_lab_d_0005",
				"rt_lab_d_0002",
				"rt_lab_d_0012",
			},
			groupB = {
				"rt_lab_d_0001",
				"rt_lab_d_0007",
				"rt_lab_d_0008",
				"rt_lab_d_0006",
			},
			groupC = {
				"rt_lab_d_0002",
				"rt_lab_d_0006",
				"rt_lab_d_0007",
				"rt_lab_d_0004",
			},
			groupD = {
				"rt_lab_d_0003",
				"rt_lab_d_0009",
				"rt_lab_d_0006",
				"rt_lab_d_0007",
			},
			groupE = {
				"rt_lab_d_0004",
				"rt_lab_d_0008",
				"rt_lab_d_0002",
				"rt_lab_d_0008",
			},
		},
		sneak_night= {
			groupA = {
				"rt_lab_n_0000",
				"rt_lab_n_0007",
				"rt_lab_n_0002",
				"rt_lab_n_0012",
			},
			groupB = {
				"rt_lab_n_0001",
				"rt_lab_n_0009",
				"rt_lab_n_0006",
				"rt_lab_n_0013",
			},
			groupC = {
				"rt_lab_n_0002",
				"rt_lab_n_0008",
				"rt_lab_n_0007",
				"rt_lab_n_0002",
			},
			groupD = {
				"rt_lab_n_0004",
				"rt_lab_n_0003",
				"rt_lab_n_0010",
				"rt_lab_n_0006",
			},
			groupE = {
				"rt_lab_n_0006",
				"rt_lab_n_0005",
				"rt_lab_n_0011",
				"rt_lab_n_0007",
			},
		},
		caution = {
			groupA = {
				"rt_lab_c_0000",
				"rt_lab_c_0001",
				"rt_lab_c_0002",
				"rt_lab_c_0004",
				"rt_lab_c_0005",
				"rt_lab_c_0008",
				"rt_lab_c_0009",
				"rt_lab_c_0000",
				"rt_lab_c_0001",
				"rt_lab_c_0003",
				"rt_lab_c_0004",
				"rt_lab_c_0005",
				"rt_lab_c_0008",
				"rt_lab_c_0007",
				"rt_lab_c_0000",
				"rt_lab_c_0001",
				"rt_lab_c_0004",
				"rt_lab_c_0005",
				"rt_lab_c_0008",
				"rt_lab_c_0006",
				"rt_lab_c_0001",
				"rt_lab_c_0008",
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
				"rt_lab_h_0000",
				"rt_lab_h_0001",
				"rt_lab_h_0002",
				"rt_lab_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_lab_s_0000",
				"rt_lab_s_0001",
				"rt_lab_s_0002",
				"rt_lab_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_lab_l_0000",
				"rt_lab_l_0001",
			},
			
			in_lrrpHold_W = {
				"rt_lab_lin_W",
				"rt_lab_lin_W",
			},
			
			out_lrrpHold_W = {
				"rt_lab_lout_W",
				"rt_lab_lout_W",
			},
		},
		outofrain = {
			"rt_lab_r_0000",
			"rt_lab_r_0001",
			"rt_lab_r_0002",
			"rt_lab_r_0003",
			"rt_lab_r_0004",
			"rt_lab_r_0005",
			"rt_lab_r_0006",
			"rt_lab_r_0007",
			"rt_lab_r_0008",
			"rt_lab_r_0009",
			"rt_lab_r_0010",
			"rt_lab_r_0011",
			"rt_lab_r_0012",
			"rt_lab_r_0013",
			"rt_lab_r_0014",
			"rt_lab_r_0015",
			"rt_lab_r_0016",
			"rt_lab_r_0017",
			"rt_lab_r_0018",
		},
		nil
	},

	
	
	
	
	mafr_labWest_ob = {
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_labWest_d_0000",
				"rt_labWest_d_0003",
			},
			groupB = {
				"rt_labWest_d_0001",
				"rt_labWest_d_0004",
			},
			groupC = {
				"rt_labWest_d_0002",
				"rt_labWest_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_labWest_n_0000",
				"rt_labWest_n_0003",
			},
			groupB = {
				"rt_labWest_n_0001",
				"rt_labWest_n_0004",
			},
			groupC = {
				"rt_labWest_n_0002",
				"rt_labWest_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_labWest_c_0000",
				"rt_labWest_c_0001",
				"rt_labWest_c_0003",
				"rt_labWest_c_0003",
				"rt_labWest_c_0004",
				"rt_labWest_c_0004",
				"rt_labWest_c_0005",
				"rt_labWest_c_0005",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_labWest_s_0000",
				"rt_labWest_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_labWest_l_0000",
				"rt_labWest_l_0001",
			},
			
			in_lrrpHold_E = {
				"rt_labWest_lin_E",
				"rt_labWest_lin_E",
			},
			in_lrrpHold_W = {
				"rt_labWest_lin_W",
				"rt_labWest_lin_W",
			},
			
			out_lrrpHold_E = {
				"rt_labWest_lout_E",
				"rt_labWest_lout_E",
			},
			out_lrrpHold_W = {
				"rt_labWest_lout_W",
				"rt_labWest_lout_W",
			},
			
			out_lrrpHold_B01 = {
				"rt_labWest_lout_B01",
				"rt_labWest_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_labWest_lout_B02",
				"rt_labWest_lout_B02",
			},
			out_lrrpHold_B03 = {
				"rt_labWest_lout_B03",
				"rt_labWest_lout_B03",
			},
		},
		outofrain = {
			"rt_labWest_r_0000",
			"rt_labWest_r_0001",
			"rt_labWest_r_0002",
			"rt_labWest_r_0003",
			"rt_labWest_r_0004",
			"rt_labWest_r_0005",
			"rt_labWest_r_0006",
			"rt_labWest_r_0007",
		},
		nil
	},

	
	
	

	
	mafr_01_20_lrrp = {
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
			lrrp_01to20 = {
				"rt_01to20_0000",
				"rt_01to20_0000",
			},
			lrrp_20to01 = {
				"rt_20to01_0000",
				"rt_20to01_0000",
			},
			rp_01to20 = {
				"rt_01to20_0000",
				"rt_01to20_0000",
				"rt_01to20_0000",
				"rt_01to20_0000",
			},
			rp_20to01 = {
				"rt_20to01_0000",
				"rt_20to01_0000",
				"rt_20to01_0000",
				"rt_20to01_0000",
			},
		},
		nil
	},

	
	mafr_02_21_lrrp = {
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
			lrrp_02to21 = {
				"rt_02to21_0000",
				"rt_02to21_0000",
			},
			lrrp_21to02 = {
				"rt_21to02_0000",
				"rt_21to02_0000",
			},
			rp_02to21 = {
				"rt_02to21_0000",
				"rt_02to21_0000",
				"rt_02to21_0000",
				"rt_02to21_0000",
			},
			rp_21to02 = {
				"rt_21to02_0000",
				"rt_21to02_0000",
				"rt_21to02_0000",
				"rt_21to02_0000",
			},
		},
		nil
	},

	
	mafr_02_22_lrrp = {
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
			lrrp_02to22 = {
				"rt_02to22_0000",
				"rt_02to22_0000",
			},
			lrrp_22to02 = {
				"rt_22to02_0000",
				"rt_22to02_0000",
			},
			rp_02to22 = {
				"rt_02to22_0000",
				"rt_02to22_0000",
				"rt_02to22_0000",
				"rt_02to22_0000",
			},
			rp_22to02 = {
				"rt_22to02_0000",
				"rt_22to02_0000",
				"rt_22to02_0000",
				"rt_22to02_0000",
			},
		},
		nil
	},

	
	mafr_03_20_lrrp = {
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
			lrrp_03to20 = {
				"rt_03to20_0000",
				"rt_03to20_0000",
			},
			lrrp_20to03 = {
				"rt_20to03_0000",
				"rt_20to03_0000",
			},
			rp_03to20 = {
				"rt_03to20_0000",
				"rt_03to20_0000",
				"rt_03to20_0000",
				"rt_03to20_0000",
			},
			rp_20to03 = {
				"rt_20to03_0000",
				"rt_20to03_0000",
				"rt_20to03_0000",
				"rt_20to03_0000",
			},
		},
		nil
	},

	
	mafr_04_09_lrrp = {
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
			lrrp_04to09 = {
				"rt_04to09_0000",
				"rt_04to09_0000",
			},
			lrrp_09to04 = {
				"rt_09to04_0000",
				"rt_09to04_0000",
			},
			rp_04to09 = {
				"rt_04to09_0000",
				"rt_04to09_0000",
				"rt_04to09_0000",
				"rt_04to09_0000",
			},
			rp_09to04 = {
				"rt_09to04_0000",
				"rt_09to04_0000",
				"rt_09to04_0000",
				"rt_09to04_0000",
			},
		},
		nil
	},

	
	mafr_04_25_lrrp = {
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
			lrrp_04to25 = {
				"rt_04to25_0000",
				"rt_04to25_0000",
			},
			lrrp_25to04 = {
				"rt_25to04_0000",
				"rt_25to04_0000",
			},
			rp_04to25 = {
				"rt_04to25_0000",
				"rt_04to25_0000",
				"rt_04to25_0000",
				"rt_04to25_0000",
			},
			rp_25to04 = {
				"rt_25to04_0000",
				"rt_25to04_0000",
				"rt_25to04_0000",
				"rt_25to04_0000",
			},
		},
		nil
	},

	
	mafr_05_16_lrrp = {
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
			lrrp_05to16 = {
				"rt_05to16_0000",
				"rt_05to16_0000",
			},
			lrrp_16to05 = {
				"rt_16to05_0000",
				"rt_16to05_0000",
			},
			rp_05to16 = {
				"rt_05to16_0000",
				"rt_05to16_0000",
				"rt_05to16_0000",
				"rt_05to16_0000",
			},
			rp_16to05 = {
				"rt_16to05_0000",
				"rt_16to05_0000",
				"rt_16to05_0000",
				"rt_16to05_0000",
			},
		},
		nil
	},

	
	mafr_05_22_lrrp = {
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
			lrrp_05to22 = {
				"rt_05to22_0000",
				"rt_05to22_0000",
			},
			lrrp_22to05 = {
				"rt_22to05_0000",
				"rt_22to05_0000",
			},
			rp_05to22 = {
				"rt_05to22_0000",
				"rt_05to22_0000",
				"rt_05to22_0000",
				"rt_05to22_0000",
			},
			rp_22to05 = {
				"rt_22to05_0000",
				"rt_22to05_0000",
				"rt_22to05_0000",
				"rt_22to05_0000",
			},
		},
		nil
	},

	
	mafr_05_23_lrrp = {
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
			lrrp_05to23 = {
				"rt_05to23_0000",
				"rt_05to23_0000",
			},
			lrrp_23to05 = {
				"rt_23to05_0000",
				"rt_23to05_0000",
			},
			rp_05to23 = {
				"rt_05to23_0000",
				"rt_05to23_0000",
				"rt_05to23_0000",
				"rt_05to23_0000",
			},
			rp_23to05 = {
				"rt_23to05_0000",
				"rt_23to05_0000",
				"rt_23to05_0000",
				"rt_23to05_0000",
			},
		},
		nil
	},

	
	mafr_06_16_lrrp = {
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
			lrrp_06to16 = {
				"rt_06to16_0000",
				"rt_06to16_0000",
			},
			lrrp_16to06 = {
				"rt_16to06_0000",
				"rt_16to06_0000",
			},
			rp_06to16 = {
				"rt_06to16_0000",
				"rt_06to16_0000",
				"rt_06to16_0000",
				"rt_06to16_0000",
			},
			rp_16to06 = {
				"rt_16to06_0000",
				"rt_16to06_0000",
				"rt_16to06_0000",
				"rt_16to06_0000",
			},
		},
		nil
	},

	
	mafr_06_22_lrrp = {
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
			lrrp_06to22 = {
				"rt_06to22_0000",
				"rt_06to22_0000",
			},
			lrrp_22to06 = {
				"rt_22to06_0000",
				"rt_22to06_0000",
			},
			rp_06to22 = {
				"rt_06to22_0000",
				"rt_06to22_0000",
				"rt_06to22_0000",
				"rt_06to22_0000",
			},
			rp_22to06 = {
				"rt_22to06_0000",
				"rt_22to06_0000",
				"rt_22to06_0000",
				"rt_22to06_0000",
			},
		},
		nil
	},

	
	mafr_06_24_lrrp = {
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

	
	mafr_07_24_lrrp = {
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
			lrrp_07to24 = {
				"rt_07to24_0000",
				"rt_07to24_0000",
			},
			lrrp_24to07 = {
				"rt_24to07_0000",
				"rt_24to07_0000",
			},
			rp_07to24 = {
				"rt_07to24_0000",
				"rt_07to24_0000",
				"rt_07to24_0000",
				"rt_07to24_0000",
			},
			rp_24to07 = {
				"rt_24to07_0000",
				"rt_24to07_0000",
				"rt_24to07_0000",
				"rt_24to07_0000",
			},
		},
		nil
	},

	
	mafr_08_10_lrrp = {
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
			lrrp_08to10 = {
				"rt_08to10_0000",
				"rt_08to10_0000",
			},
			lrrp_10to08 = {
				"rt_10to08_0000",
				"rt_10to08_0000",
			},
			rp_08to10 = {
				"rt_08to10_0000",
				"rt_08to10_0000",
				"rt_08to10_0000",
				"rt_08to10_0000",
			},
			rp_10to08 = {
				"rt_10to08_0000",
				"rt_10to08_0000",
				"rt_10to08_0000",
				"rt_10to08_0000",
			},
		},
		nil
	},

	
	mafr_08_25_lrrp = {
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
			lrrp_08to25 = {
				"rt_08to25_0000",
				"rt_08to25_0000",
			},
			lrrp_25to08 = {
				"rt_25to08_0000",
				"rt_25to08_0000",
			},
			rp_08to25 = {
				"rt_08to25_0000",
				"rt_08to25_0000",
				"rt_08to25_0000",
				"rt_08to25_0000",
			},
			rp_25to08 = {
				"rt_25to08_0000",
				"rt_25to08_0000",
				"rt_25to08_0000",
				"rt_25to08_0000",
			},
		},
		nil
	},

	
	mafr_09_25_lrrp = {
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
			lrrp_09to25 = {
				"rt_09to25_0000",
				"rt_09to25_0000",
			},
			lrrp_25to09 = {
				"rt_25to09_0000",
				"rt_25to09_0000",
			},
			rp_09to25 = {
				"rt_09to25_0000",
				"rt_09to25_0000",
				"rt_09to25_0000",
				"rt_09to25_0000",
			},
			rp_25to09 = {
				"rt_25to09_0000",
				"rt_25to09_0000",
				"rt_25to09_0000",
				"rt_25to09_0000",
			},
		},
		nil
	},

	
	mafr_10_11_lrrp = {
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
			lrrp_10to11 = {
				"rt_10to11_0000",
				"rt_10to11_0000",
			},
			lrrp_11to10 = {
				"rt_11to10_0000",
				"rt_11to10_0000",
			},
			rp_10to11 = {
				"rt_10to11_0000",
				"rt_10to11_0000",
				"rt_10to11_0000",
				"rt_10to11_0000",
			},
			rp_11to10 = {
				"rt_11to10_0000",
				"rt_11to10_0000",
				"rt_11to10_0000",
				"rt_11to10_0000",
			},
		},
		nil
	},

	
	mafr_10_26_lrrp = {
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
			lrrp_10to26 = {
				"rt_10to26_0000",
				"rt_10to26_0000",
			},
			lrrp_26to10 = {
				"rt_26to10_0000",
				"rt_26to10_0000",
			},
			rp_10to26 = {
				"rt_10to26_0000",
				"rt_10to26_0000",
				"rt_10to26_0000",
				"rt_10to26_0000",
			},
			rp_26to10 = {
				"rt_26to10_0000",
				"rt_26to10_0000",
				"rt_26to10_0000",
				"rt_26to10_0000",
			},
		},
		nil
	},

	
	mafr_11_12_lrrp = {
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
			lrrp_11to12 = {
				"rt_11to12_0000",
				"rt_11to12_0000",
			},
			lrrp_12to11 = {
				"rt_12to11_0000",
				"rt_12to11_0000",
			},
			rp_11to12 = {
				"rt_11to12_0000",
				"rt_11to12_0000",
				"rt_11to12_0000",
				"rt_11to12_0000",
			},
			rp_12to11 = {
				"rt_12to11_0000",
				"rt_12to11_0000",
				"rt_12to11_0000",
				"rt_12to11_0000",
			},
		},
		nil
	},

	
	mafr_12_14_lrrp = {
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
			lrrp_12to14 = {
				"rt_12to14_0000",
				"rt_12to14_0000",
			},
			lrrp_14to12 = {
				"rt_14to12_0000",
				"rt_14to12_0000",
			},
			rp_12to14 = {
				"rt_12to14_0000",
				"rt_12to14_0000",
				"rt_12to14_0000",
				"rt_12to14_0000",
			},
			rp_14to12 = {
				"rt_14to12_0000",
				"rt_14to12_0000",
				"rt_14to12_0000",
				"rt_14to12_0000",
			},
		},
		nil
	},

	
	mafr_13_15_lrrp = {
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
			lrrp_13to15 = {
				"rt_13to15_0000",
				"rt_13to15_0000",
			},
			lrrp_15to13 = {
				"rt_15to13_0000",
				"rt_15to13_0000",
			},
			rp_13to15 = {
				"rt_13to15_0000",
				"rt_13to15_0000",
				"rt_13to15_0000",
				"rt_13to15_0000",
			},
			rp_15to13 = {
				"rt_15to13_0000",
				"rt_15to13_0000",
				"rt_15to13_0000",
				"rt_15to13_0000",
			},
		},
		nil
	},

	
	mafr_13_16_lrrp = {
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
			lrrp_13to16 = {
				"rt_13to16_0000",
				"rt_13to16_0000",
			},
			lrrp_16to13 = {
				"rt_16to13_0000",
				"rt_16to13_0000",
			},
			rp_13to16 = {
				"rt_13to16_0000",
				"rt_13to16_0000",
				"rt_13to16_0000",
				"rt_13to16_0000",
			},
			rp_16to13 = {
				"rt_16to13_0000",
				"rt_16to13_0000",
				"rt_16to13_0000",
				"rt_16to13_0000",
			},
		},
		nil
	},

	
	mafr_04_07_lrrp = {
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
			lrrp_04to07 = {
				"rt_04to07_0000",
				"rt_04to07_0000",
			},
			lrrp_07to04 = {
				"rt_07to04_0000",
				"rt_07to04_0000",
			},
			rp_04to07 = {
				"rt_04to07_0000",
				"rt_04to07_0000",
				"rt_04to07_0000",
				"rt_04to07_0000",
			},
			rp_07to04 = {
				"rt_07to04_0000",
				"rt_07to04_0000",
				"rt_07to04_0000",
				"rt_07to04_0000",
			},
		},
		nil
	},

	
	mafr_07_09_lrrp = {
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
			lrrp_07to09 = {
				"rt_07to09_0000",
				"rt_07to09_0000",
			},
			lrrp_09to07 = {
				"rt_09to07_0000",
				"rt_09to07_0000",
			},
			rp_07to09 = {
				"rt_07to09_0000",
				"rt_07to09_0000",
				"rt_07to09_0000",
				"rt_07to09_0000",
			},
			rp_09to07 = {
				"rt_09to07_0000",
				"rt_09to07_0000",
				"rt_09to07_0000",
				"rt_09to07_0000",
			},
		},
		nil
	},

	
	mafr_13_24_lrrp = {
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
			lrrp_13to24 = {
				"rt_13to24_0000",
				"rt_13to24_0000",
			},
			lrrp_24to13 = {
				"rt_24to13_0000",
				"rt_24to13_0000",
			},
			rp_13to24 = {
				"rt_13to24_0000",
				"rt_13to24_0000",
				"rt_13to24_0000",
				"rt_13to24_0000",
			},
			rp_24to13 = {
				"rt_24to13_0000",
				"rt_24to13_0000",
				"rt_24to13_0000",
				"rt_24to13_0000",
			},
		},
		nil
	},

	
	mafr_14_27_lrrp = {
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
			lrrp_14to27 = {
				"rt_14to27_0000",
				"rt_14to27_0000",
			},
			lrrp_27to14 = {
				"rt_27to14_0000",
				"rt_27to14_0000",
			},
			rp_14to27 = {
				"rt_14to27_0000",
				"rt_14to27_0000",
				"rt_14to27_0000",
				"rt_14to27_0000",
			},
			rp_27to14 = {
				"rt_27to14_0000",
				"rt_27to14_0000",
				"rt_27to14_0000",
				"rt_27to14_0000",
			},
		},
		nil
	},

	
	mafr_15_16_lrrp = {
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
			lrrp_15to16 = {
				"rt_15to16_0000",
				"rt_15to16_0000",
			},
			lrrp_16to15 = {
				"rt_16to15_0000",
				"rt_16to15_0000",
			},
			rp_15to16 = {
				"rt_15to16_0000",
				"rt_15to16_0000",
				"rt_15to16_0000",
				"rt_15to16_0000",
			},
			rp_16to15 = {
				"rt_16to15_0000",
				"rt_16to15_0000",
				"rt_16to15_0000",
				"rt_16to15_0000",
			},
		},
		nil
	},

	
	mafr_15_23_lrrp = {
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
			lrrp_15to23 = {
				"rt_15to23_0000",
				"rt_15to23_0000",
			},
			lrrp_15to23_01 = {
				"rt_15to23_0001",
				"rt_15to23_0001",
			},
			lrrp_23to15 = {
				"rt_23to15_0000",
				"rt_23to15_0000",
			},
			lrrp_23to15_01 = {
				"rt_23to15_0001",
				"rt_23to15_0001",
			},
			rp_15to23 = {
				"rt_15to23_0000",
				"rt_15to23_0000",
				"rt_15to23_0000",
				"rt_15to23_0000",
			},
			rp_23to15 = {
				"rt_23to15_0000",
				"rt_23to15_0000",
				"rt_23to15_0000",
				"rt_23to15_0000",
			},
		},
		nil
	},

	
	mafr_15_27_lrrp = {
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
			lrrp_15to27 = {
				"rt_15to27_0000",
				"rt_15to27_0000",
			},
			lrrp_27to15 = {
				"rt_27to15_0000",
				"rt_27to15_0000",
			},
			rp_15to27 = {
				"rt_15to27_0000",
				"rt_15to27_0000",
				"rt_15to27_0000",
				"rt_15to27_0000",
			},
			rp_27to15 = {
				"rt_27to15_0000",
				"rt_27to15_0000",
				"rt_27to15_0000",
				"rt_27to15_0000",
			},
		},
		nil
	},

	
	mafr_15_31_lrrp = {
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
			lrrp_15to31 = {
				"rt_15to31_0000",
				"rt_15to31_0000",
			},
			lrrp_31to15 = {
				"rt_31to15_0000",
				"rt_31to15_0000",
			},
			rp_15to31 = {
				"rt_15to31_0000",
				"rt_15to31_0000",
				"rt_15to31_0000",
				"rt_15to31_0000",
			},
			rp_31to15 = {
				"rt_31to15_0000",
				"rt_31to15_0000",
				"rt_31to15_0000",
				"rt_31to15_0000",
			},
		},
		nil
	},

	
	mafr_16_23_lrrp = {
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
			lrrp_16to23 = {
				"rt_16to23_0000",
				"rt_16to23_0000",
			},
			lrrp_23to16 = {
				"rt_23to16_0000",
				"rt_23to16_0000",
			},
			rp_16to23 = {
				"rt_16to23_0000",
				"rt_16to23_0000",
				"rt_16to23_0000",
				"rt_16to23_0000",
			},
			rp_23to16 = {
				"rt_23to16_0000",
				"rt_23to16_0000",
				"rt_23to16_0000",
				"rt_23to16_0000",
			},
		},
		nil
	},

	
	mafr_16_24_lrrp = {
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
			lrrp_16to24 = {
				"rt_16to24_0000",
				"rt_16to24_0000",
			},
			lrrp_24to16 = {
				"rt_24to16_0000",
				"rt_24to16_0000",
			},
			rp_16to24 = {
				"rt_16to24_0000",
				"rt_16to24_0000",
				"rt_16to24_0000",
				"rt_16to24_0000",
			},
			rp_24to16 = {
				"rt_24to16_0000",
				"rt_24to16_0000",
				"rt_24to16_0000",
				"rt_24to16_0000",
			},
		},
		nil
	},

	
	mafr_17_27_lrrp = {
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

	
	mafr_18_26_lrrp = {
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
			lrrp_18to26 = {
				"rt_18to26_0000",
				"rt_18to26_0000",
			},
			lrrp_26to18 = {
				"rt_26to18_0000",
				"rt_26to18_0000",
			},
			rp_18to26 = {
				"rt_18to26_0000",
				"rt_18to26_0000",
				"rt_18to26_0000",
				"rt_18to26_0000",
			},
			rp_26to18 = {
				"rt_26to18_0000",
				"rt_26to18_0000",
				"rt_26to18_0000",
				"rt_26to18_0000",
			},
		},
		nil
	},

	
	mafr_19_29_lrrp = {
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
			lrrp_19to29 = {
				"rt_19to29_0000",
				"rt_19to29_0000",
			},
			lrrp_29to19 = {
				"rt_29to19_0000",
				"rt_29to19_0000",
			},
			rp_19to29 = {
				"rt_19to29_0000",
				"rt_19to29_0000",
				"rt_19to29_0000",
				"rt_19to29_0000",
			},
			rp_29to19 = {
				"rt_29to19_0000",
				"rt_29to19_0000",
				"rt_29to19_0000",
				"rt_29to19_0000",
			},
		},
		nil
	},

	
	mafr_18_19_lrrp = {
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
			lrrp_18to19 = {
				"rt_18to19_0000",
				"rt_18to19_0000",
			},
			lrrp_19to18 = {
				"rt_19to18_0000",
				"rt_19to18_0000",
			},
			rp_18to19 = {
				"rt_18to19_0000",
				"rt_18to19_0000",
				"rt_18to19_0000",
				"rt_18to19_0000",
			},
			rp_19to18 = {
				"rt_19to18_0000",
				"rt_19to18_0000",
				"rt_19to18_0000",
				"rt_19to18_0000",
			},
		},
		nil
	},

	
	mafr_23_33_lrrp = {
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
			lrrp_23to33 = {
				"rt_23to33_0000",
				"rt_23to33_0000",
			},
			lrrp_33to23 = {
				"rt_33to23_0000",
				"rt_33to23_0000",
			},
			rp_23to33 = {
				"rt_23to33_0000",
				"rt_23to33_0000",
				"rt_23to33_0000",
				"rt_23to33_0000",
			},
			rp_33to23 = {
				"rt_33to23_0000",
				"rt_33to23_0000",
				"rt_33to23_0000",
				"rt_33to23_0000",
			},
		},
		nil
	},

	
	mafr_27_30_lrrp = {
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
			lrrp_27to30 = {
				"rt_27to30_0000",
				"rt_27to30_0000",
			},
			lrrp_30to27 = {
				"rt_30to27_0000",
				"rt_30to27_0000",
			},
			rp_27to30 = {
				"rt_27to30_0000",
				"rt_27to30_0000",
				"rt_27to30_0000",
				"rt_27to30_0000",
			},
			rp_30to27 = {
				"rt_30to27_0000",
				"rt_30to27_0000",
				"rt_30to27_0000",
				"rt_30to27_0000",
			},
		},
		nil
	},

	
	mafr_31_33_lrrp = {
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
			lrrp_31to33 = {
				"rt_31to33_0000",
				"rt_31to33_0000",
			},
			lrrp_33to31 = {
				"rt_33to31_0000",
				"rt_33to31_0000",
			},
			rp_31to33 = {
				"rt_31to33_0000",
				"rt_31to33_0000",
				"rt_31to33_0000",
				"rt_31to33_0000",
			},
			rp_33to31 = {
				"rt_33to31_0000",
				"rt_33to31_0000",
				"rt_33to31_0000",
				"rt_33to31_0000",
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

return mafr_routeSets
