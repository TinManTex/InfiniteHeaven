-- DOBUILD: 1
--InfMain.lua
local this={}

this.modVersion="r145"
this.modName="Infinite Heaven"

--LOCALOPT:
local Ivars=Ivars
local InfButton=InfButton
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local Enum=TppDefine.Enum
local StrCode32=Fox.StrCode32


--this.debugSplash=SplashScreen.Create("debugEagle","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",640,640)

function this.IsTableEmpty(checkTable)--tex TODO: shove in a utility module
  local next=next
  if next(checkTable)==nil then
    return true
  end
  return false
end

function this.SetLevelRandomSeed()
  math.randomseed(gvars.rev_revengeRandomValue)
  math.random()
  math.random()
  math.random()
end

function this.ResetTrueRandom()
  math.randomseed(os.time())
  math.random()
  math.random()
  math.random()
end

function this.ForceArmor(missionCode)
  if Ivars.allowHeavyArmorInAllMissions:Is(1) and not TppMission.IsFreeMission(missionCode) then
    return true
  end
  if Ivars.allowHeavyArmorInFreeRoam:Is()>0 and TppMission.IsFreeMission(missionCode) then--DEBUG allowHeavyArmorInFreeRoam actiting as armor limit for debug
    return true
  end
  if Ivars.allowLrrpArmorInFree:Is(1) and TppMission.IsFreeMission(missionCode) then
    return true
  end

  return false
end

this.SETTING_FORCE_ENEMY_TYPE=Enum{
  "DEFAULT",
  "TYPE_DD",
  "TYPE_SOVIET",
  "TYPE_PF",
  "TYPE_SKULL",
  "TYPE_CHILD",
  "MAX",
}

this.enemySubTypes={
  "Default",
  "DD_A",
  "DD_PW",
  "DD_FOB",
  "SKULL_CYPR",
  "SKULL_AFGH",
  "SOVIET_A",
  "SOVIET_B",
  "PF_A",
  "PF_B",
  "PF_C",
  "CHILD_A",
}

this.soldierSubTypesForTypeName={
  TYPE_DD={
    "DD_A",
    "DD_PW",
    "DD_FOB",
  },
  TYPE_SKULL={
    "SKULL_CYPR",
    "SKULL_AFGH",
  },
  TYPE_SOVIET={
    "SOVIET_A",
    "SOVIET_B",
  },
  TYPE_PF={
    "PF_A",
    "PF_B",
    "PF_C",
  },
  TYPE_CHILD={
    "CHILD_A",
  },
}
this.soldierTypeForSubtypes={
  DD_A=EnemyType.TYPE_DD,
  DD_PW=EnemyType.TYPE_DD,
  DD_FOB=EnemyType.TYPE_DD,
  SKULL_CYPR=EnemyType.TYPE_SKULL,
  SKULL_AFGH=EnemyType.TYPE_SKULL,
  SOVIET_A=EnemyType.TYPE_SOVIET,
  SOVIET_B=EnemyType.TYPE_SOVIET,
  PF_A=EnemyType.TYPE_PF,
  PF_B=EnemyType.TYPE_PF,
  PF_C=EnemyType.TYPE_PF,
  CHILD_A=EnemyType.TYPE_CHILD,
}
--tex maybe I'm missing something but not having luck indexing by EnemyType
function this.SoldierTypeNameForType(soldierType)
  if soldierType == nil then
    return nil
  end

  if soldierType==EnemyType.TYPE_DD then
    return "TYPE_DD"
  elseif soldierType==EnemyType.TYPE_SKULL then
    return "TYPE_SKULL"
  elseif soldierType==EnemyType.TYPE_SOVIET then
    return "TYPE_SOVIET"
  elseif soldierType==EnemyType.TYPE_PF then
    return "TYPE_PF"
  elseif soldierType==EnemyType.TYPE_CHILD then
    return "TYPE_CHILD"
  end
  return nil
end

function this.IsSubTypeCorrectForType(soldierType,subType)--returns true on nil soldiertype because fsk that
  local soldierTypeName=this.SoldierTypeNameForType(soldierType)
  if soldierTypeName ~= nil then
    local subTypes=this.soldierSubTypesForTypeName[soldierTypeName]
    if subTypes ~= nil then
      for n, _subType in pairs()do
        if subType == _subType then
          return true
        end
      end
      return false
    end
  end
  return true
end

function this.IsForceSoldierSubType()
  return Ivars.forceSoldierSubType:Is()>0 and TppMission.IsFreeMission(vars.missionCode)
end

-- mb dd equip
function this.IsDDEquip(missionId)
  local missionCode=missionId or vars.missionCode
  if missionCode~=50050 and missionCode >5 then--tex IsFreeMission hangs on startup?
    local mbDDEquip = Ivars.enableMbDDEquip:Is(1) and missionCode==30050
    local enemyDDEquipFreeRoam = Ivars.enableEnemyDDEquip:Is(1) and TppMission.IsFreeMission(missionCode) and missionCode~=30050
    local enemyDDEquipMissions = Ivars.enableEnemyDDEquipMissions:Is(1) and TppMission.IsStoryMission(missionCode)
    return mbDDEquip or enemyDDEquipFreeRoam or enemyDDEquipMissions
  end
  return false
end

function this.IsDDBodyEquip(missionId)
  local missionCode=missionId or vars.missionCode
  if missionCode==30050 then
    return Ivars.mbDDSuit:Is()>0
  end
  return false
end

function this.MinMaxIvarRandom(ivarName)
  local ivarMin=Ivars[ivarName.."_MIN"]
  local ivarMax=Ivars[ivarName.."_MAX"]
  return math.random(ivarMin:Get(),ivarMax:Get())
end

function this.GetMbsClusterSecuritySoldierEquipGrade(missionId)--SYNC: mbSoldierEquipGrade
  local missionCode=missionId or vars.missionCode
  local grade = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
  if this.IsDDEquip(missionCode) then
    InfMain.SetLevelRandomSeed()
    grade=this.MinMaxIvarRandom"mbSoldierEquipGrade"
    InfMain.ResetTrueRandom()
  end
  --TppUiCommand.AnnounceLogView("GetEquipGrade: gvar:".. Ivars.mbSoldierEquipGrade:Get() .." grade: ".. grade)--DEBUG
  --TppUiCommand.AnnounceLogView("Caller: ".. tostring(debug.getinfo(2).name) .." ".. tostring(debug.getinfo(2).source))--DEBUG
  return grade
end

function this.GetMbsClusterSecuritySoldierEquipRange(missionId)
  local missionCode=missionId or vars.missionCode
  if this.IsDDEquip(missionCode) then
    if Ivars.mbSoldierEquipRange:Is"RANDOM" then
      return math.random(0,2)--REF:{ "FOB_ShortRange", "FOB_MiddleRange", "FOB_LongRange", }, but range index from 0
    else
      return Ivars.mbSoldierEquipRange:Get()
    end
  end
  return TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipRange()
end

function this.GetMbsClusterSecurityIsNoKillMode(missionId)
  local missionCode=missionId or vars.missionCode
  if this.IsDDEquip(missionCode) then
    return Ivars.mbDDEquipNonLethal:Is(1)
  end
  return TppMotherBaseManagement.GetMbsClusterSecurityIsNoKillMode()
end

function this.DisplayFox32(foxString)
  local str32 = Fox.StrCode32(foxString)
  TppUiCommand.AnnounceLogView("string :"..foxString .. "="..str32)
end

function this.ResetCpTableToDefault()
  local subTypeOfCp=TppEnemy.subTypeOfCp
  local subTypeOfCpDefault=TppEnemy.subTypeOfCpDefault
  for cp, subType in pairs(subTypeOfCp)do
    subTypeOfCp[cp]=subTypeOfCpDefault[cp]
  end
end

