local this={}
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsSavingOrLoading=TppScriptVars.IsSavingOrLoading
local IsIdle=SsdSaveSystem.IsIdle
local ICON_TYPE_SAVE=SsdSaveSystem.ICON_TYPE_SAVE
local ICON_TYPE_LOAD=SsdSaveSystem.ICON_TYPE_LOAD
local ICON_TYPE_NONE=SsdSaveSystem.ICON_TYPE_NONE
this.saveQueueDepth=0
this.saveQueueList={}
local p={{checkStorySequenceSpan={TppDefine.STORY_SEQUENCE.BEFORE_s10050,TppDefine.STORY_SEQUENCE.CLEARED_s10050},checkMissionCode=10050,checkMissionSequence=3,returnStorySequence=TppDefine.STORY_SEQUENCE.BEFORE_s10050,returnMissionCode=30020,returnLocationCode=TppDefine.LOCATION_ID.MAFR},{checkStorySequenceSpan={TppDefine.STORY_SEQUENCE.CLEARED_k40260,TppDefine.STORY_SEQUENCE.BEFORE_STORY_LAST},checkMissionCode=30010,checkMissionSequence=9,returnStorySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40270,returnMissionCode=30010,returnLocationCode=TppDefine.LOCATION_ID.SSD_AFGH},{checkStorySequenceSpan={TppDefine.STORY_SEQUENCE.BEFORE_k40270,TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST},checkMissionCode=10060,checkMissionSequence=3,returnStorySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40270,returnMissionCode=30010,returnLocationCode=TppDefine.LOCATION_ID.SSD_AFGH}}
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
  gvars.sav_permitGameSave=false
end
function this.IsForbidSave()
  return(not gvars.sav_permitGameSave)
end
function this.NeedWaitSavingErrorCheck()
  if gvars.sav_SaveResultCheckFileName==0 then
    return false
  else
    return true
  end
end
function this.IsSaving()
  if IsSavingOrLoading()then
    return true
  end
  if this.IsEnqueuedSaveData()then
    return true
  end
  if(gvars.sav_SaveResultCheckFileName~=0)then
    return true
  end
  if not IsIdle()then
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
      if not Tpp.IsMaster()then
        this.DEBUG_EraseAllGameDataCounter=3
      end
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
local o=this.IsEnqueuedSaveData
function this.RegistCompositSlotSize(a)
  this.COMPOSIT_SLOT_SIZE=a
end
function this.SetUpCompositSlot()
  if this.COMPOSIT_SLOT_SIZE then
    TppScriptVars.SetUpSlotAsCompositSlot(TppDefine.SAVE_SLOT.SAVING,this.COMPOSIT_SLOT_SIZE)
  end
end
function this.SaveGameData(r,i,t,a,n)
  if a then
    this.ReserveNextMissionStartSave(this.GetGameSaveFileName(),n)
  else
    local a=this.GetSaveGameDataQueue(r,i,t,n)
    this.EnqueueSave(a)
  end
  this.CheckAndSavePersonalData(a)
end
function this.GetSaveGameDataQueue(r,i,n,t)
  local a=this.GetGameSaveFileName()
  local a=this.GetIntializedCompositSlotSaveQueue(a,i,n,t)a=this._SaveGlobalData(a)a=this._SaveMissionData(a)a=this._SaveMissionRestartableData(a)a=this._SaveRetryData(a)a=this._SaveMbManagementData(a,r)a=this._SaveQuestData(a)
  return a
