-- DOBUILD: 1
local this={}
--LOCALOPT:
local Buttons=InfButton
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local Enum=TppDefine.Enum
local GetAssetConfig=AssetConfiguration.GetDefaultCategory

this.MAX_ANNOUNCE_STRING=256--tex sting length announcde log can handle before crashing the game, actually 288 but that worries me, so keep a little lower

--tex REFACTOR: most of these can be local
this.currentMenu=InfMenuDefs.heliSpaceMenu
this.currentMenuOptions=InfMenuDefs.heliSpaceMenu.options
this.topMenu=this.currentMenu
this.currentOption=1--tex lua tables are indexed from 1
this.previousMenuOption=1
this.currentSetting=0--tex settings from 0, to better fit variables
this.lastDisplay=0
this.autoDisplayDefault=2.8
this.autoRateHeld=0.85
this.autoDisplayRate=this.autoDisplayDefault
this.menuOn=false
this.toggleMenuHoldTime=1
this.toggleMenuButton=InfButton.EVADE
this.menuRightButton=InfButton.RIGHT
this.menuLeftButton=InfButton.LEFT
this.menuUpButton=InfButton.UP
this.menuDownButton=InfButton.DOWN
this.resetSettingButton=InfButton.CALL
this.menuBackButton=InfButton.STANCE

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
  this.currentSetting=modSetting.default or 0
  if modSetting.save then
    local gvar=gvars[modSetting.name]
    if gvar ~= nil then
      this.currentSetting=gvar
    else
      TppUiCommand.AnnounceLogView("Option Menu Error: gvar -"..modSetting.name.."- not found")
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
function this.ChangeSetting(setting,value,incrementMult)
  incrementMult = incrementMult or 1
  --TppUiCommand.AnnounceLogView("DBG:MNU: changesetting increment:"..value)--tex DEBUG: CULL:
  local newSetting=this.currentSetting

  local value=value*incrementMult
  if setting.isFloat==nil then
    if value > 0 then
      value=math.ceil(value)
    else
      value=math.floor(value)
    end
    --TppUiCommand.AnnounceLogView("DBG:MNU: newValue round:"..value)
  end

  if setting.save then
    --TppUiCommand.AnnounceLogView("DBG:MNU: found name:" .. modSetting.name)--tex DEBUG: CULL:
    local gvar=gvars[setting.name]
    if gvar ~= nil then
      --TppUiCommand.AnnounceLogView("DBG:MNU: gvar:" .. modSetting.name .. "=" .. gvar)--tex DEBUG: CULL:
      newSetting=this.IncrementSetting(gvar,value,setting.range.min,setting.range.max)
      if setting.skipValues ~= nil then
        while setting.skipValues[newSetting] do
          TppUiCommand.AnnounceLogView(newSetting .. " " .. this.LangString"setting_disallowed")--" is currently disallowed"
          newSetting=this.IncrementSetting(newSetting,value,setting.range.min,setting.range.max)
        end
      end
    else
      TppUiCommand.AnnounceLogView("Option Menu Error: gvar -" .. setting.name .. "- not found")
    end
    gvars[setting.name]=newSetting
    --TppUiCommand.AnnounceLogView("DBG:MNU: gvar set:" .. modSetting.name .. "=" .. gvar)--tex DEBUG: CULL:
    if IsFunc(setting.onChange) then
      setting:onChange()
    end
  else--gvar nil
    if setting.range~=nil then
      newSetting=this.currentSetting+value
      if value > 0 then
        if newSetting > setting.range.max then
          newSetting = setting.range.min
        end
      elseif value < 0 then
        if newSetting < setting.range.min then
          newSetting = setting.range.max
        end
      end
    end
    if IsFunc(setting.onChange) then
      setting:onChange()
    end
  end
  --TppUiCommand.AnnounceLogView("DBG:MNU: new currentSetting:" .. newSetting)--tex DEBUG: CULL:
  return newSetting
end
function this.SetCurrent()
  this.SetSetting(this.currentMenuOptions[this.currentOption],this.currentSetting)
end
function this.SetSetting(setting,value)
  if setting.save then
    local gvar=gvars[setting.name]
    if gvar then
      gvars[setting.name]=value
      if IsFunc(setting.onChange) then
        setting:onChange()
      end
    end
  end
end
function this.NextSetting(incrementMult)
  local modSetting=this.currentMenuOptions[this.currentOption]
  if modSetting.options~=nil then--tex menu
    this.GoMenu(modSetting)
  else
    this.currentSetting=this.ChangeSetting(modSetting,modSetting.range.increment,incrementMult)
  end
end
function this.PreviousSetting(incrementMult)
  local modSetting=this.currentMenuOptions[this.currentOption]
  this.currentSetting=this.ChangeSetting(modSetting,-modSetting.range.increment,incrementMult)
end

