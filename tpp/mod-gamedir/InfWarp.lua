-- InfWarp.lua
local this={}

local InfButton=InfButton
local InfMain=InfMain

--updateState
this.active=Ivars.warpPlayerUpdate
this.execCheckTable={inGame=true,inHeliSpace=false}
this.execState={
  nextUpdate=0,
}

--init
function this.OnActivate()
  this.ActivateControlSet()
end

function this.ActivateControlSet()
  InfButton.buttonStates[InfMain.moveRightButton].decrement=0.1
  InfButton.buttonStates[InfMain.moveLeftButton].decrement=0.1
  InfButton.buttonStates[InfMain.moveForwardButton].decrement=0.1
  InfButton.buttonStates[InfMain.moveBackButton].decrement=0.1
  InfButton.buttonStates[InfMain.moveUpButton].decrement=0.1
  InfButton.buttonStates[InfMain.moveDownButton].decrement=0.1

  local repeatRate=0.06
  local repeatRateUp=0.04
  InfButton.buttonStates[InfMain.moveRightButton].repeatRate=repeatRate
  InfButton.buttonStates[InfMain.moveLeftButton].repeatRate=repeatRate
  InfButton.buttonStates[InfMain.moveForwardButton].repeatRate=repeatRate
  InfButton.buttonStates[InfMain.moveBackButton].repeatRate=repeatRate
  InfButton.buttonStates[InfMain.moveUpButton].repeatRate=repeatRateUp
  InfButton.buttonStates[InfMain.moveDownButton].repeatRate=repeatRate

  --WIP this.DisableAction(Ivars.warpPlayerUpdate.disableActions)
end

function this.OnDeactivate()
--this.EnableAction(Ivars.warpPlayerUpdate.disableActions)
end

function this.Update(currentChecks,currentTime,execChecks,execState)
  if currentChecks.inMenu then
    return
  end

  if not currentChecks.inGame or currentChecks.inHeliSpace then
    if Ivars.warpPlayerUpdate:Is(1) then
      Ivars.warpPlayerUpdate:Set(0)
    end
    return
  end

  if Ivars.warpPlayerUpdate:Is(0) then
    return
  end

  this.DoControlSet(currentChecks)
end

function this.DoControlSet(currentChecks)
  local warpAmount=1
  local warpUpAmount=1

  local moveDir={}
  moveDir[1]=0
  moveDir[2]=0
  moveDir[3]=0

  local didMove=false

  if InfButton.OnButtonDown(InfMain.moveForwardButton)
    or InfButton.OnButtonRepeat(InfMain.moveForwardButton) then
    moveDir[3]=warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(InfMain.moveBackButton)
    or InfButton.OnButtonRepeat(InfMain.moveBackButton) then
    moveDir[3]=-warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(InfMain.moveRightButton)
    or InfButton.OnButtonRepeat(InfMain.moveRightButton) then
    moveDir[1]=-warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(InfMain.moveLeftButton)
    or InfButton.OnButtonRepeat(InfMain.moveLeftButton) then
    moveDir[1]=warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(InfMain.moveUpButton)
    or InfButton.OnButtonRepeat(InfMain.moveUpButton) then
    moveDir[2]=warpUpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(InfMain.moveDownButton)
    or InfButton.OnButtonRepeat(InfMain.moveDownButton) then
    moveDir[2]=-warpAmount
    didMove=true
  end

  if didMove then
    local currentPos = Vector3(vars.playerPosX, vars.playerPosY, vars.playerPosZ)
    local vMoveDir=Vector3(moveDir[1],moveDir[2],moveDir[3])
    local rotYQuat=Quat.RotationY(TppMath.DegreeToRadian(vars.playerRotY))
    local playerMoveDir=rotYQuat:Rotate(vMoveDir)
    local warpPos=currentPos+playerMoveDir
    TppPlayer.Warp{pos={warpPos:GetX(),warpPos:GetY(),warpPos:GetZ()},rotY=vars.playerCameraRotation[1]}
  end
end

return this
