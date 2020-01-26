-- DOBUILD: 1
--InfEnemyPhase.lua
local this={}

--Phase/Alert updates DOC: Phases-Alerts.txt
--TODO RETRY, see if you can get when player comes into cp range better, playerPhase doesnt change till then
--RESEARCH music also starts up
--then can shift to game msg="ChangePhase" subscription
--state
local Ivars=Ivars
local InfMain=InfMain
local PHASE_ALERT=TppGameObject.PHASE_ALERT
local PHASE_EVASION=TppGameObject.PHASE_EVASION
local ChangePhase=InfMain.ChangePhase
local SetKeepAlert=InfMain.SetKeepAlert

function this.Update(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if (TppLocation.IsMotherBase() or TppLocation.IsMBQF()) and Ivars.mbWarGamesProfile:Is(0) then
    return
  end

  local currentPhase=vars.playerPhase
  local minPhase=Ivars.minPhase:Get()
  local maxPhase=Ivars.maxPhase:Get()
  local keepPhase=Ivars.keepPhase:Is(1)

  for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
    if currentPhase<minPhase then
      ChangePhase(cpName,minPhase)--gvars.minPhase)
    end
    if currentPhase>maxPhase then
      ChangePhase(cpName,maxPhase)
    end

    if keepPhase then
      SetKeepAlert(cpName,true)
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
        InfMain.ChangePhase(cpName,PHASE_EVASION)
      end
    end
    if currentPhase<minPhase then
      if minPhase==PHASE_EVASION then
        InfMain.ChangePhase(cpName,PHASE_ALERT)
        execState.alertBump=true
      end
    end
  end

  execState.lastPhase=currentPhase
end

return this