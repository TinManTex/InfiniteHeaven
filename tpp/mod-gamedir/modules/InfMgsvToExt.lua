-- InfMgsvToExt.lua
local this={}

local InfCore=InfCore
local ivars=ivars
local concat=table.concat
local type=type

this.debugModule=false

--FORMAT
--uiElements={
--  name={<uielement info>}
--}
this.uiElements={}

function this.PostModuleReload(prevModule)
  this.uiElements=prevModule.uiElements
end

function this.Init()
  --DEBUGNOW
  if vars.missionCode <=5 then
    this.ExtCmd("UiElementVisible","runningLabel",1)
  else
    this.ExtCmd("UiElementVisible","runningLabel",0)
  end
end

function this.ExtCmd(cmd,...)
  if not InfCore.IHExtRunning() then
    return
  end

  --tex ihExt hasnt started
  if InfCore.extSession==0 then
    return
  end

  InfCore.mgsvToExtCurrent=InfCore.mgsvToExtCurrent+1

  local args={...}--tex GOTOCHA doesnt catch intermediary params that are nil
  local message=InfCore.mgsvToExtCurrent..'|'..cmd
  if #args>0 then
    message=message..'|'..concat(args,'|')
  end

  if this.debugModule then
    InfCore.PrintInspect(message,"ExtCmd message")
  end

  InfCore.mgsvToExtCommands[InfCore.mgsvToExtCurrent]=message
  --if InfCore.extSession~=0 then--tex ihExt hasnt started
  InfCore.WriteToExtTxt()
  --end
  --InfCore.PrintInspect(this.mgsvToExtCommands)--DEBUG
end

--mgsvtoext commands
--tex creates a ui element from a wpf xaml definition
function this.CreateUiElement(name,xamlStr)
  if this.uiElements[name] then
    InfCore.Log('WARNING: CreateUiElement: uiElement '..name..' already exists')
    --DEBUGNOW return
  end

  this.uiElements[name]=xamlStr

  --InfCore.PrintInspect(xamlStr,'xamlStr')--DEBUG
  this.ExtCmd('CreateUiElement',name,xamlStr)
end

function this.RemoveUiElement(name)
  if not this.uiElements[name] then
    InfCore.Log('WARNING: RemoveElement: could not find uiElement '..name)
    return
  end

  this.ExtCmd('RemoveUiElement',name)
end

--Menu specific

--tex TODO: IHExt currently uses line end as command end so cant wrap whole lot in [[]]
--but this way defeats the purpose of being able to just copy over xaml from vs
local menuLineXaml={
  [[<Label ]],
  [[xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" ]],
  [[Name="menuLine" ]],
  [[Content="--menuLine--" ]],
  [[Foreground="White" ]],
  [[Background="Transparent" ]],
  [[FontSize="25" ]],
  [[Canvas.Left="45" ]],
  [[Canvas.Top="545">]],
  [[<Label.Effect>]],
  [[<DropShadowEffect ]],
  [[ShadowDepth="2" ]],
  [[Direction="325" ]],
  [[Color="Black" ]],
  [[Opacity="1" ]],
  [[BlurRadius="0.0"/>]],
  [[</Label.Effect>]],
  [[</Label>]],
}

local inputLineXaml={
  [[<TextBox ]],
  [[xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" ]],
  [[xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" ]],
  [[Name="inputLine" ]],
  [[Height="26" ]],
  [[MinWidth="36" ]],
  [[Foreground="White" ]],
  [[Background="Black" ]],
  [[FontSize="16"  ]],
  [[VerticalContentAlignment="Center" ]],
  [[Canvas.Left="140"  ]],
  [[Canvas.Top="558" ]],
  [[KeyDown="TextControl_OnEnter" ]],
  [[/>]],
}

local menuLine='menuLine'
local menuItems='menuItems'
local menuSetting='menuSetting'
local inputElementName='inputLine'
local UiElementVisible='UiElementVisible'

function this.ShowMenu()
  --DEBUGNOW this.CreateUiElement(menuLine,table.concat(menuLineXaml))
  --DEBUGNOW this.CreateUiElement(inputLine,table.concat(inputLineXaml))
  this.ExtCmd(UiElementVisible,'menuWrap',1)
  this.ExtCmd(UiElementVisible,'menuItems',1)
  this.ExtCmd(UiElementVisible,'menuTitle',1)
  this.ExtCmd(UiElementVisible,'menuHelp',ivars.enableHelp)
end

function this.HideMenu()
  this.ExtCmd(UiElementVisible,'menuWrap',0)
  this.ExtCmd(UiElementVisible,'menuItems',0)
  this.ExtCmd(UiElementVisible,'menuTitle',0)
  this.ExtCmd(UiElementVisible,'menuHelp',0)
end

function this.SetMenuLine(fullText,text)
  --DEBUGNOW ExtCmd('SetContent',menuElementName,text)
  this.ExtCmd('SetTextBox',menuLine,text)
  this.ExtCmd('UpdateTable',menuItems,InfMenu.currentIndex-1,fullText)
  this.ExtCmd('SelectItem',menuItems,InfMenu.currentIndex-1)
  --DEBUGNOW
  --DEBUGNOW setting the combo settings only needs to be run on selection of setting, selectcombo still needs to be run though
  local currentOption=InfMenu.GetCurrentOption()
  if currentOption and currentOption.optionType=="OPTION" then
    local currentSetting=ivars[currentOption.name]
    --      InfCore.Log("currentOption:"..currentOption.name.." ivar="..tostring(currentSetting))
    --      if currentOption.OnSelect then
    --        currentOption:OnSelect(ivars[currentOption.name])
    --      end

    local settingNames=currentOption.settingNames
    if type(currentOption.GetSettingText)=="function" then
      this.ExtCmd('SelectCombo',menuSetting,currentSetting)
    elseif settingNames then
      this.ExtCmd('SelectCombo',menuSetting,currentSetting)
    elseif currentOption.settings then
      this.ExtCmd('SelectCombo',menuSetting,currentSetting)
    elseif currentSetting then--tex just a straight value
      this.ExtCmd('ClearCombo',menuSetting)
      this.ExtCmd('AddToCombo',menuSetting,currentSetting)
      this.ExtCmd('SelectCombo',menuSetting,0)
    end
  end
end

function this.TakeFocus()
  this.ExtCmd('TakeFocus')
end

return this
