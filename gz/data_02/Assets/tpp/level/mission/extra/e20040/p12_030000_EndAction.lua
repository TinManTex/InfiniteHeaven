




p12_030000_EndAction = {

	
	
	
	
	
	events = {
		Target_Demo = { Finish="MissionStartDemoEnd" },	
	},

	
	
	
	
	MissionStartDemoEnd = function( mission )




		
		missionCommon_functionSet.FlagChange("missionEventFlag_startMission",1)




	end,

}
