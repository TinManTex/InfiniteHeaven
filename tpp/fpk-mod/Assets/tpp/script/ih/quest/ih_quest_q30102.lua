-- ih_quest_q30102.lua
-- IH quest definition - mother base clear out rats
local this={
  questPackList={
    "/Assets/tpp/pack/mission2/ih/ih_rat.fpk",
    "/Assets/tpp/pack/mission2/quest/ih/ih_rat_quest.fpk"
  },
  locationId=TppDefine.LOCATION_ID.MTBS,
  areaName="MtbsSupport",
  clusterName="Support",
  plntId=TppDefine.PLNT_DEFINE.Special,
  category=TppQuest.QUEST_CATEGORIES_ENUM.CAPTURE_ANIMAL,
  questCompleteLangId="quest_extract_animal",
  canOpenQuest=InfQuest.CanOpenClusterGrade0,
  questRank=TppDefine.QUEST_RANK.G,
}
return this
