local this = {}




this.missionID = 20060
this.cpID = "gntn_cp"
this.tmpBestRank = 0
this.tmpRewardNum = 0				

this.trackWeapon1 = "WP_hg00_v01"
this.trackWeapon2 = "WP_sg01_v00"


this.markRouteBe = "GsRouteData0001"
this.markRouteAf = "GsRouteData0001_mark"



this.lookHeli = "heli_20060"
this.lookMoai = "e20060_moai"
this.lookCamera = "camera_20060"

this.tmpChallengeString = 0			

this.demoCamRot = 0.15
this.demoCamSpeed = 1.8


this.doorMax = 13

this.eneCheckSize_paz = Vector3(27,7,26) 
this.eneCheckSize_chico = Vector3(24,6,28) 

local logoMax = 8 

local hudCommonData = HudCommonDataManager.GetInstance()


local langDoor		= "announce_door_unlock"
local langHeli	 	= "announce_mission_40_20060_000_from_0_prio_0"
local langChaff 	= "announce_mission_40_20060_001_from_0_prio_0"
local langCamera 	= "announce_mission_40_20060_002_from_0_prio_0"
local langMoai 		= "announce_mission_40_20060_003_from_0_prio_0"
local langTank 		= "announce_mission_40_20060_004_from_0_prio_0"
local langVehicle 	= "announce_mission_40_20060_005_from_0_prio_0"
local langSwitch 	= "announce_mission_40_20060_006_from_0_prio_0"
local langLogo 		= "announce_mission_40_20060_007_from_0_prio_0"
local langMark 		= "announce_mission_40_20060_008_from_0_prio_0"
local langMarkLA 	= "announce_mission_40_20060_009_from_0_prio_0"
local langXOF		= "announce_allDestroyXOF"	
local langHeliDead	= "announce_destroyed_support_heli"

local langFoxDie000 = "announce_mission_40_20060_100_from_0_prio_0"	
local langFoxDie001 = "announce_mission_40_20060_101_from_0_prio_0"	
local langFoxDie002 = "announce_mission_40_20060_102_from_0_prio_0"	
local langFoxDie003 = "announce_mission_40_20060_103_from_0_prio_0"	
local langFoxDie004 = "announce_mission_40_20060_104_from_0_prio_0"	
local langFoxDie005 = "announce_mission_40_20060_105_from_0_prio_0"	
local langFoxDie006 = "announce_mission_40_20060_106_from_0_prio_0"	
local langFoxDie007 = "announce_mission_40_20060_107_from_0_prio_0"	
local langFoxDie008 = "announce_mission_40_20060_108_from_0_prio_0"	
local langFoxDie009 = "announce_mission_40_20060_109_from_0_prio_0"	
local langFoxDie010 = "announce_mission_40_20060_110_from_0_prio_0"	
local langFoxDie011 = "announce_mission_40_20060_111_from_0_prio_0"	
local langFoxDie012 = "announce_mission_40_20060_112_from_0_prio_0"	
local langFoxDie013 = "announce_mission_40_20060_113_from_0_prio_0"	
local langFoxDie014 = "announce_mission_40_20060_114_from_0_prio_0"	
local langFoxDie015 = "announce_mission_40_20060_115_from_0_prio_0"	
local langFoxDie016 = "announce_mission_40_20060_116_from_0_prio_0"	
local langFoxDie017 = "announce_mission_40_20060_117_from_0_prio_0"	
local langFoxDie018 = "announce_mission_40_20060_118_from_0_prio_0"	
local langFoxDie019 = "announce_mission_40_20060_119_from_0_prio_0"	
local langFoxDie020 = "announce_mission_40_20060_120_from_0_prio_0"	
local langFoxDie021 = "announce_mission_40_20060_121_from_0_prio_0"	
local langFoxDie022 = "announce_mission_40_20060_122_from_0_prio_0"	
local langFoxDie023 = "announce_mission_40_20060_123_from_0_prio_0"	
local langFoxDie024 = "announce_mission_40_20060_124_from_0_prio_0"	
local langFoxDie025 = "announce_mission_40_20060_125_from_0_prio_0"	
local langFoxDie026 = "announce_mission_40_20060_126_from_0_prio_0"	
local langFoxDie027 = "announce_mission_40_20060_127_from_0_prio_0"	
local langFoxDie028 = "announce_mission_40_20060_128_from_0_prio_0"	
local langFoxDie029 = "announce_mission_40_20060_129_from_0_prio_0"	
local langFoxDie030 = "announce_mission_40_20060_130_from_0_prio_0"	
local langFoxDie031 = "announce_mission_40_20060_131_from_0_prio_0"	
local langFoxDie032 = "announce_mission_40_20060_132_from_0_prio_0"	
local langFoxDie033 = "announce_mission_40_20060_133_from_0_prio_0"	



this.demoStaPlayer_chico = "Stand"
this.demoPosPlayer_chico = Vector3(73.27256, 17.2, 197.36193)
this.demoRotPlayer_chico = -20.0805

this.demoStaPlayer_paz = "Stand"
this.demoPosPlayer_paz = Vector3(-133.1, 24.5, -10.2)
this.demoRotPlayer_paz = 90

this.foxDieDemoDoorNum = 2	
this.timeFoxDieBugAnnounce = 1 
this.timeFoxDieBugStart = 2	
this.timeFoxDieBug = 100	
this.timeEndSeq = 40 




this.RequiredFiles = {
	"/Assets/tpp/script/common/GZCommon.lua",
}

this.Sequences = {
	
	{ "Seq_MissionPrepare" },
	
	{ "Seq_MissionSetup" },
	{ "Seq_OpeningDemoLoad" },
	{ "Seq_OpeningShowTransition" },
	{ "Seq_OpeningDemo" },
	{ "Seq_OpeningDemoEnd" },
	
	{ "Seq_MissionLoad" },
	{ "Seq_MissionStart" },
	{ "Seq_PlayerRideHelicopter" },
	{ "Seq_EventFoxDie"},
	
	{ "Seq_QuizSetup" },
	{ "Seq_QuizSkip" },
	{ "Seq_Quiz" },
	
	{ "Seq_DemoFoxDie" },
	
	{ "Seq_MissionClearDemo" },
	{ "Seq_MissionClearDemoAfter" },
	{ "Seq_MissionClearShowTransition" },
	{ "Seq_ShowClearReward" },
	{ "Seq_MissionAbort" },
	{ "Seq_MissionFailed" },
	{ "Seq_MissionGameOver" },
	{ "Seq_MissionEnd" },
}

this.ClearRankRewardList = {

	
	RankS = "e20060_Assult",
	RankA = "e20060_Misile",
	RankB = "e20060_Sniper",
	RankC = "e20060_HandShotGun",
}






this.ClearRankRewardPopupList = {

	
	RankS = "reward_clear_s_rifle",
	RankA = "reward_clear_a_rocket",
	RankB = "reward_clear_b_sniper",
	RankC = "reward_clear_c_pistol",
}


this.checkings = {
	"CheckLookingTarget"
}
this.OnStart = function( manager )
	GZCommon.Register( this, manager )
	TppMission.Setup()
end


