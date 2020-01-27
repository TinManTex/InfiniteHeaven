-- ih_quest_q30206.lua
-- IH quest definition - example quest, afgh wailo village hostage
local this={
  questPackList={  
     "/Assets/tpp/pack/mission2/quest/ih/quest_IH0005_ShifapRiver.fpk",--quest fpk
  },
  locationId=TppDefine.LOCATION_ID.MAFR,
  areaName="outland",--tex use the 'Show position' command in the debug menu to print the quest area you are in to ih_log.txt, see TppQuest. afgAreaList,mafrAreaList,mtbsAreaList. 
  --If areaName doesn't match the area the iconPos is in the quest fpk will fail to load (even though the Commencing Sideop message will trigger fine).
  iconPos=Vector3( -1137.373,-20.597, 217.835),--position of the quest area circle in idroid
  radius=6,--radius of the quest area circle
  category=TppQuest.QUEST_CATEGORIES_ENUM.ELIMINATE_ARMOR_VEHICLE,--Category for the IH selection/filtering options.
  questCompleteLangId="quest_defeat_armor_vehicle",--Used for feedback of quest progress, see REF questCompleteLangId in InfQuest
  canOpenQuest=InfQuest.AllwaysOpenQuest,--function that decides whether the quest is open or not
  questRank=TppDefine.QUEST_RANK.G,--reward rank for clearing quest, see TppDefine.QUEST_BONUS_GMP and TppHero.QUEST_CLEAR
  hasEnemyHeli=false,--set to true if you have added heliList in the quest script.
}

return this

