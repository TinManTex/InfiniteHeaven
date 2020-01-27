-- DOBUILD: 1
local this={}
--LOCALOPT:
local InfButton=InfButton
local InfMain=InfMain
--tex TODO cant reference modules that reload (unless you build a system to update this reference)
--local InfLang=InfLang
--local Ivars=Ivars
local IvarProc=IvarProc
local InfLog=InfLog
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local Enum=TppDefine.Enum
local GetAssetConfig=AssetConfiguration.GetDefaultCategory
local TppUiCommand=TppUiCommand

--tex REFACTOR: most of these can be local
this.currentMenu=nil
this.currentMenuOptions=nil
this.topMenu=this.currentMenu
this.currentIndex=1--tex lua tables are indexed from 1
this.currentDepth=0
this.lastDisplay=0
this.lastMenuPress=0
this.displayQueueSize=2--OFF
this.autoDisplayDefault=2.4
this.autoRateHeld=0.85
this.autoRatePressed=0.1
this.autoDisplayRate=this.autoDisplayDefault
this.menuOn=false
this.quickMenuOn=false
this.toggleMenuHoldTime=1.25
this.quickMenuHoldTime=0.8
this.toggleMenuButton=InfButton.EVADE--SYNC: InfLang "menu_keys"
this.menuRightButton=InfButton.RIGHT
this.menuLeftButton=InfButton.LEFT
this.menuUpButton=InfButton.UP
this.menuDownButton=InfButton.DOWN
this.resetSettingButton=InfButton.SUBJECT
this.menuBackButton=InfButton.STANCE
this.activateSettingButton=InfButton.ACTION
this.bigIncrementButton=InfButton.FIRE
this.smallIncrementButton=InfButton.HOLD
this.minSettingButton=InfButton.RELOAD
--CULL this.quickMenuHoldButton=InfButton.CALL

this.lastAutoDisplayString=""
this.maxAutoDisplayRepeat=3

--tex mod settings menu manipulation
function this.NextOption(incrementMult)
  local oldIndex=this.currentIndex

  local increment=1
  if incrementMult then
    increment=increment*incrementMult
    increment=math.ceil(increment)
  end

  this.currentIndex=this.currentIndex+increment
  if this.currentIndex>#this.currentMenuOptions then
    this.currentIndex=1
  end
  this.GetSetting(oldIndex)

  this.lastMenuPress=Time.GetRawElapsedTimeSinceStartUp()
end
function this.PreviousOption(incrementMult)
  local oldIndex=this.currentIndex

  local increment=1
  if incrementMult then
    increment=increment*incrementMult
    increment=math.ceil(increment)
  end

  this.currentIndex = this.currentIndex-increment
  if this.currentIndex < 1 then
    this.currentIndex = #this.currentMenuOptions
  end
  this.GetSetting(oldIndex)

  this.lastMenuPress=Time.GetRawElapsedTimeSinceStartUp()
end
function this.GetSetting(previousIndex,previousMenuOptions)
  if this.currentMenuOptions==nil then
    InfLog.Add("WARNING: currentMenuOptions == nil!",true)--DEBUG
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
  --      InfLog.DebugPrint"InfMenu.GetSetting - no previousOption for previousIndex"--DEBUG
  --    end
  --  end

  local option=this.currentMenuOptions[this.currentIndex]
  if option==nil then
    InfLog.Add("WARNING: option == nil! currentIndex="..tostring(this.currentIndex),true)--DEBUG
    return
  end

  --tex make sure ivar is synced from saved
  local gvar=IvarProc.GetSaved(option)
  if gvar~=nil then
    ivars[option.name]=gvar
  end
  if IsFunc(option.OnSelect) then
    InfLog.PCallDebug(option.OnSelect,option)
  end
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
  local currentSetting=ivars[option.name]
  local newSetting=this.IncrementWrap(currentSetting,value,option.range.min,option.range.max)
  if option.SkipValues and IsFunc(option.SkipValues) then
    while option:SkipValues(newSetting) do
      --OFF TppUiCommand.AnnounceLogView(newSetting .." ".. this.LangString"setting_disallowed")--" is currently disallowed"
      newSetting=this.IncrementWrap(newSetting,value,option.range.min,option.range.max)
    end
  end

  IvarProc.SetSetting(option,newSetting)
  --InfLog.DebugPrint("DBG:MNU: new currentSetting:" .. newSetting)--tex DEBUG: CULL:
