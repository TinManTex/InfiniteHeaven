InfCore.Log("q52130EXTERNAL")--DEBUGNOW
return InfCore.PCallDebug(function()--DEBUG
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
			cpPosition_x = -1854.596, cpPosition_y = 343.192, cpPosition_z = -299.520, cpPosition_r = 106.515,
			isOuterBaseCp = true,
			gtName = "gt_quest_0000",
			gtPosition_x = -1854.596, gtPosition_y = 343.192, gtPosition_z = -299.520, gtPosition_r = 106.515,
		},
	},
	
	enemyList = {
		{
			enemyName = "sol_quest_0000",
			--DEBUGNOW route_d = "rt_across_river_2story_bottom_hill_ruin", 	route_c = "rt_across_river_2story_bottom_hill_ruin",
		--	route_d = "rt_quest_d_0002",   route_c = "rt_quest_d_0002",
		--	route_d = "rt_quest_d_0003",   route_c = "rt_quest_d_0003",
			route_d = "rt_quest_d_0001",   route_c = "rt_quest_d_0001",
		--	route_d = "rt_bbb_test",   route_c = "rt_bbb_test",
	--	  route_d = "rt_quest_d_0001_0000",   route_c = "rt_quest_d_0001_0000",
	--	route_d = "rt_quest_d_0001",   route_c = "rt_quest_d_0001",
	--	route_d = "aaa_bbb_ccc_ddd_eee",   route_c = "aaa_bbb_ccc_ddd_eee",
	--	route_d = "zzz_fff_ggg_hhh",   route_c = "zzz_fff_ggg_hhh",

		--route_d = "rt_quest_d_0002",   route_c = "rt_quest_d_0002",
			powerSetting = { },
			--rideFromVehicleId = "vehicle_quest_0000",
		},
--		{
--			enemyName = "sol_quest_0001",
--			route_d = "rt_across_river_bank_patrol_near_wav", 	route_c = "rt_across_river_bank_patrol_near_wav",
--			powerSetting = { },
--			--rideFromVehicleId = "vehicle_quest_0001",
--		},
--		{
--			enemyName = "sol_quest_0002",
--			route_d = "rt_across_river_overcrop_to_2story_ruin", 	route_c = "rt_across_river_overcrop_to_2story_ruin",
--			powerSetting = { "SOFT_ARMOR", "HELMET", "SHIELD" },
--		},
--		{
--			enemyName = "sol_quest_0003",
--			route_d = "rt_around_bottom_hill_ruin", 	route_c = "rt_around_bottom_hill_ruin",
--			powerSetting = { "SOFT_ARMOR", "HELMET" },
--		},
--		{
--			enemyName = "sol_quest_0004",
--			route_d = "rt_broken_bridge_and_river", 	route_c = "rt_broken_bridge_and_river",
--			powerSetting = { "HELMET", "SOFT_ARMOR", "MISSILE" },
--		},
--		{
--			enemyName = "sol_quest_0005",
--			route_d = "rt_hill_top", 	route_c = "rt_hill_top",
--			powerSetting = { "SOFT_ARMOR", "HELMET", "SNIPER" },
--		},
--		{
--			enemyName = "sol_quest_0006",
--			route_d = "rt_river_ledge", 	route_c = "rt_river_ledge",
--			powerSetting = { "SOFT_ARMOR", "HELMET", "SNIPER" },
--		},
--		{
--			enemyName = "sol_quest_0007",
--			route_d = "rt_wav_river", 	route_c = "rt_wav_river",
--			--route_d = "rt_aim_test", 	route_c = "rt_aim_test",--DEBUGNOW
--			powerSetting = { "SOFT_ARMOR", "HELMET", "SNIPER" },
--			--rideFromVehicleId = "vehicle_quest_0000",--DEBUGNOW
--		},
	},
	
--	vehicleList = {
--		{	
--			id		= "Spawn",
--			locator = "vehicle_quest_0000",
--			type	= Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE,
--			
--			class	= Vehicle.class.DARK_GRAY,
--			priority = 1,
--
--			--DEBUGNOW warpPosition={pos={-1785.000,329.000,-256.000},rotY=0},
--		},
--		{	
--			id		= "Spawn",
--			locator = "vehicle_quest_0001",
--			type	= Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE,
--			subType = Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY,
--			class	= Vehicle.class.DARK_GRAY,
--			priority = 1,
--		},
--	},
	
	--[[
	heliList = {
		{
			routeName		= "rt_heli_quest_spawn",
			coloringType		= TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK, 
		},
	},
	--]]
	
	hostageList = {
		nil
	},
	
	targetList = {
		"vehicle_quest_0000",
		"vehicle_quest_0001",
		--"sol_quest_0002",
--		"sol_quest_0003",
--		"sol_quest_0004",
--		"sol_quest_0005",
--		"sol_quest_0006",
--		"sol_quest_0007",
		--TppReinforceBlock.REINFORCE_HELI_NAME,
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
		InfCore.PCall(this.WarpQuestObjects)--DEBUGNOW

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
						
						if gameObjectId ~= GetGameObjectId("sol_quest_0000") and gameObjectId ~= GetGameObjectId("sol_quest_0001") then
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
					msg = "PlacedIntoVehicle",
					func = function( gameObjectId, vehicleGameObjectId )
						if Tpp.IsHelicopter( vehicleGameObjectId ) then
							local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "InHelicopter", gameObjectId )
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

--DEBUGNOW
function this.WarpQuestObjects()
	InfCore.LogFlow("WarpQuestObjects")--DEBUGNOW
	local warpFuncs={
		vehicleList=InfMainTpp.WarpVehicle,
		hostageList=InfMainTpp.WarpHostage,
	}
	local objectNameKeys={
		vehicleList="locator",
		hostageList="hostagName",
	}

	for listName,objectList in pairs(this.QUEST_TABLE)do
		local WarpFunc=warpFuncs[listName]
		if WarpFunc then
			for i,objectInfo in ipairs(objectList)do
				if objectInfo.warpPosition then
					local objectName=objectInfo[objectNameKeys[listName]]
					WarpFunc(objectName,objectInfo.warpPosition.pos,objectInfo.warpPosition.rotY)
				end
			end
		end
	end
end

return this

end)--DEBUG