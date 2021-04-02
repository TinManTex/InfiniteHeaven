local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId

local START_TRAP_NAME = "ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|trap_shootingPractice_start"








this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.SHOOTING_PRACTIVE,
	
	gimmickMarkList = {
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0000|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0001|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0002|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0003|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0004|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0005|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0006|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0007|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0008|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0009|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0010|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0011|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0012|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0013|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0014|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0015|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0016|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0017|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0018|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0019|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0020|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0021|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0022|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0023|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0024|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0025|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0026|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0027|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0028|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0029|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0030|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0031|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0032|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0033|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0034|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Combat/quest_q42070.fox2",
			setIndex	= 0,
		},
	},
	
	gimmickTimerList = {
		displayTimeSec	= 60 * 5,
		cautionTimeSec	= 60 * 1,
	},
	
	gimmickOffsetType = "Combat",
}




function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		nil
	}
	
	
	TppGimmick.OnAllocateQuest( this.QUEST_TABLE )
	
	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = function()
			Fox.Log("Quest Shooting Practice OnActivate")
			
			TppGimmick.OnActivateQuest( this.QUEST_TABLE )
			
			local startUiPosition = { 7.09284,8.01,-9.4167 }	
			TppQuest.ShowShootingPracticeStartUi( this.QUEST_TABLE.gimmickOffsetType, startUiPosition )
			
			mvars.isShootingPracticeQuestActivated = true
		end,
		OnDeactivate = function()
			Fox.Log("Quest Shooting Practice OnDeactivate")
			
			TppGimmick.OnDeactivateQuest( this.QUEST_TABLE )
			TppQuest.OnDeactivate( this.QUEST_TABLE )
			
			mvars.isShootingPracticeQuestActivated = false
		end,
		OnOutOfAcitveArea = function()
		end,
		OnTerminate = function()
			Fox.Log("Quest Shooting Practice OnTerminate")
			
			TppGimmick.OnTerminateQuest( this.QUEST_TABLE )
		end,
	}
	
	
	TppPlayer.AddTrapSettingForQuest{
		questName	= "ShootingPractice",
		trapName	= START_TRAP_NAME,
	}
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
		Player = {
			{
				msg = "QuestStarted",
				sender = "ShootingPractice",
				func = function( questNameHash )
					Fox.Log( "QuestStarted" )
					TppPlayer.QuestStarted( questNameHash )
					
					TppQuest.SetQuestShootingPractice()
					
					mvars.needToUpdateRankingInCombat = false
				end
			},
			{	
				msg = "RideHelicopter",
				func = function( questNameHash )
					
					if TppQuest.IsShootingPracticeActivated() == false then
						Fox.Log( "Quest Trap Enter: ShootingPractice is Deactivated. Return" )
						return
					end
					
					if TppQuest.IsShootingPracticeStarted() then
						TppQuest.CancelShootingPractice()
					else
						TppQuest.HideShootingPracticeMarker()
					end
				end
			},
			{	
				msg = "LandingFromHeli",
				func = function( questNameHash )
					
					if TppQuest.IsShootingPracticeActivated() == false then
						Fox.Log( "Quest Trap Enter: ShootingPractice is Deactivated. Return" )
						return
					end
					
					if TppQuest.IsShootingPracticeStarted() then return end
					TppQuest.ShowShootingPracticeMarker()
				end
			},
		},
		Trap = {
			{
				msg = "Enter", sender = START_TRAP_NAME,
				func = function( trap, player )
					if TppQuest.IsShootingPracticeActivated() == false then
						Fox.Log( "Quest Trap Enter: ShootingPractice is Deactivated. Return" )
						return
					end
					TppPlayer.OnEnterQuestTrap( trap, player )
				end
			},
			{
				msg = "Exit", sender = START_TRAP_NAME,
				func = TppPlayer.OnExitQuestTrap
			}
		},
	}
end




function this.OnInitialize()
	TppQuest.QuestBlockOnInitialize( this )
end

function this.OnUpdate()
	TppQuest.QuestBlockOnUpdate( this )
	
	this.UpdateRankingInCombat()
end

function this.OnTerminate()
	TppQuest.QuestBlockOnTerminate( this )
end







function this.UpdateRankingInCombat()
	
	if mvars.needToUpdateRankingInCombat == true then
		
		local leftTime = TppUiCommand.GetLeftTimeFromDisplayTimer()
		if leftTime > 0 then
			local questName = TppQuest.GetCurrentQuestName()
			TppRanking.UpdateShootingPracticeClearTime( questName, leftTime )
			
			mvars.needToUpdateRankingInCombat = false
		end
	end
end





quest_step.QStep_Start = {
	
	Messages = function( self )
		return
		StrCode32Table {
			GameObject = {
				{	
					msg = "BreakGimmick",
					func = function( gameObjectId, locatorNameHash, dataSetNameHash )
						local isClearType = TppGimmick.CheckQuestAllTarget( this.QUEST_TABLE.questType, locatorNameHash )
						TppQuest.ClearWithSave( isClearType )
						
						
						if isClearType == TppDefine.QUEST_CLEAR_TYPE.SHOOTING_CLEAR then
							mvars.needToUpdateRankingInCombat = true
						end
					end
				},
				},
			UI = {
				{	
					msg = "DisplayTimerTimeUp",
					func = function()
						local isClearType = TppGimmick.CheckQuestAllTarget( this.QUEST_TABLE.questType, nil, true )
						TppQuest.ClearWithSave( isClearType )
					end
				},
			},
		}
	end,
	
	OnEnter = function()
		
	end,
}

return this
