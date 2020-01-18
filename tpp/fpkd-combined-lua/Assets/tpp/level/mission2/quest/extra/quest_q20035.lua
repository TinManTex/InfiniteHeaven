local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId









local TARGET_HOSTAGE_NAME = "hos_quest_0000"


this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.RECOVERED,
	
	cpList = {
		{
			cpName = "quest_cp",
			cpPosition_x = 1471.075, cpPosition_y = 336.987, cpPosition_z = 1469.439, cpPosition_r = 70.0,
			isOuterBaseCp = true,
			gtName = "gt_quest_0000",
			gtPosition_x = 1471.075, cpPosition_y = 336.987, cpPosition_z = 1469.439, cpPosition_r = 70.0,
		},
	},
	
	enemyList = {
		{
			enemyName = "sol_quest_0000",
			route_d = "rt_quest_d_0002", 	route_c = "rt_quest_c_0000",
		},
		{
			enemyName = "sol_quest_0001",
			route_d = "rt_quest_d_0001", 	route_c = "rt_quest_c_0001",
		},




		{
			enemyName = "sol_quest_0003",
			route_d = "rt_quest_d_0003", 	route_c = "rt_quest_c_0003",
			powerSetting = { "SNIPER", }
		},
		{
			enemyName = "sol_quest_0004",
			route_d = "rt_quest_d_0000", 	route_c = "rt_quest_c_0000",
			powerSetting = { "RADIO", }
		},
		{
			enemyName = "sol_quest_0005",
			route_d = "rt_quest_d_0002", 	route_c = "rt_quest_c_0001",
			powerSetting = { "RADIO", }
		},
	},
	
	vehicleList = {
		nil
	},
	
	hostageList = {
		{
			hostageName		= TARGET_HOSTAGE_NAME,
			isFaceRandom	= true,
			voiceType		= { "hostage_a", "hostage_b", },
			langType		= "pashto",
			bodyId			= TppDefine.QUEST_BODY_ID_LIST.AFGH_HOSTAGE_MALE,
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
		hostageType		= "NoStand",
	}

	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = function()
			Fox.Log("quest_recv_child OnActivate")
			
			TppEnemy.OnActivateQuest( this.QUEST_TABLE )
			
			local gameObjectId = GameObject.GetGameObjectId("TppHostageUnique", TARGET_HOSTAGE_NAME )
			local command = {	id = "SetHostage2Flag", flag = "unlocked",	on = true, }
			GameObject.SendCommand( gameObjectId, command )
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
						if mvars.fultonInfo ~= TppDefine.QUEST_CLEAR_TYPE.NONE then
							TppQuest.ClearWithSave( mvars.fultonInfo )
						end
						mvars.fultonInfo = TppDefine.QUEST_CLEAR_TYPE.NONE
					end
				},
				{	
					msg = "Fulton",
					func = function( gameObjectId )
						local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Fulton", gameObjectId )
						mvars.fultonInfo = isClearType
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

