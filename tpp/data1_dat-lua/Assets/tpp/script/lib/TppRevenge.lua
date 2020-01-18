-- DOBUILD: 1
local this={}
local _=GameObject.GetGameObjectId
local a=GameObject.GetTypeIndex
local n=GameObject.SendCommand
local o=GameObject.NULL_ID
function this._Random(n,E)
  local t=gvars.rev_revengeRandomValue
  if n>E then
    local e=n
    n=E
    E=e
  end
  local E=(E-n)+1
  return(t%E)+n
end
this.NO_REVENGE_MISSION_LIST={[10010]=true,[10030]=true,[10050]=true,[11050]=true,[10120]=true,[10140]=true,[11140]=true,[10151]=true,[10230]=true,[10240]=true,[10280]=true,[30050]=true,[40010]=true,[40020]=true,[40050]=true,[50050]=true}
this.NO_STEALTH_COMBAT_REVENGE_MISSION_LIST={[30010]=true,[30020]=true,[30050]=true,[30150]=true}
this.USE_SUPER_REINFORCE_VEHICLE_MISSION={[10036]=true,[11036]=true,[10093]=true}
this.CANNOT_USE_ALL_WEAPON_MISSION={[10030]=true,[10070]=true,[10080]=true,[11080]=true,[10090]=true,[11090]=true,[10151]=true,[11151]=true,[10211]=true,[11211]=true,[30050]=true}
this.REVENGE_TYPE_NAME={"STEALTH","NIGHT_S","COMBAT","NIGHT_C","LONG_RANGE","VEHICLE","HEAD_SHOT","TRANQ","FULTON","SMOKE","M_STEALTH","M_COMBAT","DUMMY","DUMMY2","DUMMY3","DUMMY4","MAX"}
this.REVENGE_TYPE=TppDefine.Enum(this.REVENGE_TYPE_NAME)
this.REVENGE_LV_LIMIT_RANK_MAX=6
this.REVENGE_LV_MAX={[this.REVENGE_TYPE.STEALTH]={0,1,2,3,4,5},[this.REVENGE_TYPE.NIGHT_S]={0,1,1,2,3,3},[this.REVENGE_TYPE.COMBAT]={0,1,2,3,4,5},[this.REVENGE_TYPE.NIGHT_C]={0,1,1,1,1,1},[this.REVENGE_TYPE.LONG_RANGE]={0,1,1,2,2,2},[this.REVENGE_TYPE.VEHICLE]={0,1,1,2,3,3},[this.REVENGE_TYPE.HEAD_SHOT]={0,1,2,3,5,7},[this.REVENGE_TYPE.TRANQ]={0,1,1,1,1,1},[this.REVENGE_TYPE.FULTON]={0,1,2,2,3,3},[this.REVENGE_TYPE.SMOKE]={0,1,1,2,3,3},[this.REVENGE_TYPE.M_STEALTH]={9,9,9,9,9,9},[this.REVENGE_TYPE.M_COMBAT]={9,9,9,9,9,9}}
this.REVENGE_POINT_OVER_MARGINE=100-1
this.REVENGE_POINT_PER_LV=100
this.REDUCE_REVENGE_POINT=10
this.REDUCE_TENDENCY_POINT_TABLE={[this.REVENGE_TYPE.STEALTH]={-20,-20,-20,-20,-25,-50},[this.REVENGE_TYPE.COMBAT]={-20,-20,-20,-20,-25,-50}}
this.REDUCE_POINT_TABLE={[this.REVENGE_TYPE.NIGHT_S]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50},[this.REVENGE_TYPE.NIGHT_C]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50},[this.REVENGE_TYPE.SMOKE]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50},[this.REVENGE_TYPE.LONG_RANGE]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50},[this.REVENGE_TYPE.VEHICLE]={-10,-50,-50,-50,-50,-50,-50,-50,-50,-50,-50}}
this.REVENGE_TRIGGER_TYPE={HEAD_SHOT=1,ELIMINATED_IN_STEALTH=2,ELIMINATED_IN_COMBAT=3,FULTON=4,SMOKE=5,KILLED_BY_HELI=6,ANNIHILATED_IN_STEALTH=7,ANNIHILATED_IN_COMBAT=8,WAKE_A_COMRADE=9,DISCOVERY_AT_NIGHT=10,ELIMINATED_AT_NIGHT=11,SNIPED=12,KILLED_BY_VEHICLE=13,WATCH_SMOKE=14}
this.BLOCKED_TYPE={GAS_MASK=0,HELMET=1,CAMERA=2,DECOY=3,MINE=4,NVG=5,SHOTGUN=6,MG=7,SOFT_ARMOR=8,SHIELD=9,ARMOR=10,GUN_LIGHT=11,SNIPER=12,MISSILE=13,MAX=14}
this.BLOCKED_FOR_MISSION_COUNT=3
this.DEPLOY_REVENGE_MISSION_BLOCKED_LIST={[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_SMOKE]=this.BLOCKED_TYPE.GAS_MASK,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_HEAD_SHOT]=this.BLOCKED_TYPE.HELMET,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH1]=this.BLOCKED_TYPE.CAMERA,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH2]=this.BLOCKED_TYPE.DECOY,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH3]=this.BLOCKED_TYPE.MINE,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_NIGHT_STEALTH]=this.BLOCKED_TYPE.NVG,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT1]=this.BLOCKED_TYPE.SHOTGUN,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT2]=this.BLOCKED_TYPE.MG,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT3]=this.BLOCKED_TYPE.SOFT_ARMOR,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT4]=this.BLOCKED_TYPE.SHIELD,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT5]=this.BLOCKED_TYPE.ARMOR,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_NIGHT_COMBAT]=this.BLOCKED_TYPE.GUN_LIGHT,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_LONG_RANGE]=this.BLOCKED_TYPE.SNIPER,[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_VEHICLE]=this.BLOCKED_TYPE.MISSILE}
this.DEPLOY_REVENGE_MISSION_CONDITION_LIST={[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_SMOKE]={revengeType=this.REVENGE_TYPE.SMOKE,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_HEAD_SHOT]={revengeType=this.REVENGE_TYPE.HEAD_SHOT,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH1]={revengeType=this.REVENGE_TYPE.STEALTH,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH2]={revengeType=this.REVENGE_TYPE.STEALTH,lv=2},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_STEALTH3]={revengeType=this.REVENGE_TYPE.STEALTH,lv=3},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_NIGHT_STEALTH]={revengeType=this.REVENGE_TYPE.NIGHT_S,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT1]={revengeType=this.REVENGE_TYPE.COMBAT,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT2]={revengeType=this.REVENGE_TYPE.COMBAT,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT3]={revengeType=this.REVENGE_TYPE.COMBAT,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT4]={revengeType=this.REVENGE_TYPE.COMBAT,lv=2},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_COMBAT5]={revengeType=this.REVENGE_TYPE.COMBAT,lv=3},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_NIGHT_COMBAT]={revengeType=this.REVENGE_TYPE.NIGHT_C,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_LONG_RANGE]={revengeType=this.REVENGE_TYPE.LONG_RANGE,lv=1},[TppMotherBaseManagementConst.DEPLOY_MISSION_ID_REVENGE_VEHICLE]={revengeType=this.REVENGE_TYPE.VEHICLE,lv=1}}
this.REVENGE_POINT_TABLE={[this.REVENGE_TRIGGER_TYPE.HEAD_SHOT]={[this.REVENGE_TYPE.HEAD_SHOT]=5},[this.REVENGE_TRIGGER_TYPE.ELIMINATED_IN_STEALTH]={[this.REVENGE_TYPE.M_STEALTH]=5},[this.REVENGE_TRIGGER_TYPE.ELIMINATED_IN_COMBAT]={[this.REVENGE_TYPE.M_COMBAT]=5},[this.REVENGE_TRIGGER_TYPE.FULTON]={[this.REVENGE_TYPE.FULTON]=15},[this.REVENGE_TRIGGER_TYPE.SMOKE]={[this.REVENGE_TYPE.SMOKE]=15},[this.REVENGE_TRIGGER_TYPE.WATCH_SMOKE]={[this.REVENGE_TYPE.SMOKE]=15},[this.REVENGE_TRIGGER_TYPE.KILLED_BY_HELI]={[this.REVENGE_TYPE.VEHICLE]=10},[this.REVENGE_TRIGGER_TYPE.ANNIHILATED_IN_STEALTH]={[this.REVENGE_TYPE.M_STEALTH]=15},[this.REVENGE_TRIGGER_TYPE.ANNIHILATED_IN_COMBAT]={[this.REVENGE_TYPE.M_COMBAT]=15},[this.REVENGE_TRIGGER_TYPE.WAKE_A_COMRADE]={[this.REVENGE_TYPE.TRANQ]=5},[this.REVENGE_TRIGGER_TYPE.DISCOVERY_AT_NIGHT]={[this.REVENGE_TYPE.NIGHT_S]=15},[this.REVENGE_TRIGGER_TYPE.ELIMINATED_AT_NIGHT]={[this.REVENGE_TYPE.NIGHT_C]=10},[this.REVENGE_TRIGGER_TYPE.SNIPED]={[this.REVENGE_TYPE.LONG_RANGE]=30},[this.REVENGE_TRIGGER_TYPE.KILLED_BY_VEHICLE]={[this.REVENGE_TYPE.VEHICLE]=10}}
this.MISSION_TENDENCY_POINT_TABLE={STEALTH={STEALTH={25,25,25,25,50,50},COMBAT={0,0,-5,-10,-50,-50}},DRAW={STEALTH={20,20,20,0,-25,-10},COMBAT={20,20,20,0,-25,-10}},COMBAT={STEALTH={0,0,-5,-10,-50,-50},COMBAT={25,25,25,25,50,50}}}
this.revengeDefine={HARD_MISSION={IGNORE_BLOCKED=true},_ENABLE_CAMERA_LV=1,_ENABLE_DECOY_LV=2,_ENABLE_MINE_LV=3,STEALTH_0={STEALTH_LOW=true,HOLDUP_LOW=true},STEALTH_1={CAMERA="100%",HOLDUP_LOW=true},STEALTH_2={DECOY="100%",CAMERA="100%"},STEALTH_3={DECOY="100%",MINE="100%",CAMERA="100%",STEALTH_HIGH=true},STEALTH_4={DECOY="100%",MINE="100%",CAMERA="100%",STEALTH_HIGH=true,HOLDUP_HIGH=true,ACTIVE_DECOY=true,GUN_CAMERA=true},STEALTH_5={DECOY="100%",MINE="100%",CAMERA="100%",STEALTH_SPECIAL=true,HOLDUP_HIGH=true,ACTIVE_DECOY=true,GUN_CAMERA=true},NIGHT_S_1={NVG="25%"},NIGHT_S_2={NVG="50%"},NIGHT_S_3={NVG="75%"},_ENABLE_SOFT_ARMOR_LV=1,_ENABLE_SHOTGUN_LV=1,_ENABLE_MG_LV=1,_ENABLE_SHIELD_LV=2,_ENABLE_ARMOR_LV=3,COMBAT_0={COMBAT_LOW=true},COMBAT_1={{SOFT_ARMOR="25%",SHOTGUN=2},{SOFT_ARMOR="25%",MG=2}},COMBAT_2={{SOFT_ARMOR="50%",SHOTGUN=2,SHIELD=1},{SOFT_ARMOR="50%",MG=2,SHIELD=1}},COMBAT_3={{SOFT_ARMOR="75%",SHOTGUN=2,SHIELD=1,ARMOR=1,STRONG_WEAPON=true,COMBAT_HIGH=true,SUPER_REINFORCE=true},{SOFT_ARMOR="75%",MG=2,SHIELD=1,ARMOR=1,STRONG_WEAPON=true,COMBAT_HIGH=true,SUPER_REINFORCE=true}},COMBAT_4={{SOFT_ARMOR="100%",SHOTGUN=4,SHIELD=2,ARMOR=2,STRONG_WEAPON=true,COMBAT_HIGH=true,SUPER_REINFORCE=true,REINFORCE_COUNT=2},{SOFT_ARMOR="100%",MG=4,SHIELD=2,ARMOR=2,STRONG_WEAPON=true,COMBAT_HIGH=true,SUPER_REINFORCE=true,REINFORCE_COUNT=2}},COMBAT_5={{SOFT_ARMOR="100%",SHOTGUN=4,SHIELD=4,ARMOR=4,STRONG_WEAPON=true,COMBAT_SPECIAL=true,SUPER_REINFORCE=true,BLACK_SUPER_REINFORCE=true,REINFORCE_COUNT=3},{SOFT_ARMOR="100%",MG=4,SHIELD=4,ARMOR=4,STRONG_WEAPON=true,COMBAT_SPECIAL=true,SUPER_REINFORCE=true,BLACK_SUPER_REINFORCE=true,REINFORCE_COUNT=3}},NIGHT_C_1={GUN_LIGHT="75%"},LONG_RANGE_1={SNIPER=2},LONG_RANGE_2={SNIPER=2,STRONG_SNIPER=true},VEHICLE_1={MISSILE=2},VEHICLE_2={MISSILE=2,STRONG_MISSILE=true},VEHICLE_3={MISSILE=4,STRONG_MISSILE=true},HEAD_SHOT_1={HELMET="10%"},HEAD_SHOT_2={HELMET="20%"},HEAD_SHOT_3={HELMET="30%"},HEAD_SHOT_4={HELMET="40%"},HEAD_SHOT_5={HELMET="50%"},HEAD_SHOT_6={HELMET="60%"},HEAD_SHOT_7={HELMET="70%"},HEAD_SHOT_8={HELMET="80%"},HEAD_SHOT_9={HELMET="90%"},HEAD_SHOT_10={HELMET="100%"},TRANQ_1={STRONG_NOTICE_TRANQ=true},FULTON_0={},FULTON_1={FULTON_LOW=true},FULTON_2={FULTON_HIGH=true},FULTON_3={FULTON_SPECIAL=true}--[[--tex RETAILBUG: VERIFY: possible bug fixed, fulton was 0 low 1 blank 2 high, now 0 blank 1 low 2 high--]],SMOKE_1={GAS_MASK="25%"},SMOKE_2={GAS_MASK="50%"},SMOKE_3={GAS_MASK="75%"},FOB_NoKill={NO_KILL_WEAPON=true},FOB_EquipGrade_1={EQUIP_GRADE_LIMIT=1},FOB_EquipGrade_2={EQUIP_GRADE_LIMIT=2},FOB_EquipGrade_3={EQUIP_GRADE_LIMIT=3},FOB_EquipGrade_4={EQUIP_GRADE_LIMIT=4},FOB_EquipGrade_5={EQUIP_GRADE_LIMIT=5},FOB_EquipGrade_6={EQUIP_GRADE_LIMIT=6},FOB_EquipGrade_7={EQUIP_GRADE_LIMIT=7},FOB_EquipGrade_8={EQUIP_GRADE_LIMIT=8},FOB_EquipGrade_9={EQUIP_GRADE_LIMIT=9},FOB_EquipGrade_10={EQUIP_GRADE_LIMIT=10},FOB_ShortRange={SHOTGUN="30%",SHIELD="60%",SMG="100%"},FOB_MiddleRange={MG="40%",MISSILE="15%"},FOB_LongRange={SNIPER="50%"},FOB_ShortRange_1={},FOB_ShortRange_2={SHOTGUN="10%"},FOB_ShortRange_3={SHOTGUN="10%"},FOB_ShortRange_4={SMG="10%",SHOTGUN="10%",SHIELD="10%"},FOB_ShortRange_5={SMG="10%",SHOTGUN="10%",SHIELD="10%"},FOB_ShortRange_6={SMG="20%",SHOTGUN="10%",SHIELD="20%"},FOB_ShortRange_7={SMG="20%",SHOTGUN="20%",SHIELD="20%"},FOB_ShortRange_8={STRONG_WEAPON=true,SMG="20%",SHOTGUN="20%",SHIELD="20%"},FOB_ShortRange_9={STRONG_WEAPON=true,SMG="20%",SHOTGUN="25%",SHIELD="20%"},FOB_ShortRange_10={STRONG_WEAPON=true,SMG="30%",SHOTGUN="30%",SHIELD="30%"},FOB_MiddleRange_1={},FOB_MiddleRange_2={MG="10%"},FOB_MiddleRange_3={MG="10%"},FOB_MiddleRange_4={MG="20%"},FOB_MiddleRange_5={MG="20%"},FOB_MiddleRange_6={STRONG_WEAPON=true,MG="20%"},FOB_MiddleRange_7={STRONG_WEAPON=true,MG="30%"},FOB_MiddleRange_8={STRONG_WEAPON=true,MG="30%",SHOTGUN="10%"},FOB_MiddleRange_9={STRONG_WEAPON=true,MG="30%",SHOTGUN="10%",MISSILE="10%"},FOB_MiddleRange_10={STRONG_WEAPON=true,MG="40%",SHOTGUN="10%",SNIPER="10%",MISSILE="10%"},FOB_LongRange_1={},FOB_LongRange_2={SNIPER="10%"},FOB_LongRange_3={SNIPER="10%"},FOB_LongRange_4={SNIPER="15%"},FOB_LongRange_5={STRONG_SNIPER=true,SNIPER="15%"},FOB_LongRange_6={STRONG_SNIPER=true,SNIPER="20%",MISSILE="10%"},FOB_LongRange_7={STRONG_SNIPER=true,SNIPER="20%",MISSILE="10%"},FOB_LongRange_8={STRONG_WEAPON=true,STRONG_SNIPER=true,STRONG_MISSILE=true,SNIPER="20%",MISSILE="10%"},FOB_LongRange_9={STRONG_WEAPON=true,STRONG_SNIPER=true,STRONG_MISSILE=true,SNIPER="25%",MISSILE="10%"},FOB_LongRange_10={STRONG_WEAPON=true,STRONG_SNIPER=true,STRONG_MISSILE=true,SNIPER="30%",MISSILE="20%",MG="10%"}}
function this.SelectRevengeType()
  local n=TppMission.GetMissionID()
  if this.IsNoRevengeMission(n)or n==10115 then
    return{}
  end
  local r=TppMission.IsHardMission(n)
  local t={}
  for E=0,this.REVENGE_TYPE.MAX-1 do
    local n=this.GetRevengeLv(E)--tex moved if ishard getlv max else getlv into getlv itself
    if n>=0 then
      local n=this.REVENGE_TYPE_NAME[E+1]..("_"..tostring(n))
      local e=this.revengeDefine[n]
      if e then
        table.insert(t,n)
      end
    end
  end
  if r then
    table.insert(t,"HARD_MISSION")
  end
  return t
