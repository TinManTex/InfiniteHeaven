--InfExtToMgsv.lua
local this={}

local concat=table.concat

function this.Update(currentChecks,currentTime,execChecks,execState)
  if not ivars.enableIHExt then
    return
  end

  this.ProcessCommands()
end

function this.DoToMgsvCommand(args)
  --InfCore.PrintInspect(args,'DoToMgsvCommand '..args[1])--DEBUGNOW

  --<messageId>|input|<elementName>|<input string>
  if args[2]=="input" and args[3]=="inputLine" and args[4] then
    local currentOption
    if InfMenu.currentMenuOptions then--DEBUGNOW KLUDGE
      currentOption=InfMenu.GetCurrentOption()
    end

    local commandArgs=InfUtil.Split(args[4],' ')
    if #commandArgs>0 then
      if commandArgs[1]=='>' then
        if currentOption then
          InfMenu.NextSetting()
          InfMenu.DisplayCurrentSetting()
        end
      elseif commandArgs[1]=='<' then
        if currentOption then
          InfMenu.PreviousSetting()
          InfMenu.DisplayCurrentSetting()
        end
      elseif commandArgs[1]=='<<' then
        if currentOption then
          InfMenu.GoBackCurrent()
          InfMenu.DisplayCurrentSetting()
        end
      elseif commandArgs[1]=='>>' then
        if currentOption then
          if not commandArgs[2] then

          else
            local menuIndex=tonumber(commandArgs[2])
            if menuIndex and menuIndex>1 and menuIndex<=#InfMenu.currentMenuOptions then
              InfMenu.currentIndex=menuIndex
              InfMenu.GetSetting()
              InfMenu.DisplayCurrentSetting()
            end
          end
        end
        --      elseif commandArgs[1]=='?' then
        --        if currentOption then
        --          local helpText=InfMenu.GetCurrentHelpText()
        --          InfCore.ExtCmd('print',helpText)
        --          InfMenu.DisplayCurrentSetting()
        --        end
      else
        if currentOption then
          local setting=tonumber(args[4]) or args[4]
          IvarProc.SetSetting(currentOption,setting)
          InfMenu.DisplayCurrentSetting()
        end
      end
    end
  end
end

local tonumber=tonumber
function this.ProcessCommands()
  local extToMgsvPrev=InfCore.extToMgsvComplete
  local extPrevSession=InfCore.extSession
  local lines=InfCore.GetLines(InfCore.toMgsvCmdsFilePath)

  if not lines then
    InfCore.Log('Could not read ih_toMgsvCmds')
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
              InfCore.ExtCmd('sessionChange')--tex a bit of nothing to get the mgsvTpExtComplete to update from the message, ext does likewise
            end
            InfCore.mgsvToExtComplete=args[3]
          elseif messageId>InfCore.extToMgsvComplete then
            this.DoToMgsvCommand(args)

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

return this
