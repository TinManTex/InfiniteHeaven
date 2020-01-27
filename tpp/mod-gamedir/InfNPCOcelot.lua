--InfNPCOcelot.lua
local this={}

--LOCALOPT
local InfMain=InfMain
local StrCode32=Fox.StrCode32
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local Random=math.random
local GetCurrentCluster=MotherBaseStage.GetCurrentCluster

--updateState
this.active=Ivars.mbEnableOcelot
this.execCheckTable={inGame=true,inHeliSpace=false}
this.execState={
  nextUpdate=0,
}
this.updateRate=1

--
this.packages={
  "/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk",
}

local onClusterId=TppDefine.CLUSTER_DEFINE.Command

--tex just outside core door
--local commandCoreStartPos=Vector3(5.56,24.83,-5.57)
--local commandCoreStartRot=144

--tex mid level overlooking lower helipad
--local commandCoreStartPos=Vector3(3.89,8.512,-14.535)
local commandCoreStartRot=170.482

--tex WORKAROUND command 1 in construction during early game
local commandCoreStartPos=Vector3(10.396,0.8,-16.994)--similar to ddogs mission static pos

local npcList={
  "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",
}

--command plat only
local npcRoutes={
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0000",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0001",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0002",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0003",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0004",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_d_0005",

  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0000",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0001",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0002",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0003",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0004",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_n_0005",

  "ly003_cl00_route0000|cl00pl0_mb_fndt_plnt_free|rt_free_h_0000",
  "ly003_cl00_route0000|cl00pl0_mb_fndt_plnt_free|rt_free_h_0001",
  "ly003_cl00_route0000|cl00pl0_mb_fndt_plnt_free|rt_free_h_0002",
  "ly003_cl00_route0000|cl00pl0_mb_fndt_plnt_free|rt_free_h_0003",

  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_h_0000",
  "ly003_cl00_route0000|cl00pl0_uq_0000_free|rt_free_h_0001",
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

function this.PostModuleReload()
  this.Init()
end

function this.AddMissionPacks(missionCode,packPaths)
  if not this.active:EnabledForMission(missionCode) then
    return
  end

  if InfGameEvent.IsMbEvent() then
    return
  end

  for i,packPath in ipairs(this.packages) do
    packPaths[#packPaths+1]=packPath
  end
end

function this.Init()
  if not this.active:EnabledForMission() then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  local clusterId=GetCurrentCluster()
  this.InitCluster(clusterId)
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
      {msg="MotherBaseCurrentClusterActivated",func=function(clusterId)this.MotherBaseCurrentClusterActivated(clusterId)end},
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
  if clusterId~=onClusterId then
    return
  end

  this.mbDemoWasPlay=false
  this.setupNpc=false

  for n=1,#npcList do
    npcTimes[n]=0
  end
end

function this.Update(currentChecks,currentTime,execChecks,execState)

  local Ivars=Ivars
  if not currentChecks.inGame then
    return
  end

  if GetCurrentCluster()~=onClusterId then
    return
  end

  if not this.active:EnabledForMission() then
    return
  end

  if InfGameEvent.IsMbEvent() then
    return
  end

  local demoName=TppDemo.GetMBDemoName()
  if demoName then
    this.mbDemoWasPlay=true
    return
  end

  if not this.setupNpc then
    this.setupNpc=true

    for n=1,#npcList do
      local npcName=npcList[n]
      local gameId=GetGameObjectId(npcName)
      if gameId==NULL_ID then
      --InfLog.DebugPrint("gameId==NULL_ID")
      else
        --InfLog.DebugPrint("setupNpc")--DEBUG

        if this.mbDemoWasPlay then
        --InfLog.DebugPrint("mbDemoWasPlay")--DEBUG
        else
          local command={id="Warp",position=commandCoreStartPos,degRotationY=commandCoreStartRot}
          SendCommand(gameId,command)
        end

        local command={id="SetEnabled",enabled=true}
        SendCommand(gameId,command)


        local bodyId=npcBodies[n][Random(#npcBodies[n])]--tex TODO: seed it if it's a big enough change to be jarring

        local command={id="ChangeFova",faceId=EnemyFova.INVALID_FOVA_VALUE,bodyId=bodyId}
        SendCommand(gameId,command)
        --if NULL_ID<
      end
      --for npcs
    end
    --if not setup<
  end

  for n=1,#npcList do
    local npcName=npcList[n]
    local gameId=GetGameObjectId(npcName)
    if gameId==NULL_ID then
    --InfLog.DebugPrint("gameId==NULL_ID")
    else
      if npcTimes[n]< currentTime then
        npcTimes[n]=currentTime+Random(routeTimeMin,routeTimeMax)

        local routeIdx=Random(#npcRoutes)

        --        local routeTime=npcTimes[n]-Time.GetRawElapsedTimeSinceStartUp()--DEBUG
        --        InfLog.DebugPrint(npcName .. " routeIdx ".. routeIdx .. " for "..routeTime)--DEBUG
        local command={id="SetSneakRoute",route=npcRoutes[routeIdx]}
        SendCommand(gameId,command)
      end
    end
    --for npcs<
  end
end

return this
