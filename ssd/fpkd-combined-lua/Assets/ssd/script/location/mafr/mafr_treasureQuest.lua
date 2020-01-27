


local  mafr_treasureQuest = {}



function this.SetResources( questResourceList )
	local resources = {}
	local index = 1

	for key, value in pairs(questResourceList) do
		for k, v in pairs(value) do
			resources[index] = v
			index = index + 1
		end
	end
	return resources
end


mafr_treasureQuest.treasureTableList = {



	
	factory_q11330 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/factory/factory_q11330.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(2428.311,76.42365,-1220.794),
			},
		},
	},
	
	factory_q11350 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/factory/factory_q11350.fox2",
				breakResources		= {
										"COL_PKG_Rare_Weapon",		
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(2441.412,98.99409,-620.1035),
			},
		},
	},
	
	lab_q11924 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/lab/lab_q11924.fox2",
				breakResources		= {
										
										"COL_PKG_WP_Hammer_A_TypeA",
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(2618.445,135.9412,-2106.368),
			},
		},
	},
	
	lab_q11926 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/lab/lab_q11926.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(2707.281,178.1307,-2406.966),
			},
		},
	},
	
	diamond_q11929 = {	
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/diamond/diamond_q11929.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(1569.683,128.1455,-1529.602),
			},
		},
	},
	
	diamond_q11930 = {	
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/diamond/diamond_q11930.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(1360.404,127.49,-1466.692),
			},
		},
	},
	
	diamond_q44250 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/diamond/q44250/diamond_q44250.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(1521.1,127.8521,-1312.403),
			},
		},
	},
	
	diamond_q44260 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/diamond/q44260/diamond_q44260.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(1380.357,138.988,-1583.602),
			},
		},
	},
	
	factory_q44210 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/factory/q44210/factory_q44210.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(2762.524,94.40759,-873.4501),
			},
		},
	},
	
	factory_q44220 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/factory/q44220/factory_q44220.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(2415.103,86.97215,-814.5051),
			},
		},
	},
	
	factory_q44230 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/factory/q44230/factory_q44230.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(2447.311,97.53564,-565.8463),
			},
		},
	},
	
	factory_q44240 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/factory/q44240/factory_q44240.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(2534.41,69.09,-1188.729),
			},
		},
	},
	
	lab_q44270 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/lab/q44270/lab_q44270.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(2595.156,69.90468,-1442.515),
			},
		},
	},
	
	lab_q44280 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/lab/q44280/lab_q44280.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(2532.188,113.7929,-2020.668),
			},
		},
	},
	
	lab_q44290 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/lab/q44290/lab_q44290.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(2711.097,70.94347,-1834.732),
			},
		},
	},
	
	lab_q44300 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/lab/q44300/lab_q44300.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(2711.097,70.94347,-1834.732),
			},
		},
	},
	
	lab_q11931 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/mafr/lab/lab_q11931.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
										"COL_PKG_Rare_Material",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(2525.225098,198.346176,-2468.158691),
			},
		},
	},



	
	factory_q11320	= {
		
		treasureKubResourceTable = {
			
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0000|srt_ssda_crys001",
				dataSetName		= "/Assets/tpp/level/location/mafr/block_small/151/151_123/mafr_151_123_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0001|srt_ssda_crys001",
				dataSetName		= "/Assets/tpp/level/location/mafr/block_small/151/151_123/mafr_151_123_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_vrtn002_gim_n0000|srt_ssda_crys001_vrtn002",
				dataSetName		= "/Assets/tpp/level/location/mafr/block_small/151/151_123/mafr_151_123_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_vrtn002_gim_n0001|srt_ssda_crys001_vrtn002",
				dataSetName		= "/Assets/tpp/level/location/mafr/block_small/151/151_123/mafr_151_123_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_vrtn002_gim_n0002|srt_ssda_crys001_vrtn002",
				dataSetName		= "/Assets/tpp/level/location/mafr/block_small/151/151_123/mafr_151_123_gimmick.fox2",
			},
		},
	},
	
	factory_q11923	= {
		
		treasureKubResourceTable = {
			
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0000|srt_ssda_crys001",
				dataSetName		= "/Assets/tpp/level/location/mafr/block_small/152/152_121/mafr_152_121_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0001|srt_ssda_crys001",
				dataSetName		= "/Assets/tpp/level/location/mafr/block_small/152/152_121/mafr_152_121_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_vrtn002_gim_n0000|srt_ssda_crys001_vrtn002",
				dataSetName		= "/Assets/tpp/level/location/mafr/block_small/152/152_121/mafr_152_121_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_vrtn002_gim_n0001|srt_ssda_crys001_vrtn002",
				dataSetName		= "/Assets/tpp/level/location/mafr/block_small/152/152_121/mafr_152_121_gimmick.fox2",
			},
		},
	},
}





mafr_treasureQuest.clearRewardCboxTableList = {
	
	diamond_q61020 = {	
		
		{
			pos = Vector3( 1347.726, 138.993+15, -1654.021 ),
			model = 3,
			showRewardLog = true,
			contents = {
				{ id = "BP_Boss02Reward_WeaponEnhance", count = 1 },
			},
		},
		
		{
			pos = Vector3( 1341.822, 138.993+15, -1648.739 ),
			model = 3,
			showRewardLog = true,
			contents = {
				{ id = "BP_Boss02Reward_AccessoryEnhance", count = 1 },
			},
		},
		
		{
			pos = Vector3( 1347.698, 138.993+15, -1642.288 ),
			model = 3,
			showRewardLog = true,
			contents = {
				{ id = "BP_Boss02Reward_Material", count = 3 },
			},
		},
	},
}




mafr_treasureQuest.clearNamePlateTableList = {
	
	diamond_q61020 = { 52, }, 
}

return mafr_treasureQuest
