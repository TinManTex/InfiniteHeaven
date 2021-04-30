local this = {}





this.missionID = 20030
this.cpID		= "gntn_cp"


this.Time_ForceSerching	= (60*5)


this.Time_PlayRadioAboutSignal	= (60)


this.Time_ListeningInfoFromBetrayer	= (20)


this.Size_ActiveEnemy		= 18


this.BetrayerID		= "e20030_Betrayer"		
this.AssistantID	= "e20030_Assistant"	
this.MastermindID	= "e20030_Mastermind"	


this.CassetteA	=	"tp_it20030_01"
this.CassetteB	=	"tp_it20030_02"


this.SecurityCameraDeadRadioName	= "CPR0340"


this.Area_campEast = 0
this.Area_campWest = 1
this.Area_Heliport = 2
this.Area_WareHouse = 3


this.AnnounceLogID_Signal			= "announce_mission_40_20030_000_from_0_prio_0"
this.AnnounceLogID_Contact			= "announce_mission_40_20030_001_from_0_prio_0"
this.AnnounceLogID_CassetteA		= "announce_mission_40_20030_002_from_0_prio_0"
this.AnnounceLogID_CassetteB		= "announce_mission_40_20030_003_from_0_prio_0"
this.AnnounceLogID_Inspection		= "announce_mission_40_20030_004_from_0_prio_0"
this.AnnounceLogID_MapUpdate		= "announce_map_update"
this.AnnounceLogID_AreaWarning		= "announce_mission_area_warning"
this.AnnounceLogID_ChallengeFailure	= "announce_challengeFailure"
this.AnnounceLogID_RecoveryBetrayer		= "announce_mission_40_20030_005_from_0_prio_0"
this.AnnounceLogID_RecoveryMastermind	= "announce_mission_40_20030_006_from_0_prio_0"
this.AnnounceLogID_MissionGoal		= "announce_mission_goal"
this.AnnounceLogID_HeliDead			= "announce_destroyed_support_heli"
this.AnnounceLogID_InfoUpdate		= "announce_mission_info_update"



this.TrophyId_e20030_CargoClear		= 9		
this.TrophyId_GZ_SideOpsClear		= 2		
this.TrophyId_GZ_RankSClear			= 4		


this.MissionSubGoal_Betrayer	= 1		
this.MissionSubGoal_Cassette	= 2		
this.MissionSubGoal_Mastermind	= 3		
this.MissionSubGoal_Escape		= 4		


this.tmpChallengeString = 0			
this.tmpBestRank = 0				
this.tmpRewardNum = 0				




this.RequiredFiles = {
	"/Assets/tpp/script/common/GZCommon.lua",
}

this.Sequences = {
	{ "Seq_MissionPrepare" },
	{ "Seq_MissionSetup" },
	{ "Seq_OpeningDemoLoad" },
	{ "Seq_OpeningShowTransition" },
	{ "Seq_OpeningDemo" },
	{ "Seq_MissionLoad" },
	{ "Seq_TruckInfiltration" },
	{ "Seq_Waiting_BetrayerContact" },
	{ "Seq_BetrayerContactDemo" },
	{ "Seq_Waiting_GetCassette" },
	{ "Seq_Escape_CameraActive" },
	{ "Seq_Escape_CameraBroken" },
	{ "Seq_PlayerRideHelicopter" },
	{ "Seq_PlayerEscapeMissionArea" },
	{ "Seq_MissionClearDemo" },
	{ "Seq_MissionClearShowTransition" },
	{ "Seq_MissionClear" },
	{ "Seq_MissionAbort" },
	{ "Seq_MissionFailed" },
	{ "Seq_MissionGameOver" },
	{ "Seq_ShowClearReward" },
	{ "Seq_MissionEnd" },
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
	"Seq_MissionLoad",
	"Seq_TruckInfiltration",
	"Seq_Waiting_BetrayerContact",
	"Seq_BetrayerContactDemo",
	"Seq_Waiting_GetCassette",
	"Seq_Escape_CameraActive",
	"Seq_Escape_CameraBroken",
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
	isBetrayerContact				= false,		
	isGetCassette_A					= false,		
	isGetCassette_B					= false,		
	isDropCassette_B				= false,		

	isGetInfo_Mastermind			= false,		
	isGetInfo_CameraTrap			= false,		
	isGetInfo_Suspicion1			= false,		
	isGetInfo_Suspicion2			= false,		
	isGetInfo_Suspicion3			= false,		
	isGetInfo_Intimidation			= false,		


	isBetrayerDown					= false,		
	isBetrayerMarking				= false,		
	isBetrayerOnHeli				= false,		
	isAssistantDown					= false,		
	isMastermindDown				= false,		
	isMastermindMarking				= false,		
	isMastermindOnHeli				= false,		
	BetrayerArea					= this.Area_campEast,	

	isCameraBroken					= false,		
	isCameraBrokenRadio				= false,		
	isCameraAlert					= false,		
	isCameraDemoPlay				= false,		
	isCameraIntelRadioPlay			= false,		
	isSignalExecuted				= false,		
	isSignalCheckEventEnd			= false,		
	isSignalTurretDestruction		= false,		

	listeningInfoFromBetrayer		= false,		

	isPlayerEnterMissionArea		= false,		
	isPlayerInWestCamp				= false,		
	isPlayerCheckMbPhoto			= false,		
	isBetrayerTogether				= false,		
	isBetrayerSignalCheckWait		= false,		
	isAssistantSignalCheckWait		= false,		
	isWarningMissionArea			= false,		
	isMastermindConversationEnd		= false,		
	isAssistantConversationEnd		= false,		
	isInspectionActive				= false,		

	isAlreadyAlert					= false,		
	isWavActivate					= false,		
	isWavBroken						= false,		

	
	isMarkingTruck001				= false,		
	isMarkingTruck002				= false,		
	isMarkingDriver001				= false,		
	isMarkingDriver002				= false,		

	
	isRadio_MissionBriefingSub1		= false,		
	isRadio_MissionBriefingSub1_3	= false,		
	isRadio_MissionBriefingSub2		= false,		
	isRadio_SimpleObjectivePlay		= false,		
	OnPlay_MissionBriefingSub1		= false,		
	isNotMarkBeforeSignal			= false,		

	
	dbg_OpeningDemoSkipFlag			= false,			
	isOpeningDemoSkip				= false,			
	isSwitchLightDemo				= false,			

	
	isCarTutorial					= false,		
	isAVMTutorial					= false,		

	isHeliLandNow					= false,		
}




this.CounterList = {
	DEBUG_commonPrint2DCount	= 0,				
	MissionRank					= 0,				
	PlayerArea					= "Area_campWest",	

	BetrayerInterrogation		= 0,				
	MastermindInterrogation		= 0,				
	GameOverRadioName			= "NoRadio",		
	BetrayerInterrogationSet	= "A",				
	BetrayerInterrogationSerif	= "A",				
	BetrayerRestraintEndRadio	= "NoRadio",		
	MastermindRestraintEndRadio	= "NoRadio",		
	CameraBrokenRadio			= "NoRadio",		
	PlayerOnCargo				= "NoRide",			

	GameOverFadeTime			= 1.4,	
	WestTruckStatus				= 0,	
	NorthTruckStatus			= 0,	
	BetrayerRestraint			= 0,				
}




this.DemoList = {
	Demo_Opening 			= "p12_020000_000",		
	Demo_BetrayerContactCam	= "p12_020010_000",		
	Demo_BetrayerContact	= "p12_020020_000",		
	Demo_SecurityCamera		= "p12_020030_000",		
	Demo_AreaEscapeNorth	= "p11_020010_000",		
	Demo_AreaEscapeWest		= "p11_020020_000",		
	SwitchLightDemo			= "p11_020003_000",		

}




this.RadioList = {

	

	Radio_MissionBriefing2		= "e0030_rtrg0006",			
	Radio_AboutSignal			= "e0030_rtrg0012",			
	Radio_AboutContact			= "e0030_rtrg0010",			

	Radio_RideOffTruck			= { "e0030_rtrg0009", 1 },	
	Radio_CheckMbPhoto			= "e0030_rtrg0013",			
	Radio_CheckMbPhotoTutorial	= { "e0030_rtrg0019", 1 },	
	Radio_SimpleObjective		= { "e0030_rtrg0011", 1 },	

	
	Radio_MissionBriefingSub1	= { "e0030_rtrg0301", 1 },	
	Radio_MissionBriefingSub1_1	= { "e0030_rtrg0302", 1 },	
	Radio_MissionBriefingSub1_2	= { "e0030_rtrg0304", 1 },	
	Radio_MissionBriefingSub1_3	= { "e0030_rtrg0305", 1 },	
	Radio_MissionBriefingSub1_5	= { "e0030_rtrg0303", 1 },	
	Radio_MissionBriefingSub2	= { "e0030_rtrg0008", 1 },	


	
	Radio_ContactNot_Phase		= "e0030_rtrg0030",			
	Radio_Contactable			= "e0030_rtrg0040",			
	Radio_ContactNot_NearEnemy1	= "e0030_rtrg0050",			
	Radio_ContactNot_NearEnemy2	= "e0030_rtrg0055",			
	Radio_Contact_JustNow		= "e0030_rtrg0045",			

	
	Radio_MarkingBetrayer1		= "e0030_rtrg0140",			
	Radio_MarkingBetrayer2		= "e0030_rtrg0142",			
	Radio_MarkingBetrayer3		= "e0030_rtrg0145",			
	Radio_MarkingBetrayer4		= "f0090_rtrg0335",			

	Radio_MarkingMastermind		= "e0030_rtrg0090",			

	
	Radio_BetrayerContact		= "e0030_rtrg0060",			
	Radio_FocusCassette_A		= { "e0030_rtrg0065", 1 },	
	Radio_GetCassette_A			= "e0030_rtrg0070",			
	Radio_GetCassette_A_Alert	= "e0030_rtrg0071",			
	Radio_GetCassette_A_NoHint	= "e0030_rtrg0110",			
	Radio_PlayedCassette_A		= { "e0030_rtrg0075", 1 },	
	Radio_RecommendGetCassette_A = "e0030_oprg0021",		

	
	Radio_DropCassette_B_NoHint		= "e0030_rtrg0115",			
	Radio_DropCassette_B_Suspicion	= "e0030_rtrg0190",			
	Radio_DropCassette_B_Confidence	= "e0030_rtrg0195",			
	Radio_PlayedCassette_B			= { "e0030_rtrg0077", 1 },	
	Radio_GetCassette_B_NoHint		= "e0030_rtrg0400",			
	Radio_GetCassette_B_WithA		= "e0030_rtrg0401",			
	Radio_GetCassette_B_Confidence	= "e0030_rtrg0402",			


	
	Radio_CameraTrap_NoContact	= { "e0030_rtrg0119", 1 },		
	Radio_CameraTrap_Normal		= { "e0030_rtrg0120", 1 },		

	Radio_CameraTrap_Confidence	= { "e0030_rtrg0122", 1 },		

	
	Radio_BrokeCamera_NoHint	= { "e0030_rtrg0124", 1 },	
	Radio_BrokeCamera_Confidence= { "e0030_rtrg0125", 1 },	
	Radio_BrokeCamera_Accident	= { "e0030_rtrg0160", 1 },	

	
	Radio_RunSignal				= { "e0030_rtrg0150", 1 },	
	Radio_AppearedBetrayer		= "e0030_rtrg0130",			
	Radio_IsThatBetrayer		= { "e0030_rtrg0020", 1 },	
	Radio_AppearedAssistant		= "e0030_rtrg0132",			
	Radio_DisablementAssistant	= "e0030_rtrg0170",			
	Radio_SignalBroken			= { "e0030_rtrg0015", 1 },	
	Radio_Map_Signal			= { "e0030_rtrg0014", 1 },	

	
	Radio_Conversation_Comp		= "e0030_rtrg0200",			
	Radio_Conversation_InComp	= "e0030_rtrg0201",			

	
	Radio_FaintBetrayer_BeforeDemo			= { "e0030_rtrg0093", 1 },	
	Radio_SleepBetrayer_BeforeDemo			= { "e0030_rtrg0094", 1 },	
	Radio_DisablementBetrayer_AfterDemo		= "e0030_rtrg0103",		
	Radio_DeadBetrayer_AfterDemo			= "e0030_rtrg0100",		
	Radio_DeadBetrayer_AfterGetCassette		= "e0030_rtrg0105",		
	Radio_BetrayerOnHeli					= "e0030_rtrg0240",		
	Radio_GetInfo_FromBetrayerOnHeli		= "e0030_rtrg0243",		

	
	Radio_Inspection			= { "e0030_rtrg0180", 1 },		
	Radio_EscapeWay				= "e0030_oprg0080",				
	Radio_RecommendEscape		= "e0030_oprg0030",				
	Radio_LandEscape			= "e0030_rtrg0033",				

	
	Radio_MissionClearRank_D	= "e0030_rtrg0080",
	Radio_MissionClearRank_C	= "e0030_rtrg0082",
	Radio_MissionClearRank_B	= "e0030_rtrg0084",
	Radio_MissionClearRank_A	= "e0030_rtrg0086",
	Radio_MissionClearRank_S	= "e0030_rtrg0088",

	
	Radio_DeadBetrayer_BeforeDemo		= "f0033_gmov0140",		
	Radio_DeadPlayer					= "f0033_gmov0010",		
	Radio_RideHeli_Failed				= "f0033_gmov0040",		
	Radio_MissionArea_Failed			= "f0033_gmov0020",		

	
	Radio_BlackCall_Cassette_A	= "e0030_rtrg0210",		
	Radio_BlackCall_Cassette_B	= "e0030_rtrg0215",		


	
	Radio_Reaction_Intimidation	= { "e0030_rtrg0220", 1 },	
	Radio_Reaction_Escape		= { "e0030_rtrg0221", 1 },	
	Radio_Reaction_Search		= { "e0030_rtrg0222", 1 },	
	Radio_Reaction_Truth		= { "e0030_rtrg0223", 1 },	

	Radio_Reaction_Rebellion	= "e0030_rtrg0230",			

	
	Radio_MissionArea_Warning	= "f0090_rtrg0310",			
	Radio_MissionArea_Clear		= "f0090_rtrg0315",			
	Radio_MissionAbort_Warning	= "f0090_rtrg0120",			
	Radio_HeliAbort_Warning		= "f0090_rtrg0130",			
	Radio_RideHeli_Clear		= "f0090_rtrg0460",			
	Radio_DiscoverHostage		= { "f0090_rtrg0470", 1 },	
	Radio_HostageOnHeli			= "f0090_rtrg0200",			
	Radio_EncourageMission		= "f0090_rtrg0011",			
	Radio_BrokenHeli			= "f0090_rtrg0220",			
	Radio_BrokenHeliSneak		= "f0090_rtrg0155",			

	
	Miller_AlartAdvice			= "f0090_rtrg0230",			
	Miller_AlertToEvasion		= "f0090_rtrg0260",			
	Miller_ReturnToSneak		= "f0090_rtrg0270",			
	Miller_SpRecoveryLifeAdvice	= "f0090_rtrg0290",			
	Miller_RevivalAdvice		= "f0090_rtrg0280",			
	Miller_CuarAdvice			= "f0090_rtrg0300",			
	Miller_EnemyOnHeli			= "f0090_rtrg0200",			
	Miller_BreakSuppressor		= "f0090_rtrg0530",			
	Miller_HeliNoCall			= "f0090_rtrg0166",			
	Miller_CallHeli01			= "f0090_rtrg0170",			
	Miller_CallHeli02			= "f0090_rtrg0171",			
	Miller_HeliAttack 			= "f0090_rtrg0225",			
	Miller_HeliLeave 			= "f0090_rtrg0465",			
	Radio_HostageDead			= "f0090_rtrg0540",			

	Miller_CallHeliHot01		= "f0090_rtrg0175",			
	Miller_CallHeliHot02		= "f0090_rtrg0176",			


}

this.OptionalRadioList = {
	
	OptionalRadioSet_001 	= "Set_e0030_oprg0010",	
	OptionalRadioSet_002 	= "Set_e0030_oprg0015",	
	OptionalRadioSet_003 	= "Set_e0030_oprg0017",	

	OptionalRadioSet_101 	= "Set_e0030_oprg0020",	
	OptionalRadioSet_102 	= "Set_e0030_oprg0023",	
	OptionalRadioSet_103 	= "Set_e0030_oprg0027",	
	OptionalRadioSet_104 	= "Set_e0030_oprg0021",	
	OptionalRadioSet_105 	= "Set_e0030_oprg0024",	
	OptionalRadioSet_106 	= "Set_e0030_oprg0026",	
	OptionalRadioSet_107 	= "Set_e0030_oprg0028",	
	OptionalRadioSet_109 	= "Set_e0030_oprg0029",	
	OptionalRadioSet_110 	= "Set_e0030_oprg0022",	

	OptionalRadioSet_201 	= "Set_e0030_oprg0030",	
	OptionalRadioSet_202 	= "Set_e0030_oprg0033",	
	OptionalRadioSet_203 	= "Set_e0030_oprg0037",	

}


this.IntelRadioList = {
	
	SL_WoodTurret04			= "e0030_esrg0015",		
	intel_e0030_rtrg0065	= "f0090_esrg0140",		

	Cargo_Truck_WEST_001	= "e0030_esrg0042",		
	Cargo_Truck_WEST_002	= "e0030_esrg0045",		

	e20030_SecurityCamera	= "e0030_esrg0100",		

	
	e20030_Betrayer			= "e0030_esrg0080",		
	e20030_Mastermind		= "e0030_esrg0080",		
	e20030_Assistant		= "e0030_esrg0080",		
	e20030_enemy002			= "e0030_esrg0080",		
	e20030_enemy003			= "e0030_esrg0080",		
	e20030_enemy004			= "e0030_esrg0080",		
	e20030_enemy005			= "e0030_esrg0080",		
	e20030_enemy006			= "e0030_esrg0080",		
	e20030_enemy007			= "e0030_esrg0080",		
	e20030_enemy008			= "e0030_esrg0080",		
	e20030_DemoSoldier01	= "e0030_esrg0080",		
	e20030_DemoSoldier03	= "e0030_esrg0080",		
	e20030_enemy011			= "e0030_esrg0080",		
	e20030_enemy012			= "e0030_esrg0080",		
	e20030_enemy013			= "e0030_esrg0080",		
	e20030_enemy014			= "e0030_esrg0080",		
	e20030_enemy015			= "e0030_esrg0080",		
	e20030_enemy016			= "e0030_esrg0080",		
	e20030_enemy017			= "e0030_esrg0080",		
	e20030_enemy018			= "e0030_esrg0080",		
	e20030_DemoSoldier02	= "e0030_esrg0080",		
	e20030_enemy020			= "e0030_esrg0080",		
	e20030_Driver			= "e0030_esrg0080",		
	e20030_enemy022			= "e0030_esrg0080",		
	e20030_enemy023			= "e0030_esrg0080",		


	
	Hostage_e20030_000		= "e0030_esrg0110",		
	Hostage_e20030_001		= "e0030_esrg0110",		
	Hostage_e20030_002		= "e0030_esrg0110",		


	
	intel_f0090_esrg0110		= "f0090_esrg0110", 
	intel_f0090_esrg0120		= "f0090_esrg0120", 
	intel_f0090_esrg0130		= "f0090_esrg0130", 
	intel_f0090_esrg0140		= "f0090_esrg0140", 
	intel_f0090_esrg0150		= "f0090_esrg0150", 
	intel_f0090_esrg0190		= "f0090_esrg0190", 
	intel_f0090_esrg0200		= "f0090_esrg0200", 

	SL_WoodTurret01				= "f0090_esrg0010",	
	SL_WoodTurret02				= "f0090_esrg0010",	
	SL_WoodTurret03				= "f0090_esrg0010",	
	SL_WoodTurret05				= "f0090_esrg0010",	
	gntn_area01_searchLight_000	= "f0090_esrg0010",	
	gntn_area01_searchLight_001	= "f0090_esrg0010",	
	gntn_area01_searchLight_002	= "f0090_esrg0010",	
	gntn_area01_searchLight_003	= "f0090_esrg0010",	
	gntn_area01_searchLight_004	= "f0090_esrg0010",	
	gntn_area01_searchLight_005	= "f0090_esrg0010",	

	gntn_area01_antiAirGun_000	= "f0090_esrg0030", 
	gntn_area01_antiAirGun_001	= "f0090_esrg0030", 
	gntn_area01_antiAirGun_002	= "f0090_esrg0030", 
	gntn_area01_antiAirGun_003	= "f0090_esrg0030", 
	Tactical_Vehicle_WEST_001	= "f0090_esrg0040", 
	Tactical_Vehicle_WEST_002	= "f0090_esrg0040", 

	APC_Machinegun_WEST_001		= "f0090_esrg0080", 
	APC_Machinegun_WEST_002		= "f0090_esrg0080", 

	
	e20030_SecurityCamera		= "e0030_esrg0100",	
	e20030_SecurityCamera_01	= "f0090_esrg0210",
	e20030_SecurityCamera_03	= "f0090_esrg0210",
	e20030_SecurityCamera_04	= "f0090_esrg0210",

	
	gntnCom_drum0002			= "f0090_esrg0180",
	gntnCom_drum0005			= "f0090_esrg0180",
	gntnCom_drum0011			= "f0090_esrg0180",
	gntnCom_drum0012			= "f0090_esrg0180",
	gntnCom_drum0015			= "f0090_esrg0180",
	gntnCom_drum0019			= "f0090_esrg0180",
	gntnCom_drum0020			= "f0090_esrg0180",
	gntnCom_drum0021			= "f0090_esrg0180",
	gntnCom_drum0022			= "f0090_esrg0180",
	gntnCom_drum0023			= "f0090_esrg0180",
	gntnCom_drum0024			= "f0090_esrg0180",
	gntnCom_drum0025			= "f0090_esrg0180",
	gntnCom_drum0027			= "f0090_esrg0180",
	gntnCom_drum0028			= "f0090_esrg0180",
	gntnCom_drum0029			= "f0090_esrg0180",
	gntnCom_drum0030			= "f0090_esrg0180",
	gntnCom_drum0031 			= "f0090_esrg0180",
	gntnCom_drum0035			= "f0090_esrg0180",
	gntnCom_drum0037			= "f0090_esrg0180",
	gntnCom_drum0038			= "f0090_esrg0180",
	gntnCom_drum0039			= "f0090_esrg0180",
	gntnCom_drum0040			= "f0090_esrg0180",
	gntnCom_drum0041			= "f0090_esrg0180",
	gntnCom_drum0042			= "f0090_esrg0180",
	gntnCom_drum0043			= "f0090_esrg0180",
	gntnCom_drum0044			= "f0090_esrg0180",
	gntnCom_drum0045			= "f0090_esrg0180",
	gntnCom_drum0046			= "f0090_esrg0180",
	gntnCom_drum0047			= "f0090_esrg0180",
	gntnCom_drum0048			= "f0090_esrg0180",
	gntnCom_drum0065			= "f0090_esrg0180",
	gntnCom_drum0066			= "f0090_esrg0180",
	gntnCom_drum0068			= "f0090_esrg0180",
	gntnCom_drum0069			= "f0090_esrg0180",
	gntnCom_drum0070			= "f0090_esrg0180",
	gntnCom_drum0071			= "f0090_esrg0180",
	gntnCom_drum0072			= "f0090_esrg0180",
	gntnCom_drum0101			= "f0090_esrg0180",

	
	intel_f0090_esrg0220		= "f0090_esrg0220",
}


this.ContinueHostageRegisterList = {
	
	CheckList01 = {
		Pos				= "Pos_Tactical_Vehicle_WEST_001",
		VehicleType			= "Vehicle",
		HostageRegisterPoint		= { "Pos_HostageWarpVehicle001_01", "Pos_HostageWarpVehicle001_02", "Pos_HostageWarpVehicle001_03",},
	},
	CheckList02 = {
		Pos				= "Pos_Tactical_Vehicle_WEST_002",
		VehicleType			= "Vehicle",
		HostageRegisterPoint		= { "Pos_HostageWarpVehicle002_01", "Pos_HostageWarpVehicle002_02", "Pos_HostageWarpVehicle002_03",},
	},
	
	CheckList03 = {
		Pos				= "Pos_APC_Machinegun_WEST_001",
		VehicleType			= "Armored_Vehicle",
		HostageRegisterPoint		= { "Pos_HostageWarpAPC001_01", "Pos_HostageWarpAPC001_02", "Pos_HostageWarpAPC001_03",},
	},
	CheckList04 = {
		Pos				= "Pos_APC_Machinegun_WEST_002",
		VehicleType			= "Armored_Vehicle",
		HostageRegisterPoint		= { "Pos_HostageWarpAPC002_01", "Pos_HostageWarpAPC002_02", "Pos_HostageWarpAPC002_03",},
	},
}





