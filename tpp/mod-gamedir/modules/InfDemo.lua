local this={}

local InfButton=InfButton
local DemoDaemon=DemoDaemon
local GetPlayingDemoId=DemoDaemon.GetPlayingDemoId

this.pauseDemoButton=InfButton.EVADE
this.resetDemoButton=InfButton.RELOAD

function this.Update(currentChecks,currentTime,execChecks,execState)
  local demoId=GetPlayingDemoId()
  if demoId==nil then
    return
  end

  if InfButton.OnButtonDown(this.pauseDemoButton) then
    DemoDaemon.PauseAll()
  end

  if InfButton.OnButtonDown(this.resetDemoButton) then
    if DemoDaemon.IsDemoPlaying() then
      InfCore.Log("InfDemo: Restarting "..demoId)
      DemoDaemon.RestartAll()
    end
  end
end

return this
