-- DOBUILD: 1
local this={}

this.DEBUGMODE=false
this.modVersion = "r95"
this.modName = "Infinite Heaven"

--LOCALOPT:
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local Enum=TppDefine.Enum

this.debugSplash=SplashScreen.Create("debugEagle","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",640,640)

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

--[[REF:

EnemyType.TYPE_SOVIET

EnemyType.TYPE_PF

EnemyType.TYPE_DD

EnemyType.TYPE_SKULL

EnemyType.TYPE_CHILD

--]]
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
function this.SoldierTypeNameForType(soldierType)--tex maybe I'm missing something but not having luck indexing by EnemyType
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

function this.IsMbWarGames(missionId)
  missionId=missionId or vars.missionCode
  return gvars.mbWarGames>0 and missionId==30050
end
function this.IsMbPlayTime(missionId)
  missionId=missionId or vars.missionCode
  if missionId==30050 then
    return gvars.mbPlayTime>0 or gvars.mbSoldierEquipGrade>0
  end
  return false
end
function this.IsForceSoldierSubType()
  return gvars.forceSoldierSubType>0 and TppMission.IsFreeMission(vars.missionCode)
end

function this.GetMbsClusterSecuritySoldierEquipGrade(missionId)--SYNC: mbSoldierEquipGrade
  local grade = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
  if this.IsMbPlayTime(missionId) and gvars.mbSoldierEquipGrade>Ivars.mbSoldierEquipGrade.enum.MBDEVEL then
    --TppUiCommand.AnnounceLogView("GetEquipGrade ismbplay, grade > devel")--DEBUG
    if gvars.mbSoldierEquipGrade==Ivars.mbSoldierEquipGrade.enum.RANDOM then
      grade = math.random(1,10)
    else
      grade = gvars.mbSoldierEquipGrade-Ivars.mbSoldierEquipGrade.enum.RANDOM
    end
  end
  --TppUiCommand.AnnounceLogView("GetEquipGrade: gvar:".. gvars.mbSoldierEquipGrade .." grade: ".. grade)--DEBUG
  --TppUiCommand.AnnounceLogView("Caller: ".. tostring(debug.getinfo(2).name) .." ".. tostring(debug.getinfo(2).source))--DEBUG
  return grade
end

function this.GetMbsClusterSecuritySoldierEquipRange(missionId)
  if InfMain.IsMbPlayTime(missionId) then
    if gvars.mbSoldierEquipRange==Ivars.mbSoldierEquipRange.enum.RANDOM then
      return math.random(0,2)--REF:{ "FOB_ShortRange", "FOB_MiddleRange", "FOB_LongRange", }, but range index from 0
    elseif gvars.mbSoldierEquipRange>0 then
      return gvars.mbSoldierEquipRange-1
    end
  end
  return TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipRange()
end

function this.GetMbsClusterSecurityIsNoKillMode(missionId)
  if this.IsMbPlayTime(missionId) then--tex PrepareDDParameter mbwargames, mbsoldierequipgrade
    return gvars.mbWarGames==Ivars.mbWarGames.enum.NONLETHAL
  end
  return TppMotherBaseManagement.GetMbsClusterSecurityIsNoKillMode()
end

function this.DisplayFox32(foxString)
  local str32 = Fox.StrCode32(foxString)
  TppUiCommand.AnnounceLogView("string :"..foxString .. "="..str32)
end

