local this={}
local o=Fox.StrCode32
local i=Tpp.IsTypeFunc
local t=Tpp.IsTypeTable
local r=DemoDaemon.FindDemoBody
local m=DemoDaemon.IsDemoPlaying
local l=DemoDaemon.IsPlayingDemoId
local d=DemoDaemon.IsDemoPaused
local u=DemoDaemon.GetPlayingDemoId
this.MOVET_TO_POSITION_RESULT={[o"success"]="success",[o"failure"]="failure",[o"timeout"]="timeout"}
this.messageExecTable={}
function this.Messages()
  return Tpp.StrCode32Table{
    Player={
      {msg="DemoSkipped",func=this.OnDemoSkipAndBlockLoadEnd,option={isExecDemoPlaying=true,isExecMissionClear=true,isExecGameOver=true}},
      {msg="DemoSkipStart",func=this.EnableWaitBlockLoadOnDemoSkip,option={isExecDemoPlaying=true,isExecMissionClear=true,isExecGameOver=true}},
      {msg="FinishInterpCameraToDemo",func=this.OnEndGameCameraInterp,option={isExecMissionClear=true,isExecGameOver=true}},
      {msg="FinishMovingToPosition",sender="DemoStartMoveToPosition",func=function(a,n)
        local e=this.MOVET_TO_POSITION_RESULT[n]
        mvars.dem_waitingMoveToPosition=nil
      end,option={isExecMissionClear=true,isExecGameOver=true}}},
    Demo={
      {msg="PlayInit",func=this._OnDemoInit,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},
      {msg="Play",func=this._OnDemoPlay,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},
      {msg="Finish",func=this._OnDemoEnd,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},
      {msg="Interrupt",func=this._OnDemoInterrupt,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="Skip",func=this._OnDemoSkip,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="Disable",func=this._OnDemoDisable},
      {msg="StartMissionTelop",func=function()
        if mvars.dm_doneStartMissionTelop then
          return
        end
        local e=TppMission.GetNextMissionCodeForMissionClear()
        TppUI.StartMissionTelop(e)
        mvars.dm_doneStartMissionTelop=true
      end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="StartCastTelopLeft",func=function()
        TppTelop.StartCastTelop"LEFT_START"end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="StartCastTelopRight",func=function()
        TppTelop.StartCastTelop"RIGHT_START"end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="afgh_base_AI_ON",func=function()
        afgh_base.SetAiVisibility(true)
      end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="afgh_base_AI_OFF",func=function()
        afgh_base.SetAiVisibility(false)
      end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="afgh_base_Digger_ON",func=function()
        afgh_base.SetDiggerVisibility(true)
      end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="afgh_base_Digger_OFF",func=function()
        afgh_base.SetDiggerVisibility(false)
      end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="mafr_base_AI_ON",func=function()
        mafr_base.SetAiVisibility(true)
      end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="mafr_base_AI_OFF",func=function()
        mafr_base.SetAiVisibility(false)
      end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="mafr_factory_jungle_asset_on",func=function()
        mafr_base.SetFactoryAssetVisibility("p40_000010_after_ON_before_OFF",true)
      end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="mafr_factory_jungle_asset_off",func=function()
        mafr_base.SetFactoryAssetVisibility("p40_000010_after_ON_before_OFF",false)
      end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="ShowDefenseGameWormhole",func=function()
        local e=TppMission.GetInitialWaveName()
        TppEnemy.EnableWaveSpawnPointEffect(e)
        Mission.EnableWaveEffect()
      end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="RescueDemo_voiceStart",func=function()
        local e=GameObject.SendCommand({type="SsdCrew"},{id="GetRescuedCrew"})
        if not e then
          return
        end
        local n=GameObject.SendCommand(e,{id="GetCrewType"})
        if n~=CrewType.UNIQUE_SETH then
          GameObject.SendCommand(e,{id="SetDemoVoice",voiceId="POWV_0050"})
        end
      end,option={isExecDemoPlaying=true,isExecMissionClear=true}},
      {msg="RescueDemo_facialStart",func=function()
        local e=GameObject.SendCommand({type="SsdCrew"},{id="GetRescuedCrew"})
        if e then
          GameObject.SendCommand(e,{id="SetDemoFacial",facialId="rescue_demo"})
        end
      end,option={isExecDemoPlaying=true,isExecMissionClear=true}}},
    UI={
      {msg="EndFadeOut",sender="DemoPlayFadeIn",func=function(n,e)
        local e=mvars.dem_invScdDemolist[e]
      end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},
      {msg="DemoPauseSkip",func=this.FadeOutOnSkip,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}}}
  }
