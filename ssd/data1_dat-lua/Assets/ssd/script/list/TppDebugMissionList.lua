local this={}
local a={}
a[6e4]={"/Assets/ssd/pack/location/init/init.fpk"}
a[61010]={"/Assets/ssd_sandbox/pack/game_core/stage/smpl/simple_test_stage.fpk"}
a[63010]={"/Assets/ssd_sandbox/pack/game_core/stage/balkan/balkan_simple_test_stage.fpk"}
local s={}
s[6e4]={"/Assets/ssd/pack/mission/debug/60000/select.fpk"}
s[61020]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/fog_wall_test/fog_wall_test.fpk"
end
s[61100]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/story/s10010/s10010.fpk"
  TppPackList.AddAvatarMaleEditPack()
end
s[61101]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/story/s10010/s10010.fpk"
  TppPackList.AddAvatarFemaleEditPack()
end
s[61200]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/tpp_sandbox/pack/hatsu/mission/crowd_test.fpk"
end
s[61210]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/boss_test/boss_test.fpk"
end
s[61211]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/boss_test2/boss_test2.fpk"
end
s[61220]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/boss_test_kaiju/boss_test_kaiju.fpk"
end
s[61230]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/insect_test/insect_test.fpk"
end
s[61231]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/insect_test2/insect_test2.fpk"
end
s[61240]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/boss_test_kaiju/boss_test_kaiju2.fpk"
end
s[61290]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/crew_test/crew_test.fpk"
end
s[61250]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/walkergear_test/walkergear_test.fpk"
end
s[61260]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/vehicle_test/vehicle_test.fpk"
end
s[61270]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/animal_test/animal_test.fpk"
end
s[61271]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/farming_animal_test/farming_animal_test.fpk"
end
s[61272]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/bird_rat_test/bird_rat_test.fpk"
end
s[62300]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/gimmick_test/gimmick_test.fpk"
end
s[62310]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/gimmick_test_building/gimmick_test_building.fpk"
end
s[63e3]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/balkan/test/balkan_test.fpk"
end
s[63010]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/balkan/muto_test/balkan_muto_test.fpk"
end
s[63020]=function(i)
  TppPackList.AddLocationCommonScriptPack(i)
  TppPackList.AddLocationCommonMissionAreaPack(i)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/balkan/ogushi_test/balkan_ogushi_test.fpk"
end
s[63030]=function(s)
  TppPackList.AddLocationCommonScriptPack(s)
  TppPackList.AddLocationCommonMissionAreaPack(s)
  TppPackList.AddMissionPack"/Assets/ssd_sandbox/pack/mission/balkan/player_test/balkan_player_test.fpk"
end
function this.GetLocationPackagePath(s)
  return a[s]
end
function this.GetMissionPackagePath(i)
  local a
  if Tpp.IsTypeFunc(s[i])then
    a=TppPackList.MakeMissionPackList(i,s[i])
  elseif Tpp.IsTypeTable(s[i])then
    a=s[i]
  end
  return a
end
if Mission.DEBUG_SetLocationPackagePathFunc then
  Mission.DEBUG_SetLocationPackagePathFunc(this.GetLocationPackagePath)
end
if Mission.DEBUG_SetMissionPackagePathFunc then
  Mission.DEBUG_SetMissionPackagePathFunc(this.GetMissionPackagePath)
end
return this
