-- DOBUILD: 1
-- ORIGINALQAR: data1
-- FILEPATH: \Assets\tpp\script\lib\TppMain.lua
local e={}
--
local this=e--tex DEMINIFYDEF:
--tex shit I want to keep at top for easy manual changing
this.DEBUGMODE=false
this.modVersion = "r39"
this.modName = "Infinite Heaven"
--tex LOCALOPT:
local IsFunc=Tpp.IsTypeFunc
local Enum=TppDefine.Enum
--tex strings, till we figure out how to access custom values in .lang files this will have to do.
--tex SYNC: with uses of TppUiCommand.AnnounceLogView
this.modStrings={
  menuOff="Menu Off",
  settingDefaults="Setting mod options to defaults...",
  settingDisallowed=" is currently disallowed"
}
--tex the bulk of my shit REFACTOR: until we can load our own lua files this is a good a spot as any
--tex SYS: buttonpress. TODO: work out the duplicate bitmasks/those that don't work, and those that are missing
this.buttonMasks={--tex: SYNC: buttonStates
  PlayerPad.DECIDE,
  PlayerPad.STANCE,
  PlayerPad.ACTION,
  PlayerPad.RELOAD,
  PlayerPad.STOCK,
  PlayerPad.MB_DEVICE,
  PlayerPad.CALL,
  PlayerPad.UP,
  PlayerPad.DOWN,
  PlayerPad.LEFT,
  PlayerPad.RIGHT,
  PlayerPad.SIDE_ROLL,
  PlayerPad.ZOOM_CHANGE,
  PlayerPad.LIGHT_SWITCH,
  PlayerPad.EVADE,
  --PlayerPad.VEHICLE_FIRE,--]]--tex button/bitmask always set for some reason
  PlayerPad.VEHICLE_CALL,
  PlayerPad.VEHICLE_DASH,
  --PlayerPad.BUTTON_PLACE_MARKER,--]]--tex button/bitmask always set for some reason
  --PlayerPad.PLACE_MARKER,--]]--tex button/bitmask always set for some reason
  PlayerPad.INTERROGATE,
  PlayerPad.RIDE_ON,
  PlayerPad.RIDE_OFF,
  PlayerPad.VEHICLE_CHANGE_SIGHT,
  PlayerPad.VEHICLE_LIGHT_SWITCH,
  PlayerPad.VEHICLE_TOGGLE_WEAPON,
  PlayerPad.JUMP,
  PlayerPad.MOVE_ACTION,
  PlayerPad.PRIMARY_WEAPON,
  PlayerPad.SECONDARY_WEAPON,
  --[[PlayerPad.STICK_L,
  PlayerPad.STICK_R,
  PlayerPad.TRIGGER_L,
  PlayerPad.TRIGGER_R,
  PlayerPad.TRIGGER_ACCEL,
  PlayerPad.TRIGGER_BREAK,
  --PlayerPad.ALL--]]
}
this.buttonStates={--tex: for defaults, not specfic button setups. SYNC: buttonmasks
  [PlayerPad.DECIDE]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.STANCE]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.ACTION]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.RELOAD]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.STOCK]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.MB_DEVICE]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.CALL]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.UP]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.DOWN]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.LEFT]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.RIGHT]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.SIDE_ROLL]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.ZOOM_CHANGE]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.LIGHT_SWITCH]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.EVADE]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  --[[[PlayerPad.VEHICLE_FIRE]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},--]]--tex button/bitmask always set for some reason
  [PlayerPad.VEHICLE_CALL]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.VEHICLE_DASH]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  --[[[PlayerPad.BUTTON_PLACE_MARKER]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},--]]--tex button/bitmask always set for some reason
  --[[[PlayerPad.PLACE_MARKER]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},--]]--tex button/bitmask always set for some reason
  [PlayerPad.INTERROGATE]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.RIDE_ON]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.RIDE_OFF]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.VEHICLE_CHANGE_SIGHT]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.VEHICLE_LIGHT_SWITCH]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.VEHICLE_TOGGLE_WEAPON]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.JUMP]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.MOVE_ACTION]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.PRIMARY_WEAPON]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
  [PlayerPad.SECONDARY_WEAPON]={isPressed=false,holdTime=0.9,startTime=0,currentRate=0.9,minRate=0.3,decrement=0},
}
function this.UpdatePressedButtons()
  for i, button in pairs(this.buttonMasks) do
    this.buttonStates[button].isPressed = this.ButtonDown(button)
  end
end
function this.UpdateHeldButtons()
  for i, button in pairs(this.buttonMasks) do
    if this.buttonStates[button].holdTime~=0 then
      if this.OnButtonDown(button)then
        this.buttonStates[button].startTime=Time.GetRawElapsedTimeSinceStartUp()
      end
      if not (bit.band(PlayerVars.scannedButtonsDirect,button)==button) then--this.ButtonDown(button)then
        this.buttonStates[button].startTime=0
      end
    end
  end
end
function this.ButtonDown(button)
  --[[if (bit.band(PlayerVars.scannedButtonsDirect,button)==button) then
    TppUiCommand.AnnounceLogView("ButtonPressed:" .. bit.tohex(button))--tex DEBUG: CULL:
  end--]]
  return bit.band(PlayerVars.scannedButtonsDirect,button)==button
end
--tex GOTCHA: OnButton functions will have a gameframe of latency, sorry to dissapoint all the pro gamers
function this.OnButtonDown(button)
  return not this.buttonStates[button].isPressed and (bit.band(PlayerVars.scannedButtonsDirect,button)==button)
end
function this.OnButtonUp(button)
  return this.buttonStates[button].isPressed and not (bit.band(PlayerVars.scannedButtonsDirect,button)==button)
end
function this.OnButtonHoldTime(button)
  local buttonState = this.buttonStates[button]
  if buttonState.holdTime~=0 and buttonState.startTime~=0 then
    if Time.GetRawElapsedTimeSinceStartUp() - buttonState.startTime > buttonState.holdTime then
      buttonState.startTime=0
      return true
    end
  end
  return false
end
function this.OnButtonRepeat(button)
  local buttonState = this.buttonStates[button]
  --tex REF: {isPressed=false,holdTime=0,startTime=0,currentRate=0,minRate=0,decrement=0},
  if buttonState.decrement ~= 0 then
    if buttonState.isPressed and not (bit.band(PlayerVars.scannedButtonsDirect,button)==button) then--tex OnButtonUp reset
      buttonState.currentRate=buttonState.holdTime
      return false
    end
    local currentRate=buttonState.currentRate
    --if currentRate~=0 and 
    if buttonState.startTime~=0 then
      if Time.GetRawElapsedTimeSinceStartUp() - buttonState.startTime > currentRate then
        buttonState.startTime=Time.GetRawElapsedTimeSinceStartUp()
        if currentRate > buttonState.minRate then
          currentRate=currentRate-buttonState.decrement
        end
        buttonState.currentRate=currentRate
        return true
      end
    end
  end
  return false  
end
--tex end SYS buttonstuff
--tex SYS: mod menu
--tex mod settings setup
this.subsistenceLoadouts={--tex pure,secondary.
  TppDefine.CYPR_PLAYER_INITIAL_WEAPON_TABLE,
  TppDefine.SUBSISTENCE_SECONDARY_INITIAL_WEAPON_TABLE
}
this.numQuests=157--tex added SYNC: number of quests REFACTOR: better place, but hangs modsettings if in tppdefine or tppquest
this.SUBSISTENCE_BOUND=2--tex: SPECIAL: RETRY:
this.SETTING_UNLOCK_SIDEOPS_ENUM=Enum{"OFF","REPOP","OPEN","MAX"}--tex SYNC: unlocksideops setting names TODO: overhaul, rectify with sliders
this.switchSlider={max=1,min=0,increment=1}
this.healthMultSlider={max=4,min=0,increment=0.2}
this.switchSettingNames={"Off","On"}
function this.SettingInfoHealth()
  return vars.playerLifeMax
