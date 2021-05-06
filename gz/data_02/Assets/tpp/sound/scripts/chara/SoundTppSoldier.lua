


SoundTppSoldier = {





Setup = function( id )

	
	SoundComponentEnemyEventConvert.SetEnemyRattleSuit{
		
		scriptId = id,
		reference = {
			"RATTLE_SUIT",		
		},
		basis = "sfx_e_rtl_suit",			
		action = {
			"wk",			
			"wkc",			
			"rn",			
			"rnc",			
			"dh",			
			"cr",			
			"cp",			
		},
		type = {
			"normal",		
			"heavy",		
		},
		
		
		normal = {
			symbol = "nom",
			suitId = {
				"",
			},
		},
		
		heavy = {
			symbol = "hvy",
			suitId = {
				"",
			},
		},
	}

	
	SoundComponentEnemyEventConvert.SetEnemyBodyCollision{
		
		scriptId = id,
		reference = {
			"CHEST_GROUND",	
		},
		basis = "sfx_e",
		action = {
			"hitfenc",			
			"hitwall",			
		},
		wet = "W",
		type = {
			"soil",			
			"soilm",		
			"rock",			
			"clot",			
			"grass",		
			"grav",			
			"wood",			
			"iron",			
			"fence",		
		},
		
		soil = {
			symbol = "SOILA",
			wet = false,
			material = {
				"MTR_SOIL_A",	
				"MTR_SOIL_B",	
				"MTR_SOIL_F",	
				"MTR_SOIL_G",	
				"MTR_SOIL_H",	
				"MTR_SAND_A",	
				"MTR_SAND_B",	
				"MTR_PLNT_A",	
			},
		},
		
		soilm = {
			symbol = "ROCKAW",
			wet = false,
			material = {
				"MTR_SOIL_D",	
				"MTR_WATE_B",	
			},
		},
		
		rock = {
			symbol = "ROCKA",
			wet = false,
			material = {
				"MTR_ROCK_A",	
				"MTR_ROCK_B",	
				"MTR_BRIC_A",	
				"MTR_CONC_A",	
				"MTR_CONC_B",	
				"MTR_PAPE_A",	
				"MTR_RUBB_A",	
				"MTR_TILE_A",	
				"MTR_VINL_A",	
				"MTR_GLAS_A",	
				"MTR_RUBB_B",	
			},
		},
		
		clot = {
			symbol = "CLOTA",
			wet = false,
			material = {
				"MTR_CLOT_C",	
				"MTR_CLOT_D",	
			},
		},
		
		grass = {
			symbol = "GRASA",
			wet = false,
			material = {
				"MTR_TURF_A",	
				"MTR_LEAF",		
			},
		},
		
		grav = {
			symbol = "GRAVA",
			wet = false,
			material = {
				"MTR_GRAV_A",	
				"MTR_SOIL_C",	
			},
		},
		
		wood = {
			symbol = "WOODA",
			wet = false,
			material = {
				"MTR_PAPE_B",	
				"MTR_PLAS_A",	
				"MTR_PLAS_B",	
				"MTR_WOOD_A",	
				"MTR_WOOD_B",	
				"MTR_WOOD_C",	
				"MTR_WOOD_D",	
			},
		},
		
		iron = {
			symbol = "IRONA",
			wet = false,
			material = {
				"MTR_IRON_A",	
				"MTR_IRON_B",	
				"MTR_FENC_A",	
				"MTR_PIPE_A",	
				"MTR_PIPE_B",	
				"MTR_TIN_A",	
				"MTR_IRON_E",	
			},
		},
		
		fence = {
			symbol = "FENCA",
			wet = false,
			material = {
				"MTR_FENC_B",	
				"MTR_CLOT_E",	
			},
		},
	}

	
	SoundComponentEnemyEventConvert.SetEnemyFootStep{
		
		scriptId = id,
		reference = {
			"FOOT_GROUND_L",	
			"FOOT_GROUND_R",	
			"FOOT_LEAVE_L",		
			"FOOT_LEAVE_R",		
		},
		basis = "Play_sfx_E_Fs",
		action = {
			
			"Wk_Grd", 		
			"Wk_Lev", 		
			"Wk_Grd", 		
			"Wk_Lev", 		
			"Wk_Grd", 		
			"Wk_Lev", 		
			"Wk_Grd",		
			"Wk_Lev",		
			
			"WkC_Grd", 		
			"WkC_Lev", 		
			"WkC_Grd", 		
			"WkC_Lev", 		
			"WkC_Grd", 		
			"WkC_Lev", 		
			"WkC_Grd",		
			"WkC_Lev",		
			
			"Rn_Grd", 		
			"Rn_Lev", 		
			"Wk_Grd", 		
			"Wk_Lev", 		
			"Rn_Grd", 		
			"Rn_Lev", 		
			"Rn_Grd",		
			"Rn_Lev",		
			
			"RnC_Grd", 		
			"RnC_Lev", 		
			"WkC_Grd", 		
			"WkC_Lev", 		
			"RnC_Grd", 		
			"RnC_Lev", 		
			"RnC_Grd",		
			"RnC_Lev",		
			
			"Dh_Grd", 		
			"Dh_Lev", 		
			"Wk_Grd", 		
			"Wk_Lev",		
			"Dh_Grd", 		
			"Dh_Lev", 		
			"Dh_Grd",		
			"Dh_Lev",		
			
			"Wk_Grd", 		
			"Wk_Lev", 		
			"Wk_Grd", 		
			"Wk_Lev", 		
			
			"Wk_Grd", 		
			"Wk_Lev",		
			"Wk_Grd", 		
			"Wk_Lev",		
			
			"Wk_Grd", 		
			"Wk_Lev",		
			"Wk_Grd", 		
			"Wk_Lev",		
		},
		side = {
			"L",			
			"R",			
		},
		wet = "W",
		type = {
			"soil",			
			"soilm",		
			"rock",			
			"clot",			
			"grass",		
			"grav",			
			"wood",			
			"iron",			
		},
		
		soil = {
			symbol = "SOILA",
			wet = true,
			material = {
				"MTR_SOIL_A",	
				"MTR_SOIL_B",	
				"MTR_SOIL_F",	
				"MTR_SOIL_G",	
				"MTR_SOIL_H",	
				"MTR_SAND_A",	
				"MTR_SAND_B",	
				"MTR_PLNT_A",	
			},
		},
		
		soilm = {
			symbol = "ROCKAW",
			wet = false,
			material = {
				"MTR_SOIL_D",	
				"MTR_WATE_B",	
			},
		},
		
		rock = {
			symbol = "ROCKA",
			wet = true,
			material = {
				"MTR_ROCK_A",	
				"MTR_ROCK_B",	
				"MTR_BRIC_A",	
				"MTR_CONC_A",	
				"MTR_CONC_B",	
				"MTR_PAPE_A",	
				"MTR_RUBB_A",	
				"MTR_TILE_A",	
				"MTR_VINL_A",	
				"MTR_GLAS_A",	
				"MTR_RUBB_B",	
			},
		},
		
		clot = {
			symbol = "CLOTA",
			wet = true,
			material = {
				"MTR_CLOT_C",	
				"MTR_CLOT_D",	
			},
		},
		
		grass = {
			symbol = "GRASA",
			wet = true,
			material = {
				"MTR_TURF_A",	
				"MTR_LEAF",		
			},
		},
		
		grav = {
			symbol = "GRAVA",
			wet = true,
			material = {
				"MTR_GRAV_A",	
				"MTR_SOIL_C",	
			},
		},
		
		wood = {
			symbol = "WOODA",
			wet = true,
			material = {
				"MTR_PAPE_B",	
				"MTR_PLAS_A",	
				"MTR_PLAS_B",	
				"MTR_WOOD_A",	
				"MTR_WOOD_B",	
				"MTR_WOOD_C",	
				"MTR_WOOD_D",	
			},
		},
		
		iron = {
			symbol = "IRONA",
			wet = true,
			material = {
				"MTR_IRON_A",	
				"MTR_IRON_B",	
				"MTR_FENC_A",	
				"MTR_FENC_B",	
				"MTR_PIPE_A",	
				"MTR_PIPE_B",	
				"MTR_TIN_A",	
				"MTR_CLOT_E",	
				"MTR_IRON_E",	
			},
		},
	}

end,

}
