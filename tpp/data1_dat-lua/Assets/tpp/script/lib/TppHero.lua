local e={}
local _=Fox.StrCode32
local n=Tpp.Code32Table
local n=GameObject.SendCommand
local t=bit.band
local o=GameObject.GetGameObjectId
local r=GameObject.GetTypeIndex
local c=Tpp.IsTypeString
e.MISSION_ABORT={heroicPoint=-50,ogrePoint=0}
e.MISSION_CLEAR={S={heroicPoint=1600,ogrePoint=0},A={heroicPoint=800,ogrePoint=0},B={heroicPoint=400,ogrePoint=0},C={heroicPoint=200,ogrePoint=0},D={heroicPoint=100,ogrePoint=0},E={heroicPoint=50,ogrepoint=0}}
e.ALL_MISSION_CLEAR={heroicPoint=1e4,ogrePoint=0}
e.ALL_MISSION_S_RANK_CLEAR={heroicPoint=5e4,ogrePoint=0}
e.QUEST_CLEAR={[TppDefine.QUEST_RANK.S]={heroicPoint=500,ogrePoint=0},[TppDefine.QUEST_RANK.A]={heroicPoint=400,ogrePoint=0},[TppDefine.QUEST_RANK.B]={heroicPoint=400,ogrePoint=0},[TppDefine.QUEST_RANK.C]={heroicPoint=300,ogrePoint=0},[TppDefine.QUEST_RANK.D]={heroicPoint=300,ogrePoint=0},[TppDefine.QUEST_RANK.E]={heroicPoint=200,ogrePoint=0},[TppDefine.QUEST_RANK.F]={heroicPoint=200,ogrePoint=0},[TppDefine.QUEST_RANK.G]={heroicPoint=100,ogrePoint=0},[TppDefine.QUEST_RANK.H]={heroicPoint=100,ogrePoint=0},[TppDefine.QUEST_RANK.I]={heroicPoint=0,ogrePoint=0}}
e.QUEST_ALL_CLEAR={heroicPoint=3e4,ogrePoint=0}
e.MINE_QUEST_ALL_CLEAR={heroicPoint=5e3,ogrePoint=-5e3}
e.ENEMY_HOLD_UP={heroicPoint=5,ogrePoint=0}
e.ENEMY_INTERROGATE={heroicPoint=5,ogrePoint=0}
e.PLAYER_ON_INJURY={heroicPoint=-10,ogrePoint=0}
e.PLAYER_DEAD={heroicPoint=-30,ogrePoint=0}
e.STARTED_COMBAT={heroicPoint=-10,ogrePoint=0}
e.FULTON_DYING_ENEMY={heroicPoint=30,ogrePoint=-30}
e.FULTON_HOSTAGE={heroicPoint=60,ogrePoint=-60}
e.FULTON_PARASITE={heroicPoint=30,ogrePoint=-30}
e.ON_HELI_DYING_ENEMY={heroicPoint=60,ogrePoint=-60}
e.ON_HELI_HOSTAGE={heroicPoint=120,ogrePoint=-120}
e.ON_HELI_LIQUID={heroicPoint=240,ogrePoint=-240}
e.FIRE_KILL_SOLDIER={heroicPoint=0,ogrePoint=120}
e.FIRE_KILL_SOLDIER_FOB_SNEAK={heroicPoint="HEROIC_POINT_FIRE_KILL_SOLDIER_FOB_SNEAK",ogrePoint="OGRE_POINT_FIRE_KILL_SOLDIER_FOB_SNEAK"}
e.KILL_SOLDIER={heroicPoint=0,ogrePoint=60}
e.KILL_SOLDIER_FOB_SNEAK={heroicPoint="HEROIC_POINT_KILL_SOLDIER_FOB_SNEAK",ogrePoint="OGRE_POINT_KILL_SOLDIER_FOB_SNEAK"}
e.KILL_HOSTAGE={heroicPoint=-60,ogrePoint=100}
e.FIRE_KILL_HOSTAGE={heroicPoint=-90,ogrePoint=200}
e.FIRE_KILL_DD_HOSTAGE={heroicPoint=-90,ogrePoint=180}
e.FIRE_KILL_DD_SOLDIER={heroicPoint=-90,ogrePoint=180}
e.KILL_DD_SOLDIER={heroicPoint=-60,ogrePoint=180}
e.KILL_DD_HOSTAGE={heroicPoint=-60,ogrePoint=90}
e.DEAD_HOSTAGE={heroicPoint=-30,ogrePoint=0}
e.DEAD_DD_SOLDIER={heroicPoint=-30,ogrePoint=0}
e.DYING_SOLDIER={heroicPoint=0,ogrePoint=30}
e.RECOVERED_SOLDIER={heroicPoint=0,ogrePoint=-30}
e.VEHICLE_BROKEN={[Vehicle.type.EASTERN_LIGHT_VEHICLE]={heroicPoint=0,ogrePoint=0},[Vehicle.type.WESTERN_LIGHT_VEHICLE]={heroicPoint=0,ogrePoint=0},[Vehicle.type.EASTERN_TRUCK]={heroicPoint=0,ogrePoint=0},[Vehicle.type.WESTERN_TRUCK]={heroicPoint=0,ogrePoint=0},[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]={heroicPoint=0,ogrePoint=0},[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]={heroicPoint=0,ogrePoint=0},[Vehicle.type.EASTERN_TRACKED_TANK]={heroicPoint=0,ogrePoint=0},[Vehicle.type.WESTERN_TRACKED_TANK]={heroicPoint=0,ogrePoint=0}}
e.BREAK_GIMMICK={[TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN]={heroicPoint=0,ogrePoint=0},[TppGameObject.GAME_OBJECT_TYPE_MORTAR]={heroicPoint=0,ogrePoint=0},[TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN]={heroicPoint=0,ogrePoint=0}}
e.BREAK_GIMMICK_BY_TYPE={[TppGimmick.GIMMICK_TYPE.ANTN]={heroicPoint=0,ogrePoint=0},[TppGimmick.GIMMICK_TYPE.MCHN]={heroicPoint=0,ogrePoint=0},[TppGimmick.GIMMICK_TYPE.CMMN]={heroicPoint=0,ogrePoint=0},[TppGimmick.GIMMICK_TYPE.GNRT]={heroicPoint=0,ogrePoint=0},[TppGimmick.GIMMICK_TYPE.SWTC]={heroicPoint=0,ogrePoint=0},[TppGimmick.GIMMICK_TYPE.AACR]={heroicPoint=0,ogrePoint=0}}
e.SUPPORT_HELI_LOST_CONTROLE={heroicPoint=-60,ogrePoint=150}
e.BREAK_SUPPORT_HELI={heroicPoint=-30,ogrePoint=0}
e.ENEMY_HELI_LOST_CONTROLE={heroicPoint=0,ogrePoint=120}
e.ON_ANNIHILATE_BASE={heroicPoint=300,ogrePoint=0}
e.ON_ANNIHILATE_OUTER_BASE={heroicPoint=30,ogrePoint=0}
e.CONSTRUCT_FIRST_FOB={heroicPoint=1e3,ogrePoint=0}
e.CONSTRUCT_SECOND_FOB={heroicPoint=2e3,ogrePoint=0}
e.CONSTRUCT_THIRD_FOB={heroicPoint=3e3,ogrePoint=0}
e.CONSTRUCT_FOURTH_FOB={heroicPoint=4e3,ogrePoint=0}
e.HORSE_RIDED={heroicPoint=-5,ogrePoint=0}
e.BREAK_MINE={heroicPoint=30,ogrePoint=0}
e.BREAK_DECOY={heroicPoint=5,ogrePoint=0}
e.PICK_UP_MINE={heroicPoint=30,ogrePoint=0}
e.BREAK_SECURITY_CAMERA={heroicPoint=0,ogrePoint=0}
e.BREAK_SECURITY_UAV={heroicPoint=0,ogrePoint=0}
e.DYING_PARASITE={heroicPoint=60,ogrePoint=0}
e.NuclearAbolition={heroicPoint=5e4,ogrePoint=-5e5}
e.STARTED_COMBAT_ON_FOB={heroicPoint="HEROIC_POINT_STARTED_COMBAT_ON_FOB",ogrePoint=0}
e.STARTED_COMBAT_ON_FOB_HERO={heroicPoint="HEROIC_POINT_STARTED_COMBAT_ON_FOB_HERO",ogrePoint=0}
e.DISCOVER_ATTACKER={heroicPoint="HEROIC_POINT_DISCOVER_ATTACKER",ogrePoint=0}
e.OFFENCE_WIN_ON_FOB={heroicPoint="HEROIC_POINT_OFFENSE_WIN",ogrePoint=0}
e.OFFENCE_LOSE_ON_FOB={heroicPoint="HEROIC_POINT_OFFENSE_LOSE",ogrePoint=0}
e.DEFENCE_WIN_ELIMINATE={heroicPoint="HEROIC_POINT_DEFENSE_WIN_ELIMINATE",ogrePoint=0}
e.DEFENCE_WIN_ABORT={heroicPoint="HEROIC_POINT_DEFENSE_WIN_ABORT",ogrePoint=0}
e.DEFENCE_LOSE={heroicPoint="HEROIC_POINT_DEFENSE_LOSE",ogrePoint=0}
e.DEFENCE_FULTON_OFFENCE={heroicPoint="HEROIC_POINT_FULTONED_PLAYER",ogrePoint="OGRE_POINT_FULTONED_PLAYER"}
e.OFFENCE_FULTONED_BY_DEFENCE={heroicPoint="HEROIC_POINT_FULTONED",ogrePoint=0}
e.RETAKE_STAFF_FROM_FOB={heroicPoint="HEROIC_POINT_RETAKE_STAFF_FROM_FOB",ogrePoint=0}
e.KILLED_PLAYER={heroicPoint=0,ogrePoint="OGRE_POINT_KILLED_PLAYER"}
e.OFFENCE_WIN_ON_FOB_FOR_FRIEND={heroicPoint="HEROIC_POINT_OFFENSE_WIN_ON_FOB_FOR_FRIEND",ogrePoint=0}
e.DEFENCE_WIN_FOR_FRIEND={heroicPoint="HEROIC_POINT_DEFENSE_WIN_FOR_FRIEND",ogrePoint=0}
e.BREAK_PTW_MACHINEGUN={heroicPoint="HEROIC_POINT_BREAK_PTW_MACHINEGUN",ogrePoint="OGRE_POINT_BREAK_PTW_MACHINEGUN"}
e.BREAK_PTW_MORTAR={heroicPoint="HEROIC_POINT_BREAK_PTW_MORTAR",ogrePoint="OGRE_POINT_BREAK_PTW_MORTAR"}
e.BREAK_PTW_ANTIAIR={heroicPoint="HEROIC_POINT_BREAK_PTW_ANTIAIR",ogrePoint="OGRE_POINT_BREAK_PTW_ANTIAIR"}
e.FULTON_SUPPORTER_CONTAINER={heroicPoint="HEROIC_POINT_FULTON_CONTAINER",ogrePoint="OGRE_POINT_FULTON_CONTAINER"}
e.NOTICE_CRIME={heroicPoint="HEROIC_POINT_NOTICE_CRIME",ogrePoint=0}
e.KILLED_DDS={heroicPoint="HEROIC_POINT_KILLED_DDS",ogrePoint="OGRE_POINT_KILLED_DDS"}
e.FOB_ABORT_BY_MENU={heroicPoint="HEROIC_POINT_FOB_ABORT_BY_MENU",ogrePoint=0}
function e.IsHero()
  return gvars.isHero
