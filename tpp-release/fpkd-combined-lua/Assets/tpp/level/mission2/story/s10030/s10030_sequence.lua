local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local sequences = {}

if DEBUG then	
this.DEBUG_strCode32List = {
	 "p31_010060",
	 "p31_010070",
	 "p51_010500",

	"CalcFultonPercent",
	"CalcDogFultonPercent",
	"RideHelicopter",
	"PlayerFulton",
	"OnPickUpCollection",
	"OnPickUpPlaced",
	"WarpEnd",
	"LandingFromHeli",
}
end	





this.MISSION_START_INITIAL_WEATHER  = TppDefine.WEATHER.SUNNY


this.NO_TACTICAL_TAKE_DOWN = true
this.NO_MISSION_CLEAR_RANK = true
this.NO_PLAY_STYLE = true
this.EQUIP_MISSION_BLOCK_GROUP_SIZE = 1520000



local DEVELOP_LV_BOX = 1 

local STAFF_MAX =14 


local DISTANCE_APPROACH = 255	
local DISTANCE_APPROACH_OCELOT = 36	
local DISTANCE_CLOSE = 9	
local DISTANCE_TOO_CLOSE = 3	
local DISTANCE_APPROACH_DD_SOLDIER = 16	
local DISTANCE_APPROACH_DD_SOLDIER_LONG = 64	

local DISTANCE_APPROACH_FIRST_FULTON = 150	


local TIMER_TIME = 60
local TIMER_GOODBYE = 3
local TIMER_GOODBYE_OCELOT = 1

local TIMER_RAPID_ATTACK_FULTON = 2
local TIMER_TIPS_SUPPLY = 3
local TIMER_TIPS_AGAIN = 8


local TIMER_TIME_WAIT_TO_WAIT = 15	
local TIMER_TIME_TALK = 30	
local TIMER_TIME_BEFORE_FULTON_DEMO = 15	
local TIMER_TIME_FULTON_AGAIN = 15	

local TIMER_FULTON = 10	
local TIMER_EXTRA_TUTORIAL = 180	


local TIMER_FADE_DEMOTODEMO = 2	
local TIMER_WAIT_OPEN_TERMINAL = 15	
local TIMER_WAIT_DELAY_MONOLOGUE = 1.2	
local TIMER_WAIT_DELAY_MONOLOGUE_LONG = 1.5	
local TIMER_WAIT_DELAY_FULTON_START = 2	

local TIMER_DEVELOP_GAUGE	=2.5	
local TIMER_RAPID_CQC	=2.5	


local TIME_ON_DEMO_AFTER_PAZ_RESQUE = "10:00:00"
local TIME_ON_DEMO_ARRIVE_AT_DD = "11:00:00"

local PLAYER_POSITION = Tpp.Enum{
	"PLANT_LOWER",
	"PLANT_UPPER_EAST",
	"PLANT_UPPER_WEST",
}

local RESTART_SEQUENCE = Tpp.Enum{
	"ARRIVE_AT_MB",
	"GIVEN_FULTON",
	"CLEAR_DEVELOP_TUTORIAL",
	"CLEAR_HANG_TUTORIAL",
}

local TUTORIAL_RESULT = Tpp.Enum{
	"NOREACTION",
	"FAILED",
	"SUCCESS",
}

this.OCELOT_TALK_PROCESS	=	Tpp.Enum{	
	"WAITING_1",	
	"TALKING_1",	
	"WAITING_2",	
	"TALKING_2",	
	"WAITING_3",	
	"TALKING_3",	
	"WAITING_4",	
	"TALKING_4",	
	"WAITING_5",	
	"TALKING_5",	
	"WAITING_6",	
	"TALKING_6",	
	"WAITING_7",	
	"TALKING_7",	
	"WAITING_8",	
	"TALKING_8",	
	"WAITING_9",	
	"TALKING_9",	
	"TALK_END",			
}



local PLAYER_DISABLE = {
	ARRIVE_AT_DD = PlayerDisableAction.FULTON + PlayerDisableAction.RUN + PlayerDisableAction.CQC_KNIFE_KILL + PlayerDisableAction.CQC_INTERROGATE+ PlayerDisableAction.KILLING_WEAPON +PlayerDisableAction.TIME_CIGARETTE,
	FIRST_TALK = PlayerDisableAction.FULTON + PlayerDisableAction.CQC_KNIFE_KILL + PlayerDisableAction.CQC_INTERROGATE+ PlayerDisableAction.KILLING_WEAPON +PlayerDisableAction.TIME_CIGARETTE,
	GIVEN_FULTON = PlayerDisableAction.CQC_KNIFE_KILL + PlayerDisableAction.CQC_INTERROGATE+ PlayerDisableAction.KILLING_WEAPON +PlayerDisableAction.TIME_CIGARETTE,

	CLEAR_DEVELOP_TUTORIAL = PlayerDisableAction.CQC_KNIFE_KILL+ PlayerDisableAction.KILLING_WEAPON + PlayerDisableAction.CQC_INTERROGATE+PlayerDisableAction.TIME_CIGARETTE,
	CLEAR_HANG_TUTORIAL = PlayerDisableAction.CQC_KNIFE_KILL+ PlayerDisableAction.KILLING_WEAPON +PlayerDisableAction.TIME_CIGARETTE,
}

local ddSoldiersTable = {
	TUTORIAL_FULTON_00 = {
		NAME = "sol_plant0_0002",
		ROUTE_TUTORIRAL = "rts_dd_stnd0000",
		ROUTE_FIGHT = "rts_dd_fight0000",
	},
	TUTORIAL_CQC_10 = {
		NAME = "sol_plant0_0001",
		ROUTE_TUTORIRAL = "rts_dd_stnd0001",
		ROUTE_FIGHT = "rts_dd_fight0001",
	},
	TUTORIAL_CQC_15 = {
		NAME = "sol_plant0_0000",
		ROUTE_TUTORIRAL = "rts_dd_stnd0002",
		ROUTE_FIGHT = "rts_dd_fight0002",
	},
	TUTORIAL_CQC_20 = {
		NAME = "sol_plant0_0003",
		ROUTE_TUTORIRAL = "rts_dd_stnd0003",
		ROUTE_FIGHT = "rts_dd_fight0003",
	},
	TUTORIAL_CQC_30 = {
		NAME = "sol_plant0_0004",
		ROUTE_TUTORIRAL = "rts_dd_stnd0004",
		ROUTE_FIGHT = "rts_dd_fight0004",
	},
	TUTORIAL_CQC_40 = {
		NAME = "sol_plant0_0005",
		ROUTE_TUTORIRAL = "rts_dd_stnd0005",
		ROUTE_FIGHT = "rts_dd_fight0005",
	},
}


local TUTORIAL_WRONG_ACTION_LIST = {
	TppDamage.ATK_CqcHit,
	TppDamage.ATK_CqcHitFinish,
	TppDamage.ATK_CqcFinish,
	TppDamage.ATK_CqcHang,
	TppDamage.ATK_CqcChoke,
	TppDamage.ATK_CqcThrow,
	TppDamage.ATK_CqcThrowWall,
	TppDamage.ATK_CqcThrowBehind,
	TppDamage.ATK_CqcThrowLadder,
	TppDamage.ATK_CqcContinuous2nd,
	TppDamage.ATK_CqcContinuousOver3Times,
	TppDamage.ATK_CqcKill,
}


local SOLDIER_GROUP = {
	"sol_plant0_0000",
	"sol_plant0_0001",
	"sol_plant0_0002",
	"sol_plant0_0003",
	"sol_plant0_0004",
	"sol_plant0_0005",
	"sol_plant0_0006",
	"sol_plant0_0007",
	"sol_plant0_0008",
	"sol_plant0_0009",
	"sol_plant0_0010",
	"sol_plant0_0011",
	"sol_reserve_0000",
	"sol_reserve_0001",
	nil
}


local SOLDIER_STAFF_ID_GROUP={
	[1]		=	TppDefine.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_01,
	[2]		=	TppDefine.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_02,
	[3]		=	TppDefine.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_03,
	[4]		=	TppDefine.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_04,
	[5]		=	TppDefine.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_05,
	[6]		=	TppDefine.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_06,
	[7]		=	TppDefine.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_07,
	[8]		=	TppDefine.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_08,
	[9]		=	TppDefine.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_09,
	[10]		=	TppDefine.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_10,
	[11]		=	TppDefine.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_11,
	[12]		=	TppDefine.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_12,
	[13]		=	TppDefine.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_13,
	[14]		=	TppDefine.UNIQUE_STAFF_TYPE_ID.FULTON_LESSON_STAFF_14,

}


local FOCUS_TEST_1 = true






function this.OnLoad()
	Fox.Log("#### OnLoad ####")

	TppSequence.RegisterSequences{
		
		"Seq_Demo_AfterPazResque",
		"Seq_Demo_ArriveAtDD",
		
		"Seq_Game_ApproachOcelot",
		"Seq_Demo_BeforeOcelotGiveFulton",
		"Seq_Demo_OcelotGiveFulton",
		"Seq_Demo_AfterOcelotGiveFulton",
		"Seq_Game_FultonASodier",
		"Seq_Game_TutorialDevelop10",
		"Seq_Game_TutorialCQC10",
		"Seq_Game_TutorialCQC15",
		"Seq_Game_TutorialDevelop20",
		"Seq_Game_ForSkipFollowTutorialDevelop20",
		"Seq_Game_AfterTutorialDevelop20",
		"Seq_Game_ClearTutorialDevelop",
		"Seq_Game_Before1TutorialCQC20",
		"Seq_Game_Before2TutorialCQC20",
		"Seq_Game_TutorialCQC20",
		"Seq_Game_TutorialCQC30",
		"Seq_Game_CQCTutAllClear",
		"Seq_Game_MissionClear",
		nil
	}
	TppSequence.RegisterSequenceTable(sequences)
end






this.saveVarsList = {
	restartSeq = 0,
	isArrivAtMB = false,
	isGivenFulton = false,
	isClearDevelopTutorial = false,
	isClearAllTutorial = false,
	isOcelotBoxHit =false,
	isSleepBulletEmpty = false,
	FulltonCount = 0 ,
	FultonFailedCount = 0 ,
	isSoldierDown = false,
	isHearedFultonSucessRate = false,	
	LastFultonCount		=0,	

	isFulton_sol_plant0_0000 = false,	
	isFulton_sol_plant0_0001 = false,
	isFulton_sol_plant0_0002 = false,
	isFulton_sol_plant0_0003 = false,
	isFulton_sol_plant0_0004 = false,
	isFulton_sol_plant0_0005 = false,
	isFulton_sol_plant0_0006 = false,
	isFulton_sol_plant0_0007 = false,
	isFulton_sol_plant0_0008 = false,
	isFulton_sol_plant0_0009 = false,
	isFulton_sol_plant0_0010 = false,
	isFulton_sol_plant0_0011 = false,
	isFulton_sol_reserve_0000 = false,
	isFulton_sol_reserve_0001 = false,



	isFultonFirstSoldier =false,	
	isFultonSecondSoldier =false,	
	latestGMP	=	30000,	
	
	isReserve_01 = false,	
	isReserve_02 = false,	
	isReserve_03 = false,	
	isReserve_04 = false,	
	isReserve_05 = false,	
	isReserve_06 = false,	
	isReserve_07 = false,	
	isReserve_08 = false,	
	isReserve_09 = false,	
	isReserve_10 = false,	
	isReserve_11 = false,	
	isReserve_12 = false,	
	isReserve_13 = false,	
	isReserve_14 = false,	
	isReserve_15 = false,
	isReserve_16 = false,
	isReserve_17 = false,
	isReserve_18 = false,
	isReserve_19 = false,
	isReserve_20 = false,

	ldReserve_01 = 0,	
	ldReserve_02 = 0,	
	ldReserve_03 = 0,	
	ldReserve_04 = 0,	
	ldReserve_05 = 0,
	ldReserve_06 = 0,
	ldReserve_07 = 0,
	ldReserve_08 = 0,
	ldReserve_09 = 0,
	ldReserve_10 = 0,
	ldReserve_11 = 0,
	ldReserve_12 = 0,
	ldReserve_13 = 0,
	ldReserve_14 = 0,
	ldReserve_15 = 0,
	ldReserve_16 = 0,
	ldReserve_17 = 0,
	ldReserve_18 = 0,
	ldReserve_19 = 0,
	ldReserve_20 = 0,
}


this.missionVarsList = {
	isDdSolDown_00 = false,
	isDdSolDown_20 = false,
	playerPos = PLAYER_POSITION.PLANT_UPPER_EAST,
	strDeadDDSoldierName = "",
	isSpeechedOcelot_DEV10 = false,
	isCloseUi_DEV10 = false,	

	isSpeechedOcelot_CQC_THOROW = false,
	isSpeechedOcelot_CQC_THOROW15 = false,
	isSpeechedOcelot_FINISH_DEVELOP = false,
	isSpeechedOcelot_CQC_HOLD = false,
	isSpeechedOcelot_CQC_PUNCH = false,
	isSpeechedOcelot_CQC_COMBO = false,
	isSpeechedOcelot_Develop_Cbox = false,
	isSpeechedOcelot_Develop_first = false,
	isFultonDdSoldier_CQC20 = false,
	isFultonDdSoldier_CQC30 = false,
	isFultonDdSoldier_CQC40 = false,
	isFultonDdSoldier_CQC50 = false,
	isFultonDdSoldier_CQC60 = false,
	actionOnCQC10 = 0,
	actionOnCQC15 = 0,
	actionOnCQC20 = 0,
	actionOnCQC30 = 0,
	actionOnCQC40 = 0,
	actionOnCQC50 = 0,
	isOpenTerminal = false,

	ocerotTalkProcess	=	1,	
	isCarried = false,	
	isHanged	=false,
	
	isApproachOcelot = false,	

	isInterruptTalkOk = false,
	isInterruptTalk = false,
	isSleepBulletEmptyTalk =false,
	isStopRepeatTalk =false,
	isStopFultonTalk =false,
	isStopDownTalk = false,
	isStopCarriedTalk = false,
	isSleepTalk =false,
	isOcelotDamage =false,
	isHangConciousTalk =false,

	
	ToggleCrazyTalk =0,

	isAlreadyDown	=false,	
	OcelotTooFarCount =0,
	RapidCQCCount = 0 ,

	isSoldierBoxHit = false, 
	isOcelotCriticalDamage =false,	




	isFirstOpenTerminal	=false,	
	isEndStaffListTalk	=false,	
	isEndDevelopTalk	=false,	
	isCanDevelopBox =false,	

	isSkipDevelopBox =false,	

	
	isSecondOpenTerminal	=false,	
	isDevelopFinish_Dev20 = false,	
	isSetBoxDropPoint	= false,	



	isHangDown =false,	
	isFultonAfterHang = false,	

	isRapidAttackDown =false,	
	isRapidAttackDownPlaseFulton =false,	

	isFultonAfterRapidAttack = false,	

	isCallHeliForMissionClear = false,	
	isUseRearLz = false,	


	isInsideOcelotTrap = false,	

	isHeliLanding = false,	
	isEverRideHeli	=false,	
	isInsideHeliport	=false,	

	isRestartLZ	=false,	


	isMotherBaseTopMemuFirst	= false,	
	isSelectStaffList	= false,	
	isCanCloseStaffList	= false,	
	isTalkMotherBaseTopMemu	= false,	
	isBackMotherBaseTopMemu	= false,	
	isSelectDevelopmentFirst	= false,	
	isSelectDevelopmentSecond	= false,	

	isCanCloseDevelopmentFirst	= false,	
	isDecideDevelopBox	= false,	

	isFULTON_DEVICE = false,	
	isCQC_THROW = false,	
	isCQC_HOLD = false,	
	isCQC_BLOW = false,	
	isTalkRapidCQC	= false,
	isDDSoldierDead = false,	
	isTitleFadeout =false,





}





this.checkPointList = {
	"CHK_ArrivAtMB",		
	"CHK_GetFulton",		
	"CHK_FinishDevelop",	
	"CHK_FinishCQCTutorial",		
	nil
}


this.ALLWAYS_100_PERCENT_FULTON = true


this.UNSET_UI_SETTING = {
	EquipHud = "INVALID",
	CqcIcon = "INVALID",
}

this.ALLWAYS_DIRECT_ADD_STAFF = true





this.missionObjectiveDefine = {
	
	learnDevelopTutorial_subGoal = {		
		subGoalId= 0,
	},
	goToAfgh_subGoal = {		
		subGoalId= 1,
	},
	
	
		
	task0_default = {	missionTask = { taskNo=0, isNew=true, isComplete=false },},
	task1_default = {	missionTask = { taskNo=1, isNew=true, isComplete=false, isFirstHide =true },},
	task2_default = {	missionTask = { taskNo=2, isNew=true, isComplete=false, isFirstHide =true },},
	task3_default = {	missionTask = { taskNo=3, isNew=true, isComplete=false, isFirstHide =true },},
	task4_default = {	missionTask = { taskNo=4, isNew=true, isComplete=false, isFirstHide=true },},


		
	task1_start = {	missionTask = { taskNo=1, isNew=true, isComplete=false, isFirstHide =false },},
	task2_start = {	missionTask = { taskNo=2, isNew=true, isComplete=false, isFirstHide =false },},
	task3_start = {	missionTask = { taskNo=3, isNew=true, isComplete=false, isFirstHide =false },},
	task4_start = {	missionTask = { taskNo=4, isNew=true, isComplete=false, isFirstHide=false },},


		
	task0_complete = {	missionTask = { taskNo=0, isComplete=true},},
	task1_complete = {	missionTask = { taskNo=1, isComplete=true},},
	task2_complete = {	missionTask = { taskNo=2, isComplete=true},},
	task3_complete = {	missionTask = { taskNo=3, isComplete=true},},
	task4_complete = {	missionTask = { taskNo=4, isComplete=true},},



}











this.missionObjectiveTree = {
	learnDevelopTutorial_subGoal = {},
	goToAfgh_subGoal = {},
	task0_complete = {
		task0_default={}
	},
	task1_complete	={
		task1_start={
			task1_default={}
		}
	},
	task2_complete	={
		task2_start={
			task2_default={}
		}
	},
	task3_complete	={
		task3_start={
			task3_default={}
		}
	},
	task4_complete	={
		task4_start={
			task4_default={}
		}
	},


}

this.missionObjectiveEnum = Tpp.Enum{
	"learnDevelopTutorial_subGoal",
	"goToAfgh_subGoal",
	
	"task0_default",
	"task1_default",
	"task2_default",
	"task3_default",
	"task4_default",
	

	"task1_start",
	"task2_start",
	"task3_start",
	"task4_start",
	
	"task0_complete",
	"task1_complete",
	"task2_complete",
	"task3_complete",
	"task4_complete",
	


}











function this.MissionPrepare()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " MissionPrepare ***")

	
	TppWeather.SetMissionStartWeather( TppDefine.WEATHER.SUNNY )

	mvars.isCallHeliForMissionClear=false
	mvars.isUseRearLz = true	



	
	TppMotherBaseManagement.SetActiveSync{ active=false }
			
	
	TppPlayer.RegisterTemporaryPlayerType{
 		partsType = PlayerPartsType.NORMAL,
 		camoType = PlayerCamoType.TIGERSTRIPE,
 		playerType = PlayerType.SNAKE,
 		handEquip = TppEquip.EQP_HAND_NORMAL,
 		faceEquipId = 0,
 	}

	this.SetMbDvcDefault()
	TppUiStatusManager.SetStatus( "MbStaffList", "BLOCK_FIRE" )
	TppUiStatusManager.UnsetStatus( "MbTop", "BLOCK_CANCEL" )	
	TppUiStatusManager.UnsetStatus( "Popup", "BLOCK_CANCEL_DIALOGUE")	
	
	
	local systemCallbackTable ={
		OnEstablishMissionClear = function()

			
			
			TppUiCommand.SetResultScore( "invalid", "play", 1 )
			TppUiCommand.SetResultScore( "invalid", "play", 2 )
			TppUiCommand.SetResultScore( "invalid", "play", 3 )
			TppUiCommand.SetResultScore( "invalid", "play", 4 )
			TppUiCommand.SetResultScore( "invalid", "play", 5 )

			TppUiCommand.SetResultScore( "invalid", "play", 6 )
			TppUiCommand.SetResultScore( "invalid", "play", 7 )
			TppUiCommand.SetResultScore( "invalid", "play", 8 )
			TppUiCommand.SetResultScore( "invalid", "play", 9 )
			TppUiCommand.SetResultScore( "invalid", "play", 10 )

			
			TppUiCommand.SetResultScore( "invalid", "bonus", 0 )
			TppUiCommand.SetResultScore( "invalid", "bonus", 1 )
			TppUiCommand.SetResultScore( "invalid", "bonus", 2 )
			TppUiCommand.SetResultScore( "invalid", "bonus", 3 )
			TppUiCommand.SetResultScore( "invalid", "bonus", 4 )
			TppUiCommand.SetResultScore( "invalid", "bonus", 5 )
			TppUiCommand.SetResultScore( "invalid", "bonus", 6 )
			TppUiCommand.SetResultScore( "invalid", "bonus", 7 )

			
			vars.playerInjuryCount = 0
			
			TppVarInit.SetHorseObtainedAndCanSortie()
			TppMission.MissionGameEnd{ loadStartOnResult = false }
		
		end,
		OnGameOver = function()					
			local sodilerName = mvars.strDeadDDSoldierName

			if mvars.isDDSoldierDead == true then	
				mvars.isDDSoldierDead = false
				TppUiStatusManager.ClearStatus( "AnnounceLog" )
			
			end

			if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.TARGET_DEAD ) then
				Fox.Log("xxxxxxxxxxxxxxxxxx DD DEAD xxxxxxxxxxxxxxxxxx" .. tostring(sodilerName) .. "is Dead!!")

				
				TppPlayer.SetTargetDeadCamera{
					gameObjectId=  sodilerName
				}
				TppMission.ShowGameOverMenu{ delayTime = TppDefine.GAME_OVER_TARGET_DEAD_DEMO_TIME }
				return true
			elseif mvars.isOcelotCriticalDamage == true then
				Fox.Log("xxxxxxxxxxxxxxxxxx ocelot critical damage xxxxxxxxxxxxxxxxxx")
				
				TppMission.ShowGameOverMenu{ delayTime = TppDefine.GAME_OVER_S10030_SHOT_OCELOT_BY_TULLET_TIME }
				return true
			end
		end,
		nil
	}
	
	TppMission.RegisterMissionSystemCallback(systemCallbackTable)

end





