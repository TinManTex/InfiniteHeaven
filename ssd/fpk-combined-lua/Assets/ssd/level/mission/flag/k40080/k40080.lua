




local this = BaseFlagMission.CreateInstance( "k40080" )	
local lastAddedStep



this.registerRescueTargetUniqueCrew = {
	locatorName = "npc_k40080_0000",
	uniqueType = SsdCrewType.UNIQUE_TYPE_BOY,
}




this.importantGimmickList = {
	{
		gimmickId	= "GIM_P_Portal",
		locatorName = "com_portal001_gim_n0000|srt_ftp0_main0_def_v00",
		datasetName	= "/Assets/ssd/level/location/afgh/block_small/142/142_145/afgh_142_145_gimmick.fox2",
	}
}



this.missionAreas = {
	{ 
		name = "marker_missionArea", 
		trapName = "trap_missionArea_k40080", 
		visibleArea = 9, 
		guideLinesId = "guidelines_mission_common_signal",
		hide = true 
	},
	{ 
		name = "marker_missionArea_FT", 
		trapName = "trap_missionArea_k40080_FT", 
		visibleArea = 8, 
		hide = true 
	},
}




this.OnActivate = function()
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()

	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameMain" ) then
		this.DisplayGuideLine( { "guidelines_mission_common_signal"} )
	end

	
	if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) then
		this.DisplayMissionArea( "marker_missionArea" )
	end

	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		this.DisplayMissionArea( "marker_missionArea_FT" )
	end

	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end

	
	TppQuest.RegisterSkipStartQuestDemo( "village_q22140" )

end


this.enemyLevelSettingTable = {
	areaSettingTableList = {
		{
			areaName = "AreaWalkerGear",
			level = -5,
			randomRange = 0,
		},
	},
}


