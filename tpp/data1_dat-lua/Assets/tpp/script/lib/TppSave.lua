local e={}
local i=TppScriptVars.IsSavingOrLoading
e.saveQueueDepth=0
e.saveQueueList={}
local function a(a)
  if gvars.sav_isReservedMbSaveResultNotify then
    gvars.sav_isReservedMbSaveResultNotify=false
    if a then
      TppMotherBaseManagement.SetRequestSaveResultSuccess()
    else
      TppMotherBaseManagement.SetRequestSaveResultFailure()
    end
  end
end
e.SAVE_RESULT_FUNCTION={
  [Fox.StrCode32(TppDefine.CONFIG_SAVE_FILE_NAME)]=function(e)
  end,[Fox.StrCode32(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)]=function(e)
    if e==false then
      return
    end
    if(vars.isPersonalDirty==1)then
      vars.isPersonalDirty=0
    end
  end,
  [Fox.StrCode32(TppDefine.GAME_SAVE_FILE_NAME)]=a,
  [Fox.StrCode32(TppDefine.GAME_SAVE_FILE_NAME_TMP)]=a
}
function e.GetSaveFileVersion(e)
  return(TppDefine.SAVE_FILE_INFO[e].version+TppDefine.PROGRAM_SAVE_FILE_VERSION[e]*TppDefine.PROGRAM_SAVE_FILE_VERSION_OFFSET)
end
function e.IsExistConfigSaveFile()
  return TppScriptVars.FileExists(TppDefine.CONFIG_SAVE_FILE_NAME)
end
function e.IsExistPersonalSaveFile()
  return TppScriptVars.FileExists(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)
end
function e.ForbidSave()
  gvars.permitGameSave=false
end
function e.NeedWaitSavingErrorCheck()
  if gvars.sav_SaveResultCheckFileName==0 then
    return false
  else
    return true
  end
end
function e.IsSaving(a)
  if TppScriptVars.IsSavingOrLoading()then
    return true
  end
  if e.IsEnqueuedSaveData()then
    return true
  end
  if(gvars.sav_SaveResultCheckFileName~=0)then
    return true
  end
  return false
end
function e.IsSavingWithFileName(e)
  if gvars.sav_SaveResultCheckFileName==Fox.StrCode32(e)then
    return true
  else
    return false
  end
end
function e.HasQueue(a)
  for n=1,e.saveQueueDepth do
    if e.saveQueueList[n].fileName==a then
      return true
    end
  end
  return false
end
function e.IsEnqueuedSaveData()
  if e.saveQueueDepth>0 then
    return true
  else
    return false
  end
end
local T=e.IsEnqueuedSaveData
function e.RegistCompositSlotSize(a)
  e.COMPOSIT_SLOT_SIZE=a
end
function e.SetUpCompositSlot()
  if e.COMPOSIT_SLOT_SIZE then
    TppScriptVars.SetUpSlotAsCompositSlot(TppDefine.SAVE_SLOT.SAVING,e.COMPOSIT_SLOT_SIZE)
  end
end
function e.SaveGameData(t,n,S,a)
  if a then
    e.ReserveNextMissionStartSave(e.GetGameSaveFileName())
  else
    local a=e.GetSaveGameDataQueue(t,n,S)
    e.EnqueueSave(a)
  end
  e.CheckAndSavePersonalData(a)
end
function e.GetSaveGameDataQueue(n,a,S)
  local t=e.GetGameSaveFileName()
  local a=e.GetIntializedCompositSlotSaveQueue(t,a,S)
  a=e._SaveGlobalData(a)
  a=e._SaveMissionData(a)
  a=e._SaveMissionRestartableData(a)
  a=e._SaveRetryData(a)
  a=e._SaveMbManagementData(a,n)
  a=e._SaveQuestData(a)
  return a
end
function e.SaveConfigData(a,S,n)
  if S then
    local a=e.MakeNewSaveQueue(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,a)
    return e.DoSave(a,true)
  elseif n then
    e.ReserveNextMissionStartSave(TppDefine.CONFIG_SAVE_FILE_NAME)
  else
    e.EnqueueSave(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,a)
  end
