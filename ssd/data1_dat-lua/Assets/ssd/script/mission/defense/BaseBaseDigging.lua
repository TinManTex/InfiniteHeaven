local this={}
local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local IsTypeNumber=Tpp.IsTypeNumber
local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID
local GAME_OBJECT_TYPE_ZOMBIE=TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local GAME_OBJECT_TYPE_ZOMBIE_BOM=TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM
function this.CreateInstance(missionName)
  if not IsTypeString(missionName)then
    return{}
  end
  local instance={}
  instance.missionName=missionName
  instance.radioSettings={startWave={"f3000_rtrg1502"},clearDefense={"f3000_rtrg1507"},failureDefense={"f3000_rtrg1509"}}
  instance.importantGimmickList=TppGimmick.GetBaseImportantGimmickList()
  instance.defenseStepList,instance.defenseStep=this.CreateBaseStep(instance)
  function instance.OnAllocate()
    SsdBaseDefense.RegisterStepList(instance.defenseStepList)
    SsdBaseDefense.RegisterStepTable(instance.defenseStep)
    SsdBaseDefense.RegisterSystemCallbacks{
      OnActivate=function()
        TppRadio.Stop()
      end,
      OnDeactivate=function()
      end,
      OnOutOfAcitveArea=function()
      end,
      OnGameStart=function(t)
        instance.waveIndex=t
        instance.totalWaveCount=SsdBaseDefense.GetTotalWaveCount()
        instance.waveSettings=this.CreateBaseWaveSettings(instance)
        local n=TppMission.GetFreePlayWaveSetting()
        TppMission.SetUpWaveSetting{n,{instance.waveSettings.waveList,instance.waveSettings.wavePropertyTable,instance.waveSettings.waveTable,instance.waveSettings.spawnPointDefine}}
        --RETAILPATCH: 1.0.5.0 removed
--        if instance.waveSettings.wavePropertyTable then
--          TppGimmick.SetDefenseTargetLevel(instance.waveSettings.wavePropertyTable)
--        end
        local currentWaveName=instance.GetCurrentWaveName()
        local n=TppMission.GetWaveProperty(currentWaveName)
        TppMission.SetInitialWaveName(currentWaveName)
        TppMission.StartDefenseGameWithWaveProperty(n)
        GameObject.SendCommand({type="SsdZombieShell"},{id="IgnoreVerticalShot",ignore=true})
      end,OnTerminate=function()
        GameObject.SendCommand({type="SsdZombieShell"},{id="IgnoreVerticalShot",ignore=false})
      end}
    if Fox.GetDebugLevel()>=Fox.DEBUG_LEVEL_QA_RELEASE then
      if instance.debugRadioLineTable then
        TppRadio.AddDebugRadioLineTable(instance.debugRadioLineTable)
      end
    end
    mvars[instance.missionName]={}mvars[instance.missionName].missionCode=string.sub(instance.missionName,-5)
  end
  function instance.GetCurrentWaveName()
    local n=instance.waveIndex
    if not IsTypeNumber(n)then
      return
    end
    local e=instance.waveSettings
    if not IsTypeTable(e)then
      return
    end
    local e=e.waveList
    if not IsTypeTable(e)then
      return
    end
    return e[n]
  end
  function instance.OnInitialize()
    SsdBaseDefense.OnInitialize(instance)
  end
  function instance.OnUpdate()
    SsdBaseDefense.OnUpdate(instance)
  end
  function instance.FinalizeDefenseGameWave()
    local e=instance.GetCurrentWaveName()
    if e then
      local e=TppMission.GetWaveProperty(e)
      local e=e.endEffectName or"explosion"
      TppEnemy.KillWaveEnemy{effectName=e,soundName="sfx_s_waveend_plasma"}
    end
    GameObject.SendCommand({type="TppCommandPost2"},{id="EndWave"})
  end
  function instance.ClearDefense()
    instance.FinalizeDefenseGameWave()
    SsdBaseDefense.SetNextStep"GameClear"
  end
  function instance.FailureDefense()
    instance.FinalizeDefenseGameWave()mvars[instance.missionName].failure=true
    SsdBaseDefense.SetNextStep"GameClear"
  end
  function instance.GetWaveLimitTime(e)
    return 180
  end
  function instance.OnTerminate()
    SsdBaseDefense.OnTerminate(instance)
    TppEnemy.SetUnrealAllFreeZombie(false)
    mvars[instance.missionName]=nil
  end
  return instance