end
function e.AddTargetLifesavingHeroicPoint(e,n)
  if n then
    if e then
      TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=240,subOgrePoint=240}
    else
      TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=120,subOgrePoint=120}
    end
  else
    if e then
      TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=120,subOgrePoint=120}
    else
      TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=60,subOgrePoint=60}
    end
  end
end
function e.OnFultonSoldier(o,i)
  local _=n(o,{id="GetStateFlag"})
  local r=n(o,{id="IsZombieOrMsf"})
  local n=n(o,{id="IsChild"})
  if r then
    if i then
      TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=60,subOgrePoint=60}
    else
      TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=30,subOgrePoint=30}
    end
  elseif n then
    e.AddTargetLifesavingHeroicPoint(n,i)
  else
    if t(_,StateFlag.DYING_LIFE)~=0 then
      if i then
        e.SetAndAnnounceHeroicOgrePoint(e.ON_HELI_DYING_ENEMY)
      else
        if((not TppMission.IsFOBMission(vars.missionCode))or TppServerManager.FobIsSneak())then
          e.SetAndAnnounceHeroicOgrePoint(e.FULTON_DYING_ENEMY)
        else
          e.SetAndAnnounceHeroicOgrePoint{heroicPoint="HEROIC_POINT_FULTONED_DYING_STAFF",ogrePoint="OGRE_POINT_FULTONED_DYING_STAFF"}
        end
      end
    else
      e.SetAndAnnounceHeroicOgrePoint(e.RECOVERED_SOLDIER)
    end
  end
