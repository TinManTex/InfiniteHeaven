





local  afgh_base = {}

local SMALL_INDEX_TO_DATA_IDENTIFIER_NAME = {
	[ "132_146" ]		= "DataIdentifier_132_146_identifier",
	[ "133_146" ]		= "DataIdentifier_133_146_identifier",
	[ "133_147" ]		= "DataIdentifier_133_147_identifier",
	[ "afgh_south" ]	= "DataIdentifier_afgh_south_identifier",
	[ "afgh_village" ]	= "DataIdentifier_afgh_village_identifier",
}

local AI_GIMMICK_TABLE_LIST = {
	{
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		locatorName = "com_ai001_gim_n0000|srt_aip0_main0_def",
		datasetName = "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",
	},
}

local DIGGER_GIMMICI_TABLE_LIST = {
	{
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
		datasetName = "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset.fox2",
	},
}

afgh_base.baseList = {
	
	"afgh_enemyBase",
	"afgh_field",
	"afgh_village",
	"afgh_base",
	"afgh_dungeon2",
}




afgh_base.SetAfghLastAssetVisibility = function( before )
	Fox.Log( "afgh_base.SetAiVisibility(): before:" .. tostring( before ) )

	if Tpp.IsLoadedLargeBlock( "afgh_base" ) then
		local identifier = "DataIdentifier_afgh_base_identifier"
		local col_identifier = "DataIdentifier_afgh_base_col_identifier"
		
		TppDataUtility.SetVisibleDataFromIdentifier( identifier, "p30_000040_before_ON_after_OFF", before, true )
		TppDataUtility.SetVisibleDataFromIdentifier( identifier, "p30_000050_before_ON_after_OFF", before, true )
		TppDataUtility.SetVisibleDataFromIdentifier( identifier, "p30_000060_before_ON_after_OFF", before, true )
		TppDataUtility.SetEnableDataFromIdentifier( col_identifier, "col_p30_000050_before_ON_after_OFF", before, true )	
		TppDataUtility.SetEnableDataFromIdentifier( col_identifier, "col_p30_000060_before_ON_after_OFF", before, true )	

		
		TppDataUtility.SetVisibleDataFromIdentifier( identifier, "p30_000040_after_ON_before_OFF", not before, true )
		TppDataUtility.SetVisibleDataFromIdentifier( identifier, "p30_000050_after_ON_before_OFF", not before, true )
		TppDataUtility.SetVisibleDataFromIdentifier( identifier, "p30_000060_after_ON_before_OFF", not before, true )
		TppDataUtility.SetEnableDataFromIdentifier( col_identifier, "col_p30_000050_after_ON_before_OFF", not before, true )	
		TppDataUtility.SetEnableDataFromIdentifier( col_identifier, "col_p30_000060_after_ON_before_OFF", not before, true )	

		
		local pathDataSetName = "/Assets/ssd/level/location/afgh/block_large/base/afgh_base_path.fox2"
		local pathNameList = {
			"pathElude_LastAfghBefore_0000",
			"pathElude_LastAfghBefore_0001",
			"pathElude_LastAfghBefore_0002",
			"pathElude_LastAfghBefore_0003",
			"pathElude_LastAfghAfter_0000",
		}
		local pathEnableList = {
			before,
			before,
			before,
			before,
			not before,
		}
		for index, pathName in pairs( pathNameList ) do
			GeoPathService.EnablePath( pathDataSetName, pathName, pathEnableList[index] )
		end
	end
end




afgh_base.SetAfghOpeningAssetVisibility = function( visibility )
	Fox.Log( "afgh_base.SetAfghOpeningAssetVisibility(): visibility:" .. tostring( visibility ) )

	local identifier
	if Tpp.IsLoadedLargeBlock( "afgh_base" ) then
		identifier = "DataIdentifier_afgh_base_identifier"
	elseif Tpp.IsLoadedLargeBlock( "afgh_base2" ) then
		identifier = "DataIdentifier_afgh_base2_identifier"
	end
	if Tpp.IsTypeString( identifier ) then
		
		TppDataUtility.SetVisibleDataFromIdentifier( identifier, "ctv0_obj0_ssd_0000", visibility, true )
	end