end
--[[ORIG: function e.SelectRevengeType()
  local n=TppMission.GetMissionID()
  if e.IsNoRevengeMission(n)or n==10115 then
    return{}
  end
  local r=TppMission.IsHardMission(n)
  local t={}
  for E=0,e.REVENGE_TYPE.MAX-1 do
    local n
    if r then
      n=e.GetRevengeLvMax(E,REVENGE_LV_LIMIT_RANK_MAX)
    else
      n=e.GetRevengeLv(E)
    end
    if n>=0 then
      local n=e.REVENGE_TYPE_NAME[E+1]..("_"..tostring(n))
      local e=e.revengeDefine[n]
      if e then
        table.insert(t,n)
      end
    end
  end
  if r then
    table.insert(t,"HARD_MISSION")
  end
  return t
end--]]
function this.SetForceRevengeType(e)
  if not Tpp.IsTypeTable(e)then
    e={e}
  end
  mvars.revenge_forceRevengeType=e
end
function this.IsNoRevengeMission(n)
  if n==nil then
    return false
  end
  local e=this.NO_REVENGE_MISSION_LIST[n]
  if e==nil then
    return false
  end
  return e
end
function this.IsNoStealthCombatRevengeMission(n)
  if n==nil then
    return false
  end
  local e=this.NO_STEALTH_COMBAT_REVENGE_MISSION_LIST[n]
  if e==nil then
    return false
  end
  return e