local afghSubTypes={
  "SOVIET_A",
  "SOVIET_B",
}
local isAfghSubType={--tex ugly
  SOVIET_A=true,
  SOVIET_B=true,
}
local mafrSubTypes={
  "PF_A",
  "PF_B",
  "PF_C",
}
local isMafrSubType={
  PF_A=true,
  PF_B=true,
  PF_C=true,
}
function this.RandomizeCpSubTypeTable()
  if Ivars.changeCpSubTypeFree:Is(0) and Ivars.changeCpSubTypeForMissions:Is(0) then
    return
  end

  if vars.missionCode==TppDefine.SYS_MISSION_ID.AFGH_FREE or vars.missionCode==TppDefine.SYS_MISSION_ID.MAFR_FREE then
    if Ivars.changeCpSubTypeFree:Is(0) then
      return
    end
  else
    if Ivars.changeCpSubTypeForMissions:Is(0) then
      return
    end
  end

  this.SetLevelRandomSeed()--tex set to a math.random on OnMissionClearOrAbort so a good base for a seed to make this constand on mission loads. Soldiers dont care since their subtype is saved but other functions read subTypeOfCp
  local subTypeOfCp=TppEnemy.subTypeOfCp
  for cp, subType in pairs(subTypeOfCp)do
    local subType=subTypeOfCp[cp]
    if isAfghSubType[subType] then
      --local rnd=TppRevenge._Random(1,#afghSubTypes)
      local rnd=math.random(1,#afghSubTypes)
      subTypeOfCp[cp]=afghSubTypes[rnd]
    elseif isMafrSubType[subType] then
      --local rnd=TppRevenge._Random(1,#mafrSubTypes)
      local rnd=math.random(1,#mafrSubTypes)
      --InfMenu.DebugPrint("rnd:"..rnd)--DEBUG
      subTypeOfCp[cp]=mafrSubTypes[rnd]
    end
  end
  this.ResetTrueRandom()--tex back to 'truly random' /s for good measure
end

function this.ChangePhase(cpName,phase)
  local gameId=GetGameObjectId("TppCommandPost2",cpName)
  if gameId==NULL_ID then
    InfMenu.DebugPrint("Could not find cp "..cpName)
    return
  end
  local command={id="SetPhase",phase=phase}
  SendCommand(gameId,command)
end

function this.SetKeepAlert(cpName,enable)
  local gameId=GetGameObjectId("TppCommandPost2",cpName)
  if gameId==NULL_ID then
    InfMenu.DebugPrint("Could not find cp "..cpName)
    return
  end
  local command={id="SetKeepAlert",enable=enable}
  GameObject.SendCommand(gameId,command)
end

--
function this.SetUpMBZombie()
  --  for idx = 1, table.getn(this.soldierDefine[mtbs_enemy.cpNameDefine]) do
  --    local gameObjectId = GameObject.GetGameObjectId("TppSoldier2", this.soldierDefine[mtbs_enemy.cpNameDefine][idx])
  --    if gameObjectId ~= NULL_ID then
  --      InfMenu.DebugPrint("idx:".. idx .. "soldiername: ".. tostring(this.soldierDefine[mtbs_enemy.cpNameDefine][idx]) )--DEBUG
  --      GameObject.SendCommand( gameObjectId, { id = "SetZombie", enabled = true, isMsf = false, isZombieSkin = true, isHagure = false } )
  --    end
  --  end
  for cpName, soldierNameList in pairs( mtbs_enemy.soldierDefine ) do
    for _, soldierName in pairs( soldierNameList ) do
      local gameObjectId = GetGameObjectId("TppSoldier2", soldierName)
      if gameObjectId ~= NULL_ID then
        local command =  {
          id = "SetZombie",
          enabled = true,
          isMsf = math.random()>0.7,
          isZombieSkin = false,--math.random()>0.5,
          isHagure = math.random()>0.7,--tex donn't even know
          isHalf=math.random()>0.7,--tex donn't even know
        }
        if not command.isMsf then
          command.isZombieSkin=true
        end
        GameObject.SendCommand( gameObjectId, command )
        if command.isMsf then
          local command = { id = "SetMsfCombatLevel", level = math.random(9) }
          GameObject.SendCommand( gameObjectId, command )
        end

        if math.random()>0.8 then
          GameObject.SendCommand( gameObjectId, { id = "SetEnableHotThroat", enabled = true } )
        end
      end
    end
  end

end

this.SetFriendlyCp = function()
  local gameObjectId = { type="TppCommandPost2", index=0 }
  local command = { id="SetFriendlyCp" }
  GameObject.SendCommand( gameObjectId, command )
end

this.SetFriendlyEnemy = function()
  local gameObjectId = { type="TppSoldier2" }
  local command = { id="SetFriendly", enabled=true }
  GameObject.SendCommand( gameObjectId, command )
end

--tex TODO:
function this.GetClosestCp()
  local closestCpId=nil
  local closestDist=9999999999999
  for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
    local cpId=GetGameObjectId(cpName)
    if cpId and cpId~=NULL_ID then
      --local cpPos=?
      local playerPos=TppPlayer.GetPosition()
      local distSqr=TppMath.FindDistance(cpPos,playerPos)
    end
  end
end

--<cp stuff



--block quests>
local blockQuests={
  "tent_q99040" -- 144 - recover volgin, player is left stuck in geometry at end of quanranteed plat demo
}

function this.BlockQuest(questName)
  --tex TODO: doesn't work for the quest area you start in (need to clear before in actual mission)
  if vars.missionCode==30050 and Ivars.mbWarGamesProfile:Is()>0 then
    --InfMenu.DebugPrint("actually BlockQuest "..tostring(questName).." "..tostring(vars.missionCode))--DEBUG CULL
    return true
  end

  for n,name in ipairs(blockQuests)do
    if name==questName then
      if TppQuest.IsCleard(questName) then
        return true
      end
    end
  end
  --tex block heli quests to allow super reinforce
  if Ivars.enableHeliReinforce:Is(1) then
    --if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
    for n,name in ipairs(TppDefine.QUEST_HELI_DEFINE)do
      if name==questName then
        return true
      end
    end
    --end
  end

  return false
end


function this.OnAllocate(missionTable)
  if TppMission.IsFOBMission(vars.missionCode)then
    TppSoldier2.ReloadSoldier2ParameterTables(InfSoldierParams.soldierParameters)
  end

  --WIP
  if missionTable.enemy then
  --OFF lua off InfEquip.LoadEquipTable()
  end
end

function this.PreMissionLoad(missionCode,currentMissionCode)
end

function this.MissionPrepare()
  if TppMission.IsStoryMission(vars.missionCode) then
    if Ivars.gameOverOnDiscovery:Is(1) then
      TppMission.RegistDiscoveryGameOver()
    end
  end
end

local disableActionMenus=PlayerDisableAction.OPEN_CALL_MENU+PlayerDisableAction.OPEN_EQUIP_MENU
local menuDisableActions=PlayerDisableAction.OPEN_EQUIP_MENU

function this.RestoreActionFlag()
  local activeControlMode=this.GetActiveControlMode()
  -- WIP
  --  if activeControlMode then
  --    if bit.band(vars.playerDisableActionFlag,menuDisableActions)==menuDisableActions then
  --    else
  --      this.EnableAction(menuDisableActions)
  --    end
  --  else
  this.EnableAction(menuDisableActions)
  --  end
end

function this.DisableAction(actionFlag)
  if not this.ActionIsDisabled(actionFlag) then
    vars.playerDisableActionFlag=vars.playerDisableActionFlag+actionFlag
  end
end
function this.EnableAction(actionFlag)
  if this.ActionIsDisabled(actionFlag) then
    vars.playerDisableActionFlag=vars.playerDisableActionFlag-actionFlag
  end
end

function this.ActionIsDisabled(actionFlag)
  if bit.band(vars.playerDisableActionFlag,actionFlag)==actionFlag then
    return true
  end
  return false
end

--
this.allButCamPadMask={
  settingName="allButCam",
  except=true,
  --buttons=PlayerPad.STANCE,
  sticks=PlayerPad.STICK_R,
}
--CULL REF
--local commonControlPadMask={
--  settingName="controlMode",
--  except=false,
--  buttons=PlayerPad.ALL,
--  sticks=PlayerPad.STICK_L,--+PlayerPad.STICK_R,
--  triggers=PlayerPad.TRIGGER_L+PlayerPad.TRIGGER_R,
--}

--
local function UpdateRangeToMinMax(updateRate,updateRange)
  local min=updateRate-updateRange*0.5
  local max=updateRate+updateRange*0.5
  if min<0 then
    min=0
  end
  return min,max
end

function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="Dead",func=this.OnDead},
      {msg="Damage",func=this.OnDamage},
      {msg="ChangePhase",func=this.OnPhaseChange},
      --WIP OFF, lua off
      --      {msg="RequestLoadReinforce",func=InfReinforce.OnRequestLoadReinforce},
      --      {msg="RequestAppearReinforce",func=InfReinforce.OnRequestAppearReinforce},
      --      {msg="CancelReinforce",func=InfReinforce.OnCancelReinforce},
      --      {msg="LostControl",func=InfReinforce.OnHeliLostControlReinforce},--DOC: Helicopter shiz.txt
      --      {msg="VehicleBroken",func=InfReinforce.OnVehicleBrokenReinforce},
      {msg="Returned", --[[sender = "EnemyHeli",--]]
        func = function(gameObjectId)
        --InfMenu.DebugPrint("GameObject msg: Returned")--DEBUG
        end
      },
      {msg="RequestedHeliTaxi",func=function(gameObjectId,currentLandingZoneName,nextLandingZoneName)
        --InfMenu.DebugPrint("RequestedHeliTaxi currentLZ:"..currentLandingZoneName.. " nextLZ:"..nextLandingZoneName)--DEBUG
        end},
      {msg="StartedPullingOut",func=function()
        --InfMenu.DebugPrint("StartedPullingOut")--DEBUG
        if TppMission.IsMbFreeMissions(vars.missionCode) then
        --this.heliSelectClusterId=nil
        end
      end},
      {msg="RequestLoadReinforce",func=function()
        --InfMenu.DebugPrint"RequestLoadReinforce"--DEBUG
        end},
      --      {
      --        msg = "RoutePoint2",--DEBUG
      --        func = function( gameObjectId, routeId, routeNodeIndex, messageId )
      --          InfInspect.TryFunc(function()
      --            InfMenu.DebugPrint("gameObjectId:"..tostring(gameObjectId).." routeId:".. tostring(routeId).." routeNodeIndex:".. tostring(routeNodeIndex).." messageId:".. tostring(messageId))--DEBUG
      --          end)
      --        end
      --      },
      {msg="SaluteRaiseMorale",func=this.CheckSalutes},
    },
    MotherBaseStage = {
      --      {
      --        msg = "MotherBaseCurrentClusterLoadStart",
      --        func = function(clusterId)
      --
      --        end,
      --      },
      {msg= "MotherBaseCurrentClusterActivated",func=this.CheckClusterMorale},
    },
    Player={
      {msg="FinishOpeningDemoOnHeli",func=this.ClearMarkers},--tex xray effect off doesn't stick if done on an endfadein, and cant seen any ofther diable between the points suggesting there's an in-engine set between those points of execution(unless I'm missing something) VERIFY
    },
    UI={
      --      {msg="EndFadeIn",func=this.FadeIn()},--tex for all fadeins
      {msg="EndFadeIn",sender="FadeInOnGameStart",func=function()--fires on: most mission starts, on-foot free and story missions, not mb on-foot, but does mb heli start
        --InfMenu.DebugPrint"FadeInOnGameStart"--DEBUG
        this.FadeInOnGameStart()
      end},
      --this.FadeInOnGameStart},
      {msg="EndFadeIn",sender="FadeInOnStartMissionGame",func=function()--fires on: returning to heli from mission
        --  TppUiStatusManager.ClearStatus"AnnounceLog"
        --InfMenu.ModWelcome()
        --InfMenu.DebugPrint"FadeInOnStartMissionGame"--DEBUG
        --this.FadeInOnGameStart()
        end},
      {msg="EndFadeIn",sender="OnEndGameStartFadeIn",func=function()--fires on: on-foot mother base, both initial and continue
        --InfMenu.DebugPrint"OnEndGameStartFadeIn"--DEBUG
        this.FadeInOnGameStart()
      end},
      --tex Heli mission-prep ui
      {msg="MissionPrep_EndSlotSelect",func=function()
        --InfMenu.DebugPrint"MissionPrep_EndSlotSelect"--DEBUG
        InfFova.CheckModelChange()
      end},
    --      {msg="MissionPrep_ExitWeaponChangeMenu",func=function()
    --        InfMenu.DebugPrint"MissionPrep_ExitWeaponChangeMenu"--DEBUG
    --      end},
    --      {msg="MissionPrep_EndItemSelect",func=function()
    --        InfMenu.DebugPrint"MissionPrep_EndItemSelect"--DEBUG
    --      end},
    --      {msg="MissionPrep_EndEdit",func=function()
    --        InfMenu.DebugPrint"MissionPrep_EndEdit"--DEBUG
    --      end},


    --elseif(messageId=="Dead"or messageId=="VehicleBroken")or messageId=="LostControl"then
    },
    Timer={
    --WIP OFF lua off {msg="Finish",sender="Timer_FinishReinforce",func=InfReinforce.OnTimer_FinishReinforce,nil},
    },
    Terminal={
      {msg="MbDvcActSelectLandPoint",func=function(nextMissionId,routeName,layoutCode,clusterId)
        --InfMenu.DebugPrint("MbDvcActSelectLandPoint:"..tostring(InfLZ.str32LzToLz[routeName]).. " "..tostring(clusterId))--DEBUG
        this.heliSelectClusterId=clusterId
      end},
      {msg="MbDvcActSelectLandPointTaxi",func=function(nextMissionId,routeName,layoutCode,clusterId)
        --InfMenu.DebugPrint("MbDvcActSelectLandPointTaxi:"..tostring(routeName).. " "..tostring(clusterId))--DEBUG
        this.heliSelectClusterId=clusterId
      end},
      {msg="MbDvcActHeliLandStartPos",func=function(set,x,y,z)
        --InfMenu.DebugPrint("HeliLandStartPos:"..x..","..y..","..z)--DEBUG
        end},
      {msg="MbDvcActCallRescueHeli",func=function(param1,param2)
        --InfMenu.DebugPrint("MbDvcActCallRescueHeli: "..tostring(param1).." ".. tostring(param2))--DEBUG
        end},
    },
  }
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this.OnDead(gameId,killerId,playerPhase,deadMessageFlag)
  --InfMenu.DebugPrint("InfMain.OnDead")--DEBUG

  if true then return end
  --  local heliId=GetGameObjectId(TppReinforceBlock.REINFORCE_HELI_NAME)--CULL not for heli I guess
  --  if heliId~=NULL_ID then
  --    if heliId==gameId then
  --    --InfMenu.DebugPrint("InfMain.OnDead is heli")
  --    end
  --  end

  if GetTypeIndex(gameId)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end

  --local killerIsPlayer=(killerId==GameObject.GetGameObjectIdByIndex("TppPlayer2",PlayerInfo.GetLocalPlayerIndex()))
end


--TODO: VERIFY, add vehicle machineguns
local AttackIsVehicle=function(attackId)--RETAILBUG: seems like attackid must be a typo and f
  if(((((((((((((
    attackId==TppDamage.ATK_VehicleHit
    or attackId==TppDamage.ATK_Tankgun_20mmAutoCannon)
    or attackId==TppDamage.ATK_Tankgun_30mmAutoCannon)
    or attackId==TppDamage.ATK_Tankgun_105mmRifledBoreGun)
    or attackId==TppDamage.ATK_Tankgun_120mmSmoothBoreGun)
    or attackId==TppDamage.ATK_Tankgun_125mmSmoothBoreGun)
    or attackId==TppDamage.ATK_Tankgun_82mmRocketPoweredProjectile)
    or attackId==TppDamage.ATK_Tankgun_30mmAutoCannon)
    or attackId==TppDamage.ATK_Wav1)
    or attackId==TppDamage.ATK_WavCannon)
    or attackId==TppDamage.ATK_TankCannon)
    or attackId==TppDamage.ATK_WavRocket)
    or attackId==TppDamage.ATK_HeliMiniGun)
    or attackId==TppDamage.ATK_HeliChainGun)
--or attackId==TppDamage.ATK_WalkerGear_BodyAttack
then
  return true
end
return false
end
function this.OnDamage(gameId,attackId,attackerId)
  --InfMenu.DebugPrint"OnDamage"--DEBUG
  local typeIndex=GameObject.GetTypeIndex(gameId)
  if typeIndex~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then--and typeIndex~=TppGameObject.GAME_OBJECT_TYPE_HELI2 then
    return
  end

  if Tpp.IsPlayer(attackerId) then
    --InfMenu.DebugPrint"OnDamage attacked by player"
    if Ivars.soldierAlertOnHeavyVehicleDamage:Is()>0 then
      if AttackIsVehicle(attackId) then
        --InfMenu.DebugPrint"OnDamage AttackIsVehicle"
        for cpId,soldierIds in pairs(mvars.ene_soldierIDList)do--tex TODO:find or build a better soldierid>cpid lookup
          if TppEnemy.GetPhaseByCPID(cpId)<Ivars.soldierAlertOnHeavyVehicleDamage:Is() then
            if soldierIds[gameId]~=nil then
              --InfMenu.DebugPrint"OnDamage found soldier in idlist"
              local command={id="SetPhase",phase=Ivars.soldierAlertOnHeavyVehicleDamage:Get()}
              SendCommand(cpId,command)
              break
            end
        end--if cp not phase
        end--for soldieridlist
      end--attackisvehicle
    end--gvar
  end--player is attacker
end

local function PhaseName(index)
  return Ivars.phaseSettings[index+1]
end
function this.OnPhaseChange(gameObjectId,phase,oldPhase)
  if Ivars.printPhaseChanges:Is(1) then
    --tex TODO: cpId>cpName
    InfMenu.Print("cpId:"..gameObjectId.." Phase change from:"..PhaseName(oldPhase).." to:"..PhaseName(phase))--InfMenu.LangString("phase_changed"..":"..PhaseName(phase)))--ADDLANG
  end
