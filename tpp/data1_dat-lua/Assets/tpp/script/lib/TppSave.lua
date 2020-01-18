local this={}
local i=TppScriptVars.IsSavingOrLoading
this.saveQueueDepth=0
this.saveQueueList={}
local function n(n)
  if gvars.sav_isReservedMbSaveResultNotify then
    gvars.sav_isReservedMbSaveResultNotify=false
    if n then
      TppMotherBaseManagement.SetRequestSaveResultSuccess()
    else
      TppMotherBaseManagement.SetRequestSaveResultFailure()
    end
  end
end
this.SAVE_RESULT_FUNCTION={[Fox.StrCode32(TppDefine.CONFIG_SAVE_FILE_NAME)]=function(e)
  end,[Fox.StrCode32(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)]=function(e)
    if e==false then
      return
    end
    if(vars.isPersonalDirty==1)then
      vars.isPersonalDirty=0
    end
  end,[Fox.StrCode32(TppDefine.GAME_SAVE_FILE_NAME)]=n,[Fox.StrCode32(TppDefine.GAME_SAVE_FILE_NAME_TMP)]=n}
function this.GetSaveFileVersion(e)
  return(TppDefine.SAVE_FILE_INFO[e].version+TppDefine.PROGRAM_SAVE_FILE_VERSION[e]*TppDefine.PROGRAM_SAVE_FILE_VERSION_OFFSET)
end
function this.IsExistConfigSaveFile()
  return TppScriptVars.FileExists(TppDefine.CONFIG_SAVE_FILE_NAME)
end
function this.IsExistPersonalSaveFile()
  return TppScriptVars.FileExists(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)
end
function this.ForbidSave()
  gvars.permitGameSave=false
end
function this.NeedWaitSavingErrorCheck()
  if gvars.sav_SaveResultCheckFileName==0 then
    return false
  else
    return true
  end
end
function this.IsSaving()
  if TppScriptVars.IsSavingOrLoading()then
    return true
  end
  if this.IsEnqueuedSaveData()then
    return true
  end
  if(gvars.sav_SaveResultCheckFileName~=0)then
    return true
  end
  return false
end
function this.IsSavingWithFileName(e)
  if gvars.sav_SaveResultCheckFileName==Fox.StrCode32(e)then
    return true
  else
    return false
  end
end
function this.HasQueue(a)
  for n=1,this.saveQueueDepth do
    if this.saveQueueList[n].fileName==a then
      return true
    end
  end
  return false
end
function this.IsEnqueuedSaveData()
  if this.saveQueueDepth>0 then
    return true
  else
    return false
  end
end
local p=this.IsEnqueuedSaveData
function this.RegistCompositSlotSize(n)
  this.COMPOSIT_SLOT_SIZE=n
end
function this.SetUpCompositSlot()
  if this.COMPOSIT_SLOT_SIZE then
    TppScriptVars.SetUpSlotAsCompositSlot(TppDefine.SAVE_SLOT.SAVING,this.COMPOSIT_SLOT_SIZE)
  end
end
function this.SaveGameData(i,t,S,n,a)
  if n then
    this.ReserveNextMissionStartSave(this.GetGameSaveFileName(),a)
  else
    local n=this.GetSaveGameDataQueue(i,t,S,a)
    this.EnqueueSave(n)
  end
  this.CheckAndSavePersonalData(n)
end
function this.GetSaveGameDataQueue(S,n,i,t)
  local a=this.GetGameSaveFileName()
  local n=this.GetIntializedCompositSlotSaveQueue(a,n,i,t)n=this._SaveGlobalData(n)n=this._SaveMissionData(n)n=this._SaveMissionRestartableData(n)n=this._SaveRetryData(n)n=this._SaveMbManagementData(n,S)n=this._SaveQuestData(n)
  return n
end
function this.SaveConfigData(n,a,S)
  if a then
    local n=this.MakeNewSaveQueue(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,n)
    return this.DoSave(n,true)
  elseif S then
    this.ReserveNextMissionStartSave(TppDefine.CONFIG_SAVE_FILE_NAME)
  else
    this.EnqueueSave(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,n)
  end
end
function this.SaveMGOData()
  this.EnqueueSave(TppDefine.SAVE_SLOT.MGO,TppDefine.SAVE_SLOT.MGO_SAVE,TppScriptVars.CATEGORY_MGO,TppDefine.MGO_SAVE_FILE_NAME)
