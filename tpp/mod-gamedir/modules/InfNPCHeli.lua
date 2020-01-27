--InfNPCHeli.lua
local this={}

--LOCALOPT
local InfCore=InfCore
local InfMain=InfMain
local StrCode32=InfCore.StrCode32
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand

this.debugModule=false

--updateState
this.active=1
this.execCheckTable={inGame=true,inHeliSpace=false}
this.execState={
  nextUpdate=0,
}

--STATE
this.heliList={}

local heliTimes={}
this.heliRouteIds={}--tex str32 route for free roam, cluster for mb (TODO: change to route as well)
local heliOnApproach={}
local closestDistance={}

this.enabledLzs=nil--tex free: is just this.heliRoutes[locationName], for mb is enabled lz in mtbs_cluster.SetUpLandingZone

local routesBag=nil--tex Free: ShuffleBag of enabledLzs

--TUNE
local routeTimeMbMin=3*60
local routeTimeMbMax=6*60

local routeTimeMin=4*60
local routeTimeMax=5*60

local levelToColor={0,0,0,1,1,2}

local heliPatrolsStr="heliPatrols"

this.totalAttackHelis=5--tex for svars, must match max instance count/fox2 totalcount (so includes reinforce/quest heli)

this.packages={
  afgh={
    "/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk",
  },
  mafr={
    "/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk",
  },
  mtbs={
    "/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk",
    "/Assets/tpp/pack/mission2/ih/ih_westheli_defloc.fpk",
  },
  "/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk",
  "/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk",
  "/Assets/tpp/pack/mission2/ih/ih_enemyheli_loc.fpk",
}

--tex defined by the entity/data definitions
this.heliNames={
  UTH={
    "WestHeli0000",
    "WestHeli0001",
    "WestHeli0002",
  },
  HP48={
    --tex don't know if I want to use "EnemyHeli" since there's a lot of other stuff tied to its name via quest heli and reinforce heli
    --"EnemyHeli",
    "EnemyHeli0000",
    "EnemyHeli0001",
    "EnemyHeli0002",
    "EnemyHeli0003",
  --tex reduced due to crash bug/match enemy_heli_<locaction>.fox2
  --      "EnemyHeli0004",
  --      "EnemyHeli0005",
  --    "EnemyHeli0006",
  },
}

--SYNC number of locators
this.maxHelis={
  UTH=3,
  HP48=4,
}

