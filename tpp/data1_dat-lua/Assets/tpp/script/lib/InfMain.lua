-- DOBUILD: 1
local this={}

this.DEBUGMODE=false
this.modVersion="r107"
this.modName="Infinite Heaven"

--LOCALOPT:
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local Enum=TppDefine.Enum
local StrCode32=Fox.StrCode32
local IsTimerActive=GkEventTimerManager.IsTimerActive

this.debugSplash=SplashScreen.Create("debugEagle","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",640,640)

function this.IsTableEmpty(checkTable)--tex TODO: shove in a utility module
  local next=next
  if next(checkTable)==nil then
    return true
  end
  return false
end


function this.ForceArmor(missionCode)
  if gvars.allowHeavyArmorInAllMissions>0 and not TppMission.IsFreeMission(missionCode) then
    return true
  end
  if gvars.allowHeavyArmorInFreeMode>0 and TppMission.IsFreeMission(missionCode) then
    return true
  end
  return false
end

function this.ForceArmorFree(missionCode)
  if gvars.allowHeavyArmorInFreeMode>0 and TppMission.IsFreeMission(missionCode) then
    return true
  end
  return false
end

this.SETTING_FORCE_ENEMY_TYPE=Enum{
  "DEFAULT",
  "TYPE_DD",
  "TYPE_SOVIET",
  "TYPE_PF",
  "TYPE_SKULL",
  "TYPE_CHILD",
  "MAX",
}

this.enemySubTypes={
  "Default",
  "DD_A",
  "DD_PW",
  "DD_FOB",
  "SKULL_CYPR",
  "SKULL_AFGH",
  "SOVIET_A",
  "SOVIET_B",
  "PF_A",
  "PF_B",
  "PF_C",
  "CHILD_A",
}

--EnemyType.TYPE_SOVIET
--EnemyType.TYPE_PF
--EnemyType.TYPE_DD
--EnemyType.TYPE_SKULL
--EnemyType.TYPE_CHILD

this.soldierSubTypesForTypeName={
  TYPE_DD={
    "DD_A",
    "DD_PW",
    "DD_FOB",
  },
  TYPE_SKULL={
    "SKULL_CYPR",
    "SKULL_AFGH",
  },
  TYPE_SOVIET={
    "SOVIET_A",
    "SOVIET_B",
  },
  TYPE_PF={
    "PF_A",
    "PF_B",
    "PF_C",
  },
  TYPE_CHILD={
    "CHILD_A",
  },
}
this.soldierTypeForSubtypes={
  DD_A=EnemyType.TYPE_DD,
  DD_PW=EnemyType.TYPE_DD,
  DD_FOB=EnemyType.TYPE_DD,
  SKULL_CYPR=EnemyType.TYPE_SKULL,
  SKULL_AFGH=EnemyType.TYPE_SKULL,
  SOVIET_A=EnemyType.TYPE_SOVIET,
  SOVIET_B=EnemyType.TYPE_SOVIET,
  PF_A=EnemyType.TYPE_PF,
  PF_B=EnemyType.TYPE_PF,
  PF_C=EnemyType.TYPE_PF,
  CHILD_A=EnemyType.TYPE_CHILD,
}
function this.SoldierTypeNameForType(soldierType)--tex maybe I'm missing something but not having luck indexing by EnemyType
  if soldierType == nil then
    return nil
end

if soldierType==EnemyType.TYPE_DD then
  return "TYPE_DD"
elseif soldierType==EnemyType.TYPE_SKULL then
  return "TYPE_SKULL"
elseif soldierType==EnemyType.TYPE_SOVIET then
  return "TYPE_SOVIET"
elseif soldierType==EnemyType.TYPE_PF then
  return "TYPE_PF"
elseif soldierType==EnemyType.TYPE_CHILD then
  return "TYPE_CHILD"
end
return nil
end

function this.IsSubTypeCorrectForType(soldierType,subType)--returns true on nil soldiertype because fsk that
  local soldierTypeName=this.SoldierTypeNameForType(soldierType)
  if soldierTypeName ~= nil then
    local subTypes=this.soldierSubTypesForTypeName[soldierTypeName]
    if subTypes ~= nil then
      for n, _subType in pairs()do
        if subType == _subType then
          return true
        end
      end
      return false
    end
  end
  return true
end

function this.IsMbWarGames(missionId)
  missionId=missionId or vars.missionCode
  return gvars.mbWarGames>0 and missionId==30050
end
function this.IsMbPlayTime(missionId)
  missionId=missionId or vars.missionCode
  if missionId==30050 then
    return gvars.mbPlayTime>0 or gvars.mbSoldierEquipGrade>0
  end
  return false
end
function this.IsForceSoldierSubType()
  return gvars.forceSoldierSubType>0 and TppMission.IsFreeMission(vars.missionCode)
end

function this.GetMbsClusterSecuritySoldierEquipGrade(missionId)--SYNC: mbSoldierEquipGrade
  local grade = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
  if this.IsMbPlayTime(missionId) and gvars.mbSoldierEquipGrade>Ivars.mbSoldierEquipGrade.enum.MBDEVEL then
    --TppUiCommand.AnnounceLogView("GetEquipGrade ismbplay, grade > devel")--DEBUG
    if gvars.mbSoldierEquipGrade==Ivars.mbSoldierEquipGrade.enum.RANDOM then
      grade = math.random(1,10)
    else
      grade = gvars.mbSoldierEquipGrade-Ivars.mbSoldierEquipGrade.enum.RANDOM
    end
  end
  --TppUiCommand.AnnounceLogView("GetEquipGrade: gvar:".. gvars.mbSoldierEquipGrade .." grade: ".. grade)--DEBUG
  --TppUiCommand.AnnounceLogView("Caller: ".. tostring(debug.getinfo(2).name) .." ".. tostring(debug.getinfo(2).source))--DEBUG
  return grade
end

function this.GetMbsClusterSecuritySoldierEquipRange(missionId)
  if InfMain.IsMbPlayTime(missionId) then
    if gvars.mbSoldierEquipRange==Ivars.mbSoldierEquipRange.enum.RANDOM then
      return math.random(0,2)--REF:{ "FOB_ShortRange", "FOB_MiddleRange", "FOB_LongRange", }, but range index from 0
    elseif gvars.mbSoldierEquipRange>0 then
      return gvars.mbSoldierEquipRange-1
    end
  end
  return TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipRange()
end

function this.GetMbsClusterSecurityIsNoKillMode(missionId)
  if this.IsMbPlayTime(missionId) then--tex PrepareDDParameter mbwargames, mbsoldierequipgrade
    return gvars.mbWarGames==Ivars.mbWarGames.enum.NONLETHAL
  end
  return TppMotherBaseManagement.GetMbsClusterSecurityIsNoKillMode()
end

function this.DisplayFox32(foxString)
  local str32 = Fox.StrCode32(foxString)
  TppUiCommand.AnnounceLogView("string :"..foxString .. "="..str32)
end


--function this.soldierFovBodyTableAfghan(missionId)
--  local bodyTable={
--    {0,MAX_REALIZED_COUNT},
--    {1,MAX_REALIZED_COUNT},
--    {2,MAX_REALIZED_COUNT},
--    {5,MAX_REALIZED_COUNT},
--    {6,MAX_REALIZED_COUNT},
--    {7,MAX_REALIZED_COUNT},
--    {10,MAX_REALIZED_COUNT},
--    {11,MAX_REALIZED_COUNT},
--    {20,MAX_REALIZED_COUNT},
--    {21,MAX_REALIZED_COUNT},
--    {22,MAX_REALIZED_COUNT},
--    {25,MAX_REALIZED_COUNT},
--    {26,MAX_REALIZED_COUNT},
--    {27,MAX_REALIZED_COUNT},
--    {30,MAX_REALIZED_COUNT},
--    {31,MAX_REALIZED_COUNT},
--    {TppEnemyBodyId.prs2_main0_v00,MAX_REALIZED_COUNT}
--  }

--  if not this.IsNotRequiredArmorSoldier(missionId)then
--    local e={TppEnemyBodyId.sva0_v00_a,MAX_REALIZED_COUNT}
--    table.insert(bodyTable,e)
--  end
--  return bodyTable
--end

