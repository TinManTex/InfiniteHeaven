local a={}
local r=Fox.StrCode32
local s=Tpp.StrCode32Table
local n=Tpp.IsTypeTable
local i=Tpp.IsTypeString
function a.CreateInstance(t)
local e=BaseMissionSequence.CreateInstance(t)
e.NO_RESULT=true
e.sequenceList={"Seq_Demo_SwitchSequence","Seq_Demo_StorySequenceDemo","Seq_Demo_WaitStorySequenceBlackRadio","Seq_Demo_StorySequenceBlackRadio","Seq_Demo_WaitMainGame","Seq_Demo_WaitLoadingMission","Seq_Game_MainGame"}
e.AddSaveVarsList{acceptMissionId=0}
e.missionObjectiveTree={}
function e.AfterMissionPrepare()
local o={OnEstablishMissionClear=function(e)
TppMission.MissionGameEnd()
end,OnDisappearGameEndAnnounceLog=function(e)Player.SetPause()
TppMission.ShowMissionReward()
if(e==TppDefine.MISSION_CLEAR_TYPE.LOCATION_CHANGE_WITH_FAST_TRAVEL)then
TppSoundDaemon.PostEventAndGetHandle("Play_truck_transfer","Loading")
end
end,OnEndMissionReward=function()
TppMission.MissionFinalize{isNoFade=true}
end,OnOutOfMissionArea=function()
TppMission.ReserveGameOver(TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA,TppDefine.GAME_OVER_RADIO.S10020_OUT_OF_MISSION_AREA)
end,OnGameOver=e.OnGameOver,OnUpdateStorySequenceInGame=function()
local e=mvars.bfm_demoScript
if e then
local e=e.GetNextStorySequenceDemoName()
if e then
TppScriptBlock.LoadDemoBlock(e)
end
end
end,OnAlertOutOfDefenseGameArea=function(e)SsdFlagMission.ExecuteSystemCallback("OnAlertOutOfDefenseGameArea",e)
end,OnOutOfDefenseGameArea=function(e)SsdFlagMission.ExecuteSystemCallback("OnOutOfDefenseGameArea",e)
end,nil}
TppMission.RegiserMissionSystemCallback(o)
TppMission.RegisterWaveList(mvars.loc_locationCommomnWaveSettings.waveList)
TppMission.RegisterWavePropertyTable(mvars.loc_locationCommomnWaveSettings.propertyTable)
local o=_G[tostring(t).."_orderBoxList"]
if o then
e.orderBoxBlockList=o.orderBoxBlockList
TppScriptBlock.RegisterCommonBlockPackList("orderBoxBlock",e.orderBoxBlockList)
end
mvars.bfm_sequenceScript=_G[tostring(t).."_sequence"]
mvars.bfm_enemyScript=_G[tostring(t).."_enemy"]
mvars.bfm_demoScript=_G[tostring(t).."_demo"]
mvars.bfm_radioScript=_G[tostring(t).."_radio"]
local e=mvars.bfm_demoScript
if n(e)then
local e=e.GetNextStorySequenceDemoName()
if e then
TppScriptBlock.PreloadRequestOnMissionStart{{demo_block=e}}
end
end
mvars.bfm_checkLoadNextMission=false
mvars.bfm_storySequenceBlackRadioSettings={}
end
function e.AfterOnRestoreSVars()
end
e.messageTable=e.AddMessage(e.messageTable,{UI={{msg="FacilityListMenuMoveToAnotherLocationSelected",func=function()
local e
if TppLocation.IsAfghan()then
e=30020
elseif TppLocation.IsMiddleAfrica()then
if(TppStory.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.BEFORE_s10050)then
e=10050
else
e=30010
end
end
if e then
TppMission.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.LOCATION_CHANGE_WITH_FAST_TRAVEL,nextMissionId=e,isLocationChangeWithFastTravel=true}
end
end},{msg="EndFadeIn",sender="FadeIn_BFM_Seq_Game_MainGame",func=function()
e.StartReturnResult(mvars.bfm_needSaveForMissionStart)
mvars.bfm_needSaveForMissionStart=false
RewardPopupSystem.RequestOpen(RewardPopupSystem.OPEN_TYPE_ALL)SsdFlagMission.Activate()
end}},Mission={{msg="OnBaseDefenseEnd",func=function()
TppSequence.SetNextSequence"Seq_Demo_SwitchSequence"end},{msg="OnFlagMissionUnloaded",func=function()
local e=mvars.bfm_demoScript
if e then
local e=e.GetNextStorySequenceDemoName()
if e then
TppScriptBlock.LoadDemoBlock(e)
end
end
TppSequence.SetNextSequence"Seq_Demo_SwitchSequence"end}},GameObject={{msg="RailPoint",func=function(n,n,e)
if e==r"Terminal"then
mvars.bfm_enemyScript.SetEndKaiju()
end
end,option={isExecFastTravel=true}}},Timer={{msg="Finish",sender="TimerKaijuEnable",func=function()
mvars.bfm_enemyScript.SetStartKaiju()
end,option={isExecFastTravel=true}}}})
function e.PlayStorySequenceRadio()
if e.radioScript and Tpp.IsTypeFunc(e.radioScript.PlayStorySequenceRadio)then
e.radioScript.PlayStorySequenceRadio()
end
end
function e.SetObjectiveInfoAtAnotherLocation()
local e=TppStory.GetObjectiveInfoAtAnotherLocation()
if e then
MissionObjectiveInfoSystem.Clear()
for n,e in ipairs(e)do
MissionObjectiveInfoSystem.SetParam{index=n-1,langId=e}
end
MissionObjectiveInfoSystem.Open()
end
end
function e.SetGuideLinesAtAnotherLocation()
local e=TppStory.GetGuideLineInfoAtAnotherLocation()
if e then
SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{guidelineIDs=e}
end
end
function e.SetMarkerAtAnotherLocation()
local e=TppStory.GetMarkerInfoAtAnotherLocation()
if e then
local n=TppStory.GetCurrentStorySequence()
if n==TppDefine.STORY_SEQUENCE.BEFORE_BASE_DEFENSE_TUTORIAL and TppLocation.IsAfghan()then
else
if(e.location and e.vagueLevel)and e.pos then
local n=SsdMarker.RegisterMarker{type="MISSION_001",flag="ALL_VIEW",vagueLevel=e.vagueLevel,location=e.location,pos=e.pos,enable=true}
if n and e.guidelinesId then
SsdMarker.RegisterMarkerSubInfo{handle=n,guidelinesId=e.guidelinesId}
end
end
end
end
end
function e.IsFlagMissionAllowedToPlayRadio(o)
local t=e.missionAllowedToPlayRadioTable
if n(t)then
return e.missionAllowedToPlayRadioTable[o]
end
end
function e.LoadNextMission()
if SsdFlagMission.GetCurrentFlagMissionName()then
return false
end
local n=TppStory.GetNextMissionInfo()
if not n then
return false
end
if not next(n)then
return false
end
local o=n.missionName
local t=string.sub(o,-5)
local n=n.missionType
local i=SsdMissionList.LOCATION_BY_MISSION_CODE[t]
if not i or i~=TppLocation.GetLocationName()then
if n==Fox.StrCode32"FLAG"or n==Fox.StrCode32"STORY"then
MissionListMenuSystem.SetCurrentMissionCode(tonumber(t))
end
return false
end
if n==Fox.StrCode32"FLAG"then
if Tpp.IsQARelease()or nil then
if tpp_editor_menu2.reentryTable and tpp_editor_menu2.reentryTable.flagStepNumber then
gvars.fms_currentFlagStepNumber=tpp_editor_menu2.reentryTable.flagStepNumber
tpp_editor_menu2.reentryTable.flagStepNumber=nil
SsdFlagMission.LoadMission(o)
return true
end
end
SsdFlagMission.SelectAndLoadMission(o)
return true
elseif n==Fox.StrCode32"STORY"then
local n=tonumber(t)
TppMission.AcceptMissionOnFreeMission(n,e.orderBoxBlockList,"acceptMissionId")
return true
end
return false
end
function e.ShouldReturnSwitchSequence()
if mvars.bfm_checkLoadNextMission then
return false
end
local n=SsdFlagMission.GetCurrentFlagMissionName()
if n then
local e=TppStory.GetNextMissionInfo()
if not e then
return true
end
if not next(e)then
return true
end
local e=e.missionName
if n==e then
return false
end
end
return true
end
e.sequences.Seq_Demo_SwitchSequence={OnEnter=function(e)
local e=mvars.bfm_demoScript
if n(e)then
local e=e.GetCurrentStorySequenceDemoName()
if i(e)then
TppSequence.SetNextSequence"Seq_Demo_StorySequenceDemo"return
end
end
local e=mvars.bfm_radioScript
if n(e)then
local e=e.GetCurrentStorySequenceBlackRadioSettings()
if n(e)then
mvars.bfm_storySequenceBlackRadioSettings=e
TppSequence.SetNextSequence"Seq_Demo_WaitStorySequenceBlackRadio"return
end
end
local e=TppStory.GetCurrentStorySequenceTable()
if n(e)then
if e.reload then
gvars.sav_needCheckPointSaveOnMissionStart=true
TppMission.Reload()
return
end
end
TppSequence.SetNextSequence"Seq_Demo_WaitMainGame"end,OnLeave=function(n)
e.LockAndUnlockUI()
end}
e.sequences.Seq_Demo_StorySequenceDemo={OnEnter=function(e)
local e=mvars.bfm_demoScript
if n(e)then
local e=e.GetCurrentStorySequenceDemoName()
if i(e)then
TppDemo.Play(e,{onStart=function()
TppSoundDaemon.ResetMute"Loading"end,onEnd=function()
if not mvars.bfm_storySequenceDemoFinished then
mvars.bfm_storySequenceDemoFinished={}
end
mvars.bfm_storySequenceDemoFinished[TppStory.GetCurrentStorySequence()]=true
TppPlayer.ResetAroundCameraRotation()
TppStory.UpdateStorySequence{updateTiming="OnStorySequenceDemoFinished"}
TppSequence.SetNextSequence"Seq_Demo_SwitchSequence"end},{isSnakeOnly=false,useDemoBlock=true,finishFadeOut=true})
return
end
end
TppSequence.SetNextSequence"Seq_Demo_WaitMainGame"end,OnLeave=function(e)
TppMission.UpdateCheckPointAtCurrentPosition()
end}
e.sequences.Seq_Demo_WaitStorySequenceBlackRadio={OnEnter=function(e)
local t=mvars.bfm_storySequenceBlackRadioSettings
if not n(t)then
e.EndBlackRadio()
return
end
if not next(t)then
e.EndBlackRadio()
return
end
local n=t[1]
if not i(n)then
e.EndBlackRadio()
return
end
table.remove(mvars.bfm_storySequenceBlackRadioSettings,1)BlackRadio.Close()BlackRadio.ReadJsonParameter(n)
TppSequence.SetNextSequence"Seq_Demo_StorySequenceBlackRadio"end,EndBlackRadio=function()
if not mvars.bfm_storySequenceBlackRadioFinished then
mvars.bfm_storySequenceBlackRadioFinished={}
end
TppSoundDaemon.SetKeepBlackRadioEnable(false)
mvars.bfm_storySequenceBlackRadioFinished[TppStory.GetCurrentStorySequence()]=true
TppStory.UpdateStorySequence{updateTiming="OnStorySequenceBlackRadioFinished"}
TppSequence.SetNextSequence"Seq_Demo_SwitchSequence"end}
e.sequences.Seq_Demo_StorySequenceBlackRadio={Messages=function(e)
return s{UI={{msg="BlackRadioClosed",func=function(e)
TppSequence.SetNextSequence"Seq_Demo_WaitStorySequenceBlackRadio"end,option={isExecMissionClear=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}}}}
end,OnEnter=function(e)
TppSoundDaemon.SetKeepBlackRadioEnable(true)
TppRadio.StartBlackRadio()
end,OnLeave=function(e)
TppMission.UpdateCheckPointAtCurrentPosition()
end}
e.sequences.Seq_Demo_WaitMainGame={OnEnter=function(e)
if not TppSave.IsSaving()then
TppSequence.SetNextSequence"Seq_Demo_WaitLoadingMission"end
end,OnUpdate=function(e)
if not TppSave.IsSaving()then
TppSequence.SetNextSequence"Seq_Demo_WaitLoadingMission"end
end}
e.sequences.Seq_Demo_WaitLoadingMission={OnEnter=function(n)
TppMission.EnableInGameFlag()
mvars.bfm_checkLoadNextMission=true
mvars.bfm_missionLoadedAutomatically=e.LoadNextMission()
if not mvars.bfm_missionLoadedAutomatically then
TppSequence.SetNextSequence"Seq_Game_MainGame"SsdUiSystem.MissionSystemDidStart()
end
end,OnUpdate=function(e)
if SsdFlagMission.IsLoaded()then
TppSequence.SetNextSequence"Seq_Game_MainGame"end
end}
e.sequences.Seq_Game_MainGame={OnEnterCommon=function(n)
if e.ShouldReturnSwitchSequence()then
TppSequence.SetNextSequence"Seq_Demo_SwitchSequence"return
end
mvars.bfm_checkLoadNextMission=true
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeIn_BFM_Seq_Game_MainGame",TppUI.FADE_PRIORITY.MISSION)
TppSoundDaemon.ResetMute"Loading"local n=mvars.bfm_missionLoadedAutomatically
if gvars.fms_currentFlagMissionCode==0 and not n then
e.PlayStorySequenceRadio()
e.SetObjectiveInfoAtAnotherLocation()
e.SetGuideLinesAtAnotherLocation()
e.SetMarkerAtAnotherLocation()
end
TppQuest.UpdateActiveQuest()
end,OnEnter=function(e)
e.OnEnterCommon(e)
end,Messages=function(e)
if e.messageTable then
return s(e.messageTable)
end
end,OnLeaveCommon=function(e)
end,OnLeave=function(e)
e.OnLeaveCommon(e)
end}
return e
end
return a