end
this.modSettings={
  {
    name="Subsistence Mode",
    gvarName="isManualSubsistence",
    default=0,
    slider={max=2,min=0,increment=1},
    settingNames={"Off","Pure (OSP -Items -Hand -Suit -Support -Fulton -Vehicle -Buddy)","Bounder (Pure +Buddy +Suit +Fulton)"},
    onChange=function()--tex DEPENDENCY: settings dependency, isManualSubsistence, subsistenceLoadout
      if gvars.isManualSubsistence==0 then
        gvars.subsistenceLoadout=0
      elseif gvars.subsistenceLoadout==0 then
        gvars.subsistenceLoadout=1
      end
    end,
  },
  {
    name="OSP Weapon Loadout",
    gvarName="subsistenceLoadout",
    default=0,
    slider={max=#this.subsistenceLoadouts,min=0,increment=1},
    settingNames={"Off","Pure","Secondary enabled"},
    helpText="Start with no primary and secondary weapons, can be used seperately from subsistence mode",
  },
  {
    name="Enemy Preparedness",
    gvarName="revengeMode",    
    default=0,
    slider=this.switchSlider,
    settingNames={"Regular","Max"},
  },
  {
    name="General Enemy Parameters",
    gvarName="enemyParameters",
    default=0,
    slider=this.switchSlider,
    settingNames={"Default (mods can override)","Tweaked"},
  },  
  {
    name="Enemy life scale (Requires Tweaked Enemy Parameters)",
    gvarName="enemyHealthMult",
    default=1,
    slider=this.healthMultSlider,
    isFloatSetting=true,
  },
  {
    name="Player life scale",
    gvarName="playerHealthMult",
    default=1,
    slider=this.healthMultSlider,
    isFloatSetting=true,
  },
  {
    name="Unlock random Sideops for areas",
    gvarName="unlockSideOps",
    default=0,
    slider={max=(this.SETTING_UNLOCK_SIDEOPS_ENUM.MAX-1),min=0,increment=1},
    settingNames={"Off","Force Replayable","Force Open"},--[[--tex SYNC: SETTING_UNLOCK_SIDEOPS_ENUM--]]
    helpText="Sideops are broken into areas to stop overlap, this setting lets you control the choice of sideop within the area.",
    onChange=function()
      TppQuest.UpdateActiveQuest()
    end,
  },
  {
    name="Open specific sideop #",
    gvarName="unlockSideOpNumber",
    default=0,
    slider={max=this.numQuests,min=0,increment=1},
    skipValues={[144]=true},
    onChange=function()
      TppQuest.UpdateActiveQuest()
    end,
  },
  {
    name="Return Quiet (not reversable)",
    default=0,
    slider=this.switchSlider,
    settingNames={">","Returned"},
    onChange=function()
      if not TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)then
        TppUiCommand.AnnounceLogView("Quiet has already returned.")
      else
        --if TppStory.IsMissionCleard(10260) then
          this.QuietReturn()
        --end
      end
    end,
  },
  --[[--tex cant get startoffline to read in init sequence, yet isnewgame seems to be fine? (well haven't checked, it is read as if it is).
  {
    name="Start Offline",
    gvarName="startOffline",
    default=0,
    slider=this.switchSlider,
    settingNames={"False","True"},
  },--]]
  {
    name="Reset all settings",
    default=0,
    slider=this.switchSlider,
    settingNames={">","Reset"},
    onChange=function()
      this.ResetSettingsDisplay()
      this.ModMenuOff()
    end,
  },
  {
    name="Turn off menu",
    default=0,
    slider=this.switchSlider,
    settingNames={">","Off"},
    onChange=function()
      this.ModMenuOff()
      this.currentOption=1
    end,
  },
}
this.currentOption=1--tex lua tables are indexed from 1
this.currentSetting=0--tex settings from 0, to better fit variables
this.lastDisplay=0
this.autoDisplayDefault=2.8
this.autoRateHeld=0.9
this.autoDisplayRate=this.autoDisplayDefault
this.modMenuOn=false
this.toggleMenuButton=PlayerPad.RELOAD
this.toggleMenuHoldTime=1
this.menuRightButton=PlayerPad.RIGHT
this.menuLeftButton=PlayerPad.LEFT
this.menuUpButton=PlayerPad.UP
this.menuDownButton=PlayerPad.DOWN
this.resetSettingButton=PlayerPad.STANCE
--tex mod settings menu manipulation
function this.NextOption()
  this.currentOption=this.currentOption+1
  if this.currentOption > #this.modSettings then
    this.currentOption = 1
  end
  this.GetSetting()
end
function this.PreviousOption()
  this.currentOption = this.currentOption-1
  if this.currentOption < 1 then
    this.currentOption = #this.modSettings
  end
  this.GetSetting()
end
function this.GetSetting()
  local modSetting=this.modSettings[this.currentOption]
  this.currentSetting=modSetting.default
  if modSetting.gvarName ~= nil then
    local gvar=gvars[modSetting.gvarName]
    if gvar ~= nil then
      this.currentSetting=gvar
    else
      TppUiCommand.AnnounceLogView("Option Menu Error: gvar -"..modSetting.gvarName.."- not found")
    end
  end
end
function this.IncrementSetting(current, increment, min, max)
  local newSetting=current+increment
   
  if increment > 0 then
    if newSetting > max then
      newSetting = min
    end
  elseif increment < 0 then
    if newSetting < min then
      newSetting = max
    end      
  end
  return newSetting
end
function this.ChangeSetting(modSetting,value)
  --TppUiCommand.AnnounceLogView("DBG:MNU: changesetting increment:"..value)--tex DEBUG: CULL:
  local newSetting=this.currentSetting
  if modSetting.gvarName~=nil then
    --TppUiCommand.AnnounceLogView("DBG:MNU: found gvarName:" .. modSetting.gvarName)--tex DEBUG: CULL:
    local gvar=gvars[modSetting.gvarName]
    if gvar ~= nil then
      --TppUiCommand.AnnounceLogView("DBG:MNU: gvar:" .. modSetting.gvarName .. "=" .. gvar)--tex DEBUG: CULL:           
      newSetting=this.IncrementSetting(gvar,value,modSetting.slider.min,modSetting.slider.max)
      if modSetting.skipValues ~= nil then
        while modSetting.skipValues[newSetting] do
          TppUiCommand.AnnounceLogView(newSetting .. this.modStrings.settingDisallowed)
          newSetting=this.IncrementSetting(newSetting,value,modSetting.slider.min,modSetting.slider.max)
        end
      end
      --TppUiCommand.AnnounceLogView("DBG:MNU: newsetting:"..newSetting)--tex DEBUG: CULL:
      newSetting=TppMath.Clamp(newSetting,modSetting.slider.min,modSetting.slider.max)
      --TppUiCommand.AnnounceLogView("DBG:MNU: newsetting clamped:"..newSetting)--tex DEBUG: CULL:
    else
      TppUiCommand.AnnounceLogView("Option Menu Error: gvar -" .. modSetting.gvarName .. "- not found")
    end
    if modSetting.confirm == nil then 
      gvars[modSetting.gvarName]=newSetting
      --TppUiCommand.AnnounceLogView("DBG:MNU: gvar set:" .. modSetting.gvarName .. "=" .. gvar)--tex DEBUG: CULL:
      if IsFunc(modSetting.onChange) then
        modSetting.onChange()
      end
    elseif newSetting==modSetting.default then--tex let confirm settings turn off without having to confirm lol
      gvars[modSetting.gvarName]=newSetting
      --TppUiCommand.AnnounceLogView("DBG:MNU: gvar set:" .. modSetting.gvarName .. "=" .. gvar)--tex DEBUG: CULL:
      if IsFunc(modSetting.onChange) then
        modSetting.onChange()
      end
    end
  else--gvar nil
    newSetting=this.currentSetting+value
    if value > 0 then
      if newSetting > modSetting.slider.max then
        newSetting = modSetting.slider.min
      end
    elseif value < 0 then
      if newSetting < modSetting.slider.min then
        newSetting = modSetting.slider.max
      end      
    end
    --newSetting=TppMath.Clamp(newSetting,modSetting.slider.min,modSetting.slider.max)
    if IsFunc(modSetting.onChange) then
      modSetting.onChange()
    end   
  end
  --TppUiCommand.AnnounceLogView("DBG:MNU: new currentSetting:" .. newSetting)--tex DEBUG: CULL:
  return newSetting
end
function this.ConfirmCurrent()
  this.ConfirmSetting(this.modSettings[this.currentOption],this.currentSetting)
end
function this.ConfirmSetting(modSetting,value)
  if modSetting.confirm ~= nil then
    if modSetting.gvarName~=nil then
      local gvar=gvars[modSetting.gvarName]
      if gvar ~= nil then
        gvars[modSetting.gvarName]=value
        if IsFunc(modSetting.onChange) then
          modSetting.onChange()
        end
      end
    end
  end
end
function this.SetCurrent()
  this.SetSetting(this.modSettings[this.currentOption],this.currentSetting)
end
function this.SetSetting(modSetting,value)
  --if modSetting.set ~= nil then
    if modSetting.gvarName~=nil then
      local gvar=gvars[modSetting.gvarName]
      if gvar ~= nil then
        gvars[modSetting.gvarName]=value
        if IsFunc(modSetting.onChange) then
          modSetting.onChange()
        end
      end
    end
  --end
end
function this.NextSetting()
  local modSetting=this.modSettings[this.currentOption]
  this.currentSetting=this.ChangeSetting(modSetting,modSetting.slider.increment)
end
function this.PreviousSetting()
  local modSetting=this.modSettings[this.currentOption]
  this.currentSetting=this.ChangeSetting(modSetting,-modSetting.slider.increment)
end
function this.DisplayCurrentSetting()
  if this.modMenuOn then
    this.DisplaySetting(this.currentOption)
  end
end
function this.DisplaySetting(optionIndex)
  this.lastDisplay=Time.GetRawElapsedTimeSinceStartUp() 
  local modSetting=this.modSettings[optionIndex]
  local settingText="UNDEFINED"
  if modSetting.settingNames ~= nil then
    if this.currentSetting < 0 or this.currentSetting > #modSetting.settingNames-1 then
      settingText="CURRENTSETTING OUT OF BOUNDS"
    else
      settingText=modSetting.settingNames[this.currentSetting+1]--tex lua indexed from 1, but settings from 0
      if modSetting.confirm ~= nil then
        if this.currentSetting ~= modSetting.default then
          if modSetting.gvarName ~= nil and gvars[modSetting.gvarName] ~= nil then
            if gvars[modSetting.gvarName] ~= this.currentSetting then
              settingText=settingText.." (Press<Reload> to confirm)"
            else--tex ASSUMPTION SPECIAL setting text is "Enable"
              settingText=modSetting.confirm
            end
          end
        end
      end
    end
  elseif modSetting.isFloatSetting then
    settingText=math.floor(100*this.currentSetting) .. "%"
  else
    settingText=tostring(this.currentSetting)
  end
  local info = 0
  if IsFunc(modSetting.infoFunc) then
    info = modSetting.infoFunc()
  end
  TppUiCommand.AnnounceLogDelayTime(0)
  TppUiCommand.AnnounceLogView(optionIndex..":"..modSetting.name.." = "..settingText)--tex thank you ThreeSocks3, you're a god damn legend for finding custom text output, heres a better way to do things than string.format, in lua .. concatenates strings, does simple format conversion
end
function this.DisplaySettings()--tex display all
  for i=1,#this.modSettings do
    this.DisplaySetting(i)
  end
end
function this.AutoDisplay()
  if this.modMenuOn then
    if this.autoDisplayRate > 0 then
      if Time.GetRawElapsedTimeSinceStartUp() - this.lastDisplay > this.autoDisplayRate then
        this.DisplayCurrentSetting()
      end
    end
  end
end
function this.DisplayHelpText()
  local modSetting=this.modSettings[this.currentOption]
  if modSetting.helpText ~= nil then
    --this.lastDisplay=Time.GetRawElapsedTimeSinceStartUp()
    TppUiCommand.AnnounceLogView(modSetting.helpText)
  end
end
function this.ResetSetting()
  local modSetting=this.modSettings[this.currentOption]
  if modSetting.gvarName~=nil then
    gvars[modSetting.gvarName]=modSetting.default
    this.currentSetting=modSetting.default
  end
end
function this.ResetSettings()
  for i=1,#this.modSettings do
    local modSetting=this.modSettings[i]
    if modSetting.gvarName~=nil then
      gvars[modSetting.gvarName]=modSetting.default
      this.currentSetting=modSetting.default
    end
  end
end
function this.ResetSettingsDisplay()
  TppUiCommand.AnnounceLogView(TppMain.modStrings.settingDefaults)--tex "Setting mod options to defaults..."
  for i=1,#this.modSettings do
    local modSetting=this.modSettings[i]
    if modSetting.gvarName~=nil then
      gvars[modSetting.gvarName]=modSetting.default
      this.currentSetting=modSetting.default
      this.DisplaySetting(i)
    end
  end
  this.GetSetting()
end
function this.ModMenuOff()
  this.modMenuOn=false
  TppUiCommand.AnnounceLogView(this.modStrings.menuOff)
end
function this.UpdateModMenu()--tex RETRY: called from TppMission.Update, had 'troubles' running in main
--local debugSplash=SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
--SplashScreen.Show(debugSplash,0,0.3,0)--tex eagle
  this.ModStart()--tex: TODO: move to actual run once on startup init thing, make sure to check ModStart itself to see affected code
  this.UpdateHeldButtons()
  if not mvars.mis_missionStateIsNotInGame then--tex actually loaded game, ie at least 'continued' from title screen
    if TppMission.IsHelicopterSpace(vars.missionCode)then
      --tex RETRY: still not happy, want to read menu status but cant find any way
      if this.OnButtonHoldTime(this.toggleMenuButton) then
        this.modMenuOn = not this.modMenuOn
        if this.modMenuOn then
          this.GetSetting()
          TppUiCommand.AnnounceLogView(this.modName.." "..this.modVersion.." (Press Up/Down,Left/Right to navigate menu)")
          --this.lastDisplay=Time.GetRawElapsedTimeSinceStartUp()
          --if this.autoDisplayRate==0 then
          --  this.DisplayCurrentSetting()
          --end
        else
          this.ModMenuOff()
        end
      end
      if this.modMenuOn then
        if this.OnButtonDown(PlayerPad.MB_DEVICE) then
          this.ModMenuOff()
        end
        if this.OnButtonDown(this.toggleMenuButton) then
          this.SetCurrent()
          this.DisplayCurrentSetting()
        end 
        if this.OnButtonDown(PlayerPad.UP) then
          this.PreviousOption()
          this.DisplayCurrentSetting()
        end
        if this.OnButtonDown(PlayerPad.DOWN) then
          this.NextOption()
          this.DisplayCurrentSetting()
        end
        
        if this.OnButtonDown(this.menuRightButton) then
          this.NextSetting()
          this.DisplayCurrentSetting()
        elseif this.OnButtonUp(this.menuRightButton) then
          this.autoDisplayRate=this.autoDisplayDefault
        elseif this.OnButtonRepeat(this.menuRightButton) then          
          this.autoDisplayRate=this.autoRateHeld
          this.NextSetting()
        end
        
        if this.OnButtonDown(this.menuLeftButton) then
          this.PreviousSetting()
          this.DisplayCurrentSetting()
        elseif this.OnButtonUp(this.menuLeftButton) then
          this.autoDisplayRate=this.autoDisplayDefault
        elseif this.OnButtonRepeat(this.menuLeftButton) then         
          this.autoDisplayRate=this.autoRateHeld
          this.PreviousSetting()
        end
        
        if this.OnButtonDown(this.resetSettingButton) then
          this.ResetSetting()
          TppUiCommand.AnnounceLogView"Setting to default.."
          this.DisplayCurrentSetting()
        end
      end
      this.AutoDisplay()
    else--!ishelispace
      this.modMenuOn = false
      if this.DEBUGMODE then
        if this.OnButtonDown(PlayerPad.LIGHT_SWITCH) then
          TppUiCommand.AnnounceLogView("")
        end
      end
    end
  else--!ingame
    this.modMenuOn = false
  end
  this.UpdatePressedButtons()--tex GOTCHA: should be after all key reads, sets current keys to prev keys for onbutton checks
--local debugSplash=SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5020_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
--SplashScreen.Show(debugSplash,0,0.3,0)--tex dog
end
function this.ModStart()--tex currently called from UpdateModMenu, RETRY: find an actual place for on start/run once init.
  gvars.isManualHard = false--tex PATCHUP: not currently exposed to mod menu, force off to patch those that might have saves from prior mod with it on 
  this.buttonStates[this.toggleMenuButton].holdTime=this.toggleMenuHoldTime--tex set up hold buttons
  this.buttonStates[this.menuRightButton].decrement=0.1
  this.buttonStates[this.menuLeftButton].decrement=0.1
end
function this.ModWelcome()
  TppUiCommand.AnnounceLogView(this.modName .. " " .. this.modVersion)
  TppUiCommand.AnnounceLogView("Hold X key or Dpad Right for 1 second to enable menu")--tex TODO: modstring
end
function this.ModMissionMessage()
  TppUiCommand.AnnounceLogView("ModMissionMessage test")--tex TODO: modstring
end
--tex end SYS modmenu
--tex SYS: enemyparams
--tex soldier2parametertables shiz REFACTOR: find somewhere nicer to put/compartmentalize this, Solider2ParameterTables.lua aparently can't be referenced even though there's a TppSolder2Parameter string in the exe, load hang on trying to do anything with it (and again no debug feedback to know why the fuck anything)
local nightSightDebug={
  discovery={distance=10,verticalAngle=30,horizontalAngle=40},
  indis={distance=15,verticalAngle=60,horizontalAngle=60},
  dim={distance=40,verticalAngle=60,horizontalAngle=60},
  far={distance=350,verticalAngle=60,horizontalAngle=60}--tex debug hax
}
--tex in sightFormParameter
local sandstormSightDefault={distanceRate=.6,angleRate=.8}
local rainSightDefault={distanceRate=1,angleRate=1}
local cloudySightDefault={distanceRate=1,angleRate=1}
local foggySightDefault={distanceRate=.5,angleRate=.6}
--tex BALLANCE: being conservative, could be more agressive if coupled with a bump in the sight dist it modifies, but I like the retail settings in general
local sandstormSightImproved={distanceRate=.6,angleRate=.8}
local rainSightImproved={distanceRate=.9,angleRate=0.95}
local cloudySightImproved={distanceRate=0.95,angleRate=1}
local foggySightImproved={distanceRate=.5,angleRate=.6}

this.lifeParameterTableDefault={maxLife=2600,maxStamina=3e3,maxLimbLife=1500,maxArmorLife=7500,maxHelmetLife=500,sleepRecoverSec=300,faintRecoverSec=50,dyingSec=60}
this.lifeParameterTableMod={maxLife=2600,maxStamina=3e3,maxLimbLife=1500,maxArmorLife=7500,maxHelmetLife=500,sleepRecoverSec=300,faintRecoverSec=50,dyingSec=60}--tex modified in-place by enemy health scale
this.soldierParametersDefault = {--tex  SYNC: soldierParametersMod. actually using my slight tweaks rather than true default
  sightFormParameter={
    contactSightForm={distance=2,verticalAngle=160,horizontalAngle=130},
    normalSightForm={distance=60,verticalAngle=60,horizontalAngle=100},
    farSightForm={distance=90,verticalAngle=30,horizontalAngle=30},
    searchLightSightForm={distance=50,verticalAngle=15,horizontalAngle=15},
    observeSightForm={distance=200,verticalAngle=5,horizontalAngle=5},
    baseSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=20,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    nightSight={
      discovery={distance=10,verticalAngle=30,horizontalAngle=40},
      indis={distance=15,verticalAngle=60,horizontalAngle=60},
      dim={distance=40,verticalAngle=60,horizontalAngle=60},
      far={distance=50,verticalAngle=8,horizontalAngle=6}
    },
    combatSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=50,verticalAngle=60,horizontalAngle=100},
      far={distance=70,verticalAngle=30,horizontalAngle=30}},
    walkerGearSight={
      discovery={distance=15,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=55,verticalAngle=60,horizontalAngle=100},
      far={distance=85,verticalAngle=30,horizontalAngle=30}},
    observeSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=70,verticalAngle=12,horizontalAngle=8},
      dim={distance=45,verticalAngle=5,horizontalAngle=5},
      far={distance=70,verticalAngle=5,horizontalAngle=5},
      observe={distance=200,verticalAngle=5,horizontalAngle=5}
    },
    snipingSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=70,verticalAngle=12,horizontalAngle=8},
      dim={distance=45,verticalAngle=5,horizontalAngle=5},
      far={distance=70,verticalAngle=5,horizontalAngle=5},
      observe={distance=200,verticalAngle=5,horizontalAngle=5}
    },
    searchLightSight={
      discovery={distance=30,verticalAngle=8,horizontalAngle=8},
      indis={distance=0,verticalAngle=0,horizontalAngle=0},
      dim={distance=50,verticalAngle=12,horizontalAngle=12},
      far={distance=0,verticalAngle=0,horizontalAngle=0}},
    armoredVehicleSight={
      discovery={distance=20,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=55,verticalAngle=60,horizontalAngle=100},
      far={distance=85,verticalAngle=30,horizontalAngle=30},
      observe={distance=120,verticalAngle=5,horizontalAngle=5}},
    zombieSight={
      discovery={distance=7,verticalAngle=36,horizontalAngle=48},
      indis={distance=14,verticalAngle=60,horizontalAngle=80},
      dim={distance=31.5,verticalAngle=60,horizontalAngle=80},
      far={distance=0,verticalAngle=12,horizontalAngle=8}},
    msfSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=20,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}},
    vehicleSight={
      discovery={distance=15,verticalAngle=36,horizontalAngle=48},
      indis={distance=25,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    sandstormSight=sandstormSightImproved,
    rainSight=rainSightImproved,
    cloudySight=cloudySightImproved,
    foggySight=foggySightImproved
  },
  sightCamouflageParameter={
    discovery={enemy=530,character=530,object=530},
    indis={enemy=80,character=210,object=270},
    dim={enemy=-50,character=30,object=130},
    far={enemy=-310,character=0,object=70},
    bushDensityThresold=100
  },
  hearingRangeParameter={
    normal={zero=0,ss=4.5,hs=5.5,s=9,m=15,l=30,hll=60,ll=160,alert=160,special=500},
    sandstorm={zero=0,ss=0,hs=0,s=0,m=15,l=30,hll=60,ll=160,alert=160,special=500},
    rain={zero=0,ss=0,hs=0,s=4.5,m=15,l=30,hll=60,ll=160,alert=160,special=500}
  },
  lifeParameterTable=this.lifeParameterTableMod,
  zombieParameterTable={highHeroicValue=1e3}
}
this.soldierParametersMod={--tex: SYNC: soldierParametersDefault. Ugly, but don't want to blow out the stack by doing table copies at runtime
  sightFormParameter={
    contactSightForm={distance=2,verticalAngle=160,horizontalAngle=130},
    normalSightForm={distance=60,verticalAngle=60,horizontalAngle=100},
    farSightForm={distance=90,verticalAngle=30,horizontalAngle=30},
    searchLightSightForm={distance=50,verticalAngle=15,horizontalAngle=15},
    observeSightForm={distance=200,verticalAngle=5,horizontalAngle=5},
    baseSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=20,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    nightSight={
      discovery={distance=10,verticalAngle=30,horizontalAngle=40},
      indis={distance=15,verticalAngle=60,horizontalAngle=60},
      dim={distance=40,verticalAngle=60,horizontalAngle=60},
      far={distance=50,verticalAngle=8,horizontalAngle=6}
    },
    combatSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=50,verticalAngle=60,horizontalAngle=100},
      far={distance=70,verticalAngle=30,horizontalAngle=30}},
    walkerGearSight={
      discovery={distance=15,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=55,verticalAngle=60,horizontalAngle=100},
      far={distance=85,verticalAngle=30,horizontalAngle=30}},
    observeSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=70,verticalAngle=12,horizontalAngle=8},
      dim={distance=45,verticalAngle=5,horizontalAngle=5},
      far={distance=70,verticalAngle=5,horizontalAngle=5},
      observe={distance=200,verticalAngle=5,horizontalAngle=5}
    },
    snipingSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=70,verticalAngle=12,horizontalAngle=8},
      dim={distance=45,verticalAngle=5,horizontalAngle=5},
      far={distance=70,verticalAngle=5,horizontalAngle=5},
      observe={distance=200,verticalAngle=5,horizontalAngle=5}
    },
    searchLightSight={
      discovery={distance=30,verticalAngle=8,horizontalAngle=8},
      indis={distance=0,verticalAngle=0,horizontalAngle=0},
      dim={distance=50,verticalAngle=12,horizontalAngle=12},
      far={distance=0,verticalAngle=0,horizontalAngle=0}},
    armoredVehicleSight={
      discovery={distance=20,verticalAngle=36,horizontalAngle=60},
      indis={distance=25,verticalAngle=60,horizontalAngle=100},
      dim={distance=55,verticalAngle=60,horizontalAngle=100},
      far={distance=85,verticalAngle=30,horizontalAngle=30},
      observe={distance=120,verticalAngle=5,horizontalAngle=5}},
    zombieSight={
      discovery={distance=7,verticalAngle=36,horizontalAngle=48},
      indis={distance=14,verticalAngle=60,horizontalAngle=80},
      dim={distance=31.5,verticalAngle=60,horizontalAngle=80},
      far={distance=0,verticalAngle=12,horizontalAngle=8}},
    msfSight={
      discovery={distance=10,verticalAngle=36,horizontalAngle=48},
      indis={distance=20,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}},
    vehicleSight={
      discovery={distance=15,verticalAngle=36,horizontalAngle=48},
      indis={distance=25,verticalAngle=60,horizontalAngle=80},
      dim={distance=45,verticalAngle=60,horizontalAngle=80},
      far={distance=70,verticalAngle=12,horizontalAngle=8}
    },
    sandstormSight=sandstormSightImproved,
    rainSight=rainSightImproved,
    cloudySight=cloudySightImproved,
    foggySight=foggySightImproved
  },
  sightCamouflageParameter={
    discovery={enemy=530,character=530,object=530},
    indis={enemy=80,character=210,object=270},
    dim={enemy=-50,character=30,object=130},
    far={enemy=-310,character=0,object=70},
    bushDensityThresold=100
  },
  hearingRangeParameter={
    normal={zero=0,ss=4.5,hs=5.5,s=9,m=15,l=30,hll=60,ll=160,alert=160,special=500},
    sandstorm={zero=0,ss=0,hs=0,s=0,m=15,l=30,hll=60,ll=160,alert=160,special=500},
    rain={zero=0,ss=0,hs=0,s=4.5,m=15,l=30,hll=60,ll=160,alert=160,special=500}
  },
  lifeParameterTable=this.lifeParameterTableMod,
  zombieParameterTable={highHeroicValue=1e3}
}
--tex SYS end enemyparams
--tex SYS: patchshit
function this.QuietReturn()--tex
  -- if gvars.str_didLostQuiet then
  if TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)then
    local q=TppMotherBaseManagement.GenerateStaffParameter{staffType="Unique",uniqueTypeId=TppMotherBaseManagementConst.STAFF_UNIQUE_TYPE_ID_QUIET}
    if not TppMotherBaseManagement.IsExistStaff{staffId=q}then
      TppMotherBaseManagement.DirectAddStaff{staffId=q}
      -- ,section="Wait",isNew=true,specialContract="fromExtra"} --tex nothing seems to work, some kind of internal check in directaddstaff i guess
      -- specialContract="fromGZ"
    end
    
    gvars.str_didLostQuiet=false
    --TppBuddyService.SetObtainedBuddyType(BuddyType.QUIET)
    TppBuddy2BlockController.SetObtainedBuddyType(BuddyType.QUIET)
    --TppBuddyService.UnsetBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_DYING)
    TppBuddyService.UnsetBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)
    TppBuddyService.UnsetBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_HOSPITALIZE)
    --TppBuddyService.UnsetDeadBuddyType(BuddyType.QUIET)
    TppBuddyService.SetSortieBuddyType(BuddyType.QUIET)
    TppBuddyService.SetFriendlyPoint(BuddyFriendlyType.QUIET,100)
    TppMotherBaseManagement.RefreshQuietStatus()
  end
