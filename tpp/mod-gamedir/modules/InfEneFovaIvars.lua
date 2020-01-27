-- InfEneFova.lua
local this={}

-->
this.registerIvars={
  'mbDDHeadGear',
}

IvarProc.MissionModeIvars(
  this,
  "customSoldierType",
  {
    save=IvarProc.CATEGORY_EXTERNAL,
    settings={
      "OFF",
      --CULL "EQUIPGRADE",
      "DRAB",
      "TIGER",
      "SNEAKING_SUIT",
      "BATTLE_DRESS",
      "SWIMWEAR",
      "SWIMWEAR2",
      "SWIMWEAR3",
      "PFA_ARMOR",
      "SOVIET_A",
      "SOVIET_B",
      "PF_A",
      "PF_B",
      "PF_C",
      "SOVIET_BERETS",
      "SOVIET_HOODIES",
      "SOVIET_ALL",
      "PF_MISC",
      "PF_ALL",
      --"MSF_SVS",
      --"MSF_PFS",
      --"GZ",
      --"PRISONER_AFGH",
      --"PRISONER_MAFR",
      --"SKULLFACE",
      --"HUEY",
      --"KAZ",
      --"KAZ_GZ",
      --"DOCTOR",
      --"DD_RESEARCHER",
      --"DD_RESEARCHER_FEMALE",
      --"DDS_PILOT1",
      --"DDS_PILOT2",
      "MSF_GZ",
      "MSF_TPP",
      --"MSF_MEDIC",
      --"MSF_KOJIMA",
      --"DDS_GROUNDCREW",
      "XOF",
      "XOF_GASMASK",
      "XOF_GZ",
      --"WSS1_MAIN0",
      "GENOME_SOLDIER",
      --      "PRISONER_AFGH",
      --      "PRISONER_MAFR",
      --"CHILD_0",
      "FATIGUES_CAMO_MIX",
    },
    settingNames="customSoldierTypeSettings",
  },
  {
    "FREE",
    --"MISSION",--TODO: missions a bit more complicated with a bunch of specific body setup
    "MB_ALL",
  }
)

IvarProc.MissionModeIvars(
  this,
  "customSoldierTypeFemale",
  {
    save=IvarProc.CATEGORY_EXTERNAL,
    settings={
      "OFF",
      --CULL "EQUIPGRADE",
      "DRAB_FEMALE",
      "TIGER_FEMALE",
      "SNEAKING_SUIT_FEMALE",
      "BATTLE_DRESS_FEMALE",
      "SWIMWEAR_FEMALE",
      "SWIMWEAR2_FEMALE",
      "SWIMWEAR3_FEMALE",
    --    "PRISONER_AFGH_FEMALE",
    --    "NURSE_FEMALE",
    --"DD_RESEARCHER_FEMALE",
    --"FATIGUES_CAMO_MIX_FEMALE",
    },
  },
  {
    --"FREE",
    --"MISSION",--TODO: missions a bit more complicated with a bunch of specific body setup
    "MB_ALL",
  }
)

this.mbDDHeadGear={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  MissionCheck=IvarProc.MissionCheckMbAll,
}
--< ivar defs
this.langStrings={
  eng={
    mbDDHeadGear="DD Head gear",
    mbDDHeadGearSettings={"Off","Current prep"},
    customSoldierTypeFREE="Custom soldier type in Free roam",
    customSoldierTypeMB_ALL="DD Suit",
    customSoldierTypeSettings={
      "Off",
      "Drab fatigues",
      "Tiger fatigues",
      "Sneaking suit",
      "Battle Dress",
      "Swimsuit",
      "Goblin swimsuit",
      "Megalodon swimsuit",
      "PF Riot Suit",
      "Soviet",
      "Soviet Urban",
      "CFA",
      "ZRS",
      "Rogue Coyote",
      "Soviet berets",
      "Soviet hoodies",
      "Soviet All",
      "PF misc",
      "PF All",
      "MSF GZ",
      "MSF TPP",
      "XOF",
      "XOF Gasmasks",
      "XOF GZ",
      "Genome Soldier",
      "Fatigues All",
    },
    customSoldierTypeFemaleMB_ALL="DD Suit female",
    customSoldierTypeFemaleMB_ALLSettings={
      "Off",
      "Drab",
      "Tiger",
      "Sneaking",
      "Battle Dress",
      "Swimsuit",
      "Goblin swimsuit",
      "Megalodon swimsuit"
    },
    setting_only_for_dd="This setting is only for DD soliders",
  },
  help={
    eng={
      customSoldierTypeFREE="Override the soldier type of enemy soldiers in Free Roam",

    },
  }
}
--< lang strings

return this