end
this.PLAY_REQUEST_START_FUNC={missionStateCheck=function(n,e)
  local n=e.isExecMissionClear
  local a=e.isExecGameOver
  local e=e.isExecDemoPlaying
  if not TppMission.CheckMissionState(n,a,e,false,true)then
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
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"DemoPlayerModelReload",TppUI.FADE_PRIORITY.DEMO)
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
this.PLAY_REQUEST_START_CHECK_FUNC={missionStateCheck=function(e)
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
  return true
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
    if DebugText then
      DebugText.Print(DebugText.NewContext(),{.5,.5,1},string.format("textureLoadRate = %0.3f, remainTime = %02.2f.",n,e))
    end
    TppUI.ShowAccessIconContinue()
    return false
  end
end}
this.FINISH_WAIT_START_FUNC={waitBlockLoadEndOnDemoSkip=function(e)
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
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"DemoPlayerModelReload",TppUI.FADE_PRIORITY.DEMO)
  end
  for e,n in pairs(mvars.dem_tempPlayerInfo)do
    vars[e]=n
  end
  mvars.dem_tempPlayerInfo=nil
  return true
end,waitFadeInOnDemoSkip=function(e)
  mvars.dem_waitFadeInCounter=0
  return true
end}
this.FINISH_WAIT_CHECK_FUNC={waitBlockLoadEndOnDemoSkip=function(e)
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
    if DebugText then
      DebugText.Print(DebugText.NewContext(),{.5,.5,1},string.format("textureLoadRate = %0.3f, remainTime = %02.2f.",e,n))
    end
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
end,waitFadeInOnDemoSkip=function(e)
  if mvars.dem_enableWaitBlockLoadOnDemoSkip then
    return false
  end
  mvars.dem_waitFadeInCounter=mvars.dem_waitFadeInCounter+1
  if mvars.dem_waitFadeInCounter>2 then
    return true
  end
  return false
end}
function this.Play(a,o,n)
  local t=mvars.dem_demoList[a]
  if(t==nil)then
    return
  end
  mvars.dem_enableWaitBlockLoadOnDemoSkip=false
  mvars.dem_demoFuncs[a]=o
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
  mvars.dem_demoFlags[a]=n
  if mvars.dem_checkTerminate and mvars.dem_checkTerminateDemoName then
    this._DoMessage(mvars.dem_checkTerminateDemoName,"onFinalize")
  end
  mvars.dem_checkTerminateDemoName=nil
  mvars.dem_checkTerminate=false
  local n=this.AddPlayReqeustInfo(t,n)
  if not n then
    this._DoMessage(a,"onEnd")
    this._DoMessage(a,"onFinalize")
  end
  return n
end
function this.EnableGameStatus(t,e)
  local e=e or{}
  local n=TppUI.GetOverrideGameStatus()
  if n then
    for n,a in pairs(n)do
      e[n]=a
    end
  end
  Tpp.SetGameStatus{target=t,except=e,enable=true,scriptName="TppDemo.lua"}
end
function this.DisableGameStatusOnPlayRequest(e)
  if not e then
    Tpp.SetGameStatus{target="all",enable=false,except={S_DISABLE_NPC=false},scriptName="TppDemo.lua"}
  end
end
function this.DisableGameStatusOnPlayStart()
  if this.IsNotPlayable()then
    HighSpeedCamera.RequestToCancel()
    Tpp.SetGameStatus{target="all",enable=false,scriptName="TppDemo.lua"}
  end
end
function this.OnEndGameCameraInterp()
  if mvars.dem_gameCameraInterpWaitingDemoName==nil then
  end
  mvars.dem_gameCameraInterpWaitingDemoName=nil
end
function this.PlayOnDemoBlock()
  this.ProcessPlayRequest(mvars.demo_playRequestInfo.demoBlock)
end
function this.FinalizeOnDemoBlock()
  if m()then
    DemoDaemon.SkipAll()
  end
end
function this.SetDemoTransform(n,e)
  local o=mvars.dem_demoList[n]
  if(o==nil)then
    return
  end
  if(t(e)==false)then
    return
  end
  local n
  local a
  if(e.usePlayer==true)then
    n=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)a=Quat.RotationY(TppMath.DegreeToRadian(vars.playerRotY))
  elseif(e.identifier and e.locatorName)then
    n,a=Tpp.GetLocatorByTransform(e.identifier,e.locatorName)
  elseif(e.translation and e.rotQuat)then
    n=e.translation
    a=e.rotQuat
  else
    return
  end
  if n==nil then
    return
  end
  DemoDaemon.SetDemoTransform(o,a,n)
