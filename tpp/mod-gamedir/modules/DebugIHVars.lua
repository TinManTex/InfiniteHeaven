--DebugIHVars.lua
--tex turnin on debug crud

local this={}

function this.PostAllModulesLoad()
  InfCore.Log("DebugIHVars.PostAllModulesLoad: setting debug vars")

  Ivars.debugMode:Set(1)
  Ivars.debugMessages:Set(1)
  Ivars.debugFlow:Set(1)
  Ivars.debugOnUpdate:Set(1)

  Ivars.enableQuickMenu:Set(1)

  InfNPC.debugModule=true
  --InfModelProc.debugModule=true
  --InfQuest.debugModule=true
  --TppQuest.debugModule=true
  --InfInterrogation.debugModule=true
  --InfMBGimmick.debugModule=true
  --InfLookup.debugModule=true
  
  InfMission.debugModule=true--DEBUGNOW
  
 --Quat shiz
--     
--    local rotY=30
--    local rotQuat=Quat.RotationY(TppMath.DegreeToRadian(rotY))
--    InfCore.PrintInspect(rotQuat,"rotQuat")
--    InfCore.PrintInspect(tostring(rotQuat),"rotQuat")
--    InfCore.PrintInspect(rotQuat:ToString(),"rotQuat")
  
  this.PrintStrCodes()--DEBUGNOW

  --TODO hangs InfWalkerGear=true

  --Ivars.customSoldierTypeFREE:Set"OFF"
  --Ivars.disableXrayMarkers:Set(1)

  if not InfCore.doneStartup then
    return
  end
  
  
  
  

  --InfCore.Log"DebugIHVars dumpshiz----------------------------------------"
  --InfCore.log={}
  --this.DumpShit()
  if true then return end
  InfCore.Log"----------------------------------------"
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

  InfCore.PrintInspect(Application,"Application")
  --InfCore.PrintInspect(getmetatable(Application),"Application metatable")--tex same

  --  Application=<1>{
  --    AddGame = <function 1>,
  --    GetGame = <function 2>,
  --    GetGames = <function 3>,
  --    GetInstance = <function 4>,
  --    GetMainGame = <function 5>,
  --    GetScene = <function 6>,
  --    RemoveGame = <function 7>,
  --    SetMainGame = <function 8>,
  --    __call = <function 9>,
  --    __index = <function 10>,
  --    __newindex = <function 11>,
  --    _className = "Application",
  --    <metatable> = <table 1>
  --  }
  InfCore.Log"---"
  local applicationInstance=Application:GetInstance()
  InfCore.PrintInspect(applicationInstance,"applicationInstance")
  InfCore.PrintInspect(getmetatable(applicationInstance),"applicationInstance metatable")
  InfCore.Log("applicationInstance:"..tostring(applicationInstance))
  --  applicationInstance=<userdata 1>
  --  applicationInstance metatable={
  --    __index = <function 1>,
  --    __newindex = <function 2>,
  --    __tostring = <function 3>
  --  }
  --  applicationInstance:Application: 0x000000001CD663D0
  InfCore.Log"---"
  local games=applicationInstance:GetGames()
  InfCore.PrintInspect(games,"games")
  InfCore.PrintInspect(getmetatable(games),"games metatable")
  InfCore.Log("games:"..tostring(games))
  --  games={
  --    MainGame = <userdata 1>
  --  }
  --  games metatable=nil
  --  games:table: 00000000F8A45880
  InfCore.Log"---"
  local mainGame=applicationInstance:GetGame"MainGame"
  InfCore.PrintInspect(mainGame,"mainGame")
  InfCore.PrintInspect(getmetatable(mainGame),"mainGame metatable")
  InfCore.Log("mainGame:"..tostring(mainGame))
  --  mainGame=<userdata 1>
  --  mainGame metatable={
  --    __index = <function 1>,
  --    __newindex = <function 2>,
  --    __tostring = <function 3>
  --  }
  --  mainGame:Game: 0x00000000067E21D0
  InfCore.Log"---"
  local mainScene=applicationInstance:GetScene"MainScene"--tex from start.lua
  InfCore.PrintInspect(mainScene,"mainScene")
  InfCore.PrintInspect(getmetatable(mainScene),"mainScene metatable")
  InfCore.Log("mainScene:"..tostring(mainScene))
  --  mainScene=<userdata 1>
  --  mainScene metatable={
  --    __index = <function 1>,
  --    __newindex = <function 2>,
  --    __tostring = <function 3>
  --  }
  --  mainScene:Scene: 0x000000001CE134D0
  InfCore.Log"---"



  -- InfCore.PrintInspect(mainGame.ExportDataRelationGraph())--expects entity


  --  local bucket=mainScene:GetMainBucket()
  --  bucket.GetEditableDataSetPath("dpp")

  --
  --local scene=game:GetScene"MainScene"
  --InfLog.PrintInspect(scene:GetActorList())
  ----InfLog.PrintInspect(Data.GetDataSet())
  ----
  ----
  --InfLog.PrintInspect(EntityClassDictionary.GetCategoryList("Locator"))
  --InfLog.PrintInspect(EntityClassDictionary.GetClassNameList("Locator"))
  --
  --
  --
  --
  local identifier="HelispaceLocatorIdentifier"
  --
  local locatorName="BuddyQuietLocator"
  local key="BuddyDDogLocator"
  --
  --local dataTypeName="TransformData"
  local data=DataIdentifier.GetDataWithIdentifier(identifier,key)--,dataTypeName)
  local dataSet=DataSet.GetDataList(identifier,key)--,dataTypeName)
  InfLog.Add"==="
  InfLog.PrintInspect(data)
  InfLog.PrintInspect(data:GetClassName())
  InfLog.PrintInspect(data:GetPropertyList())
  InfLog.PrintInspect(data:GetPropertyInfo("name"))
  InfLog.PrintInspect(data.name)
  InfLog.PrintInspect(data.referencePath)
  --InfLog.PrintInspect(data.worldTransform)
  --InfLog.PrintInspect(data.worldTransform.translation)
  --InfLog.PrintInspect(data.worldTransform.translation:GetX())
  --
  --InfLog.PrintInspect(data.worldTransform:GetClassName())
  --InfLog.PrintInspect(data.worldTransform.translation:GetClassName())


  InfLog.PrintInspect(DataSet.GetDataSetFile(data))



end

function this.PrintStrCodes()
  InfCore.Log"DebugIHVars.PrintStrCodes---------------"
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
      "Walk",--DEBUGNOW
    }

    for i,str in ipairs(strings)do
      local str32=Fox.StrCode32(str)
      InfCore.Log(str.."="..tostring(str32))
    end

end

--DEBUGNOW





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


return this
