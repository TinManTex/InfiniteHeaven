local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId








local TARGET_HOSTAGE_NAME = "child_quest_0000"


this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.RECOVERED,
	
	cpList = {
		nil
	},
	
	enemyList = {
		{
			enemyName = "sol_quest_0000",
			route_d = "rt_quest_d_0000", 	route_c = "rt_quest_d_0000",
			cpName = "afgh_remnants_cp",
			powerSetting = { "HELMET" },
		},
		{
			enemyName = "sol_quest_0001",
			route_d = "rt_quest_d_0001", 	route_c = "rt_quest_d_0001",
			cpName = "afgh_remnants_cp",
			powerSetting = { "HELMET" },
		},
		{
			enemyName = "sol_quest_0002",
			route_d = "rt_quest_d_0002", 	route_c = "rt_quest_d_0002",
			cpName = "afgh_remnants_cp",
			powerSetting = { "HELMET" },
		},
	},
	
	vehicleList = {
		nil
	},
	
	hostageList = {
		{
			hostageName		= TARGET_HOSTAGE_NAME,
			bodyId			= TppDefine.QUEST_BODY_ID_LIST.Q20910,
		},
	},
	
	targetList = {
		TARGET_HOSTAGE_NAME,
	},
}




function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		"QStep_Main",
		nil
	}

	
	TppEnemy.OnAllocateQuestFova( this.QUEST_TABLE )

	
	TppHostage2.SetHostageType{
		gameObjectType	= "TppHostageUnique",
		hostageType		= "ChildNoStand",
	}

	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = function()
			Fox.Log("quest_recv_child OnActivate")
			
			TppEnemy.OnActivateQuest( this.QUEST_TABLE )
			
			local gameObjectId = GameObject.GetGameObjectId( "child_quest_0000" )
			GameObject.SendCommand( gameObjectId, { id = "SetHostage2Flag", flag = "unlocked", on = true, } )
		end,
		OnDeactivate = function()
			Fox.Log("quest_recv_child OnDeactivate")
			
			TppEnemy.OnDeactivateQuest( this.QUEST_TABLE )
		end,
		OnOutOfAcitveArea = function()
		end,
		OnTerminate = function()
			TppUiCommand.UnRegisterIconUniqueInformation( GameObject.GetGameObjectId(TARGET_HOSTAGE_NAME) )
			
			TppEnemy.OnTerminateQuest( this.QUEST_TABLE )
		end,
	}
	
	mvars.fultonInfo = TppDefine.QUEST_CLEAR_TYPE.NONE
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
		Radio = {
			{	
				msg = "Finish",
				sender = "f2000_rtrg1560",
				func = function ()
					Fox.Log( "this.Messages Radio:Finish")
						
						if Player.GetItemLevel( TppEquip.EQP_IT_Fulton_Child ) >= 1 then
							Fox.Log("**** Fulton_Child is developed ****")
						elseif Player.GetItemLevel( TppEquip.EQP_IT_Fulton_WormHole ) >= 1 then
							Fox.Log("**** Fulton_WormHole is developed ****")
						else
							TppRadio.Play( "f1000_rtrg2450", { delayTime = "short" } )
						end					
				end
			},
			{	
				msg = "Finish",
				sender = "f2000_rtrg8320",
				func = function ()
					Fox.Log( "this.Messages Radio:Finish")
						
						if Player.GetItemLevel( TppEquip.EQP_IT_Fulton_Child ) >= 1 then
							Fox.Log("**** Fulton_Child is developed ****")
						elseif Player.GetItemLevel( TppEquip.EQP_IT_Fulton_WormHole ) >= 1 then
							Fox.Log("**** Fulton_WormHole is developed ****")
						else
							TppRadio.Play( "f1000_rtrg2450", { delayTime = "short" } )
						end					
				end
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
	OnEnter = function()
		TppUiCommand.RegisterIconUniqueInformation{ markerId = GameObject.GetGameObjectId(TARGET_HOSTAGE_NAME), langId = "marker_hostage_boys" }
		TppQuest.SetNextQuestStep( "QStep_Main" )
	end,
}

quest_step.QStep_Main = {
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
					msg = "FultonInfo",
					func = function( gameObjectId )
						if mvars.fultonInfo == TppDefine.QUEST_CLEAR_TYPE.CLEAR then
							TppQuest.ClearWithSave( mvars.fultonInfo )
							mvars.fultonInfo = TppDefine.QUEST_CLEAR_TYPE.NONE
						end
					end
				},
				{	
					msg = "Fulton",
					func = function( gameObjectId )
						local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Fulton", gameObjectId )
						if isClearType == TppDefine.QUEST_CLEAR_TYPE.CLEAR then
							mvars.fultonInfo = TppDefine.QUEST_CLEAR_TYPE.CLEAR
						end
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
					msg = "PlacedIntoVehicle",
					func = function( gameObjectId, vehicleGameObjectId )
						if Tpp.IsHelicopter( vehicleGameObjectId ) then
							local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "InHelicopter", gameObjectId )
							TppQuest.ClearWithSave( isClearType )
						end
					end
				},
			},
		}
	end,
	OnEnter = function()
		Fox.Log("QStep_Main OnEnter")
	end,
	OnLeave = function()
		Fox.Log("QStep_Main OnLeave")
	end,
}

return this
