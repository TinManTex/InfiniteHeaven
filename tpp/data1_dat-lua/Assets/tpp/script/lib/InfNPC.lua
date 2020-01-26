-- DOBUILD: 1
--InfNPC.lua
local this={}

--LOCALOPT
local StrCode32=Fox.StrCode32
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
--
local commandCoreStartPos=Vector3(5.56,24.83,-5.57)
local commandCoreStartRot=144

local npcList={
  "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",
}

local npcRoutes={
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0000",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0001",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0002",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0003",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0004",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0005",
}
local npcBodies={
  {
    TppEnemyBodyId.oce0_main0_v00,
    TppEnemyBodyId.oce0_main0_v01,--glasses
  --TppEnemyBodyId.oce0_main0_v02,--looks normal but may be defaulting/need a pack, no references but may be used in a demo
  },
}

local npcTimes={}

local routeTimeMin=3*60
local routeTimeMax=6*60

this.mbDemoWasPlay=false
this.setupNpc=false
function this.InitNPCUpdate()
  if vars.missionCode~=30050 then
    return
  end

  this.mbDemoWasPlay=false
  this.setupNpc=false

  for n,npcName in ipairs(npcList)do
    npcTimes[n]=0
  end
end
function this.UpdateNPC(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if not currentChecks.inGame then
    return
  end

  if vars.missionCode~=30050 then
    return
  end

  if Ivars.mbEnableOcelot:Is(0) or Ivars.mbWarGamesProfile:Is()>0 then
    return
  end

  local demoName=TppDemo.GetMBDemoName()
  if demoName then
    this.mbDemoWasPlay=true
    return
  end

  if not this.setupNpc then
    this.setupNpc=true

    for n,npcName in ipairs(npcList) do
      local gameId=GameObject.GetGameObjectId(npcName)
      if gameId==GameObject.NULL_ID then
      --InfMenu.DebugPrint("gameId==NULL_ID")
      else
        --InfMenu.DebugPrint("setupNpc")--DEBUG

        if this.mbDemoWasPlay then
        --InfMenu.DebugPrint("mbDemoWasPlay")--DEBUG
        else
          local command={id="Warp",position=commandCoreStartPos,degRotationY=commandCoreStartRot}
          GameObject.SendCommand(gameId,command)
        end

        local command={id="SetEnabled",enabled=true}
        GameObject.SendCommand(gameId,command)


        local bodyId=npcBodies[n][math.random(#npcBodies[n])]--tex TODO: seed it if it's a big enough change to be jarring

        local command={id="ChangeFova",faceId=EnemyFova.INVALID_FOVA_VALUE,bodyId=bodyId}
        GameObject.SendCommand(gameId,command)
        --if NULL_ID<
      end
      --for npcs
    end
    --if not setup<
  end

  for n,npcName in ipairs(npcList) do
    local gameId=GameObject.GetGameObjectId(npcName)
    if gameId==GameObject.NULL_ID then
    --InfMenu.DebugPrint("gameId==NULL_ID")
    else
      if npcTimes[n]< Time.GetRawElapsedTimeSinceStartUp() then
        npcTimes[n]=Time.GetRawElapsedTimeSinceStartUp()+math.random(routeTimeMin,routeTimeMax)

        local routeIdx=math.random(#npcRoutes)

        --        local routeTime=npcTimes[n]-Time.GetRawElapsedTimeSinceStartUp()--DEBUG
        --        InfMenu.DebugPrint(npcName .. " routeIdx ".. routeIdx .. " for "..routeTime)--DEBUG
        local command={id="SetSneakRoute",route=npcRoutes[routeIdx]}
        SendCommand(gameId,command)
      end
    end
    --for npcs<
  end
end
---


local npcHeliList={
  "WestHeli0000",
  "WestHeli0001",
  "WestHeli0002",
}

--tex don't know if I want to use it anyway since there's a lot of other stuff tied to its name via quest heli and reinforce heli
local enemyHeliList={
  --"EnemyHeli",
  "EnemyHeli0000",
  "EnemyHeli0001",
  "EnemyHeli0002",
  "EnemyHeli0003",
  "EnemyHeli0004",
  "EnemyHeli0005",
  "EnemyHeli0006",
}


local heliTimes={}
local heliClusters={}
local heliColorType

local clusterTimeMin=3*60
local clusterTimeMax=6*60

local function ChooseRandomHeliCluster(heliClusters,heliTimes,supportHeliClusterId)
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
      table.insert(clusterPool,clusterId)
    end
  end

  return clusterPool[math.random(#clusterPool)]
end

local heliColors={
  [TppDefine.ENEMY_HELI_COLORING_TYPE.DEFAULT]={pack="",fova=""},
  [TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={pack="/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk",fova="/Assets/tpp/fova/mecha/sbh/sbh_ene_blk.fv2"},
  [TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={pack="/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk",fova="/Assets/tpp/fova/mecha/sbh/sbh_ene_red.fv2"}
}

function this.InitNPCHeliUpdate()
  if vars.missionCode~=30050 then
    return
  end

  local heliList=npcHeliList
  if Ivars.mbEnemyHeli:Is(1) then
    heliList=enemyHeliList
  end

  for n,heliName in ipairs(heliList)do
    heliTimes[n]=0
    heliClusters[n]=0
  end

  --      local heliMeshTypes={
  --        "uth_v00",
  --        "uth_v01",
  --        "uth_v02",
  --      }
  --      local meshType=heliMeshTypes[math.random(#heliMeshTypes)]
  --      GameObject.SendCommand( heliObjectId, { id = "SetMeshType", typeName = meshType, } )
  if Ivars.mbEnemyHeli:Is(1) then
    local cpId
    local clusterId=1
    if mvars.mbSoldier_clusterParamList and mvars.mbSoldier_clusterParamList[clusterId] then
      local clusterParam = mvars.mbSoldier_clusterParamList[clusterId]
      cpId=GetGameObjectId(clusterParam.CP_NAME)
      if cpId==NULL_ID then
        InfMenu.DebugPrint("cpId "..clusterParam.CP_NAME.."==NULL_ID ")
      end
    end
    if cpId then
      if Ivars.mbEnemyHeli:Is(1) then
        heliColorType=Ivars.mbEnemyHeliColor:Get()+1--tex SYNC: TppDefine.ENEMY_HELI_COLORING_TYPE
      else
        heliColorType=nil
      end

      --tex doesnt work at this point, probably needs the fpk to be loaded
      local numClusters=#mvars.mbSoldier_clusterParamList
      --InfMenu.DebugPrint("numClusters "..numClusters)--DEBUG

      for n,heliName in ipairs(heliList)do
        if n>numClusters-1 then
          break
        end
        local heliObjectId = GetGameObjectId(heliName)
        if heliObjectId==NULL_ID then
          --InfMenu.DebugPrint(heliName.."==NULL_ID")--DEBUG, will trigger in battlegear hangar since it's a different pack
        else
          SendCommand(heliObjectId,{id="SetColoring",coloringType=heliColorType,fova=InfMain.heliColors[heliColorType].fova})
        end
      end
      --if cpid--<
    end
    --if mbEnemyHeli--<
  end
end

local searchLightOn={id="SetSearchLightForcedType",type="On"}
local searchLightOff={id="SetSearchLightForcedType",type="On"}
local nightCheckTime=0
local nightCheckMax=20
local prepSet=false--tex WORKAROUND
local prevHeliMode=nil--tex WORKAROUND
function this.UpdateNPCHeli(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if not currentChecks.inGame then
    return
  end

  if vars.missionCode~=30050 then
    return
  end

  if Ivars.npcHeliUpdate:Is(0) and Ivars.mbEnemyHeli:Is(0) then
    return
  end

  local enabledLzs=InfMain.enabledLzs

  local heliList=npcHeliList
  if Ivars.mbEnemyHeli:Is(1) then
    heliList=enemyHeliList
  end

  --WORKAROUND
  if prevHeliMode==nil or prevHeliMode~=heliList then
    prepSet=false
  end

  local elapsedTime=Time.GetRawElapsedTimeSinceStartUp()
  local isNight=WeatherManager.IsNight()
  local numClusters=#mvars.mbSoldier_clusterParamList
  for n,heliName in ipairs(heliList)do
    if n>numClusters-1 then
      break
    end

    local heliObjectId = GetGameObjectId(heliName)
    if heliObjectId==NULL_ID then
      InfMenu.DebugPrint(heliName.."==NULL_ID")--DEBUG
    else
      --DEBUGNOW
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

      if heliTimes[n]< elapsedTime then
        if heliTimes[n]==0 and not prepSet then--and ~=startonfoot --tex WORKAROUND, if starting on heli then the first heli set, on the first game load doesnt work for some reason, even though restart of the mission and even a quit and restart of mission works. DEBUGNOW
          prepSet=true
          heliTimes[n]=10
        else
          heliTimes[n]=elapsedTime+math.random(clusterTimeMin,clusterTimeMax)
        end

        local prevCluster=heliClusters[n]--DEBUG
        local clusterId=ChooseRandomHeliCluster(heliClusters,heliTimes,InfMain.heliSelectClusterId)
        heliClusters[n]=clusterId

        --        local clusterTime=heliTimes[n]-elapsedTime--DEBUG
        --        InfMenu.DebugPrint(heliName .. " from ".. tostring(TppDefine.CLUSTER_NAME[prevCluster]) .." to cluster ".. tostring(TppDefine.CLUSTER_NAME[clusterId]) .. " for "..clusterTime)--DEBUG

        if mvars.mbSoldier_clusterParamList and mvars.mbSoldier_clusterParamList[clusterId] then
          local clusterParam=mvars.mbSoldier_clusterParamList[clusterId]
          local cpId=GetGameObjectId(clusterParam.CP_NAME)
          if cpId==NULL_ID then
            InfMenu.DebugPrint("cpId "..clusterParam.CP_NAME.."==NULL_ID ")
          else
            SendCommand(heliObjectId,{id="SetCommandPost",cp=clusterParam.CP_NAME})
          end
        end

        if enabledLzs and #enabledLzs>0 then
          local clusterLzs=enabledLzs[clusterId]
          if clusterLzs and #clusterLzs>0 then
            local currentLandingZoneName=clusterLzs[math.random(#clusterLzs)]
            local nextLandingZoneName=clusterLzs[math.random(#clusterLzs)]
            local heliTaxiSettings=mtbs_helicopter.RequestHeliTaxi(heliObjectId, StrCode32(currentLandingZoneName), StrCode32(nextLandingZoneName) )
            if heliTaxiSettings then
              local currentClusterRoute=heliTaxiSettings.currentClusterRoute
              local relayRoute=heliTaxiSettings.relayRoute
              local nextClusterRoute=heliTaxiSettings.nextClusterRoute

              SendCommand(heliObjectId,{id="SetForceRoute",route=currentClusterRoute})
            else
              InfMenu.DebugPrint("Warning: UpdateNPCHeli - no heliTaxiSettings for".. currentLandingZoneName .." ".. nextLandingZoneName)
            end
          end
        end
        -- is > heliTime--<
      end
      --not NULL_ID<
    end
    --for heliname<
  end
end

return this