--function this.soldierFovBodyTableAfrica(missionId)
--  local bodyTable={
--    {50,MAX_REALIZED_COUNT},
--    {51,MAX_REALIZED_COUNT},
--    {55,MAX_REALIZED_COUNT},
--    {60,MAX_REALIZED_COUNT},
--    {61,MAX_REALIZED_COUNT},
--    {70,MAX_REALIZED_COUNT},
--    {71,MAX_REALIZED_COUNT},
--    {75,MAX_REALIZED_COUNT},
--    {80,MAX_REALIZED_COUNT},
--    {81,MAX_REALIZED_COUNT},
--    {90,MAX_REALIZED_COUNT},
--    {91,MAX_REALIZED_COUNT},
--    {95,MAX_REALIZED_COUNT},
--    {100,MAX_REALIZED_COUNT},
--    {101,MAX_REALIZED_COUNT},
--    {TppEnemyBodyId.prs5_main0_v00,MAX_REALIZED_COUNT}
--  }

--  local armorTypeTable=this.GetArmorTypeTable(missionId)
--  if armorTypeTable~=nil then
--    local numArmorTypes=#armorTypeTable
--    if numArmorTypes>0 then
--      for t,armorType in ipairs(armorTypeTable)do
--        if armorType==TppDefine.AFR_ARMOR.TYPE_ZRS then
--          table.insert(bodyTable,{TppEnemyBodyId.pfa0_v00_a,MAX_REALIZED_COUNT})
--        elseif armorType==TppDefine.AFR_ARMOR.TYPE_CFA then
--          table.insert(bodyTable,{TppEnemyBodyId.pfa0_v00_b,MAX_REALIZED_COUNT})
--        elseif armorType==TppDefine.AFR_ARMOR.TYPE_RC then
--          table.insert(bodyTable,{TppEnemyBodyId.pfa0_v00_c,MAX_REALIZED_COUNT})
--        else
--          table.insert(bodyTable,{TppEnemyBodyId.pfa0_v00_a,MAX_REALIZED_COUNT})
--        end
--      end
--    end
--  end
--end

function this.ResetCpTableToDefault()
  local subTypeOfCp=TppEnemy.subTypeOfCp
  local subTypeOfCpDefault=TppEnemy.subTypeOfCpDefault
  for cp, subType in pairs(subTypeOfCp)do
    subTypeOfCp[cp]=subTypeOfCpDefault[cp]
  end
end

--function this.GetGameId(gameId,type)
--if IsString(gameId) then
--gameId=GetGameObjectId(gameId)
--local soldierId=GetGameObjectId("TppSoldier2",soldierName)
--if soldierId~=NULL_ID then
--end
--if gameId==nil or gameId==NULL_ID then
--return nil
--end
--end

function this.ChangePhase(cpName,phase)
  local gameId=GetGameObjectId("TppCommandPost2",cpName)
  if gameId==NULL_ID then
    InfMenu.DebugPrint("Could not find cp "..cpName)
    return
  end
  local command={id="SetPhase",phase=phase}
  SendCommand(gameId,command)
end

function this.SetKeepAlert(cpName,enable)
  local gameId=GetGameObjectId("TppCommandPost2",cpName)
  if gameId==NULL_ID then
    InfMenu.DebugPrint("Could not find cp "..cpName)
    return
  end
  local command={id="SetKeepAlert",enable=enable}
  GameObject.SendCommand(gameId,command)
end

--

this.SetFriendlyCp = function()
  local gameObjectId = { type="TppCommandPost2", index=0 }
  local command = { id = "SetFriendlyCp" }
  GameObject.SendCommand( gameObjectId, command )
end

this.SetFriendlyEnemy = function()
  local gameObjectId = { type="TppSoldier2" }
  local command = { id="SetFriendly", enabled=true }
  GameObject.SendCommand( gameObjectId, command )
end

--
function this.GetClosestCp()
  local closestCpId=nil
  local closestDist=9999999999999
  for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
    local cpId=GetGameObjectId(cpName)
    if cpId and cpId~=NULL_ID then
      --local cpPos=?
      local playerPos=TppPlayer.GetPosition()
      local distSqr=TppMath.FindDistance(cpPos,playerPos)
    end
  end
end

--<cp stuff

--vehicle stuff>
local vehicleBaseTypes={
  LIGHT_VEHICLE={--jeep
    ivar="vehiclePatrolLvEnable",
  },
  TRUCK={
    ivar="vehiclePatrolTruckEnable",
    easternVehicles={
      "EASTERN_TRUCK",
      "EASTERN_TRUCK_CARGO_AMMUNITION",
      "EASTERN_TRUCK_CARGO_MATERIAL",
      "EASTERN_TRUCK_CARGO_DRUM",
      "EASTERN_TRUCK_CARGO_GENERATOR",
    },
    westernVehicles={
      "WESTERN_TRUCK",
      "WESTERN_TRUCK_CARGO_ITEM_BOX",
      "WESTERN_TRUCK_CARGO_CONTAINER",
    --"WESTERN_TRUCK_HOOD",--tex OFF only used in one mission TODO: build own pack with it
    },
  },
  WHEELED_ARMORED_VEHICLE={
    ivar="vehiclePatrolWavEnable",
    easternVehicles={
      "EASTERN_WHEELED_ARMORED_VEHICLE",
    },
    westernVehicles={
      "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN",
    },
  },
  WHEELED_ARMORED_VEHICLE_HEAVY={
    ivar="vehiclePatrolWavHeavyEnable",
    easternVehicles={
      "EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY",
    },
    westernVehicles={
      "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON",
    },
  },
  TRACKED_TANK={
    ivar="vehiclePatrolTankEnable",
  },
}

this.VEHICLE_SPAWN_TYPE={--SYNC vehicleSpawnInfoTable
  "EASTERN_LIGHT_VEHICLE",
  "WESTERN_LIGHT_VEHICLE",
  "EASTERN_TRUCK",
  "EASTERN_TRUCK_CARGO_AMMUNITION",
  "EASTERN_TRUCK_CARGO_MATERIAL",
  "EASTERN_TRUCK_CARGO_DRUM",
  "EASTERN_TRUCK_CARGO_GENERATOR",
  "WESTERN_TRUCK",
  "WESTERN_TRUCK_CARGO_ITEM_BOX",
  "WESTERN_TRUCK_CARGO_CONTAINER",
  "WESTERN_TRUCK_CARGO_CISTERN",
  "WESTERN_TRUCK_HOOD",
  "EASTERN_WHEELED_ARMORED_VEHICLE",
  "EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY",
  "WESTERN_WHEELED_ARMORED_VEHICLE",
  "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN",
  "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON",
  "EASTERN_TRACKED_TANK",
  "WESTERN_TRACKED_TANK",
}
this.VEHICLE_SPAWN_TYPE_ENUM=Enum(this.VEHICLE_SPAWN_TYPE)

