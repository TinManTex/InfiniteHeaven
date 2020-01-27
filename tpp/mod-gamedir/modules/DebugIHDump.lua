--DEBUGWIP
--DebugIHDump.lua
--Dumps data from mgsv globals
--Builds mock modules.
local this={}

--TODO rename knownmodulenames.lua
--TODO DEBUGNOW move knownmodulenames to modules.
--TODO: knownmodulenames,infteardown,autodoc are kinda seperate from standard modules?

this.dumpDir=[[D:\Projects\MGS\dump\]]

function this.DumpModules()
  local globalsByType=this.GetGlobalsByType()
  --InfCore.PrintInspect(globalTypes)

  --tex NOTE tables exposed from MGS_TPP.exe are userdata
  --the most common is fox table (don't know actual name)
  --these will either act as arrays with [-285212672] acting as item count
  --or [key name] being index into [some number]
  --or [key name] being index into [-285212671][some number]
  --some number == str32??
  --some times its [-285212671][some string] which is a normal name

  --many have a _classname string, these have plain text keys/dont have the somenumber indirection

  local arrayCountIdent=-285212672
  local arrayIdent=-285212671

  --tex doesnt produce anything
  --  local arrayData={}

  --  for k,v in pairs(globalTypes.table)do
  --    local arrayCount=v[arrayCountIdent]
  --    if arrayCount~=nil and arrayCount~=0 then
  --      arrayData[k]={}
  --      for i=0,arrayCount-1 do
  --        arrayData[k][i]=v[i]
  --      end
  --    end
  --  end
  --  local outDir=[[D:\Projects\MGS\dump\arraydata\]]
  --  this.DumpToFiles(outDir,arrayData)

  --local keysByType=this.GetModuleKeysByType(globalsByType.table)

  --local moduleReferences=this.GetModuleReferences(globalsByType.table)--tex takes a fair while. Run it once, then use the resulting combined table .lua DEBUGNOW
  --InfCore.PrintInspect(moduleReferences,"moduleReferences")--DEBUGNOW

  local moduleReferencesDump=DebugIHDumpedModuleReferences--ASSUMPTION output of above has been loaded as a module


  --local plainTextModules=this.GetPlainTextModules(globalsByType.table)
  --InfCore.PrintInspect(plainTextModules,"plainTextModules")--DEBUGNOW

  local mockModules=this.BuildMockModules(globalsByType.table)
  --InfCore.PrintInspect(mockModules,"mockModules")--DEBUGNOW

  local mockModulesFromRefs=this.BuildMockModulesFromReferences(globalsByType.table,moduleReferencesDump)

  InfCore.Log("combine mockModulesFromRefs to mockModules")
  for moduleName,module in pairs(mockModulesFromRefs) do
    for k,v in pairs(module)do
      if not mockModules[moduleName] then
        InfCore.Log(moduleName.." could not find module in mockmodules")
      elseif not mockModules[moduleName][k] then
        mockModules[moduleName][k]=v
      end
    end
  end

  local varsTable=this.DumpVars()
  
  --tex write dumps
  local outDir=this.dumpDir..[[modulesDump\]]
  this.DumpToFiles(outDir,globalsByType.table)

  local outDir=this.dumpDir..[[keytypebreakdown\]]
  -- this.DumpToFiles(outDir,keysByType)

  local outDir=this.dumpDir..[[moduleReference\]]
  this.DumpToFiles(outDir,moduleReferences)

  local outDir=this.dumpDir..[[mockModules\]]
  this.DumpToFiles(outDir,mockModules)

  local outDir=this.dumpDir
  local all=InfInspect.Inspect(varsTable)
  this.WriteString(outDir.."vars.lua",all)
end

--tex breaks down global variables by type
function this.GetGlobalsByType()
  local ModuleNames=DebugIHKnownModuleNames

  local skipIH=true
  local skipTpp=true
  local skipModules=true

  local skipModuleNames={
    _G=true,
    package=true,
    this=true,
  }

  local globalTypes={
    ["table"]={},
    ["function"]={},
    ["string"]={},
    other={},
  }
  local globalFunctions={}
  local globalTables={}
  local globalOther={}
  for k,v in pairs(_G)do
    local addEntry=true
    if skipIH then
      if ModuleNames.ihInternal[k] then
        addEntry=false
      elseif ModuleNames.ihExternal[k] then
        addEntry=false
      end
    end

    if skipTpp then
      if ModuleNames.tppInternal[k] then
        addEntry=false
      end
    end

    if skipModules then
      if ModuleNames.luaInternal[k] then
        addEntry=false
      end
    end

    if skipModules then
      if skipModuleNames[k] then
        addEntry=false
      end
    end

    --tex theres some strange edge cases where theres a provided lua, but also an exe internal module of that name
    if ModuleNames.exeInternal[k] then
      addEntry=true
    end

    if addEntry then
      local types=globalTypes[type(v)]
      types=types or globalTypes.other
      types[k]=v
    end
  end
  return globalTypes
end

--tex breaks down modules keys by type
function this.GetModuleKeysByType(modules)
  InfCore.Log("GetModuleKeysByType")
  local breakDown={}
  for moduleName,module in pairs(modules)do
    local tableInfo={
      stringKeys={},
      numberKeys={},
    }
    local function GetTableKeys(checkTable,tableInfo)
      for key,value in pairs(checkTable)do
        if type(key)=="string" then
          table.insert(tableInfo.stringKeys,key)
        elseif type(key)=="number" then
          table.insert(tableInfo.numberKeys,key)
          if type(value)=="table" then
            GetTableKeys(value)
          end
        end
      end
    end

    GetTableKeys(module,tableInfo)

    if #tableInfo.numberKeys>0 then
      breakDown[moduleName]=tableInfo
    end
  end
end

--tex scrapes module references from lua files
--DEBUGNOW TODO figure out if it's a function or a variable "(" follows reference name
function this.GetModuleReferences(modules)
  InfCore.Log("GetModuleReferences")

  --tex get paths of lua files ASSUMPTION: all lua files in one folder/no subfolders
  local luaFolder=[[J:\GameData\MGS\filetypecrushed\lua\]]--DEBUGNOW
  local outName="luaFileList.txt"

  local cmd=[[dir /s /b "]]..luaFolder..[[*.lua" > "]]..luaFolder..outName..[["]]
  InfCore.Log(cmd)
  os.execute(cmd)

  local luaFilePaths=InfCore.GetLines(luaFolder..outName)
  InfCore.PrintInspect(luaFilePaths,"luaFilePaths")--DEBUGNOW

  --local stringBreak={}--DEBUGNOW
  local refs={}
  for i,filePath in ipairs(luaFilePaths)do
    InfCore.Log(filePath)--DEBUGNOW
    local lines=InfCore.GetLines(filePath)
    for i,fileLine in ipairs(lines)do
      for moduleName,moduleInfo in pairs(modules)do
        local fileLine=fileLine

        --tex break up lines
        local brokenLines={}
        local delim = {
          ",", " ", "\n", "%]", "%)", "}", "\t",
          "%+","-",">","<","=","/","%*","~","%%",
          "'","\"","{","%(","%[",
        }
        local pattern = "[^"..table.concat(delim).."]+"
        for w in fileLine:gmatch(pattern) do
          --InfCore.Log(w)
          table.insert(brokenLines,w)
        end

        --InfCore.Log("looking for "..moduleName)--DEBUGNOW
        for i,line in ipairs(brokenLines)do
          local findIndex,findEndIndex=string.find(line,moduleName)
          while(findIndex~=nil)do
            local findEndIndex=findIndex+string.len(moduleName)
            line=string.sub(line,findEndIndex)
            local nextChar=string.sub(line,1,1)
            --InfCore.Log("find: "..moduleName.. " line:"..line)--DEBUGNOW
            --InfCore.Log("find: "..moduleName.. " nextChar:"..nextChar)--DEBUGNOW
            if nextChar=="." or nextChar==":" then
              --DEBUGNOW TODO: handle + - < > == number (can + be concat string too?)

              --              local keyType
              --              if line:find("%(") then
              --                keyType="function"
              --                key=key:sub(1,key:len()-1)
              --              elseif line:find("%[") then
              --                keyType="table"
              --                key=key:sub(1,key:len()-1)
              --             elseif line:find("%:") then--DEBUGNOW
              --                --keyType=""--tex most likely a comment
              --                key=key:sub(1,key:len()-1)
              --              elseif line:find("=") then
              --                if line:find("={") then
              --                  keyType="table"
              --                elseif line:find("='") then
              --                  keyType="string"
              --                elseif line:find("=\"") then
              --                  keyType="string"
              --                end
              --                --tex =something is unknown, could be any type being assigned to it
              --                local endIndex=line:find("=")
              --                key=key:sub(1,endIndex-2)
              --              end

              local key=string.sub(line,2)--tex strip leading .

              local keyEndIndex=string.find(key,"[%.:]")
              if keyEndIndex then
                key=string.sub(key,1,keyEndIndex-1)
              end

              local nextChar=string.sub(key,1,1)
              if findIndex==1 then--DEBUGNOW
                if key~="" and type(nextChar)~="number"then
                  refs[moduleName]=refs[moduleName]or{}
                  refs[moduleName][key]=true
              end
              end
            end

            findIndex=string.find(line,moduleName)
            --InfCore.Log(findIndex)--DEBUGNOW
          end
        end
      end
    end
  end

  --InfCore.PrintInspect(stringBreak,"-----------stringBreak")

  return refs
end

function this.GetPlainTextModules(modules)
  local plainTextModules={}

  local ignoreKeys={
    __call=true,
    __newindex=true,
    __index=true,
  }

  for moduleName,module in pairs(modules)do
    for k,v in pairs(module)do
      if type(k)=="string" then
        if not ignoreKeys[k] then
          plainTextModules[moduleName]=true
        end
      end
    end
  end

  return plainTextModules
end

function this.BuildMockModules(modules)
  local mockModules={}

  local ignoreModules={
    vars=true,
    cvars=true,
    gvars=true,
    svars=true,
    mvars=true,
  }

  local ignoreKeys={
    __call=true,
    __newindex=true,
    __index=true,
  }

  for moduleName,module in pairs(modules)do
    if not ignoreModules[moduleName] then
      mockModules[moduleName]={}
      for k,v in pairs(module)do
        --NOTE only string keys to skip userdata/indexified modules keys, see NOTE in DumpModules
        if type(k)=="string" then
          if not ignoreKeys[k] then
            if type(v)=="function" then
              mockModules[moduleName][k]="<function>"
            elseif type(v)=="table" then
              mockModules[moduleName][k]="<table>"
            elseif type(v)=="userdata" then
              mockModules[moduleName][k]=tostring(v)
            else
              mockModules[moduleName][k]=v
            end
          end
        end
      end
    end
  end
  return mockModules
end


function this.BuildMockModulesFromReferences(modules,moduleReferences)
  local mockModules={}

  local ignoreModules={
    vars=true,
    cvars=true,
    gvars=true,
    svars=true,
    mvars=true,
  }

  local ignoreKeys={
    __call=true,
    __newindex=true,
    __index=true,
  }

  for moduleName,referenceModule in pairs(moduleReferences)do
    if not ignoreModules[moduleName] then
      mockModules[moduleName]={}
      if not modules[moduleName] then
        InfCore.Log("Could not find module from moduleRefereces in modules:"..moduleName)
      else
        local liveModule=modules[moduleName]
        for k,v in pairs(referenceModule)do
          local liveValue=liveModule[k]
          if liveValue==nil then
            InfCore.Log(moduleName.." could not find key "..tostring(k))
          elseif not ignoreKeys[k] then
            if type(k)=="string" then
              if not ignoreKeys[k] then
                if type(liveValue)=="function" then
                  mockModules[moduleName][k]="<function>"
                elseif type(liveValue)=="table" then
                  mockModules[moduleName][k]="<table>"
                elseif type(liveValue)=="userdata" then
                  mockModules[moduleName][k]=tostring(liveValue)
                else
                  mockModules[moduleName][k]=liveValue
                end
              end
            end
          end
        end
      end
    end
  end
  return mockModules
end

function this.DumpVars()
  local vars=vars
  
  local rootArrayIdent=-285212671
  
  local arrayIdent=-285212665
  local arrayCountIdent=-285212666

  local varsTable={}

  for k,v in pairs(vars[rootArrayIdent])do
    varsTable[k]=vars[k]
  end

  local skipKeys={
    __index=true,
    __newindex=true,
  }

  for k,foxTable in pairs(vars)do
    --tex is actually a foxTable
    if type(foxTable)=="table" then
      if foxTable[arrayCountIdent] then
        --InfCore.Log("found foxTable "..k)--DEBUGNOW
        if type(k)=="string" then
          if not skipKeys[k] then
            local foxTableArray=foxTable[arrayIdent]
            if foxTableArray then
              varsTable[k]={}
              local arrayCount=foxTable[arrayCountIdent]
              --InfCore.Log("arrayCount="..arrayCount)--DEBUGNOW
              for i=0,arrayCount-1 do
                varsTable[k][i]=vars[k][i]
              end
            end
          end
        end
      end
    end
  end

  return varsTable
end

local open=io.open
local Inspect=InfInspect.Inspect

local nl=[[\n\r]]
function this.WriteString(filePath,someString)
  local file,error=open(filePath,"w")
  if not file or error then
    return
  end

  file:write(someString)
  file:close()
end

function this.DumpToFiles(outDir,moduleTable)
  if moduleTable==nil then
    return
  end
  InfCore.Log("DumpToFiles "..outDir)

  local all=InfInspect.Inspect(moduleTable)
  this.WriteString(outDir.."!All.lua",all)

  for k,v in pairs(moduleTable) do
    local filename=outDir..k..'.txt'
    local ins=Inspect(v)
    this.WriteString(filename,k.."="..ins)
  end
end

return this
