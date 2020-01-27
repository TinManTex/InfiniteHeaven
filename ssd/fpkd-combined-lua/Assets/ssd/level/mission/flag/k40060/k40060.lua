	



local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId

local this = BaseFlagMission.CreateInstance( "k40060" )

local lastAddedStep




local tipsMenuList = {
	
	TIPS_FENCE = {
		tipsRadio		= "f3010_rtrg0208",
		tipsTypes		= { HelpTipsType.TIPS_90_A, HelpTipsType.TIPS_90_B, HelpTipsType.TIPS_90_C },
		endFunction		= function() this.EndTipsFence() end,
	},
}




local tipsMenuAnnounceList = {
	TIPS_ZOMBIE = {
		tipsTypes = {
			HelpTipsType.TIPS_18_A, HelpTipsType.TIPS_18_B, HelpTipsType.TIPS_18_C,		
			HelpTipsType.TIPS_59_A, HelpTipsType.TIPS_59_B, HelpTipsType.TIPS_59_C,		
			HelpTipsType.TIPS_31_A, HelpTipsType.TIPS_31_B, HelpTipsType.TIPS_31_C,		
		},
	},
}


this.missionAreas = {
	{ name = "marker_missionArea", trapName = "trap_missionArea", visibleArea = 4, guideLinesId = "guidelines_mission_common_memoryBoard", hide = true },
}


BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isTips01",							 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isTips02",							 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isMemoryBoard",						 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isMissionArea",						 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isCraftFence",						 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isDisableFenceMarker",				 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)




this.OnActivate = function()
	
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()

	if stepIndex >= SsdFlagMission.GetStepIndex( "GameNormalFence" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameMemoryBoard" ) then
		
		this.DisplayGuideLine( { "guidelines_mission_common_memoryBoard"} )
	end

	
	MissionObjectiveInfoSystem.SetForceOpen( true )

end


this.enemyRouteTable = {
	{ enemyName = "zmb_k40060_01_r_0000", routeName = "rt_zmb_k40060_01_r_0000", },
	{ enemyName = "zmb_k40060_01_r_0001", routeName = "rt_zmb_k40060_01_r_0001", },
}





this.messageTable = {
	Trap = {
		{	
			sender = "trap_missionArea",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if SsdFlagMission.GetCurrentStepIndex() >= SsdFlagMission.GetStepIndex( "GameMemoryBoard" ) then
					if fvars.isMissionArea == false then
						TppRadio.Play( "f3000_rtrg0253" )
						fvars.isMissionArea = true
					end
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_memoryBoard",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if SsdFlagMission.GetCurrentStepIndex() >= SsdFlagMission.GetStepIndex( "GameMemoryBoard" ) then
					if fvars.isMemoryBoard == false then
						TppRadio.Play( "f3000_rtrg0254" )
						fvars.isMemoryBoard = true
					end
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_tips0001",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if SsdFlagMission.GetCurrentStepIndex() >= SsdFlagMission.GetStepIndex( "GameMemoryBoard" ) then
					if fvars.isTips02 == false then
						TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_FENCE )
						fvars.isTips02 = true
					end
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_fence",
			msg = "Exit",
			func = function( trapName, gameObjectId )
				if SsdFlagMission.GetCurrentStepIndex() == SsdFlagMission.GetStepIndex( "GameNormalFence" ) then
					TppRadio.Play( "f3000_rtrg0407" )
				end
			end,
			option = { isExecFastTravel = true, },
		},
	},
	Sbm = {
		{	
			msg = "OnDoesNotMeetConditionForCrafting",
			func = function( productionIdCode )
				if SsdFlagMission.GetCurrentStepIndex() == SsdFlagMission.GetStepIndex( "GameNormalFence" ) then
					if productionIdCode == Fox.StrCode32( "RCP_DEF_Fence_C" ) then
						TppRadio.Play( "f3000_rtrg1203" )
					end
				end
			end,
		},
	},
}








lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameNormalFence",
	OnEnter = function( self )
		
		this.DisplayGuideLine( { "guidelines_mission_common_memoryBoard"} )
	end,
	clearConditionTable = {
		completeCraft = {
			
			{
				missionObjectiveInfoTable = {
					langId				= "mission_40060_objective_07",
					facilityType 		= SsdSbm.FACILITY_TYPE_Building,	
					productionIdCode = {
						"PRD_BLD_GadgetPlant_A",
					},
				},
			},
			
			{
				requiredFacility = "GadgetPlant",
				missionObjectiveInfoTable = {
					langId				= "mission_40060_objective_07",
					facilityMenuType	= FacilityMenuType.CRAFT_GADGET,	
					productionIdCode = {
						"PRD_DEF_Fence_C",
					},
				},
			},
			
			{
				requiredProduction = "PRD_DEF_Fence_C",
			},
		},
	},
	options = {
		radio = "f3010_rtrg0200",
		recipe = {
			"RCP_DEF_Fence_C",
		},
		nextStepDelay = {
			{ type = "Delay", delayTimeSec = 6.0, },
		},
		
		
		repopResourceIfMateialInsufficient = {
			checkMaterialList = {
				{ id = "RES_Iron", count = 6 },
			},
			checkFunction = function()
				
				if ( SsdSbm.GetCountProduction{ id="PRD_DEF_Fence_C", inInventory=true, inWarehouse=true } == 0 ) then
					return true
				else
					return false
				end
			end,
			repopSettingList = {
				{
					gimmickId = "GIM_P_TreasurePoint",
					locatorName = "com_treasure_null001_gim_n0002|srt_gim_null_treasure",
					datasetName = "/Assets/ssd/level/location/afgh/block_small/129/129_151/afgh_129_151_gimmick.fox2",
				},
			},
		}
	}
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameTipsCraft",
	clearConditionTable = {
		tips = {
			tipsRadio		= "f3010_rtrg0202",
			tipsTypes		= { HelpTipsType.TIPS_16_A, HelpTipsType.TIPS_16_B },
		},
	},
	options = {
		nextStepDelay = {
			{ type = "Delay", delayTimeSec = 2.0, },
		},
	}
}


this.afterDemoFunc01 = function()
	
	SsdSbm.AddArchive{ id = { "ARCHIVE_A_001", "ARCHIVE_B_001" } } 
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameMemoryBoard",
	OnEnter = function( self )
		
		this.DisplayMissionArea("marker_missionArea")
	end,
	clearConditionTable = {
		switch = {
			{
				gimmickId			= "GIM_P_CommonSwitch",
				locatorName			= "ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001",
				datasetName			= "/Assets/ssd/level/location/afgh/block_large/base/afgh_base_gimmick.fox2",
				isPowerOn			= true,
				isAlertLockType		= true,
				checkObjective = "mission_common_objective_getMemoryBoard",
				memoryBoardDemo = {
					identifier = "GetIntelIdentifier_k40060_sequence",
					key = "GetIntel_MemoryBoard",
					afterDemoFunc = this.afterDemoFunc01,
				},
			},
		},
	},
	options = {
		radio = "f3010_rtrg0203",
		marker = {
			{ name = "marker_energyBoard", },
		},
		objective = "mission_common_objective_getMemoryBoard",
	}
}


this.EndTipsFence = function()
	
	TppMarker.Enable( "marker_fence", 0, "moving", "all", 0, true, true )
	
	TppTutorial.StartHelpTipsMenuOnlyAnnounce( tipsMenuAnnounceList.TIPS_ZOMBIE )
end

this.flagStep.GameMemoryBoard.messageTable = {
	GameObject = {
		{
			msg = "BuildingEnd",
			func = function( gameObjectId, typeId, productionId )
				if fvars.isDisableFenceMarker == false then
					
					if productionId == StrCode32( "PRD_DEF_Fence_C" ) then
						local searchProductionId		= "PRD_DEF_Fence_C"
						local searchPos					= Vector3( -210.722, 296.059, 2304.041 )
						local length, pos, gameObjectId = Gimmick.SearchNearestSsdGimmick {
							pos				= searchPos,
							searchRadius	= 5,
							productionId	= searchProductionId,
							heavySearch		= true,
							onlyEquip		= true,
						}
						if gameObjectId then
							
							TppMarker.Disable( "marker_fence" )
							fvars.isDisableFenceMarker = true
						end
					end
				end
			end,
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameEscape",
	OnEnter = function( self )
		
		TppMarker.Disable( "marker_fence" )
		
		this.DisableMissionArea( "marker_missionArea" )
		
		this.DisableGuideLine()
	end,
	clearConditionTable = {
		home = { checkObjective = "mission_common_objective_returnToBase", },
	},
	options = {
		radio = "f3000_rtrg0256",
		objective = "mission_common_objective_returnToBase",
		nextStepDelay = {
			{ type = "Delay", delayTimeSec = 4.5, },
		},
	}
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameTipsMapUpdate",
	clearConditionTable = {
		tips = {
			tipsRadio = "f3010_rtrg0212",
			tipsTypes = { HelpTipsType.TIPS_10_A, HelpTipsType.TIPS_10_B, HelpTipsType.TIPS_10_C, },
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameAiAccess",
	OnEnter = function( self )
		
		TppMarker.Enable( "marker_ai", 0, "moving", "all", 0, true, true )
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
	end,
	clearConditionTable = {
		switch = {
			{
				gimmickId	= "GIM_P_AI",
				locatorName = "com_ai001_gim_n0000|srt_aip0_main0_def",
				datasetName = "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",
				checkObjective = "mission_common_objective_accessToAI",
			},
		},
	},
	options = {
		radio = "f3000_rtrg0257",
		objective = "mission_common_objective_accessToAI",
	}
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameClear",
	clearConditionTable = {
		clearStage = {
			demo = "p01_000010",
			fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED,
		}
	}
}




this.blackRadioOnEnd = "K40060_0020"




this.releaseAnnounce = { "AddRecipeScaffold", "EnableBuilding" }

return this
