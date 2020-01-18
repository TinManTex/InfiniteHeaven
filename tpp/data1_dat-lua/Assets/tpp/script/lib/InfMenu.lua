-- DOBUILD: 1
--tex SYS: mod menu
local this={}
--local debugSplash=SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
--SplashScreen.Show(debugSplash,0,0.3,0)--tex eagle
this.DEBUGMODE=false
this.modVersion = "r44"
this.modName = "Infinite Heaven"
--tex strings, till we figure out how to access custom values in .lang files this will have to do.
--tex SYNC: with uses of TppUiCommand.AnnounceLogView
this.modStrings={
  menuOff="Menu Off",
  settingDefaults="Setting mod options to defaults...",
  settingDisallowed=" is currently disallowed"
}
--tex LOCALOPT:
local IsFunc=Tpp.IsTypeFunc
local Enum=TppDefine.Enum
--tex mod settings setup
this.subsistenceLoadouts={--tex pure,secondary.
  TppDefine.CYPR_PLAYER_INITIAL_WEAPON_TABLE,
  TppDefine.SUBSISTENCE_SECONDARY_INITIAL_WEAPON_TABLE
}
this.numQuests=157--tex added SYNC: number of quests REFACTOR: better place, but hangs modsettings if in tppdefine or tppquest
this.SETTING_SUBSISTENCE_PROFILE=Enum{"OFF","PURE","BOUNDER"}--tex SYNC: isManualSubsistence setting names
this.SETTING_UNLOCK_SIDEOPS=Enum{"OFF","REPOP","OPEN","MAX"}--tex SYNC: unlocksideops setting names TODO: overhaul, rectify with sliders
this.switchSlider={max=1,min=0,increment=1}
this.healthMultSlider={max=4,min=0,increment=0.2}
this.switchSettingNames={"Off","On"}
this.disallowSideOps={[144]=true};
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
    onChange=function()--tex DEPENDENCY: isManualSubsistence, subsistenceLoadout. noCentralLzs
      if gvars.isManualSubsistence==0 then
        gvars.subsistenceLoadout=0
        gvars.noCentralLzs=0
      elseif gvars.subsistenceLoadout==0 then
        gvars.subsistenceLoadout=1
        gvars.noCentralLzs=1
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
  --[[{
    name="No Central Lzs",
    gvarName="noCentralLzs",
    default=0,
    slider=this.switchSlider,
  },--]]
  --[[
  {
    name="LZ Waveoff (periodically disable random landing zones)",
    gvarName="landingZoneWaveOff",
    default=1,
    slider={max=1,min=0,increment=0.2},
    isFloatSetting=true,
  },--]]
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
    slider={max=(this.SETTING_UNLOCK_SIDEOPS.MAX-1),min=0,increment=1},
    settingNames={"Off","Force Replayable","Force Open"},--[[--tex SYNC: SETTING_UNLOCK_SIDEOPS enum--]]
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
    skipValues=this.disallowSideOps,
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
          InfPatch.QuietReturn()
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
  InfButton.UpdateHeldButtons()
  if not mvars.mis_missionStateIsNotInGame then--tex actually loaded game, ie at least 'continued' from title screen  
    if TppMission.IsHelicopterSpace(vars.missionCode)then
      --tex RETRY: still not happy, want to read menu status but cant find any way
      if InfButton.OnButtonHoldTime(this.toggleMenuButton) then
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
      end--togglemenu
      if this.modMenuOn then
        if InfButton.OnButtonDown(PlayerPad.MB_DEVICE) then
          this.ModMenuOff()
        end
        if InfButton.OnButtonDown(this.toggleMenuButton) then
          this.SetCurrent()
          this.DisplayCurrentSetting()
        end 
        if InfButton.OnButtonDown(PlayerPad.UP) then
          this.PreviousOption()
          this.DisplayCurrentSetting()
        end
        if InfButton.OnButtonDown(PlayerPad.DOWN) then
          this.NextOption()
          this.DisplayCurrentSetting()
        end
        
        if InfButton.OnButtonDown(this.menuRightButton) then
          this.NextSetting()
          this.DisplayCurrentSetting()
        elseif InfButton.OnButtonUp(this.menuRightButton) then
          this.autoDisplayRate=this.autoDisplayDefault
        elseif InfButton.OnButtonRepeat(this.menuRightButton) then          
          this.autoDisplayRate=this.autoRateHeld
          this.NextSetting()
        end
        
        if InfButton.OnButtonDown(this.menuLeftButton) then
          this.PreviousSetting()
          this.DisplayCurrentSetting()
        elseif InfButton.OnButtonUp(this.menuLeftButton) then
          this.autoDisplayRate=this.autoDisplayDefault
        elseif InfButton.OnButtonRepeat(this.menuLeftButton) then         
          this.autoDisplayRate=this.autoRateHeld
          this.PreviousSetting()
        end
        
        if InfButton.OnButtonDown(this.resetSettingButton) then
          this.ResetSetting()
          TppUiCommand.AnnounceLogView"Setting to default.."
          this.DisplayCurrentSetting()
        end
      end     
      this.AutoDisplay()  
    else--!ishelispace
      this.modMenuOn = false
      --[[if this.DEBUGMODE then
        if InfButton.OnButtonDown(PlayerPad.LIGHT_SWITCH) then
          TppUiCommand.AnnounceLogView("")
        end
      end--]]
    end
  else--!ingame
    this.modMenuOn = false
  end  
  InfButton.UpdatePressedButtons()--tex GOTCHA: should be after all key reads, sets current keys to prev keys for onbutton checks
--local debugSplash=SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5020_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
--SplashScreen.Show(debugSplash,0,0.3,0)--tex dog
end
function this.ModStart()--tex currently called from UpdateModMenu, RETRY: find an actual place for on start/run once init.
  gvars.isManualHard = false--tex PATCHUP: not currently exposed to mod menu, force off to patch those that might have saves from prior mod with it on 
  InfButton.buttonStates[this.toggleMenuButton].holdTime=this.toggleMenuHoldTime--tex set up hold buttons
  InfButton.buttonStates[this.menuRightButton].decrement=0.1
  InfButton.buttonStates[this.menuLeftButton].decrement=0.1
end
function this.ModWelcome()
  TppUiCommand.AnnounceLogView(this.modName .. " " .. this.modVersion)
  TppUiCommand.AnnounceLogView("Hold X key or Dpad Right for 1 second to enable menu")--tex TODO: modstring
end
function this.ModMissionMessage()
  TppUiCommand.AnnounceLogView("ModMissionMessage test")--tex TODO: modstring
end

return this