-- InfNPC.lua
-- tex implements soldier route changes on MB, and extra soldier loading
-- Ivars - mbAdditionalSoldiers, mbNpcRouteChange
local this={}

--LOCALOPT
local InfMain=InfMain
local StrCode32=Fox.StrCode32
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local Random=math.random

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
      --{msg = "MotherBaseCurrentClusterLoadStart",func=this.MotherBaseCurrentClusterLoadStart},
      {msg = "MotherBaseCurrentClusterActivated",func=this.MotherBaseCurrentClusterActivated},
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

  local clusterId=clusterId or MotherBaseStage.GetCurrentCluster()
  clusterId=clusterId+1

  --local clusterName=TppDefine.CLUSTER_NAME[clusterId]

  local GetMBEnemyAssetTable=TppEnemy.GetMBEnemyAssetTable or mvars.mbSoldier_funcGetAssetTable
  if GetMBEnemyAssetTable==nil then
    return
  end
  local grade=TppLocation.GetMbStageClusterGrade(clusterId)

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
  
  local clusterId=MotherBaseStage.GetCurrentCluster()+1
  local grade=TppLocation.GetMbStageClusterGrade(clusterId)
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

--STATE
this.reserveSoldierNames=nil
this.soldierPool=nil

--caller: mtbs_enemy.OnLoad
--IN/OUT: mb layout lua (ex ly003) .enemyAssetTable (via TppEnemy.GetMBEnemyAssetTable or mvars.mbSoldier_funcGetAssetTable)
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

return this
