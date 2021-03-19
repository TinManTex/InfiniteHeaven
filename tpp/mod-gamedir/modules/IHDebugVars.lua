--IHDebugVars.lua
--tex turnin on debug crud and running some quick test code on allmodulesload
--as well as supplying my dev menu

--tex GOTCHA: some modules have some debug logging gated behind a if this.debugModule condition.
--PostAllModulesLoad below will set debugModule to true for the modules named in this list.
--this however won't catch modules that use this.debugModule while loading,
--or stuff that the module has run before PostAllModulesLoad
--TODO: a runtime debugAllModules Ivar (don't forget vanilla modules too)
local debugModules={
  'InfCore',
  'InfExtToMgsv',
  'InfMgsvToExt',
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
    'InfEquip',
  --'InfWalkerGear',
  --'InfSoldier',
  'InfEneFova',
  --'InfMission',
  'InfNPC',
  'Ivars',
  'TppEnemy',
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
  
--  TppEnemy.GetWeaponId=this.GetWeaponId
--  TppEnemy.weaponIdTable.PF_A=weaponIdTable
--  TppEnemy.weaponIdTable.PF_B=weaponIdTable
--  TppEnemy.weaponIdTable.PF_C=weaponIdTable
--  TppEnemy.weaponIdTable.DD=weaponIdTable
--  TppEnemy.weaponIdTable.SOVIET_A=weaponIdTable
--  TppEnemy.weaponIdTable.SOVIET_B=weaponIdTable
--  TppEnemy.weaponIdTable.SKULL=weaponIdTable
--  TppEnemy.weaponIdTable.MARINES_A=weaponIdTable
--  TppEnemy.weaponIdTable.MARINES_B=weaponIdTable
--  TppEnemy.weaponIdTable.MARINES_MIXED=weaponIdTable
  
  InfCore.PrintInspect("IHH")
  InfCore.PrintInspect(imgui,"imgui")

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
  local gimMax=1025
  for i=1,gimMax do
    --InfCore.PrintInspect(gvars.gim_missionStartBreakableObjects[i],"Init gim_missionStartBreakableObjects["..i.."]:")
  end
end

function this.OnAllocate(missionTable)
  local gimMax=1025
  for i=1,gimMax do
    --InfCore.PrintInspect(gvars.gim_missionStartBreakableObjects[i],"Init gim_missionStartBreakableObjects["..i.."]:")
  end
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
    InfCore.Log(str32.."="..str)
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

function this.Dump_ui_isTaskLastCompleted()
  local taskCompletedInfo={}
  local maxMissionTasks={}
  for missionCodeStr,missionEnum in pairs(TppDefine.MISSION_ENUM)do
    local missionCode=tonumber(missionCodeStr)
    local maxMissionTask=TppUI.GetMaxMissionTask(missionCode) or 0
    local info={}
    taskCompletedInfo[missionCode]=info
    maxMissionTasks[missionCode]=maxMissionTask
    InfCore.Log(missionCode..": maxMissionTask: "..maxMissionTask..", isTaskCompleted:")
    local ui_isTaskLastComletedStr="["
    for taskIndex=0,TppDefine.MAX_MISSION_TASK_COUNT-1 do
      local missionTaskIndex=missionEnum*TppDefine.MAX_MISSION_TASK_COUNT+taskIndex

      local isTaskLastCompleted=0
      if gvars.ui_isTaskLastComleted[missionTaskIndex] then
        isTaskLastCompleted=1
      end
      info[taskIndex+1]=isTaskLastCompleted
      ui_isTaskLastComletedStr=ui_isTaskLastComletedStr..tostring(isTaskLastCompleted)..","
    end
    ui_isTaskLastComletedStr=ui_isTaskLastComletedStr.."]"
    InfCore.Log(ui_isTaskLastComletedStr)
  end
  InfCore.PrintInspect(taskCompletedInfo,"taskCompletedInfo")--DEBUG
  InfCore.PrintInspect(maxMissionTasks,"maxMissionTasks")--DEBUG

  --tex dumped from a 100% completed using above
  --alternatively could hand compile from <mission>_sequence .missionObjectiveDefine s
  --    local vanillaTasks={
  --      [10010] = { 1, 1, 0, 0, 0, 0, 0, 0 },
  --      [10020] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10030] = { 1, 1, 1, 1, 1, 0, 0, 0 },
  --      [10033] = { 1, 1, 1, 1, 1, 0, 0, 0 },
  --      [10036] = { 1, 1, 1, 1, 1, 0, 0, 0 },
  --      [10040] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10041] = { 1, 1, 1, 1, 1, 1, 1, 0 },
  --      [10043] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10044] = { 1, 0, 1, 1, 1, 1, 1, 1 },
  --      [10045] = { 0, 1, 1, 1, 1, 1, 1, 0 },
  --      [10050] = { 1, 1, 1, 0, 0, 1, 0, 0 },
  --      [10052] = { 0, 1, 1, 1, 1, 1, 0, 0 },
  --      [10054] = { 1, 1, 1, 1, 1, 1, 1, 1 },
  --      [10070] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10080] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10081] = { 0, 1, 1, 1, 0, 0, 0, 0 },
  --      [10082] = { 0, 1, 1, 1, 1, 1, 0, 0 },
  --      [10085] = { 1, 1, 1, 1, 1, 1, 1, 0 },
  --      [10086] = { 1, 1, 1, 1, 1, 1, 1, 0 },
  --      [10090] = { 1, 1, 1, 1, 1, 1, 1, 1 },
  --      [10091] = { 0, 1, 0, 1, 1, 1, 1, 1 },
  --      [10093] = { 1, 0, 1, 1, 1, 1, 1, 0 },
  --      [10100] = { 1, 1, 1, 1, 1, 1, 1, 1 },
  --      [10110] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10115] = { 1, 0, 0, 0, 0, 0, 0, 0 },
  --      [10120] = { 0, 1, 1, 1, 1, 1, 0, 0 },
  --      [10121] = { 1, 1, 1, 1, 1, 1, 1, 1 },
  --      [10130] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10140] = { 1, 1, 1, 1, 0, 0, 0, 0 },
  --      [10150] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [10151] = { 1, 1, 1, 0, 0, 0, 0, 0 },
  --      [10156] = { 1, 1, 1, 1, 1, 0, 0, 0 },
  --      [10171] = { 1, 1, 0, 1, 1, 1, 1, 1 },
  --      [10195] = { 1, 1, 1, 1, 1, 1, 1, 0 },
  --      [10200] = { 0, 0, 1, 1, 1, 1, 1, 1 },
  --      [10211] = { 1, 0, 1, 1, 1, 1, 1, 0 },
  --      [10230] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [10240] = { 1, 1, 0, 0, 0, 0, 0, 0 },
  --      [10260] = { 1, 1, 1, 1, 1, 0, 0, 0 },
  --      [10280] = { 1, 1, 0, 0, 0, 0, 0, 0 },
  --      [11033] = { 1, 1, 1, 1, 1, 0, 0, 0 },
  --      [11036] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11041] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11043] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [11044] = { 1, 0, 1, 1, 1, 1, 1, 1 },
  --      [11050] = { 1, 1, 1, 0, 0, 1, 0, 0 },
  --      [11052] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11054] = { 1, 1, 1, 1, 1, 1, 1, 1 },
  --      [11080] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [11082] = { 0, 1, 1, 1, 1, 1, 0, 0 },
  --      [11085] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11090] = { 1, 1, 1, 1, 1, 1, 1, 1 },
  --      [11091] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11115] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11121] = { 1, 1, 1, 1, 1, 1, 1, 1 },
  --      [11130] = { 1, 1, 1, 1, 1, 1, 0, 0 },
  --      [11140] = { 1, 1, 1, 1, 0, 0, 0, 0 },
  --      [11151] = { 1, 1, 1, 0, 0, 0, 0, 0 },
  --      [11171] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11195] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11200] = { 0, 0, 0, 0, 0, 0, 0, 0 },
  --      [11211] = { 0, 0, 0, 0, 0, 0, 0, 0 }
  --    }
