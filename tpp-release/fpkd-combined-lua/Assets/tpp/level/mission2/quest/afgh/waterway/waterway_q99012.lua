local this = {}
local quest_step = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId






this.QUEST_TABLE = {
	
	questType = TppDefine.QUEST_TYPE.STORY,
	
	cpList = {
		nil
	},
	
	enemyList = {
		{
			enemyName = "sol_quest_0000",
			route_d = "rts_q99012_0000", 	route_c = "rts_q99012_c_0000",
			cpName = "afgh_waterwayEast_ob",
		},
		{
			enemyName = "sol_quest_0001",
			route_d = "rts_q99012_0001", 	route_c = "rts_q99012_c_0001",
			cpName = "afgh_waterwayEast_ob",
		},
		{
			enemyName = "sol_quest_0002",
			route_d = "rts_q99012_0002", 	route_c = "rts_q99012_c_0001",
			cpName = "afgh_waterwayEast_ob",
		},
		{
			enemyName = "sol_quest_0003",
			route_d = "rts_q99012_snp_0000", 	route_c = "rts_q99012_snp_0000",
			cpName = "afgh_waterwayEast_ob", 	powerSetting = { "SNIPER" },
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
}


this.InterCall_hostage_pos01 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : Quest InterCall_hostage_pos01")
	
	TppMarker.Enable( "q99012_HintMarker", 1, "moving", "all", 0, true, false )
	TppUiCommand.RegisterIconUniqueInformation{ markerId = GameObject.GetGameObjectId("q99012_HintMarker"), langId = "marker_info_mission_targetArea" }
	TppUI.ShowAnnounceLog("updateMap", nil, nil, 1 )
end


this.questCpInterrogation = {
	
	{ name = "enqt1000_101521", func = this.InterCall_hostage_pos01, },	
}




function this.OnAllocate()
	 TppQuest.RegisterQuestStepList{
		"QStep_Start",
		"QStep_Main",
		nil
	}

	TppQuest.RegisterQuestStepTable( quest_step )
	TppQuest.RegisterQuestSystemCallbacks{
		OnActivate = function()
			Fox.Log("quest:Lost_Quiet OnActivate")
			TppPlayer.AddTrapSettingForIntel{
				intelName			= "Intel_LostQuiet",
				trapName			= "trap_Intel_quest_LostQuiet",



				identifierName		= "q99012_GetIntelIdentifier",
				locatorName			= "GetIntel_quest_LostQuiet",
				gotFlagName			= "isOnGetIntel_LostQuiet",
			}
			
			TppEnemy.OnActivateQuest( this.QUEST_TABLE )
		end,
		OnDeactivate = function()
			Fox.Log("quest:Lost_Quiet OnDeactivate")
			
			TppEnemy.OnDeactivateQuest( this.QUEST_TABLE )
		end,
		OnOutOfAcitveArea = function()
			Fox.Log("quest:Lost_Quiet OnOutOfAcitveArea")
			
			TppEnemy.OnTerminateQuest( this.QUEST_TABLE )
		end,
		OnTerminate = function()
			Fox.Log("quest:Lost_Quiet OnTerminate")
			
			this.SwitchEnableQuestHighIntTable( false, "afgh_waterwayEast_ob", this.questCpInterrogation )
		end,
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
		this.SwitchEnableQuestHighIntTable( true, "afgh_waterwayEast_ob", this.questCpInterrogation )
		TppQuest.SetNextQuestStep( "QStep_Main" )
	end,
}

quest_step.QStep_Main = {
	Messages = function( self )
		return
		StrCode32Table {
			GameObject = {
			},

			Trap = {
				{
					msg = "Enter",
					sender = "trap_IntelMarker_quest_LostQuiet",
					func = function( )
						Fox.Log("############# ENTER TRAP : trap_IntelMarker_quest_LostQuiet#############")
						TppMarker.Enable("q99012_IntelMarker")
						TppMarker.Disable( "q99012_HintMarker" )
						this.SwitchEnableQuestHighIntTable( false, "afgh_waterwayEast_ob", this.questCpInterrogation ) 
						TppRadio.Play("f2000_rtrg2030", { delayTime = 1.5 })
					end
				},
				{
					msg = "Enter",
					sender = "trap_Intel_quest_LostQuiet",
					func = function( )
						TppPlayer.ShowIconForIntel( "Intel_LostQuiet", mvars.isGotIntel )
					end
				},
				{
					msg = "Exit",
					sender = "trap_Intel_quest_LostQuiet",
					func = function( )
						Fox.Log("############# EXIT TRAP : trap_IntelMarker_quest_LostQuiet#############")
						TppPlayer.HideIconForIntel()
					end
				},
				{
					msg = "Enter",
					sender = "trap_q99012_Arrived",
					func = function( )
						Fox.Log("############# ENTER TRAP : trap_q99012_Arrived#############")
						TppRadio.Play("f2000_rtrg2020")
					end
				},
			},
			Player = {
				{
					msg = "GetIntel",
					sender = "Intel_LostQuiet",
					func = function( intelNameHash )
						TppPlayer.GotIntel( intelNameHash )
						TppDemo.PlayGetIntelDemo({ onEnd = function() this.MissionClear() end,},"q99012_GetIntelIdentifier","GetIntel_quest_LostQuiet")
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


this.MissionClear = function()
	
	TppTerminal.ReserveHelicopterSoundOnMissionGameEnd()
	TppMission.ReserveMissionClear{
		missionClearType = TppDefine.MISSION_CLEAR_TYPE.QUEST_LOST_QUIET_END,
		nextMissionId = 10260
	}
end




this.SwitchEnableQuestHighIntTable = function( flag, commandPostName, questCpInterrogation )

	local commandPostId = GameObject.GetGameObjectId( "TppCommandPost2" , commandPostName )

	if flag then
		
		TppInterrogation.SetQuestHighIntTable( commandPostId, questCpInterrogation )
	else
		
		TppInterrogation.RemoveQuestHighIntTable( commandPostId, questCpInterrogation )
	end

end

return this
