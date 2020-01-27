local this={}
local e=Fox.StrCode32
local a=Tpp.StrCode32Table
local e=Tpp.IsTypeFunc
local e=Tpp.IsTypeTable
local c=Tpp.IsTypeString
local e=Tpp.IsTypeNumber
local e=GameObject.GetGameObjectId
local e=GameObject.GetGameObjectIdByIndex
local p=GameObject.NULL_ID
local e=GameObject.SendCommand
local e=Tpp.DEBUG_StrCode32ToString
local e=20
local e=3
local t="Timer_Player_Dead_to_Revival"
local l=60
local startFogDensityDefault=.05
local waveFogDensityDefault=.0175
local r=60
local _=35
local e=10
local e=75
local e=30*60
local T=180
local f=300
local d=8
local e=3
local g=3
local e={
  PRD_BLD_WeaponPlant={"PRD_BLD_WeaponPlant_A","PRD_BLD_WeaponPlant_B"},
  PRD_BLD_GadgetPlant={"PRD_BLD_GadgetPlant_A","PRD_BLD_GadgetPlant_B"},
  PRD_BLD_MedicalPlant={"PRD_BLD_MedicalPlant_A","PRD_BLD_MedicalPlant_B"},
  PRD_BLD_Kitchen={"PRD_BLD_Kitchen_A","PRD_BLD_Kitchen_B","PRD_BLD_Kitchen_C"},
  PRD_BLD_AmmoBox={"PRD_BLD_AmmoBox"}
}
local i={}
local s={}
local o={}
for a,e in pairs(e)do
  for n,e in ipairs(e)do
    i[e]=a
    s[e]=n
    o[Fox.StrCode32(e)]=e
  end
