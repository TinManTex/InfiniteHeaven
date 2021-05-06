


SoundTppRaiden = {





Setup = function( id )

	SoundComponentPlayerEventConvert.SetPlayerRattleWeapon{
		
		
		scriptId = id,
		reference = {
			"RATTLE_WEAPON",	
		},
		basis = "sfx_p_rtl_wpn",
		action = {
			"wk",			
			"wkc",			
			"rn",			
			"rnc",			
			"dh",			
			"cr",			
			"cp",			
			"dh",			
		},
		type = {
			"asult_rifle",		
			"sniper_rifle",		
			"shot_gun",		
			"machine_gun",		
			"hand_gun",		
			"sub_machine_gun",	
			"grenade_launcher",	
			"missile",		
			"support",		
			"none",			
		},
		
		asult_rifle = {
			symbol = "ar00",
			weaponId = {
			},
		},
		
		sniper_rifle = {
			symbol = "sr00",
			weaponId = {
			},
		},
		
		shot_gun = {
			symbol = "ar00",
			weaponId = {
			},
		},
		
		machine_gun = {
			symbol = "",
			weaponId = {
			},
		},
		
		hand_gun = {
			symbol = "",
			weaponId = {
			},
		},
		
		sub_machine_gun = {
			symbol = "",
			weaponId = {
			},
		},
		
		grenade_launcher = {
			symbol = "",
			weaponId = {
			},
		},
		
		missile = {
			symbol = "ms00",
			weaponId = {
			},
		},
		
		support = {
			symbol = "",
			weaponId = {
			},
		},
		
		none = {
			symbol = "",
			weaponId = {
			},
		},
	}

	SoundComponentPlayerEventConvert.SetPlayerRattleSuit{
		
		scriptId = id,
		reference = {
			"RATTLE_SUIT",		
		},
		basis = "sfx_p_rtl_suit",
		action = {
			"wk",			
			"wkc",			
			"rn",			
			"rnc",			
			"wk",			
			"cr",			
			"cp",			
			"dh",			
		},
		type = {
			"sneaking",		
			"sneaking",		
			"sneaking",		
		},
		
		normal = {
			symbol = "nom",
			suitId = {
				"PLTypeNormal",	
			},
		},
		
		scarf = {
			symbol = "nom",
			suitId = {
				"PLTypeScarf",	
			},
		},
		
		sneaking = {
			symbol = "snk",
			suitId = {
				"PLTypeSneakingSuit",	
			},
		},
	}

	SoundComponentPlayerEventConvert.SetPlayerFootStep{
		
		scriptId = id,
		reference = {
			"FOOT_GROUND_L",	
			"FOOT_GROUND_R",	
			"FOOT_LEAVE_L",		
			"FOOT_LEAVE_R",		
			"ARM_GROUND_L",		
			"ARM_GROUND_R",		
			"ARM_LEAVE_L",		
			"ARM_LEAVE_R",		
		},
		basis = "Play_sfx_P_Fs",
		action = {
			
			"Wk_Grd", 		
			"Wk_Lev", 		
			"Wk_Grd", 		
			"Wk_Lev", 		
			"Wk_Tn_Grd", 		
			"Wk_Lev", 		
			"Rn_Grd",		
			"Rn_Lev",		
			"Dhr_Grd",		
			
			"WkC_Grd", 		
			"WkC_Lev", 		
			"WkC_Grd", 		
			"WkC_Lev", 		
			"WkC_Tn_Grd", 		
			"WkC_Lev", 		
			"Rn_Grd",		
			"Rn_Lev",		
			"Dhr_Grd",		
			
			"Rn_Grd", 		
			"Rn_Lev", 		
			"Wk_Grd", 		
			"Wk_Lev", 		
			"Rn_Tn_Grd", 		
			"Rn_Lev", 		
			"Dhr_Grd",		
			"Rn_Lev",		
			"Dhr_Grd",		
			
			"RnC_Grd", 		
			"RnC_Lev", 		
			"WkC_Grd", 		
			"WkC_Lev", 		
			"RnC_Tn_Grd", 		
			"RnC_Lev", 		
			"Dhr_Grd",		
			"Rn_Lev",		
			"Dhr_Grd",		
			
			"Dhr_Grd", 		
			"Dh_Lev", 		
			"Wk_Grd", 		
			"Wk_Lev",		
			"Dh_Tn_Grd", 		
			"Dh_Lev", 		
			"Dhr_Grd",		
			"Dh_Lev",		
			"Dhr_Grd",		
			
			"Wk_Grd", 		
			"Wk_Lev", 		
			"El_Arm_Grd", 		
			"El_Arm_Lev", 		
			
			"Wk_Grd", 		
			"Wk_Lev", 		
			"El_Arm_Grd", 		
			"El_Arm_Lev", 		
			
			"Cr_Leg_Grd", 		
			"Cr_Leg_Lev",		
			"Cr_Arm_Grd", 		
			"Cr_Arm_Lev",		
			
			"Cp_Leg_Grd", 		
			"Cp_Leg_Lev",		
			"Cp_Arm_Grd", 		
			"Cp_Arm_Lev",		
			
			"Rn_Dv_Arm_Grd",		
			"Rn_Be_Arm_Lev",		
			
			"El_Arm_Grd",		
			"El_Arm_Lev",		
			
			"Wk_Be_Arm_Grd",		
			"Wk_Be_Arm_Lev",		
			"Rn_Be_Arm_Grd",		
			"Rn_Be_Arm_Lev",		
		},
		side = {
			"L",			
			"R",			
		},
		wet = "W",
		type = {
			"soil",			
			"soilw",		
			"soilm",		
			"rock",			
			"clot",			
			"grass",		
			"grav",			
			"wood",			
			"iron",			
			"fence",		
			"tin",			
			"ironb",		
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
				"MTR_IRON_C",	
				"MTR_PIPE_A",	
				"MTR_PIPE_B",	
				"MTR_IRON_E",	
			},
		},
		
		fence = {
			symbol = "FENCA",
			wet = true,
			material = {
				"MTR_FENC_B",	
				"MTR_CLOT_E",	
			},
		},
		
		tin = {
			symbol = "TIN_A",
			wet = true,
			material = {
				"MTR_TIN_A",	
			},
		},
		
		ironb = {
			symbol = "IRONB",
			wet = true,
			material = {
				"MTR_FENC_A",	
			},
		},
	}

end,

}
