local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table


local ZOMBIE	= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local BOM		= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM
local DASH		= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH
local MORTOR	= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL
local CAMERA	= TppGameObject.GAME_OBJECT_TYPE_INSECT_1
local SPIDER	= TppGameObject.GAME_OBJECT_TYPE_INSECT_2




local  afgh_waveSettings = {}




afgh_waveSettings.waveList = {
	"wave_fast_afgh00",
	"wave_fast_afgh00",
	"wave_fast_afgh01",
	"wave_fast_afgh02",
	"wave_fast_afgh03",
	"wave_fast_afgh04",
	"wave_fast_afgh05",
	"wave_fast_afgh09",
	"wave_fast_afgh10",
	"wave_fast_afgh11",
	"wave_fast_afgh12",
	"wave_fast_afgh13",
	"wave_fast_afgh14",
	"wave_field_q11010",
	"wave_field_q11070",
	"wave_field_q11080",
	"wave_field_q11120",
	"wave_field_q11140",
	"wave_field_q11220",
	"wave_field_q11250",
	"wave_field_q11720",
	"wave_field_q11901",
	"wave_village_q11060",
	"wave_village_q11110",
	"wave_village_q11160",
	"wave_village_q11170",
	"wave_village_q11210",
	"wave_village_q11230",
	"wave_village_q11730",
	"wave_village_q11750",
	"wave_village_q11911",
}