end
function this.Seq_Demo_RecoverVolgin_OnEnter_Patch()--tex patchup shit
--tex ORIG: /Assets/tpp/level/mission2/free/f3020_sequence.lua - sequences.Seq_Demo_RecoverVolgin.OnEnter
  --tex NMC: looks like kjp had attempted some fallback for if sequence was repeated after completed, just no playing demo, trouble is the previous sequence that sets up the player in an unplayble state
  --if this.isRecoverVolginDemoPlay() then
    --Fox.Log("######## Seq_Demo_RecoverVolgin.OnEnter ########")
    TppUiCommand.AnnounceLogView"DBG:Seq_Demo_RecoverVolgin_OnEnter_Patch"
    
    mvars.isPlayVolginDemo = true
    local startFunc = function()
    end
    local endFunc = function()
      TppSequence.SetNextSequence("Seq_Game_MainGame")
    end
    
    TppDemo.SpecifyIgnoreNpcDisable( {"hos_volgin_0000",} )--(VOLGIN_DEMO_GROUP) 
    
    f30250_demo.PlayRecoverVolgin( startFunc, endFunc )
  ---else
    --TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeInOnGameStart")
    --TppMain.EnableGameStatus()  
    --TppSequence.SetNextSequence("Seq_Game_MainGame")
  --end
