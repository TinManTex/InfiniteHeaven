--IHDebugVars.lua
--tex turnin on debug crud and running some quick test code on allmodulesload

--tex some modules have some debug logging gated behind a if this.debugModule condition.
--PostAllModulesLoad below will set debugModule to true for the modules named in this list.
--this however won't catch modules that use this.debugModule while loading, 
--or stuff that the module has run before PostAllModulesLoad
--TODO: a runtime debugAllModules Ivar (don't forget vanilla modules too)
local debugModules={
  'InfMain',
  'InfMenuDefs',
  'IvarProc',
  --  'InfNPC',
  --  'InfModelProc',
  --  'InfQuest',
  --  'TppQuest',
  --  'InfInterrogation',
  --  'InfMBGimmick',
  'InfLookup',
  --  'InfMission',
  --  'InfEquip',
  --'InfWalkerGear',
  --'InfSoldier',
  --'InfEneFova',
  --'InfExtToMgsv',
  --'InfMgsvToExt',
  --'InfMission',
  'InfNPC',
  'Ivars',
}

local this={}

this.packages={
  --[30010]="/Assets/tpp/pack/mission2/ih/ih_extra_sol_test.fpk",
  -- [30020]="/Assets/tpp/pack/mission2/ih/ih_extra_sol_test.fpk",
  }

function this.AddMissionPacks(missionCode,packPaths)
  if missionCode < 5 then
    return
  end

  if this.packages[missionCode] then
    packPaths[#packPaths+1]=this.packages[missionCode]
  end
end

function this.PostAllModulesLoad()
  if isMockFox then
    InfCore.Log("isMockFox, returning:")
    return
  end
  
  this.SetDebugVars()

  -- InfCore.Log("IHDebugVars.PostAllModulesLoad:")
  -- print("testerino");

  --DEBUGNOW
  --https://www.lua.org/tests/
  local testPath="C:/Games/Steam/steamapps/common/MGS_TPP/mod/lua-test"
  _U=true--tex simple mode
  InfCore.PCallDebug(function()LoadFile(testPath.."/all.lua")end)

  -- winapi.shell_exec('open','C:/Games/Steam/steamapps/common/MGS_TPP/mod/')

  --= "currdirtest.lua"
  --  local f = loadfile(filename)
  -- return f(filename)
  --dofile()

  --DEBUGNOW
  local opentest = function(filename)
    local f,err = io.open(filename,"w")
    if f==nil then
      InfCore.Log("ERROR: "..err)
    else
      local t = f:write("blurgg")
      f:close()
    end
  end


--tex relative paths cause an error 'Result too large', 
--I guess kjp has some kind of relative path==internal path? thing going on?
--  InfCore.PCallDebug(opentest,"c:/temp/curredirtext1.txt")
--  InfCore.PCallDebug(opentest,"/temp/curredirtext2.txt")
--  InfCore.PCallDebug(opentest,"temp/curredirtext3.txt")
--  InfCore.PCallDebug(opentest,"curredirtext4.txt")
--  InfCore.PCallDebug(opentest,"./curredirtext5.txt")
--  InfCore.PCallDebug(opentest,".curredirtext6.txt")
--  InfCore.PCallDebug(opentest,"./temp/curredirtext7.txt")






  InfCore.PrintInspect(InfCore.ihFiles,"ihFiles")
  InfCore.PrintInspect(InfCore.paths,"paths")
  InfCore.PrintInspect(InfCore.files,"files")
  InfCore.PrintInspect(InfCore.filesFull,"filesFull")


  this.PrintUpdateTimes()

  --this.FileBenchMark()

  --
  -- InfCore.PrintInspect(_IHHook, "_IHHook")
  -- InfCore.PrintInspect(_GameDir, "_GameDir")
  -- InfCore.PrintInspect(_IHHook_TestTable,"_IHHook_TestTable");

  --

  InfCore.Log("TppEquip.IsExistFile test:")
  local fileNamesTest={
    "/Assets/tpp/level_asset/weapon/ParameterTables/parts/EquipParameters.lua",
    "/Assets/tpp/script/lib/Tpp.lua",
    "/Assets/tpp/script/lib/InfInit.lua",
    "/Assets/tpp/pack/fova/common_source/chara/cm_head/face/cm_m0_h0_v000_eye0.fpk",
    "/Assets/tpp/pack/mission2/init/init.fpk",
    "/Assets/tpp/pack/blurgespurgen.fpk",
    "/Assets/tpp/level_asset/weapon/ParameterTables/parts/EquipParameters",
    "hurrrg",
  }
  for i,fileName in ipairs(fileNamesTest)do
    local fileExists = TppEquip.IsExistFile(fileName)
    InfCore.Log(fileName.." : "..tostring(fileExists))
  end




  local blockNames={
    "mission_block",
    "quest_block",
    "demo_block",
    "reinforce_block",
    "npc_block",
    "animal_block",
    "TppResidentBlockGroup",
    "CommonStageBlockGroup",
  }
  for i,blockName in ipairs(blockNames)do
    local blockId=ScriptBlock.GetScriptBlockId(blockName)
    InfCore.Log(blockName.." blockId="..tostring(blockId))
  end

  local staffVarNames={
    "mbmStaffSvarsHeaders",
    "mbmStaffSvarsSeeds",
    "mbmStaffSvarsStatusesNoSync",
    "mbmStaffSvarsStatusesSync",
  }

  local staffVarsHex={}

  local arrayLength=3500
  for i,varName in ipairs(staffVarNames)do
    staffVarsHex[varName]={}
    for index=0,arrayLength-1 do
      staffVarsHex[varName][index+1]=bit.tohex(vars[varName][index])
    end
  end
  --InfCore.PrintInspect(staffVarsHex,"staffVarsHex")

  --

  --this.PrintStrCodes()

  --Quat shiz
  --
  --    local rotY=30
  --    local rotQuat=Quat.RotationY(TppMath.DegreeToRadian(rotY))
  --    InfCore.PrintInspect(rotQuat,"rotQuat")
  --    InfCore.PrintInspect(tostring(rotQuat),"rotQuat")
  --    InfCore.PrintInspect(rotQuat:ToString(),"rotQuat")

  --Ivars.customSoldierTypeFREE:Set"OFF"
  --Ivars.disableXrayMarkers:Set(1)
end

function this.Init()

--  InfCore.Log("IHDebugVars")
--    InfCore.PrintInspect(gvars.rev_revengeRandomValue, "rev_revengeRandomValue")
--  for i=0,TppRevenge.REVENGE_TYPE.MAX-1 do
--  --  gvars.rev_revengeLv[i] = 3
--  end
--
--    for i=0,TppRevenge.REVENGE_TYPE.MAX-1 do
--    InfCore.PrintInspect(gvars.rev_revengeLv[i], "rev_revengeLv "..i..":")
--  end

end

function this.SetDebugVars()
  InfCore.LogFlow("IHDebugVars.PostAllModulesLoad: setting debug vars")

  Ivars.debugMode:Set(1)
  Ivars.debugMessages:Set(1)
  Ivars.debugFlow:Set(1)
  Ivars.debugOnUpdate:Set(1)

  Ivars.enableQuickMenu:Set(1)

  for i,moduleName in ipairs(debugModules)do
    _G[moduleName].debugModule=true
  end
  if IHH then
    IHH.Log_SetFlushLevel(InfCore.level_trace)
  end
end

function this.PrintUpdateTimes()
  InfCore.PrintInspect(InfMain.updateTimes,"updateTimes")

  local averageTimes={}
  for k,v in pairs(InfMain.updateTimes)do
    averageTimes[k]=0
  end
  for k,times in pairs(InfMain.updateTimes)do
    for i,timer in ipairs(times)do
      averageTimes[k]=averageTimes[k]+timer
    end
  end

  for k,times in pairs(InfMain.updateTimes)do
    averageTimes[k]=string.format("%.12f",averageTimes[k]/#times)
  end

  InfCore.PrintInspect(averageTimes,"averageTimes")


  local maxTimes={}
  for k,v in pairs(InfMain.updateTimes)do
    maxTimes[k]=0
  end
  for k,times in pairs(InfMain.updateTimes)do
    for i,timer in ipairs(times)do
      if timer>maxTimes[k] then
        maxTimes[k]=timer
      end
    end
  end

  InfCore.PrintInspect(maxTimes,"maxTimes")

  InfMain.updateTimes={}
end

function this.PrintStrCodes()
  InfCore.Log"IHDebugVars.PrintStrCodes---------------"
  local str32s={
    1500257626,
  --routeEvent types
  --      104983832,
  --      1500257626,
  --      4019510599,
  --      4258228081,
  --      1974185602,
  --      2265318157,
  --      4202868537,
  --      561913624,
  --      --reoute even params
  --      1004142592,
  --      889322046,
  --    6452720,
  --    1631872372,
  --    825241651,
  --    573317666,
  --    975332717,
  --    1936614772,
  --    741358114,
  --routeids
  --      132331158,
  --      205387598,
  --      587733603,
  --      2615639494,
  --      2763127077,
  --      3507759117,
  --      2265318157,
  --      1004142592,
  --      18529,
  --      889322046,
  --      574235246,
  --      104983832,
  --
  --   1631872372,
  }

  --AiRtEvSoldier
  --quest frts aparently have some corruption from json route or whatever they have and has 4 bytes of plain text

  for i,str32 in ipairs(str32s)do
    local str=InfLookup.StrCode32ToString(str32)
    InfCore.Log(str32.."="..tostring(str))
  end

  local strings={
    --'rt_heli_quest_0000',
    -- 'rt_quest_heli_d_0000',
    "Wait",
    "Stop",
    "stop",
    "hold",
    "look",
    "face",
    "aim",
    "walk",
    "Hold",
    "Point",
    "Look",
    "Face",
    "Aim",
    "AimPoint",
    "AimPoi",
    "Poi",
    "Walk",
  }

  for i,str in ipairs(strings)do
    local str32=Fox.StrCode32(str)
    InfCore.Log(str.."="..tostring(str32))
  end

end


function this.FileBenchMark()
  InfCore.Log("IHDebugVars: process toMgsvCmdsFilePath benchmark")
  local startTime=os.clock()
  local file,openError=io.open(InfCore.toMgsvCmdsFilePath,"r")
  local openTime=os.clock()-startTime
  local startTime=os.clock()
  local lines=file:read("*all")
  local readTime=os.clock()-startTime
  file:close()
  local startTime=os.clock()
  lines=InfUtil.Split(lines,"\n")
  local splitTime=os.clock()-startTime
  InfCore.Log("openTime:"..openTime)
  InfCore.Log("readTime:"..readTime)
  InfCore.Log("splitTime:"..splitTime)
  InfCore.Log("totalTime:"..openTime+readTime+splitTime)
end

function this.AnalyseUserDataShiz()
--REF init.lua
--  local mainApplication=Application{name="MainApplication"}
--  local game=Game{name="MainGame"}
--  mainApplication:AddGame(game)
--  mainApplication:SetMainGame(game)
--  local mainScene=game:CreateScene"MainScene"
--  local mainBucket=game:CreateBucket("MainBucket",mainScene)
--  game:SetMainBucket(mainBucket)
--REF start.lua
--local setupBucket=mainGame:CreateBucket("SetupBucket",mainScene)

--  local tppGameSequenceInstance=TppGameSequence:GetInstance()
--  tppGameSequenceInstance:SetPhaseController(TppPhaseController.Create())

--local phDaemon=PhDaemon.GetInstance()
--some phD setup

--REF gmpEarnMissions.lua
--local motherbaseManager=TppMotherBaseManager:GetInstance()
--local GmpEarn=motherbaseManager:GetGmpEarn()
--GmpEarn:CreateMissions{

--REF TppUI.lua
--UiCommonDataManager.GetInstance()

--REF start2nd.lua
--local subtitlesDaemon=SubtitlesDaemon.GetInstance()

--REF TppUiBootInit.lua
--UiCommonDataManager.Create()
--HudCommonDataManager.Create()
--local uiCommonDataManager=UiCommonDataManager.GetInstance()
--local uiDaemonInstance=UiDaemon.GetInstance()
--whole bunch of uiDaemonInstance usage

--_radio scripts
--RadioDaemon:GetInstance()

--o50050_sound
--  function this.PlayAlertSiren( switch )
--    local source = "asiren"
--    local tag  = "Loop"
--    local pEvent = "sfx_m_mtbs_siren"
--    local sEvent = "Stop_sfx_m_mtbs_siren"
--    local daemon = TppSoundDaemon.GetInstance()
--
--    if switch == true then
--      daemon:RegisterSourceEvent{
--        sourceName = source,
--        tag = tag,
--        playEvent = pEvent,
--        stopEvent = sEvent,
--      }
--    elseif switch == false then
--      daemon:UnregisterSourceEvent{
--        sourceName = source,
--        tag = tag,
--        playEvent = pEvent,
--        stopEvent = sEvent,
--      }
--    end
--  end



end


function this.AnalizeShiz()
  InfCore.ClearLog()

  local knownKeyNames={
    TppScriptVars={
      CATEGORY_CONFIG = true,
      CATEGORY_GAME_GLOBAL = true,
      CATEGORY_MB_MANAGEMENT = true,
      CATEGORY_MGO = true,
      CATEGORY_MISSION = true,
      CATEGORY_MISSION_RESTARTABLE = true,
      CATEGORY_PERSONAL = true,
      CATEGORY_QUEST = true,
      CATEGORY_RETRY = true,
      CopySlot = true,
      CreateSaveSlot = true,
      DeclareGVars = true,
      DeclareSVars = true,
      DeleteFile = true,
      FileExists = true,
      GROUP_BIT_ALL = true,
      GROUP_BIT_GVARS = true,
      GROUP_BIT_VARS = true,
      GetElapsedTimeSinceLastPlay = true,
      GetFileExistence = true,
      GetFreeStorageSpaceSize = true,
      GetLastResult = true,
      GetNecessaryStorageSpaceSize = true,
      GetProgramVersionTable = true,
      GetSaveState = true,
      GetScriptVersionFromSlot = true,
      GetTotalPlayTime = true,
      GetVarValueInSlot = true,
      InitForNewGame = true,
      InitForNewMission = true,
      IsSavingOrLoading = true,
      IsShowingNoSpaceDialog = true,
      LoadVarsFromSlot = true,
      PLAYER_AMMO_STOCK_TYPE_COUNT = true,
      READ_FAILED = true,
      RESULT_ERROR_FILE_CORRUPT = true,
      RESULT_ERROR_INVALID_STORAGE = true,
      RESULT_ERROR_LOAD_BACKUP = true,
      RESULT_ERROR_NOSPACE = true,
      RESULT_ERROR_OWNER = true,
      RESULT_OK = true,
      ReadSlotFromAreaFile = true,
      ReadSlotFromFile = true,
      RequestAreaFileExistence = true,
      RequestFileExistence = true,
      RequestNecessaryStorageSpace = true,
      STATE_LOADING = true,
      STATE_PROCESSING = true,
      STATE_SAVING = true,
      SVarsIsSynchronized = true,
      SaveVarsToSlot = true,
      SetFileSizeList = true,
      SetSVarsNotificationEnabled = true,
      SetUpSlotAsCompositSlot = true,
      SetVarValueInSlot = true,
      ShowNoSpaceDialog = true,
      StoreUtcTimeToScriptVars = true,
      TYPE_BOOL = true,
      TYPE_FLOAT = true,
      TYPE_INT32 = true,
      TYPE_INT8 = true,
      TYPE_UINT16 = true,
      TYPE_UINT32 = true,
      TYPE_UINT8 = true,
      WRITE_FAILED = true,
      WriteSlotToFile = true
    }
  }

  local moduleName="TppScriptVars"
  local module=_G[moduleName]

  local str32Keys={}
  for key,exists in pairs(knownKeyNames[moduleName])do
    str32Keys[key]=Fox.StrCode32(key)
  end
  InfCore.PrintInspect(str32Keys,moduleName.." str32Keys")

  local moduleValues={}
  for key,exists in pairs(knownKeyNames[moduleName])do
    moduleValues[key]=InfInspect.Inspect(module[key])
  end
  InfCore.PrintInspect(moduleValues,moduleName.." moduleValues")

  local arrayValues={}
  local arrayCountIdent=-285212672
  local arrayCount=module[arrayCountIdent]
  InfCore.PrintInspect(arrayCount,moduleName.." arrayCount")
  if arrayCount then
    for i=0,arrayCount do--tex not sure if index from 0 or 1
      arrayValues[i]=InfInspect.Inspect(module[i])
    end
  end
  InfCore.PrintInspect(arrayValues,moduleName.." arrayValues")


  local tableInfo={
    stringKeys={},
    numberKeys={},
  }
  local function GetTableKeys(checkTable,tableInfo)
    for key,value in pairs(checkTable)do
      if type(key)=="string" then
        tableInfo.stringKeys[key]=true
      elseif type(key)=="number" then
        tableInfo.numberKeys[key]=true
        if type(value)=="table" then
          GetTableKeys(value,tableInfo)
        end
      end
    end
  end

  GetTableKeys(module,tableInfo)
  InfCore.PrintInspect(tableInfo,moduleName.." tableInfo")


  InfCore.PrintInspect(module,moduleName)


  for knownKeyName,str32 in pairs(str32Keys)do
    local foundKey=tableInfo.numberKeys[str32]
    InfCore.Log(knownKeyName.." "..str32.." key in module:"..tostring(foundKey))
  end
end

--tex from IHTearDown
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
            end--if foxTableArray
          end--not skipKeys
        end--k==type string
      end--if foxTable[arrayCountIndex]
    end--foxTable==type table
  end--for vars

  return varsTable
end--DumpVars

--tex dumped vars (via DumpVars()) are key, var, with var either being int or float, or indexed from 0 list of int or float
local nl="\n"
function this.PrintVars(dumpedVars)
  InfCore.Log("PrintVars:")
  local outputPath=[[C:\Projects\MGS\ToolOutput\dump-vars.txt]]

  local printLines={}

  local namesSorted={}

  for varName, var in pairs(dumpedVars)do
    namesSorted[#namesSorted+1]=varName
  end

  table.sort(namesSorted)

  local file,error=io.open(outputPath,"w")
  if not file then
    InfCore.Log(error)
    return
  end
  file:write("--Dumped vars via IHDebugVars.DumpVars,PrintVars",nl)
  file:write("--Note: arrays are indexed from 0",nl)
  for i, varName in ipairs(namesSorted)do
    local line=varName
    local var = dumpedVars[varName]
    if type(var)=="table"then
      line=line.."["..#var.."]"
      line=line.."= { "
      for j=0, #var do
        local currentVar=var[j]
        line=line..tostring(currentVar)..", "
      end
      line=line.."},"
    else
      line=line.." = "..tostring(var)..","
    end
    file:write(line,nl)
  end

  file:close()
end


return this
