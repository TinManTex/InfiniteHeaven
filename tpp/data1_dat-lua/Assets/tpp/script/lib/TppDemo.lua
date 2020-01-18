local e={}
local o=Fox.StrCode32
local n=Tpp.IsTypeFunc
local i=Tpp.IsTypeTable
local r=DemoDaemon.FindDemoBody
local d=DemoDaemon.IsDemoPlaying
local c=DemoDaemon.IsPlayingDemoId
local l=DemoDaemon.IsDemoPaused
local p=DemoDaemon.GetPlayingDemoId
local t=((5*24)*60)*60
e.MOVET_TO_POSITION_RESULT={[o"success"]="success",[o"failure"]="failure",[o"timeout"]="timeout"}
e.messageExecTable={}
function e.Messages()
  return Tpp.StrCode32Table{
    Player={
      {msg="DemoSkipped",func=e.OnDemoSkipAndBlockLoadend,
        option={isExecDemoPlaying=true,isExecMissionClear=true,isExecGameOver=true}},
      {msg="DemoSkipStart",func=e.EnableWaitBlockLoadOnDemoSkip,option={isExecDemoPlaying=true,isExecMissionClear=true,isExecGameOver=true}},
      {msg="FinishInterpCameraToDemo",func=e.OnEndGameCameraInterp,option={isExecMissionClear=true,isExecGameOver=true}},
      {msg="FinishMovingToPosition",sender="DemoStartMoveToPosition",func=function(a,n)
        local e=e.MOVET_TO_POSITION_RESULT[n]
        mvars.dem_waitingMoveToPosition=nil
      end,
      option={isExecMissionClear=true,isExecGameOver=true}}},
    Demo={
      {msg="PlayInit",func=e._OnDemoInit,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},
      {msg="Play",func=e._OnDemoPlay,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},
      {msg="Finish",func=e._OnDemoend,
        option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},
      {msg="Interrupt",func=e._OnDemoInterrupt,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="Skip",func=e._OnDemoSkip,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="Disable",func=e._OnDemoDisable},
      {msg="StartMissionTelop",func=function()
        if mvars.dm_doneStartMissionTelop then
          return
        end
        local e=TppMission.GetNextMissionCodeForMissionClear()
        TppUI.StartMissionTelop(e)
        mvars.dm_doneStartMissionTelop=true
      end,
      option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="StartCastTelopLeft",func=function()
        TppTelop.StartCastTelop"LEFT_START"
      end,
      option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="StartCastTelopRight",func=function()
        TppTelop.StartCastTelop"RIGHT_START"
      end,
      option={isExecDemoPlaying=true,isExecMissionClear=true}},nil},
    UI={
      {msg="EndFadeOut",sender="DemoPlayFadeIn",func=function(n,e)
        local e=mvars.dem_invScdDemolist[e]end,
      option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},
      {msg="DemoPauseSkip",func=e.FadeOutOnSkip,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}}},
    Timer={{msg="Finish",sender="p31_080110_000_showLocationTelop",
    func=function()
      TppUiCommand.RegistInfoTypingText("location",1)
      TppUiCommand.RegistInfoTypingText("cpname",2,"platform_isolation")
      TppUiCommand.RegistInfoTypingText("disptime",2)
      TppUiCommand.ShowInfoTypingText()
    end,
    option={isExecDemoPlaying=true}}}}
end

