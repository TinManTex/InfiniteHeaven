-- DOBUILD: 1
--tex SYS: mod menu
local this={}
--local debugSplash=SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
--SplashScreen.Show(debugSplash,0,0.3,0)--tex eagle

--tex strings, till we figure out how to access custom values in .lang files this will have to do.
--tex SYNC: with uses of TppUiCommand.AnnounceLogView
this.modStrings={
  menuOff="Menu Off",
  settingDefaults="Setting mod options to defaults...",
  settingDisallowed=" is currently disallowed"
}
--LOCALOPT:
local Buttons=InfButton
local IsFunc=Tpp.IsTypeFunc
local Enum=TppDefine.Enum

this.switchSlider={max=1,min=0,increment=1}
this.healthMultSlider={max=4,min=0,increment=0.2}
this.switchSettingNames={"Off","On"}

local menuItemMenuOff={
  name="Turn off menu",
  default=0,
  slider=this.switchSlider,
  settingNames={">","Off"},
  onChange=function()
    this.ModMenuOff()
    this.currentOption=1
  end,
}
local menuItemResetSettings={
  name="Reset all settings",
  default=0,
  slider=this.switchSlider,
  settingNames={">","Reset"},
  onChange=function()
    this.ResetSettingsDisplay()
    this.ModMenuOff()
  end,
}
local menuItemGoBack={
  name="Menu Back",
  default=0,
  slider=this.switchSlider,
  settingNames={">","Back"},
  onChange=function()
    this.GoBackCurrent()
  end,
}

local parametersMenu={
  name="Parameters Menu",
  parent=nil,
  default=0,
  --onChange=this.GoMenu(patchupMenu),
  --[[slider=this.switchSlider,
  settingNames={">","Returned"},--]]
  options={
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
    menuItemResetSettings,
    menuItemGoBack,
  }
}
local motherBaseMenu={
  name="Mother Base Menu",
  parent=nil,
  default=0,
  options={
    {
      name="DD Equip Grade",
      gvarName="mbSoldierEquipGrade",
      default=0,
      slider={max=InfMain.SETTING_MB_EQUIPGRADE.MAX-1,min=0,increment=1},
      settingNames={"Off","Current MB Dev","Random","Grade 1","Grade 2","Grade 3","Grade 4","Grade 5","Grade 6","Grade 7","Grade 8","Grade 9","Grade 10"},--SYNC: SETTING_MB_EQUIPGRADE
      onChange=function()--DEPENDENCY: mbPlayTime
        if gvars.mbSoldierEquipGrade==0 then
          gvars.mbPlayTime=0
        elseif gvars.mbSoldierEquipGrade>0 then
          gvars.mbPlayTime=1
        end
      end
    },
    {
      name="DD Equip Range",
      gvarName="mbSoldierEquipRange",
      default=0,
      slider={max=InfMain.SETTING_MB_EQUIPRANGE.MAX-1,min=0,increment=1},
      settingNames={"Default (FOB Setting)", "All Short", "All Medium","All Long","Random"},
    },
    {
      name="DD Suit (Requires Equip Grade On)",
      gvarName="mbDDSuit",
      default=0,
      slider={max=InfMain.SETTING_MB_DD_SUITS.MAX-1,min=0,increment=1},
      settingNames={"Use Equip Grade", "Tiger","Sneaking","Battle Dress","PF Riot Suit"},
    },
    --[[{
      name="DD Balaclava",
      gvarName="mbDDBalaclava",
      default=0,
      slider=this.switchSlider,
      settingNames={"Use Equip Grade", "Force Off"},
    },--]]
    {
      name="Mother Base War Games",
      gvarName="mbWarGames",
      default=0,
      slider={max=2,min=0,increment=1},
      settingNames={"Off","DD Non Lethal","DD Lethal"},
    },
    --[[{
      name="Motherbase playtime REF: CULL: REFACTOR: this is not a user control, just a depenant switch",
      gvarName="mbPlayTime",
      default=0,
      slider={max=1,min=0,increment=1},
      settingNames={"Off","ZZZZZZZZZZZZt"},
    },--]]
    menuItemResetSettings,
    menuItemGoBack,
  }
}
local patchupMenu={
  name="Patchup Menu",
  parent=nil,
  default=0,
  --onChange=this.GoMenu(patchupMenu),
  --[[slider=this.switchSlider,
  settingNames={">","Returned"},--]]
  options={
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
    menuItemGoBack,
  }
}