function this.OnRestoreSVars()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " OnRestoreSVars ***")
	Fox.Log("*** svars.restartSeq = " .. svars.restartSeq .. "!!")

	if TppMission.IsMissionStart() then
		
		TppWeather.RequestWeather( TppDefine.WEATHER.SUNNY, 0 )
	end
	

	TppUiStatusManager.SetStatus( "AnnounceLog","INVALID_LOG")	

	
	TppMotherBaseManagement.ClearEquipDeveloped()
	
	TppMotherBaseManagement.RemoveAllStaff()
	
	TppMotherBaseManagement.ResetDeploySvars()
	
	TppMotherBaseManagement.ResetBaseSvars()

	if svars.restartSeq == RESTART_SEQUENCE.ARRIVE_AT_MB then
	elseif svars.restartSeq == RESTART_SEQUENCE.GIVEN_FULTON then
	elseif svars.restartSeq == RESTART_SEQUENCE.CLEAR_DEVELOP_TUTORIAL then	
		TppMotherBaseManagement.SetEquipDeveloped{ equipDevelopID = 12000 }	
	end
	
	this.DirectAddStaffContinue()	


	
	vars.currentInventorySlot = TppDefine.WEAPONSLOT.SECONDARY

	

	
	TppUiStatusManager.SetStatus( "EquipHud", "PRIMARY1_NOUSE" )
	TppUiStatusManager.SetStatus( "EquipHud", "PRIMARY2_NOUSE" )
	TppUiStatusManager.SetStatus( "EquipHud", "SUPPORT_ALL_NOUSE" )




	TppUiStatusManager.UnsetStatus( "Popup", "BLOCK_CANCEL_DIALOGUE")	

	TppUiStatusManager.SetStatus( "MbEquipDevelop", "BLOCK_TAB" )	


	
	
	TppUiCommand.SetTutorialMode( true )


	this.SetMbDvcDefault()

	if svars.restartSeq == RESTART_SEQUENCE.ARRIVE_AT_MB then
		Fox.Log("*** RESTART FROM ::: RESTART_SEQUENCE.ARRIVE_AT_MB *** svars.restartSeq = " .. svars.restartSeq .. "!!")
		
		vars.playerDisableActionFlag = PLAYER_DISABLE.ARRIVE_AT_DD

		
		this.SetMbDvcDefault()


	elseif svars.restartSeq == RESTART_SEQUENCE.GIVEN_FULTON then
		Fox.Log("*** RESTART FROM ::: RESTART_SEQUENCE.GIVEN_FULTON *** svars.restartSeq = " .. svars.restartSeq .. "!!")
		
		vars.playerDisableActionFlag = PLAYER_DISABLE.GIVEN_FULTON

		
		this.SetMbDvcDefault()


	elseif svars.restartSeq == RESTART_SEQUENCE.CLEAR_DEVELOP_TUTORIAL then
		Fox.Log("*** RESTART FROM ::: RESTART_SEQUENCE.CLEAR_DEVELOP_TUTORIAL *** svars.restartSeq = " .. svars.restartSeq .. "!!")
		
		vars.playerDisableActionFlag = PLAYER_DISABLE.CLEAR_DEVELOP_TUTORIAL

		
		this.SetMbDvcAtTutorialClear()

		
		Fox.Log("*** DISABLE_sol_plant0_0000")
		s10030_enemy.SwitchEnableSoldier( "sol_plant0_0000", false )

	end
	TppUiStatusManager.SetStatus( "MbStaffList", "BLOCK_FIRE" )
	
	
	MotherBaseStage.UnlockCluster()

	


	mvars.isCallHeliForMissionClear=false
	mvars.isUseRearLz = true	






end


function this.ReserveMissionClear()
	TppMission.ReserveMissionClear{
		nextMissionId = TppDefine.SYS_MISSION_ID.MTBS_HELI ,
		missionClearType = TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER
	}
end



function this.OnTerminate()
	Fox.Log("s10030_sequence.OnTerminate")
		
		TppUiCommand.SetTutorialMode( false )
		
		this.ClearTerminalAttentionIcon()
		
		
		TppMotherBaseManagement.SetActiveSync{ active=true }

		
		TppUiStatusManager.UnsetStatus( "EquipHud", "PRIMARY1_NOUSE" )
		TppUiStatusManager.UnsetStatus( "EquipHud", "PRIMARY2_NOUSE" )
		TppUiStatusManager.UnsetStatus( "EquipHud", "SUPPORT_ALL_NOUSE" )

		TppUiStatusManager.UnsetStatus( "CqcIcon", "ICON_NOUSE_KILL" )
		TppUiStatusManager.UnsetStatus( "CqcIcon", "ICON_NOUSE_INTERROGATE" )


		
		TppUiStatusManager.UnsetStatus( "MbEquipDevelop", "BLOCK_CANCEL" )					
		TppUiStatusManager.UnsetStatus( "MbEquipDevelop", "BLOCK_CANCEL_DEVELOP_DIALOG" )	
		TppUiStatusManager.UnsetStatus( "MbEquipDevelop", "BLOCK_CANCEL_SUPPORT_DIALOG" )	
		TppUiStatusManager.UnsetStatus( "MbEquipDevelop", "BLOCK_TAB" )	
		TppUiStatusManager.UnsetStatus( "MbMapDropItem", "BLOCK_CANCEL" )	
		TppUiStatusManager.UnsetStatus( "MbMapDropItem", "BLOCK_SCROLL" )	
		TppUiStatusManager.UnsetStatus( "MbMap", "BLOCK_NAVIGATION" )
		TppUiStatusManager.UnsetStatus( "MbStaffList", "BLOCK_ASSIGN" )	
		TppUiStatusManager.UnsetStatus( "MbStaffList", "BLOCK_CANCEL" )	
		TppUiStatusManager.UnsetStatus( "MbStaffList", "BLOCK_DECIDE" )	
		TppUiStatusManager.UnsetStatus( "MbStaffList", "BLOCK_FIRE" )		
		TppUiStatusManager.UnsetStatus( "MbTop", "BLOCK_CANCEL" )	
		TppUiStatusManager.UnsetStatus( "PauseMenu", "INVALID" )	
		TppUiStatusManager.UnsetStatus( "Popup", "BLOCK_CANCEL_DIALOGUE")	
		TppUiStatusManager.UnsetStatus( "MbStaffList", "BLOCK_CANCEL" )	
		TppUiStatusManager.UnsetStatus( "AnnounceLog","INVALID_LOG")	
		TppUiStatusManager.UnsetStatus( "AnnounceLog","SUSPEND_LOG")	
		TppUiStatusManager.ClearStatus("AnnounceLog")	


		TppUiCommand.UnRegisterForceDropItemPosition()	

		
		
		
		

		Player.SetFultonCountInfinity(false)

		TppSound.StopSceneBGM()	

end


function this.LandingZoneForRestart()
	Fox.Log("***** s10030_sequence.LandingZoneForRestart *****")
	if mvars.isRestartLZ	==true then	
		if mvars.isCallHeliForMissionClear == false then	
			mvars.isUseRearLz =false
			Fox.Log("#### lz_commfacility_0000 activate ####")
			TppHelicopter.SetDisableLandingZone{ landingZoneName = "lz_commfacility_0000" }	
			TppHelicopter.SetEnableLandingZone{ landingZoneName = "lz_commfacility_0002" }	
		end
	end
	mvars.isRestartLZ	=false	
	this.SetLandingZnoeDoor()
	

end


function this.SetLandingZnoeDoor()
	Fox.Log("***** s10030_sequence.SetLandingZnoeDoort *****")

	local gameObjectId = GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
	GameObject.SendCommand( gameObjectId, { id="SetLandingZnoeDoorFlag", name="lz_commfacility_0000", leftDoor="Open", rightDoor="Close" } )
	GameObject.SendCommand( gameObjectId, { id="SetLandingZnoeDoorFlag", name="lz_commfacility_0002", leftDoor="Open", rightDoor="Close" } )

end

function this.OnEndMissionPrepareSequence()
	Fox.Log("s10030 OnEndMissionPrepareSequence")
	 this.InfinitDefaultFulton()	
end

function this.InfinitDefaultFulton()	
	
	Player.SetFultonCountInfinity( true )
	mvars.isDDSoldierDead = false	

end




this.EnterHeliportAfterCallHeli = function ()
	Fox.Log("#### s10030_sequence.EnterHeliportAfterCallHeli ####")
	if mvars.isCallHeliForMissionClear == true   
		and mvars.isHeliLanding == true	then
		Fox.Log("## dd_soldier_goodbye ##")	
		s10030_enemy.SetEnemyWakeUpAll()
		s10030_enemy.SetRideHeliRoute()	
	end
end










this.TIPS = {
	
	SLEEP_BULLET		= tostring( TppDefine.TIPS.TRANQUILIZER ),		
	FULTON_DEVICE		= tostring( TppDefine.TIPS.FULLTON_DEVICE ),	
	ABOUT_CQC			= tostring( TppDefine.TIPS.CQC ), 				
	CQC_THROW			= tostring( TppDefine.TIPS.CQC_THROW ),			
	SUPPLY_TOOL			= tostring( TppDefine.TIPS.SUPPLY_WEAPON ),		
	ABOUT_BOX			= tostring( TppDefine.TIPS.CARDBOARD_BOX ),		
	FULTON_RATIO		= tostring( TppDefine.TIPS.FULLTON_RECOVERY ),	

	
	CQC_HOLD			= tostring( TppDefine.TIPS.CQC_HOLD ),		 
	CQC_CHOKE 			= tostring( TppDefine.TIPS.CQC_CHOKE ),		 
	CQC_BLOW			= tostring( TppDefine.TIPS.CQC_ATTACK ),	 
	CQC_RAPID			= tostring( TppDefine.TIPS.CQC_COMB ),		 

}


function this.displayTips(langId)
	Fox.Log("#### s10030_sequence.displayTips ####")
		TppUiCommand.EnableTips( langId, true )
		TppUiCommand.DispTipsGuide( langId )	
		TppUiCommand.SeekTips( langId )		
end


function this.fultonStaffAnnounce()
	TppUiCommand.AnnounceLogViewLangId( "announce_extraction_arrived" )
	TppUiCommand.AnnounceLogViewJoinLangId( "announce_extract_staff", "announce_record_num", 1  )
end







this.playerInitialWeaponTable = {
	{ secondary = "EQP_WP_10101", magazine = TppDefine.INIT_MAG.HANDGUN_DEFAULT },
	{ primaryHip    = "EQP_WP_30101",   magazine = TppDefine.INIT_MAG.ASSAULT_DEFAULT },	
	{ primaryBack   = "EQP_None", },	
	{ support   = "EQP_None", },	
}


this.playerInitialItemTable = { "EQP_None", "EQP_None","EQP_None","EQP_None","EQP_None","EQP_None","EQP_None","EQP_None",}







function this.Messages()
	return
	StrCode32Table {
		Trap = {
			{
				
				msg = "Enter",
				sender = "trap_activateRearLZ",
				func = function ()
					if mvars.isCallHeliForMissionClear == false then	
					
						mvars.isUseRearLz =true
							Fox.Log("#### lz_commfacility_0002 activate ####")
							TppHelicopter.SetDisableLandingZone{ landingZoneName = "lz_commfacility_0002" }	
							TppHelicopter.SetEnableLandingZone{ landingZoneName = "lz_commfacility_0000" }	
				
					end
				end,
			},
			{
				
				msg = "Enter",
				sender = "trap_activateFrontLZ",
				func = function ()
					if mvars.isCallHeliForMissionClear == false then	
					
							mvars.isUseRearLz =false
							Fox.Log("#### lz_commfacility_0000 activate ####")
							TppHelicopter.SetDisableLandingZone{ landingZoneName = "lz_commfacility_0000" }	
							TppHelicopter.SetEnableLandingZone{ landingZoneName = "lz_commfacility_0002" }	
					
					end
				end,
			},

			
			{
				msg = "Enter",
				sender = "trap_dd_soldier_goodbye",
				func = function ()
					Fox.Log("## trap_dd_soldier_goodbye true ##")	
					mvars.isInsideHeliport	=true	
					
					this.EnterHeliportAfterCallHeli()

				end
			},
			
			{
				msg = "Exit",
				sender = "trap_dd_soldier_goodbye",
				func = function ()
					Fox.Log("## trap_dd_soldier_goodbye false ##")	
					mvars.isInsideHeliport	=false	
				
				
				
				end
			},

			
			{
				msg = "Enter",
				sender = "trap_FultonDemoStart",
				func = function ()
					if mvars.isCallHeliForMissionClear == false then	
						Fox.Log("## isInsideOcelotTrap true before call heli ##")	
						mvars.isInsideOcelotTrap = true	
					end
				end
			},

			{
				msg = "Enter",
				sender = "trap_HangTutorialAfterCallHeli",
				func = function ()
					if mvars.isCallHeliForMissionClear == true then	
						Fox.Log("## isInsideOcelotTrap true after call heli ##")	
						mvars.isInsideOcelotTrap = true	
					end
				end
			},

			
			{
				msg = "Exit",
				sender = "trap_FultonDemoStart",
				func = function ()
				
						Fox.Log("## isInsideOcelotTrap false ##")	
						mvars.isInsideOcelotTrap = false	
				
				end
			},






		},
		Player = {
			{	
				msg = "OnAmmoStackEmpty",
				func = function ( playerIndex, equipId )
					Fox.Log("#### Sleep bullet Empty ####")
				
				
						svars.isSleepBulletEmpty = true 
				
				end

			},
			{	
				msg = "RideHelicopter",		
				func = function ()
					Fox.Log("#### player ride heli ####")
						if svars.isReserve_03 ==false then	
							svars.isReserve_03 =true
						end
						mvars.isEverRideHeli=true
						
						Fox.Log("disable enemy marker")

						local command = { id="SetMarkerEnabledCommand", enabled=false }
						for i, name in pairs(s10030_enemy.ALL_SOLDIER_GROUP)do
							GameObject.SendCommand( GameObject.GetGameObjectId( name ), command )
						end
						GkEventTimerManager.Stop( "Timer_waitApproachOcelot")	
						s10030_enemy.SetEnemyWakeUpAll()
					
						GkEventTimerManager.Stop( "Timer_goodbye")
						GkEventTimerManager.Start( "Timer_goodbye", TIMER_GOODBYE )
						GkEventTimerManager.Stop( "Timer_OcelotGoodbye")
						GkEventTimerManager.Start( "Timer_OcelotGoodbye", TIMER_GOODBYE_OCELOT )

				end

			},
			{	
				msg = "PlayerDamaged",
				func = function ( playerIndex, attackId,attackerId )
						
					
					
					
						
					if (attackId == TppDamage.ATK_SupplyCBoxHit)  then	
							Fox.Log("## dd soldier box hit reaction ##")	
							s10030_radio.SoldierBoxHit()		
					end
				end

			},












		},
		
		Terminal = {
			{
			
				msg = "MbDvcActOpenTop",
				func = function()
					Fox.Log("#### Open Terminal ####")
					mvars.isOpenTerminal = true
				end
			},
			
			{
				msg = "MbDvcActCloseTop",
				func = function ()
					Fox.Log("#### Close Terminal ####")
					mvars.isOpenTerminal = false
				end
			},
			{
				
				msg = "MbDvcActCallRescueHeli",
				func = function()
					mvars.isCallHeliForMissionClear = true	

					TppSound.SetSceneBGM("bgm_mtbs_departure")
					TppSound.SetSceneBGMSwitch("Set_Switch_bgm_s10030_helicall")
				end
			},
		},

		Timer = {
			
			{
				msg = "Finish",
				sender = "Timer_MonologueFailed",
				func = function() 
					Fox.Log("#### Timer_MonologueFailed ####")
					s10030_radio.FailedReset()
				end
			},

			
			{
				msg = "Finish",
				sender = "Timer_goodbye",
				func = function() 
					Fox.Log("#### Timer_goodbye ####")

					s10030_enemy.SetEnemyWakeUpAll()
					s10030_enemy.SetGoodbyeRoute()	

					s10030_enemy.OcelotGoodbye()
				end
			},

			{
				msg = "Finish",
				sender = "Timer_OcelotGodbye",
				func = function() 
					Fox.Log("#### Timer_OcelotGodbye ####")

					s10030_enemy.OcelotGoodbye()
				end
			},


			{
				msg = "Finish",
				sender = "Timer_FULTON_DEVICE",
				func = function() 
					Fox.Log("#### Timer_FULTON_DEVICE ####")

					mvars.isFULTON_DEVICE = false	
				end
			},

			{
				msg = "Finish",
				sender = "Timer_CQC_THROW",
				func = function() 
					Fox.Log("#### Timer_CQC_THROW ####")
					mvars.isCQC_THROW = false	
				end
			},

			{
				msg = "Finish",
				sender = "Timer_CQC_HOLD",
				func = function() 
					Fox.Log("#### Timer_CQC_HOLD ####")
					mvars.isCQC_HOLD = false	
				end
			},

			{
				msg = "Finish",
				sender = "Timer_CQC_BLOW",
				func = function() 
					Fox.Log("#### Timer_CQC_BLOW ####")
					mvars.isCQC_BLOW = false	
				end
			},


			nil
		},
		GameObject = {
			
			{
				msg = "RoutePoint2", 
				func = function (nObjectId,nRouteId,nRouteNodeId,sendM)
					if	sendM == StrCode32("msgTakeOff") then	
					elseif	sendM == StrCode32("msgDummy") then	
					else
						Fox.Log( "*** Unknown Message ***")
					end
				end
			},
			{
				
				msg = "Damage", 
				sender = "Ocelot",
				func = function ( gameObjectId, attackId )					
					if GkEventTimerManager.IsTimerActive( "Timer_MonologueFailed" ) then
						GkEventTimerManager.Stop( "Timer_MonologueFailed")
						GkEventTimerManager.Start( "Timer_MonologueFailed", 6 )
					end
				end
			},
			
			{
				msg = "Conscious", 
				sender = s10030_enemy.ALL_SOLDIER_GROUP,
				func = function ( gameObjectId)
					Fox.Log("## CheckConciousSoldier##")	
					s10030_enemy.CheckConciousSoldier()
				end
			},
			
			{
				msg = "CalledFromStandby",
			
				func = function ()
					mvars.isCallHeliForMissionClear = true	
					s10030_enemy.SetClearedRoute()	
				end
			},
			
			{
				msg = "DescendToLandingZone",
			
				func = function ()
					mvars.isHeliLanding = true	

					
					local sequence = TppSequence.GetCurrentSequenceName() 
					if ( sequence == "Seq_Game_TutorialCQC20" ) or ( sequence == "Seq_Game_TutorialCQC30" ) then
						Fox.Log("## Now CQC turorial ##")	
					else
						s10030_enemy.SetEnemyWakeUpAll()
					end

					if mvars.isInsideHeliport	==true then	
						s10030_enemy.SetRideHeliRoute()	
					elseif 	mvars.isEverRideHeli==true then
						s10030_enemy.SetRideHeliRoute()	
					end
				end
			},
			
			{
				msg = "StartedMoveToLandingZone",
				func = function ()
					

				end
			},
			
			{
				msg = "StartedPullingOut",
			
				func = function ()
					
					TppSound.SetSceneBGM("bgm_mtbs_departure")
					TppSound.SetSceneBGMSwitch("Set_Switch_bgm_s10030_departure")
					TppSoundDaemon.SetMute( 'HeliClosing' )
				end
			},
			
			{
				msg = "HeliDoorClosed",
				sender = "SupportHeli",
				func = function () 
					TppSound.StopSceneBGM()	
					this.DirectAddStaffMissionEnd()	
					TppSequence.SetNextSequence( "Seq_Game_MissionClear" ) 
				end
			},
			
			{
				msg = "Dead",
				sender = s10030_enemy.ALL_SOLDIER_GROUP,
				func = function (gameObjectId)

					mvars.isDDSoldierDead = true	
	
					
					mvars.strDeadDDSoldierName = gameObjectId
					
					TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.PLAYER_KILL_TARGET, TppDefine.GAME_OVER_RADIO.S10030_TARGET_DEAD )


				end
			},
			
			{
				msg = "MonologueEnd",
				sender = "Ocelot",
				func = function (gameObjectId, speechLabel, isSuccess )
					if (speechLabel == StrCode32("MBTS_410") and isSuccess ~= 0) then	
						Fox.Log("#### MBTS_410 end ####")
						mvars.isSoldierBoxHit = false 
					elseif (speechLabel == StrCode32("MBTS_050") and isSuccess ~= 0) then
							TppMission.UpdateObjective{objectives = { "task0_complete" },}	
							TppMission.UpdateObjective{objectives = { "task1_start" },}	
							svars.isReserve_07 =true	
					end
				end
			},
			
			{
				msg = "Fulton",				
				sender = s10030_enemy.ALL_SOLDIER_GROUP,
				func = function (gameObjectId, gimmckInstance, gimmckDataSet, staffID)
					Fox.Log("#### Fulton common function Set dd soldier fulton flag ####")
					s10030_enemy.SetDDSoldierFultonFlag()	
					this.fultonStaffAnnounce()
				end
			},
			
			{
				msg = "PlacedIntoVehicle" , 
				sender = s10030_enemy.ALL_SOLDIER_GROUP,
				func = function ( gameObjectId , arg2 )
					if arg2 == GameObject.GetGameObjectId("SupportHeli") then
						Fox.Log("#### PlacedIntoVehicle common function Set dd soldier fulton flag ####")
						s10030_enemy.SetDDSoldierFultonFlag()	
					else	
					end
				end
			},
			
			{
				msg = "FultonFailedEnd",	
				sender = s10030_enemy.ALL_SOLDIER_GROUP,
				func = function (nGameObjectId,arg1,arg2,type) 
					Fox.Log("####fulton failed "..type)
					GkEventTimerManager.Stop( "Timer_FultonStart" )
					if type == TppGameObject.FULTON_FAILED_TYPE_ON_FINISHED_RISE then	
						if debug then	
							
							TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.PLAYER_KILL_TARGET, TppDefine.GAME_OVER_RADIO.S10030_TARGET_DEAD )
						end
					elseif type == TppGameObject.FULTON_FAILED_TYPE_WRONG_POSITION then	
						GkEventTimerManager.Stop( "Timer_FultonDisable" )	
						this.EnableFulton()	
						s10030_radio.FultonFailed()
						mvars.isStopFultonTalk = false
					else																
						GkEventTimerManager.Stop( "Timer_FultonDisable" )	
						this.EnableFulton()	
						mvars.isStopFultonTalk = false
					end
				end
			},


		},

	}

end






function this.ResetInteruptTalk(speechLabel, isSuccess)
	if	(speechLabel == StrCode32("MBTS_010") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_020") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_021") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_022") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_023") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_024") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_030") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_031") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_032") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_040") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_041") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_042") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_045") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_050") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_051") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_052") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_055") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_060") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_070") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_071") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_072") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_073") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_074") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_075") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_076") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_077") and isSuccess ~= 0) then

	elseif	(speechLabel == StrCode32("MBTS_080") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_081") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_082") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_083") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_084") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_085") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_086") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_087") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_088") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_089") and isSuccess ~= 0) then

		mvars.isInterruptTalk= false

	elseif	(speechLabel == StrCode32("MBTS_100") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_101") and isSuccess ~= 0) then

	elseif	(speechLabel == StrCode32("MBTS_110") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_111") and isSuccess ~= 0) then

		mvars.isInterruptTalk= false

	elseif	(speechLabel == StrCode32("MBTS_112") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_113") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_114") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_115") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_116") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_117") and isSuccess ~= 0) then

		mvars.isInterruptTalk= false
		mvars.isOcelotDamage= false	

	elseif	(speechLabel == StrCode32("MBTS_120") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_125") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_130") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_131") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_140") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_141") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_142") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_143") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_145") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_150") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_160") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_170") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_180") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_190") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_200") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_210") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_220") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_222") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_223") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_225") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_228") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_230") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_231") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_240") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_241") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_250") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_251") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_260") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_270") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_280") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_290") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_291") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_300") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_350") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_360") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_370") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_371") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_380") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_410") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_411") and isSuccess ~= 0) then

		mvars.isInterruptTalk= false

	elseif	(speechLabel == StrCode32("MBTS_420") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_421") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_422") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_423") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_424") and isSuccess ~= 0) then

		mvars.isSleepTalk= false
		mvars.isInterruptTalk= false

	elseif	(speechLabel == StrCode32("MBTS_430") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_440") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_450") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_460") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_470") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_480") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_490") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_500") and isSuccess ~= 0)
	or	(speechLabel == StrCode32("MBTS_510") and isSuccess ~= 0) then

		mvars.isInterruptTalk= false

	end
end



function this.GetDistanceFromPlayer( gameObjectName, gameObjectType )
	local GetGameObjectId = GameObject.GetGameObjectId
	local SendCommand = GameObject.SendCommand

	
	local playerPos = {}
	playerPos = TppPlayer.GetPosition()

	
	local gameObjectId = GetGameObjectId(gameObjectType, gameObjectName)
	local command = {
		id="GetPosition",
	}
	local enemyPosVector3 = SendCommand(gameObjectId, command)
	local enemyPos = {}
	enemyPos = TppMath.Vector3toTable( enemyPosVector3 )

	
	local distance = TppMath.FindDistance( playerPos, enemyPos )
	return distance
