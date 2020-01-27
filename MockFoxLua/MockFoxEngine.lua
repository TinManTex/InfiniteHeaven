-- MockFoxEngine.lua
--manually created mock fox engine library modules
--TODO: rename to MockFoxEngineCommon?
--TODO: split off tpp specific into ./tpp/MockFoxEngineGame.lua (see ssd equivalent)

--tex mgstpp uses bitops http://bitop.luajit.org/
--if luaHostType=="LDT" then
--  bit=require"bit"
--else
--tex TODO: for moonSharp redirect to its standard lib which I think has bit32 module
bit={}
bit.bnot=function()end
bit.band=function()end
bit.bor=function()end
bit.bxor=function()end
--
bit.tohex=function()end
--tex This should really be if _VERSION > 5.2 (except _VERSION is a string like "Lua 5.2" and cant be bothered parsing right now
--NOTE haven't really looked to see if theres any implmentation differences
if luaHostType=="MoonSharp" then
  bit.bnot=bit32.bnot
  bit.band=bit32.band
  bit.bor=bit32.bor
  bit.bxor=bit32.bxor
  bit.lshift=bit32.lshift
  bit.rshift=bit32.rshift
  --tex the rest havent been used in TPP as far as I can see>
  bit.arshift=bit32.arshift
  bit.rol=bit32.lrotate
  bit.ror=bit32.rrotate
  --  DEBUGNOW
  --  bit.bswap=
  --  bit.tobit=
  bit.tohex=function(x,n)
    n=n or 8--tex seems to be bitops default, max n, positive number for lowercase
    if (n < -8 or n == 0 or n > 8 ) then
      print("tohex: n out of range")
      return
    end

    local nums=math.abs(n)
    local fmt="%0"..nums.."x"
    local hexString=string.format(fmt,x)
    if n <0 then
      hexString=string.upper(hexString)
    end
    return hexString
  end
end
--end

--userdata
--tex possible return value of some module GetInstance or equivalent functions (see gmpEarnMissions.lua)
--see Entity.lua
--or for fox data functions (see Tpp.lua GetDataWithIdentifier)
--the Entity system use via lua was a lot more prevalent in Ground Zeros
--tostring on real module returns 'NULL ENTITY'
NULL={}
setmetatable(
  NULL,
  {
    __tostring=function(t)
      return "NULL ENTITY"
    end
  }
)

--tex returned by File.GetFileListTable, no references in lua
--only hit in exe strings. 'scriptFile' string hit in exe and Fox2Scrape
ScriptFile={}
--has __tostring - 'ScriptFile <address>' - default userdata return i guess
--has __index
--has __newindex

--tex mock module definitions to fill out stuff missed by Dump
--or to add actual functionality instead of empty functions

--DEBUGNOW CULL
--local mainApplication={}
--mainApplication.AddGame=function(self,game)end
--mainApplication.SetMainGame=function(self,game)end
--
--Application=function(initTable)
--  return mainApplication
--end

--AssetConfiguration={}
--AssetConfiguration.GetDefaultCategory=function()
--  return "eng"
--end
--AssetConfiguration.SetDefaultCategory=function(category,value)
--  print("SetDefaultCategory "..category.." "..value)
--end
--AssetConfiguration.IsDiscOrHddImage=function()
--  return false
--end
--AssetConfiguration.GetConfigurationFromAssetManager=function(configName)
--  local hasConfig={
--    EnableWindowsDX11Texture=true,
--  }
--  return hasConfig[configName] or false
--end
--
--AssetConfiguration.defaultTargetDirectory=""
--AssetConfiguration.SetDefaultTargetDirectory=function(tag)
--  AssetConfiguration.defaultTargetDirectory=tag
--end
--
--AssetConfiguration.targetDirectories={}
--AssetConfiguration.SetTargetDirectory=function(fileType,tag)
--  AssetConfiguration.targetDirectories[fileType]=tag
--end
--
--AssetConfiguration.RegisterExtensionInfo=function(extensionInfo)
--  print(extensionInfo)
--end

--mock
--local mainGame={}
--mainGame.CreateScene=function(self,sceneName)return{}end
--mainGame.CreateBucket=function(self,bucketName,scene)return{}end
--mainGame.SetMainBucket=function(self,bucket)end
--
--DEBUGNOW
--Editor=function(initTable)
--  return mainGame
--end
--EditorBase=Editor
--Game=Editor

local IHGenEntityClassDictionary=require(gameId.."/IHGenEntityClassDictionary")--tex dumped by IHTearDown.DumpEntityClassDictionary
EntityClassDictionary={}
EntityClassDictionary.GetCategoryList=function()
  local categoryList={}
  for category,classes in pairs(IHGenEntityClassDictionary)do
    categoryList[#categoryList+1]=category
  end
  return categoryList
end
EntityClassDictionary.GetClassNameList=function(category)
  return IHGenEntityClassDictionary[category]
end

Fox={}
Fox.actMode="GAME"--NOTREAL
local actModes={
  "GAME",
  "EDIT",
}
Fox.GetActMode=function()
  return Fox.actMode
end
Fox.SetActMode=function(actMode)
  Fox.actMode=actMode
end
Fox.debugLevel=0--NOTREAL
Fox.GetDebugLevel=function()
  return Fox.debugLevel
end

Fox.StrCode32=function(encodeString)
  if HashingGzsTool then--tex MoonSharp userdata that redirects to GzsTool.Core Hashing
    return HashingGzsTool.StrCode32(encodeString)
  else
    return encodeString
  end
end
Fox.PathFileNameCode32=function(encodeString)
  if HashingGzsTool then--tex MoonSharp userdata that redirects to GzsTool.Core Hashing
    return HashingGzsTool.PathFileNameCode32(encodeString)
  else
    return encodeString
  end
end

local platforms={
  "Windows",
  "Xbox360",
  "XboxOne",
  "PS3",
  "PS4",
  "Android",
  "iOS",
}
Fox.GetPlatformName=function()
  return "Windows"
end

foxmath={}
--tex TODO don't know if params match
foxmath.Absf=math.abs
foxmath.Acos=math.acos
foxmath.Asin=math.asin
foxmath.Atan=math.atan
foxmath.Atan2=math.atan--
foxmath.Ceil=math.ceil
--foxmath.Clamp=
foxmath.Cos=math.cos
foxmath.DegreeToRadian=math.rad
foxmath.Exp=math.exp
--foxmath.FRnd=
foxmath.Floor=math.floot
foxmath.Log=math.log
foxmath.Max=math.max
foxmath.Min=math.min
foxmath.Mod=math.modf
--foxmath.NormalizeRadian=
foxmath.PI=3.1415927410126
foxmath.Pow=math.pow
foxmath.RadianToDegree=math.deg
foxmath.Round=math.round
--foxmath.Rsqrt=
--foxmath.Saturate=math.acos
foxmath.Sin=math.sin
foxmath.Sqrt=math.sqrt
foxmath.Tan=math.tan

File={}
--tex NOTES from Inspect
--GetFileListTable()={
-- ["/Assets/tpp/level_asset/chara/enemy/Soldier2FaceAndBodyData.lua"] = ScriptFile (userdata),
--...
--tex seems to be for every file loaded via Script.LoadLibrary ?
--GetReferenceCount()={ [<lua path>]=<reference count (number)>,
File.GetFileListTable=function()
  return Script.fileListTable
end
File.GetReferenceCount=function()
  return Script.referenceCounts
end

GkEventTimerManager={}
GkEventTimerManager.Start=function()end
GkEventTimerManager.Stop=function()end
GkEventTimerManager.IsTimerActive=function()end

PhDaemon={}
PhDaemon.GetInstance=function()--DEBUGNOW KLUDGE
  return PhDaemon
end

Script={}
--NOTREAL mgstpp must something like these somewhere, whether its in script,file or wherever, it's not exposed directly to lua
--tex from File.GetFileListTable, GetReferenceCount
Script.fileListTable={}
Script.referenceCounts={}
--DEBUGNOW
Script.LoadLibrary=function(scriptPath)
  local _G=_G
  local Script=Script
  local split=MockUtil.Split(scriptPath,"/")
  local moduleName=split[#split]
  moduleName=string.sub(moduleName,1,-string.len(".lua")-1)
  print("Script.LoadLibrary:"..scriptPath)

  local function FileExists(filePath)
    local file,openError=io.open(filePath,"r")
    if file and not openError then
      file:close()
      return true
    end
    return false
  end

  if not FileExists(foxLuaPath..scriptPath) then
    print("Script.LoadLibrary could not find "..scriptPath)
    return
  end

  local ret=dofile(scriptPath)

  local module=ret--DEBUGNOWmoduleChunk()
  if not module then
    print("module "..moduleName.."==nil")
  else

    Script.fileListTable[scriptPath]=Script.fileListTable[scriptPath] or {mockUserDataType="ScriptFile"}--TODO: ScriptFile userdata
    Script.referenceCounts[scriptPath]=Script.referenceCounts[scriptPath] or 0
    Script.referenceCounts[scriptPath]=Script.referenceCounts[scriptPath]+1

    module._scriptInstanceId={mockUserDataType="unnamed/scriptInstanceId"}--tex has no metatable
    module._scriptPath=moduleName

    if _G[moduleName] then
      print("Merging "..moduleName.." with existing")
      _G[moduleName]=MockUtil.MergeTable(_G[moduleName],module)--tex merge with mock stubs/overrides --DEBUGNOW
    else
      _G[moduleName]=module
    end

    --tex stop it from complaining if not called from inside coroutine
    --DEBUGNOW
    --    if coroutine.running()~=nil then
    --      coroutine.yield()
    --    end

    if module.requires then
      print("Loading "..moduleName..".requires modules")
      for i,modulePath in ipairs(module.requires)do
        if not Script.fileListTable[modulePath] then--tex guard against module recursion
          Script.LoadLibrary(modulePath)
          coroutine.yield()
        else
          print(modulePath.." is already in fileListTable")
        end
      end
    end
  end
end

Script.LoadLibraryAsync=Script.LoadLibrary
--tex used in conjunction with above
Script.IsLoadingLibrary=function()
  return false
end

Time={}
Time.GetRawElapsedTimeSinceStartUp=function()--TODO IMPLEMENT
  return os.clock()
end

TppColoringSystem={}
function TppColoringSystem.GetAdditionalColoringPackFilePaths(params)
  local missionCode=params.missionCode
  --DEBUGNOW TODO: do a dump for all missionCodes
  return {}
end

TppGameObject={}

--tex in exe order
local gameObjectTypes={
  "GAME_OBJECT_TYPE_PLAYER2",--0
  "GAME_OBJECT_TYPE_COMMAND_POST2",
  "GAME_OBJECT_TYPE_SOLDIER2",
  "GAME_OBJECT_TYPE_HOSTAGE2",
  "GAME_OBJECT_TYPE_HOSTAGE_UNIQUE",
  "GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2",
  "GAME_OBJECT_TYPE_HOSTAGE_KAZ",
  "GAME_OBJECT_TYPE_OCELOT2",
  "GAME_OBJECT_TYPE_HUEY2",
  "GAME_OBJECT_TYPE_CODE_TALKER2",
  "GAME_OBJECT_TYPE_SKULL_FACE2",--10
  "GAME_OBJECT_TYPE_MANTIS2",
  "GAME_OBJECT_TYPE_BIRD2",
  "GAME_OBJECT_TYPE_HORSE2",
  "GAME_OBJECT_TYPE_HELI2",
  "GAME_OBJECT_TYPE_ENEMY_HELI",
  "GAME_OBJECT_TYPE_OTHER_HELI",
  "GAME_OBJECT_TYPE_OTHER_HELI2",
  "GAME_OBJECT_TYPE_BUDDYQUIET2",
  "GAME_OBJECT_TYPE_BUDDYDOG2",
  "GAME_OBJECT_TYPE_BUDDYPUPPY",
  "GAME_OBJECT_TYPE_SAHELAN2",
  "GAME_OBJECT_TYPE_PARASITE2",
  "GAME_OBJECT_TYPE_LIQUID2",
  "GAME_OBJECT_TYPE_VOLGIN2",
  "GAME_OBJECT_TYPE_BOSSQUIET2",
  "GAME_OBJECT_TYPE_UAV",
  "GAME_OBJECT_TYPE_SECURITYCAMERA2",
  "GAME_OBJECT_TYPE_GOAT",
  "GAME_OBJECT_TYPE_NUBIAN",
  "GAME_OBJECT_TYPE_CRITTER_BIRD",
  "GAME_OBJECT_TYPE_STORK",
  "GAME_OBJECT_TYPE_EAGLE",
  "GAME_OBJECT_TYPE_RAT",
  "GAME_OBJECT_TYPE_ZEBRA",
  "GAME_OBJECT_TYPE_WOLF",
  "GAME_OBJECT_TYPE_JACKAL",
  "GAME_OBJECT_TYPE_BEAR",
  "GAME_OBJECT_TYPE_CORPSE",
  "GAME_OBJECT_TYPE_MBQUIET",
  "GAME_OBJECT_TYPE_COMMON_HORSE2",
  "GAME_OBJECT_TYPE_HORSE2_FOR_VR",
  "GAME_OBJECT_TYPE_PLAYER_HORSE2_FOR_VR",
  "GAME_OBJECT_TYPE_VOLGIN2_FOR_VR",
  "GAME_OBJECT_TYPE_WALKERGEAR2",
  "GAME_OBJECT_TYPE_COMMON_WALKERGEAR2",
  "GAME_OBJECT_TYPE_BATTLEGEAR",
  "GAME_OBJECT_TYPE_EXAMPLE",
  "GAME_OBJECT_TYPE_SAMPLE_GAME_OBJECT",
  "GAME_OBJECT_TYPE_NOTICE_OBJECT",
  "GAME_OBJECT_TYPE_VEHICLE",
  "GAME_OBJECT_TYPE_MOTHER_BASE_CONTAINER",
  "GAME_OBJECT_TYPE_EQUIP_SYSTEM",
  "GAME_OBJECT_TYPE_PICKABLE_SYSTEM",
  "GAME_OBJECT_TYPE_COLLECTION_SYSTEM",
  "GAME_OBJECT_TYPE_THROWING_SYSTEM",
  "GAME_OBJECT_TYPE_PLACED_SYSTEM",
  "GAME_OBJECT_TYPE_SHELL_SYSTEM",
  "GAME_OBJECT_TYPE_BULLET_SYSTEM3",
  "GAME_OBJECT_TYPE_CASING_SYSTEM",
  "GAME_OBJECT_TYPE_FULTON",
  "GAME_OBJECT_TYPE_BALLOON_SYSTEM",
  "GAME_OBJECT_TYPE_PARACHUTE_SYSTEM",
  "GAME_OBJECT_TYPE_SUPPLY_CBOX",
  "GAME_OBJECT_TYPE_SUPPORT_ATTACK",
  "GAME_OBJECT_TYPE_RANGE_ATTACK",
  "GAME_OBJECT_TYPE_CBOX",
  "GAME_OBJECT_TYPE_OBSTRUCTION_SYSTEM",
  "GAME_OBJECT_TYPE_DECOY_SYSTEM",
  "GAME_OBJECT_TYPE_CAPTURECAGE_SYSTEM",
  "GAME_OBJECT_TYPE_DUNG_SYSTEM",
  "GAME_OBJECT_TYPE_MARKER2_LOCATOR",
  "GAME_OBJECT_TYPE_ESPIONAGE_RADIO",
  "GAME_OBJECT_TYPE_MGO_ACTOR",
  "GAME_OBJECT_TYPE_FOB_GAME_DAEMON",
  "GAME_OBJECT_TYPE_SYSTEM_RECEIVER",
  "GAME_OBJECT_TYPE_SEARCHLIGHT",
  "GAME_OBJECT_TYPE_FULTONABLE_CONTAINER",
  "GAME_OBJECT_TYPE_GARBAGEBOX",
  "GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE",
  "GAME_OBJECT_TYPE_GATLINGGUN",
  "GAME_OBJECT_TYPE_MORTAR",
  "GAME_OBJECT_TYPE_MACHINEGUN",
  "GAME_OBJECT_TYPE_DOOR",
  "GAME_OBJECT_TYPE_WATCH_TOWER",
  "GAME_OBJECT_TYPE_TOILET",
  "GAME_OBJECT_TYPE_ESPIONAGEBOX",
  "GAME_OBJECT_TYPE_IR_SENSOR",
  "GAME_OBJECT_TYPE_EVENT_ANIMATION",
  "GAME_OBJECT_TYPE_BRIDGE",
  "GAME_OBJECT_TYPE_WATER_TOWER",
  "GAME_OBJECT_TYPE_RADIO_CASSETTE",
  "GAME_OBJECT_TYPE_POI_SYSTEM",
  "GAME_OBJECT_TYPE_SAMPLE_MANAGER",
}
for i=1,#gameObjectTypes do
  TppGameObject[gameObjectTypes[i]]=i-1--DEBUGNOW TODO VERIFY enums
end

--tex hidden from referece scrape by local opt in TppTerminal
TppMotherBaseManagementConst={
  STAFF_UNIQUE_TYPE_ID_OCELOT=249,
  STAFF_UNIQUE_TYPE_ID_MILLER=250,
  STAFF_UNIQUE_TYPE_ID_QUIET=251,--tex is caught by scrape, but put here just to mentally fill the enum
  STAFF_UNIQUE_TYPE_ID_HEUY=252,
  STAFF_UNIQUE_TYPE_ID_CODE_TALKER=253,
}

TppScriptVars={
  TYPE_BOOL=0,
  TYPE_INT32=1,
  TYPE_UINT32=2,
  TYPE_FLOAT=3,
  TYPE_INT8=4,
  TYPE_UINT8=5,
  TYPE_INT16=6,
  TYPE_UINT16=7,

  GROUP_BIT_VARS=1,
  GROUP_BIT_CVARS=2,
  GROUP_BIT_GVARS=4,
  GROUP_BIT_SVARS=8,
  GROUP_BIT_ALL=15,

  CATEGORY_NONE=0,
  CATEGORY_CONFIG=1,
  CATEGORY_MISSION_RESTARTABLE=2,
  CATEGORY_GAME_GLOBAL=4,
  CATEGORY_MISSION=8,
  CATEGORY_RETRY=16,
  CATEGORY_MB_MANAGEMENT=32,
  CATEGORY_QUEST=64,
  CATEGORY_PERSONAL=128,
  CATEGORY_ALL=255,
}

--tex Don't know the actual implementation, but gvars need to be set up at some point due to start.lua kicking things off via TppVarInit
TppScriptVars.DeclareGVars=function(gvarsTable)
  --tex essentially TppGVars.AllInitialize(), but TppGVars hasn't actually returned at this point so cant access it via global
  if gvarsTable==nil then
    return
  end
  for a,gvar in ipairs(gvarsTable)do
    local name,arraySize,value=gvar.name,gvar.arraySize,gvar.value
    if arraySize and(arraySize>1)then
      gvars[name]={}--tex
      for e=0,(arraySize-1)do
        gvars[name][e]=value
      end
    else
      gvars[name]=value
    end
  end
end

TppUiCommand={}
TppUiCommand.AnnounceLogDelayTime=function()
end
TppUiCommand.AnnounceLogView=function(message)
  print("AnnounceLogView:"..message)
end
--TODO: tie into actual langId load/lookup (in moonsharp) if you want to go that far.
TppUiCommand.AnnounceLogViewLangId=function(...)
  local argsStr={}
  for i,v in ipairs(arg)do
    argsStr[#argsStr+1]=tostring(v)
  end
  print("AnnounceLogViewLangId:"..table.concat(argsStr,","))
end
TppUiCommand.AnnounceLogViewJoinLangId=function(...)
  local argsStr={}
  for i,v in ipairs(arg)do
    argsStr[#argsStr+1]=tostring(v)
  end
  print("AnnounceLogViewJoinLangId:"..table.concat(argsStr,","))
end

WeatherManager={}
WeatherManager.FOG_TYPE_PARASITE=0
WeatherManager.FOG_TYPE_NORMAL=1
WeatherManager.FOG_TYPE_EERIE=2--reffed, but for completion

--SYNC mgsv 1.09
TppScriptVars.GetProgramVersionTable=function()
  --NOTE indexed by CATEGORY_
  return {
    0,0,nil,1,
    [0]=0,--CATEGORY_NONE=0,
    --[1]=??--CATEGORY_CONFIG
    --[2]=??CATEGORY_MISSION_RESTARTABLE=
    --[4]=??CATEGORY_GAME_GLOBAL=
    [8]=2,--CATEGORY_MISSION=
    [16]=0,--CATEGORY_RETRY=
    [32]=5,--CATEGORY_MB_MANAGEMENT=
    [64]=0,--CATEGORY_QUEST
    [128]=1,--CATEGORY_PERSONAL
  }
end


TppSystemUtility={
  gameModes={
    "TPP",
    "MGO",
  }
}
TppSystemUtility.GetCurrentGameMode=function()
  return "TPP"
end

--UserData
--DEBUGNOW KLUDGE DEBUGNOW
Vector3=function(x,y,z)

end

TppEquip={}
TppEquip.IsExistFile=function(filePath)
  filePath=foxLuaPath..filePath
  local f=io.open(filePath,"r")
  if f~=nil then
    f:close()
    return true
  else return false
  end
end

TppCommand={}
--tex missed from scrape since its a table
TppCommand.Weather={}

TppCommand.Weather.RegisterClockMessage=function(params)
  local id=params.id--Str32
  local seconds=params.seconds
  local isRepeat=params.isRepeat--bool
end
TppCommand.Weather.UnregisterClockMessage=function(params)
  local id=params.id--Str32
end
TppCommand.Weather.SetClockTimeScale=function(newTimeScale)
end
TppCommand.Weather.UnregisterAllClockMessages=function()end

UiDaemon={}
UiDaemon.GetInstance=function()
  return UiDaemon
end

--tex manually pulled together since my references scraper doesnt handle tables
--filled out further by checking out exe section
Vehicle={
  instanceCountMax=60,
  life={
    BROKEN=0,
    EXTINCTION=-1000,
  },
  observation={
    CRASH=1,
    PLAYER_WILL_HARM_VEHICLE=2,
    PLAYER_WILL_BREAK_VEHICLE=4,
    PLAYER_STOPS_VEHICLE_BY_BREAKING_WHEELS=8,
  },
  speed={
    FORWARD_SLOW=2.7777778513638,
    FORWARD_NORMAL=8.3333335540913,
    FORWARD_FAST=12.500000331137,
    FORWARD_MAX=27.777778513638,
    BACKWARD_SLOW=-1.3888889256819,
    BACKWARD_NORMAL=-2.7777778513638,
    BACKWARD_FAST=-5.5555557027275,
    BACKWARD_MAX=-27.777778513638,
  },
  state={
    CAN_FULTON=1,
    SPEED_DOWN=2,
  },
  class={
    DEFAULT=0,
    DARK_GRAY=1,
    OXIDE_RED=2,
  },
  paintType={
    NONE=0,
    RANK_0=1,
    RANK_1=2,
    RANK_2=3,
    FOVA_0=4,
    FOVA_1=5,
    FOVA_2=6,
    CUSTOM=7,
  },
  type={
    WESTERN_LIGHT_VEHICLE=1,
    EASTERN_LIGHT_VEHICLE=2,
    WESTERN_TRUCK=3,
    EASTERN_TRUCK=4,
    WESTERN_WHEELED_ARMORED_VEHICLE=5,
    EASTERN_WHEELED_ARMORED_VEHICLE=6,
    WESTERN_TRACKED_TANK=7,
    EASTERN_TRACKED_TANK=8,
  },
  subType={
    NONE=0,
    WESTERN_TRUCK_CARGO_ITEM_BOX=1,
    WESTERN_TRUCK_CARGO_CONTAINER=2,
    WESTERN_TRUCK_CARGO_CISTERN=3,
    WESTERN_TRUCK_HOOD=4,
    EASTERN_TRUCK_CARGO_AMMUNITION=1,
    EASTERN_TRUCK_CARGO_MATERIAL=2,
    EASTERN_TRUCK_CARGO_DRUM=3,
    EASTERN_TRUCK_CARGO_GENERATOR=4,
    WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN=1,
    WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON=2,
    EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY=1,
  },
  emblemType={
    LOCAL_PLAYER=1,
    OPPONENT_PLAYER=2,
  },
}

--EVER_UNREAL,--DEBUGNOW from exe, dont know where these fit
--SPIRITED_AWAY,

--tex derived from Inspecting runtime output of Vehicle.svars with difference instanceCounts
Vehicle.svars=function(params)
  local instanceCount=params.instanceCount or Vehicle.instanceCountMax
  local svars={
    {
      arraySize=instanceCount+1,
      category=8,
      name="ene_veh_name",
      save=true,
      sync=false,
      type=2,
      value=0,
      wait=false
    },
    {
      arraySize=(instanceCount+1)*12,
      category=8,
      name="ene_veh_life",
      save=true,
      sync=false,
      type=6,
      value=0,
      wait=false
    },
    {
      arraySize=instanceCount+1,
      category=8,
      name="ene_veh_state",
      save=true,
      sync=false,
      type=6,
      value=0,
      wait=false
    },
    {
      arraySize=(instanceCount+1)*4,
      category=8,
      name="ene_veh_attitude",
      save=true,
      sync=false,
      type=3,
      value=0,
      wait=false
    },
    {
      arraySize=(instanceCount+1)*3,
      category=8,
      name="ene_veh_ammo",
      save=true,
      sync=false,
      type=7,
      value=0,
      wait=false
    },
    {
      arraySize=instanceCount+1,
      category=16,
      name="ene_veh_marker",
      save=true,
      sync=false,
      type=2,
      value=0,
      wait=false
    },
    {
      arraySize=instanceCount+1,
      category=8,
      name="ene_veh_stash",
      save=true,
      sync=false,
      type=2,
      value=0,
      wait=false
    },
    {
      arraySize=1,
      category=8,
      name="ene_veh_relief",
      save=true,
      sync=false,
      type=2,
      value=0,
      wait=false
    },
    {
      arraySize=16,
      category=8,
      name="ene_veh_convoy",
      save=true,
      sync=false,
      type=7,
      value=0,
      wait=false
    },
  }

  return svars
end

Vehicle.SaveCarry=function(params)
  local options=params.options
  local initialPosition=params.initialPosition
  local initialRotY=params.initialRotY
  local save=params.save--ASSUMPTION, in same section in exe
  local sync=params.sync--ASSUMPTION, in same section in exe
end
Vehicle.LoadCarry=function()end
Vehicle.ClearCarry=function()end
Vehicle.FinishCarry=function()end
Vehicle.SetIgnoreDisableNpc=function(ignoreDisableNpc)--bool
end

--
--tex for TppGameStatus.Set etc, don't know why these aren't enums like most other things, there's clearly an enum for them in exe, just that it's not exposed and the TppGameStatus functions use strings instead
--because of that this is only here for documentations sake
TppGameStatuses={
  "S_DISABLE_TARGET",
  "S_DISABLE_TRAP",
  "S_DISABLE_PLAYER_PAD",
  "S_DISABLE_SYSTEM_UI_PAD",
  "S_DISABLE_PLAYER_DAMAGE",
  "S_DISABLE_THROWING",
  "S_DISABLE_PLACEMENT",
  "S_DISABLE_FILTER_EFFECTS",
  "S_DISABLE_NPC",
  "S_DISABLE_NPC_NOTICE",
  "S_DISABLE_HUD",
  "S_DISABLE_TERMINAL",
  "S_DISABLE_SUPPORT_HELICOPTER",
  "S_DISABLE_GAME",
  "S_DISABLE_GAME_PAUSE",
  "S_DISABLE_DEMO_PAUSE",
  "S_IS_NO_TIME_ELAPSE_MISSION",
  "S_ENABLE_FOB_PLAYER_HIDE",
  "S_ENABLE_TUTORIAL_PAUSE",
  "S_ENABLE_HIGH_LOADING",
  "S_IS_ONLINE",
  "S_IS_TIME_CIGARETTE",
  "S_IS_STEALTH_ASSIST_MODE",
  "S_IS_CLAIRVOYANCE",
  "S_IS_BLACK_LOADING",
  "S_IS_STAGE_LOAD_LATE",
  "S_INVISIBLE_UNRELATED_DEMO",
  "S_IS_SORTIE_PREPARATION",
  "S_IS_RESULT",
  "S_IS_TITLE_SCREEN",
  "S_IS_DEMO_CAMERA",
  "S_IS_RUST_FOG",
  "S_STOP_FOR_DEMO",
  "S_DISABLE_ESC_PAUSE",
  "S_DISABLE_MOUSE_CAMERA",
  "S_DISABLE_MOUSE_TRAP",
  "S_DISABLE_MOUSE_TRAP_FOR_END",
  "S_DISABLE_KEYBOARD",
}
--
vars={}
mvars={}
svars={}
gvars={}

--tex merge with mock modules built via IHTearDown
local metafunctions={
  __call=true,
  __index=true,
  __newindex=true,
}

--PROC
local AddMockModules=function(mockModules)
  for moduleName,mockModule in pairs(mockModules)do
    --print("Adding mock module "..moduleName)--DEBUG

    local module=_G[moduleName] or {}
    _G[moduleName]=module

    local metaTable=nil

    for k,v in pairs(mockModule)do
      --DEBUGNOW
      if type(module)=="function" then--TODO: fix above modules that I've made functions (Application etc
        print("warning module "..moduleName.." is function")
      elseif type(module)=="userdata" and metafunctions[k] then--DEBUGNOW KLUDGE workaround moonsharp userdata TODO can you add keys to userdata from lua in other vms?

      elseif module[k]==nil then
        if v=="<function>" then
          if metafunctions[k] then
            metaTable=metaTable or {}

            if k=="__call" then
              metaTable[k]=function(self,...)
                return self--tex since this seems mostly used for instance creation this works ok
              end
            elseif k=="__index" then
              metaTable[k]=function(self,k)
                return rawget(self,k)--tex just do what would be done anyway
              end
            elseif k=="__newindex" then
              metaTable[k]=function(self,k,v)
                rawset(self,k,v)--tex just do what would be done anyway
              end
            end

          else
            module[k]=function(...)end
          end
        elseif v=="<table>" then
          print("warning key "..k.." is table")
        else
          module[k]=v
        end
      end
    end

    if metaTable~=nil then
      setmetatable(module,metaTable)
    end
  end
end

--EXEC
-- TODO: split EXEC and PROC into MockFoxEngineProc or something and just leave this (MockFoxEngine.lua) as mock modules definition

print("Loading MockFoxEngineGame ("..gameId..")")
local mockFoxEngineModulesGameId=require(gameId.."/MockFoxEngineGame")
if not mockFoxEngineModulesGameId then
  print"ERROR: mockFoxEngineModulesGameId==nil"
  return
end
AddMockModules(mockFoxEngineModulesGameId)

print"Loading mock modules"
local mockModules=require(gameId.."/MockModulesGenerated")
if not mockModules then
  print"ERROR: mockModules==nil"--DEBUGNOW
  return
end
print"Adding mock modules"
AddMockModules(mockModules)

vars=require(gameId.."/vars")
