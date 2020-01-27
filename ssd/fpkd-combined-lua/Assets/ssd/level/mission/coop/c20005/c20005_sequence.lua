local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.sequences = {
	"Seq_Game_ExplainArea",
	"Seq_Game_Tips_Area",
	"Seq_Game_ExplainObjective",
	"Seq_Game_Tips_Objective",
	"Seq_Game_MissionStart",
	"Seq_Game_ExplainSingularity",
	"Seq_Game_ExplainMenu",
	"Seq_Game_Tips_Menu",
	"Seq_Game_BeforeWave",
	"Seq_Game_DefenseWave1_1",
	"Seq_Game_DefenseWave1_2",
	"Seq_Game_DefenseBreak1",
	"Seq_Game_DefenseWave2",
	"Seq_Game_DefenseBreak2",
	"Seq_Game_Tips_StealthArea",
	"Seq_Game_StealthArea",
	"Seq_Game_GoToStealthArea",
	"Seq_Game_ReturnToMine",
	"Seq_Game_ExplainRetreat",
	"Seq_Game_Tips_Retreat",
	"Seq_Game_DefenseWave3",
	"Seq_Game_DefenseBreak3",
	"Seq_Game_ExplainReward",
	"Seq_Game_Reward",
	"Seq_Game_Clear",
}




this.INITIAL_CAMERA_ROTATION = { 20, 330 }
this.MISSION_START_INITIAL_ACTION = PlayerInitialAction.SQUAT
this.MISSION_WORLD_CENTER = Vector3( 420, 270, 2210 )	
this.INITIAL_INFINIT_OXYGEN = true


this.DEFENSE_MAP_LOCATOR_NAME = "afgh_field_cp"	


local DEFAULT_WAVE_ANNIHILATION = 3

this.UNSET_PAUSE_MENU_SETTING = {
	GamePauseMenu.RESTART_FROM_CHECK_POINT,
	GamePauseMenu.RESTART_FROM_MISSION_START,
}










this.rankScoreList = {
	400000,	
	200000,	
	100000,	
	50000,	
	25000,	
	0,	
}




this.targetGimmickTable = {
	locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
	datasetName = "/Assets/ssd/level/mission/coop/c20005/c20005_item.fox2",
	type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
}




this.importantGimmickTableList = {
}
table.insert( this.importantGimmickTableList, this.targetGimmickTable )




