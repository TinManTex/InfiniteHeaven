-- InfLangCpNames.lua
local this={}

this.cpNames={
  afgh={},
  mafr={},
  mtbs={},
}
this.cpNames.afgh.eng={
  afgh_citadelSouth_ob="Guard Post 01",-- East Afghanistan Central Base Camp
  afgh_sovietSouth_ob="Guard Post 02",-- South Afghanistan Central Base Camp
  afgh_plantWest_ob="Guard Post 03",-- NW Serak Power Plant
  afgh_waterwayEast_ob="Guard Post 04",-- East Aabe Shifap Ruins
  afgh_tentNorth_ob="Guard Post 05",-- NE Yakho Oboo Supply Outpost
  afgh_enemyNorth_ob="Guard Post 06",-- NE Wakh Sind Barracks
  afgh_cliffWest_ob="Guard Post 07",-- NW Sakhra Ee Village
  afgh_tentEast_ob="Guard Post 08",-- SE Yakho Oboo Supply Outpost
  afgh_enemyEast_ob="Guard Post 09",-- East Wakh Sind Barracks
  afgh_cliffEast_ob="Guard Post 10",-- East Sakhra Ee Village
  afgh_slopedWest_ob="Guard Post 11",-- NW Ghwandai Town
  afgh_remnantsNorth_ob="Guard Post 12",-- North Lamar Khaate Palace
  afgh_cliffSouth_ob="Guard Post 13",-- South Sakhra Ee Village
  afgh_fortWest_ob="Guard Post 14",-- West Smasei Fort
  afgh_villageWest_ob="Guard Post 15",-- NW Wialo Village
  afgh_slopedEast_ob="Guard Post 16",-- SE Da Ghwandai Khar
  afgh_fortSouth_ob="Guard Post 17",-- SW Smasei Fort
  afgh_villageNorth_ob="Guard Post 18",-- NE Wailo Village
  afgh_commWest_ob="Guard Post 19",-- West Eastern Communications Post
  afgh_bridgeWest_ob="Guard Post 20",-- West Mountain Relay Base
  afgh_bridgeNorth_ob="Guard Post 21",-- SE Mountain Relay Base
  afgh_fieldWest_ob="Guard Post 22",-- North Shago Village
  afgh_villageEast_ob="Guard Post 23",-- SE Wailo Village
  afgh_ruinsNorth_ob="Guard Post 24",-- East Spugmay Keep
  afgh_fieldEast_ob="Guard Post 25",-- East Shago Village

  --afgh_plantSouth_ob--Only references in generic setups",-- no actual missions
  --afgh_waterway_cp--Only references in generic setups",-- no actual missions

  afgh_cliffTown_cp="Qarya Sakhra Ee",
  afgh_tent_cp="Yakho Oboo Supply Outpost",
  afgh_powerPlant_cp="Serak Power Plant",
  afgh_sovietBase_cp="Afghanistan Central Base Camp",
  afgh_remnants_cp="Lamar Khaate Palace",
  afgh_field_cp="Da Shago Kallai",
  afgh_citadel_cp="OKB Zero",
  afgh_fort_cp="Da Smasei Laman",
  afgh_village_cp="Da Wialo Kallai",
  afgh_bridge_cp="Mountain Relay Base",
  afgh_commFacility_cp="Eastern Communications Post",
  afgh_slopedTown_cp="Da Ghwandai Khar",
  afgh_enemyBase_cp="Wakh Sind Barracks",
}

this.cpNames.mafr.eng={
  mafr_swampWest_ob="Guard Post 01",-- NW Kiziba Camp
  mafr_diamondNorth_ob="Guard Post 02",-- NE Kungenga Mine
  mafr_bananaEast_ob="Guard Post 03",-- SE Bampeve Plantation
  mafr_bananaSouth_ob="Guard Post 04",-- SW Bampeve Plantation
  mafr_savannahNorth_ob="Guard Post 05",-- NE Ditadi Abandoned Village
  mafr_outlandNorth_ob="Guard Post 06",-- North Masa Village
  mafr_diamondWest_ob="Guard Post 07",-- West Kungenga Mine
  mafr_labWest_ob="Guard Post 08",-- NW Lufwa Valley
  mafr_savannahWest_ob="Guard Post 09",-- North Ditadi Abandoned Village
  mafr_swampEast_ob="Guard Post 10",-- SE Kiziba Camp
  mafr_outlandEast_ob="Guard Post 11",-- East Masa Village
  mafr_swampSouth_ob="Guard Post 12",-- South Kiziba Camp
  mafr_diamondSouth_ob="Guard Post 13",-- SW Kungenga Mine
  mafr_pfCampNorth_ob="Guard Post 14",-- NE Nova Braga Airport
  mafr_savannahEast_ob="Guard Post 15",-- South Ditadi Abandoned Village
  mafr_hillNorth_ob="Guard Post 16",-- NE Munoko ya Nioka Station
  mafr_factoryWest_ob="Guard Post 17",-- West Ngumba Industrial Zone
  mafr_pfCampEast_ob="Guard Post 18",-- East Nova Braga Airport
  mafr_hillWest_ob="Guard Post 19",-- NW Munoko ya Nioka Station
  mafr_factorySouth_ob="Guard Post 20",-- SW Ngumba Industrial Zone
  mafr_hillWestNear_ob="Guard Post 21",-- West Munoko ya Nioka Station
  mafr_chicoVilWest_ob="Guard Post 22",-- South Nova Braga Airport
  mafr_hillSouth_ob="Guard Post 23",-- SW Munoko ya Nioka Station
  --mafr_swampWestNear_ob--Only references in generic setups, no actual missions
  mafr_flowStation_cp="Mfinda Oilfield",
  mafr_banana_cp="Bampeve Plantation",
  mafr_diamond_cp="Kungenga Mine",
  mafr_lab_cp="Lufwa Valley",
  mafr_swamp_cp="Kiziba Camp",
  mafr_outland_cp="Masa Village",
  mafr_savannah_cp="Ditadi Abandoned Village",
  mafr_pfCamp_cp="Nova Braga Airport",
  mafr_hill_cp="Munoko ya Nioka Station",

--mafr_factory_cp,--Ngumba Industrial Zone - no soldiers
--mafr_chicoVil_cp,--??
}

this.cpNames.mtbs.eng={
  ["ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|mtbs_command_cp"]="Command",
  ["ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|mtbs_combat_cp"]="Combat",
  ["ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|mtbs_develop_cp"]="Research and Development",
  ["ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|mtbs_support_cp"]="Support",
  ["ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|mtbs_medic_cp"]="Medical",
  ["ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|mtbs_intel_cp"]="Intel",
  ["ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|mtbs_basedev_cp"]="Base Development",
}

return this