-- DOBUILD: 1
-- ssd TppVarInit.lua
InfInit=require"mod/core/InfInitMain"--tex here since can't add own internal scripts to ssd at the moment, TODO should probably saferequire
local this={}
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local IsTypeNumber=Tpp.IsTypeNumber
local bnot=bit.bnot
local band,bor,bxor=bit.band,bit.bor,bit.bxor
function this.StartTitle(StartFunc)
  TppSystemLua.UseAiSystem(true)
  TppSimpleGameSequenceSystem.Start()
  local function DoStart()
    TppSave.CopyGameDataFromSavingSlot()
    this.InitializeForNewMission{}
    TppSave.VarSaveOnlyGlobalData()
  end
  gvars.ini_isTitleMode=true
  local o=TppDefine.SYS_MISSION_ID.INIT
  if TppSave.IsGameDataLoadResultOK()then
    if Tpp.IsMaster()then
      DoStart()
    elseif StartFunc then
      StartFunc()
    else
      DoStart()
    end
  else
    if gvars.gameDataLoadingResult==TppDefine.SAVE_FILE_LOAD_RESULT.NOT_EXIST_FILE then
    end
  end
  this.SetVarsTitle()PlayRecord.RegistPlayRecord"TPP_START_UP"TppSave.VarSavePersonalData()
  TppMission.RequestLoad(vars.missionCode,o,{showLoadingTips=false})
  local actMode=Fox.GetActMode()
  if(actMode=="EDIT")then
    Fox.SetActMode"GAME"
  end
  InfCore.PCallDebug(InfMain.OnStartTitle)--tex
end
function this.SetVarsTitle()
  TppMission.VarResetOnNewMission()
  local titleMission=TppDefine.SYS_MISSION_ID.TITLE
  local initLocation=TppDefine.LOCATION_ID.INIT
  gvars.title_nextMissionCode=vars.missionCode
  gvars.title_nextLocationCode=vars.locationCode
  vars.missionCode=titleMission
  vars.locationCode=initLocation
  TppPlayer.ResetInitialPosition()
  TppPlayer.ResetMissionStartPosition()
end
function this.InitializeOnStartTitle()
  this.InitializeOnStatingMainFrame()
  this.InitializeOnNewGameAtFirstTime()
  this.InitializeOnNewGame()
end
function this.InitializeOnTitle()
  BaseDefenseManager.Reset()
end
function this.ClearAllVarsAndSlot()
  vars.locationCode=TppDefine.LOCATION_ID.INIT
  vars.missionCode=TppDefine.SYS_MISSION_ID.INIT
  TppScriptVars.InitForNewGame()
  TppGVars.AllInitialize()
  TppSave.VarSave(TppDefine.SYS_MISSION_ID.INIT,true)
  TppSave.VarSaveConfig()
  TppSave.VarSavePersonalData()
  local saveInfo=TppSave.GetSaveGameDataQueue(vars.missionCode)
  for k,v in ipairs(saveInfo.slot)do
    TppScriptVars.CopySlot({saveInfo.savingSlot,v},v)
  end