this.Messages = {
	Mission = {
		{ message = "MissionFailure", 					localFunc = "commonMissionFailure" },		
		{ message = "MissionClear", 					localFunc = "commonMissionClear" },			
		{ message = "MissionRestart", 					localFunc = "commonMissionCleanUp" },		
		{ message = "MissionRestartFromCheckPoint", 	localFunc = "commonMissionCleanUp" },		
		{ message = "ReturnTitle", 						localFunc = "commonReturnTitle" },		
	},
	Trap = {
		
		{ data = "Trap_Area_campEast", 			message = { "Enter" }, commonFunc = function() this.commonPlayerAreacampEast() end },
		{ data = "Trap_Area_campWest", 			message = { "Enter" }, commonFunc = function() this.commonPlayerAreacampWest() end },
		{ data = "Trap_Area_ControlTower", 		message = { "Enter" }, commonFunc = function() this.commonPlayerAreaControlTower() end },

		
		{  data = "WestCamp", 		message = "Enter",		commonFunc = function() TppMission.SetFlag( "isPlayerInWestCamp", true ) end },
		{  data = "WestCamp", 		message = "Exit",		commonFunc = function() TppMission.SetFlag( "isPlayerInWestCamp", false ) end },

		
		{ data = "Trap_WarningMissionArea", message = { "Enter" }, 		commonFunc = function() this.commonOutsideMissionWarningAreaEnter() end },
		{ data = "Trap_WarningMissionArea", message = { "Exit"	}, 		commonFunc = function() this.commonOutsideMissionWarningAreaExit() end },
		{ data = "Trap_EscapeMissionArea",	message = { "Enter" }, 		commonFunc = function() this.commonOutsideMissionArea() end },

		
		{ data = "Trap_HostageCallHelp",	message = "Enter",			commonFunc = function() this.commonOnPlayerEnterHostageCallTrap("Enter") end },
		{ data = "Trap_HostageCallHelp",	message = "Exit",			commonFunc = function() this.commonOnPlayerEnterHostageCallTrap("Exit") end },
		
		{ data = "Trap_EnterHostageArea",	message = "Enter",			commonFunc = function() this.commonOnPlayerEnterHostageAreaTrap() end },
		
		{ data = "Trap_Monologue_Hostage01",	message = "Enter",	commonFunc = function() GZCommon.CallMonologueHostage( "Hostage_e20030_000", "hostage_a", "e20030_trap", "Trap_Monologue_Hostage01" ) end },
		{ data = "Trap_Monologue_Hostage02",	message = "Enter",	commonFunc = function() GZCommon.CallMonologueHostage( "Hostage_e20030_001", "hostage_d", "e20030_trap", "Trap_Monologue_Hostage02" ) end },
		{ data = "Trap_Monologue_Hostage03",	message = "Enter",	commonFunc = function() GZCommon.CallMonologueHostage( "Hostage_e20030_002", "hostage_c", "e20030_trap", "Trap_Monologue_Hostage03" ) end },

		
		

		
		{ data = "Trap_WavActivate",	message = "Enter",		commonFunc = function() this.commonCheckActivateWav() end },
		
		{ data = "Trap_InspectionInfo", message = "Enter",		commonFunc = function() this.commonCheckInspectionAppearance() end },

	},
	Timer = {
		
		{ data = "ForceSerchingTimer", message = "OnEnd", commonFunc = function() this.commonFinishForceSerching() end },

		
		{ data = "CheckTargetPhotoTimer", message = "OnEnd", commonFunc = function() this.commonCheckTargetPhotoTimer() end },

		
		{ data = "RestraintCheckTimer", 	message = "OnEnd", commonFunc = function() this.commonBetrayerRestraint() end },
		
		{ data = "BetrayerContactCheckTimer", message = "OnEnd", commonFunc = function() this.commonBetrayerContactCheck() end },
		
		{ data = "InterrogationTimer", message = "OnEnd", commonFunc = function() this.commonBetrayerInterrogation() end },

		
		{ data = "dbg_InterrogationTimer_Betrayer1", 	message = "OnEnd", commonFunc = function() this.commonFinishBetrayerSerif1() end },
		{ data = "dbg_InterrogationTimer_Betrayer2", 	message = "OnEnd", commonFunc = function() this.commonFinishBetrayerSerif2() end },

		
		{ data = "CassetteDropTimer", message = "OnEnd", commonFunc = function() this.CommonDropCassette_B() end },

		
		{ data = "Truck001EnableTimer", message = "OnEnd", commonFunc = function() TppData.Enable( "Cargo_Truck_WEST_001" ) end },
		{ data = "Truck002EnableTimer", message = "OnEnd", commonFunc = function() TppData.Enable( "Cargo_Truck_WEST_002" ) end },

		
		{ data = "Timer_pleaseLeaveHeli", message = "OnEnd", commonFunc = function() this.commonHeliLeaveJudge() end },

		
		{ data = "Timer_SignalLightON_01",	message = "OnEnd", commonFunc = function() this.CallSignalLightSE_ON() end },
		{ data = "Timer_SignalLightOFF_01",	message = "OnEnd", commonFunc = function() this.CallSignalLightSE_OFF() end },
		{ data = "Timer_SignalLightON_02",	message = "OnEnd", commonFunc = function() this.CallSignalLightSE_ON() end },
		{ data = "Timer_SignalLightOFF_02",	message = "OnEnd", commonFunc = function() this.CallSignalLightSE_OFF() end },
		{ data = "Timer_SignalLightON_03",	message = "OnEnd", commonFunc = function() this.CallSignalLightSE_ON() end },
		{ data = "Timer_SignalLightOFF_03",	message = "OnEnd", commonFunc = function() this.CallSignalLightSE_OFF() end },
		{ data = "Timer_SignalLightON_04",	message = "OnEnd", commonFunc = function() this.CallSignalLightSE_ON() end },
		{ data = "Timer_SignalLightOFF_04",	message = "OnEnd", commonFunc = function() this.CallSignalLightSE_OFF() end },
		{ data = "Timer_SignalLightON_05",	message = "OnEnd", commonFunc = function() this.CallSignalLightSE_ON() end },
	},
	Character = {
		
		
		{ data = this.AssistantID,		message = "MessageRoutePoint",	commonFunc = function() this.commonBetrayerRoutePoint() end },	
		
		{ data = "e20030_DemoSoldier01",	message = "EnemyArrivedAtRouteNode",	commonFunc = function() this.commonDemoSoldierRoutePoint() end },	
		{ data = "e20030_DemoSoldier02",	message = "EnemyArrivedAtRouteNode",	commonFunc = function() this.commonDemoSoldierRoutePoint() end },	

		
		
		{ data = this.BetrayerID,	message = "MessageRoutePoint",	commonFunc = function() this.commonBetrayerRoutePoint() end },
		
		
		{ data = this.BetrayerID,	message = "EnemyRestraint",		commonFunc = function() this.commonBetrayerRestraint() end },
		
		{ data = this.BetrayerID,	message = "EnemyRestraintEnd",	commonFunc = function() this.commonBetrayerRestraintEnd() end },
		
		
		{ data = this.BetrayerID,	message = "EnemyInterrogation",	commonFunc = function() TppTimer.Start( "InterrogationTimer", 0.5 ) end },	
		
		{ data = this.BetrayerID,	message = "EnemyDead", 			commonFunc = function() this.commonBetrayerDead() end },
		
		{ data = this.BetrayerID,	message = "EnemyFaint",			commonFunc = function() this.commonBetrayerFaint() end },
		
		{ data = this.BetrayerID,	message = "EnemySleep",			commonFunc = function() this.commonBetrayerSleep() end },
		
		{ data = this.BetrayerID,	message = "MessageHumanEnemyCarriedStart",	commonFunc = function() this.commonBetrayerCarried() end },

		
		
		{ data = this.MastermindID,	 message = "EnemyInterrogation",	commonFunc = function() this.commonMastermindInterrogation() end },
		
		{ data = this.MastermindID,	 message = "EnemyDead",				commonFunc = function() this.commonMastermindDead() end },
		
		{ data = this.MastermindID,	 message = "EnemyRestraintEnd",		commonFunc = function() this.commonMastermindRestraintEnd() end },

		
		
		{ data = "e20030_Driver",	message = "EnemyArrivedAtRouteNode",	commonFunc = function() this.commonDriverRoutePoint() end },

		
		{ data = "e20030_SecurityCamera",	message = "Dead",	commonFunc = function() this.commonSecurityCameraDead() end },
		{ data = "e20030_SecurityCamera",	message = "Alert",	commonFunc = function() this.commonSecurityCameraAlert() end },

		
		{ data = "e20030_SecurityCamera_01",	message = "Dead",		commonFunc = function() this.Common_SecurityCameraBroken() end },
		{ data = "e20030_SecurityCamera_03",	message = "Dead",		commonFunc = function() this.Common_SecurityCameraBroken() end },
		{ data = "e20030_SecurityCamera_04",	message = "Dead",		commonFunc = function() this.Common_SecurityCameraBroken() end },
		{ data = "e20030_SecurityCamera",		message = "PowerOFF",	commonFunc = function() this.Common_SecurityCameraPowerOff() end },
		{ data = "e20030_SecurityCamera_01",	message = "PowerOFF",	commonFunc = function() this.Common_SecurityCameraPowerOff() end },
		{ data = "e20030_SecurityCamera_03",	message = "PowerOFF",	commonFunc = function() this.Common_SecurityCameraPowerOff() end },
		{ data = "e20030_SecurityCamera_04",	message = "PowerOFF",	commonFunc = function() this.Common_SecurityCameraPowerOff() end },
		{ data = "e20030_SecurityCamera",		message = "PowerON",	commonFunc = function() this.Common_SecurityCameraPowerOn() end },
		{ data = "e20030_SecurityCamera_01",	message = "PowerON",	commonFunc = function() this.Common_SecurityCameraPowerOn() end },
		{ data = "e20030_SecurityCamera_03",	message = "PowerON",	commonFunc = function() this.Common_SecurityCameraPowerOn() end },
		{ data = "e20030_SecurityCamera_04",	message = "PowerON",	commonFunc = function() this.Common_SecurityCameraPowerOn() end },

		
		
		{ data = "Hostage_e20030_000",	message = "Dead",	commonFunc = function() this.commonOnDeadHostage() end	},
		{ data = "Hostage_e20030_001",	message = "Dead",	commonFunc = function() this.commonOnDeadHostage() end	},
		{ data = "Hostage_e20030_002",	message = "Dead",	commonFunc = function() this.commonOnDeadHostage() end	},

		
		{ data = "gntn_cp",		message = "VehicleMessageRoutePoint",	commonFunc = function() this.commonVehicleRouteUpdate() end },	
		{ data = "gntn_cp",		message = "EndGroupVehicleRouteMove",	commonFunc = function() this.commonVehicleRouteFinish() end },	
		{ data = "gntn_cp",		message = "Alert",						commonFunc = function() this.CheckAlertChange() end },			
		{ data = "gntn_cp",		message = "Evasion",					commonFunc = function() this.CheckPhaseChange() end },			
		{ data = "gntn_cp",		message = "Caution",					commonFunc = function() this.CheckPhaseChange() end },			
		{ data = "gntn_cp",		message = "Sneak",						commonFunc = function() this.CheckPhaseChange() end },			
		{ data = "gntn_cp",		message = "ConversationEnd",			commonFunc = function() this.commonConversationEnd() end },		
		{ data = "gntn_cp",		message = "AntiAir",					commonFunc = function() this.ChangeAntiAir() end },				
		{ data = "gntn_cp",		message = "EndRadio"		, 			commonFunc = function() this.EndCPRadio( ) end	},				
		
		{ data = "gntn_cp",		message = "VehicleMessageRoutePoint", 	commonFunc = function() GZCommon.Common_CenterBigGateVehicle( ) end  },
		{ data = "gntn_cp",		message = "EndRadio"		, 			commonFunc = function() GZCommon.Common_CenterBigGateVehicleEndCPRadio( ) end  },

		
		{ data = "Player", 		message = "RideHelicopter", 			commonFunc = function() this.commonPlayerRideHeli() end },		
		{ data = "Player", 		message = "OnPickUpItem", 				commonFunc = function() this.commonPlayerPickItem() end },		
		{ data = "Player", 		message = "OnVehicleRideSneak_End", 	commonFunc = function() this.commonPlayerRideOnCargo() end },	
		{ data = "Player", 		message = "OnVehicleGetOffSneak_Start", commonFunc = function() this.commonPlayerGetOffCargo() end },	
		{ data = "Player",		message = "OnVehicleRide_End",			commonFunc = function() this.commonPlayerRideOnVehicle() end },	
		{ data = "Player",		message = "NotifyStartWarningFlare",	commonFunc = function() this.MbDvcActCallRescueHeli("SupportHelicopter", "flare") end },	
		{ data = "Player",		message = "TryPicking",					commonFunc = function() this.commonOnPickingDoor() end },		

		
		{ data = "SupportHelicopter",	message = "ArriveToLandingZone",	commonFunc = function() this.commonHeliArrive() end },				
		{ data = "SupportHelicopter",	message = "DepartureToMotherBase",	commonFunc = function() this.commonHeliTakeOff() end  },			
		{ data = "SupportHelicopter",	message = "Dead",					commonFunc = function() this.commonHeliDead() end  },				
		{ data = "SupportHelicopter",	message = "DamagedByPlayer",		commonFunc = function() this.commonHeliDamagedByPlayer() end },		

		
		{ data = "APC_Machinegun_WEST_002",		message = "StrykerDestroyed",	commonFunc = function() TppMission.SetFlag( "isWavBroken", true ) end },

		
		{ data = "Hostage_e20030_000",	message = "HostageLaidOnVehicle",	commonFunc = function() this.commonHostageLaidOn() end	},	
		{ data = "Hostage_e20030_001",	message = "HostageLaidOnVehicle",	commonFunc = function() this.commonHostageLaidOn() end	},	
		{ data = "Hostage_e20030_002",	message = "HostageLaidOnVehicle",	commonFunc = function() this.commonHostageLaidOn() end	},	
	},
	Enemy = {
		
		{ message = "HostageLaidOnVehicle",			commonFunc = function() this.commonOnLaidEnemy() end  },
	},
	Myself = {
		{ data = this.BetrayerID,		message = "LookingTarget",		commonFunc = function() this.commonMissionTargetMarkingCheck() end },
		{ data = this.MastermindID,		message = "LookingTarget",		commonFunc = function() this.commonMissionTargetMarkingCheck() end },
	},
	Gimmick = {
		
		{ data = "WoodTurret03", 	message = "BreakGimmick", commonFunc = function() this.commonWoodTurret03Break() end },	
		{ data = "WoodTurret04", 	message = "BreakGimmick", commonFunc = function() this.commonWoodTurret04Break() end },	
		
		{ data = "SL_WoodTurret04", message = "BreakGimmick", commonFunc = function() this.commonWoodTurret04Break() end },	
		{ data = "SL_WoodTurret04", message = "RideEmplacement", commonFunc = function() this.commonUseSignalLight() end },	
		
		{ data = "gntn_center_SwitchLight", message = "SwitchOn", commonFunc = function() this.SwitchLight_ON() end },	
		{ data = "gntn_center_SwitchLight", message = "SwitchOff", commonFunc = function() this.SwitchLight_OFF() end },	
	},
	Radio = {
		
		
		
		{ data = "e20030_SecurityCamera", message = "EspionageRadioPlayButton" , commonFunc = function() this.IntelRadioPlayCameraTrap() end },
		
		{ data = "f0090_rtrg0130",		message = "RadioEventMessage", commonFunc = function() this.commonHeliLeaveExtension() end },
		{ data = "f0090_rtrg0200",		message = "RadioEventMessage", commonFunc = function() this.commonHeliLeaveExtension() end },
		{ data = "f0090_rtrg0210",		message = "RadioEventMessage", commonFunc = function() this.commonHeliLeaveExtension() end },
	},
	RadioCondition = {

		{ message = "PlayerHurt", 				commonFunc = function() TppRadio.Play( "Miller_CuarAdvice" ) end },
		{ message = "PlayerCureComplete", 		commonFunc = function() TppRadio.Play( "Miller_SpRecoveryLifeAdvice" ) end },
		{ message = "SuppressorIsBroken", 		commonFunc = function() this.commonSuppressorIsBroken() end },
	},
	Subtitles = {
		
		{ data="intl3000_1k1010", message = "SubtitlesEventMessage", commonFunc = function() this.commonShowTutorial_CQC() end },
		
		{ data="intl0z00_111012", message = "SubtitlesEventMessage", commonFunc = function() this.commonShowTutorial_CQC() end },

		
		{ data="sltb0z00_1y1010", message = "SubtitlesEventMessage", commonFunc = function() this.commonSubtitles_BetrayerSerifA() end },
		
		{ data="sltb0z00_1y1210", message = "SubtitlesEventMessage", commonFunc = function() this.commonSubtitles_BetrayerSerifB() end },
		
		{ data="sltb0z00_1y1310", message = "SubtitlesEventMessage", commonFunc = function() this.commonSubtitles_BetrayerSerifC() end },
		
		{ data="sltb0z00_1y1410", message = "SubtitlesEventMessage", commonFunc = function() this.commonSubtitles_BetrayerSerifD() end },

		
		{ data="sltb0z00_1y1510", message = "SubtitlesEventMessage", commonFunc = function() this.commonSubtitles_DropTapeB() end },
		
		{ data="sltb0z00_1y1610", message = "SubtitlesEventMessage", commonFunc = function() this.commonSubtitles_Rebellion() end },

		
		{ data="sltb0z00_291010", message = "SubtitlesEventMessage", commonFunc = function() this.commonSubtitles_TrapA() end },
		
		{ data="sltb0z00_2a1010", message = "SubtitlesEventMessage", commonFunc = function() this.commonSubtitles_TrapB() end },
	},
	UI = {
		
		{ message = "StopWalkMan" , commonFunc = function() this.commonStopWalkMan() end },
	},
	Terminal = {
		
		{ message = "MbDvcActFocusMapIcon",	commonFunc = function() this.commonFocusMapIcon() end },
		{ message = "MbDvcActCallRescueHeli", commonFunc = function() this.MbDvcActCallRescueHeli("SupportHelicopter", "MbDvc") end  },    
	},
	Marker = {
		{	message = "ChangeToEnable",	commonFunc = function() this.commonMarkerEnable() end },	
	},
	Demo = {
		{ data="p11_020003_000", message="invis_cam",	commonFunc = function() TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20030_SecurityCamera_04", false ) end },
		{ data="p11_020003_000", message="lightOff", commonFunc = function() TppGadgetUtility.SetSwitch("gntn_center_SwitchLight",false) end },
		{ data="p11_020003_000", message="lightOn", commonFunc = function() TppGadgetUtility.SetSwitch("gntn_center_SwitchLight",true) end },
		{ data="p11_020003_000", message="under", commonFunc = function() TppWeatherManager:GetInstance():RequestTag("under", 0 ) end },
		{ data="p11_020003_000", message="default", commonFunc = function() TppWeatherManager:GetInstance():RequestTag("default", 0 ) end },
	},
}





this.onMissionPrepare = function( manager )





	local sequence = TppSequence.GetCurrentSequence()

	
	if ( sequence == "Seq_MissionPrepare" or manager:IsStartingFromResearvedForDebug() ) then
		
		local hardmode = TppGameSequence.GetGameFlag("hardmode")
		if ( hardmode ) then
			TppPlayer.SetWeapons( GZWeapon.e20030_SetWeaponsHard )
		else
			TppPlayer.SetWeapons( GZWeapon.e20030_SetWeapons )
		end
	end

	if( TppSequence.IsGreaterThan( sequence, "Seq_TruckInfiltration" ) ) then

		
		this.CounterList.PlayerOnCargo = "NoRide"
	else
		

		
		TppPlayerUtility.SetActionStatusOnStartMission( "ACTION_STATUS_RIDE_ON_DECK" )
		TppPlayerUtility.SetPairCharacterIdOnStartMission( "Cargo_Truck_WEST_001" )		

		
		this.CounterList.PlayerOnCargo = "Cargo_Truck_WEST_001"

		
		GZCommon.PlayerAreaName = "WestCamp"

	end

	
	this.tmpBestRank = this.CheckClearRankReward()




	
	local uiCommonData = UiCommonDataManager.GetInstance()
	if ( TppMission.GetFlag("isGetCassette_A") == false ) then
		uiCommonData:HideCassetteTape( this.CassetteA )
	end
	if ( TppMission.GetFlag("isGetCassette_B") == false ) then
		uiCommonData:HideCassetteTape( this.CassetteB )
	end
	
	
	local uiCommonData = UiCommonDataManager.GetInstance()
	this.tmpRewardNum = uiCommonData:GetRewardNowCount( this.missionID )



	

end




this.CheckClearRankReward = function()





	local hardmode = TppGameSequence.GetGameFlag("hardmode")
	local BestRank = 0

	
	if ( hardmode ) then
		
		BestRank = PlayRecord.GetMissionScore( this.missionID, "HARD", "BEST_RANK")



	else
		
		BestRank = PlayRecord.GetMissionScore( this.missionID, "NORMAL", "BEST_RANK")



	end

	
	
	if ( BestRank == 1 ) then
		
		
		TppNewCollectibleUtility.PutCollectibleOnCharacter{ id = "WP_ar00_v05", count = 240, countSub = 15, target = "Cargo_Truck_WEST_001" , attachPoint = "CNP_USERITEM" }
		return BestRank
	else
		return 2
	end



end


local onCommonMissionSetup = function()




	GZCommon.MissionSetup()	

	
	TppClock.SetTime( "18:00:00" )
	TppClock.Stop()
	TppWeather.SetWeather( "sunny" )
	WeatherManager.RequestTag("default", 0 )
	GrTools.SetLightingColorScale(4.0)	

	TppEffectUtility.RemoveColorCorrectionLut()

	
	MissionManager.SetMiddleTextureWaitParameter( 0.5, 5 )

	
	this.commonMissionFlagRestore()

	
	MissionManager.RegisterVipMember( "e20030_UniqueChara", this.BetrayerID, 	"espionage", 0 )	
	MissionManager.RegisterVipMember( "e20030_UniqueChara", this.MastermindID, 	"espionage", 1 )	
	MissionManager.RegisterVipMember( "e20030_UniqueChara", this.AssistantID, 	"espionage", 2 )	

	
	GZCommon.EnemyLaidonHeliNoAnnounceSet( this.BetrayerID )
	GZCommon.EnemyLaidonHeliNoAnnounceSet( this.MastermindID )

	
	TppCommandPostObject.GsSetDisableRespawn( "gntn_cp", this.BetrayerID )
	TppCommandPostObject.GsSetDisableRespawn( "gntn_cp", this.MastermindID )

	
	TppGimmick.OpenDoor( "Paz_PickingDoor00", 270 )

	
	TppCommandPostObject.GsAddRespawnRandomWeaponId( "gntn_cp", "WP_sg01_v00", 30 )		
	TppCommandPostObject.GsAddRespawnRandomWeaponId( "gntn_cp", "WP_ms02", 10 )			

	
	TppCommandPostObject.GsSetGuardTargetValidity( "gntn_cp", "TppGuardTargetData_InspectionNorth", false )
	TppCommandPostObject.GsSetGuardTargetValidity( "gntn_cp", "TppGuardTargetData_InspectionWest", false )

	
	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager ~= NULL then
		local luaData = commonDataManager:GetUiLuaExportCommonData()
		if luaData ~= NULL then
			luaData:ResetMisionInfoCurrentStoryNo() 
		end
	end

	
	TppRadio.SetAllSaveRadioId()

end



local commonUiMissionPhotoSetup = function()




	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager == NULL then
			return
	end
	local luaData = commonDataManager:GetUiLuaExportCommonData()
	if luaData == NULL then
			return
	end
	luaData:EnableMissionPhotoId(10)						
	luaData:SetAdditonalMissionPhotoId(10, true, false)		

end



local commonMissionSubGoalSetting = function( GoalNum )





	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager == NULL then
		return
	end

	local luaData = commonDataManager:GetUiLuaExportCommonData()

	if luaData == NULL then
		return
	end

	luaData:SetCurrentMissionSubGoalNo( GoalNum ) 

end



local commonMarkerMissionSetup = function()





	
	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager == NULL then
		return
	end

	local luaData = commonDataManager:GetUiLuaExportCommonData()
	if luaData == NULL then
		return
	end

	luaData:SetupIconUniqueInformationTable(
		

		{ markerId= "e20030_marker_Cassette", 		langId="marker_info_item_tape" },
		{ markerId= "e20030_marker_Signal", 		langId="marker_info_place_04" },			



		
		{ markerId= "Tactical_Vehicle_WEST_001", 		langId="marker_info_vehicle_4wd" },
		{ markerId= "Tactical_Vehicle_WEST_002", 		langId="marker_info_vehicle_4wd" },
		{ markerId= "APC_Machinegun_WEST_001", 			langId="marker_info_APC" },
		{ markerId= "APC_Machinegun_WEST_002", 			langId="marker_info_APC" },
		{ markerId= "Cargo_Truck_WEST_001", 			langId="marker_info_truck" },
		{ markerId= "Cargo_Truck_WEST_002", 			langId="marker_info_truck" },

		
		{ markerId= "e20030_marker_Ammo001", 				langId="marker_info_bullet_tranq" },		
		{ markerId= "e20030_marker_Ammo002", 				langId="marker_info_bullet_tranq" },		
		{ markerId= "e20030_marker_Ammo003", 				langId="marker_info_bullet_tranq" },		
		{ markerId= "e20030_marker_C4_01", 					langId="marker_info_weapon_06" },
		{ markerId= "e20030_marker_C4_02", 					langId="marker_info_weapon_06" },
		{ markerId= "e20030_marker_Dmines", 				langId="marker_info_weapon_08" },
		{ markerId= "e20030_marker_Grenade", 				langId="marker_info_weapon_07" },
		{ markerId= "e20030_marker_HandGun_01", 			langId="marker_info_weapon_00" },
		{ markerId= "e20030_marker_HandGun_02", 			langId="marker_info_weapon_00" },
		{ markerId= "e20030_marker_MonlethalWeapon", 		langId="marker_info_weapon" },
		{ markerId= "e20030_marker_RecoillessRifle", 		langId="marker_info_weapon_02" },
		{ markerId= "e20030_marker_SmokeGrenade01", 		langId="marker_info_weapon_05" },
		{ markerId= "e20030_marker_SniperRifle", 			langId="marker_info_weapon_01" },
		{ markerId= "e20030_marker_SubAmmo01", 				langId="marker_info_bullet_artillery" },	
		{ markerId= "e20030_marker_SubAmmo02", 				langId="marker_info_bullet_tranq" },		
		{ markerId= "e20030_marker_SubmachineGun", 			langId="marker_info_weapon_04" },
		{ markerId= "e20030_marker_Weapon", 				langId="marker_info_weapon" },
		{ markerId= "e20030_marker_ShotGun", 				langId="marker_info_weapon_03" },

		
		{ markerId = "common_marker_Area_Asylum", 			langId = "marker_info_area_05" },				
		{ markerId = "common_marker_Area_EastCamp", 		langId = "marker_info_area_00" },				
		{ markerId = "common_marker_Area_WestCamp", 		langId = "marker_info_area_01" },				
		{ markerId = "common_marker_Area_Center", 			langId = "marker_info_area_04" },				
		{ markerId = "common_marker_Area_HeliPort", 		langId = "marker_info_area_03" },				
		{ markerId = "common_marker_Area_WareHouse", 		langId = "marker_info_area_02" },				

		
		{ markerId= "common_marker_Armory_Center", 			langId="marker_info_place_armory" },		
		{ markerId= "common_marker_Armory_HeliPort", 		langId="marker_info_place_armory" },		
		{ markerId= "common_marker_Armory_WareHouse", 		langId="marker_info_place_armory" }			
	)

	
	TppMarker.Disable( "e20030_marker_Signal" )				
	
	TppMarker.Disable( "e20030_marker_Cassette" )			
	TppMarker.Disable( "TppMarkerLocator_EscapeWest" )		
	TppMarker.Disable( "TppMarkerLocator_EscapeNorth" )		

end




local commonDemoBlockSetup = function()

	
	local demoBlockPath = "/Assets/tpp/pack/mission/extra/e20030/e20030_d01.fpk"
	TppMission.LoadDemoBlock( demoBlockPath )
	TppMission.LoadEventBlock("/Assets/tpp/pack/location/gntn/gntn_heli.fpk" )
end



local commonRouteSetMissionSetup = function( currentRouteSet )





	
	TppEnemy.RegisterRouteSet( "gntn_cp", "sneak_day", 		"e20030_routeSet_d01_basic01" )
	TppEnemy.RegisterRouteSet( "gntn_cp", "sneak_night", 	"e20030_routeSet_d01_basic02" )
	TppEnemy.RegisterRouteSet( "gntn_cp", "caution_day", 	"e20030_routeSet_c01_basic01" )
	TppEnemy.RegisterRouteSet( "gntn_cp", "caution_night", 	"e20030_routeSet_c01_serching01" )
	TppEnemy.RegisterRouteSet( "gntn_cp", "hold", 			"gntn_common_routeSet_r01_controlTower" )	

	


	TppCommandPostObject.GsSetCurrentRouteSet( "gntn_cp", currentRouteSet, true, true, true, true )
	TppCharacterUtility.ResetPhase()	


	
	this.commonBetrayerRouteDisable()
	this.commonAssistantrRouteDisable()

	
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_mst_route0000" )

	
	TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0028" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0030" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0128" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0032" )	
	TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0033" )	

	
	TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0010" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0011" )

	
	GZCommon.Common_CenterBigGateVehicleSetup( "gntn_cp", "VehicleDefaultRideRouteInfo_e20030",
														  "gntn_common_v01_route0010", 
														  "gntn_common_v01_route0011", 
														  17, "NotClose" )	

