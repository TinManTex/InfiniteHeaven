-- DOBUILD: 1
-- InfCore.lua
local this={}

--LOCALOPT
local pcall=pcall
local type=type
local open=io.open
local tostring=tostring
local concat=table.concat
local string=string
local GetRawElapsedTimeSinceStartUp=Time.GetRawElapsedTimeSinceStartUp

local InfUtil=InfUtil
local InfCore=this

local emptyTable={}

this.modVersion="205"
this.modName="Infinite Heaven"

--STATE
this.debugMode=true--tex (See GOTCHA below -v-)
--tex TODO combine into loadState
this.doneStartup=false
this.modDirFail=false
this.ihSaveFirstLoad=false
this.gameSaveFirstLoad=false
this.mainModulesOK=false
this.otherModulesOK=false

this.log={}

this.currentCmdIndex=0
this.output={}
this.extCmdIndex={}--tex map [cmd index]=output index

this.logErr=""
this.str32ToString={}
this.unknownStr32={}
this.unknownMessages={}
--
local nl="\r\n"

local stringType="string"
local functionType="function"

--GOTCHA since io open append doesnt appear to work ('Domain error') I'm writing the whole log to file on every Add
--which is naturally bad performance for a lot of frequent Adds.
function this.Log(message,announceLog,force)
  if not this.debugMode and not force then
    return
  end

  if announceLog then
    this.DebugPrint(message)
  end

  local elapsedTime=GetRawElapsedTimeSinceStartUp()

  local line="|"..elapsedTime.."|"..message
  this.log[#this.log+1]=line

  if Mock then
    print(line)
  end

  this.WriteLog(this.logFilePath,this.log)
end

--tex cant log error to log if log doesnt log lol
function this.WriteLog(filePath,log)
  local logFile,openError=open(filePath,"w")
  if not logFile or openError then
    --this.DebugPrint("Create log error: "..tostring(error))
    this.logErr=tostring(openError)
    return
  end

  logFile:write(concat(log,nl))
  logFile:close()
end

function this.WriteStringTable(filePath,stringTable)
  local logFile,openError=open(filePath,"w")
  if not logFile or openError then
    this.Log(openError)
    return
  end

  logFile:write(concat(stringTable,nl))
  logFile:close()
end

function this.WriteLogLine(message)
  local filePath=this.logFilePath

  --tex NOTE io open append doesnt appear to work - 'Domain error'
  --TODO think which would be better, just appending to string then writing that
  --or (doing currently) reading exising and string append/write that
  --either way performance will decrease as log size increases
  local logFile,openError=open(filePath,"r")
  local logText=""
  if logFile then
    logText=logFile:read("*all")
    logFile:close()
  end

  local logFile,openError=open(filePath,"w")
  if not logFile or openError then
    --this.DebugPrint("Create log error: "..tostring(error))
    return
  end

  local elapsedTime=GetRawElapsedTimeSinceStartUp()
  --tex TODO os time?


  if type(message)~=stringType then
    message=tostring(message)
  end

  local line="|"..elapsedTime.."|"..message
  logFile:write(logText..line,nl)
  logFile:close()
end

function this.FileExists(filePath)
  local file,openError=open(filePath,"r")
  if file and not openError then
    file:close()
    return true
  end
  return false
end

function this.CopyFileToPrev(path,fileName,ext)
  local filePath=path..fileName..ext
  local file,openError=open(filePath,"r")
  if file and not openError then
    local fileText=file:read("*all")
    file:close()

    local filePathPrev=path..fileName..this.prev..ext
    local filePrev,openError=open(filePathPrev,"w")
    if not filePrev or openError then
      return
    end

    filePrev:write(fileText)
    filePrev:close()
  end
end

function this.ClearFile(path,fileName,ext)
  local filePath=path..fileName..ext
  local logFile,openError=open(filePath,"w")
  if logFile then
    logFile:write""
    logFile:close()
  else
    return openError
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
    message=string.format(message,...)
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
    this.Log("PCall func == nil")
    return
  elseif type(func)~=functionType then
    this.Log("PCall func~=function")
    return
  end

  local sucess,result=pcall(func,...)
  if not sucess then
    this.Log("ERROR:"..result)
    this.Log("caller:"..this.DEBUG_Where(2))
    return
  else
    return result
  end
end

--tex as above but intended to pass through unless debugmode on
function this.PCallDebug(func,...)
  --  if func==nil then
  --    this.Log("PCallDebug func == nil")
  --    return
  --  elseif type(func)~=functionType then
  --    this.Log("PCallDebug func~=function")
  --    return
  --  end

  if not this.debugMode then
    return func(...)
  end

  local sucess, result=pcall(func,...)
  if not sucess then
    this.Log("ERROR:"..result)
    this.Log("caller:"..this.DEBUG_Where(2))
    return
  else
    return result
  end
end

function this.PrintInspect(var,options)
  if not this.debugMode and (options and not options.force) then
    return
  end
  options=options or emptyTable
  local varName=options.varName or options
  local ins=InfInspect.Inspect(var)
  if type(varName)=="string" then
    ins=varName.."="..ins
  end
  this.Log(ins,options.announceLog)
end

function this.ExtCmd(cmd,args)
  if ivars.postExtCommands==0 then
    return
  end

  this.currentCmdIndex=this.currentCmdIndex+1

  args=args or {}
  if type(args)=="string" then
    args={args}
  end

  local message=this.currentCmdIndex.."|"..cmd
  if #args>0 then
    message=message.."|"..table.concat(args,"|")
  end
  this.extCmdIndex[this.currentCmdIndex]=message
  this.output[this.currentCmdIndex]=message

  --InfCore.PrintInspect(this.output)--DEBUG

  this.WriteLog(this.toExtCmdsFilePath,this.output)
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

function this.LogFlow(message)
  if not this.debugMode then
    return false
  end
  --  local stackLevel=2
  --  local stackInfo=debug.getinfo(stackLevel,"n")
  --  this.Log(tostring(stackInfo.name).."| "..message)
  this.Log(message)
end

function this.Validate(format,profile,name)
  for keyName,valueType in pairs(profile) do
    if format[keyName] and type(profile[keyName])~=format[keyName] then
      InfCore.Log("InfCore.Validate "..tostring(name)..": Failed - "..tostring(keyName).." =="..type(keyName).." expected "..tostring(format[keyName]))
      return false
    end
  end
  return true
end

--tex TODO: could be in InfLookup, but fine here for now to keep as depenancies on InfLookup low
--tex registers string for InfLookup.StrCode32ToString
local StrCode32=Fox.StrCode32
function this.StrCode32(encodeString)
  local strCode=StrCode32(encodeString)
  if this.debugMode then
    if type(encodeString)~="string" then
      InfCore.Log("InfCore.StrCode32: WARNING: Attempting to encode a "..type(encodeString)..": "..tostring(encodeString))
      InfCore.Log("caller: "..this.DEBUG_Where(2))
    else
      local storedString=this.str32ToString[strCode]
      if storedString and storedString~=encodeString then
        InfCore.Log("InfCore.StrCode32: WARNING: Collision "..tostring(storedString).." and "..tostring(encodeString).." both hash to "..tostring(strCode))
      else
        this.str32ToString[strCode]=encodeString
      end
    end
  end
  return strCode
end

function this.GetModuleName(scriptPath)
  local split=InfUtil.Split(scriptPath,"/")
  local moduleName=split[#split]
  return string.sub(moduleName,1,-string.len(".lua")-1)
end

function this.LoadExternalModule(moduleName,isReload,skipPrint)
  this.Log("LoadExternalModule "..tostring(moduleName))
  local prevModule=_G[moduleName]
  if isReload then
    if prevModule and prevModule.PreModuleReload then
      InfCore.PCallDebug(prevModule.PreModuleReload)
    end
  end

  --tex clear so require reloads file, kind of defeats purpose of using require, but requires path search is more useful
  package.loaded[moduleName]=nil
  local sucess,module=pcall(require,moduleName)
  if not sucess then
    InfCore.Log("ERROR: "..module,false,true)
    --tex suppress on startup so it doesnt crowd out ModuleErrorMessage for user.
    if InfCore.doneStartup and not skipPrint then
      InfCore.DebugPrint("Could not load module "..moduleName)
    end
    return nil
  elseif type(module)=="table" then
    _G[moduleName]=module
  else
    InfCore.Log("InfCoreLoadExternalModule: ERROR: "..tostring(moduleName).. " is type "..type(module))
  end

  if isReload then
    if module.PostModuleReload then
      InfCore.PCallDebug(module.PostModuleReload,prevModule)
    end
  end

  return module
end

--tex for simple data modules without all the 'IH module' stuff
function this.LoadSimpleModule(path,fileName,box)
  local filePath=fileName and path..fileName or path

  local moduleChunk,loadError=loadfile(filePath)
  if loadError then
    local doDebugPrint=this.doneStartup--WORKAROUND: InfModelRegistry setup in start.lua is too early for debugprint
    InfCore.Log("Error loading "..filePath..":"..loadError,doDebugPrint,true)
    return
  end

  if box then
    local sandboxEnv={}
    setfenv(moduleChunk,sandboxEnv)
  end

  local module=moduleChunk()

  if module==nil then
    InfCore.Log("Error:"..filePath.." returned nil",true,true)
    return
  end

  return module
end

function this.RequireSimpleModule(moduleName)
  package.loaded[moduleName]=nil
  local module=require(moduleName)
  _G[moduleName]=module
  return module
end

--tex with external alternate
function this.DoFile(path)
  local scriptPath=InfCore.paths.mod..path
  local externLoaded=false
  if InfCore.FileExists(scriptPath) then
    InfCore.Log("Found external for "..scriptPath)
    local ModuleChunk,loadError=loadfile(scriptPath)
    if loadError then
      InfCore.Log("Error loading "..scriptPath..":"..loadError)
    else
      local Module=ModuleChunk()
      externLoaded=true
    end
  end
  if not externLoaded then
    dofile(path)
  end
end

--tex with alternate external loading
function this.LoadLibrary(path)
  local scriptPath=InfCore.paths.mod..path
  local externLoaded=false
  if InfCore.FileExists(scriptPath) then
    InfCore.Log("Found external for "..scriptPath)
    local ModuleChunk,loadError=loadfile(scriptPath)
    if loadError then
      InfCore.Log("Error loading "..scriptPath..":"..loadError)
    else
      local Module=ModuleChunk()
      if Module then
        local moduleName=this.GetModuleName(scriptPath)
        _G[moduleName]=Module
      end
      externLoaded=true
    end
  end
  if not externLoaded then
    Script.LoadLibrary(path)
  end
end

function this.OnLoadEvars()
  --  this.debugMode=evars.debugMode==1--tex handled via DebugModeEnalbe
  this.debugOnUpdate=evars.debugOnUpdate==1
  --tex TODO: this is not firing
  if not this.ihSaveFirstLoad then
    this.ihSaveFirstLoad=true
    if not this.debugMode then
      InfCore.Log("Further logging disabled while debugMode is off",false,true)
    end
  end
end

function this.RefreshFileList()
  InfCore.LogFlow"InfCore.RefreshFileList"

  local filesTable={}

  local cmd=""
  for dir,path in pairs(this.paths)do
    cmd=cmd..[[dir /b "]]..path..[[*.lua" > "]]..path..[[ih_files.txt" & ]]
  end
  this.Log(cmd)
  os.execute(cmd)

  for dir,path in pairs(this.paths)do
    local fileName=path.."ih_files.txt"
    local fileNames=InfCore.PCall(function()
      local lines
      local file,openError=io.open(fileName,"r")
      if file and not openError then
        --tex lines crashes with no error, dont know what kjp did to io
        --      for line in file:lines() do
        --        if line then
        --          table.insert(lines,line)
        --        end
        --      end

        lines=file:read("*all")
        file:close()

        lines=InfUtil.Split(lines,"\r\n")
        if lines[#lines]=="" then
          lines[#lines]=nil
        end
      end
      return lines
    end)
    if fileNames==nil then
      InfCore.Log("InfCore.RefreshFileList ERROR: could not read "..fileName)
      filesTable[dir]={}
    else
      filesTable[dir]=fileNames
    end
  end
  return filesTable
end

function this.GetFileList(files,filter,stripFilter)
  local fileNames={}
  if files==nil then
    InfCore.Log"InfCore.GetFileList: ERROR files==nil"
    return fileNames
  end

  for i,fileName in ipairs(files) do
    local index=string.find(fileName,filter)
    if index then
      if stripFilter then
        fileNames[#fileNames+1]=string.sub(fileName,1,index-1)
      else
        fileNames[#fileNames+1]=fileName
      end
    end
  end
  return fileNames
end

local function GetGamePath()
  local gamePath=nil
  local paths=InfUtil.Split(package.path,";")
  for i,path in ipairs(paths) do
    if string.find(path,"MGS_TPP") then
      gamePath=path
      break
    end
  end
  --tex fallback if MGS_TPP\ couldnt be found in packages.path
  if gamePath==nil then
    if Mock then
      print("InfCore.GetGamePath: Mock fallback path "..tostring(Mock))
      return Mock
    else
      return[[C:\]]
    end
  end

  local stripLength=10--tex length "\lua\?.lua"
  gamePath=gamePath:sub(1,-stripLength)
  return gamePath
end

this.saveName="ih_save.lua"
this.logFileName="ih_log"
this.toExtCmdsFileName="ih_toextcmds"
this.prev="_prev"

--hook
--tex no dice
--this.FoxLog=Fox.Log
--Fox.Log=function(message)
--  this.LogMessage(message)
--  this.FoxLog(message)
--end

--local print=print
--print=function(...)
--  InfCore.Log(...,true)
--  print(...)
--end

--EXEC
--package.path=""--DEBUG kill path for fallback testing
local gamePath=GetGamePath()
local modPath=gamePath..[[mod\]]
this.paths={
  mod=modPath,
  saves=modPath..[[saves\]],
  profiles=modPath..[[profiles\]],
  modules=modPath..[[modules\]],
  fovaInfo=modPath..[[fovaInfo\]],
  quests=modPath..[[quests\]],
}
this.files={
  mod={},
  saves={},
  profiles={},
  modules={},
  fovaInfo={},
  quests={},
}

this.logFilePath=this.paths.mod..this.logFileName..".txt"
this.logFilePathPrev=this.paths.mod..this.logFileName..this.prev..".txt"

this.toExtCmdsFilePath=this.paths.mod..this.toExtCmdsFileName..".txt"

local addPaths=";"..this.paths.mod.."?.lua"
addPaths=addPaths..";"..this.paths.profiles.."?.lua"
addPaths=addPaths..";"..this.paths.modules.."?.lua"
package.path=package.path..addPaths

this.CopyFileToPrev(this.paths.mod,this.logFileName,".txt")
local error=this.ClearFile(this.paths.mod,this.logFileName,".txt")

if error then
  if Mock then
    print(error)
  end
  this.modDirFail=true
else
  local time=os.date("%x %X")
  this.Log("InfCore start "..time)
  this.Log("package.path:"..package.path)

  this.CopyFileToPrev(this.paths.saves,"ih_save",".lua")

  this.files=this.PCall(this.RefreshFileList)
  --InfCore.PrintInspect(this.paths)--DEBUG
  --InfCore.PrintInspect(this.files)--DEBUG

  local error=this.ClearFile(this.paths.mod,this.toExtCmdsFileName,".txt")
end

return this