end
function this.InitializeOnStatingMainFrame()
  local oneK=1024
  local oneM=1024*1024
  local saveSlotSizes={
    [TppDefine.SAVE_SLOT.GLOBAL+1]=100,
    [TppDefine.SAVE_SLOT.CHECK_POINT+1]=100,
    [TppDefine.SAVE_SLOT.RETRY+1]=100,
    [TppDefine.SAVE_SLOT.MB_MANAGEMENT+1]=100,
    [TppDefine.SAVE_SLOT.QUEST+1]=100,
    [TppDefine.SAVE_SLOT.MISSION_START+1]=100,
    [TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE+1]=100
  }
  local compositeSlotSize={}
  local slotsTotalSize=0
  for slotIndex,size in ipairs(saveSlotSizes)do
    slotsTotalSize=slotsTotalSize+size
    compositeSlotSize[slotIndex]=size
  end
  saveSlotSizes[TppDefine.SAVE_SLOT.SAVING+1]=slotsTotalSize+92
  local configSize=1*oneK
  local platform=TppGameSequence.GetTargetPlatform()
  if((platform=="Steam"or platform=="Win32")or platform=="Win64")then
    configSize=2*oneK
  end
  saveSlotSizes[TppDefine.SAVE_SLOT.CONFIG+1]=configSize
  saveSlotSizes[TppDefine.SAVE_SLOT.CONFIG_SAVE+1]=saveSlotSizes[TppDefine.SAVE_SLOT.CONFIG+1]
  local personalSize=3*oneK
  if Tpp.IsQARelease()then
    personalSize=4*oneK
  end
  if TppScriptVars.ENABLE_STORED_PARAMETER~=0 then
    personalSize=personalSize+(4*oneM)
  end
  saveSlotSizes[TppDefine.SAVE_SLOT.PERSONAL+1]=personalSize
  saveSlotSizes[TppDefine.SAVE_SLOT.PERSONAL_SAVE+1]=personalSize
  Tpp.DEBUG_DumpTable(compositeSlotSize)
  Tpp.DEBUG_DumpTable(saveSlotSizes)
  TppScriptVars.CreateSaveSlot(saveSlotSizes)
  TppSave.RegistCompositSlotSize(compositeSlotSize)
  TppSave.SetUpCompositSlot()
  TppScriptVars.SetFileSizeList{
    {TppSave.GetGameSaveFileName(),saveSlotSizes[TppDefine.SAVE_SLOT.SAVING+1]},
    {TppDefine.CONFIG_SAVE_FILE_NAME,saveSlotSizes[TppDefine.SAVE_SLOT.CONFIG+1]},
    {TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,saveSlotSizes[TppDefine.SAVE_SLOT.PERSONAL+1]},
    {TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,saveSlotSizes[TppDefine.SAVE_SLOT.PERSONAL+1]}
  }
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
  local skipInitialEquipment=false
  if not skipInitialEquipment then
    SsdSbm.SetupInitialEquipment{body="PRD_ACC_Body_36",arm="PRD_ACC_Arm_16",leg="PRD_ACC_Foot_15"}
    SsdSbm.StoreToSVars()
  end
  SsdBuilding.SetLevel{level=0}
  SsdBuilding.RemoveAll()
  SsdCrewSystem.RemoveAll()
  SsdBaseManagement.InitializeResource()
  MissionObjectiveInfoSystem.Clear()
  if TppScriptVars.InitForTitleNewGame then
    TppScriptVars.InitForTitleNewGame()
  end
  SsdMarker.ClearMarker()
  BaseDefenseManager.Reset()
end
function this.InitializeForNewMission(missionTable)
  TppSave.VarRestoreOnMissionStart()
  if(Tpp.IsQARelease()or nil)then
    TppDebug.DEBUG_RestoreSVars()
  end
  TppStory.DisableMissionNewOpenFlag(vars.missionCode)
  if missionTable.sequence and missionTable.sequence.MISSION_START_INITIAL_WEATHER then
    TppWeather.SetMissionStartWeather(missionTable.sequence.MISSION_START_INITIAL_WEATHER)
  end
  TppWeather.RestoreMissionStartWeather()
  TppPlayer.SetInitialPlayerState(missionTable)
  TppPlayer.ResetDisableAction()
  TppEnemy.RestoreOnMissionStart()
  Player.ResetVarsOnMissionStart()
  TppUI.OnMissionStart()
  local setMissionOrderBoxPosition=TppMission.SetMissionOrderBoxPosition()
  if not setMissionOrderBoxPosition then
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
  SsdCrewSystem.Restore()
  SsdBaseManagement.Restore()
  MissionObjectiveInfoSystem.Clear()
  RecordRanking.WriteServerRankingScore()
end
function this.RestoreBuildingData()
  if Tpp.IsEditorNoLogin()then
    if(SsdBuilding.GetLevel()==0)then
      this.InitializeBuildingData()
    end
    return
  end
  SsdBuilding.Restore{}
  local currentStorySequence=TppStory.GetCurrentStorySequence()
  if(currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST)then
    this.RegisterBuildingOnFOB()
  end
  SsdBaseManagement.CheckResourceCounter{}
