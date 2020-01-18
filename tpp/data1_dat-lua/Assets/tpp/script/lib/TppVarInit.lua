local e={}
local i=Tpp.IsTypeFunc
local s=Tpp.IsTypeTable
local i=Tpp.IsTypeString
local i=Tpp.IsTypeNumber
local i=bit.bnot
local i,i,i=bit.band,bit.bor,bit.bxor
function e.StartTitle(i)
  TppSystemLua.UseAiSystem(true)
  TppSimpleGameSequenceSystem.Start()
  local function DoStart()
    TppSave.CopyGameDataFromSavingSlot()
    e.InitializeForNewMission{}
    gvars.elapsedTimeSinceLastPlay=TppScriptVars.GetElapsedTimeSinceLastPlay()
    gvars.elapsedTimeSinceLastUseChickCap=gvars.elapsedTimeSinceLastUseChickCap+gvars.elapsedTimeSinceLastPlay
    TppSave.VarSaveOnlyGlobalData()
  end
  gvars.ini_isTitleMode=true
  local missionIdInit=TppDefine.SYS_MISSION_ID.INIT
  if TppSave.IsGameDataLoadResultOK()then
    do
      DoStart()
    end
    if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
      e.SetVarsTitleCypr()
    else
      e.SetVarsTitleHeliSpace()
    end
  else
    if gvars.gameDataLoadingResult==TppDefine.SAVE_FILE_LOAD_RESULT.NOT_EXIST_FILE then
    end
    e.SetVarsTitleCypr()
  end
  PlayRecord.RegistPlayRecord"TPP_START_UP"TppSave.VarSavePersonalData()
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
    TppMission.Load(vars.missionCode,missionIdInit,{showLoadingTips=false})
  else
    TppMission.RequestLoad(vars.missionCode,missionIdInit,{showLoadingTips=false})
  end
  local e=Fox.GetActMode()
  if(e=="EDIT")then
    Fox.SetActMode"GAME"
  end
end
function e.SetVarsTitleCypr()
  TppMission.VarResetOnNewMission()
  vars.locationCode=TppDefine.LOCATION_ID.CYPR
  vars.missionCode=10010
  TppPlayer.SetWeapons(TppDefine.CYPR_PLAYER_INITIAL_WEAPON_TABLE)
  TppPlayer.SetItems(TppDefine.CYPR_PLAYER_INITIAL_ITEM_TABLE)
  gvars.title_nextLocationCode=vars.locationCode
  gvars.title_nextMissionCode=vars.missionCode
end
function e.SetVarsTitleHeliSpace()
  TppMission.VarResetOnNewMission()
  local i,e=TppMission.GetCurrentLocationHeliMissionAndLocationCode()
  gvars.title_nextMissionCode=vars.missionCode
  gvars.title_nextLocationCode=e
  vars.missionCode=i
  vars.locationCode=e
  TppUiCommand.LoadoutSetForStartFromHelicopter()
  TppHelicopter.ResetMissionStartHelicopterRoute()
  TppPlayer.ResetInitialPosition()
  TppPlayer.ResetMissionStartPosition()
end
function e.InitializeOnStartTitle()
  e.InitializeOnStatingMainFrame()
  e.InitializeOnNewGameAtFirstTime()
  e.InitializeOnNewGame()