end
function e.OnFultonHostage(o,i)
  local r=n(o,{id="GetLifeStatus"})
  local t=n(o,{id="IsChild"})
  if r~=TppEnemy.LIFE_STATUS.DEAD then
    local n=n(o,{id="GetStateFlag"})
    if i then
      if TppEnemy.IsRescueTarget(o)then
        e.AddTargetLifesavingHeroicPoint(t,i)
      else
        e.SetAndAnnounceHeroicOgrePoint(e.ON_HELI_HOSTAGE)
      end
    else
      if TppEnemy.IsRescueTarget(o)then
        e.AddTargetLifesavingHeroicPoint(t,i)
      else
        e.SetAndAnnounceHeroicOgrePoint(e.FULTON_HOSTAGE)
      end
    end
  end
end
function e.OnFultonEli(n,e)
  if e then
    TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=240,subOgrePoint=240}
  else
    TppMotherBaseManagement.AddTempLifesavingLog{heroicPoint=120,subOgrePoint=120}
  end
end
function e.GetFobServerParameter(e)
  local n,o
  if c(e)then
    o=e
    n=TppNetworkUtil.GetFobServerParameterByName(e)
  else
    n=e
  end
  return n,o
end
function e.SetHeroicPoint(n)
  local e,n=e.GetFobServerParameter(n)
  if e<0 then
    TppMotherBaseManagement.SubHeroicPoint{heroicPoint=-e}
  elseif e>0 then
    TppMotherBaseManagement.AddHeroicPoint{heroicPoint=e}
  end
  return e
