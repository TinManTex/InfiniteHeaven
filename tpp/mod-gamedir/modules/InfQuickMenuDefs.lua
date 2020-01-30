-- InfQuickMenuDefs.lua
-- When enabled via the 'Enable Quick menu'/enableQuickMenu option or forceEnable below, 
-- activate by holding <Switch Zoom> (V key or RStick click) + the key/button for the defined command.

--If you want to edit this it may be better to copy off to InfQuickMenuDefs_User.lua 
--so it doesn't get overwritten on new IH versions, 
--but you'll have to check any new InfQuickMenuDefs.lua to see if I've done any changes to the system.

--Quick (incomplete) Buttons/Keys reference.
--Some buttons are combined, and in different ways on keyboard vs gamepad

--InfButton name - <description> - (default key / button)
--InfButton.ACTION - (E key or Y button)
--InfButton.RELOAD - (R key or B button)
--InfButton.EVADE - <Quick dive> - (space key or X button)
--InfButton.HOLD - <Ready weapon> - (Right mouse or Left Trigger)
--InfButton.FIRE - (Left mouse or Right Trigger)
--InfButton.CALL - <Call radio/interrogate> - (Q or Left bumper)
--InfButton.SUBJECT - <Binoculars/scope> - (F or Right bumper)

--InfButton.UP - (Arrow/Dpad Up)
--InfButton.DOWN - (Arrow/Dpad Down)
--InfButton.RIGHT - (Arrow/Dpad Right)
--InfButton.LEFT - (Arrow/Dpad Left)

--InfButton.LIGHT_SWITCH - (X key,Dpad Right)

local this={}

--this.forceEnable=true--tex overrides the Enable quick menu option in the IH system menu

--tex button to hold to enable the quick menu command buttons
--make sure this doesn't conflict with any of the menu command buttons below
this.quickMenuHoldButton=InfButton.CALL

this.inSafeSpace={
  [InfButton.RELOAD]={Command='InfCamera.ToggleFreeCam'},
}
this.inMission={
  --tex just comment out to disable
  --[InfButton.SUBJECT]={Command='InfMenuCommands.Doop'},
  [InfButton.LIGHT_SWITCH]={Command='InfMenuCommandsTpp.DropCurrentEquip'},
  [InfButton.HOLD]={Command='InfUserMarker.WarpToLastUserMarker'},
  [InfButton.ACTION]={immediate=true,Command='InfTimeScale.HighSpeedCameraToggle'},--tex TSM, immediate because: It's on a key that is less likely to be accidentally triggered. Need the responsiveness. TSM actually affects timing of deactivation lol (same issue with phantom cigar and menu activation) 
  [InfButton.RELOAD]={Command='InfCamera.ToggleFreeCam'},
  [InfButton.STANCE]={Command='InfMenuCommandsTpp.QuietMoveToLastMarker'},
}
--tex cutscenes
--In addition to this IH has commands for pause and reset without using the quickmenu
--see mod\modules\InfDemo.lua to see those binds
this.inDemo={ 
  [InfButton.RELOAD]={Command='InfCamera.ToggleFreeCam'},
  [InfButton.DASH]={Command='InfCamera.ToggleCamMode'},
  [InfButton.ACTION]={immediate=true,Command='InfTimeScale.HighSpeedCameraToggle'},
}

return this
