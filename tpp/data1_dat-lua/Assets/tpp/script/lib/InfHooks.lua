-- DOBUILD: 1
-- InfHooks.lua
local this={}

local InfCore=InfCore
local PCall=InfCore.PCall
local stringFormat=string.format

this.debugHooksEnabled=false

--tex GOTCHA be cautious when hooking scripts that can be reloaded (like scriptblocks or IH external modules)
--scriptblocks are also more likely to cause yield across c-call boundary.
--pre-hooking (calling your hook function before the original function) will allow multiple-return functions to return as normal
--can also isolate your hook function in a pcall to isolate it crashing from impacting the original function
this.hookFuncs={
  TppSave={
    VarRestoreOnMissionStart=function()
      InfCore.LogFlow("InfHook TppSave.VarRestoreOnMissionStart")
      this.TppSave.VarRestoreOnMissionStart()
      --post-hook
      IvarProc.OnLoadVarsFromSlot()
    end,
    VarRestoreOnContinueFromCheckPoint=function()
      InfCore.LogFlow("InfHook TppSave.VarRestoreOnContinueFromCheckPoint")
      this.TppSave.VarRestoreOnContinueFromCheckPoint()

      IvarProc.OnLoadVarsFromSlot()
    end,
    DoSave=function(saveParams,force)
      InfCore.LogFlow("InfHook TppSave.DoSave")
      local saveResult=this.TppSave.DoSave(saveParams,force)

      InfMain.OnSave(saveParams,force)
      return saveResult
    end,
  },
--tex no go for some reason.
--  LoadGameDataFromSaveFile=function(area)
--    return InfCore.PCall(function(area)--DEBUG
--    --InfCore.LogFlow("InfHook TppSave.LoadGameDataFromSaveFile("..tostring(area)..")")
--    local loadResult=this.LoadGameDataFromSaveFile(area)


--    return loadResult
--    end,area)--DEBUG
--  end,
}

this.debugPCallHooks={
  TppQuest={
    UpdateActiveQuest=true,
  },
  TppAnimal={
    OnActivateQuest=true,
    OnDeactivateQuest=true,
    CheckQuestAllTarget=true,
  },
  TppEnemy={
    OnActivateQuest=true,
    OnDeactivateQuest=true,
    CheckQuestAllTarget=true,
  },
  TppGimmick={
    OnActivateQuest=true,
    OnDeactivateQuest=true,
    CheckQuestAllTarget=true,
  },
  TppMission={
    UpdateObjective=true,
  },
}

function this.GetFunction(moduleName,functionName)
  local originalModule=_G[moduleName]
  local originalFunction=nil
  if not originalModule then
    InfCore.Log("WARNING: InfHooks.GetFunction could not find module:"..tostring(moduleName))
  else
    originalFunction=originalModule[functionName]
    if originalFunction==nil then
      InfCore.Log("WARNING: InfHooks.GetFunction could not find function:"..moduleName.."."..tostring(functionName))
    end
  end
  return originalModule,originalFunction
end

function this.AddHook(moduleName,functionName,hookFunction)
  local originalModule,originalFunction=this.GetFunction(moduleName,functionName)
  if originalModule and originalFunction then
    if type(hookFunction)~="function" then
      InfCore.Log("Error: InfHook.AddHook("..moduleName..","..functionName..") hookFunc is not a function")
    else
      this[moduleName]=this[moduleName]or{}--tex existing or new
      local moduleHooks=this[moduleName]
      if moduleHooks[functionName] then
        --tex TODO: just swap out existing hook using original, but log a warning
        InfCore.Log("Error: attempting to add a hook to a previously hooked function: "..moduleName.."."..functionName)
      else
        moduleHooks[functionName]=originalFunction--tex save original function ref
        originalModule[functionName]=hookFunction--tex override
      end
    end
  end
end

function this.RemoveHook(moduleName,functionName)
  local hookedModule,hookedFunction=this.GetFunction(moduleName,functionName)
  if hookedModule and hookedFunction then
    local moduleHooks=this[moduleName]
    if not moduleHooks then
      InfCore.Log("Error: InfHook.RemoveHook cannot find any hooks for module: "..moduleName.."."..functionName)
    else
      local originalFunction=moduleHooks[functionName]
      if not originalFunction then
        InfCore.Log("Error: InfHook.RemoveHook cannot find any hook for function: "..moduleName.."."..functionName)
      else
        hookedModule[functionName]=originalFunction--tex restore
        moduleHooks[functionName]=nil--tex clear
      end
    end
  end
end

function this.CreatePreHookShim(moduleName,functionName,hookFunction)
  local originalModule,originalFunction=this.GetFunction(moduleName,functionName)
  if originalModule and originalFunction then
    local ShimFunction=function(...)
      hookFunction(...)
      return originalFunction(...)
    end
    return ShimFunction
  end
  return nil
end

local flowFmt="InfHook %s.%s"
--tex GOTCHA doesn't handle multiple return
function this.CreatePostHookDebugShim(moduleName,functionName,hookFunction)
  local originalModule,originalFunction=this.GetFunction(moduleName,functionName)
  if originalModule and originalFunction then
    local ShimFunction=function(...)
      InfCore.LogFlow(stringFormat(flowFmt,moduleName,functionName))
      local ret=PCall(originalFunction,...)
      local hookRet=PCall(hookFunction,...,ret)

      return hookRet or ret
    end
    return ShimFunction
  end
  return nil
end

--tex for wrapping a function in PCall and giving an LogFlow call
function this.CreateDebugWrap(moduleName,functionName)
  local flowFmt="InfHook DebugPreWrap %s.%s"
  local originalModule,originalFunction=this.GetFunction(moduleName,functionName)
  if originalModule and originalFunction then
    local ShimFunction=function(...)
      InfCore.LogFlow(stringFormat(flowFmt,moduleName,functionName))
      return PCall(originalFunction,...)
    end
    return ShimFunction
  end
  return nil
end

function this.SetupDebugHooks()
  if not this.debugHooksEnabled then
    this.debugHooksEnabled=true
    this.AddDebugHooks(this.debugPCallHooks,true)
  end
end

--hookDef table format: this.debugPCallHooks
function this.AddDebugHooks(hookDef,enable)
  for moduleName,moduleHooks in pairs(hookDef)do
    for functionName,hookInfo in pairs(moduleHooks)do
      if hookInfo==true then
        local originalModule,originalFunction=this.GetFunction(moduleName,functionName)
        if originalModule and originalFunction then
          if enable then
            local wrapper=this.CreateDebugWrap(moduleName,functionName)
            this.AddHook(moduleName,functionName,wrapper)
          else
            this.RemoveHook(moduleName,functionName)
          end
        end
      end
    end
  end
end

local function AddHooks(hookFuncs)
  for moduleName,moduleHooks in pairs(hookFuncs)do
    for functionName,hookFunction in pairs(moduleHooks)do
      this.AddHook(moduleName,functionName,hookFunction)
    end
  end
end
InfCore.PCallDebug(AddHooks,this.hookFuncs)

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

InfCore.LogFlow"InfHook done, requires-list done"--tex ASSUMPTION infhooks last in requires list

return this