end


function this.CheckDistanceFromPlayerToOcelot(isIgnoreLeave)	
	if this.GetDistanceFromPlayer( "Ocelot", "TppOcelot2" ) < DISTANCE_APPROACH then
			mvars.isApproachOcelot = true
	else
		if mvars.isApproachOcelot == true then
			mvars.isApproachOcelot = false
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
			if isIgnoreLeave ~= true then
				s10030_radio.TalkingToLeave()	
			end
		end
	end
end



function this.SetMbDvcDefault()
	
	TppTerminal.SetActiveTerminalMenu {
	}
	
end



function this.SetMbDvcStaffListTutotrial()
	
	TppTerminal.SetActiveTerminalMenu {
		TppTerminal.MBDVCMENU.MBM,
		TppTerminal.MBDVCMENU.MBM_STAFF,
	}
end




function this.SetMbDvcDevelopTutotrial()
	TppTerminal.SetActiveTerminalMenu {
		TppTerminal.MBDVCMENU.MBM,
		TppTerminal.MBDVCMENU.MBM_DEVELOP,
		TppTerminal.MBDVCMENU.MBM_DEVELOP_WEAPON,
	}
end



function this.SetMbDvcAtTutorialClear()
	TppTerminal.SetActiveTerminalMenu {
		TppTerminal.MBDVCMENU.MBM,
		TppTerminal.MBDVCMENU.MBM_STAFF,
		TppTerminal.MBDVCMENU.MBM_DEVELOP,
		TppTerminal.MBDVCMENU.MBM_DEVELOP_WEAPON,
		TppTerminal.MBDVCMENU.MSN,
		TppTerminal.MBDVCMENU.MSN_HELI,
		TppTerminal.MBDVCMENU.MSN_HELI_RENDEZVOUS,
	}
end


function this.SetMbDvcAtClear()
	Fox.Log("#### s10030_sequence.SetMbDvcAtClear() ####")

	TppTerminal.SetActiveTerminalMenu {
		TppTerminal.MBDVCMENU.ALL,
	}
end

























this.IsWrongAction = function ( attackId, successAttacks )
	
	for idx = 1, table.getn( successAttacks ) do
		if attackId == successAttacks[idx] then
			Fox.Log("#### This Action is SUCCESS" .. tostring(attackId) ..	"####")
			return TUTORIAL_RESULT.SUCCESS
		end
	end

	
	for idx = 1, table.getn( TUTORIAL_WRONG_ACTION_LIST ) do
		if attackId == TUTORIAL_WRONG_ACTION_LIST[idx] then
			Fox.Log("#### This Action is FAILED" .. tostring(attackId) ..  "####")
			return TUTORIAL_RESULT.FAILED
		end
	end

	Fox.Log("#### This Action is NOREACTION" .. tostring(attackId) ..  "####")
	return TUTORIAL_RESULT.NOREACTION
end






function this.SetTerminalAttentionIcon( menuId, switch )
	Fox.Log("#### SetTerminalAttentionIcon ")
	if switch == true then
		Fox.Log("#### SetTerminalAttentionIcon : " .. tostring(menuId) ..  "####")
		TppUiCommand.SetMbTopMenuItemTutorialNotice( menuId, true )
	else
		Fox.Log("#### UnsetTerminalAttentionIcon : " .. tostring(menuId) ..  "####")
		TppUiCommand.SetMbTopMenuItemTutorialNotice( menuId, false )
	end

end





function this.ClearTerminalAttentionIcon()
	
	this.SetTerminalAttentionIcon(TppTerminal.MBDVCMENU.MBM_STAFF, false)
	this.SetTerminalAttentionIcon(TppTerminal.MBDVCMENU.MBM_DEVELOP_WEAPON, false)
	this.SetTerminalAttentionIcon(TppTerminal.MBDVCMENU.MSN_HELI_RENDEZVOUS, false)
	this.SetTerminalAttentionIcon(TppTerminal.MBDVCMENU.MSN_MISSIONLIST, false)
end



function this.DisableFulton()
	Fox.Log("=======================DisableFulton=======================")


end



function this.EnableFulton()
	Fox.Log("=======================EnableFulton=======================")


end







sequences.Seq_Demo_AfterPazResque = {
	
	OnEnter = function ()
		




		
		MotherBaseStage.LockCluster()
		TppUiCommand.SetMisionInfoCurrentStoryNo(0)	

		
		TppClock.SetTime( TIME_ON_DEMO_AFTER_PAZ_RESQUE )

		
		local GetGameObjectId = GameObject.GetGameObjectId
		local SendCommand = GameObject.SendCommand

		local gameObjectId = GetGameObjectId("TppHeli2", "SupportHeli")
		SendCommand(gameObjectId, { id="Realize" })


	

		

		
		s10030_demo.AfterPazResque()

		
		















		mvars.CQCCount = 0 
		TppMission.UpdateObjective{
			objectives = { 
				"task0_default",
				"task1_default",
				"task2_default",
				"task3_default",
				"task4_default",},
		}	



		this.SetMbDvcAtClear()

		
	
		svars.restartSeq = RESTART_SEQUENCE.ARRIVE_AT_MB
		vars.playerDisableActionFlag = PLAYER_DISABLE.ARRIVE_AT_DD
		svars.isFultonFirstSoldier =false	
		svars.isFultonSecondSoldier =false	
		mvars.isUseRearLz = false	
		mvars.isInsideOcelotTrap = false	
	
	
		
		
		TppUiCommand.SetTutorialMode( true )
	end,

	
	OnLeave = function ()
		TppUI.StartMissionTelop()
	end,

}



sequences.Seq_Demo_ArriveAtDD = {
	Messages = function( self ) 
		return
		StrCode32Table {
			Demo = {
				
				{
					msg = "visibleOnNPC", sender = s10030_demo.demoList.ArriveAtDD,
					func = function()
						Fox.Log("=======================visibleOnNPC=======================")
						 s10030_enemy.SetRouteAfterDemo()
					end,
					option = { isExecDemoPlaying = true }
				},
			},
			UI= {
				{
					msg = "StartMissionTelopBgFadeOut",
					func = function ()
						GkEventTimerManager.Start( "Timer_waitToArriveAtDD", TIMER_FADE_DEMOTODEMO )
					end
				},
			},

			Timer = {
				{
					msg = "Finish",
					sender = "Timer_waitToArriveAtDD",
					func = function ()
						s10030_demo.PlayArriveAtDD()
					end
				},
			},
			nil
		}
	end,

	
	OnEnter = function ()
		mvars.isSoldierBoxHit = false 

		
		local gameObjectId = GameObject.GetGameObjectId( "SupportHeli" )
		GameObject.SendCommand(gameObjectId, { id="SetDemoToAfterDropEnabled", enabled=true, route="rt_heli_takeoff_opening", isTakeOff=true } ) 

		
		TppClock.SetTime( TIME_ON_DEMO_ARRIVE_AT_DD )

		
		
		
	end,


	
	OnLeave = function ()
		
		svars.restartSeq = RESTART_SEQUENCE.ARRIVE_AT_MB
		Fox.Log("*** svars.restartSeq = " .. svars.restartSeq .. "!!")
		
	
		TppTelop.StartMissionObjective()
	end,

}



sequences.Seq_Game_ApproachOcelot = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			Timer = {
				
				{
					msg = "Finish",
					sender = "Timer_waitApproachOcelot",
					func = function ()
						if mvars.ocerotTalkProcess == s10030_sequence.OCELOT_TALK_PROCESS.WAITING_2 then
							s10030_radio.WaitingApproach()	
						else
							
							s10030_radio.MissionStart() 
						end
					end
				},
			},

			GameObject = {
				
				{
					msg = "RoutePoint2", 
					sender = "Ocelot",
					func = function (nObjectId,nRouteId,nRouteNodeId,sendM)
						if sendM == StrCode32("msgOcelotArrive") then
							
							GkEventTimerManager.Stop( "Timer_waitApproachOcelot")
							GkEventTimerManager.Start( "Timer_waitApproachOcelot", 5 )
						end
					end
				},
				
				{
					msg = "Down",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId)
						
						if (TppEnemy.GetLifeStatus(gameObjectId) == TppEnemy.LIFE_STATUS.SLEEP) then
						else
							
							s10030_radio.CrazyAction()
						end
					end
				},
				
				{
					msg = "Damage", 
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						if (attackId == TppDamage.ATK_10101)  then	
							s10030_radio.CrazyAction()	
						end
					end
				},
				
				{
					msg = "Carried",					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function  (gameObjectId, arg1)
						if arg1 == 0 then
							s10030_radio.CrazyAction()
						end
					end
				},
				
				{
					
					msg = "Restraint",					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function(gameObjectId, switch, releaseAction)
						if switch == 0 then
							
							s10030_radio.CrazyAction()
						else
							if (releaseAction == 2) or (releaseAction == 4) then
								
								s10030_radio.CrazyAction()
							end
						end
					end
				},
				
				{
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	
						if speechLabel == StrCode32("MBTS_010") then	
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_010 end ####")
								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_2	
							else
								s10030_radio.FailedRequest()
							end
						end
						vars.playerDisableActionFlag = PLAYER_DISABLE.FIRST_TALK

						GkEventTimerManager.Stop( "Timer_waitApproachOcelot")
						GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME_WAIT_TO_WAIT )
					end
				},
			}
		}
	end,

	
	OnEnter = function ()
		TppUiStatusManager.ClearStatus("AnnounceLog")	

		mvars.isInterruptTalk = false
		mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.TALKING_1
		mvars.OcelotTooFarCount	=0	
		mvars.ToggleOcelotSleep = 0	

		
		local gameObjectId = GameObject.GetGameObjectId( "SupportHeli" )
		GameObject.SendCommand(gameObjectId, { id="SendPlayerAtRoute", route="rt_heli_takeoff_opening" })
		TppHelicopter.SetDisableLandingZone{ landingZoneName = "lz_commfacility_0000" }	
		TppHelicopter.SetEnableLandingZone{ landingZoneName = "lz_commfacility_0002" }	
		this.LandingZoneForRestart()

		
		s10030_enemy.SetIdleRoute()
		s10030_enemy.OcelotAction()

		
		TppUiStatusManager.SetStatus( "EquipHud", "PRIMARY1_NOUSE" )
		TppUiStatusManager.SetStatus( "EquipHud", "PRIMARY2_NOUSE" )
		TppUiStatusManager.SetStatus( "EquipHud", "SUPPORT_ALL_NOUSE" )
		TppUiStatusManager.SetStatus( "CqcIcon", "ICON_NOUSE_KILL" )
		TppUiStatusManager.SetStatus( "CqcIcon", "ICON_NOUSE_INTERROGATE" )
		TppUiStatusManager.SetStatus( "MbMap", "BLOCK_NAVIGATION" )

		
		this.SetMbDvcDefault()

	end,

	
	OnLeave = function ()
		mvars.isCarried = false	
	end,

	
	OnUpdate = function ()
		if mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_1 then
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
			s10030_radio.MissionStart() 
		end

		if mvars.isInterruptTalk == false and mvars.isInsideOcelotTrap == true then
			
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
			GkEventTimerManager.Stop( "Timer_MonologueFailed" )
			TppSequence.SetNextSequence( "Seq_Demo_BeforeOcelotGiveFulton" )
		end
	end,
}


sequences.Seq_Demo_BeforeOcelotGiveFulton = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			Timer = {
				
				{
					msg = "Finish",
					sender = "Timer_waitApproachOcelot",
					func = function ()
						s10030_radio.TalkingToApproach()	
					end
				},
			},

			
			GameObject = {
				
				{
					msg = "Down",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId)
						
						if (TppEnemy.GetLifeStatus(gameObjectId) == TppEnemy.LIFE_STATUS.SLEEP) then
						else
							
							s10030_radio.CrazyAction()
						end
					end
				},
				
				{
					msg = "Damage", 
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						if (attackId == TppDamage.ATK_10101)  then	
							s10030_radio.CrazyAction()	
						end
					end
				},
				
				{
					msg = "Carried",					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function  (gameObjectId, arg1)
						if arg1 == 0 then
							s10030_radio.CrazyAction()
						end
					end
				},
				
				{
					
					msg = "Restraint",					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function(gameObjectId, switch, releaseAction)
						if switch == 0 then
							
							s10030_radio.CrazyAction()
						else
							if (releaseAction == 2) or (releaseAction == 4) then
								
								s10030_radio.CrazyAction()
							end
						end
					end
				},
				
				{
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	
						if speechLabel == StrCode32("MBTS_020") then	
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_020 end ####")
								mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_2	
							else
								s10030_radio.FailedRequest()
							end

						elseif speechLabel == StrCode32("MBTS_021") then	
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_021 end ####")
								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_3	
							else
								s10030_radio.FailedRequest()
							end

						elseif speechLabel == StrCode32("MBTS_022") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_022 end ####")
								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_4	
							else
								s10030_radio.FailedRequest()
							end
						end

						GkEventTimerManager.Stop( "Timer_waitApproachOcelot")
						GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME_WAIT_TO_WAIT )
					end
				},
			nil
			}
		}
	end,


	
	OnEnter = function ()
		mvars.isInterruptTalk= false
		mvars.isCarried = false
		mvars.OcelotTooFarCount	=0	
		mvars.ocerotTalkProcess = s10030_sequence.OCELOT_TALK_PROCESS.WAITING_1

		vars.playerDisableActionFlag = PLAYER_DISABLE.FIRST_TALK

		
		s10030_radio.Approached()















	end,

	
	OnLeave = function ()
	end,


	
	OnUpdate = function ()
		this.CheckDistanceFromPlayerToOcelot(false)

		if mvars.isInterruptTalk == false and mvars.isApproachOcelot == true then
			if mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_1 then		
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				s10030_radio.Approached()	

			elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_2 then	
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				s10030_radio.GiveFulton_021()	

			elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_3 then	
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				s10030_radio.GiveFulton_022()	

			elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_4 then	
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
				GkEventTimerManager.Stop( "Timer_MonologueFailed" )
				TppSequence.SetNextSequence( "Seq_Demo_OcelotGiveFulton" )

			end
		end
	end,

}



sequences.Seq_Demo_OcelotGiveFulton = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			Timer = {
				
				{
					msg = "Finish",
					sender = "Timer_waitApproachOcelot",
					func = function ()
						s10030_radio.TalkingToApproach()	
					end
				},
			},
			
			GameObject = {
				
				{
					msg = "Down",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId)
						
						if (TppEnemy.GetLifeStatus(gameObjectId) == TppEnemy.LIFE_STATUS.SLEEP) then
						else
							
							s10030_radio.CrazyAction()
						end
					end
				},
				
				{
					msg = "Damage", 
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						if (attackId == TppDamage.ATK_10101)  then	
							s10030_radio.CrazyAction()	
						end
					end
				},
				
				{
					msg = "Carried",					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function  (gameObjectId, arg1)
						if arg1 == 0 then
							s10030_radio.CrazyAction()
						end
					end
				},
				
				{
					
					msg = "Restraint",					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function(gameObjectId, switch, releaseAction)
						if switch == 0 then
							
							s10030_radio.CrazyAction()
						else
							if (releaseAction == 2) or (releaseAction == 4) then
								
								s10030_radio.CrazyAction()
							end
						end
					end
				},
				{
					
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	
					end
				},
			nil
			}
		}
	end,



	
	OnEnter = function ()
		mvars.isInterruptTalk= false
		mvars.isCarried = false
		mvars.OcelotTooFarCount	=0	
		mvars.isStopFultonTalk = false
		mvars.ocerotTalkProcess = s10030_sequence.OCELOT_TALK_PROCESS.WAITING_1

		TppEnemy.UnsetSneakRoute( "Ocelot" )

	end,

	
	OnLeave = function ()
	end,


	
	OnUpdate = function ()
		this.CheckDistanceFromPlayerToOcelot(false)

		if mvars.isInterruptTalk == false then
			if mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_1 then
				if mvars.isInsideOcelotTrap == true then	
					GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
					s10030_radio.GiveFulton_023()	
				end
			elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_2 then	
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				GkEventTimerManager.Stop( "Timer_MonologueFailed" )
				TppSequence.SetNextSequence( "Seq_Demo_AfterOcelotGiveFulton" )	
			end
		end
	end,

}

sequences.Seq_Demo_AfterOcelotGiveFulton = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			Player = {
				{
					msg = "IconFultonShown",
					func = function ()

						if mvars.isFULTON_DEVICE == false then	
							mvars.isFULTON_DEVICE = true	
							
							GkEventTimerManager.Stop( "Timer_FULTON_DEVICE")
							GkEventTimerManager.Start( "Timer_FULTON_DEVICE", TIMER_TIPS_AGAIN )

							
							TppUI.ShowControlGuide{
								actionName = "HULTON",
								continue = false
							}
							
							this.displayTips( this.TIPS.FULTON_DEVICE)	
						end
					end
				},
			},

			
			GameObject = {
				
				{
					msg = "Fulton",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId, gimmckInstance, gimmckDataSet, staffID)
						Fox.Log("#### fulton  ####" .. gameObjectId)
						Fox.Log("#### DirectAddStaff staffId ####" .. staffID)

						GkEventTimerManager.Stop( "Timer_FultonDisable" )	
						mvars.isStopFultonTalk =true
					

						svars.FulltonCount = svars.FulltonCount + 1 
						TppMotherBaseManagement.DirectAddStaff{ staffId=staffID, section = "Develop" }

						Fox.Log("*** Seq_Demo_AfterOcelotGiveFulton skip by fulton ***")

						svars.isFultonFirstSoldier =true	

						GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
						GkEventTimerManager.Stop( "Timer_MonologueFailed" )
						TppSequence.SetNextSequence( "Seq_Game_FultonASodier" )
					end
				},
				
				{
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	
						if speechLabel == StrCode32("MBTS_024") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_024 end ####")
								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_2
							else
								s10030_radio.FailedRequest()
							end
						elseif speechLabel == StrCode32("MBTS_030") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_030 end ####")
								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_3
							else
								s10030_radio.FailedRequest()
							end
						end
					end
				},
			nil
			}
		}
	end,


	
	OnEnter = function ()
		mvars.isInterruptTalk= false
		mvars.isCarried = false
		mvars.OcelotTooFarCount	=0	
		mvars.isOcelotDamage= false	
		mvars.isFULTON_DEVICE = false	
		mvars.ocerotTalkProcess = s10030_sequence.OCELOT_TALK_PROCESS.WAITING_1

		TppEnemy.SetSneakRoute( "Ocelot", "rts_oc_stnd" )
		s10030_enemy.OcelotAction()

		TppUiStatusManager.ClearStatus("AnnounceLog")	

		Fox.Log("#### now enable fulton  ####")	
		svars.restartSeq = RESTART_SEQUENCE.GIVEN_FULTON
		vars.playerDisableActionFlag = PLAYER_DISABLE.GIVEN_FULTON
	end,

	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	
		s10030_enemy.SetSaluteNormalAll()
		
		svars.restartSeq = RESTART_SEQUENCE.GIVEN_FULTON
		Fox.Log("*** svars.restartSeq = " .. svars.restartSeq .. "!!")

		
	

	end,


	
	OnUpdate = function ()
		this.CheckDistanceFromPlayerToOcelot(true)

		
		if mvars.isInterruptTalk == false and mvars.isApproachOcelot == true then
			if mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_1 then
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				
				s10030_radio.GiveFulton_024()

			elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_2 then
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				
				s10030_radio.GiveFulton_030()

				
				if (this.GetDistanceFromPlayer("sol_plant0_0000", "TppSoldier2" ) > DISTANCE_APPROACH_FIRST_FULTON) then
					Fox.Log("#### wake up sol_plant0_0000  too far  ####")
					s10030_enemy.SetEnemyWakeUp( "sol_plant0_0000" )
				end

			elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_3 then

				
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
				GkEventTimerManager.Stop( "Timer_MonologueFailed" )
				TppSequence.SetNextSequence( "Seq_Game_FultonASodier" )
			end

			
			local checkDevelopSectionLv = TppMotherBaseManagement.GetSectionLv{ section="Develop" }      
			if checkDevelopSectionLv  >= DEVELOP_LV_BOX then 	
				
				svars.isReserve_06 = true	
				if svars.isReserve_07 ==true and svars.isReserve_14 ==false then 	
					svars.isReserve_14 = true	
					TppMission.UpdateObjective{objectives = { "task1_complete" },}	
					TppMission.UpdateObjective{objectives = { "task2_start" },}	
				end
			end
		end
	end,

}