local vehicleSpawnInfoTable={--SYNC VEHICLE_SPAWN_TYPE
  EASTERN_LIGHT_VEHICLE={
    baseType="LIGHT_VEHICLE",
    type=Vehicle.type.EASTERN_LIGHT_VEHICLE,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
  },
  WESTERN_LIGHT_VEHICLE={
    baseType="LIGHT_VEHICLE",
    type=Vehicle.type.WESTERN_LIGHT_VEHICLE,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
  },

  EASTERN_TRUCK={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
  },
  EASTERN_TRUCK_CARGO_AMMUNITION={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.EASTERN_TRUCK_CARGO_AMMUNITION,
    class=nil,
    paintType=nil,
  },
  EASTERN_TRUCK_CARGO_MATERIAL={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.EASTERN_TRUCK_CARGO_MATERIAL,
    class=nil,
    paintType=nil,
  },
  EASTERN_TRUCK_CARGO_DRUM={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.EASTERN_TRUCK_CARGO_DRUM,
    class=nil,
    paintType=nil,
  },
  EASTERN_TRUCK_CARGO_GENERATOR={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.EASTERN_TRUCK_CARGO_GENERATOR,
    class=nil,
    paintType=nil,
  },

  WESTERN_TRUCK={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
  },

  WESTERN_TRUCK_CARGO_ITEM_BOX={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.WESTERN_TRUCK_CARGO_ITEM_BOX,
    class=nil,
    paintType=nil,
  },

  WESTERN_TRUCK_CARGO_CONTAINER={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.WESTERN_TRUCK_CARGO_CONTAINER,
    class=nil,
    paintType=nil,
  },

  WESTERN_TRUCK_CARGO_CISTERN={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.WESTERN_TRUCK_CARGO_CISTERN,
    class=nil,
    paintType=nil,
  },

  WESTERN_TRUCK_HOOD={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.WESTERN_TRUCK_HOOD,
    class=nil,
    paintType=nil,
  },

  EASTERN_WHEELED_ARMORED_VEHICLE={
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
    --packPath="/Assets/tpp/pack/ih_east_wavs.fpk",
    packPath="/Assets/tpp/pack/vehicle/veh_rl_east_wav.fpk",
    --packPathAlt="/Assets/tpp/pack/mission2/quest/extra/quest_q52130.fpk",
  },

  EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY={
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY,
    class=nil,
    paintType=nil,
    --OWpackPath="/Assets/tpp/pack/ih_east_wavs.fpk",
    packPath="/Assets/tpp/pack/vehicle/veh_rl_east_wav_rocket.fpk",
    --packPathAlt="/Assets/tpp/pack/mission2/quest/extra/quest_q52130.fpk",
  },


  WESTERN_WHEELED_ARMORED_VEHICLE={--Nope, vehicle seems almost complete, just no turret and no use cases in game
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
  },

  WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN,
    class=nil,
    paintType=nil,
    -- packPath="/Assets/tpp/pack/ih_west_wavs.fpk",
    packPath="/Assets/tpp/pack/vehicle/veh_rl_west_wav_machinegun.fpk",
    --packPathAlt="/Assets/tpp/pack/mission2/quest/extra/quest_q52110.fpk",
  },

  WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON,
    class=nil,
    paintType=nil,
    --packPath="/Assets/tpp/pack/ih_west_wavs.fpk",
    packPath="/Assets/tpp/pack/vehicle/veh_rl_west_wav_cannon.fpk",
    --packPathAlt="/Assets/tpp/pack/mission2/quest/extra/quest_q52110.fpk",
  },

  EASTERN_TRACKED_TANK={
    baseType="TRACKED_TANK",
    type=Vehicle.type.EASTERN_TRACKED_TANK,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
    --packPath="/Assets/tpp/pack/ih_east_tank.fpk",
    packPath="/Assets/tpp/pack/vehicle/veh_rl_east_tnk.fpk",
    --packPathAlt="/Assets/tpp/pack/mission2/quest/extra/quest_q52015.fpk",
  },

  WESTERN_TRACKED_TANK={
    baseType="TRACKED_TANK",
    type=Vehicle.type.WESTERN_TRACKED_TANK,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
    --packPath="/Assets/tpp/pack/ih_west_tank.fpk",
    packPath="/Assets/tpp/pack/vehicle/veh_rl_west_tnk.fpk",
    --packPathAlt="/Assets/tpp/pack/mission2/quest/extra/quest_q52045.fpk",
  },
}

local enabledList=nil--tex cleared on Init, TODO: don't like this setup

function this.IsPatrolVehicleMission()
  if vars.missionCode==TppDefine.SYS_MISSION_ID.AFGH_FREE or vars.missionCode==TppDefine.SYS_MISSION_ID.MAFR_FREE then
    return true
  end
  return false
end

this.MAX_PATROL_VEHICLES=16--SYNC: ivars MAX_PATROL_VEHICLES
function this.ClearPatrolVehicles()--CULL
  enabledList=nil
  InfMenu.DebugPrint"in ClearPatrolVehicles"--DEBUG
  if not this.IsPatrolVehicleMission() then
    InfMenu.DebugPrint"ClearPatrolVehicles()"--DEBUG
    for i=0,this.MAX_PATROL_VEHICLES-1 do
    --      gvars.vehiclePatrolSpawnedTypes[i]=0
    end
  end
end