end





afgh_base.SetAfghReeveReunionAssetVisibility = function( visibility )
	Fox.Log( "afgh_base.SetAfghReeveReunionAssetVisibility(): visibility:" .. tostring( visibility ) )

	local identifier
	if Tpp.IsLoadedLargeBlock( "afgh_base" ) then
		identifier = "DataIdentifier_afgh_base_identifier"
	elseif Tpp.IsLoadedLargeBlock( "afgh_base2" ) then
		identifier = "DataIdentifier_afgh_base2_identifier"
	end
	if Tpp.IsTypeString( identifier ) then
		
		TppDataUtility.SetVisibleDataFromIdentifier( identifier, "cypr_shlf002_vrtn009_0001", visibility, true )	
		TppDataUtility.SetVisibleDataFromIdentifier( identifier, "ssdm_door006_vrtn001_0000", visibility, true )	
	end
end

local SetGimmickVisibilityForTable = function( gimmickTable, visibility )
	for _, gimmickTable in ipairs( gimmickTable ) do
		Gimmick.InvisibleGimmick( gimmickTable.type, gimmickTable.locatorName, gimmickTable.datasetName, not visibility )
	end
end




afgh_base.SetReeveWheelChairAssetVisibility = function( visibility )
	Fox.Log( "afgh_base.SetReeveWheelChairAssetVisibility(): visibility:" .. tostring( visibility ) )
	local identifier
	if Tpp.IsLoadedSmallBlock( 128, 150 ) then
		identifier = "DataIdentifier_128_150_identifier"
	end
	if Tpp.IsTypeString( identifier ) then
		TppDataUtility.SetVisibleDataFromIdentifier( identifier, "ssde_wepn001_bedd001_0000", not visibility, true )	
	end
end




afgh_base.SetAiVisibility = function( visibility )
	Fox.Log( "afgh_base.SetAiVisibility(): visibility:" .. tostring( visibility ) )

	if Tpp.IsLoadedLargeBlock( "afgh_base" ) then
		SetGimmickVisibilityForTable( AI_GIMMICK_TABLE_LIST, visibility )
	end
end




afgh_base.SetDiggerVisibility = function( visibility )
	Fox.Log( "afgh_base.SetDiggerVisibility(): visibility:" .. tostring( visibility ) )

	if Tpp.IsLoadedLargeBlock( "afgh_base" ) then
		SetGimmickVisibilityForTable( DIGGER_GIMMICI_TABLE_LIST, visibility )
	end
end




afgh_base.SetSahelanVisibility = function( visibility )
	Fox.Log( "afgh_base.SetSahelanVisibility(): visibility:" .. tostring( visibility ) )

	if Tpp.IsLoadedLargeBlock( "afgh_base" ) then
		Gimmick.InvisibleGimmick(
			TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			"mgs0_gim_n0000|srt_mgs0_main0_ssd_v00",
			"/Assets/ssd/level/mission/story/s10060/s10060_mgs_gim.fox2",
			( not visibility )
		)
		TppDataUtility.SetEnableDataFromIdentifier( "DataIdentifier_afgh_base_col_identifier", "col_s10060_mgs_gim", visibility, true )	
	end
end




afgh_base.SetBaseFastTravelVisibility = function( visibility )
	Fox.Log( "afgh_base.SetBaseFastTravelVisibility(): visibility:" .. tostring( visibility ) )

	if Tpp.IsLoadedSmallBlock( 129, 150 ) then
		Gimmick.InvisibleGimmick(
			TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			"com_portal001_gim_n0000|srt_ftp0_main0_def_v00",
			"/Assets/ssd/level/location/afgh/block_small/129/129_150/afgh_129_150_gimmick.fox2",
			( not visibility )
		)
	else
		Fox.Warning( "afgh_base.SetBaseFastTravelVisibility(): Small block (129, 150) is not active." )
	end
end