end



local commonUniqueCharaRouteSetup = function()





	
	TppEnemy.EnableRoute( "gntn_cp", "gntn_e20030_tgt_route0001" )
	TppEnemy.EnableRoute( "gntn_cp", "gntn_e20030_ast_route0000" )

	
	TppEnemy.ChangeRoute( "gntn_cp", this.BetrayerID, 	"e20030_routeSet_d01_basic01", "gntn_e20030_tgt_route0001", 6 )		
	TppEnemy.ChangeRoute( "gntn_cp", this.AssistantID, 	"e20030_routeSet_d01_basic01", "gntn_e20030_ast_route0000", 58 )		

	
	TppCommandPostObject.GsSetRealizeFirstPriority( "gntn_cp", this.BetrayerID, true )



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
	
	local hudCommonData = HudCommonDataManager.GetInstance()
	if hudCommonData:IsEndLoadingTips() == false then
		hudCommonData:PermitEndLoadingTips() 
		
		return false
	end
	
	return true
end









this.commonMissionFailure = function( manager, messageId, message )



	

	local hudCommonData = HudCommonDataManager.GetInstance()
	local radioDaemon = RadioDaemon:GetInstance()

	
	radioDaemon:StopDirectNoEndMessage()
	
	SubtitlesCommand.StopAll()

	
	TppEnemyUtility.IgnoreCpRadioCall(true)	
	TppEnemyUtility.StopAllCpRadio( 0.5 )	

	
	TppSoundDaemon.SetMute( 'GameOver' )

	
	this.CounterList.GameOverFadeTime = GZCommon.FadeOutTime_MissionFailed

	
	if( message == "Betrayer_Dead" )  then




		GZCommon.PlayCameraAnimationOnChicoPazDead(this.BetrayerID)

		
		this.CounterList.GameOverRadioName = "Radio_DeadBetrayer_BeforeDemo"

		hudCommonData:CallFailedTelop( "gameover_reason_target_died" )	

	
	elseif( message == "OutsideMissionArea" )  then




		
		if ( this.CounterList.PlayerOnCargo ~= "NoRide" ) then

			
			GZCommon.OutsideAreaCamera_Vehicle( this.CounterList.PlayerOnCargo, "Player" )
		else
			
			GZCommon.OutsideAreaCamera()
		end

		
		this.CounterList.GameOverRadioName = "Radio_MissionArea_Failed"

		hudCommonData:CallFailedTelop( "gameover_reason_mission_outside" )	

	
	elseif( message == "PlayerDead" )	then




		
		this.CounterList.GameOverRadioName = "Radio_DeadPlayer"

	
	elseif( message == "PlayerFallDead" )	then




		
		this.CounterList.GameOverRadioName = "Radio_DeadPlayer"

		
		this.CounterList.GameOverFadeTime = GZCommon.FadeOutTime_PlayerFallDead

	
	elseif( message == "RideHeli_Failed" )	then




		
		this.CounterList.GameOverRadioName = "Radio_RideHeli_Failed"

		hudCommonData:CallFailedTelop( "gameover_reason_mission_abort" )	

	
	elseif ( message == "PlayerDeadOnHeli" ) then




		
		this.CounterList.GameOverRadioName = "Radio_DeadPlayer"

	end

	
	TppSequence.ChangeSequence( "Seq_MissionFailed" )

end



this.commonMissionClearRequest = function( clearType )



	

	
	GZCommon.ScoreRankTableSetup( this.missionID )

	
	TppMission.ChangeState( "clear", clearType )

end



this.commonMissionClear = function( manager, messageId, message )



	

	local radioDaemon = RadioDaemon:GetInstance()

	
	radioDaemon:StopDirectNoEndMessage()
	
	SubtitlesCommand.StopAll()

	
	TppEnemyUtility.IgnoreCpRadioCall(true)	
	TppEnemyUtility.StopAllCpRadio( 0.5 )	

	
	Trophy.TrophyUnlock( this.TrophyId_GZ_SideOpsClear )

	
	if( message == "RideHeli_Clear" )  then




		
		TppSequence.ChangeSequence( "Seq_MissionClearShowTransition" )

	
	elseif( message == "EscapeArea_Clear" )  then




		

		
		if ( this.CounterList.PlayerOnCargo ~= "NoRide" ) then

			
			GZCommon.OutsideAreaCamera_Vehicle( this.CounterList.PlayerOnCargo, "Player" )
		else
			
			GZCommon.OutsideAreaCamera()
		end

		
		TppSequence.ChangeSequence( "Seq_PlayerEscapeMissionArea" )

	end

end



this.OnClosePopupWindow = function()





	
	local LangIdHash = TppData.GetArgument(1)

	
	if ( LangIdHash == this.tmpChallengeString ) then

		
		this.OnShowRewardPopupWindow()
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

	
	if ( ( Rank == 1 ) and ( Rank < this.tmpBestRank ) ) then




		this.tmpBestRank = ( this.tmpBestRank - 1 )

		hudCommonData:ShowBonusPopupItem( "reward_clear_s_rifle", "WP_ar00_v05", { isBarrel=true } )
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
		PlayRecord.GetMissionScore( 20030, "NORMAL", "CLEAR_COUNT" ) == 1 then	

		hudCommonData:ShowBonusPopupCommon( "reward_extreme" )						

	end

	
	if ( hudCommonData:IsShowBonusPopup() == false ) then



		TppSequence.ChangeSequence( "Seq_MissionEnd" )	
	end
end



this.commonMissionCleanUp = function()




	
	GZCommon.MissionCleanup()

	
	this.commonMissionFlagRestore()

	
	this.commonMissionCounterListRestore()

	
	GzRadioSaveData.ResetSaveRadioId()
	GzRadioSaveData.ResetSaveEspionageId()

	local radioManager = RadioDaemon:GetInstance()
	radioManager:DisableAllFlagIsMarkAsRead()
	radioManager:ResetRadioGroupAndGroupSetAlreadyReadFlag()

	
	TppRadioConditionManagerAccessor.Unregister( "Tutorial" )
	TppRadioConditionManagerAccessor.Unregister( "Basic" )

	
	TppMarkerSystem.DisableAllMarker()

end



this.commonReturnTitle = function()




	
	local uiCommonData = UiCommonDataManager.GetInstance()
	uiCommonData:ShowAllCassetteTapes()

	
	this.commonMissionCleanUp()

end




this.commonMissionFlagRestore = function( manager, messageId, message )

	

	
	TppMission.SetFlag( "isWarningMissionArea", false )

	
	TppMission.SetFlag( "isBetrayerTogether", false )

	
	TppMission.SetFlag( "isBetrayerSignalCheckWait", false )
	TppMission.SetFlag( "isAssistantSignalCheckWait", false )

	
	TppMission.SetFlag( "isRadio_SimpleObjectivePlay", false )

	
	TppMission.SetFlag( "OnPlay_MissionBriefingSub1", false )

end



this.commonMissionCounterListRestore = function()

	

	this.CounterList.BetrayerInterrogation 		= 0
	this.CounterList.MastermindInterrogation 	= 0
	this.CounterList.WestTruckStatus 	= 0
	this.CounterList.NorthTruckStatus 	= 0
	this.CounterList.BetrayerRestraint 	= 0

end



local commonSearchTargetSetup = function( manager )



	
	manager.CheckLookingTarget:ClearSearchTargetEntities()

	
	if( TppMission.GetFlag( "isBetrayerDown" ) == false )  then
		GZCommon.SearchTargetCharacterSetup( manager, this.BetrayerID )
	end

	
	if( TppMission.GetFlag( "isMastermindDown" ) == false )  then
		GZCommon.SearchTargetCharacterSetup( manager, this.MastermindID )
	end

end



this.commonSetCompleteMissionPhoto = function()





	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager ~= NULL then
		local luaData = commonDataManager:GetUiLuaExportCommonData()
		if luaData ~= NULL then

			luaData:SetCompleteMissionPhotoId(10, true)
		end
	end

end



this.commonUpdateMissionDescription = function()





	
	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager ~= NULL then
		local luaData = commonDataManager:GetUiLuaExportCommonData()
		if luaData ~= NULL then
			
			luaData:SetMisionInfoCurrentStoryNo(1)									
		end
	end

end





this.commonOptionalRadioUpdate = function()






	
	if( TppMission.GetFlag( "isGetCassette_A" ) == true or TppMission.GetFlag( "isGetCassette_B" ) == true ) then
		
		
		if ( TppMission.GetFlag( "isDropCassette_B" ) == false and TppMission.GetFlag( "isGetInfo_Mastermind" ) == true ) then



			TppRadio.RegisterOptionalRadio( "OptionalRadioSet_203" )
		
		elseif ( TppMission.GetFlag( "isDropCassette_B" ) == true and TppMission.GetFlag( "isGetCassette_B" ) == false ) then



			TppRadio.RegisterOptionalRadio( "OptionalRadioSet_104" )
		
		elseif ( TppMission.GetFlag( "isInspectionActive" ) == true ) then



			TppRadio.RegisterOptionalRadio( "OptionalRadioSet_202" )
		
		else



			TppRadio.RegisterOptionalRadio( "OptionalRadioSet_201" )
		end

	elseif( TppMission.GetFlag( "isBetrayerContact" ) == true )  then
		

		
		if ( TppMission.GetFlag( "isDropCassette_B" ) == true and TppMission.GetFlag( "isGetCassette_B" ) == false ) then



			TppRadio.RegisterOptionalRadio( "OptionalRadioSet_104" )

		
		elseif ( TppMission.GetFlag( "isGetInfo_Suspicion2" ) == false ) then
			
			if ( TppMission.GetFlag( "isGetInfo_Mastermind" ) == true ) then



				TppRadio.RegisterOptionalRadio( "OptionalRadioSet_106" )
			else
				
				if ( TppMission.GetFlag( "isCameraAlert" ) or TppMission.GetFlag( "isCameraBroken" ) or TppMission.GetFlag( "isCameraIntelRadioPlay" ) ) then



					TppRadio.RegisterOptionalRadio( "OptionalRadioSet_110" )
				else



					TppRadio.RegisterOptionalRadio( "OptionalRadioSet_101" )
				end
			end

		
		elseif ( TppMission.GetFlag( "isGetInfo_Mastermind" ) == true ) then
			
			if ( TppMission.GetFlag( "isCameraAlert" ) or TppMission.GetFlag( "isCameraBroken" ) or TppMission.GetFlag( "isCameraIntelRadioPlay" ) ) then



				TppRadio.RegisterOptionalRadio( "OptionalRadioSet_107" )
			else



				TppRadio.RegisterOptionalRadio( "OptionalRadioSet_103" )
			end
		else
			
			if ( TppMission.GetFlag( "isCameraAlert" ) or TppMission.GetFlag( "isCameraBroken" ) or TppMission.GetFlag( "isCameraIntelRadioPlay" ) ) then



				TppRadio.RegisterOptionalRadio( "OptionalRadioSet_109" )
			else
				
				if ( TppMission.GetFlag( "isCameraBroken" ) ) then



					TppRadio.RegisterOptionalRadio( "OptionalRadioSet_105" )
				else



					TppRadio.RegisterOptionalRadio( "OptionalRadioSet_102" )
				end
			end
		end

	else
		
		
		if ( TppMission.GetFlag( "listeningInfoFromBetrayer" ) == true ) then



			TppRadio.RegisterOptionalRadio( "OptionalRadioSet_003" )
		
		elseif ( TppMission.GetFlag( "isDropCassette_B" ) == true and TppMission.GetFlag( "isGetCassette_B" ) == false ) then



			TppRadio.RegisterOptionalRadio( "OptionalRadioSet_104" )
		
		elseif ( TppMission.GetFlag( "isSignalExecuted" ) == true or TppMission.GetFlag( "isSignalTurretDestruction" ) == true ) then



			TppRadio.RegisterOptionalRadio( "OptionalRadioSet_002" )
		else



			TppRadio.RegisterOptionalRadio( "OptionalRadioSet_001" )
		end

	end


end



this.commonRegisterIntelRadio = function()





	
	TppRadio.EnableIntelRadio( "Cargo_Truck_WEST_001")
	TppRadio.EnableIntelRadio( "Cargo_Truck_WEST_002")

	
	TppRadio.EnableIntelRadio( "e20030_SecurityCamera")

	
	TppRadio.DisableIntelRadio( "SL_WoodTurret04")
	
	

	
	

	TppRadio.EnableIntelRadio( this.BetrayerID )
	TppRadio.EnableIntelRadio( this.MastermindID )
	TppRadio.EnableIntelRadio( this.AssistantID )
	TppRadio.EnableIntelRadio( "e20030_enemy002" )
	TppRadio.EnableIntelRadio( "e20030_enemy003" )
	TppRadio.EnableIntelRadio( "e20030_enemy004" )
	TppRadio.EnableIntelRadio( "e20030_enemy005" )
	TppRadio.EnableIntelRadio( "e20030_enemy006" )
	TppRadio.EnableIntelRadio( "e20030_enemy007" )
	TppRadio.EnableIntelRadio( "e20030_enemy008" )
	TppRadio.EnableIntelRadio( "e20030_DemoSoldier01" )
	TppRadio.EnableIntelRadio( "e20030_DemoSoldier03" )
	TppRadio.EnableIntelRadio( "e20030_enemy011" )
	TppRadio.EnableIntelRadio( "e20030_enemy012" )
	TppRadio.EnableIntelRadio( "e20030_enemy013" )
	TppRadio.EnableIntelRadio( "e20030_enemy014" )
	TppRadio.EnableIntelRadio( "e20030_enemy015" )
	TppRadio.EnableIntelRadio( "e20030_enemy016" )
	TppRadio.EnableIntelRadio( "e20030_enemy017" )
	TppRadio.EnableIntelRadio( "e20030_enemy018" )
	TppRadio.EnableIntelRadio( "e20030_DemoSoldier02" )
	TppRadio.EnableIntelRadio( "e20030_enemy020" )
	TppRadio.EnableIntelRadio( "e20030_Driver" )
	TppRadio.EnableIntelRadio( "e20030_enemy022" )
	TppRadio.EnableIntelRadio( "e20030_enemy023" )


	
	TppRadio.EnableIntelRadio( "Hostage_e20030_000" )
	TppRadio.EnableIntelRadio( "Hostage_e20030_001" )
	TppRadio.EnableIntelRadio( "Hostage_e20030_002" )

	
	TppRadio.EnableIntelRadio( "gntnCom_drum0002" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0005" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0011" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0012" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0015" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0019" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0020" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0021" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0022" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0023" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0024" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0025" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0027" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0028" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0029" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0030" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0031" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0035" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0037" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0038" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0039" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0040" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0041" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0042" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0043" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0044" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0045" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0046" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0047" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0048" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0065" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0066" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0068" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0069" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0070" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0071" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0072" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0101" )

	
	TppRadio.EnableIntelRadio( "e20030_SecurityCamera" )
	TppRadio.EnableIntelRadio( "e20030_SecurityCamera_01" )
	TppRadio.EnableIntelRadio( "e20030_SecurityCamera_03" )
	TppRadio.EnableIntelRadio( "e20030_SecurityCamera_04" )
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



this.commonUpdateCheckEnemyIntelRadio = function()





	
	if ( TppMission.GetFlag( "isGetInfo_Mastermind" ) == true and
		  TppMission.GetFlag( "isDropCassette_B" ) == false ) then

		TppRadio.RegisterIntelRadio( this.MastermindID, "e0030_esrg0090", true )		
		TppRadio.RegisterIntelRadio( this.BetrayerID, "e0030_esrg0085", true )		
		this.commonUpdateNormalEnemyIntelRadio( "e0030_esrg0085" )				

	
	elseif ( TppMission.GetFlag("isBetrayerContact") == false and
			 TppMission.GetFlag("isBetrayerMarking") == false and
			 TppMission.GetFlag("isGetCassette_A") == false and
			 TppMission.GetFlag("isDropCassette_B") == false ) then

		TppRadio.RegisterIntelRadio( this.MastermindID, "e0030_esrg0080", true )		
		TppRadio.RegisterIntelRadio( this.BetrayerID, "e0030_esrg0080", true )		
		this.commonUpdateNormalEnemyIntelRadio( "e0030_esrg0080" )				

	
	else
		TppRadio.RegisterIntelRadio( this.MastermindID, "e0030_esrg0070", true )		
		TppRadio.RegisterIntelRadio( this.BetrayerID, "e0030_esrg0070", true )		
		this.commonUpdateNormalEnemyIntelRadio( "e0030_esrg0070" )				
	end

end



this.commonUpdateNormalEnemyIntelRadio = function( RadioId )





	TppRadio.RegisterIntelRadio( this.AssistantID, RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy002", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy003", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy004", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy005", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy006", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy007", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy008", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_DemoSoldier01", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_DemoSoldier03", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy011", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy012", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy013", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy014", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy015", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy016", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy017", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy018", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_DemoSoldier02", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy020", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_Driver", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy022", RadioId, true )
	TppRadio.RegisterIntelRadio( "e20030_enemy023", RadioId, true )


end



this.commonUpdateCheckCameraIntelRadio = function()





	
	local radioDaemon = RadioDaemon:GetInstance()
	if ( radioDaemon:IsRadioGroupMarkAsRead("e0030_esrg0103") == true or
		 radioDaemon:IsRadioGroupMarkAsRead("e0030_esrg0102") == true or
		 radioDaemon:IsRadioGroupMarkAsRead("e0030_esrg0101") == true ) then
		TppRadio.RegisterIntelRadio( "e20030_SecurityCamera", "f0090_esrg0210", true )
	else
		
		if ( TppMission.GetFlag( "isBetrayerContact" ) == true and
			  TppMission.GetFlag( "isGetInfo_Suspicion2" ) == true ) then

			TppRadio.RegisterIntelRadio( "e20030_SecurityCamera", "e0030_esrg0103", true )	

		
		elseif ( TppMission.GetFlag( "isBetrayerContact" ) == true and
				  TppMission.GetFlag( "isGetInfo_Suspicion2" ) == false ) then

			TppRadio.RegisterIntelRadio( "e20030_SecurityCamera", "e0030_esrg0102", true )	

		
		elseif ( TppMission.GetFlag( "isBetrayerContact" ) == false and
				  TppMission.GetFlag( "isGetInfo_Suspicion2" ) == true ) then

			TppRadio.RegisterIntelRadio( "e20030_SecurityCamera", "e0030_esrg0101", true )	

		
		else
			TppRadio.RegisterIntelRadio( "e20030_SecurityCamera", "e0030_esrg0100", true )	
		end
	end
end

this.Common_SecurityCameraBroken = function()
	local characterID = TppData.GetArgument( 1 )
	TppRadio.DisableIntelRadio( characterID )
end

this.Common_SecurityCameraPowerOff = function()
	local characterID = TppData.GetArgument( 1 )
	TppRadio.DisableIntelRadio( characterID )
end

this.Common_SecurityCameraPowerOn = function()
	local characterID = TppData.GetArgument( 1 )
	TppRadio.EnableIntelRadio( characterID)
end



this.commonMissionClearRadio = function()





	
	
	local Rank = PlayRecord.GetRank()

	if( Rank == 0 ) then



	elseif( Rank == 1 ) then
		TppRadio.Play( "Radio_MissionClearRank_S" )

		
		Trophy.TrophyUnlock( this.TrophyId_GZ_RankSClear )

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



local CallMissionBriefingOnTruck = function()





	
	
	

	TppRadio.DelayPlay( "Radio_AboutSignal", 0.2, "none", {	
		onStart = function()	TppMission.SetFlag( "OnPlay_MissionBriefingSub1", true )	end,	
		onEnd = function()
			if ( TppMission.GetFlag("isSignalTurretDestruction") == false ) then
				TppMarker.Enable( "e20030_marker_Signal", 0, "moving", "map_only_icon", 0, true, true )	
				this.commonCallAnnounceLog( this.AnnounceLogID_MapUpdate )		
			end

			
			TppRadio.EnableIntelRadio( "SL_WoodTurret04")
			
			TppMusicManager.PostJingleEvent( "SingleShot", "Stop_bgm_gntn_op_default" )

			if ( this.CounterList.PlayerOnCargo ~= "NoRide" ) then	

				TppRadio.DelayPlayEnqueue( "Radio_RideOffTruck", "short", "none", {	
					onEnd = function()

						if ( this.CounterList.PlayerOnCargo ~= "NoRide" ) then	

							TppRadio.DelayPlayEnqueue( "Radio_MissionBriefingSub1", "mid", "none",{	
								onStart = function()	TppMission.SetFlag( "isRadio_MissionBriefingSub1", true )	end,
								onEnd = function()
									if ( this.CounterList.PlayerOnCargo ~= "NoRide" ) then	

										TppRadio.DelayPlayEnqueue( "Radio_MissionBriefingSub1_1", "short", "none", {	
											onEnd = function()
												if ( this.CounterList.PlayerOnCargo ~= "NoRide" ) then	

													local MissionBriefing1_23 = { "Radio_MissionBriefingSub1_2", "Radio_MissionBriefingSub1_3" }
													TppRadio.DelayPlayEnqueue( MissionBriefing1_23, "short", "none",  {	
														onEnd = function()
															TppMission.SetFlag( "isRadio_MissionBriefingSub1_3", true )
															if ( this.CounterList.PlayerOnCargo ~= "NoRide" ) then	
																
																TppSoundDaemon.PostEvent( "Play_sfx_s_codec_NPC_end" )
																
																TppMission.SetFlag( "isRadio_SimpleObjectivePlay", true )
															else
																
																TppRadio.DelayPlayEnqueue( "Radio_SimpleObjective", "mid", "end" )
																TppMission.SetFlag( "isRadio_SimpleObjectivePlay", false )
															end
															TppMission.SetFlag( "OnPlay_MissionBriefingSub1", false )
														end
													} )
												else	
													TppRadio.DelayPlayEnqueue( "Radio_MissionBriefingSub1_3", "short", "none", {	
														onEnd = function()
															TppMission.SetFlag( "isRadio_MissionBriefingSub1_3", true )

															
															TppRadio.DelayPlayEnqueue( "Radio_SimpleObjective", "mid", "end" )
															TppMission.SetFlag( "isRadio_SimpleObjectivePlay", false )
															TppMission.SetFlag( "OnPlay_MissionBriefingSub1", false )
														end
													} )
												end
												TppTimer.Stop( "CheckTargetPhotoTimer" )
												
												TppTimer.Start( "CheckTargetPhotoTimer", GZCommon.Time_HintPhotoCheck )
											end
										} )
									else
										
										TppRadio.DelayPlayEnqueue( "Radio_SimpleObjective", "mid", "end" )
										TppMission.SetFlag( "isRadio_SimpleObjectivePlay", false )
										TppMission.SetFlag( "OnPlay_MissionBriefingSub1", false )
										TppTimer.Stop( "CheckTargetPhotoTimer" )
										
										TppTimer.Start( "CheckTargetPhotoTimer", GZCommon.Time_HintPhotoCheck )
									end
								end
							} )
						else
							
							TppSoundDaemon.PostEvent( "Play_sfx_s_codec_NPC_end" )
							TppMission.SetFlag( "OnPlay_MissionBriefingSub1", false )
							TppTimer.Stop( "CheckTargetPhotoTimer" )
							
							TppTimer.Start( "CheckTargetPhotoTimer", GZCommon.Time_HintPhotoCheck )
						end
					end
				} )
			else
				
				TppSoundDaemon.PostEvent( "Play_sfx_s_codec_NPC_end" )
				TppMission.SetFlag( "OnPlay_MissionBriefingSub1", false )
				TppTimer.Stop( "CheckTargetPhotoTimer" )
				
				TppTimer.Start( "CheckTargetPhotoTimer", GZCommon.Time_HintPhotoCheck )
			end

		end
	} )
end



this.commonCheckTargetPhotoTimer = function()





	
	local radioDaemon = RadioDaemon:GetInstance()

	
	if ( radioDaemon:IsPlayingRadio() == false ) then
		
		if ( TppMission.GetFlag("isPlayerCheckMbPhoto") == false and
			 TppMission.GetFlag("isBetrayerMarking") == false and
			 TppMission.GetFlag("isBetrayerContact") == false and
			 TppMission.GetFlag("isGetCassette_A") == false and
			 TppMission.GetFlag("isDropCassette_B") == false and
			 TppEnemy.GetPhase("gntn_cp") == "sneak" ) then

			
			TppRadio.Play( "Radio_CheckMbPhoto" )
			TppRadio.PlayEnqueue( "Radio_CheckMbPhotoTutorial" )
		end
	end

	TppTimer.Stop( "CheckTargetPhotoTimer" )
	
	TppTimer.Start( "CheckTargetPhotoTimer", GZCommon.Time_HintPhotoCheck )

end



this.IntelRadioPlayCameraTrap = function()





	
	if ( TppMission.GetFlag("isBetrayerContact") == true) then

		
		this.commonUpdateCheckCameraIntelRadio()

		TppMission.SetFlag( "isGetInfo_Suspicion2", true )
		this.commonBetrayerInterrogationSetUpdate()	

		TppMission.SetFlag("isCameraIntelRadioPlay", true )
	end

end



this.commonRadioGetCassetteB = function()




	local RadioName

	
	if ( TppMission.GetFlag( "isGetInfo_Mastermind" ) == true ) then
		
		
		RadioName = "Radio_GetCassette_B_Confidence"

	elseif ( TppMission.GetFlag( "isGetCassette_A" ) == false ) then
		
		
		RadioName = "Radio_GetCassette_B_NoHint"

	else
		
		
		RadioName = "Radio_GetCassette_B_WithA"

	end

	
	TppRadio.DelayPlayEnqueue( RadioName, "short", "begin", {
		onEnd = function()
			
			if ( TppMission.GetFlag( "isWarningMissionArea" ) == true ) then
				
				TppOutOfMissionRangeEffect.Disable( 1 )		
				GZCommon.OutsideAreaVoiceEnd()
				TppRadio.DelayPlay( "Radio_MissionArea_Clear", "short", "end" )
			else
				
				TppSoundDaemon.PostEvent( "Play_sfx_s_codec_NPC_end" )
			end
		end
	 })

end



this.commonWatchingBetrayer = function()






























end



this.commonHostageIntelCheck = function( CharacterID )



	local status = TppHostageUtility.GetStatus( CharacterID )
	if status == "Dead" then
		TppRadio.DisableIntelRadio( CharacterID )
	else
		TppRadio.EnableIntelRadio( CharacterID )
	end
end



this.commonHeliLeaveExtension = function()
	local timer = 55 

	
	GkEventTimerManager.Stop( "Timer_pleaseLeaveHeli" )
	GkEventTimerManager.Start( "Timer_pleaseLeaveHeli", timer )
end






this.commonWoodTurret03Break = function()




	
	TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0002" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_common_c01_route0002" )

end



this.commonWoodTurret04Break = function()



	
	

		
	if ( TppMission.GetFlag("isSignalExecuted") == false and
		 TppMission.GetFlag("isGetCassette_A") == false and
		 TppMission.GetFlag("isGetCassette_B") == false ) then
		
		TppRadio.DelayPlay( "Radio_SignalBroken", "mid" )
	end

	TppMission.SetFlag("isSignalTurretDestruction", true )

	
	TppRadio.DisableIntelRadio( "SL_WoodTurret04")

	
	TppMarker.Disable( "e20030_marker_Signal" )

	
	this.commonOptionalRadioUpdate()

	
	TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0009" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0025" )

