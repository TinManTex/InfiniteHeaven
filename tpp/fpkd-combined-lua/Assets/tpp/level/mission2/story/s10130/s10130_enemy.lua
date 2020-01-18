local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}





this.soldierDefine = {
	
	mafr_lab_cp = {
		
		"sol_lab_0000",
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
		nil
	},
	mafr_lab_w_cp = {
		
		"sol_lab_0012",
		"sol_lab_0013",
		"sol_lab_0014",
		"sol_lab_0015",
		"sol_lab_0016",
		"sol_lab_0017",
		"sol_lab_0018",
		"sol_lab_0019",
		"sol_lab_0020",
		"sol_lab_0021",
		"sol_lab_0022",
		"sol_lab_0023",
		"sol_lab_0036",
		"sol_lab_0037",
		"sol_lab_0038",
		"sol_lab_0039",
		"sol_lab_0040",
		"sol_lab_0041",
		"sol_lab_0042",
		"sol_lab_0043",
		"sol_lab_0044",
		"sol_lab_0045",
		"sol_lab_0046",
		"sol_lab_0047",
		"sol_lab_0048",
		"sol_lab_0049",
		"sol_lab_0050",
		"sol_lab_0051",
		"sol_lab_0052",
		"sol_lab_0053",
		"sol_lab_0054",
		"sol_lab_0055",
		"sol_lab_0056",
		"sol_lab_0057",
		"sol_lab_0058",
		"sol_lab_0059",
		"sol_lab_0060",
		"sol_lab_0061",
		"sol_lab_0062",
		"sol_lab_0063",
		"sol_lab_0064",
		"sol_lab_0065",
		"sol_lab_0066",
		"sol_lab_0067",
		"sol_lab_0068",
		"sol_lab_0069",
		"sol_lab_0070",
		"sol_lab_0071",
		nil
	},
	mafr_lab_s_cp = {
		
		"sol_lab_0024",
		"sol_lab_0025",
		"sol_lab_0026",
		"sol_lab_0027",
		"sol_lab_0028",
		"sol_lab_0029",
		"sol_lab_0030",
		"sol_lab_0031",
		"sol_lab_0032",
		"sol_lab_0033",
		"sol_lab_0034",
		"sol_lab_0035",
		"sol_lab_0072",
		"sol_lab_0073",
		"sol_lab_0074",
		"sol_lab_0075",
		"sol_lab_0076",
		"sol_lab_0077",
		"sol_lab_0078",
		"sol_lab_0079",
		"sol_lab_0080",
		"sol_lab_0081",
		"sol_lab_0082",
		"sol_lab_0083",
		"sol_lab_0084",
		"sol_lab_0085",
		"sol_lab_0086",
		"sol_lab_0087",
		"sol_lab_0088",
		"sol_lab_0089",
		"sol_lab_0090",
		"sol_lab_0091",
		"sol_lab_0092",
		"sol_lab_0093",
		"sol_lab_0094",
		"sol_lab_0095",
		"sol_lab_0096",
		"sol_lab_0097",
		"sol_lab_0098",
		"sol_lab_0099",
		"sol_lab_0100",
		"sol_lab_0101",
		"sol_lab_0102",
		"sol_lab_0103",
		"sol_lab_0104",
		"sol_lab_0105",
		"sol_lab_0106",
		"sol_lab_0107",
		nil
	},
	nil
}


this.soldierSubTypes = {
	
	PF_B = {
		this.soldierDefine.mafr_lab_w_cp,	
		this.soldierDefine.mafr_lab_s_cp,	
	},
}


this.parasiteDefine = {
	"wmu_lab_0000",
	"wmu_lab_0001",
	"wmu_lab_0002",
	"wmu_lab_0003",
	nil
}






