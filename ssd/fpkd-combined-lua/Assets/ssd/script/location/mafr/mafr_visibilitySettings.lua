




local mafr_visibilitySettings = {}

mafr_visibilitySettings.gimmickTableList = {
	{
		
		targetStorySequence = TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST + 1,	
		visibility = true,	
		datasetPath = "/Assets/ssd/level/location/mafr/block_common/mafr_common_asset_base.fox2",	
		locatorName = "com_ai002_gim_n0000|srt_pup0_main0_ssd_v00",	
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
}


mafr_visibilitySettings.powerOffGimmickTableList = {
	
	{
		gimmickId				= "GIM_P_CommonSwitch",
		gimmickName				= "ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001",
		dataSetName				= "/Assets/tpp/level/location/mafr/block_large/lab/mafr_lab_gimmick.fox2",
	},
	
	{
		gimmickId				= "GIM_P_CommonSwitch",
		gimmickName				= "ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001",
		dataSetName				= "/Assets/tpp/level/location/mafr/block_small/152/152_113/mafr_152_113_gimmick.fox2",
	},
	
	{
		gimmickId				= "GIM_P_SahelanRailGun",
		gimmickName				= "mgs0_moss_gim_n0000|srt_mgs0_moss0_ssd_v00",
		dataSetName				= "/Assets/tpp/level/location/mafr/block_large/lab/mafr_lab_gimmick.fox2",
	},
	
	{
		gimmickId				= "GIM_P_CommonSwitch",
		gimmickName				= "ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001",
		dataSetName				= "/Assets/tpp/level/location/mafr/block_small/153/153_126/mafr_153_126_gimmick.fox2",
	},
}

return mafr_visibilitySettings
