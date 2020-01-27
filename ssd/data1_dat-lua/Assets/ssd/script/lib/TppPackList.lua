local this={}
local n={"s","e","f","h","o"}
local e={"story","extra","free","heli","online"}
function this.MakeDefaultMissionPackList(i)
  this.AddLocationCommonScriptPack(i)
end
function this.AddMissionPack(i)
  if Tpp.IsTypeString(i)then
    table.insert(this.missionPackList,i)
  end
end
function this.DeleteMissionPack(a)
  if Tpp.IsTypeString(a)then
    local i
    for n,s in ipairs(this.missionPackList)do
      if s==a then
        i=n
        break
      end
    end
    if i then
      table.remove(this.missionPackList,i)
    end
  end
end
function this.AddLocationCommonScriptPack(i)
  local i=TppLocation.GetLocationName()
  if(i=="afgh"or i=="ssd_afgh2")or i=="aftr"then
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.SSD_AFGH_SCRIPT)
  elseif i=="mafr"then
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MAFR_SCRIPT)
  elseif i=="cypr"then
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.CYPR_SCRIPT)
  elseif i=="mtbs"then
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MTBS_SCRIPT)
  elseif i=="mbqf"then
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.MTBS_SCRIPT)
  end
end
function this.AddLocationCommonMissionAreaPack(i)
  local i=TppLocation.GetLocationName()
  if i=="afgh"then
    this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.SSD_AFGH_MISSION_AREA)
  elseif i=="ssd_afgh2"then
    this.AddMissionPack"/Assets/ssd/pack/mission/common/mis_com_afgh2.fpk"end
end
function this.AddZombieCommonPack(i)
  this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.ZOMBIE)
end
function this.AddCoopCommonPack(i)
  this.AddMissionPack"/Assets/ssd/pack/mission/common/mis_com_coop.fpk"
  this.AddMissionPack"/Assets/ssd/pack/ui/ssd_ui_coop.fpk"end
function this.AddFreeCommonPack(i)
  this.AddMissionPack"/Assets/ssd/pack/mission/common/mis_com_opening_demo.fpk"end
function this.IsMissionPackLabelList(i)
  if not Tpp.IsTypeTable(i)then
    return
  end
  for a,i in ipairs(i)do
    if this.IsMissionPackLabel(i)then
      return true
    end
  end
  return false
end
function this.AddRobbyStagePack(i)
  this.AddMissionPack"/Assets/ssd/pack/mission/common/mis_com_robby_stage.fpk"
  this.AddMissionPack"/Assets/ssd/pack/ui/ssd_ui_staging_area.fpk"
  this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.SSD_PLAYER_EMOTION)
  this.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_digger_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_range_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_stealthArea_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_stealthArea_c02.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_digger_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_range_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_stealthArea_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_stealthArea_c02.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_digger_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_range_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_stealthArea_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_stealthArea_c02.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_digger_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_range_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_stealthArea_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_stealthArea_c02.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_digger_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_range_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_stealthArea_c01.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_stealthArea_c02.fpk"
  this.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_digger_r01.fpk"--RETAILPATCH: 1.0.5.0>
  this.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_digger_r01.fpk"--<
end
function this.IsMissionPackLabel(s)
  if not Tpp.IsTypeString(s)then
    return
  end
  if gvars.pck_missionPackLabelName==Fox.StrCode32(s)then
    return true
  else
    return false
  end
end
function this.AddAvatarEditPack()
  local i=TppDefine.MISSION_COMMON_PACK.AVATAR_ASSET_LIST
  for a,i in ipairs(i)do
    this.AddMissionPack(i)
  end
  local i=TppDefine.MISSION_COMMON_PACK.AVATAR_ASSET_LIST_FEMALE
  for a,i in ipairs(i)do
    this.AddMissionPack(i)
  end
  this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AVATAR_EDIT)
end
function this.AddAvatarMaleEditPack()
  local i=TppDefine.MISSION_COMMON_PACK.AVATAR_ASSET_LIST
  for a,i in ipairs(i)do
    this.AddMissionPack(i)
  end
  this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AVATAR_EDIT)
end
function this.AddAvatarFemaleEditPack()
  local i=TppDefine.MISSION_COMMON_PACK.AVATAR_ASSET_LIST_FEMALE
  for a,i in ipairs(i)do
    this.AddMissionPack(i)
  end
  this.AddMissionPack(TppDefine.MISSION_COMMON_PACK.AVATAR_EDIT)
end
function this.SetUseDdEmblemFova(s)
end
function this.SetMissionPackLabelName(s)
  if Tpp.IsTypeString(s)then
    gvars.pck_missionPackLabelName=Fox.StrCode32(s)
  end
end
function this.SetDefaultMissionPackLabelName()
  this.SetMissionPackLabelName"default"
end
function this.MakeMissionPackList(a,i)
  this.missionPackList={}
  if Tpp.IsTypeFunc(i)then
    i(a)
  end
  return this.missionPackList
end
function this.GetMissionTypeAndMissionName(a)
  local s=math.floor(a/1e4)
  local e=e[s]
  local i
  if n[s]then
    i=n[s]..a
  end
  return e,i
end
function this.GetLocationNameFormMissionCode(i)
  local s
  if i and TppMission.IsEventMission(i)then
    local a=Mission.GetDlcLocationSettings()
    for a,n in pairs(a)do
      for e,n in pairs(n)do
        local n=tonumber(n)
        if n==i then
          s=a
          break
        end
      end
      if s then
        return s
      end
    end
  end
  for n,a in pairs(SsdMissionList.MISSION_LIST_FOR_LOCATION)do
    for e,a in pairs(a)do
      local a=tonumber(a)
      if a==i then
        s=n
        break
      end
    end
    if s then
      break
    end
  end
  return s
end
function this.AddTitleMissionPack(a,i)
  if i then
    this.AddMissionPack"/Assets/ssd/pack/mission/common/title_sequence_script.fpk"this.AddMissionPack"/Assets/ssd/pack/ui/ssd_init_mission_ui.fpk"this.AddMissionPack"/Assets/ssd/pack/ui/ssd_ui_title.fpk"end
  this.AddMissionPack"/Assets/ssd/pack/mission/common/title_sequence.fpk"end
return this
