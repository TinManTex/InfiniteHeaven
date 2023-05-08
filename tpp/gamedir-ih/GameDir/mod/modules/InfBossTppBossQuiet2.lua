--InfBossTppBossQuiet2.lua

--
----SetCombatGrade
--local PARASITE_GRADE_CAMO={
--  defenseValue=4000,
--  offenseGrade=2,
--  defenseGrade=7,
--}

--TODO: scrape all refs to game object again
--REF interesting functions/commands not doing anythig with yet
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

this.disableFight=false--DEBUG
--tex since I'm repurposing routes buit for normal cps the camo parasites just seem to shift along a short route, or get stuck leaving and returning to same spot.
--semi workable solution is to just set new routes after the parasite has been damaged a few times.
local camoShiftRouteAttackCount=3

--tex indexed by parasiteNames
this.hitCounts={}

this.gameObjectType="TppBossQuiet2"
this.gameObjectTypeIndex=TppGameObject.GAME_OBJECT_TYPE_BOSSQUIET2

--SetBossSubType
this.currentSubType="CAMO"
this.currentBossNames=nil
this.currentParams=nil

this.gameIdToNameIndex={}--InitEvent

this.subTypes={
  CAMO=true,
}

this.packages={
  CAMO={
    "/Assets/tpp/pack/mission2/ih/ih_parasite_camo.fpk",
    --OFF script block WIP "/Assets/tpp/pack/mission2/ih/parasite_scriptblock.fpk",
  }
}--packages

--tex locatorNames from packs
this.bossObjectNames={
  CAMO={
    "wmu_camo_ih_0000",
    "wmu_camo_ih_0001",
    "wmu_camo_ih_0002",
    "wmu_camo_ih_0003",
  },
}--bossObjectNames

this.eventParams={
  CAMO={
  --tex since camos start moving to route when activated, and closest cp may not be that discoverable
  --or their positions even that good, spawn at player pos in a close enough radius that they spot player
  --they'll then be aiming at player when they reach the cp
  --TODO: alternatively try triggering StartCombat on camo spawn
    spawnRadius=10,--ivar
    escapeDistance=100,--ivar
    escapeDistanceSqr=100^2,
    timeOut=1*60,--ivar
    zombifies=true,--TODO: set false and test the boss objects zombifying ability
  },
}--eventParams

this.routeBag=nil--Appear

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
    },--GameObject
    Player={
      {msg="PlayerDamaged",func=this.OnPlayerDamaged},
    },--Player
  }
end--Messages

--Ivars>
local parasiteStr="parasite_"

local parasiteGradeNames={
  "defenseValue",
  "offenseGrade",
  "defenseGrade",
}--parasiteGradeNames
--<

function this.PostModuleReload(prevModule)
  this.routeBag=prevModule.routeBag
end

function this.Init(missionTable)
  this.messageExecTable=nil

  if not InfBossEvent.BossEventEnabled() then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.OnReload(missionTable)
  this.messageExecTable=nil

  if not InfBossEvent.BossEventEnabled() then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