end
function e.SaveMGOData()
e.EnqueueSave(TppDefine.SAVE_SLOT.MGO,TppDefine.SAVE_SLOT.MGO_SAVE,TppScriptVars.CATEGORY_MGO,TppDefine.MGO_SAVE_FILE_NAME)
end
function e.SavePersonalData(a,n,S)
  if n then
    local a=e.MakeNewSaveQueue(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.SAVE_SLOT.PERSONAL_SAVE,TppScriptVars.CATEGORY_PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,a)
    return e.DoSave(a,true)
  elseif S then
    e.ReserveNextMissionStartSave(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)
  else
    e.EnqueueSave(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.SAVE_SLOT.PERSONAL_SAVE,TppScriptVars.CATEGORY_PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,a)
  end
end
function e.CheckAndSavePersonalData(n)
  local a=TppDefine.PERSONAL_DATA_SAVE_FILE_NAME
  if e.IsSavingWithFileName(a)or e.HasQueue(a)then
    return
  end
  if(vars.isPersonalDirty==1)then
    e.VarSavePersonalData()
    e.SavePersonalData(nil,nil,n)
  end
end
function e.SaveAvatarData()
  Player.SetEnableUpdateAvatarInfo(true)
  e.VarSavePersonalData()
  e.SavePersonalData()
end
function e.SaveOnlyMbManagement(n)
  local a=vars.missionCode
  e.VarSaveMbMangement(a)
  e.SaveGameData(a,nil,n)
end
function e.ReserveNoticeOfMbSaveResult()
  gvars.sav_isReservedMbSaveResultNotify=true
end
function e.SaveOnlyGlobalData()
  e.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
  e.SaveGameData(vars.missionCode)
end
function e.SaveGzPrivilege()
  e.SaveMBAndGlobal()
end
function e.SaveMBAndGlobal()
  e.VarSaveMBAndGlobal()
  e.SaveGameData(currentMissionCode)
end
function e.VarSaveMBAndGlobal()
  local a=vars.missionCode
  e.VarSaveMbMangement(a)
  e.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
e.DO_RESERVE_SAVE_FUNCTION={
  [TppDefine.CONFIG_SAVE_FILE_NAME]=e.SaveConfigData,
  [TppDefine.PERSONAL_DATA_SAVE_FILE_NAME]=e.SavePersonalData,
  [TppDefine.GAME_SAVE_FILE_NAME]=e.SaveGameData,
  [TppDefine.GAME_SAVE_FILE_NAME_TMP]=e.SaveGameData
}
function e.ReserveNextMissionStartSave(a)
  if not e.DO_RESERVE_SAVE_FUNCTION[a]then
    return
  end
  e.missionStartSaveFilePool=e.missionStartSaveFilePool or{}
  e.missionStartSaveFilePool[a]=true
end
function e.DoReservedSaveOnMissionStart()
  if not e.missionStartSaveFilePool then
    return
  end
  local a=Fox.GetPlatformName()
  if a=="Xbox360"or a=="XboxOne"then
    if not SignIn.IsSignedIn()then
      e.missionStartSaveFilePool=nil
      return
    end
  end
  for a,n in pairs(e.missionStartSaveFilePool)do
    local e=e.DO_RESERVE_SAVE_FUNCTION[a]
    e()
  end
  e.missionStartSaveFilePool=nil
end
function e._SaveGlobalData(a)
  if TppScriptVars.StoreUtcTimeToScriptVars then
    TppScriptVars.StoreUtcTimeToScriptVars()
  end
  return e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.GLOBAL,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
function e._SaveMissionData(a)
  return e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.CHECK_POINT,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_MISSION)
end
function e._SaveRetryData(a)
  return e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.RETRY,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_RETRY)