--tex TODO: pre convert to str32
this.heliRoutes={
  afgh={
    --    "lz_drp_enemyBase_N0000|rt_drp_enemyBase_N_0000",
    --    "lz_drp_field_N0000|rt_drp_field_N_0000",
    --    "lz_drp_enemyBase_S0000|rt_drp_enemyBase_S_0000",
    --    "lz_drp_citadelSouth_S0000|rt_drp_citadelSouth_S_0000",
    --    "lz_drp_commFacility_S0000|rt_drp_commFacility_S_0000",
    --    "lz_drp_cliffTown_N0000|rt_drp_clifftown_N_0000",
    --    "lz_drp_sovietBase_N0000|rt_drp_sovietBase_N_0000",
    --    "lz_drp_cliffTownWest_S0000|rt_drp_cliffTownWest_S_0000",
    --    "lz_drp_field_W0000|rt_drp_field_W_0000",
    "lz_drp_field_I0000|rt_drp_field_I_0000",--fort with fields assault (Da Shago Kallai)
    --    "lz_drp_remnantsNorth_N0000|rt_drp_remnantsNorth_N_0000",
    --    "lz_drp_fort_E0000|rt_drp_fort_E_0000",
    --    "lz_drp_slopedTownEast_E0000|rt_drp_slopedTownEast_E_0000",
    "lz_drp_commFacility_I0000|rt_drp_commFacility_I_0000",--Eastern Communications Post assault
    --    "lz_drp_waterway_I0000|rt_drp_waterway_I_0000",
    --    "lz_drp_sovietBase_S0000|rt_drp_sovietBase_S_0000",
    --    "lz_drp_powerPlant_S0000|rt_drp_powerPlant_S_0000",
    --    "lz_drp_bridge_S0000|rt_drp_bridge_S_0000",
    --    "lz_drp_fieldWest_S0000|rt_drp_fiieldWest_S_0000",
    --    "lz_drp_remnants_S0000|rt_drp_remnants_S_0000",
    --    "lz_drp_slopedTown_E0000|rt_drp_slopedTown_E_0000",
    --    "lz_drp_ruinsNorth_S0000|rt_drp_ruinsNorth_S_0000",
    "lz_drp_slopedTown_I0000|rt_drp_slopedTown_I_0000",--Da Ghwandai Khar assault
    "lz_drp_fort_I0000|rt_drp_fort_I_0000",--valley fort assault (Sa Smasei Laman)
    "lz_drp_tent_I0000|rt_drp_tent_I_0000",--volgin body fort assault (Yakho Oboo Supply Outpost)
    --    "lz_drp_village_W0000|rt_drp_village_W_0000",
    --    "lz_drp_remnantsNorth_S0000|rt_drp_remnantsNorth_S_0000",
    "lz_drp_village_N0000|rt_drp_village_N_0000",--Da Wialo Kallai (not assault)
    --    "lz_drp_tent_N0000|rt_drp_tent_N_0000",
    --    "lz_drp_tent_E0000|rt_drp_tent_E_0000",
    --    "lz_drp_slopedTown_W0000|rt_drp_slopedTown_W_0000",
    "lz_drp_remnants_I0000|rt_drp_remnants_I_0000",--Palace assault (Lamar Khaate Palace)
    --    "lz_drp_fort_W0000|rt_drp_fort_W_0000",
    --    "lz_drp_commFacility_W0000|rt_drp_commFacility_W_0000",
    "lz_drp_cliffTown_I0000|rt_drp_cliffTown_I0000",--cliff town assault (Qarya Sakhra Ee)
    "lz_drp_powerPlant_E0000|rt_drp_powerPlant_E_0000",--powerplant assault (Serak Power Plant)
    --    "lz_drp_cliffTown_S0000|rt_drp_cliffTown_S_0000",
    "lz_drp_enemyBase_I0000|rt_drp_enemyBase_I_0000",--Barracks assault (Wakh Sind Barracks)
    --    "lz_drp_ruins_S0000|rt_drp_ruins_S_0000",
    "lz_drp_sovietBase_E0000|rt_drp_sovietBase_E_0000",--Central Base assault (Afhanistan Central Base Camp)
  --"lz_drp_sovietSouth_S0000|rt_drp_sovietSouth_S_0000",
  },
  mafr={
    "lz_drp_lab_W0000|rt_drp_lab_W_0000",--Luftwa Valley NW, OB 08 E
    "lz_drp_hill_I0000|rt_drp_hill_I_0000",--Munoko ya Nioka Station assault
    --"lz_drp_diamond_N0000|rt_drp_diamond_N_0000",--Mine N
    --"lz_drp_swamp_S0000|rt_drp_swamp_S_0000",--Kiziba Camp SW
    --"lz_drp_savannahWest_N0000|lz_drp_savannahWest_N_0000",--Plantation S, OB 04 E, OB 03 W, OB 05 W, OB09 N
    --"lz_drp_diamondWest_S0000|lz_drp_diamondWest_S_0000",--Mine W, OB05,03 SE, OB07 W
    "lz_drp_swamp_I0000|rt_drp_swamp_I_0000",--Kiziba Camp assault
    "lz_drp_pfCamp_I0000|rt_drp_pfCamp_I_0000",-- Airport assault (Nova Braga)
    "lz_drp_savannah_I0000|rt_drp_savannah_I_0000",--Abandoned village tall hill/overlooking cliff assault (Ditadi Abandoned Village)
    --"lz_drp_pfCamp_N0000|rt_drp_pfcamp_N_0000",
    "lz_drp_diamond_I0000|rt_drp_diamond_I_0000",--Mine assault (Kungenga Mine)
    --"lz_drp_diamondSouth_W0000|rt_drp_diamondSouth_W_0000",--Mine SW, OB05,07 S, OB13N
    --"lz_drp_factoryWest_S0000|lz_drp_factoryWest_S_0000",
    --"lz_drp_pfCamp_S0000|lz_drp_pfCamp_S_0000",
    --"lz_drp_swamp_N0000|lz_drp_swamp_N_0000",--Kiziba N, OB 01 E
    --"lz_drp_labWest_W0000|rt_drp_labWest_W_0000",--Luftwa Valley W, OB02 E, OB08 W
    --"lz_drp_lab_S0000|rt_drp_lab_S_0000",--Luftwa Valley SW
    --"lz_drp_savannahEast_S0000|lz_drp_savannahEast_S_0000",
    --"lz_drp_hillWest_S0000|lz_drp_hillWest_S_0000",
    --"lz_drp_hill_N0000|lz_drp_hill_N_0000",
    --"lz_drp_pfCampNorth_S0000|rt_drp_pfCampNorth_S_0000",
    --"lz_drp_swamp_W0000|lz_drp_swamp_W_0000",--Mfinda S, Kizba NW, OP 01 W
    --"lz_drp_bananaSouth_N0000|rt_drp_bananaSouth_N_0000",
    --"lz_drp_swampEast_N0000|lz_drp_swampEast_N_0000",--Kiziba E, OB 10 N
    --"lz_drp_diamondSouth_S0000|lz_drp_diamondSouth_S_0000",
    --"lz_drp_hillSouth_W0000|lz_drp_hillSouth_W_0000",
    "lz_drp_banana_I0000|rt_drp_banana_I_0000",--Bampeve Plantation assault
    --"lz_drp_hill_E0000|lz_drp_hill_E_0000",
    --"lz_drp_factory_N0000|rt_drp_factory_N_0000",
    --"lz_drp_savannahEast_N0000|rt_drp_savannahEast_N_0000",
    --"lz_drp_flowStation_E0000|lz_drp_flowStation_E_0000",--Mfinda Oilfield east/ outpost 01
    "lz_drp_flowStation_I0000|rt_drp_flowStation_I_0000",--Mfinda Oilfield assault
  --"lz_drp_outland_S0000|rt_drp_outland_S_0000",
  },
}

