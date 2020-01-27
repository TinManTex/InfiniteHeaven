-- DOBUILD: 1
-- InfQuickMenuDefs.lua
local this={}
this.inHeliSpace={
  [InfButton.SUBJECT]=function(execCheck)--RB/F(H-mouse4)
    --InfLog.DebugPrint"quickmenu SUBJECT"--DEBUG
  end,
  [InfButton.EVADE]=function(execCheck)--X/SPACE(space)
    --InfLog.DebugPrint"quickmenu EVADE"--DEBUG
    InfMenu.ToggleMenu(execCheck)
  end,
  [InfButton.ACTION]=function(execCheck)--B/R(T)
    --InfLog.DebugPrint"quickmenu ACTION"--DEBUG
  end,--Y/E(G)
  [InfButton.RELOAD]=function(execCheck)
   -- InfLog.DebugPrint"quickmenu RELOAD"--DEBUG
  end,
  [InfButton.STANCE]=function(execCheck)--A/C(Z)
    --InfLog.DebugPrint"quickmenu STANCE"--DEBUG
  end,
}
this.inMission={
  [InfButton.SUBJECT]=function(execCheck)--RB/F(H-mouse4)
    --InfLog.DebugPrint"quickmenu SUBJECT"--DEBUG
  end,
  [InfButton.HOLD]=function(execCheck)--LT/RMouse
    --InfLog.DebugPrint"quickmenu HOLD"  --DEBUG
    InfMenuCommands.warpToUserMarker.OnChange()
  end,
  [InfButton.FIRE]=function(execCheck)--RT/LMouse
  --InfLog.DebugPrint"quickmenu FIRE"
    InfMenu.GoMenu(InfMenu.topMenu)
    InfMenu.currentIndex=this.requestHeliMenuIndex
    if InfMenu.menuOn then
      InfMenu.menuOn=false
    end
    InfMenu.ToggleMenu(execCheck)
  end,
  [InfButton.DASH]=function(execCheck)--L3 Lstick click/Shift
    --InfLog.DebugPrint"quickmenu DASH"--DEBUG
    InfMenu.PrintLangId"freecam_non_adjust"
    if Ivars.cameraMode:Is(0) then
      Ivars.cameraMode:Set(1)
    else
      Ivars.cameraMode:Set(0)
    end
  end,
  --  [InfButton.EVADE]=function(execCheck)--X/SPACE(space)-- used with keyboard to select when call menu is up
  --    InfLog.DebugPrint"quickmenu EVADE"--DEBUG
  --  end,
  [InfButton.ACTION]=function(execCheck)--B/R(T)
    --InfLog.DebugPrint"quickmenu ACTION"--DEBUG
    InfMenuCommands.highSpeedCameraToggle.OnChange()
  end,--Y/E(G)
  [InfButton.RELOAD]=function(execCheck)
    --InfLog.DebugPrint"quickmenu RELOAD"--DEBUG
    if Ivars.adjustCameraUpdate:Is(0) then
      Ivars.adjustCameraUpdate:Set(1)
    else
      Ivars.adjustCameraUpdate:Set(0)
    end
  end,
  [InfButton.STANCE]=function(execCheck)--A/C(Z)
    --InfLog.DebugPrint"quickmenu STANCE"--DEBUG
    InfMenuCommands.QuietMoveToLastMarker()
  end,
}

--tex KLUDGE, dont like the implementation of this
for index,option in ipairs(InfMenuDefs.inMissionMenu.options)do
  if option==InfMenuCommands.requestHeliLzToLastMarker then
    this.requestHeliMenuIndex=index
  end
end

return this
