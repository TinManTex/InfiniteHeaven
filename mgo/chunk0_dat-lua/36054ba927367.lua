local e={}
local S=TppScriptVars.IsSavingOrLoading
e.saveQueueDepth=0
e.saveQueueList={}
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
e.SAVE_RESULT_FUNCTION={[Fox.StrCode32(TppDefine.CONFIG_SAVE_FILE_NAME)]=function(e)
end,[Fox.StrCode32(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)]=function(e)
if e==false then
return
end
if(vars.isPersonalDirty==1)then
vars.isPersonalDirty=0
end
end,[Fox.StrCode32(TppDefine.GAME_SAVE_FILE_NAME)]=n,[Fox.StrCode32(TppDefine.GAME_SAVE_FILE_NAME_TMP)]=n}
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
function e.IsSaving(n)
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
function e.HasQueue(n)
for a=1,e.saveQueueDepth do
if e.saveQueueList[a].fileName==n then
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
function e.RegistCompositSlotSize(n)
e.COMPOSIT_SLOT_SIZE=n
end
function e.SetUpCompositSlot()
if e.COMPOSIT_SLOT_SIZE then
TppScriptVars.SetUpSlotAsCompositSlot(TppDefine.SAVE_SLOT.SAVING,e.COMPOSIT_SLOT_SIZE)
end
end
function e.SaveGameData(e,e,e,e)
end
function e.GetSaveGameDataQueue(e,e,e)
end
function e.SaveConfigData(n,a,t)
if a then
local n=e.MakeNewSaveQueue(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,n)
return e.DoSave(n,true)
elseif t then
e.ReserveNextMissionStartSave(TppDefine.CONFIG_SAVE_FILE_NAME)
else
e.EnqueueSave(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,n)
end
end
function e.SaveMGOData()
e.EnqueueSave(TppDefine.SAVE_SLOT.MGO,TppDefine.SAVE_SLOT.MGO_SAVE,TppScriptVars.CATEGORY_MGO,TppDefine.MGO_SAVE_FILE_NAME)
end
function e.SavePersonalData(n,a,t)
if a then
local n=e.MakeNewSaveQueue(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.SAVE_SLOT.PERSONAL_SAVE,TppScriptVars.CATEGORY_PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,n)
return e.DoSave(n,true)
elseif t then
e.ReserveNextMissionStartSave(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)
else
e.EnqueueSave(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.SAVE_SLOT.PERSONAL_SAVE,TppScriptVars.CATEGORY_PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,n)
end
end
function e.CheckAndSavePersonalData(a)
local n=TppDefine.PERSONAL_DATA_SAVE_FILE_NAME
if e.IsSavingWithFileName(n)or e.HasQueue(n)then
return
end
if(vars.isPersonalDirty==1)then
e.VarSavePersonalData()
e.SavePersonalData(nil,nil,a)
end
end
function e.SaveAvatarData()Player.SetEnableUpdateAvatarInfo(true)
e.VarSavePersonalData()
e.SavePersonalData()
end
function e.SaveOnlyMbManagement(a)
local n=vars.missionCode
e.VarSaveMbMangement(n)
e.SaveGameData(n,nil,a)
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
local n=vars.missionCode
e.VarSaveMbMangement(n)
e.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
e.DO_RESERVE_SAVE_FUNCTION={[TppDefine.CONFIG_SAVE_FILE_NAME]=e.SaveConfigData,[TppDefine.PERSONAL_DATA_SAVE_FILE_NAME]=e.SavePersonalData}
function e.ReserveNextMissionStartSave(n)
if not e.DO_RESERVE_SAVE_FUNCTION[n]then
return
end
e.missionStartSaveFilePool=e.missionStartSaveFilePool or{}
e.missionStartSaveFilePool[n]=true
end
function e.DoReservedSaveOnMissionStart()
if not e.missionStartSaveFilePool then
return
end
local n=Fox.GetPlatformName()
if n=="Xbox360"or n=="XboxOne"then
if not SignIn.IsSignedIn()then
e.missionStartSaveFilePool=nil
return
end
end
for n,a in pairs(e.missionStartSaveFilePool)do
local e=e.DO_RESERVE_SAVE_FUNCTION[n]e()
end
e.missionStartSaveFilePool=nil
end
function e._SaveGlobalData(n)
if TppScriptVars.StoreUtcTimeToScriptVars then
TppScriptVars.StoreUtcTimeToScriptVars()
end
return e.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.GLOBAL,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
function e._SaveMissionData(a)
local t,t,n,t=TppMission.GetSyncMissionStatus()
if n then
end
return e.AddSlotToSaveQueue(a,TppDefine.SAVE_SLOT.CHECK_POINT,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_MISSION)
end
function e._SaveRetryData(n)
return e.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.RETRY,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_RETRY)
end
function e.CanSaveMbMangementData(e)
local e=e or vars.missionCode
return(e~=10030)or(not gvars.isMissionClearedS10030)
end
function e._SaveMbManagementData(n,a)
return e.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_MB_MANAGEMENT)
end
function e._SaveQuestData(n)
return e.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.QUEST,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_QUEST)
end
function e._SaveMissionRestartableData(n)n=e.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.MISSION_START,TppDefine.SAVE_SLOT.SAVING,TppDefine.CATEGORY_MISSION_RESTARTABLE)n=e.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.CHECK_POINT_RESTARTABLE,TppDefine.SAVE_SLOT.SAVING,TppDefine.CATEGORY_MISSION_RESTARTABLE)
return n
end
function e.MakeNewGameSaveData(n)
TppVarInit.InitializeOnNewGameAtFirstTime()
TppVarInit.InitializeOnNewGame()
if n then
TppTerminal.AcquirePrivilegeInTitleScreen()
end
e.VarSave(vars.missionCode,true)
e.VarSaveOnRetry()
local a=e.GetSaveGameDataQueue(vars.missionCode)
local a=e.DoSave(a,true)
if n then
e.CheckAndSavePersonalData()
end
return a
end
function e.GetIntializedCompositSlotSaveQueue(a,n,e)
return{fileName=a,needIcon=n,doSaveFunc=e}
end
function e.AddSlotToSaveQueue(e,t,n,a)
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
function e.EnqueueSave(n,S,t,r,i)
if n==nil then
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
e.saveQueueDepth=e.saveQueueDepth+1
if a then
e.saveQueueList[e.saveQueueDepth]=a
else
e.saveQueueList[e.saveQueueDepth]=e.MakeNewSaveQueue(n,S,t,r,i)
end
end
function e.MakeNewSaveQueue(t,a,i,r,n,S)
local e={}
e.slot=t
e.savingSlot=a
e.category=i
e.fileName=r
e.needIcon=n
e.doSaveFunc=S
return e
end
function e.DequeueSave()
for n=1,(e.saveQueueDepth-1)do
e.saveQueueList[n]=e.saveQueueList[n+1]
end
e.saveQueueList[e.saveQueueDepth]=nil
e.saveQueueDepth=e.saveQueueDepth-1
end
function e.ProcessSaveQueue()
if not T()then
return false
end
local n=e.saveQueueList[1]
if n then
local n=e.DoSave(n)
if n~=nil then
e.DequeueSave()
if n==TppScriptVars.WRITE_FAILED then
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
function e.DoSave(n,a)
local r=true
if a then
r=false
end
local a
local p
local S
local i
local t
if Tpp.IsTypeTable(n.slot)then
e.SetUpCompositSlot()S=n.fileName
i=n.needIcon
t=n.doSaveFunc
for S,t in ipairs(n.slot)do
a=n.category[S]p=e.GetSaveFileVersion(a)
TppScriptVars.CopySlot({n.savingSlot,t},t)
end
else
a=n.category
if a then
p=e.GetSaveFileVersion(a)S=n.fileName
i=n.needIcon
t=n.doSaveFunc
TppScriptVars.CopySlot(n.savingSlot,n.slot)
else
return false
end
end
if t then
t()
end
local e=TppScriptVars.WriteSlotToFile(n.savingSlot,S,i)
if r then
gvars.sav_SaveResultCheckFileName=Fox.StrCode32(S)
end
return e
end
function e.Update()
if(not S())then
if(gvars.sav_SaveResultCheckFileName~=0)then
local n=true
local a=TppScriptVars.GetLastResult()
local a,t=e.GetSaveResultErrorMessage(a)
if a then
n=false
TppUiCommand.ShowErrorPopup(a,t)
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
if S()then
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
function e.GetSaveResultErrorMessage(n)
if n==TppScriptVars.RESULT_OK then
return
end
local e=e.SaveErrorMessageIdTable[n]
if e then
return e[1],e[2]
else
return TppDefine.ERROR_ID.SAVE_FAILED_UNKNOWN_REASON
end
end
function e.Init(n)
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnReload(n)
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.Messages()
return Tpp.StrCode32Table{UI={{msg="PopupClose",sender=TppDefine.ERROR_ID.CANNOT_FIND_STORAGE_IN_GAME,func=function()
e.ForbidSave()
end}}}
end
function e.OnMessage(n,a,t,S,i,p,r)
Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,n,a,t,S,i,p,r)
end
function e.WaitingAllEnqueuedSaveOnStartMission()
while S()do
e.CoroutineYieldWithShowSavingIcon()
end
while T()do
e.ProcessSaveQueue()
while S()do
e.CoroutineYieldWithShowSavingIcon()
end
end
end
function e.CoroutineYieldWithShowSavingIcon()
TppUI.ShowSavingIcon()coroutine.yield()
end
function e.SaveVarsToSlot(a,t,n)
local e=e.GetSaveFileVersion(n)
TppScriptVars.SaveVarsToSlot(a,t,n,e)
end
function e.VarSaveOnlyGlobalData()
e.SaveVarsToSlot(TppDefine.SAVE_SLOT.GLOBAL,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
function e.VarSave(e,e)
end
function e.VarSaveOnRetry()
e.SaveVarsToSlot(TppDefine.SAVE_SLOT.RETRY,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_RETRY)
end
function e.VarSaveMbMangement(n)
if e.CanSaveMbMangementData(n)then
e.SaveVarsToSlot(TppDefine.SAVE_SLOT.MB_MANAGEMENT,TppScriptVars.GROUP_BIT_ALL,TppScriptVars.CATEGORY_MB_MANAGEMENT)
end
end
function e.VarSaveQuest(n)
if e.CanSaveMbMangementData(n)then
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
function e.LoadFromSaveFile(n,e)
return TppScriptVars.ReadSlotFromFile(n,e)
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
end
local t={TppScriptVars.CATEGORY_GAME_GLOBAL,TppScriptVars.CATEGORY_MISSION,TppScriptVars.CATEGORY_RETRY,TppScriptVars.CATEGORY_MB_MANAGEMENT,TppScriptVars.CATEGORY_QUEST,TppDefine.CATEGORY_MISSION_RESTARTABLE}
function e.CheckGameDataVersion()
for a,n in ipairs(t)do
local a=TppDefine.SAVE_FILE_INFO[n].slot
local a=e.CheckSlotVersion(n,TppDefine.SAVE_SLOT.SAVING)
if a~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
return a
end
if TppDefine.SAVE_FILE_INFO[n].missionStartSlot then
local e=e.CheckSlotVersion(n,TppDefine.SAVE_SLOT.SAVING,true)
if e~=TppDefine.SAVE_FILE_LOAD_RESULT.OK then
return e
end
end
end
return TppDefine.SAVE_FILE_LOAD_RESULT.OK
end
function e.CopyGameDataFromSavingSlot()
for e,n in ipairs(t)do
local e=TppDefine.SAVE_FILE_INFO[n].slot
TppScriptVars.CopySlot(e,{TppDefine.SAVE_SLOT.SAVING,e})
local e=TppDefine.SAVE_FILE_INFO[n].missionStartSlot
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
function e.CheckSlotVersion(n,a,S)
if n==TppDefine.CATEGORY_MISSION_RESTARTABLE and TppDefine.CATEGORY_MISSION_RESTARTABLE==TppScriptVars.CATEGORY_MGO then
return TppDefine.SAVE_FILE_LOAD_RESULT.OK
end
local t=e.GetSaveFileVersion(n)
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
local a=TppScriptVars.GetLastResult()
local n=e.SAVE_FILE_OK_RESULT_TABLE[a]
if n then
local e=e.CheckGameDataVersion()
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
function e.GetGameDataLoadingResult()
return gvars.gameDataLoadingResult
end
return e