end
function e.CanSaveMbMangementData(e)
  local e=e or vars.missionCode
  if(vars.fobSneakMode==FobMode.MODE_SHAM)then
    return false
  end
  return(e~=10030)or(not gvars.isMissionClearedS10030)
end
function e._SaveMbManagementData(a,n)
  return e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_MB_MANAGEMENT)
end
function e._SaveQuestData(a)
  return e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.QUEST,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_QUEST)
end
function e._SaveMissionRestartableData(a)
  a=e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.MISSION_START,TppDefine.SAVE_SLOT.SAVING,TppDefine.CATEGORY_MISSION_RESTARTABLE)
  a=e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppDefine.SAVE_SLOT.SAVING,TppDefine.CATEGORY_MISSION_RESTARTABLE)
  return a
end
function e.MakeNewGameSaveData(S)
  TppVarInit.InitializeOnNewGameAtFirstTime()
  TppVarInit.InitializeOnNewGame()
  if S then
    TppTerminal.AcquirePrivilegeInTitleScreen()
  end
  e.VarSave(vars.missionCode,true)
  e.VarSaveOnRetry()
  local a,n=e.GetSaveGameDataQueue(vars.missionCode)
  if gvars.permitGameSave then
    a=e.GetSaveGameDataQueue(vars.missionCode)
    n=e.DoSave(a,true)
  end
  if S then
    e.CheckAndSavePersonalData()
  end
  return n
end
function e.GetIntializedCompositSlotSaveQueue(e,n,a)
  return{fileName=e,needIcon=n,doSaveFunc=a}
end
function e.AddSlotToSaveQueue(e,S,a,n)
  if S==nil then
    return
  end
  if a==nil then
    return
  end
  if n==nil then
    return
  end
  local e=e or{}
  e.savingSlot=a
  e.slot=e.slot or{}
  e.category=e.category or{}
  local a=#e.slot+1
  e.slot[a]=S
  e.category[a]=n
  return e
end
function e.EnqueueSave(a,S,t,i,p)
  if a==nil then
    return
  end
  local n
  if Tpp.IsTypeTable(a)then
    n=a
  else
    if S==nil then
      return
    end
    if t==nil then
      return
    end
  end
  if gvars.permitGameSave==false then
    return
  end
  e.saveQueueDepth=e.saveQueueDepth+1
  if n then
    e.saveQueueList[e.saveQueueDepth]=n
  else
    e.saveQueueList[e.saveQueueDepth]=e.MakeNewSaveQueue(a,S,t,i,p)
  end
end
function e.MakeNewSaveQueue(a,n,S,t,p,i)
  local e={}
  e.slot=a
  e.savingSlot=n
  e.category=S
  e.fileName=t
  e.needIcon=p
  e.doSaveFunc=i
  return e
end
function e.DequeueSave()
  for a=1,(e.saveQueueDepth-1)do
    e.saveQueueList[a]=e.saveQueueList[a+1]
    end
  e.saveQueueList[e.saveQueueDepth]=nil
  e.saveQueueDepth=e.saveQueueDepth-1
end
function e.ProcessSaveQueue()
  if not T()then
    return false
  end
  local a=e.saveQueueList[1]
  if a then
    local a=e.DoSave(a)
    if a~=nil then
      e.DequeueSave()
      if a==TppScriptVars.WRITE_FAILED then
        if(gvars.sav_SaveResultCheckFileName~=0)then
          local e=e.SAVE_RESULT_FUNCTION[gvars.sav_SaveResultCheckFileName]
          if e then
            e(false)
          end
          gvars.sav_SaveResultCheckFileName=0
        end
        TppException.ShowSaveErrorPopUp(TppDefine.ERROR_ID.SAVE_FAILED_UNKNOWN_REASON)
      end
    end
  end
