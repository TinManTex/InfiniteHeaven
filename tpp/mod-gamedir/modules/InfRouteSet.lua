--InfRouteSet.lua
--Implements routeSet randomization
--see afgh_routeSets, TppEnemy.RouteSelector for info on routesets

--The basic gist is that a routeset for a CP is number of groups of routes (for a given route type, sneak_day/night, caution etc).
--The actual list for the route type is created by working through the groups in a group priority order untill all routes are listed.

--Now assuming the soldiers for the cp are assigned routes from this list in it's order (otherwise why go to the effort)
--and since most cps have less soldiers assigned than routes then there's routes that will never get chosen in the vanilla game.

--even if that isn't the case the shift-change hold-sleep system (even though that does provide some variation due to those hold-sleep routes) doesnt seem to grab all soldiers so some routes will stay in play over multiple shifts
--(this is from eyeballing the diffs of a dump of solCpRoute for all soldiers in one cp)

--simply randomising the group priority will allow a few different routes be selected
--randomizing within groups will give a lot more variation
--and combining both the most

--TODO: a further - who cares how dumb it looks - randomisation mode could be just randomize all routes across all route types

--TODO: a periodic by min/max clock time var (set a clock message on mission start, randomize and recalculate next period when message hits)
--see routeset_randomizePeriodically -v-



