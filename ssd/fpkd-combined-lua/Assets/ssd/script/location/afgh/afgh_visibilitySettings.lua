




local  afgh_visibilitySettings = {}


afgh_visibilitySettings.gimmickTableList = {
	{	
		targetStorySequence		= TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL,									
		greaterThanStorySequence	= TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST,								
		visibility				= true,																			
		datasetPath				= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",	
		locatorName				= "com_ai001_gim_n0000|srt_aip0_main0_def",										
		type					= TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	{	
		targetStorySequence		= TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL,									
		visibility				= true,																			
		datasetPath				= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",	
		locatorName				= "com_ai002_gim_n0000|srt_pup0_main0_ssd_v00",									
		type					= TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	{	
		targetStorySequence		= TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL,									
		visibility				= true,																			
		datasetPath				= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",	
		locatorName				= "com_ai003_gim_n0000|srt_ssde_swtc001",										
		type					= TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	{	
		targetStorySequence		= TppDefine.STORY_SEQUENCE.CLEARED_k40035,										
		visibility				= true,																			
		datasetPath				= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset.fox2",		
		locatorName				= "whm0_gim_n0000|srt_whm0_main0_def_v00",										
		type					= TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	{	
		targetStorySequence		=  TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST,									
		visibility				= true,																			
		datasetPath				= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",	
		locatorName				= "com_ai101_gim_n0000|srt_aip1_main0_def",										
		type					= TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
}


afgh_visibilitySettings.powerOffGimmickTableList = {
	
	{
		storySequence			= TppDefine.STORY_SEQUENCE.STORY_START,
		gimmickId				= "GIM_P_AI",
		gimmickName				= "com_ai001_gim_n0000|srt_aip0_main0_def",
		dataSetName				= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",
	},
	
	{
		storySequence			= TppDefine.STORY_SEQUENCE.STORY_START,
		gimmickId				= "GIM_P_AI",
		gimmickName				= "com_ai101_gim_n0000|srt_aip1_main0_def",
		dataSetName				= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",
	},
	
	{
		storySequence			= TppDefine.STORY_SEQUENCE.CLEARED_k40070,
		gimmickId				= "GIM_P_AI_Skill",
		gimmickName				= "com_ai002_gim_n0000|srt_pup0_main0_ssd_v00",
		dataSetName				= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",
	},
	
	{
		storySequence			= TppDefine.STORY_SEQUENCE.CLEARED_k40060,
		gimmickId				= "GIM_P_AI_Building",
		gimmickName				= "com_ai003_gim_n0000|srt_ssde_swtc001",
		dataSetName				= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2"
	},
	
	{
		
		storySequence			= TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST,
		gimmickId				= "GIM_P_Digger",
		gimmickName				= "whm0_gim_n0000|srt_whm0_main0_def_v00",
		dataSetName				= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset.fox2",
		isNoTransfering			= true,
	},
	
	{
		gimmickId				= "GIM_P_CommonSwitch",
		gimmickName				= "ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001",
		dataSetName				= "/Assets/ssd/level/location/afgh/block_large/base/afgh_base_gimmick.fox2",
	},
	
	{
		gimmickId				= "GIM_P_CommonSwitch",
		gimmickName				= "ssde_swtc001_bord001_gim_n0001|srt_ssde_swtc001_bord001",
		dataSetName				= "/Assets/ssd/level/location/afgh/block_large/base/afgh_base_gimmick.fox2",
	},
	
	{
		gimmickId				= "GIM_P_CommonSwitch",
		gimmickName				= "ssde_swtc001_bord001_gim_n0002|srt_ssde_swtc001_bord001",
		dataSetName				= "/Assets/ssd/level/location/afgh/block_large/base/afgh_base_gimmick.fox2",
	},
	
	{
		gimmickId				= "GIM_P_CommonSwitch",
		gimmickName				= "ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001",
		dataSetName				= "/Assets/ssd/level/location/afgh/block_small/129/129_146/afgh_129_146_gimmick.fox2",
	},

	
	{
		gimmickId				= "GIM_P_CommonSwitch",
		gimmickName				= "ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001",
		dataSetName				= "/Assets/ssd/level/location/afgh/block_extraLarge/south/afgh_south_gimmick.fox2",
	},

	
	{
		gimmickId				= "GIM_P_CommonSwitch",
		gimmickName				= "ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001",
		dataSetName				= "/Assets/ssd/level/location/afgh/block_large/dungeon2/afgh_dungeon2_gimmick.fox2",
	},

}


afgh_visibilitySettings.setInOutMessageGimmickTableList = {
	
	{
		storySequence			= TppDefine.STORY_SEQUENCE.CLEARED_k40070,
		gimmickId				= "GIM_P_AI_Building",
		gimmickName				= "com_ai003_gim_n0000|srt_ssde_swtc001",
		dataSetName				= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2"
	},
	
	{
		storySequence			= TppDefine.STORY_SEQUENCE.CLEARED_k40070,
		gimmickId				= "GIM_P_AI_Skill",
		gimmickName				= "com_ai002_gim_n0000|srt_pup0_main0_ssd_v00",
		dataSetName				= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",
	},
	
	{
		storySequence			= TppDefine.STORY_SEQUENCE.CLEARED_k40070,
		gimmickId				= "GIM_P_Portal",
		gimmickName				= "com_portal001_gim_n0000|srt_ftp0_main0_def_v00",
		dataSetName				= "/Assets/ssd/level/location/afgh/block_small/129/129_150/afgh_129_150_gimmick.fox2",
	},
}

return afgh_visibilitySettings
