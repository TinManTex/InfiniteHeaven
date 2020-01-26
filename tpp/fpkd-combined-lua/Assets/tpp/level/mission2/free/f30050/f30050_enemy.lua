-- DOBUILD: 1
-- ORIGINALQAR: chunk3
-- PACKPATH: \Assets\tpp\pack\mission2\free\f30050\f30050.fpkd
--f30050_enemy.lua
local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local IsTypeFunc = Tpp.IsTypeFunc
local IsTypeTable = Tpp.IsTypeTable
local IsTypeString = Tpp.IsTypeString
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_ID

this.requires = {}





this.soldierDefine = {}
this.MAX_SOLDIER_STATE_COUNT = 256



this.soldierSubTypes = {}


this.routeSets = {}


this.GetRouteSetPriority = nil


this.combatSetting = {}






local PLNT_NAME = {
  "plnt0",
  "plnt1",
  "plnt2",
  "plnt3",
}









local VEHICLE_MAX = 4


this.vehiclDataList = {

    { setClusterId = 2, clusterId = 1, priority = 1, locator = "veh_cl01_cl00_0000", },
    { setClusterId = 3, clusterId = 1, priority = 1, locator = "veh_cl02_cl00_0000", },
    { setClusterId = 4, clusterId = 1, priority = 1, locator = "veh_cl03_cl00_0000", },
    { setClusterId = 5, clusterId = 1, priority = 1, locator = "veh_cl04_cl00_0000", },
    { setClusterId = 6, clusterId = 1, priority = 1, locator = "veh_cl05_cl00_0000", },
    { setClusterId = 7, clusterId = 1, priority = 1, locator = "veh_cl06_cl00_0000", },

    { setClusterId = 1, clusterId = 5, priority = 2, locator = "veh_cl00_cl04_0000", },
    { setClusterId = 1, clusterId = 3, priority = 3, locator = "veh_cl00_cl02_0000", },
    { setClusterId = 1, clusterId = 4, priority = 4, locator = "veh_cl00_cl03_0000", },
    { setClusterId = 1, clusterId = 2, priority = 5, locator = "veh_cl00_cl01_0000", },
    { setClusterId = 1, clusterId = 6, priority = 6, locator = "veh_cl00_cl05_0000", },
    { setClusterId = 1, clusterId = 7, priority = 7, locator = "veh_cl00_cl06_0000", },
}


this.vehicleSpawnList = {}


this.vehicleDefine = {
  instanceCount = VEHICLE_MAX
}






this.salutationRouteList = {

    {

      {
        {
          "ly003_cl00_route0000|cl00pl0_mb_fndt_plnt_free|rt_free_h_0000",
          "ly003_cl00_route0000|cl00pl0_mb_fndt_plnt_free|rt_free_h_0001",
          "ly003_cl00_route0000|cl00pl0_mb_fndt_plnt_free|rt_free_h_0002",
          "ly003_cl00_route0000|cl00pl0_mb_fndt_plnt_free|rt_free_h_0003",
        },

        {
          "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_h_0000",
          "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_h_0001",
        },
      },





























    },

















































































































































































































































}


this.salutationEnemyList = {}






this.SpawnVehicleOnInitialize = function ()
  if not this.NeedSetup() then
    return
  end

  this.SetupDespawnVehicle()
end


this.InitEnemy = function()
  if not this.NeedSetup() then
    return
  end

  for clusterId = 1, #TppDefine.CLUSTER_NAME do
    mtbs_enemy.InitEnemy(clusterId)
    mtbs_enemy.SetEnableSoldierInCluster( clusterId, false )
  end
end



this.SetUpEnemy = function()
  if not this.NeedSetup() then
    return
  end
  for clusterId = 1, #TppDefine.CLUSTER_NAME do
    mtbs_enemy.SetupEnemy( clusterId )
  end

  if Ivars.mbHostileSoldiers:Is(0) then--tex added bypass
    mtbs_enemy.SetFriendly()
  end

  if Ivars.mbZombies:Is(1) then--tex>
    InfMain.SetUpMBZombie()
  end--<


  TppEnemy.SetSaluteVoiceList()


  this.SetVehicleMarker()
end




