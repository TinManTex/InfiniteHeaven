local this={}
this.DeclareGVarsTable={
  {name="ini_isReturnToTitle",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="ini_isTitleMode",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="ini_isFirstLogin",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="needWaitMissionInitialize",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="enableResultPause",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="gameDataLoadingResult",type=TppScriptVars.TYPE_INT8,value=TppDefine.SAVE_FILE_LOAD_RESULT.INIT,save=false},
  {name="personalDataLoadingResult",type=TppScriptVars.TYPE_INT8,value=TppDefine.SAVE_FILE_LOAD_RESULT.INIT,save=false},
  {name="elapsedTimeSinceLastPlay",type=TppScriptVars.TYPE_UINT32,value=0,save=false},
  {name="waitLoadingTipsEnd",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="canExceptionHandling",type=TppScriptVars.TYPE_BOOL,value=true,save=false},
  {name="isContinueFromTitle",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="isLoadedInitMissionOnSignInUserChanged",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="isInitializedMapInfoSystem",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="mis_tempSequenceNumberForReload",type=TppScriptVars.TYPE_UINT32,value=0,save=false},
  {name="mis_skipOnPreLoadForContinue",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="mis_isReloaded",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="mis_coopClearType",type=TppScriptVars.TYPE_UINT8,value=0,save=false},
  {name="mis_chunkingCheckOnPreLoad",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="mis_needLoadMissionAfterChunkCheck",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="mis_nextMissionAfterChunkCheck",type=TppScriptVars.TYPE_UINT32,value=1,save=false},
  {name="mis_currentMissionAfterChunkCheck",type=TppScriptVars.TYPE_UINT32,value=1,save=false},
  {name="mis_skipUpdateBaseManagement",type=TppScriptVars.TYPE_BOOL,value=false,save=false,init=true},
  {name="mis_gameoverCount",type=TppScriptVars.TYPE_UINT8,value=0,save=false,init=true},
  {name="mis_isAbandonForDisconnect",type=TppScriptVars.TYPE_BOOL,value=false,save=false},--RETAILPATCH: 1.0.12
  {name="sav_permitGameSave",type=TppScriptVars.TYPE_BOOL,value=true,save=false},
  {name="sav_isCheckPointSaving",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="sav_isPersonalSaving",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="sav_isConfigSaving",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="sav_isReservedMbSaveResultNotify",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="sav_skipRestoreToVars",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="sav_needCheckPointSaveOnMissionStart",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="sav_SaveResultCheckFileName",type=TppScriptVars.TYPE_UINT32,value=0,save=false},
  {name="sav_continueForOutOfBaseArea",type=TppScriptVars.TYPE_BOOL,value=false,save=false,init=true},
  {name="sav_varRestoreForContinue",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},
  {name="exc_processState",type=TppScriptVars.TYPE_UINT8,value=0,save=false},
  {name="exc_skipDemoOnException",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="exc_skipServerSaveForException",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="exc_processingExecptionType",type=TppScriptVars.TYPE_UINT8,value=0,save=false},
  {name="exc_processingExecptionGameMode",type=TppScriptVars.TYPE_UINT8,value=0,save=false},
  {name="exc_processingForDisconnect",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="exc_exceptionQueueDepth",type=TppScriptVars.TYPE_UINT8,value=0,save=false},
  {name="exc_exceptionQueue",arraySize=TppDefine.EXCEPTION_QUEUE_MAX,type=TppScriptVars.TYPE_UINT8,value=0,save=false},
  {name="exc_queueGameMode",arraySize=TppDefine.EXCEPTION_QUEUE_MAX,type=TppScriptVars.TYPE_UINT8,value=0,save=false},
  {name="exc_skipDisconnectFromHostException",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="title_nextLocationCode",type=TppScriptVars.TYPE_UINT16,value=30,save=false},
  {name="title_nextMissionCode",type=TppScriptVars.TYPE_UINT16,value=0,save=false},
  {name="title_isInvitationStart",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="ene_soldier2CommonPackageLabelIndex",type=TppScriptVars.TYPE_UINT32,value=TppDefine.DEFAULT_SOLIDER2_COMMON_PACKAGE,save=false},
  {name="ene_fovaUniqueTargetIds",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT,save=false},
  {name="ene_fovaUniqueFaceIds",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT,save=false},
  {name="ene_fovaUniqueBodyIds",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT,save=false},
  {name="ene_fovaUniqueFlags",type=TppScriptVars.TYPE_UINT8,value=0,arraySize=TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT,save=false},
  {name="ui_isTipsGuidShownInThisGame",arraySize=TppDefine.MAX_TIPS_GUIDE_SHOWN_ONCE,type=TppScriptVars.TYPE_BOOL,value=false,save=false,category=TppScriptVars.CATEGORY_MISSION},
  {name="ui_isControlGuidShownInThisGame",arraySize=TppDefine.MAX_CONTROL_GUIDE_SHOWN_ONCE,type=TppScriptVars.TYPE_BOOL,value=false,save=false,category=TppScriptVars.CATEGORY_MISSION},
  {name="dbg_forceMaster",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="DEBUG_initMissionToTitle",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="DEBUG_showSysVars",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="DEBUG_showGameStatus",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="DEBUG_usingTemporarySaveData",type=TppScriptVars.TYPE_BOOL,value=true,save=false},
  {name="DEBUG_reserveDestroySaveData",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="DEBUG_skipInitialEquip",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="DEBUG_skipInitializeOnNewGame",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="DEBUG_reserveAddProductForPacing",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="DEBUG_reserveBaseActivated",type=TppScriptVars.TYPE_BOOL,value=false,save=false},--RETAILPATCH: 1.0.5.0
  {name="mis_isFromAvatarRoom",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="cLobby_isStartBase",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="mis_processingHostmigration",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="mis_lastResultOfHostmigration",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="heli_missionStartRoute",type=TppScriptVars.TYPE_UINT32,value=0,save=false},
  {name="e3_isShowedTitle",type=TppScriptVars.TYPE_BOOL,value=false,save=false},
  {name="isNewGame",type=TppScriptVars.TYPE_BOOL,value=true,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},
  {name="missionStartClock",type=TppScriptVars.TYPE_UINT32,value=(12*60)*60,save=true,category=TppScriptVars.CATEGORY_MISSION},
  {name="missionStartWeather",type=TppScriptVars.TYPE_UINT8,value=TppDefine.WEATHER.SUNNY,save=true,category=TppScriptVars.CATEGORY_MISSION},
  {name="missionStartWeatherNextTime",type=TppScriptVars.TYPE_FLOAT,value=(5*60)*60,save=true,category=TppScriptVars.CATEGORY_MISSION},
  {name="missionStartExtraWeatherInterval",type=TppScriptVars.TYPE_FLOAT,value=(8*60)*60,save=true,category=TppScriptVars.CATEGORY_MISSION},
  {name="mis_isStartFromFreePlay",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},
  {name="totalRetryCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_RETRY,init=true},
  {name="totalKillCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL,init=true},
  {name="totalRescueCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL,init=true},
  {name="totalheadShotCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL,init=true},
  {name="ply_isUsingTempPlayerType",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_lastPlayerPartsTypeUsingTemp",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_lastPlayerCamoTypeUsingTemp",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_lastPlayerHandTypeUsingTemp",type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_lastPlayerTypeUsingTemp",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_lastPlayerFaceIdUsingTemp",type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_lastPlayerFaceEquipIdUsingTemp",type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_isUsingTempWeapons",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_isUsingTempItems",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_lastWeaponsUsingTemp",arraySize=12,type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_lastItemsUsingTemp",arraySize=8,type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_lastHandEquipUsingTemp",type=TppScriptVars.TYPE_UINT16,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_useMissionStartPos",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_missionStartPos",type=TppScriptVars.TYPE_FLOAT,value=0,arraySize=3,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_missionStartRot",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_useMissionStartPosForNoOrderBox",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_missionStartPosForNoOrderBox",type=TppScriptVars.TYPE_FLOAT,value=0,arraySize=3,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_missionStartRotForNoOrderBox",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_initialPlayerState",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_missionStartPoint",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ply_startPosTempForBaseDefense",type=TppScriptVars.TYPE_FLOAT,value=0,arraySize=4,save=false,init=true},
  {name="str_storySequence",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL,init=true},
  {name="str_missionOpenPermission",type=TppScriptVars.TYPE_BOOL,value=false,arraySize=TppDefine.MISSION_COUNT_MAX,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL,init=true},
  {name="str_missionOpenFlag",type=TppScriptVars.TYPE_BOOL,value=false,arraySize=TppDefine.MISSION_COUNT_MAX,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL,init=true},
  {name="str_missionClearedFlag",type=TppScriptVars.TYPE_BOOL,value=false,arraySize=TppDefine.MISSION_COUNT_MAX,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL,init=true},
  {name="str_missionNewOpenFlag",type=TppScriptVars.TYPE_BOOL,value=false,arraySize=TppDefine.MISSION_COUNT_MAX,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL,init=true},
  {name="str_isAllMissionCleared",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL,init=true},
  {name="str_isAllMissionSRankCleared",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL,init=true},
  {name="str_elapsedMissionCount",arraySize=TppDefine.ELAPSED_MISSION_COUNT_MAX,type=TppScriptVars.TYPE_INT8,value=-127,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL,init=true},
  {name="mis_isExistOpenMissionFlag",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="mis_checkPoint",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="mis_orderBoxName",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="mis_nextLocationCodeForMissionClear",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="mis_nextMissionCodeForMissionClear",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="mis_missionClearState",type=TppScriptVars.TYPE_UINT8,value=TppDefine.MISSION_CLEAR_STATE.INIT,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ene_takingOverHostageCount",type=TppScriptVars.TYPE_UINT8,value=0,save=false},
  {name="ene_takingOverHostagePositions",type=TppScriptVars.TYPE_FLOAT,value=0,arraySize=TppDefine.MAX_TAKING_OVER_HOSTAGE_COUNT*3,save=false},
  {name="ene_takingOverHostageStaffIdsUpper",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=TppDefine.MAX_TAKING_OVER_HOSTAGE_COUNT,save=false},
  {name="ene_takingOverHostageStaffIdsLower",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=TppDefine.MAX_TAKING_OVER_HOSTAGE_COUNT,save=false},
  {name="ene_takingOverHostageFaceIds",type=TppScriptVars.TYPE_UINT16,value=0,arraySize=TppDefine.MAX_TAKING_OVER_HOSTAGE_COUNT,save=false},
  {name="ene_takingOverHostageFlags",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=TppDefine.MAX_TAKING_OVER_HOSTAGE_COUNT,save=false},
  {name="col_daimondStatus_afgh",type=TppScriptVars.TYPE_UINT8,value=0,arraySize=2e3,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="col_markerStatus_afgh",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=33,save=true,category=TppScriptVars.CATEGORY_MISSION_RESTARTABLE,init=true},
  {name="col_isRegisteredInDb_afgh",type=TppScriptVars.TYPE_BOOL,value=0,arraySize=2e3,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="col_daimondStatus_mafr",type=TppScriptVars.TYPE_UINT8,value=0,arraySize=2e3,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="col_markerStatus_mafr",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=33,save=true,category=TppScriptVars.CATEGORY_MISSION_RESTARTABLE,init=true},
  {name="col_isRegisteredInDb_mafr",type=TppScriptVars.TYPE_BOOL,value=0,arraySize=2e3,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="pck_missionPackLabelName",type=TppScriptVars.TYPE_UINT32,value=Fox.StrCode32"default",save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="rwd_missionRewardLangEnum",arraySize=TppDefine.REWARD_MAX.MISSION,type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="rwd_missionRewardStackSize",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="rwd_missionRewardParam",arraySize=TppDefine.REWARD_MAX.MISSION*TppDefine.REWARD_PARAM.MAX,type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="rwd_storySequenceReward",type=TppScriptVars.TYPE_INT32,value=-1,save=true,category=TppScriptVars.CATEGORY_MISSION_RESTARTABLE,init=true},
  {name="ui_isTaskLastComleted",arraySize=#TppDefine.MISSION_LIST*TppDefine.MAX_MISSION_TASK_COUNT,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="solface_groupNumber",type=TppScriptVars.TYPE_UINT32,value=672983,save=true,category=TppScriptVars.CATEGORY_MISSION},
  {name="hosface_groupNumber",type=TppScriptVars.TYPE_UINT32,value=88069,save=true,category=TppScriptVars.CATEGORY_MISSION},
  {name="trm_recoveredSoldierCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},
  {name="trm_recoveredHostageCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},
  {name="trm_recoveredAfghGoatCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},
  {name="trm_recoveredMafrGoatCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},
  {name="trm_recoveredDonkeyCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},
  {name="trm_recoveredZebraCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},
  {name="trm_recoveredOkapiCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},
  {name="trm_animalRecoverHistory",type=TppScriptVars.TYPE_UINT32,arraySize=TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},
  {name="trm_animalRecoverHistorySize",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL},
  {name="res_bestRank",type=TppScriptVars.TYPE_UINT8,arraySize=TppDefine.MISSION_COUNT_MAX,value=(TppDefine.MISSION_CLEAR_RANK.E+1),save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="rnk_isOpen",arraySize=TppDefine.RANKING_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL,init=true},
  {name="rnk_CboxGlidingDistance",type=TppScriptVars.TYPE_FLOAT,value=0,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL,init=true},
  {name="rnk_missionBestScore",type=TppScriptVars.TYPE_UINT32,value=0,arraySize=TppDefine.MISSION_COUNT_MAX,save=true,category=TppScriptVars.CATEGORY_GAME_GLOBAL,init=true},
  {name="qst_currentQuestName",arraySize=#TppDefine.QUEST_BLOCK_TYPE_DEFINE,type=TppScriptVars.TYPE_UINT32,value=0,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="qst_currentQuestStepNumber",arraySize=#TppDefine.QUEST_BLOCK_TYPE_DEFINE,type=TppScriptVars.TYPE_UINT8,value=0,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="qst_questOpenFlag",arraySize=TppDefine.QUEST_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="qst_questRepopFlag",arraySize=TppDefine.QUEST_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="qst_questClearedFlag",arraySize=TppDefine.QUEST_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="qst_questActiveFlag",arraySize=TppDefine.QUEST_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="qst_questFailureFlag",arraySize=TppDefine.QUEST_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="qst_questSuspendFlag",arraySize=TppDefine.QUEST_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="qst_questAcceptedFlag",arraySize=TppDefine.QUEST_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="qst_questLockedFlag",arraySize=TppDefine.QUEST_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="rwd_questRewardLangEnum",arraySize=TppDefine.REWARD_MAX.QUEST,type=TppScriptVars.TYPE_UINT8,value=0,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="rwd_questRewardStackSize",type=TppScriptVars.TYPE_UINT8,value=0,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="rwd_questRewardParam",arraySize=TppDefine.REWARD_MAX.QUEST*TppDefine.REWARD_PARAM.MAX,type=TppScriptVars.TYPE_UINT32,value=0,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="qst_allQuestCleared",type=TppScriptVars.TYPE_BOOL,value=false,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="qst_randomFaceId",arraySize=TppDefine.QUEST_FACE_MAX,type=TppScriptVars.TYPE_UINT16,value=0,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="qst_elapseCount",type=TppScriptVars.TYPE_INT8,value=-127,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="qst_failedIndex",arraySize=10,type=TppScriptVars.TYPE_INT32,value=-1,save=false,category=TppScriptVars.CATEGORY_QUEST,init=true},
  {name="fms_currentFlagMissionCode",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="fms_currentFlagStepNumber",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="bdf_currentMissionName",type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="bdf_currentStepNumber",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="retryCount",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_RETRY},
  {name="failedCount",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_RETRY},
  {name="timeParadoxCount",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_RETRY},
  {name="playTime",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_RETRY},
  {name="crawlTime",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_RETRY},
  {name="squatTime",type=TppScriptVars.TYPE_INT32,value=0,save=true,category=TppScriptVars.CATEGORY_RETRY},
  {name="continueTipsCount",type=TppScriptVars.TYPE_INT32,value=1,save=true,category=TppScriptVars.CATEGORY_RETRY},
  {name="ui_isTipsGuideShownOnce",arraySize=TppDefine.MAX_TIPS_GUIDE_SHOWN_ONCE,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="ui_isControlGuideShownOnce",arraySize=TppDefine.MAX_CONTROL_GUIDE_SHOWN_ONCE,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="res_coopBestRank",type=TppScriptVars.TYPE_UINT8,arraySize=TppDefine.MISSION_COUNT_MAX,value=(TppDefine.MISSION_CLEAR_RANK.E+1),save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="res_coopBestWaveCount",type=TppScriptVars.TYPE_UINT8,arraySize=TppDefine.MISSION_COUNT_MAX,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="res_coopBestPersonalScore",type=TppScriptVars.TYPE_UINT32,arraySize=TppDefine.MISSION_COUNT_MAX,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="res_coopBestIrisScore",type=TppScriptVars.TYPE_UINT32,arraySize=TppDefine.MISSION_COUNT_MAX,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},
  {name="res_coopBestRescuedCount",type=TppScriptVars.TYPE_UINT8,arraySize=TppDefine.MISSION_COUNT_MAX,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION,init=true},--RETAILPATCH: 1.0.5.0
  {name="mis_isDemoGluttonyBossAppearance",type=TppScriptVars.TYPE_BOOL,value=false,save=false,server=true},
  {name="mis_isDemoAerialBossAppearance",type=TppScriptVars.TYPE_BOOL,value=false,save=false,server=true},
  {name="mis_isNotifiedBuildingLevel",type=TppScriptVars.TYPE_BOOL,value=false,save=false,server=true},--RETAILPATCH: 1.0.5.0
  nil
}
Tpp.ApendArray(this.DeclareGVarsTable,Ivars.DeclareVars())--tex
TppScriptVars.DeclareGVars(this.DeclareGVarsTable)
Mission.RegisterUserGvars()
if Fox.GetPlatformName()=="PS3"then
  this.DeclareGVarsTable=nil
end
function this.AllInitialize()
  if this.DeclareGVarsTable==nil then
    return
  end
  for i,gvar in ipairs(this.DeclareGVarsTable)do
    local name,arraySize,value=gvar.name,gvar.arraySize,gvar.value
    if arraySize and(arraySize>1)then
      for j=0,(arraySize-1)do
        gvars[name][j]=value
      end
    else
      gvars[name]=value
    end
  end
end
function this.InitializeOnTitle()
  if this.DeclareGVarsTable==nil then
    return
  end
  for i,gvar in ipairs(this.DeclareGVarsTable)do
    local name,arraySize,value,init=gvar.name,gvar.arraySize,gvar.value,gvar.init
    if init and(init==true)then
      if arraySize and(arraySize>1)then
        for j=0,(arraySize-1)do
          gvars[name][j]=value
        end
      else
        gvars[name]=value
      end
    end
  end
end
return this