sequences.Seq_Game_FultonASodier = {
	
	Messages = function( self ) 
		return
		StrCode32Table {

			Timer = {
				
				{
					msg = "Finish",
					sender = "Timer_waitApproachOcelot",
					func = function ()
						if mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_2 then	
							s10030_radio.WaitingApproach()	
						else							
							s10030_radio.TalkingToApproach()
						end
						
						GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
						GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME )
					end
				},
				
				{
					msg = "Finish",
					sender = "Timer_FultonDisable",
					func = function ()
						this.ResetFulton()
					end
				},
				
				{
					msg = "Finish",
					sender = "Timer_NeverFulton",
					func = function ()
						if mvars.isStopFultonTalk == false or svars.FulltonCount == svars.LastFultonCount then 
							this.ocelotGuideFirstFultonAgain()	
						end
					end
				},
				
				{
					msg = "Finish",
					sender = "Timer_FultonStart",
					func = function ()
						if svars.isFultonFirstSoldier ==false then	
							s10030_radio.FirstFultonStart()	
						else
						end
					end
				},
			},
			
			GameObject = {
				
				{
					msg = "Carried",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function  (gameObjectId, arg1)
						if mvars.isStopFultonTalk == false then
							if arg1 == 0 then
								if mvars.isStopCarriedTalk == false and mvars.isStopFultonTalk == false then
									
									s10030_radio.CarriedStart()
									mvars.isStopCarriedTalk = true
								else
								end
								mvars.isCarried	= true	
							else
								if mvars.isStopFultonTalk == false then
									
									s10030_radio.CarriedEnd()
								else
								end

							end
						end
					end
				},
				
				{
					msg = "Down",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameobjectId)	
						
						local GetGameObjectId =  gameobjectId 
						if (TppEnemy.GetLifeStatus( GetGameObjectId ) == TppEnemy.LIFE_STATUS.SLEEP) then
							if mvars.isCarried == false then	
								if mvars.isStopDownTalk == false and mvars.isStopFultonTalk == false and svars.isFultonFirstSoldier == false then	
									
									s10030_radio.SuccessSleep()
									mvars.isStopDownTalk = true
								else
								end
							else
								mvars.isCarried = false
							end
							
						elseif (TppEnemy.GetLifeStatus(  GetGameObjectId  ) == TppEnemy.LIFE_STATUS.FAINT) then
							if mvars.isCarried == false then	
								if mvars.isSleepBulletEmptyTalk ==true	then
									if mvars.isStopDownTalk == false and mvars.isStopFultonTalk == false and svars.isFultonFirstSoldier ==false then	
										
										s10030_radio.SuccessFaint()
										mvars.isStopDownTalk = true
									else
									end
								else
									if mvars.isStopDownTalk == false and mvars.isStopFultonTalk == false and svars.isFultonFirstSoldier ==false then	
										
										s10030_radio.DoneDifferentAction2()
										mvars.isStopDownTalk = true
									else
									end
								end
							else
								mvars.isCarried = false
							end
						else
							if mvars.isStopDownTalk == false and mvars.isStopFultonTalk == false and svars.isFultonFirstSoldier ==false then	
								
								s10030_radio.TryAgain1()
							else
							end
							
						end
					end
				},
				
				{
					msg = "Damage", 
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						if (attackId == TppDamage.ATK_10101)  then	
							Fox.Log("## DD soldier sleep bullet hit ##")	
							if mvars.isStopFultonTalk == true then
							end
						end
					end
				},
				
				{
					
					msg = "Restraint",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function(gameObjectId, switch, releaseAction)
						if switch == 0 then
							if mvars.isStopFultonTalk == false
									and svars.isFultonFirstSoldier ==false then	
									
									s10030_radio.RestraintStart()
							else
							end
						else
							if (releaseAction == 1) or (releaseAction == 0) then
								if mvars.isStopFultonTalk == false
										and svars.isFultonFirstSoldier ==false then	
									
									s10030_radio.RestraintEnd()
								else
								end
							end
						end
					end
				},
				
				{
					msg = "Fulton",
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId, gimmckInstance, gimmckDataSet, staffID)
						Fox.Log("#### fulton  ####" .. gameObjectId)
						Fox.Log("#### DirectAddStaff staffId ####" .. staffID)
					
					
						GkEventTimerManager.Stop( "Timer_FultonDisable" )	
						mvars.isStopFultonTalk =true
					

						svars.FulltonCount = svars.FulltonCount + 1 
						TppMotherBaseManagement.DirectAddStaff{ staffId=staffID, section = "Develop" }

						if 	svars.isFultonFirstSoldier ==false then	
							Fox.Log("#### fulton first time #####")

							svars.isFultonFirstSoldier =true	
							s10030_radio.ExplainFultonRule()
						else
							Fox.Log("#### already fulton soldier #####")
						end
					end
				},
				
				{
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	
						GkEventTimerManager.Stop( "Timer_NeverFulton")
						GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )

						
						if (speechLabel == StrCode32( "MBTS_040" ) and isSuccess ~= 0) then
							
							s10030_radio.PleaseFultonFirst()

						
						elseif (speechLabel == StrCode32( "MBTS_042" ) and isSuccess ~= 0) or (speechLabel == StrCode32( "MBTS_280" ) and isSuccess ~= 0) then
							
							s10030_radio.PleaseFulton()

						
						elseif (speechLabel == StrCode32( "MBTS_031" ) and isSuccess ~= 0) then	
							
								
								s10030_radio.TalkAboutTranq()
							
						elseif (speechLabel == StrCode32( "MBTS_030" ) and isSuccess ~= 0) 			
								or (speechLabel == StrCode32( "MBTS_045" ) and isSuccess ~= 0) 		
								or (speechLabel == StrCode32( "MBTS_160" ) and isSuccess ~= 0) then	
							mvars.isStopFultonTalk = false

						elseif speechLabel == StrCode32( "MBTS_050" ) then
							Fox.Log("#### MBTS_050 end ####")
							mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_2	
							mvars.isInterruptTalk= false	

						elseif speechLabel == StrCode32("MBTS_051") then	
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_051 end ####")
								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_3	
								mvars.isInterruptTalk= false	
							else
								s10030_radio.FailedRequest()
							end

						elseif speechLabel == StrCode32("MBTS_052") then	
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_052 end ####")
								GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
								GkEventTimerManager.Stop( "Timer_MonologueFailed" )
								TppSequence.SetNextSequence( "Seq_Game_TutorialDevelop10" )
							else
								s10030_radio.FailedRequest()
							end
						end

						if mvars.ocerotTalkProcess >= this.OCELOT_TALK_PROCESS.WAITING_2 then
							GkEventTimerManager.Stop( "Timer_waitApproachOcelot")
							GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME_TALK )
						end
					end
				},
			},
			Player = {
				{
					msg = "IconFultonShown",
					func = function ()

						if mvars.isFULTON_DEVICE == false then	
							mvars.isFULTON_DEVICE = true	
	
							GkEventTimerManager.Stop( "Timer_FULTON_DEVICE")
							GkEventTimerManager.Start( "Timer_FULTON_DEVICE", TIMER_TIPS_AGAIN )
							
							TppUI.ShowControlGuide{
								actionName = "HULTON",
								continue = false
							}
							this.displayTips( this.TIPS.FULTON_DEVICE)	
						end
					end
				},
				{
					msg = "EnableCQC",
					func = function ()
						if svars.isSleepBulletEmpty == true  then
						
						
						
						
						
						end
					end
				},
				{
				
					msg = "PlayerFulton",
					func = function ()
						Fox.Log("####PlayerFulton ####")
						mvars.isStopRepeatTalk = true	

						if mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_1 then
							this.StartFulton()
							GkEventTimerManager.Stop( "Timer_FultonStart")
							GkEventTimerManager.Start( "Timer_FultonStart", TIMER_WAIT_DELAY_FULTON_START  )
							GkEventTimerManager.Stop( "Timer_NeverFulton" )	
							GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )
						end
					end

				},

			nil
			}
		}
	end,


	
	OnEnter = function ()
		mvars.isFULTON_DEVICE = false	
		mvars.OcelotTooFarCount	=0	
		mvars.isCarried = false
		mvars.isStopFultonTalk = false	
		mvars.isStopRepeatTalk = false
		mvars.isStopDownTalk = false
		mvars.isStopCarriedTalk = false

		this.EnableFulton()	
		GkEventTimerManager.Stop( "Timer_NeverFulton" )	
		GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )

		TppUiStatusManager.ClearStatus("AnnounceLog")	

		
	
			
			TppEnemy.SetSneakRoute( ddSoldiersTable.TUTORIAL_FULTON_00.NAME, ddSoldiersTable.TUTORIAL_FULTON_00.ROUTE_FIGHT )
	
		s10030_enemy.SetSaluteCQCAll()

		
		GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	

		mvars.ocerotTalkProcess = s10030_sequence.OCELOT_TALK_PROCESS.WAITING_1 	
		this.ocelotGuideFirstFulton()	

		this.LandingZoneForRestart()
	end,

	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	
		s10030_enemy.SetSaluteNormalAll()
	end,

	
	OnUpdate = function ()
		if mvars.ocerotTalkProcess >=  this.OCELOT_TALK_PROCESS.WAITING_2 then
			this.CheckDistanceFromPlayerToOcelot(false)
		else
			this.CheckDistanceFromPlayerToOcelot(true)
		end

		
		if mvars.isApproachOcelot == true then
			if mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_2 then	
				s10030_enemy.SetIdleRoute()	
				s10030_enemy.SetSaluteNormalAll()
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				s10030_radio.ExplainFultonRule_051()	

			elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_3 then	
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				s10030_radio.ExplainFultonRule_052()	

			end
		end

		
		local checkDevelopSectionLv = TppMotherBaseManagement.GetSectionLv{ section="Develop" }      
		if checkDevelopSectionLv  >= DEVELOP_LV_BOX then 	
			
			svars.isReserve_06 = true	
			if svars.isReserve_07 ==true and svars.isReserve_14 ==false then 	
				svars.isReserve_14 = true	
				TppMission.UpdateObjective{objectives = { "task1_complete" },}	
				TppMission.UpdateObjective{objectives = { "task2_start" },}	
			end
		end

	end,
}


function this.StartFulton()
	Fox.Log("####StartFulton ####")
	this.DisableFulton()	
	GkEventTimerManager.Stop( "Timer_FultonDisable" )	
	GkEventTimerManager.Start( "Timer_FultonDisable", TIMER_FULTON )	
	GkEventTimerManager.Stop( "Timer_NeverFulton" )	
end


function this.ResetFulton()
	Fox.Log("####ResetFulton ####")
	this.EnableFulton()	
	mvars.isStopFultonTalk = false	
	
	GkEventTimerManager.Stop( "Timer_NeverFulton" )	
	GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )
end


function this.ocelotGuideFirstFulton()
	if	svars.isFultonFirstSoldier ==true then	
		s10030_radio.ExplainFultonRule()	

	else	
		mvars.isStopRepeatTalk = false	

		
		if (TppEnemy.IsNeutralized(ddSoldiersTable.TUTORIAL_FULTON_00.NAME) == true) then
			
			s10030_radio.PleaseFultonFirst()
		else
			if svars.isSleepBulletEmpty == true  then
			
				mvars.isSleepBulletEmptyTalk=true	
				s10030_sequence.displayTips( s10030_sequence.TIPS.SLEEP_BULLET)	
				s10030_radio.PleaseFaint()
			else
			
				s10030_radio.MakeThemSleep()
			
			end
		end
	end

end


function this.ocelotGuideFirstFultonAgain()
		
		if (TppEnemy.IsNeutralized(ddSoldiersTable.TUTORIAL_FULTON_00.NAME) == true) then
			
			s10030_radio.PleaseFulton()
		else
			if svars.isSleepBulletEmpty == true  then
				
				mvars.isSleepBulletEmptyTalk=true	
				s10030_radio.PleaseFaint()
			else
				
				s10030_radio.PleaseSleep()
	
			end
		end
end



sequences.Seq_Game_TutorialDevelop10 = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			
			Terminal = {
				{
				
					msg = "MbDvcActOpenTop",
					func = function()
						Fox.Log(" s10030_seq Receive : MbDvcActOpenTop On Seq_Game_TutorialDevelop10 ")
						
						GkEventTimerManager.Stop( "Timer_waitOpenTerminal")	

						if mvars.isSelectStaffList == false then	
							
							GkEventTimerManager.Stop( "Timer_PleaseSelectStaffManagement")
							GkEventTimerManager.Start( "Timer_PleaseSelectStaffManagement", TIMER_WAIT_DELAY_MONOLOGUE  )
						end
						
						if mvars.isDevelopFinish_Dev20 == true then
							this.ClearTerminalControl_OnTutoDev20()
						else
						
							self.SetTerminalControl_OnTutoDev10()
						end

					end
				},
				
				{
					msg = "MbDvcActOpenStaffList",
					func = function()
						mvars.isSelectStaffList	= true

						
						GkEventTimerManager.Stop( "Timer_waitOpenTerminal")	
					

						s10030_radio.ExplainDevelop10_10()

						
						this.SetMbDvcDevelopTutotrial()
						
						this.ClearTerminalAttentionIcon()
						this.SetTerminalAttentionIcon(TppTerminal.MBDVCMENU.MBM_DEVELOP_WEAPON, true )

						TppUiStatusManager.SetStatus( "Popup", "BLOCK_CANCEL_DIALOGUE")	

					end
				},

				
				{
					msg = "MbDvcActOpenMenu",
					func = function()
						Fox.Log("#### MbDvcActOpenMenu ####")


						if mvars.isCanCloseStaffList == true and mvars.isBackMotherBaseTopMemu == false then 

							Fox.Log("#### Timer_waitSelectDevelopment start ####")
							GkEventTimerManager.Stop( "Timer_BackMotherBaseTopMemu")

							
							GkEventTimerManager.Stop( "Timer_waitSelectDevelopment")
							GkEventTimerManager.Start( "Timer_waitSelectDevelopment", TIMER_WAIT_OPEN_TERMINAL )

							if mvars.isTalkMotherBaseTopMemu == true then
								
								s10030_radio.PleaseSelectDevelopment()	
							end

							mvars.isBackMotherBaseTopMemu	= true	
						end

					end
				},
				
				{
					msg = "MbDvcActCloseTop",
					func = function ()

						
						if mvars.isSpeechedOcelot_DEV10 == true then
							mvars.isCloseUi_DEV10	= true
							GkEventTimerManager.Stop( "Timer_waitCloseTerminal")


							
							GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
							GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME )
							
						
						else
							
							
							TppUiStatusManager.ClearStatus( "MbStaffList" )
							TppUiStatusManager.ClearStatus( "MbEquipDevelop" )
							TppUiStatusManager.ClearStatus( "PauseMenu" )

							
							TppUiStatusManager.SetStatus( "MbEquipDevelop", "BLOCK_TAB" )	

							
							this.ClearTerminalAttentionIcon()

							
							TppUiCommand.SetEnableMenuCancelClose( true )


						
						
						
						end

						
						if mvars.isDevelopFinish_Dev20 == true then
							if svars.isReserve_04 == false then	
								svars.isReserve_04 =true
								this.displayTips(s10030_sequence.TIPS.SUPPLY_TOOL)	
							end
							this.ClearTerminalControl_OnTutoDev20()
						end
					end
				},

			},
			MotherBaseManagement = {
				
				{
					msg = "MbDvcActOpenDevelopEquip",
					
					func = function ()
						if mvars.isSpeechedOcelot_Develop_first ~= true then
							mvars.isSpeechedOcelot_Develop_first = true
							GkEventTimerManager.Stop( "Timer_waitOpenTerminal")	
							GkEventTimerManager.Stop( "Timer_waitSelectDevelopment")

							
							s10030_radio.ExplainDevelop10_20()
						end

					end
				},
				
				{
					msg = "MbDvcActDecideDevelopEquip",
					func = function()
						Fox.Log("*** Receive MbDvcActDecideDevelopEquip ***")
						
						mvars.isDevelopFinish_Dev20 = true
					end
				},
				
				{
					msg = "MbDvcActRunDevelopEquip",
					func = function()
						s10030_radio.DevelopComplete()
					
					end
				},
				
				{
					msg = "MbDvcActDecideSupportEquip",
					func = function()
						Fox.Log("*** Receive MbDvcActDecideSupportPoint ***")

						
						GkEventTimerManager.Stop( "Timer_waitAboutSupply")
						GkEventTimerManager.Start( "Timer_waitAboutSupply", TIMER_WAIT_DELAY_MONOLOGUE_LONG )
					end
				},
			},
			Timer = {
				{
					
					msg = "Finish",
					sender = "Timer_waitOpenTerminal",
					func = function ()
						Fox.Log("*** Timer_waitOpenTerminal ***")


						
						s10030_radio.PleaseOpenDvc()
						
						GkEventTimerManager.Stop( "Timer_waitOpenTerminal")
						GkEventTimerManager.Start( "Timer_waitOpenTerminal", TIMER_WAIT_OPEN_TERMINAL )
					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_PleaseSelectStaffManagement",
					func = function ()
						Fox.Log("*** Timer_PleaseSelectStaffManagement ***")
						
						GkEventTimerManager.Stop( "Timer_waitSelectStaffList")
						GkEventTimerManager.Start( "Timer_waitSelectStaffList", TIMER_WAIT_OPEN_TERMINAL )

						s10030_radio.PleaseSelectStaffManagement()
					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_waitSelectStaffList",
					func = function ()
						Fox.Log("*** Timer_waitSelectStaffList ***")

						if mvars.isSelectStaffList	== false then	
							
							GkEventTimerManager.Stop( "Timer_waitSelectStaffList")
							GkEventTimerManager.Start( "Timer_waitSelectStaffList", TIMER_WAIT_OPEN_TERMINAL )

							s10030_radio.PleaseSelectRedMarker()
						end

					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_BackMotherBaseTopMemu",
					func = function ()
						Fox.Log("*** Timer_BackMotherBaseTopMemu ***")
							if mvars.isBackMotherBaseTopMemu	== false then	
							
							GkEventTimerManager.Stop( "Timer_BackMotherBaseTopMemu")
							GkEventTimerManager.Start( "Timer_BackMotherBaseTopMemu", TIMER_WAIT_OPEN_TERMINAL )
							mvars.isTalkMotherBaseTopMemu	= true	

							s10030_radio.PleaseBackMotherBaseMenu()
						end

					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_waitSelectDevelopment",
					func = function ()
						Fox.Log("*** Timer_waitSelectDevelopment ***")
	
						if mvars.isSpeechedOcelot_Develop_first	== false then	
							
							GkEventTimerManager.Stop( "Timer_waitSelectDevelopment")
							GkEventTimerManager.Start( "Timer_waitSelectDevelopment", TIMER_WAIT_OPEN_TERMINAL )

							s10030_radio.PleaseSelectRedMarker()
						end

					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_waitDevelopBox",
					func = function ()
						Fox.Log("*** Timer_waitDevelopBox ***")

						if mvars.isDevelopFinish_Dev20	== false then	
							
							GkEventTimerManager.Stop( "Timer_waitDevelopBox")
							GkEventTimerManager.Start( "Timer_waitDevelopBox", TIMER_WAIT_OPEN_TERMINAL )

							s10030_radio.PleaseDevelopBox()
						end

					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_waitCloseTerminal",
					func = function ()
						Fox.Log("*** Timer_waitCloseTerminal ***")
							
						if mvars.isSpeechedOcelot_DEV10	== true	and mvars.isCloseUi_DEV10 == false then	

							
							GkEventTimerManager.Stop( "Timer_waitCloseTerminal")
							GkEventTimerManager.Start( "Timer_waitCloseTerminal", TIMER_WAIT_OPEN_TERMINAL )

							s10030_radio.PleaseCloseTerminal()

						end

					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_waitApproachOcelot",
					func = function ()
						
						GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
						GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME )

						s10030_radio.TalkingToApproach()		
					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_waitAboutSupply",
					func = function ()
						s10030_radio.AboutSupply()
					end
				},
			},
			GameObject = {
				{
				
					msg = "Fulton",
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId, gimmckInstance, gimmckDataSet, staffID)
						Fox.Log("#### fulton  ####" .. gameObjectId)
						Fox.Log("#### DirectAddStaff staffId ####" .. staffID)

						
						TppMotherBaseManagement.DirectAddStaff{ staffId=staffID, section = "Develop" }
								
						GkEventTimerManager.Stop( "Timer_FultonDisable" )	

						svars.FulltonCount = svars.FulltonCount + 1 

						if 	svars.isFultonFirstSoldier ==false then	
							Fox.Log("#### fulton first time #####")
							svars.isFultonFirstSoldier =true	
						else
							Fox.Log("#### already fulton soldier #####")
						end
					end
				
					
				},
				{
					
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	
						local developSectionLv
						
						if (speechLabel == StrCode32( "MBTS_060") and isSuccess ~= 0) then
							Fox.Log("#### MBTS_060 end ####")
							
							TppUiStatusManager.UnsetStatus( "MbStaffList", "BLOCK_CANCEL" )
	
							s10030_radio.PleaseSelectDevelopment()	

							
							GkEventTimerManager.Stop( "Timer_BackMotherBaseTopMemu")
							GkEventTimerManager.Start( "Timer_BackMotherBaseTopMemu", TIMER_WAIT_OPEN_TERMINAL )

							mvars.isCanCloseStaffList	= true	
		
							local developSectionLv = TppMotherBaseManagement.GetSectionLv{ section="Develop" }      
							if developSectionLv  < DEVELOP_LV_BOX then 	
								Fox.Log("#### cannot develop box #### Develop Lv " .. developSectionLv)
							else	

								Fox.Log("#### can develop box BLOCK_CANCEL_DEVELOP_DIALOG #### Develop Lv " .. developSectionLv)
								
								TppUiStatusManager.SetStatus( "MbEquipDevelop", "BLOCK_CANCEL_DEVELOP_DIALOG" )
								
								TppUiStatusManager.SetStatus( "MbMapDropItem", "BLOCK_CANCEL" )
							end

						
						elseif (speechLabel == StrCode32( "MBTS_055") and isSuccess ~= 0) then
							Fox.Log("#### MBTS_055 end ####")
							TppUI.ShowControlGuide{ actionName = "MB_DEVICE", continue = false }

						
						elseif (speechLabel == StrCode32( "MBTS_070") and isSuccess ~= 0) then
							Fox.Log("#### MBTS_070 end ####")
							developSectionLv = TppMotherBaseManagement.GetSectionLv{ section="Develop" }      
							if developSectionLv  < DEVELOP_LV_BOX then 	
								Fox.Log("#### cannot develop box #### Develop Lv " .. developSectionLv)
								
								s10030_radio.ExplainDevelop10_20_1()
							else	
								Fox.Log("#### can develop box #### Develop Lv " .. developSectionLv)
								mvars.isCanDevelopBox =true	
								
								if mvars.isDevelopFinish_Dev20 == true then
									Fox.Log("#### already develop box ")
									
									s10030_radio.ExplainDevelop10_20_BoxDeveloped()	
								else
									Fox.Log("#### not develop box ")
									
									s10030_radio.ExplainDevelop10_20_DevelopBox()
								end
							end

						
						elseif (speechLabel == StrCode32( "MBTS_071") and isSuccess ~= 0) then
							developSectionLv = TppMotherBaseManagement.GetSectionLv{ section="Develop" }      
							if developSectionLv  < DEVELOP_LV_BOX then 	
								Fox.Log("#### cannot develop box #### Develop Lv " .. developSectionLv)
								s10030_radio.ExplainDevelop10_20_2()
							else	
							end

						elseif (speechLabel == StrCode32( "MBTS_490")) or (speechLabel == StrCode32( "MBTS_076")) then
							Fox.Log("#### MBTS_211 end ####")
							Fox.Log("#### skip Seq_Game_TutorialDevelop20 by fulton ####")
							mvars.isSkipDevelopBox =  true
							mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_5	
							TppUiStatusManager.ClearStatus( "PauseMenu" )

							svars.isReserve_14 = true	
							TppMission.UpdateObjective{objectives = { "task1_complete" },}	
							TppMission.UpdateObjective{objectives = { "task2_start" },}	

							
							GkEventTimerManager.Stop( "Timer_waitDevelopBox")
							GkEventTimerManager.Start( "Timer_waitDevelopBox", TIMER_WAIT_OPEN_TERMINAL )

							TppSequence.SetNextSequence( "Seq_Game_TutorialDevelop20" )

						elseif (speechLabel == StrCode32( "MBTS_072") and isSuccess ~= 0) then
							Fox.Log("#### MBTS_071 end ####")
							mvars.isSkipDevelopBox =  false

						
							TppUiStatusManager.ClearStatus( "MbStaffList" )
							TppUiStatusManager.ClearStatus( "MbEquipDevelop" )	
							TppUiStatusManager.ClearStatus( "PauseMenu" )
							TppUiStatusManager.ClearStatus( "MbTop" )
							TppUiStatusManager.ClearStatus( "Popup" )

							
							TppUiCommand.SetEnableMenuCancelClose( true )

							
							TppUiStatusManager.SetStatus( "MbEquipDevelop", "BLOCK_TAB" )	
							TppUiCommand.RegisterForceDropItemPosition( Vector3(9.52,0.8,-22.932) )	
							TppUiStatusManager.SetStatus( "MbMapDropItem", "BLOCK_SCROLL" )	

							
							this.ClearTerminalAttentionIcon()

							
							TppUiCommand.SetEnableMenuCancelClose( true )
							
							this.SetMbDvcDefault()


						
						
						
							
							mvars.isSpeechedOcelot_DEV10 = true
							
							GkEventTimerManager.Stop( "Timer_waitCloseTerminal")
							GkEventTimerManager.Start( "Timer_waitCloseTerminal", TIMER_WAIT_DELAY_MONOLOGUE )

						end
					end
				},
			nil
			}
		}
	end,


	
	OnEnter = function ( self )

		mvars.isSelectStaffList	= false	
		mvars.isCanCloseStaffList	= false	
		mvars.isTalkMotherBaseTopMemu	= false	
		mvars.isBackMotherBaseTopMemu	= false	
		mvars.isCanCloseDevelopmentFirst= false	
		mvars.isSpeechedOcelot_DEV10 = false	
		mvars.isSpeechedOcelot_Develop_first	= false 
		mvars.isCanDevelopBox	= false	
		mvars.OcelotTooFarCount	=0	
		mvars.isCloseUi_DEV10	= false	
		mvars.isInterruptTalk= false	
	

		
		this.SetMbDvcStaffListTutotrial()
		
		TppUiCommand.RequestMbDvcOpenCondition{ isTopModeMotherBase=true }


	


		
		this.ClearTerminalAttentionIcon()
		this.SetTerminalAttentionIcon(TppTerminal.MBDVCMENU.MBM_STAFF, true)

		self.SetTerminalControl_OnTutoDev10()	
		
		
		GkEventTimerManager.Stop( "Timer_waitOpenTerminal")
		GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )

		if mvars.isOpenTerminal == true then
			Fox.Log("*** Terminal Opened ***")
			s10030_radio.PleaseSelectStaffManagement()

			
			GkEventTimerManager.Stop( "Timer_waitSelectStaffList")
			GkEventTimerManager.Start( "Timer_waitSelectStaffList", TIMER_WAIT_OPEN_TERMINAL )
		else	
	
			Fox.Log("*** Terminal not Opened ***")
			TppUI.ShowControlGuide{ actionName = "MB_DEVICE", continue = false }	
			GkEventTimerManager.Start( "Timer_waitOpenTerminal", TIMER_WAIT_OPEN_TERMINAL )
		end

	end,

	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	

		s10030_enemy.SetSaluteNormalAll()
		
		this.SetMbDvcDefault()
	end,

	
	OnUpdate = function ()
		this.CheckDistanceFromPlayerToOcelot(true)

		if mvars.isCloseUi_DEV10 == true then	
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
			
			TppSequence.SetNextSequence( "Seq_Game_TutorialCQC10" )
		end

		
		local checkDevelopSectionLv = TppMotherBaseManagement.GetSectionLv{ section="Develop" }      
		if checkDevelopSectionLv  >= DEVELOP_LV_BOX then 	
			
			svars.isReserve_06 = true	
			if svars.isReserve_07 ==true  and svars.isReserve_14 ==false then 	
				svars.isReserve_14 = true	

				TppMission.UpdateObjective{objectives = { "task1_complete" },}	
				TppMission.UpdateObjective{objectives = { "task2_start" },}	
			end
		end
	end,

	SetTerminalControl_OnTutoDev10 = function ()
		
		TppUiStatusManager.SetStatus( "MbTop", "BLOCK_CANCEL" )

		
		TppUiStatusManager.SetStatus( "MbStaffList", "BLOCK_DECIDE" )
		TppUiStatusManager.SetStatus( "MbStaffList", "BLOCK_CANCEL" )
		TppUiStatusManager.SetStatus( "MbStaffList", "BLOCK_ASSIGN" )

		TppUiStatusManager.SetStatus( "MbEquipDevelop", "BLOCK_CANCEL_SUPPORT_DIALOG" )

		
		TppUiStatusManager.SetStatus( "MbEquipDevelop", "BLOCK_TAB" )	
		TppUiStatusManager.SetStatus( "MbEquipDevelop", "BLOCK_CANCEL" )	
		TppUiCommand.RegisterForceDropItemPosition( Vector3(9.52,0.8,-22.932) )	
		TppUiStatusManager.SetStatus( "MbMapDropItem", "BLOCK_SCROLL" )	

	

		
		TppUiCommand.SetEnableMenuCancelClose( false )

		
		
	
	
	
	
	
	
	
	
	
	
	
	

	end,
}


