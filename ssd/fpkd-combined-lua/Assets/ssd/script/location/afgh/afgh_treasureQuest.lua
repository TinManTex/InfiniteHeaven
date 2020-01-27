


local  afgh_treasureQuest = {}



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


afgh_treasureQuest.treasureTableList = {



	
	field_q11030 = {	
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/field/field_q11030.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position = Vector3(414.5969,271.8544,2389.143),
			},
		},
	},
	
	field_q11050 = {	
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/field/field_q11050.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position = Vector3(192.7032,288.2282,2054.378),
			},
		},
	},
	
	field_q11200 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/field/field_q11200.fox2",
				breakResources		= {
										"COL_PKG_Common_Accessory",	
										"COL_PKG_Common_Weapon",	
									  },
				pickingDifficulty	= 1,
				damageRate			= 0.8,
				position = Vector3(-7.886495,279.346,1905.272),
			},
		},
	},
	
	field_q11260 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/field/field_q11260.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position = Vector3(52.87023,274.9893,2273.381),
			},
		},
	},
	
	field_q11270 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/field/field_q11270.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position = Vector3(279.6424,295.2123,2006.317),
			},
		},
	},
	
	village_q11040 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/village_q11040.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position = Vector3( 576.178, 321.027, 1826.029 ),
			},
		},
	},
	
	village_q11090 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/village_q11090.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position = Vector3(386.3678,329.4522,1242.838),
			},
		},
	},
	
	village_q11130 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/village_q11130.fox2",
				breakResources		= {
										"COL_PKG_UnCommon_Accessory",	
										"COL_PKG_UnCommon_Weapon",		
									  },
				pickingDifficulty	= 1,
				damageRate			= 0.8,
				position = Vector3(736.7906,325.9371,1722.982),
			},
		},
	},
	
	village_q11290 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/village_q11290.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				position = Vector3(776.0093,329.8849,1688.941),
			},
		},
	},
	
	village_q11710 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/village_q11710.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position = Vector3(873.1634,315.292,1300.733),
			},
		},
	},
	
	field_q44030 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000_q44030|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/field/q44030/field_q44030.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(368.4264,285.3618,2003.781),
			},
		},
	},
	
	field_q44040 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000_q44040|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/field/q44040/field_q44040.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(-393.4944,276.1172,1716.707),
			},
		},
	},
	
	field_q44050 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000_q44050|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/field/q44050/field_q44050.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(32.99578,277.423,1931.431),
			},
		},
	},
	
	field_q44100 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000_q44100|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/field/q44100/field_q44100.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(-599.203,308.0778,2214.857),
			},
		},
	},
	
	field_q44110 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000_q44110|srt_ssde_boxx004",
				dataSetName 		= "/Assets/ssd/level/mission/quest/afgh/field/q44110/field_q44110.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(-311.0778,291.1061,2376.24),
			},
		},
	},
	
	field_q44140 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName 		= "/Assets/ssd/level/mission/quest/afgh/field/q44140/field_q44140.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(292.64,299.9488,1946.805),
			},
		},
	},
	
	field_q44150 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName 		= "/Assets/ssd/level/mission/quest/afgh/field/q44150/field_q44150.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(-91.15417,289.5463,1795.969),
			},
		},
	},
	
	field_q44160 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName 		= "/Assets/ssd/level/mission/quest/afgh/field/q44160/field_q44160.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(286.6018,268.4623,2265.359),
			},
		},
	},
	
	field_q11902 = {	
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName 		= "/Assets/ssd/level/mission/quest/afgh/field/field_q11902.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(677.2532,293.627,2181.101),
			},
		},
	},
	
	field_q11903 = {	
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName 		= "/Assets/ssd/level/mission/quest/afgh/field/field_q11903.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(483.2072,302.6478,1939.625),
			},
		},
	},

	
	village_q44020 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000_q44020|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/q44020/village_q44020.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(353.8374,324.5982,1150.176),
			},
		},
	},
	
	village_q44060 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000_q44060|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/q44060/village_q44060.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(1049.915,334.5185,1214.517),
			},
		},
	},
	
	village_q44070 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000_q44070|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/q44070/village_q44070.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(854.6483,335.9637,1600.718),
			},
		},
	},
	
	village_q44080 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000_q44080|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/q44080/village_q44080.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(391.6106,313.5754,1179.144),
			},
		},
	},
	
	village_q44120 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000_q44120|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/q44120/village_q44120.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(450.0447,318.8618,1046.01),
			},
		},
	},
	
	village_q44130 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/q44130/village_q44130.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(623.652,348.6836,874.6383),
			},
		},
	},
	
	village_q44170 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/q44170/village_q44170.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(1278.03,341.8273,1251.646),
			},
		},
	},
	
	village_q44180 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/q44180/village_q44180.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(895.6964,314.8118,1294.349),
			},
		},
	},
	
	village_q44190 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/q44190/village_q44190.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Accessory",	
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(849.9493,348.648,1049.693),
			},
		},
	},
	
	village_q44200 = {
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/q44200/village_q44200.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(1131.078,317.233,1413.972),
			},
		},
	},
	
	village_q11912 = {	
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/village_q11912.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(592.8878,319.0397,1191.714),
			},
		},
	},
	
	village_q11913 = {	
		
		treasureBoxResourceTable = {
			{
				name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
				dataSetName			= "/Assets/ssd/level/mission/quest/afgh/village/village_q11913.fox2",
				breakResources		= {
										"COL_PKG_Rare_Material",	
										"COL_PKG_Rare_Weapon",		
									  },
				pickingDifficulty	= 2,
				damageRate			= 0.5,
				position			= Vector3(1017.446,331.8289,1182.622),
			},
		},
	},



	
	field_q11020 = {
		
		treasureKubResourceTable = {
			
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0001|srt_ssda_crys001",	
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/132/132_151/afgh_132_151_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0002|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/132/132_151/afgh_132_151_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0003|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/132/132_151/afgh_132_151_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0004|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/132/132_151/afgh_132_151_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",	
				name			= "ssda_crys001_gim_n0005|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/132/132_151/afgh_132_151_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0006|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/132/132_151/afgh_132_151_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0007|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/132/132_151/afgh_132_151_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0008|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/132/132_151/afgh_132_151_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0009|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/132/132_151/afgh_132_151_gimmick.fox2",
			},
		},
	},
	
	field_q11190 = {
		
		treasureKubResourceTable = {
			
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0000|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/132/132_148/afgh_132_148_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0001|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/132/132_148/afgh_132_148_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0002|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/132/132_148/afgh_132_148_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0003|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/132/132_148/afgh_132_148_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0004|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/132/132_148/afgh_132_148_gimmick.fox2",
			},
		},
	},
	
	field_q11240 = {
		
		treasureKubResourceTable = {
			
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0002|srt_ssda_crys001",	
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/133/133_150/afgh_133_150_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0003|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/133/133_150/afgh_133_150_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0004|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/133/133_150/afgh_133_150_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0005|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/133/133_150/afgh_133_150_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0006|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/133/133_150/afgh_133_150_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",	
				name			= "ssda_crys001_gim_n0007|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/133/133_150/afgh_133_150_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0008|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/133/133_150/afgh_133_150_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0009|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/133/133_150/afgh_133_150_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0010|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/133/133_150/afgh_133_150_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0011|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/133/133_150/afgh_133_150_gimmick.fox2",
			},

		},
	},
	
	field_q11280 = {
		
		treasureKubResourceTable = {
			
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0000|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/135/135_148/afgh_135_148_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0001|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/135/135_148/afgh_135_148_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0002|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/135/135_148/afgh_135_148_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0003|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/135/135_148/afgh_135_148_gimmick.fox2",
			},
			{	
				gimmickId		= "GIM_P_MissionGate",
				name			= "ssdb_brdg001_brrc003_gim_n0000|srt_ssdb_brdg001_brrc003",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/135/135_148/afgh_135_148_gimmick.fox2",
			},
		},
	},
	
	field_q11760 = {
		
		treasureKubResourceTable = {
			
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0000|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/138/138_148/afgh_138_148_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0001|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/138/138_148/afgh_138_148_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0002|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/138/138_148/afgh_138_148_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0003|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/138/138_148/afgh_138_148_gimmick.fox2",
			},
			{	
				gimmickId		= "GIM_P_MissionGate",
				name			= "ssdb_brdg001_brrc003_gim_n0000|srt_ssdb_brdg001_brrc003",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/138/138_148/afgh_138_148_gimmick.fox2",
			},
		},
	},
	
	village_q11100 = {
		
		treasureKubResourceTable = {
			
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0000|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/135/135_141/afgh_135_141_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0001|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/135/135_141/afgh_135_141_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0002|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/135/135_141/afgh_135_141_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0003|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/135/135_141/afgh_135_141_gimmick.fox2",
			},
			{	
				gimmickId		= "GIM_P_MissionGate",
				name			= "ssdg_cntn001_crys001_gim_n0000|srt_ssdg_cntn001_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/135/135_141/afgh_135_141_gimmick.fox2",
			},
		},
	},
	
	village_q11150 = {
		
		treasureKubResourceTable = {
			
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0000|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/141/141_144/afgh_141_144_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0001|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/141/141_144/afgh_141_144_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0002|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/141/141_144/afgh_141_144_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0003|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/141/141_144/afgh_141_144_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0004|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/141/141_144/afgh_141_144_gimmick.fox2",
			},
			{	
				gimmickId		= "GIM_P_MissionGate",
				name			= "ssdb_brdg001_brrc003_gim_n0000|srt_ssdb_brdg001_brrc003",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/141/141_144/afgh_141_144_gimmick.fox2",
			},
		},
	},
	
	village_q11180 = {
		
		treasureKubResourceTable = {
			
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0000|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/140/140_144/afgh_140_144_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0001|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/140/140_144/afgh_140_144_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0002|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/140/140_144/afgh_140_144_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0003|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/140/140_144/afgh_140_144_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0004|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/140/140_144/afgh_140_144_gimmick.fox2",
			},
			{	
				gimmickId		= "GIM_P_MissionGate",
				name			= "ssdg_cntn001_crys001_gim_n0000|srt_ssdg_cntn001_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/140/140_144/afgh_140_144_gimmick.fox2",
			},
		},
	},
	
	village_q11700 = {
		
		treasureKubResourceTable = {
			
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0000|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/138/138_141/afgh_138_141_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0001|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/138/138_141/afgh_138_141_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0002|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/138/138_141/afgh_138_141_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0003|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/138/138_141/afgh_138_141_gimmick.fox2",
			},
			{	
				gimmickId		= "GIM_P_MissionGate",
				name			= "ssdg_cntn001_crys001_gim_n0000|srt_ssdg_cntn001_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/138/138_141/afgh_138_141_gimmick.fox2",
			},
		},
	},
	
	village_q11740 = {
		
		treasureKubResourceTable = {
			
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0000|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/140/140_143/afgh_140_143_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0001|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/140/140_143/afgh_140_143_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0002|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/140/140_143/afgh_140_143_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0003|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/140/140_143/afgh_140_143_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0004|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/140/140_143/afgh_140_143_gimmick.fox2",
			},
			{
				gimmickType		= "SharedGimmick",
				name			= "ssda_crys001_gim_n0005|srt_ssda_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/140/140_143/afgh_140_143_gimmick.fox2",
			},
			{	
				gimmickId		= "GIM_P_MissionGate",
				name			= "ssdg_cntn001_crys001_gim_n0000|srt_ssdg_cntn001_crys001",
				dataSetName		= "/Assets/ssd/level/location/afgh/block_small/140/140_143/afgh_140_143_gimmick.fox2",
			},
		},
	},

}




afgh_treasureQuest.clearRewardCboxTableList = {
	
	field_q61010 = {	
		
		{
			pos = Vector3( 460.559, 271.499+15, 2389.305 ),
			model = 3,
			showRewardLog = true,
			contents = {
				{ id = "BP_Boss01Reward_Weapon", count = 1 },
			},
		},
		
		{
			pos = Vector3( 447.303, 271.499+15, 2394.651 ),
			model = 3,
			showRewardLog = true,
			contents = {
				{ id = "BP_Boss01Reward_Accessory", count = 1 },
			},
		},
		
		{
			pos = Vector3( 455.618, 271.499+15, 2399.037 ),
			model = 3,
			showRewardLog = true,
			contents = {
				{ id = "BP_Boss01Reward_Material", count = 3 },
			},
		},
	},
}




afgh_treasureQuest.clearNamePlateTableList = {
	
	field_q61010 = { 51, } 
}

return afgh_treasureQuest