e.PLAY_REQUEST_START_FUNC={
  missionStateCheck=function(n,e)
    local n=e.isExecMissionClear
    local a=e.isExecGameOver
    local e=e.isExecDemoPlaying
    if not TppMission.CheckMissionState(n,a,e,false)then
      return false
    end
    return true
  end,

  gameCameraInterpedToDemo=function(e)
    if not r(e)then
      return
    end
    if mvars.dem_gameCameraInterpWaitingDemoName~=nil then
      return false
    end
    mvars.dem_gameCameraInterpWaitingDemoName=e
    Player.RequestToInterpCameraToDemo(e,1,2,Vector3(.4,.6,-1),true)
    return true
  end,

  playerModelReloaded=function(e)
    if mvars.dem_tempPlayerInfo~=nil then
      return false
    end
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT)mvars.dem_tempPlayerInfo={}
    mvars.dem_tempPlayerInfo.playerType=vars.playerType
    mvars.dem_tempPlayerInfo.playerPartsType=vars.playerPartsType
    mvars.dem_tempPlayerInfo.playerCamoType=vars.playerCamoType
    mvars.dem_tempPlayerInfo.playerFaceId=vars.playerFaceId
    mvars.dem_tempPlayerInfo.playerFaceEquipId=vars.playerFaceEquipId
    TppPlayer.ForceChangePlayerToSnake(true)mvars.dem_tempPlayerReloadCounter={}
    mvars.dem_tempPlayerReloadCounter.start=0
    mvars.dem_tempPlayerReloadCounter.finish=0
    return true
  end,

  demoBlockLoaded=function(e)
    TppScriptBlock.RequestActivate"demo_block"
    return true
  end,

  playerActionAllowed=function(e)
    return true
  end,

  playerMoveToPosition=function(n,e)
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
    Player.RequestToSetTargetStance(PlayerStance.STAND)
    Player.RequestToMoveToPosition{name="DemoStartMoveToPosition",position=e.position,direction=e.direction,onlyInterpPosition=true,timeout=10}
    mvars.dem_waitingMoveToPosition=true
    return true
  end,

  waitTextureLoadOnDemoPlay=function(e)
    mvars.dem_setTempCamera=false
    mvars.dem_textureLoadWaitOnDemoPlayEndTime=nil
    return true
  end
}

e.PLAY_REQUEST_START_CHECK_FUNC={
  missionStateCheck=function(e)
    return true
  end,

  gameCameraInterpedToDemo=function(e)
    if mvars.dem_gameCameraInterpWaitingDemoName then
      return false
    else
      return true
    end
  end,

  demoBlockLoaded=function(e)
    local e=r(e)
    if not e then
      TppUI.ShowAccessIconContinue()
    end
    return e
  end,

  playerModelReloaded=function(e)
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
  end,

  playerActionAllowed=function(e)
    local e=Player.CanPlayDemo(0)
    if e==false then
    end
    return e
  end,

  playerMoveToPosition=function(e)
    if mvars.dem_waitingMoveToPosition then
      return false
    else
      return true
    end
  end,

  waitTextureLoadOnDemoPlay=function(e)
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
  end
}

e.FINISH_WAIT_START_FUNC={waitBlockLoadEndOnDemoSkip=function(e)mvars.dem_enableWaitBlockLoadOnDemoSkip=true
  TppGameStatus.Set("TppDemo.OnDemoSkip","S_IS_BLACK_LOADING")
  return true
end,
waitTextureLoadOnDemoEnd=function(e)
  return true
end,
playerModelReloaded=function(e)
  if mvars.dem_tempPlayerInfo==nil then
    return
  end
  if mvars.dem_donePlayerRestoreFadeOut==nil then
    mvars.dem_donePlayerRestoreFadeOut=true
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT)
  end
  for e,n in pairs(mvars.dem_tempPlayerInfo)do
    vars[e]=n
  end
  mvars.dem_tempPlayerInfo=nil
  return true
