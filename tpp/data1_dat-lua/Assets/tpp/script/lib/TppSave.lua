local this={}
local t=TppScriptVars.IsSavingOrLoading
this.saveQueueDepth=0
this.saveQueueList={}
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
this.SAVE_RESULT_FUNCTION={[Fox.StrCode32(TppDefine.CONFIG_SAVE_FILE_NAME)]=function(e)
  end,[Fox.StrCode32(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)]=function(e)
    if e==false then
      return
    end
    if(vars.isPersonalDirty==1)then
      vars.isPersonalDirty=0
    end
  end,[Fox.StrCode32(TppDefine.GAME_SAVE_FILE_NAME)]=a,[Fox.StrCode32(TppDefine.GAME_SAVE_FILE_NAME_TMP)]=a}
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
  if(this.GetSaveRequestFromQueue(a)~=nil)then
    return true
  else
    return false
  end
end
function this.GetSaveRequestFromQueue(n)
  for a=1,this.saveQueueDepth do
    if this.saveQueueList[a].fileName==n then
      return a,this.saveQueueList[a]
    end
  end
end
function this.EraseAllGameDataSaveRequest()
  local a,n
  repeat
    a,n=this.GetSaveRequestFromQueue(this.GetGameSaveFileName())
    if a then
      if(n.doSaveFunc==this.ReserveNoticeOfMbSaveResult)then
        TppMotherBaseManagement.SetRequestSaveResultFailure()
      end
      this.DequeueSave(a)
    end
  until(a==nil)
end
function this.IsEnqueuedSaveData()
  if this.saveQueueDepth>0 then
    return true
  else
    return false
  end
end
local p=this.IsEnqueuedSaveData
function this.RegistCompositSlotSize(a)
  this.COMPOSIT_SLOT_SIZE=a
end
function this.SetUpCompositSlot()
  if this.COMPOSIT_SLOT_SIZE then
    TppScriptVars.SetUpSlotAsCompositSlot(TppDefine.SAVE_SLOT.SAVING,this.COMPOSIT_SLOT_SIZE)
  end
end
function this.SaveGameData(t,i,S,a,n)
  if a then
    this.ReserveNextMissionStartSave(this.GetGameSaveFileName(),n)
  else
    local a=this.GetSaveGameDataQueue(t,i,S,n)
    this.EnqueueSave(a)
  end
  this.CheckAndSavePersonalData(a)
end
function this.GetSaveGameDataQueue(n,i,S,t)
  local a=this.GetGameSaveFileName()
  local a=this.GetIntializedCompositSlotSaveQueue(a,i,S,t)a=this._SaveGlobalData(a)a=this._SaveMissionData(a)a=this._SaveMissionRestartableData(a)a=this._SaveRetryData(a)a=this._SaveMbManagementData(a,n)a=this._SaveQuestData(a)
  return a
end
function this.SaveConfigData(a,t,n)
  if t then
    local a=this.MakeNewSaveQueue(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,a)
    return this.DoSave(a,true)
  elseif n then
    this.ReserveNextMissionStartSave(TppDefine.CONFIG_SAVE_FILE_NAME)
  else
    this.EnqueueSave(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,a)
  end
end
function this.SaveMGOData()
  this.EnqueueSave(TppDefine.SAVE_SLOT.MGO,TppDefine.SAVE_SLOT.MGO_SAVE,TppScriptVars.CATEGORY_MGO,TppDefine.MGO_SAVE_FILE_NAME)
end
function this.SavePersonalData(a,t,n)
  if t then
    local a=this.MakeNewSaveQueue(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.SAVE_SLOT.PERSONAL_SAVE,TppScriptVars.CATEGORY_PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,a)
    return this.DoSave(a,true)
  elseif n then
    this.ReserveNextMissionStartSave(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)
  else
    this.EnqueueSave(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.SAVE_SLOT.PERSONAL_SAVE,TppScriptVars.CATEGORY_PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,a)
  end
