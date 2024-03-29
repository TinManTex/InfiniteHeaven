local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId







this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.ELIMINATE,
	
	isQuestZombie = true,
	
	isQuestArmor = true,
	
	cpList = {
		{
			cpName = "quest_cp",
			cpPosition_x = 782.651, cpPosition_y = 463.722, cpPosition_z = -1027.080, cpPosition_r = 50.0,
			isOuterBaseCp = true,
			gtName = "gt_quest_0000",
			gtPosition_x = 782.651, cpPosition_y = 463.722, cpPosition_z = -1027.080, gtPosition_r = 50.0,
		},
	},
	
	enemyList = {
		
		{ 
			setCp = "afgh_cliffTown_cp",
			isDisable = true,
		},
		
		{ 
			enemyName = "sol_quest_0000",
			route_d = "rt_quest_d_0000", 	route_c = "rt_quest_d_0000",
			powerSetting = { "QUEST_ARMOR" },
			isZombie = true,
			isZombieUseRoute = true,
		},
		{ 
			enemyName = "sol_quest_0001",
			route_d = "rt_quest_d_0001", 	route_c = "rt_quest_d_0001",
			powerSetting = { "QUEST_ARMOR" },
			isZombie = true,
			isZombieUseRoute = true,
		},
		{ 
			enemyName = "sol_quest_0002",
			route_d = "rt_quest_d_0002", 	route_c = "rt_quest_d_0002",
			powerSetting = { "QUEST_ARMOR" },
			isZombie = true,
			isZombieUseRoute = true,
		},
		{ 
			enemyName = "sol_quest_0003",
			route_d = "rt_quest_d_0003", 	route_c = "rt_quest_d_0003",
			powerSetting = { "QUEST_ARMOR" },
			isZombie = true,
			isZombieUseRoute = true,
		},
		{ 
			enemyName = "sol_quest_0004",
			route_d = "rt_quest_d_0004", 	route_c = "rt_quest_d_0004",
			powerSetting = { "QUEST_ARMOR" },
			isZombie = true,
			isZombieUseRoute = true,
		},
		{ 
			enemyName = "sol_quest_0005",
			route_d = "rt_quest_d_0005", 	route_c = "rt_quest_d_0005",
			powerSetting = { "QUEST_ARMOR" },
			isZombie = true,
			isZombieUseRoute = true,
		},
		{ 
			enemyName = "sol_quest_0006",
			route_d = "rt_quest_d_0006", 	route_c = "rt_quest_d_0006",
			powerSetting = { "QUEST_ARMOR" },
			isZombie = true,
			isZombieUseRoute = true,
		},
		{ 
			enemyName = "sol_quest_0007",
			route_d = "rt_quest_d_0007", 	route_c = "rt_quest_d_0007",
			powerSetting = { "QUEST_ARMOR" },
			isZombie = true,
			isZombieUseRoute = true,
		},
	},
	
	vehicleList = {
		nil
	},
	
	hostageList = {
		nil
	},
	
	targetList = {
		"sol_quest_0000",
		"sol_quest_0001",
		"sol_quest_0002",
		"sol_quest_0003",
		"sol_quest_0004",
		"sol_quest_0005",
		"sol_quest_0006",
		"sol_quest_0007",
	},
}




function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		"QStep_Main",
		nil
	}
	
	
	TppEnemy.OnAllocateQuestFova( this.QUEST_TABLE )
	
	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = function()
			Fox.Log("quest_recv_child OnActivate")
			
			TppEnemy.OnActivateQuest( this.QUEST_TABLE )
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
	
	mvars.isMoveStart_0000 = false
	mvars.isMoveStart_0001 = false
	
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
			Trap = {
				{	
					msg = "Enter",
					sender = "trap_MoveStart_0000",
					func = function()
						if mvars.isMoveStart_0000 == false then
							mvars.isMoveStart_0000 = true
							TppEnemy.SetSneakRoute( "sol_quest_0005", "rt_quest_d_0005_0000" )
							TppEnemy.SetSneakRoute( "sol_quest_0006", "rt_quest_d_0006_0000" )
							TppEnemy.SetSneakRoute( "sol_quest_0007", "rt_quest_d_0007_0000" )
						end
					end,
				},
				{	
					msg = "Enter",
					sender = "trap_MoveStart_0001",
					func = function()
						if mvars.isMoveStart_0001 == false then
							mvars.isMoveStart_0001 = true
							TppEnemy.SetSneakRoute( "sol_quest_0002", "rt_quest_d_0002_0000" )
							TppEnemy.SetSneakRoute( "sol_quest_0003", "rt_quest_d_0003_0000" )
							TppEnemy.SetSneakRoute( "sol_quest_0004", "rt_quest_d_0004_0000" )
						end
					end,
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