this.routeSets = {
	
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
				"rt_lab_d_0007",
				"rt_lab_d_0002",
			},
			groupB = {
				"rt_lab_d_0001",
				"rt_lab_d_0007",
				"rt_lab_d_0006",
				"rt_lab_d_0007",
			},
			groupC = {
				"rt_lab_d_0002",
				"rt_lab_d_0006",
				"rt_lab_d_0004",
				"rt_lab_d_0002",
			},
			groupD = {
				"rt_lab_d_0003",
				"rt_lab_d_0009",
				"rt_lab_d_0012",
				"rt_lab_d_0006",
			},
			groupE = {
				"rt_lab_d_0004",
				"rt_lab_d_0002",
				"rt_lab_d_0006",
				"rt_lab_d_0007",
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
		},
		nil
	},

	mafr_lab_w_cp = {
		
		
		
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_lab_w_wait_0000",
				"rts_lab_w_wait_0001",
				"rts_lab_w_wait_0002",
				"rts_lab_w_wait_0003",
				"rts_lab_w_wait_0004",
				"rts_lab_w_wait_0005",
				"rts_lab_w_wait_0006",
				"rts_lab_w_wait_0007",
				"rts_lab_w_wait_0008",
				"rts_lab_w_wait_0009",
				"rts_lab_w_wait_0010",
				"rts_lab_w_wait_0011",
				"rts_lab_w_wait_0012",
				"rts_lab_w_wait_0013",
				"rts_lab_w_wait_0014",
				"rts_lab_w_wait_0015",
				"rts_lab_w_wait_0016",
				"rts_lab_w_wait_0017",
				"rts_lab_w_wait_0018",
				"rts_lab_w_wait_0019",
				"rts_lab_w_wait_0020",
				"rts_lab_w_wait_0021",
				"rts_lab_w_wait_0022",
				"rts_lab_w_wait_0023",
				"rts_lab_w_wait_0000",
				"rts_lab_w_wait_0001",
				"rts_lab_w_wait_0002",
				"rts_lab_w_wait_0003",
				"rts_lab_w_wait_0004",
				"rts_lab_w_wait_0005",
				"rts_lab_w_wait_0006",
				"rts_lab_w_wait_0007",
				"rts_lab_w_wait_0008",
				"rts_lab_w_wait_0009",
				"rts_lab_w_wait_0010",
				"rts_lab_w_wait_0011",
				"rts_lab_w_wait_0012",
				"rts_lab_w_wait_0013",
				"rts_lab_w_wait_0014",
				"rts_lab_w_wait_0015",
				"rts_lab_w_wait_0016",
				"rts_lab_w_wait_0017",
				"rts_lab_w_wait_0018",
				"rts_lab_w_wait_0019",
				"rts_lab_w_wait_0020",
				"rts_lab_w_wait_0021",
				"rts_lab_w_wait_0022",
				"rts_lab_w_wait_0023",
			},
		},
		sneak_night= {
			groupA = {
				"rts_lab_w_wait_0000",
				"rts_lab_w_wait_0001",
				"rts_lab_w_wait_0002",
				"rts_lab_w_wait_0003",
				"rts_lab_w_wait_0004",
				"rts_lab_w_wait_0005",
				"rts_lab_w_wait_0006",
				"rts_lab_w_wait_0007",
				"rts_lab_w_wait_0008",
				"rts_lab_w_wait_0009",
				"rts_lab_w_wait_0010",
				"rts_lab_w_wait_0011",
				"rts_lab_w_wait_0012",
				"rts_lab_w_wait_0013",
				"rts_lab_w_wait_0014",
				"rts_lab_w_wait_0015",
				"rts_lab_w_wait_0016",
				"rts_lab_w_wait_0017",
				"rts_lab_w_wait_0018",
				"rts_lab_w_wait_0019",
				"rts_lab_w_wait_0020",
				"rts_lab_w_wait_0021",
				"rts_lab_w_wait_0022",
				"rts_lab_w_wait_0023",
				"rts_lab_w_wait_0000",
				"rts_lab_w_wait_0001",
				"rts_lab_w_wait_0002",
				"rts_lab_w_wait_0003",
				"rts_lab_w_wait_0004",
				"rts_lab_w_wait_0005",
				"rts_lab_w_wait_0006",
				"rts_lab_w_wait_0007",
				"rts_lab_w_wait_0008",
				"rts_lab_w_wait_0009",
				"rts_lab_w_wait_0010",
				"rts_lab_w_wait_0011",
				"rts_lab_w_wait_0012",
				"rts_lab_w_wait_0013",
				"rts_lab_w_wait_0014",
				"rts_lab_w_wait_0015",
				"rts_lab_w_wait_0016",
				"rts_lab_w_wait_0017",
				"rts_lab_w_wait_0018",
				"rts_lab_w_wait_0019",
				"rts_lab_w_wait_0020",
				"rts_lab_w_wait_0021",
				"rts_lab_w_wait_0022",
				"rts_lab_w_wait_0023",
			},
		},
		caution = {
			groupA = {
				"rts_lab_w_wait_0000",
				"rts_lab_w_wait_0001",
				"rts_lab_w_wait_0002",
				"rts_lab_w_wait_0003",
				"rts_lab_w_wait_0004",
				"rts_lab_w_wait_0005",
				"rts_lab_w_wait_0006",
				"rts_lab_w_wait_0007",
				"rts_lab_w_wait_0008",
				"rts_lab_w_wait_0009",
				"rts_lab_w_wait_0010",
				"rts_lab_w_wait_0011",
				"rts_lab_w_wait_0012",
				"rts_lab_w_wait_0013",
				"rts_lab_w_wait_0014",
				"rts_lab_w_wait_0015",
				"rts_lab_w_wait_0016",
				"rts_lab_w_wait_0017",
				"rts_lab_w_wait_0018",
				"rts_lab_w_wait_0019",
				"rts_lab_w_wait_0020",
				"rts_lab_w_wait_0021",
				"rts_lab_w_wait_0022",
				"rts_lab_w_wait_0023",
				"rts_lab_w_wait_0000",
				"rts_lab_w_wait_0001",
				"rts_lab_w_wait_0002",
				"rts_lab_w_wait_0003",
				"rts_lab_w_wait_0004",
				"rts_lab_w_wait_0005",
				"rts_lab_w_wait_0006",
				"rts_lab_w_wait_0007",
				"rts_lab_w_wait_0008",
				"rts_lab_w_wait_0009",
				"rts_lab_w_wait_0010",
				"rts_lab_w_wait_0011",
				"rts_lab_w_wait_0012",
				"rts_lab_w_wait_0013",
				"rts_lab_w_wait_0014",
				"rts_lab_w_wait_0015",
				"rts_lab_w_wait_0016",
				"rts_lab_w_wait_0017",
				"rts_lab_w_wait_0018",
				"rts_lab_w_wait_0019",
				"rts_lab_w_wait_0020",
				"rts_lab_w_wait_0021",
				"rts_lab_w_wait_0022",
				"rts_lab_w_wait_0023",
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
		nil
	},
	mafr_lab_s_cp = {
		
		
		
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_lab_s_wait_0000",
				"rts_lab_s_wait_0001",
				"rts_lab_s_wait_0002",
				"rts_lab_s_wait_0003",
				"rts_lab_s_wait_0004",
				"rts_lab_s_wait_0005",
				"rts_lab_s_wait_0006",
				"rts_lab_s_wait_0007",
				"rts_lab_s_wait_0008",
				"rts_lab_s_wait_0009",
				"rts_lab_s_wait_0010",
				"rts_lab_s_wait_0011",
				"rts_lab_s_wait_0012",
				"rts_lab_s_wait_0013",
				"rts_lab_s_wait_0014",
				"rts_lab_s_wait_0015",
				"rts_lab_s_wait_0016",
				"rts_lab_s_wait_0017",
				"rts_lab_s_wait_0018",
				"rts_lab_s_wait_0019",
				"rts_lab_s_wait_0020",
				"rts_lab_s_wait_0021",
				"rts_lab_s_wait_0022",
				"rts_lab_s_wait_0023",
				"rts_lab_s_wait_0000",
				"rts_lab_s_wait_0001",
				"rts_lab_s_wait_0002",
				"rts_lab_s_wait_0003",
				"rts_lab_s_wait_0004",
				"rts_lab_s_wait_0005",
				"rts_lab_s_wait_0006",
				"rts_lab_s_wait_0007",
				"rts_lab_s_wait_0008",
				"rts_lab_s_wait_0009",
				"rts_lab_s_wait_0010",
				"rts_lab_s_wait_0011",
				"rts_lab_s_wait_0012",
				"rts_lab_s_wait_0013",
				"rts_lab_s_wait_0014",
				"rts_lab_s_wait_0015",
				"rts_lab_s_wait_0016",
				"rts_lab_s_wait_0017",
				"rts_lab_s_wait_0018",
				"rts_lab_s_wait_0019",
				"rts_lab_s_wait_0020",
				"rts_lab_s_wait_0021",
				"rts_lab_s_wait_0022",
				"rts_lab_s_wait_0023",
			},
		},
		sneak_night= {
			groupA = {
				"rts_lab_s_wait_0000",
				"rts_lab_s_wait_0001",
				"rts_lab_s_wait_0002",
				"rts_lab_s_wait_0003",
				"rts_lab_s_wait_0004",
				"rts_lab_s_wait_0005",
				"rts_lab_s_wait_0006",
				"rts_lab_s_wait_0007",
				"rts_lab_s_wait_0008",
				"rts_lab_s_wait_0009",
				"rts_lab_s_wait_0010",
				"rts_lab_s_wait_0011",
				"rts_lab_s_wait_0012",
				"rts_lab_s_wait_0013",
				"rts_lab_s_wait_0014",
				"rts_lab_s_wait_0015",
				"rts_lab_s_wait_0016",
				"rts_lab_s_wait_0017",
				"rts_lab_s_wait_0018",
				"rts_lab_s_wait_0019",
				"rts_lab_s_wait_0020",
				"rts_lab_s_wait_0021",
				"rts_lab_s_wait_0022",
				"rts_lab_s_wait_0023",
				"rts_lab_s_wait_0000",
				"rts_lab_s_wait_0001",
				"rts_lab_s_wait_0002",
				"rts_lab_s_wait_0003",
				"rts_lab_s_wait_0004",
				"rts_lab_s_wait_0005",
				"rts_lab_s_wait_0006",
				"rts_lab_s_wait_0007",
				"rts_lab_s_wait_0008",
				"rts_lab_s_wait_0009",
				"rts_lab_s_wait_0010",
				"rts_lab_s_wait_0011",
				"rts_lab_s_wait_0012",
				"rts_lab_s_wait_0013",
				"rts_lab_s_wait_0014",
				"rts_lab_s_wait_0015",
				"rts_lab_s_wait_0016",
				"rts_lab_s_wait_0017",
				"rts_lab_s_wait_0018",
				"rts_lab_s_wait_0019",
				"rts_lab_s_wait_0020",
				"rts_lab_s_wait_0021",
				"rts_lab_s_wait_0022",
				"rts_lab_s_wait_0023",
			},
		},
		caution = {
			groupA = {
				"rts_lab_s_wait_0000",
				"rts_lab_s_wait_0001",
				"rts_lab_s_wait_0002",
				"rts_lab_s_wait_0003",
				"rts_lab_s_wait_0004",
				"rts_lab_s_wait_0005",
				"rts_lab_s_wait_0006",
				"rts_lab_s_wait_0007",
				"rts_lab_s_wait_0008",
				"rts_lab_s_wait_0009",
				"rts_lab_s_wait_0010",
				"rts_lab_s_wait_0011",
				"rts_lab_s_wait_0012",
				"rts_lab_s_wait_0013",
				"rts_lab_s_wait_0014",
				"rts_lab_s_wait_0015",
				"rts_lab_s_wait_0016",
				"rts_lab_s_wait_0017",
				"rts_lab_s_wait_0018",
				"rts_lab_s_wait_0019",
				"rts_lab_s_wait_0020",
				"rts_lab_s_wait_0021",
				"rts_lab_s_wait_0022",
				"rts_lab_s_wait_0023",
				"rts_lab_s_wait_0000",
				"rts_lab_s_wait_0001",
				"rts_lab_s_wait_0002",
				"rts_lab_s_wait_0003",
				"rts_lab_s_wait_0004",
				"rts_lab_s_wait_0005",
				"rts_lab_s_wait_0006",
				"rts_lab_s_wait_0007",
				"rts_lab_s_wait_0008",
				"rts_lab_s_wait_0009",
				"rts_lab_s_wait_0010",
				"rts_lab_s_wait_0011",
				"rts_lab_s_wait_0012",
				"rts_lab_s_wait_0013",
				"rts_lab_s_wait_0014",
				"rts_lab_s_wait_0015",
				"rts_lab_s_wait_0016",
				"rts_lab_s_wait_0017",
				"rts_lab_s_wait_0018",
				"rts_lab_s_wait_0019",
				"rts_lab_s_wait_0020",
				"rts_lab_s_wait_0021",
				"rts_lab_s_wait_0022",
				"rts_lab_s_wait_0023",
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
		nil
	},
	nil
}