sequences.Seq_Game_TutorialCQC10 = {
	
	Messages = function( self ) 
		return
		StrCode32Table {

			Timer = {
				{
					
					msg = "Finish",
					sender = "Timer_waitApproachOcelot",
					func = function ()
						
						
						if mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.TALKING_1 or mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_5 then
							s10030_radio.WaitingApproach()	
						else
							s10030_radio.TalkingToApproach()		
						end
						
						GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
						GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME_TALK )
					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_FultonDisable",
					func = function ()
						this.ResetFulton()
					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_NeverFulton",
					func = function ()
						if mvars.isStopFultonTalk == false 
								or svars.FulltonCount == svars.LastFultonCount then 
							s10030_radio.PleaseFulton()	
							
							GkEventTimerManager.Stop( "Timer_NeverFulton" )	
							GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )
						end
					end
				},
				
				{
					msg = "Finish",
					sender = "Timer_FultonStart",
					func = function ()
						if svars.isFultonSecondSoldier == false then	
							if mvars.ocerotTalkProcess >= this.OCELOT_TALK_PROCESS.WAITING_3 and mvars.ocerotTalkProcess <= this.OCELOT_TALK_PROCESS.WAITING_4 then
								s10030_radio.FultonStart()	
								mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_4
							end
						else
						end
					end
				},
				
				{
					msg = "Finish",
					sender = "Timer_waitCQC",
					func = function ()
						s10030_radio.PleaseCQC()
						
						GkEventTimerManager.Stop( "Timer_waitCQC" )
						GkEventTimerManager.Start( "Timer_waitCQC", TIMER_TIME_FULTON_AGAIN )
					end
				},

			},
			
			GameObject = {
				
				{
					msg = "Carried",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function  (gameObjectId, arg1)
						if mvars.isStopFultonTalk == false then
							if arg1 == 0 then
								if mvars.isStopCarriedTalk == false and mvars.isStopFultonTalk == false then
									
									s10030_radio.CarriedStart()
									mvars.isStopCarriedTalk = true
								else
								end
								mvars.isCarried	= true	
							else
								if mvars.isStopFultonTalk == false then
									
									s10030_radio.CarriedEnd()
								else
								end

							end
						end
					end
				},
				
				{
					
					msg = "Restraint",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function(gameObjectId, switch, releaseAction)
						if switch == 0 then
							if mvars.isStopFultonTalk == false
									and svars.isFultonFirstSoldier ==false then	
									
									s10030_radio.RestraintStart()
							else
							end
						else
							if (releaseAction == 1) or (releaseAction == 0) then
								if mvars.isStopFultonTalk == false
										and svars.isFultonFirstSoldier ==false then	
									
									s10030_radio.RestraintEnd()
								else
								end
							end
						end
					end
				},
				{
					
					msg = "Damage", 
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						mvars.actionOnCQC10 = this.IsWrongAction( attackId, { TppDamage.ATK_CqcThrow, TppDamage.ATK_CqcThrowWall, TppDamage.ATK_CqcThrowBehind } )
						if attackId == TppDamage.ATK_CqcContinuous2nd then	
							if svars.isReserve_08	== false then	
								svars.isReserve_08	= true	

								s10030_radio.ExplainChainCQC()
								this.displayTips(s10030_sequence.TIPS.CQC_RAPID)	
							end
						end
					end
				},

				{
					msg = "Down",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameobjectId)
						local GetGameObjectId =  gameobjectId
						if mvars.ocerotTalkProcess < this.OCELOT_TALK_PROCESS.WAITING_5 then
							if (TppEnemy.GetLifeStatus( GetGameObjectId ) == TppEnemy.LIFE_STATUS.FAINT) then
								if mvars.isStopDownTalk == false and mvars.isStopFultonTalk == false then
									mvars.isSpeechedOcelot_CQC_THOROW = true	
									GkEventTimerManager.Stop( "Timer_waitCQC" )

									if mvars.actionOnCQC10 == TUTORIAL_RESULT.SUCCESS then
										
										Fox.Log("*** CQC SUCCESS ***")
										s10030_radio.SuccessCQC()
										mvars.isStopDownTalk = true
										GkEventTimerManager.Stop( "Timer_NeverFulton" )	
										GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )
									elseif mvars.actionOnCQC10 == TUTORIAL_RESULT.FAILED then
										
										
										Fox.Log("*** CQC FAILED ***")
										s10030_radio.DoneDifferentAction()
										mvars.isStopDownTalk = true
										GkEventTimerManager.Stop( "Timer_NeverFulton" )	
										GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )
									end
								else
								end
							elseif (TppEnemy.GetLifeStatus( GetGameObjectId ) == TppEnemy.LIFE_STATUS.SLEEP) then
								if mvars.isStopDownTalk == false and mvars.isStopFultonTalk == false then
									
									
									GkEventTimerManager.Stop( "Timer_waitCQC" )

									s10030_radio.DoneDifferentAction()
									mvars.isStopDownTalk = true
									GkEventTimerManager.Stop( "Timer_NeverFulton" )	
									GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )
								else
								end
							else
								if mvars.isStopDownTalk == false and mvars.isStopFultonTalk == false then	
									
									s10030_radio.TryAgain2()
								else
								end
							end
						end
					end
				},
				
				{
					msg = "Fulton",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId, gimmckInstance, gimmckDataSet, staffID)
						Fox.Log("#### fulton  ####" .. gameObjectId)
						Fox.Log("#### DirectAddStaff staffId ####" .. staffID)

						mvars.isStopFultonTalk =true
						svars.FulltonCount = svars.FulltonCount + 1 
						GkEventTimerManager.Stop( "Timer_FultonDisable" )	

						TppMotherBaseManagement.DirectAddStaff{ staffId=staffID, section = "Develop" }

						if 	svars.isFultonSecondSoldier  ==false then	
							Fox.Log("#### fulton second time #####")

							svars.isFultonSecondSoldier  =true	
							
							s10030_radio.ExplainFultonRule2()

							GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
							GkEventTimerManager.Stop( "Timer_MonologueFailed" )
						else
							Fox.Log("#### already fulton second soldier #####")
						end

					end
				},
				
				{
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	

						if speechLabel == StrCode32("MBTS_100") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_100 end ####")
								mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_2
								mvars.isInterruptTalk= false	
							else
								s10030_radio.FailedRequest()
							end

						elseif speechLabel == StrCode32("MBTS_101") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_101 end ####")
								mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_3
								mvars.isInterruptTalk= false	
							else
								s10030_radio.FailedRequest()
							end

						elseif speechLabel == StrCode32("MBTS_130") then
							Fox.Log("#### MBTS_130 end ####")
							mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_4
							mvars.isInterruptTalk= false	

						elseif speechLabel == StrCode32("MBTS_050") then
							Fox.Log("#### MBTS_050 end ####")
							mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_5

						elseif speechLabel == StrCode32("MBTS_141") then	
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_141 end ####")
								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_6
								mvars.isInterruptTalk= false
							else
								s10030_radio.FailedRequest()
							end

						elseif speechLabel == StrCode32("MBTS_142") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_142 end ####")
								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_7
								mvars.isInterruptTalk= false
							else
								s10030_radio.FailedRequest()
							end

						elseif speechLabel == StrCode32("MBTS_143") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_143 end ####")

								local developSectionLv = TppMotherBaseManagement.GetSectionLv{ section="Develop" }      
								if developSectionLv  < DEVELOP_LV_BOX then 	
									Fox.Log("#### cannot develop box ####")
									mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_8
								else	
									Fox.Log("#### can develop box ####")
									
									GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
									GkEventTimerManager.Stop( "Timer_MonologueFailed" )
									TppSequence.SetNextSequence( "Seq_Game_TutorialCQC15" )
								end
							else
								s10030_radio.FailedRequest()
							end

						elseif (speechLabel == StrCode32("MBTS_145") and isSuccess ~= 0) then
							Fox.Log("#### MBTS_145 end ####")
							
							GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
							GkEventTimerManager.Stop( "Timer_MonologueFailed" )
							TppSequence.SetNextSequence( "Seq_Game_TutorialCQC15" )
						end

						
						if mvars.ocerotTalkProcess >= this.OCELOT_TALK_PROCESS.WAITING_5 then
							GkEventTimerManager.Stop( "Timer_waitApproachOcelot")
							GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME_TALK )
						end
					end
				},
			},
			Player = {
				{
					msg = "EnableCQC",
					func = function ()
						if mvars.ocerotTalkProcess >= this.OCELOT_TALK_PROCESS.WAITING_3 then	


							if mvars.isCQC_THROW == false then	
								mvars.isCQC_THROW = true	
								GkEventTimerManager.Stop( "Timer_CQC_THROW")
								GkEventTimerManager.Start( "Timer_CQC_THROW", TIMER_TIPS_AGAIN )

								
								TppUI.ShowControlGuide{
									actionName = "CQC_THROW",
									continue = true
								}

								s10030_sequence.displayTips(s10030_sequence.TIPS.CQC_THROW)	
							end

						end
					end
				},
				{
					msg = "IconFultonShown",
					func = function ()
						if mvars.ocerotTalkProcess >= this.OCELOT_TALK_PROCESS.WAITING_3 then	
							if mvars.isSpeechedOcelot_CQC_THOROW == false then	
								mvars.isSpeechedOcelot_CQC_THOROW = true
							end
						end

						
					
					
					
					
					end
				},
				{
				
					msg = "PlayerFulton",
					func = function ()
						Fox.Log("####PlayerFulton ####")
						this.StartFulton()

						if mvars.ocerotTalkProcess < this.OCELOT_TALK_PROCESS.WAITING_5 then
							
							mvars.isSpeechedOcelot_CQC_THOROW = true
							GkEventTimerManager.Stop( "Timer_FultonStart")
							GkEventTimerManager.Start( "Timer_FultonStart", TIMER_WAIT_DELAY_FULTON_START  )

							GkEventTimerManager.Stop( "Timer_NeverFulton" )	
							GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )
						end
					end

				},
			nil
			}
		}
	end,


	
	OnEnter = function ()
		mvars.isCQC_THROW = false 
		svars.isReserve_08	= false	
		svars.isFultonSecondSoldier  =false	
		mvars.OcelotTooFarCount	=0	
		mvars.isStopFultonTalk = false	
		mvars.isStopDownTalk = false
		mvars.isStopCarriedTalk = false
	

		if svars.FulltonCount < 3 then 	
			mvars.isSpeechedOcelot_CQC_THOROW =false
			if s10030_enemy.SetTutorialRoute(ddSoldiersTable.TUTORIAL_CQC_10.ROUTE_FIGHT)== false then	
				
				TppEnemy.SetSneakRoute( ddSoldiersTable.TUTORIAL_CQC_10.NAME, ddSoldiersTable.TUTORIAL_CQC_10.ROUTE_FIGHT )
			end
			s10030_enemy.SetSaluteCQCAll()
			
			GkEventTimerManager.Stop( "Timer_NeverFulton" )	

			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
			mvars.ocerotTalkProcess = s10030_sequence.OCELOT_TALK_PROCESS.TALKING_1 	

			
			s10030_radio.OcelotCQCTutStart()
		else	
			mvars.isSpeechedOcelot_CQC_THOROW = true	
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
			GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME )	
		end

		



	end,

	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	
		s10030_enemy.SetSaluteAll()
		s10030_enemy.SetSaluteNormalAll()

	end,

	
	OnUpdate = function ()
		
		if mvars.isSpeechedOcelot_CQC_THOROW == false then
			if mvars.ocerotTalkProcess >= this.OCELOT_TALK_PROCESS.WAITING_3 then	
				
				for index, enemyName in pairs(s10030_enemy.TUTORIAL_SOLDIER_GROUP) do
					
					if (this.GetDistanceFromPlayer(enemyName, "TppSoldier2" ) < DISTANCE_APPROACH_DD_SOLDIER) and (TppEnemy.IsNeutralized(enemyName) ~= true) then
						
						s10030_radio.PleaseCQCFirst()
						GkEventTimerManager.Stop( "Timer_waitCQC" )	
						GkEventTimerManager.Start( "Timer_waitCQC", TIMER_TIME )
						
						mvars.isSpeechedOcelot_CQC_THOROW = true
					end
				end
			end
		end
		if mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_1 then
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
			s10030_radio.OcelotCQCTutStart()	

		elseif mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_2 then
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
			this.EnableFulton()	
			s10030_radio.OcelotCQCTutStart2()	

		elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_3 then

		elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_4 then

		elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_5 then
			s10030_enemy.SetIdleRoute()	
			s10030_enemy.SetSaluteNormalAll()
			svars.isHearedFultonSucessRate	= true	
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
			s10030_radio.ExplainFultonRule2_141()	

		elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_6 then
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
			s10030_radio.ExplainFultonRule2_142()	

		elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_7 then
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
			s10030_radio.ExplainFultonRule2_143()	

		elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_8 then
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
			s10030_radio.PleaseFutonNext()	
		end

		
		local checkDevelopSectionLv = TppMotherBaseManagement.GetSectionLv{ section="Develop" }      
		if checkDevelopSectionLv  >= DEVELOP_LV_BOX then 	
			
			svars.isReserve_06 = true	
			if svars.isReserve_07 ==true  	
					and svars.isReserve_14 ==false then 	
				svars.isReserve_14 = true	
				TppMission.UpdateObjective{objectives = { "task1_complete" },}	
				TppMission.UpdateObjective{objectives = { "task2_start" },}	
			end
		end
	end,

}



sequences.Seq_Game_TutorialCQC15 = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			Timer = {
				{
					
					msg = "Finish",
					sender = "Timer_waitApproachOcelot",
					func = function ()
						s10030_radio.WaitingApproach()	

						
						GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
						GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME_TALK )
					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_FultonDisable",
					func = function ()
						this.ResetFulton()
					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_NeverFulton",
					func = function ()
						if mvars.isStopFultonTalk == false 
								or svars.FulltonCount == svars.LastFultonCount then 

							if mvars.isSpeechedOcelot_CQC_THOROW15 ~= true then 
								s10030_radio.PleaseFulton()	
							end
							
							GkEventTimerManager.Stop( "Timer_NeverFulton" )	
							GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )
						end
					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_SuccessChainCQC",
					func = function ()
						if svars.isReserve_08	== false then	
							svars.isReserve_08	= true	

							s10030_radio.ExplainChainCQC()
							this.displayTips(s10030_sequence.TIPS.CQC_RAPID)	
						else
							s10030_radio.SuccessChainCQC()
						end
					end
				},
			},


			
			GameObject = {
				{
					
					msg = "Damage", 
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						if attackId == TppDamage.ATK_CqcContinuous2nd then	
							GkEventTimerManager.Stop( "Timer_SuccessChainCQC" )	
							GkEventTimerManager.Start( "Timer_SuccessChainCQC", TIMER_WAIT_DELAY_FULTON_START )
						end
					end
				},
				
				{
					msg = "Down",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameobjectId)
						
						local GetGameObjectId =  gameobjectId 
						if (TppEnemy.GetLifeStatus( GetGameObjectId ) == TppEnemy.LIFE_STATUS.SLEEP) then
							
						elseif (TppEnemy.GetLifeStatus(  GetGameObjectId  ) == TppEnemy.LIFE_STATUS.FAINT) then
						end
					end
				},
				{
				
					msg = "Fulton",
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId, gimmckInstance, gimmckDataSet, staffID)
						Fox.Log("#### fulton  ####" .. gameObjectId)
						Fox.Log("#### DirectAddStaff staffId ####" .. staffID)
						
						GkEventTimerManager.Stop( "Timer_FultonDisable" )	
						svars.FulltonCount = svars.FulltonCount + 1 
						mvars.isStopFultonTalk =true

						Fox.Log("#### TUTORIAL_CQC_15 FULTON ####")
						TppMotherBaseManagement.DirectAddStaff{ staffId=staffID, section = "Develop" }

						s10030_radio.FultonSuccessCommon()	

						svars.isReserve_08	= true	

						GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
						GkEventTimerManager.Stop( "Timer_MonologueFailed" )
						
					
					end
				},
				
				{
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	
						if speechLabel == StrCode32("MBTS_360") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_360 end ####")
								mvars.isInterruptTalk= false	
								s10030_radio.PleaseFulton()
							end
						elseif speechLabel == StrCode32("MBTS_150") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_150 end ####")
								mvars.isInterruptTalk= false	
								s10030_radio.OcelotCQCTutStart4()
							end
						end
					end
				},
			},
			Player = {
				{
				
					msg = "PlayerFulton",
					func = function ()
						Fox.Log("####PlayerFulton ####")
						this.StartFulton()
					end

				},
			},
			nil
		}


	end,

	
	OnEnter = function ()
		mvars.isTalkRapidCQC	= false
		mvars.isSpeechedOcelot_CQC_THOROW15 = false

		mvars.OcelotTooFarCount	=0	
		GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	

		
		
	
	
	

		if s10030_enemy.SetTutorialRoute(ddSoldiersTable.TUTORIAL_CQC_15.ROUTE_FIGHT) == false then	
			
			TppEnemy.SetSneakRoute( ddSoldiersTable.TUTORIAL_CQC_15.NAME, ddSoldiersTable.TUTORIAL_CQC_15.ROUTE_FIGHT )
		end
		
		if s10030_enemy.SetTutorialRouteTwin(ddSoldiersTable.TUTORIAL_CQC_20.ROUTE_FIGHT) == false then	
			
			TppEnemy.SetSneakRoute( ddSoldiersTable.TUTORIAL_CQC_20.NAME, ddSoldiersTable.TUTORIAL_CQC_20.ROUTE_FIGHT )
		end
		s10030_enemy.SetSaluteCQCAll()



	end,

	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	
		s10030_enemy.SetSaluteAll()
		s10030_enemy.SetSaluteNormalAll()
		svars.isReserve_14 = true	

		TppMission.UpdateObjective{objectives = { "task1_complete" },}	
		TppMission.UpdateObjective{objectives = { "task2_start" },}	
	end,


	
	OnUpdate = function ()

		if mvars.isSpeechedOcelot_CQC_THOROW15 == true then 
			
			local i = 0
			for index, enemyName in pairs(s10030_enemy.TUTORIAL_SOLDIER_GROUP) do
				if (this.GetDistanceFromPlayer(enemyName, "TppSoldier2" ) < DISTANCE_APPROACH_DD_SOLDIER_LONG) 
						and (TppEnemy.IsNeutralized(enemyName) ~= true) then
					i = i +1
				end
			end

			if i >=2 then	
				if svars.isReserve_08	==  false then	
					s10030_radio.ExplainChainCQC()
					this.displayTips(s10030_sequence.TIPS.CQC_RAPID)	
					svars.isReserve_08	= true	
				end
			end
		end


		for index, enemyName in pairs(s10030_enemy.TUTORIAL_SOLDIER_GROUP) do
			if (this.GetDistanceFromPlayer(enemyName, "TppSoldier2" ) < DISTANCE_APPROACH_DD_SOLDIER) then
				if mvars.isSpeechedOcelot_CQC_THOROW15 ~= true then	
					
					GkEventTimerManager.Stop( "Timer_NeverFulton" )	
					GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )
					
					s10030_radio.OcelotCQCTutStart3()
					mvars.isSpeechedOcelot_CQC_THOROW15 = true

					this.EnableFulton()	
					mvars.isStopFultonTalk = false	



				end
			end
		end



		if (this.GetDistanceFromPlayer( "Ocelot", "TppOcelot2" ) < DISTANCE_APPROACH) then	
			if svars.FulltonCount >= 3 then 
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	

				
				TppSequence.SetNextSequence( "Seq_Game_TutorialDevelop20" )			
			end
		end
		
		local checkDevelopSectionLv = TppMotherBaseManagement.GetSectionLv{ section="Develop" }      
		if checkDevelopSectionLv  >= DEVELOP_LV_BOX then 	
			
			svars.isReserve_06 = true	
			if svars.isReserve_07 ==true then 	
				TppMission.UpdateObjective{objectives = { "task1_complete" },}	
				TppMission.UpdateObjective{objectives = { "task2_start" },}	
			end
		end

	end,

}

function this.ResetOcelotTooFarTalk()	
	GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
	GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME )
	mvars.OcelotTooFarCount	=0	
end


