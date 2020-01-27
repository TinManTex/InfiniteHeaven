-- InfNPC.lua
-- tex implements soldier additions/modificationa and route changes on MB
-- Ivars: vehiclePatrolProfile, enableLrrpFreeRoam, enableWildCardFreeRoam, mbAdditionalSoldiers, mbNpcRouteChange
local this={}

--LOCALOPT
local InfLog=InfLog
local InfMain=InfMain
local StrCode32=Fox.StrCode32
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local Random=math.random

local GetCurrentCluster=MotherBaseStage.GetCurrentCluster
local GetMbStageClusterGrade=TppLocation.GetMbStageClusterGrade

this.debugModule=false

--updateState
this.active=Ivars.mbNpcRouteChange
this.execCheckTable={inGame=true,inHeliSpace=false}
this.execState={
  nextUpdate=0,
}
--tex seconds
local updateMin=30
local updateMax=80

-- command plat salutation routes
--TODO: add to routeForPlat,platForRoute if currentcluster is 1/command.
--
--        {
--          "ly003_cl00_route0000|cl00pl0_mb_fndt_plnt_free|rt_free_h_0000",
--          "ly003_cl00_route0000|cl00pl0_mb_fndt_plnt_free|rt_free_h_0001",
--          "ly003_cl00_route0000|cl00pl0_mb_fndt_plnt_free|rt_free_h_0002",
--          "ly003_cl00_route0000|cl00pl0_mb_fndt_plnt_free|rt_free_h_0003",
--        },
--
--        {
--          "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_h_0000",
--          "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_h_0001",
--        },

--STATE
local npcList={}
local npcPlats={}
local npcRoutes={}

local routesForPlat={}
local platForRoute={}

local numSoldiersOnRoute={}
local numSoldiersOnPlat={}

local mbDemoWasPlayed=false

--TUNE
local maxSoldiersOnSameRoute=2
local maxSoldiersPerPlat=12--SYNC with plat counts, and keep in mind max instace count

local plntPrefix="plnt"

--
--STATE
--DEBUGNOW
--mvars.ene_wildCardSoldiers={}
--mvars.ene_femaleWildCardSoldiers={}
--mvars.ene_wildCardCps={}

this.packages={
  "/Assets/tpp/pack/mission2/ih/ih_soldier_loc_mb.fpk"--tex still relies on totalCount in f30050_npc.fox2
}

