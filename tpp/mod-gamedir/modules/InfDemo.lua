local this={}

local InfButton=InfButton
local DemoDaemon=DemoDaemon
local GetPlayingDemoId=DemoDaemon.GetPlayingDemoId
local IsDemoPaused=DemoDaemon.IsDemoPaused
local IsDemoPlaying=DemoDaemon.IsDemoPlaying

this.pauseDemoButton=InfButton.EVADE
this.resetDemoButton=InfButton.RELOAD

function this.Update(currentChecks,currentTime,execChecks,execState)
  --tex don't know if its worth allowing user to override this for the few genuine in game demos
  if currentChecks.inGame then
    return
    end

  if not IsDemoPaused() and not IsDemoPlaying() then
    return
  end

  local demoId=GetPlayingDemoId()
  if demoId==nil then
    return
  end

  if InfButton.OnButtonDown(this.pauseDemoButton) then
    DemoDaemon.PauseAll()
  end

  if InfButton.OnButtonDown(this.resetDemoButton) then
    if IsDemoPlaying() and InfMenu.quickMenuOn==false then
      InfCore.Log("InfDemo: Restarting "..InfInspect.Inspect(demoId))
      DemoDaemon.RestartAll()
    end

  end
end

return this
