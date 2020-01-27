local l={}
local s=Fox.StrCode32
local e=0
function l.CreateInstance(t)
local e=BaseQuest.CreateInstance(t)
e.questType=TppDefine.QUEST_TYPE.DEFENSE
table.insert(e.questStepList,3,"Quest_DemoDefense")
table.insert(e.questStepList,4,"Quest_Defense")
mvars.questSpace[t].targetStateTable={}
function e.AddOnEnterQuestStartTrap()
local t=e.fasttravelPointName
local a=SsdFastTravel.GetFastTravelPointGimmickIdentifier(t)
TppGimmick.AddUnitInterferer(t,a,6,Vector3(0,10.5,0),true)
end
e.messageTable=Tpp.MergeMessageTable(e.messageTable,{GameObject={{msg="BreakGimmick",func=function(a,s,n)
local a=SsdFastTravel.GetFastTravelPointNameFromGimmick(a,s,n)
if a==e.fasttravelPointName then
if e.failureRadio then
TppRadio.Play(e.failureRadio)
end
TppMusicManager.PostJingleEvent2("SingleShot","DefenseResultFailed")
TppQuest.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.FAILURE,t)
end
end}}})
local a=e.OnAllocate
function e.OnAllocate()a()
local t=e.defenseGameArea
if Tpp.IsTypeString(t)then
e.questStep.Quest_Defense.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Defense.messageTable,{Trap={{msg="Exit",sender=t,func=e.ForceFailureDefenseGame,option={isExecFastTravel=true}}}})
end
local t=e.defenseGameAlertArea
if Tpp.IsTypeString(t)then
e.questStep.Quest_Defense.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Defense.messageTable,{Trap={{msg="Exit",sender=t,func=e.RadioAlertDefenseGame,option={isExecFastTravel=true}}}})
end
end
function e.RadioAlertDefenseGame()
if not mvars.isAlertRadio and e.alertRadio then
mvars.isAlertRadio=true
TppRadio.Play(e.alertRadio)
end
end
function e.ForceFailureDefenseGame()
local e=SsdFastTravel.GetFastTravelPointGimmickIdentifier(e.fasttravelPointName)
if not e then
return
end
Gimmick.BreakGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,e.name,e.dataSetName,false)
end
function e.ClearDefense()
TppMusicManager.PostJingleEvent2("SingleShot","DefenseResult")
TppQuest.SetNextQuestStep(e.questBlockIndex,"Quest_Clear")SsdFastTravel.UnlockFastTravelPoint(e.fasttravelPointName)
end
e.questStep.Quest_Main.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Main.messageTable,{GameObject={{msg="SwitchGimmick",func=function(n,a,t,s)
local t=SsdFastTravel.GetFastTravelPointNameFromGimmick(n,a,t)
if t==e.fasttravelPointName then
TppQuest.SetNextQuestStep(e.questBlockIndex,"Quest_DemoDefense")
end
end}}})
function e.questStep.Quest_Main:OnEnter()
e.baseStep.OnEnter(self)SsdFastTravel.ResetFastTravelPointGimmick(e.fasttravelPointName)SsdFastTravel.UnlockFastTravelPointGimmick(e.fasttravelPointName)SsdFastTravel.ActionFastTravelPointGimmick(e.fasttravelPointName,"Locked",1)
TppQuest.StartWatchingOtherDefenseGame(e.questBlockIndex)
end
e.questStep.Quest_DemoDefense=e.CreateStep"Quest_DemoDefense"function e.questStep.Quest_DemoDefense:OnEnter()
e.baseStep.OnEnter(self)
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"EndFadeOut_QuestDemoDefense",nil,nil)
end
function e.SetInvisibleModel(t)
local e=SsdFastTravel.GetFastTravelPointGimmickIdentifier(e.fasttravelPointName)
if e then
Gimmick.InvisibleModel{gimmickId="GIM_P_Portal",name=e.name,dataSetName=e.dataSetName,isInvisible=t,exceptCollision=true}
end
end
function e.SetActionGimmick()
local t=SsdFastTravel.GetFastTravelPointGimmickIdentifier(e.fasttravelPointName)
if t then
Gimmick.SetAction{gimmickId="GIM_P_Portal",name=t.name,dataSetName=t.dataSetName,action="Defense",param1=1}
end
end
e.questStep.Quest_DemoDefense.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_DemoDefense.messageTable,{UI={{sender="EndFadeOut_QuestDemoDefense",msg="EndFadeOut",func=function()
local n,a=SsdFastTravel.GetFastTravelPointName(s(e.fasttravelPointName))
local l,t=Tpp.GetLocatorByTransform(n,a)t=t*Quat.RotationY(TppMath.DegreeToRadian(180))
local i="p01_000081"local s="_DemoDefense"TppDemo.AddDemo(s,i)DemoDaemon.SetDemoTransform(i,t,l)
local t,a=Tpp.GetLocator(n,a)t[2]=t[2]+1.05
a=a+180
TppPlayer.Warp{pos=t,rotY=a}
local t=GameObject.SendCommand({type="SsdCrew"},{id="GetCarriedCrew"})
if t~=GameObject.NULL_ID then
GameObject.SendCommand(t,{id="SetIgnoreDisableNpc",enable=true})
end
TppDemo.Play(s,{onInit=function()
e.SetInvisibleModel(true)
e.SetActionGimmick()
end,onSkip=function()
e.SetInvisibleModel(false)
e.SetActionGimmick()
end,onEnd=function()Gimmick.RemoveUnitInterferer{key=e.fasttravelPointName}
TppQuest.SetNextQuestStep(e.questBlockIndex,"Quest_Defense")
end},{isSnakeOnly=false})
end}},Demo={{msg="p01_000081_gameModelOn",func=function()
e.SetInvisibleModel(false)
end,option={isExecDemoPlaying=true}}}})
e.questStep.Quest_Defense=e.CreateStep"Quest_Defense"function e.questStep.Quest_Defense:OnEnter()
e.baseStep.OnEnter(self)Mission.LoadDefenseGameDataJson""mvars.isAlertRadio=false
TppQuest.StopWatchingOtherDefenseGame(e.questBlockIndex)
local a=e.waveName
local t
local t=e.enemyWaveWalkSpeedList
if Tpp.IsTypeTable(t)then
for t,e in ipairs(t)do
TppEnemy.SetZombieWaveWalkSpeed(e.enemyName,e.enemyType,e.speed)
end
end
local t=e.enemyWaveByNameTableList
if Tpp.IsTypeTable(t)then
for t,e in ipairs(t)do
TppEnemy.SetWaveByName(e.enemyName,e.enemyType,e.spawnLocator,e.relayLocator1,e.ignoreWave)
end
end
if a then
TppMission.StartInitialWave(a)
end
SsdFastTravel.LockFastTravelPointGimmick(e.fasttravelPointName)
TppQuest.ReserveEnd(e.questBlockIndex)
end
function e.questStep.Quest_Defense:OnLeave()
local a=e.waveName
local a=TppMission.GetWaveProperty(a)
local a=a.endEffectName or"explosion"if not TppQuest.IsFailure(t)then
TppMission.OnClearDefenseGame()
TppEnemy.KillWaveEnemy{effectName=a,soundName="sfx_s_waveend_plasma"}
end
TppMission.StopDefenseGame()
end
e.questStep.Quest_Defense.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Defense.messageTable,{GameObject={{msg="FinishWave",func=function(t,t)
e.ClearDefense()
end},{msg="FinishDefenseGame",func=function()
e.ClearDefense()
end}}})
function e.AddOnTerminate()
if FastTravelSystem.IsUnlocked{identifierLinkName=e.fasttravelPointName}==false then
SsdFastTravel.LockFastTravelPointGimmick(e.fasttravelPointName)
end
Gimmick.RemoveUnitInterferer{key=e.fasttravelPointName}
end
return e
end
return l