afgh_base.SetBuildingAreaObjBrushVisibility = function()
	Fox.Log( "afgh_base.SetBuildingAreaObjBrushVisibility(): visibility:" .. tostring( visibility ) )
	local block_x_start = 101
	local block_z_start = 101
	local block_x_num = 64
	local block_x = 129
	local block_z = 150
	local block_id = (block_x - block_x_start) + (block_z - block_z_start) * block_x_num

	if SsdBuilding.GetLevel() == 2 then
		ObjectBrush.SetNonVisibleRange( block_id, -492, 2196, -404, 2284, block_x, block_z )
	elseif SsdBuilding.GetLevel() == 3 then
		ObjectBrush.SetNonVisibleRange( block_id, -508, 2180, -388, 2300, block_x, block_z )
	else
		ObjectBrush.SetNonVisibleRange()	
	end
end





afgh_base.AddOnBaseActivatedCallBackFunction = function( callBackFunction )
	Fox.Log( "afgh_base.AddOnBaseActivatedCallBackFunction(): callBackFunction:" .. tostring( callBackFunction ) )

	if not Tpp.IsTypeTable( mvars.loc_onBaseActivatedCallBackFunctions ) then
		mvars.loc_onBaseActivatedCallBackFunctions = {}
	end
	table.insert( mvars.loc_onBaseActivatedCallBackFunctions, callBackFunction )
end




afgh_base.ClearOnBaseActivatedCallBackFunction = function()
	Fox.Log( "afgh_base.ClearOnBaseActivatedCallBackFunction()" )
	mvars.loc_onBaseActivatedCallBackFunctions = nil
end




afgh_base.OnBaseActivated = function()
	Fox.Log( "afgh_base.OnBaseActivated()" )

	Fox.Log( "afgh_base.OnBaseActivated(): execute common function" )

	
	if SsdBuilding.GetLevel() >= 2 and SsdBuilding.GetItemCount{id="PRD_BLD_MB_Stair"} == 0 then
		SsdBuilding.CreateItemNoAreaCheck{row=16,col=16,buildingId=Fox.StrCode32("PRD_BLD_MB_Stair"),rotType=0}
	elseif SsdBuilding.GetLevel() <= 1 then
		SsdBuilding.RemoveItem{row=16,col=16,rotType=0}
	end

	
	afgh_base.SetBuildingAreaObjBrushVisibility()

	
	local currentStorySequence = TppStory.GetCurrentStorySequence()
	afgh_base.SetAfghLastAssetVisibility( currentStorySequence < TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST )

	
	if currentStorySequence <= TppDefine.STORY_SEQUENCE.STORY_START then
		afgh_base.SetAfghOpeningAssetVisibility( false )
	end

	
	afgh_base.SetReeveWheelChairAssetVisibility( currentStorySequence >= TppDefine.STORY_SEQUENCE.CLEARED_RETURN_TO_AFGH )

	
	afgh_base.SetSahelanVisibility( currentStorySequence >= TppDefine.STORY_SEQUENCE.CLEARED_k40230 )

	local callBackFunctionList = mvars.loc_onBaseActivatedCallBackFunctions
	if Tpp.IsTypeTable( callBackFunctionList ) and next( callBackFunctionList ) then	
		Fox.Log( "afgh_base.OnBaseActivated(): execute mission specific function, not common function" )
		for _, callBackFunction in ipairs( callBackFunctionList ) do
			callBackFunction()
		end
	end
end

local SetVisibleDataFromMultipleIdentifier = function( dataIdentifierNameList, key, visibility, recursive )
	for _, dataIdentifierName in ipairs( dataIdentifierNameList ) do
		TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, key, visibility, recursive )
	end
end

