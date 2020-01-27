local n={}
function n.CreateInstance(a)
local e=BaseQuest.CreateInstance(a)
e.questType=TppDefine.QUEST_TYPE.ANIMAL
mvars.questSpace[a].targetStateTable={}
function e.InitializeQuestSpaceCollection(t)
if not mvars.questSpace then
mvars.questSpace={}
end
if not mvars.questSpace[e.questName]then
mvars.questSpace[t]={}
end
if not mvars.questSpace[t].targetStateTable then
mvars.questSpace[t].targetStateTable={}
end
end
function e.IsTarget(t)
if Tpp.IsTypeTable(e.targetList)then
for a,e in ipairs(e.targetList)do
if t==GameObject.GetGameObjectId(e)then
return true
end
end
end
return false
end
function e.OnDeadFulton(t)
e.InitializeQuestSpaceCollection(a)
if e.IsTarget(t)then
TppQuest.ReserveEnd(e.questBlockIndex)
if not mvars.questSpace[e.questName].targetStateTable[t]then
mvars.questSpace[e.questName].targetStateTable[t]=1
end
if Tpp.IsTypeTable(e.targetList)then
for a,t in ipairs(e.targetList)do
local e=mvars.questSpace[e.questName].targetStateTable[GameObject.GetGameObjectId(t)]
if e~=1 then
return
end
end
TppQuest.SetNextQuestStep(e.questBlockIndex,"Quest_Clear")
end
end
end
e.messageTable=Tpp.MergeMessageTable(e.messageTable,{GameObject={{msg="Dead",func=function(t)
e.OnDeadFulton(t)
end},{msg="Fulton",func=function(t,a,a,a)
e.OnDeadFulton(t)
end}}})
return e
end
return n