this.enemyRouteTable = {
	{ enemyName = "cam_k40080_0001", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0000", },
	{ enemyName = "cam_k40080_0002", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0002", },
	{ enemyName = "cam_k40080_0003", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0001", },
	{ enemyName = "cam_k40080_0005", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0004", },
	{ enemyName = "cam_k40080_0006", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0005", },
	{ enemyName = "cam_k40080_0007", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0006", },
	{ enemyName = "cam_k40080_0000", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0007", },
	{ enemyName = "cam_k40080_0008", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0008", },
	{ enemyName = "cam_k40080_0009", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0009", },
	{ enemyName = "cam_k40080_0011", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0011", },
	{ enemyName = "cam_k40080_0012", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0012", },
	{ enemyName = "cam_k40080_0035", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0027", },
	{ enemyName = "cam_k40080_0032", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0029", },
	{ enemyName = "cam_k40080_0013", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0030", },
	{ enemyName = "cam_k40080_0014", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0031", },
	{ enemyName = "cam_k40080_0015", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0025", },
	{ enemyName = "cam_k40080_0016", enemyType = "SsdInsect1", routeName = "rt_cam_k40080_0032", },
}


this.WatcherRoute = function( locatorName, route, point, lookRotationX,isUseNav )
	local gameObjectId = GameObject.GetGameObjectId( "SsdInsect1", locatorName )
	local command = { id="SetSneakRoute", route=route, point= point, lookRotationX = lookRotationX, isUseNav = isUseNav }
	GameObject.SendCommand( gameObjectId, command )
end


function this.SetUniqueCrewAbsence( absence )
	SsdCrewSystem.SetUniqueCrewAbsence{ uniqueId="uniq_mlt", absence=absence}	
	SsdCrewSystem.SetUniqueCrewAbsence{ uniqueId="uniq_nrs", absence=absence}	
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameOpening",
	OnEnter = function()
		this.SetUniqueCrewAbsence( false )
	end,
	options = {
		radio = "f3010_rtrg1000",
		recipe = {
			
			"RCP_BLD_GadgetPlant_B",			
		},
	},
	clearConditionTable = {
		exitTrap = {
			trapList = {
			"trap_BlackRadio_Chris0000","trap_BlackRadio_Chris0001",
			"trap_BlackRadio_Chris0002","trap_BlackRadio_Chris0003",
			"trap_BlackRadio_Chris0004","trap_BlackRadio_Chris0005",
			"trap_BlackRadio_Chris0006","trap_BlackRadio_Chris0007",
			"trap_BlackRadio_Chris0008","trap_BlackRadio_Chris0009",
			},
			messageOptions = {},
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameblackRadio",
	previousStep = lastAddedStep,
	clearConditionTable = {
		blackRadio = {
			startRadio = "f3000_rtrg2202",
			blackRadioList = { "K40080_0010" },
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameMain",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		this.WatcherRoute("cam_k40080_0101", "rt_cam_k40080_0101", 0, 50 , false )
		this.WatcherRoute("cam_k40080_0102", "rt_cam_k40080_0102", 0, 50 , false )
		this.WatcherRoute("cam_k40080_0103", "rt_cam_k40080_0103", 0, 50 , false )
		this.WatcherRoute("cam_k40080_0106", "rt_cam_k40080_0106", 0, 50 , false )
		this.WatcherRoute("cam_k40080_0107", "rt_cam_k40080_0107", 0, 50 , false )
		this.WatcherRoute("cam_k40080_0112", "rt_cam_k40080_0112", 0, 50 , false )
		this.WatcherRoute("cam_k40080_0113", "rt_cam_k40080_0113", 0, 50 , false )
		this.WatcherRoute("cam_k40080_0115", "rt_cam_k40080_0115", 0, 45 , false )
		this.WatcherRoute("cam_k40080_0116", "rt_cam_k40080_0116", 0, 45 , false )
		this.WatcherRoute("cam_k40080_0117", "rt_cam_k40080_0117", 0, 45 , false )
		this.WatcherRoute("cam_k40080_0118", "rt_cam_k40080_0118", 0, 45 , false )
		this.WatcherRoute("cam_k40080_0119", "rt_cam_k40080_0119", 0, 45 , false )
		this.WatcherRoute("cam_k40080_0120", "rt_cam_k40080_0120", 0, 45 , false )
		this.WatcherRoute("cam_k40080_0121", "rt_cam_k40080_0121", 0, 45 , false )
		this.WatcherRoute("cam_k40080_0125", "rt_cam_k40080_0125", 0, 50 , false )
		this.WatcherRoute("cam_k40080_0126", "rt_cam_k40080_0126", 0, 50 , false )
		this.WatcherRoute("cam_k40080_0130", "rt_cam_k40080_0130", 0, 40 , false )
		
		this.DisplayMissionArea("marker_missionArea")
		
		this.DisplayGuideLine( { "guidelines_mission_common_signal"} )
		
		TppEnemy.SetBreakBody( "zmb_k40080_0003", "SsdZombie", 0, 1, 0, 1 )
		TppEnemy.SetBreakBody( "zmb_k40080_0007", "SsdZombie", 0, 0, 1, 0 )
		TppEnemy.SetBreakBody( "zmb_k40080_0014", "SsdZombie", 1, 0, 1, 0 )
		
		this.SetUniqueCrewAbsence( true )
	end,
	OnLeave = function()
		
		this.DisableMissionArea( "marker_missionArea" )
	end,
	options = {
		continueRadio = "f3010_rtrg1001",
		marker = {
			{ name = "marker_target_Chris", areaName = "marker_missionArea", },
		},
		objective = "mission_40080_objective_01",
		checkObjectiveIfCleared = "mission_40080_objective_01",
		trap = {
			{
				name = "trap_area",
				radio = "f3010_rtrg1002",
			},
		},
		onLeaveRadio = "f3000_rtrg0803",
	},
	clearConditionTable = {
		carry = {
			{ locatorName = "npc_k40080_0000", },
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameEscape",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		TppScriptBlock.LoadDemoBlock( "RescueChild", true ) 
		
		this.DisplayMissionArea( "marker_missionArea_FT" )
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
		
		this.SetUniqueCrewAbsence( true )
	end,
	options = {
		continueRadio = "f3010_rtrg1003",
		marker = {
			{ name = "marker_target_FT", areaName = "marker_missionArea_FT", mapTextId = "hud_facilityInfo_fastTravel_name" },
		},
		objective = "mission_40080_objective_02",
		checkObjectiveIfCleared = "mission_40080_objective_02",
	},
	clearConditionTable = {
		rescue = {
			{
				locatorName = "npc_k40080_0000",
				rescueDemo = {
					demoName = "p01_000022",	
					options = { finishFadeOut = true },
					rescueDemoOptions = { ignoreFacialSetting = true },
					funcs = {
						onInit = function()
							afgh_base.SetBaseFastTravelVisibility( false )
						end,
						onEnd = function()
							afgh_base.SetBaseFastTravelVisibility( true )
						end,
					},
				},
				checkObjective = "mission_40080_objective_02",
			},
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameClear",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		this.SetUniqueCrewAbsence( false )
	end,
	options = {
	},
	clearConditionTable = {
		clearStage = true,
	},
}




this.blackRadioOnEnd = "K40080_0020"




this.releaseAnnounce = {
	"OpenBaseManagement",
}

return this