end

--CALLER: TppUiFadeIn
--tex calling from function rather than msg since it triggers on start, possibly splash or loading screen, which fova naturally doesnt like because it doesn't exist then
function this.OnFadeInDirect()
  InfFova.OnFadeIn()
end

--msg called fadeins
function this.FadeInOnGameStart()
  this.ClearMarkers()

  --tex player life values for difficulty. Difficult to track down the best place for this, player.changelifemax hangs anywhere but pretty much in game and ready to move, Anything before the ui ending fade in in fact, why.
  --which i don't like, my shitty code should be run in the shadows, not while player is getting viewable frames lol, this is at least just before that
  --RETRY: push back up again, you may just have fucked something up lol, the actual one use case is in sequence.OnEndMissionPrepareSequence which is the middle of tppmain.onallocate
  local healthScale=Ivars.playerHealthScale:Get()/100
  if healthScale~=1 then
    Player.ResetLifeMaxValue()
    local newMax=vars.playerLifeMax
    newMax=newMax*healthScale
    if newMax < 10 then
      newMax = 10
    end
    Player.ChangeLifeMaxValue(newMax)
  end

  --  if Ivars.disableQuietHumming:Is(1) then --tex no go
  --    this.SetQuietHumming(false)
  --  end

  --TppUiStatusManager.ClearStatus"AnnounceLog"
  --InfMenu.ModWelcome()
end

function this.ClearMarkers()
  if Ivars.disableHeadMarkers:Is(1) then
    TppUiStatusManager.SetStatus("HeadMarker","INVALID")
  end
  if Ivars.disableWorldMarkers:Is(1) then
    TppUiStatusManager.SetStatus("WorldMarker","INVALID")
  end
  if Ivars.disableXrayMarkers:Is(1) then
    --TppSoldier2.DisableMarkerModelEffect()
    TppSoldier2.SetDisableMarkerModelEffect{enabled=true}
  end
end

--ivar update system

local updateIvars={
  Ivars.phaseUpdate,
  Ivars.warpPlayerUpdate,
  Ivars.adjustCameraUpdate,
  Ivars.heliUpdate,
  Ivars.npcUpdate,
  Ivars.npcHeliUpdate,
}

--tex called at very start of TppMain.OnInitialize, use mostly for hijacking missionTable scripts
function this.OnInitializeTop(missionTable)
  if missionTable.enemy then
    local enemyTable=missionTable.enemy
    this.soldierPool=this.ResetObjectPool("TppSoldier2",this.reserveSoldierNames)

    --InfMain.SetLevelRandomSeed()
    if IsTable(enemyTable.soldierDefine) then
      if IsTable(enemyTable.VEHICLE_SPAWN_LIST)then
        InfVehicle.ModifyVehiclePatrol(enemyTable.VEHICLE_SPAWN_LIST)
      end

      enemyTable.soldierTypes=enemyTable.soldierTypes or {}
      enemyTable.soldierSubTypes=enemyTable.soldierSubTypes or {}
      enemyTable.soldierPowerSettings=enemyTable.soldierPowerSettings or {}
      enemyTable.soldierPersonalAbilitySettings=enemyTable.soldierPersonalAbilitySettings or {}

      this.ModifyVehiclePatrolSoldiers(enemyTable.soldierDefine)
      this.AddLrrps(enemyTable.soldierDefine,enemyTable.travelPlans)
      this.AddWildCards(enemyTable.soldierDefine,enemyTable.soldierTypes,enemyTable.soldierSubTypes,enemyTable.soldierPowerSettings,enemyTable.soldierPersonalAbilitySettings)
    end
    --InfMain.ResetTrueRandom()
  end
end
function this.OnAllocateTop(missionTable)

end
--via TppMain
function this.OnMissionCanStartBottom()
  local currentChecks=this.UpdateExecChecks(this.execChecks)
  for i, ivar in ipairs(updateIvars) do
    if IsFunc(ivar.OnMissionCanStart) then
      ivar.OnMissionCanStart(currentChecks)
    end
  end

  --tex WORKAROUND invasion mode extract from mb weirdness, just disable for now
  if (Ivars.mbWarGamesProfile:Is"INVASION" and vars.missionCode==30050)then
    Player.SetItemLevel(TppEquip.EQP_IT_Fulton_WormHole,0)
  end
end

function this.Init(missionTable)--tex called from TppMain.OnInitialize
  this.abortToAcc=false

  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  local currentChecks=this.UpdateExecChecks(this.execChecks)
  for i, ivar in ipairs(updateIvars) do
    if IsFunc(ivar.ExecInit) then

      this.ExecInit(currentChecks,ivar.execChecks,ivar.ExecInit)
    end
  end

  if vars.missionCode==30050 and Ivars.mbEnableFultonAddStaff:Is(1) then
    mvars.trm_isAlwaysDirectAddStaff=false
  end

  if vars.missionCode==30050 and Ivars.mbCollectionRepop:Is(1) then
    mvars.trm_isSkipAddResourceToTempBuffer=false
  end

  this.UpdateHeliVars()

  this.ClearMoraleInfo()
end

function this.OnReload(missionTable)
  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end


function this.OnMissionGameEndTop()
  if vars.missionCode==30050 then
    this.CheckMoraleReward()
  end