end

--menus
this.devInAccMenu={
  noDoc=true,
  nonConfig=true,
  options={
    "InfMenuCommands.RefreshPlayer",--DEBUGNOW
    "Ivars.quest_useAltForceFulton",--DEBUGNOW
    "Ivars.sys_increaseMemoryAlloc",--DEBUGNOW
    "InfMenuCommands.DEBUG_SomeShiz",
    "InfMenuCommands.DEBUG_SomeShiz2",
    "InfMenuCommands.DEBUG_SomeShiz3",
    --"Ivars.customBodyTypeMB_ALL",--DEBUGNOW
    "Ivars.selectEvent",
    --"Ivars.customSoldierTypeMISSION",--TODO:
    "Ivars.manualSequence",
    "Ivars.allowUndevelopedDDEquip",
    "InfLookup.DumpValidStrCode",
    --TODO: debugmodeall command/profile
    --"Ivars.enableWildCardHostageFREE",--WIP
    --"Ivars.enableSecurityCamFREE",
    "InfMenuCommands.ForceRegenSeed",
    "Ivars.debugValue",
    "Ivars.debugMode",
    "Ivars.debugMessages",
    "Ivars.debugFlow",
    "Ivars.debugOnUpdate",
    "Ivars.log_SetFlushLevel",
  }
}--devInAccMenu

