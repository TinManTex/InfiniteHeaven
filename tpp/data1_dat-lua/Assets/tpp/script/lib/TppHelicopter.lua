local e={}
local n=Fox.StrCode32
local t=Tpp.IsTypeTable
local i=Tpp.IsTypeString
local a=GameObject.SendCommand
local o=GameObject.GetGameObjectId
local n=GameObject.NULL_ID
local this=e--DEMINDEF:
local StrCode32=n
local IsTypeTable=t
local IsTypeString=i
local SendCommand=a
local GetGameObjectId=o
local NULL_ID=n
--
function this.GetSupportHeliGameObjectId()
  if not mvars.hel_isExistSupportHelicopter then
    return
  end
  return GameObject.GetGameObjectId("TppHeli2","SupportHeli")
end
function this.SetNoSupportHelicopter()
  mvars.hel_isExistSupportHelicopter=false
end
function this.UnsetNoSupportHelicopter()
  mvars.hel_isExistSupportHelicopter=true
end
function this.ForceCallToLandingZone(a)
  if not IsTypeTable(a)then
    return
  end
  local landingZoneName=a.landingZoneName
  if not IsTypeString(landingZoneName)then
    return
  end
  if not mvars.hel_isExistSupportHelicopter then
    return
  end
  local gameId=this.GetSupportHeliGameObjectId()
  if gameId~=n then
    GameObject.SendCommand(gameId,{id="CallToLandingZoneAtName",name=landingZoneName})
    GameObject.SendCommand(gameId,{id="DisablePullOut"})
    GameObject.SendCommand(gameId,{id="EnableDescentToLandingZone"})
  else
    return
  end
end
function this.CallToLandingZone(a)
  if not IsTypeTable(a)then
    return
  end
  local landingZoneName=a.landingZoneName
  if not IsTypeString(landingZoneName)then
    return
  end
  if not mvars.hel_isExistSupportHelicopter then
    return
  end
  local gameId=this.GetSupportHeliGameObjectId()
  if gameId~=n then
    GameObject.SendCommand(gameId,{id="CallToLandingZoneAtName",name=landingZoneName})
    GameObject.SendCommand(gameId,{id="EnableDescentToLandingZone"})
  else
    return
  end
end
function this.SetEnableLandingZone(a)
  if not IsTypeTable(a)then
    return
  end
  local landingZoneName=a.landingZoneName
  if not IsTypeString(landingZoneName)then
    return
  end
  if not mvars.hel_isExistSupportHelicopter then
    return
  end
  local gameId=this.GetSupportHeliGameObjectId()
  if gameId~=n then
    GameObject.SendCommand(gameId,{id="EnableLandingZone",name=landingZoneName})
  else
    return
  end
end
function this.SetDisableLandingZone(landingZoneName)
  if not IsTypeTable(landingZoneName)then
    return
  end
  local t=landingZoneName.landingZoneName
  if not IsTypeString(t)then
    return
  end
  if not mvars.hel_isExistSupportHelicopter then
    return
  end
  local e=this.GetSupportHeliGameObjectId()
  if e~=n then
    GameObject.SendCommand(e,{id="DisableLandingZone",name=t})
  else
    return
  end
end
function this.GetLandingZoneExists(a)
  if not IsTypeTable(a)then
    return
  end
  local t=a.landingZoneName
  if not IsTypeString(t)then
    return
  end
  if not mvars.hel_isExistSupportHelicopter then
    return
  end
  local e=this.GetSupportHeliGameObjectId()
  if e~=n then
    return GameObject.SendCommand(e,{id="DoesLandingZoneExists",name=t})
  else
    return false
  end
end
function this.SetNewestPassengerTable()
  if not mvars.hel_isExistSupportHelicopter then
    this.ClearPassengerTable()
    return
  end
  local passengerIds
  local e=this.GetSupportHeliGameObjectId()
  if e~=n then
    passengerIds=SendCommand(e,{id="GetPassengerIdsStaffOnly"})
    mvars.hel_passengerListGameObjectId=e
  else
    return
  end
  if not IsTypeTable(passengerIds)or next(passengerIds)==nil then
    return
  end
  mvars.hel_heliPassengerTable={}
  for n,e in ipairs(passengerIds)do
    mvars.hel_heliPassengerTable[e]=true
  end
  mvars.hel_heliPassengerList=passengerIds
  mvars.hel_passengerListGameObjectId=e
