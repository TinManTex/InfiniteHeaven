
mission_end_sequence_ground = {

SEQ_TELOP = {

	OnEnter = function( manager )




		missionCommon_functionSet.SetSequenceIdToSkip( manager,"SEQ_END" )

		
		missionCommon_functionSet.PlayMissionEndTelop()
		TppEventSequenceManagerCollector.GoNextSequence( "TppEventSequenceManagerData_mission_end", "SEQ_END" )
	end,

},

}
