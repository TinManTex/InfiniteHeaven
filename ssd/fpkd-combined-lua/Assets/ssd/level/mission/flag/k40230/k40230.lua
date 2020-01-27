





local ZOMBIE	= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local BOM		= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM
local DASH		= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH
local MORTOR	= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL
local CAMERA	= TppGameObject.GAME_OBJECT_TYPE_INSECT_1
local SPIDER	= TppGameObject.GAME_OBJECT_TYPE_INSECT_2

local this = BaseFlagMission.CreateInstance( "k40230" )

this.missionDemoBlock = { demoBlockName = "RecoverSaheran" }

local k40230_diggerIdentifierParam = {
	"GIM_P_Digger",
	"whm0_gim_n0000|srt_whm0_main0_def_v00",
	"/Assets/ssd/level/mission/flag/k40230/k40230_item.fox2",
}

local defenseTargetGimmickIdentifier = {
	gimmickId		= k40230_diggerIdentifierParam[1],
	name			= k40230_diggerIdentifierParam[2],
	dataSetName		= k40230_diggerIdentifierParam[3],
}

local importantGimmickTable = {
	gimmickId		= k40230_diggerIdentifierParam[1],
	locatorName		= k40230_diggerIdentifierParam[2],
	datasetName		= k40230_diggerIdentifierParam[3],
	isPowerOn		= true,
}


this.missionAreas = {
	{
		name = "marker_missionArea",
		trapName = "trap_missionArea",
		visibleArea = 4,
		guideLinesId = "guidelines_mission_40230_01",
	},
}




this.OnActivate = function()

	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameMain" ) and stepIndex <= SsdFlagMission.GetStepIndex( "DemoBlackRadioAfterRecoverSaheran" ) then
		
		this.DisplayGuideLine( { "guidelines_mission_40230_01"} )
	end
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		
		this.DisableMissionArea( "marker_missionArea" )
	end
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end

end




this.AddOnTerminate = function()
	Fox.Log("k40230.AddOnTerminate")
	GameObject.SendCommand( { type="SsdZombieShell" },	{ id = "IgnoreVerticalShot", ignore=false } )
end