end}e.FINISH_WAIT_CHECK_FUNC={waitBlockLoadEndOnDemoSkip=function(e)
  if mvars.dem_enableWaitBlockLoadOnDemoSkip then
    TppUI.ShowAccessIconContinue()
    return false
  else
    TppGameStatus.Reset("TppDemo.OnDemoSkip","S_IS_BLACK_LOADING")
    return true
  end
end,
waitTextureLoadOnDemoEnd=function(e)
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
end,
playerModelReloaded=function(e)
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
  local a=mvars.dem_demoList[t]if(a==nil)then
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
  local e=e or{}
  local n=TppUI.GetOverrideGameStatus()
  if n then
    for a,n in pairs(n)do
      e[a]=n
    end
  end
  Tpp.SetGameStatus{target=t,except=e,enable=true,scriptName="TppDemo.lua"}
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
function e.PlayOnDemoBlock()e.ProcessPlayRequest(mvars.demo_playRequestInfo.demoBlock)
end
function e.FinalizeOnDemoBlock()
  if d()then
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
    n=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
    a=Quat.RotationY(TppMath.DegreeToRadian(vars.playerRotY))
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
  local n,a,e=DemoDaemon.GetStartPosition(e,"Player")
  if not n then
    return
  end
  local e=Tpp.GetRotationY(e)
  local e={position=a,direction=e}
  return e
end
function e.PlayOpening(m,n)
  local l=n or{}l.isSnakeOnly=false
  local d="_openingDemo"
  local n="p31_020000"
  local a={"p31_020000","p31_020001","p31_020002"}
  local t=math.random(#a)n=a[t]e.AddDemo(d,n)
  local o,r
  local t,a
  local u=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
  local s=Vector3(0,0,1.98)
  local i=Quat.RotationY(TppMath.DegreeToRadian(vars.playerRotY))
  if gvars.mis_orderBoxName~=0 and mvars.mis_orderBoxList~=nil then
    local e=TppMission.FindOrderBoxName(gvars.mis_orderBoxName)
    if e~=nil then
      t,a=TppMission.GetOrderBoxLocatorByTransform(e)
    end
  end
  if t then
    local e=-a:Rotate(s)o=e+t
    r=a
  else
    local e=-i:Rotate(s)o=e+u
    r=i
  end
  TppMusicManager.StopMusicPlayer(1)DemoDaemon.SetDemoTransform(n,r,o)e.Play(d,m,l)
end
function e.PlayGetIntelDemo(l,d,i,n,t)
  local o=n or{}o.isSnakeOnly=false
  local n,a
  if t then
    n,a="p31_010026","p31_010026_001"
  else
    n,a="p31_010025","p31_010025_001"
  end
  local t="_getInteldemo"
  local r="_getInteldemo02"e.AddDemo(t,n)e.AddDemo(r,a)
  local a,r=Tpp.GetLocatorByTransform(d,i)
  local i=Tpp.GetRotationY(r)Player.RequestToSetTargetStance(PlayerStance.STAND)
  if a~=nil then
    DemoDaemon.SetDemoTransform(n,r,a)
    e.Play(t,l,o)
    TppUI.ShowAnnounceLog"getIntel"
  end
end
function e.IsNotPlayable()
  if d()or l()then
    local e=p()
    for n,e in ipairs(e)do
      local e=mvars.dem_invDemoList[e]if e then
        local e=mvars.dem_demoFlags[e]or{}
        if not e.isInGame then
          return true
        end
      end
    end
    return false
  else
    return false
  end
end
function e.ReserveEnableInGameFlag()mvars.dem_resereveEnableInGameFlag=true
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
  local a=mvars.dem_demoList[a]if not a then
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
  StageBlockCurrentPositionSetter.SetEnable(true)
  StageBlockCurrentPositionSetter.SetPosition(e:GetX(),e:GetZ())
end
function e.SetPlayerPause()
  mvars.dem_isPlayerPausing=true
  Player.SetPause()
end
function e.SetPlayerWarp(e,a)
  mvars.dem_isPlayerPausing=true
  Player.SetPause()
  local n={type="TppPlayer2",index=0}
  local e={id="WarpAndWaitBlock",pos={e:GetX(),e:GetY(),e:GetZ()},rotY=a}
  GameObject.SendCommand(n,e)
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
function e.ClearReserveInTheBackGround()mvars.dem_reservedDemoId=nil
  mvars.dem_reservedDemoLoadPosition=nil
end
function e.CheckEventDemoDoor(r,n,e)
  local t=TppPlayer.GetPosition()
  local a=30
  if r==nil then
    return false
  end
  if Tpp.IsTypeTable(n)then
    t=n
  elseif n==nil then
  end
  if Tpp.IsTypeNumber(e)and e>0 then
    a=e
  elseif e==nil then
  end
  local n=0
  local i,l=0,1
  local o=Tpp.IsNotAlert()
  local a=TppEnemy.IsActiveSoldierInRange(t,a)
  local e
  if o==true and a==false then
    n=i
    e=true
  else
    n=l
    e=false
  end
  Player.SetEventLockDoorIcon{doorId=r,isNgIcon=n}
  return e,o,(not a)
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
  for n,e in pairs(e)do
    mvars.dem_invDemoList[e]=n
    mvars.dem_invScdDemolist[o(e)]=n
  end
end
function e.AddDemo(e,n)
  mvars.dem_demoList[e]=n
  mvars.dem_invDemoList[n]=e
  mvars.dem_invScdDemolist[o(n)]=e
end
function e.OnMessage(i,r,o,a,t,l,n)
  Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,i,r,o,a,t,l,n)
end
function e.FadeOutOnSkip()
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT)
end
function e.OnDemoPlay(a,t)
  if mvars.dem_playedList[a]==nil then
    return
  end
  local n=mvars.dem_demoFlags[a]or{}
  if not n.startNoFadeIn then
    local e=n.fadeSpeed or TppUI.FADE_SPEED.FADE_NORMALSPEED
    TppUI.FadeIn(e,"DemoPlayFadeIn",t)
  end
  if n.useDemoBlock then
    mvars.dem_startedDemoBlockDemo=false
  end
  if mvars.dem_resereveEnableInGameFlag then
    if TppMission.GetMissionClearState()<=TppDefine.MISSION_CLEAR_STATE.MISSION_GAME_END then
      TppSoundDaemon.ResetMute"Loading"
    end
  end
  local n=mvars.dem_demoList[a]
  if(n=="p31_080110_000_final")then
    GkEventTimerManager.Start("p31_080110_000_showLocationTelop",12+(34/60))
  end
  e.UnsetStageBlockLoadPosition()
  e.UnsetPlayerPause()
