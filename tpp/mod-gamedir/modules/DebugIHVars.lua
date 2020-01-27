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

  --InfNPC.debugModule=true
  --InfModelProc.debugModule=true
  --InfQuest.debugModule=true
  --TppQuest.debugModule=true
  --InfInterrogation.debugModule=true
  --InfMBGimmick.debugModule=true
  --InfLookup.debugModule=true

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

--DEBUGNOW
function this.DumpShit()
  this.ihExternal={}
  local externalModuleNames={}
  for path,files in pairs(InfCore.files)do
    local files=InfCore.GetFileList(files,".lua",true)
    for i,moduleName in pairs(files)do
      table.insert(externalModuleNames,moduleName)
    end
  end
  InfCore.PrintInspect(externalModuleNames)

  for i,moduleName in ipairs(externalModuleNames)do
    this.ihExternal[moduleName]=true
  end

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
      if this.ihInternal[k] then
        addEntry=false
      elseif this.ihExternal[k] then
        addEntry=false
      end
    end

    if skipTpp then
      if this.tppInternal[k] then
        addEntry=false
      end
    end

    if skipModules then
      if this.luaInternal[k] then
        addEntry=false
      end
    end

    if skipModules then
      if skipModuleNames[k] then
        addEntry=false
      end
    end

    if addEntry then
      local types=globalTypes[type(v)]
      types=types or globalTypes.other
      types[k]=v
    end
  end

  --InfCore.PrintInspect(globalTypes)
  --tex tables exposed form MGS_TPP.exe are userdata
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
  --

  --
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

  this.BreakDownModules(globalTypes.table)

  --this.GetReferences(globalTypes.table)--DEBUGNOW



  local outDir=[[D:\Projects\MGS\dump\]]
  this.DumpToFiles(outDir,globalTypes.table)

end

local open=io.open
local Inspect=InfInspect.Inspect

local nl=[[\n\r]]--DEBUGWIP "\n\r"
function this.WriteString(filePath,someString)
  local file,error=open(filePath,"w")
  if not file or error then
    return
  end

  file:write(someString)
  file:close()
end

function this.DumpToFiles(outDir,moduleTable)
  for k,v in pairs(moduleTable) do
    local filename=outDir..k..'.txt'
    local ins=Inspect(v)
    this.WriteString(filename,k.."="..ins)
  end
end