end



this.commonUseSignalLight = function()




	
	if ( TppMission.GetFlag("isSignalExecuted") == false and
		 TppMission.GetFlag("isBetrayerContact") == false and
		 TppMission.GetFlag("isGetCassette_A") == false and
		 TppMission.GetFlag("isGetCassette_B") == false and
		 TppMission.GetFlag("isSignalTurretDestruction") == false ) then

		
		if ( TppEnemy.GetPhase("gntn_cp") ~= "alert" ) then

			
			this.CallSignalLightSE()

			
			this.commonCallAnnounceLog( this.AnnounceLogID_Signal )

			
			if ( TppMission.GetFlag( "isBetrayerMarking" ) == false ) then
				TppMission.SetFlag( "isNotMarkBeforeSignal", true )
			end

			
			if ( TppMission.GetFlag( "isPlayerCheckMbPhoto" ) == true or TppMission.GetFlag( "isBetrayerMarking" ) == true ) then
				TppRadio.DelayPlayEnqueue( "Radio_RunSignal", "mid" )
			else
				local RunSignal = { "Radio_RunSignal", "Radio_CheckMbPhoto"}
				TppRadio.DelayPlayEnqueue( RunSignal, "mid" )

				
				TppTimer.Stop( "CheckTargetPhotoTimer" )
				TppTimer.Start( "CheckTargetPhotoTimer", GZCommon.Time_HintPhotoCheck )

			end

			
			TppMarker.Disable( "e20030_marker_Signal" )

			
			TppRadio.DisableIntelRadio( "SL_WoodTurret04")

			
			TppMission.SetFlag( "isSignalExecuted", true )

			
			this.ChangeSignalCheckRoute( "Normal" )

			
			this.commonOptionalRadioUpdate()

			TppMissionManager.SaveGame("10")	

		else



			
			TppRadio.DelayPlay( "Radio_ContactNot_Phase", "short" )

		end

	
	elseif ( TppMission.GetFlag( "isGetCassette_A" ) == true or
			 TppMission.GetFlag( "isGetCassette_B" ) == true ) then

		TppRadio.DelayPlayEnqueue( "Radio_EscapeWay", "mid" )	

	
	elseif ( TppMission.GetFlag( "isBetrayerContact" ) == true ) then

		TppRadio.DelayPlayEnqueue( "Radio_RecommendGetCassette_A", "mid" )	
	end

end



this.commonStopWalkMan = function()

	local CassetteId = TppData.GetArgument(1)





	
	if ( CassetteId == this.CassetteA ) then

		
		TppRadio.Play( "Radio_PlayedCassette_A" )

	elseif ( CassetteId == this.CassetteB ) then

		
		TppRadio.Play( "Radio_PlayedCassette_B" )

	end
end



this.commonFocusMapIcon = function()

	local Id_32Bit = TppEventSequenceManagerCollector.GetMessageArg( 0 )
	local sequence = TppSequence.GetCurrentSequence()





	
	if StringId.IsEqual32( Id_32Bit, "e20030_marker_Signal" ) then
		if ( TppMission.GetFlag( "isSignalTurretDestruction" ) == false and TppMission.GetFlag( "listeningInfoFromBetrayer" ) == false ) then



			TppRadio.Play( "Radio_Map_Signal" )
		end

	
	elseif StringId.IsEqual32( Id_32Bit, this.BetrayerID ) then
		if ( sequence == "Seq_Waiting_BetrayerContact" and TppMission.GetFlag( "isBetrayerMarking") ) then
			TppRadio.Play( "Radio_AboutContact" )
		end
	
	elseif StringId.IsEqual32( Id_32Bit, "e20030_marker_Cassette" ) then

		TppRadio.Play( "Radio_FocusCassette_A" )
	
	elseif StringId.IsEqual32( Id_32Bit, "TppMarkerLocator_EscapeWest" ) or
		   StringId.IsEqual32( Id_32Bit, "TppMarkerLocator_EscapeNorth" ) then

		TppRadio.Play( "Radio_LandEscape" )
	end

end




this.MbDvcActCallRescueHeli = function(characterId, type)
	local radioDaemon = RadioDaemon:GetInstance()
	local emergency = TppData.GetArgument(2)















	local VehicleId = TppPlayerUtility.GetRidingVehicleCharacterId()
	local charaObj = Ch.FindCharacterObjectByCharacterId("SupportHelicopter")
	local plgHeli = charaObj:GetCharacter():FindPlugin("TppSupportHelicopterPlugin")

	if( VehicleId == "SupportHelicopter" ) then
	else
		if ( type == "MbDvc" ) then










			if ( radioDaemon:IsPlayingRadio() == false ) then
				
				if(TppSupportHelicopterService.IsDueToGoToLandingZone(characterId)) then
				
					if(emergency == 2) then
						TppRadio.DelayPlay( "Miller_CallHeliHot02", "long" )
					else
						TppRadio.DelayPlay( "Miller_CallHeli02", "long" )
					end
				else
				
					if plgHeli:GetAiStatus() ~= "AI_STATUS_RETURN" then
					
						if(emergency == 2) then
							TppRadio.DelayPlay( "Miller_CallHeliHot01", "long" )
						else
							TppRadio.DelayPlay( "Miller_CallHeli01", "long" )
						end
					end
				end
			end
		elseif ( type == "flare" ) then










			if ( emergency == false ) then
				
				if ( radioDaemon:IsPlayingRadio() == false ) then
					TppRadio.DelayPlay( "Miller_HeliNoCall", "long" )
				end
			else
				
				if ( radioDaemon:IsPlayingRadio() == false ) then
					
					if(TppSupportHelicopterService.IsDueToGoToLandingZone(characterId)) then
					
						if(emergency == 2) then
							TppRadio.DelayPlay( "Miller_CallHeliHot02", "long" )
						else
							TppRadio.DelayPlay( "Miller_CallHeli02", "long" )
						end
					else
					
						if plgHeli:GetAiStatus() ~= "AI_STATUS_RETURN" then
						
							if(emergency == 2) then
								TppRadio.DelayPlay( "Miller_CallHeliHot01", "long" )
							else
								TppRadio.DelayPlay( "Miller_CallHeli01", "long" )
							end
						end
					end
				end
			end
		else
			if ( radioDaemon:IsPlayingRadio() == false ) then
				
				if(TppSupportHelicopterService.IsDueToGoToLandingZone(characterId)) then
				
					TppRadio.DelayPlay( "Miller_CallHeli02", "long" )
				else
				
					TppRadio.DelayPlay( "Miller_CallHeli01", "long" )
				end
			end
		end
	end
end




this.commonSecurityCameraDead = function()




	

	
	TppMission.SetFlag( "isCameraBroken", true )

	
	if (TppMission.GetFlag("isGetInfo_Suspicion2") == true and
		TppMission.GetFlag("isBetrayerContact") == true) then

		
		this.CounterList.CameraBrokenRadio = "Radio_BrokeCamera_Confidence"		

	elseif (TppMission.GetFlag("isGetInfo_Suspicion2") == false and
			TppMission.GetFlag("isBetrayerContact") == false) then

		
		this.CounterList.CameraBrokenRadio = "Radio_BrokeCamera_Accident"		

	elseif (TppMission.GetFlag("isGetInfo_Suspicion2") == false and
			TppMission.GetFlag("isBetrayerContact") == true ) then

		this.CounterList.CameraBrokenRadio = "Radio_BrokeCamera_NoHint"		

	else
		
	end

	
	if ( TppMission.GetFlag("isBetrayerContact") == true ) then
		TppMission.SetFlag( "isGetInfo_Suspicion2", true )
		this.commonBetrayerInterrogationSetUpdate()	
		
		this.commonUpdateCheckCameraIntelRadio()
	end

	
	local routeId = TppEnemyUtility.GetRouteId( this.BetrayerID )
	if ( routeId == GsRoute.GetRouteId("gntn_e20030_tgt_route0003") ) then
		
		this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic02", "gntn_e20030_tgt_route0000", 16 )
		this.commonBetrayerRouteWareHouse()
	end

	
	this.commonOptionalRadioUpdate()

	
	this.commonUpdateCheckCameraIntelRadio()

end



this.commonSecurityCameraAlert = function()




	
	

	
	if ( TppEnemy.GetPhase( "gntn_cp" ) ~= "alert" and
		 TppMission.GetFlag("isCameraAlert") == false and
		 TppMission.GetFlag("isCameraIntelRadioPlay") == false ) then
		
		if ( TppMission.GetFlag("isGetInfo_Suspicion2") == true and
			 TppMission.GetFlag("isBetrayerContact") == true ) then

			
			TppRadio.Play( "Radio_CameraTrap_Confidence" )	

		elseif ( TppMission.GetFlag("isGetInfo_Suspicion2") == false and
			 TppMission.GetFlag("isBetrayerContact") == false ) then

			
			TppRadio.Play( "Radio_CameraTrap_NoContact" )		

		elseif ( TppMission.GetFlag("isGetInfo_Suspicion2") == false and
			 TppMission.GetFlag("isBetrayerContact") == true ) then

			
			TppRadio.Play( "Radio_CameraTrap_Normal" )		

		else
			
		end
	end

	
	TppMission.SetFlag( "isCameraAlert", true )

	
	this.commonStartForceSerching()

	
	if ( TppMission.GetFlag("isBetrayerContact") == true ) then
		TppMission.SetFlag( "isGetInfo_Suspicion2", true )
	end

	this.commonBetrayerInterrogationSetUpdate()	

	
	local routeId = TppEnemyUtility.GetRouteId( this.BetrayerID )
	if ( routeId == GsRoute.GetRouteId("gntn_e20030_tgt_route0003") ) then
		
		this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic02", "gntn_e20030_tgt_route0000", 16 )
		this.commonBetrayerRouteWareHouse()
	end

	
	this.commonOptionalRadioUpdate()

	
	this.commonUpdateCheckCameraIntelRadio()
end



this.commonPlayerPickItem = function()





	local ItemID			= TppData.GetArgument(1)
	local Index				= TppData.GetArgument(2)

	
	if ( ItemID == "IT_Cassette" ) then
		if ( Index == 14 ) then
			this.CommonGetCassette_A()
		elseif ( Index == 15 ) then
			this.CommonGetCassette_B()
		else



		end
	end

end



this.commonMarkerEnable = function()





	

	local MarkerID			= TppData.GetArgument(1)

	
	if ( MarkerID == "Cargo_Truck_WEST_001" ) then
		TppMission.SetFlag("isMarkingTruck001", true )
	
	elseif ( MarkerID == "Cargo_Truck_WEST_002" ) then
		TppMission.SetFlag("isMarkingTruck002", true )
	
	elseif ( MarkerID == "e20030_Driver" ) then
		TppMission.SetFlag("isMarkingDriver001", true )
	
	elseif ( MarkerID == "e20030_enemy022" ) then
		TppMission.SetFlag("isMarkingDriver002", true )
	
	elseif ( MarkerID == "IT_Cassette" ) then
		
		TppMarker.Enable( "IT_Cassette", 0, "moving", "all", 0, true, true )	
		TppMarkerSystem.EnableMarker{ markerId = "IT_Cassette", viewType = { "VIEW_MAP_ICON", "VIEW_WORLD_GOAL" } }
	end
end



this.commonSuppressorIsBroken = function()
	local VehicleId = TppPlayerUtility.GetRidingVehicleCharacterId()

	if( VehicleId == "SupportHelicopter" ) then
	else
		TppRadio.DelayPlayEnqueue( "Miller_BreakSuppressor", "short" )
	end
end



this.After_SwitchOff = function()

	
	TppDataUtility.SetEnableDataFromIdentifier( "gntn_Trap", "SwitchLightArea", true , false )
	
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20030_SecurityCamera_04" , false )
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20030_SecurityCamera" , false )

	

end



this.SwitchLight_ON = function()


		
		TppDataUtility.SetEnableDataFromIdentifier( "gntn_Trap", "SwitchLightArea", false , false )
		
		TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20030_SecurityCamera_04" , true )
		TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20030_SecurityCamera" , true )

		

end


this.SwitchLight_OFF = function()

	local phase = TppEnemy.GetPhase( this.cpID )

	
	if( TppMission.GetFlag( "isSwitchLightDemo" ) == false ) and
		( phase == "sneak" or phase == "caution" or phase == "evasion" ) then

		local onDemoStart = function()
			
			local radioDaemon = RadioDaemon:GetInstance()
			radioDaemon:StopDirect()
			
			SubtitlesCommand.StopAll()
			
			
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20030_SecurityCamera", false )
			
			TppDataUtility.CreateEffectFromGroupId( "wtrdrpbil" )
			TppDataUtility.CreateEffectFromGroupId( "dstcomviw" )
		end
		local onDemoSkip = function()
			
			TppGadgetUtility.SetSwitch("gntn_center_SwitchLight",false)
		end
		local onDemoEnd = function()
			
			TppMission.SetFlag( "isSwitchLightDemo", true )
			
			this.After_SwitchOff()
			
			TppDataUtility.DestroyEffectFromGroupId( "wtrdrpbil" )
			TppDataUtility.DestroyEffectFromGroupId( "dstcomviw" )
		end
		TppDemo.Play( "SwitchLightDemo" , { onStart = onDemoStart, onSkip = onDemoSkip ,onEnd = onDemoEnd } , {
			disableGame			= false,	
			disableDamageFilter		= false,	
			disableDemoEnemies		= false,	
			disableEnemyReaction	= true,		
			disableHelicopter		= false,	
			disablePlacement		= false, 	
			disableThrowing		= false	 	
		})
	
	else
		
		this.After_SwitchOff()
	end
end



this.CallSignalLightSE = function()

	
	TppTimer.Start( "Timer_SignalLightON_01", 0.1 )
	TppTimer.Start( "Timer_SignalLightOFF_01", 0.3 )

	TppTimer.Start( "Timer_SignalLightON_02", 0.4 )
	TppTimer.Start( "Timer_SignalLightOFF_02", 0.6 )

	TppTimer.Start( "Timer_SignalLightON_03", 0.7 )
	TppTimer.Start( "Timer_SignalLightOFF_03", 0.9 )

	TppTimer.Start( "Timer_SignalLightON_04", 1.0 )
	TppTimer.Start( "Timer_SignalLightOFF_04", 1.4 )

	


end

this.CallSignalLightSE_ON = function()
	local characterObject = Ch.FindCharacterObjectByCharacterId( "SL_WoodTurret04" )
	local pos = characterObject:GetPosition()
	TppSoundDaemon.PostEvent3D( "sfx_s_searchlight_noise_on", pos )
end
this.CallSignalLightSE_OFF = function()
	local characterObject = Ch.FindCharacterObjectByCharacterId( "SL_WoodTurret04" )
	local pos = characterObject:GetPosition()
	TppSoundDaemon.PostEvent3D( "sfx_s_searchlight_noise_off", pos )
end






this.commonOutsideMissionWarningAreaEnter = function()




	
	if ( TppMission.GetFlag("isPlayerEnterMissionArea") == true ) then
		
		if( TppMission.GetFlag( "isGetCassette_A" ) == true or TppMission.GetFlag( "isGetCassette_B" ) == true ) then
			TppRadio.Play( "Radio_MissionArea_Clear" )	
			
			GZCommon.isOutOfMissionEffectEnable = false
		else
			TppRadio.Play( "Radio_MissionArea_Warning" )	
			
		end
		TppMission.SetFlag("isWarningMissionArea", true )
	end
end

this.commonOutsideMissionWarningAreaExit = function()



	TppMission.SetFlag("isWarningMissionArea", false )
end