end
function e.OnDemoEnd(a)
  if mvars.dem_playedList[a]==nil then
    return
  end
  local n=mvars.dem_demoFlags[a]or{}
  local a=mvars.dem_demoList[a]local t={p31_070050_001_final=true}
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
  local n=mvars.dem_demoList[e]local t=mvars.dem_demoFlags[e]or{}
  local t={p31_010010=true,p41_030005_000_final=true,p51_070020_000_final=true,p31_050026_000_final=true}
  if t[n]then
    TppSoundDaemon.SetMuteInstant"Loading"
  end
  if(n=="p31_080110_000_final")then
    if GkEventTimerManager.IsTimerActive"p31_080110_000_showLocationTelop"then
      GkEventTimerManager.Stop"p31_080110_000_showLocationTelop"
    end
    TppUiCommand.HideInfoTypingText()
  end
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
function e.DoOnEndMessage(n,r,o,t,a)
  if(not r)then
    local e=true
    if t and(not a)then
      e=false
    end
    if e then
      TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"DemoSkipFadeIn",mvars.dem_currentSkippedScdDemoID,{exceptGameStatus=o})
    end
  end
  e._DoMessage(n,"onEnd")
  mvars.dem_currentSkippedDemoName=nil
  mvars.dem_currentSkippedScdDemoID=nil
  e.EnableInGameFlagIfResereved()e.EnableNpc(n)
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
  local i
  if e.interpGameToDemo then
    i=false
  end
  local r
  if e.useDemoBlock then
    r=false
  end
  local o
  if e.isSnakeOnly then
    if(vars.playerType==PlayerType.DD_MALE or vars.playerType==PlayerType.DD_FEMALE)then
      o=false
    end
  end
  local a
  if(not e.isInGame)or(e.isNotAllowedPlayerAction)then
    a=false
  end
  local n
  if e.playerMoveToPosition then
    n=false
  end
  local t
  if e.waitTextureLoadOnDemoPlay then
    t=false
  end
  local e={missionStateCheck=false,gameCameraInterpedToDemo=i,demoBlockLoaded=r,playerModelReloaded=o,playerActionAllowed=a,playerMoveToPosition=n,waitTextureLoadOnDemoPlay=t}
  return e
