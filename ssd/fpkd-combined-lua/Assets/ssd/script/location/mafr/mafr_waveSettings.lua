 local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table


local ZOMBIE	= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local BOM		= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM
local DASH		= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH
local MORTOR	= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL
local CAMERA	= TppGameObject.GAME_OBJECT_TYPE_INSECT_1
local SPIDER	= TppGameObject.GAME_OBJECT_TYPE_INSECT_2




local  mafr_waveSettings = {}





mafr_waveSettings.waveList = {
	"wave_fast_mafr01",
	"wave_fast_mafr02",
	"wave_fast_mafr03",
	"wave_fast_mafr06",
	"wave_fast_mafr07",
	
	"wave_factory_q11300",
	"wave_factory_q11310",
	"wave_factory_q11340",
	"wave_factory_q11921",
	"wave_factory_q11922",
	
	"wave_lab_q11925",
	
	"wave_diamond_q11928",
	
}




mafr_waveSettings.propertyTable = {

	
	wave_fast_mafr01 = {
		limitTimeSec	= (60 * 1),
		defenseTimeSec	= (60 * 1),
		alertTimeSec	= 30,
		isTerminal		= true,
		pos				= { 2373.703, 86.490, -761.787 },
		radius			= 50,
		endEffectName	= "explosion_mafr01",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
		defenseTargetGimmickProperty = {
			fastTravelPoint = "fast_mafr01",
			alertParameters = { 
				needAlert = true, 
				alertRadius = 10,
			},
		},
	},


	
	wave_fast_mafr02 = {
		limitTimeSec	= (150 * 1),
		defenseTimeSec	= (150 * 1),
		alertTimeSec	= 30,
		isTerminal		= true,
		useSpecifiedAreaEnemy = {
			{ pos = { 2516.530, 70.368, -1395.740 }, radius = 30, },
			{ pos = { 2462.847, 77.042, -1428.857 }, radius = 20, },
		},
		endEffectName	= "explosion_mafr02",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
		defenseTargetGimmickProperty = {
			fastTravelPoint = "fast_mafr02",
			alertParameters = { 
				needAlert = true, 
				alertRadius = 10,
			},
		},
	},
	wave_fast_mafr03 = {
		limitTimeSec	= (120),
		defenseTimeSec	= (120),
		alertTimeSec	= 30,
		isTerminal		= true,
		pos				= { 2555.389, 113.200, -1887.445 },
		radius			= 100,
		endEffectName	= "explosion_mafr03",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
		defenseTargetGimmickProperty = {
			fastTravelPoint = "fast_mafr03",
			alertParameters = { 
				needAlert = true, 
				alertRadius = 15,
			},
		},
	},

	wave_fast_mafr06 = {
		limitTimeSec	= (30 * 3),
		defenseTimeSec	= (30 * 3),
		alertTimeSec	= 30,
		isTerminal		= true,
		pos				= { 1276.787, 144.631, -1692.986 },
		radius			= 150,
		endEffectName	= "explosion_mafr06",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
		defenseTargetGimmickProperty = {
			fastTravelPoint = "fast_mafr06",
			alertParameters = { 
				needAlert = true, 
				alertRadius = 15,
			},
		},
	},
	
	wave_fast_mafr07 = {
		limitTimeSec	= (15 * 7),
		defenseTimeSec	= (15 * 7),
		alertTimeSec	= 30,
		isTerminal		= true,
		pos				= { 2752.910, 70.058, -1886.097 },
		radius			= 180,
		endEffectName	= "explosion_mafr07",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
		defenseTargetGimmickProperty = {
			fastTravelPoint = "fast_mafr07",
			fastTravelPointLevel = 20, 
		alertParameters = { 
				needAlert = true, 
				alertRadius = 15,
			},
		},
	},

	
	wave_factory_q11300 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 2562.113,76.1628,-792.9528 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/mafr/factory/factory_q11300.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},
	
	
	wave_factory_q11310 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 2525.421,95.38603,-1779.671 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/mafr/factory/factory_q11310.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_factory_q11340 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 2663.675,160.2025,-2320.366 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/mafr/factory/factory_q11340.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_factory_q11921 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 2476.587,69.09,-1297.142 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/mafr/factory/factory_q11921.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_factory_q11922 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 2391.247,70.66665,-796.6458 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/mafr/factory/factory_q11922.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_lab_q11925 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 2559.894,111.483,-2060.483 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/mafr/lab/lab_q11925.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},

	
	wave_diamond_q11928 = {
		defenseTimeSec	= (3 * 60),
		alertTimeSec	= 30,
		limitTimeSec	= (3 * 60),
		intervalTimeSec	= 30,
		endEffectName	= "explosion",
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,	
		
		useSpecifiedAreaEnemy = {
			{ pos = { 1330.923,124.5783,-1529.525 }, radius = 50 },	
		},
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = {
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/quest/mafr/diamond/diamond_q11928.fox2",
				},
			},
			alertParameters = { needAlert = true, alertRadius = 12, }
		},
		waveFinishShockWaveRadius = 9.4,
	},
}




mafr_waveSettings.waveTable = {
	wave_fast_mafr02 = {},
	wave_fast_mafr03 = {},
	wave_fast_mafr06 = {},
	wave_fast_mafr07 = {},
	
	wave_factory_q11300 = {},
	wave_factory_q11310 = {},
	wave_factory_q11340 = {},
	wave_factory_q11921 = {},
	wave_factory_q11922 = {},
	
	wave_lab_q11925 = {},
	
	wave_diamond_q11928 = {},
}




mafr_waveSettings.spawnPointDefine = {
}

return mafr_waveSettings
