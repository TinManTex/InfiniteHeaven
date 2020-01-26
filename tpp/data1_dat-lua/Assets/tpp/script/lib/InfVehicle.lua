-- DOBUILD: 1
--InfVehicle.lua
local this={}

local vehicleBaseTypes={
  LIGHT_VEHICLE={--jeep
    ivar="vehiclePatrolLvEnable",
    seats=4,
  },
  TRUCK={
    ivar="vehiclePatrolTruckEnable",
    seats=2,
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
    seats=1,--6,
    enclosed=true,
    easternVehicles={
      "EASTERN_WHEELED_ARMORED_VEHICLE",
    },
    westernVehicles={
      "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN",
    },
  },
  WHEELED_ARMORED_VEHICLE_HEAVY={
    ivar="vehiclePatrolWavHeavyEnable",
    seats=2,--6,
    enclosed=true,
    easternVehicles={
      "EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY",
    },
    westernVehicles={
      "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON",
    },
  },
  TRACKED_TANK={
    ivar="vehiclePatrolTankEnable",
    seats=1,--tex actually seats 2, but still behaviour with it stopping, dropping off a dude, then attacking
    enclosed=true,
  },
}

--OFF
--this.VEHICLE_SPAWN_TYPE={--SYNC vehicleSpawnInfoTable
--  "EASTERN_LIGHT_VEHICLE",
--  "WESTERN_LIGHT_VEHICLE",
--  "EASTERN_TRUCK",
--  "EASTERN_TRUCK_CARGO_AMMUNITION",
--  "EASTERN_TRUCK_CARGO_MATERIAL",
--  "EASTERN_TRUCK_CARGO_DRUM",
--  "EASTERN_TRUCK_CARGO_GENERATOR",
--  "WESTERN_TRUCK",
--  "WESTERN_TRUCK_CARGO_ITEM_BOX",
--  "WESTERN_TRUCK_CARGO_CONTAINER",
--  "WESTERN_TRUCK_CARGO_CISTERN",
--  "WESTERN_TRUCK_HOOD",
--  "EASTERN_WHEELED_ARMORED_VEHICLE",
--  "EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY",
--  "WESTERN_WHEELED_ARMORED_VEHICLE",
--  "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN",
--  "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON",
--  "EASTERN_TRACKED_TANK",
--  "WESTERN_TRACKED_TANK",
--}
--this.VEHICLE_SPAWN_TYPE_ENUM=Enum(this.VEHICLE_SPAWN_TYPE)

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
    packPath="/Assets/tpp/pack/vehicle/veh_rl_east_wav.fpk",
  },

  EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY={
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY,
    class=nil,
    paintType=nil,
    packPath="/Assets/tpp/pack/vehicle/veh_rl_east_wav_rocket.fpk",
  },

  WESTERN_WHEELED_ARMORED_VEHICLE={--Nope, vehicle seems almost complete, just no turret and no use cases in game
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
  },

  WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN={
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN,
    class=nil,
    paintType=nil,
    packPath="/Assets/tpp/pack/vehicle/veh_rl_west_wav_machinegun.fpk",
  },

  WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON={
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON,
    class=nil,
    paintType=nil,
    packPath="/Assets/tpp/pack/vehicle/veh_rl_west_wav_cannon.fpk",
  },

  EASTERN_TRACKED_TANK={
    baseType="TRACKED_TANK",
    type=Vehicle.type.EASTERN_TRACKED_TANK,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
    packPath="/Assets/tpp/pack/vehicle/veh_rl_east_tnk.fpk",
  },

  WESTERN_TRACKED_TANK={
    baseType="TRACKED_TANK",
    type=Vehicle.type.WESTERN_TRACKED_TANK,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
    packPath="/Assets/tpp/pack/vehicle/veh_rl_west_tnk.fpk",
  },
}

local patrolVehicleEnabledList=nil--tex TODO: don't like this setup

function this.IsPatrolVehicleMission()
  if vars.missionCode==TppDefine.SYS_MISSION_ID.AFGH_FREE or vars.missionCode==TppDefine.SYS_MISSION_ID.MAFR_FREE then
    return true
  end
  return false
end