end
function this.PatchSequenceTable()
  --[[--tex OFF: no luck so far
  if vars.missionCode == 30250 then
    if mvars.seq_sequenceTable["Seq_Demo_RecoverVolgin"] ~= nil then
      mvars.seq_sequenceTable["Seq_Demo_RecoverVolgin"].OnEnter=this.Seq_Demo_RecoverVolgin_OnEnter_Patch
    end
  end
  --]]
end
--tex end SYS patchshit
--tex end of shit
local r=Tpp.ApendArray
local n=Tpp.DEBUG_StrCode32ToString
local i=Tpp.IsTypeFunc
local t=Tpp.IsTypeTable
local M=TppScriptVars.IsSavingOrLoading
local P=ScriptBlock.UpdateScriptsInScriptBlocks
local f=Mission.GetCurrentMessageResendCount
local a={}
local l=0
local T={}
local o=0
local c={}
local u=0
local n={}
local n=0
local d={}
local m={}
local s=0
local S={}
local h={}
local p=0
local function n()--tex NMC: cant actually see this referenced anywhere
  if QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD then
    QuarkSystem.PostRequestToLoad()coroutine.yield()
    while QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD do
      coroutine.yield()
    end
  end
end
function e.DisableGameStatus()
  TppMission.DisableInGameFlag()
  Tpp.SetGameStatus{target="all",enable=false,except={S_DISABLE_NPC=false},scriptName="TppMain.lua"}