end
function e.InitializeOnStatingMainFrame()
  local i=1024
  local e={[TppDefine.SAVE_SLOT.GLOBAL+1]=14*i,[TppDefine.SAVE_SLOT.CHECK_POINT+1]=65*i,[TppDefine.SAVE_SLOT.RETRY+1]=11*i,[TppDefine.SAVE_SLOT.MB_MANAGEMENT+1]=80.5*i+2688,[TppDefine.SAVE_SLOT.QUEST+1]=2*i,[TppDefine.SAVE_SLOT.MISSION_START+1]=10*i,[TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE+1]=10*i}
  local t={}
  local a=0
  for n,i in ipairs(e)do
    a=a+i
    t[n]=i
  end
  e[TppDefine.SAVE_SLOT.SAVING+1]=a+92
  local n=1*i
  local a=TppGameSequence.GetTargetPlatform()
  if((a=="Steam"or a=="Win32")or a=="Win64")then
    n=2*i
  end
  e[TppDefine.SAVE_SLOT.CONFIG+1]=n
  e[TppDefine.SAVE_SLOT.CONFIG_SAVE+1]=e[TppDefine.SAVE_SLOT.CONFIG+1]
  local a=3*i
  e[TppDefine.SAVE_SLOT.PERSONAL+1]=a
  e[TppDefine.SAVE_SLOT.PERSONAL_SAVE+1]=a
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    local i=16*i
    e[TppDefine.SAVE_SLOT.MGO+1]=i
    e[TppDefine.SAVE_SLOT.MGO_SAVE+1]=i
  end
  Tpp.DEBUG_DumpTable(t)
  Tpp.DEBUG_DumpTable(e)
  TppScriptVars.CreateSaveSlot(e)
  TppSave.RegistCompositSlotSize(t)
  TppSave.SetUpCompositSlot()
  TppScriptVars.SetFileSizeList{{TppSave.GetGameSaveFileName(),e[TppDefine.SAVE_SLOT.SAVING+1]},{TppDefine.CONFIG_SAVE_FILE_NAME,e[TppDefine.SAVE_SLOT.CONFIG+1]},{TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,e[TppDefine.SAVE_SLOT.PERSONAL+1]},{TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,e[TppDefine.SAVE_SLOT.PERSONAL+1]},{"MGO_GAME_DATA",16*i}}
end
function e.InitializeOnNewGameAtFirstTime()
  vars.locationCode=TppDefine.LOCATION_ID.CYPR
  vars.missionCode=10010
end
function e.InitializeOnNewGame()
  gvars.ply_initialPlayerState=TppDefine.INITIAL_PLAYER_STATE.ON_FOOT
  gvars.ply_missionStartPoint=0
  gvars.heli_missionStartRoute=0
  gvars.str_storySequence=TppDefine.STORY_SEQUENCE.STORY_START
  TppPackList.SetDefaultMissionPackLabelName()
  gvars.sav_varRestoreForContinue=false
  for e=0,TppDefine.MISSION_COUNT_MAX do
    gvars.str_missionOpenPermission[e]=false
  end
  for e=0,TppDefine.MISSION_COUNT_MAX do
    gvars.str_missionOpenFlag[e]=false
  end
  for e=0,TppDefine.MISSION_COUNT_MAX do
    gvars.str_missionClearedFlag[e]=false
  end
  TppStory.PermitMissionOpen(10010)
  TppStory.MissionOpen(10010)
  gvars.mis_isExistOpenMissionFlag=true
  gvars.ene_isRecoverdInterpreterAfgh=false
  gvars.ene_isRecoverdInterpreterMafr=false
  gvars.dbg_autoMissionOpenClearCheck=false
  gvars.ini_isTitleMode=false
  for e=0,1024 do
    gvars.gim_missionStartBreakableObjects[e]=0
    gvars.gim_checkPointBreakableObjects[e]=0
    gvars.gim_missionStartFultonableObjects[e]=0
    gvars.gim_checkPointStartFultonableObjects[e]=0
  end
  for e=0,511 do
    gvars.gim_brekableLightStatus[e]=false
  end
  for e=0,1999 do
    gvars.col_daimondStatus_afgh[e]=0
    gvars.col_daimondStatus_mafr[e]=0
    gvars.col_isRegisteredInDb_afgh[e]=false
    gvars.col_isRegisteredInDb_mafr[e]=false
  end
  for e=0,32 do
    gvars.col_markerStatus_afgh[e]=0
    gvars.col_markerStatus_mafr[e]=0
  end
  local i={"tp_bgm_10_01","tp_bgm_10_02","tp_bgm_10_03","tp_bgm_10_04","tp_bgm_10_05","tp_bgm_10_06","tp_bgm_10_07"}
  for i,e in ipairs(i)do
    TppMotherBaseManagement.AddCassetteTapeTrack(e)
  end
  TppMotherBaseManagement.DirectAddResource{resource="Plant2005",count=20,isNew=true}
  gvars.solface_groupNumber=(math.random(0,255)*65536)+math.random(1,255)
  gvars.hosface_groupNumber=(math.random(0,65535)*65536)+math.random(1,65535)
  local i,a
  do
    i={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,equip=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,equip=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SUPPORT_0,equip=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,equip=TppEquip.EQP_None}}a={TppEquip.EQP_None,TppEquip.EQP_None,TppEquip.EQP_None,TppEquip.EQP_None}
  end
  e.SetInitPlayerWeapons(i)
  TppPlayer.SupplyAllAmmoFullOnMissionFinalize()
  e.SetInitPlayerItems(a)
  e.InitializeAllPlatformForNewGame()
