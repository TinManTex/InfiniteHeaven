
local this = {}



this.missionID = 20015
this.tmpChallengeString = 0			
this.tmpBestRank = 0				
this.startViewMode = "result"		



this.RequiredFiles = {
	"/Assets/tpp/script/common/TppCommon.lua",
}

this.Sequences = {
	
	{ "Seq_Mission_Prepare" },
	
	{ "Seq_Mission_Exec" },
	{ "Seq_Game_OpeningDemoLoad" },
	{ "Seq_Wait_EndTelop" },
	{ "Seq_Demo_PazOperate" },
	
	{ "Seq_Mission_Clear" },
	{ "Seq_MissionClear" },
	{ "Seq_MissionAbort" },
	{ "Seq_MissionFailed" },
	
	{ "Seq_EndRoll" },			
	{ "Seq_ShowClearReward" },	
	{ "Seq_MissionEnd" },
}


this.OnStart = function( manager )
	TppCommon.Register( this, manager )
	
	this.startViewMode = "result" 
end


this.ChangeExecSequenceList =  {
	"Seq_Demo_PazOperate",

}


this.ClearRankRewardList = {

	
	RankS = "Rank_S_Reward_Assault",
	RankA = "Rank_A_Reward_Sniper",
	RankB = "Rank_B_Reward_Missile",
	RankC = "Rank_C_Reward_SubmachinGun",
}

this.ClearRankRewardPopupList = {

	
	RankS = "reward_clear_s_rifle",
	RankA = "reward_clear_a_sniper",
	RankB = "reward_clear_b_rocket",
	RankC = "reward_clear_c_submachine",
}


local IsChangeExecSequence = function()
	local sequence = TppSequence.GetCurrentSequence()

	for i = 1, #this.ChangeExecSequenceList do
		if sequence == this.ChangeExecSequenceList[i] then
			return true
		end
	end
	return false
end


this.OnEnterCommon = function()
	local sequence = TppSequence.GetCurrentSequence()



	
	if IsChangeExecSequence() then
		TppMission.ChangeState( "exec" )
	end
end

this.OnLeaveCommon = function()
	local sequence = TppSequence.GetCurrentSequence()



end

























