local function t()
  coroutine.yield()
end
dofile"/Assets/tpp/sound/scripts/motion/setup.lua"
t()
local e=SubtitlesDaemon.GetInstance()
if SubtitlesCommand then
  dofile"/Assets/tpp/ui/Subtitles/script/priorityTable.lua"
end
t()
dofile"/Assets/tpp/level_asset/chara/player/game_object/TppPlayer2InitializeScript.lua"
t()
if Script.LoadLibrary then
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting.lua"
  t()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting20BaseResSec.lua"
  t()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting30Deploy.lua"
  t()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting40RewardDeploy.lua"
  t()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting50RewardFob.lua"
  t()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MbmCommonSetting60DbPfLang.lua"
  t()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/EquipDevelopConstSetting.lua"
  t()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/EquipDevelopFlowSetting.lua"
  t()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/MotherBaseWeaponSpecSetting.lua"
  t()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/WeaponPartsUiSetting.lua"
  t()
  Script.LoadLibrary"/Assets/tpp/motherbase/script/WeaponPartsCombinationSettings.lua"
  t()
end
if TppSystemUtility.GetCurrentGameMode()~="MGO"then
  dofile"/Assets/tpp/radio/script/RadioParameterTable.lua"
end
