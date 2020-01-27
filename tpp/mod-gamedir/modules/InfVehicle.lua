-- InfVehicle.lua
local this={}
local InfCore=InfCore
local InfMain=InfMain
local Vehicle=Vehicle
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local SendCommand=GameObject.SendCommand

this.debugModule=false

--STATE
--tex TODO: flip flopping on how to handle mission vars (generated data on mission start)
--want shared state
--module local is nice seperation wise, but will clear (and usually break whatevers relying on it) when run-time reloading
--vs big-ole-table, mvars is the way most of the game handles it, but it's a bit opaque,
--it's cleared at some point during mission load TODO track down exact point when
--so would have to regenerate data to exact same state during in-game continue, which is a bit tricky with my other modification of stuff like soldierdefine/missionTable stuff.
--best bet might be to stick with module-local and just transfer data from old to new module instance
this.inf_patrolVehicleInfo={}
this.inf_patrolVehicleConvoyInfo={}


--REF
local numVehiclePatrols={
  [30010]=6,
  [30020]=7,
}

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

function this.PostModuleReload(prevModule)
  this.inf_patrolVehicleInfo=prevModule.inf_patrolVehicleInfo
  this.inf_patrolVehicleConvoyInfo=prevModule.inf_patrolVehicleConvoyInfo
end

