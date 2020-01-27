-- ih_quest_q30101.lua
-- IH quest definition - mother base find the sheep
local this={
  questPackList={"/Assets/tpp/pack/mission2/quest/ih/ih_sheep_quest.fpk"},
  locationId=TppDefine.LOCATION_ID.MTBS,
  areaName="MtbsCombat",
  clusterName="Combat",
  plntId=TppDefine.PLNT_DEFINE.Special,
  category=TppQuest.QUEST_CATEGORIES_ENUM.CAPTURE_ANIMAL,
  questCompleteLangId="quest_extract_animal",
  canOpenQuest=InfQuest.CanOpenClusterGrade0,
  questRank=TppDefine.QUEST_RANK.G,
}
return this
