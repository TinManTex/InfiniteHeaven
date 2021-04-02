local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId






this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.DEVELOP_RECOVERED,
	
	cpList = {
		nil
	},
	
	enemyList = {
		
		{ 
			setCp = "afgh_powerPlant_cp",
			isDisable = true,
		},
		{
			enemyName = "sol_quest_0000",
			route_d = "rt_quest_d_0000", 	route_c = "rt_quest_d_0000",
			cpName	= "afgh_powerPlant_cp",
			powerSetting = { },
		},
				{
			enemyName = "sol_quest_0001",
			route_d = "rt_quest_d_0001", 	route_c = "rt_quest_d_0001",
			cpName	= "afgh_powerPlant_cp",
			powerSetting = { },
		},
		{
			enemyName = "sol_quest_0002",
			route_d = "rt_quest_d_0002", 	route_c = "rt_quest_d_0002",
			cpName	= "afgh_powerPlant_cp",
			powerSetting = { },
		},
		{
			enemyName = "sol_quest_0003",
			route_d = "rt_quest_d_0003", 	route_c = "rt_quest_d_0003",
			cpName	= "afgh_powerPlant_cp",
			powerSetting = { },
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
	
	targetDevelopList = {
		"col_develop_Stungun"
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
			
			TppGimmick.OnActivateQuest( this.QUEST_TABLE )
			
			TppEnemy.OnActivateQuest( this.QUEST_TABLE )
		end,
		OnDeactivate = function()
			Fox.Log("quest_recv_child OnDeactivate")
			
			TppEnemy.OnDeactivateQuest( this.QUEST_TABLE )
		end,
		OnOutOfAcitveArea = function()
		end,
		OnTerminate = function()
			
			TppGimmick.OnTerminateQuest( this.QUEST_TABLE )
			
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
	OnEnter = function()
		TppQuest.SetNextQuestStep( "QStep_Main" )
	end,
}

quest_step.QStep_Main = {
	
	Messages = function( self )
		return
		StrCode32Table {
			Player = {
				{	
				 	msg = "OnPickUpCollection",
					func = function( playerGameObjectId, collectionUniqueId, collectionTypeId )
						if this.QUEST_TABLE.questType == TppDefine.QUEST_TYPE.DEVELOP_RECOVERED then
							local isClearType = TppGimmick.CheckQuestAllTarget( this.QUEST_TABLE.questType, collectionUniqueId )
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
