local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId







this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.ANIMAL_RECOVERED,
	
	cpList = {
		{
			cpName = "quest_cp",
			cpPosition_x = 516.352, cpPosition_y = 321.572, cpPosition_z = 1062.797, cpPosition_r = 30.0,
			isOuterBaseCp = true,
			gtName = "gt_quest_0000",
			gtPosition_x = 516.352, gtPosition_y = 321.572, gtPosition_z = 1062.797, gtPosition_r = 30.0,
		},
	},
	
	enemyList = {
		{
			enemyName = "sol_quest_0000",
			route_d = "rt_quest_d_0000", 	route_c = "rt_quest_d_0000",
			powerSetting = {},
		},
		{
			enemyName = "sol_quest_0001",
			route_d = "rt_quest_d_0001", 	route_c = "rt_quest_d_0001",
			powerSetting = {},
		},
	},
	
	vehicleList = {
		nil
	},
	
	hostageList = {
		nil
	},
	
	animalList = {
		
		{
			animalName		= "anml_quest_00",
			animalType		= "TppNubian",
			routeName		= "rt_anml_quest_00",
			animalId		= TppAnimal.AnimalExtraId.UNIQUE_ANIMAL_00,
			colorId			= TppAnimalFova.TYPE_COLOR_2,
			isNotice		= false,	
		}
	},
	
	targetList = {
		nil
	},
	
	targetAnimalList = {
		markerList = {
			"anml_quest_00",
		},
		animalIdList = {
			TppAnimal.AnimalExtraId.UNIQUE_ANIMAL_00,
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
			this.SetNoticeDistance( false )
			
			TppEnemy.OnDeactivateQuest( this.QUEST_TABLE )
			
			TppAnimal.OnDeactivateQuest( this.QUEST_TABLE )
		end,
		OnOutOfAcitveArea = function()
		end,
		OnTerminate = function()
			
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
		this.SetNoticeDistance( true )
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


function this.SetNoticeDistance( forceFlag )
	Fox.Log("**** field_q33010:SetNoticeDistance ****")
	local gameObjectId = { type = "TppNubian", index = 0 }
	local command = { id = "SetNoticeDistance", name = "anml_quest_00", distance = 2.0, isForce = forceFlag }
	GameObject.SendCommand( gameObjectId, command )
end

return this
