local this={}
local missionTypeNameCodes={"s","e","f","h","o"}
local missionTypeNames={"story","extra","free","heli","online"}
function this.MakeDefaultMissionPackList(n)
  this.AddDefaultMissionAreaPack(n)
  this.AddLocationCommonScriptPack(n)
end
function this.AddMissionPack(packPath)
  if Tpp.IsTypeString(packPath)then
    table.insert(this.missionPackList,packPath)
  end
end
function this.DeleteMissionPack(i)
  if Tpp.IsTypeString(i)then
    local n
    for s,e in ipairs(this.missionPackList)do
      if e==i then
        n=s
        break
      end
    end
    if n then
      table.remove(this.missionPackList,n)
    end
  end
end
function this.AddDefaultMissionAreaPack(missionCode)
  local pack=this.MakeDefaultMissionAreaPackPath(missionCode)
  if pack then
    this.AddMissionPack(pack)
  end
end
function this.MakeDefaultMissionAreaPackPath(missionCode)
  local missionCode=missionCode
  if TppMission.IsHardMission(missionCode)then
    missionCode=TppMission.GetNormalMissionCodeFromHardMission(missionCode)
  end
  local missionTypeName,missionTypeCodeName=this.GetMissionTypeAndMissionName(missionCode)
  if missionTypeName and missionTypeCodeName then
    local packPath="/Assets/tpp/pack/mission2/"..(missionTypeName..("/"..(missionTypeCodeName..("/"..(missionTypeCodeName.."_area.fpk")))))
    return packPath
  end
end
function this.AddLocationCommonScriptPack(missionCode)
  local locationName=TppLocation.GetLocationName()
  if locationName=="afgh"then
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_SCRIPT)
  elseif locationName=="mafr"then
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_SCRIPT)
  elseif locationName=="cypr"then
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.CYPR_SCRIPT)
  elseif locationName=="mtbs"then
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MTBS_SCRIPT)
  elseif locationName=="mbqf"then
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MTBS_SCRIPT)
  end
end
function this.AddLocationCommonMissionAreaPack(missionCode)
  local locationCode=TppLocation.GetLocationName()
  if locationCode=="afgh"then
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_MISSION_AREA)
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_DECOY)
  elseif locationCode=="mafr"then
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_MISSION_AREA)
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_DECOY)
  end
end
function this.IsMissionPackLabelList(n)
  if not Tpp.IsTypeTable(n)then
    return
  end
  for i,n in ipairs(n)do
    if this.IsMissionPackLabel(n)then
      return true
    end
  end
  return false
end
function this.IsMissionPackLabel(e)
  if not Tpp.IsTypeString(e)then
    return
  end
  if gvars.pck_missionPackLabelName==Fox.StrCode32(e)then
    return true
  else
    return false
  end
end
function this.AddColoringPack(missionCode)
  if TppColoringSystem then
    local coloringPacks=TppColoringSystem.GetAdditionalColoringPackFilePaths{missionCode=missionCode}
    for i,n in ipairs(coloringPacks)do
      this.AddMissionPack(n)
    end
  else
    this.AddMissionPack"/Assets/tpp/pack/fova/mecha/all/mfv_scol_c11.fpk"this.AddMissionPack"/Assets/tpp/pack/fova/mecha/all/mfv_scol_c07.fpk"
  end
end
function this.AddFOBLayoutPack(missionCode)
  local missionTypeName,missionCodeName=this.GetMissionTypeAndMissionName(missionCode)
  if missionCode==50050 then
  end
  if(missionCode==50050)or(missionCode==10115)then
    local layoutPath="/Assets/tpp/pack/mission2/"..(missionTypeName..("/"..(missionCodeName..("/"..(missionCodeName..string.format("_area_ly%03d",vars.mbLayoutCode))))))
    local layoutPack=layoutPath..".fpk"
    local clusterId=vars.mbClusterId
    if(missionCode==10115)then
      clusterId=TppDefine.CLUSTER_DEFINE.Develop
    end
    local clusterLayoutPack=layoutPath..(string.format("_cl%02d",clusterId)..".fpk")
    this.AddMissionPack(layoutPack)
    this.AddMissionPack(clusterLayoutPack)
 elseif missionCode==30050 then
    local layoutPack="/Assets/tpp/pack/mission2/"..(missionTypeName..("/"..(missionCodeName..("/"..(missionCodeName..string.format("_ly%03d",vars.mbLayoutCode))))))
    local fpkPath=layoutPack..".fpk"
    this.AddMissionPack(fpkPath)
  end
end
function this.AddAvatarEditPack()
  local avatarAssetList=TppDefine.MISSION_COMMON_PACK.AVATAR_ASSET_LIST
  for i,fpk in ipairs(avatarAssetList)do
    this.AddMissionPack(fpk)
  end
  this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AVATAR_EDIT)
end
function this.SetUseDdEmblemFova(e)
  if((e==10030)or(e==10050))or(e==10240)then
    TppSoldierFace.SetUseBlackDdFova{enabled=false}
    return
  end
  if gvars.s10240_isPlayedFuneralDemo then
    TppSoldierFace.SetUseBlackDdFova{enabled=true}
  else
    TppSoldierFace.SetUseBlackDdFova{enabled=false}
  end
end
function this.SetMissionPackLabelName(e)
  if Tpp.IsTypeString(e)then
    gvars.pck_missionPackLabelName=Fox.StrCode32(e)
  end
end
function this.SetDefaultMissionPackLabelName()
  this.SetMissionPackLabelName"default"
end
function this.MakeMissionPackList(missionCode,missionPackList)
  this.missionPackList={}
  if Tpp.IsTypeFunc(missionPackList)then
    missionPackList(missionCode)
  end
  local addColoringPack=true
  if missionCode==10010 and this.IsMissionPackLabel"afterMissionClearMovie"then
    addColoringPack=false
  end
  if addColoringPack then
    this.AddColoringPack(missionCode)
  end
  return this.missionPackList
end
function this.GetMissionTypeAndMissionName(missionCode)
  local missionCodeRange=math.floor(missionCode/1e4)
  local missionTypeName=missionTypeNames[missionCodeRange]
  local missionCodeName--RENAME, missiontyoenaemcodenamtetytpe
  if missionTypeNameCodes[missionCodeRange]then
    missionCodeName=missionTypeNameCodes[missionCodeRange]..missionCode
  end
  return missionTypeName,missionCodeName
end
function this.GetLocationNameFormMissionCode(missionCode)
  local locationName
  for location,missions in pairs(TppDefine.LOCATION_HAVE_MISSION_LIST)do
    for a,mission in pairs(missions)do
      if mission==missionCode then
        locationName=location
        break
      end
    end
    if locationName then
      break
    end
  end
  return locationName
end
return this