end
function this.GetDemoStartPlayerPosition(e)
  local e=mvars.dem_demoList[e]
  if(e==nil)then
    return
  end
  local n,e,a=DemoDaemon.GetStartPosition(e,"Player")
  if not n then
    return
  end
  local n=Tpp.GetRotationY(a)
  local e={position=e,direction=n}
  return e
end
function this.PlayOpening(u,n)
  local m=n or{}m.isSnakeOnly=false
  local s="_openingDemo"local i="p31_020000"local n={"p31_020000","p31_020001","p31_020002"}
  local a=math.random(#n)i=n[a]
  this.AddDemo(s,i)
  local o,a
  local t,n
  local l=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
  local d=Vector3(0,0,1.98)
  local r=Quat.RotationY(TppMath.DegreeToRadian(vars.playerRotY))
  if gvars.mis_orderBoxName~=0 and mvars.mis_orderBoxList~=nil then
    local e=TppMission.FindOrderBoxName(gvars.mis_orderBoxName)
    if e~=nil then
      t,n=TppMission.GetOrderBoxLocatorByTransform(e)
    end
  end
  if t then
    local e=-n:Rotate(d)o=e+t
    a=n
  else
    local e=-r:Rotate(d)o=e+l
    a=r
  end
  TppMusicManager.StopMusicPlayer(1)DemoDaemon.SetDemoTransform(i,a,o)
  this.Play(s,u,m)
end
function this.PlayGetIntelDemo(s,o,m,n,i)
  local t=n or{}t.isSnakeOnly=false
  local n,a
  if i then
    n,a="p31_010026","p31_010026_001"else
    n,a="p31_010025","p31_010025_001"end
  local i="_getInteldemo"local r="_getInteldemo02"this.AddDemo(i,n)
  this.AddDemo(r,a)
  local a,o=Tpp.GetLocatorByTransform(o,m)
  local r=Tpp.GetRotationY(o)Player.RequestToSetTargetStance(PlayerStance.STAND)
  if a~=nil then
    DemoDaemon.SetDemoTransform(n,o,a)
    this.Play(i,s,t)
    TppUI.ShowAnnounceLog"getIntel"end
end
function this.PlayGetMemoryBoardDemo(r,s,n,a)
  local t=a or{}t.isSnakeOnly=false
  local o="p01_000040"local i="_getMemoryBoarddemo"this.AddDemo(i,o)
  local n,a=Tpp.GetLocatorByTransform(s,n)
  local s=Tpp.GetRotationY(a)Player.RequestToSetTargetStance(PlayerStance.STAND)
  if n~=nil then
    TppGimmick.AreaBreakOnSwitchDemo(n,a)DemoDaemon.SetDemoTransform(o,a,n)
    this.Play(i,r,t)
  end
end
function this.PlayCommonSearchDemo(s,a,r,n)
  local i=n or{}i.isSnakeOnly=false
  local o="p01_000050"local t="_CommonSearchDemo"this.AddDemo(t,o)
  local n,a=Tpp.GetLocatorByTransform(a,r)
  local r=Tpp.GetRotationY(a)Player.RequestToSetTargetStance(PlayerStance.STAND)
  if n~=nil then
    TppGimmick.AreaBreakOnSwitchDemo(n,a)DemoDaemon.SetDemoTransform(o,a,n)
    this.Play(t,s,i)
  end
end
function this.PlayRescueDemo(a,m,d,n,s,o)
  if not t(n)then
    return
  end
  if mvars.dem_requesetedRescueDemoInfo or mvars.dem_checkPlayRescueDemoCoroutine then
    if i(n.onEnd)then
      n.onEnd()
    end
    return
  end
  if not t(o)then
    o={}
  end
  local t
  local function r()
    if mvars.dem_requesetedRescueDemoInfo.rescueDemoOptions.ignoreFacialSetting then
      return
    end
    local e=GameObject.SendCommand({type="SsdCrew"},{id="GetRescuedCrew"})
    if(e==GameObject.NULL_ID)then
      return
    end
    GameObject.SendCommand(e,{id="SetDemoFacial",facialId="faint"})
  end
  if i(n.onStart)then
    local e=n.onStart
    function t()r()e()
    end
  else
    t=r
  end
  n.onStart=t
  local t
  local function r()
    if mvars.dem_requesetedRescueDemoInfo.rescueDemoOptions.resetPlayerPosition then
      TppPlayer.ResetPlayerForReturnBaseCamp()
    end
    mvars.dem_isPlayingRescueDemo=nil
  end
  if i(n.onEnd)then
    local e=n.onEnd
    function t()e()r()
    end
  else
    t=r
  end
  n.onEnd=t
  local i=s or{}i.isSnakeOnly=false
  i.waitBlockLoadEndOnDemoSkip=false
  local t=mvars.dem_demoList[a]
  if not t then
    if mvars.dem_invDemoList[a]then
      t=a
      a=mvars.dem_invDemoList[t]
    else
      this.AddDemo(a,a)
    end
  end
  local r,s
  if TppLocation.IsMiddleAfrica()then
    r,s="DataIdentifier_f30020_sequence","aiDemoPosition"end
  if r then
    local n,e=Tpp.GetLocatorByTransform(r,s)
    local a=Tpp.GetRotationY(e)DemoDaemon.SetDemoTransform(t,e,n)
  end
  mvars.dem_requesetedRescueDemoInfo={demoName=a,funcs=n,flags=i,rescueTargetName=m,rescueDemoOptions=o,onEndFastTravel=d}
  mvars.dem_checkPlayRescueDemoCoroutine=coroutine.create(this.PlayRescueDemoCoroutine)BaseResultUiSequenceDaemon.SetReserved(true)
end
function this.PlayRescueDemoCoroutine()
  local function a(e)
    if DebugText then
      DebugText.Print(DebugText.NewContext(),tostring(e))
    end
  end
  local n=mvars.dem_requesetedRescueDemoInfo.rescueTargetName
  if n and TppEnemy.GetStatus(n)~=TppGameObject.NPC_STATE_CARRIED then
    return false
  end
  TppGameStatus.Set("RescueDemo","S_DISABLE_PLAYER_PAD")
  local t=false
  if TppPlayer.IsFastTravelingAndWarpEnd()then
    t=true
    TppPlayer.AddFastTravelOption{noFadeIn=true}
    while TppPlayer.IsFastTravelingAndWarpEnd()do
      a"TppDemo.PlayRescueDemoCoroutine : Now waiting finish fast travel."coroutine.yield()
    end
  end
  local n=mvars.dem_requesetedRescueDemoInfo.onEndFastTravel
  if n then
    if i(n)then
      n()
    end
  end
  local n=TppUI.FADE_SPEED.FADE_NORMALSPEED
  if t then
    n=.1
  end
  TppUI.FadeOut(n,"PlayRescueDemoFadeOut")
  local n=n
  while(n>0)do
    a"Waiting fade out."n=n-Time.GetFrameTime()coroutine.yield()
  end
  mvars.dem_isPlayingRescueDemo=true
  this.Play(mvars.dem_requesetedRescueDemoInfo.demoName,mvars.dem_requesetedRescueDemoInfo.funcs,mvars.dem_requesetedRescueDemoInfo.flags)
  while mvars.dem_isPlayingRescueDemo do
    a"TppDemo.PlayRescueDemoCoroutine: Now waiting demo end."coroutine.yield()
  end
  return true
end
function this.OnUpdatePlayRescueDemoCoroutine()
  if mvars.dem_checkPlayRescueDemoCoroutine then
    local n,a=coroutine.resume(mvars.dem_checkPlayRescueDemoCoroutine)
    if not n then
      this.DestroyPlayRescueDemoCoroutine(false)
      return
    end
    if(coroutine.status(mvars.dem_checkPlayRescueDemoCoroutine)=="dead")then
      this.DestroyPlayRescueDemoCoroutine(a)
    end
  end
end
function this.DestroyPlayRescueDemoCoroutine(e)
  if not e then
    if(mvars.dem_requesetedRescueDemoInfo and mvars.dem_requesetedRescueDemoInfo.funcs)and mvars.dem_requesetedRescueDemoInfo.funcs.onEnd then
      mvars.dem_requesetedRescueDemoInfo.funcs.onEnd()
    end
  end
  if not mvars.dem_requesetedRescueDemoInfo.flags.finishFadeOut then
    BaseResultUiSequenceDaemon.SetReserved(false)
  end
  TppGameStatus.Reset("RescueDemo","S_DISABLE_PLAYER_PAD")
  mvars.dem_checkPlayRescueDemoCoroutine=nil
  mvars.dem_requesetedRescueDemoInfo=nil
end
function this.IsPlayingRescueDemo()
  if(mvars.dem_checkPlayRescueDemoCoroutine==nil)then
    return false
  else
    return true
  end
end
function this.IsNotPlayable()
  if m()or d()then
    local e=u()
    for n,e in ipairs(e)do
      local e=mvars.dem_invDemoList[e]
      if e then
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
function this.ReserveEnableInGameFlag()
  mvars.dem_resereveEnableInGameFlag=true
end
function this.ResetReserveInGameFlag()
  mvars.dem_resereveEnableInGameFlag=false
end
function this.EnableInGameFlagIfResereved()
  if mvars.dem_resereveEnableInGameFlag then
    mvars.dem_resereveEnableInGameFlag=false
    TppMission.EnableInGameFlag()
  end
end
function this.ReserveInTheBackGround(n)
  if not t(n)then
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
    this.SetPlayerPause()
  end
end
function this.ExecuteBackGroundLoad(n)
  if mvars.dem_reservedDemoLoadPosition then
    this.SetStageBlockLoadPosition(mvars.dem_reservedDemoLoadPosition)
    this.SetPlayerWarpAndPause(mvars.dem_reservedDemoLoadPosition)
    mvars.dem_DoneBackGroundLoading=true
  else
    local t,n,a=DemoDaemon.GetStartPosition(n,"Player")
    if not t then
      mvars.dem_DoneBackGroundLoading=true
      return
    end
    this.SetStageBlockLoadPosition(n)
    this.SetPlayerWarp(n,a)
    mvars.dem_DoneBackGroundLoading=true
  end
end
function this.SetStageBlockLoadPosition(e)
  TppGameStatus.Set("TppDemo.ReserveInTheBackground","S_IS_BLACK_LOADING")
  mvars.dem_isSetStageBlockPosition=true
  StageBlockCurrentPositionSetter.SetEnable(true)StageBlockCurrentPositionSetter.SetPosition(e:GetX(),e:GetZ())
end
function this.SetPlayerPause()
  mvars.dem_isPlayerPausing=true
  Player.SetPause()
end
function this.SetPlayerWarp(e,a)
  mvars.dem_isPlayerPausing=true
  Player.SetPause()
  local n={type="TppPlayer2",index=0}
  local e={id="WarpAndWaitBlock",pos={e:GetX(),e:GetY(),e:GetZ()},rotY=a}
  GameObject.SendCommand(n,e)
end
function this.UnsetStageBlockLoadPosition()
  TppGameStatus.Reset("TppDemo.ReserveInTheBackground","S_IS_BLACK_LOADING")
  if mvars.dem_isSetStageBlockPosition then
    StageBlockCurrentPositionSetter.SetEnable(false)
  end
  mvars.dem_isSetStageBlockPosition=false
end
function this.UnsetPlayerPause()
  if mvars.dem_isPlayerPausing then
    Player.UnsetPause()
  end
  mvars.dem_isPlayerPausing=false
end
function this.ClearReserveInTheBackGround()
  mvars.dem_reservedDemoId=nil
  mvars.dem_reservedDemoLoadPosition=nil
end
function this.CheckEventDemoDoor(o,n,e)
  local t=TppPlayer.GetPosition()
  local i=30
  if o==nil then
    return false
  end
  if Tpp.IsTypeTable(n)then
    t=n
  elseif n==nil then
  end
  if Tpp.IsTypeNumber(e)and e>0 then
    i=e
  elseif e==nil then
  end
  local n=0
  local r,s=0,1
  local a=Tpp.IsNotAlert()
  local t=TppEnemy.IsActiveSoldierInRange(t,i)
  local e
  if a==true and t==false then
    n=r
    e=true
  else
    n=s
    e=false
  end
  Player.SetEventLockDoorIcon{doorId=o,isNgIcon=n}
  return e,a,(not t)
end
function this.SpecifyIgnoreNpcDisable(e)
  local n
  if Tpp.IsTypeString(e)then
    n={e}
  elseif t(e)then
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
function this.ClearIgnoreNpcDisableOnDemoEnd()
  if not mvars.dem_npcDisableList then
    return
  end
  for n,e in ipairs(mvars.dem_npcDisableList)do
    TppEnemy.SetIgnoreDisableNpc(e,false)
  end
  mvars.dem_npcDisableList=nil
end
function this.OnAllocate(n)
  mvars.dem_demoList={}
  mvars.dem_invDemoList={}
  mvars.dem_invScdDemolist={}
  mvars.dem_demoFuncs={}
  mvars.dem_demoFlags={}
  mvars.dem_playedList={}
  mvars.dem_isSkipped={}
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  mvars.demo_playRequestInfo={}
  mvars.demo_playRequestInfo={missionBlock={},demoBlock={}}
  mvars.demo_finishWaitRequestInfo={}
  local n=n.demo
  if n and t(n.demoList)then
    this.Register(n.demoList)
  end
end
function this.Init(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(n)
  this.OnAllocate(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.Update()
  local n=mvars
  local e=this
  if n.dem_reservedDemoId then
    if r(n.dem_reservedDemoId)then
      if not n.dem_DoneBackGroundLoading then
        e.ExecuteBackGroundLoad(n.dem_reservedDemoId)
      end
    else
      if DebugText then
        n.dem_debugReserveInTheBackGroundText="TppDemo: Do back-ground load. Waiting find demo data body. demoId = "..tostring(n.dem_reservedDemoId)
      end
    end
    if DebugText then
      if n.dem_debugReserveInTheBackGroundText then
        DebugText.Print(DebugText.NewContext(),{.5,.5,1},n.dem_debugReserveInTheBackGroundText)
      end
    end
  end
  e.OnUpdatePlayRescueDemoCoroutine()
  e.ProcessPlayRequest(n.demo_playRequestInfo.missionBlock)
  e.ProcessFinishWaitRequestInfo()
  e.OnUpdateForCheckTerminate()
end
function this.Register(e)
  mvars.dem_demoList=e
  for n,e in pairs(e)do
    mvars.dem_invDemoList[e]=n
    mvars.dem_invScdDemolist[o(e)]=n
  end
end
function this.AddDemo(n,e)
  mvars.dem_demoList[n]=e
  mvars.dem_invDemoList[e]=n
  mvars.dem_invScdDemolist[o(e)]=n
end
function this.OnMessage(s,i,r,o,t,a,n)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,s,i,r,o,t,a,n)
end
function this.FadeOutOnSkip()
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"DemoFadeOutOnSkip",TppUI.FADE_PRIORITY.DEMO)
end
function this.OnDemoPlay(n,a)
  if mvars.dem_playedList[n]==nil then
    return
  end
  local n=mvars.dem_demoFlags[n]or{}
  if not n.startNoFadeIn then
    local e=n.fadeSpeed or TppUI.FADE_SPEED.FADE_NORMALSPEED
    TppUI.FadeIn(e,"DemoPlayFadeIn",TppUI.FADE_PRIORITY.DEMO)
  end
  if n.useDemoBlock then
    mvars.dem_startedDemoBlockDemo=false
  end
  if mvars.dem_resereveEnableInGameFlag then
    if TppMission.GetMissionClearState()<=TppDefine.MISSION_CLEAR_STATE.MISSION_GAME_END then
      TppSoundDaemon.ResetMute"Loading"end
  end
  this.UnsetStageBlockLoadPosition()
  this.UnsetPlayerPause()
end
function this.OnDemoEnd(n)
  if mvars.dem_playedList[n]==nil then
    return
  end
  local a=mvars.dem_demoFlags[n]or{}
  local n=mvars.dem_demoList[n]
  local t={p31_070050_001_final=true}
  if t[n]then
    TppSound.SetMuteOnLoading()
  end
  if mvars.dem_tempPlayerInfo then
    this.AddFinishWaitRequestInfo(n,a,"playerModelReloaded")
  end
  if a.waitTextureLoadOnDemoEnd then
    this.AddFinishWaitRequestInfo(n,a,"waitTextureLoadOnDemoEnd")
  end
  if mvars.dem_isSkipped[n]then
    this.AddFinishWaitRequestInfo(n,a,"waitFadeInOnDemoSkip")
  end
  this.AddFinishWaitRequestInfo(n,a)
end
function this.OnDemoInterrupt(n)
  if mvars.dem_playedList[n]==nil then
    return
  end
  this.OnDemoEnd(n)
end
function this.OnDemoSkip(e,t)
  local n=mvars.dem_demoList[e]
  local a=mvars.dem_demoFlags[e]or{}
  local a={p31_010010=true,p41_030005_000_final=true,p51_070020_000_final=true,p31_050026_000_final=true}
  if a[n]then
    TppSoundDaemon.SetMuteInstant"Loading"end
  mvars.dem_isSkipped[n]=true
  mvars.dem_currentSkippedDemoName=e
  mvars.dem_currentSkippedScdDemoID=t
  if mvars.dem_playedList[e]==nil then
    return
  end
end
function this.EnableWaitBlockLoadOnDemoSkip()
  local a=mvars.dem_currentSkippedDemoName
  if not a then
    return
  end
  local n=mvars.dem_demoFlags[a]or{}
  local a=mvars.dem_demoList[a]
  if n.waitBlockLoadEndOnDemoSkip then
    this.AddFinishWaitRequestInfo(a,n,"waitBlockLoadEndOnDemoSkip")
    if not n.finishFadeOut then
      this.AddFinishWaitRequestInfo(a,n,"waitTextureLoadOnDemoEnd")
    end
  end
end
function this.OnDemoSkipAndBlockLoadEnd()
  if mvars.dem_enableWaitBlockLoadOnDemoSkip~=nil then
    mvars.dem_enableWaitBlockLoadOnDemoSkip=nil
  end
end
function this.DoOnEndMessage(n,t,o,i,r)
  local a=true
  if(not t)then
    if i and(not r)then
      a=false
    end
    if a then
      TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"DemoSkipFadeIn",TppUI.FADE_PRIORITY.DEMO,{exceptGameStatus=o})
    end
  end
  this._DoMessage(n,"onEnd")
  this._CheckTerminate(n,a)
  mvars.dem_currentSkippedDemoName=nil
  mvars.dem_currentSkippedScdDemoID=nil
  this.EnableInGameFlagIfResereved()
  this.EnableNpc(n)
