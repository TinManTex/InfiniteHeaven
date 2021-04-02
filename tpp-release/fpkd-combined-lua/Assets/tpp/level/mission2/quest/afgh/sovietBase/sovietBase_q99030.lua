local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId









local DATASET_PATH_LARGE = "/Assets/tpp/level/location/afgh/block_large/sovietBase/afgh_sovietBase_asset.fox2"
local DATASET_PATH_ASSET01 = "/Assets/tpp/level/location/afgh/block_large/sovietBase/afgh_soviet_mission_asset01.fox2"


this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.STORY,
	
	cpList = {
		nil
	},
	
	enemyList = {
		{
			enemyName = "sol_quest_0000",
			route_d = "rt_quest_d_0000", 	route_c = "rt_quest_c_0000",
			cpName = "afgh_sovietBase_cp",
		},
		{
			enemyName = "sol_quest_0001",
			route_d = "rt_quest_d_0001", 	route_c = "rt_quest_c_0001",
			cpName = "afgh_sovietBase_cp",
		},
		{
			enemyName = "sol_quest_0002",
			route_d = "rt_quest_d_0002", 	route_c = "rt_quest_c_0002",
			cpName = "afgh_sovietBase_cp",
		},
		{
			enemyName = "sol_quest_0003",
			route_d = "rt_quest_d_0003", 	route_c = "rt_quest_c_0003",
			cpName = "afgh_sovietBase_cp",
		},
	},
	
	vehicleList = {
		nil
	},
	
	hostageList = {
		nil
	},
	
	targetList = {
		nil
	},
}




function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		"QStep_Main",
		nil
	}

	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = function()
			Fox.Log("quest:Recover ReptilePod OnActivate")
			
			TppEnemy.OnActivateQuest( this.QUEST_TABLE )
			
			this.AddTrapSettingForAiPodDemo{
				demoName = "AiPod",
				trapName = "trap_ReptilePod_Demo",			
				direction = 0,
			}
			this.AddTrapSettingForAiPodDemo{
				demoName = "AiPod",
				trapName = "trap_ReptilePod_Demo_AiPod",	
				direction = 90,
			}
			mvars.isAiPodDemoPlay = false
		end,
		OnDeactivate = function()
			Fox.Log("quest:Recover ReptilePod OnDeactivate")
			TppEnemy.OnDeactivateQuest( this.QUEST_TABLE )
		end,
		OnOutOfAcitveArea = function()
			Fox.Log("quest:Recover ReptilePod OnOutOfAcitveArea")
		end,
		OnTerminate = function()
			Fox.Log("quest:Recover ReptilePod OnTerminate")

			
			TppEnemy.OnTerminateQuest( this.QUEST_TABLE )

			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0005|srt_mtbs_door006_door005" , DATASET_PATH_LARGE, true , 0 )
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0002|srt_mtbs_door006_door005" , DATASET_PATH_LARGE, true , 0 )
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0006|srt_mtbs_door006_door005" , DATASET_PATH_LARGE, true , 0 )
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0003|srt_mtbs_door006_door005" , DATASET_PATH_LARGE, true , 0 )
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0007|srt_mtbs_door006_door005" , DATASET_PATH_LARGE, true , 0 )
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0004|srt_mtbs_door006_door005" , DATASET_PATH_LARGE, true , 0 )
		end,
	}
end




this.Messages = function()
	return
	StrCode32Table {
		Block = {
			{
				msg = "StageBlockCurrentSmallBlockIndexUpdated",
				func = function() end,
			},
		},
		Trap = {
			{	
				msg = "Enter",	sender = "trap_Hunger",
				func = function()
					Fox.Log("**** sovietBase_q99030:Enter trap_Hunger ****")
					
					TppUiStatusManager.SetStatus( "MbMissionList", "DISABLE_BY_QUEST" )
				end,
			},
			{	
				msg = "Exit",	sender = "trap_Hunger",
				func = function()
					Fox.Log("**** sovietBase_q99030:Exit trap_Hunger ****")
					
					TppUiStatusManager.UnsetStatus( "MbMissionList", "DISABLE_BY_QUEST" )
				end,
			},
		},
	}
