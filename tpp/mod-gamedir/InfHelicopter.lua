--InfHelicopter.lua
local this={}

--LOCALOPT
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local IsTimerActive=GkEventTimerManager.IsTimerActive
local InfButton=InfButton

--updateState
this.active=1--Ivars.heliUpdate
this.execCheckTable={inGame=true,inHeliSpace=false}
this.execState={
  nextUpdate=0,
}

function this.Update(currentChecks,currentTime,execChecks,execState)
  local Ivars=Ivars

  local heliId=GetGameObjectId("TppHeli2","SupportHeli")
  if heliId==nil or heliId==NULL_ID then
    return
  end

  --if Ivars.enableGetOutHeli:Is(1) then--TEST not that useful
  -- SendCommand(heliId, { id="SetGettingOutEnabled", enabled=true })
  --end

  if not currentChecks.inMenu and currentChecks.inSupportHeli then
    if InfButton.OnButtonDown(InfButton.STANCE) then
      --InfLog.DebugPrint"STANCE"--DEBUG
      --if not currentChecks.initialAction then--tex heli ride in TODO: RETRY: A reliable mission start parameter
      if IsTimerActive"Timer_MissionStartHeliDoorOpen" then
        --InfLog.DebugPrint"IsTimerActive"--DEBUG
        GameObject.SendCommand(heliId,{id="RequestSnedDoorOpen"})
      else
        if Ivars.disablePullOutHeli:Is(1) then
          --CULL SendCommand(heliId,{id="PullOut",forced=true})--tex even with forced wont go with player in heli
          Ivars.disablePullOutHeli:Set(0,true,true)--tex overrules all, but we can tell it to not save so that's ok
          InfMenu.PrintLangId"heli_pulling_out"
        else
          Ivars.disablePullOutHeli:Set(1,true,true)
          InfMenu.PrintLangId"heli_hold_pulling_out"
        end
      end
    end--button down
  end--not menu, insupportheli
end

return this