end
function this.SavePersonalData(n,a,S)
  if a then
    local n=this.MakeNewSaveQueue(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.SAVE_SLOT.PERSONAL_SAVE,TppScriptVars.CATEGORY_PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,n)
    return this.DoSave(n,true)
  elseif S then
    this.ReserveNextMissionStartSave(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)
  else
    this.EnqueueSave(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.SAVE_SLOT.PERSONAL_SAVE,TppScriptVars.CATEGORY_PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,n)
  end
end
function this.CheckAndSavePersonalData(a)
  local n=TppDefine.PERSONAL_DATA_SAVE_FILE_NAME
  if this.IsSavingWithFileName(n)or this.HasQueue(n)then
    return
  end
  if(vars.isPersonalDirty==1)then
    this.VarSavePersonalData()
    this.SavePersonalData(nil,nil,a)
  end
end
function this.SaveAvatarData()Player.SetEnableUpdateAvatarInfo(true)
  this.VarSavePersonalData()
  this.SavePersonalData()
end
function this.SaveOnlyMbManagement(a)
  local n=vars.missionCode
  this.VarSaveMbMangement(n)
  this.SaveGameData(n,nil,a)
end
function this.ReserveNoticeOfMbSaveResult()
  gvars.sav_isReservedMbSaveResultNotify=true
end
function this.SaveOnlyGlobalData()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
  this.SaveGameData(vars.missionCode)
end
function this.SaveGzPrivilege()
  this.SaveMBAndGlobal()
end
function this.SaveMBAndGlobal()
  this.VarSaveMBAndGlobal()
  this.SaveGameData(currentMissionCode)
end
function this.VarSaveMBAndGlobal()
  local n=vars.missionCode
  this.VarSaveMbMangement(n)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
this.DO_RESERVE_SAVE_FUNCTION={[TppDefine.CONFIG_SAVE_FILE_NAME]=this.SaveConfigData,[TppDefine.PERSONAL_DATA_SAVE_FILE_NAME]=this.SavePersonalData,[TppDefine.GAME_SAVE_FILE_NAME]=this.SaveGameData,[TppDefine.GAME_SAVE_FILE_NAME_TMP]=this.SaveGameData}
function this.ReserveNextMissionStartSave(a,S)
  if not this.DO_RESERVE_SAVE_FUNCTION[a]then
    return
  end
  this.missionStartSaveFilePool=this.missionStartSaveFilePool or{}
  local n=this.missionStartSaveFilePool[a]or{}
  if n and S then
    n.isCheckPoint=S
  end
  this.missionStartSaveFilePool[a]=n
end
function this.DoReservedSaveOnMissionStart()
  if not this.missionStartSaveFilePool then
    return
  end
  local n=Fox.GetPlatformName()
  if n=="Xbox360"or n=="XboxOne"then
    if not SignIn.IsSignedIn()then
      this.missionStartSaveFilePool=nil
      return
    end
  end
  for n,a in pairs(this.missionStartSaveFilePool)do
    local e=this.DO_RESERVE_SAVE_FUNCTION[n]e(nil,nil,nil,nil,a.isCheckPoint)
  end
  this.missionStartSaveFilePool=nil
end
function this._SaveGlobalData(n)
  if TppScriptVars.StoreUtcTimeToScriptVars then
    TppScriptVars.StoreUtcTimeToScriptVars()
  end
  return this.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.GLOBAL,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
function this._SaveMissionData(n)
  return this.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.CHECK_POINT,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_MISSION)
end
function this._SaveRetryData(n)
  return this.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.RETRY,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_RETRY)
end
function this.CanSaveMbMangementData(e)
  local e=e or vars.missionCode
  if(vars.fobSneakMode==FobMode.MODE_SHAM)then
    return false
  end
  return(e~=10030)or(not gvars.isMissionClearedS10030)
end
function this._SaveMbManagementData(n,a)
  return this.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_MB_MANAGEMENT)
end
function this._SaveQuestData(n)
  return this.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.QUEST,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_QUEST)
end
function this._SaveMissionRestartableData(n)n=this.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.MISSION_START,TppDefine.SAVE_SLOT.SAVING,TppDefine.CATEGORY_MISSION_RESTARTABLE)n=this.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppDefine.SAVE_SLOT.SAVING,TppDefine.CATEGORY_MISSION_RESTARTABLE)
  return n
