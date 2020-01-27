-- InfParasite.lua
-- tex implements parasite/skulls unit event

local this={}

local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local NULL_ID=GameObject.NULL_ID
local SendCommand=GameObject.SendCommand
local TimerStart=GkEventTimerManager.Start
local TimerStop=GkEventTimerManager.Stop
local IsTimerActive=GkEventTimerManager.IsTimerActive
local GAME_OBJECT_TYPE_PARASITE2=TppGameObject.GAME_OBJECT_TYPE_PARASITE2
local GAME_OBJECT_TYPE_BOSSQUIET2=TppGameObject.GAME_OBJECT_TYPE_BOSSQUIET2
local GAME_OBJECT_TYPE_HOSTAGE2=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2

--STATE
local disableFight=false--DEBUG

local eventInitialized=false

local stateTypes={
  READY=0,
  DOWNED=1,
  FULTONED=2,
}
--tex indexed by parasiteNames
local states={}--tex TODO: going to have to save this, for camo at least, to keep in sync with internal state of downed/fultoned
local hitCounts={}

--tex dependant on defined entities
local maxParasites={
  ARMOR=4,
  CAMO=4,
}
--tex for current event
local numParasites={--tex heh
  ARMOR=0,
  CAMO=0,
  total=0,
}

this.parasitePos=nil
this.playerPos=nil
this.cpPosition=nil
this.closestCp=nil
this.closestPos=nil

local routeBag=nil

this.hostageParasiteHitCount=0--tex mbqf hostage parasites
this.forceEvent=false

--TUNE
--tex since I'm repurposing routes buit for normal cps the camo parasites just seem to shift along a short route, or get stuck leaving and returning to same spot.
--semi workable solution is to just set new routes after the parasite has been damaged a few times.
local camoShiftRouteAttackCount=3

local triggerAttackCount=45--tex mbqf hostage parasites

local PARASITE_PARAMETERS={
  NORMAL={--10020
    sightDistance = 20,
    sightVertical = 36.0,
    sightHorizontal = 48.0,
  },
  HARD={
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

local PARASITE_GRADE={
  NORMAL={
    defenseValueMain=4000,
    defenseValueArmor=7000,
    defenseValueWall=8000,
    offenseGrade=2,
    defenseGrade=7,
  },
  HARD={
    defenseValueMain=4000,
    defenseValueArmor=8400,
    defenseValueWall=9600,
    offenseGrade=5,
    defenseGrade=7,
  },
}

--seconds
local monitorRate=10
local parasiteAppearTimeMin=5
local parasiteAppearTimeMax=15

local playerRange=175--tex choose player pos as attack pos if closest lz or cp >
local escapeDistance=300--250--tex player distance from parasite attack pos to call off attack
--distsqr
playerRange=playerRange*playerRange
escapeDistance=escapeDistance*escapeDistance

local spawnRadius=40
--tex since camos start moving to route when activated, and closest cp may not be that discoverable
--or their positions even that good, spawn at player pos in a close enough radius that they spot player
--they'll then be aiming at player when they reach the cp
--TODO: alternatively try triggering StartCombat on camo spawn
local camoSpawnRadius=10

--TUNE zombies
local disableDamage=false
local isHalf=false
local msfRate=10--mb only

local cpZombieLife=300
local cpZombieStamina=200

--DATA
this.parasiteNames={
  ARMOR={
    "Parasite0",
    "Parasite1",
    "Parasite2",
    "Parasite3",
  },
  CAMO={
    "wmu_ih_0000",
    "wmu_ih_0001",
    "wmu_ih_0002",
    "wmu_ih_0003",
  },
}

this.eventTypes={
  "ARMOR",
  "CAMO",
  "MIXED",
}

--tex GOTCHA probably cant use this method for mist as I think they share parasite2, but still could be uses as a typeindex is parasite (onfulton)
this.parasiteTypes={
  [TppGameObject.GAME_OBJECT_TYPE_PARASITE2]="ARMOR",
  [TppGameObject.GAME_OBJECT_TYPE_BOSSQUIET2]="CAMO",
}

function this.Init(missionTable)
  if not this.ParasiteEventEnabled() then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.OnReload(missionTable)
  if not this.ParasiteEventEnabled() then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="Damage",func=this.OnDamage},
      {msg="Dying",func=this.OnDying},
      --tex TODO: "FultonInfo" instead of fulton and fultonfailed
      {msg="Fulton",--tex fulton success i think
        func=function(gameId,gimmickInstance,gimmickDataSet,stafforResourceId)
          local typeIndex=GetTypeIndex(gameId)
          if this.parasiteTypes[typeIndex] then
            this.OnFulton(gameId)
          end
        end
      },
      {msg="FultonFailed",
        func=function(gameId,locatorName,locatorNameUpper,failureType)
          if failureType==TppGameObject.FULTON_FAILED_TYPE_ON_FINISHED_RISE then
            local typeIndex=GetTypeIndex(gameId)
            if this.parasiteTypes[typeIndex] then
              this.OnFulton(gameId)
            end
          end
        end
      },
    },
    Timer={
      {msg="Finish",sender="Timer_ParasiteEvent",func=this.StartEvent},
      {msg="Finish",sender="Timer_ParasiteAppear",func=this.Timer_ParasiteAppear},
      {msg="Finish",sender="Timer_ParasiteCombat",func=this.Timer_StartCombat},
      {msg="Finish",sender="Timer_ParasiteMonitor",func=this.Timer_MonitorEvent},
    },
    UI={
      {msg="EndFadeIn",sender="FadeInOnGameStart",func=this.FadeInOnGameStart},--fires on: most mission starts, on-foot free and story missions, not mb on-foot, but does mb heli start
    },
  }
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  if not this.ParasiteEventEnabled() then
    return
  end

  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this.DeclareSVars()
  if not this.ParasiteEventEnabled() then
    return{}
  end
  local saveVarsList = {
    --tex engine sets svars.parasiteSquadMarkerFlag when camo parasite marked, will crash if svar not defined
    parasiteSquadMarkerFlag={name="parasiteSquadMarkerFlag",type=TppScriptVars.TYPE_BOOL,arraySize=4,value=false,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_RETRY},
  }
  return TppSequence.MakeSVarsTable(saveVarsList)