this.OnShowRewardPopupWindow = function()





	
	local hudCommonData = HudCommonDataManager.GetInstance()
	local challengeString = PlayRecord.GetOpenChallenge()

	
	local uiCommonData = UiCommonDataManager.GetInstance()
	local AllHardClear = PlayRecord.IsAllMissionClearHard()
	local count = TppStorage.GetXOFEmblemCount()	

	
	local clear_cnt = PlayRecord.GetMissionScore( 20010, "NORMAL", "CLEAR_COUNT" )

	local hardmode = TppGameSequence.GetGameFlag("hardmode") 
	local Rank = 0
	if ( hardmode ) then
		
		Rank = PlayRecord.GetMissionScore( 20010, "HARD", "BEST_RANK")
	else
		
		Rank = PlayRecord.GetMissionScore( 20010, "NORMAL", "BEST_RANK")
	end

	this.tmpBestRank = TppGameSequence.GetGameFlag("e20010_beforeBestRank")	

	
	local uiCommonData = UiCommonDataManager.GetInstance()
	uiCommonData:ShowAllCassetteTapes()

	
	local RewardAllCount = uiCommonData:GetRewardAllCount( 20010 )
	local tmpRewardCount = TppGameSequence.GetGameFlag("rewardNumOfMissionStart")	




	
	hudCommonData:SetBonusPopupCounter( tmpRewardCount, RewardAllCount )

	
	
	
	
	while ( challengeString ~= "" ) do



		
		hudCommonData:ShowBonusPopupCommon( challengeString )
		
		challengeString = PlayRecord.GetOpenChallenge()
	end
	
	
	
	
	while ( Rank < this.tmpBestRank ) do



		this.tmpBestRank = ( this.tmpBestRank - 1 )
		if ( this.tmpBestRank == 4 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankC , "WP_sm00_v00" , { isSup = true } )
		elseif ( this.tmpBestRank == 3 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankB , "WP_ms02" )
		elseif ( this.tmpBestRank == 2 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankA , "WP_sr01_v00" )
		elseif ( this.tmpBestRank == 1 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankS , "WP_ar00_v05" , { isBarrel = true })
		end
	end
	
	
	
	
	if uiCommonData:IsHaveCassetteTape( "tp_chico_03" ) then
		if ( PlayRecord.GetMissionScore( 20010, "NORMAL", "CLEAR_COUNT" ) == 1 and 	
			 PlayRecord.GetMissionScore( 20010, "HARD", "CLEAR_COUNT" ) == 0 ) then



			
			hudCommonData:ShowBonusPopupItemTape( "reward_get_tape_tp_chico_03" )
		end
	else
		
		hudCommonData:ShowBonusPopupItemTape( "reward_get_tape_tp_chico_03" )

		
		uiCommonData:GetBriefingCassetteTape( "tp_chico_03" )



	end
	
	if TppGameSequence.GetGameFlag( "e20010_cassette" ) == true then
		if uiCommonData:IsHaveCassetteTape( "tp_chico_04" ) then
			
		else
			
			hudCommonData:ShowBonusPopupItemTape( "reward_get_tape_20010" )

			
			uiCommonData:GetBriefingCassetteTape( "tp_chico_04" )



		end
	end
	
	local AllChicoTape = GZCommon.CheckReward_AllChicoTape()
	if ( AllChicoTape == true and
			 uiCommonData:IsHaveCassetteTape( "tp_chico_08" ) == false ) then



		
		hudCommonData:ShowBonusPopupItemTape( "reward_get_tape_allchico" )
		
		uiCommonData:GetBriefingCassetteTape( "tp_chico_08" )
	end
	
	if ( AllHardClear == true and
			 uiCommonData:IsHaveCassetteTape( "tp_bgm_01" ) == false ) then



		
		hudCommonData:ShowBonusPopupItemTape( "reward_get_tape_tp_bgm_01" )
		
		uiCommonData:GetBriefingCassetteTape( "tp_bgm_01" )
	end
	
	
	
	if	TppGameSequence.GetGameFlag("hardmode") == false and					
		PlayRecord.GetMissionScore( 20010, "NORMAL", "CLEAR_COUNT" ) == 1 then	

		hudCommonData:ShowBonusPopupCommon( "reward_extreme" )					
	end
	
	if ( hardmode ) then
		
	else
		if ( clear_cnt == 1 ) then
			
	
			hudCommonData:ShowBonusPopupMission( "reward_open_side_ops_20020", 2 )
			hudCommonData:ShowBonusPopupMission( "reward_open_side_ops_20040", 4 )
			hudCommonData:ShowBonusPopupMission( "reward_open_side_ops_20030", 3 )
			hudCommonData:ShowBonusPopupMission( "reward_open_side_ops_20050", 5 )
		else
			
		end
	end
	
	
	
	
	if StoryFlags.GetFlag("gzXofWappen") == "notCleared" then
	
		
		if ( count == 1 ) then
			hudCommonData:ShowBonusPopupItemXOF( "reward_xof_num_01", 0 )
		elseif ( count == 2 ) then
			hudCommonData:ShowBonusPopupItemXOF( "reward_xof_num_02", 0 )
		elseif ( count == 3 ) then
			hudCommonData:ShowBonusPopupItemXOF( "reward_xof_num_03", 0 )
		elseif ( count == 4 ) then
			hudCommonData:ShowBonusPopupItemXOF( "reward_xof_num_04", 0 )
		elseif ( count == 5 ) then
			hudCommonData:ShowBonusPopupItemXOF( "reward_xof_num_05", 0 )
		elseif ( count == 6 ) then
			hudCommonData:ShowBonusPopupItemXOF( "reward_xof_num_06", 0 )
		elseif ( count == 7 ) then
			hudCommonData:ShowBonusPopupItemXOF( "reward_xof_num_07", 0 )
		elseif ( count == 8 ) then
			hudCommonData:ShowBonusPopupItemXOF( "reward_xof_num_08", 0 )
		
		elseif ( count == 9 ) then
			hudCommonData:ShowBonusPopupItemXOF( "reward_xof_num_09", 0 )
			if ( TppGameSequence.IsEnableSkull() == true ) then
				hudCommonData:ShowBonusPopupMission( "reward_open_side_ops_20070", 13 )
				hudCommonData:ShowBonusPopupMission( "reward_open_side_ops_20060", 6 )	
			else
				hudCommonData:ShowBonusPopupMission( "reward_open_side_ops_20060", 6 )
				hudCommonData:ShowBonusPopupMission( "reward_open_side_ops_20070", 13 )	
			end
			
			StoryFlags.SetFlag("gzXofWappen","cleared")
		end
	end
	
	if ( count == 9 ) then
		Trophy.TrophyUnlock( 15 )		
	end
	

	
	if ( hudCommonData:IsShowBonusPopup() == false ) then



		TppSequence.ChangeSequence( "Seq_MissionEnd" )	
	end
