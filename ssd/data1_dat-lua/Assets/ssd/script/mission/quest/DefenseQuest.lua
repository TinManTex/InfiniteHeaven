local this={}
local s=Fox.StrCode32
local e=0
function this.CreateInstance(t)
  local instance=BaseQuest.CreateInstance(t)
  instance.questType=TppDefine.QUEST_TYPE.DEFENSE
  table.insert(instance.questStepList,3,"Quest_DemoDefense")
  table.insert(instance.questStepList,4,"Quest_Defense")
  mvars.questSpace[t].targetStateTable={}
  function instance.AddOnEnterQuestStartTrap()
    local t=instance.fasttravelPointName
    local a=SsdFastTravel.GetFastTravelPointGimmickIdentifier(t)
    TppGimmick.AddUnitInterferer(t,a,6,Vector3(0,10.5,0),true)
  end
  instance.messageTable=Tpp.MergeMessageTable(instance.messageTable,{
    GameObject={
      {msg="BreakGimmick",func=function(a,s,n)
        local a=SsdFastTravel.GetFastTravelPointNameFromGimmick(a,s,n)
        if a==instance.fasttravelPointName then
          if instance.failureRadio then
            TppRadio.Play(instance.failureRadio)
          end
          TppMusicManager.PostJingleEvent2("SingleShot","DefenseResultFailed")
          TppQuest.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.FAILURE,t)
        end
      end}}
  })
  local a=instance.OnAllocate
  function instance.OnAllocate()
    a()
    local t=instance.defenseGameArea
    if Tpp.IsTypeString(t)then
      instance.questStep.Quest_Defense.messageTable=Tpp.MergeMessageTable(instance.questStep.Quest_Defense.messageTable,{Trap={{msg="Exit",sender=t,func=instance.ForceFailureDefenseGame,option={isExecFastTravel=true}}}})
    end
    local t=instance.defenseGameAlertArea
    if Tpp.IsTypeString(t)then
      instance.questStep.Quest_Defense.messageTable=Tpp.MergeMessageTable(instance.questStep.Quest_Defense.messageTable,{Trap={{msg="Exit",sender=t,func=instance.RadioAlertDefenseGame,option={isExecFastTravel=true}}}})
    end
  end
  function instance.RadioAlertDefenseGame()
    if not mvars.isAlertRadio and instance.alertRadio then
      mvars.isAlertRadio=true
      TppRadio.Play(instance.alertRadio)
    end
  end
  function instance.ForceFailureDefenseGame()
    local e=SsdFastTravel.GetFastTravelPointGimmickIdentifier(instance.fasttravelPointName)
    if not e then
      return
    end
    Gimmick.BreakGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,e.name,e.dataSetName,false)
  end
  function instance.ClearDefense()
    TppMusicManager.PostJingleEvent2("SingleShot","DefenseResult")
    TppQuest.SetNextQuestStep(instance.questBlockIndex,"Quest_Clear")
    SsdFastTravel.UnlockFastTravelPoint(instance.fasttravelPointName)
  end
  instance.questStep.Quest_Main.messageTable=Tpp.MergeMessageTable(instance.questStep.Quest_Main.messageTable,{
    GameObject={
      {msg="SwitchGimmick",func=function(n,a,t,s)
        local t=SsdFastTravel.GetFastTravelPointNameFromGimmick(n,a,t)
        if t==instance.fasttravelPointName then
          TppQuest.SetNextQuestStep(instance.questBlockIndex,"Quest_DemoDefense")
        end
      end}}
  })
  function instance.questStep.Quest_Main:OnEnter()
    instance.baseStep.OnEnter(self)
    SsdFastTravel.ResetFastTravelPointGimmick(instance.fasttravelPointName)
    SsdFastTravel.UnlockFastTravelPointGimmick(instance.fasttravelPointName)
    SsdFastTravel.ActionFastTravelPointGimmick(instance.fasttravelPointName,"Locked",1)
    TppQuest.StartWatchingOtherDefenseGame(instance.questBlockIndex)
  end
  instance.questStep.Quest_DemoDefense=instance.CreateStep"Quest_DemoDefense"
  function instance.questStep.Quest_DemoDefense:OnEnter()
    instance.baseStep.OnEnter(self)
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"EndFadeOut_QuestDemoDefense",nil,nil)
  end
  function instance.SetInvisibleModel(t)
    local e=SsdFastTravel.GetFastTravelPointGimmickIdentifier(instance.fasttravelPointName)
    if e then
      Gimmick.InvisibleModel{gimmickId="GIM_P_Portal",name=e.name,dataSetName=e.dataSetName,isInvisible=t,exceptCollision=true}
    end
  end
  function instance.SetActionGimmick()
    local t=SsdFastTravel.GetFastTravelPointGimmickIdentifier(instance.fasttravelPointName)
    if t then
      Gimmick.SetAction{gimmickId="GIM_P_Portal",name=t.name,dataSetName=t.dataSetName,action="Defense",param1=1}
    end
  end
  instance.questStep.Quest_DemoDefense.messageTable=Tpp.MergeMessageTable(instance.questStep.Quest_DemoDefense.messageTable,{
    UI={
      {sender="EndFadeOut_QuestDemoDefense",msg="EndFadeOut",func=function()
        local n,a=SsdFastTravel.GetFastTravelPointName(s(instance.fasttravelPointName))
        local l,t=Tpp.GetLocatorByTransform(n,a)
        t=t*Quat.RotationY(TppMath.DegreeToRadian(180))
        local i="p01_000081"
        local s="_DemoDefense"
        TppDemo.AddDemo(s,i)
        DemoDaemon.SetDemoTransform(i,t,l)
        local t,a=Tpp.GetLocator(n,a)
        t[2]=t[2]+1.05
        a=a+180
        TppPlayer.Warp{pos=t,rotY=a}
        local t=GameObject.SendCommand({type="SsdCrew"},{id="GetCarriedCrew"})
        if t~=GameObject.NULL_ID then
          GameObject.SendCommand(t,{id="SetIgnoreDisableNpc",enable=true})
        end
        TppDemo.Play(s,{
          onInit=function()
            instance.SetInvisibleModel(true)
            instance.SetActionGimmick()
          end,
          onSkip=function()
            instance.SetInvisibleModel(false)
            instance.SetActionGimmick()
          end,
          onEnd=function()
            Gimmick.RemoveUnitInterferer{key=instance.fasttravelPointName}
            TppQuest.SetNextQuestStep(instance.questBlockIndex,"Quest_Defense")
          end},{isSnakeOnly=false})
      end}},
    Demo={
      {msg="p01_000081_gameModelOn",func=function()
        instance.SetInvisibleModel(false)
      end,option={isExecDemoPlaying=true}}}
  })
  instance.questStep.Quest_Defense=instance.CreateStep"Quest_Defense"
  function instance.questStep.Quest_Defense:OnEnter()
    instance.baseStep.OnEnter(self)
    Mission.LoadDefenseGameDataJson""
    mvars.isAlertRadio=false
    TppQuest.StopWatchingOtherDefenseGame(instance.questBlockIndex)
    local a=instance.waveName
    local t
    local t=instance.enemyWaveWalkSpeedList
    if Tpp.IsTypeTable(t)then
      for t,e in ipairs(t)do
        TppEnemy.SetZombieWaveWalkSpeed(e.enemyName,e.enemyType,e.speed)
      end
    end
    local t=instance.enemyWaveByNameTableList
    if Tpp.IsTypeTable(t)then
      for t,e in ipairs(t)do
        TppEnemy.SetWaveByName(e.enemyName,e.enemyType,e.spawnLocator,e.relayLocator1,e.ignoreWave)
      end
    end
    if a then
      TppMission.StartInitialWave(a)
    end
    SsdFastTravel.LockFastTravelPointGimmick(instance.fasttravelPointName)
    TppQuest.ReserveEnd(instance.questBlockIndex)
  end
  function instance.questStep.Quest_Defense:OnLeave()
    local a=instance.waveName
    local a=TppMission.GetWaveProperty(a)
    local a=a.endEffectName or"explosion"
    if not TppQuest.IsFailure(t)then
      TppMission.OnClearDefenseGame()
      TppEnemy.KillWaveEnemy{effectName=a,soundName="sfx_s_waveend_plasma"}
    end
    TppMission.StopDefenseGame()
  end
  instance.questStep.Quest_Defense.messageTable=Tpp.MergeMessageTable(instance.questStep.Quest_Defense.messageTable,{
    GameObject={
      {msg="FinishWave",func=function(t,t)
        instance.ClearDefense()
      end},
      {msg="FinishDefenseGame",func=function()
        instance.ClearDefense()
      end}}
  })
  function instance.AddOnTerminate()
    if FastTravelSystem.IsUnlocked{identifierLinkName=instance.fasttravelPointName}==false then
      SsdFastTravel.LockFastTravelPointGimmick(instance.fasttravelPointName)
    end
    Gimmick.RemoveUnitInterferer{key=instance.fasttravelPointName}
  end
  return instance
end
return this
