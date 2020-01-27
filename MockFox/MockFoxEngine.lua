-- MockFoxEngine.lua

--engine side

--mock
local mainApplication={}
mainApplication.AddGame=function(self,game)end
mainApplication.SetMainGame=function(self,game)end

Application=function(initTable)
  return mainApplication
end

AssetConfiguration={}
AssetConfiguration.GetDefaultCategory=function()
  return "eng"
end
AssetConfiguration.SetDefaultCategory=function(category,value)
  print("SetDefaultCategory "..category.." "..value)
end
AssetConfiguration.IsDiscOrHddImage=function()
  return false
end
AssetConfiguration.GetConfigurationFromAssetManager=function(configName)
  local hasConfig={
    EnableWindowsDX11Texture=true,
  }
  return hasConfig[configName] or false
end


AssetConfiguration.defaultTargetDirectory=""
AssetConfiguration.SetDefaultTargetDirectory=function(tag)
  AssetConfiguration.defaultTargetDirectory=tag
end

AssetConfiguration.targetDirectories={}
AssetConfiguration.SetTargetDirectory=function(fileType,tag)
  AssetConfiguration.targetDirectories[fileType]=tag
end


AssetConfiguration.RegisterExtensionInfo=function(extensionInfo)
  print(extensionInfo)
end

Chunk={}
Chunk.INDEX_CYPR=0
Chunk.INDEX_AFGH=1
Chunk.INDEX_MAFR=2
Chunk.INDEX_MTBS=3
Chunk.INDEX_MTBS=3
Chunk.INDEX_MGO=4

--mock
local mainGame={}
mainGame.CreateScene=function(self,sceneName)return{}end
mainGame.CreateBucket=function(self,bucketName,scene)return{}end
mainGame.SetMainBucket=function(self,bucket)end
--
Editor=function(initTable)
  return mainGame
end
EditorBase=Editor
Game=Editor

Fox={}
Fox.StrCode32=function(encodeString)--TODO IMPLEMENT
  return encodeString
end
Fox.GetPlatformName=function()
  return "Windows"
end

GameObject={}

GkEventTimerManager={}
GkEventTimerManager.Start=function()end
GkEventTimerManager.Stop=function()end
GkEventTimerManager.IsTimerActive=function()end

Mission={}

PathMapper={}
--PathMapper.Add=function(name,path)end

Player={}
Player.InitCamoufTable=function(dataTable)
end

PlayerType={}
PlayerType.SNAKE=0
PlayerType.DD_MALE=1
PlayerType.DD_FEMALE=2
PlayerType.AVATAR=3

Script={}
Script.LoadLibrary=function(scriptPath)
  local split=Util.Split(scriptPath,"/")
  local moduleName=split[#split]
  moduleName=string.sub(moduleName,1,-string.len(".lua")-1)

  local module=dofile(projectDataPath..scriptPath)
  if _G[moduleName] then
    _G[moduleName]=Util.MergeTable(_G[moduleName],module)
  else
    _G[moduleName]=module
  end
  --print("ScriptLoad:"..moduleName)
end
Script.LoadLibraryAsync=Script.LoadLibrary
Script.IsLoadingLibrary=function()
  return false
end

Time={}
Time.GetRawElapsedTimeSinceStartUp=function()--TODO IMPLEMENT
  return os.time()
end

TppGameMode={}
TppGameObject={}

local gameObjectTypes={
  "GAME_OBJECT_TYPE_PLAYER2",
  "GAME_OBJECT_TYPE_COMMAND_POST2",
  "GAME_OBJECT_TYPE_SOLDIER2",
  "GAME_OBJECT_TYPE_HOSTAGE2",
  "GAME_OBJECT_TYPE_HOSTAGE_UNIQUE",
  "GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2",
  "GAME_OBJECT_TYPE_HOSTAGE_KAZ",
  "GAME_OBJECT_TYPE_OCELOT2",
  "GAME_OBJECT_TYPE_HUEY2",
  "GAME_OBJECT_TYPE_CODE_TALKER2",
  "GAME_OBJECT_TYPE_SKULL_FACE2",
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
  TppGameObject[gameObjectTypes[i]]=i-1
end

TppNetworkUtil={}
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

WeatherManager={}
--VERIFY
WeatherManager.FOG_TYPE_PARASITE=0
WeatherManager.FOG_TYPE_NORMAL=1



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

TppDamage={}
TppDamage.ReloadDamageParameter=function(dataTable)
end
TppBullet={}
TppBullet.ReloadRecoilMaterials=function(datTable)
end
TppEnemy={}
TppEnemy.FOB_DD_SUIT_ATTCKER=1
TppEnemy.FOB_DD_SUIT_SNEAKING=2
TppEnemy.FOB_DD_SUIT_BTRDRS=3
TppEnemy.FOB_PF_SUIT_ARMOR=4

TppSoldier2={}
TppSoldier2.ReloadSoldier2ParameterTables=function(paramTable)
end

--enums and values, TODO: possibly IMPLEMENT
EnemyType={}

EnemyFova={}
EnemyFova.INVALID_FOVA_VALUE=32767
EnemyFova.MAX_REALIZED_COUNT=255
PlayerCamoType={}

PlayerDisableAction={}
PlayerPad={}
PlayerCamoType={}
BuddyType={
  HORSE=1,
  DOG=2,
  QUIET=3,
  WALKER_GEAR=4,
  BATTLE_GEAR=5,
}

TppEquip={}
TppEquip.ReloadEquipIdTable=function(equipIdTable)
  TppEquip.equipIdTable=equipIdTable
end
TppEquip.ReloadEquipParameterTables=function(dataTable)
end
TppEquip.ReloadEquipParameterTables2=function(dataTable)
end
TppEquip.ReloadEquipMotionData=function(dataTable)
end
TppEquip.ReloadEquipMotionData2=function(dataTable)
end
TppEquip.ReloadChimeraPartsInfoTable=function(dataTable)
end
TppEquip.IsExistFile=function(filePath)
  filePath=projectDataPath..filePath
  local f=io.open(filePath,"r")
  if f~=nil then
    io.close(f) return true
  else return false
  end
end

TppSoldierFace={}
TppSoldierFace.SetFovaFileTable=function(fovaFileTable)
end
TppSoldierFace.SetFaceFovaDefinitionTable=function(fovaFileTable)
end
TppSoldierFace.SetBodyFovaDefinitionTable=function(fovaFileTable)
end

vars={}
mvars={}
svars={}
gvars={}





--< engine side
