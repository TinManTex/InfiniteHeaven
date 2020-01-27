--InfExtToMgsv.lua
local this={}

local InfCore=InfCore
local ivars=ivars
local Split=InfCore.Split
local concat=table.concat
local tonumber=tonumber
local ipairs=ipairs

this.debugModule=false

local menuLine="menuLine"
local menuItems="menuItems"
local OPTION="OPTION"

function this.Update(currentChecks,currentTime,execChecks,execState)
  if not ivars.enableIHExt then
    return
  end

  --tex no commands from IHExt will be processed unless menu is open
  if currentChecks.menuOn==false and InfCore.extSession~=0 then
    --tex dont return if IHExt still hasnt acked the commands
    if InfCore.mgsvToExtComplete>=#InfCore.mgsvToExtCommands then
      return
    end
    if this.debugModule then
      InfCore.Log("commands not done",false,true)--DEBUG
    end
  end

  this.ProcessCommands()
end

function this.ProcessCommands()
  local extToMgsvPrev=InfCore.extToMgsvComplete
  local extPrevSession=InfCore.extSession
  local ignoreError=true--tex will get 'Domain error' due to file locking between ihext
  local lines=InfCore.GetLines(InfCore.toMgsvCmdsFilePath,ignoreError)

  if not lines then
    if this.debugModule then
      InfCore.Log('Could not read ih_toMgsvCmds')
    end
    return
  elseif #lines==0 then--tex file read ok, but is blank because ihext hasnt started
  --InfCore.Log('#lines==0-------------')
    return
  end

    for i,line in ipairs(lines)do
      if line:len()>0 then
        local args=Split(line,'|')
        local messageId=tonumber(args[1])
        if #args>0 then
          --tex 1st line messageId is IHExt sessionId
          if i==1 then
            if messageId~=InfCore.extSession then
              InfCore.Log('DoExtToMgsvCommands IHExt session changed')
              InfCore.extSession=messageId
              --tex reset
              --InfCore.extToMgsvComplete=0
              InfCore.ExtCmd('SessionChange')--tex a bit of nothing to get the mgsvTpExtComplete to update from the message, ext does likewise
            --InfCore.Log("SessionChange",false,true)--DEBUG
            InfCore.WriteToExtTxt()
            end
          InfCore.mgsvToExtComplete=tonumber(args[3])
          elseif messageId>InfCore.extToMgsvComplete then
            if this.debugModule then
              InfCore.PrintInspect(args,'DoToMgsvCommand '..args[1])--DEBUG
            end
            if this.commands[args[2]] then
              this.commands[args[2]](args)
            end

            InfCore.extToMgsvComplete=messageId
          end
        end--end if args>0
      end--end for lines
    end

  if InfCore.extSession~=0 then
    if InfCore.extSession~=extPrevSession then
      --InfCore.Log("SessionChange",false,true)--DEBUG
      InfCore.WriteToExtTxt()--tex to ack session change, possibly already handled by below, and above, but there may have been an edge case? should have commented it then lol
    elseif InfCore.extToMgsvComplete~=extToMgsvPrev then
      --InfCore.Log("extToMgsvComplete change",false,true)--DEBUG
      InfCore.WriteToExtTxt()
    end
  end
end

--commands

function this.Ready(args)
  if InfCore.manualIHExtStart then
    InfMenu.GoMenu(InfMenu.topMenu)
  end
end

--<messageId>|input|<elementName>|<input string>
function this.Input(args)
  local InfMenu=InfMenu
  if args[2]=="input" and (args[3]=="inputLine" or args[3]=="menuSetting") and args[4] then
    local currentOption
    if InfMenu.currentMenuOptions then
      currentOption=InfMenu.GetCurrentOption()
    end

    if currentOption==nil then
      return
    end

    local commandArgs=InfUtil.Split(args[4],' ')
    if #commandArgs>0 then
      if commandArgs[1]=='>' then
        if currentOption.optionType==OPTION then
          InfMenu.NextSetting()
          InfMenu.DisplayCurrentSetting()
        end
      elseif commandArgs[1]=='<' then
        if currentOption.optionType==OPTION then
          InfMenu.PreviousSetting()
          InfMenu.DisplayCurrentSetting()
        end
      elseif commandArgs[1]=='<<' then
        InfMenu.GoBackCurrent()
        InfMenu.DisplayCurrentSetting()
      elseif commandArgs[1]=='>>' then
        if not commandArgs[2] then

        else
          local menuIndex=tonumber(commandArgs[2])
          if menuIndex and menuIndex>0 and menuIndex<=#InfMenu.currentMenuOptions then
            InfMenu.currentIndex=menuIndex
            InfMenu.GetSetting()
            InfMenu.DisplayCurrentSetting()
          end
        end
        --      elseif commandArgs[1]=='?' then
        --        if currentOption then
        --          local helpText=InfMenu.GetCurrentHelpText()
        --          InfCore.ExtCmd('print',helpText)
        --          InfCore.WriteToExtTxt()
        --          InfMenu.DisplayCurrentSetting()
        --        end
      else
        if currentOption.optionType==OPTION then
          local setting=tonumber(args[4]) or args[4]
          IvarProc.SetSetting(currentOption,setting)
          InfMenu.DisplayCurrentSetting()
        end
      end
    end
  end