end
function this.SaveConfigData(a,n,t)
  if n then
    local a=this.MakeNewSaveQueue(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,a)
    return this.DoSave(a,true)
  elseif t then
    this.ReserveNextMissionStartSave(TppDefine.CONFIG_SAVE_FILE_NAME)
  else
    this.EnqueueSave(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,a)
  end
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
function this.SaveEditData()
  this.VarSavePersonalData()
  this.SavePersonalData()SsdSaveSystem.SaveCommunicationConfig()
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
function this.ReserveNextMissionStartSave(a,t)
  if not this.DO_RESERVE_SAVE_FUNCTION[a]then
    return
  end
  this.missionStartSaveFilePool=this.missionStartSaveFilePool or{}
  local n=this.missionStartSaveFilePool[a]or{}
  if n and t then
    n.isCheckPoint=t
  end
  this.missionStartSaveFilePool[a]=n
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
  for a,n in pairs(this.missionStartSaveFilePool)do
    local e=this.DO_RESERVE_SAVE_FUNCTION[a]e(nil,nil,nil,nil,n.isCheckPoint)
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
  gvars.sav_skipRestoreToVars=true
  this.VarSave(vars.missionCode,true)
  this.VarSaveOnRetry()
  local n,t=this.GetSaveGameDataQueue(vars.missionCode)
  if gvars.sav_permitGameSave then
    n=this.GetSaveGameDataQueue(vars.missionCode)t=this.DoSave(n,true)
  end
  if a then
    this.CheckAndSavePersonalData()
  end
  return t
end
function this.SaveImportedGameData()
  local a,n=this.GetSaveGameDataQueue(vars.missionCode)
  if gvars.sav_permitGameSave then
    a=this.GetSaveGameDataQueue(vars.missionCode)n=this.DoSave(a,true)
  end
  return n
end
function this.SaveToServer(a,n)
  if n and IsTypeFunc(n)then
    table.insert(mvars.sav_serverSaveFinishCallback,n)
  end
  if not a then
    return
  end
  if mvars.mis_skipServerSave or mvars.fms_skipServerSave then
    return
  end
  if gvars.exc_skipServerSaveForException then
    return
  end
  if TppMission.IsMultiPlayMission(vars.missionCode)then
    return
  end
  if a==TppDefine.SERVER_SAVE_TYPE.MISSION_START then
    SsdSaveSystem.SaveMissionStart()
  elseif a==TppDefine.SERVER_SAVE_TYPE.CHECK_POINT then
    SsdSaveSystem.SaveCheckPoint()
  elseif a==TppDefine.SERVER_SAVE_TYPE.MISSION_END then
    SsdSaveSystem.SaveMissionEnd()
  elseif a==TppDefine.SERVER_SAVE_TYPE.FLAG_MISSION_END then
    SsdSaveSystem.SaveFlagMissionEnd()
  elseif a==TppDefine.SERVER_SAVE_TYPE.AVATAR_EDIT_END then
    SsdSaveSystem.SaveAvatar()
  else
    return
  end
  this.ReserveVarRestoreForContinue()
end
function this.LoadFromServer(ServerSaveFinishCallback)
  if ServerSaveFinishCallback and IsTypeFunc(ServerSaveFinishCallback)then
    table.insert(mvars.sav_serverSaveFinishCallback,ServerSaveFinishCallback)
  end
  if gvars.exc_skipServerSaveForException then
    return
  end
  gvars.sav_skipRestoreToVars=false
  SsdSaveSystem.Reset()
  SsdSaveSystem.LoadInit()
end
function this.AddServerSaveCallbackFunc(e)
  if mvars.mis_skipServerSave or mvars.fms_skipServerSave then
    return
  end
  if gvars.exc_skipServerSaveForException then
    return
  end
  if not IsTypeFunc(e)then
    return
  end
  table.insert(mvars.sav_serverSaveFinishCallback,e)
end
function this.RestoreToVars(a)
  if gvars.sav_skipRestoreToVars then
    return
  end
  if gvars.exc_skipServerSaveForException then
    return
  end
  SsdSaveSystem.RestoreToVars(a)
  if gvars.sav_continueForOutOfBaseArea then
    TppPlayer.RestoreTempInitialPosition()
  elseif TppMission.IsStoryMission(vars.missionCode)then
    TppPlayer.SetInitialPositionToCurrentPosition()
  else
    TppPlayer.ResetInitialPosition()
  end
  SsdSbm.RestoreFromSVars()
  this.VarSave()
end
function this.GetIntializedCompositSlotSaveQueue(n,a,e,t)
  return{fileName=n,needIcon=a,doSaveFunc=e,isCheckPoint=t}
end
function this.AddSlotToSaveQueue(e,t,a,n)
  if t==nil then
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
  e.slot[a]=t
  e.category[a]=n
  return e
