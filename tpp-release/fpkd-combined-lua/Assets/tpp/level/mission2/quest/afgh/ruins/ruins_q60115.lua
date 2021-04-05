local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId






this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.DEVELOP_RECOVERED,
	
	cpList = {
		nil
		






	},
	
	enemyList = {
		{ 
			setCp = "afgh_village_cp",
			isDisable = true,
		},
		{
			enemyName = "sol_quest_0000",
			route_d = "rt_quest_d_0000", 	route_c = "rt_quest_d_0000",
			cpName	= "afgh_village_cp",
			powerSetting = { },
		},
		{
			enemyName = "sol_quest_0001",
			route_d = "rt_quest_d_0001", 	route_c = "rt_quest_d_0001",
			cpName	= "afgh_village_cp",
			powerSetting = { },
		},
		{
			enemyName = "sol_quest_0003",
			route_d = "rt_quest_d_0003", 	route_c = "rt_quest_d_0003",
			cpName	= "afgh_village_cp",
			powerSetting = { },
		},
		{
			enemyName = "sol_quest_0004",
			route_d = "rt_quest_d_0004", 	route_c = "rt_quest_d_0004",
			cpName	= "afgh_village_cp",
			powerSetting = { },
		},
		{
			enemyName = "sol_quest_0005",
			route_d = "rt_quest_d_0005", 	route_c = "rt_quest_d_0005",
			cpName	= "afgh_village_cp",
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
	
	targetDevelopList = {
		"col_develop_q60115"
	},
}


this.SetNoTipsGuide = function( isSet )
	local currentMissionCode = vars.missionCode
	for tipsName, index in pairs( TppDefine.TIPS ) do
		TppTutorial.SetIgnoredGuideInMission( currentMissionCode, tipsName, isSet )
	end
	TppTutorial.SetIgnoredGuideInMission( currentMissionCode, "HOLD_UP_INTERROGATION", false )
	TppTutorial.SetIgnoredGuideInMission( currentMissionCode, "CQC_INTERROGATION", false )
	TppTutorial.SetIgnoredGuideInMission( currentMissionCode, "HOLD_UP", false )
end




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
			
			TppGimmick.OnActivateQuest( this.QUEST_TABLE )
			
			TppEnemy.OnActivateQuest( this.QUEST_TABLE )
			
			this.SetNoTipsGuide( true )
		end,
		OnDeactivate = function()
			Fox.Log("quest_recv_child OnDeactivate")
			
			TppEnemy.OnDeactivateQuest( this.QUEST_TABLE )
		end,
		OnOutOfAcitveArea = function()
		end,
		OnTerminate = function()
			
			TppGimmick.OnTerminateQuest( this.QUEST_TABLE )
			
			TppEnemy.OnTerminateQuest( this.QUEST_TABLE )
			
			this.SetNoTipsGuide( false )
		end,
	}
	
	mvars.HOLD_UP		= false 
	mvars.HOLD_UP_TIPS	= false 
	mvars.isEndQuestStartRadio = false 
end




this.Messages = function()
	return
	StrCode32Table {
		GameObject = {
			{	
				msg = "Holdup",
				func = function( gameObjectId )
					if ( mvars.HOLD_UP_TIPS == false ) then
						
						this.ShowConstantTips( "HOLD_UP_INTERROGATION" )
						mvars.HOLD_UP = true
						mvars.HOLD_UP_TIPS = true
					else
					end
				end
			},
		},
		Block = {
			{
				msg = "StageBlockCurrentSmallBlockIndexUpdated",
				func = function() end,
			},
		},
		Radio = {
			{	
				msg = "Start",
				sender = "f1000_rtrg0611",
				func = function ()
					Fox.Log( "this.Messages Radio:Finish")
					
					
					this.ShowConstantTips( "CQC_INTERROGATION" )
				end
			},
		},
		Trap = {
			{	
				msg = "Enter",
				sender = "Trap_HOLD_UP_Tips",
				func = function()
					Fox.Log( "ruins_q60115.Messages(): msg:Trap Enter")
					if ( TppEnemy.GetPhase("afgh_village_cp") > TppEnemy.PHASE.SNEAK or mvars.HOLD_UP == true ) then
						Fox.Log( "ruins_q60115.Messages(): msg:NoGuideHOLD_UP")
					else
						
						this.ShowConstantTips( "HOLD_UP" )
						
						mvars.HOLD_UP = true
					end
				end
			},
		},
		UI = {
			{
				msg = "QuestAreaAnnounceLog",
				func = function( questId )
					if ( mvars.isEndQuestStartRadio == false ) then
					TppRadio.Play( "f1000_rtrg0611", { isEnqueue = true, delayTime = "mid", priority = "strong" } )
					mvars.isEndQuestStartRadio = true
					else
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

function this.ShowConstantTips( contentName )
	if type(contentName) ~= "string" then
		Fox.Error("TppUI.ShowTipsGuide: contentName is not string. return")
		return
	end
	
	local tipsIdIndex = TppDefine.TIPS[contentName]

	if tipsIdIndex == nil then
		Fox.Error("TppUI.ShowTipsGuide: tipsId is nil. return. contentName is " .. tostring(contentName) )
		return
	end
	
	local tipsId = nil
	local tipsRedRef = TppDefine.TIPS_REDUNDANT_REF[tipsIdIndex]
	if not tipsRedRef then
		tipsId = tostring( tipsIdIndex )
	else
		tipsId = tostring( tipsRedRef )
	end

	if tipsId == nil then
		Fox.Error("TppUI.ShowTipsGuide: tipsId is nil. return. contentName is " .. tostring(contentName) )
		return
	end
	
	
	TppUiCommand.EnableTips( tipsId, true )

	TppUiCommand.SetButtonGuideDispTime( TppTutorial.DISPLAY_TIME.DEFAULT )	

	TppUiCommand.DispTipsGuide( tipsId )	
	TppUiCommand.SeekTips( tipsId )			
end









quest_step.QStep_Start = {
	OnEnter = function()
		TppQuest.SetNextQuestStep( "QStep_Main" )
	end,
}

this.OnClearQuest = function( playerGameObjectId, collectionUniqueId, collectionTypeId )
	if this.QUEST_TABLE.questType == TppDefine.QUEST_TYPE.DEVELOP_RECOVERED then
		local isClearType = TppGimmick.CheckQuestAllTarget( this.QUEST_TABLE.questType, collectionUniqueId )
		TppQuest.ClearWithSave( isClearType )
		
		this.SetNoTipsGuide( false )
	end
end

quest_step.QStep_Main = {
	
	Messages = function( self )
		return
		StrCode32Table {
			Player = {
				{	
				 	msg = "OnPickUpCollection",
					func = this.OnClearQuest
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