--InfBossEvent.AddMissionPacks
function this.AddPacks(missionCode,packPaths)
  for j,packagePath in ipairs(this.packages[this.currentSubType])do
    packPaths[#packPaths+1]=packagePath
  end
end--AddPacks

--InfBossEvent
function this.SetBossSubType(bossSubType)
  if not this.subTypes[bossSubType] then
    InfCore.Log("ERROR: InfBossTppBossQuiet2.SetBossSubType: has no subType "..tostring(bossSubType))
    return
  end
  InfCore.Log("SetBossSubType "..bossSubType)
  this.currentSubType=bossSubType
  this.currentBossNames=this.bossObjectNames[bossSubType]
  --TODO shift BuildGameIdToNameIndex here if you move ChosseBossTypes/SetBossSubType from pre load
  this.currentParams=this.eventParams[bossSubType]
end--SetBossSubType

--InfBossEvent
--OUT: this.gameIdToNameIndex
function this.InitEvent()
  local bossNames=this.bossObjectNames[this.currentSubType]
  InfUtil.ClearTable(this.gameIdToNameIndex)
  InfBossEvent.BuildGameIdToNameIndex(bossNames,this.gameIdToNameIndex)

  this.DisableAll()
  this.SetupParasites()

  for nameIndex,name in ipairs(bossNames)do
    this.hitCounts[nameIndex]=0
  end--for gameObjectNames
end--InitEvent

function this.DisableAll()
  local bossNames=this.bossObjectNames[this.currentSubType]
  for i,name in ipairs(bossNames) do
    this.DisableByName(name)
  end  
end--DisableAll

function this.DisableByName(name)
  local gameId=GetGameObjectId("TppBossQuiet2",name)

  if gameId==NULL_ID then
    return
  end

  SendCommand(gameId,{id="SetSightCheck",flag=false})
  SendCommand(gameId,{id="SetNoiseNotice",flag=false})
  SendCommand(gameId,{id="SetInvincible",flag=true})
  SendCommand(gameId,{id="SetStealth",flag=true})
  SendCommand(gameId,{id="SetHumming",flag=false})
  SendCommand(gameId,{id="SetForceUnrealze",flag=true})
end--DisableByName

function this.EnableByName(name)
  local gameObjectId=GetGameObjectId("TppBossQuiet2",name)
  SendCommand(gameObjectId,{id="SetForceUnrealze",flag=false})
  SendCommand(gameObjectId,{id="SetSightCheck",flag=true})
  SendCommand(gameObjectId,{id="SetNoiseNotice",flag=true})
  SendCommand(gameObjectId,{id="SetInvincible",flag=false})
  SendCommand(gameObjectId,{id="SetStealth",flag=false})
  SendCommand(gameObjectId,{id="SetHumming",flag=true})
end--EnableByName

function this.DisableFight(name)
  local gameObjectId=GetGameObjectId("TppBossQuiet2",name)
  SendCommand(gameObjectId,{id="SetSightCheck",flag=false})
  SendCommand(gameObjectId,{id="SetNoiseNotice",flag=false})
end

--InfBossEvent
function this.SetupParasites()
  InfCore.LogFlow("InfBossTppBossQuiet2.Setup")

  SendCommand({type="TppBossQuiet2"},{id="SetFultonEnabled",enabled=true})

  local combatGradeCommand={id="SetCombatGrade",}
  for i,paramName in ipairs(parasiteGradeNames)do
    local ivarName=parasiteStr..paramName.."CAMO"
    combatGradeCommand[paramName]=Ivars[ivarName]:Get()
  end
  SendCommand({type="TppBossQuiet2"},combatGradeCommand)
  if this.debugModule then
    InfCore.PrintInspect(combatGradeCommand,"SetCombatGrade")
  end
end--Setup

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

--DEBUGNOW get working for MB
--IN: mvars.ene_routeSetsDefine
function this.GetRoutes(cpName)
  local routeSets=mvars.ene_routeSetsDefine[cpName]
  if not routeSets then
    InfCore.Log"WARNING: InfBossEvent  CamoParasiteAppear - no routesets found, aborting"
    return
  end

  local cpRoutes={}
  --tex TODO prioritze picking sniper group first?
  if routeSets==nil then
    InfCore.Log("WARNING: InfBossEvent CamoParasiteAppear no routesets for "..cpName,true)--DEBUG
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
          end--for group
        end--if group
      end--for groups
    end--if phaseRoutes
  end--for phases
  return routeCount,cpRoutes
end--GetRoutes

--InfBossEvent
--IN: this.currentSubType
--IN: this.bossObjectNames
--IN: this.this.disableFight
--OUT: this.routeBag
function this.Appear(appearPos,closestCp,closestCpPos,spawnRadius)
  --InfCore.Log"CamoParasiteAppear"--DEBUG
  --tex camo parasites rely on having route set, otherwise they'll do a constant grenade drop evade on the same spot
  local routeCount,cpRoutes=this.GetRoutes(closestCp)

  --  InfCore.PrintInspect("CamoParasiteAppear cpRoutes")--DEBUG
  --  InfCore.PrintInspect(cpRoutes)

  if routeCount<#this.bossObjectNames[this.currentSubType]then--this.numParasites then--DEBUGNOW
    InfCore.Log("WARNING: InfBossEvent CamoParasiteAppear - routeCount< #camo parasites",true)
    return
  end

  this.routeBag=InfUtil.ShuffleBag:New()
  for route,bool in pairs(cpRoutes) do
    this.routeBag:Add(route)
  end

  for index,name in ipairs(this.bossObjectNames[this.currentSubType]) do
    if svars.bossEvent_bossStates[index]==InfBossEvent.stateTypes.READY then
      local gameId=GetGameObjectId("TppBossQuiet2",name)
      if gameId==NULL_ID then
        InfCore.Log("WARNING: InfBossTppBossQuiet2.Appear - "..name.. " not found",true)
      else
        local parasiteRotY=0

        InfCore.Log(name.." appear",this.debugModule)

        --ASSUMPTION 4 parasites
        --half circle with 2 leads
        --local angle=360/i

        --4 quadrants
        local angle=90*(index-1)
        local spawnPos=InfBossEvent.PointOnCircle(appearPos,spawnRadius,angle)

        this.SetRoutes(this.routeBag,gameId)

        SendCommand(gameId,{id="ResetPosition"})
        SendCommand(gameId,{id="ResetAI"})

        --tex can put camo parasites to an initial position
        --but they will move to their set route on activation
        SendCommand(gameId,{id="WarpRequest",pos=spawnPos,rotY=parasiteRotY})

        this.EnableByName(name)

        if this.disableFight then
          this.DisableFight(name)
        end

        SendCommand(gameId,{id="SetCloseCombatMode",enabled=true})--tex NOTE unsure if this command is actually individual
      end--if gameId
      --SendCommand({type="TppBossQuiet2"},{id="StartCombat"})
    end--if stateTypes.READY
  end--for bossObjectNames

  return appearPos
end--Appear

function this.SetRoutes(routeBag,gameId)
  InfCore.Log("InfBossTppBossQuiet2.SetRoutes",this.debugModule)--DEBUG
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
end--SetRoutes

--Messages>
function this.OnDamage(gameId,attackId,attackerId)
  local BossModule=this

  local typeIndex=GetTypeIndex(gameId)
  if typeIndex~=BossModule.gameObjectTypeIndex then
    return
  end

  local nameIndex=BossModule.gameIdToNameIndex[gameId]
  if nameIndex==nil then
    return
  end

  local attackerIndex=GetTypeIndex(attackerId)
  --tex player damaged by boss
  if typeIndex==GAME_OBJECT_TYPE_PLAYER2 and attackerIndex==BossModule.gameObjectTypeIndex then
    InfBossEvent.SetFocusOnPlayerPos(BossModule.currentParams.timeOut)
    return
  end

  --tex boss damaged by player
  if typeIndex==BossModule.gameObjectTypeIndex and attackerIndex==GAME_OBJECT_TYPE_PLAYER2 then
    InfBossEvent.SetFocusOnPlayerPos(BossModule.currentParams.timeOut)
    return
  end

  BossModule.OnTakeDamage(nameIndex,gameId)
end--OnDamage

--IN: this.states
--IN/OUT: this.hitCounts
--IN: camoShiftRouteAttackCount
function this.OnTakeDamage(nameIndex,gameId)
  --tex see note on camoShiftRouteAttackCount
  if svars.bossEvent_bossStates[nameIndex]==InfBossEvent.stateTypes.READY then
    this.hitCounts[nameIndex]=this.hitCounts[nameIndex]+1
    if this.hitCounts[nameIndex]>=camoShiftRouteAttackCount then--tex module local
      this.hitCounts[nameIndex]=0
      this.SetRoutes(this.routeBag,gameId)
    end
  end
end--OnTakeDamage

function this.OnDying(gameId)
  local BossModule=this

  local typeIndex=GetTypeIndex(gameId)
  if typeIndex~=BossModule.gameObjectTypeIndex then
    return
  end

  local nameIndex=BossModule.gameIdToNameIndex[gameId]
  if nameIndex==nil then
    return
  end

  --KLUDGE DEBUGNOW don't know why OnDying keeps triggering repeatedly
  if svars.bossEvent_bossStates[nameIndex]==InfBossEvent.stateTypes.DOWNED then
    InfCore.Log"WARNING: InfBossEvent.OnDying state already ==DOWNED"
    return
  end

  svars.bossEvent_bossStates[nameIndex]=InfBossEvent.stateTypes.DOWNED

  if this.debugModule then
    InfCore.Log("OnDying is para",true)
  end
  --InfCore.PrintInspect(this.states,{varName="states"})--DEBUGNOW InspectVars

  if InfBossEvent.IsAllCleared() then
    InfCore.Log("InfBossEvent OnDying: all eliminated")--DEBUG
    InfBossEvent.EndEvent()
  end
end--OnDying

function this.OnFulton(gameId,gimmickInstance,gimmickDataSet,stafforResourceId)
  local BossModule=this

  local typeIndex=GetTypeIndex(gameId)
  if typeIndex~=BossModule.gameObjectTypeIndex then
    return
  end

  local nameIndex=BossModule.gameIdToNameIndex[gameId]
  if nameIndex==nil then
    return
  end

  svars.bossEvent_bossStates[nameIndex]=InfBossEvent.stateTypes.FULTONED

  --InfCore.PrintInspect(this.states,{varName="states"})--DEBUGNOW

  if InfBossEvent.IsAllCleared() then
    InfCore.Log("InfBossEvent OnFulton: all eliminated")--DEBUG
    InfBossEvent.EndEvent()
  end
end--OnFulton

function this.OnPlayerDamaged(playerIndex,attackId,attackerId)
  local BossModule=this
  local gameId=attackerId

  local typeIndex=GetTypeIndex(gameId)
  if typeIndex~=BossModule.gameObjectTypeIndex then
    return
  end

  local nameIndex=BossModule.gameIdToNameIndex[gameId]
  if nameIndex==nil then
    return
  end

  InfBossEvent.SetFocusOnPlayerPos(BossModule.currentParams.timeOut)
end--OnPlayerDamaged
--<

return this