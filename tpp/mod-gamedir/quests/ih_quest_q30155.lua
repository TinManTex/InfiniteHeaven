-- ih_quest_q30155.lua - name of file is used as questName, filname can have any name as long as it has a q3<questId> suffix, see InfQuest.lua
-- pilot quest testbed
local this={
  questPackList={
    "/Assets/tpp/pack/mission2/ih/ih_hostage_base.fpk",--base hostage pack
    "/Assets/tpp/pack/mission2/ih/dds9_main0_mdl.fpk",--model pack, edit the partsType in the TppHostage2Parameter to match, see InfBodyInfo.lua for different body types.
    "/Assets/tpp/pack/mission2/quest/ih/ih_pilot_quest.fpk",--quest fpk
  },
  locationId=TppDefine.LOCATION_ID.MAFR,
  areaName="lab",--tex use the 'Show position' command in the debug menu to print the quest area you are in to ih_log.txt, see TppQuest. afgAreaList,mafrAreaList,mtbsAreaList.
  --If areaName doesn't match the area the iconPos is in the quest fpk will fail to load (even though the Commencing Sideop message will trigger fine).
  iconPos=Vector3(2617.876,100.002,-1857.330),--position of the quest area circle in idroid
  radius=4,--radius of the quest area circle
  category=TppQuest.QUEST_CATEGORIES_ENUM.PRISONER,--Category for the IH selection/filtering options.
  questCompleteLangId="quest_extract_hostage",--Used for feedback of quest progress, see REF questCompleteLangId in InfQuest
  canOpenQuest=InfQuest.AllwaysOpenQuest,--function that decides whether the quest is open or not
  questRank=TppDefine.QUEST_RANK.G,--reward rank for clearing quest, see TppDefine.QUEST_BONUS_GMP and TppHero.QUEST_CLEAR
  disableLzs={--disables lzs while the quest is active. Turn on the debugMessages option and look in ih_log.txt for StartedMoveToLandingZone after calling in a support heli to find the lz name.
    "lz_lab_S0000|lz_lab_S_0000",
  },
  requestEquipIds={--equipIds of TppPickable weapons in the quest.
    "EQP_WP_EX_hg_010",
  },
}

return this


