end
function this.InitializeBuildingData(checkBuildingLevel)
  local currentStorySequence=TppStory.GetCurrentStorySequence()
  if(currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST)then
    this.RegisterBuildingOnFOB()
  end
  if not TppLocation.IsAfghan()then
    return
  end
  if not checkBuildingLevel then
    local buildingLevel=SsdBuilding.GetLevel()
    if buildingLevel>0 then
      return
    end
  end
  if not Editor and TppServerManager.IsLoginKonami()then
    return
  end
  SsdBuilding.SetLevel{level=1}
  local PRD_BLD_Rubble_A=Fox.StrCode32"PRD_BLD_Rubble_A"
  local PRD_BLD_Rubble_B=Fox.StrCode32"PRD_BLD_Rubble_B"
  local PRD_BLD_Rubble_C=Fox.StrCode32"PRD_BLD_Rubble_C"
  local PRD_BLD_Rubble_D=Fox.StrCode32"PRD_BLD_Rubble_D"
  local PRD_BLD_Rubble_E=Fox.StrCode32"PRD_BLD_Rubble_E"
  local PRD_BLD_Rubble_F=Fox.StrCode32"PRD_BLD_Rubble_F"
  local PRD_BLD_Rubble_G=Fox.StrCode32"PRD_BLD_Rubble_G"
  local PRD_BLD_Rubble_H=Fox.StrCode32"PRD_BLD_Rubble_H"
  local PRD_BLD_Rubble_I=Fox.StrCode32"PRD_BLD_Rubble_I"
  local PRD_BLD_Rubble_J=Fox.StrCode32"PRD_BLD_Rubble_J"
  local PRD_BLD_Rubble_K=Fox.StrCode32"PRD_BLD_Rubble_K"
  SsdBuilding.CreateItemNoAreaCheck{row=19,col=27,buildingId=PRD_BLD_Rubble_A,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=21,col=23,buildingId=PRD_BLD_Rubble_B,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=21,col=10,buildingId=PRD_BLD_Rubble_B,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=12,col=10,buildingId=PRD_BLD_Rubble_B,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=10,col=29,buildingId=PRD_BLD_Rubble_B,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=25,col=29,buildingId=PRD_BLD_Rubble_D,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=28,col=4,buildingId=PRD_BLD_Rubble_D,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=4,col=22,buildingId=PRD_BLD_Rubble_D,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=13,col=22,buildingId=PRD_BLD_Rubble_E,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=13,col=7,buildingId=PRD_BLD_Rubble_E,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=19,col=7,buildingId=PRD_BLD_Rubble_E,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=10,col=19,buildingId=PRD_BLD_Rubble_E,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=25,col=13,buildingId=PRD_BLD_Rubble_E,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=23,col=19,buildingId=PRD_BLD_Rubble_E,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=10,col=19,buildingId=PRD_BLD_Rubble_E,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=9,buildingId=PRD_BLD_Rubble_F,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=16,buildingId=PRD_BLD_Rubble_F,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=26,buildingId=PRD_BLD_Rubble_F,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=16,col=5,buildingId=PRD_BLD_Rubble_F,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=5,buildingId=PRD_BLD_Rubble_F,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=5,col=13,buildingId=PRD_BLD_Rubble_G,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=17,col=12,buildingId=PRD_BLD_Rubble_G,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=22,col=27,buildingId=PRD_BLD_Rubble_G,rotType=270}
  SsdBuilding.CreateItemNoAreaCheck{row=13,col=26,buildingId=PRD_BLD_Rubble_G,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=17,col=24,buildingId=PRD_BLD_Rubble_G,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=11,buildingId=PRD_BLD_Rubble_G,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=7,col=17,buildingId=PRD_BLD_Rubble_G,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=9,buildingId=PRD_BLD_Rubble_H,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=19,col=20,buildingId=PRD_BLD_Rubble_H,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=15,col=30,buildingId=PRD_BLD_Rubble_H,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=7,col=3,buildingId=PRD_BLD_Rubble_I,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=3,col=28,buildingId=PRD_BLD_Rubble_I,rotType=90}
  SsdBuilding.CreateItemNoAreaCheck{row=17,col=10,buildingId=PRD_BLD_Rubble_I,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=26,col=26,buildingId=PRD_BLD_Rubble_K,rotType=180}
  SsdBuilding.CreateItemNoAreaCheck{row=24,col=24,buildingId=PRD_BLD_Rubble_K,rotType=0}
  SsdBuilding.CreateItemNoAreaCheck{row=8,col=24,buildingId=PRD_BLD_Rubble_K,rotType=0}
  local PRD_BLD_Kitchen_A=Fox.StrCode32"PRD_BLD_Kitchen_A"
  SsdBuilding.CreateItem{row=19,col=13,buildingId=PRD_BLD_Kitchen_A,rotType=180}
  local PRD_BLD_WeaponPlant_A=Fox.StrCode32"PRD_BLD_WeaponPlant_A"
  SsdBuilding.CreateItem{row=19,col=12,buildingId=PRD_BLD_WeaponPlant_A,rotType=90}
  local PRD_BLD_AccessoryPlant_A=Fox.StrCode32"PRD_BLD_AccessoryPlant_A"
  SsdBuilding.CreateItem{row=18,col=12,buildingId=PRD_BLD_AccessoryPlant_A,rotType=90}
  local PRD_BLD_GadgetPlant_A=Fox.StrCode32"PRD_BLD_GadgetPlant_A"
  SsdBuilding.CreateItem{row=17,col=12,buildingId=PRD_BLD_GadgetPlant_A,rotType=90}
  local function PlaceBuildings(buildingId,e)
    for i,gridCoords in ipairs(e)do
      local row,col,rotType,edgeType=gridCoords[1],gridCoords[2],gridCoords[3],gridCoords[4]
      SsdBuilding.CreateItem{row=row,col=col,buildingId=buildingId,rotType=rotType,edgeType=edgeType}
    end
  end
  local PRD_DEF_Barricade_A=Fox.StrCode32"PRD_DEF_Barricade_A"
  local baracadeCoords={
    {12,18,0,0},
    {12,17,0,0},
    {12,15,0,0},
    {12,14,0,0},
    {12,20,0,1},
    {13,20,0,1},
    {15,20,0,1},
    {17,21,0,1},
    {20,17,0,0},
    {20,16,0,0},
    {20,14,0,0},
    {20,13,0,0}
  }
  PlaceBuildings(PRD_DEF_Barricade_A,baracadeCoords)
  local PRD_DEF_Barricade_A=Fox.StrCode32"PRD_DEF_Barricade_A"
  local baracadeCoords2={
    {23,17,0,0},
    {23,16,0,0},
    {23,14,0,0},
    {23,13,0,0},
    {9,19,0,0},
    {9,18,0,0},
    {9,16,0,0},
    {9,15,0,0},
    {11,13,0,0},
    {11,14,0,0},
    {11,16,0,0},
    {11,17,0,0},
    {21,19,0,0},
    {21,18,0,0},
    {21,16,0,0},
    {21,15,0,0}
  }
  PlaceBuildings(PRD_DEF_Barricade_A,baracadeCoords2)
  SsdBuilding.Save()
  SsdBuilding.SetNewGame()