this.routeSets01 = {
	
	mafr_lab_cp = {
		
		
		
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_Zombie_0000",
				"rts_Zombie_0001",
				"rts_Zombie_0002",
				"rts_Zombie_0003",
				"rts_Zombie_0004",
				"rts_Zombie_0005",
				"rts_Zombie_0006",
				"rts_Zombie_0007",
				"rts_Zombie_0008",
				"rts_Zombie_0009",
				"rts_Zombie_0010",
				"rts_Zombie_0011",
			},
		},
		sneak_night= {
			groupA = {
				"rts_Zombie_0000",
				"rts_Zombie_0001",
				"rts_Zombie_0002",
				"rts_Zombie_0003",
				"rts_Zombie_0004",
				"rts_Zombie_0005",
				"rts_Zombie_0006",
				"rts_Zombie_0007",
				"rts_Zombie_0008",
				"rts_Zombie_0009",
				"rts_Zombie_0010",
				"rts_Zombie_0011",
			},
		},
		caution = {
			groupA = {
				"rts_Zombie_0000",
				"rts_Zombie_0001",
				"rts_Zombie_0002",
				"rts_Zombie_0003",
				"rts_Zombie_0004",
				"rts_Zombie_0005",
				"rts_Zombie_0006",
				"rts_Zombie_0007",
				"rts_Zombie_0008",
				"rts_Zombie_0009",
				"rts_Zombie_0010",
				"rts_Zombie_0011",
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
				"rt_lab_l_0000",
				"rt_lab_l_0001",
			},
		},
		nil
	},
	mafr_lab_w_cp = {
		
		
		
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_Zombie_0012",
				"rts_Zombie_0013",
				"rts_Zombie_0014",
				"rts_Zombie_0015",
				"rts_Zombie_0016",
				"rts_Zombie_0017",
				"rts_Zombie_0018",
				"rts_Zombie_0019",
				"rts_Zombie_0020",
				"rts_Zombie_0021",
				"rts_Zombie_0022",
				"rts_Zombie_0023",
				"rts_Zombie_0024",
				"rts_Zombie_0025",
				"rts_Zombie_0026",
				"rts_Zombie_0027",
				"rts_Zombie_0012",
				"rts_Zombie_0013",
				"rts_Zombie_0014",
				"rts_Zombie_0015",
				"rts_Zombie_0016",
				"rts_Zombie_0017",
				"rts_Zombie_0018",
				"rts_Zombie_0019",
				"rts_Zombie_0020",
				"rts_Zombie_0021",
				"rts_Zombie_0022",
				"rts_Zombie_0023",
				"rts_Zombie_0024",
				"rts_Zombie_0025",
				"rts_Zombie_0026",
				"rts_Zombie_0027",
				"rts_Zombie_0012",
				"rts_Zombie_0013",
				"rts_Zombie_0014",
				"rts_Zombie_0015",
				"rts_Zombie_0016",
				"rts_Zombie_0017",
				"rts_Zombie_0018",
				"rts_Zombie_0019",
				"rts_Zombie_0020",
				"rts_Zombie_0021",
				"rts_Zombie_0022",
				"rts_Zombie_0023",
				"rts_Zombie_0024",
				"rts_Zombie_0025",
				"rts_Zombie_0026",
				"rts_Zombie_0027",
			},
		},
		sneak_night= {
			groupA = {
				"rts_Zombie_0012",
				"rts_Zombie_0013",
				"rts_Zombie_0014",
				"rts_Zombie_0015",
				"rts_Zombie_0016",
				"rts_Zombie_0017",
				"rts_Zombie_0018",
				"rts_Zombie_0019",
				"rts_Zombie_0020",
				"rts_Zombie_0021",
				"rts_Zombie_0022",
				"rts_Zombie_0023",
				"rts_Zombie_0024",
				"rts_Zombie_0025",
				"rts_Zombie_0026",
				"rts_Zombie_0027",
				"rts_Zombie_0012",
				"rts_Zombie_0013",
				"rts_Zombie_0014",
				"rts_Zombie_0015",
				"rts_Zombie_0016",
				"rts_Zombie_0017",
				"rts_Zombie_0018",
				"rts_Zombie_0019",
				"rts_Zombie_0020",
				"rts_Zombie_0021",
				"rts_Zombie_0022",
				"rts_Zombie_0023",
				"rts_Zombie_0024",
				"rts_Zombie_0025",
				"rts_Zombie_0026",
				"rts_Zombie_0027",
				"rts_Zombie_0012",
				"rts_Zombie_0013",
				"rts_Zombie_0014",
				"rts_Zombie_0015",
				"rts_Zombie_0016",
				"rts_Zombie_0017",
				"rts_Zombie_0018",
				"rts_Zombie_0019",
				"rts_Zombie_0020",
				"rts_Zombie_0021",
				"rts_Zombie_0022",
				"rts_Zombie_0023",
				"rts_Zombie_0024",
				"rts_Zombie_0025",
				"rts_Zombie_0026",
				"rts_Zombie_0027",
			},
		},
		caution = {
			groupA = {
				"rts_Zombie_0012",
				"rts_Zombie_0013",
				"rts_Zombie_0014",
				"rts_Zombie_0015",
				"rts_Zombie_0016",
				"rts_Zombie_0017",
				"rts_Zombie_0018",
				"rts_Zombie_0019",
				"rts_Zombie_0020",
				"rts_Zombie_0021",
				"rts_Zombie_0022",
				"rts_Zombie_0023",
				"rts_Zombie_0024",
				"rts_Zombie_0025",
				"rts_Zombie_0026",
				"rts_Zombie_0027",
				"rts_Zombie_0012",
				"rts_Zombie_0013",
				"rts_Zombie_0014",
				"rts_Zombie_0015",
				"rts_Zombie_0016",
				"rts_Zombie_0017",
				"rts_Zombie_0018",
				"rts_Zombie_0019",
				"rts_Zombie_0020",
				"rts_Zombie_0021",
				"rts_Zombie_0022",
				"rts_Zombie_0023",
				"rts_Zombie_0024",
				"rts_Zombie_0025",
				"rts_Zombie_0026",
				"rts_Zombie_0027",
				"rts_Zombie_0012",
				"rts_Zombie_0013",
				"rts_Zombie_0014",
				"rts_Zombie_0015",
				"rts_Zombie_0016",
				"rts_Zombie_0017",
				"rts_Zombie_0018",
				"rts_Zombie_0019",
				"rts_Zombie_0020",
				"rts_Zombie_0021",
				"rts_Zombie_0022",
				"rts_Zombie_0023",
				"rts_Zombie_0024",
				"rts_Zombie_0025",
				"rts_Zombie_0026",
				"rts_Zombie_0027",
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
		nil
	},
	mafr_lab_s_cp = {
		
		
		
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_Zombie_0028",
				"rts_Zombie_0029",
				"rts_Zombie_0030",
				"rts_Zombie_0031",
				"rts_Zombie_0032",
				"rts_Zombie_0033",
				"rts_Zombie_0034",
				"rts_Zombie_0035",
				"rts_Zombie_0036",
				"rts_Zombie_0037",
				"rts_Zombie_0038",
				"rts_Zombie_0039",
				"rts_Zombie_0040",
				"rts_Zombie_0041",
				"rts_Zombie_0042",
				"rts_Zombie_0043",
				"rts_Zombie_0028",
				"rts_Zombie_0029",
				"rts_Zombie_0030",
				"rts_Zombie_0031",
				"rts_Zombie_0032",
				"rts_Zombie_0033",
				"rts_Zombie_0034",
				"rts_Zombie_0035",
				"rts_Zombie_0036",
				"rts_Zombie_0037",
				"rts_Zombie_0038",
				"rts_Zombie_0039",
				"rts_Zombie_0040",
				"rts_Zombie_0041",
				"rts_Zombie_0042",
				"rts_Zombie_0043",
				"rts_Zombie_0028",
				"rts_Zombie_0029",
				"rts_Zombie_0030",
				"rts_Zombie_0031",
				"rts_Zombie_0032",
				"rts_Zombie_0033",
				"rts_Zombie_0034",
				"rts_Zombie_0035",
				"rts_Zombie_0036",
				"rts_Zombie_0037",
				"rts_Zombie_0038",
				"rts_Zombie_0039",
				"rts_Zombie_0040",
				"rts_Zombie_0041",
				"rts_Zombie_0042",
				"rts_Zombie_0043",
			},
		},
		sneak_night= {
			groupA = {
				"rts_Zombie_0028",
				"rts_Zombie_0029",
				"rts_Zombie_0030",
				"rts_Zombie_0031",
				"rts_Zombie_0032",
				"rts_Zombie_0033",
				"rts_Zombie_0034",
				"rts_Zombie_0035",
				"rts_Zombie_0036",
				"rts_Zombie_0037",
				"rts_Zombie_0038",
				"rts_Zombie_0039",
				"rts_Zombie_0040",
				"rts_Zombie_0041",
				"rts_Zombie_0042",
				"rts_Zombie_0043",
				"rts_Zombie_0028",
				"rts_Zombie_0029",
				"rts_Zombie_0030",
				"rts_Zombie_0031",
				"rts_Zombie_0032",
				"rts_Zombie_0033",
				"rts_Zombie_0034",
				"rts_Zombie_0035",
				"rts_Zombie_0036",
				"rts_Zombie_0037",
				"rts_Zombie_0038",
				"rts_Zombie_0039",
				"rts_Zombie_0040",
				"rts_Zombie_0041",
				"rts_Zombie_0042",
				"rts_Zombie_0043",
				"rts_Zombie_0028",
				"rts_Zombie_0029",
				"rts_Zombie_0030",
				"rts_Zombie_0031",
				"rts_Zombie_0032",
				"rts_Zombie_0033",
				"rts_Zombie_0034",
				"rts_Zombie_0035",
				"rts_Zombie_0036",
				"rts_Zombie_0037",
				"rts_Zombie_0038",
				"rts_Zombie_0039",
				"rts_Zombie_0040",
				"rts_Zombie_0041",
				"rts_Zombie_0042",
				"rts_Zombie_0043",
			},
		},
		caution = {
			groupA = {
				"rts_Zombie_0028",
				"rts_Zombie_0029",
				"rts_Zombie_0030",
				"rts_Zombie_0031",
				"rts_Zombie_0032",
				"rts_Zombie_0033",
				"rts_Zombie_0034",
				"rts_Zombie_0035",
				"rts_Zombie_0036",
				"rts_Zombie_0037",
				"rts_Zombie_0038",
				"rts_Zombie_0039",
				"rts_Zombie_0040",
				"rts_Zombie_0041",
				"rts_Zombie_0042",
				"rts_Zombie_0043",
				"rts_Zombie_0028",
				"rts_Zombie_0029",
				"rts_Zombie_0030",
				"rts_Zombie_0031",
				"rts_Zombie_0032",
				"rts_Zombie_0033",
				"rts_Zombie_0034",
				"rts_Zombie_0035",
				"rts_Zombie_0036",
				"rts_Zombie_0037",
				"rts_Zombie_0038",
				"rts_Zombie_0039",
				"rts_Zombie_0040",
				"rts_Zombie_0041",
				"rts_Zombie_0042",
				"rts_Zombie_0043",
				"rts_Zombie_0028",
				"rts_Zombie_0029",
				"rts_Zombie_0030",
				"rts_Zombie_0031",
				"rts_Zombie_0032",
				"rts_Zombie_0033",
				"rts_Zombie_0034",
				"rts_Zombie_0035",
				"rts_Zombie_0036",
				"rts_Zombie_0037",
				"rts_Zombie_0038",
				"rts_Zombie_0039",
				"rts_Zombie_0040",
				"rts_Zombie_0041",
				"rts_Zombie_0042",
				"rts_Zombie_0043",
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
		nil
	},
	nil
}