function this.BuildEnabledList()
  patrolVehicleEnabledList={}
  for baseType,typeInfo in pairs(vehicleBaseTypes) do
    if typeInfo.ivar then
      --InfMenu.DebugPrint("spawnInfo.ivar="..spawnInfo.ivar)--DEBUG
      if Ivars[typeInfo.ivar]~=nil and Ivars[typeInfo.ivar]:Is()>0 then
        patrolVehicleEnabledList[#patrolVehicleEnabledList+1]=baseType
        --InfMenu.DebugPrint(baseType.." added to enabledList")--DEBUG
      end
    end
  end
end

function this.SetPatrolSpawnInfo(vehicle,spawnInfo,class)
  spawnInfo.type=vehicle.type
  spawnInfo.subType=vehicle.subType
  --spawnInfo.class=vehicle.class
  --spawnInfo.paintType=vehicle.paintType

  --spawnInfo.class=gvars.vehiclePatrolClass
  --spawnInfo.paintType=gvars.vehiclePatrolPaintType
  --spawnInfo.emblemType=gvars.vehiclePatrolEmblemType

  if class then
    spawnInfo.paintType=nil
    spawnInfo.class=class
  end
end

--IN: missionTable.enemy.VEHICLE_SPAWN_LIST, missionTable.enemy.soldierDefine
function this.ModifyVehiclePatrol(vehicleSpawnList)
  if Ivars.vehiclePatrolProfile:Is(0) or not Ivars.vehiclePatrolProfile:MissionCheck() then
    return
  end


  this.BuildEnabledList()

  if #patrolVehicleEnabledList==0 then
    --InfMenu.DebugPrint"ModifyVehicleSpawn - enabledList empty"--DEBUG
    return
  end

  InfMain.SetLevelRandomSeed()

  mvars.patrolVehicleBaseInfo={}

  local class=this.GetVehicleColor()

  if Ivars.vehiclePatrolClass:Is"RANDOM" then
    class=math.random(0,2)--default>oxide
  end

  local singularBaseType=nil
  for n,spawnInfo in pairs(vehicleSpawnList)do
    if string.find(spawnInfo.locator, "veh_trc_000") then--tex only replacing certain ids, seen in free mission vehicle spawn list
      local vehicle=nil
      local vehicleType=nil

      local baseType=patrolVehicleEnabledList[math.random(#patrolVehicleEnabledList)]
      if Ivars.vehiclePatrolProfile:Is"SINGULAR" then
        if singularBaseType==nil then
          singularBaseType=baseType
        else
          baseType=singularBaseType
        end
      end
      local baseTypeInfo=vehicleBaseTypes[baseType]
      if baseTypeInfo~=nil then
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

        if vehicleType==nil then
          InfMenu.DebugPrint("warning: vehicleType==nil")
          break
        end

        vehicle=vehicleSpawnInfoTable[vehicleType]
        if vehicle==nil then
          InfMenu.DebugPrint("warning: vehicleSpawnInfoTable ".. vehicleType .."==nil")
          break
        end
        --tex used for ModifyVehiclePatrolSoldiers
        mvars.patrolVehicleBaseInfo[spawnInfo.locator]=baseTypeInfo

        if Ivars.vehiclePatrolClass:Is"RANDOM_EACH" then
          class=math.random(0,2)--default>oxide
        end
        if baseType~="LIGHT_VEHICLE" or baseType~="TRUCK" then
          class=nil
        end

        this.SetPatrolSpawnInfo(vehicle,spawnInfo,class)
      end
    end
  end

  InfMain.ResetTrueRandom()
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
  if Ivars.vehiclePatrolProfile:Is(0) or not Ivars.vehiclePatrolProfile:MissionCheck() then
    return
  end

  for baseType,typeInfo in pairs(vehicleBaseTypes) do
    if Ivars[typeInfo.ivar]~=nil and Ivars[typeInfo.ivar]:Is()>0 then
      --InfMenu.DebugPrint("has gvar ".. typeInfo.ivar)--DEBUG
      local vehicles=nil
      local vehicleType=""
      local locationName=""
      if TppLocation.IsAfghan()then
        vehicles=typeInfo.easternVehicles
        locationName="EASTERN_"
      elseif TppLocation.IsMiddleAfrica()then
        vehicles=typeInfo.westernVehicles
        locationName="WESTERN_"
      end


      local GetPackPath=function(vehicleType)
        local vehicle=vehicleSpawnInfoTable[vehicleType]
        if vehicle~=nil then
          return vehicle.packPath or nil
        end
      end

      if vehicles==nil then
        vehicleType=locationName..baseType
        local packPath=GetPackPath(vehicleType)
        if packPath~=nil then
          --InfMenu.DebugPrint("packpath: "..tostring(packPath))--DEBUG
          AddMissionPack(packPath,missionPackPath)
        end
      else
        for n, vehicleType in pairs(vehicles) do
          local packPath=GetPackPath(vehicleType)
          if packPath~=nil then
            --InfMenu.DebugPrint("packpath: "..tostring(packPath))--DEBUG
            AddMissionPack(packPath,missionPackPath)
          end
        end
      end
    end--if ivar
  end--for vehicle base types
end

--TUNE
function this.GetVehicleColor()
  if Ivars.vehiclePatrolClass:Is"ENEMY_PREP" then
    --tex alt tuning for combined stealth/combat average, but I think I like heli color tied to combat better thematically,
    --sure have them put more helis out if stealth level is high (see numAttackHelis), but only put beefier helis if your actually causing a ruckus
    --local level=InfMain.GetAverageRevengeLevel()
    --local levelToColor={0,0,1,1,2,2}--tex normally super reinforce(black,1) is combat 3,4, while super(red,2) is combat 5

    local level=TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)
    local levelToColor={0,0,0,1,1,2}
    return levelToColor[level+1]
  end

  return Ivars.vehiclePatrolClass:Get()
end

return this