this.waveSettings = {
	waveList = {
		"wave_k40230",
	},
	wavePropertyTable = {
		wave_k40230 = {
			limitTimeSec	= (60 * 15.5),
			defenseTimeSec	= (60 * 15.5),
			alertTimeSec	= 30,
			miniMap = true,
			isTerminal		= true,
			waveTimerLangId = "timer_info_k40230",
			
			endEffectName	= "explosion_k40230",
			defenseGameType = TppDefine.DEFENSE_GAME_TYPE.SPOT,
			defenseTargetGimmickProperty = {
				identificationTable = {
					digger = defenseTargetGimmickIdentifier,
				},
				alertParameters = { needAlert = true, alertRadius = 12, },
			},
		},
	},
	waveTable = {
	










	wave_k40230 = {
	
	  { 15, "SpawnPoint_k40230_00_0000", BOM, 1, 0, },
	  { 1, "SpawnPoint_k40230_00_0000", ZOMBIE, 5, 0, },
	  { 9, "SpawnPoint_k40230_00_0001", BOM, 1, 0, },
	  { 2, "SpawnPoint_k40230_00_0001", ZOMBIE, 5, 0, },
	  { 15, "SpawnPoint_k40230_00_0000", ZOMBIE, 5, 0, },
	  { 25, "SpawnPoint_k40230_00_0003", ZOMBIE, 5, 0, },
	  { 12, "SpawnPoint_k40230_00_0002", BOM, 1, -3, "walk"  },
	  { 1, "SpawnPoint_k40230_00_0002", ZOMBIE, 7, 0, "walk"  },
	  { 2, "SpawnPoint_k40230_00_0000", ZOMBIE, 8, 0, "walk"  },
	
	  { 85, "SpawnPoint_k40230_00_0003", BOM, 1, 0, },
	  { 1, "SpawnPoint_k40230_00_0003", ZOMBIE, 5, 0, },
	  { 15, "SpawnPoint_k40230_00_0000", ZOMBIE, 5, 0, },
	  { 6, "SpawnPoint_k40230_00_0001", MORTOR, 1, -5, },
	  { 10, "SpawnPoint_k40230_00_0002", ZOMBIE, 4, 0, },
	  { 25, "SpawnPoint_k40230_00_0003", ZOMBIE, 5, 0, "walk"  },
	  { 10, "SpawnPoint_k40230_01", ZOMBIE, 8, 0, "walk" },
	  { 1, "SpawnPoint_k40230_00_0000", BOM, 1, 0, "walk"  },
	  { 15, "SpawnPoint_k40230_00_0000", ZOMBIE, 10, 0, "walk"	},
	
	  { 100, "SpawnPoint_k40230_00_0001", ZOMBIE, 5, 0, },
	  { 6, "SpawnPoint_k40230_00_0001", MORTOR, 1, -5, },
	  { 4, "SpawnPoint_k40230_01", ZOMBIE, 2, 0, "walk" },
	  { 15, "SpawnPoint_k40230_00_0001", ZOMBIE, 5, 0, "walk"  },
	  { 5, "SpawnPoint_k40230_00_0000", ZOMBIE, 6, 0, },
	  { 20, "SpawnPoint_k40230_00_0002", ZOMBIE, 5, 0, },
	  { 15, "SpawnPoint_k40230_00_0003", ZOMBIE, 5, 0, },
	  { 30, "SpawnPoint_k40230_00_0000", BOM, 1, 0, },
	  { 1, "SpawnPoint_k40230_00_0000", ZOMBIE, 6, 0, },
	  { 8, "SpawnPoint_k40230_01", ZOMBIE, 2, 0, "walk" },
	  { 10, "SpawnPoint_k40230_00_0000", ZOMBIE, 7, 0, },
	  { 15, "SpawnPoint_k40230_00_0002", ZOMBIE, 9, 0, "walk" },
	
	  { 120, "SpawnPoint_k40230_00_0000", MORTOR, 1, -5, },
	  { 1, "SpawnPoint_k40230_00_0001", MORTOR, 1, -5, },
	  { 1, "SpawnPoint_k40230_00_0002", MORTOR, 1, -5, },
	
	  { 110, "SpawnPoint_k40230_00_0001", ZOMBIE, 5, 0, },
	  { 6, "SpawnPoint_k40230_00_0001", MORTOR, 1, -5, },
	  { 15, "SpawnPoint_k40230_00_0000", ZOMBIE, 6, 0, },
	  { 25, "SpawnPoint_k40230_00_0002", ZOMBIE, 5, 0, },
	  { 4, "SpawnPoint_k40230_01", ZOMBIE, 2, 0, "walk" },
	  { 15, "SpawnPoint_k40230_00_0002", ZOMBIE, 5, 0, },
	  { 9, "SpawnPoint_k40230_00_0003", ZOMBIE, 5, 0, "walk" },
	  { 25, "SpawnPoint_k40230_00_0000", BOM, 1, 0, },
	  { 5, "SpawnPoint_k40230_00_0000", ZOMBIE, 7, 0, "walk" },
	  { 4, "SpawnPoint_k40230_01", ZOMBIE, 2, 0, "walk" },
	  { 6, "SpawnPoint_k40230_00_0000", ZOMBIE, 8, 0, },
	  { 6, "SpawnPoint_k40230_00_0002", ZOMBIE, 10, 0, "walk" },
	 },
	},
	
	spawnPointDefine = {
		SpawnPoint_k40230_00_0000 = { spawnLocator = "SpawnPoint_k40230_00_0000", },
		SpawnPoint_k40230_00_0001 = { spawnLocator = "SpawnPoint_k40230_00_0001", },
		SpawnPoint_k40230_00_0002 = { spawnLocator = "SpawnPoint_k40230_00_0002", relayLocator1 = "SpawnPoint_k40230_00_0002_01", },
		SpawnPoint_k40230_00_0003 = { spawnLocator = "SpawnPoint_k40230_00_0003", relayLocator1 = "SpawnPoint_k40230_00_0003_01", },
		SpawnPoint_k40230_01 = { spawnLocator = "SpawnPoint_k40230_01", },
	},
}




this.importantGimmickList =  {
	importantGimmickTable,	
}

this.showDiggerPlanedPlace = 1	


this.enterMissionAreaRadio = { name = "f3010_rtrg2102", options = { delayTime = 2.0 } }

