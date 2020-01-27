local this={}
local s=Fox.StrCode32
local i=Tpp.StrCode32Table
local r=Tpp.IsTypeFunc
local n=Tpp.IsTypeTable
local m=Tpp.IsTypeString
local o=Tpp.IsTypeNumber
local S=GameObject.GetGameObjectId
local e=GameObject.GetGameObjectIdByIndex
local f=GameObject.NULL_ID
local a=GameObject.SendCommand
local e=Tpp.DEBUG_StrCode32ToString
local e=20
local e=3
local c="Timer_Player_Dead_to_Revival"
local G=60
local b=.05
local v=.0175
local T=60
local _=35
local e=10
local e=75
local e=30*60
local g=10
local E=180
local M=300
local D=8
local e=3
local h=3
local e={PRD_BLD_WeaponPlant={"PRD_BLD_WeaponPlant_A","PRD_BLD_WeaponPlant_B"},PRD_BLD_GadgetPlant={"PRD_BLD_GadgetPlant_A","PRD_BLD_GadgetPlant_B"},PRD_BLD_MedicalPlant={"PRD_BLD_MedicalPlant_A","PRD_BLD_MedicalPlant_B"},PRD_BLD_Kitchen={"PRD_BLD_Kitchen_A","PRD_BLD_Kitchen_B","PRD_BLD_Kitchen_C"},PRD_BLD_AmmoBox={"PRD_BLD_AmmoBox"}}local l={}local u={}local d={}for t,e in pairs(e)do
  for n,e in ipairs(e)do
    l[e]=t
    u[e]=n
    d[s(e)]=e
  end
