





local mafr_base = {}

local AI_GIMMICK_TABLE_LIST = {
	{
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		locatorName = "com_ai001_gim_n0000|srt_aip0_main0_def",
		datasetName = "/Assets/ssd/level/location/mafr/block_common/mafr_common_asset_base.fox2",
	},
}

local AFTER_STORY_LAST_AI_GIMMICK_TABLE_LIST = {
	{
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		locatorName = "com_ai101_gim_n0000|srt_aip1_main0_def",	
		datasetName = "/Assets/ssd/level/location/mafr/block_common/mafr_common_asset_base.fox2",
	},
}

local EXTRA_AI_GIMMICK_TABLE_LIST = {
	{	
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		locatorName = "com_ai004_gim_n0000|srt_ssde_swtc001_vrtn001",
		datasetName = "/Assets/ssd/level/location/mafr/block_common/mafr_common_asset_base.fox2",
	},
}

mafr_base.lab_gimmickVisibilitySetting = {
	{	
		targetStorySequence = TppDefine.STORY_SEQUENCE.BEFORE_RETURN_TO_AFGH,	
		flagMission = { missionName = "k40230", stepName = "GameEscape", },	
		visibility = false,	
		datasetName = "/Assets/tpp/level/location/mafr/block_large/lab/mafr_lab_gimmick.fox2",	
		locatorName = "mgs0_moss_gim_n0000|srt_mgs0_moss0_ssd_v00",		
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		collisionIdentifier = { identifierName = "DataIdentifier_mafr_lab_col_identifier", keyName = "col_mgs_gim", },
	},
}
mafr_base.lab_assetkVisibilitySetting = {
	{	
		targetStorySequence = TppDefine.STORY_SEQUENCE.BEFORE_RETURN_TO_AFGH,	
		flagMission = { missionName = "k40230", stepName = "GameEscape", },	
		visibility = false,	
		identifierName = "mafr_lab_StaticModelControl",					
		keyName = "K40170_after_OFF",									
	},
}

