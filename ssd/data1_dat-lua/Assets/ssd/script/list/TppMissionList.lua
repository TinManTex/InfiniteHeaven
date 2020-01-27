-- ssd TppMissionList.lua
-- NMC: Legacy/bootstrap? There's the much more complex SsdMissionList
local this={}
local locationPackTable={}
locationPackTable[TppDefine.LOCATION_ID.INIT]={"/Assets/tpptest/pack/location/empty/empty.fpk"}
locationPackTable[TppDefine.LOCATION_ID.AFGH]={"/Assets/tpp/pack/location/afgh/afgh.fpk"}
locationPackTable[TppDefine.LOCATION_ID.MAFR]={"/Assets/tpp/pack/location/mafr/mafr.fpk"}
locationPackTable[TppDefine.LOCATION_ID.CYPR]={"/Assets/tpp/pack/location/cypr/cypr.fpk"}
locationPackTable[TppDefine.LOCATION_ID.GNTN]={"/Assets/tpp/pack/location/gntn/gntn.fpk"}
locationPackTable[TppDefine.LOCATION_ID.OMBS]={"/Assets/tpp/pack/location/ombs/ombs.fpk"}
locationPackTable[TppDefine.LOCATION_ID.MTBS]={"/Assets/tpp/pack/location/mtbs/mtbs.fpk"}
locationPackTable[TppDefine.LOCATION_ID.HLSP]={"/Assets/tpp/pack/location/hlsp/hlsp.fpk"}
locationPackTable[TppDefine.LOCATION_ID.MBQF]={"/Assets/tpp/pack/location/mbqf/mbqf.fpk"}
locationPackTable[TppDefine.LOCATION_ID.FLYK]={"/Assets/tpp/pack/location/flyk/flyk.fpk"}
locationPackTable[TppDefine.LOCATION_ID.SSD_AFGH]={"/Assets/ssd/pack/location/afgh/afgh.fpk"}
locationPackTable[TppDefine.LOCATION_ID.SSD_OMBS]={"/Assets/ssd/pack/location/ombs/ombs.fpk"}
locationPackTable[TppDefine.LOCATION_ID.SSD_AFGH2]={"/Assets/ssd/pack/location/afgh2/afgh2.fpk"}
locationPackTable[TppDefine.LOCATION_ID.SAND_AFGH]={"/Assets/tpp_sandbox/pack/game_core/stage/gc_afgh.fpk"}
locationPackTable[TppDefine.LOCATION_ID.SAND_MAFR]={"/Assets/tpp/pack/location/mafr/mafr.fpk"}
locationPackTable[TppDefine.LOCATION_ID.SAND_MTBS]={"/Assets/tpp_sandbox/pack/game_core/stage/gc_mtbs.fpk"}
local missionPackTable={}
missionPackTable[1]={
  "/Assets/ssd/pack/ui/ssd_init_mission_ui.fpk",
  "/Assets/ssd/pack/ui/ssd_option_menu_ui.fpk",
  "/Assets/ssd/pack/mission/init/init.fpk"
}
missionPackTable[5]=function(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/init/title.fpk"
end
missionPackTable[1010]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/extra/e01010/e01010.fpk"
  TppPackList.AddAvatarEditPack()
end
missionPackTable[30010]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/free/f30010/f30010.fpk"
end
missionPackTable[10010]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/story/s10010/s10010.fpk"
  TppPackList.AddAvatarEditPack()
end
missionPackTable[10020]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/story/s10020/s10020.fpk"
end
missionPackTable[10050]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/story/s10050/s10050.fpk"
end
missionPackTable[20010]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/coop/c20010/c20010.fpk"
  TppPackList.AddMissionPack"/Assets/ssd/pack/collectible/rewardCbox/rewardCbox.fpk"
end
missionPackTable[20110]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/coop/c20110/c20110.fpk"
end
missionPackTable[21010]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/coop/c21010/c21010.fpk"
end
missionPackTable[12010]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/debug/s12010/s12010.fpk"
end
missionPackTable[12020]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/debug/s12020/s12020.fpk"
end
missionPackTable[12030]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/debug/s12030/s12030.fpk"
end
missionPackTable[32010]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/free/f32010/f32010.fpk"
end
missionPackTable[65010]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/debug/e65010/e65010.fpk"
end
missionPackTable[65020]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/extra/e65020/e65020.fpk"
end
missionPackTable[65030]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/extra/e65030/e65030.fpk"
end
missionPackTable[65040]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/extra/e65040/e65040.fpk"
end
missionPackTable[65060]=function(s)
  TppPackList.AddLocationCommonScriptPack(s)
  TppPackList.AddLocationCommonMissionAreaPack(s)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/extra/e65060/e65060.fpk"
end
function this.GetLocationPackagePath(locationId)
  local packPath=locationPackTable[locationId]
  if packPath then
  end
  TppLocation.SetBuddyBlock(locationId)
  return packPath
end
function this.GetMissionPackagePath(missionCode)
  TppPackList.SetUseDdEmblemFova(missionCode)
  local packPaths
  if missionPackTable[missionCode]==nil then
    packPaths=TppPackList.MakeMissionPackList(missionCode,TppPackList.MakeDefaultMissionPackList)
  elseif Tpp.IsTypeFunc(missionPackTable[missionCode])then
    packPaths=TppPackList.MakeMissionPackList(missionCode,missionPackTable[missionCode])
  elseif Tpp.IsTypeTable(missionPackTable[missionCode])then
    packPaths=missionPackTable[missionCode]
  end
  return packPaths
end
function this.IsStartHeliToMB()
end
return this
