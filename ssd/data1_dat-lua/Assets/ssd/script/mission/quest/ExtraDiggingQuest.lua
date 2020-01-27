local i={}
local e=Fox.StrCode32
local e=Tpp.IsTypeString
local n=Tpp.IsTypeTable
local e=0
local l="f3000_rtrg0115"function i.StopTimer(e)
if GkEventTimerManager.IsTimerActive(e)then
GkEventTimerManager.Stop(e)
end
end
function i.CreateInstance(t)
local e=BaseQuest.CreateInstance(t)
e.questType=TppDefine.QUEST_TYPE.DEFENSE
table.insert(e.questStepList,3,"Quest_Defense")
table.insert(e.questStepList,4,"Quest_Reward")
local m,a,r,s
mvars.questSpace[t].targetStateTable={}
function e.GetTargetGameObjectId()
local t=Gimmick.SsdGetGameObjectId{gimmickId=e.targetGimmickTable.gimmickId,name=e.targetGimmickTable.locatorName,dataSetName=e.targetGimmickTable.datasetName}
return t
end
e.messageTable=Tpp.MergeMessageTable(e.messageTable,{GameObject={{msg="BreakGimmick",func=function(a,i,i)
if(a==e.GetTargetGameObjectId())then
if e.failureRadio then
TppRadio.Play(e.failureRadio)
end
TppMusicManager.PostJingleEvent2("SingleShot","DefenseResultFailed")
TppQuest.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.FAILURE,t)
end
end}}})
local c=e.OnAllocate
function e.OnAllocate()c()
if not n(e.importantGimmickList)then
return
end
r=e.targetGimmickIndex or 1
if n(e.importantGimmickList[r])then
e.targetGimmickTable=e.importantGimmickList[r]
else
return
end
m=e.waveName
if not Tpp.IsTypeString(m)then
return
end
a=TppMission.GetWaveProperty(m)
if not n(a)then
return
end
local t=e.defenseGameArea
if Tpp.IsTypeString(t)then
e.questStep.Quest_Defense.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Defense.messageTable,{Trap={{msg="Exit",sender=t,func=e.ForceFailureDefenseGame,option={isExecFastTravel=true}}}})
end
local t=e.defenseGameAlertArea
if Tpp.IsTypeString(t)then
e.questStep.Quest_Defense.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Defense.messageTable,{Trap={{msg="Exit",sender=t,func=e.RadioAlertDefenseGame,option={isExecFastTravel=true}}}})
end
local t=a.useSpecifiedAreaEnemy
if n(t)then
if n(t[1])and t[1].pos then
s=t[1].pos
end
else
s=a.defensePosition or a.pos
end
if not s then
return
end
TppGimmick.SetDefenseTargetLevelByWaveProperty(a)Gimmick.SetSsdPowerOff{gimmickId=e.targetGimmickTable.gimmickId,name=e.targetGimmickTable.locatorName,dataSetName=e.targetGimmickTable.datasetName,powerOff=true}
end
local n=e.OnTerminate
function e.OnTerminate()n()
local t=e.GetTargetGameObjectId()MiningMachinePlacementSystem.Unregister(t)
local t={"Timer_ExtraDiggingQuestOpenRewardWormhole","Timer_ExtraDiggingQuestCloseRewardWormhole","Timer_ExtraDiggingQuestStartVanishDigger"}
for t,e in ipairs(t)do
i.StopTimer(e)
end
Gimmick.SetNoTransfering{gimmickId=e.targetGimmickTable.gimmickId,name=e.targetGimmickTable.locatorName,dataSetName=e.targetGimmickTable.datasetName,noTransfering=false}
end
function e.RadioAlertDefenseGame()
if not mvars.isAlertRadio then
mvars.isAlertRadio=true
TppRadio.Play(l)
end
end
function e.ForceFailureDefenseGame()Gimmick.BreakGimmick(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,e.targetGimmickTable.locatorName,e.targetGimmickTable.datasetName,false)
end
function e.SetSingularityEffect(a)
local e=string.sub(t,-6)
local e="singularity_"..tostring(e)
if TppDataUtility.IsReadyEffectFromGroupId(e)then
if a==true then
TppDataUtility.CreateEffectFromGroupId(e)
else
TppDataUtility.DestroyEffectFromGroupId(e)
end
end
end
function e.SetDestroySingularityEffect(a)
local e=string.sub(t,-6)
local e="destroy_singularity_"..tostring(e)
if TppDataUtility.IsReadyEffectFromGroupId(e)then
if a==true then
TppDataUtility.CreateEffectFromGroupId(e)
else
TppDataUtility.DestroyEffectFromGroupId(e)
end
end
end
function e.LoadWaveSettings()
local t=string.sub(t,-6)
local t="/Assets/ssd/level_asset/defense_game/quest/"..(tostring(t)..".json")Mission.LoadDefenseGameDataJson(t)
end
e.questStep.Quest_Main.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Main.messageTable,{GameObject={{msg="BuildingEnd",func=function(t,a,a,a)
if(t==e.GetTargetGameObjectId())then
TppQuest.SetNextQuestStep(e.questBlockIndex,"Quest_Defense")
end
end,option={isExecFastTravel=true}}}})
function e.questStep.Quest_Main:OnEnter()
e.baseStep.OnEnter(self)
e.SetTargetVisibility(false)
e.SetSingularityEffect(true)
local t=e.GetTargetGameObjectId()MiningMachinePlacementSystem.Start()MiningMachinePlacementSystem.Register(t)
TppQuest.StartWatchingOtherDefenseGame(e.questBlockIndex)Gimmick.SetAction{gimmickId=e.targetGimmickTable.gimmickId,name=e.targetGimmickTable.locatorName,dataSetName=e.targetGimmickTable.datasetName,action="SetSupplyMode"}Gimmick.SetAction{gimmickId=e.targetGimmickTable.gimmickId,name=e.targetGimmickTable.locatorName,dataSetName=e.targetGimmickTable.datasetName,action="SetEffectBeam01",string1="dummy"}Gimmick.SetAction{gimmickId=e.targetGimmickTable.gimmickId,name=e.targetGimmickTable.locatorName,dataSetName=e.targetGimmickTable.datasetName,action="SetEffectDownwash01",string1="dummy"}Gimmick.SetAction{gimmickId=e.targetGimmickTable.gimmickId,name=e.targetGimmickTable.locatorName,dataSetName=e.targetGimmickTable.datasetName,action="SetEffectBeam02",string1="BEAM01"}Gimmick.SetAction{gimmickId=e.targetGimmickTable.gimmickId,name=e.targetGimmickTable.locatorName,dataSetName=e.targetGimmickTable.datasetName,action="SetEffectDownwash02",string1="Downwash01"}Gimmick.SetAction{gimmickId=e.targetGimmickTable.gimmickId,name=e.targetGimmickTable.locatorName,dataSetName=e.targetGimmickTable.datasetName,action="SetEffectBeam03",string1="EnergyOuthole03"}
end
function e.questStep.Quest_Main:OnLeave()
e.baseStep.OnLeave(self)
local e=e.GetTargetGameObjectId()MiningMachinePlacementSystem.Unregister(e)
end
function e.SetTargetVisibility(t)Gimmick.InvisibleGimmick(0,e.targetGimmickTable.locatorName,e.targetGimmickTable.datasetName,(not visibility),{gimmickId=e.targetGimmickTable.gimmickId})
end
e.questStep.Quest_Defense=e.CreateStep"Quest_Defense"function e.questStep.Quest_Defense:OnEnter()
e.baseStep.OnEnter(self)
mvars.isAlertRadio=false
TppQuest.StopWatchingOtherDefenseGame(e.questBlockIndex)
e.LoadWaveSettings()GkEventTimerManager.Start("Timer_ExtraDiggingQuestStartSingularityEffect",13.5)Gimmick.SetAction{gimmickId=e.targetGimmickTable.gimmickId,name=e.targetGimmickTable.locatorName,dataSetName=e.targetGimmickTable.datasetName,action="Open"}
TppQuest.ReserveEnd(e.questBlockIndex)
end
function e.questStep.Quest_Defense.StartDefenseGame()
local t=e.enemyWaveWalkSpeedList
if Tpp.IsTypeTable(t)then
for t,e in ipairs(t)do
TppEnemy.SetZombieWaveWalkSpeed(e.enemyName,e.enemyType,e.speed)
end
end
local e=e.enemyWaveByNameTableList
if Tpp.IsTypeTable(e)then
for t,e in ipairs(e)do
TppEnemy.SetWaveByName(e.enemyName,e.enemyType,e.spawnLocator,e.relayLocator1,e.ignoreWave)
end
end
TppMission.StartInitialWave(m)
end
function e.questStep.Quest_Defense.ClearDefenseGame()
TppMusicManager.PostJingleEvent2("SingleShot","DefenseResult")
TppQuest.SetNextQuestStep(e.questBlockIndex,"Quest_Reward")
end
e.questStep.Quest_Defense.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Defense.messageTable,{GameObject={{msg="FinishWave",func=function(t,t)
e.questStep.Quest_Defense.ClearDefenseGame()
end},{msg="FinishDefenseGame",func=function()
e.questStep.Quest_Defense.ClearDefenseGame()
end},{msg="DiggingStartEffectEnd",func=e.questStep.Quest_Defense.StartDefenseGame}},Timer={{msg="Finish",sender="Timer_ExtraDiggingQuestStartSingularityEffect",func=function()
e.SetSingularityEffect(false)
e.SetDestroySingularityEffect(true)
end}}})
function e.questStep.Quest_Defense:OnLeave()
e.baseStep.OnLeave(self)
local a=a.endEffectName or"explosion"if not TppQuest.IsFailure(t)then
TppMission.OnClearDefenseGame()
TppEnemy.KillWaveEnemy{effectName=a,soundName="sfx_s_waveend_plasma"}
end
TppMission.StopDefenseGame()
GameObject.SendCommand({type="TppCommandPost2"},{id="EndWave"})
end
e.questStep.Quest_Reward=e.CreateStep"Quest_Reward"function e.questStep.Quest_Reward:OnEnter()
e.baseStep.OnEnter(self)Gimmick.SetAction{gimmickId=e.targetGimmickTable.gimmickId,name=e.targetGimmickTable.locatorName,dataSetName=e.targetGimmickTable.datasetName,action="Close"}GkEventTimerManager.Start("Timer_ExtraDiggingQuestStartVanishDigger",8)
end
function e.questStep.Quest_Reward:OnLeave()
e.baseStep.OnLeave(self)
local t={"Timer_ExtraDiggingQuestStartVanishDigger"}
for t,e in ipairs(t)do
i.StopTimer(e)
end
end
e.questStep.Quest_Reward.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Reward.messageTable,{Timer={{msg="Finish",sender="Timer_ExtraDiggingQuestStartVanishDigger",func=function()Gimmick.SetVanish{gimmickId=e.targetGimmickTable.gimmickId,name=e.targetGimmickTable.locatorName,dataSetName=e.targetGimmickTable.datasetName}Gimmick.SetNoTransfering{gimmickId=e.targetGimmickTable.gimmickId,name=e.targetGimmickTable.locatorName,dataSetName=e.targetGimmickTable.datasetName,noTransfering=true}
e.ClearDefense()
end}}})
function e.ClearDefense()
TppQuest.SetNextQuestStep(e.questBlockIndex,"Quest_Clear")
end
return e
end
return i
