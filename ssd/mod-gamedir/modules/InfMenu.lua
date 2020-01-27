-- InfMenu.lua
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
local GetAssetConfig=AssetConfiguration.GetDefaultCategory
local TppUiCommand=TppUiCommand
local GetElapsedTime=Time.GetRawElapsedTimeSinceStartUp
local insert=table.insert
local abs=math.abs

this.autoDisplayDefault=2.4
this.autoRateHeld=0.85
this.autoRatePressed=0.1
this.repeatRateDefault=0.85
this.repeatRateIHExt=0.25
this.toggleMenuHoldTime=1.25
this.quickMenuHoldTime=0.8
this.menuAltButtonHoldTime=0.4
this.stickInputRate=0.25

this.menuAltButton=InfButton.ZOOM_CHANGE
this.menuAltActive=InfButton.RELOAD
this.toggleMenuButton=InfButton.EVADE--SYNC: InfLang "menu_keys"
this.toggleMenuButtonAlt=InfButton.DASH
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

--tex menu on and menuAltButton down
this.stickLPadMask={
  settingName="stickLPadMask",
  sticks=PlayerPad.STICK_L,
}

--STATE
this.menuOn=false
this.quickMenuOn=false
this.currentMenu=nil
this.currentMenuOptions=nil
this.topMenu=nil
this.currentIndex=1--tex lua tables are indexed from 1
this.lastDisplay=0
this.autoDisplayRate=this.autoDisplayDefault
this.lastStickInput=0

function this.PostModuleLoad()
  this.MenuOff()
end

--IN/SIDE: InfMenuCommands.commandItems
function this.GetOptionFromRef(optionRef)
  local option,name=InfCore.GetStringRef(optionRef)
  if option then
    if type(option)=="function" then
      local itemName=InfMenuCommands.ItemNameForFunctionName(name)
      local commandItem=InfMenuCommands.commandItems[itemName]
      if commandItem==nil then
        InfCore.Log("WARNING: InfMenu.GetOptionFromRef: could not find "..tostring(optionRef).." in InfMenuCommands.commandItems")
      end
      return commandItem
    else
      return option
    end
  end
  return nil
end

function this.GetCurrentOption()
  if this.currentMenuOptions==nil then
    InfCore.Log("WARNING: InfMenu.GetCurrentOption: this.currentMenuOptions==nil")--DEBUG
    return
  end

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
        if option.settings then
          min=0
        elseif option.range then
          min=option.range.min
        end
        local max=0
        if option.settings then
          max=#option.settings-1
        elseif option.range then
          max=option.range.max
        end
        for i=min,max do
          table.insert(settings,tostring(option:GetSettingText(i)))
        end
      elseif option.settingNames then
        if type(option.settingNames)=="table" then
          settings=option.settingNames
        else
          settings=InfLangProc.LangTable(option.settingNames)
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
      local helpString=InfLangProc.LangStringHelp(option.name)
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
      newSetting=this.IncrementWrap(newSetting,value,option.range.min,option.range.max)
    end
  end

  IvarProc.SetSetting(option,newSetting)
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
    InfCore.Log("WARNING: InfMenu.NextSetting: option==nil")
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
    InfCore.Log("WARNING: InfMenu.PreviousSetting: option==nil")
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
    local menuName=InfLangProc.LangString(this.currentMenu.name)
    InfCore.ExtCmd('SetContent','menuTitle',menuName)

    InfCore.ExtCmd('ClearTable','menuItems')
    for optionIndex=1,#menu.options do
      local optionRef=this.currentMenuOptions[optionIndex]
      local option=this.GetOptionFromRef(optionRef)
      local settingText=optionIndex..":"..optionRef.." not found"
      if option==nil then
        InfCore.ExtCmd('ClearCombo','menuSetting')
      else
        if option.OnSelect then
          option:OnSelect(ivars[option.name])
        end
        settingText=this.GetSettingText(optionIndex,option,false,false)
      end
      InfCore.ExtCmd('AddToTable','menuItems',settingText)
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
  --1:SomeOption = 102
  --4:SomeOption = 102%
  --5:SomeOption = 3:SomeSetting
  --2:SomeOption <Action> = 3:SomeActivateSetting
  --8:Command >>
  --2:Menu >
  --9:Go back >>
  --3:Do and close >]
  --itemIndex..optionText..optionSeperator..settingIndex..settingText..settingSuffix

  local itemIndex=""
  local optionText=""
  local optionSeperator=""
  local settingIndex=""
  local settingText=""
  local settingSuffix=""

  itemIndex=optionIndex..":"
  optionText = option.description or InfLangProc.LangString(option.name)

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
    settingText=InfLangProc.LangTableString(option.settingNames,currentSetting+1)
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

  local settingText=optionIndex..":"..optionRef.." not found"
  if InfCore.IHExtRunning() then
    if option==nil then
      InfCore.ExtCmd('ClearCombo','menuSetting')
      InfMgsvToExt.SetMenuLine(settingText,settingText)
    else
      local settingText=this.GetSettingText(optionIndex,option,optionNameOnly)
      local noItemIndicator=false
      local settingNumberOnly=true
      local menuLineText=this.GetSettingText(optionIndex,option,optionNameOnly,noItemIndicator,settingNumberOnly)
      InfMgsvToExt.SetMenuLine(settingText,menuLineText)
    end
  else

    if option==nil then
    else
      settingText=this.GetSettingText(optionIndex,option,optionNameOnly)
    end
    TppUiCommand.AnnounceLogDelayTime(0)
    TppUiCommand.AnnounceLogView(settingText)
  end
  this.lastDisplay=GetElapsedTime()