this.routeSets02 = {
	
	mafr_lab_cp			= { USE_COMMON_ROUTE_SETS = true,	},

	mafr_lab_w_cp = {
		
		
		
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_lab_w_0000",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
				"rts_lab_w_0005",
				"rts_lab_w_0006",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
				"rts_lab_w_0005",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
			},
		},
		sneak_night= {
			groupA = {
				"rts_lab_w_0000",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
				"rts_lab_w_0005",
				"rts_lab_w_0006",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
				"rts_lab_w_0005",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
			},
		},
		caution = {
			groupA = {
				"rts_lab_w_0000",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
				"rts_lab_w_0005",
				"rts_lab_w_0006",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
				"rts_lab_w_0005",
				"rts_lab_w_0001",
				"rts_lab_w_0002",
				"rts_lab_w_0003",
				"rts_lab_w_0004",
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
		nil
	},
	mafr_lab_s_cp = {
		
		
		
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_lab_s_0000",
				"rts_lab_s_0001",
				"rts_lab_s_0002",
				"rts_lab_s_0003",
				"rts_lab_s_0004",
				"rts_lab_s_0005",
				"rts_lab_s_0006",
				"rts_lab_s_0007",
				"rts_lab_s_0008",
				"rts_lab_s_0009",
				"rts_lab_s_0010",
				"rts_lab_s_0011",
				"rts_lab_s_0012",
				"rts_lab_s_0013",
				"rts_lab_s_0014",
				"rts_lab_s_0015",
				"rts_lab_s_0016",
				"rts_lab_s_0017",
				"rts_lab_s_0018",
				"rts_lab_s_0019",
				"rts_lab_s_0020",
				"rts_lab_s_0021",
				"rts_lab_s_0022",
				"rts_lab_s_0023",
				"rts_lab_s_0000",
				"rts_lab_s_0001",
				"rts_lab_s_0002",
				"rts_lab_s_0003",
				"rts_lab_s_0004",
				"rts_lab_s_0005",
				"rts_lab_s_0006",
				"rts_lab_s_0007",
				"rts_lab_s_0008",
				"rts_lab_s_0009",
				"rts_lab_s_0010",
				"rts_lab_s_0011",
				"rts_lab_s_0012",
				"rts_lab_s_0013",
				"rts_lab_s_0014",
				"rts_lab_s_0015",
				"rts_lab_s_0016",
				"rts_lab_s_0017",
				"rts_lab_s_0018",
				"rts_lab_s_0019",
				"rts_lab_s_0020",
				"rts_lab_s_0021",
				"rts_lab_s_0022",
				"rts_lab_s_0023",
			},
		},
		sneak_night= {
			groupA = {
				"rts_lab_s_0000",
				"rts_lab_s_0001",
				"rts_lab_s_0002",
				"rts_lab_s_0003",
				"rts_lab_s_0004",
				"rts_lab_s_0005",
				"rts_lab_s_0006",
				"rts_lab_s_0007",
				"rts_lab_s_0008",
				"rts_lab_s_0009",
				"rts_lab_s_0010",
				"rts_lab_s_0011",
				"rts_lab_s_0012",
				"rts_lab_s_0013",
				"rts_lab_s_0014",
				"rts_lab_s_0015",
				"rts_lab_s_0016",
				"rts_lab_s_0017",
				"rts_lab_s_0018",
				"rts_lab_s_0019",
				"rts_lab_s_0020",
				"rts_lab_s_0021",
				"rts_lab_s_0022",
				"rts_lab_s_0023",
				"rts_lab_s_0000",
				"rts_lab_s_0001",
				"rts_lab_s_0002",
				"rts_lab_s_0003",
				"rts_lab_s_0004",
				"rts_lab_s_0005",
				"rts_lab_s_0006",
				"rts_lab_s_0007",
				"rts_lab_s_0008",
				"rts_lab_s_0009",
				"rts_lab_s_0010",
				"rts_lab_s_0011",
				"rts_lab_s_0012",
				"rts_lab_s_0013",
				"rts_lab_s_0014",
				"rts_lab_s_0015",
				"rts_lab_s_0016",
				"rts_lab_s_0017",
				"rts_lab_s_0018",
				"rts_lab_s_0019",
				"rts_lab_s_0020",
				"rts_lab_s_0021",
				"rts_lab_s_0022",
				"rts_lab_s_0023",
			},
		},
		caution = {
			groupA = {
				"rts_lab_s_0000",
				"rts_lab_s_0001",
				"rts_lab_s_0002",
				"rts_lab_s_0003",
				"rts_lab_s_0004",
				"rts_lab_s_0005",
				"rts_lab_s_0006",
				"rts_lab_s_0007",
				"rts_lab_s_0008",
				"rts_lab_s_0009",
				"rts_lab_s_0010",
				"rts_lab_s_0011",
				"rts_lab_s_0012",
				"rts_lab_s_0013",
				"rts_lab_s_0014",
				"rts_lab_s_0015",
				"rts_lab_s_0016",
				"rts_lab_s_0017",
				"rts_lab_s_0018",
				"rts_lab_s_0019",
				"rts_lab_s_0020",
				"rts_lab_s_0021",
				"rts_lab_s_0022",
				"rts_lab_s_0023",
				"rts_lab_s_0000",
				"rts_lab_s_0001",
				"rts_lab_s_0002",
				"rts_lab_s_0003",
				"rts_lab_s_0004",
				"rts_lab_s_0005",
				"rts_lab_s_0006",
				"rts_lab_s_0007",
				"rts_lab_s_0008",
				"rts_lab_s_0009",
				"rts_lab_s_0010",
				"rts_lab_s_0011",
				"rts_lab_s_0012",
				"rts_lab_s_0013",
				"rts_lab_s_0014",
				"rts_lab_s_0015",
				"rts_lab_s_0016",
				"rts_lab_s_0017",
				"rts_lab_s_0018",
				"rts_lab_s_0019",
				"rts_lab_s_0020",
				"rts_lab_s_0021",
				"rts_lab_s_0022",
				"rts_lab_s_0023",
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
		nil
	},
	nil
}




this.combatSetting = {
	mafr_lab_cp = {
		"gts_lab_0000",
		"css_lab_0000",
	},
	mafr_lab_w_cp = {
		"gts_lab_w_0000",
		"css_lab_w_0000",
	},
	mafr_lab_s_cp = {
		"gts_lab_s_0000",
		"css_lab_s_0000",
	},
	nil
}




this.cpIdList = {
	"mafr_lab_cp",
	"mafr_lab_w_cp",
	"mafr_lab_s_cp",
	nil
}