end




function this.OnInitialize()
	TppQuest.QuestBlockOnInitialize( this )
end

function this.OnUpdate()
	TppQuest.QuestBlockOnUpdate( this )
end

function this.OnTerminate()
	this.TerminateQuestAssetSetting()		
	TppUiStatusManager.UnsetStatus( "MbMissionList", "DISABLE_BY_QUEST" )	
	TppQuest.QuestBlockOnTerminate( this )
end








quest_step.QStep_Start = {

	Messages = function( self )
		return
		StrCode32Table {
			Trap = {
				{
					
					msg = "Enter",	sender = "trap_load_anmlBlock",
					func = function ()
						
						TppScriptBlock.Load( "animal_block", "sovietBase_I_AiPod", true )
					end
				},
				
				{
					msg = "Enter", sender = "trap_SwitchHungerAsset" ,
					func = function()
						Fox.Log("**** sovietBase_q99030:trap_SwitchHungerAsset ****")
						
						this.SwitchSovietBaseHungerAsset_ReptilePod()
					end,
				},
				{	
					msg = "Enter",	sender = "trap_EnableMarker_AIpodComputer",
					func = function()
						Fox.Log("**** sovietBase_q99030:trap_EnableMarker_AIpodComputer ****")
						
						TppMarker.Enable( "marker_AIpod_Computer", 0, "moving", "all", 0 )
					end,
				},
				






















				
				{
					msg = "Enter",	
					func = function (arg0,arg1)
						if arg0 == StrCode32("trap_ReptilePod_Demo") or arg0 == StrCode32("trap_ReptilePod_Demo_AiPod") then
							this.ShowIconForAiPodDemo( "AiPod", mvars.isAiPodDemoPlay )
						end
					end
				},
				
				{
					msg = "Exit",	
					func = function (arg0,arg1)
						if arg0 == StrCode32("trap_ReptilePod_Demo") or arg0 == StrCode32("trap_ReptilePod_Demo_AiPod") then
							this.HideIconForAiPodDemo()
						end
					end
				},
			},
			Player = {
				
				{
					msg = "AiPod_Start", sender = "AiPod",
					func = function()
						this.AiPod_DemoPlay()
					end,
				},
			},
			Demo = {
				{	
					msg = "pod_visoff",
					func = function( targetName, gameObjectId )
						Fox.Log("*** DemoMessage:pod_visoff ***")
						
						this.SwitchSovietBaseHungerAsset_ReptilePod_DemoStart()
					end,
					option = { isExecDemoPlaying = true },
				},
				{	
					msg = "photo_on",
					func = function( targetName, gameObjectId )
						Fox.Log("*** DemoMessage:photo_on ***")
						
						TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset05_DataIdentifier", "env_aip0_memo", true, true)		
					end,
					option = { isExecDemoPlaying = true },
				},
			},
		}
	end,

	OnEnter = function()
		Fox.Log("QStep_Start OnEnter")
	end,
	OnLeave = function()
		Fox.Log("QStep_Start OnLeave")
	end,

}

quest_step.QStep_Main = {
	Messages = function( self )
		return
		StrCode32Table {
			Trap = {
				
				{
					msg = "Enter", sender = "trap_ReptilePod_Demo" ,
					func = function()
					end,
				},
			},
		}
	end,

	OnEnter = function()
		Fox.Log("QStep_Main OnEnter")
		TppMarker.Disable( "marker_AIpod_Computer" )
		TppQuest.ClearWithSave( TppDefine.QUEST_CLEAR_TYPE.CLEAR )
	end,
	OnLeave = function()
		Fox.Log("QStep_Main OnLeave")
	end,
}




