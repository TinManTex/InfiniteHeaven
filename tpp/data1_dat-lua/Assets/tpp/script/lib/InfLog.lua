-- DOBUILD: 1
-- InfLog.lua
local this={}

--STATE
this.debugMode=true--tex (See GOTCHA below -v-)
this.doneStartup=false
this.doneFirstLoad=false

this.log={}

this.modules={}

this.str32ToString={}
this.unknownStr32={}
--
local nl="\r\n"

local stringType="string"
local functionType="function"

function this.Add(message,announceLog)
  --tex GOTCHA, true setting wont kick in till gvars is initiallized, would be solved if shifting away from gvars to direct file save/load
  if evars and evars.debugMode then
    this.debugMode=evars.debugMode>0
  end
  if this.debugMode==false then
    return
  end

  if announceLog then
    this.DebugPrint(message)
  end

  local elapsedTime=Time.GetRawElapsedTimeSinceStartUp()

  local line="|"..elapsedTime.."|"..message
  this.log[#this.log+1]=line

  this.WriteLog(this.log)
end

function this.WriteLog(log)
  local filePath=this.logFilePath

  --tex NOTE io open append doesnt appear to work - 'Domain error'
  local logFile,error=io.open(filePath,"w")
  if not logFile or error then
    --this.DebugPrint("Create log error: "..tostring(error))
    this.logErr=tostring(error)
    return
  end

  logFile:write(table.concat(log,nl))
  logFile:close()
end

function this.WriteLogLine(message)
  local filePath=this.logFilePath

  --tex NOTE io open append doesnt appear to work - 'Domain error'
  --TODO think which would be better, just appending to string then writing that
  --or (doing currently) reading exising and string append/write that
  --either way performance will decrease as log size increases
  local logFile,error=io.open(filePath,"r")
  local logText=""
  if logFile then
    logText=logFile:read("*all")
    logFile:close()
  end

  local logFile,error=io.open(filePath,"w")
  if not logFile or error then
    --this.DebugPrint("Create log error: "..tostring(error))
    return
  end

  local elapsedTime=Time.GetRawElapsedTimeSinceStartUp()
  --tex TODO os time?


  if type(message)~=stringType then
    message=tostring(message)
  end

  local line="|"..elapsedTime.."|"..message
  logFile:write(logText..line,nl)
  logFile:close()
end

function this.CopyFileToPrev(fileName,ext)
  local filePath=this.modPath..fileName..ext
  local file,error=io.open(filePath,"r")
  if file and not error then
    local fileText=file:read("*all")
    file:close()

    local filePathPrev=this.modPath..fileName..this.prev..ext
    local filePrev,error=io.open(filePathPrev,"w")
    if not filePrev or error then
      return
    end

    filePrev:write(fileText)
    filePrev:close()
  end
end

function this.ClearFile(fileName,ext)
  local filePath=this.modPath..fileName..ext
  local logFile,error=io.open(filePath,"w")
  if logFile then
    logFile:write""
    logFile:close()
  end
end
--

local MAX_ANNOUNCE_STRING=255 --288--tex sting length announce log can handle before crashing the game, a bit worried that it's actually kind of a random value at 288 (and yeah I manually worked this value out by adjusting a string and reloading and crashing the game till I got it exact lol).
function this.DebugPrint(message,...)
  if message==nil then
    TppUiCommand.AnnounceLogView("nil")
    return
  elseif type(message)~=stringType then
    message=tostring(message)
  end

  if ... then
  --message=string.format(message,...)--DEBUGNOW
  end

  while string.len(message)>MAX_ANNOUNCE_STRING do
    local printMessage=string.sub(message,0,MAX_ANNOUNCE_STRING)
    TppUiCommand.AnnounceLogView(printMessage)
    message=string.sub(message,MAX_ANNOUNCE_STRING+1)
  end

  TppUiCommand.AnnounceLogView(message)
end

function this.PCall(func,...)
  if func==nil then
    this.Add("PCall func == nil")
    return
  elseif type(func)~=functionType then
    this.Add("PCall func~=function")
    return
  end

  local sucess,result=pcall(func,...)
  if not sucess then
    this.Add(result)
    this.Add("caller:"..this.DEBUG_Where(2))
    return
  else
    return result
  end
end

--tex as above but intended to pass through unless debugmode on
function this.PCallDebug(func,...)
  --  if func==nil then
  --    this.Add("PCallDebug func == nil")
  --    return
  --  elseif type(func)~=functionType then
  --    this.Add("PCallDebug func~=function")
  --    return
  --  end

  --tex TODO: see GOTCHA in Add.
  if Ivars and evars and evars.debugMode then
    this.debugMode=evars.debugMode>0
  end

  if not this.debugMode then
    return func(...)
  end

  local sucess, result=pcall(func,...)
  if not sucess then
    InfLog.Add(result)
    InfLog.Add(this.DEBUG_Where(2))
    return
  else
    return result
  end
end

function this.PrintInspect(inspectee,announceLog,force)
  if not this.debugMode and not force then
    return
  end

  local ins=InfInspect.Inspect(inspectee)
  this.Add(ins,announceLog)
end

--tex altered from Tpp.DEBUG_Where
function this.DEBUG_Where(stackLevel)
  --defining second param of getinfo can help peformance a bit
  --`n´ selects fields name and namewhat
  --`f´ selects field func
  --`S´ selects fields source, short_src, what, and linedefined
  --`l´ selects field currentline
  --`u´ selects field nup
  local stackInfo=debug.getinfo(stackLevel+1,"Snl")
  if stackInfo then
    return stackInfo.short_src..(":"..stackInfo.currentline.." - "..(stackInfo and stackInfo.name or ""))
  end
  return"(unknown)"
end

function this.AddFlow(message)
  if Ivars.debugFlow:Is(0) then
    return
  end
  --  local stackLevel=2
  --  local stackInfo=debug.getinfo(stackLevel,"n")
  --  this.Add(tostring(stackInfo.name).."| "..message)
  this.Add(message)
end

--tex would rather have this in InfLookup, but needs to be loaded before libModules
--tex registers string for InfLookup.StrCode32ToString
local StrCode32=Fox.StrCode32
function this.StrCode32(encodeString)
  local strCode=StrCode32(encodeString)
  if this.debugMode then
    this.str32ToString[strCode]=encodeString
  end
  return strCode
end

--tex NMC from lua wiki
local function Split(str,delim,maxNb)
  -- Eliminate bad cases...
  if string.find(str,delim)==nil then
    return{str}
  end
  if maxNb==nil or maxNb<1 then
    maxNb=0--No limit
  end
  local result={}
  local pat="(.-)"..delim.."()"
  local nb=0
  local lastPos
  for part,pos in string.gfind(str,pat) do
    nb=nb+1
    result[nb]=part
    lastPos=pos
    if nb==maxNb then break end
  end
  -- Handle the last field
  if nb~=maxNb then
    result[nb+1]=string.sub(str,lastPos)
  end
  return result
end

--tex TODO, not having luck with either approach, something stopping assignment to global
--might have to keep the module reference here in InfLog instead, at this point the module is less InfLog than InfBootstrap lol
function this.LoadExternalModuleRequire(moduleName)
  local sucess,module=pcall(require,moduleName)
  if not sucess then
    InfLog.Add(module)
  else
    --    _G[moduleName]=module
    --    if not _G[moduleName] then
    --      InfLog.Add("cannot find module in global "..moduleName)
    --    end
    this[moduleName]=module
    this.modules[moduleName]=module
    return module
  end
end

function this.LoadExternalModuleLoadFile(moduleName)
  local modulePath=this.gamePath..this.modPath..moduleName..".lua"
  local sucess,module=pcall(loadfile,modulePath)
  if not sucess then
    InfLog.Add(module)
  else
    _G[moduleName]=module()
    InfLog.Add("Loaded "..moduleName)
    if not _G[moduleName] then
      InfLog.Add("could not find module in global "..moduleName)
    end
  end
end

local function GetGamePath()
  local gamePath=""
  local paths=Split(package.path,";")
  for i,path in ipairs(paths) do
    if string.find(path,"MGS_TPP") then
      gamePath=path
      break
    end
  end
  local stripLength=10--tex length "\lua\?.lua"
  gamePath=gamePath:gsub("\\","/")--tex because escaping sucks
  gamePath=gamePath:sub(1,-stripLength)
  return gamePath
end

this.modSubPath="mod/"
this.logFileName="ih_log"
this.prev="_prev"
this.ext=".txt"

--hook
--tex no dice
--this.FoxLog=Fox.Log
--Fox.Log=function(message)
--  this.AddMessage(message)
--  this.FoxLog(message)
--end

--local print=print
--print=function(...)
--  InfLog.Add(...,true)
--  print(...)
--end

--EXEC
this.gamePath=GetGamePath()
--this.gamePath=[[C:\GamesSD\MGS_TPP\]]--DEBUG override
this.modPath=this.gamePath..this.modSubPath
this.logFilePath=this.modPath..this.logFileName..this.ext
this.logFilePathPrev=this.modPath..this.logFileName..this.prev..this.ext

package.path=package.path..";"..this.modPath.."?.lua"

this.CopyFileToPrev(this.logFileName,this.ext)
this.ClearFile(this.logFileName,this.ext)

local time=os.date("%x %X")
this.Add("InfLog start "..time)
--this.Add(package.path)--DEBUG
return this