this.zombieRoute01 = {
	{ soldierName = "sol_lab_0000",routeName="rts_Zombie_0000" },
	{ soldierName = "sol_lab_0001",routeName="rts_Zombie_0001" },
	{ soldierName = "sol_lab_0002",routeName="rts_Zombie_0002" },
	{ soldierName = "sol_lab_0003",routeName="rts_Zombie_0003" },
	{ soldierName = "sol_lab_0004",routeName="rts_Zombie_0004" },
	{ soldierName = "sol_lab_0005",routeName="rts_Zombie_0005" },
	{ soldierName = "sol_lab_0006",routeName="rts_Zombie_0006" },
	{ soldierName = "sol_lab_0007",routeName="rts_Zombie_0007" },
	{ soldierName = "sol_lab_0008",routeName="rts_Zombie_0008" },
	{ soldierName = "sol_lab_0009",routeName="rts_Zombie_0009" },
	{ soldierName = "sol_lab_0010",routeName="rts_Zombie_0010" },
	{ soldierName = "sol_lab_0011",routeName="rts_Zombie_0011" },

	{ soldierName = "sol_lab_0012",routeName="rts_Zombie_0012" },
	{ soldierName = "sol_lab_0013",routeName="rts_Zombie_0013" },
	{ soldierName = "sol_lab_0014",routeName="rts_Zombie_0014" },
	{ soldierName = "sol_lab_0015",routeName="rts_Zombie_0015" },
	{ soldierName = "sol_lab_0016",routeName="rts_Zombie_0016" },
	{ soldierName = "sol_lab_0017",routeName="rts_Zombie_0017" },
	{ soldierName = "sol_lab_0018",routeName="rts_Zombie_0018" },
	{ soldierName = "sol_lab_0019",routeName="rts_Zombie_0019" },
	{ soldierName = "sol_lab_0020",routeName="rts_Zombie_0020" },
	{ soldierName = "sol_lab_0021",routeName="rts_Zombie_0021" },
	{ soldierName = "sol_lab_0022",routeName="rts_Zombie_0022" },
	{ soldierName = "sol_lab_0023",routeName="rts_Zombie_0023" },
	{ soldierName = "sol_lab_0024",routeName="rts_Zombie_0024" },
	{ soldierName = "sol_lab_0025",routeName="rts_Zombie_0025" },
	{ soldierName = "sol_lab_0026",routeName="rts_Zombie_0026" },
	{ soldierName = "sol_lab_0027",routeName="rts_Zombie_0027" },
	{ soldierName = "sol_lab_0028",routeName="rts_Zombie_0028" },
	{ soldierName = "sol_lab_0029",routeName="rts_Zombie_0029" },
	{ soldierName = "sol_lab_0030",routeName="rts_Zombie_0030" },
	{ soldierName = "sol_lab_0031",routeName="rts_Zombie_0031" },
	{ soldierName = "sol_lab_0032",routeName="rts_Zombie_0032" },
	{ soldierName = "sol_lab_0033",routeName="rts_Zombie_0033" },
	{ soldierName = "sol_lab_0034",routeName="rts_Zombie_0034" },
	{ soldierName = "sol_lab_0035",routeName="rts_Zombie_0035" },
	{ soldierName = "sol_lab_0036",routeName="rts_Zombie_0036" },
	{ soldierName = "sol_lab_0037",routeName="rts_Zombie_0037" },
	{ soldierName = "sol_lab_0038",routeName="rts_Zombie_0038" },
	{ soldierName = "sol_lab_0039",routeName="rts_Zombie_0039" },
	{ soldierName = "sol_lab_0040",routeName="rts_Zombie_0040" },
	{ soldierName = "sol_lab_0041",routeName="rts_Zombie_0041" },
	{ soldierName = "sol_lab_0042",routeName="rts_Zombie_0042" },
	{ soldierName = "sol_lab_0043",routeName="rts_Zombie_0043" },

	{ soldierName = "sol_lab_0044",routeName="rts_Zombie_0012" },
	{ soldierName = "sol_lab_0045",routeName="rts_Zombie_0013" },
	{ soldierName = "sol_lab_0046",routeName="rts_Zombie_0014" },
	{ soldierName = "sol_lab_0047",routeName="rts_Zombie_0015" },
	{ soldierName = "sol_lab_0048",routeName="rts_Zombie_0016" },
	{ soldierName = "sol_lab_0049",routeName="rts_Zombie_0017" },
	{ soldierName = "sol_lab_0050",routeName="rts_Zombie_0018" },
	{ soldierName = "sol_lab_0051",routeName="rts_Zombie_0019" },
	{ soldierName = "sol_lab_0052",routeName="rts_Zombie_0020" },
	{ soldierName = "sol_lab_0053",routeName="rts_Zombie_0021" },
	{ soldierName = "sol_lab_0054",routeName="rts_Zombie_0022" },
	{ soldierName = "sol_lab_0055",routeName="rts_Zombie_0023" },
	{ soldierName = "sol_lab_0056",routeName="rts_Zombie_0024" },
	{ soldierName = "sol_lab_0057",routeName="rts_Zombie_0025" },
	{ soldierName = "sol_lab_0058",routeName="rts_Zombie_0026" },
	{ soldierName = "sol_lab_0059",routeName="rts_Zombie_0027" },
	{ soldierName = "sol_lab_0060",routeName="rts_Zombie_0028" },
	{ soldierName = "sol_lab_0061",routeName="rts_Zombie_0029" },
	{ soldierName = "sol_lab_0062",routeName="rts_Zombie_0030" },
	{ soldierName = "sol_lab_0063",routeName="rts_Zombie_0031" },
	{ soldierName = "sol_lab_0064",routeName="rts_Zombie_0032" },
	{ soldierName = "sol_lab_0065",routeName="rts_Zombie_0033" },
	{ soldierName = "sol_lab_0066",routeName="rts_Zombie_0034" },
	{ soldierName = "sol_lab_0067",routeName="rts_Zombie_0035" },
	{ soldierName = "sol_lab_0068",routeName="rts_Zombie_0036" },
	{ soldierName = "sol_lab_0069",routeName="rts_Zombie_0037" },
	{ soldierName = "sol_lab_0070",routeName="rts_Zombie_0038" },
	{ soldierName = "sol_lab_0071",routeName="rts_Zombie_0039" },
	{ soldierName = "sol_lab_0072",routeName="rts_Zombie_0040" },
	{ soldierName = "sol_lab_0073",routeName="rts_Zombie_0041" },
	{ soldierName = "sol_lab_0074",routeName="rts_Zombie_0042" },
	{ soldierName = "sol_lab_0075",routeName="rts_Zombie_0043" },

	{ soldierName = "sol_lab_0076",routeName="rts_Zombie_0012" },
	{ soldierName = "sol_lab_0077",routeName="rts_Zombie_0013" },
	{ soldierName = "sol_lab_0078",routeName="rts_Zombie_0014" },
	{ soldierName = "sol_lab_0079",routeName="rts_Zombie_0015" },
	{ soldierName = "sol_lab_0080",routeName="rts_Zombie_0016" },
	{ soldierName = "sol_lab_0081",routeName="rts_Zombie_0017" },
	{ soldierName = "sol_lab_0082",routeName="rts_Zombie_0018" },
	{ soldierName = "sol_lab_0083",routeName="rts_Zombie_0019" },
	{ soldierName = "sol_lab_0084",routeName="rts_Zombie_0020" },
	{ soldierName = "sol_lab_0085",routeName="rts_Zombie_0021" },
	{ soldierName = "sol_lab_0086",routeName="rts_Zombie_0022" },
	{ soldierName = "sol_lab_0087",routeName="rts_Zombie_0023" },
	{ soldierName = "sol_lab_0088",routeName="rts_Zombie_0024" },
	{ soldierName = "sol_lab_0089",routeName="rts_Zombie_0025" },
	{ soldierName = "sol_lab_0090",routeName="rts_Zombie_0026" },
	{ soldierName = "sol_lab_0091",routeName="rts_Zombie_0027" },
	{ soldierName = "sol_lab_0092",routeName="rts_Zombie_0028" },
	{ soldierName = "sol_lab_0093",routeName="rts_Zombie_0029" },
	{ soldierName = "sol_lab_0094",routeName="rts_Zombie_0030" },
	{ soldierName = "sol_lab_0095",routeName="rts_Zombie_0031" },
	{ soldierName = "sol_lab_0096",routeName="rts_Zombie_0032" },
	{ soldierName = "sol_lab_0097",routeName="rts_Zombie_0033" },
	{ soldierName = "sol_lab_0098",routeName="rts_Zombie_0034" },
	{ soldierName = "sol_lab_0099",routeName="rts_Zombie_0035" },
	{ soldierName = "sol_lab_0100",routeName="rts_Zombie_0036" },
	{ soldierName = "sol_lab_0101",routeName="rts_Zombie_0037" },
	{ soldierName = "sol_lab_0102",routeName="rts_Zombie_0038" },
	{ soldierName = "sol_lab_0103",routeName="rts_Zombie_0039" },
	{ soldierName = "sol_lab_0104",routeName="rts_Zombie_0040" },
	{ soldierName = "sol_lab_0105",routeName="rts_Zombie_0041" },
	{ soldierName = "sol_lab_0106",routeName="rts_Zombie_0042" },
	{ soldierName = "sol_lab_0107",routeName="rts_Zombie_0043" },
	nil
}

