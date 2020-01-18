local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_ID




function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
	
		nil
	}
	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = this.OnActivate,
		OnDeactivate = function()
			Fox.Log("quest_test OnDeactivate")
		end,
		OnOutOfAcitveArea = function()
			Fox.Log("quest_test OnOutOfAcitveArea")

			





		end,
		OnTerminate = function()
			Fox.Log("quest_test OnTerminate")
		end,
	}
end




function this.Messages()
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







function this.OnActivate()
	Fox.Log("quest_test activate")	
	
	local fv2Index = 0
	if TppBuddyService.IsBuddyDogGot() then
		fv2Index = 0
	elseif TppBuddyService.IsBuddyDogGot() then
		fv2Index = 1
	end
	local gameObjectId = { type = "TppBuddyPuppy", index = 0 }
	GameObject.SendCommand( gameObjectId, { id = "SetFova", fv2Index = fv2Index } )	
	GameObject.SendCommand( gameObjectId, { id = "SetFultonEnabled", enabled = false } )
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
			Trap = {
			},
		}
	end,

	OnEnter = function()
		Fox.Log("QStep_Start OnEnter")
		TppQuest.ClearWithSaveMtbsDDQuest()
	end,
	
	OnLeave = function()
		Fox.Log("QStep_Start OnLeave")
	end,
}

quest_step.QStep2 = {
	OnEnter = function()
		Fox.Log("QStep2 OnEnter")
	end,
}

return this