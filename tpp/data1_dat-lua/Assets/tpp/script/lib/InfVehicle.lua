-- DOBUILD: 1
--InfVehicle.lua
local this={}
local Ivars=Ivars
local InfMain=InfMain
local Vehicle=Vehicle
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local SendCommand=GameObject.SendCommand

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
function this.ModifyVehiclePatrol(vehicleSpawnList,soldierDefine,travelPlans)
  --InfInspect.TryFunc(function(vehicleSpawnList,soldierDefine)--DEBUG
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
  mvars.inf_patrolVehicleConvoyInfo={}

  local locationName=InfMain.GetLocationName()

  --convoy setup
  local lvIndicatorStr="veh_lv_"
  local freeLvs={}
  for n,spawnInfo in pairs(vehicleSpawnList)do
    if string.find(spawnInfo.locator,lvIndicatorStr) then
      freeLvs[#freeLvs+1]=spawnInfo.locator
    end
  end

  local cpPool=InfMain.BuildCpPool(soldierDefine)

  --tex GOTCHA additional count/not counting existing/lead vehicle
  local convoySizeMin=2--TUNE DEBUGNOW
  local convoySizeMax=5--TUNE DEBUGNOW
  if convoySizeMax>0 then
    local convoys=this.convoys[locationName]
    if convoys then
      local numConvoys=0
      for travelPlan,convoyInfo in pairs(convoys) do
        numConvoys=numConvoys+1
      end

      --convoySizeMax=math.min(math.floor(#freeLvs/numConvoys),convoySizeMax)

      if convoySizeMax>0 then
        for travelPlan,convoyInfo in pairs(convoys) do
          local currentMax=math.min(#convoyInfo,convoySizeMax)
          --InfMenu.DebugPrint("currentMax "..currentMax.." for "..travelPlan)--DEBUG
          if currentMax>0 then
            --currentMax=math.random(1,currentMax)--OFF TODO
            local convoyVehicles={}
            mvars.inf_patrolVehicleConvoyInfo[travelPlan]=convoyVehicles

            convoyVehicles[#convoyVehicles+1]=convoyInfo.leadVehicle

            for i=1,currentMax do
              if #cpPool==0 then
                break
              end
              local cpName=cpPool[#cpPool]
              cpPool[#cpPool]=nil

              local vehicleName=InfMain.GetRandomPool(freeLvs)

              local cpDefine=soldierDefine[cpName]
              --TODO cpDefine.convoyIndex=i
              cpDefine.lrrpTravelPlan=travelPlan
              cpDefine.lrrpVehicle=vehicleName

              convoyVehicles[#convoyVehicles+1]=vehicleName
            end
          end
        end

        --tex soldiers getting out messes up timing/spacing of convoy, and may cause the 'cant find vehicle' for following vehicles (as the vehicle stops further away)
        --so just remove them
        local lrrpHoldStr="lrrpHold"
        for travelPlan,convoyInfo in pairs(convoys) do
          local moddedPlan={}
          for i,planStep in ipairs(travelPlans[travelPlan]) do
            if planStep.routeGroup and planStep.routeGroup[2]~=lrrpHoldStr then
              moddedPlan[#moddedPlan+1]=planStep 
            end 
          end
          travelPlans[travelPlan]=moddedPlan
        end
      end
      --< end if convoys
    end
  end
  --< end convoy setup

  --
  local patrolVehicles={}
  for cpName,cpDefine in pairs(soldierDefine)do
    if cpDefine.lrrpVehicle then
      patrolVehicles[cpDefine.lrrpVehicle]=true
    end
  end

  local baseType=patrolVehicleEnabledList[math.random(#patrolVehicleEnabledList)]

  local class=this.GetVehicleColor()
  if Ivars.vehiclePatrolClass:Is"RANDOM" then
    class=math.random(0,2)--default>oxide
  end

  for n,spawnInfo in pairs(vehicleSpawnList)do
    local vehicle=nil
    local vehicleType=nil

    --tex only changing type on patrol vehicles
    if patrolVehicles[spawnInfo.locator] then
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
  --end,vehicleSpawnList,soldierDefine)--
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

--convoy
this.convoys={
  afgh={
    travelArea2_01={--tex Eastern Coms/Wailo loop
      leadVehicle="veh_trc_0000",
      leadCp="afgh_01_13_lrrp",
      {1591.106,322.205,1099.870,81},
      {1599.292,322.354,1089.520,81},
      --{1601.481,322.686,1078.456,81},
      
      
      --{1612.066,323.194,1066.894,81},
      --{1620.903,323.664,1054.599,81},
    },
--    travelArea2_03={--tex Mountain relay/Sakhra Ee loop
--      leadVehicle="veh_trc_0002",
--      leadCp="afgh_05_33_lrrp",
--      {1891.624,336,-313.310,20},
--      {1877.762,334.184,-315.944,20},
--    },
  }
}

--tex final setup, initial setup is in ModifyVehiclePatrol
function this.SetupConvoy()
  --InfInspect.TryFunc(function()--DEBUG
    if Ivars.vehiclePatrolProfile:Is(0) or not Ivars.vehiclePatrolProfile:MissionCheck() then
      return
  end

  if TppMission.IsMissionStart() then
    if mvars.inf_patrolVehicleConvoyInfo==nil then
      --InfMenu.DebugPrint"SetupConvoy: inf_patrolVehicleConvoyInfo==nil, aborting"--DEBUG
      return
    end

    local locationName=InfMain.GetLocationName()
    local convoys=this.convoys[locationName]

    --InfInspect.PrintInspect(mvars.inf_patrolVehicleConvoyInfo)--DEBUG
    local registeredConvoy=false--DEBUGNOW
    if convoys then
      for travelPlan,convoyVehicles in pairs(mvars.inf_patrolVehicleConvoyInfo) do
        --InfMenu.DebugPrint("SetupConvoy "..travelPlan)--DEBUG
        local convoyInfo=convoys[travelPlan]

        local convoyIds={}
        for i,vehicleName in ipairs(convoyVehicles)do
          convoyIds[#convoyIds+1]=GetGameObjectId("TppVehicle2",vehicleName)
          local vehicleId=GetGameObjectId("TppVehicle2",vehicleName)
          if vehicleId==NULL_ID then
            InfMenu.DebugPrint(vehicleName.." gameId==NULL_ID")--DEBUGNOW
          else
            if i>1 then--tex patrolVehicleConvoyInfo includes lead vehicle, which already has position
              --InfMenu.DebugPrint("SetPosition "..vehicleName)--DEBUG
              local coords=convoyInfo[i-1]
              local command={id="SetPosition",position=Vector3(coords[1],coords[2],coords[3]),rotY=coords[4]}
              SendCommand(vehicleId,command)
            end
          end

        end
        --if not registeredConvoy then--DEBUGNOW
        registeredConvoy=true
        SendCommand({type="TppVehicle2"},{id="RegisterConvoy",convoyId=convoyIds})
        --end
      end
    end
  end
  --end)--
end

return this