this.zombieRoute02 = {
	{ soldierName = "sol_lab_0000",routeName="rt_lab_c_0000" },
	{ soldierName = "sol_lab_0001",routeName="rt_lab_c_0001" },
	{ soldierName = "sol_lab_0002",routeName="rt_lab_c_0002" },
	{ soldierName = "sol_lab_0003",routeName="rt_lab_c_0004" },
	{ soldierName = "sol_lab_0004",routeName="rt_lab_c_0005" },
	{ soldierName = "sol_lab_0005",routeName="rt_lab_c_0008" },
	{ soldierName = "sol_lab_0006",routeName="rt_lab_c_0009" },
	{ soldierName = "sol_lab_0007",routeName="rt_lab_c_0000" },
	{ soldierName = "sol_lab_0008",routeName="rt_lab_c_0001" },
	{ soldierName = "sol_lab_0009",routeName="rt_lab_c_0003" },
	{ soldierName = "sol_lab_0010",routeName="rt_lab_c_0004" },
	{ soldierName = "sol_lab_0011",routeName="rt_lab_c_0005" },
	{ soldierName = "sol_lab_0012",routeName="rts_lab_w_0000" },
	{ soldierName = "sol_lab_0013",routeName="rts_lab_w_0001" },
	{ soldierName = "sol_lab_0014",routeName="rts_lab_w_0002" },
	{ soldierName = "sol_lab_0015",routeName="rts_lab_w_0003" },
	{ soldierName = "sol_lab_0016",routeName="rts_lab_w_0004" },
	{ soldierName = "sol_lab_0017",routeName="rts_lab_w_0005" },
	{ soldierName = "sol_lab_0018",routeName="rts_lab_w_0006" },
	{ soldierName = "sol_lab_0019",routeName="rts_lab_w_0007" },
	{ soldierName = "sol_lab_0020",routeName="rts_lab_w_0008" },
	{ soldierName = "sol_lab_0021",routeName="rts_lab_w_0009" },
	{ soldierName = "sol_lab_0022",routeName="rts_lab_w_0010" },
	{ soldierName = "sol_lab_0023",routeName="rts_lab_w_0011" },
	{ soldierName = "sol_lab_0024",routeName="rts_lab_w_0012" },
	{ soldierName = "sol_lab_0025",routeName="rts_lab_w_0013" },
	{ soldierName = "sol_lab_0026",routeName="rts_lab_w_0014" },
	{ soldierName = "sol_lab_0027",routeName="rts_lab_w_0015" },
	{ soldierName = "sol_lab_0028",routeName="rts_lab_w_0016" },
	{ soldierName = "sol_lab_0029",routeName="rts_lab_w_0017" },
	{ soldierName = "sol_lab_0030",routeName="rts_lab_w_0018" },
	{ soldierName = "sol_lab_0031",routeName="rts_lab_w_0019" },
	{ soldierName = "sol_lab_0032",routeName="rts_lab_w_0020" },
	{ soldierName = "sol_lab_0033",routeName="rts_lab_w_0021" },
	{ soldierName = "sol_lab_0034",routeName="rts_lab_w_0022" },
	{ soldierName = "sol_lab_0035",routeName="rts_lab_w_0023" },
	{ soldierName = "sol_lab_0036",routeName="rts_lab_w_0000" },
	{ soldierName = "sol_lab_0037",routeName="rts_lab_w_0001" },
	{ soldierName = "sol_lab_0038",routeName="rts_lab_w_0002" },
	{ soldierName = "sol_lab_0039",routeName="rts_lab_w_0003" },
	{ soldierName = "sol_lab_0040",routeName="rts_lab_w_0004" },
	{ soldierName = "sol_lab_0041",routeName="rts_lab_w_0005" },
	{ soldierName = "sol_lab_0042",routeName="rts_lab_w_0006" },
	{ soldierName = "sol_lab_0043",routeName="rts_lab_w_0007" },
	{ soldierName = "sol_lab_0044",routeName="rts_lab_w_0008" },
	{ soldierName = "sol_lab_0045",routeName="rts_lab_w_0009" },
	{ soldierName = "sol_lab_0046",routeName="rts_lab_w_0010" },
	{ soldierName = "sol_lab_0047",routeName="rts_lab_w_0011" },
	{ soldierName = "sol_lab_0048",routeName="rts_lab_w_0012" },
	{ soldierName = "sol_lab_0049",routeName="rts_lab_w_0013" },
	{ soldierName = "sol_lab_0050",routeName="rts_lab_w_0014" },
	{ soldierName = "sol_lab_0051",routeName="rts_lab_w_0015" },
	{ soldierName = "sol_lab_0052",routeName="rts_lab_w_0016" },
	{ soldierName = "sol_lab_0053",routeName="rts_lab_w_0017" },
	{ soldierName = "sol_lab_0054",routeName="rts_lab_w_0018" },
	{ soldierName = "sol_lab_0055",routeName="rts_lab_w_0019" },
	{ soldierName = "sol_lab_0056",routeName="rts_lab_w_0020" },
	{ soldierName = "sol_lab_0057",routeName="rts_lab_w_0021" },
	{ soldierName = "sol_lab_0058",routeName="rts_lab_w_0022" },
	{ soldierName = "sol_lab_0059",routeName="rts_lab_w_0023" },
	{ soldierName = "sol_lab_0060",routeName="rts_lab_s_0000" },
	{ soldierName = "sol_lab_0061",routeName="rts_lab_s_0001" },
	{ soldierName = "sol_lab_0062",routeName="rts_lab_s_0002" },
	{ soldierName = "sol_lab_0063",routeName="rts_lab_s_0003" },
	{ soldierName = "sol_lab_0064",routeName="rts_lab_s_0004" },
	{ soldierName = "sol_lab_0065",routeName="rts_lab_s_0005" },
	{ soldierName = "sol_lab_0066",routeName="rts_lab_s_0006" },
	{ soldierName = "sol_lab_0067",routeName="rts_lab_s_0007" },
	{ soldierName = "sol_lab_0068",routeName="rts_lab_s_0008" },
	{ soldierName = "sol_lab_0069",routeName="rts_lab_s_0009" },
	{ soldierName = "sol_lab_0070",routeName="rts_lab_s_0010" },
	{ soldierName = "sol_lab_0071",routeName="rts_lab_s_0011" },
	{ soldierName = "sol_lab_0072",routeName="rts_lab_s_0012" },
	{ soldierName = "sol_lab_0073",routeName="rts_lab_s_0013" },
	{ soldierName = "sol_lab_0074",routeName="rts_lab_s_0014" },
	{ soldierName = "sol_lab_0075",routeName="rts_lab_s_0015" },
	{ soldierName = "sol_lab_0076",routeName="rts_lab_s_0016" },
	{ soldierName = "sol_lab_0077",routeName="rts_lab_s_0017" },
	{ soldierName = "sol_lab_0078",routeName="rts_lab_s_0018" },
	{ soldierName = "sol_lab_0079",routeName="rts_lab_s_0019" },
	{ soldierName = "sol_lab_0080",routeName="rts_lab_s_0020" },
	{ soldierName = "sol_lab_0081",routeName="rts_lab_s_0021" },
	{ soldierName = "sol_lab_0082",routeName="rts_lab_s_0022" },
	{ soldierName = "sol_lab_0083",routeName="rts_lab_s_0023" },
	{ soldierName = "sol_lab_0084",routeName="rts_lab_s_0000" },
	{ soldierName = "sol_lab_0085",routeName="rts_lab_s_0001" },
	{ soldierName = "sol_lab_0086",routeName="rts_lab_s_0002" },
	{ soldierName = "sol_lab_0087",routeName="rts_lab_s_0003" },
	{ soldierName = "sol_lab_0088",routeName="rts_lab_s_0004" },
	{ soldierName = "sol_lab_0089",routeName="rts_lab_s_0005" },
	{ soldierName = "sol_lab_0090",routeName="rts_lab_s_0006" },
	{ soldierName = "sol_lab_0091",routeName="rts_lab_s_0007" },
	{ soldierName = "sol_lab_0092",routeName="rts_lab_s_0008" },
	{ soldierName = "sol_lab_0093",routeName="rts_lab_s_0009" },
	{ soldierName = "sol_lab_0094",routeName="rts_lab_s_0010" },
	{ soldierName = "sol_lab_0095",routeName="rts_lab_s_0011" },
	{ soldierName = "sol_lab_0096",routeName="rts_lab_s_0012" },
	{ soldierName = "sol_lab_0097",routeName="rts_lab_s_0013" },
	{ soldierName = "sol_lab_0098",routeName="rts_lab_s_0014" },
	{ soldierName = "sol_lab_0099",routeName="rts_lab_s_0015" },
	{ soldierName = "sol_lab_0100",routeName="rts_lab_s_0016" },
	{ soldierName = "sol_lab_0101",routeName="rts_lab_s_0017" },
	{ soldierName = "sol_lab_0102",routeName="rts_lab_s_0018" },
	{ soldierName = "sol_lab_0103",routeName="rts_lab_s_0019" },
	{ soldierName = "sol_lab_0104",routeName="rts_lab_s_0020" },
	{ soldierName = "sol_lab_0105",routeName="rts_lab_s_0021" },
	{ soldierName = "sol_lab_0106",routeName="rts_lab_s_0022" },
	{ soldierName = "sol_lab_0107",routeName="rts_lab_s_0023" },
	nil
}






this.useGeneInter = {
	
	mafr_lab_cp = false,
	mafr_lab_w_cp = true,
	mafr_lab_s_cp = true,
	nil
}


this.InterCall_codetalker_pos01 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_codetalker_pos01")
	
	s10130_sequence.DoorPlaceMark()
end

this.InterCall_codetalker_pos02 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_codetalker_pos02")
	
	s10130_sequence.CodeTalkerPlaceMark()
end


this.interrogation = {

	
	mafr_lab_cp = {
		
		high = {
			{ name = "enqt3000_1e1010", func = this.InterCall_codetalker_pos01, },
			{ name = "enqt3000_1f1010", func = this.InterCall_codetalker_pos02, },
			nil
		},
		nil
	},
	nil
}




this.cpGroups = {
	group_Area5 = {
		
		"mafr_lab_cp",
		

		
		
		"mafr_lab_w_cp",
		"mafr_lab_s_cp",
	},
}






this.InitEnemy = function ()
end



this.SetUpEnemy = function ()

	
	local obSetCommand = { id = "SetOuterBaseCp" }
	GameObject.SendCommand( GameObject.GetGameObjectId( "mafr_lab_s_cp" ) , obSetCommand )
	GameObject.SendCommand( GameObject.GetGameObjectId( "mafr_lab_w_cp" ) , obSetCommand )

	
	TppEnemy.SetRescueTargets( { "CodeTalker" } )

	
	Fox.Log("!!!*** s10130_enemy.SetUpCamoParasiteSeq01 ***!!!")
	this.SetUpCamoParasiteSeq01()

	
	this.CamoParasiteFogOff()

	
	this.CamoParasiteFultonCheck()

	
	TppEnemy.RegisterCombatSetting( this.combatSetting )

	
	this.FormationLine()

end


this.OnLoad = function ()
	Fox.Log("*** s10130 onload ***")
end





function this.SetUpCamoParasite( ParasiteName, AttackRoute, RunRoute )

	local command = {id="SetSnipeRoute", route="route", phase="phase"}
	local gameObjectId = GameObject.GetGameObjectId("TppBossQuiet2", ParasiteName)
	if gameObjectId ~= GameObject.NULL_ID then
		command.route = AttackRoute
		command.phase = 0
		GameObject.SendCommand(gameObjectId, command)
		command.route = RunRoute
		command.phase = 1
		GameObject.SendCommand(gameObjectId, command)
	end

end


function this.SetUpCamoParasiteRelay( ParasiteName, RelayRoute )

	local command = { id="SetLandingRoute", route="route" }
	local gameObjectId = GameObject.GetGameObjectId("TppBossQuiet2", ParasiteName)
	if gameObjectId ~= GameObject.NULL_ID then
		command.route = RelayRoute
		GameObject.SendCommand(gameObjectId, command)
	end

end


function this.SetUpCamoParasiteKill( ParasiteName, KillRoute )

	local command = { id="SetKillRoute", route="route" }
	local gameObjectId = GameObject.GetGameObjectId("TppBossQuiet2", ParasiteName)
	if gameObjectId ~= GameObject.NULL_ID then
		command.route = KillRoute
		GameObject.SendCommand(gameObjectId, command)
	end

end


function this.SetUpCamoParasiteDead( ParasiteName, DeadRoute )

	local command = { id="SetDemoRoute", route="route" }
	local gameObjectId = GameObject.GetGameObjectId("TppBossQuiet2", ParasiteName)
	if gameObjectId ~= GameObject.NULL_ID then
		command.route = DeadRoute
		GameObject.SendCommand(gameObjectId, command)
	end

end


function this.SetUpCamoParasiteResetAI( ParasiteName )

	local command = { id="ResetAI" }
	local gameObjectId = GameObject.GetGameObjectId("TppBossQuiet2", ParasiteName)
	if gameObjectId ~= GameObject.NULL_ID then
		GameObject.SendCommand(gameObjectId, command)
	end

end


function this.SetUpCamoParasiteClearingOn( ParasiteName )

	local command = { id="NarrowFarSight", enabled="enabled" }
	local gameObjectId = GameObject.GetGameObjectId("TppBossQuiet2", ParasiteName)
	if gameObjectId ~= GameObject.NULL_ID then
		command.enabled = true
		GameObject.SendCommand(gameObjectId, command)
	end

end


function this.SetUpCamoParasiteClearingOff( ParasiteName )

	local command = { id="NarrowFarSight", enabled="enabled" }
	local gameObjectId = GameObject.GetGameObjectId("TppBossQuiet2", ParasiteName)
	if gameObjectId ~= GameObject.NULL_ID then
		command.enabled = false
		GameObject.SendCommand(gameObjectId, command)
	end