end
function this.CheckAndSavePersonalData(n)
  local a=TppDefine.PERSONAL_DATA_SAVE_FILE_NAME
  if this.IsSavingWithFileName(a)or this.HasQueue(a)then
    return
  end
  if(vars.isPersonalDirty==1)then
    this.VarSavePersonalData()
    this.SavePersonalData(nil,nil,n)
  end
end
function this.SaveAvatarData()Player.SetEnableUpdateAvatarInfo(true)
  this.VarSavePersonalData()
  this.SavePersonalData()
end
function this.SaveOnlyMbManagement(n)
  local a=vars.missionCode
  this.VarSaveMbMangement(a)
  this.SaveGameData(a,nil,n)
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
  local a=vars.missionCode
  this.VarSaveMbMangement(a)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
this.DO_RESERVE_SAVE_FUNCTION={[TppDefine.CONFIG_SAVE_FILE_NAME]=this.SaveConfigData,[TppDefine.PERSONAL_DATA_SAVE_FILE_NAME]=this.SavePersonalData,[TppDefine.GAME_SAVE_FILE_NAME]=this.SaveGameData,[TppDefine.GAME_SAVE_FILE_NAME_TMP]=this.SaveGameData}
function this.ReserveNextMissionStartSave(n,t)
  if not this.DO_RESERVE_SAVE_FUNCTION[n]then
    return
  end
  this.missionStartSaveFilePool=this.missionStartSaveFilePool or{}
  local a=this.missionStartSaveFilePool[n]or{}
  if a and t then
    a.isCheckPoint=t
  end
  this.missionStartSaveFilePool[n]=a
end
function this.DoReservedSaveOnMissionStart()
  if not this.missionStartSaveFilePool then
    return
  end
  local a=Fox.GetPlatformName()
  if a=="Xbox360"or a=="XboxOne"then
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
function this._SaveGlobalData(a)
  if TppScriptVars.StoreUtcTimeToScriptVars then
    TppScriptVars.StoreUtcTimeToScriptVars()
  end
  return this.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.GLOBAL,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
function this._SaveMissionData(a)
  return this.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.CHECK_POINT,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_MISSION)
end
function this._SaveRetryData(a)
  return this.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.RETRY,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_RETRY)
end
function this.CanSaveMbMangementData(e)
  local e=e or vars.missionCode
  if(vars.fobSneakMode==FobMode.MODE_SHAM)then
    return false
  end
  return(e~=10030)or(not gvars.isMissionClearedS10030)
end
function this._SaveMbManagementData(a,n)
  return this.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_MB_MANAGEMENT)
end
function this._SaveQuestData(a)
  return this.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.QUEST,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_QUEST)
end
function this._SaveMissionRestartableData(a)a=this.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.MISSION_START,TppDefine.SAVE_SLOT.SAVING,TppDefine.CATEGORY_MISSION_RESTARTABLE)a=this.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppDefine.SAVE_SLOT.SAVING,TppDefine.CATEGORY_MISSION_RESTARTABLE)
  return a
end
function this.MakeNewGameSaveData(a)
  TppVarInit.InitializeOnNewGameAtFirstTime()
  TppVarInit.InitializeOnNewGame()
  if a then
    TppTerminal.AcquirePrivilegeInTitleScreen()
  end
  this.VarSave(vars.missionCode,true)
  this.VarSaveOnRetry()
  local n,t=this.GetSaveGameDataQueue(vars.missionCode)
  if gvars.permitGameSave then
    n=this.GetSaveGameDataQueue(vars.missionCode)t=this.DoSave(n,true)
  end
  if a then
    this.CheckAndSavePersonalData()
  end
  return t
end
function this.SaveImportedGameData()
  local n,a=this.GetSaveGameDataQueue(vars.missionCode)
  if gvars.permitGameSave then
    n=this.GetSaveGameDataQueue(vars.missionCode)a=this.DoSave(n,true)
  end
  return a