end
function this.OnDemoDisable(n)
  if mvars.dem_playedList[n]==nil then
    return
  end
  this.OnDemoEnd(n)
end
function this.AddPlayReqeustInfo(o,n)
  local a=this.MakeNewPlayRequestInfo(n)
  for i,t in pairs(a)do
    local t=true
    local e=this.PLAY_REQUEST_START_FUNC[i]
    if e then
      t=e(o,n)
    else
      if e==nil then
        a[i]=nil
        t=true
      end
    end
    if not t then
      return false
    end
  end
  if not n.isInGame then
    TppRadio.Stop()
  end
  this.DisableGameStatusOnPlayRequest(n.isInGame)
  if n and n.useDemoBlock then
    mvars.demo_playRequestInfo.demoBlock[o]=a
  else
    mvars.demo_playRequestInfo.missionBlock[o]=a
  end
  return true
end
function this.MakeNewPlayRequestInfo(e)
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
  local i
  if not e.ignorePlayerAction and((not e.isInGame)or(e.isNotAllowedPlayerAction))then
    i=false
  end
  local a
  if e.playerMoveToPosition then
    a=false
  end
  local n
  if e.waitTextureLoadOnDemoPlay then
    n=false
  end
  local e={missionStateCheck=false,gameCameraInterpedToDemo=o,demoBlockLoaded=t,playerModelReloaded=playerModelReloaded,playerActionAllowed=i,playerMoveToPosition=a,waitTextureLoadOnDemoPlay=n}
  return e