mafr_base.factory_gimmickVisibilitySetting = {
	{	
		targetStorySequence = TppDefine.STORY_SEQUENCE.CLEARED_s10050,	
		visibility = true,	
		datasetName = "/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",	
		locatorName = "ssde_camp002_gim_n0000|srt_ssde_camp002",		
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	{	
		targetStorySequence = TppDefine.STORY_SEQUENCE.CLEARED_s10050,	
		visibility = true,	
		datasetName = "/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",	
		locatorName = "com_food_box001_gim_n0000|srt_food_box001",		
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	{	
		targetStorySequence = TppDefine.STORY_SEQUENCE.CLEARED_s10050,	
		visibility = true,	
		datasetName = "/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",	
		locatorName = "ssde_mdcn002_gim_n0000|srt_ssde_mdcn002",		
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
}

mafr_base.baseList = {
	
	"mafr_banana",
	"mafr_diamond",
	"mafr_lab",
	"mafr_factory",
}


local SetGimmickVisibilityForTable = function( gimmickTable, visibility )
	for _, gimmickTable in ipairs( gimmickTable ) do
		if ( gimmickTable.visibility ~= nil ) then
			if gimmickTable.targetStorySequence then
				visibility = gimmickTable.visibility
				if TppStory.GetCurrentStorySequence() < gimmickTable.targetStorySequence then
					local needRevert = true
					if gimmickTable.flagMission then
						local flagMissioName, stepName = gimmickTable.flagMission.missionName, gimmickTable.flagMission.stepName
						if ( flagMissioName == SsdFlagMission.GetCurrentFlagMissionName() ) then
							local targetStepIndex = SsdFlagMission.GetStepIndex( stepName )
							if ( SsdFlagMission.GetCurrentStepIndex() >= targetStepIndex ) then
								needRevert = false
							end
						end
					end
					if needRevert then
						visibility = not visibility
					end
				end
			else
				Fox.Error( "mafr_base.SetGimmickVisibilityForTable(): visibility parameter needs targetStorySequence parameter" )
				if DEBUG then
					Tpp.DEBUG_DumpTable( gimmickTable )
				end
			end
		end
		Gimmick.InvisibleGimmick( gimmickTable.type, gimmickTable.locatorName, gimmickTable.datasetName, not visibility )
		if gimmickTable.collisionIdentifier then
			TppDataUtility.SetEnableDataFromIdentifier( gimmickTable.collisionIdentifier.identifierName, gimmickTable.collisionIdentifier.keyName, visibility, true )	
		end
	end
end

local SetAssetVisibilityForTable = function( assetTable, visibility )
	for _, assetTable in ipairs( assetTable ) do
		if ( assetTable.visibility ~= nil ) then
			if assetTable.targetStorySequence then
				visibility = assetTable.visibility
				if TppStory.GetCurrentStorySequence() < assetTable.targetStorySequence then
					local needRevert = true
					if assetTable.flagMission then
						local flagMissioName, stepName = assetTable.flagMission.missionName, assetTable.flagMission.stepName
						if ( flagMissioName == SsdFlagMission.GetCurrentFlagMissionName() ) then
							local targetStepIndex = SsdFlagMission.GetStepIndex( stepName )
							if ( SsdFlagMission.GetCurrentStepIndex() >= targetStepIndex ) then
								needRevert = false
							end
						end
					end
					if needRevert then
						visibility = not visibility
					end
				end
			else
				Fox.Error( "mafr_base.SetAssetVisibilityForTable(): visibility parameter needs targetStorySequence parameter" )
				if DEBUG then
					Tpp.DEBUG_DumpTable( assetTable )
				end
			end
		end
		TppDataUtility.SetVisibleDataFromIdentifier( assetTable.identifierName, assetTable.keyName, visibility, true )
	end
end




mafr_base.SetFactoryAssetVisibility = function( identifierKey, visibility )
	if not Tpp.IsLoadedLargeBlock( "mafr_factory" ) then
		Fox.Log( "mafr_base.SetFactoryAssetVisibility(): mafr_factory is not loaded. identifierKey = " .. tostring(identifierKey) .. ", visibility = " .. tostring( visibility ) )
		return
	end

	Fox.Log( "mafr_base.SetFactoryAssetVisibility(): identifierKey = " .. tostring(identifierKey) .. ", visibility = " .. tostring( visibility ) )
	TppDataUtility.SetVisibleDataFromIdentifier( "DataIdentifier_mafr_factory_identifier", identifierKey, visibility, true )
end




mafr_base.SetAiVisibility = function( visibility )
	Fox.Log( "mafr_base.SetAiVisibility(): visibility:" .. tostring( visibility ) )
	SetGimmickVisibilityForTable( AI_GIMMICK_TABLE_LIST, visibility )
end

mafr_base.SetAfterStoryLastAiVisibility = function( visibility )
	Fox.Log( "mafr_base.SetAfterStoryLastAiVisibility(): visibility:" .. tostring( visibility ) )
	SetGimmickVisibilityForTable( AFTER_STORY_LAST_AI_GIMMICK_TABLE_LIST, visibility )
end

mafr_base.SetPowerOffExtraAI = function( powerOff )
	Fox.Log( "mafr_base.SetPowerOffExtraAI(): powerOff:" .. tostring( powerOff ) )
	Gimmick.SetSsdPowerOff{
		gimmickId	= "GIM_P_AI_Info",
		name		="com_ai004_gim_n0000|srt_ssde_swtc001_vrtn001",
		dataSetName	= "/Assets/ssd/level/location/mafr/block_common/mafr_common_asset_base.fox2",
		powerOff	= powerOff,
	}
end



mafr_base.SetFobAiVisibility = function()
	Fox.Log( "mafr_base.SetFobAiVisibility(): visibility:" .. tostring( visibility ) )

	mafr_base.SetPowerOffExtraAI( true )
	
	local currentStorySequence = TppStory.GetCurrentStorySequence()
	if currentStorySequence < TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST then
		
		if currentStorySequence == TppDefine.STORY_SEQUENCE.BEFORE_s10050 then
			mafr_base.SetAiVisibility( false )
			mafr_base.SetPowerOffExtraAI( false )
		else
			mafr_base.SetAiVisibility( true )
		end
		mafr_base.SetAfterStoryLastAiVisibility( false )
	else
		mafr_base.SetAiVisibility( false )
		mafr_base.SetAfterStoryLastAiVisibility( true )
	end
	
end





mafr_base.SetSaheranVisibility = function( visibility )
	Fox.Log( "mafr_base.SetSaheranVisibility(): visibility:" .. tostring( visibility ) )

	if Tpp.IsLoadedLargeBlock( "mafr_lab" ) then
		SetGimmickVisibilityForTable(
			{
				{
					datasetName = "/Assets/tpp/level/location/mafr/block_large/lab/mafr_lab_gimmick.fox2",	
					locatorName = "mgs0_moss_gim_n0000|srt_mgs0_moss0_ssd_v00",		
					type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
				},
			},
			visibility
		)
		SetAssetVisibilityForTable(
			{
				{
					identifierName = "mafr_lab_StaticModelControl",					
					keyName = "K40170_after_OFF",									
				},
			},
			visibility
		)
		TppDataUtility.SetEnableDataFromIdentifier( "DataIdentifier_mafr_lab_col_identifier", "col_mgs_gim", visibility, true )	
	end
end




mafr_base.OnActiveTable = {
	mafr_banana = function()
		Fox.Log("mafr_base.OnActiveTable : mafr_banana")
	end,

	mafr_factory = function()
		Fox.Log("mafr_base.OnActiveTable : mafr_factory")
		SetGimmickVisibilityForTable( mafr_base.factory_gimmickVisibilitySetting )
	end,

	mafr_diamond = function()
		Fox.Log("mafr_base.OnActiveTable : mafr_diamond")
	end,

	mafr_lab = function()
		Fox.Log("mafr_base.OnActiveTable : mafr_lab")
		SetGimmickVisibilityForTable( mafr_base.lab_gimmickVisibilitySetting )
		SetAssetVisibilityForTable( mafr_base.lab_assetkVisibilitySetting )
	end,
}





function mafr_base.RegisterCrackPoints()
	Fox.Log( "mafr_base.RegisterCrackPoints" )
	TppUiCommand.RegisterCrackPoints{
		Vector3(2671.136, 95.238, -1909.543),
		Vector3(2665.200, 109.902, -1911.108),
		Vector3(2677.496,76.1169,-1880.355),
		Vector3(2652.903,81.15977,-1835.519),
		Vector3(-487.8229,-1.70036,1163.904),
		Vector3(1026.979,75.92828,-1052.156),
		Vector3(1031.718,84.6208,-1056.016),
		Vector3(966.5699,85.13107,-1080.624),
		Vector3(-855.5587,-16.27699,733.6937),
		Vector3(-833.2029,-15.90319,777.0134),
		Vector3(2424.981,97.67179,-937.2994),
		Vector3(2430.719,100.2974,-928.8987),
	}
end

function mafr_base.OnInitialize()
	Fox.Log("mafr_base.OnInitialize()")

	StageBlock.AddLargeBlockNameForMessage( mafr_base.baseList )
	TppLocation.RegistBaseAssetTable( mafr_base.OnActiveTable, mafr_base.OnActiveSmallBlockTable )
	mafr_base.RegisterCrackPoints()

	mafr_base.Messages = function()
		return
		Tpp.StrCode32Table{
			Trap = {
				
				{
					msg = "Enter",	sender = "trap_noFogArea06",
					func = function ()
						SunnyAreaSystem.UnlockSunnyArea{ areaName = "sunny_area_6" }
					end,
				},
				{
					msg = "Enter",	sender = "trap_noFogArea07",
					func = function ()	SunnyAreaSystem.UnlockSunnyArea{ areaName = "sunny_area_7" }	end,
				},
				{
					msg = "Enter",	sender = "trap_noFogArea08",
					func = function ()	SunnyAreaSystem.UnlockSunnyArea{ areaName = "sunny_area_8" }	end,
				},
			},
		}
	end
	mafr_base.messageExecTable = Tpp.MakeMessageExecTable( mafr_base.Messages() )

	mafr_base.OnMessage = function(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
		Tpp.DoMessage( mafr_base.messageExecTable,TppMission.CheckMessageOption, sender, messageId, arg0, arg1, arg2, arg3, strLogText)
	end

end

function mafr_base.OnReload()
	Fox.Log("mafr_base.OnReload()")
end


return mafr_base