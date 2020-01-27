-- DOBUILD: 1
-- InfHooks.lua
local this={}

local InfLog=InfLog

--tex you should post-hook unless totally nessesary so any errors in function wont stop the call to the original function (though functions that rely on return values will still reak)
--tex GOTCHA cant have multiple functions of same name (if it becomes issue just divert to this.<moduleName>.<hooked func name>
this.hookFuncs={
  TppSave={
    VarRestoreOnMissionStart=function()
      InfLog.AddFlow("InfHook TppSave.VarRestoreOnMissionStart")
      this.VarRestoreOnMissionStart()
      --post-hook
      IvarProc.OnLoadVarsFromSlot()
    end,
    VarRestoreOnContinueFromCheckPoint=function()
      InfLog.AddFlow("InfHook TppSave.VarRestoreOnContinueFromCheckPoint")
      this.VarRestoreOnContinueFromCheckPoint()

      IvarProc.OnLoadVarsFromSlot()
    end,
    DoSave=function(saveParams,force)
      InfLog.AddFlow("InfHook TppSave.DoSave")
      local saveResult=this.DoSave(saveParams,force)

      InfMain.OnSave(saveParams,force)
      return saveResult
    end,
  },
  --tex no go for some reason.
--  LoadGameDataFromSaveFile=function(area)
--    return InfLog.PCall(function(area)--DEBUG
--    --InfLog.AddFlow("InfHook TppSave.LoadGameDataFromSaveFile("..tostring(area)..")")
--    local loadResult=this.LoadGameDataFromSaveFile(area)


--    return loadResult
--    end,area)--DEBUG
--  end,
}

for moduleName,moduleHooks in pairs(this.hookFuncs)do
  for functionName,hookFunction in pairs(moduleHooks)do
    this[functionName]=_G[moduleName][functionName]--tex save original function ref
    _G[moduleName][functionName]=hookFunction--tex override
  end
end

--this.AnnounceLogView=TppUiCommand.AnnounceLogView
--TppUiCommand.AnnounceLogView=function(message)
--  this.AnnounceLogView(message)
--end
--
--this.AnnounceLogViewLangId=TppUiCommand.AnnounceLogViewLangId
--TppUiCommand.AnnounceLogViewLangId=function(...)
--  this.AnnounceLogViewLangId(...)
--end
--
--this.AnnounceLogViewJoinLangId=TppUiCommand.AnnounceLogViewJoinLangId
--TppUiCommand.AnnounceLogViewJoinLangId=function(...)
--  this.AnnounceLogViewJoinLangId(...)
--end

InfLog.AddFlow"InfHook done, requires-list done"--tex ASSUMPTION infhooks last in requires list

return this