end
function e.SetOgrePoint(n)
  local e,n=e.GetFobServerParameter(n)
  if e<0 then
    TppMotherBaseManagement.SubOgrePoint{ogrePoint=-e}
  elseif e>0 then
    TppMotherBaseManagement.AddOgrePoint{ogrePoint=e}
  end
  svars.her_missionOgrePoint=svars.her_missionOgrePoint+e
end
function e.GetMissionOgrePoint()
  return svars.her_missionOgrePoint
end
function e.AnnounceHeroicPoint(i,o,n)
  local o=o or"heroicPointDown"local n=n or"heroicPointUp"if vars.missionCode>=6e4 then
    return
  end
  local e=e.GetFobServerParameter(i.heroicPoint)
  if e<0 then
    TppUI.ShowAnnounceLog(o,-e)
  elseif e>0 then
    TppUI.ShowAnnounceLog(n,e)
  end
end
function e.SetAndAnnounceHeroicOgrePoint(n,i,o)
  if TppMission.IsFOBMission(vars.missionCode)and(vars.fobSneakMode==FobMode.MODE_SHAM)then
    return
  end
  e.SetHeroicPoint(n.heroicPoint)
  e.AnnounceHeroicPoint(n,i,o)
  e.SetOgrePoint(n.ogrePoint)
end
function e.AnnounceMissionAbort()
  e.AnnounceHeroicPoint(e.MISSION_ABORT)
end
function e.MissionAbort()
  e.SetHeroicPoint(e.MISSION_ABORT.heroicPoint)
end
function e.MissionClear(n)
  local n=e.MISSION_CLEAR[TppDefine.MISSION_CLEAR_RANK_LIST[n]].heroicPoint
  e.SetHeroicPoint(n)svars.her_missionHeroPoint=n
end
function e.SetFirstMissionClearHeroPoint()
  if TppStory.IsMissionCleard(vars.missionCode)==false then
    mvars.her_reserveFirstMissionClear=true
  end
end
function e.AnnounceFirstMissionClearHeroPoint()
  if mvars.her_reserveFirstMissionClear then
  end
end
function e.AnnounceVehicleBroken(o)
  local n=n(o,{id="GetVehicleType"})
  local n=e.VEHICLE_BROKEN[n]
  if n then
    PlayRecord.RegistPlayRecord"VEHICLE_DESTROY"Tpp.IncrementPlayData"totalBreakVehicleCount"e.SetAndAnnounceHeroicOgrePoint(n)
  end