end
function e.DeletePlayRequestInfo(e,n)
  if n and n.useDemoBlock then
    mvars.demo_playRequestInfo.demoBlock[e]=nil
  else
    mvars.demo_playRequestInfo.missionBlock[e]=nil
  end
end
function e.ProcessPlayRequest(n)
  if not next(n)then
    return
  end
  for n,a in pairs(n)do
    local a=e.CanStartPlay(n,a)
    if a then
      if not l()then
        if not c(n)then
          local a=mvars.dem_invDemoList[n]local t=mvars.dem_demoFlags[a]e._Play(a,n)
          e.DeletePlayRequestInfo(n,t)
        end
      end
    end
  end
end
function e.CanStartPlay(o,t)
  local a=true
  for n,r in pairs(t)do
    if r==false then
      local e=e.PLAY_REQUEST_START_CHECK_FUNC[n](o)
      if e then
        t[n]=true
      else
        a=false
      end
    end
  end
  return a
end
function e.AddFinishWaitRequestInfo(t,a,n)
  local a
  local o=true
  if n then
    a=e.FINISH_WAIT_START_FUNC[n]if a then
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
      local t=mvars.dem_invDemoList[a]local n=mvars.dem_demoFlags[t]or{}
      mvars.demo_finishWaitRequestInfo[a]=nil
      e.DoOnEndMessage(t,n.finishFadeOut,n.exceptGameStatus,n.isInGame,mvars.dem_isSkipped[a])
      if(not n.finishFadeOut)and(not n.isInGame)then
        TppTerminal.GetFobStatus()
      end
    end
  end
end
function e.CanFinishPlay(o,t)
  local n=true
  for a,r in pairs(t)do
    if r==false then
      local e=e.FINISH_WAIT_CHECK_FUNC[a](o)
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
  e.ClearReserveInTheBackGround()
  DemoDaemon.Play(a)
end
function e._OnDemoInit(n)
  local n=mvars.dem_invScdDemolist[n]
  if n then
    e._DoMessage(n,"onInit")
  end
end
function e._OnDemoPlay(a)
  local n=mvars.dem_invScdDemolist[a]
  if n then
    e.DisableGameStatusOnPlayStart()
    e.OnDemoPlay(n,a)
    e._DoMessage(n,"onStart")
  end
end
function e._OnDemoEnd(n)
  local n=mvars.dem_invScdDemolist[n]
  if n then
    e.OnDemoEnd(n)
    mvars.dem_playedList[n]=nil
  end
end
function e._OnDemoInterrupt(n)
  local n=mvars.dem_invScdDemolist[n]
  if n then
    e.OnDemoInterrupt(n)
    e._DoMessage(n,"onInterrupt")
  end
end
function e._OnDemoSkip(a)
  local n=mvars.dem_invScdDemolist[a]
  if n then
    e.OnDemoSkip(n,a)
    e._DoMessage(n,"onSkip")
  end
end
function e._OnDemoDisable(n)
  local n=mvars.dem_invScdDemolist[n]
  if n then
    e.OnDemoDisable(n)
    e._DoMessage(n,"onDisable")
    mvars.dem_playedList[n]=nil
  end
end
function e._DoMessage(n,a)
  if((mvars.dem_demoFuncs==nil or mvars.dem_demoFuncs[n]==nil)or mvars.dem_demoFuncs[n][a]==nil)then
    return
  end
  mvars.dem_demoFuncs[n]
    [a]()