end
function this.GetIntializedCompositSlotSaveQueue(e,n,a,t)
  return{fileName=e,needIcon=n,doSaveFunc=a,isCheckPoint=t}
end
function this.AddSlotToSaveQueue(e,t,n,a)
  if t==nil then
    return
  end
  if n==nil then
    return
  end
  if a==nil then
    return
  end
  local e=e or{}
  e.savingSlot=n
  e.slot=e.slot or{}
  e.category=e.category or{}
  local n=#e.slot+1
  e.slot[n]=t
  e.category[n]=a
  return e
end
function this.EnqueueSave(a,S,t,r,i)
  if a==nil then
    return
  end
  if(gvars.isLoadedInitMissionOnSignInUserChanged or TppException.isLoadedInitMissionOnSignInUserChanged)or TppException.isNowGoingToMgo then
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
  this.saveQueueDepth=this.saveQueueDepth+1
  if n then
    this.saveQueueList[this.saveQueueDepth]=n
  else
    this.saveQueueList[this.saveQueueDepth]=this.MakeNewSaveQueue(a,S,t,r,i)
  end
end
function this.MakeNewSaveQueue(n,a,t,i,S,r)
  local e={}
  e.slot=n
  e.savingSlot=a
  e.category=t
  e.fileName=i
  e.needIcon=S
  e.doSaveFunc=r
  return e
end
function this.DequeueSave(a)
  if(a==nil)then
    a=1
  end
  for a=a,(this.saveQueueDepth-1)do
    this.saveQueueList[a]=this.saveQueueList[a+1]
  end
  if(this.saveQueueDepth<=0)then
    return
  end
  this.saveQueueList[this.saveQueueDepth]=nil
  this.saveQueueDepth=this.saveQueueDepth-1
end
function this.ProcessSaveQueue()
  if not p()then
    return false
  end
  local a=this.saveQueueList[1]
  if a then
    local a=this.DoSave(a)
    if a~=nil then
      this.DequeueSave()
      if a==TppScriptVars.WRITE_FAILED then
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
function this.DoSave(a,n)
  local r=true
  if n then
    r=false
  end
  local n
  local o
  local t
  local i
  local S
  local p
  if Tpp.IsTypeTable(a.slot)then
    this.SetUpCompositSlot()t=a.fileName
    i=a.needIcon
    S=a.doSaveFunc
    p=a.isCheckPoint
    for S,t in ipairs(a.slot)do
      n=a.category[S]o=this.GetSaveFileVersion(n)
      TppScriptVars.CopySlot({a.savingSlot,t},t)
    end
  else
    n=a.category
    if n then
      o=this.GetSaveFileVersion(n)t=a.fileName
      i=a.needIcon
      S=a.doSaveFunc
      TppScriptVars.CopySlot(a.savingSlot,a.slot)
    else
      return false
    end
  end
  if S then
    S()
  end
  local e=TppScriptVars.WriteSlotToFile(a.savingSlot,t,i)
  if r then
    gvars.sav_SaveResultCheckFileName=Fox.StrCode32(t)
    if p then
      gvars.sav_isCheckPointSaving=true
    end
  end
  return e
end
function this.Update()
  if(not t())then
    if(gvars.sav_SaveResultCheckFileName~=0)then
      local a=true
      local n=TppScriptVars.GetLastResult()
      local n,t=this.GetSaveResultErrorMessage(n)
      if n then
        a=false
        TppUiCommand.ShowErrorPopup(n,t)
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
  if t()then
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
function this.GetSaveResultErrorMessage(a)
  if a==TppScriptVars.RESULT_OK then
    return
  end
  local e=this.SaveErrorMessageIdTable[a]
  if e then
    return e[1],e[2]
  else
    return TppDefine.ERROR_ID.SAVE_FAILED_UNKNOWN_REASON
  end
