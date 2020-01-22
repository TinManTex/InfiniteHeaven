local e={}
local o=Fox.StrCode32
local n=Tpp.IsTypeFunc
local i=Tpp.IsTypeTable
local r=DemoDaemon.FindDemoBody
local l=DemoDaemon.IsDemoPlaying
local u=DemoDaemon.IsPlayingDemoId
local m=DemoDaemon.IsDemoPaused
local n=DemoDaemon.GetPlayingDemoId
local t=((5*24)*60)*60
e.MOVET_TO_POSITION_RESULT={[o"success"]="success",[o"failure"]="failure",[o"timeout"]="timeout"}
e.messageExecTable={}
function e.Messages()
return Tpp.StrCode32Table{Player={{msg="DemoSkipped",func=e.OnDemoSkipAndBlockLoadEnd,option={isExecDemoPlaying=true,isExecMissionClear=true,isExecGameOver=true}},{msg="DemoSkipStart",func=e.EnableWaitBlockLoadOnDemoSkip,option={isExecDemoPlaying=true,isExecMissionClear=true,isExecGameOver=true}},{msg="FinishInterpCameraToDemo",func=e.OnEndGameCameraInterp,option={isExecMissionClear=true,isExecGameOver=true}},{msg="FinishMovingToPosition",sender="DemoStartMoveToPosition",func=function(a,n)
local e=e.MOVET_TO_POSITION_RESULT[n]
mvars.dem_waitingMoveToPosition=nil
end,option={isExecMissionClear=true,isExecGameOver=true}}},Demo={{msg="PlayInit",func=e._OnDemoInit,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},{msg="Play",func=e._OnDemoPlay,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},{msg="Finish",func=e._OnDemoEnd,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},{msg="Interrupt",func=e._OnDemoInterrupt,option={isExecMissionClear=true,isExecDemoPlaying=true}},{msg="Skip",func=e._OnDemoSkip,option={isExecMissionClear=true,isExecDemoPlaying=true}},{msg="Disable",func=e._OnDemoDisable},{msg="StartMissionTelop",func=function()
if mvars.dm_doneStartMissionTelop then
return
end
local e=TppMission.GetNextMissionCodeForMissionClear()
TppUI.StartMissionTelop(e)
mvars.dm_doneStartMissionTelop=true
end,option={isExecDemoPlaying=true,isExecMissionClear=true}},{msg="StartCastTelopLeft",func=function()
TppTelop.StartCastTelop"LEFT_START"end,option={isExecDemoPlaying=true,isExecMissionClear=true}},{msg="StartCastTelopRight",func=function()
TppTelop.StartCastTelop"RIGHT_START"end,option={isExecDemoPlaying=true,isExecMissionClear=true}},nil},UI={{msg="EndFadeOut",sender="DemoPlayFadeIn",func=function(n,e)
local e=mvars.dem_invScdDemolist[e]
end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},{msg="DemoPauseSkip",func=e.FadeOutOnSkip,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}}}}
end
e.PLAY_REQUEST_START_FUNC={missionStateCheck=function(n,e)
local n=e.isExecMissionClear
local a=e.isExecGameOver
local e=e.isExecDemoPlaying
if not TppMission.CheckMissionState(n,a,e,false)then
return false
end
return true
end,gameCameraInterpedToDemo=function(e)
if not r(e)then
return
end
if mvars.dem_gameCameraInterpWaitingDemoName~=nil then
return false
end
mvars.dem_gameCameraInterpWaitingDemoName=e
Player.RequestToInterpCameraToDemo(e,1,2,Vector3(.4,.6,-1),true)
return true
end,playerModelReloaded=function(e)
if mvars.dem_tempPlayerInfo~=nil then
return false
end
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT)
mvars.dem_tempPlayerInfo={}
mvars.dem_tempPlayerInfo.playerType=vars.playerType
mvars.dem_tempPlayerInfo.playerPartsType=vars.playerPartsType
mvars.dem_tempPlayerInfo.playerCamoType=vars.playerCamoType
mvars.dem_tempPlayerInfo.playerFaceId=vars.playerFaceId
mvars.dem_tempPlayerInfo.playerFaceEquipId=vars.playerFaceEquipId
TppPlayer.ForceChangePlayerToSnake(true)
mvars.dem_tempPlayerReloadCounter={}
mvars.dem_tempPlayerReloadCounter.start=0
mvars.dem_tempPlayerReloadCounter.finish=0
return true
end,demoBlockLoaded=function(e)
TppScriptBlock.RequestActivate"demo_block"return true
end,playerActionAllowed=function(e)
return true
end,playerMoveToPosition=function(n,e)
if mvars.dem_waitingMoveToPosition then
return false
end
local e=e.playerMoveToPosition
if not e.position then
return false
end
if not e.direction then
return false
end
Player.RequestToSetTargetStance(PlayerStance.STAND)Player.RequestToMoveToPosition{name="DemoStartMoveToPosition",position=e.position,direction=e.direction,onlyInterpPosition=true,timeout=10}
mvars.dem_waitingMoveToPosition=true
return true
end,waitTextureLoadOnDemoPlay=function(e)
mvars.dem_setTempCamera=false
mvars.dem_textureLoadWaitOnDemoPlayEndTime=nil
return true
end}
e.PLAY_REQUEST_START_CHECK_FUNC={missionStateCheck=function(e)
return true
end,gameCameraInterpedToDemo=function(e)
if mvars.dem_gameCameraInterpWaitingDemoName then
return false
else
return true
end
end,demoBlockLoaded=function(e)
local e=r(e)
if not e then
TppUI.ShowAccessIconContinue()
end
return e
end,playerModelReloaded=function(e)
if mvars.dem_tempPlayerReloadCounter==nil then
return false
end
if mvars.dem_tempPlayerReloadCounter.start<10 then
mvars.dem_tempPlayerReloadCounter.start=mvars.dem_tempPlayerReloadCounter.start+1
return false
end
if PlayerInfo.OrCheckStatus{PlayerStatus.PARTS_ACTIVE}then
return true
else
return false
end
end,playerActionAllowed=function(e)
local e=Player.CanPlayDemo(0)
if e==false then
end
return e
end,playerMoveToPosition=function(e)
if mvars.dem_waitingMoveToPosition then
return false
else
return true
end
end,waitTextureLoadOnDemoPlay=function(e)
local n=r(e)
if not n then
TppUI.ShowAccessIconContinue()
return false
end
if not mvars.dem_setTempCamera then
mvars.dem_setTempCamera=true
Demo.EnableTempCamera(e)
end
if not mvars.dem_textureLoadWaitOnDemoPlayEndTime then
mvars.dem_textureLoadWaitOnDemoPlayEndTime=Time.GetRawElapsedTimeSinceStartUp()+10
end
local e=mvars.dem_textureLoadWaitOnDemoPlayEndTime-Time.GetRawElapsedTimeSinceStartUp()
local n=Mission.GetTextureLoadedRate()
if(e<=0)then
return true
else
TppUI.ShowAccessIconContinue()
return false
end
end}
e.FINISH_WAIT_START_FUNC={waitBlockLoadEndOnDemoSkip=function(e)
mvars.dem_enableWaitBlockLoadOnDemoSkip=true
TppGameStatus.Set("TppDemo.OnDemoSkip","S_IS_BLACK_LOADING")
return true
end,waitTextureLoadOnDemoEnd=function(e)
return true
end,playerModelReloaded=function(e)
if mvars.dem_tempPlayerInfo==nil then
return
end
if mvars.dem_donePlayerRestoreFadeOut==nil then
mvars.dem_donePlayerRestoreFadeOut=true
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT)
end
for n,e in pairs(mvars.dem_tempPlayerInfo)do
vars[n]=e
end
mvars.dem_tempPlayerInfo=nil
return true
end}
e.FINISH_WAIT_CHECK_FUNC={waitBlockLoadEndOnDemoSkip=function(e)
if mvars.dem_enableWaitBlockLoadOnDemoSkip then
TppUI.ShowAccessIconContinue()
return false
else
TppGameStatus.Reset("TppDemo.OnDemoSkip","S_IS_BLACK_LOADING")
return true
end
end,waitTextureLoadOnDemoEnd=function(e)
if mvars.dem_enableWaitBlockLoadOnDemoSkip then
return false
end
if not mvars.dem_textureLoadWaitEndTime then
mvars.dem_textureLoadWaitEndTime=Time.GetRawElapsedTimeSinceStartUp()+30
end
local n=mvars.dem_textureLoadWaitEndTime-Time.GetRawElapsedTimeSinceStartUp()
local e=Mission.GetTextureLoadedRate()
if(e>.35)or(n<=0)then
return true
else
TppUI.ShowAccessIconContinue()
return false
end
end,playerModelReloaded=function(e)
if mvars.dem_donePlayerRestoreFadeOut then
mvars.dem_donePlayerRestoreFadeOut=nil
return false
end
if mvars.dem_tempPlayerReloadCounter==nil then
return false
end
if mvars.dem_tempPlayerReloadCounter.finish<10 then
mvars.dem_tempPlayerReloadCounter.finish=mvars.dem_tempPlayerReloadCounter.finish+1
return false
end
if PlayerInfo.OrCheckStatus{PlayerStatus.PARTS_ACTIVE}then
return true
else
return false
end
end}
function e.Play(t,o,n)
local a=mvars.dem_demoList[t]
if(a==nil)then
return
end
mvars.dem_enableWaitBlockLoadOnDemoSkip=false
mvars.dem_demoFuncs[t]=o
n=n or{}
if n.isInGame then
if n.waitBlockLoadEndOnDemoSkip==nil then
n.waitBlockLoadEndOnDemoSkip=false
end
else
if n.isSnakeOnly==nil then
n.isSnakeOnly=true
end
if n.waitBlockLoadEndOnDemoSkip==nil then
n.waitBlockLoadEndOnDemoSkip=true
end
end
if a=="p31_040010_000_final"then
n.waitBlockLoadEndOnDemoSkip=false
mvars.dem_resereveEnableInGameFlag=false
end
if(a=="p51_070020_000_final")or(a=="p21_020010")then
mvars.dem_resereveEnableInGameFlag=false
end
mvars.dem_demoFlags[t]=n
return e.AddPlayReqeustInfo(a,n)
end
function e.EnableGameStatus(t,e)
local n=e or{}
local e=TppUI.GetOverrideGameStatus()
if e then
for e,a in pairs(e)do
n[e]=a
end
end
Tpp.SetGameStatus{target=t,except=n,enable=true,scriptName="TppDemo.lua"}
end
function e.DisableGameStatusOnPlayRequest(e)
if not e then
Tpp.SetGameStatus{target="all",enable=false,except={S_DISABLE_NPC=false},scriptName="TppDemo.lua"}
end
end
function e.DisableGameStatusOnPlayStart()
if e.IsNotPlayable()then
HighSpeedCamera.RequestToCancel()
Tpp.SetGameStatus{target="all",enable=false,scriptName="TppDemo.lua"}
end
end
function e.OnEndGameCameraInterp()
if mvars.dem_gameCameraInterpWaitingDemoName==nil then
end
mvars.dem_gameCameraInterpWaitingDemoName=nil
end
function e.PlayOnDemoBlock()
e.ProcessPlayRequest(mvars.demo_playRequestInfo.demoBlock)
end
function e.FinalizeOnDemoBlock()
if l()then
DemoDaemon.SkipAll()
end
end
function e.SetDemoTransform(n,e)
local t=mvars.dem_demoList[n]
if(t==nil)then
return
end
if(i(e)==false)then
return
end
local n
local a
if(e.usePlayer==true)then
n=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)a=Quat.RotationY(TppMath.DegreeToRadian(vars.playerRotY))
elseif(e.identifier and e.locatorName)then
n,a=Tpp.GetLocatorByTransform(e.identifier,e.locatorName)
else
return
end
if n==nil then
return
end
DemoDaemon.SetDemoTransform(t,a,n)
end
function e.GetDemoStartPlayerPosition(e)
local e=mvars.dem_demoList[e]
if(e==nil)then
return
end
local e,a,n=DemoDaemon.GetStartPosition(e,"Player")
if not e then
return
end
local e=Tpp.GetRotationY(n)
local e={position=a,direction=e}
return e
end
function e.PlayOpening(u,n)
local s=n or{}s.isSnakeOnly=false
local l="_openingDemo"local a="p31_020000"local n={"p31_020000","p31_020001","p31_020002"}
local t=math.random(#n)a=n[t]
e.AddDemo(l,a)
local r,t
local n,o
local m=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
local i=Vector3(0,0,1.98)
local d=Quat.RotationY(TppMath.DegreeToRadian(vars.playerRotY))
if gvars.mis_orderBoxName~=0 and mvars.mis_orderBoxList~=nil then
local e=TppMission.FindOrderBoxName(gvars.mis_orderBoxName)
if e~=nil then
n,o=TppMission.GetOrderBoxLocatorByTransform(e)
end
end
if n then
local e=-o:Rotate(i)r=e+n
t=o
else
local e=-d:Rotate(i)r=e+m
t=d
end
DemoDaemon.SetDemoTransform(a,t,r)
e.Play(l,u,s)
end
function e.PlayGetIntelDemo(d,l,i,n,o)
local t=n or{}t.isSnakeOnly=false
local n,a
if o then
n,a="p31_010026","p31_010026_001"else
n,a="p31_010025","p31_010025_001"end
local r="_getInteldemo"local o="_getInteldemo02"e.AddDemo(r,n)
e.AddDemo(o,a)
local a,o=Tpp.GetLocatorByTransform(l,i)
local i=Tpp.GetRotationY(o)Player.RequestToSetTargetStance(PlayerStance.STAND)
if a~=nil then
DemoDaemon.SetDemoTransform(n,o,a)
e.Play(r,d,t)
TppUI.ShowAnnounceLog"getIntel"end
end
function e.IsNotPlayable()
return false
end
function e.ReserveEnableInGameFlag()
mvars.dem_resereveEnableInGameFlag=true
end
function e.EnableInGameFlagIfResereved()
if mvars.dem_resereveEnableInGameFlag then
mvars.dem_resereveEnableInGameFlag=false
TppMission.EnableInGameFlag()
end
end
function e.ReserveInTheBackGround(n)
if not i(n)then
return
end
local a=n.demoName
local a=mvars.dem_demoList[a]
if not a then
return
end
mvars.dem_reservedDemoId=a
mvars.dem_reservedDemoLoadPosition=n.position
local a=true
if n.playerPause then
a=n.playerPause
end
if a then
mvars.dem_reservedPlayerWarpAndPause=true
e.SetPlayerPause()
end
end
function e.ExecuteBackGroundLoad(n)
if mvars.dem_reservedDemoLoadPosition then
e.SetStageBlockLoadPosition(mvars.dem_reservedDemoLoadPosition)
e.SetPlayerWarpAndPause(mvars.dem_reservedDemoLoadPosition)
mvars.dem_DoneBackGroundLoading=true
else
local a,n,t=DemoDaemon.GetStartPosition(n,"Player")
if not a then
mvars.dem_DoneBackGroundLoading=true
return
end
e.SetStageBlockLoadPosition(n)
e.SetPlayerWarp(n,t)
mvars.dem_DoneBackGroundLoading=true
end
end
function e.SetStageBlockLoadPosition(e)
TppGameStatus.Set("TppDemo.ReserveInTheBackground","S_IS_BLACK_LOADING")
mvars.dem_isSetStageBlockPosition=true
StageBlockCurrentPositionSetter.SetEnable(true)StageBlockCurrentPositionSetter.SetPosition(e:GetX(),e:GetZ())
end
function e.SetPlayerPause()
mvars.dem_isPlayerPausing=true
Player.SetPause()
end
function e.SetPlayerWarp(e,n)
mvars.dem_isPlayerPausing=true
Player.SetPause()
local a={type="TppPlayer2",index=0}
local e={id="WarpAndWaitBlock",pos={e:GetX(),e:GetY(),e:GetZ()},rotY=n}
GameObject.SendCommand(a,e)
end
function e.UnsetStageBlockLoadPosition()
TppGameStatus.Reset("TppDemo.ReserveInTheBackground","S_IS_BLACK_LOADING")
if mvars.dem_isSetStageBlockPosition then
StageBlockCurrentPositionSetter.SetEnable(false)
end
mvars.dem_isSetStageBlockPosition=false
end
function e.UnsetPlayerPause()
if mvars.dem_isPlayerPausing then
Player.UnsetPause()
end
mvars.dem_isPlayerPausing=false
end
function e.ClearReserveInTheBackGround()
mvars.dem_reservedDemoId=nil
mvars.dem_reservedDemoLoadPosition=nil
end
function e.CheckEventDemoDoor(a,n,e)
local o=TppPlayer.GetPosition()
local t=30
if a==nil then
return false
end
if Tpp.IsTypeTable(n)then
o=n
elseif n==nil then
end
if Tpp.IsTypeNumber(e)and e>0 then
t=e
elseif e==nil then
end
local e=0
local l,i=0,1
local r=Tpp.IsNotAlert()
local t=TppEnemy.IsActiveSoldierInRange(o,t)
local n
if r==true and t==false then
e=l
n=true
else
e=i
n=false
end
Player.SetEventLockDoorIcon{doorId=a,isNgIcon=e}
return n,r,(not t)
end
function e.SpecifyIgnoreNpcDisable(e)
local n
if Tpp.IsTypeString(e)then
n={e}
elseif i(e)then
n=e
else
return
end
mvars.dem_npcDisableList=mvars.dem_npcDisableList or{}
for n,e in ipairs(n)do
local n=TppEnemy.SetIgnoreDisableNpc(e,true)
if n then
table.insert(mvars.dem_npcDisableList,e)
end
end
end
function e.ClearIgnoreNpcDisableOnDemoEnd()
if not mvars.dem_npcDisableList then
return
end
for n,e in ipairs(mvars.dem_npcDisableList)do
TppEnemy.SetIgnoreDisableNpc(e,false)
end
mvars.dem_npcDisableList=nil
end
function e.IsPlayedMBEventDemo(e)
local e=TppDefine.MB_FREEPLAY_DEMO_ENUM[e]
if e then
return gvars.mbFreeDemoPlayedFlag[e]
end
end
function e.ClearPlayedMBEventDemoFlag(e)
local e=TppDefine.MB_FREEPLAY_DEMO_ENUM[e]
if e then
gvars.mbFreeDemoPlayedFlag[e]=false
end
end
function e.OnAllocate(n)
mvars.dem_demoList={}
mvars.dem_invDemoList={}
mvars.dem_invScdDemolist={}
mvars.dem_demoFuncs={}
mvars.dem_demoFlags={}
mvars.dem_playedList={}
mvars.dem_isSkipped={}
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
mvars.demo_playRequestInfo={}
mvars.demo_playRequestInfo={missionBlock={},demoBlock={}}
mvars.demo_finishWaitRequestInfo={}
local n=n.demo
if n and i(n.demoList)then
e.Register(n.demoList)
end
end
function e.Init(n)
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnReload(n)
e.OnAllocate(n)
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.Update()
local n=mvars
local e=e
if n.dem_reservedDemoId then
if r(n.dem_reservedDemoId)then
if not n.dem_DoneBackGroundLoading then
e.ExecuteBackGroundLoad(n.dem_reservedDemoId)
end
end
end
e.ProcessPlayRequest(n.demo_playRequestInfo.missionBlock)
e.ProcessFinishWaitRequestInfo()
end
function e.Register(e)
mvars.dem_demoList=e
for e,n in pairs(e)do
mvars.dem_invDemoList[n]=e
mvars.dem_invScdDemolist[o(n)]=e
end
end
function e.AddDemo(e,n)
mvars.dem_demoList[e]=n
mvars.dem_invDemoList[n]=e
mvars.dem_invScdDemolist[o(n)]=e
end
function e.OnMessage(t,o,r,i,l,a,n)
Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,t,o,r,i,l,a,n)
end
function e.FadeOutOnSkip()
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT)
end
function e.OnDemoPlay(n,a)
if mvars.dem_playedList[n]==nil then
return
end
local n=mvars.dem_demoFlags[n]or{}
if not n.startNoFadeIn then
local e=n.fadeSpeed or TppUI.FADE_SPEED.FADE_NORMALSPEED
TppUI.FadeIn(e,"DemoPlayFadeIn",a)
end
if n.useDemoBlock then
mvars.dem_startedDemoBlockDemo=false
end
if mvars.dem_resereveEnableInGameFlag then
if TppMission.GetMissionClearState()<=TppDefine.MISSION_CLEAR_STATE.MISSION_GAME_END then
TppSoundDaemon.ResetMute"Loading"end
end
e.UnsetStageBlockLoadPosition()
e.UnsetPlayerPause()
end
function e.OnDemoEnd(a)
if mvars.dem_playedList[a]==nil then
return
end
local n=mvars.dem_demoFlags[a]or{}
local a=mvars.dem_demoList[a]
local t={p31_070050_001_final=true}
if t[a]then
TppSound.SetMuteOnLoading()
end
if mvars.dem_tempPlayerInfo then
e.AddFinishWaitRequestInfo(a,n,"playerModelReloaded")
end
if n.waitTextureLoadOnDemoEnd then
e.AddFinishWaitRequestInfo(a,n,"waitTextureLoadOnDemoEnd")
end
e.AddFinishWaitRequestInfo(a,n)
end
function e.OnDemoInterrupt(n)
if mvars.dem_playedList[n]==nil then
return
end
e.OnDemoEnd(n)
end
function e.OnDemoSkip(e,a)
local n=mvars.dem_demoList[e]
local t=mvars.dem_demoFlags[e]or{}
local t={p31_010010=true,p41_030005_000_final=true,p51_070020_000_final=true,p31_050026_000_final=true}
if t[n]then
TppSoundDaemon.SetMuteInstant"Loading"end
mvars.dem_isSkipped[n]=true
mvars.dem_currentSkippedDemoName=e
mvars.dem_currentSkippedScdDemoID=a
if mvars.dem_playedList[e]==nil then
return
end
end
function e.EnableWaitBlockLoadOnDemoSkip()
local a=mvars.dem_currentSkippedDemoName
if not a then
return
end
local n=mvars.dem_demoFlags[a]or{}
local a=mvars.dem_demoList[a]
if n.waitBlockLoadEndOnDemoSkip then
e.AddFinishWaitRequestInfo(a,n,"waitBlockLoadEndOnDemoSkip")
if not n.finishFadeOut then
e.AddFinishWaitRequestInfo(a,n,"waitTextureLoadOnDemoEnd")
end
end
end
function e.OnDemoSkipAndBlockLoadEnd()
if mvars.dem_enableWaitBlockLoadOnDemoSkip~=nil then
mvars.dem_enableWaitBlockLoadOnDemoSkip=nil
end
end
function e.DoOnEndMessage(n,o,a,r,t)
if(not o)then
local e=true
if r and(not t)then
e=false
end
if e then
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"DemoSkipFadeIn",mvars.dem_currentSkippedScdDemoID,{exceptGameStatus=a})
end
end
e._DoMessage(n,"onEnd")
mvars.dem_currentSkippedDemoName=nil
mvars.dem_currentSkippedScdDemoID=nil
e.EnableInGameFlagIfResereved()
e.EnableNpc(n)
end
function e.OnDemoDisable(n)
if mvars.dem_playedList[n]==nil then
return
end
e.OnDemoEnd(n)
end
function e.AddPlayReqeustInfo(t,n)
local a=e.MakeNewPlayRequestInfo(n)
for r,o in pairs(a)do
local o=true
local e=e.PLAY_REQUEST_START_FUNC[r]
if e then
o=e(t,n)
else
if e==nil then
a[r]=nil
o=true
end
end
if not o then
return false
end
end
if not n.isInGame then
TppRadio.Stop()
end
e.DisableGameStatusOnPlayRequest(n.isInGame)
if n and n.useDemoBlock then
mvars.demo_playRequestInfo.demoBlock[t]=a
else
mvars.demo_playRequestInfo.missionBlock[t]=a
end
return true
end
function e.MakeNewPlayRequestInfo(e)
if e==nil then
return{}
end
local o
if e.interpGameToDemo then
o=false
end
local t
if e.useDemoBlock then
t=false
end
local a
if e.isSnakeOnly then
if(vars.playerType==PlayerType.DD_MALE or vars.playerType==PlayerType.DD_FEMALE)then
a=false
end
end
local n
if(not e.isInGame)or(e.isNotAllowedPlayerAction)then
n=false
end
local r
if e.playerMoveToPosition then
r=false
end
local i
if e.waitTextureLoadOnDemoPlay then
i=false
end
local e={missionStateCheck=false,gameCameraInterpedToDemo=o,demoBlockLoaded=t,playerModelReloaded=a,playerActionAllowed=n,playerMoveToPosition=r,waitTextureLoadOnDemoPlay=i}
return e
end
function e.DeletePlayRequestInfo(n,e)
if e and e.useDemoBlock then
mvars.demo_playRequestInfo.demoBlock[n]=nil
else
mvars.demo_playRequestInfo.missionBlock[n]=nil
end
end
function e.ProcessPlayRequest(n)
if not next(n)then
return
end
for n,a in pairs(n)do
local a=e.CanStartPlay(n,a)
if a then
if not m()then
if not u(n)then
local a=mvars.dem_invDemoList[n]
local t=mvars.dem_demoFlags[a]
e._Play(a,n)
e.DeletePlayRequestInfo(n,t)
end
end
end
end
end
function e.CanStartPlay(r,t)
local n=true
for a,o in pairs(t)do
if o==false then
local e=e.PLAY_REQUEST_START_CHECK_FUNC[a](r)
if e then
t[a]=true
else
n=false
end
end
end
return n
end
function e.AddFinishWaitRequestInfo(t,a,n)
local a
local o=true
if n then
a=e.FINISH_WAIT_START_FUNC[n]
if a then
o=a(t)
else
return
end
end
local e
e=mvars.demo_finishWaitRequestInfo[t]or{}
if(o==true)then
if n then
e[n]=false
end
else
return
end
mvars.demo_finishWaitRequestInfo[t]=e
end
function e.ProcessFinishWaitRequestInfo()
local n=mvars.demo_finishWaitRequestInfo
if not next(n)then
return
end
for a,n in pairs(n)do
local n=e.CanFinishPlay(a,n)
if n then
local t=mvars.dem_invDemoList[a]
local n=mvars.dem_demoFlags[t]or{}
mvars.demo_finishWaitRequestInfo[a]=nil
e.DoOnEndMessage(t,n.finishFadeOut,n.exceptGameStatus,n.isInGame,mvars.dem_isSkipped[a])
if(not n.finishFadeOut)and(not n.isInGame)then
TppTerminal.GetFobStatus()
end
end
end
end
function e.CanFinishPlay(r,t)
local n=true
for a,o in pairs(t)do
if o==false then
local e=e.FINISH_WAIT_CHECK_FUNC[a](r)
if e then
t[a]=true
else
n=false
end
end
end
return n
end
function e._Play(n,a)
mvars.dem_playedList[n]=true
e.ClearReserveInTheBackGround()DemoDaemon.Play(a)
end
function e._OnDemoInit(e)
end
function e._OnDemoPlay(e)
end
function e._OnDemoEnd(e)
end
function e._OnDemoInterrupt(e)
end
function e._OnDemoSkip(e)
end
function e._OnDemoDisable(e)
end
function e._DoMessage(n,a)
if((mvars.dem_demoFuncs==nil or mvars.dem_demoFuncs[n]==nil)or mvars.dem_demoFuncs[n][a]==nil)then
return
end
mvars.dem_demoFuncs[n][a]()
end
e.mtbsPriorityFuncList={TheGreatEscapeLiquid=function()
return false
end,NuclearEliminationCeremony=function()
if not gvars.f30050_isInitNuclearAbolitionCount then
return false
end
local a=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
local e=TppServerManager.GetNuclearAbolitionCount()
local n=e>=0
local e=gvars.f30050_NuclearAbolitionCount<e
return(n and a)and e
end,ForKeepNuclearElimination=function()
return false
end,SacrificeOfNuclearElimination=function()
return false
end,GoToMotherBaseAfterQuietBattle=function()
return gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterQuietBattle]
end,ArrivedMotherBaseLiquid=function()
return gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterWhiteMamba]
end,ArrivedMotherBaseFromDeathFactory=function()
return gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterDethFactory]
end,EntrustDdog=function()
if e.IsPlayedMBEventDemo"EntrustDdog"then
return false
end
if TppBuddyService.DidObtainBuddyType(BuddyType.DOG)then
return true
else
return false
end
end,DdogComeToGet=function()
if e.IsPlayedMBEventDemo"DdogComeToGet"then
return false
end
local e=TppStory.GetClearedMissionCount{10036,10043,10033}>=2
local n=TppBuddyService.DidObtainBuddyType(BuddyType.DOG)
local a=not TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
local t=TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_COME_TO_GET)
return((e and n)and a)and t
end,DdogGoWithMe=function()
local a=TppStory.GetClearedMissionCount{10041,10044,10052,10054}>=3
local e=not TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
local n=TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_GO_WITH_ME)
return(a and e)and n
end,LongTimeNoSee_DDSoldier=function()
local n=TppStory.IsMissionCleard(10030)
local e=gvars.elapsedTimeSinceLastPlay>=t
return n and e
end,LongTimeNoSee_DdogPup=function()
local e=gvars.elapsedTimeSinceLastPlay>=t
local n=TppBuddyService.DidObtainBuddyType(BuddyType.DOG)
local a=not TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
return(e and n)and a
end,LongTimeNoSee_DdogLowLikability=function()
local n=TppStory.IsMissionCleard(10050)
local e=gvars.elapsedTimeSinceLastPlay>=t
local a=TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
local t=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG)<25
return((n and e)and a)and t
end,LongTimeNoSee_DdogHighLikability=function()
local a=TppStory.IsMissionCleard(10050)
local t=gvars.elapsedTimeSinceLastPlay>=t
local e=TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
local n=25<=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG)and TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG)<75
return((a and t)and e)and n
end,LongTimeNoSee_DdogSuperHighLikability=function()
local a=TppStory.IsMissionCleard(10050)
local n=gvars.elapsedTimeSinceLastPlay>=t
local e=TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
local t=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG)>=75
return((a and n)and e)and t
end,AttackedFromOtherPlayer_KnowWhereFrom=function()
if e.IsPlayedMBEventDemo"AttackedFromOtherPlayer_KnowWhereFrom"or e.IsPlayedMBEventDemo"AttackedFromOtherPlayer_UnknowWhereFrom"then
return false
end
local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_CAPTURE_THE_WEAPON_DEALER
local e=vars.mbmDemoAttackedFromOtherPlayerKnowWhereFrom~=0
return n and e
end,AttackedFromOtherPlayer_UnknowWhereFrom=function()
if e.IsPlayedMBEventDemo"AttackedFromOtherPlayer_KnowWhereFrom"or e.IsPlayedMBEventDemo"AttackedFromOtherPlayer_UnknowWhereFrom"then
return false
end
local e=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_CAPTURE_THE_WEAPON_DEALER
local n=vars.mbmRequestDemoAttackedFromOtherPlayer~=0
return e and n
end,MoraleOfMBIsLow=function()
if e.IsPlayedMBEventDemo"MoraleOfMBIsLow"then
return false
end
local e=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE
local n=vars.mbmTppGmp<0
return e and n
end,OcelotIsPupilOfSnake=function()
if e.IsPlayedMBEventDemo"OcelotIsPupilOfSnake"then
return false
end
local a=TppStory.IsMissionCleard(10040)
local e=0
for n=TppMotherBaseManagementConst.SECTION_COMBAT,TppMotherBaseManagementConst.SECTION_SECURITY do
e=e+#TppMotherBaseManagement.GetOutOnMotherBaseStaffs{sectionId=n}
end
local e=e>=3
return a and e
end,HappyBirthDay=function()
if e.IsPlayedMBEventDemo"HappyBirthDay"then
return false
end
local e=TppUiCommand.IsBirthDay()
local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE
local a=TppStory.GetClearedMissionCount{10036,10043,10033}>=1
return(e and n)and a
end,HappyBirthDayWithQuiet=function()
return false
end,QuietOnHeliInRain=function()
if e.IsPlayedMBEventDemo"QuietOnHeliInRain"then
return false
else
local e=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
local t=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.QUIET)>=80
local a=(vars.buddyType==BuddyType.QUIET)
local n=TppStory.CanArrivalQuietInMB(false)
return((e and t)and a)and n
end
end,QuietHasFriendshipWithChild=function()
if e.IsPlayedMBEventDemo"QuietHasFriendshipWithChild"then
return false
else
local n=TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE.Medical+1)>=2
local e=TppStory.CanArrivalQuietInMB(true)
local t=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
local a=not(TppQuest.IsOpen"outland_q20913"or TppQuest.IsOpen"lab_q20914")
return((n and e)and t)and a
end
end,QuietWishGoMission=function()
if e.IsPlayedMBEventDemo"QuietWishGoMission"then
return false
end
if TppStory.CanArrivalQuietInMB(false)then
if TppQuest.IsOpen"mtbs_q99011"then
return TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.QUIET_WITH_GO_MISSION)
else
return true
end
end
end,QuietReceivesPersecution=function()
return false
end,SnakeHasBadSmell_WithoutQuiet=function()
if e.IsPlayedMBEventDemo"SnakeHasBadSmell_WithoutQuiet"then
return false
end
local e=TppStory.IsMissionCleard(10040)
local n=Player.GetSmallFlyLevel()>=1
return e and n
end,SnakeHasBadSmell_000=function()
if e.IsPlayedMBEventDemo"SnakeHasBadSmell_000"then
return false
end
local n=TppStory.IsMissionCleard(10086)
local t=TppStory.CanArrivalQuietInMB(false)
local a=Player.GetSmallFlyLevel()>=1
local e=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.QUIET)>=60
return((n and t)and a)and e
end,SnakeHasBadSmell_001=function()
return false
end,EliLookSnake=function()
if e.IsPlayedMBEventDemo"EliLookSnake"then
return false
end
return false
end,LiquidAndChildSoldier=function()
if e.IsPlayedMBEventDemo"LiquidAndChildSoldier"then
return false
end
local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA
local e=TppQuest.IsOpen"sovietBase_q99030"return n and not e
end,InterrogateQuiet=function()
if e.IsPlayedMBEventDemo"InterrogateQuiet"then
return false
else
local a=TppStory.CanArrivalQuietInMB(true)
local e=TppQuest.IsOpen"sovietBase_q99030"local n=not TppRadio.IsPlayed"f2000_rtrg8290"return(a and e)and n
end
end,AnableDevBattleGear=function()
if e.IsPlayedMBEventDemo"AnableDevBattleGear"then
return false
end
return TppRadio.IsPlayed"f2000_rtrg8175"and(TppStory.GetClearedMissionCount{10085,10200}==0)
end,CodeTalkerSunBath=function()
if e.IsPlayedMBEventDemo"CodeTalkerSunBath"then
return false
end
local e=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
local n=TppStory.IsMissionCleard(10130)
return e and n
end,ParasiticWormCarrierKill=function()
return false
end,DecisionHuey=function()
if e.IsPlayedMBEventDemo"DecisionHuey"then
return false
end
if TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.DECISION_HUEY)and TppRadio.IsPlayed"f2000_rtrg8410"then
return true
else
return false
end
end,DetailsNuclearDevelop=function()
return false
end,EndingSacrificeOfNuclear=function()
return false
end}
function e.UpdateHappyBirthDayFlag()
if e.IsPlayedMBEventDemo"HappyBirthDay"then
if TppUiCommand.IsBirthDay()then
if gvars.elapsedTimeSinceLastPlay>(24*60)*60 and(not gvars.isPlayedHappyBirthDayToday)then
e.ClearPlayedMBEventDemoFlag"HappyBirthDay"end
else
e.ClearPlayedMBEventDemoFlag"HappyBirthDay"gvars.isPlayedHappyBirthDayToday=false
end
end
end
function e.GetMBDemoName()
return TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST[gvars.mbFreeDemoPlayNextIndex]
end
function e.UpdateMBDemo()
e.UpdateHappyBirthDayFlag()
gvars.mbFreeDemoPlayNextIndex=0
for n,a in ipairs(TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST)do
local e=e.mtbsPriorityFuncList[a]
if e and e()then
gvars.mbFreeDemoPlayNextIndex=n
return
end
end
end
function e.IsUseMBDemoStage(e)
if e then
for a,n in pairs(TppDefine.MB_FREEPLAY_LARGEDEMO)do
if n==e then
return true
end
end
end
return false
end
function e.SetNextMBDemo(e)
local n=TppDefine.MB_FREEPLAY_DEMO_ENUM[e]
if e and n then
gvars.mbFreeDemoPlayNextIndex=n+1
else
gvars.mbFreeDemoPlayNextIndex=0
end
end
function e.CanUpdateMBDemo()
for n,e in pairs(TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE)do
if gvars.mbFreeDemoPlayRequestFlag[e]then
return true
end
end
if not TppMission.IsStartFromHelispace()then
return false
end
return true
end
function e.IsQuestStart()
if not TppMission.IsStartFromHelispace()then
return false
end
if TppQuest.IsActive"mtbs_q99050"and MotherBaseStage.GetFirstCluster()==TppDefine.CLUSTER_DEFINE.Develop then
return true
end
if TppQuest.IsActive"mtbs_q99011"and MotherBaseStage.GetFirstCluster()==TppDefine.CLUSTER_DEFINE.Medical then
return true
end
return false
end
function e.IsSortieMBDemo(e)
if TppDefine.MB_FREEPLAY_RIDEONHELI_DEMO_DEFINE[e]then
return true
else
return false
end
end
function e.IsBattleHangerDemo(n)
local e={"DevelopedBattleGear1","DevelopedBattleGear2","DevelopedBattleGear4","DevelopedBattleGear5"}
for a,e in ipairs(e)do
if e==n then
return true
end
end
return false
end
function e.EnableNpc(t)
local n=mvars.dem_demoFlags[t]or{}
if not n.isInGame then
local a="all"local t=mvars.dem_demoList[t]
if n.finishFadeOut or mvars.dem_isSkipped[t]then
a={}
for n,e in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
a[n]=e
end
end
e.EnableGameStatus(a,n.exceptGameStatus)
end
e.ClearIgnoreNpcDisableOnDemoEnd()
end
return e
