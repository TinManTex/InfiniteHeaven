local this={}
local i=Tpp.IsTypeFunc
local i=Tpp.IsTypeTable
local i=Tpp.IsTypeString
local i=Tpp.IsTypeNumber
local i=bit.bnot
local i,i,i=bit.band,bit.bor,bit.bxor
function this.StartTitle(i)
  TppSystemLua.UseAiSystem(true)
  TppSimpleGameSequenceSystem.Start()
  local function t()
    TppSave.CopyGameDataFromSavingSlot()
    this.InitializeForNewMission{}
    TppSave.VarSaveOnlyGlobalData()
  end
  gvars.ini_isTitleMode=true
  local o=TppDefine.SYS_MISSION_ID.INIT
  if TppSave.IsGameDataLoadResultOK()then
    if Tpp.IsMaster()then
      t()
    elseif i then
      i()
    else
      t()
    end
  else
    if gvars.gameDataLoadingResult==TppDefine.SAVE_FILE_LOAD_RESULT.NOT_EXIST_FILE then
    end
  end
  this.SetVarsTitle()PlayRecord.RegistPlayRecord"TPP_START_UP"TppSave.VarSavePersonalData()
  TppMission.RequestLoad(vars.missionCode,o,{showLoadingTips=false})
  local e=Fox.GetActMode()
  if(e=="EDIT")then
    Fox.SetActMode"GAME"end
end
function this.SetVarsTitle()
  TppMission.VarResetOnNewMission()
  local i=TppDefine.SYS_MISSION_ID.TITLE
  local e=TppDefine.LOCATION_ID.INIT
  gvars.title_nextMissionCode=vars.missionCode
  gvars.title_nextLocationCode=vars.locationCode
  vars.missionCode=i
  vars.locationCode=e
  TppPlayer.ResetInitialPosition()
  TppPlayer.ResetMissionStartPosition()
end
function this.InitializeOnStartTitle()
  this.InitializeOnStatingMainFrame()
  this.InitializeOnNewGameAtFirstTime()
  this.InitializeOnNewGame()
end
function this.InitializeOnTitle()BaseDefenseManager.Reset()
end
function this.ClearAllVarsAndSlot()
  vars.locationCode=TppDefine.LOCATION_ID.INIT
  vars.missionCode=TppDefine.SYS_MISSION_ID.INIT
  TppScriptVars.InitForNewGame()
  TppGVars.AllInitialize()
  TppSave.VarSave(TppDefine.SYS_MISSION_ID.INIT,true)
  TppSave.VarSaveConfig()
  TppSave.VarSavePersonalData()
  local i=TppSave.GetSaveGameDataQueue(vars.missionCode)
  for t,e in ipairs(i.slot)do
    TppScriptVars.CopySlot({i.savingSlot,e},e)
  end
end
function this.InitializeOnStatingMainFrame()
  local t=1024
  local a=1024*1024
  local e={[TppDefine.SAVE_SLOT.GLOBAL+1]=100,[TppDefine.SAVE_SLOT.CHECK_POINT+1]=100,[TppDefine.SAVE_SLOT.RETRY+1]=100,[TppDefine.SAVE_SLOT.MB_MANAGEMENT+1]=100,[TppDefine.SAVE_SLOT.QUEST+1]=100,[TppDefine.SAVE_SLOT.MISSION_START+1]=100,[TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE+1]=100}
  local o={}
  local i=0
  for n,t in ipairs(e)do
    i=i+t
    o[n]=t
  end
  e[TppDefine.SAVE_SLOT.SAVING+1]=i+92
  local n=1*t
  local i=TppGameSequence.GetTargetPlatform()
  if((i=="Steam"or i=="Win32")or i=="Win64")then
    n=2*t
  end
  e[TppDefine.SAVE_SLOT.CONFIG+1]=n
  e[TppDefine.SAVE_SLOT.CONFIG_SAVE+1]=e[TppDefine.SAVE_SLOT.CONFIG+1]
  local i=3*t
  if Tpp.IsQARelease()then
    i=4*t
  end
  if TppScriptVars.ENABLE_STORED_PARAMETER~=0 then
    i=i+(4*a)
  end
  e[TppDefine.SAVE_SLOT.PERSONAL+1]=i
  e[TppDefine.SAVE_SLOT.PERSONAL_SAVE+1]=i
  Tpp.DEBUG_DumpTable(o)
  Tpp.DEBUG_DumpTable(e)
  TppScriptVars.CreateSaveSlot(e)
  TppSave.RegistCompositSlotSize(o)
  TppSave.SetUpCompositSlot()
  TppScriptVars.SetFileSizeList{{TppSave.GetGameSaveFileName(),e[TppDefine.SAVE_SLOT.SAVING+1]},{TppDefine.CONFIG_SAVE_FILE_NAME,e[TppDefine.SAVE_SLOT.CONFIG+1]},{TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,e[TppDefine.SAVE_SLOT.PERSONAL+1]},{TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,e[TppDefine.SAVE_SLOT.PERSONAL+1]}}
