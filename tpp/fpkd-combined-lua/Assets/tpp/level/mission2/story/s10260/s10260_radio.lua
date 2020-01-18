local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {

	{ "s0260_rtrg0100", playOnce = true }, 
	{ "s0260_rtrg0105", playOnce = true }, 

	{ "s0260_rtrg0120", playOnce = true }, 
	{ "s0260_rtrg0150", playOnce = true }, 
	{ "s0260_rtrg0160", playOnce = true }, 

	
	"s0260_rtrg0170",
	"s0260_rtrg0180",
	"s0260_rtrg0190",

	
	"s0260_rtrg0220",
	"s0260_rtrg0230",

	
	"s0260_rtrg0240",
	"s0260_rtrg0250", 

	
	"s0260_rtrg0260",
	"s0260_rtrg0270",

	"s0260_rtrg0290", 
	"s0260_rtrg0280", 

	"s0260_rtrg0300", 
	"s0260_rtrg0310", 
	"s0260_rtrg0315", 
	"s0260_rtrg0320", 
	"s0260_rtrg0330", 
	"s0260_rtrg0360", 
	"s0260_rtrg0370", 

	{ "s0260_rtrg0415", playOnce = true }, 
	{ "s0260_rtrg0200", playOnce = true }, 
	{ "s0260_rtrg0210", playOnce = true }, 
	
	{ "s0260_rtrg0380", playOnce = true }, 
	{ "s0260_rtrg0390", playOnce = true }, 

	
	"s0260_rtrg0150", 
	"s0260_rtrg0160", 
	"s0260_rtrg0400", 

	
	"s0260_rtrg0430", 
	"s0260_rtrg0000", 
	"s0260_rtrg0140", 

}





this.optionalRadioList = {
	"Set_s0260_oprg0010",
	"Set_s0260_oprg0020",
	"Set_s0260_oprg0030",
}





this.intelRadioList = {
}




this.gameOverRadioTable = {}
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.S10260_QUIET_DEAD] 		= "s0260_gmov0010"	





this.commonRadioTable = {}

this.GetRadioGroup = function()
	if TppSequence.GetCurrentSequenceIndex() == TppSequence.GetSequenceIndex("Seq_Game_MainGame")
	or TppSequence.GetCurrentSequenceIndex() == TppSequence.GetSequenceIndex("Seq_Game_MainGame_04") then
		return 	"s0260_rtrg0150"

	elseif TppSequence.GetCurrentSequenceIndex() == TppSequence.GetSequenceIndex("Seq_Game_MainGame_02_Phase01")
	or TppSequence.GetCurrentSequenceIndex() == TppSequence.GetSequenceIndex("Seq_Game_MainGame_02_Phase02")
	or TppSequence.GetCurrentSequenceIndex() == TppSequence.GetSequenceIndex("Seq_Game_MainGame_02_Phase03")
	or TppSequence.GetCurrentSequenceIndex() == TppSequence.GetSequenceIndex("Seq_Game_MainGame_02_Phase04") then
		return	"s0260_rtrg0160"

	elseif TppSequence.GetCurrentSequenceIndex() == TppSequence.GetSequenceIndex("Seq_Game_MainGame_03") then
		return	"s0260_rtrg0400"
	end
end

this.commonRadioTable[ TppDefine.COMMON_RADIO.OUTSIDE_MISSION_AREA ] = this.GetRadioGroup
this.commonRadioTable[ TppDefine.COMMON_RADIO.ABORT_BY_HELI ] = "s0260_rtrg0430"


this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_S		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_A		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_B		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_C		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_D		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_E		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_NOT_DEFINED]		= TppRadio.IGNORE_COMMON_RADIO        