end
function this.DeletePlayRequestInfo(n,e)
  if e and e.useDemoBlock then
    mvars.demo_playRequestInfo.demoBlock[n]=nil
  else
    mvars.demo_playRequestInfo.missionBlock[n]=nil
  end
end
function this.ProcessPlayRequest(n)
  if not next(n)then
    return
  end
  for n,a in pairs(n)do
    local a=this.CanStartPlay(n,a)
    if a then
      if not d()then
        if not l(n)then
          local a=mvars.dem_invDemoList[n]
          local t=mvars.dem_demoFlags[a]
          this._Play(a,n)
          this.DeletePlayRequestInfo(n,t)
        else
          if DebugText then
            DebugText.Print(DebugText.NewContext(),{.5,.5,1},"Now playing : demoID = "..tostring(n))
          end
        end
      else
        if DebugText then
          DebugText.Print(DebugText.NewContext(),{.5,.5,1},"Now demo paused")
        end
      end
    end
  end
end
function this.CanStartPlay(t,a)
  local o=true
  if DebugText then
    DebugText.Print(DebugText.NewContext(),{.5,.5,1},"Now waiting can play : "..tostring(t))
  end
  for n,i in pairs(a)do
    if i==false then
      local e=this.PLAY_REQUEST_START_CHECK_FUNC[n](t)
      if DebugText then
        DebugText.Print(DebugText.NewContext(),{.5,.5,1},"CheckCanPlay : checkTypeName : "..(n..(", canPlay = "..tostring(e))))
      end
      if e then
        a[n]=true
      else
        o=false
      end
    end
  end
  return o
