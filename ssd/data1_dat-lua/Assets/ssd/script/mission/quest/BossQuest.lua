local a={}
local e=Fox.StrCode32
local n=GameObject.GetGameObjectId
local e=Tpp.IsTypeString
local e=Tpp.IsTypeFunc
local e=Tpp.IsTypeNumber
function a.CreateInstance(a)
local e=BaseQuest.CreateInstance(a)
e.questType=TppDefine.QUEST_TYPE.ELIMINATE
table.insert(e.questStepList,3,"Quest_DemoAppearance")
table.insert(e.questStepList,4,"Quest_BossBattle")
mvars.questSpace[e.questName].targetStateTable={}
local t=e.OnAllocate
function e.OnAllocate()t()
local t=e.BossEnableTrapName
if Tpp.IsTypeString(t)then
e.questStep.Quest_Main.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Main.messageTable,{Trap={{msg="Enter",sender=t,func=e.EnableBossArea,option={isExecFastTravel=true}}}})
end
local t=e.demoTrapName
if Tpp.IsTypeString(t)then
e.questStep.Quest_Main.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Main.messageTable,{Trap={{msg="Enter",sender=t,func=e.BossDemoArea,option={isExecFastTravel=true}}}})
end
end
local t=e.OnTerminate
function e.OnTerminate()t()
e.SetBossEnabled(false)
mvars.bossquest_isEnable=false
end
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
function e.SetBossEnabled(t)
if e.gameObjectName then
local e=n(e.gameObjectName)
if e~=NULL_ID then
GameObject.SendCommand(e,{id="SetEnabled",enabled=t})
end
end
end
function e.SetBossRoute()
if(e.gameObjectName and e.gameObjectType)and e.routeName then
local t=GameObject.GetGameObjectId(e.gameObjectType,e.gameObjectName)
if t~=NULL_ID then
GameObject.SendCommand(t,{id="SetSneakRoute",route=e.routeName})
end
end
end
function e.SetSingularityEffect(t)
if e.singularityEffectName then
if t==true then
TppDataUtility.CreateEffectFromGroupId(e.singularityEffectName)
else
TppDataUtility.DestroyEffectFromGroupId(e.singularityEffectName)
end
end
end
function e.OpenDeadWormhole(t)
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
function e.EnableBossArea()
if e.isNoDemo==false then
if gvars[e.gvarsName]==true then
if mvars.bossquest_isEnable==false then
e.SetBossEnabled(true)
e.SetBossRoute()
mvars.bossquest_isEnable=true
end
end
else
if mvars.bossquest_isEnable==false then
e.SetBossEnabled(true)
e.SetBossRoute()
mvars.bossquest_isEnable=true
end
end
end
function e.BossDemoArea()
if e.isNoDemo==false then
if gvars[e.gvarsName]==false then
TppQuest.SetNextQuestStep(e.questBlockIndex,"Quest_DemoAppearance")
end
end
end
e.messageTable=Tpp.MergeMessageTable(e.messageTable,{GameObject={{msg="OpenDeadWormhole",func=function(t)
e.OpenDeadWormhole(t)
end}}})
e.questStep.Quest_Main.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_Main.messageTable,{Block={{msg="OnScriptBlockStateTransition",func=function(t,a)
if t==Fox.StrCode32"creature_block"then
if a==ScriptBlock.TRANSITION_ACTIVATED then
local t=SsdCreatureBlock.GetCurrentInfoName()
if e.creatureBlockName==t then
e.SetBossEnabled(false)
end
end
end
end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}}}})
function e.questStep.Quest_Main:OnEnter()
e.baseStep.OnEnter(self)
mvars.bossquest_isEnable=false
e.SetBossEnabled(false)
if e.isNoDemo==false then
if gvars[e.gvarsName]==false then
TppScriptBlock.LoadDemoBlock(e.demoBlockName,true)
end
end
end
e.questStep.Quest_DemoAppearance=e.CreateStep"Quest_DemoAppearance"function e.questStep.Quest_DemoAppearance:OnEnter()
e.baseStep.OnEnter(self)
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,"EndFadeOut_QuestDemoAppearance",nil,nil)
end
e.questStep.Quest_DemoAppearance.messageTable=Tpp.MergeMessageTable(e.questStep.Quest_DemoAppearance.messageTable,{UI={{sender="EndFadeOut_QuestDemoAppearance",msg="EndFadeOut",func=function()
if e.demoIdentifierName and e.demoPointName then
TppDemo.SetDemoTransform(e.demoName,{identifier=e.demoIdentifierName,locatorName=e.demoPointName})
end
TppDemo.Play(e.demoName,{onInit=function()
e.SetBossEnabled(true)
e.SetBossRoute()
e.SetSingularityEffect(false)
mvars.bossquest_isEnable=true
end,onSkip=function()
end,onEnd=function()GkEventTimerManager.Start("TimerEndBossQuestDemo",1)
end},{isSnakeOnly=false,useDemoBlock=true,finishFadeOut=true,waitBlockLoadEndOnDemoSkip=false})
end},{sender="EndFadeIn_QuestDemoAppearance",msg="EndFadeIn",func=function()gvars[e.gvarsName]=true
e.SetSingularityEffect(true)
TppQuest.SetNextQuestStep(e.questBlockIndex,"Quest_BossBattle")
end}},Timer={{msg="Finish",sender="TimerEndBossQuestDemo",func=function()
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED,"EndFadeIn_QuestDemoAppearance",nil,nil)
end}}})
e.questStep.Quest_BossBattle=e.CreateStep"Quest_BossBattle"function e.questStep.Quest_BossBattle:OnEnter()
e.baseStep.OnEnter(self)
local e=HelpTipsMenuSystem.IsPageOpened(HelpTipsType.TIPS_71_A)
if e==false then
TppTutorial.StartHelpTipsMenu{startRadio="f3010_rtrg2910",tipsTypes={HelpTipsType.TIPS_71_A,HelpTipsType.TIPS_71_B},endFunction=function()
end}
end
end
return e
end
return a