end

function this.SetCurrent()--tex refresh current setting/re-call OnChange
  local option=this.currentMenuOptions[this.currentIndex]
  local currentSetting=ivars[option.name]
  if currentSetting then
    IvarProc.SetSetting(option,currentSetting)
  end
end

function this.ActivateCurrent()--tex run activate function
  local option=this.currentMenuOptions[this.currentIndex]
  if IsFunc(option.OnActivate) then
    InfLog.PCallDebug(option.OnActivate,option,ivars[option.name])
  else
    this.SetCurrent()
  end
end

function this.NextSetting(incrementMult)
  local option=this.currentMenuOptions[this.currentIndex]
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
    local newSetting=option:GetNext(ivars[option.name])
    IvarProc.SetSetting(option,newSetting)
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

  this.lastMenuPress=Time.GetRawElapsedTimeSinceStartUp()
end
function this.PreviousSetting(incrementMult)
  local option=this.currentMenuOptions[this.currentIndex]

  if IsFunc(option.GetPrev) then
    local newSetting=option:GetPrev(ivars[option.name])
    IvarProc.SetSetting(option,newSetting)
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

  this.lastMenuPress=Time.GetRawElapsedTimeSinceStartUp()
end

function this.GoMenu(menu,goBack)
  if menu.options==nil then
    InfLog.DebugPrint("WARNING: GoMenu menu var "..tostring(menu.name).." is not a menu")
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
function this.DisplayCurrentSetting(optionNameOnly)
  if this.menuOn then
    this.DisplaySetting(this.currentIndex,optionNameOnly)
  end
end

local itemIndicators={
  equals=" = ",
  colon=" :",
  menu=" >",
  command=" >>",
  command_menu_off=" >]",
  mode=" >[]",
  activate=" <Action>",
}

function this.GetSettingText(optionIndex,option,optionNameOnly)
  local settingText=""
  local settingSuffix=""
  local optionSeperator=""

  local currentSetting=ivars[option.name]

  if option.isMenuOff then
    optionSeperator=itemIndicators.command_menu_off
    settingText=""
  elseif option.optionType=="COMMAND" then
    optionSeperator=itemIndicators.command
    settingText=""
  elseif option.optionType=="MENU" then
    optionSeperator=itemIndicators.menu
    settingText=""
  elseif currentSetting==nil then
    settingText=": ERROR: ivar==nil"
  elseif IsFunc(option.GetSettingText) then
    optionSeperator=itemIndicators.equals
    settingText=tostring(option:GetSettingText(currentSetting))
  elseif IsTable(option.settingNames) then--tex direct table of names (like mbSelectedDemo) or the fallback - settings table
    optionSeperator=itemIndicators.equals
    if currentSetting < 0 or currentSetting > #option.settingNames-1 then
      settingText=" WARNING: current setting out of settingNames bounds"
    else
      settingText=option.settingNames[currentSetting+1]
    end
  elseif option.settingNames then
    optionSeperator=itemIndicators.equals
    settingText=this.LangTableString(option.settingNames,currentSetting+1)
  else
    optionSeperator=itemIndicators.equals
    settingText=tostring(currentSetting)
  end

  if option.OnActivate then
    optionSeperator=itemIndicators.activate..optionSeperator
  end

  if option.isPercent then
    settingSuffix="%"
  end

  if not option.noSettingCounter and option.optionType=="OPTION" and (option.settingNames or option.settingsTable or option.GetSettingText) then--
    settingText=currentSetting..":"..settingText
  end

  local settingName = option.description or this.LangString(option.name)

  local fullSettingText=""
  if optionNameOnly then
    if optionSeperator==itemIndicators.equals then
      optionSeperator=itemIndicators.colon
    end
    fullSettingText=optionIndex..":"..settingName..optionSeperator
  else
    fullSettingText=optionIndex..":"..settingName..optionSeperator..settingText..settingSuffix
  end

  return fullSettingText
end