end
function this.AddFinishWaitRequestInfo(t,a,n)
  local a
  local o=true
  if n then
    a=this.FINISH_WAIT_START_FUNC[n]
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
function this.ProcessFinishWaitRequestInfo()
  local n=mvars.demo_finishWaitRequestInfo
  if not next(n)then
    return
  end
  for n,a in pairs(n)do
    local a=this.CanFinishPlay(n,a)
    if a then
      local t=mvars.dem_invDemoList[n]
      local a=mvars.dem_demoFlags[t]or{}
      mvars.demo_finishWaitRequestInfo[n]=nil
      this.DoOnEndMessage(t,a.finishFadeOut,a.exceptGameStatus,a.isInGame,mvars.dem_isSkipped[n])
    end
  end
end
function this.CanFinishPlay(a,t)
  local o=true
  if DebugText then
    DebugText.Print(DebugText.NewContext(),{.5,.5,1},"Now waiting can finish demo: "..tostring(a))
  end
  for n,i in pairs(t)do
    if i==false then
      local e=this.FINISH_WAIT_CHECK_FUNC[n](a)
      if DebugText then
        DebugText.Print(DebugText.NewContext(),{.5,.5,1},"CheckCanFinish : checkTypeName : "..(n..(", canFinish = "..tostring(e))))
      end
      if e then
        t[n]=true
      else
        o=false
      end
    end
  end
  return o
