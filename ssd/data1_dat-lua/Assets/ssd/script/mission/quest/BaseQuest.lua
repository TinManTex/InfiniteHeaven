local e=Fox.StrCode32
local s=Tpp.StrCode32Table
local e=GameObject.GetGameObjectId
local n=Tpp.IsTypeTable
local a={}
function a.CreateInstance(t)
local e={}
e.questBlockIndex=nil
e.questName=t
local a=string.len(t)
e.questId=string.sub(t,a-4,a)
e.questTable={}
e.questStep={}
e.questStepList={"Quest_Main","Quest_Clear"}
function e.InitializeQuestSpace(t)
if not mvars.questSpace then
mvars.questSpace={}
end
if not mvars.questSpace[t]then
mvars.questSpace[t]={}
end
end
e.InitializeQuestSpace(t)
mvars.questSpace[t]={}
function e.Messages()
if n(e.messageTable)then
return s(e.messageTable)
end
end
e.baseStep={OnEnter=function(t)
if t.markerName then
TppMarker.Enable(t.markerName,2,"quest","map_only_icon",0,true,true,"quest_"..(tostring(e.questId).."_name"))
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
if n(e.messageTable)then
return s(e.messageTable)
end
end}
function e.CreateStep(t)
return{stepName=t,OnEnter=e.baseStep.OnEnter,OnLeave=e.baseStep.OnLeave,Messages=e.baseStep.Messages}
end
function e.OnAllocate()
e.questBlockIndex=TppQuest.RegisterQuestInfo(t)
TppQuest.RegisterQuestStepList(e.questBlockIndex,e.questStepList)
TppQuest.RegisterQuestStepTable(e.questBlockIndex,e.questStep)
TppQuest.RegisterQuestSystemCallbacks(e.questBlockIndex,{OnActivate=function()
e.InitializeQuestSpace(t)
if not mvars.questSpace[t].isActivate then
local e=e.enemyRouteTableList
if n(e)then
for t,e in ipairs(e)do
if(((not e.enemyType or e.enemyType=="SsdZombie")or e.enemyType=="SsdZombieBom")or e.enemyType=="SsdZombieDash")or e.enemyType=="SsdZombieShell"then
TppEnemy.SetZombieSneakRoute(e.enemyName,e.enemyType,e.routeName)
else
TppEnemy.SetInsectSneakRoute(e.enemyName,e.enemyType,e.routeName)
end
end
end
mvars.questSpace[t].isActivate=true
end
end,OnDeactivate=function()
end,OnOutOfAcitveArea=function()
end,OnTerminate=function()
if Tpp.IsTypeFunc(e.AddOnTerminate)then
e.AddOnTerminate()
end
end})
mvars.fultonInfo=TppDefine.QUEST_CLEAR_TYPE.NONE
end
function e.OnInitialize()
TppQuest.QuestBlockOnInitialize(e)
end
function e.OnUpdate()
TppQuest.QuestBlockOnUpdate(e)
end
function e.OnTerminate()
TppQuest.QuestBlockOnTerminate(e)
mvars.questSpace[t]=nil
end
e.questStep.Quest_Main=e.CreateStep"Quest_Main"e.questStep.Quest_Main.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Main.messageTable,{Trap={{sender="trap_"..t,msg="Enter",func=function(n,n)
if Tpp.IsTypeFunc(e.AddOnEnterQuestStartTrap)then
e.AddOnEnterQuestStartTrap()
end
e.InitializeQuestSpace(t)
if not mvars.questSpace[t].isStartQuestArea then
if not TppQuest.IsSkipStartQuestDemo(t)then
TppQuest.TelopStart(t)
local e=e.startRadio
if e then
TppRadio.Play(e)
end
end
mvars.questSpace[t].isStartQuestArea=true
end
end,option={isExecFastTravel=true}}}})
e.questStep.Quest_Clear=e.CreateStep"Quest_Clear"function e.questStep.Quest_Clear:OnEnter()
e.baseStep.OnEnter(self)
if not mvars.questSpace[t].isEndQuestArea then
TppQuest.TelopComplete(t)
local e=e.endRadio
if e then
TppRadio.Play(e)
end
TppQuest.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.CLEAR,t)
mvars.questSpace[t].isEndQuestArea=true
end
end
return e
end
return a
