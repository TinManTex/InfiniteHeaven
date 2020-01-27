local this={}
local n={
  condition=function()
    if not Tpp.IsTypeTable(mvars.bfm_storySequenceDemoFinished)then
      return false
    end
    return not(not mvars.bfm_storySequenceDemoFinished[TppStory.GetCurrentStorySequence()])
  end,
  updateTiming={OnStorySequenceDemoFinished=true}
}
local _={
  condition=function()
    if not Tpp.IsTypeTable(mvars.bfm_storySequenceBlackRadioFinished)then
      return false
    end
    return not(not mvars.bfm_storySequenceBlackRadioFinished[TppStory.GetCurrentStorySequence()])
  end,
  updateTiming={OnStorySequenceBlackRadioFinished=true}
}
local a={
  reload=true,
  condition=function()
    if gvars.isContinueFromTitle or gvars.mis_isReloaded then
      return true
    end
    return false
  end,
  updateTiming={OnMissionStart=true,OnMissionReload=true}
}
this.storySequenceTable={
  {story={"s10010"},updateTiming={OnMissionClear=true},baseEnemyLevel=0},
  {onlyOpen={"c20010"}},
  {flag={"k40040"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=0},
  {},
  {},
  {},
  {flag={"k40060"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=0},
  {},
  {flag={"k40070"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=1,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_area1_01={level=2,randomRange=0},afgh_dungeon1={level=3,randomRange=1},afgh_area1_02={level=3,randomRange=1},afgh_field={level=4,randomRange=1},afgh_field_crystal={level=6,randomRange=3},afgh_area2_01={level=9,randomRange=2},afgh_dungeon2={level=10,randomRange=2},afgh_area2_02={level=11,randomRange=1},afgh_village={level=11,randomRange=1},afgh_village_crystal={level=13,randomRange=1}}}},
  {},
  {flag={"k40015"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=3,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_dungeon1={level=2,randomRange=0},afgh_area1_02={level=2,randomRange=1},afgh_field={level=4,randomRange=1},afgh_field_crystal={level=6,randomRange=3},afgh_area2_01={level=9,randomRange=2},afgh_dungeon2={level=10,randomRange=2},afgh_area2_02={level=11,randomRange=1},afgh_village={level=11,randomRange=1},afgh_village_crystal={level=13,randomRange=1}}}},n,_,{flag={"k40020"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=3,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_area1_02={level=2,randomRange=0},afgh_field={level=4,randomRange=1},afgh_field_crystal={level=6,randomRange=3},afgh_area2_01={level=9,randomRange=2},afgh_dungeon2={level=10,randomRange=2},afgh_area2_02={level=11,randomRange=1},afgh_village={level=11,randomRange=1},afgh_village_crystal={level=13,randomRange=1}}}},a,{flag={"k40030"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=4,enemyLevelRandRange=1,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_area1_02={level=2,randomRange=0},afgh_field={level=4,randomRange=1},afgh_field_crystal={level=6,randomRange=3},afgh_area2_01={level=9,randomRange=2},afgh_dungeon2={level=10,randomRange=2},afgh_area2_02={level=11,randomRange=1},afgh_village={level=11,randomRange=1},afgh_village_crystal={level=13,randomRange=1}}}},
  {},
  {flag={"k40035"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=6,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field={level=2,randomRange=1},afgh_field_crystal={level=4,randomRange=1},afgh_area2_01={level=9,randomRange=2},afgh_dungeon2={level=10,randomRange=2},afgh_area2_02={level=11,randomRange=1},afgh_village={level=11,randomRange=1},afgh_village_crystal={level=13,randomRange=1}}}},
  {},
  {flag={"k40075"},updateTiming={FlagMissionEnd=true},guideLine={"guidelines_mission_common_wormhole"},baseEnemyLevel=4,enemyLevelRandRange=4,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_area1_02={level=3,randomRange=0},afgh_field={level=6,randomRange=1},afgh_field_crystal={level=8,randomRange=1},afgh_area2_01={level=13,randomRange=2},afgh_dungeon2={level=14,randomRange=2},afgh_area2_02={level=15,randomRange=1},afgh_village={level=15,randomRange=1},afgh_village_crystal={level=17,randomRange=1}}}},
  {},
  {flag={"k40077"},updateTiming={FlagMissionEnd=true},guideLine={"guidelines_mission_common_coop"},baseEnemyLevel=8,enemyLevelRandRange=3,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=2,randomRange=1},afgh_area2_01={level=7,randomRange=2},afgh_dungeon2={level=8,randomRange=2},afgh_area2_02={level=9,randomRange=1},afgh_village={level=9,randomRange=1},afgh_village_crystal={level=11,randomRange=1}}}},
  {},
  {},
  {flag={"k40080"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=10,enemyLevelRandRange=1,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=2,randomRange=1},afgh_area2_01={level=1,randomRange=1},afgh_dungeon2={level=5,randomRange=2},afgh_area2_02={level=6,randomRange=1},afgh_village={level=8,randomRange=1},afgh_village_crystal={level=10,randomRange=1}}}},
  {},
  {flag={"k40090"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=12,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=1,randomRange=1},afgh_area2_02={level=4,randomRange=1},afgh_village={level=6,randomRange=1},afgh_village_crystal={level=8,randomRange=1}}}},
  {},
  {flag={"k40130"},updateTiming={FlagMissionEnd=true},guideLine={"guidelines_mission_common_signal"},baseEnemyLevel=14,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=1,randomRange=1},afgh_village={level=1,randomRange=1},afgh_village_crystal={level=3,randomRange=1}}}},
  {},
  {flag={"k40140"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=15,enemyLevelRandRange=1,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=2,randomRange=1},afgh_village_crystal={level=3,randomRange=1}}}},
  {onlyOpen={"c20110"}},
  {flag={"k40150"},updateTiming={FlagMissionEnd=true},guideLine={"guidelines_mission_40150_01"},baseEnemyLevel=16,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=1,randomRange=1},afgh_village_crystal={level=2,randomRange=1}}}},
  {},
  {flag={"k40155"},updateTiming={FlagMissionEnd=true},guideLine={"guidelines_mission_common_wormhole"},baseEnemyLevel=16,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=1,randomRange=1},afgh_village_crystal={level=2,randomRange=1}}}},
  {},
  {story={"s10035"},updateTiming={OnMissionClear=true},guideLine={"guidelines_mission_common_wormhole"},baseEnemyLevel=16,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=1,randomRange=1},afgh_village_crystal={level=2,randomRange=1}}}},n,_,{flag={"k40160"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=18,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=1,randomRange=1},afgh_village_crystal={level=2,randomRange=1}},mafr={mafr_area1_01={level=1,randomRange=2},mafr_area1_02={level=3,randomRange=2},mafr_area1_03={level=4,randomRange=1},mafr_lab={level=5,randomRange=1},mafr_dungeon01={level=6,randomRange=1}}}},
  {},
  {flag={"k40180"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=19,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=1,randomRange=1},afgh_village_crystal={level=2,randomRange=1}},mafr={mafr_area1_02={level=2,randomRange=3},mafr_area1_03={level=3,randomRange=2},mafr_lab={level=4,randomRange=2},mafr_dungeon01={level=5,randomRange=1},mafr_diamond={level=5,randomRange=1},mafr_diamond_crystal={level=5,randomRange=1}}}},a,{flag={"k40170"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=20,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=1,randomRange=1},afgh_village_crystal={level=2,randomRange=1}},mafr={mafr_area1_03={level=1,randomRange=1},mafr_lab={level=2,randomRange=2},mafr_dungeon01={level=3,randomRange=2},mafr_diamond={level=5,randomRange=1},mafr_diamond_crystal={level=5,randomRange=1}}}},
  {},
  {flag={"k40230"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=14,enemyLevelRandRange=7,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=7,randomRange=1},afgh_village_crystal={level=8,randomRange=1}},mafr={mafr_diamond_crystal={level=7,randomRange=2}}}},
  {},
  {},
  {},
  {story={"s10050"},updateTiming={OnMissionClear=true},baseEnemyLevel=14,enemyLevelRandRange=7,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=7,randomRange=1},afgh_village_crystal={level=8,randomRange=1}},mafr={mafr_diamond_crystal={level=7,randomRange=2}}},objectiveInfoAtAnotherLocation={"mission_common_objective_returnToBase"},guideLineInfoAtAnotherLocation={"guidelines_mission_10050_02"},markerInfoAtAnotherLocation={location="afgh",vagueLevel=5,pos=Vector3(-450.414,290.404,2240.041)}},
  {},
  {flag={"k40220"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=21,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=1,randomRange=1},afgh_village_crystal={level=2,randomRange=1}},mafr={mafr_diamond={level=2,randomRange=1},mafr_diamond_crystal={level=4,randomRange=1}}},objectiveInfoAtAnotherLocation={"mission_common_objective_getMemoryBoard"},guideLineInfoAtAnotherLocation={"guidelines_mission_common_memoryBoard"},markerInfoAtAnotherLocation={location="mafr",vagueLevel=5,pos=Vector3(2744.697,198.868,-2404.741),guidelinesId="guidelines_mission_common_memoryBoard"}},
  {},
  {flag={"k40250"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=17,enemyLevelRandRange=2,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=6,randomRange=1},afgh_village_crystal={level=7,randomRange=1}},mafr={mafr_diamond_crystal={level=6,randomRange=2}}},objectiveInfoAtAnotherLocation={"mission_common_objective_putDigger"},guideLineInfoAtAnotherLocation={"guidelines_mission_common_coop"},markerInfoAtAnotherLocation={location="mafr",vagueLevel=5,pos=Vector3(1322.917,123.078,-1543.98),guidelinesId="guidelines_mission_common_coop"}},
  {onlyOpen={"c20210"}},
  {flag={"k40260"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=22,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=1,randomRange=1},afgh_village_crystal={level=2,randomRange=1}},mafr={mafr_diamond_crystal={level=1,randomRange=2}}},objectiveInfoAtAnotherLocation={"mission_40260_objective_05"},guideLineInfoAtAnotherLocation={"guidelines_mission_40260_01"},markerInfoAtAnotherLocation={location="afgh",vagueLevel=5,pos=Vector3(-450.414,290.404,2240.041),guidelinesId="guidelines_mission_40260_01"}},
  {},
  {flag={"k40270"},updateTiming={FlagMissionEnd=true},guideLine={"guidelines_mission_common_wormhole"},baseEnemyLevel=22,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=1,randomRange=1},afgh_village_crystal={level=2,randomRange=1}},mafr={mafr_diamond_crystal={level=1,randomRange=2}}},objectiveInfoAtAnotherLocation={"mission_common_objective_bootDigger"},guideLineInfoAtAnotherLocation={"guidelines_mission_common_wormhole"},markerInfoAtAnotherLocation={location="afgh",vagueLevel=5,pos=Vector3(-450.414,290.404,2240.041),guidelinesId="guidelines_mission_common_wormhole"}},
  {},
  {story={"s10060"},updateTiming={OnMissionClear=true},baseEnemyLevel=17,enemyLevelRandRange=4,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=6,randomRange=1},afgh_village_crystal={level=7,randomRange=1}},mafr={mafr_diamond_crystal={level=6,randomRange=2}}},objectiveInfoAtAnotherLocation={"mission_common_objective_returnToBase"},guideLineInfoAtAnotherLocation={"guidelines_mission_common_wormhole"},markerInfoAtAnotherLocation={location="afgh",vagueLevel=5,pos=Vector3(-450.414,290.404,2240.041)}},
  {onlyOpen={"c20020","c20120","c20220","c20610","c20620","c20710","c20720"},updateTiming={OnMissionStart=true}},
  {defense={"d50500"},updateTiming={OnBaseDefenseClear=true},guideLineInfoAtAnotherLocation={"guidelines_mission_50500"},markerInfoAtAnotherLocation={location="afgh",vagueLevel=5,pos=Vector3(-450.414,290.404,2240.041),guidelinesId="guidelines_mission_50500"}},
  {},
  {flag={"k40320"},updateTiming={FlagMissionEnd=true},objectiveInfoAtAnotherLocation={"mission_40020_objective_02"},guideLineInfoAtAnotherLocation={"guidelines_mission_common_signal"},markerInfoAtAnotherLocation={location="mafr",vagueLevel=5,pos=Vector3(2697.192,139.343,-2121.746),guidelinesId="guidelines_mission_common_signal"}},
  {},
  {flag={"k40310"},updateTiming={FlagMissionEnd=true},baseEnemyLevel=21,enemyLevelRandRange=5,regionEnemyLevelSetting={afgh={afgh_base_spot={fixLevel=2,randomRange=0},afgh_field_crystal={level=3,randomRange=1},afgh_village_crystal={level=4,randomRange=1}},mafr={mafr_diamond_crystal={level=3,randomRange=2}}},objectiveInfoAtAnotherLocation={"mission_common_objective_getMemoryBoard"},guideLineInfoAtAnotherLocation={"guidelines_mission_common_memoryBoard"},markerInfoAtAnotherLocation={location="mafr",vagueLevel=5,pos=Vector3(2527.006,204.606,-2497.627),guidelinesId="guidelines_mission_common_memoryBoard"}},
  {},
  {}
}
this.sequenceAutoLoadMissionList={}
for a,_ in ipairs(this.storySequenceTable)do
  local a={}
  if Tpp.IsTypeTable(_)then
    if _.autoLoad~=false then
      local missionName
      local missionType
      if _.story then
        missionName=_.story[1]
        missionType=Fox.StrCode32"STORY"
      elseif _.flag then
        missionName=_.flag[1]
        missionType=Fox.StrCode32"FLAG"
      end
      if Tpp.IsTypeString(missionName)then
        a.missionName=missionName
        a.missionType=missionType
      end
    end
  end
  table.insert(this.sequenceAutoLoadMissionList,a)
