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
--
--tex just outside core door
--local commandCoreStartPos=Vector3(5.56,24.83,-5.57)
--local commandCoreStartRot=144
--tex mid level overlooking lower helipad
local commandCoreStartPos=Vector3(3.89,8.512,-14.535)
local commandCoreStartRot=170.482

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
function this.InitUpdate()
  if vars.missionCode~=30050 then
    return
  end

  this.mbDemoWasPlay=false
  this.setupNpc=false

  for n,npcName in ipairs(npcList)do
    npcTimes[n]=0
  end
end
function this.Update(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if not currentChecks.inGame then
    return
  end

  if vars.missionCode~=30050 then
    return
  end

  if Ivars.mbEnableOcelot:Is(0) or Ivars.mbWarGamesProfile:Is()>0 or Ivars.inf_event:Is()>0 then
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

return this