end
function this.GetEquipGradeLimit()
  return mvars.revenge_revengeConfig.EQUIP_GRADE_LIMIT
end
function this.IsUsingNoKillWeapon()
  return mvars.revenge_revengeConfig.NO_KILL_WEAPON
end
function this.IsUsingStrongWeapon()
  return mvars.revenge_revengeConfig.STRONG_WEAPON
end
function this.IsUsingStrongMissile()
  return mvars.revenge_revengeConfig.STRONG_MISSILE
end
function this.IsUsingStrongSniper()
  return mvars.revenge_revengeConfig.STRONG_SNIPER
end
function this.IsUsingSuperReinforce()
  if not mvars.revenge_isEnabledSuperReinforce then
    return false
  end
  return mvars.revenge_revengeConfig.SUPER_REINFORCE
end
function this.IsUsingBlackSuperReinforce()
  return mvars.revenge_revengeConfig.BLACK_SUPER_REINFORCE
end
function this.GetReinforceCount()
  local e=mvars.revenge_revengeConfig.REINFORCE_COUNT
  if e then
    return e+0
  end
  return 1
end
function this.CanUseArmor(e)
  if TppEneFova==nil then
    return false
  end
  local n=TppMission.GetMissionID()
  if TppEneFova.IsNotRequiredArmorSoldier(n)then
    return false
  end
  if e then
    return TppEneFova.CanUseArmorType(n,e)
  end
  return true
end
local n=function(e)
  if e==nil then
    return 0
  end
  return(e:sub(1,-2)+0)/100
end
function this.GetMineRate()
  return n(mvars.revenge_revengeConfig.MINE)
end
function this.GetDecoyRate()
  return n(mvars.revenge_revengeConfig.DECOY)
end
function this.IsUsingActiveDecoy()
  return mvars.revenge_revengeConfig.ACTIVE_DECOY
end
function this.GetCameraRate()
  return n(mvars.revenge_revengeConfig.CAMERA)
end
function this.IsUsingGunCamera()
  return mvars.revenge_revengeConfig.GUN_CAMERA
end
function this.GetPatrolRate()
  if mvars.revenge_revengeConfig.STRONG_PATROL then
    return 1
  else
    return 0
  end
end
function this.IsIgnoreBlocked()
  return mvars.revenge_revengeConfig.IGNORE_BLOCKED
end
function this.IsBlocked(e)
  if gvars.revengeMode==1 then--tex revengemax
    return false
  end--
  if e==nil then
    return false
  end
  return gvars.rev_revengeBlockedCount[e]>0
end
function this.SetEnabledSuperReinforce(e)
  mvars.revenge_isEnabledSuperReinforce=e
end
function this.SetHelmetAll()
  mvars.revenge_revengeConfig.HELMET="100%"end
function this.RegisterMineList(n,E)
  if not mvars.rev_usingBase then
    return
  end
  mvars.rev_mineBaseTable={}
  for n,e in ipairs(n)do
    if mvars.rev_usingBase[e]then
      mvars.rev_mineBaseTable[e]=n-1
    end
  end
  mvars.rev_mineBaseList=n
  mvars.rev_mineBaseCountMax=#n
  this.RegisterCommonMineList(E)
end
function this.RegisterCommonMineList(E)
  mvars.rev_mineTrapTable={}
  for n,e in pairs(E)do
    if mvars.rev_usingBase[n]then
      for E,e in ipairs(e)do
        local e=e.trapName
        local n={areaIndex=E,trapName=e,baseName=n}
        mvars.rev_mineTrapTable[Fox.StrCode32(e)]=n
      end
    end
  end
  mvars.rev_revengeMineList={}
  for n,E in pairs(E)do
    if mvars.rev_usingBase[n]then
      mvars.rev_revengeMineList[n]={}
      if Tpp.IsTypeTable(E)then
        if next(E)then
          for E,t in ipairs(E)do
            mvars.rev_revengeMineList[n][E]={}
            this._CopyRevengeMineArea(mvars.rev_revengeMineList[n][E],t,n,E)
          end
          local e=E.decoyLocatorList
          if e then
            mvars.rev_revengeMineList[n].decoyLocatorList={}
            for E,e in ipairs(e)do
              table.insert(mvars.rev_revengeMineList[n].decoyLocatorList,e)
            end
          end
        end
      end
    end
  end
end
function this.RegisterMissionMineList(n)
  for n,E in pairs(n)do
    this.AddBaseMissionMineList(n,E)
  end
end
function this.AddBaseMissionMineList(e,n)
  local a=mvars.rev_revengeMineList[e]
  if not a then
    return
  end
  if not Tpp.IsTypeTable(n)then
    return
  end
  local E=n.decoyLocatorList
  if E then
    local n=mvars.rev_revengeMineList[e].decoyLocatorList
    mvars.rev_revengeMineList[e].decoyLocatorList=mvars.rev_revengeMineList[e].decoyLocatorList or{}
    for E,n in ipairs(E)do
      table.insert(mvars.rev_revengeMineList[e].decoyLocatorList,n)
    end
  end
  for t,r in pairs(n)do
    local e=mvars.rev_mineTrapTable[Fox.StrCode32(t)]
    if e then
      local e=e.areaIndex
      local e=a[e]
      local n=r.mineLocatorList
      if n then
        e.mineLocatorList=e.mineLocatorList or{}
        for E,n in ipairs(n)do
          table.insert(e.mineLocatorList,n)
        end
      end
      if not E then
        local n=r.decoyLocatorList
        if n then
          e.decoyLocatorList=e.decoyLocatorList or{}
          for E,n in ipairs(n)do
            table.insert(e.decoyLocatorList,n)
          end
        end
      end
    else
      if t~="decoyLocatorList"then
      end
    end
  end
