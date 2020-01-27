-- InfLookup.lua
-- tex various script analysis, lookup-tables, printing functions
-- still some other stuff scattered around:
-- InfLangProc.CpNameString

local this={}

--LOCAOPT
local InfCore=InfCore
local TppGameObject=TppGameObject
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local NULL_ID=GameObject.NULL_ID
local StrCode32=Fox.StrCode32

this.debugModule=false

this.str32ToString={}--tex what the <module>.DEBUG_StrCode32ToString tables are loaded into as well as mod\strings\*.txt, migrates into InfCore.str32ToString if this.StrCode32ToString gets any hits.

this.subtitleId32ToString={}--tex NOTE: interrogation name is also subtitleId (TODO also note in wiki for subp?)
this.path32ToDataSetName={}

this.strings={}
this.gameObjectNames={}

this.soldierSvarIndexes={}

this.dictionaries={
  subtitleId={
    fileName="subp_dictionary.txt",
    HashFunction=Fox.StrCode32,--seems SubtitlesCommand:ConvertToSubtitlesId(subtitleId) is just StrCode32
  },
}

function this.PostModuleReload(prevModule)
  this.subtitleId32ToString=prevModule.subtitleId32ToString
  this.path32ToDataSetName=prevModule.path32ToDataSetName
  --GOTCHA: generated lookups need to be restored too else they'll point to the empty ones from the newly loaded module
  this.lookups.subtitleId=this.subtitleId32ToString
  this.lookups.dataSetPath32=this.path32ToDataSetName

  this.strings=prevModule.strings
  this.gameObjectNames=prevModule.gameObjectNames

  this.soldierSvarIndexes=prevModule.soldierSvarIndexes
end

function this.PostAllModulesLoad()
  if not InfCore.debugMode then
    return
  end

  --tex not really going to do too much runtime edit/reload, so bail out so I dont have to wait
  if InfCore.doneStartup then
    return
  end

  this.LoadStrings()

  this.BuildStr32ToString()
  this.BuildPath32ToDataSetName()

  this.AddObjectNamesToStr32List()
  this.BuildDictionaryLookup("subtitleId",this.subtitleId32ToString)


  this.LoadGameObjectNames()

  if this.debugModule then
    InfCore.PrintInspect(this.lookups,"InfLookup.lookups")
  end
end

function this.OnInitializeTop(missionTable)
  if Ivars.debugMode:Is(0) then
    return
  end
  --tex want this as early as possible (gameobjects are init sometime between allocate and oninit)
  --GOTCHA: InfLookup isn't guaranteed to be before any other modules (but currently there aren't really any other modules that do InfLookups in OnInitTop)
  this.BuildGameIdToNames()
  this.BuildSoldierSvarIndexes()--DEBUGNOW don't know at what point soldier svars are valid, TODO: find down those svar save commands (TppEnemy.StoreSVars/RestoreOn?) and log the call

  for name,module in pairs(missionTable)do
    if module.DEBUG_strCode32List then
      InfCore.Log("Adding "..tostring(name)..".DEBUG_strCode32List to strCode32List")
      this.AddToStr32StringLookup(module.DEBUG_strCode32List)
    end
  end
end