end
function e.AnnounceBreakGimmick(n,i,i,o)
  if not Tpp.IsLocalPlayer(o)then
    return
  end
  local n=r(n)
  local n=e.BREAK_GIMMICK[n]
  if n then
    Tpp.IncrementPlayData"totalBreakPlacedGimmickCount"e.SetAndAnnounceHeroicOgrePoint(n)
  end
end
function e.AnnounceBreakGimmickByGimmickType(n)
  local n=e.BREAK_GIMMICK_BY_TYPE[n]
  if n then
    e.SetAndAnnounceHeroicOgrePoint(n)
  end
end
function e.OnHelicopterLostControl(o,n)
  local o=r(o)
  local n=Tpp.IsLocalPlayer(n)
  if o==TppGameObject.GAME_OBJECT_TYPE_HELI2 then
    if n then
      e.SetAndAnnounceHeroicOgrePoint(e.SUPPORT_HELI_LOST_CONTROLE,"destroyed_support_heli")
    else
      e.SetAndAnnounceHeroicOgrePoint(e.BREAK_SUPPORT_HELI,"destroyed_support_heli")
    end
  elseif n then
    PlayRecord.RegistPlayRecord"HERI_DESTROY"Tpp.IncrementPlayData"totalHelicopterDestoryCount"e.SetAndAnnounceHeroicOgrePoint(e.ENEMY_HELI_LOST_CONTROLE)
  end
end
function e.SetAndAnnounceHeroicOgrePointForAnnihilateCp(i,o)
  local n
  if o then
    n="outpost_neutralize"else
    n="guradpost_neutralize"end
  e.SetAndAnnounceHeroicOgrePoint(i,nil,n)
end
function e.SetAndAnnounceHeroicOgrePointForQuestClear(n)
  local n=e.QUEST_CLEAR[n]
  if n then
    e.SetAndAnnounceHeroicOgrePoint(n)
  end
end
function e.HorseRided(n)
  if not Tpp.IsLocalPlayer(n)then
    return
  end
  e.SetAndAnnounceHeroicOgrePoint(e.HORSE_RIDED)
end
function e.OnBreakPlaced(o,n,t,i)
  if vars.missionCode==50050 then
    return
  end
  if not Tpp.IsLocalPlayer(o)then
    return
  end
  if i==1 then
    return
  end
  if TppPlayer.IsDecoy(n)then
    e.SetAndAnnounceHeroicOgrePoint(e.BREAK_DECOY,nil,"disposal_decoy")
  end
  if TppPlayer.IsMine(n)then
    Tpp.IncrementPlayData"totalMineRemoveCount"e.SetAndAnnounceHeroicOgrePoint(e.BREAK_MINE,nil,"disposal_mine")
  end
end
function e.OnPickUpPlaced(i,o,t,n)
  if vars.missionCode==50050 then
    return
  end
  if not Tpp.IsLocalPlayer(i)then
    return
  end
  if n==1 then
    return
  end
  if TppPlayer.IsMine(o)then
    Tpp.IncrementPlayData"totalMineRemoveCount"e.SetAndAnnounceHeroicOgrePoint(e.PICK_UP_MINE,nil,"disposal_mine")
  end
end
function e._RideOnHeli(o)
  if Tpp.IsSoldier(o)then
    local n=n(o,{id="GetStateFlag"})
    if bit.band(n,StateFlag.DYING_LIFE)~=0 then
      e.SetAndAnnounceHeroicOgrePoint(e.ON_HELI_DYING_ENEMY)
    end
  elseif Tpp.IsHostage(o)then
    local n=n(o,{id="GetLifeStatus"})
    if n~=TppEnemy.LIFE_STATUS.DEAD then
      if TppEnemy.IsRescueTarget(o)then
        e.SetAndAnnounceHeroicOgrePoint(e.ON_HELI_RESCUE_TARGET)
      else
        e.SetAndAnnounceHeroicOgrePoint(e.ON_HELI_HOSTAGE)
      end
    end
  end