function this.GoMenu(menu,goBack)
  if not goBack and menu ~= this.topMenu then
    menu.parent=this.currentMenu
    menu.parentOption=this.currentOption
  end
  
  if goBack then
      this.currentOption=this.currentMenu.parentOption
  else
      this.currentOption=1
  end
  this.currentMenu=menu
  this.currentMenuOptions=menu.options
  this.GetSetting()
  if this.currentMenu.name and this.menuOn then
    this.AnnounceLogLangId(this.currentMenu.name)
  end
  --if menu.parent==nil then CULL:
   -- TppUiCommand.AnnounceLogView("Option Menu Error: parent = nil")
  --end
end
function this.GoBackCurrent()
  if this.currentMenu.parent==nil then
    if this.currentMenu~=this.topMenu then
      TppUiCommand.AnnounceLogView("Option Menu Error: parent = nil")
    end
    return
  end
  this.GoMenu(this.currentMenu.parent,true)
end

--tex display settings
function this.DisplayCurrentSetting()
  if this.menuOn then
    this.DisplaySetting(this.currentOption)
  end
end

local optionSeperators={
  equals=" = ",
  menu=" >>",
}
function this.DisplaySetting(optionIndex)
  this.lastDisplay=Time.GetRawElapsedTimeSinceStartUp()
  local modSetting=this.currentMenuOptions[optionIndex]
  local settingText=""
  local optionSeperator=optionSeperators.equals
  local settingNames=modSetting.settingNames or modSetting.settings
  if settingNames then
    if this.currentSetting < 0 or this.currentSetting > #settingNames-1 then
      settingText="currentSetting out of settingNames bounds"
    elseif IsTable(settingNames) then--old style direct non localized table
      settingText=this.currentSetting..":"..settingNames[this.currentSetting+1]--tex lua indexed from 1, but settings from 0
    else
      settingText=this.LangTableString(settingNames,this.currentSetting+1)--tex lua indexed from 1, but settings from 0
    end
  elseif modSetting.isFloat then
    settingText=math.floor(100*this.currentSetting) .. "%"
  elseif modSetting.options~=nil then--tex menu
    settingText=""
    optionSeperator=optionSeperators.menu
  else
    settingText=tostring(this.currentSetting)
  end
  TppUiCommand.AnnounceLogDelayTime(0)
  local settingName = this.LangString(modSetting.name)
  TppUiCommand.AnnounceLogView(optionIndex..":"..settingName..optionSeperator..settingText)
end
function this.DisplaySettings()--tex display all
  for i=1,#this.currentMenuOptions do
    this.DisplaySetting(i)
  end
end
function this.DisplayProfileChangedToCustom(profile)
  TppUiCommand.AnnounceLogView("Profile "..this.LangString(profile.name).." set to Custom")--DEBUGNOW: ADDLANG:
end
function this.AutoDisplay()
  if this.autoDisplayRate > 0 then
    if Time.GetRawElapsedTimeSinceStartUp() - this.lastDisplay > this.autoDisplayRate then
      this.DisplayCurrentSetting()
    end
  end
end
function this.DisplayHelpText()
  local modSetting=this.currentMenuOptions[this.currentOption]
  if modSetting.helpText ~= nil then
    --this.lastDisplay=Time.GetRawElapsedTimeSinceStartUp()
    TppUiCommand.AnnounceLogView(modSetting.helpText)--ADDLANG:
  end
end
function this.ResetSetting()
  local setting=this.currentMenuOptions[this.currentOption]
  if setting.save then
    gvars[setting.name]=setting.default
    this.currentSetting=setting.default
    if IsFunc(setting.onChange) then
      setting:onChange()
    end
  end
end
function this.ResetSettings()
  for n,menu in ipairs(InfMenuDefs.allMenus) do
    for m,setting in ipairs(menu.options) do
      if setting.save then
        gvars[setting.name]=setting.default
        if IsFunc(setting.onChange) then
          setting:onChange()
        end
      end
    end
  end
end
function this.ResetSettingsDisplay()
  this.AnnounceLogLangId"setting_defaults"--"Setting mod options to defaults..."
  for i=1,#this.currentMenuOptions do
    local modSetting=this.currentMenuOptions[i]
    if modSetting.save then
      gvars[modSetting.name]=modSetting.default
      this.currentSetting=modSetting.default
      this.DisplaySetting(i)
    end
  end
  this.GetSetting()
end

function this.MenuOff()
  this.menuOn=false
  this.AnnounceLogLangId"menu_off"--"Menu Off"
end

local function ToggleMenu()--TODO: break out
  this.menuOn = not this.menuOn
  if this.menuOn then
    this.GetSetting()
    TppUiCommand.AnnounceLogView(InfMain.modName.." "..InfMain.modVersion.." ".. this.LangString"menu_open_help")--(Press Up/Down,Left/Right to navigate menu)
  else
    this.MenuOff()
  end