end
function this.GetPassengerlist()
  return mvars.hel_heliPassengerList
end
function this.ClearPassengerTable()
  if mvars.hel_passengerListGameObjectId then
    SendCommand(mvars.hel_passengerListGameObjectId,{id="InitializePassengers"})
  end
  mvars.hel_passengerListGameObjectId=nil
  mvars.hel_heliPassengerTable=nil
  mvars.hel_heliPassengerList=nil
end
function this.IsInHelicopter(n)
  if not IsTypeTable(mvars.hel_heliPassengerTable)then
    return
  end
  local e
  if Tpp.IsTypeString(n)then
    e=GetGameObjectId(n)
  else
    e=n
  end
  return mvars.hel_heliPassengerTable[e]
end
function this.ForcePullOut()
  GameObject.SendCommand({type="TppHeli2",index=0},{id="PullOut",forced=true})
end
function this.AdjustBuddyDropPoint()
  if gvars.heli_missionStartRoute~=0 then
    TppBuddyService.AdjustFromDropPoint(gvars.heli_missionStartRoute,EntryBuddyType.BUDDY,6,3.14)
    TppBuddyService.AdjustFromDropPoint(gvars.heli_missionStartRoute,EntryBuddyType.VEHICLE,6,0)
  end
end
function this.Init(t)
  local gameId=GetGameObjectId("TppHeli2","SupportHeli")
  if gameId==NULL_ID then
    mvars.hel_isExistSupportHelicopter=false
    return
  end
  mvars.hel_isExistSupportHelicopter=true
  if TppMission.IsCanMissionClear()then
    this.SetNoTakeOffTime()
  else
    this.SetDefaultTakeOffTime()
  end
  if gvars.ply_initialPlayerState~=TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER then
    return
  end
  local helicopterRouteList=nil
  if(t.sequence and t.sequence.missionStartPosition)and t.sequence.missionStartPosition.helicopterRouteList then
    if not Tpp.IsTypeFunc(t.sequence.missionStartPosition.IsUseRoute)or t.sequence.missionStartPosition.IsUseRoute()then
      helicopterRouteList=t.sequence.missionStartPosition.helicopterRouteList
    end
  end
  if helicopterRouteList==nil then
    return
  end
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    GameObject.SendCommand(gameId,{id="Realize"})
  else
    if gvars.heli_missionStartRoute~=0 then
      if not svars.ply_isUsedPlayerInitialAction then
        GameObject.SendCommand(gameId,{id="SendPlayerAtRouteReady",route=gvars.heli_missionStartRoute})
      end
    end
  end
end
function this.SetDefaultTakeOffTime()
  local e=this.GetSupportHeliGameObjectId()
  if(e==nil)then
    return
  end
  if e==n then
    return
  end
  GameObject.SendCommand(e,{id="SetTakeOffWaitTime",time=5})
end
function this.SetNoTakeOffTime()
  local e=this.GetSupportHeliGameObjectId()
  if(e==nil)then
    return
  end
  if e==n then
    return
  end
  GameObject.SendCommand(e,{id="SetTakeOffWaitTime",time=0})
end
function this.SetRouteToHelicopterOnStartMission()
  local e=this.GetSupportHeliGameObjectId()
  if(e==nil)then
    return
  end
  if e==n then
    return
  end
  if gvars.heli_missionStartRoute~=0 then
    GameObject.SendCommand(e,{id="SendPlayerAtRouteStart",isAssault=TppLandingZone.IsAssaultDropLandingZone(gvars.heli_missionStartRoute)})
  end
end
function this.ResetMissionStartHelicopterRoute()
  gvars.heli_missionStartRoute=0
end
function this.GetMissionStartHelicopterRoute()
  return gvars.heli_missionStartRoute
end
local heliColors={[TppDefine.ENEMY_HELI_COLORING_TYPE.DEFAULT]={pack="",fova=""},[TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={pack="/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk",fova="/Assets/tpp/fova/mecha/sbh/sbh_ene_blk.fv2"},[TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={pack="/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk",fova="/Assets/tpp/fova/mecha/sbh/sbh_ene_red.fv2"}}
function this.GetEnemyColoringPack(heliColoringType)
  return heliColors[heliColoringType].pack
end
function this.SetEnemyColoring(heliColoringType)
  SendCommand({type="TppEnemyHeli",index=0},{id="SetColoring",coloringType=heliColoringType,fova=heliColors[heliColoringType].fova})
end
return this