this.ChangeExecSequenceList =  {
	
	"Seq_OpeningDemo",
	"Seq_OpeningDemoEnd",
	"Seq_MissionLoad",
	"Seq_MissionStart",
	"Seq_PlayerRideHelicopter",
	
	
	
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




this.MissionFlagList = {
	isClear			=	false, 
	isClearComp		=	false, 
	
	isLookHeli 		= false,	
	isGetChaffCase 	= false,	
	isLookCamera 	= false,	
	isLookMoai 		= false,	
	isBombTank 		= false,	
	isRunVehicle 	= false,	
	isTurnOffPanel 	= false,	
	isInCamera		= false,
	isInMoai		= false,
	isInHeli		= false,
	
	isLookHeliFailed 		= false,	
	isGetChaffCaseFailed 	= false,	
	isLookCameraFailed 		= false,	
	isLookMoaiFailed 		= false,	
	isBombTankFailed 		= false,	
	isRunVehicleFailed 		= false,	
	isTurnOffPanelFailed 	= false,	
	
	isLookHeliPhoto 		= false,	
	isGetChaffCasePhoto 	= false,	
	isLookCameraPhoto		= false,	
	isLookMoaiPhoto 		= false,	
	isBombTankPhoto 		= false,	
	isRunVehiclePhoto 		= false,	
	isTurnOffPanelPhoto 	= false,	
	
	isCountTitleLogo		= 0,
	isTitleComp				= false,
	isGetWeapon				= false,
	isMakeFox				= false,
	isMakeLA				= false,
	isDoorCounter			= 0,
	
	isPlayerInsideBGM		= false,	
	isPlayerInsideColor		= false,	
	
	isCountClear			= 0,
	isCountClaymore			= 0,
	isFailedClaymore		= false,
	
	isFoxDieChico			= false, 
	isFoxDiePaz				= false, 
	isFoxDieStart			= false,
	isFoxDieEnd				= false, 
	isInTankDemo			= false,
	
	isRadioEndOfKonkai		= false,
	isRadioAraskaSay		= false, 
	isRadioAraskaTrap		= false, 
	isRadioJanai			= false,
	
	isGetShotGun			= false, 
	isGetHandGun			= false,
	
	isCarTutorial			= false, 
	isAVMTutorial			= false, 
	
	isMarkGZ	= false,
	isMarkMG	= false,
	isMarkMG2	= false,
	isMarkMGS	= false,
	isMarkMGS2	= false,
	isMarkMGS3	= false,
	isMarkMGSPW	= false,
	isMarkMGS4	= false,
	isMarkHeli	= false, 

	isHeliLandNow			= false,	

	isHeliBreak	= false,	
	isHeliComming = false,

	isDemoChico		= false,
	isDemoPaz		= false,
	isHostageDead1	= false,
	isHostageDead2	= false,

	isPazDoor		= false,

	isBreakWood		= false,
	isJinmon		= false,

	isRouteSerch1	= false,
	isRouteSerch2	= false,
	isRouteSerch3	= false,

	isQuizSkip		= false,
	isQuizComp		= false,

	isNinjaReward	= false,
}




this.CounterList = {
	GameOverRadioName			= "NoRadio",		
	GameOverFadeTime			= GZCommon.FadeOutTime_MissionFailed,	
}




this.DemoList = {
	Demo_Opening 			= "p12_050000_000",		
	Demo_LookHeli			= "p12_050020_010",		
	Demo_FlashGetChaffCase	= "p12_050020_020",		
	Demo_LookCamera			= "p12_050020_030",		
	Demo_LookMoai			= "p12_050020_040",		
	Demo_BombTank			= "p12_050020_055",		
	Demo_BombTankGns		= "p12_050020_055_gns",		
	Demo_RunVehicle			= "p12_050020_060",		
	Demo_RunVehicleRev		= "p12_050020_060_rev",		
	Demo_TurnOffPanel		= "p12_050020_075",		
	Demo_TurnOffPanelJP		= "p12_050020_075_jpn",		
	Demo_MissionClear		= "p12_050010_000",		
	Demo_MissionClearComp	= "p12_050010_000",		
	Demo_FoxDieChico		= "p12_050030_000",
	Demo_FoxDiePaz			= "p12_050040_000",		
	Demo_FoxDieChicoLow		= "p12_050050_000",
	Demo_FoxDiePazLow		= "p12_050060_000",		
	Demo_AreaEscapeNorth	= "p11_020010_000",		
	Demo_AreaEscapeWest		= "p11_020020_000",		
	Demo_FoxLightKJP		= "p12_050070_000",		
	Demo_FoxLightLA			= "p12_050070_001",		
}




this.RadioList = {
	
	Miller_MissionAreaOut	= "f0090_rtrg0310",			
	
	Miller_op000			= {"e0060_rtrg0010",1}, 	
	Miller_op002			= {"e0060_rtrg0013",1}, 	
	Near_Hostage			=  "e0060_rtrg0222",		
	Miller_op003			= "e0060_rtrg0011",			
	
	fondHomage1				= "e0060_rtrg0021", 		
	fondHomage2				= "e0060_rtrg0020", 		
	canClear				= {"e0060_rtrg0022",1}, 	
	complateHomage			= "e0060_rtrg0030", 		
	Answer_near				= "e0060_rtrg0040", 		
	Answer_toFlase			= "e0060_rtrg0050", 		
	Answer_failedAlert		= "e0060_rtrg0054", 		
	Answer_failed			= "e0060_rtrg0055", 		
	Answer_failedTo			= "e0060_rtrg0056", 		
	
	
	Answer_no				= "e0060_rtrg0057", 		
	Answer_noHeli			= "e0060_rtrg0065", 		
	Hint_heli				= "e0060_rtrg0070", 		
	Hint_chaff				= "e0060_rtrg0071", 		
	Hint_moai				= "e0060_rtrg0072", 		
	Hint_tank				= "e0060_rtrg0073", 		
	Hint_vehicle			= "e0060_rtrg0074", 		
	Hint_camera				= "e0060_rtrg0075", 		
	Hint_switch				= "e0060_rtrg0079", 		
	Hint_switch0			= {"e0060_rtrg0069",1}, 	
	Answer_switch			= {"e0060_rtrg0077",1}, 	
	Clear_normal			= {"e0060_rtrg0110",1}, 	
	Clear_normal2			= {"e0060_rtrg0120",1}, 	
	Clear_complate			= "e0060_rtrg0130", 	
	
	radio_Alert				= {"e0060_rtrg0015",1},
	radio_BackAlert			= {"e0060_rtrg0016",1},
	
	neta_start				= {"e0060_rtrg0140",1}, 	
	neta_start2				= {"e0060_rtrg0141",1}, 	
	neta_door				= {"e0060_rtrg0150",1}, 	
	neta_vehicle			= {"e0060_rtrg0160",1}, 	
	Call_dact				= {"e0060_rtrg0090",1}, 	
	Call_rat				= {"e0060_rtrg0100",1}, 	
	
	Call_mine				= {"e0060_rtrg0080",1}, 	
	Metal_getGun			= {"e0060_rtrg0170",1}, 	
	Metal_mistakeGun		= {"e0060_rtrg0175",1}, 	
	Metal_mistakeBigMark	= "e0060_rtrg0176", 		
	Metal_notYet			= "e0060_rtrg0177", 		
	Metal_visibleMark		= "e0060_rtrg0178", 		
	Metal_int				= "e0060_rtrg0180", 		
	Metal_wrong				= "e0060_rtrg0183", 		
	Metal_allClear			= {"e0060_rtrg0185",1}, 		
	Metal_bigMarkClear		= "e0060_rtrg0187", 		
	Metal_Clear				= {"e0060_rtrg0188",1}, 	
	Light_offMark			= {"e0060_rtrg0189",1}, 	
	Light_near				= {"e0060_rtrg0190",1}, 	
	Light_clear				= {"e0060_rtrg0200",1}, 	
	Light_clearLA			= {"e0060_rtrg0210",1}, 	
	
	Radio_MissionClearRank_S = "e0060_rtrg0304",
	Radio_MissionClearRank_A = "e0060_rtrg0303",
	Radio_MissionClearRank_B = "e0060_rtrg0302",
	Radio_MissionClearRank_C = "e0060_rtrg0301",
	Radio_MissionClearRank_D = "e0060_rtrg0300",
	
	Radio_RideHeli_Clear 		="f0090_rtrg0460",
	Radio_MissionAbort_Warning 	="f0090_rtrg0130",
	Miller_HeliAttack			="f0090_rtrg0225",				
	
	Radio_FoxDie1 			="e0060_rtrg0220",
	Radio_FoxDie2 			="e0060_rtrg0230",
	Radio_FoxDieIDroid 		="e0060_rtrg9010",
	Radio_FoxDieFixed 		="e0060_rtrg9020",

	
	Sneak_Natsui00	= "e0060_rtrg1010",
	Sneak_Natsui01	= "e0060_rtrg1013",
	Sneak_Natsui02	= "e0060_rtrg1017",
	Sneak_Natsui03	= "e0060_rtrg1018",

	
	Quiz_start1 	= "e0060_rtrg2010",	
	Quiz_start2 	= "e0060_rtrg2020",	
	Quiz_skinNot	= "e0060_rtrg2030",	
	Quiz_skinHave 	= "e0060_rtrg2032",	
	Quiz_setumei	= "e0060_rtrg2040",	
	Quiz_normal 	= "e0060_rtrg2050",	
	Quiz_hard 		= "e0060_rtrg2052",	
	Quiz_areYouRedy = "e0060_rtrg2060",	
	Quiz_goToQuiz 	= "e0060_rtrg2070",	
	Quiz_goToTitle 	= "e0060_rtrg2075",	
	Quiz_failed 	= "e0060_rtrg2120",	
	Quiz_allClear 	= "e0060_rtrg2130",	
	Quiz_skinGet 	= "e0060_rtrg2140",	
	Quiz_skinNoGet 	= "e0060_rtrg2145",	
	Quiz_skip		= "e0060_rtrg2011", 
	
	Quiz_Die		= "e0060_rtrg2155", 

	
	Radio_DeadPlayer					= "f0033_gmov0190",		
	Radio_RideHeli_Failed				= "f0033_gmov0040",		
	Radio_MissionArea_Failed			= "f0033_gmov0020",		

	Miller_BreakSuppressor	= "f0090_rtrg0530",

	
	Radio_AlertHostage		= "e0060_rtrg0310", 
	Radio_HostageDead 		= "f0090_rtrg0540",	
	Radio_HostageOnHeli		= "f0090_rtrg0200",			

	
	Miller_CallHeliHot01		= "e0010_rtrg0175",			
	Miller_CallHeliHot02		= "e0010_rtrg0176",			
	Miller_CallHeli01			= "f0090_rtrg0170",			
	Miller_CallHeli02			= "f0090_rtrg0171",			
	
	radio_Toilet			= {"e0060_rtrg0240",1},



}
this.OptionalRadioList = {
	
	OptionalRadioSet_001		= "Set_e0060_oprg0010",
	OptionalRadioSet_001snow	= "Set_e0060_oprg0011",
	OptionalRadioSet_003		= "Set_e0060_oprg0015",
	OptionalRadioSet_003snow	= "Set_e0060_oprg0016",
	OptionalRadioSet_002		= "Set_e0060_oprg0020",
}


this.IntelRadioList = {
	intelHomage   	= "e0060_esrg0060", 
	radio_homage_heli 	= "e0060_esrg0060",
	radio_homage_camera = "e0060_esrg0060",
	radio_homage_chaff	= "e0060_esrg0060",
	radio_homage_tank 	= "e0060_esrg0060",
	radio_homage_moai 	= "e0060_esrg0060",

	
	intelMark_001 	= "e0060_esrg0010",
	intelMark_002 	= "e0060_esrg0015",
	intelMark_gz 	= "e0060_esrg0019",
	intelMark_mg 	= "e0060_esrg0020",
	intelMark_mg2 	= "e0060_esrg0021",
	intelMark_mgs 	= "e0060_esrg0023",
	intelMark_104 	= "e0060_esrg0022",
	intelMark_mgs2	= "e0060_esrg0024",
	intelMark_mgs3 	= "e0060_esrg0025",
	e20060_logo_001 			= "e0060_esrg0026",
	intelMark_mgs4 				= "e0060_esrg0027",
	intelMark_109 				= "e0060_esrg0028",
	intelMark_110 				= "e0060_esrg0029",
	
	radio_kjpLogo 				= "e0060_esrg0030",
	gntn_serchlight_20060_3 	= "e0060_esrg0040",
	gntn_serchlight_20060_4 	= "e0060_esrg0040",
	
	radio_foxFlag				= "e0060_esrg0050",
	radio_foxFlag1				= "e0060_esrg0050",
	
	camera_20060				= "f0090_esrg0210",

	intel_e0060_esrg0070		= "e0060_esrg0070",						
	intel_e0060_esrg0080		= "e0060_esrg0080",						

	
	Hostage_e20060_000 			= "e0060_esrg0090",
	Hostage_e20060_001 			= "e0060_esrg0090",
	Hostage_e20060_002 			= "e0060_esrg0090",
	Hostage_e20060_003 			= "e0060_esrg0090",

	
	intel_f0090_esrg0110		= "f0090_esrg0110",						
	intel_f0090_esrg0120		= "f0090_esrg0120",						
	intel_f0090_esrg0130		= "f0090_esrg0130",						
	intel_f0090_esrg0140		= "f0090_esrg0140",						
	intel_f0090_esrg0150		= "f0090_esrg0150",						
	intel_f0090_esrg0190		= "f0090_esrg0190",						
	intel_f0090_esrg0220		= "f0090_esrg0220",						
}

this.Messages = {
	Mission = {
		{ 								message = "MissionFailure",		 		localFunc = "commonMissionFailure" },
		{ 								message = "MissionClear", 				localFunc = "commonMissionClear" },
		{ 								message = "MissionRestart", 				localFunc = "commonMissionCleanUp" },		
		{ 								message = "MissionRestartFromCheckPoint", 		localFunc = "commonMissionCleanUp" },		
		{ 								message = "ReturnTitle", 					localFunc = "commonReturnTitle" },		
	},
	Character = {
		
		{ data = "gntn_cp",				message = "Alert",		commonFunc = function() this.commonOnAlert() end },
		{ data = "gntn_cp",				message = "Evasion",	commonFunc = function() this.commonOnEvasion() end },
		{ data = "gntn_cp",				message = "Caution",	commonFunc = function() this.commonOnCaution() end },
		{ data = "gntn_cp",				message = "Sneak",		commonFunc = function() GZCommon.StopAlertSirenCheck() end },		
		{ data = "gntn_cp",				message = "AntiAir",	commonFunc = function() this.ChangeAntiAir() end },	
		
		{ data = "Player", 				message = "RideHelicopter", commonFunc = function() this.commonPlayerRideHeli() end},	
		{ data = "SupportHelicopter",	message = "Dead",	commonFunc = function() this.commonHeliDead() end  },		
		{ data = "SupportHelicopter",	message = "DepartureToMotherBase",	commonFunc = function() this.commonHeliTakeOff() end  },	
		{ data = "SupportHelicopter",	message = "DamagedByPlayer",		commonFunc = function() this.commonHeliDamagedByPlayer() end },		
	},
	Gimmick = {
		
		{ 								message = "DoorUnlock", commonFunc = function()  this.Common_DoorUnlock() end},
		{ data = "Paz_PickingDoor00",	message = "DoorOpenComplete", commonFunc = function()  this.Common_DoorOpen() end},
	},
}




local insideBGMSetting = function()
	
	
	if (TppMission.GetFlag( "isPlayerInsideBGM" ) == false)then
		



		TppMusicManager.ChangeParameter( 'bgm_mgs1_phase_out' )
	else
		



		TppMusicManager.ChangeParameter( 'bgm_mgs1_phase_in' )
	end
end

local insideColorSetting = function()
	
	
	if (TppMission.GetFlag( "isPlayerInsideColor" ) == false)then
		



		TppEffectUtility.SetColorCorrectionLut( "MGS1_FILTERLUT_r1" )
	else
		



		
		
		TppEffectUtility.SetColorCorrectionLut( "MGS1_FILTERLUT_r1" )
	end
end


local commonSetOptRadio = function()
	




	if( TppMission.GetFlag( "isClearComp" ) == true )then
	
		
		TppRadio.RegisterOptionalRadio( "OptionalRadioSet_002" )
	elseif( TppMission.GetFlag( "isClear" ) == true )then
	
		
		if (TppGameSequence.GetGameFlag("playerSkinMode" ) == 0)  then
			TppRadio.RegisterOptionalRadio( "OptionalRadioSet_003" )
		else
			TppRadio.RegisterOptionalRadio( "OptionalRadioSet_003snow" )
		end
	else
	
		if (TppGameSequence.GetGameFlag("playerSkinMode" ) == 0)  then
			TppRadio.RegisterOptionalRadio( "OptionalRadioSet_001" )
		else
			TppRadio.RegisterOptionalRadio( "OptionalRadioSet_001snow" )
		end
	end
end


local commonRadioSet = function()



	commonSetOptRadio()

	if( TppMission.GetFlag( "isMakeLA" ) == true or TppMission.GetFlag( "isMakeFox" ) == true )then
		TppRadio.DisableIntelRadio( "radio_kjpLogo" )
	else
		TppRadio.EnableIntelRadio( "radio_kjpLogo" )
	end
	TppRadio.EnableIntelRadio( "gntn_serchlight_20060_3" )
	TppRadio.EnableIntelRadio( "gntn_serchlight_20060_4" )
	TppRadio.EnableIntelRadio( "radio_foxFlag" )
	TppRadio.EnableIntelRadio( "radio_foxFlag1" )
	TppRadio.EnableIntelRadio( "camera_20060" )
	TppRadio.EnableIntelRadio( "Hostage_e20060_000" )
	TppRadio.EnableIntelRadio( "Hostage_e20060_001" )
	TppRadio.EnableIntelRadio( "Hostage_e20060_002" )
	TppRadio.EnableIntelRadio( "Hostage_e20060_003" )
	TppRadio.EnableIntelRadio( "intel_e0060_esrg0070" )

	
	TppRadio.EnableIntelRadio( "intelMark_gz" )
	TppRadio.EnableIntelRadio( "intelMark_mg" )
	TppRadio.EnableIntelRadio( "intelMark_mg2" )
	TppRadio.EnableIntelRadio( "intelMark_mgs" )
	TppRadio.EnableIntelRadio( "intelMark_mgs2" )
	TppRadio.EnableIntelRadio( "intelMark_mgs3" )
	TppRadio.EnableIntelRadio( "e20060_logo_001" )
	TppRadio.EnableIntelRadio( "intelMark_mgs4" )	
	TppRadio.EnableIntelRadio( "intelMark_002" )	

end

local lowPolyPlayer = function()



	
	local skinFlag = TppGameSequence.GetGameFlag("playerSkinMode" )



	if (skinFlag == 1)	then
		



		TppPlayerUtility.ChangeLocalPlayerType("PLTypeMgs1")
	elseif( skinFlag == 2 )then
		



		TppPlayerUtility.ChangeLocalPlayerType("PLTypeNinja")
	else
		



		TppPlayerUtility.ChangeLocalPlayerType("PLTypeSneakingSuit")
	end
end
local lowPolyEnemy = function()
	
	if (TppGameSequence.GetGameFlag("playerSkinMode" ) ~= 0)  then



		
		TppEffect.ShowEffect( "fx_snow" )
		TppEffect.HideEffect( "fx_dst" )
		
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_000",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_001",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_002",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_003",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_004",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_005",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_006",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_007",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_008",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_009",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_010",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_011",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_012",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_024",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_025",false )
		TppCharacterUtility.SetEnableCharacterId( "USSArmmy_026",false )
		TppCharacterUtility.SetEnableCharacterId( "Hostage_e20060_000",false )
		TppCharacterUtility.SetEnableCharacterId( "Hostage_e20060_001",false )
		
		TppCharacterUtility.SetEnableCharacterId( "genom_000",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_001",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_002",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_003",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_004",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_005",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_006",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_007",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_008",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_009",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_010",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_011",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_012",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_013",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_014",true )
		TppCharacterUtility.SetEnableCharacterId( "genom_015",true )
		TppCharacterUtility.SetEnableCharacterId( "Hostage_e20060_002",true )
		TppCharacterUtility.SetEnableCharacterId( "Hostage_e20060_003",true )
		TppHostageManager.GsSetEnableVoice( "Hostage_e20060_002", false ) 
		TppHostageManager.GsSetEnableVoice( "Hostage_e20060_003", false )
		
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_000" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_001" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_002" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_003" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_004" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_005" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_006" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_007" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_008" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_009" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_010" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_011" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_012" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_013" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_014" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "genom_015" )
		GZCommon.EnemyLaidonHeliNoAnnounceSet( "GenomeSoldier_Save" )
	end
end


local commonChangeMissionSubGoal = function(add)
	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager == NULL then
			return
	end

	local luaData = commonDataManager:GetUiLuaExportCommonData()
	if luaData == NULL then
			return
	end

	if( TppMission.GetFlag( "isClear" ) == false )then
		luaData:SetCurrentMissionSubGoalNo( 1 ) 
	else
		luaData:SetCurrentMissionSubGoalNo( 2 ) 
	end
end



local All_Seq_MissionAreaOut = function()
	
	 local sequence = TppSequence.GetCurrentSequence()
		if (sequence ~= "Seq_PlayerRideHelicopter" )then
			TppMission.OnLeaveInnerArea( function() TppRadio.Play( "Miller_MissionAreaOut" ) end )
			TppMission.OnLeaveOuterArea( function() TppMission.ChangeState( "failed", "MissionAreaOut" ) end )	
		else



		end
end

local heliWindowEffect = function()



	if TppMission.GetFlag( "isHeliBreak" ) then
		TppEffect.HideEffect( "fx_heliWindow")
	else
		TppEffect.ShowEffect( "fx_heliWindow" )
	end

end

local setHeliMarker = function()



	if( TppMission.GetFlag( "isMarkMGSPW" ) == false and TppMission.GetFlag( "isJinmon" ) )then

		if( TppMission.GetFlag( "isMarkHeli" ) == true )then
			



			TppMarkerSystem.DisableMarker{ markerId="e20060_marker_charenge01" }
			TppMarkerSystem.SetMarkerGoalType{ markerId="e20060_logo_001", goalType="GOAL_NONE", radiusLevel=1 }
			TppMarkerSystem.EnableMarker{ markerId="e20060_logo_001", viewType="VIEW_MAP_ICON" }

		else
			



			TppMarkerSystem.DisableMarker{ markerId="e20060_logo_001" }
			TppMarkerSystem.SetMarkerGoalType{ markerId="e20060_marker_charenge01", goalType="GOAL_NONE", radiusLevel=1 }
			TppMarkerSystem.EnableMarker{ markerId="e20060_marker_charenge01", viewType="VIEW_MAP_ICON"  }
		end
		return true

	elseif( TppMission.GetFlag( "isJinmon" ) )then
		



		TppMarkerSystem.DisableMarker{ markerId="e20060_logo_001" }
		TppMarkerSystem.DisableMarker{ markerId="e20060_marker_charenge01" }

		return false
	end
end

local removeJinmon = function(characterId,characterIdLow)
		



		TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( characterId,1 )
		TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( characterIdLow,1 ) 
end

local removeAllJinmon = function()



			removeJinmon( "USSArmmy_000","genom_006" )
			removeJinmon( "USSArmmy_011","genom_004" )
			removeJinmon( "USSArmmy_007","genom_008" )
			removeJinmon( "USSArmmy_009","genom_003" )
			removeJinmon( "USSArmmy_012","genom_015" )
			removeJinmon( "USSArmmy_002","genom_005" )
			removeJinmon( "USSArmmy_024","genom_012" )
			removeJinmon( "USSArmmy_005","genom_010" )
end


local MissionSetup = function()
	

	
	TppRadio.SetAllSaveRadioId()

	GZCommon.MissionSetup()	
	
	commonRadioSet()
	
	lowPolyEnemy()

	
	MissionManager.SetMiddleTextureWaitParameter( 0.5, 5 )

	
	WeatherManager.RequestTag("default", 0 )
	TppClock.SetTime( "00:00:00" )
	TppClock.Stop()
	TppWeather.SetWeather( "cloudy" )
	GrTools.SetLightingColorScale(2.0)

	
	TppVehicleUtility.SetCannotRide("Armored_Vehicle_WEST_001")

	
	if ( TppMission.GetFlag( "isGetHandGun" ) == false ) then
		TppNewCollectibleUtility.PutCollectibleOnCharacter{ id = this.trackWeapon1, count = 21, target = "Cargo_Truck_WEST_001" , attachPoint = "CNP_USERITEM" }
	end
	if ( TppMission.GetFlag( "isGetShotGun" ) == false ) then
		TppNewCollectibleUtility.PutCollectibleOnCharacter{ id = this.trackWeapon2, count = 15, target = "Cargo_Truck_WEST_002" , attachPoint = "CNP_USERITEM" }
	end

	
	if( TppMission.GetFlag( "isBombTank" ) == false and TppMission.GetFlag( "isBombTankFailed" ) == false) then
		TppRadio.DisableIntelRadio( "radio_homage_tank" )
		TppRadio.EnableIntelRadio( "intel_e0060_esrg0070" )
	else
		TppRadio.DisableIntelRadio( "intel_e0060_esrg0070" )
		this.damageTank()
	end

	
	if ( TppMission.GetFlag( "isMarkMGSPW" ) == false ) then
		TppGadgetUtility.AttachGadgetToChara("e20060_logo_001","SupportHelicopter","CNP_MARK")
	end

	
	commonChangeMissionSubGoal()
	
	insideBGMSetting()
	
	insideColorSetting()

	
	if ( TppMission.GetFlag( "isGetWeapon" ) == true ) then
		TppEffect.HideEffect( "fx_weaponLight")
	else
		TppEffect.ShowEffect( "fx_weaponLight" )
	end

	
	if ( TppMission.GetFlag( "isBreakWood" ) == true ) then
		TppCharacterUtility.SetEnableCharacterId( "e20060_logo_008", false )
	else
		TppCharacterUtility.SetEnableCharacterId( "e20060_logo_008", true )
	end

	
	heliWindowEffect()

	
	local angle = 120
	TppGimmick.OpenDoor( "AsyPickingDoor04", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor05", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor07", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor08", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor09", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor13", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor15", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor16", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor22", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor23", angle )


	
	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager == NULL then
			return
	end
	local luaData = commonDataManager:GetUiLuaExportCommonData()
	if luaData == NULL then
			return
	end


	
	luaData:SetupIconUniqueInformationTable(
		
		 { markerId="e20060_marker_GoalPoint", 			langId=	"marker_info_place_02" }
		,{ markerId="e20060_marker_PowerSupply",		langId=	"marker_info_place_00" }				
		,{ markerId="e20060_marker_Weapon", 			langId=	"marker_info_weapon" }				
		,{ markerId = "Cargo_Truck_WEST_002", 			langId = "marker_info_truck" }				
		,{ markerId = "Cargo_Truck_WEST_001", 			langId = "marker_info_truck" }				
		,{ markerId = "Armored_Vehicle_WEST_001",		langId = "marker_info_APC" }				
		,{ markerId = "Tactical_Vehicle_WEST", 			langId = "marker_info_vehicle_4wd" }		
		,{ markerId = "e20060_marker_Cassette", 		langId = "marker_info_item_tape" }			
		,{ markerId="e20060_marker_sniperRifle",		langId="marker_info_weapon_01" }			
		,{ markerId="e20060_marker_Mine",				langId="marker_info_weapon_08" }			
		,{ markerId="e20060_marker_MonlethalWeapon",	langId="marker_info_weapon_00" }			
		,{ markerId="e20060_marker_HundGun",			langId="marker_info_weapon_00" }			
		,{ markerId="e20060_marker_ShotGun",			langId="marker_info_weapon_03" }			
		,{ markerId="e20060_marker_SubMachineGun",		langId="marker_info_weapon_04" }			
		,{ markerId = "camera_20060",					langId="marker_info_Surveillance_camera" }
		,{ markerId = "e20060_marker_Moai",					langId="marker_info_moai" }
		
		,{ markerId="e20060_logo_101",					langId="marker_info_logo" }
		,{ markerId="e20060_logo_102",					langId="marker_info_logo" }
		,{ markerId="e20060_logo_103",					langId="marker_info_logo" }
		,{ markerId="e20060_logo_104",					langId="marker_info_logo" }
		,{ markerId="e20060_logo_105",					langId="marker_info_logo" }
		,{ markerId="e20060_logo_106",					langId="marker_info_logo" }
		,{ markerId="e20060_logo_107",					langId="marker_info_logo" }
		,{ markerId="e20060_logo_001",					langId="marker_info_logoArea" }
		,{ markerId="e20060_logo_002",					langId="marker_info_logoArea" }
		,{ markerId="e20060_logo_003",					langId="marker_info_logoArea" }
		,{ markerId="e20060_logo_004",					langId="marker_info_logoArea" }
		,{ markerId="e20060_logo_005",					langId="marker_info_logoArea" }
		,{ markerId="e20060_logo_006",					langId="marker_info_logoArea" }
		,{ markerId="e20060_logo_007",					langId="marker_info_logoArea" }
		,{ markerId="e20060_logo_008",					langId="marker_info_logoArea" }
		,{ markerId="e20060_marker_charenge01",			langId="marker_info_logoArea" }
		
		,{ markerId="common_marker_Area_HeliPort",		langId="marker_info_area_03" }					
	)

	
	TppDataUtility.SetEnableDataFromIdentifier( "id_20130417_132026_266", "20060", false )
	
	TppCharacterUtility.SetEnableCharacterId( "gntn_area01_searchLight_001",false )
	TppCharacterUtility.SetEnableCharacterId( "gntn_area01_searchLight_002",false )

	
	this.SetIntelRadio()

	
	if ( TppMission.GetFlag( "isJinmon" ) == true ) then
		removeAllJinmon()
	end

	
	local rainManager = TppRainFilterInterruptManager:GetInstance()
	rainManager:ResetStartEndFadeInDistanceDemo( 0 )

	
	TppRadioConditionManagerAccessor.Register( "Tutorial" )
	TppRadioConditionManagerAccessor.Register( "Basic", TppRadioConditionPlayerBasic{ time = 0.3 } )

end




local commonAnnounceLogMission = function( langNo ,count,max)



	local counter = nil
	local maxNum = nil
	if( count ~= nil )then
		counter = count
	end
	if( max ~= nil )then
		maxNum = max
	end

	if ( langNo ~= nil) then
		hudCommonData:AnnounceLogViewLangId( langNo ,counter,maxNum)
		
	end
end

local checkHostDoor = function()

	if( TppMission.GetFlag( "isHostageDead1" ) == true )then



		TppGadgetUtility.SetWillBeOpenedInDemo("AsyPickingDoor24", false)
	else



		TppGadgetUtility.SetWillBeOpenedInDemo("AsyPickingDoor24", true)
		TppGadgetUtility.AddDoorEnableCheckInfo("AsyPickingDoor24", Vector3(69,20,204), this.eneCheckSize_chico)
	end

	if( TppMission.GetFlag( "isHostageDead2" ) == true )then



		TppGadgetUtility.SetWillBeOpenedInDemo("Paz_PickingDoor00", false)
	else



		TppGadgetUtility.SetWillBeOpenedInDemo("Paz_PickingDoor00", true)
		TppGadgetUtility.AddDoorEnableCheckInfo("Paz_PickingDoor00", Vector3(-138, 24, -16), this.eneCheckSize_paz )
	end


end


local onDemoBlockLoad = function()
	local demoBlockPath = "/Assets/tpp/pack/mission/extra/e20060/e20060_d01.fpk"
	TppMission.LoadDemoBlock( demoBlockPath )

	TppMission.LoadEventBlock("/Assets/tpp/pack/location/gntn/gntn_heli.fpk" )

end


local IsDemoAndEventBlockActive = function()
	if ( TppMission.IsDemoBlockActive() == false ) then
		return false
	end

	if ( TppMission.IsEventBlockActive() == false ) then
		return false
	end

	if ( TppVehicleBlockControllerService.IsHeliBlockExist() ) then
		
		if ( TppVehicleBlockControllerService.IsHeliBlockActivated() == false ) then
			return false
		end
	end

	if ( MissionManager.IsMissionStartMiddleTextureLoaded() == false ) then
		return false
	end

	if hudCommonData:IsEndLoadingTips() == false then
			hudCommonData:PermitEndLoadingTips() 
			
			return false
	end

	return true

end


local commonRouteSetMissionSetup = function()

	
	
	TppCommandPostObject.GsAddDisabledRoutes( this.cpID, this.markRouteAf )

	
	
	
	

	
end





this.SearchTargetCharacterSetupCamera = function( manager, CharacterID )



	
	manager.CheckLookingTarget:AddSearchTargetEntity{				
		mode 						= "CHARACTER",					
		name						= CharacterID,					
		
		targetName					=  CharacterID,					
		
		offset 						= Vector3(-0.0,	-0.4,	1.0),	
		lookingTime					= 0.8,							
		doWideCheck					= true,							
		wideCheckRadius				= 0.60,							
		wideCheckRange				= 0.05,							
		doDirectionCheck			= true,							
		directionCheckRange			= 15.0,							
		doInMarkerCheckingMode		= false,						
		doCollisionCheck			= true,							
		doSendMessage				= true,							
		doNearestCheck				= false							
	}
end
this.SearchTargetCharacterSetupMoai = function( manager, CharacterID )



	
	manager.CheckLookingTarget:AddSearchTargetEntity{				
		mode 						= "CHARACTER",					
		name						= CharacterID,					
		targetName					=  CharacterID,					
		
		offset 						= Vector3(0,0.15,0.8),			
		lookingTime					= 1.1,							
		doWideCheck					= true,							
		wideCheckRadius				= 0.20,							
		wideCheckRange				= 0.08,							
		doDirectionCheck			= true,							
		directionCheckRange			= 90,							
		doInMarkerCheckingMode		= false,						
		doCollisionCheck			= true,							
		doSendMessage				= true,							
		doNearestCheck				= false							
	}
end

this.SearchTargetCharacterSetupHeli = function( manager, CharacterID )



	
	manager.CheckLookingTarget:AddSearchTargetEntity{				
		mode 						= "CHARACTER",					
		name						= CharacterID,					
		targetName					=  CharacterID,					
		
		offset 						= Vector3(-2.0,	0.2, 	4.0),	
		lookingTime					= 1.1,							
		doWideCheck					= true,							
		wideCheckRadius				= 1.10,							
		wideCheckRange				= 0.10,							
		doDirectionCheck			= true,							
		directionCheckRange			= 100,							
		doInMarkerCheckingMode		= false,						
		doCollisionCheck			= false,							
		doSendMessage				= true,							
		doNearestCheck				= false							
	}
end


local commonSearchTargetSetup = function( manager )



	
	manager.CheckLookingTarget:ClearSearchTargetEntities()

	
	if( TppMission.GetFlag( "isLookCamera" ) == false and TppMission.GetFlag( "isLookCameraFailed" ) == false )  then



		this.SearchTargetCharacterSetupCamera( manager, this.lookCamera )
	end

	
	if( TppMission.GetFlag( "isLookHeli" ) == false and TppMission.GetFlag( "isLookHeliFailed" ) == false )  then



		this.SearchTargetCharacterSetupHeli( manager, this.lookHeli )
	end
	
	if( TppMission.GetFlag( "isLookMoai" ) == false and TppMission.GetFlag( "isLookMoaiFailed" ) == false )  then



		this.SearchTargetCharacterSetupMoai( manager, this.lookMoai )
	end

end

local commonLookCheck = function()
	local CharacterID = TppData.GetArgument(1)

	if( CharacterID == this.lookCamera and TppMission.GetFlag( "isInCamera" ) == true and TppMission.GetFlag( "isLookCamera" )==false )then	



		this.Seq_MissionStart.FuncCheckLookCamera()

	elseif( CharacterID == this.lookMoai and TppMission.GetFlag( "isInMoai" ) == true and TppMission.GetFlag( "isLookMoai" )==false)then	



		this.Seq_MissionStart.FuncCheckLookMoai()

	elseif( CharacterID == this.lookHeli and TppMission.GetFlag( "isInHeli" ) == true and TppMission.GetFlag( "isLookHeli" )==false)then	



		this.Seq_MissionStart.FuncCheckLookHeli()

	end

end

this.SetIntelRadio = function()



	
	TppRadio.DisableIntelRadio( "WoodTurret01" )
	TppRadio.DisableIntelRadio( "WoodTurret02" )
	TppRadio.DisableIntelRadio( "WoodTurret03" )
	TppRadio.DisableIntelRadio( "WoodTurret04" )
	TppRadio.DisableIntelRadio( "WoodTurret05" )
	
	TppPlayerUtility.SetPlayerSightSearchInfoRadioEnable( "WoodTurret01", false )
	TppPlayerUtility.SetPlayerSightSearchInfoRadioEnable( "WoodTurret02", false )
	TppPlayerUtility.SetPlayerSightSearchInfoRadioEnable( "WoodTurret03", false )
	TppPlayerUtility.SetPlayerSightSearchInfoRadioEnable( "WoodTurret04", false )
	TppPlayerUtility.SetPlayerSightSearchInfoRadioEnable( "WoodTurret05", false )
end


this.commonHeliDead = function()
	commonAnnounceLogMission(langHeliDead)
	TppMission.SetFlag( "isMarkHeli", false )
	setHeliMarker()
	local sequence = TppSequence.GetCurrentSequence()
	
	if ( sequence == "Seq_PlayerRideHelicopter" ) then
		TppMission.ChangeState( "failed", "PlayerDeadOnHeli" )
	end

end






this.commonMissionFailure = function( manager, messageId, message )



	
	

	



	local uiCommonData = UiCommonDataManager.GetInstance()
	uiCommonData:SetGameOverDejavuFailed()

	local radioDaemon = RadioDaemon:GetInstance()

	TppEnemyUtility.IgnoreCpRadioCall(true)	
	TppEnemyUtility.StopAllCpRadio( 0.5 )	

	
	radioDaemon:StopDirectNoEndMessage()
	
	SubtitlesCommand.StopAll()

	
	TppSoundDaemon.SetMute( 'GameOver' )

	
	this.CounterList.GameOverFadeTime = GZCommon.FadeOutTime_MissionFailed

	
	if( message == "PlayerDead" )	then
		
		this.CounterList.GameOverRadioName = "Radio_DeadPlayer"

	
	elseif( message == "PlayerFallDead" )	then

		
		this.CounterList.GameOverRadioName = "Radio_DeadPlayer"

		
		this.CounterList.GameOverFadeTime = GZCommon.FadeOutTime_PlayerFallDead

	
	elseif( message == "MissionAreaOut" )  then

		
		GZCommon.OutsideAreaCamera()

		this.CounterList.GameOverRadioName = "Radio_MissionArea_Failed"	

		
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:CallFailedTelop( "gameover_reason_mission_outside" )	  


	elseif ( message == "PlayerHeli" ) then
		this.CounterList.GameOverRadioName = "Radio_RideHeli_Failed"	

		
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:CallFailedTelop( "gameover_reason_mission_abort" )

	end
	
	TppSequence.ChangeSequence( "Seq_MissionFailed" )

end

this.commonMissionClear = function( manager, messageId, message )
	
	TppSequence.ChangeSequence( "Seq_MissionClearDemo" )
	
	Trophy.TrophyUnlock( 2 )
end



this.commonMissionClearRadio = function()

	
	
	local Rank = PlayRecord.GetRank()

	if( Rank == 0 ) then
		Tpp.Warning( "commonMissionClearRadio:Mission not yet clear!!" )
	elseif( Rank == 1 ) then
		TppRadio.Play( "Radio_MissionClearRank_S" )
		
		Trophy.TrophyUnlock( 4 )
	elseif( Rank == 2 ) then
		TppRadio.Play( "Radio_MissionClearRank_A" )
	elseif( Rank == 3 ) then
		TppRadio.Play( "Radio_MissionClearRank_B" )
	elseif( Rank == 4 ) then
		TppRadio.Play( "Radio_MissionClearRank_C" )
	else
		TppRadio.Play( "Radio_MissionClearRank_D" )
	end

end

this.commonReturnTitle = function()



	
	TppDataUtility.SetVisibleDataFromIdentifier( "asset_base", "TestKey0", true, false )
	TppDataUtility.SetVisibleDataFromIdentifier( "asset_base", "gntn_vent001_0001", false, false )
	
	this.commonMissionCleanUp()
end

this.commonMissionCleanUp = function()
	
	GZCommon.MissionCleanup()

	
	TppRadioConditionManagerAccessor.Unregister( "Tutorial" )
	TppRadioConditionManagerAccessor.Unregister( "Basic" )

	
	GzRadioSaveData.ResetSaveRadioId()
	local radioManager = RadioDaemon:GetInstance()
	radioManager:DisableAllFlagIsMarkAsRead()
	radioManager:ResetRadioGroupAndGroupSetAlreadyReadFlag()
	
end

this.commonPlayerRideHeli = function()
		
		TppRadio.Play( "Radio_MissionAbort_Warning")
		
		TppSupportHelicopterService.SetEnableGetOffTime( GZCommon.WaitTime_HeliTakeOff )
end

this.commonHeliTakeOff = function()
	TppMission.SetFlag( "isHeliComming", false )

	local isPlayer = TppData.GetArgument(3)
	
	if ( isPlayer == true ) then
		TppSequence.ChangeSequence( "Seq_PlayerRideHelicopter" )	
	end
end

this.commonHeliDamagedByPlayer = function()
	local radioDaemon = RadioDaemon:GetInstance()

	if ( radioDaemon:IsPlayingRadio() == false ) then
		
		TppRadio.PlayEnqueue( "Miller_HeliAttack" )
	end
end


this.OnShowRewardPopupWindow = function()




	
	local hudCommonData = HudCommonDataManager.GetInstance()
	local challengeString = PlayRecord.GetOpenChallenge()
	local uiCommonData = UiCommonDataManager.GetInstance()
	local AllHardClear = PlayRecord.IsAllMissionClearHard()
	local AllChicoTape = GZCommon.CheckReward_AllChicoTape()
	local Rank = PlayRecord.GetRank()

	
	local RewardAllCount = uiCommonData:GetRewardAllCount( this.missionID )



	
	hudCommonData:SetBonusPopupCounter( this.tmpRewardNum, RewardAllCount )

	
	
	while ( challengeString ~= "" ) do




		
		hudCommonData:ShowBonusPopupCommon( challengeString )
		
		challengeString = PlayRecord.GetOpenChallenge()
	end

	
	while ( Rank < this.tmpBestRank ) do




		this.tmpBestRank = ( this.tmpBestRank - 1 )
		if ( this.tmpBestRank == 4 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankC, "WP_hg02_v00" )
		elseif ( this.tmpBestRank == 3 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankB, "WP_sr01_v00" )
		elseif ( this.tmpBestRank == 2 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankA, "WP_ms02" )
		elseif ( this.tmpBestRank == 1 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankS, "WP_ar00_v05", { isBarrel=true } )
		end
	end

	
	
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
		PlayRecord.GetMissionScore( 20060, "NORMAL", "CLEAR_COUNT" ) == 1 then	

		hudCommonData:ShowBonusPopupCommon( "reward_extreme" )						

	end

	if ( TppMission.GetFlag( "isNinjaReward" ) == true ) then
			



			hudCommonData:ShowBonusPopupCommon( "reward_open_raiden_b_20060" )
	end

	
	if ( hudCommonData:IsShowBonusPopup() == false ) then



		TppSequence.ChangeSequence( "Seq_MissionEnd" )	
	end

end


this.commonOnLaidEnemy = function()

	local sequence				= TppSequence.GetCurrentSequence()
	local EnemyCharacterID		= TppData.GetArgument(1)
	local VehicleCharacterID	= TppData.GetArgument(3)
	local EnemyLife				= TppEnemyUtility.GetLifeStatus( EnemyCharacterID )





	
	if ( EnemyLife ~= "Dead" ) then
		
		if( VehicleCharacterID == "SupportHelicopter" ) then
			
			TppRadio.DelayPlay( "Radio_HostageOnHeli", "short" )	




			local check = string.find(EnemyCharacterID, "genom")

			if( check == 1 ) then



				
				PlayRecord.RegistPlayRecord( "SOLDIER_RESCUE", "GenomeSoldier_Save" )
			end
		
		else
			
		end
	end
end


local commonPhotoMissionSetup = function()
	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager == NULL then
			return
	end
	local luaData = commonDataManager:GetUiLuaExportCommonData()
	if luaData == NULL then
			return
	end

	luaData:EnableMissionPhotoId(10)
	luaData:EnableMissionPhotoId(20)
	luaData:EnableMissionPhotoId(30)
	luaData:EnableMissionPhotoId(50)
	luaData:EnableMissionPhotoId(60)
	luaData:EnableMissionPhotoId(40)
	luaData:EnableMissionPhotoId(70)

end



this.ChangeAntiAir = function()
	
	local status = TppData.GetArgument(2)
	
	if ( status == true ) then
		
		GZCommon.CallCautionSiren()
	
	else
		
		GZCommon.StopSirenNormal()
	end
end

this.commonOnAlert = function()
	
	GZCommon.CallAlertSirenCheck()
	
	local radioDaemon = RadioDaemon:GetInstance()
	radioDaemon:DisableFlagIsCallCompleted( "e0060_oprg9020" )
end

this.commonOnEvasion = function()
	
	GZCommon.StopAlertSirenCheck()
	
	local radioDaemon = RadioDaemon:GetInstance()
	radioDaemon:DisableFlagIsCallCompleted( "e0060_oprg9010" )
end


this.commonOnCaution = function()
	
	GZCommon.StopAlertSirenCheck()
	
	local radioDaemon = RadioDaemon:GetInstance()
	radioDaemon:DisableFlagIsCallCompleted( "e0060_oprg9020" )
end


local commonDisablePhoto = function( flagName )



	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager == NULL then
			return
	end
	local luaData = commonDataManager:GetUiLuaExportCommonData()
	if luaData == NULL then
			return
	end

	local flagNum = 0
	local langNo = 0
	local intel = ""

	
	if (flagName == "isLookHeli")then
		flagNum = 10
		langNo = langHeli
		intel = "radio_homage_heli"
	elseif (flagName == "isGetChaffCase")then
		flagNum = 20
		langNo = langChaff
		intel = "radio_homage_chaff"
	elseif (flagName == "isLookCamera")then
		flagNum = 30
		langNo = langCamera
		intel = "radio_homage_camera"
	elseif (flagName == "isLookMoai" )then
		flagNum = 50
		langNo = langMoai
		intel = "radio_homage_moai"
	elseif (flagName == "isBombTank")then
		flagNum = 60
		langNo = langTank
		intel = "radio_homage_tank"
	elseif (flagName == "isRunVehicle")then
		flagNum = 40
		langNo = langVehicle
	elseif (flagName == "isTurnOffPanel")then
		flagNum = 70
		langNo = langSwitch
	end

	
	luaData:SetCompleteMissionPhotoId(flagNum, true)
	commonAnnounceLogMission(langNo)

	
	if( intel ~= "" )then



		TppRadio.DisableIntelRadio( intel )
	end

end


local checkVehicleRide = function()
	local vehicle	=	TppData.GetArgument(1)
	local VehicleID = TppData.GetArgument(2)




	if ( vehicle == "Tactical_Vehicle_WEST") then
		TppRadio.Play( "neta_vehicle" )
	end
	if VehicleID == "WheeledArmoredVehicleMachineGun" then						
		if( TppMission.GetFlag( "isAVMTutorial" ) == false ) then				
			local hudCommonData = HudCommonDataManager.GetInstance()
			hudCommonData:CallButtonGuide( "tutorial_apc", fox.PAD_SELECT )
			TppMission.SetFlag( "isAVMTutorial", true )							
		end
	elseif VehicleID == "SupportHelicopter" then
		
	else

			
			local hudCommonData = HudCommonDataManager.GetInstance()
			hudCommonData:CallButtonGuide( "tutorial_accelarater", "VEHICLE_TRIGGER_ACCEL" )
			
			local hudCommonData = HudCommonDataManager.GetInstance()
			hudCommonData:CallButtonGuide( "tutorial_brake", "VEHICLE_TRIGGER_BREAK" )
			TppMission.SetFlag( "isCarTutorial", true )							

	end

end


local ratEscape = function()

	local characters = Ch.FindCharacters( "Rat" )
	for i=1, #characters.array do
		local chara = characters.array[i]
		local plgAction = chara:FindPlugin("TppRatActionPlugin")
		plgAction:SetForceEscape()
	end
	TppRadio.Play( "Call_rat" )

end

local ibikiOnOff = function( flag )


	if( flag == true )then



		local daemon = TppSoundDaemon.GetInstance()
		daemon:RegisterSourceEvent{
						sourceName = 'Source_tanksleep',
						tag = "Loop",
						playEvent = 'sfx_m_e20060_tank_sleep',
						stopEvent = 'Stop_sfx_m_e20060_tank_sleep',
		}

	elseif( flag == false )then



		local daemon = TppSoundDaemon.GetInstance()
		daemon:UnregisterSourceEvent{
						sourceName = 'Source_tanksleep',
						tag = "Loop",
						playEvent = 'sfx_m_e20060_tank_sleep',
				stopEvent = 'Stop_sfx_m_e20060_tank_sleep',
		}
	end

end


local tankOpen = function( flag )



	local vehicleObject = Ch.FindCharacterObjectByCharacterId( "Armored_Vehicle_WEST_001" )
	if( vehicleObject ~= nil ) then
		local vehicleCharacter = vehicleObject:GetCharacter()
		local plgBasicAction = vehicleCharacter:FindPluginByName( "TppStrykerBasicAction" )

		
		plgBasicAction:SetBoneRotation( Vector3( -130, 0, 0 ) )

		if( TppMission.GetFlag( "isBombTankFailed" ) == false and TppMission.GetFlag( "isBombTank" ) == false )then



			
			plgBasicAction:AddDefenseTargetResponsiveToGrenadeHit( "SKL_011_HATCHL1", Vector3( 0.0, -0.65, 0.3 ), 0.8 )
			
			ibikiOnOff(true)
		else
			
			plgBasicAction:RemoveDefenseTargetResponsiveToGrenadeHit()
			ibikiOnOff(false)
		end
	else
		ibikiOnOff(false)
	end
end

this.damageTank = function()
	local vehicleObject = Ch.FindCharacterObjectByCharacterId( "Armored_Vehicle_WEST_001" ) 

	if( vehicleObject ~= nil ) then
		local vehicle = vehicleObject:GetCharacter()
		local plgLife = vehicle:FindPluginByName( "Life" ) 

		local life = 5000
		
		plgLife:RequestSetLife( "Life", life )
		vehicle:SendMessage( ChDamageActionRequest() )
	end
end

local getDemoStartPos = function( demoId )



	if( demoId ~= nil )then



		local body = DemoDaemon.FindDemoBody( demoId )
		local data = body.data
		local controlCharacters = data.controlCharacters
		for k, controlCharacter in pairs(controlCharacters) do
			local characterId = controlCharacter.characterId



			local translation = controlCharacter.startTranslation



			local rotation = controlCharacter.startRotation



			
			if( characterId == "Player")then

				local direction = rotation:Rotate( Vector3( 0.0, 0.0, 1.0 ) )
				local angle = foxmath.Atan2( direction:GetX(), direction:GetZ() )
				local degree = foxmath.RadianToDegree( angle )

				return translation, degree
			end
		end
	end
end


local PhaseCheck = function()



	local phase = TppEnemy.GetPhase( this.cpID )
	if( phase == "alert")then



		return false
	else



		return true
	end
end


local hint_radio = function()



	
	local radioDaemon = RadioDaemon:GetInstance()

	
	if ( radioDaemon:IsPlayingRadio() == false and PhaseCheck() == true) then
		TppRadio.Play( "Answer_near" )
	end
end


local checkEnemyStatusAndPositon = function()



	
	local checkPos0 = TppData.GetPosition( "check_enePos0000" )
	local checkPos1 = TppData.GetPosition( "check_enePos0001" )

	local checkSize = Vector3(5, 5, 5)
	
	local eneCheck0 = TppEnemyUtility.GetNumberOfActiveSoldierByBoxShape( checkPos0,checkSize )
	local eneCheck1 = TppEnemyUtility.GetNumberOfActiveSoldierByBoxShape( checkPos1,checkSize )

	
	local eneCheck = eneCheck0 * eneCheck1









	if( eneCheck == 0 )then
		return 0
	else
		return 1
	end

end

local chengeRouteSneak = function( warp )
	if( warp == "warp" )then



		TppCommandPostObject.GsSetCurrentRouteSet( "gntn_cp", "TppRouteSet_n", true, true, true, true )
	else



		TppCommandPostObject.GsSetCurrentRouteSet( "gntn_cp", "TppRouteSet_n", false, false, false, false )
	end
	if( TppMission.GetFlag( "isRouteSerch1" ) )then



		TppCommandPostObject.GsAddDisabledRoutes( "gntn_cp", "GsRouteData", false )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0006"		, 0, "USSArmmy_000", "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0006"		, 0, "genom_006", "ROUTE_PRIORITY_TYPE_FORCED" )
	else
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData"		, 0, "USSArmmy_000", "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData"		, 0, "genom_006", "ROUTE_PRIORITY_TYPE_FORCED" )
	end
	if( TppMission.GetFlag( "isRouteSerch2" ) )then



		TppCommandPostObject.GsAddDisabledRoutes( "gntn_cp", "GsRouteData0000", false )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0001"	, 0, "USSArmmy_001", "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0001"	, 0, "genom_007", "ROUTE_PRIORITY_TYPE_FORCED" )
	else
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0000"	, 0, "USSArmmy_001", "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0000"	, 0, "genom_007", "ROUTE_PRIORITY_TYPE_FORCED" )
	end
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n",  "GsRouteData0002"	, 0, "USSArmmy_008" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0002"	, 0, "genom_002"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n",  "GsRouteData0003"	, 0, "USSArmmy_006" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0003"	, 0, "genom_011"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n",  "GsRouteData0004"	, 0, "USSArmmy_005" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0004"	, 0, "genom_010"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n",  "GsRouteData0005"	, 0, "USSArmmy_004" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0005"	, 0, "genom_001"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n",  "GsRouteData0006"	, 0, "USSArmmy_003" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0006"	, 0, "genom_000"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n",  "GsRouteData0007"	, 0, "USSArmmy_002" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0007"	, 0, "genom_005"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n",  "GsRouteData0008"	, 0, "USSArmmy_025" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0008"	, 0, "genom_013"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n",  "GsRouteData0009"	, 0, "USSArmmy_024" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0009"	, 0, "genom_012"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n",  "GsRouteData0010"	, 0, "USSArmmy_012" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0010"	, 0, "genom_015"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	if( TppMission.GetFlag( "isRouteSerch3" ) )then



		TppCommandPostObject.GsAddDisabledRoutes( "gntn_cp", "GsRouteData0010_serch", false )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n",  "GsRouteData0009"	, 0, "USSArmmy_026" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0009"	, 0, "genom_014"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	else
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n",  "GsRouteData0010_serch"	, 0, "USSArmmy_026" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0010_serch"	, 0, "genom_014"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	end

	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n",  "GsRouteData0011"	, 0, "USSArmmy_010" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0011"	, 0, "genom_009"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n",  "GsRouteData0012"	, 0, "USSArmmy_007" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0012"	, 0, "genom_008"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n",  "GsRouteData0013"	, 0, "USSArmmy_011" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0013"	, 0, "genom_004"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	if( TppMission.GetFlag( "isGetWeapon" ) )then
		 TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0001_mark"	, 0, "USSArmmy_009", "ROUTE_PRIORITY_TYPE_FORCED" )
		 TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0001_mark"	, 0, "genom_003", "ROUTE_PRIORITY_TYPE_FORCED" )
	else
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0001"	, 0, "USSArmmy_009", "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_n", "GsRouteData0001"	, 0, "genom_003", "ROUTE_PRIORITY_TYPE_FORCED" )
	end
end

local chengeRouteCaution = function()



	TppCommandPostObject.GsSetCurrentRouteSet( "gntn_cp", "TppRouteSet_c", false, false, false, false )
	if( TppMission.GetFlag( "isRouteSerch1" ) )then



		TppCommandPostObject.GsAddDisabledRoutes( "gntn_cp", "GsRouteData", false )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0016"		, 0, "USSArmmy_000", "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0016"		, 0, "genom_006", "ROUTE_PRIORITY_TYPE_FORCED" )
	else
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData"		, 0, "USSArmmy_000", "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData"		, 0, "genom_006", "ROUTE_PRIORITY_TYPE_FORCED" )
	end
	if( TppMission.GetFlag( "isRouteSerch2" ) )then



		TppCommandPostObject.GsAddDisabledRoutes( "gntn_cp", "GsRouteData0000", false )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0015"	, 0, "USSArmmy_001", "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0015"	, 0, "genom_007", "ROUTE_PRIORITY_TYPE_FORCED" )
	else
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0000"	, 0, "USSArmmy_001", "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0000"	, 0, "genom_007", "ROUTE_PRIORITY_TYPE_FORCED" )
	end
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0015"	, 0, "USSArmmy_008" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0015"	, 0, "genom_002"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0022"	, 0, "USSArmmy_006" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0022"	, 0, "genom_011"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0022"	, 0, "USSArmmy_005" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0022"	, 0, "genom_010"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0018"	, 0, "USSArmmy_004" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0018"	, 0, "genom_001"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0017"	, 0, "USSArmmy_003" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0017"	, 0, "genom_000"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0014"	, 0, "USSArmmy_002" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0014"	, 0, "genom_005"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0024"	, 0, "USSArmmy_025" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0024"	, 0, "genom_013"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0023"	, 0, "USSArmmy_024" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0023"	, 0, "genom_012"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0021"	, 0, "USSArmmy_012" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0021"	, 0, "genom_015"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	if( TppMission.GetFlag( "isRouteSerch3" ) )then



		TppCommandPostObject.GsAddDisabledRoutes( "gntn_cp", "GsRouteData0010_serch", false )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0023"	, 0, "USSArmmy_026" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0023"	, 0, "genom_014"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	else
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0010_serch"	, 0, "USSArmmy_026" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0010_serch"	, 0, "genom_014"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	end
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0019"	, 0, "USSArmmy_010" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0019"	, 0, "genom_009"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0020"	, 0, "USSArmmy_007" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0020"	, 0, "genom_008"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0014"	, 0, "USSArmmy_011" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0014"	, 0, "genom_004"	, "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0016"	, 0, "USSArmmy_009", "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "TppRouteSet_c", "GsRouteData0016"	, 0, "genom_003", "ROUTE_PRIORITY_TYPE_FORCED" )
end


local routeSetChangeFromSerchLight = function()



	local phase = TppEnemy.GetPhase( "gntn_cp" )
	if ( phase == "sneak" ) then
		chengeRouteSneak()
	else
		chengeRouteCaution()
	end
end


local FuncEventFailed = function( flag1)
	local flag2 = flag1.."Failed"
	local chara = TppData.GetArgument( 1 )







	
	if ( chara == "gntn_serchlight_20060_1" ) then



		TppMission.SetFlag( "isRouteSerch1", true )
		routeSetChangeFromSerchLight()
	elseif ( chara == "gntn_serchlight_20060_2" ) then



		TppMission.SetFlag( "isRouteSerch2", true )
		routeSetChangeFromSerchLight()
	end

	if ( TppMission.GetFlag( flag1 ) == false and TppMission.GetFlag( flag2 ) == false) then



		
		TppMission.SetFlag( flag2, true )
		
		local phase = TppEnemy.GetPhase( this.cpID )
		if( phase == "sneak")then
			TppRadio.DelayPlay( "Answer_failed","long" ,{onEnd = function()	TppRadio.Play( "Answer_failedTo" ) end} ) 
		else
			TppRadio.DelayPlay( "Answer_failedAlert","long" ,{onEnd = function()	TppRadio.Play( "Answer_failedTo" ) end} ) 
		end

	end

	if( flag1 == "isBombTank" )then



		tankOpen("close")
	end

	if( flag1 == "isLookMoai" )then



		
		local position = Vector3( -158.456, 26.300, -52.760 )
		TppSoundDaemon.PostEvent3D( 'sfx_m_e20060_moai', position )
	end

	if ( flag1 == "isLookHeli" ) then



		TppMission.SetFlag( "isHeliBreak", true )
		heliWindowEffect()
	end

	local intel = ""
	
	if (flag1 == "isLookHeli")then
		intel = "radio_homage_heli"
	elseif (flag1 == "isGetChaffCase")then
		intel = "radio_homage_chaff"
	elseif (flag1 == "isLookCamera")then
		intel = "radio_homage_camera"
	elseif (flag1 == "isLookMoai" )then
		intel = "radio_homage_moai"
	elseif (flag1 == "isBombTank")then
		intel = "radio_homage_tank"
	end

	
	if( intel ~= "" )then



		TppRadio.DisableIntelRadio( intel )
	end






end


local FuncNearRadio = function( flag1,type)
	
	local failed = flag1.."Failed"
	local photo = flag1.."Photo"

	if( TppMission.GetFlag( flag1 ) == false and TppMission.GetFlag( failed ) == false) then




		if( type == "near" )then
			if ( TppMission.GetFlag( photo ) == true ) then



			
			hint_radio()
			end
		else



		end
	end
end


local challengeChancel = function()



	if ( TppMission.GetFlag( "isMarkMGS3" ) == false )then

		local mark = PlayRecord.IsMissionChallenge( "DELETE_XOF_MARK" )
		if mark == true then
			
			PlayRecord.UnsetMissionChallenge( "DELETE_XOF_MARK" )
		end
	end

	TppMission.SetFlag( "isBreakWood", true )
	
	TppCharacterUtility.SetEnableCharacterId( "e20060_logo_008", false )

end

local challengeChancelFox = function()



	if( TppMission.GetFlag( "isMakeFox" ) == false )then

		local mark = PlayRecord.IsMissionChallenge( "CREATE_FOX_MARK" )
		if mark == true then
			
			PlayRecord.UnsetMissionChallenge( "CREATE_FOX_MARK" )
		end
	end
end

local challengeChancelLA = function()



	if( TppMission.GetFlag( "isMakeLA" ) == false )then



		TppMission.SetFlag( "isRouteSerch3", true )
		routeSetChangeFromSerchLight()

		local mark = PlayRecord.IsMissionChallenge( "CREATE_FOX_MARK" )
		if mark == true then
			
			PlayRecord.UnsetMissionChallenge( "CREATE_FOX_MARK" )
		end
	end
end




local EventClearRadio = function(flagName,checkPointId)

		local voice = ""
		local radioId = ""
		local delay = "short" 

		
		
		if (flagName == "isLookHeli")then
			voice = "Sneak_Natsui00"
		elseif (flagName == "isGetChaffCase" )then
			voice = "Sneak_Natsui01"
		elseif (flagName == "isLookMoai" )then
			voice = "Sneak_Natsui03"
		elseif (flagName == "isBombTank" )then
			voice = "Sneak_Natsui02"
		end

		
		if( TppMission.GetFlag( "isClear" ) == false ) then



			TppMission.SetFlag( "isClear", true)
			
			radioId = "fondHomage1"

			
			TppMarkerSystem.EnableMarker{ markerId="e20060_marker_GoalPoint", viewType="VIEW_MAP_GOAL" }

			commonAnnounceLogMission("announce_mission_goal")
			commonAnnounceLogMission("announce_mission_info_update")

			
			commonSetOptRadio()

			
			commonChangeMissionSubGoal()
			
			TppDataUtility.SetVisibleDataFromIdentifier( "asset_base", "TestKey0", false, false )
			TppDataUtility.SetVisibleDataFromIdentifier( "asset_base", "gntn_vent001_0001", true, false )
			
		else
			



			radioId = "fondHomage2"

		end

		
		if (	TppMission.GetFlag( "isLookHeli" ) == true and
				TppMission.GetFlag( "isGetChaffCase" ) == true and
				TppMission.GetFlag( "isLookCamera" ) == true and
				TppMission.GetFlag( "isLookMoai" ) == true and
				TppMission.GetFlag( "isBombTank" ) == true and
				TppMission.GetFlag( "isRunVehicle" ) == true and
				TppMission.GetFlag( "isTurnOffPanel" ) == true
			) then



			
			radioId = "complateHomage"
			delay = "long"

			TppMission.SetFlag( "isClearComp", true)
			
			commonSetOptRadio()
			
			TppMusicManager.PostJingleEvent( 'SuspendPhase', 'Play_bgm_e20060_jingle_item' )
			
		end

		
		if( voice ~= "" )then



			if ( delay ~= "long" ) then 



				TppRadio.DelayPlay( voice, delay, "none" )
			end
		end


		







		TppRadio.DelayPlayEnqueue( radioId,delay,"both" )

		
		TppMissionManager.SaveGame(checkPointId)
end


local clearFlagCheck = function( flagName,checkPointId )



	
	local count = TppMission.GetFlag( "isCountClear" )
	count = count+1
	TppMission.SetFlag( "isCountClear", count )




	
	commonDisablePhoto( flagName )

	EventClearRadio(flagName,checkPointId)

	if( flagName == "isBombTank" )then
		
		this.damageTank()
	end

	if( flagName == "isTurnOffPanel") then
		
		TppDataUtility.SetEnableDataFromIdentifier( "gntn_Trap", "SwitchLightArea", true , false )
	end

	
	PlayRecord.PlusExternalScore( 5000 )

	
	WeatherManager.RequestTag("default", 0 )

	
	if(flagName == "isLookHeli")then
		chengeRouteSneak()
	else
		chengeRouteSneak("warp")
	end

	TppUI.FadeIn(0)
end


local playerPositonSetForDemo = function(r)




	
	

end


local notRealizeCharacter = function(route)



	
	

	local eneId1,eneId2 = TppEnemyUtility.GetCharacterIdByRoute( this.cpID, route )
	if ( eneId1 ~= nil)then



		MissionManager.RegisterNotInGameRealizeCharacter( eneId1 )
	end
	if ( eneId2 ~= nil)then



		MissionManager.RegisterNotInGameRealizeCharacter( eneId2 )
	end

end



local playDemoForHomage = function( demoName, flagName,checkPointId,r )




	
	if ( r ~= nil ) then



		playerPositonSetForDemo(r)
	end

	GZCommon.StopAlertSirenCheck()




	if( TppMission.GetFlag( flagName ) == false  ) then
		TppMission.SetFlag( flagName, true)


		if( flagName == "isLookHeli" )then



			notRealizeCharacter("GsRouteData0013")
			notRealizeCharacter("GsRouteData0007")
		end
		if( flagName == "isLookCamera" )then



			notRealizeCharacter("GsRouteData0002")
		end

		
		local demoInterpCameraId = this.DemoList[demoName]



		TppDemoUtility.Setup(demoInterpCameraId)

		TppDemo.Play( demoName,{onEnd = function() clearFlagCheck(flagName,checkPointId) end} )
	end

end


local commonMbDvcActWatchPhoto = function()

	local PhotoID = TppData.GetArgument(1)
	local radioNum = ""
	local flagNum = ""
	local intel = ""





	if( PhotoID == 10 ) then
		if( TppMission.GetFlag( "isLookHeli" ) == false )then 
			radioNum = "Hint_heli"
			flagNum = "isLookHeliPhoto"
			intel = "radio_homage_heli"
		end
	elseif( PhotoID == 20 ) then
		if(TppMission.GetFlag( "isGetChaffCase" ) == false)then 
			radioNum = "Hint_chaff"
			flagNum = "isGetChaffCasePhoto"
			intel = "radio_homage_chaff"
		end
	elseif( PhotoID == 30 ) then
		if( TppMission.GetFlag( "isLookCamera" ) == false )then 
			radioNum = "Hint_camera"
			flagNum = "isLookCameraPhoto"
			intel = "radio_homage_camera"
		end
	elseif( PhotoID == 40 ) then
		if( TppMission.GetFlag( "isRunVehicle" ) == false )then 
			radioNum = "Hint_vehicle"
			flagNum = "isRunVehiclePhoto"
		end
	elseif( PhotoID == 50 ) then
		if( TppMission.GetFlag( "isLookMoai" ) == false )then 
			radioNum = "Hint_moai"
			flagNum = "isLookMoaiPhoto"
			intel = "radio_homage_moai"
		end
	elseif( PhotoID == 60 ) then
		if( TppMission.GetFlag( "isBombTank" ) == false )then 
			radioNum = "Hint_tank"
			flagNum = "isBombTankPhoto"
			
		end
	elseif( PhotoID == 70 ) then
		if( TppMission.GetFlag( "isTurnOffPanel" ) == false )then 
			radioNum = "Hint_switch"
			flagNum = "isTurnOffPanelPhoto"
		end
	end

	
	if ( intel ~= "") then
		TppRadio.EnableIntelRadio( intel )
	end

	if( radioNum == "Hint_switch" )then
		
		if( TppMission.GetFlag( "isTurnOffPanelPhoto" ) == false )then
			TppRadio.Play( "Hint_switch0")
			TppMission.SetFlag( "isTurnOffPanelPhoto", true )
		else
			TppRadio.Play( "Hint_switch" )

		end
	elseif ( radioNum ~= nil) then 
		
		TppRadio.Play( radioNum )
		
		TppMission.SetFlag( flagNum, true )
	end

end


local charengeClaymoreCount = function()
	if(TppData.GetArgument( 1 ) == "WP_Claymore")then

		
		local crymore = PlayRecord.IsMissionChallenge( "CLAYMORE_RECOVERY" )
		if crymore == true then

			local count = TppMission.GetFlag( "isCountClaymore" )
			count = count + 1
			TppMission.SetFlag( "isCountClaymore", count )

			commonAnnounceLogMission("announce_allGetClaymore",	count,	5)

			
			if (count == 5) then
				PlayRecord.RegistPlayRecord( "CLAYMORE_RECOVERY" )
			end
		end

	end

end


local charengeClaymorePut = function()
	if(TppData.GetArgument( 1 ) == "WP_Claymore")then

		local count = TppMission.GetFlag( "isCountClaymore" )
		count = count - 1
		if ( count < -9 ) then
			count = -9
		end
		TppMission.SetFlag( "isCountClaymore", count )
	end
end





local checkPickUpAmmo = function()



	if(TppData.GetArgument( 1 ) == "WP_SmokeGrenade" )then
		

		local cPos = TppData.GetPosition( "check_pos" )
		local player = Ch.FindCharacterObjectByCharacterId( "Player")
		local pPos = player:GetPosition()

		local dist = TppUtility.FindDistance( pPos, cPos )




		
		if( dist < 10 )then



			
			if( TppMission.GetFlag( "isGetChaffCase" ) == false and TppMission.GetFlag( "isGetChaffCaseFailed" ) == false ) then



				local phase = TppEnemy.GetPhase( this.cpID )
				if( phase == "alert")then
					



					FuncEventFailed("isGetChaffCase")
				else
					



					playDemoForHomage( "Demo_FlashGetChaffCase", "isGetChaffCase","1200" )
				end
			end
		end
	elseif (TppData.GetArgument( 1 ) == "WP_ar00_v03b" ) then
		
		if( TppMission.GetFlag( "isGetWeapon" ) == false )then
			TppRadio.Play( "Metal_mistakeGun" )
			TppMission.SetFlag( "isGetWeapon", true )
			TppEffect.HideEffect( "fx_weaponLight")
			



			TppCommandPostObject.GsDeleteDisabledRoutes( 	this.cpID, this.markRouteAf )
			TppCommandPostObject.GsAddDisabledRoutes( 		this.cpID, this.markRouteBe )
		end


	elseif (TppData.GetArgument( 1 ) == this.trackWeapon1 ) then
		
		TppMission.SetFlag( "isGetHandGun", true )

	elseif (TppData.GetArgument( 1 ) == this.trackWeapon2 ) then
		
		
		TppMission.SetFlag( "isGetShotGun", true )

	end
end


local findTitleLogoMark = function(num)




	if( num ~= 10 ) then
		
		local count = TppMission.GetFlag( "isCountTitleLogo" )
		count = count + 1
		if (count >= 8) then
			count = 8
		end
		TppMission.SetFlag( "isCountTitleLogo", count )

		local text = "debug "..count




		
		if ( count == logoMax ) then
			
			TppMission.SetFlag( "isTitleComp", true )

			TppRadio.Play( "Metal_allClear")
			
			TppRadio.DelayPlayEnqueue( "Metal_Clear", "mid" )

			



			removeAllJinmon()

			local mark = PlayRecord.IsMissionChallenge( "DELETE_XOF_MARK" )
			if mark == true then
				
				commonAnnounceLogMission(langXOF,8,logoMax)
				
				PlayRecord.RegistPlayRecord( "DELETE_XOF_MARK" )
			end
		else



			local mark = PlayRecord.IsMissionChallenge( "DELETE_XOF_MARK" )
			if mark == true then



				
				commonAnnounceLogMission(langXOF,count,logoMax)
			end
			
			TppRadio.DelayPlay( "Metal_int","short" )
		end

		
		local disMark = "e20060_logo_00"..num




		TppMarkerSystem.DisableMarker{ markerId=disMark }
		



		local characterId = ""
		local characterIdLow = ""

		
		local flagID = ""
		local locatorID = ""
		if( num == 1)then
			flagID = "isMarkMGSPW"
			characterId, characterIdLow = "USSArmmy_000","genom_006"
		elseif( num == 2)then
			locatorID = "intelMark_mgs"
			flagID = "isMarkMGS"
			characterId, characterIdLow = "USSArmmy_011","genom_004"
		elseif( num == 3)then
			locatorID = "intelMark_mg"
			flagID = "isMarkMG"
			characterId, characterIdLow = "USSArmmy_007","genom_008"
		elseif( num == 4)then
			locatorID = "intelMark_mgs4"
			flagID = "isMarkMGS4"
			characterId, characterIdLow = "USSArmmy_009","genom_003"
		elseif( num == 5)then
			locatorID = "intelMark_mgs2"
			flagID = "isMarkMGS2"
			characterId, characterIdLow = "USSArmmy_012","genom_015"
		elseif( num == 6)then
			locatorID = "intelMark_gz"
			flagID = "isMarkGZ"
			characterId, characterIdLow = "USSArmmy_002","genom_005"
		elseif( num == 7)then
			locatorID = "intelMark_mg2"
			flagID = "isMarkMG2"
			characterId, characterIdLow = "USSArmmy_024","genom_012"
		elseif( num == 8)then
			locatorID = "intelMark_mgs3"
			flagID = "isMarkMGS3"
			characterId, characterIdLow = "USSArmmy_005","genom_010"
		end
		
		TppMission.SetFlag( flagID, true )
		
		TppRadio.DisableIntelRadio( locatorID )
		
		setHeliMarker()
	else
		
		TppRadio.Play( "Metal_wrong" )
	end
end




local findFoxLogo = function()
	if( TppMission.GetFlag( "isMakeFox" ) == false and TppMission.GetFlag( "isMakeLA" ) == false )then
		TppRadio.Play( "Light_near" )
	end
end


local highlightFoxLogo = function(type)



	

	if ( PhaseCheck() == true ) then




		local demo = ""
		local radio = ""
		local flag = ""
		if( type == "fox" and TppMission.GetFlag( "isMakeFox" ) == false )then
			flag = "isMakeFox"
			radio = "Light_clear"
			demo = "Demo_FoxLightKJP"

		elseif(type=="la" and TppMission.GetFlag( "isMakeLA" ) == false)then
			flag = "isMakeLA"
			radio = "Light_clearLA"
			demo = "Demo_FoxLightLA"
		end

		local onDemoStart = function()
		end
		local onDemoEnd = function()



			TppMission.SetFlag( flag, true )

			if (TppMission.GetFlag( "isMakeLA" ) == true and TppMission.GetFlag( "isMakeFox" ) == true) then
				



				
				local mark = PlayRecord.IsMissionChallenge( "CREATE_FOX_MARK" )
				if mark == true then
					commonAnnounceLogMission(langMarkLA)
					PlayRecord.RegistPlayRecord( "CREATE_FOX_MARK" )
				end
			elseif (TppMission.GetFlag( "isMakeLA" ) == true or TppMission.GetFlag( "isMakeFox" ) == true) then
				local mark = PlayRecord.IsMissionChallenge( "CREATE_FOX_MARK" )
				if mark == true then
					commonAnnounceLogMission(langMark)
				end
			end

		   
		end

		if( demo ~= "")then



			TppDemo.Play( demo ,{ onStart = onDemoStart, onEnd = onDemoEnd},{
			  disableGame = false,			
			  disableDamageFilter = false,	
			  disableDemoEnemies = false,	
			  disableHelicopter = false,	
			  disablePlacement = false, 	
			  disableThrowing = false	 
			})
			TppGameStatus.Set("TppDemo.lua","S_DISABLE_PLAYER_PAD")
		end

	TppRadio.DisableIntelRadio( "radio_kjpLogo" )
		
	end
end


local DamagedOnClaymore = function()
	



	if( (TppData.GetArgument( 1 ) == "WP_Claymore" ) and TppMission.GetFlag( "isFailedClaymore" ) == false) then

		local crymore = PlayRecord.IsMissionChallenge( "CLAYMORE_RECOVERY" )
		if crymore == true then



			
			TppMission.SetFlag( "isFailedClaymore", true )
			
			PlayRecord.UnsetMissionChallenge( "CLAYMORE_RECOVERY" )
		end
	end
end


local Common_PickUpItem = function()
	
	if TppData.GetArgument( 1 ) == "IT_Cassette" then



		local uiCommonData = UiCommonDataManager.GetInstance()
		uiCommonData:GetBriefingCassetteTape( "tp_bgm_04" )
	end
end

this.Common_DoorOpen = function()



	TppGadgetUtility.SetDoor{ id = "Paz_PickingDoor00", isVisible = true, isEnableBounder = true, isEnableTacticalActionEdge = true , angle = -90, isOpen = true }
end

this.Common_DoorUnlock = function( flag )




	local id = TppData.GetArgument( 1 )

	if ( id == "AsyPickingDoor24" and TppMission.GetFlag( "isHostageDead1" ) == true )then
		
		flag = "chico"
	end
	if ( id == "Paz_PickingDoor00" and TppMission.GetFlag( "isHostageDead2" ) == true and TppMission.GetFlag( "isPazDoor" ) == false )then
		
		TppMission.SetFlag( "isPazDoor", true )
		flag = "paz"
	end


	if(    id == "Asy_PickingDoor"
		or id == "AsyPickingDoor01"
		or id == "AsyPickingDoor17"
		or id == "AsyPickingDoor21"
		or id == "StartCliff_PickingDoor01"
		or id == "WareHousePickingDoor01"
		or id == "Center_PickingDoor01"
		or id == "Center_PickingDoor02"
		or id == "WP_HouseDoor01"
		or id == "WP_HouseDoor02"
		or id == "WP_HouseDoor03"
		or flag == "chico"
		or flag == "paz"
	)then

		if ( flag ~= nil )then



		else



		end


		local counter = TppMission.GetFlag( "isDoorCounter" )
		counter = counter + 1
		TppMission.SetFlag( "isDoorCounter", counter )





		
		local door = PlayRecord.IsMissionChallenge( "OPEN_DOOR" )
		if door == true then
			if (counter == this.doorMax)then



				PlayRecord.RegistPlayRecord( "OPEN_DOOR" )

			elseif (counter < this.doorMax	) then



				commonAnnounceLogMission(langDoor,	counter,	this.doorMax)

			end
		end
	end
end




local radioStartCheckEndOfKonkai = function()



	this.SetIntelRadio()
	TppMission.SetFlag( "isRadioEndOfKonkai",true )

	
	if( TppMission.GetFlag( "isRadioJanai" ) == false and TppMission.GetFlag( "isRadioAraskaTrap" ) == true )then
		
		if ( TppMission.GetFlag( "isRadioJanai" ) == false )then
			TppRadio.DelayPlayEnqueue( "neta_start","short","begin" ,{onEnd=function()TppRadio.DelayPlay( "neta_start2",nil,"end" ) end})
		end
	end
end


local radioStartCheckAraska = function()



	TppMission.SetFlag( "isRadioAraskaTrap",true )
	TppMission.SetFlag( "isRadioAraskaSay",false )

	
	if ( TppMission.GetFlag( "isRadioEndOfKonkai" ) ) then
		
		if ( TppMission.GetFlag( "isRadioJanai" ) == false )then
			TppRadio.DelayPlayEnqueue( "neta_start",nil,"begin" ,{onEnd=function()TppRadio.DelayPlay( "neta_start2",nil,"end" ) end})
		end
	end
end


local radioNetaCheckJanai = function()



	TppMission.SetFlag( "isRadioJanai",true )

	
	if( TppMission.GetFlag( "isRadioAraskaSay" ) == true )then
		
		if( TppMission.GetFlag( "isRadioEndOfKonkai" ) == false )then
			TppRadio.DelayPlayEnqueue( "Miller_op002","short" )
		elseif( TppMission.GetFlag( "isRadioEndOfKonkai" ) == true and TppMission.GetFlag( "isRadioAraskaTrap" ) == true )then
			
			TppRadio.DelayPlay( "neta_start2",nil,"end" )
		end
	end
end

local radioStartCheck = function()



	local check = TppData.GetArgument( 1 )
	
	if ( check == "e0060_rtrg0140" ) then
		TppMission.SetFlag( "isRadioAraskaSay",true )
	else
		TppMission.SetFlag( "isRadioAraskaSay",false )
	end

end

local netaDoor = function()
	local player = Ch.FindCharacterObjectByCharacterId( "Player")
	local pPos = player:GetPosition()

	TppSoundDaemon.PostEvent3D( 'Play_sfx_s_norm_ng_buzzer_1', pPos )
	TppRadio.DelayPlay( "neta_door","short" )

end



local RadioNearHostage = function( num )



	
	
	local status = "Normal"
	if (num == 1) then
		
		if (TppGameSequence.GetGameFlag("playerSkinMode" ) ~= 0)  then
			status = TppHostageUtility.GetStatus( "Hostage_e20060_002" )
		else
			status = TppHostageUtility.GetStatus( "Hostage_e20060_000" )
		end

	elseif (num  ==2 ) then
		
		if (TppGameSequence.GetGameFlag("playerSkinMode" ) ~= 0)  then
			status = TppHostageUtility.GetStatus( "Hostage_e20060_003" )
		else
			status = TppHostageUtility.GetStatus( "Hostage_e20060_001" )
		end

	end





	if (status == "Normal" )then
		if( PhaseCheck() == true )then
			
			TppRadio.DelayPlayEnqueue( "Near_Hostage", "short" )
		else
			
			TppRadio.DelayPlayEnqueue( "Radio_AlertHostage", "short" )
		end
	end
end

local CheckHostageStatus = function( num )




	local status = "Normal"

	if (num == 1) then
		
		if (TppGameSequence.GetGameFlag("playerSkinMode" ) ~= 0)  then
			status = TppHostageUtility.GetStatus( "Hostage_e20060_002" )
		else
			status = TppHostageUtility.GetStatus( "Hostage_e20060_000" )
		end

	elseif (num  ==2 ) then
		
		if (TppGameSequence.GetGameFlag("playerSkinMode" ) ~= 0)  then
			status = TppHostageUtility.GetStatus( "Hostage_e20060_003" )
		else
			status = TppHostageUtility.GetStatus( "Hostage_e20060_001" )
		end

	end





	if (status == "Dead" )then
		return "Dead"
	else
		return "notDead"
	end
end





this.onMissionPrepare = function()
	
	TppPlayer.SetWeapons( GZWeapon.e20060_SetWeapons )

end




this.Seq_MissionPrepare = {
	OnEnter = function()
		this.onMissionPrepare()

		
		this.tmpBestRank = GZCommon.CheckClearRankReward( this.missionID, this.ClearRankRewardList )





		lowPolyPlayer()

		
		local uiCommonData = UiCommonDataManager.GetInstance()
		this.tmpRewardNum = uiCommonData:GetRewardNowCount( this.missionID )




		TppSequence.ChangeSequence( "Seq_MissionSetup" )
	end,

}

this.Seq_MissionSetup = {

	OnEnter = function()
		MissionSetup()
		TppSequence.ChangeSequence( "Seq_OpeningDemoLoad" )
	end,
}


this.Seq_OpeningDemoLoad = {

	OnEnter = function()
		onDemoBlockLoad()
	end,

	OnUpdate = function()
		
		
		if( IsDemoAndEventBlockActive() ) then
			TppSequence.ChangeSequence( "Seq_OpeningShowTransition" )
		end
	end,
}


this.Seq_OpeningShowTransition = {
	OnEnter = function()
		local localChangeSequence = {
			onOpeningBgEnd = function()
				TppSequence.ChangeSequence( "Seq_OpeningDemo" ) 
			end,
		}
		TppUI.ShowTransition( "opening", localChangeSequence )
		TppMusicManager.PostJingleEvent( "MissionStart", "Play_bgm_gntn_op_default_intro" )
	end,
}

this.Seq_OpeningDemo = {
	Messages = {
		Timer = {
			{ data = "delayFadeIn", message = "OnEnd", commonFunc = function() TppUI.FadeIn(0.7) end },
		}
	},
	OnEnter = function()

		TppDemo.Play( "Demo_Opening", {
			onStart = function()
				TppTimer.Start( "delayFadeIn", 0.2 )
				
			end,
			onEnd = function()
			 	TppSequence.ChangeSequence( "Seq_OpeningDemoEnd" )
			end
		 } )
	end,
}

this.Seq_OpeningDemoEnd = {
	OnEnter = function()
		
		TppMissionManager.SaveGame(1000)

		TppSequence.ChangeSequence( "Seq_MissionLoad" )
	end,
}



this.Seq_MissionLoad = {
	OnEnter = function()
		
		commonPhotoMissionSetup()

		
		TppRadio.DelayPlay( "Miller_op000", "short",nil,{onEnd =function() radioStartCheckEndOfKonkai() end })

		TppSequence.ChangeSequence( "Seq_MissionStart" )
	end,
}



this.Seq_MissionStart = {

	
	
	FuncCheckLookHeli = function()
		
		if ( PhaseCheck() == true ) then
			if( TppMission.GetFlag( "isLookHeli" ) == false and TppMission.GetFlag( "isLookHeliFailed" ) == false) then
				
				local checkA = checkEnemyStatusAndPositon()



				if( checkA ~= 0) then
					
					playDemoForHomage( "Demo_LookHeli", "isLookHeli","1100",-30 )
				else
					TppRadio.Play( "Answer_no" )
				end
			end
		end
	end,
	FuncFailedHeli = function()
		if( TppMission.GetFlag( "isLookHeli" ) == false and TppMission.GetFlag( "isLookHeliFailed" ) == false and PhaseCheck() == true ) then
				TppRadio.Play( "Answer_noHeli" )
		end
	end,

	
	FuncCheckLookCamera = function()



		
		if ( PhaseCheck() == true ) then
			if( TppMission.GetFlag( "isLookCamera" ) == false and TppMission.GetFlag( "isLookCameraFailed" ) == false) then

				playDemoForHomage( "Demo_LookCamera", "isLookCamera","1300",-90 )
			end
		end
	end,

	
	FuncCheckBombTank = function()
		
		if ( PhaseCheck() == true ) then
			if( TppMission.GetFlag( "isBombTank" ) == false and TppMission.GetFlag( "isBombTankFailed" ) == false) then
				tankOpen("close")
				local demoNameTank = "Demo_BombTank"

				
				local r = 0
				local enePos = Vector3(-195.208, 26.346, 235.094)
				local player = Ch.FindCharacterObjectByCharacterId( "Player")
				local pos = player:GetPosition()

				local hikaku = pos - enePos

				if (hikaku:GetX() > 0 )then
					if (hikaku:GetZ() > 0 )then
						r = 215
					else
						r = 315
					end
				else
					if (hikaku:GetZ() > 0 )then
						r = 135
					else
						r = 45
					end
				end

				local bombEnemyId = "USSArmmy_100"

				if (TppGameSequence.GetGameFlag("playerSkinMode" ) ~= 0)  then
					
					bombEnemyId = "genom_100"
					demoNameTank = "Demo_BombTankGns"
				end

				
				if ( TppMission.GetFlag( "isInTankDemo" ) == true ) then
					TppPlayer.Warp( "warp_tankDemo" )
				end
				
				TppCharacterUtility.SetEnableCharacterId( bombEnemyId,true )
				
				MissionManager.RegisterNotInGameRealizeCharacter( bombEnemyId )
				
				TppEnemyUtility.ChangeStatus( bombEnemyId, "Faint" )
				
				TppEnemyUtility.SetLifeFlagByCharacterId( bombEnemyId, "NoRecoverFaint" )
				TppEnemyUtility.SetLifeFlagByCharacterId( bombEnemyId, "NoRecoverSleep" )
				TppEnemyUtility.SetLifeFlagByCharacterId( bombEnemyId, "NoDamageSleep" )
				TppEnemyUtility.SetLifeFlagByCharacterId( bombEnemyId, "NoDamageFaint" )

				
				ibikiOnOff(false)
				
				local position = Vector3( -193.837, 26.770, 233.847 )
				TppSoundDaemon.PostEvent3D( 'sfx_m_grenade_holein', position )

				
				TppRadio.DisableIntelRadio( "intel_e0060_esrg0070" )

				playDemoForHomage( demoNameTank, "isBombTank","1400",r )
			end
		end
	end,

	
	FuncCheckLookMoai = function()
		
		if ( PhaseCheck() == true ) then
			if( TppMission.GetFlag( "isLookMoai" ) == false and TppMission.GetFlag( "isLookMoaiFailed" ) == false ) then

				playDemoForHomage( "Demo_LookMoai", "isLookMoai","1500",-180 )
			end
		end
	end,

	
	FuncCheckRunVehicle = function()
		
		if ( PhaseCheck() == true ) then
			if( TppMission.GetFlag( "isRunVehicle" ) == false and TppMission.GetFlag( "isRunVehicleFailed" ) == false) then
				
				local chObj = Ch.FindCharacterObjectByCharacterId( "Tactical_Vehicle_WEST")
				local driverObj = chObj:GetDriver()

				if (driverObj:FindTag("Player")) then
					
					playDemoForHomage( "Demo_RunVehicle", "isRunVehicle","1600" )
				end
			end
		end
	end,
	
	FuncCheckRunVehicleRev = function()
		
		if ( PhaseCheck() == true ) then
			if( TppMission.GetFlag( "isRunVehicle" ) == false and TppMission.GetFlag( "isRunVehicleFailed" ) == false) then

				
				local chObj = Ch.FindCharacterObjectByCharacterId( "Tactical_Vehicle_WEST")
				local driverObj = chObj:GetDriver()

				if (driverObj:FindTag("Player")) then
					
					playDemoForHomage( "Demo_RunVehicleRev", "isRunVehicle","1600" )
				end
			end
		end
	end,

	
	FuncLightOffTag = function()
		local charaID = TppData.GetArgument( 1 )
		local status = TppGadgetManager.GetGadgetStatus( "gntn_center_SwitchLight" )

		if( charaID == "gntn_center_SwitchLight" )then	
			
			if( status == 1 )then	
				
				TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "camera_20060", false )

				
				if( TppMission.GetFlag( "isTurnOffPanel" ) == false and PhaseCheck() == true) then
					WeatherManager.RequestTag("e20060_lightOff", 0.2 )
				end
			else 
				
				TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "camera_20060", true )
				
				TppDataUtility.SetEnableDataFromIdentifier( "gntn_Trap", "SwitchLightArea", false , false )
			end
		end
	end,

	
	FuncCheckTurnOffPanel = function()
		
		if ( PhaseCheck() == true ) then
			if( TppMission.GetFlag( "isTurnOffPanel" ) == false) then
				
				local demoName = "Demo_TurnOffPanel"
				local useLang = AssetConfiguration.GetDefaultCategory( "Language" )
				if useLang == "jpn" then
					demoName = "Demo_TurnOffPanelJP"
				end
				playDemoForHomage( demoName, "isTurnOffPanel","1700" )
			end
		end
		
		if( TppMission.GetFlag( "isTurnOffPanel" ) == true )then
			TppDataUtility.SetEnableDataFromIdentifier( "gntn_Trap", "SwitchLightArea", true , false )
		end
	end,

	
	FuncMissionClear = function()
		if( TppMission.GetFlag( "isClear" ) == true ) then
			
			GZCommon.ScoreRankTableSetup( this.missionID )
			insideColorSetting() 
			if( TppMission.GetFlag( "isClearComp" ) == true ) then
				TppMission.ChangeState( "clear", "inDactComplate" )
			else
				TppMission.ChangeState( "clear", "inDactNormal" )
			end
		end
	end,

	
	InsideSettingBGM = function()
		TppMission.SetFlag( "isPlayerInsideBGM", true )
		insideBGMSetting()
	end,
	
	OutsideSettingBGM = function()
		TppMission.SetFlag( "isPlayerInsideBGM", false )
		insideBGMSetting()
	end,
	
	InsideSettingColor = function()
		TppMission.SetFlag( "isPlayerInsideColor", true )
		insideColorSetting()
	end,
	
	OutsideSettingColor = function()
		TppMission.SetFlag( "isPlayerInsideColor", false )
		insideColorSetting()
	end,

	
	CharengeStart = function()
		
		if( PhaseCheck() == true )then
			TppSound.PlayEvent( "sfx_s_mgsomg_codec_call" )
			TppRadio.DelayPlay( "Call_mine","mid","both" )
		end
	end,

	DemoFoxDieCheck = function()

		if ( PhaseCheck() == true ) then




			local status = "Normal"
			if( (TppData.GetArgument( 1 ) == "AsyPickingDoor24" ) ) then
				



				
				status = CheckHostageStatus(1)
				if(status == "notDead")then



					if( TppMission.GetFlag("isFoxDieChico")== true )then
						this.foxDieDemoDoorNum = 2
					else
						this.foxDieDemoDoorNum = 0
						this.Common_DoorUnlock("chico")
						TppMission.SetFlag( "isDemoChico", true )
						TppSequence.ChangeSequence( "Seq_DemoFoxDie" )
					end
				end
			elseif( (TppData.GetArgument( 1 ) == "Paz_PickingDoor00" ) )then
				



				status = CheckHostageStatus(2)
				if(status == "notDead")then



					
					if( TppMission.GetFlag("isFoxDiePaz") == true)then
						this.foxDieDemoDoorNum = 2
					else
						this.foxDieDemoDoorNum = 1
						this.Common_DoorUnlock("paz")
						TppMission.SetFlag( "isDemoPaz", true )
						TppSequence.ChangeSequence( "Seq_DemoFoxDie" )
					end
				end
			end

		end
	end,

	
   
	openMbDvc = function()
		if( TppMission.GetFlag( "isClear" ) == true and TppMission.GetFlag( "isClearComp" ) == false)then
			TppRadio.Play("canClear")
		end
	end,

	
	hostageDead1 = function()
		



		if( TppData.GetArgument( 4 ) == true ) then



			TppRadio.PlayEnqueue( "Radio_HostageDead" )
		end
		TppDataUtility.SetEnableDataFromIdentifier( "id_20060_all", "radioHostage1", false, true )

		TppMission.SetFlag( "isHostageDead1", true )
		
		checkHostDoor()

	end,
	hostageDead2 = function()
		



		if( TppData.GetArgument( 4 ) == true ) then



			TppRadio.PlayEnqueue( "Radio_HostageDead" )
		end
		TppDataUtility.SetEnableDataFromIdentifier( "id_20060_all", "radioHostage2", false, true )

		TppMission.SetFlag( "isHostageDead2", true )
		
		checkHostDoor()

	end,

	
	dactHoken = function()
		if( TppMission.GetFlag( "isClear" ) == true)then
			
			TppDataUtility.SetVisibleDataFromIdentifier( "asset_base", "TestKey0", false, false )
			TppDataUtility.SetVisibleDataFromIdentifier( "asset_base", "gntn_vent001_0001", true, false )
		else
			TppDataUtility.SetVisibleDataFromIdentifier( "asset_base", "TestKey0", true, false )
			TppDataUtility.SetVisibleDataFromIdentifier( "asset_base", "gntn_vent001_0001", false, false )
		end
	end,

	
	cpAlert = function()
		if ( TppMission.GetFlag( "isClearComp" ) == false ) then
			TppRadio.DelayPlay( "radio_Alert","short" )
		end
	end,

	cpCaution = function()
		chengeRouteCaution()
	end,
	cpEvasion = function()
		TppRadio.DelayPlay( "radio_BackAlert","short" )
		chengeRouteCaution()
	end,
	cpSneak = function()
		chengeRouteSneak()
	end,

	jinmonHeliCheck = function()
		setHeliMarker()
	end,

	
	jinmonMarkCheck = function()



		
		if( TppMission.GetFlag( "isJinmon" ) == false )then
			local charaid = TppData.GetArgument( 1 )




			if( charaid == "USSArmmy_000" or charaid == "genom_006"
				or charaid == "USSArmmy_011" or charaid == "genom_004"
				or charaid == "USSArmmy_007" or charaid == "genom_008"
				or charaid == "USSArmmy_009" or charaid == "genom_003"
				or charaid == "USSArmmy_012" or charaid == "genom_015"
				or charaid == "USSArmmy_002" or charaid == "genom_005"
				or charaid == "USSArmmy_024" or charaid == "genom_012"
				or charaid == "USSArmmy_005" or charaid == "genom_010"
			) then



				TppMission.SetFlag( "isJinmon" ,true )
				removeAllJinmon()
			end


			if ( TppMission.GetFlag( "isMarkMGS" ) )then
				TppMarkerSystem.DisableMarker{ markerId="e20060_logo_002" }
			end
			if ( TppMission.GetFlag( "isMarkMG" ) )then
				TppMarkerSystem.DisableMarker{ markerId="e20060_logo_003" }
			end
			if ( TppMission.GetFlag( "isMarkMGS4" ) )then
				TppMarkerSystem.DisableMarker{ markerId="e20060_logo_004" }
			end
			if ( TppMission.GetFlag( "isMarkMGS2" ) )then
				TppMarkerSystem.DisableMarker{ markerId="e20060_logo_005" }
			end
			if ( TppMission.GetFlag( "isMarkGZ" ) )then
				TppMarkerSystem.DisableMarker{ markerId="e20060_logo_006" }
			end
			if ( TppMission.GetFlag( "isMarkMG2" ) )then
				TppMarkerSystem.DisableMarker{ markerId="e20060_logo_007" }
			end
			if ( TppMission.GetFlag( "isMarkMGS3" ) )then
				TppMarkerSystem.DisableMarker{ markerId="e20060_logo_008" }
			end
		end
	end,

	callHeli = function()




		
		local radioDaemon = RadioDaemon:GetInstance()
		local emergency = TppData.GetArgument(2)
		local charaObj = Ch.FindCharacterObjectByCharacterId("SupportHelicopter")
		local plgHeli = charaObj:GetCharacter():FindPlugin("TppSupportHelicopterPlugin")
		if ( radioDaemon:IsPlayingRadio() == false ) then

			if(TppSupportHelicopterService.IsDueToGoToLandingZone("SupportHelicopter")) then
			
				if(emergency == 2) then
					TppRadio.DelayPlay( "Miller_CallHeli02", "long" )
				else
					TppRadio.DelayPlay( "Miller_CallHeli02", "long" )
				end
			else
			
				if plgHeli:GetAiStatus() ~= "AI_STATUS_RETURN" then
					if(emergency == 2) then
						TppRadio.DelayPlay( "Miller_CallHeli01", "long" )
					else
						TppRadio.DelayPlay( "Miller_CallHeli01", "long" )
					end
				end
			end
		end

		
		TppGadgetUtility.AttachGadgetToChara("e20060_logo_001","SupportHelicopter","CNP_MARK")

		if( TppMission.GetFlag( "isMarkHeli" ) == true )then
			return
		else
			TppMission.SetFlag( "isMarkHeli", true )
		end

		setHeliMarker()

	end,

	
	checkingsOnThisSequence = {
		"CheckLookingTarget"
	},
	Messages = {
		Character = {
			
			{ data = "gntn_cp",		message = "Alert",				localFunc = "cpAlert" },		
			{ data = "gntn_cp",		message = "Evasion",			localFunc = "cpEvasion" },		
			{ data = "gntn_cp",		message = "Caution",			localFunc = "cpCaution" },		
			{ data = "gntn_cp",		message = "Sneak",				localFunc = "cpSneak" },		
			
			{ data = "Player", 		message = "OnPickUpItem" , 		commonFunc = Common_PickUpItem },	
			
			{ data = "Player", 		message = "SwitchPushButton", 	localFunc = "FuncLightOffTag" },	
			
			{ data = "Player", 		message = "OnVehicleRide_End", 	commonFunc = function() checkVehicleRide() end },	
			
			{ data = "Player", 		message = "OnPickUpWeapon", 	commonFunc = function() checkPickUpAmmo() end },
			{ data = "Player", 		message = "OnPickUpAmmo", 		commonFunc = function() checkPickUpAmmo() end },
			
			{ data = "Player", 		message = "OnPickUpPlaced", 	commonFunc = function()charengeClaymoreCount() end },	
			{ data = "Player", 		message = "WeaponPutPlaced", 	commonFunc = function()charengeClaymorePut() end },	
			{ data = "Player", 		message = "OnActivatePlaced", 			commonFunc = function() DamagedOnClaymore() end },	
			
			{ data = "Player", 		message = "TryPicking", 		localFunc = "DemoFoxDieCheck"  },
			
			{ data = "Armored_Vehicle_WEST_001", message = "GrenadeDroppedIn", localFunc = "FuncCheckBombTank"},
			
			{ data = "Armored_Vehicle_WEST_001", message = "StrykerDestroyed", commonFunc = function()	FuncEventFailed("isBombTank") end},
			{ data = "Tactical_Vehicle_WEST", 	message = "VehicleBroken", 	commonFunc = function()  FuncEventFailed("isRunVehicle") end},
			{ data = "camera_20060", 			message = "Dead", 			commonFunc = function()	FuncEventFailed("isLookCamera") end}, 
			
			{ data = "Hostage_e20060_000", message = "Dead", localFunc = "hostageDead1"}, 
			{ data = "Hostage_e20060_001", message = "Dead", localFunc = "hostageDead2"}, 
			{ data = "Hostage_e20060_002", message = "Dead", localFunc = "hostageDead1"}, 
			{ data = "Hostage_e20060_003", message = "Dead", localFunc = "hostageDead2"}, 
		},
		Trap = {
			
			{ data = "Trap_MissionClear", 	message = "Enter", localFunc = "FuncMissionClear" },	
			{ data = "Trap_ratEscape", 		message = "Enter", commonFunc = function()	ratEscape() end },			
			{ data = "Trap_dact", 			message = "Enter", commonFunc = function() 	TppRadio.Play("Call_dact")	end },			
			
			
			{ data = "Trap_homage_heli", 	message = "Enter", commonFunc = function() TppMission.SetFlag( "isInHeli", true )  end },
			{ data = "Trap_homage_heli", 	message = "Exit",  commonFunc = function() TppMission.SetFlag( "isInHeli", false )	end },
			{ data = "Trap_homage_camera", 	message = "Enter", commonFunc = function() TppMission.SetFlag( "isInCamera", true )  end },
			{ data = "Trap_homage_camera", 	message = "Exit",  commonFunc = function() TppMission.SetFlag( "isInCamera", false )  end },
			{ data = "Trap_homage_moai", 	message = "Enter", commonFunc = function() TppMission.SetFlag( "isInMoai", true )  end },
			{ data = "Trap_homage_moai", 	message = "Exit",  commonFunc = function() TppMission.SetFlag( "isInMoai", false )	end },
			{ data = "Trap_homage_vehicle", message = "Enter", localFunc = "FuncCheckRunVehicle" },
			{ data = "Trap_homage_vehicle_Rev", message = "Enter", localFunc = "FuncCheckRunVehicleRev" },
			
			{ data = "Trap_failed_heli", 	message = "Enter", localFunc = "FuncFailedHeli"  },
			
			{ data = "trap_tankOpen", 		message = "Enter", commonFunc = function() tankOpen() end },
			
			{ data = "Trap_hint_heli", 		message = "Enter", commonFunc = function() FuncNearRadio( "isLookHeli" , "near" ) end },
			{ data = "Trap_hint_camera", 	message = "Enter", commonFunc = function() FuncNearRadio( "isLookCamera", "near"  ) end },
			{ data = "Trap_hint_chaff",		message = "Enter", commonFunc = function() FuncNearRadio( "isGetChaffCase", "near"	) end },
			{ data = "Trap_hint_vehicle",	message = "Enter", commonFunc = function() FuncNearRadio( "isRunVehicle", "near"  ) end },
			{ data = "Trap_hint_tank",		message = "Enter", commonFunc = function() FuncNearRadio( "isBombTank", "near"	) end },
			{ data = "Trap_hint_switch",	message = "Enter", commonFunc = function() FuncNearRadio( "isTurnOffPanel", "near"	) end },
			
			{ data = "trap_BGMArea",		message = "Enter", localFunc = "InsideSettingBGM" },
			{ data = "trap_BGMArea",		message = "Exit", localFunc = "OutsideSettingBGM" },
			{ data = "trap_colorArea",		message = "Enter", localFunc = "InsideSettingColor" },
			{ data = "trap_colorArea",		message = "Exit", localFunc = "OutsideSettingColor" },
			
			{ data = "trap_merker_01", 		message = "Enter", commonFunc = function()TppRadio.Play( "Metal_getGun" ) end },
			
			{ data = "trap_logo", 			message = "Enter", commonFunc = function() findFoxLogo() end },
			
			{ data = "trap_op01", 			message = "Enter", commonFunc = function()TppRadio.PlayEnqueue( "Miller_op002") end },
			{ data = "trap_netaStart", 		message = "Enter", commonFunc = function() radioStartCheckAraska() end },
			{ data = "trap_netaStart2", 	message = "Enter", commonFunc = function() radioNetaCheckJanai() end },
			{ data = "trap_DoorRadio", 		message = "Enter", commonFunc = function() netaDoor() end },
			{ data = "trap_CharengeStart", 	message = "Enter", localFunc = "CharengeStart" },			
			{ data = "trap_radioHostage1", 	message = "Enter", commonFunc = function()RadioNearHostage(1) end },
			{ data = "trap_radioHostage2", 	message = "Enter", commonFunc = function()RadioNearHostage(2) end },
			{ data = "trap_JohnnyRadio", 	message = "Enter", commonFunc = function()TppRadio.PlayEnqueue("radio_Toilet") end },
			
			{ data = "trap_TankCheckPos", 	message = "Enter", commonFunc = function() TppMission.SetFlag( "isInTankDemo", true ) end },
			{ data = "trap_TankCheckPos", 	message = "Exit", commonFunc = function() TppMission.SetFlag( "isInTankDemo", false ) end },
			
			{ data = "trap_DactHoken", 		message = "Enter", localFunc = "dactHoken" },
		},
		Terminal = {
			{		message = "MbDvcActWatchPhoto",commonFunc = commonMbDvcActWatchPhoto },
			{		message = "MbDvcActOpenTop", localFunc = "openMbDvc"},
			{ 		message = "MbDvcActCallRescueHeli", localFunc = "callHeli" },	
		},
		Gimmick = {
			
			{ data = "gntn_center_SwitchLight", message = "SwitchOff", localFunc =	"FuncCheckTurnOffPanel" },
			
			{ data = this.lookHeli, 			message = "BreakGimmick", commonFunc = function()  FuncEventFailed("isLookHeli") end},
			{ data = "e20060_moai", 			message = "BreakGimmick", commonFunc = function()  FuncEventFailed("isLookMoai") end},
			{ data = "gntn_serchlight_20060_1", message = "BreakGimmick", commonFunc = function()  FuncEventFailed("isGetChaffCase") end},
			{ data = "gntn_serchlight_20060_2", message = "BreakGimmick", commonFunc = function()  FuncEventFailed("isGetChaffCase") end},
			
			{ data = "charenge_20060_KJP", message = "HitLight", commonFunc =	function() highlightFoxLogo("fox")	end },
			{ data = "charenge_20060_LA",  message = "HitLight", commonFunc =	function() highlightFoxLogo("la")  end },
			{ data = "gntn_serchlight_20060_3", message = "SwitchOff", commonFunc = function()	TppRadio.DelayPlayEnqueue( "Light_offMark", "short" ) end},
			{ data = "gntn_serchlight_20060_4", message = "SwitchOff", commonFunc = function()	TppRadio.DelayPlayEnqueue( "Light_offMark", "short" ) end},
			{ data = "gntn_serchlight_20060_3", message = "BreakGimmick", commonFunc = function()	challengeChancelFox() end},
			{ data = "gntn_serchlight_20060_4", message = "BreakGimmick", commonFunc = function()	challengeChancelLA() end},
			
			{ data = "WoodTurret04", message = "BreakGimmick", commonFunc = function() challengeChancel()  end },
			
			{ data = "e20060_logo_001", message = "HitLight", commonFunc = function()  findTitleLogoMark(1) end},
			{ data = "e20060_logo_002", message = "HitLight", commonFunc = function()  findTitleLogoMark(2) end},
			{ data = "e20060_logo_003", message = "HitLight", commonFunc = function()  findTitleLogoMark(3) end},
			{ data = "e20060_logo_004", message = "HitLight", commonFunc = function()  findTitleLogoMark(4) end},
			{ data = "e20060_logo_005", message = "HitLight", commonFunc = function()  findTitleLogoMark(5) end},
			{ data = "e20060_logo_006", message = "HitLight", commonFunc = function()  findTitleLogoMark(6) end},
			{ data = "e20060_logo_007", message = "HitLight", commonFunc = function()  findTitleLogoMark(7) end},
			{ data = "e20060_logo_008", message = "HitLight", commonFunc = function()  findTitleLogoMark(8) end},
			{ data = "e20060_logo_101", message = "HitLight", commonFunc = function()  findTitleLogoMark(10) end},
			{ data = "e20060_logo_102", message = "HitLight", commonFunc = function()  findTitleLogoMark(10) end},
			{ data = "e20060_logo_103", message = "HitLight", commonFunc = function()  findTitleLogoMark(10) end},
			{ data = "e20060_logo_104", message = "HitLight", commonFunc = function()  findTitleLogoMark(10) end},
			{ data = "e20060_logo_105", message = "HitLight", commonFunc = function()  findTitleLogoMark(10) end},
			{ data = "e20060_logo_106", message = "HitLight", commonFunc = function()  findTitleLogoMark(10) end},
			{ data = "e20060_logo_107", message = "HitLight", commonFunc = function()  findTitleLogoMark(10) end},
		},
		Radio = {
			{ data = "e0060_rtrg0140",		message = "RadioEventMessage", commonFunc = function() radioStartCheck() end },
		},
		Marker = {
			
		},
		Enemy = {
			
			{ message = "HostageLaidOnVehicle",			commonFunc = function() this.commonOnLaidEnemy() end  },
			{ message = "EnemyInterrogation", 			localFunc = "jinmonMarkCheck"},


		},
		
		Myself = {
			{ data = this.lookCamera,	message = "LookingTarget",		commonFunc = function() commonLookCheck() end },
			{ data = this.lookMoai,		message = "LookingTarget",		commonFunc = function() commonLookCheck() end },
			{ data = this.lookHeli,		message = "LookingTarget",		commonFunc = function() commonLookCheck() end },
		},
	},

	OnEnter = function( manager )
		
		commonRouteSetMissionSetup()
		
		All_Seq_MissionAreaOut()
		
		TppPadOperatorUtility.ResetMasksForPlayer( 0, "MB_Disable")
		
		commonSearchTargetSetup( manager )
		
		checkHostDoor()
		
		insideColorSetting()
		
		this.SetIntelRadio()
	end,
}



