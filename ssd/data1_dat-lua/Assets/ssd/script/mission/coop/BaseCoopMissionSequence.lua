local this={}
local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
local IsTypeNumber=Tpp.IsTypeNumber
local IsTypeString=Tpp.IsTypeString
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local defaultDefenseAlertRange=20
local u8=3
local Timer_Player_Dead_to_RevivalStr="Timer_Player_Dead_to_Revival"
local u7=60
local u6=.05
local u5=.0175
local u4=60
local u3=35
local defaultFinishShockWaveRadiusMin=10
local defaultFinishShockWaveRadiusMax=75
local defaultShockWaveRadiusEnlargementTime=30*60
local defaultIntervalTime=180
local defaultPrepareTime=300
local u2=8
local u1=3
local defaultQuestVariationCount=3
local instance={
  PRD_BLD_WeaponPlant={"PRD_BLD_WeaponPlant_A","PRD_BLD_WeaponPlant_B"},
  PRD_BLD_GadgetPlant={"PRD_BLD_GadgetPlant_A","PRD_BLD_GadgetPlant_B"},
  PRD_BLD_MedicalPlant={"PRD_BLD_MedicalPlant_A","PRD_BLD_MedicalPlant_B"},
  PRD_BLD_Kitchen={"PRD_BLD_Kitchen_A","PRD_BLD_Kitchen_B","PRD_BLD_Kitchen_C"},
  PRD_BLD_AmmoBox={"PRD_BLD_AmmoBox"}
}
local ut3={}
local ut2={}
local ut1={}
for a,e in pairs(instance)do
  for n,e in ipairs(e)do
    ut3[e]=a
    ut2[e]=n
    ut1[Fox.StrCode32(e)]=e
  end