end

--tex my own shizzy langid stuff since games is too limitied
function this.LangString(langId)
  if langId==nil or langId=="" then
    TppUiCommand.AnnounceLogView"AnnounceLogLangId langId empty"
    return ""
  end
  local languageCode=GetAssetConfig"Language"
  if gvars.langOverride == 1 then--Cht over Jpn
    if languageCode=="jpn" then
      languageCode="cht"
    end
  end
  
  if InfLang[languageCode]==nil then
    --TppUiCommand.AnnounceLogView("no lang in inflang")
    languageCode="eng"
  end
  local langString=InfLang[languageCode][langId]
  if (langString==nil or langString=="") and languageCode~="eng" then
    --TppUiCommand.AnnounceLogView("no langstring for " .. languageCode)
    langString=InfLang.eng[langId]
  end

  if langString==nil or langString=="" then
    --TppUiCommand.AnnounceLogView"AnnounceLogLangId langString empty"
    return langId
  end

  return langString
end

function this.LangTableString(langId,index)--remember lua tables from 1
  if langId==nil or langId=="" then
    TppUiCommand.AnnounceLogView"AnnounceLogLangId langId empty"
    return ""
end
local languageCode=GetAssetConfig"Language"
if InfLang[languageCode]==nil then
  --TppUiCommand.AnnounceLogView("no lang in inflang")
  languageCode="eng"
end
local langTable=InfLang[languageCode][langId]
if (langTable==nil or langTable=="" or not IsTable(langTable)) and languageCode~="eng" then
  --TppUiCommand.AnnounceLogView("no langTable for " .. languageCode)
  langTable=InfLang.eng[langId]
end

if langTable==nil or langTable=="" or not IsTable(langTable) then
  --TppUiCommand.AnnounceLogView"AnnounceLogLangId langTable empty"
  return langId .. ":" .. index
end

if index < 1 or index > #langTable then
  --TppUiCommand.AnnounceLogView("LangTableString - index for " .. langId " out of bounds")
  return langId .. " OUTOFBOUNDS:" .. index
end

return langTable[index]
end

function this.AnnounceLogLangId(langId)
  TppUiCommand.AnnounceLogView(this.LangString(langId))
end

function this.Update()
  --local debugSplash=SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
  --SplashScreen.Show(debugSplash,0,0.3,0)--tex eagle
  this.ModStart()--TODO: move to actual run once on startup init thing, make sure to check ModStart itself to see affected code
  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end
  InfButton.UpdateHeld()
  if not mvars.mis_missionStateIsNotInGame then--tex actually loaded game, ie at least 'continued' from title screen
    --tex RETRY: still not happy, want to read menu status but cant find a way
    local inHeliSpace = TppMission.IsHelicopterSpace(vars.missionCode)
    if inHeliSpace then
      if this.topMenu~=InfMenuDefs.heliSpaceMenu then
        this.topMenu=InfMenuDefs.heliSpaceMenu
        this.GoMenu(this.topMenu)
      end
    else--!ishelispace
      if this.topMenu~=InfMenuDefs.inMissionMenu then
        this.topMenu=InfMenuDefs.inMissionMenu
        this.GoMenu(this.topMenu)
      end
    end

    if InfButton.OnButtonHoldTime(this.toggleMenuButton) then
      local playerVehicleId=vars.playerVehicleGameObjectId
      local onHorse = false
      if not inHeliSpace then
        onHorse = Tpp.IsHorse(playerVehicleId)
      end
      if not onHorse then
        ToggleMenu()
      end
    end

    if this.menuOn then
      --TODO: figure out a way to check better, see general feature do.txt
      if InfButton.OnButtonDown(InfButton.MB_DEVICE) then
        this.MenuOff()
      end

      if InfButton.OnButtonDown(this.toggleMenuButton) then--update gvar of current
        this.SetCurrent()
        this.DisplayCurrentSetting()
      end
      if InfButton.OnButtonDown(this.menuUpButton) then
        this.PreviousOption()
        this.DisplayCurrentSetting()
      end
      if InfButton.OnButtonDown(this.menuDownButton) then
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
        this.AnnounceLogLangId"setting_default"--"Setting to default.."
        this.DisplayCurrentSetting()
      end
      if InfButton.OnButtonDown(this.menuBackButton) then
        this.GoBackCurrent()
      end

      this.AutoDisplay()
    end--!menuOn
  else--!ingame
    this.menuOn = false
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
  TppUiCommand.AnnounceLogView(InfMain.modName .. " r" .. InfMain.modVersion)--ADDLANG:
  TppUiCommand.AnnounceLogView("Hold X key or Dpad Right for 1 second to enable menu")--ADDLANG:
end
function this.ModMissionMessage()
  TppUiCommand.AnnounceLogView("ModMissionMessage test")--ADDLANG
end

return this