this.rankRewardTableListList = {
	{	
		{ percent = 10, id = "RCP_DEF_Fence_B", count = 1, },
		{ percent = 10, id = "RCP_ACC_Helmet_05", count = 1, },
		{ percent = 10, id = "RCP_ACC_Helmet_00", count = 1, },

		{ percent = 20, id = "RES_Leather", count = 20, },
		{ percent = 20, id = "RES_Nail", count = 20, },
		{ percent = 20, id = "RES_Grass_A", count = 20, },
		{ percent = 20, id = "RES_Meat_A", count = 20, },
		{ percent = 20, id = "RES_Meat_B", count = 20, },
		{ percent = 20, id = "RES_Water_A", count = 20, },
		{ percent = 20, id = "RES_Cotton", count = 20, },
		{ percent = 20, id = "RES_Gauze", count = 20, },
		{ percent = 20, id = "RES_Grass_B", count = 20, },

		
		{ id = "RES_Oil", count = 1, },
		{ id = "RES_Iron", count = 1, },
		{ id = "RES_Wood", count = 1, },
	},
	{	
		{ percent = 20, id = "RES_Lead", count = 10, },
		{ percent = 20, id = "RES_Metal_Wire", count = 10, },
		{ percent = 20, id = "RES_Plastic", count = 10, },
		{ percent = 20, id = "RES_Rubber", count = 10, },
		{ percent = 20, id = "RES_Screw", count = 10, },
		{ percent = 20, id = "RES_Solvent", count = 10, },
		{ percent = 20, id = "RES_Spring", count = 10, },
		{ percent = 20, id = "RES_Tin", count = 10, },
		{ percent = 20, id = "RES_Animal_Fiber", count = 10, },
		{ percent = 20, id = "RES_Ceramic", count = 10, },
		{ percent = 20, id = "RES_Concrete", count = 10, },
		{ percent = 20, id = "RES_Copper", count = 10, },
		{ percent = 20, id = "RES_Fabric", count = 10, },
		{ percent = 20, id = "RES_Gear", count = 10, },
		{ percent = 20, id = "RES_Glass", count = 10, },

		{ percent = 20, id = "RCP_DEF_Fence_B", count = 1, },
		{ percent = 20, id = "RCP_ACC_Helmet_05", count = 1, },
		{ percent = 20, id = "RCP_ACC_Helmet_00", count = 1, },

		{ percent = 30, id = "RES_Leather", count = 20, },
		{ percent = 30, id = "RES_Nail", count = 20, },
		{ percent = 30, id = "RES_Grass_A", count = 20, },
		{ percent = 30, id = "RES_Meat_A", count = 20, },
		{ percent = 30, id = "RES_Meat_B", count = 20, },
		{ percent = 30, id = "RES_Water_A", count = 20, },
		{ percent = 30, id = "RES_Cotton", count = 20, },
		{ percent = 30, id = "RES_Gauze", count = 20, },
		{ percent = 30, id = "RES_Grass_B", count = 20, },

		{ id = "RES_Oil", count = 5, },
		{ id = "RES_Iron", count = 5, },
		{ id = "RES_Wood", count = 5, },
	},
	{	
		{ percent = 30, id = "RES_Lead", count = 10, },
		{ percent = 30, id = "RES_Metal_Wire", count = 10, },
		{ percent = 30, id = "RES_Plastic", count = 10, },
		{ percent = 30, id = "RES_Rubber", count = 10, },
		{ percent = 30, id = "RES_Screw", count = 10, },
		{ percent = 30, id = "RES_Solvent", count = 10, },
		{ percent = 30, id = "RES_Spring", count = 10, },
		{ percent = 30, id = "RES_Tin", count = 10, },
		{ percent = 30, id = "RES_Animal_Fiber", count = 10, },
		{ percent = 30, id = "RES_Ceramic", count = 10, },
		{ percent = 30, id = "RES_Concrete", count = 10, },
		{ percent = 30, id = "RES_Copper", count = 10, },
		{ percent = 30, id = "RES_Fabric", count = 10, },
		{ percent = 30, id = "RES_Gear", count = 10, },
		{ percent = 30, id = "RES_Glass", count = 10, },

		{ percent = 30, id = "RCP_EQP_WP_hg00", count = 1, },
		{ percent = 30, id = "RCP_FOD_Dish_C", count = 1, },
		{ percent = 30, id = "RCP_ACC_Helmet_02", count = 1, },
		{ percent = 30, id = "RCP_ACC_Body_18", count = 1, },
		{ percent = 30, id = "RCP_ACC_Body_00", count = 1, },
		{ percent = 30, id = "RCP_ACC_Body_03", count = 1, },

		{ percent = 40, id = "RES_Leather", count = 20, },
		{ percent = 40, id = "RES_Nail", count = 20, },
		{ percent = 40, id = "RES_Grass_A", count = 20, },
		{ percent = 40, id = "RES_Meat_A", count = 20, },
		{ percent = 40, id = "RES_Meat_B", count = 20, },
		{ percent = 40, id = "RES_Water_A", count = 20, },
		{ percent = 40, id = "RES_Cotton", count = 20, },
		{ percent = 40, id = "RES_Gauze", count = 20, },
		{ percent = 40, id = "RES_Grass_B", count = 20, },

		{ id = "RES_Oil", count = 10, },
		{ id = "RES_Iron", count = 10, },
		{ id = "RES_Wood", count = 10, },
	},
	{	
		{ percent = 30, id = "RES_GunPowder", count = 5, },
		{ percent = 30, id = "RES_Junk_Cloth", count = 5, },
		{ percent = 30, id = "RES_Junk_Facility", count = 5, },
		{ percent = 30, id = "RES_Junk_Gun", count = 5, },
		{ percent = 30, id = "RES_Junk_Ic", count = 5, },
		{ percent = 30, id = "RES_Junk_MedicalKit", count = 5, },

		{ percent = 30, id = "RCP_EQP_WP_hg00", count = 1, },
		{ percent = 30, id = "RCP_FOD_Dish_C", count = 1, },
		{ percent = 30, id = "RCP_ACC_Helmet_02", count = 1, },
		{ percent = 30, id = "RCP_ACC_Body_18", count = 1, },
		{ percent = 30, id = "RCP_ACC_Body_00", count = 1, },
		{ percent = 30, id = "RCP_ACC_Body_03", count = 1, },

		{ percent = 40, id = "RES_Lead", count = 10, },
		{ percent = 40, id = "RES_Metal_Wire", count = 10, },
		{ percent = 40, id = "RES_Plastic", count = 10, },
		{ percent = 40, id = "RES_Rubber", count = 10, },
		{ percent = 40, id = "RES_Screw", count = 10, },
		{ percent = 40, id = "RES_Solvent", count = 10, },
		{ percent = 40, id = "RES_Spring", count = 10, },
		{ percent = 40, id = "RES_Tin", count = 10, },
		{ percent = 40, id = "RES_Animal_Fiber", count = 10, },
		{ percent = 40, id = "RES_Ceramic", count = 10, },
		{ percent = 40, id = "RES_Concrete", count = 10, },
		{ percent = 40, id = "RES_Copper", count = 10, },
		{ percent = 40, id = "RES_Fabric", count = 10, },
		{ percent = 40, id = "RES_Gear", count = 10, },
		{ percent = 40, id = "RES_Glass", count = 10, },

		{ percent = 40, id = "RCP_DEF_Fence_B", count = 1, },
		{ percent = 40, id = "RCP_ACC_Helmet_05", count = 1, },
		{ percent = 40, id = "RCP_ACC_Helmet_00", count = 1, },

		{ percent = 50, id = "RES_Leather", count = 20, },
		{ percent = 50, id = "RES_Nail", count = 20, },
		{ percent = 50, id = "RES_Grass_A", count = 20, },
		{ percent = 50, id = "RES_Meat_A", count = 20, },
		{ percent = 50, id = "RES_Meat_B", count = 20, },
		{ percent = 50, id = "RES_Water_A", count = 20, },
		{ percent = 50, id = "RES_Cotton", count = 20, },
		{ percent = 50, id = "RES_Gauze", count = 20, },
		{ percent = 50, id = "RES_Grass_B", count = 20, },

		{ id = "RES_Oil", count = 20, },
		{ id = "RES_Iron", count = 20, },
		{ id = "RES_Wood", count = 20, },
	},
	{	
		{ percent = 40, id = "RES_GunPowder", count = 5, },
		{ percent = 40, id = "RES_Junk_Cloth", count = 5, },
		{ percent = 40, id = "RES_Junk_Facility", count = 5, },
		{ percent = 40, id = "RES_Junk_Gun", count = 5, },
		{ percent = 40, id = "RES_Junk_Ic", count = 5, },
		{ percent = 40, id = "RES_Junk_MedicalKit", count = 5, },

		{ percent = 40, id = "RCP_EQP_WP_hg00", count = 1, },
		{ percent = 40, id = "RCP_FOD_Dish_C", count = 1, },
		{ percent = 40, id = "RCP_ACC_Helmet_02", count = 1, },
		{ percent = 40, id = "RCP_ACC_Body_18", count = 1, },
		{ percent = 40, id = "RCP_ACC_Body_00", count = 1, },
		{ percent = 40, id = "RCP_ACC_Body_03", count = 1, },

		{ percent = 50, id = "RES_Lead", count = 10, },
		{ percent = 50, id = "RES_Metal_Wire", count = 10, },
		{ percent = 50, id = "RES_Plastic", count = 10, },
		{ percent = 50, id = "RES_Rubber", count = 10, },
		{ percent = 50, id = "RES_Screw", count = 10, },
		{ percent = 50, id = "RES_Solvent", count = 10, },
		{ percent = 50, id = "RES_Spring", count = 10, },
		{ percent = 50, id = "RES_Tin", count = 10, },
		{ percent = 50, id = "RES_Animal_Fiber", count = 10, },
		{ percent = 50, id = "RES_Ceramic", count = 10, },
		{ percent = 50, id = "RES_Concrete", count = 10, },
		{ percent = 50, id = "RES_Copper", count = 10, },
		{ percent = 50, id = "RES_Fabric", count = 10, },
		{ percent = 50, id = "RES_Gear", count = 10, },
		{ percent = 50, id = "RES_Glass", count = 10, },

		{ percent = 50, id = "RCP_DEF_Fence_B", count = 1, },
		{ percent = 50, id = "RCP_ACC_Helmet_05", count = 1, },
		{ percent = 50, id = "RCP_ACC_Helmet_00", count = 1, },

		{ percent = 60, id = "RES_Leather", count = 20, },
		{ percent = 60, id = "RES_Nail", count = 20, },
		{ percent = 60, id = "RES_Grass_A", count = 20, },
		{ percent = 60, id = "RES_Meat_A", count = 20, },
		{ percent = 60, id = "RES_Meat_B", count = 20, },
		{ percent = 60, id = "RES_Water_A", count = 20, },
		{ percent = 60, id = "RES_Cotton", count = 20, },
		{ percent = 60, id = "RES_Gauze", count = 20, },
		{ percent = 60, id = "RES_Grass_B", count = 20, },

		{ id = "RES_Oil", count = 50, },
		{ id = "RES_Iron", count = 50, },
		{ id = "RES_Wood", count = 50, },
	},
	{	
		{ percent = 50, id = "RES_GunPowder", count = 5, },
		{ percent = 50, id = "RES_Junk_Cloth", count = 5, },
		{ percent = 50, id = "RES_Junk_Facility", count = 5, },
		{ percent = 50, id = "RES_Junk_Gun", count = 5, },
		{ percent = 50, id = "RES_Junk_Ic", count = 5, },
		{ percent = 50, id = "RES_Junk_MedicalKit", count = 5, },

		{ percent = 50, id = "RCP_EQP_WP_hg00", count = 1, },
		{ percent = 50, id = "RCP_FOD_Dish_C", count = 1, },
		{ percent = 50, id = "RCP_ACC_Helmet_02", count = 1, },
		{ percent = 50, id = "RCP_ACC_Body_18", count = 1, },
		{ percent = 50, id = "RCP_ACC_Body_00", count = 1, },
		{ percent = 50, id = "RCP_ACC_Body_03", count = 1, },

		{ percent = 60, id = "RES_Lead", count = 10, },
		{ percent = 60, id = "RES_Metal_Wire", count = 10, },
		{ percent = 60, id = "RES_Plastic", count = 10, },
		{ percent = 60, id = "RES_Rubber", count = 10, },
		{ percent = 60, id = "RES_Screw", count = 10, },
		{ percent = 60, id = "RES_Solvent", count = 10, },
		{ percent = 60, id = "RES_Spring", count = 10, },
		{ percent = 60, id = "RES_Tin", count = 10, },
		{ percent = 60, id = "RES_Animal_Fiber", count = 10, },
		{ percent = 60, id = "RES_Ceramic", count = 10, },
		{ percent = 60, id = "RES_Concrete", count = 10, },
		{ percent = 60, id = "RES_Copper", count = 10, },
		{ percent = 60, id = "RES_Fabric", count = 10, },
		{ percent = 60, id = "RES_Gear", count = 10, },
		{ percent = 60, id = "RES_Glass", count = 10, },

		{ percent = 60, id = "RCP_DEF_Fence_B", count = 1, },
		{ percent = 60, id = "RCP_ACC_Helmet_05", count = 1, },
		{ percent = 60, id = "RCP_ACC_Helmet_00", count = 1, },

		{ percent = 70, id = "RES_Leather", count = 20, },
		{ percent = 70, id = "RES_Nail", count = 20, },
		{ percent = 70, id = "RES_Grass_A", count = 20, },
		{ percent = 70, id = "RES_Meat_A", count = 20, },
		{ percent = 70, id = "RES_Meat_B", count = 20, },
		{ percent = 70, id = "RES_Water_A", count = 20, },
		{ percent = 70, id = "RES_Cotton", count = 20, },
		{ percent = 70, id = "RES_Gauze", count = 20, },
		{ percent = 70, id = "RES_Grass_B", count = 20, },

		{ id = "RES_Oil", count = 100, },
		{ id = "RES_Iron", count = 100, },
		{ id = "RES_Wood", count = 100, },
	},
}








function this.OnLoad()
	Fox.Log("#### OnLoad ####")
	
	
	TppSequence.RegisterSequences( this.sequences )
	TppSequence.RegisterSequenceTable( this.sequences )
end





this.saveVarsList = {
	waveCount = 0,	
}


this.checkPointList = {
	"CHK_DefenseWave",
	nil,
}


