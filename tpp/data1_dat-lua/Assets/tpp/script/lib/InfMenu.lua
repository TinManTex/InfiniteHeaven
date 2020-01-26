-- DOBUILD: 1
local this={}
--LOCALOPT:
local InfButton=InfButton
local InfMain=InfMain
local InfLang=InfLang
local Ivars=Ivars
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local Enum=TppDefine.Enum
local GetAssetConfig=AssetConfiguration.GetDefaultCategory
local TppUiCommand=TppUiCommand

this.MAX_ANNOUNCE_STRING=255 --288--tex sting length announce log can handle before crashing the game, a bit worried that it's actually kind of a random value at 288 (and yeah I manually worked this value out by adjusting a string and reloading and crashing the game till I got it exact lol).

--tex REFACTOR: most of these can be local
this.currentMenu=InfMenuDefs.heliSpaceMenu
this.currentMenuOptions=InfMenuDefs.heliSpaceMenu.options
this.topMenu=this.currentMenu
this.currentIndex=1--tex lua tables are indexed from 1
this.currentDepth=0
this.lastDisplay=0
this.autoDisplayDefault=2.8
this.autoRateHeld=0.85
this.autoDisplayRate=this.autoDisplayDefault
this.menuOn=false
this.toggleMenuHoldTime=1.25
this.toggleMenuButton=InfButton.EVADE--SYNC: InfLang "menu_keys"
this.menuRightButton=InfButton.RIGHT
this.menuLeftButton=InfButton.LEFT
this.menuUpButton=InfButton.UP
this.menuDownButton=InfButton.DOWN
this.resetSettingButton=InfButton.CALL
this.menuBackButton=InfButton.STANCE
this.activateSettingButton=InfButton.ACTION

this.lastAutoDisplayString=""
this.maxAutoDisplayRepeat=3

--tex mod settings menu manipulation
function this.NextOption()
  local oldIndex=this.currentIndex
  this.currentIndex=this.currentIndex+1
  if this.currentIndex > #this.currentMenuOptions then
    this.currentIndex = 1
  end
  this.GetSetting(oldIndex)
end
function this.PreviousOption()
  local oldIndex=this.currentIndex
  this.currentIndex = this.currentIndex-1
  if this.currentIndex < 1 then
    this.currentIndex = #this.currentMenuOptions
  end
  this.GetSetting(oldIndex)
end
function this.GetSetting(previousIndex,previousMenuOptions)
  if this.currentMenuOptions==nil then
    InfMenu.DebugPrint("WARNING: currentMenuOptions == nil!")--DEBUG
    return
  end

  --WIP
  --  if previousIndex then
  --    local menuOptions=previousMenuOptions or this.currentMenuOptions
  --    local previousOption=this.menuOptions[this.previousIndex]
  --    if previousOption then
  --      if IsFunc(previousOption.OnDeselect) then
  --        previousOption:OnDeselect()
  --      end
  --    else
  --      InfMenu.DebugPrint"InfMenu.GetSetting - no previousOption for previousIndex"--DEBUG
  --    end
  --  end

  local option=this.currentMenuOptions[this.currentIndex]

  --  for k,v in pairs(this.currentMenuOptions)do--DEBUG
  --    InfMenu.DebugPrint("currentMenuOptions "..tostring(k).." "..tostring(v))
  --  end--<

  if option==nil then
    InfMenu.DebugPrint("WARNING: option == nil! currentIndex="..tostring(this.currentIndex))--DEBUG
    return
  end

  if option.save then
    local gvar=gvars[option.name]
    if gvar~=nil then
      option.setting=gvar
    else
      TppUiCommand.AnnounceLogView("Option Menu Error: gvar -"..option.name.."- not found")
    end
  end
  if IsFunc(option.OnSelect) then
    option:OnSelect()
  end
end

function this.IscurrentIndexMenu()
  local option=this.currentMenuOptions[this.currentIndex]
  if option.options~=nil then
    return true
  end
  return false
end