end
function this.GetPlayerVoiceSoundEventName()
  local e={[PlayerType.AVATAR_MALE]={"Set_State_ply_ma","Set_State_ply_mb","Set_State_ply_mc","Set_State_ply_md"},[PlayerType.AVATAR_FEMALE]={"Set_State_ply_fa","Set_State_ply_fb","Set_State_ply_fc","Set_State_ply_fd"}}
  local e=e[vars.playerType]
  if not e then
    return"player_ma"
  end
  local n=e[vars.avatarVoiceIndex+1]
  if not n then
    return e[1]
  end
  return n
end
function this.SetPlayerVoiceType()
  local e=this.GetPlayerVoiceSoundEventName()
  TppSoundDaemon.PostEvent(e)
end
function this.OnUpdateForCheckTerminate()
  if not mvars.dem_checkTerminate then
    return
  end
  if SsdFadeManager.IsFadeOutOrProcessing()then
    return
  end
  if TppGameStatus.IsSet("","S_DISABLE_HUD")then
    return
  end
  this._DoMessage(mvars.dem_checkTerminateDemoName,"onFinalize")
  mvars.dem_checkTerminateDemoName=nil
  mvars.dem_checkTerminate=false
end
function this._Play(a,n)
  mvars.dem_playedList[a]=true
  this.ClearReserveInTheBackGround()DemoDaemon.Play(n)
