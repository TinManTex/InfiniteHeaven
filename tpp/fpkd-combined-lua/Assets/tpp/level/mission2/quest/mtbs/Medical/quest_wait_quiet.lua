local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_IDdem




function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		nil
	}
	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = this.OnActivate,
		OnDeactivate = function()
			Fox.Log("quest_wait_quiet OnDeactivate")
		end,
		OnOutOfAcitveArea = function()
		end,
		OnTerminate = function()
			Fox.Log("quest_wait_quiet OnTerminate")
		end,
	}
end



















function this.OnActivate()
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
				{
					msg = "Enter",
					sender = "mtbs_uq0040_plnt0000|uq_00400000|uq_0040_path0000|trap_toQuietPrison",
					func = function()
						GameObject.SendCommand( { type="TppMbQuiet", index=0 }, { id="StartWakeUp", isLoop=true, isAll=false } )
					end,
				},
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

return this