--tex takes a table of numbers and number ranges, ex: {1,5,{6-10},{14-20}}
--returns the next valid for a given value
--I'm obviously no mathmagitian
function this.NextInRange(rangeTable,value,direction)
  local bottom=1
  local top=#rangeTable

  local start
  if direction>0 then
    start=bottom
  else
    start=top
  end
  local ending
  if direction>0 then
    ending=top
  else
    ending=bottom
  end

  for i=start,ending,direction do
    local range=rangeTable[i]
    local low, hi
    --tex check direct match
    if value >= range[1] and value <= range[2] then
      return value
    end

    --tex figure out gap values
    if direction>0 then
      low=range[2] or range
    else
      hi=range[1] or range
    end

    local dirRange=rangeTable[i+direction]
    if dirRange==nil then--tex reached an end, let the callee handle the wrap
      return -1
    end

    if direction>0 then
      hi=dirRange[1] or dirRange
    else
      low=dirRange[2] or dirRange
    end

    --in gap?
    if value>low and value<hi then
      if direction>0 then
        return hi
      else
        return low
      end
    end
  end--for
end

function this.IncrementWrap(current,increment,min,max)
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

function this.ChangeSetting(option,value)
  local newSetting=this.IncrementWrap(option.setting,value,option.range.min,option.range.max)
  if option.SkipValues and IsFunc(option.SkipValues) then
    while option:SkipValues(newSetting) do
      --OFF TppUiCommand.AnnounceLogView(newSetting .." ".. this.LangString"setting_disallowed")--" is currently disallowed"
      newSetting=this.IncrementWrap(newSetting,value,option.range.min,option.range.max)
    end
  end

  this.SetSetting(option,newSetting)
  --InfMenu.DebugPrint("DBG:MNU: new currentSetting:" .. newSetting)--tex DEBUG: CULL:
end

function this.SetCurrent()--tex refresh current setting/re-call OnChange
  local option=this.currentMenuOptions[this.currentIndex]
  if option.setting then
    this.SetSetting(option,option.setting)
  end
end

function this.ActivateCurrent()--tex run activate function
  local option=this.currentMenuOptions[this.currentIndex]
  if IsFunc(option.OnActivate) then
    option:OnActivate()
  else
    this.SetCurrent()
  end
end

function this.SetSetting(self,setting,noOnChangeSub,noSave)
  if self==nil then
    InfMenu.DebugPrint("WARNING: SetSetting: self==nil, did you use ivar.Set instead of ivar:Set?")
    return
  end
  if not IsTable(self) then
    InfMenu.DebugPrint("WARNING: SetSetting: self ~= table!")
    return
  end
  if self.setting==nil then
    InfMenu.DebugPrint("WARNING: SetSetting: setting==nil")
    return
  end
  if self.option then
    InfMenu.DebugPrint("WARNING: SetSetting called on menu")
    return
  end

  if type(setting)=="string" then
    setting=self.enum[setting]
    if setting==nil then
      TppUiCommand.AnnounceLogView("SetSetting: no setting on "..self.name)--DEBUG
      return
    end
  end
  --TppUiCommand.AnnounceLogView("SetSetting:" .. option.name)--DEBUG
  if self.noBounds~=true then
    if setting < self.range.min or setting > self.range.max then
      TppUiCommand.AnnounceLogView("WARNING: SetSetting for "..self.name.." OUT OF BOUNDS")
      return
    end
  end
  --TppUiCommand.AnnounceLogView("SetSetting:" .. self.name)--DEBUG
  local prevSetting=self.setting
  self.setting=setting
  if self.save and not noSave then
    local gvar=gvars[self.name]
    if gvar~=nil then
      gvars[self.name]=setting
    end
  end
  if self.OnChange then
    --    if noOnChangeSub and self.OnSubSettingChanged then --CULL
    --    --elseif noOnChangeSub and self.OnChange==Ivars.RunCurrentSetting then
    --    else
    self:OnChange(prevSetting)
    -- end
  end
  if self.profile and not noOnChangeSub then
    Ivars.OnChangeSubSetting(self)
  end
end
function this.SaveSetting(self,setting)
  self.setting=setting
  if self.save then
    local gvar=gvars[self.name]
    if gvar~=nil then
      gvars[self.name]=setting
    end
  end
