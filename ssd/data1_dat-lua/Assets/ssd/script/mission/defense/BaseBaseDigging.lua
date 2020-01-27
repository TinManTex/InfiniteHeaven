local n={}
local e=Fox.StrCode32
local o=Tpp.StrCode32Table
local e=Tpp.IsTypeFunc
local a=Tpp.IsTypeTable
local e=Tpp.IsTypeString
local i=Tpp.IsTypeNumber
local t=GameObject.GetGameObjectId
local t=GameObject.NULL_ID
local t=TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local t=TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM
function n.CreateInstance(t)
if not e(t)then
return{}
end
local e={}
e.missionName=t
e.radioSettings={startWave={"f3000_rtrg1502"},clearDefense={"f3000_rtrg1507"},failureDefense={"f3000_rtrg1509"}}
e.importantGimmickList=TppGimmick.GetBaseImportantGimmickList()
e.defenseStepList,e.defenseStep=n.CreateBaseStep(e)
function e.OnAllocate()SsdBaseDefense.RegisterStepList(e.defenseStepList)SsdBaseDefense.RegisterStepTable(e.defenseStep)SsdBaseDefense.RegisterSystemCallbacks{OnActivate=function()
TppRadio.Stop()
end,OnDeactivate=function()
end,OnOutOfAcitveArea=function()
end,OnGameStart=function(t)
e.waveIndex=t
e.totalWaveCount=SsdBaseDefense.GetTotalWaveCount()
e.waveSettings=n.CreateBaseWaveSettings(e)
local n=TppMission.GetFreePlayWaveSetting()
TppMission.SetUpWaveSetting{n,{e.waveSettings.waveList,e.waveSettings.wavePropertyTable,e.waveSettings.waveTable,e.waveSettings.spawnPointDefine}}
if e.waveSettings.wavePropertyTable then
TppGimmick.SetDefenseTargetLevel(e.waveSettings.wavePropertyTable)
end
local e=e.GetCurrentWaveName()
local n=TppMission.GetWaveProperty(e)
TppMission.SetInitialWaveName(e)
TppMission.StartDefenseGameWithWaveProperty(n)
GameObject.SendCommand({type="SsdZombieShell"},{id="IgnoreVerticalShot",ignore=true})
end,OnTerminate=function()
GameObject.SendCommand({type="SsdZombieShell"},{id="IgnoreVerticalShot",ignore=false})
end}
if Fox.GetDebugLevel()>=Fox.DEBUG_LEVEL_QA_RELEASE then
if e.debugRadioLineTable then
TppRadio.AddDebugRadioLineTable(e.debugRadioLineTable)
end
end
mvars[e.missionName]={}mvars[e.missionName].missionCode=string.sub(e.missionName,-5)
end
function e.GetCurrentWaveName()
local n=e.waveIndex
if not i(n)then
return
end
local e=e.waveSettings
if not a(e)then
return
end
local e=e.waveList
if not a(e)then
return
end
return e[n]
end
function e.OnInitialize()SsdBaseDefense.OnInitialize(e)
end
function e.OnUpdate()SsdBaseDefense.OnUpdate(e)
end
function e.FinalizeDefenseGameWave()
local e=e.GetCurrentWaveName()
if e then
local e=TppMission.GetWaveProperty(e)
local e=e.endEffectName or"explosion"TppEnemy.KillWaveEnemy{effectName=e,soundName="sfx_s_waveend_plasma"}
end
GameObject.SendCommand({type="TppCommandPost2"},{id="EndWave"})
end
function e.ClearDefense()
e.FinalizeDefenseGameWave()SsdBaseDefense.SetNextStep"GameClear"end
function e.FailureDefense()
e.FinalizeDefenseGameWave()mvars[e.missionName].failure=true
SsdBaseDefense.SetNextStep"GameClear"end
function e.GetWaveLimitTime(e)
return 180
end
function e.OnTerminate()SsdBaseDefense.OnTerminate(e)
TppEnemy.SetUnrealAllFreeZombie(false)mvars[e.missionName]=nil
end
return e
end
function n.CreateBaseWaveSettings(n)
local a=n.totalWaveCount
local o=n.missionName
local e={waveList={},wavePropertyTable={},waveTable={},spawnPointDefine={}}
local t=2
for a=1,a do
local i=n.GetWaveLimitTime(a)
local n=string.format("wave_%s_%03d",o,a)
table.insert(e.waveList,n)
e.wavePropertyTable[n]={limitTimeSec=i+t,defenseTimeSec=i+t,prepareTime=t,alertTimeSec=30,isTerminal=true,isBaseDigging=true,defensePosition=TppGimmick.GetCurrentLocationDiggerPosition(),defenseGameType=TppDefine.DEFENSE_GAME_TYPE.BASE,defenseTargetGimmickProperty={identificationTable={digger=TppGimmick.GetAfghBaseDiggerIdentifier()},alertParameters={needAlert=true,alertRadius=15}},finishType={type=TppDefine.DEFENSE_FINISH_TYPE.TIMER},waveTimerLangId="timer_info_defense_coop_endWave"}
e.waveTable[n]={}
end
return e
end
function n.CreateBaseStep(e)
local i={"GameDefense","GameClear",nil}
local e={GameDefense={OnEnter=function(n)DefenceTelopSystem.SetInfo(mvars[e.missionName].missionCode,DefenceTelopType.Start)DefenceTelopSystem.RequestOpen()
TppRadio.Play(e.radioSettings.startWave,{delayTime=2})
TppEnemy.SetUnrealAllFreeZombie(true)
end,Messages=function()
return o{GameObject={{msg="FinishWave",func=function(n,n)
e.ClearDefense()
end},{msg="FinishDefenseGame",func=function()
e.ClearDefense()
end},{msg="FinishPrepareTimer",func=function()
local e=e.GetCurrentWaveName()
TppMission.StartInitialWave(e,true)
end},{msg="BreakGimmick",func=function(a,t,i,i)
if n.IsImportantGimmick(e,a,t)then
e.FailureDefense()
end
end}},Block={{msg="OnChangeSmallBlockState",func=function()
if not Tpp.IsBaseLoaded()then
e.FailureDefense()
end
end}},Mission={{msg="AbandonBaseDefense",func=function()
e.FailureDefense()
end}}}
end,OnLeave=function(e)
end},GameClear={OnEnter=function(n)
local e=not mvars[e.missionName].failure
if e then
SsdBaseDefense.StartRewardSequence(TppDefine.BASE_DEFENSE_CLEAR_TYPE.CLEAR)
else
SsdBaseDefense.StartRewardSequence(TppDefine.BASE_DEFENSE_CLEAR_TYPE.FAILURE)
end
end,OnLeave=function(e)
end}}
return i,e
end
function n.OpenRewardWormhole()
local e=TppGimmick.baseImportantGimmickList.afgh[4]Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="SetRewardMode"}
local n=TppGimmick.GetDiggerDefensePosition(TppGimmick.GetAfghBaseDiggerIdentifier())
if not n then
return
end
local n=Vector3(n[1],n[2]+20,n[3])Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="SetTargetPos",position=n}Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="Open"}
end
function n.CloseRewardWormhole()
local e=TppGimmick.baseImportantGimmickList.afgh[4]Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="Close"}
end
function n.IsImportantGimmick(n,i,t)
if not a(n.importantGimmickList)then
return
end
local function a(e,t,n)
if not e.gimmickId then
return
end
if not e.locatorName then
return
end
if not e.datasetName then
return
end
if Fox.StrCode32(e.locatorName)~=n then
return
end
local e=Gimmick.SsdGetGameObjectId{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName}
if(t==e)then
return true
else
return false
end
end
for n,e in pairs(n.importantGimmickList)do
if a(e,i,t)then
return true
end
end
end
return n