end
e.mtbsPriorityFuncList={
  TheGreatEscapeLiquid=function()
    return false
  end,
  NuclearEliminationCeremony=function()
    if not gvars.f30050_isInitNuclearAbolitionCount then
      return false
    end
    local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
    local e=TppServerManager.GetNuclearAbolitionCount()
    local a=e>=0
    local e=gvars.f30050_NuclearAbolitionCount<e
    if(a and n)and e then
      if vars.mbmIsNuclearDeveloping==0 and TppMotherBaseManagement.GetResourceUsableCount{resource="NuclearWeapon"}==0 then
        return true
      else
        gvars.f30050_needUpdateNuclearFlag=true
        return false
      end
    end
    return false
  end,
  ForKeepNuclearElimination=function()
    return false
  end,
  SacrificeOfNuclearElimination=function()
    return false
  end,
  GoToMotherBaseAfterQuietBattle=function()
    return gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterQuietBattle]
  end,
  ArrivedMotherBaseLiquid=function()
    return gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterWhiteMamba]
  end,
  ArrivedMotherBaseFromDeathFactory=function()
    return gvars.mbFreeDemoPlayRequestFlag[TppDefine.MB_FREEPLAY_DEMO_REQUESTFLAG_DEFINE.PlayAfterDethFactory]
  end,
  EntrustDdog=function()
    if e.IsPlayedMBEventDemo"EntrustDdog"then
      return false
    end
    if TppBuddyService.DidObtainBuddyType(BuddyType.DOG)then
      return true
    else
      return false
    end
  end,
  DdogComeToGet=function()
    if e.IsPlayedMBEventDemo"DdogComeToGet"then
      return false
    end
    local n=TppStory.GetClearedMissionCount{10036,10043,10033}>=2
    local t=TppBuddyService.DidObtainBuddyType(BuddyType.DOG)
    local a=not TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
    local e=TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_COME_TO_GET)
    return((n and t)and a)and e
  end,
  DdogGoWithMe=function()
    local a=TppStory.GetClearedMissionCount{10041,10044,10052,10054}>=3
    local n=not TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
    local e=TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.D_DOG_GO_WITH_ME)
    return(a and n)and e
  end,
  LongTimeNoSee_DDSoldier=function()
    local n=TppStory.IsMissionCleard(10030)
    local e=gvars.elapsedTimeSinceLastPlay>=t
    return n and e
  end,
  LongTimeNoSee_DdogPup=function()
    local e=gvars.elapsedTimeSinceLastPlay>=t
    local n=TppBuddyService.DidObtainBuddyType(BuddyType.DOG)
    local a=not TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
    return(e and n)and a
  end,
  LongTimeNoSee_DdogLowLikability=function()
    local e=TppStory.IsMissionCleard(10050)
    local n=gvars.elapsedTimeSinceLastPlay>=t
    local a=TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
    local t=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG)<25
    return((e and n)and a)and t
  end,
  LongTimeNoSee_DdogHighLikability=function()
    local e=TppStory.IsMissionCleard(10050)
    local n=gvars.elapsedTimeSinceLastPlay>=t
    local a=TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
    local t=25<=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG)and TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG)<75
    return((e and n)and a)and t
  end,
  LongTimeNoSee_DdogSuperHighLikability=function()
    local o=TppStory.IsMissionCleard(10050)
    local n=gvars.elapsedTimeSinceLastPlay>=t
    local a=TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
    local e=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG)>=75
    return((o and n)and a)and e
  end,
  AttackedFromOtherPlayer_KnowWhereFrom=function()
    if e.IsPlayedMBEventDemo"AttackedFromOtherPlayer_KnowWhereFrom"or e.IsPlayedMBEventDemo"AttackedFromOtherPlayer_UnknowWhereFrom"then
      return false
    end
    local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_CAPTURE_THE_WEAPON_DEALER
    local e=vars.mbmDemoAttackedFromOtherPlayerKnowWhereFrom~=0
    return n and e
  end,
  AttackedFromOtherPlayer_UnknowWhereFrom=function()
    if e.IsPlayedMBEventDemo"AttackedFromOtherPlayer_KnowWhereFrom"or e.IsPlayedMBEventDemo"AttackedFromOtherPlayer_UnknowWhereFrom"then
      return false
    end
    local e=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_CAPTURE_THE_WEAPON_DEALER
    local n=vars.mbmRequestDemoAttackedFromOtherPlayer~=0
    return e and n
  end,
  MoraleOfMBIsLow=function()
    if e.IsPlayedMBEventDemo"MoraleOfMBIsLow"then
      return false
    end
    local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE
    local e=vars.mbmTppGmp<0
    return n and e
  end,
  OcelotIsPupilOfSnake=function()
    if e.IsPlayedMBEventDemo"OcelotIsPupilOfSnake"then
      return false
    end
    local n=TppStory.IsMissionCleard(10040)
    local e=0
    for n=TppMotherBaseManagementConst.SECTION_COMBAT,TppMotherBaseManagementConst.SECTION_SECURITY do
      e=e+#TppMotherBaseManagement.GetOutOnMotherBaseStaffs{sectionId=n}
    end
    local e=e>=3
    return n and e
  end,
  HappyBirthDay=function()
    if e.IsPlayedMBEventDemo"HappyBirthDay"then
      return false
    end
    local a=TppUiCommand.IsBirthDay()
    local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE
    local e=TppStory.GetClearedMissionCount{10036,10043,10033}>=1
    return(a and n)and e
  end,
  HappyBirthDayWithQuiet=function()
    return false
  end,
  QuietOnHeliInRain=function()
    if e.IsPlayedMBEventDemo"QuietOnHeliInRain"then
      return false
    else
      local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
      local t=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.QUIET)>=80
      local a=(vars.buddyType==BuddyType.QUIET)
      local e=TppStory.CanArrivalQuietInMB(false)
      return((n and t)and a)and e
    end
  end,
  QuietHasFriendshipWithChild=function()
    if e.IsPlayedMBEventDemo"QuietHasFriendshipWithChild"then
      return false
    else
      local t=TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE.Medical+1)>=2
      local a=TppStory.CanArrivalQuietInMB(true)
      local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
      local e=not(TppQuest.IsOpen"outland_q20913"or TppQuest.IsOpen"lab_q20914")
      return((t and a)and n)and e
    end
  end,
  QuietWishGoMission=function()
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
  end,
  QuietReceivesPersecution=function()
    return false
  end,
  SnakeHasBadSmell_WithoutQuiet=function()
    if e.IsPlayedMBEventDemo"SnakeHasBadSmell_WithoutQuiet"then
      return false
    end
    local e=TppStory.IsMissionCleard(10040)
    local n=Player.GetSmallFlyLevel()>=1
    return e and n
  end,
  SnakeHasBadSmell_000=function()
    if e.IsPlayedMBEventDemo"SnakeHasBadSmell_000"then
      return false
    end
    local n=TppStory.IsMissionCleard(10086)
    local e=TppStory.CanArrivalQuietInMB(false)
    local a=Player.GetSmallFlyLevel()>=1
    local t=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.QUIET)>=60
    return((n and e)and a)and t
  end,
  SnakeHasBadSmell_001=function()
    return false
  end,
  EliLookSnake=function()
    if e.IsPlayedMBEventDemo"EliLookSnake"then
      return false
    end
    return false
  end,
  LiquidAndChildSoldier=function()
    if e.IsPlayedMBEventDemo"LiquidAndChildSoldier"then
      return false
    end
    local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA
    local e=TppQuest.IsOpen"sovietBase_q99030"
    return n and not e
  end,
  InterrogateQuiet=function()
    if e.IsPlayedMBEventDemo"InterrogateQuiet"then
      return false
    else
      local n=TppStory.CanArrivalQuietInMB(true)
      local e=TppQuest.IsOpen"sovietBase_q99030"
      local a=not TppRadio.IsPlayed"f2000_rtrg8290"
      return(n and e)and a
    end
  end,
  AnableDevBattleGear=function()
    if e.IsPlayedMBEventDemo"AnableDevBattleGear"then
      return false
    end
    return TppRadio.IsPlayed"f2000_rtrg8175"and(TppStory.GetClearedMissionCount{10085,10200}==0)
  end,
  CodeTalkerSunBath=function()
    if e.IsPlayedMBEventDemo"CodeTalkerSunBath"then
      return false
    end
    local n=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO
    local e=TppStory.IsMissionCleard(10130)
    return n and e
  end,
  ParasiticWormCarrierKill=function()
    return false
  end,
  DecisionHuey=function()
    if e.IsPlayedMBEventDemo"DecisionHuey"then
      return false
    end
    if TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.DECISION_HUEY)and TppRadio.IsPlayed"f2000_rtrg8410"then
      return true
    else
      return false
    end
  end,
  DetailsNuclearDevelop=function()
    return false
  end,
  EndingSacrificeOfNuclear=function()
    return false
  end
}