end
function this.MakeNewGameSaveData(S)
  TppVarInit.InitializeOnNewGameAtFirstTime()
  TppVarInit.InitializeOnNewGame()
  if S then
    TppTerminal.AcquirePrivilegeInTitleScreen()
  end
  this.VarSave(vars.missionCode,true)
  this.VarSaveOnRetry()
  local a,n=this.GetSaveGameDataQueue(vars.missionCode)
  if gvars.permitGameSave then
    a=this.GetSaveGameDataQueue(vars.missionCode)n=this.DoSave(a,true)
  end
  if S then
    this.CheckAndSavePersonalData()
  end
  return n
end
function this.GetIntializedCompositSlotSaveQueue(e,a,n,S)
  return{fileName=e,needIcon=a,doSaveFunc=n,isCheckPoint=S}
end
function this.AddSlotToSaveQueue(e,a,n,S)
  if a==nil then
    return
  end
  if n==nil then
    return
  end
  if S==nil then
    return
  end
  local e=e or{}
  e.savingSlot=n
  e.slot=e.slot or{}
  e.category=e.category or{}
  local n=#e.slot+1
  e.slot[n]=a
  e.category[n]=S
  return e
end
function this.EnqueueSave(n,S,t,r,i)
  if n==nil then
    return
  end
  if gvars.isLoadedInitMissionOnSignInUserChanged or TppException.isLoadedInitMissionOnSignInUserChanged then
    return
  end
  local a
  if Tpp.IsTypeTable(n)then
    a=n
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
  this.saveQueueDepth=this.saveQueueDepth+1
  if a then
    this.saveQueueList[this.saveQueueDepth]=a
  else
    this.saveQueueList[this.saveQueueDepth]=this.MakeNewSaveQueue(n,S,t,r,i)
  end
end
function this.MakeNewSaveQueue(a,n,i,S,t,r)
  local e={}
  e.slot=a
  e.savingSlot=n
  e.category=i
  e.fileName=S
  e.needIcon=t
  e.doSaveFunc=r
  return e
end
function this.DequeueSave()
  for n=1,(this.saveQueueDepth-1)do
    this.saveQueueList[n]=this.saveQueueList[n+1]
  end
  this.saveQueueList[this.saveQueueDepth]=nil
  this.saveQueueDepth=this.saveQueueDepth-1
end
function this.ProcessSaveQueue()
  if not p()then
    return false
  end
  local n=this.saveQueueList[1]
  if n then
    local n=this.DoSave(n)
    if n~=nil then
      this.DequeueSave()
      if n==TppScriptVars.WRITE_FAILED then
        if(gvars.sav_SaveResultCheckFileName~=0)then
          local e=this.SAVE_RESULT_FUNCTION[gvars.sav_SaveResultCheckFileName]
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
function this.DoSave(n,a)
  local r=true
  if a then
    r=false
  end
  local a
  local p
  local t
  local i
  local S
  local T
  if Tpp.IsTypeTable(n.slot)then
    this.SetUpCompositSlot()t=n.fileName
    i=n.needIcon
    S=n.doSaveFunc
    T=n.isCheckPoint
    for t,S in ipairs(n.slot)do
      a=n.category[t]p=this.GetSaveFileVersion(a)
      TppScriptVars.CopySlot({n.savingSlot,S},S)
    end
  else
    a=n.category
    if a then
      p=this.GetSaveFileVersion(a)t=n.fileName
      i=n.needIcon
      S=n.doSaveFunc
      TppScriptVars.CopySlot(n.savingSlot,n.slot)
    else
      return false
    end
  end
  if S then
    S()
  end
  local e=TppScriptVars.WriteSlotToFile(n.savingSlot,t,i)
  if r then
    gvars.sav_SaveResultCheckFileName=Fox.StrCode32(t)
    if T then
      gvars.sav_isCheckPointSaving=true
    end
  end
  return e
end
function this.Update()
  if(not i())then
    if(gvars.sav_SaveResultCheckFileName~=0)then
      local a=true
      local n=TppScriptVars.GetLastResult()
      local n,S=this.GetSaveResultErrorMessage(n)
      if n then
        a=false
        TppUiCommand.ShowErrorPopup(n,S)
      end
      local e=this.SAVE_RESULT_FUNCTION[gvars.sav_SaveResultCheckFileName]
      if e then
        e(a)
      end
      gvars.sav_SaveResultCheckFileName=0
      gvars.sav_isCheckPointSaving=false
    end
    if not PatchDlc.IsCheckingPatchDlc()then
      if this.IsEnqueuedSaveData()then
        this.ProcessSaveQueue()
      end
    end
  end
  if i()then
    local e=TppScriptVars.GetSaveState()
    if e==TppScriptVars.STATE_SAVING then
      if gvars.sav_isCheckPointSaving then
        TppUI.ShowSavingIcon"checkpoint"else
        TppUI.ShowSavingIcon()
      end
    end
    if e==TppScriptVars.STATE_LOADING then
      TppUI.ShowLoadingIcon()
    end
    if e==TppScriptVars.STATE_PROCESSING then
      TppUI.ShowLoadingIcon()
    end
  end
