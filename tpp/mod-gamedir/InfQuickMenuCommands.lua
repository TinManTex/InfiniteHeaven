-- InfQuickMenuCommands.lua
local this={}

this.ToggleCamMode=function()
  InfMenu.PrintLangId"freecam_non_adjust"
  if Ivars.cameraMode:Is(0) then
    Ivars.cameraMode:Set(1)
  else
    Ivars.cameraMode:Set(0)
  end
end

this.ToggleFreeCam=function()
  --InfLog.DebugPrint"quickmenu RELOAD"--DEBUG
  if Ivars.adjustCameraUpdate:Is(0) then
    Ivars.adjustCameraUpdate:Set(1)
  else
    Ivars.adjustCameraUpdate:Set(0)
  end
end

return this