sequences.Seq_Game_TutorialDevelop20 = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			
			Timer = {
				{
					
					msg = "Finish",
					sender = "Timer_waitApproachOcelot",
					func = function ()
						s10030_radio.TalkingToApproach()
						GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
						GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME )
					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_waitSelectDevelopment",
					func = function ()
						Fox.Log("*** Timer_waitSelectDevelopment ***")
	
						
						GkEventTimerManager.Stop( "Timer_waitOpenDevelopment")
						GkEventTimerManager.Start( "Timer_waitOpenDevelopment", TIMER_WAIT_OPEN_TERMINAL )
						s10030_radio.PleaseSelectDevelopment()


					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_waitOpenDevelopment",
					func = function ()
						Fox.Log("*** Timer_waitOpenDevelopment ***")
	
						if mvars.isSelectDevelopmentSecond	== false then	
							
							GkEventTimerManager.Stop( "Timer_waitOpenDevelopment")
							GkEventTimerManager.Start( "Timer_waitOpenDevelopment", TIMER_WAIT_OPEN_TERMINAL )

							s10030_radio.PleaseSelectRedMarker()
						end

					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_waitDevelopBox",
					func = function ()
						Fox.Log("*** Timer_waitDevelopBox ***")

						if mvars.isDevelopFinish_Dev20	== false then	
							
							GkEventTimerManager.Stop( "Timer_waitDevelopBox")
							GkEventTimerManager.Start( "Timer_waitDevelopBox", TIMER_WAIT_OPEN_TERMINAL )

							s10030_radio.PleaseDevelopBox()
						end

					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_developGauge",
					func = function ()
						Fox.Log("*** Timer_waitDevelopBox ***")
						GkEventTimerManager.Stop( "Timer_developGauge")

						s10030_radio.DevelopComplete()
					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_waitAboutSupply",
					func = function ()
						s10030_radio.AboutSupply()
					end
				},
			},

			
			Terminal = {
				{
				
					msg = "MbDvcActOpenTop",
					func = function()
						if mvars.isDevelopFinish_Dev20 ~= true then
							
							GkEventTimerManager.Stop( "Timer_waitOpenTerminal" )

							
							
							if mvars.isSkipDevelopBox ==  true	then
								Fox.Log("#### use skip already develop box ####")
								this.ClearTerminalControl_OnTutoDev20()
							else	
								Fox.Log("#### not use skip ####")

								
								GkEventTimerManager.Stop( "Timer_waitSelectDevelopment")
								GkEventTimerManager.Start( "Timer_waitSelectDevelopment", TIMER_WAIT_DELAY_MONOLOGUE  )

								
								self.SetTerminalControl_OnTutoDev20()
							end
						end
					end
				},
				
				{
					msg = "MbDvcActCloseTop",
					func = function ()
						Fox.Log("*** s10030_seq Receive MbDvcActCloseTop On Seq_Game_TutorialDevelop20 ***")
						
						this.ClearTerminalControl_OnTutoDev20()

						
						this.ClearTerminalAttentionIcon()
						
						if mvars.isDevelopFinish_Dev20 == true then
							if svars.isReserve_04 == false then	
								svars.isReserve_04 =true
								this.displayTips(s10030_sequence.TIPS.SUPPLY_TOOL)	
							end
						end

					end
				},
			},
			MotherBaseManagement = {
				
				{
					msg = "MbDvcActOpenDevelopEquip",
					func = function()
						Fox.Log("*** Receive MbDvcActOpenDevelopEquip ***")
						if mvars.isDevelopFinish_Dev20 ~= true then
							mvars.isSelectDevelopmentSecond	=true	
							GkEventTimerManager.Stop( "Timer_waitSelectDevelopment")


							
							GkEventTimerManager.Stop( "Timer_waitDevelopBox")
							GkEventTimerManager.Start( "Timer_waitDevelopBox", TIMER_WAIT_OPEN_TERMINAL )

							s10030_radio.OcelotExplainDevelop20_DevelopBox()
							self.SetTerminalControl_OnTutoDev20()
						end
					end
				},
				{
					msg = "MbDvcActDecideDevelopEquip",
					func = function()
						Fox.Log("*** Receive MbDvcActDecideDevelopEquip ***")

						
						mvars.isDevelopFinish_Dev20 = true
				

					end
				},
				{		
					msg = "MbDvcActRunDevelopEquip",
					func = function()
						GkEventTimerManager.Stop( "Timer_developGauge")
						GkEventTimerManager.Start( "Timer_developGauge", TIMER_DEVELOP_GAUGE )
					end
				},
				{
					
					msg = "MbDvcActDecideSupportEquip",
					func = function()
						Fox.Log("*** Receive MbDvcActDecideSupportPoint ***")
						
						GkEventTimerManager.Stop( "Timer_waitAboutSupply")
						GkEventTimerManager.Start( "Timer_waitAboutSupply", TIMER_WAIT_DELAY_MONOLOGUE_LONG )
					end
				},

			},
			Player = {
				{
					msg = "IconMBCBoxShown",
					func = function ()
						
						if mvars.isSpeechedOcelot_Develop_Cbox ~= true then
							mvars.isSpeechedOcelot_Develop_Cbox = true
							
							s10030_radio.OcelotExplainDevelop20_Developed()
						end
					end
				},

				{
					msg = "MB_DEVICE",
					func = function ()
						
					
					
					
					
					end
				},

				{
					msg = "OnPickUpSupplyCbox",
					func = function ()
						GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
						TppUiCommand.UnRegisterForceDropItemPosition()	
						
						TppUI.ShowControlGuide{
							actionName = "EQUIPMENT_WP",
							continue = false
						}
					end
				},

				{
					msg = "OnComeOutSupplyCbox",
					func = function ()
						GkEventTimerManager.Stop( "Timer_waitApproachOcelot")
						GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME_TALK )
					end
				},


			},
			GameObject = {
				
				{
					msg = "Down",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId)
						
					
							if (TppEnemy.GetLifeStatus(gameObjectId) == TppEnemy.LIFE_STATUS.SLEEP) then
								if mvars.isCarried == false then	
									if mvars.ocerotTalkProcess >=  this.OCELOT_TALK_PROCESS.WAITING_5 then	
									end
								else
									mvars.isCarried = false
								end
							elseif (TppEnemy.GetLifeStatus( gameObjectId) == TppEnemy.LIFE_STATUS.FAINT) then
								if mvars.isCarried == false then	
									if mvars.ocerotTalkProcess >=  this.OCELOT_TALK_PROCESS.WAITING_5 then	
									end
								else
									mvars.isCarried = false
								end
							else
								if mvars.ocerotTalkProcess >=  this.OCELOT_TALK_PROCESS.WAITING_5 then	
								end
							end
						end					
				},
				{
					
					msg = "Damage", 
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						mvars.actionOnCQC20 = this.IsWrongAction( attackId, { TppDamage.ATK_CqcChoke, TppDamage.ATK_CqcHang } )
						if (attackId == TppDamage.ATK_SupplyCBoxHit)  then	
							Fox.Log("## dd soldier box hit reaction ##")
							s10030_radio.SoldierBoxHit()
						end
					end
				},
				{
					
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	
						
						if speechLabel == StrCode32("MBTS_077") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_077 end ####")
								this.ResetOcelotTooFarTalk()	
								mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_2	
								TppUI.ShowControlGuide{ actionName = "MB_DEVICE", continue = false }	
							else
								s10030_radio.FailedRequest()
							end

							
							GkEventTimerManager.Stop( "Timer_waitDevelopBox")
							GkEventTimerManager.Start( "Timer_waitDevelopBox", TIMER_WAIT_OPEN_TERMINAL )

						
						elseif speechLabel == StrCode32("MBTS_074") then
							Fox.Log("#### MBTS_220 end ####")
							mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_4	

						
						elseif speechLabel == StrCode32("MBTS_075") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_221 end ####")
								if svars.isHearedFultonSucessRate == false then	
									Fox.Log("#### Not HearedFultonSucessRate ####")
									TppSequence.SetNextSequence( "Seq_Game_ForSkipFollowTutorialDevelop20" ) 
								else
									Fox.Log("#### HearedFultonSucessRate ####")
									TppSequence.SetNextSequence( "Seq_Game_AfterTutorialDevelop20" ) 
								end
							else
								s10030_radio.FailedRequest()
							end
						
						elseif speechLabel == StrCode32("MBTS_079") then
							Fox.Log("#### MBTS_221 end ####")
							if svars.isHearedFultonSucessRate == false then	
								Fox.Log("#### Not HearedFultonSucessRate ####")
								TppSequence.SetNextSequence( "Seq_Game_ForSkipFollowTutorialDevelop20" ) 
							else
								Fox.Log("#### HearedFultonSucessRate ####")
								TppSequence.SetNextSequence( "Seq_Game_AfterTutorialDevelop20" ) 
							end
						end
					end
				},
			},
			nil
		}
	end,

	
	OnEnter = function ( self )
		mvars.isSelectDevelopmentSecond	= false	
		mvars.OcelotTooFarCount	=0	
		mvars.isSpeechedOcelot_Develop_Cbox = false

		s10030_enemy.SetIdleRoute()	
		s10030_enemy.SetSaluteNormalAll()

		GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	

		if mvars.isSkipDevelopBox ==  true	then
			Fox.Log("#### on enter  skip ####")
		else
			Fox.Log("#### on enter  normal ####")
			mvars.ocerotTalkProcess = s10030_sequence.OCELOT_TALK_PROCESS.TALKING_1 	

			
			
			s10030_radio.OcelotExplainDevelop20_00()

			
			this.ClearTerminalAttentionIcon()
			this.SetTerminalAttentionIcon(TppTerminal.MBDVCMENU.MBM_DEVELOP_WEAPON, true )

			
			this.SetMbDvcDevelopTutotrial()
			
			TppUiCommand.RequestMbDvcOpenCondition{ isTopModeMotherBase=true }

			TppUiStatusManager.SetStatus( "MbTop", "BLOCK_CANCEL" )	
			TppUiCommand.RegisterForceDropItemPosition( Vector3(9.52,0.8,-22.932) )	
			TppUiStatusManager.SetStatus( "MbEquipDevelop", "BLOCK_TAB" )	
     	 	end
 
		GkEventTimerManager.Stop( "Timer_waitOpenTerminal")	

		if mvars.isOpenTerminal == true then
			Fox.Log("*** Terminal Opened ***")
			self.SetTerminalControl_OnTutoDev20()

			if mvars.isSkipDevelopBox ==  true	then
				Fox.Log("#### use skip already develop box ####")

			else	
				Fox.Log("#### not use skip ####")

				
				GkEventTimerManager.Stop( "Timer_waitDevelopBox")
				GkEventTimerManager.Start( "Timer_waitDevelopBox", TIMER_WAIT_OPEN_TERMINAL )
							
				s10030_radio.PleaseSelectDevelopment()
			end

		else
			Fox.Log("*** Terminal not Opened ***")
			
			GkEventTimerManager.Start( "Timer_waitOpenTerminal", TIMER_WAIT_OPEN_TERMINAL )
		end

		TppUiStatusManager.SetStatus( "MbEquipDevelop", "BLOCK_CANCEL" )	

	end,

	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	

		
		svars.restartSeq = RESTART_SEQUENCE.CLEAR_DEVELOP_TUTORIAL
		Fox.Log("*** svars.restartSeq = " .. svars.restartSeq .. "!!")

		s10030_enemy.SetSaluteNormalAll()

		TppMission.UpdateObjective{objectives = { "task2_complete" },}	

		
	
	end,

	
	OnUpdate = function ()
		if (this.GetDistanceFromPlayer( "Ocelot", "TppOcelot2" ) < DISTANCE_APPROACH) then

		
			if mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_1 then	
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				
				s10030_radio.OcelotExplainDevelop20_00()

			elseif mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_2 then	
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	

			elseif mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_3 then	
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				
			elseif mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_4 then	
				
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				s10030_radio.OcelotExplainDevelop20_BoxUse()
			end
		end
	end,

	SetTerminalControl_OnTutoDev20 = function ()
		Fox.Log("*** SetTerminalControl_OnTutoDev20 ***")
		if svars.isReserve_04 == false then	

			
			TppUiStatusManager.SetStatus( "MbEquipDevelop", "BLOCK_TAB" )
			TppUiStatusManager.SetStatus( "MbEquipDevelop", "BLOCK_CANCEL" )
			TppUiStatusManager.SetStatus( "MbEquipDevelop", "BLOCK_CANCEL_DEVELOP_DIALOG" )
			TppUiStatusManager.SetStatus( "MbEquipDevelop", "BLOCK_CANCEL_SUPPORT_DIALOG" )
			TppUiStatusManager.SetStatus( "Popup", "BLOCK_CANCEL_DIALOGUE")

			
			TppUiStatusManager.SetStatus( "MbMapDropItem", "BLOCK_CANCEL" )
			TppUiStatusManager.SetStatus( "MbMapDropItem", "BLOCK_SCROLL" )

	

			
			
			TppUiCommand.SetEnableMenuCancelClose( false )
		end
	end,
}

this.ClearTerminalControl_OnTutoDev20 = function ()

	Fox.Log("###*** ClearTerminalControl_OnTutoDev20 ***###")
	
	TppUiStatusManager.ClearStatus( "MbStaffList" )
	TppUiStatusManager.ClearStatus( "MbEquipDevelop" )
	TppUiStatusManager.ClearStatus( "PauseMenu" )
	TppUiStatusManager.ClearStatus( "Popup" )
	TppUiStatusManager.ClearStatus( "MbMapDropItem" )
	TppUiStatusManager.ClearStatus( "MbTop" )

	
	TppUiStatusManager.SetStatus( "MbEquipDevelop", "BLOCK_TAB" )	

	
	TppUiCommand.SetEnableMenuCancelClose( true )
	this.SetMbDvcDefault()

end


sequences.Seq_Game_ForSkipFollowTutorialDevelop20 = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			
			Timer = {
				{
					
					msg = "Finish",
					sender = "Timer_waitApproachOcelot",
					func = function ()
						s10030_radio.TalkingToApproach()
						GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
						GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME )
					end
				},
			},

			
					

			GameObject = {
				{
					
					msg = "Damage", 
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						mvars.actionOnCQC20 = this.IsWrongAction( attackId, { TppDamage.ATK_CqcChoke, TppDamage.ATK_CqcHang } )
						if (attackId == TppDamage.ATK_SupplyCBoxHit)  then	
							Fox.Log("## dd soldier box hit reaction ##")	
							s10030_radio.SoldierBoxHit()
						end
					end
				},
				{
					
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	
						if speechLabel == StrCode32("MBTS_141") then	
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_141 end ####")
								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_6
								mvars.isInterruptTalk= false
							else
								s10030_radio.FailedRequest()
							end

						elseif speechLabel == StrCode32("MBTS_142") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_142 end ####")
								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_7
								mvars.isInterruptTalk= false
							else
								s10030_radio.FailedRequest()
							end

						elseif speechLabel == StrCode32("MBTS_143") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_143 end ####")
								GkEventTimerManager.Stop( "Timer_waitApproachOcelot")
								s10030_sequence.displayTips(s10030_sequence.TIPS.FULTON_RATIO)	
								TppSequence.SetNextSequence( "Seq_Game_AfterTutorialDevelop20" )
							else
								s10030_radio.FailedRequest()
							end
						end

						GkEventTimerManager.Stop( "Timer_waitApproachOcelot")
						GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME_TALK )
					end
				},
			},


		}
	end,

	
	OnEnter = function ()
		mvars.OcelotTooFarCount	=0	
		TppUiStatusManager.ClearStatus("AnnounceLog")	

		mvars.isStopFultonTalk = false	
	

		s10030_enemy.SetSaluteNormalAll()

		mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_5

		
		this.SetMbDvcDevelopTutotrial()
	end,

	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	
	end,

	
	OnUpdate = function ()
		if (this.GetDistanceFromPlayer( "Ocelot", "TppOcelot2" ) < DISTANCE_APPROACH) then
		
			if mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_5 then	
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				s10030_radio.ExplainFultonRule2_141()	

			elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_6 then	
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				s10030_radio.ExplainFultonRule2_142()	

			elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_7 then	
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				s10030_radio.ExplainFultonRule2_143()	
			end
		end
	end,

}


sequences.Seq_Game_AfterTutorialDevelop20 = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			
			Timer = {
				{
					
					msg = "Finish",
					sender = "Timer_waitApproachOcelot",
					func = function ()
						if mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.TALKING_1 		
								or mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_7 then	
							s10030_radio.WaitingApproach()	
						else									
							s10030_radio.TalkingToApproach()		
						end						
						GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
						GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME )
					end
				},
			},

			
					

			GameObject = {
				{
					
					msg = "Damage", 
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						mvars.actionOnCQC20 = this.IsWrongAction( attackId, { TppDamage.ATK_CqcChoke, TppDamage.ATK_CqcHang } )
						if (attackId == TppDamage.ATK_SupplyCBoxHit)  then	
							Fox.Log("## dd soldier box hit reaction ##")	
							s10030_radio.SoldierBoxHit()
						end
					end
				},

				{
					
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	

						if speechLabel == StrCode32("MBTS_078") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_078 end ####")
								
								TppSequence.SetNextSequence( "Seq_Game_ClearTutorialDevelop" )
							else
								s10030_radio.FailedRequest()
							end
						end
					end
				},
			},
			nil
		}
	end,

	
	OnEnter = function ( self )
		mvars.OcelotTooFarCount	=0	

		s10030_enemy.SetIdleRoute()	
		s10030_enemy.SetSaluteNormalAll()

		GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	

		mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_1
		s10030_radio.OcelotExplainDevelop20_Staff()

		
		this.SetMbDvcDevelopTutotrial()

	end,

	
	OnLeave = function ()
		svars.LastFultonCount = svars.FulltonCount 	

		
		svars.isClearDevelopTutorial = true

		svars.restartSeq = RESTART_SEQUENCE.CLEAR_DEVELOP_TUTORIAL
		Fox.Log("*** svars.restartSeq = " .. svars.restartSeq .. "!!")

		s10030_enemy.SetSaluteNormalAll()

		TppUiCommand.SetMisionInfoCurrentStoryNo(1)	

		TppMission.UpdateObjective{objectives = { "task2_complete" },}	

		
	
	end,

	
	OnUpdate = function ()
		if (this.GetDistanceFromPlayer( "Ocelot", "TppOcelot2" ) < DISTANCE_APPROACH) then

		
			if mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_1 then	
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				s10030_radio.OcelotExplainDevelop20_Staff()	
			end
		end
	end,

}



sequences.Seq_Game_ClearTutorialDevelop = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			GameObject = {
				{
					
					msg = "Damage", 
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						mvars.actionOnCQC20 = this.IsWrongAction( attackId, { TppDamage.ATK_CqcChoke, TppDamage.ATK_CqcHang } )
						if (attackId == TppDamage.ATK_SupplyCBoxHit)  then	
							Fox.Log("## dd soldier box hit reaction ##")	
							s10030_radio.SoldierBoxHit()
						end
					end
				},
				{
					
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	

						if speechLabel == StrCode32("MBTS_225") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_225 end ####")
								this.ResetOcelotTooFarTalk()	

								mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_2	
								mvars.isInterruptTalk= false	
							else
								s10030_radio.FailedRequest()
							end
						elseif speechLabel == StrCode32("MBTS_226") then	
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_226 end ####")
								this.ResetOcelotTooFarTalk()	

								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_3	
								mvars.isInterruptTalk= false	
							else
								s10030_radio.FailedRequest()
							end

						elseif speechLabel == StrCode32("MBTS_227") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_227 end ####")
								this.ResetOcelotTooFarTalk()	

								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_4	
								mvars.isInterruptTalk= false	
							else
								s10030_radio.FailedRequest()
							end

						elseif speechLabel == StrCode32("MBTS_228") then	
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_228 end ####")
								this.ResetOcelotTooFarTalk()	
								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_5	
								
								mvars.isSpeechedOcelot_FINISH_DEVELOP = true
							else
								s10030_radio.FailedRequest()
							end
						end

					end
				},
			},
			nil
		}
	end,


	
	OnEnter = function ()
		
		TppMission.UpdateObjective{
			objectives = { "goToAfgh_subGoal" },
		}
							
		
		svars.restartSeq = RESTART_SEQUENCE.CLEAR_DEVELOP_TUTORIAL
		vars.playerDisableActionFlag = PLAYER_DISABLE.GIVEN_FULTON
		TppUiStatusManager.ClearStatus("AnnounceLog")	

		mvars.OcelotTooFarCount	=0	
		mvars.isCallHeliForMissionClear=false

		
		s10030_radio.OcelotDevelopTutAllClear()
		s10030_enemy.SetEnemyWakeUpAll()

		
		this.SetMbDvcAtTutorialClear()

		
		this.ClearTerminalAttentionIcon()
		this.SetTerminalAttentionIcon(TppTerminal.MBDVCMENU.MSN_HELI_RENDEZVOUS, true)

		
		vars.playerDisableActionFlag = PLAYER_DISABLE.CLEAR_DEVELOP_TUTORIAL
		this.DisableFulton()	

		TppUiStatusManager.UnsetStatus( "MbMap", "BLOCK_NAVIGATION" )

		s10030_enemy.SetClearedRoute()	

		this.LandingZoneForRestart()


	end,


	
	OnLeave = function ()
		svars.LastFultonCount = svars.FulltonCount 	
		s10030_enemy.SetSaluteNormalAll()

	end,

	
	OnUpdate = function ()
		
		if mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_1 then	
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
			s10030_radio.OcelotDevelopTutAllClear()	

		elseif mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_2 then	
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
			s10030_radio.OcelotAllClearToHeli()	

		elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_3 then	
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	

			if mvars.isCallHeliForMissionClear == false then
				s10030_radio.OcelotAllClearSetLZ()	
				TppUI.ShowControlGuide{ actionName = "MB_DEVICE", continue = false }	
			else
				s10030_radio.OcelotAllClearMoreCQC()	
			end

		elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_4 then
			GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
			s10030_radio.OcelotAllClearMoreCQC()	

		elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_5 then
			if mvars.isSpeechedOcelot_FINISH_DEVELOP == true then
				TppSequence.SetNextSequence( "Seq_Game_Before1TutorialCQC20" )
			end
		end
	end,

}



sequences.Seq_Game_Before1TutorialCQC20 = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			Timer = {
				{
					
					msg = "Finish",
					sender = "Timer_waitExtraTutorial",
					func = function ()
						GkEventTimerManager.Stop( "Timer_waitExtraTutorial" )
						TppSequence.SetNextSequence( "Seq_Game_Before2TutorialCQC20" )	
					end
				},
			},
			GameObject = {

				
				{
					msg = "Down",
				
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,

					func = function (gameObjectId)
						
					
						if (TppEnemy.GetLifeStatus(gameObjectId) == TppEnemy.LIFE_STATUS.SLEEP) then
							if mvars.isCarried == false then	
							else
								mvars.isCarried = false
							end
						elseif (TppEnemy.GetLifeStatus( gameObjectId) == TppEnemy.LIFE_STATUS.FAINT) then
							if mvars.isCarried == false then	
							else
								mvars.isCarried = false
							end
						else
						end
					end
				},
				{
					
					msg = "Damage", 
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						mvars.actionOnCQC20 = this.IsWrongAction( attackId, { TppDamage.ATK_CqcChoke, TppDamage.ATK_CqcHang } )
						if (attackId == TppDamage.ATK_SupplyCBoxHit)  then	
							Fox.Log("## dd soldier box hit reaction ##")	
							s10030_radio.SoldierBoxHit()
						end
					end
				},
				{
					
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	
					end
				},
			},
			nil
		}
	end,


	
	OnEnter = function ()
		mvars.OcelotTooFarCount	=0	

		GkEventTimerManager.Stop( "Timer_waitExtraTutorial" )
		GkEventTimerManager.Start( "Timer_waitExtraTutorial", TIMER_EXTRA_TUTORIAL )	
	end,


	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	
		s10030_enemy.SetSaluteNormalAll()

	end,

	
	OnUpdate = function ()
		if mvars.isInsideOcelotTrap == false then	
			TppSequence.SetNextSequence( "Seq_Game_Before2TutorialCQC20" )	
		end

	end,
}




sequences.Seq_Game_Before2TutorialCQC20 = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			GameObject = {
				{
					
					msg = "Damage", 
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						mvars.actionOnCQC20 = this.IsWrongAction( attackId, { TppDamage.ATK_CqcChoke, TppDamage.ATK_CqcHang } )
						if (attackId == TppDamage.ATK_SupplyCBoxHit)  then	
							Fox.Log("## dd soldier box hit reaction ##")	
							s10030_radio.SoldierBoxHit()
						end
					end
				},
				{
					
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	
					end
				},
			},
			nil
		}
	end,


	
	OnEnter = function ()
		mvars.OcelotTooFarCount	=0	

	end,


	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	
		s10030_enemy.SetSaluteNormalAll()

	end,

	
	OnUpdate = function ()
		if mvars.isInsideOcelotTrap == true then	

			TppSequence.SetNextSequence( "Seq_Game_TutorialCQC20" )	
		end

	end,
}