end
function this.EnqueueSave(a,i,t,r,S)
  if a==nil then
    return
  end
  if(gvars.isLoadedInitMissionOnSignInUserChanged or TppException.isLoadedInitMissionOnSignInUserChanged)or TppException.isNowGoingToMgo then
    return
  end
  if gvars.exc_processingForDisconnect then
    return
  end
  local n
  if IsTypeTable(a)then
    n=a
  else
    if i==nil then
      return
    end
    if t==nil then
      return
    end
  end
  if gvars.sav_permitGameSave==false then
    return
  end
  this.saveQueueDepth=this.saveQueueDepth+1
  if n then
    this.saveQueueList[this.saveQueueDepth]=n
  else
    this.saveQueueList[this.saveQueueDepth]=this.MakeNewSaveQueue(a,i,t,r,S)
  end
end
function this.MakeNewSaveQueue(t,a,r,i,n,S)
  local e={}
  e.slot=t
  e.savingSlot=a
  e.category=r
  e.fileName=i
  e.needIcon=n
  e.doSaveFunc=S
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
  if not o()then
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
  local o=true
  if n then
    o=false
  end
  local n
  local p
  local i
  local r
  local t
  local S
  if IsTypeTable(a.slot)then
    this.SetUpCompositSlot()i=a.fileName
    r=a.needIcon
    t=a.doSaveFunc
    S=a.isCheckPoint
    for i,t in ipairs(a.slot)do
      n=a.category[i]p=this.GetSaveFileVersion(n)
      TppScriptVars.CopySlot({a.savingSlot,t},t)
    end
  else
    n=a.category
    if n then
      p=this.GetSaveFileVersion(n)i=a.fileName
      r=a.needIcon
      t=a.doSaveFunc
      TppScriptVars.CopySlot(a.savingSlot,a.slot)
    else
      return false
    end
  end
  if t then
    t()
  end
  local e=TppScriptVars.WriteSlotToFile(a.savingSlot,i,r)
  if o then
    gvars.sav_SaveResultCheckFileName=Fox.StrCode32(i)
    if S then
      gvars.sav_isCheckPointSaving=true
    end
  end
  return e
end
function this.Update()
  local a=gvars
  if(not IsSavingOrLoading())then
    if(a.sav_SaveResultCheckFileName~=0)then
      local n=true
      local t=TppScriptVars.GetLastResult()
      local t,i=this.GetSaveResultErrorMessage(t)
      if t then
        n=false
        if vars.missionCode==TppDefine.SYS_MISSION_ID.INIT then
          TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"end
        TppUiCommand.ShowErrorPopup(t,i)
      end
      local e=this.SAVE_RESULT_FUNCTION[a.sav_SaveResultCheckFileName]
      if e then
        e(n)
      end
      a.sav_SaveResultCheckFileName=0
      a.sav_isCheckPointSaving=false
      a.sav_isPersonalSaving=false
      a.sav_isConfigSaving=false
    end
    if not PatchDlc.IsCheckingPatchDlc()then
      if this.IsEnqueuedSaveData()then
        this.ProcessSaveQueue()
      end
    end
  end
  if IsSavingOrLoading()then
    local e=TppScriptVars.GetSaveState()
    if e==TppScriptVars.STATE_SAVING then
      if a.sav_isPersonalSaving or a.sav_isConfigSaving then
        TppUI.ShowSavingIcon()
      end
    elseif e==TppScriptVars.STATE_LOADING then
      TppUI.ShowLoadingIcon()
    elseif e==TppScriptVars.STATE_PROCESSING then
      TppUI.ShowLoadingIcon()
    end
  end
  if not IsIdle()then
    local e=SsdSaveSystem.GetIconType()
    if e==ICON_TYPE_SAVE then
      if a.sav_isCheckPointSaving then
        TppUI.ShowSavingIcon"checkpoint"else
        TppUI.ShowSavingIcon()
      end
    elseif e==ICON_TYPE_LOAD then
      TppUI.ShowLoadingIcon()
    end
  else
    local e=mvars.sav_serverSaveFinishCallback
    if IsTypeTable(e)and next(e)then
      for a,e in pairs(e)do
        if IsTypeFunc(e)then
          e()
        end
      end
      mvars.sav_serverSaveFinishCallback={}
    end
  end
  if not Tpp.IsMaster()then
    if this.DEBUG_RecoverSaveDataCount then
      if this.DEBUG_RecoverSaveDataCount>0 then
        this.DEBUG_RecoverSaveDataCount=this.DEBUG_RecoverSaveDataCount-Time.GetFrameTime()
        local e=DebugText.NewContext()DebugText.Print(e,{1,0,0},"TppSave: Recover mission cleared broken save data.")
      else
        this.DEBUG_RecoverSaveDataCount=nil
      end
    end
    if this.QARELEASE_DEBUG_ExecuteReservedDestroySaveDataCount then
      if this.QARELEASE_DEBUG_ExecuteReservedDestroySaveDataCount>0 then
        this.QARELEASE_DEBUG_ExecuteReservedDestroySaveDataCount=this.QARELEASE_DEBUG_ExecuteReservedDestroySaveDataCount-Time.GetFrameTime()
        local e=DebugText.NewContext()DebugText.Print(e,{1,0,0},"TppSave: Execute save data break!!!.")
      else
        this.QARELEASE_DEBUG_ExecuteReservedDestroySaveDataCount=nil
      end
    end
  end
