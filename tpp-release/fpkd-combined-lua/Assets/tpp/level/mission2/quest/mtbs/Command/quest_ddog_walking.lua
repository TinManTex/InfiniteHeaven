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
	Fox.Log("quest_ddog_walking activate")
	if TppBuddyService.CheckBuddyCommonFlag( BuddyCommonFlag.BUDDY_RIDE_HELI ) then
		if vars.buddyType == BuddyType.DOG then
			TppBuddy2BlockController.ReserveCallBuddy(BuddyType.DOG,BuddyInitStatus.RIDE,Vector3( 0, 0, 0 ), 0.0 )		
			TppBuddy2BlockController.Load()
		end
	else
		TppBuddy2BlockController.ReserveCallBuddy(BuddyType.DOG,BuddyInitStatus.NORMAL,Vector3( 7.180, 0.000, 12.592 ), 1.36)
		TppBuddy2BlockController.Load()
	end
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









this.TIMER_LIST = {
	BUDDYDOG_SETUP = { timerName = "TimerBuddyDogSetup", time = 0.1, },
}

quest_step.QStep_Start = {

	Messages = function( self )
		return
		StrCode32Table {
			Timer = {
				{
					msg = "Finish",
					sender = this.TIMER_LIST.BUDDYDOG_SETUP.timerName,
					func = function()
						local gameObjectId = { type = "TppBuddyDog2", index = 0 }
						if GameObject.GetGameObjectIdByIndex( "TppBuddyDog2", 0 ) == NULL_ID then
							this.SetTimer{ timerList = this.TIMER_LIST.BUDDYDOG_SETUP }
						else
							GameObject.SendCommand( gameObjectId, { id = "SetMotherBaseCenterAndRadius", center = Vector3( 0, 0, 0 ), radius = 45.0 } )
						end
					end
				},
			},
		}
	end,
	
	OnEnter = function()
		this.SetTimer{ timerList = this.TIMER_LIST.BUDDYDOG_SETUP }
		TppQuest.ClearWithSaveMtbsDDQuest()
	end,
	
	OnLeave = function()
	end,
}






function this.SetTimer( params )
	local timerName
	local time
	local stop
	if params.timerList then
		timerName	= params.timerList.timerName or nil
		time		= params.timerList.time or nil
		stop		= params.timerList.stop or false
	else
		timerName	= params.timerName or nil
		time		= params.time or nil
		stop		= params.stop or false
	end
	if stop == true then
		GkEventTimerManager.Stop( timerName )
	end
	if timerName == nil or time == nil then
		return
	end
	if not GkEventTimerManager.IsTimerActive( timerName ) then
		GkEventTimerManager.Start( timerName, time )
	end
end


return this