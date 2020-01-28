-- ih_quest_q30101.lua
-- IH quest definition - mother base clear out birds
local this={
  questPackList={
    "/Assets/tpp/pack/mission2/ih/ih_raven.fpk",
    "/Assets/tpp/pack/mission2/quest/ih/ih_bird_quest.fpk"
  },
  locationId=TppDefine.LOCATION_ID.MTBS,
  areaName="MtbsSpy",
  clusterName="Spy",
  plntId=TppDefine.PLNT_DEFINE.Special,
  category=TppQuest.QUEST_CATEGORIES_ENUM.CAPTURE_ANIMAL,
  questCompleteLangId="announce_quest_extract_animal",
  canOpenQuest=InfQuest.CanOpenClusterGrade0,
  questRank=TppDefine.QUEST_RANK.G,
}
return this
