-- DOBUILD: 1
local this={}
--LOCALOPT:
local InfCore=InfCore
local InfButton=InfButton
local InfMain=InfMain
--tex TODO cant reference modules that reload (unless you build a system to update this reference)
--local InfLang=InfLang
--local Ivars=Ivars
local IvarProc=IvarProc
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local Enum=TppDefine.Enum
local GetAssetConfig=AssetConfiguration.GetDefaultCategory
local TppUiCommand=TppUiCommand
local GetElapsedTime=Time.GetRawElapsedTimeSinceStartUp

--tex REFACTOR: most of these can be local
this.currentMenu=nil
this.currentMenuOptions=nil
this.topMenu=this.currentMenu
this.currentIndex=1--tex lua tables are indexed from 1
this.currentDepth=0
this.lastDisplay=0
this.displayQueueSize=2--OFF
this.autoDisplayDefault=2.4
this.autoRateHeld=0.85
this.autoRatePressed=0.1
this.autoDisplayRate=this.autoDisplayDefault
this.repeatRateDefault=0.85
this.repeatRateIHExt=0.25
this.menuOn=false
this.quickMenuOn=false
this.toggleMenuHoldTime=1.25
this.quickMenuHoldTime=0.8
this.menuAltButton=InfButton.ZOOM_CHANGE
this.menuAltActive=InfButton.SUBJECT
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


function this.GetCurrentOption()
  local optionRef=this.currentMenuOptions[this.currentIndex]
  return this.GetOptionFromRef(optionRef)
end

--IN/SIDE: InfMenuCommands.commandItems
function this.GetOptionFromRef(optionRef)
  local option,name=InfCore.GetStringRef(optionRef)
  if option then
    if type(option)=="function" then
      local itemName=InfMenuCommands.ItemNameForFunctionName(name)
      return InfMenuCommands.commandItems[itemName]
    else
      return option
    end
  end
  return nil
end

function this.GetCurrentOption()
  local optionRef=this.currentMenuOptions[this.currentIndex]
  local option=this.GetOptionFromRef(optionRef)
  if option==nil then
    InfCore.Log("WARNING: option == nil! currentIndex="..tostring(this.currentIndex),true)--DEBUG
    return
  end
  return option
end

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
end

function this.GetSetting(previousIndex,previousMenuOptions)
  if this.currentMenuOptions==nil then
    InfCore.Log("WARNING: currentMenuOptions == nil!",true)--DEBUG
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
  --      InfCore.DebugPrint"InfMenu.GetSetting - no previousOption for previousIndex"--DEBUG
  --    end
  --  end

  local optionRef=this.currentMenuOptions[this.currentIndex]
  local option=this.GetOptionFromRef(optionRef)
  if option==nil then
    InfCore.Log("WARNING: option == nil! currentIndex="..tostring(this.currentIndex),true)--DEBUG
    return
  end

  --tex make sure ivar is synced from saved
  local gvar=IvarProc.GetSaved(option)
  if gvar~=nil then
    ivars[option.name]=gvar
  end
  if IsFunc(option.OnSelect) then
    InfCore.PCallDebug(option.OnSelect,option,ivars[option.name])
  end

  if InfCore.IHExtRunning() then
    InfCore.ExtCmd('ClearCombo','menuSetting')
    if option.optionType=="OPTION" then
      local currentSetting=ivars[option.name]

      local settings={}

      if type(option.GetSettingText)=="function" then
        local min=0
        if option.range then
          min=option.range.min
        end
        local max
        if option.settings then
          max=#option.settings
        elseif option.range then
          max=option.range.max
        end
        for i=0,max-1 do
          table.insert(settings,tostring(option:GetSettingText(i)))
        end
      elseif option.settingNames then
        if type(option.settingNames)=="table" then
          settings=option.settingNames
        else
          settings=InfMenu.LangTable(option.settingNames)
        end
      elseif option.settings then
        settings=option.settings
      end

      if this.debugModule then
        InfCore.PrintInspect(settings,"menuSettings")
      end

      if #settings>0 then
        for i,settingText in ipairs(settings)do
          InfCore.ExtCmd('AddToCombo','menuSetting',settingText)
        end
      elseif currentSetting then
        InfCore.ExtCmd('AddToCombo','menuSetting',currentSetting)
      end

      if #settings>0 then
        InfCore.ExtCmd('SelectCombo','menuSetting',currentSetting)
      elseif currentSetting then
        InfCore.ExtCmd('SelectCombo','menuSetting',0)
      end
    end--if option

    if ivars.enableHelp>0 then
      local helpString=this.LangStringHelp(option.name)
      if helpString then
        if this.menuOn then
          InfCore.ExtCmd('UiElementVisible','menuHelp',1)
        end
        InfCore.ExtCmd('SetText','menuHelp',helpString)
      else
        InfCore.ExtCmd('UiElementVisible','menuHelp',0)
      end
    end
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
  --InfCore.DebugPrint("DBG:MNU: new currentSetting:" .. newSetting)--tex DEBUG: CULL:
