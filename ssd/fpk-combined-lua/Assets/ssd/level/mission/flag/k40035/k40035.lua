



local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId

local this = BaseFlagMission.CreateInstance( "k40035" )

local lastAddedStep


this.missionAreas = {
	{
		name = "marker_missionArea",
		trapName = "trap_missionArea",
		visibleArea = 9,
		guideLinesId = "guidelines_mission_common_digger",
	},
}

this.enterMissionAreaRadio = "f3010_rtrg0702"


this.enemyLevelSettingTable = {
	areaSettingTableList = {
		{
			areaName = "AreaVehicle",
			level = -3,
			randomRange = 0,
		},
	},
}


BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isTipsStepTransition",				 type = TppScriptVars.TYPE_BOOL,	value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isEquipFulton",						 type = TppScriptVars.TYPE_BOOL,	value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)





this.OnActivate = function()

	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		this.DisableMissionArea( "marker_missionArea" )
	end
	
	
	if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) then
		this.DisplayGuideLine( { "guidelines_mission_common_digger"} )
	end

	
	if stepIndex == SsdFlagMission.GetStepIndex( "GameEscape" ) then
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end
	
end




this.messageTable = {
	Trap = {
		{	
			sender = "trap_RadioFulton0000",
			msg = "Enter",
			func = function ()
				
				this.RadioPlayNoSulton()
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_RadioFulton0001",
			msg = "Exit",
			func = function ()
				
				this.RadioPlayNoSulton()
			end,
			option = { isExecFastTravel = true, },
		},
	}
}


this.RadioPlayNoSulton = function()
	if fvars.isEquipFulton == false then
		
		local count = SsdSbm.GetCountProduction{ id="PRD_SVE_Fulton", inInventory=true, inWarehouse=true }
		if count >= 1 then
			fvars.isEquipFulton = true
		else
			if not mvars.isRadioFulton then
				TppRadio.Play( "f3010_rtrg0705" )
				mvars.isRadioFulton = true
			end
		end
	end
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameTipsWH",
	options = {
	},
	clearConditionTable = {
		tips = {
			tipsRadio = "f3010_rtrg0700",
			tipsTypes = {
				{ HelpTipsType.TIPS_84_A, },
			},
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameMain",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		this.DisplayGuideLine( { "guidelines_mission_common_digger"} )
	end,
	options = {
		continueRadio = "f3010_rtrg0701",
		objective = "mission_40035_objective_01",
		marker = {
			{ name = "marker_target", },
		},
		
		
		repopResourceIfMateialInsufficient = {
			checkMaterialList = {
				{ id = "RES_Iron",		count = 1 }, 
				{ id = "RES_Wire",		count = 1 }, 
				{ id = "RES_Adhesive",	count = 1 }, 
			},
			checkFunction = function()
				
				if ( SsdSbm.GetCountProduction{ id="PRD_SVE_Fulton", inInventory=true, inWarehouse=true } == 0 ) then
					return true
				else
					return false
				end
			end,
			repopSettingList = {
				{	
					gimmickId = "GIM_P_TreasurePoint",
					locatorName = "com_treasure_null001_gim_n0000|srt_gim_null_treasure",
					datasetName = "/Assets/ssd/level/location/afgh/block_small/128/128_148/afgh_128_148_gimmick.fox2",
				},
				{	
					gimmickId = "GIM_P_TreasurePoint",
					locatorName = "com_treasure_null001_gim_n0002|srt_gim_null_treasure",
					datasetName = "/Assets/ssd/level/location/afgh/block_small/129/129_151/afgh_129_151_gimmick.fox2",
				},
			},
		}
	},
}

this.flagStep.GameMain.messageTable = {
	GameObject = {
		{	
			msg = "WormholeFultoned",
			func = function( gameObjectId, typeId, productionId )
				Fox.Log( "k40035.Messages(): GameObject: msg:WormholeFultoned, gameObjectId:" .. tostring( gameObjectId ) )
				local gimmickGameObjectId = Gimmick.SsdGetGameObjectId{
					gimmickId		= "GIM_P_Digger",
					name			= "whm0_main1_gim_n0000|srt_whm0_main1_def_v00",
					dataSetName		= "/Assets/ssd/level/mission/flag/k40035/k40035_item.fox2",
				}
				Fox.Log( "k40035.Messages(): Gimmick.SsdGetGameObjectId, gimmickGameObjectId:" .. tostring( gimmickGameObjectId ) )
				
				if gameObjectId == gimmickGameObjectId then
					MissionObjectiveInfoSystem.Check{ langId="mission_40035_objective_01",checked=true }
					
					this.DisableMissionArea( "marker_missionArea" )
					SsdFlagMission.SetNextStep( "GameEscape" )
				end
			end
		},
	},
}



lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameEscape",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		this.DisableGuideLine()
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end,
	options = {
		radio = "f3010_rtrg0703",
		objective = "mission_common_objective_returnToBase",
		checkObjectiveIfCleared = "mission_common_objective_returnToBase",
	},
	clearConditionTable = {
		home = true,
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameClear",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		afgh_base.SetDiggerVisibility( true )
	end,
	OnLeave = function()
	end,
	options = {},
	clearConditionTable = {
		clearStage = {
			demo = {
				demoName = "p01_000030",
				funcs = {
					SetDemoTransform = function()
						return Vector3( -445.838, 287.320, 2246.257 )	
					end,
				},
			}
		}
	},
}




this.blackRadioOnEnd = "K40035_0020"

return this