function this.BuildEnabledList()
  enabledList={}
  for baseType,typeInfo in pairs(vehicleBaseTypes) do
    if typeInfo.ivar then
      --InfMenu.DebugPrint("spawnInfo.ivar="..spawnInfo.ivar)--DEBUG
      if gvars[typeInfo.ivar]~=nil and gvars[typeInfo.ivar]>0 then
        enabledList[#enabledList+1]=baseType
        --InfMenu.DebugPrint(baseType.." added to enabledList")--DEBUG
      end
    end
  end
end

--CALLER: TppEnemy.SpawnVehicle
--IN: spawnInfo
--OUT: spawnInfo
function this.PreSpawnVehicle(spawnInfo)
  if gvars.vehiclePatrolProfile==0 then
    return
  end

  if not this.IsPatrolVehicleMission() then
    return
  end

  if not spawnInfo.locator then
    return
  end

  if not string.find(spawnInfo.locator, "veh_trc_000") then--tex only replacing certain ids, seen in free mission vehicle spawn list
    return
  end

  local vehicleNumber=string.sub(spawnInfo.locator,9)
  vehicleNumber=tonumber(vehicleNumber)

  if vehicleNumber==nil then
    InfMenu.DebugPrint("vehiclePatrolSpawned but could not convert "..spawnInfo.locator.." to number")
    return
  end

  if vehicleNumber<0 or vehicleNumber>=this.MAX_PATROL_VEHICLES then
    InfMenu.DebugPrint("WARNING: vehicleNumber out of bounds: "..vehicleNumber)
    return
  end

  if Ivars.vehiclePatrolProfile:Is"SINGULAR" then
    vehicleNumber=0
  end

  local vehicleTypeNumber=svars.vehiclePatrolSpawnedTypes[vehicleNumber]

  if vehicleTypeNumber==nil then
    InfMenu.DebugPrint("ERROR: vehicleTypeNumber==nil")
    return
  end

  if vehicleTypeNumber==0 then
    --InfMenu.DebugPrint("vehicleTypeNumber==0")--DEBUG
    this.ModifyVehicleSpawn(vehicleNumber,spawnInfo)
  else
    this.RestoreVehiclePatrol(vehicleTypeNumber,spawnInfo)
  end
end

function this.RestoreVehiclePatrol(vehicleTypeNumber, spawnInfo)

  local vehicleType=this.VEHICLE_SPAWN_TYPE[vehicleTypeNumber]
  if vehicleType==nil then
    InfMenu.DebugPrint("could not restore vehicle "..spawnInfo.locator.." vehicletype nil with info type index "..vehicleTypeNumber)
    return
  end

  local vehicle=vehicleSpawnInfoTable[vehicleType]
  if vehicle==nil then
    InfMenu.DebugPrint("could not restore vehicle "..spawnInfo.locator.." vehicle nil with info type index "..vehicleTypeNumber)
    return
  end


  --InfMenu.DebugPrint("restoring "..spawnInfo.locator.." with "..vehicleType)--DEBUG
  this.SetPatrolSpawnInfo(vehicle,spawnInfo)
end

function this.ModifyVehicleSpawn(vehicleNumber,spawnInfo)
  if enabledList==nil then
    this.BuildEnabledList()
  end

  if #enabledList==0 then
    --InfMenu.DebugPrint"ModifyVehicleSpawn - enabledList empty"--DEBUG
    return
  end

  local vehicle=nil
  local vehicleType=nil

  --CULL if Ivars.vehiclePatrolProfile:Is"EACH_VEHICLE" or svars.vehiclePatrolSpawnedTypes[0]==0 then--tex using first in array set as indicator of Is"SINGULAR" set
  local baseType=enabledList[math.random(#enabledList)]
  local baseTypeInfo=vehicleBaseTypes[baseType]
  if baseTypeInfo==nil then
    InfMenu.DebugPrint("No baseTypeInfo for baseType "..baseType)
    return
  end

  local vehicles=nil
  local locationName=""
  if TppLocation.IsAfghan()then
    vehicles=baseTypeInfo.easternVehicles
    locationName="EASTERN_"
  elseif TppLocation.IsMiddleAfrica()then
    vehicles=baseTypeInfo.westernVehicles
    locationName="WESTERN_"
  end

  if vehicles==nil then
    vehicleType=locationName..baseType
  else
    vehicleType=vehicles[math.random(#vehicles)]
  end
  --end

  if vehicleType==nil then
    InfMenu.DebugPrint("warning: vehicleType==nil")
    return
  end

  vehicle=vehicleSpawnInfoTable[vehicleType]
  if vehicle==nil then
    InfMenu.DebugPrint("warning: vehicle==nil")
    return
  end

  --InfMenu.DebugPrint("spawning "..spawnInfo.locator.." with "..vehicleType)--DEBUG

  if svars.vehiclePatrolSpawnedTypes==nil then
    InfMenu.DebugPrint"svars.vehiclePatrolSpawnedTypes==nil"--DEBUG
  end
  svars.vehiclePatrolSpawnedTypes[vehicleNumber]=this.VEHICLE_SPAWN_TYPE_ENUM[vehicleType]+1

  this.SetPatrolSpawnInfo(vehicle,spawnInfo)
end

function this.SetPatrolSpawnInfo(vehicle,spawnInfo)
  spawnInfo.type=vehicle.type
  spawnInfo.subType=vehicle.subType
  --spawnInfo.class=vehicle.class
  --spawnInfo.paintType=vehicle.paintType

  --spawnInfo.class=gvars.vehiclePatrolClass
  --spawnInfo.paintType=gvars.vehiclePatrolPaintType
  --spawnInfo.emblemType=gvars.vehiclePatrolEmblemType
end

--OUT: missionPackPath
local function AddMissionPack(packPath,missionPackPath)
  if Tpp.IsTypeString(packPath)then
    table.insert(missionPackPath,packPath)
  end
end

--IN: vehicleSpawnInfoTable
--OUT: missionPackPath
--CALLER: TppMissionList.GetMissionPackagePath
--TODO: only add those packs of active vehicles
--ditto reinforce vehicle types (or maybe an seperate equivalent function)
function this.AddVehiclePacks(missionCode,missionPackPath)
  if gvars.vehiclePatrolProfile==0 then
    return
  end
  if not this.IsPatrolVehicleMission() then
    return
  end

--  for baseType,typeInfo in ipairs(vehicleBaseTypes) do
--    if gvars[typeInfo.ivar]~=nil and gvars[typeInfo.ivar]>0 then
--      --InfMenu.DebugPrint("has gvar ".. typeInfo.ivar)--DEBUG
--
--      local vehicles=nil
--      local vehicleType=""
--      local locationName=""
--      if TppLocation.IsAfghan()then
--        vehicles=typeInfo.easternVehicles
--        locationName="EASTERN_"
--      elseif TppLocation.IsMiddleAfrica()then
--        vehicles=typeInfo.westernVehicles
--        locationName="WESTERN_"
--      end
--
--
--      local GetPackPath=function(vehicleType)
--        local vehicle=vehicleSpawnInfoTable[vehicleType]
--        if vehicle~=nil then
--          if Ivars.vehiclePatrolPackType:Is"QUESTPACK" then
--            return vehicle.packPathAlt or nil
--          else
--            return vehicle.packPath or nil
--          end
--        end
--      end
--
--      if vehicles==nil then
--        vehicleType=locationName..typeInfo
--        local packPath=GetPackPath(vehicleType)
--        if packPath~=nil then
--           InfMenu.DebugPrint("packpath: "..tostring(packPath))--DEBUG
--          AddMissionPack(packPath,missionPackPath)
--        end
--
--      else
--        for n, vehicleType in ipairs(vehicles) do
--          local packPath=GetPackPath(vehicleType)
--          if packPath~=nil then
--            InfMenu.DebugPrint("packpath: "..tostring(packPath))--DEBUG
--            AddMissionPack(packPath,missionPackPath)
--          end              
--        end
--      end
--    end--if gvar
--  end--for vehicle base types

  local packPath
  for vehicleType,spawnInfo in pairs(vehicleSpawnInfoTable) do
    --CULLif Ivars.vehiclePatrolPackType:Is"QUESTPACK" then
    --  packPath=spawnInfo.packPathAlt
    --else
      packPath=spawnInfo.packPath
    --end 
    if packPath then
      AddMissionPack(packPath,missionPackPath)
    end
  end
end
--<vehicle stuff

--splash stuff>
this.oneOffSplashes={
  "startstart",
  "startend",
  "knm",
}
function this.AddOneOffSplash(splashName)
-- this.oneOffSplashes[#this.oneOffSplashes+1]=splashName
end
function this.DeleteOneOffSplashes()
  for n,splashName in pairs(this.oneOffSplashes) do
    this.DeleteSplash(splashName)
  end
  this.oneOffSplashes={}
end

function this.DeleteStartSplashes()
  this.DeleteSplash(this.currentRandomSplash)
  this.DeleteOneOffSplashes()
end


function this.DeleteSplash(splashName)
  if splashName~=nil then
    local splash=SplashScreen.GetSplashScreenWithName(splashName)
    if splash~=nil then
      SplashScreen.Delete(splash)
    end
  end
end

local emblemTypes={
  --{"base",{01,50}},--tex OFF mostly boring
  {"front",{01,85}},
  {"front",{5001,5027}},
  --{"front",{7008,7063}},--tex bunch missing (see DOC), boring emblems anyhoo
  {"front",{
    100,
    110,
    120,
    200,
    210,
    220,
    300,
    400,
    410,
    500,
    510,
    600,
    610,
    700,
    720,
    730,
    800,
    810,
    900,
    1000,
    1100,
    1200,
    1210,
    1220,
    1300,
    1310,
    1410,
    1420,
    1430,
    1500,
    1700,
    1710,
    1800,
    1900,
    1920,
    1940,
    1960,
    2000,
    2010,
    2100,
    2200,
    2210,
    2240,
    2241,
  }},
}

this.currentRandomSplash=nil
--IN: emblemTypes
--OUT: this.oneOffSplashes, this.currentRandomSplash, SplashScreen - a splashscreen
--ASSUMPTION: heavy on emblemTypes data layout assumptions, so if you change it, this do break
function this.CreateRandomEmblemSplash()
  --  if this.currentRandomSplash~=nil then
  --    if SplashScreen.GetSplashScreenWithName(this.currentRandomSplash) then
  --      return
  --    end
  --  end

  local groupNumber=math.random(#emblemTypes)
  local group=emblemTypes[groupNumber]
  local emblemType=group[1]
  local emblemRanges=group[2]
  local emblemNumber
  if #emblemRanges>2 then--tex collection of numbers rather than range
    local randomIndex=math.random(#emblemRanges)
    emblemNumber=emblemRanges[randomIndex]
  else
    emblemNumber=math.random(emblemRanges[1],emblemRanges[2])
  end

  local lowOrHi="h"--tex low is full opaque, i guess for being in background thus 'low' display order, hi is more detailed stencil
  --  if math.random()<0.5 then
  --    lowOrHi="l"
  --  else
  --    lowOrHi="h"
  --  end

  local name=emblemType..emblemNumber

  local path="/Assets/tpp/ui/texture/Emblem/"..emblemType.."/ui_emb_"..emblemType.."_"..emblemNumber.."_"..lowOrHi.."_alp.ftex"
  local randomSplash=SplashScreen.Create(name,path,640,640)

  this.currentRandomSplash=name
  --this.AddOneOffSplash(name)

  --SplashScreen.Show(randomSplash,.2,0.5,.2)
  return randomSplash
end

function this.SplashStateCallback_r(screenId, state)
  if mvars.startHasTitileSeqeunce then
    return
  end

  if state==SplashScreen.STATE_DELETE then
    local newSplash=this.CreateRandomEmblemSplash()
    SplashScreen.SetStateCallback(newSplash, this.SplashStateCallback_r)
    SplashScreen.Show( newSplash, .5, 3, .5)--.5,3,.5)-- 1.0, 4.0, 1.0)
  end
end
--<splash stuff

function this.OnAllocateFob()
  InfMenu.ResetSettings()--tex TODO: would like a nosave reset, but would need to change to reading ivar.setting instead of gvars, then would need to VERFY that .setting is restored on gvar restore
  TppSoldier2.ReloadSoldier2ParameterTables(InfSoldierParams.soldierParameters)
end


this.prevDisableActionFlag=nil
function this.DisableActionFlagEquipMenu()
  if this.prevDisableActionFlag==nil then
    this.prevDisableActionFlag=vars.playerDisableActionFlag
    vars.playerDisableActionFlag=vars.playerDisableActionFlag+PlayerDisableAction.OPEN_EQUIP_MENU
  end
end
function this.RestoreActionFlag()
  if this.prevDisableActionFlag~=nil then
    vars.playerDisableActionFlag=this.prevDisableActionFlag
    this.prevDisableActionFlag=nil
  end
end

--
local function UpdateRangeToMinMax(updateRate,updateRange)
  local min=updateRate-updateRange*0.5
  local max=updateRate+updateRange*0.5
  if min<0 then
    min=0
  end
  return min,max
end

function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="Dead",func=this.OnDead},
      {msg="Damage",func=this.OnDamage},
      {msg="ChangePhase",func=this.OnPhaseChange},
      {msg="RequestLoadReinforce",func=this.OnRequestLoadReinforce},
      {msg="RequestAppearReinforce",func=this.OnRequestAppearReinforce},
      {msg="CancelReinforce",func=this.OnCancelReinforce},
      {msg="LostControl",func=this.OnHeliLostControlReinforce},--DOC: Helicopter shiz.txt
      {msg="VehicleBroken",func=this.OnVehicleBrokenReinforce},
      {msg="RequestedHeliTaxi",func=function(gameObjectId,currentLandingZoneName,nextLandingZoneName)
        --InfMenu.DebugPrint("RequestedHeliTaxi currentLZ:"..currentLandingZoneName.. " nextLZ:"..nextLandingZoneName)--DEBUG
        end},
    },
    Player={
      {msg="FinishOpeningDemoOnHeli",func=this.ClearMarkers()},--tex xray effect off doesn't stick if done on an endfadein, and cant seen any ofther diable between the points suggesting there's an in-engine set between those points of execution(unless I'm missing something) VERIFY
    },
    UI={
      {msg="EndFadeIn",sender="FadeInOnGameStart",func=function()--fires on: most mission starts, on-foot free and story missions, not mb on-foot, but does mb heli start
        --InfMenu.DebugPrint"FadeInOnGameStart"--DEBUG
        this.FadeInOnGameStart()
      end},
      --this.FadeInOnGameStart},
      {msg="EndFadeIn",sender="FadeInOnStartMissionGame",func=function()--fires on: returning to heli from mission
        --  TppUiStatusManager.ClearStatus"AnnounceLog"
        --InfMenu.ModWelcome()
        --InfMenu.DebugPrint"FadeInOnStartMissionGame"--DEBUG
        --this.FadeInOnGameStart()
        end},
      {msg="EndFadeIn",sender="OnEndGameStartFadeIn",func=function()--fires on: on-foot mother base, both initial and continue
        --InfMenu.DebugPrint"OnEndGameStartFadeIn"--DEBUG
        this.FadeInOnGameStart()
      end},
    --elseif(messageId=="Dead"or messageId=="VehicleBroken")or messageId=="LostControl"then
    },
    Timer={
      {msg="Finish",sender="Timer_FinishReinforce",func=this.OnTimer_FinishReinforce,nil},
    },
    Terminal={
      {msg="MbDvcActSelectLandPoint",func=function(nextMissionId,routeName,layoutCode,clusterId)
        --InfMenu.DebugPrint("MbDvcActSelectLandPoint:"..tostring(routeName))--DEBUG
        end},
      {msg="MbDvcActSelectLandPointTaxi",func=function(nextMissionId,routeName,layoutCode,clusterId)
        --InfMenu.DebugPrint("MbDvcActSelectLandPointTaxi:"..tostring(routeName))--DEBUG
        end},
      {msg="MbDvcActHeliLandStartPos",func=function(set,x,y,z)
        --InfMenu.DebugPrint("HeliLandStartPos:"..x..","..y..","..z)--DEBUG
        end},
    },
  }
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this.OnDead(gameId,killerId,playerPhase,deadMessageFlag)
  --InfMenu.DebugPrint("InfMain.OnDead")
  --  local heliId=GetGameObjectId(TppReinforceBlock.REINFORCE_HELI_NAME)--CULL not for heli I guess
  --  if heliId~=NULL_ID then
  --    if heliId==gameId then
  --    --InfMenu.DebugPrint("InfMain.OnDead is heli")
  --    end
  --  end

  if GetTypeIndex(gameId)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end

  --local killerIsPlayer=(killerId==GameObject.GetGameObjectIdByIndex("TppPlayer2",PlayerInfo.GetLocalPlayerIndex()))
end


--TODO: VERIFY, add vehicle machineguns
local AttackIsVehicle=function(attackId)--RETAILBUG: seems like attackid must be a typo and f
  if(((((((((((((
    attackId==TppDamage.ATK_VehicleHit
    or attackId==TppDamage.ATK_Tankgun_20mmAutoCannon)
    or attackId==TppDamage.ATK_Tankgun_30mmAutoCannon)
    or attackId==TppDamage.ATK_Tankgun_105mmRifledBoreGun)
    or attackId==TppDamage.ATK_Tankgun_120mmSmoothBoreGun)
    or attackId==TppDamage.ATK_Tankgun_125mmSmoothBoreGun)
    or attackId==TppDamage.ATK_Tankgun_82mmRocketPoweredProjectile)
    or attackId==TppDamage.ATK_Tankgun_30mmAutoCannon)
    or attackId==TppDamage.ATK_Wav1)
    or attackId==TppDamage.ATK_WavCannon)
    or attackId==TppDamage.ATK_TankCannon)
    or attackId==TppDamage.ATK_WavRocket)
    or attackId==TppDamage.ATK_HeliMiniGun)
    or attackId==TppDamage.ATK_HeliChainGun)
--or attackId==TppDamage.ATK_WalkerGear_BodyAttack
then
  return true
end
return false
end
function this.OnDamage(gameId,attackId,attackerId)
  --InfMenu.DebugPrint"OnDamage"--DEBUG
  local typeIndex=GameObject.GetTypeIndex(gameId)
  if typeIndex~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then--and typeIndex~=TppGameObject.GAME_OBJECT_TYPE_HELI2 then
    return
  end

  if Tpp.IsPlayer(attackerId) then
    --InfMenu.DebugPrint"OnDamage attacked by player"
    if gvars.soldierAlertOnHeavyVehicleDamage>0 then
      if AttackIsVehicle(attackId) then
        --InfMenu.DebugPrint"OnDamage AttackIsVehicle"
        for cpId,soldierIds in pairs(mvars.ene_soldierIDList)do--tex TODO:find or build a better soldierid>cpid lookup
          if TppEnemy.GetPhaseByCPID(cpId)<gvars.soldierAlertOnHeavyVehicleDamage then
            if soldierIds[gameId]~=nil then
              --InfMenu.DebugPrint"OnDamage found soldier in idlist"
              local command={id="SetPhase",phase=gvars.soldierAlertOnHeavyVehicleDamage}
              SendCommand(cpId,command)
              break
            end
        end--if cp not phase
        end--for soldieridlist
      end--attackisvehicle
    end--gvar
  end--player is attacker
end

local function PhaseName(index)
  return Ivars.phaseSettings[index+1]
end
function this.OnPhaseChange(gameObjectId,phase,oldPhase)
  if gvars.printPhaseChanges==1 then
    --tex TODO: cpId>cpName
    InfMenu.Print("cpId:"..gameObjectId.." Phase change from:"..PhaseName(oldPhase).." to:"..PhaseName(phase))--InfMenu.LangString("phase_changed"..":"..PhaseName(phase)))--ADDLANG
  end
end

function this.FadeInOnGameStart()
  this.ClearMarkers()

  --tex player life values for difficulty. Difficult to track down the best place for this, player.changelifemax hangs anywhere but pretty much in game and ready to move, Anything before the ui ending fade in in fact, why.
  --which i don't like, my shitty code should be run in the shadows, not while player is getting viewable frames lol, this is at least just before that
  --RETRY: push back up again, you may just have fucked something up lol, the actual one use case is in sequence.OnEndMissionPrepareSequence which is the middle of tppmain.onallocate
  local healthScale=gvars.playerHealthScale
  if healthScale~=1 then
    Player.ResetLifeMaxValue()
    local newMax=vars.playerLifeMax
    newMax=newMax*healthScale
    if newMax < 10 then
      newMax = 10
    end
    Player.ChangeLifeMaxValue(newMax)
  end

  --TppUiStatusManager.ClearStatus"AnnounceLog"
  --InfMenu.ModWelcome()
end

function this.ClearMarkers()
  if gvars.disableHeadMarkers==1 then
    TppUiStatusManager.SetStatus("HeadMarker","INVALID")
  end
  if gvars.disableXrayMarkers==1 then
    --TppSoldier2.DisableMarkerModelEffect()
    TppSoldier2.SetDisableMarkerModelEffect{enabled=true}
  end
end

--ivar update system

local updateIvars={
  Ivars.phaseUpdate,
  Ivars.warpPlayerUpdate,
  Ivars.heliUpdate,
}

function this.Init(missionTable)--tex called from TppMain.OnInitialize
  this.abortToAcc=false

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  for i, ivar in ipairs(updateIvars) do
    if IsFunc(ivar.ExecInit) then
      ivar.ExecInit()
    end
  end

  this.UpdateHeliVars()

  --CULL  this.ClearPatrolVehicles()
end

function this.OnReload(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end


this.execChecks={
  inGame=false,--tex actually loaded game, ie at least 'continued' from title screen
  inHeliSpace=false,
  inMission=false,
  initialAction=false,--tex mission actually started/reached ground, triggers on checkpoint save so might not be valid for some uses
  inGroundVehicle=false,
  inSupportHeli=false,
  onBuddy=false,--tex sexy
  inMenu=false,
}

local playerVehicleId=0
this.currentTime=0

this.abortToAcc=false--tex

function this.Update()
  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end

  playerVehicleId=NULL_ID
  local currentChecks=this.execChecks
  --for k,v in ipairs(this.execChecks) do
  --this.execChecks[k]=false--tex TODO: can't figure out why this isn't actually setting REPRO: start misison, get into vehicle, get checkpoint, return to acc, still inGroundVehicle==true
  --end
  currentChecks.inHeliSpace=false
  currentChecks.inMission=false
  currentChecks.initialAction=false
  currentChecks.inGroundVehicle=false
  currentChecks.inSupportHeli=false
  currentChecks.onBuddy=false
  currentChecks.inMenu=false

  currentChecks.inGame=not mvars.mis_missionStateIsNotInGame

  if currentChecks.inGame then
    currentChecks.inHeliSpace=TppMission.IsHelicopterSpace(vars.missionCode)
    currentChecks.inMission=currentChecks.inGame and not currentChecks.inHeliSpace
    playerVehicleId=vars.playerVehicleGameObjectId

    if not currentChecks.inHeliSpace then
      currentChecks.initialAction=svars.ply_isUsedPlayerInitialAction--VERIFY that start on ground catches this (it's triggered on checkpoint save DOESNT catch motherbase ground start
      --if not initialAction then
      --InfMenu.DebugPrint"not initialAction"
      --end
      currentChecks.inSupportHeli=Tpp.IsHelicopter(playerVehicleId)--tex VERIFY
      currentChecks.inGroundVehicle=Tpp.IsVehicle(playerVehicleId) and not currentChecks.inSupportHeli-- or Tpp.IsEnemyWalkerGear(playerVehicleId)?? VERIFY
      currentChecks.onBuddy=Tpp.IsHorse(playerVehicleId) or Tpp.IsPlayerWalkerGear(playerVehicleId)
    end
  else

    local abortButton=InfButton.ESCAPE
    InfButton.buttonStates[abortButton].holdTime=1.5
    if InfButton.OnButtonHoldTime(abortButton) then
      local splash=SplashScreen.Create("abortsplash","/Assets/tpp/ui/ModelAsset/sys_logo/Pictures/common_kjp_logo_clp_nmp.ftex",640,640)
      SplashScreen.Show(splash,0,0.3,0)
      this.abortToAcc=true
    end
    --if this.abortToAcc then
    --  this.abortToAcc=false
    --  TppMission.ExecuteMissionAbort()
    --end
  end

  this.currentTime=Time.GetRawElapsedTimeSinceStartUp()
  --if currentChecks.inGame then
  --InfMenu.DebugPrint(tostring(this.currentTime))
  --end

  InfButton.UpdateHeld()
  InfButton.UpdateRepeatReset()

  ---Update shiz
  InfMenu.Update(currentChecks)
  currentChecks.inMenu=InfMenu.menuOn

  for i, ivar in ipairs(updateIvars) do
    if ivar.setting==1 then
      --tex ivar.updateRate is either number or another ivar
      local updateRate=ivar.updateRate or 0
      local updateRange=ivar.updateRange or 0
      if IsTable(updateRate) then
        updateRate=updateRate.setting
      end
      if IsTable(updateRange) then
        updateRange=updateRange.setting
      end
      --

      this.ExecUpdate(currentChecks,this.currentTime,ivar.execChecks,ivar.execState,updateRate,updateRange,ivar.ExecUpdate)
    end
  end
  ---
  InfButton.UpdatePressed()--tex GOTCHA: should be after all key reads, sets current keys to prev keys for onbutton checks
end

function this.ExecUpdate(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if execState.nextUpdate > currentTime then
    return
  end

  for check,ivarCheck in ipairs(execChecks) do
    if currentChecks[check]~=ivarCheck then
      return
    end
  end

  if not IsFunc(ExecUpdate) then
    InfMenu.DebugPrint"ExecUpdate is not a function"
    return
  end

  ExecUpdate(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)

  --tex set up next update time GOTCHA: wont reflect changes to rate and range till next update
  if updateRange then
    local updateMin=updateRate-updateRange*0.5
    local updateMax=updateRate+updateRange*0.5
    if updateMin<0 then
      updateMin=0
    end

    updateRate=math.random(updateMin,updateMax)
  end
  execState.nextUpdate=currentTime+updateRate

  --if currentChecks.inGame then
  -- InfMenu.DebugPrint("currentTime: "..tostring(currentTime).." updateRate:"..tostring(updateRate) .." nextUpdate:"..tostring(execState.nextUpdate))
  --end
end

--Phase/Alert updates DOC: Phases-Alerts.txt
--TODO RETRY, see if you can get when player comes into cp range better, playerPhase doesnt change till then
--RESEARCH music also starts up
--then can shift to game msg="ChangePhase" subscription
--state
local PHASE_ALERT=TppGameObject.PHASE_ALERT

function this.UpdatePhase(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if TppLocation.IsMotherBase() or TppLocation.IsMBQF() then
    return
  end

  local currentPhase=vars.playerPhase
  local minPhase=gvars.minPhase
  local maxPhase=gvars.maxPhase

  for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
    if currentPhase<minPhase then
      this.ChangePhase(cpName,minPhase)--gvars.minPhase)
    end
    if currentPhase>maxPhase then
      InfMain.ChangePhase(cpName,maxPhase)
    end

    if gvars.keepPhase==1 then
      InfMain.SetKeepAlert(cpName,true)
    else
    --InfMain.SetKeepAlert(cpName,false)--tex this would trash any vanilla setting, but updating this to off would only be important if ivar was updated at mission time
    end

    --tex keep forcing ALERT so that last know pos updates, otherwise it would take till the alert>evasion cooldown
    --doesnt really work well, > alert is set last know pos, take cover and suppress last know pos
    --evasion is - is no last pos, downgrade to caution, else group advance on last know pos
    --ideally would be able to set last know pos independant of phase
    --if minPhase==PHASE_ALERT then
    --debugMessage="phase<min setting to "..PhaseName(gvars.minPhase)
    --if currentPhase==PHASE_ALERT and execState.lastPhase==PHASE_ALERT then
    --this.ChangePhase(cpName,minPhase-1)--gvars.minPhase)
    --end
    --end
    if minPhase==TppGameObject.PHASE_EVASION then
      if execState.alertBump then
        execState.alertBump=false
        InfMain.ChangePhase(cpName,TppGameObject.PHASE_EVASION)
      end
    end
    if currentPhase<minPhase then
      if minPhase==TppGameObject.PHASE_EVASION then
        InfMain.ChangePhase(cpName,PHASE_ALERT)
        execState.alertBump=true
      end
    end
  end

  execState.lastPhase=currentPhase
end

--warp mode
--config
this.moveRightButton=InfButton.RIGHT
this.moveLeftButton=InfButton.LEFT
this.moveForwardButton=InfButton.UP
this.moveBackButton=InfButton.DOWN
this.moveUpButton=InfButton.STANCE
this.moveDownButton=InfButton.CALL

this.warpModeButtons={
  this.moveRightButton,
  this.moveLeftButton,
  this.moveForwardButton,
  this.moveBackButton,
  this.moveUpButton,
  this.moveDownButton,
}

--init
function this.InitWarpPlayerUpdate()
  InfButton.buttonStates[this.moveRightButton].decrement=0.1
  InfButton.buttonStates[this.moveLeftButton].decrement=0.1
  InfButton.buttonStates[this.moveForwardButton].decrement=0.1
  InfButton.buttonStates[this.moveBackButton].decrement=0.1
  InfButton.buttonStates[this.moveUpButton].decrement=0.1
  InfButton.buttonStates[this.moveDownButton].decrement=0.1
end

function this.UpdateWarpPlayer(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if currentChecks.inMenu then
    return
  end

  if not currentChecks.inGame or currentChecks.inHeliSpace then
    if Ivars.warpPlayerUpdate.setting==1 then
      Ivars.warpPlayerUpdate:Set(0)
    end
    return
  end

  if Ivars.warpPlayerUpdate.setting==0 then
    return
  end

  --TODO: refactor, in InfMenu.Update too
  local repeatRate=0.06
  local repeatRateUp=0.04
  InfButton.buttonStates[this.moveRightButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveLeftButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveForwardButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveBackButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveUpButton].repeatRate=repeatRateUp
  InfButton.buttonStates[this.moveDownButton].repeatRate=repeatRate

  local warpAmount=1
  local warpUpAmount=1

  local moveDir={}
  moveDir[1]=0
  moveDir[2]=0
  moveDir[3]=0

  local didMove=false

  if InfButton.OnButtonDown(this.moveForwardButton)
    or InfButton.OnButtonRepeat(this.moveForwardButton) then
    moveDir[3]=warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveBackButton)
    or InfButton.OnButtonRepeat(this.moveBackButton) then
    moveDir[3]=-warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveRightButton)
    or InfButton.OnButtonRepeat(this.moveRightButton) then
    moveDir[1]=-warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveLeftButton)
    or InfButton.OnButtonRepeat(this.moveLeftButton) then
    moveDir[1]=warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveUpButton)
    or InfButton.OnButtonRepeat(this.moveUpButton) then
    moveDir[2]=warpUpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveDownButton)
    or InfButton.OnButtonRepeat(this.moveDownButton) then
    moveDir[2]=-warpAmount
    didMove=true
  end

  if didMove then
    local currentPos = Vector3(vars.playerPosX, vars.playerPosY, vars.playerPosZ)
    local vMoveDir=Vector3(moveDir[1],moveDir[2],moveDir[3])
    local rotYQuat=Quat.RotationY(TppMath.DegreeToRadian(vars.playerRotY))
    local playerMoveDir=rotYQuat:Rotate(vMoveDir)
    local warpPos=currentPos+playerMoveDir
    TppPlayer.Warp{pos={warpPos:GetX(),warpPos:GetY(),warpPos:GetZ()},rotY=vars.playerCameraRotation[1]}
  end