this.blackTelephoneDisplaySetting = {
	f6000_rtrg0265 = {
		Japanese = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10260/mb_photo_10260_010_1.ftex", 1,"cast_quiet" }, 

			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_01.ftex", 8.45 }, 
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_02.ftex", 8.75 }, 

			{ "hide", "main_1", 29 }, 
			{ "hide", "main_2", 29.3 }, 

			{ "main_3", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_03.ftex", 29.6 }, 
			{ "main_4", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_04.ftex", 29.9 }, 

			{ "hide", "main_3", 51.3 }, 
			{ "hide", "main_4", 51.6 }, 

			{ "main_5", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_05.ftex", 51.9 }, 

			{ "hide", "main_5", 60.35 }, 

			{ "main_6", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_06.ftex", 60.65 }, 

			{ "hide", "main_6", 66.95 }, 

			{ "main_7", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_07.ftex", 67.25 }, 
			{ "main_8", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_08.ftex", 67.55 }, 
			{ "main_9", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_09.ftex", 67.85 }, 
			{ "main_10", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_10.ftex", 68.15 }, 

			{ "hide", "sub_1", 73.25 }, 
			{ "hide", "main_7", 73.55 }, 
			{ "hide", "main_8", 73.85 }, 
			{ "hide", "main_9", 74.15 }, 
			{ "hide", "main_10", 74.45 }, 

			{ "main_11", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_11.ftex", 74.75 }, 

		},

		English = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10260/mb_photo_10260_010_1.ftex", 1,"cast_quiet" }, 

			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_01.ftex", 8.3 }, 
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_02.ftex", 8.6 }, 

			{ "hide", "main_1", 33.1 }, 
			{ "hide", "main_2", 33.4 }, 

			{ "main_3", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_03.ftex", 33.7 }, 
			{ "main_4", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_04.ftex", 34 }, 

			{ "hide", "main_3", 53 }, 
			{ "hide", "main_4", 53.3 }, 

			{ "main_5", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_05.ftex", 53.6 }, 

			{ "hide", "main_5", 62.35 }, 

			{ "main_6", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_06.ftex", 62.65 }, 

			{ "hide", "main_6", 70.5 }, 

			{ "main_7", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_07.ftex", 70.8 }, 
			{ "main_8", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_08.ftex", 71.1 }, 
			{ "main_9", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_09.ftex", 71.4 }, 
			{ "main_10", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_10.ftex", 71.7 }, 

			{ "hide", "sub_1", 75 }, 
			{ "hide", "main_7", 75.3 }, 
			{ "hide", "main_8", 75.6 }, 
			{ "hide", "main_9", 75.9 }, 
			{ "hide", "main_10", 76.2 }, 

			{ "main_11", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10260_11.ftex", 76.5 }, 

		},
	},
}






this.MissionStory = function()
	Fox.Log("#### s10260_radio.MissionStory ####")
	TppRadio.Play( "s0260_rtrg0105" )
end





this.EnemyReached = function()
	Fox.Log("#### s10260_radio.enemyComesFront ####")
	if mvars.enemyReached == nil then
		mvars.enemyReached = 0
	end

	if mvars.enemyReached == 0 then
		TppRadio.Play( "s0260_rtrg0170",{ isEnqueue = true, delayTime = 1.0 } )
		mvars.enemyReached = 1
	elseif mvars.enemyReached == 1 then
		TppRadio.Play( "s0260_rtrg0180",{ isEnqueue = true, delayTime = 1.0 } )
		mvars.enemyReached = 2
	elseif mvars.enemyReached == 2 then
		TppRadio.Play( "s0260_rtrg0190",{ isEnqueue = true, delayTime = 1.0 } )
		mvars.enemyReached = 0
	end
end



this.EnemyComesFront = function()
	Fox.Log("#### s10260_radio.enemyComesFront ####")
	if mvars.enemyComesFront == nil then
		mvars.enemyComesFront = 0
	end

	if mvars.enemyComesFront == 0 then
		TppRadio.Play( "s0260_rtrg0220" ,{ isEnqueue = true, delayTime = 1.0 } )
		mvars.enemyComesFront = 1
	elseif mvars.enemyComesFront == 1 then
		TppRadio.Play( "s0260_rtrg0230" ,{ isEnqueue = true, delayTime = 1.0 } )
		mvars.enemyComesFront = 0
	end
end


this.EnemyComesLeft = function()
	Fox.Log("#### s10260_radio.enemyComesLeft ####")

	if mvars.enemyComesLeft == nil then
		mvars.enemyComesLeft = 0
	end

	if mvars.enemyComesLeft == 0 then
		TppRadio.Play( "s0260_rtrg0260" ,{ isEnqueue = true, delayTime = 1.0 } )
		mvars.enemyComesLeft = 1
	elseif mvars.enemyComesLeft == 1 then
		TppRadio.Play( "s0260_rtrg0270" ,{ isEnqueue = true, delayTime = 1.0 } )
		mvars.enemyComesLeft = 0
	end
end



this.EnemyComesRight = function()
	Fox.Log("#### s10260_radio.enemyComesRight ####")
	if mvars.enemyComesRight == nil then
		mvars.enemyComesRight = 0
	end

	if mvars.enemyComesRight == 0 then
		TppRadio.Play( "s0260_rtrg0240" ,{ isEnqueue = true, delayTime = 1.0 } )
		mvars.enemyComesRight = 1
	elseif mvars.enemyComesRight == 1 then
		TppRadio.Play( "s0260_rtrg0250",{ isEnqueue = true, delayTime = 1.0 } )
		mvars.enemyComesRight = 0
	end
end



this.enemyChopperComes = function()
	Fox.Log("#### s10260_radio.enemyChopperComes ####")
	TppRadio.Play( "s0260_rtrg0290" )
end

this.enemyChopperStart = function()
	Fox.Log("#### s10260_radio.enemyChopperComes ####")
	TppRadio.Play( "s0260_rtrg0280" )
end




this.StillComing = function() 
	Fox.Log("#### s10260_radio.StillComing ####")
	TppRadio.Play( "s0260_rtrg0300")
end

this.Reinforcement = function() 
	Fox.Log("#### s10260_radio.Reinforcement ####")
	TppRadio.Play( "s0260_rtrg0310")
end

this.QuietIsGo = function() 
	Fox.Log("#### s10260_radio.QuietIsGo ####")
	TppRadio.Play( "s0260_rtrg0315")
end

this.ReinforcementReaching = function() 
	Fox.Log("#### s10260_radio.ReinforcementReaching ####")
	TppRadio.Play( "s0260_rtrg0320")
end

this.interval = function()
	Fox.Log("#### s10260_radio.interval ####") 
	local n = math.random(0, 1) 

	if n == 0 then
		TppRadio.Play( "s0260_rtrg0330" )
	elseif n == 1 then
		TppRadio.Play( "s0260_rtrg0320" )
	end
end

this.intervalHint = function()
	Fox.Log("#### s10260_radio.interval Hint ####") 
	local n = math.random(0, 2) 

	if n == 0 then
		Fox.Log(" ### Skip Play Radio ### ")
	elseif n == 1 then
		TppRadio.Play( "s0260_rtrg0340", { isEnqueue = true, delayTime = 0.5 } )
	elseif n == 2 then
		TppRadio.Play( "s0260_rtrg0350", { isEnqueue = true, delayTime = 0.5 } )
	end
end


this.NoEnemyInSight = function()
	Fox.Log("#### s10260_radio.FewRemain ####") 
	TppRadio.Play( "s0260_rtrg0360")
end

this.FewRemain = function()
	Fox.Log("#### s10260_radio.FewRemain ####")
	TppRadio.Play( "s0260_rtrg0370") 
end

this.QuietDamage_99 = function()
	Fox.Log("#### s10260_radio.QuietDamage_99 ####")
	TppRadio.Play( "s0260_rtrg0415")
end

this.QuietDamage_50 = function()
	Fox.Log("#### s10260_radio.QuietDamage_50 ####")
	TppRadio.Play( "s0260_rtrg0200")
end

this.QuietDamage_25 = function()
	Fox.Log("#### s10260_radio.QuietDamage_25 ####")
	TppRadio.Play( "s0260_rtrg0210")
end

this.CannotCallQuietMenu = function()
	Fox.Log("#### s10260_radio.CannotCallQuietMenu ####")
	TppRadio.Play("s0260_rtrg0430")
end

this.CannotCallAllMenu = function()
	Fox.Log("#### s10260_radio.CannotCallAllMenu ####")
	local n = math.random(0, 255) 
	if n == 224 then
		TppRadio.Play( "s0260_rtrg0140" )
	else
		TppUiCommand.RequestMbSoundControllerVoice( "VOICE_SIGNAL_NOT_FOUND", true )
	end
end


this.OnGameCleared = function()
	Fox.Log("#### s10260_radio.OnGameCleared ####")
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0265" )
end





return this
