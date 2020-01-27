-- InfMgsvToExt.lua
local this={}

local concat=table.concat

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
  if vars.missionCode~=1 and vars.missionCode~=5 then
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
  if not this.uiElements[name] then
    InfCore.Log('WARNING: SetContent: could not find uiElement '..name)
    return
  end

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
  [[xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" ]],
  [[x:Name="menuLine" ]],
  [[Content="--menuLine--" ]],
  [[Foreground="White" ]],
  [[Background="Transparent" ]],
  [[FontSize="25" ]],
  [[Canvas.Left="140" ]],
  [[Canvas.Top="506">]],
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
  [[x:Name="inputLine" ]],
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
  this.CreateUiElement(menuElementName,table.concat(menuLineXaml))
  --DEBUGNOW this.CreateUiElement(inputElementName,table.concat(inputLineXaml))

  InfCore.ExtCmd('UiElementVisible',menuElementName,1)
  InfCore.ExtCmd('UiElementVisible',inputElementName,1)
end

function this.HideMenu()
  InfCore.ExtCmd('UiElementVisible',menuElementName,0)
  InfCore.ExtCmd('UiElementVisible',inputElementName,0)
end

function this.SetMenuLine(content)
  this.SetContent(menuElementName,content)
end

return this