end
function e.DoSave(a,n)
  local r=true
  if n then
    r=false
  end
  local n
  local p
  local S
  local i
  local t
  if Tpp.IsTypeTable(a.slot)then
    e.SetUpCompositSlot()
    S=a.fileName
    i=a.needIcon
    t=a.doSaveFunc
    for t,S in ipairs(a.slot)do
      n=a.category[t]
      p=e.GetSaveFileVersion(n)
      TppScriptVars.CopySlot({a.savingSlot,S},S)
    end
  else
    n=a.category
    if n then
      p=e.GetSaveFileVersion(n)
      S=a.fileName
      i=a.needIcon
      t=a.doSaveFunc
      TppScriptVars.CopySlot(a.savingSlot,a.slot)
    else
      return false
    end
  end
  if t then
    t()
  end
  local e=TppScriptVars.WriteSlotToFile(a.savingSlot,S,i)
  if r then
    gvars.sav_SaveResultCheckFileName=Fox.StrCode32(S)
  end
  return e
end
function e.Update()
  if(not i())then
    if(gvars.sav_SaveResultCheckFileName~=0)then
      local n=true
      local a=TppScriptVars.GetLastResult()
      local a,S=e.GetSaveResultErrorMessage(a)
      if a then
        n=false
        TppUiCommand.ShowErrorPopup(a,S)
      end
      local e=e.SAVE_RESULT_FUNCTION[gvars.sav_SaveResultCheckFileName]
      if e then
        e(n)
      end
      gvars.sav_SaveResultCheckFileName=0
    end
    if e.IsEnqueuedSaveData()then
      e.ProcessSaveQueue()
    end
  end
  if i()then
    local e=TppScriptVars.GetSaveState()
    if e==TppScriptVars.STATE_SAVING then
      TppUI.ShowSavingIcon()
    end
    if e==TppScriptVars.STATE_LOADING then
      TppUI.ShowLoadingIcon()
    end
    if e==TppScriptVars.STATE_PROCESSING then
      TppUI.ShowLoadingIcon()
    end
  end
end
e.SaveErrorMessageIdTable={[TppScriptVars.RESULT_ERROR_INVALID_STORAGE]={TppDefine.ERROR_ID.CANNOT_FIND_STORAGE_IN_GAME,Popup.TYPE_ONE_BUTTON}}
function e.GetSaveResultErrorMessage(a)
  if a==TppScriptVars.RESULT_OK then
    return
  end
  local e=e.SaveErrorMessageIdTable[a]
  if e then
    return e[1],e[2]else
    return TppDefine.ERROR_ID.SAVE_FAILED_UNKNOWN_REASON
  end
end
function e.Init(a)
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnReload(a)
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.Messages()
  return Tpp.StrCode32Table{UI={{msg="PopupClose",sender=TppDefine.ERROR_ID.CANNOT_FIND_STORAGE_IN_GAME,func=function()
  e.ForbidSave()
    end}}
  }
end
function e.OnMessage(r,p,t,S,i,n,a)
  Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,r,p,t,S,i,n,a)
end
function e.WaitingAllEnqueuedSaveOnStartMission()
  while i()do
    e.CoroutineYieldWithShowSavingIcon()
  end
  while T()do
    e.ProcessSaveQueue()
    while i()do
      e.CoroutineYieldWithShowSavingIcon()
    end
  end
end
function e.CoroutineYieldWithShowSavingIcon()
  TppUI.ShowSavingIcon()
  coroutine.yield()
end
function e.SaveVarsToSlot(S,n,a)
  local e=e.GetSaveFileVersion(a)
  TppScriptVars.SaveVarsToSlot(S,n,a,e)
end
function e.VarSaveOnlyGlobalData()
e.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
function e.VarSave(n,a)
e.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
  if gvars.usingNormalMissionSlot then
    e.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MISSION)
    if a then
      e.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
      e.SaveVarsToSlot(TppDefine.SAVE_SLOT.MISSION_START,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
    else
      e.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
    end
  end
  if e.CanSaveMbMangementData(n)then
    e.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  end
  e.SaveVarsToSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)
  e.SaveVarsToSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)
end
function e.VarSaveOnRetry()
e.SaveVarsToSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)
end
function e.VarSaveMbMangement(n,a)
  if e.CanSaveMbMangementData(n)or a then
    e.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  end
