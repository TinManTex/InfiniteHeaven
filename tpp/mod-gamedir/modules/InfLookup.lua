-- InfLookup.lua
-- tex various script analysis, lookup-tables, printing functions
-- still some other stuff scttered around:
-- InfMenu.CpNameString

local this={}

--LOCAOPT
local InfCore=InfCore
local TppGameObject=TppGameObject
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local NULL_ID=GameObject.NULL_ID

this.debugModule=false

this.DEBUG_strCode32List={}

function this.PostModuleReload(prevModule)
end

function this.PostAllModulesLoad()
  InfCore.PCallDebug(this.AddObjectNamesToStr32List)
end

function this.Init(missionTable)
  if Ivars.debugMode:Is(1) then
    InfCore.Log"Dumping unknownStr32"
    local unknownStr32={InfInspect.Inspect(InfCore.unknownStr32)}
    InfCore.WriteStringTable(InfCore.paths.mod.."ih_unknownStr32.txt",unknownStr32)

    InfCore.Log"Dumping unknownMessages"
    local unknownMessages={InfInspect.Inspect(InfCore.unknownMessages)}
    InfCore.WriteStringTable(InfCore.paths.mod.."ih_unknownMessages.txt",unknownMessages)
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

--TABLESETUP
this.objectNameLists={
  veh_lv=this.GenerateNameList("veh_lv_%04d",20),--jeeps
  veh_trc=this.GenerateNameList("veh_trc_%04d",10),--trucks
  anml_quest=this.GenerateNameList("anml_quest_%02d",10),
  sol_quest=this.GenerateNameList("sol_quest_%04d",10),
  ih_hostage=this.GenerateNameList("ih_hostage_%04d",10),
  itm_Mine_quest=this.GenerateNameList("itm_Mine_quest_%04d",10),
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
--

function this.Time(time)
  return tostring(time).."||"..TppClock.FormalizeTime(time,"string")
end

--tex gives {[gameClass.Enum]=enum name}
function this.BuildGameClassEnumNameLookup(gameClass,enumNames)
  local enumNameLookup={}
  for i,name in ipairs(enumNames) do
    local enum=gameClass[name]
    if enum then
      if enumNameLookup[enum] then
        if this.debugModule then
          InfCore.Log("InfLookup.BuildGameClassEnumNameLookup WARNING: "..name.." with enum "..enum.." is same as ".. enumNameLookup[enum])--DEBUG
        end
        enumNameLookup[enum]=enumNameLookup[enum].."||"..name
      else
        enumNameLookup[enum]=name
      end
    else
      InfCore.Log("InfLookup.BuildGameClassEnumNameLookup: WARNING could not find enum "..tostring(name))
    end
  end
  return enumNameLookup
end


function this.GetObjectNameLists()
  local nameLists={
    {TppReinforceBlock.REINFORCE_SOLDIER_NAMES,"TppSoldier2"},
    {"hos_pilot_0000"},
    {"reinforce_soldier_driver"},
    InfNPCHeli.heliNames.UTH,
    InfNPCHeli.heliNames.HP48,
    InfWalkerGear.walkerNames,
    InfAnimal.birdNames,
    InfMain.reserveSoldierNames,
  }

  for listName,list in pairs(this.objectNameLists) do
    table.insert(nameLists,list)
  end

  return nameLists
end


function this.GetObjectList()
  --return InfMain.reserveSoldierNames
  --        local travelPlan="travelArea2_01"
  --         return InfVehicle.inf_patrolVehicleConvoyInfo[travelPlan]

  --return InfParasite.parasiteNames[InfParasite.parasiteType]
  --return InfLookup.truckNames
  --return InfLookup.jeepNames
  --return {TppReinforceBlock.REINFORCE_DRIVER_SOLDIER_NAME}
  --return TppReinforceBlock.REINFORCE_SOLDIER_NAMES
  --return InfInterrogation.interCpQuestSoldiers
  --return InfWalkerGear.walkerNames
  --return InfNPCHeli.heliList
  --return TppEnemy.armorSoldiers
  --return InfAnimal.birdNames
  -- return objectNameLists[4]
  --return InfNPC.ene_wildCardNames
  --return InfHostage.hostageNames
  --return this.objectNameLists.sol_quest
  --return {"hos_quest_0000"}
  return InfWalkerGear.walkerNames
end

function this.GetObjectInfoOrPos(index)
  local objectList=this.GetObjectList()

  if objectList==nil then
    return nil,"objectList nil"
  end

  if #objectList==0 then
    return nil,"objectList empty"
  end

  local objectName=objectList[index]
  if objectName==nil then
    return nil,"objectName==nil for index "..index,nil
  end
  local gameId=objectName
  if type(objectName)=="string" then
    gameId=GetGameObjectId(objectName)
  end
  if gameId==nil then
    return objectName,objectName.." nil"
  end
  if gameId==NULL_ID then
    return objectName,objectName.." NULL_ID"
  end

  local position=GameObject.SendCommand(gameId,{id="GetPosition"})
  if position==nil then
    return objectName,objectName.." nil for GetPosition"
  end

  position={position:GetX(),position:GetY(),position:GetZ()}

  return objectName,"",position
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
function this.ObjectNameForGameId(findId)
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

  local objectNameLists=this.GetObjectNameLists()
  for i,list in ipairs(objectNameLists)do
    local objectName
    if type(list[1])=="table" then
      objectName=this.ObjectNameForGameIdList(findId,list[1],list[2])
    else
      objectName=this.ObjectNameForGameIdList(findId,list)
    end
    if objectName then
      return objectName
    end
  end

  local enemyHeli="EnemyHeli"
  local gameId=GetGameObjectId(enemyHeli)
  if gameId~=NULL_ID then
    if gameId==findId then
      return enemyHeli
    end
  end

  return nil
end

function this.CpNameForCpId(cpId)
  local cpName
  if mvars.ene_cpList then
    cpName=mvars.ene_cpList[cpId]
  end
  if cpName==nil then
    InfCore.Log("InfLookup.CpNameForCpId: WARNING: could not find cpName in mvars.ene_cpList")
    this.ObjectNameForGameId(cpId)
  end
  return cpName
end

--tex assumes gameclass has lua readable enum names like TppDamage, and not whatever index fancyness gameclasses like ScritBlock do
function this.BuildDirectGameClassEnumLookup(gameClass,filter)
  --tex WORKAROUND autodoc/mock
  if gameClass==nil then
    return {}
  end

  local enumToName={}
  for k,v in pairs(gameClass)do
    if type(v)=="number" then
      if string.find(k,filter)~=nil then
        if enumToName[v] then
          if this.debugModule then
            InfCore.Log("InfLookup.BuildDirectGameClassEnumLookup WARNING: "..k.." with enum "..v.." is same as ".. enumToName[v])--DEBUG
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

--TABLESETUP
function this.BuildTppEquipLookup()
  local enumToName={}
  for k,v in pairs(TppEquip)do
    if type(v)=="number" then
      if string.find(k,"EQP_")~=nil and string.find(k,"EQP_TYPE_")==nil and string.find(k,"EQP_BLOCK_")==nil then
        if enumToName[v] then
          if this.debugModule then
            InfCore.Log("InfLookup.BuildTppEquipLookup WARNING: "..k.." with enum "..v.." is same as ".. enumToName[v])
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


--tex returns string or nil
--isStrCode on guaranteed strcodes to add that code to unknowns (this function is also used in a blanket fashion in PrintOnMessage with potential non-strcodes)
function this.StrCode32ToString(strCode,isStrCode)
  if type(strCode)=="number" then
    --tex using InfCore since this is built up using Fox.StrCode32 replacement InfCore.StrCode32, since InfCore is loaded before lib modules
    local returnString=InfCore.str32ToString[strCode]
    if returnString==nil then
      returnString=TppDbgStr32.DEBUG_StrCode32ToString(strCode)
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
      InfCore.Log("InfLookup.StrCode32ToString: WARNING: returnString for strCode:"..strCode.." is a number: "..returnString)
    end

    return returnString
  else
    InfCore.Log("InfLookup.StrCode32ToString: WARNING: strCode:"..tostring(strCode).." is not a number.")
    return strCode
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

  InfCore.Log("InfCore.unknownStr32")
  InfCore.PrintInspect(InfCore.unknownStr32)
end


--game class lookups
this.HeadshotMessageFlag={
  headshotMessageFlag=this.BuildGameClassEnumNameLookup(HeadshotMessageFlag,
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
  neutralizeCause=this.BuildGameClassEnumNameLookup(NeutralizeCause,
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
  neutralizeFobCause=this.BuildGameClassEnumNameLookup(NeutralizeFobCause,
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
  neutralizeType=this.BuildGameClassEnumNameLookup(NeutralizeType,
    {"INVALID","FAINT","SLEEP","DYING","HOLDUP","FULTON"}
  ),
}

this.ScriptBlock={
  scriptBlockState=this.BuildGameClassEnumNameLookup(ScriptBlock,
    {
      "SCRIPT_BLOCK_STATE_EMPTY",
      "SCRIPT_BLOCK_STATE_PROCESSING",
      "SCRIPT_BLOCK_STATE_INACTIVE",
      "SCRIPT_BLOCK_STATE_ACTIVE",
    }
  ),
  scriptBlockStateTransition=this.BuildGameClassEnumNameLookup(ScriptBlock,
    {
      "TRANSITION_LOADED",
      "TRANSITION_ACTIVATED",
      "TRANSITION_DEACTIVATED",
      "TRANSITION_EMPTIED",
    }
  ),
}

this.StageBlock={
  stageBlockState=this.BuildGameClassEnumNameLookup(StageBlock,
    {
      "INACTIVE",
      "ACTIVE",
    }
  ),
}

this.TppCollection={
  resourceType=this.BuildDirectGameClassEnumLookup(TppCollection,"TYPE_"),
}

this.TppDamage={
  attackId=this.BuildDirectGameClassEnumLookup(TppDamage,"ATK_"),
  damageSource=this.BuildDirectGameClassEnumLookup(TppDamage,"DAM_SOURCE_"),
  injuryType=this.BuildDirectGameClassEnumLookup(TppDamage,"INJ_TYPE_"),
}

this.TppEquip={
  equipId=this.BuildTppEquipLookup(),
  equipType=this.BuildDirectGameClassEnumLookup(TppEquip,"EQP_TYPE_"),
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
  --  typeIndex=this.BuildDirectGameClassEnumLookup(TppGameObject,"GAME_OBJECT_TYPE_"),
  --  routeEventFailedType=this.BuildDirectGameClassEnumLookup(TppGameObject,"ROUTE_EVENT_FAILED_TYPE_"),

  phase=this.BuildGameClassEnumNameLookup(TppGameObject,
    {
      "PHASE_SNEAK",
      "PHASE_CAUTION",
      "PHASE_EVASION",
      "PHASE_ALERT",
    }
  ),
  routeEventFailedType=this.BuildGameClassEnumNameLookup(TppGameObject,
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
  vehicleActionType=this.BuildGameClassEnumNameLookup(TppGameObject,
    {
      "VEHICLE_ACTION_TYPE_GOT_IN_VEHICLE",
      "VEHICLE_ACTION_TYPE_GOT_OUT_VEHICLE",
      "VEHICLE_ACTION_TYPE_FELL_OFF_VEHICLE",
    }
  ),

  typeIndex=this.BuildGameClassEnumNameLookup(TppGameObject,gameObjectTypes),
}

this.TppSystem={
  bgmPhase=this.BuildDirectGameClassEnumLookup(TppSystem,"BGM_PHASE_"),
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

--tex simplified lookup name to lookup table or function
this.lookups={
  str32=this.StrCode32ToString,
  gameId=this.ObjectNameForGameId,
  cpId=this.CpNameForCpId,
  time=this.Time,
  weatherType=this.weatherTypeNames,
}
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
      InfCore.Log("InfLookup.Lookup: WARNING no lookup of type "..lookupType)
    end
  end
  return lookedupValue
end

-- {
--  TYPE={
--    MSG={
--      [arg(n+1)]={argName=<arg name>,argType=<lookupType>},
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
    StageBlockCurrentSmallBlockIndexUpdated={
      {argName="blockIndexX",argType="number"},
      {argName="blockIndexY",argType="number"},
      {argName="clusterIndex",argType="number"},
    },
  },
  GameObject={
    ChangePhase={
      {argName="cpId",argType="cpId"},
      {argName="phase",argType="phase"},
      {argName="priorPhase",argType="phase"},
    },
    Damage={--On Damage
      {argName="damagedId",argType="gameId"},--object that took damage
      {argName="attackId",argType="attackId"},
      {argName="attackerId",argType="gameId"},
      {argName="unk3",argType="number"},--tex UNKOWN: no use cases I can see
    },
    --    Fulton={
    --      {argName="gameId",argType="gameId"},
    --      {argName="gimmickInstanceOrAnimalId",argType="number"},
    --      {argName="gimmickDataSet",argType="number"},--TODO: 
    --      {argName="stafforResourceId",argType="number"},--TODO:
    --    },
    FultonInfo={
      {argName="gameId",argType="gameId"},
      {argName="fultonedPlayerIndex",argType="number"},
      {argName="reduceThisContainer",argType="number"},--boolAsNumber
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
    RadioEnd={
      {argName="gameId",argType="gameId"},
      {argName="cpId",argType="cpId"},
      {argName="speechLabel",argType="str32"},
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
    SpecialActionEnd={--tex after some SpecialAction anim has ended
      {argName="gameId",argType="gameId"},
      {argName="actionId",argType="str32"},
      {argName="commandId",argType="str32"},
    },
    SwitchGimmick={
      {argName="gameId",argType="gameId"},
      {argName="locatorName",argType="str32"},--tex TODO: gameIdName?
      {argName="dataSetName",argType="str32"},
      {argName="switchFlag",argType="number"},--tex 0,1,255 state of switch. 0 seems to be off, 1 is on? 255 is 'broken' (used to trigger buzz sound on mfinda oilfield switch)
    },
    Unconscious={
      {argName="gameId",argType="gameId"},
      {argName="attackerId",argType="gameId"},
      {argName="phase",argType="phase"},
    },
    VehicleAction={
      {argName="rideMemberId",argType="gameId"},
      {argName="vehicleId",argType="gameId"},
      {argName="vehicleActionType",argType="vehicleActionType"},
    },
    VehicleDisappeared={
      {argName="gameId",argType="gameId"},--vehicle gameid
    --{argName="unk1",argType="str32"}, --tex UNKOWN s10052 == "CanNotMove", otherwise doesn't seem to be set in most calls TODO test that mission to see if it actually does
    },
  },
  Marker={
    ChangeToEnable={
      {argName="instanceName",argType="str32"},
      {argName="markedType",argType="str32"},--tex "TYPE_ENEMY" or ??
      {argName="gameId",argType="gameId"},
      {argName="markedBy",argType="str32"},--tex alias: identificationCode --what set the marker, "Player" or ? buddy or ??
    },
  },
  Player={
    Enter={--tex mission zones
      {argName="zoneType",argType="str32"},--tex outerZone,innerZone,hotZone
    },
    IconFultonShown={
      {argName="gameId",argType="gameId"},--tex player instance I guess
      {argName="targetObjectId",argType="gameId"},
      {argName="isContainer",argType="number"},--boolAsNumber
      {argName="isContainer",argType="number"},--boolAsNumber
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
      {argName="blueprintNumber",argType="number"},--blueprint number, ? VERIFY
    },
    PlayerDamaged={
      {argName="playerIndex",argType="number"},
      {argName="attackId",argType="attackId"},
      {argName="attackerId",argType="gameId"},
    },
    PlayerHoldWeapon={
      {argName="equipId",argType="equipId"},
      {argName="equipType",argType="equipType"},
      {argName="hasGunLight",argType="number"},--tex TODO: boolAsNumber?
      {argName="isSheild",argType="number"},
    },
    SetMarkerBySearch={--tex object was marked by looking at it
      {argName="typeIndex",argType="typeIndex"},
    },
  },
  Radio={
    Start={
      {argName="radioGroupName32",argType="str32"},--radioGroupName
      {argName="unk1",argType="number"},--tex UNKOWN
    },
    Finish={
      {argName="radioGroupName32",argType="str32"},--radioGroupName
      {argName="unk1",argType="number"},--tex UNKOWN
    },
  },
  Sound={
    ChangeBgmPhase={
      {argName="bgmPhase",argType="bgmPhase"},
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
      {argName="unk1",argType="number"},--tex UNKOWN
    },
    EndFadeIn={
      {argName="fadeInName",argType="str32"},
      {argName="unk1",argType="number"},--tex UNKOWN
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
    InfCore.Log("InfLookup.PrintMessageSignature: WARNING: incomplete signature? #signature<#args")
  end

  local hasArgs=false
  local argsString=""
  for i,arg in ipairs(args)do
    local argNum=i-1
    local argDef=signature[i]
    if arg~=nil then
      hasArgs=true

      if argDef then
        local argValue=this.Lookup(argDef.argType,arg) or tostring(arg)
        local argTypeSuff=""
        --if this.debugModule then --tex TODO always give type if the lookup failed?
        if argDef.argName~=argDef.argType or argValue==tostring(arg) then--tex KLUDGE
          argTypeSuff=" ("..argDef.argType..")"
        end
        --end
        argsString=argsString..argDef.argName.."="..argValue..argTypeSuff..", "
      else
        InfCore.Log("InfLookup.PrintMessageSignature: WARNING: incomplete signature? no var found for arg"..tostring(argNum)..":"..tostring(arg))
        --tex TODO: fall back to normal try-all-lookups
        argsString=argsString.."arg"..argNum.."="..tostring(arg)..", "
      end
    else
      if argDef then
        InfCore.Log("InfLookup.PrintMessageSignature: WARNING: arg"..tostring(argNum).." is nil but has signature arg defined")
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
    InfCore.Log"Adding object names to strCode32 list"
    local objectNameLists=this.GetObjectNameLists()
    for i,list in ipairs(objectNameLists)do
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

function this.DumpValidStrCode()
  local ins=InfInspect.Inspect(InfCore.str32ToString)
  InfCore.Log(ins)--TODO dump to seperate file
end

--EXEC
if this.debugModule then
  InfCore.Log"lookups:"
  InfCore.PrintInspect(this.lookups)
end

return this
