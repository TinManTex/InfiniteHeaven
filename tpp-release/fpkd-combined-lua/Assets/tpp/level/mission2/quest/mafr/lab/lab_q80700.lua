local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId







this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.MSF_RECOVERED,
	
	cpList = {
		nil
	},
	
	enemyList = {
		{ 
			enemyName			= "sol_quest_0000",
			route_d				= "rt_quest_d_0000", 	route_c = "rt_quest_d_0000",
			powerSetting		= { },
			isMsf				= true,
			isZombieUseRoute	= true,
			bodyId				= TppDefine.QUEST_BODY_ID_LIST.MSF_08,
			uniqueTypeId		= TppDefine.UNIQUE_STAFF_TYPE_ID.QUEST_MSF_08,
			soldierType			= EnemyType.TYPE_DD,
			voiceType			= "ene_c",
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

			
			this.SetEscapePoint()

			
			local gameObjectId = { type="TppSoldier2" } 
			local command = { id = "SetMsfCombatLevel", level = 7 }
			GameObject.SendCommand( gameObjectId, command )
		end,
		OnDeactivate = function()
			Fox.Log("quest_recv_child OnDeactivate")
			
			this.ClearEscapePoint()

			
			TppEnemy.OnDeactivateQuest( this.QUEST_TABLE )
		end,
		OnOutOfAcitveArea = function()
		end,
		OnTerminate = function()
			
			TppEnemy.OnTerminateQuest( this.QUEST_TABLE )
		end,
	}
	
	mvars.isPlaySaluteRadio = false
	mvars.isPlayChangeToEnableRadio = false
	
	mvars.fultonInfo = TppDefine.QUEST_CLEAR_TYPE.NONE
end


this.SetEscapePoint = function()
	local EscapeIdx = {
		DownTip		= 0,
		DownHut		= 1,
		DownTree	= 2,
		HillPlane	= 3,
		HillTip		= 4,
		HillTree	= 5,
	}
	
	local identifierName = "identifier_q80700_esc_pos"
	local downTipPos = Tpp.GetLocatorByTransform( identifierName, "down_tip" )
	local downHutPos = Tpp.GetLocatorByTransform( identifierName, "down_hut" )
	local downTreePos = Tpp.GetLocatorByTransform( identifierName, "down_tree" )
	local hillPlanePos = Tpp.GetLocatorByTransform( identifierName, "hill_plane" )
	local hillTipPos = Tpp.GetLocatorByTransform( identifierName, "hill_tip" )
	local hillTreePos = Tpp.GetLocatorByTransform( identifierName, "hill_tree" )

	local EscapePosList = {
		{ idx = EscapeIdx.DownTip,		pos = downTipPos,	link = { EscapeIdx.DownHut, EscapeIdx.DownTree } },
		{ idx = EscapeIdx.DownHut,		pos = downHutPos,	link = { EscapeIdx.DownTree, EscapeIdx.DownTip } },
		{ idx = EscapeIdx.DownTree,		pos = downTreePos,	link = { EscapeIdx.DownHut, EscapeIdx.DownTip, EscapeIdx.HillPlane } },
		{ idx = EscapeIdx.HillPlane,	pos = hillPlanePos,	link = { EscapeIdx.HillTip, EscapeIdx.HillTree, EscapeIdx.DownTree } },
		{ idx = EscapeIdx.HillTip,		pos = hillTipPos,	link = { EscapeIdx.HillPlane, EscapeIdx.HillTree } },
		{ idx = EscapeIdx.HillTree,		pos = hillTreePos,	link = { EscapeIdx.HillPlane, EscapeIdx.HillTip } },
	}
		
	local gameObjectId = { type="TppSoldier2" }
	local command = { id = "SetEscapePosition", posList = EscapePosList }
	GameObject.SendCommand( gameObjectId, command )
end

this.ClearEscapePoint = function()
	local gameObjectId = { type="TppSoldier2" }
	local command = { id = "ClearEscapePosition" }
	GameObject.SendCommand( gameObjectId, command )
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
			Marker = {
				{
					msg = "ChangeToEnable",
					func = function ( arg0, arg1, arg2, arg3 )
						Fox.Log("### Marker ChangeToEnable  ###"..arg0 )
						if arg0 == StrCode32("sol_quest_0000") and arg3 == StrCode32("Player") and mvars.isPlayChangeToEnableRadio == false then
							TppRadio.Play( "f1000_rtrg4111", { delayTime = "short", isEnqueue = true } )
							mvars.isPlayChangeToEnableRadio = true
						end
					end
				},
			},
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
					msg = "Vanished",
					func = function( gameObjectId )
						local isClearType = TppEnemy.CheckQuestAllTarget( this.QUEST_TABLE.questType, "Vanished", gameObjectId )
						TppQuest.ClearWithSave( isClearType )
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
					msg = "MsfSalute",
					func = function( gameObjectId, vehicleGameObjectId )
						if mvars.isPlaySaluteRadio == false then
							TppRadio.Play( "f1000_rtrg4101", { delayTime = "long", isEnqueue = true } )
							mvars.isPlaySaluteRadio = true
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
