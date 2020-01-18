local e={}
--local jj=SplashScreen.Create("jj","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5010_l_alp.ftex",1280,640)  
--SplashScreen.Show(jj,0,0.5,0)--tex spider
local r=GameObject.GetGameObjectId
local r=GameObject.GetTypeIndex
local n=GameObject.SendCommand
local nullId=GameObject.NULL_ID
local this=e--tex DEMINIFY:
local r=nullId--
e.REINFORCE_TYPE_NAME={"NONE","EAST_WAV","EAST_WAV_ROCKET","WEST_WAV","WEST_WAV_CANNON","EAST_TANK","WEST_TANK","HELI"}
e.REINFORCE_TYPE=TppDefine.Enum(e.REINFORCE_TYPE_NAME)
e.REINFORCE_FPK={
  [e.REINFORCE_TYPE.NONE]="",
  [e.REINFORCE_TYPE.EAST_WAV]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_wav.fpk",
  [e.REINFORCE_TYPE.EAST_WAV_ROCKET]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_wav_roc.fpk",
  [e.REINFORCE_TYPE.WEST_WAV]={
    PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_a.fpk",
    PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_b.fpk",
    PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_c.fpk"},
  [e.REINFORCE_TYPE.WEST_WAV_CANNON]={
    PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_a.fpk",
    PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_b.fpk",
    PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_c.fpk"},
  [e.REINFORCE_TYPE.EAST_TANK]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_tnk.fpk",
  [e.REINFORCE_TYPE.WEST_TANK]={
    PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_a.fpk",
    PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_b.fpk",
    PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_c.fpk"},
  [e.REINFORCE_TYPE.HELI]={
    AFGH={
      _DEFAULT="/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk",
      [TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk"},
      [TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk"}},
    MAFR={
      _DEFAULT="/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk",
      [TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk"},
      [TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk"}
    }
  }
}
e.REINFORCE_VEHICLE_NAME="reinforce_vehicle_0000"
e.REINFORCE_DRIVER_SOLDIER_NAME="reinforce_soldier_driver"
e.REINFORCE_SOLDIER_NAMES={"reinforce_soldier_0000","reinforce_soldier_0001","reinforce_soldier_0002","reinforce_soldier_0003"}
e.REINFORCE_HELI_NAME="EnemyHeli"
function this.GetReinforceBlockId()
  return ScriptBlock.GetScriptBlockId(mvars.reinforce_reinforceBlockName)
end
function this.GetReinforceBlockState()
  return ScriptBlock.GetScriptBlockState(e.GetReinforceBlockId())
end
function this.IsLoaded()
  return e.GetReinforceBlockState()==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY
end
function this.IsProcessing()
  return e.GetReinforceBlockState()==ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING
end
function this.GetFpk(vehicleType,cpType,color)
  local vehicleFpks=this.REINFORCE_FPK[vehicleType]
  if Tpp.IsTypeTable(vehicleFpks)then
    local location=""
    if TppLocation.IsAfghan()then
      location="AFGH"
    elseif TppLocation.IsMiddleAfrica()then
      location="MAFR"
    end
    local cpOrColor=vehicleFpks[cpType]or vehicleFpks[vehicleType]
    if Tpp.IsTypeTable(r)then
      color=color or"_DEFAULT"
      if cpOrColor[color]then
        cpOrColor=cpOrColor[color]
      else
        cpOrColor=nil
      end
    end
    if cpOrColor then
      vehicleFpks=cpOrColor
    else
      local def=""
      for i,fpk in pairs(vehicleFpks)do
        if def==""then
          def=fpk
        end
      end
      vehicleFpks=def
    end
  end
  if not vehicleFpks then
    return""
  end
  return vehicleFpks
end
function this.SetUpReinforceBlock()
  mvars.reinforce_reinforceBlockName="reinforce_block"
  local n=false
  local i=e.GetReinforceBlockId()
  n=(i~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID)
  mvars.reinforce_hasReinforceBlock=n
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  for n,r in ipairs(e.REINFORCE_SOLDIER_NAMES)do
    e._SetEnabledSoldier(r,false)
  end
  e._SetEnabledVehicle(e.REINFORCE_VEHICLE_NAME,false)
  mvars.reinforce_reinforceType=e.REINFORCE_TYPE.NONE
  mvars.reinforce_reinforceColoringType=nil
  mvars.reinforce_reinforceCpId=nullId
  mvars.reinforce_activated=false
end
function this.LoadReinforceBlock(vehicleType,commandPostId,color)
  if mvars.reinforce_activated then
    return
  end
  if mvars.reinforce_reinforceCpId~=nullId and mvars.reinforce_reinforceCpId~=commandPostId then
    return
  end
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  if vehicleType==this.REINFORCE_TYPE.HELI and GameObject.DoesGameObjectExistWithTypeName"TppEnemyHeli"then
    return
  end
  local a=e.GetReinforceBlockId()
  local cpType=TppEnemy.GetCpSubType(mvars.reinforce_cpId)
  local fpkPath=this.GetFpk(vehicleType,cpType,color)
  if fpkPath==nil then
    vehicleType=e.REINFORCE_TYPE.NONE
    fpkPath=""
  end  
  ScriptBlock.Load(a,fpkPath)
  mvars.reinforce_reinforceType=vehicleType
  mvars.reinforce_reinforceColoringType=color
  if vehicleType~=this.REINFORCE_TYPE.NONE then
    n({type="TppCommandPost2"},{id="SetReinforceEnable"})
    mvars.reinforce_reinforceCpId=commandPostId
    local hasVehicle=this._HasVehicle()
    local t=this._HasSoldier()
    local c,i
    local r={}
    if t then
      for n,e in ipairs(e.REINFORCE_SOLDIER_NAMES)do
        r[n]=GameObject.GetGameObjectId("TppSoldier2",e)
      end
    end
    if hasVehicle then
      c=GameObject.GetGameObjectId("TppVehicle2",this.REINFORCE_VEHICLE_NAME)
      i=GameObject.GetGameObjectId("TppSoldier2",this.REINFORCE_DRIVER_SOLDIER_NAME)
    end
    n({type="TppCommandPost2"},{id="SetNominateList",driver=i,vehicle=c,sol01=r[1],sol02=r[2],sol03=r[3],sol04=r[4]})
  else
    mvars.reinforce_reinforceCpId=nullId
  end
end
function this.UnloadReinforceBlock(n)
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  if((n~=nil and n~=nullId)and mvars.reinforce_reinforceCpId~=nullId)and mvars.reinforce_reinforceCpId~=n then
    return
  end
  local n=e.GetReinforceBlockId()
  if e.GetReinforceBlockState()>ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE then
    e.ReinforceBlockOnDeactivate()
  end
  ScriptBlock.Load(n,"")
  mvars.reinforce_reinforceType=e.REINFORCE_TYPE.NONE
  mvars.reinforce_reinforceColoringType=nil
  mvars.reinforce_reinforceCpId=nullId
end
function this.StartReinforce(cpId)
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  if mvars.reinforce_reinforceType==e.REINFORCE_TYPE.NONE then
    return
  end 
  if(cpId~=nil and cpId~=nullId)and mvars.reinforce_reinforceCpId~=cpId then
    return
  end
  local e=e.GetReinforceBlockId()
  ScriptBlock.Activate(e)
  mvars.reinforce_activated=true
end
function this.FinishReinforce(n)
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  if(n~=nil and n~=nullId)and mvars.reinforce_reinforceCpId~=n then
    return
  end
  local e=e.GetReinforceBlockId()
  ScriptBlock.Deactivate(e)
  mvars.reinforce_activated=false
  mvars.reinforce_reinforceCpId=nullId
end
function this.ReinforceBlockOnInitialize()
  mvars.reinforce_lastReinforceBlockState=e.GetReinforceBlockState()
  mvars.reinforce_isEnabledVehicle=false
  mvars.reinforce_isEnabledSoldiers=false
end
function this.ReinforceBlockOnUpdate()
  local blockState=this.GetReinforceBlockState()
  if blockState==nil then
    return
  end
  local lastReinforceBlockState=mvars.reinforce_lastReinforceBlockState
  local STATE_INACTIVE=ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE
  local STATE_ACTIVE=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
  if blockState==STATE_INACTIVE then
    if lastReinforceBlockState==STATE_ACTIVE then
      this.ReinforceBlockOnDeactivate()
    end
    mvars.reinforce_lastReinforceInactiveToActive=false
  elseif blockState==STATE_ACTIVE then
    if mvars.reinforce_lastReinforceInactiveToActive then
      mvars.reinforce_lastReinforceInactiveToActive=false
      this.ReinforceBlockOnActivate()
    end
    if(not lastReinforceBlockState)or lastReinforceBlockState<=STATE_INACTIVE then
      mvars.reinforce_lastReinforceInactiveToActive=true
    end
  end
  mvars.reinforce_lastReinforceBlockState=blockState
end
function this.ReinforceBlockOnActivate()
  e._ActivateReinforce()
end
function this.ReinforceBlockOnDeactivate()
  e._DeactivateReinforce()
end
function this.ReinforceBlockOnTerminate()
end
function this._HasSoldier()
  if((mvars.reinforce_reinforceType==e.REINFORCE_TYPE.HELI or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.EAST_WAV_ROCKET)or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.EAST_TANK)or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.WEST_TANK then
    return false
  end
  return true
end
function this._HasVehicle()
  --[[local allowedTypes={--tex NMC: refactored
    this.REINFORCE_TYPE.EAST_WAV,
    this.REINFORCE_TYPE.EAST_WAV_ROCKET,
    this.REINFORCE_TYPE.WEST_WAV,
    this.REINFORCE_TYPE.WEST_WAV_CANNON,
    this.REINFORCE_TYPE.EAST_TANK,
    this.REINFORCE_TYPE.WEST_TANK,
  }--]]
  --if mvars.reinforce_reinforceType~=this.REINFORCE_TYPE.none and mvars.reinforce_reinforceType~=this.REINFORCE_TYPE.HELI then--tex fuck it, just take the easy way rather than process ASSUMPTION: no new types added that we dont want as reinforce.
   --tex was -v- i don't know wtf, if there's some kind of voodoo logic to it? 
   if((((mvars.reinforce_reinforceType==e.REINFORCE_TYPE.EAST_WAV or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.EAST_WAV_ROCKET)or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.WEST_WAV)or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.WEST_WAV_CANNON)or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.EAST_TANK)or mvars.reinforce_reinforceType==e.REINFORCE_TYPE.WEST_TANK then
    return true
  end
  return false
end
function this._HasHeli()
  if mvars.reinforce_reinforceType==e.REINFORCE_TYPE.HELI then
    return true
  end
  return false
end
function this._GetHeliRoute(e)
  return"reinforce_heli_route_0000"
end
function this._SetEnabledSoldier(e,i)
  local e=GameObject.GetGameObjectId(e)
  if e==nullId then
    return
  end
  n(e,{id="SetEnabled",enabled=i})
end
function this._SetEnabledVehicle(c,o)
  local i=GameObject.GetGameObjectId(c)
  if i==nullId then
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
function this._ActivateReinforce()
  local hasVehicle=e._HasVehicle()
  local l=e._HasSoldier()
  local f=e._HasHeli()
  local _,a,i,c,t,o
  local r={}
  if l then
    mvars.reinforce_isEnabledSoldiers=true
    for n,r in ipairs(e.REINFORCE_SOLDIER_NAMES)do
      e._SetEnabledSoldier(r,true)
    end
    i=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_SOLDIER_NAMES[1])
    c=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_SOLDIER_NAMES[2])
    t=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_SOLDIER_NAMES[3])
    o=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_SOLDIER_NAMES[4])
    table.insert(r,i)
    table.insert(r,c)
    table.insert(r,t)
    table.insert(r,o)
  end
  if hasVehicle then
    mvars.reinforce_isEnabledVehicle=true
    e._SetEnabledVehicle(e.REINFORCE_VEHICLE_NAME,true)
    e._SetEnabledSoldier(e.REINFORCE_DRIVER_SOLDIER_NAME,true)
    _=GameObject.GetGameObjectId("TppVehicle2",e.REINFORCE_VEHICLE_NAME)
    a=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_DRIVER_SOLDIER_NAME)
    table.insert(r,a)
  end
  if f then
    local r=GameObject.GetGameObjectId(e.REINFORCE_HELI_NAME)
    local e=e._GetHeliRoute(mvars.reinforce_cpId)
    local e=mvars.ene_cpList[mvars.reinforce_reinforceCpId]
    n(r,{id="RequestReinforce",toCp=e})
    n(r,{id="SetCommandPost",cp=e})
    if mvars.reinforce_reinforceColoringType then
      TppHelicopter.SetEnemyColoring(mvars.reinforce_reinforceColoringType)
    end
  end
  TppRevenge.ApplyPowerSettingsForReinforce(r)
  GameObject.SendCommand({type="TppCommandPost2"},{id="SetReinforcePrepared"})
end
function this._DeactivateReinforce()
  if mvars.reinforce_isEnabledSoldiers then
    mvars.reinforce_isEnabledSoldiers=false
    for n,r in ipairs(e.REINFORCE_SOLDIER_NAMES)do
      e._SetEnabledSoldier(r,false)
    end
  end
  if mvars.reinforce_isEnabledVehicle then
    mvars.reinforce_isEnabledVehicle=false
    e._SetEnabledVehicle(e.REINFORCE_VEHICLE_NAME,false)
    e._SetEnabledSoldier(e.REINFORCE_DRIVER_SOLDIER_NAME,false)
  end
  GameObject.SendCommand({type="TppCommandPost2"},{id="SetNominateList"})
end
function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="RequestLoadReinforce",func=e._OnRequestLoadReinforce},
      {msg="RequestAppearReinforce",func=e._OnRequestAppearReinforce},
      {msg="CancelReinforce",func=e._OnCancelReinforce}
    }
  }
end
function this.Init(r)
  e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function this.OnReload(r)
  e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function this.OnMessage(r,n,a,o,t,c,i)
  Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,r,n,a,o,t,c,i)
end
function this._OnRequestLoadReinforce(i)
  local vehicleType=TppRevenge.SelectReinforceType()
  local color
  if TppRevenge.IsUsingBlackSuperReinforce()then
    if vehicleType==this.REINFORCE_TYPE.HELI then
      color=TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK
    else
      color=Vehicle.class.DARK_GRAY
    end
  end
  e.LoadReinforceBlock(vehicleType,i,color)
end
function this._OnRequestAppearReinforce(r)
  e.StartReinforce(r)
end
function this._OnCancelReinforce(r)
  if mvars.reinforce_activated then
    return
  end
  e.FinishReinforce(r)
end
return this
