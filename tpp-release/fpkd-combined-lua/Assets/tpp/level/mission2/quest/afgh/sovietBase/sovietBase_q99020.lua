local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId









local CHECK_ENEMY_POS		= {-648.030, 540.732, -1641.722} 
local CHECK_ENEMY_RANGE		= 15	
local EVENT_DOOR_NAME		= "gntn_door004_vrtn002_gim_n0001|srt_gntn_door004_vrtn002"
local EVENT_DOOR_PATH		= "/Assets/tpp/level/location/afgh/block_large/powerPlant/afgh_powerPlant_gimmick.fox2"


local LOCK_POS = Vector3(-648.202, 541.944, -1642.727)


this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.STORY,
	
	cpList = {
		nil
	},
	
	enemyList = {
		nil
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
			Fox.Log("quest_recv_child OnActivate")
			
			TppEnemy.OnActivateQuest( this.QUEST_TABLE )
			mvars.isPlayed_f2000_rtrg3010 = false

		end,
		OnDeactivate = function()
			Fox.Log("quest_recv_child OnDeactivate")
			
			TppEnemy.OnDeactivateQuest( this.QUEST_TABLE )
		end,
		OnOutOfAcitveArea = function()
		end,
		OnTerminate = function()
			
			TppEnemy.OnTerminateQuest( this.QUEST_TABLE )
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
	}
end




function this.OnInitialize()
	TppQuest.QuestBlockOnInitialize( this )
end

function this.OnUpdate()
	TppQuest.QuestBlockOnUpdate( this )
end

function this.OnTerminate()
	TppQuest.QuestBlockOnTerminate( this )
end








quest_step.QStep_Start = {

	Messages = function( self )
		return
		StrCode32Table {
			GameObject = {
				{	
					msg = "Dead",
					func = function( gameObjectId )
						local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Dead", gameObjectId )
						TppQuest.ClearWithSave( isClearType )
					end
				},
				{	
					msg = "Fulton",
					func = function( gameObjectId )
						local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Fulton", gameObjectId )
						TppQuest.ClearWithSave( isClearType )
					end
				},
				{	
					msg = "FultonFailed",
					func = function( gameObjectId, locatorName, locatorNameUpper, failureType )
						if failureType == TppGameObject.FULTON_FAILED_TYPE_ON_FINISHED_RISE then
							local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "FultonFailed", gameObjectId )
							TppQuest.ClearWithSave( isClearType )
						end
					end
				},
				{	
					msg = "Unconscious",
					func = function( gameObjectId )
						local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Unconscious", gameObjectId )
						TppQuest.ClearWithSave( isClearType )
					end
				},
				{	
					msg = "VehicleBroken",
					func = function( gameObjectId, state )
						if state == StrCode32("End") then
							local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "VehicleBroken", gameObjectId )
							TppQuest.ClearWithSave( isClearType )
						end
					end
				},
			},
			
			Radio = {
				{ msg = "Finish", sender = "f2000_rtrg3010",

					func = function()
						Fox.Log("**** sovietBase_q99020:Played f2000_rtrg3010 ****")
						
						TppMarker.Enable( "marker_powerPlant_hanger", 0, "moving", "all", 0 )
					end,
				},
			},
			Player = {
				{
					msg = "CheckEventDoorNgIcon",
					func = function(playerId,doorId)
						Fox.Log("**** sovietBase_q99020:Event door Check!! ****")
						Fox.Log("player in event door")
						local result,checkAlert,checkEnemy = TppDemo.CheckEventDemoDoor(doorId,CHECK_ENEMY_POS,CHECK_ENEMY_RANGE)
						
						if result == true then
							Fox.Log("check is ok")
						elseif checkAlert == false then
							Fox.Log("check is ng. alert")
							
							TppRadio.Play( "f1000_rtrg2250" )
						elseif checkEnemy == false then
							Fox.Log("check is ng. enemy")
							
							TppRadio.Play( "f1000_rtrg2260" )
						end
					end
				},
				{
					msg = "StartEventDoorPicking",
					func = function ()
						Fox.Log("**** sovietBase_q99020:Event door Open!! ****")
						TppSoundDaemon.PostEvent( "sfx_s_act_icon_choose" )
						this.StartCameraFocalLengthAndDistance()	
						
						GkEventTimerManager.Start( "Timer_PickingSE_02", 1.0 ) 
					end
				},
			},
			Trap = {
				{	
					msg = "Enter",	sender = "trap_Update_s10070_Open",
					func = function()
						if mvars.isPlayed_f2000_rtrg3010 == false then
							Fox.Log("**** sovietBase_q99020:trap_Update_s10070_Open Enter ****")
							TppRadio.Play( "f2000_rtrg3010" )
							mvars.isPlayed_f2000_rtrg3010 = true
						end
					end,
				},
				{	
					msg = "Enter",	sender = "trap_s10070_EventDoorSet",
					func = function()
						Fox.Log("**** sovietBase_q99020:trap_s10070_EventDoorSet Enter ****")
						
						Gimmick.SetEventDoorLock( EVENT_DOOR_NAME , EVENT_DOOR_PATH , true , 0 )
					end,
				},
			},
			Timer = {
				{
					msg = "Finish", sender = "Timer_PickingSE_02",
					func = function()
						
						
						TppMission.ReserveMissionClear{ nextMissionId = 10070, missionClearType = TppDefine.MISSION_CLEAR_TYPE.QUEST_INTRO_RESCUE_EMERICH_END }
					end,
				},
			},
		}
	end,

	OnEnter = function()
		Fox.Log("QStep_Start OnEnter")

	end,
	OnLeave = function()
		Fox.Log("QStep_Start OnLeave")
		
		Gimmick.SetEventDoorLock( EVENT_DOOR_NAME , EVENT_DOOR_PATH , false , 0 )
	end,

}

quest_step.QStep_Main = {

	OnEnter = function()
		Fox.Log("QStep_Main OnEnter")
		
	end,
	OnLeave = function()
		Fox.Log("QStep_Main OnLeave")
	end,

}




function this.SwitchSovietBaseHungerAsset_ReptilePod()

	Fox.Log("**** q99030.SwitchSovietBaseHungerAsset_ReptilePod ****")

	
	TppDataUtility.SetVisibleDataFromIdentifier( "sovietBase_asset_DataIdentifier", "ReptileHungerAsset_HueyMission", false, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "sovietBase_asset_DataIdentifier", "HueyHungerAsset_HueyMission", false, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "sovietBase_asset_DataIdentifier", "HueyHungerAsset_ReptileMission", true, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "sovietBase_asset_DataIdentifier", "ReptileHungerAsset_ReptileMission", true, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "sovietBase_asset_DataIdentifier", "ReptileHungerAsset_TopRoof_Before", true, true)

	
	TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset01_DataIdentifier", "HueyHungerAsset_HueyMission", false, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset01_DataIdentifier", "HueyHungerAsset_ReptileMission", true, true)

	
	TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset02_DataIdentifier", "ReptileHungerAsset_ReptileMission", true, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset02_DataIdentifier", "ReptileHungerAsset_HueyMission", false, true)
	TppDataUtility.SetVisibleDataFromIdentifier( "soviet_mission_asset02_DataIdentifier", "ReptileHungerAsset_TopRoof_After", false, true)

end


function this.StartCameraFocalLengthAndDistance()

	Fox.Log("**** q99030.StartCameraFocalLengthAndDistance ****")
	
	Player.RequestToSetCameraFocalLengthAndDistance {
		focalLength = 31, 
		distance = 4, 
		interpTime = 0.8 
	}

end





return this