end
function this._CopyRevengeMineArea(e,n,E,E)
  local E=n.trapName
  if E then
    e.trapName=E
  else
    return
  end
  local E=n.mineLocatorList
  if E then
    e.mineLocatorList={}
    for E,n in ipairs(E)do
      e.mineLocatorList[E]=n
    end
  end
  local n=n.decoyLocatorList
  if n then
    e.decoyLocatorList={}
    for n,E in ipairs(n)do
      e.decoyLocatorList[n]=E
    end
  end
end
function this.OnEnterRevengeMineTrap(n)
  if not mvars.rev_mineTrapTable then
    return
  end
  local n=mvars.rev_mineTrapTable[n]
  if not n then
    return
  end
  local t,n,E=n.areaIndex,n.baseName,n.trapName
  this.UpdateLastVisitedMineArea(n,t,E)
end
function this.ClearLastRevengeMineBaseName()
  gvars.rev_lastUpdatedBaseName=0
end
function this.UpdateLastVisitedMineArea(n,t,e)
  local e=mvars.rev_LastVisitedMineAreaVarsName
  if not e then
    return
  end
  local E=Fox.StrCode32(n)
  if gvars.rev_lastUpdatedBaseName==E then
    return
  else
    gvars.rev_lastUpdatedBaseName=E
  end
  local n=mvars.rev_mineBaseTable[n]gvars[e][n]=t
end
function this.SaveMissionStartMineArea()
  local e,E=mvars.rev_missionStartMineAreaVarsName,mvars.rev_LastVisitedMineAreaVarsName
  if not e then
    return
  end
  for n=0,(TppDefine.REVENGE_MINE_BASE_MAX-1)do
    gvars[e][n]=gvars[E][n]
  end
end
function this.SetUpRevengeMine()
  if TppMission.IsMissionStart()then
    this._SetUpRevengeMine()
  end