--GOTCHA: randomisation is currently done on the active routeSets (mvars.ene_routeSetsDefine),
--so there's no current resetting to default, or even seed based randomisation
--(since the underlying routeSets are randomised depending on the amount of times it's been randomised, if that makes sense)
--so mission reloads will give a different randomisation


local this={}

this.registerMenus={
  "routeSetMenu",
}

this.routeSetMenu={
  parentRefs={"InfMenuDefs.safeSpaceMenu","InfMenuDefs.inMissionMenu"},
  options={
    "Ivars.routeset_randomizeRouteSetsMISSION",
    "Ivars.routeset_randomizeRouteSetsFREE",
    "Ivars.routeset_randomizeOnShiftChange",
    "Ivars.routeset_randomizeOnPhaseChange",
    "Ivars.routeset_randomizePriority",
    "Ivars.routeset_randomizeGroups",
    "InfRouteSet.RandomizeCurrentRouteSet",
  },
}--routeSetMenu

this.registerIvars={
  "routeset_randomizeOnShiftChange",
  "routeset_randomizeOnPhaseChange",
  "routeset_randomizePriority",
  "routeset_randomizeGroups",
}

IvarProc.MissionModeIvars(
  this,
  "routeset_randomizeRouteSets",
  {
    save=IvarProc.CATEGORY_EXTERNAL,
    range=Ivars.switchRange,
    settingNames="set_switch",
  },
  {"MISSION","FREE"}
)--routeset_randomizeRouteSets

this.routeset_randomizeOnShiftChange={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.routeset_randomizeOnPhaseChange={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

--tex in minutes
--DEBUGNOW
--IvarProc.MinMaxIvar(
--  this,
--  "routeset_randomizePeriodically",
--  {
--    default=60,
--    OnChange=function(self,setting,prevSetting)
--      IvarProc.PushMax(self,setting,prevSetting)
--      --...
--    end,
--  },
--  {
--    default=120,
--    OnChange=function(self,setting,prevSetting)
--      IvarProc.PushMin(self,setting,prevSetting)
--      --...
--    end,
--  },
--  {
--    inMission=true,
--    range={min=1,max=1440,increment=10},
--  }
--)--MinMaxIvar routeset_randomizePeriodically

this.routeset_randomizePriority={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.routeset_randomizeGroups={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.langStrings={
  eng={
    routeSetMenu="RouteSet menu",
    routeset_randomizeRouteSetsFREE="Randomize RouteSets in free roam",
    routeset_randomizeRouteSetsMISSION="Randomize RouteSets in missions",
    routeset_randomizeOnShiftChange="Randomize on shift change",
    routeset_randomizeOnPhaseChange="Randomize on phase change",
    routeset_randomizePriority="Randomize group priority",
    routeset_randomizeGroups="Randomize group routes",
    randomizeCurrentRouteSet="Randomize RouteSet now",
  },
  help={
    eng={
      routeSetMenu="Options to randomize what routes soldiers use in a Command Post.",
      routeset_randomizeRouteSetsFREE="Enables all following options. Also randomizes current routeSet on mission load/reload.",
      routeset_randomizeRouteSetsMISSION="Enables all following options. Also randomizes current routeSet on mission load/reload. WARNING: may mess up scripted mission routes.",
      routeset_randomizeOnShiftChange="Randomize current routeSet on morning and night shift changes",
      routeset_randomizeOnPhaseChange="Randomize current routeSet when enemy phase changes in any way, Sneak, Caution, Alert, Evasion. Up or down.",
      routeset_randomizePriority="Each routeSet for a CP has a number of groups of routes, this will change the order the groups are picked from.",
      routeset_randomizeGroups="Each routeSet for a CP has a number of groups of routes, this will change the order within the group.",
      randomizeCurrentRouteSet="Randomize current routeset right now.",
    },
  }--help
}--langStrings

function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
--tex called after RegisterRouteSet in TppMain.OnReload
function this.OnReload(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  if IvarProc.EnabledForMission"routeset_randomizeRouteSets" then
    this.RandomizeCurrentRouteSet()
  end
end--OnReload
--tex called a little ways after RegisterRouteSet is called in TppMain.OnInitialize
function this.SetupEnemy(missionTable)
  if IvarProc.EnabledForMission"routeset_randomizeRouteSets" then
    this.RandomizeCurrentRouteSet()
  end
end--SetupEnemy

function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="ChangePhase",func=this.OnPhaseChange},
    },
    Weather={
      {msg="Clock",sender="ShiftChangeAtNight",func=this.ShiftChangeAtNight},
      {msg="Clock",sender="ShiftChangeAtMorning",func=this.ShiftChangeAtMorning},
      {msg="Clock",sender="ShiftChangeAtMidNight",func=this.ShiftChangeAtMidNight},
    },--Weather
  }--StrCode32Table message table
end--Messages

function this.OnPhaseChange(cpGameObjectId,phase,oldPhase)
  if not IvarProc.EnabledForMission"routeset_randomizeRouteSets" then
    return
  end
  if not ivars.routeset_randomizeOnPhaseChange then
    return
  end
  --tex this is called for every OnPhaseChange, so will be brutal for something like InfEnemyPhase or events that trigger a bunch of phasechange
  --DEBUGNOW TODO
  local cpName=InfLookup.CpNameForCpId(cpGameObjectId)
  InfCore.Log("InfRouteSet.OnPhaseChange "..tostring(cpName))--DEBUGNOW
  local cpRouteSet={}
  if mvars.ene_routeSetsDefine[cpName] then
    cpRouteSet[cpName]=InfUtil.CopyTable(mvars.ene_routeSetsDefine[cpName])
    InfCore.PrintInspect(cpRouteSet,"cpRouteSet")--DEBUGNOW
    this.RandomizeRouteSet(cpRouteSet)
  end
end--OnPhaseChange

function this.ShiftChangeAtMorning(sender,time)
  if not IvarProc.EnabledForMission"routeset_randomizeRouteSets" then
    return
  end
  if Ivars.routeset_randomizeOnShiftChange:Get()==0 then
    return
  end
  InfCore.Log("InfRouteSet.ShiftChangeAtMorning")
  this.RandomizeCurrentRouteSet()
end--ShiftChangeAtMorning

function this.ShiftChangeAtNight(sender,time)
  if not IvarProc.EnabledForMission"routeset_randomizeRouteSets" then
    return
  end
  if Ivars.routeset_randomizeOnShiftChange:Get()==0 then
    return
  end
  InfCore.Log("InfRouteSet.ShiftChangeAtNight")
  this.RandomizeCurrentRouteSet()
end--ShiftChangeAtNight

--tex actually at 22:00:00 (TppClock.NIGHT_TO_MIDNIGHT) rather than actual midnight
--tex GOTCHA: while there's no midgnight routes ("sneak_midnight etc") they take the night routeType and create a shift anyway?
--see TppEnemy._MakeShiftChangeUnit, search 'midnight'
function this.ShiftChangeAtMidNight(sender,time)
  if not IvarProc.EnabledForMission"routeset_randomizeRouteSets" then
    return
  end
  if Ivars.routeset_randomizeOnShiftChange:Get()==0 then
    return
  end
  InfCore.Log("InfRouteSet.ShiftChangeAtMidNight")
  --this.RandomizeCurrentRouteSet()--tex DEBUGNOW don't know if I want to given that night shift is at ~18:00
end--ShiftChangeAtMidNight

function this.RandomizeCurrentRouteSet()
  --DEBUGNOW warn user if not in mission that this is for in mission
  InfCore.Log("RandomizeCurrentRouteSet",false,true)
  local routeSets=InfUtil.CopyTable(mvars.ene_routeSetsDefine)--tex ChangeRouteSets>MergeRouteSets isn't a pure merge, so you'd break things feeding ene_routeSetsDefine back into it directly
  this.RandomizeRouteSet(routeSets)
end

--tex DEBUGNOW Clean up
function this.RandomizeRouteSet(routeSets)
  if TppMission.IsHelicopterSpace(vars.missionCode) then
    InfMenu.PrintLangId"command_for_in_mission"
    return
  end

  InfCore.LogFlow("RandomizeRouteSet")
  --DEBUGNOW TODO setrandomtolevelseed, or is there a mission elapsed time var that can be used since this is being called in-mission too?

  --tex randomizing priority but keeping same sets just makes soldiers reassign
  --I assume its a case of there being more routes than soldiers thus the distrubution of soldier over them changes
  --tex could have an random-all-but-first, but the first tends to be sniper/vip tables which are added seperate anyway
  if Ivars.routeset_randomizePriority:Get()==1 then
    for cpOrLrrp,routeSet in pairs(routeSets)do
      routeSet.priority=InfUtil.RandomizeArray(routeSet.priority)

      routeSet.fixedShiftChangeGroup=InfUtil.RandomizeArray(routeSet.fixedShiftChangeGroup)
    end
  end--if routeset_randomizePriority

  if Ivars.routeset_randomizeGroups:Get()==1 then
    --tex ok, so it's not technically a group
    --    for cpOrLrrp,routeSet in pairs(routeSets)do
    --      routeSet.outofrain=this.RandomizeArray(routeSet.outofrain)
    --    end
    --
    --    --tex randomize each group
    --    --kind of the same as randomizing only priority,
    --    --but more change in distribution as routes that normally wouldnt get assigned get assigned
    --    --and randomizing just this instead of priority still gives a prioritized route set, just one thats different than vanilla
    for cpOrLrrp,routeSet in pairs(routeSets)do
      --tex DEBUGNOW see if I want to handle 'travel' differently
      for i,routeSetType in pairs(TppEnemy.ROUTE_SET_TYPES)do
        --InfCore.Log(tostring(i)..":"..tostring(routeSetType))--DEBUGNOW
        local routeSetForType=routeSet[routeSetType]
        if not routeSetForType then
        --InfCore.Log("routeSet "..cpOrLrrp.." has no routeSetType "..routeSetType)--DEBUG
        else
          for groupName,routes in pairs(routeSetForType)do
            --InfCore.PrintInspect(routeSetForType[groupName],groupName.." before")--DEBUG
            routeSetForType[groupName]=InfUtil.RandomizeArray(routes)
            --InfCore.PrintInspect(routeSetForType[groupName],groupName.." after")--DEBUG
          end--for routeSetForType
        end--if routeSetForType
      end--for ROUTE_SET_TYPES
    end--for routeSets
  end--if routeset_randomizeGroups

  --tex could further ransomize routes across types,
  --that is if you're fine with soliders manning lights at night
  --or some rushing around like theyre in caution when its sneak

  TppEnemy.ChangeRouteSets(routeSets)
  TppEnemy.MakeShiftChangeTable()--tex DEBUGNOW usually only called on initial routesets setup not for ChangeRouteSets, but lets give it a go
end--RandomizeRouteSet

return this