this.baseList = {
	nil
}




this.CounterList = {
}







this.missionObjectiveDefine = {
	marker_all_disable = {},
	marker_target = {
		gameObjectName = "marker_target", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true, langId = "marker_power", goalType = "moving", viewType = "all",
	},
	marker_target_disable = {},
	marker_stealthArea = {
		gameObjectName = "marker_stealthArea", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true, langId = "marker_power", goalType = "moving", viewType = "all",
	},
	marker_stealthArea_disable = {},
	marker_defense1 = {
		gameObjectName = "marker_defense1", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true, langId = "marker_power", goalType = "moving", viewType = "all",
	},
	marker_defense1_disable = {},
}











this.missionObjectiveTree = {
	marker_all_disable = {
		marker_stealthArea_disable = {
			marker_stealthArea = {
				marker_defense1_disable = {
					marker_defense1 = {
						marker_target_disable = {
							marker_target = {
							},
						},
					},
				},
			},
		},
	},
}

this.missionObjectiveEnum = Tpp.Enum{
	"marker_all_disable",
	"marker_target",
	"marker_target_disable",
	"marker_stealthArea",
	"marker_stealthArea_disable",
	"marker_defense1",
	"marker_defense1_disable",
}




this.waveSequenceSettings = {
	{	
		waveName = "wave_01_1",
		waveLimitTime = 90.0,
		waveAnnihilation = 0,
	},
	{	
		waveName = "wave_01_2",
		waveLimitTime = 90.0,
		waveAnnihilation = 0,
	},
	{	
		waveName = "wave_02",
		waveLimitTime = 120.0,
		waveAnnihilation = 0,
	},
	{	
		waveName = "wave_03",
		waveLimitTime = 180.0,
		waveAnnihilation = 0,
	},
	{	
		waveName = "wave_04",
		waveLimitTime = 240.0,
	},
	{	
		waveName = "wave_05",
		waveLimitTime = 260.0,
	},
	{	
		waveName = "wave_06",
		waveLimitTime = 280.0,
	},
	{	
		waveName = "wave_07",
		waveLimitTime = 300.0,
	},
}


function this.MissionPrepare()
	Fox.Log( "c20005_sequence.MissionPrepare()" )

	local systemCallbackTable ={
		OnEstablishMissionClear = function( missionClearType )
			
			if mvars.finalRewardDropped then
				Fox.Log( "c20005_sequence.OnTerminate(): SsdRewardCbox.ObtainAll()" )
				SsdRewardCbox.ObtainAll()
			end

			
			TppMission.SetNextMissionCodeForMissionClear( 21005 )
			TppMission.MissionGameEnd()
		end,
		OnDisappearGameEndAnnounceLog = function( missionClearType )
			Player.SetPause()
			TppMission.ShowMissionReward()
		end,
		OnEndMissionReward = function()
			local missionClearType = TppMission.GetMissionClearType()
			TppMission.MissionFinalize{ isNoFade = true }
		end,
		
		OnOutOfMissionArea = function()
			TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA, TppDefine.GAME_OVER_RADIO.S10020_OUT_OF_MISSION_AREA )
		end,
		nil
	}

	
	TppMission.RegiserMissionSystemCallback( systemCallbackTable )

	
	FogWallController.SetEnabled( false )

	
	ScriptParam.SetValue{ category = ScriptParamCategory.PLAYER, paramName = "infiniteOxygen", value = true, }

	
	Mission.SetWaveCount( 7 )

	
	Mission.SetRankBoaderPoints {
		S = this.rankScoreList[ 1 ],
		A = this.rankScoreList[ 2 ],
		B = this.rankScoreList[ 3 ],
		C = this.rankScoreList[ 4 ],
		D = this.rankScoreList[ 5 ],
	}

	
	GameObject.SendCommand( { type = "TppCommandPost2", }, { id = "SetStealthUnitMax", count = 8, } )
end


function this.OnTerminate()
	Fox.Log( "c20005_sequence.OnTerminate()" )

	
	FogWallController.SetEnabled( true )

	
	ScriptParam.ResetValueToDefault{ category = ScriptParamCategory.PLAYER, paramName = "infiniteOxygen" }

	
	ResultSystem.RequestClose()
end






function this.OnGameOver()
end


function this.OnRestoreSVars()
	Fox.Log( "c20005_sequence.OnRestoreSVars()" )

	
	mvars.waveCount = svars.waveCount	

	
	if mvars.waveCount > 0 then
		mvars.continueFromDefenseBreak = true
	end
end




function this.OnEndMissionPrepareSequence()

	Fox.Log( "c20005_sequence.OnEndMissionPrepareSequence()" )

	
	TppWeather.ForceRequestWeather( TppDefine.WEATHER.FOGGY, 0.01, { fogDensity = 0.01 } )
	WeatherManager.ClearTag( "ssd_ClearSky", 5 )

	
	if Tpp.IsTypeTable( this.importantGimmickTableList ) then
		for _, gimmickTable in ipairs( this.importantGimmickTableList ) do
			Gimmick.ResetGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, gimmickTable.locatorName, gimmickTable.datasetName )
		end
	end

	
	local targetGimmickTable = this.targetGimmickTable
	Gimmick.InvisibleGimmick( targetGimmickTable.type, targetGimmickTable.locatorName, targetGimmickTable.datasetName, true )

	
	SsdSbm.AddProduction{ id = "PRD_EQP_SWP_Digger", count = 1, toInventory = false, tryEquip = true, }

	Player.RequestToAppearWithWormhole( 0.0 )

	
	TppClock.SetTime("09:00:00")
end




this.GoToClearSequence = function()
	Fox.Log( "c20005_sequence.GoToClearSequence()" )
	local currentSequenceIndex = TppSequence.GetCurrentSequenceIndex()
	if currentSequenceIndex < TppSequence.GetSequenceIndex( "Seq_Game_ExplainReward" ) then
		TppSequence.SetNextSequence( "Seq_Game_ExplainReward" )
	end
end




this.StartWave = function( waveCount )
	Fox.Log( "c20005_sequence.StartWave(): waveCount:" .. tostring( waveCount ) )

	local targetPosition = { 423.8629, 271.3565, 2209.768, }
	TppMission.SetDefensePosition( targetPosition )

	local waveSequenceSetting = this.waveSequenceSettings[ waveCount ]
	if not waveSequenceSetting then
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave.OnEnter(): ignore process because there are no wave settings." )
		return
	end
	local gameObjectId = { type = "SsdZombie", }
	GameObject.SendCommand( gameObjectId, { id = "SetWaveAttacker", pos = targetPosition, radius = 30.0, } )

	GameObject.SendCommand( { type = "SsdZombie", }, { id = "SetDefenseAi", active = true, } )

	local waveName = waveSequenceSetting.waveName
	local waveLimitTime = waveSequenceSetting.waveLimitTime
	Mission.StartWave{ waveName = waveName, waveLimitTime = waveLimitTime, }

end





local wormholePositionTableList = {
	{
		position = Vector3( 427.818, 269.822, 2202.483 ),
		height = 5,
	},
	{
		position = Vector3( 418.959, 269.984, 2217.844 ),
		height = 5,
	},
	{
		position = Vector3( 423.600, 270.523, 2239.306 ),
		height = 5,
	},
	{
		position = Vector3( 426.360, 269.829, 2177.280 ),
		height = 5,
	},
	{
		position = Vector3( 433.204, 269.643, 2219.803 ),
		height = 5,
	},
	{
		position = Vector3( 389.071, 270.038, 2204.706 ),
		height = 5,
	},
	{
		position = Vector3( 446.701, 269.332, 2198.158 ),
		height = 5,
	},
	{
		position = Vector3( 407.301, 278.052, 2221.048 ),
		height = 5,
	},
	{
		position = Vector3( 437.486, 278.640, 2184.819 ),
		height = 5,
	},
	{
		position = Vector3( 398.111, 270.642, 2174.773 ),
		height = 5,
	},
	{
		position = Vector3( 455.695, 269.870, 2221.562 ),
		height = 5,
	},
	{
		position = Vector3( 417.521, 274.072, 2229.456 ),
		height = 5,
	},
	{
		position = Vector3( 390.705, 271.765, 2242.118 ),
		height = 5,
	},
	{
		position = Vector3( 449.075, 269.196, 2171.753 ),
		height = 5,
	},
	{
		position = Vector3( 400.956, 270.648, 2175.404 ),
		height = 5,
	},
	{
		position = Vector3( 413.015, 270.133, 2206.914 ),
		height = 5,
	},
	{
		position = Vector3( 436.938, 274.681, 2230.839 ),
		height = 5,
	},
	{
		position = Vector3( 465.588, 268.263, 2213.008 ),
		height = 5,
	},
}


