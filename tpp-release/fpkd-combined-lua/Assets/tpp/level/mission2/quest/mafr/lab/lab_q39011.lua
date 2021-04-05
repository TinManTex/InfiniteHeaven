local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId







this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.ANIMAL_RECOVERED,
	
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
	
	animalList = {
		
		{
			birdList	= {
							{
								name		= "anml_quest_00",
								birdType	= "TppStork",
								center		= { 2690.83100000, 168.65870000, -2168.63300000 },
								radius		= 30.000000000000,
								height		= 25.0,
								ground		= { 2716.011, 147.015, -2200.431 },
							},
						},
		}
	},
	
	targetList = {
		nil
	},
	
	targetAnimalList = {
		markerList = {
			"anml_quest_00",
		},
		dataBaseIdList = {
			TppAnimal.AnimalIdTable[ TppAnimal.AnimalExtraId.UNIQUE_ANIMAL_03 ],
		},
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
			
			TppAnimal.OnActivateQuest( this.QUEST_TABLE )
		end,
		OnDeactivate = function()
			Fox.Log("quest_recv_child OnDeactivate")
			
			TppEnemy.OnDeactivateQuest( this.QUEST_TABLE )
			
			TppAnimal.OnDeactivateQuest( this.QUEST_TABLE )
		end,
		OnOutOfAcitveArea = function()
		end,
		OnTerminate = function()
			TppUiCommand.UnRegisterIconUniqueInformation( GameObject.GetGameObjectId("anml_quest_00") )
			
			TppEnemy.OnTerminateQuest( this.QUEST_TABLE )
			
			TppAnimal.OnTerminateQuest( this.QUEST_TABLE )
		end,
	}
	
	mvars.fultonClearType = 0
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
		TppUiCommand.RegisterIconUniqueInformation{ markerId = GameObject.GetGameObjectId("anml_quest_00"), langId = "anml_bird_2250" }	
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
					func = function( gameObjectId, gameObjectId01, animalId )
						local isClearType = TppAnimal.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Dead", gameObjectId, animalId )
						TppQuest.ClearWithSave( isClearType )
					end
				},
				{	
					msg = "Fulton",
					func = function( gameObjectId, animalId )
						mvars.fultonClearType = TppAnimal.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Fulton", gameObjectId, animalId )
					end
				},
				{	
					msg = "FultonInfo",
					func = function( gameObjectId, animalId )
						if mvars.fultonClearType ~= 0 then
							TppQuest.ClearWithSave( mvars.fultonClearType )
						end
					end
				},
				{	
					msg = "FultonFailed",
					func = function( gameObjectId, locatorName, locatorNameUpper, failureType )
						local isClearType = TppAnimal.CheckQuestAllTarget( this.QUEST_TABLE.questType, "FultonFailed", gameObjectId, locatorName )
						TppQuest.ClearWithSave( isClearType )
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
