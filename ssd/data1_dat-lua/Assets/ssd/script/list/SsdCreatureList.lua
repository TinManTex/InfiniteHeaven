local this={}
this.CREATURE_BLOCK_INFO_LIST={
  {locationId=TppDefine.LOCATION_ID.SSD_AFGH,loadArea={130,145,138,153},
    activeArea={131,146,137,152},
    infoList={{name="afgh_dungeon1_zombieXOF",enemyTypeTable={"SsdZombieEvent"},
      isSequenceEnemyLevel=true,loadCondition=function()
        local e=TppStory.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.BEFORE_k40020
        local a=not TppQuest.IsLoadableQuestName"field_q61010"
        return e and a
      end,
      pack={"/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieXOF_8c.fpk",
        "/Assets/ssd/pack/location/afgh/pack_mission/dungeon/dungeon1/afgh_dungeon1_zombieXOF01.fpk"},
      npcs={
        {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_EVENT,"ZombieXOF","ZombieXOFNormal"}
      }}}},
  {locationId=TppDefine.LOCATION_ID.SSD_AFGH,loadArea={130,145,138,153},
    activeArea={131,146,137,152},
    infoList={{name="afgh_dungeon1_zombieWCS",enemyTypeTable={"SsdZombieEvent"},
      isSequenceEnemyLevel=true,loadCondition=function()
        local a=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.BEFORE_k40030
        local e=not TppQuest.IsLoadableQuestName"field_q61010"
        return a and e
      end,
      pack={"/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieWCS_8c.fpk",
        "/Assets/ssd/pack/location/afgh/pack_mission/dungeon/dungeon1/afgh_dungeon1_zombieWCS01.fpk"},
      npcs={{TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_EVENT,"ZombieWCS","ZombieWCSNormal"}}}}},
  {locationId=TppDefine.LOCATION_ID.MAFR,loadArea={151,112,157,116},
    activeArea={152,113,156,115},
    infoList={{name="mafr_dungeon1_zombieWCS",enemyTypeTable={"SsdZombieEvent"},
      isSequenceEnemyLevel=true,loadCondition=function()
        return true
      end,
      pack={"/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieWCS_8c.fpk",
        "/Assets/ssd/pack/location/mafr/pack_mission/dungeon/dungeon1/mafr_dungeon1_zombieWCS01.fpk"},
      npcs={{TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_EVENT,"ZombieWCS","ZombieWCSNormal"}}}}},
  {locationId=TppDefine.LOCATION_ID.SSD_AFGH,loadArea={130,145,138,153},
    activeArea={131,146,137,152},
    infoList={{name="afgh_field_gluttony",enemyTypeTable={"SsdBoss3"},
      enemyLevel=42,enemyLevelRandomRange=0,isSequenceEnemyLevel=false,loadCondition=function()
        local a=TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_BASE_DEFENSE_TUTORIAL
        local e=TppQuest.IsLoadableQuestName"field_q61010"
        return a and e
      end,
      pack={"/Assets/ssd/pack/npc/gameobject/npc_gameobject_gluttony.fpk",
        "/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_boss01.fpk",
        "/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_stealthArea_c01.fpk"},
      npcs={{TppGameObject.GAME_OBJECT_TYPE_BOSS_3,"Gluttony","GluttonyNormal"}}}}},
  {locationId=TppDefine.LOCATION_ID.MAFR,loadArea={140,118,146,125},
    activeArea={141,119,145,124},
    infoList={{name="mafr_diamond_aerial",enemyTypeTable={"SsdBoss1"},
      enemyLevel=49,enemyLevelRandomRange=0,isSequenceEnemyLevel=false,loadCondition=function()
        local a=TppQuest.IsCleard"field_q61010"
        local e=TppQuest.IsLoadableQuestName"diamond_q61020"
        return a and e
      end,pack={"/Assets/ssd/pack/npc/gameobject/npc_gameobject_aerial.fpk",
        "/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_boss01.fpk",
        "/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_stealthArea_c02.fpk"},

      npcs={{TppGameObject.GAME_OBJECT_TYPE_BOSS_1,"Aerial","AerialNormal"}}}}},
  {locationId=TppDefine.LOCATION_ID.MAFR,loadArea={140,118,146,125},
    activeArea={141,119,145,124},
    infoList={{name="mafr_diamond_gluttony",enemyTypeTable={"SsdBoss3"},
      enemyLevel=59,enemyLevelRandomRange=0,isSequenceEnemyLevel=false,loadCondition=function()
        local e=TppQuest.IsCleard"diamond_q61020"
        local a=TppQuest.IsLoadableQuestName"diamond_q61030"
        return e and a
      end,pack={"/Assets/ssd/pack/npc/gameobject/npc_gameobject_gluttony.fpk",
        "/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_boss02.fpk",
        "/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_stealthArea_c01.fpk"},
      npcs={{TppGameObject.GAME_OBJECT_TYPE_BOSS_3,"Gluttony","GluttonyNormal"}}}}},
  {locationId=TppDefine.LOCATION_ID.SSD_AFGH,loadArea={134,138,140,144},
    activeArea={135,139,139,143},
    infoList={{name="afgh_village_aerial",enemyTypeTable={"SsdBoss1"},
      enemyLevel=64,enemyLevelRandomRange=0,isSequenceEnemyLevel=false,loadCondition=function()
        local e=TppQuest.IsCleard"diamond_q61030"
        local a=TppQuest.IsLoadableQuestName"village_q61040"
        return e and a
      end,
      pack={"/Assets/ssd/pack/npc/gameobject/npc_gameobject_aerial.fpk",
        "/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_boss01.fpk",
        "/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_stealthArea_c01.fpk"},
      npcs={{TppGameObject.GAME_OBJECT_TYPE_BOSS_1,"Aerial","AerialNormal"}}}}}}
return this