local waveWormholeResourceListList = {	
	{	
		{ "COL_WoodBox_A", "COL_Chair_B", "COL_Wolf", },
		{ "COL_WoodBox_C", "COL_Radio", "COL_Goat", },
		{ "COL_WoodBox_F", "COL_BioResource", "COL_Bottle" },
	},
	{	
		{ "COL_Drum_A", "COL_Bonfire", "COL_Desk", },
		{ "COL_Chair_B", "COL_Chair_B", "COL_WormWood", },
		{ "COL_Signboard", "COL_Radio", "COL_BioResource", },
	},
	{	
		{ "COL_Bonfire", "COL_Radio", "COL_Radio", },
		{ "COL_Wolf", "COL_WoodBox_C", "COL_FuelResource", },
		{ "COL_Fence", "COL_Chair_B", "COL_BioResource", },
	},
	{	
		{ "COL_Drum_A", "COL_PlasticTank_C", "COL_BioResource", },
		{ "COL_Chair_B", "COL_Radio", "COL_FuelResource", },
		{ "COL_Signboard", "COL_Sandbag", "COL_FuelResource", },
	},
	{	
		{ "COL_Radio", "COL_Bonfire", "COL_PreciousMetal", },
		{ "COL_Chair_B", "COL_FuelResource", "COL_FuelResource", },
		{ "COL_Bottle", "COL_Radio", "COL_BioResource", },
	},
	{	
		{ "COL_CommonMetal", "COL_FuelResource", "COL_PreciousMetal", },
		{ "COL_RareMetal", "COL_CommonMetal", "COL_FuelResource", },
		{ "COL_PreciousMetal", "COL_RareMetal", "COL_BioResource", },
	},
}

this.GoToWave3Sequence = function()
	local currentSequenceIndex = TppSequence.GetCurrentSequenceIndex()
	if TppSequence.GetSequenceIndex( "Seq_Game_DefenseBreak2" ) <= currentSequenceIndex and currentSequenceIndex < TppSequence.GetSequenceIndex( "Seq_Game_DefenseWave3" ) then
		TppSequence.SetNextSequence( "Seq_Game_DefenseWave3" )
	end
end




this.messageTable = {
	Player = {
		{
			msg = "Dead",
			func = function()
				
				TppUI.ShowAnnounceLog( "staff_dead" )
			end,
		},
	},
	GameObject = {
		{
			msg = "BrokenMiningMachine",
			func = function()
				Fox.Log( "c20005_sequence.Messages(): GameObject: BrokenMiningMachine:" )

				mvars.miningMachineBroken = true
				TppUI.ShowAnnounceLog( "target_died" )
				this.GoToClearSequence()
			end,
		},
		{	
			msg = "FinishDefenseGame",
			func = function()
				mvars.timeUp = true
				this.GoToClearSequence()
			end,
		},
		{	
			msg = "BrokenTreasureBox",
			func = function()
				Fox.Log( "c20005_sequence.Messages(): msg:BrokenTreasureBox" )
				mvars.treasureBoxDead = true
				this.GoToClearSequence()
			end,
		},
		{	
			msg = "VotingResult",
			func = function( sender, result )
				Fox.Log( "c20005_sequence.Messages(): msg:VotingResult, sender:" .. tostring( sender ) .. ", result:" .. tostring( result ) )
				if result == Mission.VOTING_ESCAPE and TppSequence.GetCurrentSequenceIndex() < TppSequence.GetSequenceIndex( "Seq_Game_Clear" ) then
					this.GoToClearSequence()
				end
			end,
		},
		{	
			msg = "SwitchGimmick",
			func = function( gameObjectId, locatorName, upperLocatorName, on )

				Fox.Log( "c20005_sequence.Messages(): GameObject: SwitchGimmick: gameObjectId:" .. tostring( gameObjectId ) .. ", locatorName:" .. tostring( locatorName ) ..
					", upperLocatorName:" .. tostring( upperLocatorName ) .. ", on:" .. tostring( on ) )

				if locatorName == Fox.StrCode32( this.targetGimmickTable.locatorName ) then	
					SsdSbm.ShowSettlementReport()	

					if TppSequence.GetCurrentSequenceIndex() < TppSequence.GetSequenceIndex( "Seq_Game_Tips_Menu" ) then
						TppSequence.SetNextSequence( "Seq_Game_Tips_Menu" )
					end
				end
			end,
		},
		{
			msg = "DefenseChangeState",
			func = function( sender, state )
				Fox.Log( "c20005_sequence.Messages(): GameObject: DefenseChangeState: sender:" .. tostring( sender ) .. ", state:" .. tostring( state ) )
				if state == TppDefine.DEFENSE_GAME_STATE.ESCAPE then
					this.GoToClearSequence()
				elseif state == TppDefine.DEFENSE_GAME_STATE.WAVE then
					this.GoToWave3Sequence()
				end
			end,
		},
		{
			msg = "DefenseTotatlResult",
			func = function( sender, score )
				Fox.Log( "c20005_sequence.Messages(): DefenceGameDaemon: msg:DefenseTotatlResult, sender:" .. tostring( sender ) .. ", score:" .. tostring( score ) )
				mvars.finalScore = score
			end,
		},
		{	
			msg = "FinishWaveInterval",
			func = function()
				Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseBreak.Messages(): GameObject: msg:FinishWaveInterval," )

				this.GoToWave3Sequence()
			end,
		},
		{	
			msg = "BreakGimmick",
			func = function( gameObjectId, locatorName, upperLocatorName, on )

				Fox.Log( "c20005_sequence.Messages(): GameObject: BreakGimmick: gameObjectId:" ..
					tostring( gameObjectId ) .. ", locatorName:" .. tostring( locatorName ) ..
					", upperLocatorName:" .. tostring( upperLocatorName ) .. ", on:" .. tostring( on ) )

				if locatorName == Fox.StrCode32( this.targetGimmickTable.locatorName ) and TppSequence.GetCurrentSequenceIndex() < TppSequence.GetSequenceIndex( "Seq_Game_DefenseWave3" ) then
					TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.TARGET_DEAD, TppDefine.GAME_OVER_RADIO.TARGET_DEAD )
				end
			end,
		},
		{	
			msg = "BuildingEnd",
			func = function( gameObjectId, typeId, productionId )
				Fox.Log( "BuildingEnd:" )
				if productionId == Fox.StrCode32( "PRD_EQP_SWP_Digger" ) then
					if TppSequence.GetCurrentSequenceIndex() < TppSequence.GetSequenceIndex( "Seq_Game_ExplainMenu" ) then
						TppSequence.SetNextSequence( "Seq_Game_ExplainMenu" )
					end
				end
			end,
		},
	},
	Timer = {
		{	
			sender = "Timer_Resources",
			msg = "Finish",
			func = function()
				Fox.Log( "c20005_sequence.Messages(): Timer: sender:Timer_Resources, msg:Finish" )

				if not mvars.resourcesDropCount then
					mvars.resourcesDropCount = 0
				end

				
				
				if TppSequence.GetCurrentSequenceName() == "Seq_Game_DefenseWave" then	
					
					local tmpWormholeResourceList = {}
					for waveCount, wormholeResourceTableList in ipairs( waveWormholeResourceListList ) do
						for _, wormholeResourceTable in ipairs( wormholeResourceTableList ) do
							Fox.Log( "wormholeResourceTable:" .. tostring( wormholeResourceTable ) )
							table.insert( tmpWormholeResourceList, wormholeResourceTable )
						end
						Fox.Log( "waveCount:" .. tostring( waveCount ) .. ", mvars.waveCount:" .. tostring( mvars.waveCount ) )
						if waveCount >= mvars.waveCount then
							break
						end
					end

					
					local wormholeResourceTable = tmpWormholeResourceList[ mvars.resourcesDropCount % #tmpWormholeResourceList + 1 ]
					if Tpp.IsTypeTable( wormholeResourceTable ) then
						local wormholePositionTable = wormholePositionTableList[ mvars.resourcesDropCount % #wormholePositionTableList + 1 ]
						if Tpp.IsTypeTable( wormholePositionTable ) then
							local position = wormholePositionTable.position
							local height = wormholePositionTable.height
							if Tpp.IsTypeTable( wormholeResourceTable ) and position then
								Fox.Log( "wormholePositionTable" .. tostring( wormholePositionTable ) .. ", position:" .. tostring( position ) .. ", height:" .. tostring( height ) )
								Gimmick.DropWormholeResources{
									pos = position,
									resources = wormholeResourceTable,
									height = height,
									randomCount = wormholeResourceTable.randomCount,	
									randomOffset = wormholeResourceTable.randomOffset,	
								}
							else
								Fox.Log( "c20005_sequence.Messages(): Timer: sender:Timer_Resources, msg:Finish, waveWormholeResourceListList[ " .. tostring( mvars.resourcesDropCount ) .. " ]:" .. tostring( wormholeResourceTable ) )
							end
						else
							Fox.Log( "wormholeResourceTable:" .. tostring( wormholeResourceTable ) )
						end
					end
				end

				mvars.resourcesDropCount = mvars.resourcesDropCount + 1

				GkEventTimerManager.Start( "Timer_Resources", 10 )	
			end,
		},
	},
	UI = {
		{	
			msg = "MiningMachineMenuRequestPulloutSelected",
			func = function()
				Fox.Log( "c20005_sequence.Messages(): UI: msg:MiningMachineMenuRequestPulloutSelected" )

				Mission.VoteEscape()
			end,
		},
		{	
			msg = "MiningMachineMenuCancelPulloutSelected",
			func = function()
				Fox.Log( "c20005_sequence.Messages(): UI: msg:MiningMachineMenuCancelPulloutSelected" )
			end,
		},
		{	
			msg = "MiningMachineMenuRestartMachineSelected",
			func = function()
				Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseBreak.Messages(): UI: msg:MiningMachineMenuRestartMachineSelected" )
				local currentSequenceIndex = TppSequence.GetCurrentSequenceIndex()
				if currentSequenceIndex < TppSequence.GetSequenceIndex( "Seq_Game_DefenseWave1_1" ) then
					TppSequence.SetNextSequence( "Seq_Game_DefenseWave1_1" )
				elseif TppSequence.GetSequenceIndex( "Seq_Game_DefenseBreak2" ) <= currentSequenceIndex and currentSequenceIndex < TppSequence.GetSequenceIndex( "Seq_Game_DefenseBreak3" ) then
					TppMission.StopWaveInterval()
				end
			end,
		},
	},
	Sbm = {
		{
			msg = "OnGetItem",
			func = function( itemId, productionType, isProduction, count )
				SsdRecipe.UnlockConditionClearedRecipe()
			end,
		},
	},
	Trap = {
		{
			sender = "trap_singularity",
			msg = "Enter",
			func = function()
				if TppSequence.GetCurrentSequenceIndex() < TppSequence.GetSequenceIndex( "Seq_Game_ExplainSingularity" ) then
					TppSequence.SetNextSequence( "Seq_Game_ExplainSingularity" )
				end
			end,
		},
	},
}

function this.Messages()
	return StrCode32Table( this.messageTable )
end




function this.GoToNextSequenceIfWaveExist( nextSequence1, nextSequence2)

	Fox.Log( "c20005_sequence.GoToNextSequenceIfWaveExist(): nextSequence1:" .. tostring( nextSequence1 ) .. ", nextSequence2:" .. tostring( nextSequence2 ) )

	
	local waveSequenceSetting = this.waveSequenceSettings[ mvars.waveCount + 1 ]
	if waveSequenceSetting then	
		TppSequence.SetNextSequence( nextSequence1 )
	else	
		TppSequence.SetNextSequence( nextSequence2 )
	end

end




this.SetWaveEffectVisibility = function( waveCount, visibility )
	Fox.Log( "c20005_sequence.SetWaveMistVisible(): waveCount:" .. tostring( waveCount ) .. ", visibility:" .. tostring( visibility ) )

	local waveSetting = this.waveSequenceSettings[ waveCount ]
	if waveSetting then
		local nextWaveName = waveSetting.waveName
		if nextWaveName then
			local spawnLocatorNames = c20005_enemy.GetSpawnLocatorNames( nextWaveName )
			if Tpp.IsTypeTable( spawnLocatorNames ) then
				for _, spawnLocatorName in ipairs( spawnLocatorNames ) do
					GameObject.SendCommand( { type = "TppCommandPost2", }, { id = "EnableWaveEffect", locatorName = spawnLocatorName, enabled = visibility, } )
				end
			end

			
			MapInfoSystem.ClearAllWavePoints()

			
			MapInfoSystem.SetWavePoints{ locatorNames = spawnLocatorNames, }
		end
	end
end






this.sequences.Seq_Game_ExplainArea = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_ExplainArea.OnEnter(): self:" .. tostring( self ) )

		TppMission.StartDefenseGame( 3600, 60 )

		
		TppUiStatusManager.SetStatus( "SsdUiCoopTutorial", "COOP_TUTORIAL_50", "SsdUiCoopTutorial" )

		c20005_radio.PlaySequenceRadio()
		GkEventTimerManager.Start( "Timer_Seq_Game_ExplainArea", 10 )
	end,

	Messages = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_ExplainArea.Messages(): self:" .. tostring( self ) )
		return StrCode32Table{
			Radio = {
				{
					msg = "Finish",
					func = function()
						TppSequence.SetNextSequence( "Seq_Game_Tips_Area" )
						GkEventTimerManager.Stop( "Timer_Seq_Game_ExplainArea" )
					end,
				},
			},
			Timer = {
				{
					sender = "Timer_Seq_Game_ExplainArea",
					msg = "Finish",
					func = function()
						if TppRadioCommand.IsPlayingRadio() then
							GkEventTimerManager.Start( "Timer_Seq_Game_ExplainArea", 1 )
						else
							TppSequence.SetNextSequence( "Seq_Game_Tips_Area" )
						end
					end,
				},
			},
		}
	end,
}

