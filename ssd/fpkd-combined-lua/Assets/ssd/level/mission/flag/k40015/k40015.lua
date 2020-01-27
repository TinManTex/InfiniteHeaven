




local StrCode32 = Fox.StrCode32

local this = BaseFlagMission.CreateInstance( "k40015" )	

local lastAddedStep


this.unexecFastTravel = true


this.missionDemoBlock = { demoBlockName = "FastTravel" }




local tipsMenuList = {
	
	TIPS_FASTTRAVEL = {
		tipsTypes		= { HelpTipsType.TIPS_58_A, HelpTipsType.TIPS_58_B, HelpTipsType.TIPS_58_C, },
	},
}




local tipsMenuAnnounceList = {
	
	TIPS_COOP = {
		tipsTypes		= {
								HelpTipsType.TIPS_39_A, HelpTipsType.TIPS_39_B, HelpTipsType.TIPS_39_C,
						},
	},
}




this.importantGimmickList = {
	{
		gimmickId	= "GIM_P_Portal",
		locatorName = "com_portal001_gim_n0000|srt_ftp0_main0_def_v00",
		datasetName	= "/Assets/ssd/level/location/afgh/block_small/132/132_150/afgh_132_150_gimmick.fox2",
	}
}




BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isRadioTalking01",				 type = TppScriptVars.TYPE_BOOL,	value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isRadioTalking02",				 type = TppScriptVars.TYPE_BOOL,	value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)

this.missionAreas = {
	{
		name = "marker_missionArea_Start",
		trapName = "trap_missionArea_Start",
		visibleArea = 5, 
		guideLinesId = "guidelines_mission_common_fastTravel",
	},
	{
		name = "marker_missionArea_Return",
		trapName = "trap_missionArea_Return",
		visibleArea = 5, 
		hide = true 
	},
}


this.enemyLevelSettingTable = {
	areaSettingTableList = {
		{
			areaName = "Sleep_Zombie",
			level = -1,
			randomRange = 0,
		},
	},
}


this.disableEnemy = {
	{ enemyName = "zmb_132_148_0007" },
	{ enemyName = "zmb_132_149_0000" },
	{ enemyName = "zmb_133_149_01_0000" },
	{ enemyName = "zmb_133_149_01_0001" },
	{ enemyName = "zmb_133_149_01_0002" },
	{ enemyName = "zmb_133_149_01_0003" },
	{ enemyName = "zmb_133_149_01_0005" },
	{ enemyName = "zmb_133_149_01_0006" },
	{ enemyName = "zmb_133_149_01_0008" },
	{ enemyName = "zmb_133_149_02_0000" },
	{ enemyName = "zmb_133_149_02_0003" },
	{ enemyName = "zmb_133_149_03_0003" },
	{ enemyName = "zmb_133_149_03_0006" },
	{ enemyName = "zmb_133_149_03_0008" },
	{ enemyName = "zmb_132_148_0006" },
}




this.OnActivate = function()
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameMain" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameDefense" ) then
		
		this.DisplayGuideLine( { "guidelines_mission_common_fastTravel"} )
	end
	
	SsdFastTravel.LockFastTravelPointGimmick( "fast_afgh00" )
	
	SsdFastTravel.ActionFastTravelPointGimmick(  "fast_afgh00", "Unlocked", 1 )
end


this.enterMissionAreaRadio = "f3010_rtrg0402"





lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameTipsFastTravel",
	clearConditionTable = {
		tips = {
			tipsRadio	= "f3010_rtrg0400",
			tipsTypes	= {
							{ HelpTipsType.TIPS_22_A, HelpTipsType.TIPS_22_B, HelpTipsType.TIPS_22_C, },
							{ HelpTipsType.TIPS_89_A, HelpTipsType.TIPS_89_B },
							{ HelpTipsType.TIPS_88_A, HelpTipsType.TIPS_88_B },
						},
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameMain",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		TppTutorial.StartHelpTipsMenuOnlyAnnounce( tipsMenuAnnounceList.TIPS_COOP )
		
		this.DisplayGuideLine( { "guidelines_mission_common_fastTravel"} )
	end,
	OnLeave = function()
		Gimmick.RemoveUnitInterferer{ key = "fast_afgh01", }
	end,
	options = {
		continueRadio = "f3010_rtrg0401",
		objective = "mission_40015_objective_01",
		route = {
			{ enemyName = "zmb_k40015_0016", routeName = "rt_k40015_0000", },
		},
		marker = {
			{ name = "marker_target", areaName = "marker_missionArea_Start", mapTextId = "hud_facilityInfo_fastTravel_name" },
		},
		nextStepDelay = {
			{ type = "FadeOut", fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED },
		},
		recipe = {
			
			"RCP_BLD_WeaponPlant_B",			
			"RCP_DEF_Fence_A",					
			"RCP_DEF_Barricade_A",				
		},
	},
	clearConditionTable = {
		switch = {
			{
				gimmickId	= "GIM_P_Portal",
				locatorName = "com_portal001_gim_n0000|srt_ftp0_main0_def_v00",
				datasetName	= "/Assets/ssd/level/location/afgh/block_small/132/132_150/afgh_132_150_gimmick.fox2",
				isPowerOn	= true,
			},
		},
	},
}





this.flagStep.GameMain.messageTable = {
	Trap = {
		{
			sender = "trap_fasttravel",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if fvars.isRadioTalking02 == false then
					TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_FASTTRAVEL )
					fvars.isRadioTalking02 = true
				end
				
				local fasttravelPointName = "fast_afgh01"
				local gimmickIdentifier = SsdFastTravel.GetFastTravelPointGimmickIdentifier( fasttravelPointName )
				TppGimmick.AddUnitInterferer( fasttravelPointName, gimmickIdentifier, 6.0, Vector3( 0.0, 10.5, 0.0), true ) 
			end,
			option = { isExecFastTravel = true, },
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "DemoStartDefense",
	previousStep = lastAddedStep,
	options = {
		checkObjectiveIfCleared = "mission_40015_objective_01",
	},
	clearConditionTable = {
		demo = {
			demoName = "p01_000080",
			funcs = {
				onInit = function()
					
					SsdFastTravel.InvisibleFastTravelPointGimmick( "fast_afgh01", true )
				end,
			},
		},
	},
}



this.flagStep.DemoStartDefense.messageTable = {
	Demo = {
		{	
			msg = "p01_000080_gameModelOn",
			func = function()
				
				SsdFastTravel.InvisibleFastTravelPointGimmick( "fast_afgh01", false )
				
				SsdFastTravel.ActionFastTravelPointGimmick( "fast_afgh01", "Defense", 1 )
			end,
			option = { isExecDemoPlaying = true },
		},
	},
}



lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameDefense",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		this.SetWaveWalkSpeed("zmb_k40015_0000", "walk")
		this.SetWaveWalkSpeed("zmb_k40015_0001", "walk")
		this.SetWaveWalkSpeed("zmb_k40015_0002", "run")
		this.SetWaveWalkSpeed("zmb_k40015_0015", "walk")
		
		this.SetWaveWalkSpeed("zmb_k40015_0005", "walk")
		this.SetWaveWalkSpeed("zmb_k40015_0006", "walk")
		this.SetWaveWalkSpeed("zmb_k40015_0007", "run")
		this.SetWaveWalkSpeed("zmb_k40015_0008", "walk")
		this.SetWaveWalkSpeed("zmb_k40015_0009", "walk")
		this.SetWaveWalkSpeed("zmb_k40015_0014", "walk")
		
		this.SetWaveWalkSpeed("zmb_k40015_0010", "walk")
		this.SetWaveWalkSpeed("zmb_k40015_0011", "walk")
		this.SetWaveWalkSpeed("zmb_k40015_0012", "walk")
		this.SetWaveWalkSpeed("zmb_k40015_0013", "walk")
		this.SetWaveWalkSpeed("zmb_k40015_0016", "walk")
		
		this.SetWaveWalkSpeed("zmb_133_149_01_0000", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_01_0001", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_01_0002", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_01_0003", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_01_0004", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_01_0005", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_01_0006", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_01_0007", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_01_0008", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_01_0001", "walk")
		
		this.SetWaveWalkSpeed("zmb_133_149_03_0000", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_03_0001", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_03_0002", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_03_0003", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_03_0004", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_03_0005", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_03_0006", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_03_0007", "walk")
		this.SetWaveWalkSpeed("zmb_133_149_03_0008", "walk")
		
		this.SetWaveWalkSpeed("zmb_132_150_0000", "walk")
		this.SetWaveWalkSpeed("zmb_132_150_0001", "walk")
		this.SetWaveWalkSpeed("zmb_132_150_0002", "walk")
		this.SetWaveWalkSpeed("zmb_132_150_0003", "walk")
		this.SetWaveWalkSpeed("zmb_132_150_0004", "walk")
		this.SetWaveWalkSpeed("zmb_132_150_0005", "walk")
		
		this.SetWaveWalkSpeed("zmb_132_148_0000", "walk")
		this.SetWaveWalkSpeed("zmb_132_148_0001", "walk")
		this.SetWaveWalkSpeed("zmb_132_148_0002", "walk")
		this.SetWaveWalkSpeed("zmb_132_148_0003", "walk")
		this.SetWaveWalkSpeed("zmb_132_148_0004", "walk")
		this.SetWaveWalkSpeed("zmb_132_148_0005", "walk")
		this.SetWaveWalkSpeed("zmb_132_148_0006", "walk")
		
	
	
	end,
	options = {
		radio = "f3000_rtrg1605",
		objective = "mission_40015_objective_02",
		checkObjectiveIfCleared = "mission_40015_objective_02",
		marker = {
			{ name = "marker_target", areaName = "marker_missionArea_Start", mapTextId = "hud_facilityInfo_fastTravel_name" },
		},
	},
	clearConditionTable = {
		wave = {
			waveName = "wave_fast_afgh01",
			defenseGameArea = {
				areaTrapName = "trap_k40015_DefenseArea",
				alertTrapName = "trap_k40015_DefenseAlertArea",
			},
		},
	},
}


this.SetWaveWalkSpeed = function( locatorName, speed )
	if speed == nil then
		speed = "speed"
	end
	local gameObjectId = { type="SsdZombie" } 
	local command = { id="SetWaveWalkSpeed", speed=speed, locatorName=locatorName }
	GameObject.SendCommand( gameObjectId, command )
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameAfterDefense",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		this.DisableMissionArea( "marker_missionArea_Start" )
		
		this.DisplayMissionArea("marker_missionArea_Return")
		
		this.DisableGuideLine()
	end,
	OnLeave = function()
		
		this.DisableMissionArea( "marker_missionArea_Return" )
	end,
	options = {
		marker = {
			{ name = "marker_target_return", areaName = "marker_missionArea_Return", mapTextId = "hud_facilityInfo_fastTravel_name" },
		},
		radio = { "f3000_rtrg1606", "f3000_rtrg0204", },
		fastTravelPoint = { "fast_afgh00", "fast_afgh01", },
		objective = "mission_40015_objective_03",
	},
	clearConditionTable = {
	},
}


this.flagStep.GameAfterDefense.messageTable = {
	UI = {
		{	
			msg = "FastTravelMenuPointSelected",
			func = function( from, to )
				Fox.Log( "k40015.Messages(): UI: msg:FastTravelMenuPointSelected" )
				
				if to == Fox.StrCode32("fast_afgh00") then
					
					SsdBuildingMenuSystem.CloseBuildingMenu()
					SsdUiSystem.RequestForceCloseForMissionClear()
					
					TppUI.FadeOut( TppUI.FADE_SPEED.FADE_HIGHESTSPEED, "EndFadeOut_FastTravel", nil, nil )
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "EndFadeOut_FastTravel",
			msg = "EndFadeOut",
			func = function()
				local demoName = "p01_000090"
				TppDemo.AddDemo( demoName, demoName )
				TppDemo.Play(
					demoName,
					{
						
						onInit = function()
							
							mvars.isFastTravel = true
							
							SsdFastTravel.InvisibleFastTravelPointGimmick( "fast_afgh01", true )
						end,
						
						onEnd = function()
							
							local command = { id="ForceCancelWormhole", resetToVisible = false }
							GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, command )
							
							SsdFastTravel.InvisibleFastTravelPointGimmick( "fast_afgh01", false )
							
							BaseResultUiSequenceDaemon.SetReserved( true )
							
							TppPlayer.StartFastTravel(
								StrCode32("fast_afgh01"),
								StrCode32("fast_afgh00"),
								
								function()
									
									SsdFlagMission.SetNextStep( "MissionClearFastTravel" )
								end,
								{
									noFadeIn = true,
									noSound = true,
								}
							)
						end,
					},
					{
						finishFadeOut = true,
						waitBlockLoadEndOnDemoSkip = false,
					}
				)
			end,
			option = { isExecFastTravel = true, },
		},
	},
	Demo = {
		{	
			msg = "p01_000090_StartWormhole",
			func = function()
				
				local command = { id="StartWormhole", isEnter = true, isVfxDisabled = true, wormholeTime = 7 }
				GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, command )
			end,
			option = { isExecDemoPlaying = true },
		},
	},
	GameObject = {
		{	
			msg = "EnterBaseCheckpoint",
			func = function()
				
				if not mvars.isFastTravel then
					
					SsdFlagMission.SetNextStep( "MissionClearWalk" )
					
					MissionObjectiveInfoSystem.Check{ langId = "mission_40015_objective_03", checked = true, }
				end
			end,
			option = { isExecFastTravel = true, },
		},
	},
}



lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "MissionClearFastTravel",
	previousStep = lastAddedStep,
	OnEnter = function()
	end,
	OnLeave = function()
	end,
	options = {
		objective = "mission_40015_objective_03",
	},
	clearConditionTable = {
		clearStage = {
			demo = {
				demoName = "p01_000091",
				funcs = {
					onInit = function()
						
						SsdFastTravel.InvisibleFastTravelPointGimmick( "fast_afgh00", true )
						
						Player.SetDisableAttachMask( true )
						
						Player.SetAttachMaskState()
					end,
					
					onEnd = function()
						
						local command = { id="ForceCancelWormhole", resetToVisible = true }
						GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, command )
						
						Player.SetDisableAttachMask( false )
						
						SsdFastTravel.InvisibleFastTravelPointGimmick( "fast_afgh00", false )
					end,
				},
				options = {
					useDemoBlock = true,
					finishFadeOut = true,
				},
			}
		}
	},
}


this.flagStep.MissionClearFastTravel.messageTable = {
	Demo = {
		{	
			msg = "p01_000091_StartWormhole",
			func = function()
				Fox.Log( "k40015.Messages(): Demo: msg:p01_000091_StartWormhole" )
				
				local command = { id="StartWormhole", isEnter = false, isVfxDisabled = true, wormholeTime = 7 }
				GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, command )
			end,
			option = { isExecDemoPlaying = true },
		},
		{	
			msg = "p01_000091_UIstart",
			func = function()
				Fox.Log( "k40015.Messages(): Demo: msg:p01_000091_UIstart" )
				MissionObjectiveInfoSystem.Check{ langId="mission_40015_objective_03",checked=true }
			end,
			option = { isExecDemoPlaying = true, }, 
  		}, 
	},
}






lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "MissionClearWalk",
	previousStep = lastAddedStep,
	OnEnter = function()
	end,
	OnLeave = function()
	end,
	options = {
	},
	clearConditionTable = {
		clearStage = true
	},
}




this.blackRadioOnEnd = "K40015_0010"




this.releaseAnnounce = { "EnableFastTravel" }

return this