end
--tex display all
function this.DisplaySettings()
  for i=1,#this.currentMenuOptions do
    this.DisplaySetting(i)
  end
end

function this.AutoDisplay()
  if this.autoDisplayRate > 0 then
    if GetElapsedTime()-this.lastDisplay>this.autoDisplayRate then
        this.DisplayCurrentSetting()
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
    return InfLangProc.LangStringHelp(option.name)
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

function this.PrintLangId(langId)
  TppUiCommand.AnnounceLogView(InfLangProc.LangString(langId))
end

function this.PrintFormatLangId(langId,...)
  TppUiCommand.AnnounceLogView(string.format(InfLangProc.LangString(langId),...))
end

function this.ToggleMenu(currentChecks)
  if this.CheckActivate(currentChecks) then
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

  local message=InfCore.modName.." r"..InfCore.modVersion.." ".. InfLangProc.LangString"menu_open_help"--(Press Up/Down,Left/Right to navigate menu)
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

function this.CheckActivate(currentChecks)
  local disallowCheck=currentChecks.inGroundVehicle or currentChecks.onBuddy or currentChecks.inBox
  return not disallowCheck and not TppUiCommand.IsMbDvcTerminalOpened()
end

--tex CULL, handled on a command by command basis
--function this.CheckActivateQuickMenu(execCheck)
--  local disallowCheck=execCheck.inGroundVehicle or execCheck.onBuddy or execCheck.inBox
--  return not disallowCheck and not TppUiCommand.IsMbDvcTerminalOpened()
--end
--tex called directly from InfMain.Update
function this.Update(currentChecks,currentTime,execChecks,execState)
  local InfMenuDefs=InfMenuDefs
  --tex current stuff in OnDeactivate doesnt need/want to be run in !inGame, so just dump out
  --TODO NOTE controlset deactivate on game state change
  --DEBUGNOW
  --  if not currentChecks.inGame then
  --    if this.menuOn then
  --      this.MenuOff()
  --    end
  --    return
  --  end

  if not currentChecks.inSafeSpace and not currentChecks.inMission then
    if this.menuOn then
      this.MenuOff()
    end
    return
  end

  if not currentChecks.missionCanStart then
    if this.menuOn then
      this.MenuOff()
    end
    return
  end

  if this.menuOn then
    --TODO NOTE controlset deactivate on game state change
    if not this.CheckActivate(currentChecks) then
      this.MenuOff()
      return
    end
  end

  if this.menuOn then
    --tex while pause is bound to escape key by default it is not actually the ESCAPE button mask
    --so if pause is bound to something else this wont catch it.
    if InfButton.OnButtonDown(InfButton.ESCAPE) then
      this.MenuOff()
      return
    end
  end

  if currentChecks.inSafeSpace then
    if this.topMenu~=InfMenuDefs.safeSpaceMenu then
      IvarProc.PrintGvarSettingMismatch()
      this.topMenu=InfMenuDefs.safeSpaceMenu
      this.GoMenu(this.topMenu)
    end
  else
    if this.topMenu~=InfMenuDefs.inMissionMenu then
      --IvarProc.PrintGvarSettingMismatch()--DEBUG
      this.topMenu=InfMenuDefs.inMissionMenu
      this.GoMenu(this.topMenu)
    end
  end

  if this.toggleMenuButton then
    if InfButton.OnButtonHoldTime(this.toggleMenuButton) then
      --InfCore.DebugPrint"OnButtonHoldTime toggleMenuButton"--DEBUG
      this.ToggleMenu(currentChecks)
    end
  end

  if InfButton.ButtonHeld(this.menuAltButton) then
    if InfButton.OnButtonDown(this.toggleMenuButtonAlt) then
      this.ToggleMenu(currentChecks)
      return
    end
  end

  if InfButton.ButtonHeld(this.menuAltButton) then
    if InfButton.OnButtonDown(this.menuAltActive) then
      if this.menuOn then
        InfCore.ExtCmd('TakeFocus')
        return
      end
    end
  end

  if this.menuOn then
    this.DoControlSet()

    if not InfCore.IHExtRunning() then
    this.AutoDisplay()
    end
  end--!menuOn

  --quickmenu>
  local InfQuickMenuDefs=InfQuickMenuDefs_User or InfQuickMenuDefs
  if InfQuickMenuDefs and not this.menuOn then
    if InfQuickMenuDefs.forceEnable or Ivars.enableQuickMenu:Is(1) then
      local quickMenuHoldButton=this.menuAltButton
      this.quickMenuOn=InfButton.ButtonHeld(quickMenuHoldButton)
      local quickMenu=InfQuickMenuDefs.inMission
      if currentChecks.inSafeSpace then
        quickMenu=InfQuickMenuDefs.inSafeSpace
      end
      if currentChecks.inDemo then
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
  --<