this.sequences.Seq_Game_Tips_Area = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_Tips_Area.OnEnter(): self:" .. tostring( self ) )

		TppTutorial.StartHelpTipsMenu{
			tipsTypes = { HelpTipsType.TIPS_1_A, HelpTipsType.TIPS_1_B, HelpTipsType.TIPS_1_C, },
			endFunction = function()
				TppSequence.SetNextSequence( "Seq_Game_ExplainObjective" )
			end,
		}
	end,
}

this.sequences.Seq_Game_ExplainObjective = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_ExplainObjective.OnEnter(): self:" .. tostring( self ) )

		c20005_radio.PlaySequenceRadio()
		GkEventTimerManager.Start( "Timer_Seq_Game_ExplainObjective", 10 )
	end,

	Messages = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_ExplainObjective.Messages(): self:" .. tostring( self ) )
		return StrCode32Table{
			Radio = {
				{
					msg = "Finish",
					func = function()
						GkEventTimerManager.Stop( "Timer_Seq_Game_ExplainObjective" )
						TppSequence.SetNextSequence( "Seq_Game_Tips_Objective" )
					end,
				},
			},
			Timer = {
				{
					sender = "Timer_Seq_Game_ExplainObjective",
					msg = "Finish",
					func = function()
						if TppRadioCommand.IsPlayingRadio() then
							GkEventTimerManager.Start( "Timer_Seq_Game_ExplainObjective", 1 )
						else
							TppSequence.SetNextSequence( "Seq_Game_Tips_Objective" )
						end
					end,
				},
			},
		}
	end,
}

this.sequences.Seq_Game_Tips_Objective = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_Tips_Objective.OnEnter(): self:" .. tostring( self ) )

		TppTutorial.StartHelpTipsMenu{
			tipsRadio = "Seq_Game_Tips_Objective",
			tipsTypes = { HelpTipsType.TIPS_1_A, HelpTipsType.TIPS_1_B, HelpTipsType.TIPS_1_C, },
			endFunction = function()
				TppSequence.SetNextSequence( "Seq_Game_MissionStart" )
			end,
		}
	end,
}

this.sequences.Seq_Game_MissionStart = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_MissionStart.OnEnter(): self:" .. tostring( self ) )
		TppMission.UpdateObjective{ objectives = { "marker_target", },  }

		c20005_radio.PlaySequenceRadio()
	end,
}

this.sequences.Seq_Game_ExplainSingularity = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_MissionStart.OnEnter(): self:" .. tostring( self ) )

		c20005_radio.PlaySequenceRadio()
	end,
}