end
this.SaveErrorMessageIdTable={[TppScriptVars.RESULT_ERROR_INVALID_STORAGE]={TppDefine.ERROR_ID.CANNOT_FIND_STORAGE_IN_GAME,nil}}
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
  mvars.sav_serverSaveFinishCallback={}
  Mission.ClearDeceptiveSaveSettings()
  Mission.SetDeceptiveSaveSettings(p)
end
function this.OnReload(a)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())Mission.ClearDeceptiveSaveSettings()Mission.SetDeceptiveSaveSettings(p)
end
function this.Messages()
  return Tpp.StrCode32Table{UI={{msg="PopupClose",sender=TppDefine.ERROR_ID.CANNOT_FIND_STORAGE_IN_GAME,func=function()
    this.ForbidSave()
  end}}}
end
function this.OnMessage(t,n,i,S,a,r,s)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,t,n,i,S,a,r,s)
end
function this.WaitingAllEnqueuedSaveOnStartMission()
  this.WaitSaving()
  while o()do
    this.ProcessSaveQueue()
    this.WaitSaving()
  end
  this.WaitServerSaving()
end
function this.WaitSaving()
  while IsSavingOrLoading()do
    this.CoroutineYieldWithShowSavingIcon()
  end
end
function this.WaitServerSaving()
  while not IsIdle()do
    this.CoroutineYieldWithShowSavingIcon()
  end
end
function this.CoroutineYieldWithShowSavingIcon()
  TppUI.ShowSavingIcon()coroutine.yield()
end
function this.SaveVarsToSlot(t,n,a)
  if gvars.exc_processingForDisconnect then
    return
  end
  local e=this.GetSaveFileVersion(a)
  TppScriptVars.SaveVarsToSlot(t,n,a,e)
end
function this.VarSaveOnlyGlobalData()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
function this.VarSave(n,a)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MISSION)
  if a then
    this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
    this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MISSION_START,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
  else
    this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppScriptVars.GROUP_BIT_ALL,TppDefine.CATEGORY_MISSION_RESTARTABLE)
  end
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)
end
function this.VarSaveOnRetry()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)
end
function this.VarSaveMbMangement(a)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
end
function this.VarSaveQuest(a)
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)
end
function this.VarSaveConfig()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.CONFIG,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_CONFIG)
  gvars.sav_isConfigSaving=true
end
function this.VarSavePersonalData()
  this.SaveVarsToSlot(TppDefine.SAVE_SLOT.PERSONAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_PERSONAL)
  gvars.sav_isPersonalSaving=true
end
function this.LoadFromSaveFile(a,e,n)
  if not n then
    return TppScriptVars.ReadSlotFromFile(a,e)
  else
    return TppScriptVars.ReadSlotFromAreaFile(a,n,e)
  end
end
function this.GetGameSaveFileName()
  local e=Fox.GetPlatformName()
  if((Tpp.IsMaster()or Tpp.IsQARelease())or e=="PS4")then
    return TppDefine.GAME_SAVE_FILE_NAME
  else
    if gvars.DEBUG_usingTemporarySaveData then
      return TppDefine.GAME_SAVE_FILE_NAME_TMP
    else
      return TppDefine.GAME_SAVE_FILE_NAME
    end
  end