end


function this.ResetPositionCamoParasite()

	local gameObjectId = { type="TppBossQuiet2" }
	local command = { id="ResetPosition" }
	GameObject.SendCommand( gameObjectId, command )

end


function this.WarpCamoParasite( ParasiteName, ParasitePos, ParasiteRotY )




	local gameObjectId = GameObject.GetGameObjectId("TppBossQuiet2", ParasiteName)
	local command = { id = "WarpRequest", pos=ParasitePos, rotY=ParasiteRotY }
	GameObject.SendCommand( gameObjectId, command )

end


function this.WarpCamoParasiteJungle()

	this.WarpCamoParasite( "wmu_lab_0000", {2556.281, 117.820, -2076.318}, 0 )
	this.WarpCamoParasite( "wmu_lab_0001", {2601.633, 128.814, -2072.811}, 0 )
	this.WarpCamoParasite( "wmu_lab_0002", {2675.445, 139.116, -2079.545}, 0 )
	this.WarpCamoParasite( "wmu_lab_0003", {2732.616, 144.194, -2066.199}, 0 )

end


function this.WarpCamoParasiteSeq02()

	this.WarpCamoParasite( "wmu_lab_0000", {2561.025,196.274,-2415.062}, 0 )
	this.WarpCamoParasite( "wmu_lab_0001", {2598.337,126.9555,-2098.653}, 0 )
	this.WarpCamoParasite( "wmu_lab_0002", {2561.239,196.1814,-2405.197}, 0 )
	this.WarpCamoParasite( "wmu_lab_0003", {2677.726,139.3948,-2100.455}, 0 )

end


function this.ChaseCamoParasiteWest()

	this.WarpCamoParasite( "wmu_lab_0001", {2690.052, 175.114, -2478.285}, 0 )
	this.WarpCamoParasite( "wmu_lab_0003", {2690.052, 175.114, -2478.285}, 0 )

	this.SetUpCamoParasite( "wmu_lab_0001", "rts_Parasite01_P02_Chase" ,"rts_Parasite01_P02_Chase" )
	this.SetUpCamoParasite( "wmu_lab_0003", "rts_Parasite03_P02_Chase" ,"rts_Parasite03_P02_Chase" )

end


function this.ChaseCamoParasiteSouth()

	this.WarpCamoParasite( "wmu_lab_0000", {2692.550, 157.386, -2345.479}, 0 )
	this.WarpCamoParasite( "wmu_lab_0002", {2692.550, 157.386, -2345.479}, 0 )

	this.SetUpCamoParasite( "wmu_lab_0000", "rts_Parasite00_P02_Chase" ,"rts_Parasite00_P02_Chase" )
	this.SetUpCamoParasite( "wmu_lab_0002", "rts_Parasite02_P02_Chase" ,"rts_Parasite02_P02_Chase" )

end


function this.ReturnCamoParasiteWest()

	this.WarpCamoParasite( "wmu_lab_0001", {2598.337,126.9555,-2098.653}, 0 )
	this.WarpCamoParasite( "wmu_lab_0003", {2677.726,139.3948,-2100.455}, 0 )

	this.SetUpCamoParasite( "wmu_lab_0001", "rts_Parasite01_P02_Combat0001" ,"rts_Parasite01_P02_Combat0001" )
	this.SetUpCamoParasite( "wmu_lab_0003", "rts_Parasite03_P02_Combat0001" ,"rts_Parasite03_P02_Combat0001" )


end


function this.ReturnCamoParasiteSouth()

	this.WarpCamoParasite( "wmu_lab_0000", {2561.025,196.274,-2415.062}, 0 )
	this.WarpCamoParasite( "wmu_lab_0002", {2561.239,196.1814,-2405.197}, 0 )

	this.SetUpCamoParasite( "wmu_lab_0000", "rts_Parasite00_P02_Combat0001" ,"rts_Parasite00_P02_Combat0001" )
	this.SetUpCamoParasite( "wmu_lab_0002", "rts_Parasite02_P02_Combat0001" ,"rts_Parasite02_P02_Combat0001" )

end


function this.SetUpCamoParasiteSeq01()

	this.SetUpCamoParasite( "wmu_lab_0000", "rts_Parasite00_P01_Start" ,"rts_Parasite00_P01_Start" )
	this.SetUpCamoParasite( "wmu_lab_0001", "rts_Parasite01_P01_Start" ,"rts_Parasite01_P01_Start" )
	this.SetUpCamoParasite( "wmu_lab_0002", "rts_Parasite02_P01_Start" ,"rts_Parasite02_P01_Start" )
	this.SetUpCamoParasite( "wmu_lab_0003", "rts_Parasite03_P01_Start" ,"rts_Parasite03_P01_Start" )

end


function this.CombatCamoParasiteSeq01BeforeDemo()

	Fox.Log( "!!!! s10130_enemy.CombatCamoParasiteSeq01 Before Demo !!!!" )

	this.SetUpCamoParasite( "wmu_lab_0000", "rts_Parasite00_P01_Combat0001" ,"rts_Parasite00_P01_Combat0002" )
	this.SetUpCamoParasite( "wmu_lab_0001", "rts_Parasite01_P01_Combat0001" ,"rts_Parasite01_P01_Combat0002" )
	this.SetUpCamoParasite( "wmu_lab_0002", "rts_Parasite02_P01_Combat0001" ,"rts_Parasite02_P01_Combat0002" )
	this.SetUpCamoParasite( "wmu_lab_0003", "rts_Parasite03_P01_Combat0001" ,"rts_Parasite03_P01_Combat0002" )

	this.SetUpCamoParasiteRelay( "wmu_lab_0000", "rts_Parasite00_P01_Relay" )
	this.SetUpCamoParasiteRelay( "wmu_lab_0001", "rts_Parasite01_P01_Relay" )
	this.SetUpCamoParasiteRelay( "wmu_lab_0002", "rts_Parasite02_P01_Relay" )
	this.SetUpCamoParasiteRelay( "wmu_lab_0003", "rts_Parasite03_P01_Relay" )

	this.SetUpCamoParasiteKill( "wmu_lab_0000", "rts_Parasite00_P01_Kill0001" )
	this.SetUpCamoParasiteKill( "wmu_lab_0001", "rts_Parasite01_P01_Kill0001" )
	this.SetUpCamoParasiteKill( "wmu_lab_0002", "rts_Parasite02_P01_Kill0001" )
	this.SetUpCamoParasiteKill( "wmu_lab_0003", "rts_Parasite03_P01_Kill0001" )

	this.SetUpCamoParasiteDead( "wmu_lab_0000", "rts_Parasite00_P01_Dead" )
	this.SetUpCamoParasiteDead( "wmu_lab_0001", "rts_Parasite01_P01_Dead" )
	this.SetUpCamoParasiteDead( "wmu_lab_0002", "rts_Parasite02_P01_Dead" )
	this.SetUpCamoParasiteDead( "wmu_lab_0003", "rts_Parasite03_P01_Dead" )

end


function this.CombatCamoParasiteSeq01()

	Fox.Log( "!!!! s10130_enemy.CombatCamoParasiteSeq01 !!!!" )

	this.CombatCamoParasiteSeq01BeforeDemo()

	this.WarpCamoParasite( "wmu_lab_0002", {2627.358,127.3464,-1997.11}, 0 )
	this.WarpCamoParasite( "wmu_lab_0003", {2522.942,129.6939,-1962.911}, 0 )

end


function this.CombatCamoParasiteSeq01Jungle()

	this.SetUpCamoParasite( "wmu_lab_0000", "rts_Parasite00_P01_Combat0002" ,"rts_Parasite00_P01_Combat0002" )
	this.SetUpCamoParasite( "wmu_lab_0001", "rts_Parasite01_P01_Combat0002" ,"rts_Parasite01_P01_Combat0002" )
	this.SetUpCamoParasite( "wmu_lab_0002", "rts_Parasite02_P01_Combat0002" ,"rts_Parasite02_P01_Combat0002" )
	this.SetUpCamoParasite( "wmu_lab_0003", "rts_Parasite03_P01_Combat0002" ,"rts_Parasite03_P01_Combat0002" )

end


function this.SetUpCamoParasiteSeq02()

	this.SetUpCamoParasiteClearingOn( "wmu_lab_0000" )
	this.SetUpCamoParasiteClearingOn( "wmu_lab_0001" )
	this.SetUpCamoParasiteClearingOn( "wmu_lab_0002" )
	this.SetUpCamoParasiteClearingOn( "wmu_lab_0003" )

	this.SetUpCamoParasite( "wmu_lab_0000", "rts_Parasite00_P02_Start" ,"rts_Parasite00_P02_Start" )
	this.SetUpCamoParasite( "wmu_lab_0001", "rts_Parasite01_P02_Start" ,"rts_Parasite01_P02_Start" )
	this.SetUpCamoParasite( "wmu_lab_0002", "rts_Parasite02_P02_Start" ,"rts_Parasite02_P02_Start" )
	this.SetUpCamoParasite( "wmu_lab_0003", "rts_Parasite03_P02_Start" ,"rts_Parasite03_P02_Start" )

	this.SetUpCamoParasiteRelay( "wmu_lab_0000", "rts_Parasite00_P02_Relay" )
	this.SetUpCamoParasiteRelay( "wmu_lab_0001", "rts_Parasite01_P02_Relay" )
	this.SetUpCamoParasiteRelay( "wmu_lab_0002", "rts_Parasite02_P02_Relay" )
	this.SetUpCamoParasiteRelay( "wmu_lab_0003", "rts_Parasite03_P02_Relay" )

	this.SetUpCamoParasiteDead( "wmu_lab_0000", "rts_Parasite00_P02_Dead" )
	this.SetUpCamoParasiteDead( "wmu_lab_0001", "rts_Parasite01_P02_Dead" )
	this.SetUpCamoParasiteDead( "wmu_lab_0002", "rts_Parasite02_P02_Dead" )
	this.SetUpCamoParasiteDead( "wmu_lab_0003", "rts_Parasite03_P02_Dead" )

