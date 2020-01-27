local e=Fox.StrCode32
local e=Tpp.StrCode32Table
local s=GameObject.GetGameObjectId
local e=Tpp.IsTypeTable
local n={}
function n.CreateInstance(a)
local e=BaseQuest.CreateInstance(a)
e.questType=TppDefine.QUEST_TYPE.COLLECTION
mvars.questSpace[e.questName].targetStateTable={}
function e.InitializeQuestSpaceVehicle(t)
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
function e.IsVehicleTarget(t)
if t==GameObject.GetGameObjectId(e.gameObjectName)then
return true
end
return false
end
function e.SetVehicleEnabled(t)
local e=s(e.gameObjectName)
GameObject.SendCommand(e,{id="SetEnabled",enabled=t})
end
function e.SetWalkerGearRespawn()
local e=s(e.gameObjectName)
GameObject.SendCommand(e,{id="Respawn"})
end
function e.questStep.Quest_Main:OnEnter()
e.baseStep.OnEnter(self)
e.InitializeQuestSpaceVehicle(a)
e.SetVehicleEnabled(true)
if e.isWaklerGear==true then
e.SetWalkerGearRespawn()
end
end
e.questStep.Quest_Main.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Main.messageTable,{Player={{msg="OnVehicleRide_Start",func=function(a,a,t)
if e.IsVehicleTarget(t)then
TppQuest.ReserveEnd(e.questBlockIndex)
TppQuest.SetNextQuestStep(e.questBlockIndex,"Quest_Clear")
end
end}}})
return e
end
return n