end
function this.CreateBaseWaveSettings(n)
  local a=n.totalWaveCount
  local o=n.missionName
  local e={waveList={},wavePropertyTable={},waveTable={},spawnPointDefine={}}
  local t=2
  for a=1,a do
    local i=n.GetWaveLimitTime(a)
    local n=string.format("wave_%s_%03d",o,a)
    table.insert(e.waveList,n)
    e.wavePropertyTable[n]={
      limitTimeSec=i+t,
      defenseTimeSec=i+t,
      prepareTime=t,
      alertTimeSec=30,
      isTerminal=true,
      isBaseDigging=true,
      defensePosition=TppGimmick.GetCurrentLocationDiggerPosition(),
      defenseGameType=TppDefine.DEFENSE_GAME_TYPE.BASE,
      defenseTargetGimmickProperty={
        identificationTable={digger=TppGimmick.GetAfghBaseDiggerIdentifier()},
        alertParameters={needAlert=true,alertRadius=15}},
      finishType={type=TppDefine.DEFENSE_FINISH_TYPE.TIMER},waveTimerLangId="timer_info_defense_coop_endWave"}
    e.waveTable[n]={}
  end
  return e
end
function this.CreateBaseStep(e)
  local i={"GameDefense","GameClear",nil}
  local e={
    GameDefense={
      OnEnter=function(n)
        DefenceTelopSystem.SetInfo(mvars[e.missionName].missionCode,DefenceTelopType.Start)
        DefenceTelopSystem.RequestOpen()
        TppRadio.Play(e.radioSettings.startWave,{delayTime=2})
        TppEnemy.SetUnrealAllFreeZombie(true)
      end,
      Messages=function()
        return StrCode32Table{
          GameObject={
            {msg="FinishWave",func=function(n,n)
              e.ClearDefense()
            end},
            {msg="FinishDefenseGame",func=function()
              e.ClearDefense()
            end},
            {msg="FinishPrepareTimer",func=function()
              local e=e.GetCurrentWaveName()
              TppMission.StartInitialWave(e,true)
            end},
            {msg="BreakGimmick",func=function(a,t,i,i)
              if this.IsImportantGimmick(e,a,t)then
                e.FailureDefense()
              end
            end}},
          Block={
            {msg="OnChangeSmallBlockState",func=function()
              if not Tpp.IsBaseLoaded()then
                e.FailureDefense()
              end
            end}},
          Mission={
            {msg="AbandonBaseDefense",func=function()
              e.FailureDefense()
            end}}}
      end,
      OnLeave=function(e)
      end},
    GameClear={
      OnEnter=function(n)
        local e=not mvars[e.missionName].failure
        if e then
          SsdBaseDefense.StartRewardSequence(TppDefine.BASE_DEFENSE_CLEAR_TYPE.CLEAR)
        else
          SsdBaseDefense.StartRewardSequence(TppDefine.BASE_DEFENSE_CLEAR_TYPE.FAILURE)
        end
      end,
      OnLeave=function(e)
      end}}
  return i,e
end
function this.OpenRewardWormhole()
  local e=TppGimmick.baseImportantGimmickList.afgh[4]Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="SetRewardMode"}
  local n=TppGimmick.GetDiggerDefensePosition(TppGimmick.GetAfghBaseDiggerIdentifier())
  if not n then
    return
  end
  local n=Vector3(n[1],n[2]+20,n[3])Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="SetTargetPos",position=n}
  Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="Open"}
end
function this.CloseRewardWormhole()
  local e=TppGimmick.baseImportantGimmickList.afgh[4]Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="Close"}
end
function this.IsImportantGimmick(n,i,t)
  if not IsTypeTable(n.importantGimmickList)then
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
return this