end
function this.InitializeOnNewGameAtFirstTime()
  vars.locationCode=TppDefine.LOCATION_ID.INIT
  vars.missionCode=TppDefine.SYS_MISSION_ID.TITLE
end
function this.InitializeOnNewGame()
  if not Tpp.IsMaster()then
    if gvars.DEBUG_skipInitializeOnNewGame then
      gvars.DEBUG_skipInitializeOnNewGame=false
      return
    end
  end
  TppGVars.InitializeOnTitle()
  gvars.ply_initialPlayerState=TppDefine.INITIAL_PLAYER_STATE.ON_FOOT
  gvars.ply_missionStartPoint=0
  gvars.str_storySequence=TppDefine.STORY_SEQUENCE.STORY_START
  TppPackList.SetDefaultMissionPackLabelName()
  gvars.sav_varRestoreForContinue=false
  TppStory.PermitMissionOpen(10010)
  TppStory.MissionOpen(10010)
  local e=false
  if not e then
    SsdSbm.SetupInitialEquipment{body="PRD_ACC_Body_36",arm="PRD_ACC_Arm_16",leg="PRD_ACC_Foot_15"}SsdSbm.StoreToSVars()
  end
  SsdBuilding.SetLevel{level=0}SsdBuilding.RemoveAll()SsdCrewSystem.RemoveAll()SsdBaseManagement.InitializeResource()MissionObjectiveInfoSystem.Clear()
  if TppScriptVars.InitForTitleNewGame then
    TppScriptVars.InitForTitleNewGame()
  end
  SsdMarker.ClearMarker()BaseDefenseManager.Reset()
end
function this.InitializeForNewMission(i)
  TppSave.VarRestoreOnMissionStart()
  if(Tpp.IsQARelease()or nil)then
    TppDebug.DEBUG_RestoreSVars()
  end
  TppStory.DisableMissionNewOpenFlag(vars.missionCode)
  if i.sequence and i.sequence.MISSION_START_INITIAL_WEATHER then
    TppWeather.SetMissionStartWeather(i.sequence.MISSION_START_INITIAL_WEATHER)
  end
  TppWeather.RestoreMissionStartWeather()
  TppPlayer.SetInitialPlayerState(i)
  TppPlayer.ResetDisableAction()
  TppEnemy.RestoreOnMissionStart()Player.ResetVarsOnMissionStart()
  TppUI.OnMissionStart()
  local i=TppMission.SetMissionOrderBoxPosition()
  if not i then
    if TppMission.IsFreeMission(vars.missionCode)then
      TppPlayer.SetMissionStartPositionFromNoOrderBoxPosition()
    end
  end
  TppPlayer.SetInitialPositionFromMissionStartPosition()
  TppBuddyService.ResetVarsMissionStart()
  if not gvars.ini_isTitleMode then
    Vehicle.LoadCarry()
  end
  Gimmick.RestoreSaveDataPermanentGimmickFromMission()
  if Tpp.IsEditorNoLogin()and not gvars.isContinueFromTitle then
    this.SetBuildingLevel()
    this.InitializeBuildingData(true)
  else
    this.RestoreBuildingData()
  end
  SsdCrewSystem.Restore()SsdBaseManagement.Restore()MissionObjectiveInfoSystem.Clear()RecordRanking.WriteServerRankingScore()