end
function this.CreateInstance(missionName)
  local instance={}
  instance.MISSION_START_INITIAL_WEATHER=TppDefine.WEATHER.FOGGY
  instance.missionName=missionName
  instance.UNSET_PAUSE_MENU_SETTING={GamePauseMenu.RESTART_FROM_CHECK_POINT,GamePauseMenu.RESTART_FROM_MISSION_START}
  instance.INITIAL_INFINIT_OXYGEN=true
  instance.sequenceList={"Seq_Demo_SyncGameStart","Seq_Demo_HostAlreadyCleared","Seq_Game_Ready","Seq_Game_Stealth","Seq_Game_WaitStartDigger","Seq_Game_DefenseWave","Seq_Game_DefenseWaveWaitStartDigger","Seq_Game_DefenseBreakWaitRescue","Seq_Game_DefenseBreak","Seq_Game_EstablishClear","Seq_Game_RequestCoopEndToServer","Seq_Game_Clear"}function instance.OnLoad()TppSequence.RegisterSequences(instance.sequenceList)TppSequence.RegisterSequenceTable(instance.sequences)end
  instance.saveVarsList={waveCount=0}
  instance.checkPointList={"CHK_DefenseWave",nil}
  instance.baseList={nil}
  instance.CounterList={}
  instance.missionObjectiveDefine={marker_all_disable={},marker_target={gameObjectName="marker_target",visibleArea=0,randomRange=0,setNew=true,setImportant=true,goalType="moving",viewType="all"},marker_target_disable={}}
  instance.missionObjectiveTree={marker_all_disable={marker_target_disable={marker_target={}}}}
  instance.missionObjectiveEnumSource={"marker_all_disable","marker_target","marker_target_disable"}
  instance.missionObjectiveEnum=Tpp.Enum(instance.missionObjectiveEnumSource)function instance.MissionPrepare()
    if TppMission.IsHostmigrationProcessing()then
      instance.HostMigration_OnEnter()end
    local a={
      OnEstablishMissionClear=function(n)
        instance.OnStartDropReward()end,
      OnDisappearGameEndAnnounceLog=function(e)Player.SetPause()TppMission.ShowMissionReward()end,
      OnEndMissionReward=function()
        instance.OnMissionEnd()
        TppMission.SetNextMissionCodeForMissionClear(TppMission.GetCoopLobbyMissionCode())
        local e=TppMission.GetMissionClearType()
        TppMission.MissionFinalize{isNoFade=true}
      end,
      OnOutOfMissionArea=function()
        TppMission.ReserveGameOver(TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA,TppDefine.GAME_OVER_RADIO.S10020_OUT_OF_MISSION_AREA)end,nil}
    TppMission.RegiserMissionSystemCallback(a)
    mvars.bcm_radioScript=_G[tostring(missionName).."_radio"]
    mvars.bcm_enemyScript=_G[tostring(missionName).."_enemy"]
    local locationScriptName=_G[instance.locationScriptName]or{}
    instance.walkerGearNameList=instance.walkerGearNameList or locationScriptName.walkerGearNameList
    instance.wormholePointResourceTableList=instance.wormholePointResourceTableList or locationScriptName.wormholePointResourceTableList
    instance.startFogDensity=(instance.startFogDensity or locationScriptName.startFogDensity)or b
    instance.waveFogDensity=(instance.waveFogDensity or locationScriptName.waveFogDensity)or v
    instance.treasurePointTableList=instance.treasurePointTableList or locationScriptName.treasurePointTableList
    instance.treasureBoxTableList=instance.treasureBoxTableList or locationScriptName.treasureBoxTableList
    instance.ignoreLoadSmallBlocks=instance.ignoreLoadSmallBlocks or locationScriptName.ignoreLoadSmallBlocks
    instance.extraTargetGimmickTableListTable=instance.extraTargetGimmickTableListTable or locationScriptName.extraTargetGimmickTableListTable
    instance.craftGimmickTableTable=instance.craftGimmickTableTable or locationScriptName.craftGimmickTableTable
    instance.questGimmickTableListTable=instance.questGimmickTableListTable or locationScriptName.questGimmickTableListTable
    instance.stealthAreaNameTable=instance.stealthAreaNameTable or locationScriptName.stealthAreaNameTable
    instance.huntDownRouteNameTable=instance.huntDownRouteNameTable or locationScriptName.huntDownRouteNameTable
    instance.singularityEffectName=instance.singularityEffectName or locationScriptName.singularityEffectName
    instance.breakableGimmickTableList=instance.breakableGimmickTableList or locationScriptName.breakableGimmickTableList
    instance.impactAreaHeightOffset=instance.impactAreaHeightOffset or locationScriptName.impactAreaHeightOffset
    instance.impactAreaHeightRange=(instance.impactAreaHeightRange or locationScriptName.impactAreaHeightRange)or TppDefine.DEFAULT_IMPACKT_AREA_HEIGHT_RANGE
    instance.crewRescueAreaRadius=instance.crewRescueAreaRadius
    instance.waveFinishShockWaveRadius=instance.waveFinishShockWaveRadius
    FogWallController.SetEnabled(false)
    ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteOxygen",value=true}
    local t=instance.identifier
    local a=instance.defensePositionKey
    if t and a then
      local e=Tpp.GetLocator(t,a)
      mvars.bcm_defensePosition=e
    end
    SsdSbm.MakeInventoryTemporaryCopy()
    Mission.RequestCoopStartToServer()
    local t=instance.waveFinishShockWaveRadius or _
    Mission.SetDiggerShockWaveRadiusAtWaveFinish(t)
    local t=instance.GetDefensePosition()
    local t=Vector3(t[1],t[2],t[3])
    Mission.SetCrewRescueCenterPosition(t)
    local t=instance.crewRescueAreaRadius or g
    Mission.SetCrewRescueRadius(t)
    TppEffectUtility.SetEnemyRootView_Color(Vector4(.2,.5,1,.5))
    local t=instance.treasurePointTableList
    if n(t)then
      for n,e in ipairs(t)do
        Gimmick.SetTreasurePointResources(e)
      end
    end
    local t=instance.treasureBoxTableList
    if n(t)then
      for n,e in ipairs(t)do
        Gimmick.SetTreasureBoxResources(e)
      end
    end
    local t=instance.ignoreLoadSmallBlocks
    if n(t)then
      Mission.SetIgnoreLoadSmallStageBlocks(t)end
    local t=mvars.loc_locationWormhole
    if n(t)then
      local e=t.wormholePointTable
      if n(e)then
        for n,e in ipairs(e)do
          Gimmick.SetResourceValidity{name=e.name,dataSetName=e.dataSetName,validity=false}
        end
      end
    end
    local t=instance.wormholePointResourceTableList
    if n(t)then
      for n,e in ipairs(t)do
        Gimmick.SetWormholePointResources(e)
        Gimmick.SetResourceValidity{name=e.name,dataSetName=e.dataSetName,validity=true}
      end
    end
    local n=instance.defenseGameDataJsonFilePath
    if m(n)then
      Mission.LoadDefenseGameDataJson(n)else
      Mission.LoadDefenseGameDataJson"/Assets/ssd/level_asset/defense_game/debug/debug_c20010_test.json"end
    instance.defenseGameVariationIndex=Mission.GetDefenseGameVariationIndex()or 0
    instance.questVariationCount=instance.questVariationCount or h
    instance.waveVariationIndex=math.floor((instance.defenseGameVariationIndex+instance.questVariationCount)/instance.questVariationCount)
    local e=instance.AfterMissionPrepare
    if r(e)then
      e()end
  end
  function instance.OnStartDropReward()
    if mvars.bcm_isCalledOnStartDropReward then
      return
    end
    mvars.bcm_rewardOffsetTable={{-1,-1},
      {-1,-.5},
      {-1,0},
      {-1,.5},
      {-1,1},
      {-.5,1},
      {0,1},
      {.5,1},
      {1,1},
      {1,.5},
      {1,0},
      {1,-.5},
      {1,-1},
      {.5,-1},
      {0,-1}}
    GkEventTimerManager.Start("Timer_WaitStartCloseDigger",.5)
    TppGameStatus.Reset("TppMain.lua","S_DISABLE_PLAYER_PAD")
    Player.SetPadMask{settingName="BaseCoopMissionSequence",except=false,buttons=PlayerPad.SKILL}
    TppGameStatus.Reset("TppMain.lua","S_DISABLE_HUD")
    mvars.bcm_isCalledOnStartDropReward=true
  end
  function instance.OnTerminate()
    FogWallController.SetEnabled(true)
    ScriptParam.ResetValueToDefault{category=ScriptParamCategory.PLAYER,paramName="infiniteOxygen"}
    ResultSystem.RequestClose()
    CoopRewardSystem.RequestClose()
    TppUiCommand.ErasePopup()
    MapInfoSystem.ClearVisibleEnemyRouteInfos()
    TppEffectUtility.RemoveEnemyRootView()
    TppEffectUtility.SetEnemyRootView_Color(Vector4(.98,.7,.65,1))
    StageBlockCurrentPositionSetter.SetEnable(false)
    local e=instance.wormholePointResourceTableList
    if n(e)then
      for n,e in ipairs(e)do
        Gimmick.SetResourceValidity{name=e.name,dataSetName=e.dataSetName,validity=false}
      end
    end
    if Mission.IsLocalPlayerFromAutoMatching()then
      TppMission.DisconnectMatching(true)
    end
    if Mission.IsCoopTutorialMode()then
      TppMission.DisconnectMatching(true)
    end
  end
  function instance.OnGameOver()end
  function instance.OnBuddyBlockLoad()
    local n=instance.time
    if n then
      TppClock.SetTime(n)end
    local e=instance.startFogDensity
    TppWeather.ForceRequestWeather(TppDefine.WEATHER.FOGGY,.1,{fogDensity=e})
    WeatherManager.ClearTag("ssd_ClearSky",5)end
  function instance.OnRestoreSVars()mvars.waveCount=Mission.GetCurrentWaveCount()
    local t=instance.diggerLifeBreakSetting or{breakPoints={.75,.5,.25},radius=2}TppMission.SetDiggerLifeBreakSetting(t)
    local t=instance.fastTravelPointNameList
    if n(t)then
      for n,e in ipairs(t)do
        SsdFastTravel.InvisibleFastTravelPointGimmick(e,true)end
    end
    mvars.currentExtraTargetList={}Player.RequestToAppearWithWormhole(0)
    if TppLocation.IsMiddleAfrica()then
      local e=instance.walkerGearNameList
      if n(e)then
        for n,e in ipairs(e)do
          a(S(e),{id="SetColoringType",type=2})end
      end
    end
    local t=instance.extraTargetGimmickTableListTable
    if n(t)then
      for t,e in pairs(t)do
        if n(e)then
          for t,e in ipairs(e)do
            if n(e)then
              local t=e.locatorName
              local n=e.datasetName
              local e=e.type
              Gimmick.InvisibleGimmick(e,t,n,true)end
          end
        end
      end
    end
    local t=instance.craftGimmickTableTable
    if n(t)then
      for n,e in pairs(t)do
        if not e.visible then
          Gimmick.InvisibleGimmick(e.type,e.locatorName,e.datasetName,true)else
          local n=d[n]if n then
            local e=l[n]if e then
              if not mvars.builtProductionIdListTable then
                mvars.builtProductionIdListTable={}end
              if not mvars.builtProductionIdListTable[e]then
                mvars.builtProductionIdListTable[e]={}end
              table.insert(mvars.builtProductionIdListTable[e],n)end
          end
        end
      end
    end
    local t=instance.questGimmickTableListTable
    if n(t)then
      for t,e in pairs(t)do
        if n(e)then
          for t,e in ipairs(e)do
            if n(e)then
              Gimmick.InvisibleGimmick(e.type,e.locatorName,e.datasetName,true)end
          end
        end
      end
    end
    local n=instance.impactAreaHeightOffset
    if o(n)then
      ImpactAreaSystem.SetOffsetHeight(n)end
    local n=instance.impactAreaHeightRange
    if o(n)then
      ImpactAreaSystem.SetOffsetHeightRange(n)end
    local e=instance.AfterOnRestoreSVars
    if r(e)then
      e()end
  end
  function instance.OnEndMissionPrepareSequence()
    local t=instance.targetGimmickTable or{}if n(t)then
      local e=t.type
      local e=t.locatorName
      local n=t.datasetName
      Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=e,dataSetName=n,isActiveTarget=true,needAlert=false}Gimmick.SetAction{gimmickId="GIM_P_Digger",name=t.locatorName,dataSetName=t.datasetName,action="SetEffectBeam03",string1="dummy"}Gimmick.SetAction{gimmickId="GIM_P_Digger",name=t.locatorName,dataSetName=t.datasetName,action="SetEffectRewardWormholeVariation",string1="Middle_Blue"}end
    local t=instance.extraTargetGimmickTableListTable
    if n(t)then
      for t,e in pairs(t)do
        if n(e)then
          for s,a in ipairs(e)do
            if n(a)then
              local t=a.locatorName
              local e=a.datasetName
              Gimmick.SetAction{gimmickId="GIM_P_Digger",name=t,dataSetName=e,action="SetSupplyMode"}Gimmick.SetAction{gimmickId="GIM_P_Digger",name=t,dataSetName=e,action="SetEffectBeam01",string1="dummy"}Gimmick.SetAction{gimmickId="GIM_P_Digger",name=t,dataSetName=e,action="SetEffectDownwash01",string1="dummy"}Gimmick.SetAction{gimmickId="GIM_P_Digger",name=t,dataSetName=e,action="SetEffectBeam02",string1="BEAM01"}Gimmick.SetAction{gimmickId="GIM_P_Digger",name=t,dataSetName=e,action="SetEffectDownwash02",string1="Downwash01"}Gimmick.SetAction{gimmickId="GIM_P_Digger",name=t,dataSetName=e,action="SetEffectBeam03",string1="EnergyOuthole03"}Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=t,dataSetName=e,noTransfering=true}local i=a.extraTargetRadius or 30
              Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=t,dataSetName=e,isExtraTarget=true,extraTargetRadius=i}if Mission.IsBootedExtraDigger then
                local e=Mission.IsBootedExtraDigger{dataSetName=e,locatorName=t}if e then
                  if not n(mvars.currentExtraTargetList)then
                    mvars.currentExtraTargetList={}end
                  mvars.currentExtraTargetList[s]=true
                  local e=a.singularityEffectName
                  if e then
                    TppDataUtility.DestroyEffectFromGroupId(e)end
                end
              end
            end
          end
        end
      end
    end
    if instance.fixedTime then
      TppClock.Stop()end
    local t=instance.MISSION_WORLD_CENTER
    if t then
      StageBlockCurrentPositionSetter.SetEnable(true)StageBlockCurrentPositionSetter.SetPosition(t:GetX(),t:GetZ())end
    MapInfoSystem.SetupInfos()TppPlayer.SetInitialPositionToCurrentPosition()
    local t=instance.walkerGearNameList
    if n(t)then
      for n,e in ipairs(t)do
        local n=S("TppCommonWalkerGear2",e)
        local e={id="SetEnabled",enabled=false}a(n,e)end
    end
    for n,e in ipairs{TppDefine.ZOMBIE_TYPE_LIST,TppDefine.CREATURE_TYPE_LIST}do
      for n,e in ipairs(e)do
        if GameObject.DoesGameObjectExistWithTypeName(e)then
          a({type=e},
            {id="SetupCoopEXP"})end
      end
    end
    if n(instance.stealthAreaNameTable)then
      for e,n in pairs(instance.stealthAreaNameTable)do
        local e=SsdNpc.GetGameObjectIdFromNpcTypeCode32(e)
        if e~=f then
          a(e,{id="SetStealthArea",name=n})end
      end
    end
    local t=instance.huntDownRouteNameTable
    if n(t)then
      local e=SsdNpc.GetGameObjectIdFromNpcTypeName"Aerial"if e~=f then
        a(e,{id="SetHuntDownRoute",routes=t})end
    end
    mvars.retentionExtraTargetTable=nil
    for n,e in ipairs(TppDefine.ZOMBIE_TYPE_LIST)do
      local e={type=e}a(e,{id="SetGatherRange",run=512,dash=256})end
    local n={TppDefine.ZOMBIE_TYPE_LIST.SsdZombieBom,TppDefine.ZOMBIE_TYPE_LIST.SsdZombieArmor,TppDefine.ZOMBIE_TYPE_LIST.SsdZombiePack}for n,e in ipairs(TppDefine.ZOMBIE_TYPE_LIST)do
      local e={type=e}a(e,{id="SetDrawLifeRangeInCoop",range=5})end
    local n=instance.AfterOnEndMissionPrepareSequence
    if r(n)then
      n()end
    NamePlateMenu.SetBeginnerNamePlateIfTutorialUnfinied()end
  instance.GameStateToGameSequence={[Mission.DEFENSE_STATE_NONE]="Seq_Game_Ready",[Mission.DEFENSE_STATE_PREPARE]="Seq_Game_Ready",[Mission.DEFENSE_STATE_WAVE]="Seq_Game_DefenseWave",[Mission.DEFENSE_STATE_RESCUE_PREPARE]="Seq_Game_DefenseWaveWaitStartDigger",[Mission.DEFENSE_STATE_RESCUE]="Seq_Game_DefenseBreakWaitRescue",[Mission.DEFENSE_STATE_WAVE_INTERVAL]="Seq_Game_DefenseBreak",[Mission.DEFENSE_STATE_ESCAPE]="Seq_Game_EstablishClear",[Mission.DEFENSE_STATE_RESULT]="Seq_Game_Clear"}function instance.GetGameSequenceFromDefenseGameState()
    local n=Mission.GetDefenseGameState()
    return instance.GameStateToGameSequence[n]end
  function instance.StartWave(n)
    local e=instance.GetDefensePosition()
    if e then
      TppMission.SetDefensePosition(e)end
    for t,n in ipairs{TppDefine.ZOMBIE_TYPE_LIST,TppDefine.CREATURE_TYPE_LIST}do
      for t,n in ipairs(n)do
        if GameObject.DoesGameObjectExistWithTypeName(n)then
          local n={type=n}a(n,{id="SetWaveAttacker",pos=e,radius=512})
          a(n,{id="SetDefenseAi",active=true})end
      end
    end
    Mission.SetAttackToRescueTarget{enable=true}Mission.StartWave()end
  function instance.GetDefensePosition()return mvars.bcm_defensePosition
  end
  function instance.AddMissionObjective(e)
    if not mvars.missionObjectiveTableList then
      mvars.missionObjectiveTableList={}end
    table.insert(mvars.missionObjectiveTableList,{langId=e})
    MissionObjectiveInfoSystem.Open()
    MissionObjectiveInfoSystem.SetTable(mvars.missionObjectiveTableList)end
  function instance.CheckMissionObjective(e)
    if mvars.missionObjectiveTableList then
      for t,n in ipairs(mvars.missionObjectiveTableList)do
        if n.langId==e then
          MissionObjectiveInfoSystem.Check{langId=e,checked=true}
          table.remove(mvars.missionObjectiveTableList,t)
          MissionObjectiveInfoSystem.Open()
          MissionObjectiveInfoSystem.SetTable(mvars.missionObjectiveTableList)break
        end
      end
    end
  end
  function instance.ClearMissionObjective()
    mvars.missionObjectiveTableList={}
    MissionObjectiveInfoSystem.Clear()end
  function instance.OnMissionEnd()
    if mvars.isCalledOnMissionEnd then
      return
    end
    mvars.isCalledOnMissionEnd=true
    SsdSbm.ClearResourcesInInventory()
    local t=instance.fastTravelPointNameList
    if n(t)then
      for n,e in ipairs(t)do
        SsdFastTravel.InvisibleFastTravelPointGimmick(e,false)end
    end
    Player.ResetPadMask{settingName="BaseCoopMissionSequence"}
    TppMission.MissionGameEnd()end
  instance.messageTable={Player={
    {msg="Dead",func=function(e)
      if e==PlayerInfo.GetLocalPlayerIndex()then
        if GkEventTimerManager.IsTimerActive(c)then
          GkEventTimerManager.Stop(c)end
        GkEventTimerManager.Start(c,G)end
    end},
    {msg="WarpEnd",func=function()TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED,"RestartRevivePlayer")end}},
  GameObject={
    {msg="DiggerDrumRollStart",func=function()
      if TppSequence.GetCurrentSequenceName()=="Seq_Game_Clear"then
        GkEventTimerManager.Start("Timer_OpenResult",26.709483)TppMusicManager.PostJingleState"Set_State_ssd_jin_WaveComp_out"end
    end,option={isExecMissionClear=true}},
    {msg="ResortieCountDownEnd",func=function()TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"StartAutoRevivePlayer")end},
    {msg="DiggingStartEffectEnd",func=function()
      if TppSequence.GetCurrentSequenceIndex()<TppSequence.GetSequenceIndex"Seq_Game_EstablishClear"then
        return
      end
      GkEventTimerManager.Start("Timer_Reward",9.2)
      if not GkEventTimerManager.IsTimerActive"Timer_OpenResult"then
        GkEventTimerManager.Start("Timer_OpenResult",10)end
      CoopScoreSystem.StartDiggerChargeEnagy{chargeTime=6}
      GkEventTimerManager.Start("Timer_Destroy_Reward_Singularity",5.5)end,option={isExecMissionClear=true}},
    {msg="GameOverConfirm",func=function()
      instance.GoToGameOver(false)end,option={isExecGameOver=true}},
    {msg="FinishDefenseGame",func=function(n,n,n)
      if TppSequence.GetCurrentSequenceIndex()<TppSequence.GetSequenceIndex"Seq_Game_EstablishClear"then
        WavePopupSystem.RequestOpen{type=WavePopupType.ABORT_DEFENSE}
        instance.OnDefenseGameClear()end
    end},
    {msg="VotingResult",func=function(t,n)
      if n==Mission.VOTING_ESCAPE and TppSequence.GetCurrentSequenceIndex()<TppSequence.GetSequenceIndex"Seq_Game_EstablishClear"then
        if mvars.bcm_requestAbandon then
          return
        end
        mvars.votingResult=true
        WavePopupSystem.RequestOpen{type=WavePopupType.ABORT_DEFENSE}TppMusicManager.SetWaveOverrideEvent"DefenseResult"instance.OnDefenseGameClear()end
    end},
    {msg="SwitchGimmick",func=function(a,t,a,a)
      local e=instance.craftGimmickTableTable
      if n(e)then
        for n,e in pairs(e)do
          local e=e.locatorName
          if t==s(e)then
            SsdSbm.ShowSettlementReport()end
        end
      end
    end},
    {msg="DefenseChangeState",func=function(e,e)mvars.waveCount=Mission.GetCurrentWaveCount()end},
    {msg="DefenseTotatlResult",func=function(n,e)
      if mvars.bcm_requestAbandon then
        return
      end
      mvars.finalScore=e
      TppSequence.SetNextSequence"Seq_Game_EstablishClear"end},
    {msg="ClearDefenseGame",func=function()
      if mvars.isHostMigration then
        return
      end
      if TppSequence.GetCurrentSequenceIndex()>=TppSequence.GetSequenceIndex"Seq_Game_EstablishClear"then
        return
      end
    end},
    {msg="CompletedCoopTask",func=function(r,t,o)
      if t==TppDefine.COOP_TASK_REWARD_TYPE.IRI and Tpp.IsLocalPlayer(r)then
        Mission.AddEventScore(o)
      elseif t==TppDefine.COOP_TASK_REWARD_TYPE.AMMO_BOX or t==TppDefine.COOP_TASK_REWARD_TYPE.BUILDING then
        local i=instance.craftGimmickTableTable
        local r
        if n(i)then
          local a=i[o]if n(a)then
            local t=d[o]if t then
              local e=l[t]local o=u[t]if e and o then
                local a=mvars.builtProductionIdListTable
                if n(a)then
                  local e=a[e]if n(e)then
                    for m,a in ipairs(e)do
                      local t=u[a]if t<o then
                        local t=i[s(a)]if n(t)then
                          Gimmick.SetVanish{productionId=a,name=t.locatorName,dataSetName=t.datasetName}
                          table.remove(e,m)end
                      else
                        r=true
                      end
                    end
                  end
                end
                if not mvars.builtProductionIdListTable then
                  mvars.builtProductionIdListTable={}end
                if not mvars.builtProductionIdListTable[e]then
                  mvars.builtProductionIdListTable[e]={}end
                table.insert(mvars.builtProductionIdListTable[e],t)end
            end
            if not r then
              Gimmick.ResetGimmick(a.type,a.locatorName,a.datasetName,{needSpawnEffect=true})end
          end
        end
      elseif t==TppDefine.COOP_TASK_REWARD_TYPE.RECOVER_DIGGER_LIFE then
      elseif t==TppDefine.COOP_TASK_REWARD_TYPE.WALKERGEAR then
      end
      if Tpp.IsLocalPlayer(r)then
        for t,n in ipairs(mvars.missionObjectiveTableList)do
          if n.langId=="mission_common_objective_bringBack_questItem"then
            instance.CheckMissionObjective"mission_common_objective_bringBack_questItem"break
          end
        end
      end
    end},
    {msg="GetCoopObjective",func=function(n,t)
      if Tpp.IsLocalPlayer(n)then
        instance.AddMissionObjective"mission_common_objective_bringBack_questItem"end
    end},
    {msg="BuildingSpawnEffectEnd",func=function(a,t,t)
      local t=instance.extraTargetGimmickTableListTable
      if n(t)then
        local i=instance.questVariationCount
        local e=instance.waveVariationIndex
        local e=t[e]if n(e)then
          for i,e in ipairs(e)do
            if n(e)then
              local s=e.locatorName
              local t=e.datasetName
              local t=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name=s,dataSetName=t}
              if a==t then
                if not n(mvars.currentExtraTargetList)then
                  mvars.currentExtraTargetList={}end
                mvars.currentExtraTargetList[i]=true
                mvars.retentionExtraTargetTable=e
                if Mission.GetDefenseGameState()==Mission.DEFENSE_STATE_WAVE_INTERVAL then
                  TppMission.StopWaveInterval()end
                TppSequence.SetNextSequence"Seq_Game_WaitStartDigger"end
            end
          end
        end
      end
    end},
    {msg="BuyCoopQuestShop",func=function(t)
      if t==s"SHOP_GIMMICK"then
        local t=instance.questGimmickTableListTable
        if n(t)then
          local a=instance.questVariationCount
          local e=instance.waveVariationIndex
          local e=t[e]if n(e)then
            for t,e in ipairs(e)do
              if n(e)then
                Gimmick.ResetGimmick(e.type,e.locatorName,e.datasetName,{needSpawnEffect=true})end
            end
          end
        end
      elseif t==s"SHOP_AMMOBOX"then
        local e=instance.craftGimmickTableTable
        if n(e)then
          local e=e[s"PRD_BLD_AmmoBox"]if n(e)then
            Gimmick.ResetGimmick(e.type,e.locatorName,e.datasetName,{needSpawnEffect=true})end
        end
      elseif t==s"SHOP_WALKERGEAR"then
      elseif t==s"SHOP_METALGEAR_RAY"then
      end
    end}},Timer={
    {sender="Timer_WaitStartCloseDigger",msg="Finish",func=function()TopLeftDisplaySystem.RequestClose()
      instance.SetActionDigger{action="SetRewardMode"}
      instance.SetActionDigger{action="Open"}local n=instance.GetDefensePosition()
      local n=Vector3(n[1],n[2]+12,n[3])
      instance.SetActionDigger{action="SetTargetPos",position=n}end,option={isExecMissionClear=true}},
    {sender="Timer_Close_Digger",msg="Finish",func=function()
      instance.SetActionDigger{action="StopRewardWormhole"}GkEventTimerManager.Start("Timer_StartVanishDigger",13)end,option={isExecMissionClear=true}},
    {sender="Timer_Destroy_Reward_Singularity",msg="Finish",func=function()
      local e=instance.singularityEffectName
      if e then
        TppDataUtility.DestroyEffectFromGroupId(e)TppDataUtility.CreateEffectFromGroupId"destroy_singularity_reward"end
    end,option={isExecMissionClear=true}},
    {sender="Timer_Reward",msg="Finish",func=function()
      if not mvars.announceLogSuspended then
        TppUiStatusManager.UnsetStatus("AnnounceLog","SUSPEND_LOG")mvars.announceLogSuspended=true
      end
      local e=false
      if mvars.finalScore then
        if not mvars.currentRewardIndex then
          mvars.currentRewardIndex=0
        end
        if mvars.currentRewardIndex<D then
          e=Mission.DropCoopRewardBox(mvars.currentRewardIndex)table.remove(mvars.bcm_rewardOffsetTable,index)mvars.finalRewardDropped=true
          mvars.currentRewardIndex=mvars.currentRewardIndex+1
        end
      end
      if e then
        GkEventTimerManager.Start("Timer_Reward",.1)end
    end,option={isExecMissionClear=true}},
    {sender="Timer_OpenResult",msg="Finish",func=function()
      ResultSystem.OpenCoopResult()GkEventTimerManager.Start("Timer_Close_Digger",2)end,option={isExecMissionClear=true}},
    {sender="Timer_StartVanishDigger",msg="Finish",func=function()
      local e=instance.targetGimmickTable
      Gimmick.SetVanish{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName}Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=true}end,option={isExecMissionClear=true}},
    {sender="WaitCameraMoveEnd",msg="Finish",func=function()TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED,"RestartRevivePlayer")end}},UI={
      {msg="CoopMissionResultClosed",option={isExecMissionClear=true},func=function()
        instance.OnCloseResult()end},
      {msg="CoopRewardClosed",option={isExecMissionClear=true},func=function()
        instance.OnMissionEnd()end},
      {msg="EndFadeOut",sender="StartAutoRevivePlayer",func=function()
        local e={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}
        local n={id="Revive",revivalType="Respawn"}a(e,n)end},
      {msg="AbandonFromPauseMenu",func=function()mvars.bcm_requestAbandon=true
        TppUI.FadeOut(TppUI.FADE_SPEED.MOMENT)
        if Mission.IsJoinedCoopRoom()then
          TppMission.DisconnectMatching(true)else
          TppMission.AbandonMission()end
      end},
      {msg="TimeOutSyncCoopReward",option={isExecMissionClear=true},func=function()
        if mvars.bcm_requestGameOver or mvars.bcm_requestAbandon then
          return
        end
        instance.OnStartDropReward()end},
      {msg="TimeOutCoopResult",option={isExecMissionClear=true},func=function()
        instance.OnCloseResult()end},
      {msg="TimeOutCoopReward",option={isExecMissionClear=true},func=function()
        instance.OnMissionEnd()end},
      {msg="PopupClose",func=function(e)
        if e==5210 then
          TppMain.EnableAllGameStatus()TppMain.DisablePause()TppException.OnSessionDisconnectFromHost()end
      end},
      {msg="MiningMachineMenuPulloutOfRecoverySelected",func=function()
        if TppSequence.GetSequenceIndex"Seq_Game_Stealth"<TppSequence.GetCurrentSequenceIndex()then
          Mission.VoteEscape()mvars.isVotingResultEscape=true
        end
      end}},
    Network={
      {msg="StartHostMigration",func=function()
        instance.HostMigration_OnEnter()end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true}},
      {msg="FinishHostMigration",func=function(n)
        if n==0 then
          instance.HostMigration_Failed()else
          instance.HostMigration_OnLeave()end
      end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true}},
      {msg="SuccessedLeaveRoomAndSession",func=function()
        if mvars.bcm_requestAbandon then
          TppSequence.SetNextSequence"Seq_Game_EstablishClear"end
      end}},Trap={
      {sender="trap_collection",msg="Enter",func=function(n,e)
        if Tpp.IsLocalPlayer(e)then
          SsdSbm.ShowSettlementReport()end
      end}}}function instance.Messages()
    if n(instance.messageTable)then
      return i(instance.messageTable)else
      return{}end
      end
      function instance.OnCloseResult()
        if mvars.bcm_isCalledOnClseResult then
          return
        end
        mvars.bcm_isCalledOnClseResult=true
        CoopRewardSystem.RequestOpen()
        TppMusicManager.PostJingleState"Set_State_ssd_jin_WaveComp_none"
        TppUI.FadeOut()
        TppGameStatus.Set("TppMain.lua","S_DISABLE_PLAYER_PAD")end
      function instance.GoToGameOver(e)
        if mvars.bcm_requestAbandon then
          return
        end
        mvars.bcm_requestGameOver=true
        if e then
          mvars.bcm_gameOverType=TppDefine.GAME_OVER_TYPE.DEFENSE_TARGET_WAS_DESTROYED
          mvars.bmc_gameOverRadio=TppDefine.GAME_OVER_RADIO.TARGET_DEAD
        else
          mvars.bcm_gameOverType=TppDefine.GAME_OVER_TYPE.PLAYER_DEAD
          mvars.bmc_gameOverRadio=TppDefine.GAME_OVER_RADIO.PLAYER_DEAD
        end
        TppSequence.SetNextSequence("Seq_Game_EstablishClear",{isExecGameOver=true})end
      function instance.EnableExtraTargetMarker(a)
        local t=instance.extraTargetGimmickTableListTable
        if n(t)then
          local i=instance.questVariationCount
          local e=instance.waveVariationIndex
          local e=t[e]if n(e)then
            for s,e in ipairs(e)do
              if n(e)then
                local t=e.markerName
                local i=e.wave
                if(m(t)and((not n(i)or not o(a))or i[a]))and not mvars.currentExtraTargetList[s]then
                  TppMarker.Enable(t,0,"moving","all",0,true,false)
                  Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=false}end
              end
            end
          end
        end
      end
      function instance.DisableAllExtraTargetMarker()
        local t=instance.extraTargetGimmickTableListTable
        if n(t)then
          local a=instance.questVariationCount
          local e=instance.waveVariationIndex
          local e=t[e]if n(e)then
            for t,e in ipairs(e)do
              if n(e)then
                local n=e.markerName
                if m(n)then
                  TppMarker.Disable(n)Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=true}end
              end
            end
          end
        end
      end
      function instance.OnFinishFulton(n)
        if Mission.IsLastWave()then
          instance.OnDefenseGameClear()else
          TppSequence.SetNextSequence(n)end
      end
      function instance.OnDefenseGameClear()
        if mvars.bcm_requestAbandon then
          return
        end
        TppMission.StopDefenseTotalTime()end
      instance.sequences={}
      instance.sequences.Seq_Demo_SyncGameStart={
        messageTable={Timer={
          {sender="Timer_SyncStart",msg="Finish",func=function()
            instance.SetStartMissionSequence()end}}},
        Messages=function(e)
          local e=e.messageTable
          if n(e)then
            return i(e)end
        end,
        OnEnter=function(e)GkEventTimerManager.Start("Timer_SyncStart",T)mvars.bcs_syncStartTime=Time.GetRawElapsedTimeSinceStartUp()end,DEBUG_TextPrint=function(n)
          local e=DebugText.NewContext()DebugText.Print(e,{.5,.5,1},n)end,
        OnUpdate=function(n)
          local t=Time.GetRawElapsedTimeSinceStartUp()-mvars.bcs_syncStartTime
          if DebugText then
            n.DEBUG_TextPrint(string.format("[Seq_Demo_SyncGameStart] Waiting coop member loading. : coop member wait time = %02.2f[s] : TIMEOUT = %02.2f[s]",t,T))end
          if not mvars.bcs_isReadyLocal and not Mission.IsCoopRequestBusy()then
            mvars.bcs_isReadyLocal=true
            Mission.SetIsReadyCoopMission(true)end
          if Mission.IsReadyCoopMissionAllMembers()then
            instance.SetStartMissionSequence()end
          TppUI.ShowAccessIconContinue()end,
        OnLeave=function()
          Mission.HostMigration_SetActive(true)end}
      function instance.SetStartMissionSequence()
        TppMission.EnableInGameFlag()
        if Mission.CanJoinSession()then
          TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED,"StartMainGame")
          TppSequence.SetNextSequence(instance.GetGameSequenceFromDefenseGameState())else
          TppSequence.SetNextSequence"Seq_Demo_HostAlreadyCleared"end
      end
      instance.sequences.Seq_Demo_HostAlreadyCleared={
        OnEnter=function()TppMission.EnableInGameFlag()TppMission.DisconnectMatching(true)svars.mis_isDefiniteMissionClear=false
          mvars.mis_isReserveMissionClear=false
          TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.SESSION_DISCONNECT_FROM_HOST,Popup.TYPE_ONE_BUTTON)end,
        OnUpdate=function()
          if not TppUiCommand.IsShowPopup(TppDefine.ERROR_ID.SESSION_DISCONNECT_FROM_HOST)then
            TppMission.AbandonMission()end
        end}
      instance.sequences.Seq_Game_Ready={
        messageTable={
          Timer={
            {sender="Timer_Start",msg="Finish",func=function()
              TppSequence.SetNextSequence"Seq_Game_Stealth"end}}},
        Messages=function(e)
          local e=e.messageTable
          if n(e)then
            return i(e)end
        end,
        OnEnter=function()
          if TppMission.IsCoopMission(vars.missionCode)then
            if not(Mission.IsReadyCoopMissionHostMember()or mvars.isHostMigration)then
              TppMission.AbandonMission()return
            end
          end
          TppUiStatusManager.UnsetStatus("AnnounceLog","SUSPEND_LOG")
          GkEventTimerManager.Start("Timer_Start",5)
          local t=instance.extraTargetGimmickTableListTable
          if n(t)then
            local a=instance.questVariationCount
            local e=instance.waveVariationIndex
            local e=t[e]if n(e)then
              for n,e in ipairs(e)do
                Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=true}
                Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=true}end
            end
          end
        end}
      instance.sequences.Seq_Game_Stealth={
        messageTable={GameObject={
          {msg="DefenseChangeState",func=function(n,e)
            if e==TppDefine.DEFENSE_GAME_STATE.WAVE then
              TppSequence.SetNextSequence"Seq_Game_DefenseWave"end
          end}}},
        Messages=function(e)
          local e=e.messageTable
          if n(e)then
            return i(e)end
        end,
        OnEnter=function()
          local n=instance.prepareTime or M
          TppMission.StartDefenseGame(n)
          local n=instance.GetDefensePosition()
          if n then
            Mission.SetDefensePosition{pos=n}end
          Mission.SetPlacedDigger()Mission.EnableWaveEffect()
          instance.EnableExtraTargetMarker(1)
          instance.AddMissionObjective"mission_20105_objective_01"end,
        OnLeave=function()end}
      instance.sequences.Seq_Game_WaitStartDigger={Messages=function(e)
        return i{
          GameObject={
            {msg="DefenseChangeState",func=function(n,e)
              if e==TppDefine.DEFENSE_GAME_STATE.WAVE then
                TppSequence.SetNextSequence"Seq_Game_DefenseWave"end
            end},
            {msg="DiggingStartEffectEndCoop",func=function()
              mvars.waveCount=mvars.waveCount+1
              TppSequence.SetNextSequence"Seq_Game_DefenseWave"end},
            {msg="DiggerShootEffect",func=function(n,e)
              if e~=1 then
                return
              end
              GkEventTimerManager.Start("Timer_DestroySingularityEffect",6)end}},
          Timer={
            {msg="Finish",sender="Timer_DestroySingularityEffect",func=function()
              local e=mvars.retentionExtraTargetTable
              if e then
                local n=e.singularityEffectName
                local e=e.destroySingularityEffectName
                if n and e then
                  TppDataUtility.DestroyEffectFromGroupId(n)
                  TppDataUtility.CreateEffectFromGroupId(e)
                end
              end
            end}}}end,
      OnEnter=function(n)
        local n=Mission.GetRestWaveInterval()>.1
        local n=mvars.retentionExtraTargetTable
        if n then
          local e=n.locatorName
          local t=n.datasetName
          if n.dataIdentifierName and n.extraDiggerPositionName then
            local n,a=Tpp.GetLocatorByTransform(n.dataIdentifierName,n.extraDiggerPositionName)
            Gimmick.SetAction{gimmickId="GIM_P_Digger",name=e,dataSetName=t,action="SetTargetPos",position=n}
          end
          Gimmick.SetAction{gimmickId="GIM_P_Digger",name=e,dataSetName=t,action="Open"}
          Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e,dataSetName=t,powerOff=true}
        end
        instance.CheckMissionObjective"mission_20105_objective_01"
        instance.DisableAllExtraTargetMarker()end,
      OnLeave=function(e)end}
      instance.sequences.Seq_Game_DefenseWave={
        messageTable={
          UI={
            {msg="MiningMachineMenuRecoveryCrewSelected",func=function()
              Mission.StartRescuePrepare()end}},
          Timer={
            {sender="Timer_WaitExtraDiggerClose",msg="Finish",func=function()
              local e=mvars.retentionExtraTargetTable
              if e then
                local n=e.locatorName
                local e=e.datasetName
                Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=n,dataSetName=e,noTransfering=true}
                Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=n,dataSetName=e,isExtraTarget=true,isActiveTarget=false}
                Gimmick.SetAction{gimmickId="GIM_P_Digger",name=n,dataSetName=e,action="Close"}
              end
            end},
            {sender="Timer_WaitExtraDiggerVanish",msg="Finish",func=function()
              local e=mvars.retentionExtraTargetTable
              if e then
                local n=e.locatorName
                local e=e.datasetName
                Gimmick.SetVanish{gimmickId="GIM_P_Digger",name=n,dataSetName=e}
              end
            end}},
          GameObject={
            {msg="DefenseChangeState",func=function(n,e)
              if e==TppDefine.DEFENSE_GAME_STATE.PRE_RESCUE then
                TppSequence.SetNextSequence"Seq_Game_DefenseWaveWaitStartDigger"
              end
            end},
            {msg="EnableRescueCrew",func=function(n,n)
              if not mvars.isMissionObjectiveRescueCrew then
                instance.CheckMissionObjective"mission_20105_objective_02"
                instance.AddMissionObjective"mission_20105_objective_03"
                mvars.isMissionObjectiveRescueCrew=true
              end
            end},
            {msg="DisableRescueCrew",func=function(e,e)end}},nil},
        Messages=function(e)
          local t=e.messageTable
          if n(t)then
            return i(e.messageTable)end
        end,
        OnEnter=function(n)
          local t=mvars.waveCount
          instance.StartWave(t)
          WavePopupSystem.RequestOpen{type=WavePopupType.START,waveCount=t}
          instance.AddMissionObjective"mission_20105_objective_02"
          instance.DisableAllExtraTargetMarker()
          TppWeather.ForceRequestWeather(TppDefine.WEATHER.FOGGY,5,{fogDensity=instance.waveFogDensity})
          GkEventTimerManager.Start("Timer_WaitExtraDiggerClose",3)
          GkEventTimerManager.Start("Timer_WaitExtraDiggerVanish",13)
          TppMarker.Enable("marker_target",0,"moving","all",0,true,false)
          mvars.isMissionObjectiveRescueCrew=nil
          local e=n.AfterOnEnter
          if r(e)then
            e(n)end
        end,
        OnLeave=function(e)end}
      instance.sequences.Seq_Game_DefenseWaveWaitStartDigger={
        messageTable={
          GameObject={
            {msg="DefenseChangeState",func=function(n,e)
              if e==TppDefine.DEFENSE_GAME_STATE.RESCUE then
                TppSequence.SetNextSequence"Seq_Game_DefenseBreakWaitRescue"end
            end},
            {msg="DiggerShootEffect",func=function(n,e)
              if e~=1 then
                return
              end
              GkEventTimerManager.Start("Timer_DestroySingularityEffect",.9)
            end}},
          Timer={
            {msg="Finish",sender="Timer_DestroySingularityEffect",func=function()
              local e=instance.singularityEffectName
              if e then
                TppDataUtility.DestroyEffectFromGroupId(e)
                TppDataUtility.CreateEffectFromGroupId"destroy_singularity"
              end
            end}}},
        Messages=function(e)
          local e=e.messageTable
          if n(e)then
            return i(e)end
        end,
        OnEnter=function()
          local n=instance.targetGimmickTable
          Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=n.locatorName,dataSetName=n.datasetName,powerOff=true}
          Gimmick.SetAction{gimmickId="GIM_P_Digger",name=n.locatorName,dataSetName=n.datasetName,action="Open",offsetPosition=Vector3(0,12,0)}
          instance.CheckMissionObjective"mission_20105_objective_03"
          instance.AddMissionObjective"mission_20105_objective_04"
          local e=mvars.waveCount
          WavePopupSystem.RequestOpen{type=WavePopupType.RESCUE_PREPARE_START,waveCount=e}
        end,
        OnLeave=function()
          if mvars.bcm_requestGameOver or mvars.bcm_requestAbandon then
            return
          end
          a({type="TppCommandPost2"},
            {id="EndWave"})a({type="SsdZombie"},
            {id="SetDefenseAi",active=false})
            Mission.SetAttackToRescueTarget{enable=false}
            Mission.DiggerShockWave{type=TppDefine.DIGGER_SHOCK_WAVE_TYPE.FINISH_WAVE}
            TppSoundDaemon.PostEvent"sfx_s_waveend_plasma"
            if Mission.IsLastWave()then
              TppMusicManager.SetWaveOverrideEvent"DefenseResult"end
            a({type="TppCommandPost2"},
              {id="KillWaveEnemy"})
            local t=mvars.waveCount
            WavePopupSystem.RequestOpen{type=WavePopupType.FINISH,waveCount=t}
            if t==1 then
              local e=instance.breakableGimmickTableList
              if n(e)then
                for t,e in ipairs(e)do
                  if n(e)then
                    Gimmick.BreakGimmick(-1,e.locatorName,e.datasetName)
                  end
                end
              end
            end
        end}
      instance.sequences.Seq_Game_DefenseBreakWaitRescue={
        messageTable={
          GameObject={
            {msg="DefenseChangeState",func=function(t,n)
              if n~=TppDefine.DEFENSE_GAME_STATE.RESCUE then
                instance.OnFinishFulton"Seq_Game_DefenseBreak"end
            end},
            {msg="FinishRescueFulton",func=function(n)
              instance.OnFinishFulton"Seq_Game_DefenseBreak"end}},
          Timer={
            {sender="Timer_RescueCrewWormhole",msg="Finish",func=function()
              local e=instance.targetGimmickTable
              Gimmick.SetAction{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,action="StartRewardWormhole"}end}}},
        Messages=function(e)
          local e=e.messageTable
          if n(e)then
            return i(e)
          end
        end,
        OnEnter=function()
          GkEventTimerManager.Start("Timer_RescueCrewWormhole",3)
          instance.CheckMissionObjective"mission_20105_objective_04"
        end,
        OnLeave=function()
          local n=instance.targetGimmickTable
          Gimmick.SetAction{gimmickId="GIM_P_Digger",name=n.locatorName,dataSetName=n.datasetName,action="StopRewardWormhole"}
          Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=n.locatorName,dataSetName=n.datasetName,powerOff=false}
          Gimmick.SetAction{gimmickId="GIM_P_Digger",name=n.locatorName,dataSetName=n.datasetName,action="Close"}
          local n=instance.singularityEffectName
          if n then
            TppDataUtility.CreateEffectFromGroupId(n)
          end
          mvars.isFog=true
          if not mvars.bcm_requestGameOver and not mvars.votingResult then
            if TppSequence.GetCurrentSequenceName()=="Seq_Game_EstablishClear"then
              ResultSystem.OpenPopupResult()
              mvars.isFog=false
            end
          end
          if mvars.isFog==true then
            TppWeather.ForceRequestWeather(TppDefine.WEATHER.FOGGY,5,{fogDensity=instance.startFogDensity})end
        end}
      instance.sequences.Seq_Game_DefenseBreak={
        messageTable={
          GameObject={
            {msg="DefenseChangeState",func=function(n,e)
              if e==TppDefine.DEFENSE_GAME_STATE.WAVE then
                TppSequence.SetNextSequence"Seq_Game_DefenseWave"end
            end}},Timer={
            {sender="Timer_WaitSync",msg="Finish",func=function()
              TppPlayer.EnableSwitchIcon()end}}},
        Messages=function(e)
          local e=e.messageTable
          if n(e)then
            return i(e)end
        end,
        OnEnter=function()
          GkEventTimerManager.Start("Timer_WaitSync",10)
          TppPlayer.DisableSwitchIcon()
          local a=E
          local t=instance.intervalTimeTable
          if n(t)then
            local e=t[waveCount]if o(e)then
              a=e
            end
          end
          TppMission.StartWaveInterval(a)
          instance.EnableExtraTargetMarker(mvars.waveCount+1)
          TppMarker.Disable"marker_target"
          instance.AddMissionObjective"mission_20105_objective_01"end,
        OnLeave=function()TppPlayer.EnableSwitchIcon()end}
      instance.sequences.Seq_Game_EstablishClear={
        OnEnter=function(n)
          TppUiStatusManager.SetStatus("PauseMenu","INVALID")
          if not(mvars.bcm_requestGameOver or mvars.bcm_requestAbandon)then
            Mission.UpdateCoopMissionResult()end
          SsdSbm.RemoveWithoutTemporaryCopy()SsdSbm.StoreToSVars()n.SetClearType()
          if not(mvars.bcm_requestGameOver or mvars.bcm_requestAbandon)then
            if PlayerInfo.OrCheckStatus{PlayerStatus.DEAD,PL_F_NEAR_DEATH,PL_F_NEAR_DEAD}then
              local n={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}
              local e={id="Revive",revivalType="Bailout"}
              a(n,e)
            end
            a({type="SsdZombie"},
              {id="SetDefenseAi",active=false})
            Mission.SetAttackToRescueTarget{enable=false}
            TppMarker.Disable"marker_target"
            a({type="TppCommandPost2"},
              {id="KillWaveEnemy",target="AllWithoutBoss"})
            local e=instance.targetGimmickTable
            Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=true}
            Gimmick.SetAction{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,action="ResetAllEffects"}
            TppMusicManager.PostJingleState"Set_State_ssd_jin_WaveComp_on"
          end
          GkEventTimerManager.Start("Timer_WaitRewardAllMember",90)
          GkEventTimerManager.Start("Timer_WaitUpdateFinalScore",.1)
          instance.ClearMissionObjective()
          Gimmick.SetAllSwitchInvalid(true)
          SsdUiSystem.RequestForceCloseForMissionClear()
          TppException.SetSkipDisconnectFromHost()
          Mission.AddFinalizer(function()
            TppException.ResetSkipDisconnectFromHost()end)
        end,
        Messages=function(e)
          return i{
            Timer={
              {sender="Timer_WaitRewardAllMember",msg="Finish",func=function()
                TppSequence.SetNextSequence("Seq_Game_RequestCoopEndToServer",{isExecGameOver=true,isExecMissionClear=true})end,option={isExecGameOver=true,isExecMissionClear=true}},
              {sender="Timer_WaitUpdateFinalScore",msg="Finish",func=function()Mission.RequestCoopRewardToServer()end,option={isExecGameOver=true,isExecMissionClear=true}}}}
        end,
        OnUpdate=function()
          if not Mission.IsEndSynRewardAllMembers()then
            return
          end
          if mvars.bcm_requestAbandon then
            TppMission.AbandonMission()
            mvars.bcm_requestAbandon=false
          else
            TppSequence.SetNextSequence("Seq_Game_RequestCoopEndToServer",{isExecGameOver=true,isExecMissionClear=true})
          end
        end,
        SetClearType=function()
          if mvars.bcm_requestAbandon then
            gvars.mis_coopClearType=TppDefine.COOP_CLEAR_TYPE.ABORT
          elseif mvars.bcm_requestGameOver then
            gvars.mis_coopClearType=TppDefine.COOP_CLEAR_TYPE.FAILURE
          else
            gvars.mis_coopClearType=TppDefine.COOP_CLEAR_TYPE.CLEAR
          end
        end,
        OnLeave=function()end}
      instance.sequences.Seq_Game_RequestCoopEndToServer={
        OnEnter=function(e)
          Mission.RequestCoopEndToServer()e.isRequestedGameOver=false
        end,
        OnUpdate=function(e)
          if Mission.IsCoopRequestBusy()then
            return
          end
          if mvars.bcm_requestGameOver then
            if not e.isRequestedGameOver then
              TppMission.ReserveGameOver(mvars.bcm_gameOverType,mvars.bmc_gameOverRadio)
              e.isRequestedGameOver=true
            end
          else
            TppSequence.SetNextSequence("Seq_Game_Clear",{isExecMissionClear=true,isExecMissionClear=true})
          end
        end,
        OnLeave=function()end}
      instance.sequences.Seq_Game_Clear={
        OnEnter=function(e)TppMission.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppMission.GetCoopLobbyMissionCode()}
          MissionObjectiveInfoSystem.Clear()
        end}
      function instance.SetActionDigger(n)
        local e=instance.targetGimmickTable
        Gimmick.SetAction{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,action=n.action,param1=n.param1,position=n.position,offsetPosition=n.offsetPosition}
      end
      function instance.HostMigration_OnEnter()
        TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT)
        TppMain.DisableGameStatus()
        TppMain.EnablePause()
        mvars.isHostMigration=true
        TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"
        TppUiCommand.ShowErrorPopup(5209)
        if TppException.CanExceptionHandlingForFromHost()then
          if gvars.exc_processingExecptionType==TppDefine.ERROR_ID.SESSION_DISCONNECT_FROM_HOST then
            TppException.FinishProcess()end
        end
        TppUI.ShowAccessIcon()end
      function instance.HostMigration_OnLeave()
        TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED)
        TppMain.EnableAllGameStatus()
        TppMain.DisablePause()
        if TppUiCommand.IsShowPopup(5209)then
          TppUiCommand.ErasePopup()end
        mvars.isHostMigration=false
        TppUI.HideAccessIcon()end
      function instance.HostMigration_Failed()
        if TppUiCommand.IsShowPopup(5209)then
          TppUiCommand.ErasePopup()
        end
        TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON"
        TppUiCommand.ShowErrorPopup(5210)
      end
      return instance
end
return this