end
this.SaveErrorMessageIdTable={[TppScriptVars.RESULT_ERROR_INVALID_STORAGE]={TppDefine.ERROR_ID.CANNOT_FIND_STORAGE_IN_GAME,Popup.TYPE_ONE_BUTTON}}
function this.GetSaveResultErrorMessage(n)
  if n==TppScriptVars.RESULT_OK then
    return
  end
  local e=this.SaveErrorMessageIdTable[n]
  if e then
    return e[1],e[2]
  else
    return TppDefine.ERROR_ID.SAVE_FAILED_UNKNOWN_REASON
  end
end
function this.Init(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.Messages()
  return Tpp.StrCode32Table{UI={{msg="PopupClose",sender=TppDefine.ERROR_ID.CANNOT_FIND_STORAGE_IN_GAME,func=function()
    this.ForbidSave()
  end}}}
end
function this.OnMessage(p,r,t,i,S,n,a)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,p,r,t,i,S,n,a)
end
function this.WaitingAllEnqueuedSaveOnStartMission()
  while i()do
    this.CoroutineYieldWithShowSavingIcon()
  end
  while p()do
    this.ProcessSaveQueue()
    while i()do
      this.CoroutineYieldWithShowSavingIcon()
    end
  end
end
function this.CoroutineYieldWithShowSavingIcon()
  TppUI.ShowSavingIcon()coroutine.yield()
end
function this.SaveVarsToSlot(S,a,n)
  local e=this.GetSaveFileVersion(n)
  TppScriptVars.SaveVarsToSlot(S,a,n,e)
end
function this.VarSaveOnlyGlobalData()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
function this.VarSave(n,a)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
  if gvars.usingNormalMissionSlot then
    this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MISSION)
    if a then
      this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
      this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MISSION_START,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
    else
      this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
    end
  end
  if this.CanSaveMbMangementData(n)then
    this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  end
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)
end
function this.VarSaveOnRetry()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)
end
function this.VarSaveMbMangement(n,a)
  if this.CanSaveMbMangementData(n)or a then
    this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  end
end
function this.VarSaveQuest(n)
  if this.CanSaveMbMangementData(n)then
    this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  end
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)
end
function this.VarSaveConfig()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CONFIG,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_CONFIG)
end
function this.VarSaveMGO()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MGO,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MGO)
end
function this.VarSavePersonalData()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.PERSONAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_PERSONAL)
end
function this.LoadFromSaveFile(e,n)
  return TppScriptVars.ReadSlotFromFile(e,n)
end
function this.GetGameSaveFileName()do
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    return TppDefine.MGO_MAIN_SAVE_FILE_NAME
  else
    return TppDefine.GAME_SAVE_FILE_NAME
  end
end
end
function this.DEBUG_IsUsingTemporarySaveData()do
  return false
end
return gvars.DEBUG_usingTemporarySaveData
end
function this.LoadGameDataFromSaveFile()
  local n=this.GetGameSaveFileName()
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.SAVING,n)
end
local a={TppScriptVars.CATEGORY_GAME_GLOBAL,TppScriptVars.CATEGORY_MISSION,TppScriptVars.CATEGORY_RETRY,TppScriptVars.CATEGORY_MB_MANAGEMENT,TppScriptVars.CATEGORY_QUEST,TppDefine.CATEGORY_MISSION_RESTARTABLE}
function this.CheckGameDataVersion()
  for a,n in ipairs(a)do
    local a=TppDefine.SAVE_FILE_INFO[n].slot
    local a=this.CheckSlotVersion(n,TppDefine.SAVE_SLOT.SAVING)
    if a~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
      return a
    end
    if TppDefine.SAVE_FILE_INFO[n].missionStartSlot then
      local e=this.CheckSlotVersion(n,TppDefine.SAVE_SLOT.SAVING,true)
      if e~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
        return e
      end
    end
  end
  return TppDefine.SAVE_FILE_LOAD_RESULT.OK