end


--missionFinalize={
--  currentMissionCode,
--  currentLocationCode,
--  isHeliSpace,
--  nextIsHeliSpace,
--  isFreeMission,
--  nextIsFreeMission,
--  isMotherBase,
--  isZoo,
--}
function this.ExecuteMissionFinalize(missionFinalize)
  --tex repop count decrement for plants
  if Ivars.mbCollectionRepop:Is(1) then
    if missionFinalize.isZoo then
      TppGimmick.DecrementCollectionRepopCount()
    elseif missionFinalize.isMotherBase then
      --tex dont want it too OP
      Ivars.mbRepopDiamondCountdown:Set(Ivars.mbRepopDiamondCountdown:Get()-1)
      if Ivars.mbRepopDiamondCountdown:Is(0) then
        Ivars.mbRepopDiamondCountdown:Reset()
        TppGimmick.DecrementCollectionRepopCount()
      end
    end
  end
end

this.execChecks={
  inGame=false,--tex actually loaded game, ie at least 'continued' from title screen
  inHeliSpace=false,
  inMission=false,
  initialAction=false,--tex mission actually started/reached ground, triggers on checkpoint save so might not be valid for some uses
  inGroundVehicle=false,
  inSupportHeli=false,
  onBuddy=false,--tex sexy
  inMenu=false,
}

this.currentTime=0

this.abortToAcc=false--tex

--tex NOTE: doesn't actually return a new table/reuses input
function this.UpdateExecChecks(currentChecks)
  --for k,v in ipairs(this.execChecks) do
  --this.execChecks[k]=false--tex TODO: can't figure out why this isn't actually setting REPRO: start misison, get into vehicle, get checkpoint, return to acc, still inGroundVehicle==true
  --end
  currentChecks.inHeliSpace=false
  currentChecks.inMission=false
  currentChecks.initialAction=false
  currentChecks.inGroundVehicle=false
  currentChecks.inSupportHeli=false
  currentChecks.onBuddy=false
  currentChecks.inBox=false
  currentChecks.inMenu=false

  currentChecks.inGame=not mvars.mis_missionStateIsNotInGame
  currentChecks.inHeliSpace=vars.missionCode and TppMission.IsHelicopterSpace(vars.missionCode)
  currentChecks.inMission=currentChecks.inGame and not currentChecks.inHeliSpace

  if currentChecks.inGame then
    local playerVehicleId=vars.playerVehicleGameObjectId
    if not currentChecks.inHeliSpace then
      currentChecks.initialAction=svars.ply_isUsedPlayerInitialAction--VERIFY that start on ground catches this (it's triggered on checkpoint save DOESNT catch motherbase ground start
      --if not initialAction then--DEBUG
      --InfMenu.DebugPrint"not initialAction"
      --end
      currentChecks.inSupportHeli=Tpp.IsHelicopter(playerVehicleId)--tex VERIFY
      currentChecks.inGroundVehicle=Tpp.IsVehicle(playerVehicleId) and not currentChecks.inSupportHeli-- or Tpp.IsEnemyWalkerGear(playerVehicleId)?? VERIFY
      currentChecks.onBuddy=Tpp.IsHorse(playerVehicleId) or Tpp.IsPlayerWalkerGear(playerVehicleId)
      currentChecks.inBox=Player.IsVarsCurrentItemCBox()
    end
  end

  return currentChecks
end

function this.Update()
  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end

  local currentChecks=this.UpdateExecChecks(this.execChecks)
  this.currentTime=Time.GetRawElapsedTimeSinceStartUp()

  InfButton.UpdateHeld()
  InfButton.UpdateRepeatReset()

  local abortButton=InfButton.ESCAPE
  InfButton.buttonStates[abortButton].holdTime=2
  if InfButton.OnButtonHoldTime(abortButton) then
    if gvars.ini_isTitleMode then
      local splash=SplashScreen.Create("abortsplash","/Assets/tpp/ui/ModelAsset/sys_logo/Pictures/common_kjp_logo_clp_nmp.ftex",640,640)
      SplashScreen.Show(splash,0,0.3,0)
      this.abortToAcc=true
    else--elseif currentChecks.inGame then--WIP
    --this.ClearStatus()
    end
  end

  ---Update shiz
  InfMenu.Update(currentChecks)
  currentChecks.inMenu=InfMenu.menuOn

  for i, ivar in ipairs(updateIvars) do
    if ivar.setting>0 then
      --tex ivar.updateRate is either number or another ivar
      local updateRate=ivar.updateRate or 0
      local updateRange=ivar.updateRange or 0
      if IsTable(updateRate) then
        updateRate=updateRate.setting
      end
      if IsTable(updateRange) then
        updateRange=updateRange.setting
      end

      this.ExecUpdate(currentChecks,this.currentTime,ivar.execChecks,ivar.execState,updateRate,updateRange,ivar.ExecUpdate)
    end
  end
  ---
  InfButton.UpdatePressed()--tex GOTCHA: should be after all key reads, sets current keys to prev keys for onbutton checks
end

function this.ExecInit(currentChecks,execChecks,ExecInitFunc)
  if execChecks==nil then
    InfMenu.DebugPrint"update ivar has no execChecks var, aborting"
    return
  end
  --  for check,ivarCheck in ipairs(execChecks) do
  --    if currentChecks[check]~=ivarCheck then
  --      return
  --    end
  --  end

  ExecInitFunc(currentChecks)
end

function this.ExecUpdate(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdateFunc)
  if execState.nextUpdate > currentTime then
    return
  end

  if execChecks==nil then
    InfMenu.DebugPrint"update ivar has no execChecks var, aborting"
    return
  end
  for check,ivarCheck in ipairs(execChecks) do
    if currentChecks[check]~=ivarCheck then
      return
    end
  end

  if not IsFunc(ExecUpdateFunc) then
    InfMenu.DebugPrint"ExecUpdateFunc is not a function"
    return
  end

  ExecUpdateFunc(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdateFunc)

  --tex set up next update time GOTCHA: wont reflect changes to rate and range till next update
  if updateRange then
    local updateMin=updateRate-updateRange*0.5
    local updateMax=updateRate+updateRange*0.5
    if updateMin<0 then
      updateMin=0
    end

    updateRate=math.random(updateMin,updateMax)
  end
  execState.nextUpdate=currentTime+updateRate

  --if currentChecks.inGame then
  -- InfMenu.DebugPrint("currentTime: "..tostring(currentTime).." updateRate:"..tostring(updateRate) .." nextUpdate:"..tostring(execState.nextUpdate))
  --end
end



--warp mode
--config
this.moveRightButton=InfButton.RIGHT
this.moveLeftButton=InfButton.LEFT
this.moveForwardButton=InfButton.UP
this.moveBackButton=InfButton.DOWN
this.moveUpButton=InfButton.STANCE
this.moveDownButton=InfButton.CALL
--cam buttons
--CULL
--this.zoomInButton=InfButton.ZOOM_CHANGE
--this.zoomOutButton=InfButton.SUBJECT

this.resetModeButton=InfButton.ACTION
this.verticalModeButton=InfButton.SUBJECT
this.zoomModeButton=InfButton.FIRE
this.apertureModeButton=InfButton.RELOAD
this.focusDistanceModeButton=InfButton.STANCE
this.distanceModeButton=InfButton.CALL
this.speedModeButton=InfButton.DASH

this.nextEditCamButton=InfButton.RIGHT
this.prevEditCamButton=InfButton.LEFT

this.warpModeButtons={
  this.moveRightButton,
  this.moveLeftButton,
  this.moveForwardButton,
  this.moveBackButton,
  this.moveUpButton,
  this.moveDownButton,
}

--init
function this.InitWarpPlayerUpdate(currentChecks)
end

function this.OnActivateWarpPlayer()
  InfButton.buttonStates[this.moveRightButton].decrement=0.1
  InfButton.buttonStates[this.moveLeftButton].decrement=0.1
  InfButton.buttonStates[this.moveForwardButton].decrement=0.1
  InfButton.buttonStates[this.moveBackButton].decrement=0.1
  InfButton.buttonStates[this.moveUpButton].decrement=0.1
  InfButton.buttonStates[this.moveDownButton].decrement=0.1

  local repeatRate=0.06
  local repeatRateUp=0.04
  InfButton.buttonStates[this.moveRightButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveLeftButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveForwardButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveBackButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveUpButton].repeatRate=repeatRateUp
  InfButton.buttonStates[this.moveDownButton].repeatRate=repeatRate

  --WIP this.DisableAction(Ivars.warpPlayerUpdate.disableActions)
end

function this.OnDeactivateWarpPlayer()
--this.EnableAction(Ivars.warpPlayerUpdate.disableActions)
end

function this.UpdateWarpPlayer(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if currentChecks.inMenu then
    return
  end

  if not currentChecks.inGame or currentChecks.inHeliSpace then
    if Ivars.warpPlayerUpdate:Is(1) then
      Ivars.warpPlayerUpdate:Set(0)
    end
    return
  end

  if Ivars.warpPlayerUpdate:Is(0) then
    return
  end

  local warpAmount=1
  local warpUpAmount=1

  local moveDir={}
  moveDir[1]=0
  moveDir[2]=0
  moveDir[3]=0

  local didMove=false

  if InfButton.OnButtonDown(this.moveForwardButton)
    or InfButton.OnButtonRepeat(this.moveForwardButton) then
    moveDir[3]=warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveBackButton)
    or InfButton.OnButtonRepeat(this.moveBackButton) then
    moveDir[3]=-warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveRightButton)
    or InfButton.OnButtonRepeat(this.moveRightButton) then
    moveDir[1]=-warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveLeftButton)
    or InfButton.OnButtonRepeat(this.moveLeftButton) then
    moveDir[1]=warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveUpButton)
    or InfButton.OnButtonRepeat(this.moveUpButton) then
    moveDir[2]=warpUpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveDownButton)
    or InfButton.OnButtonRepeat(this.moveDownButton) then
    moveDir[2]=-warpAmount
    didMove=true
  end

  if didMove then
    local currentPos = Vector3(vars.playerPosX, vars.playerPosY, vars.playerPosZ)
    local vMoveDir=Vector3(moveDir[1],moveDir[2],moveDir[3])
    local rotYQuat=Quat.RotationY(TppMath.DegreeToRadian(vars.playerRotY))
    local playerMoveDir=rotYQuat:Rotate(vMoveDir)
    local warpPos=currentPos+playerMoveDir
    TppPlayer.Warp{pos={warpPos:GetX(),warpPos:GetY(),warpPos:GetZ()},rotY=vars.playerCameraRotation[1]}
  end