end
function this._SetUpRevengeMine()
  local t=mvars.rev_missionStartMineAreaVarsName
  if not t then
    return
  end
  if not mvars.rev_mineBaseTable then
    return
  end
  local _,E=false,false
  if this.GetMineRate()>.5 then
    _=true
  else
    _=false
  end
  if this.GetDecoyRate()>.5 then
    E=true
  else
    E=false
  end
  for a,o in pairs(mvars.rev_mineBaseTable)do
    local r=mvars.rev_revengeMineList[a]
    local n=gvars[t][o]
    if n==0 and#r>0 then
      n=math.random(1,#r)gvars[t][o]=n
    end
    local o=r.decoyLocatorList
    local t=false
    for r,i in ipairs(r)do
      local T=i.mineLocatorList
      if T then
        local e=_ and(r==n)
        if e then
          t=false
        end
        for E,n in ipairs(T)do
          TppPlaced.SetEnableByLocatorName(n,e)
        end
      end
      local _=i.decoyLocatorList
      if o then
        this._EnableDecoy(a,o,E)
        if E then
          t=false
        end
      end
      if _ then
        local n=E and(r==n)
        this._EnableDecoy(a,_,n)
        if n then
          t=false
        end
      end
    end
    if t then
    end
  end
end
function this._GetDecoyType(e)
  local n={PF_A=1,PF_B=2,PF_C=3}
  local e=_(e)
  local e=TppEnemy.GetCpSubType(e)
  return n[e]
end
function this._EnableDecoy(n,t,E)
  local n=n.."_cp"local n=this._GetDecoyType(n)
  local r=this.IsUsingActiveDecoy()
  for t,e in ipairs(t)do
    if n then
      TppPlaced.SetCorrelationValueByLocatorName(e,n)
    end
    if r then
      TppPlaced.ChangeEquipIdByLocatorName(e,TppEquip.EQP_SWP_ActiveDecoy)
    end
    TppPlaced.SetEnableByLocatorName(e,E)
  end
end
function this._SetupCamera()
  if not GameObject.DoesGameObjectExistWithTypeName"TppSecurityCamera2"then
    return
  end
  if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
    return
  end
  local n=false
  if this.GetCameraRate()>.5 then
    n=true
  else
    n=false
  end
  GameObject.SendCommand({type="TppSecurityCamera2"},{id="SetEnabled",enabled=n})
  if this.IsUsingGunCamera()then
    GameObject.SendCommand({type="TppSecurityCamera2"},{id="SetGunCamera"})
  else
    GameObject.SendCommand({type="TppSecurityCamera2"},{id="SetNormalCamera"})
  end
end
function this.OnAllocate(n)
  mvars.revenge_isEnabledSuperReinforce=true
  this.SetUpMineAreaVarsName()
  if n.sequence then
    local e=n.sequence.baseList
    if e then
      local n=TppLocation.GetLocationName()
      mvars.rev_usingBase={}
      for E,e in ipairs(e)do
        local e=n..("_"..e)
        mvars.rev_usingBase[e]=true
      end
    end
  end
end
function this.SetUpMineAreaVarsName()
  if TppLocation.IsAfghan()then
    mvars.rev_missionStartMineAreaVarsName="rev_baseMissionStartMineAreaAfgh"mvars.rev_LastVisitedMineAreaVarsName="rev_baseLastVisitedMineAreaAfgh"elseif TppLocation.IsMiddleAfrica()then
    mvars.rev_missionStartMineAreaVarsName="rev_baseMissionStartMineAreaMafr"mvars.rev_LastVisitedMineAreaVarsName="rev_baseLastVisitedMineAreaMafr"else
    return
  end
end
function this.DecideRevenge(n)
  this._SetUiParameters()
  mvars.revenge_revengeConfig=mvars.revenge_revengeConfig or{}
  mvars.revenge_revengeType=mvars.revenge_forceRevengeType
  if mvars.revenge_revengeType==nil then
    mvars.revenge_revengeType=this.SelectRevengeType()
  end
  mvars.revenge_revengeConfig=this._CreateRevengeConfig(mvars.revenge_revengeType)
  if(n.enemy and n.enemy.soldierDefine)or vars.missionCode>6e4 then
    this._AllocateResources(mvars.revenge_revengeConfig)
  end
end
function this.SetUpEnemy()
  if mvars.ene_soldierDefine==nil then
    return
  end
  if mvars.ene_soldierIDList==nil then
    return
  end
  this._SetMbInterrogate()
  local n=this.GetReinforceCount()
  GameObject.SendCommand({type="TppCommandPost2"},{id="SetReinforceCount",count=n})
  if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
    TppEnemy.SetUpDDParameter()
  end
  this._SetupCamera()
  for n,E in pairs(mvars.ene_soldierDefine)do
    local n=_(n)
    if n==o then
    else
      if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
        for E=0,3 do
          this._ApplyRevengeToCp(n,mvars.revenge_revengeConfig,E)
        end
      else
        this._ApplyRevengeToCp(n,mvars.revenge_revengeConfig)
      end
    end
  end
end
function this.GetRevengeLvLimitRank()
  local e=gvars.str_storySequence
  if e<TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
    return 1
  elseif e<TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY then
    return 2
  elseif e<TppDefine.STORY_SEQUENCE.CLEARD_ELIMINATE_THE_POWS then
    return 3
  elseif e<TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA then
    return 4
  elseif e<TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
    return 5
  else
    return 6
  end
  return 6
end
function this.GetRevengeLv(e)
  local missionId=TppMission.GetMissionID()
  if TppMission.IsHardMission(missionId) or gvars.revengeMode>0 then--tex added
    return this.GetRevengeLvMax(e,this.REVENGE_LV_LIMIT_RANK_MAX)--tex RETAILBUG: was just REVE, the limit on REVE is max rank anyway which GetRevengeLvMax defaults to
  else
    return gvars.rev_revengeLv[e]
  end
end
function this.GetActualRevengeLv(e)--tex ORIG: GetRevengeLv
  return gvars.rev_revengeLv[e]
end
function this.GetRevengeLvMax(E,n)
  local n=n or this.GetRevengeLvLimitRank()
  local e=this.REVENGE_LV_MAX[E]
  if Tpp.IsTypeTable(e)then
    local e=e[n]
    return e or 0
  end
  return 0
end
function this.GetRevengePoint(e)
  return gvars.rev_revengePoint[e]
end
function this.AddRevengePoint(n,E)
  this.SetRevengePoint(n,gvars.rev_revengePoint[n]+E)
end
function this.GetRevengeTriggerName(n)
  for e,E in pairs(this.REVENGE_TRIGGER_TYPE)do
    if E==n then
      return e
    end
  end
  return""end
function this.AddRevengePointByTriggerType(n)
  local E=TppMission.GetMissionID()
  if this.IsNoRevengeMission(E)then
    return
  end
  local t="###REVENGE### "..(tostring(E)..(" / AddRevengePointBy ["..(this.GetRevengeTriggerName(n).."] : ")))
  local n=this.REVENGE_POINT_TABLE[n]
  for n,E in pairs(n)do
    n=n+0
    E=E+0
    local r=gvars.rev_revengePoint[n]
    this.SetRevengePoint(n,gvars.rev_revengePoint[n]+E)
    local E=gvars.rev_revengePoint[n]t=t..(this.REVENGE_TYPE_NAME[n+1]..(":"..(tostring(r)..("->"..(tostring(E).." ")))))
  end
end
function this.SetRevengePoint(E,n)
  local t=this.GetRevengeLvMax(E)
  local e=t*this.REVENGE_POINT_PER_LV+this.REVENGE_POINT_OVER_MARGINE
  if n<0 then
    n=0
  end
  if n>e then
    n=e
  end
  gvars.rev_revengePoint[E]=n
end
function this.ResetRevenge()
  for n=0,this.REVENGE_TYPE.MAX-1 do
    this.SetRevengePoint(n,0)
  end
  this.UpdateRevengeLv()
end
function this.UpdateRevengeLv(n)
  if n==nil then
    n=TppMission.GetMissionID()
  end
  for n=0,this.REVENGE_TYPE.MAX-1 do
    local E=this.GetRevengeLvMax(n)
    local e=this.GetRevengePoint(n)
    local e=math.floor(e/100)
    if e>E then
      e=E
    end
    gvars.rev_revengeLv[n]=e
  end
  this._SetEnmityLv()
end
function this._GetUiParameterValue(E)
  local r=4
  local t=5
  local n=this.GetRevengeLv(E)
  if n>=this.GetRevengeLvMax(E,t)then
    return 3
  elseif n>=this.GetRevengeLvMax(E,r)then
    return 2
  elseif n>=1 then
    return 1
  end
  return 0
end
function this._SetUiParameters()
  local a=this._GetUiParameterValue(this.REVENGE_TYPE.FULTON)
  local r=this._GetUiParameterValue(this.REVENGE_TYPE.HEAD_SHOT)
  local E=this._GetUiParameterValue(this.REVENGE_TYPE.STEALTH)
  local n=this._GetUiParameterValue(this.REVENGE_TYPE.COMBAT)
  local t=math.min(3,math.max(this.GetRevengeLv(this.REVENGE_TYPE.NIGHT_S),this.GetRevengeLv(this.REVENGE_TYPE.NIGHT_C)))
  local e=this._GetUiParameterValue(this.REVENGE_TYPE.LONG_RANGE)
  TppUiCommand.RegisterEnemyRevengeParameters{fulton=a,headShot=r,stealth=E,combat=n,night=t,longRange=e}
end
function this._SetMbInterrogate()
  if not GameObject.DoesGameObjectExistWithTypeName"TppSoldier2"then
    return
  end
  local E=0
  local n={{MbInterrogate.FULUTON,this.REVENGE_TYPE.FULTON,1},{MbInterrogate.GAS,this.REVENGE_TYPE.SMOKE,1,this.BLOCKED_TYPE.GAS_MASK},{MbInterrogate.MET,this.REVENGE_TYPE.HEAD_SHOT,1,this.BLOCKED_TYPE.HELMET},{MbInterrogate.FLASH,this.REVENGE_TYPE.NIGHT_C,1,this.BLOCKED_TYPE.GUN_LIGHT},{MbInterrogate.SNIPER,this.REVENGE_TYPE.LONG_RANGE,1,this.BLOCKED_TYPE.SNIPER},{MbInterrogate.MISSILE,this.REVENGE_TYPE.VEHICLE,1,this.BLOCKED_TYPE.MISSILE},{MbInterrogate.NIGHT,this.REVENGE_TYPE.NIGHT_S,1,this.BLOCKED_TYPE.NVG},{MbInterrogate.CAMERA,this.REVENGE_TYPE.STEALTH,this.revengeDefine._ENABLE_CAMERA_LV,this.BLOCKED_TYPE.CAMERA},{MbInterrogate.DECOY,this.REVENGE_TYPE.STEALTH,this.revengeDefine._ENABLE_DECOY_LV,this.BLOCKED_TYPE.DECOY},{MbInterrogate.MINE,this.REVENGE_TYPE.STEALTH,this.revengeDefine._ENABLE_MINE_LV,this.BLOCKED_TYPE.MINE},{MbInterrogate.SHOTGUN,this.REVENGE_TYPE.COMBAT,this.revengeDefine._ENABLE_SHOTGUN_LV,this.BLOCKED_TYPE.SHOTGUN},{MbInterrogate.MACHINEGUN,this.REVENGE_TYPE.COMBAT,this.revengeDefine._ENABLE_MG_LV,this.BLOCKED_TYPE.MG},{MbInterrogate.BODY,this.REVENGE_TYPE.COMBAT,this.revengeDefine._ENABLE_SOFT_ARMOR_LV,this.BLOCKED_TYPE.SOFT_ARMOR},{MbInterrogate.SHIELD,this.REVENGE_TYPE.COMBAT,this.revengeDefine._ENABLE_SHIELD_LV,this.BLOCKED_TYPE.SHIELD},{MbInterrogate.ARMOR,this.REVENGE_TYPE.COMBAT,this.revengeDefine._ENABLE_ARMOR_LV,this.BLOCKED_TYPE.ARMOR}}
  for t,n in ipairs(n)do
    local t=n[1]
    local a=n[2]
    local r=n[3]
    local n=n[4]
    if n and this.IsBlocked(n)then
    elseif this.GetRevengeLv(a)>=r then
      E=bit.bor(E,t)
    end
  end
  GameObject.SendCommand({type="TppSoldier2"},{id="SetMbInterrogate",enableMask=E})
end
function this._SetEnmityLv()
  local n=this.GetRevengePoint(this.REVENGE_TYPE.STEALTH)
  local e=this.GetRevengePoint(this.REVENGE_TYPE.COMBAT)
  local t=math.max(n,e)
  local e={TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_NONE,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_10,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_20,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_30,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_40,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_50,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_60,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_70,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_80,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_90,TppMotherBaseManagementConst.STAFF_INIT_ENMITY_LV_100}
  local n=500
  local E=#e
  local n=math.floor((t*(E-1))/n)+1
  if n>=E then
    n=#e
  end
  local e=e[n]
  TppMotherBaseManagement.SetStaffInitEnmityLv{lv=e}
end
function this.OnMissionClearOrAbort(n)
  gvars.rev_revengeRandomValue=math.random(0,2147483647)
  this.ApplyMissionTendency(n)
  this._ReduceRevengePointByChickenCap(n)
  this._ReduceBlockedCount(n)
  this._ReceiveClearedDeployRevengeMission()
  this.UpdateRevengeLv(n)
  this._AddDeployRevengeMission()
end
function this._ReduceBlockedCount(n)
  if not TppMission.IsHelicopterSpace(n)then
    return
  end
  for n=0,this.BLOCKED_TYPE.MAX-1 do
    local e=gvars.rev_revengeBlockedCount[n]
    if e>0 then
      gvars.rev_revengeBlockedCount[n]=e-1
    end
  end
end
function this._GetBlockedName(n)
  for E,e in pairs(this.BLOCKED_TYPE)do
    if e==n then
      return E
    end
  end
  return"unknown"end
function this._ReceiveClearedDeployRevengeMission()
  if not TppMotherBaseManagement.GetClearedDeployRevengeMissionFlag then
    return
  end
  for n,t in pairs(this.DEPLOY_REVENGE_MISSION_BLOCKED_LIST)do
    local E=TppMotherBaseManagement.GetClearedDeployRevengeMissionFlag{deployMissionId=n}
    if E then
      gvars.rev_revengeBlockedCount[t]=this.BLOCKED_FOR_MISSION_COUNT
      TppMotherBaseManagement.UnsetClearedDeployRevengeMissionFlag{deployMissionId=n}
    end
  end
end
function this._AddDeployRevengeMission()
  for n,E in pairs(this.DEPLOY_REVENGE_MISSION_CONDITION_LIST)do
    local t=this.DEPLOY_REVENGE_MISSION_BLOCKED_LIST[n]
    if not this.IsBlocked(t)and this.GetRevengeLv(E.revengeType)>=E.lv then
      local e=TppMotherBaseManagement.RequestAddDeployRevengeMission{deployMissionId=n}
    else
      if not TppMotherBaseManagement.RequestDeleteDeployRevengeMission then
        return
      end
      TppMotherBaseManagement.RequestDeleteDeployRevengeMission{deployMissionId=n}
    end
  end
end
function this._ReduceRevengePointStealthCombat()
  for n,E in pairs(this.REDUCE_TENDENCY_POINT_TABLE)do
    local t=this.GetRevengePoint(n)
    local r=this.GetRevengeLv(n)
    local E=E[r+1]
    this.SetRevengePoint(n,(t+E))
  end
end
function this._ReduceRevengePointOther()
  local r={[this.REVENGE_TYPE.STEALTH]=true,[this.REVENGE_TYPE.COMBAT]=true,[this.REVENGE_TYPE.M_STEALTH]=true,[this.REVENGE_TYPE.M_COMBAT]=true}
  for E=0,this.REVENGE_TYPE.MAX-1 do
    local a=this.GetRevengePoint(E)
    local t=this.GetRevengeLv(E)
    local n=0
    if r[E]then
      n=0
    elseif bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)==PlayerPlayFlag.USE_CHICKEN_CAP then
      n=100
    elseif this.REDUCE_POINT_TABLE[E]then
      n=this.REDUCE_POINT_TABLE[E][t+1]
      if n==nil then
        n=50
      else
        n=-n
      end
    else
      n=this.REDUCE_REVENGE_POINT*(t+1)
      if n>50 then
        n=50
      end
    end
    this.SetRevengePoint(E,a-n)
  end