end

--heli, called from TppMain.Onitiialize, so should only be 'enable/change from default', VERIFY it's in the right spot to override each setting
function this.UpdateHeliVars()
  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end

  local heliId=GetGameObjectId("TppHeli2","SupportHeli")
  if heliId==nil or heliId==NULL_ID then
    return
  end

  if gvars.disableHeliAttack==1 then--tex disable heli be fightan
    SendCommand(heliId,{id="SetCombatEnabled",enabled=false})
  end
  if gvars.setInvincibleHeli==1 then
    SendCommand(heliId,{id="SetInvincible",enabled=true})
  end
  if not Ivars.setTakeOffWaitTime:IsDefault() then
    SendCommand(heliId,{id="SetTakeOffWaitTime",time=gvars.setTakeOffWaitTime})
  end
  if gvars.disablePullOutHeli==1 then
    --if not TppLocation.IsMotherBase() and not TppLocation.IsMBQF() then--tex aparently disablepullout overrides the mother base taxi service TODO: not sure if I want to turn this off to save user confusion, or keep consistant behaviour
    SendCommand(heliId,{id="DisablePullOut"})
    --end
  end
  if not Ivars.setLandingZoneWaitHeightTop:IsDefault() then
    SendCommand(heliId,{id="SetLandingZoneWaitHeightTop",height=gvars.setLandingZoneWaitHeightTop})
  end
  if gvars.disableDescentToLandingZone==1 then
    SendCommand(heliId,{id="DisableDescentToLandingZone"})
  end
  if gvars.setSearchLightForcedHeli==1 then
    SendCommand(heliId,{id="SetSearchLightForcedType",type="Off"})
  end

  --if TppMission.IsMbFreeMissions(vars.missionCode) then--TEST no aparent result on initial testing, in-engine pullout check must be overriding
  --  TppUiStatusManager.UnsetStatus( "MbMap", "BLOCK_TAXI_CHANGE_LOCATION" )
  --end