end
function this.NextSetting(incrementMult)
  local option=this.currentMenuOptions[this.currentIndex]
  if option==nil then
    InfMenu.DebugPrint"WARNING: cannot find option for currentindex"
    return
  end

  if option.disabled then
    if option.disabledReason then
      this.PrintLangId(option.disabledReason)
    else
      this.PrintLangId"item_disabled"
    end
    return
  end

  if option.options then--tex is menu
    this.GoMenu(option)
  elseif IsFunc(option.GetNext) then
    local newSetting=option:GetNext()
    this.SetSetting(option,newSetting)
  else
    local increment=option.range.increment
    if incrementMult then
      increment=increment*incrementMult
      if not option.isFloat then
        increment=math.ceil(increment)
      end
    end

    this.ChangeSetting(option,increment)
  end
end
function this.PreviousSetting(incrementMult)
  local option=this.currentMenuOptions[this.currentIndex]

  if IsFunc(option.GetPrev) then
    local newSetting=option:GetPrev()
    this.SetSetting(option,newSetting)
  else
    local increment=-option.range.increment
    if incrementMult then
      increment=increment*incrementMult
      if not option.isFloat then
        increment=math.floor(increment)
      end
    end
    this.ChangeSetting(option,increment)
  end
end

function this.GoMenu(menu,goBack)
  if menu.options==nil then
    InfMenu.DebugPrint("WARNING: GoMenu menu var "..tostring(menu.name).." is not a menu")
    return
  end

  if not goBack and menu~=this.topMenu then
    menu.parent=this.currentMenu
    menu.parentOption=this.currentIndex
    this.currentDepth=this.currentDepth+1
  elseif menu==this.topMenu then
    this.currentDepth=0
  elseif goBack then
    this.currentDepth=this.currentDepth-1
  end

  local previousIndex=this.currentIndex
  if goBack then
    this.currentIndex=this.currentMenu.parentOption
  else
    this.currentIndex=1
  end

  local previousMenuOptions=this.currentMenuOptions

  this.currentMenu=menu
  this.currentMenuOptions=menu.options
  this.GetSetting(previousIndex,previousMenuOptions)
end

function this.GoBackCurrent()
  if this.currentMenu.parent==nil then
    if this.currentMenu~=this.topMenu then
      TppUiCommand.AnnounceLogView("Option Menu Error: parent = nil")
    end
    return
  end
  this.GoMenu(this.currentMenu.parent,true)
  if this.currentMenu.name and this.menuOn then
    this.PrintLangId(this.currentMenu.name)
  end
end

--tex display settings
function this.DisplayCurrentSetting()
  if this.menuOn then
    this.DisplaySetting(this.currentIndex)
  end
end

local itemIndicators={
  equals=" = ",
  menu=" >",
  command=" >>",
  command_menu_off=" >]",
  mode=" >[]",
}

function this.DisplaySetting(optionIndex)
  this.lastDisplay=Time.GetRawElapsedTimeSinceStartUp()
  local option=this.currentMenuOptions[optionIndex]
  local settingText=""
  local settingSuffix=""
  local optionSeperator=""
  local settingNames=option.settingNames or option.settings

  if option.isMenuOff then
    optionSeperator=itemIndicators.command_menu_off    
    settingText=""
  elseif option.optionType=="COMMAND" then
    optionSeperator=itemIndicators.command    
    settingText=""
  elseif option.optionType=="MENU" then
    optionSeperator=itemIndicators.menu    
    settingText=""
  elseif settingNames then
    optionSeperator=itemIndicators.equals
    --tex old style direct non localized table
    if IsTable(settingNames) then
      if option.setting < 0 or option.setting > #settingNames-1 then
        settingText="current setting out of settingNames bounds"
      else
        --tex lua indexed from 1, but settings from 0
        settingText=option.setting..":"..settingNames[option.setting+1]
      end
    else
      settingText=this.LangTableString(settingNames,option.setting+1)
    end
  elseif IsFunc(option.GetSettingText) then
    optionSeperator=itemIndicators.equals
    settingText=tostring(option:GetSettingText())
  else
    optionSeperator=itemIndicators.equals
    settingText=tostring(option.setting)
  end
  
  if option.isPercent then
   settingSuffix="%"
  end
  
  TppUiCommand.AnnounceLogDelayTime(0)
  local settingName = option.description or this.LangString(option.name)
  TppUiCommand.AnnounceLogView(optionIndex..":"..settingName..optionSeperator..settingText..settingSuffix)