afgh_waveSettings.propertyTable = {
	
	wave_fast_afgh00 = {
		limitTimeSec	= (30 * 3),
		defenseTimeSec	= (30 * 3),
		alertTimeSec	= 30,
		isTerminal		= true,
		pos				= { -445.225, 287.996, 2246.029 },
		radius			= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.BASE,
	},
	
	wave_fast_afgh01 = {
		limitTimeSec	= (30 * 5),
		defenseTimeSec	= (30 * 5),
		alertTimeSec	= 30,
		isTerminal		= true,
		pos				= { -72.47887,292.9945,2157.529 },
		radius			= 180,
		endEffectName	= "explosion_afgh01",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
		defenseTargetGimmickProperty = {
			fastTravelPoint = "fast_afgh01",
			alertParameters = {
				needAlert = true,
				alertRadius = 13,
			},
		},
	},
	
	wave_fast_afgh02 = {
		limitTimeSec	= (60 * 1),
		defenseTimeSec	= (60 * 1),
		alertTimeSec	= 30,
		isTerminal		= true,
		useSpecifiedAreaEnemy = {
			{ pos = { -79.826, 273.565, 1828.439 }, radius = 5, },
			{ pos = { -25.222, 263.794, 1844.899 }, radius = 50, },
		},
		endEffectName	= "explosion_afgh02",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
		defenseTargetGimmickProperty = {
			fastTravelPoint = "fast_afgh02",
			alertParameters = {
				needAlert = true,
				alertRadius = 32,
			},
		},
	},

	
	wave_fast_afgh03 = {
		limitTimeSec	= (90 * 1),
		defenseTimeSec	= (90 * 1),
		alertTimeSec	= 30,
		isTerminal		= true,
		pos				= { -505.735, 299.164, 1635.711 },
		radius			= 180,
		endEffectName	= "explosion_afgh03",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
		defenseTargetGimmickProperty = {
			fastTravelPoint = "fast_afgh03",
			alertParameters = {
				needAlert = true,
				alertRadius = 15,
			},
		},
	},

	
	wave_fast_afgh04 = {
		limitTimeSec	= (30 * 3),
		defenseTimeSec	= (30 * 3),
		alertTimeSec	= 30,
		isTerminal		= true,
		pos				= { 435.762, 277.964, 2511.567 },
		radius			= 180,
		endEffectName	= "explosion_afgh04",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
		defenseTargetGimmickProperty = {
			fastTravelPoint = "fast_afgh04",
			alertParameters = {
				needAlert = true,
				alertRadius = 25,
			},
		},

	},

	
	wave_fast_afgh05 = {
		limitTimeSec	= (120 * 1),
		defenseTimeSec	= (120 * 1),
		alertTimeSec	= 30,
		isTerminal		= true,
		useSpecifiedAreaEnemy = {
			{ pos = { 609.131, 279.547, 2095.490 }, radius = 5, },
			{ pos = { 595.440, 275.564, 2067.272 }, radius = 50, },
		},
		endEffectName	= "explosion_afgh05",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
		defenseTargetGimmickProperty = {
			fastTravelPoint = "fast_afgh05",
			alertParameters = {
				needAlert = true,
				alertRadius = 15,
			},
		},
	},
	

	
	wave_fast_afgh09 = {
		limitTimeSec	= (10 * 11),
		defenseTimeSec	= (10 * 11),
		alertTimeSec	= 30,
		isTerminal		= true,
		pos				= { 1201.100, 317.610, 1652.927 },
		radius			= 140,
		endEffectName	= "explosion_afgh09",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
		defenseTargetGimmickProperty = {
			fastTravelPoint = "fast_afgh09",
			alertParameters = {
				needAlert = true,
				alertRadius = 12,
			},
		},
	},


	
	wave_fast_afgh10 = {
		limitTimeSec	= (30 * 3),
		defenseTimeSec	= (30 * 3),
		alertTimeSec	= 30,
		isTerminal		= true,
		pos				= { 774.146, 316.954, 1492.415 },
		radius			= 80,
		endEffectName	= "explosion_afgh10",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
		defenseTargetGimmickProperty = {
			fastTravelPoint = "fast_afgh10",
			alertParameters = {
				needAlert = true,
				alertRadius = 15,
			},
		},
	},
	
	wave_fast_afgh11 = {
		limitTimeSec	= (90 * 1),
		defenseTimeSec	= (90 * 1),
		alertTimeSec	= 30,
		isTerminal		= true,
		useSpecifiedAreaEnemy = {
			{ pos = { 1197.390, 346.694, 1171.005 }, radius = 15, },
			{ pos = { 1224.216, 357.926, 1151.098 }, radius = 50, },
		},
		endEffectName	= "explosion_afgh11",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
		defenseTargetGimmickProperty = {
			fastTravelPoint = "fast_afgh11",
			alertParameters = {
				needAlert = true,
				alertRadius = 10,
			},
		},
	},

	
	wave_fast_afgh13 = {
		limitTimeSec	= (30 * 7),
		defenseTimeSec	= (30 * 7),
		alertTimeSec	= 30,
		isTerminal		= true,
		pos				= { 381.241, 337.453, 855.848 },
		radius			= 150,
		endEffectName	= "explosion_afgh13",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
		defenseTargetGimmickProperty = {
			fastTravelPoint = "fast_afgh13",
			alertParameters = {
				needAlert = true,
				alertRadius = 15,
			},
		},
	},

	
	wave_field_q11010 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { -503.41670000, 287.63520000, 1798.97000000 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/field/field_q11010/field_q11010.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},
	
	wave_field_q11070 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { -299.817, 297.263, 1585.933 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/field/field_q11070.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},
	
	
	wave_field_q11080 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 458.1824,265.5249,2065.31 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/field/field_q11080.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},
	
	
	wave_field_q11120 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { -76.76894,267.4004,1958.919 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/field/field_q11120.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},
	
	
	wave_field_q11140 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 464.1596,268.6417,2219.317 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/field/field_q11140.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_field_q11220 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { -52.33262,274.0749,1917.373 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/field/field_q11220.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_field_q11250 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { -184.4994,296.0656,2330.744 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/field/field_q11250.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},
	
	
	wave_field_q11720 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 329.8576,273.3962,2103.294 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/field/field_q11720.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},
	
	
	wave_field_q11901 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { -562.2701,289.9155,1982.178 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/field/field_q11901.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_village_q11060 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 1121.683,315.6354,1226.884 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/village/village_q11060.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_village_q11110 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 612.1761,347.8167,892.1229 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/village/village_q11110.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_village_q11160 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 813.7363,348.8179,1083.166 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/village/village_q11160.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_village_q11170 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 487.6836,320.7592,1192.526 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/village/village_q11170.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_village_q11210 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 615.1738,330.5702,1305.057 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/village/village_q11210.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_village_q11230 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 1091.455,316.4756,1347.386 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/village/village_q11230.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},
	
	
	wave_village_q11730 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 893.4858,321.5031,1339.769}, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/village/village_q11730.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_village_q11750 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 777.1464,324.4511,1746.677 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/village/village_q11750.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_village_q11911 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 1171.26,317.5214,1627.728 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/afgh/village/village_q11911.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

}




afgh_waveSettings.waveTable = {
	wave_fast_afgh00 = {},
	wave_fast_afgh01 = {},
	wave_fast_afgh02 = {},
	wave_fast_afgh03 = {},
	wave_fast_afgh04 = {},
	wave_fast_afgh05 = {},
	wave_fast_afgh09 = {},
	wave_fast_afgh10 = {},
	wave_fast_afgh11 = {},
	wave_fast_afgh12 = {},
	wave_fast_afgh13 = {},
	wave_fast_afgh14 = {},
	wave_field_q11010 = {},
	wave_field_q11070 = {},
	wave_field_q11080 = {},
	wave_field_q11120 = {},
	wave_field_q11140 = {},
	wave_field_q11220 = {},
	wave_field_q11250 = {},
	wave_field_q11720 = {},
	wave_field_q11901 = {},
	wave_village_q11060 = {},
	wave_village_q11110 = {},
	wave_village_q11160 = {},
	wave_village_q11170 = {},
	wave_village_q11210 = {},
	wave_village_q11230 = {},
	wave_village_q11730 = {},
	wave_village_q11750 = {},
	wave_village_q11911 = {},
}




afgh_waveSettings.spawnPointDefine = {
}

return afgh_waveSettings