this.sequences.Seq_Game_ExplainBoot = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_ExplainBoot.OnEnter(): self:" .. tostring( self ) )

		
		local targetGimmickTable = this.targetGimmickTable
		Gimmick.ResetGimmick( targetGimmickTable.type, targetGimmickTable.locatorName, targetGimmickTable.datasetName, { needSpawnEffect = true, } )

		c20005_radio.PlaySequenceRadio()
	end,
}

this.sequences.Seq_Game_ExplainMenu = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_ExplainMenu.OnEnter(): self:" .. tostring( self ) )

		c20005_radio.PlaySequenceRadio()
	end,
}

this.sequences.Seq_Game_Tips_Menu = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_Tips_Menu.OnEnter(): self:" .. tostring( self ) )

		TppTutorial.StartHelpTipsMenu{
			
			tipsTypes = { HelpTipsType.TIPS_1_A, HelpTipsType.TIPS_1_B, HelpTipsType.TIPS_1_C, },
			endFunction = function()
				TppSequence.SetNextSequence( "Seq_Game_BeforeWave" )
			end,
		}
	end,
}

this.sequences.Seq_Game_BeforeWave = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_BeforeWave.OnEnter(): self:" .. tostring( self ) )

		c20005_radio.PlaySequenceRadio()
	end,
}

this.sequences.Seq_Game_DefenseWave1_1 = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave1_1.OnEnter(): self:" .. tostring( self ) )

		
		TppDataUtility.DestroyEffectFromGroupId( "singularity" )

		
		mvars.waveCount = mvars.waveCount + 1

		
		this.SetWaveEffectVisibility( mvars.waveCount, true )

		
		this.StartWave( mvars.waveCount )

		TppMission.UpdateObjective{ objectives = { "marker_target_disable", }, }

		c20005_radio.PlaySequenceRadio()
	end,

	Messages = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave1_1.OnEnter(): self:" .. tostring( self ) )
		return StrCode32Table{
			GameObject = {
				{	
					msg = "FinishWave",
					func = function( waveName, waveIndex )
						Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave1_1.Messages(): GameObject: FinishWave: waveName:" ..
							tostring( waveName ) .. ", waveIndex:" .. tostring( waveIndex ) )

						TppSequence.SetNextSequence( "Seq_Game_DefenseWave1_2" )
					end,
				},
			},
		}
	end,

	OnLeave = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave1_1.OnLeave(): self:" .. tostring( self ) )
		this.SetWaveEffectVisibility( mvars.waveCount, false )
	end,
}

this.sequences.Seq_Game_DefenseWave1_2 = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave1_2.OnEnter(): self:" .. tostring( self ) )

		
		mvars.waveCount = mvars.waveCount + 1

		
		this.SetWaveEffectVisibility( mvars.waveCount, true )

		
		this.StartWave( mvars.waveCount )

		TppMission.UpdateObjective{ objectives = { "marker_defense1", }, }

		c20005_radio.PlaySequenceRadio()
	end,

	Messages = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave1_2.OnEnter(): self:" .. tostring( self ) )
		return StrCode32Table{
			GameObject = {
				{	
					msg = "FinishWave",
					func = function( waveName, waveIndex )
						Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave1_2.Messages(): GameObject: FinishWave: waveName:" ..
							tostring( waveName ) .. ", waveIndex:" .. tostring( waveIndex ) )

						TppSequence.SetNextSequence( "Seq_Game_DefenseBreak1" )
					end,
				},
			},
		}
	end,

	OnLeave = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave1_2.OnLeave(): self:" .. tostring( self ) )

		this.SetWaveEffectVisibility( mvars.waveCount, false )

		
		GameObject.SendCommand( { type = "TppCommandPost2", }, { id = "EndWave", } )

		
		GameObject.SendCommand( { type = "SsdZombie", }, { id = "SetDefenseAi", active = false, } )

		
		TppDataUtility.CreateEffectFromGroupId( "explosion" )	
		TppSoundDaemon.PostEvent( "sfx_s_waveend_plasma" )
		GameObject.SendCommand( { type="TppCommandPost2", }, { id = "KillWaveEnemy", } )	

		
		local result = Gimmick.AreaBreak{
			pos = Vector3( 423.8629, 271.3565, 2209.768 ),
			radius = 60,
			damageValue = 30000,
			ineffectiveTypes = {
				"GIM_P_ElectricGenerator",
				"GIM_P_AI",
				"GIM_P_WeaponPlant",
				"GIM_P_Kitchen",
				"GIM_P_DefensePlant",
				"GIM_P_Goal",
				"GIM_P_TreasureBox",
				"GIM_P_AccessoryPlant",
				"GIM_P_MedicalPlant",
				"GIM_P_GadgetPlant",
				"GIM_P_Warehouse",
				"GIM_P_AI_Skill",
				"GIM_P_MissionGate",
				"GIM_P_AI_Building",
				"GIM_P_Portal",
				"GIM_P_Digger",
			},
		}

		TppMission.UpdateObjective{ objectives = { "marker_defense1_disable", }, }
	end,
}

this.sequences.Seq_Game_DefenseBreak1 = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseBreak1.OnEnter(): self:" .. tostring( self ) )

		
		this.SetWaveEffectVisibility( mvars.waveCount + 1, true )

		TppMission.StartWaveInterval( 60 )

		c20005_radio.PlaySequenceRadio()
	end,

	Messages = function( self ) 
		return
		StrCode32Table {
			GameObject = {
				{	
					msg = "FinishWaveInterval",
					func = function()
						Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseBreak.Messages(): GameObject: msg:FinishWaveInterval," )

						TppSequence.SetNextSequence( "Seq_Game_DefenseWave2" )
					end,
				},
				{	
					msg = "DefenseChangeState",
					func = function( sender, state )
						Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseBreak.Messages(): GameObject: DefenseChangeState: sender:" .. tostring( sender ) .. ", state:" .. tostring( state ) )
						if state == TppDefine.DEFENSE_GAME_STATE.WAVE then
							TppSequence.SetNextSequence( "Seq_Game_DefenseWave2" )
						end
					end,
				},
			},
			UI = {
				{	
					msg = "MiningMachineMenuRestartMachineSelected",
					func = function()
						Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseBreak.Messages(): UI: msg:MiningMachineMenuRestartMachineSelected" )

						
						TppMission.StopWaveInterval()
					end,
				},
			},
		}
	end,
}

this.sequences.Seq_Game_DefenseWave2 = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave2.OnEnter(): self:" .. tostring( self ) )

		
		TppUiStatusManager.UnsetStatus( "SsdUiCoopTutorial", "COOP_TUTORIAL_50", "SsdUiCoopTutorial" )
		TppUiStatusManager.SetStatus( "SsdUiCoopTutorial", "COOP_TUTORIAL_60", "SsdUiCoopTutorial" )

		
		mvars.waveCount = mvars.waveCount + 1

		
		this.SetWaveEffectVisibility( mvars.waveCount, true )

		
		this.StartWave( mvars.waveCount )

		c20005_radio.PlaySequenceRadio()
	end,

	Messages = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave2.OnEnter(): self:" .. tostring( self ) )
		return StrCode32Table{
			GameObject = {
				{	
					msg = "FinishWave",
					func = function( waveName, waveIndex )
						Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave2.Messages(): GameObject: FinishWave: waveName:" ..
							tostring( waveName ) .. ", waveIndex:" .. tostring( waveIndex ) )

						TppSequence.SetNextSequence( "Seq_Game_DefenseBreak2" )
					end,
				},
			},
		}
	end,

	OnLeave = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave2.OnLeave(): self:" .. tostring( self ) )

		
		GameObject.SendCommand( { type = "TppCommandPost2", }, { id = "EndWave", } )

		
		GameObject.SendCommand( { type = "SsdZombie", }, { id = "SetDefenseAi", active = false, } )

		
		TppDataUtility.CreateEffectFromGroupId( "explosion" )	
		TppSoundDaemon.PostEvent( "sfx_s_waveend_plasma" )
		GameObject.SendCommand( { type="TppCommandPost2", }, { id = "KillWaveEnemy", } )	

		
		local result = Gimmick.AreaBreak{
			pos = Vector3( 423.8629, 271.3565, 2209.768 ),
			radius = 60,
			damageValue = 30000,
			ineffectiveTypes = {
				"GIM_P_ElectricGenerator",
				"GIM_P_AI",
				"GIM_P_WeaponPlant",
				"GIM_P_Kitchen",
				"GIM_P_DefensePlant",
				"GIM_P_Goal",
				"GIM_P_TreasureBox",
				"GIM_P_AccessoryPlant",
				"GIM_P_MedicalPlant",
				"GIM_P_GadgetPlant",
				"GIM_P_Warehouse",
				"GIM_P_AI_Skill",
				"GIM_P_MissionGate",
				"GIM_P_AI_Building",
				"GIM_P_Portal",
				"GIM_P_Digger",
			},
		}
	end,
}