function this.SwitchSovietBaseHungerAsset_ReptilePod()

	Fox.Log("**** q99030.SwitchSovietBaseHungerAsset_ReptilePod ****")

	
	TppDataUtility.SetVisibleDataFromIdentifier( "sovietBase_asset_DataIdentifier", "ReptileHungerAsset_HueyMission", false, true)
	
	TppDataUtility.SetVisibleDataFromIdentifier( "sovietBase_asset_DataIdentifier", "HueyHungerAsset_ReptileMission", true, true)
	
	TppDataUtility.SetVisibleDataFromIdentifier( "sovietBase_asset_DataIdentifier", "ReptileHungerAsset_TopRoof_Before", true, true)

	
	TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset01_DataIdentifier", "HueyHungerAsset_HueyMission", false, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset01_DataIdentifier", "HueyHungerAsset_ReptileMission", true, true)

	
	TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset02_DataIdentifier", "ReptileHungerAsset_ReptileMission", true, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset02_DataIdentifier", "ReptileHungerAsset_HueyMission", false, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset02_DataIdentifier", "ReptileHungerAsset_TopRoof_After", false, true)

	
	TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset05_DataIdentifier", "env_aip0_memo", false, true)		

	
	Gimmick.InvisibleGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "afgh_cmpt002_gim_n0001|srt_afgh_cmpt002", DATASET_PATH_ASSET01, true )
	Gimmick.InvisibleGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "afgh_cmpt002_gim_n0002|srt_afgh_cmpt002", DATASET_PATH_ASSET01, true )
	Gimmick.InvisibleGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "afgh_cmpt002_gim_n0003|srt_afgh_cmpt002", DATASET_PATH_ASSET01, false )
	Gimmick.InvisibleGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "afgh_cmpt002_gim_n0004|srt_afgh_cmpt002", DATASET_PATH_ASSET01, false )
	Gimmick.InvisibleGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "afgh_cmpt002_gim_n0005|srt_afgh_cmpt002", DATASET_PATH_ASSET01, true )
	Gimmick.InvisibleGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "afgh_cmpt002_gim_n0000|srt_afgh_cmpt002", DATASET_PATH_ASSET01, true )
	Gimmick.InvisibleGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "afgh_cmpt002_gim_n0007|srt_afgh_cmpt002", DATASET_PATH_ASSET01, true )
	Gimmick.InvisibleGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "afgh_cmpt002_gim_n0008|srt_afgh_cmpt002", DATASET_PATH_ASSET01, true )
	Gimmick.InvisibleGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "afgh_cmpt002_gim_n0009|srt_afgh_cmpt002", DATASET_PATH_ASSET01, true )
	
	Gimmick.ResetGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "afgh_cmpt002_gim_n0003|srt_afgh_cmpt002", DATASET_PATH_ASSET01 )
	Gimmick.ResetGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "afgh_cmpt002_gim_n0004|srt_afgh_cmpt002", DATASET_PATH_ASSET01 )

	
	Gimmick.InvisibleGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "aip0_main0_gm_gim_n0000|srt_aip0_main0_gm", DATASET_PATH_ASSET01, true )
	Gimmick.InvisibleGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "aip0_main0_gm_gim_n0001|srt_aip0_main0_gm", DATASET_PATH_ASSET01, false )

	
	Gimmick.InvincibleGimmickData( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "afgh_cmpt002_gim_i0000|TppPermanentGimmick_afgh_cmpt002_", DATASET_PATH_ASSET01, true )

	
	TppDataUtility.SetVisibleDataFromIdentifier( "f30010_sovietBase_DataIdentifier", "center_hous", false, true)

end