end
function this.ReduceRevengePointOnMissionClear(n)
  if n==nil then
    n=TppMission.GetMissionID()
  end
  if this.IsNoRevengeMission(n)then
    return
  end
  if bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)==PlayerPlayFlag.USE_CHICKEN_CAP then
    return
  end
  this._ReduceRevengePointOther()
end
function this._ReduceRevengePointByChickenCap(n)
  if n==nil then
    n=TppMission.GetMissionID()
  end
  if this.IsNoRevengeMission(n)then
    return
  end
  if bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)==PlayerPlayFlag.USE_CHICKEN_CAP then
    this._ReduceRevengePointStealthCombat()
    this._ReduceRevengePointOther()
  end
end
function this.ReduceRevengePointOnAbort(e)
end
function this._GetMissionTendency(n)
  local n=this.GetRevengePoint(this.REVENGE_TYPE.M_STEALTH)
  local e=this.GetRevengePoint(this.REVENGE_TYPE.M_COMBAT)
  if n==0 and e==0 then
    return"STEALTH"end
  if e==0 then
    return"STEALTH"end
  if n==0 then
    return"COMBAT"end
  local t=n-e
  local r=.3
  local E=10
  local e=(n+e)*r
  if e<E then
    e=E
  end
  local n="DRAW"if t>=e then
    n="STEALTH"elseif t<=-e then
    n="COMBAT"end
  return n
end
function this.ApplyMissionTendency(n)
  if n==nil then
    n=TppMission.GetMissionID()
  end
  if(not this.IsNoRevengeMission(n)and not this.IsNoStealthCombatRevengeMission(n))and bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)~=PlayerPlayFlag.USE_CHICKEN_CAP then
    local n=this._GetMissionTendency(n)
    local n=this.MISSION_TENDENCY_POINT_TABLE[n]
    if n then
      local E=this.GetRevengeLv(this.REVENGE_TYPE.STEALTH)+1
      local t=this.GetRevengeLv(this.REVENGE_TYPE.COMBAT)+1
      if E>#n.STEALTH then
        E=#n.STEALTH
      end
      if t>#n.COMBAT then
        t=#n.COMBAT
      end
      this.AddRevengePoint(this.REVENGE_TYPE.STEALTH,n.STEALTH[E])
      this.AddRevengePoint(this.REVENGE_TYPE.COMBAT,n.COMBAT[t])
    end
  end
  this.SetRevengePoint(this.REVENGE_TYPE.M_STEALTH,0)
  this.SetRevengePoint(this.REVENGE_TYPE.M_COMBAT,0)
end
function this.CanUseReinforceVehicle()
  local n=TppMission.GetMissionID()
  return this.USE_SUPER_REINFORCE_VEHICLE_MISSION[n]
end
function this.CanUseReinforceHeli()
  return not GameObject.DoesGameObjectExistWithTypeName"TppEnemyHeli"end