end
function this.DEBUG_IsUsingTemporarySaveData()
  if Tpp.IsMaster()then
    return false
  end
  return gvars.DEBUG_usingTemporarySaveData
end
function this.LoadGameDataFromSaveFile(n)
  local a=this.GetGameSaveFileName()
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.SAVING,a,n)
end
local n={TppScriptVars.CATEGORY_GAME_GLOBAL,TppScriptVars.CATEGORY_MISSION,TppScriptVars.CATEGORY_RETRY,TppScriptVars.CATEGORY_MB_MANAGEMENT,TppScriptVars.CATEGORY_QUEST,TppDefine.CATEGORY_MISSION_RESTARTABLE}
function this.CheckGameDataVersion()
  for n,a in ipairs(n)do
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
  for a,e in ipairs(n)do
    local a=TppDefine.SAVE_FILE_INFO[e].slot
    TppScriptVars.CopySlot(a,{TppDefine.SAVE_SLOT.SAVING,a})
    local e=TppDefine.SAVE_FILE_INFO[e].missionStartSlot
    if e then
      TppScriptVars.CopySlot(e,{TppDefine.SAVE_SLOT.SAVING,e})
    end
  end
end
function this.LoadConfigDataFromSaveFile(a)
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,a)
end
function this.LoadPersonalDataFromSaveFile(a)
  return this.LoadFromSaveFile(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,a)
end
function this.CheckSlotVersion(a,n,t)
  local i=this.GetSaveFileVersion(a)
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
  if e<=i then
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
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.GLOBAL,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_GAME_GLOBAL)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_MISSION)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MISSION_START,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppDefine.CATEGORY_MISSION_RESTARTABLE)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.RETRY,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_RETRY)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.QUEST,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppScriptVars.CATEGORY_QUEST)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CONFIG,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_CONFIG)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.PERSONAL,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_PERSONAL)
  gvars.sav_varRestoreForContinue=false
end
function this.VarRestoreOnContinueFromCheckPoint()
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MISSION)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppDefine.VARS_GROUP_GAME_DATA_ON_START_MISSION,TppDefine.CATEGORY_MISSION_RESTARTABLE)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.QUEST,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_QUEST)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CONFIG,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_CONFIG)
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.PERSONAL,TppScriptVars.GROUP_BIT_VARS,TppScriptVars.CATEGORY_PERSONAL)
  this.RestoreToVars()
end
function this.CheckAndSaveInitMission()
  if TppMission.IsInvitationStart()then
    vars.locationCode=TppDefine.SYS_MISSION_ID.INIT
    vars.missionCode=TppMission.GetCoopLobbyMissionCode()
    TppPlayer.ResetInitialPosition()
    TppPlayer.ResetMissionStartPosition()
    this.VarSave()
    gvars.sav_skipRestoreToVars=true
  elseif(TppMission.IsInitMission(vars.missionCode)or TppMission.IsMultiPlayMission(vars.missionCode))or TppMission.IsAvatarEditMission(vars.missionCode)then
    local a=TppStory.GetCurrentStorySequence()
    if a<TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL then
      vars.missionCode=10010
      vars.locationCode=TppDefine.LOCATION_ID.SSD_OMBS
    elseif a>=TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST and a<TppDefine.STORY_SEQUENCE.CLEARED_RETURN_TO_AFGH then
      vars.missionCode=30020
      vars.locationCode=TppDefine.LOCATION_ID.MAFR
      TppPlayer.ResetInitialPosition()
      TppPlayer.ResetMissionStartPosition()
    else
      vars.missionCode=30010
      vars.locationCode=TppDefine.LOCATION_ID.SSD_AFGH
      TppPlayer.ResetInitialPosition()
      TppPlayer.ResetMissionStartPosition()
    end
    this.VarSave()
    gvars.sav_skipRestoreToVars=true
  end
  TppVarInit.SetBuildingLevel()
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
function this.CheckPersonalSaveDataLoadResult()
  local n=TppScriptVars.GetLastResult()
  local a=this.SAVE_FILE_OK_RESULT_TABLE[n]
  if gvars.personalDataLoadingResult~=TppDefine.SAVE_FILE_LOAD_RESULT.OK and gvars.personalDataLoadingResult~=TppDefine.SAVE_FILE_LOAD_RESULT.NOT_EXIST_FILE then
    return
  end
  if a then
    local e=this.CheckSlotVersion(TppScriptVars.CATEGORY_PERSONAL)
    if e~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
      gvars.personalDataLoadingResult=e
    else
      gvars.personalDataLoadingResult=a
    end
  else
    if n==TppScriptVars.RESULT_ERROR_NOSPACE then
      gvars.personalDataLoadingResult=TppDefine.SAVE_FILE_LOAD_RESULT.DIFFER_FROM_CURRENT_VERSION
    else
      gvars.personalDataLoadingResult=TppDefine.SAVE_FILE_LOAD_RESULT.ERROR_LOAD_FAILED
    end
  end