function this.Init(missionTable)
  if Ivars.debugMode:Is(0) then
    return
  end

  this.InitObjectLists(missionTable)

  InfCore.Log"Dumping unknownStr32"
  --DEBUGNOW TODO also load ih_unknownStr32 into InfCore.unknownStr32 so I don't have to babysit the file over sessions and just let it accumulate
  local unknownStr={}
  for strCode,isUnknown in pairs(InfCore.unknownStr32)do
    unknownStr[#unknownStr+1]=strCode
  end
  table.sort(unknownStr)

  InfCore.WriteStringTable(InfCore.paths.mod.."ih_unknownStr32.txt",unknownStr)

  InfCore.Log"Dumping unknownMessages"
  local unknownMessages={InfInspect.Inspect(InfCore.unknownMessages)}
  InfCore.WriteStringTable(InfCore.paths.mod.."ih_unknownMessages.txt",unknownMessages)
end

function this.Save()
  if Ivars.debugMode:Is(0) then
    return
  end

  --DEBUGNOW WIP - See this.Init
  --  if IHGenUnknownHashes then
  --    InfCore.Log("Saving IHGenUnknownHashes")
  --    local saveTextList={}
  --    saveTextList[#saveTextList+1]="--IHGenUnknownHashes.lua"
  --    saveTextList[#saveTextList+1]="--GENERATED at runtime from hashes that have no match"
  --    saveTextList[#saveTextList+1]="this={}"
  --    IvarProc.BuildTableText("unknownStr32",IHGenUnknownHashes.unknownStr32,saveTextList)
  --    IvarProc.BuildTableText("unknownMessages",IHGenUnknownHashes.unknownMessages,saveTextList)
  --    saveTextList[#saveTextList+1]="return this"
  --    InfCore.WriteStringTable(InfCore.paths.modules.."IHGenUnknownHashes.lua",saveTextList)
  --  end
end

function this.LoadStrings()
  if InfCore.filesFull.strings then
    InfCore.LogFlow("LoadStrings")
    for i,filePath in ipairs(InfCore.filesFull.strings)do
      InfCore.Log("LoadStrings "..filePath)
      local name=InfUtil.GetFileName(filePath,true)
      local extension=InfUtil.GetFileExtension(filePath)
      if extension==".txt" then
        local lines=InfCore.GetLines(filePath)
        if lines==nil then
          InfCore.Log("InfLookup LoadStrings: could not load "..name)
        else
          --InfCore.Log("Adding "..name.." to strings")
          this.strings[name]=lines
        end
      end
    end
  end
end

--lookup-tables>
function this.GenerateNameList(fmt,num,list)
  local list=list or {}
  for i=0,num-1 do
    local name=string.format(fmt,i)
    table.insert(list,name)
  end
  return list
end

--tex TODO: scrape fox2s typeName
this.gameObjectClass={
  "TppBear",
  "TppBuddyDog2",
  "TppBuddyPuppy",
  "TppBuddyQuiet2",
  "TppBossQuiet2",--tex is also sniper parasites
  "TppCodeTalker2",
  "TppCommandPost2",
  "TppCommonWalkerGear2",
  "TppCorpse",
  "TppCritterBird",
  "TppDecoySystem",
  "TppEagle",
  "TppEnemyHeli",
  "TppEspionageRadioSystem",
  "TppGoat",
  "TppJackal",
  "TppMarker2LocatorSystem",
  "TppNubian",
  "TppHeli2",
  "TppHorse2",
  "TppHostage2",
  "TppHostageKaz",
  "TppHostageUnique",
  "TppHostageUnique2",
  "TppHuey2",
  "TppJackal",
  "TppLiquid2",
  "TppMantis2",
  "TppMarkerLocatorSystem",
  "TppNubian",
  "TppOcelot2",
  "TppOtherHeli2",
  "TppParasite2",
  "TppPlacedSystem",
  "TppPlayer2",
  "TppPlayerHorseforVr",--tex prologue volgin escape
  "TppRat",
  "TppSahalen2",
  "TppSecurityCamera2",
  "TppSkullFace2",
  "TppSoldier2",
  "TppStork",
  "TppSupplyCboxSystem",
  "TppSupportAttackSystem",
  "TppVolgin2",
  "TppVolgin2forVr",--tex prologue volgin escape
  "TppUav",
  "TppVehicle2",
  "TppWalkerGear2",
  "TppWolf",
  "TppZebra",
}

this.mbCps={
  "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|mtbs_command_cp",
  "ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|mtbs_combat_cp",
  "ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|mtbs_develop_cp",
  "ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|mtbs_support_cp",
  "ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|mtbs_medic_cp",
  "ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|mtbs_intel_cp",
  "ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|mtbs_basedev_cp",
}

--TABLESETUP
--tex TODO: scrape fox2s
this.objectNameLists={
  player_locator=this.GenerateNameList("player_locator_%04d",2),
  helis={"SupportHeli","EnemyHeli","WestHeli"},
  accPilot={"hos_pilot_0000"},
  charactersInPrologue={"ishmael","volgin","ocelot","ocelot_horse"},
  charactersInMb={
    "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",
    "mtbs_uq0040_plnt0000|uq_00400000|uq_0040_asset|TppPazLocator"
  },
  buddies={"BuddyDogGameObjectLocator","BuddyDogGameObjectLocator","BuddyQuietGameObjectLocator","BuddyWalkerGearGameObjectLocator",},
  characters={"TppHuey2GameObjectLocator"},
  veh_lv=this.GenerateNameList("veh_lv_%04d",20),--jeeps
  veh_trc=this.GenerateNameList("veh_trc_%04d",10),--trucks
  wkr_WalkerGear=this.GenerateNameList("wkr_WalkerGear_%04d",20),
  anml_quest=this.GenerateNameList("anml_quest_%02d",10),
  sol_quest=this.GenerateNameList("sol_quest_%04d",10),
  hos_quest=this.GenerateNameList("hos_quest_%04d",10),
  vehicle_quest=this.GenerateNameList("vehicle_quest_%04d",10),
  ih_hostage=this.GenerateNameList("ih_hostage_%04d",30),
  itm_Mine_quest=this.GenerateNameList("itm_Mine_quest_%04d",10),
  itm_revDecoy=this.GenerateNameList("itm_revDecoy_%04d",10),
  itm_revMine=this.GenerateNameList("itm_revMine_%04d",10),
  OtherHeli=this.GenerateNameList("OtherHeli%04d",10),
  TppCorpseGameObjectLocator=this.GenerateNameList("TppCorpseGameObjectLocator%04d",12),--TODO VERIFY max
  pickable_ih=this.GenerateNameList("pickable_ih_%04d",20),
  pickable_quest=this.GenerateNameList("pickable_quest_%04d",20),
  mbCps=this.mbCps,
}

--tex from TppAnimalBlock animalsTable
--REF
--  Goat={type="TppGoat",locatorFormat="anml_goat_%02d",routeFormat="rt_anml_goat_%02d",nightRouteFormat="rt_anml_goat_n%02d",isHerd=true,isDead=false},
--  Wolf={type="TppWolf",locatorFormat="anml_wolf_%02d",routeFormat="rt_anml_wolf_%02d",nightRouteFormat="rt_anml_wolf_n%02d",isHerd=true,isDead=false},
--  Nubian={type="TppNubian",locatorFormat="anml_nubian_%02d",routeFormat="rt_anml_nubian_%02d",nightRouteFormat="rt_anml_nubian_n%02d",isHerd=true,isDead=false},
--  Jackal={type="TppJackal",locatorFormat="anml_jackal_%02d",routeFormat="rt_anml_jackal_%02d",nightRouteFormat="rt_anml_jackal_n%02d",isHerd=true,isDead=false},
--  Zebra={type="TppZebra",locatorFormat="anml_Zebra_%02d",routeFormat="rt_anml_Zebra_%02d",nightRouteFormat="rt_anml_Zebra_n%02d",isHerd=true,isDead=false},
--  Bear={type="TppBear",locatorFormat="anml_bear_%02d",routeFormat="rt_anml_bear_%02d",nightRouteFormat="rt_anml_bear_n%02d",isHerd=false,isDead=false},
--  BuddyPuppy={type="TppBuddyPuppy",locatorFormat="anml_BuddyPuppy_%02d",routeFormat="rt_anml_BuddyPuppy_%02d",nightRouteFormat="rt_anml_BuddyPuppy_%02d",isHerd=false,isDead=false},
--  MotherDog={type="TppJackal",locatorFormat="anml_MotherDog_%02d",routeFormat="rt_anml_BuddyPuppy_%02d",nightRouteFormat="rt_anml_BuddyPuppy_%02d",isHerd=false,isDead=true},
--  Rat={type="TppRat",locatorFormat="anml_rat_%02d",routeFormat="rt_anml_rat_%02d",nightRouteFormat="rt_anml_rat_%02d",isHerd=false,isDead=false},
--  NoAnimal={type="NoAnimal",locatorFormat="anml_NoAnimal_%02d",routeFormat="rt_anml_BuddyPuppy_%02d",nightRouteFormat="rt_anml_BuddyPuppy_%02d",isHerd=false,isDead=false}
local animalLocatorPrefixes={
  anml_goat="anml_goat_%02d",
  anml_wolf="anml_wolf_%02d",
  anml_nubian="anml_nubian_%02d",
  anml_jackal="anml_jackal_%02d",
  anml_Zebra="anml_Zebra_%02d",
  anml_bear="anml_bear_%02d",
  anml_BuddyPuppy="anml_BuddyPuppy_%02d",
  anml_MotherDog="anml_MotherDog_%02d",
  anml_rat="anml_rat_%02d",
  anml_NoAnimal="anml_NoAnimal_%02d",
}
for name,fmt in pairs(animalLocatorPrefixes)do
  this.objectNameLists[name]=this.GenerateNameList(fmt,10)
end

this.objectNameLists.mbVehicleNames={
  "veh_cl01_cl00_0000",
  "veh_cl02_cl00_0000",
  "veh_cl03_cl00_0000",
  "veh_cl04_cl00_0000",
  "veh_cl05_cl00_0000",
  "veh_cl06_cl00_0000",
  "veh_cl00_cl04_0000",
  "veh_cl00_cl02_0000",
  "veh_cl00_cl03_0000",
  "veh_cl00_cl01_0000",
  "veh_cl00_cl05_0000",
  "veh_cl00_cl06_0000",
}

for location,cpNames in pairs(InfMain.baseNames) do
  this.objectNameLists["cpNames"..location]=cpNames
end

function this.InitObjectLists(missionTable)
  this.objectNameLists.reinforceNames={TppReinforceBlock.REINFORCE_SOLDIER_NAMES,"TppSoldier2"}
  this.objectNameLists.reinforceDriver={"reinforce_soldier_driver"}
  if InfNPCHeli then
    this.objectNameLists.heliUTH=InfNPCHeli.heliNames.UTH
    this.objectNameLists.heliUTH=InfNPCHeli.heliNames.HP48
  end
  if InfAnimal then
    this.objectNameLists.ihBirdNames=InfAnimal.birdNames
  end
  if InfMainTpp then
    this.objectNameLists.reserveSoldierNames=InfMainTpp.reserveSoldierNames
  end
end
--

function this.Time(time)
  return TppClock.FormalizeTime(time,"string")
end

--tex not exhaustive, theres still a bunch of loose ids scattered around, and a bunch only defined in EXE
function this.PopupErrorId(findErrorId)
  for errorName,errorId in pairs(TppDefine.ERROR_ID) do
    if findErrorId==errorId then
      return errorName
    end
  end
  return nil
end

--tex TODO, wont really cover all anyway, better to just use str32 table, or scrape one targeted at lz objects
this.str32LzToLz={}
function this.BuildStr32ToLzLookup()

end

function this.LandingZoneName(lzStr32)
  return InfLZ.str32LzToLz[lzStr32]
end

function this.BuildStr32ToString()
  for name,strings in pairs(this.strings) do
    InfCore.Log("Adding "..name.." strings to strCode32List")
    this.AddToStr32StringLookup(strings)
  end
  for i,libName in ipairs(Tpp._requireList)do
    local module=_G[libName]
    if module and module.DEBUG_strCode32List then
      InfCore.Log("Adding "..tostring(libName)..".DEBUG_strCode32List to strCode32List")
      this.AddToStr32StringLookup(module.DEBUG_strCode32List)
    end
  end
  for i,module in ipairs(InfModules)do
    if module.DEBUG_strCode32List then
      InfCore.Log("Adding "..tostring(module.name)..".DEBUG_strCode32List to strCode32List")
      this.AddToStr32StringLookup(module.DEBUG_strCode32List)
    end
  end
end

--tex TODO: more targeted?
--SIDE: this.path32ToDataSetName
function this.BuildPath32ToDataSetName()
  InfCore.Log("InfLookup.BuildPath32ToDataSetName:")
  for name,strings in pairs(this.strings) do
    for i,line in ipairs(strings)do
      local ext=InfUtil.GetFileExtension(line)
      --InfCore.Log(ext)--DEBUG
      if ext==".fox2" then
        local path32=Fox.PathFileNameCode32(line)
        this.path32ToDataSetName[path32]=line
      end
    end
  end
  --InfCore.PrintInspect(this.path32ToDataSetName,"path32ToDataSetName")--DEBUG
end

--tex gives {[gameClass.Enum]=enum name}
function this.BuildGameClassEnumNameLookup(gameClassName,enumNames)
  InfCore.LogFlow("InfLookup.BuildGameClassEnumNameLookup: "..gameClassName)

  local gameClass=_G[gameClassName]

  if gameClass==nil then
    InfCore.Log("WARNING: InfLookup.BuildGameClassEnumNameLookup: gameclass "..gameClassName.." == nil")
    return
  end

  local enumNameLookup={}
  for i,name in ipairs(enumNames) do
    local enum=gameClass[name]
    if enum then
      if enumNameLookup[enum] then
        if this.debugModule then
          InfCore.Log("WARNING: InfLookup.BuildGameClassEnumNameLookup "..name.." with enum "..enum.." is same as ".. enumNameLookup[enum])--DEBUG
        end
        enumNameLookup[enum]=enumNameLookup[enum].."||"..name
      else
        enumNameLookup[enum]=name
      end
    else
      InfCore.Log("WARNING: InfLookup.BuildGameClassEnumNameLookup: could not find enum "..tostring(name))
    end
  end
  if #enumNameLookup==0 then
    InfCore.Log("WARNING: InfLookup.BuildGameClassEnumNameLookup: "..gameClassName.." #enumNameLookup==0")
  end
  return enumNameLookup
end

--tex assumes gameclass has lua readable enum names like TppDamage, and not whatever index fancyness gameclasses like ScritBlock do
function this.BuildDirectGameClassEnumLookup(gameClassName,filter)
  InfCore.LogFlow("InfLookup.BuildGameClassEnumNameLookup: "..gameClassName)

  local gameClass=_G[gameClassName]

  --tex WORKAROUND autodoc/mock
  if gameClass==nil then
    InfCore.Log("WARNING: InfLookup.BuildGameClassEnumNameLookup: gameClass "..gameClassName.."==nil")
    return {}
  end

  local enumToName={}
  for k,v in pairs(gameClass)do
    if type(v)=="number" then
      if string.find(k,filter)~=nil then
        if enumToName[v] then
          if this.debugModule then
            InfCore.Log("WARNING: InfLookup.BuildDirectGameClassEnumLookup: "..k.." with enum "..v.." is same as ".. enumToName[v])--DEBUG
          end
          enumToName[v]=enumToName[v].."|"..k
        else
          enumToName[v]=k
        end
      end
    end
  end
  if #enumToName==0 then
    InfCore.Log("WARNING: InfLookup.BuildGameClassEnumNameLookup: gameClass "..gameClassName.." "..filter.." #enumToName==0")
  end
  return enumToName
end

--tex --DEBUGNOW CULL or think of a sub list selection system
function this.GetObjectList()
  -- return{"ih_uav_0000","ih_uav_0001","ih_uav_0002","ih_uav_0003"}
  --   return{ "sol_mtbs_0000",
  --    "sol_mtbs_0001",
  --    "sol_mtbs_0002",
  --    "sol_mtbs_0003",
  --    "sol_mtbs_0004",
  --    "sol_mtbs_0005",
  --    }
  --
  -- return InfMainTpp.reserveSoldierNames
  --        local travelPlan="travelArea2_01"
  --         return InfVehicle.inf_patrolVehicleConvoyInfo[travelPlan]

  --return InfParasite.parasiteNames[InfParasite.parasiteType]
  -- return this.objectNameLists.veh_trc
  --return InfLookup.jeepNames
  --return {TppReinforceBlock.REINFORCE_DRIVER_SOLDIER_NAME}
  --return TppReinforceBlock.REINFORCE_SOLDIER_NAMES
  --return InfInterrogation.interCpQuestSoldiers
  --   return InfWalkerGear.walkerNames
  --return InfNPCHeli.heliList
  --return TppEnemy.armorSoldiers
  --return InfAnimal.birdNames
  -- return objectNameLists[4]
  --return InfSoldier.ene_wildCardNames
  --return InfNPC.hostageNames
  return this.objectNameLists.sol_quest
    --return {"hos_quest_0000"}
    --return InfWalkerGear.walkerNames
    --return{"sol_quest_ih_0000","sol_quest_ih_0001","sol_quest_ih_0002","sol_quest_ih_0003",}
    --return {"vehicle_quest_0000"}
end

--tex there's no real lookup for this I've found
--there's probably faster tables (look in DefineSoldiers()) that have the cpId>soldierId, but this is nice for the soldiername,cpname
function this.ObjectNameForGameIdList(findId,list,objectType)
  for n,name in ipairs(list)do
    local gameId=NULL_ID
    if objectType then
      gameId=GetGameObjectId(objectType,name)
    else
      gameId=GetGameObjectId(name)
    end
    if gameId~=NULL_ID then
      if gameId==findId then
        return name
      end
    end
  end
end
--returns name or nil

function this.GameObjectNameFromSoldierIDList(findId)
  if mvars.ene_soldierIDList then
    for cpId,soldierIds in pairs(mvars.ene_soldierIDList)do
      for soldierId,soldierName in pairs(soldierIds)do
        if soldierId==findId then
          local cpName=mvars.ene_cpList[cpId]
          return soldierName,cpName
        end
      end
    end
  end
end

function this.ObjectNameForGameId(findId,objectType)
  if findId==0 then
    return "Player"--ASSUMPTION -- player instance 0, single player/local player
  end
  if findId==1 then
    return "Player instance 1"--ASSUMPTION, fob defender (if local is server)
  end

  --tex == 65535
  if findId==NULL_ID then
    return "NULL_ID"
  end

  local lookupName=InfCore.gameIdToName[findId]
  if lookupName then
    return lookupName
  end

  if not objectType or objectType=="TppSoldier2" then
    local objectName=this.GameObjectNameFromSoldierIDList(findId)
    if objectName then
      return objectName
    end
  end

  --tex alread added in BuildGameIdToNames, but quest objects wont have been loaded at that point
  for listName,list in pairs(this.objectNameLists) do
    local objectName
    --tex {{nameList},"objectType"}
    if type(list[1])=="table" then
      if not objectType or objectType==list[2] then
        objectName=this.ObjectNameForGameIdList(findId,list[1],list[2])
      end
    else
      objectName=this.ObjectNameForGameIdList(findId,list)
    end
    if objectName then
      return objectName
    end
  end

  --too killer on performance to do frequencly, TODO enable on a switch
  --  if IHStringsGameObjectNames then
  --    local module=IHStringsGameObjectNames
  --    if module.lookupStrings then
  --      local objectName=this.ObjectNameForGameIdList(findId,module.lookupStrings)
  --      if objectName then
  --        return objectName
  --      end
  --    end
  --  end
  --nuclear option, try str32 lists
  --  for i,module in ipairs(InfModules) do
  --    if module.lookupStrings then
  --      local objectName=this.ObjectNameForGameIdList(findId,module.lookupStrings)
  --      if objectName then
  --        return objectName
  --      end
  --    end
  --  end

  return nil
end

function this.GameObjectNameForGimmickId(gimmickId)
  if mvars.gim_identifierParamTable==nil then
    return "WARNING: mvars.gim_identifierParamTable==nil"
  end
  local ret,gameId=TppGimmick.GetGameObjectId(gimmickId)
  return this.ObjectNameForGameId(gameId)
end

function this.CpNameForCpId(cpId)
  local cpName
  if mvars.ene_cpList then
    cpName=mvars.ene_cpList[cpId]
  end
  if cpName==nil then
    if InfUtil.GetLocationName()=="mtbs" then
      local clusterId=MotherBaseStage.GetCurrentCluster()
      local cpName=this.mbCps[clusterId]
      local gameId=GetGameObjectId("TppCommandPost2",cpName)
      if cpId==gameId then
        return cpName
      end
      cpName=this.ObjectNameForGameIdList(cpId,this.mbCps,"TppCommandPost2")
    end
  end
  if cpName==nil then
    InfCore.Log("WARNING: InfLookup.CpNameForCpId: could not find cpName in lists")
    this.ObjectNameForGameId(cpId)
  end
  return cpName
end

function this.SoldierSvarIndexForName(soldierName)
  local s32Name=StrCode32(soldierName)
  local svarIndex=this.soldierSvarIndexes[s32Name]
  --DEBUGNOW TODO check out of bounds?
  if svars.solName[svarIndex]~=s32Name then
    InfCore.Log("WARNING: InfLookup.SoldierSvarIndexForName: soldierSvarIndexes index for "..soldierName.."/"..s32Name.." does not match svars index")--DEBUGNOW
    --DEBUGNOW TODO: not picking up quest soldiers for some reason, either: I'm doing something wrong, or they're flagged no to save?
    for i=0,mvars.ene_maxSoldierStateCount-1 do
      if svars.solName[i]==s32Name then
        return i
      end
    end

    return nil
  end
  return svarIndex
end

--TABLESETUP
function this.BuildTppEquipLookup()
  local enumToName={}
  for k,v in pairs(TppEquip)do
    if type(v)=="number" then
      if string.find(k,"EQP_")~=nil and string.find(k,"EQP_TYPE_")==nil and string.find(k,"EQP_BLOCK_")==nil then
        if enumToName[v] then
          if this.debugModule then
            InfCore.Log("WARNING: InfLookup.BuildTppEquipLookup: "..k.." with enum "..v.." is same as ".. enumToName[v])
          end
          enumToName[v]=enumToName[v].."|"..k
        else
          enumToName[v]=k
        end
      end
    end
  end
  return enumToName
end

function this.AddToStr32StringLookup(strCode32List)
  for i,someString in ipairs(strCode32List)do
    this.str32ToString[StrCode32(someString)]=someString
  end
end

--tex returns string or nil
--isStrCode on guaranteed strcodes to add that code to unknowns (this function is also used in a blanket fashion in PrintOnMessage with potential non-strcodes)
function this.StrCode32ToString(strCode,isStrCode)
  if type(strCode)=="number" then
    --tex using InfCore since this is built up using Fox.StrCode32 replacement InfCore.StrCode32, since InfCore is loaded before lib modules
    local returnString=InfCore.str32ToString[strCode]
    if returnString==nil then
      returnString=this.str32ToString[strCode]
      if returnString then
        InfCore.str32ToString[strCode]=returnString--tex push back into InfCore str32ToString so I can dump that as a verified in-use dictionary
      end
    end
    if isStrCode and returnString==nil then
      InfCore.unknownStr32[strCode]=true
    end
    if returnString==nil then
      return nil-- strCode
    end

    if type(returnString)=="number" then
      InfCore.Log("WARNING: InfLookup.StrCode32ToString: returnString for strCode:"..strCode.." is a number: "..returnString)
    end

    return returnString
  else
    InfCore.Log("WARNING: InfLookup.StrCode32ToString: strCode:"..tostring(strCode).." is not a number.")
  end
end

function this.DumpStrCodeTables()
  InfCore.Log("InfCore.str32ToString")
  --InfCore.PrintInspect(InfCore.str32ToString)

  local strings={}
  local strToCode={}
  for strCode,str in pairs(InfCore.str32ToString)do
    table.insert(strings,str)
    strToCode[str]=strCode
  end
  table.sort(strings)
  for i,str in ipairs(strings) do
    InfCore.Log(str.."="..strToCode[str])
  end

  InfCore.PrintInspect(InfCore.unknownStr32,{varName="InfCore.unknownStr32"})
end


--game class lookups
this.HeadshotMessageFlag={
  headshotMessageFlag=this.BuildGameClassEnumNameLookup("HeadshotMessageFlag",
    {--are bitflags,
      "IS_TRANQ_HANDGUN",--1
      "IS_JUST_UNCONSCIOUS",--2
      "NEUTRALIZE_DONE",--4
    }
  ),
}

--tex outputs all flag states for the bitflag value
this.HeadshotMessageFlag.headshotMessageFlags=function(flag)
  local flagsStatus={}
  local flags=this.HeadshotMessageFlag.headshotMessageFlag
  for bitFlag,flagName in pairs(flags)do
    flagsStatus[bitFlag]=false
    if bit.band(flag,bitFlag)==bitFlag then
      flagsStatus[bitFlag]=true
    end
  end
  local flagsStr="|"
  for bitFlag,flagSet in pairs(flagsStatus)do
    flagsStr=flagsStr..flags[bitFlag].."="..tostring(flagSet).."|"
  end
  return flagsStr
end

this.NeutralizeCause={
  --TODO: at lease one missing (gap in consecurive enum)
  --22 missing, trigger by doing holdup, or fultoning walker?
  neutralizeCause=this.BuildGameClassEnumNameLookup("NeutralizeCause",
    {
      "CQC",
      "NO_KILL",
      "NO_KILL_BULLET",
      "CQC_KNIFE",
      "HANDGUN",
      "SUBMACHINE_GUN",
      "SHOTGUN",
      "ASSAULT_RIFLE",
      "MACHINE_GUN",
      "SNIPER_RIFLE",
      "GRENADE",
      "MINE",
      "QUIET",
      "D_DOG",
      "D_HORSE",
      "D_WALKER_GEAR",
      "VEHICLE",
      "SUPPORT_HELI",
      "ASSIST",
      "ROCKET_ARM",
      "GIMMICK",
    }
  ),
}

this.NeutralizeFobCause={
  --TODO: at lease two missing (gaps in consecurive enum)
  neutralizeFobCause=this.BuildGameClassEnumNameLookup("NeutralizeFobCause",
    {
      "CQC",
      "CQC_KNIFE",
      "HANDGUN",
      "SUBMACHINE_GUN",
      "SHOTGUN",
      "ASSAULT_RIFLE",
      "MACHINE_GUN",
      "SNIPER_RIFLE",
      "QUIET",
      "D_DOG",
      "D_HORSE",
      "D_WALKER_GEAR",
      "VEHICLE",
      "ASSIST",
      "ROCKET_ARM",
      "GRENADER",
      "ANTIMATERIAL_RIFLE",
      "THROWING",
      "PLACED",
      "BOSS",
      "TURRET",
      "ANTI_AIR",
      "MORTAR",
      "HELI_MINI_GUN",
    }
  ),
}

this.NeutralizeType={
  neutralizeType=this.BuildGameClassEnumNameLookup("NeutralizeType",
    {"INVALID","FAINT","SLEEP","DYING","HOLDUP","FULTON"}
  ),
}

this.ScriptBlock={
  scriptBlockState=this.BuildGameClassEnumNameLookup("ScriptBlock",
    {
      "SCRIPT_BLOCK_STATE_EMPTY",
      "SCRIPT_BLOCK_STATE_PROCESSING",
      "SCRIPT_BLOCK_STATE_INACTIVE",
      "SCRIPT_BLOCK_STATE_ACTIVE",
    }
  ),
  scriptBlockStateTransition=this.BuildGameClassEnumNameLookup("ScriptBlock",
    {
      "TRANSITION_LOADED",
      "TRANSITION_ACTIVATED",
      "TRANSITION_DEACTIVATED",
      "TRANSITION_EMPTIED",
    }
  ),
}

this.StageBlock={
  stageBlockState=this.BuildGameClassEnumNameLookup("StageBlock",
    {
      "INACTIVE",
      "ACTIVE",
    }
  ),
}

this.TppCollection={
  resourceType=this.BuildDirectGameClassEnumLookup("TppCollection","TYPE_"),
}

this.TppDamage={
  attackId=this.BuildDirectGameClassEnumLookup("TppDamage","ATK_"),
  damageSource=this.BuildDirectGameClassEnumLookup("TppDamage","DAM_SOURCE_"),
  injuryType=this.BuildDirectGameClassEnumLookup("TppDamage","INJ_TYPE_"),
}

this.TppEquip={
  equipId=this.BuildTppEquipLookup(),
  equipType=this.BuildDirectGameClassEnumLookup("TppEquip","EQP_TYPE_"),
}

--DEBUG >
--InfCore.Log("Iterate TppGameObject")
--for k,v in pairs(TppGameObject) do
--  InfCore.Log(tostring(k)..","..tostring(v))
--end
--InfCore.Log("Inspect TppGameObject")
--InfCore.PrintInspect(TppGameObject)
--<

local gameObjectTypes={
  "GAME_OBJECT_TYPE_BALLOON_SYSTEM",
  "GAME_OBJECT_TYPE_BATTLEGEAR",
  "GAME_OBJECT_TYPE_BEAR",
  "GAME_OBJECT_TYPE_BIRD2",
  "GAME_OBJECT_TYPE_BOSSQUIET2",
  "GAME_OBJECT_TYPE_BRIDGE",
  "GAME_OBJECT_TYPE_BUDDYDOG2",
  "GAME_OBJECT_TYPE_BUDDYPUPPY",
  "GAME_OBJECT_TYPE_BUDDYQUIET2",
  "GAME_OBJECT_TYPE_BULLET_SYSTEM3",
  "GAME_OBJECT_TYPE_CAPTURECAGE_SYSTEM",
  "GAME_OBJECT_TYPE_CASING_SYSTEM",
  "GAME_OBJECT_TYPE_CBOX",
  "GAME_OBJECT_TYPE_CODE_TALKER2",
  "GAME_OBJECT_TYPE_COLLECTION_SYSTEM",
  "GAME_OBJECT_TYPE_COMMAND_POST2",
  "GAME_OBJECT_TYPE_COMMON_HORSE2",
  "GAME_OBJECT_TYPE_COMMON_WALKERGEAR2",
  "GAME_OBJECT_TYPE_CORPSE",
  "GAME_OBJECT_TYPE_CRITTER_BIRD",
  "GAME_OBJECT_TYPE_DECOY_SYSTEM",
  "GAME_OBJECT_TYPE_DOOR",
  "GAME_OBJECT_TYPE_DUNG_SYSTEM",
  "GAME_OBJECT_TYPE_EAGLE",
  "GAME_OBJECT_TYPE_ENEMY_HELI",
  "GAME_OBJECT_TYPE_EQUIP_SYSTEM",
  "GAME_OBJECT_TYPE_ESPIONAGEBOX",
  "GAME_OBJECT_TYPE_ESPIONAGE_RADIO",
  "GAME_OBJECT_TYPE_EVENT_ANIMATION",
  "GAME_OBJECT_TYPE_EXAMPLE",
  "GAME_OBJECT_TYPE_FOB_GAME_DAEMON",
  "GAME_OBJECT_TYPE_FULTON",
  "GAME_OBJECT_TYPE_FULTONABLE_CONTAINER",
  "GAME_OBJECT_TYPE_GARBAGEBOX",
  "GAME_OBJECT_TYPE_GATLINGGUN",
  "GAME_OBJECT_TYPE_GOAT",
  "GAME_OBJECT_TYPE_HELI2",
  "GAME_OBJECT_TYPE_HORSE2",
  "GAME_OBJECT_TYPE_HORSE2_FOR_VR",
  "GAME_OBJECT_TYPE_HOSTAGE2",
  "GAME_OBJECT_TYPE_HOSTAGE_KAZ",
  "GAME_OBJECT_TYPE_HOSTAGE_UNIQUE",
  "GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2",
  "GAME_OBJECT_TYPE_HUEY2",
  "GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE",
  "GAME_OBJECT_TYPE_IR_SENSOR",
  "GAME_OBJECT_TYPE_JACKAL",
  "GAME_OBJECT_TYPE_LIQUID2",
  "GAME_OBJECT_TYPE_MACHINEGUN",
  "GAME_OBJECT_TYPE_MANTIS2",
  "GAME_OBJECT_TYPE_MARKER2_LOCATOR",
  "GAME_OBJECT_TYPE_MBQUIET",
  "GAME_OBJECT_TYPE_MGO_ACTOR",
  "GAME_OBJECT_TYPE_MORTAR",
  "GAME_OBJECT_TYPE_MOTHER_BASE_CONTAINER",
  "GAME_OBJECT_TYPE_NOTICE_OBJECT",
  "GAME_OBJECT_TYPE_NUBIAN",
  "GAME_OBJECT_TYPE_OBSTRUCTION_SYSTEM",
  "GAME_OBJECT_TYPE_OCELOT2",
  "GAME_OBJECT_TYPE_OTHER_HELI",
  "GAME_OBJECT_TYPE_OTHER_HELI2",
  "GAME_OBJECT_TYPE_PARACHUTE_SYSTEM",
  "GAME_OBJECT_TYPE_PARASITE2",
  "GAME_OBJECT_TYPE_PICKABLE_SYSTEM",
  "GAME_OBJECT_TYPE_PLACED_SYSTEM",
  "GAME_OBJECT_TYPE_PLAYER2",
  "GAME_OBJECT_TYPE_PLAYER_HORSE2_FOR_VR",
  "GAME_OBJECT_TYPE_POI_SYSTEM",
  "GAME_OBJECT_TYPE_RADIO_CASSETTE",
  "GAME_OBJECT_TYPE_RANGE_ATTACK",
  "GAME_OBJECT_TYPE_RAT",
  "GAME_OBJECT_TYPE_SAHELAN2",
  "GAME_OBJECT_TYPE_SAMPLE_GAME_OBJECT",
  "GAME_OBJECT_TYPE_SAMPLE_MANAGER",
  "GAME_OBJECT_TYPE_SEARCHLIGHT",
  "GAME_OBJECT_TYPE_SECURITYCAMERA2",
  "GAME_OBJECT_TYPE_SHELL_SYSTEM",
  "GAME_OBJECT_TYPE_SKULL_FACE2",
  "GAME_OBJECT_TYPE_SOLDIER2",
  "GAME_OBJECT_TYPE_STORK",
  "GAME_OBJECT_TYPE_SUPPLY_CBOX",
  "GAME_OBJECT_TYPE_SUPPORT_ATTACK",
  "GAME_OBJECT_TYPE_SYSTEM_RECEIVER",
  "GAME_OBJECT_TYPE_THROWING_SYSTEM",
  "GAME_OBJECT_TYPE_TOILET",
  "GAME_OBJECT_TYPE_UAV",
  "GAME_OBJECT_TYPE_VEHICLE",
  "GAME_OBJECT_TYPE_VOLGIN2",
  "GAME_OBJECT_TYPE_VOLGIN2_FOR_VR",
  "GAME_OBJECT_TYPE_WALKERGEAR2",
  "GAME_OBJECT_TYPE_WATCH_TOWER",
  "GAME_OBJECT_TYPE_WATER_TOWER",
  "GAME_OBJECT_TYPE_WOLF",
  "GAME_OBJECT_TYPE_ZEBRA",
}

this.TppGameObject={
  --tex: no go, TppGameObject seems to have more dynamic indexing funkyness
  --  typeIndex=this.BuildDirectGameClassEnumLookup("TppGameObject","GAME_OBJECT_TYPE_"),
  --  routeEventFailedType=this.BuildDirectGameClassEnumLookup("TppGameObject","ROUTE_EVENT_FAILED_TYPE_"),

  phase=this.BuildGameClassEnumNameLookup("TppGameObject",
    {
      "PHASE_SNEAK",
      "PHASE_CAUTION",
      "PHASE_EVASION",
      "PHASE_ALERT",
    }
  ),
  routeEventFailedType=this.BuildGameClassEnumNameLookup("TppGameObject",
    {
      "ROUTE_EVENT_FAILED_TYPE_NONE",
      "ROUTE_EVENT_FAILED_TYPE_VEHICLE_GET_IN",
      "ROUTE_EVENT_FAILED_TYPE_WALKER_GEAR_GET_IN",
      "ROUTE_EVENT_FAILED_TYPE_PICK_UP_HONEY_BEE",
      "ROUTE_EVENT_FAILED_TYPE_LOST_HOSTAGE_PUT_IN_VEHICLE",
      "ROUTE_EVENT_FAILED_TYPE_LOST_HOSTAGE_TAKE_OUT_OF_VEHICLE",
      "ROUTE_EVENT_FAILED_TYPE_LOST_VEHICLE_HOSTAGE_PUT_IN",
      "ROUTE_EVENT_FAILED_TYPE_LOST_VEHICLE_HOSTAGE_TAKE_OUT_OF",
    }
  ),
  vehicleActionType=this.BuildGameClassEnumNameLookup("TppGameObject",
    {
      "VEHICLE_ACTION_TYPE_GOT_IN_VEHICLE",
      "VEHICLE_ACTION_TYPE_GOT_OUT_VEHICLE",
      "VEHICLE_ACTION_TYPE_FELL_OFF_VEHICLE",
    }
  ),

  typeIndex=this.BuildGameClassEnumNameLookup("TppGameObject",gameObjectTypes),
}

this.TppSystem={
  bgmPhase=this.BuildGameClassEnumNameLookup("TppSystem",
    {
      --tex actual enum order, from 0
      "BGM_PHASE_NONE",
      "BGM_PHASE_SNEAK_1",
      "BGM_PHASE_SNEAK_2",
      "BGM_PHASE_SNEAK_3",
      "BGM_PHASE_CAUTION",
      "BGM_PHASE_EVASION",
      "BGM_PHASE_ALERT",
      "BGM_PHASE_ALERT_BATTLE",
      "BGM_PHASE_ALERT_CP",
      "BGM_PHASE_ALERT_REINFORCE",
      "BGM_PHASE_ALERT_LOST",
    }
  ),
}

--< game classes

--TppDefine.WEATHER
this.weatherTypeNames={
  [0]="SUNNY",
  [1]="CLOUDY",
  [2]="RAINY",
  [3]="SANDSTORM",
  [4]="FOGGY",
  [5]="POURING",
}

local gameClasses={
  "HeadshotMessageFlag",
  "NeutralizeCause",
  "NeutralizeFobCause",
  "NeutralizeType",
  "ScriptBlock",
  "StageBlock",
  "TppCollection",
  "TppDamage",
  "TppEquip",
  "TppGameObject",
  "TppSystem",
}

--tex player carry soldier/hostage
this.carryState={
  [0]="START",--going through pick up animation
  [1]="END",--dropped/thrown
  [2]="CARRYING",
}

--tex simplified lookup name to lookup table or function
this.lookups={
  str32=this.StrCode32ToString,
  gameId=this.ObjectNameForGameId,
  cpId=this.CpNameForCpId,
  time=this.Time,
  weatherType=this.weatherTypeNames,
  popupId=this.PopupErrorId,
  --landingZone=this.LandingZoneName,--tex not complete, use str32 instead
  carryState=this.carryState,
  gimmickId=this.GameObjectNameForGimmickId,
  subtitleId=this.subtitleId32ToString,
  dataSetPath32=this.path32ToDataSetName,
}
--tex crushes down this[gameclass][lookup] to lookups[lookup] - ex this.lookups.phase=TppGameObject.phase
for i,gameClass in ipairs(gameClasses)do
  for lookupType,lookup in pairs(this[gameClass])do
    this.lookups[lookupType]=lookup
  end
end

function this.Lookup(lookupType,value)
  local lookedupValue=nil
  local lookup=this.lookups[lookupType]
  if type(lookup)=="function" then
    lookedupValue=lookup(value)
  elseif type(lookup)=="table" then
    lookedupValue=lookup[value]
  else
    if lookupType~="number" then
      InfCore.Log("WARNING: InfLookup.Lookup: no lookup of type "..lookupType)
    end
  end
  return lookedupValue
end

--tex message signatures for PrintOnMessage/Ivars.debugMessages
-- {
--  MESSAGE CLASS={
--    MSG={
--      [arg(n+1)]={argName=<arg name>,argType=<lookupType>},
-- lookupType for this.lookups table.
this.messageSignatures={
  Block={
    OnScriptBlockStateTransition={
      {argName="blockName",argType="str32"},
      {argName="blockState",argType="scriptBlockStateTransition"},
    },
    OnChangeLargeBlockState={
      {argName="blockName",argType="str32"},
      {argName="blockStatus",argType="stageBlockState"},
    },
    OnChangeSmallBlockState={
      {argName="blockIndexX",argType="number"},
      {argName="blockIndexY",argType="number"},
      {argName="blockStatus",argType="stageBlockState"},
    },
    StageBlockCurrentSmallBlockIndexUpdated={
      {argName="blockIndexX",argType="number"},
      {argName="blockIndexY",argType="number"},
      {argName="clusterIndex",argType="number"},
    },
  },
  GameObject={
    ArrivedAtLandingZoneSkyNav={--SupportHeli
      {argName="heliId",argType="gameId"},
      {argName="landingZone",argType="str32"},
    },
    ArrivedAtLandingZoneWaitPoint={--SupportHeli
      {argName="heliId",argType="gameId"},
      {argName="landingZone",argType="str32"},
    },
    BreakGimmick={
      {argName="gimmickId",argType="gimmickId"},
      {argName="locatorNameS32",argType="str32"},
      {argName="dataSetPath32",argType="dataSetPath32"},
      {argName="attackerId",argType="gameId"},
    },
    BreakGimmickBurglarAlarm={
      {argName="attackerId",argType="gameId"},--VERIFY is gameId
    },
    BurglarAlarmTrap={
      {argName="bAlarmId",argType="gimmickId"},--VERIFY is gameId
      {argName="bAlarmHash",argType="str32"},--tex from ly<layout>.lua .itemTable.stolenAlarms
      {argName="bAlarmDataSet",argType="dataSetPath32"},--VERIFY
      {argName="triggerer",argType="gameId"},--tex who tripped alarm
    },
    CalledFromStandby={--SupportHeli
      {argName="gameId",argType="gameId"},
    },
    Carried={--carry soldier/hostage
      {argName="gameId",argType="gameId"},
      {argName="carryState",argType="carryState"},
    },
    ChangePhase={
      {argName="cpId",argType="cpId"},
      {argName="phase",argType="phase"},
      {argName="priorPhase",argType="phase"},
    },
    ChangePhaseForAnnounce={
      {argName="cpId",argType="cpId"},
      {argName="phase",argType="phase"},
    },
    Conscious={
      {argName="gameId",argType="gameId"},
      {argName="arg1",argType="number"},--tex UNKNOWN 65535 or ?, 0 or ?
      {argName="arg2",argType="number"},--tex UNKNOWN
    },
    ConversationEnd={
      {argName="cpId",argType="cpId"},
      {argName="speechLabel",argType="str32"},
      {argName="isSuccess",argType="number"},--boolasnumber
    },
    Damage={--On Damage
      {argName="damagedId",argType="gameId"},--object that took damage
      {argName="attackId",argType="attackId"},
      {argName="attackerId",argType="gameId"},
      {argName="unk3",argType="number"},--tex UNKNOWN: no use cases I can see
    },
    Dead={
      --tex still unsure if some calls to messages have more args than others, while most Dead msg reesponse functions only care about thr first two args, and the only msg calls ive seen logged only have
      --but then you have TppResult Dead - function(gameId,attackerId,playerPhase,deadMessageFlag)
      {argName="gameId",argType="gameId"},
      {argName="attackerId",argType="gameId"},
      {argName="phase",argType="phase"},
      {argName="deadMessageFlag",argType="number"},--TODO:
    },
    DescendToLandingZone={--SupportHeli
      {argName="heliId",argType="gameId"},
      {argName="landingZone",argType="str32"},
    },
    Down={
      {argName="downedId",argType="gameId"},--tex when soldier downed
    },
    Fulton={
      {argName="gameId",argType="gameId"},
      {argName="gimmickInstanceOrAnimalId",argType="number"},
      {argName="gimmickDataSet",argType="dataSetPath32"},
      {argName="staffIdOrResourceId",argType="number"},--TODO:
    },
    FultonInfo={
      {argName="gameId",argType="gameId"},
      {argName="fultonedPlayerIndex",argType="number"},
      {argName="reduceThisContainer",argType="number"},--boolAsNumber
    },
    LandedAtLandingZone={--SupportHeli
      {argName="heliId",argType="gameId"},
      {argName="landingZone",argType="str32"},
    },
    Neutralize={
      {argName="gameId",argType="gameId"},
      {argName="attackerId",argType="gameId"},
      {argName="neutralizeType",argType="neutralizeType"},
      {argName="neutralizeCause",argType="neutralizeCause"},
    },
    NeutralizeFob={
      {argName="gameId",argType="gameId"},
      {argName="attackerId",argType="gameId"},
      {argName="neutralizeType",argType="neutralizeType"},
      {argName="neutralizeFobCause",argType="neutralizeFobCause"},
    },
    HeadShot={
      {argName="gameId",argType="gameId"},
      {argName="attacker",argType="attackId"},
      {argName="attackerId",argType="gameId"},
      {argName="headshotMessageFlags",argType="headshotMessageFlags"},
    },
    HeadShotDistance={
      {argName="gameId",argType="gameId"},
      {argName="attacker",argType="attackId"},
      {argName="attackerId",argType="gameId"},
      {argName="distance",argType="number"},
    },
    InSight={--tex when heli spots player
      {argName="heliId",argType="gameId"},
      {argName="targetId",argType="gameId"},
    },
    Interrogate={
      {argName="soldierId",argType="gameId"},
      {argName="cpId",argType="cpId"},
      {argName="allowCollectionInterr",argType="number"},--boolasnumber
    },
    InterrogateEnd={
      {argName="soldierId",argType="gameId"},
      {argName="cpId",argType="cpId"},
      {argName="strCodeName",argType="str32"},
      {argName="index",argType="number"},
    },
    RadioEnd={--tex fired by soldier calling via radio? in mission script msgs they mostly have variables/comments saying 'conversation'
      {argName="gameId",argType="gameId"},--tex gamobjectid of what soldier is reporting on? is player in the case of soldier reporting spotted player to cp
      {argName="cpId",argType="cpId"},--tex cp theyre calling? calling from?
      {argName="speechLabel",argType="str32"},--tex there's a bunch of labels referenced in mission CPR0081 (cp radio I guess), the param is most often named speechLabel, but these dont match subpids like other conversations (unless I've missed some subp hashes somehow).
      {argName="isSuccess",argType="number"},
    },
    ReinforceRespawn={--tex on each normal reinforce soldier respawn
      {argName="soldierId",argType="gameId"},
    },
    RequestLoadReinforce={--tex prior call for super reinforce
      {argName="reinforceCpId",argType="cpId"},
    },
    RouteEventFaild={--tex AI route event failed
      {argName="gameId",argType="gameId"},
      {argName="routeId",argType="str32"},--tex TODO gather route names
      {argName="failureType",argType="routeEventFailedType"},
    },
    RoutePoint2={--tex fire by Route Event 'SendMessage', and some other unknown Route Events
      {argName="gameId",argType="gameId"},--tex gameId of agent on route VERIFY because SendEvent param3 is a str32 game object name.
      {argName="routeId",argType="str32"},--tex TODO gather route names
      {argName="param",argType="str32"},
      {argName="messageId",argType="str32"},
    },
    SaluteRaiseMorale={
      {argName="saluter",argType="gameId"},
    },
    SpecialActionEnd={--tex after some SpecialAction anim has ended
      {argName="gameId",argType="gameId"},
      {argName="actionId",argType="str32"},
      {argName="commandId",argType="str32"},
    },
    StartedCombat={--enemy heli, skulls
      {argName="unk0",argType="gameId"},--tex assuming gameId from the look of it, but it wasn't picking up enemy heli, is it attacker or attacked?
    },
    StartedMoveToLandingZone={--SupportHeli
      {argName="gameId",argType="gameId"},
      {argName="landingZone",argType="str32"},--str32
    },
    StartedPullingOut={--SupportHeli
      {argName="gameId",argType="gameId"},
    },
    SwitchGimmick={
      {argName="gameId",argType="gameId"},
      {argName="locatorName",argType="str32"},
      {argName="dataSetName",argType="dataSetPath32"},
      {argName="switchFlag",argType="number"},--tex 0,1,255 state of switch. 0 seems to be off, 1 is on? 255 is 'broken' (used to trigger buzz sound on mfinda oilfield switch)
    },
    Unconscious={
      {argName="gameId",argType="gameId"},
      {argName="attackerId",argType="gameId"},
      {argName="phase",argType="phase"},
    },
    Unlocked={
      {argName="hostageId",argType="gameId"},
    },
    VehicleAction={
      {argName="rideMemberId",argType="gameId"},
      {argName="vehicleId",argType="gameId"},
      {argName="vehicleActionType",argType="vehicleActionType"},
    },
    VehicleDisappeared={
      {argName="gameId",argType="gameId"},--vehicle gameid
    --{argName="unk1",argType="str32"}, --tex UNKNOWN s10052 == "CanNotMove", otherwise doesn't seem to be set in most calls TODO test that mission to see if it actually does
    },
    WarningGimmick={--tex on ir sensor trigger
      {argName="irSensorId",argType="gimmickId"},--TODO can't seem to get any hits for str32 or TppGimmick.GetGameObjectId > gameObjectId name
      {argName="irHash",argType="str32"},--tex from ly<layout>.lua .itemTable.irsensors
      {argName="irDataSet",argType="dataSetPath32"},
      {argName="triggerer",argType="gameId"},--tex who tripped sensor
    },
  },
  Marker={
    ChangeToEnable={
      {argName="instanceName",argType="str32"},
      {argName="markerType",argType="str32"},--tex fox2 TppMarker2LocatorParameter markerType {"TYPE_COMMON","TYPE_FIRE","TYPE_INTELLI_FILE","TYPE_MB_SPOT","TYPE_MISSION_KEY_PLACE",}, or "TYPE_ENEMY" or ??
      {argName="gameId",argType="gameId"},
      {argName="markedBy",argType="str32"},--tex alias: identificationCode --what set the marker, "Player" or ? buddy or ??, TODO arg not present some times?
    },
  },
  MotherBaseStage={
    MotherBaseCurrentClusterLoadStart={
      {argName="clusterId",argType="number"},--TODO clusterid to name, but would still want to present the number
    },
    MotherBaseCurrentClusterActivated={
      {argName="clusterId",argType="number"},--TODO clusterid to name, but would still want to present the number
    },
    MotherBaseCurrentClusterDeactivated={
      {argName="clusterId",argType="number"},--TODO clusterid to name, but would still want to present the number
    },
  },
  Placed={
    OnActivatePlaced={
      {argName="equipId",argType="equipId"},
      {argName="index",argType="number"},
    },
  },
  Player={
    CalcFultonPercent={--tex TODO: only first two arg appear? test to see if gimmick args do actually show when next to container or some other gimmick
      {argName="playerIndex",argType="gameId"},--tex assumed
      {argName="gameId",argType="gameId"},
    --          {argName="gimmickInstanceOrAnimalId",argType="number"},
    --          {argName="gimmickDataSet",argType="number"},--TODO:
    --          {argName="stafforResourceId",argType="number"},--TODO:
    },
    CalcDogFultonPercent={
      {argName="playerIndex",argType="gameId"},--tex assumed
      {argName="gameId",argType="gameId"},
    --          {argName="gimmickInstanceOrAnimalId",argType="number"},
    --          {argName="gimmickDataSet",argType="number"},--TODO:
    --          {argName="stafforResourceId",argType="number"},--TODO:
    },
    CBoxSlideEnd={
      {argName="gameId",argType="gameId"},--tex player instance I guess
      {argName="distance",argType="number"},--tex distance of slide
    },
    Dead={
      {argName="playerId",argType="gameId"},
      {argName="deathType",argType="str32"},
    },
    DirectMotion={--tex after Player.RequestToPlayDirectMotion is called
      {argName="animName",argType="str32"},
      {argName="animStage",argType="str32"},
      {argName="arg2",argType="number"},--tex UNKNOWN
    },
    Enter={--tex mission zones
      {argName="zoneType",argType="str32"},--tex outerZone,innerZone,hotZone
    },
    IconFultonShown={
      {argName="gameId",argType="gameId"},--tex player instance I guess
      {argName="targetObjectId",argType="gameId"},
      {argName="isContainer",argType="number"},--boolAsNumber
      {argName="isNuclear",argType="number"},--boolAsNumber
    },
    IconSwitchShown={
      {argName="gameId",argType="gameId"},--tex player instance I guess
      {argName="gimmickId",argType="gimmickId"},
      {argName="locatorNameS32",argType="str32"},
      {argName="dataSetPath32",argType="dataSetPath32"},
    },
    OnAmmoLessInMagazine={
      {argName="unk0",argType="number"},--TODO
      {argName="unk1",argType="number"},--TODO
      {argName="equipId",argType="equipId"},--VERIFY
    },
    OnEquipHudClosed={
      {argName="playerIndex",argType="number"},--tex TODO VERIFY
      {argName="equipId",argType="equipId"},
      {argName="equipType",argType="equipType"},
    },
    OnEquipItem={
      {argName="playerIndex",argType="number"},
      {argName="equipId",argType="equipId"},
    },
    OnEquipWeapon={
      {argName="playerIndex",argType="number"},
      {argName="equipId",argType="equipId"},
      {argName="slot",argType="number"},--tex TODO VERIFY, build lookup
    },
    OnPickUpCollection={
      {argName="playerId",argType="number"},
      {argName="resourceId",argType="number"},--tex TODO
      {argName="resourceType",argType="resourceType"},
      {argName="langId",argType="str32"},
    },
    OnPickUpPlaced={
      {argName="playerIndex",argType="number"},
      {argName="equipId",argType="equipId"},
      {argName="itemIndex",argType="number"},--TODO
      {argName="isPlayers",argType="number"},--boolAsNumber
    },
    OnPickUpWeapon={
      {argName="playerIndex",argType="number"},
      {argName="equipId",argType="equipId"},
      {argName="pickupNumber",argType="number"},--blueprint number or casset number or ? VERIFY doesnt seem to directly match countRaw on the TppPickableLocatorParameter as arg3 was returning 60 for a rawcount 1
    },
    OnVehicleRide_Start={
      {argName="playerId",argType="number"},
      {argName="rideFlag",argType="number"},--0== get on, 1 == get off ?
      {argName="vehicleId",argType="gameId"},
    },
    PlayerDamaged={
      {argName="playerIndex",argType="number"},
      {argName="attackId",argType="attackId"},
      {argName="attackerId",argType="gameId"},
    },
    PlayerFulton={
      {argName="playerIndex",argType="number"},
      {argName="targetId",argType="gameId"},
    },
    PlayerHoldWeapon={
      {argName="equipId",argType="equipId"},
      {argName="equipType",argType="equipType"},
      {argName="hasGunLight",argType="number"},--tex TODO: boolAsNumber?
      {argName="isSheild",argType="number"},
    },
    PlayerSwitchStart={
      {argName="playerId",argType="gameId"},
      {argName="switchId",argType="gameId"},
    },
    PressedFultonIcon={
      {argName="playerIndex",argType="number"},
      {argName="targetId",argType="gameId"},
      {argName="unk2",argType="number"},--TODO
      {argName="unk3",argType="number"},--TODO
    },
    PutMarkerWithBinocle={
      {argName="x",argType="number"},
      {argName="y",argType="number"},
      {argName="z",argType="number"},
    },
    SetMarkerBySearch={--tex object was marked by looking at it
      {argName="typeIndex",argType="typeIndex"},
    },
  },
  Radio={
    EspionageRadioCandidate={--tex seems to be when you look at something that has a radio/call message
      {argName="gameId",argType="gameId"},
      {argName="unk1",argType="number"},--tex UNKNOWN TODO label argType unknown to run through the same multi lookup as no signature
    },
    Start={
      {argName="radioGroupName32",argType="str32"},--radioGroupName
      {argName="unk1",argType="number"},--tex UNKNOWN
    },
    Finish={
      {argName="radioGroupName32",argType="str32"},--radioGroupName
      {argName="unk1",argType="number"},--tex UNKNOWN
    },
  },
  Sound={
    ChangeBgmPhase={
      {argName="bgmPhase",argType="bgmPhase"},
    },
  },
  Subtitles={
    SubtitlesStartEventMessage={--tex no use cases, but looks the same as SubtitlesEndEventMessage
      {argName="speechLabel",argType="subtitleId"},
      {argName="status",argType="number"},--tex TODO
    },
    SubtitlesEndEventMessage={
      {argName="speechLabel",argType="subtitleId"},--TODO argType="subtitleId"-- TEST
      {argName="status",argType="number"},--tex TODO
    },
  },
  Terminal={
    MbDvcActFocusMapIcon={
      {argName="focusedGameId",argType="gameId"},
    },
    MbDvcActHeliLandStartPos={
      {argName="set",argType="number"},--boolAsNumber
      {argName="x",argType="number"},
      {argName="y",argType="number"},
      {argName="z",argType="number"},
    },
    MbDvcActSelectLandPoint={
      {argName="nextMissionId",argType="number"},
      {argName="routeName",argType="str32"},--landingZone??
      {argName="layoutCode",argType="number"},
      {argName="clusterId",argType="number"},
    },
  },
  Timer={
    Start={
      {argName="timerName",argType="str32"},
    },
    Finish={
      {argName="timerName",argType="str32"},
    },
  },
  Trap={
    Enter={
      {argName="trapName",argType="str32"},--tex msg usually filtered by sender anyway, so only useful if passing trap name through to another function
      {argName="gameId",argType="gameId"},
    },
    Exit={
      {argName="trapName",argType="str32"},--tex msg usually filtered by sender anyway, so only useful if passing trap name through to another function
      {argName="gameId",argType="gameId"},
    },
  },
  UI={
    EndFadeOut={
      {argName="fadeInName",argType="str32"},
      {argName="unk1",argType="number"},--tex UNKNOWN
    },
    EndFadeIn={
      {argName="fadeInName",argType="str32"},
      {argName="unk1",argType="number"},--tex UNKNOWN
    },
    PopupClose={
      {argName="popupId",argType="popupId"},
      {argName="unk1",argType="number"},--tex UNKNOWN, haven't seen any value but 0 yet
    },
    QuestAreaAnnounceLog={
      {argName="questId",argType="number"},--tex TODO questId to name lookup
    },
    QuestAreaAnnounceText={
      {argName="questId",argType="number"},--tex TODO questId to name lookup
    },
    TitleMenu={
      {argName="action",argType="str32"},
    },
  },
  Weather={
    ChangeWeather={
      {argName="weatherType",argType="weatherType"},
    },
    Clock={
      {argName="sender",argType="str32"},
      {argName="time",argType="time"},
    },
    WeatherForecast={
      {argName="weatherType",argType="weatherType"},
    },
  },
}

--
function this.PrintOnMessage(sender,messageId,arg0,arg1,arg2,arg3)
  --InfCore.PCall(function(sender,messageId,arg0,arg1,arg2,arg3)--DEBUG

  local senderStr=this.StrCode32ToString(sender,true) or sender
  local messageIdStr=this.StrCode32ToString(messageId,true) or messageId

  if type(senderStr)=="number" then
    --InfCore.Log("InfLookup.PrintOnMessage: Unknown sender: "..senderStr)
    InfCore.unknownMessages[senderStr]=InfCore.unknownMessages[senderStr] or {}
    InfCore.unknownMessages[senderStr][messageIdStr]=true
  end
  if type(messageIdStr)=="number" then
    --InfCore.Log("InfLookup.PrintOnMessage: Unknown messageId: "..messageIdStr)
    InfCore.unknownMessages[senderStr]=InfCore.unknownMessages[senderStr] or {}
    InfCore.unknownMessages[senderStr][messageIdStr]=true
  end

  local args={arg0,arg1,arg2,arg3}

  local senderSignatures=this.messageSignatures[senderStr]
  if senderSignatures then
    local signature=senderSignatures[messageIdStr]
    if signature then
      this.PrintMessageSignature(senderStr,messageIdStr,args,signature)
      return
    end
  end

  this.PrintMessage(senderStr,messageIdStr,args)
  --end,sender,messageId,arg0,arg1,arg2,arg3)--DEBUG
end

--tex print message and just attempt to throw a bunch of lookups at the args
--most times they won't be right, but when it does can let you figure out what the arg is
function this.PrintMessage(senderStr,messageIdStr,args)
  local lookupTypes={
    "str32",
    "gameId",
    "typeIndex",
    "attackId",
    "damageSource",
    "equipId",
    "equipType",
  --"time",
  }

  local hasArgs=false
  local argsString=""
  for i,arg in ipairs(args)do
    local argNum=i-1
    local argPreStr="arg"..argNum.."="
    local argValue=""
    if arg~=nil then
      hasArgs=true

      if type(arg)=="number" then
        local lookupReturns={}--tex possible number/id collisions, so return all
        lookupReturns[#lookupReturns+1]=arg
        --tex KLUDGE too many collisions on low numbers, pretty arbitrary cut-off point though.
        if arg>10 then
          for i,lookupType in ipairs(lookupTypes)do
            local lookup=this.lookups[lookupType]
            local lookupReturn=this.Lookup(lookupType,arg)
            if lookupReturn then
              lookupReturns[#lookupReturns+1]=lookupType..":"..lookupReturn
            end
          end
        end
        local addSeperator=#lookupReturns>1
        for i,lookupReturn in ipairs(lookupReturns) do
          if addSeperator and i>1 then
            argValue=argValue.."||"
          end
          argValue=argValue..lookupReturn
        end
      else
        argValue=type(arg)..":"..tostring(arg)
      end

      argsString=argsString..argPreStr..argValue..", "
    end
  end

  local messageInfoString="OnMessage|sender: "..senderStr..", messageId: "..messageIdStr
  if hasArgs then
    messageInfoString=messageInfoString..", (no signature): "..argsString
  else
  end
  InfCore.Log(messageInfoString)
end

--tex TODO: if arg is type str32 and it returns as unknown note it.
function this.PrintMessageSignature(senderStr,messageIdStr,args,signature)
  --ASSUMPTION: if message has any args they are contiguous (none nil)
  if #signature<#args then
    InfCore.Log("WARNING: InfLookup.PrintMessageSignature: incomplete signature? #signature<#args")
  end

  local hasArgs=false
  local argsString=""
  for i,arg in ipairs(args)do
    local argNum=i-1
    local argDef=signature[i]
    if arg~=nil then
      hasArgs=true

      if argDef then
        local lookupValue=this.Lookup(argDef.argType,arg)
        local argTypeSuff=""
        if argDef.argName~=argDef.argType or lookupValue==nil then--tex KLUDGE
          argTypeSuff=" ("..argDef.argType..")"
        end
        if lookupValue then
          lookupValue=arg..":"..lookupValue
        else
          lookupValue=tostring(arg)
        end
        argsString=argsString..argDef.argName.."="..lookupValue..argTypeSuff..", "
      else
        InfCore.Log("WARNING: InfLookup.PrintMessageSignature: incomplete signature? no var found for arg"..tostring(argNum)..":"..tostring(arg))
        --tex TODO: fall back to normal try-all-lookups
        argsString=argsString.."arg"..argNum.."="..tostring(arg)..", "
      end
    else
      if argDef then
        InfCore.Log("WARNING: InfLookup.PrintMessageSignature: arg"..tostring(argNum).." is nil but has signature arg defined")
      end
    end
  end

  local messageInfoString="OnMessage|sender: "..senderStr..", messageId: "..messageIdStr
  if hasArgs then
    messageInfoString=messageInfoString..", "..argsString
  end
  InfCore.Log(messageInfoString)
end

function this.OnShowAnnounceLog(announceId,param1,param2)
  if Ivars.debugMessages:Is(1) then
    local langId=TppUI.ANNOUNCE_LOG_TYPE[announceId]
    InfCore.Log("InfLookup.OnShowAnnounceLog: langId="..tostring(langId)..", param1="..tostring(param2)..", param2="..tostring(param2))
    --InfCore.StrCode32(langId) --tex would allready be in there from InfStrCode lua scrape
  end
end

function this.AddObjectNamesToStr32List()
  if InfCore.debugMode then
    InfCore.Log"InfLookup.AddObjectNamesToStr32List:"
    for listName,list in pairs(this.objectNameLists) do
      if type(list[1])=="table" then
        for i,objectName in ipairs(list[1]) do
          InfCore.StrCode32(objectName)
        end
      else
        for i,objectName in ipairs(list) do
          InfCore.StrCode32(objectName)
        end
      end
    end
  end
end

--IN/SIDE: this.dictionaries
function this.BuildDictionaryLookup(name,lookupTable)
  InfUtil.ClearTable(lookupTable)

  local dictionaryPath=InfCore.modPath..[[\strings\]]..this.dictionaries[name].fileName
  local lines=InfCore.GetLines(dictionaryPath)
  if lines==nil then
    InfCore.Log("WARNING: InfLookup.BuildDictionaryLookup: could not load "..this.dictionaries[name].fileName)
    return
  end
  local HashFunction=this.dictionaries[name].HashFunction
  for i,str in ipairs(lines) do
    local hash=HashFunction(str)--tex is just StrCode32, but whatevs
    if (lookupTable[hash]) then
      InfCore.Log("WARNING: InfLookup.BuildDictionaryLookup("..name.."): collision for hash:"..hash.." between "..str.." and "..lookupTable[hash])
    end
    lookupTable[hash]=str
  end
end
--CALLER: PostAllModulesLoad
function this.LoadGameObjectNames()
  InfCore.LogFlow("InfLookup.LoadGameObjectNames")

  local dictionaryPath=InfCore.modPath..[[\strings\]].."IHStringsGameObjectNames.txt"
  local lines=InfCore.GetLines(dictionaryPath)
  if lines==nil then
    InfCore.Log("LoadGameObjectNames: could not load IHStringsGameObjectNames.txt")
  else
    InfCore.Log("LoadGameObjectNames: Adding IHStringsGameObjectNames to gameObjectNames")
    for i,gameObjectName in ipairs(lines)do
      this.gameObjectNames[gameObjectName]=true
    end
  end
end
--CALLER: InfMain.OnIntializeTop, since it needs gameobjects to have been loaded
--Actual names (re)loaded in PostAllModulesLoad
function this.BuildGameIdToNames()
  InfUtil.ClearTable(InfCore.gameIdToName)--tex clear since different gameIds/mapped differently each level
  for listName,list in pairs(this.objectNameLists) do
    local objectName
    --tex {{nameList},"objectType"}
    if type(list[1])=="table" then
      list=list[1]
    end
    for i,gameObjectName in ipairs(list)do
      InfCore.GetGameObjectId(gameObjectName)--tex
    end
  end

  InfCore.Log("BuildGameIdToNames: Adding gameObjectName to InfCore.gameIdToName")
  for gameObjectName,bool in pairs(this.gameObjectNames)do
    InfCore.GetGameObjectId(gameObjectName)--tex adds to InfCore.gameIdToName
  end
  if this.debugModule then
    InfCore.PrintInspect(InfCore.gameIdToName,"InfCore.gameIdToName")
  end
end

function this.BuildSoldierSvarIndexes()
  InfCore.LogFlow("InfLookup.BuildSoldierSvarIndexes:")
  InfUtil.ClearTable(this.soldierSvarIndexes)
  local soldierNames={}

  local soldierNames={}
  if mvars.ene_soldierIDList then
    for cpId,soldierIds in pairs(mvars.ene_soldierIDList)do
      for soldierId,soldierName in pairs(soldierIds)do
        soldierNames[Fox.StrCode32(soldierName)]=soldierName
      end
    end
  end

  local fmt="sol_quest_%04d"
  local num=8
  for i=0,num-1 do
    local soldierName=string.format(fmt,i)
    soldierNames[Fox.StrCode32(soldierName)]=soldierName
  end

  --TODO: + reserve?

  --InfCore.PrintInspect(soldierNames,"soldierNames")--DEBUG

  for i=0,mvars.ene_maxSoldierStateCount-1 do
    local soldierNameStr32=svars.solName[i]
    if soldierNameStr32>0 then
      this.soldierSvarIndexes[soldierNameStr32]=i
    end
  end
  if this.debugModule then
    InfCore.PrintInspect(this.soldierSvarIndexes,"soldierSaveIndexes")
  end
end

function this.DumpValidStrCode()
  local ins=InfInspect.Inspect(InfCore.str32ToString)
  InfCore.Log(ins)--TODO dump to seperate file
end

--EXEC
if this.debugModule then
  InfCore.PrintInspect(this.lookups,{varName="InfLookups.lookups"})
end

return this