end



this.MissionFlagList = {

}



this.DemoList = {
	MotherbaseDestroyed	= "p11_010200_000",
	PazOperate = "p11_010180_000",
	PazOperate_JP = "p11_010185_000",
}






local onMissionPrepare = function()
	
	MissionManager.SetMiddleTextureWaitParameter( 0.5, 5 )
end

local onMissionExec = function()
	
	

	local colorCorrectionLUTPath = "ombs_demo_r8_FILTERLUT"
	TppEffectUtility.SetColorCorrectionLut( colorCorrectionLUTPath )

	
	GrTools.SetLightingColorScale(4.0)

	
	TppClock.SetTime( "06:35:00" )
	TppClock.Stop()
	TppWeather.SetWeather( "sunny" )
	TppWeather.Stop()
end

local onDemoBlockLoad = function()
		
		
		

		
		
		local demoBlockPath = ""
		if TppGameSequence.GetTargetPlatform() == "XboxOne" then
			demoBlockPath = "/Assets/tpp/pack/mission/extra/e20010/e20010_d03_1.fpk"
		elseif TppGameSequence.GetTargetPlatform() == "PS4" then
			demoBlockPath = "/Assets/tpp/pack/mission/extra/e20010/e20010_d03_2.fpk"
		else
			demoBlockPath = "/Assets/tpp/pack/mission/extra/e20010/e20010_d03.fpk"
		end

		TppMission.LoadDemoBlock( demoBlockPath )
end



this.Messages = {
	UI = {
		
		
	},
}

this.Seq_Mission_Prepare = {

	OnEnter = function()
		onMissionPrepare()

		
		local hudCommonData = HudCommonDataManager.GetInstance()
		if hudCommonData:IsEndLoadingTips() == false then
			this.startViewMode = "tips" 
		else
			this.startViewMode = "result" 
		end

		TppSequence.ChangeSequence( "Seq_Mission_Exec" )
	end,
}


this.Seq_Mission_Exec = {

	OnEnter = function()
		onMissionExec()
		TppSequence.ChangeSequence( "Seq_Game_OpeningDemoLoad" )
	end,
}


local IsDemoAndEventBlockActive = function()
	if ( TppMission.IsDemoBlockActive() == false ) then
		return false
	end
	if ( MissionManager.IsMissionStartMiddleTextureLoaded() == false ) then
		return false
	end

	return true

end

this.Seq_Game_OpeningDemoLoad = {

	OnEnter = function()
		onDemoBlockLoad()
	end,

	OnUpdate = function()
		
		if( IsDemoAndEventBlockActive() ) then



			
			TppSequence.ChangeSequence( "Seq_Wait_EndTelop" )
		end
	end,
}