local ResetFogDungeonAsset = function( smallIndex )
	local currentStorySequence = TppStory.GetCurrentStorySequence()
	local dataIdentifierName = SMALL_INDEX_TO_DATA_IDENTIFIER_NAME[ smallIndex ]

	if Tpp.IsTypeString( dataIdentifierName ) then
		if currentStorySequence < TppDefine.STORY_SEQUENCE.CLEARED_k40015 then	
			TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, "Gate_Before", true, true )
			TppDataUtility.SetEnableDataFromIdentifier( dataIdentifierName, "col_Gate_Before", true, true )	
			TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, "Gate_After", false, true )
			
			TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, "Hostage_After", false, true )
			TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, "Hostage_Before", false, true )
			TppDataUtility.SetEnableDataFromIdentifier( dataIdentifierName, "col_Hostage_Before", true, true )	

			TppDataUtility.SetVisibleEffectFromGroupId( "Hostage_Before_fx", false )
			TppDataUtility.SetVisibleEffectFromGroupId( "Gate_After_fx", false )

			Nav.SetEnabledTacticalActionInRange( "", Vector3( -80.197, 273.478, 1909.941 ), 3.0, false )
		else	
			TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, "Gate_Before", false, true )
			TppDataUtility.SetEnableDataFromIdentifier( dataIdentifierName, "col_Gate_Before", false, true )	
			TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, "Gate_After", true, true )

			if currentStorySequence < TppDefine.STORY_SEQUENCE.CLEARED_k40020 then	
				TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, "Hostage_Before", true, true )
				TppDataUtility.SetEnableDataFromIdentifier( dataIdentifierName, "col_Hostage_Before", true, true )	
				TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, "Hostage_After", false, true )

				TppDataUtility.SetVisibleEffectFromGroupId( "Hostage_Before_fx", true )
				TppDataUtility.SetVisibleEffectFromGroupId( "Gate_After_fx", false )
			else	
				TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, "Hostage_Before", false, true )
				TppDataUtility.SetEnableDataFromIdentifier( dataIdentifierName, "col_Hostage_Before", false, true )	
				TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, "Hostage_After", true, true )

				TppDataUtility.SetVisibleEffectFromGroupId( "Hostage_Before_fx", false )
				TppDataUtility.SetVisibleEffectFromGroupId( "Gate_After_fx", true )
			end

			Nav.SetEnabledTacticalActionInRange( "", Vector3( -80.197, 273.478, 1909.941 ), 3.0, true )
		end

		
		if TppDefine.STORY_SEQUENCE.BEFORE_k40150 <= currentStorySequence then
			TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, "Dungeon_Barricade", false, true )
		
		else
			TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, "Dungeon_Barricade", true, true )
		end
	end
end

local ResetVillageAsset = function( smallIndex )
	local currentStorySequence = TppStory.GetCurrentStorySequence()
	local dataIdentifierName = SMALL_INDEX_TO_DATA_IDENTIFIER_NAME[ smallIndex ]
	if Tpp.IsTypeString( dataIdentifierName ) then
		
		if currentStorySequence < TppDefine.STORY_SEQUENCE.CLEARED_k40090 then
			TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, "k40130_asset", false, true )
		
		else
			TppDataUtility.SetVisibleDataFromIdentifier( dataIdentifierName, "k40130_asset", true, true )
		end
	end
end




afgh_base.OnActiveSmallBlockTable = {
	base = {	
		activeArea = { 128, 150, 129, 151 },
		OnActive = afgh_base.OnBaseActivated,
	},
	
	fogDungeon1_132_146 = {
		activeArea = { 132, 146, 132, 146, },
		OnActive = function()
			Fox.Log("afgh_base.OnActiveSmallBlockTable : fogDungeon1")
			ResetFogDungeonAsset( "132_146" )
			ResetFogDungeonAsset( "afgh_south" )
		end,
	},
	
	fogDungeon1_133_146 = {
		activeArea = { 133, 146, 133, 146, },
		OnActive = function()
			Fox.Log("afgh_base.OnActiveSmallBlockTable : fogDungeon1")
			ResetFogDungeonAsset( "133_146" )
			ResetFogDungeonAsset( "afgh_south" )
		end,
	},
	
	fogDungeon1_133_147 = {
		activeArea = { 133, 147, 133, 147, },
		OnActive = function()
			Fox.Log("afgh_base.OnActiveSmallBlockTable : fogDungeon1")
			ResetFogDungeonAsset( "133_147" )
			ResetFogDungeonAsset( "afgh_south" )
		end,
	},
	
	village_137_140 = {
		activeArea = { 137, 140, 137, 140, },
		OnActive = function()
			Fox.Log("afgh_base.OnActiveSmallBlockTable : village")
			ResetVillageAsset( "afgh_village" )
		end,
	},
}