end
function this._OnDemoInit(n)
  local n=mvars.dem_invScdDemolist[n]
  if n then
    this._DoMessage(n,"onInit")
  end
end
function this._OnDemoPlay(a)
  local n=mvars.dem_invScdDemolist[a]
  if n then
    this.DisableGameStatusOnPlayStart()
    this.SetPlayerVoiceType()
    this.OnDemoPlay(n,a)
    this._DoMessage(n,"onStart")
  end
end
function this._OnDemoEnd(n)
  local n=mvars.dem_invScdDemolist[n]
  if n then
    this.OnDemoEnd(n)
    mvars.dem_playedList[n]=nil
  end
end
function this._OnDemoInterrupt(n)
  local n=mvars.dem_invScdDemolist[n]
  if n then
    this.OnDemoInterrupt(n)
    this._DoMessage(n,"onInterrupt")
  end
end
function this._OnDemoSkip(a)
  local n=mvars.dem_invScdDemolist[a]
  if n then
    this.OnDemoSkip(n,a)
    this._DoMessage(n,"onSkip")
  end
end
function this._OnDemoDisable(n)
  local n=mvars.dem_invScdDemolist[n]
  if n then
    this.OnDemoDisable(n)
    this._DoMessage(n,"onDisable")
    mvars.dem_playedList[n]=nil
  end
end
function this._DoMessage(e,n)
  if((mvars.dem_demoFuncs==nil or mvars.dem_demoFuncs[e]==nil)or mvars.dem_demoFuncs[e][n]==nil)then
    return
  end
  mvars.dem_demoFuncs[e][n]()
end
function this.EnableNpc(t)
  local a=mvars.dem_demoFlags[t]or{}
  if not a.isInGame then
    local n="all"local t=mvars.dem_demoList[t]
    if a.finishFadeOut or mvars.dem_isSkipped[t]then
      n={}
      for a,e in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
        n[a]=e
      end
    end
    this.EnableGameStatus(n,a.exceptGameStatus)
  end
  this.ClearIgnoreNpcDisableOnDemoEnd()
end
function this._CheckTerminate(n,t)
  if not mvars.dem_demoFuncs==nil then
    return
  end
  local a=mvars.dem_demoFuncs[n]
  if not a or not a.onFinalize then
    return
  end
  if not t then
    this._DoMessage(n,"onFinalize")
    return
  end
  mvars.dem_checkTerminateDemoName=n
  mvars.dem_checkTerminate=true
end
return this