end
function this.CreateInstance(missionName)
  local instance={}
  instance.MISSION_START_INITIAL_WEATHER=TppDefine.WEATHER.FOGGY
  instance.missionName=missionName
  instance.UNSET_PAUSE_MENU_SETTING={GamePauseMenu.RESTART_FROM_CHECK_POINT,GamePauseMenu.RESTART_FROM_MISSION_START}
  instance.INITIAL_INFINIT_OXYGEN=true
  instance.sequenceList={"Seq_Demo_SyncGameStart","Seq_Demo_HostAlreadyCleared","Seq_Game_Ready","Seq_Game_Stealth","Seq_Game_WaitStartDigger","Seq_Game_DefenseWave","Seq_Game_DefenseBreak","Seq_Game_EstablishClear","Seq_Game_RequestCoopEndToServer","Seq_Game_Clear"}
  function instance.OnLoad()
    TppSequence.RegisterSequences(instance.sequenceList)
    TppSequence.RegisterSequenceTable(instance.sequences)
  end
  instance.saveVarsList={waveCount=0}
  instance.checkPointList={"CHK_DefenseWave",nil}
  instance.baseList={nil}
  instance.CounterList={}
  instance.missionObjectiveDefine={marker_all_disable={},marker_target={gameObjectName="marker_target",visibleArea=0,randomRange=0,setNew=true,setImportant=true,goalType="moving",viewType="all"},marker_target_disable={}}
  instance.missionObjectiveTree={marker_all_disable={marker_target_disable={marker_target={}}}}
  instance.missionObjectiveEnumSource={"marker_all_disable","marker_target","marker_target_disable"}
  instance.missionObjectiveEnum=Tpp.Enum(instance.missionObjectiveEnumSource)
  function instance.MissionPrepare()
    if TppMission.IsHostmigrationProcessing()then
      instance.HostMigration_OnEnter()
    end
    local MissionCallbacks={
      OnEstablishMissionClear=function(n)
        instance.OnStartDropReward()
      end,
      OnDisappearGameEndAnnounceLog=function(e)
        Player.SetPause()
        TppMission.ShowMissionReward()
      end,OnEndMissionReward=function()
        instance.OnMissionEnd()
        TppMission.SetNextMissionCodeForMissionClear(TppMission.GetCoopLobbyMissionCode())
        if IS_GC_2017_COOP then
          TppMission.GameOverReturnToTitle()
          return
        end
        local missionClearType=TppMission.GetMissionClearType()
        TppMission.MissionFinalize{isNoFade=true}
      end,
      OnOutOfMissionArea=function()
        TppMission.ReserveGameOver(TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA,TppDefine.GAME_OVER_RADIO.S10020_OUT_OF_MISSION_AREA)
      end,
      nil
    }
    TppMission.RegiserMissionSystemCallback(MissionCallbacks)
    mvars.bcm_radioScript=_G[tostring(missionName).."_radio"]
    mvars.bcm_enemyScript=_G[tostring(missionName).."_enemy"]
    local n=_G[instance.locationScriptName]or{}
    instance.walkerGearNameList=instance.walkerGearNameList or n.walkerGearNameList
    instance.wormholePointResourceTableList=instance.wormholePointResourceTableList or n.wormholePointResourceTableList
    instance.startFogDensity=(instance.startFogDensity or n.startFogDensity)or u6
    instance.waveFogDensity=(instance.waveFogDensity or n.waveFogDensity)or u5
    instance.treasurePointTableList=instance.treasurePointTableList or n.treasurePointTableList
    instance.treasureBoxTableList=instance.treasureBoxTableList or n.treasureBoxTableList
    instance.ignoreLoadSmallBlocks=instance.ignoreLoadSmallBlocks or n.ignoreLoadSmallBlocks
    instance.extraTargetGimmickTableListTable=instance.extraTargetGimmickTableListTable or n.extraTargetGimmickTableListTable
    instance.craftGimmickTableTable=instance.craftGimmickTableTable or n.craftGimmickTableTable
    instance.questGimmickTableListTable=instance.questGimmickTableListTable or n.questGimmickTableListTable
    instance.stealthAreaNameTable=instance.stealthAreaNameTable or n.stealthAreaNameTable
    instance.huntDownRouteNameTable=instance.huntDownRouteNameTable or n.huntDownRouteNameTable
    instance.singularityEffectName=instance.singularityEffectName or n.singularityEffectName
    instance.breakableGimmickTableList=instance.breakableGimmickTableList or n.breakableGimmickTableList
    instance.impactAreaHeightOffset=instance.impactAreaHeightOffset or n.impactAreaHeightOffset
    FogWallController.SetEnabled(false)
    ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteOxygen",value=true}
    local identifier=instance.identifier
    local defensePositionKey=instance.defensePositionKey
    if identifier and defensePositionKey then
      local pos=Tpp.GetLocator(identifier,defensePositionKey)
      mvars.bcm_defensePosition=pos
    end
    SsdSbm.MakeInventoryTemporaryCopy()
    Mission.RequestCoopStartToServer()
    if not instance.dynamicShockWaveRadius then
      local e=instance.waveFinishShockWaveRadius or u3
      Mission.SetDiggerShockWaveRadiusAtWaveFinish(e)
    else
      mvars.waveFinishShockWaveRadiusMin=instance.waveFinishShockWaveRadiusMin or defaultFinishShockWaveRadiusMin
      mvars.waveFinishShockWaveRadiusMax=instance.waveFinishShockWaveRadiusMax or defaultFinishShockWaveRadiusMax
      mvars.currentShockWaveRadius=mvars.waveFinishShockWaveRadiusMin
      local shockWaveRadiusEnlargementTime=instance.shockWaveRadiusEnlargementTime or defaultShockWaveRadiusEnlargementTime
      mvars.shockWaveRadiusAdditionalValue=(mvars.waveFinishShockWaveRadiusMax-mvars.waveFinishShockWaveRadiusMin)/shockWaveRadiusEnlargementTime
      Mission.SetDiggerShockWaveRadiusAtWaveFinish(mvars.currentShockWaveRadius)
    end
    local treasurePointTableList=instance.treasurePointTableList
    if Tpp.IsTypeTable(treasurePointTableList)then
      for n,e in ipairs(treasurePointTableList)do
        Gimmick.SetTreasurePointResources(e)
      end
    end
    local treasureBoxTableList=instance.treasureBoxTableList
    if Tpp.IsTypeTable(treasureBoxTableList)then
      for n,e in ipairs(treasureBoxTableList)do
        Gimmick.SetTreasureBoxResources(e)
      end
    end
    local ignoreLoadSmallBlocks=instance.ignoreLoadSmallBlocks
    if Tpp.IsTypeTable(ignoreLoadSmallBlocks)then
      Mission.SetIgnoreLoadSmallStageBlocks(ignoreLoadSmallBlocks)
    end
    local loc_locationWormhole=mvars.loc_locationWormhole
    if Tpp.IsTypeTable(loc_locationWormhole)then
      local wormholePointTable=loc_locationWormhole.wormholePointTable
      if Tpp.IsTypeTable(wormholePointTable)then
        for n,e in ipairs(wormholePointTable)do
          Gimmick.SetResourceValidity{name=e.name,dataSetName=e.dataSetName,validity=false}
        end
      end
    end
    local wormholePointResourceTableList=instance.wormholePointResourceTableList
    if Tpp.IsTypeTable(wormholePointResourceTableList)then
      for n,e in ipairs(wormholePointResourceTableList)do
        Gimmick.SetWormholePointResources(e)
        Gimmick.SetResourceValidity{name=e.name,dataSetName=e.dataSetName,validity=true}
      end
    end
    local defenseGameDataJsonFilePath=instance.defenseGameDataJsonFilePath
    if Tpp.IsTypeString(defenseGameDataJsonFilePath)then
      Mission.LoadDefenseGameDataJson(defenseGameDataJsonFilePath)
    else
      Mission.LoadDefenseGameDataJson"/Assets/ssd/level_asset/defense_game/debug/debug_c20010_test.json"
    end
    instance.defenseGameVariationIndex=Mission.GetDefenseGameVariationIndex()or 0
    instance.questVariationCount=instance.questVariationCount or defaultQuestVariationCount
    instance.waveVariationIndex=math.floor((instance.defenseGameVariationIndex+instance.questVariationCount)/instance.questVariationCount)
    local AfterMissionPrepare=instance.AfterMissionPrepare
    if Tpp.IsTypeFunc(AfterMissionPrepare)then
      AfterMissionPrepare()
    end
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
    mvars.waveCount=Mission.GetCurrentWaveCount()--RETAILPATCH: 1.0.5.0 was svars.waveCount
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
      local walkerGearNameList=instance.walkerGearNameList
      if Tpp.IsTypeTable(walkerGearNameList)then
        for n,walkerId in ipairs(walkerGearNameList)do
          GameObject.SendCommand(GameObject.GetGameObjectId(walkerId),{id="SetColoringType",type=2})
        end
      end
    end
    local targetGimmickTable=instance.targetGimmickTable or{}
    if Tpp.IsTypeTable(targetGimmickTable)then
      local type=targetGimmickTable.type
      local locatorName=targetGimmickTable.locatorName
      local datasetName=targetGimmickTable.datasetName
      Gimmick.ResetGimmick(type,locatorName,datasetName)
      Gimmick.InvisibleGimmick(type,locatorName,datasetName,true)
    end
    local extraTargetGimmickTableListTable=instance.extraTargetGimmickTableListTable
    if Tpp.IsTypeTable(extraTargetGimmickTableListTable)then
      for n,e in pairs(extraTargetGimmickTableListTable)do
        if Tpp.IsTypeTable(e)then
          for n,e in ipairs(e)do
            if Tpp.IsTypeTable(e)then
              local locatorName=e.locatorName
              local datasetName=e.datasetName
              local type=e.type
              Gimmick.InvisibleGimmick(type,locatorName,datasetName,true)
            end
          end
        end
      end
    end
    local craftGimmickTableTable=instance.craftGimmickTableTable
    if Tpp.IsTypeTable(craftGimmickTableTable)then
      for n,e in pairs(craftGimmickTableTable)do
        if not e.visible then
          Gimmick.InvisibleGimmick(e.type,e.locatorName,e.datasetName,true)
        else
          local n=ut1[n]
          if n then
            local e=ut3[n]
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
    local questGimmickTableListTable=instance.questGimmickTableListTable
    if Tpp.IsTypeTable(questGimmickTableListTable)then
      for n,e in pairs(questGimmickTableListTable)do
        if Tpp.IsTypeTable(e)then
          for n,e in ipairs(e)do
            if Tpp.IsTypeTable(e)then
              Gimmick.InvisibleGimmick(e.type,e.locatorName,e.datasetName,true)
            end
          end
        end
      end
    end
    local impactAreaHeightOffset=instance.impactAreaHeightOffset
    if Tpp.IsTypeNumber(impactAreaHeightOffset)then
      ImpactAreaSystem.SetOffsetHeight(impactAreaHeightOffset)
    end
    --RETAILPATCH: 1.0.5.0>
    local impactAreaHeightRange=instance.impactAreaHeightRange
    if IsTypeNumber(impactAreaHeightRange)then
      ImpactAreaSystem.SetOffsetHeightRange(impactAreaHeightRange)
    end
    --<
    local AfterOnRestoreSVars=instance.AfterOnRestoreSVars
    if Tpp.IsTypeFunc(AfterOnRestoreSVars)then
      AfterOnRestoreSVars()
    end
  end
  function instance.OnEndMissionPrepareSequence()
    local targetGimmickTable=instance.targetGimmickTable or{}
    if Tpp.IsTypeTable(targetGimmickTable)then
      local type=targetGimmickTable.type
      local locatorName=targetGimmickTable.locatorName
      local datasetName=targetGimmickTable.datasetName
      local defenseAlertRange=instance.defenseAlertRange or defaultDefenseAlertRange
      Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=locatorName,dataSetName=datasetName,isActiveTarget=true,needAlert=true,alertRadius=defenseAlertRange,label=nil}
    end
    local extraTargetGimmickTableListTable=instance.extraTargetGimmickTableListTable
    if Tpp.IsTypeTable(extraTargetGimmickTableListTable)then
      for n,e in pairs(extraTargetGimmickTableListTable)do
        if Tpp.IsTypeTable(e)then
          for n,e in ipairs(e)do
            if Tpp.IsTypeTable(e)then
              local locatorName=e.locatorName
              local datasetName=e.datasetName
              Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=locatorName,dataSetName=datasetName,noTransfering=true}
              local extraTargetRadius=e.extraTargetRadius or 30
              Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=locatorName,dataSetName=datasetName,isExtraTarget=true,extraTargetRadius=extraTargetRadius}
            end
          end
        end
      end
    end
    --RETAILPATCH: 1.0.5.0>
    mvars.waveCount=Mission.GetCurrentWaveCount()
    instance.OnChangeState()
    --<
    if instance.fixedTime then
      TppClock.Stop()
    end
    local MISSION_WORLD_CENTER=instance.MISSION_WORLD_CENTER
    if MISSION_WORLD_CENTER then
      StageBlockCurrentPositionSetter.SetEnable(true)
      StageBlockCurrentPositionSetter.SetPosition(MISSION_WORLD_CENTER:GetX(),MISSION_WORLD_CENTER:GetZ())
    end
    MapInfoSystem.SetupInfos()
    TppPlayer.SetInitialPositionToCurrentPosition()
    local walkerGearNameList=instance.walkerGearNameList
    if Tpp.IsTypeTable(walkerGearNameList)then
      for n,e in ipairs(walkerGearNameList)do
        local walkerId=GameObject.GetGameObjectId("TppCommonWalkerGear2",e)
        local command={id="SetEnabled",enabled=false}
        GameObject.SendCommand(walkerId,command)
      end
    end
    for n,e in ipairs{TppDefine.ZOMBIE_TYPE_LIST,TppDefine.CREATURE_TYPE_LIST}do
      for n,creatureType in ipairs(e)do
        if GameObject.DoesGameObjectExistWithTypeName(creatureType)then
          GameObject.SendCommand({type=creatureType},{id="SetupCoopEXP"})
        end
      end
    end
    if Tpp.IsTypeTable(instance.stealthAreaNameTable)then
      for e,name in pairs(instance.stealthAreaNameTable)do
        local gameId=SsdNpc.GetGameObjectIdFromNpcTypeCode32(e)
        if gameId~=GameObject.NULL_ID then
          GameObject.SendCommand(gameId,{id="SetStealthArea",name=name})
        end
      end
    end
    local huntDownRouteNameTable=instance.huntDownRouteNameTable
    if Tpp.IsTypeTable(huntDownRouteNameTable)then
      local gameId=SsdNpc.GetGameObjectIdFromNpcTypeName"Aerial"
      if gameId~=GameObject.NULL_ID then
        GameObject.SendCommand(gameId,{id="SetHuntDownRoute",routes=huntDownRouteNameTable})
      end
    end
    local AfterOnEndMissionPrepareSequence=instance.AfterOnEndMissionPrepareSequence
    if Tpp.IsTypeFunc(AfterOnEndMissionPrepareSequence)then
      AfterOnEndMissionPrepareSequence()
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
    local defenseGameState=Mission.GetDefenseGameState()
    return instance.GameStateToGameSequence[defenseGameState]
  end
  function instance.StartWave(n)
    local defensePosition=instance.GetDefensePosition()
    if defensePosition then
      TppMission.SetDefensePosition(defensePosition)
    end
    for a,n in ipairs{TppDefine.ZOMBIE_TYPE_LIST,TppDefine.CREATURE_TYPE_LIST}do
      for a,n in ipairs(n)do
        if GameObject.DoesGameObjectExistWithTypeName(n)then
          local gameId={type=n}
          GameObject.SendCommand(gameId,{id="SetWaveAttacker",pos=defensePosition,radius=512})
          GameObject.SendCommand(gameId,{id="SetDefenseAi",active=true})
        end
      end
    end
    Mission.StartWave()
  end
  function instance.GetDefensePosition()
    return mvars.bcm_defensePosition
  end
  function instance.AddMissionObjective(langId)
    if not mvars.missionObjectiveTableList then
      mvars.missionObjectiveTableList={}
    end
    table.insert(mvars.missionObjectiveTableList,{langId=langId})
    MissionObjectiveInfoSystem.Open()
    MissionObjectiveInfoSystem.SetTable(mvars.missionObjectiveTableList)
  end
  function instance.CheckMissionObjective(langId)
    if mvars.missionObjectiveTableList then
      for n,a in ipairs(mvars.missionObjectiveTableList)do
        if a.langId==langId then
          MissionObjectiveInfoSystem.Check{langId=langId,checked=true}
          table.remove(mvars.missionObjectiveTableList,n)
          MissionObjectiveInfoSystem.Open()
          MissionObjectiveInfoSystem.SetTable(mvars.missionObjectiveTableList)
          break
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
    local fastTravelPointNameList=instance.fastTravelPointNameList
    if Tpp.IsTypeTable(fastTravelPointNameList)then
      for n,e in ipairs(fastTravelPointNameList)do
        SsdFastTravel.InvisibleFastTravelPointGimmick(e,false)
      end
    end
    Player.ResetPadMask{settingName="BaseCoopMissionSequence"}
    TppMission.MissionGameEnd()
  end
  instance.messageTable={
    Player={
      {msg="Dead",func=function(playerIndex)
        if playerIndex==PlayerInfo.GetLocalPlayerIndex()then
          if GkEventTimerManager.IsTimerActive(Timer_Player_Dead_to_RevivalStr)then
            GkEventTimerManager.Stop(Timer_Player_Dead_to_RevivalStr)
          end
          GkEventTimerManager.Start(Timer_Player_Dead_to_RevivalStr,u7)
        end
      end},
      {msg="WarpEnd",func=function()
        TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED,"RestartRevivePlayer")
      end}},
    GameObject={
      {msg="DiggerDrumRollStart",func=function()
        if TppSequence.GetCurrentSequenceName()=="Seq_Game_Clear"then
          if mvars.miningMachineBroken then--RETAILPATCH: 1.0.14>
            GkEventTimerManager.Start("Timer_OpenResult",36)
          else--<
            GkEventTimerManager.Start("Timer_OpenResult",26.709483)
          end
          TppMusicManager.PostJingleState"Set_State_ssd_jin_WaveComp_out"
        end
      end,option={isExecMissionClear=true}},
      {msg="ResortieCountDownEnd",func=function()
        TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"StartAutoRevivePlayer")
      end},
      {msg="BrokenMiningMachine",func=function(a,n)
        instance.BrokenMiningMachine(a,n)
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
      {msg="BreakGimmick",func=function(n,a,n,n)
        local gimmickObjectiveMap=instance.gimmickObjectiveMap
        if Tpp.IsTypeTable(gimmickObjectiveMap)then
          local currentSequenceName=TppSequence.GetCurrentSequenceName()
          if((currentSequenceName~="Seq_Game_Ready"and currentSequenceName~="Seq_Game_WaitStartDigger")and currentSequenceName~="Seq_Game_Clear")and currentSequenceName~="Seq_Game_EstablishClear"then
            local objectiveName=gimmickObjectiveMap[a]
            if objectiveName then
              Mission.AddEventScore(1e4)
              local disableObjectiveName=objectiveName.."_disable"
              TppMission.UpdateObjective{objectives={disableObjectiveName}}
              if Tpp.IsTypeTable(mvars.bcm_radioScript)and Tpp.IsTypeFunc(mvars.bcm_radioScript.OnGimmickBroken)then
                mvars.bcm_radioScript.OnGimmickBroken()
              end
            end
          end
        end
      end},
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
        --RETAILPATCH: 1.0.5.0>
        mvars.waveCount=Mission.GetCurrentWaveCount()
        instance.OnChangeState()
        --<
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
      {msg="CompletedCoopTask",func=function(m,taskRewardType,i)
        if taskRewardType==TppDefine.COOP_TASK_REWARD_TYPE.IRI and Tpp.IsLocalPlayer(m)then
          Mission.AddEventScore(i)
        elseif taskRewardType==TppDefine.COOP_TASK_REWARD_TYPE.AMMO_BOX or taskRewardType==TppDefine.COOP_TASK_REWARD_TYPE.BUILDING then
          local craftGimmickTableTable=instance.craftGimmickTableTable
          local m
          if Tpp.IsTypeTable(craftGimmickTableTable)then
            local craftGimmickTable=craftGimmickTableTable[i]
            if Tpp.IsTypeTable(craftGimmickTable)then
              local n=ut1[i]
              if n then
                local e=ut3[n]
                local i=ut2[n]
                if e and i then
                  local builtProductionIdListTable=mvars.builtProductionIdListTable
                  if Tpp.IsTypeTable(builtProductionIdListTable)then
                    local e=builtProductionIdListTable[e]
                    if Tpp.IsTypeTable(e)then
                      for r,productionId in ipairs(e)do
                        local n=ut2[productionId]
                        if n<i then
                          local n=craftGimmickTableTable[Fox.StrCode32(productionId)]
                          if Tpp.IsTypeTable(n)then
                            Gimmick.SetVanish{productionId=productionId,name=n.locatorName,dataSetName=n.datasetName}
                            table.remove(e,r)
                          end
                        else
                          m=true
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
                  table.insert(mvars.builtProductionIdListTable[e],n)
                end
              end
              if not m then
                Gimmick.ResetGimmick(craftGimmickTable.type,craftGimmickTable.locatorName,craftGimmickTable.datasetName,{needSpawnEffect=true})
              end
            end
          end
        elseif taskRewardType==TppDefine.COOP_TASK_REWARD_TYPE.RECOVER_DIGGER_LIFE then
        elseif taskRewardType==TppDefine.COOP_TASK_REWARD_TYPE.WALKERGEAR then
        end
        if Tpp.IsLocalPlayer(m)then
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
        local extraTargetGimmickTableListTable=instance.extraTargetGimmickTableListTable
        if Tpp.IsTypeTable(extraTargetGimmickTableListTable)then
          local questVariationCount=instance.questVariationCount
          local waveVariationIndex=instance.waveVariationIndex
          local n=extraTargetGimmickTableListTable[waveVariationIndex]
          if Tpp.IsTypeTable(n)then
            for s,n in ipairs(n)do
              if Tpp.IsTypeTable(n)then
                local name=n.locatorName
                local dataSetName=n.datasetName
                local r=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name=name,dataSetName=dataSetName}
                if i==r then
                  local extraTargetRadius=n.extraTargetRadius or 30
                  Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=name,dataSetName=dataSetName,isExtraTarget=true,extraTargetRadius=extraTargetRadius}
                  instance.DisableAllExtraTargetMarker()
                  if not Tpp.IsTypeTable(mvars.currentExtraTargetList)then
                    mvars.currentExtraTargetList={}
                  end
                  mvars.currentExtraTargetList[s]=true
                end
              end
            end
          end
        end
      end},
      {msg="BuyCoopQuestShop",func=function(shopItem)
        if shopItem==Fox.StrCode32"SHOP_GIMMICK"then
          local questGimmickTableListTable=instance.questGimmickTableListTable
          if Tpp.IsTypeTable(questGimmickTableListTable)then
            local questVariationCount=instance.questVariationCount
            local waveVariationIndex=instance.waveVariationIndex
            local e=questGimmickTableListTable[waveVariationIndex]
            if Tpp.IsTypeTable(e)then
              for n,e in ipairs(e)do
                if Tpp.IsTypeTable(e)then
                  Gimmick.ResetGimmick(e.type,e.locatorName,e.datasetName,{needSpawnEffect=true})
                end
              end
            end
          end
        elseif shopItem==Fox.StrCode32"SHOP_AMMOBOX"then
          local craftGimmickTableTable=instance.craftGimmickTableTable
          if Tpp.IsTypeTable(craftGimmickTableTable)then
            local e=craftGimmickTableTable[Fox.StrCode32"PRD_BLD_AmmoBox"]
            if Tpp.IsTypeTable(e)then
              Gimmick.ResetGimmick(e.type,e.locatorName,e.datasetName,{needSpawnEffect=true})
            end
          end
        elseif shopItem==Fox.StrCode32"SHOP_WALKERGEAR"then
        elseif shopItem==Fox.StrCode32"SHOP_METALGEAR_RAY"then
        end
      end}},
    Timer={{sender="Timer_WaitStartCloseDigger",msg="Finish",func=function()
      TopLeftDisplaySystem.RequestClose()
      instance.SetActionDigger{action="SetRewardMode"}
      instance.SetActionDigger{action="Open"}
      local defensePosition=instance.GetDefensePosition()
      local positionVec3=Vector3(defensePosition[1],defensePosition[2]+12,defensePosition[3])
      instance.SetActionDigger{action="SetTargetPos",position=positionVec3}
    end,option={isExecMissionClear=true}},
    {sender="Timer_Close_Digger",msg="Finish",func=function()
      instance.SetActionDigger{action="StopRewardWormhole"}
      GkEventTimerManager.Start("Timer_StartVanishDigger",13)
    end,option={isExecMissionClear=true}},
    {sender="Timer_Destroy_Reward_Singularity",msg="Finish",func=function()
      local singularityEffectName=instance.singularityEffectName
      if singularityEffectName then
        TppDataUtility.DestroyEffectFromGroupId(singularityEffectName)
        TppDataUtility.CreateEffectFromGroupId"destroy_singularity_reward"
      end
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
        if mvars.currentRewardIndex<u2 then
          e=Mission.DropCoopRewardBox(mvars.currentRewardIndex)
          table.remove(mvars.bcm_rewardOffsetTable,index)
          mvars.finalRewardDropped=true
          mvars.currentRewardIndex=mvars.currentRewardIndex+1
        end
      end
      if e then
        GkEventTimerManager.Start("Timer_Reward",.1)
      end
      if mvars.miningMachineBroken then--RETAILPATCH: 1.0.14>
        instance.OpenCoopResult()
      end--<
    end,option={isExecMissionClear=true}},
    {sender="Timer_OpenResult",msg="Finish",func=function()
      instance.OpenCoopResult()  --RETAILPATCH: 1.0.14 was ResultSystem.OpenCoopResult()
      GkEventTimerManager.Start("Timer_Close_Digger",2)
    end,option={isExecMissionClear=true}},
    {sender="Timer_StartVanishDigger",msg="Finish",func=function()
      local targetGimmickTable=instance.targetGimmickTable
      Gimmick.SetVanish{gimmickId="GIM_P_Digger",name=targetGimmickTable.locatorName,dataSetName=targetGimmickTable.datasetName}
      Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=targetGimmickTable.locatorName,dataSetName=targetGimmickTable.datasetName,noTransfering=true}
    end,option={isExecMissionClear=true}},
    {sender="WaitCameraMoveEnd",msg="Finish",func=function()
      TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED,"RestartRevivePlayer")
    end},
    {sender="Timer_TickShockWave",msg="Finish",func=function()
      if TppSequence.GetCurrentSequenceName()~="Seq_Game_DefenseWave"then
        GkEventTimerManager.Start("Timer_TickShockWave",1)
        return
      end
      if Tpp.IsTypeNumber(mvars.currentShockWaveRadius)and Tpp.IsTypeNumber(mvars.shockWaveRadiusAdditionalValue)then
        mvars.currentShockWaveRadius=mvars.currentShockWaveRadius+mvars.shockWaveRadiusAdditionalValue
        if mvars.currentShockWaveRadius>mvars.waveFinishShockWaveRadiusMax then
          mvars.currentShockWaveRadius=mvars.waveFinishShockWaveRadiusMax
        else
          GkEventTimerManager.Start("Timer_TickShockWave",1)
        end
        Mission.SetDiggerShockWaveRadiusAtWaveFinish(mvars.currentShockWaveRadius)
      end
    end}},
    UI={
      {msg="MiningMachineMenuRequestPulloutSelected",func=function()
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
        local playerId={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}
        local command={id="Revive",revivalType="Respawn"}
        GameObject.SendCommand(playerId,command)
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
        --RETAILPATCH: 1.0.5.0
        if mvars.bcm_requestGameOver or mvars.bcm_requestAbandon then
          return
        end
        --<
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
            local playerId={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}
            local command={id="Revive",revivalType="Respawn"}
            GameObject.SendCommand(playerId,command)
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
      end}},Network={{msg="StartHostMigration",func=function()
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
        end}}
  }
  function instance.Messages()
    if Tpp.IsTypeTable(instance.messageTable)then
      return StrCode32Table(instance.messageTable)
    else
      return{}
    end
  end
  function instance.OpenCoopResult()--RETAILPATCH: 1.0.14>
    if mvars.bcm_isOpenedCoopResult then
      return
  end
  ResultSystem.OpenCoopResult()
  mvars.bcm_isOpenedCoopResult=true
  end--<
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
    local targetGimmickTable=instance.targetGimmickTable
    if Tpp.IsTypeTable(targetGimmickTable)then
      if Gimmick.CanTransfering~=nil then
        local canTransfering=Gimmick.CanTransfering{gimmickId="GIM_P_Digger",name=targetGimmickTable.locatorName,dataSetName=targetGimmickTable.datasetName}
        if not canTransfering then
          return
        end
      end
      Gimmick.ResetGimmick(targetGimmickTable.type,targetGimmickTable.locatorName,targetGimmickTable.datasetName,{needSpawnEffect=true})
      mvars.bcm_isAlreadySetupDigger=true
    end
    instance.CheckMissionObjective"mission_common_objective_putDigger"
    instance.AddMissionObjective"mission_common_objective_bootDigger"
  end
  function instance.BrokenMiningMachine(a,n)
    local targetGimmickTable=instance.targetGimmickTable
    if Tpp.IsTypeTable(targetGimmickTable)then
      local locatorName=targetGimmickTable.locatorName
      local datasetName=targetGimmickTable.datasetName
      local diggerId=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name=locatorName,dataSetName=datasetName}
      if a==diggerId then
        instance.DoBrokenMainDigger()
      else
        local extraTargetGimmickTableListTable=instance.extraTargetGimmickTableListTable
        if Tpp.IsTypeTable(extraTargetGimmickTableListTable)then
          local questVariationCount=instance.questVariationCount
          local waveVariationIndex=instance.waveVariationIndex
          local e=extraTargetGimmickTableListTable[waveVariationIndex]
          if Tpp.IsTypeTable(e)then
            for n,e in ipairs(e)do
              if Tpp.IsTypeTable(e)then
                local locatorName=e.locatorName
                local datasetName=e.datasetName
                local diggerId=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name=locatorName,dataSetName=datasetName}
                if a==diggerId then
                  Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=locatorName,dataSetName=datasetName,isExtraTarget=true,isActiveTarget=false}
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
      local n,a=Gimmick.SsdGetPosAndRot{gameObjectId=gameObjectId}--RETAILBUG undefined
      if n then
        local e=TppPlayer.GetDefenseTargetBrokenCameraInfo(n,a,locatorName,upperLocatorName)--RETAILBUG undefined
        TppPlayer.ReserveDefenseTargetBrokenCamera(e)
      end
      instance.GoToGameOver(true)
    end
  end
  function instance.EnableExtraTargetMarker(n)
    local extraTargetGimmickTableListTable=instance.extraTargetGimmickTableListTable
    if Tpp.IsTypeTable(extraTargetGimmickTableListTable)then
      local questVariationCount=instance.questVariationCount
      local waveVariationIndex=instance.waveVariationIndex
      local e=extraTargetGimmickTableListTable[waveVariationIndex]
      if Tpp.IsTypeTable(e)then
        for i,e in ipairs(e)do
          if Tpp.IsTypeTable(e)then
            local a=e.markerName
            local t=e.wave
            if(Tpp.IsTypeString(a)and((not Tpp.IsTypeTable(t)or not Tpp.IsTypeNumber(n))or t[n]))and not mvars.currentExtraTargetList[i]then
              TppMarker.Enable(a,0,"moving","all",0,true,false)
              Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=false}
              local floatingSingularityEffectName=e.floatingSingularityEffectName
              if floatingSingularityEffectName then
                TppDataUtility.CreateEffectFromGroupId(floatingSingularityEffectName)
              end
            end
          end
        end
      end
    end
  end
  function instance.DisableAllExtraTargetMarker(a)
    local extraTargetGimmickTableListTable=instance.extraTargetGimmickTableListTable
    if Tpp.IsTypeTable(extraTargetGimmickTableListTable)then
      local questVariationCount=instance.questVariationCount
      local waveVariationIndex=instance.waveVariationIndex
      local e=extraTargetGimmickTableListTable[waveVariationIndex]
      if Tpp.IsTypeTable(e)then
        for n,e in ipairs(e)do
          if Tpp.IsTypeTable(e)then
            local n=e.markerName
            if Tpp.IsTypeString(n)then
              TppMarker.Disable(n)Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=true}
            end
            if a then
              local floatingSingularityEffectName=e.floatingSingularityEffectName
              if floatingSingularityEffectName then
                TppDataUtility.DestroyEffectFromGroupId(floatingSingularityEffectName)
              end
            end
          end
        end
      end
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
        return StrCode32Table(e)
      end
    end,
    OnEnter=function(e)
      GkEventTimerManager.Start("Timer_SyncStart",u4)
      mvars.bcs_syncStartTime=Time.GetRawElapsedTimeSinceStartUp()
    end,DEBUG_TextPrint=function(e)
      local n=DebugText.NewContext()
      DebugText.Print(n,{.5,.5,1},e)
    end,OnUpdate=function(a)
      local n=Time.GetRawElapsedTimeSinceStartUp()-mvars.bcs_syncStartTime
      if DebugText then
        a.DEBUG_TextPrint(string.format("[Seq_Demo_SyncGameStart] Waiting coop member loading. : coop member wait time = %02.2f[s] : TIMEOUT = %02.2f[s]",n,u4))
      end
      if not mvars.bcs_isReadyLocal and not Mission.IsCoopRequestBusy()then
        mvars.bcs_isReadyLocal=true
        Mission.SetIsReadyCoopMission(true)
      end
      if Mission.IsReadyCoopMissionAllMembers()then
        instance.SetStartMissionSequence()
      end
      TppUI.ShowAccessIconContinue()
    end,OnLeave=function()
      Mission.HostMigration_SetActive(true)
    end}
  function instance.SetStartMissionSequence()
    TppMission.EnableInGameFlag()
    if Mission.CanJoinSession()then
      TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED,"StartMainGame")
      --RETAILPATCH: 1.0.5.0
      local gameSequence=instance.GetGameSequenceFromDefenseGameState()
      if gameSequence=="Seq_Game_WaitStartDigger"or gameSequence=="Seq_Game_DefenseBreak"then
        instance.EnableExtraTargetMarker(mvars.waveCount+1)
      end
      TppSequence.SetNextSequence(gameSequence)
      --<
    else
      TppSequence.SetNextSequence"Seq_Demo_HostAlreadyCleared"
    end
  end
  instance.sequences.Seq_Demo_HostAlreadyCleared={
    OnEnter=function()
      TppMission.EnableInGameFlag()
      TppMission.DisconnectMatching(true)
      svars.mis_isDefiniteMissionClear=false
      mvars.mis_isReserveMissionClear=false
      TppException.OnSessionDisconnectFromHost()--RETAILPATCH: 1.0.14
    end}
  instance.sequences.Seq_Game_Ready={
    messageTable={
      Timer={
        {sender="Timer_Start",msg="Finish",func=function()
          TppSequence.SetNextSequence"Seq_Game_Stealth"end}}},
    Messages=function(e)
      local e=e.messageTable
      if Tpp.IsTypeTable(e)then
        return StrCode32Table(e)
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
      if Tpp.IsTypeTable(mvars.bcm_radioScript)and Tpp.IsTypeFunc(mvars.bcm_radioScript.OnSequenceStarted)then
        mvars.bcm_radioScript.OnSequenceStarted()
      end
      GkEventTimerManager.Start("Timer_Start",5)
      local extraTargetGimmickTableListTable=instance.extraTargetGimmickTableListTable
      if Tpp.IsTypeTable(extraTargetGimmickTableListTable)then
        local questVariationCount=instance.questVariationCount
        local waveVariationIndex=instance.waveVariationIndex
        local e=extraTargetGimmickTableListTable[waveVariationIndex]
        if Tpp.IsTypeTable(e)then
          for n,e in ipairs(e)do
            Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=true}
            Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=true}
          end
        end
      end
    end}
  function instance.OnBuildingSpawnEffectEnd(a,n,n)
    local targetGimmickTable=instance.targetGimmickTable
    if Tpp.IsTypeTable(targetGimmickTable)then
      local n=Gimmick.SsdGetGameObjectId{gimmickId="GIM_P_Digger",name=targetGimmickTable.locatorName,dataSetName=targetGimmickTable.datasetName}
      if a==n and not mvars.bcm_isAlreadySetupDigger then
        local defensePosition=instance.GetDefensePosition()
        if defensePosition then
          Mission.SetDefensePosition{pos=defensePosition}
        end
        mvars.bcm_isAlreadySetupDigger=true
        if not mvars.waveEffectVisibility then
          Mission.SetPlacedDigger()
          instance.SetWaveMistVisible(1,true)
          mvars.waveEffectVisibility=true
        end
        instance.CheckMissionObjective"mission_common_objective_putDigger"
        instance.AddMissionObjective"mission_common_objective_bootDigger"
        instance.EnableExtraTargetMarker(1)
      end
    end
  end
  function instance.OnChangeState()
    local extraTargetGimmickTableListTable=instance.extraTargetGimmickTableListTable
    if not IsTypeTable(extraTargetGimmickTableListTable)then
      return
    end
    local waveVariationIndex=instance.waveVariationIndex
    local extraTargetGimmickTable=extraTargetGimmickTableListTable[waveVariationIndex]
    if not IsTypeTable(extraTargetGimmickTable)then
      return
    end
    for t,e in ipairs(extraTargetGimmickTable)do
      if IsTypeTable(e)then
        local locatorName=e.locatorName
        local datasetName=e.datasetName
        local isBootedExtraDigger=Mission.IsBootedExtraDigger{dataSetName=datasetName,locatorName=locatorName}
        if isBootedExtraDigger then
          if not IsTypeTable(mvars.currentExtraTargetList)then
            mvars.currentExtraTargetList={}
          end
          mvars.currentExtraTargetList[t]=true
        end
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
        end},
        {msg="BuildingSpawnEffectEnd",func=instance.OnBuildingSpawnEffectEnd}},
      UI={
        {msg="MiningMachineMenuRestartMachineSelected",func=function()
          local e=instance.targetGimmickTable
          Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=true}
          Mission.StopDefenseGamePrepare()
        end}}},
    Messages=function(e)
      local messageTable=e.messageTable
      if Tpp.IsTypeTable(messageTable)then
        return StrCode32Table(messageTable)
      end
    end,
    OnEnter=function()
      TppMission.UpdateObjective{objectives={"marker_target"}}
      local gimmickObjectiveMap=instance.gimmickObjectiveMap
      if Tpp.IsTypeTable(gimmickObjectiveMap)then
        for n,e in pairs(gimmickObjectiveMap)do
          TppMission.UpdateObjective{objectives={e}}
        end
      end
      local prepareTime=instance.prepareTime or defaultPrepareTime
      TppMission.StartDefenseGame(prepareTime)
      if Tpp.IsTypeTable(mvars.bcm_radioScript)and Tpp.IsTypeFunc(mvars.bcm_radioScript.OnSequenceStarted)then
        mvars.bcm_radioScript.OnSequenceStarted()
      end
      instance.AddMissionObjective"mission_common_objective_putDigger"
    end,
    OnLeave=function()
      TppMission.UpdateObjective{objectives={"marker_target_disable"}}
    end}
  instance.sequences.Seq_Game_WaitStartDigger={
    Messages=function(n)
      return StrCode32Table{
        GameObject={
          {msg="DefenseChangeState",func=function(n,defenseGameState)
            if defenseGameState==TppDefine.DEFENSE_GAME_STATE.WAVE then
              TppSequence.SetNextSequence"Seq_Game_DefenseWave"
            end
          end},
          {msg="DiggingStartEffectEndCoop",func=function()
            mvars.waveCount=mvars.waveCount+1--RETAILPATCH: 1.0.5.0
            --RETAILPATCH: 1.0.5.0 removed n.isStartDigger=true
            TppSequence.SetNextSequence"Seq_Game_DefenseWave"
          end},
          {msg="FinishWaveInterval",func=function()
            end},
          {msg="DiggerShootEffect",func=function(n,e)
            if e~=1 then
              return
            end
            GkEventTimerManager.Start("Timer_DestroySingularityEffect",.9)
          end},
          {msg="BuildingSpawnEffectEnd",func=instance.OnBuildingSpawnEffectEnd}},
        Timer={
          {msg="Finish",sender="Timer_DestroySingularityEffect",func=function()
            local singularityEffectName=instance.singularityEffectName
            if singularityEffectName then
              TppDataUtility.DestroyEffectFromGroupId(singularityEffectName)
              TppDataUtility.CreateEffectFromGroupId"destroy_singularity"
              TppWeather.ForceRequestWeather(TppDefine.WEATHER.FOGGY,1,{fogDensity=instance.waveFogDensity})
            end
          end}}}
    end,
    OnEnter=function(t)
      local a=Mission.GetRestWaveInterval()>.1
      local targetGimmickTable=instance.targetGimmickTable
      Gimmick.SetAction{gimmickId="GIM_P_Digger",name=targetGimmickTable.locatorName,dataSetName=targetGimmickTable.datasetName,action="Open",offsetPosition=Vector3(0,12,0)}
      if not a then
        TopLeftDisplaySystem.RequestClose()
      end
      local targetGimmickTable=instance.targetGimmickTable
      Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=targetGimmickTable.locatorName,dataSetName=targetGimmickTable.datasetName,powerOff=true}
      --RETAILPATCH: 1.0.5.0 removed t.isStartDigger=false
    end,
    OnLeave=function(n)
      local targetGimmickTable=instance.targetGimmickTable
      Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=targetGimmickTable.locatorName,dataSetName=targetGimmickTable.datasetName,powerOff=false}
      if not GkEventTimerManager.IsTimerActive"Timer_TickShockWave"then
        GkEventTimerManager.Start("Timer_TickShockWave",1)
      end
    end}
  instance.sequences.Seq_Game_DefenseWave={
    messageTable={
      GameObject={
        {msg="FinishWave",func=function(unkP1,unkP2)
          local totalWaveCount=Mission.GetTotalWaveCount()--RETAILPATCH: 1.0.14>
          if Mission.HasExtraWave()then
            if(unkP2>=totalWaveCount)or(unkP2==(totalWaveCount-1)and not Mission.IsReadyExtraWave())then
              u1.OnDefenseGameClear()
            elseif Mission.IsReadyExtraWave()then
              TppSequence.SetNextSequence"Seq_Game_ExtraBreak"else
              TppSequence.SetNextSequence"Seq_Game_DefenseBreak"end
          else--<
            if unkP2>=totalWaveCount then
              instance.OnDefenseGameClear()
          else
            TppSequence.SetNextSequence"Seq_Game_DefenseBreak"
          end
          end
        end},
        {msg="DefenseChangeState",func=function(n,e)
          if e==TppDefine.DEFENSE_GAME_STATE.WAVE_INTERVAL then
            TppSequence.SetNextSequence"Seq_Game_DefenseBreak"
          elseif e==TppDefine.DEFENSE_GAME_STATE.EXTRA_PREPARE then--RETAILPATCH: 1.0.14>
            TppSequence.SetNextSequence"Seq_Game_ExtraBreak"--<
          end
        end}},
      nil},
    Messages=function(e)
      local messageTable=e.messageTable
      if Tpp.IsTypeTable(messageTable)then
        return StrCode32Table(e.messageTable)
      end
    end,
    OnEnter=function(n)
      --RETAILPATCH: 1.0.5.0 removed mvars.waveCount=mvars.waveCount+1
      instance.StartWave(mvars.waveCount)
      if not mvars.waveEffectVisibility then
        instance.SetWaveMistVisible(mvars.waveCount,true)
      end
      mvars.waveEffectVisibility=nil
      if Tpp.IsTypeTable(mvars.bcm_radioScript)and Tpp.IsTypeFunc(mvars.bcm_radioScript.OnSequenceStarted)then
        mvars.bcm_radioScript.OnSequenceStarted()
      end
      GkEventTimerManager.Start("Timer_Tick",30)
      if WavePopupSystem and Tpp.IsTypeFunc(WavePopupSystem.RequestOpen)then
        WavePopupSystem.RequestOpen{type=WavePopupType.START,waveCount=mvars.waveCount}
      end
      if mvars.waveCount==1 then
        instance.CheckMissionObjective"mission_common_objective_bootDigger"instance.AddMissionObjective"mission_common_objective_defendDigger_coop"TppWeather.ForceRequestWeather(TppDefine.WEATHER.FOGGY,1,{fogDensity=instance.waveFogDensity})
      end
      instance.DisableAllExtraTargetMarker(true)
      local AfterOnEnter=n.AfterOnEnter
      if Tpp.IsTypeFunc(AfterOnEnter)then
        AfterOnEnter(n)
      end
    end,OnLeave=function(n)
      if mvars.bcm_requestGameOver or mvars.bcm_requestAbandon then
        return
      end
      GameObject.SendCommand({type="TppCommandPost2"},{id="EndWave"})
      instance.SetWaveMistVisible(mvars.waveCount,false)
      GameObject.SendCommand({type="SsdZombie"},{id="SetDefenseAi",active=false})
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
      local singularityEffectName=instance.singularityEffectName
      if singularityEffectName then
        TppDataUtility.CreateEffectFromGroupId(singularityEffectName)
      end
      local extraTargetGimmickTableListTable=instance.extraTargetGimmickTableListTable
      if Tpp.IsTypeTable(extraTargetGimmickTableListTable)then
        local questVariationCount=instance.questVariationCount
        local waveVariationIndex=instance.waveVariationIndex
        local e=extraTargetGimmickTableListTable[waveVariationIndex]
        local currentExtraTargetList=mvars.currentExtraTargetList
        if Tpp.IsTypeTable(currentExtraTargetList)and Tpp.IsTypeTable(e)then
          for n,a in pairs(currentExtraTargetList)do
            local e=e[n]
            if Tpp.IsTypeTable(e)then
              Gimmick.SetNoTransfering{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,noTransfering=true}
              Gimmick.SetDefenseTarget{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,isExtraTarget=true,isActiveTarget=false}
              Gimmick.SetVanish{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName}
            end
          end
        end
      end
      if mvars.waveCount==1 then
        local breakableGimmickTableList=instance.breakableGimmickTableList
        if Tpp.IsTypeTable(breakableGimmickTableList)then
          for n,e in ipairs(breakableGimmickTableList)do
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
          if not mvars.waveEffectVisibility then
            instance.SetWaveMistVisible(mvars.waveCount+1,true)
            mvars.waveEffectVisibility=true
          end
        end}},
      UI={
        {msg="MiningMachineMenuRestartMachineSelected",func=function()
          local targetGimmickTable=instance.targetGimmickTable
          Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=targetGimmickTable.locatorName,dataSetName=targetGimmickTable.datasetName,powerOff=true}
          TppMission.StopWaveInterval()
          if mvars.continueFromDefenseBreak then
            TppSequence.SetNextSequence"Seq_Game_DefenseWave"end
        end}}},
    Messages=function(e)
      local messageTable=e.messageTable
      if Tpp.IsTypeTable(messageTable)then
        return StrCode32Table(messageTable)
      end
    end,
    OnEnter=function()
      if Tpp.IsTypeTable(mvars.bcm_radioScript)and Tpp.IsTypeFunc(mvars.bcm_radioScript.OnSequenceStarted)then
        mvars.bcm_radioScript.OnSequenceStarted()
      end
      GkEventTimerManager.Start("Timer_WaitSync",10)
      TppPlayer.DisableSwitchIcon()
      if not mvars.continueFromDefenseBreak then
        local intervalTime=defaultIntervalTime
        local intervalTimeTable=instance.intervalTimeTable
        if Tpp.IsTypeTable(intervalTimeTable)then
          local currentIntervalTime=intervalTimeTable[mvars.waveCount]
          if Tpp.IsTypeNumber(currentIntervalTime)then
            intervalTime=currentIntervalTime
          end
        end
        TppMission.StartWaveInterval(intervalTime)
      end
      instance.EnableExtraTargetMarker(mvars.waveCount+1)
    end,
    OnLeave=function()
      TppPlayer.EnableSwitchIcon()
    end}
  --RETAILPATCH: 1.0.14>
  instance.sequences.Seq_Game_ExtraBreak={
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
          if not mvars.waveEffectVisibility then
            instance.SetWaveMistVisible(mvars.waveCount+1,true)
            mvars.waveEffectVisibility=true
          end
        end}},
      UI={
        {msg="MiningMachineMenuRestartMachineSelected",func=function()
          local e=instance.targetGimmickTable
          Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=e.locatorName,dataSetName=e.datasetName,powerOff=true}
          Mission.StopExtraPrepare()
        end}}},
    Messages=function(e)
      local e=e.messageTable
      if IsTypeTable(e)then
        return StrCode32Table(e)
      end
    end,
    OnEnter=function()
      if IsTypeTable(mvars.bcm_radioScript)and IsTypeFunc(mvars.bcm_radioScript.OnSequenceStarted)then
        mvars.bcm_radioScript.OnSequenceStarted()
      end
      GkEventTimerManager.Start("Timer_WaitSync",10)
      TppPlayer.DisableSwitchIcon()
      Mission.StartExtraPrepare()
      Mission.StartWaveResult()
    end,
    OnLeave=function()
      TppPlayer.EnableSwitchIcon()
    end}
  --<
  instance.sequences.Seq_Game_EstablishClear={
    OnEnter=function(n)
      if IS_GC_2017_COOP and mvars.e3_bcm_gameover_isShowGameOver then
        GameOverMenuSystem.RequestClose()
      end
      TppUiStatusManager.SetStatus("PauseMenu","INVALID")
      if not(mvars.bcm_requestGameOver or mvars.bcm_requestAbandon)then
        Mission.UpdateCoopMissionResult()
      end
      SsdSbm.RemoveWithoutTemporaryCopy()
      SsdSbm.StoreToSVars()
      n.SetClearType()
      if not(mvars.bcm_requestGameOver or mvars.bcm_requestAbandon)then
        if PlayerInfo.OrCheckStatus{PlayerStatus.DEAD,PL_F_NEAR_DEATH,PL_F_NEAR_DEAD}then--DEBUGNOW RETAILBUG
          --RETAILPATCH: 1.0.5.0 was TppPlayer.Revive()
          -->
          local gameId={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}
          local command={id="Revive",revivalType="Bailout"}
          GameObject.SendCommand(gameId,command)
          --<
        end
        GameObject.SendCommand({type="SsdZombie"},{id="SetDefenseAi",active=false})
        TppMission.UpdateObjective{objectives={"marker_all_disable"}}
        GameObject.SendCommand({type="TppCommandPost2"},{id="KillWaveEnemy",target="AllWithoutBoss"})
        local targetGimmickTable=instance.targetGimmickTable
        Gimmick.SetSsdPowerOff{gimmickId="GIM_P_Digger",name=targetGimmickTable.locatorName,dataSetName=targetGimmickTable.datasetName,powerOff=true}
        TppMusicManager.PostJingleState"Set_State_ssd_jin_WaveComp_on"
      end
      GkEventTimerManager.Start("Timer_WaitRewardAllMember",90)
      GkEventTimerManager.Start("Timer_WaitUpdateFinalScore",1.5)--RETAILPATCH: 1.0.14 was .1
      instance.ClearMissionObjective()
      Gimmick.SetAllSwitchInvalid(true)
      SsdUiSystem.RequestForceCloseForMissionClear()
      TppException.SetSkipDisconnectFromHost()
      Mission.AddFinalizer(function()
        TppException.ResetSkipDisconnectFromHost()
      end)
    end,
    Messages=function(e)
      return StrCode32Table{
        Timer={
          {sender="Timer_WaitRewardAllMember",msg="Finish",
            func=function()
              TppSequence.SetNextSequence("Seq_Game_RequestCoopEndToServer",{isExecGameOver=true,isExecMissionClear=true})
            end,option={isExecGameOver=true,isExecMissionClear=true}},
          {sender="Timer_WaitUpdateFinalScore",msg="Finish",
            func=function()
              Mission.RequestCoopRewardToServer()
            end,option={isExecGameOver=true,isExecMissionClear=true}}}
      }
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
    end
  }

  instance.sequences.Seq_Game_RequestCoopEndToServer={
    OnEnter=function(e)
      Mission.RequestCoopEndToServer()
      e.isRequestedGameOver=false
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
    OnLeave=function()
    end
  }

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
    TppUiCommand.SetPopupType"POPUP_TYPE_NO_BUTTON_NO_EFFECT"TppUiCommand.ShowErrorPopup(5209)
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
    local targetGimmickTable=instance.targetGimmickTable
    if Gimmick.IsBrokenGimmick(targetGimmickTable.type,targetGimmickTable.locatorName,targetGimmickTable.datasetName,1)then
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
