local e={}
local s={"s","e","f","h","o"}
local o={"story","extra","free","heli","online"}
function e.MakeDefaultMissionPackList(n)
  e.AddDefaultMissionAreaPack(n)
  e.AddLocationCommonScriptPack(n)
end
function e.AddMissionPack(n)
  if Tpp.IsTypeString(n)then
    table.insert(e.missionPackList,n)
  end
end
function e.DeleteMissionPack(i)
  if Tpp.IsTypeString(i)then
    local n
    for s,e in ipairs(e.missionPackList)do
      if e==i then
        n=s
        break
      end
    end
    if n then
      table.remove(e.missionPackList,n)
    end
  end
end
function e.AddDefaultMissionAreaPack(n)
  local n=e.MakeDefaultMissionAreaPackPath(n)
  if n then
    e.AddMissionPack(n)
  end
end
function e.MakeDefaultMissionAreaPackPath(n)
  local n=n
  if TppMission.IsHardMission(n)then
    n=TppMission.GetNormalMissionCodeFromHardMission(n)
  end
  local n,e=e.GetMissionTypeAndMissionName(n)
  if n and e then
    local e="/Assets/tpp/pack/mission2/"..(n..("/"..(e..("/"..(e.."_area.fpk")))))
    return e
  end
end
function e.AddLocationCommonScriptPack(n)
  local n=TppLocation.GetLocationName()
  if n=="afgh"then
    e.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_SCRIPT)
  elseif n=="mafr"then
    e.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_SCRIPT)
  elseif n=="cypr"then
    e.AddMissionPack(TppDefine.MISSION_COMMON_PACK.CYPR_SCRIPT)
  elseif n=="mtbs"then
    e.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MTBS_SCRIPT)
  elseif n=="mbqf"then
    e.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MTBS_SCRIPT)
  end
end
function e.AddLocationCommonMissionAreaPack(n)
  local n=TppLocation.GetLocationName()
  if n=="afgh"then
    e.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
    e.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_MISSION_AREA)
    e.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AFGH_DECOY)
  elseif n=="mafr"then
    e.AddMissionPack(TppDefine.MISSION_COMMON_PACK.HELICOPTER)
    e.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_MISSION_AREA)
    e.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_DECOY)
  end
end
function e.IsMissionPackLabelList(n)
  if not Tpp.IsTypeTable(n)then
    return
  end
  for i,n in ipairs(n)do
    if e.IsMissionPackLabel(n)then
      return true
    end
  end
  return false
end
function e.IsMissionPackLabel(e)
  if not Tpp.IsTypeString(e)then
    return
  end
  if gvars.pck_missionPackLabelName==Fox.StrCode32(e)then
    return true
  else
    return false
  end
end
function e.AddColoringPack(n)
  if TppColoringSystem then
    local n=TppColoringSystem.GetAdditionalColoringPackFilePaths{missionCode=n}
    for i,n in ipairs(n)do
      e.AddMissionPack(n)
    end
  else
    e.AddMissionPack"/Assets/tpp/pack/fova/mecha/all/mfv_scol_c11.fpk"
    e.AddMissionPack"/Assets/tpp/pack/fova/mecha/all/mfv_scol_c07.fpk"
  end
end
function e.AddFOBLayoutPack(n)
  local a,i=e.GetMissionTypeAndMissionName(n)
  if n==50050 then
  end
  if(n==50050)or(n==10115)then
    local s="/Assets/tpp/pack/mission2/"..(a..("/"..(i..("/"..(i..string.format("_area_ly%03d",vars.mbLayoutCode))))))
    local a=s..".fpk"
    local i=vars.mbClusterId
    if(n==10115)then
      i=TppDefine.CLUSTER_DEFINE.Develop
    end
    local n=s..(string.format("_cl%02d",i)..".fpk")
    e.AddMissionPack(a)
    e.AddMissionPack(n)
  elseif n==30050 then
    local n="/Assets/tpp/pack/mission2/"..(a..("/"..(i..("/"..(i..string.format("_ly%03d",vars.mbLayoutCode))))))
    local n=n..".fpk"
    e.AddMissionPack(n)
  end
end
function e.AddAvatarEditPack()
  local n=TppDefine.MISSION_COMMON_PACK.AVATAR_ASSET_LIST
  for i,n in ipairs(n)do
    e.AddMissionPack(n)
  end
  e.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AVATAR_EDIT)
end
function e.SetUseDdEmblemFova(e)
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
function e.SetMissionPackLabelName(e)
  if Tpp.IsTypeString(e)then
    gvars.pck_missionPackLabelName=Fox.StrCode32(e)
  end
end
function e.SetDefaultMissionPackLabelName()
  e.SetMissionPackLabelName"default"
end
function e.MakeMissionPackList(n,i)
  e.missionPackList={}
  if Tpp.IsTypeFunc(i)then
    i(n)
  end
  local i=true
  if n==10010 and e.IsMissionPackLabel"afterMissionClearMovie"then
    i=false
  end
  if i then
    e.AddColoringPack(n)
  end
  return e.missionPackList
end
function e.GetMissionTypeAndMissionName(n)
  local e=math.floor(n/1e4)
  local a=o[e]local i
  if s[e]then
    i=s[e]..n
  end
  return a,i
end
function e.GetLocationNameFormMissionCode(n)
  local e
  for i,s in pairs(TppDefine.LOCATION_HAVE_MISSION_LIST)do
    for a,s in pairs(s)do
      if s==n then
        e=i
        break
      end
    end
    if e then
      break
    end
  end
  return e
end
return e
