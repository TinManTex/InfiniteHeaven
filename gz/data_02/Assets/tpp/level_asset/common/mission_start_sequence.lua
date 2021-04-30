






mission_start_sequence = {





sequences = {
	{ "SEQ_START",			},	
	{ "SEQ_OPENING_DEMO",	"/Assets/tpp/level_asset/common/mission_start_sequence_ground.lua"	},	
	{ "SEQ_TELOP",		"/Assets/tpp/level_asset/common/mission_start_sequence_ground.lua"	},	
	{ "SEQ_TELOP_HELI",	"/Assets/tpp/level_asset/common/mission_start_sequence_heli.lua"	},	
	{ "SEQ_END",				},	
},






SEQ_START = {

	OnEnter = function( manager )






		
		if missionCommon_functionSet.IsFromHelicopter() == false then

			
			missionCommon_functionSet.SetOpeningTelopCallBackSetting("/Assets/tpp/level_asset/common/mission_start_sequence.lua", "FuncStartTelopEnd")

			
			manager:RegisterReceiveMessageFromDemo( "DemoTelopTiming" )
			TppEventSequenceManagerCollector.GoNextSequence( "TppEventSequenceManagerData_mission_start", "SEQ_OPENING_DEMO" )
		else

			
			missionCommon_functionSet.SetOpeningTelopCallBackSetting("/Assets/tpp/level_asset/common/mission_start_sequence.lua", "FuncStartTelopHeliEnd")

			TppEventSequenceManagerCollector.GoNextSequence( "TppEventSequenceManagerData_mission_start", "SEQ_TELOP_HELI" )

		end

		
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:SetMissionTelopCallBackPreFade()

	end,

},

SEQ_END = {

	OnEnter = function( manager )




		
		manager:AllSequencesIsEnded()
	end,

},





FuncStartTelopEnd = function()



	TppEventSequenceManagerCollector.GoNextSequence( "TppEventSequenceManagerData_mission_start", "SEQ_END" )
end,


FuncStartTelopHeliEnd = function()



	TppEventSequenceManagerCollector.GoNextSequence( "TppEventSequenceManagerData_mission_start", "SEQ_END" )
end,

}