this.Seq_EventFoxDie = {
	Messages = {
		Character = {
			
			{ data = "Player", 		message = "OnPickUpItem" , 		commonFunc = Common_PickUpItem },	
			
			{ data = "Player", 		message = "OnPickUpPlaced", 	commonFunc = function()charengeClaymoreCount() end },	
			{ data = "Player", 		message = "WeaponPutPlaced", 	commonFunc = function()charengeClaymorePut() end },	
			{ data = "Player", 		message = "OnActivatePlaced", 			commonFunc = function() DamagedOnClaymore() end },	
			
			{ data = "Armored_Vehicle_WEST_001", message = "StrykerDestroyed", commonFunc = function()	FuncEventFailed("isBombTank") end},
			{ data = "Tactical_Vehicle_WEST", 	message = "VehicleBroken", 	commonFunc = function()  FuncEventFailed("isRunVehicle") end},
			{ data = "camera_20060", 			message = "Dead", 			commonFunc = function()	FuncEventFailed("isLookCamera") end}, 
		},
		Trap = {
			
			{ data = "Trap_MissionClear", 	message = "Enter", commonFunc =  function() this.Seq_MissionStart.FuncMissionClear() end },	
			{ data = "Trap_ratEscape", 		message = "Enter", commonFunc = function()	ratEscape() end },			
			
			{ data = "trap_tankOpen", 		message = "Enter", commonFunc = function() tankOpen() end },
			
			{ data = "trap_BGMArea",		message = "Enter",commonFunc = function() this.Seq_MissionStart.InsideSettingBGM() end },
			{ data = "trap_BGMArea",		message = "Exit", commonFunc = function() this.Seq_MissionStart.OutsideSettingBGM() end },
			
			{ data = "trap_DactHoken", 		message = "Enter", commonFunc = function() this.Seq_MissionStart.dactHoken() end },
		},
		Gimmick = {
			
			{ data = this.lookHeli, 			message = "BreakGimmick", commonFunc = function()  FuncEventFailed("isLookHeli") end},
			{ data = "e20060_moai", 			message = "BreakGimmick", commonFunc = function()  FuncEventFailed("isLookMoai") end},
			{ data = "gntn_serchlight_20060_1", message = "BreakGimmick", commonFunc = function()  FuncEventFailed("isGetChaffCase") end},
			{ data = "gntn_serchlight_20060_2", message = "BreakGimmick", commonFunc = function()  FuncEventFailed("isGetChaffCase") end},
			
			{ data = "charenge_20060_KJP", message = "HitLight", commonFunc =	function() highlightFoxLogo("fox")	end },
			{ data = "charenge_20060_LA",  message = "HitLight", commonFunc =	function() highlightFoxLogo("la")  end },
			{ data = "gntn_serchlight_20060_3", message = "BreakGimmick", commonFunc = function()	challengeChancelFox() end},
			{ data = "gntn_serchlight_20060_4", message = "BreakGimmick", commonFunc = function()	challengeChancelLA() end},
			{ data = "WoodTurret04", message = "BreakGimmick", commonFunc = function() challengeChancel()  end },
			
			{ data = "e20060_logo_001", message = "HitLight", commonFunc = function()  findTitleLogoMark(1) end},
			{ data = "e20060_logo_002", message = "HitLight", commonFunc = function()  findTitleLogoMark(2) end},
			{ data = "e20060_logo_003", message = "HitLight", commonFunc = function()  findTitleLogoMark(3) end},
			{ data = "e20060_logo_004", message = "HitLight", commonFunc = function()  findTitleLogoMark(4) end},
			{ data = "e20060_logo_005", message = "HitLight", commonFunc = function()  findTitleLogoMark(5) end},
			{ data = "e20060_logo_006", message = "HitLight", commonFunc = function()  findTitleLogoMark(6) end},
			{ data = "e20060_logo_007", message = "HitLight", commonFunc = function()  findTitleLogoMark(7) end},
			{ data = "e20060_logo_008", message = "HitLight", commonFunc = function()  findTitleLogoMark(8) end},
		},
		Timer = {
			{ data = "Timer_foxDieBugEnd", message = "OnEnd", localFunc = "foxDieBugEnd" },
			{ data = "Timer_foxDieBugEndHoken", message = "OnEnd", localFunc = "foxDieBugEnd" },
			{ data = "Timer_foxDieFadeOut", message = "OnEnd", localFunc = "foxDieBugFadeOut" },
			{ data = "Timer_foxDieFadeIn", message = "OnEnd", localFunc = "foxDieBugFadeIn" },
			{ data = "Timer_foxDieAnnounce0", message = "OnEnd", localFunc = "foxDieBugAnnounce0" },
			{ data = "Timer_foxDieAnnounce1", message = "OnEnd", localFunc = "foxDieBugAnnounce1" },
			{ data = "Timer_foxDieAnnounce2", message = "OnEnd", localFunc = "foxDieBugAnnounce2" },
			{ data = "Timer_foxDieAnnounce3", message = "OnEnd", localFunc = "foxDieBugAnnounce3" },
			{ data = "Timer_foxDieAnnounce4", message = "OnEnd", localFunc = "foxDieBugAnnounce4" },
			{ data = "Timer_foxDieAnnounce5", message = "OnEnd", localFunc = "foxDieBugAnnounce5" },
			{ data = "Timer_foxDieAnnounce6", message = "OnEnd", localFunc = "foxDieBugAnnounce6" },
			{ data = "Timer_foxDieAnnounce7", message = "OnEnd", localFunc = "foxDieBugAnnounce7" },
			{ data = "Timer_foxDieAnnounce8", message = "OnEnd", localFunc = "foxDieBugAnnounce8" },
			{ data = "Timer_foxDieAnnounce9", message = "OnEnd", localFunc = "foxDieBugAnnounce9" },
			{ data = "Timer_foxDieAnnounce10", message = "OnEnd", localFunc = "foxDieBugAnnounce10" },
		},
	},

	OnEnter = function()

		
		if ( TppMission.GetFlag( "isFoxDieStart" ) == true ) then



			insideColorSetting() 
			TppUI.FadeIn( 0 ) 
			TppSequence.ChangeSequence( "Seq_MissionStart" )

			
			TppPadOperatorUtility.ResetMasksForPlayer( 0, "MB_Disable")
		else




			
			TppPadOperatorUtility.SetMasksForPlayer( 0, "MB_Disable")

			
			TppMission.SetFlag( "isFoxDieStart", true )

			
			GkEventTimerManager.Start( "Timer_foxDieBugEndHoken", this.timeFoxDieBug ) 
			
			GkEventTimerManager.Start( "Timer_foxDieFadeOut", 6 )

			
			commonAnnounceLogMission(langFoxDie023)
			commonAnnounceLogMission(langFoxDie019)
			commonAnnounceLogMission(langFoxDie017)
		end
		
		this.SetIntelRadio()
	end,

	foxDieBugFadeOut = function()
		
		

		
		TppRadio.Play( "Radio_FoxDieIDroid")
		TppSound.PlayEvent( "Set_State_FoxDie" )

		GkEventTimerManager.Start( "Timer_foxDieFadeIn", 1 )
	end,
	foxDieBugFadeIn = function()
		TppUI.FadeIn( 1 )
		TppEffectUtility.SetColorCorrectionLut( "gntn_bug_a_FILTERLUT" )
		TppPlayerUtility.SetFoxDieBugFlag()

		GkEventTimerManager.Start( "Timer_foxDieAnnounce0", 2 )
	end,


	foxDieBugAnnounce0 = function()
		
		commonAnnounceLogMission(langFoxDie002)
		GkEventTimerManager.Start( "Timer_foxDieAnnounce1", this.timeFoxDieBugAnnounce )
	end,

	foxDieBugAnnounce1 = function()
		GkEventTimerManager.Start( "Timer_foxDieAnnounce2", this.timeFoxDieBugAnnounce )
	end,

	foxDieBugAnnounce2 = function()
		commonAnnounceLogMission(langFoxDie008)
		GkEventTimerManager.Start( "Timer_foxDieAnnounce3", this.timeFoxDieBugAnnounce )
	end,

	foxDieBugAnnounce3 = function()
		GkEventTimerManager.Start( "Timer_foxDieAnnounce4", this.timeFoxDieBugAnnounce )
	end,

	foxDieBugAnnounce4 = function()
		commonAnnounceLogMission(langFoxDie012)
		GkEventTimerManager.Start( "Timer_foxDieAnnounce5", this.timeFoxDieBugAnnounce )
	end,

	foxDieBugAnnounce5 = function()
		
		
		
		GkEventTimerManager.Start( "Timer_foxDieAnnounce6", this.timeFoxDieBugAnnounce )
	end,

	foxDieBugAnnounce6 = function()
		commonAnnounceLogMission(langFoxDie018)
		
		
		GkEventTimerManager.Start( "Timer_foxDieAnnounce7", this.timeFoxDieBugAnnounce )
	end,

	foxDieBugAnnounce7 = function()
		
		
		commonAnnounceLogMission(langFoxDie024)
		GkEventTimerManager.Start( "Timer_foxDieAnnounce8", this.timeFoxDieBugAnnounce )
	end,

	foxDieBugAnnounce8 = function()
		
		commonAnnounceLogMission(langFoxDie026)
		
		GkEventTimerManager.Start( "Timer_foxDieAnnounce9", this.timeFoxDieBugAnnounce )
	end,

	foxDieBugAnnounce9 = function()
		
		
		
		GkEventTimerManager.Start( "Timer_foxDieAnnounce10", 3)
	end,

	foxDieBugAnnounce10 = function()
		commonAnnounceLogMission(langFoxDie031)
		commonAnnounceLogMission(langFoxDie032)
		commonAnnounceLogMission(langFoxDie033)

		
		GkEventTimerManager.Start( "Timer_foxDieBugEnd", 3 )
	end,

	
	foxDieBugEnd = function()

		TppMission.SetFlag( "isFoxDieEnd", true )
		
		
		
		TppSound.PlayEvent( "sfx_s_mgsomg_rader_clear" )
		TppRadio.DelayPlay( "Radio_FoxDieFixed","mid","none")

		insideColorSetting()

		TppPlayerUtility.ResetFoxDieBugFlag()
		TppSound.PlayEvent( "p12_Set_State_none" )

		
		TppRadio.DelayPlayEnqueue( "Radio_FoxDie2","long",nil,{onEnd =function() 
			if ( MissionManager.GetMissionClearMessage() == "" ) then



				TppSequence.ChangeSequence( "Seq_MissionStart" ) 
			else



			end
		end } )

	end,



}

