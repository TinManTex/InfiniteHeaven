local e={}
local r=GameObject.GetGameObjectId
local r=GameObject.GetTypeIndex
local n=GameObject.SendCommand
local r=GameObject.NULL_ID
e.REINFORCE_TYPE_NAME={"NONE","EAST_WAV","EAST_WAV_ROCKET","WEST_WAV","WEST_WAV_CANNON","EAST_TANK","WEST_TANK","HELI"}
e.REINFORCE_TYPE=TppDefine.Enum(e.REINFORCE_TYPE_NAME)
e.REINFORCE_FPK={[e.REINFORCE_TYPE.NONE]="",[e.REINFORCE_TYPE.EAST_WAV]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_wav.fpk",[e.REINFORCE_TYPE.EAST_WAV_ROCKET]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_wav_roc.fpk",[e.REINFORCE_TYPE.WEST_WAV]={PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_a.fpk",PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_b.fpk",PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_c.fpk"},[e.REINFORCE_TYPE.WEST_WAV_CANNON]={PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_a.fpk",PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_b.fpk",PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_c.fpk"},[e.REINFORCE_TYPE.EAST_TANK]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_tnk.fpk",[e.REINFORCE_TYPE.WEST_TANK]={PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_a.fpk",PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_b.fpk",PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_c.fpk"},[e.REINFORCE_TYPE.HELI]={AFGH={_DEFAULT="/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk",[TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk"},[TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk"}},MAFR={_DEFAULT="/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk",[TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk"},[TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk"}}}}
e.REINFORCE_VEHICLE_NAME="reinforce_vehicle_0000"
e.REINFORCE_DRIVER_SOLDIER_NAME="reinforce_soldier_driver"
e.REINFORCE_SOLDIER_NAMES={"reinforce_soldier_0000","reinforce_soldier_0001","reinforce_soldier_0002","reinforce_soldier_0003"}
e.REINFORCE_HELI_NAME="EnemyHeli"
function e.GetReinforceBlockId()
  return ScriptBlock.GetScriptBlockId(mvars.reinforce_reinforceBlockName)
end
function e.GetReinforceBlockState()
  return ScriptBlock.GetScriptBlockState(e.GetReinforceBlockId())
end
function e.IsLoaded()
  return e.GetReinforceBlockState()==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY
end
function e.IsProcessing()
  return e.GetReinforceBlockState()==ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING
end
function e.GetFpk(r,i,n)
  local e=e.REINFORCE_FPK[r]if Tpp.IsTypeTable(e)then
    local r=""
    if TppLocation.IsAfghan()then
      r="AFGH"
    elseif TppLocation.IsMiddleAfrica()then
      r="MAFR"
    end
    local r=e[i]or e[r]if Tpp.IsTypeTable(r)then
      n=n or"_DEFAULT"
      if r[n]then
        r=r[n]else
        r=nil
      end
    end
    if r then
      e=r
    else
      local r=""
      for i,n in pairs(e)do
        if r==""then
          r=n
        end
      end
      e=r
    end
  end
  if not e then
    return""
  end
  return e
end
function e.SetUpReinforceBlock()mvars.reinforce_reinforceBlockName="reinforce_block"
  local n=false
  local i=e.GetReinforceBlockId()n=(i~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID)mvars.reinforce_hasReinforceBlock=n
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  for n,r in ipairs(e.REINFORCE_SOLDIER_NAMES)do
    e._SetEnabledSoldier(r,false)
  end
  e._SetEnabledVehicle(e.REINFORCE_VEHICLE_NAME,false)mvars.reinforce_reinforceType=e.REINFORCE_TYPE.NONE
  mvars.reinforce_reinforceColoringType=nil
  mvars.reinforce_reinforceCpId=r
  mvars.reinforce_activated=false
