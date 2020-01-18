local e={}
local s={"s","e","f","h","o"}
local o={"story","extra","free","heli","online"}
--tex DEMINIFY
local this=e
local missionTypePackCodes=s
local missionTypePackCodeNames=o
function this.MakeDefaultMissionPackList(n)
  e.AddDefaultMissionAreaPack(n)
  e.AddLocationCommonScriptPack(n)
end
function this.AddMissionPack(n)
  if Tpp.IsTypeString(n)then
    table.insert(e.missionPackList,n)
  end
end
function this.DeleteMissionPack(i)
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
function this.AddDefaultMissionAreaPack(n)
  local n=e.MakeDefaultMissionAreaPackPath(n)
  if n then
    e.AddMissionPack(n)
  end
end
function this.MakeDefaultMissionAreaPackPath(_missionCode)
  local missionCode=_missionCode
  if TppMission.IsHardMission(missionCode)then
    missionCode=TppMission.GetNormalMissionCodeFromHardMission(missionCode)--tex NMC: just shifts from 11k range to 10k so it matches it's normal story mission and falls into story mission type range, so no seperate packs for hard missions I guess
  end
  local missionTypePackCodeName,missionName=this.GetMissionTypeAndMissionName(missionCode)--tex: NMC: lua functions can return multiple values
  if missionTypePackCodeName and missionName then
    local path="/Assets/tpp/pack/mission2/"..(missionTypePackCodeName..("/"..(missionName..("/"..(missionName.."_area.fpk")))))--tex NMC: .. operator in lua concats strings
    return path
  end
end
function this.AddLocationCommonScriptPack(n)
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
function this.AddLocationCommonMissionAreaPack(n)
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
function this.IsMissionPackLabelList(n)
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
function this.AddColoringPack(n)
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
function this.AddFOBLayoutPack(missionCode)
  local missionTypePackCodeName,missionName=this.GetMissionTypeAndMissionName(missionCode)
  if missionCode==50050 then--tex: NMC: WTF: uhhh, what. 50050 is online fob, this means it doesnt pull the pack, yet next if it's checking again
  end
  if(missionCode==50050)or(missionCode==10115)then
    local areaPath="/Assets/tpp/pack/mission2/"..(missionTypePackCodeName..("/"..(missionName..("/"..(missionName..string.format("_area_ly%03d",vars.mbLayoutCode))))))
    local areaPathF=areaPath..".fpk"
    local mbClusterId=vars.mbClusterId--tex NMC: range 0-6 - from TppDefine.CLUSTER_DEFINE
    if(missionCode==10115)then
      mbClusterId=TppDefine.CLUSTER_DEFINE.Develop
    end
    local clusterPath=areaPath..(string.format("_cl%02d",mbClusterId)..".fpk")
    this.AddMissionPack(areaPathF)
    this.AddMissionPack(clusterPath)
  elseif missionCode==30050 then
    local layoutPath="/Assets/tpp/pack/mission2/"..(missionTypePackCodeName..("/"..(missionName..("/"..(missionName..string.format("_ly%03d",vars.mbLayoutCode))))))--tex NMC: mbLayoutCode 0-103,980?, from TppLocation.lua, ?mbstage_parameter.lua
    local layoutPath=layoutPath..".fpk"
    this.AddMissionPack(layoutPath)
  end
end
function this.AddAvatarEditPack()
  local n=TppDefine.MISSION_COMMON_PACK.AVATAR_ASSET_LIST
  for i,n in ipairs(n)do
    e.AddMissionPack(n)
  end
  e.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AVATAR_EDIT)
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
  e.SetMissionPackLabelName"default"
end
function this.MakeMissionPackList(n,i)
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
function this.GetMissionTypeAndMissionName(missionCode)
  local missionCodeTypeRange=math.floor(missionCode/1e4)--tex NMC: missioncodes fall into 1e4 ranges per mission type
  local missionTypePackCodeName=missionTypePackCodeNames[missionCodeTypeRange]
  local missionName
  if missionTypePackCodes[missionCodeTypeRange]then
    missionName=missionTypePackCodes[missionCodeTypeRange]..missionCode
  end
  return missionTypePackCodeName,missionName
end
function this.GetLocationNameFormMissionCode(n)
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
return this