end

function this.SetCurrent()--tex refresh current setting/re-call OnChange
  local optionRef=this.currentMenuOptions[this.currentIndex]
  local option=this.GetOptionFromRef(optionRef)
  if option then
    local currentSetting=ivars[option.name]
    if currentSetting then
      IvarProc.SetSetting(option,currentSetting)
    end
  end
end

function this.ActivateCurrent()--tex run activate function
  local optionRef=this.currentMenuOptions[this.currentIndex]
  local option=this.GetOptionFromRef(optionRef)
  if option then
    if IsFunc(option.OnActivate) then
      InfCore.PCallDebug(option.OnActivate,option,ivars[option.name])
    else
      this.SetCurrent()
    end
  end
end

function this.NextSetting(incrementMult)
  local optionRef=this.currentMenuOptions[this.currentIndex]
  local option=this.GetOptionFromRef(optionRef)
  if option==nil then
    InfCore.Log("InfMenu.NextSetting: WARNING option==nil")
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
end
function this.PreviousSetting(incrementMult)
  local optionRef=this.currentMenuOptions[this.currentIndex]
  local option=this.GetOptionFromRef(optionRef)
  if option==nil then
    InfCore.Log("InfMenu.PreviousSetting: WARNING option==nil")
  end
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
end

function this.GoMenu(menu,goBack)
  if menu.options==nil then
    InfCore.Log("WARNING: GoMenu menu var "..tostring(menu.name).." is not a menu",true,true)
    return
  end
  InfCore.LogFlow("InfMenu.GoMenu:"..menu.name)--DEBUG

  if not goBack and menu~=this.topMenu then
    menu.parent=this.currentMenu
    menu.parentOption=this.currentIndex
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

  if InfCore.IHExtRunning() then
    local menuName=this.LangString(this.currentMenu.name)
    InfCore.ExtCmd('SetContent','menuTitle',menuName)

    InfCore.ExtCmd('ClearTable','menuItems')
    for optionIndex=1,#menu.options do
      local optionRef=this.currentMenuOptions[optionIndex]
      local option=this.GetOptionFromRef(optionRef)
      if option then
        if option.OnSelect then
          option:OnSelect(ivars[option.name])
        end
        local settingText=this.GetSettingText(optionIndex,option,false,false)
        InfCore.ExtCmd('AddToTable','menuItems',settingText)
      end
    end
  end

  this.GetSetting(previousIndex,previousMenuOptions)
end

function this.GoBackCurrent()
  if this.currentMenu.parent==nil then
    if this.currentMenu~=this.topMenu then
      InfCore.Log("ERROR GoBackCurrent parent == nil")
    end
    return
  end
  this.GoMenu(this.currentMenu.parent,true)
  if this.currentMenu.name and this.menuOn then
    if not InfCore.IHExtRunning() then
      this.PrintLangId(this.currentMenu.name)
    end
  end
end

--tex display settings
function this.DisplayCurrentSetting()
  if this.menuOn then
    this.DisplaySetting(this.currentIndex,false)
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

