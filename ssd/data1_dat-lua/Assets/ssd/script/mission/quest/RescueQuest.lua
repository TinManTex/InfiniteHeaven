local this={}
function this.CreateInstance(t)
  local instance=BaseQuest.CreateInstance(t)
  instance.questType=TppDefine.QUEST_TYPE.RECOVERED
  table.insert(instance.questStepList,3,"Quest_Escape")
  instance.messageTable=Tpp.MergeMessageTable(instance.messageTable,{
    GameObject={
      {msg="Dead",func=function(s)
        if s==GameObject.GetGameObjectId(instance.target)then
          TppQuest.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.FAILURE,t)
        end
      end}}
  })
  instance.questStep.Quest_Main.messageTable=Tpp.MergeMessageTable(instance.questStep.Quest_Main.messageTable,{
    GameObject={
      {msg="Carried",func=function(t,s)
        if t==GameObject.GetGameObjectId(instance.target)then
          TppQuest.SetNextQuestStep(instance.questBlockIndex,"Quest_Escape")
        end
      end}}
  })
  instance.questStep.Quest_Escape=instance.CreateStep"Quest_Escape"
  function instance.questStep.Quest_Escape:OnEnter()
    instance.baseStep.OnEnter(self)
    TppQuest.OpenWormhole("crewCarry",t)
  end
  instance.questStep.Quest_Escape.messageTable=Tpp.MergeMessageTable(instance.questStep.Quest_Escape.messageTable,{
    GameObject={
      {msg="EnterBaseCheckpoint",func=function()
        if TppEnemy.GetStatus(instance.target)==TppGameObject.NPC_STATE_CARRIED then
          TppQuest.SetNextQuestStep(instance.questBlockIndex,"Quest_Clear")
        end
      end,option={isExecFastTravel=true}}}
  })
  return instance
end
return this
