-- DOBUILD: 1
-- InfParasite.lua
local this={}

local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID
local SendCommand=GameObject.SendCommand
local StartTimer=GkEventTimerManager.Start

--TUNE
local PARASITE_PARAMETERS={
  NORMAL={--10020
    sightDistance = 20,
    sightVertical = 36.0,
    sightHorizontal = 48.0,
  },
  HARD = {
    sightDistance = 30,
    sightVertical = 55.0,
    sightHorizontal = 48.0,
  },
}

--10090
--local PARASITE_PARAMETERS={
--  NORMAL = {
--    sightDistance         = 25,
--    sightDistanceCombat       = 75,
--
--    sightHorizontal         = 60,
--    noiseRate           = 8,
--    avoidSideMin          = 8,
--    avoidSideMax          = 12,
--    areaCombatBattleRange     = 50,
--    areaCombatBattleToSearchTime  = 1,
--    areaCombatLostSearchRange   = 1000,
--    areaCombatLostToGuardTime   = 120,
--
--    throwRecastTime         = 10,
--  },
--
--  EXTREME={
--    sightDistance         = 25,
--    sightDistanceCombat       = 100,
--
--    sightHorizontal         = 100,
--    noiseRate           = 10,
--    avoidSideMin          = 8,
--    avoidSideMax          = 12,
--    areaCombatBattleRange     = 50,
--    areaCombatBattleToSearchTime  = 1,
--    areaCombatLostSearchRange   = 1000,
--    areaCombatLostToGuardTime   = 60,
--
--    throwRecastTime         = 10,
--  },
--}

local PARASITE_GRADE = {
  NORMAL = {
    defenseValueMain = 4000,
    defenseValueArmor = 7000,
    defenseValueWall = 8000,
    offenseGrade = 2,
    defenseGrade = 7,
  },
  HARD = {
    defenseValueMain = 4000,
    defenseValueArmor = 8400,
    defenseValueWall = 9600,
    offenseGrade = 5,
    defenseGrade = 7,
  },
}



--seconds
local monitorRate=15
local parasiteAppearTimeMin=5
local parasiteAppearTimeMax=15

local playerRange=175
local escapeDistance=250
--distsqr
playerRange=playerRange*playerRange
escapeDistance=escapeDistance*escapeDistance

local spawnRadius=40

local cpZombieLife=300
local cpZombieStamina=200


this.parasiteNames={
  "Parasite0",
  "Parasite1",
  "Parasite2",
  "Parasite3",
}

local hardened=false


function this.SetupParasites()
  local parameters=PARASITE_PARAMETERS.NORMAL
  local combatGrade=PARASITE_GRADE.NORMAL
  GameObject.SendCommand({type="TppParasite2"},{id="SetParameters",params=parameters})
  GameObject.SendCommand(
    {type="TppParasite2"},
    {
      id="SetCombatGrade",
      defenseValueMain=combatGrade.defenseValueMain,
      defenseValueArmor=combatGrade.defenseValueArmor,
      defenseValueWall=combatGrade.defenseValueWall,
      offenseGrade=combatGrade.offenseGrade,
      defenseGrade=combatGrade.defenseGrade,
    }
  )
end

function this.OnDamage(gameId,attackId,attackerId)
  local typeIndex=GameObject.GetTypeIndex(gameId)
  --DEBUGNOW TODO
  if typeIndex==TppGameObject.GAME_OBJECT_TYPE_PARASITE2 then
    if Ivars.enableParasiteEvent:Is(0) or not Ivars.enableParasiteEvent:MissionCheck() then
      return
    end
    --InfMenu.DebugPrint"OnDamage para"--DEBUG
    --  if harden and not hardened then
    --    GameObject.SendCommand( { type="TppParasite2" }, { id="StartCombat",harden=true } )
    --  end
  end
end