function this.GetSettingText(optionIndex,option,optionNameOnly,noItemIndicator,settingNumberOnly)
  local currentSetting=ivars[option.name]

  --REF
  --1:SomeOption: 102
  --1:SomeOption: 102%
  --1:SomeOption: 1:SomeSetting
  --1:Command >>
  --1:Menu >
  --1:Go back >>
  --1:Do and close >
  --itemIndex..optionText..optionSeperator..settingIndex..settingText..settingSuffix

  local itemIndex=""
  local optionText=""
  local optionSeperator=""
  local settingIndex=""
  local settingText=""
  local settingSuffix=""

  itemIndex=optionIndex..":"
  optionText = option.description or this.LangString(option.name)

  if option.isMenuOff then
    if not noItemIndicator then
      optionSeperator=itemIndicators.command_menu_off
    end
    settingText=""
  elseif option.optionType=="COMMAND" then
    if not noItemIndicator then
      optionSeperator=itemIndicators.command
    end
    settingText=""
  elseif option.optionType=="MENU" then
    if not noItemIndicator then
      optionSeperator=itemIndicators.menu
    end
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
    if not option.noActivateText then
      optionSeperator=itemIndicators.activate..optionSeperator
    end
  end

  if option.isPercent then
    settingSuffix="%"
  end

  if not option.noSettingCounter and option.optionType=="OPTION" and (option.settingNames or option.settingsTable or option.GetSettingText) then--
    settingIndex=currentSetting..":"

  end

  if settingNumberOnly then
    settingText=""
  end

  local fullSettingText=""
  if optionNameOnly then
    if optionSeperator==itemIndicators.equals then
      optionSeperator=itemIndicators.colon
    end
    fullSettingText=itemIndex..optionText..optionSeperator
  else
    fullSettingText=itemIndex..optionText..optionSeperator..settingIndex..settingText..settingSuffix
  end

  return fullSettingText
end

function this.DisplaySetting(optionIndex,optionNameOnly)
  local optionRef=this.currentMenuOptions[optionIndex]
  local option=this.GetOptionFromRef(optionRef)
  if option==nil then
    InfCore.Log("InfMenu.DisplaySetting: WARNING option==nil")
    return
  else
    if InfCore.IHExtRunning() then
      local settingText=this.GetSettingText(optionIndex,option,optionNameOnly)
      local menuLineText=this.GetSettingText(optionIndex,option,optionNameOnly,false,true)
      InfMgsvToExt.SetMenuLine(settingText,menuLineText)
    else
      local settingText=this.GetSettingText(optionIndex,option,optionNameOnly)
      TppUiCommand.AnnounceLogDelayTime(0)
      TppUiCommand.AnnounceLogView(settingText)
    end
  end
  this.lastDisplay=GetElapsedTime()
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
    if GetElapsedTime()-this.lastDisplay>this.autoDisplayRate then
      if not InfCore.IHExtRunning() then
        this.DisplayCurrentSetting()
      end
    end
  end
  --OFF
  --  if GetElapsedTime()-this.lastDisplay>this.autoRatePressed then
  --    this.DisplayQueue()
  --  end
end
function this.GetCurrentHelpText()
  local optionRef=this.currentMenuOptions[this.currentIndex]
  local option=this.GetOptionFromRef(optionRef)
  if option then
    --this.lastDisplay=GetElapsedTime()
    return this.LangStringHelp(option.name)
  end
end
function this.ResetSetting()
  local optionRef=this.currentMenuOptions[this.currentIndex]
  local option=this.GetOptionFromRef(optionRef)
  if option and option.optionType=="OPTION" then
    IvarProc.SetSetting(option,option.default)
    this.PrintLangId"setting_default"--"Setting to default.."
    this.DisplayCurrentSetting()
  end
end
function this.MinSetting()
  local optionRef=this.currentMenuOptions[this.currentIndex]
  local option=this.GetOptionFromRef(optionRef)
  if option and option.optionType=="OPTION" then
    IvarProc.SetSetting(option,option.range.min)
    this.PrintLangId"setting_minimum"--"Setting to minimum.."
    this.DisplayCurrentSetting()
  end
end
function this.ResetSettings()
  for n,menu in pairs(InfMenuDefs.allMenus) do
    --InfCore.DebugPrint(menu.name)
    for m,optionRef in pairs(menu.options) do
      --InfCore.DebugPrint(option.name)
      local option=this.GetOptionFromRef(optionRef)
      if option and option.save then--tex using identifier for all ivar/resetable settings
        --InfCore.DebugPrint(option.name)--DEBUG
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
    local optionRef=this.currentMenuOptions[i]
    local option=this.GetOptionFromRef(optionRef)
    if option and option.save then
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
    InfCore.Log("WANRING: InfLangProc.LangString langId is empty")
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

