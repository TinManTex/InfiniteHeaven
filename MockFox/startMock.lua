-- startMock.lua
if Script.LoadLibrary then
  local tppOrMgoPath
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    tppOrMgoPath="/Assets/mgo/"
  else
    tppOrMgoPath="/Assets/tpp/"
  end
  local filePath
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    filePath="/Assets/mgo/level_asset/weapon/ParameterTables/EquipIdTable.lua"
  else
    filePath="Tpp/Scripts/Equip/EquipIdTable.lua"
  end

  Script.LoadLibraryAsync(filePath)
  while Script.IsLoadingLibrary(filePath)do
    yield()
  end
  local filePath=tppOrMgoPath.."level_asset/weapon/ParameterTables/parts/EquipParameters.lua"
  if TppEquip.IsExistFile(filePath)then
    Script.LoadLibrary(filePath)
  else
    Script.LoadLibrary"Tpp/Scripts/Equip/EquipParameters.lua"
  end
  yield()
  local filePath=tppOrMgoPath.."level_asset/weapon/ParameterTables/parts/EquipMotionDataForChimera.lua"
  if TppEquip.IsExistFile(filePath)then
    Script.LoadLibrary(filePath)
  end

  Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/TppEnemyFaceId.lua"
  Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/TppEnemyBodyId.lua"
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    Script.LoadLibrary"/Assets/mgo/level_asset/player/ParameterTables/PlayerTables.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/player/ParameterTables/PlayerProgression.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/ChimeraPartsPackageTable.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/EquipParameterTables.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/EquipConfig.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/WeaponParameterTables.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/RulesetConfig.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/SafeSpawnConfig.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/SoundtrackConfig.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/PresetRadioConfig.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/player/Stats/StatTables.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/PointOfInterestConfig.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/damage/ParameterTables/DamageParameterTables.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/EquipMotionData.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/MgoWeaponParameters.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/GearConfig.lua"
  else
    yield()
    Script.LoadLibrary"Tpp/Scripts/Equip/ChimeraPartsPackageTable.lua"
    yield()
    Script.LoadLibrary"/Assets/tpp/level_asset/weapon/ParameterTables/EquipParameterTables.lua"
    yield()
    Script.LoadLibrary"/Assets/tpp/level_asset/damage/ParameterTables/DamageParameterTables.lua"
    yield()
    Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/Soldier2ParameterTables.lua"
    Script.LoadLibrary"Tpp/Scripts/Equip/EquipMotionData.lua"
    Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/TppEnemyFaceGroupId.lua"
    Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/TppEnemyFaceGroup.lua"
    yield()
    Script.LoadLibrary"/Assets/tpp/level_asset/chara/enemy/Soldier2FaceAndBodyData.lua"
    yield()
  end
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    Script.LoadLibrary"/Assets/mgo/level_asset/weapon/ParameterTables/RecoilMaterial/RecoilMaterialTable.lua"
  else
    Script.LoadLibrary"/Assets/tpp/level_asset/weapon/ParameterTables/RecoilMaterial/RecoilMaterialTable.lua"
  end
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    Script.LoadLibrary"/Assets/mgo/script/lib/Overrides.lua"
  end
  Script.LoadLibraryAsync"/Assets/tpp/script/lib/Tpp.lua"
  while Script.IsLoadingLibrary"/Assets/tpp/script/lib/Tpp.lua"do
    yield()
  end

  --tex TODO: to LoadLibraryAsync - if module.requires then load each requires
  local requires=Tpp.requires

  local requires={
    "/Assets/tpp/script/lib/InfRequiresStart.lua",--tex
    "/Assets/tpp/script/lib/TppDefine.lua",
    "/Assets/tpp/script/lib/TppMath.lua",
    --"/Assets/tpp/script/lib/TppSave.lua",
    "/Assets/tpp/script/lib/TppLocation.lua",
    "/Assets/tpp/script/lib/TppSequence.lua",
    "/Assets/tpp/script/lib/TppWeather.lua",
    "/Assets/tpp/script/lib/TppDbgStr32.lua",
    "/Assets/tpp/script/lib/TppDebug.lua",
    "/Assets/tpp/script/lib/TppClock.lua",
    --"/Assets/tpp/script/lib/TppUI.lua",
    --"/Assets/tpp/script/lib/TppResult.lua",
    "/Assets/tpp/script/lib/TppSound.lua",
    --"/Assets/tpp/script/lib/TppTerminal.lua",
    "/Assets/tpp/script/lib/TppMarker.lua",
    "/Assets/tpp/script/lib/TppRadio.lua",
    --"/Assets/tpp/script/lib/TppPlayer.lua",
    "/Assets/tpp/script/lib/TppHelicopter.lua",
    "/Assets/tpp/script/lib/TppScriptBlock.lua",
    --"/Assets/tpp/script/lib/TppMission.lua",
    "/Assets/tpp/script/lib/TppStory.lua",
    "/Assets/tpp/script/lib/TppDemo.lua",
    --"/Assets/tpp/script/lib/TppEnemy.lua",
    "/Assets/tpp/script/lib/TppGeneInter.lua",
    "/Assets/tpp/script/lib/TppInterrogation.lua",
    --"/Assets/tpp/script/lib/TppGimmick.lua",
    "/Assets/tpp/script/lib/TppMain.lua",
    "/Assets/tpp/script/lib/TppDemoBlock.lua",
    "/Assets/tpp/script/lib/TppAnimalBlock.lua",
    "/Assets/tpp/script/lib/TppCheckPoint.lua",
    "/Assets/tpp/script/lib/TppPackList.lua",
    --"/Assets/tpp/script/lib/TppQuest.lua",
    "/Assets/tpp/script/lib/TppTrap.lua",
    "/Assets/tpp/script/lib/TppReward.lua",
    --"/Assets/tpp/script/lib/TppRevenge.lua",
    "/Assets/tpp/script/lib/TppReinforceBlock.lua",
    "/Assets/tpp/script/lib/TppEneFova.lua",
    "/Assets/tpp/script/lib/TppFreeHeliRadio.lua",
    --"/Assets/tpp/script/lib/TppHero.lua",
    "/Assets/tpp/script/lib/TppTelop.lua",
    "/Assets/tpp/script/lib/TppRatBird.lua",
    "/Assets/tpp/script/lib/TppMovie.lua",
    --"/Assets/tpp/script/lib/TppAnimal.lua",
    --"/Assets/tpp/script/lib/TppException.lua",
    --"/Assets/tpp/script/lib/TppTutorial.lua",
    "/Assets/tpp/script/lib/TppLandingZone.lua",
    "/Assets/tpp/script/lib/TppCassette.lua",
    "/Assets/tpp/script/lib/TppEmblem.lua",
    "/Assets/tpp/script/lib/TppDevelopFile.lua",
    "/Assets/tpp/script/lib/TppPaz.lua",
    --"/Assets/tpp/script/lib/TppRanking.lua",
    --"/Assets/tpp/script/lib/TppTrophy.lua",
    "/Assets/tpp/script/lib/TppMbFreeDemo.lua",
    "/Assets/tpp/script/lib/InfButton.lua",--tex>
    "/Assets/tpp/script/lib/InfModules.lua",
    "/Assets/tpp/script/lib/InfMain.lua",
    "/Assets/tpp/script/lib/InfMenu.lua",
    "/Assets/tpp/script/lib/InfEneFova.lua",
    "/Assets/tpp/script/lib/InfRevenge.lua",
    "/Assets/tpp/script/lib/InfFova.lua",
    "/Assets/tpp/script/lib/InfLZ.lua",
    "/Assets/tpp/script/lib/InfPersistence.lua",
    "/Assets/tpp/script/lib/InfHooks.lua",--<
  }

  for i,modulePath in ipairs(requires)do
    Script.LoadLibrary(modulePath)
  end

  Script.LoadLibrary"/Assets/tpp/script/lib/TppDefine.lua"
  Script.LoadLibrary"/Assets/tpp/script/lib/TppVarInit.lua"
  --Script.LoadLibrary"/Assets/tpp/script/lib/TppGVars.lua"
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    Script.LoadLibrary"/Assets/mgo/script/utils/SaveLoad.lua"
    Script.LoadLibrary"/Assets/mgo/script/lib/PostTppOverrides.lua"
    Script.LoadLibrary"/Assets/mgo/script/lib/MgoMain.lua"
    Script.LoadLibrary"Tpp/Scripts/System/Block/Overflow.lua"
    Script.LoadLibrary"/Assets/mgo/level_asset/config/TppMissionList.lua"
    Script.LoadLibrary"/Assets/mgo/script/utils/Utils.lua"
    Script.LoadLibrary"/Assets/mgo/script/gear/RegisterGear.lua"
    Script.LoadLibrary"/Assets/mgo/script/gear/RegisterConnectPointFiles.lua"
    Script.LoadLibrary"/Assets/mgo/script/player/PlayerResources.lua"
    Script.LoadLibrary"/Assets/mgo/script/player/PlayerDefaults.lua"
    Script.LoadLibrary"/Assets/mgo/script/Matchmaking.lua"
  else
    Script.LoadLibrary"/Assets/tpp/script/list/TppMissionList.lua"
    Script.LoadLibrary"/Assets/tpp/script/list/TppQuestList.lua"
  end
end
yield()
pcall(dofile,"/Assets/tpp/ui/Script/UiRegisterInfo.lua")

Script.LoadLibrary"/Assets/tpp/level_asset/chara/player/game_object/player2_camouf_param.lua"

yield()

--loadfile"Tpp/Scripts/System/start2nd.lua"--tex TODO DEBUG loadfile hangs in LDT?
--do
--  local e=coroutine.create(loadfile"Tpp/Scripts/System/start2nd.lua")
--  repeat
--    coroutine.yield()
--    local a,t=coroutine.resume(e)
--    if not a then
--      error(t)
--    end
--  until coroutine.status(e)=="dead"
--end
--if TppSystemUtility.GetCurrentGameMode()=="MGO"then
--  dofile"Tpp/Scripts/System/start3rd.lua"
--end


print"parse: starMock done"