mission_start_sequence_ground = {

SEQ_OPENING_DEMO = {

	OnEnter = function( manager )




		missionCommon_functionSet.SetSequenceIdToSkip( manager,"SEQ_TELOP" )

		
		manager:PlayDemo( "p41_020000" )
	end,

	OnReceiveMessageRegistered = function( manager, messageId, arg0 )
		
		if messageId == "DemoTelopTiming" and arg0 == "p41_020000" then
		missionCommon_functionSet.PlayMissionOpeningTelop()
			
		end
	end,

},

SEQ_TELOP = {

	OnEnter = function( manager )




		missionCommon_functionSet.SetSequenceIdToSkip( manager,"SEQ_END" )

		
		missionCommon_functionSet.PlayMissionOpeningTelop()
	end,

},


}
