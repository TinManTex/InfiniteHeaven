local s={}
function s.CreateInstance(t)
local e=BaseQuest.CreateInstance(t)
e.questType=TppDefine.QUEST_TYPE.RECOVERED
table.insert(e.questStepList,3,"Quest_Escape")
e.messageTable=Tpp.MergeMessageTable(e.messageTable,{GameObject={{msg="Dead",func=function(s)
if s==GameObject.GetGameObjectId(e.target)then
TppQuest.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.FAILURE,t)
end
end}}})
e.questStep.Quest_Main.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Main.messageTable,{GameObject={{msg="Carried",func=function(t,s)
if t==GameObject.GetGameObjectId(e.target)then
TppQuest.SetNextQuestStep(e.questBlockIndex,"Quest_Escape")
end
end}}})
e.questStep.Quest_Escape=e.CreateStep"Quest_Escape"function e.questStep.Quest_Escape:OnEnter()
e.baseStep.OnEnter(self)
TppQuest.OpenWormhole("crewCarry",t)
end
e.questStep.Quest_Escape.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Escape.messageTable,{GameObject={{msg="EnterBaseCheckpoint",func=function()
if TppEnemy.GetStatus(e.target)==TppGameObject.NPC_STATE_CARRIED then
TppQuest.SetNextQuestStep(e.questBlockIndex,"Quest_Clear")
end
end,option={isExecFastTravel=true}}}})
return e
end
return s
