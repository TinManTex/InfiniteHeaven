local this={}
this.BLOCKTYPE={GROUP_A="quest_block_1",GROUP_B="quest_block_2",GROUP_C="quest_block_3"}
this.QUEST_INFO_DEFINE={{name="field_q22010",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q22010.fpk",guideLineId="guidelines_quest_fastTravel",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40015
end},{name="field_q22020",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q22020.fpk",guideLineId="guidelines_quest_fastTravel",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40015
end},{name="field_q22030",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q22030.fpk",guideLineId="guidelines_quest_fastTravel",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40030
end},{name="field_q22040",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q22040.fpk",guideLineId="guidelines_quest_fastTravel",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40030
end},{name="village_q22050",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q22050.fpk",guideLineId="guidelines_quest_fastTravel",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40077
end},{name="village_q22060",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q22060.fpk",guideLineId="guidelines_quest_fastTravel",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40080
end},{name="village_q22140",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q22140.fpk",guideLineId="guidelines_quest_fastTravel",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40077
end},{name="village_q22150",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q22150.fpk",guideLineId="guidelines_quest_fastTravel",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40090
end},{name="diamond_q22090",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q22090.fpk",guideLineId="guidelines_quest_fastTravel",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40180
end},{name="diamond_q22100",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q22100.fpk",guideLineId="guidelines_quest_fastTravel",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40180
end},{name="diamond_q22120",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q22120.fpk",guideLineId="guidelines_quest_fastTravel",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40220
end},{name="diamond_q22130",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q22130.fpk",guideLineId="guidelines_quest_fastTravel",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40180
end},{name="diamond_q22160",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q22160.fpk",guideLineId="guidelines_quest_fastTravel",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40160
end},{name="field_q11010",pack={"/Assets/ssd/pack/mission/quest/afgh/field/field_q11010.fpk","/Assets/ssd/pack/mission/quest/afgh/field/field_q11010_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40090
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q11020",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q11020.fpk",guideLineId="guideline_quest_kub",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40015
end,lockCondition=function()
return TppQuest.IsCleard"field_q11020"end},{name="field_q11030",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q11030.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q11040",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q11040.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q11050",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q11050.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q11060",pack={"/Assets/ssd/pack/mission/quest/afgh/village/village_q11060.fpk","/Assets/ssd/pack/mission/quest/afgh/village/village_q11060_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40080
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q11070",pack={"/Assets/ssd/pack/mission/quest/afgh/field/field_q11070.fpk","/Assets/ssd/pack/mission/quest/afgh/field/field_q11070_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40130
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q11080",pack={"/Assets/ssd/pack/mission/quest/afgh/field/field_q11080.fpk","/Assets/ssd/pack/mission/quest/afgh/field/field_q11080_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q11100",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q11100.fpk",guideLineId="guideline_quest_kub",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40140
end,lockCondition=function()
return TppQuest.IsCleard"village_q11100"end},{name="village_q11110",pack={"/Assets/ssd/pack/mission/quest/afgh/village/village_q11110.fpk","/Assets/ssd/pack/mission/quest/afgh/village/village_q11110_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q11090",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q11090.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q11120",pack={"/Assets/ssd/pack/mission/quest/afgh/field/field_q11120.fpk","/Assets/ssd/pack/mission/quest/afgh/field/field_q11120_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q11130",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q11130.fpk",guideLineId="guidelines_quest_container",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40130
end},{name="field_q11140",pack={"/Assets/ssd/pack/mission/quest/afgh/field/field_q11140.fpk","/Assets/ssd/pack/mission/quest/afgh/field/field_q11140_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q11150",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q11150.fpk",guideLineId="guideline_quest_kub",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40080
end,lockCondition=function()
return TppQuest.IsCleard"village_q11150"end},{name="village_q11160",pack={"/Assets/ssd/pack/mission/quest/afgh/village/village_q11160.fpk","/Assets/ssd/pack/mission/quest/afgh/village/village_q11160_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40090
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q11170",pack={"/Assets/ssd/pack/mission/quest/afgh/village/village_q11170.fpk","/Assets/ssd/pack/mission/quest/afgh/village/village_q11170_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q11180",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q11180.fpk",guideLineId="guideline_quest_kub",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40080
end,lockCondition=function()
return TppQuest.IsCleard"village_q11180"end},{name="field_q11190",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q11190.fpk",guideLineId="guideline_quest_kub",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40020
end,lockCondition=function()
return TppQuest.IsCleard"field_q11190"end},{name="field_q11200",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q11200.fpk",guideLineId="guidelines_quest_container",isOnce=true,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40020
end},{name="village_q11210",pack={"/Assets/ssd/pack/mission/quest/afgh/village/village_q11210.fpk","/Assets/ssd/pack/mission/quest/afgh/village/village_q11210_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q11220",pack={"/Assets/ssd/pack/mission/quest/afgh/field/field_q11220.fpk","/Assets/ssd/pack/mission/quest/afgh/field/field_q11220_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40310
end},{name="village_q11230",pack={"/Assets/ssd/pack/mission/quest/afgh/village/village_q11230.fpk","/Assets/ssd/pack/mission/quest/afgh/village/village_q11230_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q11240",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q11240.fpk",guideLineId="guideline_quest_kub",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40015
end,lockCondition=function()
return TppQuest.IsCleard"field_q11240"end},{name="field_q11250",pack={"/Assets/ssd/pack/mission/quest/afgh/field/field_q11250.fpk","/Assets/ssd/pack/mission/quest/afgh/field/field_q11250_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=72,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40077
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q11260",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q11260.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q11270",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q11270.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q11280",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q11280.fpk",guideLineId="guideline_quest_kub",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_DEFENSE_AREA_1
end,lockCondition=function()
return TppQuest.IsCleard"field_q11280"end},{name="village_q11290",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q11290.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q11700",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q11700.fpk",guideLineId="guideline_quest_kub",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40090
end,lockCondition=function()
return TppQuest.IsCleard"village_q11700"end},{name="village_q11710",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q11710.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q11720",pack={"/Assets/ssd/pack/mission/quest/afgh/field/field_q11720.fpk","/Assets/ssd/pack/mission/quest/afgh/field/field_q11720_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40310
end},{name="village_q11730",pack={"/Assets/ssd/pack/mission/quest/afgh/village/village_q11730.fpk","/Assets/ssd/pack/mission/quest/afgh/village/village_q11730_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q11740",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q11740.fpk",guideLineId="guideline_quest_kub",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40080
end,lockCondition=function()
return TppQuest.IsCleard"village_q11740"end},{name="village_q11750",pack={"/Assets/ssd/pack/mission/quest/afgh/village/village_q11750.fpk","/Assets/ssd/pack/mission/quest/afgh/village/village_q11750_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40077
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q11760",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q11760.fpk",guideLineId="guideline_quest_kub",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40077
end,lockCondition=function()
return TppQuest.IsCleard"field_q11760"end},{name="field_q44050",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q44050.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q44010",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q44010.fpk",guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return false
end},{name="village_q44020",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q44020.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q44030",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q44030.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q44040",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q44040.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q44060",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q44060.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q44070",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q44070.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q44080",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q44080.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q44090",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q44090.fpk",guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return false
end},{name="field_q44100",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q44100.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=72,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40250
end},{name="field_q44110",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q44110.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=72,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q44120",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q44120.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q44130",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q44130.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=72,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40250
end},{name="field_q44140",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q44140.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q44150",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q44150.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q44160",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q44160.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q44170",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q44170.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q44180",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q44180.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q44190",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q44190.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q44200",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q44200.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q33080",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q33080.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40220
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q33090",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q33090.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_s10050
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q33100",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q33100.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q33110",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q33110.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,conditionFunc=function()
return false
end},{name="factory_q11300",pack={"/Assets/ssd/pack/mission/quest/mafr/factory/factory_q11300.fpk","/Assets/ssd/pack/mission/quest/mafr/factory/factory_q11300_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q11310",pack={"/Assets/ssd/pack/mission/quest/mafr/factory/factory_q11310.fpk","/Assets/ssd/pack/mission/quest/mafr/factory/factory_q11310_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40170
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q11320",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q11320.fpk",guideLineId="guideline_quest_kub",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40220
end,lockCondition=function()
return TppQuest.IsCleard"factory_q11320"end},{name="factory_q11330",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q11330.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q11340",pack={"/Assets/ssd/pack/mission/quest/mafr/factory/factory_q11340.fpk","/Assets/ssd/pack/mission/quest/mafr/factory/factory_q11340_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q33040",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q33040.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40090
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q33050",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q33050.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q33060",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q33060.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40130
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q33070",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q33070.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40130
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q33071",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q33071.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q33010",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q33010.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40090
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q33020",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q33020.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_DEFENSE_AREA_1
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q33030",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q33030.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q44220",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q44220.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=72,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40250
end},{name="factory_q44210",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q44210.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=72,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40250
end},{name="factory_q44230",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q44230.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q44240",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q44240.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="diamond_q44250",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q44250.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="diamond_q44260",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q44260.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="lab_q44270",pack="/Assets/ssd/pack/mission/quest/mafr/lab/lab_q44270.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="lab_q44280",pack="/Assets/ssd/pack/mission/quest/mafr/lab/lab_q44280.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="lab_q44290",pack="/Assets/ssd/pack/mission/quest/mafr/lab/lab_q44290.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="lab_q44300",pack="/Assets/ssd/pack/mission/quest/mafr/lab/lab_q44300.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="diamond_q33260",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q33260.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40220
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="diamond_q33270",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q33270.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q33220",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q33220.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_s10050
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q33230",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q33230.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q33240",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q33240.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=120,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q33250",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q33250.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=96,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="lab_q33280",pack="/Assets/ssd/pack/mission/quest/mafr/lab/lab_q33280.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=96,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="lab_q33290",pack="/Assets/ssd/pack/mission/quest/mafr/lab/lab_q33290.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=96,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="lab_q33300",pack="/Assets/ssd/pack/mission/quest/mafr/lab/lab_q33300.fpk",guideLineId="guidelines_quest_signal",openTime=48,closeTime=96,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40310
end},{name="factory_q11350",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q11350.fpk",guideLineId="guidelines_quest_container",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40220
end},{name="field_q54010",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q54010.fpk",guideLineId="guidelines_quest_animal",openTime=24,closeTime=72,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q54020",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q54020.fpk",guideLineId="guidelines_quest_animal",openTime=24,closeTime=72,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_ANUBIS,"Anubis","AnubisNormal"}}},{name="field_q54030",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q54030.fpk",guideLineId="guidelines_quest_animal",openTime=24,closeTime=72,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_OKAPI,"Okapi","OkapiNormal"}}},{name="village_q54040",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q54040.fpk",guideLineId="guidelines_quest_animal",openTime=24,closeTime=72,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q54050",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q54050.fpk",guideLineId="guidelines_quest_animal",openTime=24,closeTime=72,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_ANUBIS,"Anubis","AnubisNormal"}}},{name="village_q54060",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q54060.fpk",guideLineId="guidelines_quest_animal",openTime=24,closeTime=72,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_KASHMIR_BEAR,"KashmirBear","KashmirBearNormal"}}},{name="factory_q54070",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q54070.fpk",guideLineId="guidelines_quest_animal",openTime=24,closeTime=72,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q54080",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q54080.fpk",guideLineId="guidelines_quest_animal",openTime=24,closeTime=72,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_ANUBIS,"Anubis","AnubisNormal"}}},{name="diamond_q54090",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q54090.fpk",guideLineId="guidelines_quest_animal",openTime=24,closeTime=72,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="lab_q54100",pack="/Assets/ssd/pack/mission/quest/mafr/lab/lab_q54100.fpk",guideLineId="guidelines_quest_animal",openTime=24,closeTime=72,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_KASHMIR_BEAR,"KashmirBear","KashmirBearNormal"}}},{name="field_q11901",pack={"/Assets/ssd/pack/mission/quest/afgh/field/field_q11901.fpk","/Assets/ssd/pack/mission/quest/afgh/field/field_q11901_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=72,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40220
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q11902",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q11902.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q11903",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q11903.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q11911",pack={"/Assets/ssd/pack/mission/quest/afgh/village/village_q11911.fpk","/Assets/ssd/pack/mission/quest/afgh/village/village_q11911_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q11912",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q11912.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="village_q11913",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q11913.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q11921",pack={"/Assets/ssd/pack/mission/quest/mafr/factory/factory_q11921.fpk","/Assets/ssd/pack/mission/quest/mafr/factory/factory_q11921_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q11922",pack={"/Assets/ssd/pack/mission/quest/mafr/factory/factory_q11922.fpk","/Assets/ssd/pack/mission/quest/mafr/factory/factory_q11922_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=72,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40220
end,lockCondition=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q11923",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q11923.fpk",guideLineId="guideline_quest_kub",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40180
end,lockCondition=function()
return TppQuest.IsCleard"factory_q11923"end},{name="lab_q11924",pack="/Assets/ssd/pack/mission/quest/mafr/lab/lab_q11924.fpk",guideLineId="guidelines_quest_container",isOnce=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40220
end},{name="lab_q11925",pack={"/Assets/ssd/pack/mission/quest/mafr/lab/lab_q11925.fpk","/Assets/ssd/pack/mission/quest/mafr/lab/lab_q11925_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="lab_q11926",pack="/Assets/ssd/pack/mission/quest/mafr/lab/lab_q11926.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="diamond_q11928",pack={"/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q11928.fpk","/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q11928_effect.fpk"},guideLineId="guideline_quest_defense",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="diamond_q11929",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q11929.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="diamond_q11930",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q11930.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=48,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="lab_q11931",pack="/Assets/ssd/pack/mission/quest/mafr/lab/lab_q11931.fpk",guideLineId="guidelines_quest_container",openTime=24,closeTime=72,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="field_q61010",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q61010.fpk",guideLineId="guidelines_quest_zombie_enhanced",openTime=24,closeTime=120,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_BASE_DEFENSE_TUTORIAL
end,lockCondition=function()
return TppQuest.IsCleard"field_q61010"end},{name="diamond_q61020",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q61020.fpk",guideLineId="guidelines_quest_zombie_enhanced",openTime=24,closeTime=120,conditionFunc=function()
return TppQuest.IsCleard"field_q61010"end,lockCondition=function()
return TppQuest.IsCleard"diamond_q61020"end},{name="diamond_q61030",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q61030.fpk",guideLineId="guidelines_quest_zombie_enhanced",openTime=24,closeTime=120,conditionFunc=function()
return false
end},{name="village_q61040",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q61040.fpk",guideLineId="guidelines_quest_zombie_enhanced",openTime=24,closeTime=120,conditionFunc=function()
return false
end},{name="base_q54110",pack="/Assets/ssd/pack/mission/quest/afgh/base/base_q54110.fpk",guideLineId="guideline_quest_animal_S",openTime=24,closeTime=72,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40060
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_JACKAL,"Jackal","JackalNormal"}}},{name="base_q54120",pack="/Assets/ssd/pack/mission/quest/afgh/base/base_q54120.fpk",guideLineId="guideline_quest_animal_M",openTime=24,closeTime=72,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40060
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_NUBIAN,"Nubian","NubianNormal"}}},{name="base_q54130",pack="/Assets/ssd/pack/mission/quest/afgh/base/base_q54130.fpk",guideLineId="guideline_quest_animal_M",openTime=24,closeTime=72,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40070
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_NUBIAN,"Nubian","NubianNormal"}}},{name="field_q54140",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q54140.fpk",guideLineId="guideline_quest_animal_S",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40030
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_JACKAL,"Jackal","JackalNormal"}}},{name="field_q54150",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q54150.fpk",guideLineId="guideline_quest_animal_M",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40130
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_ZEBRA,"Zebra","ZebraNormal"}}},{name="field_q54160",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q54160.fpk",guideLineId="guideline_quest_animal_S",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40015
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_JACKAL,"Jackal","JackalNormal"}}},{name="field_q54170",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q54170.fpk",guideLineId="guideline_quest_animal_M",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40140
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_ZEBRA,"Zebra","ZebraNormal"}}},{name="village_q54180",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q54180.fpk",guideLineId="guideline_quest_animal_L",openTime=24,closeTime=60,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40077
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_BEAR,"Bear","BearNormal"}}},{name="village_q54190",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q54190.fpk",guideLineId="guideline_quest_animal_M",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40077
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_DONKEY,"Donkey","DonkeyNormal"}}},{name="village_q54200",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q54200.fpk",guideLineId="guideline_quest_animal_M",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40080
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_DONKEY,"Donkey","DonkeyNormal"}}},{name="village_q54210",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q54210.fpk",guideLineId="guideline_quest_animal_S",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40080
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_LYCAON,"Lycaon","LycaonNormal"}}},{name="village_q54220",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q54220.fpk",guideLineId="guideline_quest_animal_S",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40090
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_JACKAL,"Jackal","JackalNormal"}}},{name="village_q54230",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q54230.fpk",guideLineId="guideline_quest_animal_L",openTime=24,closeTime=60,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40090
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_BEAR,"Bear","BearNormal"}}},{name="factory_q54240",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q54240.fpk",guideLineId="guideline_quest_animal_M",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_SHEEP,"Sheep","SheepNormal"}}},{name="factory_q54250",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q54250.fpk",guideLineId="guideline_quest_animal_M",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_GOAT,"Goat","GoatNormal"}}},{name="factory_q54260",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q54260.fpk",guideLineId="guideline_quest_animal_M",openTime=24,closeTime=60,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40160
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_GOAT,"Goat","GoatNormal"}}},{name="factory_q54270",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q54270.fpk",guideLineId="guideline_quest_animal_S",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40160
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_WOLF,"Wolf","WolfNormal"}}},{name="lab_q54280",pack="/Assets/ssd/pack/mission/quest/mafr/lab/lab_q54280.fpk",guideLineId="guideline_quest_animal_S",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40180
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_WOLF,"Wolf","WolfNormal"}}},{name="lab_q54290",pack="/Assets/ssd/pack/mission/quest/mafr/lab/lab_q54290.fpk",guideLineId="guideline_quest_animal_L",openTime=24,closeTime=60,isOrder=true,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40180
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_BEAR,"Bear","BearNormal"}}},{name="diamond_q54300",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q54300.fpk",guideLineId="guideline_quest_animal_S",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40220
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_WOLF,"Wolf","WolfNormal"}}},{name="diamond_q54310",pack="/Assets/ssd/pack/mission/quest/mafr/diamond/diamond_q54310.fpk",guideLineId="guideline_quest_animal_S",openTime=24,closeTime=48,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40220
end,npcs={{TppGameObject.GAME_OBJECT_TYPE_WOLF,"Wolf","WolfNormal"}}},{name="field_q74010",pack="/Assets/ssd/pack/mission/quest/afgh/field/field_q74010.fpk",guideLineId="guideline_quest_walkerGear",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40077
end},{name="village_q74020",pack="/Assets/ssd/pack/mission/quest/afgh/village/village_q74020.fpk",guideLineId="guideline_quest_walkerGear",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end},{name="factory_q74030",pack="/Assets/ssd/pack/mission/quest/mafr/factory/factory_q74030.fpk",guideLineId="guideline_quest_walkerGear",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40180
end},{name="lab_q74040",pack="/Assets/ssd/pack/mission/quest/mafr/lab/lab_q74040.fpk",guideLineId="guideline_quest_walkerGear",openTime=24,closeTime=24,conditionFunc=function()
return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST
end}}
this.questList={{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_A01",blockType=this.BLOCKTYPE.GROUP_A,loadArea={127,148,130,152},infoList={{name="field_q44110",invokeStepName="Quest_Main"},{name="field_q44100",invokeStepName="Quest_Main"},{name="base_q54110",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_A02",blockType=this.BLOCKTYPE.GROUP_A,loadArea={132,151,134,153},infoList={{name="field_q54020",invokeStepName="Quest_Main"},{name="field_q54150",invokeStepName="Quest_Main"},{name="field_q54140",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_A03",blockType=this.BLOCKTYPE.GROUP_A,loadArea={136,149,139,152},infoList={{name="field_q11030",invokeStepName="Quest_Main"},{name="field_q11902",invokeStepName="Quest_Main"},{name="field_q11140",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_A04",blockType=this.BLOCKTYPE.GROUP_A,loadArea={128,144,130,146},infoList={{name="field_q22020",invokeStepName="Quest_Main"},{name="field_q44040",invokeStepName="Quest_Main"},{name="field_q11070",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_A05",blockType=this.BLOCKTYPE.GROUP_A,loadArea={132,146,134,149},infoList={{name="field_q11200",invokeStepName="Quest_Main"},{name="field_q44050",invokeStepName="Quest_Main"},{name="field_q11050",invokeStepName="Quest_Main"},{name="field_q11220",invokeStepName="Quest_Main"},{name="field_q54030",invokeStepName="Quest_Main"},{name="field_q54170",invokeStepName="Quest_Main"},{name="field_q54160",invokeStepName="Quest_Main"},{name="field_q11190",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_A06",blockType=this.BLOCKTYPE.GROUP_A,loadArea={136,145,139,147},infoList={{name="village_q11130",invokeStepName="Quest_Main"},{name="village_q44070",invokeStepName="Quest_Main"},{name="village_q11290",invokeStepName="Quest_Main"},{name="village_q11040",invokeStepName="Quest_Main"},{name="village_q11750",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_A07",blockType=this.BLOCKTYPE.GROUP_A,loadArea={141,145,143,147},infoList={{name="village_q22140",invokeStepName="Quest_Main"},{name="village_q11911",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_A08",blockType=this.BLOCKTYPE.GROUP_A,loadArea={132,138,139,143},infoList={{name="village_q61040",invokeStepName="Quest_Main"},{name="village_q74020",invokeStepName="Quest_Main"},{name="village_q44190",invokeStepName="Quest_Main"},{name="village_q44120",invokeStepName="Quest_Main"},{name="village_q44020",invokeStepName="Quest_Main"},{name="village_q11912",invokeStepName="Quest_Main"},{name="village_q11090",invokeStepName="Quest_Main"},{name="village_q44080",invokeStepName="Quest_Main"},{name="village_q11170",invokeStepName="Quest_Main"},{name="village_q11210",invokeStepName="Quest_Main"},{name="village_q11160",invokeStepName="Quest_Main"},{name="village_q54220",invokeStepName="Quest_Main"},{name="village_q11100",invokeStepName="Quest_Main"},{name="village_q11700",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_A09",blockType=this.BLOCKTYPE.GROUP_A,loadArea={141,138,143,143},infoList={{name="village_q22060",invokeStepName="Quest_Main"},{name="village_q44170",invokeStepName="Quest_Main"},{name="village_q44060",invokeStepName="Quest_Main"},{name="village_q11060",invokeStepName="Quest_Main"},{name="village_q54050",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_B02",blockType=this.BLOCKTYPE.GROUP_B,loadArea={127,150,133,152},infoList={{name="field_q11260",invokeStepName="Quest_Main"},{name="field_q11250",invokeStepName="Quest_Main"},{name="field_q54010",invokeStepName="Quest_Main"},{name="field_q11240",invokeStepName="Quest_Main"},{name="field_q11020",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_B03",blockType=this.BLOCKTYPE.GROUP_B,loadArea={135,146,143,152},infoList={{name="field_q22030",invokeStepName="Quest_Main"},{name="field_q22040",invokeStepName="Quest_Main"},{name="field_q61010",invokeStepName="Quest_Main"},{name="field_q44160",invokeStepName="Quest_Main"},{name="field_q44030",invokeStepName="Quest_Main"},{name="field_q11903",invokeStepName="Quest_Main"},{name="field_q11270",invokeStepName="Quest_Main"},{name="field_q44140",invokeStepName="Quest_Main"},{name="field_q11720",invokeStepName="Quest_Main"},{name="field_q11080",invokeStepName="Quest_Main"},{name="village_q54180",invokeStepName="Quest_Main"},{name="village_q54190",invokeStepName="Quest_Main"},{name="field_q11760",invokeStepName="Quest_Main"},{name="field_q11280",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_B04",blockType=this.BLOCKTYPE.GROUP_B,loadArea={127,145,129,148},infoList={{name="field_q11901",invokeStepName="Quest_Main"},{name="field_q11010",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_B05",blockType=this.BLOCKTYPE.GROUP_B,loadArea={131,145,133,148},infoList={{name="field_q22010",invokeStepName="Quest_Main"},{name="field_q44150",invokeStepName="Quest_Main"},{name="field_q11120",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_B08",blockType=this.BLOCKTYPE.GROUP_B,loadArea={138,142,143,144},infoList={{name="village_q44200",invokeStepName="Quest_Main"},{name="village_q44180",invokeStepName="Quest_Main"},{name="village_q11913",invokeStepName="Quest_Main"},{name="village_q11710",invokeStepName="Quest_Main"},{name="village_q11230",invokeStepName="Quest_Main"},{name="village_q11730",invokeStepName="Quest_Main"},{name="village_q11740",invokeStepName="Quest_Main"},{name="village_q11180",invokeStepName="Quest_Main"},{name="village_q11150",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_B09",blockType=this.BLOCKTYPE.GROUP_B,loadArea={134,138,143,140},infoList={{name="village_q22150",invokeStepName="Quest_Main"},{name="village_q44130",invokeStepName="Quest_Main"},{name="village_q11110",invokeStepName="Quest_Main"},{name="village_q54060",invokeStepName="Quest_Main"},{name="village_q54040",invokeStepName="Quest_Main"},{name="village_q54230",invokeStepName="Quest_Main"},{name="village_q54210",invokeStepName="Quest_Main"},{name="village_q54200",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.SSD_AFGH,areaName="afgh_C",blockType=this.BLOCKTYPE.GROUP_C,loadArea={101,101,164,164},infoList={{name="field_q74010",invokeStepName="Quest_Main"},{name="village_q22050",invokeStepName="Quest_Main"},{name="field_q33020",invokeStepName="Quest_Main"},{name="field_q33010",invokeStepName="Quest_Main"},{name="village_q33040",invokeStepName="Quest_Main"},{name="village_q33060",invokeStepName="Quest_Main"},{name="village_q33070",invokeStepName="Quest_Main"},{name="field_q33030",invokeStepName="Quest_Main"},{name="village_q33050",invokeStepName="Quest_Main"},{name="village_q33071",invokeStepName="Quest_Main"},{name="base_q54130",invokeStepName="Quest_Main"},{name="base_q54120",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.MAFR,areaName="mafr_A01",blockType=this.BLOCKTYPE.GROUP_A,loadArea={141,119,145,124},infoList={{name="diamond_q22120",invokeStepName="Quest_Main"},{name="diamond_q61030",invokeStepName="Quest_Main"},{name="diamond_q61020",invokeStepName="Quest_Main"},{name="diamond_q44250",invokeStepName="Quest_Main"},{name="diamond_q11930",invokeStepName="Quest_Main"},{name="diamond_q11928",invokeStepName="Quest_Main"},{name="diamond_q54090",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.MAFR,areaName="mafr_A02",blockType=this.BLOCKTYPE.GROUP_A,loadArea={150,125,152,129},infoList={{name="factory_q11350",invokeStepName="Quest_Main"},{name="factory_q44220",invokeStepName="Quest_Main"},{name="factory_q54080",invokeStepName="Quest_Main"},{name="factory_q54070",invokeStepName="Quest_Main"},{name="factory_q54260",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.MAFR,areaName="mafr_A03",blockType=this.BLOCKTYPE.GROUP_A,loadArea={154,125,156,127},infoList={{name="factory_q44210",invokeStepName="Quest_Main"},{name="factory_q54250",invokeStepName="Quest_Main"},{name="factory_q54240",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.MAFR,areaName="mafr_A04",blockType=this.BLOCKTYPE.GROUP_A,loadArea={151,119,154,123},infoList={{name="diamond_q22090",invokeStepName="Quest_Main"},{name="lab_q44270",invokeStepName="Quest_Main"},{name="factory_q11921",invokeStepName="Quest_Main"},{name="factory_q11923",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.MAFR,areaName="mafr_A05",blockType=this.BLOCKTYPE.GROUP_A,loadArea={152,113,155,117},infoList={{name="lab_q74040",invokeStepName="Quest_Main"},{name="lab_q44280",invokeStepName="Quest_Main"},{name="lab_q11926",invokeStepName="Quest_Main"},{name="lab_q11925",invokeStepName="Quest_Main"},{name="factory_q11340",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.MAFR,areaName="mafr_B01",blockType=this.BLOCKTYPE.GROUP_B,loadArea={141,119,145,124},infoList={{name="diamond_q44260",invokeStepName="Quest_Main"},{name="diamond_q11929",invokeStepName="Quest_Main"},{name="diamond_q54310",invokeStepName="Quest_Main"},{name="diamond_q54300",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.MAFR,areaName="mafr_B02",blockType=this.BLOCKTYPE.GROUP_B,loadArea={150,126,153,129},infoList={{name="diamond_q22160",invokeStepName="Quest_Main"},{name="factory_q44230",invokeStepName="Quest_Main"},{name="factory_q11300",invokeStepName="Quest_Main"},{name="factory_q11922",invokeStepName="Quest_Main"},{name="factory_q54270",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.MAFR,areaName="mafr_B03",blockType=this.BLOCKTYPE.GROUP_B,loadArea={151,121,153,124},infoList={{name="factory_q44240",invokeStepName="Quest_Main"},{name="factory_q11330",invokeStepName="Quest_Main"},{name="factory_q11320",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.MAFR,areaName="mafr_B04",blockType=this.BLOCKTYPE.GROUP_B,loadArea={152,116,154,119},infoList={{name="diamond_q22130",invokeStepName="Quest_Main"},{name="lab_q11924",invokeStepName="Quest_Main"},{name="lab_q44290",invokeStepName="Quest_Main"},{name="factory_q11310",invokeStepName="Quest_Main"},{name="lab_q54100",invokeStepName="Quest_Main"},{name="lab_q54290",invokeStepName="Quest_Main"},{name="lab_q54280",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.MAFR,areaName="mafr_B05",blockType=this.BLOCKTYPE.GROUP_B,loadArea={151,113,155,114},infoList={{name="lab_q11931",invokeStepName="Quest_Main"},{name="lab_q44300",invokeStepName="Quest_Main"}}},{locationId=TppDefine.LOCATION_ID.MAFR,areaName="mafr_C",blockType=this.BLOCKTYPE.GROUP_C,loadArea={101,101,164,164},infoList={{name="factory_q74030",invokeStepName="Quest_Main"},{name="diamond_q22100",invokeStepName="Quest_Main"},{name="factory_q33220",invokeStepName="Quest_Main"},{name="factory_q33090",invokeStepName="Quest_Main"},{name="factory_q33080",invokeStepName="Quest_Main"},{name="diamond_q33260",invokeStepName="Quest_Main"},{name="factory_q33230",invokeStepName="Quest_Main"},{name="diamond_q33270",invokeStepName="Quest_Main"},{name="factory_q33100",invokeStepName="Quest_Main"},{name="factory_q33240",invokeStepName="Quest_Main"},{name="factory_q33250",invokeStepName="Quest_Main"},{name="lab_q33280",invokeStepName="Quest_Main"},{name="lab_q33290",invokeStepName="Quest_Main"},{name="lab_q33300",invokeStepName="Quest_Main"}}}}
function this.GetNpcPackagePathList(i)
local n={}
for i,e in ipairs(i)do
local e=SsdNpc.GetGameObjectPackFilePathsFromPartsType{partsType=e[3]}
for i,e in ipairs(e)do
table.insert(n,e)
end
end
return n
end
this.QUEST_DEFINE={}
this.questPackList={}
this.questOpenCondition={}
this.questLockCondition={}
this.questGuideLineList={}
this.questTimerList={}
this.npcsList={}
this.questLocationList={}
this.questOrderList={}
for n,i in ipairs(this.QUEST_INFO_DEFINE)do
local n=i.name
if Tpp.IsTypeString(n)then
table.insert(this.QUEST_DEFINE,n)
if Tpp.IsTypeTable(i.pack)then
this.questPackList[n]=i.pack
else
this.questPackList[n]={i.pack}
end
local t=i.npcs
if t~=nil then
local i=this.GetNpcPackagePathList(t)
if i then
for t,i in ipairs(i)do
table.insert(this.questPackList[n],i)
end
end
this.npcsList[n]=t
end
if Tpp.IsTypeFunc(i.conditionFunc)then
this.questOpenCondition[n]=i.conditionFunc
else
this.questOpenCondition[n]=function()
return false
end
end
if Tpp.IsTypeFunc(i.lockCondition)then
this.questLockCondition[n]=i.lockCondition
else
this.questLockCondition[n]=function()
return false
end
end
if Tpp.IsTypeString(i.guideLineId)then
this.questGuideLineList[n]=i.guideLineId
else
this.questGuideLineList[n]=""end
if i.isOrder==true then
this.questOrderList[n]=true
else
this.questOrderList[n]=false
end
do
local t=function(n)
local i=255
local n=n
if Tpp.IsTypeNumber(n)then
if n==0 or n>i then
n=i
end
return n
end
return i
end
this.questTimerList[n]={}
if i.isOnce then
this.questTimerList[n].isOnce=true
this.questTimerList[n].openTime=0
this.questTimerList[n].closeTime=0
else
this.questTimerList[n].isOnce=false
this.questTimerList[n].openTime=t(i.openTime)
this.questTimerList[n].closeTime=t(i.closeTime)
end
end
end
end
this.QUEST_INDEX=TppDefine.Enum(this.QUEST_DEFINE)
this.QUEST_DEFINE_IN_NUMBER={}
this.QUEST_DEFINE_HASH_TABLE={}
local i={}
for t,n in ipairs(this.QUEST_DEFINE)do
local t=tonumber(string.sub(n,-5))
this.QUEST_DEFINE_IN_NUMBER[n]=t
this.QUEST_DEFINE_HASH_TABLE[Fox.StrCode32(n)]=n
table.insert(i,t)
end
if Mission.RegisterQuestCodeList then
Mission.RegisterQuestCodeList{codeList=i}
end
i=nil
for n,i in ipairs(this.questList)do
local n=i.infoList
if Tpp.IsTypeTable(n)then
for t,n in ipairs(n)do
local n=tonumber(string.sub(n.name,-5))
this.questLocationList[n]=i.locationId
end
end
end
if Mission.DEBUG_RegisterQuestInfo then
local n={}
for e,i in pairs(this.questLocationList)do
local e={questCode=e,locationCode=i}
table.insert(n,e)
end
Mission.DEBUG_RegisterQuestInfo(n)
end
this.QUEST_INFO_DEFINE={}
return this
