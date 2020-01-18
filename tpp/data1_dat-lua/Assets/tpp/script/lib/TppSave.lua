local e={}
local i=TppScriptVars.IsSavingOrLoading
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
function e.IsSaving()
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
local p=e.IsEnqueuedSaveData
function e.RegistCompositSlotSize(n)
e.COMPOSIT_SLOT_SIZE=n
end
function e.SetUpCompositSlot()
if e.COMPOSIT_SLOT_SIZE then
TppScriptVars.SetUpSlotAsCompositSlot(TppDefine.SAVE_SLOT.SAVING,e.COMPOSIT_SLOT_SIZE)
end
end
function e.SaveGameData(i,t,S,n,a)
if n then
e.ReserveNextMissionStartSave(e.GetGameSaveFileName(),a)
else
local n=e.GetSaveGameDataQueue(i,t,S,a)
e.EnqueueSave(n)
end
e.CheckAndSavePersonalData(n)
end
function e.GetSaveGameDataQueue(S,n,i,t)
local a=e.GetGameSaveFileName()
local n=e.GetIntializedCompositSlotSaveQueue(a,n,i,t)n=e._SaveGlobalData(n)n=e._SaveMissionData(n)n=e._SaveMissionRestartableData(n)n=e._SaveRetryData(n)n=e._SaveMbManagementData(n,S)n=e._SaveQuestData(n)
return n
end
function e.SaveConfigData(n,a,S)
if a then
local n=e.MakeNewSaveQueue(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,n)
return e.DoSave(n,true)
elseif S then
e.ReserveNextMissionStartSave(TppDefine.CONFIG_SAVE_FILE_NAME)
else
e.EnqueueSave(TppDefine.SAVE_SLOT.CONFIG,TppDefine.SAVE_SLOT.CONFIG_SAVE,TppScriptVars.CATEGORY_CONFIG,TppDefine.CONFIG_SAVE_FILE_NAME,n)
end
end
function e.SaveMGOData()
e.EnqueueSave(TppDefine.SAVE_SLOT.MGO,TppDefine.SAVE_SLOT.MGO_SAVE,TppScriptVars.CATEGORY_MGO,TppDefine.MGO_SAVE_FILE_NAME)
end
function e.SavePersonalData(n,a,S)
if a then
local n=e.MakeNewSaveQueue(TppDefine.SAVE_SLOT.PERSONAL,TppDefine.SAVE_SLOT.PERSONAL_SAVE,TppScriptVars.CATEGORY_PERSONAL,TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,n)
return e.DoSave(n,true)
elseif S then
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
e.DO_RESERVE_SAVE_FUNCTION={[TppDefine.CONFIG_SAVE_FILE_NAME]=e.SaveConfigData,[TppDefine.PERSONAL_DATA_SAVE_FILE_NAME]=e.SavePersonalData,[TppDefine.GAME_SAVE_FILE_NAME]=e.SaveGameData,[TppDefine.GAME_SAVE_FILE_NAME_TMP]=e.SaveGameData}
function e.ReserveNextMissionStartSave(a,S)
if not e.DO_RESERVE_SAVE_FUNCTION[a]then
return
end
e.missionStartSaveFilePool=e.missionStartSaveFilePool or{}
local n=e.missionStartSaveFilePool[a]or{}
if n and S then
n.isCheckPoint=S
end
e.missionStartSaveFilePool[a]=n
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
local e=e.DO_RESERVE_SAVE_FUNCTION[n]e(nil,nil,nil,nil,a.isCheckPoint)
end
e.missionStartSaveFilePool=nil
end
function e._SaveGlobalData(n)
if TppScriptVars.StoreUtcTimeToScriptVars then
TppScriptVars.StoreUtcTimeToScriptVars()
end
return e.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.GLOBAL,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_GAME_GLOBAL)
end
function e._SaveMissionData(n)
return e.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.CHECK_POINT,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_MISSION)
end
function e._SaveRetryData(n)
return e.AddSlotToSaveQueue(n,TppDefine.SAVE_SLOT.RETRY,TppDefine.SAVE_SLOT.SAVING,TppScriptVars.CATEGORY_RETRY)
end
function e.CanSaveMbMangementData(e)
local e=e or vars.missionCode
if(vars.fobSneakMode==FobMode.MODE_SHAM)then
return false
end
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
a=e.GetSaveGameDataQueue(vars.missionCode)n=e.DoSave(a,true)
end
if S then
e.CheckAndSavePersonalData()
end
return n
end
function e.GetIntializedCompositSlotSaveQueue(e,a,n,S)
return{fileName=e,needIcon=a,doSaveFunc=n,isCheckPoint=S}
end
function e.AddSlotToSaveQueue(e,a,n,S)
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
function e.EnqueueSave(n,S,t,r,i)
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
e.saveQueueDepth=e.saveQueueDepth+1
if a then
e.saveQueueList[e.saveQueueDepth]=a
else
e.saveQueueList[e.saveQueueDepth]=e.MakeNewSaveQueue(n,S,t,r,i)
end
end
function e.MakeNewSaveQueue(a,n,i,S,t,r)
local e={}
e.slot=a
e.savingSlot=n
e.category=i
e.fileName=S
e.needIcon=t
e.doSaveFunc=r
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
if not p()then
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
local t
local i
local S
local T
if Tpp.IsTypeTable(n.slot)then
e.SetUpCompositSlot()t=n.fileName
i=n.needIcon
S=n.doSaveFunc
T=n.isCheckPoint
for t,S in ipairs(n.slot)do
a=n.category[t]p=e.GetSaveFileVersion(a)
TppScriptVars.CopySlot({n.savingSlot,S},S)
end
else
a=n.category
if a then
p=e.GetSaveFileVersion(a)t=n.fileName
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
function e.Update()
if(not i())then
if(gvars.sav_SaveResultCheckFileName~=0)then
local a=true
local n=TppScriptVars.GetLastResult()
local n,S=e.GetSaveResultErrorMessage(n)
if n then
a=false
TppUiCommand.ShowErrorPopup(n,S)
end
local e=e.SAVE_RESULT_FUNCTION[gvars.sav_SaveResultCheckFileName]
if e then
e(a)
end
gvars.sav_SaveResultCheckFileName=0
gvars.sav_isCheckPointSaving=false
end
if not PatchDlc.IsCheckingPatchDlc()then
if e.IsEnqueuedSaveData()then
e.ProcessSaveQueue()
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
function e.OnMessage(p,r,t,i,S,n,a)
Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,p,r,t,i,S,n,a)
end
function e.WaitingAllEnqueuedSaveOnStartMission()
while i()do
e.CoroutineYieldWithShowSavingIcon()
end
while p()do
e.ProcessSaveQueue()
while i()do
e.CoroutineYieldWithShowSavingIcon()
end
end
end
function e.CoroutineYieldWithShowSavingIcon()
TppUI.ShowSavingIcon()coroutine.yield()
end
function e.SaveVarsToSlot(S,a,n)
local e=e.GetSaveFileVersion(n)
TppScriptVars.SaveVarsToSlot(S,a,n,e)
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
function e.LoadFromSaveFile(e,n)
return TppScriptVars.ReadSlotFromFile(e,n)
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
local n=e.GetGameSaveFileName()
return e.LoadFromSaveFile(TppDefine.SAVE_SLOT.SAVING,n)
end
local a={TppScriptVars.CATEGORY_GAME_GLOBAL,TppScriptVars.CATEGORY_MISSION,TppScriptVars.CATEGORY_RETRY,TppScriptVars.CATEGORY_MB_MANAGEMENT,TppScriptVars.CATEGORY_QUEST,TppDefine.CATEGORY_MISSION_RESTARTABLE}
function e.CheckGameDataVersion()
for a,n in ipairs(a)do
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
for e,n in ipairs(a)do
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