--[[

function this.soldierFovBodyTableAfghan(missionId)

  local bodyTable={

    {0,MAX_REALIZED_COUNT},

    {1,MAX_REALIZED_COUNT},

    {2,MAX_REALIZED_COUNT},

    {5,MAX_REALIZED_COUNT},

    {6,MAX_REALIZED_COUNT},

    {7,MAX_REALIZED_COUNT},

    {10,MAX_REALIZED_COUNT},

    {11,MAX_REALIZED_COUNT},

    {20,MAX_REALIZED_COUNT},

    {21,MAX_REALIZED_COUNT},

    {22,MAX_REALIZED_COUNT},

    {25,MAX_REALIZED_COUNT},

    {26,MAX_REALIZED_COUNT},

    {27,MAX_REALIZED_COUNT},

    {30,MAX_REALIZED_COUNT},

    {31,MAX_REALIZED_COUNT},

    {TppEnemyBodyId.prs2_main0_v00,MAX_REALIZED_COUNT}

  }

  if not this.IsNotRequiredArmorSoldier(missionId)then

    local e={TppEnemyBodyId.sva0_v00_a,MAX_REALIZED_COUNT}

    table.insert(bodyTable,e)

  end

  return bodyTable

end

function this.soldierFovBodyTableAfrica(missionId)

  local bodyTable={

    {50,MAX_REALIZED_COUNT},

    {51,MAX_REALIZED_COUNT},

    {55,MAX_REALIZED_COUNT},

    {60,MAX_REALIZED_COUNT},

    {61,MAX_REALIZED_COUNT},

    {70,MAX_REALIZED_COUNT},

    {71,MAX_REALIZED_COUNT},

    {75,MAX_REALIZED_COUNT},

    {80,MAX_REALIZED_COUNT},

    {81,MAX_REALIZED_COUNT},

    {90,MAX_REALIZED_COUNT},

    {91,MAX_REALIZED_COUNT},

    {95,MAX_REALIZED_COUNT},

    {100,MAX_REALIZED_COUNT},

    {101,MAX_REALIZED_COUNT},

    {TppEnemyBodyId.prs5_main0_v00,MAX_REALIZED_COUNT}

  }

  local armorTypeTable=this.GetArmorTypeTable(missionId)

  if armorTypeTable~=nil then

    local numArmorTypes=#armorTypeTable

    if numArmorTypes>0 then

      for t,armorType in ipairs(armorTypeTable)do

        if armorType==TppDefine.AFR_ARMOR.TYPE_ZRS then

          table.insert(bodyTable,{TppEnemyBodyId.pfa0_v00_a,MAX_REALIZED_COUNT})

        elseif armorType==TppDefine.AFR_ARMOR.TYPE_CFA then

          table.insert(bodyTable,{TppEnemyBodyId.pfa0_v00_b,MAX_REALIZED_COUNT})

        elseif armorType==TppDefine.AFR_ARMOR.TYPE_RC then

          table.insert(bodyTable,{TppEnemyBodyId.pfa0_v00_c,MAX_REALIZED_COUNT})

        else

          table.insert(bodyTable,{TppEnemyBodyId.pfa0_v00_a,MAX_REALIZED_COUNT})

        end

      end

    end

  end

end

--]]

function this.ResetCpTableToDefault()
  local subTypeOfCp=TppEnemy.subTypeOfCp
  local subTypeOfCpDefault=TppEnemy.subTypeOfCpDefault
  for cp, subType in pairs(subTypeOfCp)do
    subTypeOfCp[cp]=subTypeOfCpDefault[cp]
  end
end

--function this.GetGameId(gameId,type)
  --if IsString(gameId) then
    --gameId=GetGameObjectId(gameId) 
    --local soldierId=GetGameObjectId("TppSoldier2",soldierName)
      --if soldierId~=NULL_ID then
  --end
  --if gameId==nil or gameId==NULL_ID then
    --return nil
  --end
--end

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

this.SetFriendlyCp = function()
  local gameObjectId = { type="TppCommandPost2", index=0 }
  local command = { id = "SetFriendlyCp" }
  GameObject.SendCommand( gameObjectId, command )
end

this.SetFriendlyEnemy = function()
  local gameObjectId = { type="TppSoldier2" }
  local command = { id="SetFriendly", enabled=true }
  GameObject.SendCommand( gameObjectId, command )
end

--
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