end
function e.DisableGameStatusOnGameOverMenu()
  TppMission.DisableInGameFlag()
  Tpp.SetGameStatus{target="all",enable=false,scriptName="TppMain.lua"}
end
function e.EnableGameStatus()
  TppMission.EnableInGameFlag()
  Tpp.SetGameStatus{target={S_DISABLE_PLAYER_PAD=true,S_DISABLE_TARGET=true,S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true},enable=true,scriptName="TppMain.lua"}
end
function e.EnableGameStatusForDemo()
  TppDemo.ReserveEnableInGameFlag()
  Tpp.SetGameStatus{target={S_DISABLE_PLAYER_PAD=true,S_DISABLE_TARGET=true,S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true},enable=true,scriptName="TppMain.lua"}
end
function e.EnableAllGameStatus()
  TppMission.EnableInGameFlag()
  Tpp.SetGameStatus{target="all",enable=true,scriptName="TppMain.lua"}
end
function e.EnablePlayerPad()
  TppGameStatus.Reset("TppMain.lua","S_DISABLE_PLAYER_PAD")
end
function e.DisablePlayerPad()
  TppGameStatus.Set("TppMain.lua","S_DISABLE_PLAYER_PAD")
end
function e.EnablePause()
  TppPause.RegisterPause"TppMain.lua"end
function e.DisablePause()
  TppPause.UnregisterPause"TppMain.lua"end
function e.EnableBlackLoading(e)
  TppGameStatus.Set("TppMain.lua","S_IS_BLACK_LOADING")
  if e then
    TppUI.StartLoadingTips()
  end
end
function e.DisableBlackLoading()
  TppGameStatus.Reset("TppMain.lua","S_IS_BLACK_LOADING")
  TppUI.FinishLoadingTips()
