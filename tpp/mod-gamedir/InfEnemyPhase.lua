--InfEnemyPhase.lua
--Phase/Alert updates DOC: Phases-Alerts.txt
--TODO alert radius
local this={}

--LOCALOPT
local InfMain=InfMain
local TppLocation=TppLocation
local PHASE_SNEAK=TppGameObject.PHASE_SNEAK
local PHASE_CAUTION=TppGameObject.PHASE_CAUTION
local PHASE_EVASION=TppGameObject.PHASE_EVASION
local PHASE_ALERT=TppGameObject.PHASE_ALERT
local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID
local SendCommand=GameObject.SendCommand
local random=math.random

--updateState
this.active=Ivars.phaseUpdate
local rate=Ivars.phaseUpdateRate
local range=Ivars.phaseUpdateRange
this.execCheckTable={inGame=true,inHeliSpace=false}
this.execState={
  nextUpdate=0,
  lastPhase=0,
  alertBump=false,
}
--
function this.Init(missionTable)
end

function this.Update(currentChecks,currentTime,execChecks,execState)
  local Ivars=Ivars
  local mvars=mvars  
  
  if mvars.ene_soldierDefine==nil then
    --InfLog.DebugPrint"WARNING: InfEnemyPhase.Update - ene_soldierDefine==nil"
    return
  end

  if (TppLocation.IsMotherBase() or TppLocation.IsMBQF()) and Ivars.mbHostileSoldiers:Is(0) then
    return
  end

  local currentPhase=vars.playerPhase
  local minPhase=Ivars.minPhase:Get()
  local maxPhase=Ivars.maxPhase:Get()
  local keepPhase=Ivars.keepPhase:Is(1)

  --tex OFF TODO: MB cppositions
  --  local playerPosition={vars.playerPosX,vars.playerPosY,vars.playerPosZ}
  --  local closestCp,cpDistance,cpPosition=InfMain.GetClosestCp(playerPosition)
  --  if closestCp==nil then
  --    return
  --  end

  for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
    if #soldierList>0 then
      local cpId=GetGameObjectId(cpName)
      local cpPhase=SendCommand(cpId,{id="GetPhase",cpName=cpName})
--      if cpPhase==PHASE_ALERT then
--        this.inf_cpLastAlert[cpName]=currentTime
--      end

      if currentPhase<minPhase then
        this.ChangePhase(cpName,minPhase)--gvars.minPhase)
      end
      if currentPhase>maxPhase then
        this.ChangePhase(cpName,maxPhase)
      end

      if keepPhase then
        this.SetKeepAlert(cpName,true)
      else
      --InfMain.SetKeepAlert(cpName,false)--tex this would trash any vanilla setting, but updating this to off would only be important if ivar was updated at mission time
      end

      --tex keep forcing ALERT so that last know pos updates, otherwise it would take till the alert>evasion cooldown
      --doesnt really work well, > alert is set last know pos, take cover and suppress last know pos
      --evasion is - is no last pos, downgrade to caution, else group advance on last know pos
      --ideally would be able to set last know pos independant of phase
      --if minPhase==PHASE_ALERT then
      --debugMessage="phase<min setting to "..PhaseName(gvars.minPhase)
      --if currentPhase==PHASE_ALERT and execState.lastPhase==PHASE_ALERT then
      --this.ChangePhase(cpName,minPhase-1)--gvars.minPhase)
      --end
      --end
      if minPhase==PHASE_EVASION then
        if execState.alertBump then
          execState.alertBump=false
          this.ChangePhase(cpName,PHASE_EVASION)
        end
      end
      if currentPhase<minPhase then
        if minPhase==PHASE_EVASION then
          this.ChangePhase(cpName,PHASE_ALERT)
          execState.alertBump=true
        end
      end
    end
  end

  if Ivars.printPhaseChanges:Is(1) and execState.lastPhase~=currentPhase then
    InfMenu.Print("Phase change from:"..Ivars.phaseSettings[execState.lastPhase+1].." to:"..Ivars.phaseSettings[currentPhase+1])
  end

  execState.lastPhase=currentPhase
  
  execState.nextUpdate=currentTime+this.GetUpdateRate()
end

function this.GetUpdateRate()
  local updateRate=rate:Get()
  local updateRange=range:Get()
  if updateRange then
    local updateMin=updateRate-updateRange*0.5
    local updateMax=updateRate+updateRange*0.5
    if updateMin<0 then
      updateMin=0
    end

    updateRate=random(updateMin,updateMax)
  end

  return updateRate
end
function this.ChangePhase(cpName,phase)
  local gameId=GetGameObjectId("TppCommandPost2",cpName)
  if gameId==NULL_ID then
    InfLog.DebugPrint("Could not find cp "..cpName)
    return
  end
  local command={id="SetPhase",phase=phase}
  SendCommand(gameId,command)
end

function this.SetKeepAlert(cpName,enable)
  local gameId=GetGameObjectId("TppCommandPost2",cpName)
  if gameId==NULL_ID then
    InfLog.DebugPrint("Could not find cp "..cpName)
    return
  end
  local command={id="SetKeepAlert",enable=enable}
  GameObject.SendCommand(gameId,command)
end

return this