end
function this.RestoreBuildingData()
  if Tpp.IsEditorNoLogin()then
    if(SsdBuilding.GetLevel()==0)then
      this.InitializeBuildingData()
    end
    return
  end
  SsdBuilding.Restore{}
  local i=TppStory.GetCurrentStorySequence()
  if(i>=TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST)then
    this.RegisterBuildingOnFOB()
  end
  SsdBaseManagement.CheckResourceCounter{}
end
function this.InitializeBuildingData(i)
  local t=TppStory.GetCurrentStorySequence()
  if(t>=TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST)then
    this.RegisterBuildingOnFOB()
  end
  if not TppLocation.IsAfghan()then
    return
  end
  if not i then
    local e=SsdBuilding.GetLevel()
    if e>0 then
      return
    end
  end
  if not Editor and TppServerManager.IsLoginKonami()then
    return
  end
  SsdBuilding.SetLevel{level=1}
  local d=Fox.StrCode32"PRD_BLD_Rubble_A"local o=Fox.StrCode32"PRD_BLD_Rubble_B"local e=Fox.StrCode32"PRD_BLD_Rubble_C"local n=Fox.StrCode32"PRD_BLD_Rubble_D"local i=Fox.StrCode32"PRD_BLD_Rubble_E"local t=Fox.StrCode32"PRD_BLD_Rubble_F"local e=Fox.StrCode32"PRD_BLD_Rubble_G"local r=Fox.StrCode32"PRD_BLD_Rubble_H"local a=Fox.StrCode32"PRD_BLD_Rubble_I"local l=Fox.StrCode32"PRD_BLD_Rubble_J"local l=Fox.StrCode32"PRD_BLD_Rubble_K"SsdBuilding.CreateItemNoAreaCheck{row=19,col=27,buildingId=d,rotType=0}SsdBuilding.CreateItemNoAreaCheck{row=21,col=23,buildingId=o,rotType=180}SsdBuilding.CreateItemNoAreaCheck{row=21,col=10,buildingId=o,rotType=0}SsdBuilding.CreateItemNoAreaCheck{row=12,col=10,buildingId=o,rotType=180}SsdBuilding.CreateItemNoAreaCheck{row=10,col=29,buildingId=o,rotType=0}SsdBuilding.CreateItemNoAreaCheck{row=25,col=29,buildingId=n,rotType=0}SsdBuilding.CreateItemNoAreaCheck{row=28,col=4,buildingId=n,rotType=90}SsdBuilding.CreateItemNoAreaCheck{row=4,col=22,buildingId=n,rotType=270}SsdBuilding.CreateItemNoAreaCheck{row=13,col=22,buildingId=i,rotType=90}SsdBuilding.CreateItemNoAreaCheck{row=13,col=7,buildingId=i,rotType=270}SsdBuilding.CreateItemNoAreaCheck{row=19,col=7,buildingId=i,rotType=270}SsdBuilding.CreateItemNoAreaCheck{row=10,col=19,buildingId=i,rotType=180}SsdBuilding.CreateItemNoAreaCheck{row=25,col=13,buildingId=i,rotType=0}SsdBuilding.CreateItemNoAreaCheck{row=23,col=19,buildingId=i,rotType=0}SsdBuilding.CreateItemNoAreaCheck{row=10,col=19,buildingId=i,rotType=0}SsdBuilding.CreateItemNoAreaCheck{row=5,col=9,buildingId=t,rotType=0}SsdBuilding.CreateItemNoAreaCheck{row=5,col=16,buildingId=t,rotType=180}SsdBuilding.CreateItemNoAreaCheck{row=8,col=26,buildingId=t,rotType=90}SsdBuilding.CreateItemNoAreaCheck{row=16,col=5,buildingId=t,rotType=90}SsdBuilding.CreateItemNoAreaCheck{row=8,col=5,buildingId=t,rotType=270}SsdBuilding.CreateItemNoAreaCheck{row=5,col=13,buildingId=e,rotType=90}SsdBuilding.CreateItemNoAreaCheck{row=17,col=12,buildingId=e,rotType=90}SsdBuilding.CreateItemNoAreaCheck{row=22,col=27,buildingId=e,rotType=270}SsdBuilding.CreateItemNoAreaCheck{row=13,col=26,buildingId=e,rotType=0}SsdBuilding.CreateItemNoAreaCheck{row=17,col=24,buildingId=e,rotType=0}SsdBuilding.CreateItemNoAreaCheck{row=8,col=11,buildingId=e,rotType=90}SsdBuilding.CreateItemNoAreaCheck{row=7,col=17,buildingId=e,rotType=90}SsdBuilding.CreateItemNoAreaCheck{row=26,col=9,buildingId=r,rotType=180}SsdBuilding.CreateItemNoAreaCheck{row=19,col=20,buildingId=r,rotType=90}SsdBuilding.CreateItemNoAreaCheck{row=15,col=30,buildingId=r,rotType=90}SsdBuilding.CreateItemNoAreaCheck{row=7,col=3,buildingId=a,rotType=180}SsdBuilding.CreateItemNoAreaCheck{row=3,col=28,buildingId=a,rotType=90}SsdBuilding.CreateItemNoAreaCheck{row=17,col=10,buildingId=a,rotType=0}SsdBuilding.CreateItemNoAreaCheck{row=26,col=26,buildingId=l,rotType=180}SsdBuilding.CreateItemNoAreaCheck{row=24,col=24,buildingId=l,rotType=0}SsdBuilding.CreateItemNoAreaCheck{row=8,col=24,buildingId=l,rotType=0}
  local e=Fox.StrCode32"PRD_BLD_Kitchen_A"SsdBuilding.CreateItem{row=19,col=13,buildingId=e,rotType=180}
  local e=Fox.StrCode32"PRD_BLD_WeaponPlant_A"SsdBuilding.CreateItem{row=19,col=12,buildingId=e,rotType=90}
  local e=Fox.StrCode32"PRD_BLD_AccessoryPlant_A"SsdBuilding.CreateItem{row=18,col=12,buildingId=e,rotType=90}
  local e=Fox.StrCode32"PRD_BLD_GadgetPlant_A"SsdBuilding.CreateItem{row=17,col=12,buildingId=e,rotType=90}
  local function i(i,e)
    for t,e in ipairs(e)do
      local o,n,t,e=e[1],e[2],e[3],e[4]SsdBuilding.CreateItem{row=o,col=n,buildingId=i,rotType=t,edgeType=e}
    end
  end
  local e=Fox.StrCode32"PRD_DEF_Barricade_A"local t={{12,18,0,0},{12,17,0,0},{12,15,0,0},{12,14,0,0},{12,20,0,1},{13,20,0,1},{15,20,0,1},{17,21,0,1},{20,17,0,0},{20,16,0,0},{20,14,0,0},{20,13,0,0}}i(e,t)
  local t=Fox.StrCode32"PRD_DEF_Barricade_A"local e={{23,17,0,0},{23,16,0,0},{23,14,0,0},{23,13,0,0},{9,19,0,0},{9,18,0,0},{9,16,0,0},{9,15,0,0},{11,13,0,0},{11,14,0,0},{11,16,0,0},{11,17,0,0},{21,19,0,0},{21,18,0,0},{21,16,0,0},{21,15,0,0}}i(t,e)SsdBuilding.Save()SsdBuilding.SetNewGame()