end
function e.OnAllocate(n)
  TppWeather.OnEndMissionPrepareFunction()
  e.DisableGameStatus()
  e.EnablePause()
  TppClock.Stop()a={}l=0
  c={}u=0
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,nil,nil)
  TppSave.WaitingAllEnqueuedSaveOnStartMission()
  if TppMission.IsFOBMission(vars.missionCode)then
    this.ResetSettings()--tex reset settings on FOB
    TppMission.SetFOBMissionFlag()
    TppGameStatus.Set("Mission","S_IS_ONLINE")
  else
    TppGameStatus.Reset("Mission","S_IS_ONLINE")
  end
  Mission.Start()
  TppMission.WaitFinishMissionEndPresentation()
  TppMission.DisableInGameFlag()
  TppException.OnAllocate(n)
  TppClock.OnAllocate(n)
  TppTrap.OnAllocate(n)
  TppCheckPoint.OnAllocate(n)
  TppUI.OnAllocate(n)
  TppDemo.OnAllocate(n)
  TppScriptBlock.OnAllocate(n)
  TppSound.OnAllocate(n)
  TppPlayer.OnAllocate(n)
  TppMission.OnAllocate(n)
  TppTerminal.OnAllocate(n)
  TppEnemy.OnAllocate(n)
  TppRadio.OnAllocate(n)
  TppGimmick.OnAllocate(n)
  TppMarker.OnAllocate(n)
  TppRevenge.OnAllocate(n)
  e.ClearStageBlockMessage()
  TppQuest.OnAllocate(n)
  TppAnimal.OnAllocate(n)
  local function s()
    if TppLocation.IsAfghan()then
      if afgh then
        afgh.OnAllocate()
      end
    elseif TppLocation.IsMiddleAfrica()then
      if mafr then
        mafr.OnAllocate()
      end
    elseif TppLocation.IsCyprus()then
      if cypr then
        cypr.OnAllocate()
      end
    elseif TppLocation.IsMotherBase()then
      if mtbs then
        mtbs.OnAllocate()
      end
    end
  end
  s()
  if n.sequence then
    if i(n.sequence.MissionPrepare)then
      n.sequence.MissionPrepare()
    end
    if i(n.sequence.OnEndMissionPrepareSequence)then
      TppSequence.SetOnEndMissionPrepareFunction(n.sequence.OnEndMissionPrepareSequence)
    end
  end
  for n,e in pairs(n)do
    if i(e.OnLoad)then
      e.OnLoad()
    end
  end
  do
    local s={}
    for t,e in ipairs(Tpp._requireList)do
      if _G[e]then
        if _G[e].DeclareSVars then
          r(s,_G[e].DeclareSVars(n))
        end
      end
    end
    local o={}
    for n,e in pairs(n)do
      if i(e.DeclareSVars)then
        r(o,e.DeclareSVars())
      end
      if t(e.saveVarsList)then
        r(o,TppSequence.MakeSVarsTable(e.saveVarsList))
      end
    end
    r(s,o)
    TppScriptVars.DeclareSVars(s)
    TppScriptVars.SetSVarsNotificationEnabled(false)
    while M()do
      coroutine.yield()
    end
    TppRadioCommand.SetScriptDeclVars()
    local i=vars.mbLayoutCode
    if gvars.ini_isTitleMode then
      TppPlayer.MissionStartPlayerTypeSetting()
    else
      if TppMission.IsMissionStart()then
        TppVarInit.InitializeForNewMission(n)
        TppPlayer.MissionStartPlayerTypeSetting()
        if not TppMission.IsFOBMission(vars.missionCode)then
          TppSave.VarSave(vars.missionCode,true)
        end
      else
        TppVarInit.InitializeForContinue(n)
      end
      TppVarInit.ClearIsContinueFromTitle()
    end
    TppStory.SetMissionClearedS10030()
    TppTerminal.StartSyncMbManagementOnMissionStart()
    if TppLocation.IsMotherBase()then
      if i~=vars.mbLayoutCode then
        if vars.missionCode==30050 then
          vars.mbLayoutCode=i
        else
          vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(TppMotherBaseManagement.GetMbsTopologyType())
        end
      end
    end
    e.StageBlockCurrentPosition(true)
    TppMission.SetSortieBuddy()
    TppStory.UpdateStorySequence{updateTiming="BeforeBuddyBlockLoad"}
    if n.sequence then
      local e=n.sequence.DISABLE_BUDDY_TYPE
      if e then
        local n
        if t(e)then
          n=e
        else
          n={e}
        end
        for n,e in ipairs(n)do
          TppBuddyService.SetDisableBuddyType(e)
        end
      end
    end
    --if(vars.missionCode==11043)or(vars.missionCode==11044)then--tex ORIG: changed to issubs check, more robust even without my mod
    if TppMission.IsSubsistenceMission() and gvars.isManualSubsistence~=this.SUBSISTENCE_BOUND then--tex disable
      TppBuddyService.SetDisableAllBuddy()
    end
    if TppGameSequence.GetGameTitleName()=="TPP"then
      if n.sequence and n.sequence.OnBuddyBlockLoad then
        n.sequence.OnBuddyBlockLoad()
      end
      if TppLocation.IsAfghan()or TppLocation.IsMiddleAfrica()then
        TppBuddy2BlockController.Load()
      end
    end
    TppSequence.SaveMissionStartSequence()
    TppScriptVars.SetSVarsNotificationEnabled(true)
  end
  if gvars.enemyParameters==1 then--tex use tweaked soldier parameters
  --tex REF: this.lifeParameterTableDefault={maxLife=2600,maxStamina=3e3,maxLimbLife=1500,maxArmorLife=7500,maxHelmetLife=500,sleepRecoverSec=300,faintRecoverSec=50,dyingSec=60}
    local healthMult=gvars.enemyHealthMult--tex mod enemy health scale
    this.lifeParameterTableMod.maxLife = TppMath.ScaleValueClamp1(this.lifeParameterTableDefault.maxLife,healthMult)
    this.lifeParameterTableMod.maxLimbLife = TppMath.ScaleValueClamp1(this.lifeParameterTableDefault.maxLimbLife,healthMult)
    this.lifeParameterTableMod.maxArmorLife = TppMath.ScaleValueClamp1(this.lifeParameterTableDefault.maxArmorLife,healthMult)
    this.lifeParameterTableMod.maxHelmetLife = TppMath.ScaleValueClamp1(this.lifeParameterTableDefault.maxHelmetLife,healthMult)
    TppSoldier2.ReloadSoldier2ParameterTables(this.soldierParametersMod)--tex reloadsoldierparams changes
  end--
  if n.enemy then
    if t(n.enemy.soldierPowerSettings)then
      TppEnemy.SetUpPowerSettings(n.enemy.soldierPowerSettings)
    end
  end
  TppRevenge.DecideRevenge(n)
  if TppEquip.CreateEquipMissionBlockGroup then
    if(vars.missionCode>6e4)then
      TppEquip.CreateEquipMissionBlockGroup{size=(380*1024)*24}
    else
      TppPlayer.SetEquipMissionBlockGroupSize()
    end
  end
  if TppEquip.CreateEquipGhostBlockGroups then
    if TppSystemUtility.GetCurrentGameMode()=="MGO"then
      TppEquip.CreateEquipGhostBlockGroups{ghostCount=16}
    elseif TppMission.IsFOBMission(vars.missionCode)then
      TppEquip.CreateEquipGhostBlockGroups{ghostCount=1}
    end
  end
  TppEquip.StartLoadingToEquipMissionBlock()
  TppPlayer.SetMaxPickableLocatorCount()
  TppPlayer.SetMaxPlacedLocatorCount()
  TppEquip.AllocInstances{instance=60,realize=60}
  TppEquip.ActivateEquipSystem()
  if TppEnemy.IsRequiredToLoadDefaultSoldier2CommonPackage()then
    TppEnemy.LoadSoldier2CommonBlock()
  end
  if n.sequence then
    mvars.mis_baseList=n.sequence.baseList
    TppCheckPoint.RegisterCheckPointList(n.sequence.checkPointList)
  end