--tex distances are distsquared
local routeInfos={
  afgh={
    --    "lz_drp_enemyBase_N0000|rt_drp_enemyBase_N_0000",
    --    "lz_drp_field_N0000|rt_drp_field_N_0000",
    --    "lz_drp_enemyBase_S0000|rt_drp_enemyBase_S_0000",
    --    "lz_drp_citadelSouth_S0000|rt_drp_citadelSouth_S_0000",
    --    "lz_drp_commFacility_S0000|rt_drp_commFacility_S_0000",
    --    "lz_drp_cliffTown_N0000|rt_drp_clifftown_N_0000",
    --    "lz_drp_sovietBase_N0000|rt_drp_sovietBase_N_0000",
    --    "lz_drp_cliffTownWest_S0000|rt_drp_cliffTownWest_S_0000",
    --    "lz_drp_field_W0000|rt_drp_field_W_0000",
    [StrCode32"lz_drp_field_I0000|rt_drp_field_I_0000"]={arrivedDistance=10,exitTime={25,60}},--fort with fields assault (Da Shago Kallai)
    --    "lz_drp_remnantsNorth_N0000|rt_drp_remnantsNorth_N_0000",
    --    "lz_drp_fort_E0000|rt_drp_fort_E_0000",
    --    "lz_drp_slopedTownEast_E0000|rt_drp_slopedTownEast_E_0000",
    [StrCode32"lz_drp_commFacility_I0000|rt_drp_commFacility_I_0000"]={arrivedDistance=10,exitTime={20,60}},--Eastern Communications Post assault --could have long exit 5+
    --    "lz_drp_waterway_I0000|rt_drp_waterway_I_0000",
    --    "lz_drp_sovietBase_S0000|rt_drp_sovietBase_S_0000",
    --    "lz_drp_powerPlant_S0000|rt_drp_powerPlant_S_0000",
    --    "lz_drp_bridge_S0000|rt_drp_bridge_S_0000",
    --    "lz_drp_fieldWest_S0000|rt_drp_fiieldWest_S_0000",
    --    "lz_drp_remnants_S0000|rt_drp_remnants_S_0000",
    --    "lz_drp_slopedTown_E0000|rt_drp_slopedTown_E_0000",
    --    "lz_drp_ruinsNorth_S0000|rt_drp_ruinsNorth_S_0000",
    [StrCode32"lz_drp_slopedTown_I0000|rt_drp_slopedTown_I_0000"]={arrivedDistance=12,exitTime={25,50}},--Kaz rescue village assault (Da Ghwandai Khar)
    [StrCode32"lz_drp_fort_I0000|rt_drp_fort_I_0000"]={arrivedDistance=20,exitTime={30,50}},--valley fort assault (Sa Smasei Laman)
    [StrCode32"lz_drp_tent_I0000|rt_drp_tent_I_0000"]={stickDistance=260},--volgin body fort assault (Yakho Oboo Supply Outpost)
    --    "lz_drp_village_W0000|rt_drp_village_W_0000",
    --    "lz_drp_remnantsNorth_S0000|rt_drp_remnantsNorth_S_0000",
    [StrCode32"lz_drp_village_N0000|rt_drp_village_N_0000"]={arrivedDistance=28,exitTime={15,50}},--Da Wialo Kallai (not assault) -- could have long exit 5+
    --    "lz_drp_tent_N0000|rt_drp_tent_N_0000",
    --    "lz_drp_tent_E0000|rt_drp_tent_E_0000",
    --    "lz_drp_slopedTown_W0000|rt_drp_slopedTown_W_0000",
    [StrCode32"lz_drp_remnants_I0000|rt_drp_remnants_I_0000"]={arrivedDistance=35,exitTime={20,35}},--Palace assault (Lamar Khaate Palace)
    --    "lz_drp_fort_W0000|rt_drp_fort_W_0000",
    --    "lz_drp_commFacility_W0000|rt_drp_commFacility_W_0000",
    [StrCode32"lz_drp_cliffTown_I0000|rt_drp_cliffTown_I0000"]={arrivedDistance=30,exitTime={40,60}},--cliff town assault (Qarya Sakhra Ee) --could have long exit
    [StrCode32"lz_drp_powerPlant_E0000|rt_drp_powerPlant_E_0000"]={arrivedDistance=440,exitTime={35,60}},--powerplant assault (Serak Power Plant), almost gets stuck, stickdist would be ~440, sould have long
    --    "lz_drp_cliffTown_S0000|rt_drp_cliffTown_S_0000",
    [StrCode32"lz_drp_enemyBase_I0000|rt_drp_enemyBase_I_0000"]={arrivedDistance=10,exitTime={25,60}},--Barracks assault (Wakh Sind Barracks)
    --    "lz_drp_ruins_S0000|rt_drp_ruins_S_0000",
    [StrCode32"lz_drp_sovietBase_E0000|rt_drp_sovietBase_E_0000"]={arrivedDistance=10,exitTime={50,70}},--Central Base assault (Afhanistan Central Base Camp)
  --"lz_drp_sovietSouth_S0000|rt_drp_sovietSouth_S_0000",
  },
  mafr={
    [StrCode32"lz_drp_lab_W0000|rt_drp_lab_W_0000"]={stickDistance=102},--Luftwa Valley NW, OB 08 E
    [StrCode32"lz_drp_hill_I0000|rt_drp_hill_I_0000"]={stickDistance=60},--Munoko ya Nioka Station assault
    --[StrCode32"lz_drp_diamond_N0000|rt_drp_diamond_N_0000"--Mine N
    --[StrCode32"lz_drp_swamp_S0000|rt_drp_swamp_S_0000"--Kiziba Camp SW
    --[StrCode32"lz_drp_savannahWest_N0000|lz_drp_savannahWest_N_0000"--Plantation S, OB 04 E, OB 03 W, OB 05 W, OB09 N
    --[StrCode32"lz_drp_diamondWest_S0000|lz_drp_diamondWest_S_0000"--Mine W, OB05,03 SE, OB07 W
    [StrCode32"lz_drp_swamp_I0000|rt_drp_swamp_I_0000"]={arrivedDistance=10,exitTime={20,60}},--Kiziba Camp assault
    [StrCode32"lz_drp_pfCamp_I0000|rt_drp_pfCamp_I_0000"]={arrivedDistance=10,exitTime={20,60}},-- Airport assault (Nova Braga)
    [StrCode32"lz_drp_savannah_I0000|rt_drp_savannah_I_0000"]={arrivedDistance=10,exitTime={20,40}},--Abandoned village tall hill/overlooking cliff assault (Ditadi Abandoned Village)
    --[StrCode32"lz_drp_pfCamp_N0000|rt_drp_pfcamp_N_0000",
    [StrCode32"lz_drp_diamond_I0000|rt_drp_diamond_I_0000"]={stickDistance=60},--Mine assault (Kungenga Mine)
    --[StrCode32"lz_drp_diamondSouth_W0000|rt_drp_diamondSouth_W_0000"--Mine SW, OB05,07 S, OB13N
    --[StrCode32"lz_drp_factoryWest_S0000|lz_drp_factoryWest_S_0000",
    --[StrCode32"lz_drp_pfCamp_S0000|lz_drp_pfCamp_S_0000",
    --[StrCode32"lz_drp_swamp_N0000|lz_drp_swamp_N_0000"--Kiziba N, OB 01 E
    --[StrCode32"lz_drp_labWest_W0000|rt_drp_labWest_W_0000"--Luftwa Valley W, OB02 E, OB08 W
    --[StrCode32"lz_drp_lab_S0000|rt_drp_lab_S_0000"--Luftwa Valley SW
    --[StrCode32"lz_drp_savannahEast_S0000|lz_drp_savannahEast_S_0000",
    --[StrCode32"lz_drp_hillWest_S0000|lz_drp_hillWest_S_0000",
    --[StrCode32"lz_drp_hill_N0000|lz_drp_hill_N_0000",
    --[StrCode32"lz_drp_pfCampNorth_S0000|rt_drp_pfCampNorth_S_0000",
    --[StrCode32"lz_drp_swamp_W0000|lz_drp_swamp_W_0000"--Mfinda S, Kizba NW, OP 01 W
    --[StrCode32"lz_drp_bananaSouth_N0000|rt_drp_bananaSouth_N_0000",
    --[StrCode32"lz_drp_swampEast_N0000|lz_drp_swampEast_N_0000"--Kiziba E, OB 10 N
    --[StrCode32"lz_drp_diamondSouth_S0000|lz_drp_diamondSouth_S_0000",
    --[StrCode32"lz_drp_hillSouth_W0000|lz_drp_hillSouth_W_0000",
    [StrCode32"lz_drp_banana_I0000|rt_drp_banana_I_0000"]={stickDistance=15},--Bampeve Plantation assault
    --[StrCode32"lz_drp_hill_E0000|lz_drp_hill_E_0000",
    --[StrCode32"lz_drp_factory_N0000|rt_drp_factory_N_0000",
    --[StrCode32"lz_drp_savannahEast_N0000|rt_drp_savannahEast_N_0000",
    --[StrCode32"lz_drp_flowStation_E0000|lz_drp_flowStation_E_0000"--Mfinda Oilfield east/ outpost 01
    [StrCode32"lz_drp_flowStation_I0000|rt_drp_flowStation_I_0000"]={arrivedDistance=10,exitTime={20,60}},--Mfinda Oilfield assault
  --[StrCode32"lz_drp_outland_S0000|rt_drp_outland_S_0000",
  },
}
this.heliRouteToCp={
  afgh={
    ["lz_drp_field_I0000|rt_drp_field_I_0000"]="afgh_field_cp",
    ["lz_drp_commFacility_I0000|rt_drp_commFacility_I_0000"]="afgh_commFacility_cp",
    --    "lz_drp_waterway_I0000|rt_drp_waterway_I_0000",--??
    ["lz_drp_slopedTown_I0000|rt_drp_slopedTown_I_0000"]="afgh_slopedTown_cp",
    ["lz_drp_fort_I0000|rt_drp_fort_I_0000"]="afgh_fort_cp",
    ["lz_drp_tent_I0000|rt_drp_tent_I_0000"]="afgh_tent_cp",
    ["lz_drp_village_N0000|rt_drp_village_N_0000"]="afgh_village_cp",
    ["lz_drp_remnants_I0000|rt_drp_remnants_I_0000"]="afgh_remnants_cp",
    ["lz_drp_cliffTown_I0000|rt_drp_cliffTown_I0000"]="afgh_cliffTown_cp",
    ["lz_drp_powerPlant_E0000|rt_drp_powerPlant_E_0000"]="afgh_powerPlant_cp",
    ["lz_drp_enemyBase_I0000|rt_drp_enemyBase_I_0000"]="afgh_enemyBase_cp",
    ["lz_drp_sovietBase_E0000|rt_drp_sovietBase_E_0000"]="afgh_sovietBase_cp",
  },
  mafr={
    ["lz_drp_hill_I0000|rt_drp_hill_I_0000"]="mafr_hill_cp",
    ["lz_drp_swamp_I0000|rt_drp_swamp_I_0000"]="mafr_swamp_cp",
    ["lz_drp_pfCamp_I0000|rt_drp_pfCamp_I_0000"]="mafr_pfCamp_cp",
    ["lz_drp_savannah_I0000|rt_drp_savannah_I_0000"]="mafr_savannah_cp",
    ["lz_drp_diamond_I0000|rt_drp_diamond_I_0000"]="mafr_diamond_cp",
    ["lz_drp_banana_I0000|rt_drp_banana_I_0000"]="mafr_banana_cp",
    ["lz_drp_flowStation_I0000|rt_drp_flowStation_I_0000"]="mafr_flowStation_cp",
  },
}
this.cpToHeliRoute={
  afgh={},
  mafr={},
}
for location,routeCpInfo in pairs(this.heliRouteToCp)do
  for route,cpName in pairs(routeCpInfo)do
    this.cpToHeliRoute[location][cpName]=route
  end
end

function this.AddMissionPacks(missionCode,packPaths)
  if not IvarProc.EnabledForMission(heliPatrolsStr,missionCode) then
    return
  end

  local locationName=InfUtil.GetLocationName()
  for i,packPath in ipairs(this.packages[locationName]) do
    packPaths[#packPaths+1]=packPath
  end
  for i,packPath in ipairs(this.packages) do
    packPaths[#packPaths+1]=packPath
  end
end

function this.Init(missionTable,currentChecks)
  this.messageExecTable=nil

  if not IvarProc.EnabledForMission(heliPatrolsStr) then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  local isMb=vars.missionCode==30050
  local isOuterPlat=vars.missionCode==30150 or vars.missionCode==30250

  this.heliList={}
  if isOuterPlat then
    return
  elseif isMb then
    local numClusters=0
    for clusterId, clusterName in ipairs(TppDefine.CLUSTER_NAME) do--DEBUGNOW
      local grade=TppMotherBaseManagement.GetMbsClusterGrade{category=TppDefine.CLUSTER_NAME[clusterId]}
      if grade>0 then
        numClusters=numClusters+1
      end
    end
    --InfCore.Log("InfNPCHeli numClusters "..numClusters)--DEBUG

    if Ivars.heliPatrolsMB:Is"UTH" or Ivars.heliPatrolsMB:Is"UTH_AND_HP48" then
      local numSupportHelis=math.min(this.maxHelis.UTH,numClusters)
      this.heliNames.UTH=InfLookup.GenerateNameList("WestHeli%04d",numSupportHelis)
      for i=1,numSupportHelis do
        this.heliList[#this.heliList+1]=this.heliNames.UTH[i]
      end
    end
    
    local numAttackHelis=numClusters-#this.heliList
    if numAttackHelis > 0 then
      if Ivars.heliPatrolsMB:Is"HP48" or Ivars.heliPatrolsMB:Is"UTH_AND_HP48" then
        this.heliNames.HP48=InfLookup.GenerateNameList("EnemyHeli%04d",numAttackHelis)
      
        for i=1,numAttackHelis do
          this.heliList[#this.heliList+1]=this.heliNames.HP48[i]
        end
      end
    end
  elseif Ivars.heliPatrolsFREE:Is()>0 then
    --local numAttackHelis=0
    --    if Ivars.heliPatrolsFREE:Is"ENEMY_PREP" then
    --      local level=InfMain.GetAverageRevengeLevel()
    --      local levelToHeli={0,1,3,5,6,7}--tex TUNE GOTCHA tuned to max helis of 7
    --      numAttackHelis=levelToHeli[level+1]
    --    else
    --      --tex from 1 (ignoring 0, off) SYNC Ivars.heliPatrolsFREE
    --      local settingToHeliNum={1,3,5,7}
    --      numAttackHelis=settingToHeliNum[Ivars.heliPatrolsFREE:Get()]
    --    end
    --numAttackHelis=math.min(numAttackHelis,#this.heliNames.HP48)

    local numAttackHelis=this.maxHelis.HP48
    this.heliNames.HP48=InfLookup.GenerateNameList("EnemyHeli%04d",numAttackHelis)

    for i=1,numAttackHelis do
      this.heliList[#this.heliList+1]=this.heliNames.HP48[i]
    end
  end

  local heliRouteIds=this.heliRouteIds
  for n=1,#this.heliList do
    heliTimes[n]=0
    heliRouteIds[n]=0
    heliOnApproach[n]=false
  end

  --      local heliMeshTypes={
  --        "uth_v00",
  --        "uth_v01",
  --        "uth_v02",
  --      }
  --      local meshType=heliMeshTypes[math.random(#heliMeshTypes)]
  --      GameObject.SendCommand( heliObjectId, { id = "SetMeshType", typeName = meshType, } )

  InfMain.RandomSetToLevelSeed()
  local heliColorType
  if Ivars.mbEnemyHeliColor:Is"RANDOM" then
    heliColorType=math.random(0,2)
  elseif Ivars.mbEnemyHeliColor:Is()>0 then
    heliColorType=this.GetEnemyHeliColor()
  end
  InfMain.RandomResetToOsTime()

  for n=1,#this.heliList do
    local heliName=this.heliList[n]
    local heliObjectId = GetGameObjectId(heliName)
    if heliObjectId==NULL_ID then
    --InfCore.DebugPrint(heliName.."==NULL_ID")--DEBUG, will trigger in battlegear hangar since it's a different pack --DEBUG
    else
      local typeIndex=GetTypeIndex(heliObjectId)
      if typeIndex==TppGameObject.GAME_OBJECT_TYPE_ENEMY_HELI then
        if isMb and Ivars.mbEnemyHeli:Is(0) then
          SendCommand(heliObjectId,{id="SetEyeMode",mode="Close"})
          SendCommand(heliObjectId,{id="SetRestrictNotice",enabled=true})
          SendCommand(heliObjectId,{id="SetCombatEnabled",enabled=false})
          --TppMarker2System.DisableMarker{gameObjectId=heliObjectId}
        end

        if Ivars.mbEnemyHeliColor:Is"RANDOM_EACH" then
          heliColorType=math.random(0,2)
        end

        if heliColorType~=nil then
          SendCommand(heliObjectId,{id="SetColoring",coloringType=heliColorType,fova=this.heliColors[heliColorType].fova})
        end
      end
    end
  end

  InfCore.PrintInspect(this.heliList,{varName="InfNPCHeli.heliList"})--DEBUG
end

function this.OnMissionCanStart(currentChecks)
  if not IvarProc.EnabledForMission(heliPatrolsStr) then
    return
  end
  local isMb=vars.missionCode==30050
  --tex set up lz info
  if isMb then
  --tex done in mtbs_cluster.SetUpLandingZone
  else
    local locationName=InfUtil.GetLocationName()
    this.enabledLzs=this.heliRoutes[locationName]
    routesBag=InfUtil.ShuffleBag:New(this.enabledLzs)
  end
  --InfCore.PrintInspect(this.enabledLzs)--DEBUG
  --this.SetRoutes()
end

function this.OnReload(missionTable)
  this.messageExecTable=nil

  if not IvarProc.EnabledForMission(heliPatrolsStr) then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="StartedPullingOut",func=function()
        --InfCore.DebugPrint("StartedPullingOut")--DEBUG
        --this.heliSelectClusterId=nil
        end}
    },
    Terminal={
      {msg="MbDvcActSelectLandPoint",func=function(nextMissionId,routeName,layoutCode,clusterId)
        --InfCore.DebugPrint("MbDvcActSelectLandPoint:"..tostring(InfLookup.str32LzToLz[routeName]).. " "..tostring(clusterId))--DEBUG
        this.heliSelectClusterId=clusterId
      end},
      {msg="MbDvcActSelectLandPointTaxi",func=function(nextMissionId,routeName,layoutCode,clusterId)
        --InfCore.DebugPrint("MbDvcActSelectLandPointTaxi:"..tostring(routeName).. " "..tostring(clusterId))--DEBUG
        this.heliSelectClusterId=clusterId
      end},
    },
  }
end

function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end


local searchLightOn={id="SetSearchLightForcedType",type="On"}
local searchLightOff={id="SetSearchLightForcedType",type="On"}
local nightCheckTime=0
local nightCheckMax=20

function this.Update(currentChecks,currentTime,execChecks,execState)
  --InfCore.PCall(function(currentChecks,currentTime,execChecks,execState)--DEBUG
  if not currentChecks.inGame then
    return
  end

  if not IvarProc.EnabledForMission(heliPatrolsStr) then
    return
  end

  if this.heliList==nil or #this.heliList==0 then
    --InfCore.DebugPrint"UpdateNPCHeli: helilist empty"--DEBUG
    return
  end

  --tex don't start til ready
  if this.enabledLzs==nil or #this.enabledLzs==0 then
    --InfCore.DebugPrint"enabledLzs empty"--DEBUG
    return
  end

  --LOCALOPT:
  local TppMath=TppMath
  local math=math
  local vars=vars
  local mvars=mvars
  local SendCommand=GameObject.SendCommand
  local InfLZ=InfLZ

  local isMb=vars.missionCode==30050
  local locationName=InfUtil.locationNames[vars.locationCode]

  local elapsedTime=Time.GetRawElapsedTimeSinceStartUp()
  local isNight=WeatherManager.IsNight()
  local heliRouteIds=this.heliRouteIds
  for heliIndex=1,#this.heliList do
    local heliName=this.heliList[heliIndex]
    local heliObjectId = GetGameObjectId(heliName)
    if heliObjectId==NULL_ID then
    --InfCore.DebugPrint(heliName.."==NULL_ID")--DEBUG
    else

      --CULL
      --      if nightCheckTime<elapsedTime then
      --        nightCheckTime=elapsedTime+nightCheckMax+math.random(3)
      --
      --        if isNight then--tex manual searchligh, don't know why they dont come on during approach route, they do with other routes
      --        -- doesn't seem to work for TppOtherHeli anyway, and Enemy manages to do it itself
      --          SendCommand(heliObjectId,searchLightOn)
      --        else
      --          SendCommand(heliObjectId,searchLightOff)
      --        end
      --      end

      --tex TODO: rate limit or set on a msg timerh
      if not isMb then
        local routeEnd=InfLZ.GetGroundStartPosition(heliRouteIds[heliIndex])
        routeEnd=routeEnd and routeEnd.pos or nil
        if routeEnd==nil and heliRouteIds[heliIndex]~=nil then
        --InfCore.DebugPrint("routeCenter==nil")--DEBUG
        else
          local heliPos=SendCommand(heliObjectId,{id="GetPosition"})
          if heliPos==nil then
          --InfCore.DebugPrint("heliPos==nil")--DEBUG
          else
            heliPos={heliPos:GetX(),heliPos:GetY(),heliPos:GetZ()}
            local distSqr=TppMath.FindDistance(heliPos,routeEnd)

            local routeInfo=routeInfos[locationName][heliRouteIds[heliIndex]]
            local approachDist=700
            if distSqr<approachDist*approachDist and not heliOnApproach[heliIndex] then--tex getting close, don't bail now
              heliOnApproach[heliIndex]=true
              heliTimes[heliIndex]=elapsedTime+math.random(routeTimeMin,routeTimeMax)
            end
            if routeInfo.stickDistance and distSqr<routeInfo.stickDistance then
              heliTimes[heliIndex]=0
            elseif routeInfo.arrivedDistance and distSqr<routeInfo.arrivedDistance then
              --InfCore.DebugPrint(n.." "..heliName.." arrived for route: "..tostring(InfLookup.str32LzToLz[heliRouteIds[n]]))--DEBUG
              heliTimes[heliIndex]=elapsedTime+math.random(routeInfo.exitTime[1],routeInfo.exitTime[2])
            end

            if distSqr<closestDistance[heliIndex] then--DEBUG
              closestDistance[heliIndex]=distSqr
            end

            --InfCore.DebugPrint("routepos:")
            --InfCore.PrintInspect(routeCenter)
            --InfCore.DebugPrint("helipos:".. heliPos[1]..",".. heliPos[2].. ","..heliPos[3].." distsqr:"..distSqr.. " closestdist:"..closestDistance)--DEBUG

            --TODO
            --            local closestCp,cpDistance,cpPosition=InfMain.GetClosestCp(heliPos)
            --            if closestCp==nil then
            --            else
            --              SendCommand(heliObjectId,{id="SetCommandPost",cp=closestCp})
            --            end
          end
        end
      end

      --tex TODO set cp to nearest, possibly on second timer so it's not hitting it up every frame

      --tex choose new route
      if heliTimes[heliIndex]<elapsedTime then
        if isMb then
          heliTimes[heliIndex]=elapsedTime+math.random(routeTimeMbMin,routeTimeMbMax)
        else
          heliTimes[heliIndex]=elapsedTime+math.random(routeTimeMin,routeTimeMax)
        end

        local heliRoute=nil

        if isMb then
          heliRoute=this.UpdateHeliMB(heliObjectId,heliIndex,heliRouteIds)
        else
          heliRoute=routesBag:Next()
          heliRoute=StrCode32(heliRoute)

          heliRouteIds[heliIndex]=heliRoute
          local groundStartPosition=InfLZ.GetGroundStartPosition(heliRoute)
          if groundStartPosition then
            heliOnApproach[heliIndex]=false
            closestDistance[heliIndex]=9999999999997--DEBUG
          end
        end

        if heliRoute then
          SendCommand(heliObjectId,{id="SetForceRoute",route=heliRoute})
          --SendCommand(heliObjectId,{id="SetForceRoute",route=heliRoute,point=0,warp=true})
          --SendCommand(heliObjectId,{id="SetLandingZnoeDoorFlag",name="heliRoute",leftDoor="Close",rightDoor="Close"})

          --InfCore.DebugPrint(n.." "..heliName.." route: "..tostring(InfLookup.str32LzToLz[heliRouteIds[n]]))--DEBUG
        end
        -- is > heliTime--<
      end

      --not NULL_ID<
    end
    --for heliname<
  end
  --end,currentChecks,currentTime,execChecks,execState)--DEBUG
end


--IN-SIDE heliRouteIds
function this.UpdateHeliMB(heliObjectId,heliIndex,heliRouteIds)
  local prevCluster=heliRouteIds[heliIndex]--DEBUG
  local clusterId=this.ChooseRandomHeliCluster(heliRouteIds,heliTimes,this.heliSelectClusterId)
  heliRouteIds[heliIndex]=clusterId

  --        local clusterTime=heliTimes[n]-elapsedTime--DEBUG
  --        InfCore.DebugPrint(n.." "..heliName .. " from ".. tostring(TppDefine.CLUSTER_NAME[prevCluster]) .." to cluster ".. tostring(TppDefine.CLUSTER_NAME[clusterId]) .. " for "..clusterTime)--DEBUG

  if mvars.mbSoldier_clusterParamList and mvars.mbSoldier_clusterParamList[clusterId] then
    local clusterParam=mvars.mbSoldier_clusterParamList[clusterId]
    local cpId=GetGameObjectId("TppCommandPost2",clusterParam.CP_NAME)
    if cpId==NULL_ID then
      InfCore.Log("cpId "..clusterParam.CP_NAME.."==NULL_ID ")
    else
      SendCommand(heliObjectId,{id="SetCommandPost",cp=clusterParam.CP_NAME})
    end
  end

  local clusterLzs=this.enabledLzs[clusterId]
  if clusterLzs and #clusterLzs>0 then
    local currentLandingZoneName=clusterLzs[math.random(#clusterLzs)]
    local nextLandingZoneName=clusterLzs[math.random(#clusterLzs)]
    if currentLandingZoneName and nextLandingZoneName then--tex may be nil on demos
      local heliTaxiSettings=mtbs_helicopter.RequestHeliTaxi(heliObjectId,StrCode32(currentLandingZoneName),StrCode32(nextLandingZoneName))
      if heliTaxiSettings then
        local currentClusterRoute=heliTaxiSettings.currentClusterRoute
        local relayRoute=heliTaxiSettings.relayRoute
        local nextClusterRoute=heliTaxiSettings.nextClusterRoute

        return currentClusterRoute
      else
        InfCore.DebugPrint("Warning: UpdateNPCHeli - no heliTaxiSettings for".. currentLandingZoneName .." ".. nextLandingZoneName)
      end
    end
  end
end

--DEBUG
function this.ClearHeliState()
  for n=1,#this.heliList do
    heliTimes[n]=0
    --heliClusters[n]=0
  end
end

function this.GetEnemyHeliColor()
  --tex: cant use BLACK_SUPER_REINFORCE/SUPER_REINFORCE since it's not inited when I need it.
  if Ivars.mbEnemyHeliColor:Is"ENEMY_PREP" then
    --tex alt tuning for combined stealth/combat average, but I think I like heli color tied to combat better thematically,
    --sure have them put more helis out if stealth level is high (see numAttackHelis), but only put beefier helis if your actually causing a ruckus
    --local level=InfMain.GetAverageRevengeLevel()
    --local levelToColor={0,0,1,1,2,2}--tex normally super reinforce(black,1) is combat 3,4, while super(red,2) is combat 5

    local level=TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)
    return levelToColor[level+1]
  end

  return Ivars.mbEnemyHeliColor:Get()
end

this.heliColors={
  [TppDefine.ENEMY_HELI_COLORING_TYPE.DEFAULT]={pack="",fova=""},
  [TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={pack="/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk",fova="/Assets/tpp/fova/mecha/sbh/sbh_ene_blk.fv2"},
  [TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={pack="/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk",fova="/Assets/tpp/fova/mecha/sbh/sbh_ene_red.fv2"}
}

this.heliColorNames={
  "DEFAULT",
  "BLACK",
  "RED",
}
function this.GetEnemyHeliColorName()
  return this.heliColorNames[this.GetEnemyHeliColor()+1]
end

function this.ChooseRandomHeliCluster(heliClusters,heliTimes,supportHeliClusterId)
  local cohabitTimeLimit=60
  local blockClusters={}
  for n,heliCluster in ipairs(heliClusters)do
    if heliTimes[n]-Time.GetRawElapsedTimeSinceStartUp() > cohabitTimeLimit then
      blockClusters[heliCluster]=true
    end
  end

  if supportHeliClusterId then
  --OFF blockClusters[supportHeliClusterId]=true--tex TODO need to find an accurate way to get the cluster, or lz of a called in heli
  end

  local clusterPool={}

  for clusterId, clusterName in ipairs(TppDefine.CLUSTER_NAME) do
    local grade=TppMotherBaseManagement.GetMbsClusterGrade{category=TppDefine.CLUSTER_NAME[clusterId]}
    if grade>0 and not blockClusters[clusterId] then
      clusterPool[#clusterPool+1]=clusterId
    end
  end

  --tex no sure why this is happening, in invasion at least, maybe a bunch of helis stacking up on same cluster
  --so try again without block
  if #clusterPool==0 then
    --InfCore.DebugPrint"#clusterPool==0"--DEBUG
    for clusterId, clusterName in ipairs(TppDefine.CLUSTER_NAME) do
      local grade=TppMotherBaseManagement.GetMbsClusterGrade{category=TppDefine.CLUSTER_NAME[clusterId]}
      if grade>0 then
        clusterPool[#clusterPool+1]=clusterId
      end
    end
  end

  if #clusterPool==0 then
    --InfCore.DebugPrint"#clusterPool==0"--DEBUG
    return nil
  end

  return clusterPool[math.random(#clusterPool)]
end

--DEBUG
function this.SetRoute(heliRoute,heliIndex)
  this.heliRouteIds[heliIndex]=heliRoute
  local groundStartPosition=InfLZ.GetGroundStartPosition(heliRoute)
  if groundStartPosition then
    InfCore.DebugPrint("found ground posisiton")--DEBUG
    closestDistance[heliIndex]=9999999999998--DEBUG
  else
    InfCore.DebugPrint("!!no ground posisiton")--DEBUG
  end


  local heliName=this.heliList[heliIndex]
  local heliObjectId = GetGameObjectId(heliName)
  if heliObjectId==NULL_ID then
  --InfCore.DebugPrint(heliName.."==NULL_ID")--DEBUG
  else

    if heliRoute then
      SendCommand(heliObjectId,{id="SetSneakRoute",route=heliRoute,point=0,warp=true})--DEBUG
      InfCore.DebugPrint(heliIndex.." "..heliName.." route: "..tostring(InfLookup.str32LzToLz[heliRoute]))--DEBUG
    end
  end
end

--DEBUG
function this.ClearRoute(heliIndex)
  local route=nil

  local heliName=this.heliList[heliIndex]
  local heliObjectId = GetGameObjectId(heliName)
  if heliObjectId==NULL_ID then
  --InfCore.DebugPrint(heliName.."==NULL_ID")--DEBUG
  else
    --SendCommand(heliObjectId,{id="SetForceRoute",route=route})--DEBUG
    SendCommand(heliObjectId,{id="SetSneakRoute",route=route})
    SendCommand(heliObjectId,{id="SetCautionRoute",route=route})
    SendCommand(heliObjectId,{id="SetAlertRoute",route=route})
    InfCore.DebugPrint(heliIndex.." "..heliName.." clearroute")--DEBUG
  end
end

function this.PrintHeliPos()
  for heliIndex,heliName in ipairs(this.heliList)do
    local heliObjectId = GetGameObjectId(heliName)
    if heliObjectId==NULL_ID then
    --InfCore.DebugPrint(heliName.."==NULL_ID")--DEBUG
    else

      --tex TODO: rate limit or set on a msg timer
      local routeCenter=heliRouteIds[heliIndex]
      if routeCenter==nil then
        InfCore.DebugPrint("routeCenter==nil")--DEBUG
      else
        local heliPos=GameObject.SendCommand(heliObjectId,{id="GetPosition"})
        if heliPos==nil then
          InfCore.DebugPrint("heliPos==nil")--DEBUG
        else
          heliPos={heliPos:GetX(),heliPos:GetY(),heliPos:GetZ()}
          local distSqr=TppMath.FindDistance(heliPos,routeCenter.pos)
          --InfCore.DebugPrint("routepos:")
          --InfCore.PrintInspect(routeCenter)

          --InfCore.DebugPrint("helipos:".. heliPos[1]..",".. heliPos[2].. ","..heliPos[3])
          InfCore.DebugPrint(heliIndex.." "..heliName.." route: "..tostring(InfLookup.str32LzToLz[this.heliRouteIds[heliIndex]]))
          InfCore.DebugPrint("distsqr:"..distSqr .. " closestdist:"..closestDistance)
        end
      end
    end
  end
end

return this