end
if(Tpp.IsQARelease()or nil)then
  Tpp.DEBUG_DumpTable(this.sequenceAutoLoadMissionList)
  this.DEBUG_storySequenceTable={
    {Equip={Arm="PRD_ACC_Arm_16",Body="PRD_ACC_Body_36",Foot="PRD_ACC_Foot_15"}},
    {Equip={Thurst="PRD_EQP_WP_Spear_A"},Exp=150},
    {overrideVarsFunction=function()
      TppVarInit.SetTutorialPlayerHungerAndThirst()
    end},
    {},
    {},
    {},
    {Resource={RES_Meat_A=6,RES_Water_Pure=10,RES_Nail=60,RES_Wood=120,RES_Iron=30,RES_Rag=20,RES_WildPlants_F=15,RES_Gauze=5,RES_Cotton=5,RES_Junk_MedicalKit=5},Exp=1e3},
    {Equip={Item="PRD_DEF_Fence_C"}},
    {Equip={Item="PRD_DEF_Scaffold_A"}},
    {},
    {Equip={Item="PRD_EQP_SWP_MolotovCocktail",OneHandSwing="PRD_EQP_WP_Machete_A"},Exp=5e3,Skill={{id="SKILL_BackStab",level=1},
      {id="SKILL_StepMove",level=1}},FastTravel={"fast_afgh00"}},
    {},
    {},
    {Equip={TwoHandSwing="PRD_EQP_WP_Bat",Bow="PRD_EQP_WP_WoodBow",Item="PRD_BL_ARW_Normal",Gun="PRD_EQP_WP_hg00"},FastTravel={"fast_afgh01"}},
    {},
    {FastTravel={"fast_afgh02"},Skill={{id="SKILL_ItemizeSpeedUp",level=1}}},
    {},
    {Equip={OneHandSwing="PRD_EQP_WP_CrowBar",Item="PRD_EXP_Fulton"},Skill={{id="SKILL_StrengthUp",level=1},
      {id="SKILL_DexterityUp",level=1}},FastTravel={"fast_afgh03"}},
    {},
    {Equip={Thurst="PRD_EQP_WP_Spear_B",Arm="PRD_ACC_Arm_02",Head="PRD_ACC_Helmet_03",Body="PRD_ACC_Body_06",Poach="PRD_SVE_ExHolster_GadgetL_Lv1",Item="PRD_DEF_Mortar_A"},FastTravel={"fast_afgh04"},Skill={{id="SKILL_SwingDash",level=1}}},
    {},
    {Equip={TwoHandSwing="PRD_EQP_WP_Axe_A",Arrow="PRD_BL_ARW_Iron"},Skill={{id="SKILL_TwoHandSwingDash",level=1}}},
    {},
    {},
    {Equip={OneHandSwing="PRD_EQP_WP_Scoop_A",Arrow="PRD_BL_ARW_Flame"},FastTravel={"fast_afgh05"},Skill={{id="SKILL_VitalityUp",level=1},
      {id="SKILL_AgilityUp",level=1}}},
    {},
    {Equip={TwoHandHeavy="PRD_EQP_WP_Hammer_B",Bow="PRD_EQP_WP_Bow_A"},FastTravel={"fast_afgh09"},Skill={{id="SKILL_ThrustDash",level=1},
      {id="SKILL_Push",level=1}}},
    {},
    {Equip={OneHandSwing="PRD_EQP_WP_Machete_E",Item="PRD_DEF_Turret_A"},FastTravel={"fast_afgh10","fast_afgh11"},Skill={{id="SKILL_HeavyDash",level=1},
      {id="SKILL_Stomping",level=1}}},
    {},
    {FastTravel={"fast_afgh13"}},
    {Equip={OneHandSwing="PRD_EQP_WP_StrongBat",Thurst="PRD_EQP_WP_ArmorPiercingSpear"},Skill={{id="SKILL_SwingMastery",level=1}}},
    {},
    {},
    {},
    {},
    {Equip={OneHandSwing="PRD_EQP_WP_StunRod_A"},Skill={{id="SKILL_ThrustMastery",level=1}}},
    {},
    {},
    {Equip={OneHandSwing="PRD_EQP_WP_TailRoterBlade",Arm="PRD_ACC_Arm_03",Head="PRD_ACC_Helmet_04",Body="PRD_ACC_Body_16"},FastTravel={"fast_mafr00"},Skill={{id="SKILL_HeavyMastery",level=1},
      {id="SKILL_TwoHandSwingMastery",level=1}}},
    {},
    {Equip={Gun="PRD_EQP_WP_sg02"},Skill={{id="SKILL_Sweep",level=1},
      {id="SKILL_PowerThrust",level=1}}},
    {},
    {FastTravel={"fast_mafr01"}},
    {},
    {Equip={TwoHandSwing="PRD_EQP_WP_FireBat"},FastTravel={"fast_mafr02","fast_mafr03","fast_mafr07"},Skill={{id="SKILL_HeavyStamp",level=1}}},
    {},
    {},
    {},
    {},
    {},
    {Equip={OneHandSwing="PRD_EQP_WP_Machete_B"},FastTravel={"fast_mafr02","fast_mafr07"},Skill={{id="SKILL_Bash",level=1},
      {id="SKILL_CQCCounter",level=1}}},
    {},
    {},
    {Equip={TwoHandHeavy="PRD_EQP_WP_Hammer_C",Bow="PRD_EQP_WP_Bow_B",Thurst="PRD_EQP_WP_Spear_C"}},
    {FastTravel={"fast_mafr06"},Equip={OneHandSwing="PRD_EQP_WP_StrongCrowBar"}},
    {},
    {},
    {},
    {Equip={TwoHandSwing="PRD_EQP_WP_StunBat"}},
    {},
    {},
    {},
    {},
    {},
    {},
    {},
    {}
  }
  this.DEBUG_afterStoryPacingTable={
    {Recipe={"RCP_SVE_Fulton","RCP_EQP_WP_Machete_B","RCP_EQP_WP_StrongCrowBar","RCP_EQP_WP_Axe_A","RCP_EQP_WP_FireBat","RCP_EQP_WP_Spear_C","RCP_EQP_WP_ShockSpear","RCP_EQP_WP_ArmorPiercingSpear","RCP_EQP_WP_TailRoterBlade","RCP_EQP_WP_Hammer_C","RCP_EQP_WP_Bow_A","RCP_EQP_WP_ar00","RCP_EQP_WP_ar01","RCP_EQP_WP_sg01","RCP_EQP_WP_sr01","RCP_EQP_WP_hg10","RCP_EQP_WP_hg00_main2","RCP_ACC_Helmet_08","RCP_ACC_Helmet_11","RCP_ACC_Helmet_12","RCP_ACC_Helmet_14","RCP_ACC_Helmet_15","RCP_ACC_Helmet_25","RCP_ACC_Body_03","RCP_ACC_Body_06","RCP_ACC_Body_16","RCP_ACC_Body_17","RCP_ACC_Body_20","RCP_ACC_Body_25","RCP_ACC_Body_39","RCP_ACC_Body_41","RCP_ACC_Arm_01","RCP_ACC_Arm_04","RCP_ACC_Arm_24","RCP_ACC_Foot_11","RCP_ACC_Foot_17","RCP_ACC_Foot_07","RCP_ACC_Body_47","RCP_ACC_Foot_18","RCP_EQP_SWP_MolotovCocktail","RCP_EQP_SWP_C4","RCP_DEF_Barricade_E","RCP_DEF_Floor_B","RCP_BLD_WeaponPlant_B","RCP_DEF_Fence_A","RCP_DEF_Fence_C","RCP_DEF_Barricade_A","RCP_BLD_VegetableFarm_A","RCP_BLD_Shelter_A","RCP_DEF_Scaffold_A","RCP_BLD_Kitchen_B","RCP_BLD_DirtyWaterTank_A","RCP_BLD_GadgetPlant_B","RCP_BLD_StandbyRoom_A","RCP_BLD_VegetableFarm_B","RCP_BLD_AccessoryPlant_B","RCP_BLD_Shelter_B","RCP_BLD_HerbFarm_A","RCP_BLD_HerbFarm_B","RCP_BLD_Kitchen_D","RCP_BLD_WeaponPlant_C","RCP_BLD_GadgetPlant_C","RCP_BLD_AccessoryPlant_C","RCP_BLD_DirtyWaterTank_B","RCP_BLD_RadioStation_A","RCP_BLD_RadioTower_A","RCP_BLD_FoodStorage_A","RCP_BLD_MedicalStorage_A","RCP_BLD_WaterTank_A","RCP_BLD_DirtyWaterTank_B","RCP_DEF_Barricade_C","RCP_DEF_Turret_A","RCP_DEF_Fence_D","RCP_DEF_Mortar_A","RCP_IT_CureSpray","RCP_EQP_SWP_Grenade","RCP_SVE_ExHolster_GadgetL_Lv1","RCP_EQP_SWP_DMine","RCP_BL_ARW_Flame","RCP_SVE_ExtraBag_Lv1","RCP_SVE_ExPorch_Bomb_Lv1","RCP_SVE_ExPorch_WoodArrow_Lv1","RCP_SVE_ExPorch_IronArrow_Lv1","RCP_SVE_ExPorch_FrameArrow_Lv1","RCP_SVE_ExHolster_Main","RCP_BL_ARW_Normal","RCP_BL_ARW_Iron","RCP_EQP_WP_hg00","RCP_BL_Hg114Auto","RCP_SVE_ExHolster_GadgetR_Lv1","RCP_SVE_ExPorch_Disk_Lv1","RCP_EQP_WP_hg06","RCP_BL_Hg44Mag","RCP_DEF_Barricade_B","RCP_DEF_Barricade_D","RCP_DEF_Fence_B","RCP_EQP_WP_hg20","RCP_BL_Sling","RCP_SVE_ExPorch_Grenade_Lv1"},PlayerBaseLevel=28,Exp=1e6,Skill={{id="SKILL_StrengthUp",level=5},
      {id="SKILL_DexterityUp",level=5},
      {id="SKILL_VitalityUp",level=5},
      {id="SKILL_AgilityUp",level=5}},UniqueCrew={"k40020","k40130","k40180","k40220"}},
    {Recipe={"RCP_EQP_WP_StunBat","RCP_EQP_WP_Bow_B","RCP_BLD_Kitchen_E","RCP_BLD_WaterTank_C","RCP_BLD_Shelter_C","RCP_BLD_VegetableFarm_C","RCP_BLD_HerbFarm_C","RCP_BLD_Herbivore_C","RCP_BLD_Herbivore_D","RCP_BLD_Light_C","RCP_BLD_Ornament_D","RCP_EQP_SWP_ShockDecoy","RCP_EQP_SWP_ShockMine","RCP_EQP_SWP_WaterPump","RCP_DEF_Fence_F","RCP_DEF_AntiAircraftGun_A","RCP_DEF_AutoTurret_A","RCP_DEF_AirCannon","RCP_DEF_Floor_C","RCP_DEF_Floor_A","RCP_DEF_SpikePole_A","RCP_DEF_Fence_E","RCP_DEF_Barricade_F","RCP_BL_ARW_Ice","RCP_BL_ARW_Shock","RCP_BL_ARW_Rpa","RCP_BL_ARW_Blast","RCP_SVE_ExPorch_IceArrow_Lv1","RCP_SVE_ExPorch_ShockArrow_Lv1","RCP_SVE_ExPorch_RPA_Lv1","RCP_SVE_ExPorch_BlastArrow_Lv1","RCP_SVE_ExtraBag_Lv2","RCP_SVE_ExPorch_Disk_Lv2","RCP_SVE_ExPorch_Bomb_Lv2","RCP_SVE_ExPorch_Molotov_Lv1"},PlayerBaseLevel=40,Exp=5e6,UniqueCrew={"k40320_2"}},
    {Recipe={"RCP_EQP_WP_FireBlade_A","RCP_EQP_WP_IceBlade_A","RCP_EQP_WP_StunBlade_A","RCP_EQP_WP_FireGlaive","RCP_EQP_WP_IceGlaive","RCP_EQP_WP_StunGlaive","RCP_EQP_WP_Heavy_A","RCP_EQP_WP_IceJetHammer","RCP_EQP_WP_StunJetHammer","RCP_EQP_WP_CrossLineBow","RCP_BLD_Kitchen_F","RCP_BLD_DirtyWaterTank_C","RCP_BLD_FoodStorage_B","RCP_BLD_MedicalStorage_B","RCP_BLD_Light_D","RCP_BLD_Ornament_B","RCP_BLD_Ornament_G","RCP_BLD_Ornament_H","RCP_BLD_Ornament_I","RCP_BLD_WeaponPlant_D","RCP_BLD_GadgetPlant_D","RCP_BLD_AccessoryPlant_D","RCP_DEF_Turret_B","RCP_DEF_AutoTurret_B","RCP_DEF_AutoTurret_C","RCP_DEF_Floor_D","RCP_DEF_Cutter_A","RCP_DEF_WatchTower_C","RCP_DEF_Barricade_G","RCP_DEF_AutoTurret_A2","RCP_DEF_AirCannon2","RCP_DEF_Floor_B2","RCP_DEF_Floor_C2","RCP_DEF_Floor_A2","RCP_ACC_Helmet_07","RCP_ACC_Helmet_20","RCP_ACC_Helmet_21","RCP_ACC_Helmet_19","RCP_ACC_Helmet_22","RCP_ACC_Helmet_23","RCP_ACC_Helmet_29","RCP_ACC_Helmet_31","RCP_ACC_Helmet_32","RCP_ACC_Helmet_33","RCP_ACC_Body_34","RCP_ACC_Body_48","RCP_ACC_Body_49","RCP_ACC_Body_51","RCP_ACC_Body_52","RCP_ACC_Body_53","RCP_ACC_Body_59","RCP_ACC_Body_61","RCP_ACC_Body_66","RCP_ACC_Body_67","RCP_ACC_Arm_09","RCP_ACC_Arm_20","RCP_ACC_Arm_21","RCP_ACC_Arm_19","RCP_ACC_Arm_22","RCP_ACC_Arm_23","RCP_ACC_Arm_26","RCP_ACC_Arm_28","RCP_ACC_Arm_29","RCP_ACC_Arm_30","RCP_ACC_Foot_05","RCP_ACC_Foot_22","RCP_ACC_Foot_23","RCP_ACC_Foot_20","RCP_ACC_Foot_24","RCP_ACC_Foot_25","RCP_ACC_Foot_31","RCP_ACC_Foot_33","RCP_ACC_Foot_34","RCP_ACC_Foot_35","RCP_SVE_ExPorch_WoodArrow_Lv3","RCP_SVE_ExPorch_IronArrow_Lv2","RCP_SVE_ExPorch_FrameArrow_Lv2","RCP_SVE_ExPorch_IceArrow_Lv2","RCP_SVE_ExPorch_ShockArrow_Lv2","RCP_SVE_ExPorch_RPA_Lv2","RCP_SVE_ExPorch_BlastArrow_Lv2","RCP_SVE_ExtraBag_Lv3","RCP_SVE_ExPorch_Disk_Lv3","RCP_SVE_ExPorch_Bomb_Lv3","RCP_SVE_ExPorch_Grenade_Lv2","RCP_SVE_ExPorch_Molotov_Lv2"},PlayerBaseLevel=40,PlayerLevelFighter=5,Exp=1e7},
    {Recipe={"RCP_BLD_Kitchen_G","RCP_BLD_Shelter_D","RCP_BLD_Light_B","RCP_BLD_Light_E","RCP_BLD_Ornament_A","RCP_BLD_Ornament_E","RCP_BLD_Ornament_F","RCP_BLD_HydroponicFarm_A","RCP_BLD_Herbivore_E","RCP_DEF_AntiAircraftGun_B","RCP_DEF_AutoTurret_B2","RCP_DEF_AutoTurret_C2","RCP_DEF_Floor_D2","RCP_DEF_Cutter_A2","RCP_SVE_ExPorch_IronArrow_Lv3","RCP_SVE_ExPorch_FrameArrow_Lv3","RCP_SVE_ExPorch_IceArrow_Lv3","RCP_SVE_ExPorch_ShockArrow_Lv3","RCP_SVE_ExPorch_RPA_Lv3","RCP_SVE_ExPorch_BlastArrow_Lv3","RCP_SVE_ExPorch_Molotov_Lv3","RCP_SVE_ExPorch_Grenade_Lv3"},PlayerBaseLevel=40,PlayerLevelFighter=23,Exp=5e7},
    {Recipe={},PlayerBaseLevel=40,PlayerLevelFighter=23},
    {Recipe={},PlayerBaseLevel=63,PlayerLevelFighter=23,PlayerLevelShooter=23,PlayerLevelMedic=23,PlayerLevelScout=23},
    {Recipe={},PlayerBaseLevel=63}
  }
end
return this