local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId






local GIMMICK_CNTN_NAME		= "gntn_cntn001_vrtn001_gim_n0000|srt_gntn_cntn001_vrtn001"
local GIMMICK_CNTN_PATH		= "/Assets/tpp/level/mission2/quest/mafr/outland/outland_q40010.fox2"


this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.GIMMICK_RECOVERED,
	
	cpList = {
		{
			cpName = "quest_cp",
			cpPosition_x = 222.904, cpPosition_y = 20.496, cpPosition_z = -932.784, cpPosition_r = 20.0,
			isOuterBaseCp = true,
			gtName = "gt_quest_0000",
			gtPosition_x = 222.904, cpPosition_y = 20.496, cpPosition_z = -932.784, gtPosition_r = 20.0,
		},
	},
	
	enemyList = {
		{
			enemyName = "sol_quest_0000",
			route_d = "rt_quest_d_0000", 	route_c = "rt_quest_c_0000",
			soldierSubType = "PF_C",
			powerSetting = { },
		},
		{
			enemyName = "sol_quest_0001",
			route_d = "rt_quest_d_0001", 	route_c = "rt_quest_c_0000",
			soldierSubType = "PF_C",
			powerSetting = { },
		},
		{
			enemyName = "sol_quest_0002",
			route_d = "rt_quest_d_0002", 	route_c = "rt_quest_c_0001",
			soldierSubType = "PF_C",
			powerSetting = { },
		},
	},
	
	vehicleList = {
		nil
	},
	
	hostageList = {
		nil
	},
	
	targetList = {
		nil
	},
	
	containerList = {
		{
			locatorName = GIMMICK_CNTN_NAME,
			dataSetName = GIMMICK_CNTN_PATH,
		},
	},
	
	targetGimmicklList = {
		"q40010_cntn001"
	},
}




function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		"QStep_Main",
		nil
	}

	TppGimmick.OnAllocateQuest( this.QUEST_TABLE )

	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = function()
			Fox.Log("quest_recv_child OnActivate")
			
			TppEnemy.OnActivateQuest( this.QUEST_TABLE )
			
			TppGimmick.OnActivateQuest( this.QUEST_TABLE )
		end,
		OnDeactivate = function()
			Fox.Log("quest_recv_child OnDeactivate")
			
			TppEnemy.OnDeactivateQuest( this.QUEST_TABLE )
		end,
		OnOutOfAcitveArea = function()
		end,
		OnTerminate = function()
			
			TppEnemy.OnTerminateQuest( this.QUEST_TABLE )
			
			TppGimmick.OnTerminateQuest( this.QUEST_TABLE )
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
		UI = {
			{
				msg = "QuestAreaAnnounceText",
				func = function( questId )
					
					if Player.GetItemLevel( TppEquip.EQP_IT_Fulton_Cargo ) >= 2 then
						Fox.Log("**** Fulton_Cargo is developed ****")
					elseif Player.GetItemLevel( TppEquip.EQP_IT_Fulton_WormHole ) >= 1 then
						Fox.Log("**** Fulton_WormHole is developed ****")
					else
						TppRadio.Play( "f1000_rtrg0531", { delayTime = "short" } )
					end
				end,
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
		
		Gimmick.ResetGimmick( TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER,	GIMMICK_CNTN_NAME, GIMMICK_CNTN_PATH )

		
		local getFlag, gameObjectId = Gimmick.GetGameObjectId( TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER, GIMMICK_CNTN_NAME, GIMMICK_CNTN_PATH )
		if getFlag then
			TppPlayer.SetForceFultonPercent( gameObjectId, 100 )
		end

		
		this.SetQuestContainerFova()
		TppQuest.SetNextQuestStep( "QStep_Main" )
	end,
}

quest_step.QStep_Main = {

	Messages = function( self )
		return
		StrCode32Table {
			GameObject = {
				{
					
					msg = "FultonInfo",
					func = function ( s_gameObjectId, containerName )
						if this.QUEST_TABLE.questType == TppDefine.QUEST_TYPE.GIMMICK_RECOVERED then
							if mvars.fultonInfo ~= TppDefine.QUEST_CLEAR_TYPE.NONE then
								TppQuest.ClearWithSave( mvars.fultonInfo )
							end
							mvars.fultonInfo = TppDefine.QUEST_CLEAR_TYPE.NONE
						end
					end
				},
				{	
					msg = "Fulton",
					func = function ( s_gameObjectId, containerName )
						local isClearType = TppGimmick.CheckQuestAllTarget(  this.QUEST_TABLE.questType, s_gameObjectId )
						mvars.fultonInfo = isClearType
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




function this.SetQuestContainerFova()

	Fox.Log("**** q40010.SetQuestContainerFova ****")
	Gimmick.SetFultonableContainerForMission( GIMMICK_CNTN_NAME,GIMMICK_CNTN_PATH,1,false )

end


return this
