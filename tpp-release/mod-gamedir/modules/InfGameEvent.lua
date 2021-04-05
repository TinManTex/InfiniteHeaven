-- InfGameEvent.lua
-- system relies on preventing saved ivar values from restoring (search inf_event) and using it's own profile settings with level seed to ensure randomisation is the same
local this={}

local InfCore=InfCore
local InfMain=InfMain
local SendCommand=GameObject.SendCommand
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId

this.forceEvent=false
this.inf_enabledEvents={}
this.doInjury=false

this.registerIvars={
  "mbWarGamesProfile",
  "mbWargameFemales",
  "mbHostileSoldiers",
  "mbNonStaff",
  "mbZombies",
  "mbEnemyHeli",
  "mbEnableFultonAddStaff",
  "selectEvent",
  "enableEventHUNTED",
  "enableEventCRASHLAND",
  "enableEventLOST_COMS",
}
--tex profile that sets many of the wargames event settings, but just the underlying categories
--see gameEventChance, GenerateEvent, igvars.inf_event for the randomly triggered event that sets the actually themed/flavorful ones
this.mbWarGamesProfile={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={"OFF","TRAINING","INVASION","ZOMBIE_DD","ZOMBIE_OBLITERATION"},
  settingsTable={
    OFF={
      mbDDEquipNonLethal=0,
      mbHostileSoldiers=0,
      mbNonStaff=0,
      mbEnableFultonAddStaff=0,
      mbZombies=0,
      mbEnemyHeli=0,
    },
    TRAINING={
      --mbDDEquipNonLethal=0,--tex allow user setting
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
      attackHeliPatrolsMB=4,
      mbEnemyHeli=1,
    },
    ZOMBIE_DD={
      mbDDEquipNonLethal=0,--tex n/a
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
  },
  OnChange=IvarProc.OnChangeProfile,
}

this.mbWargameFemales={
  save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=100,increment=10},
  isPercent=true,
}