end


--heli, called from TppMain.Onitiialize, so should only be 'enable/change from default', VERIFY it's in the right spot to override each setting
function this.UpdateHeliVars()
  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end

  local heliId=GetGameObjectId("TppHeli2","SupportHeli")
  if heliId==nil or heliId==NULL_ID then
    return
  end

  if Ivars.disableHeliAttack:Is(1) then--tex disable heli be fightan
    SendCommand(heliId,{id="SetCombatEnabled",enabled=false})
  end
  if Ivars.setInvincibleHeli:Is(1) then
    SendCommand(heliId,{id="SetInvincible",enabled=true})
  end
  if not Ivars.setTakeOffWaitTime:IsDefault() then
    SendCommand(heliId,{id="SetTakeOffWaitTime",time=Ivars.setTakeOffWaitTime:Get()})
  end
  if Ivars.disablePullOutHeli:Is(1) then
    --if not TppLocation.IsMotherBase() and not TppLocation.IsMBQF() then--tex aparently disablepullout overrides the mother base taxi service TODO: not sure if I want to turn this off to save user confusion, or keep consistant behaviour
    SendCommand(heliId,{id="DisablePullOut"})
    --end
  end
  if not Ivars.setLandingZoneWaitHeightTop:IsDefault() then
    SendCommand(heliId,{id="SetLandingZoneWaitHeightTop",height=Ivars.setLandingZoneWaitHeightTop:Get()})
  end
  if Ivars.disableDescentToLandingZone:Is(1) then
    SendCommand(heliId,{id="DisableDescentToLandingZone"})
  end
  if Ivars.setSearchLightForcedHeli:Is(1) then
    SendCommand(heliId,{id="SetSearchLightForcedType",type="Off"})
  end

  --if TppMission.IsMbFreeMissions(vars.missionCode) then--TEST no aparent result on initial testing, in-engine pullout check must be overriding
  --  TppUiStatusManager.UnsetStatus( "MbMap", "BLOCK_TAXI_CHANGE_LOCATION" )
  --end
end



function this.OnMenuOpen()

end
function this.OnMenuClose()
  local activeControlMode=this.GetActiveControlMode()
  if activeControlMode then
    if IsFunc(activeControlMode.OnActivate) then
      activeControlMode.OnActivate()
    end
  end
end


local controlModes={
  Ivars.warpPlayerUpdate,
  Ivars.adjustCameraUpdate,
}
function this.GetActiveControlMode()
  for i,ivar in ipairs(controlModes)do
    if ivar:Is(1) then
      return ivar
    end
  end
  return nil
end
--

function this.HeliOrderRecieved()
  if this.execChecks.inGame and not this.execChecks.inHeliSpace then
    InfMenu.PrintLangId"order_recieved"
  end
end



--tex has no effect sadly, only boss quiet gameobject i guess
function this.SetQuietHumming(hummingFlag)
  local command = {id="SetHumming", flag=hummingFlag}
  local gameObjectId = GameObject.GetGameObjectIdByIndex("TppBuddyQuiet2", 0)

  if gameObjectId ~= NULL_ID then
    --InfMenu.DebugPrint("sethumming:"..tostring(hummingFlag))--DEBUG
    SendCommand(gameObjectId, command)
  else
  --InfMenu.DebugPrint"no TppBuddyQuiet2 found"--DEBUG
  end
end

--lrrp plus
local afghBaseNames={
  "afgh_villageEast_ob",
  "afgh_commWest_ob",
  "afgh_cliffSouth_ob",
  "afgh_villageWest_ob",
  "afgh_bridgeWest_ob",
  "afgh_tentEast_ob",
  "afgh_enemyNorth_ob",
  "afgh_cliffWest_ob",
  "afgh_cliffEast_ob",
  "afgh_fortWest_ob",
  "afgh_slopedEast_ob",
  "afgh_fortSouth_ob",
  "afgh_ruinsNorth_ob",
  "afgh_villageNorth_ob",
  "afgh_slopedWest_ob",
  "afgh_fieldEast_ob",
  "afgh_plantSouth_ob",
  "afgh_waterwayEast_ob",
  "afgh_plantWest_ob",
  "afgh_fieldWest_ob",
  "afgh_remnantsNorth_ob",
  "afgh_tentNorth_ob",
  "afgh_cliffTown_cp",
  "afgh_tent_cp",
  "afgh_waterway_cp",
  "afgh_powerPlant_cp",
  "afgh_sovietBase_cp",
  "afgh_remnants_cp",
  "afgh_field_cp",
  "afgh_citadel_cp",
  "afgh_fort_cp",
  "afgh_village_cp",
  "afgh_bridge_cp",
  "afgh_commFacility_cp",
  "afgh_slopedTown_cp",
  "afgh_enemyBase_cp",
  "afgh_bridgeNorth_ob",
  "afgh_enemyEast_ob",
  "afgh_sovietSouth_ob",
}--#39

local mafrBaseNames={
  "mafr_outlandNorth_ob",
  "mafr_swampWest_ob",
  "mafr_outlandEast_ob",
  "mafr_bananaSouth_ob",
  "mafr_swampSouth_ob",
  "mafr_swampEast_ob",
  "mafr_savannahWest_ob",
  "mafr_bananaEast_ob",
  "mafr_savannahNorth_ob",
  "mafr_diamondWest_ob",
  "mafr_diamondSouth_ob",
  "mafr_hillNorth_ob",
  "mafr_savannahEast_ob",
  "mafr_hillWest_ob",
  "mafr_pfCampEast_ob",
  "mafr_pfCampNorth_ob",
  "mafr_factorySouth_ob",
  "mafr_diamondNorth_ob",
  "mafr_labWest_ob",
  "mafr_outland_cp",
  "mafr_flowStation_cp",
  "mafr_swamp_cp",
  "mafr_pfCamp_cp",
  "mafr_savannah_cp",
  "mafr_banana_cp",
  "mafr_diamond_cp",
  "mafr_hill_cp",
  "mafr_factory_cp",
  "mafr_lab_cp",
  "mafr_hillWestNear_ob",
  "mafr_hillSouth_ob",
  "mafr_swampWestNear_ob",
  "mafr_chicoVilWest_ob",
  "mafr_chicoVil_cp",
}--#34

--reserve vehiclepool
this.reserveVehicleNames={}
--local vehPrefix="veh_ih_"
--this.numReserveVehicles=12--tex SYNC number of soldier locators i added to fox2s
--for i=0,this.numReserveVehicles-1 do
--  local name=vehPrefix..string.format("%04d", i)
--  table.insert(this.reserveVehicleNames,name)
--end

this.mbVehicleNames={
  "veh_cl01_cl00_0000",
  "veh_cl02_cl00_0000",
  "veh_cl03_cl00_0000",
  "veh_cl04_cl00_0000",
  "veh_cl05_cl00_0000",
  "veh_cl06_cl00_0000",
  "veh_cl00_cl04_0000",
  "veh_cl00_cl02_0000",
  "veh_cl00_cl03_0000",
  "veh_cl00_cl01_0000",
  "veh_cl00_cl05_0000",
  "veh_cl00_cl06_0000",
}

--reserve soldierpool
this.reserveSoldierNames={}
local solPrefix="sol_ih_"
this.numReserveSoldiers=40--tex SYNC number of soldier locators i added to fox2s
for i=0,this.numReserveSoldiers-1 do
  local name=solPrefix..string.format("%04d", i)
  table.insert(this.reserveSoldierNames,name)
end

function this.ResetObjectPool(objectType,objectNames)
  local pool={}
  for n,objectName in ipairs(objectNames) do
    local gameId=GetGameObjectId(objectType,objectName)
    if gameId==NULL_ID then
    --InfMenu.DebugPrint(objectName.."==NULL_ID")--DEBUG
    else
      table.insert(pool,objectName)
    end
  end
  return pool
end