end
function e.Messages()
  return Tpp.StrCode32Table{GameObject={{msg="Holdup",func=function(o)
    if o then
      if not n(o,{id="IsDoneHoldup"})then
        e.SetAndAnnounceHeroicOgrePoint(e.ENEMY_HOLD_UP)n(o,{id="SetDoneHoldup"})
      end
    end
  end},{msg="InterrogateUpHero",func=function()
    e.SetAndAnnounceHeroicOgrePoint(e.ENEMY_INTERROGATE)
  end},{msg="ChangePhase",func=function(o,n)
    if(vars.missionCode==50050)and(not TppServerManager.FobIsSneak())then
      return
    end
    if(n==TppGameObject.PHASE_ALERT)and Tpp.IsCommandPost(o)then
      e.SetAndAnnounceHeroicOgrePoint(e.STARTED_COMBAT)
    end
  end},{msg="Dead",func=function(gameId,r,_,i)
    if r and Tpp.IsLocalPlayer(r)then
      if Tpp.IsHostage(gameId)then
        if n(gameId,{id="IsDD"})and(not TppMission.IsFOBMission(vars.missionCode))then
          if(i~=nil)and(t(i,DeadMessageFlag.FIRE)~=0)then
            e.SetAndAnnounceHeroicOgrePoint(e.FIRE_KILL_DD_HOSTAGE,"mbstaff_died")
          else
            e.SetAndAnnounceHeroicOgrePoint(e.KILL_DD_HOSTAGE,"mbstaff_died")
          end
        else
          if not n(gameId,{id="IsChild"})then
            if(i~=nil)and(t(i,DeadMessageFlag.FIRE)~=0)then
              e.SetAndAnnounceHeroicOgrePoint(e.FIRE_KILL_HOSTAGE,"hostage_died")
            else
              e.SetAndAnnounceHeroicOgrePoint(e.KILL_HOSTAGE,"hostage_died")
            end
          end
        end
      elseif Tpp.IsSoldier(gameId)then
        Tpp.IncrementPlayData"totalKillCount"
        local soldierType=TppEnemy.GetSoldierType(gameId)
        if(n(gameId,{id="IsDD"}))then
          if(i~=nil)and(t(i,DeadMessageFlag.FIRE)~=0)then
            e.SetAndAnnounceHeroicOgrePoint(e.FIRE_KILL_DD_SOLDIER,"mbstaff_died")
          else
            e.SetAndAnnounceHeroicOgrePoint(e.KILL_DD_SOLDIER,"mbstaff_died")
          end
        else
          if(soldierType~=EnemyType.TYPE_CHILD)then
            local n=DeadMessageFlag.FIRE
            if DeadMessageFlag.FIRE_OR_DYING~=nil then
              n=DeadMessageFlag.FIRE_OR_DYING
            end
            local o=TppMission.IsFOBMission(vars.missionCode)and TppServerManager.FobIsSneak()
            if(i~=nil)and(t(i,n)~=0)then
              if not o then
                e.SetAndAnnounceHeroicOgrePoint(e.FIRE_KILL_SOLDIER)
              else
                e.SetAndAnnounceHeroicOgrePoint(e.FIRE_KILL_SOLDIER_FOB_SNEAK)
              end
            else
              if not o then
                e.SetAndAnnounceHeroicOgrePoint(e.KILL_SOLDIER)
              else
                e.SetAndAnnounceHeroicOgrePoint(e.KILL_SOLDIER_FOB_SNEAK)
              end
            end
          end
        end
      end
      if Tpp.IsAnimal(gameId)then
        if(i~=nil)and(t(i,DeadMessageFlag.FIRE)~=0)then
          e.SetAndAnnounceHeroicOgrePoint{heroicPoint=0,ogrePoint=40}
        else
          e.SetAndAnnounceHeroicOgrePoint{heroicPoint=0,ogrePoint=20}
        end
      end
    else
      if Tpp.IsHostage(gameId)then
        if n(gameId,{id="IsDD"})and(not TppMission.IsFOBMission(vars.missionCode))then
          e.SetAndAnnounceHeroicOgrePoint(e.DEAD_DD_SOLDIER,"mbstaff_died")
        else
          if not n(gameId,{id="IsChild"})then
            e.SetAndAnnounceHeroicOgrePoint(e.DEAD_HOSTAGE,"hostage_died")
          end
        end
      elseif Tpp.IsSoldier(gameId)then
        if TppMission.IsFOBMission(vars.missionCode)then
        else
          if(n(gameId,{id="IsDD"}))then
            e.SetAndAnnounceHeroicOgrePoint(e.DEAD_DD_SOLDIER,"mbstaff_died")
          end
        end
      end
    end
  end},{msg="Dying",func=function(o,i)
    if Tpp.IsSoldier(o)then
      if not n(o,{id="IsDD"})then
        e.SetAndAnnounceHeroicOgrePoint(e.DYING_SOLDIER)
      end
    elseif Tpp.IsParasiteSquad(o)then
      e.SetAndAnnounceHeroicOgrePoint(e.DYING_PARASITE,"destroyed_skull","destroyed_skull")
    elseif Tpp.IsBossQuiet(o)then
      local n=n({type="TppBossQuiet2"},{id="GetQuietType"})
      if n==Fox.StrCode32"Cam"then
        e.SetAndAnnounceHeroicOgrePoint(e.DYING_PARASITE,"destroyed_skull","destroyed_skull")
      end
    end
  end},{msg="BreakGimmick",func=e.AnnounceBreakGimmick},{msg="VehicleBroken",func=function(o,n)
    if n==_"Start"then
      e.AnnounceVehicleBroken(o)
    end
  end},{msg="LostControl",func=function(i,o,n)
    if o==_"Start"then
      e.OnHelicopterLostControl(i,n)
    end
  end},{msg="CommandPostAnnihilated",func=function(n,o,i)
    local o=false
    if mvars.ene_cpList then
      local e=mvars.ene_cpList[n]o=TppTrophy.DOMINATION_TARGET_CP_NAME_LIST[e]
    end
    if i==0 then
      if TppEnemy.IsBaseCp(n)then
        if o then
          PlayRecord.RegistPlayRecord"BASE_SUPPRESSION"e.SetAndAnnounceHeroicOgrePointForAnnihilateCp(e.ON_ANNIHILATE_BASE,true)
          TppTrophy.Unlock(18)
          Tpp.IncrementPlayData"totalAnnihilateBaseCount"end
        TppEmblem.AcquireOnCommandPostAnnihilated(n)
      elseif TppEnemy.IsOuterBaseCp(n)then
        if o then
          e.SetAndAnnounceHeroicOgrePointForAnnihilateCp(e.ON_ANNIHILATE_OUTER_BASE,false)
          Tpp.IncrementPlayData"totalAnnihilateOutPostCount"TppTrophy.Unlock(18)
        end
        TppEmblem.AcquireOnCommandPostAnnihilated(n)
      end
    end
    if TppCommandPost2.SetCpDominated then
      local e=TppLocation.GetLocationName()
      if e=="afgh"or e=="mafr"then
        local n=mvars.ene_cpList[n]
        local i=TppCommandPost2.SetCpDominated{cpName=n,type=e}
        local n=TppCommandPost2.GetDominatedCpCount{type=e}
        local o=TppTrophy.DOMINATION_TARGET_CP_COUNT[e]
        if i then
        end
        if n==o then
          local n={afgh=19,mafr=20}
          TppTrophy.Unlock(n[e])
        end
      end
    end
  end}},Player={{msg="OnInjury",func=function()
    e.SetAndAnnounceHeroicOgrePoint(e.PLAYER_ON_INJURY)
  end},{msg="DogBiteConnect",func=e.HorseRided},{msg="ZombBiteConnect",func=e.HorseRided},{msg="OnPickUpPlaced",func=e.OnPickUpPlaced},{msg="LiquidPutInHeli",func=function(n)
    e.SetAndAnnounceHeroicOgrePoint(e.ON_HELI_LIQUID)
  end}},Placed={{msg="OnBreakPlaced",func=e.OnBreakPlaced}}}
end
function e.Init(n)
  e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnReload(n)
  e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnMessage(t,i,o,n,r,c,_)
  Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,t,i,o,n,r,c,_)
end
function e.DeclareSVars()
  return{{name="her_missionOgrePoint",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},{name="her_missionHeroPoint",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function e.UpdateHero()
  local n=gvars.isHero
  local e=TppMotherBaseManagement.GetHeroicPoint()
  if(e>=vars.mbmHeroThreshold)then
    gvars.isHero=true
  end
  if(e<vars.mbmNotHeroThreshold)then
    gvars.isHero=false
  end
  if(TppStory.GetCurrentStorySequence()<TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO)then
    gvars.isHero=false
  end
  if(not n)and gvars.isHero then
    TppUI.ShowAnnounceLog"get_hero"end
  if n and(not gvars.isHero)then
    TppUI.ShowAnnounceLog"lost_hero"end
  if gvars.isHero then
    TppTrophy.Unlock(46,3e4)
    local e={"word80","word81","word82","word83","word84","word85","word86","word88","word89","front40","front41"}
    for n,e in ipairs(e)do
      TppEmblem.Add(e,true)
    end
  end
end
return e
