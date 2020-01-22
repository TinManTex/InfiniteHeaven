local this={}
this.PlayerTypes={
  [PlayerType.MGO_MALE]={parts={[PlayerPartsType.NORMAL]={fpk="/Assets/mgo/pack/player/parts/plparts_bse0_main2.fpk",file="/Assets/mgo/parts/chara/base/bse0_main0_def_v02.parts"}}},
  [PlayerType.MGO_FEMALE]={parts={[PlayerPartsType.NORMAL]={fpk="/Assets/mgo/pack/player/parts/plparts_bse0_main2_f.fpk",file="/Assets/mgo/parts/chara/base/bse0_main0_def_v02_f.parts"}}},
  [PlayerType.AVATAR]={parts={[PlayerPartsType.AVATAR_EDIT_MAN]={fpk="/Assets/mgo/pack/player/parts/plparts_avatar_man.fpk",file="/Assets/tpp/parts/chara/avm/avm0_main0_def_v00.parts"},
    [PlayerPartsType.AVATAR_EDIT_WOMAN]={fpk="/Assets/mgo/pack/player/parts/plparts_avatar_woman.fpk",file="/Assets/mgo/parts/chara/avm/avf0_main0_def_v00.parts"}}},
  [PlayerType.MGO_SNAKE]={parts={[PlayerPartsType.NORMAL]={fpk="/Assets/mgo/pack/player/parts/plparts_sna0_main.fpk",file="/Assets/mgo/parts/chara/sna/sna0_main4_def_v00.parts"}}},
  [PlayerType.MGO_OCELOT]={parts={[PlayerPartsType.NORMAL]={fpk="/Assets/mgo/pack/player/parts/plparts_oce0_main.fpk",file="/Assets/mgo/parts/chara/oce/oce0_main0_def_v00.parts"}}}}
function this.GetPartsFpkPath(s,p)
  local e
  pcall(function()e=this.PlayerTypes[s].parts[p].fpk end)
  return e
end
function this.GetPartsFilePath(p,s)
  local e
  pcall(function()e=this.PlayerTypes[p].parts[s].file end)
  return e
end
function this.GetFaceFpkPath(p,e,s)
  local e
  pcall(function()e=this.PlayerTypes[p].faces[s+1].fpk end)
  return e
end
function this.GetFaceFilePath(s,e,p)
  local e
  pcall(function()e=this.PlayerTypes[s].faces[p+1].file end)
  return e
end
return this