local function FillLrrp(num,soldierPool,cpDefine)
  local soldiers={}
  while num>0 and #soldierPool>0 do
    local soldierName=soldierPool[#soldierPool]
    if soldierName then
      table.remove(soldierPool)--pop
      table.insert(cpDefine,soldierName)
      table.insert(soldiers,soldierName)
      num=num-1
    end
  end
  return soldiers
end

function this.ResetPool(objectNames)
  local namePool={}
  for n,name in ipairs(objectNames) do
    table.insert(namePool,name)
  end
  return namePool
end

function this.GetRandomPool(pool)
  local rndIndex=math.random(#pool)
  local name=pool[rndIndex]
  table.remove(pool,rndIndex)
  return name
end

function this.ModifyVehiclePatrolSoldiers(soldierDefine)
  if vars.missionCode~=30010 and vars.missionCode~=30020 then
    return
  end

  if Ivars.vehiclePatrolProfile:Is()>0 and Ivars.vehiclePatrolProfile:MissionCheck() then
    InfMain.SetLevelRandomSeed()

    --local initPoolSize=#this.soldierPool--DEBUG
    for cpName,cpDefine in pairs(soldierDefine)do
      local numCpSoldiers=0
      for n,soldierName in ipairs(cpDefine)do
        numCpSoldiers=numCpSoldiers+1
      end

      if cpDefine.lrrpVehicle then
        local numSeats=2
        if mvars.patrolVehicleBaseInfo then
          local baseTypeInfo=mvars.patrolVehicleBaseInfo[cpDefine.lrrpVehicle]
          if baseTypeInfo then
            numSeats=math.random(math.min(numSeats,baseTypeInfo.seats),baseTypeInfo.seats)
            --InfMenu.DebugPrint(cpDefine.lrrpVehicle .. " numVehSeats "..numSeats)--DEBUG
          end
        end
        --
        if numCpSoldiers>numSeats then
          local gotSeat=0
          local clearIndices={}
          for n,soldierName in ipairs(cpDefine)do
            gotSeat=gotSeat+1
            if gotSeat>numSeats then
              table.insert(this.soldierPool,soldierName)
              cpDefine[n]=nil
            end
          end
        else
          numSeats=numSeats-numCpSoldiers
          --InfMenu.DebugPrint(cpDefine.lrrpVehicle .. " numfillSeats "..numSeats)--DEBUG
          if numSeats>0 then
            FillLrrp(numSeats,this.soldierPool,cpDefine)
          end
        end
        --if lrrpVehicle<
      end
      --for soldierdefine<
    end
    --local poolChange=#this.soldierPool-initPoolSize--DEBUG
    --InfMenu.DebugPrint("pool change:"..poolChange)--DEBUG

    InfMain.ResetTrueRandom()

    --if vehiclePatrol
  end
end

--IN/OUT,SIDE reserveSoldierPool
function this.AddLrrps(soldierDefine,travelPlans)
  if vars.missionCode~=30010 and vars.missionCode~=30020 then
    return
  end

  if Ivars.enableLrrpFreeRoam:Is(0) then
    return
  end

  InfMain.SetLevelRandomSeed()

  local cpPool={}

  local lrrpInd="_lrrp"
  for cpName,cpDefine in pairs(soldierDefine)do
    local cpId=GetGameObjectId(cpName)
    if cpId==NULL_ID then
      InfMenu.DebugPrint(cpName.."==NULL_ID")--DEBUG
    else
      --if #cpDefine==0 then --OFF wont be empty on restart from checkpoint
      --tex cp is labeled _lrrp
      if string.find(cpName,lrrpInd) then
        if not cpDefine.lrrpVehicle then
          table.insert(cpPool,cpName)
        end
      end
    end
  end
  --InfMenu.DebugPrint("cpPool"..#cpPool)--DEBUG

  local planStr="travelIH_"

  local reserved=0--6
  --tex OFF
  --  local minSize=Ivars.lrrpSizeFreeRoam_MIN:Get()
  --  local maxSize=Ivars.lrrpSizeFreeRoam_MAX:Get()
  --  if maxSize>#this.soldierPool then
  --    maxSize=#this.soldierPool
  --  end
  local numLrrps=0

  local baseNamePool={}
  local startBases={}
  local endBases={}
  if TppLocation.IsAfghan()then
    startBases=this.ResetPool(afghBaseNames)
  elseif TppLocation.IsMiddleAfrica()then
    startBases=this.ResetPool(mafrBaseNames)
  end
  for n,cpName in pairs(startBases)do
    local cpDefine=soldierDefine[cpName]
    if cpDefine==nil then
    --InfMenu.DebugPrint(tostring(cpName).." cpDefine==nil")--DEBUG
    else
      local cpId=GetGameObjectId(cpName)
      if cpId==NULL_ID then
      --InfMenu.DebugPrint(tostring(cpName).." cpId==NULL_ID")--DEBUG
      else
        table.insert(baseNamePool,cpName)
      end
    end
  end
  startBases=baseNamePool
  local half=math.floor(#startBases/2)
  for i=0, half do
    table.insert(endBases,this.GetRandomPool(startBases))
  end
  --tex TODO, copy off tables, swap, and make a second pass


  while #this.soldierPool-reserved>0 do

    --tex done, this limits to one lrrp per base (or rather starting at base, the end is much more random)
    --TODO: a second pass with start and end tables swapped (would have to copy off the tables above i guess)
    if #startBases==0 or #endBases==0 then
      --InfMenu.DebugPrint"#startBases==0"--DEBUG
      break
    end

    if #cpPool==0 then
      --InfMenu.DebugPrint"#cpPool==0"--DEBUG
      break
    end
    if #this.soldierPool==0 then
      --InfMenu.DebugPrint"#soldierPool==0"--DEBUG
      break
    end

    local lrrpSize=2 --WIP custom lrrp size OFF to give coverage till I can come up with something better math.random(minSize,maxSize)
    --tex TODO: stop it from eating reserved
    --InfMenu.DebugPrint("lrrpSize "..lrrpSize)--DEBUG

    local cpName=cpPool[#cpPool]
    table.remove(cpPool)

    --InfMenu.DebugPrint("cpName:"..tostring(cpName))--DEBUG

    local cpDefine={}
    soldierDefine[cpName]=cpDefine--tex GOTCHA clearing the cp here, wheres in AddWildCards we are reading existing

    local soldiers=FillLrrp(lrrpSize,this.soldierPool,cpDefine)

    local planName=planStr..cpName
    cpDefine.lrrpTravelPlan=planName
    travelPlans[planName]={
      {base=this.GetRandomPool(startBases)},
      {base=this.GetRandomPool(endBases)},
    }
    numLrrps=numLrrps+1
  end
  --InfMenu.DebugPrint("num lrrps"..numLrrps)--DEBUG

  InfMain.ResetTrueRandom()
end

this.MAX_WILDCARD_FACES=4--10
function this.AddWildCards(soldierDefine,soldierTypes,soldierSubTypes,soldierPowerSettings,soldierPersonalAbilitySettings)
  if not (Ivars.enableWildCardFreeRoam:Is(1) and Ivars.enableWildCardFreeRoam:MissionCheck()) then
    return
  end

  InfMain.SetLevelRandomSeed()

  local reserved=0

  local numLrrps=0

  local baseNamePool={}

  for cpName,cpDefine in pairs(soldierDefine)do
    if #cpDefine>0 then
      local cpId=GetGameObjectId(cpName)
      if cpId~=NULL_ID then
        if cpDefine.lrrpVehicle==nil and cpDefine.lrrpTravelPlan==nil then--tex TODO: think if you want to add wildcards to vehicle lrrps, would need to makes sure its a vehicle where they're a passenger
          table.insert(baseNamePool,cpName)
        end
      end
    end
  end

  local wildCardSubType="SOVIET_WILDCARD"
  if TppLocation.IsAfghan()then
    wildCardSubType="SOVIET_WILDCARD"
  elseif TppLocation.IsMiddleAfrica()then
    wildCardSubType="PF_WILDCARD"
  end

  local gearPowers={
    "HELMET",
    "SOFT_ARMOR",
    "GUN_LIGHT",
    "NVG",
  --"GAS_MASK",
  }
  local weaponPowers={
    "ASSAULT",
    "SMG",
    "SHOTGUN",
    "MG",
    "SNIPER",
  --"MISSILE",
  }


  local weaponPool={}

  local abilityLevel="sp"
  local personalAbilitySettings={
    notice=abilityLevel,
    cure=abilityLevel,
    reflex=abilityLevel,
    shot=abilityLevel,
    grenade=abilityLevel,
    reload=abilityLevel,
    hp=abilityLevel,
    speed=abilityLevel,
    fulton=abilityLevel,
    holdup=abilityLevel
  }

  local numWildCards=math.max(1,math.ceil(#baseNamePool/5))
  local numFemale=2--math.max(1,math.ceil(numWildCards/3))--SYNC: MAX_WILDCARD_FACES
  --InfMenu.DebugPrint("numwildcards: "..numWildCards .. " numFemale:"..numFemale)--DEBUG

  local faceIdPool={}

  --  InfMenu.DebugPrint"ene_wildCardFaceList"--DEBUG >
  --  local ins=InfInspect.Inspect(InfEneFova.inf_wildCardFaceList)
  --  InfMenu.DebugPrint(ins)--<

  this.ene_wildCardSoldiers={}
  this.ene_femaleWildCardSoldiers={}

  for i=1,numWildCards do
    if #baseNamePool==0 then
      --InfMenu.DebugPrint"#baseNamePool==0"--DEBUG
      break
    end

    local cpName=this.GetRandomPool(baseNamePool)
    --InfMenu.DebugPrint("cpName:"..tostring(cpName))--DEBUG

    local cpDefine=soldierDefine[cpName]
    --local wildCardsPerCp=1
    --local soldiers=FillLrrp(wildCardsPerCp,this.soldierPool,cpDefine)
    if #cpDefine>0 then
      --WIP add soldier to cover
      --tex adding soldiers will mess things up because of soldiername random #cpdefine
      --alternative would be to save off wildcard soldiers and read that
      --      if #this.soldierPool>0 then
      --        local soldierName=this.soldierPool[#this.soldierPool]
      --        if soldierName then
      --      --          InfMenu.DebugPrint("addwild pool "..soldierName)--DEBUG
      --          table.insert(cpDefine,soldierName)
      --          table.remove(this.soldierPool)--pop
      --        end
      --      end


      local soldierName=cpDefine[math.random(#cpDefine)]
      table.insert(this.ene_wildCardSoldiers,soldierName)

      --local isFemale=math.random()<=femaleChance
      --CULL
      --local soldiers=FillLrrp(
      --for n,soldierName in pairs(soldiers)do
      local isFemale=false
      if InfEneFova.inf_wildCardFaceList then
        if numFemale>0 then
          isFemale=true
          numFemale=numFemale-1
          table.insert(this.ene_femaleWildCardSoldiers,soldierName)

          if #faceIdPool==0 then
            faceIdPool=this.ResetPool(InfEneFova.inf_wildCardFaceList)
          end

          local faceId=this.GetRandomPool(faceIdPool)
          local bodyId=EnemyFova.INVALID_FOVA_VALUE
          TppEneFova.RegisterUniqueSetting("enemy",soldierName,faceId,bodyId)
        end
      else
        InfMenu.DebugPrint"WARNING no inf_wildCardFaceList!"
      end

      local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", soldierName )
      if gameObjectId==NULL_ID then
        InfMenu.DebugPrint"AddWildCards gameObjectId==NULL_ID"--DEBUG
      else
        local command={id="UseExtendParts",enabled=isFemale}
        GameObject.SendCommand(gameObjectId,command)
      end
      --end
      soldierSubTypes[wildCardSubType]=soldierSubTypes[wildCardSubType] or {}
      table.insert(soldierSubTypes[wildCardSubType],soldierName)


      local soldierPowers={}
      for n,power in pairs(gearPowers) do
        table.insert(soldierPowers,power)
      end
      if #weaponPool==0 then
        weaponPool=this.ResetPool(weaponPowers)
      end
      local weapon=this.GetRandomPool(weaponPool)
      table.insert(soldierPowers,weapon)

      soldierPowerSettings[soldierName]=soldierPowers

      soldierPersonalAbilitySettings[soldierName]=personalAbilitySettings
      --end

      numLrrps=numLrrps+1
    end
  end

  --  --DEBUG
  --  for n,soldierName in pairs(this.ene_wildCardSoldiers)do
  --    InfMenu.DebugPrint(soldierName)
  --    local ins=InfInspect.Inspect(soldierPowerSettings[soldierName])
  --    InfMenu.DebugPrint(ins)
  -- end

  --InfMenu.DebugPrint("num wildCards"..numLrrps)--DEBUG
  InfMain.ResetTrueRandom()
end

---
function this.MarkObject(gameId)
  if gameId==NULL_ID then
    return
  end

  local radiusLevel=0--0-9
  local goalType="none"--TppMarker.GoalTypes
  local viewType="all"--TppMarker.ViewTypes
  local randomLevel=0--0-9 randoms to radiuslevel I guess
  local setImportant=true
  local setNew=false
  TppMarker.Enable(gameId,0,"moving","all",0,setImportant,setNew)
end
---

local TppGameObject=TppGameObject

local gameObjectTypes={}
local gameObjectTypeLiteralStr="GAME_OBJECT_TYPE_"

--tex from exe, don't know if anythings missing (as it commonly seems)
this.gameObjectStringToType={
  GAME_OBJECT_TYPE_PLAYER2=TppGameObject.GAME_OBJECT_TYPE_PLAYER2,
  GAME_OBJECT_TYPE_COMMAND_POST2=TppGameObject.GAME_OBJECT_TYPE_COMMAND_POST2,
  GAME_OBJECT_TYPE_SOLDIER2=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2,
  GAME_OBJECT_TYPE_HOSTAGE2=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2,
  GAME_OBJECT_TYPE_HOSTAGE_UNIQUE=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE,
  GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_UNIQUE2,
  GAME_OBJECT_TYPE_HOSTAGE_KAZ=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE_KAZ,
  GAME_OBJECT_TYPE_OCELOT2=TppGameObject.GAME_OBJECT_TYPE_OCELOT2,
  GAME_OBJECT_TYPE_HUEY2=TppGameObject.GAME_OBJECT_TYPE_HUEY2,
  GAME_OBJECT_TYPE_CODE_TALKER2=TppGameObject.GAME_OBJECT_TYPE_CODE_TALKER2,
  GAME_OBJECT_TYPE_SKULL_FACE2=TppGameObject.GAME_OBJECT_TYPE_SKULL_FACE2,
  GAME_OBJECT_TYPE_MANTIS2=TppGameObject.GAME_OBJECT_TYPE_MANTIS2,
  GAME_OBJECT_TYPE_BIRD2=TppGameObject.GAME_OBJECT_TYPE_BIRD2,
  GAME_OBJECT_TYPE_HORSE2=TppGameObject.GAME_OBJECT_TYPE_HORSE2,
  GAME_OBJECT_TYPE_HELI2=TppGameObject.GAME_OBJECT_TYPE_HELI2,
  GAME_OBJECT_TYPE_ENEMY_HELI=TppGameObject.GAME_OBJECT_TYPE_ENEMY_HELI,
  GAME_OBJECT_TYPE_OTHER_HELI=TppGameObject.GAME_OBJECT_TYPE_OTHER_HELI,
  GAME_OBJECT_TYPE_OTHER_HELI2=TppGameObject.GAME_OBJECT_TYPE_OTHER_HELI2,
  GAME_OBJECT_TYPE_BUDDYQUIET2=TppGameObject.GAME_OBJECT_TYPE_BUDDYQUIET2,
  GAME_OBJECT_TYPE_BUDDYDOG2=TppGameObject.GAME_OBJECT_TYPE_BUDDYDOG2,
  GAME_OBJECT_TYPE_BUDDYPUPPY=TppGameObject.GAME_OBJECT_TYPE_BUDDYPUPPY,
  GAME_OBJECT_TYPE_SAHELAN2=TppGameObject.GAME_OBJECT_TYPE_SAHELAN2,
  GAME_OBJECT_TYPE_PARASITE2=TppGameObject.GAME_OBJECT_TYPE_PARASITE2,
  GAME_OBJECT_TYPE_LIQUID2=TppGameObject.GAME_OBJECT_TYPE_LIQUID2,
  GAME_OBJECT_TYPE_VOLGIN2=TppGameObject.GAME_OBJECT_TYPE_VOLGIN2,
  GAME_OBJECT_TYPE_BOSSQUIET2=TppGameObject.GAME_OBJECT_TYPE_BOSSQUIET2,
  GAME_OBJECT_TYPE_UAV=TppGameObject.GAME_OBJECT_TYPE_UAV,
  GAME_OBJECT_TYPE_SECURITYCAMERA2=TppGameObject.GAME_OBJECT_TYPE_SECURITYCAMERA2,
  GAME_OBJECT_TYPE_GOAT=TppGameObject.GAME_OBJECT_TYPE_GOAT,
  GAME_OBJECT_TYPE_NUBIAN=TppGameObject.GAME_OBJECT_TYPE_NUBIAN,
  GAME_OBJECT_TYPE_CRITTER_BIRD=TppGameObject.GAME_OBJECT_TYPE_CRITTER_BIRD,
  GAME_OBJECT_TYPE_STORK=TppGameObject.GAME_OBJECT_TYPE_STORK,
  GAME_OBJECT_TYPE_EAGLE=TppGameObject.GAME_OBJECT_TYPE_EAGLE,
  GAME_OBJECT_TYPE_RAT=TppGameObject.GAME_OBJECT_TYPE_RAT,
  GAME_OBJECT_TYPE_ZEBRA=TppGameObject.GAME_OBJECT_TYPE_ZEBRA,
  GAME_OBJECT_TYPE_WOLF=TppGameObject.GAME_OBJECT_TYPE_WOLF,
  GAME_OBJECT_TYPE_JACKAL=TppGameObject.GAME_OBJECT_TYPE_JACKAL,
  GAME_OBJECT_TYPE_BEAR=TppGameObject.GAME_OBJECT_TYPE_BEAR,
  GAME_OBJECT_TYPE_CORPSE=TppGameObject.GAME_OBJECT_TYPE_CORPSE,
  GAME_OBJECT_TYPE_MBQUIET=TppGameObject.GAME_OBJECT_TYPE_MBQUIET,
  GAME_OBJECT_TYPE_COMMON_HORSE2=TppGameObject.GAME_OBJECT_TYPE_COMMON_HORSE2,
  GAME_OBJECT_TYPE_HORSE2_FOR_VR=TppGameObject.GAME_OBJECT_TYPE_HORSE2_FOR_VR,
  GAME_OBJECT_TYPE_PLAYER_HORSE2_FOR_VR=TppGameObject.GAME_OBJECT_TYPE_PLAYER_HORSE2_FOR_VR,
  GAME_OBJECT_TYPE_VOLGIN2_FOR_VR=TppGameObject.GAME_OBJECT_TYPE_VOLGIN2_FOR_VR,
  GAME_OBJECT_TYPE_WALKERGEAR2=TppGameObject.GAME_OBJECT_TYPE_WALKERGEAR2,
  GAME_OBJECT_TYPE_COMMON_WALKERGEAR2=TppGameObject.GAME_OBJECT_TYPE_COMMON_WALKERGEAR2,
  GAME_OBJECT_TYPE_BATTLEGEAR=TppGameObject.GAME_OBJECT_TYPE_BATTLEGEAR,
  GAME_OBJECT_TYPE_EXAMPLE=TppGameObject.GAME_OBJECT_TYPE_EXAMPLE,
  GAME_OBJECT_TYPE_SAMPLE_GAME_OBJECT=TppGameObject.GAME_OBJECT_TYPE_SAMPLE_GAME_OBJECT,
  GAME_OBJECT_TYPE_NOTICE_OBJECT=TppGameObject.GAME_OBJECT_TYPE_NOTICE_OBJECT,
  GAME_OBJECT_TYPE_VEHICLE=TppGameObject.GAME_OBJECT_TYPE_VEHICLE,
  GAME_OBJECT_TYPE_MOTHER_BASE_CONTAINER=TppGameObject.GAME_OBJECT_TYPE_MOTHER_BASE_CONTAINER,
  GAME_OBJECT_TYPE_EQUIP_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_EQUIP_SYSTEM,
  GAME_OBJECT_TYPE_PICKABLE_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_PICKABLE_SYSTEM,
  GAME_OBJECT_TYPE_COLLECTION_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_COLLECTION_SYSTEM,
  GAME_OBJECT_TYPE_THROWING_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_THROWING_SYSTEM,
  GAME_OBJECT_TYPE_PLACED_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_PLACED_SYSTEM,
  GAME_OBJECT_TYPE_SHELL_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_SHELL_SYSTEM,
  GAME_OBJECT_TYPE_BULLET_SYSTEM3=TppGameObject.GAME_OBJECT_TYPE_BULLET_SYSTEM3,
  GAME_OBJECT_TYPE_CASING_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_CASING_SYSTEM,
  GAME_OBJECT_TYPE_FULTON=TppGameObject.GAME_OBJECT_TYPE_FULTON,
  GAME_OBJECT_TYPE_BALLOON_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_BALLOON_SYSTEM,
  GAME_OBJECT_TYPE_PARACHUTE_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_PARACHUTE_SYSTEM,
  GAME_OBJECT_TYPE_SUPPLY_CBOX=TppGameObject.GAME_OBJECT_TYPE_SUPPLY_CBOX,
  GAME_OBJECT_TYPE_SUPPORT_ATTACK=TppGameObject.GAME_OBJECT_TYPE_SUPPORT_ATTACK,
  GAME_OBJECT_TYPE_RANGE_ATTACK=TppGameObject.GAME_OBJECT_TYPE_RANGE_ATTACK,
  GAME_OBJECT_TYPE_CBOX=TppGameObject.GAME_OBJECT_TYPE_CBOX,
  GAME_OBJECT_TYPE_OBSTRUCTION_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_OBSTRUCTION_SYSTEM,
  GAME_OBJECT_TYPE_DECOY_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_DECOY_SYSTEM,
  GAME_OBJECT_TYPE_CAPTURECAGE_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_CAPTURECAGE_SYSTEM,
  GAME_OBJECT_TYPE_DUNG_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_DUNG_SYSTEM,
  GAME_OBJECT_TYPE_MARKER2_LOCATOR=TppGameObject.GAME_OBJECT_TYPE_MARKER2_LOCATOR,
  GAME_OBJECT_TYPE_ESPIONAGE_RADIO=TppGameObject.GAME_OBJECT_TYPE_ESPIONAGE_RADIO,
  GAME_OBJECT_TYPE_MGO_ACTOR=TppGameObject.GAME_OBJECT_TYPE_MGO_ACTOR,
  GAME_OBJECT_TYPE_FOB_GAME_DAEMON=TppGameObject.GAME_OBJECT_TYPE_FOB_GAME_DAEMON,
  GAME_OBJECT_TYPE_SYSTEM_RECEIVER=TppGameObject.GAME_OBJECT_TYPE_SYSTEM_RECEIVER,
  GAME_OBJECT_TYPE_SEARCHLIGHT=TppGameObject.GAME_OBJECT_TYPE_SEARCHLIGHT,
  GAME_OBJECT_TYPE_FULTONABLE_CONTAINER=TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER,
  GAME_OBJECT_TYPE_GARBAGEBOX=TppGameObject.GAME_OBJECT_TYPE_GARBAGEBOX,
  GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE=TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
  GAME_OBJECT_TYPE_GATLINGGUN=TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN,
  GAME_OBJECT_TYPE_MORTAR=TppGameObject.GAME_OBJECT_TYPE_MORTAR,
  GAME_OBJECT_TYPE_MACHINEGUN=TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN,
  GAME_OBJECT_TYPE_DOOR=TppGameObject.GAME_OBJECT_TYPE_DOOR,
  GAME_OBJECT_TYPE_WATCH_TOWER=TppGameObject.GAME_OBJECT_TYPE_WATCH_TOWER,
  GAME_OBJECT_TYPE_TOILET=TppGameObject.GAME_OBJECT_TYPE_TOILET,
  GAME_OBJECT_TYPE_ESPIONAGEBOX=TppGameObject.GAME_OBJECT_TYPE_ESPIONAGEBOX,
  GAME_OBJECT_TYPE_IR_SENSOR=TppGameObject.GAME_OBJECT_TYPE_IR_SENSOR,
  GAME_OBJECT_TYPE_EVENT_ANIMATION=TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION,
  GAME_OBJECT_TYPE_BRIDGE=TppGameObject.GAME_OBJECT_TYPE_BRIDGE,
  GAME_OBJECT_TYPE_WATER_TOWER=TppGameObject.GAME_OBJECT_TYPE_WATER_TOWER,
  GAME_OBJECT_TYPE_RADIO_CASSETTE=TppGameObject.GAME_OBJECT_TYPE_RADIO_CASSETTE,
  GAME_OBJECT_TYPE_POI_SYSTEM=TppGameObject.GAME_OBJECT_TYPE_POI_SYSTEM,
  GAME_OBJECT_TYPE_SAMPLE_MANAGER=TppGameObject.GAME_OBJECT_TYPE_SAMPLE_MANAGER,
}
this.gameObjectTypeToString={}
for k,v in pairs(this.gameObjectStringToType)do
  this.gameObjectTypeToString[v]=k
end

--tex there's no real lookup for this I've found
--there's probably faster tables (look in DefineSoldiers()) that have the cpId>soldierId, but this is nice for the soldiername,cpname

local npcHeliList={
  "WestHeli0000",
  "WestHeli0001",
  "WestHeli0002",
  "EnemyHeli",
  "EnemyHeli0000",
  "EnemyHeli0001",
  "EnemyHeli0002",
  "EnemyHeli0003",
  "EnemyHeli0004",
  "EnemyHeli0005",
  "EnemyHeli0006",
}

function this.SoldierNameForGameId(findId)
  for n,soldierName in ipairs(TppReinforceBlock.REINFORCE_SOLDIER_NAMES)do
    local soldierId=GetGameObjectId("TppSoldier2",soldierName)
    if soldierId~=NULL_ID then
      if soldierId==findId then
        return soldierName
      end
    end
  end

  for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
    for n,soldierName in ipairs(soldierList)do
      local soldierId=GetGameObjectId("TppSoldier2",soldierName)
      if soldierId~=NULL_ID then
        if soldierId==findId then
          return soldierName,cpName
        end
      end
    end
  end

  for n,heliName in ipairs(npcHeliList)do
    local soldierId=GetGameObjectId(heliName)
    if soldierId~=NULL_ID then
      if soldierId==findId then
        return heliName
      end
    end
  end

  return "object name not found"
end


function this.ClearStatus()
  InfInspect.TryFunc(function()
    local splash=SplashScreen.Create("abortsplash","/Assets/tpp/ui/ModelAsset/sys_logo/Pictures/common_kjp_logo_clp_nmp.ftex",640,640)
    SplashScreen.Show(splash,0,0.3,0)

    vars.playerDisableActionFlag=PlayerDisableAction.NONE
    Player.SetPadMask{settingName="AllClear"}
    Tpp.SetGameStatus{target="all",enable=true,scriptName="InfMain.lua"}
    InfMenu.DebugPrint"Cleared status"
  end)
end

this.heliColors={
  [TppDefine.ENEMY_HELI_COLORING_TYPE.DEFAULT]={pack="",fova=""},
  [TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={pack="/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk",fova="/Assets/tpp/fova/mecha/sbh/sbh_ene_blk.fv2"},
  [TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={pack="/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk",fova="/Assets/tpp/fova/mecha/sbh/sbh_ene_red.fv2"}
}
this.heliColorNames={
  "DEFAULT",
  "BLACK",
  "RED",
}

function this.IvarsIsForMission(ivarList,setting,missionCode)
  local passedCheck=false
  for n,ivar in ipairs(ivarList) do
    if ivar:Is(setting) and ivar:MissionCheck(missionCode) then
      passedCheck=true
      break
    end
  end
  return passedCheck
end

function this.IvarsEnabledForMission(ivarList,missionCode)
  local passedCheck=false
  for n,ivar in ipairs(ivarList) do
    if ivar:Is()>0 and ivar:MissionCheck(missionCode) then
      passedCheck=true
      break
    end
  end
  return passedCheck
end


function this.IsStartOnFoot(missionCode,isAssaultLz)
  local missionCode=missionCode or vars.missionCode
  local ivarList={
    Ivars.startOnFootMission,
    Ivars.startOnFootFree,
    Ivars.startOnFootMb
  }
  local enabled=InfMain.IvarsEnabledForMission(ivarList)

  local assault=InfMain.IvarsIsForMission(ivarList,"NOT_ASSAULT",missionCode)
  if isAssaultLz and assault then
    return false
  else
    return enabled
  end

end

function this.GetAverageRevengeLevel()
  local stealthLevel=TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.STEALTH)
  local combatLevel=TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)

  return math.ceil((stealthLevel+combatLevel)/2)
end

this.locationIdForName={
  afgh=10,
  mafr=20,
  cypr=30,
  mtbs=50,
  mbqf=55,
}

--mbmorale
--tuning tex TODO: do I want to fuzz these?
local rewardMorale=1
local rewardOnSalutesCount=14--12 is nice if stacking since it's a division of total, but it's just a smidgen too easy for a single
local rewardOnClustersCount={
  [5]=true,
  [7]=true
}

local saluteClusterCounts={}
local visitedClusterCounts={}
local totalSaluteCount=0
local totalVisitedCount=0
local lastSalute=0

local saluteRewards=0
local visitRewards={}

function this.ClearMoraleInfo()
  totalSaluteCount=0
  totalVisitedCount=0
  for i=1,#TppDefine.CLUSTER_NAME do
    saluteClusterCounts[i]=0
    visitedClusterCounts[i]=false
  end

  saluteRewards=0
  for n,bool in pairs(rewardOnClustersCount) do
    visitRewards[n]=false
  end

  lastSalute=0
end

function this.GetTotalSalutes()
  local total=0
  for i=1,#TppDefine.CLUSTER_NAME do
    total=total+saluteClusterCounts[i]
  end
  return total
end

function this.CheckSalutes()
  InfInspect.TryFunc(function()
    if vars.missionCode==30050 and Ivars.mbMoraleBoosts:Is(1) then
      local currentCluster=mtbs_cluster.GetCurrentClusterId()

      saluteClusterCounts[currentCluster]=saluteClusterCounts[currentCluster]+1
      local totalSalutes=this.GetTotalSalutes()
      --InfMenu.DebugPrint("SaluteRaiseMorale cluster "..currentCluster.." count:"..saluteClusterCounts[currentCluster].. " total sulutes:"..totalSalutes)--DEBUG
      --InfInspect.PrintInspect(saluteClusterCounts)--DEBUG

      local modTotalSalutes=totalSalutes % rewardOnSalutesCount
      --InfMenu.DebugPrint("totalSalutes % rewardSalutesCount ="..modTotalSalutes)--DEBUG
      if modTotalSalutes == 0 then        
        saluteRewards=saluteRewards+1
        --InfMenu.DebugPrint("REWARD for "..totalSalutes.." salutes")--DEBUG
        InfMenu.PrintLangId"mb_morale_visit_noticed"
      end

      local totalClustersVisited=0
      for clusterId,saluteCount in pairs(saluteClusterCounts) do
        if saluteCount>0 then
          totalClustersVisited=totalClustersVisited+1
        end
      end
      --InfMenu.DebugPrint("totalClustersVisited:"..totalClustersVisited)--DEBUG
      if rewardOnClustersCount[totalClustersVisited] and visitRewards[totalClustersVisited]==false then
        visitRewards[totalClustersVisited]=true
        --InfMenu.DebugPrint("REWARD for ".. totalClustersVisited .." clusters visited")--DEBUG
        InfMenu.PrintLangId"mb_morale_visit_noticed"
      end

      lastSalute=Time.GetRawElapsedTimeSinceStartUp()
    end
  end)
end

--clusterId indexed from 0
--DEBUGNOW CULL
function this.CheckClusterMorale(clusterId)
--  InfInspect.TryFunc(function(clusterId)
--    if vars.missionCode==30050 and Ivars.mbMoraleBoosts:Is(1) then
--      InfMenu.DebugPrint("MotherBaseCurrentClusterActivated "..clusterId)--DEBUG
--      visitedClusterCounts[clusterId+1]=true
--      InfInspect.PrintInspect(visitedClusterCounts)--DEBUG
--    end
--  end,clusterId)
end

function this.CheckMoraleReward()
  if Ivars.mbMoraleBoosts:Is(1) then
    --tex was considering stacking, but even at the minimum 1 it's close to OP with a large staff size
    local moraleBoost=0
    if saluteRewards>0 then
      moraleBoost=1
    end
    for numClusters,reward in pairs(visitRewards) do
      if reward then
        moraleBoost=1
      end
    end
    --InfMenu.DebugPrint("Global moral boosted by "..moraleBoost.." by visit")--DEBUG
    if moraleBoost then
      InfMenu.PrintLangId"mb_morale_boosted"
      TppMotherBaseManagement.IncrementAllStaffMorale{morale=moraleBoost}
    end
  end
end

return this