afgh_base.OnActiveTable = {
}




function afgh_base.RegisterCrackPoints()
	Fox.Log( "afgh_base.RegisterCrackPoints" )
	TppUiCommand.RegisterCrackPoints{
		Vector3(451.4234,268.9413,2059.778),
		Vector3(502.491,270.4769,2179.7),
		Vector3(1464.682,353.1352,1433.652),
		Vector3(1607.16,361.2092,550.2523),
		Vector3(-594.5807,323.8413,647.9941),
		Vector3(-584.4622,325.0274,582.5809),
		Vector3(-463.1054,334.2138,355.8104),
		Vector3(-900.4858,290.3305,1956.564),
		Vector3(-726.0238,539.3185,-1366.024),
		Vector3(1980.945,307.5733,-496.1255),
		Vector3(1865.837,318.1019,-380.4251),
		Vector3(-1340.78,596.8517,-2771.541),
		Vector3(-1343.087,595.0551,-2782.617),
		Vector3(-1309.777,597.3832,-2971.19),
		Vector3(2091.219,478.2067,-1820.542),
		Vector3(529.3447,337.7473,9.986572),
		Vector3(764.3511,458.8442,-1036.495),
		Vector3(770.8134,460.0755,-1005.047),
		Vector3(-1446.582,294.3126,995.8232),
		Vector3(-1437.528,294.3657,980.6818),
		Vector3(-1376.357,292.0499,1006.505),
		Vector3(-1378.895,292.6224,1039.208),
		Vector3(-1373.945,295.9665,1050.913),
		Vector3(-1313.019,294.2779,1130.35),
		Vector3(-1292.315,291.9832,1161.58),
		Vector3(-1473.26,293.5357,961.9572),
		Vector3(-1328.514,292.6284,1108.255),
		Vector3(-885.243,296.3309,1930.643),
		Vector3(-347.5424,420.697,-487.0363),
	}
end

function afgh_base.OnInitialize()
	Fox.Log("afgh_base.OnInitialize()")

	StageBlock.AddLargeBlockNameForMessage( afgh_base.baseList )
	TppLocation.RegistBaseAssetTable( afgh_base.OnActiveTable, afgh_base.OnActiveSmallBlockTable )
	afgh_base.RegisterCrackPoints()

	afgh_base.Messages = function()
		return
		Tpp.StrCode32Table{
			Trap = {
				
				{
					msg = "Enter",	sender = "trap_noFogArea01",
					func = function ()	SunnyAreaSystem.UnlockSunnyArea{ areaName = "sunny_area_1" }	end,
				},
				{
					msg = "Enter",	sender = "trap_noFogArea02",
					func = function ()	SunnyAreaSystem.UnlockSunnyArea{ areaName = "sunny_area_2" }	end,
				},
				{
					msg = "Enter",	sender = "trap_noFogArea03",
					func = function ()	SunnyAreaSystem.UnlockSunnyArea{ areaName = "sunny_area_3" }	end,
				},
				{
					msg = "Enter",	sender = "trap_noFogArea04",
					func = function ()	SunnyAreaSystem.UnlockSunnyArea{ areaName = "sunny_area_4" }	end,
				},
				{
					msg = "Enter",	sender = "trap_noFogArea05",
					func = function ()	SunnyAreaSystem.UnlockSunnyArea{ areaName = "sunny_area_5" }	end,
				},
			},
		}
	end
	afgh_base.messageExecTable = Tpp.MakeMessageExecTable( afgh_base.Messages() )

	afgh_base.OnMessage = function(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
		Tpp.DoMessage( afgh_base.messageExecTable,TppMission.CheckMessageOption, sender, messageId, arg0, arg1, arg2, arg3, strLogText)
	end

end

function afgh_base.OnReload()
	Fox.Log("afgh_base.OnReload()")
end

return afgh_base