--splash stuff
local oneOffSplashes={
  "startstart",
  "startend",
}
function this.AddOneOffSplash(splashName)
  oneOffSplashes[#oneOffSplashes+1]=splashName
end
function this.DeleteOneOffSplashes()
  for n,splashName in ipairs(oneOffSplashes) do
    this.DeleteSplash(splashName)
  end
end


function this.DeleteSplash(splashName)
  if splashName~=nil then
    local splash=SplashScreen.GetSplashScreenWithName(splashName)
    if splash~=nil then
      SplashScreen.Delete(splash)
    end
  end
end

local emblemTypes={
  {"base",{01,50}},
  {"front",{01,85}},
  {"front",{5001,5027}},
  --{"front",{7008,7063}},--tex bunch missing (see DOC), boring emblems anyhoo
  {"front",{
    100,
    110,
    120,
    200,
    210,
    220,
    300,
    400,
    410,
    500,
    510,
    600,
    610,
    700,
    720,
    730,
    800,
    810,
    900,
    1000,
    1100,
    1200,
    1210,
    1220,
    1300,
    1310,
    1410,
    1420,
    1430,
    1500,
    1700,
    1710,
    1800,
    1900,
    1920,
    1940,
    1960,
    2000,
    2010,
    2100,
    2200,
    2210,
    2240,
    2241,
  }},
}

this.currentRandomSplash=nil
--IN: emblemTypes
--OUT: this.oneOffSplashes, this.currentRandomSplash, SplashScreen - a splashscreen
--ASSUMPTION: heavy on emblemTypes data layout assumptions, so if you change it, this do break
function this.CreateRandomEmblemSplash()
  --[[if this.currentRandomSplash~=nil then

    if SplashScreen.GetSplashScreenWithName(this.currentRandomSplash) then

      return

    end

  end--]]

  local groupNumber=math.random(#emblemTypes)
  local group=emblemTypes[groupNumber]
  local emblemType=group[1]
  local emblemRanges=group[2]
  local emblemNumber
  if #emblemRanges>2 then--tex collection of numbers rather than range
    local randomIndex=math.random(#emblemRanges)
    emblemNumber=emblemRanges[randomIndex]
  else
    emblemNumber=math.random(emblemRanges[1],emblemRanges[2])
  end

  local lowOrHi="h"--tex low is full opaque, i guess for being in background thus 'low' display order, hi is more detailed stencil
  --[[if math.random()<0.5 then

    lowOrHi="l"

  else

    lowOrHi="h"

  end--]]

  local name=emblemType..emblemNumber

  local path="/Assets/tpp/ui/texture/Emblem/"..emblemType.."/ui_emb_"..emblemType.."_"..emblemNumber.."_"..lowOrHi.."_alp.ftex"
  local randomSplash=SplashScreen.Create(name,path,640,640)

  this.currentRandomSplash=name
  --this.AddOneOffSplash(name)

  --SplashScreen.Show(randomSplash,.2,0.5,.2)
  return randomSplash
end

function this.SplashStateCallback_r(screenId, state)
  if mvars.startHasTitileSeqeunce then
    return
  end

  if state == SplashScreen.STATE_DELETE then
    local newSplash=this.CreateRandomEmblemSplash()
    SplashScreen.SetStateCallback(newSplash, this.SplashStateCallback_r)
    SplashScreen.Show( newSplash, .5, 3, .5)--.5,3,.5)-- 1.0, 4.0, 1.0)
  end
end


--

function this.OnAllocateFob()
  InfMenu.ResetSettings()--tex TODO: would like a nosave reset, but would need to change to reading ivar.setting instead of gvars, then would need to VERFY that .setting is restored on gvar restore
  TppSoldier2.ReloadSoldier2ParameterTables(InfSoldierParams.soldierParameters)
end


this.prevDisableActionFlag=nil
function this.DisableActionFlagEquipMenu()
  if this.prevDisableActionFlag==nil then
    this.prevDisableActionFlag=vars.playerDisableActionFlag
    vars.playerDisableActionFlag=vars.playerDisableActionFlag+PlayerDisableAction.OPEN_EQUIP_MENU
  end
end
function this.RestoreActionFlag()
  if this.prevDisableActionFlag~=nil then
    vars.playerDisableActionFlag=this.prevDisableActionFlag
    this.prevDisableActionFlag=nil
  end
end

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
      {msg="Dead",func=this._OnDead},
      {msg="Damage",func=this._OnDamage},
      {msg="ChangePhase",func=this._OnPhaseChange},
    },
    Player={
      {msg="FinishOpeningDemoOnHeli",func=this.ClearMarkers()},
    },
    UI={
      {msg="EndFadeIn",sender="FadeInOnGameStart",func=function()--fires on: most mission starts, on-foot free and story missions, not mb on-foot, but does mb heli start
        --InfMenu.DebugPrint"FadeInOnGameStart"--DEBUGNOW
        this.FadeInOnGameStart()
      end},
      --this.FadeInOnGameStart},
      {msg="EndFadeIn",sender="FadeInOnStartMissionGame",func=function()--fires on: returning to heli from mission
        --  TppUiStatusManager.ClearStatus"AnnounceLog"
        --InfMenu.ModWelcome()
        --InfMenu.DebugPrint"FadeInOnStartMissionGame"--DEBUGNOW
        --this.FadeInOnGameStart()
        end},
      {msg="EndFadeIn",sender="OnEndGameStartFadeIn",func=function()--fires on: on-foot mother base, both initial and continue
        --InfMenu.DebugPrint"OnEndGameStartFadeIn"--DEBUGNOW
        this.FadeInOnGameStart()
      end},
    },
  }
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this._OnDead(gameId,killerId,playerPhase,deadMessageFlag)--tex cant quite nail down the args, since tpprevenge_ondead has a bug where it references a non existant attackId, most other listeners to the message only have 1 or two args declared/read,
  --InfMenu.DebugPrint("InfMain._OnDead")--DEBUGNOW:

  if GetTypeIndex(gameId)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end

  local killerIsPlayer=(killerId==GameObject.GetGameObjectIdByIndex("TppPlayer2",PlayerInfo.GetLocalPlayerIndex()))
