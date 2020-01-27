-- InfGameEvent.lua
-- system relies on preventing saved ivar values from restoring (search inf_event) and using it's own profile settings with level seed to ensure randomisation is the same
local this={}

local InfCore=InfCore
local InfMain=InfMain

this.forceEvent=false
this.inf_enabledEvents={}
this.doInjury=false

function this.PostModuleReload(prevModule)
  this.forceEvent=prevModule.forceEvent
  this.inf_enabledEvents=prevModule.inf_enabledEvents
end

function this.DisableEvent()
  local eventMissions={
    [30010]=true,
    [30020]=true,
    [30050]=true,
  }

  if eventMissions[vars.missionCode] then
    if igvars.inf_event~=false then
      igvars.inf_event=false
      this.inf_enabledEvents={}
      --DEBUGNOW
      local IvarProc=IvarProc
      for name,ivar in pairs(Ivars) do
        if IvarProc.IsIvar(ivar) then
          IvarProc.UpdateSettingFromGvar(ivar)
        end
      end
    end
  end
end

function this.OnMissionCanStart()
  if not igvars.inf_event then
    return
  end

  this.DisableLzs()

  this.doInjury=false
  if this.inf_enabledEvents.CRASHLAND then
    InfCore.Log"InfGameEvent.OnMissionCanStart event CRASHLAND"
    if TppMission.IsMissionStart() then
      TppHero.SetAndAnnounceHeroicOgrePoint({heroicPoint=-1,ogrePoint=-1},"destroyed_support_heli")

      local rndHours=math.random(0,23)
      local rndMinutes=math.random(0,60)
      local rndSeconds=0--math.random(0,60)
      local startTime=string.format("%02d:%02d:%02d",rndHours,rndMinutes,rndSeconds)
      --InfCore.DebugPrint("crashland startTime="..startTime)--DEBUG
      gvars.missionStartClock=TppClock.ParseTimeString(startTime,"number")
      vars.clock=gvars.missionStartClock

      local stances={
        PlayerStance.STAND,
        PlayerStance.SQUAT,
        PlayerStance.CRAWL,
      }
      Player.RequestToSetTargetStance(stances[math.random(#stances)])
      Player.SetForceInjury{type=math.random(1,3)}
    end
  end
end

function this.GenerateEvent(missionCode)
  --InfCore.PCallDebug(function(misisonCode)--DEBUGOW
  if not this.forceEvent and not IvarProc.EnabledForMission("gameEventChance",missionCode) then
    return
  end

  InfMain.RandomSetToLevelSeed()
  local randomTriggered=math.random(100)<Ivars.gameEventChanceFREE:Get()
  if missionCode==30050 then
    randomTriggered=math.random(100)<Ivars.gameEventChanceMB:Get()
  end

  --tex some of these have been getting stuck on for some users even though they are only applied with noSave
  if Ivars.mbWarGamesProfile:Is(0) then
    local clearVars={
      --mbDDEquipNonLethal=0,
      mbHostileSoldiers=0,
      mbNonStaff=0,
      mbEnableFultonAddStaff=0,
      mbZombies=0,
      mbEnemyHeli=0,
    }
    IvarProc.ApplyProfile(clearVars)
  end

  if this.forceEvent or randomTriggered or igvars.inf_event then
    InfCore.Log("InfGameEvent.GenerateEvent missionCode:"..missionCode)--DEBUG
    --    InfCore.DebugPrint("GenerateEvent actual "..missionCode)--DEBUG
    --    InfCore.DebugPrint("inf_levelSeed:"..tostring(igvars.inf_levelSeed))--DEBUG


    if missionCode==30050 then
      this.GenerateWarGameEvent(missionCode)
    elseif missionCode==30010 or missionCode==30020 then
      this.GenerateRoamEvent(missionCode)
    end

    this.forceEvent=false

    InfCore.PrintInspect(this.inf_enabledEvents,{varName="InfGameEvent.inf_enabledEvents"})
  end
  InfMain.RandomResetToOsTime()
  --end,missionCode)--DEBUG
end

--TUNE
local roamEventProfiles={
  HUNTED={
    phaseUpdate=1,
    minPhase="PHASE_ALERT",
    maxPhase="PHASE_ALERT",
    keepPhase=1,
    phaseUpdateRate=30,
    phaseUpdateRange=30,
    abortMenuItemControl=1,--TODO not what we want, probably don't want to force it upon user anyway
  },
  CRASHLAND={
    clearItems={0,1},
    clearSupportItems={0,1},
    primaryWeaponOsp={0,1},
    secondaryWeaponOsp={0,1},
    tertiaryWeaponOsp={0,1},
    startOnFootFREE="ALL",
  },
  LOST_COMS={
    disableMenuDrop=1,
    disableMenuBuddy=1,
    disableMenuAttack=1,
    disableMenuHeliAttack=1,
    disableSupportMenu=1,
    disableSpySearch=1,
    disableLzs="REGULAR",
  },
}

local roamEventNames={
  "HUNTED",
  "CRASHLAND",
  "LOST_COMS",
}

local disableLzsFromStartDistance=1900--tex TUNE
disableLzsFromStartDistance=disableLzsFromStartDistance*disableLzsFromStartDistance
--tex called from InfMain.OnMissionCanStartBottom
function this.DisableLzs()
  local missionCode=vars.missionCode
  if this.inf_enabledEvents.HUNTED then
    local startPos={gvars.ply_missionStartPos[0],gvars.ply_missionStartPos[1],gvars.ply_missionStartPos[2]}
    local locationName=InfUtil.GetLocationName()
    InfLZ.DisableLzsWithinDist(TppLandingZone.assaultLzs[locationName],startPos,disableLzsFromStartDistance,missionCode)
    InfLZ.DisableLzsWithinDist(TppLandingZone.missionLzs[locationName],startPos,disableLzsFromStartDistance,missionCode)
  end
end

function this.GenerateRoamEvent(missionCode)
  --InfCore.PCall(function(missionCode)--DEBUG
  igvars.inf_event=true

  this.inf_enabledEvents={}
  local numEvents=0

  local forcedEvent=false
  if this.forceEvent then
    if type(this.forceEvent)=="string" then
      if roamEventNames[this.forceEvent] then
        forcedEvent=this.forceEvent
      end
    end
  end
  if forcedEvent then
    this.inf_enabledEvents[forcedEvent]=true
    numEvents=numEvents+1
  else
    for i=1,#roamEventNames do
      if math.random(100)<100/#roamEventNames then--TUNE
        local eventName=roamEventNames[i]
        this.inf_enabledEvents[eventName]=true
        numEvents=numEvents+1
      end
    end
  end
  if numEvents==0 then
    local eventName=roamEventNames[math.random(#roamEventNames)]
    this.inf_enabledEvents[eventName]=true
  end

  --DEBUG
  --  this.inf_enabledEvents={}
  --  this.inf_enabledEvents={
  --    --HUNTED=true,
  --    CRASHLAND=true,
  --  --LOST_COMS=true,
  --  }

  for eventId,enabled in pairs(this.inf_enabledEvents)do
    InfMenu.PrintFormatLangId("event_announce",eventId)-- TODO ADDLANG to event ids
    IvarProc.ApplyProfile(roamEventProfiles[eventId],true)
  end

  local missionCodeLocation={
    [30010]="afgh",
    [30020]="mafr",
  }

  if this.inf_enabledEvents.CRASHLAND then
    --      local rndHours=math.random(0,23)
    --      local rndMinutes=math.random(0,60)
    --      local rndSeconds=math.random(0,60)
    --      gvars.missionStartClock=rndHours*60*60*rndMinutes*60*rndSeconds
    --      vars.clock=gvars.missionStartClock

    --tex random start location
    local locationName=missionCodeLocation[missionCode]
    local lzTable=TppLandingZone.missionLzs[locationName]
    local lzDrpNames={}
    for drpName,aprName in pairs(lzTable)do
      lzDrpNames[#lzDrpNames+1]=drpName
    end
    mvars.heli_missionStartRoute=lzDrpNames[math.random(#lzDrpNames)]
    --InfCore.DebugPrint("mvars.heli_missionStartRoute:"..mvars.heli_missionStartRoute)--DEBUG
  end
  --end,missionCode)
end

local warGamesBase={
  TRAINING={
    mbDDEquipNonLethal=1,
    mbHostileSoldiers=1,
    mbEnableLethalActions=0,
    mbNonStaff=0,
    mbEnableFultonAddStaff=0,
    mbZombies=0,
    mbEnemyHeli=0,
  },
  INVASION={
    mbDDEquipNonLethal=0,
    mbHostileSoldiers=1,
    mbEnableLethalActions=1,
    mbNonStaff=1,
    mbEnableFultonAddStaff=1,
    mbZombies=0,
    heliPatrolsMB="HP48",
    mbEnemyHeli=1,
  },
  ZOMBIE_DD={
    mbDDEquipNonLethal=0,
    mbHostileSoldiers=1,
    mbEnableLethalActions=0,
    mbNonStaff=0,
    mbEnableFultonAddStaff=0,
    mbZombies=1,
    mbEnemyHeli=0,
  },
  ZOMBIE_OBLITERATION={
    mbDDEquipNonLethal=0,
    mbHostileSoldiers=1,
    mbEnableLethalActions=1,
    mbNonStaff=1,
    mbEnableFultonAddStaff=0,
    mbZombies=1,
    mbEnemyHeli=0,
  },
}

local warGames={
  "TRAINING",
  "SOVIET_INVASION",
  "COYOTE_INVASION",
  "XOF_INVASION",
  "FEMME_FATALE",
  "ZOMBIE_DD",
  "ZOMBIE_OBLITERATION",
}
local warGamesEnum=Tpp.Enum(warGames)

local warGamesBaseTypes={
  TRAINING="TRAINING",
  SOVIET_INVASION="INVASION",
  COYOTE_INVASION="INVASION",
  XOF_INVASION="INVASION",
  FEMME_FATALE="INVASION",
  ZOMBIE_DD="ZOMBIE_DD",
  ZOMBIE_OBLITERATION="ZOMBIE_OBLITERATION",
}

local warGameSettings={
  TRAINING={
    enableWalkerGearsMB=0,
    mbNpcRouteChange={0,1},
  },
  SOVIET_INVASION={
    mbDDHeadGear=0,
    customSoldierTypeMB_ALL="SOVIET_B",
    customWeaponTableMB_ALL=0,
    mbWargameFemales=0,
    enableWalkerGearsMB=1,
    mbWalkerGearsColor="SOVIET",
    mbEnemyHeliColor="DEFAULT",
    revengeModeMB_ALL="DEFAULT",--tex TODO generate custom
    mbNpcRouteChange=0,
  },
  COYOTE_INVASION={
    mbDDHeadGear=0,
    customSoldierTypeMB_ALL="PF_C",
    customSoldierTypeFemaleMB_ALL="BATTLE_DRESS_FEMALE",
    customWeaponTableMB_ALL=1,
    weaponTableStrength="STRONG",
    weaponTableAfgh=1,
    weaponTableMafr=1,
    weaponTableSkull=1,
    weaponTableDD=0,
    mbWargameFemales=15,
    enableWalkerGearsMB=1,
    mbWalkerGearsColor="ROGUE_COYOTE",
    mbEnemyHeliColor="RANDOM_EACH",
    revengeModeMB_ALL="DEFAULT",--tex TODO generate custom
    mbNpcRouteChange={0,1},
  },
  XOF_INVASION={
    mbDDHeadGear=1,
    customSoldierTypeMB_ALL="XOF",
    customWeaponTableMB_ALL=1,
    weaponTableAfgh=0,
    weaponTableMafr=0,
    weaponTableSkull=1,
    weaponTableDD=1,
    soldierEquipGrade_MIN=15,
    soldierEquipGrade_MAX=15,
    allowUndevelopedDDEquip=1,
    mbDDEquipNonLethal=0,
    mbWargameFemales=0,
    enableWalkerGearsMB=1,
    mbWalkerGearsColor="DDOGS",--tex or soviet?
    mbEnemyHeliColor="RED",
    revengeModeMB_ALL="DEFAULT",--tex TODO generate custom
    mbNpcRouteChange=1,
  },
  FEMME_FATALE={
    mbDDHeadGear=0,
    customSoldierTypeMB_ALL="DRAB",--tex even though this is female only theres still a bunch of code predicated on customSoldierType
    customSoldierTypeFemaleMB_ALL="SWIMWEAR_FEMALE",
    customWeaponTableMB_ALL=1,
    weaponTableAfgh=0,
    weaponTableMafr=0,
    weaponTableSkull=0,
    weaponTableDD=1,
    soldierEquipGrade_MIN=3,
    soldierEquipGrade_MAX=15,
    allowUndevelopedDDEquip=1,
    mbDDEquipNonLethal=0,
    mbWargameFemales=100,
    enableWalkerGearsMB=1,
    mbWalkerGearsColor="DDOGS",--tex or soviet?
    mbEnemyHeliColor="BLACK",
    revengeModeMB_ALL="DEFAULT",--tex TODO generate custom
    mbNpcRouteChange=1,
  },
  ZOMBIE_DD={
    enableWalkerGearsMB=0,
  },
  ZOMBIE_OBLITERATION={
    enableWalkerGearsMB=0,
  },
}

function this.GenerateWarGameEvent()
  --InfCore.PCallDebug(function()--DEBUG
  --tex user is doing wargames anyway
  if Ivars.mbWarGamesProfile:Is()>0 and not igvars.inf_event then
    return
  end

  --tex TODO: only catches some times
  --InfCore.Log("GenerateWarGameEvent mbFreeDemoPlayNextIndex:"..tostring(gvars.mbFreeDemoPlayNextIndex))--DEBUG
  if gvars.mbFreeDemoPlayNextIndex and gvars.mbFreeDemoPlayNextIndex~=0 then
    return
  end

  igvars.inf_event=true

  this.inf_enabledEvents={}

  local warGame=warGames[math.random(#warGames)]
  if this.forceEvent then
    if type(this.forceEvent)=="string" then
      if warGamesEnum[this.forceEvent] then
        warGame=this.forceEvent
      end
    end
  end
  --local warGame="TRAINING"--DEBUG
  this.inf_enabledEvents[warGame]=true
  local wargameBaseType=warGamesBaseTypes[warGame]

  local warGameNames=InfMenu.GetLangTable"events_mb"
  --tex ugh, TODO better
  local warGameIndex=warGamesEnum[warGame]
  local warGameName=warGameNames[warGameIndex]
  InfMenu.PrintFormatLangId("event_announce",warGameName)--tex TODO ADDLANG to event ids

  if wargameBaseType=="INVASION" then
    ivars.mbWarGamesProfile=Ivars.mbWarGamesProfile.enum.INVASION--KLUDGE just setting without saving or triggering other profile sub ivars
    Ivars.mbEnablePuppy:Set(0,true)--tex TODO should be handled by infpuppy
  end

  IvarProc.ApplyProfile(warGamesBase[wargameBaseType],true)
  IvarProc.ApplyProfile(warGameSettings[warGame],true)

  --custom config TODO: make generated config a seperate feature?
  --all the rest, for now just use enemy prep levels
  --Ivars.revengeModeMB_ALL:Set("CUSTOM",true)
  --tex for now just useing enemy prep levels (set via warGames table)
  --end)--
end

function this.ForceEvent()
  InfMenu.PrintLangId"event_forced"
  this.forceEvent=true
end

function this.GetEventNames()
  local eventNames={}
  for i,eventName in ipairs(roamEventNames)do
    eventNames[#eventNames+1]=eventName
  end
  for i,eventName in ipairs(warGames)do
    eventNames[#eventNames+1]=eventName
  end
  return eventNames
end

return this