local OutsideAreaUniqueCharaCheck = function( charaId )





	local pos		= TppPlayerUtility.GetLocalPlayerCharacter():GetPosition()	
	local size		= Vector3( 20, 12, 20 )										
	local rot		= Quat( 0.0 , 0.50, 0.0, 0.50 )								
	local npcIds	= TppNpcUtility.GetNpcByBoxShape( pos, size, rot )

	
	local charaObj = Ch.FindCharacterObjectByCharacterId( charaId )
	if Entity.IsNull( charaObj ) then



		return false
	end
	local chara = charaObj:GetCharacter()
	local uniqueId = chara:GetUniqueId()

	
	if( npcIds and #npcIds.array > 0 ) then
		for i,id in ipairs(npcIds.array) do



			
			if ( id == uniqueId ) then
				
				local life = TppEnemyUtility.GetLifeStatus( id )



				if ( life ~= "Dead" ) then
					
					local status = TppEnemyUtility.GetStatus( id )



					if( status == "RideVehicle" or status == "Carried" ) then
						return true		
					else
						return false
					end
				end
			end
		end
	end



	return false

end



this.OutsideAreaRecoveryCharaCheck = function()





	local pos		= TppPlayerUtility.GetLocalPlayerCharacter():GetPosition()	
	local size		= Vector3( 20, 12, 20 )										
	local rot		= Quat( 0.0 , 0.50, 0.0, 0.50 )								
	local npcIds	= TppNpcUtility.GetNpcByBoxShape( pos, size, rot )
	local npctype


	local CharacterID

	
	if( npcIds and #npcIds.array > 0 ) then
		
		for i,id in ipairs(npcIds.array) do



			npctype = TppNpcUtility.GetNpcType( id )



			
			if( npctype == "Enemy" ) then
				
				CharacterID = TppCharacterUtility.GetCharacterIdFromUniqueId( id )

				
				if ( CharacterID == this.BetrayerID ) then
					
					local life = TppEnemyUtility.GetLifeStatus( id )



					if ( life ~= "Dead" ) then
						
						local status = TppEnemyUtility.GetStatus( id )



						if( status == "RideVehicle" or status == "Carried" ) then
							
							
							this.commonCallAnnounceLog( this.AnnounceLogID_RecoveryBetrayer )
							
							PlayRecord.RegistPlayRecord( "SOLDIER_RESCUE", this.BetrayerID )
						else
							



						end
					end
				elseif ( CharacterID == this.MastermindID ) then
					
					local life = TppEnemyUtility.GetLifeStatus( id )



					if ( life ~= "Dead" ) then
						
						local status = TppEnemyUtility.GetStatus( id )



						if( status == "RideVehicle" or status == "Carried" ) then
							
							
							this.commonCallAnnounceLog( this.AnnounceLogID_RecoveryMastermind )
							
							PlayRecord.RegistPlayRecord( "SOLDIER_RESCUE", this.MastermindID )
						else
							



						end
					end
				else
					
					local life = TppEnemyUtility.GetLifeStatus( id )



					if ( life ~= "Dead" ) then
						
						local status = TppEnemyUtility.GetStatus( id )



						if( ( status == "RideVehicle" or status == "Carried" ) and
							( this.CounterList.PlayerOnCargo == "NoRide" ) ) then	
							
							
							this.commonCallAnnounceLog( "announce_collection_enemy" )
							
							PlayRecord.RegistPlayRecord( "SOLDIER_RESCUE" )
						else
							



						end
					end
				end
			
			elseif( npctype == "Hostage" ) then
				
				local life = TppHostageUtility.GetStatus( id )



				if ( life ~= "Dead" ) then
					
					local status = TppHostageUtility.GetStatus( id )



					if( status == "RideOnVehicle" or status == "Carried" ) then
						
						CharacterID = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
						
						GZCommon.NormalHostageRecovery( CharacterID )
					else
						



					end
				end
			end
		end
	end
end



this.commonOutsideMissionArea = function()




	
	
	if ( TppMission.GetFlag("isWarningMissionArea") == true ) then

		
		
		if( TppMission.GetFlag( "isGetCassette_A" ) == true or TppMission.GetFlag( "isGetCassette_B" ) == true ) then

			
			this.OutsideAreaRecoveryCharaCheck()

			this.commonMissionClearRequest( "EscapeArea_Clear" )

		
		elseif( TppMission.GetFlag( "isGetCassette_A" ) == false and TppMission.GetFlag( "isGetCassette_B" ) == false ) then

				TppMission.ChangeState( "failed", "OutsideMissionArea" )

		else
			



		end

	else
		



	end
end



this.commonPlayerEnterMissionArea = function()




	if ( TppMission.GetFlag("isPlayerEnterMissionArea") == false ) then
		
		TppMission.SetFlag("isPlayerEnterMissionArea", true )

		
		GZCommon.isOutOfMissionEffectEnable = true

	end
end



this.commonPlayerAreacampEast = function()



	this.CounterList.PlayerArea = "Area_campEast"

	

	
	this.commonUpdateGuardTarget()
end


this.commonPlayerAreacampWest = function()



	this.CounterList.PlayerArea = "Area_campWest"

	

	
	this.commonUpdateGuardTarget()
end


this.commonPlayerAreaControlTower = function()



	this.CounterList.PlayerArea = "Area_ControlTower"

	

	
	this.commonUpdateGuardTarget()
end



this.commonBetrayerRoutecampEast = function()




	
	TppMission.SetFlag( "BetrayerArea", this.Area_campEast )

end


this.commonBetrayerRoutecampWest = function()




	
	TppMission.SetFlag( "BetrayerArea", this.Area_campWest )

end


this.commonBetrayerRouteHeliport = function()




	
	TppMission.SetFlag( "BetrayerArea", this.Area_Heliport )

end


this.commonBetrayerRouteWareHouse = function()




	TppMission.SetFlag( "BetrayerArea", this.Area_WareHouse )

end




this.commonPlayerRideOnCargo = function()

	local Type = TppData.GetArgument(2)

	if ( Type == "Truck" ) then
		
		this.CounterList.PlayerOnCargo = TppData.GetArgument(1)



	end
end


this.commonPlayerGetOffCargo = function()

	this.CounterList.PlayerOnCargo = "NoRide"




	
	if ( TppSequence.GetCurrentSequence() == "Seq_Waiting_BetrayerContact" and
		 TppMission.GetFlag( "isRadio_SimpleObjectivePlay" ) == true ) then

		TppRadio.DelayPlay( "Radio_SimpleObjective", "long", "both" )
		TppMission.SetFlag( "isRadio_SimpleObjectivePlay", false )
	end
end


this.commonPlayerRideOnVehicle = function()
	local VehicleID = TppData.GetArgument(2)
	local hudCommonData = HudCommonDataManager.GetInstance()
	
	if VehicleID == "WheeledArmoredVehicleMachineGun" then
		if( TppMission.GetFlag( "isAVMTutorial" ) == false ) then
			
			hudCommonData:CallButtonGuide( "tutorial_pause", "UI_SELECT" )
			hudCommonData:CallButtonGuide( "tutorial_apc", fox.PAD_Y )
			TppMission.SetFlag( "isAVMTutorial", true )
		else
			hudCommonData:CallButtonGuide( "tutorial_vehicle_attack", "VEHICLE_FIRE" )
		end
	elseif VehicleID == "SupportHelicopter" then
		
	else

			
			hudCommonData:CallButtonGuide( "tutorial_accelarater", "VEHICLE_TRIGGER_ACCEL" )
			
			hudCommonData:CallButtonGuide( "tutorial_brake", "VEHICLE_TRIGGER_BREAK" )

			TppMission.SetFlag( "isCarTutorial", true )							

	end
end



this.commonSequenceSaveIndefinite = function()

	
	if ( GZCommon.PlayerAreaName == "WareHouse" ) then
		TppMissionManager.SaveGame("20")
	elseif ( GZCommon.PlayerAreaName == "Asylum" ) then
		TppMissionManager.SaveGame("21")
	elseif ( GZCommon.PlayerAreaName == "EastCamp" ) then
		TppMissionManager.SaveGame("22")
	elseif ( GZCommon.PlayerAreaName == "WestCamp" ) then
		TppMissionManager.SaveGame("23")
	elseif ( GZCommon.PlayerAreaName == "Heliport" ) then
		TppMissionManager.SaveGame("24")
	elseif ( GZCommon.PlayerAreaName == "ControlTower_East" ) then
		TppMissionManager.SaveGame("25")
	elseif ( GZCommon.PlayerAreaName == "ControlTower_West" ) then
		TppMissionManager.SaveGame("26")
	elseif ( GZCommon.PlayerAreaName == "SeaSide" ) then
		TppMissionManager.SaveGame("27")
	else



		TppMissionManager.SaveGame("20")	
	end

end





this.commonBetrayerRouteDisable = function()

	
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_tgt_route0000" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_tgt_route0001" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_tgt_route0002" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_tgt_route0003" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_tgt_route9001" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_tgt_route9002" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_tgt_route9003" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_tgt_route9900" )

end



this.commonAssistantrRouteDisable = function()

	
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_ast_route0000" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_ast_route0001" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_ast_route9001" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_ast_route9002" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_ast_route9003" )
	TppEnemy.DisableRoute( "gntn_cp", "gntn_e20030_ast_route9900" )

end



this.ChangeBetrayerRoute = function( routeSet, routeID, nodeNum)




	
	this.commonBetrayerRouteDisable()
	
	TppEnemy.EnableRoute( "gntn_cp", routeID )
	
	TppEnemy.ChangeRoute( "gntn_cp", this.BetrayerID,	routeSet, routeID, nodeNum )
end



this.ChangeAssistantRoute = function( routeSet, routeID, nodeNum)




	
	this.commonAssistantrRouteDisable()
	
	TppEnemy.EnableRoute( "gntn_cp", routeID )
	
	TppEnemy.ChangeRoute( "gntn_cp", this.AssistantID,	routeSet, routeID, nodeNum )
end




this.commonBetrayerRoutePoint = function()



	local RouteName				= TppData.GetArgument(3)
	local RoutePointNumber			= TppData.GetArgument(1)

	
	if( RouteName == GsRoute.GetRouteId("gntn_e20030_tgt_route0000")  ) then
		if( ( RoutePointNumber >= 17 ) and ( this.CounterList.PlayerArea == "Area_ControlTower" )) then




			
			this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_tgt_route0002", 0 )
			this.commonBetrayerRouteHeliport()

		elseif ( ( RoutePointNumber >= 19 ) and ( this.CounterList.PlayerArea == "Area_campEast")) then




			
			this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_tgt_route0001", 0 )
			this.commonBetrayerRoutecampEast()

		end
	
	elseif( RouteName == GsRoute.GetRouteId("gntn_e20030_tgt_route0001")  ) then
		if( ( (RoutePointNumber == 3) or (RoutePointNumber == 8) or (RoutePointNumber == 14) ) and
			  ( this.CounterList.PlayerArea == "Area_ControlTower")) then




			
			this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_tgt_route0002", 0 )
			this.commonBetrayerRouteHeliport()

		elseif ( ( (RoutePointNumber == 3) or (RoutePointNumber == 8) or (RoutePointNumber == 14) ) and
			  ( this.CounterList.PlayerArea == "Area_campWest")) then




			
			this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_tgt_route0000", 0 )
			this.commonBetrayerRouteWareHouse()

		end
	
	elseif( RouteName == GsRoute.GetRouteId("gntn_e20030_tgt_route0002")  ) then
		if(( (RoutePointNumber == 7) or (RoutePointNumber == 8) or (RoutePointNumber == 14) or (RoutePointNumber == 15) ) and
			  ( this.CounterList.PlayerArea == "Area_campEast")) then




			
			this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_tgt_route0001", 0 )
			this.commonBetrayerRoutecampEast()

		elseif(( (RoutePointNumber == 7) or (RoutePointNumber == 8) or (RoutePointNumber == 14) or (RoutePointNumber == 15) ) and
			  ( this.CounterList.PlayerArea == "Area_campWest")) then




			
			this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_tgt_route0000", 0 )
			this.commonBetrayerRouteWareHouse()

		end
	
	elseif( RouteName == ( GsRoute.GetRouteId("gntn_e20030_tgt_route9900")) ) then

		if( RoutePointNumber == 0 ) then
			TppMission.SetFlag( "isBetrayerSignalCheckWait", true )	
		
		elseif ( TppMission.GetFlag( "isAssistantSignalCheckWait" ) == true or this.commonCheckAssistantStatus() == false ) then





			
			if ( this.commonCheckAssistantStatus() ) then
				TppMission.SetFlag( "isBetrayerTogether", true )
			end

			this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_tgt_route9001", 0 )
			this.ChangeAssistantRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_ast_route9001", 0 )

			this.commonBetrayerRoutecampWest()

		end
	
	elseif( RouteName == ( GsRoute.GetRouteId("gntn_e20030_ast_route9900")) ) then
		if( RoutePointNumber == 0 ) then
			TppMission.SetFlag( "isAssistantSignalCheckWait", true )	
		elseif ( TppMission.GetFlag( "isBetrayerSignalCheckWait" ) == true ) then




			
			TppMission.SetFlag( "isBetrayerTogether", true )

			this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_tgt_route9001", 0 )
			this.ChangeAssistantRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_ast_route9001", 0 )

		end
	
	elseif( RouteName == ( GsRoute.GetRouteId("gntn_e20030_tgt_route9001")) ) then
		if( RoutePointNumber == 4 ) then
			
			if( TppMission.GetFlag( "isPlayerInWestCamp" ) == true ) then
				
				if( TppMission.GetFlag( "isBetrayerMarking" ) == true ) then
					
					if ( TppMission.GetFlag( "isNotMarkBeforeSignal" ) == false ) then



						
						if ( this.commonCheckAssistantStatus() == true ) then
							local Play_AppearedAssistant = { "Radio_AppearedBetrayer", "Radio_AppearedAssistant" }
							TppRadio.Play( Play_AppearedAssistant )

						else
							TppRadio.Play( "Radio_AppearedBetrayer" )
						end
					end
				else
					
					TppRadio.Play( "Radio_IsThatBetrayer" )	
				end
			end
		elseif ( RoutePointNumber == 15 ) then




			
			TppCommandPostObject.GsSetConversationEnableFlag( "gntn_cp", "CTE0030_0010" , true )

			
			this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_tgt_route9002", 0 )
			this.commonBetrayerRoutecampWest()

			
			this.ChangeAssistantRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_ast_route9002", 0 )

		end
	
	elseif( RouteName == ( GsRoute.GetRouteId("gntn_e20030_ast_route9001")) ) then
		if( RoutePointNumber == 15 ) then
			
			this.ChangeAssistantRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_ast_route9002", 0 )

		end
	
	elseif( RouteName == ( GsRoute.GetRouteId("gntn_e20030_tgt_route9002")) ) then
		if( RoutePointNumber == 1 ) then




			
			this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_tgt_route9003", 0 )
			this.ChangeAssistantRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_ast_route9003", 0 )
			this.commonBetrayerRoutecampWest()
		end
	
	elseif( RouteName == ( GsRoute.GetRouteId("gntn_e20030_ast_route9002")) ) then



		
		local routeId = TppEnemyUtility.GetRouteId( this.BetrayerID )
		
		if( RoutePointNumber == 1 and
			routeId ~= GsRoute.GetRouteId("gntn_e20030_tgt_route9002") ) then



			
			this.ChangeAssistantRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_ast_route9003", 0 )
		end
	
	elseif( RouteName == ( GsRoute.GetRouteId("gntn_e20030_tgt_route9003")) ) then
		if( RoutePointNumber == 0 ) then
			
			this.ChangeAssistantRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_ast_route9003", 0 )

		elseif( RoutePointNumber == 18 ) then
			
			this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_tgt_route0000", 11 )
			this.commonBetrayerRouteWareHouse()
			
			TppMission.SetFlag( "isSignalCheckEventEnd", true )

		end
	
	elseif( RouteName == ( GsRoute.GetRouteId("gntn_e20030_ast_route9003")) ) then

		if( RoutePointNumber == 10 ) then

			
			TppMission.SetFlag( "isBetrayerTogether", false )

			
			local enemyNum = TppEnemyUtility.GetNumberOfActiveSoldierByCharacterId( this.BetrayerID, this.Size_ActiveEnemy )
			
			if( TppMission.GetFlag( "isBetrayerMarking" ) == true and enemyNum <= 1) then
				
				if( TppMission.GetFlag( "isPlayerInWestCamp" ) == true ) then
					
					local radioGroup = {"Radio_DisablementAssistant", "Radio_MarkingBetrayer2" }
					TppRadio.Play( "Radio_DisablementAssistant" )
				end
			end

		elseif(  RoutePointNumber == 17 ) then




			
			this.ChangeAssistantRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_ast_route0000", 60 )
			
			TppCommandPostObject.GsSetRealizeFirstPriority( "gntn_cp", this.AssistantID, false )

		end
	
	elseif( RouteName == ( GsRoute.GetRouteId("gntn_e20030_tgt_route0003")) ) then
		




			this.commonBetrayerRouteWareHouse()	

			
			if ( TppMission.GetFlag( "isMastermindConversationEnd" ) == true or
				 TppMission.GetFlag( "isCameraAlert" ) == true or
				 TppMission.GetFlag( "isCameraBroken" ) == true or
				 TppMission.GetFlag( "isGetCassette_B" ) == true or
				 TppMission.GetFlag( "isGetInfo_Mastermind" ) == true ) then



				
				this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic02", "gntn_e20030_tgt_route0000", 16 )
				this.commonBetrayerRouteWareHouse()
			end
		
	else
		
		
	end
end



this.commonDemoSoldierRoutePoint = function()



	local RouteName				= TppData.GetArgument(2)
	local RoutePointNumber		= TppData.GetArgument(3)

	
	if( RouteName == GsRoute.GetRouteId("gntn_e20030_add_route0002") or RouteName == GsRoute.GetRouteId("gntn_e20030_add_route0003") ) then
		if( RoutePointNumber >= 14 ) then




			
			TppCommandPostObject.GsSetExclusionRoutes( "gntn_cp", "gntn_common_d01_route0010", "gntn_e20030_add_route0002" )
			TppCommandPostObject.GsSetExclusionRoutes( "gntn_cp", "gntn_common_d01_route0011", "gntn_e20030_add_route0003" )

		end
	else

	end
end



this.commonDriverRoutePoint = function()



	local RouteName				= TppData.GetArgument(2)
	local RoutePointNumber		= TppData.GetArgument(3)

	
	if( RouteName == GsRoute.GetRouteId( "gntn_common_d01_route0028" ) ) then



		if( RoutePointNumber >= 2 and RoutePointNumber <= 9 ) then



			
			if ( TppMission.GetFlag( "isGetCassette_A" ) == true or TppMission.GetFlag( "isGetCassette_B" ) == true ) and
			   ( this.CounterList.PlayerOnCargo == "Cargo_Truck_WEST_001" ) then




				
				TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0028" )		
				TppEnemy.EnableRoute( "gntn_cp", "gntn_common_d01_route0128" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "e20030_routeSet_d01_basic01", "gntn_common_d01_route0128", 0, "e20030_Driver" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "e20030_routeSet_d01_basic02", "gntn_common_d01_route0128", 0, "e20030_Driver" )
			end
		end

	elseif( RouteName == GsRoute.GetRouteId( "gntn_common_d01_route0128" ) ) then



		if( RoutePointNumber > 1 ) then




				
				TppEnemy.EnableRoute( "gntn_cp", "gntn_common_d01_route0028" )
				TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0128" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "e20030_routeSet_d01_basic01", "gntn_common_d01_route0028", 10, "e20030_Driver" )
				TppCommandPostObject.GsSetPriorityEnemyForRoute( "gntn_cp", "e20030_routeSet_d01_basic02", "gntn_common_d01_route0028", 10, "e20030_Driver" )

		end
	end

end




this.ChangeSignalCheckRoute = function( flag )




	local Flag = flag or "Normal"

	
	TppCommandPostObject.GsSetRealizeFirstPriority( "gntn_cp", this.AssistantID, true )

	if ( flag == "Normal" ) then
		
		this.commonBetrayerRouteDisable()
		this.commonAssistantrRouteDisable()
		TppEnemy.EnableRoute( "gntn_cp", "gntn_e20030_tgt_route9900" )
		TppEnemy.EnableRoute( "gntn_cp", "gntn_e20030_ast_route9900" )

		
		TppEnemy.ChangeRoute( "gntn_cp", this.BetrayerID,	"e20030_routeSet_d01_basic01", "gntn_e20030_tgt_route9900", 0 )
		TppEnemy.ChangeRoute( "gntn_cp", this.AssistantID,	"e20030_routeSet_d01_basic01", "gntn_e20030_ast_route9900", 0 )

	elseif (flag == "Continue" ) then

		
		TppMission.SetFlag( "isBetrayerTogether", true )

		this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_tgt_route9001", 0 )
		this.ChangeAssistantRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_ast_route9001", 0 )

	end
end



this.commonVehicleRouteUpdate = function()

	local vehicleGroupInfo	= TppData.GetArgument(2)

	local vehicleInfoName	= vehicleGroupInfo.routeInfoName			
	local vehicleCharaID	= vehicleGroupInfo.vehicleCharacterId		
	local routeID			= vehicleGroupInfo.vehicleRouteId			
	local routeNodeIndex	= vehicleGroupInfo.passedNodeIndex			
	local memberCharaIDs	= vehicleGroupInfo.memberCharacterIds		

	local driverCharaID		= memberCharaIDs[1]





	
	if( (vehicleInfoName == "VehicleRouteInfo_common_v01_0000") or (vehicleInfoName == "VehicleDefaultRideRouteInfo_e20030")) then
		
		if ( routeID == GsRoute.GetRouteId( "gntn_common_v01_route0010" ) ) then
			if ( routeNodeIndex == 0 ) then
				
				this.CounterList.WestTruckStatus = -1
			elseif ( routeNodeIndex == 1 ) then
				
				if ( TppMission.GetFlag("isMarkingTruck001") == true ) then
					TppMarker.Enable( "Cargo_Truck_WEST_001", 0, "none", "map_and_world_only_icon", 0, false, false )
				elseif ( TppMission.GetFlag("isMarkingDriver001") == true ) then
					TppMarkerSystem.EnableMarker{ markerId = "e20030_Driver", viewType = { "VIEW_MAP_ICON", "VIEW_WORLD_ICON" } }
				end
			elseif ( routeNodeIndex == 3 ) then
				
				this.CounterList.WestTruckStatus = 0
			end
		
		elseif ( routeID == GsRoute.GetRouteId( "gntn_common_v01_route0011" ) ) then

			if ( routeNodeIndex == 1 ) then
				
				
			end
		end
	
	elseif( vehicleInfoName == "VehicleRouteInfo_common_v01_0001" ) then
		
		if( routeID == GsRoute.GetRouteId( "gntn_common_v01_route0020" ) ) then
			if ( routeNodeIndex == 2 ) then
				
				GZCommon.Common_CenterBigGate_Close()
			elseif ( routeNodeIndex == 11 and  TppMission.GetFlag("isInspectionActive") == true ) then
				
				TppCommandPostObject.GsSetGroupVehicleRoute( "gntn_cp", "Cargo_Truck_WEST_001", "gntn_common_v01_route0025", 12 )
			elseif ( routeNodeIndex == 12 and  TppMission.GetFlag("isInspectionActive") == true ) then
				
				TppCommandPostObject.GsSetGroupVehicleRoute( "gntn_cp", "Cargo_Truck_WEST_001", "gntn_common_v01_route0025", 13 )
			elseif ( routeNodeIndex == 17 ) then
				
				TppMarkerSystem.DisableMarker{ markerId="Cargo_Truck_WEST_001" }
				TppMarkerSystem.DisableMarker{ markerId="e20030_Driver" }
			end
			
			this.CounterList.WestTruckStatus = routeNodeIndex + 1
		end
	
	elseif( vehicleInfoName == "VehicleRouteInfo_common_v02_0000" ) then
		
		if( routeID == GsRoute.GetRouteId( "gntn_common_v02_route0000" ) ) then
			if ( routeNodeIndex == 0 ) then
				
				this.CounterList.NorthTruckStatus = -1
			elseif ( routeNodeIndex == 2 ) then
				
				if ( TppMission.GetFlag("isMarkingTruck002") == true ) then
					TppMarker.Enable( "Cargo_Truck_WEST_002", 0, "none", "map_and_world_only_icon", 0, false, false )
				elseif ( TppMission.GetFlag("isMarkingDriver002") == true ) then
					TppMarkerSystem.EnableMarker{ markerId = "e20030_enemy022", viewType = { "VIEW_MAP_ICON", "VIEW_WORLD_ICON" } }
				end
			elseif ( routeNodeIndex == 5 ) then
				
				this.CounterList.NorthTruckStatus = 0
			end
		end
	
	elseif( vehicleInfoName == "VehicleRouteInfo_common_v02_0001" ) then
		
		if( routeID == GsRoute.GetRouteId( "gntn_common_v02_route0001" ) ) then
			if ( routeNodeIndex == 6 and  TppMission.GetFlag("isInspectionActive") == true ) then



				
				TppCommandPostObject.GsSetGroupVehicleRoute( "gntn_cp", "Cargo_Truck_WEST_002", "gntn_common_v02_route0005", 7 )
			elseif ( routeNodeIndex == 7 and  TppMission.GetFlag("isInspectionActive") == true ) then



				
				TppCommandPostObject.GsSetGroupVehicleRoute( "gntn_cp", "Cargo_Truck_WEST_002", "gntn_common_v02_route0005", 8 )
			elseif ( routeNodeIndex == 14 ) then
				
				TppMarkerSystem.DisableMarker{ markerId="Cargo_Truck_WEST_002" }
				TppMarkerSystem.DisableMarker{ markerId="e20030_enemy022" }
			end
			
			this.CounterList.NorthTruckStatus = routeNodeIndex + 1
		end
	else



	end
end



this.commonVehicleRouteFinish = function()



	local vehicleGroupInfo	= TppData.GetArgument(2)

	local vehicleInfoName	= vehicleGroupInfo.routeInfoName		
	local vehicleCharaID	= vehicleGroupInfo.vehicleCharacterId	
	local routeID			= vehicleGroupInfo.vehicleRouteId		
	local routeNodeIndex	= vehicleGroupInfo.passedNodeIndex		
	local memberCharaIDs	= vehicleGroupInfo.memberCharactorIds	
	local result 			= vehicleGroupInfo.result				
	local reason			= vehicleGroupInfo.reason				


	
	if ( result == "SUCCESS" ) then
		
		if( (vehicleInfoName == "VehicleRouteInfo_common_v01_0000") or (vehicleInfoName == "VehicleDefaultRideRouteInfo_e20030")) then




			
			this.CounterList.WestTruckStatus = 0

			
			if ( TppMission.GetFlag("isInspectionActive") == true ) then
				
				TppCommandPostObject.GsSetExclusionRoutes( "gntn_cp", "gntn_common_d01_route0032", "gntn_common_d01_route0027")

			else
				
				TppCommandPostObject.GsSetExclusionRoutes( "gntn_cp", "gntn_common_d01_route0028", "gntn_common_d01_route0027")
			end

		
		elseif( vehicleInfoName == "VehicleRouteInfo_common_v01_0001" ) then




			
			this.CounterList.WestTruckStatus = 0

			
			if ( TppMission.GetFlag("isInspectionActive") == true ) then
				
				TppCommandPostObject.GsSetExclusionRoutes( "gntn_cp", "gntn_common_d01_route0032", "gntn_common_d01_route0028")

			else
				
				TppCommandPostObject.GsSetExclusionRoutes( "gntn_cp", "gntn_common_d01_route0027", "gntn_common_d01_route0028")
			end

			
			GZCommon.Common_CenterBigGateVehicleSetup( "gntn_cp", "VehicleRouteInfo_common_v01_0000",
														  "gntn_common_v01_route0010", 
														  "gntn_common_v01_route0011", 
														  17, "NotClose" )	
			
			TppMarkerSystem.HideMarker{ markerId="Cargo_Truck_WEST_001", isHidden=true }
			TppMarkerSystem.HideMarker{ markerId="e20030_Driver", isHidden=true }

		
		elseif( vehicleInfoName == "VehicleRouteInfo_common_v02_0000" ) then




			
			this.CounterList.NorthTruckStatus = 0

			
			if ( TppMission.GetFlag("isInspectionActive") == true ) then
				
				TppCommandPostObject.GsSetExclusionRoutes( "gntn_cp", "gntn_common_d01_route0033", "gntn_common_d01_route0029")
			else
				
				TppCommandPostObject.GsSetExclusionRoutes( "gntn_cp", "gntn_common_d01_route0030", "gntn_common_d01_route0029")
			end

		
		elseif( vehicleInfoName == "VehicleRouteInfo_common_v02_0001" ) then




			
			this.CounterList.NorthTruckStatus = 0

			
			if ( TppMission.GetFlag("isInspectionActive") == true ) then
				
				TppCommandPostObject.GsSetExclusionRoutes( "gntn_cp", "gntn_common_d01_route0033", "gntn_common_d01_route0030")

			else
				
				TppCommandPostObject.GsSetExclusionRoutes( "gntn_cp", "gntn_common_d01_route0029", "gntn_common_d01_route0030")
			end

			
			TppMarkerSystem.HideMarker{ markerId="Cargo_Truck_WEST_002", isHidden=true }
			TppMarkerSystem.HideMarker{ markerId="e20030_enemy022", isHidden=true }
		else




		end
	else
		
		local sequence = TppSequence.GetCurrentSequence()
		local RouteSetName
		if( TppSequence.IsGreaterThan( sequence, "Seq_Waiting_GetCassette" ) or  TppMission.GetFlag("isGetCassette_B") == true ) then
			RouteSetName = "e20030_routeSet_d01_basic02"
		else
			RouteSetName = "e20030_routeSet_d01_basic01"
		end
		
		if ( vehicleCharaID == "Cargo_Truck_WEST_001" ) then



			TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0027" )
			TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0028" )
			TppEnemy.EnableRoute( "gntn_cp", "gntn_common_d01_route0032" )
			TppEnemy.ChangeRoute( "gntn_cp", "e20030_Driver", 	RouteSetName, "gntn_common_d01_route0032", 0 )
		else



			TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0029" )
			TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0030" )
			TppEnemy.EnableRoute( "gntn_cp", "gntn_common_d01_route0033" )
			TppEnemy.ChangeRoute( "gntn_cp", "e20030_enemy022", 	RouteSetName, "gntn_common_d01_route0033", 0 )
		end
	end
end




this.commonCheckVehicleSkipInspection = function()




	
	

	
	if ( this.CounterList.WestTruckStatus == -1 ) then
		
		
		
		
		

	elseif ( this.CounterList.WestTruckStatus ~= 0 ) then
		
		if ( this.CounterList.WestTruckStatus < 12 ) then
			


		elseif ( this.CounterList.WestTruckStatus < 15 ) then
			
			
			
			
			

		end
	end
	
	if ( this.CounterList.NorthTruckStatus == -1 ) then
		
		
		
		
		
		

	elseif ( this.CounterList.NorthTruckStatus ~= 0 ) then
		
		if ( this.CounterList.NorthTruckStatus < 7 ) then
			

		elseif ( this.CounterList.NorthTruckStatus < 12 ) then
			
			
			
			
			

		end
	end

end






this.CheckAlertChange = function()

	
	TppMission.SetFlag( "isAlreadyAlert", true )

	
	GZCommon.CallAlertSirenCheck()
	
	local radioDaemon = RadioDaemon:GetInstance()
	radioDaemon:DisableFlagIsCallCompleted( "e0030_oprg9020" )
end



this.CheckPhaseChange = function()

	
	GZCommon.StopAlertSirenCheck()


	local status = TppData.GetArgument(2)
	local radioDaemon = RadioDaemon:GetInstance()

	
	if ( status == "Down" ) then
		
		if ( TppSequence.GetCurrentSequence() == "Seq_Waiting_BetrayerContact" ) then

			
			if( TppEnemy.GetPhase("gntn_cp") == "caution" )then
				
			end
			
			if ( TppEnemy.GetPhase("gntn_cp") == "evasion" and TppMission.GetFlag("isGetCassette_B") == false ) then
				TppRadio.Play( "Radio_Contactable")		
				TppEnemy.ChangeRouteSet( "gntn_cp", "e20030_routeSet_c01_basic01", { warpEnemy = false } )
			end
		else
			
			if ( TppEnemy.GetPhase("gntn_cp") == "evasion" ) then
				TppEnemy.ChangeRouteSet( "gntn_cp", "e20030_routeSet_c01_basic01", { warpEnemy = false } )
			end
		end
		if( TppEnemy.GetPhase("gntn_cp") == "caution" )then
			
			radioDaemon:DisableFlagIsCallCompleted( "e0030_oprg9020" )
		end
		if ( TppEnemy.GetPhase("gntn_cp") == "evasion" ) then
			
			radioDaemon:DisableFlagIsCallCompleted( "e0060_oprg9010" )
		end

	end

end



this.ChangeAntiAir = function()

	
	local status = TppData.GetArgument(2)

	
	if ( status == true ) then

		
		GZCommon.CallCautionSiren()

	
	else
		
		GZCommon.StopSirenNormal()
	end

end



this.commonPlayerRideHeli = function()




	
	if ( TppMission.GetFlag("isGetCassette_A") == true or TppMission.GetFlag("isGetCassette_B") == true ) then

		
		TppRadio.Play( "Radio_RideHeli_Clear")

		
		TppSequence.ChangeSequence( "Seq_PlayerRideHelicopter" )	

	else

		
		TppRadio.Play( "Radio_HeliAbort_Warning")

		
		TppSupportHelicopterService.SetEnableGetOffTime( GZCommon.WaitTime_HeliTakeOff )

	end

	
	

end



this.commonHeliArrive = function()




	local timer = 55 

	
	TppMission.SetFlag( "isHeliLandNow", true )						
	GkEventTimerManager.Start( "Timer_pleaseLeaveHeli", timer )
end



this.commonHeliTakeOff = function()





	local isPlayer = TppData.GetArgument(3)

	
	if ( isPlayer == true ) then

		TppSequence.ChangeSequence( "Seq_PlayerRideHelicopter" )	

	end

	TppMission.SetFlag( "isHeliLandNow", false )					
end



this.commonHeliDead = function()





	local sequence = TppSequence.GetCurrentSequence()
	local killerCharacterId = TppData.GetArgument(2)

	
	if ( sequence == "Seq_PlayerRideHelicopter" ) then

		TppMission.ChangeState( "failed", "PlayerDeadOnHeli" )

	else
		
		if killerCharacterId == "Player" then
			TppRadio.Play( "Radio_BrokenHeliSneak" )
		else
			TppRadio.Play( "Radio_BrokenHeli" )
		end

		
		if ( TppMission.GetFlag( "isMastermindOnHeli" ) == true ) then
			this.commonMastermindDead()
			
			TppMission.SetFlag( "isMastermindOnHeli", false )
			this.commonBetrayerInterrogationSetUpdate()	
		end
		
		if ( TppMission.GetFlag( "isBetrayerOnHeli" ) == true ) then
			this.commonBetrayerDead()
			
			TppMission.SetFlag( "isBetrayerOnHeli", false )
		end

		
		this.commonCallAnnounceLog( this.AnnounceLogID_HeliDead )
	end


end



this.commonHeliDamagedByPlayer = function()



	local radioDaemon = RadioDaemon:GetInstance()

	if ( radioDaemon:IsPlayingRadio() == false ) then
		
		TppRadio.PlayEnqueue( "Miller_HeliAttack" )
	end
end



this.commonHeliLeaveJudge = function()
	local radioDaemon = RadioDaemon:GetInstance()
	local timer = 55 
	
	if( TppMission.GetFlag( "isHeliLandNow" ) == true ) then
		
		if ( GZCommon.Radio_pleaseLeaveHeli() == true ) then
			
			if ( radioDaemon:IsPlayingRadio() == false ) then
				
				TppRadio.PlayEnqueue( "Miller_HeliLeave" )
			end
			GkEventTimerManager.Start( "Timer_pleaseLeaveHeli", timer )
		end
	end
end



this.commonHostageLaidOn = function()




	local HostageCharacterID	= TppData.GetArgument(1)
	local VehicleCharacterID	= TppData.GetArgument(3)
	local sequence				= TppSequence.GetCurrentSequence()

	
	if ( VehicleCharacterID == "SupportHelicopter" ) then

		local funcs = {
			onEnd = function()
				
				if ( TppMission.GetFlag("isGetCassette_A") == false and TppMission.GetFlag("isGetCassette_B") == false ) then
					TppRadio.Play( "Radio_EncourageMission" )	
				end
			end,
		}
		TppRadio.Play( "Radio_HostageOnHeli", funcs )	

		
		GZCommon.NormalHostageRecovery( HostageCharacterID )
	end


end



this.commonCheckActivateWav = function()




	
	if ( TppMission.GetFlag("isAlreadyAlert") == true or
		( TppMission.GetFlag("isBetrayerContact") == true and TppMission.GetFlag("isBetrayerDown") == false ) ) then
		
		TppData.Enable( "APC_Machinegun_WEST_002" )
		TppData.Enable( "e20030_WavDriver" )
		TppMission.SetFlag( "isWavActivate", true )	
	end
end



this.commonCheckInspectionAppearance = function()




	

	
	if ( ( TppMission.GetFlag("isGetCassette_A") == true or TppMission.GetFlag("isGetCassette_B") == true ) and
		 TppMission.GetFlag("isInspectionActive") == false ) then

		
		if ( TppMission.GetFlag("isCameraAlert") == true ) then

			
			this.commonInspectionObjectON()

			
			this.CenterAreaTruckCheck()

			
			TppMission.SetFlag( "isInspectionActive", true )

			
			TppData.Enable( "e20030_enemyInspection01" )
			TppData.Enable( "e20030_enemyInspection02" )

			
			if ( TppMission.GetFlag("isWavActivate") == false ) then
				this.commonCheckActivateWav()
			end

			
			this.commonCheckVehicleSkipInspection()

			
			TppRadio.DelayPlay( "Radio_Inspection", "mid", "both", {
				onStart = function()
					
					this.commonCallAnnounceLog( this.AnnounceLogID_Inspection )
				end,
				onEnd = function()
					
					this.commonCallAnnounceLog( this.AnnounceLogID_MapUpdate )

					TppMarker.Enable( "TppMarkerLocator_EscapeWest", 0, "moving", "all", 0, false, true )		
					TppMarker.Enable( "TppMarkerLocator_EscapeNorth", 0, "moving", "all", 0, false, true  )		

					
					this.commonOptionalRadioUpdate()
				end,
			} )
		end
	end
end




this.commonInspectionObjectON = function()




	
	TppCharacterUtility.SetEnableCharacterId( "North_Barricade001", true )

	TppCharacterUtility.SetEnableCharacterId( "North_Barricade003", true )



	TppCharacterUtility.SetEnableCharacterId( "North_Barricade007", true )
	TppCharacterUtility.SetEnableCharacterId( "North_Barricade008", true )
	TppCharacterUtility.SetEnableCharacterId( "North_BarricadeBox001", true )
	TppCharacterUtility.SetEnableCharacterId( "North_BarricadeBox002", true )
	TppCharacterUtility.SetEnableCharacterId( "West_BarricadeBox001", true )
	TppCharacterUtility.SetEnableCharacterId( "West_BarricadeBox002", true )

end



this.CenterAreaTruckCheck = function()



	local pos			= Vector3( -164, 36, -3 )				
	local size			= Vector3( 83, 15, 62 )					
	local rot			= Quat( 0.0, 0.0, 0.0, 0.0 )			
	local npcIds		= 0
	local vehicleIds	= 0
	local characterID
	local UnrealFlag	= false

	
	
	vehicleIds = TppVehicleUtility.GetVehicleByBoxShape( pos, size, rot )

	
	if( vehicleIds and #vehicleIds.array > 0 ) then
		for i,id in ipairs( vehicleIds.array ) do
			characterID = TppCharacterUtility.GetCharacterIdFromUniqueId( id )



			if( characterID == "Cargo_Truck_WEST_002" ) then
				UnrealFlag = true
			end
		end
	end

	
	if ( UnrealFlag == false) then

		
		
		pos		= Vector3( 26, 34, 61 )
		size	= Vector3( 26, 14, 33 )
		rot		= Quat( 0.0, -0.3, 0.0, 0.8 )

		vehicleIds = TppVehicleUtility.GetVehicleByBoxShape( pos, size, rot )

		
		if( vehicleIds and #vehicleIds.array > 0 ) then
			for i,id in ipairs( vehicleIds.array ) do
				characterID = TppCharacterUtility.GetCharacterIdFromUniqueId( id )



				TppData.Disable( characterID )
			end
		end

		




		
		local VehicleId = TppPlayerUtility.GetRidingVehicleCharacterId()
		if ( VehicleId ~= "Cargo_Truck_WEST_002" ) then
			TppData.Disable( "Cargo_Truck_WEST_002" )
		end
		
		TppData.Enable( "Cargo_Truck_WEST_003" )

		
		TppEnemy.ChangeRoute( "gntn_cp", "e20030_enemy022", "e20030_routeSet_d01_basic02", "gntn_common_d01_route0033", 0 )
	end
end



this.commonStartForceSerching = function()



	
	

	
	

	
	TppEnemy.RegisterRouteSet( "gntn_cp", "caution_day", 	"e20030_routeSet_c01_serching01" )	
	
	

end



this.commonFinishForceSerching = function()



	
	
	TppCommandPostObject.GsSetKeepPhaseName( "gntn_cp", "Sneak" )	

	
	TppEnemy.ChangeRouteSet( "gntn_cp", "e20030_routeSet_d01_basic02", { warpEnemy = false } )
	TppEnemy.RegisterRouteSet( "gntn_cp", "caution_day", 	"e20030_routeSet_c01_basic01" )	

end



this.commonSwitchSneakRouteSet = function()




	
	TppEnemy.RegisterRouteSet( "gntn_cp", "sneak_day", 	"e20030_routeSet_d01_basic02" )	

	
	TppEnemy.ChangeRouteSet( "gntn_cp", "e20030_routeSet_d01_basic02", { warpEnemy = false } )

	
	if ( this.commonCheckAssistantStatus() == true ) then
		this.commonAssistantrRouteDisable()
		TppEnemy.EnableRoute( "gntn_cp", "gntn_e20030_ast_route0000" )
		TppEnemy.ChangeRoute( "gntn_cp", this.AssistantID,	"e20030_routeSet_d01_basic02", "gntn_e20030_ast_route0000", 0 )
	end

	
	this.commonSwitchMastermindConversation()

end



this.commonSwitchMastermindConversation = function()




	
	this.commonBetrayerRouteDisable()
	TppEnemy.EnableRoute( "gntn_cp", "gntn_e20030_tgt_route0003" )
	TppEnemy.ChangeRoute( "gntn_cp", this.BetrayerID,	"e20030_routeSet_d01_basic02", "gntn_e20030_tgt_route0003", 0 )

	
	TppEnemy.EnableRoute( "gntn_cp", "gntn_e20030_mst_route0000" )
	TppEnemy.ChangeRoute( "gntn_cp", this.MastermindID,	"e20030_routeSet_d01_basic02", "gntn_e20030_mst_route0000", 0 )

	
	TppCommandPostObject.GsSetRealizeFirstPriorityByRoute( "gntn_cp", "gntn_e20030_mst_route0000", true )

	
	TppCommandPostObject.GsSetConversationEnableFlag( "gntn_cp", "CTE0030_0020" , true )

end



this.commonCheckAssistantStatus = function()



	local AssistantStatus = TppEnemy.GetEnemyStatus( this.AssistantID )

	if ( AssistantStatus == ( "Normal" ) ) then



		return true
	else



		return false
	end
end



this.commonConversationEnd = function()

	local LabelName			= TppData.GetArgument(2)
	local CharaID			= TppData.GetArgument(3)





	
	if ( LabelName == "CTE0030_0020" ) then




		TppMission.SetFlag( "isMastermindConversationEnd", true )

		
		TppCommandPostObject.GsSetConversationEnableFlag( "gntn_cp", "CTE0030_0020" , false )

		
		if ( (TppMission.GetFlag("isGetInfo_Suspicion1") == true) and (TppMission.GetFlag("isGetInfo_Suspicion3") == true)) then
			
			TppRadio.Play( "Radio_Conversation_Comp" )

		elseif ( (TppMission.GetFlag("isGetInfo_Suspicion1") == true) or (TppMission.GetFlag("isGetInfo_Suspicion3") == true)) then
			
			TppRadio.Play( "Radio_Conversation_InComp" )

		else
			

		end

		
		this.commonOptionalRadioUpdate()

	
	elseif ( LabelName == "CTE0030_0010" ) then




		
		TppCommandPostObject.GsSetConversationEnableFlag( "gntn_cp", "CTE0030_0010" , false )

		
		this.ChangeAssistantRoute( "e20030_routeSet_d01_basic01", "gntn_e20030_ast_route9003", 0 )

		
		TppMission.SetFlag( "isAssistantConversationEnd", true )

	end

end



this.CommonGetCassette_A = function()





	
	local uiCommonData = UiCommonDataManager.GetInstance()
	uiCommonData:GetBriefingCassetteTape( this.CassetteA )

	
	
	if ( TppMission.GetFlag( "isBetrayerContact" ) == false ) then

		if ( TppMission.GetFlag( "isDropCassette_B" ) == false ) then
			
			TppRadio.Play( "Radio_GetCassette_A_NoHint" )
		else
			if ( TppEnemy.GetPhase("gntn_cp") == "alert" ) then
				TppRadio.Play( "Radio_GetCassette_A_Alert" )
			else
				TppRadio.Play( "Radio_GetCassette_A" )
			end
		end
	
	else
		if ( TppEnemy.GetPhase("gntn_cp") == "alert" ) then
			TppRadio.Play( "Radio_GetCassette_A_Alert" )
		else
			TppRadio.Play( "Radio_GetCassette_A" )
		end
	end

	TppMission.SetFlag( "isGetCassette_A", true )
	this.commonBetrayerInterrogationSetUpdate()	

	
	GZCommon.isOutOfMissionEffectEnable = false

	
	TppMarker.Disable( "e20030_marker_Signal" )

	
	if ( TppMission.GetFlag( "isCameraBroken" ) == true ) then
		
		TppSequence.ChangeSequence( "Seq_Escape_CameraBroken" )

	else
		
		TppSequence.ChangeSequence( "Seq_Escape_CameraActive" )

	end

	
	if ( TppMission.GetFlag( "isGetCassette_B" ) == false ) then
		
		this.commonCallAnnounceLog( this.AnnounceLogID_MissionGoal )
	end

	
	this.commonOptionalRadioUpdate()

	
	this.commonUpdateCheckEnemyIntelRadio()

	
	this.commonUpdateGuardTarget()

end



this.CommonGetCassette_B = function()





	
	local uiCommonData = UiCommonDataManager.GetInstance()
	uiCommonData:GetBriefingCassetteTape( this.CassetteB )

	TppMission.SetFlag( "isGetCassette_B", true )

	local hardmode = TppGameSequence.GetGameFlag("hardmode")
	if ( hardmode == true ) then
		
		PlayRecord.RegistPlayRecord( "TAPE_GET" )
	end

	
	commonMissionSubGoalSetting( this.MissionSubGoal_Escape )

	
	this.commonCallAnnounceLog( this.AnnounceLogID_InfoUpdate )

	
	this.commonRadioGetCassetteB()

	
	this.commonOptionalRadioUpdate()

	
	local routeId = TppEnemyUtility.GetRouteId( this.BetrayerID )
	if ( routeId == GsRoute.GetRouteId("gntn_e20030_tgt_route0003") ) then
		
		this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic02", "gntn_e20030_tgt_route0000", 16 )
		this.commonBetrayerRouteWareHouse()
	end

	
	this.commonUpdateCheckEnemyIntelRadio()

	
	TppMarker.Disable( "e20030_marker_Signal" )		
	TppMarker.Disable( "e20030_marker_Cassette" )	

	
	GZCommon.isOutOfMissionEffectEnable = false

	
	TppEnemy.RegisterRouteSet( "gntn_cp", "sneak_day", 	"e20030_routeSet_d01_basic02" )	

	
	TppEnemy.ChangeRouteSet( "gntn_cp", "e20030_routeSet_d01_basic02", { warpEnemy = false } )

	
	this.commonSequenceSaveIndefinite()

	
	this.commonUpdateGuardTarget()

	
	if ( TppMission.GetFlag( "isGetCassette_A" ) == false ) then
		
		this.commonCallAnnounceLog( this.AnnounceLogID_MissionGoal )
	end

	
	PlayRecord.PlusExternalScore( 3000 )
end



this.CommonDropCassette_B = function()




	
	TppEnemyUtility.DropItem {
		characterId	= this.MastermindID,
		itemId		= "IT_Cassette",
		itemIndex	= 15,
		setMarker	= true,
	}
	

	
	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager == NULL then
		return
	end

	local luaData = commonDataManager:GetUiLuaExportCommonData()
	if luaData == NULL then
		return
	end

	luaData:RegisterIconUniqueInformation( { markerId= "IT_Cassette", langId="marker_info_item_tape" })

	
	
	if ( TppEnemyUtility.GetStatus( this.MastermindID ) == "HoldUp" ) then
		this.commonMastermindRestraintEnd()
	end

end



this.commonOnSecurityCameraDemo = function()





	
	if ( TppMission.GetFlag( "isCameraDemoPlay" ) == false and
		 TppMission.GetFlag( "isCameraBroken" ) == false and
		 TppEnemy.GetPhase( "gntn_cp" ) ~= "alert" ) then

		
		
		TppPlayerUtility.RequestToStartTransition{stance="Stand",direction=100,doKeep=false}

		
		local funcs = {}
		
		TppDemo.Play( "Demo_SecurityCamera", funcs,
		{ disableGame = false,			
		  disableDamageFilter = false,	
		  disableDemoEnemies = false,	
		  disableHelicopter = false,	
		  disablePlacement = false,		
		  disableThrowing = false,		
		} )

		TppMission.SetFlag( "isCameraDemoPlay", true )	

		
		this.commonStartForceSerching()

	end

end




this.doorToHostageMap = {
	AsyPickingDoor08 = "Hostage_e20030_000",
	AsyPickingDoor13 = "Hostage_e20030_002",
	AsyPickingDoor17 = "Hostage_e20030_001",
}




this.commonGetDoorOpenedFlagName = function( doorCharacterId )

	return doorCharacterId .. "Opened"

end




this.commonSetDoorOpenedFlag = function( doorCharacterId, flag )

	TppMission.SetFlag( this.commonGetDoorOpenedFlagName( doorCharacterId ), flag )

end




this.commonGetDoorOpenedFlag = function( doorCharacterId )

	return TppMission.GetFlag( this.commonGetDoorOpenedFlagName( doorCharacterId ) )

end


for doorCharacterId, hostageCharacterId in pairs( this.doorToHostageMap ) do
	this.MissionFlagList[ this.commonGetDoorOpenedFlagName( doorCharacterId ) ] = false
end




this.commonOnPickingDoor = function()

	local doorCharacterId = TppData.GetArgument( 1 )
	local hostageCharacterId = this.doorToHostageMap[ doorCharacterId ]

	if hostageCharacterId ~= nil then

		
		TppHostageManager.GsSetStruggleFlag( hostageCharacterId, false )

		
		this.commonSetDoorOpenedFlag( doorCharacterId, true )

	end

end




this.commonOnPlayerEnterHostageCallTrap = function( num )





	local trapBodyHandle = TppData.GetArgument(3)
	local trapName = trapBodyHandle.data.name

	if( num == "Enter" ) then
		TppHostageManager.GsSetStruggleVoice( "Hostage_e20030_000", "POWV_0260" )	
		TppHostageManager.GsSetStruggleVoice( "Hostage_e20030_001", "POWV_0260" )	
		TppHostageManager.GsSetStruggleVoice( "Hostage_e20030_002", "POWV_0260" )	

		
		for doorCharacterId, hostageCharacterId in pairs( this.doorToHostageMap ) do
			if this.commonGetDoorOpenedFlag( doorCharacterId ) == false then		
				TppHostageManager.GsSetStruggleFlag( hostageCharacterId, true )			
			end
		end

	else
		TppHostageManager.GsSetStruggleFlag( "Hostage_e20030_000", false )	
		TppHostageManager.GsSetStruggleFlag( "Hostage_e20030_001", false )	
		TppHostageManager.GsSetStruggleFlag( "Hostage_e20030_002", false )	

	end
end



this.commonOnPlayerEnterHostageAreaTrap = function()





	
	TppRadio.Play( "Radio_DiscoverHostage" )

end






this.commonBetrayerDead = function()




	local sequence = TppSequence.GetCurrentSequence()

	if ( sequence == "Seq_Waiting_BetrayerContact") then

		
		if ( TppMission.GetFlag( "isGetCassette_A" ) == false and TppMission.GetFlag( "isGetCassette_B" ) == false ) then
			TppMission.ChangeState( "failed", "Betrayer_Dead" )		
		end

	elseif ( sequence == "Seq_Waiting_GetCassette" and TppMission.GetFlag( "isGetCassette_B" ) == false ) then

		TppMission.SetFlag( "isBetrayerDown", true )
		
		TppRadio.DelayPlay( "Radio_DeadBetrayer_AfterDemo", "short" )

	else

		TppMission.SetFlag( "isBetrayerDown", true )
		
		if ( TppMission.GetFlag( "isBetrayerMarking" ) == true ) then
			TppRadio.DelayPlay( "Radio_DeadBetrayer_AfterGetCassette", "short" )
		end
	end

	
	TppTimer.Stop( "BetrayerContactCheckTimer" )

end



this.commonBetrayerFaint = function()




	local sequence = TppSequence.GetCurrentSequence()

	
	if ( TppMission.GetFlag( "isBetrayerMarking" ) == true ) then
		if ( sequence == "Seq_Waiting_BetrayerContact") then

			
			if ( this.CounterList.BetrayerRestraintEndRadio ~= "NoRadio" ) then

				this.commonBetrayerRestraintEnd()
			else
				
				local radioDaemon = RadioDaemon:GetInstance()
				if ( radioDaemon:IsRadioGroupMarkAsRead("e0030_rtrg0094") == false ) then
					TppRadio.DelayPlay( "Radio_FaintBetrayer_BeforeDemo", "short" )
				end
			end

		elseif ( sequence == "Seq_Waiting_GetCassette") then

			
			
			

		else
			
			if ( this.CounterList.BetrayerRestraintEndRadio ~= "NoRadio" ) then

				this.commonBetrayerRestraintEnd()

			else
				TppRadio.DelayPlay( "Radio_DisablementBetrayer_AfterDemo", "short" )	
			end
		end
	end
	
	TppTimer.Stop( "BetrayerContactCheckTimer" )

end



this.commonBetrayerSleep = function()




	local sequence = TppSequence.GetCurrentSequence()

	
	if ( TppMission.GetFlag( "isBetrayerMarking" ) == true ) then
		if ( sequence == "Seq_Waiting_BetrayerContact") then
			
			local radioDaemon = RadioDaemon:GetInstance()
			if ( radioDaemon:IsRadioGroupMarkAsRead("e0030_rtrg0093") == false ) then
				TppRadio.DelayPlay( "Radio_SleepBetrayer_BeforeDemo", "short" )
			end

		elseif ( sequence == "Seq_Waiting_GetCassette") then

			
			
			

		else
			
			if ( this.CounterList.BetrayerRestraintEndRadio ~= "NoRadio" ) then

				this.commonBetrayerRestraintEnd()
			else
				TppRadio.DelayPlay( "Radio_DisablementBetrayer_AfterDemo", "short" )	
			end
		end
	end
	
	TppTimer.Stop( "BetrayerContactCheckTimer" )

end



this.commonBetrayerCarried = function()




	
	if ( TppMission.GetFlag( "isBetrayerMarking" ) == false and
		 TppMission.GetFlag( "isGetCassette_A" ) == false and TppMission.GetFlag( "isGetCassette_B" ) == false ) then
		
		this.commonBetrayerMarkerOn()
		TppRadio.Play("Radio_MarkingBetrayer4")		
	end
end



this.commonBetrayerRestraint = function()




	
	this.CounterList.BetrayerRestraint = 0

	
	if ( TppMission.GetFlag( "isGetCassette_B" ) == false ) then
		
		this.commonBetrayerContactCheck()
	end

	
	if ( TppMission.GetFlag( "isBetrayerMarking" ) == false and
		 TppMission.GetFlag( "isGetCassette_A" ) == false and TppMission.GetFlag( "isGetCassette_B" ) == false ) then
		
		this.commonBetrayerMarkerOn()
		TppRadio.Play("Radio_MarkingBetrayer4")		
	end
end



this.commonBetrayerRestraintEnd = function()




	
	if ( this.CounterList.BetrayerRestraintEndRadio ~= "NoRadio" ) then

		
		if (( TppMission.GetFlag( "isBetrayerContact" ) == false and
			  TppMission.GetFlag( "isGetInfo_Suspicion2" ) == false and
			  TppMission.GetFlag( "isGetCassette_A" ) == true and
			  TppMission.GetFlag( "isDropCassette_B" ) == false ) ) then

			this.CounterList.BetrayerRestraintEndRadio = "Radio_Reaction_Escape"	
		end

		
		TppRadio.DelayPlay( this.CounterList.BetrayerRestraintEndRadio, "short" )

		
		this.CounterList.BetrayerRestraintEndRadio = "NoRadio"

	end

	
	this.CounterList.BetrayerRestraint = 0

	
	TppTimer.Stop( "BetrayerContactCheckTimer" )
end



this.commonBetrayerMarkerOn = function()




	TppMission.SetFlag( "isBetrayerMarking", true )
	
	TppMarker.Enable( this.BetrayerID, 0, "moving", "all", 0, true, true )
	TppMarkerSystem.EnableMarker{ markerId = this.BetrayerID, viewType = { "VIEW_MAP_ICON", "VIEW_WORLD_ICON" } }	

	
	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager == NULL then
		return
	end

	local luaData = commonDataManager:GetUiLuaExportCommonData()
	if luaData == NULL then
		return
	end

	luaData:RegisterIconUniqueInformation( { markerId= this.BetrayerID, langId="marker_info_agent" })

	
	GZCommon.CallSearchTarget()

	
	this.commonUpdateCheckEnemyIntelRadio()

end



this.commonMastermindDead = function()




	TppMission.SetFlag( "isMastermindDown", true )
	this.commonBetrayerInterrogationSetUpdate()	

	
	if ( TppMission.GetFlag( "isGetCassette_B" ) == false and TppMission.GetFlag( "isDropCassette_B" ) == false ) then
		PlayRecord.UnsetMissionChallenge( "TAPE_GET" )

	end
end



this.commonMastermindRestraintEnd = function()




	
	if ( this.CounterList.MastermindRestraintEndRadio ~= "NoRadio" ) then

		
		TppRadio.DelayPlay( this.CounterList.MastermindRestraintEndRadio, "short" )

		
		this.CounterList.MastermindRestraintEndRadio = "NoRadio"

	end
end


this.commonMissionTargetMarkingCheck = function()
	local CharacterID = TppData.GetArgument(1)



	
	if( CharacterID == this.BetrayerID ) then
		
		if( TppMission.GetFlag( "isBetrayerMarking" ) == false and
			TppMission.GetFlag( "isGetCassette_A" ) == false and
			TppMission.GetFlag( "isGetCassette_B" ) == false and
			TppMission.GetFlag( "isBetrayerContact" ) == false ) then





			
			TppMarkerSystem.ResetAllNewMarker()

			
			this.commonBetrayerMarkerOn()

			
			
			local enemyNum = TppEnemyUtility.GetNumberOfActiveSoldierByCharacterId( this.BetrayerID, 5 )

			if ( enemyNum == 0 ) then
				local MarkingBetrayer = { "Radio_MarkingBetrayer1", "Radio_MarkingBetrayer2" }
				TppRadio.Play( MarkingBetrayer )
			else
				local MarkingBetrayer = { "Radio_MarkingBetrayer1", "Radio_MarkingBetrayer3" }
				TppRadio.Play( MarkingBetrayer )
			end

			
			TppRadio.RegisterIntelRadio( this.BetrayerID, "e0030_esrg0020", true )	

			
			TppTimer.Stop( "CheckTargetPhotoTimer" )
		end
	
	elseif( CharacterID == this.MastermindID ) then
		
		if( TppMission.GetFlag( "isMastermindMarking" ) == false and TppMission.GetFlag( "isGetInfo_Mastermind" ) == true ) then
			TppMission.SetFlag( "isMastermindMarking", true )





			
			TppMarkerSystem.ResetAllNewMarker()

			
			TppMarker.Enable( this.MastermindID, 0, "moving", "map_only_icon", 0, true )
			
			GZCommon.CallSearchTarget()
			
			TppRadio.Play( "Radio_MarkingMastermind" )

			
			TppRadio.EnableIntelRadio( "e20030_Mastermind")
		end
	end
end



this.commonOnLaidEnemy = function()

	local sequence				= TppSequence.GetCurrentSequence()
	local EnemyCharacterID		= TppData.GetArgument(1)
	local VehicleCharacterID	= TppData.GetArgument(3)
	local EnemyLife				= TppEnemyUtility.GetLifeStatus( EnemyCharacterID )





	
	if ( EnemyLife ~= "Dead" ) then
		
		if( VehicleCharacterID == "SupportHelicopter" ) then
			
			if ( TppMission.GetFlag("isGetCassette_A") == true or TppMission.GetFlag("isGetCassette_B") == true ) then
				TppRadio.DelayPlay( "Radio_HostageOnHeli", "short" )	
			else
				
				if ( sequence == "Seq_Waiting_BetrayerContact" and EnemyCharacterID == this.BetrayerID ) then

					TppRadio.DelayPlay( "Radio_BetrayerOnHeli", "mid", "end" )	

					
					TppMission.SetFlag( "listeningInfoFromBetrayer", true )
					
					this.commonOptionalRadioUpdate()
					
					TppTimer.Start( "Timer_ListeningInfoFromBetrayer", this.Time_ListeningInfoFromBetrayer )
				else
					local EncourageMission = { "Radio_HostageOnHeli", "Radio_EncourageMission" }	
					TppRadio.DelayPlay( EncourageMission, "short", "begin", {
						onEnd = function()
							if ( TppMission.GetFlag("isBetrayerContact") == true ) then
								
								TppRadio.DelayPlay( "Radio_RecommendGetCassette_A", "mid", "end" )
							else
								
								TppRadio.DelayPlay( "Radio_MissionBriefing2", "mid", "end" )
							end
						end
					} )
				end
			end

			
			if( EnemyCharacterID == this.MastermindID ) then
				TppMission.SetFlag( "isMastermindOnHeli", true )
				this.commonBetrayerInterrogationSetUpdate()	

				
				this.commonCallAnnounceLog( this.AnnounceLogID_RecoveryMastermind )
				
				PlayRecord.RegistPlayRecord( "SOLDIER_RESCUE", this.MastermindID )
			end
			
			if( EnemyCharacterID == this.BetrayerID ) then
				TppMission.SetFlag( "isBetrayerOnHeli", true )
				
				this.commonCallAnnounceLog( this.AnnounceLogID_RecoveryBetrayer )
				
				PlayRecord.RegistPlayRecord( "SOLDIER_RESCUE", this.BetrayerID )
			end
		
		else
			
		end
	end
end



this.EndCPRadio = function()

	local RadioEnentName = TppData.GetArgument(1)





	
	if( RadioEnentName == this.SecurityCameraDeadRadioName and
		TppMission.GetFlag( "isCameraBroken" ) == true and
		TppMission.GetFlag( "isCameraBrokenRadio" ) == false and
		TppMission.GetFlag( "isCameraAlert" ) == false and
		TppMission.GetFlag( "isCameraIntelRadioPlay" ) == false ) then	

		
		if ( this.CounterList.CameraBrokenRadio ~= "NoRadio") then
			TppRadio.DelayPlay( this.CounterList.CameraBrokenRadio, "short" )
		end
		TppMission.SetFlag( "isCameraBrokenRadio", true )
	end

end



this.commonUpdateGuardTarget = function()

	
	if ( TppMission.GetFlag( "isGetCassette_A" ) == true or
		 TppMission.GetFlag( "isGetCassette_B" ) == true ) then




		
		if ( this.CounterList.PlayerArea == "Area_campWest" ) then
			
			TppCommandPostObject.GsSetGuardTargetValidity( "gntn_cp", "TppGuardTargetData_Gate", false )
			TppCommandPostObject.GsSetGuardTargetValidity( "gntn_cp", "TppGuardTargetData_InspectionNorth", false )
			TppCommandPostObject.GsSetGuardTargetValidity( "gntn_cp", "TppGuardTargetData_InspectionWest", true )

		else
			
			TppCommandPostObject.GsSetGuardTargetValidity( "gntn_cp", "TppGuardTargetData_Gate", false )
			TppCommandPostObject.GsSetGuardTargetValidity( "gntn_cp", "TppGuardTargetData_InspectionNorth", true )
			TppCommandPostObject.GsSetGuardTargetValidity( "gntn_cp", "TppGuardTargetData_InspectionWest", false )

		end
		
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0000",false)
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0106",false)
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0057",false)
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0010",true)
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0121",true)

	else
		
		TppCommandPostObject.GsSetGuardTargetValidity( "gntn_cp", "TppGuardTargetData_Gate", true )
		TppCommandPostObject.GsSetGuardTargetValidity( "gntn_cp", "TppGuardTargetData_InspectionNorth", false )
		TppCommandPostObject.GsSetGuardTargetValidity( "gntn_cp", "TppGuardTargetData_InspectionWest", false )

		
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0167",false)
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0095",false)
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0146",false)
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0014",true)
		TppCommandPostObject.GsSetPriorityCombatLocator("gntn_cp","TppCombatLocatorData0130",true)
	end
end


this.commonOnDeadHostage = function()



	local HostageCharacterID	= TppData.GetArgument(1)
	local PlayerDead			= TppData.GetArgument(4)
	
	if( PlayerDead == true ) then
		TppRadio.DelayPlay( "Radio_HostageDead", "mid" )
	end
	TppRadio.DisableIntelRadio( HostageCharacterID )

end







this.commonMastermindInterrogation = function()




	
	
	

	
	if ( TppMission.GetFlag( "isDropCassette_B" ) == false ) then

		TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.MastermindID, 0 )

	
	else

		
		TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.MastermindID, 1 )

	end
end





this.commonBetrayerContactCheck = function()




	
	local status = TppEnemyUtility.GetStatus( this.BetrayerID )

	if ( status == "Hung") then
		
		local enemyNum = TppEnemyUtility.GetNumberOfActiveSoldierByCharacterId( this.BetrayerID, this.Size_ActiveEnemy )

		
		if ( enemyNum ~= 0 ) then




			
			if ( TppSequence.GetCurrentSequence() == "Seq_Waiting_BetrayerContact") then

				
				TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.BetrayerID, 0 )

				
				if ( this.CounterList.BetrayerRestraint == 0 ) then
					if ( TppEnemy.GetPhase( "gntn_cp" ) == "alert" ) then
						TppRadio.Play( "Radio_ContactNot_Phase")		
					else
						TppRadio.Play( "Radio_ContactNot_NearEnemy2")	
					end
					this.CounterList.BetrayerRestraint = 1	
				end
			end
		
		elseif ( (TppMission.GetFlag( "isBetrayerContact" ) == false) and
				 (TppMission.GetFlag( "isGetCassette_A" ) == false) and
				 (TppMission.GetFlag( "isDropCassette_B" ) == false) and
				 (TppMission.GetFlag( "isGetInfo_Suspicion2" ) == false) and
			
				 ((TppEnemy.GetPhase( "gntn_cp" ) ~= "alert") ) ) then



			
			TppSequence.ChangeSequence( "Seq_BetrayerContactDemo" )
		else
			
		end
	end

	
	if ( TppSequence.GetCurrentSequence() == "Seq_Waiting_BetrayerContact") then
		TppTimer.Start( "BetrayerContactCheckTimer", 7 )
	end