this.Seq_Wait_EndTelop = {

	OnEnter = function()



		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:SetMissionEndTelopButtonDisp()
	end,

	OnUpdate = function()
		if ( this.startViewMode == "tips" ) then 
			local hudCommonData = HudCommonDataManager.GetInstance()
			if hudCommonData:IsEndLoadingTips() == false then
				hudCommonData:PermitEndLoadingTips() 
			else
				TppSequence.ChangeSequence( "Seq_Demo_PazOperate" )
			end
		end
	end,

	Messages = {
		UI = {
			{ message = "EndMissionTelopFadeOut" , commonFunc = function() TppSequence.ChangeSequence( "Seq_Demo_PazOperate" ) end },	
		},
	},
}


this.Seq_Demo_PazOperate = {

	OnEnter = function()



		PlatformConfiguration.SetShareScreenEnabled(false) 

		if (TppGameSequence.GetTargetArea() == "Japan" ) then		
			TppDemo.Play( "PazOperate_JP", {
				onStart = function() TppUI.FadeIn( 2 ) end,
				onEnd = function()
					TppUI.FadeOut( 0 )
					TppDemo.Play( "MotherbaseDestroyed", {
						onStart = function() TppUI.FadeIn(2) end,
						onEnd = function()
							TppPlayerUtility.SetPause()
							TppSequence.ChangeSequence( "Seq_EndRoll" )	
							TppUI.FadeOut(0)
						end,
					} )
				end
			} )
		else														
			TppDemo.Play( "PazOperate", {
				onStart = function() TppUI.FadeIn( 2 ) end,
				onEnd = function()
					TppUI.FadeOut( 0 )
					TppDemo.Play( "MotherbaseDestroyed", {
						onStart = function() TppUI.FadeIn(2) end,
						onEnd = function()
							TppPlayerUtility.SetPause()
							TppSequence.ChangeSequence( "Seq_EndRoll" )	
							TppUI.FadeOut(0)
						end,
					} )
				end
			} )
		end




		PlatformConfiguration.SetVideoRecordingEnabled(false) 

	end,
}

this.Seq_EndRoll = {

	MissionState = "clear",

	Messages = {
		UI = {
			{ message = "GzEndingFinish" , commonFunc = function() TppSequence.ChangeSequence( "Seq_ShowClearReward" ) end },	
		},
	},

	OnEnter = function()
		
		GzEnding.Start()



	end,

}

this.Seq_Mission_Clear = {

	OnEnter = function()

		TppSequence.ChangeSequence( "Seq_MissionEnd" )
	end,
}


this.Seq_MissionAbort = {
	OnEnter = function()
		TppMission.ChangeState( "abort" )
		TppSequence.ChangeSequence( "Seq_MissionEnd" )
	end,
}

this.Seq_MissionFailed = {
	OnEnter = function()
		TppMission.ChangeState( "failed" )
		TppSequence.ChangeSequence( "Seq_MissionEnd" )
	end,
}





this.Seq_ShowClearReward = {









	Messages = {
		UI = {
			
			{ message = "BonusPopupAllClose", commonFunc = function() TppSequence.ChangeSequence( "Seq_MissionEnd" ) end },
		},
	},

	OnEnter = function()







		PlatformConfiguration.SetShareScreenEnabled(true) 

		
		this.OnShowRewardPopupWindow()
	end,
}

this.Seq_MissionEnd = {

	OnEnter = function()
		TppMissionManager.SaveGame()
		TppMission.ChangeState( "end" )




		PlatformConfiguration.SetVideoRecordingEnabled(true)					

	end,
}




this.OnSkipEnterCommon = function()
	local sequence = TppSequence.GetCurrentSequence()

	onDemoBlockLoad()

	
	if( TppSequence.IsGreaterThan( sequence, "Seq_MissionFailed" ) ) then
		TppMission.ChangeState( "failed" )
	elseif( TppSequence.IsGreaterThan( sequence, "Seq_MissionAbort" ) ) then
		TppMission.ChangeState( "abort" )
	elseif( TppSequence.IsGreaterThan( sequence, "Seq_MissionClear" ) ) then
		TppMission.ChangeState( "clear" )
	
	
	end
end

this.OnSkipUpdateCommon = function()
	return IsDemoAndEventBlockActive()
end

this.OnSkipLeaveCommon = function()

end



return this
