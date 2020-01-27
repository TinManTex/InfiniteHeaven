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

--tex updateState
this.active=Ivars.adjustCameraUpdate
this.execState={
  nextUpdate=0,
}

local cameraOffsetDefault=Vector3(0,0.75,0)
--this.cameraPosition=cameraOffsetDefault--CULL
--this.cameraOffset=cameraOffsetDefault

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

local function WritePosition(camName,position)
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
    WritePosition(currentCamName,currentPos+cameraOffsetDefault)
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
  if not InfButton.ButtonDown(InfMain.resetModeButton) then--tex reusing these buttons in reset mode
    if InfButton.ButtonDown(InfMain.moveUpButton)
      or InfButton.OnButtonRepeat(InfMain.moveUpButton) then
    moveY=moveAmount*currentMoveScale
    didMove=true
  end
  if InfButton.ButtonDown(InfMain.moveDownButton)
    or InfButton.OnButtonRepeat(InfMain.moveDownButton) then
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
      if InfButton.ButtonDown(InfMain.zoomModeButton) then
        local newValue=focalLength:Get()-leftStickY*adjustScaleSlow
        newValue=IvarClamp(focalLength,newValue)
        focalLength:Set(newValue)
      elseif InfButton.ButtonDown(InfMain.apertureModeButton) then
        local newValue=aperture:Get()-leftStickY*adjustScaleMed
        newValue=IvarClamp(aperture,newValue)
        aperture:Set(newValue)
      elseif InfButton.ButtonDown(InfMain.focusDistanceModeButton) then
        local newValue=focusDistance:Get()-leftStickY*adjustScaleFast
        newValue=IvarClamp(focusDistance,newValue)
        focusDistance:Set(newValue)
        --CULL
        --      elseif InfButton.ButtonDown(InfMain.verticalModeButton) then
        --        moveY=moveZ
        --        moveZ=0
        --        local vMoveDir=Vector3(moveX,moveY,moveZ)
        --        local rotYQuat=Quat.RotationY(TppMath.DegreeToRadian(vars.playerCameraRotation[1]))
        --        local camMoveDir=rotYQuat:Rotate(vMoveDir)
        --        movePosition=movePosition+camMoveDir
      elseif InfButton.ButtonDown(InfMain.speedModeButton) then
        local newValue=moveScale:Get()-leftStickY*adjustScaleSlow--WIP TODO own scale
        newValue=IvarClamp(moveScale,newValue)
        moveScale:Set(newValue)
      elseif InfButton.ButtonDown(InfMain.distanceModeButton) then
        local newValue=cameraDistance:Get()+leftStickY*adjustScaleFast--WIP TODO own scale
        newValue=IvarClamp(cameraDistance,newValue)
        cameraDistance:Set(newValue)
      else
        local vMoveDir=Vector3(moveX,moveY,moveZ)
        local rotYQuat=Quat.RotationY(TppMath.DegreeToRadian(vars.playerCameraRotation[1]))
        local camMoveDir=rotYQuat:Rotate(vMoveDir)
        movePosition=movePosition+camMoveDir
      end
    end--didmove
    --
    if InfButton.ButtonDown(InfMain.resetModeButton) and not InfMenu.quickMenuOn then
      if InfButton.OnButtonDown(InfMain.zoomModeButton) then
        focalLength:Reset()
      elseif InfButton.OnButtonDown(InfMain.apertureModeButton) then
        aperture:Reset()
      elseif InfButton.OnButtonDown(InfMain.focusDistanceModeButton) then
        focusDistance:Reset()
      elseif InfButton.OnButtonDown(InfMain.moveUpButton) then
        if isFreeCam then
          local currentPos = Vector3(vars.playerPosX, vars.playerPosY, vars.playerPosZ)
          movePosition=currentPos+cameraOffsetDefault
        else
          movePosition=cameraOffsetDefault
        end
      elseif InfButton.ButtonDown(InfMain.speedModeButton) then
        moveScale:Reset()
      elseif InfButton.OnButtonDown(InfMain.distanceModeButton) then
        if isFreeCam then--tex KLUDGE
          cameraDistance:Set(0)
        else
          cameraDistance:Reset()
        end
      end
    end
    --
    if Ivars.disableCamText:Is(0) then
      if InfButton.OnButtonDown(InfMain.zoomModeButton) or InfButton.OnButtonUp(InfMain.zoomModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"focal_length_mode".." "..focalLength:Get())
      end
      if InfButton.OnButtonDown(InfMain.apertureModeButton) or InfButton.OnButtonUp(InfMain.apertureModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"aperture_mode".." "..aperture:Get())
      end
      if InfButton.OnButtonDown(InfMain.focusDistanceModeButton) or InfButton.OnButtonUp(InfMain.focusDistanceModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"focus_distance_mode".." "..focusDistance:Get())
      end
      --CULL
      --      if InfButton.OnButtonDown(InfMain.verticalModeButton) then
      --        InfMenu.Print(currentCamName.." "..InfMenu.LangString"vertical_mode")
      --      end
      if InfButton.OnButtonDown(InfMain.speedModeButton) or InfButton.OnButtonUp(InfMain.speedModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"speed_mode".." "..moveScale:Get())
      end
      if InfButton.OnButtonDown(InfMain.distanceModeButton) or InfButton.OnButtonUp(InfMain.distanceModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"distance_mode".." "..cameraDistance:Get())
      end
      if InfButton.OnButtonDown(InfMain.resetModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"reset_mode")
      end
    end
    --inmenu-v-
  else
    if didMove then
      local vMoveDir=Vector3(moveX,moveY,moveZ)
      local rotYQuat=Quat.RotationY(TppMath.DegreeToRadian(vars.playerCameraRotation[1]))
      local camMoveDir=rotYQuat:Rotate(vMoveDir)
      movePosition=movePosition+camMoveDir
      --InfCore.DebugPrint("movePosition "..movePosition:GetX()..","..movePosition:GetY()..","..movePosition:GetZ())
    end
  end

  WritePosition(currentCamName,movePosition)
  --end,currentChecks)--DEBUG
end

return this
