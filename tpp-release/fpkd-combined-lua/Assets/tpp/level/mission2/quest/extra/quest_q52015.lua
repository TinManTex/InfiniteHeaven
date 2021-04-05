local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId









this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.ELIMINATE,
	
	cpList = {
		{
			cpName = "quest_cp",
			cpPosition_x = -1626.333, cpPosition_y = 353.561, cpPosition_z = -285.074, cpPosition_r = 30.0,
			isOuterBaseCp = true,
			gtName = "gt_quest_0000",
			gtPosition_x = -1626.333, gtPosition_y = 353.561, gtPosition_z = -285.074, gtPosition_r = 30.0,
		},
	},
	
	enemyList = {
		{
			enemyName = "sol_quest_0000",
			route_d = "rt_quest_d_0000", 	route_c = "rt_quest_d_0000",
			powerSetting = { },
			rideFromVehicleId = "vehicle_quest_0000",
		},
		{
			enemyName = "sol_quest_0001",
			route_d = "rt_quest_d_0001", 	route_c = "rt_quest_d_0001",
			powerSetting = {},
		},
		{
			enemyName = "sol_quest_0002",
			route_d = "rt_quest_d_0002", 	route_c = "rt_quest_d_0002",
			powerSetting = {},
		},
		{
			enemyName = "sol_quest_0003",
			route_d = "rt_quest_d_0001", 	route_c = "rt_quest_d_0001",
			powerSetting = { "SHOTGUN" },
		},
		{
			enemyName = "sol_quest_0004",
			route_d = "rt_quest_d_0002", 	route_c = "rt_quest_d_0002",
			powerSetting = { "SHOTGUN" },
		},
	},
	
	heliList = {
		{
			routeName		= "rt_heli_quest_spawn",
		},
	},
	
	vehicleList = {
		{	
			id		= "Spawn",
			locator = "vehicle_quest_0000",
			type	= Vehicle.type.EASTERN_TRACKED_TANK,
		},
	},
	
	hostageList = {
		nil
	},
	
	targetList = {
		TppReinforceBlock.REINFORCE_HELI_NAME,
		"vehicle_quest_0000",
		"sol_quest_0001",
		"sol_quest_0002",
		"sol_quest_0003",
		"sol_quest_0004",
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
	
	mvars.fultonInfo = TppDefine.QUEST_CLEAR_TYPE.NONE

	mvars.isHeliStart = false

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
					msg = "RoutePoint2",
					func = function (gameObjectId, routeId ,routeNode, messageId )
						if messageId == StrCode32("msg_questHeli_routeChange") then
							Fox.Log("*** " .. tostring(gameObjectId) .. " ::RouteChangeGameObjectId ***")
							this.SetHeliRoute( "rt_heli_quest_0000", true )
						end
					end
				},
				{	
					msg = "Dead",
					func = function( gameObjectId )
						local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Dead", gameObjectId )
						
						if gameObjectId ~= GetGameObjectId("sol_quest_0000") then
							TppQuest.ClearWithSave( isClearType )
						end
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
					msg = "VehicleBroken",
					func = function( gameObjectId, state )
						if state == StrCode32("End") then
							local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "VehicleBroken", gameObjectId )
							TppQuest.ClearWithSave( isClearType )
						end
					end
				},
				{	
					msg = "LostControl",
					func = function( gameObjectId, state )
						if state == StrCode32("End") then
							local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "LostControl", gameObjectId )
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
					sender = "trap_q52015_enable_heli",
					func = function()
						if mvars.isHeliStart == false then
							mvars.isHeliStart = true
							this.HeliStart()
						else
							this.SetHeliRoute( "rt_quest_heli_d_0000", false )
						end
					end
				},
				{	
					msg = "Exit",
					sender = "trap_q52015_enable_heli",
					func = function()
						if mvars.isHeliStart == true then
							this.SetHeliRoute( "rt_quest_heli_d_0000", true )
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




function this.HeliStart()
	local gameObjectId	= GameObject.GetGameObjectId("EnemyHeli" )
	local heliBroken	= GameObject.SendCommand( gameObjectId, { id="IsBroken" } )
	
	if svars.ispowerPlantHeliDisable or heliBroken then
		GameObject.SendCommand(gameObjectId, { id="Recover" })
	end
	
	GameObject.SendCommand(gameObjectId, { id = "RequestRoute", route = "rt_quest_heli_d_0000" })
end

function this.SetHeliRoute( routeName, isEnabled )
	local gameObjectId	= GameObject.GetGameObjectId("EnemyHeli" )
	GameObject.SendCommand( gameObjectId, { id = "SetSneakRoute",	enabled = isEnabled, route = routeName } )
	GameObject.SendCommand( gameObjectId, { id = "SetCautionRoute",	enabled = isEnabled, route = routeName } )
	GameObject.SendCommand( gameObjectId, { id = "SetAlertRoute",	enabled = isEnabled, route = routeName } )
end

return this

