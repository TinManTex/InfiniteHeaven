local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
local GetGameObjectId=GameObject.GetGameObjectId
local IsTypeTable=Tpp.IsTypeTable
local this={}
function this.CreateInstance(t)
  local instance={}
  instance.questBlockIndex=nil
  instance.questName=t
  local a=string.len(t)
  instance.questId=string.sub(t,a-4,a)
  instance.questTable={}
  instance.questStep={}
  instance.questStepList={"Quest_Main","Quest_Clear"}
  function instance.InitializeQuestSpace(t)
    if not mvars.questSpace then
      mvars.questSpace={}
    end
    if not mvars.questSpace[t]then
      mvars.questSpace[t]={}
    end
  end
  instance.InitializeQuestSpace(t)
  mvars.questSpace[t]={}
  function instance.Messages()
    if IsTypeTable(instance.messageTable)then
      return StrCode32Table(instance.messageTable)
    end
  end
  instance.baseStep={
    OnEnter=function(t)
      if t.markerName then
        TppMarker.Enable(t.markerName,2,"quest","map_only_icon",0,true,true,"quest_"..(tostring(instance.questId).."_name"))
      end
      if t.onEnterRadio then
        TppRadio.Play(t.onEnterRadio)
      end
      if t.OnEnterSub then
        t.OnEnterSub(t)
      end
    end,OnLeave=function(e)
      if e.markerName then
        TppMarker.Disable(e.markerName)
      end
      if e.OnLeaveSub then
        e.OnLeaveSub(e)
      end
    end,Messages=function(e)
      if IsTypeTable(e.messageTable)then
        return StrCode32Table(e.messageTable)
      end
    end}
  function instance.CreateStep(stepName)
    return{stepName=stepName,OnEnter=instance.baseStep.OnEnter,OnLeave=instance.baseStep.OnLeave,Messages=instance.baseStep.Messages}
  end
  function instance.OnAllocate()
    instance.questBlockIndex=TppQuest.RegisterQuestInfo(t)
    TppQuest.RegisterQuestStepList(instance.questBlockIndex,instance.questStepList)
    TppQuest.RegisterQuestStepTable(instance.questBlockIndex,instance.questStep)
    TppQuest.RegisterQuestSystemCallbacks(instance.questBlockIndex,{
      OnActivate=function()
        instance.InitializeQuestSpace(t)
        if not mvars.questSpace[t].isActivate then
          local enemyRouteTableList=instance.enemyRouteTableList
          if IsTypeTable(enemyRouteTableList)then
            for t,e in ipairs(enemyRouteTableList)do
              if(((not e.enemyType or e.enemyType=="SsdZombie")or e.enemyType=="SsdZombieBom")or e.enemyType=="SsdZombieDash")or e.enemyType=="SsdZombieShell"then
                TppEnemy.SetZombieSneakRoute(e.enemyName,e.enemyType,e.routeName)
              else
                TppEnemy.SetInsectSneakRoute(e.enemyName,e.enemyType,e.routeName)
              end
            end
          end
          mvars.questSpace[t].isActivate=true
        end
      end,
      OnDeactivate=function()
      end,
      OnOutOfAcitveArea=function()
      end,
      OnTerminate=function()
        if Tpp.IsTypeFunc(instance.AddOnTerminate)then
          instance.AddOnTerminate()
        end
      end
    })
    mvars.fultonInfo=TppDefine.QUEST_CLEAR_TYPE.NONE
  end
  function instance.OnInitialize()
    TppQuest.QuestBlockOnInitialize(instance)
  end
  function instance.OnUpdate()
    TppQuest.QuestBlockOnUpdate(instance)
  end
  function instance.OnTerminate()
    TppQuest.QuestBlockOnTerminate(instance)
    mvars.questSpace[t]=nil
  end
  instance.questStep.Quest_Main=instance.CreateStep"Quest_Main"
  instance.questStep.Quest_Main.messageTable=Tpp.MergeMessageTable(instance.questStep.Quest_Main.messageTable,{
    Trap={
      {sender="trap_"..t,msg="Enter",func=function(n,n)
        if Tpp.IsTypeFunc(instance.AddOnEnterQuestStartTrap)then
          instance.AddOnEnterQuestStartTrap()
        end
        instance.InitializeQuestSpace(t)
        if not mvars.questSpace[t].isStartQuestArea then
          if not TppQuest.IsSkipStartQuestDemo(t)then
            TppQuest.TelopStart(t)
            local e=instance.startRadio
            if e then
              TppRadio.Play(e)
            end
          end
          mvars.questSpace[t].isStartQuestArea=true
        end
      end,option={isExecFastTravel=true}}}
  })
  instance.questStep.Quest_Clear=instance.CreateStep"Quest_Clear"
  function instance.questStep.Quest_Clear:OnEnter()
    instance.baseStep.OnEnter(self)
    if not mvars.questSpace[t].isEndQuestArea then
      TppQuest.TelopComplete(t)
      local endRadio=instance.endRadio
      if endRadio then
        TppRadio.Play(endRadio)
      end
      TppQuest.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.CLEAR,t)
      mvars.questSpace[t].isEndQuestArea=true
    end
  end
  return instance
end
return this