this.devInMissionMenu={
  noDoc=true,
  nonConfig=true,
  options={
    "Ivars.cam_disableCameraAnimations",
    "InfMenuCommands.DEBUG_SomeShiz",
    "InfMenuCommands.DEBUG_SomeShiz2",
    "InfMenuCommands.DEBUG_SomeShiz3",
    "InfMenuCommands.DEBUG_WarpToObject",
    "Ivars.warpToListPosition",
    "Ivars.warpToListObject",
    "InfHelicopter.RequestHeliLzToLastMarker",
    "InfHelicopter.RequestHeliLzToLastMarkerAlt",
    "InfHelicopter.ForceExitHeli",
    "InfHelicopter.ForceExitHeliAlt",
    "InfHelicopter.PullOutHeli",
    "InfHelicopter.ChangeToIdleStateHeli",
    "Ivars.disablePullOutHeli",
    --"Ivars.selectedCp",
    --"InfMenuCommands.SetSelectedCpToMarkerObjectCp",
    "InfMenuCommands.SetSelectedCpToMarkerClosestCp",
    "Ivars.selectedCp",
    "InfUserMarker.PrintLatestUserMarker",
    "InfMenuCommands.SetAllZombie",
    "InfMenuCommands.CheckPointSave",
    "Ivars.manualMissionCode",
    "Ivars.setCamToListObject",
    "Ivars.dropLoadedEquip",
    "Ivars.dropTestEquip",
    "Ivars.manualMissionCode",
    "Ivars.manualSequence",
    "Ivars.allowUndevelopedDDEquip",
    "Ivars.debugValue",
    "InfMenuCommandsTpp.DEBUG_PrintSoldierDefine",
    --"Ivars.parasitePeriod_MIN",
    --"Ivars.parasitePeriod_MAX",
    --"InfMenuCommandsTpp.DEBUG_ToggleParasiteEvent",
    "InfLookup.DumpValidStrCode",
    "InfMenuCommands.SetAllFriendly",
    "InfCamera.ShowFreeCamPosition",
    "InfMenuCommands.ShowPosition",
    "InfCore.ClearLog",
  }
}--devInMissionMenu

function this.AddDevMenus()
  InfCore.Log"AddDevMenus"
  local safeSpaceMenu=InfMenuDefs.safeSpaceMenu.options
  local inMissionMenu=InfMenuDefs.inMissionMenu.options
  --KLUDGE
  if safeSpaceMenu[1]~="InfMenuDefs.devInAccMenu" then
    if not isMockFox then
      table.insert(safeSpaceMenu,1,'InfMenuDefs.devInAccMenu')
      table.insert(inMissionMenu,1,'InfMenuDefs.devInMissionMenu')
    end
  end
end--AddDevMenus
--< menus