end
function this.RegisterBuildingOnFOB()
  local i=this.FobBuildingList
  if TppLocation.IsMiddleAfrica()then
    for i,e in pairs(i)do
      local e=Gimmick.SsdGetGameObjectId{gimmickId=e.gimmickId,name=e.name,dataSetName=e.dataSetName}SsdBuilding.RegisterAfricaItem{gameObjectId=e}
    end
  else
    for i,e in pairs(i)do
      local e=e.productionId
      SsdBuilding.RegisterAfricaItem{buildingId=Fox.StrCode32(e)}
    end
  end
end
function this.InitializeForContinue(i)
  TppSave.VarRestoreOnContinueFromCheckPoint()
  TppEnemy.RestoreOnContinueFromCheckPoint()Gimmick.RestoreSaveDataPermanentGimmickFromCheckPoint()
  vars.requestFlagsAboutEquip=255
  if i.sequence and i.sequence.ALWAYS_APPLY_TEMPORATY_PLAYER_PARTS_SETTING then
    TppPlayer.MissionStartPlayerTypeSetting()
  end
  this.SetBuildingLevel()
  this.RestoreBuildingData()SsdCrewSystem.Restore()SsdBaseManagement.Restore()
  if gvars.isContinueFromTitle then
    TppMission.IncrementRetryCount()
    TppSave.VarSaveOnRetry()
  end