end
function this.RegisterBuildingOnFOB()
  local fobBuildingList=this.FobBuildingList
  if TppLocation.IsMiddleAfrica()then
    for i,buildingInfo in pairs(fobBuildingList)do
      local gameId=Gimmick.SsdGetGameObjectId{gimmickId=buildingInfo.gimmickId,name=buildingInfo.name,dataSetName=buildingInfo.dataSetName}
      SsdBuilding.RegisterAfricaItem{gameObjectId=gameId}
    end
  else
    for i,buildingInfo in pairs(fobBuildingList)do
      local productionId=buildingInfo.productionId
      SsdBuilding.RegisterAfricaItem{buildingId=Fox.StrCode32(productionId)}
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
  this.RestoreBuildingData()
  SsdCrewSystem.Restore()
  SsdBaseManagement.Restore()
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
  local currentStorySequence=TppStory.GetCurrentStorySequence()
  local buildingLevel=SsdBuilding.GetLevel()
  if vars.ssdBuildingLevel<buildingLevel then
    buildingLevel=vars.ssdBuildingLevel
  end

  if SsdBaseDefense.IsCleared"d53010"and buildingLevel<3 then--RETAILPATCH: 1.0.5.0
    SsdBuilding.SetLevel{level=3}--<
  elseif TppDefine.STORY_SEQUENCE.BEFORE_k40150<currentStorySequence and buildingLevel<2 then
    SsdBuilding.SetLevel{level=2}
  elseif buildingLevel==0 then
    SsdBuilding.SetLevel{level=1}
  end
end
function this.SetTutorialPlayerHungerAndThirst()
  Player.SetHungerAndThirstForTutorial()
end
this.FobBuildingList={
  {gimmickId="GIM_P_PurificationTank",name="ssde_tank002_vrtn001_gim_n0000|srt_ssde_tank002_vrtn001",dataSetName="/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",productionId="PRD_BLD_DirtyWaterTank_B"},
  {gimmickId="GIM_P_WaterTank",name="ssde_tank001_gim_n0000|srt_ssde_tank001",dataSetName="/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",productionId="PRD_BLD_WaterTank_A"},
  {gimmickId="GIM_P_FoodBox",name="com_food_box001_gim_n0000|srt_food_box001",dataSetName="/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",productionId="PRD_BLD_FoodStorage_A"},
  {gimmickId="GIM_P_MedicalBox",name="ssde_mdcn002_gim_n0000|srt_ssde_mdcn002",dataSetName="/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",productionId="PRD_BLD_MedicalStorage_A"},
  {gimmickId="GIM_P_Warehouse",name="ssde_boxx001_gim_n0000|srt_ssde_boxx001",dataSetName="/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",productionId="PRD_BLD_Warehouse_A"},
  {gimmickId="GIM_P_Bed",name="ssde_bedd001_vrtn001_gim_n0000|srt_ssde_bedd001_vrtn001",dataSetName="/Assets/tpp/level/location/mafr/block_large/factory/mafr_factory_gimmick.fox2",productionId="PRD_BLD_Shelter_B"}
}
return this