--menuCommands
local toggle1=true
local index1Min=1
local index1Max=2
local index1=index1Min
local count=0
local increment=5
this.log=""
this.DEBUG_SomeShiz=function()
  count=count+1
  InfCore.Log("---------------------DEBUG_SomeShiz---------------------"..count)
  
    local customSoldierType=IvarProc.GetForMission("customSoldierType",vars.missionCode)
    InfCore.Log("customSoldierType:"..tostring(customSoldierType))
  
  --for i=1,100 do
  --InfCore.Log(i)
  ---InfExtToMgsv.GetPlayerPos()
  --end
  
  if true then return end
  
  local markerPos=InfUserMarker.GetMarkerPosition(0)
  InfCore.PrintInspect(markerPos,"markerPos")
  local markerPos=InfUserMarker.GetMarkerPosition(nil)
  InfCore.PrintInspect(markerPos,"markerPos 2nd")
  
  local markerIndex=0
  vars.userMarkerPosX[markerIndex]=0+index1
  vars.userMarkerPosY[markerIndex]=0+index1
  vars.userMarkerPosZ[markerIndex]=0+index1
  
  InfCore.PrintInspect(vars.userMarkerGameObjId[markerIndex],"userMarkerGameObjId")

  --local dumpedVars=IHDebugVars.DumpVars()
  --IHDebugVars.PrintVars(dumpedVars)


  if true then return end

  local scriptBlockNames={
    "animal_block",
    "demo_block",
    "quest_block",
    "mission_block",
    "npc_block",
    "reinforce_block",
    "cypr_small_mission_block_1",
    "cypr_small_mission_block_2",
    "cypr_small_mission_block_3",
    "cypr_demo_block",
  }

  for i,blockName in ipairs(scriptBlockNames)do
    InfCore.PrintInspect(ScriptBlock.GetScriptBlockId(blockName),blockName)
  end

  if true then return end


  InfCore.PrintInspect(Time,"Time")
  local timeResult={
    deltaGameTime=Time.GetDeltaGameTime(),
    gameTimeRate=Time.GetGameTimeRate(),
    frameTime=Time.GetFrameTime(),
    rawElapsedTimeSinceStartUp=Time.GetRawElapsedTimeSinceStartUp(),
    frameIndex=Time.GetFrameIndex(),
  }

  for name,result in pairs(timeResult)do
    InfCore.Log(name..":"..tostring(result))
  end

  if true then return end

  InfUAV.SetupUAV()
  if true then return end
  local fileList=File.GetFileListTable("/Assets/tpp/pack/player/motion/player2_location_motion.fpk")
  InfCore.PrintInspect(fileList,"fileList")


  --    GetBlockPackagePath = "<function>",
  --    GetFileListTable = "<function>",
  --    GetReferenceCount = "<function>",

  local identifier="HelispaceLocatorIdentifier"
  --  local locatorName="BuddyQuietLocator"
  local key="BuddyDDogLocator"
  local data=DataIdentifier.GetDataWithIdentifier(identifier,key)
  local dataSet=Data.GetDataSet(data)
  local dataSetFile=DataSet.GetDataSetFile(dataSet)
  local  blockPackagePath=File.GetBlockPackagePath(dataSetFile)

  -- local  blockPackagePath=File.GetBlockPackagePath("/Assets/tpp/pack/player/motion/player2_location_motion.fpk")

  -- local  blockPackagePath=File.GetBlockPackagePath(data)
  InfCore.PrintInspect(blockPackagePath,"blockPackagePath")

  --local  referenceCount=File.GetReferenceCount("/Assets/tpp/pack/player/motion/player2_location_motion.fpk")
  local  referenceCount=File.GetReferenceCount("Tpp/Scripts/Equip/EquipMotionData.lua")
  InfCore.PrintInspect(referenceCount,"referenceCount")

  if true then return end

  InfCore.DebugPrint("index1:"..index1)
  index1=index1+increment
  if index1>index1Max then
    index1=index1Min
  end
  toggle1=not toggle1
end