end
function this.GetGameDataLoadingResult()
  return gvars.gameDataLoadingResult
end
if DebugMenu then
  function this.QARELEASE_DEBUG_Init()
    mvars.qaDebug.sav_forbidSave=false
    DebugMenu.AddDebugMenu(" SaveData","ForbidSave","bool",mvars.qaDebug,"sav_forbidSave")
    mvars.qaDebug.sav_permitSave=false
    DebugMenu.AddDebugMenu(" SaveData","PermitSave","bool",mvars.qaDebug,"sav_permitSave")
    mvars.qaDebug.sav_dumpSaveData=false
    DebugMenu.AddDebugMenu(" SaveData","DumpSaveData","bool",mvars.qaDebug,"sav_dumpSaveData")
    mvars.qaDebug.sav_loadDumpSaveData=false
    DebugMenu.AddDebugMenu(" SaveData","LoadDumpedSaveData","bool",mvars.qaDebug,"sav_loadDumpSaveData")
    mvars.qaDebug.sav_makeNewGameSaveData=false
    DebugMenu.AddDebugMenu(" SaveData","MakeNewGameSaveData","bool",mvars.qaDebug,"sav_makeNewGameSaveData")
    mvars.qaDebug.sav_cyprEndEntry=false
    DebugMenu.AddDebugMenu(" SaveData","GoCyprEndEntry","bool",mvars.qaDebug,"sav_cyprEndEntry")
    mvars.qaDebug.sav_makeFullOpenSaveData=false
    DebugMenu.AddDebugMenu(" SaveData","MakeFullOpenSaveData","bool",mvars.qaDebug,"sav_makeFullOpenSaveData")
    mvars.qaDebug.sav_deleteTemporaryGameFile=false
    DebugMenu.AddDebugMenu(" SaveData","DeleteTemopraryGameSaveFile","bool",mvars.qaDebug,"sav_deleteTemporaryGameFile")
    mvars.qaDebug.sav_deleteGameFile=false
    DebugMenu.AddDebugMenu(" SaveData","DeleteGameSaveFile","bool",mvars.qaDebug,"sav_deleteGameFile")
    mvars.qaDebug.sav_deleteConfigFile=false
    DebugMenu.AddDebugMenu(" SaveData","DeleteConfigFile","bool",mvars.qaDebug,"sav_deleteConfigFile")
    mvars.qaDebug.sav_deletePersonalDataFile=false
    DebugMenu.AddDebugMenu(" SaveData","DeletePersonalDataFile","bool",mvars.qaDebug,"sav_deletePersonalDataFile")
    mvars.qaDebug.sav_makeConfigFile=false
    DebugMenu.AddDebugMenu(" SaveData","MakeConfigFile","bool",mvars.qaDebug,"sav_makeConfigFile")DebugMenu.AddDebugMenu(" SaveData","reserveDestroySave","bool",gvars,"DEBUG_reserveDestroySaveData")
  end
  function this.QARELEASE_DEBUG_IsAvatarEditPlayer()
    if(vars.playerCamoType==PlayerCamoType.AVATAR_EDIT_MAN)or(vars.playerPartsType==PlayerPartsType.AVATAR_EDIT_MAN)then
      return true
    end
  end
  function this.QAReleaseDebugUpdate()
    local a=5
    local a=svars
    local a=mvars
    local n=DebugText.NewContext()
    if a.qaDebug.sav_forbidSave then
      a.qaDebug.sav_forbidSave=false
      this.ForbidSave()
    end
    if a.qaDebug.sav_permitSave then
      a.qaDebug.sav_permitSave=false
      gvars.sav_permitGameSave=true
    end
    if gvars.sav_permitGameSave==false then
      DebugText.Print(n,{1,.5,1},"Now forbid save mode!")
    end
    if a.qaDebug.sav_dumpSaveData then
      a.qaDebug.sav_dumpSaveData=false
      TppScriptVars.DEBUG_DumpVarsInSlot(TppDefine.SAVE_SLOT.SAVING,this.GetGameSaveFileName()..".lua")
      TppScriptVars.DEBUG_DumpVarsInSlot(TppDefine.SAVE_SLOT.CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME..".lua")
      TppScriptVars.DEBUG_DumpVarsInSlot(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME..".lua")
    end
    if a.qaDebug.sav_loadDumpSaveData then
      a.qaDebug.sav_loadDumpSaveData=false
      TppScriptVars.DEBUG_LoadDumpedVars(this.GetGameSaveFileName()..".lua")
      TppScriptVars.DEBUG_LoadDumpedVars(TppDefine.CONFIG_SAVE_FILE_NAME..".lua")
      this.VarSave(vars.missionCode,true)
      this.VarSaveOnRetry()
      this.SaveGameData(vars.missionCode)
      this.SaveConfigData()
    end
    if a.qaDebug.sav_makeNewGameSaveData then
      a.qaDebug.sav_makeNewGameSaveData=false
      if this.QARELEASE_DEBUG_IsAvatarEditPlayer()then
        return
      end
      this.MakeNewGameSaveData()
    end
    if a.qaDebug.sav_cyprEndEntry then
      a.qaDebug.sav_cyprEndEntry=false
      if not tpp_editor_menu2 then
        Script.LoadLibrary"/Assets/tpp/editor_scripts/tpp_editor_menu2.lua"
        Script.LoadLibrary"/Assets/tpp/script/entry/entry_prologue.lua"
        end
      entry_prologue.Bridge()
    end
    if a.qaDebug.sav_makeRescueMillerSaveData then
      a.qaDebug.sav_makeRescueMillerSaveData=false
      if this.QARELEASE_DEBUG_IsAvatarEditPlayer()then
        return
      end
    end
    if a.qaDebug.sav_makeFullOpenSaveData then
      a.qaDebug.sav_makeFullOpenSaveData=false
      if this.QARELEASE_DEBUG_IsAvatarEditPlayer()then
        return
      end
      TppStory.DEBUG_AllMissionOpen()
      this.VarSave(vars.missionCode,true)
      this.VarSaveOnRetry()
      this.SaveGameData()
    end
    if a.qaDebug.sav_deleteTemporaryGameFile then
      a.qaDebug.sav_deleteTemporaryGameFile=false
      this.DeleteTemporaryGameSaveFile()
    end
    if a.qaDebug.sav_deleteGameFile then
      a.qaDebug.sav_deleteGameFile=false
      this.DeleteGameSaveFile()
    end
    if a.qaDebug.sav_deleteConfigFile then
      a.qaDebug.sav_deleteConfigFile=false
      this.DeleteConfigSaveFile()
    end
    if a.qaDebug.sav_deletePersonalDataFile then
      a.qaDebug.sav_deletePersonalDataFile=false
      this.DeletePersonalDataSaveFile()
    end
    if a.qaDebug.sav_makeConfigFile then
      a.qaDebug.sav_makeConfigFile=false
      this.VarSaveConfig()
      this.SaveConfigData()
    end
  end
  function this.UpdateMotherBaseStaffWithoutCheckpointSave()
    TppTerminal.AddStaffsFromTempBuffer(true)
    this.VarSaveMbMangement(vars.missionCode)
    this.SaveGameData(vars.missionCode)
  end
  function this.QARELEASE_DEBUG_ExecuteReservedDestroySaveData()
    if gvars.DEBUG_reserveDestroySaveData then
      this.SaveGameData()
      this.QARELEASE_DEBUG_ExecuteReservedDestroySaveDataCount=3
      gvars.DEBUG_reserveDestroySaveData=false
    end
  end
end
return this
