






mission_end_sequence = {





sequences = {
	{ "SEQ_START",			},	
	{ "SEQ_TELOP",		"/Assets/tpp/level_asset/common/mission_end_sequence_ground.lua"	},		
	{ "SEQ_TELOP_HELI",	"/Assets/tpp/level_asset/common/mission_end_sequence_heli.lua"	},	
	{ "SEQ_END",				},	
},






SEQ_START = {

	OnEnter = function( manager )






		
		if missionCommon_functionSet.IsFromHelicopter() == false then
			
			
			TppEventSequenceManagerCollector.GoNextSequence( "TppEventSequenceManagerData_mission_end", "SEQ_TELOP" )
		else
			
			
			TppEventSequenceManagerCollector.GoNextSequence( "TppEventSequenceManagerData_mission_end", "SEQ_TELOP_HELI" )

		end

		
		
		
	end,

},

SEQ_END = {

	OnEnter = function( manager )




		
		manager:AllSequencesIsEnded()
	end,

},





















}

