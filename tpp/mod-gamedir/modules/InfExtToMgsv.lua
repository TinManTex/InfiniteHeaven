--InfExtToMgsv.lua
local this={}

local concat=table.concat

this.debugModule=false

function this.Update(currentChecks,currentTime,execChecks,execState)
  if not ivars.enableIHExt then
    return
  end

  this.ProcessCommands()
end

local tonumber=tonumber
function this.ProcessCommands()
  local extToMgsvPrev=InfCore.extToMgsvComplete
  local extPrevSession=InfCore.extSession
  local lines=InfCore.GetLines(InfCore.toMgsvCmdsFilePath)

  if not lines then
    if this.debugModule then
      InfCore.Log('Could not read ih_toMgsvCmds')
    end
  elseif #lines==0 then--tex file read ok, but is blank because ihext hasnt started
  --InfCore.Log('#lines==0-------------')
  end

  if lines then
    for i,line in ipairs(lines)do
      if line:len()>0 then
        local args=InfUtil.Split(line,'|')
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
            end
            InfCore.mgsvToExtComplete=args[3]
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
    if InfCore.extSession~=0 then--tex ihExt hasnt started
      if InfCore.extToMgsvComplete~=extToMgsvPrev or this.extSession~=extPrevSession then
        InfCore.WriteToExtTxt()--tex update due to extToMgsvComplete change
    end
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
        if currentOption.optionType=="OPTION" then
          InfMenu.NextSetting()
          InfMenu.DisplayCurrentSetting()
        end
      elseif commandArgs[1]=='<' then
        if currentOption.optionType=="OPTION" then
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
        --          InfMenu.DisplayCurrentSetting()
        --        end
      else
        if currentOption.optionType=="OPTION" then
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
  --DEBUGNOW TODO some kind of list registry and subscription to event i guess
  --just hardcoded to menu for now
  if args[3]=="menuItems" then
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
      if currentOption.optionType=="OPTION" then
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
  if args[3]=="menuItems" then
    local menuIndex=tonumber(args[4])+1--tex shift to 1 indexed
    if menuIndex and menuIndex>0 and menuIndex<=#InfMenu.currentMenuOptions then
      local optionRef=InfMenu.currentMenuOptions[menuIndex]
      local option=InfMenu.GetOptionFromRef(optionRef)
      if option then
        if option.options then--tex is menu
          InfMenu.GoMenu(option)
        elseif type(option.OnActivate)=="function" then
          InfCore.PCallDebug(option.OnActivate,option,ivars[option.name])
        else
          InfMenu.SetCurrent()
        end
      end
    end
  end
end

function this.ToggleMenu(args)
  local currentChecks=InfMain.UpdateExecChecks(InfMain.execChecks)
  InfMenu.ToggleMenu(currentChecks)
end

this.commands={
  ready=this.Ready,
  input=this.Input,
  selected=this.Selected,
  selectedcombo=this.SelectedCombo,
  activate=this.Activate,
  togglemenu=this.ToggleMenu,
}

return this
