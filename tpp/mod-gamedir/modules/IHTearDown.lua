--DEBUGWIP
--IHTearDown.lua
--Dumps data from mgsv globals
--Builds mock modules.
local this={}

--TODO rename knownmodulenames.lua
--TODO DEBUGNOW move knownmodulenames to modules.
--TODO: knownmodulenames,infteardown,autodoc are kinda seperate from standard modules?

this.dumpDir=[[D:\Projects\MGS\dump\]]

--DEBUGNOW trying shiz out
function this.PostAllModulesLoad()
  InfCore.Log("IHTearDown.PostAllModulesLoad")
  
  this.DumpModules()--DEBUGNOW

  if true then return end
  --DEBUGNOW
  -- InfCore.ClearLog()

  --DEBUGNOW


  --  local metaFunctions={
  --    __call=true,
  --    __index=true,
  --    __newindex=true,
  --  }

  --  for moduleName,moduleInfo in pairs(IHGenMockModules)do
  --    InfCore.Log("--Module: "..moduleName)
  --    local module=_G[moduleName]
  --    if module==nil then
  --      InfCore.Log("WARNING: could not find "..moduleName.." in globals")
  --    else
  --      for k,v in pairs(moduleInfo)do
  --        if not metaFunctions[k] then
  --          if v=="<function>" then
  --            InfCore.PCall(function()
  --              InfCore.PrintInspect(module[k](),k.."()")
  --            end)
  --          end
  --        end
  --      end
  --    end
  --  end


  local function PrintInfo(object,objectName)
    InfCore.PrintInspect(object,objectName)
    InfCore.PrintInspect(getmetatable(object),objectName.." metatable")
    InfCore.Log(objectName..":"..tostring(object))
  end

  --InfCore.PrintInspect(Application,"Application")
  --  --InfCore.PrintInspect(getmetatable(Application),"Application metatable")--tex same
  --  --  Application=<1>{
  --  --    AddGame = <function 1>,
  --  --    GetGame = <function 2>,
  --  --    GetGames = <function 3>,
  --  --    GetInstance = <function 4>,
  --  --    GetMainGame = <function 5>,
  --  --    GetScene = <function 6>,
  --  --    RemoveGame = <function 7>,
  --  --    SetMainGame = <function 8>,
  --  --    __call = <function 9>,
  --  --    __index = <function 10>,
  --  --    __newindex = <function 11>,
  --  --    _className = "Application",
  --  --    <metatable> = <table 1>
  --  --  }
  --  InfCore.Log"---"
  local application=Application:GetInstance()
  PrintInfo(application,"application")
  --  application=<userdata 1>
  --  application metatable={
  --    __index = <function 1>,
  --    __newindex = <function 2>,
  --    __tostring = <function 3>
  --  }
  --  application:Application: 0x000000001CD663D0
  InfCore.Log"---"
  local games=application:GetGames()
  PrintInfo(games,"games")
  --  games={
  --    MainGame = <userdata 1>
  --  }
  --  games metatable=nil
  --  games:table: 00000000F8A45880
  InfCore.Log"---"
  --  Game = {
  --    CreateBucket = "<function>",
  --    CreateScene = "<function>",
  --    DeleteBucket = "<function>",
  --    DeleteScene = "<function>",
  --    ExportDataRelationGraph = "<function>",
  --    GetBucket = "<function>",
  --    GetMainBucket = "<function>",
  --    GetScene = "<function>",
  --    PostDataBodyRecreation = "<function>",
  --    PostDataBodyReset = "<function>",
  --    SetMainBucket = "<function>",
  --    SetName = "<function>",
  --    __call = "<function>",
  --    __index = "<function>",
  --    __newindex = "<function>",
  --    _className = "Game"
  --  },

  local mainGame=application:GetGame"MainGame"
  PrintInfo(mainGame,"mainGame")
  --  mainGame=<userdata 1>
  --  mainGame metatable={
  --    __index = <function 1>,
  --    __newindex = <function 2>,
  --    __tostring = <function 3>
  --  }
  --  mainGame:Game: 0x00000000067E21D0
  InfCore.Log"---"
  --  Bucket = {
  --    AddActor = "<function>",
  --    GetEditableDataBodySet = "<function>",
  --    GetEditableDataSet = "<function>",
  --    GetEditableDataSetPath = "<function>",
  --    GetScene = "<function>",
  --    LoadDataSetFile = "<function>",
  --    LoadEditableDataSet = "<function>",
  --    LoadProjectFile = "<function>",
  --    RecreateDataBody = "<function>",
  --    RemoveActor = "<function>",
  --    RemoveAll = "<function>",
  --    SaveEditableDataSet = "<function>",
  --    UnloadDataSetFile = "<function>",
  --    __index = "<function>",
  --    __newindex = "<function>",
  --    _className = "Bucket"
  --  },
  local mainBucket=mainGame:GetMainBucket()
  PrintInfo(mainBucket,"mainBucket")

  local editableDataSet=mainBucket:GetEditableDataSet()-- returns NULL
  PrintInfo(editableDataSet,"editableDataSet")

  --  local dataSetPath="/Assets/tpp/level/mission2/heli/common/heli_common_asset.fox2"
  --  local dataSet=mainBucket:LoadDataSetFile(dataSetPath)--"ERROR Load DataSet file failed!"
  --  PrintInfo(dataSet,"dataSet")

  InfCore.Log"---"
  local mainScene=application:GetScene"MainScene"
  PrintInfo(mainScene,"mainScene")
  --  mainScene=<userdata 1>
  --  mainScene metatable={
  --    __index = <function 1>,
  --    __newindex = <function 2>,
  --    __tostring = <function 3>
  --  }
  --  mainScene:Scene: 0x000000001CE134D0
  InfCore.Log"---"
  --
  --
  --
  --  -- InfCore.PrintInspect(mainGame.ExportDataRelationGraph())--expects entity
  --
  --

  --
  --  --
  InfCore.PrintInspect(mainScene:GetActorList(),"mainScene:GetActorList")

  --  ----
  --
  local identifier="HelispaceLocatorIdentifier"
  --  --
  --  local locatorName="BuddyQuietLocator"
  local key="BuddyDDogLocator"

  InfCore.Log"==="
  --REF
  --  Data = {
  --    GetDataBody = "<function>",
  --    GetDataBodyOnEditing = "<function>",
  --    GetDataBodyWithReferrer = "<function>",
  --    GetDataSet = "<function>",
  --    IsReference = "<function>",
  --    __index = "<function>",
  --    __newindex = "<function>",
  --    _className = "Data"
  --  },
  local data=DataIdentifier.GetDataWithIdentifier(identifier,key)
  PrintInfo(data,"data")

  InfCore.PrintInspect(data:GetClassName(),"data:GetClassName()")
  InfCore.PrintInspect(data:GetPropertyList(),"data:GetPropertyList()")
  InfCore.PrintInspect(data:GetPropertyInfo("name"),"data:GetPropertyInfo('name')")
  InfCore.PrintInspect(data.name,"data.name")
  InfCore.PrintInspect(data.referencePath,"data.referencePath")
  --OUTPUT
  --data=<userdata 1>
  --data:GetClassName()="Locator"
  --data:GetPropertyList()={ "name", "referencePath", "parent", "transform", "shearTransform", "pivotTransform", "inheritTransform", "visibility", "selection", "worldMatrix", "worldTransform", "size" }
  --data:GetPropertyInfo('name')={
  --  arraySize = 1,
  --  container = "StaticArray",
  --  dynamic = false,
  --  export = "RW",
  --  name = "name",
  --  storage = "Instance",
  --  type = "String"
  --}
  --data.name="BuddyDDogLocator"
  --data.referencePath="BuddyDDogLocator"
  --

  --InfCore.PrintInspect(data.worldTransform)
  --InfCore.PrintInspect(data.worldTransform.translation)
  --InfCore.PrintInspect(data.worldTransform.translation:GetX())
  --
  --InfCore.PrintInspect(data.worldTransform:GetClassName())
  --InfCore.PrintInspect(data.worldTransform.translation:GetClassName())
  --
  --
  InfCore.Log"==="
  --  DataSet = {
  --    GetAllDataList = "<function>",
  --    GetBucket = "<function>",
  --    GetData = "<function>",
  --    GetDataList = "<function>",
  --    GetDataSetFile = "<function>",
  --    GetRootTransformData = "<function>",
  --    __index = "<function>",
  --    __newindex = "<function>",
  --    _className = "DataSet"
  --  },
  --

  local dataSet=Data.GetDataSet(data)
  PrintInfo(dataSet,"dataSet")

  local dataList=dataSet:GetDataList()
  InfCore.PrintInspect(dataList,"dataList")

  local allDataList=dataSet:GetAllDataList()
  InfCore.PrintInspect(allDataList,"allDataList")

  local missionData=dataSet:GetData("mission_data")
  PrintInfo(missionData,"mission_data")

  local dataSetFile=DataSet.GetDataSetFile(dataSet)
  InfCore.PrintInspect(dataSetFile,"dataSetFile")
  InfCore.PrintInspect(getmetatable(dataSetFile),"dataSetFile metatable")
  InfCore.Log("dataSetFile:"..tostring(dataSetFile))

  InfCore.Log"==="
  --
  --  local doop={}
  --     InfCore.PrintInspect(mainGame.ExportDataRelationGraph(mainGame,doop))--expects Game, arg1 must be a table -- returns nil
  --
  --  InfCore.Log"--------------"
  --
  --  local navWorld=Nav.GetWorld()
  --  InfCore.PrintInspect(navWorld,"navWorld")
  --  InfCore.Log("navWorld="..tostring(navWorld))
  --  InfCore.PrintInspect(getmetatable(navWorld),"navWorld metatable")
  --
  --
  --  local nclDaemon=NclDaemon.GetInstance()
  --  InfCore.PrintInspect(nclDaemon,"nclDaemon")
  --  InfCore.Log("nclDaemon="..tostring(nclDaemon))
  --  InfCore.PrintInspect(getmetatable(nclDaemon),"nclDaemon metatable")
  --  InfCore.PrintInspect(nclDaemon.IsLogin(),"nclDaemon.IsLogin()")
  --
  --  local phDaemon=PhDaemon.GetInstance()
  --  InfCore.PrintInspect(phDaemon,"phDaemon")
  --  InfCore.Log("phDaemon="..tostring(phDaemon))
  --  InfCore.PrintInspect(getmetatable(phDaemon),"phDaemon metatable")
  --  --phDaemon:SetGravity(0.1)


  InfCore.PrintInspect(TppGameSequence.GetGameTitleName(),"GetGameTitleName")
  InfCore.PrintInspect(TppGameSequence.GetPatchVersion(),"GetPatchVersion")
  InfCore.PrintInspect(TppGameSequence.GetShortTargetArea(),"GetShortTargetArea")
  InfCore.PrintInspect(TppGameSequence.GetShortTargetAreaList(),"GetShortTargetAreaList")
  InfCore.PrintInspect(TppGameSequence.GetSpecialVersionName(),"GetSpecialVersionName")
  InfCore.PrintInspect(TppGameSequence.GetTargetArea(),"GetTargetArea")
  InfCore.PrintInspect(TppGameSequence.GetTargetPlatform(),"GetTargetPlatform")
  InfCore.PrintInspect(TppGameSequence.IsMaster(),"IsMaster")

  --GetGameTitleName="TPP"
  --GetPatchVersion=90
  --GetShortTargetArea="ne"
  --GetShortTargetAreaList={ "jp", "ne" }
  --GetSpecialVersionName="unknown"
  --GetTargetArea="NorthAmericaEurope"
  --GetTargetPlatform="Steam"
  --IsMaster=true

  --    NclDaemon = {
  --    GetInstance = "<function>",
  --    IsLogin = "<function>",

  --  navWorld=<userdata 1>
  --navWorld=NavWorldDesc: 0x0000000076016EC0
  --navWorld metatable={
  --  __index = <function 1>,
  --  __newindex = <function 2>,
  --  __tostring = <function 3>
  --}
  --
  --InfCore.PrintInspect(Fox.StrCode32('bleh'), 'str32 bleh')
  --InfCore.PrintInspect(Fox.PathFileNameCode32('bleh'), 'path32 bleh')
  --InfCore.PrintInspect(Fox.PathFileNameCode32('/Tpp/start.lua'), 'path32 /Tpp/start.lua')


  


  --  local cameraSelector=CameraSelector.GetMainInstance()
  --  InfCore.PrintInspect(cameraSelector,"cameraSelector")--cameraSelector=<userdata 1>
  --  InfCore.Log("cameraSelector:"..tostring(cameraSelector))--cameraSelector:CameraSelector: 0x00000000067E22B0
  --
  --  --tex calling GetRenderName with . instead of : 'ERROR:C:\GamesSD\MGS_TPP\mod\modules\IHTearDown.lua:23: bad argument #1 to 'GetRenderName' (Entity expected, got no value)'
  --  InfCore.PrintInspect(cameraSelector:GetRenderName(),"GetRenderName")--GetRenderName="MainRender"
  --  InfCore.PrintInspect(cameraSelector:GetViewportName(),"GetViewportName")--GetViewportName="MainViewport"
  --
  --  local dump=cameraSelector:DumpActiveCamera()--nil
  --  InfCore.PrintInspect(dump,"dump")
  --  local dump=CameraSelector.DumpActiveCamera()--nil
  --  InfCore.PrintInspect(dump,"dump2")




  --local globalsByType=this.GetGlobalsByType()
  --InfCore.PrintInspect(globalsByType)

  --local keysByType=this.GetModuleKeysByType(globalsByType.table)

  --local plainTextModules=this.GetPlainTextModules(globalsByType.table)
  --InfCore.PrintInspect(plainTextModules,"plainTextModules")--DEBUG

  InfCore.Log("---")
  --DEBUGNOW

  local gameDefaultData=TppDefaultParameter.GetDataFromGroupName("TppEnemyCombatDefaultParameter")
  PrintInfo(gameDefaultData,"gameDefaultData")

  InfCore.Log("---")
end

--NOTE: this should be run at least in ACC
--Some of the modules and some of the keys aren't up and running during start/start2nd.lua but are by ACC.
function this.DumpModules()
  local globalsByType=this.GetGlobalsByType()
  --InfCore.PrintInspect(globalsByType)

  --tex NOTE internal C tables/modules exposed from MGS_TPP.exe are kinda funky,
  --a few are normal, plain text keys as you'd expect.
  --most are doing something with indexing metatables via some custom class binding i guess
  --the most common is fox table (don't know actual name)
  --these will either act as arrays with [-285212672] acting as item count
  --or [key name] being index into [some number]
  --or [key name] being index into [-285212671][some number]
  --some number doesnt seem to be strcode32
  --some times its [-285212671][some string] which is a normal name

  --many have a _classname string, these have plain text keys/dont have the somenumber indirection

  local arrayCountIdent=-285212672
  local arrayIdent=-285212671


  local mockModules=this.BuildMockModules(globalsByType.table)
  --InfCore.PrintInspect(mockModules,"mockModules")--DEBUG

  --DEBUGNOW
  --tex NOTE: takes a fair while to run. Run it once, then use the resulting combined table .lua (after copying it to MGS_TPP\mod\modules and lauding it) --DEBUGNOW
  --open ih_log.txt in an editor that live refreshes to see progress
  --local moduleReferences=this.GetModuleReferences(globalsByType.table)
  --InfCore.PrintInspect(moduleReferences,"moduleReferences")--DEBUG

  local moduleReferences=IHGenModuleReferences--ASSUMPTION output of above has been loaded as a module

  local mockModulesFromRefs,notFound=this.BuildMockModulesFromReferences(globalsByType.table,moduleReferences)
  InfCore.PrintInspect(notFound,"notFound")

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
  
  local missedModules={}
  for name,module in pairs(globalsByType.table)do
    if not mockModules[name] then
      missedModules[name]=true
    end
  end
  
  --DEBUGNOW
  if isMockFox then
    InfCore.Log("isMockFox, will not output dump files")
    return
  end

  local varsTable=this.DumpVars()

  local svarsTable=this.DumpSaveVars(svars)

  local gvarsTable=this.DumpSaveVars(gvars)
  
  local mvarsTable=mvars

  --tex write dumps
  local header={
    [[--ModulesDump.lua]],
    [[--GENERATED by IHTearDown]],
    [[--Straight Inspect dump of mgstpp global tables]],
  }
  local outDir=this.dumpDir..[[modulesDump\]]
  this.DumpToFiles(outDir,globalsByType.table)
  this.WriteTable(this.dumpDir.."ModulesDump.lua",table.concat(header,"\r\n"),globalsByType.table)

  if moduleReferences~=IHGenModuleReferences then--tex no point dumping a dump
    local header={
      [[--IHGenModuleReferences.lua]],
      [[--GENERATED by IHTearDown.DumpModules > GetModuleReferences]],
      [[--is scrape of references to modules in .lua files]],
    }
  local outDir=this.dumpDir..[[moduleReference\]]
  this.DumpToFiles(outDir,moduleReferences)
  this.WriteTable(this.dumpDir.."IHGenModuleReferences.lua",table.concat(header,"\r\n"),moduleReferences)
  end

  local header={
    [[--MockModules.lua]],
    [[--GENERATED by IHTearDown from running mgs combined with scrapes of .lua files for further module references (due to internal mgs_tpp modules indexing crud, see NOTE in DumpModules)]],
  }
  local outDir=this.dumpDir..[[mockModules\]]
  this.DumpToFiles(outDir,mockModules)
  this.WriteTable(this.dumpDir.."MockModules.lua",table.concat(header,"\r\n"),mockModules)
  
  local header={
    [[--IHGenModuleReferences.lua]],
    [[--GENERATED by IHTearDown BuildMockModulesFromReferences]],
    [[--references from IHGenModuleReferences that werent found in live session]],
  }
  this.WriteTable(this.dumpDir.."IHGenUnfoundReferences.lua",table.concat(header,"\r\n"),notFound) 
  
  local header={
    [[--IHMissedModules.lua]],
    [[--GENERATED by IHTearDown]],
    [[--global module names that werent in generated mockmodules]],
  }
  this.WriteTable(this.dumpDir.."IHMissedModules.lua",table.concat(header,"\r\n"),missedModules) 

  local header={
    [[--vars.lua]],
    [[--GENERATED by IHTearDown.DumpVars]],
    [[--Note: indexed from 0 like actual vars]],
    [[--dump of vars during missionCode:]]..vars.missionCode,
  }
  this.WriteTable(this.dumpDir.."\\varsDump\\".."vars.lua",table.concat(header,"\r\n"),varsTable)

  local header={
    [[--svars.lua]],
    [[--GENERATED by IHTearDown.DumpSaveVars]],
    [[--Note: indexed from 0 like actual vars]],
    [[--dump of vars during missionCode:]]..vars.missionCode,
  }
  this.WriteTable(this.dumpDir.."\\varsDump\\".."svars.lua",table.concat(header,"\r\n"),svarsTable)

  local header={
    [[--gvars.lua]],
    [[--GENERATED by IHTearDown.DumpSaveVars]],
    [[--Note: indexed from 0 like actual vars]],
    [[--dump of vars during missionCode:]]..vars.missionCode,
  }
  this.WriteTable(this.dumpDir.."\\varsDump\\".."gvars.lua",table.concat(header,"\r\n"),svarsTable)
  
  local header={
    [[--mvars.lua]],
    [[--using Inspect]],
    [[--dump of vars during missionCode:]]..vars.missionCode,
  }
  this.WriteTable(this.dumpDir.."\\varsDump\\".."mvars.lua",table.concat(header,"\r\n"),mvarsTable)

  local entityClassDictionary=this.DumpEntityClassDictionary()
  local header={
    [[--IHGenEntityClassDictionary.lua]],
    [[--GENERATED by IHTearDown DumpEntityClassDictionary]],
    [[--dump of EntityClassDictionary.GetCategoryList, GetClassNameList]],
  }
  this.WriteTable(this.dumpDir.."IHGenEntityClassDictionary.lua",table.concat(header,"\r\n"),entityClassDictionary)
end

--tex breaks down global variables by type
--IN/SIDE: IHGenKnownModuleNames, _G
--OUT: globalsByType
function this.GetGlobalsByType()
  local ModuleNames=IHGenKnownModuleNames

  --tex names of tables in KnownModuleNames to skip
  local skipModuleTableNames={
    "ihInternal",
    "ihExternal",
    "ihModelInfo",
    "tppInternal",
    "luaInternal",
  }

  local skipModuleNames={
    _G=true,
    package=true,
    this=true,
  }

  local globalsByType={
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
    for i,moduleNameTable in ipairs(skipModuleTableNames)do
      if ModuleNames[moduleNameTable] and ModuleNames[moduleNameTable][k] then
        addEntry=false
        break
      end
    end

    if skipModuleNames[k] then
      addEntry=false
    end

    --tex theres some strange edge cases where theres a provided lua, but also an exe internal module of that name
    if ModuleNames.exeInternal[k] then
      addEntry=true
    end

    if addEntry then
      local types=globalsByType[type(v)]
      types=types or globalsByType.other
      types[k]=v
    end
  end
  return globalsByType
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
--DEBUGNOW REWORK
--just do a straight search for . : and build up it's own module names, that way it can also catch stuff like CyprRailActionDataSet that only calls via a variable
--break lines on ")", "}", "]", "=", ","??
--," " -- would be nice, but would miss cases such as 'blah.Functionname ('
--for brokenLines
--refpos = findfirst '.'
--type=normalref
--refpos = findfirst ':'
--type=selfref

--DEBUGNOW DOES delims/split remove the delim chars from the lines??

--from refpos left/decement/toward start of line
--objstartPos=find/breakup string by anything not alphanumeric or start of line
--what if is ..? -- that would be objstartPos==refpos?
--objectName = refPos to objstartPos

--from refPos right/increment/toward end of line
--memberEndPos =find/break on alphanumeric or end of line
--" ",???
--what if 'blah.Functionname (' or 'blah.Functionname<tab>(' ??

function this.GetModuleReferences(modules)
  InfCore.Log("GetModuleReferences")

  --tex get paths of lua files ASSUMPTION: all lua files in one folder/no subfolders
  local luaFolder=[[J:\GameData\MGS\filetypecrushed\lua\]]--DEBUGNOW
  local outName="luaFileList.txt"

  local startTime=os.clock()

  local cmd=[[dir /s /b "]]..luaFolder..[[*.lua" > "]]..luaFolder..outName..[["]]
  InfCore.Log(cmd)
  os.execute(cmd)

  local luaFilePaths=InfCore.GetLines(luaFolder..outName)
  --InfCore.PrintInspect(luaFilePaths,"luaFilePaths")--DEBUG

  local numFiles=#luaFilePaths

  local refs={}
  for i,filePath in ipairs(luaFilePaths)do
    InfCore.Log("["..i.."//"..numFiles.."] "..filePath)--DEBUG
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

  InfCore.Log(string.format("GetModuleReferences completed in: %.2f", os.clock() - startTime))

  return refs
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
    --    __call=true,
    --    __newindex=true,
    --    __index=true,
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
              mockModules[moduleName][k]="<userdata: "..tostring(v)..">"
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
  InfCore.Log("BuildMockModulesFromReferences")
  local mockModules={}

  local ignoreModules={
    vars=true,
    cvars=true,
    gvars=true,
    svars=true,
    mvars=true,
  }

  local ignoreKeys={
    --    __call=true,
    --    __index=true,
    --    __newindex=true,
    }
  
  local notFound={
  
  }

  for moduleName,referenceModule in pairs(moduleReferences)do
    if not ignoreModules[moduleName] then
      mockModules[moduleName]={}
      if not modules[moduleName] then
        InfCore.Log("Could not find module '"..moduleName.."' from moduleReferences in modules")
        notFound[moduleName]=true
      else
        local liveModule=modules[moduleName]
        for k,v in pairs(referenceModule)do
          local liveValue=liveModule[k]
          if liveValue==nil then
            InfCore.Log(moduleName.." could not find key "..tostring(k))
            notFound[moduleName]=notFound[moduleName] or {}
            notFound[moduleName][k]=true
          elseif type(k)=="string" then
            if not ignoreKeys[k] then
              if type(liveValue)=="function" then
                mockModules[moduleName][k]="<function>"
              elseif type(liveValue)=="table" then
                mockModules[moduleName][k]="<table>"
              elseif type(liveValue)=="userdata" then
                mockModules[moduleName][k]="<userdata: "..tostring(liveValue)..">"
              else
                mockModules[moduleName][k]=liveValue
              end
            end
          end
        end
      end
    end
  end
  return mockModules,notFound
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

--tex svars,gvars use same layout
function this.DumpSaveVars(inputVars)
  if inputVars==nil then
    InfCore.Log("DumpSaveVars inputVars==nil")
    return
  end

  local varsTable={}

  --tex svars.__as is non array vars
  for k,v in pairs(inputVars.__as)do
    varsTable[k]=v
  end

  --tex svars.__rt is array vars
  --REF
  --  __rt = {
  --      InterrogationNormal = {
  --      __vi = 224,
  --      <metatable> = <table 1>
  --    },
  for k,v in pairs(inputVars.__rt)do
    varsTable[k]={}
    local arraySize=v.__vi--DEBUGNOW not sure if this is right
    for i=0,arraySize-1 do
      varsTable[k][i]=inputVars[k][i]
    end
  end

  return varsTable
end

function this.DumpEntityClassDictionary()
  local entityClassNames={}

  local categoryList=EntityClassDictionary.GetCategoryList()

  for i,categoryName in ipairs(categoryList)do
    entityClassNames[categoryName]=EntityClassDictionary.GetClassNameList(categoryName)
  end

  return entityClassNames
end

local open=io.open
local Inspect=InfInspect.Inspect

local nl=[[\r\n]]
function this.WriteString(filePath,someString)
  local file,error=open(filePath,"w")
  if not file or error then
    return
  end

  file:write(someString)
  file:close()
end

--tex writes a table out to file with text header
function this.WriteTable(fileName,header,t)
  if t==nil then
    return
  end
  InfCore.Log("WriteTable "..fileName)

  local all=InfInspect.Inspect(t)
  all="local this="..all.."\r\n".."return this"
  if header then
    all=header.."\r\n"..all
  end

  this.WriteString(fileName,all)
end

function this.DumpToFiles(outDir,moduleTable)
  if moduleTable==nil then
    return
  end
  InfCore.Log("DumpToFiles "..outDir)

  for k,v in pairs(moduleTable) do
    local filename=outDir..k..'.txt'
    local ins=Inspect(v)
    this.WriteString(filename,k.."="..ins)
  end
end

return this