this.Seq_DemoFoxDie = {
	Messages = {
	   Character = {
			{ data="Player", message="TransitionActionEnd", localFunc="DemoStart" },
		},
		Demo = {
			{ data="p12_050030_000", message="visibleGate", localFunc="onDemoVisibleGateChico" },
			{ data="p12_050040_000", message="visibleGate", localFunc="onDemoVisibleGate" },
			{ data="p12_050050_000", message="visibleGate", localFunc="onDemoVisibleGateChico" },
			{ data="p12_050060_000", message="visibleGate", localFunc="onDemoVisibleGate" },
		},
	},

	demoId = "Demo_FoxDieChico",
	doorName = "AsyPickingDoor24",

	onDemoVisibleGate = function()



			
			TppGadgetUtility.SetDoor{ id = this.Seq_DemoFoxDie.doorName, isVisible = true, isEnableBounder = true, isEnableTacticalActionEdge = true , angle = 240, isOpen = true }
	end,

	onDemoVisibleGateChico = function()



			
			TppGadgetUtility.SetDoor{ id = this.Seq_DemoFoxDie.doorName, isVisible = true, isEnableBounder = true, isEnableTacticalActionEdge = true , angle = -110, isOpen = true }
	end,

	DemoStart = function()


		local onDemoStart = function()



			
			TppGadgetUtility.SetDoor{ id = this.Seq_DemoFoxDie.doorName, isVisible = false, isEnableBounder = true, isEnableTacticalActionEdge = false , angle = 0, isOpen = false }

			if( this.foxDieDemoDoorNum == 0 ) then
				TppMission.SetFlag( "isFoxDieChico", true )
				TppDataUtility.SetEnableDataFromIdentifier( "id_20060_all", "radioHostage1", false, true )

				TppHostageManager.GsSetDeadFlag( "Hostage_e20060_000", true)
				TppHostageManager.GsSetDeadFlag( "Hostage_e20060_002", true)
			else
				TppMission.SetFlag( "isFoxDiePaz", true )
				TppDataUtility.SetEnableDataFromIdentifier( "id_20060_all", "radioHostage2", false, true )

				TppHostageManager.GsSetDeadFlag( "Hostage_e20060_001", true)
				TppHostageManager.GsSetDeadFlag( "Hostage_e20060_003", true)
			end

		end


		local onDemoEnd = function()







			
			

			if( TppMission.GetFlag( "isFoxDieChico" ) == true and TppMission.GetFlag( "isFoxDiePaz" ) )then
				
				TppSequence.ChangeSequence( "Seq_EventFoxDie" )
			else
				
				TppSequence.ChangeSequence( "Seq_MissionStart" )
			end
		end


		TppDemo.Play( this.Seq_DemoFoxDie.demoId, { onStart = onDemoStart, onEnd = onDemoEnd } )

	end,

	OnEnter = function()



		GZCommon.StopAlertSirenCheck()

		






		if( this.foxDieDemoDoorNum == 0 ) then
			
			this.Seq_DemoFoxDie.doorName = "AsyPickingDoor24"

			
			if (TppGameSequence.GetGameFlag("playerSkinMode" ) ~= 0)  then
				this.Seq_DemoFoxDie.demoId = "Demo_FoxDieChicoLow"
			else
				this.Seq_DemoFoxDie.demoId = "Demo_FoxDieChico"
			end

		elseif( this.foxDieDemoDoorNum == 1 ) then
			
			this.Seq_DemoFoxDie.doorName = "Paz_PickingDoor00"
			if (TppGameSequence.GetGameFlag("playerSkinMode" ) ~= 0) then
				
				this.Seq_DemoFoxDie.demoId = "Demo_FoxDiePazLow"
			else
				this.Seq_DemoFoxDie.demoId = "Demo_FoxDiePaz"
			end
		end

		local demoInterpCameraId = this.DemoList[this.Seq_DemoFoxDie.demoId]










		
		local demoPos = 0
		local demoRot = 0
		demoPos, demoRot = getDemoStartPos( demoInterpCameraId )










		
		if( this.foxDieDemoDoorNum == 0 ) then
			
			TppPlayerUtility.RequestToStartTransition{stance=this.demoStaPlayer_chico,position=demoPos,direction=demoRot}
			

		elseif( this.foxDieDemoDoorNum == 1 ) then
			
			TppPlayerUtility.RequestToStartTransition{stance=this.demoStaPlayer_paz,position=demoPos,direction=demoRot}
		else
			TppSequence.ChangeSequence( "Seq_MissionStart" )
		end

		GZCommon.SetGameStatusForDemoTransition()

		
		TppDemoUtility.Setup(demoInterpCameraId)
		TppPlayerUtility.RequestToInterpCameraToDemo(demoInterpCameraId,this.demoCamRot,this.demoCamSpeed)

	end,

	OnLeave = function()
		
		chengeRouteSneak("warp")
		

		
		TppRadio.DelayPlay( "Radio_FoxDie1","mid" )
	end,
}