end

function this.UpdateHeli(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  local heliId=GetGameObjectId("TppHeli2","SupportHeli")
  if heliId==nil or heliId==NULL_ID then
    return
  end

  --if gvars.enableGetOutHeli==1 then--TEST not that useful
  -- SendCommand(heliId, { id="SetGettingOutEnabled", enabled=true })
  --end

  if not currentChecks.inMenu and currentChecks.inSupportHeli then
    if gvars.disablePullOutHeli==1 then--or not currentChecks.initialAction then
      if InfButton.OnButtonDown(InfButton.STANCE) then
        --if not currentChecks.initialAction then--tex heli ride in TODO: RETRY: A reliable mission start parameter
        if IsTimerActive"Timer_MissionStartHeliDoorOpen" then
          SendCommand(heliId,{id="RequestSnedDoorOpen"})
        else
          if Ivars.disablePullOutHeli.setting==1 then
            --CULL SendCommand(heliId,{id="PullOut",forced=true})--tex even with forced wont go with player in heli
            Ivars.disablePullOutHeli:Set(0,true,true)--tex overrules all, but we can tell it to not save so that's ok
            InfMenu.PrintLangId"heli_pulling_out"
          else
            Ivars.disablePullOutHeli:Set(1,true,true)
            InfMenu.PrintLangId"heli_hold_pulling_out"
          end
        end
    end--button down
    end--nopullout or initialact
  end--not menu, insupportheli
end

function this.HeliOrderRecieved()
  if this.execChecks.inGame and not this.execChecks.inHeliSpace then
    InfMenu.PrintLangId"order_recieved"
  end
end



--reinforce stuff
this.reinforceInfo={
  cpId=nil,
  request=0,
  count=0,
}

function this.OnRequestLoadReinforce(cpId)
  --InfMenu.DebugPrint"_OnRequestLoadReinforce"--DEBUG
  if this.reinforceCount.cpId~=cpId then
    this.reinforceCount.cpId=cpId
    this.reinforceCount.count=0
    this.reinforceCount.request=0
  end
  this.reinforceCount.request=this.reinforceCount.request+1
end
function this.OnRequestAppearReinforce(cpId)
  --InfMenu.DebugPrint"_OnRequestAppearReinforce"--DEBUG
  this.reinforceCount.count=this.reinforceCount.count+1
end
function this.OnCancelReinforce(cpId)
--InfMenu.DebugPrint"_OnCancelReinforce"--DEBUG
end

function this.OnHeliLostControlReinforce(gameId,state,attackerId)--DOC: Helicopter shiz.txt
  --InfMenu.DebugPrint"OnHeliLostControlReinforce"
  local gameObjectType=GameObject.GetTypeIndex(gameId)
  if gameObjectType~=TppGameObject.GAME_OBJECT_TYPE_ENEMY_HELI then
    return
  end

  local heliId=GetGameObjectId(TppReinforceBlock.REINFORCE_HELI_NAME)
  if heliId~=gameId then
    return
  end

  if not mvars.reinforce_activated then
    --InfMenu.DebugPrint"OnHeliLostControlReinforce is reinforce heli but not reinforce_activated"
    return
  end

  if (state==StrCode32("Start")) then
  elseif (state==StrCode32("End")) then
    --InfMenu.DebugPrint"OnHeliLostControlReinforce is reinforce heli"
    --this.CheckAndFinishReinforce()

    if TppReinforceBlock._HasHeli() then--tex reinforcetype is heli
      --InfMenu.DebugPrint"start timer FinishReinforce"
      local cpId=mvars.reinforce_reinforceCpId
      --TppReinforceBlock.FinishReinforce(cpId)
      local StartTimer=GkEventTimerManager.Start
      StartTimer("Timer_FinishReinforce",2)--tex heli doesn't like it if reinforceblock is deactivated, even though I can't see it acually deactivating heli in finish.
    end
  end
end

function this.OnVehicleBrokenReinforce(vehicleId,state)--ASSUMPTION: Run after TppEnemy._OnVehicleBroken
  --InfMenu.DebugPrint"OnVehicleBroken"
  --local gameObjectType=GameObject.GetTypeIndex(vehicleId)
  local reinforceId=GetGameObjectId(TppReinforceBlock.REINFORCE_VEHICLE_NAME)
  if reinforceId~=vehicleId then
    return
  end

  if not mvars.reinforce_activated then
    --InfMenu.DebugPrint"OnVehicleBrokenReinforce is reinforce vehicle but not reinforce_activated"
    return
  end

  if (state==StrCode32("Start")) then
  elseif (state==StrCode32("End")) then
    --InfMenu.DebugPrint"OnVehicleBrokenReinforce is reinforce vehicle"
    --this.CheckAndFinishReinforce()
    if TppReinforceBlock._HasVehicle() then--tex reinforcetype is heli
      --InfMenu.DebugPrint"Do timer FinishReinforce"
      local cpId=mvars.reinforce_reinforceCpId
      --TppReinforceBlock.FinishReinforce(cpId)
      local StartTimer=GkEventTimerManager.Start
      StartTimer("Timer_FinishReinforce",2)--tex heli doesn't like it if reinforceblock is deactivated, even though I can't see it acually deactivating heli in finish.
    end
  end
end

function this.OnTimer_FinishReinforce()
  --InfMenu.DebugPrint"Do FinishReinforce"
  local cpId=mvars.reinforce_reinforceCpId
  TppReinforceBlock.FinishReinforce(cpId)
  TppReinforceBlock.UnloadReinforceBlock(cpId)
end

function this.CheckAndFinishReinforce()--WIP/UNUSED
  if not mvars.reinforce_activated then
    return false
end
if this.CheckReinforceDeactivate() then
  --InfMenu.DebugPrint"Do FinishReinforce"
  local cpId=mvars.reinforce_reinforceCpId
  TppReinforceBlock.FinishReinforce(cpId)
end
end
function this.CheckReinforceDeactivate()--WIP/UNUSED
  --if not mvars.reinforce_activated then
  --   return false
  -- end
  --mvars.reinforce_reinforceType
  local hasVehicle=TppReinforceBlock._HasVehicle()
  local hasSoldier=TppReinforceBlock._HasSoldier()
  local hasHeli=TppReinforceBlock._HasHeli()
  --local cp=mvars.ene_cpList[mvars.reinforce_reinforceCpId]
  local soldiersDead=false
  local vehicleBroken=false
  local heliBroken=false
  local vehicleAlive
  local vehicleReal
  local heliAlive
  local heliReal

  InfMenu.DebugPrint("hasVehicle: "..tostring(hasVehicle).." hasHeli: "..tostring(hasHeli).." hasSoldier: "..tostring(hasSoldier))

  local deadCount=0
  for n,soldierName in ipairs(TppReinforceBlock.REINFORCE_SOLDIER_NAMES)do
    local soldierId=GetGameObjectId("TppSoldier2",soldierName)
    if soldierId~=nil and soldierId~=NULL_ID then
      local NPC_STATE_DISABLE=TppGameObject.NPC_STATE_DISABLE
      local lifeStatus=SendCommand(soldierId,{id="GetLifeStatus"})
      local status=SendCommand(soldierId,{id="GetStatus"})
      if(status~=NPC_STATE_DISABLE)and(lifeStatus~=TppGameObject.NPC_LIFE_STATE_DEAD)then
        deadCount=deadCount+1
      end
    end
  end
  if deadCount==#TppReinforceBlock.REINFORCE_SOLDIER_NAMES then
    soldiersDead=true
  end

  InfMenu.DebugPrint("soldiersEliminated:"..tostring(soldiersDead))

  local vehicleId=GetGameObjectId("TppVehicle2",TppReinforceBlock.REINFORCE_VEHICLE_NAME)
  local driverId=GetGameObjectId("TppSoldier2",TppReinforceBlock.REINFORCE_DRIVER_SOLDIER_NAME)

  if vehicleId~=NULL_ID then
    --    if TppEnemy.IsVehicleBroken(vehicleId)then--tex only initied for quest eliminate targets
    --      vehicleEliminated=true
    --    end--
    --      if TppEnemy.IsRecovered(vehicleId)then
    --      vehicleEliminated=true
    --    end
    vehicleBroken=SendCommand(heliId,{id="IsBroken"})

    vehicleAlive=SendCommand(vehicleId,{id="IsAlive"})
    vehicleReal=SendCommand(vehicleId,{id="IsReal"})
    InfMenu.DebugPrint("vehicleBroken:"..tostring(vehicleBroken).." vehicleAlive:"..tostring(vehicleAlive))--.." vehicleReal:"..tostring(vehicleReal))
  end


  local heliId=GetGameObjectId(TppReinforceBlock.REINFORCE_HELI_NAME)
  if heliId~=NULL_ID then
    heliBroken=SendCommand(heliId,{id="IsBroken"})
    heliAlive=SendCommand(heliId,{id="IsAlive"})
    --heliReal=SendCommand(heliId,{id="IsReal"})
    InfMenu.DebugPrint("heliBroken:"..tostring(heliBroken).." heliAlive:"..tostring(heliAlive))--.." heliReal:"..tostring(heliReal))

    --    local aiState = SendCommand(heliId,{id="GetAiState"})--tex CULL only support heli aparently, returns strcode32 ""
    --    --InfMenu.DebugPrint("heliAiState:"..tostring(aiState))
    --    if aiState==StrCode32("WaitPoint") then
    --      InfMenu.DebugPrint("heliAiState: WaitPoint")
    --    elseif aiState==StrCode32("Descent") then
    --      InfMenu.DebugPrint("heliAiState: Descent")
    --    elseif aiState==StrCode32("Landing") then
    --      InfMenu.DebugPrint("heliAiState: Landing")
    --    elseif aiState==StrCode32("PullOut") then
    --      InfMenu.DebugPrint("heliAiState: PullOut")
    --    elseif aiState==StrCode32("") then
    --    InfMenu.DebugPrint("heliAiState: errr")
    --    else
    --      InfMenu.DebugPrint("heliAiState: unknown")
    --    end

  end



  if hasHeli and heliBroken then
    return true
  end
end
return this