end
function this.CopyGameDataFromSavingSlot()
  for e,n in ipairs(a)do
    local e=TppDefine.SAVE_FILE_INFO[n].slot
    TppScriptVars.CopySlot(e,{TppDefine.SAVE_SLOT.SAVING,e})
    local e=TppDefine.SAVE_FILE_INFO[n].missionStartSlot
    if e then
      TppScriptVars.CopySlot(e,{TppDefine.SAVE_SLOT.SAVING,e})
    end
  end
end
function this.LoadMGODataFromSaveFile()
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.MGO,TppDefine.MGO_SAVE_FILE_NAME)
end
function this.LoadConfigDataFromSaveFile()
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME)
end
function this.LoadPersonalDataFromSaveFile()
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)
end
function this.CheckSlotVersion(n,a,S)
  local t=this.GetSaveFileVersion(n)
  local e=TppDefine.SAVE_FILE_INFO[n].slot
  if S then
    e=TppDefine.SAVE_FILE_INFO[n].missionStartSlot
  end
  if a then
    e={a,e}
  end
  local e=TppScriptVars.GetScriptVersionFromSlot(e)
  if e==nil then
    return TppDefine.SAVE_FILE_LOAD_RESULT.ERROR_LOAD_FAILED
  end
  if e<=t then
    return TppDefine.SAVE_FILE_LOAD_RESULT.OK
  else
    return TppDefine.SAVE_FILE_LOAD_RESULT.DIFFER_FROM_CURRENT_VERSION
  end
end
function this.CheckSlotVersionConfigData()
  return this.CheckSlotVersion(TppScriptVars.CATEGORY_CONFIG)
end
function this.IsReserveVarRestoreForContinue()
  return gvars.sav_varRestoreForContinue
end
function this.ReserveVarRestoreForContinue()
  gvars.sav_varRestoreForContinue=true
end
function this.ReserveVarRestoreForMissionStart()
  gvars.sav_varRestoreForContinue=false
end
function this.VarRestoreOnMissionStart()
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
function this.VarRestoreOnContinueFromCheckPoint()
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
function this.DeleteGameSaveFile()
  TppScriptVars.DeleteFile(TppDefine.GAME_SAVE_FILE_NAME)
end
function this.DeleteTemporaryGameSaveFile()
  TppScriptVars.DeleteFile(TppDefine.GAME_SAVE_FILE_NAME_TMP)
end
function this.DeleteConfigSaveFile()
  TppScriptVars.DeleteFile(TppDefine.CONFIG_SAVE_FILE_NAME)
end
function this.DeletePersonalDataSaveFile()
  TppScriptVars.DeleteFile(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)
end
function this.DeleteMGOSaveFile()
  TppScriptVars.DeleteFile(TppDefine.MGO_SAVE_FILE_NAME)
end
function this.IsNewGame()
  return gvars.isNewGame
end
function this.IsGameDataLoadResultOK()
  if(gvars.gameDataLoadingResult==TppDefine.SAVE_FILE_LOAD_RESULT.OK)or(gvars.gameDataLoadingResult==TppDefine.SAVE_FILE_LOAD_RESULT.OK_LOAD_BACKUP)then
    return true
  else
    return false
  end
end
this.SAVE_FILE_OK_RESULT_TABLE={[TppScriptVars.RESULT_OK]=TppDefine.SAVE_FILE_LOAD_RESULT.OK,[TppScriptVars.RESULT_ERROR_LOAD_BACKUP]=TppDefine.SAVE_FILE_LOAD_RESULT.OK_LOAD_BACKUP}
function this.CheckGameSaveDataLoadResult()
  local a=TppScriptVars.GetLastResult()
  local n=this.SAVE_FILE_OK_RESULT_TABLE[a]
  if n then
    local e=this.CheckGameDataVersion()
    if e~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
      gvars.gameDataLoadingResult=e
    else
      gvars.gameDataLoadingResult=n
    end
  else
    if a==TppScriptVars.RESULT_ERROR_NOSPACE then
      gvars.gameDataLoadingResult=TppDefine.SAVE_FILE_LOAD_RESULT.DIFFER_FROM_CURRENT_VERSION
    else
      gvars.gameDataLoadingResult=TppDefine.SAVE_FILE_LOAD_RESULT.ERROR_LOAD_FAILED
    end
  end
end
function this.GetGameDataLoadingResult()
  return gvars.gameDataLoadingResult
end
return this
