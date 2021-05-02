-- InfParasite.lua
-- tex implements parasite/skulls unit event
local this={}

local InfCore=InfCore
local InfMain=InfMain
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
local GAME_OBJECT_TYPE_PLAYER2=TppGameObject.GAME_OBJECT_TYPE_PLAYER2

this.debugModule=false

--DATA
this.packages={
  ARMOR={
    "/Assets/tpp/pack/mission2/online/o50050/o50055_parasite_metal.fpk",
  --OFF script block WIP "/Assets/tpp/pack/mission2/ih/parasite_scriptblock.fpk",
  },
  MIST={
    "/Assets/tpp/pack/mission2/ih/ih_parasite_mist.fpk",
  --OFF script block WIP "/Assets/tpp/pack/mission2/ih/parasite_scriptblock.fpk",
  },
  CAMO={
    "/Assets/tpp/pack/mission2/ih/ih_parasite_camo.fpk",
  --OFF script block WIP "/Assets/tpp/pack/mission2/ih/parasite_scriptblock.fpk",
  },
}

--STATE
local disableFight=false--DEBUG

this.parasiteType="ARMOR"

local stateTypes={
  READY=0,
  DOWNED=1,
  FULTONED=2,
}
--tex indexed by parasiteNames
local states={}--tex TODO: going to have to save this, for camo at least, to keep in sync with internal state of downed/fultoned
local hitCounts={}
this.lastContactTime=0

--tex for current event
local numParasites=0

this.parasitePos=nil

this.routeBag=nil

this.hostageParasiteHitCount=0--tex mbqf hostage parasites

--TUNE
--tex since I'm repurposing routes buit for normal cps the camo parasites just seem to shift along a short route, or get stuck leaving and returning to same spot.
--semi workable solution is to just set new routes after the parasite has been damaged a few times.
local camoShiftRouteAttackCount=3

local triggerAttackCount=45--tex mbqf hostage parasites

--SetParameters
local PARASITE_PARAMETERS={
  EASY={--10020
    sightDistance = 20,
    sightVertical = 36.0,
    sightHorizontal = 48.0,
  },

  --ARMOR
  --o50050_enemy
  HARD = {
    sightDistance = 30,
    sightVertical = 55.0,
    sightHorizontal = 48.0,
  },


  --10090
  NORMAL = {
    sightDistance                 = 25,
    sightDistanceCombat           = 75,
    sightVertical                 = 40,
    sightHorizontal               = 60,
    noiseRate                     = 8,
    avoidSideMin                  = 8,
    avoidSideMax                  = 12,
    areaCombatBattleRange         = 50,
    areaCombatBattleToSearchTime  = 1,
    areaCombatLostSearchRange     = 1000,
    areaCombatLostToGuardTime     = 120,
    --areaCombatGuardDistance
    throwRecastTime               = 10,
  },
  --10090
  EXTREME={
    sightDistance                 = 25,
    sightDistanceCombat           = 100,
    sightVertical                 = 60,
    sightHorizontal               = 100,
    noiseRate                     = 10,
    avoidSideMin                  = 8,
    avoidSideMax                  = 12,
    areaCombatBattleRange         = 50,
    areaCombatBattleToSearchTime  = 1,
    areaCombatLostSearchRange     = 1000,
    areaCombatLostToGuardTime     = 60,
    --areaCombatGuardDistance
    throwRecastTime               = 10,
  },
}--PARASITE_PARAMETERS

