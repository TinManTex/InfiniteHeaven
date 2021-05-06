local this = {}


this.missionID	= 20010
this.cpID		= "gntn_cp"
this.tmpBestRank = 0				
this.tmpRewardNum = 0				



this.demoStaPlayer_chico = "Stand"
this.eneCheckSize_chico = Vector3(24,6,28) 
this.hostageCheckSize = Vector3(2.6,4.8,4.7)
this.hostageOtherCheckSize = Vector3(40.7, 4.8, 40.9)

this.demoStaPlayer_paz = "Stand"
local eneCheckSize_paz = Vector3(27,7,26) 

local eneCheckSize_seaside = Vector3(38.7,9.1, 26.8 ) 
local eneCheckSize_bukiko = Vector3(5.9, 5.8, 8.4)

this.demoSeaSideDist = 18
this.demoSeaSideDist = 18

this.demoCamRot = 0.15
this.demoCamSpeed = 1.8

this.openingDemoSkipCount = 0




this.RequiredFiles = {
	"/Assets/tpp/script/common/GZCommon.lua",
	"/Assets/tpp/level/mission/extra/e20010/e20010_require_01.lua",
}

this.Sequences = {
	
	{ "Seq_MissionPrepare" },				
	
	{ "Seq_MissionSetup" },					
	{ "Seq_OpeningDemoLoad" },				
	{ "Seq_MissionLoad" },					
	{ "Seq_Mission_Failed" },				
	{ "Seq_HelicopterDeadNotOnPlayer" },	
	{ "Seq_MissionGameOver" },				
	{ "Seq_Mission_End" },					
	{ "Seq_Mission_Clear" },				
	{ "Seq_Mission_Telop" },				
	
	{ "Seq_RescueHostages" },				
	{ "Seq_NextRescuePaz" },				
	{ "Seq_NextRescueChico" },				
	{ "Seq_ChicoPazToRV" },					
	{ "Seq_PazChicoToRV" },					
	{ "Seq_PlayerOnHeli" },					
	{ "Seq_PlayerOnHeliAfter" },			
	
	{ "Seq_OpeningDemoPlay" },				
	{ "Seq_RescueChicoDemo01" },			
	{ "Seq_RescueChicoDemo02" },			
	{ "Seq_RescuePazDemo" },				
	{ "Seq_QuestionChicoDemo" },			
	{ "Seq_QuestionPazDemo" },				
	{ "Seq_CassetteDemo" },					
}

this.OnStart = function( manager )
	GZCommon.Register( this, manager )
	TppMission.Setup()
end


this.ChangeExecSequenceList =  {
	"Seq_MissionLoad",
	"Seq_RescueHostages",
	"Seq_NextRescuePaz",
	"Seq_NextRescueChico",
	"Seq_ChicoPazToRV",
	"Seq_PazChicoToRV",
	"Seq_PlayerOnHeli",
	"Seq_PlayerOnHeliAfter",
	 "Seq_OpeningDemoPlay",
	"Seq_RescueChicoDemo01",			
	"Seq_RescueChicoDemo02",			
	"Seq_RescuePazDemo",				
	"Seq_QuestionChicoDemo",			
	"Seq_QuestionPazDemo",				
	"Seq_CassetteDemo" ,					
}


this.ClearRankRewardList = {

	
	RankS = "Rank_S_Reward_Assault",
	RankA = "Rank_A_Reward_Sniper",
	RankB = "Rank_B_Reward_Missile",
	RankC = "Rank_C_Reward_SubmachinGun",
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
	
	isPlayerOnHeli				= false,		
	isFirstEncount_Chico		= false,		
	isEncounterChico			= false,		
	isQuestionChico				= false,		
	isPlaceOnHeliChico			= false,		
	isFinishOnHeliChico			= false,		
	isChicoPrisonBreak			= false,		
	isEncounterPaz				= false,		
	isQuestionPaz				= false,		
	isPlaceOnHeliPaz			= false,		
	isPazPrisonBreak			= false,		
	isPazChicoDemoArea			= false,		
	isSaftyArea01				= false,		
	isSaftyArea02				= false,		
	isDangerArea				= false,		
	isPazChicoDangerArea		= false,		
	isHeliComingRV				= false,		
	isHeliComeToSea				= false,		
	isHeliLandNow				= false,		
	isChicoTapeGet				= false,		
	isChicoTapePlay				= false,		

	isAlertTapeAdvice			= false,		
	isPlayInterrogationAdv		= false,		
	isHostageUnusual			= false,		
	isKeepCaution				= false,		
	isPlaceOnHeliSpHostage		= false,		
	isFinishOnHeliSpHostage		= false,		
	isCarryOnSpHostage			= false,		
	isGetDuctInfomation			= false,		
	isGunTutorialArea			= false,		
	isPreCarryAdvice			= false,		
	isDoCarryAdvice 			= false,		
	isCenterBackEnter			= false,		
	isAfterChicoDemoHostage		= false,		
	isCarTutorial				= false,		
	isBehindTutorial			= 0,			
	isInSeaCliffArea			= false,		
	isInStartCliffArea			= false,		
	isAlertCageCheck			= false,		
	isDoneCQC					= false,		
	isAsylumRadioArea			= false,		
	isDramaPazArea				= false,		
	isPrimaryWPIcon				= false,		
	isMissionStartRadio			= false,		
	isSearchLightChicoArea		= 0,			
	isSpHostage_Dead			= false,		
	isCenterTowerEnemy			= false,		
	isPlaceOnHeliHostage04		= false,		
	isFinishOnHeliHostage04		= false,		
	isGetXofMark_Hostage04		= false,		
	isHostageOnVehicle			= false,		
	
	isCassetteDemo				= false,		
	isSwitchLightDemo			= false,		
	isDemoRelativePlay			= false,		
	
	isTalkChicoTapeFinish		= false,		
	isKillSpHostageEnemy01		= false,		
	isKillingSpHostage			= false,		
	isCTE0010_0280_NearArea		= false,		
	isCTE0010_0310_NearArea		= false,		
	isEscapeHostage				= false,		
	
	isAsyInsideRouteChange_01	= false,		
	isCenter2F_EneRouteChange	= false,		



	isSmokingRouteChange		= false,		
	isVehicle_Seq30_0506Start	= false,		
	isArmorVehicle_Start		= 0,			

	isSeq10_02_DriveEnd			= 0,			
	isSeq10_03_DriveEnd			= 0,			
	isSeq20_02_DriveEnd			= 0,			
	isSeq40_0304_DriveEnd		= 0,			
	
	isSeq10_05SL_ON				= false,		
	isAsyPickingDoor05			= false,		
	isAsyPickingDoor15			= false,		
	isTruckSneakRideOn			= false,		
	isInterrogation_Count		= 0,			
	isInterrogation_Radio		= false,		
	isNoConversation_GateInTruck	= false,	
	isChicoPaz1stCarry			= false,		
	isSpHostageEncount			= false,		
	isChicoHeliJingle			= false,		
	isPazHeliJingle				= false,		
	isChicoMarkJingle			= false,		
	isPazMarkJingle				= false,		
	isCenterEnter				= false,		
	isSaveAreaNo				= 0,			
	isSpHostageKillVersion		= false,		
	
	isWoodTurret01_Break		= false,		
	isWoodTurret02_Break		= false,		
	isWoodTurret03_Break		= false,		
	isWoodTurret04_Break		= false,		
	isWoodTurret05_Break		= false,		
	isIronTurretSL01_Break		= false,		
	isIronTurretSL02_Break		= false,		
	isIronTurretSL04_Break		= false,		
	isIronTurretSL05_Break		= false,		
	isCenterTowerSL_Break		= false,		
	isWappenDemo				= false,		
}



this.DemoList = {
	ArrivalAtGz									= "p11_010100_000",	
	EncounterChico_BeforePaz_WithHostage		= "p11_010120_000",	
	EncounterChico_BeforePaz_WithoutHostage		= "p11_010125_000",	
	EncounterChico_BeforePaz_NoHostage			= "p11_010126_000",	
	EncounterChico_AfterPaz_WithHostage			= "p11_010110_000",	
	EncounterChico_AfterPaz_WithoutHostage		= "p11_010115_000",	
	EncounterChico_AfterPaz_NoHostage			= "p11_010116_000",	
	QuestionChico								= "p11_010140_000",	
	QuestionChicoCut							= "p11_010145_000",	
	EncounterPaz								= "p11_010130_000",	
	QuestionPaz									= "p11_010150_000",	
	QuestionPazCut								= "p11_010155_000",	
	SwitchLightDemo								= "p11_020001_000",		
	BigGateOpenDemo								= "p11_020005_000",		
	Demo_AreaEscapeNorth						= "p11_020010_000",	
	Demo_AreaEscapeWest							= "p11_020020_000",	
	Demo_XOFrolling								= "p11_010170_000", 
	Demo_CassettePlayWithTapeL					= "p11_010149_000", 
	Demo_CassettePlayWithTapeR					= "p11_010148_000", 
	Demo_CassettePlayWithoutTapeL				= "p11_010147_000", 
	Demo_CassettePlayWithoutTapeR				= "p11_010146_000", 
}



this.CounterList = {
	GameOverRadioName			= "NoRadio",		
	GameOverFadeTime			= GZCommon.FadeOutTime_MissionFailed,	
	PlayQuestionDemo 			= "QuestionChico"
}





this.RadioList = {
	
	Miller_CarryDownInDanger		= "e0010_rtrg0090",			
	Miller_ChicoOnHeliAdvice		= "e0010_rtrg0250",			
	Miller_PazOnHeliAdvice			= "e0010_rtrg0260",			
	Miller_EnemyOnHeli				= "e0010_rtrg1240",			
	Miller_KillHostage				= "e0010_rtrg1245",			
	Miller_DontSneakPhase			= "e0010_rtrg0240",			
	Miller_DontEscapeTargetOnHeli	= "e0010_rtrg0340",			
	Miller_TargetOnHeliAdvice		= "e0010_rtrg0360",			
	Miller_DontOnHeliOnlyPlayer		= "e0010_rtrg0370",			
	Miller_CallHeli01				= "e0010_rtrg0378",			
	Miller_CallHeli02				= "e0010_rtrg0379",			
	Miller_CallHeliHot01			= "e0010_rtrg0376",			
	Miller_CallHeliHot02			= "e0010_rtrg0377",			
	Miller_HeliNoCall				= "e0010_rtrg0375",			
	Miller_MissionFailedOnHeli		= "e0010_rtrg0380",			
	Miller_StartCallHeli			= {"e0010_rtrg0381", 1},	
	Miller_HeliLeave				= "e0010_rtrg0390",			
	Miller_HeliAttack				= "e0010_rtrg0400",			
	Miller_WarningFlareAdvice		= {"e0010_rtrg0420", 1},	





	Miller_UnKillGunAdvice			= {"e0010_rtrg0570", 1},	
	Miller_BreakSuppressor			= "e0010_rtrg0636",			
	Miller_EspionageRadioAdvice		= {"e0010_rtrg0660", 1},	
	Miller_CqcAdvice				= {"e0010_rtrg0670", 1},	
	Miller_InterrogationAdvice		= {"e0010_rtrg0680", 1},	
	Miller_RestrictAdvice			= {"e0010_rtrg0681", 1},	
	Miller_QustionAdvice			= {"e0010_rtrg0682", 1},	


	Miller_MillerEludeFall			= {"e0010_rtrg0690", 1},	
	Miller_MillerEludeNoFall		= {"e0010_rtrg0692", 1},	

	Miller_SpRecoveryLifeAdvice		= "e0010_rtrg0710",			

	Miller_CuarAdvice				= "e0010_rtrg0731",			



	Miller_MissionAreaOut			= "e0010_rtrg0790",			
	Miller_MissileGet				= {"e0010_rtrg0810", 1},	
	Miller_GranadoGet				= {"e0010_rtrg0813", 1},	
	Miller_BreakAAG					= "e0010_rtrg0816",			
	Miller_AtherCagePicking			= "e0010_rtrg0825",			
	Miller_AtherHostageAdvice		= {"e0010_rtrg0830", 1},	
	Miller_SpWeaponGet				= {"e0010_rtrg0890", 1},	
	Miller_EmptyMagazin				= "e0010_rtrg0910",			
	Miller_MarkingTutorial			= {"e0010_rtrg0930", 1},	


	Miller_CoverTutorial			= {"e0010_rtrg0967", 1},	
	Miller_CrawlTutorial			= {"e0010_rtrg0968", 1},	

	Miller_CommonHostageInformation	= "e0010_rtrg0980",			
	Miller_XofMarking				= "e0010_rtrg1000",			


	Miller_StrykerDriveAdvice		= {"e0010_rtrg1060", 1},	
	Miller_AboutXofMark				= "e0010_rtrg1070",			
	Miller_AboutXofMarkTwo			= "e0010_rtrg1071",			
	Miller_AllXofMarkGet			= "e0010_rtrg1075",			
	Miller_PlayerOnHeliAdvice		= "e0010_rtrg1080",			


	Miller_HohukuAdvice				= {"e0010_rtrg1250", 1},	

	Miller_InHeliport				= {"e0010_rtrg3050", 1},	
	Miller_GetPazInfo				= {"e0010_rtrg1260", 1},	
	Miller_AllGetTape				= {"e0010_rtrg4010", 1},	
	Miller_JointVoice01				= "e0010_rtrg9900",			

	Miller_TapeReaction00			= {"e0010_rtrg1269", 1},	
	Miller_TapeReaction01			= "e0010_rtrg1270",			
	Miller_TapeReaction02			= "e0010_rtrg1271",			
	Miller_TapeReaction03			= "e0010_rtrg1272",			
	Miller_TapeReaction04			= "e0010_rtrg1273",			
	Miller_TapeReaction05			= "e0010_rtrg1274",			

	Miller_TapeReaction07			= {"e0010_rtrg0111", 1},	



	Miller_SecurityCameraAdvice		= {"e0010_rtrg2050", 1},	
	
	Miller_MissionStart				= {"e0010_rtrg0010", 1},	
	Miller_MissionContinue			= {"e0010_rtrg0009", 1},	

	Miller_CallAdvice				= {"e0010_rtrg0031", 1},	
	Miller_MovingAdvice				= {"e0010_rtrg0040", 1},	
	Miller_DeviceAdvice				= {"e0010_rtrg0041", 1},	
	Miller_ChangePostureAdvice		= {"e0010_rtrg0940", 1},	
	Miller_EnemyCopeOnlyVersion		= {"e0010_rtrg0950", 1},	
	Miller_EnemyCopeOnlyCQC			= {"e0010_rtrg0952", 1},	
	Miller_TranquilizerGunAdvice	= {"e0010_rtrg0960", 1},	

	Miller_DiscoverySpHostage		= {"e0010_rtrg1090", 1},	
	Miller_MarkingExTape			= {"e0010_rtrg1150", 1},	
	Miller_MarkingExhaveTape		= {"e0010_rtrg1152", 1},	
	Miller_StepOnAdvice				= {"e0010_rtrg1170", 1},	
	Miller_PreCarryAdvice			= "e0010_rtrg0965",			
	Miller_DramaChico				= {"e0010_rtrg2020", 1},	
	Miller_Drama2Chico				= {"e0010_rtrg2021", 1},	
	Miller_InOldAsylum				= {"e0010_rtrg0050", 1},	
	
	Miller_TakeChicoToRVPoint		= {"e0010_rtrg0060", 1},	
	Miller_TakeChicoOnHeli			= "e0010_rtrg0061",			

	Miller_ChicoTapeAdvice01		= "e0010_rtrg0100",			
	Miller_ChicoTapeAdvice02		= {"e0010_rtrg0101", 1},	
	Miller_ChicoTapeReAdvice		= {"e0010_rtrg0110", 1},	

	Miller_PazTakeRouteInHeliport	= {"e0010_rtrg0140", 1},	
	Miller_PazTakeRouteInGate		= {"e0010_rtrg0150", 1},	
	Miller_PazTakeRouteInBoilar		= {"e0010_rtrg0160", 1},	
	Miller_PazTakeRouteInFlag		= {"e0010_rtrg0130", 1},	


	Miller_LeadSpHostageEscape		= {"e0010_rtrg1140", 1},	
	Miller_EscapeOrAttack			= {"e0010_rtrg1160", 1},	
	Miller_DramaPaz1				= {"e0010_rtrg2010", 1},	
	Miller_DramaPaz2				= {"e0010_rtrg2011", 1},	


	Miller_RescuePaz1				= {"e0010_rtrg3030", 1},	
	Miller_RescuePaz2				= {"e0010_rtrg3035", 1},	
	Miller_InCenterCoverAdviceCQC	= {"e0010_rtrg3070", 1},	
	Miller_InCenterCoverAdvice		= {"e0010_rtrg3072", 1},	
	


	Miller_takePazToRVPoint01		= "e0010_rtrg0200",			
	Miller_takePazOnHeli			= {"e0010_rtrg0210", 1},	

	
	Miller_NearRV					= {"e0010_rtrg0070", 1},	
	Miller_ArriveRV					= {"e0010_rtrg0080", 1},	
	Miller_ArriveRVChico			= {"e0010_rtrg0083", 1},	
	Miller_ArriveRVChicoAlert		= {"e0010_rtrg0081", 1},	
	Miller_ArriveRVChicoNearEnemy	= {"e0010_rtrg0082", 1},	
	Miller_PazJailBreak				= "e0010_rtrg0220",			
	Miller_PazJailBreak2			= "e0010_rtrg0221",			
	Miller_EnemyDiscoveryChico		= "e0010_rtrg0320",			
	Miller_EnemyDiscoveryPaz		= "e0010_rtrg0330",			
	Miller_CallHeliAdvice			= {"e0010_rtrg0350", 1},	




	Miller_MeetChicoPazInCombat		= "e0010_rtrg1020",			
	Miller_MeetChicoPazNearEnemy	= "e0010_rtrg1022",			
	Miller_UlMeetChicoPazInCombat	= "e0010_rtrg1025",			
	Miller_UlMeetChicoPazNearEnemy	= "e0010_rtrg1026",			
	Miller_CarrySpHostage			= {"e0010_rtrg1095", 1},	
	Miller_RescueSpHostage			= {"e0010_rtrg1096", 1},	

	Miller_AboutDuct01				= "e0010_rtrg1110",			


	Miller_SwitchLightAdvice02		= {"e0010_rtrg1130", 1},	
	Miller_ReChicoAdviceEva			= "e0010_rtrg1180",			

	Miller_ReChicoAdviceCarrie		= "e0010_rtrg0085",			
	Miller_ReChicoAdviceOutRV		= "e0010_rtrg0086",			

	Miller_PazChicoCarriedEndRV		= "e0010_rtrg1220",			
	Miller_SearchChico				= {"e0010_rtrg1300", 1},	
	Miller_SearchLightChico			= {"e0010_rtrg1310", 1},	
	Miller_MillerHistory1			= {"e0010_rtrg2030", 1},	
	Miller_MillerHistory2			= {"e0010_rtrg2040", 1},	
	Miller_CliffAttention			= {"e0010_rtrg3020", 1},	
	Miller_Rain						= {"e0010_rtrg3040", 1},	
	Miller_Cheer					= {"e0010_rtrg3080", 1},	


	Miller_WatchPhotoChico			= {"e0010_rtrg1410", 1},	
	Miller_WatchPhotoPaz			= {"e0010_rtrg1420", 1},	
	Miller_WatchPhotoStart			= {"e0010_rtrg1429", 1},	
	Miller_WatchPhotoAll			= {"e0010_rtrg1430", 1},	
	
	Miller_DeadPlayer				= "f0033_gmov0010",			
	Miller_OutofMissionArea			= "f0033_gmov0020",			
	Miller_StopMission				= "f0033_gmov0030",			

	Miller_DeadChico				= "f0033_gmov0060",			
	Miller_KillChoco				= "f0033_gmov0070",			
	Miller_HeliDownChico			= "f0033_gmov0080",			
	Miller_DeadPaz					= "f0033_gmov0090",			
	Miller_KillPaz					= "f0033_gmov0100",			
	Miller_HeliDownPaz				= "f0033_gmov0110",			
	Miller_OnlyPcOnHeli				= "f0033_gmov0040",			
	Miller_HeliDead					= "f0033_gmov0050",			
	Miller_HeliKill					= "f0033_gmov0120",			
}

this.OptionalRadioList = {
	Optional_GameStartToRescue			= "Set_e0010_oprg0010",
	Optional_GameStartToRescueBino		= "Set_e0010_oprg1010",
	Optional_InOldAsylum				= "Set_e0010_oprg0011",
	Optional_DiscoveryChico				= "Set_e0010_oprg0012",
	Optional_RescueChicoToRVChico		= "Set_e0010_oprg0015",
	Optional_OnRVChico					= "Set_e0010_oprg0019",
	Optional_RVChicoToRescuePaz			= "Set_e0010_oprg0020",
	Optional_RVChicoToRescuePazBino		= "Set_e0010_oprg1020",
	Optional_ChicoOnHeli				= "Set_e0010_oprg0021",
	Optional_Interrogation				= "Set_e0010_oprg0022",
	Optional_InterrogationBino			= "Set_e0010_oprg1022",
	Optional_DiscoveryPaz				= "Set_e0010_oprg0025",
	Optional_RescuePazToRVPaz			= "Set_e0010_oprg0029",
	Optional_RescuePazToRescueChico		= "Set_e0010_oprg0030",
	Optional_RescuePazToRescueChicoBino	= "Set_e0010_oprg1030",
	Optional_RescueBothToRideHeli		= "Set_e0010_oprg0040",
	Optional_RideHeliChico				= "Set_e0010_oprg0041",
	Optional_RideHeliPaz				= "Set_e0010_oprg0042",
	Optional_RescueComplete				= "Set_e0010_oprg0043",
}

this.IntelRadioList = {
	
	intel_e0010_esrg0020	= "e0010_esrg0020",
	intel_e0010_esrg0030	= "e0010_esrg0030",
	intel_e0010_esrg0040	= "e0010_esrg0040",	
	intel_e0010_esrg0090	= "e0010_esrg0090",
	intel_e0010_esrg0110	= "e0010_esrg0110",
	intel_e0010_esrg0120	= "e0010_esrg0120",
	intel_e0010_esrg0190	= "e0010_esrg0190",
	intel_e0010_esrg0380	= "e0010_esrg0380",
	intel_e0010_esrg0440	= "e0010_esrg0440",
	intel_e0010_esrg0440_1	= "e0010_esrg0440",
	intel_e0010_esrg0450	= "e0010_esrg0450",
	intel_e0010_esrg0450_1	= "e0010_esrg0450",
	intel_e0010_esrg0450_2	= "e0010_esrg0450",
	intel_e0010_esrg0480	= "e0010_esrg0480",
	intel_e0010_esrg0490	= "e0010_esrg0490",
	
	Chico = "e0010_esrg0080",
	Paz   = "e0010_esrg0100",
	
	ComEne01 = "e0010_esrg0170",
	ComEne02 = "e0010_esrg0170",
	ComEne03 = "e0010_esrg0170",
	ComEne04 = "e0010_esrg0170",
	ComEne05 = "e0010_esrg0170",
	ComEne06 = "e0010_esrg0170",
	ComEne07 = "e0010_esrg0170",
	ComEne08 = "e0010_esrg0170",
	ComEne09 = "e0010_esrg0170",
	ComEne10 = "e0010_esrg0170",
	ComEne11 = "e0010_esrg0170",
	ComEne12 = "e0010_esrg0170",
	ComEne13 = "e0010_esrg0170",
	ComEne14 = "e0010_esrg0170",
	ComEne15 = "e0010_esrg0170",
	ComEne16 = "e0010_esrg0170",
	ComEne17 = "e0010_esrg0170",
	ComEne18 = "e0010_esrg0170",
	ComEne19 = "e0010_esrg0170",
	ComEne20 = "e0010_esrg0170",
	ComEne21 = "e0010_esrg0170",
	ComEne22 = "e0010_esrg0170",
	ComEne23 = "e0010_esrg0170",
	ComEne24 = "e0010_esrg0170",
	ComEne25 = "e0010_esrg0170",
	ComEne26 = "e0010_esrg0170",
	ComEne27 = "e0010_esrg0170",
	ComEne28 = "e0010_esrg0170",
	ComEne29 = "e0010_esrg0170",
	ComEne30 = "e0010_esrg0170",
	ComEne31 = "e0010_esrg0170",
	ComEne32 = "e0010_esrg0170",
	ComEne33 = "e0010_esrg0170",
	ComEne34 = "e0010_esrg0170",
	Seq10_01 = "e0010_esrg0170",
	Seq10_02 = "e0010_esrg0170",
	Seq10_05 = "e0010_esrg0170",
	Seq10_06 = "e0010_esrg0170",
	Seq10_07 = "e0010_esrg0170",
	SpHostage = "e0010_esrg0330",
	
	gntn_area01_antiAirGun_000 = "e0010_esrg0180",
	gntn_area01_antiAirGun_001 = "e0010_esrg0180",
	gntn_area01_antiAirGun_002 = "e0010_esrg0180",
	gntn_area01_antiAirGun_003 = "e0010_esrg0180",
	
	WoodTurret01 = "e0010_esrg0201",
	WoodTurret02 = "e0010_esrg0201",
	WoodTurret03 = "e0010_esrg0200",
	WoodTurret04 = "e0010_esrg0200",
	WoodTurret05 = "e0010_esrg0200",
	

	Tactical_Vehicle_WEST_002 = "e0010_esrg0210",
	Tactical_Vehicle_WEST_003 = "e0010_esrg0210",
	Tactical_Vehicle_WEST_004 = "e0010_esrg0210",
	Tactical_Vehicle_WEST_005 = "e0010_esrg0210",
	
	Cargo_Truck_WEST_002 = "e0010_esrg0290",
	Cargo_Truck_WEST_003 = "e0010_esrg0290",
	Cargo_Truck_WEST_004 = "e0010_esrg0290",
	
	Armored_Vehicle_WEST_001 = "e0010_esrg0390",


	
	SL_WoodTurret01 = "e0010_esrg0010",
	SL_WoodTurret02 = "e0010_esrg0010",
	SL_WoodTurret03 = "e0010_esrg0010",
	SL_WoodTurret04 = "e0010_esrg0010",
	SL_WoodTurret05 = "e0010_esrg0010",

	
	gntn_area01_searchLight_000 = "e0010_esrg0010",
	gntn_area01_searchLight_001 = "e0010_esrg0010",
	gntn_area01_searchLight_002 = "e0010_esrg0010",
	gntn_area01_searchLight_003 = "e0010_esrg0010",
	gntn_area01_searchLight_004 = "e0010_esrg0010",
	gntn_area01_searchLight_005 = "e0010_esrg0010",
	gntn_area01_searchLight_006 = "e0010_esrg0010",
	


	
	e20010_drum0025  = "e0010_esrg0430",
	e20010_drum0027  = "e0010_esrg0430",
	e20010_drum0040  = "e0010_esrg0430",
	e20010_drum0042  = "e0010_esrg0430",
	gntnCom_drum0002 = "e0010_esrg0430",
	gntnCom_drum0005 = "e0010_esrg0430",
	gntnCom_drum0011 = "e0010_esrg0430",
	gntnCom_drum0012 = "e0010_esrg0430",
	gntnCom_drum0015 = "e0010_esrg0430",
	gntnCom_drum0019 = "e0010_esrg0430",
	gntnCom_drum0020 = "e0010_esrg0430",
	gntnCom_drum0021 = "e0010_esrg0430",
	gntnCom_drum0022 = "e0010_esrg0430",
	gntnCom_drum0023 = "e0010_esrg0430",
	gntnCom_drum0024 = "e0010_esrg0430",
	gntnCom_drum0025 = "e0010_esrg0430",
	gntnCom_drum0027 = "e0010_esrg0430",
	gntnCom_drum0028 = "e0010_esrg0430",
	gntnCom_drum0029 = "e0010_esrg0430",
	gntnCom_drum0030 = "e0010_esrg0430",
	gntnCom_drum0031 = "e0010_esrg0430",
	gntnCom_drum0035 = "e0010_esrg0430",
	gntnCom_drum0037 = "e0010_esrg0430",
	gntnCom_drum0038 = "e0010_esrg0430",
	gntnCom_drum0039 = "e0010_esrg0430",
	gntnCom_drum0040 = "e0010_esrg0430",
	gntnCom_drum0041 = "e0010_esrg0430",
	gntnCom_drum0042 = "e0010_esrg0430",
	gntnCom_drum0043 = "e0010_esrg0430",
	gntnCom_drum0044 = "e0010_esrg0430",
	gntnCom_drum0045 = "e0010_esrg0430",
	gntnCom_drum0046 = "e0010_esrg0430",
	gntnCom_drum0047 = "e0010_esrg0430",
	gntnCom_drum0048 = "e0010_esrg0430",
	gntnCom_drum0065 = "e0010_esrg0430",
	gntnCom_drum0066 = "e0010_esrg0430",
	gntnCom_drum0068 = "e0010_esrg0430",
	gntnCom_drum0069 = "e0010_esrg0430",
	gntnCom_drum0070 = "e0010_esrg0430",
	gntnCom_drum0071 = "e0010_esrg0430",
	gntnCom_drum0072 = "e0010_esrg0430",
	gntnCom_drum0101 = "e0010_esrg0430",
	
	e20010_SecurityCamera_01 = "e0010_esrg0470",
	e20010_SecurityCamera_02 = "e0010_esrg0470",
	e20010_SecurityCamera_03 = "e0010_esrg0470",
	e20010_SecurityCamera_04 = "e0010_esrg0470",
}

local PrepareDisposal = function()
	
	local uiCommonData = UiCommonDataManager.GetInstance()
	this.tmpRewardNum = uiCommonData:GetRewardNowCount( this.missionID )



	
	TppGameSequence.SetGameFlag("rewardNumOfMissionStart", this.tmpRewardNum )

	
	if( TppMission.GetFlag( "isChicoTapeGet" ) == false ) then
		local uiCommonData = UiCommonDataManager.GetInstance()
		uiCommonData:HideCassetteTape( "tp_chico_03" )
	else
		
	end
	
	this.tmpBestRank = GZCommon.CheckClearRankReward( this.missionID, this.ClearRankRewardList )



	
	TppGameSequence.SetGameFlag("e20010_beforeBestRank", this.tmpBestRank )
	
	TppRadioCommand.SetEnableDisableRadioWhileChico3TapeIsPlaying( false )
end




local AnounceLog_area_warning = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_mission_area_warning" )
end

local AnounceLog_enemyReplacement = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_enemyReplacement" )
end

local AnounceLog_enemyDecrease = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_enemyDecrease" )
end

local AnounceLog_EncountChico = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_mission_40_20010_000_from_0_prio_0" )
end

local AnounceLog_EncountPaz = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_mission_40_20010_003_from_0_prio_0" )
end

local AnounceLog_CarryChicoToRV = function()
	if ( TppMission.GetFlag( "isSaftyArea01" ) == true ) then
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:AnnounceLogViewLangId( "announce_mission_40_20010_001_from_0_prio_0" )
	else
	end
end

local AnounceLog_CarryPazToRV = function()
	if ( TppMission.GetFlag( "isSaftyArea01" ) == true ) then
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:AnnounceLogViewLangId( "announce_mission_40_20010_004_from_0_prio_0" )
	else
	end
end

local AnounceLog_ChicoRideOnHeli = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_mission_40_20010_002_from_0_prio_0" )
end

local AnounceLog_PazRideOnHeli = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_mission_40_20010_005_from_0_prio_0" )
end

local AnounceLog_SpHostage = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_mission_40_20010_006_from_0_prio_0" )
end

local AnounceLog_SpHostageRideOnHeli = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_mission_40_20010_007_from_0_prio_0" )
end

local AnounceLog_HeliEscape = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_heli_escape" )
end

local AnounceLog_NormalHostageRideOnHeli = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_collection_hostage" )
end

local AnounceLog_EnemyRideOnHeli = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_collection_enemy" )
end

local AnounceLog_GetXofMark = function()
	local count = TppStorage.GetXOFEmblemCount()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_get_xof", count , 9 )

	if ( count == 1 ) then	
		TppRadio.DelayPlay("Miller_AboutXofMark", "short")
	elseif ( count == 2 ) then	
		TppRadio.DelayPlay("Miller_AboutXofMarkTwo", "short")
	elseif ( count == 9 ) then	
		TppRadio.DelayPlay("Miller_AllXofMarkGet", "short")
	end

end

local AnounceLog_MapUpdate = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_map_update" )
end

local AnounceLog_MissionUpdate = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_mission_info_update" )
end


local MissionArea_PcWarp = function()

	local player	= Ch.FindCharacterObjectByCharacterId( "Player" )
	local playerPos	= player:GetPosition()
	local x = playerPos:GetX()
	local z = playerPos:GetZ()

	
	if ( 4.5 < x ) and ( x < 72) and ( 2.5 < z) and ( z < 62.5 ) then



		TppMission.ChangeState( "failed", "MissionAreaOut" )
	
	elseif ( -380 < x ) and ( x < -293) and ( 113 < z) and ( z < 200) then



		TppMission.ChangeState( "failed", "MissionAreaOut" )
	else
		



	end
end




this.e20010_PlayerSetWeapons = function()
	local hardmode = TppGameSequence.GetGameFlag("hardmode")	
	if hardmode == true then
		TppPlayer.SetWeapons( GZWeapon.e20010_SetWeaponsHard )
	else
		TppPlayer.SetWeapons( GZWeapon.e20010_SetWeapons )
	end
end

this.e20010_PlayerSetWeapons = function()
	local hardmode = TppGameSequence.GetGameFlag("hardmode")	
	if hardmode == true then
		TppPlayer.SetWeapons( GZWeapon.e20010_SetWeaponsHard )
	else
		TppPlayer.SetWeapons( GZWeapon.e20010_SetWeapons )
	end
end


local Common_RetryKeepCautionSiren = function()
	
	if( TppMission.GetFlag( "isPazPrisonBreak" ) == true ) then
		local timer = 2
		GkEventTimerManager.Start( "Timer_CallCautionSiren", timer )
	else
		TppMusicManager.SetSwitch{
			groupName = "bgm_phase_ct_level",
			stateName = "bgm_phase_ct_level_01",
		}
	end
end


this.Seq_MissionPrepare = {
	OnEnter = function()
		this.e20010_PlayerSetWeapons()
		TppSequence.ChangeSequence( "Seq_MissionSetup" )
		PrepareDisposal()
	end,
}


local MissionSetup = function()
	
	


	TppEffectUtility.SetColorCorrectionLut( "gntn_25thDemo_FILTERLUT" )

	
	GrTools.SetLightingColorScale(1.0)
	
	TppClock.SetTime( "00:00:00" )
	TppClock.Stop()
	TppWeather.SetWeather( "pouring" )
	TppWeather.Stop()

	


	
	local cpRouteSets = {
		{
			cpID = "gntn_cp",
			sets = {
				sneak_night = "e20010_Seq00_SneakRouteSet",
				caution_night = "e20010_Seq00_CautionRouteSet",
			},
		},
	}
	TppEnemy.SetRouteSets( cpRouteSets )
	PrepareDisposal()
	


	TppRadio.SetAllSaveRadioId()
	
	TppNewCollectibleUtility.PutCollectibleOnCharacter{ id = "WP_hg02_v00", count = 90, target = "Cargo_Truck_WEST_002" , attachPoint = "CNP_USERITEM" }

	
	TppGadgetUtility.SetWillBeOpenedInDemo("AsyPickingDoor24")
	TppGadgetUtility.SetWillBeOpenedInDemo("Paz_PickingDoor00")
	TppGadgetUtility.AddDoorEnableCheckInfo("AsyPickingDoor24", Vector3(69,20,204), this.eneCheckSize_chico)
	TppGadgetUtility.AddDoorEnableCheckInfo("Paz_PickingDoor00", Vector3(-138, 24, -16), eneCheckSize_paz )

	



end







local IsEventBlockActive = function()
	if ( TppMission.IsEventBlockActive() == false ) then
		return false
	end

	
	local hudCommonData = HudCommonDataManager.GetInstance()
	if hudCommonData:IsEndLoadingTips() == false then
			hudCommonData:PermitEndLoadingTips() 
			
			return false
	end
	
	return true











end


local MainMissionLoad = function()
	
	TppData.GetData( "Chico" ).enable = true

	

end


local Check_AroundSpace = function( charaId )
	
	local warpPlayer = "notWarp"

	local player = Ch.FindCharacterObjectByCharacterId( "Player")
	local hikaku = player:GetRotation()

	if( TppMission.GetFlag( "isSaftyArea01" ) == true ) then
		if (TppMission.GetFlag( "isDemoRelativePlay" ) == false) then
			






			
			local player = Ch.FindCharacterObjectByCharacterId( "Player" )
			local playerPos = player:GetPosition()
			local point10 = TppData.GetPosition( "warp_demo_seaside10" )
			
			local checkPto10 = TppUtility.FindDistance( playerPos, point10 )




			
			if ( checkPto10 < this.demoSeaSideDist ) then
				



				warpPlayer = "warp_demo_seaside10"
			else
				



				warpPlayer = "warp_demo_seaside20"
			end

		else



			warpPlayer = "notWarp"
		end

	else
		
		return warpPlayer

	end

	return warpPlayer

end


local commonTranrationPlayer = function(stand,r)
	local sisei = "Stand"
	if( stand ~= nul)then
		sisei = stand
	end

	
	TppPlayerUtility.RequestToStartTransition{stance=sisei,direction=r,doKeep = true}


end


local Check_SafetyArea_enemy = function(id,size)



	local checkPos = TppData.GetPosition( id ) 
	

	local eneNum = 0














	eneNum = TppEnemyUtility.GetNumberOfActiveSoldierByBoxShape( checkPos, size )





	
	local player = Ch.FindCharacterObjectByCharacterId( "Player" )
	local playerPos = player:GetPosition()
	local point10 = TppData.GetPosition( "warp_demo_seaside10" )
	
	local checkPto10 = TppUtility.FindDistance( playerPos, point10 )




	
	local n = 0
	if ( checkPto10 < this.demoSeaSideDist ) then
		
	else
		



		local pos = Vector3( 135, 5, 110 )
		local size = Vector3( 10, 10, 10 )					
		local rot = Quat( 0.0, 0.0, 0.0, 0.0 )			


		local vehicleIds = 0
		vehicleIds = TppVehicleUtility.GetVehicleByBoxShape( pos, size, rot )

		
		if( vehicleIds and #vehicleIds.array > 0 ) then
			for i,id in ipairs( vehicleIds.array ) do
				n = n + 1
			end
		end
	end





	if( eneNum == 0 )then

		if( n == 0 )then
			return true
		else
			
			return false
		end
	else
		
		return false
	end

end


local Check_SafetyArea = function()



	local check = false

	if( TppMission.GetFlag( "isSaftyArea01" ) == true )then
		check = Check_SafetyArea_enemy("eneCheck_seaside",eneCheckSize_seaside)
	end

	return ( check )
end


local CheckDemoCondition = function()



	local phase = TppEnemy.GetPhase( this.cpID )
	if ( phase == "alert" ) then



		return false
	else
		if ( Check_SafetyArea() == true ) then



			return true
		else
			return false
		end
	end

end




local changeEnablePickingDoor = function( id, doing )


























end

local Demo_eneChecker = function( flag ) 
	
	




	local enemyNum = 0
	local phase = TppEnemy.GetPhase( cpID )
	local radioDaemon = RadioDaemon:GetInstance()





	if ( phase == "alert") then 
		
		TppRadio.Play( "Miller_MeetChicoPazInCombat" )
		TppMission.SetFlag( "isAlertCageCheck", true )



	else

		if ( flag == "chico") then
			
			enemyNum = TppEnemyUtility.GetNumberOfActiveSoldierByBoxShape( Vector3(69, 20, 204), this.eneCheckSize_chico )




			if ( enemyNum >= 1 ) then
				changeEnablePickingDoor( "AsyPickingDoor24", "lock" )
				TppRadio.Play( "Miller_MeetChicoPazNearEnemy" )
			else
				changeEnablePickingDoor( "AsyPickingDoor24", "unlock" )
				if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1022") == true ) then
					TppRadio.Play( "Miller_UlMeetChicoPazNearEnemy" )
				end
			end

		else
			
			
			enemyNum = TppEnemyUtility.GetNumberOfActiveSoldierByBoxShape( Vector3(-138, 24, -16), eneCheckSize_paz )




			if ( enemyNum >= 1 ) then
				changeEnablePickingDoor( "Paz_PickingDoor00", "lock" )
				TppRadio.Play( "Miller_MeetChicoPazNearEnemy" )
			else
				changeEnablePickingDoor( "Paz_PickingDoor00", "unlock" )
				if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1022") == true ) then
					TppRadio.Play( "Miller_UlMeetChicoPazNearEnemy" )
				end
			end

		end
	end
end

local Demo_hosChecker = function()

	
	
	



	local hosNum = 0

	
	local checkPos = TppData.GetPosition( "hosCheck_chico" ) 
	local npcIds = TppNpcUtility.GetNpcByBoxShape( checkPos, this.hostageOtherCheckSize )
	if npcIds and #npcIds.array > 0 then
		for i,id in ipairs(npcIds.array) do
			local type = TppNpcUtility.GetNpcType( id )
			if type == "Hostage" then
				
				local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )

				if( characterId ~="Chico" and characterId ~="Paz" )then
					
					
					local status = TppHostageUtility.GetStatus( characterId )
					if status == "Normal" then
						
						hosNum = hosNum + 1
					end
				end
			end
		end
	end

	
	if ( hosNum == 0 ) then



		return 0
	else

		
		
		if TppMission.GetFlag( "isHostageUnusual" ) then
			



			return 1
		else
		




			
			hosNum = 0
			local checkPos = TppData.GetPosition( "eneCheck_chico_hos" )
			local npcIds = TppNpcUtility.GetNpcByBoxShape( checkPos, this.hostageCheckSize )
			if npcIds and #npcIds.array > 0 then
				for i,id in ipairs(npcIds.array) do
					local type = TppNpcUtility.GetNpcType( id )
					if type == "Hostage" then
						
						local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
						if( characterId =="Hostage_e20010_001" or characterId =="Hostage_e20010_002")then
							hosNum = hosNum + 1
						end
					end
				end
			end

			



			if (hosNum >= 2) then
				



				return 2
			else
				



				return 1
			end
		end
	end
end

local ChengeChicoPazIdleMotion = function()



	
	if ( TppMission.GetFlag( "isEncounterPaz" ) == false ) then



		TppHostageManager.GsSetSpecialIdleFlag( "Paz", true )
	else



		TppHostageManager.GsSetSpecialIdleFlag( "Paz", false )
	end

	if( TppMission.GetFlag( "isQuestionChico" ) == true ) then			






		TppHostageManager.GsSetSpecialFaintFlag( "Chico", false )
		TppHostageManager.GsSetSpecialIdleFlag( "Chico", false )
	else
		if ( TppMission.GetFlag( "isEncounterChico" ) == false ) then 	



			TppHostageManager.GsSetSpecialIdleFlag( "Chico", true )
		else






			TppHostageManager.GsSetSpecialIdleFlag( "Chico", false )
			TppHostageManager.GsSetSpecialFaintFlag( "Chico", true )	
		end
	end
end


local DropXOFCrawRoling = function()
	
	local rolling = TppData.GetArgument( 1 )
	local result = TppStorage.HasXOFEmblem(9)







	if( rolling == 10 and result == 0 and TppMission.GetFlag( "isWappenDemo" ) == false)then




		local onDemoEnd = function()
			TppMission.SetFlag( "isWappenDemo", true )
			
			local player = TppPlayerUtility.GetLocalPlayerCharacter()
			local pos = player:GetPosition()

			local vel = player:GetRotation():Rotate( Vector3( -1.5, 1.5, 0) )

			local offset = player:GetRotation():Rotate( Vector3( 0.0, 0, 0) )
			TppNewCollectibleUtility.DropItem{ id = "IT_XOFEmblem", index = 9, pos = pos+offset, rot = Quat.RotationY(1.5), vel = vel, rotVel = Vector3(0,2,0) }
			
			
			TppCharacterUtility.SetMeshVisible("Player","MESH_XOF_IV",false)
			
			Common_RetryKeepCautionSiren()
			
			MissionArea_PcWarp()
		end
		TppDemo.Play( "Demo_XOFrolling" , {onEnd = onDemoEnd })

	end
end

local RegisterRadioCondition = function()
	TppRadioConditionManagerAccessor.Register(
												"Tutorial", 				
												TppRadioConditionTutorialPlayer{
														time = 1.5, 	
														descMessage = {
																		
																		"PlayerBehind", "Behind",
																		"PlayerBinocle", "BinocleHold",
																		"PlayerRecovering", "Recovering",
																		"PlayerElude", "Elude",
																		"PlayerCrawl", "Crawl"
														},
												}
										)

	TppRadioConditionManagerAccessor.Register( "Basic", TppRadioConditionPlayerBasic{ time = 0.3 } )
end


local MapIconText = function()

		local commonDataManager = UiCommonDataManager.GetInstance()
		if commonDataManager == NULL then
				return
		end

		local luaData = commonDataManager:GetUiLuaExportCommonData()
		if luaData == NULL then
				return
		end

		luaData:SetupIconUniqueInformationTable(
				
				{ markerId="20010_marker_Chico",				langId="marker_info_mission_targetArea" }		
				,{ markerId="20010_marker_ChicoPinpoint",		langId="marker_info_chico" }					
				,{ markerId="20010_marker_Paz",					langId="marker_info_mission_targetArea" }		
				
				,{ markerId="Chico",							langId="marker_info_chico" }					
				,{ markerId="Paz",								langId="marker_info_paz" }						
				,{ markerId="SpHostage",						langId="marker_info_hostage_esc" }				
				
				,{ markerId="Tactical_Vehicle_WEST_002",		langId="marker_info_vehicle_4wd" }
				,{ markerId="Tactical_Vehicle_WEST_003",		langId="marker_info_vehicle_4wd" }
				,{ markerId="Tactical_Vehicle_WEST_004",		langId="marker_info_vehicle_4wd" }
				,{ markerId="Tactical_Vehicle_WEST_005",		langId="marker_info_vehicle_4wd" }
				
				,{ markerId="Cargo_Truck_WEST_002",				langId="marker_info_truck" }
				,{ markerId="Cargo_Truck_WEST_003",				langId="marker_info_truck" }
				,{ markerId="Cargo_Truck_WEST_004",				langId="marker_info_truck" }
				
				,{ markerId="Armored_Vehicle_WEST_001",			langId="marker_info_APC" }
				,{ markerId="Armored_Vehicle_WEST_002",			langId="marker_info_APC" }
				,{ markerId="Armored_Vehicle_WEST_003",			langId="marker_info_APC" }
				
				,{ markerId="20010_marker_RV",					langId="marker_info_RV" }						
				,{ markerId="e20010_marker_PowerSupply",		langId="marker_info_place_00" }					
				,{ markerId="Marker_Duct",						langId="marker_info_place_01" }					
				,{ markerId="e20010_marker_Kill",				langId="marker_info_place_03" }					
				,{ markerId="common_marker_Armory_WareHouse",	langId="marker_info_place_armory" }				
				,{ markerId="common_marker_Armory_HeliPort",	langId="marker_info_place_armory" }				
				,{ markerId="common_marker_Armory_Center",		langId="marker_info_place_armory" }				
				,{ markerId="common_marker_Area_EastCamp",		langId="marker_info_area_00" }					
				,{ markerId="common_marker_Area_WestCamp",		langId="marker_info_area_01" }					
				,{ markerId="common_marker_Area_WareHouse",		langId="marker_info_area_02" }					
				,{ markerId="common_marker_Area_HeliPort",		langId="marker_info_area_03" }					
				,{ markerId="common_marker_Area_Center",		langId="marker_info_area_04" }					
				,{ markerId="common_marker_Area_Asylum",		langId="marker_info_area_05" }					
				
				,{ markerId="e20010_marker_Ammo01",				langId="marker_info_bullet_tranq" }				
				,{ markerId="e20010_marker_Ammo02",				langId="marker_info_bullet_tranq" }				
				,{ markerId="e20010_marker_Ammo03",				langId="marker_info_bullet_tranq" }				
				,{ markerId="e20010_marker_Ammo04",				langId="marker_info_bullet_tranq" }				
				,{ markerId="e20010_marker_Ammo05",				langId="marker_info_bullet_tranq" }				


				

				,{ markerId="e20010_marker_SniperRifle",		langId="marker_info_weapon_01" }				

				,{ markerId="e20010_marker_ShotGun",			langId="marker_info_weapon_03" }				



				,{ markerId="e20010_marker_Grenade",			langId="marker_info_weapon_07" }				

				
				,{ markerId="e20010_marker_Cassette",			langId="marker_info_item_tape" }				
				,{ markerId="Marker_Cassette",					langId="marker_info_item_tape" }				
				,{ markerId="Marker_XOF",						langId="marker_info_item_xof" }					
				,{ markerId="e20010_marker_Patch01",			langId="marker_info_item_xof" }					
				,{ markerId="e20010_marker_Patch02",			langId="marker_info_item_xof" }					
				,{ markerId="e20010_marker_Patch03",			langId="marker_info_item_xof" }					
				,{ markerId="e20010_marker_Patch04",			langId="marker_info_item_xof" }					
		)
end

local Setting_Seq_RescueHostages_RouteSet = function()

	local sequence = TppSequence.GetCurrentSequence()

	if ( sequence == "Seq_MissionLoad" ) then
		
	else
	end
	
	
	TppEnemy.DisableRoute( this.cpID , "Seq10_02_RideOnVehicle" )
	TppEnemy.DisableRoute( this.cpID , "S_GoToExWeaponTruck" )
	TppEnemy.DisableRoute( this.cpID , "S_GoTo_EastCamp" )
	TppEnemy.DisableRoute( this.cpID , "S_Sen_EastCamp_SouthLeftGate" )
	TppEnemy.DisableRoute( this.cpID , "S_Pat_WestCampOutLine" )
	TppEnemy.DisableRoute( this.cpID , "S_RainTalk_ComEne05" )
	TppEnemy.DisableRoute( this.cpID , "S_GoTo_SeaSideEnter" )
	TppEnemy.DisableRoute( this.cpID , "S_GoTo_EastCampNorthTower" )
	TppEnemy.DisableRoute( this.cpID , "S_Sen_SeaSideEnter" )
	TppEnemy.DisableRoute( this.cpID , "S_SL_EastCamp_North" )
	TppEnemy.DisableRoute( this.cpID , "S_SL_EastCamp_South_in" )
	TppEnemy.DisableRoute( this.cpID , "S_Seq10_03_RideOnTruck" )
	TppEnemy.DisableRoute( this.cpID , "S_GunTutorial_Route" )
	TppEnemy.DisableRoute( this.cpID , "S_Sen_AsylumBehind" )
	TppEnemy.DisableRoute( this.cpID , "S_GoToSearchEscapeHostage_a" )
	TppEnemy.DisableRoute( this.cpID , "S_GoToSearchEscapeHostage_b" )
	TppEnemy.DisableRoute( this.cpID , "S_Pat_AsylumInside_Ver02" )
	TppEnemy.DisableRoute( this.cpID , "S_Pat_AsylumInside_Ver03" )
	TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_go" )
	TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_back" )
	TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2manSeparate01" )
	TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2manSeparate02" )
	TppEnemy.DisableRoute( this.cpID , "S_Mov_Center_d" )
	TppEnemy.DisableRoute( this.cpID , "S_Ret_Center_d" )
	TppEnemy.DisableRoute( this.cpID , "S_Mov_Smoking_Center" )
	TppEnemy.DisableRoute( this.cpID , "S_Mov_Center_2Fto1F" )
	TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_e" )
	TppEnemy.DisableRoute( this.cpID , "S_Mov_CenterHouse_a" )
	TppEnemy.DisableRoute( this.cpID , "S_Mov_CenterHouse_b" )
	TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_a" )
	TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_b" )
	TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret01_Route" )
	TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret02_Route" )
	TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret03_Route" )
	TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret04_Route" )
	TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret05_Route" )
	TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL01_Route" )
	TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL02_Route" )
	TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL04_Route" )
	TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL05_Route" )
	TppEnemy.DisableRoute( this.cpID , "Break_CenterTower_Route" )
	TppEnemy.DisableRoute( this.cpID , "S_Talk_ChicoTape" )
	TppEnemy.DisableRoute( this.cpID , "S_Talk_EscapeHostage" )
	TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage01" )
	TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage02" )
	TppEnemy.DisableRoute( this.cpID , "GoToWestCamp_TalkWeapon" )
	TppEnemy.DisableRoute( this.cpID , "S_Mov_CenterHouse_a2" )
	TppEnemy.DisableRoute( this.cpID , "S_Mov_CenterHouse_b2" )
	TppEnemy.DisableRoute( this.cpID , "ComEne21_TalkRoute" )
	TppEnemy.DisableRoute( this.cpID , "S_Seeing_Sea" )
	TppEnemy.DisableRoute( this.cpID , "Seq10_01_VehicleFailed_Route" )
	TppEnemy.DisableRoute( this.cpID , "Seq10_02_VehicleFailed_Route" )
	
	TppEnemy.DisableRoute( this.cpID , "ComEne25_SwitchOFF" )
	TppEnemy.DisableRoute( this.cpID , "ComEne26_SwitchOFF" )
	TppEnemy.DisableRoute( this.cpID , "ComEne27_SwitchOFF" )
	TppEnemy.DisableRoute( this.cpID , "ComEne28_SwitchOFF" )
	TppEnemy.DisableRoute( this.cpID , "ComEne29_SwitchOFF" )
	TppEnemy.DisableRoute( this.cpID , "ComEne31_SwitchOFF" )
	
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Pre_ExWeaponTalk_a" , -1 , "ComEne01" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_SL_WestCamp" , -1 , "ComEne02" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Pre_ExWeaponTalk_b" , -1 , "ComEne03" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_SL_WareHouse01a" , -1 , "ComEne04" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Pre_RainTalk_a" , -1 , "ComEne05" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Pre_RainTalk_b" , -1 , "ComEne06" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_WareHouseBehind" , -1 , "ComEne07" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Pre_GunTitorial_Waiting" , -1 , "ComEne08" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Pat_AsylumInside_Ver01" , -1 , "ComEne09" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_AsylumOutSideGate_a" , -1 , "ComEne10" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_EastCamp_NorthLeftGate" , -1 , "ComEne11" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_WareHouse_NorthGate" , -1 , "ComEne12" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Pre_EscapeHostageTalk_a" , -1 , "ComEne13" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Pre_EscapeHostageTalk_b" , -1 , "ComEne14" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_HeliPortFrontGate_a" , -1 , "ComEne15" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_HeliPortFrontGate_b" , -1 , "ComEne16" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_Bridge" , -1 , "ComEne17" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_HeliPortBehind_a" , -1 , "ComEne18" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_HeliPortBehind_b" , -1 , "ComEne19" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_HeliPortYard" , -1 , "ComEne20" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_HeliPortCenter_a" , -1 , "ComEne21" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_HeliPortCenter_b" , -1 , "ComEne22" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_BigGate_a" , -1 , "ComEne23" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_BigGate_b" , -1 , "ComEne24" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_Center_d" , -1 , "ComEne25" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_Center_a" , -1 , "ComEne26" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_BoilarFront" , -1 , "ComEne27" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_Center_b" , -1 , "ComEne28" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_Center_c" , -1 , "ComEne29" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Search_Xof" , -1 , "ComEne30" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Pre_ChikcoTapeTalk_c" , -1 , "ComEne31" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Pre_ChikcoTapeTalk_d" , -1 , "ComEne32" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_SL_EastCamp_South" , -1 , "ComEne33" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_SL_HeliPortTower" , -1 , "ComEne34" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_WestCamp_WestGate2" , -1 , "Seq10_01" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Sen_EastCampCenter_East" , -1 , "Seq10_02" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Pre_TruckWaiting" , -1 , "Seq10_03" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_SL_StartCliff" , -1 , "Seq10_05" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Pre_ChikcoTapeTalk_a" , -1 , "Seq10_06" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq10_SneakRouteSet" , "S_Pre_ChikcoTapeTalk_b" , -1 , "Seq10_07" , "ROUTE_PRIORITY_TYPE_FORCED" )
end

local Setting_RealizeEnable = function()

	local sequence = TppSequence.GetCurrentSequence()

	if ( sequence == "Seq_RescueHostages" ) then
		
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_01" , true )
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_02" , true )
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_03" , true )
	elseif ( sequence == "Seq_NextRescuePaz" ) then
		
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq20_02" , true )
		
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_01" , false )
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_02" , false )
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_03" , false )
	elseif ( sequence == "Seq_NextRescueChico" ) or ( sequence == "Seq_PazChicoToRV" ) then
		
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq40_03" , true )
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq40_04" , true )
		
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_01" , false )
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_02" , false )
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_03" , false )
	elseif ( sequence == "Seq_ChicoPazToRV" ) then
		
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq30_05" , true )
		
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq20_02" , false )
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_01" , false )
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_02" , false )
		TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_03" , false )
	else	
		if( TppMission.GetFlag( "isFirstEncount_Chico" ) == true ) then
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq30_05" , true )
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq20_02" , false )
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_01" , false )
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_02" , false )
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_03" , false )
		else
			
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq40_03" , true )
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq40_04" , true )
			
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_01" , false )
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_02" , false )
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_03" , false )
		end
	end
end



local SetOptionalRadio = function()
	local sequence = TppSequence.GetCurrentSequence()
	local radioDaemon = RadioDaemon:GetInstance()




	
	if ( sequence == "Seq_RescueHostages" ) then
	














			TppRadio.RegisterOptionalRadio( "Optional_GameStartToRescue" )		


	elseif ( sequence == "Seq_NextRescuePaz" ) then
	
		if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1260") == true ) then
			TppRadio.RegisterOptionalRadio( "Optional_ChicoOnHeli" )			

		elseif( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) then



			TppRadio.RegisterOptionalRadio( "Optional_RVChicoToRescuePaz" )		

		elseif( TppMission.GetFlag( "isQuestionChico" ) == true ) then



			TppRadio.RegisterOptionalRadio( "Optional_RideHeliPaz" )			






		else



			TppRadio.RegisterOptionalRadio( "Optional_RescueChicoToRVChico" )	
		end

	elseif ( sequence == "Seq_NextRescueChico" ) then
	





		if( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then



			TppRadio.RegisterOptionalRadio( "Optional_RescuePazToRescueChico" )	
		elseif( TppMission.GetFlag( "isQuestionPaz" ) == true ) then



			TppRadio.RegisterOptionalRadio( "Optional_DiscoveryPaz" )			
		else



			TppRadio.RegisterOptionalRadio( "Optional_RescuePazToRVPaz" )		
		end

	elseif ( sequence == "Seq_ChicoPazToRV" or sequence == "Seq_PazChicoToRV" ) then
		if( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then



			TppRadio.RegisterOptionalRadio( "Optional_RideHeliPaz" )			
		elseif( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) then



			TppRadio.RegisterOptionalRadio( "Optional_RideHeliChico" )			
		else



			TppRadio.RegisterOptionalRadio( "Optional_RescueBothToRideHeli" )	
		end

	elseif ( sequence == "Seq_PlayerOnHeli" ) then



		TppRadio.RegisterOptionalRadio( "Optional_RescueComplete" )			
	else



	end
end




local SetIntelRadio = function()
	local sequence = TppSequence.GetCurrentSequence()




	
	this.Check_SetIntelRadio( "ComEne01", "enemy" )
	this.Check_SetIntelRadio( "ComEne02", "enemy" )
	this.Check_SetIntelRadio( "ComEne03", "enemy" )
	this.Check_SetIntelRadio( "ComEne04", "enemy" )
	this.Check_SetIntelRadio( "ComEne05", "enemy" )
	this.Check_SetIntelRadio( "ComEne06", "enemy" )
	this.Check_SetIntelRadio( "ComEne07", "enemy" )
	this.Check_SetIntelRadio( "ComEne08", "enemy" )
	this.Check_SetIntelRadio( "ComEne09", "enemy" )
	this.Check_SetIntelRadio( "ComEne10", "enemy" )
	this.Check_SetIntelRadio( "ComEne11", "enemy" )
	this.Check_SetIntelRadio( "ComEne12", "enemy" )
	this.Check_SetIntelRadio( "ComEne13", "enemy" )
	this.Check_SetIntelRadio( "ComEne14", "enemy" )
	this.Check_SetIntelRadio( "ComEne15", "enemy" )
	this.Check_SetIntelRadio( "ComEne16", "enemy" )
	this.Check_SetIntelRadio( "ComEne17", "enemy" )
	this.Check_SetIntelRadio( "ComEne18", "enemy" )
	this.Check_SetIntelRadio( "ComEne19", "enemy" )
	this.Check_SetIntelRadio( "ComEne20", "enemy" )
	this.Check_SetIntelRadio( "ComEne21", "enemy" )
	this.Check_SetIntelRadio( "ComEne22", "enemy" )
	this.Check_SetIntelRadio( "ComEne23", "enemy" )
	this.Check_SetIntelRadio( "ComEne24", "enemy" )
	this.Check_SetIntelRadio( "ComEne25", "enemy" )
	this.Check_SetIntelRadio( "ComEne26", "enemy" )
	this.Check_SetIntelRadio( "ComEne27", "enemy" )
	this.Check_SetIntelRadio( "ComEne28", "enemy" )
	this.Check_SetIntelRadio( "ComEne29", "enemy" )
	this.Check_SetIntelRadio( "ComEne30", "enemy" )
	this.Check_SetIntelRadio( "ComEne31", "enemy" )
	this.Check_SetIntelRadio( "ComEne32", "enemy" )
	this.Check_SetIntelRadio( "ComEne33", "enemy" )
	this.Check_SetIntelRadio( "ComEne34", "enemy" )
	this.Check_SetIntelRadio( "Seq10_01", "enemy" )
	this.Check_SetIntelRadio( "Seq10_02", "enemy" )
	this.Check_SetIntelRadio( "Seq10_03", "enemy" )
	this.Check_SetIntelRadio( "Seq10_05", "enemy" )
	this.Check_SetIntelRadio( "Seq10_06", "enemy" )
	this.Check_SetIntelRadio( "Seq10_07", "enemy" )

	this.Check_SetIntelRadio( "SpHostage", "hostage" )
	this.Check_SetIntelRadio( "Chico", "hostage" )
	this.Check_SetIntelRadio( "Paz", "hostage" )

	this.Check_SetIntelRadio( "WoodTurret01", "gimmick" )
	this.Check_SetIntelRadio( "WoodTurret02", "gimmick" )
	this.Check_SetIntelRadio( "WoodTurret03", "gimmick" )
	this.Check_SetIntelRadio( "WoodTurret04", "gimmick" )
	this.Check_SetIntelRadio( "WoodTurret05", "gimmick" )
	this.Check_SetIntelRadio( "gntn_area01_antiAirGun_000", "gimmick" )
	this.Check_SetIntelRadio( "gntn_area01_antiAirGun_001", "gimmick" )
	this.Check_SetIntelRadio( "gntn_area01_antiAirGun_002", "gimmick" )
	this.Check_SetIntelRadio( "gntn_area01_antiAirGun_003", "gimmick" )

	this.Check_SetIntelRadio( "Tactical_Vehicle_WEST_002", "gimmick" )
	this.Check_SetIntelRadio( "Tactical_Vehicle_WEST_003", "gimmick" )
	this.Check_SetIntelRadio( "Tactical_Vehicle_WEST_004", "gimmick" )
	this.Check_SetIntelRadio( "Tactical_Vehicle_WEST_005", "gimmick" )
	this.Check_SetIntelRadio( "Cargo_Truck_WEST_002", "gimmick" )
	this.Check_SetIntelRadio( "Cargo_Truck_WEST_003", "gimmick" )
	this.Check_SetIntelRadio( "Cargo_Truck_WEST_004", "gimmick" )
	this.Check_SetIntelRadio( "Armored_Vehicle_WEST_001", "gimmick" )


	this.Check_SetIntelRadio( "SL_WoodTurret01", "gimmick" )
	this.Check_SetIntelRadio( "SL_WoodTurret02", "gimmick" )
	this.Check_SetIntelRadio( "SL_WoodTurret03", "gimmick" )
	this.Check_SetIntelRadio( "SL_WoodTurret04", "gimmick" )
	this.Check_SetIntelRadio( "SL_WoodTurret05", "gimmick" )
	this.Check_SetIntelRadio( "gntn_area01_searchLight_000", "gimmick" )
	this.Check_SetIntelRadio( "gntn_area01_searchLight_001", "gimmick" )
	this.Check_SetIntelRadio( "gntn_area01_searchLight_002", "gimmick" )
	this.Check_SetIntelRadio( "gntn_area01_searchLight_003", "gimmick" )
	this.Check_SetIntelRadio( "gntn_area01_searchLight_004", "gimmick" )
	this.Check_SetIntelRadio( "gntn_area01_searchLight_005", "gimmick" )
	this.Check_SetIntelRadio( "gntn_area01_searchLight_006", "gimmick" )
	this.Check_SetIntelRadio( "e20010_drum0025", "gimmick" )
	this.Check_SetIntelRadio( "e20010_drum0027", "gimmick" )
	this.Check_SetIntelRadio( "e20010_drum0040", "gimmick" )
	this.Check_SetIntelRadio( "e20010_drum0042", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0002", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0005", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0011", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0012", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0015", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0019", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0020", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0021", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0022", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0023", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0024", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0025", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0027", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0028", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0029", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0030", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0031", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0035", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0037", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0038", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0039", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0040", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0041", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0042", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0043", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0044", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0045", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0046", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0047", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0048", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0065", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0066", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0068", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0069", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0070", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0071", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0072", "gimmick" )
	this.Check_SetIntelRadio( "gntnCom_drum0101", "gimmick" )
	this.Check_SetIntelRadio( "e20010_SecurityCamera_01", "gimmick" )
	this.Check_SetIntelRadio( "e20010_SecurityCamera_02", "gimmick" )
	this.Check_SetIntelRadio( "e20010_SecurityCamera_03", "gimmick" )
	this.Check_SetIntelRadio( "e20010_SecurityCamera_04", "gimmick" )

	TppRadio.EnableIntelRadio( "intel_e0010_esrg0020" )
	TppRadio.EnableIntelRadio( "intel_e0010_esrg0030" )
	TppRadio.EnableIntelRadio( "intel_e0010_esrg0040" )
	TppRadio.EnableIntelRadio( "intel_e0010_esrg0090" )
	TppRadio.EnableIntelRadio( "intel_e0010_esrg0110" )
	TppRadio.EnableIntelRadio( "intel_e0010_esrg0120" )
	TppRadio.EnableIntelRadio( "intel_e0010_esrg0190" )
	TppRadio.EnableIntelRadio( "intel_e0010_esrg0380" )
	TppRadio.EnableIntelRadio( "intel_e0010_esrg0440" )
	TppRadio.EnableIntelRadio( "intel_e0010_esrg0440_1" )
	TppRadio.EnableIntelRadio( "intel_e0010_esrg0450" )
	TppRadio.EnableIntelRadio( "intel_e0010_esrg0450_1" )
	TppRadio.EnableIntelRadio( "intel_e0010_esrg0450_2" )
	TppRadio.EnableIntelRadio( "intel_e0010_esrg0480" )
	TppRadio.EnableIntelRadio( "intel_e0010_esrg0490" )

	
	TppRadio.RegisterIntelRadio( "Chico", "e0010_esrg0080", true )
	TppRadio.RegisterIntelRadio( "Paz", "e0010_esrg0100", true )
	TppRadio.RegisterIntelRadio( "intel_e0010_esrg0040", "e0010_esrg0040", true )
	TppRadio.RegisterIntelRadio( "intel_e0010_esrg0090", "e0010_esrg0090", true )
	TppRadio.RegisterIntelRadio( "intel_e0010_esrg0120", "e0010_esrg0120", true )
	TppRadio.RegisterIntelRadio( "SL_WoodTurret05", "e0010_esrg0460", true )
	TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_002", "e0010_esrg0210", true )
	TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_003", "e0010_esrg0210", true )
	TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_004", "e0010_esrg0210", true )
	TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_005", "e0010_esrg0210", true )

	
	if ( sequence == "Seq_RescueHostages" ) then
		
		TppRadio.RegisterIntelRadio( "Chico", "e0010_esrg0080", true )
		TppRadio.RegisterIntelRadio( "SL_WoodTurret05", "e0010_esrg0460", true )

	elseif ( sequence == "Seq_NextRescuePaz" ) then
		
		TppRadio.RegisterIntelRadio( "intel_e0010_esrg0040", "e0010_esrg0060", true )
		TppRadio.RegisterIntelRadio( "Chico", "e0010_esrg0083", true )
		TppRadio.RegisterIntelRadio( "SL_WoodTurret05", "e0010_esrg0010", true )	
		
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0090" )	
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0120" )	
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0380" )	

	elseif ( sequence == "Seq_NextRescueChico" ) then
		
		TppRadio.RegisterIntelRadio( "intel_e0010_esrg0040", "e0010_esrg0050", true )
		TppRadio.RegisterIntelRadio( "Chico", "e0010_esrg0070", true )
		TppRadio.RegisterIntelRadio( "Paz", "e0010_esrg0104", true )
		
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0090" )	
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0120" )	

		TppRadio.DisableIntelRadio( "intel_e0010_esrg0110" )	
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0190" )	

	elseif ( sequence == "Seq_ChicoPazToRV" ) then
		
		TppRadio.RegisterIntelRadio( "intel_e0010_esrg0040", "e0010_esrg0060", true )
		TppRadio.RegisterIntelRadio( "Chico", "e0010_esrg0083", true )
		TppRadio.RegisterIntelRadio( "Paz", "e0010_esrg0103" )
		TppRadio.RegisterIntelRadio( "SL_WoodTurret05", "e0010_esrg0010", true )	

		TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_002", "e0010_esrg0215", true )
		TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_003", "e0010_esrg0215", true )
		TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_004", "e0010_esrg0215", true )
		TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_005", "e0010_esrg0215", true )
		
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0090" )	
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0120" )	
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0380" )	
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0110" )	
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0190" )	

	elseif ( sequence == "Seq_PazChicoToRV" ) then
		
		TppRadio.RegisterIntelRadio( "intel_e0010_esrg0040", "e0010_esrg0060", true )
		TppRadio.RegisterIntelRadio( "Chico", "e0010_esrg0083", true )
		TppRadio.RegisterIntelRadio( "Paz", "e0010_esrg0103" )
		TppRadio.RegisterIntelRadio( "SL_WoodTurret05", "e0010_esrg0010", true )	

		TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_002", "e0010_esrg0215", true )
		TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_003", "e0010_esrg0215", true )
		TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_004", "e0010_esrg0215", true )
		TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_005", "e0010_esrg0215", true )
		
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0090" )	
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0120" )	
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0380" )	
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0110" )	
		TppRadio.DisableIntelRadio( "intel_e0010_esrg0190" )	

	end

end


this.Check_SetIntelRadio = function( characterID, type )

	
	if( type == "enemy" ) then
		
		TppRadio.EnableIntelRadio( characterID )
	
	elseif( type == "hostage" ) then
		local status = TppHostageUtility.GetStatus( characterID )

		
		if( characterID == "Chico" ) then
			if(TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) then
				TppRadio.DisableIntelRadio( characterID )
			else
				TppRadio.EnableIntelRadio( characterID )
			end
		
		elseif( characterID == "Paz" ) then
			if(TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then
				TppRadio.DisableIntelRadio( characterID )
			else
				TppRadio.EnableIntelRadio( characterID )
			end
		else
			if (status =="Dead" ) then
			else
				TppRadio.EnableIntelRadio( characterID )
			end
		end

	
	elseif( type == "gimmick" ) then
		TppRadio.EnableIntelRadio( characterID )
	end
end




local MissionStartTelopTimerStart = function()
	local timer = 0		
	GkEventTimerManager.Start( "Timer_MissionStartTelop", timer )
end

local MissionStartTelop_ON = function()
		
		local funcs = {


		}

		TppUI.ShowTransitionInGame( "opening", funcs )
end




local Seq_RescueHostages_RouteSet = function()
	local cpRouteSets = {
		{
			cpID = "gntn_cp",
			sets = {
				sneak_night = "e20010_Seq10_SneakRouteSet",
				caution_night = "e20010_Seq10_CautionRouteSet",
			},
		},
	}
	TppEnemy.SetRouteSets( cpRouteSets )
end

local Seq_RescueHostages_RouteSet_Continue = function()
	local cpRouteSets = {
		{
			cpID = "gntn_cp",
			sets = {
				sneak_night = "e20010_Seq10_SneakRouteSet",
				caution_night = "e20010_Seq10_CautionRouteSet",
			},
		},
	}
	TppEnemy.SetRouteSets( cpRouteSets , { warpEnemy = true , forceUpdate = true } )
end

local Seq_NextRescuePaz_RouteSet = function()
	local cpRouteSets = {
		{
			cpID = "gntn_cp",
			sets = {
				sneak_night = "e20010_Seq20_SneakRouteSet",
				caution_night = "e20010_Seq20_CautionRouteSet",
			},
		},
	}
	TppEnemy.SetRouteSets( cpRouteSets , { warpEnemy = true , forceUpdate = true , forceReload = true , startAtZero = true } )

end

local Seq_ChicoPazToRV_RouteSet = function()
	local cpRouteSets = {
		{
			cpID = "gntn_cp",
			sets = {
				sneak_night = "e20010_Seq30_SneakRouteSet",
				caution_night = "e20010_Seq30_CautionRouteSet",
			},
		},
	}
	TppEnemy.SetRouteSets( cpRouteSets , { warpEnemy = true } )
end

local Seq_NextRescueChico_RouteSet = function()
	local cpRouteSets = {
		{
			cpID = "gntn_cp",
			sets = {
				sneak_night = "e20010_Seq40_SneakRouteSet",
				caution_night = "e20010_Seq40_CautionRouteSet",
			},
		},
	}
	TppEnemy.SetRouteSets( cpRouteSets , { warpEnemy = true , forceUpdate = true , forceReload = true , startAtZero = true } )

end

local Seq_PazChicoToRV_RouteSet = function()
	local cpRouteSets = {
		{
			cpID = "gntn_cp",
			sets = {
				sneak_night = "e20010_Seq40_SneakRouteSet",
				caution_night = "e20010_Seq50_CautionRouteSet",
			},
		},
	}
	TppEnemy.SetRouteSets( cpRouteSets , { warpEnemy = true , forceUpdate = true , forceReload = true , startAtZero = true } )

end




local Seq10Enemy_Enable = function()
	TppEnemyUtility.SetEnableCharacterId( "Seq10_01" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq10_02" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq10_03" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq10_05" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq10_06" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq10_07" , true )
end

local Seq10Enemy_Disable = function()
	TppEnemyUtility.SetEnableCharacterId( "Seq10_01" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq10_02" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq10_03" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq10_05" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq10_06" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq10_07" , false )
end

local Seq10Enemy_Disable_Ver2 = function()
	TppEnemyUtility.SetEnableCharacterId( "Seq10_01" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq10_02" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq10_03" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq10_05" , false )
end

local Seq20Enemy_Enable = function()
	TppEnemyUtility.SetEnableCharacterId( "Seq20_01" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq20_02" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq20_03" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq20_04" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq20_05" , true )
end

local Seq20Enemy_Disable = function()
	TppEnemyUtility.SetEnableCharacterId( "Seq20_01" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq20_02" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq20_03" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq20_04" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq20_05" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq20_06" , false )
end

local Seq30Enemy_Enable = function()
	TppEnemyUtility.SetEnableCharacterId( "Seq30_01" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_02" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_03" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_04" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_05" , true )
	
	TppEnemyUtility.SetEnableCharacterId( "Seq30_07" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_08" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_09" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_10" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_11" , true )
end

local Seq30Enemy_Disable = function()
	TppEnemyUtility.SetEnableCharacterId( "Seq30_01" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_02" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_03" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_04" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_05" , false )
	
	TppEnemyUtility.SetEnableCharacterId( "Seq30_07" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_08" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_09" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_10" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq30_11" , false )
end

local Seq40Enemy_Enable = function()
	TppEnemyUtility.SetEnableCharacterId( "Seq40_01" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq40_02" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq40_03" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq40_04" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq40_05" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq40_06" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq40_07" , true )
	TppEnemyUtility.SetEnableCharacterId( "Seq40_08" , true )
end

local Seq40Enemy_Disable = function()
	TppEnemyUtility.SetEnableCharacterId( "Seq40_01" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq40_02" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq40_03" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq40_04" , false )
	
	TppEnemyUtility.SetEnableCharacterId( "Seq40_07" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq40_08" , false )
end



local EnablePhoto = function()

	
	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager == NULL then
		return
	end
	local luaData = commonDataManager:GetUiLuaExportCommonData()
	if luaData == NULL then
		return
	end
	luaData:EnableMissionPhotoId( 10 )
	luaData:EnableMissionPhotoId( 30 )
	luaData:SetAdditonalMissionPhotoId(10,true,false)
	luaData:SetAdditonalMissionPhotoId(30,true,false)

end

local SetComplatePhoto = function( num )






	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager == NULL then
			return
	end

	local luaData = commonDataManager:GetUiLuaExportCommonData()
	if luaData == NULL then
			return
	end

	if ( num ~= nil ) then
		



		luaData:SetCompleteMissionPhotoId(num, true)
	else



		
		if ( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then
			



			luaData:SetCompleteMissionPhotoId(30, true)
		end

		if ( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) then
			



			luaData:SetCompleteMissionPhotoId(10, true)
		end

	end
end

local WoodTurret_RainFilter_OFF = function()
	local rainManager = TppRainFilterInterruptManager:GetInstance()
	
	rainManager:ResetStartEndFadeInDistanceDemo( 1 )
	
	TppEffectUtility.SetCameraRainDropRate( 1.0 )
end



local commonUiMissionSubGoalNo = function( id )

	local sequence = TppSequence.GetCurrentSequence()

	if ( sequence ~= "Seq_RescueHostages" ) then
		AnounceLog_MissionUpdate()
	end

	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager == NULL then
			return
	end

	local luaData = commonDataManager:GetUiLuaExportCommonData()
	if luaData == NULL then
			return
	end
	
	luaData:SetCurrentMissionSubGoalNo( id)
end




this.Seq_MissionSetup = {

	OnEnter = function()
		MissionSetup()
		GZCommon.MissionSetup()
		TppSequence.ChangeSequence( "Seq_OpeningDemoLoad" )
	end,
}

this.Seq_OpeningDemoLoad = {

	OnEnter = function()

		TppMission.LoadEventBlock("/Assets/tpp/pack/mission/extra/e20010/e20010_e01.fpk")
		
		TppCollectibleDataManager.LoadMissionWeapon("WP_ms02")
		TppCollectibleDataManager.LoadMissionWeapon("WP_sr01_v00")
		TppCollectibleDataManager.LoadMissionWeapon("WP_sg01_v00")
		TppCollectibleDataManager.LoadMissionWeapon("WP_ar00_v01")
	end,

	OnUpdate = function()
		if( IsEventBlockActive() ) then
			TppSequence.ChangeSequence( "Seq_OpeningDemoPlay" )
		end
	end,
}

this.Seq_MissionLoad = {

	Messages = {
		Timer = {
				{ data = "Timer_MissionStartTelop", message = "OnEnd", commonFunc = MissionStartTelop_ON },
			},
	},

	OnEnter = function()
		
		TppMissionManager.SaveGame("10")
		
		commonUiMissionSubGoalNo(1)
		
		EnablePhoto()
		
		TppSupportHelicopterService.SetDefaultRendezvousPointMarker("no_lz")
		
		WoodTurret_RainFilter_OFF()
		
		Seq10Enemy_Enable()
		Seq20Enemy_Disable()
		Seq30Enemy_Disable()
		Seq40Enemy_Disable()
		
		Seq_RescueHostages_RouteSet()
		
		Setting_Seq_RescueHostages_RouteSet()
		
		TppMission.LoadEventBlock("/Assets/tpp/pack/mission/extra/e20010/e20010_e02.fpk")
		MainMissionLoad()
		
		MissionStartTelopTimerStart()
		
		MapIconText()
		RegisterRadioCondition()
		
	
	
	end,

	OnUpdate = function()
		if( IsEventBlockActive() ) then
			TppSequence.ChangeSequence( "Seq_RescueHostages" )
		end
	end,
}



local GuardTarget_Setting = function()

	local sequence = TppSequence.GetCurrentSequence()

	if( sequence == "Seq_RescueHostages" ) then
		
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_OFF_SetFrontLine000", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_OFF_SetFrontLine001", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_OFF_SetFrontLine002", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine000", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine001", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine002", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine003", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine004", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine005", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine006", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine007", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine008", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine009", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine010", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetMainGuardIndex000", true , false )
		
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0126",false)
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0000",true)
		
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_Chico", true )		
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_Paz", true )			
		
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_HeliPort", false )	
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_Paz2", false )		
	elseif( sequence == "Seq_NextRescuePaz" ) then
		
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_OFF_SetFrontLine000", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_OFF_SetFrontLine001", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_OFF_SetFrontLine002", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine000", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine001", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine002", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine003", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine004", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine005", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine006", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine007", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine008", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine009", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine010", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetMainGuardIndex000", true , false )
		
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0126",true)
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0000",false)
		
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_Paz2", true )			
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_Paz", true )			
		
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_Chico", false )		
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_HeliPort", false )	
	elseif( sequence == "Seq_NextRescueChico" ) then
		
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_OFF_SetFrontLine000", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_OFF_SetFrontLine001", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_OFF_SetFrontLine002", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine000", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine001", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine002", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine003", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine004", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine005", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine006", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine007", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine008", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine009", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine010", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetMainGuardIndex000", false , false )
		
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0126",false)
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0000",true)
		
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_Chico", true )		
		
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_HeliPort", false )	
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_Paz2", false )		
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_Paz", false )			
	else
		
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_OFF_SetFrontLine000", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_OFF_SetFrontLine001", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_OFF_SetFrontLine002", true , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine000", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine001", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine002", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine003", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine004", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine005", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine006", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine007", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine008", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine009", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetFrontLine010", false , false )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "paz_ON_SetMainGuardIndex000", false , false )
		
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0126",true)
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0000",false)
		
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_Paz2", true )		
		
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_HeliPort", false )	
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_Chico", false )		
		TppCommandPostObject.GsSetGuardTargetValidity( this.cpID, "TppGuardTarget_Paz", false )		
	end
end



this.OnSkipEnterCommon = function()

	local sequence = TppSequence.GetCurrentSequence()

	
	if( TppSequence.IsGreaterThan( sequence, "Seq_MissionPrepare" ) ) then

	end

	








	if( TppSequence.IsGreaterThan( sequence, "Seq_MissionPrepare" ) ) then

		this.e20010_PlayerSetWeapons()
		
		MissionSetup()
		
		TppMission.LoadEventBlock("/Assets/tpp/pack/mission/extra/e20010/e20010_e02.fpk")
		
		MapIconText()
	elseif( TppSequence.IsGreaterThan( sequence, "Seq_Mission_Failed" ) ) then
		TppMission.ChangeState( "failed" )
	end
end

this.OnSkipUpdateCommon = function()


	return IsEventBlockActive()
end

this.OnSkipLeaveCommon = function()
	local sequence = TppSequence.GetCurrentSequence()

	
	EnablePhoto()

	
	if( TppSequence.IsGreaterThan( sequence, "Seq_MissionLoad" ) ) then

		GZCommon.MissionSetup()
		RegisterRadioCondition()
	end

end

this.OnAfterRestore = function()
	
	
	local sequence = TppSequence.GetCurrentSequence()
	
	WoodTurret_RainFilter_OFF()
	TppMission.SetFlag( "isTruckSneakRideOn", false )
	
	e20010_require_01.HostageWarp_FrontGateArmorVehicle()
	e20010_require_01.HostageWarp_EastCampVehicle01()
	e20010_require_01.HostageWarp_EastCampTruck()
	e20010_require_01.HostageWarp_CarryWeaponTruck()
	e20010_require_01.HostageWarp_OpenGateTruck01()
	e20010_require_01.HostageWarp_OpenGateTruck02()
	e20010_require_01.HostageWarp_OpenGateTruck03()
	e20010_require_01.HostageWarp_CenterOutVehicle01()
	e20010_require_01.HostageWarp_CenterOutVehicle02()
	e20010_require_01.HostageWarp_WareHouseArmorVehicle()
	e20010_require_01.HostageWarp_AsylumVehicle()
	e20010_require_01.HostageWarp_HeliPortFrontGateArmorVehicle()
	
	if ( sequence == "Seq_MissionLoad" ) or ( sequence == "Seq_RescueHostages" ) then					
		Seq_RescueHostages_RouteSet_Continue()
		
		local radioDaemon = RadioDaemon:GetInstance()
		radioDaemon:DisableFlagIsMarkAsRead( "e0010_rtrg0010" )

		if( TppMission.GetFlag( "isSpHostage_Dead" ) == true ) then
			TppRadio.DisableIntelRadio( "SpHostage" )
		else
		end
	elseif ( sequence == "Seq_NextRescuePaz" ) then					
		Seq_NextRescuePaz_RouteSet()
		e20010_require_01.SpHostageStatus()	
		if( TppMission.GetFlag( "isSeq20_02_DriveEnd" ) == 2 ) then
			TppEnemy.Warp( "Cargo_Truck_WEST_004" , "warp_OpenGateTruck" )
		else
		end
	elseif ( sequence == "Seq_NextRescueChico" ) then				
		Seq_NextRescueChico_RouteSet()
		if( TppMission.GetFlag( "isArmorVehicle_Start" ) == 1 ) then
			TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Armored_Vehicle_WEST_002" , "ArmorVehicle_onRaid_Seq40_08_02" , -1 )
		elseif( TppMission.GetFlag( "isArmorVehicle_Start" ) == 2 ) then
			TppEnemy.Warp( "Armored_Vehicle_WEST_002" , "warp_ArmorVehicle" )
			TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Armored_Vehicle_WEST_002" , "ArmorVehicle_WareHouseWait" , -1 )
		end
		if( TppMission.GetFlag( "isSeq40_0304_DriveEnd" ) == 2 ) then
			TppEnemy.Warp( "Tactical_Vehicle_WEST_005" , "warp_ToAsylumVehicle" )
		else
			TppEnemy.EnableRoute( this.cpID , "Seq40_03_RideOnVehicle" )
			TppEnemy.EnableRoute( this.cpID , "Seq40_04_RideOnVehicle" )
			TppEnemy.DisableRoute( this.cpID , "Seq40_03_PreRideOnVehicle" )
			TppEnemy.DisableRoute( this.cpID , "Seq40_04_PreRideOnVehicle" )
			TppEnemy.ChangeRoute( this.cpID , "Seq40_03","e20010_Seq40_SneakRouteSet","Seq40_03_RideOnVehicle", 0 )
			TppEnemy.ChangeRoute( this.cpID , "Seq40_04","e20010_Seq40_SneakRouteSet","Seq40_04_RideOnVehicle", 0 )
		end
	elseif ( sequence == "Seq_ChicoPazToRV" ) then					
		Seq_ChicoPazToRV_RouteSet()
		if( TppMission.GetFlag( "isVehicle_Seq30_0506Start" ) == true ) then
			TppEnemy.EnableRoute( this.cpID , "Seq30_05_RideOnVehicle" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_AsylumOutSideGate_c" )
			TppEnemy.ChangeRoute( this.cpID , "Seq30_05","e20010_Seq30_SneakRouteSet","Seq30_05_RideOnVehicle", 0 )
		else
		end
		if( TppMission.GetFlag( "isArmorVehicle_Start" ) == 1 ) then
			TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Armored_Vehicle_WEST_003" , "ArmorVehicle_onRaid_Seq30_11_2" , -1 )
		elseif( TppMission.GetFlag( "isArmorVehicle_Start" ) == 2 ) then
			TppEnemy.Warp( "Armored_Vehicle_WEST_002" , "warp_ArmorVehicle" )
			TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Armored_Vehicle_WEST_003" , "ArmorVehicle_WareHouseWait" , -1 )
		end
		if( TppMission.GetFlag( "isSeq20_02_DriveEnd" ) == 2 ) then
			TppEnemy.Warp( "Cargo_Truck_WEST_004" , "warp_OpenGateTruck" )
		else
		end
	elseif ( sequence == "Seq_PazChicoToRV" ) then					
		Seq_PazChicoToRV_RouteSet()
		if( TppMission.GetFlag( "isArmorVehicle_Start" ) == 1 ) then
			TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Armored_Vehicle_WEST_002" , "ArmorVehicle_onRaid_Seq40_08_02" , -1 )
		elseif( TppMission.GetFlag( "isArmorVehicle_Start" ) == 2 ) then
			TppEnemy.Warp( "Armored_Vehicle_WEST_002" , "warp_ArmorVehicle" )
			TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Armored_Vehicle_WEST_002" , "ArmorVehicle_WareHouseWait" , -1 )
		end
		if( TppMission.GetFlag( "isSeq40_0304_DriveEnd" ) == 2 ) then
			TppEnemy.Warp( "Tactical_Vehicle_WEST_005" , "warp_ToAsylumVehicle" )
		else
			TppEnemy.EnableRoute( this.cpID , "Seq40_03_RideOnVehicle" )
			TppEnemy.EnableRoute( this.cpID , "Seq40_04_RideOnVehicle" )
			TppEnemy.DisableRoute( this.cpID , "Seq40_03_PreRideOnVehicle" )
			TppEnemy.DisableRoute( this.cpID , "Seq40_04_PreRideOnVehicle" )
			TppEnemy.ChangeRoute( this.cpID , "Seq40_03","e20010_Seq40_SneakRouteSet","Seq40_03_RideOnVehicle", 0 )
			TppEnemy.ChangeRoute( this.cpID , "Seq40_04","e20010_Seq40_SneakRouteSet","Seq40_04_RideOnVehicle", 0 )
		end
	else							
		if( TppMission.GetFlag( "isFirstEncount_Chico" ) == true ) then
			Seq_ChicoPazToRV_RouteSet()
			
			if( TppMission.GetFlag( "isVehicle_Seq30_0506Start" ) == true ) then
				TppEnemy.EnableRoute( this.cpID , "Seq30_05_RideOnVehicle" )
				TppEnemy.DisableRoute( this.cpID , "S_Sen_AsylumOutSideGate_c" )
				TppEnemy.ChangeRoute( this.cpID , "Seq30_05","e20010_Seq30_SneakRouteSet","Seq30_05_RideOnVehicle", 0 )
			else
			end
			if( TppMission.GetFlag( "isArmorVehicle_Start" ) == 1 ) then
				TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Armored_Vehicle_WEST_003" , "ArmorVehicle_onRaid_Seq30_11_2" , -1 )
			elseif( TppMission.GetFlag( "isArmorVehicle_Start" ) == 2 ) then
				TppEnemy.Warp( "Armored_Vehicle_WEST_003" , "warp_ArmorVehicle" )
				TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Armored_Vehicle_WEST_003" , "ArmorVehicle_WareHouseWait" , -1 )
			end
			if( TppMission.GetFlag( "isSeq20_02_DriveEnd" ) == 2 ) then
				TppEnemy.Warp( "Cargo_Truck_WEST_004" , "warp_OpenGateTruck" )
			else
			end
		else
			Seq_PazChicoToRV_RouteSet()
			if( TppMission.GetFlag( "isArmorVehicle_Start" ) == 1 ) then
				TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Armored_Vehicle_WEST_002" , "ArmorVehicle_onRaid_Seq40_08_02" , -1 )
			elseif( TppMission.GetFlag( "isArmorVehicle_Start" ) == 2 ) then
				TppEnemy.Warp( "Armored_Vehicle_WEST_002" , "warp_ArmorVehicle" )
				TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Armored_Vehicle_WEST_002" , "ArmorVehicle_WareHouseWait" , -1 )
			end
			if( TppMission.GetFlag( "isSeq40_0304_DriveEnd" ) == 2 ) then
				TppEnemy.Warp( "Tactical_Vehicle_WEST_005" , "warp_ToAsylumVehicle" )
			else
				TppEnemy.EnableRoute( this.cpID , "Seq40_03_RideOnVehicle" )
				TppEnemy.EnableRoute( this.cpID , "Seq40_04_RideOnVehicle" )
				TppEnemy.DisableRoute( this.cpID , "Seq40_03_PreRideOnVehicle" )
				TppEnemy.DisableRoute( this.cpID , "Seq40_04_PreRideOnVehicle" )
				TppEnemy.ChangeRoute( this.cpID , "Seq40_03","e20010_Seq40_SneakRouteSet","Seq40_03_RideOnVehicle", 0 )
				TppEnemy.ChangeRoute( this.cpID , "Seq40_04","e20010_Seq40_SneakRouteSet","Seq40_04_RideOnVehicle", 0 )
			end
		end
	end
	GuardTarget_Setting()	

	local radioDaemon = RadioDaemon:GetInstance()
	

	



	TppRadio.RestoreIntelRadio()

	
	SetOptionalRadio()
	if( sequence == "Seq_NextRescuePaz" ) then
		if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1260") == false ) then
			if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true )then
				
				if( TppMission.GetFlag( "isPlayInterrogationAdv" ) == false ) then
					e20010_require_01.InterrogationAdviceTimerReStart()
				else
					if( TppMission.GetFlag( "isPazMarkJingle" ) == false ) then
						TppRadio.DelayPlay("Miller_InterrogationAdvice", "mid")
						TppRadio.RegisterOptionalRadio( "Optional_Interrogation" )
					end
				end
			elseif( TppMission.GetFlag( "isQuestionChico" ) == true )then
				if( TppMission.GetFlag( "isSaftyArea01" ) == true ) then
					TppRadio.DelayPlay("Miller_TakeChicoOnHeli", 3.5)
				end
			end
		end
	end
	
	if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1270") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1271") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1272") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1274") == false ) then
		if( TppMission.GetFlag( "isPazMarkJingle" ) == false and TppMission.GetFlag( "isInterrogation_Radio" ) == false ) then
			
			TppRadioCommand.SetEnableDisableRadioWhileChico3TapeIsPlaying( true )
		else
			
			TppRadioCommand.SetEnableDisableRadioWhileChico3TapeIsPlaying( false )
		end
	else
		
		TppRadioCommand.SetEnableDisableRadioWhileChico3TapeIsPlaying( false )
	end

end




local SetGameOverMissionFailed = function()
	local uiCommonData = UiCommonDataManager.GetInstance()
	uiCommonData:SetGameOverMissionFailed()
end

local SetGameOverTimeParadox = function()
	local uiCommonData = UiCommonDataManager.GetInstance()
	uiCommonData:SetGameOverTimeParadox()
end








local Asylum_MarkerON = function()
	TppMarker.Enable( "20010_marker_Chico", 2 , "moving" , "map" , 0 , false )
end

local Cassette_MarkerOn = function()
	TppMarker.Enable( "Marker_Cassette", 0 , "none" , "map_only_icon" , 0 , false , true )
end

local Duct_MarkerOn = function()
	TppMarker.Enable( "Marker_Duct", 0 , "none" , "map_only_icon" , 0 , false , true )
end

local Xof_MarkerOn = function()
	TppMarker.Enable( "Marker_XOF", 0 , "none" , "map_only_icon" , 0 , false , true )
end

local RV_MarkerON = function()
	TppMarker.Enable( "20010_marker_RV" , 0 , "moving" , "all" , 0 , false , true )

end

local Chico_MarkerON = function()
	
	if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == false ) then
		
		TppMarker.Enable( "Chico" , 0 , "none" , "map_and_world_only_icon" , 0 , true )
	
	else
		
		TppMarkerSystem.DisableMarker{ markerId = "Chico" }
	end
end

local Paz_MarkerON = function()
	
	if( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == false ) then
		
		TppMarker.Enable( "Paz" , 0 , "none" , "map_and_world_only_icon" , 0 , true )
	
	else
		
		TppMarkerSystem.DisableMarker{ markerId = "Paz" }
	end
end





local RankingFeedBack = function()
	
	local Rank = PlayRecord.GetRank()
	if( Rank == 0 ) then
	elseif( Rank == 1 ) then
		Trophy.TrophyUnlock(4)
	elseif( Rank == 2 ) then
	elseif( Rank == 3 ) then
	elseif( Rank == 4 ) then
	else
	end
end

local Common_CenterBigGate_DefaultOpen = function()
	TppGadgetUtility.SetDoor{ id = "gntn_BigGate", isVisible = true, isEnableBounder = false, isOpen = true }
end

local Common_CenterBigGate_Open = function()
	local gateObj = Ch.FindCharacterObjectByCharacterId( "gntn_BigGate" )
	local gateChara = gateObj:GetCharacter()
	gateChara:SendMessage( TppGadgetStartActionRequest() )
end

local Common_CenterBigGate_Close = function()
	local gateObj = Ch.FindCharacterObjectByCharacterId( "gntn_BigGate" )
	local gateChara = gateObj:GetCharacter()
	gateChara:SendMessage( TppGadgetUnsetOwnerRequest() )
	gateChara:SendMessage( TppGadgetEndActionRequest() )
end

local SpHostage_Enable = function()
	TppCharacterUtility.SetEnableCharacterIdWithMarker( "SpHostage" , true )
end

local SpHostage_Disable = function()

	if( TppMission.GetFlag( "isSpHostageEncount" ) == true ) then
		
	else
		
		TppCharacterUtility.SetEnableCharacterIdWithMarker( "SpHostage" , false )
	end
end

local Seq10Trap_Enable = function()
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "AsyInsideRouteChange_01", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "EastCampMoveTruck_Start", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "EastCampSouth_SL_RouteChange", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "GunTutorialEnemyRouteChange", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Talk_AsyWC", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Talk_ChicoTape", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Talk_EscapeHostage", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "VehicleStart", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "CTE0010_0310_NearArea", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Talk_Helipad01", true , false )
end

local Seq10Trap_Disable = function()
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "AsyInsideRouteChange_01", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "EastCampMoveTruck_Start", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "EastCampSouth_SL_RouteChange", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "GunTutorialEnemyRouteChange", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Talk_AsyWC", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Talk_ChicoTape", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Talk_EscapeHostage", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "VehicleStart", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "CTE0010_0310_NearArea", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Talk_Helipad01", false , false )
end

local Seq20Trap_Enable = function()
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "BoilarEnemyRouteChange", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ComEne11_RouteChange", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "GateOpenTruckRouteChange", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seaside2manStartRouteChange", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq20_05_RouteChange", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ChicoMonologue", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ChicoMonologue02", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ChicoMonologue03", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ChicoMonologue04", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "CTE0010_0280_NearArea", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ComEne17_RouteChange", true , false )

end

local Seq20Trap_Disable = function()
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "BoilarEnemyRouteChange", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ComEne11_RouteChange", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "GateOpenTruckRouteChange", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seaside2manStartRouteChange", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq20_05_RouteChange", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Talk_KillSpHostage01", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ChicoMonologue", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ChicoMonologue02", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ChicoMonologue03", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ChicoMonologue04", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "CTE0010_0280_NearArea", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ComEne17_RouteChange", false , false )
end

local Seq10_20Trap_Enable = function()
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Center2F_EneRouteChange", true , false )



	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "SmokingRouteChange", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Talk_Helipad02", true , false )
end

local Seq10_20Trap_Disable = function()
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Center2F_EneRouteChange", false , false )



	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "SmokingRouteChange", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Talk_Helipad02", false , false )
end

local Seq30Trap_Enable = function()
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq30_PatrolVehicle_Start", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq30_PazCheck_Start", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq30_ArmorVehicle_Start", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq30_02_RouteChange", true , false )
end

local Seq30Trap_Disable = function()
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq30_PatrolVehicle_Start", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq30_PazCheck_Start", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq30_ArmorVehicle_Start", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq30_02_RouteChange", false , false )
end

local Seq40Trap_Enable = function()
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "toAsylumGroupStart", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ComEne24_RouteChange", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq40_ComEne27_RouteChange", true , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq40_ArmorVehicle_Start", true , false )
end

local Seq40Trap_Disable = function()
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "toAsylumGroupStart", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ComEne24_RouteChange", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq40_ComEne27_RouteChange", false , false )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq40_ArmorVehicle_Start", false , false )
end

local GetChicoTape = function()


	local uiCommonData = UiCommonDataManager.GetInstance()
	uiCommonData:GetBriefingCassetteTape( "tp_chico_03" )
	TppMission.SetFlag( "isChicoTapeGet", true )
	

	SetOptionalRadio()
end








local UnlockDoorFromPhase = function()






	local chicoNum = 0
	local pazNum = 0

	chicoNum = TppEnemyUtility.GetNumberOfActiveSoldierByBoxShape( Vector3(69, 20, 204), this.eneCheckSize_chico )
	pazNum = TppEnemyUtility.GetNumberOfActiveSoldierByBoxShape( Vector3(-138, 24, -16), eneCheckSize_paz )







	if ( chicoNum == 0 ) then
		



		changeEnablePickingDoor( "AsyPickingDoor24", "unlock" ) 	
	end
	if ( pazNum == 0 ) then
		



		changeEnablePickingDoor( "Paz_PickingDoor00", "unlock" ) 	
	end
end



local commonGetGsRouteRouteName = function( string )
	if DEBUG then
		return GsRoute.DEBUG_GetRouteName( string )
	else
		return string
	end
end

local Common_Alert = function()

	
	GZCommon.CallAlertSirenCheck()

	changeEnablePickingDoor( "AsyPickingDoor24", "lock" ) 	
	changeEnablePickingDoor( "Paz_PickingDoor00", "lock" ) 	


	
	local radioDaemon = RadioDaemon:GetInstance()
	radioDaemon:DisableFlagIsCallCompleted( "e0010_oprg9020" )

end

local Common_Evasion = function()

	
	GZCommon.StopAlertSirenCheck()

	
	UnlockDoorFromPhase()
	
	
	

	local PhaseState = TppData.GetArgument( 2 )
	if PhaseState == "Down" then				
		local radioDaemon = RadioDaemon:GetInstance()
		local sequence = TppSequence.GetCurrentSequence()

		
		Common_RetryKeepCautionSiren()

		
		radioDaemon:DisableFlagIsCallCompleted( "e0010_oprg9010" )

		
		if( sequence == "Seq_RescueHostages" ) then			
			TppEnemy.ChangeRouteSet( this.cpID , "e20010_Seq10_CautionRouteSet", { warpEnemy = false } )
		elseif( sequence == "Seq_NextRescuePaz" ) then		
			TppEnemy.ChangeRouteSet( this.cpID , "e20010_Seq20_CautionRouteSet", { warpEnemy = false } )
		elseif( sequence == "Seq_NextRescueChico" ) then	
			TppEnemy.ChangeRouteSet( this.cpID , "e20010_Seq40_CautionRouteSet", { warpEnemy = false } )
		elseif( sequence == "Seq_ChicoPazToRV" ) then		
			TppEnemy.ChangeRouteSet( this.cpID , "e20010_Seq30_CautionRouteSet", { warpEnemy = false } )
		elseif( sequence == "Seq_PazChicoToRV" ) then		
			TppEnemy.ChangeRouteSet( this.cpID , "e20010_Seq50_CautionRouteSet", { warpEnemy = false } )
		else
			if( TppMission.GetFlag( "isFirstEncount_Chico" ) == true ) then		
				TppEnemy.ChangeRouteSet( this.cpID , "e20010_Seq40_CautionRouteSet", { warpEnemy = false } )
			else		
				TppEnemy.ChangeRouteSet( this.cpID , "e20010_Seq50_CautionRouteSet", { warpEnemy = false } )
			end
		end
		
		if( TppMission.GetFlag( "isAlertCageCheck" ) == true ) then
			TppRadio.DelayPlayEnqueue("Miller_UlMeetChicoPazInCombat", "mid")
			TppMission.SetFlag( "isAlertCageCheck", false )

		elseif( TppMission.GetFlag( "isAlertTapeAdvice" ) == true ) then
			e20010_require_01.Radio_AlertTapeReAdvice()
		elseif( sequence == "Seq_NextRescuePaz" and	
				radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0081") == true or
				radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0082") == true ) then
			if( TppPlayerUtility.IsCarriedCharacter( "Chico" ) == true and		
				TppMission.GetFlag( "isSaftyArea01" ) == true ) then			
				TppRadio.DelayPlayEnqueue("Miller_ReChicoAdviceCarrie", "mid")
			elseif( TppMission.GetFlag( "isPazChicoDemoArea" ) == true ) then	
				TppRadio.DelayPlayEnqueue("Miller_ReChicoAdviceEva", "mid")
				TppRadio.DelayPlayEnqueue("Miller_PazChicoCarriedEndRV", "short")
			else
				TppRadio.DelayPlayEnqueue("Miller_ReChicoAdviceOutRV", "mid")
			end
		else
			if ( TppMission.GetFlag( "isDoCarryAdvice" ) == true and
				radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0050") == false ) then	
				TppRadio.DelayPlay( "Miller_MovingAdvice", "short" )
			end
		end
	else
	end
end

local Common_Caution = function()
	
	GZCommon.StopAlertSirenCheck()
	
	UnlockDoorFromPhase()
	local PhaseState = TppData.GetArgument( 2 )
	if PhaseState == "Down" then				

		
		local radioDaemon = RadioDaemon:GetInstance()
		radioDaemon:DisableFlagIsCallCompleted( "e0010_oprg9010" )
		radioDaemon:DisableFlagIsCallCompleted( "e0010_oprg9020" )

		
		Common_RetryKeepCautionSiren()

		if( TppMission.GetFlag( "isKeepCaution" ) == true ) then
			if( TppMission.GetFlag( "isPlayerOnHeli" ) == false ) then
				TppRadio.DelayPlayEnqueue("Miller_DontSneakPhase", "mid")
			end
		else
			local radioDaemon = RadioDaemon:GetInstance()
			if ( TppMission.GetFlag( "isDoCarryAdvice" ) == true and
				radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0050") == false ) then	
				TppRadio.DelayPlay( "Miller_MovingAdvice", "short" )
			end
		end
	else
	end
end

local Common_Sneak = function()

	
	GZCommon.StopAlertSirenCheck()

	
	local radioDaemon = RadioDaemon:GetInstance()
	radioDaemon:DisableFlagIsCallCompleted( "e0010_oprg9010" )
	radioDaemon:DisableFlagIsCallCompleted( "e0010_oprg9020" )

	
	UnlockDoorFromPhase()
	local PhaseState = TppData.GetArgument( 2 )
	if PhaseState == "Down" then				
		local radioDaemon = RadioDaemon:GetInstance()
		local sequence = TppSequence.GetCurrentSequence()

		if( sequence == "Seq_NextRescuePaz" and	
				radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0081") == true or
				radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0082") == true ) then
			if( TppMission.GetFlag( "isPazChicoDemoArea" ) == true and	
				TppMission.GetFlag( "isSaftyArea01" ) == true ) then	
			
			end
		elseif ( TppMission.GetFlag( "isDoCarryAdvice" ) == true and
			radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0050") == false ) then	
			TppRadio.DelayPlay( "Miller_MovingAdvice", "short" )

		end
	else
	end
end

local Common_Hostage001_Dead = function()
	TppMission.SetFlag( "isHostageUnusual", true )


	
	local killChk = TppData.GetArgument( 4 )
	if killChk == true then
		TppRadio.DelayPlayEnqueue("Miller_KillHostage", "mid")
	end
end

local Common_Hostage002_Dead = function()
	TppMission.SetFlag( "isHostageUnusual", true )


	
	local killChk = TppData.GetArgument( 4 )
	if killChk == true then
		TppRadio.DelayPlayEnqueue("Miller_KillHostage", "mid")
	end
end

local Common_Hostage003_Dead = function()
	TppMission.SetFlag( "isAfterChicoDemoHostage", true )


	
	local killChk = TppData.GetArgument( 4 )
	if killChk == true then
		TppRadio.DelayPlayEnqueue("Miller_KillHostage", "mid")
	end
end

local Common_Hostage004_Dead = function()


	
	local killChk = TppData.GetArgument( 4 )
	if killChk == true then
		TppRadio.DelayPlayEnqueue("Miller_KillHostage", "mid")
	end
end

local Common_SpHostage_Dead = function()
	TppMission.SetFlag( "isSpHostage_Dead", true )
	TppRadio.DisableIntelRadio( "SpHostage" )

	PlayRecord.UnsetMissionChallenge( "HOSTAGE_RESCUE" )

	if( TppMission.GetFlag( "isKillingSpHostage" ) == true ) then
		

	else
	end

	
	local killChk = TppData.GetArgument( 4 )
	if killChk == true then
		TppRadio.DelayPlayEnqueue("Miller_KillHostage", "mid")
	end
	TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( "Seq20_03", 1 )
end

local Common_VehicleBroken = function()

	local CharacterID = TppData.GetArgument( 1 )

	if CharacterID == "Tactical_Vehicle_WEST_002" then
		TppMission.SetFlag( "isSeq10_02_DriveEnd", 1 )
	else
	end
end

local Common_TruckBroken = function()

	local CharacterID = TppData.GetArgument( 1 )

	if CharacterID == "Cargo_Truck_WEST_003" then
		TppMission.SetFlag( "isSeq10_03_DriveEnd", 1 )
	else
	end
end

local Common_EnemyDiscoveryNoPaz = function()

	local hostageID = TppData.GetArgument( 2 )
	local stateID = TppData.GetArgument( 3 )
	if hostageID == "Paz" then						
		if stateID == "ReportedLostHostage" then	
			
			TppCommandPostObject.GsSetKeepPhaseName( this.cpID , "Caution" )
			GZCommon.CallCautionSiren()
			local sequence = TppSequence.GetCurrentSequence()
			if( sequence == "Seq_NextRescueChico" ) then
				TppRadio.Play("Miller_PazJailBreak")
			else
				TppRadio.Play("Miller_PazJailBreak2")
			end
			TppMission.SetFlag( "isKeepCaution", true )
			
			TppMusicManager.SetSwitch{
				groupName = "bgm_phase_ct_level",
				stateName = "bgm_phase_ct_level_02",
			}
			TppMission.SetFlag( "isPazPrisonBreak", true )	
		elseif stateID == "ReportedHostage" then	
			TppRadio.Play("Miller_EnemyDiscoveryPaz")
		end
	elseif hostageID == "Chico" then						
		if stateID == "ReportedHostage" then
			TppRadio.Play("Miller_EnemyDiscoveryChico")
		end
	end
end

local Common_EnemyDead = function()

	local sequence = TppSequence.GetCurrentSequence()
	local CharaID = TppData.GetArgument(1)

	if( sequence == "Seq_RescueHostages" ) then
		if CharaID == "Seq10_01" then
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_01" , false )
		elseif CharaID == "Seq10_02" then
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_02" , false )
		elseif CharaID == "Seq10_03" then
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_03" , false )
		end
	elseif( sequence == "Seq_NextRescuePaz" ) then
		if CharaID == "Seq20_02" then
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq20_02" , false )
		else
		end
	elseif( sequence == "Seq_NextRescueChico" ) or ( sequence == "Seq_PazChicoToRV" ) then
		if CharaID == "Seq40_03" then
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq40_03" , false )
		elseif CharaID == "Seq40_04" then
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq40_04" , false )
		end
	elseif( sequence == "Seq_ChicoPazToRV" ) then
		if CharaID == "Seq30_05" then
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq30_05" , false )
		else
		end
	else	
		if( TppMission.GetFlag( "isFirstEncount_Chico" ) == true ) then
			if CharaID == "Seq30_05" then
				TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq30_05" , false )
			else
			end
		else
			if CharaID == "Seq40_03" then
				TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq40_03" , false )
			elseif CharaID == "Seq40_04" then
				TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq40_04" , false )
			end
		end
	end
end

local Common_PreEnemyCarryAdvice = function()
	if( TppMission.GetFlag( "isPreCarryAdvice" ) == false ) then
		if( TppMission.GetFlag( "isDoCarryAdvice" ) == true ) then
			TppRadio.DelayPlay("Miller_PreCarryAdvice", "long" )
			TppMission.SetFlag( "isPreCarryAdvice", true )
		end
	end
end

local Common_ChangeAntiAir = function()

	
	local status = TppData.GetArgument(2)
	
	if ( status == true ) then
		
		GZCommon.CallCautionSiren()
	
	else
		
		GZCommon.StopSirenNormal()
	end
end

local Common_PlayerOnHeli = function()

	
	if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true
		and TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then		
		
		TppSequence.ChangeSequence( "Seq_PlayerOnHeliAfter" )				
	else
		local sequence = TppSequence.GetCurrentSequence()
		
		if( sequence == "Seq_ChicoPazToRV" or sequence == "Seq_PazChicoToRV" ) then
			local NearCheckPaz = false
			local NearCheckChico = false
			if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true) then	
				
				if( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == false ) then
					NearCheckPaz = e20010_require_01.playerNearCheck("Paz")
				end
			else															
				
				if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == false ) then
					NearCheckChico = e20010_require_01.playerNearCheck("Chico")
				end
			end
			if( NearCheckPaz == true or NearCheckChico == true ) then
				TppRadio.Play("Miller_DontOnHeliOnlyPlayer")
			else
				TppRadio.Play("Miller_MissionFailedOnHeli")
			end
		else
			TppRadio.DelayPlay( "Miller_MissionFailedOnHeli", "mid" )
		end
		
		TppSupportHelicopterService.SetEnableGetOffTime( GZCommon.WaitTime_HeliTakeOff )
	end
end

local Common_PickUpWeaopn = function()
	local weaponID = TppData.GetArgument( 1 )
	if weaponID == "WP_ms02" then					
		TppRadio.DelayPlayEnqueue("Miller_MissileGet", "mid")
		if( TppMission.GetFlag( "isPrimaryWPIcon" ) == false ) then
			e20010_require_01.Tutorial_2Button("tutorial_primary_wp_select", fox.PAD_U, "RStick")
			TppMission.SetFlag( "isPrimaryWPIcon", true )
		end
	elseif weaponID == "WP_sr01_v00" then				
		if( TppMission.GetFlag( "isPrimaryWPIcon" ) == false ) then
			e20010_require_01.Tutorial_2Button("tutorial_primary_wp_select", fox.PAD_U, "RStick")
			TppMission.SetFlag( "isPrimaryWPIcon", true )
		end
	elseif weaponID == "WP_hg00_v01" then				

	elseif weaponID == "WP_hg02_v00" then						
		TppRadio.DelayPlayEnqueue("Miller_SpWeaponGet", "mid")
	elseif weaponID == "WP_Grenade" then				
		TppRadio.DelayPlayEnqueue("Miller_GranadoGet", "mid")
	elseif weaponID == "WP_SmokeGrenade" then		

	elseif weaponID == "WP_C4" then					
		TppRadio.DelayPlayEnqueue("Miller_GranadoGet", "mid")
	elseif weaponID == "WP_Claymore" then						

	else
	end
end

local Common_PickUpItem = function()
	local ItemID = TppData.GetArgument( 1 )
	local IndexNo = TppData.GetArgument( 2 )
	if ItemID == "IT_XOFEmblem" then					
		if IndexNo == 9 then
		
				AnounceLog_GetXofMark()
				PlayRecord.RegistPlayRecord( "EMBLEM_GET" )
		else
			AnounceLog_GetXofMark()
			PlayRecord.RegistPlayRecord( "EMBLEM_GET" )
		end
	elseif ItemID == "IT_Cassette" then					
		if IndexNo == 1 then
			local uiCommonData = UiCommonDataManager.GetInstance()
			uiCommonData:GetBriefingCassetteTape( "tp_chico_02" )
		elseif IndexNo == 4 then
			local uiCommonData = UiCommonDataManager.GetInstance()
			uiCommonData:GetBriefingCassetteTape( "tp_chico_05" )
		elseif IndexNo == 12 then
			local uiCommonData = UiCommonDataManager.GetInstance()
			uiCommonData:GetBriefingCassetteTape( "tp_bgm_03" )
		else
		end
	else
	end
end

local Common_EquipWeapon = function()
	local weaponID = TppData.GetArgument( 1 )
	local radioDaemon = RadioDaemon:GetInstance()

	if weaponID == "WP_WarningFlare" then								
		if ( radioDaemon:IsPlayingRadio() == false ) then
			
			if ( TppMission.GetFlag("isHeliComingRV") == false and
				 TppMission.GetFlag("isDoCarryAdvice") == true ) then
				TppRadio.DelayPlay( "Miller_WarningFlareAdvice", "short" )
			end
		end
	else
	end
end

local WoodTurret_RainFilter_ON = function()
	local rainManager = TppRainFilterInterruptManager:GetInstance()
	
	rainManager:SetStartEndFadeInDistanceDemo( 1, 4, 1 )
end

local MissionArea_Out = function()

end


local Common_ChicoPazCarry = function()
	TppMission.SetFlag( "isSeq10_02_DriveEnd", 1 )
	TppMission.SetFlag( "isSeq10_03_DriveEnd", 1 )
end


local Common_ChicoOnHeli = function()

	local sequence = TppSequence.GetCurrentSequence()
	local VehicleID = TppData.GetArgument(3)




	if VehicleID == "SupportHelicopter" then							
		TppMission.SetFlag( "isPlaceOnHeliChico", true )				
		SetComplatePhoto(10)											
		TppMarkerSystem.DisableMarker{ markerId = "Chico" }
		AnounceLog_ChicoRideOnHeli()	

		PlayRecord.RegistPlayRecord( "HOSTAGE_RESCUE", "Chico" )

		
		if ( sequence == "Seq_NextRescuePaz" ) then
			
			TppSupportHelicopterService.SetDefaultRendezvousPointMarker("no_lz")
			if( TppMission.GetFlag( "isChicoTapePlay" ) == true ) then
				commonUiMissionSubGoalNo(4)		
			else
			end
		elseif ( sequence == "Seq_ChicoPazToRV" )
			or ( sequence == "Seq_PazChicoToRV" ) then
			if ( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == false ) then
				commonUiMissionSubGoalNo(7)
			else
			end
		elseif ( sequence == "Seq_PlayerOnHeli" ) then
			commonUiMissionSubGoalNo(8)
		end

		TppRadio.DisableIntelRadio( "Chico" )
		
		SetOptionalRadio()

		
		TppHostageManager.GsGetOnHelicopter("Chico","CNP_pos_rbr")
		e20010_require_01.ChicoPaznHeliSave()							

		if( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then			
			
			local hudCommonData = HudCommonDataManager.GetInstance()
			hudCommonData:AnnounceLogViewLangId( "announce_mission_goal" )
			e20010_require_01.Timer_PlayerOnHeliAdviceStart()
			TppSequence.ChangeSequence( "Seq_PlayerOnHeli" )
		else															
		end
	
	elseif VehicleID == "Tactical_Vehicle_WEST_002" then
		TppMission.SetFlag( "isSeq10_02_DriveEnd", 2 )
	elseif VehicleID == "Cargo_Truck_WEST_003" then
		TppMission.SetFlag( "isSeq10_03_DriveEnd", 2 )
	else
		TppMission.SetFlag( "isSeq10_02_DriveEnd", 1 )
		TppMission.SetFlag( "isSeq10_03_DriveEnd", 1 )
	end
end

local Common_PazOnHeli = function()
	local sequence = TppSequence.GetCurrentSequence()
	local VehicleID = TppData.GetArgument(3)




	if VehicleID == "SupportHelicopter" then							
		TppMission.SetFlag( "isPlaceOnHeliPaz", true )					
		TppMarkerSystem.DisableMarker{ markerId = "20010_marker_RV" }	
		SetComplatePhoto(30)											
		
		
		local hardmode = TppGameSequence.GetGameFlag("hardmode")	
		if hardmode == true then									
			PlayRecord.RegistPlayRecord( "PAZ_RESCUE" )				
			
		else														
		end
		
		TppRadio.DisableIntelRadio( "Paz" )
		SetOptionalRadio()	
		TppMarkerSystem.DisableMarker{ markerId = "Paz" }
		PlayRecord.RegistPlayRecord( "PAZ_RESCUE" )
		AnounceLog_PazRideOnHeli()	

		PlayRecord.RegistPlayRecord( "HOSTAGE_RESCUE", "Paz" )

		
		if ( sequence == "Seq_NextRescueChico" ) then
			
			TppSupportHelicopterService.SetDefaultRendezvousPointMarker("no_lz")
			commonUiMissionSubGoalNo(1)
		elseif ( sequence == "Seq_ChicoPazToRV" )
			or ( sequence == "Seq_PazChicoToRV" ) then
			if ( TppMission.GetFlag( "isPlaceOnHeliChico" ) == false ) then
				commonUiMissionSubGoalNo(3)
			else
			end
		elseif ( sequence == "Seq_PlayerOnHeli" ) then
			commonUiMissionSubGoalNo(8)
		end

		
		TppHostageManager.GsGetOnHelicopter("Paz","CNP_pos_rsm")
		e20010_require_01.ChicoPaznHeliSave()							

		if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) then		
			
			local hudCommonData = HudCommonDataManager.GetInstance()
			hudCommonData:AnnounceLogViewLangId( "announce_mission_goal" )
			e20010_require_01.Timer_PlayerOnHeliAdviceStart()
			TppSequence.ChangeSequence( "Seq_PlayerOnHeli" )
		else															
			TppRadio.DelayPlayEnqueue( "Miller_ChicoOnHeliAdvice", "short" )
		end
	
	elseif VehicleID == "Tactical_Vehicle_WEST_002" then
		TppMission.SetFlag( "isSeq10_02_DriveEnd", 2 )
	elseif VehicleID == "Cargo_Truck_WEST_003" then
		TppMission.SetFlag( "isSeq10_03_DriveEnd", 2 )
	else
		TppMission.SetFlag( "isSeq10_02_DriveEnd", 1 )
		TppMission.SetFlag( "isSeq10_03_DriveEnd", 1 )
	end
end

local Common_SpHostageOnHeli = function()
	local CharacterID	= TppData.GetArgument(1)
	local VehicleID = TppData.GetArgument(3)
	if VehicleID == "SupportHelicopter" then								
		if( TppMission.GetFlag( "isSpHostage_Dead" ) == false ) then		
			TppMission.SetFlag( "isPlaceOnHeliSpHostage", true )			
			PlayRecord.PlusExternalScore( 3500 )		
			Trophy.TrophyUnlock(6)		
			TppRadio.DelayPlay("Miller_EnemyOnHeli", "mid")
			PlayRecord.RegistPlayRecord( "HOSTAGE_RESCUE", "SpHostage" )
			AnounceLog_SpHostageRideOnHeli()
		else																
			
		end
	else
	end
end

local Common_HostageOnHeli = function()

	local CharacterID	= TppData.GetArgument(1)
	local status = TppHostageUtility.GetStatus( CharacterID )
	local VehicleID = TppData.GetArgument(3)
	if VehicleID == "SupportHelicopter" then								
		if( status ~= "Dead" ) then											
			TppRadio.DelayPlay("Miller_EnemyOnHeli", "mid")
			GZCommon.NormalHostageRecovery( CharacterID )
		else
		end
	else
	end
end

local Common_Hostage04OnHeli = function()

	local CharacterID	= TppData.GetArgument(1)
	local VehicleID = TppData.GetArgument(3)
	local status = TppHostageUtility.GetStatus( "Hostage_e20010_004" )

	if VehicleID == "SupportHelicopter" then								
		if( status ~= "Dead" ) then											
			TppMission.SetFlag( "isPlaceOnHeliHostage04", true )			
			TppRadio.DelayPlay("Miller_EnemyOnHeli", "mid")
			GZCommon.NormalHostageRecovery( CharacterID )
		else																
		end
	else
	end
end

local Common_EnemyOnHeli = function()
	local characterID = TppData.GetArgument(1)
	local VehicleID = TppData.GetArgument(3)
	if VehicleID == "SupportHelicopter" then								
		local status = TppEnemyUtility.GetLifeStatus( characterID )
		if (status ~="Dead")then
			TppRadio.DelayPlay("Miller_EnemyOnHeli", "mid")
		end
	else
	end
end

local Common_SpHostageCarryStart = function()

	local sequence = TppSequence.GetCurrentSequence()

	TppMission.SetFlag( "isCarryOnSpHostage", true )			
	TppMission.SetFlag( "isSpHostageEncount", true )
	TppRadio.DisableIntelRadio( "SpHostage" )

	if( TppMission.GetFlag( "isSpHostage_Dead" ) == false ) then		
		if ( sequence == "Seq_RescueHostages" ) then
			TppRadio.Play("Miller_CarrySpHostage")
			if( TppMission.GetFlag( "isEscapeHostage" ) == false ) then
				TppEnemy.EnableRoute( this.cpID , "S_Talk_EscapeHostage" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Pre_EscapeHostageTalk_a" )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne13","e20010_Seq10_SneakRouteSet","S_Talk_EscapeHostage",0 )
				TppMission.SetFlag( "isEscapeHostage", true )
			else
			end
		else
			local radioDaemon = RadioDaemon:GetInstance()
			if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1095") == false ) then
				TppRadio.Play("Miller_RescueSpHostage")
			end
		end
	else																
		
	end
end

local Common_RideOnVehicle = function()
	local CharacterID = TppData.GetArgument(1)
	local VehicleID = TppData.GetArgument(2)
	local hudCommonData = HudCommonDataManager.GetInstance()

	
	if VehicleID == "WheeledArmoredVehicleMachineGun" then
		TppMission.SetFlag( "isSeq10_02_DriveEnd", 1 )
		TppMission.SetFlag( "isSeq10_03_DriveEnd", 1 )
		local radioDaemon = RadioDaemon:GetInstance()
		if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1060") == true ) then
			hudCommonData:CallButtonGuide( "tutorial_vehicle_attack", "VEHICLE_FIRE" )
		end
		TppRadio.DelayPlay( "Miller_StrykerDriveAdvice", "mid" )
	
	elseif VehicleID == "SupportHelicopter" then
		
	else

			
			hudCommonData:CallButtonGuide( "tutorial_accelarater", "VEHICLE_TRIGGER_ACCEL" )
			
			hudCommonData:CallButtonGuide( "tutorial_brake", "VEHICLE_TRIGGER_BREAK" )

			TppMission.SetFlag( "isCarTutorial", true )							

		
		if CharacterID == "Tactical_Vehicle_WEST_002" then
			TppMission.SetFlag( "isSeq10_02_DriveEnd", 2 )		
		elseif CharacterID == "Cargo_Truck_WEST_003" then
			TppMission.SetFlag( "isSeq10_03_DriveEnd", 2 )		
		else
			TppMission.SetFlag( "isSeq10_02_DriveEnd", 1 )
			TppMission.SetFlag( "isSeq10_03_DriveEnd", 1 )
		end
	end
end

local Common_HeliArrive = function()
	local sequence = TppSequence.GetCurrentSequence()
	local lz = TppData.GetArgument( 2 )
	local timer = 55 
	local NearCheckPaz = false
	local NearCheckChico = false





	if (lz == "RV_SeaSide") then
		TppMission.SetFlag( "isHeliComeToSea", true )
	else
		TppMission.SetFlag( "isHeliComeToSea", false )
	end

	
	TppMission.SetFlag( "isHeliLandNow", true )						
	GkEventTimerManager.Start( "Timer_pleaseLeaveHeli", timer )

	if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true and
		TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then	

	else																												
		
		if( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == false ) then
			NearCheckPaz = e20010_require_01.playerNearCheck("Paz")
		end
		if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == false ) then
			NearCheckChico = e20010_require_01.playerNearCheck("Chico")
		end

		if( NearCheckPaz == true or NearCheckChico == true ) then		
			TppRadio.Play("Miller_TargetOnHeliAdvice")

		else																
			if( e20010_require_01.playerNearCheck("Hostage_e20010_001") == true 	
				or e20010_require_01.playerNearCheck("Hostage_e20010_002") == true
				or e20010_require_01.playerNearCheck("Hostage_e20010_003") == true
				or e20010_require_01.playerNearCheck("Hostage_e20010_004") == true
				or e20010_require_01.playerNearCheck("SpHostage") == true ) then

			else																	
				if( sequence == "Seq_ChicoPazToRV" or
					sequence == "Seq_PazChicoToRV" ) then
					TppRadio.Play("Miller_TargetOnHeliAdvice")
				elseif( sequence == "Seq_PlayerOnHeli" ) then

				else
					TppRadio.Play("Miller_DontEscapeTargetOnHeli")
				end
			end

		end
	end
end

local Common_Departure = function()

	local isPlayer = TppData.GetArgument(3)
	
	if ( isPlayer == true ) then
		TppMission.SetFlag( "isPlayerOnHeli", true )					
		TppSequence.ChangeSequence( "Seq_PlayerOnHeliAfter" )	
	else
		TppMission.SetFlag( "isPlayerOnHeli", false )					
	end

	TppMission.SetFlag( "isHeliLandNow", false )						
end

local Common_HeliCloseDoor = function()

	local sequence = TppSequence.GetCurrentSequence()
	local timer = 20 

	
	TppMission.SetFlag( "isHeliComeToSea", false )
	TppMission.SetFlag( "isHeliComingRV", false )
	
	if ( sequence == "Seq_PlayerOnHeliAfter" ) then				
		
		if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true )
			and ( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then
			
			GZCommon.ScoreRankTableSetup( this.missionID )
			TppMission.ChangeState( "clear", "RideHeli_Clear" )		
		else
			TppMission.ChangeState( "failed", "PlayerOnHeli" )
		end
	else		
		
		
		
		if( TppMission.GetFlag( "isChicoTapeGet" ) == false ) and ( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) and ( TppMission.GetFlag( "isFinishOnHeliChico" ) == false )
		and ( TppMission.GetFlag( "isGetDuctInfomation" ) == false ) and ( TppMission.GetFlag( "isPlaceOnHeliSpHostage" ) == true ) and ( TppMission.GetFlag( "isFinishOnHeliSpHostage" ) == false )
		and ( TppMission.GetFlag( "isGetXofMark_Hostage04" ) == false ) and ( TppMission.GetFlag( "isPlaceOnHeliHostage04" ) == true ) and ( TppMission.GetFlag( "isFinishOnHeliHostage04" ) == false ) then
			if ( sequence == "Seq_RescueHostages" ) or ( sequence == "Seq_NextRescuePaz" ) then
				
			
			
				GkEventTimerManager.Start( "Timer_HeliCloseDoor_01", timer )
				
				TppMission.SetFlag( "isChicoTapeGet", true )
				TppMission.SetFlag( "isGetDuctInfomation", true )
				TppMission.SetFlag( "isGetXofMark_Hostage04", true )
				TppMission.SetFlag( "isFinishOnHeliChico", true )
				TppMission.SetFlag( "isFinishOnHeliSpHostage", true )
				TppMission.SetFlag( "isFinishOnHeliHostage04", true )
				
				GetChicoTape()	
				e20010_require_01.InterrogationAdviceTimerStart()	
			
			
			else
				
			
			
				GkEventTimerManager.Start( "Timer_HeliCloseDoor_01b", timer )
				
				TppMission.SetFlag( "isGetXofMark_Hostage04", true )
				TppMission.SetFlag( "isFinishOnHeliChico", true )
				TppMission.SetFlag( "isFinishOnHeliSpHostage", true )
				TppMission.SetFlag( "isFinishOnHeliHostage04", true )
				
			
			end
		
		
		elseif ( TppMission.GetFlag( "isGetDuctInfomation" ) == false ) and ( TppMission.GetFlag( "isPlaceOnHeliSpHostage" ) == true ) and ( TppMission.GetFlag( "isFinishOnHeliSpHostage" ) == false )
		and ( TppMission.GetFlag( "isGetXofMark_Hostage04" ) == false ) and ( TppMission.GetFlag( "isPlaceOnHeliHostage04" ) == true ) and ( TppMission.GetFlag( "isFinishOnHeliHostage04" ) == false ) then
			if ( sequence == "Seq_RescueHostages" ) or ( sequence == "Seq_NextRescuePaz" ) then
				
			
			
				GkEventTimerManager.Start( "Timer_HeliCloseDoor_04", timer )
				
				TppMission.SetFlag( "isGetDuctInfomation", true )
				TppMission.SetFlag( "isGetXofMark_Hostage04", true )
				TppMission.SetFlag( "isFinishOnHeliSpHostage", true )
				TppMission.SetFlag( "isFinishOnHeliHostage04", true )
				
			
			
			else
				
			
			
				GkEventTimerManager.Start( "Timer_HeliCloseDoor_04b", timer )
				
				TppMission.SetFlag( "isGetXofMark_Hostage04", true )
				TppMission.SetFlag( "isFinishOnHeliHostage04", true )
				
			
			end
		
		
		elseif( TppMission.GetFlag( "isChicoTapeGet" ) == false ) and ( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) and ( TppMission.GetFlag( "isFinishOnHeliChico" ) == false )
		and ( TppMission.GetFlag( "isGetXofMark_Hostage04" ) == false ) and ( TppMission.GetFlag( "isPlaceOnHeliHostage04" ) == true ) and ( TppMission.GetFlag( "isFinishOnHeliHostage04" ) == false ) then
			if ( sequence == "Seq_RescueHostages" ) or ( sequence == "Seq_NextRescuePaz" ) then
				
			
			
				GkEventTimerManager.Start( "Timer_HeliCloseDoor_05", timer )
				
				TppMission.SetFlag( "isChicoTapeGet", true )
				TppMission.SetFlag( "isGetXofMark_Hostage04", true )
				TppMission.SetFlag( "isFinishOnHeliChico", true )
				TppMission.SetFlag( "isFinishOnHeliHostage04", true )
				
				e20010_require_01.InterrogationAdviceTimerStart()	
			
			
			else
				
			
			
				GkEventTimerManager.Start( "Timer_HeliCloseDoor_05b", timer )
				
				TppMission.SetFlag( "isGetXofMark_Hostage04", true )
				TppMission.SetFlag( "isFinishOnHeliHostage04", true )
				
			
			end
		
		
		elseif( TppMission.GetFlag( "isChicoTapeGet" ) == false ) and ( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) and ( TppMission.GetFlag( "isFinishOnHeliChico" ) == false )
		and ( TppMission.GetFlag( "isGetDuctInfomation" ) == false ) and ( TppMission.GetFlag( "isPlaceOnHeliSpHostage" ) == true ) and ( TppMission.GetFlag( "isFinishOnHeliSpHostage" ) == false ) then
			if ( sequence == "Seq_RescueHostages" ) or ( sequence == "Seq_NextRescuePaz" ) then
				
			
			
				GkEventTimerManager.Start( "Timer_HeliCloseDoor_06", timer )
				
				TppMission.SetFlag( "isChicoTapeGet", true )
				TppMission.SetFlag( "isGetDuctInfomation", true )
				TppMission.SetFlag( "isFinishOnHeliChico", true )
				TppMission.SetFlag( "isFinishOnHeliSpHostage", true )
				
				e20010_require_01.InterrogationAdviceTimerStart()	
			
			
			else
			end
		
		elseif ( TppMission.GetFlag( "isGetXofMark_Hostage04" ) == false ) and ( TppMission.GetFlag( "isPlaceOnHeliHostage04" ) == true ) and ( TppMission.GetFlag( "isFinishOnHeliHostage04" ) == false ) then
			
		
		
			GkEventTimerManager.Start( "Timer_HeliCloseDoor_02", timer )
			
			TppMission.SetFlag( "isGetXofMark_Hostage04", true )
			TppMission.SetFlag( "isFinishOnHeliHostage04", true )
			
		
		
		elseif ( TppMission.GetFlag( "isGetDuctInfomation" ) == false ) and ( TppMission.GetFlag( "isPlaceOnHeliSpHostage" ) == true ) and ( TppMission.GetFlag( "isFinishOnHeliSpHostage" ) == false ) then
			if ( sequence == "Seq_RescueHostages" ) or ( sequence == "Seq_NextRescuePaz" ) then
				
			
			
				GkEventTimerManager.Start( "Timer_HeliCloseDoor_03", timer )
				
				TppMission.SetFlag( "isGetDuctInfomation", true )
				TppMission.SetFlag( "isFinishOnHeliSpHostage", true )
				
			
			else
			end
		
		elseif ( TppMission.GetFlag( "isChicoTapeGet" ) == false ) and ( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) and ( TppMission.GetFlag( "isFinishOnHeliChico" ) == false ) then
			if ( sequence == "Seq_RescueHostages" ) or ( sequence == "Seq_NextRescuePaz" ) then
				
			
				GkEventTimerManager.Start( "Timer_HeliCloseDoor_07", timer )
				
				TppMission.SetFlag( "isChicoTapeGet", true )
				TppMission.SetFlag( "isFinishOnHeliChico", true )
				
			
				e20010_require_01.InterrogationAdviceTimerStart()	
			else
			end
		end
	end
end

local Radio_HeliCloseDoor = function( setName )
	local RadioSet
	local result = TppStorage.HasXOFEmblem(8)




	if( setName == "RadioSet01" ) then
		if ( result == 0 ) then 
			RadioSet = {"Miller_CommonHostageInformation","Miller_AboutDuct01","Miller_JointVoice01","Miller_XofMarking"}
			Xof_MarkerOn()		
		else
			RadioSet = {"Miller_CommonHostageInformation","Miller_AboutDuct01"}
		end
		Duct_MarkerOn()		
	elseif( setName == "RadioSet01b" ) then
		if ( result == 0 ) then 
			RadioSet = {"Miller_CommonHostageInformation","Miller_XofMarking"}
			Xof_MarkerOn()		
		end
	elseif( setName == "RadioSet04" ) then
		if ( result == 0 ) then 
			RadioSet = {"Miller_CommonHostageInformation","Miller_AboutDuct01","Miller_JointVoice01","Miller_XofMarking"}
			Xof_MarkerOn()		
		else
			RadioSet = {"Miller_CommonHostageInformation","Miller_AboutDuct01"}
		end
		Duct_MarkerOn()		
	elseif( setName == "RadioSet04b" ) then
		if ( result == 0 ) then 
			RadioSet = {"Miller_CommonHostageInformation","Miller_XofMarking"}
			Xof_MarkerOn()		
		end
	elseif( setName == "RadioSet05" ) then
		if ( result == 0 ) then 
			RadioSet = {"Miller_CommonHostageInformation","Miller_XofMarking"}
			Xof_MarkerOn()		
		end
		GetChicoTape()		
	elseif( setName == "RadioSet05b" ) then
		if ( result == 0 ) then 
			RadioSet = {"Miller_CommonHostageInformation","Miller_XofMarking"}
			Xof_MarkerOn()		
		end
	elseif( setName == "RadioSet06" ) then
		RadioSet = {"Miller_CommonHostageInformation","Miller_AboutDuct01"}
		GetChicoTape()		
		Duct_MarkerOn()		
	elseif( setName == "RadioSet02" ) then
		if ( result == 0 ) then 
			RadioSet = {"Miller_CommonHostageInformation","Miller_XofMarking"}
			Xof_MarkerOn()		
		end
	elseif( setName == "RadioSet03" ) then
		RadioSet = {"Miller_CommonHostageInformation","Miller_AboutDuct01"}
		Duct_MarkerOn()		
	elseif( setName == "RadioSet07" ) then
		GetChicoTape()		
		return
	else
		return
	end

	TppRadio.DelayPlayEnqueue( RadioSet, "mid" , nil , { onEnd = function() AnounceLog_MapUpdate() end }, nil )
end

local Common_NomalHostage01CarryStart = function()

	local status = TppHostageUtility.GetStatus( "Hostage_e20010_001" )

	if( status ~= "Dead" ) then
		TppRadio.Play("Miller_AtherHostageAdvice")
	else
	end
end

local Common_NomalHostage02CarryStart = function()

	local status = TppHostageUtility.GetStatus( "Hostage_e20010_002" )

	if( status ~= "Dead" ) then
		TppRadio.Play("Miller_AtherHostageAdvice")
	else
	end
end

local Common_NomalHostage03CarryStart = function()

	local status = TppHostageUtility.GetStatus( "Hostage_e20010_003" )

	if( status ~= "Dead" ) then
		TppRadio.Play("Miller_AtherHostageAdvice")
	else
	end
end

local Common_NomalHostage04CarryStart = function()

	local status = TppHostageUtility.GetStatus( "Hostage_e20010_004" )

	if( status ~= "Dead" ) then
		TppRadio.Play("Miller_AtherHostageAdvice")
	else
	end
end

local AsyInsideRouteChange_01 = function()
	TppMission.SetFlag( "isAsyInsideRouteChange_01", true )
end

local EastCampMoveTruck_Start = function()

	if( TppMission.GetFlag( "isSeq10_02_DriveEnd" ) == 1 ) then
		TppEnemy.EnableRoute( this.cpID , "S_Seq10_03_RideOnTruck" ) 	
		TppEnemy.DisableRoute( this.cpID , "S_Pre_TruckWaiting" )	
		TppEnemy.ChangeRoute( this.cpID , "Seq10_03","e20010_Seq10_SneakRouteSet","S_Seq10_03_RideOnTruck", 0 )	
	else
	end
end

local EastCampSouth_SL_RouteChange = function()
	TppEnemy.EnableRoute( this.cpID , "S_SL_EastCamp_South_in" ) 	
	TppEnemy.DisableRoute( this.cpID , "S_SL_EastCamp_South" )	
	TppEnemy.ChangeRoute( this.cpID , "ComEne33","e20010_Seq10_SneakRouteSet","S_SL_EastCamp_South_in", 0 )	
end

local GunTutorialEnemyRouteChange = function()

	TppEnemy.EnableRoute( this.cpID , "S_GunTutorial_Route" ) 			
	TppEnemy.DisableRoute( this.cpID , "S_Pre_GunTitorial_Waiting" )	
	TppEnemy.ChangeRoute( this.cpID , "ComEne08","e20010_Seq10_SneakRouteSet","S_GunTutorial_Route", 0 )	
end

local Talk_AsyWC = function()
	TppEnemy.EnableRoute( this.cpID , "S_RainTalk_ComEne05" ) 	
	TppEnemy.DisableRoute( this.cpID , "S_Pre_RainTalk_a" )	
	TppEnemy.ChangeRoute( this.cpID , "ComEne05","e20010_Seq10_SneakRouteSet","S_RainTalk_ComEne05", 0 )	
end

local Talk_ChicoTape = function()

	TppEnemy.EnableRoute( this.cpID , "S_Talk_ChicoTape" ) 		
	TppEnemy.DisableRoute( this.cpID , "S_Pre_ChikcoTapeTalk_a" )	
	TppEnemy.ChangeRoute( this.cpID , "Seq10_06","e20010_Seq10_SneakRouteSet","S_Talk_ChicoTape",0 )	
end

local Talk_EscapeHostage = function()

	TppEnemy.EnableRoute( this.cpID , "S_Talk_EscapeHostage" ) 	
	TppEnemy.DisableRoute( this.cpID , "S_Pre_EscapeHostageTalk_a" )	
	TppEnemy.ChangeRoute( this.cpID , "ComEne13","e20010_Seq10_SneakRouteSet","S_Talk_EscapeHostage",0 )	
end

local VehicleStart = function()

	if( TppMission.GetFlag( "isEscapeHostage" ) == false ) then
		TppEnemy.EnableRoute( this.cpID , "Seq10_02_RideOnVehicle" )			
		TppEnemy.DisableRoute( this.cpID , "S_Sen_EastCampCenter_East" ) 		
		TppEnemy.ChangeRoute( this.cpID , "Seq10_02","e20010_Seq10_SneakRouteSet","Seq10_02_RideOnVehicle", 0 )	
		TppMission.SetFlag( "isEscapeHostage", true )
	else
	end
end

local Center2F_EneRouteChange = function()

	local sequence = TppSequence.GetCurrentSequence()

	if ( sequence == "Seq_RescueHostages" ) then
		if( TppMission.GetFlag( "isCenter2F_EneRouteChange" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_Mov_Center_2Fto1F" ) 	
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_c" ) 	
			TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq10_SneakRouteSet","S_Mov_Center_2Fto1F", 0 )	
			TppMission.SetFlag( "isCenter2F_EneRouteChange", true )
		else
		end
	elseif ( sequence == "Seq_NextRescuePaz" ) then
		if( TppMission.GetFlag( "isCenter2F_EneRouteChange" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_Mov_Center_2Fto1F" ) 	
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_c" ) 	
			TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq20_SneakRouteSet","S_Mov_Center_2Fto1F", 0 )	
			TppMission.SetFlag( "isCenter2F_EneRouteChange", true )
		else
		end
	else
	end
end

























































































local SmokingRouteChange = function()

	local sequence = TppSequence.GetCurrentSequence()

	if ( sequence == "Seq_RescueHostages" ) then
		if( TppMission.GetFlag( "isSmokingRouteChange" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_Mov_Smoking_Center" ) 	
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_b" ) 	
			TppEnemy.ChangeRoute( this.cpID , "ComEne28","e20010_Seq10_SneakRouteSet","S_Mov_Smoking_Center", 0 )	
			TppMission.SetFlag( "isSmokingRouteChange", true )
		else
		end
	elseif ( sequence == "Seq_NextRescuePaz" ) then
		if( TppMission.GetFlag( "isSmokingRouteChange" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_Mov_Smoking_Center" ) 	
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_b" ) 	
			TppEnemy.ChangeRoute( this.cpID , "ComEne28","e20010_Seq20_SneakRouteSet","S_Mov_Smoking_Center", 0 )	
			TppMission.SetFlag( "isSmokingRouteChange", true )
		else
		end
	else
	end
end

local BoilarEnemyRouteChange = function()

	TppEnemy.EnableRoute( this.cpID , "S_GetOut_Boilar01" )
	TppEnemy.EnableRoute( this.cpID , "S_GetOut_Boilar02" )
	TppEnemy.DisableRoute( this.cpID , "S_WaitingInBoilar_01" )
	TppEnemy.DisableRoute( this.cpID , "S_WaitingInBoilar_02" )
	TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq20_SneakRouteSet","S_GetOut_Boilar01", 0 )
	TppEnemy.ChangeRoute( this.cpID , "ComEne32","e20010_Seq20_SneakRouteSet","S_GetOut_Boilar02", 0 )
end

local ComEne11_RouteChange = function()

	TppEnemy.EnableRoute( this.cpID , "S_Pat_EastCamp_North" )
	TppEnemy.DisableRoute( this.cpID , "S_Sen_EastCamp_NorthLeftGate" )
	TppEnemy.ChangeRoute( this.cpID , "ComEne11","e20010_Seq20_SneakRouteSet","S_Pat_EastCamp_North", 0 )
end

local GateOpenTruckRouteChange = function()
	TppEnemy.EnableRoute( this.cpID , "Seq20_02_RideOnTruck" ) 				
	TppEnemy.DisableRoute( this.cpID , "S_WaitingInTruck" ) 					
	TppEnemy.ChangeRoute( this.cpID , "Seq20_02","e20010_Seq20_SneakRouteSet","Seq20_02_RideOnTruck", 0 )	
end

local Seaside2manStartRouteChange = function()

	TppEnemy.EnableRoute( this.cpID , "S_Pat_SeaSide01a" ) 	
	TppEnemy.EnableRoute( this.cpID , "S_Pat_SeaSide02a" ) 	
	TppEnemy.DisableRoute( this.cpID , "S_Waiting_PC_AsyOut01" ) 	
	TppEnemy.DisableRoute( this.cpID , "S_Waiting_PC_AsyOut02" ) 	
	TppEnemy.ChangeRoute( this.cpID , "Seq20_03","e20010_Seq20_SneakRouteSet","S_Pat_SeaSide02a", 0 )	
	TppEnemy.ChangeRoute( this.cpID , "Seq20_04","e20010_Seq20_SneakRouteSet","S_Pat_SeaSide01a", 0 )	
end

local Seq20_05_RouteChange = function()
	TppEnemy.EnableRoute( this.cpID , "OutDoorFromWareHouse" ) 							
	TppEnemy.DisableRoute( this.cpID , "S_Waiting_Seq20_05" )							
	TppEnemy.ChangeRoute( this.cpID , "Seq20_05","e20010_Seq20_SneakRouteSet","OutDoorFromWareHouse",0 )	
end

local Talk_KillSpHostage01 = function()

	if ( TppMission.GetFlag( "isQuestionChico" ) == true )
		and ( TppMission.GetFlag( "isKillSpHostageEnemy01" ) == false ) then
		TppEnemy.EnableRoute( this.cpID , "Seq20_04_Talk_KillHostage" ) 					
		TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide01b" )							
		TppEnemy.ChangeRoute( this.cpID , "Seq20_04","e20010_Seq20_SneakRouteSet","Seq20_04_Talk_KillHostage",0 )	
		TppMission.SetFlag( "isKillSpHostageEnemy01", true )
	else
	end
end

local Seq30_PazCheck_Start = function()

	TppEnemy.DisableRoute( this.cpID , "S_Pre_PazCheck_Vip" )							
	TppEnemy.DisableRoute( this.cpID , "S_Pre_PazCheck" )							
	TppEnemy.EnableRoute( this.cpID , "GoTo_PazCheck_vip" )
	TppEnemy.EnableRoute( this.cpID , "GoTo_PazCheck" )
	TppEnemy.ChangeRoute( this.cpID , "Seq30_03","e20010_Seq30_SneakRouteSet","GoTo_PazCheck_vip", 0 )
	TppEnemy.ChangeRoute( this.cpID , "Seq30_04","e20010_Seq30_SneakRouteSet","GoTo_PazCheck", 0 )
	

end

local Seq30_PatrolVehicle_Start = function()
	TppMission.SetFlag( "isVehicle_Seq30_0506Start" , true )
	TppEnemy.EnableRoute( this.cpID , "Seq30_05_RideOnVehicle" )
	TppEnemy.DisableRoute( this.cpID , "S_Sen_AsylumOutSideGate_c" )
	TppEnemy.ChangeRoute( this.cpID , "Seq30_05","e20010_Seq30_SneakRouteSet","Seq30_05_RideOnVehicle", 0 )
end

local Common_NoTargetCagePicking = function()

	local chacterID = TppData.GetArgument( 1 )
	local status01 = TppHostageUtility.GetStatus( "Hostage_e20010_001" )
	local status02 = TppHostageUtility.GetStatus( "Hostage_e20010_002" )
	local status03 = TppHostageUtility.GetStatus( "Hostage_e20010_003" )
	local status04 = TppHostageUtility.GetStatus( "Hostage_e20010_004" )

	if chacterID == "AsyPickingDoor22" then
		if( status01 ~= "Dead" ) then
			TppRadio.Play("Miller_AtherCagePicking")
		else
		end
	elseif chacterID == "AsyPickingDoor21" then
		if( status02 ~= "Dead" ) then
			TppRadio.Play("Miller_AtherCagePicking")
		else
		end
	elseif chacterID == "AsyPickingDoor15" then
		if( status03 ~= "Dead" ) then
			TppRadio.Play("Miller_AtherCagePicking")
			TppHostageManager.GsSetStruggleFlag( "Hostage_e20010_003" , false )
		else
		end
	elseif chacterID == "AsyPickingDoor05" then
		if( status04 ~= "Dead" ) then
			TppRadio.Play("Miller_AtherCagePicking")
			TppHostageManager.GsSetStruggleFlag( "Hostage_e20010_004" , false )
		else
		end
	end
end


this.flagchk_LookInTutorialStart = 2  
this.flagchk_LookInTutorialEnd	 = 4  
this.flagchk_CoverTutorialPre	 = 5  
this.flagchk_CoverTutorialStart  = 6  
this.flagchk_CoverTutorialEnd	 = 7  
local Common_behind = function()

	
	if( TppMission.GetFlag( "isDoCarryAdvice" ) == true ) then

		
		if( TppMission.GetFlag( "isSaftyArea02" ) == false ) then
	
	
	

			if( TppMission.GetFlag( "isBehindTutorial" ) == 0 ) then
				TppMission.SetFlag( "isBehindTutorial", this.flagchk_LookInTutorialStart )
			
				local timer = 2
				GkEventTimerManager.Start( "Timer_Behind", timer )

			elseif( TppMission.GetFlag( "isBehindTutorial" ) == this.flagchk_LookInTutorialStart ) then

				local phase = TppEnemy.GetPhase( this.cpID )
				if ( phase == "alert" or phase == "evasion" ) then
				else
					TppRadio.PlayEnqueue( "Miller_CoverTutorial", {
						onStart = function() e20010_require_01.Tutorial_1Button("tutorial_look_in","PL_STOCK")
						TppMission.SetFlag( "isBehindTutorial", this.flagchk_LookInTutorialEnd )
						GkEventTimerManager.Stop( "Timer_Behind" )
						local timer = 2
						GkEventTimerManager.Start( "Timer_Behind", timer )
					end })
				end
			elseif( TppMission.GetFlag( "isBehindTutorial" ) == this.flagchk_LookInTutorialEnd ) then
				GkEventTimerManager.Stop( "Timer_Behind" )
				local timer = 2
				GkEventTimerManager.Start( "Timer_Behind", timer )

			elseif( TppMission.GetFlag( "isBehindTutorial" ) == this.flagchk_CoverTutorialPre ) then
				local timer = 2
				GkEventTimerManager.Start( "Timer_Behind", timer )
				TppMission.SetFlag( "isBehindTutorial", this.flagchk_CoverTutorialStart )

			elseif( TppMission.GetFlag( "isBehindTutorial" ) == this.flagchk_CoverTutorialStart ) then
				GkEventTimerManager.Stop( "Timer_Behind" )
				e20010_require_01.Tutorial_2Button( "tutorial_cover_attack", "PL_HOLD", "PL_SHOT" )
				TppMission.SetFlag( "isBehindTutorial", this.flagchk_CoverTutorialEnd )
			end
		end
	end

end

local TimerBehindCount = function()
	if( TppMission.GetFlag( "isBehindTutorial" ) == this.flagchk_LookInTutorialStart ) then
		TppMission.SetFlag( "isBehindTutorial", 0 )
	elseif( TppMission.GetFlag( "isBehindTutorial" ) == this.flagchk_LookInTutorialEnd) then
		TppMission.SetFlag( "isBehindTutorial", this.flagchk_CoverTutorialPre )
	elseif( TppMission.GetFlag( "isBehindTutorial" ) == this.flagchk_CoverTutorialStart ) then
		TppMission.SetFlag( "isBehindTutorial", this.flagchk_CoverTutorialPre )
	end
end

local Timer_SwitchOFF = function()
	TppDataUtility.SetEnableDataFromIdentifier( "gntn_Trap", "SwitchLightArea", true , false )
end
local Timer_takePazToRVPoint01_OnEnd = function()
	local sequence = TppSequence.GetCurrentSequence()
	if ( sequence == "Seq_NextRescueChico" ) then
		TppRadio.DelayPlay("Miller_takePazToRVPoint01", "mid")
	elseif ( sequence == "Seq_ChicoPazToRV" ) then
		TppRadio.DelayPlay("Miller_takePazOnHeli", "mid")
	else
	end
end

local Common_enemyIntel = function(id)

	local radioDaemon = RadioDaemon:GetInstance()
	local status = TppEnemyUtility.GetStatus( id )			
	local aiStatus = TppEnemyUtility.GetAiStatus( id )		
	local lifeStatus = TppEnemyUtility.GetLifeStatus( id )	
	local routeId = TppEnemyUtility.GetRouteId( id )		
	local phase = TppEnemy.GetPhase( this.cpID )			





	
	local espRadioPlay = function()
		local radioDaemon = RadioDaemon:GetInstance()
		if ( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0660") == false ) then	
			if( TppMission.GetFlag( "isEncounterChico" ) == false and TppMission.GetFlag( "isEncounterPaz" ) == false ) then
				TppRadio.DelayPlayEnqueue( "Miller_EspionageRadioAdvice", "short" )					
			end
		elseif( TppMission.GetFlag( "isDoCarryAdvice" ) == true ) then			
			if( lifeStatus == "Dead" ) then
			else
				if( TppMission.GetFlag( "isEncounterChico" ) == false and TppMission.GetFlag( "isEncounterPaz" ) == false ) then
					TppRadio.DelayPlayEnqueue("Miller_MarkingTutorial", "short" )
				end
			end
		end
	end

	if lifeStatus == "Normal" and (status == "HoldUp") == false then
		if	(routeId == GsRoute.GetRouteId("S_Sen_AsylumOutSideGate_a")
			or routeId == GsRoute.GetRouteId("S_Sen_AsylumOutSideGate_b") )
			and ( phase == "neutral" or phase == "sneak" ) then
			
			TppRadio.RegisterIntelRadio( id, "e0010_esrg0370", true )	
			espRadioPlay()										

		elseif (routeId == GsRoute.GetRouteId("S_Pat_AsylumInside_Ver01")
			or routeId == GsRoute.GetRouteId("S_Pat_AsylumInside_Ver02")
			or routeId == GsRoute.GetRouteId("S_Pat_AsylumInside_Ver03"))
			and ( phase == "neutral" or phase == "sneak" ) then
			
			TppRadio.RegisterIntelRadio( id, "e0010_esrg0360", true )	
			espRadioPlay()										

		elseif aiStatus == "Conversation" then
			



			TppRadio.RegisterIntelRadio( id, "e0010_esrg0310", true )	

			
			if ( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0660") == false ) then
				if( TppMission.GetFlag( "isEncounterChico" ) == false and TppMission.GetFlag( "isEncounterPaz" ) == false ) then
					TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" )
				end
			else
			
			end

		else
			



			TppRadio.RegisterIntelRadio( id, "e0010_esrg0170", true )	
			espRadioPlay()										
		end
	else	
			TppRadio.RegisterIntelRadio( id, "e0010_esrg0171", true )	
			espRadioPlay()										
	end
end

local Common_Gimmick_Break = function()

	local gimmick	= TppData.GetArgument( 1 )			

	
	if ( gimmick == "WoodTurret01" ) then
		TppMission.SetFlag( "isWoodTurret01_Break", true )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "WoodTurret_RainFilter01", false , false )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret01_Route" , "S_SL_StartCliff" )
	
	elseif ( gimmick == "SL_WoodTurret01" ) then
		TppMission.SetFlag( "isWoodTurret01_Break", true )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret01_Route" , "S_SL_StartCliff" )
	
	elseif ( gimmick == "WoodTurret02" ) then
		TppMission.SetFlag( "isWoodTurret02_Break", true )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "WoodTurret_RainFilter03", false , false )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret02_Route" , "S_SL_EastCamp_South" )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret02_Route" , "S_SL_EastCamp_South_in" )
	
	elseif ( gimmick == "SL_WoodTurret02" ) then
		TppMission.SetFlag( "isWoodTurret02_Break", true )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret02_Route" , "S_SL_EastCamp_South" )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret02_Route" , "S_SL_EastCamp_South_in" )
	
	elseif ( gimmick == "WoodTurret03" ) then
		TppMission.SetFlag( "isWoodTurret03_Break", true )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "WoodTurret_RainFilter04", false , false )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret03_Route" , "S_SL_EastCamp_North" )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret03_Route" , "S_Pre_RainTalk_b" )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret03_Route" , "S_GoTo_EastCampNorthTower" )
	
	elseif ( gimmick == "SL_WoodTurret03" ) then
		TppMission.SetFlag( "isWoodTurret03_Break", true )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret03_Route" , "S_SL_EastCamp_North" )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret03_Route" , "S_Pre_RainTalk_b" )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret03_Route" , "S_GoTo_EastCampNorthTower" )
	
	elseif ( gimmick == "WoodTurret04" ) then
		TppMission.SetFlag( "isWoodTurret04_Break", true )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "WoodTurret_RainFilter02", false , false )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret04_Route" , "S_SL_WestCamp" )
	
	elseif ( gimmick == "SL_WoodTurret04" ) then
		TppMission.SetFlag( "isWoodTurret04_Break", true )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret04_Route" , "S_SL_WestCamp" )
	
	elseif ( gimmick == "WoodTurret05" ) then
		TppMission.SetFlag( "isWoodTurret05_Break", true )
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "WoodTurret_RainFilter05", false , false )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret05_Route" , "S_SL_Asylum" )
	
	elseif ( gimmick == "SL_WoodTurret05" ) then
		TppMission.SetFlag( "isWoodTurret05_Break", true )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_WoodTurret05_Route" , "S_SL_Asylum" )
	
	elseif ( gimmick == "gntn_area01_searchLight_001" ) then
		TppMission.SetFlag( "isIronTurretSL01_Break", true )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_IronTurretSL01_Route" , "S_SL_WareHouse01a" )
	
	elseif ( gimmick == "gntn_area01_searchLight_002" ) then
		TppMission.SetFlag( "isIronTurretSL02_Break", true )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_IronTurretSL02_Route" , "S_SL_WareHouse02a" )
	
	elseif ( gimmick == "gntn_area01_searchLight_004" ) then
		TppMission.SetFlag( "isIronTurretSL04_Break", true )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_IronTurretSL04_Route" , "S_SL_HeliPortTurret02" )
	
	elseif ( gimmick == "gntn_area01_searchLight_005" ) then
		TppMission.SetFlag( "isIronTurretSL05_Break", true )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_IronTurretSL05_Route" , "S_SL_HeliPortTurret01" )
	
	elseif ( gimmick == "gntn_area01_searchLight_006" ) then
		TppMission.SetFlag( "isCenterTowerSL_Break", true )
		TppCommandPostObject.GsSetExclusionRoutes( this.cpID , "Break_CenterTower_Route" , "S_SL_HeliPortTower" )
	end
end

local Common_AAG01_Break = function()
	if( TppMission.GetFlag( "isPlayerOnHeli" ) == false ) then
		TppRadio.DelayPlayEnqueue("Miller_BreakAAG", "mid")
	end
end

local Common_AAG02_Break = function()
	if( TppMission.GetFlag( "isPlayerOnHeli" ) == false ) then
		TppRadio.DelayPlayEnqueue("Miller_BreakAAG", "mid")
	end
end

local Common_AAG03_Break = function()
	if( TppMission.GetFlag( "isPlayerOnHeli" ) == false ) then
		TppRadio.DelayPlayEnqueue("Miller_BreakAAG", "mid")
	end
end

local Common_AAG04_Break = function()
	if( TppMission.GetFlag( "isPlayerOnHeli" ) == false ) then
		TppRadio.DelayPlayEnqueue("Miller_BreakAAG", "mid")
	end
end





local FirstChico_Vehicle_01 = function()

	local timer = 1

	
	TppData.Enable( "Cargo_Truck_WEST_004" )		
	TppData.Enable( "Armored_Vehicle_WEST_001" )	
	
	GkEventTimerManager.Start( "Timer_Weapon_Truck_Clean", timer )
	TppData.Enable( "Cargo_Truck_WEST_002" )		
	
	if( TppMission.GetFlag( "isSeq10_02_DriveEnd" ) == 2 ) then	
		GkEventTimerManager.Start( "Timer_SC_Vehicle_Clean", timer )
	else
		TppMarkerSystem.DisableMarker{ markerId = "Tactical_Vehicle_WEST_002" }
		TppData.Disable("Tactical_Vehicle_WEST_002")
	end
	if( TppMission.GetFlag( "isSeq10_03_DriveEnd" ) == 2 ) then	
		GkEventTimerManager.Start( "Timer_EC_Truck_Clean", timer )
	else
		TppMarkerSystem.DisableMarker{ markerId = "Cargo_Truck_WEST_003" }
		TppData.Disable("Cargo_Truck_WEST_003")
	end
	
	TppMarkerSystem.DisableMarker{ markerId = "Tactical_Vehicle_WEST_003" }
	TppData.Disable( "Tactical_Vehicle_WEST_003" )	
	TppMarkerSystem.DisableMarker{ markerId = "Tactical_Vehicle_WEST_004" }
	TppData.Disable( "Tactical_Vehicle_WEST_004" )	
	TppMarkerSystem.DisableMarker{ markerId = "Armored_Vehicle_WEST_003" }
	TppData.Disable( "Armored_Vehicle_WEST_003" )	
	
	TppMarkerSystem.DisableMarker{ markerId = "Armored_Vehicle_WEST_002" }
	TppData.Disable( "Armored_Vehicle_WEST_002" )	
	TppMarkerSystem.DisableMarker{ markerId = "Tactical_Vehicle_WEST_005" }
	TppData.Disable( "Tactical_Vehicle_WEST_005" )	
end

local FirstChico_Vehicle_02 = function()

	local timer = 1

	
	GkEventTimerManager.Start( "Timer_Gate_Truck_Clean", timer )
	TppData.Enable( "Cargo_Truck_WEST_004" )		
	TppData.Enable( "Armored_Vehicle_WEST_001" )	
	TppData.Enable( "Armored_Vehicle_WEST_003" )	
	
	TppData.Enable( "Cargo_Truck_WEST_002" )		
	
	if( TppMission.GetFlag( "isSeq10_02_DriveEnd" ) == 2 ) then	
		TppEnemyUtility.SetEnableCharacterId( "Seq30_05" , false )
	else
		TppMarkerSystem.DisableMarker{ markerId = "Tactical_Vehicle_WEST_002" }
		TppData.Disable("Tactical_Vehicle_WEST_002")
		GkEventTimerManager.Start( "Timer_Patrol_Vehicle_Clean", timer )
		TppData.Enable( "Tactical_Vehicle_WEST_003" )			
	end
	if( TppMission.GetFlag( "isSeq10_03_DriveEnd" ) == 2 ) then	
	else
		TppMarkerSystem.DisableMarker{ markerId = "Cargo_Truck_WEST_003" }
		TppData.Disable("Cargo_Truck_WEST_003")
		TppData.Enable( "Tactical_Vehicle_WEST_004" )			
	end
	
	TppMarkerSystem.DisableMarker{ markerId = "Armored_Vehicle_WEST_002" }
	TppData.Disable( "Armored_Vehicle_WEST_002" )	
	TppMarkerSystem.DisableMarker{ markerId = "Tactical_Vehicle_WEST_005" }
	TppData.Disable( "Tactical_Vehicle_WEST_005" )	
end

local FirstPaz_Vehicle = function()

	local timer = 1

	
	GkEventTimerManager.Start( "Timer_ToAsylum_Vehicle_Clean", timer )
	TppData.Enable( "Tactical_Vehicle_WEST_005" )	
	TppData.Enable( "Armored_Vehicle_WEST_002" )	
	TppData.Enable( "Armored_Vehicle_WEST_001" )	
	
	GkEventTimerManager.Start( "Timer_Weapon_Truck_Clean", timer )
	TppData.Enable( "Cargo_Truck_WEST_002" )		
	
	if( TppMission.GetFlag( "isSeq10_02_DriveEnd" ) == 2 ) then	
		GkEventTimerManager.Start( "Timer_SC_Vehicle_Clean", timer )
	else
		TppMarkerSystem.DisableMarker{ markerId = "Tactical_Vehicle_WEST_002" }
		TppData.Disable("Tactical_Vehicle_WEST_002")
	end
	if( TppMission.GetFlag( "isSeq10_03_DriveEnd" ) == 2 ) then	
		GkEventTimerManager.Start( "Timer_EC_Truck_Clean", timer )
	else
		TppMarkerSystem.DisableMarker{ markerId = "Cargo_Truck_WEST_003" }
		TppData.Disable("Cargo_Truck_WEST_003")
	end
	
	TppMarkerSystem.DisableMarker{ markerId = "Tactical_Vehicle_WEST_003" }
	TppData.Disable( "Tactical_Vehicle_WEST_003" )	
	TppMarkerSystem.DisableMarker{ markerId = "Tactical_Vehicle_WEST_004" }
	TppData.Disable( "Tactical_Vehicle_WEST_004" )	
	TppMarkerSystem.DisableMarker{ markerId = "Armored_Vehicle_WEST_003" }
	TppData.Disable( "Armored_Vehicle_WEST_003" )	
	TppMarkerSystem.DisableMarker{ markerId = "Cargo_Truck_WEST_004" }
	TppData.Disable( "Cargo_Truck_WEST_004" )		
end



local ChicoPazQustionDemoAfterReStart = function()
	local sequence = TppSequence.GetCurrentSequence()
	
	if( TppMission.GetFlag( "isSaftyArea01" ) == true ) then
		TppMissionManager.SaveGame("40")		







	else
		
	end
end




local ChicoDoor_OFF = function()
	TppGadgetUtility.SetDoor{ id = "AsyPickingDoor24", isVisible = false, isEnableBounder = true, isEnableTacticalActionEdge = false , angle = 0, isOpen = false }
end

local ChicoDoor_ON_Open = function()
	TppGadgetUtility.SetDoor{ id = "AsyPickingDoor24", isVisible = true, isEnableBounder = true, isEnableTacticalActionEdge = true , angle = 270, isOpen = true }
end

local ChicoDoor_ON_Close = function()
	TppGadgetUtility.SetDoor{ id = "AsyPickingDoor24", isVisible = true, isEnableBounder = true, isEnableTacticalActionEdge = false , angle = 0, isOpen = false }
end




local PazDoor_OFF = function()
	TppGadgetUtility.SetDoor{ id = "Paz_PickingDoor00", isVisible = false, isEnableBounder = true, isEnableTacticalActionEdge = false , angle = 0, isOpen = false }
end

local PazDoor_ON_Open = function()
	TppGadgetUtility.SetDoor{ id = "Paz_PickingDoor00", isVisible = true, isEnableBounder = true, isEnableTacticalActionEdge = true , angle = 270, isOpen = true }
end

local PazDoor_ON_Close = function()
	TppGadgetUtility.SetDoor{ id = "Paz_PickingDoor00", isVisible = true, isEnableBounder = true, isEnableTacticalActionEdge = false , angle = 0, isOpen = false }
end



local After_SwitchOff = function()

	local sequence = TppSequence.GetCurrentSequence()

	GkEventTimerManager.Start( "Timer_SwitchOFF", 0.75 )
	
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20010_SecurityCamera_02", false )
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20010_SecurityCamera_03", false )
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20010_SecurityCamera_04", false )
	
	if ( sequence == "Seq_RescueHostages" ) then				
		



		TppEnemy.EnableRoute( this.cpID , "ComEne25_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_d" )
		TppEnemy.DisableRoute( this.cpID , "S_Mov_Center_d" )
		TppEnemy.DisableRoute( this.cpID , "S_Ret_Center_d" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne256","e20010_Seq10_SneakRouteSet","ComEne25_SwitchOFF", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne26_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_a" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne26","e20010_Seq10_SneakRouteSet","ComEne26_SwitchOFF", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne27_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_BoilarFront" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne27","e20010_Seq10_SneakRouteSet","ComEne27_SwitchOFF", 0 )
		
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "SmokingRouteChange", false , false )
		TppEnemy.EnableRoute( this.cpID , "ComEne28_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_b" )
		TppEnemy.DisableRoute( this.cpID , "S_Mov_Smoking_Center" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne28","e20010_Seq10_SneakRouteSet","ComEne28_SwitchOFF", 0 )
		
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Center2F_EneRouteChange", false , false )
		TppEnemy.EnableRoute( this.cpID , "ComEne29_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_c" )
		TppEnemy.DisableRoute( this.cpID , "S_Mov_Center_2Fto1F" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq10_SneakRouteSet","ComEne29_SwitchOFF", 0 )
	elseif ( sequence == "Seq_NextRescuePaz" ) then				
		
		TppEnemy.EnableRoute( this.cpID , "ComEne25_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_d" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne256","e20010_Seq20_SneakRouteSet","ComEne25_SwitchOFF", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne26_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_a" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne26","e20010_Seq20_SneakRouteSet","ComEne26_SwitchOFF", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne27_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_BoilarFront" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne27","e20010_Seq20_SneakRouteSet","ComEne27_SwitchOFF", 0 )
		
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "SmokingRouteChange", false , false )
		TppEnemy.EnableRoute( this.cpID , "ComEne28_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_b" )
		TppEnemy.DisableRoute( this.cpID , "S_Mov_Smoking_Center" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne28","e20010_Seq20_SneakRouteSet","ComEne28_SwitchOFF", 0 )
		
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Center2F_EneRouteChange", false , false )
		TppEnemy.EnableRoute( this.cpID , "ComEne29_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_c" )
		TppEnemy.DisableRoute( this.cpID , "S_Mov_Center_2Fto1F" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq20_SneakRouteSet","ComEne29_SwitchOFF", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne31_SwitchOFF_v3" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_f" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq20_SneakRouteSet","ComEne31_SwitchOFF_v3",0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne31_SwitchOFF_v2" )
		TppEnemy.DisableRoute( this.cpID , "S_TalkingDelatetape_After02" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne32","e20010_Seq20_SneakRouteSet","ComEne31_SwitchOFF_v2",0 )
	elseif ( sequence == "Seq_NextRescueChico" ) or ( sequence == "Seq_PazChicoToRV" ) then		
		
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ComEne24_RouteChange", false , false )
		TppEnemy.EnableRoute( this.cpID , "ComEne24_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_HeliPortBigGate" )
		TppEnemy.DisableRoute( this.cpID , "GoToCenterB_2F_02" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterB_2F" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne24","e20010_Seq40_SneakRouteSet","ComEne24_SwitchOFF", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne25_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_d" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne25","e20010_Seq40_SneakRouteSet","ComEne25_SwitchOFF", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne26_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_a" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne26","e20010_Seq40_SneakRouteSet","ComEne26_SwitchOFF", 0 )
		
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq40_ComEne27_RouteChange", false , false )
		TppEnemy.EnableRoute( this.cpID , "ComEne27_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterBack" )
		TppEnemy.DisableRoute( this.cpID , "S_GoTo_BoilarFront" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_BoilarFront" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne27","e20010_Seq40_SneakRouteSet","ComEne27_SwitchOFF", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne28_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Mov_Smoking_Center" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne28","e20010_Seq40_SneakRouteSet","ComEne28_SwitchOFF", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne29_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_e" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq40_SneakRouteSet","ComEne29_SwitchOFF", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne31_SwitchOFF_v2" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_Middle2" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq40_SneakRouteSet","ComEne31_SwitchOFF_v2", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne32_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_Middle" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne32","e20010_Seq40_SneakRouteSet","ComEne32_SwitchOFF", 0 )
	elseif ( sequence == "Seq_ChicoPazToRV" ) then				
		
		TppEnemy.EnableRoute( this.cpID , "ComEne25_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_d" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne256","e20010_Seq30_SneakRouteSet","ComEne25_SwitchOFF", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne26_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_a" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne26","e20010_Seq30_SneakRouteSet","ComEne26_SwitchOFF", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne27_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_BoilarFront" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne27","e20010_Seq30_SneakRouteSet","ComEne27_SwitchOFF", 0 )
		
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "SmokingRouteChange", false , false )
		TppEnemy.EnableRoute( this.cpID , "ComEne28_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_b" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne28","e20010_Seq30_SneakRouteSet","ComEne28_SwitchOFF", 0 )
		
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Center2F_EneRouteChange", false , false )
		TppEnemy.EnableRoute( this.cpID , "ComEne29_SwitchOFF" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_e" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq30_SneakRouteSet","ComEne29_SwitchOFF", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "ComEne31_SwitchOFF_v3" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_f" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq30_SneakRouteSet","ComEne31_SwitchOFF_v3",0 )
	else
		if( TppMission.GetFlag( "isFirstEncount_Chico" ) == true ) then		
			
			TppEnemy.EnableRoute( this.cpID , "ComEne25_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_d" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne256","e20010_Seq30_SneakRouteSet","ComEne25_SwitchOFF", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "ComEne26_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_a" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne26","e20010_Seq30_SneakRouteSet","ComEne26_SwitchOFF", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "ComEne27_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_BoilarFront" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne27","e20010_Seq30_SneakRouteSet","ComEne27_SwitchOFF", 0 )
			
			TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "SmokingRouteChange", false , false )
			TppEnemy.EnableRoute( this.cpID , "ComEne28_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_b" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne28","e20010_Seq30_SneakRouteSet","ComEne28_SwitchOFF", 0 )
			
			TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Center2F_EneRouteChange", false , false )
			TppEnemy.EnableRoute( this.cpID , "ComEne29_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_e" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq30_SneakRouteSet","ComEne29_SwitchOFF", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "ComEne31_SwitchOFF_v3" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_f" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq30_SneakRouteSet","ComEne31_SwitchOFF_v3",0 )
		else	
			
			TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ComEne24_RouteChange", false , false )
			TppEnemy.EnableRoute( this.cpID , "ComEne24_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_HeliPortBigGate" )
			TppEnemy.DisableRoute( this.cpID , "GoToCenterB_2F_02" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterB_2F" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne24","e20010_Seq40_SneakRouteSet","ComEne24_SwitchOFF", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "ComEne25_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_d" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne25","e20010_Seq40_SneakRouteSet","ComEne25_SwitchOFF", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "ComEne26_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_a" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne26","e20010_Seq40_SneakRouteSet","ComEne26_SwitchOFF", 0 )
			
			TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq40_ComEne27_RouteChange", false , false )
			TppEnemy.EnableRoute( this.cpID , "ComEne27_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterBack" )
			TppEnemy.DisableRoute( this.cpID , "S_GoTo_BoilarFront" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_BoilarFront" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne27","e20010_Seq40_SneakRouteSet","ComEne27_SwitchOFF", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "ComEne28_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "S_Mov_Smoking_Center" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne28","e20010_Seq40_SneakRouteSet","ComEne28_SwitchOFF", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "ComEne29_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_e" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq40_SneakRouteSet","ComEne29_SwitchOFF", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "ComEne31_SwitchOFF_v2" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_Middle2" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq40_SneakRouteSet","ComEne31_SwitchOFF_v2", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "ComEne32_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_Middle" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne32","e20010_Seq40_SneakRouteSet","ComEne32_SwitchOFF", 0 )
		end
	end
end




local SwitchLight_ON = function()

	local sequence = TppSequence.GetCurrentSequence()

	
	TppDataUtility.SetEnableDataFromIdentifier( "gntn_Trap", "SwitchLightArea", false , false )
	
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20010_SecurityCamera_02", true )
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20010_SecurityCamera_03", true )
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20010_SecurityCamera_04", true )
	
	if ( sequence == "Seq_RescueHostages" ) then				
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_d" )
		TppEnemy.DisableRoute( this.cpID , "ComEne25_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne25","e20010_Seq10_SneakRouteSet","S_Sen_Center_d", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_a" )
		TppEnemy.DisableRoute( this.cpID , "ComEne26_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne26","e20010_Seq10_SneakRouteSet","S_Sen_Center_a", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_BoilarFront" )
		TppEnemy.DisableRoute( this.cpID , "ComEne27_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne27","e20010_Seq10_SneakRouteSet","S_Sen_BoilarFront", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Mov_Smoking_Center" )
		TppEnemy.DisableRoute( this.cpID , "ComEne28_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne28","e20010_Seq10_SneakRouteSet","S_Mov_Smoking_Center", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_e" )
		TppEnemy.DisableRoute( this.cpID , "ComEne29_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq10_SneakRouteSet","S_Sen_Center_e", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_b" )
		TppEnemy.DisableRoute( this.cpID , "ComEne31_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq10_SneakRouteSet","S_Sen_Boilar_b",0 )
	elseif ( sequence == "Seq_NextRescuePaz" ) then				
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_d" )
		TppEnemy.DisableRoute( this.cpID , "ComEne25_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne25","e20010_Seq20_SneakRouteSet","S_Sen_Center_d", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_a" )
		TppEnemy.DisableRoute( this.cpID , "ComEne26_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne26","e20010_Seq20_SneakRouteSet","S_Sen_Center_a", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_BoilarFront" )
		TppEnemy.DisableRoute( this.cpID , "ComEne27_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne27","e20010_Seq20_SneakRouteSet","S_Sen_BoilarFront", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Mov_Smoking_Center" )
		TppEnemy.DisableRoute( this.cpID , "ComEne28_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne28","e20010_Seq20_SneakRouteSet","S_Mov_Smoking_Center", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_e" )
		TppEnemy.DisableRoute( this.cpID , "ComEne29_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq20_SneakRouteSet","S_Sen_Center_e", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_f" )
		TppEnemy.DisableRoute( this.cpID , "ComEne31_SwitchOFF_v3" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq20_SneakRouteSet","S_Sen_Center_f",0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_TalkingDelatetape_After02" )
		TppEnemy.DisableRoute( this.cpID , "ComEne31_SwitchOFF_v2" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne32","e20010_Seq20_SneakRouteSet","S_TalkingDelatetape_After02",0 )
	elseif ( sequence == "Seq_NextRescueChico" ) or ( sequence == "Seq_PazChicoToRV" ) then			
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_CenterB_2F" )
		TppEnemy.DisableRoute( this.cpID , "ComEne24_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne24","e20010_Seq40_SneakRouteSet","S_Sen_CenterB_2F",0 )	
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_d" )
		TppEnemy.DisableRoute( this.cpID , "ComEne25_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne24","e20010_Seq40_SneakRouteSet","S_Sen_Center_d",0 )	
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_a" )
		TppEnemy.DisableRoute( this.cpID , "ComEne26_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne26","e20010_Seq40_SneakRouteSet","S_Sen_Center_a",0 )	
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_BoilarFront" )
		TppEnemy.DisableRoute( this.cpID , "ComEne27_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne27","e20010_Seq40_SneakRouteSet","S_Sen_BoilarFront",0 )	
		
		TppEnemy.EnableRoute( this.cpID , "S_Mov_Smoking_Center" )
		TppEnemy.DisableRoute( this.cpID , "ComEne28_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne28","e20010_Seq40_SneakRouteSet","S_Mov_Smoking_Center", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_e" )
		TppEnemy.DisableRoute( this.cpID , "ComEne29_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq40_SneakRouteSet","S_Sen_Center_e", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_Middle2" )
		TppEnemy.DisableRoute( this.cpID , "ComEne31_SwitchOFF_v2" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq40_SneakRouteSet","S_Sen_Boilar_Middle2", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_Middle" )
		TppEnemy.DisableRoute( this.cpID , "ComEne32_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne32","e20010_Seq40_SneakRouteSet","S_Sen_Boilar_Middle", 0 )
	elseif ( sequence == "Seq_ChicoPazToRV" ) then				
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_d" )
		TppEnemy.DisableRoute( this.cpID , "ComEne25_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne256","e20010_Seq30_SneakRouteSet","S_Sen_Center_d", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_a" )
		TppEnemy.DisableRoute( this.cpID , "ComEne26_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne26","e20010_Seq30_SneakRouteSet","S_Sen_Center_a", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_BoilarFront" )
		TppEnemy.DisableRoute( this.cpID , "ComEne27_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne27","e20010_Seq30_SneakRouteSet","S_Sen_BoilarFront", 0 )
		
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "SmokingRouteChange", false , false )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_b" )
		TppEnemy.DisableRoute( this.cpID , "ComEne28_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne28","e20010_Seq30_SneakRouteSet","S_Sen_Center_b", 0 )
		
		TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Center2F_EneRouteChange", false , false )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_e" )
		TppEnemy.DisableRoute( this.cpID , "ComEne29_SwitchOFF" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq30_SneakRouteSet","S_Sen_Center_e", 0 )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_f" )
		TppEnemy.DisableRoute( this.cpID , "ComEne31_SwitchOFF_v3" )
		TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq30_SneakRouteSet","S_Sen_Center_f",0 )
	else
		if( TppMission.GetFlag( "isFirstEncount_Chico" ) == true ) then		
			
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_d" )
			TppEnemy.DisableRoute( this.cpID , "ComEne25_SwitchOFF" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne256","e20010_Seq30_SneakRouteSet","S_Sen_Center_d", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_a" )
			TppEnemy.DisableRoute( this.cpID , "ComEne26_SwitchOFF" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne26","e20010_Seq30_SneakRouteSet","S_Sen_Center_a", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "S_Sen_BoilarFront" )
			TppEnemy.DisableRoute( this.cpID , "ComEne27_SwitchOFF" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne27","e20010_Seq30_SneakRouteSet","S_Sen_BoilarFront", 0 )
			
			TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "SmokingRouteChange", false , false )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_b" )
			TppEnemy.DisableRoute( this.cpID , "ComEne28_SwitchOFF" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne28","e20010_Seq30_SneakRouteSet","S_Sen_Center_b", 0 )
			
			TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Center2F_EneRouteChange", false , false )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_e" )
			TppEnemy.DisableRoute( this.cpID , "ComEne29_SwitchOFF" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq30_SneakRouteSet","S_Sen_Center_e", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_f" )
			TppEnemy.DisableRoute( this.cpID , "ComEne31_SwitchOFF_v3" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq30_SneakRouteSet","S_Sen_Center_f",0 )
		else	
			
			TppEnemy.EnableRoute( this.cpID , "S_Sen_CenterB_2F" )
			TppEnemy.DisableRoute( this.cpID , "ComEne24_SwitchOFF" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne24","e20010_Seq40_SneakRouteSet","S_Sen_CenterB_2F",0 )	
			
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_d" )
			TppEnemy.DisableRoute( this.cpID , "ComEne25_SwitchOFF" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne24","e20010_Seq40_SneakRouteSet","S_Sen_Center_d",0 )	
			
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_a" )
			TppEnemy.DisableRoute( this.cpID , "ComEne26_SwitchOFF" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne26","e20010_Seq40_SneakRouteSet","S_Sen_Center_a",0 )	
			
			TppEnemy.EnableRoute( this.cpID , "S_Sen_BoilarFront" )
			TppEnemy.DisableRoute( this.cpID , "ComEne27_SwitchOFF" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne27","e20010_Seq40_SneakRouteSet","S_Sen_BoilarFront",0 )	
			
			TppEnemy.EnableRoute( this.cpID , "S_Mov_Smoking_Center" )
			TppEnemy.DisableRoute( this.cpID , "ComEne28_SwitchOFF" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne28","e20010_Seq40_SneakRouteSet","S_Mov_Smoking_Center", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_e" )
			TppEnemy.DisableRoute( this.cpID , "ComEne29_SwitchOFF" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq40_SneakRouteSet","S_Sen_Center_e", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_Middle2" )
			TppEnemy.DisableRoute( this.cpID , "ComEne31_SwitchOFF_v2" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq40_SneakRouteSet","S_Sen_Boilar_Middle2", 0 )
			
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_Middle" )
			TppEnemy.DisableRoute( this.cpID , "ComEne32_SwitchOFF" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne32","e20010_Seq40_SneakRouteSet","S_Sen_Boilar_Middle", 0 )
		end
	end
end

local SwitchLight_OFF = function()

	local phase = TppEnemy.GetPhase( this.cpID )

	
	if( TppMission.GetFlag( "isSwitchLightDemo" ) == false )
		and ( phase == "sneak" or phase == "caution" or phase == "evasion" ) then

		local onDemoStart = function()
			
			local radioDaemon = RadioDaemon:GetInstance()
			radioDaemon:StopDirect()
			
			SubtitlesCommand.StopAll()
			
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20010_SecurityCamera_03", false )
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20010_SecurityCamera_04", false )
			
			TppDataUtility.CreateEffectFromGroupId( "wtrdrpbil" )
			TppDataUtility.CreateEffectFromGroupId( "dstcomviw" )
		end
		local onDemoSkip = function()
			
			TppGadgetUtility.SetSwitch("gntn_center_SwitchLight",false)
		end
		local onDemoEnd = function()
			
			TppMission.SetFlag( "isSwitchLightDemo", true )
			
			After_SwitchOff()
			
			TppDataUtility.DestroyEffectFromGroupId( "wtrdrpbil" )
			TppDataUtility.DestroyEffectFromGroupId( "dstcomviw" )
		end
		TppDemo.Play( "SwitchLightDemo" , { onStart = onDemoStart, onSkip = onDemoSkip , onEnd = onDemoEnd } , {
			disableGame				= false,	
			disableDamageFilter		= false,	
			disableDemoEnemies		= false,	
			disableEnemyReaction	= true,		
			disableHelicopter		= false,	
			disablePlacement		= false, 	
			disableThrowing			= false	 	
		})
	
	else
		
		After_SwitchOff()
	end
end



local OpenGateRouteChange = function()
	TppMission.SetFlag( "isSeq20_02_DriveEnd", 1 )
	
	GZCommon.Common_CenterBigGateVehicleSetup( this.cpID, "TppGroupVehicleRouteInfo_Seq20_02a", "GateEnterTruck", "GateEnterTruck02", 2, 1 )
	GZCommon.Common_CenterBigGateVehicle()

end




this.Seq_OpeningDemoPlay = {

	Messages = {
	   Demo = {
			{ data="p11_010100_000", message="characterRealize", localFunc="DemoInGameAction" },
		},
	},

	OnEnter = function()
		TppMusicManager.ClearParameter()	
		this.openingDemoSkipCount = 0		
		
		local function onDemoStart()



			TppCharacterUtility.SetEnableCharacterId( "gntn_flag_000" , false )
			TppEffectUtility.SetThunderSpotLightShadowEnable( true )	
			TppGadgetUtility.SetDoor{ id = "Asy_PickingDoor", isVisible = false, isEnableBounder = true, isEnableTacticalActionEdge = true, angle = 0, isOpen = false }
			TppUI.FadeIn(1)
		end
		
		local function onDemoSkip()




			MissionManager.RegisterNotInGameRealizeCharacter("Seq10_05")
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq00_SneakRouteSet" , "OpeningDemoRoute03" , -1 , "Seq10_05" , "ROUTE_PRIORITY_TYPE_FORCED" )

			TppCharacterUtility.SetEnableCharacterId( "gntn_flag_000" , true )
			TppEffectUtility.SetThunderSpotLightShadowEnable( false )	
			TppGameStatus.Set("MissionScript", "S_DISABLE_GAME")
			TppGadgetUtility.SetDoor{ id = "Asy_PickingDoor", isVisible = true, isEnableBounder = false, isEnableTacticalActionEdge = true, angle = 0, isOpen = false }
			this.openingDemoSkipCount = 1 
			
			local hudCommonData = HudCommonDataManager.GetInstance()
			hudCommonData:CallAccessMessage()
		end
		
		local function onDemoEnd()
			if this.openingDemoSkipCount == 0 then 



				TppCharacterUtility.SetEnableCharacterId( "gntn_flag_000" , true )
				TppEffectUtility.SetThunderSpotLightShadowEnable( false )	
				TppGadgetUtility.SetDoor{ id = "Asy_PickingDoor", isVisible = true, isEnableBounder = false, isEnableTacticalActionEdge = true, angle = 0, isOpen = false }
				TppSequence.ChangeSequence( "Seq_MissionLoad" )
				TppRadio.DelayPlay( "Miller_MissionStart", 2.0 )
			else
				TppRadio.DelayPlay( "Miller_MissionStart", 6.2 )
			end
		end
		TppDemo.Play( "ArrivalAtGz", { onStart = onDemoStart, onEnd = onDemoEnd, onSkip = onDemoSkip } )
	end,

	OnUpdate = function()
		
		if this.openingDemoSkipCount >= 1 then
			this.openingDemoSkipCount = this.openingDemoSkipCount + 1
			if this.openingDemoSkipCount >= 300 or TppMission.GetFlag( "isSeq10_05SL_ON" ) == true then 
				TppGameStatus.Reset("MissionScript", "S_DISABLE_GAME")
				TppGadgetUtility.SetDoor{ id = "Asy_PickingDoor", isVisible = true, isEnableBounder = false, isEnableTacticalActionEdge = true, angle = 0, isOpen = false }
				TppSequence.ChangeSequence( "Seq_MissionLoad" )
				
				local hudCommonData = HudCommonDataManager.GetInstance()
				hudCommonData:HideAccessMessage()
			end
		end
	end,

	DemoInGameAction = function()

		
		MissionManager.RegisterNotInGameRealizeCharacter("ComEne01")		
		MissionManager.RegisterNotInGameRealizeCharacter("ComEne04")		
		MissionManager.RegisterNotInGameRealizeCharacter("Seq10_01")		
		MissionManager.RegisterNotInGameRealizeCharacter("Seq10_05")		
		
		local cpRouteSets = {
			{
				cpID = "gntn_cp",
				sets = {
					sneak_night = "e20010_Seq00_SneakRouteSet",
					caution_night = "e20010_Seq00_SneakRouteSet",
				},
			},
		}
		TppEnemy.SetRouteSets( cpRouteSets )
		
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq00_SneakRouteSet" , "OpeningDemoRoute01" , -1 , "ComEne01" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq00_SneakRouteSet" , "OpeningDemoRoute02" , -1 , "ComEne04" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq00_SneakRouteSet" , "S_Pre_ExWeaponTalk_b" , -1 , "Seq10_01" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq00_SneakRouteSet" , "OpeningDemoRoute03" , -1 , "Seq10_05" , "ROUTE_PRIORITY_TYPE_FORCED" )
	end,
}


this.Seq_RescueChicoDemo01 = {
	
	Messages = {
	   Character = {
			{ data="Player", message="TransitionActionEnd", localFunc="DemoStart" },
		},
		Demo = {
			{ data="p11_010120_000", message="visibleGate", localFunc="onDemoVisibleGate" },
			{ data="p11_010125_000", message="visibleGate", localFunc="onDemoVisibleGate" },
			{ data="p11_010126_000", message="visibleGate", localFunc="onDemoVisibleGate" },
		},
	},

	demoId = "EncounterChico_BeforePaz_WithoutHostage",

	onDemoVisibleGate = function()



		ChicoDoor_ON_Open()
	end,

	DemoStart = function()
		
		local onDemoStart = function()
			ChicoDoor_OFF()
			
			ChengeChicoPazIdleMotion()
		end

		
		local onDemoEnd = function()
			Trophy.TrophyUnlock(13)		
			TppRadio.DelayPlayEnqueue( "Miller_TakeChicoToRVPoint", "long", nil, { onEnd = function() AnounceLog_MapUpdate() end }, nil )
			AnounceLog_EncountChico()	


			TppSequence.ChangeSequence( "Seq_NextRescuePaz" )
		end

		
		TppMission.SetFlag( "isEncounterChico", true )

		TppDemo.Play( this.Seq_RescueChicoDemo01.demoId, { onStart = onDemoStart, onEnd = onDemoEnd } )

	end,

	OnEnter = function()
		GZCommon.StopAlertSirenCheck()

		
		local hosCheck = Demo_hosChecker()	
		if( hosCheck == 0 ) then
				this.Seq_RescueChicoDemo01.demoId = "EncounterChico_BeforePaz_NoHostage"
		elseif( hosCheck == 2 )then
				this.Seq_RescueChicoDemo01.demoId = "EncounterChico_BeforePaz_WithHostage"
		else
				this.Seq_RescueChicoDemo01.demoId = "EncounterChico_BeforePaz_WithoutHostage"
		end

		local demoInterpCameraId = this.DemoList[this.Seq_RescueChicoDemo01.demoId]







		
		local demoPos = 0
		local demoRot = 0
		demoPos, demoRot = e20010_require_01.getDemoStartPos( demoInterpCameraId )







		
		TppDemoUtility.Setup(demoInterpCameraId)
		TppPlayerUtility.RequestToStartTransition{stance=this.demoStaPlayer_chico, position=demoPos, direction=demoRot, doKeep = true}
		TppPlayerUtility.RequestToInterpCameraToDemo(demoInterpCameraId,this.demoCamRot,this.demoCamSpeed)
		GZCommon.SetGameStatusForDemoTransition()
	end,
}

this.Seq_RescueChicoDemo02 = {
	
	Messages = {
	   Character = {
			{ data="Player", message="TransitionActionEnd", localFunc="DemoStart" },
		},
		Demo = {
			{ data="p11_010110_000", message="visibleGate", localFunc="onDemoVisibleGate" },
			{ data="p11_010115_000", message="visibleGate", localFunc="onDemoVisibleGate" },
			{ data="p11_010116_000", message="visibleGate", localFunc="onDemoVisibleGate" },
		},
	},

	demoId = "EncounterChico_AfterPaz_WithoutHostage",

	onDemoVisibleGate = function()



		ChicoDoor_ON_Open()
	end,

	DemoStart = function()
		
		local onDemoStart = function()
			ChicoDoor_OFF()
			
			ChengeChicoPazIdleMotion()

		end

		
		local onDemoEnd = function()
			Trophy.TrophyUnlock(13)		
			AnounceLog_EncountChico()	
			TppRadio.DelayPlayEnqueue( "Miller_TakeChicoOnHeli", "long" )


			TppSequence.ChangeSequence( "Seq_PazChicoToRV" )
		end
		
		TppMission.SetFlag( "isEncounterChico", true )

		TppDemo.Play( this.Seq_RescueChicoDemo02.demoId, { onStart = onDemoStart, onEnd = onDemoEnd } )

	end,

	OnEnter = function()
		GZCommon.StopAlertSirenCheck()

		
		local hosCheck = Demo_hosChecker()	
		if( hosCheck == 0 ) then
				this.Seq_RescueChicoDemo02.demoId = "EncounterChico_AfterPaz_NoHostage"
		elseif( hosCheck == 2 )then
				this.Seq_RescueChicoDemo02.demoId = "EncounterChico_AfterPaz_WithHostage"
		else
				this.Seq_RescueChicoDemo02.demoId = "EncounterChico_AfterPaz_WithoutHostage"
		end





		local demoInterpCameraId = this.DemoList[this.Seq_RescueChicoDemo02.demoId]




		
		local demoPos = 0
		local demoRot = 0
		demoPos, demoRot = e20010_require_01.getDemoStartPos( demoInterpCameraId )








		
		TppDemoUtility.Setup(demoInterpCameraId)
		TppPlayerUtility.RequestToStartTransition{stance=this.demoStaPlayer_chico,position=demoPos,direction=demoRot,doKeep = true}
		TppPlayerUtility.RequestToInterpCameraToDemo(demoInterpCameraId,this.demoCamRot,this.demoCamSpeed)
		GZCommon.SetGameStatusForDemoTransition()
	end,
}

this.Seq_QuestionChicoDemo = {
	Messages = {
	   Character = {
			{ data="Player", message="TransitionActionEnd", localFunc="DemoStart" },
		},
		Timer = {
			{ data = "timer_demoRescueChico", message = "OnEnd", localFunc = "DemoStart" },
		},
	},

	
	DemoStart = function()
		local function onDemoStart()
			
			ChengeChicoPazIdleMotion()
		end
		local function onDemoEnd()
			TppEnemy.SetFormVariation( "Chico" , "ChicoYPfova" )	
			e20010_require_01.InterrogationAdviceTimerStart()	
			AnounceLog_CarryChicoToRV()	
			GetChicoTape()
			TppHostageManager.GsSetSpecialFaintFlag( "Chico", false ) 
			if( TppMission.GetFlag( "isHeliComingRV" ) == false ) then
				TppRadio.DelayPlay("Miller_PazChicoCarriedEndRV","mid")
			end
			e20010_require_01.Radio_RescuePaz1Timer()
			e20010_require_01.Radio_RescuePaz2Timer()
			TppSequence.ChangeSequence( "Seq_NextRescuePaz" )
		end
		TppMission.SetFlag( "isQuestionChico", true )								

		TppDemo.Play( this.CounterList.PlayQuestionDemo, { onStart = onDemoStart, onEnd = onDemoEnd} )
	end,

	OnEnter = function()



		GZCommon.StopAlertSirenCheck()
		
		this.CounterList.PlayQuestionDemo = "QuestionChico"

		local demoInterpCameraId = ""

		
		local demoPos
		local demoRot
		local degree

		local warpPoint = Check_AroundSpace("Chico")




		
		local ret,quat,trans
		if( warpPoint == "notWarp" ) then			
			



			this.CounterList.PlayQuestionDemo = "QuestionChicoCut"
			
			demoInterpCameraId = this.DemoList[this.CounterList.PlayQuestionDemo]

			ret,quat,trans = Demo.GetCharacterTransformFromCharacter(demoInterpCameraId,"Player","Chico")
			if ret then







				local offsetBase = Vector3(0.0,0,0.0215)
				local offset = quat:Rotate(offsetBase)
				trans = trans + offset



				local direction = quat:Rotate( Vector3( 0.0, 0.0, 1.0 ) )
				local angle = foxmath.Atan2( direction:GetX(), direction:GetZ() )
				degree = foxmath.RadianToDegree( angle )
				demoPos = trans
				demoRot = quat

			else
				
				TppSequence.ChangeSequence( "Seq_NextRescuePaz" )
			end

		else		



			this.CounterList.PlayQuestionDemo = "QuestionChico"
			
			demoInterpCameraId = this.DemoList[this.CounterList.PlayQuestionDemo]
			demoPos = TppData.GetPosition( warpPoint )
			demoRot = TppData.GetRotation( warpPoint )
		end

		



		local body = DemoDaemon.FindDemoBody(demoInterpCameraId)

		if not Entity.IsNull(body)then









			body.data.transform.translation = demoPos
			body.data.transform.rotQuat = demoRot
		end

		
		TppDemoUtility.Setup(demoInterpCameraId)

		
		if( warpPoint == "notWarp" ) then
			






			TppPlayerUtility.RequestToStartTransition{stance="Squat",position=trans,direction=degree,doKeep = true}
			TppPlayerUtility.RequestToInterpCameraToDemo(demoInterpCameraId,this.demoCamRot,this.demoCamSpeed)

			GZCommon.SetGameStatusForDemoTransition()
		else



			this.Seq_QuestionChicoDemo.DemoStart()
		end
	end,
}

this.Seq_CassetteDemo = {

	OnEnter = function()

		local function onDemoStart()
			
			do
				local cpObj = Ch.FindCharacterObjectByCharacterId( this.cpID )
				if not Entity.IsNull(cpObj) then
					local phaseController = cpObj:GetPhaseController()
					if not Entity.IsNull(phaseController) then
						phaseController:SetCurrentPhaseByName("Neutral")
						phaseController:SetCurrentPhaseLevel(0)
						TppCharacterUtility.ResetPhase()
						TppSoundDaemon.PostEvent( "Stop_sfx_m_gntn_alert_siren4_lp" )
					end
				end
			end
			
			TppSupportHelicopterService.Initialize("SupportHelicopter")
			ChengeChicoPazIdleMotion()
		end
		local function onDemoEnd()
			if ( TppMission.GetFlag( "isChicoTapeGet" ) == false ) then
				GetChicoTape()		
				e20010_require_01.InterrogationAdviceTimerStart()	
			else
				
			end
			TppMission.SetFlag( "isHeliLandNow", false )
			TppMission.SetFlag( "isHeliComeToSea", false )
			TppMission.SetFlag( "isHeliComingRV", false )
			TppUI.FadeIn( 0 )
			TppSequence.ChangeSequence( "Seq_NextRescuePaz" )
		end

	
	
		
		
		local player = Ch.FindCharacterObjectByCharacterId( "Player" )
		local playerPos = player:GetPosition()
		local point00 = TppData.GetPosition( "cassetteDemoCheck_00" )
		local point10 = TppData.GetPosition( "cassetteDemoCheck_10" )
		local point20 = TppData.GetPosition( "cassetteDemoCheck_20" )
		local point25 = TppData.GetPosition( "cassetteDemoCheck_25" )
		local point30 = TppData.GetPosition( "cassetteDemoCheck_30" )
		local point35 = TppData.GetPosition( "cassetteDemoCheck_35" )
		
		local checkP00 = TppUtility.FindDistance( playerPos, point00 )
		local checkP10 = TppUtility.FindDistance( playerPos, point10 )
		local checkP20 = TppUtility.FindDistance( playerPos, point20 )
		local checkP25 = TppUtility.FindDistance( playerPos, point25 )
		local checkP30 = TppUtility.FindDistance( playerPos, point30 )
		local checkP35 = TppUtility.FindDistance( playerPos, point35 )
		
		local minLength = 999999999999999999
		local minIndex = ""

		local hoge = {
		}
		hoge["cassetteDemoCheck_00"] = checkP00
		hoge["cassetteDemoCheck_10"] = checkP10
		hoge["cassetteDemoCheck_20"] = checkP20
		hoge["cassetteDemoCheck_25"] = checkP25
		hoge["cassetteDemoCheck_30"] = checkP30
		hoge["cassetteDemoCheck_35"] = checkP35
		for index, length in pairs( hoge ) do
			if length < minLength then
				minLength = length
				minIndex = index
			end
		end




		local demoName = "Demo_CassettePlayWithoutTapeL"
		local demoPos = Vector3(137.771,	4.970	,114.796)
		local demoRot = Quat(0,	0.208172,	0,	0.978092)
		local LR = "L"
		if( minIndex == "cassetteDemoCheck_10" )then
			demoPos = Vector3(-220.154600,	37.969590,	302.029100)
			demoRot = Quat(0,	-0.65277750,	0,			0.75754960)
			LR = "R"
		elseif( minIndex == "cassetteDemoCheck_20" )then
			demoPos = Vector3(-119.560, 27.944, 146.219)
			demoRot = Quat(0,	0.70710650,	0,	0.70710700)
			LR = "L"
		elseif( minIndex == "cassetteDemoCheck_25" )then
			demoPos = Vector3(-111.207400,	27.944450	,140.348100)
			demoRot = Quat(0,	-0.72373610,	0,	0.69007680)
			LR = "R"
		elseif( minIndex == "cassetteDemoCheck_30" )then
			demoPos = Vector3(-95.282150,	31.080120	,52.449980)
			demoRot = Quat(0,	0,	0,	1)
			LR = "L"
		elseif( minIndex == "cassetteDemoCheck_35" )then
			demoPos = Vector3(-83.816440,	31.080120	,52.364280)
			demoRot = Quat(0,	0,	0,	1)
			LR = "R"
		end

		
		if( TppMission.GetFlag( "isQuestionChico" ) == false )then
		
			if ( LR == "L")then
				demoName = "Demo_CassettePlayWithoutTapeL"
			else
				demoName = "Demo_CassettePlayWithoutTapeR"
			end
		else
		
			if ( LR == "L")then
				demoName = "Demo_CassettePlayWithTapeL"
			else
				demoName = "Demo_CassettePlayWithTapeR"
			end
		end







		TppMission.SetFlag( "isCassetteDemo", true )								
		GZCommon.StopAlertSirenCheck()

		
		local demoInterpCameraId = this.DemoList[demoName]
		local body = DemoDaemon.FindDemoBody(demoInterpCameraId)

		if not Entity.IsNull(body)then
			body.data.transform.translation = demoPos
			body.data.transform.rotQuat = demoRot
		end

		TppDemo.Play( demoName, { onStart = onDemoStart, onEnd = onDemoEnd } )

	end,

	OnLeave = function()
		
		TppMusicManager.PlayMusicPlayer( 'tp_chico_00_03' )



		TppMission.SetFlag( "isHeliLandNow", false )
		TppMission.SetFlag( "isHeliComeToSea", false )
		TppMission.SetFlag( "isHeliComingRV", false )
		TppMission.SetFlag( "isChicoTapePlay", true )
		
		if( TppMission.GetFlag( "isSaveAreaNo" ) == 1 ) then		
			TppMissionManager.SaveGame("50")
		elseif( TppMission.GetFlag( "isSaveAreaNo" ) == 2 ) then	
			TppMissionManager.SaveGame("40")
		elseif( TppMission.GetFlag( "isSaveAreaNo" ) == 3 ) then	
			TppMissionManager.SaveGame("10")
		elseif( TppMission.GetFlag( "isSaveAreaNo" ) == 4 ) then	
			TppMissionManager.SaveGame("51")
		else
			
		end
	end,

}


this.Seq_RescuePazDemo = {
	
	Messages = {
	   Character = {
			{ data="Player", message="TransitionActionEnd", localFunc="DemoStart" },
		},
		Demo = {
			{ data="p11_010130_000", message="visibleGate", localFunc="onDemoVisibleGate" },
		},
	},


	onDemoVisibleGate = function()



		PazDoor_ON_Open()
	end,

	DemoStart = function()
		TppMission.SetFlag( "isEncounterPaz", true )								

		local function onDemoStart()
			
			ChengeChicoPazIdleMotion()
			PazDoor_OFF()
			TppEnemy.SetFormVariation( "Paz" , "fovaPazBeforeDemo2" )	

		end
		local function onDemoEnd()
			TppEnemy.SetFormVariation( "Paz" , "fovaPazAfterDemo" )	
			Trophy.TrophyUnlock(13)		
			AnounceLog_EncountPaz()		
			PazDoor_ON_Open()

			
			TppRadioCommand.SetEnableDisableRadioWhileChico3TapeIsPlaying( false )

		
		

			local uiCommonData = UiCommonDataManager.GetInstance()
			if( uiCommonData:IsNeedSkipPazRescueSequence() == true ) then
				uiCommonData:PazResqueEndSequence()
			elseif( TppMission.GetFlag( "isEncounterChico" ) == false ) then			
				TppRadio.DelayPlayEnqueue( "Miller_takePazToRVPoint01", "long", nil, { onEnd = function() AnounceLog_MapUpdate() end }, nil )
				TppSequence.ChangeSequence( "Seq_NextRescueChico" )

			else																
				TppRadio.DelayPlayEnqueue("Miller_takePazOnHeli","mid")
				TppSequence.ChangeSequence( "Seq_ChicoPazToRV" )
			end

		end
		TppDemo.Play( "EncounterPaz", { onStart = onDemoStart, onEnd = onDemoEnd } )
		TppTimer.Start( "PazPrizonBreakTimer", 60 )	

	end,

	OnEnter = function()
		GZCommon.StopAlertSirenCheck()

		local demoInterpCameraId = "p11_010130_000"

		
		local demoPos = 0
		local demoRot = 0
		demoPos, demoRot = e20010_require_01.getDemoStartPos( demoInterpCameraId )










		
		TppDemoUtility.Setup(demoInterpCameraId)
		TppPlayerUtility.RequestToStartTransition{stance=this.demoStaPlayer_paz,position=demoPos,direction=demoRot,doKeep = true}
		TppPlayerUtility.RequestToInterpCameraToDemo(demoInterpCameraId,this.demoCamRot,this.demoCamSpeed)

		
		GZCommon.SetGameStatusForDemoTransition()

	end,
}

this.Seq_QuestionPazDemo = {
	Messages = {
	   Character = {
			{ data="Player", message="TransitionActionEnd", localFunc="DemoStart" },
		},
		Timer = {
			{ data = "timer_demoRescuePaz", message = "OnEnd", localFunc = "DemoStart" },
		},
	},

	DemoStart = function()
		local function onDemoStart()
		end
		local function onDemoEnd()
			AnounceLog_CarryPazToRV()	

			TppSequence.ChangeSequence( "Seq_NextRescueChico" )
		end
		TppMission.SetFlag( "isQuestionPaz", true )								
		TppDemo.Play( this.CounterList.PlayQuestionDemo, { onStart = onDemoStart, onEnd = onDemoEnd } )
	end,
	OnEnter = function()



		GZCommon.StopAlertSirenCheck()
		
		this.CounterList.PlayQuestionDemo = "QuestionPaz"

		local demoInterpCameraId = ""

		
		local demoPos
		local demoRot
		local degree

		local warpPoint = Check_AroundSpace("Paz")





		
		local ret,quat,trans
		if( warpPoint == "notWarp" ) then			
			



			this.CounterList.PlayQuestionDemo= "QuestionPazCut"
			
			demoInterpCameraId = this.DemoList[this.CounterList.PlayQuestionDemo]


			ret,quat,trans = Demo.GetCharacterTransformFromCharacter(demoInterpCameraId,"Player","Paz")
			if ret then







				local offsetBase = Vector3(0.0,0,0.0215)
				local offset = quat:Rotate(offsetBase)
				trans = trans + offset



				local direction = quat:Rotate( Vector3( 0.0, 0.0, 1.0 ) )
				local angle = foxmath.Atan2( direction:GetX(), direction:GetZ() )
				degree = foxmath.RadianToDegree( angle )
				demoPos = trans
				demoRot = quat

			else
				
				TppSequence.ChangeSequence( "Seq_NextRescueChico" )
			end

		else		



			this.CounterList.PlayQuestionDemo = "QuestionPaz"
			
			demoInterpCameraId = this.DemoList[this.CounterList.PlayQuestionDemo]
			demoPos = TppData.GetPosition( warpPoint )
			demoRot = TppData.GetRotation( warpPoint )
		end

		



		local body = DemoDaemon.FindDemoBody(demoInterpCameraId)

		if not Entity.IsNull(body)then









			body.data.transform.translation = demoPos
			body.data.transform.rotQuat = demoRot
		end

		
		TppDemoUtility.Setup(demoInterpCameraId)

		
		if( warpPoint == "notWarp" ) then
			






			TppPlayerUtility.RequestToStartTransition{stance="Squat",position=trans,direction=degree,doKeep = true}
			TppPlayerUtility.RequestToInterpCameraToDemo(demoInterpCameraId,this.demoCamRot,this.demoCamSpeed)

			GZCommon.SetGameStatusForDemoTransition()
		else



			this.Seq_QuestionPazDemo.DemoStart()
		end
	end,
}

this.commonMarkerEnable = function()





	

	local MarkerID			= TppData.GetArgument(1)

	if ( MarkerID == "Chico" ) then
		if( TppMission.GetFlag( "isSearchLightChicoArea" ) == 1 ) then 
			TppRadio.PlayEnqueue( "Miller_SearchLightChico" )
		end
		TppMission.SetFlag( "isSearchLightChicoArea", 2 )
	end
end

this.enterSearchLightChicoArea = function()
	if( TppMission.GetFlag( "isSearchLightChicoArea" ) == 0 ) then
		TppMission.SetFlag( "isSearchLightChicoArea", 1 )
	end
end

this.exitSearchLightChicoArea = function()
	if( TppMission.GetFlag( "isSearchLightChicoArea" ) == 1 ) then
		TppMission.SetFlag( "isSearchLightChicoArea", 0 )
	end
end

this.commonHeliDamagedByPlayer = function()
	local radioDaemon = RadioDaemon:GetInstance()

	if ( radioDaemon:IsPlayingRadio() == false ) then
		
		TppRadio.PlayEnqueue( "Miller_HeliAttack" )
	end
end

this.commonSuppressorIsBroken = function()
	local VehicleId = TppPlayerUtility.GetRidingVehicleCharacterId()

	if( VehicleId == "SupportHelicopter" ) then
	else
		TppRadio.DelayPlayEnqueue( "Miller_BreakSuppressor", "short" )
	end
end


this.commmonPlayerCrawl = function()
	local phase = TppEnemy.GetPhase( this.cpID )
	local radioDaemon = RadioDaemon:GetInstance()
	if ( phase == "alert" or phase == "evasion" ) then
	else
		if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0968") == false )then
			if ( radioDaemon:IsPlayingRadio() == false ) then
				TppRadio.DelayPlayEnqueue( "Miller_CrawlTutorial", "short", nil, { onEnd = function() e20010_require_01.Tutorial_2Button( "tutorial_rolling", "PL_HOLD", fox.PAD_L3 ) end } )
			end
		end
	end
end


this.Common_HeliLostControl = function()
	local characterId = TppEventSequenceManagerCollector.GetMessageArg( 1 )
	if characterId == "Player" then
		TppMission.ChangeState( "failed", "HeliLostControl_PlayerAttack" )
	else
		TppMission.ChangeState( "failed", "HeliLostControl" )
	end
end


this.Radio_HohukuAdvice = function()
	local radioDaemon = RadioDaemon:GetInstance()
	if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1250") == false ) then
		TppRadio.DelayPlayEnqueue( "Miller_HohukuAdvice" ,"short" )
		radioDaemon:EnableFlagIsMarkAsRead( "e0010_rtrg1250" )
	end
end


this.Messages = {
	Mission = {
		{ message = "MissionFailure", localFunc = "commonMissionFailure" },
		{ message = "MissionClear", localFunc = "commonMissionClear" },
		{ message = "MissionRestart", localFunc = "commonMissionCleanUp" },		
		{ message = "MissionRestartFromCheckPoint", localFunc = "commonMissionCleanUp" },		
		{ message = "ReturnTitle", localFunc = "Pre_commonMissionCleanUp" },		
	},
	Enemy = {
		{ message = "EnemyFindHostage", commonFunc = Common_EnemyDiscoveryNoPaz },
		{ message = "EnemyDead", commonFunc = Common_EnemyDead },
	},
	Character = {
		{ data = "gntn_cp", message = "Alert", commonFunc = Common_Alert },	
		{ data = "gntn_cp", message = "Evasion", commonFunc = Common_Evasion },									
		{ data = "gntn_cp", message = "Caution", commonFunc = Common_Caution },									
		{ data = "gntn_cp", message = "Sneak", commonFunc = Common_Sneak },	
		{ data = "gntn_cp", message = "EnemySleep" , commonFunc = Common_PreEnemyCarryAdvice },					
		{ data = "gntn_cp", message = "EnemyFaint" , commonFunc = Common_PreEnemyCarryAdvice },					
		{ data = "gntn_cp", message = "EnemyDying" , commonFunc = Common_PreEnemyCarryAdvice },					
		{ data = "gntn_cp", message = "EnemyDead" , commonFunc = Common_PreEnemyCarryAdvice },						
		{ data = "gntn_cp",	message = "AntiAir",	commonFunc = Common_ChangeAntiAir },	
		{ data = "gntn_cp", message = "ConversationEnd", commonFunc = function() e20010_require_01.Common_ConversationEnd() end },	
		{ data = "gntn_cp", message = "EnemyFaint" , commonFunc = function() TppMission.SetFlag( "isDoneCQC", true ) end },		
		{ data = "gntn_cp", message = "EnemyRestraint", commonFunc = function() TppMission.SetFlag( "isDoneCQC", true ) end },	
		{ data = "Player", message = "RideHelicopter", commonFunc = Common_PlayerOnHeli },	
		{ data = "Player", message = "OnVehicleRide_End", commonFunc = Common_RideOnVehicle },	
		{ data = "Player", message = "OnPickUpWeapon" , commonFunc = Common_PickUpWeaopn },	
		{ data = "Player", message = "OnPickUpItem" , commonFunc = Common_PickUpItem },	
		{ data = "Player", message = "TryPicking", commonFunc = Common_NoTargetCagePicking },	
		{ data = "Player", message = "OnEquipWeapon", commonFunc = Common_EquipWeapon },		
		{ data = "Player", message = "OnAmmoStackEmpty", commonFunc = function() e20010_require_01.Radio_OnAmmoStackEmpty() end },		

		{ data = "Player", message = "OnVehicleRideSneak_End", commonFunc = function() e20010_require_01.OpenGateTruck_SneakRideON() end },	
		{ data = "Player", message = "OnVehicleGetOffSneak_Start", commonFunc = function() e20010_require_01.OpenGateTruck_SneakRideOFF() end },	
		{ data = "Player", message = "NotifyStartWarningFlare", commonFunc = function() e20010_require_01.MbDvcActCallRescueHeli("SupportHelicopter", "flare") end },	
		{ data = "Player", message = "CrawlRolling", commonFunc = function() DropXOFCrawRoling() end },	
		{ data = "Player", message = "RideHelicopterWithHostage", commonFunc = function() e20010_require_01.Common_CarryHostageOnHeli() end },	
		{ data = "Player", message = "OnBinocularsMode", commonFunc = function() e20010_require_01.Radio_BinocularsModeOn() end },	
		{ data = "Player", message = "OffBinocularsMode", commonFunc = function() e20010_require_01.Radio_BinocularsModeOff() end },	
		{ data = "Chico", message = "MessageHostageCarriedStart", commonFunc = Common_ChicoPazCarry },	
		{ data = "Paz", message = "MessageHostageCarriedStart", commonFunc = Common_ChicoPazCarry },	
		{ data = "Chico", message = "HostageLaidOnVehicle", commonFunc = Common_ChicoOnHeli },	
		{ data = "Chico", message = "DeadType", commonFunc = function() GZCommon.Common_ChicoPazDead() end },
		{ data = "Paz", message = "HostageLaidOnVehicle", commonFunc = Common_PazOnHeli },	
		{ data = "Paz", message = "DeadType", commonFunc = function() GZCommon.Common_ChicoPazDead() end },
		{ data = "SpHostage", message = "HostageLaidOnVehicle", commonFunc = function() Common_SpHostageOnHeli() end },	
		{ data = "Hostage_e20010_004", message = "HostageLaidOnVehicle", commonFunc = Common_Hostage04OnHeli },	
		{ data = "ComEne01", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne02", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne03", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne04", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne05", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne06", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne07", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne08", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne09", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne10", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne11", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne12", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne13", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne14", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne15", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne16", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne17", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne18", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne19", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne20", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne21", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne22", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne23", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne24", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne25", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne26", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne27", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne28", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne29", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne30", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne31", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne32", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne33", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "ComEne34", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "Seq10_01", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "Seq10_02", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "Seq10_03", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "Seq10_05", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "Seq10_05", message = "SearchLightOn", commonFunc = function() TppMission.SetFlag( "isSeq10_05SL_ON", true ) end },	
		{ data = "Seq10_06", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "Seq10_07", message = "HostageLaidOnVehicle", commonFunc = Common_EnemyOnHeli },	
		{ data = "Hostage_e20010_001", message = "HostageLaidOnVehicle", commonFunc = Common_HostageOnHeli },	
		{ data = "Hostage_e20010_002", message = "HostageLaidOnVehicle", commonFunc = Common_HostageOnHeli },	
		{ data = "Hostage_e20010_003", message = "HostageLaidOnVehicle", commonFunc = Common_HostageOnHeli },	
		{ data = "SpHostage", message = "MessageHostageCarriedStart", commonFunc = Common_SpHostageCarryStart },	
		{ data = "SupportHelicopter", message = "ArriveToLandingZone", commonFunc = Common_HeliArrive },	
		{ data = "SupportHelicopter", message = "DescendToLandingZone", commonFunc = function() e20010_require_01.Common_HeliDescend() end },	
		{ data = "SupportHelicopter", message = "LostControl", commonFunc = function() this.Common_HeliLostControl() end },
		{ data = "SupportHelicopter", message = "DepartureToMotherBase",	commonFunc = Common_Departure },	

		{ data = "SupportHelicopter", message = "CloseDoor", commonFunc = Common_HeliCloseDoor },	
		{ data = "SupportHelicopter", message = "DamagedByPlayer", commonFunc = function() this.commonHeliDamagedByPlayer() end },	

		{ data = "Hostage_e20010_001", message = "HostageSleep", commonFunc = function() TppMission.SetFlag( "isHostageUnusual", true ) end },	
		{ data = "Hostage_e20010_001", message = "HostageFaint", commonFunc = function() TppMission.SetFlag( "isHostageUnusual", true ) end },	

		{ data = "Hostage_e20010_002", message = "HostageSleep", commonFunc = function() TppMission.SetFlag( "isHostageUnusual", true ) end },	
		{ data = "Hostage_e20010_002", message = "HostageFaint", commonFunc = function() TppMission.SetFlag( "isHostageUnusual", true ) end },	
		{ data = "Hostage_e20010_001", message = "MessageHostageCarriedStart", commonFunc = Common_NomalHostage01CarryStart },			
		{ data = "Hostage_e20010_002", message = "MessageHostageCarriedStart", commonFunc = Common_NomalHostage02CarryStart },			
		{ data = "Hostage_e20010_003", message = "MessageHostageCarriedStart", commonFunc = Common_NomalHostage03CarryStart },			
		{ data = "Hostage_e20010_004", message = "MessageHostageCarriedStart", commonFunc = Common_NomalHostage04CarryStart },			
		{ data = "Hostage_e20010_001", message = "Dead", commonFunc = Common_Hostage001_Dead },	
		{ data = "Hostage_e20010_002", message = "Dead", commonFunc = Common_Hostage002_Dead },	
		{ data = "Hostage_e20010_003", message = "Dead", commonFunc = Common_Hostage003_Dead },	
		{ data = "Hostage_e20010_004", message = "Dead", commonFunc = Common_Hostage004_Dead },	
		{ data = "SpHostage",		   message = "Dead", commonFunc = Common_SpHostage_Dead },	

		{ data = "Tactical_Vehicle_WEST_002", message = "VehicleBroken", commonFunc = Common_VehicleBroken },	
		{ data = "Tactical_Vehicle_WEST_003", message = "VehicleBroken", commonFunc = Common_VehicleBroken },	
		{ data = "Tactical_Vehicle_WEST_004", message = "VehicleBroken", commonFunc = Common_VehicleBroken },	
		{ data = "Tactical_Vehicle_WEST_005", message = "VehicleBroken", commonFunc = Common_VehicleBroken },	
		{ data = "Cargo_Truck_WEST_002", message = "VehicleBroken", commonFunc = Common_TruckBroken },	
		{ data = "Cargo_Truck_WEST_003", message = "VehicleBroken", commonFunc = Common_TruckBroken },	
		{ data = "Cargo_Truck_WEST_004", message = "VehicleBroken", commonFunc = Common_TruckBroken },	
		{ data = "ComEne34", message = "EnemyDead", commonFunc = function() TppMission.SetFlag( "isCenterTowerEnemy", true ) end },	
		{ data = "e20010_SecurityCamera_01", message = "Dead", commonFunc = function() e20010_require_01.Common_SecurityCameraBroken() end },
		{ data = "e20010_SecurityCamera_02", message = "Dead", commonFunc = function() e20010_require_01.Common_SecurityCameraBroken() end },
		{ data = "e20010_SecurityCamera_03", message = "Dead", commonFunc = function() e20010_require_01.Common_SecurityCameraBroken() end },
		{ data = "e20010_SecurityCamera_04", message = "Dead", commonFunc = function() e20010_require_01.Common_SecurityCameraBroken() end },
		{ data = "e20010_SecurityCamera_01", message = "PowerOFF", commonFunc = function() e20010_require_01.Common_SecurityCameraPowerOff() end },
		{ data = "e20010_SecurityCamera_02", message = "PowerOFF", commonFunc = function() e20010_require_01.Common_SecurityCameraPowerOff() end },
		{ data = "e20010_SecurityCamera_03", message = "PowerOFF", commonFunc = function() e20010_require_01.Common_SecurityCameraPowerOff() end },
		{ data = "e20010_SecurityCamera_04", message = "PowerOFF", commonFunc = function() e20010_require_01.Common_SecurityCameraPowerOff() end },
		{ data = "e20010_SecurityCamera_01", message = "PowerON", commonFunc = function() e20010_require_01.Common_SecurityCameraPowerOn() end },
		{ data = "e20010_SecurityCamera_02", message = "PowerON", commonFunc = function() e20010_require_01.Common_SecurityCameraPowerOn() end },
		{ data = "e20010_SecurityCamera_03", message = "PowerON", commonFunc = function() e20010_require_01.Common_SecurityCameraPowerOn() end },
		{ data = "e20010_SecurityCamera_04", message = "PowerON", commonFunc = function() e20010_require_01.Common_SecurityCameraPowerOn() end },
		{ data = "e20010_SecurityCamera_01", message = "Alert", commonFunc = function() e20010_require_01.Common_SecurityCameraAlert() end },
		{ data = "e20010_SecurityCamera_02", message = "Alert", commonFunc = function() e20010_require_01.Common_SecurityCameraAlert() end },
		{ data = "e20010_SecurityCamera_03", message = "Alert", commonFunc = function() e20010_require_01.Common_SecurityCameraAlert() end },
		{ data = "e20010_SecurityCamera_04", message = "Alert", commonFunc = function() e20010_require_01.Common_SecurityCameraAlert() end },
	},
	Trap = {
		{ data = "Wave_OFF", message = "Enter", commonFunc = function() TppDataUtility.DestroyEffectFromGroupId( "splash01" ) end },
		{ data = "Wave_OFF", message = "Exit", commonFunc = function() TppDataUtility.CreateEffectFromGroupId( "splash01" ) end },
		{ data = "S01_HeliPort", message = "Enter", commonFunc = function() TppMission.SetFlag( "isSaveAreaNo", 1 ) end },
		{ data = "S01_HeliPort", message = "Exit", commonFunc = function() TppMission.SetFlag( "isSaveAreaNo", 0 ) end },
		{ data = "S02_SeaSide", message = "Enter", commonFunc = function() TppMission.SetFlag( "isSaveAreaNo", 2 ) end },
		{ data = "S02_SeaSide", message = "Exit", commonFunc = function() TppMission.SetFlag( "isSaveAreaNo", 0 ) end },
		{ data = "S03_StartCliff", message = "Enter", commonFunc = function() TppMission.SetFlag( "isSaveAreaNo", 3 ) end },
		{ data = "S03_StartCliff", message = "Exit", commonFunc = function() TppMission.SetFlag( "isSaveAreaNo", 0 ) end },
		{ data = "S04_WareHouse", message = "Enter", commonFunc = function() TppMission.SetFlag( "isSaveAreaNo", 4 ) end },
		{ data = "S04_WareHouse", message = "Exit", commonFunc = function() TppMission.SetFlag( "isSaveAreaNo", 0 ) end },
		{ data = "RainDropCamera", message = "Enter", commonFunc = function() TppEffectUtility.SetCameraRainDropRate( 3.3 ) end },
		{ data = "RainDropCamera", message = "Exit", commonFunc = function() TppEffectUtility.SetCameraRainDropRate( 1.0 ) end },
		{ data = "WoodTurret_RainFilter01", message = "Enter", commonFunc = WoodTurret_RainFilter_ON },
		{ data = "WoodTurret_RainFilter02", message = "Enter", commonFunc = WoodTurret_RainFilter_ON },
		{ data = "WoodTurret_RainFilter03", message = "Enter", commonFunc = WoodTurret_RainFilter_ON },
		{ data = "WoodTurret_RainFilter04", message = "Enter", commonFunc = WoodTurret_RainFilter_ON },
		{ data = "WoodTurret_RainFilter05", message = "Enter", commonFunc = WoodTurret_RainFilter_ON },
		{ data = "WoodTurret_RainFilter01", message = "Exit", commonFunc = WoodTurret_RainFilter_OFF },
		{ data = "WoodTurret_RainFilter02", message = "Exit", commonFunc = WoodTurret_RainFilter_OFF },
		{ data = "WoodTurret_RainFilter03", message = "Exit", commonFunc = WoodTurret_RainFilter_OFF },
		{ data = "WoodTurret_RainFilter04", message = "Exit", commonFunc = WoodTurret_RainFilter_OFF },
		{ data = "WoodTurret_RainFilter05", message = "Exit", commonFunc = WoodTurret_RainFilter_OFF },
		{ data = "MissionArea_Out", message = "Enter", commonFunc = MissionArea_Out },
		{ data = "CTE0010_0280_NearArea", message = "Enter", commonFunc = function() TppMission.SetFlag( "isCTE0010_0280_NearArea", true ) end },
		{ data = "CTE0010_0280_NearArea", message = "Exit", commonFunc = function() TppMission.SetFlag( "isCTE0010_0280_NearArea", false ) end },
		{ data = "CTE0010_0310_NearArea", message = "Enter", commonFunc = function() TppMission.SetFlag( "isCTE0010_0310_NearArea", true ) end },
		{ data = "CTE0010_0310_NearArea", message = "Exit", commonFunc = function() TppMission.SetFlag( "isCTE0010_0310_NearArea", false ) end },
		{ data = "SaftyAreaTrap01", message = "Enter", commonFunc = function() TppMission.SetFlag( "isSaftyArea01", true ) end },
		{ data = "SaftyAreaTrap01", message = "Exit", commonFunc = function() TppMission.SetFlag( "isSaftyArea01", false ) end },
		{ data = "SaftyAreaTrap02", message = "Enter", commonFunc = function() TppMission.SetFlag( "isSaftyArea02", true ) end },
		{ data = "SaftyAreaTrap02", message = "Exit", commonFunc = function() TppMission.SetFlag( "isSaftyArea02", false ) end },
		{ data = "Radio_DangerArea", message = "Enter", commonFunc = function() TppMission.SetFlag( "isDangerArea", true ) end },
		{ data = "Radio_DangerArea", message = "Exit", commonFunc = function() TppMission.SetFlag( "isDangerArea", false ) end },
		{ data = "Check_SeaCliff", message = "Enter", commonFunc = function() TppMission.SetFlag( "isInSeaCliffArea", true ) end },	
		{ data = "Check_SeaCliff", message = "Exit", commonFunc = function() TppMission.SetFlag( "isInSeaCliffArea", false ) end },	
		{ data = "Check_StartCliff", message = "Enter", commonFunc = function() TppMission.SetFlag( "isInStartCliffArea", true ) end },	
		{ data = "Check_StartCliff", message = "Exit", commonFunc = function() TppMission.SetFlag( "isInStartCliffArea", false ) end },	
		{ data = "Check_NoKillGunAdviceAsylum", message = "Enter", commonFunc = function() TppMission.SetFlag( "isGunTutorialArea", true ) end },	
		{ data = "Check_NoKillGunAdviceAsylum", message = "Exit", commonFunc = function() TppMission.SetFlag( "isGunTutorialArea", false ) end },	
		{ data = "Radio_SearchChico", message = "Enter", commonFunc = this.enterSearchLightChicoArea },	
		{ data = "Radio_SearchChico", message = "Exit", commonFunc = this.exitSearchLightChicoArea },	
		{ data = "AsyInsideRouteChange_01", message = "Enter", commonFunc = AsyInsideRouteChange_01 },
		{ data = "EastCampMoveTruck_Start", message = "Enter", commonFunc = EastCampMoveTruck_Start },
		{ data = "EastCampSouth_SL_RouteChange", message = "Enter", commonFunc = EastCampSouth_SL_RouteChange },
		{ data = "GunTutorialEnemyRouteChange", message = "Enter", commonFunc = GunTutorialEnemyRouteChange },
		{ data = "Talk_AsyWC", message = "Enter", commonFunc = Talk_AsyWC },
		{ data = "Talk_ChicoTape", message = "Enter", commonFunc = Talk_ChicoTape },
		{ data = "Talk_EscapeHostage", message = "Enter", commonFunc = Talk_EscapeHostage },
		{ data = "VehicleStart", message = "Enter", commonFunc = VehicleStart },
		{ data = "Center2F_EneRouteChange", message = "Enter", commonFunc = Center2F_EneRouteChange },



		{ data = "SmokingRouteChange", message = "Enter", commonFunc = SmokingRouteChange },
		{ data = "BoilarEnemyRouteChange", message = "Enter", commonFunc = BoilarEnemyRouteChange },
		{ data = "ComEne11_RouteChange", message = "Enter", commonFunc = ComEne11_RouteChange },
		{ data = "GateOpenTruckRouteChange", message = "Enter", commonFunc = GateOpenTruckRouteChange },
		{ data = "Seaside2manStartRouteChange", message = "Enter", commonFunc = Seaside2manStartRouteChange },
		{ data = "Seq20_05_RouteChange", message = "Enter", commonFunc = Seq20_05_RouteChange },
		{ data = "Talk_KillSpHostage01", message = "Enter", commonFunc = Talk_KillSpHostage01 },
		{ data = "Seq30_PazCheck_Start", message = "Enter", commonFunc = Seq30_PazCheck_Start },
		{ data = "Seq30_PatrolVehicle_Start", message = "Enter", commonFunc = Seq30_PatrolVehicle_Start },
		{ data = "Radio_RouteDrain", message = "Enter", commonFunc = function() e20010_require_01.Radio_RouteDrain() end },						
		{ data = "Radio_InCenterCoverAdvice", message = "Enter", commonFunc = function() e20010_require_01.Radio_InCenterCoverAdvice() end },	
		{ data = "Radio_HohukuAdvice", message = "Enter", commonFunc = function() e20010_require_01.Radio_drainTutorial() end },	
		{ data = "XofMarkerOff_Trap", message = "Enter", commonFunc = function() TppMarkerSystem.DisableMarker{ markerId = "Marker_XOF" } end },		
		{ data = "RV_MarkerOFF", message = "Enter", commonFunc = function() TppMarkerSystem.DisableMarker{ markerId = "20010_marker_RV" } end },		
		{ data = "HostageQuiet_Trap", message = "Enter", commonFunc = function() e20010_require_01.HostageQuiet_Trap() end },
		{ data = "SpHostageMonologue", message = "Enter", commonFunc = function() e20010_require_01.SpHostageMonologue() end },
		{ data = "Hostage01Monologue", message = "Enter", commonFunc = function() e20010_require_01.Hostage01Monologue() end },
		{ data = "Hostage02Monologue", message = "Enter", commonFunc = function() e20010_require_01.Hostage02Monologue() end },
		{ data = "Hostage03Monologue", message = "Enter", commonFunc = function() e20010_require_01.Hostage03Monologue() end },
		{ data = "Hostage04Monologue", message = "Enter", commonFunc = function() e20010_require_01.Hostage04Monologue() end },
		{ data = "PazFovaChangeTrap", message = "Enter", commonFunc = function() TppEnemy.SetFormVariation( "Paz" , "fovaPazBeforeDemo" ) end },
		{ data = "demoWarpOKTrap", message = "Enter", commonFunc = function() TppMission.SetFlag( "isDemoRelativePlay", true ) end },
		{ data = "demoWarpOKTrap", message = "Exit", commonFunc = function() TppMission.SetFlag( "isDemoRelativePlay", false ) end },
		{ data = "Radio_SecurityCameraAdvice", message = "Enter", commonFunc = function() e20010_require_01.Radio_SecurityCameraAdvice() end },	
	},
	Gimmick = {
		
		{ data = "gntn_center_SwitchLight", message = "SwitchOn", commonFunc = SwitchLight_ON },	
		{ data = "gntn_center_SwitchLight", message = "SwitchOff", commonFunc = SwitchLight_OFF },	
		
		{ data = "AsyPickingDoor05", message = "DoorUnlock", commonFunc = function() TppMission.SetFlag( "isAsyPickingDoor05", true ) end },
		{ data = "AsyPickingDoor15", message = "DoorUnlock", commonFunc = function() TppMission.SetFlag( "isAsyPickingDoor15", true ) end },
		
		{ data = "WoodTurret01", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		{ data = "WoodTurret02", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		{ data = "WoodTurret03", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		{ data = "WoodTurret04", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		{ data = "WoodTurret05", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		
		{ data = "SL_WoodTurret01", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		{ data = "SL_WoodTurret02", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		{ data = "SL_WoodTurret03", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		{ data = "SL_WoodTurret04", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		{ data = "SL_WoodTurret05", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		
		{ data = "gntn_area01_searchLight_000", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		{ data = "gntn_area01_searchLight_001", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		{ data = "gntn_area01_searchLight_002", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		{ data = "gntn_area01_searchLight_003", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		{ data = "gntn_area01_searchLight_004", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		{ data = "gntn_area01_searchLight_005", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		{ data = "gntn_area01_searchLight_006", message = "BreakGimmick", commonFunc = Common_Gimmick_Break },	
		
		{ data = "gntn_area01_antiAirGun_000", message = "BreakGimmick", commonFunc = Common_AAG01_Break },	
		{ data = "gntn_area01_antiAirGun_001", message = "BreakGimmick", commonFunc = Common_AAG02_Break },	
		{ data = "gntn_area01_antiAirGun_002", message = "BreakGimmick", commonFunc = Common_AAG03_Break },	
		{ data = "gntn_area01_antiAirGun_003", message = "BreakGimmick", commonFunc = Common_AAG04_Break },	
		
		{ message = "HitTranqDamage", commonFunc = function() TppRadio.PlayEnqueue( "Miller_UnKillGunAdvice" ) end },
	},
	Radio = {
		{ data = "ComEne01", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne01" ) end },
		{ data = "ComEne02", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne02" ) end },
		{ data = "ComEne03", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne03" ) end },
		{ data = "ComEne04", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne04" ) end },
		{ data = "ComEne05", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne05" ) end },
		{ data = "ComEne06", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne06" ) end },
		{ data = "ComEne07", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne07" ) end },
		{ data = "ComEne08", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne08" ) end },
		{ data = "ComEne09", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne09" ) end },
		{ data = "ComEne10", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne10" ) end },
		{ data = "ComEne11", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne11" ) end },
		{ data = "ComEne12", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne12" ) end },
		{ data = "ComEne13", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne13" ) end },
		{ data = "ComEne14", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne14" ) end },
		{ data = "ComEne15", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne15" ) end },
		{ data = "ComEne16", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne16" ) end },
		{ data = "ComEne17", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne17" ) end },
		{ data = "ComEne18", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne18" ) end },
		{ data = "ComEne19", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne19" ) end },
		{ data = "ComEne20", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne20" ) end },
		{ data = "ComEne21", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne21" ) end },
		{ data = "ComEne22", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne22" ) end },
		{ data = "ComEne23", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne23" ) end },
		{ data = "ComEne24", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne24" ) end },
		{ data = "ComEne25", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne25" ) end },
		{ data = "ComEne26", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne26" ) end },
		{ data = "ComEne27", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne27" ) end },
		{ data = "ComEne28", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne28" ) end },
		{ data = "ComEne29", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne29" ) end },
		{ data = "ComEne30", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne30" ) end },
		{ data = "ComEne31", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne31" ) end },
		{ data = "ComEne32", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne32" ) end },
		{ data = "ComEne33", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne33" ) end },
		{ data = "ComEne34", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "ComEne34" ) end },
		{ data = "Seq10_01", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "Seq10_01" ) end },
		{ data = "Seq10_02", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "Seq10_02" ) end },
		{ data = "Seq10_03", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "Seq10_03" ) end },
		{ data = "Seq10_05", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "Seq10_05" ) end },
		{ data = "Seq10_06", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "Seq10_06" ) end },
		{ data = "Seq10_07", message = "EspionageRadioCandidate" , commonFunc = function() Common_enemyIntel( "Seq10_07" ) end },
		{ data = "SpHostage", message = "EspionageRadioPlayButton" , commonFunc = function() TppMission.SetFlag( "isSpHostageEncount", true ) end },
		{ data = "Chico", message = "EspionageRadioPlayButton" , commonFunc = function() e20010_require_01.Chico_Espion() end },
		{ data = "Paz", message = "EspionageRadioPlayButton" , commonFunc = function() e20010_require_01.Paz_Espion() end },
		{ data = "e0010_rtrg0370",		message = "RadioEventMessage", commonFunc = function() e20010_require_01.commonHeliLeaveExtension() end },
		{ data = "e0010_rtrg0380",		message = "RadioEventMessage", commonFunc = function() e20010_require_01.commonHeliLeaveExtension() end },
		{ data = "e0010_rtrg1240",		message = "RadioEventMessage", commonFunc = function() e20010_require_01.commonHeliLeaveExtension() end },
		{ data = "e0010_rtrg1220",		message = "RadioEventMessage", commonFunc = function() e20010_require_01.Tutorial_1Button("tutorial_mb_device","MB_DEVICE") end },
	},
	Terminal = {
		{ message = "MbDvcActCallRescueHeli", commonFunc = function() e20010_require_01.MbDvcActCallRescueHeli("SupportHelicopter", "MbDvc") end },	

	},
	Timer = {
		{ data = "Timer_SC_Vehicle_Clean", 		message = "OnEnd", commonFunc = function() e20010_require_01.Timer_SC_Vehicle_Clean() end },
		{ data = "Timer_EC_Truck_Clean", 		message = "OnEnd", commonFunc = function() e20010_require_01.Timer_EC_Truck_Clean() end },
		{ data = "Timer_Weapon_Truck_Clean", 	message = "OnEnd", commonFunc = function() e20010_require_01.Timer_Weapon_Truck_Clean() end },
		{ data = "Timer_Gate_Truck_Clean",	 	message = "OnEnd", commonFunc = function() e20010_require_01.Timer_Gate_Truck_Clean() end },
		{ data = "Timer_ToAsylum_Vehicle_Clean",message = "OnEnd", commonFunc = function() e20010_require_01.Timer_ToAsylum_Vehicle_Clean() end },
		{ data = "Timer_Patrol_Vehicle_Clean",	message = "OnEnd", commonFunc = function() e20010_require_01.Timer_Patrol_Vehicle_Clean() end },
		{ data = "Timer_CallCautionSiren", 		message = "OnEnd", commonFunc = function() e20010_require_01.Timer_CallCautionSiren() end },
		{ data = "Timer_RescuePaz1", 			message = "OnEnd", commonFunc = function() e20010_require_01.Radio_RescuePaz1() end },
		{ data = "Timer_RescuePaz2", 			message = "OnEnd", commonFunc = function() e20010_require_01.Radio_RescuePaz2() end },
		{ data = "Timer_MillerHistory1", 		message = "OnEnd", commonFunc = function() e20010_require_01.Radio_MillerHistory1() end },
		{ data = "Timer_Behind", 				message = "OnEnd", commonFunc = TimerBehindCount },
		{ data = "Timer_GetPazInfo", 			message = "OnEnd", commonFunc = function() e20010_require_01.Radio_GetPazInfo() end },

		{ data = "Timer_takePazToRVPoint01", 	message = "OnEnd", commonFunc = Timer_takePazToRVPoint01_OnEnd },
		{ data = "Timer_ListenTape", 			message = "OnEnd", commonFunc = function() e20010_require_01.Radio_ListenTape() end },
		{ data = "Timer_HeliCloseDoor_01",		message = "OnEnd", commonFunc = function() Radio_HeliCloseDoor("RadioSet01") end },
		{ data = "Timer_HeliCloseDoor_01b", 	message = "OnEnd", commonFunc = function() Radio_HeliCloseDoor("RadioSet01b") end },
		{ data = "Timer_HeliCloseDoor_02",		message = "OnEnd", commonFunc = function() Radio_HeliCloseDoor("RadioSet02") end },
		{ data = "Timer_HeliCloseDoor_03",		message = "OnEnd", commonFunc = function() Radio_HeliCloseDoor("RadioSet03") end },
		{ data = "Timer_HeliCloseDoor_04",		message = "OnEnd", commonFunc = function() Radio_HeliCloseDoor("RadioSet04") end },
		{ data = "Timer_HeliCloseDoor_04b", 	message = "OnEnd", commonFunc = function() Radio_HeliCloseDoor("RadioSet04b") end },
		{ data = "Timer_HeliCloseDoor_05",		message = "OnEnd", commonFunc = function() Radio_HeliCloseDoor("RadioSet05") end },
		{ data = "Timer_HeliCloseDoor_05b", 	message = "OnEnd", commonFunc = function() Radio_HeliCloseDoor("RadioSet05b") end },
		{ data = "Timer_HeliCloseDoor_06",		message = "OnEnd", commonFunc = function() Radio_HeliCloseDoor("RadioSet06") end },
		{ data = "Timer_HeliCloseDoor_07",		message = "OnEnd", commonFunc = function() Radio_HeliCloseDoor("RadioSet07") end },
		{ data = "Timer_pleaseLeaveHeli", 		message = "OnEnd", commonFunc = function() e20010_require_01.commonHeliLeaveJudge() end },
		{ data = "Timer_PlayerOnHeliAdvice", 	message = "OnEnd", commonFunc = function() e20010_require_01.Radio_PlayerOnHeliAdvice() end },
		{ data = "Timer_SwitchOFF", 			message = "OnEnd", commonFunc = Timer_SwitchOFF },
		{ data = "Timer_CarryDownInDanger", 	message = "OnEnd", commonFunc = function() e20010_require_01.Radio_CarryDownInDanger() end },
	},
	RadioCondition = {


		{ message = "PlayerHurt", commonFunc = function() TppRadio.DelayPlay( "Miller_CuarAdvice", "mid" ) end },
		{ message = "PlayerCureComplete", commonFunc = function() TppRadio.PlayEnqueue( "Miller_SpRecoveryLifeAdvice" ) end },
		{ message = "PlayerBehind", commonFunc = Common_behind },

		{ message = "SuppressorIsBroken", commonFunc = function() this.commonSuppressorIsBroken() end },
	},
	Subtitles = {
		{ data="rdps0z00_0x1010", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Tutorial_1Button("tutorial_bino","PL_SUB_CAMERA") end },		

		{ data="rdps0z00_0x1012", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Sub_rdps0z00_0x1012() end },										
		{ data="pprg1001_161010", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Tutorial_1Button("tutorial_mb_device","MB_DEVICE") end },		
		{ data="pprg1001_5u1010", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Tutorial_1Button("tutorial_advice","PL_CALL") end },			
		{ data="pprg1001_3i1010", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Tutorial_1Button("tutorial_radio","PL_CALL") end },				
		{ data="pprg1001_511010", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Tutorial_2Button("tutorial_attack","PL_HOLD","PL_SHOT") end },	
		{ data="pprg1001_5l1010", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Tutorial_1Button("tutorial_climeb_up","PL_ACTION") end },		
		{ data="pprg1001_261110", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Tutorial_1Button("tutorial_mb_device","MB_DEVICE") end },		

		{ data="rdps1001_111010", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Sub_rdps1001_111010() end },										
		{ data="pprg1001_3k1010", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Tutorial_1Button("tutorial_cqc","PL_CQC") end },				
		{ data="rdps1000_181015", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Sub_RDPS1000_181015() end },	
		{ data="ENQT1000_1m1310", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Sub_ENQT1000_1m1310() end },	
		{ data="sltb0z10_5y1010", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Sub_SLTB0z10_5y1010() end },	
		{ data="rdps2110_141010", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Sub_rdps2110_141010() end },	
		{ data="prsn1000_2q1012", message = "SubtitlesFinishedEventMessage", commonFunc = function() e20010_require_01.SpHostageInformation() end },
	},
	Demo = {
		{ data="p11_020001_000", message="invis_cam", commonFunc = function() TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20010_SecurityCamera_02", false ) end },
		{ data="p11_020001_000", message="lightOff", commonFunc = function() TppGadgetUtility.SetSwitch("gntn_center_SwitchLight",false) end },
		{ data="p11_020001_000", message="lightOn", commonFunc = function() TppGadgetUtility.SetSwitch("gntn_center_SwitchLight",true) end },
		{ data="p11_020005_000", message="open_gate", commonFunc = OpenGateRouteChange },
	},
	UI = {
		{ message = "GetAllCassetteTapes" , commonFunc = function() TppRadio.DelayPlayEnqueue("Miller_AllGetTape", "mid" ) end },	
	},
}



local myMessages = {
	Character = {
		{ data = "gntn_cp", message = "EnemyRestraint", commonFunc = function() e20010_require_01.Radio_QustionAdvice() end },			
		{ data = "Player", message = "OnBinocularsMode", commonFunc = function() e20010_require_01.Radio_BinocularsTutorial() end },	
		{ data = "ComEne15", message = "MessageRoutePoint", commonFunc = function() e20010_require_01.Select_ComEne15_NodeAction() end },	
	},
	Trap = {
		{ data = "DuctMarkerOFF", message = "Enter", commonFunc = function() TppMarkerSystem.DisableMarker{ markerId = "Marker_Duct" } end },				
		{ data = "Radio_SwitchLight", message = "Enter", commonFunc = function() TppRadio.DelayPlayEnqueue( "Miller_SwitchLightAdvice02", "short" ) end },	
		{ data = "Radio_SwitchLightAdvice", message = "Enter", commonFunc = function() e20010_require_01.Select_SwitchLightAdvice() end },					
		{ data = "Radio_NearRvEscapedTarget", message = "Enter", commonFunc = function() e20010_require_01.Radio_NearRvEscapedTarget() end },				
		{ data = "Radio_InCenterAdvice", message = "Enter", commonFunc = function()  end },	
		{ data = "Radio_SearchChico", message = "Enter", commonFunc = function() e20010_require_01.Radio_SearchChico() end },								
		{ data = "Radio_MillerHistory2", message = "Enter", commonFunc = function() e20010_require_01.Radio_DramaChico() end },								
		{ data = "Radio_InOldAsylum", message = "Enter", commonFunc = function() TppRadio.DelayPlayEnqueue( "Miller_InOldAsylum", "short" ) end },			
		{ data = "Radio_PaztakeRoute_HeliPort", message = "Exit", commonFunc = function() e20010_require_01.Radio_Cheer() end },							
		{ data = "Talk_Helipad02", message = "Enter", commonFunc = function() e20010_require_01.Talk_Helipad02() end },
	},
	Timer = {
	},
	RadioCondition = {
		{ message = "EnableCQC", commonFunc = function() e20010_require_01.Radio_CQCTutorial() end },
		{ message = "PlayerElude", commonFunc = function() e20010_require_01.Common_Elude() end },
		{ message = "PlayerCrawl", commonFunc = function() this.commmonPlayerCrawl() end },
	},
}



this.commonMissionFailure = function( manager, messageId, message )

	local hudCommonData = HudCommonDataManager.GetInstance()
	local radioDaemon = RadioDaemon:GetInstance()

	
	radioDaemon:StopDirectNoEndMessage()
	
	SubtitlesCommand.StopAll()
	
	TppEnemyUtility.IgnoreCpRadioCall(true)	
	TppEnemyUtility.StopAllCpRadio( 0.5 )	
	
	TppSoundDaemon.SetMute( 'GameOver' )
	
	this.CounterList.GameOverFadeTime = GZCommon.FadeOutTime_MissionFailed

	
	
	if( message == "HeliLostControl" )	then
		
		if( TppMission.GetFlag( "isPlayerOnHeli" ) == true ) then
			SetGameOverTimeParadox()									
			this.CounterList.GameOverRadioName = "Miller_DeadPlayer"	
			TppSequence.ChangeSequence( "Seq_Mission_Failed" )	

		
		elseif( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true and
				TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) then
			SetGameOverMissionFailed()										
			this.CounterList.GameOverRadioName = "Miller_StopMission"			
			TppSequence.ChangeSequence( "Seq_Mission_Failed" )	
			
			hudCommonData:CallFailedTelop( "gameover_reason_target_died" )	  
		
		elseif( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then
			SetGameOverMissionFailed()										
			this.CounterList.GameOverRadioName = "Miller_HeliDownPaz"			
			TppSequence.ChangeSequence( "Seq_Mission_Failed" )				
			
			hudCommonData:CallFailedTelop( "gameover_reason_target_died" )

		
		elseif( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) then
			SetGameOverMissionFailed()										
			this.CounterList.GameOverRadioName = "Miller_HeliDownChico"			
			TppSequence.ChangeSequence( "Seq_Mission_Failed" )	
			
			hudCommonData:CallFailedTelop( "gameover_reason_target_died" )	  

		
		else
			TppSequence.ChangeSequence( "Seq_HelicopterDeadNotOnPlayer" )
			
			hudCommonData:CallFailedTelop( "gameover_reason_heli_destroyed" )    
		end
	elseif( message == "HeliLostControl_PlayerAttack" )	then
		
		if( TppMission.GetFlag( "isPlayerOnHeli" ) == true ) then
			SetGameOverTimeParadox()									
			this.CounterList.GameOverRadioName = "Miller_DeadPlayer"	
			TppSequence.ChangeSequence( "Seq_Mission_Failed" )	

		
		elseif( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true and
				TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) then
			SetGameOverMissionFailed()										
			this.CounterList.GameOverRadioName = "Miller_HeliKill"			
			TppSequence.ChangeSequence( "Seq_Mission_Failed" )	
			
			hudCommonData:CallFailedTelop( "gameover_reason_target_died" )    
		
		elseif( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then
			SetGameOverMissionFailed()										
			this.CounterList.GameOverRadioName = "Miller_KillPaz"			
			TppSequence.ChangeSequence( "Seq_Mission_Failed" )				
			
			hudCommonData:CallFailedTelop( "gameover_reason_target_died" )

		
		elseif( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) then
			SetGameOverMissionFailed()										
			this.CounterList.GameOverRadioName = "Miller_KillChoco"			
			TppSequence.ChangeSequence( "Seq_Mission_Failed" )	
			
			hudCommonData:CallFailedTelop( "gameover_reason_target_died" )    

		
		else
			TppSequence.ChangeSequence( "Seq_HelicopterDeadNotOnPlayer" )
			
			hudCommonData:CallFailedTelop( "gameover_reason_heli_destroyed" )    
		end
	
	elseif( message == "ChicoDead" )  then
		if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) then	
			this.CounterList.GameOverFadeTime = 1.0							
		else
			
		end
		
		SetGameOverMissionFailed()										
		this.CounterList.GameOverRadioName = "Miller_DeadChico"			
		GZCommon.PlayCameraAnimationOnChicoPazDead("Chico")
		TppSequence.ChangeSequence( "Seq_Mission_Failed" )				
		
		hudCommonData:CallFailedTelop( "gameover_reason_target_died" )	  

	
	elseif( message == "PazDead" )	then
		if( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then	
			this.CounterList.GameOverFadeTime = 1.0							
		else
			
		end
		
		SetGameOverMissionFailed()										
		this.CounterList.GameOverRadioName = "Miller_DeadPaz"			
		GZCommon.PlayCameraAnimationOnChicoPazDead("Paz")
		TppSequence.ChangeSequence( "Seq_Mission_Failed" )				
		
		hudCommonData:CallFailedTelop( "gameover_reason_target_died" )

	
	elseif( message == "MissionAreaOut" )  then
		SetGameOverMissionFailed()										
		GZCommon.OutsideAreaCamera()									
		this.CounterList.GameOverRadioName = "Miller_OutofMissionArea"	
		TppSequence.ChangeSequence( "Seq_Mission_Failed" )				
		
		hudCommonData:CallFailedTelop( "gameover_reason_mission_outside" )

	
	elseif( message == "PlayerDead" )	then
		SetGameOverTimeParadox()										
		this.CounterList.GameOverRadioName = "Miller_DeadPlayer"		
		TppSequence.ChangeSequence( "Seq_Mission_Failed" )	
	
	elseif( message == "PlayerFallDead" )	then
		SetGameOverTimeParadox()										
		this.CounterList.GameOverRadioName = "Miller_DeadPlayer"		
		this.CounterList.GameOverFadeTime = GZCommon.FadeOutTime_PlayerFallDead		
		TppSequence.ChangeSequence( "Seq_Mission_Failed" )	
	
	elseif( message == "PlayerOnHeli" )	then
		SetGameOverMissionFailed()										
		this.CounterList.GameOverRadioName = "Miller_OnlyPcOnHeli"		
		TppSequence.ChangeSequence( "Seq_Mission_Failed" )	
		
		hudCommonData:CallFailedTelop( "gameover_reason_mission_abort" )
	end
end



this.commonMissionClear = function( manager, messageId, message )

	
	if( message == "RideHeli_Clear" )  then
		
		TppSequence.ChangeSequence( "Seq_Mission_Telop" )
	else
	end
end



this.Pre_commonMissionCleanUp = function()

	
	local uiCommonData = UiCommonDataManager.GetInstance()
	uiCommonData:ShowAllCassetteTapes()
	
	TppRadioCommand.SetEnableDisableRadioWhileChico3TapeIsPlaying( false )
	
	this.commonMissionCleanUp()
end




this.commonMissionCleanUp = function()

	GzRadioSaveData.ResetSaveRadioId()
	GzRadioSaveData.ResetSaveEspionageId()
	local radioManager = RadioDaemon:GetInstance()
	radioManager:DisableAllFlagIsMarkAsRead()
	radioManager:ResetRadioGroupAndGroupSetAlreadyReadFlag()
	TppRadioConditionManagerAccessor.Unregister( "Tutorial" )
	TppRadioConditionManagerAccessor.Unregister( "Basic" )

	
	GZCommon.MissionCleanup()
	
end




	
	local All_Seq_MissionAreaOut = function()
		if( TppMission.GetFlag( "isPlayerOnHeli" ) == true ) then
			
		else
			TppMission.OnLeaveInnerArea( function() TppRadio.Play( "Miller_MissionAreaOut" ) end )
			TppMission.OnLeaveOuterArea( function() TppMission.ChangeState( "failed", "MissionAreaOut" ) end )	
		end
	end


	
	local Seq_NextRescuePaz_NoChicoTapeStartExec = function()

		
		TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide01b" )
		TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide01c" )
		TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide01d" )
		TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide02b" )
		TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide02c" )
		TppEnemy.DisableRoute( this.cpID , "GoToKillSpHostage" )
		TppEnemy.DisableRoute( this.cpID , "S_Driver03b" )
		TppEnemy.DisableRoute( this.cpID , "S_Boilar03d" )
		TppEnemy.DisableRoute( this.cpID , "S_Boilar04d" )
		TppEnemy.DisableRoute( this.cpID , "S_Boilar03e" )
		TppEnemy.DisableRoute( this.cpID , "S_Boilar04e" )
	end
	
	local Seq_NextRescuePaz_GetChicoTapeStartExec = function()
		


		TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide01c" )
		TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide01d" )
		TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide02c" )
		TppEnemy.DisableRoute( this.cpID , "GoToKillSpHostage" )
		TppEnemy.DisableRoute( this.cpID , "S_Driver03b" )
	end





this.Seq_RescueHostages = {

	Messages = {
		Character = {
			myMessages.Character[1],
			myMessages.Character[2],
			myMessages.Character[3],
			{ data = "gntn_cp", message = "EndGroupVehicleRouteMove", localFunc = "Seq10_VehicleFailed" },
			{ data = "gntn_cp", message = "VehicleMessageRoutePoint", localFunc = "Seq10_VehicleMessageRoutePoint" },
			{ data = "gntn_cp", message = "ConversationEnd", localFunc = "local_Seq10_ConversationEnd" },	
			{ data = "Seq10_01",	message = "MessageRoutePoint",	localFunc = "Seq10_01_NodeAction" },	
			{ data = "Seq10_02",	message = "MessageRoutePoint",	localFunc = "Seq10_02_NodeAction" },	
			{ data = "Seq10_03",	message = "MessageRoutePoint",	localFunc = "Seq10_03_NodeAction" },	
			{ data = "Seq10_06",	message = "MessageRoutePoint",	localFunc = "Seq10_06_NodeAction" },	
			{ data = "Seq10_07",	message = "MessageRoutePoint",	localFunc = "Seq10_07_NodeAction" },	
			{ data = "ComEne01",	message = "MessageRoutePoint",	localFunc = "ComEne01_NodeAction" },	
			{ data = "ComEne03",	message = "MessageRoutePoint",	localFunc = "ComEne03_NodeAction" },	
			{ data = "ComEne05",	message = "MessageRoutePoint",	localFunc = "ComEne05_NodeAction" },	
			{ data = "ComEne06",	message = "MessageRoutePoint",	localFunc = "ComEne06_NodeAction" },	
			{ data = "ComEne08",	message = "MessageRoutePoint",	localFunc = "ComEne08_NodeAction" },	
			{ data = "ComEne09",	message = "MessageRoutePoint",	localFunc = "ComEne09_NodeAction" },	
			{ data = "ComEne13",	message = "MessageRoutePoint",	localFunc = "ComEne13_NodeAction" },	
			{ data = "ComEne14",	message = "MessageRoutePoint",	localFunc = "ComEne14_NodeAction" },	
			{ data = "ComEne18",	message = "MessageRoutePoint",	localFunc = "ComEne18_NodeAction" },	
			{ data = "ComEne19",	message = "MessageRoutePoint",	localFunc = "ComEne19_NodeAction" },	
			{ data = "ComEne21",	message = "MessageRoutePoint",	localFunc = "ComEne21_NodeAction" },	
			{ data = "ComEne25",	message = "MessageRoutePoint",	localFunc = "ComEne25_NodeAction" },	
			{ data = "ComEne29",	message = "MessageRoutePoint",	localFunc = "ComEne29_NodeAction" },	
			{ data = "Player", message = "TryPicking", localFunc = "Seq_RescueDemo_OnlyOnce"  },
		},
		Trap = {
			myMessages.Trap[1],
			myMessages.Trap[2],
			myMessages.Trap[3],

			myMessages.Trap[6],
			myMessages.Trap[7],
			{ data = "Radio_MillerHistory2", message = "Exit", commonFunc = function() TppMission.SetFlag( "isAsylumRadioArea", false ) end },
			{ data = "Talk_Helipad01", message = "Enter", localFunc = "Talk_Helipad01" },
			myMessages.Trap[8],
			myMessages.Trap[10],
			
			
			{ data = "Radio_ChangePostureAdvice", message = "Enter", localFunc = "Radio_ChangePostureAdvice" },
			{ data = "Radio_ChangePostureReAdvice", message = "Enter", commonFunc = function() TppRadio.DelayPlayEnqueue( "Miller_ChangePostureAdvice", "short" ) end },
			{ data = "Radio_MoveAsylumAnounce", message = "Enter", localFunc = "Radio_MoveAsylum" },
			{ data = "Radio_StepON", message = "Enter", commonFunc = function() TppRadio.Play( "Miller_StepOnAdvice" ) end },
			{ data = "Radio_SpHostageDiscovery", message = "Enter", localFunc = "Radio_SpHostageDiscovery" },
			{ data = "Radio_NoKillGunAdvice", message = "Enter", localFunc = "Radio_TranquilizerGunAdvice" },

		
			{ data = "Radio_CliffAttention", message = "Enter", commonFunc = function() TppRadio.Play( "Miller_CliffAttention" ) end },
			{ data = "Radio_Rain", message = "Enter", commonFunc = function() e20010_require_01.OnVehicleCheckRadioPlayEnqueue("Miller_Rain", "mid" ) end },

			{ data = "Radio_DramaPaz", message = "Enter", commonFunc = function() e20010_require_01.Radio_DramaPaz() end },
			{ data = "Radio_DramaPaz", message = "Exit", commonFunc = function() TppMission.SetFlag( "isDramaPazArea", false ) end },
			{ data = "Radio_CallAdvice", message = "Exit", commonFunc = function() TppRadio.DelayPlayEnqueue( "Miller_CallAdvice", "short" ) end },
			{ data = "Radio_PaztakeRoute_HeliPort", message = "Enter", commonFunc = function() e20010_require_01.Radio_helipad() end },
			{ data = "Radio_InOldAsylum", message = "Enter", commonFunc = function() e20010_require_01.OptionalRadio_InOldAsylum() end },								
			{ data = "Radio_InOldAsylum", message = "Exit", commonFunc = function() e20010_require_01.OptionalRadio_OutOldAsylum("Optional_GameStartToRescue") end },	
			{ data = "Radio_StartCliff", message = "Enter", commonFunc = function() e20010_require_01.Radio_StartCliffTimer() end },		
			{ data = "Radio_StartCliff", message = "Exit", commonFunc = function() GkEventTimerManager.Stop( "Timer_StartCliff" ) end },	
			{ data = "Radio_InCenterCoverAdvice", message = "Enter", localFunc = "Radio_RescuePazTimerStop" },								
			
			{ data = "Demo_EncounterChico", message = "Enter", commonFunc = function() Demo_eneChecker("chico") end },
			{ data = "Demo_EncounterPaz", message = "Enter", commonFunc = function() Demo_eneChecker("paz") end },
		},
		Timer = {
			{ data = "Timer_StartCliff", message = "OnEnd", commonFunc = function() e20010_require_01.Radio_StartCliff() end },
		},
		Terminal = {
			{ message = "MbDvcActWatchPhoto", commonFunc = function() e20010_require_01.Mb_WatchPhoto() end },
		},
		Radio = {
			{ data = "intel_e0010_esrg0020", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "intel_e0010_esrg0030", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "intel_e0010_esrg0040", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
	
			{ data = "intel_e0010_esrg0090", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
	
			{ data = "intel_e0010_esrg0110", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "intel_e0010_esrg0120", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "intel_e0010_esrg0190", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "intel_e0010_esrg0380", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "intel_e0010_esrg0440", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "intel_e0010_esrg0440_1", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "intel_e0010_esrg0450", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "intel_e0010_esrg0450_1", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "intel_e0010_esrg0450_2", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "intel_e0010_esrg0490", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "Paz", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "Chico", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntn_area01_antiAirGun_000", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntn_area01_antiAirGun_001", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntn_area01_antiAirGun_002", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntn_area01_antiAirGun_003", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "WoodTurret01", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "WoodTurret02", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "WoodTurret03", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "WoodTurret04", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "WoodTurret05", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
	
			{ data = "Tactical_Vehicle_WEST_002", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "Tactical_Vehicle_WEST_003", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "Tactical_Vehicle_WEST_004", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "Tactical_Vehicle_WEST_005", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "Cargo_Truck_WEST_002", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "Cargo_Truck_WEST_003", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "Cargo_Truck_WEST_004", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "Armored_Vehicle_WEST_001", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },


	
	
			{ data = "e20010_drum0025", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "e20010_drum0027", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "e20010_drum0040", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "e20010_drum0042", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0002", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0005", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0011", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0012", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0015", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0019", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0020", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0021", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0022", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0023", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0024", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0025", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0027", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0028", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0029", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0030", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0031", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0035", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0037", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0038", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0039", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0040", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0041", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0042", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0043", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0044", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0045", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0046", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0047", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0048", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0065", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0066", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0068", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0069", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0070", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0071", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0072", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntnCom_drum0101", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "SL_WoodTurret01", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "SL_WoodTurret02", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "SL_WoodTurret03", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "SL_WoodTurret04", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "SL_WoodTurret05", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntn_area01_searchLight_000", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntn_area01_searchLight_001", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntn_area01_searchLight_002", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntn_area01_searchLight_003", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntn_area01_searchLight_004", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntn_area01_searchLight_005", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
			{ data = "gntn_area01_searchLight_006", message = "EspionageRadioCandidate" , commonFunc = function() TppRadio.PlayEnqueue( "Miller_EspionageRadioAdvice" ) end },
		},
		RadioCondition = {
			myMessages.RadioCondition[1],	
			myMessages.RadioCondition[2],	
			myMessages.RadioCondition[3],	
		},
		Marker = {
			{ message = "ChangeToEnable",	commonFunc = function() this.commonMarkerEnable() end },	
		},
	},

	OnEnter = function( manager )
		
		WoodTurret_RainFilter_OFF()
		
		TppSupportHelicopterService.SetDefaultRendezvousPointMarker("no_lz")
		
		MissionStartTelopTimerStart()		
		
		TppMission.SetFlag( "isFirstEncount_Chico", false )
		
		ChicoDoor_ON_Close()
		PazDoor_ON_Close()
		
		commonUiMissionSubGoalNo(1)
		
		TppMusicManager.ClearParameter()
		TppMusicManager.SetSwitch{
			groupName = "bgm_phase_ct_level",
			stateName = "bgm_phase_ct_level_01",
		}
		
		EnablePhoto()
		
		Seq10Trap_Enable()
		Seq10_20Trap_Enable()
		Seq20Trap_Disable()
		Seq30Trap_Disable()
		Seq40Trap_Disable()
		
		TppHostageUtility.SetHostageStatusInCp( "gntn_cp", "SpHostage", "HOSTAGE_STATUS_LOST" )
		
		ChengeChicoPazIdleMotion()
		
		Seq10Enemy_Enable()
		Seq20Enemy_Disable()
		Seq30Enemy_Disable()
		Seq40Enemy_Disable()
		
		TppMarkerSystem.DisableMarker{ markerId = "Tactical_Vehicle_WEST_003" }
		TppData.Disable( "Tactical_Vehicle_WEST_003" )
		TppMarkerSystem.DisableMarker{ markerId = "Tactical_Vehicle_WEST_004" }
		TppData.Disable( "Tactical_Vehicle_WEST_004" )
		TppMarkerSystem.DisableMarker{ markerId = "Tactical_Vehicle_WEST_005" }
		TppData.Disable( "Tactical_Vehicle_WEST_005" )
		TppMarkerSystem.DisableMarker{ markerId = "Armored_Vehicle_WEST_002" }
		TppData.Disable( "Armored_Vehicle_WEST_002" )
		TppMarkerSystem.DisableMarker{ markerId = "Armored_Vehicle_WEST_003" }
		TppData.Disable( "Armored_Vehicle_WEST_003" )
		TppMarkerSystem.DisableMarker{ markerId = "Cargo_Truck_WEST_004" }
		TppData.Disable( "Cargo_Truck_WEST_004" )
		
		TppData.Enable( "Armored_Vehicle_WEST_001" )
		TppData.Enable( "Cargo_Truck_WEST_002" )
		TppData.Enable( "Cargo_Truck_WEST_003" )
		TppData.Enable( "Tactical_Vehicle_WEST_002" )
		
		Seq_RescueHostages_RouteSet()
		
		Setting_Seq_RescueHostages_RouteSet()
		
		Setting_RealizeEnable()
		
		All_Seq_MissionAreaOut()
		
		Asylum_MarkerON()	

		
	
	
	
		
		GuardTarget_Setting()

		
		SetIntelRadio()
		
		SetOptionalRadio()

		
		local radioDaemon = RadioDaemon:GetInstance()
		if( TppMission.GetFlag( "isMissionStartRadio" ) == false ) then
			TppRadio.DelayPlay( "Miller_MissionStart", 2.8 )
		else
			TppRadio.DelayPlay( "Miller_MissionContinue", 2.8 )
		end
		TppMission.SetFlag( "isMissionStartRadio", true )
	end,
	
	Seq10_VehicleFailed = function()

		local VehicleGroupInfo			= TppData.GetArgument(2)
		local VehicleGroupInfoName		= VehicleGroupInfo.routeInfoName
		local VehicleGroupResult		= VehicleGroupInfo.result
		local VehicleGroupReason		= VehicleGroupInfo.reason

		if( VehicleGroupInfoName == "TppGroupVehicleRouteInfo_Seq10_01" ) then
			if( VehicleGroupResult == "SUCCESS" ) then
				
			else	
				TppMission.SetFlag( "isSeq10_02_DriveEnd", 1 )
				TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_02" , false )
				TppEnemy.EnableRoute( this.cpID , "Seq10_02_VehicleFailed_Route" )
				TppEnemy.DisableRoute( this.cpID , "Seq10_02_RideOnVehicle" )
				TppEnemy.ChangeRoute( this.cpID , "Seq10_02","e20010_Seq10_SneakRouteSet","Seq10_02_VehicleFailed_Route", 0 )
				EastCampMoveTruck_Start()		
				TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "EastCampMoveTruck_Start", false , false )
			end
		elseif( VehicleGroupInfoName == "TppGroupVehicleRouteInfo_Seq10_02" ) then
			if( VehicleGroupResult == "SUCCESS" ) then
				
			else	
				TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_01" , false )
				TppEnemy.EnableRoute( this.cpID , "Seq10_01_VehicleFailed_Route" )
				TppEnemy.DisableRoute( this.cpID , "S_GoToExWeaponTruck" )
				TppEnemy.ChangeRoute( this.cpID , "Seq10_01","e20010_Seq10_SneakRouteSet","Seq10_01_VehicleFailed_Route", 0 )
			end
		elseif( VehicleGroupInfoName == "TppGroupVehicleRouteInfo_Seq10_03" ) then
			if( VehicleGroupResult == "SUCCESS" ) then
				
			else	
				TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_03" , false )
				TppEnemy.EnableRoute( this.cpID , "Seq10_02_VehicleFailed_Route" )
				TppEnemy.DisableRoute( this.cpID , "S_Seq10_03_RideOnTruck" )
				TppEnemy.ChangeRoute( this.cpID , "Seq10_03","e20010_Seq10_SneakRouteSet","Seq10_02_VehicleFailed_Route", 0 )
			end
		end
	end,
	
	Seq10_VehicleMessageRoutePoint = function()

		local PlayerRaidVehicleId	= TppPlayerUtility.GetRidingVehicleCharacterId()	
		local vehicleGroupInfo		= TppData.GetArgument(2)							
		local vehicleInfoName		= vehicleGroupInfo.routeInfoName					
		local vehicleCharaID		= vehicleGroupInfo.vehicleCharacterId				
		local routeID				= vehicleGroupInfo.vehicleRouteId					
		local routeNodeIndex		= vehicleGroupInfo.passedNodeIndex					
		local memberCharaIDs		= vehicleGroupInfo.memberCharactorIds				
		local result 				= vehicleGroupInfo.result							
		local reason				= vehicleGroupInfo.reason							

		
		if ( vehicleInfoName == "TppGroupVehicleRouteInfo_Seq10_02" ) then
			if ( routeID == GsRoute.GetRouteId( "Truck_onRaid_Seq10_01" )) and ( routeNodeIndex == 12 ) then
				AnounceLog_enemyDecrease()	
				TppEnemyUtility.SetEnableCharacterId( "Seq10_01" , false )
				TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_01" , false )
				
				if ( vehicleCharaID == "Cargo_Truck_WEST_002" ) then
					
					if( PlayerRaidVehicleId == "Cargo_Truck_WEST_002" ) then
						
					
					else
						TppMarkerSystem.DisableMarker{ markerId = "Cargo_Truck_WEST_002" }
						TppData.Disable( "Cargo_Truck_WEST_002" )
					end
				
				elseif ( vehicleCharaID == "Cargo_Truck_WEST_003" ) then
					
					if( PlayerRaidVehicleId == "Cargo_Truck_WEST_003" ) then
						
					
					else
						TppMarkerSystem.DisableMarker{ markerId = "Cargo_Truck_WEST_003" }
						TppData.Disable( "Cargo_Truck_WEST_003" )
					end
				
				else
					
				end
			end
		
		elseif ( vehicleInfoName == "TppGroupVehicleRouteInfo_Seq10_03" ) then
			if ( routeID == GsRoute.GetRouteId( "Truck_onRaid_Seq10_03" )) and ( routeNodeIndex == 18 ) then
				TppMission.SetFlag( "isSeq10_03_DriveEnd", 1 )
				AnounceLog_enemyDecrease()	
				TppEnemyUtility.SetEnableCharacterId( "Seq10_03" , false )
				TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_03" , false )
				
				if ( vehicleCharaID == "Cargo_Truck_WEST_003" ) then
					
					if( PlayerRaidVehicleId == "Cargo_Truck_WEST_003" ) then
						
					
					else
						TppMarkerSystem.DisableMarker{ markerId = "Cargo_Truck_WEST_003" }
						TppData.Disable( "Cargo_Truck_WEST_003" )
					end
				
				elseif ( vehicleCharaID == "Cargo_Truck_WEST_002" ) then
					
					if( PlayerRaidVehicleId == "Cargo_Truck_WEST_002" ) then
						
					
					else
						TppMarkerSystem.DisableMarker{ markerId = "Cargo_Truck_WEST_002" }
						TppData.Disable( "Cargo_Truck_WEST_002" )
					end
				
				else
					
				end
			end
		else
			
		end
	end,
	
	local_Seq10_ConversationEnd = function()
		local label		= TppData.GetArgument(2)
		local judge		= TppData.GetArgument(4)
		if ( label == "CTE0010_0010") then
			TppEnemy.EnableRoute( this.cpID , "S_GoTo_EastCamp" ) 	
			TppEnemy.EnableRoute( this.cpID , "GoToWestCamp_TalkWeapon" ) 	
			TppEnemy.DisableRoute( this.cpID , "S_Pre_ExWeaponTalk_a" )	
			TppEnemy.DisableRoute( this.cpID , "S_Pre_ExWeaponTalk_b" )	
			TppEnemy.ChangeRoute( this.cpID , "ComEne01","e20010_Seq10_SneakRouteSet","S_GoTo_EastCamp", 0 )	
			TppEnemy.ChangeRoute( this.cpID , "ComEne03","e20010_Seq10_SneakRouteSet","GoToWestCamp_TalkWeapon", 0 )	
		elseif ( label == "CTE0010_0260") then
			TppEnemy.EnableRoute( this.cpID , "S_GoToExWeaponTruck" ) 	
			TppEnemy.EnableRoute( this.cpID , "S_Sen_WestCamp_WestGate2" ) 	
			TppEnemy.DisableRoute( this.cpID , "GoToWestCamp_TalkWeapon" )	
			TppEnemy.ChangeRoute( this.cpID , "Seq10_01","e20010_Seq10_SneakRouteSet","S_GoToExWeaponTruck", 0 )	
			TppEnemy.ChangeRoute( this.cpID , "ComEne03","e20010_Seq10_SneakRouteSet","S_Sen_WestCamp_WestGate2", 0 )	
		elseif ( label == "CTE0010_0310") then

			local LightState	= TppGadgetManager.GetGadgetStatus( "gntn_center_SwitchLight" )

			if ( judge == true ) then
				if( TppMission.GetFlag( "isCTE0010_0310_NearArea" ) == true ) then
					local uiCommonData = UiCommonDataManager.GetInstance()
					
					if uiCommonData:IsHaveCassetteTape( "tp_chico_05" ) then
						TppRadio.Play( "Miller_MarkingExhaveTape" )
					else	
						local onRadioStart = function()
							Cassette_MarkerOn()
						end
						local onRadioEnd = function()
							AnounceLog_MapUpdate()
						end
						TppRadio.Play("Miller_MarkingExTape" , { onStart = onRadioStart, onEnd = onRadioEnd } )
					end
				else
				end
			else
			end
			TppEnemy.EnableRoute( this.cpID , "S_Mov_CenterHouse_a" ) 	
			TppEnemy.EnableRoute( this.cpID , "S_Mov_CenterHouse_b" ) 	
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_a" ) 	
			TppEnemy.DisableRoute( this.cpID , "S_Talk_ChicoTape" )	
			TppEnemy.DisableRoute( this.cpID , "S_Pre_ChikcoTapeTalk_c" )	
			TppEnemy.DisableRoute( this.cpID , "S_Pre_ChikcoTapeTalk_d" )	
			TppEnemy.ChangeRoute( this.cpID , "ComEne32","e20010_Seq10_SneakRouteSet","S_Sen_Boilar_a",0 )	
			TppEnemy.ChangeRoute( this.cpID , "Seq10_06","e20010_Seq10_SneakRouteSet","S_Mov_CenterHouse_a",0 )	
			TppEnemy.ChangeRoute( this.cpID , "Seq10_07","e20010_Seq10_SneakRouteSet","S_Mov_CenterHouse_b",0 )	
			TppMission.SetFlag( "isTalkChicoTapeFinish", true )
			
			if ( LightState == 2 ) then			
				TppEnemy.EnableRoute( this.cpID , "ComEne31_SwitchOFF" ) 		
				TppEnemy.DisableRoute( this.cpID , "S_Pre_ChikcoTapeTalk_b" )	
				TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_b" )			
				TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq10_SneakRouteSet","ComEne31_SwitchOFF",0 )	
			else								
				TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_b" ) 			
				TppEnemy.DisableRoute( this.cpID , "S_Pre_ChikcoTapeTalk_b" )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq10_SneakRouteSet","S_Sen_Boilar_b",0 )	
			end

		elseif ( label == "CTE0010_0130") then
			TppEnemy.EnableRoute( this.cpID , "S_GoTo_SeaSideEnter" ) 	
			TppEnemy.EnableRoute( this.cpID , "S_GoTo_EastCampNorthTower" ) 	
			TppEnemy.DisableRoute( this.cpID , "S_RainTalk_ComEne05" ) 	
			TppEnemy.DisableRoute( this.cpID , "S_Pre_RainTalk_b" ) 	
			TppEnemy.ChangeRoute( this.cpID , "ComEne05","e20010_Seq10_SneakRouteSet","S_GoTo_SeaSideEnter", 0 )
			TppEnemy.ChangeRoute( this.cpID , "ComEne06","e20010_Seq10_SneakRouteSet","S_GoTo_EastCampNorthTower", 0 )
		elseif ( label == "CTE0010_0350") then
			TppEnemy.EnableRoute( this.cpID , "S_GoToSearchEscapeHostage_a" ) 	
			TppEnemy.EnableRoute( this.cpID , "S_GoToSearchEscapeHostage_b" ) 	
			TppEnemy.DisableRoute( this.cpID , "S_Talk_EscapeHostage" )			
			TppEnemy.DisableRoute( this.cpID , "S_Pre_EscapeHostageTalk_b" )	
			TppEnemy.ChangeRoute( this.cpID , "ComEne13","e20010_Seq10_SneakRouteSet","S_GoToSearchEscapeHostage_a",0 )	
			TppEnemy.ChangeRoute( this.cpID , "ComEne14","e20010_Seq10_SneakRouteSet","S_GoToSearchEscapeHostage_b",0 )	
		end
	end,
	
	ComEne08_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_GunTutorial_Route" )) then
			if( RoutePointNumber == 0 ) then										
				local radioDaemon = RadioDaemon:GetInstance()
				if( TppMission.GetFlag( "isGunTutorialArea" ) == true and radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0960") == false ) then			
					TppRadio.Play( "Miller_EnemyCopeOnlyVersion" )
				elseif( TppMission.GetFlag( "isGunTutorialArea" ) == true and TppMission.GetFlag( "isDoneCQC" ) == false ) then			
					TppRadio.Play( "Miller_EnemyCopeOnlyCQC" )
					TppMission.SetFlag( "isDoneCQC", true )
				else																
				end
			elseif( RoutePointNumber == 11 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumBehind" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_GunTutorial_Route" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne08","e20010_Seq10_SneakRouteSet","S_Sen_AsylumBehind", 0 )	
			end
		else
		end
	end,
	
	Seq10_01_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)

		if ( RouteName ==  GsRoute.GetRouteId( "Seq10_01_VehicleFailed_Route" )) then
			if( RoutePointNumber == 8 ) then
					AnounceLog_enemyDecrease()	
					TppEnemyUtility.SetEnableCharacterId( "Seq10_01" , false )
					TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_01" , false )
			else
			end
		else
		end
	end,
	
	Seq10_02_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		local VehicleId = TppPlayerUtility.GetRidingVehicleCharacterId()

		if ( RouteName ==  GsRoute.GetRouteId( "Vehicle_onRaid_Seq10_02" )) then
			if( RoutePointNumber == 16 ) then
				if( VehicleId == "Tactical_Vehicle_WEST_002" ) then
					
					
				else
					AnounceLog_enemyDecrease()	
					TppEnemyUtility.SetEnableCharacterId( "Seq10_02" , false )
					TppMarkerSystem.DisableMarker{ markerId = "Tactical_Vehicle_WEST_002" }
					TppData.Disable( "Tactical_Vehicle_WEST_002" )
					TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_02" , false )
					TppMission.SetFlag( "isSeq10_02_DriveEnd", 1 )
					EastCampMoveTruck_Start()		
					TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "EastCampMoveTruck_Start", false , false )
				end
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "Seq10_02_VehicleFailed_Route" )) then
			if( RoutePointNumber == 5 ) then
				AnounceLog_enemyDecrease()	
				TppEnemyUtility.SetEnableCharacterId( "Seq10_02" , false )
				TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_02" , false )
			else
			end
		else
		end
	end,
	
	Seq10_03_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)

		if ( RouteName ==  GsRoute.GetRouteId( "Seq10_02_VehicleFailed_Route" )) then
			if( RoutePointNumber == 5 ) then
				AnounceLog_enemyDecrease()	
				TppEnemyUtility.SetEnableCharacterId( "Seq10_03" , false )
				TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq10_03" , false )
			else
			end
		else
		end
	end,
	
	Seq10_06_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Mov_CenterHouse_a" )) then
			if( RoutePointNumber == 29 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Mov_CenterHouse_a2" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Mov_CenterHouse_a" ) 	
				TppEnemy.ChangeRoute( this.cpID , "Seq10_06","e20010_Seq10_SneakRouteSet","S_Mov_CenterHouse_a2", 0 )	
			else
			end
		else
		end
	end,
	
	Seq10_07_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Mov_CenterHouse_b" )) then
			if( RoutePointNumber == 21 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Mov_CenterHouse_b2" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Mov_CenterHouse_b" ) 	
				TppEnemy.ChangeRoute( this.cpID , "Seq10_07","e20010_Seq10_SneakRouteSet","S_Mov_CenterHouse_b2", 0 )	
			else
			end
		else
		end
	end,
	
	ComEne01_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_GoTo_EastCamp" )) then
			if( RoutePointNumber == 21 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_EastCamp_SouthLeftGate" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_GoTo_EastCamp" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne01","e20010_Seq10_SneakRouteSet","S_Sen_EastCamp_SouthLeftGate", 0 )	
			else
			end
		end
	end,
	
	ComEne03_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "GoToWestCamp_TalkWeapon" )) then
			if( RoutePointNumber == 19 ) then
				TppEnemy.EnableRoute( this.cpID , "S_GoToExWeaponTruck" ) 	
				TppEnemy.EnableRoute( this.cpID , "S_Sen_WestCamp_WestGate2" ) 	
				TppEnemy.DisableRoute( this.cpID , "GoToWestCamp_TalkWeapon" )	
				TppEnemy.ChangeRoute( this.cpID , "Seq10_01","e20010_Seq10_SneakRouteSet","S_GoToExWeaponTruck", 0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne03","e20010_Seq10_SneakRouteSet","S_Sen_WestCamp_WestGate2", 0 )	
			else
			end
		end
	end,
	
	ComEne05_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)

		if ( RouteName ==  GsRoute.GetRouteId( "S_GoTo_SeaSideEnter" )) then
			if( RoutePointNumber == 16 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_SeaSideEnter" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_GoTo_SeaSideEnter" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne05","e20010_Seq10_SneakRouteSet","S_Sen_SeaSideEnter", 0 )
			else
			end
		end
	end,
	
	ComEne06_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_GoTo_EastCampNorthTower" )) then
			if( RoutePointNumber == 22 ) then
				TppEnemy.EnableRoute( this.cpID , "S_SL_EastCamp_North" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_GoTo_EastCampNorthTower" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne06","e20010_Seq10_SneakRouteSet","S_SL_EastCamp_North", 0 )	
			else
			end
		else
		end
	end,
	
	ComEne09_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Pat_AsylumInside_Ver01" )) then
			if( RoutePointNumber == 4 ) then
				TppEnemy.DisableRoute( this.cpID , "S_Pat_AsylumInside_Ver01" ) 	
				if ( TppMission.GetFlag( "isAsyInsideRouteChange_01" ) == true ) then
					TppEnemy.EnableRoute( this.cpID , "S_Pat_AsylumInside_Ver03" ) 	
					TppEnemy.ChangeRoute( this.cpID , "ComEne09","e20010_Seq10_SneakRouteSet","S_Pat_AsylumInside_Ver03", 0 )	
				else
				end
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "S_Pat_AsylumInside_Ver03" )) then
			if( RoutePointNumber == 7 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Seeing_Sea" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Pat_AsylumInside_Ver03" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne09","e20010_Seq10_SneakRouteSet","S_Seeing_Sea", 0 )
			else
			end
		end
	end,
	
	ComEne13_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_GoToSearchEscapeHostage_a" )) then
			if( RoutePointNumber == 11	 ) then
				TppEnemy.EnableRoute( this.cpID , "S_SearchSpHostage02" ) 	
				TppEnemy.EnableRoute( this.cpID , "S_SearchSpHostage01" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_GoToSearchEscapeHostage_a" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_GoToSearchEscapeHostage_b" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne14","e20010_Seq10_SneakRouteSet","S_SearchSpHostage02", 0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne13","e20010_Seq10_SneakRouteSet","S_SearchSpHostage01", 0 )	
			else
			end
		else
		end
	end,
	
	ComEne14_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_GoToSearchEscapeHostage_b" )) then
			if( RoutePointNumber == 12 ) then
				TppEnemy.EnableRoute( this.cpID , "S_SearchSpHostage01" ) 	
				TppEnemy.EnableRoute( this.cpID , "S_SearchSpHostage02" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_GoToSearchEscapeHostage_a" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_GoToSearchEscapeHostage_b" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne13","e20010_Seq10_SneakRouteSet","S_SearchSpHostage01", 0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne14","e20010_Seq10_SneakRouteSet","S_SearchSpHostage02", 0 )	
			else
			end
		else
		end
	end,
	
	ComEne18_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_HeliPort_2manSeparate02" )) then
			if( RoutePointNumber == 12 ) then
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2mancell_back" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2manSeparate01" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne19","e20010_Seq10_SneakRouteSet","S_HeliPort_2mancell_back", 0 )	
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2mancell_back" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2manSeparate02" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne18","e20010_Seq10_SneakRouteSet","S_HeliPort_2mancell_back", 0 )	
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "S_HeliPort_2mancell_back" )) then
			if( RoutePointNumber == 6 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortBehind_a" ) 	
				TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortBehind_b" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_back" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_back" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne18","e20010_Seq10_SneakRouteSet","S_Sen_HeliPortBehind_a", 0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne19","e20010_Seq10_SneakRouteSet","S_Sen_HeliPortBehind_b", 0 )	
			else
			end
		end
	end,
	
	ComEne19_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Sen_HeliPortBehind_b" )) then
			if( RoutePointNumber == 4 ) then
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2mancell_go" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Sen_HeliPortBehind_b" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne19","e20010_Seq10_SneakRouteSet","S_HeliPort_2mancell_go", 0 )	
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2mancell_go" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Sen_HeliPortBehind_a" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne18","e20010_Seq10_SneakRouteSet","S_HeliPort_2mancell_go", 0 )	
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "S_HeliPort_2mancell_go" )) then
			if( RoutePointNumber == 9 ) then
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2manSeparate01" ) 	
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2manSeparate02" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_go" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_go" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne18","e20010_Seq10_SneakRouteSet","S_HeliPort_2manSeparate02", 0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne19","e20010_Seq10_SneakRouteSet","S_HeliPort_2manSeparate01", 0 )	
			else
			end
		end
	end,
	
	ComEne21_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "ComEne21_TalkRoute" )) then
			if( RoutePointNumber == 4 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortCenter_a" ) 	
				TppEnemy.DisableRoute( this.cpID , "ComEne21_TalkRoute" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne21","e20010_Seq10_SneakRouteSet","S_Sen_HeliPortCenter_a", 0 )	
			else
			end
		else
		end
	end,
	
	ComEne25_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Mov_Center_d" )) then
			if( RoutePointNumber == 5 ) then										
				if( TppMission.GetFlag( "isCenterBackEnter" ) == true ) then
					TppEnemy.EnableRoute( this.cpID , "S_Ret_Center_d" ) 	
					TppEnemy.DisableRoute( this.cpID , "S_Mov_Center_d" ) 	
					TppEnemy.ChangeRoute( this.cpID , "ComEne25","e20010_Seq10_SneakRouteSet","S_Ret_Center_d", 0 )	
				else
				end
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "S_Ret_Center_d" )) then
			if( RoutePointNumber == 8 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_d" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Ret_Center_d" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne25","e20010_Seq10_SneakRouteSet","S_Sen_Center_d", 0 )	
			else
			end
		end
	end,
	
	ComEne29_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Mov_Center_2Fto1F" )) then
			if( RoutePointNumber == 15 ) then										
				TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_e" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Mov_Center_2Fto1F" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq10_SneakRouteSet","S_Sen_Center_e", 0 )	
			else
			end
		else
		end
	end,
	
	Talk_Helipad01 = function()
		TppEnemy.EnableRoute( this.cpID , "ComEne21_TalkRoute" ) 	
		TppEnemy.DisableRoute( this.cpID , "S_Sen_HeliPortCenter_a" ) 	
		TppEnemy.ChangeRoute( this.cpID , "ComEne21","e20010_Seq10_SneakRouteSet","ComEne21_TalkRoute", 0 )	
	end,
	
	Radio_ChangePostureAdvice = function()
		local radioDaemon = RadioDaemon:GetInstance()
		if ( radioDaemon:IsPlayingRadio() == false ) then
			TppRadio.DelayPlay( "Miller_ChangePostureAdvice", "short" )
		end
	end,
	
	Radio_SpHostageDiscovery = function()
		if( TppMission.GetFlag( "isSpHostage_Dead" ) == false ) then
			if( TppMission.GetFlag( "isSpHostageEncount" ) == false ) then
				TppMission.SetFlag( "isSpHostageEncount", true )
				TppRadio.Play( "Miller_DiscoverySpHostage" )
			end
		else
		end
	end,
	
	Radio_TranquilizerGunAdvice = function()
		local lifeStatus1 = TppEnemyUtility.GetLifeStatusByRoute( "gntn_cp", "S_SL_StartCliff" )
		local radioPlay = false

		if(lifeStatus1 == "Normal" and TppMission.GetFlag( "isDoCarryAdvice" ) == false )then
				



			radioPlay = true
		end

		if radioPlay == true then
			
			local checkPos = Vector3(-151.5,35.0,253.8)
			local size = Vector3(3.0,3.0,3.0)

			local npcIds = TppNpcUtility.GetNpcByBoxShape( checkPos, size )

			local eneNum = 0
			if npcIds and #npcIds.array > 0 then
				for i,id in ipairs(npcIds.array) do
					local type = TppNpcUtility.GetNpcType( id )
					if type == "Enemy" then
						
						TppRadio.Play( "Miller_TranquilizerGunAdvice" )
					end
				end
			end



		end
	end,
	
	Radio_MoveAsylum = function()
		if( TppMission.GetFlag( "isDoCarryAdvice" ) == false ) then
			local radioDaemon = RadioDaemon:GetInstance()

			if ( radioDaemon:IsPlayingRadioWithGroupName("e0010_rtrg0009") == true ) then
				TppRadio.PlayEnqueue( "Miller_DeviceAdvice" )
			else
				local phase = TppEnemy.GetPhase( this.cpID )
				if ( phase == "alert" or phase == "evasion" ) then
				else
					TppRadio.DelayPlay( "Miller_MovingAdvice", "short" )
				end
			end
			TppMission.SetFlag( "isDoCarryAdvice", true )	
			TppRadio.RegisterIntelRadio( "intel_e0010_esrg0090", "e0010_esrg0091", true )
			TppRadio.RegisterIntelRadio( "intel_e0010_esrg0120", "e0010_esrg0121", true )
			RegisterRadioCondition()
		end
	end,

	
	Seq_RescueDemo_OnlyOnce = function()
		
		

			
			if( (TppData.GetArgument( 1 ) == "AsyPickingDoor24" ) ) then
				TppSequence.ChangeSequence( "Seq_RescueChicoDemo01" )

			elseif( (TppData.GetArgument( 1 ) == "Paz_PickingDoor00" ) )then

				TppSequence.ChangeSequence( "Seq_RescuePazDemo" )

			end
	end,
	
	Radio_RescuePazTimerStop = function()
		e20010_require_01.Radio_RescuePaz1TimerStop()
		e20010_require_01.Radio_RescuePaz2TimerStop()
	end,
}



this.Seq_NextRescuePaz = {

	Messages = {
		Character = {
			myMessages.Character[1],
			myMessages.Character[2],
			{ data = "gntn_cp", message = "ConversationEnd", localFunc = "local_ConversationEnd" },		
			{ data = "gntn_cp", message = "EndGroupVehicleRouteMove", localFunc = "EnterCenterTruck" },
			{ data = "Chico", message = "MessageHostageCarriedStart", localFunc = "ChicoCarriedStart" },
			{ data = "Chico", message = "MessageHostageCarriedEnd", localFunc = "Seq_QuestionChicoDemo_OnlyOnce" },
			{ data = "Chico", message = "HostageLaidOnVehicle", commonFunc = function() e20010_require_01.Common_HostageOnVehicleInDangerArea() end },
			{ data = "ComEne01",	message = "MessageRoutePoint",	localFunc = "ComEne01_NodeAction" },
			{ data = "ComEne11",	message = "MessageRoutePoint",	localFunc = "ComEne11_NodeAction" },
			{ data = "ComEne13",	message = "MessageRoutePoint",	localFunc = "ComEne13_NodeAction" },
			{ data = "ComEne14",	message = "MessageRoutePoint",	localFunc = "ComEne14_NodeAction" },
			{ data = "ComEne17",	message = "MessageRoutePoint", commonFunc = function() e20010_require_01.ComeEne17_NodeAction() end },
			{ data = "ComEne18",	message = "MessageRoutePoint",	localFunc = "ComEne18_NodeAction" },
			{ data = "ComEne19",	message = "MessageRoutePoint",	localFunc = "ComEne19_NodeAction" },
			{ data = "ComEne25",	message = "MessageRoutePoint",	localFunc = "ComEne25_NodeAction" },	
			{ data = "ComEne29",	message = "MessageRoutePoint",	localFunc = "ComEne29_NodeAction" },
			{ data = "ComEne31",	message = "MessageRoutePoint",	localFunc = "ComEne31_NodeAction" },	
			{ data = "Seq20_01",	message = "MessageRoutePoint",	localFunc = "Seq20_01_NodeAction" },
			{ data = "Seq20_02",	message = "EnemyArrivedAtRouteNode", localFunc = "Seq20_02_ArrivedAtRoutePoint" },
			{ data = "Seq20_03",	message = "MessageRoutePoint",	localFunc = "Seq20_03_NodeAction" },
			{ data = "Seq20_04",	message = "MessageRoutePoint",	localFunc = "Seq20_04_NodeAction" },
			{ data = "Seq20_05",	message = "MessageRoutePoint",	localFunc = "Seq20_05_NodeAction" },
			{ data = "SpHostage",	message = "Dead",	localFunc = "SpHostageIsDead" },
			{ data = "SpHostage",	message = "MessageHostageCarriedStart", localFunc = "SpHostage_EnemyLost" },
			{ data = "Player", message = "TryPicking", localFunc = "Seq_RescueDemo_OnlyOnce"  },
			
			{ data = "gntn_cp",		message = "VehicleMessageRoutePoint", commonFunc = function() GZCommon.Common_CenterBigGateVehicle( ) end  },
			{ data = "gntn_cp",		message = "EndRadio", commonFunc = function() GZCommon.Common_CenterBigGateVehicleEndCPRadio( ) end  },
		},
		Enemy = {
			{ message = "EnemyInterrogation", commonFunc = function() e20010_require_01.Seq20_Interrogation() end },
		},
		Trap = {
			myMessages.Trap[1],
			myMessages.Trap[2],
			myMessages.Trap[3],


			
			{ data = "Radio_ChicoRV", message = "Exit", localFunc = "Radio_ChicoRV" },
			{ data = "Radio_NearRV", message = "Enter", localFunc = "Radio_NearRV" },
			{ data = "Radio_ArriveRV", message = "Enter", localFunc = "Radio_ArriveRV" },
			{ data = "Radio_PaztakeRoute_Camp", message = "Enter", localFunc = "Radio_PazTakeRoute_Camp" },
			{ data = "Radio_PaztakeRoute_HeliPort", message = "Enter", localFunc = "Radio_PazTakeRoute_HeliPort" },
			{ data = "Radio_PaztakeRoute_Gate", message = "Enter", localFunc = "Radio_PazTakeRoute_Gate" },
			{ data = "Radio_PaztakeRoute_Boilar", message = "Enter", localFunc = "Radio_PazTakeRoute_Boilar" },
			{ data = "Radio_PaztakeRoute_Flag", message = "Enter", localFunc = "Radio_PazTakeRoute_Flag" },
			{ data = "Radio_CliffAttention", message = "Enter", localFunc = "Radio_CliffAttention" },
			{ data = "Radio_Rain", message = "Enter", commonFunc = function() TppRadio.DelayPlayEnqueue("Miller_Rain", "mid" ) end },
			{ data = "Radio_DramaPaz", message = "Enter", commonFunc = function() e20010_require_01.OnVehicleCheckRadioPlayEnqueue( "Miller_DramaPaz1", "long" ) end },
			{ data = "Radio_DiscoveryPaz", message = "Enter", commonFunc = function() e20010_require_01.NextRescuePaz_DiscoveryPaz() end },	
			{ data = "ComEne17_RouteChange", message = "Enter", commonFunc = function() e20010_require_01.ComEne17_RouteChange() end },
			{ data = "Talk_SearchSpHostage", message = "Enter", localFunc = "Talk_SearchSpHostage" },
			
			{ data = "Demo_EncounterPaz", message = "Enter", commonFunc = function() Demo_eneChecker("paz") end },
			
			
			{ data = "ChicoMonologue", message = "Enter", localFunc = "Chico_Monologue" },
			{ data = "ChicoMonologue02", message = "Enter", localFunc = "Chico_Monologue02" },
			{ data = "ChicoMonologue03", message = "Enter", localFunc = "Chico_Monologue03" },
			{ data = "ChicoMonologue04", message = "Enter", localFunc = "Chico_Monologue04" },
		},
		Timer = {
			{ data = "Timer_InterrogationAdvice", message = "OnEnd", commonFunc = function() e20010_require_01.Radio_InterrogationAdvice() end },
		},
		UI = {
			{ message = "PlayWalkMan" , commonFunc = function() e20010_require_01.Common_PlayListenTape() end },		
		},
		RadioCondition = {
			myMessages.RadioCondition[1],	
			myMessages.RadioCondition[2],	
		
		},
		Subtitles = {
				
				{ data="enqt1000_1m1310", message = "SubtitlesEventMessage", commonFunc = function() e20010_require_01.Common_interrogation_B() end },
				{ data="e0010_rtrg1269", commonFunc = function() e20010_require_01.CallTapeReaction0() end },		
				{ data="e0010_rtrg1270", commonFunc = function() e20010_require_01.CallTapeReaction1() end },		
				{ data="e0010_rtrg1271", commonFunc = function() e20010_require_01.CallTapeReaction2() end },		
				{ data="e0010_rtrg1272", commonFunc = function() e20010_require_01.CallTapeReaction3() end },		
				{ data="e0010_rtrg1273", commonFunc = function() e20010_require_01.CallTapeReaction4() end },		
				{ data="e0010_rtrg1274", commonFunc = function() e20010_require_01.CallTapeReaction5() end },		
				{ data="e0010_rtrg1275", commonFunc = function() e20010_require_01.CallTapeReaction6() end },		
		
				{ data="tp_chico_00_03", message = "SubtitlesFinishedEventMessage", commonFunc = function() e20010_require_01.CallTapeReaction7() end },	
		
		
		
		},
	},

	OnEnter = function( manager )
		local LightState	= TppGadgetManager.GetGadgetStatus( "gntn_center_SwitchLight" )
		
		Seq_NextRescuePaz_RouteSet()
		
		WoodTurret_RainFilter_OFF()
		
		TppCommandPostObject.GsSetRealizeFirstPriorityByRoute( this.cpID , "S_Sen_HeliPortFrontGate_a" , false )
		TppCommandPostObject.GsSetRealizeFirstPriorityByRoute( this.cpID , "S_Sen_HeliPortFrontGate_b" , false )
		
		SetComplatePhoto()
		
		TppMission.SetFlag( "isFirstEncount_Chico", true )
		
		TppPickableManager.DisableByLocator( "tp_chico_05" )
		
		TppSupportHelicopterService.SetDefaultRendezvousPointMarker("RV_SeaSide")
		
		All_Seq_MissionAreaOut()
		
		ChicoDoor_ON_Open()
		PazDoor_ON_Close()
		
		Seq10Trap_Disable()
		Seq10_20Trap_Enable()
		Seq20Trap_Enable()
		Seq30Trap_Disable()
		Seq40Trap_Disable()
		
		ChengeChicoPazIdleMotion()
		
		TppNewCollectibleUtility.PutCollectibleOnCharacter{ id = "WP_sm00_v00", count = 330, target = "Cargo_Truck_WEST_004" , attachPoint = "CNP_USERITEM" }
		
		SetIntelRadio()
		
		SetOptionalRadio()
		
		TppMission.SetFlag( "isCenter2F_EneRouteChange", false )



		TppMission.SetFlag( "isSmokingRouteChange", false )
		TppMission.SetFlag( "isCenterBackEnter", false )
		
		GuardTarget_Setting()
		
		Seq10Enemy_Disable()
		Seq20Enemy_Enable()
		Seq30Enemy_Disable()
		Seq40Enemy_Disable()
		
		FirstChico_Vehicle_01()
		
		local radioDaemon = RadioDaemon:GetInstance()
		if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1270") == false or
			radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1271") == false or
			radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1272") == false or
			radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1274") == false) then
			if( TppMission.GetFlag( "isPazMarkJingle" ) == false and TppMission.GetFlag( "isInterrogation_Radio" ) == false ) then
				
				TppRadioCommand.SetEnableDisableRadioWhileChico3TapeIsPlaying( true )
			else
				
				TppRadioCommand.SetEnableDisableRadioWhileChico3TapeIsPlaying( false )
			end
		else
			
			TppRadioCommand.SetEnableDisableRadioWhileChico3TapeIsPlaying( false )
		end

		if( TppMission.GetFlag( "isQuestionChico" ) == true ) then				
			
			if( TppMission.GetFlag( "isCassetteDemo" ) == false ) and
				( TppMission.GetFlag( "isPlaceOnHeliChico" ) == false )	then
				commonUiMissionSubGoalNo(3)
				ChicoPazQustionDemoAfterReStart()	
			else
				commonUiMissionSubGoalNo(4)
			end

			if( TppMission.GetFlag( "isCarryOnSpHostage" ) == false ) and			
				( TppMission.GetFlag( "isSpHostage_Dead" ) == false ) and			
				( TppMission.GetFlag( "isPlaceOnHeliSpHostage" ) == false ) then	

				TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Talk_KillSpHostage01", true , false )
			else
			end
			
			if( TppMission.GetFlag( "isCassetteDemo" ) == false ) then
				e20010_require_01.SpHostageStatus()	
				TppEnemy.EnableRoute( this.cpID , "S_Pat_SeaSide01b" ) 					
				TppEnemy.EnableRoute( this.cpID , "S_Pat_SeaSide02b" ) 					
				TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumOutSideGate_b" ) 		
				TppEnemy.DisableRoute( this.cpID , "S_Seeing_Sea" )						
				TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide01a" )					
				TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide02a" )					
				TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide02c" )					
				TppEnemy.DisableRoute( this.cpID , "S_Waiting_PC_AsyOut01" )					
				TppEnemy.DisableRoute( this.cpID , "S_Waiting_PC_AsyOut02" )					
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_AsylumOutSideGate_b" , -1 , "ComEne09" , "ROUTE_PRIORITY_TYPE_FORCED" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Pat_SeaSide01b" , -1 , "Seq20_04" , "ROUTE_PRIORITY_TYPE_FORCED" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Pat_SeaSide02b" , -1 , "Seq20_03" , "ROUTE_PRIORITY_TYPE_FORCED" )
			else
			end
		else																
			
			if( TppMission.GetFlag( "isCassetteDemo" ) == false ) then
				commonUiMissionSubGoalNo(2)
				TppMissionManager.SaveGame("20")	
			else
				commonUiMissionSubGoalNo(4)
			end
			
			TppMarkerSystem.DisableMarker{ markerId = "20010_marker_Chico" }
			TppMarkerSystem.DisableMarker{ markerId = "20010_marker_ChicoPinpoint" }
			
			if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == false ) then
				RV_MarkerON()
				AnounceLog_enemyReplacement()
			else
				TppMarkerSystem.DisableMarker{ markerId = "20010_marker_RV" }
			end
			
			Chico_MarkerON()
			
			TppEnemy.EnableRoute( this.cpID , "S_Sen_EastCampCenter_East02" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_WestCamp_NorthGate" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_SeaSideEnter02" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_WareHouseBehind" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumBehind" )
			TppEnemy.EnableRoute( this.cpID , "S_Seeing_Sea" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumOutSideGate_a" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_EastCamp_NorthLeftGate" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_WareHouse_NorthGate" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortFrontGate_a" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortFrontGate_b" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortHouse" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortBehind_a" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortBehind_b" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPort_Front" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortCenter_b" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_BigGate_a" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_BigGate_b" )
			TppEnemy.EnableRoute( this.cpID , "S_Pre_CenterDoorOut" )
			TppEnemy.EnableRoute( this.cpID , "S_Search_Xof" )
			TppEnemy.EnableRoute( this.cpID , "S_WaitingInBoilar_01" )
			TppEnemy.EnableRoute( this.cpID , "S_WaitingInBoilar_02" )
			TppEnemy.EnableRoute( this.cpID , "S_WaitingInTruck" )
			TppEnemy.EnableRoute( this.cpID , "S_Waiting_PC_AsyOut01" )
			TppEnemy.EnableRoute( this.cpID , "S_Waiting_PC_AsyOut02" )
			TppEnemy.EnableRoute( this.cpID , "S_Waiting_Seq20_05" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortYard" )
			TppEnemy.EnableRoute( this.cpID , "S_Seeing_Sea" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_BoilarFront" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumOutSideGate_a" )
			
			TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide01a" )
			TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide01b" )
			TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide02a" )
			TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide02b" )
			TppEnemy.DisableRoute( this.cpID , "Seq20_04_Talk_KillHostage" )
			TppEnemy.DisableRoute( this.cpID , "GoToKillHostageArea" )
			TppEnemy.DisableRoute( this.cpID , "KillHostage01" )
			TppEnemy.DisableRoute( this.cpID , "KillHostage02" )
			TppEnemy.DisableRoute( this.cpID , "KillHostage03" )
			TppEnemy.DisableRoute( this.cpID , "KillHostage04" )
			TppEnemy.DisableRoute( this.cpID , "Seq20_02_RideOnTruck" )
			TppEnemy.DisableRoute( this.cpID , "GoToEastcampSouthGate" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_EastCamp_SouthLeftGate" )
			TppEnemy.DisableRoute( this.cpID , "S_Pat_EastCamp_North" )
			TppEnemy.DisableRoute( this.cpID , "OutDoorFromWareHouse" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_WareHousePloofUnder" )
			TppEnemy.DisableRoute( this.cpID , "S_Ret_Center_d" )
			TppEnemy.DisableRoute( this.cpID , "S_Mov_Center_d" )
			TppEnemy.DisableRoute( this.cpID , "S_Mov_Center_2Fto1F" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_e" )
			TppEnemy.DisableRoute( this.cpID , "S_Mov_Smoking_Center" )
			TppEnemy.DisableRoute( this.cpID , "S_GetOut_Boilar01" )
			TppEnemy.DisableRoute( this.cpID , "S_GetOut_Boilar02" )
			TppEnemy.DisableRoute( this.cpID , "S_TalkingDelatetape_After01" )
			TppEnemy.DisableRoute( this.cpID , "S_TalkingDelatetape_After02" )
			TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter01" )
			TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter02" )
			TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter03" )
			TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter04" )
			TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_go" )
			TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_go" )
			TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2manSeparate01" )
			TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2manSeparate02" )
			TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_back" )
			TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_back" )
			TppEnemy.DisableRoute( this.cpID , "S_Waiting_Vehicle" )
			TppEnemy.DisableRoute( this.cpID , "GoToWareHouse3Mancell" )
			TppEnemy.DisableRoute( this.cpID , "GoToWareHouse3Mancell" )
			TppEnemy.DisableRoute( this.cpID , "GoToWareHouse3Mancell" )
			TppEnemy.DisableRoute( this.cpID , "GoTo_CenterBuilding" )
			TppEnemy.DisableRoute( this.cpID , "GoToWareHouse_ComEne13" )
			TppEnemy.DisableRoute( this.cpID , "GoToWareHouse_ComEne14" )
			TppEnemy.DisableRoute( this.cpID , "GoToWestCampWestGate_Seq20_03" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_WestCamp_WestGate" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_WareHouseKeeper01" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_WareHouseKeeper02" )
			TppEnemy.DisableRoute( this.cpID , "S_Talk_AboutBoilar" )
			TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage01" )
			TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage02" )
			TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage03" )
			TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage04" )
			TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage05a" )
			TppEnemy.DisableRoute( this.cpID , "Seq20_02_RideOnTruck" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_f" )
			TppEnemy.DisableRoute( this.cpID , "S_Mov_CenterHouse_b2" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Bridge" )
			TppEnemy.DisableRoute( this.cpID , "ComEne17_TalkRoute" )
			TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage05b" )
			TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage06a" )
			TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage06b" )
			TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage07a" )
			TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage07b" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_AsylumOutSideGate_b" )
			TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret01_Route" )
			TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret05_Route" )
			TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL02_Route" )
			TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL04_Route" )
			TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL05_Route" )
			TppEnemy.DisableRoute( this.cpID , "ComEne31_SwitchOFF_v3" )
			TppEnemy.DisableRoute( this.cpID , "ComEne31_SwitchOFF_v2" )
			
			if ( LightState == 2 ) then		
				TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "SmokingRouteChange", false , false )
				TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Center2F_EneRouteChange", false , false )
				TppEnemy.EnableRoute( this.cpID , "ComEne25_SwitchOFF" )
				TppEnemy.EnableRoute( this.cpID , "ComEne26_SwitchOFF" )
				TppEnemy.EnableRoute( this.cpID , "ComEne27_SwitchOFF" )
				TppEnemy.EnableRoute( this.cpID , "ComEne28_SwitchOFF" )
				TppEnemy.EnableRoute( this.cpID , "ComEne29_SwitchOFF" )
				TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_d" )
				TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_a" )
				TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_b" )
				TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_c" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "ComEne25_SwitchOFF" , -1 , "ComEne25" , "ROUTE_PRIORITY_TYPE_FORCED" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "ComEne26_SwitchOFF" , -1 , "ComEne26" , "ROUTE_PRIORITY_TYPE_FORCED" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "ComEne27_SwitchOFF" , -1 , "ComEne27" , "ROUTE_PRIORITY_TYPE_FORCED" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "ComEne28_SwitchOFF" , -1 , "ComEne28" , "ROUTE_PRIORITY_TYPE_FORCED" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "ComEne29_SwitchOFF" , -1 , "ComEne29" , "ROUTE_PRIORITY_TYPE_FORCED" )
			else
				TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_d" )
				TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_a" )
				TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_b" )
				TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_c" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_Center_d" , -1 , "ComEne25" , "ROUTE_PRIORITY_TYPE_FORCED" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_Center_a" , -1 , "ComEne26" , "ROUTE_PRIORITY_TYPE_FORCED" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_BoilarFront" , -1 , "ComEne27" , "ROUTE_PRIORITY_TYPE_FORCED" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_Center_b" , -1 , "ComEne28" , "ROUTE_PRIORITY_TYPE_FORCED" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_Center_c" , -1 , "ComEne29" , "ROUTE_PRIORITY_TYPE_FORCED" )
			end
			
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_EastCampCenter_East02" , -1 , "ComEne01" , "ROUTE_PRIORITY_TYPE_FORCED" )
			if( TppMission.GetFlag( "isWoodTurret04_Break" ) == false ) then
				TppEnemy.EnableRoute( this.cpID , "S_SL_WestCamp" )
				TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret04_Route" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_SL_WestCamp" , -1 , "ComEne02" , "ROUTE_PRIORITY_TYPE_FORCED" )
			else
				TppEnemy.EnableRoute( this.cpID , "Break_WoodTurret04_Route" )
				TppEnemy.DisableRoute( this.cpID , "S_SL_WestCamp" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "Break_WoodTurret04_Route" , -1 , "ComEne02" , "ROUTE_PRIORITY_TYPE_FORCED" )
			end
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_WestCamp_NorthGate" , -1 , "ComEne03" , "ROUTE_PRIORITY_TYPE_FORCED" )
			if( TppMission.GetFlag( "isIronTurretSL01_Break" ) == false ) then
				TppEnemy.EnableRoute( this.cpID , "S_SL_WareHouse01a" )
				TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL01_Route" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_SL_WareHouse01a" , -1 , "ComEne04" , "ROUTE_PRIORITY_TYPE_FORCED" )
			else
				TppEnemy.EnableRoute( this.cpID , "Break_IronTurretSL01_Route" )
				TppEnemy.DisableRoute( this.cpID , "S_SL_WareHouse01a" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "Break_IronTurretSL01_Route" , -1 , "ComEne04" , "ROUTE_PRIORITY_TYPE_FORCED" )
			end
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_SeaSideEnter02" , -1 , "ComEne05" , "ROUTE_PRIORITY_TYPE_FORCED" )
			if( TppMission.GetFlag( "isWoodTurret03_Break" ) == false ) then
				TppEnemy.EnableRoute( this.cpID , "S_SL_EastCamp_North" )
				TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret03_Route" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_SL_EastCamp_North" , -1 , "ComEne06" , "ROUTE_PRIORITY_TYPE_FORCED" )
			else
				TppEnemy.EnableRoute( this.cpID , "Break_WoodTurret03_Route" )
				TppEnemy.DisableRoute( this.cpID , "S_SL_EastCamp_North" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "Break_WoodTurret03_Route" , -1 , "ComEne06" , "ROUTE_PRIORITY_TYPE_FORCED" )
			end
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_WareHouseBehind" , -1 , "ComEne07" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_AsylumBehind" , -1 , "ComEne08" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Seeing_Sea" , -1 , "ComEne09" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_AsylumOutSideGate_a" , -1 , "ComEne10" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_EastCamp_NorthLeftGate" , -1 , "ComEne11" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_WareHouse_NorthGate" , -1 , "ComEne12" , "ROUTE_PRIORITY_TYPE_FORCED" )
			
			
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_HeliPortFrontGate_a" , -1 , "ComEne15" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_HeliPortFrontGate_b" , -1 , "ComEne16" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_HeliPortHouse" , -1 , "ComEne17" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_HeliPortBehind_a" , -1 , "ComEne18" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_HeliPortBehind_b" , -1 , "ComEne19" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_HeliPortYard" , -1 , "ComEne20" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_HeliPort_Front" , -1 , "ComEne21" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_HeliPortCenter_b" , -1 , "ComEne22" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_BigGate_a" , -1 , "ComEne23" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Sen_BigGate_b" , -1 , "ComEne24" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Search_Xof" , -1 , "ComEne30" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_WaitingInBoilar_01" , -1 , "ComEne31" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_WaitingInBoilar_02" , -1 , "ComEne32" , "ROUTE_PRIORITY_TYPE_FORCED" )
			if( TppMission.GetFlag( "isWoodTurret02_Break" ) == false ) then
				TppEnemy.EnableRoute( this.cpID , "S_SL_EastCamp_South_in" )
				TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret02_Route" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_SL_EastCamp_South_in" , -1 , "ComEne33" , "ROUTE_PRIORITY_TYPE_FORCED" )
			else
				TppEnemy.EnableRoute( this.cpID , "Break_WoodTurret02_Route" )
				TppEnemy.DisableRoute( this.cpID , "S_SL_EastCamp_South_in" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "Break_WoodTurret02_Route" , -1 , "ComEne33" , "ROUTE_PRIORITY_TYPE_FORCED" )
			end
			if( TppMission.GetFlag( "isCenterTowerSL_Break" ) == false ) then
				TppEnemy.EnableRoute( this.cpID , "S_SL_HeliPortTower" )
				TppEnemy.DisableRoute( this.cpID , "Break_CenterTower_Route" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_SL_HeliPortTower" , -1 , "ComEne34" , "ROUTE_PRIORITY_TYPE_FORCED" )
			else
				TppEnemy.EnableRoute( this.cpID , "Break_CenterTower_Route" )
				TppEnemy.DisableRoute( this.cpID , "S_SL_HeliPortTower" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "Break_CenterTower_Route" , -1 , "ComEne34" , "ROUTE_PRIORITY_TYPE_FORCED" )
			end
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_WaitingInTruck" , -1 , "Seq20_02" , "ROUTE_PRIORITY_TYPE_FORCED" )


			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_Waiting_Seq20_05" , -1 , "Seq20_05" , "ROUTE_PRIORITY_TYPE_FORCED" )
			
			if( TppMission.GetFlag( "isAsyPickingDoor15" ) == false ) then
				TppHostageManager.GsSetStruggleFlag( "Hostage_e20010_003" , true )
				TppHostageManager.GsSetStruggleVoice( "Hostage_e20010_003" , "POWV_0260" )
			else
			end
			
			if( TppMission.GetFlag( "isAsyPickingDoor05" ) == false ) then
				TppHostageManager.GsSetStruggleFlag( "Hostage_e20010_004" , true )
				TppHostageManager.GsSetStruggleVoice( "Hostage_e20010_004" , "POWV_0270" )
			else
			end
			
			e20010_require_01.SpHostageStatus()
		end
	end,
	
	Talk_SearchSpHostage = function()
		TppEnemy.EnableRoute( this.cpID , "S_SearchSpHostage05b" ) 						
		TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage05a" )						
		TppEnemy.ChangeRoute( this.cpID , "Seq20_04","e20010_Seq20_SneakRouteSet","S_SearchSpHostage05b",0 )	
	end,
	
	Seq20_02_ArrivedAtRoutePoint = function()
		local phase				= TppEnemy.GetPhase( this.cpID )
		local RouteName			= TppData.GetArgument(2)
		local RoutePointNumber	= TppData.GetArgument(3)
		local GateState			= TppGadgetManager.GetGadgetStatus( "gntn_BigGateSwitch" )

		if ( RouteName ==  GsRoute.GetRouteId( "GateOpenTruck01" )) then
			if( RoutePointNumber == 5 ) or ( RoutePointNumber == 7 ) then
				
				if( TppMission.GetFlag( "isTruckSneakRideOn" ) == true ) then
					
					TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Cargo_Truck_WEST_004" , "GateEnterTruck" , -1 )
					TppMission.SetFlag( "isNoConversation_GateInTruck", true )
				else
				end
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "GateEnterTruck" )) then
			if( RoutePointNumber == 2 ) then
				if( TppMission.GetFlag( "isNoConversation_GateInTruck" ) == true ) then
					if( TppMission.GetFlag( "isTruckSneakRideOn" ) == true ) then
						if ( phase == "sneak" ) and ( GateState == 2 ) then
							local onDemoStart = function()
								TppMusicManager.PostJingleEvent( 'SuspendPhase', 'Play_bgm_gntn_jingle_gate' )
							end
							local onDemoEnd = function()
							end
							TppDemo.Play( "BigGateOpenDemo" , { onStart = onDemoStart, onEnd = onDemoEnd } , {
								disableGame				= false,	
								disableDamageFilter		= false,	
								disableDemoEnemies		= false,	
								disableEnemyReaction	= false,	
								disableHelicopter		= false,	
								disablePlacement		= false, 	
								disableThrowing			= false	 	
							})
						else	
							
							GZCommon.Common_CenterBigGateVehicleSetup( this.cpID, "TppGroupVehicleRouteInfo_Seq20_02a", "GateEnterTruck", "GateEnterTruck02", 2, 1 )
							TppMission.SetFlag( "isSeq20_02_DriveEnd", 1 )
						end
					else
						
						GZCommon.Common_CenterBigGateVehicleSetup( this.cpID, "TppGroupVehicleRouteInfo_Seq20_02a", "GateEnterTruck", "GateEnterTruck02", 2, 1 )
						TppMission.SetFlag( "isSeq20_02_DriveEnd", 1 )
					end
				else
					
					GZCommon.Common_CenterBigGateVehicleSetup( this.cpID, "TppGroupVehicleRouteInfo_Seq20_02b", "GateEnterTruck", "GateEnterTruck02", 2, 1 )
					TppMission.SetFlag( "isSeq20_02_DriveEnd", 1 )
				end
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "GoTo_CenterBuilding" )) then
			if( RoutePointNumber == 7 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Mov_CenterHouse_b2" ) 	
				TppEnemy.DisableRoute( this.cpID , "GoTo_CenterBuilding" ) 	
				TppEnemy.ChangeRoute( this.cpID , "Seq20_02","e20010_Seq20_SneakRouteSet","S_Mov_CenterHouse_b2", 0 )	
			else
			end
		end
	end,

	
	EnterCenterTruck = function()
		local VehicleGroupInfo			= TppData.GetArgument(2)
		local VehicleGroupInfoName		= VehicleGroupInfo.routeInfoName
		local VehicleGroupResult		= VehicleGroupInfo.result
		local VehicleGroupReason		= VehicleGroupInfo.reason

		if( VehicleGroupInfoName == "TppGroupVehicleRouteInfo_Seq20_02a" ) then
			if( VehicleGroupResult == "SUCCESS" ) then
				if( TppMission.GetFlag( "isSeq20_02_DriveEnd" ) == 1 ) then
					TppMission.SetFlag( "isSeq20_02_DriveEnd", 2 )
					TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq20_02" , false )
					TppEnemy.EnableRoute( this.cpID , "GoTo_CenterBuilding" )
					TppEnemy.ChangeRoute( this.cpID , "Seq20_02","e20010_Seq20_SneakRouteSet","GoTo_CenterBuilding", 0 )
				else
					TppEnemy.EnableRoute( this.cpID , "S_Talk_AboutBoilar" )
					TppEnemy.ChangeRoute( this.cpID , "Seq20_02","e20010_Seq20_SneakRouteSet","S_Talk_AboutBoilar", 0 )
				end
			else
				TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq20_02" , false )
				TppEnemy.EnableRoute( this.cpID , "GoTo_CenterBuilding" )
				TppEnemy.ChangeRoute( this.cpID , "Seq20_02","e20010_Seq20_SneakRouteSet","GoTo_CenterBuilding", -1 )
			end
		elseif( VehicleGroupInfoName == "TppGroupVehicleRouteInfo_Seq20_02b" ) then
			if( VehicleGroupResult == "SUCCESS" ) then
				TppMission.SetFlag( "isSeq20_02_DriveEnd", 2 )
			else
			end
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq20_02" , false )
			TppEnemy.EnableRoute( this.cpID , "GoTo_CenterBuilding" )
			TppEnemy.ChangeRoute( this.cpID , "Seq20_02","e20010_Seq20_SneakRouteSet","GoTo_CenterBuilding", -1 )
		else
		end
	end,

	
	local_ConversationEnd = function()
		local label		= TppData.GetArgument(2)
		local judge		= TppData.GetArgument(4)
		if ( label == "CTE0010_0280") then
			if ( judge == true ) then
				if( TppMission.GetFlag( "isCTE0010_0280_NearArea" ) == true ) then
					TppRadio.Play("Miller_LeadSpHostageEscape")
				else
				end
			else
			end
			TppEnemy.EnableRoute( this.cpID , "GoToKillHostageArea" ) 				
			TppEnemy.EnableRoute( this.cpID , "S_Pat_SeaSide01b" ) 					
			TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide02b" )					
			TppEnemy.DisableRoute( this.cpID , "Seq20_04_Talk_KillHostage" )		
			TppEnemy.ChangeRoute( this.cpID , "Seq20_03","e20010_Seq20_SneakRouteSet","GoToKillHostageArea",0 )	
			TppEnemy.ChangeRoute( this.cpID , "Seq20_04","e20010_Seq20_SneakRouteSet","S_Pat_SeaSide01b",0 )	
		elseif ( label == "CTE0010_0290") then
			TppHostageUtility.SetHostageStatusInCp( "gntn_cp", "SpHostage", "HOSTAGE_STATUS_EXECUTE" )	
			TppMission.SetFlag( "isKillingSpHostage", true )
			TppEnemy.EnableRoute( this.cpID , "KillHostage01" ) 					
			TppEnemy.EnableRoute( this.cpID , "KillHostage02" ) 					
			TppEnemy.EnableRoute( this.cpID , "KillHostage03" ) 					
			TppEnemy.EnableRoute( this.cpID , "KillHostage04" ) 					
			TppEnemy.DisableRoute( this.cpID , "KillWaiting_Hostage01" )			
			TppEnemy.DisableRoute( this.cpID , "KillWaiting_Hostage02" )			
			TppEnemy.DisableRoute( this.cpID , "KillWaiting_Hostage03" )			
			TppEnemy.DisableRoute( this.cpID , "GoToKillHostageArea" )				
			TppEnemy.ChangeRoute( this.cpID , "Seq20_01","e20010_Seq20_SneakRouteSet","KillHostage01",0 )	
			TppEnemy.ChangeRoute( this.cpID , "ComEne13","e20010_Seq20_SneakRouteSet","KillHostage02",0 )	
			TppEnemy.ChangeRoute( this.cpID , "ComEne14","e20010_Seq20_SneakRouteSet","KillHostage03",0 )	
			TppEnemy.ChangeRoute( this.cpID , "Seq20_03","e20010_Seq20_SneakRouteSet","KillHostage04",0 )	
		elseif ( label == "CTE0010_0300") then
			TppMission.SetFlag( "isKillingSpHostage", false )
			TppEnemy.EnableRoute( this.cpID , "S_Waiting_Vehicle" ) 				
			TppEnemy.EnableRoute( this.cpID , "GoToWareHouse_ComEne13" ) 			
			TppEnemy.EnableRoute( this.cpID , "GoToWareHouse_ComEne14" ) 			
			TppEnemy.EnableRoute( this.cpID , "GoToWestCampWestGate_Seq20_03" ) 	
			TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter01" )				
			TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter02" )				
			TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter03" )				
			TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter04" )				
			TppEnemy.ChangeRoute( this.cpID , "Seq20_01","e20010_Seq20_SneakRouteSet","S_Waiting_Vehicle",0 )	
			TppEnemy.ChangeRoute( this.cpID , "ComEne13","e20010_Seq20_SneakRouteSet","GoToWareHouse_ComEne13",0 )	
			TppEnemy.ChangeRoute( this.cpID , "ComEne14","e20010_Seq20_SneakRouteSet","GoToWareHouse_ComEne14",0 )	
			TppEnemy.ChangeRoute( this.cpID , "Seq20_03","e20010_Seq20_SneakRouteSet","GoToWestCampWestGate_Seq20_03",0 )	
		elseif ( label == "CTE0010_0340") then
			local LightState	= TppGadgetManager.GetGadgetStatus( "gntn_center_SwitchLight" )

			TppEnemy.EnableRoute( this.cpID , "S_TalkingDelatetape_After01" ) 				
			TppEnemy.DisableRoute( this.cpID , "S_GetOut_Boilar01" )						
			TppEnemy.DisableRoute( this.cpID , "S_GetOut_Boilar02" )						
			TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq20_SneakRouteSet","S_TalkingDelatetape_After01",0 )	
			
			if ( LightState == 2 ) then		
				TppEnemy.EnableRoute( this.cpID , "ComEne31_SwitchOFF_v2" ) 				
				TppEnemy.ChangeRoute( this.cpID , "ComEne32","e20010_Seq20_SneakRouteSet","ComEne31_SwitchOFF_v2",0 )	
			else
				TppEnemy.EnableRoute( this.cpID , "S_TalkingDelatetape_After02" ) 				
				TppEnemy.ChangeRoute( this.cpID , "ComEne32","e20010_Seq20_SneakRouteSet","S_TalkingDelatetape_After02",0 )	
			end
		elseif ( label == "CTE0010_0380") then
			TppEnemy.EnableRoute( this.cpID , "S_SearchSpHostage06a" ) 					
			TppEnemy.EnableRoute( this.cpID , "S_SearchSpHostage07a" ) 					
			TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage05b" )					
			TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage03" )					
			TppEnemy.ChangeRoute( this.cpID , "Seq20_04","e20010_Seq20_SneakRouteSet","S_SearchSpHostage06a",0 )	
			TppEnemy.ChangeRoute( this.cpID , "Seq20_01","e20010_Seq20_SneakRouteSet","S_SearchSpHostage07a",0 )	
		elseif ( label == "CTE0010_0390") then
			TppEnemy.EnableRoute( this.cpID , "GoToEastcampSouthGate" ) 				
			TppEnemy.DisableRoute( this.cpID , "S_Sen_EastCampCenter_East02" )						
			TppEnemy.ChangeRoute( this.cpID , "ComEne01","e20010_Seq20_SneakRouteSet","GoToEastcampSouthGate",0 )	
		end
	end,
	
	ComEne18_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_HeliPort_2manSeparate02" )) then
			if( RoutePointNumber == 12 ) then
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2mancell_back" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2manSeparate01" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne19","e20010_Seq20_SneakRouteSet","S_HeliPort_2mancell_back", 0 )	
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2mancell_back" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2manSeparate02" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne18","e20010_Seq20_SneakRouteSet","S_HeliPort_2mancell_back", 0 )	
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "S_HeliPort_2mancell_back" )) then
			if( RoutePointNumber == 6 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortBehind_a" ) 	
				TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortBehind_b" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_back" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_back" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne18","e20010_Seq20_SneakRouteSet","S_Sen_HeliPortBehind_a", 0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne19","e20010_Seq20_SneakRouteSet","S_Sen_HeliPortBehind_b", 0 )	
			else
			end
		end
	end,
	
	ComEne19_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Sen_HeliPortBehind_b" )) then
			if( RoutePointNumber == 4 ) then
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2mancell_go" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Sen_HeliPortBehind_b" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne19","e20010_Seq20_SneakRouteSet","S_HeliPort_2mancell_go", 0 )	
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2mancell_go" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Sen_HeliPortBehind_a" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne18","e20010_Seq20_SneakRouteSet","S_HeliPort_2mancell_go", 0 )	
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "S_HeliPort_2mancell_go" )) then
			if( RoutePointNumber == 9 ) then
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2manSeparate01" ) 	
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2manSeparate02" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_go" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_go" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne18","e20010_Seq20_SneakRouteSet","S_HeliPort_2manSeparate02", 0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne19","e20010_Seq20_SneakRouteSet","S_HeliPort_2manSeparate01", 0 )	
			else
			end
		end
	end,
	
	ComEne25_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Mov_Center_d" )) then
			if( RoutePointNumber == 5 ) then										
				if( TppMission.GetFlag( "isCenterBackEnter" ) == true ) then
					TppEnemy.EnableRoute( this.cpID , "S_Ret_Center_d" ) 	
					TppEnemy.DisableRoute( this.cpID , "S_Mov_Center_d" ) 	
					TppEnemy.ChangeRoute( this.cpID , "ComEne25","e20010_Seq20_SneakRouteSet","S_Ret_Center_d", 0 )	
				else
				end
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "S_Ret_Center_d" )) then
			if( RoutePointNumber == 8 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_d" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Ret_Center_d" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne25","e20010_Seq20_SneakRouteSet","S_Sen_Center_d", 0 )	
			else
			end
		end
	end,
	
	ComEne29_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Mov_Center_2Fto1F" )) then
			if( RoutePointNumber == 15 ) then										
				TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_e" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Mov_Center_2Fto1F" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne29","e20010_Seq20_SneakRouteSet","S_Sen_Center_e", 0 )	
			else
			end
		else
		end
	end,
	
	ComEne31_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		local LightState	= TppGadgetManager.GetGadgetStatus( "gntn_center_SwitchLight" )
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_TalkingDelatetape_After01" )) then
			if( RoutePointNumber == 13 ) then										
				TppEnemy.DisableRoute( this.cpID , "S_TalkingDelatetape_After01" ) 	
				
				if ( LightState == 2 ) then		
					TppEnemy.EnableRoute( this.cpID , "ComEne31_SwitchOFF_v3" ) 	
					TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq20_SneakRouteSet","ComEne31_SwitchOFF_v3", 0 )	
				else
					TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_f" ) 	
					TppEnemy.ChangeRoute( this.cpID , "ComEne31","e20010_Seq20_SneakRouteSet","S_Sen_Center_f", 0 )	
				end
			else
			end
		else
		end
	end,
	
	Seq20_01_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_SearchSpHostage07a" )) then
			if( RoutePointNumber == 7 ) then
				TppEnemy.EnableRoute( this.cpID , "S_SearchSpHostage07b" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage07a" )	
				TppEnemy.ChangeRoute( this.cpID , "Seq20_01","e20010_Seq20_SneakRouteSet","S_SearchSpHostage07b",0 )	
			else
			end
		else
		end
	end,
	
	Seq20_03_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Pat_SeaSide02a" )) then
			if( RoutePointNumber == 8 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Pat_SeaSide02c" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide02a" )	
				TppEnemy.ChangeRoute( this.cpID , "Seq20_03","e20010_Seq20_SneakRouteSet","S_Pat_SeaSide02c",0 )	
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "GoToKillHostageArea" )) then
			if( RoutePointNumber == 37 ) then
				TppHostageUtility.SetHostageStatusInCp( "gntn_cp", "SpHostage", "HOSTAGE_STATUS_EXECUTE" )	
				TppMission.SetFlag( "isKillingSpHostage", true )
				TppEnemy.EnableRoute( this.cpID , "KillHostage01" ) 					
				TppEnemy.EnableRoute( this.cpID , "KillHostage02" ) 					
				TppEnemy.EnableRoute( this.cpID , "KillHostage03" ) 					
				TppEnemy.EnableRoute( this.cpID , "KillHostage04" ) 					
				TppEnemy.DisableRoute( this.cpID , "KillWaiting_Hostage01" )			
				TppEnemy.DisableRoute( this.cpID , "KillWaiting_Hostage02" )			
				TppEnemy.DisableRoute( this.cpID , "KillWaiting_Hostage03" )			
				TppEnemy.DisableRoute( this.cpID , "GoToKillHostageArea" )				
				TppEnemy.ChangeRoute( this.cpID , "Seq20_01","e20010_Seq20_SneakRouteSet","KillHostage01",0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne13","e20010_Seq20_SneakRouteSet","KillHostage02",0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne14","e20010_Seq20_SneakRouteSet","KillHostage03",0 )	
				TppEnemy.ChangeRoute( this.cpID , "Seq20_03","e20010_Seq20_SneakRouteSet","KillHostage04",0 )	
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "GoToWestCampWestGate_Seq20_03" )) then
			if( RoutePointNumber == 4 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_WestCamp_WestGate" ) 	
				TppEnemy.DisableRoute( this.cpID , "GoToWestCampWestGate_Seq20_03" )	
				TppEnemy.ChangeRoute( this.cpID , "Seq20_03","e20010_Seq20_SneakRouteSet","S_Sen_WestCamp_WestGate",0 )
			else
			end
		end
	end,
	
	Seq20_04_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Pat_SeaSide01a" )) then
			if( RoutePointNumber == 5 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Pat_SeaSide01b" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide01a" )	
				TppEnemy.ChangeRoute( this.cpID , "Seq20_04","e20010_Seq20_SneakRouteSet","S_Pat_SeaSide01b",0 )	
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "S_SearchSpHostage06a" )) then
			if( RoutePointNumber == 5 ) then
				TppEnemy.EnableRoute( this.cpID , "S_SearchSpHostage06b" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_SearchSpHostage06a" )	
				TppEnemy.ChangeRoute( this.cpID , "Seq20_04","e20010_Seq20_SneakRouteSet","S_SearchSpHostage06b",0 )	
			else
			end
		end
	end,
	
	Seq20_05_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "OutDoorFromWareHouse" )) then
			if( RoutePointNumber == 8 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_WareHousePloofUnder" ) 	
				TppEnemy.DisableRoute( this.cpID , "OutDoorFromWareHouse" )	
				TppEnemy.ChangeRoute( this.cpID , "Seq20_05","e20010_Seq20_SneakRouteSet","S_Sen_WareHousePloofUnder",0 )	
			else
			end
		else
		end
	end,
	
	ComEne01_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "GoToEastcampSouthGate" )) then
			if( RoutePointNumber == 13 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_EastCamp_SouthLeftGate" ) 	
				TppEnemy.DisableRoute( this.cpID , "GoToEastcampSouthGate" )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne01","e20010_Seq20_SneakRouteSet","S_Sen_EastCamp_SouthLeftGate",0 )	
			else
			end
		else
		end
	end,
	
	ComEne11_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Pat_EastCamp_North" )) then
			if( RoutePointNumber == 13 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_EastCamp_NorthLeftGate" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Pat_EastCamp_North" )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne11","e20010_Seq20_SneakRouteSet","S_Sen_EastCamp_NorthLeftGate",0 )	
			else
			end
		else
		end
	end,
	
	ComEne13_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "GoToWareHouse_ComEne13" )) then
			if( RoutePointNumber == 8 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_WareHouseKeeper01" ) 	
				TppEnemy.DisableRoute( this.cpID , "GoToWareHouse_ComEne13" )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne13","e20010_Seq20_SneakRouteSet","S_Sen_WareHouseKeeper01",0 )	
			else
			end
		else
		end
	end,
	
	ComEne14_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "GoToWareHouse_ComEne14" )) then
			if( RoutePointNumber == 9 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_WareHouseKeeper02" ) 	
				TppEnemy.DisableRoute( this.cpID , "GoToWareHouse_ComEne14" )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne14","e20010_Seq20_SneakRouteSet","S_Sen_WareHouseKeeper02",0 )	
			else
			end
		else
		end
	end,
	
	SpHostageIsDead = function()
		local status = TppEnemyUtility.GetLifeStatusByRoute( "gntn_cp" , "KillHostage01" )
		if( TppMission.GetFlag( "isSpHostageKillVersion" ) == true ) then
			if( TppMission.GetFlag( "isKillingSpHostage" ) == true ) and ( status == "Normal" ) then	
				TppEnemy.EnableRoute( this.cpID , "SpHostageKillAfter01" ) 	
				TppEnemy.EnableRoute( this.cpID , "SpHostageKillAfter02" ) 	
				TppEnemy.EnableRoute( this.cpID , "SpHostageKillAfter03" ) 	
				TppEnemy.EnableRoute( this.cpID , "SpHostageKillAfter04" ) 	
				TppEnemy.DisableRoute( this.cpID , "KillHostage01" ) 	
				TppEnemy.DisableRoute( this.cpID , "KillHostage02" ) 	
				TppEnemy.DisableRoute( this.cpID , "KillHostage03" ) 	
				TppEnemy.DisableRoute( this.cpID , "KillHostage04" ) 	
				TppEnemy.ChangeRoute( this.cpID , "Seq20_01","e20010_Seq20_SneakRouteSet","SpHostageKillAfter01", 0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne13","e20010_Seq20_SneakRouteSet","SpHostageKillAfter02", 0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne14","e20010_Seq20_SneakRouteSet","SpHostageKillAfter03", 0 )	
				TppEnemy.ChangeRoute( this.cpID , "Seq20_03","e20010_Seq20_SneakRouteSet","SpHostageKillAfter04", 0 )	
			else	
				TppEnemy.EnableRoute( this.cpID , "S_Waiting_Vehicle" ) 				
				TppEnemy.EnableRoute( this.cpID , "GoToWareHouse_ComEne13" ) 			
				TppEnemy.EnableRoute( this.cpID , "GoToWareHouse_ComEne14" ) 			
				TppEnemy.EnableRoute( this.cpID , "GoToWestCampWestGate_Seq20_03" ) 	
				TppEnemy.DisableRoute( this.cpID , "KillHostage01" ) 					
				TppEnemy.DisableRoute( this.cpID , "KillHostage02" ) 					
				TppEnemy.DisableRoute( this.cpID , "KillHostage03" ) 					
				TppEnemy.DisableRoute( this.cpID , "KillHostage04" ) 					
				TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter01" )				
				TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter02" )				
				TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter03" )				
				TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter04" )				
				TppEnemy.DisableRoute( this.cpID , "GoToKillHostageArea" )				
				TppEnemy.ChangeRoute( this.cpID , "Seq20_01","e20010_Seq20_SneakRouteSet","S_Waiting_Vehicle",0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne13","e20010_Seq20_SneakRouteSet","GoToWareHouse_ComEne13",0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne14","e20010_Seq20_SneakRouteSet","GoToWareHouse_ComEne14",0 )	
				TppEnemy.ChangeRoute( this.cpID , "Seq20_03","e20010_Seq20_SneakRouteSet","GoToWestCampWestGate_Seq20_03",0 )	
			end
			TppMission.SetFlag( "isKillingSpHostage", false )
		else
		end
	end,
	
	SpHostage_EnemyLost = function()

		TppHostageUtility.SetHostageStatusInCp( "gntn_cp", "SpHostage", "HOSTAGE_STATUS_LOST" )
		TppMission.SetFlag( "isKillingSpHostage", false )
		TppEnemy.EnableRoute( this.cpID , "S_Waiting_Vehicle" ) 				
		TppEnemy.EnableRoute( this.cpID , "GoToWareHouse_ComEne13" ) 			
		TppEnemy.EnableRoute( this.cpID , "GoToWareHouse_ComEne14" ) 			
		TppEnemy.EnableRoute( this.cpID , "GoToWestCampWestGate_Seq20_03" ) 	
		TppEnemy.DisableRoute( this.cpID , "KillHostage01" ) 					
		TppEnemy.DisableRoute( this.cpID , "KillHostage02" ) 					
		TppEnemy.DisableRoute( this.cpID , "KillHostage03" ) 					
		TppEnemy.DisableRoute( this.cpID , "KillHostage04" ) 					
		TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter01" )				
		TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter02" )				
		TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter03" )				
		TppEnemy.DisableRoute( this.cpID , "SpHostageKillAfter04" )				
		TppEnemy.DisableRoute( this.cpID , "GoToKillHostageArea" )				
		TppEnemy.ChangeRoute( this.cpID , "Seq20_01","e20010_Seq20_SneakRouteSet","S_Waiting_Vehicle",0 )	
		TppEnemy.ChangeRoute( this.cpID , "ComEne13","e20010_Seq20_SneakRouteSet","GoToWareHouse_ComEne13",0 )	
		TppEnemy.ChangeRoute( this.cpID , "ComEne14","e20010_Seq20_SneakRouteSet","GoToWareHouse_ComEne14",0 )	
		TppEnemy.ChangeRoute( this.cpID , "Seq20_03","e20010_Seq20_SneakRouteSet","GoToWestCampWestGate_Seq20_03",0 )	
	end,
	
	Radio_ChicoRV = function()







	end,
	
	Radio_NearRV = function()
		if( TppMission.GetFlag( "isQuestionChico" ) == false ) then			
			if( TppPlayerUtility.IsCarriedCharacter( "Chico" )) then		
				TppRadio.DelayPlayEnqueue( "Miller_NearRV", "short" )
			else															
			end

		





		else																
			if( TppMission.GetFlag( "isChicoTapePlay" ) == false ) then		
				local radioDaemon = RadioDaemon:GetInstance()
				if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0110") == false ) then
					TppRadio.Play( "Miller_ChicoTapeAdvice02" )
					e20010_require_01.Check_AlertTapeReAdvice()	
				end
			else
			end
		end
	end,
	
	Radio_ArriveRV = function()

		if( TppMission.GetFlag( "isQuestionChico" ) == false ) then		
			if( TppPlayerUtility.IsCarriedCharacter( "Chico" )) then	
				local phase = TppEnemy.GetPhase( this.cpID )
				if ( phase == "alert" ) then

					
					local checkPos = Vector3( 127.0,14.5,112.0)
					local size = Vector3( 30.0,24.0,45.0)
					local npcIds = TppNpcUtility.GetNpcByBoxShape( checkPos, size )

					local eneNum = 0
					if npcIds and #npcIds.array > 0 then
						for i,id in ipairs(npcIds.array) do
								local type = TppNpcUtility.GetNpcType( id )
								if type == "Enemy" then
										
										local status = TppEnemyUtility.GetLifeStatus( id )
										if (status =="Dead" or status =="Sleep" or status =="Faint" )then
										else
											eneNum = eneNum + 1
									end
								end
						end
					end




					if Check_SafetyArea_enemy("eneCheck_seaside",eneCheckSize_seaside) == true then
						TppRadio.Play( "Miller_ArriveRVChicoNearEnemy" )
					else
						TppRadio.Play( "Miller_ArriveRVChicoAlert" )
					end
					TppRadio.RegisterOptionalRadio( "Optional_RideHeliPaz" )	
				else
					if( TppMission.GetFlag( "isHeliComeToSea" ) == false ) then	
						TppRadio.Play( "Miller_ArriveRVChico" )
					
						TppRadio.RegisterOptionalRadio( "Optional_OnRVChico" )	
				
					end
				end
				TppMarkerSystem.DisableMarker{ markerId = "20010_marker_RV" }
			else													
			end
		else														
		end
	end,
	
	Radio_ArriveRVExit = function()
		if( TppMission.GetFlag( "isQuestionChico" ) == false ) then		

		else														
		
		end
	end,
	
	Radio_PazTakeRoute_Camp = function()
	



	end,
	
	Radio_PazTakeRoute_HeliPort = function()
		local radioDaemon = RadioDaemon:GetInstance()
		if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1272") == true ) then

			TppRadio.Play("Miller_PazTakeRouteInHeliport")
		else																	
			if( TppMission.GetFlag( "isCenterEnter" ) == false ) then			
				e20010_require_01.OnVehicleCheckRadioPlay("Miller_InHeliport")
			end
		end
	end,
	
	Radio_PazTakeRoute_Gate = function()
		local radioDaemon = RadioDaemon:GetInstance()
		if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1273") == true ) then

			TppRadio.Play("Miller_PazTakeRouteInGate")
		else																	
		end
	end,
	
	Radio_PazTakeRoute_Boilar = function()
		local radioDaemon = RadioDaemon:GetInstance()
		if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1275") == true ) then

		
		else																
		end
	end,
	
	Radio_PazTakeRoute_Flag = function()
		local radioDaemon = RadioDaemon:GetInstance()
		if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1271") == true ) then

			TppRadio.Play("Miller_PazTakeRouteInFlag")
		else																
		end
	end,
	
	Radio_CliffAttention = function()
		if( TppMission.GetFlag( "isQuestionChico" ) == false ) then		
			TppRadio.Play( "Miller_CliffAttention" )
		end
	end,

	
	ChicoCarriedStart = function()

		local phase = TppEnemy.GetPhase( this.cpID )

	
		TppMission.SetFlag( "isPazChicoDemoArea", false )

		if ( phase == "alert" ) then
			
		else
			if( TppMission.GetFlag( "isChicoPaz1stCarry" ) == false ) then
				TppMusicManager.PostJingleEvent( 'SuspendPhase', 'Play_bgm_e20010_jingle_rescue' )
				TppMission.SetFlag( "isChicoPaz1stCarry", true )
			else
			end
		end

	end,

	
	Seq_QuestionChicoDemo_OnlyOnce = function()




		
		local status = TppHostageUtility.GetStatus( "Chico" )



		if( status == "RideOnHelicopter" )then
			



			local sequence = TppSequence.GetCurrentSequence()
			if( TppMission.GetFlag( "isCassetteDemo" ) == false and sequence == "Seq_NextRescuePaz" and TppMission.GetFlag( "isChicoTapePlay" ) == false )then



				TppSequence.ChangeSequence( "Seq_CassetteDemo" )

				return
			end
		end

		
		if( CheckDemoCondition() == true ) then			



			if( TppMission.GetFlag( "isQuestionChico" ) == false ) then		



				TppHostageManager.GsSetSpecialFaintFlag( "Chico", true ) 
				TppSequence.ChangeSequence( "Seq_QuestionChicoDemo" )
			else														



				
			end
		elseif( Check_SafetyArea() == true		
		and TppMission.GetFlag( "isHeliComeToSea" ) == false ) then



			if( TppMission.GetFlag( "isQuestionChico" ) == false ) then		
				TppMission.SetFlag( "isPazChicoDemoArea", true )
			end
		elseif( TppMission.GetFlag( "isDangerArea" ) == true ) then			



			TppRadio.DelayPlayEnqueue("Miller_CarryDownInDanger", "short")
		end
	end,

	
	Seq_RescueDemo_OnlyOnce = function()
		
		

			
			if( (TppData.GetArgument( 1 ) == "Paz_PickingDoor00" )) then
				TppMission.SetFlag( "isPazChicoDemoArea", false )
				TppSequence.ChangeSequence( "Seq_RescuePazDemo" )
			end
	end,


	
	Chico_Monologue = function( manager, messageId, characterId, characterHandle, trapBodyHandle, trapName )

		
		if( TppPlayerUtility.IsCarriedCharacter( "Chico" )) then

			local obj = Ch.FindCharacterObjectByCharacterId("Chico")

			if not Entity.IsNull(obj) then
				TppHostageManager.GsSetSpecialFaintFlag( "Chico", false )
				TppHostageManager.GsSetSpecialIdleFlag( "Chico", false )
				TppEnemyUtility.CallCharacterMonologue( "CHCD_0010" , 3, obj, true )
				trapBodyHandle:SetInvalid() 
			end
		else
		end
	end,
	
	Chico_Monologue02 = function( manager, messageId, characterId, characterHandle, trapBodyHandle, trapName )

		
		if( TppPlayerUtility.IsCarriedCharacter( "Chico" )) then

			local obj = Ch.FindCharacterObjectByCharacterId("Chico")

			if not Entity.IsNull(obj) then
				TppHostageManager.GsSetSpecialFaintFlag( "Chico", false )
				TppHostageManager.GsSetSpecialIdleFlag( "Chico", false )
				TppEnemyUtility.CallCharacterMonologue( "CHCD_0020" , 3, obj, true )
				trapBodyHandle:SetInvalid() 
			end
		else
		end
	end,
	
	Chico_Monologue03 = function( manager, messageId, characterId, characterHandle, trapBodyHandle, trapName )

		
		if( TppPlayerUtility.IsCarriedCharacter( "Chico" )) then

			local obj = Ch.FindCharacterObjectByCharacterId("Chico")

			if not Entity.IsNull(obj) then
				TppHostageManager.GsSetSpecialFaintFlag( "Chico", false )
				TppHostageManager.GsSetSpecialIdleFlag( "Chico", false )
				TppEnemyUtility.CallCharacterMonologue( "CHCD_0030" , 3, obj, true )
				trapBodyHandle:SetInvalid() 
			end
		else
		end
	end,
	
	Chico_Monologue04 = function( manager, messageId, characterId, characterHandle, trapBodyHandle, trapName )

		
		if( TppPlayerUtility.IsCarriedCharacter( "Chico" )) then

			local obj = Ch.FindCharacterObjectByCharacterId("Chico")

			if not Entity.IsNull(obj) then
				TppHostageManager.GsSetSpecialFaintFlag( "Chico", false )
				TppHostageManager.GsSetSpecialIdleFlag( "Chico", false )
				TppEnemyUtility.CallCharacterMonologue( "CHCD_0040" , 3, obj, true )
				trapBodyHandle:SetInvalid() 
			end
		else
		end
	end,
}



this.Seq_NextRescueChico = {

	Messages = {
		Character = {
			myMessages.Character[1],
			myMessages.Character[2],
			{ data = "gntn_cp", message = "EndGroupVehicleRouteMove", localFunc = "GoToAsylum_End" },
			{ data = "Paz", message = "MessageHostageCarriedStart", commonFunc = function() e20010_require_01.PazCarryStart() end },

			{ data = "Paz", message = "MessageHostageCarriedEnd", localFunc = "Seq_QuestionPazDemo_OnlyOnce" },
			{ data = "Paz", message = "HostageLaidOnVehicle", commonFunc = function() e20010_require_01.Common_HostageOnVehicleInDangerArea() end },

			{ data = "Player", message = "TryPicking", localFunc = "Seq_RescueDemo_OnlyOnce"  },
			{ data = "ComEne09",	message = "MessageRoutePoint",	localFunc = "ComEne09_NodeAction" },
			{ data = "ComEne10",	message = "MessageRoutePoint",	localFunc = "ComEne10_NodeAction" },
			{ data = "ComEne18",	message = "MessageRoutePoint",	localFunc = "ComEne18_NodeAction" },
			{ data = "ComEne19",	message = "MessageRoutePoint",	localFunc = "ComEne19_NodeAction" },
			{ data = "ComEne24",	message = "MessageRoutePoint",	localFunc = "ComEne24_NodeAction" },
			{ data = "ComEne27",	message = "MessageRoutePoint",	localFunc = "ComEne27_NodeAction" },
			{ data = "ComEne30",	message = "MessageRoutePoint",	localFunc = "ComEne30_NodeAction" },
			{ data = "Seq40_01", message = "MessageRoutePoint",	localFunc = "Seq40_01_NodeAction" },
			{ data = "Seq40_02", message = "MessageRoutePoint",	localFunc = "Seq40_02_NodeAction" },
			{ data = "Seq40_03", message = "MessageRoutePoint",	localFunc = "Seq40_03_NodeAction" },
			{ data = "Seq40_08", message = "MessageRoutePoint",	localFunc = "Seq40_08_NodeAction" },
		},
		Trap = {
			myMessages.Trap[6],
			myMessages.Trap[8],
			myMessages.Trap[9],
			
			{ data = "Demo_EncounterChico", message = "Enter", commonFunc = function() Demo_eneChecker("chico") end },
			
		
			{ data = "Radio_NearRV", message = "Enter", localFunc = "Radio_NearRV" },
			{ data = "Radio_ArriveRV", message = "Enter", localFunc = "Radio_ArriveRV" },
			{ data = "Radio_ArriveRV", message = "Exit", localFunc = "Radio_ArriveRVExit" },
			{ data = "toAsylumGroupStart", message = "Enter", localFunc = "toAsylumGroupStart" },
			{ data = "ComEne24_RouteChange", message = "Enter", localFunc = "ComEne24_RouteChange" },
			{ data = "Seq40_ComEne27_RouteChange", message = "Enter", localFunc = "Seq40_ComEne27_RouteChange" },
			{ data = "Seq40_ArmorVehicle_Start", message = "Enter", localFunc = "Seq40_ArmorVehicle_Start" },
			{ data = "Radio_InOldAsylum", message = "Enter", commonFunc = function() e20010_require_01.OptionalRadio_InOldAsylum() end },	
			{ data = "Radio_InOldAsylum", message = "Exit", commonFunc = function() e20010_require_01.OptionalRadio_OutOldAsylum("Optional_RescuePazToRescueChico") end },	
		},
		Radio = {
		},
		RadioCondition = {
		
			myMessages.RadioCondition[2],	
		
		},
	},

	OnEnter = function( manager )
		local LightState	= TppGadgetManager.GetGadgetStatus( "gntn_center_SwitchLight" )
		
		Seq_NextRescueChico_RouteSet()
		
		WoodTurret_RainFilter_OFF()
		
		TppCommandPostObject.GsSetRealizeFirstPriorityByRoute( this.cpID , "S_Sen_HeliPortFrontGate_a" , false )
		TppCommandPostObject.GsSetRealizeFirstPriorityByRoute( this.cpID , "S_Sen_HeliPortFrontGate_b" , false )
		
		SetComplatePhoto()
		
		TppMission.SetFlag( "isFirstEncount_Chico", false )
		
		FirstPaz_Vehicle()
		
		TppSupportHelicopterService.SetDefaultRendezvousPointMarker("RV_SeaSide")
		
		WeatherManager.RequestWeather(2,0)
		
		Seq10Trap_Disable()
		Seq10_20Trap_Disable()
		Seq20Trap_Disable()
		Seq30Trap_Disable()
		Seq40Trap_Enable()
		
		ChengeChicoPazIdleMotion()
		
		Common_RetryKeepCautionSiren()
		
		ChicoDoor_ON_Close()
		PazDoor_ON_Open()
		
		All_Seq_MissionAreaOut()
		
		Seq10Enemy_Disable_Ver2()
		Seq20Enemy_Disable()
		Seq30Enemy_Disable()
		Seq40Enemy_Enable()
		
		SpHostage_Disable()
		
		Common_CenterBigGate_DefaultOpen()
		
		GuardTarget_Setting()
		
		TppEnemy.EnableRoute( this.cpID , "Seq40_PazCheck01" )
		TppEnemy.EnableRoute( this.cpID , "Seq40_PazCheck02" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_EastCamp_SouthLeftGate" )
		TppEnemy.EnableRoute( this.cpID , "S_Pat_WestCampOutLine" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_SeaSideEnter" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_WareHouseBehind" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_EastCamp_NorthLeftGate" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_WareHouse_NorthGate" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_WareHouseKeeper01" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_WareHouseKeeper02" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortFrontGate_a" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortFrontGate_b" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortHouse" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortBehind_a" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPort_Outline02" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortCenter_a" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortCenter_b" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortGateSide" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Bridge_3" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_EastCampCenter_East" )
		TppEnemy.EnableRoute( this.cpID , "S_Mov_CenterHouse_a2" )
		TppEnemy.EnableRoute( this.cpID , "S_Mov_CenterHouse_b2" )
		TppEnemy.EnableRoute( this.cpID , "Seq40_03_PreRideOnVehicle" )
		TppEnemy.EnableRoute( this.cpID , "Seq40_04_PreRideOnVehicle" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_SeasideNearBox" )
		TppEnemy.EnableRoute( this.cpID , "S_Pat_SeaSide_Seq40_06" )
		
		TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_go" )
		TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2manSeparate01" )
		TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2manSeparate02" )
		TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_back" )
		TppEnemy.DisableRoute( this.cpID , "GoToCenterB_2F_02" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterB_2F" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterBehind_a" )
		TppEnemy.DisableRoute( this.cpID , "S_GoTo_BoilarFront" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_BoilarFront" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_a" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_c" )
		TppEnemy.DisableRoute( this.cpID , "Seq40_03_RideOnVehicle" )
		TppEnemy.DisableRoute( this.cpID , "Seq40_04_RideOnVehicle" )
		TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret01_Route" )
		TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL02_Route" )
		TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL05_Route" )
		TppEnemy.DisableRoute( this.cpID , "S_Pat_FinalPazCheck" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Bridge" )
		
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "Seq40_PazCheck01" , 0 , "Seq40_01" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "Seq40_PazCheck02" , 0 , "Seq40_02" , "ROUTE_PRIORITY_TYPE_FORCED" )
		
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_SeasideNearBox" , 0 , "Seq40_05" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Pat_SeaSide_Seq40_06" , 0 , "Seq40_06" , "ROUTE_PRIORITY_TYPE_FORCED" )
		if( TppMission.GetFlag( "isWoodTurret05_Break" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_SL_Asylum" )
			TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret05_Route" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_SL_Asylum" , 0 , "Seq40_07" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "Break_WoodTurret05_Route" )
			TppEnemy.DisableRoute( this.cpID , "S_SL_Asylum" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "Break_WoodTurret05_Route" , 0 , "Seq40_07" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_EastCamp_SouthLeftGate" , 0 , "ComEne01" , "ROUTE_PRIORITY_TYPE_FORCED" )
		if( TppMission.GetFlag( "isWoodTurret04_Break" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_SL_WestCamp" )
			TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret04_Route" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_SL_WestCamp" , 0 , "ComEne02" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "Break_WoodTurret04_Route" )
			TppEnemy.DisableRoute( this.cpID , "S_SL_WestCamp" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "Break_WoodTurret04_Route" , 0 , "ComEne02" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Pat_WestCampOutLine" , 0 , "ComEne03" , "ROUTE_PRIORITY_TYPE_FORCED" )
		if( TppMission.GetFlag( "isIronTurretSL01_Break" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_SL_WareHouse01a" )
			TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL01_Route" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_SL_WareHouse01a" , 0 , "ComEne04" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "Break_IronTurretSL01_Route" )
			TppEnemy.DisableRoute( this.cpID , "S_SL_WareHouse01a" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "Break_IronTurretSL01_Route" , 0 , "ComEne04" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_SeaSideEnter" , 0 , "ComEne05" , "ROUTE_PRIORITY_TYPE_FORCED" )
		if( TppMission.GetFlag( "isWoodTurret03_Break" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_SL_EastCamp_North" )
			TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret03_Route" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_SL_EastCamp_North" , 0 , "ComEne06" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "Break_WoodTurret03_Route" )
			TppEnemy.DisableRoute( this.cpID , "S_SL_EastCamp_North" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "Break_WoodTurret03_Route" , 0 , "ComEne06" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_WareHouseBehind" , 0 , "ComEne07" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_EastCampCenter_East" , 0 , "ComEne08" , "ROUTE_PRIORITY_TYPE_FORCED" )
		
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_EastCamp_NorthLeftGate" , 0 , "ComEne11" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_WareHouse_NorthGate" , 0 , "ComEne12" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_WareHouseKeeper01" , 0 , "ComEne13" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_WareHouseKeeper02" , 0 , "ComEne14" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_HeliPortFrontGate_a" , 0 , "ComEne15" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_HeliPortFrontGate_b" , 0 , "ComEne16" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Bridge_3" , 0 , "ComEne17" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_HeliPortBehind_a" , 0 , "ComEne18" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_HeliPort_Outline02" , 0 , "ComEne19" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_HeliPortHouse" , 0 , "ComEne20" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_HeliPortCenter_a" , 0 , "ComEne21" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_HeliPortCenter_b" , 0 , "ComEne22" , "ROUTE_PRIORITY_TYPE_FORCED" )
		if( TppMission.GetFlag( "isIronTurretSL04_Break" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_SL_HeliPortTurret02" )
			TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL04_Route" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_SL_HeliPortTurret02" , 0 , "ComEne23" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "Break_IronTurretSL04_Route" )
			TppEnemy.DisableRoute( this.cpID , "S_SL_HeliPortTurret02" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "Break_IronTurretSL04_Route" , 0 , "ComEne23" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_HeliPortGateSide" , 0 , "ComEne30" , "ROUTE_PRIORITY_TYPE_FORCED" )
		if( TppMission.GetFlag( "isWoodTurret02_Break" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_SL_EastCamp_South_in" )
			TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret02_Route" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_SL_EastCamp_South_in" , 0 , "ComEne33" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "Break_WoodTurret02_Route" )
			TppEnemy.DisableRoute( this.cpID , "S_SL_EastCamp_South_in" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "Break_WoodTurret02_Route" , 0 , "ComEne33" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		if( TppMission.GetFlag( "isCenterTowerSL_Break" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_SL_HeliPortTower" )
			TppEnemy.DisableRoute( this.cpID , "Break_CenterTower_Route" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_SL_HeliPortTower" , 0 , "ComEne34" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "Break_CenterTower_Route" )
			TppEnemy.DisableRoute( this.cpID , "S_SL_HeliPortTower" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "Break_CenterTower_Route" ,0 , "ComEne34" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Mov_CenterHouse_a2" , 0 , "Seq10_06" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Mov_CenterHouse_b2" , 0 , "Seq10_07" , "ROUTE_PRIORITY_TYPE_FORCED" )

		
		if ( LightState == 2 ) then		
			TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "ComEne24_RouteChange", false , false )
			TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq40_ComEne27_RouteChange", false , false )
			TppEnemy.EnableRoute( this.cpID , "ComEne24_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne25_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne26_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne27_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne28_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne29_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne31_SwitchOFF_v2" )
			TppEnemy.EnableRoute( this.cpID , "ComEne32_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_HeliPortBigGate" )
			TppEnemy.DisableRoute( this.cpID , "GoToCenterB_2F_02" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_d" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_a" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterBack" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterBack" )
			TppEnemy.DisableRoute( this.cpID , "S_GoTo_BoilarFront" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_Middle2" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_Middle" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne24_SwitchOFF" , 0 , "ComEne24" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne25_SwitchOFF" , 0 , "ComEne25" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne26_SwitchOFF" , 0 , "ComEne26" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne27_SwitchOFF" , 0 , "ComEne27" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne28_SwitchOFF" , 0 , "ComEne28" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne29_SwitchOFF" , 0 , "ComEne29" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne31_SwitchOFF_v2" , 0 , "ComEne31" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne32_SwitchOFF" , 0 , "ComEne32" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortBigGate" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_d" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_a" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_CenterBack" )
			TppEnemy.EnableRoute( this.cpID , "S_Mov_Smoking_Center" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_e" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_Middle2" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_Middle" )
			TppEnemy.DisableRoute( this.cpID , "ComEne24_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne25_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne26_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne27_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne28_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne29_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne31_SwitchOFF_v2" )
			TppEnemy.DisableRoute( this.cpID , "ComEne32_SwitchOFF" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_HeliPortBigGate" , -1 , "ComEne24" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Center_d" , -1 , "ComEne25" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Center_a" , -1 , "ComEne26" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_CenterBack" , -1 , "ComEne27" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Mov_Smoking_Center" , -1 , "ComEne28" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Center_e" , -1 , "ComEne29" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Boilar_Middle2" , -1 , "ComEne31" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Boilar_Middle" , -1 , "ComEne32" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		
		if( TppMission.GetFlag( "isQuestionPaz" ) == true ) then				
			
			ChicoPazQustionDemoAfterReStart()
			TppMarkerSystem.DisableMarker{ markerId = "20010_marker_RV" }		

			if( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then
				commonUiMissionSubGoalNo(1)	
			else
				commonUiMissionSubGoalNo(7)	
			end
			
			TppEnemy.EnableRoute( this.cpID , "S_Pat_SeaSide_To_Asylum01" ) 					
			TppEnemy.EnableRoute( this.cpID , "S_Pat_SeaSide_To_Asylum02" ) 					
			TppEnemy.DisableRoute( this.cpID , "S_Sen_AsylumOutSideGate_a" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_AsylumOutSideGate_b" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Pat_SeaSide_To_Asylum01" , 0 , "ComEne09" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Pat_SeaSide_To_Asylum02" , 0 , "ComEne10" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else															
			
			TppMissionManager.SaveGame("30")
			if( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then
				commonUiMissionSubGoalNo(1)	
			else
				commonUiMissionSubGoalNo(6)	
			end
			
			AnounceLog_enemyReplacement()
			
			Paz_MarkerON()				
			Asylum_MarkerON()			
			RV_MarkerON()				
			TppMarkerSystem.DisableMarker{ markerId = "20010_marker_Paz" }
			TppMarkerSystem.DisableMarker{ markerId = "Marker_Duct" }			
			
			TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumOutSideGate_a" ) 					
			TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumOutSideGate_b" ) 					
			TppEnemy.EnableRoute( this.cpID , "Seq40_03_PreRideOnVehicle" ) 					
			TppEnemy.EnableRoute( this.cpID , "Seq40_04_PreRideOnVehicle" ) 						
			TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide_To_Asylum01" )
			TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide_To_Asylum02" )
			TppEnemy.DisableRoute( this.cpID , "Seq40_03_RideOnVehicle" )
			TppEnemy.DisableRoute( this.cpID , "Seq40_04_RideOnVehicle" )
			TppEnemy.DisableRoute( this.cpID , "S_Pat_Asylum_OutSideAround" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_AsylumBehind" )
			TppEnemy.DisableRoute( this.cpID , "GoTo_AsylumInside01a" )
			TppEnemy.DisableRoute( this.cpID , "GoTo_AsylumInside02b" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_AsylumOutSideGate_c" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_AsylumOutSideGate_b" , -1 , "ComEne09" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_AsylumOutSideGate_a" , -1 , "ComEne10" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "Seq40_03_PreRideOnVehicle" , -1 , "Seq40_03" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "Seq40_04_PreRideOnVehicle" , -1 , "Seq40_04" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		
		SetIntelRadio()
		
		SetOptionalRadio()

	end,
	
	GoToAsylum_End = function()
		local VehicleGroupInfo			= TppData.GetArgument(2)
		local VehicleGroupInfoName		= VehicleGroupInfo.routeInfoName
		local VehicleGroupResult		= VehicleGroupInfo.result
		local VehicleGroupReason		= VehicleGroupInfo.reason
		if( VehicleGroupInfoName == "TppGroupVehicleRouteInfo_Seq40_0304" ) then
			if( VehicleGroupResult == "SUCCESS" ) then
				TppMission.SetFlag( "isSeq40_0304_DriveEnd" , 2 )
			else		
			end
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq40_03" , false )
			TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq40_04" , false )
			
			TppEnemy.EnableRoute( this.cpID , "GoTo_AsylumInside01a" )
			TppEnemy.EnableRoute( this.cpID , "GoTo_AsylumInside02b" )
			TppEnemy.ChangeRoute( this.cpID , "Seq40_03","e20010_Seq40_SneakRouteSet","GoTo_AsylumInside01a", 0 )
			TppEnemy.ChangeRoute( this.cpID , "Seq40_04","e20010_Seq40_SneakRouteSet","GoTo_AsylumInside02b", 0 )
		else
		end
	end,
	
	ComEne09_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Pat_SeaSide_To_Asylum01" )) then
			if( RoutePointNumber == 12 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumOutSideGate_b" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide_To_Asylum01" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne09","e20010_Seq40_SneakRouteSet","S_Sen_AsylumOutSideGate_b", 0 )	
			else
			end
		else
		end
	end,
	
	ComEne10_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Pat_SeaSide_To_Asylum02" )) then
			if( RoutePointNumber == 16 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumOutSideGate_a" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Pat_SeaSide_To_Asylum02" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne10","e20010_Seq40_SneakRouteSet","S_Sen_AsylumOutSideGate_a", 0 )	
			else
			end
		else
		end
	end,
	
	ComEne18_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_HeliPort_2manSeparate02" )) then
			if( RoutePointNumber == 12 ) then
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2mancell_back" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2manSeparate01" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne19","e20010_Seq40_SneakRouteSet","S_HeliPort_2mancell_back", 0 )	
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2mancell_back" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2manSeparate02" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne18","e20010_Seq40_SneakRouteSet","S_HeliPort_2mancell_back", 0 )	
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "S_HeliPort_2mancell_back" )) then
			if( RoutePointNumber == 6 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortBehind_a" ) 	
				TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortBehind_b" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_back" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_back" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne18","e20010_Seq40_SneakRouteSet","S_Sen_HeliPortBehind_a", 0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne19","e20010_Seq40_SneakRouteSet","S_Sen_HeliPortBehind_b", 0 )	
			else
			end
		end
	end,
	
	ComEne19_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Sen_HeliPortBehind_b" )) then
			if( RoutePointNumber == 4 ) then
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2mancell_go" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Sen_HeliPortBehind_b" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne19","e20010_Seq40_SneakRouteSet","S_HeliPort_2mancell_go", 0 )	
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2mancell_go" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_Sen_HeliPortBehind_a" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne18","e20010_Seq40_SneakRouteSet","S_HeliPort_2mancell_go", 0 )	
			else
			end
		elseif ( RouteName ==  GsRoute.GetRouteId( "S_HeliPort_2mancell_go" )) then
			if( RoutePointNumber == 9 ) then
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2manSeparate01" ) 	
				TppEnemy.EnableRoute( this.cpID , "S_HeliPort_2manSeparate02" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_go" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_HeliPort_2mancell_go" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne18","e20010_Seq40_SneakRouteSet","S_HeliPort_2manSeparate02", 0 )	
				TppEnemy.ChangeRoute( this.cpID , "ComEne19","e20010_Seq40_SneakRouteSet","S_HeliPort_2manSeparate01", 0 )	
			else
			end
		end
	end,
	
	ComEne24_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "GoToCenterB_2F_02" )) then
			if( RoutePointNumber == 4 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_CenterB_2F" ) 	
				TppEnemy.DisableRoute( this.cpID , "GoToCenterB_2F_02" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne24","e20010_Seq40_SneakRouteSet","S_Sen_CenterB_2F", 0 )	
			else
			end
		else
		end
	end,
	
	ComEne27_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_GoTo_BoilarFront" )) then
			if( RoutePointNumber == 3 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_BoilarFront" ) 	
				TppEnemy.DisableRoute( this.cpID , "S_GoTo_BoilarFront" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne27","e20010_Seq40_SneakRouteSet","S_Sen_BoilarFront", 0 )	
			else
			end
		else
		end
	end,
	
	ComEne30_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "GoToCenterB_Door" )) then
			if( RoutePointNumber == 5 ) then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_CenterBehind_a" ) 	
				TppEnemy.DisableRoute( this.cpID , "GoToCenterB_Door" ) 	
				TppEnemy.ChangeRoute( this.cpID , "ComEne30","e20010_Seq40_SneakRouteSet","S_Sen_CenterBehind_a", 0 )	
			else
			end
		else
		end
	end,
	
	Seq40_01_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "Seq40_PazCheck01" )) then
			if( RoutePointNumber == 10 ) then										
				TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_a" )
				TppEnemy.DisableRoute( this.cpID , "Seq40_PazCheck01" )
				TppEnemy.ChangeRoute( this.cpID , "Seq40_01","e20010_Seq40_SneakRouteSet","S_Sen_Boilar_a", 0 )
			else
			end
		else
		end
	end,
	
	Seq40_02_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "Seq40_PazCheck02" )) then
			if( RoutePointNumber == 23 ) then										
				TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_c" )
				TppEnemy.DisableRoute( this.cpID , "Seq40_PazCheck02" )
				TppEnemy.ChangeRoute( this.cpID , "Seq40_02","e20010_Seq40_SneakRouteSet","S_Sen_Center_c", 0 )
			else
			end
		else
		end
	end,
	
	Seq40_03_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "GoTo_AsylumInside01a" )) then
			if( RoutePointNumber == 26 ) then										
				TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumOutSideGate_c" )
				TppEnemy.DisableRoute( this.cpID , "GoTo_AsylumInside01a" )
				TppEnemy.ChangeRoute( this.cpID , "Seq40_03","e20010_Seq40_SneakRouteSet","S_Sen_AsylumOutSideGate_c", 0 )
			else
			end
		else
		end
	end,
	
	Seq40_08_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)

		if ( RouteName ==  GsRoute.GetRouteId( "ArmorVehicle_onRaid_Seq40_08_02" )) then
			if( RoutePointNumber == 13 ) then
				TppMission.SetFlag( "isArmorVehicle_Start" , 2 )
				TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Armored_Vehicle_WEST_002" , "ArmorVehicle_WareHouseWait" , -1 )
			else
			end
		else
		end
	end,
	
	ComEne24_RouteChange = function()
		TppEnemy.EnableRoute( this.cpID , "GoToCenterB_2F_02" ) 	
		TppEnemy.DisableRoute( this.cpID , "S_Sen_HeliPortBigGate" )	
		TppEnemy.ChangeRoute( this.cpID , "ComEne24","e20010_Seq40_SneakRouteSet","GoToCenterB_2F_02", 0 )	
	end,
	
	Seq40_ComEne27_RouteChange = function()
		TppEnemy.EnableRoute( this.cpID , "S_GoTo_BoilarFront" ) 	
		TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterB_Stair" )	
		TppEnemy.ChangeRoute( this.cpID , "ComEne27","e20010_Seq40_SneakRouteSet","S_GoTo_BoilarFront", 0 )	
	end,
	
	toAsylumGroupStart = function()
		TppEnemy.EnableRoute( this.cpID , "Seq40_03_RideOnVehicle" ) 	
		TppEnemy.EnableRoute( this.cpID , "Seq40_04_RideOnVehicle" ) 	
		TppEnemy.DisableRoute( this.cpID , "Seq40_03_PreRideOnVehicle" )	
		TppEnemy.DisableRoute( this.cpID , "Seq40_04_PreRideOnVehicle" )	
		TppEnemy.ChangeRoute( this.cpID , "Seq40_03","e20010_Seq40_SneakRouteSet","Seq40_03_RideOnVehicle", 0 )	
		TppEnemy.ChangeRoute( this.cpID , "Seq40_04","e20010_Seq40_SneakRouteSet","Seq40_04_RideOnVehicle", 0 )	
	end,
	
	Seq40_ArmorVehicle_Start = function()
		TppMission.SetFlag( "isArmorVehicle_Start" , 1 )
		TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Armored_Vehicle_WEST_002" , "ArmorVehicle_onRaid_Seq40_08_02" , -1 )
	end,
	
	Radio_NearRV = function()
		if( TppMission.GetFlag( "isQuestionPaz" ) == false ) then		
			if( TppPlayerUtility.IsCarriedCharacter( "Paz" )) then		
				TppRadio.DelayPlayEnqueue( "Miller_NearRV", "short" )
			else													
			end
		else														
		end
	end,
	
	Radio_ArriveRV = function()
		if( TppMission.GetFlag( "isQuestionPaz" ) == false ) then		
			if( TppPlayerUtility.IsCarriedCharacter( "Paz" )) then		
				if( TppMission.GetFlag( "isHeliComingRV" ) == false ) then
					TppRadio.Play( "Miller_ArriveRV", {onStart = function() SetOptionalRadio() end} )
				else
				end
				TppRadio.RegisterOptionalRadio( "Optional_DiscoveryPaz" )			
				TppMarkerSystem.DisableMarker{ markerId = "20010_marker_RV" }
			else													
			end
		else														
		end
	end,

	
	Seq_QuestionPazDemo_OnlyOnce = function()




		
		local status = TppHostageUtility.GetStatus( "Paz" )



		if( status == "RideOnHelicopter" )then
			



			return
		end


		if( CheckDemoCondition() == true
		and TppMission.GetFlag( "isHeliComeToSea" ) == false



		 ) then				
			if( TppMission.GetFlag( "isQuestionPaz" ) == false ) then		
				TppSequence.ChangeSequence( "Seq_QuestionPazDemo" )
			else														
			end
		elseif( Check_SafetyArea() == true



) then				
			if( TppMission.GetFlag( "isQuestionPaz" ) == false ) then		
				TppMission.SetFlag( "isPazChicoDemoArea", true )
			end
		elseif( TppMission.GetFlag( "isDangerArea" ) == true ) then			
			local timer = 0.5
			GkEventTimerManager.Start( "Timer_CarryDownInDanger", timer )
		
		end
	end,

	
	Seq_RescueDemo_OnlyOnce = function()
		
		
			
			if( (TppData.GetArgument( 1 ) == "AsyPickingDoor24" )) then
				
				TppMission.SetFlag( "isPazChicoDemoArea", false )

				TppSequence.ChangeSequence( "Seq_RescueChicoDemo02" )
			end
	end,
}



this.Seq_ChicoPazToRV = {

	Messages = {
		Character = {
			{ data = "gntn_cp", message = "EndGroupVehicleRouteMove", localFunc = "Seq30_EnterCenterTruck" },
			{ data = "gntn_cp", message = "ConversationEnd", localFunc = "local_Seq30_ConversationEnd" },
			{ data = "Seq30_01", message = "MessageRoutePoint", localFunc = "Seq30_01_NodeAction" },
			{ data = "Seq30_02", message = "MessageRoutePoint", localFunc = "Seq30_02_NodeAction" },
			{ data = "Seq30_03", message = "MessageRoutePoint", localFunc = "Seq30_03_NodeAction" },
			{ data = "Seq30_04", message = "MessageRoutePoint", localFunc = "Seq30_04_NodeAction" },
			{ data = "Seq30_11", message = "MessageRoutePoint", localFunc = "Seq30_11_NodeAction" },
		},
		Trap = {
			myMessages.Trap[9],

			{ data = "Seq30_ArmorVehicle_Start", message = "Enter", localFunc = "Seq30_ArmorVehicle_Start" },
			{ data = "Seq30_02_RouteChange", message = "Enter", localFunc = "Seq30_02_RouteChange" },
			{ data = "Radio_CallHeliAdvice", message = "Enter", localFunc = "Radio_CallHeliAdvice" },
		},
	},

	OnEnter = function( manager )
		local LightState	= TppGadgetManager.GetGadgetStatus( "gntn_center_SwitchLight" )
		
		WoodTurret_RainFilter_OFF()
		
		TppCommandPostObject.GsSetRealizeFirstPriorityByRoute( this.cpID , "S_Sen_HeliPortFrontGate_a" , false )
		TppCommandPostObject.GsSetRealizeFirstPriorityByRoute( this.cpID , "S_Sen_HeliPortFrontGate_b" , false )
		
		SetComplatePhoto()
		
		TppMission.SetFlag( "isFirstEncount_Chico", true )
		
		TppPickableManager.DisableByLocator( "tp_chico_05" )
		
		TppSupportHelicopterService.SetDefaultRendezvousPointMarker("no_lz")
		
		TppMissionManager.SaveGame("30")
		
		if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == false )
			and ( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then
			commonUiMissionSubGoalNo(3)
		else
			commonUiMissionSubGoalNo(7)
		end
		
		AnounceLog_enemyReplacement()
		
		WeatherManager.RequestWeather(2,0)
		
		Seq10Trap_Disable()
		Seq10_20Trap_Disable()
		Seq20Trap_Disable()
		Seq30Trap_Enable()
		Seq40Trap_Disable()
		
		Common_CenterBigGate_DefaultOpen()
		
		ChengeChicoPazIdleMotion()
		
		TppMusicManager.ChangeParameter( 'bgm_paz_escape' )
		
		All_Seq_MissionAreaOut()
		
		ChicoDoor_ON_Open()
		PazDoor_ON_Open()
		
		Chico_MarkerON()			
		Paz_MarkerON()				
		TppMarkerSystem.DisableMarker{ markerId = "20010_marker_Chico" }
		TppMarkerSystem.DisableMarker{ markerId = "20010_marker_ChicoPinpoint" }
		TppMarkerSystem.DisableMarker{ markerId = "Marker_Duct" }
		TppMarkerSystem.DisableMarker{ markerId = "20010_marker_Paz" }
		TppMarkerSystem.DisableMarker{ markerId = "20010_marker_RV" }
		
		SetIntelRadio()
		
		SetOptionalRadio()
		
		TppEnemyUtility.SetEnableCharacterId( "ComEne08" , false )
		TppEnemyUtility.SetEnableCharacterId( "ComEne30" , false )
		
		Seq10Enemy_Disable()
		Seq20Enemy_Disable()
		Seq30Enemy_Enable()
		Seq40Enemy_Disable()
		
		FirstChico_Vehicle_02()
		
		Common_RetryKeepCautionSiren()
		
		GuardTarget_Setting()
		
		Seq_ChicoPazToRV_RouteSet()
		
		TppEnemy.EnableRoute( this.cpID , "GoToCenter_BigGate" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_CenterB_PreTalk" )
		TppEnemy.EnableRoute( this.cpID , "S_Pre_PazCheck_Vip" )
		TppEnemy.EnableRoute( this.cpID , "S_Pre_PazCheck" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_EastCamp_SouthLeftGate" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_WestCampRoom" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumOutSideGate_a" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumOutSideGate_b" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_EastCamp_NorthLeftGate" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_WareHouse_NorthGate" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_WareHouseKeeper01" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_WareHouseKeeper02" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortFrontGate_a2" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortFrontGate_b2" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Bridge_3" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortBehind_a" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortBehind_b" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortCenter_a" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortCenter_b" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_PreTalk" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortHouse" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_SeaSideEnter02" )
		TppEnemy.EnableRoute( this.cpID , "S_SL_WareHouse02a" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_WareHouseBehind" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_SeaSideEnter03" )
		TppEnemy.EnableRoute( this.cpID , "S_Pat_SeaSide01b" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_SeasideNearBox" )
		TppEnemy.EnableRoute( this.cpID , "S_Pat_SeaSide" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPort_FrontGate01" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPort_FrontGate02" )
		TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumOutSideGate_c" )
		
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_BigGate" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterB_2F" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_HeliPortGateSide" )
		TppEnemy.DisableRoute( this.cpID , "GoTo_PazCheck_vip" )
		TppEnemy.DisableRoute( this.cpID , "GoTo_PazCheck" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_Middle" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterB_TalkAfter" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_a" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_b" )
		TppEnemy.DisableRoute( this.cpID , "Seq30_05_RideOnVehicle" )
		TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret01_Route" )
		TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret05_Route" )
		TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL02_Route" )

		
		if ( LightState == 2 ) then		
			TppEnemy.EnableRoute( this.cpID , "ComEne25_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne26_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne27_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne28_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne29_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne31_SwitchOFF_v3" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_d" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_a" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_BoilarFront" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_b" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_e" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_f" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "ComEne25_SwitchOFF" , -1 , "ComEne25" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "ComEne26_SwitchOFF" , -1 , "ComEne26" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "ComEne27_SwitchOFF" , -1 , "ComEne27" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "ComEne28_SwitchOFF" , -1 , "ComEne28" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "ComEne29_SwitchOFF" , -1 , "ComEne29" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "ComEne31_SwitchOFF_v3" , -1 , "ComEne31" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_d" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_a" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_BoilarFront" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_b" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_e" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_f" )
			TppEnemy.DisableRoute( this.cpID , "ComEne25_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne26_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne27_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne28_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne29_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne31_SwitchOFF_v3" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_Center_d" , -1 , "ComEne25" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_Center_a" , -1 , "ComEne26" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_BoilarFront" , -1 , "ComEne27" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_Center_b" , -1 , "ComEne28" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_Center_e" , -1 , "ComEne29" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_Center_f" , -1 , "ComEne31" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "GoToCenter_BigGate" , -1 , "Seq30_01" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_CenterB_PreTalk" , -1 , "Seq30_02" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Pre_PazCheck_Vip" , -1 , "Seq30_03" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Pre_PazCheck" , -1 , "Seq30_04" , "ROUTE_PRIORITY_TYPE_FORCED" )
		
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Pat_SeaSide01b" , -1 , "Seq30_07" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_SeasideNearBox" , -1 , "Seq30_08" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Pat_SeaSide" , -1 , "Seq30_09" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_SeaSideEnter03" , -1 , "Seq30_10" , "ROUTE_PRIORITY_TYPE_FORCED" )
		
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_EastCamp_SouthLeftGate" , -1 , "ComEne01" , "ROUTE_PRIORITY_TYPE_FORCED" )
		if( TppMission.GetFlag( "isWoodTurret04_Break" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_SL_WestCamp" )
			TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret04_Route" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_SL_WestCamp" , -1 , "ComEne02" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "Break_WoodTurret04_Route" )
			TppEnemy.DisableRoute( this.cpID , "S_SL_WestCamp" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "Break_WoodTurret04_Route" , -1 , "ComEne02" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_WestCampRoom" , -1 , "ComEne03" , "ROUTE_PRIORITY_TYPE_FORCED" )
		if( TppMission.GetFlag( "isIronTurretSL01_Break" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_SL_WareHouse01a" )
			TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL01_Route" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_SL_WareHouse01a" , -1 , "ComEne04" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "Break_IronTurretSL01_Route" )
			TppEnemy.DisableRoute( this.cpID , "S_SL_WareHouse01a" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "Break_IronTurretSL01_Route" , -1 , "ComEne04" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_SeaSideEnter02" , -1 , "ComEne05" , "ROUTE_PRIORITY_TYPE_FORCED" )
		if( TppMission.GetFlag( "isWoodTurret03_Break" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_SL_EastCamp_North" )
			TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret03_Route" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_SL_EastCamp_North" , -1 , "ComEne06" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "Break_WoodTurret03_Route" )
			TppEnemy.DisableRoute( this.cpID , "S_SL_EastCamp_North" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "Break_WoodTurret03_Route" , -1 , "ComEne06" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_WareHouseBehind" , -1 , "ComEne07" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_AsylumOutSideGate_a" , -1 , "ComEne09" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_AsylumOutSideGate_b" , -1 , "ComEne10" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_EastCamp_NorthLeftGate" , -1 , "ComEne11" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_WareHouse_NorthGate" , -1 , "ComEne12" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_WareHouseKeeper01" , -1 , "ComEne13" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_WareHouseKeeper02" , -1 , "ComEne14" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_HeliPortFrontGate_a2" , -1 , "ComEne15" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_HeliPortFrontGate_b2" , -1 , "ComEne16" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_Bridge_3" , -1 , "ComEne17" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_HeliPortBehind_a" , -1 , "ComEne18" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_SL_WareHouse02a" , -1 , "ComEne19" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_HeliPortHouse" , -1 , "ComEne20" , "ROUTE_PRIORITY_TYPE_FORCED" )
		if( TppMission.GetFlag( "isIronTurretSL04_Break" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_SL_HeliPortTurret02" )
			TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL04_Route" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_SL_HeliPortTurret02" , -1 , "ComEne21" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "Break_IronTurretSL04_Route" )
			TppEnemy.DisableRoute( this.cpID , "S_SL_HeliPortTurret02" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "Break_IronTurretSL04_Route" , -1 , "ComEne21" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		if( TppMission.GetFlag( "isIronTurretSL05_Break" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_SL_HeliPortTurret01" )
			TppEnemy.DisableRoute( this.cpID , "Break_IronTurretSL05_Route" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_SL_HeliPortTurret01" , -1 , "ComEne22" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "Break_IronTurretSL05_Route" )
			TppEnemy.DisableRoute( this.cpID , "S_SL_HeliPortTurret01" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "Break_IronTurretSL05_Route" , -1 , "ComEne22" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_HeliPort_FrontGate01" , -1 , "ComEne23" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_HeliPort_FrontGate02" , -1 , "ComEne24" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_Sen_Boilar_PreTalk" , -1 , "ComEne32" , "ROUTE_PRIORITY_TYPE_FORCED" )
		if( TppMission.GetFlag( "isWoodTurret02_Break" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_SL_EastCamp_South_in" )
			TppEnemy.DisableRoute( this.cpID , "Break_WoodTurret02_Route" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_SL_EastCamp_South_in" , -1 , "ComEne33" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "Break_WoodTurret02_Route" )
			TppEnemy.DisableRoute( this.cpID , "S_SL_EastCamp_South_in" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "Break_WoodTurret02_Route" , -1 , "ComEne33" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		if( TppMission.GetFlag( "isCenterTowerSL_Break" ) == false ) then
			TppEnemy.EnableRoute( this.cpID , "S_SL_HeliPortTower" )
			TppEnemy.DisableRoute( this.cpID , "Break_CenterTower_Route" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_SL_HeliPortTower" , -1 , "ComEne34" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "Break_CenterTower_Route" )
			TppEnemy.DisableRoute( this.cpID , "S_SL_HeliPortTower" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq30_SneakRouteSet" , "S_SL_HeliPortTower" , -1 , "ComEne34" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		
		TppCommandPostObject.GsSetRealizeFirstPriorityByRoute( this.cpID , "GoTo_PazCheck_vip" , true )
		
		SpHostage_Disable()
	end,

	Seq30_EnterCenterTruck= function()

		local VehicleGroupInfo			= TppData.GetArgument(2)
		local VehicleGroupInfoName		= VehicleGroupInfo.routeInfoName
		local VehicleGroupResult		= VehicleGroupInfo.result
		local VehicleGroupReason		= VehicleGroupInfo.reason

		if( VehicleGroupInfoName == "TppGroupVehicleRouteInfo_Seq30_05" ) then
			if( VehicleGroupResult == "SUCCESS" ) then
				
			else	
				TppCommandPostObject.GsSetRealizeFirstPriority( this.cpID , "Seq30_05" , false )
				TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumOutSideGate_c" )
				TppEnemy.DisableRoute( this.cpID , "Seq30_05_RideOnVehicle" )
				TppEnemy.ChangeRoute( this.cpID , "Seq30_05","e20010_Seq30_SneakRouteSet","S_Sen_AsylumOutSideGate_c", 0 )
			end
		else
		end
	end,
	
	local_Seq30_ConversationEnd = function()
		local label		= TppData.GetArgument(2)
		if ( label == "CTE0010_0345") then
				TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_Middle" )
				TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_PreTalk" )
				TppEnemy.ChangeRoute( this.cpID , "ComEne32","e20010_Seq30_SneakRouteSet","S_Sen_Boilar_Middle", 0 )
				Seq30_PazCheck_Start()	









		elseif ( label == "CTE0010_0050") then
			TppEnemy.EnableRoute( this.cpID , "S_Sen_CenterB_TalkAfter" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterB_PreTalk" )
			TppEnemy.ChangeRoute( this.cpID , "Seq30_02","e20010_Seq30_SneakRouteSet","S_Sen_CenterB_TalkAfter", 0 )
			
			TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seq30_02_RouteChange", false , false )
		else
		end
	end,
	
	Seq30_01_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "GoToCenter_BigGate" )) then
			if( RoutePointNumber == 12 ) then										
				TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortGateSide" )
				TppEnemy.DisableRoute( this.cpID , "GoToCenter_BigGate" )
				TppEnemy.ChangeRoute( this.cpID , "Seq30_01","e20010_Seq30_SneakRouteSet","S_Sen_HeliPortGateSide", 0 )
			else
			end
		else
		end
	end,
	
	Seq30_02_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Sen_CenterB_TalkAfter" )) then
			if( RoutePointNumber == 4 ) then										
				TppEnemy.EnableRoute( this.cpID , "S_Sen_CenterB_2F" )
				TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterB_TalkAfter" )
				TppEnemy.ChangeRoute( this.cpID , "Seq30_02","e20010_Seq30_SneakRouteSet","S_Sen_CenterB_2F", 0 )
			else
			end
		else
		end
	end,
	
	Seq30_03_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "GoTo_PazCheck_vip" )) then
			if( RoutePointNumber == 18 ) then										
				TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_a" )
				TppEnemy.DisableRoute( this.cpID , "GoTo_PazCheck_vip" )
				TppEnemy.ChangeRoute( this.cpID , "Seq30_03","e20010_Seq30_SneakRouteSet","S_Sen_Boilar_a", 0 )
			else
			end
		else
		end
	end,
	
	Seq30_04_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "GoTo_PazCheck" )) then
			if( RoutePointNumber == 18 ) then										
				TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_b" )
				TppEnemy.DisableRoute( this.cpID , "GoTo_PazCheck" )
				TppEnemy.ChangeRoute( this.cpID , "Seq30_04","e20010_Seq30_SneakRouteSet","S_Sen_Boilar_b", 0 )
			else
			end
		else
		end
	end,
	
	Seq30_11_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)

		if ( RouteName ==  GsRoute.GetRouteId( "ArmorVehicle_onRaid_Seq30_11_2" )) then
			if( RoutePointNumber == 14 ) then
				TppMission.SetFlag( "isArmorVehicle_Start" , 2 )
				TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Armored_Vehicle_WEST_003" , "ArmorVehicle_WareHouseWait" , -1 )
			else
			end
		else
		end
	end,
	
	Seq30_ArmorVehicle_Start = function()
		TppMission.SetFlag( "isArmorVehicle_Start" , 1 )
		TppCommandPostObject.GsSetGroupVehicleRoute( this.cpID , "Armored_Vehicle_WEST_003" , "ArmorVehicle_onRaid_Seq30_11_2" , -1 )
	end,
	
	Seq30_02_RouteChange = function()
		TppEnemy.EnableRoute( this.cpID , "S_Sen_CenterB_TalkAfter" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterB_PreTalk" )
		TppEnemy.ChangeRoute( this.cpID , "Seq30_02","e20010_Seq30_SneakRouteSet","S_Sen_CenterB_TalkAfter", 0 )
	end,
	
	Radio_CallHeliAdvice = function()
		if( TppMission.GetFlag( "isHeliComingRV" ) == false and 				
			TppPlayerUtility.IsCarriedCharacter( "Paz" ) ) then					
			TppRadio.PlayEnqueue("Miller_CallHeliAdvice")
		end
	end,
}



this.Seq_PazChicoToRV = {

	Messages = {
		Character = {
		
			{ data = "Chico", message = "MessageHostageCarriedEnd", localFunc = "Seq_CarriedEndChico" },
			{ data = "ComEne34", message = "MessageRoutePoint", localFunc = "ComEne34_NodeAction" },
		},
		Trap = {

		},
	},
	OnEnter = function( manager )

		local LightState = TppGadgetManager.GetGadgetStatus( "gntn_center_SwitchLight" )

		
		WoodTurret_RainFilter_OFF()
		
		SetComplatePhoto()
		
		TppMissionManager.SaveGame("20")
		
		TppMission.SetFlag( "isFirstEncount_Chico", false )
		
		FirstPaz_Vehicle()
		
		TppPickableManager.DisableByLocator( "tp_chico_05" )
		
		if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true )
			and ( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == false ) then
			commonUiMissionSubGoalNo(7)
		else
			commonUiMissionSubGoalNo(3)
		end
		
		AnounceLog_enemyReplacement()
		
		TppSupportHelicopterService.SetDefaultRendezvousPointMarker("no_lz")
		
		GuardTarget_Setting()
		
		Seq10Trap_Disable()
		Seq10_20Trap_Disable()
		Seq20Trap_Disable()
		Seq30Trap_Disable()
		Seq40Trap_Disable()
		
		Common_RetryKeepCautionSiren()
		
		ChengeChicoPazIdleMotion()
		
		All_Seq_MissionAreaOut()
		
		TppMusicManager.ChangeParameter( 'bgm_paz_escape' )
		
		WeatherManager.RequestWeather(2,0)
		
		Common_CenterBigGate_DefaultOpen()
		
		Chico_MarkerON()		
		Paz_MarkerON()			
		TppMarkerSystem.DisableMarker{ markerId = "20010_marker_Paz" }
		TppMarkerSystem.DisableMarker{ markerId = "Marker_Duct" }
		TppMarkerSystem.DisableMarker{ markerId = "20010_marker_Chico" }
		TppMarkerSystem.DisableMarker{ markerId = "20010_marker_ChicoPinpoint" }
		TppMarkerSystem.DisableMarker{ markerId = "20010_marker_RV" }
		
		SetIntelRadio()
		
		SetOptionalRadio()
		
		ChicoDoor_ON_Open()
		PazDoor_ON_Open()
		
		Seq10Enemy_Disable_Ver2()
		Seq20Enemy_Disable()
		Seq30Enemy_Disable()
		Seq40Enemy_Enable()
		
		Seq_PazChicoToRV_RouteSet()
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Bridge" )
		TppEnemy.DisableRoute( this.cpID , "S_Sen_Bridge_3" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Bridge" , 0 , "ComEne17" , "ROUTE_PRIORITY_TYPE_FORCED" )
		
		TppEnemy.EnableRoute( this.cpID , "S_Pat_FinalPazCheck" )
		TppEnemy.DisableRoute( this.cpID , "S_SL_HeliPortTower" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Pat_FinalPazCheck" , 0 , "ComEne34" , "ROUTE_PRIORITY_TYPE_FORCED" )
		TppCommandPostObject.GsSetRealizeFirstPriorityByRoute( this.cpID , "S_Pat_FinalPazCheck" , true )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_a" )
		TppEnemy.DisableRoute( this.cpID , "Seq40_PazCheck01" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Boilar_a" , 0 , "Seq40_01" , "ROUTE_PRIORITY_TYPE_FORCED" )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_c" )
		TppEnemy.DisableRoute( this.cpID , "Seq40_PazCheck02" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Center_c" , 0 , "Seq40_02" , "ROUTE_PRIORITY_TYPE_FORCED" )
		
		TppEnemy.EnableRoute( this.cpID , "S_Sen_AsylumOutSideGate_c" )
		TppEnemy.DisableRoute( this.cpID , "Seq40_03_PreRideOnVehicle" )
		TppEnemy.DisableRoute( this.cpID , "Seq40_03_RideOnVehicle" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_AsylumOutSideGate_c" , 0 , "Seq40_03" , "ROUTE_PRIORITY_TYPE_FORCED" )
		
		TppEnemy.EnableRoute( this.cpID , "GoTo_AsylumInside02b" )
		TppEnemy.DisableRoute( this.cpID , "Seq40_04_RideOnVehicle" )
		TppEnemy.DisableRoute( this.cpID , "Seq40_04_PreRideOnVehicle" )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "GoTo_AsylumInside02b" , 0 , "Seq40_04" , "ROUTE_PRIORITY_TYPE_FORCED" )

		
		if ( LightState == 2 ) then		
			TppEnemy.EnableRoute( this.cpID , "ComEne24_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne25_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne26_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne27_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne28_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne29_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne31_SwitchOFF" )
			TppEnemy.EnableRoute( this.cpID , "ComEne32_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_CenterB_2F" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_d" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_a" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_BoilarFront" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_b" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Center_e" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_Middle2" )
			TppEnemy.DisableRoute( this.cpID , "S_Sen_Boilar_Middle" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne24_SwitchOFF" , 0 , "ComEne24" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne25_SwitchOFF" , 0 , "ComEne25" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne26_SwitchOFF" , 0 , "ComEne26" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne27_SwitchOFF" , 0 , "ComEne27" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne28_SwitchOFF" , 0 , "ComEne28" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne29_SwitchOFF" , 0 , "ComEne29" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne31_SwitchOFF" , 0 , "ComEne31" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "ComEne32_SwitchOFF" , 0 , "ComEne32" , "ROUTE_PRIORITY_TYPE_FORCED" )
		else
			TppEnemy.EnableRoute( this.cpID , "S_Sen_CenterB_2F" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_d" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_a" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_BoilarFront" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_b" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Center_e" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_Middle2" )
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Boilar_Middle" )
			TppEnemy.DisableRoute( this.cpID , "ComEne24_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne25_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne26_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne27_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne28_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne29_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne31_SwitchOFF" )
			TppEnemy.DisableRoute( this.cpID , "ComEne31_SwitchOFF_v2" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_CenterB_2F" , 0 , "ComEne24" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Center_d" , 0 , "ComEne25" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Center_a" , 0 , "ComEne26" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_BoilarFront" , 0 , "ComEne27" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Center_b" , 0 , "ComEne28" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Center_e" , 0 , "ComEne29" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Boilar_Middle2" , 0 , "ComEne31" , "ROUTE_PRIORITY_TYPE_FORCED" )
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq40_SneakRouteSet" , "S_Sen_Boilar_Middle" , 0 , "ComEne32" , "ROUTE_PRIORITY_TYPE_FORCED" )
		end
		
		SpHostage_Disable()
	end,

	
	Seq_CarriedEndChico = function()
		if( CheckDemoCondition() == true



		and TppMission.GetFlag( "isHeliComingRV" ) == false ) then	
			TppRadio.Play("Miller_PazChicoCarriedEndRV")
		end
	end,

	
	ComEne34_NodeAction = function()
		local RouteName			= TppData.GetArgument(3)
		local RoutePointNumber		= TppData.GetArgument(1)
		
		if ( RouteName ==  GsRoute.GetRouteId( "S_Pat_FinalPazCheck" )) then
			if( RoutePointNumber == 31 ) then										
				TppEnemy.EnableRoute( this.cpID , "S_SL_HeliPortTower" )
				TppEnemy.DisableRoute( this.cpID , "S_Pat_FinalPazCheck" )
				TppEnemy.ChangeRoute( this.cpID , "ComEne34","e20010_Seq40_SneakRouteSet","S_SL_HeliPortTower", 0 )
			else
			end
		else
		end
	end,
}



this.Seq_PlayerOnHeli = {

	Messages = {
		Character = {

		},
	},

	OnEnter = function( manager )
		
		WoodTurret_RainFilter_OFF()
		
		TppCommandPostObject.GsSetRealizeFirstPriorityByRoute( this.cpID , "GoTo_PazCheck_vip" , false )
		TppCommandPostObject.GsSetRealizeFirstPriorityByRoute( this.cpID , "S_Pat_FinalPazCheck" , false )
		
		Common_CenterBigGate_DefaultOpen()
		
		if( TppMission.GetFlag( "isFirstEncount_Chico" ) == true ) then
			FirstChico_Vehicle_02()	
		else
			FirstPaz_Vehicle()		
		end
		
		SetComplatePhoto()
		
		if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) and
			( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then
				commonUiMissionSubGoalNo(8)
		elseif( TppMission.GetFlag( "isPlaceOnHeliChico" ) == true ) and
			( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == false ) then
				commonUiMissionSubGoalNo(7)
		elseif( TppMission.GetFlag( "isPlaceOnHeliChico" ) == false ) and
			( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == true ) then
				commonUiMissionSubGoalNo(3)
		else
			
		end
		
		SetIntelRadio()
		
		SetOptionalRadio()
		
		TppPickableManager.DisableByLocator( "tp_chico_05" )
		
		All_Seq_MissionAreaOut()
		
		TppSupportHelicopterService.SetDefaultRendezvousPointMarker("no_lz")
		
		Seq10Trap_Disable()
		Seq10_20Trap_Disable()
		Seq20Trap_Disable()
		Seq30Trap_Disable()
		Seq40Trap_Disable()
		
		GuardTarget_Setting()
		
		ChicoDoor_ON_Open()
		PazDoor_ON_Open()
		
		Common_RetryKeepCautionSiren()
		
		TppMusicManager.ChangeParameter( 'bgm_paz_escape' )
	end,
}



this.Seq_PlayerOnHeliAfter = {

	Messages = {
		Character = {

		},
	},

	OnEnter = function( manager )
		
		SetComplatePhoto()
		
		All_Seq_MissionAreaOut()
		
		TppPickableManager.DisableByLocator( "tp_chico_05" )
		
		Common_CenterBigGate_DefaultOpen()
		
		if( TppMission.GetFlag( "isFirstEncount_Chico" ) == true ) then
			FirstChico_Vehicle_02()	
		else
			FirstPaz_Vehicle()		
		end
		
		Seq10Trap_Disable()
		Seq10_20Trap_Disable()
		Seq20Trap_Disable()
		Seq30Trap_Disable()
		Seq40Trap_Disable()
		
		GuardTarget_Setting()
		
		Common_RetryKeepCautionSiren()
		
		TppMusicManager.ChangeParameter( 'bgm_paz_escape' )
	end,
}



this.Seq_Mission_Failed = {

	MissionState = "failed",

	Messages = {
		Timer = {
			{ data = "MissionFailedProductionTimer",	message = "OnEnd", 	localFunc="OnFinishMissionFailedProduction" },
		},
	},
	
	OnFinishMissionFailedProduction = function( manager )
			
			TppSequence.ChangeSequence( "Seq_MissionGameOver" )
	end,

	OnEnter = function( manager )
			
			
			
			TppTimer.Start( "MissionFailedProductionTimer", this.CounterList.GameOverFadeTime )
			GzRadioSaveData.ResetSaveRadioId()
			GzRadioSaveData.ResetSaveEspionageId()
			local radioManager = RadioDaemon:GetInstance()
			radioManager:DisableAllFlagIsMarkAsRead()
			radioManager:ResetRadioGroupAndGroupSetAlreadyReadFlag()
			TppRadioConditionManagerAccessor.Unregister( "Tutorial" )
			TppRadioConditionManagerAccessor.Unregister( "Basic" )
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



this.Seq_HelicopterDeadNotOnPlayer = {
	MissionState = "failed",
	Messages = {
		Character = {
			{ data = "SupportHelicopter",	message = "Dead",	localFunc = "localChangeSequence" },
		},
	},
	OnEnter = function()
		GZCommon.PlayCameraOnCommonHelicopterGameOver()
		SetGameOverMissionFailed()									
	
	end,
	localChangeSequence = function()
		local characterId = TppEventSequenceManagerCollector.GetMessageArg( 1 )
		if characterId == "Player" then
			this.CounterList.GameOverRadioName = "Miller_HeliKill"		
		else
			this.CounterList.GameOverRadioName = "Miller_HeliDead"		
		end
		TppSequence.ChangeSequence( "Seq_MissionGameOver" )
	end,
}



this.Seq_Mission_End = {

	OnEnter = function()
		
		local uiCommonData = UiCommonDataManager.GetInstance()
		uiCommonData:ShowAllCassetteTapes()

		GZCommon.MissionCleanup()	
		
		this.commonMissionCleanUp()
		TppMission.ChangeState( "end" )
	end,
}



this.Seq_Mission_Telop = {

	MissionState = "clear",
	Messages = {
		UI = {
			
			{ message = "EndMissionTelopFadeIn" ,	localFunc = "OnFinishClearFade" },
		},
	},
	
	OnFinishClearFade = function()
		
		TppSoundDaemon.SetMute( 'Result' )
		
		TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_e20010_result" )
	end,

	OnEnter = function()
		Trophy.TrophyUnlock(1)		
		RankingFeedBack()			

		
		if( TppMission.GetFlag( "isPlaceOnHeliSpHostage" ) == true ) then
			
			TppGameSequence.SetGameFlag( "e20010_cassette" , true )
		else
		end

		local TelopEnd = {
			onEndingStartNextLoading = function()
				TppSequence.ChangeSequence( "Seq_Mission_Clear" )
			end
		}
		GZCommon.StopSirenNormal()	
		TppUI.ShowTransitionWithFadeOut( "ending", TelopEnd, 2 )
	end,
}



this.Seq_Mission_Clear = {

	OnEnter = function()
		TppMission.ChangeState( "end" )
		GzRadioSaveData.ResetSaveRadioId()
		GzRadioSaveData.ResetSaveEspionageId()
		local radioManager = RadioDaemon:GetInstance()
		radioManager:DisableAllFlagIsMarkAsRead()
		radioManager:ResetRadioGroupAndGroupSetAlreadyReadFlag()
		TppRadioConditionManagerAccessor.Unregister( "Tutorial" )
		TppRadioConditionManagerAccessor.Unregister( "Basic" )
	end,
}



return this