function this.OnDying(gameId)
  --InfMenu.DebugPrint"OnDying para"--DEBUG
  local typeIndex=GameObject.GetTypeIndex(gameId)
  if typeIndex==TppGameObject.GAME_OBJECT_TYPE_PARASITE2 then
    if Ivars.enableParasiteEvent:Is(0) or not Ivars.enableParasiteEvent:MissionCheck() then
      return
    end
    --InfMenu.DebugPrint"OnDying is para"--DEBUG
    --tex in theory dont need to do this since messages is already using parasiteNames as sender
    --  for k,parasiteName in pairs(this.parasiteNames) do
    --    local gameObjectId=GameObject.GetGameObjectId(parasiteName)
    --    if gameObjectId~=nil then
    --      --isParasite=true
    --      break
    --    end
    --  end
    local count=Ivars.inf_parasiteEvent:Get()
    if count==0 then
      --InfMenu.DebugPrint"WARNING: OnDying and inf_parasiteEvent == 0"--DEBUGNOW
      return
    end
    local count=count-1
    Ivars.inf_parasiteEvent:Set(count)

    if count==0 then
      this.EndEvent()
    end
  end
end

function this.FadeInOnGameStart()
  if Ivars.inf_parasiteEvent:Is()>0 then
    if TppMission.IsMissionStart() then
      --InfMenu.DebugPrint"mission start clear, StartEventTimer"--DEBUG
      Ivars.inf_parasiteEvent:Set(0)
      this.StartEventTimer()
    else
      --InfMenu.DebugPrint"ContinueEvent"--DEBUG
      this.ContinueEvent()
    end
  else
    --InfMenu.DebugPrint"StartEventTimer"--DEBUG
    this.StartEventTimer()
  end
end

function this.InitEvent()
  if Ivars.inf_parasiteEvent:Is()>0 then
    if TppMission.IsMissionStart() then
      --InfMenu.DebugPrint"mission start clear, StartEventTimer"--DEBUG
      Ivars.inf_parasiteEvent:Set(0)
      hardened=false
    end
  end
  this.SetupParasites()
end

function this.StartEventTimer()
  --InfInspect.TryFunc(function()--DEBUG
  --InfMenu.DebugPrint("Timer_ParasiteEvent start")--DEBUG
  local minute=60
  --local nextEventTime=10--DEBUG
  local nextEventTime=math.random(Ivars.parasitePeriod_MIN:Get()*minute,Ivars.parasitePeriod_MAX:Get()*minute)
  --InfMenu.DebugPrint("Timer_ParasiteEvent start in "..nextEventTime)--DEBUG
  StartTimer("Timer_ParasiteEvent",nextEventTime)
  --end)--
end

function this.StartEvent()
  --InfMenu.DebugPrint"Timer_ParasiteEvent hit"--DEBUG

  local fogDensity=math.random(0.001,0.9)
  TppWeather.ForceRequestWeather(TppDefine.WEATHER.FOGGY,4,{fogDensity=fogDensity})

  local parasiteAppearTime=math.random(parasiteAppearTimeMin,parasiteAppearTimeMax)
  StartTimer("Timer_ParasiteAppear",parasiteAppearTime)
end

function this.ContinueEvent()
  local parasiteAppearTime=math.random(parasiteAppearTimeMin,parasiteAppearTimeMax)
  StartTimer("Timer_ParasiteAppear",parasiteAppearTime)
end

function this.ParasiteAppear()
  --InfMenu.DebugPrint"ParasiteAppear"--DEBUG
  local playerPosition={vars.playerPosX,vars.playerPosY,vars.playerPosZ}

  local closestLz,lzDistance,lzPosition=InfMain.GetClosestLz(playerPosition)
  if closestLz==nil then
    InfMenu.DebugPrint"WARNING: StartEvent closestLz==nil"--DEBUGNOW
    return
  end

  local closestCp,cpDistance,cpPosition=InfMain.GetClosestCp(playerPosition)
  if closestCp==nil then
    InfMenu.DebugPrint"WARNING: StartEvent closestCp==nil"--DEBUGNOW
    return
  end
  