--NONUSER/ handled by profile>
this.mbHostileSoldiers={
  nonUser=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.mbNonStaff={--tex also disables negative ogre on kill
  nonUser=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.mbZombies={
  nonUser=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

--tex attackHelis on mb hostile or not --InfNPCHeli
this.mbEnemyHeli={
  nonUser=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckMb,
}

this.mbEnableFultonAddStaff={
  nonUser=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}
--<NONUSER

IvarProc.MissionModeIvars(
  this,
  "gameEventChance",
  {
    save=IvarProc.CATEGORY_EXTERNAL,
    range={min=0,max=100,increment=5},
    isPercent=true,
  },
  {"FREE","MB",}
)

this.selectEvent={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={"NONE"},--DYNAMIC
  OnSelect=function(self)
    local settings=InfGameEvent.GetEventNames()
    IvarProc.SetSettings(self,settings)
  end,
  OnActivate=function(self,setting)
    InfMenu.PrintLangId"event_forced"
    InfGameEvent.forceEvent=self.settings[setting+1]
  end,
}

--
this.enableEventHUNTED={
  save=IvarProc.CATEGORY_EXTERNAL,
  default=1,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.enableEventCRASHLAND={
  save=IvarProc.CATEGORY_EXTERNAL,
  default=1,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.enableEventLOST_COMS={
  save=IvarProc.CATEGORY_EXTERNAL,
  default=1,
  range=Ivars.switchRange,
  settingNames="set_switch",
}
--< ivar defs
this.registerMenus={
  "eventsMenu",
}

this.eventsMenu={
  parentRefs={"InfMenuDefs.safeSpaceMenu"},
  options={
    "InfGameEvent.ForceGameEvent",
    "Ivars.gameEventChanceFREE",
    "Ivars.gameEventChanceMB",
    "Ivars.enableEventHUNTED",
    "Ivars.enableEventCRASHLAND",
    "Ivars.enableEventLOST_COMS",
    "Ivars.enableParasiteEvent",
    "Ivars.armorParasiteEnabled",
    "Ivars.mistParasiteEnabled",
    "Ivars.camoParasiteEnabled",
    "Ivars.parasitePeriod_MIN",
    "Ivars.parasitePeriod_MAX",
    "Ivars.parasiteWeather",
  }
}
--< menu defs
this.langStrings={
  eng={
    eventsMenu="Events menu",
    enableEventHUNTED="Allow Hunted event",
    enableEventCRASHLAND="Allow Crashland event",
    enableEventLOST_COMS="Allow Lost Coms event",
    event_announce="Event: %s",--event name
    event_forced="Event will start on next MB visit or Free Roam",
    forceGameEvent="Trigger random IH event",
    gameEventChanceMB="MB event random trigger chance",
    gameEventChanceFREE="Free roam event random trigger chance",
    events_mb={
      "DD Training wargame",
      "Soviet attack",
      "Rogue Coyote attack",
      "XOF attack",
      "Femme Fatales attack",
      "DD Infection outbreak",
      "Zombie Obliteration (non DD)",
    },
    mbWargameFemales="Women in Enemy Invasion mode",
    mbWarGamesProfile="Mother Base War Games",
    mbWarGamesProfileSettings={"Off","DD Training","Enemy Invasion","DD Infection","Zombie Obliteration (non DD)"},   
  },
  help={
    eng={
      gameEventChanceMB="Chance to randomly trigger an IH event on returning to MB. (See 'Trigger random IH event')",
      gameEventChanceFREE="Chance to randomly trigger an IH event on starting Free roam. (See 'Trigger random IH event')",
       forceGameEvent=[[Events are temporary combinations of IH settings for free roam and mother base.
Free roam events (can stack): 
Crashland: Starts you on foot in at a random start point and randomly selects OSP options - cleared primary, secondary, back weapons, items, support items. 
Lost-coms: Disables most mother base support menus and disables all heli landing zones except from main bases/towns. 
Hunted: Sets the enemy to combat alert every 15-45 seconds (this also sets the player spotted position right on you), and also disables heli landing zones in a 2k radius from your start position, so you'll have to travel if you want to 'get out'. 
MB events (only one active): 
DD Training wargame, 
Soviet attack, 
Rogue Coyote attack, 
XOF attack, 
DD Infection outbreak, 
Zombie Obliteration (non DD)]],
      mbWarGamesProfile="Profiles that sets many of the wargames event settings, but just the underlying categories, see 'MB event random trigger chance' actually themed/flavorful versions",
    },
  }
}
--<

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
--CALLERS: InfMain.ExecuteMissionFinalizeTop, title_sequence OnEndFadeOutSelectContinue (to re-apply event following session since they are implmented as non saved profiles)
function this.GenerateEvent(missionCode)
  --InfCore.PCallDebug(function(misisonCode)--DEBUGOW
  if not this.forceEvent and not IvarProc.EnabledForMission("gameEventChance",missionCode) and not igvars.inf_event then
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
    local locationName=TppLocation.GetLocationName()
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
    local enabledTypes={}
    for i,eventType in ipairs(roamEventNames)do
      enabledTypes[eventType]=Ivars["enableEvent"..eventType]:Is(1)
    end

    for i,eventName in ipairs(roamEventNames) do
      if enabledTypes[eventName] then
        if math.random(100)<100/#roamEventNames then--TUNE
          this.inf_enabledEvents[eventName]=true
          numEvents=numEvents+1
        end
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
    attackHeliPatrolsMB=4,
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
    attackHeliTypeMB="SBH",
    attackHeliFovaMB="DEFAULT",
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
    attackHeliTypeMB="UTH",
    attackHeliFovaMB="RANDOM_EACH",
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
    attackHeliTypeMB="UTH",
    attackHeliTypeMB="uth_v02",--DEBUGNOW which one is XOF
    revengeModeMB_ALL="DEFAULT",--tex TODO generate custom
    mbNpcRouteChange=1,
  },
  FEMME_FATALE={
    mbDDHeadGear=0,
    customSoldierTypeMB_ALL="DRAB",--tex even though this is female only theres still a bunch of code predicated on customSoldierType
    customSoldierTypeFemaleMB_ALL={"SWIMWEAR_FEMALE","SWIMWEAR2_FEMALE","SWIMWEAR3_FEMALE"},
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
    attackHeliTypeMB="SBH",--DEBUGNOW UTH?, except attackHeliFova doesnt get inited to UTH till onselect, but could still do RANDOM,RANDOM_EACH
    attackHeliFovaMB="BLACK",
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
  --tex user is doing wargames anyway (see mbWarGamesProfile vs gameEventChance)
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
  InfCore.Log("InfGameEvent.GenerateWarGameEvent: "..tostring(warGame))
  --local warGame="TRAINING"--DEBUG
  this.inf_enabledEvents[warGame]=true
  local wargameBaseType=warGamesBaseTypes[warGame]

  local warGameNames=InfLangProc.LangTable"events_mb"
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

function this.ForceGameEvent()
  InfMenu.PrintLangId"event_forced"
  this.forceEvent=true
end

--TUNE
function this.SetZombie(gameObjectId)
  local command= {
    id="SetZombie",
    enabled=true,
    isMsf=math.random()>0.7,
    isZombieSkin=false,--math.random()>0.5,
    isHagure=math.random()>0.7,--tex donn't even know
    isHalf=math.random()>0.7,--tex donn't even know
  }
  if not command.isMsf then
    command.isZombieSkin=true
  end
  SendCommand(gameObjectId,command )
  if command.isMsf then
    local command={id="SetMsfCombatLevel",level=math.random(9)}
    SendCommand(gameObjectId,command)
  end

  if math.random()>0.8 then
    SendCommand(gameObjectId,{id="SetEnableHotThroat",enabled=true})
  end
end

function this.SetUpMBZombie()
  for cpName,soldierNameList in pairs(mvars.ene_soldierDefine) do
    for i,soldierName in pairs(soldierNameList) do
      local gameObjectId=GetGameObjectId("TppSoldier2",soldierName)
      if gameObjectId~=NULL_ID then
        this.SetZombie(gameObjectId)
      end
    end
  end
end

return this