end
--tex display all
function this.DisplaySettings()
  for i=1,#this.currentMenuOptions do
    this.DisplaySetting(i)
  end
end
function this.DisplayProfileChangedToCustom(profile)
  TppUiCommand.AnnounceLogView("Profile "..this.LangString(profile.name).." set to Custom")--TODO: ADDLANG:
end
function this.AutoDisplay()
  if this.autoDisplayRate > 0 then
    if Time.GetRawElapsedTimeSinceStartUp() - this.lastDisplay > this.autoDisplayRate then
      this.DisplayCurrentSetting()
    end
  end
end
function this.DisplayHelpText()
  local option=this.currentMenuOptions[this.currentIndex]
  if option.helpText ~= nil then
    --this.lastDisplay=Time.GetRawElapsedTimeSinceStartUp()
    TppUiCommand.AnnounceLogView(option.helpText)--ADDLANG:
  end
end
function this.ResetSetting()
  local option=this.currentMenuOptions[this.currentIndex]
  this.SetSetting(option,option.default)
end
function this.ResetSettings()
  for n,menu in pairs(InfMenuDefs.allMenus) do
    --InfMenu.DebugPrint(menu.name)
    for m,option in pairs(menu.options) do
      --InfMenu.DebugPrint(option.name)
      if option.save then--tex using identifier for all ivar/resetable settings
        --InfMenu.DebugPrint(option.name)--DEBUG
        this.SetSetting(option,option.default,true)
      end
    end
  end
end
function this.ResetSettingsDisplay()
  this.PrintLangId"setting_defaults"--"Setting mod options to defaults..."
  for i=1,#this.currentMenuOptions do
    local option=this.currentMenuOptions[i]
    if option.save then
      this.SetSetting(option,option.default,true)
      this.DisplaySetting(i)
    end
  end
  this.GetSetting()
end
--
function this.Print(message,...)
  if ... then
    TppUiCommand.AnnounceLogView(string.format(message,...))
  else
    TppUiCommand.AnnounceLogView(message)
  end
end

function this.DebugPrint(message,...)
  if message==nil then
    TppUiCommand.AnnounceLogView("nil")
    return
  elseif type(message)~="string" then
    message=tostring(message)
  end
  
  if ... then
  --message=string.format(message,...)--DEBUGNOW
  end

  while string.len(message)>this.MAX_ANNOUNCE_STRING do
    local printMessage=string.sub(message,0,this.MAX_ANNOUNCE_STRING)
    TppUiCommand.AnnounceLogView(printMessage)
    message=string.sub(message,this.MAX_ANNOUNCE_STRING+1)
  end

  TppUiCommand.AnnounceLogView(message)
end

--tex my own shizzy langid stuff since games is too limitied
function this.GetLanguageCode()
  --Cht over Jpn
  local languageCode=GetAssetConfig"Language"
  if Ivars.langOverride:Is(1) then
    if languageCode=="jpn" then
      languageCode="cht"
    end
  end
  return languageCode
end

function this.LangString(langId)
  if langId==nil or langId=="" then
    TppUiCommand.AnnounceLogView"PrintLangId langId empty"
    return ""
  end
  local languageCode=this.GetLanguageCode()
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
    --TppUiCommand.AnnounceLogView"PrintLangId langString empty"
    return langId
  end

  return langString
end

function this.LangTableString(langId,index)
  if langId==nil or langId=="" then
    TppUiCommand.AnnounceLogView"PrintLangId langId empty"
    return ""
  end
  local languageCode=this.GetLanguageCode()
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
    --TppUiCommand.AnnounceLogView"LangTableString langTable empty"
    return langId .. ":" .. index
  end

  if index < 1 or index > #langTable then
    --TppUiCommand.AnnounceLogView("LangTableString - index for " .. langId " out of bounds")
    return langId .. " OUTOFBOUNDS:" .. index
  end

  return langTable[index]
end

