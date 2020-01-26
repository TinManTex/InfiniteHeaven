-- DOBUILD: 1
--InfNPCHeli.lua
local this={}

--LOCALOPT
local Ivars=Ivars
local InfMain=InfMain
local StrCode32=Fox.StrCode32
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand

local npcHeliList={
  "WestHeli0000",
  "WestHeli0001",
  "WestHeli0002",
}

local enemyHeliList={
  --tex don't know if I want to use it anyway since there's a lot of other stuff tied to its name via quest heli and reinforce heli
  --"EnemyHeli",
  "EnemyHeli0000",
  "EnemyHeli0001",
  "EnemyHeli0002",
  "EnemyHeli0003",
  "EnemyHeli0004",
  "EnemyHeli0005",
  "EnemyHeli0006",
}

local numNpcAttackHelis=3
--numNpcAttackHelis=math.min(numNpcAttackHelis,#enemyHeliList)

this.heliList={}

local heliTimes={}
local heliRouteIds={}--tex str32 route for free roam, cluster for mb (TODO: change to route as well)
local heliColorType

--DEBUG
function this.ClearHeliState()
  for n,heliName in ipairs(this.heliList)do
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
    local levelToColor={0,0,0,1,1,2}
    return levelToColor[level+1]
  end

  return Ivars.mbEnemyHeliColor:Get()
end

function this.GetEnemyHeliColorName()
  return InfMain.heliColorNames[this.GetEnemyHeliColor()+1]
end

local routeTimeMbMin=3*60
local routeTimeMbMax=6*60

local routeTimeMin=2.5*60
local routeTimeMax=4*60

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

this.heliEnableIvars={
  Ivars.npcHeliUpdate,
  Ivars.mbEnemyHeli,
  Ivars.enemyHeliPatrol,
}

function this.InitUpdate(currentChecks)
  if not InfMain.IvarsEnabledForMission(this.heliEnableIvars) then
    return
  end

  local isMb=vars.missionCode==30050

  this.heliList={}
  if Ivars.mbEnemyHeli:Is(1) then
    this.heliList=InfMain.ResetPool(enemyHeliList)
  elseif isMb then
    this.heliList=InfMain.ResetPool(npcHeliList)
    if Ivars.mbWarGamesProfile:Is(0) then
      if Ivars.npcHeliUpdate:Is"UTH_AND_HP48" then
        for i=1,numNpcAttackHelis do
          table.insert(this.heliList,enemyHeliList[i])
        end
      end
    end
  elseif Ivars.enemyHeliPatrol:Is()>0 then
    local numAttackHelis=0

    if Ivars.enemyHeliPatrol:Is"MAX" then
      numAttackHelis=#enemyHeliList
    elseif Ivars.enemyHeliPatrol:Is"MIN" then
      numAttackHelis=1
    elseif Ivars.enemyHeliPatrol:Is"MID" then
      numAttackHelis=math.floor(#enemyHeliList/2)
    elseif Ivars.enemyHeliPatrol:Is"ENEMY_PREP" then
      local level=InfMain.GetAverageRevengeLevel()
      local levelToHeli={0,1,3,5,7,7}--tex GOTCHA tuned to max helis of 7, also need to weight the end to max since the steal vs combat ballance and decay system makes it hard to get up there
      numAttackHelis=levelToHeli[level+1]
    end

    numAttackHelis=math.min(numAttackHelis,#enemyHeliList)

    for i=1,numAttackHelis do
      this.heliList=InfMain.ResetPool(enemyHeliList)
    end
  end

  for n,heliName in ipairs(this.heliList)do
    heliTimes[n]=0
    heliRouteIds[n]=0
  end

  --      local heliMeshTypes={
  --        "uth_v00",
  --        "uth_v01",
  --        "uth_v02",
  --      }
  --      local meshType=heliMeshTypes[math.random(#heliMeshTypes)]
  --      GameObject.SendCommand( heliObjectId, { id = "SetMeshType", typeName = meshType, } )


  if Ivars.mbEnemyHeliColor:Is()>0 then
    heliColorType=this.GetEnemyHeliColor()
  end

  for n,heliName in ipairs(this.heliList)do
    local heliObjectId = GetGameObjectId(heliName)
    if heliObjectId==NULL_ID then
    --InfMenu.DebugPrint(heliName.."==NULL_ID")--DEBUG, will trigger in battlegear hangar since it's a different pack --DEBUG
    else
      local typeIndex=GetTypeIndex(heliObjectId)
      if typeIndex==TppGameObject.GAME_OBJECT_TYPE_ENEMY_HELI then
        if isMb and Ivars.mbEnemyHeli:Is(0) then
          SendCommand(heliObjectId,{id="SetEyeMode",mode="Close"})
          SendCommand(heliObjectId,{id="SetRestrictNotice",enabled=true})
          SendCommand(heliObjectId,{id="SetCombatEnabled",enabled=false})
          --TppMarker2System.DisableMarker{gameObjectId=heliObjectId}
        end

        if heliColorType~=nil then
          SendCommand(heliObjectId,{id="SetColoring",coloringType=heliColorType,fova=InfMain.heliColors[heliColorType].fova})
        end
      end
    end
  end

end

function this.ResetLzPool()
  local lzPool={}
  for strCode32Route, bool in pairs(mvars.ldz_assaultDropLandingZoneTable) do
    table.insert(lzPool,strCode32Route)
  end
  return lzPool
end

function this.OnMissionCanStart(currentChecks)
  if not InfMain.IvarsEnabledForMission(this.heliEnableIvars) then
    return
  end

  local isMb=vars.missionCode==30050
  --tex set up lz info
  if isMb then
  else
    InfMain.enabledLzs=this.ResetLzPool()
    --InfInspect.PrintInspect(mvars.ldz_assaultDropLandingZoneTable)--DEBUG
  end

  --this.SetRoutes()
end

local searchLightOn={id="SetSearchLightForcedType",type="On"}
local searchLightOff={id="SetSearchLightForcedType",type="On"}
local nightCheckTime=0
local nightCheckMax=20

function this.Update(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if not currentChecks.inGame then
    return
  end

    if not InfMain.IvarsEnabledForMission(this.heliEnableIvars) then
      return
  end

  if this.heliList==nil or #this.heliList==0 then
    --InfMenu.DebugPrint"UpdateNPCHeli: helilist empty"--DEBUG
    return
  end

  --tex don't start til ready
  local enabledLzs=InfMain.enabledLzs
  if enabledLzs==nil or #enabledLzs==0 then
    --InfMenu.DebugPrint"enabledLzs empty"--DEBUG
    return
  end

  local isMb=vars.missionCode==30050

  local elapsedTime=Time.GetRawElapsedTimeSinceStartUp()
  local isNight=WeatherManager.IsNight()
  for n,heliName in ipairs(this.heliList)do
    local heliObjectId = GetGameObjectId(heliName)
    if heliObjectId==NULL_ID then
    --InfMenu.DebugPrint(heliName.."==NULL_ID")--DEBUG
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


      --tex TODO set cp to nearest, possibly on second timer so it's not hitting it up every frame

      --tex choose new route
      if heliTimes[n]< elapsedTime then
        if isMb then
          heliTimes[n]=elapsedTime+math.random(routeTimeMbMin,routeTimeMbMax)
        else
          heliTimes[n]=elapsedTime+math.random(routeTimeMin,routeTimeMax)
        end

        local heliRoute=nil

        if isMb then
          local prevCluster=heliRouteIds[n]--DEBUG
          local clusterId=ChooseRandomHeliCluster(heliRouteIds,heliTimes,InfMain.heliSelectClusterId)
          heliRouteIds[n]=clusterId

          --        local clusterTime=heliTimes[n]-elapsedTime--DEBUG
          --        InfMenu.DebugPrint(n.." "..heliName .. " from ".. tostring(TppDefine.CLUSTER_NAME[prevCluster]) .." to cluster ".. tostring(TppDefine.CLUSTER_NAME[clusterId]) .. " for "..clusterTime)--DEBUG

          if mvars.mbSoldier_clusterParamList and mvars.mbSoldier_clusterParamList[clusterId] then
            local clusterParam=mvars.mbSoldier_clusterParamList[clusterId]
            local cpId=GetGameObjectId(clusterParam.CP_NAME)
            if cpId==NULL_ID then
              InfMenu.DebugPrint("cpId "..clusterParam.CP_NAME.."==NULL_ID ")
            else
              SendCommand(heliObjectId,{id="SetCommandPost",cp=clusterParam.CP_NAME})
            end
          end

          local clusterLzs=enabledLzs[clusterId]
          if clusterLzs and #clusterLzs>0 then
            local currentLandingZoneName=clusterLzs[math.random(#clusterLzs)]
            local nextLandingZoneName=clusterLzs[math.random(#clusterLzs)]
            local heliTaxiSettings=mtbs_helicopter.RequestHeliTaxi(heliObjectId,StrCode32(currentLandingZoneName),StrCode32(nextLandingZoneName))
            if heliTaxiSettings then
              local currentClusterRoute=heliTaxiSettings.currentClusterRoute
              local relayRoute=heliTaxiSettings.relayRoute
              local nextClusterRoute=heliTaxiSettings.nextClusterRoute

              heliRoute=currentClusterRoute
            else
              InfMenu.DebugPrint("Warning: UpdateNPCHeli - no heliTaxiSettings for".. currentLandingZoneName .." ".. nextLandingZoneName)
            end
          end

        else
          --tex trying to overcome the heli will keep going if set to same route, which for free roam assault lzs means going off till disapearing,
          --setforcerouting to point 0 doesnt seem to do it, neither does setroute to "" then setting route again
          while heliRoute==nil or heliRoute==heliRouteIds[n] do
            heliRoute=InfMain.GetRandomPool(enabledLzs)

            if #enabledLzs==0 then
              InfMain.enabledLzs=this.ResetLzPool()
              enabledLzs=InfMain.enabledLzs
            end
          end
          heliRouteIds[n]=heliRoute
        end

        if heliRoute then
          SendCommand(heliObjectId,{id="SetForceRoute",route=heliRoute})
          --SendCommand(heliObjectId,{id="SetForceRoute",route=heliRoute,point=0,warp=true})
          --SendCommand(heliObjectId,{id="SetLandingZnoeDoorFlag",name="heliRoute",leftDoor="Close",rightDoor="Close"})

          ---InfMenu.DebugPrint(n.." "..heliName.." setting route: "..tostring(heliRoute))--DEBUG
        end
        -- is > heliTime--<
      end
      --not NULL_ID<
    end
    --for heliname<
  end
end

function this.SetRoutes()
  InfInspect.TryFunc(function()--DEBUGNOW

    if not InfMain.IvarsEnabledForMission(this.heliEnableIvars) then
      return
  end

  if this.heliList==nil or #this.heliList==0 then
    InfMenu.DebugPrint"UpdateNPCHeli: helilist empty"--DEBUGNOW
    return
  end

  --tex don't start til ready
  local enabledLzs=InfMain.enabledLzs
  if enabledLzs==nil or #enabledLzs==0 then
    InfMenu.DebugPrint"enabledLzs empty"--DEBUGNOW
    return
  end

  InfMain.SetLevelRandomSeed()

  local elapsedTime=Time.GetRawElapsedTimeSinceStartUp()
  local isNight=WeatherManager.IsNight()
  for n,heliName in ipairs(this.heliList)do
    local heliObjectId = GetGameObjectId(heliName)
    if heliObjectId==NULL_ID then
      InfMenu.DebugPrint(heliName.."==NULL_ID")--DEBUG
    else
      --tex TODO set cp to nearest, possibly on second timer so it's not hitting it up every frame

      local heliRoute=enabledLzs[math.random(#enabledLzs)]

      if heliRoute then
        SendCommand(heliObjectId,{id="SetForceRoute",route=heliRoute})
        --SendCommand(heliObjectId,{id="SetLandingZnoeDoorFlag",name="heliRoute",leftDoor="Close",rightDoor="Close"})
        --SendCommand(heliObjectId,{id="SetForceRoute",route=heliRoute,point=0,warp=true})
        InfMenu.DebugPrint(n.." "..heliName.." setting route: "..tostring(heliRoute))--DEBUGNOW
      end
    end
  end

  InfMain.ResetTrueRandom()

  end)
end

return this