function this.SwitchSovietBaseHungerAsset_ReptilePod_DemoStart()

	Fox.Log("**** q99030.SwitchSovietBaseHungerAsset_ReptilePod_DemoStart ****")

	
	
	TppDataUtility.SetVisibleDataFromIdentifier( "sovietBase_asset_DataIdentifier", "ReptileHungerAsset_TopRoof_Before", false, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset05_DataIdentifier", "aip_memo", false, true)

	
	
	Gimmick.InvisibleGimmick( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "aip0_main0_gm_gim_n0001|srt_aip0_main0_gm", DATASET_PATH_ASSET01, true )

end


function this.SwitchSovietBaseHungerAsset_ReptilePod_DemoEnd()

	Fox.Log("**** q99030.SwitchSovietBaseHungerAsset_ReptilePod_DemoEnd ****")

	
	
	TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset02_DataIdentifier", "ReptileHungerAsset_TopRoof_After", true, true)

	
	
	

	
	Gimmick.InvincibleGimmickData( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "afgh_cmpt002_gim_i0000|TppPermanentGimmick_afgh_cmpt002_", DATASET_PATH_ASSET01, false )


end


function this.TerminateQuestAssetSetting()

	Fox.Log("**** q99030.TerminateQuestAssetSetting ****")
	
	TppDataUtility.SetVisibleDataFromIdentifier( "sovietBase_asset_DataIdentifier", "ReptileHungerAsset_TopRoof_Before", true, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset02_DataIdentifier", "ReptileHungerAsset_TopRoof_After", false, true)

	
	TppDataUtility.SetVisibleDataFromIdentifier( "f30010_sovietBase_DataIdentifier", "center_hous", true, true)

end



function this.AddTrapSettingForAiPodDemo( params )
	local trapName = params.trapName
	local direction = params.direction or 0
	local directionRange = params.directionRange or 45
	local demoName = params.demoName

	if not Tpp.IsTypeString(trapName) then
		Fox.Error("Invalid trap name. trapName = " .. tostring(trapName) )
	end

	Fox.Log("sovietBase_q99030.AddTrapSettingForAiPodDemo. trapName = " .. tostring(trapName) .. ", direction = " .. tostring(direction) .. ", directionRange = " .. tostring(directionRange) )

	mvars.AiPod_TrapInfo = mvars.AiPod_TrapInfo or {}

	if demoName then
		mvars.AiPod_TrapInfo[demoName] = { trapName = trapName }
	else
		Fox.Error("s10070_sequence.AddTrapSettingForAiPodDemo: Must set demo name.")
	end

	Player.AddTrapDetailCondition {
		trapName = trapName,
		condition = PlayerTrap.FINE,
		action = ( PlayerTrap.NORMAL + PlayerTrap.CARRY ),
		stance = (PlayerTrap.STAND + PlayerTrap.SQUAT ),
		direction = direction,
		directionRange = directionRange,
	}
end


function this.ShowIconForAiPodDemo( demoName, doneCheckFlag )

	if not Tpp.IsTypeString(demoName) then
		Fox.Error("invalid demo name. demoName = " .. tostring(demoName) )
		return
	end

	local trapName
	if mvars.AiPod_TrapInfo and mvars.AiPod_TrapInfo[demoName] then
		trapName = mvars.AiPod_TrapInfo[demoName].trapName
	end

	if not doneCheckFlag then
		if Tpp.IsNotAlert() then
			Fox.Log("sovietBase_q99030.ShowIconForAiPodDemo()")
			Player.RequestToShowIcon {
				type = ActionIcon.ACTION,
				icon = ActionIcon.AI_POD,
				message = StrCode32("AiPod_Start"),
				messageArg = demoName,
			}
		elseif trapName then
			this.HideIconForRideMetalDemo()
			Player.SetWaitingTimeToTrapDetailCondition { trapName = trapName, time = 2.0 }
			
		else
			
		end
	end
end

function this.HideIconForAiPodDemo()
	Fox.Log("sovietBase_q99030.ShowIconForAiPodDemo()")
	Player.RequestToHideIcon{
		type = ActionIcon.ACTION,
		icon = ActionIcon.AI_POD,
	}
end


function this.AiPod_DemoPlay()
	Fox.Log("**** sovietBase_q99030:AiPod_DemoPlay ****")
	TppDemo.Play(
		"Demo_RecoverReptilePod",
		{
			onStart = function()

			end,
			onEnd = function()
				
				this.SwitchSovietBaseHungerAsset_ReptilePod_DemoEnd()
				TppQuest.SetNextQuestStep( "QStep_Main" )
			end,
		}
	)
end





return this