function this.LangTable(langId)
  if langId==nil or langId=="" then
    InfCore.Log("ERROR: GetLangTable langId empty",false,true)
    return {}
  end
  local languageCode=InfMenu.GetLanguageCode()
  local langTable=InfLang[languageCode][langId]
  if (langTable==nil or langTable=="" or not IsTable(langTable)) and languageCode~="eng" then
    --TppUiCommand.AnnounceLogView("no langTable for " .. languageCode)--DEBUG
    langTable=InfLang.eng[langId]
  end

  if langTable==nil or langTable=="" or not IsTable(langTable) then
    InfCore.Log("ERROR: LangTableString langTable empty",false,true)--DEBUG
    return {langId .. ":" .. "n"}
  end

  return langTable
end

function this.LangStringHelp(langId)
  if langId==nil or langId=="" then
    InfCore.Log("WANRING: InfLangProc.LangString langId is empty")
    TppUiCommand.AnnounceLogView"LangString langId empty"
    return ""
  end
  local languageCode=this.GetLanguageCode()
  local langTable=InfLang.help[languageCode] or InfLang.help.eng
  local langString=langTable[langId] or InfLang.help.eng[langId] -- or langId
  return langString
end

function this.CpNameString(cpName,location)
  local location=location or InfUtil.GetLocationName()
  local languageCode=this.GetLanguageCode()
  local locationCps=InfLang.cpNames[location]
  if locationCps==nil then
    InfCore.Log("InfMenu.CpNameString: WARNING No name for "..tostring(cpName).." in "..tostring(location))
    return nil
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
  InfCore.LogFlow"InfMenu.OnActivate"
  this.ActivateControlSet()

  this.GetSetting()
  TppUiStatusManager.ClearStatus"AnnounceLog"

  local message=InfCore.modName.." r"..InfCore.modVersion.." ".. this.LangString"menu_open_help"--(Press Up/Down,Left/Right to navigate menu)
  TppUiCommand.AnnounceLogView(message)

  if InfCore.IHExtRunning() then
    InfMgsvToExt.ShowMenu()
    this.DisplayCurrentSetting()
  end

  InfMain.OnMenuOpen()
end