sequences.Seq_Game_TutorialCQC20 = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			Timer = {
				{
					
					msg = "Finish",
					sender = "Timer_waitApproachOcelot",
					func = function ()

						if mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.TALKING_1 		
								or mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_5 then	
							s10030_radio.WaitingApproach()	

						else									
							s10030_radio.TalkingToApproach()		
						end
						
						GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
						GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME )
					end
				},




				{
					
					msg = "Finish",
					sender = "Timer_FultonDisable",
					func = function ()
						this.ResetFulton()
					end
				},

				{
					
					msg = "Finish",
					sender = "Timer_NeverFulton",
					func = function ()
						if mvars.isStopFultonTalk == false 
								or svars.FulltonCount == svars.LastFultonCount then 

							if mvars.isSpeechedOcelot_CQC_THOROW15 ~= true then 
								s10030_radio.PleaseFulton()	
							else												
							
							end
							
							GkEventTimerManager.Stop( "Timer_NeverFulton" )	
							GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )
						end
					end
				},

				{
					
					msg = "Finish",
					sender = "Timer_waitPopUp",
					func = function ()
						TppEnemy.SetSneakRoute( "sol_reserve_0000", ddSoldiersTable.TUTORIAL_CQC_30.ROUTE_FIGHT)						
						s10030_enemy.SetSaluteToCqc("sol_reserve_0000")
					end
				},
			},

			
			GameObject = {

				{
					msg = "RoutePoint2", 
					func = function (nObjectId,nRouteId,nRouteNodeId,sendM)
						if	sendM == StrCode32("msgNoSalute") then	
								s10030_enemy.SetNoSalute("sol_reserve_0000")
						elseif	sendM == StrCode32("msgDummy") then	
						else
							Fox.Log( "*** Unknown Message ***")
						end
					end
				},

				{
					
					
					msg = "Restraint", 
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function(gameObjectId, switch, releaseAction)
						if switch == 0 then
							
						
						
							mvars.isHanged = true	

							
							if mvars.isSpeechedOcelot_CQC_HOLD ~= true then
								if mvars.ocerotTalkProcess < s10030_sequence.OCELOT_TALK_PROCESS.TALKING_3 then	
									mvars.isInterruptTalk= true	
									s10030_radio.OcelotCQCTut20_10()
								end
							else
								mvars.isInterruptTalk= true	
								s10030_radio.OcelotCQCTut20_15()
							end

							
							
							TppUI.ShowControlGuide{
								actionName = "INTERROGATION",
								continue = false
							}
							
							TppUI.ShowControlGuide{
								actionName = "SWOON",
								continue = false
							}
							
							TppUI.ShowControlGuide{
								actionName = "KILL",
								continue = false
							}
						else
							if (releaseAction == 1) or (releaseAction == 0) then
								s10030_radio.WrongAction()
								mvars.isInterruptTalk= true	
								mvars.isHanged = false	

								
							
							
							end
						end
					end
				},
				{
					
					msg = "Conscious", 
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId)
						Fox.Log("## dd Conscious##")	
						local SendCommand = GameObject.SendCommand
						local command = { id = "SetDisableDamage", life = false, faint = true, sleep = true }
						local actionState = SendCommand( gameObjectId, command )

					end
				},
				{
					
					msg = "Damage", 
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						local i =0 
						mvars.actionOnCQC20 = this.IsWrongAction( attackId, { TppDamage.ATK_CqcChoke, TppDamage.ATK_CqcHang } )
				

						if (attackId == TppDamage.ATK_SupplyCBoxHit)  then	
							Fox.Log("## dd soldier box hit reaction ##")	
							s10030_radio.SoldierBoxHit()
						elseif (attackId == TppDamage.ATK_CqcChoke)  then	
							
						
							local SendCommand = GameObject.SendCommand
							local command = { id = "SetDisableDamage", life = false, faint = false, sleep = false }
							local actionState = SendCommand( gameObjectId, command )
							local GetGameObjectId = GameObject.GetGameObjectId
							local gameObjectId = gameObjectId
								
							command = { id = "ChangeLifeState", state = TppEnemy.LIFE_STATUS.FAINT } 
							local actionState = GameObject.SendCommand( gameObjectId, command )
								
							
							
							
							

						elseif (attackId == TppDamage.ATK_10101)  	
								or (attackId == TppDamage.ATK_CBoxHeadAttack)  
								or (attackId == TppDamage.ATK_CBoxBodyAttack)  
								or (attackId == TppDamage.ATK_DownKick)  then
							Fox.Log("## wrong attack ##")	
							if mvars.isHangDown ==false then	
								if mvars.isInterruptTalk== false then	
									s10030_radio.WrongSleepBullet()	
									mvars.isInterruptTalk= true	
								end
							end
						elseif (attackId == TppDamage.ATK_CqcThrow)  	
								or (attackId == TppDamage.ATK_CqcHoldThrow)  
								or (attackId == TppDamage.ATK_CqcThrowWall)  
								or (attackId == TppDamage.ATK_CqcThrowBehind)  
								or (attackId == TppDamage.ATK_CqcThrowLadder)  
								or (attackId == TppDamage.ATK_CqcContinuous2nd)  
								or (attackId == TppDamage.ATK_CqcContinuousOver3Times)  
								or (attackId == TppDamage.ATK_CqcFinish) 
								or (attackId == TppDamage.ATK_CqcHitFinish) 
								or (attackId == TppDamage.ATK_CqcDashPunch)  then

							Fox.Log("## wrong faint ##")	
							
							if mvars.isHangDown ==false then	
								if mvars.isInterruptTalk== false then	
									s10030_radio.WrongAction()
									mvars.isInterruptTalk= true	
								end
							end
								
									
									
									
								
						else
							Fox.Log("## other attack ##")	
						end
					end
				},
				
				{
					msg = "Unconscious",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId)
						
						if (TppEnemy.GetLifeStatus( gameObjectId ) == TppEnemy.LIFE_STATUS.FAINT) then
							
							s10030_radio.OcelotCQCTut20_20()
							this.EnableFulton()	
							mvars.isHangDown =true	


							 mvars.isAlreadyDown	= true	
							
							return
						end
					end
				},

				{
				
					msg = "Fulton",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId, gimmckInstance, gimmckDataSet, staffID)
						local fultonFlag = true
						this.Seq_Game_TutorialCQC20_fultonEnd(gameObjectId,fultonFlag)
					end
				
					
				},


				{	
					msg = "PlacedIntoVehicle" , 
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId , type )

						if mvars.isHangDown ==true then	
							Fox.Log("####PlayerFulton after hang down ####")
							mvars.isFultonAfterHang = true	
						else
							Fox.Log("####PlayerFulton before hang down ####")
						end

						if type == GameObject.GetGameObjectId("SupportHeli") then
							local extractFlag = false
							this.Seq_Game_TutorialCQC20_fultonEnd(gameObjectId,extractFlag)
						else	
						end
					end
				},

				{
					
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	
						if (speechLabel == StrCode32("MBTS_270") and isSuccess ~= 0) then	
							mvars.isHangConciousTalk = false 	
							mvars.isInterruptTalk= false	

						elseif speechLabel == StrCode32("MBTS_250") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_250 end ####")

								mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_2
								mvars.isInterruptTalk= false	
							else
								s10030_radio.FailedRequest()
							end
						elseif speechLabel == StrCode32("MBTS_251") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_251 end ####")

								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_3
								mvars.isInterruptTalk= false	
							else
								s10030_radio.FailedRequest()
							end

						elseif speechLabel == StrCode32("MBTS_260") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_260 end ####")

								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_4
								mvars.isInterruptTalk= false	

								GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
								if mvars.isHanged == true then
									s10030_radio.OcelotCQCTut20_15()	
								end

								
								mvars.isSpeechedOcelot_CQC_HOLD = true
							else
								s10030_radio.FailedRequest()
							end
							
						elseif speechLabel == StrCode32("MBTS_280") then
							if isSuccess ~= 0 then
								
								s10030_radio.PleaseFultonAgain()
							else
								s10030_radio.FailedRequest()
							end
						end
					end
				},

			},
			Player = {
				{
					msg = "EnableCQC",
					func = function ()
					if mvars.isFultonDdSoldier_CQC20 ==false then	


							if mvars.isCQC_HOLD == false then	
								mvars.isCQC_HOLD = true	
								GkEventTimerManager.Stop( "Timer_CQC_HOLD")
								GkEventTimerManager.Start( "Timer_CQC_HOLD", TIMER_TIPS_AGAIN )

								
								TppUI.ShowControlGuide{
									actionName = "RESTRAINT2",
									continue = false
								}

								s10030_sequence.displayTips(s10030_sequence.TIPS.CQC_HOLD)	
							end
						end
					end
				},
				{
				
					msg = "PlayerFulton",
					func = function ()
						Fox.Log("####PlayerFulton ####")
						this.StartFulton()

						if mvars.isHangDown ==true then	
							Fox.Log("####PlayerFulton after hang down ####")
							mvars.isFultonAfterHang = true	
						else
							Fox.Log("####PlayerFulton before hang down ####")
						end
					end
				},


			nil
			},
		}
	end,

	
	OnEnter = function ()
		mvars.isCQC_HOLD = false	
		mvars.OcelotTooFarCount	=0	
		mvars.isHangDown =false	
		mvars.isFultonAfterHang = false	
		mvars.isInterruptTalk= false	
		mvars.isHangConciousTalk= false	
		mvars.isHanged = false	
		mvars.isFultonDdSoldier_CQC20 =false	

		
		svars.restartSeq = RESTART_SEQUENCE.CLEAR_DEVELOP_TUTORIAL
		vars.playerDisableActionFlag = PLAYER_DISABLE.GIVEN_FULTON

		TppMission.UpdateObjective{objectives = { "task3_start" },}	

		
		s10030_radio.OcelotCQCTut20_00()

		s10030_enemy.SetCqcRoute()	


		
		s10030_enemy.PopUpSoldier("sol_reserve_0000", "rts_reserve_0000")
		GkEventTimerManager.Stop( "Timer_waitPopUp" )	
		GkEventTimerManager.Start( "Timer_waitPopUp", TIMER_WAIT_DELAY_MONOLOGUE )

		s10030_enemy.SetEnemyWakeUpAll()
		s10030_enemy.SetEnemyDisableDamageAll()

		
		this.SetMbDvcAtTutorialClear()

		mvars.isStopRepeatTalk = false	
		this.DisableFulton()	

	end,

	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	
		svars.restartSeq = RESTART_SEQUENCE.CLEAR_HANG_TUTORIAL
		TppMission.UpdateObjective{objectives = { "task3_complete" },}	
		TppMission.UpdateObjective{objectives = { "task4_start" },}	
		s10030_enemy.SetSaluteNormalAll()
	end,



	
	OnUpdate = function ()
		if (this.GetDistanceFromPlayer( "Ocelot", "TppOcelot2" ) < DISTANCE_APPROACH) then
			
			if mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_1 then
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				s10030_radio.OcelotCQCTut20_00()	

			elseif mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_2 then
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				s10030_radio.OcelotCQCTut20_00_251()	
				
			elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_3 then
				
				
			elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_4 then
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	

				
			elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_5 then
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	

				Fox.Log("#### Exit Seq_Game_TutorialCQC20  ####")
				
				TppSequence.SetNextSequence( "Seq_Game_TutorialCQC30" )	

			end
		end


		
			
				
				
			
		
	end,
}



function this.Seq_Game_TutorialCQC20_fultonEnd(SoldierID,fultonFlag)
	Fox.Log("#### s10030_sequence.Seq_Game_TutorialCQC20_fultonEnd  ####")


	if fultonFlag == true then
		Fox.Log("#### eliminate type fulton  ####")

		
		this.DirectAddStaff(SoldierID)	

		svars.FulltonCount = svars.FulltonCount + 1 
	else
		Fox.Log("#### eliminate type heli  ####")
	end

	if mvars.isFultonAfterHang == true then	
		Fox.Log("#### Fulton after hang down goto next step ####")

		s10030_radio.FultonSuccessCommon()	
		GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
		GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME_TALK )
		mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_5

		s10030_enemy.SetEnemyWakeUpAll()
		GkEventTimerManager.Stop( "Timer_NeverFulton" )	

		vars.playerDisableActionFlag =  PLAYER_DISABLE.CLEAR_HANG_TUTORIAL


		
		mvars.isFultonDdSoldier_CQC20 = true
	else
		Fox.Log("#### Fulton before hang down try again ####")
		if fultonFlag == true then
			svars.LastFultonCount		=svars.FulltonCount 	
		end
	end
end



function this.DirectAddStaff(SoldierID)

	Fox.Log("#### s10030_sequence.DirectAddStaff ####")
	local i =false
	Fox.Log("#### SoldierID " .. tostring(SoldierID) )

	for index, enemyName in pairs(SOLDIER_GROUP) do
		if	GameObject.GetGameObjectId("TppSoldier2",SoldierID) == GameObject.GetGameObjectId("TppSoldier2", enemyName)  then
			Fox.Log("#### Direct Set Mb Staff " .. tostring(enemyName) )
			Fox.Log("####  Staff id " .. tostring(SOLDIER_STAFF_ID_GROUP[index]) )
			local DDStaffId = TppMotherBaseManagement.GenerateStaffParameter{ staffType="Unique", uniqueTypeId=SOLDIER_STAFF_ID_GROUP[index] }
			TppMotherBaseManagement.DirectAddStaff{ staffId=DDStaffId, section = "Develop" }
			i=true
		end
	end
	if i ==false then
		Fox.Log("#### cannot add staff ####")
	end

end


function this.DirectAddStaffContinue()	

	Fox.Log("#### Direct add default support staff ####")

	
	
	local defaultDDStaffId050 = TppMotherBaseManagement.GenerateStaffParameter{ staffType="Unique", uniqueTypeId=0 }
	TppMotherBaseManagement.DirectAddStaff{ staffId=defaultDDStaffId050, section = "Support" }

	local defaultDDStaffId060 = TppMotherBaseManagement.GenerateStaffParameter{ staffType="Unique", uniqueTypeId=1 }
	TppMotherBaseManagement.DirectAddStaff{ staffId=defaultDDStaffId060, section = "Support" }

	local defaultDDStaffId070 = TppMotherBaseManagement.GenerateStaffParameter{ staffType="Unique", uniqueTypeId=2 }
	TppMotherBaseManagement.DirectAddStaff{ staffId=defaultDDStaffId070, section = "Support" }

	
	if svars.isFulton_sol_plant0_0000 == true then
		Fox.Log("#### Set Staff sol_plant0_0000 ####")
		this.DirectAddStaff("sol_plant0_0000")
	end

	if svars.isFulton_sol_plant0_0001 == true then
		Fox.Log("#### Set Staff sol_plant0_0001 ####")
		this.DirectAddStaff("sol_plant0_0001")
	end

	if svars.isFulton_sol_plant0_0002 == true then
		Fox.Log("#### Set Staff sol_plant0_0002 ####")
		this.DirectAddStaff("sol_plant0_0002")
	end

	if svars.isFulton_sol_plant0_0003 == true then
		Fox.Log("#### Set Staff sol_plant0_0003 ####")
		this.DirectAddStaff("sol_plant0_0003")
	end

	if svars.isFulton_sol_plant0_0004 == true then
		Fox.Log("#### Set Staff sol_plant0_0004 ####")
		this.DirectAddStaff("sol_plant0_0004")
	end

	if svars.isFulton_sol_plant0_0005 == true then
		Fox.Log("#### Set Staff sol_plant0_0005 ####")
		this.DirectAddStaff("sol_plant0_0005")
	end

	if svars.isFulton_sol_plant0_0006 == true then
		Fox.Log("#### Set Staff sol_plant0_0006 ####")
		this.DirectAddStaff("sol_plant0_0006")
	end

	if svars.isFulton_sol_plant0_0007 == true then
		Fox.Log("#### Set Staff sol_plant0_0007 ####")
		this.DirectAddStaff("sol_plant0_0007")
	end

	if svars.isFulton_sol_plant0_0008 == true then
		Fox.Log("#### Set Staff sol_plant0_0008 ####")
		this.DirectAddStaff("sol_plant0_0008")
	end

	if svars.isFulton_sol_plant0_0009 == true then
		Fox.Log("#### Set Staff sol_plant0_0009 ####")
		this.DirectAddStaff("sol_plant0_0009")
	end

	if svars.isFulton_sol_plant0_0010 == true then
		Fox.Log("#### Set Staff sol_plant0_0010 ####")
		this.DirectAddStaff("sol_plant0_0010")
	end

	if svars.isFulton_sol_plant0_0011 == true then
		Fox.Log("#### Set Staff sol_plant0_0011 ####")
		this.DirectAddStaff("sol_plant0_0011")
	end

	if svars.isFulton_sol_reserve_0000 == true then
		Fox.Log("#### Set Staff sol_reserve_0000 ####")
		this.DirectAddStaff("sol_reserve_0000")
	end

	if svars.isFulton_sol_reserve_0001 == true then
		Fox.Log("#### Set Staff sol_reserve_0001 ####")
		this.DirectAddStaff("sol_reserve_0001")
	end

end



function this.DirectAddStaffMissionEnd()	
	Fox.Log("#### Direct add staff Mission End####")


	
	local exract_staff_num = 0	

		
	if svars.isFulton_sol_plant0_0000 == false then
		Fox.Log("#### extract sol_plant0_0000 ####")
		exract_staff_num =exract_staff_num +1	
	end

	if svars.isFulton_sol_plant0_0001 == false then
		Fox.Log("#### extract sol_plant0_0001 ####")
		exract_staff_num =exract_staff_num +1	
	end

	if svars.isFulton_sol_plant0_0002 == false then
		Fox.Log("#### extract sol_plant0_0002 ####")
		exract_staff_num =exract_staff_num +1	
	end

	if svars.isFulton_sol_plant0_0003 == false then
		Fox.Log("#### extract sol_plant0_0003 ####")

		exract_staff_num =exract_staff_num +1	
	end

	if svars.isFulton_sol_plant0_0004 == false then
		Fox.Log("#### extract sol_plant0_0004 ####")

		exract_staff_num =exract_staff_num +1	
	end

	if svars.isFulton_sol_plant0_0005 == false then
		Fox.Log("#### extract sol_plant0_0005 ####")

		exract_staff_num =exract_staff_num +1	
	end

	if svars.isFulton_sol_plant0_0006 == false then
		Fox.Log("#### extract sol_plant0_0006 ####")

		exract_staff_num =exract_staff_num +1	
	end

	if svars.isFulton_sol_plant0_0007 == false then
		Fox.Log("#### extract sol_plant0_0007 ####")

		exract_staff_num =exract_staff_num +1	
	end

	if svars.isFulton_sol_plant0_0008 == false then
		Fox.Log("#### extract sol_plant0_0008 ####")

		exract_staff_num =exract_staff_num +1	
	end

	if svars.isFulton_sol_plant0_0009 == false then
		Fox.Log("#### extract sol_plant0_0009 ####")


		exract_staff_num =exract_staff_num +1	
	end

	if svars.isFulton_sol_plant0_0010 == false then
		Fox.Log("#### extract sol_plant0_0010 ####")

		exract_staff_num =exract_staff_num +1	
	end

	if svars.isFulton_sol_plant0_0011 == false then
		Fox.Log("#### extract sol_plant0_0011 ####")

		exract_staff_num =exract_staff_num +1	
	end

	if svars.isFulton_sol_reserve_0000 == false then
		Fox.Log("#### extract sol_reserve_0000 ####")


		exract_staff_num =exract_staff_num +1	
	end

	if svars.isFulton_sol_reserve_0001 == false then
		Fox.Log("#### extract sol_reserve_0001 ####")
		exract_staff_num =exract_staff_num +1	
	end

	if exract_staff_num >0 then
		Fox.Log("#### exract_staff_num ####" .. exract_staff_num)

		
		TppUiCommand.AnnounceLogViewLangId( "announce_extraction_arrived" )
		TppUiCommand.AnnounceLogViewJoinLangId( "announce_extract_staff", "announce_record_num", exract_staff_num  )

		
		
		if svars.isFulton_sol_plant0_0000 == false then
			Fox.Log("#### Set Staff sol_plant0_0000 ####")
			svars.isFulton_sol_plant0_0000 =true	
			this.DirectAddStaff("sol_plant0_0000")
		end

		if svars.isFulton_sol_plant0_0001 == false then
			Fox.Log("#### Set Staff sol_plant0_0001 ####")
			svars.isFulton_sol_plant0_0001 =true	
			this.DirectAddStaff("sol_plant0_0001")
		end

		if svars.isFulton_sol_plant0_0002 == false then
			Fox.Log("#### Set Staff sol_plant0_0002 ####")
			svars.isFulton_sol_plant0_0002 =true	
			this.DirectAddStaff("sol_plant0_0002")
		end

		if svars.isFulton_sol_plant0_0003 == false then
			Fox.Log("#### Set Staff sol_plant0_0003 ####")
			svars.isFulton_sol_plant0_0003 =true	
			this.DirectAddStaff("sol_plant0_0003")
		end

		if svars.isFulton_sol_plant0_0004 == false then
			Fox.Log("#### Set Staff sol_plant0_0004 ####")
			svars.isFulton_sol_plant0_0004 =true	
			this.DirectAddStaff("sol_plant0_0004")
		end

		if svars.isFulton_sol_plant0_0005 == false then
			Fox.Log("#### Set Staff sol_plant0_0005 ####")
			svars.isFulton_sol_plant0_0005 =true	
			this.DirectAddStaff("sol_plant0_0005")
		end

		if svars.isFulton_sol_plant0_0006 == false then
			Fox.Log("#### Set Staff sol_plant0_0006 ####")
			svars.isFulton_sol_plant0_0006 =true	
			this.DirectAddStaff("sol_plant0_0006")
		end

		if svars.isFulton_sol_plant0_0007 == false then
			Fox.Log("#### Set Staff sol_plant0_0007 ####")
			svars.isFulton_sol_plant0_0007 =true	
			this.DirectAddStaff("sol_plant0_0007")
		end

		if svars.isFulton_sol_plant0_0008 == false then
			Fox.Log("#### Set Staff sol_plant0_0008 ####")
			svars.isFulton_sol_plant0_0008 =true	
			this.DirectAddStaff("sol_plant0_0008")
		end

		if svars.isFulton_sol_plant0_0009 == false then
			Fox.Log("#### Set Staff sol_plant0_0009 ####")
			svars.isFulton_sol_plant0_0009 =true	
			this.DirectAddStaff("sol_plant0_0009")
		end

		if svars.isFulton_sol_plant0_0010 == false then
			Fox.Log("#### Set Staff sol_plant0_0010 ####")
			svars.isFulton_sol_plant0_0010 =true	
			this.DirectAddStaff("sol_plant0_0010")
		end

		if svars.isFulton_sol_plant0_0011 == false then
			Fox.Log("#### Set Staff sol_plant0_0011 ####")
			svars.isFulton_sol_plant0_0011 =true	
			this.DirectAddStaff("sol_plant0_0011")
		end

		if svars.isFulton_sol_reserve_0000 == false then
			Fox.Log("#### Set Staff sol_reserve_0000 ####")
			svars.isFulton_sol_reserve_0000 =true	
			this.DirectAddStaff("sol_reserve_0000")
		end

		if svars.isFulton_sol_reserve_0001 == false then
			Fox.Log("#### Set Staff sol_reserve_0001 ####")
			svars.isFulton_sol_reserve_0001 =true	
			this.DirectAddStaff("sol_reserve_0001")
		end
	else	
		Fox.Log("#### no staff extract  ####")
	end
	
	
	this.DirectAddStaff("sol_plant0_0000")
	this.DirectAddStaff("sol_plant0_0001")
	this.DirectAddStaff("sol_plant0_0002")
	this.DirectAddStaff("sol_plant0_0003")
	this.DirectAddStaff("sol_plant0_0004")
	this.DirectAddStaff("sol_plant0_0005")
	this.DirectAddStaff("sol_plant0_0006")
	this.DirectAddStaff("sol_plant0_0007")
	this.DirectAddStaff("sol_plant0_0008")
	this.DirectAddStaff("sol_plant0_0009")
	this.DirectAddStaff("sol_plant0_0010")
	this.DirectAddStaff("sol_plant0_0011")
	this.DirectAddStaff("sol_reserve_0000")
	this.DirectAddStaff("sol_reserve_0001")

