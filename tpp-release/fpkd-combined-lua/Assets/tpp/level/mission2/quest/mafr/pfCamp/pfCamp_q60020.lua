local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId








local QUEST_MINE_TOTAL_COUNT = 9




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
			
			TppGimmick.SetUpMineQuest( QUEST_MINE_TOTAL_COUNT )
		end,
		OnDeactivate = function()
			Fox.Log("quest_recv_child OnDeactivate")
			
		end,
		OnOutOfAcitveArea = function()
		end,
		OnTerminate = function()
			
			TppGimmick.OnTerminateMineQuest()
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
		Fox.Log("QStep_Start OnEnter")
		TppQuest.SetNextQuestStep( "QStep_Main" )
	end,
	OnLeave = function()
		Fox.Log("QStep_Start OnLeave")
	end,
}

quest_step.QStep_Main = {
	Messages = function( self )
		return
		StrCode32Table {
			Player = {
				{	
					msg = "OnPickUpPlaced",
					func = function( playerGameObjectId, equipId, index, isPlayer )
						
						if TppGimmick.CheckQuestPlaced( equipId, index ) then
							TppQuest.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.CLEAR)
						end
					end
				},
			},
			Placed = {
				{	
					msg = "OnActivatePlaced",
					func = function( equipId, index )
						
						if TppGimmick.CheckQuestPlaced( equipId, index ) then
							TppQuest.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.CLEAR)
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