end




this.commonBetrayerInterrogation = function()




	
	
	
	
	

	
	local SetName = this.CounterList.BetrayerInterrogationSet
	
	local SerifName = this.CounterList.BetrayerInterrogationSerif








	
	if ( SetName == "BCD" ) then
		if ( SerifName == "B") then
			TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.BetrayerID, 2 )
		elseif ( SerifName == "C" or SerifName == "D" ) then
			TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.BetrayerID, 3 )
		else
			
			TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.BetrayerID, 1 )
		end
	elseif ( SetName == "BD" ) then
		if ( SerifName == "B" or SerifName == "D" ) then
			TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.BetrayerID, 3 )
		else
			
			TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.BetrayerID, 1 )
		end
	elseif ( SetName == "A" ) then
		
		TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.BetrayerID, 0 )

	else



		
		TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.BetrayerID, 0 )

	end
end



this.commonBetrayerInterrogationSetUpdate = function()





	
	
	
	
	
	
	

		
	if ( TppMission.GetFlag( "isBetrayerContact" ) == true and
		 TppMission.GetFlag( "isGetInfo_Suspicion2" ) == false and
		 TppMission.GetFlag( "isDropCassette_B" ) == false ) then
		this.CounterList.BetrayerInterrogationSet = "A"
		TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.BetrayerID, 0 )

		
	elseif (
			( TppMission.GetFlag( "isBetrayerContact" ) == false and
			  TppMission.GetFlag( "isGetInfo_Suspicion2" ) == false and
			  TppMission.GetFlag( "isGetCassette_A" ) == true and
			  TppMission.GetFlag( "isDropCassette_B" ) == false and
			  ( TppMission.GetFlag( "isMastermindDown" ) == true or TppMission.GetFlag( "isMastermindOnHeli" ) == true ) ) or
		
		   ( TppMission.GetFlag( "isGetInfo_Suspicion2" ) == true and
			 TppMission.GetFlag( "isDropCassette_B" ) == false and
			( TppMission.GetFlag( "isMastermindDown" ) == true or TppMission.GetFlag( "isMastermindOnHeli" ) == true ) )
		   ) then
		this.CounterList.BetrayerInterrogationSet = "BD"
		TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.BetrayerID, 1 )

		
	elseif (
			( TppMission.GetFlag( "isBetrayerContact" ) == false and
			  TppMission.GetFlag( "isGetInfo_Suspicion2" ) == false and
			  TppMission.GetFlag( "isGetCassette_A" ) == true and
			  TppMission.GetFlag( "isDropCassette_B" ) == false and
			  ( TppMission.GetFlag( "isMastermindDown" ) == false and TppMission.GetFlag( "isMastermindOnHeli" ) == false ) ) or
		
		   ( TppMission.GetFlag( "isBetrayerContact" ) == true and
			 TppMission.GetFlag( "isGetInfo_Suspicion2" ) == true and
			 TppMission.GetFlag( "isGetCassette_A" ) == false and
			 TppMission.GetFlag( "isDropCassette_B" ) == false and
			( TppMission.GetFlag( "isMastermindDown" ) == false and TppMission.GetFlag( "isMastermindOnHeli" ) == false ) ) or
		
		   ( TppMission.GetFlag( "isGetInfo_Suspicion2" ) == true and
			 TppMission.GetFlag( "isGetCassette_A" ) == true and
			 TppMission.GetFlag( "isDropCassette_B" ) == false and
			( TppMission.GetFlag( "isMastermindDown" ) == false and TppMission.GetFlag( "isMastermindOnHeli" ) == false ) )
		   ) then
		this.CounterList.BetrayerInterrogationSet = "BCD"
		TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.BetrayerID, 1 )

	else
		
		this.CounterList.BetrayerInterrogationSet = "A"
		TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.BetrayerID, 0 )
	end

