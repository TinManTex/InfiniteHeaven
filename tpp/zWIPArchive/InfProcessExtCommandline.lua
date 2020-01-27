--InfExtToMgsv.lua
local this={}

function this.Update(currentChecks,currentTime,execChecks,execState)
  if ivars.postExtCommands==0 then
    return
  end

  InfCore.PCallDebug(InfCore.DoExtToMgsvCommands)
end

function this.DoToMgsvCommand(args)
  --InfCore.PrintInspect(args,'DoToMgsvCommand '..args[1])--DEBUGNOW

  --DEBUGNOW commands
  --some way of navigating menu by number
  -- >2 = select option (or gomenu (if that option was a menu?)

  -- < = back a menu

  -- --announce_off -- turns off menu announce/displaysetting in game, reset on menu close or IHExt exit.

  --set current setting by just typing
  --if number try and set value (within bounds) of current
  --if text try and set setting

  --exec <whatevs> lua loadstring whatevs
  --

  if args[2] then
    local currentOption
    if InfMenu.currentMenuOptions then--DEBUGNOW KLUDGE
      currentOption=InfMenu.GetCurrentOption()
    end

    local commandArgs=InfUtil.Split(args[2],' ')
    if #commandArgs>0 then
      if commandArgs[1]=='>' then
        if currentOption then
          InfMenu.NextSetting()
          this.DisplayCurrentOption()
        end
      elseif commandArgs[1]=='<' then
        if currentOption then
          InfMenu.PreviousSetting()
          this.DisplayCurrentOption()
        end
      elseif commandArgs[1]=='<<' then
        if currentOption then
          InfMenu.GoBackCurrent()
          this.DisplayCurrentOption()
        end
      elseif commandArgs[1]=='>>' then
        if currentOption then
          if not commandArgs[2] then

          else
            local menuIndex=tonumber(commandArgs[2])
            if menuIndex and menuIndex > 1 and menuIndex<=#InfMenu.currentMenuOptions then
              InfMenu.currentIndex=menuIndex
              InfMenu.GetSetting()
              this.DisplayCurrentOption()
            end
          end
        end
      elseif commandArgs[1]=='?' then
        if currentOption then
          local helpText=InfMenu.GetCurrentHelpText()
          InfCore.ExtCmd('print',helpText)
          this.DisplayCurrentOption()
        end
      else
        if currentOption then
          InfCore.Log('args[2]:'..args[2])--DEBUGNOW
          InfCore.Log('type args[2]:'..type(args[2]))--DEBUGNOW
          InfCore.Log('tonumber args[2]:'..tostring(tonumber(args[2])))--DEBUGNOW

          local setting=tonumber(args[2]) or args[2]
          IvarProc.SetSetting(currentOption,setting)
          this.DisplayCurrentOption()
        end
      end
    end
  end
end

function this.DisplayCurrentOption()
  local currentOption=InfMenu.GetCurrentOption()
  local settingText=InfMenu.GetSettingText(InfMenu.currentIndex,currentOption,false,true)
  InfCore.ExtCmd('print',settingText)
end

return this