end

function this.OnMissionCanStart()
  if not this.ParasiteEventEnabled() then
    eventInitialized=false
    return
  end

  if not eventInitialized then
    this.InitEvent()
  end
end

function this.FadeInOnGameStart()
  if not this.ParasiteEventEnabled() then
    return
  end

  if Ivars.enableParasiteEvent:Is(0) then
    return
  end

  if Ivars.inf_parasiteEvent:Is()>0 then
    if TppMission.IsMissionStart() then
      InfLog.Add"InfParasite mission start, clear, StartEventTimer"
      Ivars.inf_parasiteEvent:Set(0)
      this.StartEventTimer()
    else
      InfLog.Add"InfParasite mission start ContinueEvent"
      this.ContinueEvent()
    end
  else
    InfLog.Add"InfParasite mission start StartEventTimer"
    this.StartEventTimer()
  end
end

function this.ParasiteEventEnabled()
  if (Ivars.enableParasiteEvent:Is(1) or this.forceEvent) and (Ivars.enableParasiteEvent:MissionCheck() or vars.missionCode==30250) then
    return true
  end
  return false
end

function this.SetupParasites()
  local parameters=PARASITE_PARAMETERS.NORMAL
  local combatGrade=PARASITE_GRADE.NORMAL
  SendCommand({type="TppParasite2"},{id="SetParameters",params=parameters})
  SendCommand(
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
  local typeIndex=GetTypeIndex(gameId)
  if typeIndex==GAME_OBJECT_TYPE_PARASITE2 then
  --    if not this.ParasiteEventEnabled() then
  --      return
  --    end
  elseif typeIndex==GAME_OBJECT_TYPE_BOSSQUIET2 then
    if not this.ParasiteEventEnabled() then
      return
    end
    this.OnDamageCamoParasite(gameId,attackId,attackerId)
  elseif typeIndex==GAME_OBJECT_TYPE_HOSTAGE2 then
    --tex dont block if parasite events off so player can always manually trigger event
    if vars.missionCode==30250 then
      this.OnDamageMbqfParasite(gameId,attackId,attackerId)
    end
  end
end

local hostageParasites={
  "hos_wmu00_0000",
  "hos_wmu00_0001",
  "hos_wmu01_0000",
  "hos_wmu01_0001",
  "hos_wmu03_0000",
  "hos_wmu03_0001",
}
function this.OnDamageMbqfParasite(gameId,attackId,attackerId)
  if vars.missionCode~=30250 then
    return
  end
  --InfLog.DebugPrint"OnDamage"--DEBUG

  local isHostage=false
  for i,parasiteName in pairs(hostageParasites) do
    local gameId=GetGameObjectId(parasiteName)
    if gameId==gameId then
      isHostage=true
      break
    end
  end

  if isHostage then
    this.hostageParasiteHitCount=this.hostageParasiteHitCount+1
    --InfLog.Add("hostageParasiteHitCount "..this.hostageParasiteHitCount,true)--DEBUG

    if this.hostageParasiteHitCount>triggerAttackCount then
      this.hostageParasiteHitCount=0
      this.forceEvent=true
      this.StartEvent()
    end
  end
end

function this.OnDamageCamoParasite(gameId,attackId,attackerId)
  local name=this.GetNameForId(gameId)
  if name then
    if states[name]==stateTypes.READY then
      hitCounts[name]=hitCounts[name]+1
      if hitCounts[name]>=camoShiftRouteAttackCount then
        hitCounts[name]=0
        this.SetCamoRoutes(routeBag,gameId)
      end
    end
  end
end

function this.OnDying(gameId)
  --InfLog.PCall(function(gameId)--DEBUG
  local parasiteType=nil
  local typeIndex=GetTypeIndex(gameId)
  if typeIndex==GAME_OBJECT_TYPE_PARASITE2 then
    if not this.ParasiteEventEnabled() then
      return
    end

    for k,parasiteName in pairs(this.parasiteNames.ARMOR) do
      local parasiteId=GetGameObjectId(parasiteName)
      if parasiteId~=nil and parasiteId==gameId then
        parasiteType="ARMOR"
        break
      end
    end
  elseif typeIndex==GAME_OBJECT_TYPE_BOSSQUIET2 then
    for k,parasiteName in pairs(this.parasiteNames.CAMO) do
      local parasiteId=GetGameObjectId(parasiteName)
      if parasiteId~=nil and parasiteId==gameId then
        parasiteType="CAMO"
        break
      end
    end
  end

  if parasiteType==nil then
    return
  end
  InfLog.Add("OnDying is para",true)
  local name=this.GetNameForId(gameId)
  states[name]=stateTypes.DOWNED

  InfLog.PrintInspect(states)--DEBUG

  local numCleared=this.GetNumCleared()
  if numCleared==numParasites.total then
    --InfLog.DebugPrint"OnDying all eliminated"--DEBUG
    this.EndEvent()
  end
  --end,gameId)--
end

function this.OnFulton(gameId,gimmickInstance,gimmickDataSet,stafforResourceId)
  --InfLog.PCall(function(gameId)--DEBUG
  if not this.ParasiteEventEnabled() then
    return
  end

  local typeIndex=GetTypeIndex(gameId)
  local parasiteType=this.parasiteTypes[typeIndex]
  if parasiteType then
    local name=this.GetNameForId(gameId)
    states[name]=stateTypes.FULTONED
  end

  InfLog.PrintInspect(states)

  local numCleared=this.GetNumCleared()
  if numCleared==numParasites.total then
    this.EndEvent()
  end
  --end,gameId)--
end

function this.InitEvent()
  --InfLog.PCall(function()--DEBUG
  InfLog.Add("InfParasite InitEvent")
  this.forceEvent=false

  if not this.ParasiteEventEnabled() and vars.missionCode~=30250 then
    return
  end

  for i,parasiteName in ipairs(this.parasiteNames.CAMO) do
    this.CamoParasiteOff(parasiteName)
  end

  this.hostageParasiteHitCount=0

  if TppMission.IsMissionStart() then
    --InfLog.DebugPrint"InitEvent IsMissionStart clear"--DEBUG
    Ivars.inf_parasiteEvent:Set(0)
  end

  for parasiteType,names in pairs(this.parasiteNames)do
    for i,name in ipairs(names)do
      states[name]=stateTypes.READY
      hitCounts[name]=0
    end
  end

  InfMain.RandomSetToLevelSeed()
  local eventType=this.eventTypes[math.random(#this.eventTypes)]
  InfMain.RandomResetToOsTime()

  if eventType=="ARMOR" then
    numParasites.ARMOR=maxParasites.ARMOR
  end
  if eventType=="CAMO" then
    numParasites.CAMO=maxParasites.CAMO
  end
  if eventType=="MIXED" then
    numParasites.ARMOR=maxParasites.ARMOR--tex armor parasites cant appear individually
    numParasites.CAMO=maxParasites.CAMO --math.random(1,maxParasites.CAMO)
  end
  InfLog.Add("InfParasite.InitEvent "..eventType)

  --DEBUG
--  numParasites={
--    ARMOR=4,
--    CAMO=4,
--    total=8,
--  }
  numParasites.total=numParasites.ARMOR+numParasites.CAMO

  InfLog.PrintInspect(numParasites)

  this.SetupParasites()

  eventInitialized=true
  --end)--
end

local Timer_ParasiteEventStr="Timer_ParasiteEvent"
function this.StartEventTimer()
  if not this.ParasiteEventEnabled() then
    return
  end

  if Ivars.enableParasiteEvent:Is(0) then
    return
  end

  local numCleared=this.GetNumCleared()
  if numCleared==numParasites.total then
    InfLog.Add("StartEventTimer numCleared==numParasites.total aborting")
    return
  end

  --InfLog.PCall(function()--DEBUG
  --InfLog.DebugPrint("Timer_ParasiteEvent start")--DEBUG
  local minute=60
  --local nextEventTime=10--DEBUG
  local nextEventTime=math.random(Ivars.parasitePeriod_MIN:Get()*minute,Ivars.parasitePeriod_MAX:Get()*minute)
  --InfLog.DebugPrint("Timer_ParasiteEvent start in "..nextEventTime)--DEBUG
  TimerStop(Timer_ParasiteEventStr)
  TimerStart(Timer_ParasiteEventStr,nextEventTime)
  --end)--
end

function this.StartEvent()
  if IsTimerActive(Timer_ParasiteEventStr)then
    TimerStop(Timer_ParasiteEventStr)
  end

  local numCleared=this.GetNumCleared()
  if numCleared==numParasites.total then
    InfLog.Add("StartEvent numCleared==numParasites.total aborting",true)
    return
  end

  Ivars.inf_parasiteEvent:Set(1)

  local playerPos={vars.playerPosX,vars.playerPosY,vars.playerPosZ}
  local closestPos=playerPos
  local closestDist=999999999999999

  local isMb=vars.missionCode==30050 or vars.missionCode==30250

  local cpDistance
  local closestCp,cpDistance,cpPosition=InfMain.GetClosestCp(playerPos)
  if closestCp==nil or cpPosition==nil then
    InfLog.DebugPrint"WARNING: ParasiteAppear closestCp==nil"--DEBUG
    return
  end

  closestDist=cpDistance

  if not isMb then--tex TODO: implement for mb
    local closestLz,lzDistance,lzPosition=InfMain.GetClosestLz(playerPos)
    if closestLz==nil or lzPosition==nil then
      InfLog.DebugPrint"WARNING: ParasiteAppear closestLz==nil"--DEBUG
      return
    end

    local lzCpDist=TppMath.FindDistance(lzPosition,cpPosition)
    closestPos=cpPosition
    if cpDistance>lzDistance and lzCpDist>playerRange*2 then
      closestPos=lzPosition
      closestDist=lzDistance
    end
  end

  if closestDist>playerRange then
    closestPos=playerPos
  end

  --tex keep em together, else camo will likely go unnoticed
  if numParasites.CAMO>0 then
    closestPos=cpPosition
  end

  this.parasitePos=closestPos
  this.playerPos=playerPos
  this.cpPosition=cpPosition
  this.closestCp=closestCp
  this.closestPos=closestPos

  local fogDensity=math.random(0.001,0.9)
  TppWeather.ForceRequestWeather(TppDefine.WEATHER.FOGGY,4,{fogDensity=fogDensity})

  local parasiteAppearTime=math.random(parasiteAppearTimeMin,parasiteAppearTimeMax)
  TimerStart("Timer_ParasiteAppear",parasiteAppearTime)
end

function this.ContinueEvent()
  --InfLog.Add("ContinueEvent hit",true)
  local numCleared=this.GetNumCleared()
  if numCleared==numParasites.total then
    InfLog.Add("StartEvent numCleared==numParasites.total aborting",true)
    return
  end

  local parasiteAppearTime=math.random(parasiteAppearTimeMin,parasiteAppearTimeMax)
  TimerStart("Timer_ParasiteAppear",parasiteAppearTime)
end

--tex have to indirect/wrap this since the address in the timer doesnt get refreshed on module reload
function this.Timer_ParasiteAppear()
  this.ParasiteAppear()
end

function this.ParasiteAppear()
  --InfLog.PCall(function()--DEBUG
    local locationName=InfMain.GetLocationName()
    InfLog.Add("ParasiteAppear closestCp:"..this.closestCp.. " "..InfMenu.CpNameString(this.closestCp,locationName),true)

    local isMb=vars.missionCode==30050 or vars.missionCode==30250
    if isMb then
      this.ZombifyMB()
    else
      this.ZombifyFree(this.closestCp,this.closestPos)
    end

    if numParasites.ARMOR>0 then
      this.ArmorParasiteAppear(this.parasitePos,spawnRadius)
    end
    if numParasites.CAMO>0 then
      this.CamoParasiteAppear(this.closestCp,this.cpPosition,this.playerPos,camoSpawnRadius)
    end
    --
    --tex once one armor parasite has been fultoned the rest will be stuck in some kind of idle ai state on next appearance
    --forcing combat bypasses this
    local armorFultoned=false
    for i,name in ipairs(this.parasiteNames.ARMOR)do
      if states[name]==stateTypes.FULTONED then
        armorFultoned=true
      end
    end
    if armorFultoned and numParasites.ARMOR>0 then
      --InfLog.DebugPrint"Timer_ParasiteCombat start"--DEBUG
      TimerStart("Timer_ParasiteCombat",4)
    end

    TimerStart("Timer_ParasiteMonitor",monitorRate)
  --end)--
end

function this.ZombifyMB(disableDamage)
  for cpName,cpDefine in pairs(mvars.ene_soldierDefine)do
    for i,soldierName in ipairs(cpDefine)do
      local soldierId=GetGameObjectId("TppSoldier2",soldierName)
      if soldierId~=NULL_ID then
        local isMsf=math.random(100)<msfRate
        this.SetZombie(cpDefine[i],disableDamage,isHalf,cpZombieLife,cpZombieStamina,isMsf)

        --tex GOTCHA setfriendlycp seems to be one-way only
        local command={id="SetFriendly",enabled=false}
        SendCommand(soldierId,command)
      end
    end
  end
end

local SetZombies=function(soldierNames,cpPosition)
  for i,soldierName in ipairs(soldierNames) do
    local gameId=GetGameObjectId("TppSoldier2",soldierName)
    if gameId~=NULL_ID then
      local soldierPosition=SendCommand(gameId,{id="GetPosition"})
      local soldierCpDistance=0
      if cpPosition then
        TppMath.FindDistance({soldierPosition:GetX(),soldierPosition:GetY(),soldierPosition:GetZ()},cpPosition)
      end
      if not cpPosition or soldierCpDistance<escapeDistance then
        --InfLog.DebugPrint(soldierName.." close to "..closestCp.. ", zombifying")--DEBUG
        this.SetZombie(soldierName,disableDamage,isHalf,cpZombieLife,cpZombieStamina)
      end
    end
  end
end

function this.ZombifyFree(closestCp,cpPosition)
  --tex soldiers of closestCp
  if closestCp then
    local cpDefine=mvars.ene_soldierDefine[closestCp]
    if cpDefine==nil then
      InfLog.DebugPrint("WARNING StartEvent could not find cpdefine for "..closestCp)--DEBUG
    else
      SetZombies(cpDefine)
    end
  end

  --tex IH free roam foot lrrps
  if InfMain.lrrpDefines then
    for i=1,#InfMain.lrrpDefines do
      local lrrpDefine=InfMain.lrrpDefines[i]
      if lrrpDefine.base1==closestCp or lrrpDefine.base2==closestCp then
        SetZombies(lrrpDefine.cpDefine,cpPosition)
      end
    end
  end

  --tex TODO doesn't cover vehicle lrrp

  --TODO VERIFY
  if mvars.ene_soldierDefine and mvars.ene_soldierDefine.quest_cp then
    SetZombies(mvars.ene_soldierDefine.quest_cp,cpPosition)
  end
end

function this.ArmorParasiteAppear(parasitePos,spawnRadius)
  --tex after fultoning armor parasites don't appear, try and reset
  --doesnt work, parasite does appear, but is in fulton pose lol
  --  if numFultonedThisMap>0 then
  --    for k,parasiteName in pairs(this.parasiteNames.ARMOR) do
  --      local gameId=GetGameObjectId(parasiteName)
  --      if gameId~=NULL_ID then
  --        SendCommand(gameId,{id="Realize"})
  --      end
  --    end
  --  end

  --tex Armor parasites appear all at once, distributed in a circle
  SendCommand({type="TppParasite2"},{id="StartAppearance",position=Vector3(parasitePos[1],parasitePos[2],parasitePos[3]),radius=spawnRadius})
end

local phases={
  "caution",
  "sneak_day",
  "sneak_night",
}
local groups={
  "groupSniper",
  "groupA",
  "groupB",
  "groupC",
}
local groupSniper="groupSniper"
function this.CamoParasiteAppear(closestCp,cpPosition,playerPos,spawnRadius)

  --tex WORKAROUND the delay between player pos on startevent and parasite appear is too high
  local playerPos={vars.playerPosX,vars.playerPosY,vars.playerPosZ}

  --InfLog.Add"CamoParasiteAppear"--DEBUG
  --tex camo parasites rely on having route set, otherwise they'll do a constant grenade drop evade on the same spot
  local routeSets=nil
  if mvars.loc_locationCommonRouteSets then
    routeSets=mvars.loc_locationCommonRouteSets[closestCp]
  elseif mvars.ene_routeSetsDefine then
    routeSets=mvars.ene_routeSetsDefine[closestCp]
  end
  if not routeSets then
    InfLog.Add"CamoParasiteAppear - no routesets found, aborting"
    return
  end

  local cpRoutes={}
  --tex TODO prioritze picking sniper group first?
  if routeSets==nil then
    InfLog.DebugPrint("WARNING CamoParasiteAppear no routesets for "..this.closestCp)--DEBUG
    return
  end

  local routeCount=0
  for i,phaseName in ipairs(phases)do
    local phaseRoutes=routeSets[phaseName]
    if phaseRoutes then
      for i,groupName in ipairs(groups)do
        local group=phaseRoutes[groupName]
        if group then
          --tex some groups have duplicate groups
          for i,route in ipairs(group)do
            if groupName==groupSniper then
              cpRoutes[route[1]]=true
            else
              cpRoutes[route]=true
            end
            routeCount=routeCount+1
          end
        end
      end
    end
  end

  --InfLog.PrintInspect("CamoParasiteAppear pickedroutes")--DEBUG
  --InfLog.PrintInspect(pickedRoutes)

  if routeCount<numParasites.CAMO then
    InfLog.Add("WARNING: CamoParasiteAppear - routeCount< #camo parasites",true)
    return
  end

  routeBag=InfMain.ShuffleBag:New()
  for route,bool in pairs(cpRoutes) do
    routeBag:Add(route)
  end

  local spawnPos=playerPos

  for i=1,numParasites.CAMO do
    local parasiteName=this.parasiteNames.CAMO[i]
    if states[parasiteName]==stateTypes.READY then
      local gameId=GetGameObjectId("TppBossQuiet2",parasiteName)
      if gameId==NULL_ID then
        InfLog.Add("WARNING: CamoParasiteAppear - "..parasiteName.. " not found",true)
      else
        local parasiteRotY=0

        InfLog.Add(parasiteName.." appear",true)

        --ASSUMPTION 4 parasites
        --half circle with 2 leads
        --local angle=360/i

        --4 quadrants
        local angle=90*(i-1)
        local spawnPos=this.PointOnCircle(spawnPos,spawnRadius,angle)

        this.SetCamoRoutes(routeBag,gameId)

        SendCommand(gameId,{id="ResetPosition"})
        SendCommand(gameId,{id="ResetAI"})

        --tex can put camo parasites to an initial position
        --but they will move to their set route on activation
        SendCommand(gameId,{id="WarpRequest",pos=spawnPos,rotY=parasiteRotY})

        if disableFight then
          this.CamoParasiteOnDisableFight(parasiteName)
        else
          this.CamoParasiteOn(parasiteName)
        end

        this.CamoParasiteCloseCombatMode(parasiteName,true)
      end
      --SendCommand({type="TppBossQuiet2"},{id="StartCombat"})
    end
  end
end

function this.Timer_StartCombat()
  SendCommand({type="TppParasite2"},{id="StartCombat"})
end

function this.Timer_MonitorEvent()
  --  InfLog.PCall(function()--DEBUG
  --InfLog.Add("MonitorEvent",true)
  if Ivars.inf_parasiteEvent:Is(0) then
    return
  end

  if this.parasitePos==nil then
    InfLog.DebugPrint"WARNING MonitorEvent parasitePos==nil"--DEBUG
    return
  end

  local outOfRange=false
  local playerPos={vars.playerPosX,vars.playerPosY,vars.playerPosZ}
  local distSqr=TppMath.FindDistance(playerPos,this.parasitePos)
  if distSqr>escapeDistance then
    outOfRange=true
  end

  --InfLog.DebugPrint("dist:"..math.sqrt(distSqr))--DEBUG

  --tex TppParasites aparently dont support GetPosition, frustrating inconsistancy, you'd figure it would be a function of all gameobjects
  --  for i,parasiteName in pairs(this.parasiteNames.ARMOR) do
  --    local gameId=GetGameObjectId(parasiteName)
  --    if gameId~=NULL_ID then
  --      local parasitePos=SendCommand(gameId,{id="GetPosition"})
  --      local distSqr=TppMath.FindDistance(playerPos,{parasitePos:GetX(),parasitePos:GetY(),parasitePos:GetZ()})
  --     -- InfLog.DebugPrint(parasiteName.." dist:"..math.sqrt(distSqr))--DEBUG
  --      if distSqr<escapeDistance then
  --        outOfRange=false
  --        break
  --      end
  --    end
  --  end
  if numParasites.CAMO>0 then
    for i,parasiteName in pairs(this.parasiteNames.CAMO) do
      if states[parasiteName]==stateTypes.READY then
        local gameId=GetGameObjectId("TppBossQuiet2",parasiteName)
        if gameId~=NULL_ID then
          local parasitePos=SendCommand(gameId,{id="GetPosition"})
          local distSqr=TppMath.FindDistance(playerPos,{parasitePos:GetX(),parasitePos:GetY(),parasitePos:GetZ()})
          InfLog.Add("Monitor: "..parasiteName.." dist:"..math.sqrt(distSqr),true)--DEBUG
          if distSqr<escapeDistance then
            outOfRange=false
            break
          end
        end
      end
    end
  end

  if outOfRange then
    InfLog.Add("MonitorEvent: out of range, ending event",true)
    this.EndEvent()
    TimerStop("Timer_ParasiteMonitor")
    this.StartEventTimer()
  else
    TimerStart("Timer_ParasiteMonitor",monitorRate)
  end
  --end)--
end

function this.EndEvent()
  InfLog.Add("EndEvent",true)
  this.forceEvent=false

  Ivars.inf_parasiteEvent:Set(0)
  TppWeather.CancelForceRequestWeather(TppDefine.WEATHER.SUNNY,7)
  SendCommand({type="TppParasite2"},{id="StartWithdrawal"})

  --tex TODO throw them to some far route (or warprequest if it doesn't immediately vanish them) then Off them after a while
  for i,parasiteName in ipairs(this.parasiteNames.CAMO) do
    if states[parasiteName]==stateTypes.READY then
      this.CamoParasiteOff(parasiteName)
    end
  end
end

function this.GetNumCleared()
  local numCleared=0
  for parasiteName,state in pairs(states)do
    if state~=stateTypes.READY then
      numCleared=numCleared+1
    end
  end
  return numCleared
end

--tex TODO: build direct gameid>name lookup table on Init()
function this.GetNameForId(findId)
  for parasiteType,parasites in pairs(this.parasiteNames) do
    for i,name in ipairs(parasites)do
      local gameId=GetGameObjectId(name)
      if gameId~=NULL_ID then
        if gameId==findId then
          return name
        end
      end
    end
  end
end

function this.SetZombie(gameObjectName,disableDamage,isHalf,life,stamina,isMsf)
  isHalf=isHalf or false

  local gameObjectId=GetGameObjectId("TppSoldier2",gameObjectName)
  SendCommand(gameObjectId,{id="SetZombie",enabled=true,isHalf=isHalf,isZombieSkin=true,isHagure=true,isMsf=isMsf})
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

--camo zombies/TppBossQuiet2
function this.CamoParasiteOff(parasiteName)
  local gameObjectId=GetGameObjectId("TppBossQuiet2",parasiteName)

  local command01={id="SetSightCheck",flag=false}
  SendCommand(gameObjectId,command01)

  local command02={id="SetNoiseNotice",flag=false}
  SendCommand(gameObjectId,command02)

  local command03={id="SetInvincible",flag=true}
  SendCommand(gameObjectId,command03)

  local command04={id="SetStealth",flag=true}
  SendCommand(gameObjectId,command04)

  local command05={id="SetHumming",flag=false}
  SendCommand(gameObjectId,command05)

  local command06={id="SetForceUnrealze",flag=true}
  SendCommand(gameObjectId,command06)
end

function this.CamoParasiteOn(parasiteName)
  local gameObjectId=GetGameObjectId("TppBossQuiet2",parasiteName)

  local command={id="SetForceUnrealze",flag=false}
  SendCommand(gameObjectId,command)

  local command01={id="SetSightCheck",flag=true}
  SendCommand(gameObjectId,command01)

  local command02={id="SetNoiseNotice",flag=true}
  SendCommand(gameObjectId,command02)

  local command03={id="SetInvincible",flag=false}
  SendCommand(gameObjectId,command03)

  local command04={id="SetStealth",flag=false}
  SendCommand(gameObjectId,command04)

  local command05={id="SetHumming",flag=true}
  SendCommand(gameObjectId,command05)
end

function this.CamoParasiteOnDisableFight(parasiteName)
  local gameObjectId=GetGameObjectId("TppBossQuiet2",parasiteName)

  local command={id="SetForceUnrealze",flag=false}
  SendCommand(gameObjectId,command)

  local command01={id="SetSightCheck",flag=false}
  SendCommand(gameObjectId,command01)

  local command02={id="SetNoiseNotice",flag=false}
  SendCommand(gameObjectId,command02)

  local command03={id="SetInvincible",flag=false}
  SendCommand(gameObjectId,command03)

  local command04={id="SetStealth",flag=false}
  SendCommand(gameObjectId,command04)

  local command05={id="SetHumming",flag=true}
  SendCommand(gameObjectId,command05)
end

function this.SetCamoRoutes(routeBag,gameId)
  InfLog.Add("SetCamoRoutes",true)--DEBUG
  local attackRoute=routeBag:Next()
  local runRoute=routeBag:Next()
  local deadRoute=attackRoute--routeBag:Next()
  local relayRoute=routeBag:Next()
  local killRoute=routeBag:Next()

  SendCommand(gameId,{id="SetSnipeRoute",route=attackRoute,phase=0})
  SendCommand(gameId,{id="SetSnipeRoute",route=runRoute,phase=1})
  SendCommand(gameId,{id="SetDemoRoute",route=deadRoute})--tex route on death
  SendCommand(gameId,{id="SetLandingRoute",route=relayRoute})--tex nesesary else it gets stuck in jump to same position behaviour
  SendCommand(gameId,{id="SetKillRoute",route=killRoute})

  --SendCommand(gameId,{id="SetRecoveryRoute",route=recoveryRoute})--tex ?only used with quiet
  --SendCommand(gameId,{id="SetAntiHeliRoute",route=antiHeliRoute})--tex ?only used with quiet
end

function this.CamoParasiteCloseCombatMode(parasiteName,enabled)
  local command={id="SetCloseCombatMode",enabled=enabled}--tex NOTE unsure if this command is actually individual
  local gameObjectId={type="TppBossQuiet2",parasiteName}
  if gameObjectId~=NULL_ID then
    SendCommand(gameObjectId,command)
  end
end

--REF interesting functions/commands not doing anythig with yet
function this.CamoParasiteEnableFulton(enabled)
  local command={id="SetFultonEnabled",enabled=enabled}
  command.enabled = true
  local gameObjectId={type="TppBossQuiet2"}
  SendCommand(gameObjectId, command)
end

function this.CamoParasiteNarrowFarSight(parasiteName,enabled)
  local command={id="NarrowFarSight",enabled=enabled}
  local gameObjectId=GetGameObjectId("TppBossQuiet2",parasiteName)
  if gameObjectId~=NULL_ID then
    SendCommand(gameObjectId,command)
  end
end

function this.CamoParasiteWaterFallShift(enabled)
  local command = {id="SetWatherFallShift",enabled=enabled}
  local gameObjectId = { type="TppBossQuiet2" }
  SendCommand(gameObjectId, command)
end

function this.IsCamoParasite()
  local quietType=SendCommand({type="TppBossQuiet2"},{id="GetQuietType"})
  if quietType==Fox.StrCode32"Cam"then--Camo parasite, not Quiet

  end
end

--tex from quiet boss fight
this.RequestShoot = function( target )
  local command = {}

  if ( target == "player" ) then
    command = { id="ShootPlayer" }

  elseif ( target == "entrance" ) then
    command = { id="ShootPosition", position="position" }
    command.position = {-1828.670, 360.220, -132.585}

  end

  if not( command == {} ) then
    SendCommand( { type="TppBossQuiet2", index=0 }, command )
    Fox.Log("#### qest_bossQuiet_00 #### RequestShoot [ "..tostring(target).." ]")

    if ( target == "player" ) then
      local ridingGameObjectId = vars.playerVehicleGameObjectId
      if Tpp.IsHorse(ridingGameObjectId) then

        SendCommand( ridingGameObjectId, { id = "HorseForceStop" } )
      elseif( Tpp.IsPlayerWalkerGear(ridingGameObjectId) or Tpp.IsEnemyWalkerGear(ridingGameObjectId) )then

        SendCommand( ridingGameObjectId, { id = "ForceStop", enabled = true } )
      end
    end

    if (this.isPlayerRideVehicle()) then
      this.ChangeVehicleSettingForEvent()
    end
  end
end

this.SetQuietExtraRoute = function(demo,kill,recovery,antiHeli)
  local gameObjectId = GetGameObjectId("TppBossQuiet2", BOSS_QUIET )


  local command = {id="SetDemoRoute", route="route"}
  if gameObjectId ~= NULL_ID then
    command.route = demo
    SendCommand(gameObjectId, command)
  end


  command = {id="SetKillRoute", route="route"}
  if gameObjectId ~= NULL_ID then
    command.route = kill
    SendCommand(gameObjectId, command)
  end


  command = {id="SetRecoveryRoute", route="route"}
  if gameObjectId ~= NULL_ID then
    command.route = recovery
    SendCommand(gameObjectId, command)
  end


  command = {id="SetAntiHeliRoute", route="route"}
  if gameObjectId ~= NULL_ID then
    command.route = kill
    SendCommand(gameObjectId, command)
  end
end

--tex doesn't seem to be called
this.QuietKillModeChange = function()
  local command = {id="SetKill", flag="flag"}
  local gameObjectId = GetGameObjectId("TppBossQuiet2", BOSS_QUIET)

  if gameObjectId ~= NULL_ID then

    command.flag = svars.isKillMode
    SendCommand(gameObjectId, command)
  else
  end
end

this.QuietForceCombatMode = function()
  SendCommand( { type="TppBossQuiet2", index=0 }, { id="StartCombat" } )
end


this.StartQuietDeadEffect = function()
  local command = { id="StartDeadEffect" }
  local gameObjectId = { type="TppBossQuiet2", index=0 }
  SendCommand(gameObjectId, command)
end
---

function this.PointOnCircle(origin,radius,angle)
  local x=origin[1]+radius*math.cos(math.rad(angle))
  local y=origin[3]+radius*math.sin(math.rad(angle))
  return {x,origin[2],y}
end

return this