function e.UpdateHappyBirthDayFlag()
  if e.IsPlayedMBEventDemo"HappyBirthDay"then
    if TppUiCommand.IsBirthDay()then
      if gvars.elapsedTimeSinceLastPlay>(24*60)*60 and(not gvars.isPlayedHappyBirthDayToday)then
        e.ClearPlayedMBEventDemoFlag"HappyBirthDay"
      end
    else
      e.ClearPlayedMBEventDemoFlag"HappyBirthDay"
      gvars.isPlayedHappyBirthDayToday=false
    end
  end
end
function e.GetMBDemoName()
  return TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST[gvars.mbFreeDemoPlayNextIndex]end
function e.UpdateMBDemo()e.UpdateHappyBirthDayFlag()gvars.mbFreeDemoPlayNextIndex=0
  for n,a in ipairs(TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST)do
    local e=e.mtbsPriorityFuncList[a]
    if e and e()then
      gvars.mbFreeDemoPlayNextIndex=n
      return
    end
  end
end
function e.IsUseMBDemoStage(e)
  if not TppMission.IsMissionStart()then
    return false
  end
  if e then
    for a,n in pairs(TppDefine.MB_FREEPLAY_LARGEDEMO)do
      if n==e then
        return true
      end
    end
  end
  return false
