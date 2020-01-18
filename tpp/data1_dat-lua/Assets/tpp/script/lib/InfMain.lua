-- DOBUILD: 1 --
local this={}

this.DEBUGMODE=false
this.modVersion = "r80"
this.modName = "Infinite Heaven"

--LOCALOPT:
local IsFunc=Tpp.IsTypeFunc
local IsString=Tpp.IsTypeString
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local SendCommand=GameObject.SendCommand
local Enum=TppDefine.Enum

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

function this.ResetCpTableToDefault()
 local subTypeOfCp=TppEnemy.subTypeOfCp
  local subTypeOfCpDefault=TppEnemy.subTypeOfCpDefault
  for cp, subType in pairs(subTypeOfCp)do
    subTypeOfCp[cp]=subTypeOfCpDefault[cp]
  end
end

--[[function this.GetGameId(gameId,type)
  if IsString(gameId) then
    gameId=GetGameObjectId(gameId)
    
    local soldierId=GetGameObjectId("TppSoldier2",soldierName)
      if soldierId~=NULL_ID then
    
  end
  if gameId==nil or gameId==NULL_ID then
    return nil
  end
end--]]

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

----DEBUGNOW WIP

--[[
local dominationTargetCpList={
  afgh={
    "afgh_field_cp",
    "afgh_remnants_cp",
    "afgh_tent_cp",
    "afgh_fieldEast_ob",
    "afgh_fieldWest_ob",
    "afgh_remnantsNorth_ob",
    "afgh_tentEast_ob",
    "afgh_tentNorth_ob",
    "afgh_village_cp",
    "afgh_slopedTown_cp",
    "afgh_commFacility_cp",
    "afgh_enemyBase_cp",
    "afgh_commWest_ob",
    "afgh_ruinsNorth_ob",
    "afgh_slopedWest_ob",
    "afgh_villageEast_ob",
    "afgh_villageNorth_ob",
    "afgh_villageWest_ob",
    "afgh_enemyEast_ob",
    "afgh_bridge_cp",
    "afgh_fort_cp",
    "afgh_cliffTown_cp",
    "afgh_bridgeNorth_ob",
    "afgh_bridgeWest_ob",
    "afgh_cliffEast_ob",
    "afgh_cliffSouth_ob",
    "afgh_cliffWest_ob",
    "afgh_enemyNorth_ob",
    "afgh_fortSouth_ob",
    "afgh_fortWest_ob",
    "afgh_slopedEast_ob",
    "afgh_powerPlant_cp",
    "afgh_sovietBase_cp",
    "afgh_plantWest_ob",
    "afgh_sovietSouth_ob",
    "afgh_waterwayEast_ob",
    "afgh_citadel_cp",
    "afgh_citadelSouth_ob"
  },
  mafr={
    "mafr_outland_cp",
    "mafr_outlandEast_ob",
    "mafr_outlandNorth_ob",
    "mafr_flowStation_cp",
    "mafr_swamp_cp",
    "mafr_pfCamp_cp",
    "mafr_savannah_cp",
    "mafr_swampEast_ob",
    "mafr_swampWest_ob",
    "mafr_swampSouth_ob",
    "mafr_pfCampEast_ob",
    "mafr_pfCampNorth_ob",
    "mafr_savannahEast_ob",
    "mafr_savannahWest_ob",
    "mafr_chicoVilWest_ob",
    "mafr_hillSouth_ob",
    "mafr_banana_cp",
    "mafr_diamond_cp",
    "mafr_hill_cp",
    "mafr_savannahNorth_ob",
    "mafr_bananaEast_ob",
    "mafr_bananaSouth_ob",
    "mafr_hillNorth_ob",
    "mafr_hillWest_ob",
    "mafr_hillWestNear_ob",
    "mafr_factorySouth_ob",
    "mafr_diamondNorth_ob",
    "mafr_diamondSouth_ob",
    "mafr_diamondWest_ob",
    "mafr_factoryWest_ob",
    "mafr_lab_cp",
    "mafr_labWest_ob"
  }
}
--]]
--WIP Phase/Alert updates
this.nextPhaseUpdate=0
this.lastPhase=0
this.alertBump=false
local PHASE_ALERT=TppGameObject.PHASE_ALERT
--
local function PhaseName(index)
  return Ivars.phaseSettings[index+1]
end

function this.Update()
   -- InfMenu.DebugPrint("InfMain.Update")
   -- SplashScreen.Show(SplashScreen.Create("debugSplash","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5020_l_alp.ftex",1280,640),0,0.3,0)--tex dog--tex ghetto as 'does it run?' indicator
    
  local currentTime=Time.GetRawElapsedTimeSinceStartUp()
  
  --WIP Phase/Alert updates DOC: Phases-Alerts.txt
  --TODO RETRY, see if you can get when player comes into cp range better, playerPhase doesnt change till then
  --RESEARCH music also starts up
  --then can shift to game msg="ChangePhase" subscription
  local currentPhase=vars.playerPhase
  local minPhase=gvars.minPhase
  local maxPhase=gvars.maxPhase
  

  if currentPhase~=this.lastPhase then
    if gvars.printPhaseChanges==1 then
      InfMenu.Print(InfMenu.LangString("phase_changed"..":"..PhaseName(currentPhase)))
    end
  end
  
  if gvars.enablePhaseMod==1 and this.nextPhaseUpdate < currentTime then
    --InfMenu.DebugPrint("InfMain.Update phase mod")
    --local minPhase=gvars.minPhase
    --local maxPhase=gvars.maxPhase
    
    local debugMessage=nil--DEBUGNOW
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
      --[[if minPhase==PHASE_ALERT then
 
        --debugMessage="phase<min setting to "..PhaseName(gvars.minPhase)
        if currentPhase==PHASE_ALERT and this.lastPhase==PHASE_ALERT then
          this.ChangePhase(cpName,minPhase-1)--gvars.minPhase) 
        end
      end--]]
      if minPhase==TppGameObject.PHASE_EVASION then
        if this.alertBump then
          this.alertBump=false
          InfMain.ChangePhase(cpName,TppGameObject.PHASE_EVASION)
        end
      end
      if currentPhase<minPhase then
        if minPhase==TppGameObject.PHASE_EVASION then
          InfMain.ChangePhase(cpName,PHASE_ALERT)
          this.alertBump=true
        end
      end

    end
    
   --[[ if debugMessage then--DEBUGNOW--tex not a good idea to keep on cause playerphase only updates in certain radius of a cp
    InfMenu.DebugPrint(debugMessage)
    end--]]
  end
  if gvars.enablePhaseMod==1 and this.nextPhaseUpdate < currentTime then    
    local phaseUpdateRate=gvars.phaseUpdateRate
    
    if phaseUpdateRate == 0 then
      this.nextPhaseUpdate = currentTime--GOTCHA: wont reflect changes to rate and range till next update
    else
      local phaseUpdateRange=gvars.phaseUpdateRange
      local phaseUpdateRangeHalf=phaseUpdateRange*0.5
      local phaseUpdateMin=phaseUpdateRate-phaseUpdateRangeHalf
      local phaseUpdateMax=phaseUpdateRate+phaseUpdateRangeHalf
      if phaseUpdateMin<0 then
       phaseUpdateMin=0
      end
      
      local randomRange=math.random(phaseUpdateMin,phaseUpdateMax)
      this.nextPhaseUpdate = currentTime + randomRange--GOTCHA: wont reflect changes to rate and range till next update
    end 
  end 
  this.lastPhase=currentPhase
end

return this