this.mainMenu={
  name="Main Menu",
  parent=nil,
  options={
    {
      name="Subsistence Mode",
      gvarName="isManualSubsistence",
      default=0,
      slider={max=2,min=0,increment=1},
      settingNames={"Off","Pure (OSP -Items -Hand -Suit -Support -Fulton -Vehicle -Buddy)","Bounder (Pure +Buddy +Suit +Fulton)"},
      onChange=function()--DEPENDENCY: isManualSubsistence, subsistenceLoadout. noCentralLzs
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
      slider={max=#InfMain.subsistenceLoadouts,min=0,increment=1},
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
    --[[{
      name="LZ Waveoff (periodically disable random landing zones)",
      gvarName="landingZoneWaveOff",
      default=1,
      slider={max=1,min=0,increment=0.2},
      isFloatSetting=true,
    },--]]
    {
      name="Unlock random Sideops for areas",
      gvarName="unlockSideOps",
      default=0,
      slider={max=(InfMain.SETTING_UNLOCK_SIDEOPS.MAX-1),min=0,increment=1},
      settingNames={"Off","Force Replayable","Force Open"},--SYNC: SETTING_UNLOCK_SIDEOPS enum
      helpText="Sideops are broken into areas to stop overlap, this setting lets you control the choice of sideop within the area.",
      onChange=function()
        TppQuest.UpdateActiveQuest()
      end,
    },
    {
      name="Open specific sideop #",
      gvarName="unlockSideOpNumber",
      default=0,
      slider={max=InfMain.numQuests,min=0,increment=1},
      skipValues=InfMain.disallowSideOps,
      onChange=function()
        TppQuest.UpdateActiveQuest()
      end,
    },
    parametersMenu,
    motherBaseMenu,
    patchupMenu,
    --[[--tex cant get startoffline to read in init sequence, yet isnewgame seems to be fine? (well haven't checked, it is read as if it is).
    {
      name="Start Offline",
      gvarName="startOffline",
      default=0,
      slider=this.switchSlider,
      settingNames={"False","True"},
    },--]]
    menuItemResetSettings,
    menuItemMenuOff
  }
}

this.allMenus={
  this.mainMenu,
  parametersMenu,
  motherBaseMenu,
  patchupMenu,
}

--tex REFACTOR: most of these can be local
this.currentMenu=this.mainMenu
this.currentMenuOptions=this.mainMenu.options
this.currentOption=1--tex lua tables are indexed from 1
this.currentSetting=0--tex settings from 0, to better fit variables
this.lastDisplay=0
this.autoDisplayDefault=2.8
this.autoRateHeld=0.85
this.autoDisplayRate=this.autoDisplayDefault
this.modMenuOn=false
this.toggleMenuButton=PlayerPad.RELOAD
this.toggleMenuHoldTime=1
this.menuRightButton=PlayerPad.RIGHT
this.menuLeftButton=PlayerPad.LEFT
this.menuUpButton=PlayerPad.UP
this.menuDownButton=PlayerPad.DOWN
this.resetSettingButton=PlayerPad.CALL
this.menuBackButton=PlayerPad.STANCE

--tex mod settings menu manipulation
function this.NextOption()
  this.currentOption=this.currentOption+1
  if this.currentOption > #this.currentMenuOptions then
    this.currentOption = 1
  end
  this.GetSetting()
end
function this.PreviousOption()
  this.currentOption = this.currentOption-1
  if this.currentOption < 1 then
    this.currentOption = #this.currentMenuOptions
  end
  this.GetSetting()
end
function this.GetSetting()
  local modSetting=this.currentMenuOptions[this.currentOption]
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
function this.IsCurrentOptionMenu()
  local modSetting=this.currentMenuOptions[this.currentOption]
  if modSetting.options~=nil then
    return true
  end
  return false  
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
function this.ChangeSetting(modSetting,value,incrementMult)
  incrementMult = incrementMult or 1
  --TppUiCommand.AnnounceLogView("DBG:MNU: changesetting increment:"..value)--tex DEBUG: CULL:
  local newSetting=this.currentSetting

  local value=value*incrementMult
  if modSetting.isFloatSetting==nil then
    if value > 0 then
      value=math.ceil(value)
    else
      value=math.floor(value)
    end
    --TppUiCommand.AnnounceLogView("DBG:MNU: newValue round:"..value)
  end
  
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
    if modSetting.slider~=nil then
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
    end
    if IsFunc(modSetting.onChange) then
      modSetting.onChange()
    end
  end
  --TppUiCommand.AnnounceLogView("DBG:MNU: new currentSetting:" .. newSetting)--tex DEBUG: CULL:
  return newSetting
end
function this.ConfirmCurrent()
  this.ConfirmSetting(this.currentMenuOptions[this.currentOption],this.currentSetting)
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
  this.SetSetting(this.currentMenuOptions[this.currentOption],this.currentSetting)
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
function this.NextSetting(incrementMult)
  local modSetting=this.currentMenuOptions[this.currentOption]
  if modSetting.options~=nil then--tex menu
    this.GoMenu(modSetting)
  else
    this.currentSetting=this.ChangeSetting(modSetting,modSetting.slider.increment,incrementMult)
  end
end
function this.PreviousSetting(incrementMult)
  local modSetting=this.currentMenuOptions[this.currentOption]
  this.currentSetting=this.ChangeSetting(modSetting,-modSetting.slider.increment,incrementMult)
end

function this.GoMenu(menu)
  menu.parent=this.currentMenu
  this.currentMenu=menu
  this.currentMenuOptions=menu.options
  this.currentOption=1
  this.GetSetting()
  if menu.name then
    TppUiCommand.AnnounceLogView(menu.name)
  end
  TppUiCommand.AnnounceLogView()
  if menu.parent==nil then
    TppUiCommand.AnnounceLogView("Option Menu Error: parent = nil")
  end
end
function this.GoBack(menu)
  if menu.parent==nil then
    TppUiCommand.AnnounceLogView("Option Menu Error: parent = nil")
    return
  end
  this.GoMenu(menu.parent)
end
function this.GoBackCurrent()
  if this.currentMenu.parent==nil then
    if this.currentMenu~=this.mainMenu then
      TppUiCommand.AnnounceLogView("Option Menu Error: parent = nil")
    end
    return
  end
  this.GoMenu(this.currentMenu.parent)
end

--tex display settings
function this.DisplayCurrentSetting()
  if this.modMenuOn then
    this.DisplaySetting(this.currentOption)
  end
end
function this.DisplaySetting(optionIndex)
  this.lastDisplay=Time.GetRawElapsedTimeSinceStartUp()
  local modSetting=this.currentMenuOptions[optionIndex]
  local settingText="UNDEFINED"
  if modSetting.settingNames ~= nil then
    if this.currentSetting < 0 or this.currentSetting > #modSetting.settingNames-1 then
      settingText="CURRENTSETTING OUT OF BOUNDS"
    else
      settingText="= "..modSetting.settingNames[this.currentSetting+1]--tex lua indexed from 1, but settings from 0
      if modSetting.confirm ~= nil then
        if this.currentSetting ~= modSetting.default then
          if modSetting.gvarName ~= nil and gvars[modSetting.gvarName] ~= nil then
            if gvars[modSetting.gvarName] ~= this.currentSetting then
              settingText=settingText.." (Press<Reload> to confirm)"
            else--tex ASSUMPTION: SPECIAL: setting text is "Enable"
              settingText="= "..modSetting.confirm
            end
          end
        end
      end
    end
  elseif modSetting.isFloatSetting then
    settingText="= "..math.floor(100*this.currentSetting) .. "%"
  elseif modSetting.options~=nil then--tex menu
    settingText=">>"
  else
    settingText="= "..tostring(this.currentSetting)
  end
  local info = 0
  if IsFunc(modSetting.infoFunc) then
    info = modSetting.infoFunc()
  end
  TppUiCommand.AnnounceLogDelayTime(0)
  TppUiCommand.AnnounceLogView(optionIndex..":"..modSetting.name.." "..settingText)--tex thank you ThreeSocks3, you're a god damn legend for finding custom text output, heres a better way to do things than string.format, in lua .. concatenates strings, does simple format conversion
end
function this.DisplaySettings()--tex display all
  for i=1,#this.currentMenuOptions do
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
  local modSetting=this.currentMenuOptions[this.currentOption]
  if modSetting.helpText ~= nil then
    --this.lastDisplay=Time.GetRawElapsedTimeSinceStartUp()
    TppUiCommand.AnnounceLogView(modSetting.helpText)
  end
end
function this.ResetSetting()
  local modSetting=this.currentMenuOptions[this.currentOption]
  if modSetting.gvarName~=nil then
    gvars[modSetting.gvarName]=modSetting.default
    this.currentSetting=modSetting.default
  end
end
function this.ResetSettings()
  for n,menu in ipairs(this.allMenus) do
    for m,modSetting in ipairs(menu.options) do
      if modSetting.gvarName~=nil then
        gvars[modSetting.gvarName]=modSetting.default
      end
    end
  end
end
function this.ResetSettingsDisplay()
  TppUiCommand.AnnounceLogView(this.modStrings.settingDefaults)--tex "Setting mod options to defaults..."
  for i=1,#this.currentMenuOptions do
    local modSetting=this.currentMenuOptions[i]
    if modSetting.gvarName~=nil then
      gvars[modSetting.gvarName]=modSetting.default
      this.currentSetting=modSetting.default
      this.DisplaySetting(i)
    end
  end
  this.GetSetting()
end

--
function this.ModMenuOff()
  this.modMenuOn=false
  TppUiCommand.AnnounceLogView(this.modStrings.menuOff)
end
function this.UpdateModMenu()
  --local debugSplash=SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
  --SplashScreen.Show(debugSplash,0,0.3,0)--tex eagle
  this.ModStart()--tex: TODO: move to actual run once on startup init thing, make sure to check ModStart itself to see affected code
  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end
  InfButton.UpdateHeld()
  if not mvars.mis_missionStateIsNotInGame then--tex actually loaded game, ie at least 'continued' from title screen
    if TppMission.IsHelicopterSpace(vars.missionCode)then
      --tex RETRY: still not happy, want to read menu status but cant find any way
      if InfButton.OnButtonHoldTime(this.toggleMenuButton) then
        this.modMenuOn = not this.modMenuOn
        if this.modMenuOn then
          this.GetSetting()
          TppUiCommand.AnnounceLogView(InfMain.modName.." "..InfMain.modVersion.." (Press Up/Down,Left/Right to navigate menu)")
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
        
        InfButton.ButtonRepeatReset(this.menuRightButton)
        if InfButton.OnButtonDown(this.menuRightButton) then
          this.NextSetting()
          this.DisplayCurrentSetting()
        elseif InfButton.OnButtonUp(this.menuRightButton) then
          this.autoDisplayRate=this.autoDisplayDefault
        elseif InfButton.OnButtonRepeat(this.menuRightButton) then
          this.autoDisplayRate=this.autoRateHeld
          this.NextSetting(InfButton.GetRepeatMult())
        end

        InfButton.ButtonRepeatReset(this.menuLeftButton)
        if InfButton.OnButtonDown(this.menuLeftButton) then
          this.PreviousSetting()
          this.DisplayCurrentSetting()
        elseif InfButton.OnButtonUp(this.menuLeftButton) then
          this.autoDisplayRate=this.autoDisplayDefault
        elseif InfButton.OnButtonRepeat(this.menuLeftButton) then
          this.autoDisplayRate=this.autoRateHeld
          this.PreviousSetting(InfButton.GetRepeatMult())
        end

        if InfButton.OnButtonDown(this.resetSettingButton) then
          this.ResetSetting()
          TppUiCommand.AnnounceLogView"Setting to default.."
          this.DisplayCurrentSetting()
        end
        if InfButton.OnButtonDown(this.menuBackButton) then
          this.GoBackCurrent()
        end
      end
      this.AutoDisplay()
  else--!ishelispace
    this.modMenuOn = false
    --[[if InfMain.DEBUGMODE then
        if InfButton.OnButtonDown(PlayerPad.LIGHT_SWITCH) then
          TppUiCommand.AnnounceLogView("")
        end
      end--]]
  end
  else--!ingame
    this.modMenuOn = false
  end
  InfButton.UpdatePressed()--tex GOTCHA: should be after all key reads, sets current keys to prev keys for onbutton checks
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
  TppUiCommand.AnnounceLogView(InfMain.modName .. " " .. InfMain.modVersion)
  TppUiCommand.AnnounceLogView("Hold X key or Dpad Right for 1 second to enable menu")--tex TODO: modstring
end
function this.ModMissionMessage()
  TppUiCommand.AnnounceLogView("ModMissionMessage test")--tex TODO: modstring
end

return this
