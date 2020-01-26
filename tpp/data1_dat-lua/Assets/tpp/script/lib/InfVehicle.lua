-- DOBUILD: 1
--InfVehicle.lua
local this={}
local Ivars=Ivars
local InfMain=InfMain
local Vehicle=Vehicle

this.vehicleBaseTypes={
  LIGHT_VEHICLE={--jeep
    ivar="vehiclePatrolLvEnable",
    seats=4,
  },
  TRUCK={
    ivar="vehiclePatrolTruckEnable",
    seats=2,
    afgh={
      "EASTERN_TRUCK",
      "EASTERN_TRUCK_CARGO_AMMUNITION",
      "EASTERN_TRUCK_CARGO_MATERIAL",
      "EASTERN_TRUCK_CARGO_DRUM",
      "EASTERN_TRUCK_CARGO_GENERATOR",
    },
    mafr={
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
    afgh={
      "EASTERN_WHEELED_ARMORED_VEHICLE",
    },
    mafr={
      "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN",
    },
  },
  WHEELED_ARMORED_VEHICLE_HEAVY={
    ivar="vehiclePatrolWavHeavyEnable",
    seats=2,--6,
    enclosed=true,
    afgh={
      "EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY",
    },
    mafr={
      "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON",
    },
  },
  TRACKED_TANK={
    ivar="vehiclePatrolTankEnable",
    seats=1,--tex actually seats 2, but still behaviour with it stopping, dropping off a dude, then attacking
    enclosed=true,
  },
}

--TABLESETUP
--local vehicleBaseTypeNames={}
--for vehicleBaseType,baseTypeInfo in pairs(vehicleBaseTypes)do
--  
--end
--this.VEHICLE_BASETYPE=Enum(vehicleBaseTypeNames)

local vehicleSpawnInfoTable={--SYNC VEHICLE_SPAWN_TYPE
  EASTERN_LIGHT_VEHICLE={
    baseType="LIGHT_VEHICLE",
    type=Vehicle.type.EASTERN_LIGHT_VEHICLE,
    subType=Vehicle.subType.NONE,
  },
  WESTERN_LIGHT_VEHICLE={
    baseType="LIGHT_VEHICLE",
    type=Vehicle.type.WESTERN_LIGHT_VEHICLE,
    subType=Vehicle.subType.NONE,
  },

  EASTERN_TRUCK={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.NONE,
  },
  EASTERN_TRUCK_CARGO_AMMUNITION={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.EASTERN_TRUCK_CARGO_AMMUNITION,
  },
  EASTERN_TRUCK_CARGO_MATERIAL={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.EASTERN_TRUCK_CARGO_MATERIAL,
  },
  EASTERN_TRUCK_CARGO_DRUM={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.EASTERN_TRUCK_CARGO_DRUM,
  },
  EASTERN_TRUCK_CARGO_GENERATOR={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.EASTERN_TRUCK_CARGO_GENERATOR,
  },

  WESTERN_TRUCK={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.NONE,
  },

  WESTERN_TRUCK_CARGO_ITEM_BOX={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.WESTERN_TRUCK_CARGO_ITEM_BOX,
  },

  WESTERN_TRUCK_CARGO_CONTAINER={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.WESTERN_TRUCK_CARGO_CONTAINER,
  },

  WESTERN_TRUCK_CARGO_CISTERN={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.WESTERN_TRUCK_CARGO_CISTERN,
  },

  WESTERN_TRUCK_HOOD={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.WESTERN_TRUCK_HOOD,
  },

  EASTERN_WHEELED_ARMORED_VEHICLE={
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.NONE,
    packPath="/Assets/tpp/pack/vehicle/veh_rl_east_wav.fpk",
  },

  EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY={
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY,
    packPath="/Assets/tpp/pack/vehicle/veh_rl_east_wav_rocket.fpk",
  },

  WESTERN_WHEELED_ARMORED_VEHICLE={--Nope, vehicle seems almost complete, just no turret and no use cases in game
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.NONE,
  },

  WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN={
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN,
    packPath="/Assets/tpp/pack/vehicle/veh_rl_west_wav_machinegun.fpk",
  },

  WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON={
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON,
    packPath="/Assets/tpp/pack/vehicle/veh_rl_west_wav_cannon.fpk",
  },

  EASTERN_TRACKED_TANK={
    baseType="TRACKED_TANK",
    type=Vehicle.type.EASTERN_TRACKED_TANK,
    subType=Vehicle.subType.NONE,
    packPath="/Assets/tpp/pack/vehicle/veh_rl_east_tnk.fpk",
  },

  WESTERN_TRACKED_TANK={
    baseType="TRACKED_TANK",
    type=Vehicle.type.WESTERN_TRACKED_TANK,
    subType=Vehicle.subType.NONE,
    packPath="/Assets/tpp/pack/vehicle/veh_rl_west_tnk.fpk",
  },
}

local locationVehiclePrefix={
  afgh="EASTERN_",
  mafr="WESTERN_",
}

local skipClassSet={
  --tex still back and forth whether I want jeeps/trucks to have the heavier classes
--  [Vehicle.type.EASTERN_LIGHT_VEHICLE]=true,
--  [Vehicle.type.EASTERN_TRUCK]=true,
  [Vehicle.type.WESTERN_LIGHT_VEHICLE]=true,
  [Vehicle.type.WESTERN_TRUCK]=true,
}

function this.BuildEnabledList(patrolVehicleEnabledList)
  local patrolVehicleEnabledList={}
  for baseType,typeInfo in pairs(this.vehicleBaseTypes) do
    if typeInfo.ivar then
      --InfMenu.DebugPrint("spawnInfo.ivar="..spawnInfo.ivar)--DEBUG
      if Ivars[typeInfo.ivar]~=nil and Ivars[typeInfo.ivar]:Is()>0 then
        patrolVehicleEnabledList[#patrolVehicleEnabledList+1]=baseType
        --InfMenu.DebugPrint(baseType.." added to enabledList")--DEBUG
      end
    end
  end
  return patrolVehicleEnabledList
end

--IN: missionTable.enemy.VEHICLE_SPAWN_LIST, missionTable.enemy.soldierDefine
function this.ModifyVehiclePatrol(vehicleSpawnList)
  if Ivars.vehiclePatrolProfile:Is(0) or not Ivars.vehiclePatrolProfile:MissionCheck() then
    return
  end

  local patrolVehicleEnabledList=this.BuildEnabledList()
  if #patrolVehicleEnabledList==0 then
    --InfMenu.DebugPrint"ModifyVehicleSpawn - enabledList empty"--DEBUG
    return
  end

  InfMain.RandomSetToLevelSeed()

  mvars.inf_patrolVehicleInfo={}
  local locationName=InfMain.GetLocationName()
  local patrolNameIndicatorStr="veh_trc_000"

  local baseType=patrolVehicleEnabledList[math.random(#patrolVehicleEnabledList)]

  local class=this.GetVehicleColor()
  if Ivars.vehiclePatrolClass:Is"RANDOM" then
    class=math.random(0,2)--default>oxide
  end

  for n,spawnInfo in pairs(vehicleSpawnList)do
    local vehicle=nil
    local vehicleType=nil

    --tex only changing type on patrol vehicles
    local isPatrolVehicle=string.find(spawnInfo.locator,patrolNameIndicatorStr)
    if isPatrolVehicle then
      if not Ivars.vehiclePatrolProfile:Is"SINGULAR" then
        baseType=patrolVehicleEnabledList[math.random(#patrolVehicleEnabledList)]
      end
      local baseTypeInfo=this.vehicleBaseTypes[baseType]
      if baseTypeInfo~=nil then
        local vehicles=baseTypeInfo[locationName]
        if vehicles==nil then
          vehicleType=locationVehiclePrefix[locationName]..baseType
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
        mvars.inf_patrolVehicleInfo[spawnInfo.locator]=vehicle

        --tex overwrite spawn info
        spawnInfo.type=vehicle.type
        spawnInfo.subType=vehicle.subType
      end
      --<if isPatrolVehicle
    end

    if Ivars.vehiclePatrolClass:Is"RANDOM_EACH" then
      class=math.random(0,2)--default>oxide
    end

    --tex jeeps/trucks are fine with class/colors, but I'd rather just keep them with their PF paint.
    if skipClassSet[spawnInfo.type] then
      class=nil
    end

    --spawnInfo.emblemType=gvars.vehiclePatrolEmblemType
    if class then
      spawnInfo.paintType=nil
      spawnInfo.class=class
    end
    --<for vehicleSpawnList
  end

  InfMain.RandomResetToOsTime()
end

--OUT: missionPackPath
local function AddMissionPack(packPath,missionPackPath)
  if Tpp.IsTypeString(packPath)then
    missionPackPath[#missionPackPath+1]=packPath
  end
end

--IN: vehicleType,vehicleSpawnInfoTable
local GetPackPath=function(vehicleType)
  local vehicle=vehicleSpawnInfoTable[vehicleType]
  if vehicle~=nil then
    return vehicle.packPath or nil
  end
end

--IN: vehicleSpawnInfoTable(via getpackpath,vehicleBaseTypes
--OUT: missionPackPath
--CALLER: TppMissionList.GetMissionPackagePath
--TODO: only add those packs of active vehicles
--ditto reinforce vehicle types (or maybe an seperate equivalent function)
function this.AddVehiclePacks(missionCode,missionPackPath)
  if Ivars.vehiclePatrolProfile:Is(0) or not Ivars.vehiclePatrolProfile:MissionCheck() then
    return
  end

  local locationName=InfMain.GetLocationName()

  for baseType,typeInfo in pairs(this.vehicleBaseTypes) do
    if Ivars[typeInfo.ivar]~=nil and Ivars[typeInfo.ivar]:Is()>0 then
      --InfMenu.DebugPrint("has gvar ".. typeInfo.ivar)--DEBUG
      local vehicles=typeInfo[locationName]

      if vehicles==nil then
        local vehicleType=locationVehiclePrefix[locationName]..baseType
        local packPath=GetPackPath(vehicleType)
        if packPath~=nil then
          --InfMenu.DebugPrint("packpath: "..tostring(packPath))--DEBUG
          AddMissionPack(packPath,missionPackPath)
        end
      else
        for n,vehicleType in pairs(vehicles) do
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
