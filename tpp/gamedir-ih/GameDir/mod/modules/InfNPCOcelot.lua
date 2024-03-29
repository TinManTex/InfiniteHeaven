--InfNPCOcelot.lua
local this={}

--LOCALOPT
local InfMain=InfMain
local StrCode32=InfCore.StrCode32
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local Random=math.random
local GetCurrentCluster=MotherBaseStage.GetCurrentCluster

--updateState
this.active="mbEnableOcelot"
this.execCheckTable={inGame=true,inSafeSpace=false}
this.execState={
  nextUpdate=0,
}
this.updateRate=1

--
this.packages={
  "/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk",
}

this.npcPositions={
  [30050]={
    --TODO: expand to multiple clusters, multiple startpos/rots and multiple npc
    onClusterId=TppDefine.CLUSTER_DEFINE.Command,
    startPos=Vector3(10.396,0.8,-16.994),--similar to ddogs mission static pos
    -- OFF: command 1 is in construction during early game
    --startPos=Vector3(5.56,24.83,-5.57)--tex just outside core door
    --startRotY=144,
    --startPos=Vector3(3.89,8.512,-14.535)--tex mid level overlooking lower helipad
    startRotY=170.482,
    --command plat only
    npcRoutes={
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
    },--npcRoutes
  },--30050
  --DEBUGNOW
  [34001]={
    startPos=Vector3(-14,-7.2,3.85),
    startRotY=340,
  },--34001
}--npcPositions

local onClusterId=TppDefine.CLUSTER_DEFINE.Command--DEBUGNOW use npcPositions instead

local npcList={
  --WARNING TODO: not multiple npc aware
  "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator",
}
--tex indexed by npcList
local npcBodies={
  {
    TppEnemyBodyId.oce0_main0_v00,
    TppEnemyBodyId.oce0_main0_v01,--glasses
  --TppEnemyBodyId.oce0_main0_v02,--looks normal but may be defaulting/need a pack, no references but may be used in a demo
  },
}

local npcTimes={}
for n=1,#npcList do
  npcTimes[n]=0
end

local routeTimeMin=3*60
local routeTimeMax=6*60

this.mbDemoWasPlay=false
this.setupNpc=false

this.registerIvars={
  "mbEnableOcelot",
}

this.mbEnableOcelot={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckMb,
  --DEBUGNOW
--  MissionCheck=function(self,missionCode)
--    local missionCode=missionCode or vars.missionCode
--
--    local firstDigit=math.floor(missionCode/1e4)
--    if firstDigit==3 then
--      InfCore.Log"Ivars.mbEnableOcelot MissionCheck true"--DEBUGNOW
--      return true
--    end
--InfCore.Log"Ivars.mbEnableOcelot MissionCheck false"--DEBUGNOW
--    return false
--  end,
}
--<
this.langStrings={
  eng={
    mbEnableOcelot="Enable Ocelot",
  },
  help={
    eng={
      mbEnableOcelot="Enables Ocelot to roam the command platform.",
    },
  }
}
--<

function this.PostAllModulesLoad()
  this.Init()
end

function this.AddMissionPacks(missionCode,packPaths)
  --DEBUGNOW
  if this.npcPositions[missionCode]==nil then
    return
  end
  if not this.active:EnabledForMission(missionCode) then
    return
  end

  if InfMainTpp.IsMbEvent(missionCode) then
    return
  end

  for i,packPath in ipairs(this.packages) do
    packPaths[#packPaths+1]=packPath
  end
end

function this.Init()
  this.messageExecTable=nil

  if not this.active:EnabledForMission() then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  local clusterId=GetCurrentCluster()
  this.InitCluster(clusterId)
end

function this.OnReload(missionTable)
  this.messageExecTable=nil

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
  if not currentChecks.inGame then
    return
  end

  if not this.active:EnabledForMission() then
    return
  end

  if InfMainTpp.IsMbEvent() then
    return
  end

  local demoName=TppDemo.GetMBDemoName()
  if demoName then
    this.mbDemoWasPlay=true
    return
  end

  local placement=this.npcPositions[vars.missionCode]--WARNING: not multiple npc aware
  if placement==nil then
    InfCore.Log("InfNPCOcelot placement==nil")--DEBUGNOW
    return
  end

  if placement.onClusterId and GetCurrentCluster()~=placement.onClusterId then
    return
  end

  if not this.setupNpc then
    this.setupNpc=true

    for n=1,#npcList do
      local npcName=npcList[n]
      local gameId=GetGameObjectId(npcName)
      if gameId==NULL_ID then
        InfCore.Log("InfNPCOcelot "..npcName.."==NULL_ID")--DEBUGNOW
      else
        InfCore.Log("InfNPCOcelot setupNpc")--DEBUGNOW

        if this.mbDemoWasPlay then
        --InfCore.DebugPrint("mbDemoWasPlay")--DEBUG
        else
          local command={id="Warp",position=placement.startPos,degRotationY=placement.startRotY}
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

  if placement.npcRoutes then--WARNING: not multiple npc aware
    for n=1,#npcList do
      local npcName=npcList[n]
      local gameId=GetGameObjectId(npcName)
      if gameId==NULL_ID then
      --InfCore.DebugPrint("gameId==NULL_ID")
      else
        if npcTimes[n]< currentTime then
          npcTimes[n]=currentTime+Random(routeTimeMin,routeTimeMax)

          local routeIdx=Random(#placement.npcRoutes)

          --        local routeTime=npcTimes[n]-Time.GetRawElapsedTimeSinceStartUp()--DEBUG
          --        InfCore.DebugPrint(npcName .. " routeIdx ".. routeIdx .. " for "..routeTime)--DEBUG
          local command={id="SetSneakRoute",route=placement.npcRoutes[routeIdx]}
          SendCommand(gameId,command)
        end
      end
      --for npcs<
  end
  end
end

return this