end
function e.LoadReinforceBlock(i,o,t)
  if mvars.reinforce_activated then
    return
  end
  if mvars.reinforce_reinforceCpId~=r and mvars.reinforce_reinforceCpId~=o then
    return
  end
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  if i==e.REINFORCE_TYPE.HELI and GameObject.DoesGameObjectExistWithTypeName"TppEnemyHeli"then
    return
  end
  local a=e.GetReinforceBlockId()
  local c=TppEnemy.GetCpSubType(mvars.reinforce_cpId)
  local c=e.GetFpk(i,c,t)
  if c==nil then
    i=e.REINFORCE_TYPE.NONE
    c=""
  end
  ScriptBlock.Load(a,c)mvars.reinforce_reinforceType=i
  mvars.reinforce_reinforceColoringType=t
  if i~=e.REINFORCE_TYPE.NONE then
    n({type="TppCommandPost2"},{id="SetReinforceEnable"})mvars.reinforce_reinforceCpId=o
    local o=e._HasVehicle()
    local t=e._HasSoldier()
    local c,i
    local r={}
    if t then
      for n,e in ipairs(e.REINFORCE_SOLDIER_NAMES)do
        r[n]=GameObject.GetGameObjectId("TppSoldier2",e)
      end
    end
    if o then
      c=GameObject.GetGameObjectId("TppVehicle2",e.REINFORCE_VEHICLE_NAME)i=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_DRIVER_SOLDIER_NAME)
    end
    n({type="TppCommandPost2"},{id="SetNominateList",driver=i,vehicle=c,sol01=r[1],sol02=r[2],sol03=r[3],sol04=r[4]})
  else
    mvars.reinforce_reinforceCpId=r
  end
end
function e.UnloadReinforceBlock(n)
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  if((n~=nil and n~=r)and mvars.reinforce_reinforceCpId~=r)and mvars.reinforce_reinforceCpId~=n then
    return
  end
  local n=e.GetReinforceBlockId()
  if e.GetReinforceBlockState()>ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE then
    e.ReinforceBlockOnDeactivate()
  end
  ScriptBlock.Load(n,"")mvars.reinforce_reinforceType=e.REINFORCE_TYPE.NONE
  mvars.reinforce_reinforceColoringType=nil
  mvars.reinforce_reinforceCpId=r
end
function e.StartReinforce(n)
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  if mvars.reinforce_reinforceType==e.REINFORCE_TYPE.NONE then
    return
  end
  if(n~=nil and n~=r)and mvars.reinforce_reinforceCpId~=n then
    return
  end
  local e=e.GetReinforceBlockId()ScriptBlock.Activate(e)mvars.reinforce_activated=true
end
function e.FinishReinforce(n)
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  if(n~=nil and n~=r)and mvars.reinforce_reinforceCpId~=n then
    return
  end
  local e=e.GetReinforceBlockId()ScriptBlock.Deactivate(e)mvars.reinforce_activated=false
  mvars.reinforce_reinforceCpId=r
end
function e.ReinforceBlockOnInitialize()mvars.reinforce_lastReinforceBlockState=e.GetReinforceBlockState()mvars.reinforce_isEnabledVehicle=false
  mvars.reinforce_isEnabledSoldiers=false
end
function e.ReinforceBlockOnUpdate()
  local n=e.GetReinforceBlockState()
  if n==nil then
    return
  end
  local c=ScriptBlock
  local r=mvars
  local i=r.reinforce_lastReinforceBlockState
  local o=c.SCRIPT_BLOCK_STATE_INACTIVE
  local c=c.SCRIPT_BLOCK_STATE_ACTIVE
  if n==o then
    if i==c then
      e.ReinforceBlockOnDeactivate()
    end
    r.reinforce_lastReinforceInactiveToActive=false
  elseif n==c then
    if r.reinforce_lastReinforceInactiveToActive then
      r.reinforce_lastReinforceInactiveToActive=false
      e.ReinforceBlockOnActivate()
    end
    if(not i)or i<=o then
      r.reinforce_lastReinforceInactiveToActive=true
    end
  end
  r.reinforce_lastReinforceBlockState=n
end
function e.ReinforceBlockOnActivate()e._ActivateReinforce()
end
function e.ReinforceBlockOnDeactivate()e._DeactivateReinforce()
end
function e.ReinforceBlockOnTerminate()
end
function e._HasSoldier()
  if((mvars.reinforce_reinforceType==e.REINFORCE_TYPE.HELI or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.EAST_WAV_ROCKET)or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.EAST_TANK)or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.WEST_TANK then
    return false
  end
  return true
end
function e._HasVehicle()
  if((((mvars.reinforce_reinforceType==e.REINFORCE_TYPE.EAST_WAV or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.EAST_WAV_ROCKET)or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.WEST_WAV)or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.WEST_WAV_CANNON)or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.EAST_TANK)or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.WEST_TANK then
    return true
  end
  return false
end
function e._HasHeli()
  if mvars.reinforce_reinforceType==e.REINFORCE_TYPE.HELI then
    return true
  end
  return false
end
function e._GetHeliRoute(e)
  return"reinforce_heli_route_0000"
end
function e._SetEnabledSoldier(e,i)
  local e=GameObject.GetGameObjectId(e)
  if e==r then
    return
  end
  n(e,{id="SetEnabled",enabled=i})