this.Seq_MissionClearDemo = {

	MissionState = "clear",

	OnEnter = function()
		
		TppDataUtility.SetVisibleDataFromIdentifier( "asset_base", "TestKey0", true, false )
		TppDataUtility.SetVisibleDataFromIdentifier( "asset_base", "gntn_vent001_0001", false, false )

		if ( TppMission.GetFlag( "isClearComp" ) == false ) then
			TppSequence.ChangeSequence( "Seq_MissionClearShowTransition" )
		else
			Trophy.TrophyUnlock(11)
			TppSequence.ChangeSequence( "Seq_MissionClearShowTransition" )
		end




		PlatformConfiguration.SetVideoRecordingEnabled(false) 

	end,
}


this.Seq_MissionClearShowTransition = {

	MissionState = "clear",

	Messages = {
		UI = {
			
			{ message = "EndMissionTelopFadeIn" ,	localFunc = "OnFinishClearFade" },
		},
	},

	
	OnFinishClearFade = function()
		
		TppSoundDaemon.SetMute( 'Result' )
		
		
		local Rank = PlayRecord.GetRank()
		if( Rank == 0 ) then



		elseif( Rank == 1 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_gntn_ed_default_s" )
		elseif( Rank == 2 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_gntn_ed_default_ab" )
		elseif( Rank == 3 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_gntn_ed_default_ab" )
		elseif( Rank == 4 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_gntn_ed_default_cd" )
		elseif( Rank == 5 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_gntn_ed_default_cd" )
		else
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_gntn_ed_default_e" )
		end

		
		SubtitlesCommand.SetIsEnabledUiPrioStrong( true )
		
		this.commonMissionClearRadio()
	end,

	OnEnter = function()

		local TelopEnd = {
			onEnd = function()
				if ( TppMission.GetFlag( "isClearComp" ) == true )then



					TppSequence.ChangeSequence( "Seq_QuizSetup" )
				else



					TppSequence.ChangeSequence( "Seq_MissionClearDemoAfter" )
				end
			end,
		}

		TppUI.ShowTransitionWithFadeOut( "ending", TelopEnd, 2 )

		

	end,
}



this.Seq_QuizSetup = {
	MissionState = "clear",

	Messages = {
		UI = {
			{ message = "MgsQuizLoaded",		localFunc = "QuizLoaded"  },

		},
	},

	OnEnter = function()




		
		if TppGameSequence.GetGameFlag("hardmode") then



			
			local uiCommonData = UiCommonDataManager.GetInstance()
			uiCommonData :SetupMgsQuizItemTable(
			  { quizId=11, answerId=1, questionRadioId="e0060_rtrg2080", correctRadioId="e0060_rtrg2100" }
			 ,{ quizId=12, answerId=3, questionRadioId="e0060_rtrg2080", correctRadioId="e0060_rtrg2100" }
			 ,{ quizId=13, answerId=4, questionRadioId="e0060_rtrg2080", correctRadioId="e0060_rtrg2100" }
			 ,{ quizId=14, answerId=3, questionRadioId="e0060_rtrg2082", correctRadioId="e0060_rtrg2102" }
			 ,{ quizId=15, answerId=5, questionRadioId="e0060_rtrg2082", correctRadioId="e0060_rtrg2100" }
			 ,{ quizId=16, answerId=2, questionRadioId="e0060_rtrg2082", correctRadioId="e0060_rtrg2104" }
			 ,{ quizId=17, answerId=4, questionRadioId="e0060_rtrg2084", correctRadioId="e0060_rtrg2100" }
			 ,{ quizId=18, answerId=4, questionRadioId="e0060_rtrg2084", correctRadioId="e0060_rtrg2106" }
			 ,{ quizId=19, answerId=3, questionRadioId="e0060_rtrg2086", correctRadioId="e0060_rtrg2100" }
			 ,{ quizId=20, answerId=5, questionRadioId="e0060_rtrg2090", correctRadioId="e0060_rtrg2108" }
			 )
		else



			
			local uiCommonData = UiCommonDataManager.GetInstance()
			uiCommonData :SetupMgsQuizItemTable(
			  { quizId= 1, answerId=4, questionRadioId="e0060_rtrg2080", correctRadioId="e0060_rtrg2100" }
			 ,{ quizId= 2, answerId=3, questionRadioId="e0060_rtrg2080", correctRadioId="e0060_rtrg2100" }
			 ,{ quizId= 3, answerId=3, questionRadioId="e0060_rtrg2080", correctRadioId="e0060_rtrg2102" }
			 ,{ quizId= 4, answerId=4, questionRadioId="e0060_rtrg2082", correctRadioId="e0060_rtrg2100" }
			 ,{ quizId= 5, answerId=2, questionRadioId="e0060_rtrg2082", correctRadioId="e0060_rtrg2100" }
			 ,{ quizId= 6, answerId=3, questionRadioId="e0060_rtrg2082", correctRadioId="e0060_rtrg2100" }
			 ,{ quizId= 7, answerId=1, questionRadioId="e0060_rtrg2082", correctRadioId="e0060_rtrg2104" }
			 ,{ quizId= 8, answerId=2, questionRadioId="e0060_rtrg2084", correctRadioId="e0060_rtrg2100" }
			 ,{ quizId= 9, answerId=2, questionRadioId="e0060_rtrg2086", correctRadioId="e0060_rtrg2106" }
			 ,{ quizId=10, answerId=5, questionRadioId="e0060_rtrg2090", correctRadioId="e0060_rtrg2108" }
			)
		end






		
		TppMusicManager.PostJingleEvent( "MissionEnd", "Stop_bgm_gntn_ed_default" )

		
		local uiCommonData = UiCommonDataManager.GetInstance()
		uiCommonData:LoadMgsQuiz()

	end,

	QuizLoaded = function()
		TppSound.PlayEvent( "sfx_s_e20060_quiz_env" )	
		TppSequence.ChangeSequence( "Seq_QuizSkip" )
	end,
}


this.Seq_QuizSkip = {
	MissionState = "clear",

	Messages = {
		UI = {
			{ message = "MgsQuizDisplayed",		localFunc = "QuizDisplayed"  },
		},
		Radio = {
			{ data = "e0060_rtrg2010",		message = "RadioEventMessage", commonFunc = function()
				if ( TppData.GetArgument( 2 ) == 1 )then



					
					TppSound.PlayEvent( "sfx_s_e20060_quiz01" )	
				end
			end },
			{ data = "e0060_rtrg2040",		message = "RadioEventMessage", commonFunc = function()
				if ( TppData.GetArgument( 2 ) == 1 )then



					TppSound.PlayEvent( "sfx_s_e20060_quiz13" )
				end
			end },
			{ data = "e0060_rtrg2060",		message = "RadioEventMessage", commonFunc = function()
				if ( TppData.GetArgument( 2 ) == 1 )then



					TppSound.PlayEvent( "sfx_s_e20060_quiz14" )
				end
			end },
			
			{ data = "e0060_rtrg2030",		message = "RadioEventMessage", commonFunc = function()
				if ( TppData.GetArgument( 2 ) == 1 )then



					TppSound.PlayEvent( "sfx_s_e20060_quiz02" )
				end
			end },
			
			{ data = "e0060_rtrg2030",		message = "RadioEventMessage", commonFunc = function()
				if ( TppData.GetArgument( 2 ) == 1 )then



					TppSound.PlayEvent( "sfx_s_e20060_quiz15" )
				end
			end },
		},

	},

	OnEnter = function()
		
		SubtitlesCommand.SetIsEnabledUiPrioStrong( true )

		local uiCommonData = UiCommonDataManager.GetInstance()
		uiCommonData:StartMgsQuizDisplay()
	end,

	
	QuizDisplayed = function()



		local skin = false
		
		if ( TppGameSequence.GetGameFlag("hardmode") == true) then 



			if	(TppGameSequence.GetGameFlag("isLowSkin2Enabled") == false ) then



			else



				skin = true
			end
		else



			if	(TppGameSequence.GetGameFlag("isLowSkin1Enabled") == false )then 



			else



				skin = true
			end
		end

		local func = {
			onEnd = function()
				this.Seq_QuizSkip.QuizLoaded()
			end
		}

		TppRadio.DelayPlay("Quiz_start1","short" ,	"none")


		if( skin == true )then






			TppRadio.DelayPlayEnqueue( "Quiz_skinHave","short" ,"none",func)
		else






			TppRadio.DelayPlayEnqueue( "Quiz_skinNot","short" ,"none",func )
		end

	end,


	
	QuizLoaded = function()



		
		local radioId = "Quiz_normal"




		
		if( TppMission.GetFlag( "isQuizSkip" ) == false )then
			TppRadio.DelayPlayEnqueue( "Quiz_setumei","mid" ,"none")
		end





		
		if ( TppGameSequence.GetGameFlag("hardmode") == true) then 



			radioId = "Quiz_hard"
		else



			radioId = "Quiz_normal"
		end





		if( TppMission.GetFlag( "isQuizSkip" ) == false )then
			TppRadio.DelayPlayEnqueue( radioId,"short" ,"none" ,{onEnd = function() this.Seq_QuizSkip.QuizSelect()	end})
		end

	end,

	
	QuizSelect = function()
		local funcs = {
			onStart = function()



			end,
			onEnd = function()
				TppSequence.ChangeSequence( "Seq_Quiz" )
			end,
		}
		
		if( TppMission.GetFlag( "isQuizSkip" ) == false )then
			TppRadio.DelayPlayEnqueue( "Quiz_areYouRedy","short" ,"none",	funcs )
		end
	end,

	OnUpdate = function()
		local hudCommonData = HudCommonDataManager.GetInstance()
		if hudCommonData:IsPushRadioSkipButton() then



			
			local uiCommonData = UiCommonDataManager.GetInstance()
			uiCommonData:StartMgsQuizDisplay()
			

			
			local radioDaemon = RadioDaemon:GetInstance()
			radioDaemon:StopDirectNoEndMessage()
			
			SubtitlesCommand.StopAll()

			TppSequence.ChangeSequence( "Seq_Quiz" )
			TppMission.SetFlag( "isQuizSkip", true )
		end
	end,
}

this.Seq_Quiz = {


	MissionState = "clear",

	Messages = {
		UI = {
			{ message = "MgsQuizChallengeYes", 	localFunc = "QuizStart"	},
			{ message = "MgsQuizChallengeNo", 	localFunc = "QuizEnd"  },
			{ message = "MgsQuizFailed", 		localFunc = "QuizFailed"	},
			{ message = "MgsQuizClear", 		localFunc = "QuizClear"  },
			{ message = "MgsQuizFoxDieOK", 		localFunc = "QuizFoxDie"  },
			{ message = "MgsQuizFoxDieNG", 		localFunc = "FoxDieNg"	},
			{ message = "MgsQuizEnd", 			localFunc = "WaitEnd"  },
			{ message = "MgsQuizUnLoaded", 		localFunc = "WaitEnd"  },
		},
		Radio = {
			{ 	message = "RadioEventMessage", commonFunc = function()



			end },
			
			{ data = "e0060_rtrg2070",		message = "RadioEventMessage", commonFunc = function()
				if ( TppData.GetArgument( 2 ) == 1 )then



					TppSound.PlayEvent( "sfx_s_e20060_quiz03" )
				end
			end },
			
			{ data = "e0060_rtrg2140",		message = "RadioEventMessage", commonFunc = function()
				if ( TppData.GetArgument( 2 ) == 1 )then



					TppSound.PlayEvent( "sfx_s_e20060_quiz05" )
				end
			end },
		},
	},

	OnEnter = function()




		
		TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz01" )
		TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz02" )
		TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz13" )
		TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz14" )
		TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz15" )

		local uiCommonData = UiCommonDataManager.GetInstance()
		uiCommonData:StartMgsQuizChallenge()
	end,

	QuizStart = function()
		local funcs = {
			onEnd = function()



				local uiCommonData = UiCommonDataManager.GetInstance()
				uiCommonData:StartMgsQuizMain()
			end,
		}




		TppRadio.DelayPlay( "Quiz_goToQuiz",nil ,"none",	funcs )

	end,

	QuizClear = function()




		local radioId = "Quiz_skinGet"
		local funcs = {
			onEnd = function()

				



				if ( TppGameSequence.GetGameFlag("hardmode") == true) then 



					if	(TppGameSequence.GetGameFlag("isLowSkin2Enabled") == false ) then



						TppGameSequence.SetGameFlag("isLowSkin2Enabled", true)
			   			
						radioId = "Quiz_skinGet"
						
						TppMission.SetFlag( "isNinjaReward", true )
					else



						radioId = "Quiz_skinNoGet"
		   			end
				else



					if	(TppGameSequence.GetGameFlag("isLowSkin1Enabled") == false )then 



				  		TppGameSequence.SetGameFlag("isLowSkin1Enabled", true)
						TppGameSequence.SetGameFlag("titleBlackOut", true )
						
						radioId = "Quiz_skinGet"
					else



						radioId = "Quiz_skinNoGet"
		  			end
				end




				TppRadio.DelayPlayEnqueue( radioId,"short" ,"none",	{onEnd= function()



					local uiCommonData = UiCommonDataManager.GetInstance()
					uiCommonData:StartMgsQuizFoxDie()
				 end} )

			end
		}




		
		TppRadio.DelayPlayEnqueue( "Quiz_allClear","mid" ,"none",	funcs )

	end,

	QuizFoxDie = function()



		local funcs = {
			onEnd = function()
				
				local uiCommonData = UiCommonDataManager.GetInstance()
				uiCommonData:EndMgsQuiz()

			end
		}
		TppMission.SetFlag( "isQuizComp", true )
		TppRadio.DelayPlayEnqueue( "Quiz_Die",nil ,"none",	funcs )

	end,

	QuizFailed = function()







		TppRadio.DelayPlayEnqueue( "Quiz_failed","short" ,"none",	{ onEnd = function()



			TppSound.PlayEvent( "sfx_s_e20060_quiz17" )
			this.Seq_Quiz.NextSeq()
		end} )

	end,

	QuizEnd = function()







		TppRadio.DelayPlay( "Quiz_goToTitle","short" ,"none",	{ onEnd = function()



			TppSound.PlayEvent( "sfx_s_e20060_quiz16" )
			this.Seq_Quiz.NextSeq()
		end})
	end,

	FoxDieNg = function()



	 	TppSound.PlayEvent( "sfx_s_e20060_quiz09" )
		this.Seq_Quiz.NextSeq()
	end,

	NextSeq = function()



		
		TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_gntn_ed_default_lp" )

		local uiCommonData = UiCommonDataManager.GetInstance()
		uiCommonData:EndMgsQuiz()


	end,

	WaitEnd = function()




		TppSequence.ChangeSequence( "Seq_MissionClearDemoAfter" )
	end,


}

this.Seq_MissionClearDemoAfter = {

	MissionState = "clear",

	Messages = {
		Timer = {
			{ data = "Timer_endSeq", message = "OnEnd", commonFunc = function() TppSequence.ChangeSequence( "Seq_ShowClearReward" ) end },
		},
	},


	OnEnter = function()

		local func = {
			onStart = function() TppMusicManager.PostJingleEvent( 'SingleShot', 'Set_Switch_bgm_gntn_ed_default_lp' ) end,
			onEnd = function()
				if ( TppMission.GetFlag( "isClearComp" ) == false ) then
					
				end

				TppSequence.ChangeSequence( "Seq_ShowClearReward" )
			end,
		}




		PlatformConfiguration.SetShareScreenEnabled(false) 

		
		SubtitlesCommand.SetIsEnabledUiPrioStrong( true )

		
		if ( TppMission.GetFlag( "isClearComp" ) == false ) then
			TppRadio.DelayPlayEnqueue( "Clear_normal2", "short", "none",func )
		else
			if( TppMission.GetFlag( "isQuizComp" ) == true )then
				TppSound.PlayEvent( "sfx_s_e20060_quiz08" )
				TppRadio.DelayPlay( "Clear_complate", 1.5, "none",func )
			else
				TppSequence.ChangeSequence( "Seq_ShowClearReward" )
			end
		end

		
		

	end,

	OnUpdate = function()
		
		local hudCommonData = HudCommonDataManager.GetInstance()
		if hudCommonData:IsPushRadioSkipButton() == true then
			
			
			local radioDaemon = RadioDaemon:GetInstance()
			radioDaemon:StopDirect()

			
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz_env" )
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz01")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz02")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz03")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz04")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz05")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz06")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz07")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz08")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz09")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz10")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz11")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz12")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz13")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz14")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz15")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz16")
			TppSound.PlayEvent( "Stop_sfx_s_e20060_quiz17")

			TppSequence.ChangeSequence( "Seq_ShowClearReward" )
		end
	end,

}





