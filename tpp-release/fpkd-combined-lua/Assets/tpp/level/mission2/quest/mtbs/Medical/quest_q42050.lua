local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId

local START_TRAP_NAME = "ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|trap_shootingPractice_start"
local QUIET_ROOM_TRAP_NAME = "mtbs_uq0040_plnt0000|uq_00400000|uq_0040_asset|QuietAudioTelopAreaTrap"








this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.SHOOTING_PRACTIVE,
	
	gimmickMarkList = {
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0000|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0001|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0002|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0003|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0004|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0005|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0006|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0007|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0008|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0009|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0010|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0011|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0012|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0013|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0014|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0015|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0016|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0017|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0018|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0019|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0020|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0021|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0022|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0023|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0024|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0025|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0026|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0027|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0028|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0029|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0030|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0031|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0032|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0033|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
		{
			locatorName = "mtbs_bord001_vrtn003_ev_gim_n0034|srt_mtbs_bord001_vrtn003_ev",
			dataSetName = "/Assets/tpp/level/mission2/quest/mtbs/Medical/quest_q42050.fox2",
			setIndex	= 0,
		},
	},
	
	gimmickTimerList = {
		displayTimeSec	= 60 * 5,
		cautionTimeSec	= 60 * 1,
	},
	
	gimmickOffsetType = "Medical",
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
			
			local startUiPosition = { -6.549169,0.01,7.193749 }	
			TppQuest.ShowShootingPracticeStartUi( this.QUEST_TABLE.gimmickOffsetType, startUiPosition )
			
			mvars.isShootingPracticeQuestActivated = true
			
			mvars.shootingPracticeClearTypeInMedical = nil
		end,
		OnDeactivate = function()
			Fox.Log("Quest Shooting Practice OnDeactivate")
			
			TppGimmick.OnDeactivateQuest( this.QUEST_TABLE )
			TppQuest.OnDeactivate( this.QUEST_TABLE )
			
			mvars.isShootingPracticeQuestActivated = false
		end,
		OnOutOfAcitveArea = function()
			Fox.Log( "OnOutOfAcitveArea" )
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
					
					f30050_sequence.StopMusicFromQuietRoom()
					
					mvars.isShootingPracticeInMedicalStopMusicFromQuietRoom = true
					
					mvars.needToUpdateRankingInMedical = false
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
			},
			{ 
				msg = "Enter",
				sender = QUIET_ROOM_TRAP_NAME,
				func = function()
					if TppQuest.IsShootingPracticeActivated() == false then
						Fox.Log( "Quest Trap Enter: ShootingPractice is Deactivated. Return" )
						return
					end
					if TppQuest.IsShootingPracticeStarted() == false then
						TppQuest.HideShootingPracticeMarker()
					end
				end,
			},
			{
				msg = "Exit",
				sender = QUIET_ROOM_TRAP_NAME,
				func = function()
					
					if TppQuest.IsShootingPracticeActivated() == false then
						Fox.Log( "Quest Trap Enter: ShootingPractice is Deactivated. Return" )
						return
					end
					
					if TppQuest.IsShootingPracticeStarted() then return end
					
					if mvars.shootingPracticeClearTypeInMedical == TppDefine.QUEST_CLEAR_TYPE.SHOOTING_CLEAR then
						Fox.Log( "Quest Trap Enter: ShootingPractice is already cleared. Return" )
						return
					end
					
					TppQuest.ShowShootingPracticeMarker()
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
	
	this.UpdateRankingInMedical()
end

function this.OnTerminate()
	TppQuest.QuestBlockOnTerminate( this )
end








function this.UpdateRankingInMedical()
	
	if mvars.needToUpdateRankingInMedical == true then
		
		local leftTime = TppUiCommand.GetLeftTimeFromDisplayTimer()
		if leftTime > 0 then
			local questName = TppQuest.GetCurrentQuestName()
			TppRanking.UpdateShootingPracticeClearTime( questName, leftTime )
			
			mvars.needToUpdateRankingInMedical = false
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
						mvars.shootingPracticeClearTypeInMedical = isClearType

						
						if isClearType == TppDefine.QUEST_CLEAR_TYPE.SHOOTING_CLEAR then
							mvars.needToUpdateRankingInMedical = true
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