end

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
function this._OnDamage(gameId,attackId,attackerId)
  --InfMenu.DebugPrint"_OnDamage"--DEBUGNOW
  if GetTypeIndex(gameId)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end
  if Tpp.IsPlayer(attackerId) then
    --InfMenu.DebugPrint"_OnDamage attacked by player"--DEBUGNOW
    if gvars.soldierAlertOnHeavyVehicleDamage>0 then
      if AttackIsVehicle(attackId) then
        --InfMenu.DebugPrint"_OnDamage AttackIsVehicle"--DEBUGNOW
        for cpId,soldierIds in pairs(mvars.ene_soldierIDList)do--tex TODO:find or build a better soldierid>cpid lookup 
          if TppEnemy.GetPhaseByCPID(cpId)<gvars.soldierAlertOnHeavyVehicleDamage then
            if soldierIds[gameId]~=nil then
              --InfMenu.DebugPrint"_OnDamage found soldier in idlist"--DEBUGNOW
              local command={id="SetPhase",phase=gvars.soldierAlertOnHeavyVehicleDamage}
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
function this._OnPhaseChange(gameObjectId,phase,oldPhase)
  if gvars.printPhaseChanges==1 then
    --tex TODO: cpId>cpName
    InfMenu.Print("cpId:"..gameObjectId.." Phase change from:"..PhaseName(oldPhase).." to:"..PhaseName(phase))--InfMenu.LangString("phase_changed"..":"..PhaseName(phase)))--ADDLANG
  end
end

function this.FadeInOnGameStart()
  this.ClearMarkers()
  
  --tex player life values for difficulty. Difficult to track down the best place for this, player.changelifemax hangs anywhere but pretty much in game and ready to move, Anything before the ui ending fade in in fact, why.
  --which i don't like, my shitty code should be run in the shadows, not while player is getting viewable frames lol, this is at least just before that
  --RETRY: push back up again, you may just have fucked something up lol
  local healthScale=gvars.playerHealthScale
  if healthScale~=1 then
    Player.ResetLifeMaxValue()
    local newMax=vars.playerLifeMax
    newMax=newMax*healthScale
    if newMax < 10 then
      newMax = 10
    end
    Player.ChangeLifeMaxValue(newMax)
  end
  
  --TppUiStatusManager.ClearStatus"AnnounceLog"
  --InfMenu.ModWelcome()
end