function this.SelectReinforceType()
  if mvars.reinforce_reinforceType==TppReinforceBlock.REINFORCE_TYPE.HELI then
    return TppReinforceBlock.REINFORCE_TYPE.HELI
  end
  if not this.IsUsingSuperReinforce()then
    return TppReinforceBlock.REINFORCE_TYPE.NONE
  end
  local n={}
  local t=this.CanUseReinforceVehicle()
  local E=this.CanUseReinforceHeli()
  if t then
    local e={AFGH={TppReinforceBlock.REINFORCE_TYPE.EAST_WAV,TppReinforceBlock.REINFORCE_TYPE.EAST_TANK},MAFR={TppReinforceBlock.REINFORCE_TYPE.WEST_WAV,TppReinforceBlock.REINFORCE_TYPE.WEST_WAV_CANNON,TppReinforceBlock.REINFORCE_TYPE.WEST_TANK}}
    if TppLocation.IsAfghan()then
      n=e.AFGH
    elseif TppLocation.IsMiddleAfrica()then
      n=e.MAFR
    end
  end
  if E then
    table.insert(n,TppReinforceBlock.REINFORCE_TYPE.HELI)
  end
  if#n==0 then
    return TppReinforceBlock.REINFORCE_TYPE.NONE
  end
  local e=math.random(1,#n)
  return n[e]
end
function this.ApplyPowerSettingsForReinforce(r)
  for n,e in ipairs(r)do
    GameObject.SendCommand(e,{id="RegenerateStaffIdForReinforce"})
  end
  local n={}do
    local E=this.GetRevengeLv(this.REVENGE_TYPE.HEAD_SHOT)
    local E=E/10
    if math.random()<E and(this.IsIgnoreBlocked()or not this.IsBlocked(this.BLOCKED_TYPE.HELMET))then
      table.insert(n,"HELMET")
    end
  end
  if this.IsUsingStrongWeapon()then
    table.insert(n,"STRONG_WEAPON")
  end
  if this.IsUsingNoKillWeapon()then
    table.insert(n,"NO_KILL_WEAPON")
  end
  do
    local E=0
    local t=this.GetRevengeLv(this.REVENGE_TYPE.COMBAT)
    if t>=4 then
      E=99
    elseif t>=3 then
      E=.75
    elseif t>=1 then
      E=.5
    end
    if math.random()<E and(this.IsIgnoreBlocked()or not this.IsBlocked(this.BLOCKED_TYPE.SOFT_ARMOR))then
      table.insert(n,"SOFT_ARMOR")
    end
    if math.random()<E then
      if mvars.revenge_loadedEquip.SHOTGUN and(this.IsIgnoreBlocked()or not this.IsBlocked(this.BLOCKED_TYPE.SHOTGUN))then
        table.insert(n,"SHOTGUN")
      elseif mvars.revenge_loadedEquip.MG and(this.IsIgnoreBlocked()or not this.IsBlocked(this.BLOCKED_TYPE.MG))then
        table.insert(n,"MG")
      end
    end
  end
  for E,e in ipairs(r)do
    TppEnemy.ApplyPowerSetting(e,n)
  end
end
function this._CreateRevengeConfig(E)
  local n={}
  local t=mvars.ene_disablePowerSettings
  do
    local e=mvars.ene_missionRequiresPowerSettings
    local n={MISSILE={"SHIELD"},SHIELD={"MISSILE"},SHOTGUN={"MG"},MG={"SHOTGUN"}}
    for e,E in pairs(e)do
      local e=n[e]
      if e then
        for n,e in ipairs(e)do
          if not mvars.ene_missionRequiresPowerSettings[e]then
            t[e]=true
          end
        end
      end
    end
  end
  for r,E in ipairs(E)do
    local E=this.revengeDefine[E]
    if E~=nil then
      if E[1]~=nil then
        local e=this._Random(1,#E)E=E[e]
      end
      for e,E in pairs(E)do
        if t[e]then
        else
          n[e]=E
        end
      end
    end
  end
  if not n.IGNORE_BLOCKED then
    for E,t in pairs(n)do
      if this.IsBlocked(this.BLOCKED_TYPE[E])then
        n[E]=nil
      end
    end
  end
  if Tpp.IsTypeNumber(n.ARMOR)and not this.CanUseArmor()then
    if not t.SHIELD then
      local e=n.SHIELD or 0
      if Tpp.IsTypeNumber(e)then
        n.SHIELD=e+n.ARMOR
      end
    end
    n.ARMOR=nil
  end
  local e={NO_KILL_WEAPON={"MG"}}
  if not mvars.ene_missionRequiresPowerSettings.SHIELD then
    e.MISSILE={"SHIELD"}
  end
  if not mvars.ene_missionRequiresPowerSettings.MG then
    e.SHOTGUN={"MG"}
  end
  local E={}
  for e,t in pairs(e)do
    if n[e]and not E[e]then
      for n,e in ipairs(t)do
        E[e]=true
      end
    end
  end
  for e,E in pairs(E)do
    n[e]=nil
  end
  local e=TppMission.GetMissionID()
  if TppMission.IsFOBMission(e)then
    local e=TppEnemy.weaponIdTable.DD
    if n.NO_KILL_WEAPON and e then
      local e=e.NORMAL
      if e and e.IS_NOKILL then
        if not e.IS_NOKILL.SHOTGUN then
          n.SHOTGUN=nil
        end
        if not e.IS_NOKILL.MISSILE then
          n.MISSILE=nil
        end
        if not e.IS_NOKILL.SNIPER then
          n.SNIPER=nil
        end
        if not e.IS_NOKILL.SMG then
          n.SHIELD=nil
          n.MISSILE=nil
        end
      end
    end
  end
  return n
end
function this._AllocateResources(_)
  mvars.revenge_loadedEquip={}
  local r=mvars.ene_missionRequiresPowerSettings
  local a={}
  local n=o
  local T=TppEnemy.GetSoldierType(n)
  local n=TppEnemy.GetSoldierSubType(n)
  local n=TppEnemy.GetWeaponIdTable(T,n)
  if n==nil then
    TppEnemy.weaponIdTable.DD={NORMAL={HANDGUN=TppEquip.EQP_WP_West_hg_010,ASSAULT=TppEquip.EQP_WP_West_ar_040}}n=TppEnemy.weaponIdTable.DD
  end
  local t=mvars.ene_disablePowerSettings
  local i=TppMission.GetMissionID()
  local s=true
  if this.CANNOT_USE_ALL_WEAPON_MISSION[i]then
    s=false
  end
  local E={}
  if not s then
    if not _.SHIELD or _.MISSILE then
      if not r.SHIELD then
        E.SHIELD=true
        t.SHIELD=true
      end
    else
      if not r.MISSILE then
        E.MISSILE=true
        t.MISSILE=true
      end
    end
    if T~=EnemyType.TYPE_DD then
      if _.SHOTGUN then
        if not r.MG then
          E.MG=true
          t.MG=true
        end
      else
        if not r.SHOTGUN then
          E.SHOTGUN=true
          t.SHOTGUN=true
        end
      end
    end
  end
  for e,n in pairs(r)do
    E[e]=nil
    t[e]=nil
  end
  do
    local _={HANDGUN=true,SMG=true,ASSAULT=true,SHOTGUN=true,MG=true,SHIELD=true}
    local r=n.NORMAL
    if this.IsUsingStrongWeapon()and n.STRONG then
      r=n.STRONG
    end
    if Tpp.IsTypeTable(r)then
      for e,n in pairs(r)do
        if not _[e]then
        elseif t[e]then
        elseif E[e]then
        else
          a[n]=true
          mvars.revenge_loadedEquip[e]=n
        end
      end
    end
  end
  if not t.MISSILE and not E.MISSILE then
    local E={}
    if this.IsUsingStrongMissile()and n.STRONG then
      E=n.STRONG
    else
      E=n.NORMAL
    end
    local e=E.MISSILE
    if e then
      a[e]=true
      mvars.revenge_loadedEquip.MISSILE=e
    end
  end
  if not t.SNIPER and not E.SNIPER then
    local E={}
    if this.IsUsingStrongSniper()and n.STRONG then
      E=n.STRONG
    else
      E=n.NORMAL
    end
    local e=E.SNIPER
    if e then
      a[e]=true
      mvars.revenge_loadedEquip.SNIPER=e
    end
  end
  do
    local e,n,E=TppEnemy.GetWeaponId(o,{})
    TppSoldier2.SetDefaultSoldierWeapon{primary=e,secondary=n,tertiary=E}
  end
  local e={}
  for n,E in pairs(a)do
    table.insert(e,n)
  end
  if i==10080 or i==11080 then
    table.insert(e,TppEquip.EQP_WP_Wood_ar_010)
  end
  if TppEquip.RequestLoadToEquipMissionBlock then
    TppEquip.RequestLoadToEquipMissionBlock(e)
  end
end
function this._GetSettingSoldierCount(t,n,E)
  local e={NO_KILL_WEAPON=true,STRONG_WEAPON=true,STRONG_PATROL=true,STRONG_NOTICE_TRANQ=true,STEALTH_SPECIAL=true,STEALTH_HIGH=true,STEALTH_LOW=true,COMBAT_SPECIAL=true,COMBAT_HIGH=true,COMBAT_LOW=true,FULTON_SPECIAL=true,FULTON_HIGH=true,FULTON_LOW=true,HOLDUP_SPECIAL=true,HOLDUP_HIGH=true,HOLDUP_LOW=true}
  if e[t]then
    return E
  end
  local e=0
  if Tpp.IsTypeNumber(n)then
    e=n
  elseif Tpp.IsTypeString(n)then
    if n:sub(-1)=="%"then
      local n=n:sub(1,-2)+0
      e=math.ceil(E*(n/100))
    end
  end
  if e>E then
    e=E
  end
  do
    local n={ARMOR=4}
    local n=n[t]
    if n and e>n then
      e=n
    end
  end
  return e
end
function this._ApplyRevengeToCp(t,l,a)
  local E=mvars.ene_soldierIDList[t]
  local o={}
  local n=0
  if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
    local r=0
    local e=mvars.ene_cpList[t]
    if(mtbs_enemy and mtbs_enemy.cpNameToClsterIdList~=nil)and mvars.mbSoldier_enableSoldierLocatorList~=nil then
      local e=mtbs_enemy.cpNameToClsterIdList[e]
      if e then
        E={}
        local e=mvars.mbSoldier_enableSoldierLocatorList[e]
        for n,e in ipairs(e)do
          local n=tonumber(string.sub(e,-6,-6))
          if n~=nil and n==a then
            local e=GameObject.GetGameObjectId("TppSoldier2",e)E[e]=r
          end
        end
      end
    end
  end
  if E==nil then
    return
  end
  local r={}
  for e,n in pairs(mvars.ene_missionSoldierPowerSettings)do
    local e=_("TppSoldier2",e)r[e]=n
  end
  local i={}
  for n,e in pairs(mvars.ene_missionSoldierPersonalAbilitySettings)do
    local n=_("TppSoldier2",n)i[n]=e
  end
  local T=mvars.ene_outerBaseCpList[t]
  local a={}
  local _={}
  for e,E in pairs(E)do
    table.insert(o,e)n=n+1
    if r[e]then
      a[n]=true
    elseif mvars.ene_eliminateTargetList[e]then
      a[n]=true
    elseif TppEnemy.GetSoldierType(e)==EnemyType.TYPE_CHILD then
      a[n]=true
    elseif T then
      _[n]=true
    elseif mvars.ene_lrrpTravelPlan[t]then
      _[n]=true
    end
  end
  local t={}
  for e=1,n do
    if T then
      t[e]={OB=true}
    else
      t[e]={}
    end
  end
  local T={ARMOR={"SOFT_ARMOR","HELMET","GAS_MASK","NVG","SNIPER","SHIELD","MISSILE"},SOFT_ARMOR={"ARMOR"},SNIPER={"SHOTGUN","MG","MISSILE","GUN_LIGHT","ARMOR","SHIELD","SMG"},SHOTGUN={"SNIPER","MG","MISSILE","SHIELD","SMG"},MG={"SNIPER","SHOTGUN","MISSILE","GUN_LIGHT","SHIELD","SMG"},SMG={"SNIPER","SHOTGUN","MG"},MISSILE={"ARMOR","SHIELD","SNIPER","SHOTGUN","MG"},SHIELD={"ARMOR","SNIPER","MISSILE","SHOTGUN","MG"},HELMET={"ARMOR","GAS_MASK","NVG"},GAS_MASK={"ARMOR","HELMET","NVG"},NVG={"ARMOR","HELMET","GAS_MASK"},GUN_LIGHT={"SNIPER","MG"}}
  local s={STEALTH_LOW=true,STEALTH_HIGH=true,STEALTH_SPECIAL=true,COMBAT_LOW=true,COMBAT_HIGH=true,COMBAT_SPECIAL=true,HOLDUP_LOW=true,HOLDUP_HIGH=true,HOLDUP_SPECIAL=true,FULTON_LOW=true,FULTON_HIGH=true,FULTON_SPECIAL=true}
  for r,E in ipairs(TppEnemy.POWER_SETTING)do
    local r=l[E]
    if r then
      local r=this._GetSettingSoldierCount(E,r,n)
      local o=T[E]or{}
      local r=r
      for n=1,n do
        local a=a[n]
        local _=(not s[E])and _[n]
        if(not a and not _)and r>0 then
          local a=true
          if t[n][E]then
            r=r-1
            a=false
          end
          if a then
            for E,e in ipairs(o)do
              if t[n][e]then
                a=false
              end
            end
          end
          if a then
            r=r-1
            t[n][E]=true
            if E=="MISSILE"and this.IsUsingStrongMissile()then
              t[n].STRONG_MISSILE=true
            end
            if E=="SNIPER"and this.IsUsingStrongSniper()then
              t[n].STRONG_SNIPER=true
            end
          end
        end
      end
    end
  end
  for n,e in ipairs(t)do
    local t=o[n]
    TppEnemy.ApplyPowerSetting(t,e)
    if i[t]==nil then
      local n={}do
        local E
        if e.STEALTH_SPECIAL then
          E="sp"elseif e.STEALTH_HIGH then
          E="high"elseif e.STEALTH_LOW then
          E="low"end
        n.notice=E
        n.cure=E
        n.reflex=E
      end
      do
        local E
        if e.COMBAT_SPECIAL then
          E="sp"elseif e.COMBAT_HIGH then
          E="high"elseif e.COMBAT_LOW then
          E="low"end
        n.shot=E
        n.grenade=E
        n.reload=E
        n.hp=E
      end
      do
        local E
        if e.STEALTH_SPECIAL or e.COMBAT_SPECIAL then
          E="sp"elseif e.STEALTH_HIGH or e.COMBAT_HIGH then
          E="high"elseif e.STEALTH_LOW or e.COMBAT_LOW then
          E="low"end
        n.speed=E
      end
      do
        local E
        if e.FULTON_SPECIAL then
          E="sp"elseif e.FULTON_HIGH then
          E="high"elseif e.FULTON_LOW then
          E="low"end
        n.fulton=E
      end
      do
        local E
        if e.HOLDUP_SPECIAL then
          E="sp"elseif e.HOLDUP_HIGH then
          E="high"elseif e.HOLDUP_LOW then
          E="low"end
        n.holdup=E
      end
      TppEnemy.ApplyPersonalAbilitySettings(t,n)
    end
  end
end
function this.Messages()
  return Tpp.StrCode32Table{GameObject={{msg="HeadShot",func=this._OnHeadShot},{msg="Dead",func=this._OnDead},{msg="Unconscious",func=this._OnUnconscious},{msg="ComradeFultonDiscovered",func=this._OnComradeFultonDiscovered},{msg="CommandPostAnnihilated",func=this._OnAnnihilated},{msg="ChangePhase",func=this._OnChangePhase},{msg="Damage",func=this._OnDamage},{msg="AntiSniperNoticed",func=this._OnAntiSniperNoticed},{msg="SleepingComradeRecoverd",func=this._OnSleepingComradeRecoverd},{msg="SmokeDiscovered",func=this._OnSmokeDiscovered},{msg="ReinforceRespawn",func=this._OnReinforceRespawn}},Trap={{msg="Enter",func=this._OnEnterTrap}}}
end
function this.Init(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(r,E,n,t,a,o,_)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,r,E,n,t,a,o,_)
end
local r=function(e)
  if(((((((((((((attackid==TppDamage.ATK_VehicleHit or e==TppDamage.ATK_Tankgun_20mmAutoCannon)or e==TppDamage.ATK_Tankgun_30mmAutoCannon)or e==TppDamage.ATK_Tankgun_105mmRifledBoreGun)or e==TppDamage.ATK_Tankgun_120mmSmoothBoreGun)or e==TppDamage.ATK_Tankgun_125mmSmoothBoreGun)or e==TppDamage.ATK_Tankgun_82mmRocketPoweredProjectile)or e==TppDamage.ATK_Tankgun_30mmAutoCannon)or e==TppDamage.ATK_Wav1)or e==TppDamage.ATK_WavCannon)or e==TppDamage.ATK_TankCannon)or e==TppDamage.ATK_WavRocket)or e==TppDamage.ATK_HeliMiniGun)or e==TppDamage.ATK_HeliChainGun)or attackid==TppDamage.ATK_WalkerGear_BodyAttack then
    return true
  end
  return false
end
function this._OnReinforceRespawn(n)
  if TppMission.IsFOBMission(vars.missionCode)then
    TppEnemy.AddPowerSetting(n,{})o50050_enemy.AssignAndSetupRespawnSoldier(n)
  else
    this.ApplyPowerSettingsForReinforce{n}
  end
end
function this._OnHeadShot(E,t,t,n)
  if a(E)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end
  if bit.band(n,HeadshotMessageFlag.IS_JUST_UNCONSCIOUS)==0 then
    return
  end
  this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.HEAD_SHOT)
end
local E=function(n)
  if n==nil then
    n=vars.playerPhase
  end
  if n~=TppGameObject.PHASE_SNEAK or vars.playerPhase~=TppGameObject.PHASE_SNEAK then
    this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.ELIMINATED_IN_COMBAT)
  else
    this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.ELIMINATED_IN_STEALTH)
  end
  if TppClock.GetTimeOfDay()=="night"then
    this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.ELIMINATED_AT_NIGHT)
  end
