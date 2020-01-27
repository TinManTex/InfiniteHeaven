-- InfAnimal.lua
local this={}

local GetCurrentCluster=MotherBaseStage.GetCurrentCluster

this.packages={
  BIRD="/Assets/tpp/pack/mission2/ih/ih_raven.fpk",
  RAT="/Assets/tpp/pack/mission2/ih/ih_rat.fpk",
}

this.birdNames={
  "ih_raven_0000",
  "ih_raven_0001",
  "ih_raven_0002",
  "ih_raven_0003",
  "ih_raven_0004",
  "ih_raven_0005",
  "ih_raven_0006",
  "ih_raven_0007",
}

local birdCenters={
  Command={
    {-0.481,38,-0.081},--plat0
    {116.888,22,0.562},--plat1
    {212.925,16,-80.130},--plat2
    {334.155,12,-66.795},--plat3
  },
  Combat={
    {1128.469,40,-604.095},--plat0
    {1142.788,16,-730.768},--plat1
    {1238.641,14,-808.431},--plat2
    {1360.101,12,-794.208},--plat3
  },
  Develop={
    {1192,50,304},--plat0
    {1313.883,17,316.840},--plat1
    {1408.627,14,236.079},--plat2
    {1530.719,18,249.914},--plat3
  },
  Support={
    {373.729,20,865.484},--plat0
    {454.271,16.800,956.160},--plat1
    {441.817,12,1079.355},--plat2
    {340.349,20,1149.023},--plat3
  },
  Medical={
    {-136.577,20,-956.578},--plat0
    {-123.936,17,-1078.801},--plat1
    {-204.430,12,-1174.303},--plat2
    {-191.023,20,-1296.039},--plat3
  },
  Spy={
    {-679.699,40,534.390},--plat0
    {-687.967,18,651.257},--plat1
    {-785.644,20,733.809},--plat2
    {-792.327,15,853.594},--plat3
  },
  BaseDev={
    {-745.755,16,-372.843},--plat0
    {-823.040,16,-467.386},--plat1
    {-947.669,18,-478.383},--plat2
    {-1024.306,15,-574.054},--plat3
  },
  Separation={
    {-175.147,12.826,-2057.978},
  },
}

function this.AddMissionPacks(missionCode,packPaths)
  if Ivars.mbEnableBirds:EnabledForMission(missionCode) then
    packPaths[#packPaths+1]=this.packages.BIRD
  end
end

function this.Init()
  this.messageExecTable=nil

  if not Ivars.mbEnableBirds:EnabledForMission() then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  local clusterId=GetCurrentCluster()
  this.InitCluster(clusterId)
end

function this.OnReload(missionTable)
  this.messageExecTable=nil

  if not Ivars.mbEnableBirds:EnabledForMission() then
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
  if not Ivars.mbEnableBirds:EnabledForMission() then
    return
  end
  this.SetupBirds(clusterId)
end

function this.SetupBirds(clusterId)
  local clusterName=InfMain.CLUSTER_NAME[clusterId+1]
  --tex TODO: i only have positions for mbLayout 3, should either add others, or disable on different layouts
  local clusterCenters=birdCenters[clusterName]

  local birdInfo={
    name="ih_raven_0000",
    birdType="TppCritterBird",
    center={1360.101,12,-794.208},
    radius=60,
    height=10,
  }

  for i,birdName in ipairs(this.birdNames)do
    birdInfo.name=birdName
    birdInfo.center=clusterCenters[math.random(#clusterCenters)]
    birdInfo.radius=math.random(30,80)

    this.SetupBird(birdInfo)
  end
end

function this.SetupBird(birdInfo)
  local birdGameId={type=birdInfo.birdType,index=0}
  local setEnabledCommand={id="SetEnabled",name=birdInfo.name,birdIndex=0,enabled=true}
  GameObject.SendCommand(birdGameId,setEnabledCommand)
  if(birdInfo.center and birdInfo.radius)and birdInfo.height then
    local changeFlyingZoneCommand={id="ChangeFlyingZone",name=birdInfo.name,center=birdInfo.center,radius=birdInfo.radius,height=birdInfo.height}
    GameObject.SendCommand(birdGameId,changeFlyingZoneCommand)
    local setLandingPointCommand=nil
    if birdInfo.ground then
      setLandingPointCommand={id="SetLandingPoint",birdIndex=birdInfo.birdIndex,name=birdInfo.name,groundPos=birdInfo.ground}
      GameObject.SendCommand(birdGameId,setLandingPointCommand)
    elseif birdInfo.perch then
      setLandingPointCommand={id="SetLandingPoint",birdIndex=birdInfo.birdIndex,name=birdInfo.name,perchPos=birdInfo.perch}
      GameObject.SendCommand(birdGameId,setLandingPointCommand)
    end
    local setAutoLandingCommand={id="SetAutoLanding",name=birdInfo.name}
    GameObject.SendCommand(birdGameId,setAutoLandingCommand)

    this.SetBirdBehavior(birdInfo)
  end
end

function this.SetBirdBehavior(birdInfo)
  local gameObjectId={type=birdInfo.birdType,index=0}
  local command={
    id="SetParameter",
    name=birdInfo.birdName,
    maxSpeed=35.0,
    minSpeed=18.0,
    flyTime=20.0,
    idleTime=100.0,
  }
  GameObject.SendCommand(gameObjectId,command)

  local perchCommand={
    id="WarpOnPerch",
    name=birdInfo.birdName,
  }
  GameObject.SendCommand(gameObjectId,perchCommand)
end


return this
