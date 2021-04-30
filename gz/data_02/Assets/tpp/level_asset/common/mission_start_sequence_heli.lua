
mission_start_sequence_heli = {

SEQ_TELOP_HELI = {

	OnEnter = function( manager )




		missionCommon_functionSet.SetSequenceIdToSkip( manager,"SEQ_END" )

		
		missionCommon_functionSet.PlayMissionOpeningTelop()
	end,

},

}