end
function e.SetNextMBDemo(n)
  local e=TppDefine.MB_FREEPLAY_DEMO_ENUM[n]
  if n and e then
    gvars.mbFreeDemoPlayNextIndex=e+1
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
function e.IsBattleHangerDemo(e)
  local n={"DevelopedBattleGear1","DevelopedBattleGear2","DevelopedBattleGear4","DevelopedBattleGear5"}
  for a,n in ipairs(n)do
    if n==e then
      return true
    end
  end
  return false
end
function e.EnableNpc(t)
  local a=mvars.dem_demoFlags[t]or{}
  if not a.isInGame then
    local n="all"
    local t=mvars.dem_demoList[t]if a.finishFadeOut or mvars.dem_isSkipped[t]then
      n={}
      for a,e in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
        n[a]=e
      end
    end
    e.EnableGameStatus(n,a.exceptGameStatus)
  end
  e.ClearIgnoreNpcDisableOnDemoEnd()
end
function e.UpdateNuclearAbolitionFlag()
  if gvars.f30050_needUpdateNuclearFlag then
    gvars.f30050_NuclearAbolitionCount=TppServerManager.GetNuclearAbolitionCount()
    gvars.f30050_discardNuclearCountFromLastAbolition=TppMotherBaseManagement.GetResourceUsableCount{resource="NuclearWaste"}
    gvars.f30050_needUpdateNuclearFlag=false
  end
end
return e