end

function this.ActivateControlSet()
  --tex set up hold buttons
  if this.toggleMenuButton then
    InfButton.buttonStates[this.toggleMenuButton].holdTime=this.toggleMenuHoldTime
  end
--DEBUGNOW  InfButton.buttonStates[InfQuickMenuDefs.quickMenuHoldButton].holdTime=this.quickMenuHoldTime

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
  Player.ResetPadMask(this.stickLPadMask)
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

  if InfButton.ButtonHeld(this.menuAltButton) then
    Player.SetPadMask(this.stickLPadMask)

    local leftStickX=PlayerVars.leftStickXDirect
    local leftStickY=PlayerVars.leftStickYDirect

    local deadZone=0.5
    if abs(leftStickX)<deadZone then
      leftStickX=0
    end
    if abs(leftStickY)<deadZone then
      leftStickY=0
    end

    --InfCore.Log(leftStickX..","..leftStickY)--DEBUGNOW

    --DEBUGNOW TODO: repeat timer, proportional to stick dist
    local elapsedTime=GetElapsedTime()
    if elapsedTime-this.lastStickInput>this.stickInputRate then
      if leftStickY<0 then
        this.lastStickInput=elapsedTime
        this.PreviousOption(incrementMod)
        this.DisplayCurrentSetting()
      elseif leftStickY>0 then
        this.lastStickInput=elapsedTime
        this.NextOption(incrementMod)
        this.DisplayCurrentSetting()
      end

      if leftStickX<0 then
        this.lastStickInput=elapsedTime
        this.PreviousSetting(incrementMod)
        this.DisplayCurrentSetting()
      elseif leftStickX>0 then
        this.lastStickInput=elapsedTime
        this.NextSetting(incrementMod)
        this.DisplayCurrentSetting()
      end
    end
  end

  if InfButton.OnButtonUp(this.menuAltButton) then
    Player.ResetPadMask(this.stickLPadMask)
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
  local safeSpaceMenu=InfMenuDefs.safeSpaceMenu.options
  local inMissionMenu=InfMenuDefs.inMissionMenu.options
  if safeSpaceMenu[1]~="InfMenuDefs.devInAccMenu" then
    table.insert(safeSpaceMenu,1,'InfMenuDefs.devInAccMenu')
    table.insert(inMissionMenu,1,'InfMenuDefs.devInMissionMenu')
  end
end

local nonSearchItems={
  menuOffItem=true,
  searchItem=true,
}

function this.BuildMenuDefForSearch(searchString)
  local newMenuDef={
    options={}
  }
  local foundItems={}
  if searchString and searchString~="" then
    searchString=searchString:lower()

    local searchItems
    if InfMain.IsSafeSpace(vars.missionCode) then
      searchItems=InfMenuDefs.allItems.safeSpaceMenu
    else
      searchItems=InfMenuDefs.allItems.inMissionMenu
    end

    for i,optionRef in ipairs(searchItems)do
      local option,name=InfCore.GetStringRef(optionRef)
      local langName=InfLangProc.LangString(name):lower()
      if string.find(langName,searchString,1,true) then
        foundItems[optionRef]=true
      end
    end
    end
  for optionRef,found in pairs(foundItems)do
    insert(newMenuDef.options,optionRef)
  end
  table.sort(newMenuDef.options)
  insert(newMenuDef.options,1,"Ivars.searchItem")
  insert(newMenuDef.options,"InfMenuCommands.GoBackTopItem")
  return newMenuDef
end

--MenuCommand
function this.GoBackTop()
  if InfMain.IsSafeSpace(vars.missionCode) then
    this.topMenu=InfMenuDefs.safeSpaceMenu
  else
    this.topMenu=InfMenuDefs.inMissionMenu
  end
  this.GoMenu(this.topMenu)
end

return this
