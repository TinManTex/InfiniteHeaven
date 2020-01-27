--InfCamera.lua
local this={}
--LOCALOPT
local InfMain=InfMain
local IsDemoPaused=DemoDaemon.IsDemoPaused
local IsDemoPlaying=DemoDaemon.IsDemoPlaying
local Vector3=Vector3
local Ivars=Ivars
local SetCameraParams=Player.SetAroundCameraManualModeParams
local UpdateCameraParams=Player.UpdateAroundCameraManualModeParams

this.moveUpButton=InfButton.DASH
this.moveDownButton=InfButton.ZOOM_CHANGE

this.resetModeButton=InfButton.SUBJECT
this.verticalModeButton=InfButton.ACTION
this.zoomModeButton=InfButton.FIRE
this.apertureModeButton=InfButton.RELOAD
this.focusDistanceModeButton=InfButton.STANCE
this.distanceModeButton=InfButton.HOLD
this.speedModeButton=InfButton.ACTION

--tex updateState
this.active='adjustCameraUpdate'
this.execState={
  nextUpdate=0,
}

local cameraOffsetDefault=Vector3(0,0.75,0)
--this.cameraPosition=cameraOffsetDefault--CULL
--this.cameraOffset=cameraOffsetDefault

-->
this.registerIvars={
  'adjustCameraUpdate',
  'cameraMode',
  'moveScale',
  'disableCamText',
}

this.adjustCameraUpdate={
  inMission=true,
  nonConfig=true,
  --save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  isMode=true,
  --disableActions=PlayerDisableAction.OPEN_CALL_MENU+PlayerDisableAction.OPEN_EQUIP_MENU,--tex OFF not really needed, padmask is sufficient
  OnModeActivate=function()InfCamera.OnActivateCameraAdjust()end,
  OnChange=function(self,previousSetting,setting)
    if Ivars.warpPlayerUpdate:Is(1) then
      self:SetDirect(0)
      InfMenu.PrintLangId"other_control_active"
      return
    end

    if setting==1 then
      --      if Ivars.cameraMode:Is(0) then
      --        InfMenu.PrintLangId"cannot_edit_default_cam"
      --        setting=0
      --        return
      --      else
      InfMenu.PrintLangId"cam_mode_on"
      --InfMain.ResetCamDefaults()
      InfCamera.OnActivateCameraAdjust()
      Ivars.cameraMode:Set(1)
      --end
    else
      InfMenu.PrintLangId"cam_mode_off"
      InfCamera.OnDectivateCameraAdjust()
      Ivars.cameraMode:Set(0)
    end

    if InfMenu.menuOn then
      InfMain.RestoreActionFlag()--TODO only restore those that menu disables that this doesnt
      InfMenu.MenuOff()
    end
  end,
}

this.cameraMode={
  inMission=true,
  --save=IvarProc.CATEGORY_EXTERNAL,
  settings={"DEFAULT","CAMERA"},--"PLAYER","CAMERA"},
  OnChange=function(self,previousSetting)
    if self:Is"DEFAULT" then
      Player.SetAroundCameraManualMode(false)
    else
      Player.SetAroundCameraManualMode(true)
      InfCamera.UpdateCameraManualMode()
    end
  end,
}

this.moveScale={--Set
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  default=0.5,
  range={max=10,min=0.01,increment=0.1},
}