this.OnLoad = function()
  if not this.NeedSetup() then
    this.soldierDefine	 = nil
    this.soldierSubTypes = nil
    this.routeSets		 = nil
    this.combatSetting	 = nil
    return
  end
  Fox.Log("*** f30050_enemy onload ***")
  mtbs_enemy.SetUseUiSettings(false)

  mvars.clusterConstructTable = {}
  for clusterId = 1, #TppDefine.CLUSTER_NAME do
    mvars.clusterConstructTable[clusterId] = 1
    local noUseRevenge = true
    if Ivars.revengeModeForMb:Is"FOB" then--tex>
      noUseRevenge=false
    end--<
    mtbs_enemy.OnLoad( clusterId, noUseRevenge )
    mtbs_enemy.SetupSoldierListFovaApplyPriority( clusterId )
  end


  this.soldierDefine	 = mtbs_enemy.soldierDefine
  this.soldierSubTypes = mtbs_enemy.soldierSubTypes
  this.routeSets		 = mtbs_enemy.routeSets
  this.combatSetting	 = mtbs_enemy.combatSetting
end


this.OnAllocate = function()
  this.GetRouteSetPriority = mtbs_enemy.GetRouteSetPriority
end


this.NeedSetup = function()
  return gvars.f30050_missionPackIndex == 0
end






function this.SetupSalutationEnemy()


  local startClusterId	= mtbs_helicopter.GetHeliStartClusterId()

  local startPlatformId	= mtbs_helicopter.GetHeliStartPlatformId()

  local isHeliport		= mtbs_helicopter.IsHeliStartHeliport()


  local clusterName		= TppDefine.CLUSTER_NAME[ startClusterId ]
  local platformName		= PLNT_NAME[startPlatformId]


  local clusterData		= this.salutationRouteList[ startClusterId ]

  if clusterData == nil or clusterData[ startPlatformId ] == nil then
    return
  end


  local routeSetTable		= clusterData[ startPlatformId ]
  local routeSets

  if isHeliport == false then
    routeSets			= routeSetTable[1]
  else
    if routeSetTable[2] then
      routeSets			= routeSetTable[2]
    else
      routeSets			= routeSetTable[1]
    end
  end

  local routeCount		= #routeSets


  local soldierList		= mtbs_enemy.GetSoldierForSalutation( clusterName, platformName, routeCount )


  if routeSets and next( routeSets ) then
    for i, soldierName in ipairs( soldierList ) do
      if routeSets[i] then
        local routeName = routeSets[i]
        TppEnemy.SetSneakRoute( soldierName, routeName )

        table.insert( this.salutationEnemyList, soldierName )
      end
    end
  end

end


function this.UnsetSalutationEnemy()
  if this.salutationEnemyList and next( this.salutationEnemyList ) then

    for i, soldierName in ipairs( this.salutationEnemyList ) do
      TppEnemy.UnsetSneakRoute( soldierName )
    end
  end
end






function this.SetupDespawnVehicle()

  local vehicleSetTable	= {}
  local clusterId


  if mvars.f30050_demoName and ( not f30050_sequence.IsRideOnHeliDemo( mvars.f30050_demoName ) ) then

    local demoPlayClusterName = f30050_demo.GetDemoPlayCluster( mvars.f30050_demoName )

    clusterId = mtbs_cluster.GetClusterId( demoPlayClusterName )

  else

    clusterId = ( MotherBaseStage.GetFirstCluster() + 1 )
  end

  for index, params in ipairs( this.vehiclDataList ) do
    local isSet = false

    local grade = mtbs_cluster.GetClusterConstruct( params.clusterId )

    if clusterId == 1 then
      if params.setClusterId == 1 and grade > 0 then
        isSet = true
      end

    else

      if clusterId == params.setClusterId then
        isSet = true

      elseif params.setClusterId == 1 and clusterId ~= params.clusterId then
        if grade > 0 then
          isSet = true
        end
      end
    end

    if isSet == true then
      local vehicleSetData = {
        id		= "Spawn",
        locator	= params.locator,
        type	= Vehicle.type.WESTERN_LIGHT_VEHICLE,
      }
      table.insert( vehicleSetTable, vehicleSetData )
    end
  end

  this.vehicleSpawnList	= {}
  local vehicleCount		= 0

  if next( vehicleSetTable ) then

    for i, params in ipairs( vehicleSetTable ) do
      if vehicleCount < VEHICLE_MAX then
        table.insert( this.vehicleSpawnList, params )
        vehicleCount = vehicleCount + 1
      end
    end

    TppEnemy.SpawnVehicles( this.vehicleSpawnList )
  end
end


function this.SetVehicleMarker()
  for i, params in ipairs( this.vehicleSpawnList ) do
    if params.locator then
      TppMarker.Enable( params.locator, 1, "none", "map_and_world_only_icon", 0, false, false , nil )
    end
  end
end




return this