end



sequences.Seq_Game_TutorialCQC30 = {
	
	Messages = function( self ) 
		return
		StrCode32Table {

			Timer = {

				{
					
					msg = "Finish",
					sender = "Timer_waitApproachOcelot",
					func = function ()

						if mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.TALKING_1 		
								or mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_3 then	
							s10030_radio.WaitingApproach()	

						elseif mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_2 then	
							s10030_radio.TalkingToApproach()		
						end
						
						GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
						GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME )
					end
				},


				{
					
					msg = "Finish",
					sender = "Timer_FultonDisable",
					func = function ()
						this.ResetFulton()
					end
				},

				{
					
					msg = "Finish",
					sender = "Timer_RappidAttackDownFirst",
					func = function ()
						Fox.Log("#### Timer_RappidAttackDownFirst####")

						if mvars.isRapidAttackDownPlaseFulton == false	 then
							mvars.isRapidAttackDownPlaseFulton = true	
		
							s10030_radio.PleaseFultonAgain()
						end
					end
				},




				{
					
					msg = "Finish",
					sender = "Timer_NeverFulton",
					func = function ()
						if mvars.isStopFultonTalk == false 
								or svars.FulltonCount == svars.LastFultonCount then 
								s10030_radio.PleaseFulton()	
							
							GkEventTimerManager.Stop( "Timer_NeverFulton" )	
							GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )
						end
					end
				},


				{
					
					msg = "Finish",
					sender = "Timer_waitPopUp",
					func = function ()
						TppEnemy.SetSneakRoute( "sol_reserve_0001", ddSoldiersTable.TUTORIAL_CQC_30.ROUTE_FIGHT)
						s10030_enemy.SetEnemyDisableDamage( "sol_reserve_0001" ,true)
						s10030_enemy.SetSaluteToCqc("sol_reserve_0001")
					end
				},
			},
			
			GameObject = {
				{
					
					msg = "Conscious", 
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId)
						Fox.Log("## dd Conscious##")	
						local SendCommand = GameObject.SendCommand
						local command = { id = "SetDisableDamage", life = false, faint = true, sleep = true }
						local actionState = SendCommand( gameObjectId, command )



					end
				},

	

				{
					
					
					msg = "Restraint", 
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,

					func = function(gameObjectId, switch, releaseAction)
						if switch == 0 then
						else
							if (releaseAction == 1) or (releaseAction == 0) then
								s10030_radio.RestraintEnd()
							end
						end
					end
				},

				{
					
					msg = "Damage", 
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,

		
					func = function ( gameObjectId, attackId )
							
					
						if (attackId == TppDamage.ATK_CqcFinish) or (attackId == TppDamage.ATK_CqcHitFinish) then

							
						
							local SendCommand = GameObject.SendCommand
							local command = { id = "SetDisableDamage", life = false, faint = false, sleep = false }
							local actionState = SendCommand( gameObjectId, command )
							local GetGameObjectId = GameObject.GetGameObjectId
							local gameObjectId = gameObjectId
							
							command = { id = "ChangeLifeState", state = TppEnemy.LIFE_STATUS.FAINT } 
							local actionState = GameObject.SendCommand( gameObjectId, command )
		
							
							
							
							
							


							s10030_radio.OcelotCQCTut30_10()
							mvars.isRapidAttackDown =true	

					
								GkEventTimerManager.Stop( "Timer_RappidAttackDownFirst" )	
								GkEventTimerManager.Start( "Timer_RappidAttackDownFirst", TIMER_RAPID_ATTACK_FULTON )
								
						

							GkEventTimerManager.Stop( "Timer_NeverFulton" )	
							GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )
							this.EnableFulton()	

						
						elseif (attackId == TppDamage.ATK_SupplyCBoxHit)  then	
							Fox.Log("## dd soldier box hit reaction ##")	
							s10030_radio.SoldierBoxHit()

						elseif (attackId == TppDamage.ATK_10101)  	
								or (attackId == TppDamage.ATK_CBoxHeadAttack)  
								or (attackId == TppDamage.ATK_CBoxBodyAttack)  
								or (attackId == TppDamage.ATK_DownKick) then
							Fox.Log("## wrong attack ##")	
						
						
						
								if mvars.isInterruptTalk== false then	
									s10030_radio.WrongAction()	
									mvars.isInterruptTalk= true	
								end
						
	
						elseif (attackId == TppDamage.ATK_CqcChoke)  	
								or (attackId == TppDamage.ATK_CqcDashPunch)  then
							Fox.Log("## wrong fauin ##")	
							

							if mvars.isRapidAttackDown == false	 then
								if mvars.isInterruptTalk== false then	
									s10030_radio.WrongAction()
									mvars.isInterruptTalk= true	
								end
							else
								if mvars.isInterruptTalk== false then	
									s10030_radio.WrongAction()
									mvars.isInterruptTalk= true	
								end
							end

						elseif (attackId == TppDamage.ATK_CqcThrow)  	
								or (attackId == TppDamage.ATK_CqcHoldThrow)  
								or (attackId == TppDamage.ATK_CqcThrowWall)  
								or (attackId == TppDamage.ATK_CqcThrowBehind)  
								or (attackId == TppDamage.ATK_CqcThrowLadder)  then
							Fox.Log("## wrong throw ##")	
								
							if mvars.isRapidAttackDown == false	 then
								if mvars.isInterruptTalk== false then	
									s10030_radio.WrongAction()
									mvars.isInterruptTalk= true	
								end
							else
								if mvars.isInterruptTalk== false then	
									s10030_radio.WrongAction()
									mvars.isInterruptTalk= true	
								end
							end

						elseif (attackId == TppDamage.ATK_CqcContinuous2nd)  
								or (attackId == TppDamage.ATK_CqcContinuousOver3Times)  then

							Fox.Log("## wrong rapid cqc ##")	
							
							if mvars.isRapidAttackDown == false	 then
								if mvars.isInterruptTalk== false then	
									s10030_radio.WrongAction()
									mvars.isInterruptTalk= true	
								end
							else
								if mvars.isInterruptTalk== false then	
									s10030_radio.WrongAction()
									mvars.isInterruptTalk= true	
								end
							end
							
								
									
									
									
								
						else
							Fox.Log("## other attack ##")	
						end
					end
				},
				
				{
					msg = "Fulton",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId, gimmckInstance, gimmckDataSet, staffID)
						this.Seq_Game_TutorialCQC30_fultonEnd(gameObjectId)
					end
				},
				
				{
					msg = "PlacedIntoVehicle" , 
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId , arg2 )

						if mvars.isRapidAttackDown  ==true then	
							Fox.Log("####PlayerFulton after Rapid Attack down ####")
							mvars.isFultonAfterRapidAttack  = true	
						else
							Fox.Log("####PlayerFulton before Rapid Attack  down ####")
						end
						if arg2 == GameObject.GetGameObjectId("SupportHeli") then
							this.Seq_Game_TutorialCQC30_fultonEnd(gameObjectId)
						else	
						end
					end
				},
				{
					
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	
						if speechLabel == StrCode32("MBTS_290") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_290 end ####")
								this.ResetOcelotTooFarTalk()	

								mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_2	
								mvars.isInterruptTalk= false	
							else
								s10030_radio.FailedRequest()
							end

						elseif speechLabel == StrCode32("MBTS_291") then	
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_291 end ####")

								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_3	
								mvars.isInterruptTalk= false	
							else
								s10030_radio.FailedRequest()
							end
						end
					end
				}

			},
			Player = {
				{
					msg = "EnableCQC",
					func = function ()
				
							
						
						
				
							

							if mvars.isFultonDdSoldier_CQC30 == false then	
								if mvars.isCQC_BLOW == false and TppUiCommand.IsDispGuide( ) == false then	
									mvars.isCQC_BLOW = true	
									GkEventTimerManager.Stop( "Timer_CQC_BLOW")
									GkEventTimerManager.Start( "Timer_CQC_BLOW", TIMER_TIPS_AGAIN )
							
									
									TppUI.ShowControlGuide{
										actionName = "CQC_PUNCH",
										continue = true
									}		
									s10030_sequence.displayTips(s10030_sequence.TIPS.CQC_BLOW)	
								end
							end
				
					end
				},

				{
				
					msg = "PlayerFulton",
					func = function ()
						Fox.Log("####PlayerFulton ####")
						this.StartFulton()

						if mvars.isRapidAttackDown  ==true then	
							Fox.Log("####PlayerFulton after Rapid Attack down ####")
							mvars.isFultonAfterRapidAttack  = true	
						else
							Fox.Log("####PlayerFulton before Rapid Attack  down ####")
						end
					end
				},
			},
			nil
		}
	end,


	
	OnEnter = function ()
		mvars.isCQC_BLOW = false	
		mvars.OcelotTooFarCount	=0	
		mvars.isRapidAttackDown =false	
		mvars.isFultonAfterRapidAttack = false
		mvars.isInterruptTalk= false	
		mvars.isRapidAttackDown  =false
		mvars.isFultonAfterRapidAttack =false
		mvars.isRapidAttackDownPlaseFulton = false
		mvars.isFultonDdSoldier_CQC30 = false	

		s10030_enemy.SetCqcRoute()	

		Fox.Log("#### sol_reserve_0000 eliminated pop sol_reserve_0001 ####")

		s10030_enemy.PopUpSoldier("sol_reserve_0001", "rts_reserve_0001")
		GkEventTimerManager.Stop( "Timer_waitPopUp" )	
		GkEventTimerManager.Start( "Timer_waitPopUp", TIMER_WAIT_DELAY_MONOLOGUE )

		s10030_enemy.SetEnemyWakeUpAll()
		s10030_enemy.SetEnemyDisableDamageAll()

		mvars.isStopRepeatTalk = false	

		this.DisableFulton()	
		GkEventTimerManager.Stop( "Timer_FultonDisable" )	

		s10030_radio.OcelotCQCTut30_00()
	end,


	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	
		s10030_enemy.ResetEnemyDisableDamageAll()
		s10030_enemy.SetSaluteNormalAll()

		TppMission.UpdateObjective{objectives = { "task4_complete" },}	
	

		svars.restartSeq = RESTART_SEQUENCE.CLEAR_HANG_TUTORIAL

		
	

	end,
	
	
	OnUpdate = function ()
		if (this.GetDistanceFromPlayer( "Ocelot", "TppOcelot2" ) < DISTANCE_APPROACH) then
			
			if mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_1 then
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				s10030_radio.OcelotCQCTut30_00()	

			elseif mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_2 then
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				s10030_radio.OcelotCQCTut30_00_291()	

			elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_3 then

			elseif mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_4 then
				
			
				TppSequence.SetNextSequence( "Seq_Game_CQCTutAllClear" )

			end
		end
	end,


}


function this.Seq_Game_TutorialCQC30_fultonEnd(SoldierID,fultonFlag)
	Fox.Log("#### s10030_sequence.Seq_Game_TutorialCQC30_fultonEnd ####")


	if fultonFlag == true then
		Fox.Log("#### eliminate type fulton  ####")
		
	
		this.DirectAddStaff(SoldierID)	

		svars.FulltonCount = svars.FulltonCount + 1 
	else
		Fox.Log("#### eliminate type heli  ####")
	end
	
	if mvars.isFultonAfterRapidAttack ==true then
		Fox.Log("#### Fulton after Rapid Attack down goto next step ####")

		s10030_radio.FultonSuccessCommon()	
		GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
		GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME_TALK )

		mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_4	

		s10030_enemy.SetEnemyWakeUpAll()
		GkEventTimerManager.Stop( "Timer_NeverFulton" )	

		s10030_enemy.SetClearedRoute()	

		mvars.isStopFultonTalk =true
			GkEventTimerManager.Stop( "Timer_FultonDisable" )	

		
		mvars.isFultonDdSoldier_CQC30 = true
	else
		Fox.Log("#### Fulton before Rapid Attack down try again ####")
		if fultonFlag == true then
			svars.LastFultonCount		=svars.FulltonCount 	
		end
	end

	Fox.Log("#### exit s10030_sequence.Seq_Game_TutorialCQC30_fultonEnd ####")
end




sequences.Seq_Game_TutorialCQC40 = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			
			GameObject = {
				{
					msg = "Fulton",
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId, gimmckInstance, gimmckDataSet, staffID)
						
						TppMotherBaseManagement.DirectAddStaff{ staffId=staffID, section = "Support" }

						svars.FulltonCount = svars.FulltonCount + 1 

						
						
						mvars.isFultonDdSoldier_CQC40 = true

						
						TppSequence.SetNextSequence( "Seq_Game_TutorialCQC50" )
					end
				},



			},
			nil
		}
	end,

	
	OnEnter = function ()
		mvars.OcelotTooFarCount	=0	

	end,

	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	
		s10030_enemy.SetSaluteNormalAll()

	end,

	
	OnUpdate = function ()
	end,
}



sequences.Seq_Game_TutorialCQC50 = {
	
	Messages = function( self ) 
		return
		StrCode32Table {

			Timer = {

				{
					
					msg = "Finish",
					sender = "Timer_waitApproachOcelot",
					func = function ()
						s10030_radio.WaitingApproach()	
						
						GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )
						GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME )
					end
				},

				{
					
					msg = "Finish",
					sender = "Timer_FultonDisable",
					func = function ()
						this.ResetFulton()
					end
				},
				{
					
					msg = "Finish",
					sender = "Timer_NeverFulton",
					func = function ()
						
						
						if mvars.isStopFultonTalk == false or svars.FulltonCount == svars.LastFultonCount then
							s10030_radio.PleaseFulton()	
							
							GkEventTimerManager.Stop( "Timer_NeverFulton" )	
							GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )
						end
					end
				},
			},
			
			GameObject = {
				{
					
					msg = "Damage", 
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						if (attackId == TppDamage.ATK_CqcThrow) or (attackId == TppDamage.ATK_CqcThrowWall) then
							
							local SendCommand = GameObject.SendCommand
							local command = { id = "SetDisableDamage", life = false, faint = false, sleep = false }
							local actionState = SendCommand( gameObjectId, command )

							local gameObjectId = gameObjectId
							
							command = { id = "ChangeLifeState", state = TppEnemy.LIFE_STATUS.FAINT } 
							local actionState = GameObject.SendCommand( gameObjectId, command )

						
						
						
						
						
						
						
						elseif attackId == TppDamage.ATK_CqcContinuous2nd then

							
							local SendCommand = GameObject.SendCommand
							local command = { id = "SetDisableDamage", life = false, faint = false, sleep = false }
							local actionState = SendCommand( gameObjectId, command )

							local gameObjectId = gameObjectId
							
							command = { id = "ChangeLifeState", state = TppEnemy.LIFE_STATUS.FAINT } 
							local actionState = GameObject.SendCommand( gameObjectId, command )


						
						
						
						
						
						
						

							
							s10030_radio.SuccessChainCQC()
							this.EnableFulton()	
							GkEventTimerManager.Stop( "Timer_NeverFulton" )	
							GkEventTimerManager.Start( "Timer_NeverFulton", TIMER_TIME_FULTON_AGAIN )
							s10030_enemy.ResetEnemyDisableDamageAll()
						elseif (attackId == TppDamage.ATK_SupplyCBoxHit)  then	
							Fox.Log("## dd soldier box hit reaction ##")	
							s10030_radio.SoldierBoxHit()
						else
							return
						end
					end
				},
				{
					
					msg = "Fulton", 
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId)
						this.Seq_Game_TutorialCQC50_fultonEnd(gameObjectId)
					end
				},

				{	
					msg = "PlacedIntoVehicle" , 
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId , arg2 )
						if arg2 == GameObject.GetGameObjectId("SupportHeli") then
							this.Seq_Game_TutorialCQC50_fultonEnd(gameObjectId)
						else	
						end
					end
				},

			},
			
			Player = {
				{
					
					msg = "CqcContinuePass",
					func = function ()
						
						s10030_radio.WrongAction()
						
						s10030_enemy.SetEnemyDisableDamageAll()

						
						s10030_enemy.SetEnemyWakeUpAll()
					end
				},
				{
					msg = "EnableCQC",
					func = function ()
						
						TppUI.ShowControlGuide{
							actionName = "CQC_COMBO",
							continue = true
						}
					end
				},

				{
				
					msg = "PlayerFulton",
					func = function ()
						Fox.Log("####PlayerFulton ####")
						this.StartFulton()

					end
				},

			},
			nil
		}
	end,

	
	OnEnter = function ()
		mvars.OcelotTooFarCount	=0	
		mvars.isTutorialCQC50_Cleared	= false	
		vars.playerDisableActionFlag =  PLAYER_DISABLE.CLEAR_HANG_TUTORIAL

		
		GkEventTimerManager.Stop( "Timer_FultonDisable" )	

		s10030_enemy.SetCQCRoute()		

		s10030_enemy.SetEnemyWakeUpAll()
		s10030_enemy.SetEnemyDisableDamageAll()
		this.DisableFulton()	

		
		s10030_radio.ExplainChainCQC()
		GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )

	end,

	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	

		
		s10030_enemy.SetIdleRoute()	
		s10030_enemy.SetSaluteNormalAll()

	

		svars.restartSeq = RESTART_SEQUENCE.CLEAR_DEVELOP_TUTORIAL

		
	
	end,

	
	OnUpdate = function ()
		if (this.GetDistanceFromPlayer( "Ocelot", "TppOcelot2" ) < DISTANCE_APPROACH) then	
			if mvars.isTutorialCQC50_Cleared	== true then	
				
				TppSequence.SetNextSequence( "Seq_Game_CQCTutAllClear" )
			end
		end
	end,
}


function this.Seq_Game_TutorialCQC50_fultonEnd(SoldierID)
	s10030_radio.FultonSuccessCommon()	

	mvars.isTutorialCQC50_Cleared	= true	
	GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
	GkEventTimerManager.Start( "Timer_waitApproachOcelot", TIMER_TIME_TALK )
	GkEventTimerManager.Stop( "Timer_FultonDisable" )	

	GkEventTimerManager.Stop( "Timer_NeverFulton" )	

	this.DirectAddStaff(SoldierID)	

	svars.FulltonCount = svars.FulltonCount + 1 



end



sequences.Seq_Game_CQCTutAllClear = {
	
	Messages = function( self ) 
		return
		StrCode32Table {
			
			GameObject = {
				{
					
					msg = "Damage", 
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId, attackId )
						if (attackId == TppDamage.ATK_10101)  then	
						elseif (attackId == TppDamage.ATK_SupplyCBoxHit)  then	
							Fox.Log("## dd soldier box hit reaction ##")	
							s10030_radio.SoldierBoxHit()
						elseif (attackId == TppDamage.ATK_Push)  
								or (attackId == TppDamage.ATK_PushSlide)then
						else
						end
					end
				},




				{
				
					msg = "Fulton",
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId, gimmckInstance, gimmckDataSet, staffID)
						this.DirectAddStaff(gameObjectId)
					end

				},

				{	
					msg = "PlacedIntoVehicle" , 
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function ( gameObjectId , arg2 )
						if arg2 == GameObject.GetGameObjectId("SupportHeli") then
							this.DirectAddStaff(gameObjectId)
						else	
						end
					end
				},

				
				{
					msg = "Down",
					
					sender = s10030_enemy.ALL_SOLDIER_GROUP,
					func = function (gameObjectId)
						
						if (TppEnemy.GetLifeStatus(gameObjectId) == TppEnemy.LIFE_STATUS.SLEEP) then
							if mvars.isCarried == false then	
							else
								mvars.isCarried = false
							end
						elseif (TppEnemy.GetLifeStatus( gameObjectId) == TppEnemy.LIFE_STATUS.FAINT) then
							if mvars.isCarried == false then	
							else
								mvars.isCarried = false
							end
						else
						end
					end
				},

				{
					
					msg = "MonologueEnd",
					sender = "Ocelot",
					func = function (gameObjectId, speechLabel, isSuccess )
						this.ResetInteruptTalk(speechLabel, isSuccess)	

						if speechLabel == StrCode32("MBTS_370") then
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_370 end ####")
								this.ResetOcelotTooFarTalk()	

								mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_2	
								mvars.isInterruptTalk= false	
							else
								s10030_radio.FailedRequest()
							end

						elseif speechLabel == StrCode32("MBTS_371") then	
							if isSuccess ~= 0 then
								Fox.Log("#### MBTS_371 end ####")
								this.ResetOcelotTooFarTalk()	

								mvars.ocerotTalkProcess = this.OCELOT_TALK_PROCESS.WAITING_3	
								mvars.isInterruptTalk= false	
							else
								s10030_radio.FailedRequest()
							end
						end
					end
				}

			},
			}
	end,

	
	OnEnter = function ()

		
		svars.restartSeq = RESTART_SEQUENCE.CLEAR_HANG_TUTORIAL
		vars.playerDisableActionFlag =  PLAYER_DISABLE.CLEAR_HANG_TUTORIAL


		
		this.SetMbDvcAtTutorialClear()

		mvars.OcelotTooFarCount	=0	
		svars.isClearAllTutorial =true	

		TppUiStatusManager.ClearStatus("AnnounceLog")	

		
		mvars.ocerotTalkProcess =  this.OCELOT_TALK_PROCESS.WAITING_1
		s10030_radio.OcelotAllClear()	

		TppUiStatusManager.UnsetStatus( "MbEquipDevelop", "BLOCK_CANCEL" )					
		TppUiStatusManager.UnsetStatus( "MbMap", "BLOCK_NAVIGATION" )

		this.LandingZoneForRestart()

	end,

	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	
		s10030_enemy.SetSaluteNormalAll()
	end,

	
	OnUpdate = function ()
		if (this.GetDistanceFromPlayer( "Ocelot", "TppOcelot2" ) < DISTANCE_APPROACH) then
			
			if mvars.ocerotTalkProcess == this.OCELOT_TALK_PROCESS.WAITING_1 then
				
				s10030_radio.OcelotAllClear()	
				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	

			elseif mvars.ocerotTalkProcess ==  this.OCELOT_TALK_PROCESS.WAITING_2 then	
				s10030_enemy.SetEnemyWakeUpAll()
				s10030_enemy.SetClearedRoute()	

				GkEventTimerManager.Stop( "Timer_waitApproachOcelot" )	
				if mvars.isCallHeliForMissionClear == false	then
					s10030_radio.OcelotAllClear_CallHeli()	
					TppUI.ShowControlGuide{ actionName = "MB_DEVICE", continue = false }	
				else
					s10030_radio.OcelotAllClearToHeli()	
				end
			end
		end
	end,



}



sequences.Seq_Game_TakingOffHeli = {
	
	OnEnter = function ()
	end,

	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	
	end,
}




sequences.Seq_Game_MissionClear = {

	
	OnEnter = function ()



		
		
		
		this.SetMbDvcAtClear()

	
	
		










		








































		
		
		
		

		
		this.ReserveMissionClear()
	end,


	
	OnLeave = function ()
		svars.LastFultonCount		=svars.FulltonCount 	
	end,


}





return this