this.OnClosePopupWindow = function()





	
	local LangIdHash = TppData.GetArgument(1)

	
	if ( LangIdHash == this.tmpChallengeString ) then

		
		this.OnShowRewardPopupWindow()
	end
end



this.Seq_ShowClearReward = {

	MissionState = "clear",

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



this.Seq_MissionFailed = {
	MissionState = "failed",
	Messages = {
		Timer = {
		{ data = "MissionFailedProductionTimer",	message = "OnEnd", 	localFunc="OnFinishMissionFailedProduction" },
		},
	},

	
	OnFinishMissionFailedProduction = function( manager )

			
			TppSequence.ChangeSequence( "Seq_MissionGameOver" )
	end,


	OnEnter = function()
		
		TppTimer.Start( "MissionFailedProductionTimer", this.CounterList.GameOverFadeTime )

	end,
}


this.Seq_MissionEnd = {

	OnEnter = function()
		
		this.commonMissionCleanUp()

		
		TppMusicManager.PostJingleEvent( "SingleShot", "Stop_bgm_gntn_ed_default" )

		TppMissionManager.SaveGame()		
		
		TppMission.ChangeState( "end" )




		PlatformConfiguration.SetVideoRecordingEnabled(true)					

	end,
}

this.Seq_PlayerRideHelicopter = {
	Messages = {
		Character = {
			{ data = "SupportHelicopter",		message = "CloseDoor",		localFunc = "FuncMissionClearDemo" },
			{ data = "SupportHelicopter", 		message = "LostControl", commonFunc = function() GZCommon.PlayCameraOnCommonHelicopterGameOver() end },
		},
	},

	OnEnter = function()
		
	end,

	FuncMissionClearDemo = function()
		
		TppMission.ChangeState( "failed", "PlayerHeli" )

		TppMission.SetFlag( "isMarkHeli", false )
		setHeliMarker()
	end,
}



this.Seq_MissionGameOver = {
	
	MissionState = "gameOver",

	Messages = {
		UI = {
			
			{ message = "GameOverOpen" ,	localFunc = "OnFinishGameOverFade" },
		},
	},

	
	OnFinishGameOverFade = function()




		SubtitlesCommand.SetIsEnabledUiPrioStrong( true )	
		TppRadio.DelayPlay( this.CounterList.GameOverRadioName, nil, "none" )	

	end,

	OnEnter = function()
		
	end,
}




this.OnSkipEnterCommon = function()

	local sequence = TppSequence.GetCurrentSequence()

	
	if( TppSequence.IsGreaterThan( sequence, "Seq_MissionPrepare" ) ) then



		this.onMissionPrepare()
		lowPolyPlayer()

		
		
		this.tmpBestRank = GZCommon.CheckClearRankReward( this.missionID, this.ClearRankRewardList )




		
		local uiCommonData = UiCommonDataManager.GetInstance()
		this.tmpRewardNum = uiCommonData:GetRewardNowCount( this.missionID )



		
	end

	
	if( TppSequence.IsGreaterThan( sequence, "Seq_MissionFailed" ) ) then
		TppMission.ChangeState( "failed" )
	elseif( TppSequence.IsGreaterThan( sequence, "Seq_MissionAbort" ) ) then
		TppMission.ChangeState( "abort" )
	elseif( TppSequence.IsGreaterThan( sequence, "Seq_MissionClearDemo" ) ) then
		TppMission.ChangeState( "clear" )
	elseif( TppSequence.IsGreaterThan( sequence, "Seq_MissionPrepare" ) ) then
		onDemoBlockLoad()
	elseif( sequence == "Seq_MissionPrepare" ) then
		
		onDemoBlockLoad()
	end
end

this.OnSkipUpdateCommon = function()
	
	
	return IsDemoAndEventBlockActive()
end

this.OnSkipLeaveCommon = function()

	local sequence = TppSequence.GetCurrentSequence()

	
	if( TppSequence.IsGreaterThan( sequence, "Seq_MissionLoad" )
		or sequence == "Seq_OpeningDemoEnd" ) then
		MissionSetup()	
		
		commonPhotoMissionSetup()
		
		commonRouteSetMissionSetup()

		
		if( TppMission.GetFlag( "isClearComp" ) == false )then
			TppMission.SetFlag( "isRadioAraskaSay",false )
			TppRadio.DelayPlay( "Miller_op003", "long",nil,{onStart = function() 	this.SetIntelRadio() end,onEnd =function() radioStartCheckEndOfKonkai() end })
		end

	end

end


this.OnAfterRestore = function()
	chengeRouteSneak("warp")
	TppMission.SetFlag( "isMarkHeli", false )
	setHeliMarker()
	TppMarkerSystem.ResetAllNewMarker()
	

end



return this