end
function e._SetEnabledVehicle(c,o)
  local i=GameObject.GetGameObjectId(c)
  if i==r then
    return
  end
  if o then
    local r
    if mvars.reinforce_reinforceType==e.REINFORCE_TYPE.EAST_WAV_ROCKET then
      r=Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY
    elseif mvars.reinforce_reinforceType==e.REINFORCE_TYPE.WEST_WAV then
      r=Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN
    elseif mvars.reinforce_reinforceType==e.REINFORCE_TYPE.WEST_WAV_CANNON then
      r=Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON
    end
    local e=TppEnemy.GetCpSubType(mvars.reinforce_cpId)
    local o=Vehicle.paintType.NONE
    if(e=="PF_A"or e=="PF_B")or e=="PF_C"then
      o=Vehicle.paintType.FOVA_0
    end
    local e=nil
    if mvars.reinforce_reinforceColoringType then
      e=mvars.reinforce_reinforceColoringType
    end
    local e={id="Respawn",name=c,type=9,subType=r,paintType=o,class=e}n(i,e)
  else
    n(i,{id="Despawn",name=c,type=9})
  end
end
function e._ActivateReinforce()
  local E=e._HasVehicle()
  local l=e._HasSoldier()
  local f=e._HasHeli()
  local _,a,i,c,t,o
  local r={}
  if l then
    mvars.reinforce_isEnabledSoldiers=true
    for n,r in ipairs(e.REINFORCE_SOLDIER_NAMES)do
      e._SetEnabledSoldier(r,true)
    end
    i=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_SOLDIER_NAMES[1])c=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_SOLDIER_NAMES[2])t=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_SOLDIER_NAMES[3])o=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_SOLDIER_NAMES[4])table.insert(r,i)table.insert(r,c)table.insert(r,t)table.insert(r,o)
  end
  if E then
    mvars.reinforce_isEnabledVehicle=true
    e._SetEnabledVehicle(e.REINFORCE_VEHICLE_NAME,true)e._SetEnabledSoldier(e.REINFORCE_DRIVER_SOLDIER_NAME,true)_=GameObject.GetGameObjectId("TppVehicle2",e.REINFORCE_VEHICLE_NAME)a=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_DRIVER_SOLDIER_NAME)table.insert(r,a)
  end
  if f then
    local r=GameObject.GetGameObjectId(e.REINFORCE_HELI_NAME)
    local e=e._GetHeliRoute(mvars.reinforce_cpId)
    local e=mvars.ene_cpList[mvars.reinforce_reinforceCpId]n(r,{id="RequestReinforce",toCp=e})n(r,{id="SetCommandPost",cp=e})
    if mvars.reinforce_reinforceColoringType then
      TppHelicopter.SetEnemyColoring(mvars.reinforce_reinforceColoringType)
    end
  end
  TppRevenge.ApplyPowerSettingsForReinforce(r)
  GameObject.SendCommand({type="TppCommandPost2"},{id="SetReinforcePrepared"})
end
function e._DeactivateReinforce()
  if mvars.reinforce_isEnabledSoldiers then
    mvars.reinforce_isEnabledSoldiers=false
    for n,r in ipairs(e.REINFORCE_SOLDIER_NAMES)do
      e._SetEnabledSoldier(r,false)
    end
  end
  if mvars.reinforce_isEnabledVehicle then
    mvars.reinforce_isEnabledVehicle=false
    e._SetEnabledVehicle(e.REINFORCE_VEHICLE_NAME,false)e._SetEnabledSoldier(e.REINFORCE_DRIVER_SOLDIER_NAME,false)
  end
  GameObject.SendCommand({type="TppCommandPost2"},{id="SetNominateList"})
end
function e.Messages()
  return Tpp.StrCode32Table{GameObject={{msg="RequestLoadReinforce",func=e._OnRequestLoadReinforce},{msg="RequestAppearReinforce",func=e._OnRequestAppearReinforce},{msg="CancelReinforce",func=e._OnCancelReinforce}}}
end
function e.Init(r)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnReload(r)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnMessage(r,n,a,o,t,c,i)
  Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,r,n,a,o,t,c,i)
end
function e._OnRequestLoadReinforce(i)
  local n=TppRevenge.SelectReinforceType()
  local r
  if TppRevenge.IsUsingBlackSuperReinforce()then
    if n==e.REINFORCE_TYPE.HELI then
      r=TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK
    else
      r=Vehicle.class.DARK_GRAY
    end
  end
  e.LoadReinforceBlock(n,i,r)
end
function e._OnRequestAppearReinforce(r)e.StartReinforce(r)
end
function e._OnCancelReinforce(r)
  if mvars.reinforce_activated then
    return
  end
  e.FinishReinforce(r)
end
return e