local lastAddedStep




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameMain",
	OnEnter = function( self )
		self.lastDefenseGameState = nil
		
		this.waveSettings.wavePropertyTable.wave_k40230.defensePosition = TppGimmick.GetPositionTableByGimmickIdentifier( defenseTargetGimmickIdentifier )
		
		this.DisplayGuideLine( { "guidelines_mission_40230_01"} )
	end,
	OnLeave = function( self )
		self.lastDefenseGameState = nil
	end,
	
	AddOnUpdate = function( self )
		local defenseGameState = Mission.GetDefenseGameState()
		local isDefenseGameActive, isChangedDefenseGameState
		if ( defenseGameState ~= TppDefine.DEFENSE_GAME_STATE.NONE ) then
			isDefenseGameActive = true
		else
			isDefenseGameActive = false
		end
		if ( self.lastDefenseGameState ~= defenseGameState ) then
			isChangedDefenseGameState = true
		end
		self.lastDefenseGameState = defenseGameState
		
		if isChangedDefenseGameState then
			if isDefenseGameActive then
				if fvars.k40230_GameMain_putDigger then	
					Gimmick.SetVanish{
						gimmickId = k40230_diggerIdentifierParam[1],
						name = k40230_diggerIdentifierParam[2],
						dataSetName = k40230_diggerIdentifierParam[3],
					}
					fvars.k40230_GameMain_putDigger = false
				end
				
				Gimmick.SetNoTransfering{
					gimmickId = k40230_diggerIdentifierParam[1],
					name = k40230_diggerIdentifierParam[2],
					dataSetName = k40230_diggerIdentifierParam[3],
					noTransfering = true,
				}
			else
				
				Gimmick.SetNoTransfering{
					gimmickId = k40230_diggerIdentifierParam[1],
					name = k40230_diggerIdentifierParam[2],
					dataSetName = k40230_diggerIdentifierParam[3],
					noTransfering = false,
				}
			end
		end
	end,
	options = {
		radio = "f3010_rtrg2100",
		marker = "marker_target",
		objective = "mission_40230_objective_01",
		checkObjectiveIfCleared = "mission_40230_objective_01",
		OnChangeClearCondition = function( updateVarsName )
			
			if ( updateVarsName == "k40230_GameMain_putDigger" ) then
				TppRadio.Play( "f3000_rtrg2112", { delayTime = 2.0 }  )
			end
		end,
	},
	clearConditionTable = {
		putDigger = defenseTargetGimmickIdentifier,
		switch = {
			importantGimmickTable,
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameDefense",
	OnEnter = function( self )
		self.needSetDiggerTargetPosition = true
		this.DisableMissionArea( "marker_missionArea" )
		GameObject.SendCommand( { type="SsdZombieShell" },	{ id = "IgnoreVerticalShot", ignore=true } )
	end,
	
	AddOnUpdate = function( self )
		if self.needSetDiggerTargetPosition then
			local position, rotQuat = Tpp.GetLocatorByTransform( "DataIdentifier_k40230","RecoverSaheranWormholePosition" )
			Gimmick.SetAction{
				gimmickId = k40230_diggerIdentifierParam[1],
				name = k40230_diggerIdentifierParam[2],
				dataSetName = k40230_diggerIdentifierParam[3],
				action = "SetTargetPos",
				position = position,
			}
			
			Gimmick.SetAction{
				gimmickId = k40230_diggerIdentifierParam[1],
				name = k40230_diggerIdentifierParam[2],
				dataSetName = k40230_diggerIdentifierParam[3],
				action = "SetSupplyMode",
			}
			
			
			Gimmick.SetAction{
				gimmickId = k40230_diggerIdentifierParam[1],
				name = k40230_diggerIdentifierParam[2],
				dataSetName = k40230_diggerIdentifierParam[3],
				action = "SetEffectBeam01",
				string1 = "dummy",
			}
			
			
			Gimmick.SetAction{
				gimmickId = k40230_diggerIdentifierParam[1],
				name = k40230_diggerIdentifierParam[2],
				dataSetName = k40230_diggerIdentifierParam[3],
				action = "SetEffectDownwash01",
				string1 = "dummy",
			}
			
			Gimmick.SetAction{
				gimmickId = k40230_diggerIdentifierParam[1],
				name = k40230_diggerIdentifierParam[2],
				dataSetName = k40230_diggerIdentifierParam[3],
				action = "SetEffectBeam02",
				string1 = "BEAM04",
			}
			
			Gimmick.SetAction{
				gimmickId = k40230_diggerIdentifierParam[1],
				name = k40230_diggerIdentifierParam[2],
				dataSetName = k40230_diggerIdentifierParam[3],
				action = "SetEffectDownwash02",
				string1 = "Downwash01",
			}
			
			Gimmick.SetAction{
				gimmickId = k40230_diggerIdentifierParam[1],
				name = k40230_diggerIdentifierParam[2],
				dataSetName = k40230_diggerIdentifierParam[3],
				action = "SetEffectBeam03",
				string1 = "EnergyOuthole02",
			}
			self.needSetDiggerTargetPosition = nil
		end
	end,
	OnLeave = function()
		GameObject.SendCommand( { type="SsdZombieShell" },	{ id = "IgnoreVerticalShot", ignore=false } )
	end,
	options = {
		radio = { name = "f3010_rtrg2104", options = { delayTime = 3.0 } },
		objective = "mission_40230_objective_02",
		checkObjectiveIfCleared = "mission_40230_objective_02",
		nextStepDelay = {
			{ type = "Delay", delayTimeSec = 12.0, },	
			{ type = "FadeOut", },	
		},
	},
	clearConditionTable = {
		wave = {
			waveName = "wave_k40230",
			onClearRadio = { name = "f3000_rtrg1117", options = { delayTime = 3.0 } },	
			defenseGameArea = {
				areaTrapName = "trap_defenseGameArea_k40230",
				alertTrapName = "trap_defenseGameAlertArea_k40230",
			},
		},
	},
}

lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "DemoRecoverSaheran",
	OnEnter = function()
		mafr_base.SetSaheranVisibility( false )
		
		Gimmick.InvisibleGimmick(
			TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			"mgs0_moss_leg_gim_n0000|srt_mgs0_main1_ssd_v00",
			"/Assets/tpp/level/location/mafr/block_large/lab/mafr_lab_gimmick.fox2",
			true
		)
		Gimmick.InvisibleGimmick( 0, k40230_diggerIdentifierParam[2], k40230_diggerIdentifierParam[3], true, { gimmickId = k40230_diggerIdentifierParam[1], } )
		Gimmick.AreaBreak{
			pos = Vector3( 2705.51, 69.9314, -1873.77 ),
			radius = 24.0,
			onlyEquip = true,
			silentBreak = true,
		}
	end,
	OnLeave = function()
		TppTrophy.Unlock( 12 ) 
	end,
	clearConditionTable = {
		demo = {
			demoName = "p40_000030",
			options = { useDemoBlock = true }
		},
	},
}


