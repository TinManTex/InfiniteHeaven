local m=Fox.StrCode32
local e=Tpp.StrCode32Table
local e=GameObject.GetGameObjectId
local n=Tpp.IsTypeTable
local c={}
function c.CreateInstance(r)
local e=BaseQuest.CreateInstance(r)
e.questType=TppDefine.QUEST_TYPE.COLLECTION
mvars.questSpace[e.questName].targetStateTable={}
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
function e.IsClearCheck(i)
local t=TppQuest.GetGimmickResource(r)
if t==nill then
return
end
local a=false
if i=="None"then
return false
end
if i=="Kub"and t.treasureKubResourceTable then
local t=t.treasureKubResourceTable
if n(t)then
for n,t in ipairs(t)do
if t.gimmickType=="SharedGimmick"then
local t=m(t.name)
if not mvars.questSpace[e.questName].targetStateTable[t]then
return false
end
else
local t=Gimmick.SsdGetGameObjectId{gimmickId=t.gimmickId,name=t.name,dataSetName=t.dataSetName}
if not mvars.questSpace[e.questName].targetStateTable[t]then
return false
end
end
end
a=true
end
end
if i=="TreasureBox"and t.treasureBoxResourceTable then
local t=t.treasureBoxResourceTable
if n(t)then
local n="GIM_P_TreasureBox"for r,t in ipairs(t)do
local t=Gimmick.SsdGetGameObjectId{gimmickId=n,name=t.name,dataSetName=t.dataSetName}
if not mvars.questSpace[e.questName].targetStateTable[t]then
return false
end
end
a=true
end
end
if i=="TreasurePoint"and t.treasurePointResourceTable then
local t=t.treasurePointResourceTable
if n(t)then
local n="GIM_P_TreasurePoint"for r,t in ipairs(t)do
local t=Gimmick.SsdGetGameObjectId{gimmickId=n,name=t.name,dataSetName=t.dataSetName}
if not mvars.questSpace[e.questName].targetStateTable[t]then
return false
end
end
a=true
end
end
return a
end
function e.OnGimmick(i,a,o,c)
local t=TppQuest.GetGimmickResource(r)
if t==nill then
return
end
local u=false
local s="None"if i=="BreakSharedGimmick"then
if t.treasureKubResourceTable then
local t=t.treasureKubResourceTable
if n(t)then
for t,a in ipairs(t)do
local t=m(a.name)
local a=Gimmick.GetDataSetCode(a.dataSetName)
if o==t and c==a then
e.InitializeQuestSpaceCollection(r)
if not mvars.questSpace[e.questName].targetStateTable[t]then
mvars.questSpace[e.questName].targetStateTable[t]=1
u=true
s="Kub"end
end
end
end
end
elseif i=="WormholeFultoned"then
if t.treasureKubResourceTable then
local t=t.treasureKubResourceTable
if n(t)then
for n,t in ipairs(t)do
if t.gimmickId then
if a==Gimmick.SsdGetGameObjectId{gimmickId=t.gimmickId,name=t.name,dataSetName=t.dataSetName}then
e.InitializeQuestSpaceCollection(r)
if not mvars.questSpace[e.questName].targetStateTable[a]then
mvars.questSpace[e.questName].targetStateTable[a]=1
u=true
s="Kub"end
end
end
end
end
end
elseif i=="OpenTreasureBox"then
if t.treasureBoxResourceTable then
local i="GIM_P_TreasureBox"local t=t.treasureBoxResourceTable
if n(t)then
for n,t in ipairs(t)do
if a==Gimmick.SsdGetGameObjectId{gimmickId=i,name=t.name,dataSetName=t.dataSetName}then
e.InitializeQuestSpaceCollection(r)
if not mvars.questSpace[e.questName].targetStateTable[a]then
mvars.questSpace[e.questName].targetStateTable[a]=1
u=true
s="TreasureBox"end
end
end
end
end
elseif i=="PickupTreasurePoint"then
if t.treasurePointResourceTable then
local r="GIM_P_TreasurePoint"local t=t.treasurePointResourceTable
if n(t)then
for n,t in ipairs(t)do
if a==Gimmick.SsdGetGameObjectId{gimmickId=r,name=t.name,dataSetName=t.dataSetName}then
TppQuest.ReserveEnd(e.questBlockIndex)
end
end
end
end
elseif i=="TreasurePointEnd"then
if t.treasurePointResourceTable then
local i="GIM_P_TreasurePoint"local t=t.treasurePointResourceTable
if n(t)then
for n,t in ipairs(t)do
if a==Gimmick.SsdGetGameObjectId{gimmickId=i,name=t.name,dataSetName=t.dataSetName}then
e.InitializeQuestSpaceCollection(r)
if not mvars.questSpace[e.questName].targetStateTable[a]then
mvars.questSpace[e.questName].targetStateTable[a]=1
u=true
s="TreasurePoint"end
end
end
end
end
else
return
end
if u==true then
TppQuest.ReserveEnd(e.questBlockIndex)
if e.IsClearCheck(s)then
TppQuest.SetNextQuestStep(e.questBlockIndex,"Quest_Clear")
end
end
end
function e.questStep.Quest_Main:OnEnter()
e.baseStep.OnEnter(self)
end
e.questStep.Quest_Main.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Main.messageTable,{GameObject={{msg="BreakSharedGimmick",func=function(n,t,a)
e.OnGimmick("BreakSharedGimmick",n,t,a)
end},{msg="WormholeFultoned",func=function(t,a,n)
e.OnGimmick("WormholeFultoned",t,a,n)
end},{msg="OpenTreasureBox",func=function(a,n,t,r)
e.OnGimmick("OpenTreasureBox",a,n,t)
end},{msg="PickupTreasurePoint",func=function(t,a,n,r)
e.OnGimmick("PickupTreasurePoint",t,a,n)
end},{msg="TreasurePointEnd",func=function(t,n,a)
e.OnGimmick("TreasurePointEnd",t,n,a)
end}}})
return e
end
return c
