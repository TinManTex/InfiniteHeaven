-- DOBUILD: 1
-- InfQuickMenuDefs.lua
local this={}
this.inHeliSpace={
  [InfButton.SUBJECT]=function(execCheck)--RB/F(H-mouse4)
    --InfMenu.DebugPrint"quickmenu SUBJECT"--DEBUG
  end,
  [InfButton.EVADE]=function(execCheck)--X/SPACE(space)
    --InfMenu.DebugPrint"quickmenu EVADE"--DEBUG
    InfMenu.ToggleMenu(execCheck)
  end,
  [InfButton.ACTION]=function(execCheck)--B/R(T)
    --InfMenu.DebugPrint"quickmenu ACTION"--DEBUG
  end,--Y/E(G)
  [InfButton.RELOAD]=function(execCheck)
   -- InfMenu.DebugPrint"quickmenu RELOAD"--DEBUG
  end,
  [InfButton.STANCE]=function(execCheck)--A/C(Z)
    --InfMenu.DebugPrint"quickmenu STANCE"--DEBUG
  end,
}
this.inMission={
  [InfButton.SUBJECT]=function(execCheck)--RB/F(H-mouse4)
    --InfMenu.DebugPrint"quickmenu SUBJECT"--DEBUG
    InfMenu.ToggleMenu(execCheck)
  end,
  [InfButton.HOLD]=function(execCheck)--LT/RMouse
    --InfMenu.DebugPrint"quickmenu HOLD"  --DEBUG
    InfMenuCommands.warpToUserMarker.OnChange()
  end,
  [InfButton.FIRE]=function(execCheck)--RT/LMouse
  --InfMenu.DebugPrint"quickmenu FIRE"
    InfMenu.GoMenu(InfMenu.topMenu)
    InfMenu.currentIndex=this.requestHeliMenuIndex
    if InfMenu.menuOn then
      InfMenu.menuOn=false
    end
    InfMenu.ToggleMenu(execCheck)
  end,
  [InfButton.DASH]=function(execCheck)--L3 Lstick click/Shift
    --InfMenu.DebugPrint"quickmenu DASH"--DEBUG
    InfMenu.PrintLangId"freecam_non_adjust"
    if Ivars.cameraMode:Is(0) then
      Ivars.cameraMode:Set(1)
    else
      Ivars.cameraMode:Set(0)
    end
  end,
  --  [InfButton.EVADE]=function(execCheck)--X/SPACE(space)-- used with keyboard to select when call menu is up
  --    InfMenu.DebugPrint"quickmenu EVADE"--DEBUG
  --  end,
  [InfButton.ACTION]=function(execCheck)--B/R(T)
    --InfMenu.DebugPrint"quickmenu ACTION"--DEBUG
    InfMenuCommands.highSpeedCameraToggle.OnChange()
  end,--Y/E(G)
  [InfButton.RELOAD]=function(execCheck)
    --InfMenu.DebugPrint"quickmenu RELOAD"--DEBUG
    if Ivars.adjustCameraUpdate:Is(0) then
      Ivars.adjustCameraUpdate:Set(1)
    else
      Ivars.adjustCameraUpdate:Set(0)
    end
  end,
  [InfButton.STANCE]=function(execCheck)--A/C(Z)
    --InfMenu.DebugPrint"quickmenu STANCE"--DEBUG
  end,
}

for index,option in ipairs(InfMenuDefs.inMissionMenu.options)do
  if option==InfMenuCommands.requestHeliLzToLastMarker then
    this.requestHeliMenuIndex=index
  end
end

return this