end
function this.ClearIsContinueFromTitle()
  gvars.isContinueFromTitle=false
end
function this.StartInitMission()
  TppSystemLua.UseAiSystem(true)
  TppSimpleGameSequenceSystem.Start()
  vars.locationCode=TppDefine.LOCATION_ID.INIT
  vars.missionCode=TppDefine.SYS_MISSION_ID.INIT
  TppMission.VarResetOnNewMission()
  TppPlayer.ResetInitialPosition()
  TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
  TppSave.VarSave(nil,true)
  TppSave.VarSaveConfig()
  TppSave.VarSavePersonalData()
  TppMission.Load(vars.missionCode,nil,{force=true,showLoadingTips=false})
  local e=Fox.GetActMode()
  if(e=="EDIT")then
    Fox.SetActMode"GAME"end
end
function this.SetHorseObtainedAndCanSortie()
  TppBuddyService.SetObtainedBuddyType(BuddyType.HORSE)
  TppBuddyService.SetSortieBuddyType(BuddyType.HORSE)
end
function this.SetBuildingLevel()
  local i=TppStory.GetCurrentStorySequence()
  local e=SsdBuilding.GetLevel()
  if vars.ssdBuildingLevel<e then
    e=vars.ssdBuildingLevel
  end
  if TppDefine.STORY_SEQUENCE.BEFORE_k40150<i and e<2 then
    SsdBuilding.SetLevel{level=2}
  elseif e==0 then
    SsdBuilding.SetLevel{level=1}
  end
end
function this.SetTutorialPlayerHungerAndThirst()Player.SetHungerAndThirstForTutorial()
end
this.FobBuildingList={{gimmickId="GIM_P_PurificationTank",name="ssde_tank002_vrtn001_gim_n0000|srt_ssde_tank002_vrtn001",dataSetName="/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",productionId="PRD_BLD_DirtyWaterTank_B"},{gimmickId="GIM_P_WaterTank",name="ssde_tank001_gim_n0000|srt_ssde_tank001",dataSetName="/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",productionId="PRD_BLD_WaterTank_A"},{gimmickId="GIM_P_FoodBox",name="com_food_box001_gim_n0000|srt_food_box001",dataSetName="/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",productionId="PRD_BLD_FoodStorage_A"},{gimmickId="GIM_P_MedicalBox",name="ssde_mdcn002_gim_n0000|srt_ssde_mdcn002",dataSetName="/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",productionId="PRD_BLD_MedicalStorage_A"},{gimmickId="GIM_P_Warehouse",name="ssde_boxx001_gim_n0000|srt_ssde_boxx001",dataSetName="/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",productionId="PRD_BLD_Warehouse_A"},{gimmickId="GIM_P_Bed",name="ssde_bedd001_vrtn001_gim_n0000|srt_ssde_bedd001_vrtn001",dataSetName="/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",productionId="PRD_BLD_Shelter_B"}}
return this