end


function this.CombatCamoParasiteSeq02()

	this.SetUpCamoParasiteClearingOff( "wmu_lab_0000" )
	this.SetUpCamoParasiteClearingOff( "wmu_lab_0001" )
	this.SetUpCamoParasiteClearingOff( "wmu_lab_0002" )
	this.SetUpCamoParasiteClearingOff( "wmu_lab_0003" )

	this.SetUpCamoParasite( "wmu_lab_0000", "rts_Parasite00_P02_Combat0001" ,"rts_Parasite00_P02_Combat0001" )
	this.SetUpCamoParasite( "wmu_lab_0001", "rts_Parasite01_P02_Combat0001" ,"rts_Parasite01_P02_Combat0001" )
	this.SetUpCamoParasite( "wmu_lab_0002", "rts_Parasite02_P02_Combat0001" ,"rts_Parasite02_P02_Combat0001" )
	this.SetUpCamoParasite( "wmu_lab_0003", "rts_Parasite03_P02_Combat0001" ,"rts_Parasite03_P02_Combat0001" )

end


function this.CamoParasiteFogOn()

	TppWeather.RequestWeather( TppDefine.WEATHER.FOGGY, 3, { fogDensity=0.001 } )

end


function this.CamoParasiteFogOff()

	TppWeather.RequestWeather( TppDefine.WEATHER.CLOUDY, 3 )

	TppWeather.CancelRequestWeather()

end


function this.CamoParasiteOff()

	Fox.Log( "!!!! s10130_enemy.CamoParasiteOff !!!!" )

	for i, ParasiteName in pairs( this.parasiteDefine ) do

		local gameObjectId = GameObject.GetGameObjectId("TppBossQuiet2", ParasiteName)

		
		local command01 = { id="SetSightCheck", flag="flag" }
		command01.flag = false
		GameObject.SendCommand(gameObjectId, command01)

		
		local command02 = { id="SetNoiseNotice", flag="flag" }
		command02.flag = false
		GameObject.SendCommand(gameObjectId, command02)

		
		local command03 = { id="SetInvincible", flag="flag" }
		command03.flag = true
		GameObject.SendCommand(gameObjectId, command03)

		
		local command04 = { id="SetStealth", flag="flag" }
		command04.flag = true
		GameObject.SendCommand(gameObjectId, command04)

		
		local command05 = { id="SetHumming", flag="flag" }
		command05.flag = false
		GameObject.SendCommand(gameObjectId, command05)

		
		local command06 = { id="SetForceUnrealze", flag="flag" }
		command06.flag = true
		GameObject.SendCommand(gameObjectId, command06)

	end

end



function this.CamoParasiteOn()

	for i, ParasiteName in pairs( this.parasiteDefine ) do

		
		if ( svars[ParasiteName.."Fulton"] == false ) then

			local gameObjectId = GameObject.GetGameObjectId("TppBossQuiet2", ParasiteName)

			
			local command06 = { id="SetForceUnrealze", flag="flag" }
			command06.flag = false
			GameObject.SendCommand(gameObjectId, command06)

			
			local command01 = { id="SetSightCheck", flag="flag" }
			command01.flag = true
			GameObject.SendCommand(gameObjectId, command01)

			
			local command02 = { id="SetNoiseNotice", flag="flag" }
			command02.flag = true
			GameObject.SendCommand(gameObjectId, command02)

			
			local command03 = { id="SetInvincible", flag="flag" }
			command03.flag = false
			GameObject.SendCommand(gameObjectId, command03)

			
			local command04 = { id="SetStealth", flag="flag" }
			command04.flag = false
			GameObject.SendCommand(gameObjectId, command04)

			
			local command05 = { id="SetHumming", flag="flag" }
			command05.flag = true
			GameObject.SendCommand(gameObjectId, command05)

		end

	end

end



function this.CamoParasiteForceUnrealize()

	for i, ParasiteName in pairs( this.parasiteDefine ) do

		local gameObjectId = GameObject.GetGameObjectId("TppBossQuiet2", ParasiteName)

		
		local command02 = { id="SetMarkerEnabledCommand", enabled=false }
		GameObject.SendCommand(gameObjectId, command02)

		
		if ( svars[ParasiteName.."Disablement"] == true ) then

			
			local command06 = { id="SetForceUnrealze", flag="flag" }
			command06.flag = true
			GameObject.SendCommand(gameObjectId, command06)

		end

	end

end


function this.CamoParasiteShortMode()

	Fox.Log( "!!!! s10130_enemy.CamoParasiteShortMode !!!!" )
	local command = { id="SetCloseCombatMode", enabled="enabled" }
	command.enabled = true
	local gameObjectId = { type="TppBossQuiet2" }
	GameObject.SendCommand(gameObjectId, command)

end


function this.CamoParasiteLongMode()

	Fox.Log( "!!!! s10130_enemy.CamoParasiteLongMode !!!!" )
	local command = { id="SetCloseCombatMode", enabled="enabled" }
	command.enabled = false
	local gameObjectId = { type="TppBossQuiet2" }
	GameObject.SendCommand(gameObjectId, command)

end


function this.CamoParasiteWaterFallShift()

	Fox.Log( "!!!! s10130_enemy.CamoParasiteWaterFallShift !!!!" )
	local command = { id="SetWatherFallShift", enabled="enabled" }
	command.enabled = true
	local gameObjectId = { type="TppBossQuiet2" }
	GameObject.SendCommand(gameObjectId, command)

end


function this.CamoParasiteNormalShift()

	Fox.Log( "!!!! s10130_enemy.CamoParasiteNormalShift !!!!" )
	local command = { id="SetWatherFallShift", enabled="enabled" }
	command.enabled = false
	local gameObjectId = { type="TppBossQuiet2" }
	GameObject.SendCommand(gameObjectId, command)

end


function this.CamoParasiteFultonCheck()

	
	if TppStory.GetCurrentStorySequence() >= TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA then
		Fox.Log( "!!!! s10130_enemy.CamoParasiteFulton Enable !!!!" )
		local command = { id="SetFultonEnabled", enabled="enabled" }
		command.enabled = true
		local gameObjectId = { type="TppBossQuiet2" }
		GameObject.SendCommand(gameObjectId, command)
	else
		Fox.Log( "!!!! s10130_enemy.CamoParasiteFulton Disable !!!!" )
	end

end



function this.ResetPositionZombie()
	for i, name in pairs( this.zombieRoute01 ) do
		
		local gameObjectId00 =  GameObject.GetGameObjectId( name.soldierName )
		local command00 = { id="SetEnabled", enabled=false }
		GameObject.SendCommand( gameObjectId00, command00 )

		
		TppEnemy.SetSneakRoute( name.soldierName, name.routeName )
		TppEnemy.SetCautionRoute( name.soldierName, name.routeName )

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


function this.ResetPositionEnemy01()

	for name, group in pairs( this.soldierDefine ) do
		for i, enemyName in ipairs( group ) do
			local gameObjectId = GameObject.GetGameObjectId( enemyName )
			local command = { id="SetEnabled", enabled=false }
			GameObject.SendCommand( gameObjectId, command )
		end
	end

end


function this.ResetPositionEnemy02()

	for name, group in pairs( this.soldierDefine ) do
		for i, enemyName in ipairs( group ) do
			local gameObjectId = GameObject.GetGameObjectId( enemyName )
			local command = { id="SetEnabled", enabled=true }
			GameObject.SendCommand( gameObjectId, command )
		end
	end

end


function this.EnemyMarkerSet( cp )

	for name, enemyName in pairs( cp ) do
			TppMarker.Enable( enemyName , 0, "none" , "map_and_world_only_icon" , 0 , false, false )
	end

end


function this.ZombieEnemy()

	
	for i, name in pairs( this.zombieRoute01 ) do
		
		local gameObjectId = GameObject.GetGameObjectId( name.soldierName )
		local command = { id="SetEnabled", enabled=true }
		GameObject.SendCommand( gameObjectId, command )
		
		local command01 = { id = "SetZombie", enabled=true, isZombieSkin=true  }
		GameObject.SendCommand( gameObjectId, command01 )
	end

end


function this.DiszombieEnemy()

	Fox.Log("!!!*** s10130_enemy.DiszombieEnemy ***!!!")

	
	TppEnemy.ChangeRouteSets( this.routeSets02 )
	this.EnemyZombieAfterRoute()

	for name, group in pairs( this.soldierDefine ) do
		for i, enemyName in ipairs( group ) do
			
			local gameObjectId = GameObject.GetGameObjectId( enemyName )
			local command = { id = "SetZombie", enabled=false  }
			GameObject.SendCommand( gameObjectId, command )
			
			local command01 = { id = "SetEverDown", enabled = true }
			GameObject.SendCommand( gameObjectId, command01 )
		end
	end

end


function this.EnemyZombieAfterRoute()
	for i, name in pairs( this.zombieRoute02 ) do
		
		TppEnemy.SetSneakRoute( name.soldierName, name.routeName )
		TppEnemy.SetCautionRoute( name.soldierName, name.routeName )
	end
end


function this.UnlockedCodeTalker()

	local locatorName = "CodeTalker"
	local gameObjectType = "TppCodeTalker2"
	local gameObjectId = GameObject.GetGameObjectId(gameObjectType, locatorName)
	local command = {
		id = "SetHostage2Flag",
		
		flag = "unlocked",	
		on = true,
	}
	GameObject.SendCommand( gameObjectId, command )

end




return this