this.sequences.Seq_Game_DefenseBreak2 = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseBreak2.OnEnter(): self:" .. tostring( self ) )

		
		this.SetWaveEffectVisibility( mvars.waveCount + 1, true )

		TppMission.StartWaveInterval( 600 )

		c20005_radio.PlaySequenceRadio()
		GkEventTimerManager.Start( "Timer_Seq_Game_DefenseBreak2", 10 )
	end,

	Messages = function( self ) 
		return
		StrCode32Table {
			Radio = {
				{
					msg = "Finish",
					func = function()
						GkEventTimerManager.Stop( "Timer_Seq_Game_DefenseBreak2" )
						TppSequence.SetNextSequence( "Seq_Game_Tips_StealthArea" )
					end,
				},
			},
			Timer = {
				{
					sender = "Timer_Seq_Game_DefenseBreak2",
					msg = "Finish",
					func = function()
						if TppRadioCommand.IsPlayingRadio() then
							GkEventTimerManager.Start( "Timer_Seq_Game_DefenseBreak2", 1 )
						else
							TppSequence.SetNextSequence( "Seq_Game_Tips_StealthArea" )
						end
					end,
				},
			},
		}
	end,
}

this.sequences.Seq_Game_Tips_StealthArea = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_Tips_StealthArea.OnEnter(): self:" .. tostring( self ) )

		TppTutorial.StartHelpTipsMenu{
			tipsTypes = { HelpTipsType.TIPS_1_A, HelpTipsType.TIPS_1_B, HelpTipsType.TIPS_1_C, },
			endFunction = function()
				TppSequence.SetNextSequence( "Seq_Game_GoToStealthArea" )
			end,
		}
	end,
}

this.sequences.Seq_Game_GoToStealthArea = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_GoToStealthArea.OnEnter(): self:" .. tostring( self ) )

		TppMission.UpdateObjective{ objectives = { "marker_stealthArea", }, }

		local gameObjectId = { type = "TppCommandPost2", }
		GameObject.SendCommand( gameObjectId, { id = "StartWave", waveName = "wave_stealthArea", } )
		GameObject.SendCommand( gameObjectId, { id = "EnableWaveEffect", locatorName = "SpawnPoint_stealthArea", enabled = true, } )

		c20005_radio.PlaySequenceRadio()
	end,

	Messages = function( self )
		return StrCode32Table{
			Trap = {
				{
					sender = "trap_stealthArea",
					msg = "Enter",
					func = function()
						Fox.Log( "c20005_sequence.sequences.Seq_Game_GoToStealthArea.Messages(): Trap: sender:trap_stealthArea, msg:Enter" )
						TppSequence.SetNextSequence( "Seq_Game_StealthArea" )
					end,
				},
			},
		}
	end,

	OnLeave = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_GoToStealthArea.OnEnter(): self:" .. tostring( self ) )

		local gameObjectId = { type = "TppCommandPost2", }
		GameObject.SendCommand( gameObjectId, { id = "EnableWaveEffect", locatorName = "SpawnPoint_stealthArea", enabled = true, } )
	end,
}

this.sequences.Seq_Game_StealthArea = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_StealthArea.OnEnter(): self:" .. tostring( self ) )

		TppMission.UpdateObjective{ objectives = { "marker_stealthArea_disable", "marker_target", },  }
		c20005_radio.PlaySequenceRadio()
	end,

	Messages = function( self )
		return StrCode32Table{
			Trap = {
				{
					sender = "trap_stealthArea",
					msg = "Exit",
					func = function()
						Fox.Log( "c20005_sequence.sequences.Seq_Game_StealthArea.Messages(): Trap: sender:trap_stealthArea, msg:Exit" )
						TppSequence.SetNextSequence( "Seq_Game_ReturnToMine" )
					end,
				},
			},
		}
	end,

	OnLeave = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_StealthArea.OnEnter(): self:" .. tostring( self ) )
	end,
}

this.sequences.Seq_Game_ReturnToMine = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_ReturnToMine.OnEnter(): self:" .. tostring( self ) )
		c20005_radio.PlaySequenceRadio()
	end,

	Messages = function( self )
		return StrCode32Table{
			Trap = {
				{
					sender = "trap_mine",
					msg = "Enter",
					func = function()
						Fox.Log( "c20005_sequence.sequences.Seq_Game_ReturnToMine.Messages(): Trap: sender:trap_mine, msg:Enter" )
						TppSequence.SetNextSequence( "Seq_Game_ExplainRetreat" )
					end,
				},
			},
		}
	end,
}

this.sequences.Seq_Game_ExplainRetreat = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_ExplainRetreat.OnEnter(): self:" .. tostring( self ) )

		
		TppUiStatusManager.UnsetStatus( "SsdUiCoopTutorial", "COOP_TUTORIAL_60", "SsdUiCoopTutorial" )

		c20005_radio.PlaySequenceRadio()
		GkEventTimerManager.Start( "Timer_Seq_Game_ExplainRetreat", 10 )
	end,

	Messages = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_ExplainRetreat.Messages(): self:" .. tostring( self ) )
		return StrCode32Table{
			Radio = {
				{
					msg = "Finish",
					func = function()
						GkEventTimerManager.Stop( "Timer_Seq_Game_ExplainRetreat" )
						TppSequence.SetNextSequence( "Seq_Game_Tips_Retreat" )
					end,
				},
			},
			Timer = {
				{
					sender = "Timer_Seq_Game_ExplainRetreat",
					msg = "Finish",
					func = function()
						if TppRadioCommand.IsPlayingRadio() then
							GkEventTimerManager.Start( "Timer_Seq_Game_ExplainRetreat", 1 )
						else
							TppSequence.SetNextSequence( "Seq_Game_Tips_Retreat" )
						end
					end,
				},
			},
		}
	end,
}

this.sequences.Seq_Game_Tips_Retreat = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_Tips_Retreat.OnEnter(): self:" .. tostring( self ) )

		TppTutorial.StartHelpTipsMenu{
			tipsTypes = { HelpTipsType.TIPS_1_A, HelpTipsType.TIPS_1_B, HelpTipsType.TIPS_1_C, },
			endFunction = function()
				
				
			end,
		}
	end,
}

this.sequences.Seq_Game_ExplainWave3 = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_ExplainWave3.OnEnter(): self:" .. tostring( self ) )

		c20005_radio.PlaySequenceRadio()
		GkEventTimerManager.Start( "Timer_Seq_Game_ExplainWave3", 10 )
	end,

	Messages = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_ExplainWave3.Messages(): self:" .. tostring( self ) )
		return StrCode32Table{
			Radio = {
				{
					msg = "Finish",
					func = function()
						GkEventTimerManager.Stop( "Timer_Seq_Game_ExplainWave3" )
						TppSequence.SetNextSequence( "Seq_Game_DefenseWave3" )
					end,
				},
			},
			Timer = {
				{
					sender = "Timer_Seq_Game_ExplainRetreat",
					msg = "Finish",
					func = function()
						if TppRadioCommand.IsPlayingRadio() then
							GkEventTimerManager.Start( "Timer_Seq_Game_ExplainWave3", 1 )
						else
							TppSequence.SetNextSequence( "Seq_Game_DefenseWave3" )
						end
					end,
				},
			},
		}
	end,
}