this.flagStep.DemoRecoverSaheran.messageTable = {
	Demo = {
		{
			msg = "p40_000030_diggerOn",
			func = function()
				Gimmick.InvisibleGimmick( 0, k40230_diggerIdentifierParam[2], k40230_diggerIdentifierParam[3], false, { gimmickId = k40230_diggerIdentifierParam[1], } )
				local position, rotQuat = Tpp.GetLocatorByTransform( "DataIdentifier_k40230","RecoverSaheranWormholePosition" )
				Gimmick.SetAction{
					gimmickId = k40230_diggerIdentifierParam[1],
					name = k40230_diggerIdentifierParam[2],
					dataSetName = k40230_diggerIdentifierParam[3],
					action = "SetTargetPos",
					position = position,
				}
				Gimmick.SetAction{
					gimmickId = k40230_diggerIdentifierParam[1],
					name = k40230_diggerIdentifierParam[2],
					dataSetName = k40230_diggerIdentifierParam[3],
					action = "Close",
					param1 = 1,	
				}
				
				Gimmick.InvisibleGimmick(
					TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
					"mgs0_moss_leg_gim_n0000|srt_mgs0_main1_ssd_v00",
					"/Assets/tpp/level/location/mafr/block_large/lab/mafr_lab_gimmick.fox2",
					false
				)
			end,
			option = { isExecDemoPlaying = true, }
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "DemoBlackRadioAfterRecoverSaheran",
	previousStep = lastAddedStep,
	clearConditionTable = {
		blackRadio = {
			startRadio = "f3010_rtrg2106",
			blackRadioList = { "K40230_0010" },
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameEscape",
	OnEnter = function()
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
		
		this.DisableMissionArea( "marker_missionArea" )
		
		this.DisableGuideLine()
		
		mafr_base.SetAiVisibility(false)
		
		Gimmick.SetVanish{
			gimmickId = k40230_diggerIdentifierParam[1],
			name = k40230_diggerIdentifierParam[2],
			dataSetName = k40230_diggerIdentifierParam[3],
		}
		Gimmick.SetNoTransfering{
			gimmickId = k40230_diggerIdentifierParam[1],
			name = k40230_diggerIdentifierParam[2],
			dataSetName = k40230_diggerIdentifierParam[3],
			noTransfering = true,
		}
	end,
	OnLeave = function()
		SsdCrewSystem.UnregisterCrew{uniqueId="uniq_seth"}	
		SsdCrewSystem.SetUniqueCrewAbsence{ uniqueId="uniq_boy", absence=true }		
	end,
	options = {
		objective = "mission_40230_objective_03",
		checkObjectiveIfCleared = "mission_40230_objective_03",
	},
	clearConditionTable = {
		home = true,
	},
}




BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameClear",
	clearConditionTable = {
		clearStage = true,
	},
}




this.clearRadio = "f3000_rtrg0213"




this.blackRadioOnEnd = { "K40230_0020", "K40230_0030" }




this.releaseAnnounce = { "OpenLocationChange" }

return this
