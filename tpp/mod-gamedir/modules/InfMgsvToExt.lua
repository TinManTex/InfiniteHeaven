-- InfMgsvToExt.lua
local this={}

local concat=table.concat

this.debugModule=false--DEBUGNOW

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
    InfCore.ExtCmd("UiElementVisible","runningLabel",1)
  else
    InfCore.ExtCmd("UiElementVisible","runningLabel",0)
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

  local args={...}--tex doesnt catch intermediary params that are nil
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
  InfCore.ExtCmd('CreateUiElement',name,xamlStr)
end

function this.RemoveUiElement(name)
  if not this.uiElements[name] then
    InfCore.Log('WARNING: RemoveElement: could not find uiElement '..name)
    return
  end

  InfCore.ExtCmd('RemoveUiElement',name)
end

--tex set Content on uiElement
function this.SetContent(name,content)
  --  if not this.uiElements[name] then
  --    InfCore.Log('WARNING: SetContent: could not find uiElement '..name)
  --    return
  --  end

  if type(content)~='string' then
    InfCore.Log('WARNING: SetContent: content is not string')
    return
  end

  InfCore.ExtCmd('SetContent',name,content)
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

local menuElementName='menuLine'
local inputElementName='inputLine'
function this.ShowMenu()
  --DEBUGNOW this.CreateUiElement(menuElementName,table.concat(menuLineXaml))
  --DEBUGNOW this.CreateUiElement(inputElementName,table.concat(inputLineXaml))
  InfCore.ExtCmd('UiElementVisible','menuWrap',1)
  InfCore.ExtCmd('UiElementVisible','menuItems',1)
  InfCore.ExtCmd('UiElementVisible','menuTitle',1)
  if ivars.enableHelp>0 then
    InfCore.ExtCmd('UiElementVisible','menuHelp',1)
  end
end

function this.HideMenu()
  InfCore.ExtCmd('UiElementVisible','menuWrap',0)
  InfCore.ExtCmd('UiElementVisible','menuItems',0)
  InfCore.ExtCmd('UiElementVisible','menuTitle',0)
  InfCore.ExtCmd('UiElementVisible','menuHelp',0)
end

function this.SetMenuLine(fullText,text)
  InfCore.ExtCmd('SetContent',menuElementName,text)
  InfCore.ExtCmd('UpdateTable','menuItems',InfMenu.currentIndex-1,fullText)
  InfCore.ExtCmd('SelectItem','menuItems',InfMenu.currentIndex-1)
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
      InfCore.ExtCmd('SelectCombo','menuSetting',currentSetting)
    elseif settingNames then
      InfCore.ExtCmd('SelectCombo','menuSetting',currentSetting)
    elseif currentOption.settings then
      InfCore.ExtCmd('SelectCombo','menuSetting',currentSetting)
    elseif currentSetting then--tex just a straight value
      InfCore.ExtCmd('ClearCombo','menuSetting')
      InfCore.ExtCmd('AddToCombo','menuSetting',currentSetting)
      InfCore.ExtCmd('SelectCombo','menuSetting',0)
    end
  end
end

function this.TakeFocus()
  InfCore.ExtCmd('TakeFocus')
end

return this