end


this.commonFinishBetrayerSerif1 = function()




	
	if ( TppEnemyUtility.GetStatus( this.BetrayerID ) ~= "Hung" ) then
		TppRadio.Play( "Radio_Reaction_Intimidation" )	
	else
		
		TppTimer.Start( "dbg_InterrogationTimer_Betrayer1", 10 )
	end
end


this.commonFinishBetrayerSerif2 = function()




	TppRadio.Play( "Radio_Reaction_Escape" )	

end



this.commonBetrayerInterrogationRegister = function()




	this.CounterList.BetrayerInterrogation = 0
	TppEnemyUtility.SetInterrogationAllDoneFlagByCharacterId( this.BetrayerID, false )

end




this.commonRadioCallAfterBetrayerInterrogation = function()

	
	

end





this.commonCallAnnounceLog = function( langId )




	local hudCommonData = HudCommonDataManager.GetInstance()

	hudCommonData:AnnounceLogViewLangId( langId )

	
	TppSoundDaemon.PostEvent( "sfx_s_terminal_data_fix" )

end



this.commonShowTutorial_CQC = function()




	
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:CallButtonGuide( "tutorial_restraint","PL_CQC" )

end



this.commonSubtitles_BetrayerSerifA = function()





	this.CounterList.BetrayerInterrogationSerif = "A"

	
	

end


this.commonSubtitles_BetrayerSerifB = function()





	
	if ( TppMission.GetFlag( "isGetInfo_Intimidation" ) == false ) then

		
		this.CounterList.BetrayerRestraintEndRadio = "Radio_Reaction_Intimidation"	
	end

	this.CounterList.BetrayerInterrogationSerif = "B"

	
	TppMission.SetFlag( "isGetInfo_Intimidation", true )

	
	

end


this.commonSubtitles_BetrayerSerifC = function()





	
	if ( TppMission.GetFlag( "isGetInfo_Mastermind" ) == false ) then

		
		if ( TppMission.GetFlag( "isGetCassette_A" ) == false and
			 TppMission.GetFlag( "isDropCassette_B" ) == false and
			 ( TppMission.GetFlag( "isMastermindDown" ) == false and TppMission.GetFlag( "isMastermindOnHeli" ) == false ) ) then

			
			this.CounterList.BetrayerRestraintEndRadio = "Radio_Reaction_Search"	
		elseif ( TppMission.GetFlag( "isDropCassette_B" ) == true ) then

			
			this.CounterList.BetrayerRestraintEndRadio = "Radio_Reaction_Truth"	
		end
	end

	this.CounterList.BetrayerInterrogationSerif = "C"

	
	TppMission.SetFlag( "isGetInfo_Mastermind", true )

	
	this.commonUpdateCheckEnemyIntelRadio()

	
	this.commonOptionalRadioUpdate()

	
	local routeId = TppEnemyUtility.GetRouteId( this.BetrayerID )
	if ( routeId == GsRoute.GetRouteId("gntn_e20030_tgt_route0003") ) then
		
		this.ChangeBetrayerRoute( "e20030_routeSet_d01_basic02", "gntn_e20030_tgt_route0000", 16 )
		this.commonBetrayerRouteWareHouse()
	end

	
	

end


this.commonSubtitles_BetrayerSerifD = function()





	this.CounterList.BetrayerInterrogationSerif = "D"

end



this.commonSubtitles_DropTapeB = function()





	
	TppTimer.Start( "CassetteDropTimer", 3 )

	TppMission.SetFlag( "isDropCassette_B", true )
	this.commonBetrayerInterrogationSetUpdate()	

	
	this.commonOptionalRadioUpdate()

	
	this.commonUpdateMissionDescription()

	
	commonMissionSubGoalSetting( this.MissionSubGoal_Cassette )

	
	TppRadio.DisableIntelRadio( "e20030_Mastermind")

	
	this.commonUpdateCheckEnemyIntelRadio()

	
	TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.MastermindID, 1 )

	
	if ( TppMission.GetFlag( "isGetInfo_Mastermind" ) == true ) then
		
		
		this.CounterList.MastermindRestraintEndRadio = "Radio_DropCassette_B_Confidence"

	elseif ( TppMission.GetFlag( "isGetCassette_A" ) == false ) then
		
		
		this.CounterList.MastermindRestraintEndRadio = "Radio_DropCassette_B_Suspicion"

	else
		
		
		this.CounterList.MastermindRestraintEndRadio = "Radio_DropCassette_B_NoHint"
	end

	
	this.CounterList.BetrayerRestraintEndRadio = "NoRadio"

end


this.commonSubtitles_Rebellion = function()





	local radioDaemon = RadioDaemon:GetInstance()

	
	if ( radioDaemon:IsRadioGroupMarkAsRead("e0030_rtrg0230") == false ) then

		
		if ( this.CounterList.MastermindRestraintEndRadio == "NoRadio" ) then
			
			this.CounterList.MastermindRestraintEndRadio = "Radio_Reaction_Rebellion"	
		end
	end



	
	TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.MastermindID, 1 )

end


this.commonSubtitles_TrapA = function()



	
	TppMission.SetFlag( "isGetInfo_Suspicion1", true )

end


this.commonSubtitles_TrapB = function()



	
	TppMission.SetFlag( "isGetInfo_Suspicion2", true )
	TppMission.SetFlag( "isGetInfo_Suspicion3", true )
	this.commonBetrayerInterrogationSetUpdate()	

	
	this.commonUpdateCheckCameraIntelRadio()

end






this.Seq_MissionPrepare = {
	OnEnter = function( manager )
		this.onMissionPrepare( manager )

		TppSequence.ChangeSequence( "Seq_MissionSetup" )
	end,
}




this.Seq_MissionSetup = {

	OnEnter = function()
		onCommonMissionSetup()

		
		commonRouteSetMissionSetup( "e20030_routeSet_d01_basic01" )

		TppSequence.ChangeSequence( "Seq_OpeningDemoLoad" )
	end,
}




this.Seq_OpeningDemoLoad = {

	OnEnter = function()
		commonDemoBlockSetup()
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

		TppUI.ShowTransitionWithFadeIn( "opening", localChangeSequence )
		TppMusicManager.PostJingleEvent( "MissionStart", "Play_bgm_gntn_op_default" )
	end,
}




this.Seq_OpeningDemo = {

	Messages = {
		Timer = {
			{ data = "Timer_FadeInStart", message = "OnEnd", localFunc = "localFadeInStart" },
			{ data = "FaceLeftTimer", message = "OnEnd", localFunc = "funcFaceLeftTimer" },
			{ data = "FaceBackTimer", message = "OnEnd", localFunc = "funcFaceBackTimer" },
		},
		Trap = {
			
			{ data = "Trap_EnterMissionArea", 	message = { "Enter", "Exit" }, commonFunc = function() this.commonPlayerEnterMissionArea() end },
		},
		Demo = {
			
			{ data = "p12_020000_000", 	message = "Skip", localFunc = "SkipOpeningDemo" },
		},
	},

	funcFaceLeftTimer = function()
		
		TppPlayerUtility.SetDemoOnTruck( true )
	end,

	funcFaceBackTimer = function()

		
		TppPlayerUtility.StartForwardToFace( 1 )

		
		TppMission.SetFlag( "dbg_OpeningDemoSkipFlag", true )

	end,

	SkipOpeningDemo = function()
		
		if ( TppMission.GetFlag( "dbg_OpeningDemoSkipFlag" ) == false ) then




			TppMission.SetFlag( "isOpeningDemoSkip", true )

			
			TppPlayerUtility.StartForwardToFace( 1 )
		end
	end,

	OnEnter = function()

		
		TppPlayerUtility.SetStock( TppPlayer.StockDirectionLeft )

		
		GZCommon.isOutOfMissionEffectEnable = false

		
		TppEnemy.ChangeRoute( "gntn_cp", "e20030_DemoSoldier01", 	"e20030_routeSet_d01_basic01", "gntn_e20030_add_route0002", 0 )
		TppEnemy.ChangeRoute( "gntn_cp", "e20030_DemoSoldier02", 	"e20030_routeSet_d01_basic01", "gntn_e20030_add_route0003", 0 )
		TppEnemy.ChangeRoute( "gntn_cp", "e20030_DemoSoldier03", 	"e20030_routeSet_d01_basic01", "gntn_common_d01_route0009", 0 )

		TppDemoUtility.AddWaitCharacter("Player")
		TppDemoUtility.WaitPlayerReady()
		TppDemoUtility.SetCameraParameter()

		
		MissionManager.RegisterNotInGameRealizeCharacter( "Cargo_Truck_WEST_001" )	
		MissionManager.RegisterNotInGameRealizeCharacter( "e20030_Driver" )			

		TppDemo.Play( "Demo_Opening", {
										onStart = function()
											TppUI.FadeIn(0.7)
											
											TppPlayerUtility.RequestToAttachInDemo{ ownerId = "Cargo_Truck_WEST_001", connectPoint = "CNP_DECK_A", unattachOnSleep = false }

											MissionManager.RegisterNotInGameRealizeCharacter( "e20030_DemoSoldier01" )	
											MissionManager.RegisterNotInGameRealizeCharacter( "e20030_DemoSoldier02" )	
											MissionManager.RegisterNotInGameRealizeCharacter( "e20030_DemoSoldier03" )	
											TppVehicleUtility.ForceEngineOn("Cargo_Truck_WEST_001")
										end,
										onEnd 	= function() TppSequence.ChangeSequence( "Seq_MissionLoad" ) end } )

	end,

	
	localFadeInStart = function()



		TppUI.FadeIn(1)

		TppTimer.Start( "FaceLeftTimer", 15 )
		TppTimer.Start( "FaceBackTimer", 19.5 )	

		
	end,

	OnLeave = function()
	end,
}




this.Seq_MissionLoad = {

	
	Messages = {
		Trap = {
			
			{ data = "Trap_EnterMissionArea", 	message = { "Enter", "Exit" }, commonFunc = function() this.commonPlayerEnterMissionArea() end },
		},
	},

	OnEnter = function()
		
		

		commonUniqueCharaRouteSetup()

		
		

		
		
		
		this.commonOptionalRadioUpdate()

		
		this.commonRegisterIntelRadio()
		
		this.SetIntelRadio()

		
		this.commonUpdateCheckCameraIntelRadio()

		
		TppRadioConditionManagerAccessor.Register( "Tutorial", TppRadioConditionTutorialPlayer{ time = 1.5 } )
		TppRadioConditionManagerAccessor.Register( "Basic", TppRadioConditionPlayerBasic{ time = 0.3 } )

		
		commonUiMissionPhotoSetup()

		
		commonMissionSubGoalSetting( this.MissionSubGoal_Betrayer )

		
		this.commonBetrayerInterrogationRegister()

		
		this.CounterList.BetrayerInterrogationSet = "A"
		TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.BetrayerID, 0 )

		
		commonMarkerMissionSetup()

		TppSequence.ChangeSequence( "Seq_Waiting_BetrayerContact" )

		
		if ( TppMission.GetFlag( "isOpeningDemoSkip" ) == true ) then

			
			TppCharacterUtility.WarpCharacterIdFromIdentifier( "Cargo_Truck_WEST_001", "id_vipRestorePoint", "DemoSkip_WarpPos_Truck" )
			TppCommandPostObject.GsSetGroupVehicleRoute( "gntn_cp", "Cargo_Truck_WEST_001", "gntn_common_v01_route0010", 3 )

			
			TppCharacterUtility.WarpCharacterIdFromIdentifier( "e20030_DemoSoldier01", "id_vipRestorePoint", "DemoSkip_WarpPos_Soldier01" )
			TppCharacterUtility.WarpCharacterIdFromIdentifier( "e20030_DemoSoldier02", "id_vipRestorePoint", "DemoSkip_WarpPos_Soldier02" )

		
		end
	end,
}




this.Seq_TruckInfiltration = {
	Messages = {
		Trap = {
			
			{ data = "Trap_EnterMissionArea", 	message = { "Enter", "Exit" }, commonFunc = function() this.commonPlayerEnterMissionArea() end },
		},
	},

	OnEnter = function()

		TppPadOperatorUtility.SetMasksForPlayer( 0, "Hospital_Wait" )			

	end,

	OnLeave = function()

		TppPadOperatorUtility.ResetMasksForPlayer( 0, "Hospital_Wait" )			
	end,
}




this.Seq_Waiting_BetrayerContact = {

	
	checkingsOnThisSequence = {
		"CheckLookingTarget"
	},

	Messages = {
		Character = {
			
			{ data = this.AssistantID,	message= { "EnemyDead", "EnemySleep", "EnemyFaint"	},	localFunc = "OnDisablementAssistant" },
		},

		Terminal = {
			{ message = "MbDvcActWatchPhoto",	localFunc = "OnMbDvcActWatchPhoto" },
		},
		Trap = {
			
			{ data = "Trap_EnterMissionArea", 	message = { "Enter", "Exit" }, commonFunc = function() this.commonPlayerEnterMissionArea() end },
		},
		Timer = {
			{ data = "OpeningDemoSkipFadeInTimer", message = "OnEnd", localFunc = "OpeningDemoSKipFadeEnd" },
			
			{ data = "Timer_ListeningInfoFromBetrayer", message = "OnEnd", localFunc = "ListeningInfoFromBetrayerEnd" },
		},
		RadioCondition = {
			
			{ message = "EnableCQC", localFunc = "EnableCQC_Betrayer" },
		},
	},

	
	OnMbDvcActWatchPhoto = function()




		local PhotoID = TppData.GetArgument(1)

		
		if( PhotoID == 10 and TppMission.GetFlag( "OnPlay_MissionBriefingSub1" ) == false and
			TppMission.GetFlag( "isGetCassette_B" ) == false and
			TppMission.GetFlag( "listeningInfoFromBetrayer" ) == false ) then

			TppMission.SetFlag( "isPlayerCheckMbPhoto", true )

			TppTimer.Stop( "CheckTargetPhotoTimer" )	
			
			if ( TppMission.GetFlag( "isRadio_MissionBriefingSub2" ) == false ) then
				TppRadio.DelayPlay( "Radio_MarkingBetrayer4", "short", "begin", {	
					onEnd = function()
						
						if ( TppMission.GetFlag( "isRadio_MissionBriefingSub1_3" ) == false ) then
							
							if ( TppMission.GetFlag( "isRadio_MissionBriefingSub1" ) == false ) then
								
								
								local MissionBriefing1_15 = { "Radio_MissionBriefingSub1", "Radio_MissionBriefingSub1_5" }
								TppRadio.DelayPlayEnqueue( MissionBriefing1_15, "short", "end", {
									onEnd = function()
										TppMission.SetFlag( "isRadio_MissionBriefingSub1", true )
										TppMission.SetFlag( "isRadio_MissionBriefingSub1_3", true )
									end
								} )
							
							else
								
								
								TppRadio.DelayPlayEnqueue( "Radio_MissionBriefingSub1_5", "short", "end", {
									onEnd = function()
										TppMission.SetFlag( "isRadio_MissionBriefingSub1_3", true )
									end
								} )
							end
						
						elseif ( TppMission.GetFlag( "isRadio_MissionBriefingSub2" ) == false ) then
							TppRadio.DelayPlayEnqueue( "Radio_MissionBriefingSub2", "short", "end", {	
								onEnd = function() TppMission.SetFlag( "isRadio_MissionBriefingSub2", true ) end
							} )
						else
							
							TppSoundDaemon.PostEvent( "Play_sfx_s_codec_NPC_end" )
						end
					end
				} )
			end
		end
	end,

	
	OnDisablementAssistant = function( manager, messageId, arg0, arg1, arg2, arg3 )

		
		if ( TppMission.GetFlag( "isBetrayerMarking" ) and
			 TppMission.GetFlag( "isBetrayerTogether" ) and
			 ( TppEnemy.GetPhase("gntn_cp") == "sneak" )) then
			
			local radioGroup = {"Radio_DisablementAssistant", "Radio_MarkingBetrayer2" }
			TppRadio.Play( "Radio_DisablementAssistant" )
		end
	end,

	
	OpeningDemoSKipFadeEnd = function()
		

		
		TppRadio.DelayPlay( "Radio_MissionBriefing2", "short", "begin", {
			onEnd = function() CallMissionBriefingOnTruck() end		
		} )

	end,

	
	ListeningInfoFromBetrayerEnd = function()

		TppRadio.DelayPlay( "Radio_GetInfo_FromBetrayerOnHeli", "short", "both", {
						onEnd = function()
							
							TppSequence.ChangeSequence( "Seq_Waiting_GetCassette" )
						end
					} )
	end,

	
	EnableCQC_Betrayer = function()




		local CharaID = TppData.GetArgument(1)

		
		if ( CharaID == this.BetrayerID and TppMission.GetFlag( "isBetrayerMarking" ) == true ) then

			
			local enemyNum = TppEnemyUtility.GetNumberOfActiveSoldierByCharacterId( this.BetrayerID, this.Size_ActiveEnemy )

			if ( TppEnemy.GetPhase("gntn_cp") == "alert" ) then

				TppRadio.Play( "Radio_ContactNot_Phase")		
			else
				
				if ( enemyNum ~= 0 ) then
					TppRadio.Play( "Radio_ContactNot_NearEnemy1")
				end
			end


		end
	end,

	OnEnter = function( manager )

		this.commonPlayerEnterMissionArea()	

		TppMissionManager.SaveGame("40")	

		EspionageRadioController.SetEnable{ enable = true }
		
		this.SetIntelRadio()

		
		commonSearchTargetSetup( manager )


		
		if ( TppMission.GetFlag( "isOpeningDemoSkip" ) == true and this.CounterList.PlayerOnCargo ~= "NoRide" ) then
			TppTimer.Start( "OpeningDemoSkipFadeInTimer", 3 )

		else
			
			if ( this.CounterList.PlayerOnCargo ~= "NoRide" ) then
				
				CallMissionBriefingOnTruck()
			
			elseif ( TppMission.GetFlag("isSignalExecuted") == false and
					 TppMission.GetFlag("isGetCassette_B") == false ) then

				
				if ( TppMission.GetFlag("isSignalTurretDestruction") == false ) then




					
					TppRadio.EnableIntelRadio( "SL_WoodTurret04")
					
					TppRadio.DelayPlay( "Radio_MissionBriefing2", "mid", "begin", {
						onEnd = function()
							TppRadio.DelayPlay( "Radio_AboutSignal", "short", "end", {
								onEnd = function()
									if ( TppMission.GetFlag("isSignalTurretDestruction") == false ) then
										
										TppMarker.Enable( "e20030_marker_Signal", 0, "moving", "map_only_icon", 0, true, true )
										this.commonCallAnnounceLog( this.AnnounceLogID_MapUpdate )		
									end
								end
							} )
						end
					} )
				else
					
					TppMarker.Disable( "e20030_marker_Signal" )
					
					TppRadio.DisableIntelRadio( "SL_WoodTurret04")
					
					TppRadio.DelayPlay( "Radio_MissionBriefing2", "mid", "both" )
				end

				TppTimer.Stop( "CheckTargetPhotoTimer" )
				
				TppTimer.Start( "CheckTargetPhotoTimer", GZCommon.Time_HintPhotoCheck )
			
			elseif ( TppMission.GetFlag("isSignalCheckEventEnd") == true and
					 TppMission.GetFlag("isGetCassette_B") == false ) then
				
				TppRadio.DelayPlay( "Radio_MissionBriefing2", "mid", "both" )
			end
		end
	end,
}




