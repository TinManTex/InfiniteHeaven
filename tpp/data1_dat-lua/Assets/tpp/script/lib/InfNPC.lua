-- DOBUILD: 1
--InfNPC.lua
local this={}

--LOCALOPT
local Ivars=Ivars
local InfMain=InfMain
local StrCode32=Fox.StrCode32
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local Random=math.random
--

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

local npcList={}
local npcPlats={}
local npcRoutes={}

local nextRouteTime=0

local routesForPlat={}
local platForRoute={}

local numSoldiersOnRoute={}
local numSoldiersOnPlat={}

local npcSetUp=false
local mbDemoWasPlayed=false

local plntPrefix="plnt"

local routeTimeMin=30
local routeTimeMax=80
local maxSoldiersOnSameRoute=2

local maxSoldiersPerPlat=12--SYNC with plat counts, and keep in mind max instace count

function this.Messages()
  return Tpp.StrCode32Table{
    MotherBaseStage={
      --{msg = "MotherBaseCurrentClusterLoadStart",func=this.MotherBaseCurrentClusterLoadStart},
      {msg = "MotherBaseCurrentClusterActivated",func=this.MotherBaseCurrentClusterActivated},
    },
  }
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  if TppMission.IsFOBMission(vars.missionCode)then
    return
  end

  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.Init(missionTable)
  if vars.missionCode~=30050 then
    return
  end
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.OnReload(missionTable)
  if vars.missionCode~=30050 then
    return
  end
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.MotherBaseCurrentClusterActivated(clusterId)
  this.InitCluster(clusterId)
end

function this.InitUpdate(currentChecks)
  this.InitCluster()
end

function this.InitCluster(clusterId)
  --InfInspect.TryFunc(function(clusterId)--DEBUG
  if vars.missionCode~=30050 then
    return
  end

  mbDemoWasPlayed=false
  npcSetUp=false

  npcList={}
  npcPlats={}
  npcRoutes={}

  routesForPlat={}
  platForRoute={}

  numSoldiersOnPlat={}
  numSoldiersOnRoute={}

  nextRouteTime=0

  if TppPackList.IsMissionPackLabel"BattleHanger"or TppDemo.IsBattleHangerDemo(TppDemo.GetMBDemoName())then
    return
  end

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
          InfMenu.DebugPrint(npcName.." not found")--DEBUG
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

function this.Update(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  --InfInspect.TryFunc(function(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)--DEBUG
    if not currentChecks.inGame then
      return
  end

  if vars.missionCode~=30050 then
    return
  end

  if Ivars.mbNpcRouteChange:Is(0) then
    return
  end

  local elapsedTime=Time.GetRawElapsedTimeSinceStartUp()
  local clusterId=MotherBaseStage.GetCurrentCluster()+1

  local demoName=TppDemo.GetMBDemoName()
  if demoName then
    mbDemoWasPlayed=true
    return
  end

  if #npcList==0 then
    --InfMenu.DebugPrint"Update #npcList==0 aborting"--DEBUG
    return
  end

  if not npcSetUp then
    npcSetUp=true

    nextRouteTime=elapsedTime+Random(7,10)--TODO magic

    for n=1,#npcList do
      local npcName=npcList[n]

      local gameId=GetGameObjectId(npcName)
      if gameId==NULL_ID then
      --InfMenu.DebugPrint("gameId==NULL_ID")
      else

      end
      --<for npc list
    end
    --<if not set up
  end

  if nextRouteTime<elapsedTime then
    nextRouteTime=elapsedTime+Random(routeTimeMin,routeTimeMax)

    local npcIndex=Random(1,#npcList)
    local npcName=npcList[npcIndex]

    local gameId=GetGameObjectId(npcName)
    if gameId==NULL_ID then
      InfMenu.DebugPrint(npcName.." not found")--DEBUG
      return
    end

    local grade=TppLocation.GetMbStageClusterGrade(clusterId)
    --local clusterAssetTable=TppEnemy.GetMBEnemyAssetTable(clusterId)

    local lastPlat=npcPlats[npcIndex]
    local platIndex=Random(1,grade)

    local tryCount=0
    while numSoldiersOnPlat[platIndex]>=maxSoldiersPerPlat or (platIndex==lastPlat and grade>1) do
      platIndex=Random(1,grade)

      tryCount=tryCount+1
--      if tryCount>grade*4 then
--        InfMenu.DebugPrint""--DEBUGNOW
--        break
--      end
    end


    if lastPlat then
      numSoldiersOnPlat[lastPlat]=numSoldiersOnPlat[lastPlat]-1
    end
    npcPlats[npcIndex]=platIndex

    local platRoutes=routesForPlat[platIndex]
    local routeIdx=Random(#platRoutes)
    local route=platRoutes[routeIdx]
    --GOTCHA possible inf loop if #route on plat * maxSoldiersOnSameRoute < maxSoldiersPerPlat
    --InfMenu.DebugPrint("#platRoutes:"..#platRoutes.." * maxSoldiersOnSameRoute="..(#platRoutes*maxSoldiersOnSameRoute).." maxSoldiersPerPlat:"..maxSoldiersPerPlat)--DEBUG
    if #platRoutes*maxSoldiersOnSameRoute < maxSoldiersPerPlat then
      InfMenu.DebugPrint"InfNPC:Update - WARNING #platRoutes*maxSoldiersOnSameRoute < maxSoldiersPerPlat, aborting"--DEBUG
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

    --InfMenu.DebugPrint(npcName .. " from plat "..tostring(lastPlat).." to plat "..platIndex.. " routeIdx ".. routeIdx .. " nextRouteTime "..nextRouteTime)--DEBUG
    local command={id="SetSneakRoute",route=route}
    SendCommand(gameId,command)
    local command={id="SwitchRoute",route=route}
    SendCommand(gameId,command)
  end
  --end,currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)--DEBUG
end

--tex TODO, hook up to msg
function this.OnEliminated(soldierId)
--TODO: find index in npclist
--npcPlats[index] > decrease soldiersonplat,npcRoutes[index] decrease soldiersonroute
end

return this