--SetCombatGrade
--o50050_enemy
local PARASITE_GRADE={
  NORMAL={
    --DEBUGNOW where did I get these values from, did I actually log fob?
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

--SetCombatGrade
local PARASITE_GRADE_CAMO={
  defenseValue=4000,
  offenseGrade=2,
  defenseGrade=7,
}

--seconds
local monitorRate=10
local parasiteAppearTimeMin=5
local parasiteAppearTimeMax=10

local playerRange=175--tex choose player pos as attack pos if closest lz or cp >
--tex player distance from parasite attack pos to call off attack
local escapeDistances={
  ARMOR=250,
  MIST=0,
  CAMO=250,
}
--distsqr
playerRange=playerRange*playerRange
for paraType,escapeDistance in pairs(escapeDistances)do
  escapeDistances[paraType]=escapeDistance*escapeDistance
end

local spawnRadius={
  ARMOR=40,
  MIST=20,
  --tex since camos start moving to route when activated, and closest cp may not be that discoverable
  --or their positions even that good, spawn at player pos in a close enough radius that they spot player
  --they'll then be aiming at player when they reach the cp
  --TODO: alternatively try triggering StartCombat on camo spawn
  CAMO=10,
}

local timeOuts={
  ARMOR=0,
  MIST=1*60,
  CAMO=0,
}

--TUNE zombies
local disableDamage=false
local isHalf=false
local msfRate=10--mb only

local cpZombieLife=300
local cpZombieStamina=200

--<

this.parasiteNames={
  ARMOR={
    "Parasite0",
    "Parasite1",
    "Parasite2",
    "Parasite3",
  },
  MIST={
    "wmu_mist_ih_0000",
    "wmu_mist_ih_0001",
    "wmu_mist_ih_0002",
    "wmu_mist_ih_0003",
  },
  CAMO={
    "wmu_camo_ih_0000",
    "wmu_camo_ih_0001",
    "wmu_camo_ih_0002",
    "wmu_camo_ih_0003",
  },
}

local parasiteTypeNames={"ARMOR","MIST","CAMO"}

this.isParasiteObjectType={
  [TppGameObject.GAME_OBJECT_TYPE_PARASITE2]=true,
  [TppGameObject.GAME_OBJECT_TYPE_BOSSQUIET2]=true,
}

this.bgmList={
  ARMOR={
    bgm_metallic={
      start="Play_bgm_s10140_metallic",
      finish="Set_Switch_bgm_s10140_metallic_ed",
      restore="Set_Switch_bgm_s10140_metallic_op",
      switch={
        "Set_Switch_bgm_s10140_metallic_op",
        "Set_Switch_bgm_s10140_metallic_sn",
        "Set_Switch_bgm_s10140_metallic_al",
        "Set_Switch_bgm_s10140_metallic_ed",
      },
    },
    bgm_post_metallic={
      start="Play_bgm_s10140_post_metallic",
      finish="Stop_bgm_s10140_post_metallic",
    },
  },
}

this.registerIvars={
  "enableParasiteEvent",
  "armorParasiteEnabled",
  "mistParasiteEnabled",
  "camoParasiteEnabled",
  "parasiteWeather",
}

this.enableParasiteEvent={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckFree,
  --DEBUG mbzoo not set up (needs command post,routes), mb crashes or restart/abort for armor/mist, snipers seem to work ok (but would need to hide npcs on attack to stop it looking weird)
--  MissionCheck=function(self,missionCode)
--    if TppMission.IsFreeMission(missionCode) then return true end
--  end,
}

this.armorParasiteEnabled={
  save=IvarProc.CATEGORY_EXTERNAL,
  default=1,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.mistParasiteEnabled={
  save=IvarProc.CATEGORY_EXTERNAL,
  default=1,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.camoParasiteEnabled={
  save=IvarProc.CATEGORY_EXTERNAL,
  default=1,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

--tex See weatherTypes in StartEvent
this.parasiteWeather={
  save=IvarProc.CATEGORY_EXTERNAL,
  default=1,--parasite
  settings={"NONE","PARASITE_FOG","RANDOM"},
}

--tex time in minutes
IvarProc.MinMaxIvar(
  this,
  "parasitePeriod",
  {
    default=10,
    OnChange=function(self,setting,prevSetting)
      IvarProc.PushMax(self,setting,prevSetting)
      InfParasite.StartEventTimer()
    end,
  },
  {
    default=30,
    OnChange=function(self,setting,prevSetting)
      IvarProc.PushMin(self,setting,prevSetting)
      InfParasite.StartEventTimer()
    end,
  },
  {
    inMission=true,
    range={min=0,max=180,increment=1},
  }
)

local parasiteToggle=false
this.DEBUG_ToggleParasiteEvent=function()
  if not this.ParasiteEventEnabled() then
    InfCore.Log("InfParasite InitEvent ParasiteEventEnabled false",true)--DEBUG
    return
  end

  parasiteToggle=not parasiteToggle
  if parasiteToggle then
    InfCore.Log("DEBUG_ToggleParasiteEvent on",false,true)
    this.InitEvent()
    this.StartEvent()
  else
    InfCore.Log("DEBUG_ToggleParasiteEvent off",false,true)
    this.EndEvent()
  end
end--DEBUG_ToggleParasiteEvent
--< ivar defs

function this.PreModuleReload()
  local timers={
    "Timer_ParasiteEvent",
    "Timer_ParasiteAppear",
    "Timer_ParasiteCombat",
    "Timer_ParasiteMonitor",
    "Timer_ParasiteUnrealize",
  }
  for i,timerName in ipairs(timers)do
    TimerStop(timerName)
  end
end

function this.OnLoad(nextMissionCode,currentMissionCode)
  if not this.ParasiteEventEnabled(nextMissionCode) then
    return
  end

  InfMain.RandomSetToLevelSeed()

  local enabledTypes={
    ARMOR=Ivars.armorParasiteEnabled:Is(1),
    MIST=Ivars.mistParasiteEnabled:Is(1),
    CAMO=Ivars.camoParasiteEnabled:Is(1),
  }

  --tex WORKAROUND quiet battle, will crash with CAMO (which also use TppBossQuiet2)
  if TppQuest.IsActive"waterway_q99010" then
    InfCore.Log("InfParasite.Onload - IsActive'waterway_q99010', changing from CAMO to MIST")--DEBUGNOW TODO triggering when I wouldnt have expected it to
    enabledTypes.CAMO=false
  end
  --tex WORKAROUND zoo currently has no routes for sniper
  if nextMissionCode==30150 then
    enabledTypes.CAMO=false
  end
  --tex WORKAROUND mb crashes on armor/mist
  if nextMissionCode==30050 then
    enabledTypes.ARMOR=false
    enabledTypes.MIST=false
  end

  local parasiteTypes={}

  local allDisabled=true
  for paraType,enabled in pairs(enabledTypes) do
    if enabled then
      table.insert(parasiteTypes,paraType)
      allDisabled=false
    end
  end

  if allDisabled then
    table.insert(parasiteTypes,"ARMOR")
  end

  this.parasiteType=parasiteTypes[math.random(#parasiteTypes)]

  --tex DEBUG
  --TODO force type via ivar
  --this.parasiteType="MIST"
  --this.parasiteType="ARMOR"
  --this.parasiteType="CAMO"

  InfCore.Log("OnLoad parasiteType:"..this.parasiteType)

  InfMain.RandomResetToOsTime()
end

function this.AddMissionPacks(missionCode,packPaths)
  if not this.ParasiteEventEnabled(missionCode)then
    return
  end

  --OFF script block WIP packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/ih/parasite_scriptblock.fpk"
  for i,packagePath in ipairs(this.packages[this.parasiteType])do
    packPaths[#packPaths+1]=packagePath
  end
end

function this.MissionPrepare()
  if not this.ParasiteEventEnabled() then
    return
  end

  --OFF script block WIP TppScriptBlock.RegisterCommonBlockPackList("parasite_block",this.packages)
end

function this.Init(missionTable)
  this.messageExecTable=nil

  if not this.ParasiteEventEnabled() then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.OnReload(missionTable)
  this.messageExecTable=nil

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
          this.OnFulton(gameId)
        end
      },
      {msg="FultonFailed",
        func=function(gameId,locatorName,locatorNameUpper,failureType)
          if failureType==TppGameObject.FULTON_FAILED_TYPE_ON_FINISHED_RISE then
            this.OnFulton(gameId)
          end
        end
      },
    },
    Timer={
      {msg="Finish",sender="Timer_ParasiteEvent",func=this.StartEvent},
      {msg="Finish",sender="Timer_ParasiteAppear",func=this.Timer_ParasiteAppear},
      {msg="Finish",sender="Timer_ParasiteCombat",func=this.Timer_StartCombat},
      {msg="Finish",sender="Timer_ParasiteMonitor",func=this.Timer_MonitorEvent},
      {msg="Finish",sender="Timer_ParasiteUnrealize",func=this.Timer_ParasiteUnrealize},
    },
    UI={
      {msg="EndFadeIn",sender="FadeInOnGameStart",func=this.FadeInOnGameStart},--fires on: most mission starts, on-foot free and story missions, not mb on-foot, but does mb heli start
    },
  }
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this.DeclareSVars()
  if not this.ParasiteEventEnabled() then
    return{}
  end
  local saveVarsList = {
    inf_parasiteEvent=false,
    --tex engine sets svars.parasiteSquadMarkerFlag when camo parasite marked, will crash if svar not defined
    parasiteSquadMarkerFlag={name="parasiteSquadMarkerFlag",type=TppScriptVars.TYPE_BOOL,arraySize=4,value=false,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_RETRY},
  }
  return TppSequence.MakeSVarsTable(saveVarsList)
end

function this.OnMissionCanStart()
  if not this.ParasiteEventEnabled() then
    return
  end

  this.InitEvent()
end

function this.FadeInOnGameStart()
  if not this.ParasiteEventEnabled() then
    return
  end

  if Ivars.enableParasiteEvent:Is(0) then
    return
  end

  if svars.inf_parasiteEvent then
    if TppMission.IsMissionStart() then
      InfCore.Log"InfParasite mission start, clear, StartEventTimer"
      this.EndEvent()
      this.StartEventTimer()
    else
      InfCore.Log"InfParasite mission start ContinueEvent"
      local continueTime=math.random(parasiteAppearTimeMin,parasiteAppearTimeMax)
      this.StartEventTimer(continueTime)
    end
  else
    InfCore.Log"InfParasite mission start StartEventTimer"
    this.StartEventTimer()
  end
end

function this.ParasiteEventEnabled(missionCode)
  local missionCode=missionCode or vars.missionCode
  if Ivars.enableParasiteEvent:Is(1) and (Ivars.enableParasiteEvent:MissionCheck(missionCode) or missionCode==30250) then
    return true
  end
  return false
end

function this.SetupParasites()
  if this.parasiteType~="CAMO" then
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
end

function this.OnDamage(gameId,attackId,attackerId)
  local typeIndex=GetTypeIndex(gameId)

  if typeIndex==GAME_OBJECT_TYPE_HOSTAGE2 then
    --tex dont block if parasite events off so player can always manually trigger event
    if vars.missionCode==30250 then
      this.OnDamageMbqfParasite(gameId,attackId,attackerId)
    end
    return
  end

  if not this.ParasiteEventEnabled() then
    return
  end

  local attackerIndex=GetTypeIndex(attackerId)
  if typeIndex==GAME_OBJECT_TYPE_PLAYER2 then
    if this.isParasiteObjectType[attackerIndex] then
      this.lastContactTime=Time.GetRawElapsedTimeSinceStartUp()+timeOuts[this.parasiteType]
      this.parasitePos={vars.playerPosX,vars.playerPosY,vars.playerPosZ}
    end
    return
  end

  if not this.isParasiteObjectType[typeIndex] then
    return
  end

  local parasiteIndex=0
  for index,parasiteName in ipairs(this.parasiteNames[this.parasiteType]) do
    local parasiteId=GetGameObjectId(parasiteName)
    if parasiteId~=nil and parasiteId==gameId then
      parasiteIndex=index
      break
    end
  end
  if parasiteIndex==0 then
    return
  end

  if attackerIndex==GAME_OBJECT_TYPE_PLAYER2 then
    this.lastContactTime=Time.GetRawElapsedTimeSinceStartUp()+timeOuts[this.parasiteType]
    this.parasitePos={vars.playerPosX,vars.playerPosY,vars.playerPosZ}
  end

  if typeIndex==GAME_OBJECT_TYPE_BOSSQUIET2 then
    if not this.ParasiteEventEnabled() then
      return
    end
    this.OnDamageCamoParasite(parasiteIndex,gameId)
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
  --InfCore.DebugPrint"OnDamage"--DEBUG

  local isHostage=false
  for i,parasiteName in pairs(hostageParasites) do
    local parasiteHostage=GetGameObjectId(parasiteName)
    if gameId==parasiteHostage then
      isHostage=true
      break
    end
  end

  if isHostage then
    this.hostageParasiteHitCount=this.hostageParasiteHitCount+1
    InfCore.Log("hostageParasiteHitCount "..this.hostageParasiteHitCount,this.debugModule)--DEBUG

    if this.hostageParasiteHitCount>triggerAttackCount then
      this.hostageParasiteHitCount=0
      this.StartEvent()
    end
  end
end

function this.OnDamageCamoParasite(parasiteIndex,gameId)
  if states[parasiteIndex]==stateTypes.READY then
    hitCounts[parasiteIndex]=hitCounts[parasiteIndex]+1
    if hitCounts[parasiteIndex]>=camoShiftRouteAttackCount then
      hitCounts[parasiteIndex]=0
      this.SetCamoRoutes(this.routeBag,gameId)
    end
  end
end

function this.OnDying(gameId)
  --InfCore.PCall(function(gameId)--DEBUG
  local parasiteType=nil
  local typeIndex=GetTypeIndex(gameId)
  if not this.isParasiteObjectType[typeIndex] then
    return
  end
  if not this.ParasiteEventEnabled() then
    return
  end

  local parasiteIndex=0
  for index,parasiteName in ipairs(this.parasiteNames[this.parasiteType]) do
    local parasiteId=GetGameObjectId(parasiteName)
    if parasiteId~=nil and parasiteId==gameId then
      parasiteIndex=index
      break
    end
  end
  if parasiteIndex==0 then
    return
  end

  states[parasiteIndex]=stateTypes.DOWNED

  if this.debugModule then
    InfCore.Log("OnDying is para",true)
  end
  InfCore.PrintInspect(states,{varName="states"})--DEBUG

  local numCleared=this.GetNumCleared()
  if numCleared==numParasites then
    InfCore.Log("InfParasite OnDying: all eliminated")--DEBUG
    this.EndEvent()
  end
  --end,gameId)--
end

function this.OnFulton(gameId,gimmickInstance,gimmickDataSet,stafforResourceId)
  --InfCore.PCall(function(gameId)--DEBUG
  local typeIndex=GetTypeIndex(gameId)
  if not this.isParasiteObjectType[typeIndex] then
    return
  end
  if not this.ParasiteEventEnabled() then
    return
  end

  local parasiteIndex=0
  for index,parasiteName in ipairs(this.parasiteNames[this.parasiteType]) do
    local parasiteId=GetGameObjectId(parasiteName)
    if parasiteId~=nil and parasiteId==gameId then
      parasiteIndex=index
      break
    end
  end
  if parasiteIndex==0 then
    return
  end

  states[parasiteIndex]=stateTypes.FULTONED

  InfCore.PrintInspect(states,{varName="states"})

  local numCleared=this.GetNumCleared()
  if numCleared==numParasites then
    InfCore.Log("InfParasite OnFulton: all eliminated")--DEBUG
    this.EndEvent()
  end
  --end,gameId)--
end

function this.InitEvent()
  --InfCore.PCall(function()--DEBUG
  InfCore.Log("InfParasite InitEvent")--DEBUG

  if not this.ParasiteEventEnabled() then
    InfCore.Log("InfParasite InitEvent ParasiteEventEnabled false")--DEBUG
    return
  end

  if this.parasiteType=="CAMO" then
    for i,parasiteName in ipairs(this.parasiteNames[this.parasiteType]) do
      this.CamoParasiteOff(parasiteName)
    end
  else
    for i,parasiteName in ipairs(this.parasiteNames[this.parasiteType]) do
      this.AssaultParasiteOff(parasiteName)
    end
  end

  this.hostageParasiteHitCount=0

  numParasites=#this.parasiteNames[this.parasiteType]

  this.SetupParasites()

  if TppMission.IsMissionStart() then
    InfCore.Log"InfParasite InitEvent IsMissionStart clear"--DEBUG
    svars.inf_parasiteEvent=false
  end

  if not InfMain.IsContinue() then
    for index,state in ipairs(this.parasiteNames[this.parasiteType])do
      states[index]=stateTypes.READY
      hitCounts[index]=0
    end
  end
  --end)--
end

local Timer_ParasiteEventStr="Timer_ParasiteEvent"
function this.StartEventTimer(time)
  --InfCore.PCall(function(time)--DEBUG
  if not this.ParasiteEventEnabled() then
    return
  end

  if Ivars.enableParasiteEvent:Is(0) then
    return
  end

  local numCleared=this.GetNumCleared()
  if numCleared==numParasites then
    InfCore.Log("StartEventTimer numCleared==numParasites aborting")
    this.EndEvent()
    return
  end

  local minute=60
  local nextEventTime=time or math.random(Ivars.parasitePeriod_MIN:Get()*minute,Ivars.parasitePeriod_MAX:Get()*minute)
  --local nextEventTime=10--DEBUG
  InfCore.Log("Timer_ParasiteEvent start in "..nextEventTime,this.debugModule)--DEBUG

  --OFF script block WIP
  --tex fails due to invalid blockId. I can't figure out how fox assigns blockIds.
  --ScriptBlocks that aren't used for the current mission return invalid,
  --but as the scriptblock definitions are in the scriptblock fpk itself there's a chicken and egg problem if they're what is used to define the script block name.
  --  local success=TppScriptBlock.Load("parasite_block",this.parasiteType,true,true)--DEBUGNOW TODO only start once block loaded and active
  --  if not success then
  --    InfCore.Log("WARNING: InfParasite TppScriptBlock.Load returned false")--DEBUG
  --  end

  TimerStop(Timer_ParasiteEventStr)
  TimerStart(Timer_ParasiteEventStr,nextEventTime)
  --end,time)--
end

function this.StartEvent()
  InfCore.Log("InfParasite StartEvent")
  if IsTimerActive(Timer_ParasiteEventStr)then
    TimerStop(Timer_ParasiteEventStr)
  end

  local numCleared=this.GetNumCleared()
  if numCleared==numParasites then
    InfCore.Log("InfParasite StartEvent numCleared==numParasites ("..tostring(numCleared).."=="..tostring(numParasites)..") aborting",this.debugModule)
    this.EndEvent()
    return
  end

  svars.inf_parasiteEvent=true--DEBUGNOW uhh, why was I using svars again?

  --GOTCHA: for some reason always seems to fire parasite effect if this table is defined local to module/at module load time, even though inspecting fogType it seems fine? VERIFY
  local weatherTypes={
    {weatherType=TppDefine.WEATHER.FOGGY,fogInfo={fogDensity=0.15,fogType=WeatherManager.FOG_TYPE_PARASITE}},
    {weatherType=TppDefine.WEATHER.RAINY,fogInfo=nil},
    --{weatherType=TppDefine.WEATHER.SANDSTORM,fogInfo=nil},--tex too difficult to discover non playerpos appearances
    {weatherType=TppDefine.WEATHER.FOGGY,fogInfo={fogDensity=0.15,fogType=WeatherManager.FOG_TYPE_NORMAL}},
  }

  local weatherInfo
  if Ivars.parasiteWeather:Is"PARASITE_FOG" then
    weatherInfo=weatherTypes[1]
  elseif Ivars.parasiteWeather:Is"RANDOM" then
    weatherInfo=weatherTypes[math.random(#weatherTypes)]
  end

  if weatherInfo then
    if weatherInfo.fogInfo then
      weatherInfo.fogInfo.fogDensity=math.random(0.001,0.9)
    end

    TppWeather.ForceRequestWeather(weatherInfo.weatherType,4,weatherInfo.fogInfo)
  end

  local parasiteAppearTime=math.random(parasiteAppearTimeMin,parasiteAppearTimeMax)
  TimerStart("Timer_ParasiteAppear",parasiteAppearTime)
end

--tex have to indirect/wrap this since the address in the timer doesnt get refreshed on module reload
function this.Timer_ParasiteAppear()
  this.ParasiteAppear()
end

function this.ParasiteAppear()
  InfCore.PCallDebug(function()--DEBUG
    InfCore.LogFlow("InfParasite ParasiteAppear")
    local playerPos={vars.playerPosX,vars.playerPosY,vars.playerPosZ}
    local closestPos=playerPos
    local closestDist=999999999999999

    local isMb=vars.missionCode==30050 or vars.missionCode==30250
    local noCps=false

    local closestCp,cpDistance,cpPosition

    if noCps then
		  InfCore.Log("InfParasite.ParasiteAppear noCps")
      closestPos=playerPos
    else
      closestCp,cpDistance,cpPosition=InfMain.GetClosestCp(playerPos)
      if closestCp==nil or cpPosition==nil then
        InfCore.Log("WARNING: InfParasite ParasiteAppear closestCp==nil")--DEBUG
        closestPos=playerPos
      else
      closestDist=cpDistance

      if not isMb then--tex TODO: implement for mb
        local closestLz,lzDistance,lzPosition=InfLZ.GetClosestLz(playerPos)
        if closestLz==nil or lzPosition==nil then
            InfCore.Log("WARNING: InfParasite ParasiteAppear closestLz==nil")--DEBUG
          else
        local lzCpDist=TppMath.FindDistance(lzPosition,cpPosition)
        closestPos=cpPosition
        if cpDistance>lzDistance and lzCpDist>playerRange*2 then
          closestPos=lzPosition
          closestDist=lzDistance
        end
          end--if closestLz
        end--if no isMb

      if closestDist>playerRange then
        closestPos=playerPos
      end
      end--if closestCp
    end--if not noCps

    InfCore.Log("ParasiteAppear "..this.parasiteType.." closestCp:"..tostring(closestCp),this.debugModule)

    this.lastContactTime=Time.GetRawElapsedTimeSinceStartUp()+timeOuts[this.parasiteType]

    if this.parasiteType=="CAMO" then
      this.parasitePos=playerPos
      this.CamoParasiteAppear(playerPos,closestCp,cpPosition,spawnRadius[this.parasiteType])
    elseif this.parasiteType=="MIST" then
      this.parasitePos=closestPos
      this.ArmorParasiteAppear(playerPos,spawnRadius[this.parasiteType])
    elseif this.parasiteType=="ARMOR" then
      this.parasitePos=closestPos
      this.ArmorParasiteAppear(closestPos,spawnRadius[this.parasiteType])
    end

    if isMb then
      this.ZombifyMB()
    else
      this.ZombifyFree(closestCp,this.parasitePos)
    end

    --tex once one armor parasite has been fultoned the rest will be stuck in some kind of idle ai state on next appearance
    --forcing combat bypasses this
    local armorFultoned=false
    for index,state in ipairs(this.parasiteNames[this.parasiteType])do
      if state==stateTypes.FULTONED then
        armorFultoned=true
      end
    end
    if armorFultoned and this.parasiteType=="ARMOR" then
      --InfCore.Log("Timer_ParasiteCombat start",true)--DEBUG
      TimerStart("Timer_ParasiteCombat",4)
    end

    TimerStart("Timer_ParasiteMonitor",monitorRate)
  end)--
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

local SetZombies=function(soldierNames,position,radius)
  for i,soldierName in ipairs(soldierNames) do
    local gameId=GetGameObjectId("TppSoldier2",soldierName)
    if gameId~=NULL_ID then
      local soldierPosition=SendCommand(gameId,{id="GetPosition"})
      local soldierDistance=0
      if position then
        soldierDistance=TppMath.FindDistance({soldierPosition:GetX(),soldierPosition:GetY(),soldierPosition:GetZ()},position)
      end
      if not position or (radius and soldierDistance<radius) then
        --InfCore.Log(soldierName.." close to "..closestCp.. ", zombifying",true)--DEBUG
        this.SetZombie(soldierName,disableDamage,isHalf,cpZombieLife,cpZombieStamina)
      end
    end
  end
end

function this.ZombifyFree(closestCp,position)
  local radius=escapeDistances[this.parasiteType]

  --tex soldiers of closestCp
  if closestCp then
    local cpDefine=mvars.ene_soldierDefine[closestCp]
    if cpDefine==nil then
      InfCore.Log("WARNING InfParasite StartEvent could not find cpdefine for "..closestCp)--DEBUG
    else
      SetZombies(cpDefine)
    end
  end

  --tex IH free roam foot lrrps
  if InfMainTpp.lrrpDefines then
    for cpName,lrrpDefine in pairs(InfMainTpp.lrrpDefines) do
      if lrrpDefine.base1==closestCp or lrrpDefine.base2==closestCp then
        SetZombies(lrrpDefine.cpDefine,position,radius)
      end
    end
  end

  --tex TODO doesn't cover vehicle lrrp

  if mvars.ene_soldierDefine and mvars.ene_soldierDefine.quest_cp then
    SetZombies(mvars.ene_soldierDefine.quest_cp,position,radius)
  end
end

function this.ArmorParasiteAppear(parasitePos,spawnRadius)
  InfCore.Log("InfParasite ArmorParasiteAppear spawnRadius:"..spawnRadius)
  if this.debugModule then
    InfCore.PrintInspect(parasitePos,"parasitePos")
  end
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

  for k,parasiteName in pairs(this.parasiteNames[this.parasiteType]) do
    local gameId=GetGameObjectId(parasiteName)
    if gameId==NULL_ID then
      InfCore.Log("WARNING: "..parasiteName.. " not found",true)
    end
  end

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
function this.CamoParasiteAppear(parasitePos,closestCp,cpPosition,spawnRadius)
  --InfCore.Log"CamoParasiteAppear"--DEBUG
  --tex camo parasites rely on having route set, otherwise they'll do a constant grenade drop evade on the same spot
  local routeCount,cpRoutes=this.GetRoutes(closestCp)

  --  InfCore.PrintInspect("CamoParasiteAppear cpRoutes")--DEBUG
  --  InfCore.PrintInspect(cpRoutes)

  if routeCount<numParasites then
    InfCore.Log("WARNING: InfParasite CamoParasiteAppear - routeCount< #camo parasites",true)
    return
  end

  this.routeBag=InfUtil.ShuffleBag:New()
  for route,bool in pairs(cpRoutes) do
    this.routeBag:Add(route)
  end

  for index,parasiteName in ipairs(this.parasiteNames.CAMO) do
    if states[index]==stateTypes.READY then
      local gameId=GetGameObjectId("TppBossQuiet2",parasiteName)
      if gameId==NULL_ID then
        InfCore.Log("WARNING: InfParasite CamoParasiteAppear - "..parasiteName.. " not found",true)
      else
        local parasiteRotY=0

        InfCore.Log(parasiteName.." appear",this.debugModule)

        --ASSUMPTION 4 parasites
        --half circle with 2 leads
        --local angle=360/i

        --4 quadrants
        local angle=90*(index-1)
        local spawnPos=this.PointOnCircle(parasitePos,spawnRadius,angle)

        this.SetCamoRoutes(this.routeBag,gameId)

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

  return parasitePos
end
--DEBUGNOW get working for MB
function this.GetRoutes(cpName)
  local routeSets=mvars.ene_routeSetsDefine[cpName]
  if not routeSets then
    InfCore.Log"WARNING: InfParasite  CamoParasiteAppear - no routesets found, aborting"
    return
  end

  local cpRoutes={}
  --tex TODO prioritze picking sniper group first?
  if routeSets==nil then
    InfCore.Log("WARNING: InfParasite CamoParasiteAppear no routesets for "..cpName,true)--DEBUG
    return
  end

  local routeCount=0
  for i,phaseName in ipairs(phases)do
    local phaseRoutes=routeSets[phaseName]
    if phaseRoutes then
      for i,groupName in ipairs(groups)do--tex TODO read groups from routeSet .priority instead
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
  return routeCount,cpRoutes
end--GetRoutes

function this.Timer_StartCombat()
  SendCommand({type="TppParasite2"},{id="StartCombat"})
end

function this.Timer_MonitorEvent()
  --  InfCore.PCall(function()--DEBUG
  --InfCore.Log("MonitorEvent",true)
  if svars.inf_parasiteEvent==false then
    return
  end

  if this.parasitePos==nil then
    InfCore.Log("WARNING InfParasite MonitorEvent parasitePos==nil",true)--DEBUG
    return
  end

  local outOfRange=false
  local playerPos={vars.playerPosX,vars.playerPosY,vars.playerPosZ}
  local distSqr=TppMath.FindDistance(playerPos,this.parasitePos)
  local escapeDistance=escapeDistances[this.parasiteType]
  if escapeDistance>0 and distSqr>escapeDistance then
    outOfRange=true
  end

  --InfCore.Log("Timer_MonitorEvent "..this.parasiteType.. " escapeDistanceSqr:"..escapeDistance.." distSqr:"..distSqr)--DEBUG
  --InfCore.Log("dist:"..math.sqrt(distSqr),true)--DEBUG

  --tex TppParasites aparently dont support GetPosition, frustrating inconsistancy, you'd figure it would be a function of all gameobjects
  --  for i,parasiteName in pairs(this.parasiteNames.ARMOR) do
  --    local gameId=GetGameObjectId(parasiteName)
  --    if gameId~=NULL_ID then
  --      local parasitePos=SendCommand(gameId,{id="GetPosition"})
  --      local distSqr=TppMath.FindDistance(playerPos,{parasitePos:GetX(),parasitePos:GetY(),parasitePos:GetZ()})
  --     -- InfCore.Log(parasiteName.." dist:"..math.sqrt(distSqr),true)--DEBUG
  --      if distSqr<escapeDistance[this.parasiteType] then
  --        outOfRange=false
  --        break
  --      end
  --    end
  --  end
  if this.parasiteType=="CAMO" then
    for index,parasiteName in pairs(this.parasiteNames.CAMO) do
      if states[index]==stateTypes.READY then
        local gameId=GetGameObjectId("TppBossQuiet2",parasiteName)
        if gameId~=NULL_ID then
          local parasitePos=SendCommand(gameId,{id="GetPosition"})
          local distSqr=TppMath.FindDistance(playerPos,{parasitePos:GetX(),parasitePos:GetY(),parasitePos:GetZ()})
          InfCore.Log("Monitor: "..parasiteName.." dist:"..math.sqrt(distSqr),this.debugModule)--DEBUG
          if distSqr<escapeDistance then
            outOfRange=false
            break
          end
        end
      end
    end
  end

  if this.parasiteType=="MIST" then
    if distSqr>playerRange then
      InfCore.Log("MonitorEvent: > playerRange",this.debugModule)
      InfCore.Log("MonitorEvent: lastcontactTime:"..this.lastContactTime,this.debugModule)
      if this.lastContactTime<Time.GetRawElapsedTimeSinceStartUp() then
        InfCore.Log("MonitorEvent: lastContactTime timeout, starting combat",this.debugModule)
        --SendCommand({type="TppParasite2"},{id="StartCombat"})
        this.parasitePos=playerPos
        this.ParasiteAppear()
      end
    end
  end

  if outOfRange then
    InfCore.Log("MonitorEvent: out of range :"..math.sqrt(distSqr).."> "..math.sqrt(escapeDistance).. ", ending event",this.debugModule)
    this.EndEvent()
    TimerStop("Timer_ParasiteMonitor")
    this.StartEventTimer()
  else
    TimerStart("Timer_ParasiteMonitor",monitorRate)
  end
  --end)--
end

function this.EndEvent()
  InfCore.Log("InfParasite EndEvent",this.debugModule)

  svars.inf_parasiteEvent=false
  TppWeather.CancelForceRequestWeather(TppDefine.WEATHER.SUNNY,7)

  SendCommand({type="TppParasite2"},{id="StartWithdrawal"})

  --tex TODO throw CAMO parasites to some far route (or warprequest if it doesn't immediately vanish them) then Off them after a while

  TimerStart("Timer_ParasiteUnrealize",6)
end

function this.Timer_ParasiteUnrealize()
  if this.parasiteType=="CAMO" then
    for index,parasiteName in ipairs(this.parasiteNames.CAMO) do
      if states[index]==stateTypes.READY then--tex can leave behind non fultoned
        this.CamoParasiteOff(parasiteName)
      end
    end
  else
    --tex possibly not nessesary for ARMOR parasites, but MIST parasites have a bug where they'll
    --withdraw to wherever the withdraw postion is but keep making the warp noise constantly.
    for index,parasiteName in ipairs(this.parasiteNames[this.parasiteType]) do
      if states[index]==stateTypes.READY then
        this.AssaultParasiteOff(parasiteName)
      end
    end
  end
end

function this.GetNumCleared()
  local numCleared=0
  for i,state in pairs(states)do
    if state~=stateTypes.READY then
      numCleared=numCleared+1
    end
  end
  return numCleared
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

--
function this.AssaultParasiteOff(parasiteName)
  local gameId=GetGameObjectId("TppParasite2",parasiteName)
  if gameId~=NULL_ID then
    SendCommand(gameId,{id="Unrealize"})
  end
end

--camo zombies/TppBossQuiet2
function this.CamoParasiteOff(parasiteName)
  local gameObjectId=GetGameObjectId("TppBossQuiet2",parasiteName)

  if gameObjectId~=NULL_ID then
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
  InfCore.Log("SetCamoRoutes",this.debugModule)--DEBUG
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
--armor, from fob
--this.StartSearchParasite = function ()
--  Fox.Log("***** this.StartSearchParasite *****")
--
--  for k, parasiteName in pairs(this.PARASITE_NAME_LIST) do
--    local gameObjectId = GameObject.GetGameObjectId(parasiteName)
--    if gameObjectId ~= nil then
--      GameObject.SendCommand( gameObjectId, { id="StartSearch" })
--    end
--  end
--end

--camo
--function this.CamoParasiteEnableFulton(enabled)
--  local command={id="SetFultonEnabled",enabled=enabled}
--  command.enabled = true
--  local gameObjectId={type="TppBossQuiet2"}
--  SendCommand(gameObjectId, command)
--end

--function this.CamoParasiteNarrowFarSight(parasiteName,enabled)
--  local command={id="NarrowFarSight",enabled=enabled}
--  local gameObjectId=GetGameObjectId("TppBossQuiet2",parasiteName)
--  if gameObjectId~=NULL_ID then
--    SendCommand(gameObjectId,command)
--  end
--end

--function this.CamoParasiteWaterFallShift(enabled)
--  local command = {id="SetWatherFallShift",enabled=enabled}
--  local gameObjectId = { type="TppBossQuiet2" }
--  SendCommand(gameObjectId, command)
--end

--function this.IsCamoParasite()
--  local quietType=SendCommand({type="TppBossQuiet2"},{id="GetQuietType"})
--  if quietType==InfCore.StrCode32"Cam"then--Camo parasite, not Quiet
--
--  end
--end

--tex REF from quiet boss fight s10050_enemy
--this.RequestShoot = function( target )
--  local command = {}
--
--  if ( target == "player" ) then
--    command = { id="ShootPlayer" }
--
--  elseif ( target == "entrance" ) then
--    command = { id="ShootPosition", position="position" }
--    command.position = {-1828.670, 360.220, -132.585}
--
--  end
--
--  if not( command == {} ) then
--    SendCommand( { type="TppBossQuiet2", index=0 }, command )
--    Fox.Log("#### qest_bossQuiet_00 #### RequestShoot [ "..tostring(target).." ]")
--
--    if ( target == "player" ) then
--      local ridingGameObjectId = vars.playerVehicleGameObjectId
--      if Tpp.IsHorse(ridingGameObjectId) then
--
--        SendCommand( ridingGameObjectId, { id = "HorseForceStop" } )
--      elseif( Tpp.IsPlayerWalkerGear(ridingGameObjectId) or Tpp.IsEnemyWalkerGear(ridingGameObjectId) )then
--
--        SendCommand( ridingGameObjectId, { id = "ForceStop", enabled = true } )
--      end
--    end
--
--    if (this.isPlayerRideVehicle()) then
--      this.ChangeVehicleSettingForEvent()
--    end
--  end
--end
--REF s10050_enemy
--local BOSS_QUIET  = "BossQuietGameObjectLocator"
--this.SetQuietExtraRoute = function(demo,kill,recovery,antiHeli)
--  local gameObjectId = GetGameObjectId("TppBossQuiet2", BOSS_QUIET )
--
--
--  local command = {id="SetDemoRoute", route="route"}
--  if gameObjectId ~= NULL_ID then
--    command.route = demo
--    SendCommand(gameObjectId, command)
--  end
--
--
--  command = {id="SetKillRoute", route="route"}
--  if gameObjectId ~= NULL_ID then
--    command.route = kill
--    SendCommand(gameObjectId, command)
--  end
--
--
--  command = {id="SetRecoveryRoute", route="route"}
--  if gameObjectId ~= NULL_ID then
--    command.route = recovery
--    SendCommand(gameObjectId, command)
--  end
--
--
--  command = {id="SetAntiHeliRoute", route="route"}
--  if gameObjectId ~= NULL_ID then
--    command.route = kill
--    SendCommand(gameObjectId, command)
--  end
--end
--REF s10050_enemy
--tex doesn't seem to be called
--this.QuietKillModeChange = function()
--  local command = {id="SetKill", flag="flag"}
--  local gameObjectId = GetGameObjectId("TppBossQuiet2", BOSS_QUIET)
--
--  if gameObjectId ~= NULL_ID then
--
--    command.flag = svars.isKillMode
--    SendCommand(gameObjectId, command)
--  else
--  end
--end
--REF s10050_enemy
--this.QuietForceCombatMode = function()
--  SendCommand( { type="TppBossQuiet2", index=0 }, { id="StartCombat" } )
--end
--REF s10050_enemy
--this.StartQuietDeadEffect = function()
--  local command = { id="StartDeadEffect" }
--  local gameObjectId = { type="TppBossQuiet2", index=0 }
--  SendCommand(gameObjectId, command)
--end
---

function this.PointOnCircle(origin,radius,angle)
  local x=origin[1]+radius*math.cos(math.rad(angle))
  local y=origin[3]+radius*math.sin(math.rad(angle))
  return {x,origin[2],y}
end

this.langStrings={
  eng={
    enableParasiteEvent="Enable Skull attacks in Free roam",
    parasitePeriod_MIN="Skull attack min (minutes)",
    parasitePeriod_MAX="Skull attack max (minutes)",
    parasiteWeather="Weather on Skull attack",
    parasiteWeatherSettings={"None","Parasite fog","Random"},
    armorParasiteEnabled="Allow armor skulls",
    mistParasiteEnabled="Allow mist skulls",
    camoParasiteEnabled="Allow sniper skulls",
  },
  help={
    eng={
      enableParasiteEvent="Skulls attack at a random time (in minutes) between Skull attack min and Skull attack max settings.",
    },
  }
}

return this