function this.ClearMarkers()
  if gvars.disableHeadMarkers==1 then
    TppUiStatusManager.SetStatus("HeadMarker","INVALID")
  end
  if gvars.disableXrayMarkers==1 then
    --TppSoldier2.DisableMarkerModelEffect()
    TppSoldier2.SetDisableMarkerModelEffect{enabled=true}
  end
end

--ivar update system

local updateIvars={
  Ivars.phaseUpdate,
  Ivars.warpPlayerUpdate,
  Ivars.heliUpdate,
}

function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  for i, ivar in ipairs(updateIvars) do
    if IsFunc(ivar.ExecInit) then
      ivar.ExecInit()
    end
  end
end
function this.OnReload(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
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

local playerVehicleId=0
this.currentTime=0

function this.Update()
  -- InfMenu.DebugPrint("InfMain.Update")
  --SplashScreen.Show(SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5020_l_alp.ftex",1280,640),0,0.3,0)--tex dog--tex ghetto as 'does it run?' indicator
  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end

  playerVehicleId=NULL_ID
  local currentChecks=this.execChecks
  --for k,v in ipairs(this.execChecks) do
  --this.execChecks[k]=false--tex TODO: can't figure out why this isn't actually setting REPRO: start misison, get into vehicle, get checkpoint, return to acc, still inGroundVehicle==true
  --end
  currentChecks.inHeliSpace=false
  currentChecks.inMission=false
  currentChecks.initialAction=false
  currentChecks.inGroundVehicle=false
  currentChecks.inSupportHeli=false
  currentChecks.onBuddy=false
  currentChecks.inMenu=false

  currentChecks.inGame=not mvars.mis_missionStateIsNotInGame

  if currentChecks.inGame then
    currentChecks.inHeliSpace=TppMission.IsHelicopterSpace(vars.missionCode)
    currentChecks.inMission=currentChecks.inGame and not currentChecks.inHeliSpace
    --SplashScreen.Show(this.debugSplash,0,0.3,0)--tex
    playerVehicleId=vars.playerVehicleGameObjectId

    if not currentChecks.inHeliSpace then
      currentChecks.initialAction=svars.ply_isUsedPlayerInitialAction--VERIFY that start on ground catches this (it's triggered on checkpoint save DOESNT catch motherbase ground start
      --[[   if not initialAction then

        InfMenu.DebugPrint"not initialAction"--DEBUGNOW

      end --]]

      currentChecks.inSupportHeli=Tpp.IsHelicopter(playerVehicleId)--tex VERIFY
      currentChecks.inGroundVehicle=Tpp.IsVehicle(playerVehicleId) and not currentChecks.inSupportHeli-- or Tpp.IsEnemyWalkerGear(playerVehicleId)?? VERIFY
      currentChecks.onBuddy=Tpp.IsHorse(playerVehicleId) or Tpp.IsPlayerWalkerGear(playerVehicleId)
    end
  end

  this.currentTime=Time.GetRawElapsedTimeSinceStartUp()
  --if currentChecks.inGame then
  --InfMenu.DebugPrint(tostring(this.currentTime))--DEBUGNOW
  --end

  InfButton.UpdateHeld()
  InfButton.UpdateRepeatReset()

  --InfMenu.DebugPrint("InfMain.Update")
  --SplashScreen.Show(SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5020_l_alp.ftex",1280,640),0,0.3,0)--tex dog--tex ghetto as 'does it run?' indicator

  ---Update shiz
  InfMenu.Update(currentChecks)
  currentChecks.inMenu=InfMenu.menuOn

  for i, ivar in ipairs(updateIvars) do
    if ivar.setting==1 then
      --tex ivar.updateRate is either number or another ivar
      local updateRate=ivar.updateRate or 0
      local updateRange=ivar.updateRange or 0
      if IsTable(updateRate) then
        updateRate=updateRate.setting
      end
      if IsTable(updateRange) then
        updateRange=updateRange.setting
      end
      --

      this.ExecUpdate(currentChecks,this.currentTime,ivar.execChecks,ivar.execState,updateRate,updateRange,ivar.ExecUpdate)
    end
  end
  ---
  InfButton.UpdatePressed()--tex GOTCHA: should be after all key reads, sets current keys to prev keys for onbutton checks
end

function this.ExecUpdate(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if execState.nextUpdate > currentTime then
    return
  end

  for check,ivarCheck in ipairs(execChecks) do
    if currentChecks[check]~=ivarCheck then
      return
    end
  end

  if not IsFunc(ExecUpdate) then
    InfMenu.DebugPrint"ExecUpdate is not a function"
    return
  end

  ExecUpdate(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)

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
  -- InfMenu.DebugPrint("currentTime: "..tostring(currentTime).." updateRate:"..tostring(updateRate) .." nextUpdate:"..tostring(execState.nextUpdate))--DEBUGNOW
  --end
end

--Phase/Alert updates
--state
local PHASE_ALERT=TppGameObject.PHASE_ALERT

function this.UpdatePhase(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  --if currentChecks.inGame then
  --InfMenu.DebugPrint("currentTime: "..currentTime.." updateRate:"..updateRate)--DEBUGNOW
  --  return
  -- end

  --Phase/Alert updates DOC: Phases-Alerts.txt
  --TODO RETRY, see if you can get when player comes into cp range better, playerPhase doesnt change till then
  --RESEARCH music also starts up
  --then can shift to game msg="ChangePhase" subscription
  if TppLocation.IsMotherBase() or TppLocation.IsMBQF() then
    return
  end

  local currentPhase=vars.playerPhase
  local minPhase=gvars.minPhase
  local maxPhase=gvars.maxPhase

--CULL  if currentPhase~=execState.lastPhase then
--    if gvars.printPhaseChanges==1 then
--      InfMenu.Print(InfMenu.LangString("phase_changed"..":"..PhaseName(currentPhase)))
--    end
--  end

  --InfMenu.DebugPrint("InfMain.Update phase mod")

  --local debugMessage=nil--DEBUG
  for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
    if currentPhase<minPhase then
      --debugMessage="phase<min setting to "..PhaseName(gvars.minPhase)
      this.ChangePhase(cpName,minPhase)--gvars.minPhase)
    end
    if currentPhase>maxPhase then
      --debugMessage="phase>max setting to "..PhaseName(gvars.maxPhase)
      InfMain.ChangePhase(cpName,maxPhase)
    end

    if gvars.keepPhase==1 then
      InfMain.SetKeepAlert(cpName,true)
    else
    --InfMain.SetKeepAlert(cpName,false)--tex this would trash any vanilla setting, but updating this to off would only be important if ivar was updated at mission time
    end

    --tex keep forcing ALERT so that last know pos updates, otherwise it would take till the alert>evasion cooldown
    --doesnt really work well, > alert is set last know pos, take cover and suppress last know pos
    --evasion is - is no last pos, downgrade to caution, else group advance on last know pos
    --ideally would be able to set last know pos independant of phase
    --if minPhase==PHASE_ALERT then
      --debugMessage="phase<min setting to "..PhaseName(gvars.minPhase)
      --if currentPhase==PHASE_ALERT and execState.lastPhase==PHASE_ALERT then
        --this.ChangePhase(cpName,minPhase-1)--gvars.minPhase)
      --end
    --end
    if minPhase==TppGameObject.PHASE_EVASION then
      if execState.alertBump then
        execState.alertBump=false
        InfMain.ChangePhase(cpName,TppGameObject.PHASE_EVASION)
      end
    end
    if currentPhase<minPhase then
      if minPhase==TppGameObject.PHASE_EVASION then
        InfMain.ChangePhase(cpName,PHASE_ALERT)
        execState.alertBump=true
      end
    end
  end

  --if debugMessage then--DEBUG--tex not a good idea to keep on cause playerphase only updates in certain radius of a cp
    --InfMenu.DebugPrint(debugMessage)
    --end--]]  

  --  if currentChecks.inGame then---
  -- InfMenu.DebugPrint("currentTime: "..tostring(currentTime).." updateRate:"..tostring(updateRate))--DEBUGNOW
  -- end---

  execState.lastPhase=currentPhase
end

--warp mode
--config
this.moveRightButton=InfButton.RIGHT
this.moveLeftButton=InfButton.LEFT
this.moveForwardButton=InfButton.UP
this.moveBackButton=InfButton.DOWN
this.moveUpButton=InfButton.STANCE
this.moveDownButton=InfButton.CALL

this.warpModeButtons={
  this.moveRightButton,
  this.moveLeftButton,
  this.moveForwardButton,
  this.moveBackButton,
  this.moveUpButton,
  this.moveDownButton,
}

--init
function this.InitWarpPlayerUpdate()
  InfButton.buttonStates[this.moveRightButton].decrement=0.1
  InfButton.buttonStates[this.moveLeftButton].decrement=0.1
  InfButton.buttonStates[this.moveForwardButton].decrement=0.1
  InfButton.buttonStates[this.moveBackButton].decrement=0.1
  InfButton.buttonStates[this.moveUpButton].decrement=0.1
  InfButton.buttonStates[this.moveDownButton].decrement=0.1
end

function this.UpdateWarpPlayer(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if currentChecks.inMenu then
    return
  end

  if not currentChecks.inGame or currentChecks.inHeliSpace then
    if Ivars.warpPlayerUpdate.setting==1 then
      Ivars.warpPlayerUpdate:Set(0)
    end
    return
  end

  if Ivars.warpPlayerUpdate.setting==0 then
    return
  end

  --TODO: refactor, in InfMenu.Update too
  local repeatRate=0.06
  local repeatRateUp=0.04
  InfButton.buttonStates[this.moveRightButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveLeftButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveForwardButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveBackButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveUpButton].repeatRate=repeatRateUp
  InfButton.buttonStates[this.moveDownButton].repeatRate=repeatRate

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

  if gvars.disableHeliAttack==1 then--tex disable heli be fightan
    SendCommand(heliId,{id="SetCombatEnabled",enabled=false})
  end
  if gvars.setInvincibleHeli==1 then
    SendCommand(heliId,{id="SetInvincible",enabled=true})
  end
  if not Ivars.setTakeOffWaitTime:IsDefault() then
    SendCommand(heliId,{id="SetTakeOffWaitTime",time=gvars.setTakeOffWaitTime})
  end
  if gvars.disablePullOutHeli==1 then
    --if not TppLocation.IsMotherBase() and not TppLocation.IsMBQF() then--tex aparently disablepullout overrides the mother base taxi service
    SendCommand(heliId,{id="DisablePullOut"})
    --end
  end
  if not Ivars.setLandingZoneWaitHeightTop:IsDefault() then
    SendCommand(heliId,{id="SetLandingZoneWaitHeightTop",height=gvars.setLandingZoneWaitHeightTop})
  end
  if gvars.disableDescentToLandingZone==1 then
    SendCommand(heliId,{id="DisableDescentToLandingZone"})
  end
  if gvars.setSearchLightForcedHeli==1 then
    SendCommand(heliId,{id="SetSearchLightForcedType",type="Off"})
  end
end

function this.UpdateHeli(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  local heliId=GetGameObjectId("TppHeli2","SupportHeli")
  if heliId==nil or heliId==NULL_ID then
    return
  end

  --if gvars.enableGetOutHeli==1 then
  -- SendCommand(heliId, { id="SetGettingOutEnabled", enabled=true })
  --end

  if not currentChecks.inMenu and currentChecks.inSupportHeli then
    if gvars.disablePullOutHeli==1 then--or not currentChecks.initialAction then
      if InfButton.OnButtonDown(InfButton.STANCE) then
        if not currentChecks.initialAction then--tex heli ride in
          SendCommand(heliId,{id="RequestSnedDoorOpen"})
        else

          Ivars.disablePullOutHeli:Set(0,true,true)--tex seems this overrules all, but we can tell it to not save so that's ok
          InfMenu.PrintLangId"heli_pulling_out"
          --CULL SendCommand(heliId,{id="PullOut",forced=true})--tex even with forced wont go with player
        end
    end--button down
    end--nopullout or initialact
  end--not menu, insupportheli
end

function this.HeliOrderRecieved()
  if this.execChecks.inGame and not this.execChecks.inHeliSpace then
    InfMenu.PrintLangId"order_recieved"
  end
end

return this