--  InfMenu.DebugPrint(closestLz..":"..math.sqrt(lzDistance))--DEBUG
--  InfMenu.DebugPrint(closestCp..":"..math.sqrt(cpDistance))--DEBUG

  local lzCpDist=TppMath.FindDistance(lzPosition,cpPosition)
  local closestDist=cpDistance
  local closestPos=cpPosition
  if cpDistance>lzDistance and lzCpDist>playerRange*2 then
    closestPos=lzPosition
    closestDist=lzDistance
  end

  if closestDist>playerRange then
    closestPos=playerPosition
  end

  --TODO TUNE
  local disableDamage=false
  local isHalf=false  
  
  --tex TODO doesn't cover visiting lrrp
  if closestPos==cpPosition then

    local cpDefine=mvars.ene_soldierDefine[closestCp]
    if cpDefine==nil then
      InfMenu.DebugPrint("WARNING StartEvent could not find cpdefine for "..closestCp)--DEBUGNOW
    else
      for i=1,#cpDefine do
        this.SetZombie(cpDefine[i],disableDamage,isHalf,cpZombieLife,cpZombieStamina)
      end
    end
  end

  local numParasites=4--tex TODO
  Ivars.inf_parasiteEvent:Set(numParasites)

  this.parasitePos=closestPos

  SendCommand({type="TppParasite2"},{id="StartAppearance",position=Vector3(closestPos[1],closestPos[2],closestPos[3]),radius=spawnRadius})

  StartTimer("Timer_ParasiteMonitor",monitorRate)
  this.StartEventTimer()--tex schedule next
end


function this.MonitorEvent()
  --  InfInspect.TryFunc(function()--DEBUG
  --    InfMenu.DebugPrint"MonitorEvent"--DEBUG
  if Ivars.inf_parasiteEvent:Is(0) then
    return
  end

  if this.parasitePos==nil then
    InfMenu.DebugPrint"WARNING MonitorEvent parasitePos==nil"--DEBUGNOW
    return
  end

  local outOfRange=false
  local playerPos={vars.playerPosX,vars.playerPosY,vars.playerPosZ}
  local distSqr=TppMath.FindDistance(playerPos,this.parasitePos)
  if distSqr>escapeDistance then
    outOfRange=true
  end

  --InfMenu.DebugPrint("dist:"..math.sqrt(distSqr))--DEBUG

  --tex TppParasites aparently dont support GetPosition, frustrating inconsistancy, you'd figure it would be a function of all gameobjects
  --  for k,parasiteName in pairs(this.parasiteNames) do
  --    local gameId=GetGameObjectId(parasiteName)
  --    if gameId~=NULL_ID then
  --      local parasitePos=SendCommand(gameId,{id="GetPosition"})
  --      local distSqr=TppMath.FindDistance(playerPos,{parasitePos:GetX(),parasitePos:GetY(),parasitePos:GetZ()})
  --      InfMenu.DebugPrint(parasiteName.." dist:"..math.sqrt(distSqr))--DEBUGNOW
  --      if distSqr<escapeDistance then
  --        outOfRange=false
  --        break
  --      end
  --    end
  --  end

  if outOfRange then
    --InfMenu.DebugPrint"MonitorEvent: out of range, ending event"--DEBUG
    this.EndEvent()
    this.StartEventTimer()
  else
    StartTimer("Timer_ParasiteMonitor",monitorRate)
  end
  --end)--
end

function this.EndEvent()
  Ivars.inf_parasiteEvent:Set(0)
  hardened=false
  TppWeather.CancelForceRequestWeather()
  TppWeather.RequestWeather(TppDefine.WEATHER.SUNNY,7)
  SendCommand({type="TppParasite2"},{id="StartWithdrawal"})
end

function this.SetZombie(gameObjectName,disableDamage,isHalf,life,stamina)
  isHalf=isHalf or false

  local gameObjectId=GetGameObjectId("TppSoldier2",gameObjectName)
  SendCommand(gameObjectId,{id="SetZombie",enabled=true,isHalf=isHalf})
  SendCommand(gameObjectId,{id="SetMaxLife",life=life,stamina=stamina})
  SendCommand(gameObjectId,{id="SetZombieUseRoute",enabled=false})
  if disableDamage==true then
    SendCommand(gameObjectId,{id="SetDisableDamage",life=false,faint=true,sleep=true})
  end
  if isHalf then
    local ignoreFlag=0
    SendCommand(gameObjectId,{id="SetIgnoreDamageAction",flag=ignoreFlag})
  end
end

return this