end
function this.CreateInstance(missionName)
  local instance={}
  instance.MISSION_START_INITIAL_WEATHER=TppDefine.WEATHER.FOGGY
  instance.missionName=missionName
  instance.UNSET_PAUSE_MENU_SETTING={GamePauseMenu.RESTART_FROM_CHECK_POINT,GamePauseMenu.RESTART_FROM_MISSION_START}
  instance.INITIAL_INFINIT_OXYGEN=true
  instance.sequenceList={
    "Seq_Demo_SyncGameStart",
    "Seq_Demo_HostAlreadyCleared",
    "Seq_Game_Ready",
    "Seq_Game_Stealth",
    "Seq_Game_WaitStartDigger",
    "Seq_Game_DefenseWave",
    "Seq_Game_DefenseBreak",
    "Seq_Game_EstablishClear",
    "Seq_Game_RequestCoopEndToServer",
    "Seq_Game_Clear"
  }
  function instance.OnLoad()
    TppSequence.RegisterSequences(instance.sequenceList)
    TppSequence.RegisterSequenceTable(instance.sequences)
  end
  instance.saveVarsList={waveCount=0}
  instance.checkPointList={"CHK_DefenseWave",nil}
  instance.baseList={nil}
  instance.CounterList={}
  instance.missionObjectiveDefine={
    marker_all_disable={},
    marker_target={gameObjectName="marker_target",visibleArea=0,randomRange=0,setNew=true,setImportant=true,goalType="moving",viewType="all"},
    marker_target_disable={}
  }
  instance.missionObjectiveTree={marker_all_disable={marker_target_disable={marker_target={}}}}
  instance.missionObjectiveEnumSource={"marker_all_disable","marker_target","marker_target_disable"}
  instance.missionObjectiveEnum=Tpp.Enum(instance.missionObjectiveEnumSource)
  function instance.MissionPrepare()
    if TppMission.IsHostmigrationProcessing()then
      instance.HostMigration_OnEnter()
    end
    local missionSystemCallback={
      OnEstablishMissionClear=function(n)
        instance.OnStartDropReward()
      end,
      OnDisappearGameEndAnnounceLog=function(e)
        Player.SetPause()
        TppMission.ShowMissionReward()
      end,
      OnEndMissionReward=function()
        instance.OnMissionEnd()
        TppMission.SetNextMissionCodeForMissionClear(TppMission.GetCoopLobbyMissionCode())
        if IS_GC_2017_COOP then
          TppMission.GameOverReturnToTitle()
          return
        end
        local e=TppMission.GetMissionClearType()
        TppMission.MissionFinalize{isNoFade=true}
      end,
      OnOutOfMissionArea=function()
        TppMission.ReserveGameOver(TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA,TppDefine.GAME_OVER_RADIO.S10020_OUT_OF_MISSION_AREA)
      end,
      nil
    }
    TppMission.RegiserMissionSystemCallback(missionSystemCallback)
    mvars.bcm_radioScript=_G[tostring(missionName).."_radio"]
    mvars.bcm_enemyScript=_G[tostring(missionName).."_enemy"]
    local locationScript=_G[instance.locationScriptName]or{}
    instance.walkerGearNameList=instance.walkerGearNameList or locationScript.walkerGearNameList
    instance.wormholePointResourceTableList=instance.wormholePointResourceTableList or locationScript.wormholePointResourceTableList
    instance.startFogDensity=(instance.startFogDensity or locationScript.startFogDensity)or startFogDensityDefault
    instance.waveFogDensity=(instance.waveFogDensity or locationScript.waveFogDensity)or waveFogDensityDefault
    instance.treasurePointTableList=instance.treasurePointTableList or locationScript.treasurePointTableList
    instance.treasureBoxTableList=instance.treasureBoxTableList or locationScript.treasureBoxTableList
    instance.ignoreLoadSmallBlocks=instance.ignoreLoadSmallBlocks or locationScript.ignoreLoadSmallBlocks
    instance.extraTargetGimmickTableListTable=instance.extraTargetGimmickTableListTable or locationScript.extraTargetGimmickTableListTable
    instance.craftGimmickTableTable=instance.craftGimmickTableTable or locationScript.craftGimmickTableTable
    instance.questGimmickTableListTable=instance.questGimmickTableListTable or locationScript.questGimmickTableListTable
    instance.stealthAreaNameTable=instance.stealthAreaNameTable or locationScript.stealthAreaNameTable
    instance.huntDownRouteNameTable=instance.huntDownRouteNameTable or locationScript.huntDownRouteNameTable
    instance.singularityEffectName=instance.singularityEffectName or locationScript.singularityEffectName
    instance.breakableGimmickTableList=instance.breakableGimmickTableList or locationScript.breakableGimmickTableList
    instance.impactAreaHeightOffset=instance.impactAreaHeightOffset or locationScript.impactAreaHeightOffset
    instance.impactAreaHeightRange=(instance.impactAreaHeightRange or locationScript.impactAreaHeightRange)or TppDefine.DEFAULT_IMPACKT_AREA_HEIGHT_RANGE
    instance.crewTargetList=instance.crewTargetList
    FogWallController.SetEnabled(false)
    ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteOxygen",value=true}
    local n=instance.identifier
    local a=instance.defensePositionKey
    if n and a then
      local e=Tpp.GetLocator(n,a)
      mvars.bcm_defensePosition=e
    end
    SsdSbm.MakeInventoryTemporaryCopy()
    Mission.RequestCoopStartToServer()
    local n=instance.waveFinishShockWaveRadius or _
    Mission.SetDiggerShockWaveRadiusAtWaveFinish(n)
    local n=instance.treasurePointTableList
    if Tpp.IsTypeTable(n)then
      for n,e in ipairs(n)do
        Gimmick.SetTreasurePointResources(e)
      end
    end
    local n=instance.treasureBoxTableList
    if Tpp.IsTypeTable(n)then
      for n,e in ipairs(n)do
        Gimmick.SetTreasureBoxResources(e)
      end
    end
    local n=instance.ignoreLoadSmallBlocks
    if Tpp.IsTypeTable(n)then
      Mission.SetIgnoreLoadSmallStageBlocks(n)
    end
    local n=mvars.loc_locationWormhole
    if Tpp.IsTypeTable(n)then
      local e=n.wormholePointTable
      if Tpp.IsTypeTable(e)then
        for n,e in ipairs(e)do
          Gimmick.SetResourceValidity{name=e.name,dataSetName=e.dataSetName,validity=false}
        end
      end
    end
    local n=instance.wormholePointResourceTableList
    if Tpp.IsTypeTable(n)then
      for n,e in ipairs(n)do
        Gimmick.SetWormholePointResources(e)
        Gimmick.SetResourceValidity{name=e.name,dataSetName=e.dataSetName,validity=true}
      end
    end
    local n=instance.defenseGameDataJsonFilePath
    if Tpp.IsTypeString(n)then
      Mission.LoadDefenseGameDataJson(n)
    else
      Mission.LoadDefenseGameDataJson"/Assets/ssd/level_asset/defense_game/debug/debug_c20010_test.json"
    end
    instance.defenseGameVariationIndex=Mission.GetDefenseGameVariationIndex()or 0
    instance.questVariationCount=instance.questVariationCount or g
    instance.waveVariationIndex=math.floor((instance.defenseGameVariationIndex+instance.questVariationCount)/instance.questVariationCount)
    local e=instance.AfterMissionPrepare
    if Tpp.IsTypeFunc(e)then
      e()
    end
  end--<instance.MissionPrepare
  function instance.OnStartDropReward()
    if mvars.bcm_isCalledOnStartDropReward then
      return
    end
    mvars.bcm_rewardOffsetTable={{-1,-1},{-1,-.5},{-1,0},{-1,.5},{-1,1},{-.5,1},{0,1},{.5,1},{1,1},{1,.5},{1,0},{1,-.5},{1,-1},{.5,-1},{0,-1}}
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
    StageBlockCurrentPositionSetter.SetEnable(false)
    local e=instance.wormholePointResourceTableList
    if Tpp.IsTypeTable(e)then
      for n,e in ipairs(e)do
        Gimmick.SetResourceValidity{name=e.name,dataSetName=e.dataSetName,validity=false}
      end
    end
    if Mission.IsLocalPlayerFromAutoMatching()then
      TppMission.DisconnectMatching(true)
    end
  end

  function instance.OnGameOver()
  end

  function instance.OnBuddyBlockLoad()
    local n=instance.time
    if n then
      TppClock.SetTime(n)
    end
    local e=instance.startFogDensity
    TppWeather.ForceRequestWeather(TppDefine.WEATHER.FOGGY,.1,{fogDensity=e})
    WeatherManager.ClearTag("ssd_ClearSky",5)
  end

  function instance.OnRestoreSVars()
    mvars.waveCount=svars.waveCount
    if mvars.waveCount>0 then
      mvars.continueFromDefenseBreak=true
    end
    local n=instance.diggerLifeBreakSetting or{breakPoints={.875,.75,.625,.5,.375,.25,.125},radius=2}
    TppMission.SetDiggerLifeBreakSetting(n)
    local n=instance.fastTravelPointNameList
    if Tpp.IsTypeTable(n)then
      for n,e in ipairs(n)do
        SsdFastTravel.InvisibleFastTravelPointGimmick(e,true)
      end
    end
    mvars.currentExtraTargetList={}
    Player.RequestToAppearWithWormhole(0)
    if TppLocation.IsMiddleAfrica()then
      local e=instance.walkerGearNameList
      if Tpp.IsTypeTable(e)then
        for n,e in ipairs(e)do
          GameObject.SendCommand(GameObject.GetGameObjectId(e),{id="SetColoringType",type=2})
        end
      end
    end
    local n=instance.extraTargetGimmickTableListTable
    if Tpp.IsTypeTable(n)then
      for n,e in pairs(n)do
        if Tpp.IsTypeTable(e)then
          for n,e in ipairs(e)do
            if Tpp.IsTypeTable(e)then
              local n=e.locatorName
              local a=e.datasetName
              local e=e.type
              Gimmick.InvisibleGimmick(e,n,a,true)
            end
          end
        end
      end
    end
    local n=instance.craftGimmickTableTable
    if Tpp.IsTypeTable(n)then
      for n,e in pairs(n)do
        if not e.visible then
          Gimmick.InvisibleGimmick(e.type,e.locatorName,e.datasetName,true)
        else
          local n=o[n]
          if n then
            local e=i[n]
            if e then
              if not mvars.builtProductionIdListTable then
                mvars.builtProductionIdListTable={}
              end
              if not mvars.builtProductionIdListTable[e]then
                mvars.builtProductionIdListTable[e]={}
              end
              table.insert(mvars.builtProductionIdListTable[e],n)
            end
          end
        end
      end
    end
    local n=instance.questGimmickTableListTable
    if Tpp.IsTypeTable(n)then
      for n,e in pairs(n)do
        if Tpp.IsTypeTable(e)then
          for n,e in ipairs(e)do
            if Tpp.IsTypeTable(e)then
              Gimmick.InvisibleGimmick(e.type,e.locatorName,e.datasetName,true)
            end
          end
        end
      end
    end
    local n=instance.impactAreaHeightOffset
    if Tpp.IsTypeNumber(n)then
      ImpactAreaSystem.SetOffsetHeight(n)
    end
    local n=instance.impactAreaHeightRange
    if Tpp.IsTypeNumber(n)then
      ImpactAreaSystem.SetOffsetHeightRange(n)
    end
    local e=instance.AfterOnRestoreSVars
    if Tpp.IsTypeFunc(e)then
      e()
    end
  end

  function instance.OnEndMissionPrepareSequence()
    local n=instance.extraTargetGimmickTableListTable
    if Tpp.IsTypeTable(n)then
      for n,e in pairs(n)do
        if Tpp.IsTypeTable(e)then
          for n,e in ipairs(e)do
            if Tpp.IsTypeTable(e)then
              local n=e.locatorName
              local a=e.datasetName
              Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=n,dataSetName=a,noTransfering=true}
              local e=e.extraTargetRadius or 30
              Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=n,dataSetName=a,isExtraTarget=true,extraTargetRadius=e}
            end
          end
        end
      end
    end
    if instance.fixedTime then
      TppClock.Stop()
    end
    local n=instance.MISSION_WORLD_CENTER
    if n then
      StageBlockCurrentPositionSetter.SetEnable(true)
      StageBlockCurrentPositionSetter.SetPosition(n:GetX(),n:GetZ())
    end
    MapInfoSystem.SetupInfos()
    TppPlayer.SetInitialPositionToCurrentPosition()
    local n=instance.walkerGearNameList
    if Tpp.IsTypeTable(n)then
      for n,e in ipairs(n)do
        local e=GameObject.GetGameObjectId("TppCommonWalkerGear2",e)
        local n={id="SetEnabled",enabled=false}
        GameObject.SendCommand(e,n)
      end
    end
    for n,e in ipairs{TppDefine.ZOMBIE_TYPE_LIST,TppDefine.CREATURE_TYPE_LIST}do
      for n,e in ipairs(e)do
        if GameObject.DoesGameObjectExistWithTypeName(e)then
          GameObject.SendCommand({type=e},{id="SetupCoopEXP"})
        end
      end
    end
    if Tpp.IsTypeTable(instance.stealthAreaNameTable)then
      for e,n in pairs(instance.stealthAreaNameTable)do
        local e=SsdNpc.GetGameObjectIdFromNpcTypeCode32(e)
        if e~=GameObject.NULL_ID then
          GameObject.SendCommand(e,{id="SetStealthArea",name=n})
        end
      end
    end
    local n=instance.huntDownRouteNameTable
    if Tpp.IsTypeTable(n)then
      local e=SsdNpc.GetGameObjectIdFromNpcTypeName"Aerial"
      if e~=GameObject.NULL_ID then
        GameObject.SendCommand(e,{id="SetHuntDownRoute",routes=n})
      end
    end
    mvars.retentionCrewName=nil
    for a,n in ipairs(instance.crewTargetList)do
      instance.SetCrewEnable(n,false)
    end
    for n,e in ipairs(TppDefine.ZOMBIE_TYPE_LIST)do
      local e={type=e}
      GameObject.SendCommand(e,{id="SetDrawLifeRangeInCoop",range=5})
      GameObject.SendCommand(e,{id="SetGatherRange",run=512,dash=256})
      GameObject.SendCommand(e,{id="SetRespawnFlagAll"})
      GameObject.SendCommand(e,{id="SetIgnoreRepawnFlagMode"})
    end
    local n=instance.AfterOnEndMissionPrepareSequence
    if Tpp.IsTypeFunc(n)then
      n()
    end
    NamePlateMenu.SetBeginnerNamePlateIfTutorialUnfinied()
  end
  instance.GameStateToGameSequence={
    [Mission.DEFENSE_STATE_NONE]="Seq_Game_Ready",
    [Mission.DEFENSE_STATE_PREPARE]="Seq_Game_Ready",
    [Mission.DEFENSE_STATE_WAVE]="Seq_Game_DefenseWave",
    [Mission.DEFENSE_STATE_WAVE_INTERVAL]="Seq_Game_DefenseBreak",
    [Mission.DEFENSE_STATE_ESCAPE]="Seq_Game_EstablishClear",
    [Mission.DEFENSE_STATE_RESULT]="Seq_Game_Clear"
  }
  function instance.GetGameSequenceFromDefenseGameState()
    local n=Mission.GetDefenseGameState()
    return instance.GameStateToGameSequence[n]
  end

  function instance.StartWave(n)
    local e=instance.GetDefensePosition()
    if e then
      TppMission.SetDefensePosition(e)
    end
    for a,n in ipairs{TppDefine.ZOMBIE_TYPE_LIST,TppDefine.CREATURE_TYPE_LIST}do
      for a,n in ipairs(n)do
        if GameObject.DoesGameObjectExistWithTypeName(n)then
          local n={type=n}
          GameObject.SendCommand(n,{id="SetWaveAttacker",pos=e,radius=512})
          GameObject.SendCommand(n,{id="SetDefenseAi",active=true})
        end
      end
    end
    Mission.SetAttackToRescueTarget{enable=true}
    Mission.StartWave()
  end

  function instance.GetDefensePosition()
    return mvars.bcm_defensePosition
  end

  function instance.AddMissionObjective(e)
    if not mvars.missionObjectiveTableList then
      mvars.missionObjectiveTableList={}
    end
    table.insert(mvars.missionObjectiveTableList,{langId=e})
    MissionObjectiveInfoSystem.Open()
    MissionObjectiveInfoSystem.SetTable(mvars.missionObjectiveTableList)
  end

  function instance.CheckMissionObjective(e)
    if mvars.missionObjectiveTableList then
      for a,n in ipairs(mvars.missionObjectiveTableList)do
        if n.langId==e then
          MissionObjectiveInfoSystem.Check{langId=e,checked=true}
          table.remove(mvars.missionObjectiveTableList,a)
          MissionObjectiveInfoSystem.Open()
          MissionObjectiveInfoSystem.SetTable(mvars.missionObjectiveTableList)break
        end
      end
    end
  end

  function instance.ClearMissionObjective()
    mvars.missionObjectiveTableList={}
    MissionObjectiveInfoSystem.Clear()
  end

  function instance.OnMissionEnd()
    if mvars.isCalledOnMissionEnd then
      return
    end
    mvars.isCalledOnMissionEnd=true
    SsdSbm.ClearResourcesInInventory()
    local n=instance.fastTravelPointNameList
    if Tpp.IsTypeTable(n)then
      for n,e in ipairs(n)do
        SsdFastTravel.InvisibleFastTravelPointGimmick(e,false)
      end
    end
    Player.ResetPadMask{settingName="BaseCoopMissionSequence"}
    TppMission.MissionGameEnd()
  end
  instance.messageTable={
    Player={
      {msg="Dead",func=function(e)
        if e==PlayerInfo.GetLocalPlayerIndex()then
          if GkEventTimerManager.IsTimerActive(t)then
            GkEventTimerManager.Stop(t)
          end
          GkEventTimerManager.Start(t,l)
        end
      end},
      {msg="WarpEnd",func=function()
        TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED,"RestartRevivePlayer")
      end}},

    GameObject={
      {msg="DiggerDrumRollStart",func=function()
        if TppSequence.GetCurrentSequenceName()=="Seq_Game_Clear"then
          GkEventTimerManager.Start("Timer_OpenResult",26.709483)
          TppMusicManager.PostJingleState"Set_State_ssd_jin_WaveComp_out"end
      end,option={isExecMissionClear=true}},
      {msg="ResortieCountDownEnd",func=function()
        TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"StartAutoRevivePlayer")
      end},
      {msg="BrokenMiningMachine",func=function(n,a)
        instance.BrokenMiningMachine(n,a)
      end},
      {msg="DiggingStartEffectEnd",func=function()
        if TppSequence.GetCurrentSequenceIndex()<TppSequence.GetSequenceIndex"Seq_Game_EstablishClear"then
          return
        end
        GkEventTimerManager.Start("Timer_Reward",9.2)
        if not GkEventTimerManager.IsTimerActive"Timer_OpenResult"then
          GkEventTimerManager.Start("Timer_OpenResult",10)
        end
        CoopScoreSystem.StartDiggerChargeEnagy{chargeTime=6}
        GkEventTimerManager.Start("Timer_Destroy_Reward_Singularity",5.5)
      end,option={isExecMissionClear=true}},
      {msg="GameOverConfirm",func=function()
        instance.GoToGameOver(false)
      end,option={isExecGameOver=true}},
      {msg="FinishDefenseGame",func=function(n,n,e)
        mvars.timeUp=true
        if e==1 then
          mvars.miningMachineBroken=true
        end
      end},
      {msg="VotingResult",func=function(a,n)
        if n==Mission.VOTING_ESCAPE and TppSequence.GetCurrentSequenceIndex()<TppSequence.GetSequenceIndex"Seq_Game_EstablishClear"then
          if mvars.bcm_requestAbandon then
            return
          end
          mvars.votingResult=true
          if WavePopupSystem and Tpp.IsTypeFunc(WavePopupSystem.RequestOpen)then
            WavePopupSystem.RequestOpen{type=WavePopupType.ABORT_DEFENSE}
          end
          instance.OnDefenseGameClear()
        end
      end},
      {msg="SwitchGimmick",func=function(a,n,a,a)
        local e=instance.craftGimmickTableTable
        if Tpp.IsTypeTable(e)then
          for a,e in pairs(e)do
            local e=e.locatorName
            if n==Fox.StrCode32(e)then
              SsdSbm.ShowSettlementReport()
            end
          end
        end
      end},
      {msg="DefenseChangeState",func=function(e,e)
        end},
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
        if mvars.waveCount==0 then
          return
        end
        if TppSequence.GetCurrentSequenceIndex()>=TppSequence.GetSequenceIndex"Seq_Game_EstablishClear"then
          return
        end
      end},
      {msg="FinishPrepareTimer",func=function()
        if TppSequence.GetCurrentSequenceIndex()<TppSequence.GetSequenceIndex"Seq_Game_WaitStartDigger"then
          instance.ResetDiggerGimmick()
          TppSequence.SetNextSequence"Seq_Game_WaitStartDigger"end
      end},
      {msg="CompletedCoopTask",func=function(r,n,a)
        if n==TppDefine.COOP_TASK_REWARD_TYPE.IRI and Tpp.IsLocalPlayer(r)then
          Mission.AddEventScore(a)
        elseif n==TppDefine.COOP_TASK_REWARD_TYPE.AMMO_BOX or n==TppDefine.COOP_TASK_REWARD_TYPE.BUILDING then
          local t=instance.craftGimmickTableTable
          local r
          if Tpp.IsTypeTable(t)then
            local n=t[a]
            if Tpp.IsTypeTable(n)then
              local a=o[a]
              if a then
                local e=i[a]
                local i=s[a]
                if e and i then
                  local n=mvars.builtProductionIdListTable
                  if Tpp.IsTypeTable(n)then
                    local a=n[e]
                    if Tpp.IsTypeTable(a)then
                      for o,e in ipairs(a)do
                        local n=s[e]
                        if n<i then
                          local n=t[Fox.StrCode32(e)]
                          if Tpp.IsTypeTable(n)then
                            Gimmick.SetVanish{productionId=e,name=n.locatorName,dataSetName=n.datasetName}
                            table.remove(a,o)
                          end
                        else
                          r=true
                        end
                      end
                    end
                  end
                  if not mvars.builtProductionIdListTable then
                    mvars.builtProductionIdListTable={}
                  end
                  if not mvars.builtProductionIdListTable[e]then
                    mvars.builtProductionIdListTable[e]={}
                  end
                  table.insert(mvars.builtProductionIdListTable[e],a)
                end
              end
              if not r then
                Gimmick.ResetGimmick(n.type,n.locatorName,n.datasetName,{needSpawnEffect=true})
              end
            end
          end
        elseif n==TppDefine.COOP_TASK_REWARD_TYPE.RECOVER_DIGGER_LIFE then
        elseif n==TppDefine.COOP_TASK_REWARD_TYPE.WALKERGEAR then
        end
        if Tpp.IsLocalPlayer(r)then
          for a,n in ipairs(mvars.missionObjectiveTableList)do
            if n.langId=="mission_common_objective_bringBack_questItem"then
              instance.CheckMissionObjective"mission_common_objective_bringBack_questItem"break
            end
          end
        end
      end},
      {msg="GetCoopObjective",func=function(n,a)
        if Tpp.IsLocalPlayer(n)then
          instance.AddMissionObjective"mission_common_objective_bringBack_questItem"end
      end},
      {msg="BuildingSpawnEffectEnd",func=function(i,n,n)
        local n=instance.extraTargetGimmickTableListTable
        if Tpp.IsTypeTable(n)then
          local a=instance.questVariationCount
          local a=instance.waveVariationIndex
          local n=n[a]
          if Tpp.IsTypeTable(n)then
            for s,n in ipairs(n)do
              if Tpp.IsTypeTable(n)then
                local t=n.locatorName
                local a=n.datasetName
                local o=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name=t,dataSetName=a}
                if i==o then
                  instance.DisableAllExtraTargetMarker()
                  if not Tpp.IsTypeTable(mvars.currentExtraTargetList)then
                    mvars.currentExtraTargetList={}
                  end
                  mvars.currentExtraTargetList[s]=true
                  mvars.retentionCrewName=n.crewName
                  if mvars.waveCount>0 then
                    TppMission.StopWaveInterval()
                  end
                  Gimmick.SetAction{gimmickId="GIM_P_Digger",name=t,dataSetName=a,action="Open",offsetPosition=Vector3(0,12,0)}
                  Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=t,dataSetName=a,powerOff=true}
                  TppSequence.SetNextSequence"Seq_Game_WaitStartDigger"
                end
              end
            end
          end
        end
      end},
      {msg="BuyCoopQuestShop",func=function(n)
        if mvars.waveCount>=3 then
          instance.OnDefenseGameClear()
        else
          TppSequence.SetNextSequence"Seq_Game_DefenseBreak"end
      end}},

    Timer={
      {sender="Timer_WaitStartCloseDigger",msg="Finish",func=function()
        TopLeftDisplaySystem.RequestClose()
        instance.SetActionDigger{action="SetRewardMode"}
        instance.SetActionDigger{action="Open"}
        local n=instance.GetDefensePosition()
        local n=Vector3(n[1],n[2]+12,n[3])
        instance.SetActionDigger{action="SetTargetPos",position=n}
      end,option={isExecMissionClear=true}},
      {sender="Timer_Close_Digger",msg="Finish",func=function()
        instance.SetActionDigger{action="StopRewardWormhole"}
        GkEventTimerManager.Start("Timer_StartVanishDigger",13)
      end,option={isExecMissionClear=true}},
      {sender="Timer_Destroy_Reward_Singularity",msg="Finish",func=function()
        local e=instance.singularityEffectName
        if e then
          TppDataUtility.DestroyEffectFromGroupId(e)
          TppDataUtility.CreateEffectFromGroupId"destroy_singularity_reward"end
      end,option={isExecMissionClear=true}},
      {sender="Timer_Reward",msg="Finish",func=function()
        if not mvars.announceLogSuspended then
          TppUiStatusManager.UnsetStatus("AnnounceLog","SUSPEND_LOG")
          mvars.announceLogSuspended=true
        end
        local e=false
        if mvars.finalScore then
          if not mvars.currentRewardIndex then
            mvars.currentRewardIndex=0
          end
          if mvars.currentRewardIndex<d then
            e=Mission.DropCoopRewardBox(mvars.currentRewardIndex)
            table.remove(mvars.bcm_rewardOffsetTable,index)
            mvars.finalRewardDropped=true
            mvars.currentRewardIndex=mvars.currentRewardIndex+1
          end
        end
        if e then
          GkEventTimerManager.Start("Timer_Reward",.1)
        end
      end,option={isExecMissionClear=true}},
      {sender="Timer_OpenResult",msg="Finish",func=function()ResultSystem.OpenCoopResult()GkEventTimerManager.Start("Timer_Close_Digger",2)
        end,option={isExecMissionClear=true}},
      {sender="Timer_StartVanishDigger",msg="Finish",func=function()
        local e=instance.targetGimmickTable
        Gimmick.SetVanish{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName}Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=true}
      end,option={isExecMissionClear=true}},
      {sender="WaitCameraMoveEnd",msg="Finish",func=function()
        TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED,"RestartRevivePlayer")
      end}},

    UI={{msg="MiningMachineMenuRequestPulloutSelected",func=function()
      if TppSequence.GetSequenceIndex"Seq_Game_Stealth"<TppSequence.GetCurrentSequenceIndex()then
        Mission.VoteEscape()
        mvars.isVotingResultEscape=true
      end
    end},
    {msg="MiningMachineMenuCancelPulloutSelected",func=function()
      end},
    {msg="CoopMissionResultClosed",option={isExecMissionClear=true},func=function()
      instance.OnCloseResult()
    end},
    {msg="CoopRewardClosed",option={isExecMissionClear=true},func=function()
      instance.OnMissionEnd()
    end},
    {msg="EndFadeOut",sender="StartAutoRevivePlayer",func=function()
      local e={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}
      local n={id="Revive",revivalType="Respawn"}
      GameObject.SendCommand(e,n)
    end},
    {msg="AbandonFromPauseMenu",func=function()
      mvars.bcm_requestAbandon=true
      TppUI.FadeOut(TppUI.FADE_SPEED.MOMENT)
      if Mission.IsJoinedCoopRoom()then
        TppMission.DisconnectMatching(true)
      else
        TppMission.AbandonMission()
      end
    end},
    {msg="TimeOutSyncCoopReward",option={isExecMissionClear=true},func=function()
      instance.OnStartDropReward()
    end},
    {msg="TimeOutCoopResult",option={isExecMissionClear=true},func=function()
      instance.OnCloseResult()
    end},
    {msg="TimeOutCoopReward",option={isExecMissionClear=true},func=function()
      instance.OnMissionEnd()
    end},
    {msg="GameOverMenuAutomaticallyClosed",option={isExecMissionClear=true},func=function()
      if IS_GC_2017_COOP then
        if TppSequence.GetCurrentSequenceIndex()<TppSequence.GetSequenceIndex"Seq_Game_EstablishClear"then
          local e={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}
          local n={id="Revive",revivalType="Respawn"}
          GameObject.SendCommand(e,n)
        else
          TppUI.FadeIn()
        end
      end
    end},
    {msg="PopupClose",func=function(e)
      if e==5210 then
        TppMain.EnableAllGameStatus()
        TppMain.DisablePause()
        TppException.OnSessionDisconnectFromHost()
      end
    end}},
    Network={{msg="StartHostMigration",func=function()
      instance.HostMigration_OnEnter()
    end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true}},
    {msg="FinishHostMigration",func=function(n)
      if n==0 then
        instance.HostMigration_Failed()
      else
        instance.HostMigration_OnLeave()
      end
    end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true}},
    {msg="SuccessedLeaveRoomAndSession",func=function()
      if mvars.bcm_requestAbandon then
        TppSequence.SetNextSequence"Seq_Game_EstablishClear"end
    end}},

    Trap={
      {sender="trap_collection",msg="Enter",func=function(n,e)
        if Tpp.IsLocalPlayer(e)then
          SsdSbm.ShowSettlementReport()
        end
      end}}}
  function instance.Messages()
    if Tpp.IsTypeTable(instance.messageTable)then
      return a(instance.messageTable)
    else
      return{}
    end
  end

  function instance.OnCloseResult()
    if mvars.bcm_isCalledOnClseResult then
      return
    end
    mvars.bcm_isCalledOnClseResult=true
    CoopRewardSystem.RequestOpen()
    TppMusicManager.PostJingleState"Set_State_ssd_jin_WaveComp_none"
    TppUI.FadeOut()
    TppGameStatus.Set("TppMain.lua","S_DISABLE_PLAYER_PAD")
  end

  function instance.GoToGameOver(e)
    if mvars.bcm_requestAbandon then
      return
    end
    if IS_GC_2017_COOP and(not e)then
      mvars.e3_bcm_gameover_isShowGameOver=true
      GameOverMenuSystem.SetType(GameOverType.Normal)
      GameOverMenuSystem.RequestOpen()
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
    TppSequence.SetNextSequence("Seq_Game_EstablishClear",{isExecGameOver=true})
  end

  function instance.SetWaveMistVisible(n,e)
    if e then
      Mission.EnableWaveEffect()
    else
      Mission.DisableWaveEffect()
    end
  end

  function instance.ResetDiggerGimmick()
    local n=instance.targetGimmickTable
    if Tpp.IsTypeTable(n)then
      if Gimmick.CanTransfering~=nil then
        local e=Gimmick.CanTransfering{gimmickId="GIM_P_Digger",name=n.locatorName,dataSetName=n.datasetName}
        if not e then
          return
        end
      end
      Gimmick.ResetGimmick(n.type,n.locatorName,n.datasetName,{needSpawnEffect=true})
      mvars.bcm_isAlreadySetupDigger=true
    end
    instance.CheckMissionObjective"mission_common_objective_putDigger"
    instance.AddMissionObjective"mission_common_objective_bootDigger"
  end

  function instance.BrokenMiningMachine(a,n)
    local n=instance.targetGimmickTable
    if Tpp.IsTypeTable(n)then
      local t=n.locatorName
      local n=n.datasetName
      local n=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name=t,dataSetName=n}
      if a==n then
        instance.DoBrokenMainDigger()
      else
        local n=instance.extraTargetGimmickTableListTable
        if Tpp.IsTypeTable(n)then
          local t=instance.questVariationCount
          local e=instance.waveVariationIndex
          local e=n[e]
          if Tpp.IsTypeTable(e)then
            for n,e in ipairs(e)do
              if Tpp.IsTypeTable(e)then
                local n=e.locatorName
                local e=e.datasetName
                local t=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name=n,dataSetName=e}
                if a==t then
                  Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=n,dataSetName=e,isExtraTarget=true,isActiveTarget=false}
                end
              end
            end
          end
        end
      end
    end
  end

  function instance.DoBrokenMainDigger()
    mvars.miningMachineBroken=true
    if mvars.waveCount and mvars.waveCount>0 then
      instance.OnDefenseGameClear()
    else
      local n,a=Gimmick.SsdGetPosAndRot{gameObjectId=gameObjectId}--RETAILBUG ORPHAN
      if n then
        local e=TppPlayer.GetDefenseTargetBrokenCameraInfo(n,a,locatorName,upperLocatorName)--RETAILBUG ORPHAN
        TppPlayer.ReserveDefenseTargetBrokenCamera(e)
      end
      instance.GoToGameOver(true)
    end
  end

  function instance.EnableExtraTargetMarker(a)
    local n=instance.extraTargetGimmickTableListTable
    if Tpp.IsTypeTable(n)then
      local t=instance.questVariationCount
      local e=instance.waveVariationIndex
      local e=n[e]
      if Tpp.IsTypeTable(e)then
        for i,e in ipairs(e)do
          if Tpp.IsTypeTable(e)then
            local n=e.markerName
            local t=e.wave
            if(Tpp.IsTypeString(n)and((not Tpp.IsTypeTable(t)or not Tpp.IsTypeNumber(a))or t[a]))and not mvars.currentExtraTargetList[i]then
              TppMarker.Enable(n,0,"moving","all",0,true,false)
              Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=false}
              local e=e.floatingSingularityEffectName
              if e then
                TppDataUtility.CreateEffectFromGroupId(e)
              end
            end
          end
        end
      end
    end
  end

  function instance.DisableAllExtraTargetMarker(a)
    local n=instance.extraTargetGimmickTableListTable
    if Tpp.IsTypeTable(n)then
      local t=instance.questVariationCount
      local e=instance.waveVariationIndex
      local e=n[e]
      if Tpp.IsTypeTable(e)then
        for n,e in ipairs(e)do
          if Tpp.IsTypeTable(e)then
            local n=e.markerName
            if Tpp.IsTypeString(n)then
              TppMarker.Disable(n)
              Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=true}
            end
            if a then
              local e=e.floatingSingularityEffectName
              if e then
                TppDataUtility.DestroyEffectFromGroupId(e)
              end
            end
          end
        end
      end
    end
  end

  function instance.SetCrewEnable(e,n)
    if c(e)then
      e=GameObject.GetGameObjectId(e)
    end
    if enemyName~=p then--RETAILBUG
      GameObject.SendCommand(e,{id="SetEnabled",enabled=n})
    end
  end

  function instance.SetZombieRespawnAll()
    for n,e in ipairs(TppDefine.ZOMBIE_TYPE_LIST)do
      local e={type=e}
      GameObject.SendCommand(e,{id="RespawnAll"})
    end
  end

  function instance.OnDefenseGameClear()
    if mvars.bcm_requestAbandon then
      return
    end
    TppMission.StopDefenseTotalTime()
  end
  instance.sequences={}
  instance.sequences.Seq_Demo_SyncGameStart={
    messageTable={
      Timer={
        {sender="Timer_SyncStart",msg="Finish",func=function()
          instance.SetStartMissionSequence()
        end}}},
    Messages=function(e)
      local e=e.messageTable
      if Tpp.IsTypeTable(e)then
        return a(e)
      end
    end,
    OnEnter=function(e)
      GkEventTimerManager.Start("Timer_SyncStart",r)
      mvars.bcs_syncStartTime=Time.GetRawElapsedTimeSinceStartUp()
    end,DEBUG_TextPrint=function(e)
      local n=DebugText.NewContext()
      DebugText.Print(n,{.5,.5,1},e)
    end,OnUpdate=function(a)
      local n=Time.GetRawElapsedTimeSinceStartUp()-mvars.bcs_syncStartTime
      if DebugText then
        a.DEBUG_TextPrint(string.format("[Seq_Demo_SyncGameStart] Waiting coop member loading. : coop member wait time = %02.2f[s] : TIMEOUT = %02.2f[s]",n,r))
      end
      if not mvars.bcs_isReadyLocal and not Mission.IsCoopRequestBusy()then
        mvars.bcs_isReadyLocal=true
        Mission.SetIsReadyCoopMission(true)
      end
      if Mission.IsReadyCoopMissionAllMembers()then
        instance.SetStartMissionSequence()
      end
      TppUI.ShowAccessIconContinue()
    end,
    OnLeave=function()
      Mission.HostMigration_SetActive(true)
    end}
  function instance.SetStartMissionSequence()
    TppMission.EnableInGameFlag()
    if Mission.CanJoinSession()then
      TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED,"StartMainGame")
      TppSequence.SetNextSequence(instance.GetGameSequenceFromDefenseGameState())
    else
      TppSequence.SetNextSequence"Seq_Demo_HostAlreadyCleared"end
  end
  instance.sequences.Seq_Demo_HostAlreadyCleared={
    OnEnter=function()
      TppMission.EnableInGameFlag()
      TppMission.DisconnectMatching(true)svars.mis_isDefiniteMissionClear=false
      mvars.mis_isReserveMissionClear=false
      TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.SESSION_DISCONNECT_FROM_HOST,Popup.TYPE_ONE_BUTTON)
    end,OnUpdate=function()
      if not TppUiCommand.IsShowPopup(TppDefine.ERROR_ID.SESSION_DISCONNECT_FROM_HOST)then
        TppMission.AbandonMission()
      end
    end}
  instance.sequences.Seq_Game_Ready={
    messageTable={
      Timer={
        {sender="Timer_Start",msg="Finish",func=function()
          TppSequence.SetNextSequence"Seq_Game_Stealth"
        end}}},
    Messages=function(e)
      local e=e.messageTable
      if Tpp.IsTypeTable(e)then
        return a(e)
      end
    end,
    OnEnter=function()
      if TppMission.IsCoopMission(vars.missionCode)then
        if not(Mission.IsReadyCoopMissionHostMember()or mvars.isHostMigration)then
          TppMission.AbandonMission()
          return
        end
      end
      TppUiStatusManager.UnsetStatus("AnnounceLog","SUSPEND_LOG")
      GkEventTimerManager.Start("Timer_Start",5)
      local n=instance.extraTargetGimmickTableListTable
      if Tpp.IsTypeTable(n)then
        local a=instance.questVariationCount
        local e=instance.waveVariationIndex
        local e=n[e]
        if Tpp.IsTypeTable(e)then
          for n,e in ipairs(e)do
            Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=true}
            Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=true}
          end
        end
      end
    end}
  function instance.OnBuildingSpawnEffectEnd(a,n,n)
    local n=instance.targetGimmickTable
    if Tpp.IsTypeTable(n)then
      local n=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name=n.locatorName,dataSetName=n.datasetName}
      if a==n and not mvars.bcm_isAlreadySetupDigger then
        local n=instance.GetDefensePosition()
        if n then
          Mission.SetDefensePosition{pos=n}
        end
        mvars.bcm_isAlreadySetupDigger=true
        Mission.SetPlacedDigger()
        instance.SetWaveMistVisible(1,true)
        instance.CheckMissionObjective"mission_common_objective_putDigger"
        instance.AddMissionObjective"mission_common_objective_bootDigger"
        instance.EnableExtraTargetMarker(1)
      end
    end
  end
  instance.sequences.Seq_Game_Stealth={
    messageTable={
      GameObject={
        {msg="DefenseChangeState",func=function(n,e)
          if e==TppDefine.DEFENSE_GAME_STATE.WAVE then
            TppSequence.SetNextSequence"Seq_Game_DefenseWave"
          end
        end}},

      UI={
        {msg="MiningMachineMenuRestartMachineSelected",func=function()
          local e=instance.targetGimmickTable
          Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=true}
          Mission.StopDefenseGamePrepare()
        end}}},
    Messages=function(e)
      local e=e.messageTable
      if Tpp.IsTypeTable(e)then
        return a(e)
      end
    end,
    OnEnter=function()
      local n=instance.prepareTime or f
      TppMission.StartDefenseGame(n)
      local n=instance.targetGimmickTable
      if Tpp.IsTypeTable(n)then
        local n=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name=n.locatorName,dataSetName=n.datasetName}
        instance.OnBuildingSpawnEffectEnd(n)
      end
      instance.AddMissionObjective"mission_common_objective_putDigger"
    end,
    OnLeave=function()
    end}
  instance.sequences.Seq_Game_WaitStartDigger={
    Messages=function(e)
      return a{
        GameObject={{msg="DefenseChangeState",func=function(n,e)
          if e==TppDefine.DEFENSE_GAME_STATE.WAVE then
            TppSequence.SetNextSequence"Seq_Game_DefenseWave"end
        end},
        {msg="DiggingStartEffectEnd",func=function()
          e.isStartDigger=true
          if e.isFinishInterval and e.isStartDigger then
            TppSequence.SetNextSequence"Seq_Game_DefenseWave"end
        end},
        {msg="FinishWaveInterval",func=function()
          e.isFinishInterval=true
          if e.isFinishInterval and e.isStartDigger then
            TppSequence.SetNextSequence"Seq_Game_DefenseWave"end
        end}}}
    end,
    OnEnter=function(n)
      local e=Mission.GetRestWaveInterval()>.1
      if not e then
        TopLeftDisplaySystem.RequestClose()
      end
      n.isFinishInterval=not e
      n.isStartDigger=false
    end,
    OnLeave=function(e)
    end}
  instance.sequences.Seq_Game_DefenseWave={messageTable={GameObject={{msg="FinishWave",func=function(a,n)
    if n>=Mission.GetTotalWaveCount()then
      instance.OnDefenseGameClear()
    else
      TppSequence.SetNextSequence"Seq_Game_DefenseBreak"end
  end},
  {msg="DefenseChangeState",func=function(n,e)
    if e==TppDefine.DEFENSE_GAME_STATE.WAVE_INTERVAL then
      TppSequence.SetNextSequence"Seq_Game_DefenseBreak"end
  end}},
  Timer={
    {sender="Timer_WaitExtraDiggerClose",msg="Finish",func=function()
      local n=instance.extraTargetGimmickTableListTable
      if Tpp.IsTypeTable(n)then
        local a=instance.questVariationCount
        local e=instance.waveVariationIndex
        local n=n[e]
        local e=mvars.currentExtraTargetList
        if Tpp.IsTypeTable(e)and Tpp.IsTypeTable(n)then
          for e,a in pairs(e)do
            local e=n[e]
            if Tpp.IsTypeTable(e)then
              Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=true}Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,isExtraTarget=true,isActiveTarget=false}Gimmick.SetAction{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,action="Close"}
            end
          end
        end
      end
    end},
    {sender="Timer_WaitExtraDiggerVanish",msg="Finish",func=function()
      local n=instance.extraTargetGimmickTableListTable
      if Tpp.IsTypeTable(n)then
        local a=instance.questVariationCount
        local e=instance.waveVariationIndex
        local e=n[e]
        local n=mvars.currentExtraTargetList
        if Tpp.IsTypeTable(n)and Tpp.IsTypeTable(e)then
          for n,a in pairs(n)do
            local e=e[n]
            if Tpp.IsTypeTable(e)then
              Gimmick.SetVanish{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName}
            end
          end
        end
      end
    end}},
  nil},
  Messages=function(e)
    local n=e.messageTable
    if Tpp.IsTypeTable(n)then
      return a(e.messageTable)
    end
  end,
  OnEnter=function(n)
    mvars.waveCount=mvars.waveCount+1
    instance.StartWave(mvars.waveCount)
    if WavePopupSystem and Tpp.IsTypeFunc(WavePopupSystem.RequestOpen)then
      WavePopupSystem.RequestOpen{type=WavePopupType.START,waveCount=mvars.waveCount}
    end
    if mvars.waveCount==1 then
      instance.CheckMissionObjective"mission_common_objective_bootDigger"
      instance.AddMissionObjective"mission_common_objective_defendDigger_coop"end
    instance.DisableAllExtraTargetMarker(true)
    GkEventTimerManager.Start("Timer_WaitExtraDiggerClose",10)
    GkEventTimerManager.Start("Timer_WaitExtraDiggerVanish",20)
    instance.SetCrewEnable(mvars.retentionCrewName,true)
    TppMarker.Enable("marker_target",0,"moving","all",0,true,false)
    local e=n.AfterOnEnter
    if Tpp.IsTypeFunc(e)then
      e(n)
    end
  end,
  OnLeave=function(n)
    if mvars.bcm_requestGameOver or mvars.bcm_requestAbandon then
      return
    end
    GameObject.SendCommand({type="TppCommandPost2"},{id="EndWave"})
    GameObject.SendCommand({type="SsdZombie"},{id="SetDefenseAi",active=false})
    Mission.SetAttackToRescueTarget{enable=false}
    Mission.DiggerShockWave{type=TppDefine.DIGGER_SHOCK_WAVE_TYPE.FINISH_WAVE}
    TppSoundDaemon.PostEvent"sfx_s_waveend_plasma"
    GameObject.SendCommand({type="TppCommandPost2"},{id="KillWaveEnemy"})
    if not mvars.bcm_requestGameOver and not mvars.votingResult then
      if TppSequence.GetCurrentSequenceName()=="Seq_Game_EstablishClear"then
        if mvars.miningMachineBroken then
          if WavePopupSystem and Tpp.IsTypeFunc(WavePopupSystem.RequestOpen)then
            WavePopupSystem.RequestOpen{type=WavePopupType.DEFENSE_FAILURE}
          end
        else
          ResultSystem.OpenPopupResult()
        end
      elseif WavePopupSystem and Tpp.IsTypeFunc(WavePopupSystem.RequestOpen)then
        WavePopupSystem.RequestOpen{type=WavePopupType.FINISH,waveCount=mvars.waveCount}
      end
    end
    TppMarker.Disable"marker_target"instance.SetCrewEnable(mvars.retentionCrewName,false)
    local n=instance.singularityEffectName
    if n then
      TppDataUtility.CreateEffectFromGroupId(n)
    end
    if mvars.waveCount==1 then
      local e=instance.breakableGimmickTableList
      if Tpp.IsTypeTable(e)then
        for n,e in ipairs(e)do
          if Tpp.IsTypeTable(e)then
            Gimmick.BreakGimmick(-1,e.locatorName,e.datasetName)
          end
        end
      end
    end
  end}
  instance.sequences.Seq_Game_DefenseBreak={
    messageTable={
      GameObject={
        {msg="FinishWaveInterval",func=function()
          TppSequence.SetNextSequence"Seq_Game_WaitStartDigger"end},
        {msg="DefenseChangeState",func=function(n,e)
          if e==TppDefine.DEFENSE_GAME_STATE.WAVE then
            TppSequence.SetNextSequence"Seq_Game_DefenseWave"end
        end},
        {msg="StartRebootDigger",func=function()
          TppSequence.SetNextSequence"Seq_Game_WaitStartDigger"end}},
      Timer={
        {sender="Timer_WaitSync",msg="Finish",func=function()
          TppPlayer.EnableSwitchIcon()
        end},
        {sender="Timer_ZombieRespawnAll",msg="Finish",func=function()
          instance.SetZombieRespawnAll()
        end}},
      UI={{msg="MiningMachineMenuRestartMachineSelected",func=function()
        local e=instance.targetGimmickTable
        Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=true}
        TppMission.StopWaveInterval()
        if mvars.continueFromDefenseBreak then
          TppSequence.SetNextSequence"Seq_Game_DefenseWave"end
      end}}},
    Messages=function(e)
      local e=e.messageTable
      if Tpp.IsTypeTable(e)then
        return a(e)
      end
    end,
    OnEnter=function()
      GkEventTimerManager.Start("Timer_WaitSync",10)
      TppPlayer.DisableSwitchIcon()
      if not mvars.continueFromDefenseBreak then
        local n=T
        local e=instance.intervalTimeTable
        if Tpp.IsTypeTable(e)then
          local e=e[mvars.waveCount]
          if Tpp.IsTypeNumber(e)then
            n=e
          end
        end
        TppMission.StartWaveInterval(n)
      end
      GkEventTimerManager.Start("Timer_ZombieRespawnAll",5)
      instance.EnableExtraTargetMarker(mvars.waveCount+1)
    end,
    OnLeave=function()
      TppPlayer.EnableSwitchIcon()
    end}
  instance.sequences.Seq_Game_EstablishClear={OnEnter=function(n)
    if IS_GC_2017_COOP and mvars.e3_bcm_gameover_isShowGameOver then
      GameOverMenuSystem.RequestClose()
    end
    TppUiStatusManager.SetStatus("PauseMenu","INVALID")
    if not(mvars.bcm_requestGameOver or mvars.bcm_requestAbandon)then
      Mission.UpdateCoopMissionResult()
    end
    SsdSbm.RemoveWithoutTemporaryCopy()
    SsdSbm.StoreToSVars()n.SetClearType()
    if not(mvars.bcm_requestGameOver or mvars.bcm_requestAbandon)then
      if PlayerInfo.OrCheckStatus{PlayerStatus.DEAD,PL_F_NEAR_DEATH,PL_F_NEAR_DEAD}then
        TppPlayer.Revive()
      end
      GameObject.SendCommand({type="SsdZombie"},{id="SetDefenseAi",active=false})
      Mission.SetAttackToRescueTarget{enable=false}
      TppMarker.Disable"marker_target"
      GameObject.SendCommand({type="TppCommandPost2"},{id="KillWaveEnemy",target="AllWithoutBoss"})
      local e=instance.targetGimmickTable
      Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=true}
      TppMusicManager.PostJingleState"Set_State_ssd_jin_WaveComp_on"
    end
    GkEventTimerManager.Start("Timer_WaitRewardAllMember",90)
    GkEventTimerManager.Start("Timer_WaitUpdateFinalScore",.1)
    instance.ClearMissionObjective()
    Gimmick.SetAllSwitchInvalid(true)
    SsdUiSystem.RequestForceCloseForMissionClear()
    TppException.SetSkipDisconnectFromHost()
    Mission.AddFinalizer(function()
      TppException.ResetSkipDisconnectFromHost()
    end)
  end,
  Messages=function(e)
    return a{
      Timer={
        {sender="Timer_WaitRewardAllMember",msg="Finish",func=function()
          TppSequence.SetNextSequence("Seq_Game_RequestCoopEndToServer",{isExecGameOver=true,isExecMissionClear=true})
        end,option={isExecGameOver=true,isExecMissionClear=true}},
        {sender="Timer_WaitUpdateFinalScore",msg="Finish",func=function()
          Mission.RequestCoopRewardToServer()
        end,option={isExecGameOver=true,isExecMissionClear=true}}}}
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
  OnLeave=function()
  end}
  instance.sequences.Seq_Game_RequestCoopEndToServer={
    OnEnter=function(e)
      Mission.RequestCoopEndToServer()
      e.isRequestedGameOver=false
    end,OnUpdate=function(e)
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
    OnLeave=function()
    end}
  instance.sequences.Seq_Game_Clear={OnEnter=function(e)
    TppMission.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppMission.GetCoopLobbyMissionCode()}MissionObjectiveInfoSystem.Clear()
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
        TppException.FinishProcess()
      end
    end
    TppUI.ShowAccessIcon()
  end

  function instance.HostMigration_OnLeave()
    TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED)
    TppMain.EnableAllGameStatus()
    TppMain.DisablePause()
    if TppUiCommand.IsShowPopup(5209)then
      TppUiCommand.ErasePopup()
    end
    mvars.isHostMigration=false
    TppUI.HideAccessIcon()
    local n=instance.targetGimmickTable
    if Gimmick.IsBrokenGimmick(n.type,n.locatorName,n.datasetName,1)then
      instance.DoBrokenMainDigger()
    end
  end

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