end
function this._OnDead(t,n,i)
  if a(t)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end
  local o=(Tpp.IsVehicle(vars.playerVehicleGameObjectId)or Tpp.IsEnemyWalkerGear(vars.playerVehicleGameObjectId))or Tpp.IsPlayerWalkerGear(vars.playerVehicleGameObjectId)
  local _=r(attackId)
  local r=Tpp.IsEnemyWalkerGear(n)or Tpp.IsPlayerWalkerGear(n)
  local t=(n==GameObject.GetGameObjectIdByIndex("TppPlayer2",PlayerInfo.GetLocalPlayerIndex()))
  if(r or _)or(t and o)then
    this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.KILLED_BY_VEHICLE)
  end
  E(i)
  if a(n)==TppGameObject.GAME_OBJECT_TYPE_HELI2 then
    this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.KILLED_BY_HELI)
  end
end
function this._OnUnconscious(e,t,n)
  if a(e)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end
  local e=GameObject.SendCommand(e,{id="GetLifeStatus"})
  if e==TppGameObject.NPC_LIFE_STATE_DYING or e==TppGameObject.NPC_LIFE_STATE_DEAD then
    return
  end
  E(n)
end
function this._OnAnnihilated(E,n,t)
  if t==0 then
    if TppEnemy.IsBaseCp(E)or TppEnemy.IsOuterBaseCp(E)then
      if n==nil then
        n=vars.playerPhase
      end
      if n~=TppGameObject.PHASE_SNEAK or vars.playerPhase~=TppGameObject.PHASE_SNEAK then
        this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.ANNIHILATED_IN_COMBAT)
      else
        this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.ANNIHILATED_IN_STEALTH)
      end
    end
  end
end
function this._OnChangePhase(E,n)
  if n~=TppGameObject.PHASE_ALERT then
    return
  end
  if TppClock.GetTimeOfDay()=="night"then
    this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.DISCOVERY_AT_NIGHT)
  end
end
function this._OnComradeFultonDiscovered(n,n)
  this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.FULTON)
end
local n=function(e)
  if((((((((((((e==TppDamage.ATK_Smoke or e==TppDamage.ATK_SmokeOccurred)or e==TppDamage.ATK_SleepGus)or e==TppDamage.ATK_SleepGusOccurred)or e==TppDamage.ATK_SupportHeliFlareGrenade)or e==TppDamage.ATK_SupplyFlareGrenade)or e==TppDamage.ATK_SleepingGusGrenade)or e==TppDamage.ATK_SleepingGusGrenade_G1)or e==TppDamage.ATK_SleepingGusGrenade_G2)or e==TppDamage.ATK_SmokeAssist)or e==TppDamage.ATK_SleepGusAssist)or e==TppDamage.ATK_Grenader_Smoke)or e==TppDamage.ATK_Grenader_Sleep)or e==TppDamage.ATK_SmokeGrenade then
    return true
  end
  return false
end
function this._OnDamage(t,E,r)
  if a(t)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end
  if n(E)then
    this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.SMOKE)
  end
end
function this._OnSmokeDiscovered(n)
  this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.WATCH_SMOKE)
end
function this._OnAntiSniperNoticed(n)
  this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.SNIPED)
end
function this._OnSleepingComradeRecoverd(n)
  this.AddRevengePointByTriggerType(this.REVENGE_TRIGGER_TYPE.WAKE_A_COMRADE)
end
function this._OnEnterTrap(n)
  this.OnEnterRevengeMineTrap(n)
end
return this