function this.AddMissionPacks(missionCode,packPaths)
  if not this.active:EnabledForMission() then
    return
  end

  for i,packPath in ipairs(this.packages) do
    packPaths[#packPaths+1]=packPath
  end
end

function this.Init(missionTable)
  if not Ivars.mbAdditionalSoldiers:EnabledForMission() then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  this.InitCluster()
end

function this.OnReload(missionTable)
  if not this.active:EnabledForMission() then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.Messages()
  return Tpp.StrCode32Table{
    MotherBaseStage={
      --{msg="MotherBaseCurrentClusterLoadStart",func=this.MotherBaseCurrentClusterLoadStart},
      {msg="MotherBaseCurrentClusterActivated",func=this.MotherBaseCurrentClusterActivated},
    },
  }
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  if not this.active:EnabledForMission() then
    return
  end

  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this.MotherBaseCurrentClusterActivated(clusterId)
  this.InitCluster(clusterId)
end

function this.InitCluster(clusterId)
  --InfLog.PCall(function(clusterId)--DEBUG
  if vars.missionCode~=30050 then
    return
  end

  mbDemoWasPlayed=false

  npcList={}
  npcPlats={}
  npcRoutes={}

  routesForPlat={}
  platForRoute={}

  numSoldiersOnPlat={}
  numSoldiersOnRoute={}

  local isRouteChange=Ivars.mbNpcRouteChange:Is(1)

  local clusterId=clusterId or GetCurrentCluster()
  clusterId=clusterId+1

  --local clusterName=TppDefine.CLUSTER_NAME[clusterId]

  local GetMBEnemyAssetTable=TppEnemy.GetMBEnemyAssetTable or mvars.mbSoldier_funcGetAssetTable
  if GetMBEnemyAssetTable==nil then
    return
  end
  local grade=GetMbStageClusterGrade(clusterId)

  --tex loading an unbuilt cluster probbably doesnt happen anyway lol
  if grade==0 then
    return
  end

  for platIndex=1,grade do
    numSoldiersOnPlat[platIndex]=0

    local clusterAssetTable=GetMBEnemyAssetTable(clusterId)
    local platName=plntPrefix..(platIndex-1)

    local platInfo=clusterAssetTable[platName]

    local sneakRoutes=platInfo.soldierRouteList.Sneak[1].inPlnt
    local nightRoutes=platInfo.soldierRouteList.Night[1].inPlnt
    local cautionRoutes=platInfo.soldierRouteList.Caution[1].inPlnt

    --tex mb doesn't have caution routes by default, should be fine to patch without user action since they wouldn't be used normally
    if #cautionRoutes then
      for i=1,#sneakRoutes do
        --tex TODO: random selection of day/night
        cautionRoutes[i]=sneakRoutes[i]
      end
    end

    if isRouteChange then
      local soldierList=platInfo.soldierList
      for j=1,#soldierList do
        local npcName=soldierList[j]
        local gameId=GetGameObjectId(npcName)
        if gameId==NULL_ID then
          InfLog.Add(npcName.." not found")--DEBUG
        else
          local newIndex=#npcList+1
          npcList[newIndex]=npcName
          npcPlats[newIndex]=platIndex
          numSoldiersOnPlat[platIndex]=numSoldiersOnPlat[platIndex]+1
        end
      end

      local platRoutes={}
      routesForPlat[platIndex]=platRoutes

      local routes=sneakRoutes
      for n,routes in ipairs({sneakRoutes,nightRoutes})do
        for i=1,#routes do
          local route=routes[i]
          platRoutes[#platRoutes+1]=route
          platForRoute[route]=platIndex
          numSoldiersOnRoute[route]=0--tex TODO: initial soldier route assignemnt is not accounted for, it seems like routes for mb are just assigned soldierlist index>route list index, but not totally sure
        end
      end
      --<isRouteChange
    end
    --<for plats
  end
  --end,clusterId)--DEBUG
end

function this.Update(currentChecks,currentTime,execChecks,execState)
  --InfLog.PCall(function(currentChecks,currentTime,execChecks,execState)--DEBUG
  if not currentChecks.inGame then
    return
  end

  if not this.active:MissionCheck() then
    return
  end

  local demoName=TppDemo.GetMBDemoName()
  if demoName then
    mbDemoWasPlayed=true
    return
  end

  if #npcList==0 then
    --InfLog.DebugPrint"Update #npcList==0 aborting"--DEBUG
    return
  end

  local clusterId=GetCurrentCluster()+1
  local grade=GetMbStageClusterGrade(clusterId)
  if grade==1 then
    return
  end

  local npcIndex=Random(1,#npcList)
  local npcName=npcList[npcIndex]

  local gameId=GetGameObjectId(npcName)
  if gameId==NULL_ID then
    InfLog.Add(npcName.." not found")--DEBUG
    return
  end

  local previousPlat=npcPlats[npcIndex]

  local availablePlats={}
  for i=1,grade do
    if numSoldiersOnPlat[i]<maxSoldiersPerPlat and i~=previousPlat then
      availablePlats[#availablePlats+1]=i
    end
  end

  local platIndex=1
  if #availablePlats>0 then
    platIndex=availablePlats[Random(#availablePlats)]
  else
    --InfLog.DebugPrint"#availablePlats==0"--DEBUG
    platIndex=Random(1,grade)
    --return--CULL
  end

  if previousPlat then
    numSoldiersOnPlat[previousPlat]=numSoldiersOnPlat[previousPlat]-1
  end
  npcPlats[npcIndex]=platIndex

  local platRoutes=routesForPlat[platIndex]
  local routeIdx=Random(#platRoutes)
  local route=platRoutes[routeIdx]
  --GOTCHA possible inf loop if #route on plat * maxSoldiersOnSameRoute < maxSoldiersPerPlat
  --InfLog.DebugPrint("#platRoutes:"..#platRoutes.." * maxSoldiersOnSameRoute="..(#platRoutes*maxSoldiersOnSameRoute).." maxSoldiersPerPlat:"..maxSoldiersPerPlat)--DEBUG
  if #platRoutes*maxSoldiersOnSameRoute < maxSoldiersPerPlat then
    InfLog.DebugPrint"InfNPC:Update - WARNING #platRoutes*maxSoldiersOnSameRoute < maxSoldiersPerPlat, aborting"--DEBUG
    return
  end

  while(numSoldiersOnRoute[route]>=maxSoldiersOnSameRoute)do
    routeIdx=Random(#platRoutes)
    route=platRoutes[routeIdx]
  end

  local lastRoute=npcRoutes[npcIndex]
  npcRoutes[npcIndex]=route

  if lastRoute then
    numSoldiersOnRoute[lastRoute]=numSoldiersOnRoute[lastRoute]-1
  end
  numSoldiersOnRoute[route]=numSoldiersOnRoute[route]+1

  --InfLog.DebugPrint(npcName .. " from plat "..tostring(lastPlat).." to plat "..platIndex.. " routeIdx ".. routeIdx .. " nextRouteTime "..nextRouteTime)--DEBUG
  local command={id="SetSneakRoute",route=route}
  SendCommand(gameId,command)
  local command={id="SwitchRoute",route=route}
  SendCommand(gameId,command)

  execState.nextUpdate=currentTime+Random(updateMin,updateMax)
  --end,currentChecks,currentTime,execChecks,execState)--DEBUG
end

--tex TODO, hook up to msg
function this.OnEliminated(soldierId)
--TODO: find index in npclist
--npcPlats[index] > decrease soldiersonplat,npcRoutes[index] decrease soldiersonroute
end

--tex additional soldiers:

--TUNE
-- CULL local additionalSoldiersPerPlat=5
local maxSoldiersOnPlat=9
this.numReserveSoldiers=140


this.soldierPool=nil

--caller: mtbs_enemy.OnLoad
--IN/OUT: mb layout lua (ex ly003) .enemyAssetTable (via TppEnemy.GetMBEnemyAssetTable or mvars.mbSoldier_funcGetAssetTable)
--tex adds extra soldiers,route names to mb cps
function this.ModifyEnemyAssetTable()
  --InfLog.PCall(function()--DEBUG
  if not Ivars.mbAdditionalSoldiers:EnabledForMission() then
    return
  end

  this.reserveSoldierNames=InfMain.BuildReserveSoldierNames(this.numReserveSoldiers,this.reserveSoldierNames)
  this.soldierPool=InfMain.ResetPool(this.reserveSoldierNames)

  local GetMBEnemyAssetTable=TppEnemy.GetMBEnemyAssetTable or mvars.mbSoldier_funcGetAssetTable

  local plntPrefix="plnt"
  for clusterId=1,#TppDefine.CLUSTER_NAME do
    --local clusterName=TppDefine.CLUSTER_NAME[clusterId]
    local totalPlatsRouteCount=0--DEBUG
    local soldierCountFinal=0

    local grade=TppLocation.GetMbStageClusterGrade(clusterId)
    if grade>0 then
      for i=1,grade do
        local clusterAssetTable=GetMBEnemyAssetTable(clusterId)
        local platName=plntPrefix..(i-1)

        local platInfo=clusterAssetTable[platName]

        local soldierList=platInfo.soldierList
        --        if clusterId==mtbs_cluster.GetCurrentClusterId() then--DEBUG>
        --        InfLog.DebugPrint("cluster "..clusterId.. " "..platName.." #soldierListpre "..#soldierList)--DEBUG
        --        end--<

        local sneakRoutes=platInfo.soldierRouteList.Sneak[1].inPlnt
        local nightRoutes=platInfo.soldierRouteList.Night[1].inPlnt

        local addedRoutes=false
        for i=1,#sneakRoutes do
          if sneakRoutes[i]==nightRoutes[1] then
            addedRoutes=true
            break
          end
        end
        if not addedRoutes then
          for i=1,#nightRoutes do
            sneakRoutes[#sneakRoutes+1]=nightRoutes[i]
          end
          for i=1,#sneakRoutes do
            nightRoutes[#nightRoutes+1]=sneakRoutes[i]
          end
        end

        local minRouteCount=math.min(#sneakRoutes,#nightRoutes)
        --OFF totalPlatsRouteCount=totalPlatsRouteCount+minRouteCount --DEBUG

        --CULL local numToAdd=math.min((minRouteCount-3)-#soldierList,additionalSoldiersPerPlat)--tex MAGIC this only really affects main plats which only have 12(-6soldiers) routes (with combined sneak/night). Rest have 15+
        local numToAdd=maxSoldiersOnPlat-#soldierList
        if numToAdd>0 then
          InfMain.FillList(numToAdd,this.soldierPool,soldierList)
        end
        soldierCountFinal=soldierCountFinal+#soldierList
        --        if clusterId==mtbs_cluster.GetCurrentClusterId() then--DEBUG>
        --          local totalRouteCount=#sneakRoutes+#nightRoutes
        --          InfLog.DebugPrint("cluster "..clusterId.. " "..platName.. " minRouteCount "..minRouteCount.." totalRouteCount "..totalRouteCount.." numToAdd "..numToAdd.." #soldierList "..#soldierList)--DEBUG
        --          --InfLog.PrintInspect(soldierList)--DEBUG
        --        end--<
      end
    end

    --InfLog.DebugPrint(string.format("cluster:%d routeCount:%d soldierCountFinal:%d",clusterId,routeCount,soldierCountFinal))--DEBUG
  end
  --InfLog.DebugPrint("#this.soldierPool:"..#this.soldierPool)--DEBUG
  --end)--
end

--IN/OUT soldierPool,soldierDefine
--IN-SIDE: mvars.inf_patrolVehicleInfo
--tex adjusts soldiers assigned to lrrp vehicles
--DEBUGNOW TODO TEST, soldierDefine looks ok, but verify soldier counts on vehicles correct, also that vehicles are changing and convoys work
function this.ModifyVehiclePatrolSoldiers(soldierPool,soldierDefine,soldiersAssigned)
  if not Ivars.vehiclePatrolProfile:EnabledForMission() then
    return
  end

  if InfMain.IsContinue() then
    return
  end

  InfMain.RandomSetToLevelSeed()

  local seatChanges={}--DEBUG

  local initPoolSize=#soldierPool
  for cpName,cpDefine in pairs(soldierDefine)do

    local numCpSoldiers=0
    for n=1,#cpDefine do
      if cpDefine[n] then
        numCpSoldiers=numCpSoldiers+1
      end
    end

    if cpDefine.lrrpVehicle then
      --tex figure out how many soldiers for the vehicle
      local numSeats=2
      if mvars.inf_patrolVehicleInfo then
        local vehicleInfo=mvars.inf_patrolVehicleInfo[cpDefine.lrrpVehicle]
        if vehicleInfo then
          local baseTypeInfo=InfVehicle.vehicleBaseTypes[vehicleInfo.baseType]
          if baseTypeInfo then
            numSeats=math.random(math.min(numSeats,baseTypeInfo.seats),baseTypeInfo.seats)
            --InfLog.DebugPrint(cpDefine.lrrpVehicle .. " numVehSeats "..numSeats)--DEBUG
          end
        end
      end
      --
      local seatDelta=numSeats-numCpSoldiers
      seatChanges[cpDefine.lrrpVehicle]=seatDelta--DEBUGNOW
      --DEBUG
      --      local isConvoy=false
      --      for travelPlan,convoyVehicles in pairs(mvars.inf_patrolVehicleConvoyInfo) do
      --        for i,vehicleName in ipairs(convoyVehicles)do
      --          if cpDefine.lrrpVehicle==vehicleName then
      --            InfLog.DebugPrint(vehicleName .." seatDelta "..seatDelta .. " #soldierPool "..#soldierPool)
      --            isConvoy=true
      --            break
      --          end
      --        end
      --      end
      --<DEBUG
      if seatDelta<0 then--tex over filled
        --tex back into soldierPool
        InfMain.FillList(-seatDelta,cpDefine,soldierPool)
      elseif seatDelta>0 then--tex under filled
        --tex add soldiers
        local soldiersAdded=InfMain.FillList(seatDelta,soldierPool,cpDefine)
        for i,soldierName in ipairs(soldiersAdded)do
          soldiersAssigned[soldierName]=true
        end
        --        if isConvoy then--DEBUG
        --          InfLog.PrintInspect(soldiersAdded)
        --        end--
      end
      --if lrrpVehicle<
    end
    --for soldierdefine<
  end

  InfMain.RandomResetToOsTime()

  if this.debugModule then
    local poolChange=initPoolSize-#soldierPool--DEBUG
    InfLog.Add("ModifyVehiclePatrolSoldiers #soldierPool:"..#soldierPool.." pool change:"..poolChange)
    InfLog.PrintInspect(soldierPool)
    InfLog.Add"seatChanges"
    InfLog.PrintInspect(seatChanges)
  end
end

--IN/OUT soldierPool,soldierDefine,travelPlans
--OUT: lrrpDefines
--tex sets up lrrp foot patrols between bases
function this.AddLrrps(soldierPool,soldierDefine,travelPlans,lrrpDefines)
  if not Ivars.enableLrrpFreeRoam:EnabledForMission() then
    return
  end

  InfMain.RandomSetToLevelSeed()

  --tex TODO clear instead of new
  lrrpDefines={}

  --tex find empty cps to use for lrrps
  local cpPool=InfMain.BuildLrrpVehicleCpPool(soldierDefine)

  local planStr="travelIH_"

  local reserved=0--6
  --tex OFF
  --  local minSize=Ivars.lrrpSizeFreeRoam_MIN:Get()
  --  local maxSize=Ivars.lrrpSizeFreeRoam_MAX:Get()
  --  if maxSize>#soldierPool then
  --    maxSize=#soldierPool
  --  end
  local numLrrps=0--DEBUG

  local baseNameBag=InfMain.ShuffleBag:New()
  local locationName=InfMain.GetLocationName()
  local baseNames=InfMain.baseNames[locationName]
  for n,cpName in pairs(baseNames)do
    local cpDefine=soldierDefine[cpName]
    if cpDefine==nil then
    --InfLog.DebugPrint(tostring(cpName).." cpDefine==nil")--DEBUG
    else
      local cpId=GetGameObjectId("TppCommandPost2",cpName)
      if cpId==NULL_ID then
        InfLog.DebugPrint("baseNames "..tostring(cpName).." cpId==NULL_ID")--DEBUG
      else
        baseNameBag:Add(cpName)
      end
    end
  end

  --InfLog.DebugPrint("#baseNameBag:"..baseNameBag:Count())--DEBUG

  --tex one lrrp per two bases (start at one, head to next) is a nice target for num of lrrps, but lrrp cps or soldiercount may run out first
  while #soldierPool-reserved>0 do
    --tex the main limiter, available empty cps to use for lrrps
    if #cpPool==0 then
      --InfLog.DebugPrint"#cpPool==0"--DEBUG
      break
    end
    if #soldierPool==0 then
      --InfLog.DebugPrint"#soldierPool==0"--DEBUG
      break
    end

    local lrrpSize=2 --TUNE WIP custom lrrp size OFF to give coverage till I can come up with something better math.random(minSize,maxSize)
    --tex TODO: stop it from eating reserved
    --InfLog.DebugPrint("lrrpSize "..lrrpSize)--DEBUG

    local cpName=cpPool[#cpPool]
    cpPool[#cpPool]=nil

    --InfLog.DebugPrint("cpName:"..tostring(cpName))--DEBUG

    local cpDefine={}
    soldierDefine[cpName]=cpDefine--tex GOTCHA clearing the cp here, wheres in AddWildCards we are modding existing

    InfMain.FillList(lrrpSize,soldierPool,cpDefine)

    local planName=planStr..cpName
    cpDefine.lrrpTravelPlan=planName
    local base1=baseNameBag:Next()
    local base2=baseNameBag:Next()
    travelPlans[planName]={
      {base=base1},
      {base=base2},
    }
    --tex info for interrog
    local lrrpDefine={
      cpDefine=cpDefine,
      base1=base1,
      base2=base2,
    }
    lrrpDefines[#lrrpDefines+1]=lrrpDefine

    numLrrps=numLrrps+1
  end
  --  InfLog.DebugPrint("num lrrps"..numLrrps)--DEBUG
  --  InfLog.DebugPrint("#soldierPool:"..#soldierPool)--DEBUG
  --  InfLog.DebugPrint("#cpPool:"..#cpPool)--DEBUG

  --Fill rest. can just do straight cpDefine order since they're build randomly anyway
  if #soldierPool>0 then
    for cpName,cpDefine in pairs(soldierDefine)do
      local cpId=GetGameObjectId("TppCommandPost2",cpName)
      if cpId==NULL_ID then
      else
        if cpDefine.lrrpTravelPlan and not cpDefine.lrrpVehicle then
          InfMain.FillList(1,soldierPool,cpDefine)
        end
      end
    end
  end

  InfMain.RandomResetToOsTime()

  if this.debugModule then
  InfLog.Add"InfMain.lrrpDefines"
  InfLog.PrintInspect(lrrpDefines)
  end
end

local function FaceIsFemale(faceId)
  local isFemale=TppSoldierFace.CheckFemale{face={faceId}}
  return isFemale and isFemale[1]==1
end

this.MAX_WILDCARD_FACES=16
--TUNE:
--afgh has ~39 cps, mafr ~33
this.numWildCards=10--tex limit TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT=16
this.numWildCardFemales=5

local wildCardSubTypes={
  afgh="SOVIET_WILDCARD",
  mafr="PF_WILDCARD",
}

local gearPowers={
  "HELMET",
  "SOFT_ARMOR",
  "GUN_LIGHT",
  "NVG",
--"GAS_MASK",
}
local weaponPowers={
  "ASSAULT",
  "SMG",
  "SHOTGUN",
  "MG",
  "SNIPER",
--"MISSILE",
}

--ASSUMPTION, ordered after vehicle cpdefines have been modified
--IN/OUT: soldierPool,soldierDefine,soldierTypes,soldierSubTypes,soldierPowerSettings,soldierPersonalAbilitySettings
--IN-SIDE: InfEneFova.inf_wildCardFemaleFaceList,InfEneFova.inf_wildCardMaleFaceList
--IN-SIDE: this.numWildCards,this.numWildCardFemales
--OUT-SIDE: mvars.ene_wildCardSoldiers, mvars.ene_femaleWildCardSoldiers, mvars.ene_wildCardCps
--tex sets up some soldiers of existing cps as wildcard soldiers
function this.AddWildCards(soldierPool,soldierDefine,soldierTypes,soldierSubTypes,soldierPowerSettings,soldierPersonalAbilitySettings)
  if not Ivars.enableWildCardFreeRoam:EnabledForMission() then
    return
  end

  local InfEneFova=InfEneFova
  if not InfEneFova.inf_wildCardFemaleFaceList or #InfEneFova.inf_wildCardFemaleFaceList==0  then
    InfLog.Add("AddWildCards InfEneFova.inf_wildCardFemaleFaceList not set up, aborting",true)
    return
  end
  if not InfEneFova.inf_wildCardMaleFaceList or #InfEneFova.inf_wildCardMaleFaceList==0  then
    InfLog.Add("AddWildCards InfEneFova.inf_wildCardMaleFaceList not set up, aborting",true)
    return
  end

  InfMain.RandomSetToLevelSeed()

  local reserved=0
  local numLrrps=0

  local baseNamePool=InfMain.BuildCpPoolWildCard(soldierDefine)

  local locationName=InfMain.GetLocationName()


  local wildCardSubType=wildCardSubTypes[locationName]or "SOVIET_WILDCARD"

  local weaponPowersBag=InfMain.ShuffleBag:New(weaponPowers)

  local abilityLevel="sp"
  local personalAbilitySettings={
    notice=abilityLevel,
    cure=abilityLevel,
    reflex=abilityLevel,
    shot=abilityLevel,
    grenade=abilityLevel,
    reload=abilityLevel,
    hp=abilityLevel,
    speed=abilityLevel,
    fulton=abilityLevel,
    holdup=abilityLevel
  }

  --TUNE:
  --tex GOTCHA LIMIT TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT=16
  --InfLog.DebugPrint("#baseNamePool:"..#baseNamePool)--DEBUG
  --this.numWildCards=math.max(1,math.ceil(#baseNamePool/4))--SYNC: MAX_WILDCARD_FACES
  --this.numWildCards=math.min(TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT,this.numWildCards)
  --tex shifted outside of function-- this.numWildCardFemales=math.max(1,math.ceil(numWildCards/2))--SYNC: MAX_WILDCARD_FACES
  --InfLog.Add("numwildcards: "..this.numWildCards .. " numFemale:"..this.numWildCardFemales)--DEBUG

  --  InfLog.DebugPrint"ene_wildCardFaceList"--DEBUG >
  --  InfLog.PrintInspect(InfEneFova.inf_wildCardFaceList)--<

  --tex TODO clear not new
  mvars.ene_wildCardSoldiers={}
  mvars.ene_femaleWildCardSoldiers={}
  mvars.ene_wildCardCps={}

  local numFemales=0
  local maleFaceIdPool=InfMain.ResetPool(InfEneFova.inf_wildCardMaleFaceList)
  local femaleFaceIdPool=InfMain.ResetPool(InfEneFova.inf_wildCardFemaleFaceList)
  --InfLog.DebugPrint("#maleFaceIdPool:"..#maleFaceIdPool.." #femaleFaceIdPool:"..#femaleFaceIdPool)--DEBUG

  for i=1,this.numWildCards do
    if #baseNamePool==0 then
      InfLog.DebugPrint"#baseNamePool==0"--DEBUG
      break
    end

    local cpName=InfMain.GetRandomPool(baseNamePool)
    local cpDefine=soldierDefine[cpName]
    mvars.ene_wildCardCps[#mvars.ene_wildCardCps+1]=cpName

    local soldierName=cpDefine[math.random(#cpDefine)]
    mvars.ene_wildCardSoldiers[#mvars.ene_wildCardSoldiers+1]=soldierName

    local isFemale=false
    if numFemales<this.numWildCardFemales then
      isFemale=true
      numFemales=numFemales+1
      mvars.ene_wildCardSoldiers[#mvars.ene_femaleWildCardSoldiers+1]=soldierName
    end

    --tex choose face
    local faceIdPool
    if isFemale then
      faceIdPool=femaleFaceIdPool
    else
      faceIdPool=maleFaceIdPool
    end
    if #faceIdPool==0 then
      InfLog.Add("#faceIdPool too small, aborting",true)--DEBUG
      break
    end
    local faceId=InfMain.GetRandomPool(faceIdPool)

    --tex choose body
    local bodyId=EnemyFova.INVALID_FOVA_VALUE
    if isFemale then
      local bodyInfo=InfEneFova.GetFemaleWildCardBodyInfo()
      if not bodyInfo or not bodyInfo.bodyId then
        InfLog.Add("WARNING no bodyinfo for wildcard",true)--DEBUG
      else
        bodyId=bodyInfo.bodyId
        if bodyId and type(bodyId)=="table"then
          bodyId=bodyId[math.random(#bodyId)]
        end
      end
    else
      local bodyTable=InfEneFova.wildCardBodyTable[locationName]
      bodyId=bodyTable[math.random(1,#bodyTable)]
    end

    --tex RegisterUniqueSetting face,body
    --tex GOTCHA LIMIT TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT
    local hasSetting=false
    local uniqueSettings=TppEneFova.GetUniqueSettings()
    for i=1,#uniqueSettings do
      if uniqueSettings[i].name==soldierName then
        hasSetting=true
        if isFemale and not FaceIsFemale(uniqueSettings[i].faceId) then
          InfLog.Add("WARNING: AddWildCards "..soldierName.." marked as female and uniqueSetting face not female",true)--DEBUG
        end
      end
    end
    if not hasSetting then
      TppEneFova.RegisterUniqueSetting("enemy",soldierName,faceId,bodyId)
    end

    local gameObjectId=GetGameObjectId("TppSoldier2",soldierName)
    if gameObjectId==NULL_ID then
      InfLog.DebugPrint"AddWildCards gameObjectId==NULL_ID"--DEBUG
    else
      local command={id="UseExtendParts",enabled=isFemale}
      SendCommand(gameObjectId,command)
    end

    --
    soldierSubTypes[wildCardSubType]=soldierSubTypes[wildCardSubType] or {}
    table.insert(soldierSubTypes[wildCardSubType],soldierName)

    local soldierPowers={}
    for n,power in pairs(gearPowers) do
      soldierPowers[#soldierPowers+1]=power
    end
    soldierPowers[#soldierPowers+1]=weaponPowersBag:Next()

    soldierPowerSettings[soldierName]=soldierPowers

    soldierPersonalAbilitySettings[soldierName]=personalAbilitySettings

    numLrrps=numLrrps+1
  end


  --DEBUG
  InfLog.Add"ene_wildCardSoldiers"
  InfLog.PrintInspect(mvars.ene_wildCardSoldiers)
  InfLog.Add"ene_femaleWildCardSoldiers"
  InfLog.PrintInspect(mvars.ene_femaleWildCardSoldiers)
  InfLog.Add"ene_wildCardCps"
  InfLog.PrintInspect(mvars.ene_wildCardCps)
  --  local uniqueSettings=TppEneFova.GetUniqueSettings()
  --  InfLog.Add"TppEneFova uniqueSettings"
  --  InfLog.PrintInspect(uniqueSettings)

  --InfLog.DebugPrint("numadded females:"..tostring(numFemales))--DEBUG

  --  --DEBUG
  --  for n,soldierName in pairs(mvars.ene_wildCardSoldiers)do
  --    InfLog.Add(soldierName)
  --    InfLog.PrintInspect(soldierPowerSettings[soldierName])
  -- end

  --InfLog.Add("num wildCards"..numLrrps)--DEBUG
  InfMain.RandomResetToOsTime()
end

return this