function this.GetFileNamesFromDirOut(fileName)
  --InfCore.Log("GetFileNamesFromDirOut "..fileName)
  local fileNames=InfCore.PCall(function()
    local lines
    local file,openError=io.open(fileName,"r")
    if file and not openError then
      InfCore.Log("GetFileNamesFromDirOut "..fileName)--DEBUGNOW
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
  return fileNames
end

function this.BreakDownModules(modules)
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

  local outDir=[[D:\Projects\MGS\dump\breakdown\]]
  this.DumpToFiles(outDir,breakDown)
end


function this.GetReferences(modules)
  local luaFolder=[[J:\GameData\MGS\filetypecrushed\lua\]]--DEBUGNOW
  local outName="luaFileList.txt"

  local cmd=[[dir /s /b "]]..luaFolder..[[*.lua" > "]]..luaFolder..outName..[["]]
  InfCore.Log(cmd)
  os.execute(cmd)

  local luaFilePaths=this.GetFileNamesFromDirOut(luaFolder..outName)
  InfCore.PrintInspect(luaFilePaths,"luaFilePaths")--DEBUGNOW

  --local stringBreak={}--DEBUGNOW
  this.refs={}
  for i,filePath in ipairs(luaFilePaths)do
    InfCore.Log(filePath)--DEBUGNOW
    local lines=this.GetFileNamesFromDirOut(filePath)
    for i,line in ipairs(lines)do
      for moduleName,moduleInfo in pairs(modules)do
        local line=line

        local stringBreak={}
        local delim = {
          ",", " ", "\n", "%]", "%)", "}", "\t",
          "%+","-",">","<","=","/","%*","~","%%",
          "'","\"","{","%(","%[",
        }
        local str = line
        local pattern = "[^"..table.concat(delim).."]+"
        for w in str:gmatch(pattern) do
          --InfCore.Log(w)
          table.insert(stringBreak,w)
        end

        --InfCore.Log("looking for "..moduleName)--DEBUGNOW
        local findStr=moduleName

        for i,line in ipairs(stringBreak)do
          local findIndex,findEndIndex=string.find(line,findStr)
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
                  this.refs[moduleName]=this.refs[moduleName]or{}
                  this.refs[moduleName][key]=true
              end
              end
            end

            findIndex=string.find(line,findStr)
            --InfCore.Log(findIndex)--DEBUGNOW
          end
        end
      end
    end
  end

  --InfCore.PrintInspect(stringBreak,"-----------stringBreak")
  InfCore.PrintInspect(this.refs,"-----------refs")
  local outDir=[[D:\Projects\MGS\dump\luaobjectscrape\]]
  this.DumpToFiles(outDir,this.refs)
end

this.luaInternal={
  ___lclass=true,
  ___lfunc=true,
  ___lnvar=true,
  ___lvar=true,
  bit=true,--tex bit module statically built
  coroutine=true,
  debug=true,
  io=true,
  math=true,
  os=true,
  string=true,
  table=true,
}

this.ihInternal={
  ivars=true,
  evars=true,
  InfInspect=true,
  InfUtil=true,
  InfCore=true,
  IvarProc=true,
  InfInit=true,
  InfModelProc=true,
  --
  InfButton=true,
  InfModules=true,
  InfMain=true,
  InfMenu=true,
  InfEneFova=true,
  InfRevenge=true,
  InfFova=true,
  InfLZ=true,
  InfPersistence=true,
  InfHooks=true,
}

--tex filetypecrushed lua, getfileList
this.tppInternal={
  afgh=true,
  afgh_animal=true,
  afgh_base=true,
  afgh_baseTelop=true,
  afgh_checkPoint=true,
  afgh_combat=true,
  afgh_common_fx_mtr_def=true,
  afgh_common_fx_mtr_rain=true,
  afgh_common_fx_mtr_underwater=true,
  afgh_cpGroups=true,
  afgh_gimmick=true,
  afgh_landingZone=true,
  afgh_luxury_block_list=true,
  afgh_quest=true,
  afgh_routeSets=true,
  afgh_siren=true,
  afgh_travelPlans=true,
  AiRtEvSoldier=true,
  animal_block=true,
  avatar_presets=true,
  banana_q10500=true,
  banana_q11600=true,
  banana_q11700=true,
  banana_q60023=true,
  banana_q71400=true,
  CameraAroundParams=true,
  CameraSubjectiveParams=true,
  CameraTpsParams=true,
  ChimeraPartsPackageTable=true,
  citadel_q1090=true,
  citadel_q60112=true,
  cliffTown_q1050=true,
  cliffTown_q11040=true,
  cliffTown_q11050=true,
  cliffTown_q60012=true,
  cliffTown_q71050=true,
  cliffTown_q71060=true,
  cliffTown_q99080=true,
  commFacility_q1060=true,
  commFacility_q11080=true,
  commFacility_q19013=true,
  commFacility_q80060=true,
  cypr=true,
  CyprRailActionDataSet=true,
  cypr_mission_block=true,
  cypr_player_bed_and_corridor=true,
  cypr_player_rail=true,
  cypr_player_volgin_ride=true,
  DamageParameterTables=true,
  Debug2DPrint=true,
  DebugChangeCameraSitPreset=true,
  DebugChangeTppGlobalVolFog=true,
  DebugFxEffectDispChange=true,
  DebugRouteChange=true,
  DebugSoundPostEvent=true,
  demo_block=true,
  diamond_q10600=true,
  diamond_q71500=true,
  diamond_q80600=true,
  emblem_list=true,
  Entity=true,
  EquipDevelopConstSetting=true,
  EquipDevelopFlowSetting=true,
  EquipIdTable=true,
  EquipMotionData=true,
  EquipMotionDataForChimera=true,
  EquipParameters=true,
  EquipParameterTables=true,
  f30010_demo=true,
  f30010_enemy=true,
  f30010_orderBoxList=true,
  f30010_radio=true,
  f30010_sequence=true,
  f30010_sound=true,
  f30020_demo=true,
  f30020_enemy=true,
  f30020_orderBoxList=true,
  f30020_radio=true,
  f30020_sequence=true,
  f30050_demo=true,
  f30050_enemy=true,
  f30050_radio=true,
  f30050_sequence=true,
  f30050_sound=true,
  f30150_sequence=true,
  f30250_demo=true,
  f30250_enemy=true,
  f30250_radio=true,
  f30250_sequence=true,
  field_q10020=true,
  field_q30010=true,
  field_q71020=true,
  field_q71090=true,
  field_q80020=true,
  FobUI=true,
  fort_q10080=true,
  fort_q11060=true,
  fort_q11070=true,
  fort_q20911=true,
  fort_q60013=true,
  fort_q71080=true,
  fort_q80080=true,
  FxShadersNoLnm_dx11=true,
  FxShaders_dx11=true,
  gmpEarnMissions=true,
  GrModelShadersNoLnm_dx11=true,
  GrModelShaders_dx11=true,
  GrSystemShadersNoLnm_dx11=true,
  GrSystemShaders_dx11=true,
  gr_init=true,
  gr_init_dx11=true,
  h40020_sequence=true,
  h40050_sequence=true,
  heli_common_photo=true,
  heli_common_radio=true,
  heli_common_sequence=true,
  hill_q10400=true,
  hill_q11500=true,
  hill_q19012=true,
  hill_q60021=true,
  hill_q80400=true,
  init=true,
  init_sequence=true,
  lab_q10700=true,
  lab_q20914=true,
  lab_q39011=true,
  lab_q60022=true,
  lab_q71600=true,
  lab_q71700=true,
  lab_q80700=true,
  LanguageInit=true,
  ly003=true,
  ly003_s10115=true,
  ly013=true,
  ly023=true,
  ly033=true,
  ly043=true,
  ly073=true,
  ly083=true,
  ly093=true,
  mafr=true,
  mafr_animal=true,
  mafr_base=true,
  mafr_baseTelop=true,
  mafr_checkPoint=true,
  mafr_combat=true,
  mafr_common_fx_mtr_def=true,
  mafr_common_fx_mtr_rain=true,
  mafr_common_fx_mtr_underwater=true,
  mafr_cpGroups=true,
  mafr_gimmick=true,
  mafr_luxury_block_list=true,
  mafr_routeSets=true,
  mafr_siren=true,
  mafr_travelPlans=true,
  mbdvc_map_location_parameter=true,
  mbdvc_map_mbstage_parameter=true,
  mbdvc_map_mission_parameter=true,
  mbdvc_pause_help_table=true,
  MbmCommonSetting=true,
  MbmCommonSetting20BaseResSec=true,
  MbmCommonSetting30Deploy=true,
  MbmCommonSetting40RewardDeploy=true,
  MbmCommonSetting50RewardFob=true,
  MbmCommonSetting60DbPfLang=true,
  mission_main=true,
  MotherBaseWeaponSpecSetting=true,
  mtbs=true,
  mtbs_baseTelop=true,
  mtbs_cluster=true,
  mtbs_common_fx_mtr_def=true,
  mtbs_common_fx_mtr_rain=true,
  mtbs_common_fx_mtr_underwater=true,
  mtbs_enemy=true,
  mtbs_helicopter=true,
  mtbs_item=true,
  npc_block=true,
  o50050_enemy=true,
  o50050_item=true,
  o50050_radio=true,
  o50050_sequence=true,
  o50050_sound=true,
  OnlineChallengeTask=true,
  order_box_block=true,
  outland_q10100=true,
  outland_q11090=true,
  outland_q11100=true,
  outland_q19011=true,
  outland_q20913=true,
  outland_q40010=true,
  outland_q60024=true,
  outland_q60113=true,
  outland_q71200=true,
  outland_q80100=true,
  outland_q99071=true,
  Pad=true,
  pfCamp_q10200=true,
  pfCamp_q11200=true,
  pfCamp_q39012=true,
  pfCamp_q60020=true,
  pfCamp_q60114=true,
  pfCamp_q80200=true,
  player2_camouf_param=true,
  PreinstallTape=true,
  priorityTable=true,
  qest_bossQuiet_00=true,
  qest_q101210=true,
  qest_q101220=true,
  qest_smoking=true,
  quest_child_dog=true,
  quest_ddog_walking=true,
  quest_liquid_challenge=true,
  quest_q20015=true,
  quest_q20025=true,
  quest_q20035=true,
  quest_q20045=true,
  quest_q20055=true,
  quest_q20065=true,
  quest_q20075=true,
  quest_q20085=true,
  quest_q20095=true,
  quest_q20105=true,
  quest_q20205=true,
  quest_q20305=true,
  quest_q20405=true,
  quest_q20505=true,
  quest_q20605=true,
  quest_q20705=true,
  quest_q20805=true,
  quest_q20905=true,
  quest_q21005=true,
  quest_q22005=true,
  quest_q23005=true,
  quest_q24005=true,
  quest_q25005=true,
  quest_q26005=true,
  quest_q27005=true,
  quest_q42010=true,
  quest_q42020=true,
  quest_q42030=true,
  quest_q42040=true,
  quest_q42050=true,
  quest_q42060=true,
  quest_q42070=true,
  quest_q52010=true,
  quest_q52015=true,
  quest_q52020=true,
  quest_q52025=true,
  quest_q52030=true,
  quest_q52035=true,
  quest_q52040=true,
  quest_q52045=true,
  quest_q52050=true,
  quest_q52055=true,
  quest_q52060=true,
  quest_q52065=true,
  quest_q52070=true,
  quest_q52075=true,
  quest_q52080=true,
  quest_q52085=true,
  quest_q52090=true,
  quest_q52095=true,
  quest_q52100=true,
  quest_q52105=true,
  quest_q52110=true,
  quest_q52115=true,
  quest_q52120=true,
  quest_q52125=true,
  quest_q52130=true,
  quest_q52135=true,
  quest_q52140=true,
  quest_q52145=true,
  quest_visit_quiet=true,
  quest_wait_quiet=true,
  RadioParameterTable=true,
  RecoilMaterialTable=true,
  reinforce_block=true,
  ruins_q10030=true,
  ruins_q19010=true,
  ruins_q60010=true,
  ruins_q60115=true,
  s00005_sequence=true,
  s10010_demo=true,
  s10010_enemy=true,
  s10010_enemy2=true,
  s10010_radio=true,
  s10010_score=true,
  s10010_sequence=true,
  s10010_sound=true,
  s10020_demo=true,
  s10020_enemy=true,
  s10020_enemy2=true,
  s10020_radio=true,
  s10020_score=true,
  s10020_sequence=true,
  s10020_sound=true,
  s10030_demo=true,
  s10030_enemy=true,
  s10030_radio=true,
  s10030_sequence=true,
  s10030_sound=true,
  s10033_demo=true,
  s10033_enemy=true,
  s10033_order_box=true,
  s10033_radio=true,
  s10033_score=true,
  s10033_sequence=true,
  s10033_sound=true,
  s10033_telop=true,
  s10036_demo=true,
  s10036_enemy=true,
  s10036_order_box=true,
  s10036_radio=true,
  s10036_score=true,
  s10036_sequence=true,
  s10036_sound=true,
  s10036_telop=true,
  s10040_demo=true,
  s10040_enemy=true,
  s10040_order_box=true,
  s10040_radio=true,
  s10040_score=true,
  s10040_sequence=true,
  s10040_sound=true,
  s10040_telop=true,
  s10041_demo=true,
  s10041_enemy=true,
  s10041_order_box=true,
  s10041_radio=true,
  s10041_score=true,
  s10041_sequence=true,
  s10041_sound=true,
  s10041_telop=true,
  s10043_demo=true,
  s10043_enemy=true,
  s10043_order_box=true,
  s10043_radio=true,
  s10043_score=true,
  s10043_sequence=true,
  s10043_sound=true,
  s10043_telop=true,
  s10044_demo=true,
  s10044_enemy=true,
  s10044_order_box=true,
  s10044_radio=true,
  s10044_score=true,
  s10044_sequence=true,
  s10044_sound=true,
  s10044_telop=true,
  s10045_demo=true,
  s10045_enemy=true,
  s10045_order_box=true,
  s10045_radio=true,
  s10045_score=true,
  s10045_sequence=true,
  s10045_sound=true,
  s10045_telop=true,
  s10050_demo=true,
  s10050_enemy=true,
  s10050_radio=true,
  s10050_score=true,
  s10050_sequence=true,
  s10050_sound=true,
  s10050_telop=true,
  s10052_demo=true,
  s10052_enemy=true,
  s10052_order_box=true,
  s10052_radio=true,
  s10052_score=true,
  s10052_sequence=true,
  s10052_sound=true,
  s10052_telop=true,
  s10054_demo=true,
  s10054_enemy=true,
  s10054_order_box=true,
  s10054_radio=true,
  s10054_score=true,
  s10054_sequence=true,
  s10054_sound=true,
  s10054_telop=true,
  s10070_demo=true,
  s10070_enemy01=true,
  s10070_enemy02=true,
  s10070_enemy03=true,
  s10070_radio=true,
  s10070_score=true,
  s10070_sequence=true,
  s10070_sound=true,
  s10070_telop=true,
  s10080_demo=true,
  s10080_enemy=true,
  s10080_radio=true,
  s10080_score=true,
  s10080_sequence=true,
  s10080_sound=true,
  s10080_telop=true,
  s10081_demo=true,
  s10081_enemy=true,
  s10081_order_box=true,
  s10081_radio=true,
  s10081_score=true,
  s10081_sequence=true,
  s10081_sound=true,
  s10081_telop=true,
  s10082_demo=true,
  s10082_enemy=true,
  s10082_order_box=true,
  s10082_radio=true,
  s10082_score=true,
  s10082_sequence=true,
  s10082_sound=true,
  s10082_telop=true,
  s10085_demo=true,
  s10085_enemy=true,
  s10085_order_box=true,
  s10085_radio=true,
  s10085_score=true,
  s10085_sequence=true,
  s10085_sound=true,
  s10085_telop=true,
  s10086_demo=true,
  s10086_enemy=true,
  s10086_order_box=true,
  s10086_radio=true,
  s10086_score=true,
  s10086_sequence=true,
  s10086_sound=true,
  s10086_telop=true,
  s10090_demo=true,
  s10090_enemy=true,
  s10090_order_box=true,
  s10090_radio=true,
  s10090_score=true,
  s10090_sequence=true,
  s10090_sound=true,
  s10090_telop=true,
  s10091_demo=true,
  s10091_enemy=true,
  s10091_order_box=true,
  s10091_radio=true,
  s10091_score=true,
  s10091_sequence=true,
  s10091_sound=true,
  s10091_telop=true,
  s10093_demo=true,
  s10093_enemy=true,
  s10093_order_box=true,
  s10093_radio=true,
  s10093_score=true,
  s10093_sequence=true,
  s10093_sound=true,
  s10093_telop=true,
  s10100_demo=true,
  s10100_enemy=true,
  s10100_enemy2=true,
  s10100_order_box=true,
  s10100_radio=true,
  s10100_score=true,
  s10100_sequence=true,
  s10100_sound=true,
  s10100_telop=true,
  s10110_demo=true,
  s10110_enemy=true,
  s10110_enemy02=true,
  s10110_npc_block=true,
  s10110_npc_block2=true,
  s10110_order_box=true,
  s10110_radio=true,
  s10110_score=true,
  s10110_sequence=true,
  s10110_sound=true,
  s10110_telop=true,
  s10115_enemy=true,
  s10115_radio=true,
  s10115_score=true,
  s10115_sequence=true,
  s10115_sound=true,
  s10115_telop=true,
  s10120_demo=true,
  s10120_enemy=true,
  s10120_order_box=true,
  s10120_radio=true,
  s10120_score=true,
  s10120_sequence=true,
  s10120_sound=true,
  s10120_telop=true,
  s10121_demo=true,
  s10121_enemy=true,
  s10121_order_box=true,
  s10121_radio=true,
  s10121_score=true,
  s10121_sequence=true,
  s10121_sound=true,
  s10121_telop=true,
  s10130_demo=true,
  s10130_enemy=true,
  s10130_enemy02=true,
  s10130_enemy03=true,
  s10130_order_box=true,
  s10130_radio=true,
  s10130_score=true,
  s10130_sequence=true,
  s10130_sound=true,
  s10130_telop=true,
  s10140_demo=true,
  s10140_enemy=true,
  s10140_enemy01=true,
  s10140_radio=true,
  s10140_score=true,
  s10140_sequence=true,
  s10140_sound=true,
  s10140_telop=true,
  s10150_demo=true,
  s10150_enemy=true,
  s10150_enemy02=true,
  s10150_order_box=true,
  s10150_radio=true,
  s10150_score=true,
  s10150_sequence=true,
  s10150_sound=true,
  s10151_demo=true,
  s10151_enemy=true,
  s10151_radio=true,
  s10151_score=true,
  s10151_sequence=true,
  s10151_sound=true,
  s10156_demo=true,
  s10156_enemy=true,
  s10156_order_box=true,
  s10156_radio=true,
  s10156_score=true,
  s10156_sequence=true,
  s10156_sound=true,
  s10156_telop=true,
  s10171_demo=true,
  s10171_enemy=true,
  s10171_order_box=true,
  s10171_radio=true,
  s10171_score=true,
  s10171_sequence=true,
  s10171_sound=true,
  s10171_telop=true,
  s10195_demo=true,
  s10195_enemy=true,
  s10195_order_box=true,
  s10195_radio=true,
  s10195_score=true,
  s10195_sequence=true,
  s10195_sound=true,
  s10195_telop=true,
  s10200_demo=true,
  s10200_enemy=true,
  s10200_order_box=true,
  s10200_radio=true,
  s10200_score=true,
  s10200_sequence=true,
  s10200_sound=true,
  s10200_telop=true,
  s10211_demo=true,
  s10211_enemy=true,
  s10211_order_box=true,
  s10211_radio=true,
  s10211_score=true,
  s10211_sequence=true,
  s10211_sound=true,
  s10211_telop=true,
  s10240_demo=true,
  s10240_enemy=true,
  s10240_enemy02=true,
  s10240_radio=true,
  s10240_score=true,
  s10240_sequence=true,
  s10240_sound=true,
  s10240_telop=true,
  s10260_demo=true,
  s10260_enemy=true,
  s10260_radio=true,
  s10260_score=true,
  s10260_sequence=true,
  s10260_sound=true,
  s10260_telop=true,
  savannah_q10300=true,
  savannah_q11300=true,
  savannah_q11400=true,
  savannah_q71300=true,
  Scene=true,
  setup=true,
  Soldier2FaceAndBodyData=true,
  Soldier2ParameterTables=true,
  SoundTppAnimal=true,
  SoundTppPlayer=true,
  SoundTppSoldier=true,
  sovietBase_q10070=true,
  sovietBase_q20912=true,
  sovietBase_q60014=true,
  sovietBase_q60110=true,
  sovietBase_q60111=true,
  sovietBase_q71070=true,
  sovietBase_q99020=true,
  sovietBase_q99030=true,
  sovietBase_q99070=true,
  start=true,
  start2nd=true,
  tent_q10010=true,
  tent_q11010=true,
  tent_q11020=true,
  tent_q20910=true,
  tent_q60011=true,
  tent_q71010=true,
  tent_q71030=true,
  tent_q80010=true,
  tent_q99040=true,
  tent_q99072=true,
  title_sequence=true,
  Tpp=true,
  TppAnimal=true,
  TppAnimalBlock=true,
  TppCassette=true,
  TppCheckPoint=true,
  TppClock=true,
  TppCollection=true,
  TppDbgStr32=true,
  TppDebug=true,
  TppDebugMbDevelop=true,
  TppDefine=true,
  TppDemo=true,
  TppDemoBlock=true,
  TppDevelopFile=true,
  TppEmblem=true,
  TppEneFova=true,
  TppEnemy=true,
  TppEnemyBodyId=true,
  TppEnemyFaceGroup=true,
  TppEnemyFaceGroupId=true,
  TppEnemyFaceId=true,
  TppException=true,
  TppFreeHeliRadio=true,
  TppGeneInter=true,
  TppGimmick=true,
  TppGVars=true,
  TppHelicopter=true,
  TppHero=true,
  TppInterrogation=true,
  TppLandingZone=true,
  TppLocation=true,
  TppMain=true,
  TppMarker=true,
  TppMath=true,
  TppMbFreeDemo=true,
  TppMission=true,
  TppMissionList=true,
  TppMovie=true,
  TppPackList=true,
  TppPadOperatorUtility=true,
  TppPaz=true,
  TppPlayer=true,
  TppPlayer2CallbackScript=true,
  TppPlayer2InitializeScript=true,
  TppQuest=true,
  TppQuestList=true,
  TppRadio=true,
  TppRanking=true,
  TppRatBird=true,
  TppReinforceBlock=true,
  TppResult=true,
  TppRevenge=true,
  TppReward=true,
  TppSave=true,
  TppScriptBlock=true,
  TppSequence=true,
  TppShadersNoLnm_dx11=true,
  TppShaders_dx11=true,
  TppSound=true,
  TppStory=true,
  TppTelop=true,
  TppTerminal=true,
  TppTrap=true,
  TppTrapExecChangeCamera=true,
  TppTrapExecChangeCamSitPreset=true,
  TppTrapExecReachBase=true,
  TppTrapExecVolginCharge=true,
  TppTrapExecVolginSetParams=true,
  TppTrophy=true,
  TppTutorial=true,
  TppUI=true,
  TppUiBootInit=true,
  TppUiPrefetchTexture=true,
  TppVarInit=true,
  TppWeather=true,
  UiRegisterInfo=true,
  waterway_q10040=true,
  waterway_q11030=true,
  waterway_q20040=true,
  waterway_q39010=true,
  waterway_q71040=true,
  waterway_q80040=true,
  waterway_q99012=true,
  WeaponPartsCombinationSettings=true,
  WeaponPartsUiSetting=true,
}

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