local index2Min=300
local index2Max=334
local index2=index2Min
this.DEBUG_SomeShiz2=function()
  InfCore.Log("---DEBUG_SomeShiz2---")

  -- vars.missionCode=12345--

  local function PrintInfo(object,objectName)
    InfCore.Log("PrintInfo "..objectName..":")
    InfCore.PrintInspect(object,objectName.." Inspect")
    InfCore.PrintInspect(getmetatable(object),objectName.." Inspect metatable")
    InfCore.Log(objectName.." tostring:"..tostring(object))
  end

  --  --tex in helispace \chunk3_dat\Assets\tpp\pack\mission2\heli\h40050\h40050_area_fpkd\Assets\tpp\level\mission2\heli\h40050\h40050_sequence.fox2 (or equivalent h40010,h40020 fox2) is loaded
  --  --it has a DataIdentifier named HelispaceLocatorIdentifier
  --  --DataIdentifier have key / nameInfArchive paths to other Data / Entities, this is what DataIdentifier.GetDataWithIdentifier used to return a Data entity.
  --  local identifier="HelispaceLocatorIdentifier"
  --  --  local locatorName="BuddyQuietLocator"
  --  local key="BuddyDDogLocator"
  --  InfCore.Log("identifier: "..identifier)
  --  InfCore.Log("key: "..key)
  --  local data=DataIdentifier.GetDataWithIdentifier(identifier,key)
  --  PrintInfo(data,"data")
  --  --OUTPUT
  --  --PrintInfo data:
  --  --data Inspect=<userdata 1>
  --  --data Inspect metatable={
  --  --  __index = <function 1>,
  --  --  __newindex = <function 2>,
  --  --  __tostring = <function 3>
  --  --}
  --  --data tostring:Locator: 0x000000011624FF40
  --
  --  InfCore.PrintInspect(data:GetClassName(),"data:GetClassName()")
  --  --data:GetClassName()="Locator"
  --  InfCore.PrintInspect(data:GetPropertyList(),"data:GetPropertyList()")
  --  --data:GetPropertyList()={ "name", "referencePath", "parent", "transform", "shearTransform", "pivotTransform", "inheritTransform", "visibility", "selection", "worldMatrix", "worldTransform", "size" }
  --  InfCore.PrintInspect(data:GetPropertyInfo("name"),"data:GetPropertyInfo('name')")
  --  --data:GetPropertyInfo('name')={
  --  --  arraySize = 1,
  --  --  container = "StaticArray",
  --  --  dynamic = false,
  --  --  export = "RW",
  --  --  name = "name",
  --  --  storage = "Instance",
  --  --  type = "String"
  --  --}
  --  --tex as you can see the properties of entites can be accessed with dot notation
  --  InfCore.PrintInspect(data.name,"data.name")
  --  --data.name="BuddyDDogLocator"
  --  InfCore.PrintInspect(data.referencePath,"data.referencePath")
  --  --data.referencePath="BuddyDDogLocator"

  ---
  InfCore.Log("---------")
  local identifier="PlayerDataIdentifier"
  --  local locatorName="BuddyQuietLocator"
  local key="PlayerGameObject"
  InfCore.Log("identifier: "..identifier)
  InfCore.Log("key: "..key)

  local data=DataIdentifier.GetDataWithIdentifier(identifier,key)
  PrintInfo(data,"data")
  --OUTPUT
  --PrintInfo data:
  --data Inspect=<userdata 1>
  --data Inspect metatable={
  --  __index = <function 1>,
  --  __newindex = <function 2>,
  --  __tostring = <function 3>
  --}
  --data tostring:Locator: 0x000000011624FF40

  InfCore.PrintInspect(data:GetClassName(),"data:GetClassName()")
  --data:GetClassName()="GameObject"
  InfCore.PrintInspect(data:GetPropertyList(),"data:GetPropertyList()")
  --data:GetPropertyList()={ "name", "referencePath", "typeName", "groupId", "totalCount", "realizedCount", "parameters" }
  InfCore.PrintInspect(data:GetPropertyInfo("name"),"data:GetPropertyInfo('name')")
  --data:GetPropertyInfo('name')={
  --  arraySize = 1,
  --  container = "StaticArray",
  --  dynamic = false,
  --  export = "RW",
  --  name = "name",
  --  storage = "Instance",
  --  type = "String"
  --}
  --tex as you can see the properties of entites can be accessed with dot notation
  InfCore.PrintInspect(data.name,"data.name")
  --data.name="PlayerGameObject"
  InfCore.PrintInspect(data.referencePath,"data.referencePath")
  --data.referencePath="PlayerGameObject"

  ---
  InfCore.PrintInspect(data:GetPropertyInfo("parameters"),"data:GetPropertyInfo('parameters')")
  --data:GetPropertyInfo('parameters')={
  --  arraySize = 1,
  --  container = "StaticArray",
  --  dynamic = false,
  --  export = "RW",
  --  name = "name",
  --  storage = "Instance",
  --  type = "String"
  --}
  --tex as you can see the properties of entites can be accessed with dot notation
  InfCore.PrintInspect(data.parameters,"data.parameters")
  --data.parameters=
  local parameters=data.parameters
  InfCore.PrintInspect(tostring(parameters),"tostring(parameters)")


  -- InfCore.PrintInspect(parameters:GetPropertyList(),"parameters:GetPropertyList()")
  IHH.TestCallToIHHook(data)
  --DEBUGNOW

  InfCore.DebugPrint("index2:"..index2)
  index2=index2+1
  if index2>index2Max then
    index2=index2Min
  end