end
function e.VarSaveQuest(a)
  if e.CanSaveMbMangementData(a)then
    e.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  end
  e.SaveVarsToSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)
end
function e.VarSaveConfig()
e.SaveVarsToSlot(TppDefine.SAVE_SLOT.CONFIG,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_CONFIG)
end
function e.VarSaveMGO()
e.SaveVarsToSlot(TppDefine.SAVE_SLOT.MGO,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MGO)
end
function e.VarSavePersonalData()
e.SaveVarsToSlot(TppDefine.SAVE_SLOT.PERSONAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_PERSONAL)
end
function e.LoadFromSaveFile(a,e)
  return TppScriptVars.ReadSlotFromFile(a,e)
end
function e.GetGameSaveFileName()do
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    return TppDefine.MGO_MAIN_SAVE_FILE_NAME
  else
    return TppDefine.GAME_SAVE_FILE_NAME
  end
end
end
function e.DEBUG_IsUsingTemporarySaveData()do
  return false
end
return gvars.DEBUG_usingTemporarySaveData
end
function e.LoadGameDataFromSaveFile()
  local a=e.GetGameSaveFileName()
  return e.LoadFromSaveFile(TppDefine.SAVE_SLOT.SAVING,a)
end
local n={TppScriptVars.CATEGORY_GAME_GLOBAL,TppScriptVars.CATEGORY_MISSION,TppScriptVars.CATEGORY_RETRY,TppScriptVars.CATEGORY_MB_MANAGEMENT,TppScriptVars.CATEGORY_QUEST,TppDefine.CATEGORY_MISSION_RESTARTABLE}
function e.CheckGameDataVersion()
  for n,a in ipairs(n)do
    local n=TppDefine.SAVE_FILE_INFO[a].slot
    local n=e.CheckSlotVersion(a,TppDefine.SAVE_SLOT.SAVING)
    if n~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
      return n
    end
    if TppDefine.SAVE_FILE_INFO[a].missionStartSlot then
      local e=e.CheckSlotVersion(a,TppDefine.SAVE_SLOT.SAVING,true)
      if e~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
        return e
      end
    end
  end
  return TppDefine.SAVE_FILE_LOAD_RESULT.OK
end
function e.CopyGameDataFromSavingSlot()
  for a,e in ipairs(n)do
    local a=TppDefine.SAVE_FILE_INFO[e].slot
    TppScriptVars.CopySlot(a,{TppDefine.SAVE_SLOT.SAVING,a})
    local e=TppDefine.SAVE_FILE_INFO[e].missionStartSlot
    if e then
      TppScriptVars.CopySlot(e,{TppDefine.SAVE_SLOT.SAVING,e})
    end
  end
end
function e.LoadMGODataFromSaveFile()
  return e.LoadFromSaveFile(TppDefine.SAVE_SLOT.MGO,TppDefine.MGO_SAVE_FILE_NAME)
end
function e.LoadConfigDataFromSaveFile()
  return e.LoadFromSaveFile(TppDefine.SAVE_SLOT.CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME)
end
function e.LoadPersonalDataFromSaveFile()
  return e.LoadFromSaveFile(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)
end
function e.CheckSlotVersion(a,n,t)
  local S=e.GetSaveFileVersion(a)
  local e=TppDefine.SAVE_FILE_INFO[a].slot
  if t then
    e=TppDefine.SAVE_FILE_INFO[a].missionStartSlot
  end
  if n then
    e={n,e}
  end
  local e=TppScriptVars.GetScriptVersionFromSlot(e)
  if e==nil then
    return TppDefine.SAVE_FILE_LOAD_RESULT.ERROR_LOAD_FAILED
  end
  if e<=S then
    return TppDefine.SAVE_FILE_LOAD_RESULT.OK
  else
    return TppDefine.SAVE_FILE_LOAD_RESULT.DIFFER_FROM_CURRENT_VERSION
  end