function this.OnDeactivate()
  InfCore.LogFlow"InfMenu.OnDeactivate"
  this.PrintLangId"menu_off"--"Menu Off"
  --InfMain.RestoreActionFlag()
  this.DeactivateControlSet()
  InfMain.OnMenuClose()

  if InfCore.IHExtRunning() then
    InfMgsvToExt.HideMenu()
  end
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
  --InfCore.PCallDebug(function(execCheck)--DEBUG
  --tex current stuff in OnDeactivate doesnt need/want to be run in !inGame, so just dump out
  --TODO NOTE controlset deactivate on game state change
  if not execCheck.inGame then
    if this.menuOn then
      this.MenuOff()
    end
  else
    if this.menuOn then
      --TODO NOTE controlset deactivate on game state change
      if not this.CheckActivate(execCheck) then
        this.MenuOff()
        return
      end

      --tex while pause is bound to escape key by default it is not actually the ESCAPE button mask
      --so if pause is bound to something else this wont catch it.
      if InfButton.OnButtonDown(InfButton.ESCAPE) then
        this.MenuOff()
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
      --InfCore.DebugPrint"OnButtonHoldTime toggleMenuButton"--DEBUG
      this.ToggleMenu(execCheck)
    end

    if InfButton.ButtonHeld(this.menuAltButton) then
      if InfButton.OnButtonDown(this.menuAltActive) then
        InfCore.ExtCmd('TakeFocus')
      end
    end

    if this.menuOn then
      this.DoControlSet()

      this.AutoDisplay()
    end--!menuOn
  end

  --quickmenu>
  local InfQuickMenuDefs=InfQuickMenuDefs_User or InfQuickMenuDefs
  if InfQuickMenuDefs and not this.menuOn then
    if InfQuickMenuDefs.forceEnable or Ivars.enableQuickMenu:Is(1) then
      local quickMenuHoldButton=InfQuickMenuDefs.quickMenuHoldButton
      if quickMenuHoldButton then
        this.quickMenuOn=InfButton.ButtonHeld(quickMenuHoldButton)
        local quickMenu=InfQuickMenuDefs.inMission
        if execCheck.inHeliSpace then
          quickMenu=InfQuickMenuDefs.inHeliSpace
        end
        if execCheck.inDemo then
          quickMenu=InfQuickMenuDefs.inDemo
        end

        for button,commandInfo in pairs(quickMenu) do
          InfButton.buttonStates[button].holdTime=0.9--DEBUGNOW --commandInfo.immediate and 0.05 or 0.9
          if commandInfo.immediate then
            this.quickMenuOn=InfButton.ButtonDown(quickMenuHoldButton)
          end
          
          if (commandInfo.immediate and InfButton.OnButtonDown(button)) or
            InfButton.OnButtonHoldTime(button) then
            --tex have to be careful with order when doing combos since OnButtonHold (and others) update state
            if this.quickMenuOn then
              local Command,name=InfCore.GetStringRef(commandInfo.Command)
              if Command==nil then
                InfCore.Log("WARNING: Could not find function for QuickMenu command:"..tostring(commandInfo.Command))
              elseif type(Command)~="function"then
                InfCore.Log("WARNING: QuickMenu command "..tostring(commandInfo.Command).." is not a function")
              else
                Command()
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

  local repeatRate=this.repeatRateDefault
  if InfCore.IHExtRunning() then
    InfButton.incrementMultIncrementMult=1.1
  end
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
  local ihextIsRunning=InfCore.IHExtRunning()

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
    InfButton.buttonStates[this.menuRightButton].repeatRate=this.repeatRateDefault--tex slow initial repeat
  elseif InfButton.OnButtonUp(this.menuRightButton) then
    this.autoDisplayRate=this.autoDisplayDefault
  elseif InfButton.OnButtonRepeat(this.menuRightButton) then
    this.autoDisplayRate=this.autoRateHeld
    this.NextSetting(incrementMod*InfButton.GetRepeatMult())
    --tex handled by autodisplay if not ihext otherwise announcelog would choke on too many updates
    if ihextIsRunning then
      this.DisplayCurrentSetting()
      InfButton.buttonStates[this.menuRightButton].repeatRate=this.repeatRateIHExt--tex quicker repeat
    end
  end

  if InfButton.OnButtonDown(this.menuLeftButton) then
    this.PreviousSetting(incrementMod)
    this.DisplayCurrentSetting()
  elseif InfButton.OnButtonUp(this.menuLeftButton) then
    this.autoDisplayRate=this.autoDisplayDefault
  elseif InfButton.OnButtonRepeat(this.menuLeftButton) then
    this.autoDisplayRate=this.autoRateHeld
    this.PreviousSetting(incrementMod*InfButton.GetRepeatMult())
    if ihextIsRunning then
      this.DisplayCurrentSetting()
    end
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

  InfMenu.Print(InfCore.modName.." r"..InfCore.modVersion)
  InfMenu.PrintLangId"menu_keys"
end

function this.BuildProfileMenu(profile)
  local revertProfile={}
  local options={}
  for ivarName,setting in pairs(profile)do
    local ivar=Ivars[ivarName]
    if ivar==nil then
      InfCore.DebugPrint("WARNING: BuildProfileMenu - could not find ivar "..ivarName)--DEBUG
    else
      revertProfile[ivarName]=ivars[ivar.name]
      options[#options+1]=ivar
    end
  end
  options[#options+1]='InfMenuCommands.RevertProfile'
  options[#options+1]='InfMenuCommands.GoBackItem'

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

function this.AddDevMenus()
  InfCore.Log"AddDevMenus"
  local heliSpaceMenu=InfMenuDefs.heliSpaceMenu.options
  local inMissionMenu=InfMenuDefs.inMissionMenu.options
  if heliSpaceMenu[1]~="InfMenuDefs.devInAccMenu" then
    table.insert(heliSpaceMenu,1,'InfMenuDefs.devInAccMenu')
    table.insert(inMissionMenu,1,'InfMenuDefs.devInMissionMenu')
  end
end

function this.BuildMenuDefForSearch(searchString)
  local newMenuDef={
    options={}
  }
  for i,optionRef in ipairs(InfMenuDefs.allItems)do
    if string.find(optionRef,searchString,1,true) then
      table.insert(newMenuDef.options,optionRef)
    end
  end
  table.sort(newMenuDef.options)
  table.insert(newMenuDef.options,"InfMenu.BackToTop")--TODO ADDLANG
end

--MenuCommand
function this.BackToTop()
  if TppMission.IsHelicopterSpace(vars.missionCode) then
    this.topMenu=InfMenuDefs.heliSpaceMenu
  else
    this.topMenu=InfMenuDefs.inMissionMenu
  end      
  this.GoMenu(this.topMenu)
end

return this
