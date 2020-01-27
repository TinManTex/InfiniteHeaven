local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId







this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.RECOVERED,
	
	cpList = {
		nil
	},
	
	enemyList = {
		
		{ 
			setCp = "afgh_ruinsNorth_ob",
			isDisable = true,
		},
		
		{
			enemyName			= "sol_quest_0000",
			route_d				= "rt_quest_d_ene01_0000",	route_c = "rt_quest_c_ene01_0000",
			cpName				= "afgh_ruinsNorth_ob",
			powerSetting		= { },
			bodyId				= TppDefine.QUEST_BODY_ID_LIST.Q19010,
			faceId				= TppDefine.QUEST_FACE_ID_LIST.Q19010,
			uniqueTypeId		= TppDefine.UNIQUE_STAFF_TYPE_ID.S10043_INTERPRETER,
		},
		
		{
			enemyName			= "sol_quest_0001",
			route_d				= "rt_quest_d_ene02_0000",	route_c = "rt_quest_c_ene02_0000",
			cpName				= "afgh_ruinsNorth_ob",
			powerSetting		= { },
		},
		
		{
			enemyName			= "sol_quest_0002",
			route_d				= "rt_quest_d_ene03_0000",	route_c = "rt_quest_c_ene03_0000",
			cpName				= "afgh_ruinsNorth_ob",
			powerSetting		= { },
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
			
			TppInterrogation.AddQuestTable( this.uniqueInterrogation )
		end,
		OnDeactivate = function()
			Fox.Log("quest_recv_child OnDeactivate")
			
			TppEnemy.OnDeactivateQuest( this.QUEST_TABLE )
		end,
		OnOutOfAcitveArea = function()
			Fox.Log("quest_recv_child OnOutOfAcitveArea")
		end,
		OnTerminate = function()
			Fox.Log("quest_recv_child OnTerminate")
			
			TppEnemy.OnTerminateQuest( this.QUEST_TABLE )
			
			TppInterrogation.ResetQuestTable()
		end,
	}
	
	mvars.isConversationArea	= false
	mvars.isConversationStart	= false
	mvars.isPlayerInRuinsNorth	= false
	mvars.interrogationCount	= 0
	
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
		
		TppUiCommand.RegisterIconUniqueInformation{ markerId = GameObject.GetGameObjectId("sol_quest_0000"), langId = "marker_ene_translator" }
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
				{	
					msg = "ConversationEnd",
					func = function( cpGameObjectId, speechLabel, isSuccess )
						Fox.Log( "ruins_q19010.Messages(): msg:ConversationEnd")
						if speechLabel == StrCode32( "CT10043_01" ) and isSuccess ~= 0 then
							if mvars.isConversationArea == true then
								TppRadio.Play( "f1000_rtrg0960")
							end
						end
						this.SetRouteId{ beforeRouteId_d = "rt_quest_d_ene01_0000", afterRouteId_d = "rt_quest_d_ene01_0001", }
						this.SetRouteId{ beforeRouteId_d = "rt_quest_d_ene02_0001", afterRouteId_d = "rt_quest_d_ene02_0000", }
					end
				},
				{	
					msg = "RoutePoint2",
					func = function( gameObjectId, routeId, routeNodeIndex, messageId )
						Fox.Log( "ruins_q19010.Messages(): msg:RoutePoint2")
						if messageId == StrCode32("ConversationStart") then
							this.RouteCallConversation( { "rt_quest_d_ene02_0001" }, { "rt_quest_d_ene01_0000" }, "CT10043_01", true )
						end
					end
				},
			},
			Trap = {
				{	
					msg = "Enter",
					sender = "trap_q19010_ConversationStart",
					func = function()
						Fox.Log( "ruins_q19010.Messages(): msg:Trap Enter")
						if mvars.isConversationStart == false then
							mvars.isConversationStart = true
							this.SetRouteId{ beforeRouteId_d = "rt_quest_d_ene02_0000", afterRouteId_d = "rt_quest_d_ene02_0001", }
						end
					end
				},
				{	
					msg = "Enter",
					sender = "trap_q19010_ConversationArea",
					func = function()
						Fox.Log( "ruins_q19010.Messages(): msg:Trap Enter")
						mvars.isConversationArea = true
					end
				},
				{	
					msg = "Exit",
					sender = "trap_q19010_ConversationArea",
					func = function()
						Fox.Log( "ruins_q19010.Messages(): msg:Trap Exit")
						mvars.isConversationArea = false
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






function this.GetGameObjectIdUsingRoute( routeName )
	Fox.Log("*** GetGameObjectIdUsingRoute ***")
	local soldiers = GameObject.SendCommand( { type = "TppSoldier2" }, { id = "GetGameObjectIdUsingRoute", route = routeName } )
	return soldiers
end


function this.GetGameObjectIdUsingRouteTable( routeNameTable )
	Fox.Log("*** GetGameObjectIdUsingRouteTable ***")
	if not Tpp.IsTypeTable( routeNameTable ) then
		routeNameTable = { routeNameTable }
	end
	for i, routeName in ipairs( routeNameTable ) do
		local soldiers = this.GetGameObjectIdUsingRoute( routeName )
		for j, soldier in ipairs( soldiers ) do
			return soldier
		end
	end
	return nil
end


function this.SetRouteId( params )
	
	local gameObjectId	= this.GetGameObjectIdUsingRouteTable( params.beforeRouteId_d )
	
	if gameObjectId and params.afterRouteId_d then
		TppEnemy.SetSneakRoute( gameObjectId, params.afterRouteId_d )
	end
end






function this.RouteCallConversation( speakerRouteNameTable, friendRouteNameTable, speechLabel, isMonologue )
	
	local speakerGameObjectId	= this.GetGameObjectIdUsingRouteTable( speakerRouteNameTable )
	local friendGameObjectId	= this.GetGameObjectIdUsingRouteTable( friendRouteNameTable )
	if isMonologue == true then
		if speakerGameObjectId == nil then
			return
		end
		
		if friendGameObjectId == nil then
			friendGameObjectId = speakerGameObjectId
		end
	else
		if speakerGameObjectId == nil or friendGameObjectId == nil then
			return
		end
	end
	
	this.CallConversation( speakerGameObjectId, friendGameObjectId, speechLabel )
end


function this.CallConversation( speakerGameObjectId, friendGameObjectId, speechLabel )
	if Tpp.IsTypeString( speakerGameObjectId ) then
		speakerGameObjectId = GameObject.GetGameObjectId( speakerGameObjectId )
	end
	if Tpp.IsTypeString( friendGameObjectId ) then
		friendGameObjectId = GameObject.GetGameObjectId( friendGameObjectId )
	end
	local command = { id = "CallConversation", label = speechLabel, friend = friendGameObjectId, }
	GameObject.SendCommand( speakerGameObjectId, command )
end





this.UniqueInterStart_sol_interpreter_0000 = function( soldier2GameObjectId, cpID )
	
	if mvars.interrogationCount == 0 then
		TppInterrogation.QuestInterrogation( cpID, "enqt1000_1u1a10" )




	elseif mvars.interrogationCount == 1 then
		TppInterrogation.QuestInterrogation( cpID, "enqt1000_1w1a10" )
	else
		TppInterrogation.QuestInterrogation( cpID, "enqt1000_1x1a10" )
	end
	
	if mvars.interrogationCount < 4 then
		mvars.interrogationCount = mvars.interrogationCount+ 1
	end
	return true
end

this.UniqueInterEnd_sol_interpreter_0000 = function( soldier2GameObjectId, cpID )

end


this.uniqueInterrogation = {
	
	unique = {
		{ name = "enqt1000_1u1a10",				func = this.UniqueInterEnd_sol_interpreter_0000,},			

		{ name = "enqt1000_1w1a10",				func = this.UniqueInterEnd_sol_interpreter_0000,},			
		{ name = "enqt1000_1x1a10",				func = this.UniqueInterEnd_sol_interpreter_0000,},			
	},
	
	uniqueChara = {
		{ name = "sol_quest_0000",				func = this.UniqueInterStart_sol_interpreter_0000,},		
	},
}

return this