this.Seq_BetrayerContactDemo = {

	Messages = {
		Character = {
		
		},
		Timer = {
			{ data = "InterpCameraToDemoTimer", message = "OnEnd", localFunc = "CameraDemoPlay" },
		},
	},

	
	CameraDemoPlay = function()
		
		TppEnemyUtility.ChangeStatus( this.BetrayerID, "Faint" )
		
		TppEnemyUtility.SetLifeFlagByCharacterId( this.BetrayerID, "NoRecoverFaint" )

		TppDemo.Play( "Demo_BetrayerContactCam",
					{
						onStart = function()
							TppEnemyUtility.ChangeStatus( this.BetrayerID, "EndCqc" )	
						end,
						onEnd = function()
							TppPadOperatorUtility.ResetMasksForPlayer( 0, "Hospital_Wait" )			
							TppSequence.ChangeSequence( "Seq_Waiting_GetCassette" )
						end },
					{ disableGame = false } )	
	end,

	OnEnter = function()

		
		MissionManager.RegisterNotInGameRealizeCharacter( "e20030_Betrayer" )

		TppMarker.Disable( this.BetrayerID )			

		
		TppMission.SetFlag( "isBetrayerContact", true )
		this.commonBetrayerInterrogationSetUpdate()	

		
		TppPlayerUtility.RequestStandAndKeepCqc()

		
		if ( TppMission.GetFlag( "isWarningMissionArea" ) == true ) then
				
				TppOutOfMissionRangeEffect.Disable( 1 )
				GZCommon.OutsideAreaVoiceEnd()
		end

		
		if (TppPlayerUtility.IsThereEnoughSpaceAroundPlayer(-2.5,2.5,-2.5,1.5) == false) then
			
			TppEnemyUtility.ChangeStatus( this.BetrayerID, "Faint" )
			
			TppEnemyUtility.SetLifeFlagByCharacterId( this.BetrayerID, "NoRecoverFaint" )

			TppDemo.Play( "Demo_BetrayerContact",
						{
							onStart = function()
								
								TppEnemyUtility.ChangeStatus( this.BetrayerID, "EndCqc" )

							end,
							onEnd = function()

								TppSequence.ChangeSequence( "Seq_Waiting_GetCassette" )
							end
						},
						{
							disableGame = false,			
							disablePlayerPad = false,		
						 } )
		else
			
			if ( this.CounterList.BetrayerRestraint ~= 0 ) then
			
			end
			TppDemoUtility.Setup("p12_020010_000")
			TppPlayerUtility.RequestToInterpCameraToDemo( "p12_020010_000",0.15,1.8)	

			TppPadOperatorUtility.SetMasksForPlayer( 0, "Hospital_Wait" )			

			TppTimer.Start( "InterpCameraToDemoTimer", 1.8 )

		end

		
		TppTimer.Stop( "BetrayerContactCheckTimer" )

		
		TppTimer.Stop( "CheckTargetPhotoTimer" )
	end,

	OnLeave = function()

		TppUI.FadeIn( 1 )		

		
		if ( TppMission.GetFlag( "isWarningMissionArea" ) == true ) then
				
				TppOutOfMissionRangeEffect.Enable( 1 )
				GZCommon.OutsideAreaVoiceStart()
		end

		
		this.commonCallAnnounceLog( this.AnnounceLogID_Contact )

		
		TppEnemyUtility.UnsetLifeFlagByCharacterId( this.BetrayerID, "NoRecoverFaint" )

		
		TppRadio.DisableIntelRadio( "e20030_Betrayer")

		
		TppEnemyUtility.ForgetDamageFacts( this.BetrayerID )

	end,
}




this.Seq_Waiting_GetCassette = {

	
	checkingsOnThisSequence = {
		"CheckLookingTarget"
	},

	Messages = {
	},

	OnEnter = function( manager )

		
		this.commonSwitchSneakRouteSet()

		
		TppCommandPostObject.GsSetRealizeFirstPriority( "gntn_cp", this.AssistantID, false )

		
		if ( TppMission.GetFlag( "listeningInfoFromBetrayer" ) == true ) then
			
			TppMission.SetFlag( "listeningInfoFromBetrayer", false )

			TppMarker.Disable( this.BetrayerID )			

			
			TppMission.SetFlag( "isBetrayerContact", true )

			
			this.commonCallAnnounceLog( this.AnnounceLogID_MapUpdate )

		else
			
			TppMarker.Enable( this.BetrayerID, 0, "moving", "map_only_icon", 0, true )

			
			local commonDataManager = UiCommonDataManager.GetInstance()
			if commonDataManager == NULL then
				return
			end

			local luaData = commonDataManager:GetUiLuaExportCommonData()
			if luaData == NULL then
				return
			end

			luaData:RegisterIconUniqueInformation( { markerId= this.BetrayerID, langId="marker_info_agent" })

			TppMission.SetFlag( "isBetrayerMarking", true )

			
			if ( TppMission.GetFlag("isGetCassette_B") == false ) then
				
				TppRadio.DelayPlay( "Radio_BetrayerContact","mid", { onEnd = function() this.commonCallAnnounceLog( this.AnnounceLogID_MapUpdate ) end } )
			else
				
				TppRadio.DelayPlay( "Radio_RecommendEscape", "mid" )	
			end

		end

		
		this.commonSetCompleteMissionPhoto()

		TppMarker.Disable( "e20030_marker_Signal" )	
		TppMarker.Enable( "e20030_marker_Cassette", 0, "moving", "all", 0, true, true )	
		TppMarkerSystem.EnableMarker{ markerId = "e20030_marker_Cassette", viewType = { "VIEW_MAP_ICON", "VIEW_WORLD_GOAL" } }

		
		local commonDataManager = UiCommonDataManager.GetInstance()
		if commonDataManager == NULL then
			return
		end

		local luaData = commonDataManager:GetUiLuaExportCommonData()
		if luaData == NULL then
			return
		end

		luaData:RegisterIconUniqueInformation( { markerId= "e20030_marker_Cassette", langId="marker_info_item_tape" })

		
		
		TppRadio.RegisterIntelRadio( "intel_e0030_rtrg0065", "e0030_esrg0065", true )	
		TppRadio.DisableIntelRadio( "intel_f0090_esrg0140")

		
		this.SetIntelRadio()

		
		this.commonOptionalRadioUpdate()

		
		this.commonUpdateCheckEnemyIntelRadio()

		
		this.commonUpdateCheckCameraIntelRadio()

		
		this.commonSequenceSaveIndefinite()

		
		this.commonBetrayerInterrogationRegister()

		
		this.commonUpdateMissionDescription()

		
		if ( TppMission.GetFlag("isGetCassette_B") == false ) then
			
			commonMissionSubGoalSetting( this.MissionSubGoal_Cassette )
		end

		
		this.commonCallAnnounceLog( this.AnnounceLogID_InfoUpdate )

		
		commonSearchTargetSetup( manager )

	end,

	OnLeave = function()
		TppMarker.Disable( "e20030_marker_Cassette" )
	end,
}




this.Seq_Escape_CameraActive = {

	
	checkingsOnThisSequence = {
		"CheckLookingTarget"
	},

	Messages = {
		Trap = {
			
		
		},
	},

	OnEnter = function( manager )
		this.commonOptionalRadioUpdate()

		
		

		
		this.commonBetrayerInterrogationRegister()

		
		commonMissionSubGoalSetting( this.MissionSubGoal_Escape )

		
		this.commonCallAnnounceLog( this.AnnounceLogID_InfoUpdate )

		TppMissionManager.SaveGame("30")	

		
		this.SetIntelRadio()

		
		commonSearchTargetSetup( manager )
	end,

	FuncInspection_CameraActive = function()

		local InspectionFunc = {
			onStart = function()
				
				this.commonCallAnnounceLog( this.AnnounceLogID_Inspection )
			end,
			onEnd = function()
				
				this.commonCallAnnounceLog( this.AnnounceLogID_MapUpdate )

				TppMarker.Enable( "TppMarkerLocator_EscapeWest", 0, "moving", "all", 0, false, true )	
				TppMarker.Enable( "TppMarkerLocator_EscapeNorth", 0, "moving", "all", 0, false, true )	

				
				TppMission.SetFlag( "isInspectionActive", true )

				
				this.commonOptionalRadioUpdate()
			end,
		}

		
		TppRadio.DelayPlay( "Radio_Inspection", "mid", "both", InspectionFunc )

	end,

}




this.Seq_Escape_CameraBroken = {

	
	checkingsOnThisSequence = {
		"CheckLookingTarget"
	},

	Messages = {
		Trap = {
			
		
		},
	},

	OnEnter = function( manager )
		this.commonOptionalRadioUpdate()

		

		
		

		
		this.commonBetrayerInterrogationRegister()

		
		commonMissionSubGoalSetting( this.MissionSubGoal_Escape )

		
		this.commonCallAnnounceLog( this.AnnounceLogID_InfoUpdate )

		TppMissionManager.SaveGame("30")	

		
		this.SetIntelRadio()

		
		commonSearchTargetSetup( manager )
	end,

	FuncInspection_CameraBroken = function()

		local EscapeFunc = {
			onEnd = function()
				
				this.commonCallAnnounceLog( this.AnnounceLogID_MapUpdate )

				TppMarker.Enable( "TppMarkerLocator_EscapeWest", 0, "moving", "all", 0, false, true )	
				TppMarker.Enable( "TppMarkerLocator_EscapeNorth", 0, "moving", "all", 0, false, true )	
			end,
		}

		
		TppRadio.DelayPlay( "Radio_EscapeWay", "mid", "both", EscapeFunc )

	end,

}



this.Seq_PlayerRideHelicopter = {



	Messages = {
		Character = {
			{ data = "SupportHelicopter",		message = "CloseDoor",		localFunc = "FuncCloseDoor" },	
		},
	},

	OnEnter = function()
		

	end,

	FuncCloseDoor = function()

		
		if ( TppMission.GetFlag("isGetCassette_A") == true or TppMission.GetFlag("isGetCassette_B") == true ) then


			this.commonMissionClearRequest( "RideHeli_Clear" )

		else

			TppMission.ChangeState( "failed", "RideHeli_Failed" )
		end
	end,

}



this.Seq_PlayerEscapeMissionArea = {

	MissionState = "clear",

	Messages = {
		Timer = {
			{ data = "MissionClearProductionTimer",	message = "OnEnd", 	localFunc="OnFinishMissionClearProduction" },
		},
	},

	
	OnFinishMissionClearProduction = function()




		TppSequence.ChangeSequence( "Seq_MissionClearShowTransition" )	
	end,

	OnEnter = function()

		

		
		if ( this.CounterList.PlayerOnCargo ~= "NoRide" ) then
			Trophy.TrophyUnlock( this.TrophyId_e20030_CargoClear )
		end

		
		
		TppTimer.Start( "MissionClearProductionTimer", GZCommon.FadeOutTime_MissionClear )

	end,

}



this.Seq_MissionClearDemo = {

	MissionState = "clear",

	OnEnter = function()
		
	end,
}




this.Seq_MissionClearShowTransition = {

	MissionState = "clear",

	Messages = {
		UI = {
			
			{ message = "EndMissionTelopFadeIn" ,	localFunc = "OnFinishClearFade" },
			
			{ message = "EndMissionTelopRadioStop",	commonFunc = function() PlatformConfiguration.SetVideoRecordingEnabled( false ) end },
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
				TppSequence.ChangeSequence( "Seq_MissionClear" )
			end,
		}

		TppUI.ShowTransitionWithFadeOut( "ending", TelopEnd, 2 )

		
		TppRadioConditionManagerAccessor.Unregister( "Tutorial" )
		TppRadioConditionManagerAccessor.Unregister( "Basic" )
	end,

}




this.Seq_MissionClear = {

	MissionState = "clear",

	OnEnter = function()




		PlatformConfiguration.SetShareScreenEnabled(false) 

		
		SubtitlesCommand.SetIsEnabledUiPrioStrong( true )

		
		if ( TppMission.GetFlag("isGetCassette_B") == false ) then

			
			TppRadio.Play( "Radio_BlackCall_Cassette_A", {
				onStart = function() TppMusicManager.PostJingleEvent( 'SingleShot', 'Set_Switch_bgm_gntn_ed_default_lp' ) end,
				onEnd = function()
					TppSequence.ChangeSequence( "Seq_ShowClearReward" )	
				end
			}, nil, nil, "none" )
		else
			
			TppRadio.Play( "Radio_BlackCall_Cassette_B", {
				onStart = function() TppMusicManager.PostJingleEvent( 'SingleShot', 'Set_Switch_bgm_gntn_ed_default_lp' ) end,
				onEnd = function()
					TppSequence.ChangeSequence( "Seq_ShowClearReward" )	
				end
			}, nil, nil, "none" )

		end
	end,

	OnUpdate = function()
		
		local hudCommonData = HudCommonDataManager.GetInstance()
		if hudCommonData:IsPushRadioSkipButton() == true then
			
			
			local radioDaemon = RadioDaemon:GetInstance()
			radioDaemon:StopDirect()
			TppSequence.ChangeSequence( "Seq_ShowClearReward" )
		end
	end,
}


this.Seq_MissionAbort = {

	OnEnter = function()
		
		TppMission.ChangeState( "abort" )
		

		TppSequence.ChangeSequence( "Seq_MissionEnd" )
	end,
}


this.Seq_MissionFailed = {

	
	MissionState = "failed",

	Messages = {
		Timer = {
			{ data = "MissionFailedProductionTimer",	message = "OnEnd", 	localFunc="OnFinishMissionFailedProduction" },
		},
	},

	
	OnFinishMissionFailedProduction = function()




		TppSequence.ChangeSequence( "Seq_MissionGameOver" )
	end,


	OnEnter = function( manager )




		
		TppTimer.Start( "MissionFailedProductionTimer", this.CounterList.GameOverFadeTime )

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


this.Seq_MissionEnd = {

	
	
	OnEnter = function()

		
		this.commonMissionCleanUp()

		
		TppMusicManager.PostJingleEvent( "SingleShot", "Stop_bgm_gntn_ed_default" )

		
		local uiCommonData = UiCommonDataManager.GetInstance()
		uiCommonData:ShowAllCassetteTapes()

		TppMissionManager.SaveGame()	
		
		TppMission.ChangeState( "end" )
		
		PlatformConfiguration.SetVideoRecordingEnabled( true )
	end,
}





this.OnSkipEnterCommon = function( manager )



	local sequence = TppSequence.GetCurrentSequence()

	
	if( TppSequence.IsGreaterThan( sequence, "Seq_MissionPrepare" ) ) then
		this.onMissionPrepare( manager )
	end

	
	if( TppSequence.IsGreaterThan( sequence, "Seq_MissionFailed" ) ) then
		TppMission.ChangeState( "failed" )
	elseif( TppSequence.IsGreaterThan( sequence, "Seq_MissionAbort" ) ) then
		TppMission.ChangeState( "abort" )
	elseif( TppSequence.IsGreaterThan( sequence, "Seq_MissionClear" ) ) then
		TppMission.ChangeState( "clear" )
	elseif( TppSequence.IsGreaterThan( sequence, "Seq_MissionPrepare" ) ) then
		
		commonDemoBlockSetup()
	elseif( sequence == "Seq_MissionPrepare" ) then
		
		commonDemoBlockSetup()
	end

	
	if( sequence == "Seq_Waiting_GetCassette" ) then

	end
end


this.OnSkipUpdateCommon = function( manager )



	return IsDemoAndEventBlockActive()	
end


this.OnSkipLeaveCommon = function( manager )



	local sequence = TppSequence.GetCurrentSequence()

	
	if( TppSequence.IsGreaterThan( sequence, "Seq_MissionLoad" ) ) then

		onCommonMissionSetup()

		
		this.commonOptionalRadioUpdate()

		
		this.commonRegisterIntelRadio()

		
		TppRadioConditionManagerAccessor.Register( "Tutorial", TppRadioConditionTutorialPlayer{ time = 1.5 } )
		TppRadioConditionManagerAccessor.Register( "Basic", TppRadioConditionPlayerBasic{ time = 0.3 } )

		
		commonUiMissionPhotoSetup()

		
		this.commonBetrayerInterrogationSetUpdate()

		
		this.commonBetrayerInterrogationRegister()

		
		commonMarkerMissionSetup()

		
		if ( TppMission.GetFlag("isWavActivate") == true and TppMission.GetFlag("isWavBroken") == false ) then
			this.commonCheckActivateWav()
		end

		
		commonRouteSetMissionSetup( "e20030_routeSet_d01_basic01" )

	end

	
	if ( TppMission.GetFlag("isBetrayerContact") == true ) then
		
		TppRadio.DisableIntelRadio( "e20030_Betrayer")

		
		
		this.commonUpdateMissionDescription()

	elseif (  TppMission.GetFlag("isBetrayerMarking") == true ) then
		
		TppRadio.RegisterIntelRadio( this.BetrayerID, "e0030_esrg0020", true )	
	end
	
	if ( TppMission.GetFlag("isBetrayerContact") == true and  TppMission.GetFlag("isGetCassette_A") == false ) then
		TppRadio.RegisterIntelRadio( "intel_e0030_rtrg0065", "e0030_esrg0065", true )	
		TppRadio.DisableIntelRadio( "intel_f0090_esrg0140")
	else
		TppRadio.RegisterIntelRadio( "intel_e0030_rtrg0065", "f0090_esrg0140", true )	
	end

	if (  TppMission.GetFlag("isBetrayerMarking") == true ) then
		
		local commonDataManager = UiCommonDataManager.GetInstance()
		if commonDataManager == NULL then
			return
		end

		local luaData = commonDataManager:GetUiLuaExportCommonData()
		if luaData == NULL then
			return
		end

		luaData:RegisterIconUniqueInformation( { markerId= this.BetrayerID, langId="marker_info_agent" })
	end

	
	if ( TppMission.GetFlag( "BetrayerArea" ) == this.Area_WareHouse ) then
		
		TppMission.RegisterVipRestorePoint( this.BetrayerID, "BetrayerRestorePoint_WareHouse" )

	elseif ( TppMission.GetFlag( "BetrayerArea" ) == this.Area_campEast ) then
		
		TppMission.RegisterVipRestorePoint( this.BetrayerID, "BetrayerRestorePoint_campEast" )

	elseif ( TppMission.GetFlag( "BetrayerArea" ) == this.Area_Heliport ) then
		
		TppMission.RegisterVipRestorePoint( this.BetrayerID, "BetrayerRestorePoint_HeliPort" )

	elseif ( TppMission.GetFlag( "BetrayerArea" ) == this.Area_campWest ) then
		
		TppMission.RegisterVipRestorePoint( this.BetrayerID, "BetrayerRestorePoint_campWest" )

	else
		
		TppMission.RegisterVipRestorePoint( this.BetrayerID, "BetrayerRestorePoint_WareHouse" )

	end

	
	TppMission.RegisterVipRestorePoint( "Cargo_Truck_WEST_001", "TruckRestorePoint" )

	
	if ( sequence == "Seq_Waiting_BetrayerContact" ) then
		
		if ( TppMission.GetFlag("isGetCassette_B") == true ) then
			
			
			GZCommon.isOutOfMissionEffectEnable = false











			TppRadio.DelayPlay( "Radio_RecommendEscape", "mid" )	

		elseif ( TppMission.GetFlag("isSignalExecuted") == true and
			 TppMission.GetFlag("isSignalCheckEventEnd") == false and
			 TppMission.GetFlag("isSignalTurretDestruction") == false and
			 TppMission.GetFlag("isGetCassette_B") == false ) then





			
			if ( TppMission.GetFlag( "isPlayerInWestCamp" ) == true ) then
				TppRadio.DelayPlay( "Radio_RunSignal", "mid" )
			else
				TppRadio.DelayPlay( "Radio_MissionBriefing2", "mid" )
			end
			
			TppMission.RegisterVipRestorePoint( this.BetrayerID, "BetrayerRestorePoint_SignalCheck" )
			TppMission.RegisterVipRestorePoint( this.AssistantID, "BetrayerRestorePoint_SignalCheck" )	

		
		elseif ( TppMission.GetFlag("isSignalExecuted") == false and
				 TppMission.GetFlag("isSignalTurretDestruction") == false and
				 TppMission.GetFlag("isGetCassette_B") == false ) then




			
			
			
			TppRadio.EnableIntelRadio( "SL_WoodTurret04")
		end

		
		commonMissionSubGoalSetting( this.MissionSubGoal_Betrayer )

	elseif ( sequence == "Seq_Waiting_GetCassette" ) then

		
		local commonDataManager = UiCommonDataManager.GetInstance()
		if commonDataManager ~= NULL then
			local luaData = commonDataManager:GetUiLuaExportCommonData()
			if luaData ~= NULL then
				
				luaData:SetMisionInfoCurrentStoryNo(1)									
			end
		end

		
		commonMissionSubGoalSetting( this.MissionSubGoal_Cassette )

	end

	
	if ( TppMission.GetFlag("isGetCassette_A") == true or
		 TppMission.GetFlag("isGetCassette_B") == true ) then

		
		commonMissionSubGoalSetting( this.MissionSubGoal_Escape )

		
		GZCommon.isOutOfMissionEffectEnable = false

		
		if ( TppMission.GetFlag("isInspectionActive") == true ) then
			
			this.commonInspectionObjectON()
			
			TppData.Enable( "Cargo_Truck_WEST_003" )
		end

	end

	
	if ( TppMission.GetFlag("isDropCassette_B") == true ) then
		
		TppEnemyUtility.SetInterrogationCountAndUnsetDoneByCharacterId( this.MastermindID, 1 )
	end

end




this.OnAfterRestore = function()




	
	
	

	local sequence = TppSequence.GetCurrentSequence()
	local RouteSetName

	
	if( TppSequence.IsGreaterThan( sequence, "Seq_Waiting_BetrayerContact" ) ) then

		RouteSetName = "e20030_routeSet_d01_basic02"
	else

		RouteSetName = "e20030_routeSet_d01_basic01"
	end

	
	GZCommon.CheckContinueHostageRegister( this.ContinueHostageRegisterList )

	
	commonRouteSetMissionSetup( RouteSetName )

	
	this.commonHostageIntelCheck("Hostage_e20030_000")
	this.commonHostageIntelCheck("Hostage_e20030_001")
	this.commonHostageIntelCheck("Hostage_e20030_002")

	
	
	TppCommandPostObject.GsSetRealizeFirstPriority( "gntn_cp", this.BetrayerID, true )

	
	this.ChangeAssistantRoute( RouteSetName, "gntn_e20030_ast_route0000", 58 )

	
	TppRadio.RestoreIntelRadio()

	
	if ( TppMission.GetFlag( "BetrayerArea" ) == this.Area_WareHouse ) then
		
		TppCharacterUtility.WarpCharacterIdFromIdentifier( this.BetrayerID, "id_vipRestorePoint", "BetrayerRestorePoint_WareHouse" )
		
		this.ChangeBetrayerRoute( RouteSetName, "gntn_e20030_tgt_route0000", 0 )

	elseif ( TppMission.GetFlag( "BetrayerArea" ) == this.Area_campEast ) then
		
		TppCharacterUtility.WarpCharacterIdFromIdentifier( this.BetrayerID, "id_vipRestorePoint", "BetrayerRestorePoint_campEast" )
		
		this.ChangeBetrayerRoute( RouteSetName, "gntn_e20030_tgt_route0001", 5 )

	elseif ( TppMission.GetFlag( "BetrayerArea" ) == this.Area_Heliport ) then
		
		TppCharacterUtility.WarpCharacterIdFromIdentifier( this.BetrayerID, "id_vipRestorePoint", "BetrayerRestorePoint_HeliPort" )
		
		this.ChangeBetrayerRoute( RouteSetName, "gntn_e20030_tgt_route0002", 8 )

	elseif ( TppMission.GetFlag( "BetrayerArea" ) == this.Area_campWest ) then



		
		TppCharacterUtility.WarpCharacterIdFromIdentifier( this.BetrayerID, "id_vipRestorePoint", "BetrayerRestorePoint_campWest" )

	else
		
		TppCharacterUtility.WarpCharacterIdFromIdentifier( this.BetrayerID, "id_vipRestorePoint", "BetrayerRestorePoint_WareHouse" )
		this.ChangeBetrayerRoute( RouteSetName, "gntn_e20030_tgt_route0000", 0 )
	end


	
	if( TppSequence.IsGreaterThan( sequence, "Seq_Waiting_BetrayerContact" ) ) then
		
		if ( TppMission.GetFlag("isMastermindConversationEnd") == false ) then
			
			this.commonSwitchMastermindConversation()
			if ( TppMission.GetFlag( "BetrayerArea" ) == this.Area_campWest ) then



				
				TppCharacterUtility.WarpCharacterIdFromIdentifier( this.BetrayerID, "id_vipRestorePoint", "BetrayerRestorePoint_campWest" )
			end

		else
			
			TppEnemy.EnableRoute( "gntn_cp", "gntn_e20030_mst_route0000" )
			TppEnemy.ChangeRoute( "gntn_cp", this.MastermindID,	RouteSetName, "gntn_e20030_mst_route0000", 0 )
		end

		
		if ( TppMission.GetFlag( "isCameraAlert" ) == true ) then
			
			this.commonStartForceSerching()
		end

	else
		
		if ( sequence == "Seq_Waiting_BetrayerContact" ) then
			
			if ( TppMission.GetFlag("isSignalExecuted") == true and
				 TppMission.GetFlag("isSignalCheckEventEnd") == false and
				 TppMission.GetFlag("isSignalTurretDestruction") == false ) then




					
					TppCharacterUtility.WarpCharacterIdFromIdentifier( this.BetrayerID, "id_vipRestorePoint", "BetrayerRestorePoint_SignalCheck" )
					TppCharacterUtility.WarpCharacterIdFromIdentifier( this.AssistantID, "id_vipRestorePoint", "BetrayerRestorePoint_SignalCheck" )
					
					this.ChangeSignalCheckRoute( "Continue" )
			end
		end
	end

	
	if ( TppMission.GetFlag("isGetCassette_A") == true or
		 TppMission.GetFlag("isGetCassette_B") == true ) then

		
		if ( TppMission.GetFlag("isInspectionActive") == true ) then
			TppData.Disable( "Cargo_Truck_WEST_001" )	
			
			TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0027" )
			TppEnemy.EnableRoute( "gntn_cp", "gntn_common_d01_route0032" )
			TppEnemy.ChangeRoute( "gntn_cp", "e20030_Driver", 	RouteSetName, "gntn_common_d01_route0032", 0 )

			
			TppEnemy.DisableRoute( "gntn_cp", "gntn_common_d01_route0029" )
			TppEnemy.EnableRoute( "gntn_cp", "gntn_common_d01_route0033" )
			TppEnemy.ChangeRoute( "gntn_cp", "e20030_enemy022", 	RouteSetName, "gntn_common_d01_route0033", 0 )
		end
	end

end




return this