function this.GetLangTable(langId,index)
  if langId==nil or langId=="" then
    TppUiCommand.AnnounceLogView"PrintLangId langId empty"
    return {}
  end
  local languageCode=InfMenu.GetLanguageCode()
  if InfLang[languageCode]==nil then
    --TppUiCommand.AnnounceLogView("no lang in inflang")
    languageCode="eng"
  end
  local langTable=InfLang[languageCode][langId]
  if (langTable==nil or langTable=="" or not IsTable(langTable)) and languageCode~="eng" then
    --TppUiCommand.AnnounceLogView("no langTable for " .. languageCode)--DEBUG
    langTable=InfLang.eng[langId]
  end

  if langTable==nil or langTable=="" or not IsTable(langTable) then
    TppUiCommand.AnnounceLogView"LangTableString langTable empty"--DEBUG
    return {langId .. ":" .. "n"}
  end

  return langTable
end

function this.CpNameString(cpName,location)
  local languageCode=this.GetLanguageCode()
  local locationCps=InfLang.cpNames[location]
  if locationCps==nil then
    InfMenu.DebugPrint("WARNING: CpNameString - could not find location "..tostring(location).." in cpNames table")
    return
  end
  local cps=locationCps[languageCode] or locationCps["eng"]
  return cps[cpName]
end

function this.PrintLangId(langId)
  TppUiCommand.AnnounceLogView(this.LangString(langId))
end

function this.PrintFormatLangId(langId,...)
  TppUiCommand.AnnounceLogView(string.format(this.LangString(langId),...))
end

function this.Init(missionTable)
end

function this.MenuOff()
  this.menuOn=false
  this.OnDeactivate()
end

function this.OnActivate()
  InfButton.buttonStates[this.toggleMenuButton].holdTime=this.toggleMenuHoldTime--tex set up hold buttons

  InfButton.buttonStates[this.menuUpButton].decrement=0.1
  InfButton.buttonStates[this.menuDownButton].decrement=0.1
  InfButton.buttonStates[this.menuRightButton].decrement=0.1
  InfButton.buttonStates[this.menuLeftButton].decrement=0.1

  local repeatRate=0.85
  InfButton.buttonStates[this.menuUpButton].repeatRate=repeatRate
  InfButton.buttonStates[this.menuDownButton].repeatRate=repeatRate
  InfButton.buttonStates[this.menuRightButton].repeatRate=repeatRate
  InfButton.buttonStates[this.menuLeftButton].repeatRate=repeatRate
  InfButton.buttonStates[this.resetSettingButton].repeatRate=repeatRate
  InfButton.buttonStates[this.menuBackButton].repeatRate=repeatRate

  InfMain.DisableAction(InfMain.menuDisableActions)
  this.GetSetting()
  TppUiStatusManager.ClearStatus"AnnounceLog"
  TppUiCommand.AnnounceLogView(InfMain.modName.." "..InfMain.modVersion.." ".. this.LangString"menu_open_help")--(Press Up/Down,Left/Right to navigate menu)

  InfMain.OnMenuOpen()
end

function this.OnDeactivate()
  this.PrintLangId"menu_off"--"Menu Off"
  --InfMain.RestoreActionFlag()
  InfMain.EnableAction(InfMain.menuDisableActions)
  InfMain.OnMenuClose()
end

function this.CheckActivate(execCheck)
  local disallowCheck=execCheck.inGroundVehicle or execCheck.onBuddy or execCheck.inBox
  return not disallowCheck and not TppUiCommand.IsMbDvcTerminalOpened()
end