this.sequences.Seq_Game_DefenseWave3 = {

	Messages = function( self ) 
		return
		StrCode32Table {
			GameObject = {
				{	
					msg = "FinishWave",
					func = function( waveName, waveIndex )
						Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave3.Messages(): GameObject: FinishWave: waveName:" .. tostring( waveName ) .. ", waveIndex:" .. tostring( waveIndex ) )

						
						this.GoToNextSequenceIfWaveExist( "Seq_Game_DefenseBreak3", "Seq_Game_ExplainReward" )
					end,
				},
				{	
					msg = "DefenseChangeState",
					func = function( sender, state )
						Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave3.Messages(): GameObject: DefenseChangeState: sender:" .. tostring( sender ) .. ", state:" .. tostring( state ) )
						if state == TppDefine.DEFENSE_GAME_STATE.WAVE_INTERVAL then
							this.GoToNextSequenceIfWaveExist( "Seq_Game_DefenseBreak3", "Seq_Game_ExplainReward" )
						end
					end,
				},
			},
		}
	end,

	OnEnter = function()
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave3.OnEnter()" )

		
		mvars.waveCount = mvars.waveCount + 1

		
		this.SetWaveEffectVisibility( mvars.waveCount, true )

		
		this.StartWave( mvars.waveCount )

		c20005_radio.PlaySequenceRadio()
	end,

	OnLeave = function()
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseWave3.OnLeave()" )

		
		GameObject.SendCommand( { type = "TppCommandPost2", }, { id = "EndWave", } )

		
		this.SetWaveEffectVisibility( mvars.waveCount, false )

		
		GameObject.SendCommand( { type = "SsdZombie", }, { id = "SetDefenseAi", active = false, } )

		
		TppDataUtility.CreateEffectFromGroupId( "explosion" )	
		TppSoundDaemon.PostEvent( "sfx_s_waveend_plasma" )
		GameObject.SendCommand( { type="TppCommandPost2", }, { id = "KillWaveEnemy", } )	

		
		local result = Gimmick.AreaBreak{
			pos = Vector3( 423.8629, 271.3565, 2209.768 ),
			radius = 60,
			damageValue = 30000,
			ineffectiveTypes = {
				"GIM_P_ElectricGenerator",
				"GIM_P_AI",
				"GIM_P_WeaponPlant",
				"GIM_P_Kitchen",
				"GIM_P_DefensePlant",
				"GIM_P_Goal",
				"GIM_P_TreasureBox",
				"GIM_P_AccessoryPlant",
				"GIM_P_MedicalPlant",
				"GIM_P_GadgetPlant",
				"GIM_P_Warehouse",
				"GIM_P_AI_Skill",
				"GIM_P_MissionGate",
				"GIM_P_AI_Building",
				"GIM_P_Portal",
				"GIM_P_Digger",
			},
		}
	end,

}


this.sequences.Seq_Game_DefenseBreak3 = {

	Messages = function( self ) 
		return
		StrCode32Table {
			GameObject = {
				{	
					msg = "FinishWaveInterval",
					func = function()
						Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseBreak3.Messages(): GameObject: msg:FinishWaveInterval," )

						this.GoToNextSequenceIfWaveExist( "Seq_Game_DefenseWave3", "Seq_Game_ExplainReward" )
					end,
				},
				{	
					msg = "DefenseChangeState",
					func = function( sender, state )
						Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseBreak3.Messages(): GameObject: DefenseChangeState: sender:" .. tostring( sender ) .. ", state:" .. tostring( state ) )
						if state == TppDefine.DEFENSE_GAME_STATE.WAVE then
							this.GoToNextSequenceIfWaveExist( "Seq_Game_DefenseWave3", "Seq_Game_ExplainReward" )
						end
					end,
				},
			},
		}
	end,

	OnEnter = function()
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseBreak3.OnEnter()" )

		
		if not mvars.continueFromDefenseBreak then	
			TppMission.StartWaveInterval( 120 )
		end

		
		this.SetWaveEffectVisibility( mvars.waveCount + 1, true )
	end,

	OnLeave = function()
		Fox.Log( "c20005_sequence.sequences.Seq_Game_DefenseBreak3.OnLeave()" )
	end,
}

this.sequences.Seq_Game_ExplainReward = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_ExplainReward.OnEnter(): self:" .. tostring( self ) )

		
		TppMission.StopDefenseTotalTime()

		
		GameObject.SendCommand( { type = "SsdZombie", }, { id = "SetAttackGoalItemAi", active = false, } )
		GameObject.SendCommand( { type = "SsdZombie", }, { id = "SetDefenseAi", active = false, } )

		
		TppMission.UpdateObjective{ objectives = { "marker_all_disable", }, }

		
		GameObject.SendCommand( { type = "TppCommandPost2", }, { id = "KillWaveEnemy", target = "All", } )

		c20005_radio.PlaySequenceRadio()
		GkEventTimerManager.Start( "Timer_Seq_Game_ExplainReward", 10 )
	end,

	Messages = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_ExplainReward.Messages(): self:" .. tostring( self ) )
		return StrCode32Table{
			Radio = {
				{
					msg = "Finish",
					func = function()
						GkEventTimerManager.Stop( "Timer_Seq_Game_ExplainReward" )
						TppSequence.SetNextSequence( "Seq_Game_Reward" )
					end,
				},
			},
			Timer = {
				{
					sender = "Timer_Seq_Game_ExplainReward",
					msg = "Finish",
					func = function()
						if TppRadioCommand.IsPlayingRadio() then
							GkEventTimerManager.Start( "Timer_Seq_Game_ExplainReward", 1 )
						else
							TppSequence.SetNextSequence( "Seq_Game_Reward" )
						end
					end,
				},
			},
		}
	end,
}


this.sequences.Seq_Game_Reward = {
	OnEnter = function()
		Fox.Log( "c20005_sequence.sequences.Seq_Game_Clear.OnEnter()" )

		
		GkEventTimerManager.Start( "Timer_Reward", 3 )

		
		ResultSystem.OpenCoopResult()
	end,

	Messages = function( self ) 
		return StrCode32Table {
			Timer = {
				{	
					sender = "Timer_Reward",
					msg = "Finish",
					func = function()
						Fox.Log( "sequences.Seq_Game_Clear.Messages(): Timer: sender:Timer_Reward, msg:Finish" )

						
						if mvars.finalScore then
							local rankRewardTableListList = this.rankRewardTableListList

							
							if not mvars.finalRank then
								mvars.finalRank = #this.rankScoreList
								for i, rankScore in ipairs( this.rankScoreList ) do
									if mvars.finalScore >= rankScore then
										mvars.finalRank = i
										break
									end
								end
							end

							
							if not mvars.currentRewardIndex then
								mvars.currentRewardIndex = 1
							end
							if mvars.currentRewardIndex <= 6 - mvars.finalRank + 1 then
								local rankRewardTableList = rankRewardTableListList[ mvars.currentRewardIndex ]
								local contents = {}
								for _, rankRewardTable in ipairs( rankRewardTableList ) do
									if not rankRewardTable.percent or math.random( 0, 10000 ) / 100 <= rankRewardTable.percent then
										table.insert( contents, rankRewardTable )
										if #contents >= 4 then
											break
										end
									end
								end
								SsdRewardCbox.Drop{
									pos = Vector3( 423.786 + math.random( -500, 500 ) / 100, 281.357, 2209.870 + math.random( -500, 500 ) / 100 ),
									contents = contents,
								}

								
								mvars.finalRewardDropped = true

								mvars.currentRewardIndex = mvars.currentRewardIndex + 1
							end
						end

						
						GkEventTimerManager.Start( "Timer_Reward", 3 )
					end,
				},
			},
			UI = {
				{	
					msg = "CoopMissionResultClosed",
					option = { isExecMissionClear = true }, 
					func = function()
						Fox.Log( tostring( missionName ) .. "_sequence.Messages(): UI: msg:CoopMissionResultClosed" )
						TppSequence.SetNextSequence( "Seq_Game_Clear" )
					end,
				},
			},
		}
	end,
}

this.sequences.Seq_Game_Clear = {
	OnEnter = function( self )
		Fox.Log( "c20005_sequence.sequences.Seq_Game_Clear.OnEnter(): self:" .. tostring( self ) )

		c20005_radio.PlaySequenceRadio()
		GkEventTimerManager.Start( "Timer_Seq_Game_Clear", 10 )
	end,

	OnMissionEnd = function()
		
		SsdSbm.ClearResourcesInInventory()

		
		TppMission.ReserveMissionClear{
			missionClearType = TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,
			nextMissionId = 21005,
		}
	end,

	Messages = function( self )
		Fox.Log( "c20005_sequence.sequences.Timer_Seq_Game_Clear.Messages(): self:" .. tostring( self ) )
		return StrCode32Table{
			Radio = {
				{
					msg = "Finish",
					func = function()
						GkEventTimerManager.Stop( "Timer_Seq_Game_Clear" )
						self.OnMissionEnd()
					end,
				},
			},
			Timer = {
				{
					sender = "Timer_Seq_Game_Clear",
					msg = "Finish",
					func = function()
						if TppRadioCommand.IsPlayingRadio() then
							GkEventTimerManager.Start( "Timer_Seq_Game_Clear", 1 )
						else
							self.OnMissionEnd()
						end
					end,
				},
			},
		}
	end,
}




return this