end
function e.OnInitialize(n)
  if TppMission.IsFOBMission(vars.missionCode)then
    TppMission.SetFobPlayerStartPoint()
  elseif TppMission.IsNeedSetMissionStartPositionToClusterPosition()then
    TppMission.SetMissionStartPositionMtbsClusterPosition()
    e.StageBlockCurrentPosition(true)
  else
    TppCheckPoint.SetCheckPointPosition()
  end
  if TppEnemy.IsRequiredToLoadSpecialSolider2CommonBlock()then
    TppEnemy.LoadSoldier2CommonBlock()
  end
  if TppMission.IsMissionStart()then
    TppTrap.InitializeVariableTraps()
  else
    TppTrap.RestoreVariableTrapState()
  end
  TppAnimalBlock.InitializeBlockStatus()
  if TppQuestList then
    TppQuest.RegisterQuestList(TppQuestList.questList)
    TppQuest.RegisterQuestPackList(TppQuestList.questPackList)
  end
  TppHelicopter.AdjustBuddyDropPoint()
  if n.sequence then
    local e=n.sequence.NPC_ENTRY_POINT_SETTING
    if t(e)then
      TppEnemy.NPCEntryPointSetting(e)
    end
  end
  TppLandingZone.OverwriteBuddyVehiclePosForALZ()
  if n.enemy then
    if t(n.enemy.vehicleSettings)then
      TppEnemy.SetUpVehicles()
    end
    if i(n.enemy.SpawnVehicleOnInitialize)then
      n.enemy.SpawnVehicleOnInitialize()
    end
    TppReinforceBlock.SetUpReinforceBlock()
  end
  for t,e in pairs(n)do
    if i(e.Messages)then
      n[t]._messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnInitialize()
  end
  TppLandingZone.OnInitialize()
  for t,e in ipairs(Tpp._requireList)do
    if _G[e].Init then
      _G[e].Init(n)
    end
  end
  if n.enemy then
    if GameObject.DoesGameObjectExistWithTypeName"TppSoldier2"then
      GameObject.SendCommand({type="TppSoldier2"},{id="CreateFaceIdList"})
    end
    if t(n.enemy.soldierDefine)then
      TppEnemy.DefineSoldiers(n.enemy.soldierDefine)
    end
    if n.enemy.InitEnemy and i(n.enemy.InitEnemy)then
      n.enemy.InitEnemy()
    end
    if t(n.enemy.soldierPersonalAbilitySettings)then
      TppEnemy.SetUpPersonalAbilitySettings(n.enemy.soldierPersonalAbilitySettings)
    end
    if t(n.enemy.travelPlans)then
      TppEnemy.SetTravelPlans(n.enemy.travelPlans)
    end
    TppEnemy.SetUpSoldiers()
    if t(n.enemy.soldierDefine)then
      TppEnemy.InitCpGroups()
      TppEnemy.RegistCpGroups(n.enemy.cpGroups)
      TppEnemy.SetCpGroups()
      if mvars.loc_locationGimmickCpConnectTable then
        TppGimmick.SetCommunicateGimmick(mvars.loc_locationGimmickCpConnectTable)
      end
    end
    if t(n.enemy.interrogation)then
      TppInterrogation.InitInterrogation(n.enemy.interrogation)
    end
    if t(n.enemy.useGeneInter)then
      TppInterrogation.AddGeneInter(n.enemy.useGeneInter)
    end
    if t(n.enemy.uniqueInterrogation)then
      TppInterrogation.InitUniqueInterrogation(n.enemy.uniqueInterrogation)
    end
    do
      local e
      if t(n.enemy.routeSets)then
        e=n.enemy.routeSets
        for e,n in pairs(e)do
          if not t(mvars.ene_soldierDefine[e])then
          end
        end
      end
      if e then
        TppEnemy.RegisterRouteSet(e)
        TppEnemy.MakeShiftChangeTable()
        TppEnemy.SetUpCommandPost()
        TppEnemy.SetUpSwitchRouteFunc()
      end
    end
    if n.enemy.soldierSubTypes then
      TppEnemy.SetUpSoldierSubTypes(n.enemy.soldierSubTypes)
    end
    TppRevenge.SetUpEnemy()
    TppEnemy.ApplyPowerSettingsOnInitialize()
    TppEnemy.ApplyPersonalAbilitySettingsOnInitialize()
    TppEnemy.SetOccasionalChatList()
    TppEneFova.ApplyUniqueSetting()
    if n.enemy.SetUpEnemy and i(n.enemy.SetUpEnemy)then
      n.enemy.SetUpEnemy()
    end
    if TppMission.IsMissionStart()then
      TppEnemy.RestoreOnMissionStart2()
    else
      TppEnemy.RestoreOnContinueFromCheckPoint2()
    end
  end
  if not TppMission.IsMissionStart()then
    TppWeather.RestoreFromSVars()
    TppMarker.RestoreMarkerLocator()
  end
  TppPlayer.RestoreSupplyCbox()
  TppPlayer.RestoreSupportAttack()
  TppTerminal.MakeMessage()
  if n.sequence then
    local e=n.sequence.SetUpRoutes
    if e and i(e)then
      e()
    end
    TppEnemy.RegisterRouteAnimation()
    local e=n.sequence.SetUpLocation
    if e and i(e)then
      e()
    end
  end
  for n,e in pairs(n)do
    if e.OnRestoreSVars then
      e.OnRestoreSVars()
    end
  end
  TppMission.RestoreShowMissionObjective()
  TppRevenge.SetUpRevengeMine()
  if TppPickable.StartToCreateFromLocators then
    TppPickable.StartToCreateFromLocators()
  end
  if TppPlaced and TppPlaced.StartToCreateFromLocators then
    TppPlaced.StartToCreateFromLocators()
  end
  if TppMission.IsMissionStart()then
    TppRadioCommand.RestoreRadioState()
  else
    TppRadioCommand.RestoreRadioStateContinueFromCheckpoint()
  end
  TppMission.PostMissionOrderBoxPositionToBuddyDog()
  e.SetUpdateFunction(n)
  e.SetMessageFunction(n)
  TppQuest.UpdateActiveQuest()
  TppDevelopFile.OnMissionCanStart()
  if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
    if TppQuest.IsActiveQuestHeli()then
      TppEnemy.ReserveQuestHeli()
    end
  end
  TppDemo.UpdateNuclearAbolitionFlag()
  TppQuest.AcquireKeyItemOnMissionStart()
end
function e.SetUpdateFunction(e)a={}l=0
  T={}o=0
  c={}u=0
  a={TppMission.Update,TppSequence.Update,TppSave.Update,TppDemo.Update,TppPlayer.Update,TppMission.UpdateForMissionLoad}l=#a
  for n,e in pairs(e)do
    if i(e.OnUpdate)then
      o=o+1
      T[o]=e.OnUpdate
    end
  end
end
function e.OnEnterMissionPrepare()
  if TppMission.IsMissionStart()then
    TppScriptBlock.PreloadSettingOnMissionStart()
  end
  TppScriptBlock.ReloadScriptBlock()
end
function e.OnTextureLoadingWaitStart()
  if not TppMission.IsHelicopterSpace(vars.missionCode)then
    StageBlockCurrentPositionSetter.SetEnable(false)
  end
  gvars.canExceptionHandling=true
end
function e.OnMissionStartSaving()
end
function e.OnMissionCanStart()
  if TppMission.IsMissionStart()then
    TppWeather.SetDefaultWeatherProbabilities()
    TppWeather.SetDefaultWeatherDurations()
    if(not gvars.ini_isTitleMode)and(not TppMission.IsFOBMission(vars.missionCode))then
      TppSave.VarSave(nil,true)
    end
  end
  TppLocation.ActivateBlock()
  TppWeather.OnMissionCanStart()
  TppMarker.OnMissionCanStart()
  TppResult.OnMissionCanStart()
  TppQuest.InitializeQuestLoad()
  TppRatBird.OnMissionCanStart()
  TppMission.OnMissionStart()
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnMissionCanStart()
  end
  TppLandingZone.OnMissionCanStart()
  TppOutOfMissionRangeEffect.Disable(0)
  if TppLocation.IsMiddleAfrica()then
    TppGimmick.MafrRiverPrimSetting()
  end
  if MotherBaseConstructConnector.RefreshGimmicks then
    if vars.locationCode==TppDefine.LOCATION_ID.MTBS then
      MotherBaseConstructConnector.RefreshGimmicks()
    end
  end
  if vars.missionCode==10240 and TppLocation.IsMBQF()then
    Player.AttachGasMask()
  end
  if(vars.missionCode==10150)then
    local e=TppSequence.GetMissionStartSequenceIndex()
    if(e~=nil)and(e<TppSequence.GetSequenceIndex"Seq_Game_SkullFaceToPlant")then
      if(svars.mis_objectiveEnable[17]==false)then
        Gimmick.ForceResetOfRadioCassetteWithCassette()
      end
    end
  end
end
function e.OnMissionGameStart(n)
  TppClock.Start()
  if not gvars.ini_isTitleMode then
    PlayRecord.RegistPlayRecord"MISSION_START"end
  TppQuest.InitializeQuestActiveStatus()
  if mvars.seq_demoSequneceList[mvars.seq_missionStartSequence]then
    e.EnableGameStatusForDemo()
  else
    e.EnableGameStatus()
  end
  if Player.RequestChickenHeadSound~=nil then
    Player.RequestChickenHeadSound()
  end
  TppTerminal.OnMissionGameStart()
  if TppSequence.IsLandContinue()then
    TppMission.EnableAlertOutOfMissionAreaIfAlertAreaStart()
  end
  TppSoundDaemon.ResetMute"Telop"end