end

local index3Min=1
local index3Max=10
local index3=index3Min
local toggle3=false
this.DEBUG_SomeShiz3=function()
  InfCore.Log("---DEBUG_SomeShiz3---")



  local routes={
    --      "rt_slopedWest_d_0000_sub",
    --        "rt_slopedWest_d_0004",
    --        "rt_slopedWest_d_0003",
    "rt_slopedWest_d_0002",
    --        "rt_slopedWest_d_0001",
    "rt_slopedWest_d_0005",

    --        "rt_slopedWest_n_0000",
    "rt_slopedWest_n_0004",
    --        "rt_slopedWest_n_0003",
    --        "rt_slopedWest_n_0002",
    --        "rt_slopedWest_n_0001",
    --        "rt_slopedWest_n_0005",

    --        "rt_slopedWest_c_0000",
    --        "rt_slopedWest_c_0003",
    --        "rt_slopedWest_c_0001",
    --        "rt_slopedWest_c_0004",
    --        "rt_slopedWest_c_0002",
    "rt_slopedWest_c_0004",

    "rt_slopedWest_s_0000",
  --"rt_slopedWest_s_0001",
  }
  index3Max=#routes
  
  local soldierName="sol_slopedWest_0000"
  local routeName=routes[index3]
  InfCore.DebugPrint(routeName)
  InfSoldier.WarpSetRoute(soldierName,routeName)

  --  local objectName = "sol_slopedWest_0000"
  --  local gameId=GetGameObjectId(objectName)
  --  local objectPos=GameObject.SendCommand(gameId,{id="GetPosition"})
  --  if objectPos==nil then
  --    InfCore.Log("GetPosition nil for "..objectName,true)
  --  else
  --    InfCore.Log(objectName.." pos:".. objectPos:GetX()..",".. objectPos:GetY().. ","..objectPos:GetZ(),true)
  --  end
  --
  --  if true then return end
  --
  --  InfCore.PrintInspect(TppLandingZone.assaultLzs,"assaultLzs")
  --  InfCore.PrintInspect(TppLandingZone.missionLzs,"missionLzs")
  --
  --  local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
  --  local closestRoute
  --  if lastMarkerIndex==nil then
  --    InfMenu.PrintLangId"no_marker_found"
  --    return
  --  else
  --    local markerPostion=InfUserMarker.GetMarkerPosition(lastMarkerIndex)
  --    markerPostion={markerPostion:GetX(),markerPostion:GetY(),markerPostion:GetZ()}
  --
  --    closestRoute=InfLZ.GetClosestLz(markerPostion)
  --  end
  --
  --  InfCore.PrintInspect(closestRoute,"closestRoute")

  InfCore.DebugPrint("index3:"..index3)
  index3=index3+1
  if index3>index3Max then
    index3=index3Min
  end
  toggle3=not toggle3
end
--< menuCommands

return this