end
function e.CheckSlotVersionConfigData()
  return e.CheckSlotVersion(TppScriptVars.CATEGORY_CONFIG)
end
function e.IsReserveVarRestoreForContinue()
  return gvars.sav_varRestoreForContinue
end
function e.ReserveVarRestoreForContinue()
gvars.sav_varRestoreForContinue=true
end
function e.ReserveVarRestoreForMissionStart()
gvars.sav_varRestoreForContinue=false
end
function e.VarRestoreOnMissionStart()
  if not TppMission.IsFOBMission(vars.missionCode)then
    TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.GLOBAL,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_GAME_GLOBAL)
    if gvars.usingNormalMissionSlot then
      TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_MISSION)
      if TppSystemUtility.GetCurrentGameMode()~="MGO"then
        TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MISSION_START,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppDefine.CATEGORY_MISSION_RESTARTABLE)
      end
      TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.RETRY,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_RETRY)
    end
    TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_MB_MANAGEMENT)
    TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.QUEST,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_QUEST)
  end
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CONFIG,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_CONFIG)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.PERSONAL,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_PERSONAL)
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MGO,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_MGO)
  end
  gvars.sav_varRestoreForContinue=false
end
function e.VarRestoreOnContinueFromCheckPoint()
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
  if gvars.usingNormalMissionSlot then
    TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MISSION)
    if TppSystemUtility.GetCurrentGameMode()~="MGO"then
      TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppDefine.CATEGORY_MISSION_RESTARTABLE)
    end
    TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)
  end
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CONFIG,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_CONFIG)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.PERSONAL,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_PERSONAL)
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MGO,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MGO)
  end
end
function e.DeleteGameSaveFile()
  TppScriptVars.DeleteFile(TppDefine.GAME_SAVE_FILE_NAME)
end
function e.DeleteTemporaryGameSaveFile()
  TppScriptVars.DeleteFile(TppDefine.GAME_SAVE_FILE_NAME_TMP)
end
function e.DeleteConfigSaveFile()
  TppScriptVars.DeleteFile(TppDefine.CONFIG_SAVE_FILE_NAME)
end
function e.DeletePersonalDataSaveFile()
  TppScriptVars.DeleteFile(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)
end
function e.DeleteMGOSaveFile()
  TppScriptVars.DeleteFile(TppDefine.MGO_SAVE_FILE_NAME)
end
function e.IsNewGame()
  return gvars.isNewGame
end
function e.IsGameDataLoadResultOK()
  if(gvars.gameDataLoadingResult==TppDefine.SAVE_FILE_LOAD_RESULT.OK)or(gvars.gameDataLoadingResult==TppDefine.SAVE_FILE_LOAD_RESULT.OK_LOAD_BACKUP)then
    return true
  else
    return false
  end
end
e.SAVE_FILE_OK_RESULT_TABLE={[TppScriptVars.RESULT_OK]=TppDefine.SAVE_FILE_LOAD_RESULT.OK,[TppScriptVars.RESULT_ERROR_LOAD_BACKUP]=TppDefine.SAVE_FILE_LOAD_RESULT.OK_LOAD_BACKUP}
function e.CheckGameSaveDataLoadResult()
  local n=TppScriptVars.GetLastResult()
  local a=e.SAVE_FILE_OK_RESULT_TABLE[n]
  if a then
    local e=e.CheckGameDataVersion()
    if e~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
      gvars.gameDataLoadingResult=e
    else
      gvars.gameDataLoadingResult=a
    end
  else
    if n==TppScriptVars.RESULT_ERROR_NOSPACE then
      gvars.gameDataLoadingResult=TppDefine.SAVE_FILE_LOAD_RESULT.DIFFER_FROM_CURRENT_VERSION
    else
      gvars.gameDataLoadingResult=TppDefine.SAVE_FILE_LOAD_RESULT.ERROR_LOAD_FAILED
    end
  end
end
function e.GetGameDataLoadingResult()
  return gvars.gameDataLoadingResult
end
return e