function e.ClearStageBlockMessage()StageBlock.ClearLargeBlockNameForMessage()StageBlock.ClearSmallBlockIndexForMessage()
end
function e.ReservePlayerLoadingPosition(n,o,s,t,i,p,a)
  e.DisableGameStatus()
  if n==TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE then
    if t then
      TppHelicopter.ResetMissionStartHelicopterRoute()
      TppPlayer.ResetInitialPosition()
      TppPlayer.ResetMissionStartPosition()
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.ResetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    elseif o then
      if gvars.heli_missionStartRoute~=0 then
        TppPlayer.SetStartStatusRideOnHelicopter()
        if mvars.mis_helicopterMissionStartPosition then
          TppPlayer.SetInitialPosition(mvars.mis_helicopterMissionStartPosition,0)
          TppPlayer.SetMissionStartPosition(mvars.mis_helicopterMissionStartPosition,0)
        end
      else
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        local e=TppDefine.NO_HELICOPTER_MISSION_START_POSITION[vars.missionCode]
        if e then
          TppPlayer.SetInitialPosition(e,0)
          TppPlayer.SetMissionStartPosition(e,0)
        else
          TppPlayer.ResetInitialPosition()
          TppPlayer.ResetMissionStartPosition()
        end
      end
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.SetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    elseif i then
      if TppLocation.IsMotherBase()then
        TppPlayer.SetStartStatusRideOnHelicopter()
      else
        TppPlayer.ResetInitialPosition()
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        TppPlayer.SetMissionStartPositionToCurrentPosition()
      end
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.ResetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
      TppLocation.MbFreeSpecialMissionStartSetting(TppMission.GetMissionClearType())
    elseif(s and TppLocation.IsMotherBase())then
      if gvars.heli_missionStartRoute~=0 then
        TppPlayer.SetStartStatusRideOnHelicopter()
      else
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
      end
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.SetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    else
      if s then
        if mvars.mis_orderBoxName then
          TppMission.SetMissionOrderBoxPosition()
          TppPlayer.ResetNoOrderBoxMissionStartPosition()
        else
          TppPlayer.ResetInitialPosition()
          TppPlayer.ResetMissionStartPosition()
          local e={[10020]={1449.3460693359,339.18698120117,1467.4300537109,-104},[10050]={-1820.7060546875,349.78659057617,-146.44400024414,139},[10070]={-792.00512695313,537.3740234375,-1381.4598388672,136},[10080]={-439.28802490234,-20.472593307495,1336.2784423828,-151},[10140]={499.91635131836,13.07358455658,1135.1315917969,79},[10150]={-1732.0286865234,543.94067382813,-2225.7587890625,162},[10260]={-1260.0454101563,298.75305175781,1325.6383056641,51}}e[11050]=e[10050]e[11080]=e[10080]e[11140]=e[10140]e[10151]=e[10150]e[11151]=e[10150]
          local e=e[vars.missionCode]
          if TppDefine.NO_ORDER_BOX_MISSION_ENUM[tostring(vars.missionCode)]and e then
            TppPlayer.SetNoOrderBoxMissionStartPosition(e,e[4])
          else
            TppPlayer.ResetNoOrderBoxMissionStartPosition()
          end
        end
        local e=TppDefine.NO_ORDER_FIX_HELICOPTER_ROUTE[vars.missionCode]
        if e then
          TppPlayer.SetStartStatusRideOnHelicopter()
          TppMission.SetIsStartFromHelispace()
          TppMission.ResetIsStartFromFreePlay()
        else
          TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
          TppHelicopter.ResetMissionStartHelicopterRoute()
          TppMission.ResetIsStartFromHelispace()
          TppMission.SetIsStartFromFreePlay()
        end
        local e=TppMission.GetMissionClearType()
        TppQuest.SpecialMissionStartSetting(e)
      else
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
        TppMission.ResetIsStartFromHelispace()
        TppMission.ResetIsStartFromFreePlay()
      end
    end
  elseif n==TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT then
    TppPlayer.ResetInitialPosition()
    TppHelicopter.ResetMissionStartHelicopterRoute()
    TppMission.ResetIsStartFromHelispace()
    TppMission.ResetIsStartFromFreePlay()
    if p then
      if i then
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.SetMissionStartPositionToCurrentPosition()
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
      elseif t then
        TppPlayer.ResetMissionStartPosition()
      elseif vars.missionCode~=5 then
      end
    else
      if t then
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
      elseif i then
        TppMission.SetMissionOrderBoxPosition()
      elseif vars.missionCode~=5 then
      end
    end
  elseif n==TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART then
  elseif n==TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT then
  end
  if o and a then
    Mission.AddLocationFinalizer(function()
      e.StageBlockCurrentPosition()
    end)
  else
    e.StageBlockCurrentPosition()
  end
end
function e.StageBlockCurrentPosition(e)
  if vars.initialPlayerFlag==PlayerFlag.USE_VARS_FOR_INITIAL_POS then
    StageBlockCurrentPositionSetter.SetEnable(true)StageBlockCurrentPositionSetter.SetPosition(vars.initialPlayerPosX,vars.initialPlayerPosZ)
  else
    StageBlockCurrentPositionSetter.SetEnable(false)
  end
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    StageBlockCurrentPositionSetter.SetEnable(true)StageBlockCurrentPositionSetter.DisablePosition()
    if e then
      while not StageBlock.LargeAndSmallBlocksAreEmpty()do
        coroutine.yield()
      end
    end
  end
end
function e.OnReload(n)
  for t,e in pairs(n)do
    if i(e.OnLoad)then
      e.OnLoad()
    end
    if i(e.Messages)then
      n[t]._messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
    end
  end
  if n.enemy then
    if t(n.enemy.routeSets)then
      TppClock.UnregisterClockMessage"ShiftChangeAtNight"TppClock.UnregisterClockMessage"ShiftChangeAtMorning"TppEnemy.RegisterRouteSet(n.enemy.routeSets)
      TppEnemy.MakeShiftChangeTable()
    end
  end
  for t,e in ipairs(Tpp._requireList)do
    if _G[e].OnReload then
      _G[e].OnReload(n)
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnReload()
  end
  if n.sequence then
    TppCheckPoint.RegisterCheckPointList(n.sequence.checkPointList)
  end
  e.SetUpdateFunction(n)
  e.SetMessageFunction(n)
end
function e.OnUpdate(e)
  local e
  local e=a
  local n=T
  local t=c
  for n=1,l do
    e[n]()
  end
  for e=1,o do
    n[e]()
  end
  P()
end
function e.OnChangeSVars(e,n,t)
  for i,e in ipairs(Tpp._requireList)do
    if _G[e].OnChangeSVars then
      _G[e].OnChangeSVars(n,t)
    end
  end
end
function e.SetMessageFunction(e)d={}s=0
  S={}p=0
  for n,e in ipairs(Tpp._requireList)do
    if _G[e].OnMessage then
      s=s+1
      d[s]=_G[e].OnMessage
    end
  end
  for n,t in pairs(e)do
    if e[n]._messageExecTable then
      p=p+1
      S[p]=e[n]._messageExecTable
    end
  end
end
function e.OnMessage(n,e,t,i,o,a,r)
  local n=mvars
  local l=""local T
  local c=Tpp.DoMessage
  local u=TppMission.CheckMessageOption
  local T=TppDebug
  local T=m
  local T=h
  local T=TppDefine.MESSAGE_GENERATION[e]and TppDefine.MESSAGE_GENERATION[e][t]
  if not T then
    T=TppDefine.DEFAULT_MESSAGE_GENERATION
  end
  local m=f()
  if m<T then
    return Mission.ON_MESSAGE_RESULT_RESEND
  end
  for s=1,s do
    local n=l
    d[s](e,t,i,o,a,r,n)
  end
  for s=1,p do
    local n=l
    c(S[s],u,e,t,i,o,a,r,n)
  end
  if n.loc_locationCommonTable then
    n.loc_locationCommonTable.OnMessage(e,t,i,o,a,r,l)
  end
  if n.order_box_script then
    n.order_box_script.OnMessage(e,t,i,o,a,r,l)
  end
  if n.animalBlockScript and n.animalBlockScript.OnMessage then
    n.animalBlockScript.OnMessage(e,t,i,o,a,r,l)
  end
end
function e.OnTerminate(e)
  if e.sequence then
    if i(e.sequence.OnTerminate)then
      e.sequence.OnTerminate()
    end
  end
end
return e