function this.BuildEnabledList(patrolVehicleEnabledList)
  local patrolVehicleEnabledList={}
  for baseType,typeInfo in pairs(this.vehicleBaseTypes) do
    if typeInfo.ivar then
      --InfCore.DebugPrint("spawnInfo.ivar="..spawnInfo.ivar)--DEBUG
      if Ivars[typeInfo.ivar]~=nil and Ivars[typeInfo.ivar]:Is()>0 then
        patrolVehicleEnabledList[#patrolVehicleEnabledList+1]=baseType
        --InfCore.DebugPrint(baseType.." added to enabledList")--DEBUG
      end
    end
  end
  return patrolVehicleEnabledList
end

--IN: vehicleSpawnList=missionTable.enemy.VEHICLE_SPAWN_LIST
--IN/OUT: soldierDefine
--OUT-SIDE: this.inf_patrolVehicleInfo,this.inf_patrolVehicleConvoyInfo
--IN-SIDE: this.convoys
--tex adds convoys, and sets up vehicles, InfSoldier.ModifyLrrpSoldiers fills them.
function this.ModifyVehiclePatrol(vehicleSpawnList,soldierDefine,travelPlans,cpPool)
  --InfCore.PCall(function(vehicleSpawnList,soldierDefine)--DEBUG
  if not Ivars.vehiclePatrolProfile:EnabledForMission() then
    return
  end

  if InfMain.IsContinue() then
    return
  end

  if vehicleSpawnList==nil then
    return
  end

  local patrolVehicleEnabledList=this.BuildEnabledList()
  if #patrolVehicleEnabledList==0 then
    InfCore.Log"ModifyVehicleSpawn - enabledList empty"--DEBUG
    return
  end

  InfMain.RandomSetToLevelSeed()

  local locationName=InfUtil.GetLocationName()

  this.inf_patrolVehicleInfo={}
  this.inf_patrolVehicleConvoyInfo={}

  --convoy setup
  --tex creates cp defines for additional convoy vehicles
  local lvIndicatorStr="veh_lv_"
  local freeLvs={}
  for n,spawnInfo in pairs(vehicleSpawnList)do
    if string.find(spawnInfo.locator,lvIndicatorStr) then
      freeLvs[#freeLvs+1]=spawnInfo.locator
    end
  end

  local convoys=this.convoys[locationName]
  this.inf_patrolVehicleConvoyInfo=this.SetupConvoyCpDefine(convoys,soldierDefine,travelPlans,cpPool,freeLvs)

  --tex vehicle setup
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

    local vehicleId=GetGameObjectId(spawnInfo.locator)
    if vehicleId==NULL_ID then
      InfCore.Log("InfVehicle.ModifyVehiclePatrol "..spawnInfo.locator.."==NULL_ID")
    else

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
            InfCore.DebugPrint("warning: vehicleType==nil")
            break
          end

          vehicle=vehicleSpawnInfoTable[vehicleType]
          if vehicle==nil then
            InfCore.DebugPrint("warning: vehicleSpawnInfoTable ".. vehicleType .."==nil")
            break
          end
          --tex used for ModifyLrrpSoldiers
          this.inf_patrolVehicleInfo[spawnInfo.locator]=vehicle

          --tex overwrite spawn info
          spawnInfo.type=vehicle.type
          spawnInfo.subType=vehicle.subType
        end
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

  if this.debugModule then
    InfCore.Log"ModifyPatrolVehicles"
    InfCore.Log"this.inf_patrolVehicleInfo:"
    InfCore.PrintInspect(this.inf_patrolVehicleInfo)
    InfCore.Log"this.inf_patrolVehicleConvoyInfo:"
    InfCore.PrintInspect(this.inf_patrolVehicleConvoyInfo)
  end
  --end,vehicleSpawnList,soldierDefine)--
end

--OUT: missionPackPath
--IN/OUT: packPaths
local function AddVehiclePack(vehicleType,packPaths)
  local vehicle=vehicleSpawnInfoTable[vehicleType]
  if vehicle and vehicle.packPath then
    packPaths[#packPaths+1]=vehicle.packPath
  end
end

--IN: vehicleSpawnInfoTable(via getpackpath,vehicleBaseTypes
--IN/OUT: missionPackPath
--CALLER: TppMissionList.GetMissionPackagePath
--TODO: only add those packs of active vehicles
--ditto reinforce vehicle types (or maybe an seperate equivalent function)

function this.AddMissionPacks(missionCode,packPaths)
  if not Ivars.vehiclePatrolProfile:EnabledForMission() then
    return
  end

  local locationName=InfUtil.GetLocationName()

  for baseType,typeInfo in pairs(this.vehicleBaseTypes) do
    if Ivars[typeInfo.ivar]~=nil and Ivars[typeInfo.ivar]:Is()>0 then
      --InfCore.DebugPrint("has gvar ".. typeInfo.ivar)--DEBUG
      local vehicles=typeInfo[locationName]

      if vehicles then
        for n,vehicleType in pairs(vehicles) do
          AddVehiclePack(vehicleType,packPaths)
        end
      else
        local vehicleType=locationVehiclePrefix[locationName]..baseType
        AddVehiclePack(vehicleType,packPaths)
      end
    end--if ivar
  end--for vehicle base types
end

function this.SetUpEnemy(missionTable)
  this.SetupConvoy()
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

--IN/OUT: soldierDefine,travelPlans,freeLvs,cpPool
function this.SetupConvoyCpDefine(convoys,soldierDefine,travelPlans,cpPool,freeLvs)
  if not convoys then
    return {}
  end

  --tex convoy setup
  --tex GOTCHA additional count/not counting existing/lead vehicle
  local convoySizeMin=2--TUNE
  local convoySizeMax=5--TUNE
  if convoySizeMax==0 then
    return {}
  end

  local patrolVehicleConvoyInfo={}

  --  local numConvoys=0
  --  for travelPlan,convoyInfo in pairs(convoys) do
  --    numConvoys=numConvoys+1
  --  end
  --convoySizeMax=math.min(math.floor(#freeLvs/numConvoys),convoySizeMax)
  --if convoySizeMax>==0 then
  --return
  --end

  for travelPlan,convoyInfo in pairs(convoys) do
    if #freeLvs==0 then
      break
    end

    local currentMax=math.min(#convoyInfo,convoySizeMax)
    --InfCore.DebugPrint("currentMax "..currentMax.." for "..travelPlan)--DEBUG
    if currentMax>0 then
      --currentMax=math.random(1,currentMax)--OFF TODO
      local convoyVehicles={}
      convoyVehicles[#convoyVehicles+1]=convoyInfo.leadVehicle

      for i=1,currentMax do
        if #cpPool==0 then
          break
        end
        local cpName=cpPool[#cpPool]
        cpPool[#cpPool]=nil

        local vehicleName=InfUtil.GetRandomPool(freeLvs)

        local cpDefine=soldierDefine[cpName]
        --TODO cpDefine.convoyIndex=i
        cpDefine.lrrpTravelPlan=travelPlan
        cpDefine.lrrpVehicle=vehicleName

        convoyVehicles[#convoyVehicles+1]=vehicleName
      end

      patrolVehicleConvoyInfo[travelPlan]=convoyVehicles
    end
  end

  --tex soldiers getting out messes up timing/spacing of convoy, and may cause the 'cant find vehicle' for following vehicles (as the vehicle stops further away)
  --so just remove them
  for travelPlan,convoyInfo in pairs(convoys) do
    travelPlans[travelPlan]=this.RemoveHoldsFromTravelPlan(travelPlans[travelPlan])
  end

  return patrolVehicleConvoyInfo
end

--IN-SIDE : this.inf_patrolVehicleConvoyInfo
--tex final setup, initial setup is in ModifyVehiclePatrol
function this.SetupConvoy()
  --InfCore.PCall(function()--DEBUG
  if not Ivars.vehiclePatrolProfile:EnabledForMission() then
    return
  end

  if this.inf_patrolVehicleConvoyInfo==nil then
    InfCore.Log"WARNING SetupConvoy: inf_patrolVehicleConvoyInfo==nil, aborting"--DEBUG
    return
  end

  local locationName=InfUtil.GetLocationName()
  local convoys=this.convoys[locationName]

  --InfCore.PrintInspect(this.inf_patrolVehicleConvoyInfo)--DEBUG
  if convoys then
    for travelPlan,convoyVehicles in pairs(this.inf_patrolVehicleConvoyInfo) do
      --InfCore.DebugPrint("SetupConvoy "..travelPlan)--DEBUG
      local convoyInfo=convoys[travelPlan]

      local convoyIds={}
      for i,vehicleName in ipairs(convoyVehicles)do
        local vehicleId=GetGameObjectId("TppVehicle2",vehicleName)
        if vehicleId==NULL_ID then
          InfCore.Log("WARNING: SetupConvoy: "..vehicleName.." gameId==NULL_ID")--DEBUG
        else
          convoyIds[#convoyIds+1]=vehicleId
          if TppMission.IsMissionStart() then
            if i>1 then--tex patrolVehicleConvoyInfo includes lead vehicle, which already has position
              --InfCore.DebugPrint("SetPosition "..vehicleName)--DEBUG
              local coords=convoyInfo[i-1]
              local command={id="SetPosition",position=Vector3(coords[1],coords[2],coords[3]),rotY=coords[4]}
              SendCommand(vehicleId,command)
            end
          end
        end

      end
      SendCommand({type="TppVehicle2"},{id="RegisterConvoy",convoyId=convoyIds})--tex not sure if this state is saved TODO: is RegisterConvoy singular or not? see s10090_sequence
    end
  end
  --end)--
end

function this.RemoveHoldsFromTravelPlan(travelPlan)
  local lrrpHoldStr="lrrpHold"
  local moddedPlan={}
  for i,planStep in ipairs(travelPlan) do
    if planStep.routeGroup and planStep.routeGroup[2]~=lrrpHoldStr then
      moddedPlan[#moddedPlan+1]=planStep
    end
  end
  return moddedPlan
end

return this
