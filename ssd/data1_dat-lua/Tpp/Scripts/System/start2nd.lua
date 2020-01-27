local function yield()
  coroutine.yield()
end
dofile"/Assets/tpp/sound/scripts/motion/setup.lua"
yield()
local subtitlesDaemon=SubtitlesDaemon.GetInstance()
if SubtitlesCommand then
  dofile"/Assets/tpp/ui/Subtitles/script/priorityTable.lua"
  if TppGameSequence.IsMaster()==false then
    yield()
    dofile"/Assets/ssd/ui/Subtitles/script/sdTextRelationalTableNotEd.lua"
  end
end
yield()
if Script.LoadLibrary then
  Script.LoadLibrary"/Assets/ssd/level_asset/chara/player/game_object/SsdPlayerInitializeScript.lua"
  yield()
end
if TppSystemUtility.GetCurrentGameMode()~="MGO"then
  dofile"/Assets/tpp/radio/script/RadioParameterTable.lua"
end
