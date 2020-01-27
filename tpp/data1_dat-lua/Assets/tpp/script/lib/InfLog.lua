-- DOBUILD: 1
-- InfLog.lua
local this={}

--STATE
this.debugMode=true--tex non user till I get this sorted (See GOTCHA -v-)

--
this.gamePath="C:\\GamesSD\\MGS_TPP"--tex TODO: find a way to get games path, otherwise have a chicken and egg
this.modPath="\\mod"
this.logFileName="ih_log"
local prev="_prev"
local ext=".txt"

local logFilePath=this.gamePath..this.modPath.."\\"..this.logFileName..ext
local logFilePathPrev=this.gamePath..this.modPath.."\\"..this.logFileName..prev..ext

local nl="\r\n"

local stringType="string"
local functionType="function"

function this.Add(message,announceLog)
  --tex GOTCHA, true setting wont kick in till gvars is initiallized, would be solved if shifting away from gvars to direct file save/load
  if Ivars and gvars and gvars.debugMode then
    this.debugMode=Ivars.debugMode:Is()>0
  end
  if this.debugMode==false then
    return
  end

  local filePath=logFilePath

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

  local line="|"..elapsedTime.."|"..message
  logFile:write(logText..line,nl)
  logFile:close()

  if announceLog then
    this.DebugPrint(line)
  end
end

local function CopyLogToPrev()
  local logFile,error=io.open(logFilePath,"r")
  if logFile and not error then
    local logText=logFile:read("*all")
    logFile:close()

    local logFilePrev,error=io.open(logFilePathPrev,"w")
    if not logFilePrev or error then
      return
    end

    logFilePrev:write(logText)
    logFilePrev:close()

    local logFile,error=io.open(logFilePath,"w")
    if logFile then
      logFile:write""--tex clear
      logFile:close()
    end
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

  local sucess, result=pcall(func,...)
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
  if func==nil then
    this.Add("TryFunc func == nil")
    return
  elseif type(func)~=functionType then
    this.Add("TryFunc func~=function")
    return
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

function this.PrintInspect(inspectee,options,announceLog)
  local ins=InfInspect.Inspect(inspectee,options)
  this.Add(ins,announceLog)
end

function this.DEBUG_Where(stackLevel)
  --defining second param of getinfo can help peformance a bit
  --`n´ selects fields name and namewhat
  --`f´ selects field func
  --`S´ selects fields source, short_src, what, and linedefined
  --`l´ selects field currentline
  --`u´ selects field nup
  local stackInfo=debug.getinfo(stackLevel+1,"Snl")
  if stackInfo then
    return stackInfo.short_src..(":"..stackInfo.currentline.." - "..stackInfo.name)
  end
  return"(unknown)"
end


--hook
--tex no dice
--this.FoxLog=Fox.Log
--Fox.Log=function(message)
--  this.AddMessage(message)
--  this.FoxLog(message)
--end

--EXEC
CopyLogToPrev()

local time=os.date("%x %X")
this.Add("InfLog start "..time)

return this