end
function e.InitializeForNewMission(e)
  TppSave.VarRestoreOnMissionStart()
  TppStory.DisableMissionNewOpenFlag(vars.missionCode)
  TppClock.RestoreMissionStartClock()
  if e.sequence and e.sequence.MISSION_START_INITIAL_WEATHER then
    TppWeather.SetMissionStartWeather(e.sequence.MISSION_START_INITIAL_WEATHER)
  end
  TppWeather.RestoreMissionStartWeather()
  TppPlayer.SetInitialPlayerState(e)
  TppPlayer.ResetDisableAction()
  TppEnemy.RestoreOnMissionStart()
  if e.sequence then
    TppPlayer.InitItemStockCount()
  end
  Player.ResetVarsOnMissionStart()
  TppPlayer.SetSelfSubsistenceOnHardMission()
  TppPlayer.RestoreChimeraWeaponParameter()
  if e.sequence and s(e.sequence.playerInitialWeaponTable)then
    TppPlayer.SetInitWeapons(e.sequence.playerInitialWeaponTable)
  end
  TppPlayer.RestorePlayerWeaponsOnMissionStart()
  TppPlayer.SetMissionStartAmmoCount()
  if e.sequence and s(e.sequence.playerInitialItemTable)then
    TppPlayer.SetInitItems(e.sequence.playerInitialItemTable)
  end
  TppPlayer.RestorePlayerItemsOnMissionStart()
  TppUI.OnMissionStart()
  local e=TppMission.SetMissionOrderBoxPosition()
  if not e then
    if TppMission.IsFreeMission(vars.missionCode)then
      TppPlayer.SetMissionStartPositionFromNoOrderBoxPosition()
    end
  end
  TppPlayer.SetInitialPositionFromMissionStartPosition()
  TppMotherBaseManagement.ClearAllStaffBonusPopupFlag()
  TppBuddyService.ResetVarsMissionStart()
  if not gvars.ini_isTitleMode then
    Vehicle.LoadCarry()
  end
  Gimmick.RestoreSaveDataPermanentGimmickFromMission()
  TppMotherBaseManagement.SetupAfterRestoreFromSVars()
end
function e.InitializeForContinue(e)
  TppSave.VarRestoreOnContinueFromCheckPoint()
  TppEnemy.RestoreOnContinueFromCheckPoint()
  if not TppMission.IsFOBMission(vars.missionCode)then
    Gimmick.RestoreSaveDataPermanentGimmickFromCheckPoint()
  end
  TppMotherBaseManagement.SetupAfterRestoreFromSVars()
  vars.requestFlagsAboutEquip=255
  if svars.chickCapEnabled then
    gvars.elapsedTimeSinceLastUseChickCap=0
  end
  if e.sequence and e.sequence.ALWAYS_APPLY_TEMPORATY_PLAYER_PARTS_SETTING then
    TppPlayer.MissionStartPlayerTypeSetting()
  end
  if gvars.isContinueFromTitle then
    TppMission.IncrementRetryCount()
    TppSave.VarSaveOnRetry()
  end
