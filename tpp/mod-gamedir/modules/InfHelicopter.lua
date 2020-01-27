-- InfHelicopter.lua
-- tex support heli stuff
local this={}

--LOCALOPT
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local SendCommand=GameObject.SendCommand
local IsTimerActive=GkEventTimerManager.IsTimerActive
local InfButton=InfButton

--updateState
this.active=1--Ivars.heliUpdate
this.execCheckTable={inGame=true,inHeliSpace=false}
this.execState={
  nextUpdate=0,
}

function this.Init()
  this.messageExecTable=nil

  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end
  
  --update heli vars
  --texcalled from TppMain.Onitiialize, so should only be 'enable/change from default', VERIFY it's in the right spot to override each setting
  local heliId=GetGameObjectId("TppHeli2","SupportHeli")
  if heliId==nil or heliId==NULL_ID then
    return
  end

  if Ivars.disableHeliAttack:Is(1) then--tex disable heli be fightan
    SendCommand(heliId,{id="SetCombatEnabled",enabled=false})
  end
  if Ivars.setInvincibleHeli:Is(1) then
    SendCommand(heliId,{id="SetInvincible",enabled=true})
  end
  if not Ivars.setTakeOffWaitTime:IsDefault() then
    SendCommand(heliId,{id="SetTakeOffWaitTime",time=Ivars.setTakeOffWaitTime:Get()})
  end
  if Ivars.disablePullOutHeli:Is(1) then
    --if not TppLocation.IsMotherBase() and not TppLocation.IsMBQF() then--tex aparently disablepullout overrides the mother base taxi service TODO: not sure if I want to turn this off to save user confusion, or keep consistant behaviour
    SendCommand(heliId,{id="DisablePullOut"})
    --end
  end
  if not Ivars.setLandingZoneWaitHeightTop:IsDefault() then
    SendCommand(heliId,{id="SetLandingZoneWaitHeightTop",height=Ivars.setLandingZoneWaitHeightTop:Get()})
  end
  if Ivars.disableDescentToLandingZone:Is(1) then
    SendCommand(heliId,{id="DisableDescentToLandingZone"})
  end
  if Ivars.setSearchLightForcedHeli:Is"ON" then
    SendCommand(heliId,{id="SetSearchLightForcedType",type="On"})
  elseif Ivars.setSearchLightForcedHeli:Is"OFF" then
    SendCommand(heliId,{id="SetSearchLightForcedType",type="Off"})
  end

  --if TppMission.IsMbFreeMissions(vars.missionCode) then--TEST no aparent result on initial testing, in-engine pullout check must be overriding
  --  TppUiStatusManager.UnsetStatus( "MbMap", "BLOCK_TAXI_CHANGE_LOCATION" )
  --end  
end

function this.Update(currentChecks,currentTime,execChecks,execState)
  local Ivars=Ivars
  
  if TppUiCommand.IsMbDvcTerminalOpened()then
    return
  end

  local heliId=GetGameObjectId("TppHeli2","SupportHeli")
  if heliId==nil or heliId==NULL_ID then
    return
  end

  --if Ivars.enableGetOutHeli:Is(1) then--TEST not that useful
  -- SendCommand(heliId, { id="SetGettingOutEnabled", enabled=true })
  --end

  --tex TODO some kind of periodic print if player in heli and pullout disabled (in any way, by temporary button press or actual ivar set)

  if not currentChecks.inMenu and currentChecks.inSupportHeli then
    if InfButton.OnButtonDown(InfButton.STANCE) then
      --InfCore.DebugPrint"STANCE"--DEBUG
      --if not currentChecks.initialAction then--tex heli ride in TODO: RETRY: A reliable mission start parameter
      if IsTimerActive"Timer_MissionStartHeliDoorOpen" then
        --InfCore.DebugPrint"IsTimerActive"--DEBUG
        GameObject.SendCommand(heliId,{id="RequestSnedDoorOpen"})
      else
        if Ivars.disablePullOutHeli:Is(1) then
          --CULL SendCommand(heliId,{id="PullOut",forced=true})--tex even with forced wont go with player in heli
          Ivars.disablePullOutHeli:Set(0,true)--tex overrules all, but we can tell it to not save so that's ok
          InfMenu.PrintLangId"heli_pulling_out"
        else
          Ivars.disablePullOutHeli:Set(1,true)
          InfMenu.PrintLangId"heli_hold_pulling_out"
        end
      end
    end--button down
  end--not menu, insupportheli
end

function this.HeliOrderRecieved()
  if InfMain.execChecks.inGame and not InfMain.execChecks.inHeliSpace then
    InfMenu.PrintLangId"order_recieved"
  end
end

return this
