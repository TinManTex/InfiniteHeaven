local this={}
this.recipeUnlockConditionTable={
  RCP_FOD_Dish_A={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_Meat_A"}}},
  RCP_FOD_Roast_goat_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_Meat_A",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_goat_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_Meat_A",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_goat_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Dish_A"}}},
  RCP_FOD_Oven_goat_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_Meat_A",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Special_goat_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMaterial_goat_1_2",productionName="PRD_BLD_Kitchen_G"}}},
  RCP_FOD_Dish_B={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_Meat_B"}}},
  RCP_FOD_Roast_wolf_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_Meat_B",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_wolf_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_Meat_B",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_wolf_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Dish_B"}}},
  RCP_FOD_Grill_Nubian={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_Meat_Nubian"}}},
  RCP_FOD_Roast_goat_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_Meat_Nubian",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_goat_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_Meat_Nubian",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_goat_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_Nubian"}}},
  RCP_FOD_Oven_goat_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_Meat_Nubian",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Special_goat_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMaterial_goat_3_2",productionName="PRD_BLD_Kitchen_G"}}},
  RCP_FOD_Grill_horse_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_horse_1"}}},
  RCP_FOD_Roast_horse_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_horse_1",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_horse_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_horse_1",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_horse_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_horse_1"}}},
  RCP_FOD_Oven_horse_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_horse_1",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Special_horse_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMaterial_horse_1_2",productionName="PRD_BLD_Kitchen_G"}}},
  RCP_FOD_Grill_horse_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_horse_2"}}},
  RCP_FOD_Roast_horse_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_horse_2",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_horse_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_horse_2",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_horse_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_horse_2"}}},
  RCP_FOD_Oven_horse_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_horse_2",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Grill_horse_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_horse_3"}}},
  RCP_FOD_Roast_horse_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_horse_3",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_horse_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_horse_3",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_horse_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_horse_3"}}},
  RCP_FOD_Oven_horse_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_horse_3",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Special_horse_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMaterial_horse_3_2",productionName="PRD_BLD_Kitchen_G"}}},
  RCP_FOD_Grill_goat_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_goat_2"}}},
  RCP_FOD_Roast_goat_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_goat_2",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_goat_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_goat_2",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_goat_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_goat_2"}}},
  RCP_FOD_Oven_goat_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_goat_2",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Grill_goat_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_goat_4"}}},
  RCP_FOD_Roast_goat_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_goat_4",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_goat_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_goat_4",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_goat_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_goat_4"}}},
  RCP_FOD_Oven_goat_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_goat_4",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Grill_bear_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_bear_1"}}},
  RCP_FOD_Roast_bear_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bear_1",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_bear_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bear_1",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_bear_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_bear_1"}}},
  RCP_FOD_Special_bear_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMaterial_bear_1_2",productionName="PRD_BLD_Kitchen_G"}}},
  RCP_FOD_Grill_bear_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_bear_2"}}},
  RCP_FOD_Roast_bear_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bear_2",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_bear_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bear_2",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_bear_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_bear_2"}}},
  RCP_FOD_Special_bear_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMaterial_bear_2_2"}}},
  RCP_FOD_Grill_wolf_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_wolf_2"}}},
  RCP_FOD_Roast_wolf_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_wolf_2",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_wolf_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_wolf_2",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_wolf_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_wolf_2"}}},
  RCP_FOD_Grill_wolf_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_wolf_3"}}},
  RCP_FOD_Roast_wolf_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_wolf_3",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_wolf_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_wolf_3",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_wolf_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_wolf_3"}}},
  RCP_FOD_Grill_wolf_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_wolf_4"}}},
  RCP_FOD_Roast_wolf_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_wolf_4",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_wolf_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_wolf_4",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_wolf_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_wolf_4"}}},
  RCP_FOD_Grill_rat_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_rat_4"}}},
  RCP_FOD_Roast_rat_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_rat_4",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_rat_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_rat_4",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_rat_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_rat_4"}}},
  RCP_FOD_Oven_rat_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_rat_4",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Grill_rat_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_rat_1"}}},
  RCP_FOD_Roast_rat_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_rat_1",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_rat_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_rat_1",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_rat_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_rat_1"}}},
  RCP_FOD_Oven_rat_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_rat_1",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Grill_rat_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_rat_2"}}},
  RCP_FOD_Roast_rat_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_rat_2",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_rat_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_rat_2",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Oven_rat_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_rat_2",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Grill_bird_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_bird_4"}}},
  RCP_FOD_Roast_bird_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_4",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_bird_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_4",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Oven_bird_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_4",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Special_bird_4={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMaterial_bird_4_2"}}},
  RCP_FOD_Grill_bird_8={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_bird_8"}}},
  RCP_FOD_Roast_bird_8={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_8",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_bird_8={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_8",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Oven_bird_8={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_8",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Grill_bird_5={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_bird_5"}}},
  RCP_FOD_Roast_bird_5={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_5",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_bird_5={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_5",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Oven_bird_5={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_5",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Grill_bird_6={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_bird_6"}}},
  RCP_FOD_Roast_bird_6={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_6",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_bird_6={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_6",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Oven_bird_6={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_6",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Grill_bird_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_bird_2"}}},
  RCP_FOD_Roast_bird_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_2",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_bird_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_2",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_bird_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_bird_2"}}},
  RCP_FOD_Oven_bird_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_2",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Grill_bird_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_bird_3"}}},
  RCP_FOD_Roast_bird_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_3",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_bird_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_3",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Oven_bird_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_3",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Special_bird_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMaterial_bird_3_2"}}},
  RCP_FOD_Grill_bird_7={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_bird_7"}}},
  RCP_FOD_Roast_bird_7={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_7",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_bird_7={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_7",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Oven_bird_7={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_7",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Grill_rat_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_rat_3"}}},
  RCP_FOD_Roast_rat_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_rat_3",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_rat_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_rat_3",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Oven_rat_3={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_rat_3",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Grill_bird_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_AnimalMeat_bird_1"}}},
  RCP_FOD_Roast_bird_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_1",productionName="PRD_BLD_Kitchen_F"}}},
  RCP_FOD_Smoked_bird_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_1",productionName="PRD_BLD_Kitchen_D"}}},
  RCP_FOD_Boil_bird_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Grill_bird_1"}}},
  RCP_FOD_Oven_bird_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_AnimalMeat_bird_1",productionName="PRD_BLD_Kitchen_E"}}},
  RCP_FOD_Special_potato_1={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,building={{resourceName="RES_Potato",productionName="PRD_BLD_VegetableFarm_A"}}},
  RCP_FOD_Special_potato_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Special_potato_1"}}},
  RCP_FOD_Special_onion={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_Onion"}}},
  RCP_FOD_Special_corn={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_Corn"}}},
  RCP_BLD_VegetableFarm_A={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_Potato"}}},
  RCP_BLD_VegetableFarm_B={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_Corn"}}},
  RCP_BLD_VegetableFarm_D={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_Onion"}}},
  RCP_BLD_VegetableFarm_E={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_Tomato"}}},
  RCP_FOD_Bottle_Water_Pure_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_FOD_Bottle_Water_Dirty"}}},
  RCP_FOD_Canteen_Water_Pure_2={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_EXP_Canteen"}}},
  RCP_CURE_Bleeding={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_CURE_Bleeding"}}},
  RCP_CURE_Sprain={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_CURE_Sprain"}}},
  RCP_CURE_Ruptura={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_CURE_Ruptura"}}},
  RCP_CURE_Tiredness={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_CURE_Tiredness"}}},
  RCP_CURE_Weakening={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_CURE_Weakening"}}},
  RCP_CURE_Poison_Normal={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_CURE_Poison_Normal"}}},
  RCP_CURE_Poison_Deadly={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_CURE_Poison_Deadly"}}},
  RCP_CURE_Poison_Food={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_CURE_Poison_Food"}}},
  RCP_CURE_Poison_Water={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,production={{name="PRD_CURE_Poison_Water"}}},
  RCP_EXP_RevivalPill={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resourceTable={{name="RES_AnimalMaterial_bear_1_2"},{name="RES_AnimalMaterial_bear_2_2"},{name="RES_AnimalMaterial_bird_4_2"},{name="RES_AnimalMaterial_bird_3_2"}}}}
this.GetRecipeListByItemId={}
this.GetStorySequenceByRecipeName={}
this.GetBuildingNameByRecipeName={}
this.GetRecipeNameByBuildingNameAndResourceName={}
--REF RCP_FOD_Dish_A={storySequence=TppDefine.STORY_SEQUENCE.BEFORE_k40040,resource={{name="RES_Meat_A"}}},
for recipeName,unlockInfo in pairs(this.recipeUnlockConditionTable)do
  local function AddToGetRecipeListByItemId(itemName,recipeList)
    local itemNameS32=Fox.StrCode32(itemName)
    this.GetRecipeListByItemId[itemNameS32]=this.GetRecipeListByItemId[itemNameS32]or{}
    table.insert(this.GetRecipeListByItemId[itemNameS32],recipeList)
  end
  local storySequence=unlockInfo.storySequence
  local resource=unlockInfo.resource or unlockInfo.resourceTable
  local resourceName,o
  if resource then
    for i,resource in ipairs(resource)do
      resourceName=resource.name
      AddToGetRecipeListByItemId(resourceName,recipeName)
    end
  end
  local building=unlockInfo.building
  local productionName
  if building then
    for i,buildInfo in ipairs(building)do
      resourceName=buildInfo.resourceName
      productionName=buildInfo.productionName
      AddToGetRecipeListByItemId(resourceName,recipeName)
      if this.GetBuildingNameByRecipeName[recipeName]then
      end
      this.GetBuildingNameByRecipeName[recipeName]=productionName
      this.GetRecipeNameByBuildingNameAndResourceName[productionName]=this.GetRecipeNameByBuildingNameAndResourceName[productionName]or{}
      if this.GetRecipeNameByBuildingNameAndResourceName[productionName][resourceName]then
      end
      this.GetRecipeNameByBuildingNameAndResourceName[productionName][resourceName]=recipeName
    end
  end
  local production=unlockInfo.production
  if production then
    for i,prodInfo in ipairs(production)do
      resourceName=prodInfo.name
      AddToGetRecipeListByItemId(resourceName,recipeName)
    end
  end
  this.GetStorySequenceByRecipeName[recipeName]=storySequence
end
return this