end
function e.ClearIsContinueFromTitle()
  gvars.isContinueFromTitle=false
end
function e.StartInitMission()
  TppSystemLua.UseAiSystem(true)
  TppSimpleGameSequenceSystem.Start()
  vars.locationCode=TppDefine.LOCATION_ID.INIT
  vars.missionCode=TppDefine.SYS_MISSION_ID.INIT
  TppMission.VarResetOnNewMission()
  TppPlayer.ResetInitialPosition()
  TppHelicopter.ResetMissionStartHelicopterRoute()
  TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
  TppSave.VarSave(nil,true)
  TppSave.VarSaveConfig()
  TppSave.VarSavePersonalData()
  TppMission.Load(vars.locationCode,nil,{force=true,showLoadingTips=false})
  local e=Fox.GetActMode()
  if(e=="EDIT")then
    Fox.SetActMode"GAME"end
end
function e.SetInitPlayerWeapons(e)
  for e,i in pairs(e)do
    local a=i.ammo
    local e=i.slot
    local t=i.equip
    local s=i.ammoMax
    local i=i.bulletId
    if e>=TppDefine.WEAPONSLOT.SUPPORT_0 and e<=TppDefine.WEAPONSLOT.SUPPORT_3 then
      local n=e-TppDefine.WEAPONSLOT.SUPPORT_0
      vars.initSupportWeapons[n]=t
      vars.ammoStockIds[e]=i
      vars.ammoStockCounts[e]=a
    else
      vars.initWeapons[e]=t
      vars.ammoStockIds[e]=i
      vars.ammoStockCounts[e]=a
      vars.ammoInWeapons[e]=s
      vars.isInitialWeapon[e]=1
    end
  end
end
function e.SetInitPlayerItems(e)
  for e,i in pairs(e)do
    vars.initItems[e-1]=i
    vars.items[e-1]=i
  end
end
function e.DEBUG_GetDefaultPlayerWeaponAndItemTable()
  return{{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,equip=TppEquip.EQP_WP_30101,bulletId=TppEquip.BL_Rf556x45mm,ammoMax=30,ammo=240},{slot=TppDefine.WEAPONSLOT.SECONDARY,equip=TppEquip.EQP_WP_10101,bulletId=TppEquip.BL_HgTranq,ammoMax=7,ammo=21},{slot=TppDefine.WEAPONSLOT.SUPPORT_0,equip=TppEquip.EQP_SWP_Grenade,bulletId=TppEquip.BL_SWP_Grenade,ammoMax=8,ammo=8},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,equip=TppEquip.EQP_SWP_Magazine,bulletId=TppEquip.BL_SWP_Magazine,ammoMax=-1,ammo=-1}},{TppEquip.EQP_None,TppEquip.EQP_IT_Nvg,TppEquip.EQP_IT_TimeCigarette,TppEquip.EQP_IT_CBox}
end
function e.InitializeAllPlatformForNewGame()
  local t=0
  local n=1
  local a={"Command","Combat","Develop","BaseDev","Support","Spy","Medical"}
  local e={"MotherBase","Fob1","Fob2","Fob3","Fob4"}
  for e,i in ipairs(e)do
    for a,e in ipairs(a)do
      TppMotherBaseManagement.SetClusterSvars{base=i,category=e,grade=t,buildStatus="Completed",timeMinute=0,isNew=false}
    end
  end
  TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category="Command",grade=n,buildStatus="Completed",timeMinute=0,isNew=true}
end
function e.SetHorseObtainedAndCanSortie()
  TppBuddyService.SetObtainedBuddyType(BuddyType.HORSE)
  TppBuddyService.SetSortieBuddyType(BuddyType.HORSE)
end
return e