function this.DisplaySetting(optionIndex,optionNameOnly)
  local option=this.currentMenuOptions[optionIndex]
  local settingText=this.GetSettingText(optionIndex,option,optionNameOnly)
  --OFF this.QueueDisplay(message)
  TppUiCommand.AnnounceLogDelayTime(0)
  TppUiCommand.AnnounceLogView(settingText)
  this.lastDisplay=Time.GetRawElapsedTimeSinceStartUp()
end
--tex display all
function this.DisplaySettings()
  for i=1,#this.currentMenuOptions do
    this.DisplaySetting(i)
  end
end
--tex CULL wont achieve much since the issue is with already posted log lines, and cant delay enough to filter without losing responsiveness
--function this.QueueDisplay(message,messageType)
--  if this.displayQueue[#InfMessageLog.display]==message then
--    return
--  end
--
--  --tex kill front of queue since it will be oldest
--  if #InfMessageLog.display==this.displayQueueSize then
--    table.remove(InfMessageLog.display,1)
--  end
--
--  table.insert(InfMessageLog.display,message)
--end
--function this.DisplayQueue()
--  if #InfMessageLog.display>0 then
--    TppUiCommand.AnnounceLogView(InfMessageLog.display[1])
--    table.remove(InfMessageLog.display,1)
--    this.lastDisplay=Time.GetRawElapsedTimeSinceStartUp()
--  end
--end
function this.AutoDisplay()
  if this.autoDisplayRate > 0 then
    if Time.GetRawElapsedTimeSinceStartUp()-this.lastDisplay>this.autoDisplayRate then
      --if #InfMessageLog.display==0 then
      this.DisplayCurrentSetting()
      --end
    end
  end
  --OFF
  --  if Time.GetRawElapsedTimeSinceStartUp()-this.lastDisplay>this.autoRatePressed then
  --    this.DisplayQueue()
  --  end
end
function this.DisplayHelpText()
  local option=this.currentMenuOptions[this.currentIndex]
  if option.helpText~=nil then
    --this.lastDisplay=Time.GetRawElapsedTimeSinceStartUp()
    TppUiCommand.AnnounceLogView(option.helpText)--ADDLANG:
  end
end
function this.ResetSetting()
  local option=this.currentMenuOptions[this.currentIndex]
  if option.optionType=="OPTION" then
    IvarProc.SetSetting(option,option.default)
    this.PrintLangId"setting_default"--"Setting to default.."
    this.DisplayCurrentSetting()
  end
end
function this.MinSetting()
  local option=this.currentMenuOptions[this.currentIndex]
  if option.optionType=="OPTION" then
    IvarProc.SetSetting(option,option.range.min)
    this.PrintLangId"setting_minimum"--"Setting to minimum.."
    this.DisplayCurrentSetting()
  end
end
function this.ResetSettings()
  for n,menu in pairs(InfMenuDefs.allMenus) do
    --InfLog.DebugPrint(menu.name)
    for m,option in pairs(menu.options) do
      --InfLog.DebugPrint(option.name)
      if option.save then--tex using identifier for all ivar/resetable settings
        --InfLog.DebugPrint(option.name)--DEBUG
        if ivars[option.name]~=option.default then
          IvarProc.SetSetting(option,option.default)
      end
      end
    end
  end
end
function this.ResetSettingsDisplay()
  this.PrintLangId"setting_defaults"--"Setting mod options to defaults..."
  for i=1,#this.currentMenuOptions do
    local option=this.currentMenuOptions[i]
    if option.save then
      IvarProc.SetSetting(option,option.default)
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

--tex my own shizzy langid stuff since games is too limitied
function this.GetLanguageCode()
  --Cht over Jpn
  local languageCode=GetAssetConfig"Language"
  if Ivars.langOverride:Is(1) then
    if languageCode=="jpn" then
      languageCode="cht"
    end
  end
  if Ivars[languageCode]==nil then
    languageCode="eng"
  end
  return languageCode
end

function this.LangString(langId)
  if langId==nil or langId=="" then
    TppUiCommand.AnnounceLogView"LangString langId empty"
    return ""
  end
  local languageCode=this.GetLanguageCode()
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
    TppUiCommand.AnnounceLogView"LangTableString langId empty"
    return ""
  end
  local languageCode=this.GetLanguageCode()
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

  return langTable[index],langTable
end

function this.GetLangTable(langId,index)
  if langId==nil or langId=="" then
    TppUiCommand.AnnounceLogView"GetLangTable langId empty"
    return {}
  end
  local languageCode=InfMenu.GetLanguageCode()
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
  local location=location or InfMain.GetLocationName()
  local languageCode=this.GetLanguageCode()
  local locationCps=InfLang.cpNames[location]
  if locationCps==nil then
    return "No name for "..tostring(cpName)
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

function this.ToggleMenu(execCheck)
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

function this.MenuOff()
  this.menuOn=false
  this.OnDeactivate()
end

function this.OnActivate()
  this.ActivateControlSet()

  this.GetSetting()
  TppUiStatusManager.ClearStatus"AnnounceLog"
  TppUiCommand.AnnounceLogView(InfMain.modName.." r"..InfMain.modVersion.." ".. this.LangString"menu_open_help")--(Press Up/Down,Left/Right to navigate menu)

  InfMain.OnMenuOpen()
end

function this.OnDeactivate()
  this.PrintLangId"menu_off"--"Menu Off"
  --InfMain.RestoreActionFlag()
  this.DeactivateControlSet()
  InfMain.OnMenuClose()
end

function this.CheckActivate(execCheck)
  local disallowCheck=execCheck.inGroundVehicle or execCheck.onBuddy or execCheck.inBox
  return not disallowCheck and not TppUiCommand.IsMbDvcTerminalOpened()
end

--tex CULL, handled on a command by command basis
--function this.CheckActivateQuickMenu(execCheck)
--  local disallowCheck=execCheck.inGroundVehicle or execCheck.onBuddy or execCheck.inBox
--  return not disallowCheck and not TppUiCommand.IsMbDvcTerminalOpened()
--end

function this.Update(execCheck)
  local InfMenuDefs=InfMenuDefs
  --InfLog.PCallDebug(function(execCheck)--DEBUG
  --tex current stuff in OnDeactivate doesnt need/want to be run in !inGame, so just dump out
  --TODO NOTE controlset deactivate on game state change
  if not execCheck.inGame then
    this.menuOn = false
    this.quickMenuOn=false
    return
  end

  if this.menuOn then
    --TODO NOTE controlset deactivate on game state change
    if not this.CheckActivate(execCheck) then
      this.menuOn=false
      this.OnDeactivate()
      return
    end
  end

  if execCheck.inHeliSpace then
    if this.topMenu~=InfMenuDefs.heliSpaceMenu then
      IvarProc.PrintGvarSettingMismatch()
      this.topMenu=InfMenuDefs.heliSpaceMenu
      this.GoMenu(this.topMenu)
    end
  else
    if this.topMenu~=InfMenuDefs.inMissionMenu then
      --IvarProc.PrintGvarSettingMismatch()--DEBUG
      this.topMenu=InfMenuDefs.inMissionMenu
      this.GoMenu(this.topMenu)
    end
  end

  --TODO NOTE controlset toggle on button
  if InfButton.OnButtonHoldTime(this.toggleMenuButton) then
    --InfLog.DebugPrint"OnButtonHoldTime toggleMenuButton"--DEBUG
    this.ToggleMenu(execCheck)
  end

  if this.menuOn then
    this.DoControlSet()

    this.AutoDisplay()
  end--!menuOn

  --quickmenu>
  local InfQuickMenuDefs=InfQuickMenuDefs
  if InfQuickMenuDefs and not this.menuOn then
    if InfQuickMenuDefs.forceEnable or Ivars.enableQuickMenu:Is(1) then
      local quickMenuHoldButton=InfQuickMenuDefs.quickMenuHoldButton
      if quickMenuHoldButton then
        this.quickMenuOn=InfButton.ButtonHeld(quickMenuHoldButton)
        local quickMenu=InfQuickMenuDefs.inMission
        if execCheck.inHeliSpace then
          quickMenu=InfQuickMenuDefs.inHeliSpace
        end
        for button,commandInfo in pairs(quickMenu) do
          InfButton.buttonStates[button].holdTime=commandInfo.immediate and 0.05 or 0.9
          if commandInfo.immediate then
            this.quickMenuOn=InfButton.ButtonDown(quickMenuHoldButton)
          end

          if InfButton.OnButtonHoldTime(button) then
            --tex have to be careful with order when doing combos since OnButtonHold (and others) update state
            if this.quickMenuOn then
              if IsFunc(commandInfo.Command) then
                commandInfo.Command()
              end
            end
          end
        end
      end
    end
  end

  --<
  --end,execCheck)--DEBUG
end

function this.ActivateControlSet()
  --tex set up hold buttons
  InfButton.buttonStates[this.toggleMenuButton].holdTime=this.toggleMenuHoldTime
  InfButton.buttonStates[InfQuickMenuDefs.quickMenuHoldButton].holdTime=this.quickMenuHoldTime

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
end

function this.DeactivateControlSet()
  InfMain.EnableAction(InfMain.menuDisableActions)
end

function this.DoControlSet()
  if InfButton.OnButtonDown(this.minSettingButton) then
    this.MinSetting()
  end

  if InfButton.OnButtonDown(this.activateSettingButton) then
    this.ActivateCurrent()
    --this.DisplayCurrentSetting()
  end

  if InfButton.OnButtonDown(this.resetSettingButton) and not this.quickMenuOn then
    this.ResetSetting()
  end
  if InfButton.OnButtonDown(this.menuBackButton) then
    this.GoBackCurrent()
  end

  local incrementMod=1
  if InfButton.ButtonDown(this.bigIncrementButton) then
    incrementMod=10
  end

  if InfButton.OnButtonDown(this.menuUpButton)
    or InfButton.OnButtonRepeat(this.menuUpButton) then
    this.PreviousOption(incrementMod)
    this.DisplayCurrentSetting()
  end
  if InfButton.OnButtonDown(this.menuDownButton)
    or InfButton.OnButtonRepeat(this.menuDownButton) then
    this.NextOption(incrementMod)
    this.DisplayCurrentSetting()
  end

  local incrementMod=1
  if InfButton.ButtonDown(this.bigIncrementButton) then
    incrementMod=10
  elseif InfButton.ButtonDown(this.smallIncrementButton) then
    incrementMod=0.1
  end

  if InfButton.OnButtonDown(this.menuRightButton) then
    this.NextSetting(incrementMod)
    this.DisplayCurrentSetting()
  elseif InfButton.OnButtonUp(this.menuRightButton) then
    this.autoDisplayRate=this.autoDisplayDefault
  elseif InfButton.OnButtonRepeat(this.menuRightButton) then
    this.autoDisplayRate=this.autoRateHeld
    this.NextSetting(incrementMod*InfButton.GetRepeatMult())
  end

  if InfButton.OnButtonDown(this.menuLeftButton) then
    this.PreviousSetting(incrementMod)
    this.DisplayCurrentSetting()
  elseif InfButton.OnButtonUp(this.menuLeftButton) then
    this.autoDisplayRate=this.autoDisplayDefault
  elseif InfButton.OnButtonRepeat(this.menuLeftButton) then
    this.autoDisplayRate=this.autoRateHeld
    this.PreviousSetting(incrementMod*InfButton.GetRepeatMult())
  end
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

  InfMenu.Print(InfMain.modName.." r"..InfMain.modVersion)
  InfMenu.PrintLangId"menu_keys"
end

function this.BuildProfileMenu(profile)
  local revertProfile={}
  local options={}
  for ivarName,setting in pairs(profile)do
    local ivar=Ivars[ivarName]
    if ivar==nil then
      InfLog.DebugPrint("WARNING: BuildProfileMenu - could not find ivar "..ivarName)--DEBUG
    else
      revertProfile[ivarName]=ivars[ivar.name]
      options[#options+1]=ivar
    end
  end
  options[#options+1]=InfMenuCommands.revertProfile
  options[#options+1]=InfMenuCommands.goBackItem

  return {
    isProfileMenu=true,
    revertProfile=revertProfile,
    options=options
  }
end

function this.RevertProfileMenu()
  --tex profile menu applies with nosave, so revert
  if this.currentMenu.isProfileMenu then
    for i,option in pairs(this.currentMenu.options) do
      IvarProc.UpdateSettingFromGvar(option)
    end
  end
end

return this
