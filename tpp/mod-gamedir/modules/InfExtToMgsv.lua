--InfExtToMgsv.lua
local this={}

local InfCore=InfCore
local IHH=IHH
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

  if IHH then
  --tex always run if IHH DEBUGNOW
  else
    if not ivars.enableIHExt then
      return
    end

    --tex no commands from IHExt will be processed unless menu is open
    if currentChecks.inMenu==false and InfCore.extSession~=0 then
      --tex dont return if IHExt still hasnt acked the commands
      if InfCore.mgsvToExtComplete>=InfCore.mgsvToExtCount then
        if this.debugModule then
        --InfCore.Log("commands not done",false,true)--DEBUG
        end
        return
      end
    end
  end--if not IHH

  this.ProcessCommands()
end

function this.ProcessCommands()
  local extToMgsvPrev=InfCore.extToMgsvComplete
  local extPrevSession=InfCore.extSession
  local ignoreError=true--tex will get 'Domain error' due to file locking between ihext
  local messages

  if IHH then
    messages=IHH.GetPipeInMessages()
    --messages={}--DEBUGNOW
    if not messages then
      return
    end

    --tex WORKAROUND, IHH doesn't need this at all, but there's still a bunch of checks using it
    --DEBUGNOW InfCore.mgsvToExtComplete=InfCore.mgsvToExtCount
  else
    --tex legacy text IPC, IHExt only
    messages=InfCore.GetLines(InfCore.toMgsvCmdsFilePath,ignoreError)
    if not messages then
      if this.debugModule then
        InfCore.Log('Could not read ih_toMgsvCmds')
      end
      return
    elseif #messages==0 then--tex file read ok, but is blank because ihext hasnt started
      --InfCore.Log('#lines==0-------------')
      return
    end
  end--Get messages

  for i,message in ipairs(messages)do
    if message:len()>0 then
      local args=Split(message,'|')
      local messageId=tonumber(args[1])
      --DEBUGNOW
      if #args>0 then
        --tex 1st line command arg3 is extToMgsvComplete
        --can't just stick it in a command as that would just create a loop of further commands to update it
        if i==1 and not IHH then
        elseif IHH or messageId>InfCore.extToMgsvComplete then
          if this.debugModule then
            InfCore.PrintInspect(args,'ToMgsv command '..args[1])--DEBUG
          end
          if this.commands[args[2]] then
            this.commands[args[2]](args)
          end

          InfCore.extToMgsvComplete=messageId
        end
      end--end if args>0
    end--end for lines
  end--for messages

  if not IHH then
    if InfCore.extSession~=0 then
      local extToMgsvPrev=InfCore.extToMgsvComplete
      local extPrevSession=InfCore.extSession
      if InfCore.extSession~=extPrevSession then
        --InfCore.Log("SessionChange",false,true)--DEBUG
        InfCore.WriteToExtTxt()--tex to ack session change, possibly already handled by below, and above, but there may have been an edge case? should have commented it then lol
      elseif InfCore.extToMgsvComplete~=extToMgsvPrev then
        --InfCore.Log("extToMgsvComplete change",false,true)--DEBUG
        InfCore.WriteToExtTxt()
      end
    end
  end--not IHH
end--ProcessCommands

--commands
--tex all commands take in single param and array of args
--args[1] = messageId (not really useful for a command)
--args[2] = command name (ditto)
--args[3+] = args as string

--tex First message sent by IHExt when it starts
--args int extSession
function this.ExtSession(args)
  local extSession = args[3]
  if extSession~=InfCore.extSession then
    InfCore.Log('IHExt session changed')
    InfCore.extSession=extSession

    if not IHH then
      InfCore.ExtCmd('SessionChange')--tex a bit of nothing to get the mgsvTpExtComplete to update from the message, ext does likewise
      InfCore.WriteToExtTxt()
    end
  end

  --DEBUGNOW if InfCore.manualIHExtStart then
  InfMenu.GoMenu(InfMenu.topMenu)
  InfMenu.DisplayCurrentSetting()
  --end
end

--args string elementName, string input
--tex handles input from inputLine or menuSetting
--TODO document what the actual commands are
function this.Input(args)
  local InfMenu=InfMenu
  local elementName=args[3]
  local input=args[4]
  if (elementName=="inputLine" or elementName=="menuSetting") and input then
    local currentOption
    if InfMenu.currentMenuOptions then
      currentOption=InfMenu.GetCurrentOption()
    end

    if currentOption==nil then
      return
    end

    local commandArgs=InfUtil.Split(input,' ')
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
          local setting=tonumber(input) or input
          IvarProc.SetSetting(currentOption,setting)
          InfMenu.DisplayCurrentSetting()
        end
      end
    end--commandArgs
  end--elementName==inputLine or menuSetting
end--function Input

--args string listName, int selectedIndex
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

--args string comboName, int selectedIndex
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

--args string listName, int selectedIndex
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

--args string textBlockName
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
      local menuLineText=InfLangProc.LangString"type_to_search"
      InfMgsvToExt.SetMenuLine(settingText,menuLineText)
      InfCore.ExtCmd("SelectAllText",menuLine)
      InfCore.WriteToExtTxt()
    end
  end
end

--args string textBlockName, string searchText
function this.EnterText(args)
  if args[3]==menuLine then
    local searchText=args[4]
    InfMenuDefs.searchMenu=InfMenu.BuildMenuDefForSearch(searchText)
    InfMenuDefs.BuildMenuItem("searchMenu",InfMenuDefs.searchMenu)
    InfMenu.GoMenu(InfMenuDefs.searchMenu)
    --local settingText=""
    --local menuLineText=InfLangProc.LangString"type_to_search"
    --InfMgsvToExt.SetMenuLine(settingText,menuLineText)
    --InfCore.WriteToExtTxt()
  end
end

--DEBUGNOW
--FoxKitToMgsv
function this.GetPlayerPos(args)
  --InfCore.Log("GetPlayerPos")--DEBUG
  local offsetY=0
  if Ivars.adjustCameraUpdate:Is(0) then--tex freecam not on
    offsetY=-0.783
    if PlayerInfo.OrCheckStatus{PlayerStatus.CRAWL} then
      offsetY = offsetY + 0.45
    end
  end

  InfCore.ExtCmd('GamePlayerPos',vars.playerPosX,vars.playerPosY,vars.playerPosZ,vars.playerRotY)
end

function this.GetCameraPos(args)
  InfCore.ExtCmd('GameCameraPos',
    vars.playerCameraPosition[0],vars.playerCameraPosition[1],vars.playerCameraPosition[2],
    vars.playerCameraRotation[0],vars.playerCameraRotation[1],vars.playerCameraRotation[2])
end

this.commands={
  extSession=this.ExtSession,
  input=this.Input,
  selected=this.Selected,
  selectedcombo=this.SelectedCombo,
  activate=this.Activate,
  togglemenu=this.ToggleMenu,
  GotKeyboardFocus=this.GotKeyboardFocus,
  EnterText=this.EnterText,
  --DEBUGNOW
  --FoxKitToMgsv
  GetPlayerPos=this.GetPlayerPos,
  GetCameraPos=this.GetCameraPos,
}

return this