this.disableCamText={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.camNames={
  "FreeCam",
--  "PlayerStand",
--  "PlayerSquat",
--  "PlayerCrawl",
--  "PlayerDash",
}
this.camIvarPrefixes={
  'focalLength',
  'focusDistance',
  'aperture',
  'distance',
  'positionX',
  'positionY',
  'positionZ',
}

for i,camName in ipairs(this.camNames) do
  this["focalLength"..camName]={
    inMission=true,
    --OFF save=IvarProc.CATEGORY_EXTERNAL,
    default=21,
    range={max=10000,min=0.1,increment=1},
  }

  this["focusDistance"..camName]={
    inMission=true,
    --OFF save=IvarProc.CATEGORY_EXTERNAL,
    default=8.175,
    range={max=1000,min=0.01,increment=0.1},
  }

  this["aperture"..camName]={
    inMission=true,
    --OFF save=IvarProc.CATEGORY_EXTERNAL,
    default=1.875,
    range={max=100,min=0.001,increment=0.1},
  }

  this["distance"..camName]={
    inMission=true,
    --OFF save=IvarProc.CATEGORY_EXTERNAL,
    default=0,--WIP TODO need seperate default for playercam and freemode (player wants to be about 5, free 0)
    range={max=100,min=0,increment=0.1},
  }

  this["positionX"..camName]={
    inMission=true,
    --OFF save=IvarProc.CATEGORY_EXTERNAL,
    default=0,
    range={max=1000,min=0,increment=0.1},
    noBounds=true,
  }
  this["positionY"..camName]={
    inMission=true,
    --OFF save=IvarProc.CATEGORY_EXTERNAL,
    default=0,
    range={max=1000,min=0,increment=0.1},
    noBounds=true,
  }
  this["positionZ"..camName]={
    inMission=true,
    --OFF save=IvarProc.CATEGORY_EXTERNAL,
    default=0,
    range={max=1000,min=0,increment=0.1},
    noBounds=true,
  }

  for i,prefix in ipairs(this.camIvarPrefixes)do
    this.registerIvars[#this.registerIvars+1]=prefix..camName
  end
end
--< ivar defs
--menuCommands
this.WarpToCamPos=function()
  local warpPos=this.ReadPosition"FreeCam"
  InfCore.DebugPrint("warp pos:".. warpPos:GetX()..",".. warpPos:GetY().. ","..warpPos:GetZ())
  TppPlayer.Warp{pos={warpPos:GetX(),warpPos:GetY(),warpPos:GetZ()},rotY=vars.playerCameraRotation[1]}
end

this.ShowFreeCamPosition=function()
  local currentCamName=this.GetCurrentCamName()
  local movePosition=this.ReadPosition(currentCamName)

  --tex TODO: dump to seperate file
  local x,y,z=movePosition:GetX(),movePosition:GetY(),movePosition:GetZ()
  local rotY=vars.playerCameraRotation[1]
  local positionTable=string.format("{pos={%.3f,%.3f,%.3f},rotY=%.3f,},",x,y,z,rotY)
  local positionXML=string.format('<value x="%.3f" y="%.3f" z="%.3f" w="0" />',x,y,z)
  table.insert(this.positions,positionTable)
  table.insert(this.positionsXML,positionXML)

  --    InfCore.Log(positionTable)
  --    InfCore.Log(positionXML)
  InfCore.Log("positions:\n"..table.concat(this.positions,"\n"),false,true)
  InfCore.Log("positionsxml:\n"..table.concat(this.positionsXML,"\n"),false,true)
  InfCore.DebugPrint("Position written to ih_log")
end
--quickmenu commands
this.ToggleCamMode=function()
  InfMenu.PrintLangId"freecam_non_adjust"
  if Ivars.cameraMode:Is(0) then
    Ivars.cameraMode:Set(1)
  else
    Ivars.cameraMode:Set(0)
  end
end

this.ToggleFreeCam=function()
  --InfCore.DebugPrint"quickmenu RELOAD"--DEBUG
  if Ivars.adjustCameraUpdate:Is(0) then
    Ivars.adjustCameraUpdate:Set(1)
  else
    Ivars.adjustCameraUpdate:Set(0)
  end
end
--< menu commands
-->
this.registerMenus={
  'cameraMenu',
}

this.cameraMenu={
  options={
    "Ivars.adjustCameraUpdate",
    "Ivars.cameraMode",
    "InfCamera.WarpToCamPos",
    "Ivars.moveScale",
    "Ivars.disableCamText",
    "InfMenuCommands.SetStageBlockPositionToFreeCam",
    "InfCamera.ShowFreeCamPosition",
  --    "Ivars.focalLength",--CULL
  --    "Ivars.focusDistance",
  --    "Ivars.aperture",
  --    "InfMenuCommands.ResetCameraSettings",--tex just reset cam pos at the moment
  }
}
--< menu defs
this.langStrings={
  eng={
    adjustCameraUpdate="Adjust-cam [Mode]",
    cam_mode_on="Adjust-cam mode on",
    cam_mode_off="Adjust-cam mode off",
    moveScale="Cam speed scale",
    cameraMode="Camera mode",
    cameraModeSettings={"Default","Free cam"},--"Player","Free cam"},
    cameraMenu="Camera menu",
    focal_length_mode="Focal length mode",
    aperture_mode="Aperture mode",
    focus_distance_mode="Focus distance mode",
    vertical_mode="Vertical mode",
    speed_mode="Speed mode",
    reset_mode="Reset mode",
    resetCameraSettings="Set cam to near player",
    other_control_active="Another control mode is active",
    cannot_edit_default_cam="Cannot adjust Camera mode Default",
    distance_mode="Distance mode",
    disableCamText="Disable mode text feedback",
    warpToCamPos="Warp body to FreeCam position",
    showFreeCamPosition="Show freecam position",
    freecam_non_adjust="Static cam mode",
  },
  help={
    eng={
      cameraMenu="Lets you move a detached camera, use the main movement stick/keys in combination with other keys/buttons to adjust camera settings, including Zoom, aperture, focus distance.",
      adjustCameraUpdate=[[
  Move cam with normal move keys 

  <Dash>(Shift or Left stick click) to move up

  <Switch zoom>(Middle mouse or Right stick click) to move down

  Hold the following and move left stick up/down to increase/decrease the settings:

  <Fire> - Zoom/focal length

  <Reload> - Aperture (DOF)

  <Stance> - Focus distance (DOF) 

  <Action> - Cam move speed

  <Ready weapon> - Camera orbit distance

  Or hold <Binocular> and press the above to reset that setting.

  Hold <Binocular> and press <Dash> to move free cam position to the player position]],

    },
  }
}

--function this.ResetCamDefaults()--CULL
--  local currentPos = Vector3(vars.playerPosX, vars.playerPosY, vars.playerPosZ)
--  this.cameraPosition=currentPos+cameraOffsetDefault
--end

--function this.ResetCamPosition()--CULL
--  local currentPos = Vector3(vars.playerPosX, vars.playerPosY, vars.playerPosZ)
--  this.cameraPosition=currentPos+cameraOffsetDefault
--end
--SYNC: Ivars camNames
function this.GetCurrentCamName()
  --WIP
  --  if Ivars.cameraMode:Is"PLAYER" then
  --    if PlayerInfo.OrCheckStatus{PlayerStatus.STAND}then
  --      return "PlayerStand"
  --    elseif PlayerInfo.OrCheckStatus{PlayerStatus.SQUAT}then
  --      return "PlayerSquat"
  --    elseif  PlayerInfo.OrCheckStatus{PlayerStatus.CRAWL}then
  --      return "PlayerCrawl"
  --    elseif  PlayerInfo.OrCheckStatus{PlayerStatus.DASH}then
  --      return "PlayerDash"
  --    else
  --      InfCore.DebugPrint"UpdateCameraManualMode: unknow PlayerStatus"
  --    end
  --  else
  return "FreeCam"
    --  end
end

local positionXStr="positionX"
local positionYStr="positionY"
local positionZStr="positionZ"
function this.ReadPosition(camName)
  local ivars=ivars
  return Vector3(ivars[positionXStr..camName],ivars[positionYStr..camName],ivars[positionZStr..camName])
end

function this.WritePosition(camName,position)
  local ivars=ivars
  ivars[positionXStr..camName]=position:GetX()
  ivars[positionYStr..camName]=position:GetY()
  ivars[positionZStr..camName]=position:GetZ()
end

--REF
--    Player.SetAroundCameraManualModeParams{
--      --offset=this.cameraOffset,
--      distance=0,--1.2,
--      focalLength=focalLength:Get(),
--      focusDistance=focusDistance:Get(),
--      aperture=aperture:Get(),
--      --target=Vector3(0,0,0),--tex only if targetIsPlayer?--Vector3(0,1000,0),--Vector3(2,10,10),
--      target=movePosition,
--      targetInterpTime=.2,
--      --targetIsPlayer=true,
--      --targetOffsetFromPlayer=Vector3(0,0,0.5),
--      --rotationBasedOnPlayer = true,
--      ignoreCollisionGameObjectName="Player",
--      --ignoreCollisionGameObjectId
--      rotationLimitMinX=-90,
--      rotationLimitMaxX=90,
--      alphaDistance=.5,
--    --interpImmediately = immediately,
--    --enableStockChangeSe = true,
--    --rotationBasedOnPlayer = true,
--    --useShakeParam = true
--    }

function this.UpdateCameraManualMode()
  local Ivars=Ivars
  local currentCamName=this.GetCurrentCamName()
  local focalLength=Ivars["focalLength"..currentCamName]
  local aperture=Ivars["aperture"..currentCamName]
  local focusDistance=Ivars["focusDistance"..currentCamName]
  local cameraDistance=Ivars["distance"..currentCamName]
  local movePosition=this.ReadPosition(currentCamName)
  --WIP
  --  if Ivars.cameraMode:Is"PLAYER" then
  --    Player.SetAroundCameraManualModeParams{
  --      offset=movePosition,--this.cameraOffset,--Vector3(0.0,0.75,0),--this.cameraOffset,
  --      distance=cameraDistance:Get(),
  --      focalLength=focalLength:Get(),
  --      focusDistance=focusDistance:Get(),
  --      aperture=aperture:Get(),
  --      --target=Vector3(0,0,0),--tex only if targetIsPlayer?--Vector3(0,1000,0),--Vector3(2,10,10),--this.cameraPosition,
  --      targetInterpTime=.2,
  --      targetIsPlayer=true,
  --      --targetOffsetFromPlayer=Vector3(0,0,0.5),
  --      --rotationBasedOnPlayer = true,
  --      ignoreCollisionGameObjectName="Player",
  --      --TEST OFF rotationLimitMinX=-60,
  --      --TEST OFF rotationLimitMaxX=80,
  --      alphaDistance=0--.1,--3--.5,
  --    --enableStockChangeSe = false,
  --    --useShakeParam = true
  --    }
  --  else
  SetCameraParams{
    target=movePosition,
    distance=cameraDistance:Get(),
    focalLength=focalLength:Get(),
    focusDistance=focusDistance:Get(),
    aperture=aperture:Get(),
    targetInterpTime=.4,
    ignoreCollisionGameObjectName="Player",
    rotationLimitMinX=-90,
    rotationLimitMaxX=90,
    alphaDistance=0,
  }
  -- end
  UpdateCameraParams()
end

function this.OnActivateCameraAdjust()
  --KLUDGE
  local currentCamName=this.GetCurrentCamName()
  local currentCamPos=this.ReadPosition(currentCamName)
  --InfCore.DebugPrint(currentCamPos:GetX()..","..currentCamPos:GetY()..","..currentCamPos:GetZ())--DEBUG
  if currentCamPos:GetX()==0 and currentCamPos:GetY()==0 and currentCamPos:GetZ()==0 then
    local currentPos=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
    this.WritePosition(currentCamName,currentPos+cameraOffsetDefault)
  end
  --this.DisableAction(Ivars.adjustCameraUpdate.disableActions)--tex OFF not really needed, padmask is sufficient
  Player.SetPadMask(InfMain.allButCamPadMask)
end

function this.OnDectivateCameraAdjust()
  --this.EnableAction(Ivars.adjustCameraUpdate.disableActions)--tex OFF not really needed, padmask is sufficient
  Player.ResetPadMask {
    settingName = "allButCam",
  }
end

function this.Update(currentChecks,currentTime,execChecks,execState)
  --InfCore.PCall(function(currentChecks,currentTime,execChecks,execState)--DEBUG
  local Ivars=Ivars

  if not currentChecks.inGame then
    if not IsDemoPaused() and not IsDemoPlaying() then
      if Ivars.adjustCameraUpdate:Is(1) then
        Ivars.adjustCameraUpdate:Set(0)
      end
      return
    end
  end

  if Ivars.adjustCameraUpdate:Is(0) then
    if Ivars.cameraMode:Is()>0 then
      this.UpdateCameraManualMode()
    end
    return
  end

  if Ivars.cameraMode:Is(0) then
    --OFF    InfMenu.PrintLangId"cannot_edit_default_cam"
    Ivars.adjustCameraUpdate:Set(0)
    return
  end

  this.DoControlSet(currentChecks)

  this.UpdateCameraManualMode()
  --end,currentChecks,currentTime,execChecks,execState)--DEBUG
end

function this.DoControlSet(currentChecks)
  --InfCore.PCall(function(currentChecks)--DEBUG
  local Ivars=Ivars
  local InfButton=InfButton

  local isFreeCam=Ivars.cameraMode:Is"CAMERA"

  local moveAmount=1
  local zoomAmount=4
  local deadZone=0

  local moveX=0
  local moveY=0
  local moveZ=0

  local leftStickX=PlayerVars.leftStickXDirect
  local leftStickY=PlayerVars.leftStickYDirect

  local didMove=false
  if math.abs(leftStickX)>deadZone or math.abs(leftStickY)>deadZone then--tex seem like game already handles deadzone?
    didMove=true
  end

  local currentCamName=this.GetCurrentCamName()
  local focalLength=Ivars["focalLength"..currentCamName]
  local aperture=Ivars["aperture"..currentCamName]
  local focusDistance=Ivars["focusDistance"..currentCamName]
  local cameraDistance=Ivars["distance"..currentCamName]
  local movePosition=this.ReadPosition(currentCamName)
  local moveScale=Ivars.moveScale

  local currentMoveScale=moveScale:Get()
  if not isFreeCam then
    currentMoveScale=currentMoveScale*0.1
  end
  --tex TUNE pretty much doing voodoo to tune these
  local adjustScaleVerySlow=focalLength:Get()/1000--1
  local adjustScaleSlow=focalLength:Get()/100--1
  local adjustScaleMed=aperture:Get()/50--0.1
  local adjustScaleFast=focusDistance:Get()/10--0.1

  moveX=-leftStickX*currentMoveScale
  moveZ=-leftStickY*currentMoveScale

  local moveAmount=1
  if not InfButton.ButtonDown(this.resetModeButton) then--tex reusing these buttons in reset mode
    if InfButton.ButtonDown(this.moveUpButton)
      or InfButton.OnButtonRepeat(this.moveUpButton) then
    moveY=moveAmount*currentMoveScale
    didMove=true
  end
  if InfButton.ButtonDown(this.moveDownButton)
    or InfButton.OnButtonRepeat(this.moveDownButton) then
    moveY=-moveAmount*currentMoveScale
    didMove=true
  end
  end

  if not currentChecks.inMenu then
    local function IvarClamp(ivar,value)
      if value>ivar.range.max then
        value=ivar.range.max
      elseif value<ivar.range.min then
        value=ivar.range.min
      end
      return value
    end

    if didMove then
      if InfButton.ButtonDown(this.zoomModeButton) then
        local newValue=focalLength:Get()-leftStickY*adjustScaleSlow
        newValue=IvarClamp(focalLength,newValue)
        focalLength:Set(newValue)
      elseif InfButton.ButtonDown(this.apertureModeButton) then
        local newValue=aperture:Get()-leftStickY*adjustScaleMed
        newValue=IvarClamp(aperture,newValue)
        aperture:Set(newValue)
      elseif InfButton.ButtonDown(this.focusDistanceModeButton) then
        local newValue=focusDistance:Get()-leftStickY*adjustScaleFast
        newValue=IvarClamp(focusDistance,newValue)
        focusDistance:Set(newValue)
        --CULL
        --      elseif InfButton.ButtonDown(this.verticalModeButton) then
        --        moveY=moveZ
        --        moveZ=0
        --        local vMoveDir=Vector3(moveX,moveY,moveZ)
        --        local rotYQuat=Quat.RotationY(TppMath.DegreeToRadian(vars.playerCameraRotation[1]))
        --        local camMoveDir=rotYQuat:Rotate(vMoveDir)
        --        movePosition=movePosition+camMoveDir
      elseif InfButton.ButtonDown(this.speedModeButton) then
        local newValue=moveScale:Get()-leftStickY*adjustScaleVerySlow--WIP TODO own scale
        newValue=IvarClamp(moveScale,newValue)
        moveScale:Set(newValue)
      elseif InfButton.ButtonDown(this.distanceModeButton) then
        local newValue=cameraDistance:Get()+leftStickY*adjustScaleFast--WIP TODO own scale
        newValue=IvarClamp(cameraDistance,newValue)
        cameraDistance:Set(newValue)
      else
        local vMoveDir=Vector3(moveX,moveY,moveZ)
        local rotY=0
        if vars.playerCameraRotation~=nil then--TODO find altenate
          rotY=vars.playerCameraRotation[1]
        end
        local rotYQuat=Quat.RotationY(TppMath.DegreeToRadian(rotY))
        local camMoveDir=rotYQuat:Rotate(vMoveDir)
        movePosition=movePosition+camMoveDir
      end
    end--didmove
    --
    if InfButton.ButtonDown(this.resetModeButton) and not InfMenu.quickMenuOn then
      if InfButton.OnButtonDown(this.zoomModeButton) then
        focalLength:Reset()
      elseif InfButton.OnButtonDown(this.apertureModeButton) then
        aperture:Reset()
      elseif InfButton.OnButtonDown(this.focusDistanceModeButton) then
        focusDistance:Reset()
      elseif InfButton.OnButtonDown(this.moveUpButton) then
        if isFreeCam then
          local currentPos = Vector3(vars.playerPosX, vars.playerPosY, vars.playerPosZ)
          movePosition=currentPos+cameraOffsetDefault
        else
          movePosition=cameraOffsetDefault
        end
      elseif InfButton.ButtonDown(this.speedModeButton) then
        moveScale:Reset()
      elseif InfButton.OnButtonDown(this.distanceModeButton) then
        if isFreeCam then--tex KLUDGE
          cameraDistance:Set(0)
        else
          cameraDistance:Reset()
        end
      end
    end
    --
    if Ivars.disableCamText:Is(0) then
      if InfButton.OnButtonDown(this.zoomModeButton) or InfButton.OnButtonUp(this.zoomModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"focal_length_mode".." "..focalLength:Get())
      end
      if InfButton.OnButtonDown(this.apertureModeButton) or InfButton.OnButtonUp(this.apertureModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"aperture_mode".." "..aperture:Get())
      end
      if InfButton.OnButtonDown(this.focusDistanceModeButton) or InfButton.OnButtonUp(this.focusDistanceModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"focus_distance_mode".." "..focusDistance:Get())
      end
      --CULL
      --      if InfButton.OnButtonDown(InfMain.verticalModeButton) then
      --        InfMenu.Print(currentCamName.." "..InfMenu.LangString"vertical_mode")
      --      end
      if InfButton.OnButtonDown(this.speedModeButton) or InfButton.OnButtonUp(this.speedModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"speed_mode".." "..moveScale:Get())
      end
      if InfButton.OnButtonDown(this.distanceModeButton) or InfButton.OnButtonUp(this.distanceModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"distance_mode".." "..cameraDistance:Get())
      end
      if InfButton.OnButtonDown(this.resetModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"reset_mode")
      end
    end
    --inmenu-v-
  else
    if didMove then
      local vMoveDir=Vector3(moveX,moveY,moveZ)
      local rotY=0
      if vars.playerCameraRotation~=nil then--TODO find altenate
        rotY=vars.playerCameraRotation[1]
      end
      local rotYQuat=Quat.RotationY(TppMath.DegreeToRadian(rotY))
      local camMoveDir=rotYQuat:Rotate(vMoveDir)
      movePosition=movePosition+camMoveDir
      --InfCore.DebugPrint("movePosition "..movePosition:GetX()..","..movePosition:GetY()..","..movePosition:GetZ())
    end
  end

  this.WritePosition(currentCamName,movePosition)
  --end,currentChecks)--DEBUG
end

return this