function this.Update(execCheck)
  local InfMenuDefs=InfMenuDefs
  --InfInspect.TryFunc(function(execCheck)--DEBUG
  --SplashScreen.Show(SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",1280,640),0,0.3,0)--tex eagle--tex ghetto as 'does it run?' indicator --DEBUG
  --tex current stuff in OnDeactivate doesnt need/want to be run in !inGame, so just dump out
  if not execCheck.inGame then
    this.menuOn = false
    return
  end

  if this.menuOn then
    if not this.CheckActivate(execCheck) then
      this.menuOn=false
      this.OnDeactivate()
      return
    end
  end

  if InfButton.OnButtonHoldTime(this.toggleMenuButton) then
    --InfMenu.DebugPrint"OnButtonHoldTime toggleMenuButton"--DEBUG
    if this.CheckActivate(execCheck) then
      this.menuOn = not this.menuOn
      if this.menuOn then
        this.OnActivate()
      else
        this.OnDeactivate()
        return
      end
    end
  end

  if execCheck.inHeliSpace then
    if this.topMenu~=InfMenuDefs.heliSpaceMenu then
      Ivars.PrintGvarSettingMismatch()
      this.topMenu=InfMenuDefs.heliSpaceMenu
      this.GoMenu(this.topMenu)
    end
  else
    if this.topMenu~=InfMenuDefs.inMissionMenu then
      --Ivars.PrintGvarSettingMismatch()--DEBUG
      this.topMenu=InfMenuDefs.inMissionMenu
      this.GoMenu(this.topMenu)
    end
  end

  if this.menuOn then
    --    if InfButton.OnButtonDown(this.toggleMenuButton) then--tex update gvar of current
    --      this.SetCurrent()
    --      this.DisplayCurrentSetting()
    --    end

    if InfButton.OnButtonDown(this.activateSettingButton) then
      this.ActivateCurrent()
      --this.DisplayCurrentSetting()
    end

    if InfButton.OnButtonDown(this.menuUpButton)
      or InfButton.OnButtonRepeat(this.menuUpButton) then
      this.PreviousOption()
      this.DisplayCurrentSetting()
    end
    if InfButton.OnButtonDown(this.menuDownButton)
      or InfButton.OnButtonRepeat(this.menuDownButton) then
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
      this.NextSetting(InfButton.GetRepeatMult())
    end

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
      this.PrintLangId"setting_default"--"Setting to default.."
      this.DisplayCurrentSetting()
    end
    if InfButton.OnButtonDown(this.menuBackButton) then
      this.GoBackCurrent()
    end

    this.AutoDisplay()
  end--!menuOn

  --SplashScreen.Show(SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5020_l_alp.ftex",1280,640),0,0.3,0)--tex dog--tex ghetto as 'does it run?' indicator
  --end,execCheck)--DEBUG
end

local didWelcome=false
function this.ModWelcome()
  if this.menuOn then
    return
  end
  if didWelcome then
    return
  end
  didWelcome=true

  --if gvars.disableModWelcome==1 and InfMain.version==InfMain.lastVersion then TODO:
  --  return
  --end
  TppUiCommand.AnnounceLogDelayTime(0)

  InfMenu.Print(InfMain.modName.." "..InfMain.modVersion)
  InfMenu.PrintLangId"menu_keys"
end
function this.ModMissionMessage()
  TppUiCommand.AnnounceLogView("ModMissionMessage test")--ADDLANG
end

this.menuString="MENUSTRINGCLEAR"
function this.PrintMenu()
  --DEBUG InfInspect.TryFunc(function()
  local menuString="MENUSTRING".."START".."\n"
  for n,item in pairs(InfMenuDefs) do
    if IsTable(item) then
      if item.options then--tex is menu
        local displayString=this.GetSettingString(item)
        menuString=menuString.."MENUDEF\n"..displayString.."\n"
        for i,option in ipairs(item.options) do
          local displayString=this.GetSettingString(option)
          menuString=menuString..displayString.."\n"
        end
      end
    end
  end
  menuString=menuString.."MENUSTRING".."END"
  --InfMenu.DebugPrint(menuString)--DEBUG
  this.menuString=menuString
  this.menustringLength=string.len(menuString)
  InfMenu.DebugPrint("menuString length ="..this.menustringLength)
  --DEBUG end)
end
function this.GetSettingString(option)
  local settingText=""
  local optionSeperator=itemIndicators.equals
  local settingNames=option.settingNames or option.settings
  if settingNames then
    --tex old style direct non localized table
    if IsTable(settingNames) then
      if option.setting < 0 or option.setting > #settingNames-1 then
        settingText="current setting out of settingNames bounds"
      else
        --tex lua indexed from 1, but settings from 0
        settingText=option.setting..":"..settingNames[option.setting+1]
      end
    else
      settingText=this.LangTableString(settingNames,option.setting+1)
    end
  elseif IsFunc(option.GetSettingText) then
    settingText="GetSettingText"--DEBUGNOWtostring(option:GetSettingText())
  elseif option.isPercent then
    settingText=option.setting .. "%"
  elseif option.options~=nil then--tex menu
    settingText=""
    optionSeperator=itemIndicators.menu
  else
    settingText=tostring(option.setting)
  end
  local settingName = option.description or this.LangString(option.name)
  return settingName--DEBUGNOW..optionSeperator..settingText
end

return this