end

--messageId|selected|listName|selectedIndex
function this.Selected(args)
  local InfMenu=InfMenu
  --DEBUGNOW TODO some kind of list registry and subscription to event i guess
  --just hardcoded to menu for now
  if args[3]==menuItems then
    local menuIndex=tonumber(args[4])+1
    if menuIndex and menuIndex>0 and menuIndex<=#InfMenu.currentMenuOptions then
      InfMenu.currentIndex=menuIndex
      InfMenu.GetSetting()
      InfMenu.DisplayCurrentSetting()
    end
  end
end

--messageId|selected|comboName|selectedIndex
function this.SelectedCombo(args)
  --DEBUGNOW TODO some kind of list registry and subscription to event i guess
  --just hardcoded to menu for now
  if args[3]=="menuSetting" then
    local currentOption=InfMenu.GetCurrentOption()
    if currentOption then
      local setting=tonumber(args[4])
      if this.debugModule then
        InfCore.Log("currentoption:"..currentOption.name.." setting:"..setting)--DEBUG
      end
      if currentOption.optionType==OPTION then
        currentOption:Set(setting)
        InfMenu.GetSetting()
        InfMenu.DisplayCurrentSetting()
      end
    end
  end
end

--messageId|activate|listName|selectedIndex
function this.Activate(args)
  --TODO, see Selected -^-
  if args[3]==menuItems then
    local menuIndex=tonumber(args[4])+1--tex shift to 1 indexed
    if menuIndex and menuIndex>0 and menuIndex<=#InfMenu.currentMenuOptions then
      local optionRef=InfMenu.currentMenuOptions[menuIndex]
      local option=InfMenu.GetOptionFromRef(optionRef)
      if option then
        if option.options then--tex is menu
          InfMenu.GoMenu(option)
        elseif type(option.OnActivate)=="function" then
          InfCore.PCallDebug(option.OnActivate,option,ivars[option.name])
        elseif option.optionType==OPTION then
          InfMenu.NextSetting()
        else
          InfMenu.SetCurrent()
        end
        InfMenu.DisplayCurrentSetting()
      end
    end
  end
end

function this.ToggleMenu(args)
  local currentChecks=InfMain.UpdateExecChecks(InfMain.execChecks)
  InfMenu.ToggleMenu(currentChecks)
end

--messageId|GotKeyboardFocus|textBlockName
function this.GotKeyboardFocus(args)
  if args[3]==menuLine then
    if InfMenu.currentMenu~=InfMenuDefs.searchMenu then
      InfMenuDefs.searchMenu=InfMenu.BuildMenuDefForSearch(nil)
      InfMenuDefs.BuildMenuItem("searchMenu",InfMenuDefs.searchMenu)
      InfMenu.GoMenu(InfMenuDefs.searchMenu)

      --InfMenu.DisplayCurrentSetting()
      --DEBUGNOW
      --            local settingText=this.GetSettingText(optionIndex,option,optionNameOnly)
      --      local noItemIndicator=false
      --      local settingNumberOnly=true
      --      local menuLineText=this.GetSettingText(optionIndex,option,optionNameOnly,noItemIndicator,settingNumberOnly)
      --      InfMgsvToExt.SetMenuLine(settingText,menuLineText)
      local settingText=""
      local menuLineText="<Type and Enter to search>"--DEBUGNOW TODO LANG
      InfMgsvToExt.SetMenuLine(settingText,menuLineText)
      InfCore.ExtCmd("SelectAllText",menuLine)
      InfCore.WriteToExtTxt()
    end
  end
end

--messageId|EnterText|textBlockName|text
function this.EnterText(args)
  if args[3]==menuLine then
    local searchText=args[4]
    InfMenuDefs.searchMenu=InfMenu.BuildMenuDefForSearch(searchText)
    InfMenuDefs.BuildMenuItem("searchMenu",InfMenuDefs.searchMenu)
    InfMenu.GoMenu(InfMenuDefs.searchMenu)
    local settingText=""
    local menuLineText="<Type and Enter to search>"--DEBUGNOW TODO LANG
    --InfMgsvToExt.SetMenuLine(settingText,menuLineText)
    --InfCore.WriteToExtTxt()
  end
end

this.commands={
  ready=this.Ready,
  input=this.Input,
  selected=this.Selected,
  selectedcombo=this.SelectedCombo,
  activate=this.Activate,
  togglemenu=this.ToggleMenu,
  GotKeyboardFocus=this.GotKeyboardFocus,
  EnterText=this.EnterText,
}

return this