end
function this.Init(a)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(a)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.Messages()
  return Tpp.StrCode32Table{UI={{msg="PopupClose",sender=TppDefine.ERROR_ID.CANNOT_FIND_STORAGE_IN_GAME,func=function()
    this.ForbidSave()
  end}}}
end
function this.OnMessage(t,i,p,r,a,n,S)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,t,i,p,r,a,n,S)
end
function this.WaitingAllEnqueuedSaveOnStartMission()
  while t()do
    this.CoroutineYieldWithShowSavingIcon()
  end
  while p()do
    this.ProcessSaveQueue()
    while t()do
      this.CoroutineYieldWithShowSavingIcon()
    end
  end
end
function this.CoroutineYieldWithShowSavingIcon()
  TppUI.ShowSavingIcon()coroutine.yield()
end
function this.SaveVarsToSlot(t,n,a)
  local e=this.GetSaveFileVersion(a)
  TppScriptVars.SaveVarsToSlot(t,n,a,e)
end
function this.VarSaveOnlyGlobalData()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
function this.VarSave(a,n)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
  if gvars.usingNormalMissionSlot then
    this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MISSION)
    if n then
      this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
      this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MISSION_START,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
    else
      this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
    end
  end
  if this.CanSaveMbMangementData(a)then
    this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  end
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)
end
function this.VarSaveOnRetry()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)
end
function this.VarSaveMbMangement(a,n)
  if this.CanSaveMbMangementData(a)or n then
    this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  end
end
function this.VarSaveQuest(a)
  if this.CanSaveMbMangementData(a)then
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
function this.LoadFromSaveFile(n,a,e)
  if not e then
    return TppScriptVars.ReadSlotFromFile(n,a)
  else
    return TppScriptVars.ReadSlotFromAreaFile(n,e,a)
  end
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
function this.LoadGameDataFromSaveFile(a)
  local n=this.GetGameSaveFileName()
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.SAVING,n,a)
end
local t={TppScriptVars.CATEGORY_GAME_GLOBAL,TppScriptVars.CATEGORY_MISSION,TppScriptVars.CATEGORY_RETRY,TppScriptVars.CATEGORY_MB_MANAGEMENT,TppScriptVars.CATEGORY_QUEST,TppDefine.CATEGORY_MISSION_RESTARTABLE}
function this.CheckGameDataVersion()
  for n,a in ipairs(t)do
    local n=TppDefine.SAVE_FILE_INFO[a].slot
    local n=this.CheckSlotVersion(a,TppDefine.SAVE_SLOT.SAVING)
    if n~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
      return n
    end
    if TppDefine.SAVE_FILE_INFO[a].missionStartSlot then
      local e=this.CheckSlotVersion(a,TppDefine.SAVE_SLOT.SAVING,true)
      if e~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
        return e
      end
    end
  end
  return TppDefine.SAVE_FILE_LOAD_RESULT.OK
end
function this.CopyGameDataFromSavingSlot()
  for e,a in ipairs(t)do
    local e=TppDefine.SAVE_FILE_INFO[a].slot
    TppScriptVars.CopySlot(e,{TppDefine.SAVE_SLOT.SAVING,e})
    local e=TppDefine.SAVE_FILE_INFO[a].missionStartSlot
    if e then
      TppScriptVars.CopySlot(e,{TppDefine.SAVE_SLOT.SAVING,e})
    end
  end
end
function this.LoadMGODataFromSaveFile()
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.MGO,TppDefine.MGO_SAVE_FILE_NAME)
end
function this.LoadConfigDataFromSaveFile(a)
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,a)
end
function this.LoadPersonalDataFromSaveFile(a)
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,a)
end
function this.CheckSlotVersion(a,n,t)
  local S=this.GetSaveFileVersion(a)
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
  local n=TppScriptVars.GetLastResult()
  local a=this.SAVE_FILE_OK_RESULT_TABLE[n]
  if a then
    local e=this.CheckGameDataVersion()
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
function this.GetGameDataLoadingResult()
  return gvars.gameDataLoadingResult
end
return this
