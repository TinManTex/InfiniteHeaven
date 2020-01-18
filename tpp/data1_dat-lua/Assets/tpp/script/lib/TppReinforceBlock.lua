local this={}
local r=GameObject.GetGameObjectId
local r=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local NULL_ID=GameObject.NULL_ID
this.REINFORCE_TYPE_NAME={"NONE","EAST_WAV","EAST_WAV_ROCKET","WEST_WAV","WEST_WAV_CANNON","EAST_TANK","WEST_TANK","HELI"}
this.REINFORCE_TYPE=TppDefine.Enum(this.REINFORCE_TYPE_NAME)
this.REINFORCE_FPK={
  [this.REINFORCE_TYPE.NONE]="",
  [this.REINFORCE_TYPE.EAST_WAV]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_wav.fpk",
  [this.REINFORCE_TYPE.EAST_WAV_ROCKET]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_wav_roc.fpk",
  [this.REINFORCE_TYPE.WEST_WAV]={
    PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_a.fpk",
    PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_b.fpk",
    PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_c.fpk"
    },
  [this.REINFORCE_TYPE.WEST_WAV_CANNON]={
    PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_a.fpk",
    PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_b.fpk",
    PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_wav_can_c.fpk"
  },
  [this.REINFORCE_TYPE.EAST_TANK]="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_tnk.fpk",
  [this.REINFORCE_TYPE.WEST_TANK]={
    PF_A="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_a.fpk",
    PF_B="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_b.fpk",
    PF_C="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_west_tnk_c.fpk"
  },
  [this.REINFORCE_TYPE.HELI]={
    AFGH={
      _DEFAULT="/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk",
      [TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk"},
      [TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_afgh.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk"}
      },
    MAFR={_DEFAULT="/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk",
      [TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_blk.fpk"},
      [TppDefine.ENEMY_HELI_COLORING_TYPE.RED]={"/Assets/tpp/pack/soldier/reinforce/reinforce_heli_mafr.fpk","/Assets/tpp/pack/fova/mecha/sbh/sbh_ene_red.fpk"}
      }
  }
}
this.REINFORCE_VEHICLE_NAME="reinforce_vehicle_0000"
this.REINFORCE_DRIVER_SOLDIER_NAME="reinforce_soldier_driver"
this.REINFORCE_SOLDIER_NAMES={"reinforce_soldier_0000","reinforce_soldier_0001","reinforce_soldier_0002","reinforce_soldier_0003"}
this.REINFORCE_HELI_NAME="EnemyHeli"
function this.GetReinforceBlockId()
  return ScriptBlock.GetScriptBlockId(mvars.reinforce_reinforceBlockName)
end
function this.GetReinforceBlockState()
  return ScriptBlock.GetScriptBlockState(this.GetReinforceBlockId())
end
function this.IsLoaded()
  return this.GetReinforceBlockState()==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY
end
function this.IsProcessing()
  return this.GetReinforceBlockState()==ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING
end
function this.GetFpk(r,i,n)
  local e=this.REINFORCE_FPK[r]
  if Tpp.IsTypeTable(e)then
    local r=""if TppLocation.IsAfghan()then
      r="AFGH"elseif TppLocation.IsMiddleAfrica()then
      r="MAFR"end
    local r=e[i]or e[r]
    if Tpp.IsTypeTable(r)then
      n=n or"_DEFAULT"if r[n]then
        r=r[n]
      else
        r=nil
      end
    end
    if r then
      e=r
    else
      local r=""for i,n in pairs(e)do
        if r==""then
          r=n
        end
      end
      e=r
    end
  end
  if not e then
    return""end
  return e
end
function this.SetUpReinforceBlock()
  mvars.reinforce_reinforceBlockName="reinforce_block"local n=false
  local i=this.GetReinforceBlockId()n=(i~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID)
  mvars.reinforce_hasReinforceBlock=n
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  for n,r in ipairs(this.REINFORCE_SOLDIER_NAMES)do
    this._SetEnabledSoldier(r,false)
  end
  this._SetEnabledVehicle(this.REINFORCE_VEHICLE_NAME,false)
  mvars.reinforce_reinforceType=this.REINFORCE_TYPE.NONE
  mvars.reinforce_reinforceColoringType=nil
  mvars.reinforce_reinforceCpId=NULL_ID
  mvars.reinforce_activated=false
end
function this.LoadReinforceBlock(reinforceType,reinforceCpId,reinforceColoringType)
  if mvars.reinforce_activated then
    return
  end
  if mvars.reinforce_reinforceCpId~=NULL_ID and mvars.reinforce_reinforceCpId~=reinforceCpId then
    return
  end
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  if reinforceType==this.REINFORCE_TYPE.HELI and GameObject.DoesGameObjectExistWithTypeName"TppEnemyHeli"then
    return
  end
  local reinforceBlockId=this.GetReinforceBlockId()
  local cpSubType=TppEnemy.GetCpSubType(mvars.reinforce_cpId)
  local fpk=this.GetFpk(reinforceType,cpSubType,reinforceColoringType)
  if fpk==nil then
    reinforceType=this.REINFORCE_TYPE.NONE
    fpk=""
    end
  ScriptBlock.Load(reinforceBlockId,fpk)
  mvars.reinforce_reinforceType=reinforceType
  mvars.reinforce_reinforceColoringType=reinforceColoringType
  if reinforceType~=this.REINFORCE_TYPE.NONE then
    SendCommand({type="TppCommandPost2"},{id="SetReinforceEnable"})
    mvars.reinforce_reinforceCpId=reinforceCpId
    local hasVehicle=this._HasVehicle()
    local hasSoldier=this._HasSoldier()
    local vehicleId,driverId
    local reinforceSoldiers={}
    if hasSoldier then
      for n,soldierName in ipairs(this.REINFORCE_SOLDIER_NAMES)do
        reinforceSoldiers[n]=GameObject.GetGameObjectId("TppSoldier2",soldierName)
      end
    end
    if hasVehicle then
      vehicleId=GameObject.GetGameObjectId("TppVehicle2",this.REINFORCE_VEHICLE_NAME)
      driverId=GameObject.GetGameObjectId("TppSoldier2",this.REINFORCE_DRIVER_SOLDIER_NAME)
    end
    SendCommand({type="TppCommandPost2"},{id="SetNominateList",driver=driverId,vehicle=vehicleId,sol01=reinforceSoldiers[1],sol02=reinforceSoldiers[2],sol03=reinforceSoldiers[3],sol04=reinforceSoldiers[4]})
  else
    mvars.reinforce_reinforceCpId=NULL_ID
  end
end
function this.UnloadReinforceBlock(cpId)
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  if((cpId~=nil and cpId~=NULL_ID)and mvars.reinforce_reinforceCpId~=NULL_ID)and mvars.reinforce_reinforceCpId~=cpId then
    return
  end
  local reinforceBlockId=this.GetReinforceBlockId()
  if this.GetReinforceBlockState()>ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE then
    this.ReinforceBlockOnDeactivate()
  end
  ScriptBlock.Load(reinforceBlockId,"")
  mvars.reinforce_reinforceType=this.REINFORCE_TYPE.NONE
  mvars.reinforce_reinforceColoringType=nil
  mvars.reinforce_reinforceCpId=NULL_ID
end
function this.StartReinforce(n)
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  if mvars.reinforce_reinforceType==this.REINFORCE_TYPE.NONE then
    return
  end
  if(n~=nil and n~=NULL_ID)and mvars.reinforce_reinforceCpId~=n then
    return
  end
  local e=this.GetReinforceBlockId()ScriptBlock.Activate(e)
  mvars.reinforce_activated=true
end
function this.FinishReinforce(n)
  if not mvars.reinforce_hasReinforceBlock then
    return
  end
  if(n~=nil and n~=NULL_ID)and mvars.reinforce_reinforceCpId~=n then
    return
  end
  local e=this.GetReinforceBlockId()ScriptBlock.Deactivate(e)
  mvars.reinforce_activated=false
  mvars.reinforce_reinforceCpId=NULL_ID
end
function this.ReinforceBlockOnInitialize()
  mvars.reinforce_lastReinforceBlockState=this.GetReinforceBlockState()
  mvars.reinforce_isEnabledVehicle=false
  mvars.reinforce_isEnabledSoldiers=false
end
function this.ReinforceBlockOnUpdate()
  local n=this.GetReinforceBlockState()
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
      this.ReinforceBlockOnDeactivate()
    end
    r.reinforce_lastReinforceInactiveToActive=false
  elseif n==c then
    if r.reinforce_lastReinforceInactiveToActive then
      r.reinforce_lastReinforceInactiveToActive=false
      this.ReinforceBlockOnActivate()
    end
    if(not i)or i<=o then
      r.reinforce_lastReinforceInactiveToActive=true
    end
  end
  r.reinforce_lastReinforceBlockState=n
end
function this.ReinforceBlockOnActivate()
  this._ActivateReinforce()
end
function this.ReinforceBlockOnDeactivate()
  this._DeactivateReinforce()
end
function this.ReinforceBlockOnTerminate()
end
function this._HasSoldier()
  if((mvars.reinforce_reinforceType==this.REINFORCE_TYPE.HELI or mvars.reinforce_reinforceType==this.REINFORCE_TYPE.EAST_WAV_ROCKET)or mvars.reinforce_reinforceType==this.REINFORCE_TYPE.EAST_TANK)or mvars.reinforce_reinforceType==this.REINFORCE_TYPE.WEST_TANK then
    return false
  end
  return true
end
function this._HasVehicle()
  if((((mvars.reinforce_reinforceType==this.REINFORCE_TYPE.EAST_WAV or mvars.reinforce_reinforceType==this.REINFORCE_TYPE.EAST_WAV_ROCKET)or mvars.reinforce_reinforceType==this.REINFORCE_TYPE.WEST_WAV)or mvars.reinforce_reinforceType==this.REINFORCE_TYPE.WEST_WAV_CANNON)or mvars.reinforce_reinforceType==this.REINFORCE_TYPE.EAST_TANK)or mvars.reinforce_reinforceType==this.REINFORCE_TYPE.WEST_TANK then
    return true
  end
  return false
end
function this._HasHeli()
  if mvars.reinforce_reinforceType==this.REINFORCE_TYPE.HELI then
    return true
  end
  return false
end
function this._GetHeliRoute(e)
  return"reinforce_heli_route_0000"end
function this._SetEnabledSoldier(e,i)
  local e=GameObject.GetGameObjectId(e)
  if e==NULL_ID then
    return
  end
  SendCommand(e,{id="SetEnabled",enabled=i})
end
function this._SetEnabledVehicle(c,o)
  local i=GameObject.GetGameObjectId(c)
  if i==NULL_ID then
    return
  end
  if o then
    local r
    if mvars.reinforce_reinforceType==this.REINFORCE_TYPE.EAST_WAV_ROCKET then
      r=Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY
    elseif mvars.reinforce_reinforceType==this.REINFORCE_TYPE.WEST_WAV then
      r=Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN
    elseif mvars.reinforce_reinforceType==this.REINFORCE_TYPE.WEST_WAV_CANNON then
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
    local e={id="Respawn",name=c,type=9,subType=r,paintType=o,class=e}SendCommand(i,e)
  else
    SendCommand(i,{id="Despawn",name=c,type=9})
  end
end
function this._ActivateReinforce()
  local hasVehicle=this._HasVehicle()
  local hasSoldier=this._HasSoldier()
  local hasHeli=this._HasHeli()
  local vehicleId,driverId,soldier1Id,soldier2Id,soldier3Id,soldier4Id
  local reinforceSoldiers={}
  if hasSoldier then
    mvars.reinforce_isEnabledSoldiers=true
    for n,r in ipairs(this.REINFORCE_SOLDIER_NAMES)do
      this._SetEnabledSoldier(r,true)
    end
    soldier1Id=GameObject.GetGameObjectId("TppSoldier2",this.REINFORCE_SOLDIER_NAMES[1])
    soldier2Id=GameObject.GetGameObjectId("TppSoldier2",this.REINFORCE_SOLDIER_NAMES[2])
    soldier3Id=GameObject.GetGameObjectId("TppSoldier2",this.REINFORCE_SOLDIER_NAMES[3])
    soldier4Id=GameObject.GetGameObjectId("TppSoldier2",this.REINFORCE_SOLDIER_NAMES[4])
    table.insert(reinforceSoldiers,soldier1Id)
    table.insert(reinforceSoldiers,soldier2Id)
    table.insert(reinforceSoldiers,soldier3Id)
    table.insert(reinforceSoldiers,soldier4Id)
  end
  if hasVehicle then
    mvars.reinforce_isEnabledVehicle=true
    this._SetEnabledVehicle(this.REINFORCE_VEHICLE_NAME,true)
    this._SetEnabledSoldier(this.REINFORCE_DRIVER_SOLDIER_NAME,true)
    vehicleId=GameObject.GetGameObjectId("TppVehicle2",this.REINFORCE_VEHICLE_NAME)
    driverId=GameObject.GetGameObjectId("TppSoldier2",this.REINFORCE_DRIVER_SOLDIER_NAME)
    table.insert(reinforceSoldiers,driverId)
  end
  if hasHeli then
    local heliId=GameObject.GetGameObjectId(this.REINFORCE_HELI_NAME)
    local heliRoute=this._GetHeliRoute(mvars.reinforce_cpId)
    local cp=mvars.ene_cpList[mvars.reinforce_reinforceCpId]
    SendCommand(heliId,{id="RequestReinforce",toCp=cp})
    SendCommand(heliId,{id="SetCommandPost",cp=cp})
    if mvars.reinforce_reinforceColoringType then
      TppHelicopter.SetEnemyColoring(mvars.reinforce_reinforceColoringType)
    end
  end
  TppRevenge.ApplyPowerSettingsForReinforce(reinforceSoldiers)
  GameObject.SendCommand({type="TppCommandPost2"},{id="SetReinforcePrepared"})
end
function this._DeactivateReinforce()
  if mvars.reinforce_isEnabledSoldiers then
    mvars.reinforce_isEnabledSoldiers=false
    for n,r in ipairs(this.REINFORCE_SOLDIER_NAMES)do
      this._SetEnabledSoldier(r,false)
    end
  end
  if mvars.reinforce_isEnabledVehicle then
    mvars.reinforce_isEnabledVehicle=false
    this._SetEnabledVehicle(this.REINFORCE_VEHICLE_NAME,false)
    this._SetEnabledSoldier(this.REINFORCE_DRIVER_SOLDIER_NAME,false)
  end
  GameObject.SendCommand({type="TppCommandPost2"},{id="SetNominateList"})
end
function this.Messages()
  return Tpp.StrCode32Table{GameObject={{msg="RequestLoadReinforce",func=this._OnRequestLoadReinforce},{msg="RequestAppearReinforce",func=this._OnRequestAppearReinforce},{msg="CancelReinforce",func=this._OnCancelReinforce}}}
end
function this.Init(r)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(r)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(r,n,a,o,t,c,i)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,r,n,a,o,t,c,i)
end
function this._OnRequestLoadReinforce(i)
  local n=TppRevenge.SelectReinforceType()
  local r
  if TppRevenge.IsUsingBlackSuperReinforce()then
    if n==this.REINFORCE_TYPE.HELI then
      r=TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK
    else
      r=Vehicle.class.DARK_GRAY
    end
  end
  this.LoadReinforceBlock(n,i,r)
end
function this._OnRequestAppearReinforce(r)
  this.StartReinforce(r)
end
function this._OnCancelReinforce(r)
  if mvars.reinforce_activated then
    return
  end
  this.FinishReinforce(r)
end
return this
