-- DOBUILD: 1
local this={}
local StrCode32=Fox.StrCode32
local n=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local IsTypeNumber=Tpp.IsTypeNumber
local GetGameObjectId=GameObject.GetGameObjectId
local GetGameObjectIdByIndex=GameObject.GetGameObjectIdByIndex
local n=TppGameObject.GAME_OBJECT_TYPE_VEHICLE
local NULL_ID=GameObject.NULL_ID
local SendCommand=GameObject.SendCommand
local DEBUG_StrCode32ToString=Tpp.DEBUG_StrCode32ToString
local _="quest_cp"
local enemySubType=EnemySubType or{}
local function c(i)--tex NMC: cant actually find reference to original function, it looks similar to setsolidertype/subtype
  local e={}
  for t,n in ipairs(i)do
    if IsTypeTable(n)then
      e[t]=c(n)
    else
      local n=GetGameObjectId(i[t])
      if n and n~=NULL_ID then
        e[n]=t
      end
    end
  end
  return e
end
function this.Messages()
  return Tpp.StrCode32Table{
    Player={
      {msg="RideHelicopterWithHuman",func=this._RideHelicopterWithHuman}
    },
    GameObject={
      {msg="Dead",func=this._OnDead},
      {msg="PlacedIntoVehicle",func=this._PlacedIntoVehicle},
      {msg="Damage",func=this._OnDamage},
      {msg="RoutePoint2",func=this._DoRoutePointMessage},
      {msg="LostControl",func=this._OnHeliBroken},
      {msg="VehicleBroken",func=this._OnVehicleBroken,option={isExecDemoPlaying=true}},
      {msg="WalkerGearBroken",func=this._OnWalkerGearBroken},
      {msg="ChangePhaseForAnnounce",func=this._AnnouncePhaseChange},
      {msg="InterrogateUpHero",func=function(gameId)
        local soldierType=this.GetSoldierType(gameId)
        if(soldierType~=EnemyType.TYPE_DD)then
          TppTrophy.Unlock(30)
        end
        PlayRecord.RegistPlayRecord"PLAYER_INTERROGATION"
      end}
    },
    Weather={
      {msg="Clock",sender="ShiftChangeAtNight",func=function(n,n)
        this.ShiftChangeByTime"shiftAtNight"
      end},
      {msg="Clock",sender="ShiftChangeAtMorning",func=function(n,n)
        this.ShiftChangeByTime"shiftAtMorning"
      end},
      {msg="Clock",sender="ShiftChangeAtMidNight",func=function(n,n)
        this.ShiftChangeByTime"shiftAtMidNight"
      end}
    }
  }
end
this.POWER_SETTING={
"NO_KILL_WEAPON",
"ARMOR",
"SOFT_ARMOR",
"SNIPER",
"SHIELD",
"MISSILE",
"MG",
"SHOTGUN",
"SMG",
"HELMET",
"NVG",
"GAS_MASK",
"GUN_LIGHT",
"STRONG_WEAPON",
"STRONG_PATROL",
"STRONG_NOTICE_TRANQ",
"FULTON_SPECIAL",
"FULTON_HIGH",
"FULTON_LOW",
"COMBAT_SPECIAL",
"COMBAT_HIGH",
"COMBAT_LOW",
"STEALTH_SPECIAL",
"STEALTH_HIGH",
"STEALTH_LOW",
"HOLDUP_SPECIAL",
"HOLDUP_HIGH",
"HOLDUP_LOW"
}
this.PHASE={SNEAK=0,CAUTION=1,EVASION=2,ALERT=3,MAX=4}
this.ROUTE_SET_TYPES={"sneak_day","sneak_night","caution","hold","travel","sneak_midnight","sleep"}
this.LIFE_STATUS={NORMAL=0,DEAD=1,DYING=2,SLEEP=3,FAINT=4}
this.ACTION_STATUS={NORMAL=0,FULTON_RECOVERD=1,HOLD_UP_STAND=2,HOLD_UP_CROWL=3,NOW_CARRYING=4}
this.SOLDIER_DEFINE_RESERVE_TABLE_NAME=Tpp.Enum{"lrrpTravelPlan","lrrpVehicle"}
this.TAKING_OVER_HOSTAGE_LIST={"hos_takingOver_0000","hos_takingOver_0001","hos_takingOver_0002","hos_takingOver_0003"}
this.ROUTE_SET_TYPETAG={}
this.subTypeOfCpTable={
  SOVIET_A={
    afgh_field_cp=true,
    afgh_remnants_cp=true,
    afgh_tent_cp=true,
    afgh_fieldEast_ob=true,
    afgh_fieldWest_ob=true,
    afgh_remnantsNorth_ob=true,
    afgh_tentEast_ob=true,
    afgh_tentNorth_ob=true,
    afgh_01_16_lrrp=true,
    afgh_29_20_lrrp=true,
    afgh_29_16_lrrp=true,
    afgh_village_cp=true,
    afgh_slopedTown_cp=true,
    afgh_commFacility_cp=true,
    afgh_enemyBase_cp=true,
    afgh_commWest_ob=true,
    afgh_ruinsNorth_ob=true,
    afgh_slopedWest_ob=true,
    afgh_villageEast_ob=true,
    afgh_villageEast_ob=true,
    afgh_villageNorth_ob=true,
    afgh_villageWest_ob=true,
    afgh_enemyEast_ob=true,
    afgh_01_13_lrrp=true,
    afgh_02_14_lrrp=true,
    afgh_32_01_lrrp=true,
    afgh_32_04_lrrp=true,
    afgh_32_14_lrrp=true,
    afgh_34_02_lrrp=true,
    afgh_34_13_lrrp=true,
    afgh_35_02_lrrp=true,
    afgh_35_14_lrrp=true,
    afgh_35_15_lrrp=true,
    afgh_36_04_lrrp=true,
    afgh_36_15_lrrp=true,
    afgh_36_06_lrrp=true
  },
  SOVIET_B={
    afgh_bridge_cp=true,
    afgh_fort_cp=true,
    afgh_cliffTown_cp=true,
    afgh_bridgeNorth_ob=true,
    afgh_bridgeWest_ob=true,
    afgh_cliffEast_ob=true,
    afgh_cliffSouth_ob=true,
    afgh_cliffWest_ob=true,
    afgh_enemyNorth_ob=true,
    afgh_fortSouth_ob=true,
    afgh_fortWest_ob=true,
    afgh_slopedEast_ob=true,
    afgh_powerPlant_cp=true,
    afgh_sovietBase_cp=true,
    afgh_plantSouth_ob=true,
    afgh_plantWest_ob=true,
    afgh_sovietSouth_ob=true,
    afgh_waterwayEast_ob=true,
    afgh_citadel_cp=true,
    afgh_citadelSouth_ob=true
  },
  PF_A={
    mafr_outland_cp=true,
    mafr_outlandEast_ob=true,
    mafr_outlandNorth_ob=true,
    mafr_01_20_lrrp=true,
    mafr_03_20_lrrp=true,
    mafr_flowStation_cp=true,
    mafr_swamp_cp=true,
    mafr_pfCamp_cp=true,
    mafr_savannah_cp=true,
    mafr_swampEast_ob=true,
    mafr_swampWest_ob=true,
    mafr_swampSouth_ob=true,
    mafr_pfCampEast_ob=true,
    mafr_pfCampNorth_ob=true,
    mafr_savannahEast_ob=true,
    mafr_chicoVilWest_ob=true,
    mafr_hillSouth_ob=true,
    mafr_02_21_lrrp=true,
    mafr_02_22_lrrp=true,
    mafr_05_23_lrrp=true,
    mafr_06_16_lrrp=true,
    mafr_06_22_lrrp=true,
    mafr_06_24_lrrp=true,
    mafr_13_15_lrrp=true,
    mafr_13_16_lrrp=true,
    mafr_13_24_lrrp=true,
    mafr_15_16_lrrp=true,
    mafr_15_23_lrrp=true,
    mafr_16_23_lrrp=true,
    mafr_16_24_lrrp=true,
    mafr_23_33_lrrp=true},
  PF_B={
    mafr_factory_cp=true,
    mafr_lab_cp=true,
    mafr_labWest_ob=true,
    mafr_19_29_lrrp=true
  },
  PF_C={
    mafr_banana_cp=true,
    mafr_diamond_cp=true,
    mafr_hill_cp=true,
    mafr_savannahNorth_ob=true,
    mafr_savannahWest_ob=true,
    mafr_bananaEast_ob=true,
    mafr_bananaSouth_ob=true,
    mafr_hillNorth_ob=true,
    mafr_hillWest_ob=true,
    mafr_hillWestNear_ob=true,
    mafr_factorySouth_ob=true,
    mafr_factoryWest_ob=true,
    mafr_diamondNorth_ob=true,
    mafr_diamondSouth_ob=true,
    mafr_diamondWest_ob=true,
    mafr_07_09_lrrp=true,
    mafr_07_24_lrrp=true,
    mafr_08_10_lrrp=true,
    mafr_08_25_lrrp=true,
    mafr_09_25_lrrp=true,
    mafr_10_11_lrrp=true,
    mafr_10_18_lrrp=true,
    mafr_10_26_lrrp=true,
    mafr_11_10_lrrp=true,
    mafr_11_12_lrrp=true,
    mafr_11_26_lrrp=true,
    mafr_12_14_lrrp=true,
    mafr_14_27_lrrp=true,
    mafr_17_27_lrrp=true,
    mafr_18_26_lrrp=true,
    mafr_27_30_lrrp=true
  }
}
this.subTypeOfCp={}
for subType,cp in pairs(this.subTypeOfCpTable)do
  for cpName,bool in pairs(cp)do
    this.subTypeOfCp[cpName]=subType
  end
end
local tppEnemyBodyId=TppEnemyBodyId or{}
this.childBodyIdTable={tppEnemyBodyId.chd0_v00,tppEnemyBodyId.chd0_v01,tppEnemyBodyId.chd0_v02,tppEnemyBodyId.chd0_v03,tppEnemyBodyId.chd0_v05,tppEnemyBodyId.chd0_v06,tppEnemyBodyId.chd0_v07,tppEnemyBodyId.chd0_v08,tppEnemyBodyId.chd0_v09,tppEnemyBodyId.chd0_v10,tppEnemyBodyId.chd0_v11}
this.bodyIdTable={
  SOVIET_A={
    ASSAULT={tppEnemyBodyId.svs0_rfl_v00_a,tppEnemyBodyId.svs0_rfl_v00_a,tppEnemyBodyId.svs0_rfl_v01_a,tppEnemyBodyId.svs0_mcg_v00_a},
    ASSAULT_OB={tppEnemyBodyId.svs0_rfl_v02_a,tppEnemyBodyId.svs0_mcg_v02_a},
    SNIPER={tppEnemyBodyId.svs0_snp_v00_a},
    SHOTGUN={tppEnemyBodyId.svs0_rfl_v00_a,tppEnemyBodyId.svs0_rfl_v01_a},
    SHOTGUN_OB={tppEnemyBodyId.svs0_rfl_v02_a},
    MG={tppEnemyBodyId.svs0_mcg_v00_a,tppEnemyBodyId.svs0_mcg_v01_a},
    MG_OB={tppEnemyBodyId.svs0_mcg_v02_a},
    MISSILE={tppEnemyBodyId.svs0_rfl_v00_a},
    SHIELD={tppEnemyBodyId.svs0_rfl_v00_a},
    ARMOR={tppEnemyBodyId.sva0_v00_a},
    RADIO={tppEnemyBodyId.svs0_rdo_v00_a}
  },
  SOVIET_B={
    ASSAULT={tppEnemyBodyId.svs0_rfl_v00_b,tppEnemyBodyId.svs0_rfl_v00_b,tppEnemyBodyId.svs0_rfl_v01_b,tppEnemyBodyId.svs0_mcg_v00_b},
    ASSAULT_OB={tppEnemyBodyId.svs0_rfl_v02_b,tppEnemyBodyId.svs0_mcg_v02_b},
    SNIPER={tppEnemyBodyId.svs0_snp_v00_b},
    SHOTGUN={tppEnemyBodyId.svs0_rfl_v00_b,tppEnemyBodyId.svs0_rfl_v01_b},
    SHOTGUN_OB={tppEnemyBodyId.svs0_rfl_v02_b},
    MG={tppEnemyBodyId.svs0_mcg_v00_b,tppEnemyBodyId.svs0_mcg_v01_b},
    MG_OB={tppEnemyBodyId.svs0_mcg_v02_b},
    MISSILE={tppEnemyBodyId.svs0_rfl_v00_b},
    SHIELD={tppEnemyBodyId.svs0_rfl_v00_b},
    ARMOR={tppEnemyBodyId.sva0_v00_a},
    RADIO={tppEnemyBodyId.svs0_rdo_v00_b}
  },
  PF_A={
    ASSAULT={tppEnemyBodyId.pfs0_rfl_v00_a,tppEnemyBodyId.pfs0_mcg_v00_a},
    ASSAULT_OB={tppEnemyBodyId.pfs0_rfl_v00_a,tppEnemyBodyId.pfs0_rfl_v01_a,tppEnemyBodyId.pfs0_mcg_v00_a},
    SNIPER={tppEnemyBodyId.pfs0_snp_v00_a},
    SHOTGUN={tppEnemyBodyId.pfs0_rfl_v00_a},
    SHOTGUN_OB={tppEnemyBodyId.pfs0_rfl_v00_a,tppEnemyBodyId.pfs0_rfl_v01_a},
    MG={tppEnemyBodyId.pfs0_mcg_v00_a},
    MISSILE={tppEnemyBodyId.pfs0_rfl_v00_a},
    SHIELD={tppEnemyBodyId.pfs0_rfl_v00_a},
    ARMOR={tppEnemyBodyId.pfa0_v00_b},
    RADIO={tppEnemyBodyId.pfs0_rdo_v00_a}
  },
  PF_B={
    ASSAULT={tppEnemyBodyId.pfs0_rfl_v00_b,tppEnemyBodyId.pfs0_mcg_v00_b},
    ASSAULT_OB={tppEnemyBodyId.pfs0_rfl_v00_b,tppEnemyBodyId.pfs0_rfl_v01_b,tppEnemyBodyId.pfs0_mcg_v00_b},
    SNIPER={tppEnemyBodyId.pfs0_snp_v00_b},
    SHOTGUN={tppEnemyBodyId.pfs0_rfl_v00_b},
    SHOTGUN_OB={tppEnemyBodyId.pfs0_rfl_v00_b,tppEnemyBodyId.pfs0_rfl_v01_b},
    MG={tppEnemyBodyId.pfs0_mcg_v00_b},
    MISSILE={tppEnemyBodyId.pfs0_rfl_v00_b},
    SHIELD={tppEnemyBodyId.pfs0_rfl_v00_b},
    ARMOR={tppEnemyBodyId.pfa0_v00_a},
    RADIO={tppEnemyBodyId.pfs0_rdo_v00_b}
  },
  PF_C={
    ASSAULT={tppEnemyBodyId.pfs0_rfl_v00_c,tppEnemyBodyId.pfs0_mcg_v00_c},
    ASSAULT_OB={tppEnemyBodyId.pfs0_rfl_v00_c,tppEnemyBodyId.pfs0_rfl_v01_c,tppEnemyBodyId.pfs0_mcg_v00_c},
    SNIPER={tppEnemyBodyId.pfs0_snp_v00_c},
    SHOTGUN={tppEnemyBodyId.pfs0_rfl_v00_c},
    SHOTGUN_OB={tppEnemyBodyId.pfs0_rfl_v00_c,tppEnemyBodyId.pfs0_rfl_v01_c},
    MG={tppEnemyBodyId.pfs0_mcg_v00_c},
    MISSILE={tppEnemyBodyId.pfs0_rfl_v00_c},
    SHIELD={tppEnemyBodyId.pfs0_rfl_v01_c},
    ARMOR={tppEnemyBodyId.pfa0_v00_c},
    RADIO={tppEnemyBodyId.pfs0_rdo_v00_c}
  },
  DD_A={ASSAULT={tppEnemyBodyId.dds3_main0_v00}},
  DD_FOB={ASSAULT={tppEnemyBodyId.dds5_main0_v00}},
  DD_PW={ASSAULT={tppEnemyBodyId.dds0_main1_v00}},
  SKULL_CYPR={ASSAULT={tppEnemyBodyId.wss0_main0_v00}},
  SKULL_AFGH={ASSAULT={tppEnemyBodyId.wss4_main0_v00}},
  CHILD={ASSAULT=this.childBodyIdTable}
}
this.weaponIdTable={
  SOVIET_A={
    NORMAL={
      HANDGUN=TppEquip.EQP_WP_East_hg_010,
      SMG=TppEquip.EQP_WP_East_sm_010,
      ASSAULT=TppEquip.EQP_WP_East_ar_010,
      SNIPER=TppEquip.EQP_WP_East_sr_011,
      SHOTGUN=TppEquip.EQP_WP_Com_sg_011,
      MG=TppEquip.EQP_WP_East_mg_010,
      MISSILE=TppEquip.EQP_WP_East_ms_010,
      SHIELD=TppEquip.EQP_SLD_SV
    },
    STRONG={
      HANDGUN=TppEquip.EQP_WP_East_hg_010,
      SMG=TppEquip.EQP_WP_East_sm_020,
      ASSAULT=TppEquip.EQP_WP_East_ar_030,
      SNIPER=TppEquip.EQP_WP_East_sr_020,
      SHOTGUN=TppEquip.EQP_WP_Com_sg_020,
      MG=TppEquip.EQP_WP_East_mg_010,
      MISSILE=TppEquip.EQP_WP_Com_ms_010,
      SHIELD=TppEquip.EQP_SLD_SV
    }
  },
  PF_A={
    NORMAL={
      HANDGUN=TppEquip.EQP_WP_West_hg_010,
      SMG=TppEquip.EQP_WP_West_sm_010,
      ASSAULT=TppEquip.EQP_WP_West_ar_010,
      SNIPER=TppEquip.EQP_WP_West_sr_011,
      SHOTGUN=TppEquip.EQP_WP_Com_sg_011,
      MG=TppEquip.EQP_WP_West_mg_010,
      MISSILE=TppEquip.EQP_WP_West_ms_010,
      SHIELD=TppEquip.EQP_SLD_PF_01
    },
    STRONG={
      HANDGUN=TppEquip.EQP_WP_West_hg_010,
      SMG=TppEquip.EQP_WP_West_sm_020,
      ASSAULT=TppEquip.EQP_WP_West_ar_020,
      SNIPER=TppEquip.EQP_WP_West_sr_020,
      SHOTGUN=TppEquip.EQP_WP_Com_sg_020,
      MG=TppEquip.EQP_WP_West_mg_010,
      MISSILE=TppEquip.EQP_WP_Com_ms_010,
      SHIELD=TppEquip.EQP_SLD_PF_01
    }
  },
  PF_B={
    NORMAL={
      HANDGUN=TppEquip.EQP_WP_West_hg_010,
      SMG=TppEquip.EQP_WP_West_sm_010,
      ASSAULT=TppEquip.EQP_WP_West_ar_010,
      SNIPER=TppEquip.EQP_WP_West_sr_011,
      SHOTGUN=TppEquip.EQP_WP_Com_sg_011,
      MG=TppEquip.EQP_WP_West_mg_010,
      MISSILE=TppEquip.EQP_WP_West_ms_010,
      SHIELD=TppEquip.EQP_SLD_PF_00
    },
    STRONG={
      HANDGUN=TppEquip.EQP_WP_West_hg_010,
      SMG=TppEquip.EQP_WP_West_sm_020,
      ASSAULT=TppEquip.EQP_WP_West_ar_020,
      SNIPER=TppEquip.EQP_WP_West_sr_020,
      SHOTGUN=TppEquip.EQP_WP_Com_sg_020,
      MG=TppEquip.EQP_WP_West_mg_010,
      MISSILE=TppEquip.EQP_WP_Com_ms_010,
      SHIELD=TppEquip.EQP_SLD_PF_00
    }
  },
  PF_C={
    NORMAL={
      HANDGUN=TppEquip.EQP_WP_West_hg_010,
      SMG=TppEquip.EQP_WP_West_sm_010,
      ASSAULT=TppEquip.EQP_WP_West_ar_010,
      SNIPER=TppEquip.EQP_WP_West_sr_011,
      SHOTGUN=TppEquip.EQP_WP_Com_sg_011,
      MG=TppEquip.EQP_WP_West_mg_010,
      MISSILE=TppEquip.EQP_WP_West_ms_010,
      SHIELD=TppEquip.EQP_SLD_PF_02
    },
    STRONG={
      HANDGUN=TppEquip.EQP_WP_West_hg_010,
      SMG=TppEquip.EQP_WP_West_sm_020,
      ASSAULT=TppEquip.EQP_WP_West_ar_020,
      SNIPER=TppEquip.EQP_WP_West_sr_020,
      SHOTGUN=TppEquip.EQP_WP_Com_sg_020,
      MG=TppEquip.EQP_WP_West_mg_010,
      MISSILE=TppEquip.EQP_WP_Com_ms_010,
      SHIELD=TppEquip.EQP_SLD_PF_02
    }
  },
  DD=nil,
  SKULL_CYPR={
    NORMAL={
      HANDGUN=TppEquip.EQP_WP_West_hg_020,
      SMG=TppEquip.EQP_WP_East_sm_030}},
  SKULL={
    NORMAL={
      HANDGUN=TppEquip.EQP_WP_West_hg_020,
      SMG=TppEquip.EQP_WP_West_sm_020,
      ASSAULT=TppEquip.EQP_WP_West_ar_030,
      SNIPER=TppEquip.EQP_WP_West_sr_020,
      SHOTGUN=TppEquip.EQP_WP_Com_sg_011,
      MG=TppEquip.EQP_WP_West_mg_020,
      MISSILE=TppEquip.EQP_WP_West_ms_010,
      SHIELD=TppEquip.EQP_SLD_PF_02},
    STRONG={
      HANDGUN=TppEquip.EQP_WP_West_hg_020,
      SMG=TppEquip.EQP_WP_West_sm_020,
      ASSAULT=TppEquip.EQP_WP_West_ar_030,
      SNIPER=TppEquip.EQP_WP_West_sr_020,
      SHOTGUN=TppEquip.EQP_WP_Com_sg_020,
      MG=TppEquip.EQP_WP_West_mg_020,
      MISSILE=TppEquip.EQP_WP_Com_ms_010,
      SHIELD=TppEquip.EQP_SLD_PF_02}},
  CHILD={
    NORMAL={
      HANDGUN=TppEquip.EQP_WP_East_hg_010,
      ASSAULT=TppEquip.EQP_WP_East_ar_020}
  }
}
this.gunLightWeaponIds={
  [TppEquip.EQP_WP_Com_sg_011]=TppEquip.EQP_WP_Com_sg_011_FL,
  [TppEquip.EQP_WP_Com_sg_020]=TppEquip.EQP_WP_Com_sg_020_FL,
  [TppEquip.EQP_WP_West_ar_010]=TppEquip.EQP_WP_West_ar_010_FL,
  [TppEquip.EQP_WP_West_ar_020]=TppEquip.EQP_WP_West_ar_020_FL,
  [TppEquip.EQP_WP_East_ar_010]=TppEquip.EQP_WP_East_ar_010_FL,
  [TppEquip.EQP_WP_East_ar_030]=TppEquip.EQP_WP_East_ar_030_FL
}
local mbsDevelopedEquipType=MbsDevelopedEquipType or{}
this.DDWeaponIdInfo={
  HANDGUN={{equipId=TppEquip.EQP_WP_West_hg_010}},
  SMG={
    {equipId=TppEquip.EQP_WP_East_sm_047,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SM_2040_NOKILL,developId=2044},
    {equipId=TppEquip.EQP_WP_East_sm_045,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SM_2040_NOKILL,developId=2043},
    {equipId=TppEquip.EQP_WP_East_sm_044,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SM_2040_NOKILL,developId=2042},
    {equipId=TppEquip.EQP_WP_East_sm_043,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SM_2040_NOKILL,developId=2041},
    {equipId=TppEquip.EQP_WP_East_sm_042,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SM_2040_NOKILL,developId=2040},
    {equipId=TppEquip.EQP_WP_West_sm_017,developedEquipType=mbsDevelopedEquipType.SM_2014,developId=2014},
    {equipId=TppEquip.EQP_WP_West_sm_016,developedEquipType=mbsDevelopedEquipType.SM_2010,developId=2013},
    {equipId=TppEquip.EQP_WP_West_sm_015,developedEquipType=mbsDevelopedEquipType.SM_2010,developId=2012},
    {equipId=TppEquip.EQP_WP_West_sm_014,developedEquipType=mbsDevelopedEquipType.SM_2010,developId=2011},
    {equipId=TppEquip.EQP_WP_West_sm_010,developedEquipType=mbsDevelopedEquipType.SM_2010,developId=2010}},
  SHOTGUN={
    {equipId=TppEquip.EQP_WP_Com_sg_038,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SG_4027_NOKILL,developId=4028},
    {equipId=TppEquip.EQP_WP_Com_sg_030,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SG_4027_NOKILL,developId=4027},
    {equipId=TppEquip.EQP_WP_Com_sg_025,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SG_4035_NOKILL,developId=4037},
    {equipId=TppEquip.EQP_WP_Com_sg_024,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SG_4035_NOKILL,developId=4036},
    {equipId=TppEquip.EQP_WP_Com_sg_023,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SG_4035_NOKILL,developId=4035},
    {equipId=TppEquip.EQP_WP_Com_sg_018,developedEquipType=mbsDevelopedEquipType.SG_4040,developId=4044},
    {equipId=TppEquip.EQP_WP_Com_sg_016,developedEquipType=mbsDevelopedEquipType.SG_4040,developId=4043},
    {equipId=TppEquip.EQP_WP_Com_sg_015,developedEquipType=mbsDevelopedEquipType.SG_4040,developId=4042},
    {equipId=TppEquip.EQP_WP_Com_sg_020,developedEquipType=mbsDevelopedEquipType.SG_4040,developId=4041},
    {equipId=TppEquip.EQP_WP_Com_sg_013,developedEquipType=mbsDevelopedEquipType.SG_4040,developId=4040},
    {equipId=TppEquip.EQP_WP_Com_sg_011,developedEquipType=mbsDevelopedEquipType.SG_4020,developId=4020}},
  ASSAULT={
    {equipId=TppEquip.EQP_WP_West_ar_077,isNoKill=true,developedEquipType=mbsDevelopedEquipType.AR_3060_NOKILL,developId=3064},
    {equipId=TppEquip.EQP_WP_West_ar_075,isNoKill=true,developedEquipType=mbsDevelopedEquipType.AR_3060_NOKILL,developId=3063},
    {equipId=TppEquip.EQP_WP_West_ar_070,isNoKill=true,developedEquipType=mbsDevelopedEquipType.AR_3060_NOKILL,developId=3062},
    {equipId=TppEquip.EQP_WP_West_ar_063,isNoKill=true,developedEquipType=mbsDevelopedEquipType.AR_3060_NOKILL,developId=3061},
    {equipId=TppEquip.EQP_WP_West_ar_060,isNoKill=true,developedEquipType=mbsDevelopedEquipType.AR_3060_NOKILL,developId=3060},
    {equipId=TppEquip.EQP_WP_West_ar_057,developedEquipType=mbsDevelopedEquipType.AR_3036,developId=3042},
    {equipId=TppEquip.EQP_WP_West_ar_050,developedEquipType=mbsDevelopedEquipType.AR_3036,developId=3038},
    {equipId=TppEquip.EQP_WP_West_ar_055,developedEquipType=mbsDevelopedEquipType.AR_3036,developId=3037},
    {equipId=TppEquip.EQP_WP_West_ar_010,developedEquipType=mbsDevelopedEquipType.AR_3036,developId=3036},
    {equipId=TppEquip.EQP_WP_West_ar_042,developedEquipType=mbsDevelopedEquipType.AR_3030,developId=3031},
    {equipId=TppEquip.EQP_WP_West_ar_040}},
  SNIPER={
    {equipId=TppEquip.EQP_WP_West_sr_048,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SR_6037_NOKILL,developId=6039},
    {equipId=TppEquip.EQP_WP_West_sr_047,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SR_6037_NOKILL,developId=6038},
    {equipId=TppEquip.EQP_WP_West_sr_037,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SR_6037_NOKILL,developId=6037},
    {equipId=TppEquip.EQP_WP_East_sr_034,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SR_6005_NOKILL,developId=6006},
    {equipId=TppEquip.EQP_WP_East_sr_033,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SR_6005_NOKILL,developId=6008},
    {equipId=TppEquip.EQP_WP_East_sr_032,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SR_6005_NOKILL,developId=6005},
    {equipId=TppEquip.EQP_WP_West_sr_027,developedEquipType=mbsDevelopedEquipType.SR_6030,developId=6033},
    {equipId=TppEquip.EQP_WP_West_sr_020,developedEquipType=mbsDevelopedEquipType.SR_6030,developId=6032},
    {equipId=TppEquip.EQP_WP_West_sr_014,developedEquipType=mbsDevelopedEquipType.SR_6030,developId=6031},
    {equipId=TppEquip.EQP_WP_West_sr_013,developedEquipType=mbsDevelopedEquipType.SR_6030,developId=6030},
    {equipId=TppEquip.EQP_WP_West_sr_011,developedEquipType=mbsDevelopedEquipType.SR_6010,developId=6010}},
  MG={
    {equipId=TppEquip.EQP_WP_West_mg_037,developedEquipType=mbsDevelopedEquipType.MG_7000,developId=7004},
    {equipId=TppEquip.EQP_WP_West_mg_030,developedEquipType=mbsDevelopedEquipType.MG_7000,developId=7003},
    {equipId=TppEquip.EQP_WP_West_mg_024,developedEquipType=mbsDevelopedEquipType.MG_7000,developId=7002},
    {equipId=TppEquip.EQP_WP_West_mg_023,developedEquipType=mbsDevelopedEquipType.MG_7000,developId=7001},
    {equipId=TppEquip.EQP_WP_West_mg_020,developedEquipType=mbsDevelopedEquipType.MG_7000,developId=7e3}},
  MISSILE={
    {equipId=TppEquip.EQP_WP_West_ms_020,isNoKill=true,developedEquipType=mbsDevelopedEquipType.MS_8013_NOKILL,developId=8013},
    {equipId=TppEquip.EQP_WP_Com_ms_026,developedEquipType=mbsDevelopedEquipType.MS_8020,developId=8023},
    {equipId=TppEquip.EQP_WP_Com_ms_020,developedEquipType=mbsDevelopedEquipType.MS_8020,developId=8022},
    {equipId=TppEquip.EQP_WP_Com_ms_024,developedEquipType=mbsDevelopedEquipType.MS_8020,developId=8021},
    {equipId=TppEquip.EQP_WP_Com_ms_023,developedEquipType=mbsDevelopedEquipType.MS_8020,developId=8020}},
  SHIELD={
    {equipId=TppEquip.EQP_SLD_DD,developedEquipType=mbsDevelopedEquipType.SD_9000,developId=9e3}},
  GRENADE={
    {equipId=TppEquip.EQP_SWP_Grenade_G05,developedEquipType=mbsDevelopedEquipType.GRENADE,developId=10045},
    {equipId=TppEquip.EQP_SWP_Grenade_G04,developedEquipType=mbsDevelopedEquipType.GRENADE,developId=10044},
    {equipId=TppEquip.EQP_SWP_Grenade_G03,developedEquipType=mbsDevelopedEquipType.GRENADE,developId=10043},
    {equipId=TppEquip.EQP_SWP_Grenade_G02,developedEquipType=mbsDevelopedEquipType.GRENADE,developId=10042},
    {equipId=TppEquip.EQP_SWP_Grenade_G01,developedEquipType=mbsDevelopedEquipType.GRENADE,developId=10041},
    {equipId=TppEquip.EQP_SWP_Grenade}},
  STUN_GRENADE={
    {equipId=TppEquip.EQP_SWP_StunGrenade_G03,isNoKill=true,developedEquipType=mbsDevelopedEquipType.STUN_GRENADE,developId=10063},
    {equipId=TppEquip.EQP_SWP_StunGrenade_G02,isNoKill=true,developedEquipType=mbsDevelopedEquipType.STUN_GRENADE,developId=10062},
    {equipId=TppEquip.EQP_SWP_StunGrenade_G01,isNoKill=true,developedEquipType=mbsDevelopedEquipType.STUN_GRENADE,developId=10061},
    {equipId=TppEquip.EQP_SWP_StunGrenade,isNoKill=true,developedEquipType=mbsDevelopedEquipType.STUN_GRENADE,developId=10060}},
  SNEAKING_SUIT={
    {equipId=3,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SNEAKING_SUIT,developId=19052},
    {equipId=2,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SNEAKING_SUIT,developId=19051},
    {equipId=1,isNoKill=true,developedEquipType=mbsDevelopedEquipType.SNEAKING_SUIT,developId=19050}},
  BATTLE_DRESS={
    {equipId=3,developedEquipType=mbsDevelopedEquipType.BATTLE_DRESS,developId=19055},
    {equipId=2,developedEquipType=mbsDevelopedEquipType.BATTLE_DRESS,developId=19054},
    {equipId=1,developedEquipType=mbsDevelopedEquipType.BATTLE_DRESS,developId=19053}}
}
do
  this.ROUTE_SET_TYPETAG[StrCode32"day"]="day"
  this.ROUTE_SET_TYPETAG[StrCode32"night"]="night"
  this.ROUTE_SET_TYPETAG[StrCode32"caution"]="caution"
  this.ROUTE_SET_TYPETAG[StrCode32"hold"]="hold"
  this.ROUTE_SET_TYPETAG[StrCode32"travel"]="travel"
  this.ROUTE_SET_TYPETAG[StrCode32"new"]="new"
  this.ROUTE_SET_TYPETAG[StrCode32"old"]="old"
  this.ROUTE_SET_TYPETAG[StrCode32"midnight"]="midnight"
  this.ROUTE_SET_TYPETAG[StrCode32"sleep"]="sleep"
end
this.DEFAULT_HOLD_TIME=60
this.DEFAULT_TRAVEL_HOLD_TIME=15
this.DEFAULT_SLEEP_TIME=300
this.FOB_DD_SUIT_ATTCKER=1
this.FOB_DD_SUIT_SNEAKING=2
this.FOB_DD_SUIT_BTRDRS=3
this.FOB_PF_SUIT_ARMOR=4
function this._ConvertSoldierNameKeysToId(soldierTypes)
  local i={}
  local n={}
  Tpp.MergeTable(n,soldierTypes)
  for soldierName,s in pairs(n)do
    if IsTypeString(soldierName)then
      local soldierId=GetGameObjectId("TppSoldier2",soldierName)
      if soldierId~=NULL_ID then
        table.insert(i,soldierName)
        soldierTypes[soldierId]=s
      end
    end
  end
  for t,n in ipairs(i)do
    soldierTypes[n]=nil
  end
end
function this._SetUpSoldierTypes(t,n)
  for a,soldierId in ipairs(n)do
    if IsTypeTable(soldierId)then
      this._SetUpSoldierTypes(t,soldierId)
    else
      mvars.ene_soldierTypes[soldierId]=EnemyType["TYPE_"..t]
    end
  end
end
function this.SetUpSoldierTypes(n)
  for n,t in pairs(n)do
    this._SetUpSoldierTypes(n,t)
  end
end
function this._SetUpSoldierSubTypes(subType,n)
  for a,n in ipairs(n)do
    if IsTypeTable(n)then
      this._SetUpSoldierSubTypes(subType,n)
    else
      local gameId=GetGameObjectId("TppSoldier2",n)
      mvars.ene_soldierSubType[gameId]=subType
    end
  end
end
function this.SetUpSoldierSubTypes(n)
  for n,t in pairs(n)do
    this._SetUpSoldierSubTypes(n,t)
  end
end
function this.SetUpPowerSettings(e)
  mvars.ene_missionSoldierPowerSettings=e
  local n={}
  for t,e in pairs(e)do
    for e,t in pairs(e)do
      local e=e
      if Tpp.IsTypeNumber(e)then
        e=t
      end
      n[e]=true
    end
  end
  mvars.ene_missionRequiresPowerSettings=n
end
function this.ApplyPowerSettingsOnInitialize()
  local missionPowerSettings=mvars.ene_missionSoldierPowerSettings
  for soldierName,loadout in pairs(missionPowerSettings)do
    local soldierId=GetGameObjectId(soldierName)
    if soldierId==NULL_ID then
    else
      this.ApplyPowerSetting(soldierId,loadout)
    end
  end
end
function this.DisablePowerSettings(e)
  local n={ASSAULT=true,HANDGUN=true}
  mvars.ene_disablePowerSettings={}
  for t,e in ipairs(e)do
    if n[e]then
    else
      mvars.ene_disablePowerSettings[e]=true
    end
  end
  if mvars.ene_disablePowerSettings.SMG then
    mvars.ene_disablePowerSettings.MISSILE=true
    mvars.ene_disablePowerSettings.SHIELD=true
  end
end
function this.SetUpPersonalAbilitySettings(e)
  mvars.ene_missionSoldierPersonalAbilitySettings=e
end
function this.ApplyPersonalAbilitySettingsOnInitialize()
  local n=mvars.ene_missionSoldierPersonalAbilitySettings
  for n,t in pairs(n)do
    local n=GetGameObjectId(n)
    if n==NULL_ID then
    else
      this.ApplyPersonalAbilitySettings(n,t)
    end
  end
end
function this.SetSoldierType(soldierId,soldierType)
  mvars.ene_soldierTypes[soldierId]=soldierType
  SendCommand(soldierId,{id="SetSoldier2Type",type=soldierType})
end
function this.GetSoldierType(soldierId)
  local missionCode=TppMission.GetMissionID()
  if soldierId==nil or soldierId==NULL_ID then
    if missionCode==10080 or missionCode==11080 then--PATCHUP:
      return EnemyType.TYPE_PF
    end
    for soldierId,soldierType in pairs(mvars.ene_soldierTypes)do
      if soldierType then
        return soldierType
      end
    end
  else
    if mvars.ene_soldierTypes then
      local soldierType=mvars.ene_soldierTypes[soldierId]
      if soldierType then
        return soldierType
      end
    end
  end
  if(missionCode==10150 or missionCode==10151)or missionCode==11151 then--PATCHUP:
    return EnemyType.TYPE_SKULL
  end
  local soliderType=EnemyType.TYPE_SOVIET
  if TppLocation.IsAfghan()then
    soliderType=EnemyType.TYPE_SOVIET
  elseif TppLocation.IsMiddleAfrica()then
    soliderType=EnemyType.TYPE_PF
  elseif TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
    soliderType=EnemyType.TYPE_DD
  elseif TppLocation.IsCyprus()then
    soliderType=EnemyType.TYPE_SKULL
  end
  return soliderType
end
function this.SetSoldierSubType(gameId,subType)
  mvars.ene_soldierSubType[gameId]=subType
end
function this.GetSoldierSubType(gameId,soldierType)
  local missionCode=TppMission.GetMissionID()
  if missionCode==10115 or missionCode==11115 then
    return"DD_PW"
  end
  if TppMission.IsFOBMission(missionCode)or InfMain.IsMbPlayTime() then--tex
    return"DD_FOB"
  end
  local soliderSubType=nil
  if mvars.ene_soldierSubType then
    soliderSubType=mvars.ene_soldierSubType[gameId]
  end
  if soliderSubType==nil then
    soliderSubType=this.GetDefaultSoldierSubType(soldierType)
  end
  return soliderSubType
end
function this.GetCpSubType(cpId)
  if mvars.ene_soldierIDList then
    local soldierIdList=mvars.ene_soldierIDList[cpId]
    if soldierIdList~=nil then
      for n,t in pairs(soldierIdList)do
        return this.GetSoldierSubType(n)
      end
    end
  end
  if mvars.ene_cpList then
    local cp=mvars.ene_cpList[cpId]
    local soldierSubType=this.subTypeOfCp[cp]
    if soldierSubType~=nil then
      return soldierSubType
    end
  end
  return this.GetSoldierSubType(nil)
end
function this.GetDefaultSoldierSubType(soldierType)
  if soldierType==nil then
    soldierType=this.GetSoldierType(nil)
  end
  if TppLocation.IsCyprus()then
    return"SKULL_CYPR"
  end
  if soldierType==EnemyType.TYPE_SOVIET then
    return"SOVIET_A"
    elseif soldierType==EnemyType.TYPE_PF then
    return"PF_A"
    elseif soldierType==EnemyType.TYPE_DD then
    return"DD_A"
    elseif soldierType==EnemyType.TYPE_SKULL then
    return"SKULL_AFGH"
    elseif soldierType==EnemyType.TYPE_CHILD then
    return"CHILD_A"
    else
    return"SOVIET_A"
    end
  return nil
end
function this._CreateDDWeaponIdTable(developedEquipGradeTable,securitySoldierEquipGrade,isNoKillMode)
  local ddWeaponIdTable={NORMAL={}}
  local NORMAL=ddWeaponIdTable.NORMAL
  mvars.ene_ddWeaponCount=0
  NORMAL.IS_NOKILL={}
  local weaponIdInfo=this.DDWeaponIdInfo
  for equipType,equipmentTable in pairs(weaponIdInfo)do
    for n,equipment in ipairs(equipmentTable)do
      local canEquip=false
      local developedEquipType=equipment.developedEquipType
      if developedEquipType==nil then
        canEquip=true
      elseif equipment.isNoKill and not isNoKillMode then
        canEquip=false
      else
        local developId=equipment.developId
        local developRank=TppMotherBaseManagement.GetEquipDevelopRank(developId)
        if gvars.mbSoldierEquipGrade == InfMain.SETTING_MB_EQUIPGRADE.MAX then--tex
          developRank=1
        end
       -- TppUiCommand.AnnounceLogView("_CreateDDWeaponIdTable developrank:" .. developRank)--tex DEBUG: CULL:
        if(securitySoldierEquipGrade>=developRank and developedEquipGradeTable[developedEquipType]>=developRank)then
          canEquip=true
        end
      end
      if canEquip then
        mvars.ene_ddWeaponCount=mvars.ene_ddWeaponCount+1
        if NORMAL[equipType]then
        else
          NORMAL[equipType]=equipment.equipId
          if equipment.isNoKill then
            NORMAL.IS_NOKILL[equipType]=true
          end
        end
      end
    end
  end
  return ddWeaponIdTable
end
function this.GetDDWeaponCount()
  return mvars.ene_ddWeaponCount
end
function this.ClearDDParameter()
  this.weaponIdTable.DD=nil
end
function this.PrepareDDParameter(securitySoldierEquipGrade,isNoKillMode)
  if TppMotherBaseManagement.GetMbsDevelopedEquipGradeTable==nil then
    this.weaponIdTable.DD={NORMAL={HANDGUN=TppEquip.EQP_WP_West_hg_010,ASSAULT=TppEquip.EQP_WP_West_ar_040}}
    return
  end
  local mbsDevelopedEquipGradeTable=TppMotherBaseManagement.GetMbsDevelopedEquipGradeTable()
  securitySoldierEquipGrade=securitySoldierEquipGrade or 9999
  if gvars.ini_isTitleMode then
    this.ClearDDParameter()
  end
  if this.weaponIdTable.DD~=nil then
  else
    this.weaponIdTable.DD=this._CreateDDWeaponIdTable(mbsDevelopedEquipGradeTable,securitySoldierEquipGrade,isNoKillMode)
  end
  --TppUiCommand.AnnounceLogView("PrepareDDParameter securitySoldierEquipGrade:"..securitySoldierEquipGrade)--tex DEBUG: CULL:
  --[[TppUiCommand.AnnounceLogView("PrepareDDParameter weaponIdTable.DD")--tex DEBUG: CULL:
    local dd = this.weaponIdTable.DD
    local inss = InfInspect.Inspect(dd)
    TppUiCommand.AnnounceLogView(inss)--]]
  local fultonDevelopedGrade=mbsDevelopedEquipGradeTable[mbsDevelopedEquipType.FULTON_16001]
  local wormholeDevelopedGrade=mbsDevelopedEquipGradeTable[mbsDevelopedEquipType.FULTON_16008]
  if fultonDevelopedGrade>securitySoldierEquipGrade then
    fultonDevelopedGrade=securitySoldierEquipGrade
  end
  if wormholeDevelopedGrade>securitySoldierEquipGrade then
    wormholeDevelopedGrade=securitySoldierEquipGrade
  end
  local fultonLevel=0
  if fultonDevelopedGrade>=4 then
    fultonLevel=3
  elseif fultonDevelopedGrade>=3 then
    fultonLevel=2
  elseif fultonDevelopedGrade>=1 then
    fultonLevel=1
  end
  local haveWormhole=false
  if wormholeDevelopedGrade~=0 then
    haveWormhole=true
  end
  this.weaponIdTable.DD.NORMAL.FULTON_LV=fultonLevel
  this.weaponIdTable.DD.NORMAL.WORMHOLE_FULTON=haveWormhole
end
function this.SetUpDDParameter()
  if not GameObject.DoesGameObjectExistWithTypeName"TppSoldier2"then
    return
  end
  local t={type="TppCommandPost2"}
  local n={id="SetFultonLevel",fultonLevel=this.weaponIdTable.DD.NORMAL.FULTON_LV,isWormHole=this.weaponIdTable.DD.NORMAL.WORMHOLE_FULTON}
  SendCommand(t,n)
  if(this.weaponIdTable.DD.NORMAL.SNEAKING_SUIT and this.weaponIdTable.DD.NORMAL.SNEAKING_SUIT>=3)or(this.weaponIdTable.DD.NORMAL.BATTLE_DRESS and this.weaponIdTable.DD.NORMAL.BATTLE_DRESS>=3)then
    TppRevenge.SetHelmetAll()
  end
  local n=this.weaponIdTable.DD.NORMAL.GRENADE or TppEquip.EQP_SWP_Grenade
  local e=this.weaponIdTable.DD.NORMAL.STUN_GRENADE or TppEquip.EQP_None
  SendCommand({type="TppSoldier2"},{id="RegistGrenadeId",grenadeId=n,stunId=e})
end
function this.GetWeaponIdTable(soldierType,soldierSubType)
  --local n={}
  local weaponIdTable={}
  if soldierType==EnemyType.TYPE_SOVIET then
    weaponIdTable=this.weaponIdTable.SOVIET_A
  elseif soldierType==EnemyType.TYPE_PF then
    weaponIdTable=this.weaponIdTable.PF_A
    if soldierSubType=="PF_B"then
      weaponIdTable=this.weaponIdTable.PF_B
    elseif soldierSubType=="PF_C"then
      weaponIdTable=this.weaponIdTable.PF_C
    end
  elseif soldierType==EnemyType.TYPE_DD then
    weaponIdTable=this.weaponIdTable.DD
  elseif soldierType==EnemyType.TYPE_SKULL then
    if soldierSubType=="SKULL_CYPR"then
      weaponIdTable=this.weaponIdTable.SKULL_CYPR
    else
      weaponIdTable=this.weaponIdTable.SKULL
    end
  elseif soldierType==EnemyType.TYPE_CHILD then
    weaponIdTable=this.weaponIdTable.CHILD
  else
    weaponIdTable=this.weaponIdTable.SOVIET_A
  end
  return weaponIdTable
end
function this.GetWeaponId(gameId,loadout)
  local equipPrimary,equipHandgun,equipBack
  local soldierType=this.GetSoldierType(gameId)
  local soldierSubType=this.GetSoldierSubType(gameId,soldierType)
  local missionId=TppMission.GetMissionID()
  if(missionId==10080 or missionId==11080)and soldierType==EnemyType.TYPE_CHILD then
    return TppEquip.EQP_WP_Wood_ar_010,TppEquip.EQP_WP_West_hg_010,nil
  end
  local weaponIdTable=this.GetWeaponIdTable(soldierType,soldierSubType)
  if weaponIdTable==nil then
    return nil,nil,nil
  end
  local primaryByPower={}
  if TppRevenge.IsUsingStrongWeapon()and weaponIdTable.STRONG then
    primaryByPower=weaponIdTable.STRONG
  else
    primaryByPower=weaponIdTable.NORMAL
  end
  equipBack=TppEquip.EQP_None
  equipHandgun=primaryByPower.HANDGUN
  local sniperByPower={}
  if TppRevenge.IsUsingStrongSniper()and weaponIdTable.STRONG then
    sniperByPower=weaponIdTable.STRONG
  else
    sniperByPower=weaponIdTable.NORMAL
  end
  local missileByPower={}
  if TppRevenge.IsUsingStrongMissile()and weaponIdTable.STRONG then
    missileByPower=weaponIdTable.STRONG
  else
    missileByPower=weaponIdTable.NORMAL
  end
  if loadout.SNIPER and sniperByPower.SNIPER then
    equipPrimary=sniperByPower.SNIPER
  elseif loadout.SHOTGUN and primaryByPower.SHOTGUN then
    equipPrimary=primaryByPower.SHOTGUN
  elseif loadout.MG and primaryByPower.MG then
    equipPrimary=primaryByPower.MG
  elseif loadout.SMG and primaryByPower.SMG then
    equipPrimary=primaryByPower.SMG
  else
    equipPrimary=primaryByPower.ASSAULT
  end
  if loadout.SHIELD and primaryByPower.SHIELD then
    equipBack=primaryByPower.SHIELD
  elseif loadout.MISSILE and missileByPower.MISSILE then
    equipBack=missileByPower.MISSILE
  end
  if loadout.GUN_LIGHT then
    local gunLightWeapon=this.gunLightWeaponIds[equipPrimary]
    equipPrimary=gunLightWeapon or equipPrimary
  end
  return equipPrimary,equipHandgun,equipBack
end
function this.GetBodyId(soldierId,soldierType,soldierSubType,loadout)
  local bodyId
  local subTypeBody={}
  --TppUiCommand.AnnounceLogView("DBG:GetBodyId soldier:"..soldierId.." soldiertype:"..soldierType.." soldierSubType:"..soldierSubType)--tex DEBUG: CULL:
  if soldierType==EnemyType.TYPE_SOVIET then
    subTypeBody=this.bodyIdTable.SOVIET_A
    if soldierSubType=="SOVIET_B"then
      subTypeBody=this.bodyIdTable.SOVIET_B
    end
  elseif soldierType==EnemyType.TYPE_PF then
    subTypeBody=this.bodyIdTable.PF_A
    if soldierSubType=="PF_B"then
      subTypeBody=this.bodyIdTable.PF_B
    elseif soldierSubType=="PF_C"then
      subTypeBody=this.bodyIdTable.PF_C
    end
  elseif soldierType==EnemyType.TYPE_DD then
    subTypeBody=this.bodyIdTable.DD_A
    if soldierSubType=="DD_FOB"then
      subTypeBody=this.bodyIdTable.DD_FOB
    elseif soldierSubType=="DD_PW"then
      subTypeBody=this.bodyIdTable.DD_PW
    end
  elseif soldierType==EnemyType.TYPE_SKULL then
    if this.bodyIdTable[soldierSubType]then
      subTypeBody=this.bodyIdTable[soldierSubType]
    else
      subTypeBody=this.bodyIdTable.SKULL_AFGH
    end
  elseif soldierType==EnemyType.TYPE_CHILD then
    subTypeBody=this.bodyIdTable.CHILD
  else
    subTypeBody=this.bodyIdTable.SOVIET_A
  end
  if subTypeBody==nil then
    return nil
  end
  
  local getBodyId=function(soldierId,loadoutBodyId)
    if#loadoutBodyId==0 then
      return loadoutBodyId[1]
    end
    return loadoutBodyId[(soldierId%#loadoutBodyId)+1]
  end
  
  if loadout.ARMOR and subTypeBody.ARMOR then
    return getBodyId(soldierId,subTypeBody.ARMOR)
  end
  if(mvars.ene_soldierLrrp[soldierId]or loadout.RADIO)and subTypeBody.RADIO then
    return getBodyId(soldierId,subTypeBody.RADIO)
  end
  if loadout.MISSILE and subTypeBody.MISSILE then
    return getBodyId(soldierId,subTypeBody.MISSILE)
  end
  if loadout.SHIELD and subTypeBody.SHIELD then
    return getBodyId(soldierId,subTypeBody.SHIELD)
  end
  if loadout.SNIPER and subTypeBody.SNIPER then
    bodyId=getBodyId(soldierId,subTypeBody.SNIPER)
  elseif loadout.SHOTGUN and subTypeBody.SHOTGUN then
    if loadout.OB and subTypeBody.SHOTGUN_OB then
      bodyId=getBodyId(soldierId,subTypeBody.SHOTGUN_OB)
    else
      bodyId=getBodyId(soldierId,subTypeBody.SHOTGUN)
    end
  elseif loadout.MG and subTypeBody.MG then
    if loadout.OB and subTypeBody.MG_OB then
      bodyId=getBodyId(soldierId,subTypeBody.MG_OB)
    else
      bodyId=getBodyId(soldierId,subTypeBody.MG)
    end
  elseif subTypeBody.ASSAULT then
    if loadout.OB and subTypeBody.ASSAULT_OB then
      bodyId=getBodyId(soldierId,subTypeBody.ASSAULT_OB)
    else
      bodyId=getBodyId(soldierId,subTypeBody.ASSAULT)
    end
  end
  return bodyId
end
function this.GetFaceId(n,e,n,n)
  if e==EnemyType.TYPE_SKULL then
    return EnemyFova.INVALID_FOVA_VALUE
  elseif e==EnemyType.TYPE_DD then
    return EnemyFova.INVALID_FOVA_VALUE
  elseif e==EnemyType.TYPE_CHILD then
    return 630
  end
  return nil
end
function this.GetBalaclavaFaceId(t,e,t,n)
  if e==EnemyType.TYPE_SKULL then
    return EnemyFova.NOT_USED_FOVA_VALUE
  elseif e==EnemyType.TYPE_DD then
    if n.HELMET then
      return TppEnemyFaceId.dds_balaclava0
    else
      return TppEnemyFaceId.dds_balaclava2
    end
  end
  return nil
end
function this.IsSniper(e)
  local e=mvars.ene_soldierPowerSettings[e]
  if e~=nil and e.SNIPER then
    return true
  end
  return false
end
function this.IsMissile(e)
  local e=mvars.ene_soldierPowerSettings[e]
  if e~=nil and e.MISSILE then
    return true
  end
  return false
end
function this.IsShield(e)
  local e=mvars.ene_soldierPowerSettings[e]
  if e~=nil and e.SHIELD then
    return true
  end
  return false
end
function this.IsArmor(e)
  local e=mvars.ene_soldierPowerSettings[e]
  if e~=nil and e.ARMOR then
    return true
  end
  return false
end
function this.IsHelmet(e)
  local e=mvars.ene_soldierPowerSettings[e]
  if e~=nil and e.HELMET then
    return true
  end
  return false
end
function this.IsNVG(e)
  local e=mvars.ene_soldierPowerSettings[e]
  if e~=nil and e.NVG then
    return true
  end
  return false
end
function this.AddPowerSetting(soldierId,loadout)
  local applySetting=mvars.ene_soldierPowerSettings[soldierId]or{}
  for n,setting in pairs(loadout)do
    applySetting[n]=setting
  end
  this.ApplyPowerSetting(soldierId,applySetting)
end
function this.ApplyPowerSetting(soldierId,loadout)
  if soldierId==NULL_ID then
    return
  end
  local soldierType=this.GetSoldierType(soldierId)
  local soldierSubType=this.GetSoldierSubType(soldierId,soldierType)
  local n={}
  for e,t in pairs(loadout)do
    if Tpp.IsTypeNumber(e)then
      n[t]=true
    else
      n[e]=t
    end
  end
  local o={SMG=true,MG=true,SHOTGUN=true,SNIPER=true,MISSILE=true,SHIELD=true}
  for e,t in pairs(o)do
    if n[e]and not mvars.revenge_loadedEquip[e]then
      n[e]=nil
    end
  end
  if soldierType==EnemyType.TYPE_SKULL then
    if soldierSubType=="SKULL_CYPR"then
      n.SNIPER=nil
      n.SHOTGUN=nil
      n.MG=nil
      n.SMG=true
      n.GUN_LIGHT=true
    else
      n.HELMET=true
      n.SOFT_ARMOR=true
    end
  end
  if n.ARMOR and not TppRevenge.CanUseArmor(soldierSubType)then
    n.ARMOR=nil
  end
  if n.QUEST_ARMOR then
    n.ARMOR=true
  end
  if n.ARMOR then
    n.SNIPER=nil
    n.SHIELD=nil
    n.MISSILE=nil
    n.SMG=nil
    if not n.SHOTGUN and not n.MG then
      if mvars.revenge_loadedEquip.MG then
        n.MG=true
      elseif mvars.revenge_loadedEquip.SHOTGUN then
        n.SHOTGUN=true
      end
    end
    if n.MG then
      n.SHOTGUN=nil
    end
    if n.SHOTGUN then
      n.MG=nil
    end
  end
  if n.MISSILE or n.SHIELD then
    n.SNIPER=nil
    n.SHOTGUN=nil
    n.MG=nil
    n.SMG=true
  end
  if n.GAS_MASK then
    if soldierSubType~="DD_FOB"then
      n.HELMET=nil
      n.NVG=nil
    end
  end
  if n.NVG then
    if soldierSubType~="DD_FOB"then
      n.HELMET=nil
      n.GAS_MASK=nil
    end
  end
  if n.HELMET then
    if soldierSubType~="DD_FOB"then
      n.GAS_MASK=nil
      n.NVG=nil
    end
  end
  mvars.ene_soldierPowerSettings[soldierId]=n
  loadout=n
  local n=0
  local bodyId=this.GetBodyId(soldierId,soldierType,soldierSubType,loadout)
  local faceId=this.GetFaceId(soldierId,soldierType,soldierSubType,loadout)
  local balaclavaFaceId=this.GetBalaclavaFaceId(soldierId,soldierType,soldierSubType,loadout)
  local primaryId,handgunId,backId=this.GetWeaponId(soldierId,loadout)
  if loadout.HELMET then
    n=n+WearEquip.HELMET
  end
  if loadout.GAS_MASK then
    n=n+WearEquip.GAS_MASK
  end
  if loadout.NVG then
    n=n+WearEquip.NVG
  end
  if loadout.SOFT_ARMOR then
    n=n+WearEquip.SOFT_ARMOR
  end
  if(primaryId~=nil or secondaryWeapon~=nil)or backId~=nil then
    SendCommand(soldierId,{id="SetEquipId",primary=primaryId,secondary=handgunId,tertiary=backId})
  end
  SendCommand(soldierId,{id="ChangeFova",bodyId=bodyId,faceId=faceId,balaclavaFaceId=l})
  SendCommand(soldierId,{id="SetWearEquip",flag=n})
  local e={SOVIET_A=enemySubType.SOVIET_A,SOVIET_B=enemySubType.SOVIET_B,PF_A=enemySubType.PF_A,PF_B=enemySubType.PF_B,PF_C=enemySubType.PF_C,DD_A=enemySubType.DD_A,DD_FOB=enemySubType.DD_FOB,DD_PW=enemySubType.DD_PW,CHILD_A=enemySubType.CHILD_A,SKULL_AFGH=enemySubType.SKULL_AFGH,SKULL_CYPR=enemySubType.SKULL_CYPR}
  SendCommand(soldierId,{id="SetSoldier2SubType",type=e[soldierSubType]})
end
function this.ApplyPersonalAbilitySettings(e,n)
  if e==NULL_ID then
    return
  end
  mvars.ene_soldierPersonalAbilitySettings[e]=n
  SendCommand(e,{id="SetPersonalAbility",ability=n})
end
function this.SetOccasionalChatList()
  if not GameObject.DoesGameObjectExistWithTypeName"TppSoldier2"then
    return
  end
  local e={}
  table.insert(e,"USSR_story_04")
  table.insert(e,"USSR_story_05")
  table.insert(e,"USSR_story_06")
  table.insert(e,"USSR_story_07")
  table.insert(e,"USSR_story_08")
  table.insert(e,"USSR_story_15")
  table.insert(e,"USSR_story_16")
  table.insert(e,"USSR_story_17")
  table.insert(e,"USSR_story_18")
  table.insert(e,"USSR_story_19")
  table.insert(e,"PF_story_01")
  table.insert(e,"PF_story_04")
  table.insert(e,"PF_story_05")
  table.insert(e,"PF_story_06")
  table.insert(e,"PF_story_07")
  table.insert(e,"PF_story_08")
  table.insert(e,"PF_story_12")table.insert(e,"PF_story_13")table.insert(e,"PF_story_14")table.insert(e,"PF_story_15")table.insert(e,"MB_story_07")table.insert(e,"MB_story_08")table.insert(e,"MB_story_18")table.insert(e,"MB_story_19")
  local n=gvars.str_storySequence
  if n<TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY then
    table.insert(e,"USSR_story_01")
    table.insert(e,"USSR_story_02")
    table.insert(e,"USSR_story_03")
  end
  if not TppBuddyService.DidObtainBuddyType(BuddyType.QUIET)and not TppStory.IsMissionCleard(10050)then
    table.insert(e,"USSR_story_10")
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
    table.insert(e,"USSR_story_11")
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON and n<TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY then
    table.insert(e,"USSR_story_12")table.insert(e,"USSR_story_13")
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON and n<TppDefine.STORY_SEQUENCE.CLEARD_SKULLFACE then
    table.insert(e,"USSR_story_14")
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION and n<TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA then
    table.insert(e,"PF_story_02")
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION and n<TppDefine.STORY_SEQUENCE.CLEARD_ELIMINATE_THE_COMMANDER then
    table.insert(e,"PF_story_03")
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION and n<TppDefine.STORY_SEQUENCE.CLEARD_SKULLFACE then
    table.insert(e,"PF_story_09")
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION and n<TppDefine.STORY_SEQUENCE.CLEARD_CODE_TALKER then
    table.insert(e,"PF_story_10")
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION then
    table.insert(e,"PF_story_11")
  end
  if(n>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON and TppResult.GetTotalNeutralizeCount()<10)and TppResult.IsTotalPlayStyleStealth()then
    table.insert(e,"MB_story_01")
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON and TppMotherBaseManagement.GetOgrePoint()>=5e4 then
    table.insert(e,"MB_story_02")
  end
  if TppMotherBaseManagement.IsOpenedSection{section="Security"}and TppMotherBaseManagement.GetSectionLv{section="Security"}<20 then
    table.insert(e,"MB_story_03")
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_ELIMINATE_THE_POWS and n<TppDefine.STORY_SEQUENCE.CLEARD_MURDER_INFECTORS then
    table.insert(e,"MB_story_04")
  end
  if TppTerminal.IsBuiltAnimalPlatform()then
    table.insert(e,"MB_story_05")
  end
  if TppBuddyService.DidObtainBuddyType(BuddyType.QUIET)and not TppBuddyService.IsDeadBuddyType(BuddyType.QUIET)then
    table.insert(e,"MB_story_09")
  end
  if(TppBuddyService.DidObtainBuddyType(BuddyType.DOG)and not TppBuddyService.CanSortieBuddyType(BuddyType.DOG))and not TppBuddyService.IsDeadBuddyType(BuddyType.DOG)then
    table.insert(e,"MB_story_10")
  end
  if(TppBuddyService.DidObtainBuddyType(BuddyType.DOG)and TppBuddyService.CanSortieBuddyType(BuddyType.DOG))and not TppBuddyService.IsDeadBuddyType(BuddyType.DOG)then
    table.insert(e,"MB_story_11")
  end
  if TppMotherBaseManagement.IsPandemicEventMode()then
    table.insert(e,"MB_story_12")
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO and n<TppDefine.STORY_SEQUENCE.CLEARD_MURDER_INFECTORS then
    table.insert(e,"MB_story_13")
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
    table.insert(e,"MB_story_14")
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_MURDER_INFECTORS then
    table.insert(e,"MB_story_15")
  end
  if gvars.pazLookedPictureCount>=1 and gvars.pazLookedPictureCount<10 then
    table.insert(e,"MB_story_16")
  end
  if TppDemo.IsPlayedMBEventDemo"DecisionHuey"then
    table.insert(e,"MB_story_17")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.FULTON)==1 then
    table.insert(e,"USSR_revenge_01")table.insert(e,"PF_revenge_01")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.FULTON)>=2 then
    table.insert(e,"USSR_revenge_02")table.insert(e,"PF_revenge_02")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)==1 then
    table.insert(e,"USSR_revenge_03")table.insert(e,"PF_revenge_03")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)==2 then
    table.insert(e,"USSR_revenge_04")table.insert(e,"PF_revenge_04")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)==3 then
    table.insert(e,"USSR_revenge_05")table.insert(e,"PF_revenge_05")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.STEALTH)==1 then
    table.insert(e,"USSR_revenge_06")table.insert(e,"PF_revenge_06")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.STEALTH)==2 then
    table.insert(e,"USSR_revenge_07")table.insert(e,"PF_revenge_07")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.HEAD_SHOT)==0 and TppRevenge.GetRevengePoint(TppRevenge.REVENGE_TYPE.HEAD_SHOT)>=50 then
    table.insert(e,"USSR_revenge_08")table.insert(e,"PF_revenge_08")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.VEHICLE)==0 and TppRevenge.GetRevengePoint(TppRevenge.REVENGE_TYPE.VEHICLE)>=50 then
    table.insert(e,"USSR_revenge_09")table.insert(e,"PF_revenge_09")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.VEHICLE)==0 and TppRevenge.GetRevengePoint(TppRevenge.REVENGE_TYPE.VEHICLE)>=50 then
    table.insert(e,"USSR_revenge_10")table.insert(e,"PF_revenge_10")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.LONG_RANGE)==0 and TppRevenge.GetRevengePoint(TppRevenge.REVENGE_TYPE.LONG_RANGE)>=50 then
    table.insert(e,"USSR_revenge_11")table.insert(e,"PF_revenge_11")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.NIGHT_S)==0 and TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.NIGHT_C)==0 then
    if TppRevenge.GetRevengePoint(TppRevenge.REVENGE_TYPE.NIGHT_S)>=50 or TppRevenge.GetRevengePoint(TppRevenge.REVENGE_TYPE.NIGHT_C)>=50 then
      table.insert(e,"USSR_revenge_12")table.insert(e,"PF_revenge_12")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.STEALTH)==3 and TppRevenge.GetRevengePoint(TppRevenge.REVENGE_TYPE.TRANQ)>0 then
    table.insert(e,"USSR_revenge_13")table.insert(e,"PF_revenge_13")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.STEALTH)>=3 then
    if not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.MINE)then
      table.insert(e,"USSR_counter_01")table.insert(e,"PF_counter_01")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.HEAD_SHOT)>=1 and TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.HEAD_SHOT)<=9 then
    if not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.HELMET)then
      table.insert(e,"USSR_counter_03")table.insert(e,"PF_counter_03")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.HEAD_SHOT)==10 then
    if not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.HELMET)then
      table.insert(e,"USSR_counter_04")table.insert(e,"PF_counter_04")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)>=1 then
    if not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.SOFT_ARMOR)then
      table.insert(e,"USSR_counter_05")table.insert(e,"PF_counter_05")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)>=1 then
    if not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.SHIELD)then
      table.insert(e,"USSR_counter_06")table.insert(e,"PF_counter_06")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.NIGHT_S)>=1 then
    if not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.NVG)then
      table.insert(e,"USSR_counter_07")table.insert(e,"PF_counter_07")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.NIGHT_C)>=1 then
    if not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.GUN_LIGHT)then
      table.insert(e,"USSR_counter_08")table.insert(e,"PF_counter_08")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)>=3 then
    if not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.ARMOR)then
      table.insert(e,"USSR_counter_10")table.insert(e,"PF_counter_10")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)>=3 then
    table.insert(e,"USSR_counter_11")table.insert(e,"PF_counter_11")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)>=3 then
    table.insert(e,"USSR_counter_12")table.insert(e,"PF_counter_12")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)>=3 then
    table.insert(e,"USSR_counter_13")table.insert(e,"PF_counter_13")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)>=3 then
    table.insert(e,"USSR_counter_14")table.insert(e,"PF_counter_14")
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)>=3 then
    if not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.SHOTGUN)or not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.MG)then
      table.insert(e,"USSR_counter_15")table.insert(e,"PF_counter_15")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.LONG_RANGE)>=2 then
    if not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.SNIPER)then
      table.insert(e,"USSR_counter_16")table.insert(e,"PF_counter_16")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.VEHICLE)==1 then
    if not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.MISSILE)then
      table.insert(e,"USSR_counter_17")table.insert(e,"PF_counter_17")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.VEHICLE)>=2 then
    if not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.MISSILE)then
      table.insert(e,"USSR_counter_18")table.insert(e,"PF_counter_18")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.STEALTH)>=2 then
    if not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.DECOY)then
      table.insert(e,"USSR_counter_19")table.insert(e,"PF_counter_19")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.STEALTH)>=1 then
    if not TppRevenge.IsBlocked(TppRevenge.BLOCKED_TYPE.CAMERA)then
      table.insert(e,"USSR_counter_20")table.insert(e,"PF_counter_20")
    end
  end
  if TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE.COMBAT)>=3 then
    table.insert(e,"USSR_counter_22")
  end
  local n={type="TppSoldier2"}
  SendCommand(n,{id="SetConversationList",list=e})
end
function this.SetSaluteVoiceList()
  if not GameObject.DoesGameObjectExistWithTypeName"TppSoldier2"then
    return
  end
  local r={}
  local i={}
  local t={}
  local p={}
  local e={}
  local s={}
  table.insert(e,"EVF010")
  table.insert(e,"salute0180")
  table.insert(e,"salute0220")
  table.insert(e,"salute0310")
  table.insert(e,"salute0320")
  table.insert(t,"salute0410")
  table.insert(t,"salute0420")
  local a=gvars.str_storySequence
  if TppMotherBaseManagement.GetOgrePoint()>=5e4 then
    table.insert(i,"salute0080")
  elseif Player.GetSmallFlyLevel()>=5 then
    table.insert(i,"salute0050")
  elseif Player.GetSmallFlyLevel()>=3 then
    table.insert(i,"salute0040")
  else
    table.insert(i,"salute0060")
  end
  local staffCount=TppMotherBaseManagement.GetStaffCount()
  local totalStaffLimit=0
  totalStaffLimit=totalStaffLimit+TppMotherBaseManagement.GetSectionStaffCountLimit{section=TppMotherBaseManagementConst.SECTION_COMBAT}
  totalStaffLimit=totalStaffLimit+TppMotherBaseManagement.GetSectionStaffCountLimit{section=TppMotherBaseManagementConst.SECTION_DEVELOP}
  totalStaffLimit=totalStaffLimit+TppMotherBaseManagement.GetSectionStaffCountLimit{section=TppMotherBaseManagementConst.SECTION_BASE_DEV}
  totalStaffLimit=totalStaffLimit+TppMotherBaseManagement.GetSectionStaffCountLimit{section=TppMotherBaseManagementConst.SECTION_SUPPORT}
  totalStaffLimit=totalStaffLimit+TppMotherBaseManagement.GetSectionStaffCountLimit{section=TppMotherBaseManagementConst.SECTION_SPY}
  totalStaffLimit=totalStaffLimit+TppMotherBaseManagement.GetSectionStaffCountLimit{section=TppMotherBaseManagementConst.SECTION_MEDICAL}
  totalStaffLimit=totalStaffLimit+TppMotherBaseManagement.GetSectionStaffCountLimit{section=TppMotherBaseManagementConst.SECTION_SECURITY}
  local percentageFullStaff=staffCount/totalStaffLimit
  if percentageFullStaff<.2 then
    table.insert(e,"salute0100")
  elseif percentageFullStaff<.4 then
    table.insert(e,"salute0090")
  elseif percentageFullStaff>.8 then
    table.insert(e,"salute0120")
  end
  if TppMotherBaseManagement.GetGmp()<0 then
    table.insert(e,"salute0150")
  end
  if TppMotherBaseManagement.GetDevelopableEquipCount()>8 then
    table.insert(e,"salute0160")
  end
  if(TppMotherBaseManagement.GetResourceUsableCount{resource="CommonMetal"}<500 or TppMotherBaseManagement.GetResourceUsableCount{resource="FuelResource"}<200)or TppMotherBaseManagement.GetResourceUsableCount{resource="BioticResource"}<200 then
    table.insert(e,"salute0170")
  end
  if TppMotherBaseManagement.IsBuiltFirstFob()then
    table.insert(e,"salute0190")
  end
  if TppTerminal.IsReleaseSection"Combat"then
    table.insert(e,"salute0200")
  end
  if TppMotherBaseManagement.IsOpenedSectionFunc{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_BATTLE}then
    local n=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_BATTLE}
    if n>=TppMotherBaseManagementConst.SECTION_FUNC_RANK_E then
      table.insert(e,"salute0230")
    end
  end
  if(TppBuddyService.DidObtainBuddyType(BuddyType.DOG)and not TppBuddyService.CanSortieBuddyType(BuddyType.DOG))and not TppBuddyService.IsDeadBuddyType(BuddyType.DOG)then
    table.insert(e,"salute0240")
  end
  if(TppBuddyService.DidObtainBuddyType(BuddyType.QUIET)and not TppBuddyService.CanSortieBuddyType(BuddyType.QUIET))and not TppBuddyService.IsDeadBuddyType(BuddyType.QUIET)then
    table.insert(e,"salute0250")
  end
  if TppMotherBaseManagement.GetResourceUsableCount{resource="Plant2000"}<100 or TppMotherBaseManagement.GetResourceUsableCount{resource="Plant2005"}<100 then
    table.insert(e,"salute0260")
  end
  if a==TppDefine.STORY_SEQUENCE.CLEARD_TAKE_OUT_THE_CONVOY then
    table.insert(t,"salute0270")
  end
  if TppMotherBaseManagement.IsPandemicEventMode()or a==TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_BEFORE_MURDER_INFECTORS then
    table.insert(t,"salute0280")
  end
  if a==TppDefine.STORY_SEQUENCE.CLEARD_ELIMINATE_THE_POWS then
    table.insert(t,"salute0290")
  end
  if TppTerminal.IsBuiltAnimalPlatform()then
    table.insert(e,"salute0300")
  end
  if a==TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_INTEL_AGENTS then
    table.insert(t,"salute0330")
  end
  if a>=TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA and a<=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
    table.insert(t,"salute0340")
  end
  if a==TppDefine.STORY_SEQUENCE.CLEARD_MURDER_INFECTORS then
    table.insert(t,"salute0350")table.insert(t,"salute0360")
  end
  if a>=TppDefine.STORY_SEQUENCE.CLEARD_THE_TRUTH then
    table.insert(e,"salute0370")
  end
  if TppUiCommand.IsBirthDay()then
    table.insert(r,"salute0380")
  end
  local n={high={normal=r,once=i},mid={normal=t,once=p},low={normal=e,once=s}}
  local e={type="TppSoldier2"}
  SendCommand(e,{id="SetSaluteVoiceList",list=n})
end
function this.RequestLoadWalkerGearEquip()
  TppEquip.RequestLoadToEquipMissionBlock{TppEquip.EQP_WP_West_hg_010}
end
function this.SetSoldier2CommonPackageLabel(e)
  mvars.ene_soldier2CommonBlockPackageLabel=e
end
function this.AssignUniqueStaffType(e)
  if not IsTypeTable(e)then
    return
  end
  local t=e.locaterName
  local i=e.gameObjectId
  local n=e.uniqueStaffTypeId
  local s=e.alreadyExistParam
  if not IsTypeNumber(n)then
    return
  end
  if(not IsTypeNumber(i))and(not IsTypeString(t))then
    return
  end
  local e
  if IsTypeNumber(i)then
    e=i
  elseif IsTypeString(t)then
    e=GetGameObjectId(t)
  end
  if not TppDefine.IGNORE_EXIST_STAFF_CHECK[n]then
    if TppMotherBaseManagement.IsExistStaff{uniqueTypeId=n}then
      if s then
        local e={gameObjectId=e}
        for n,t in pairs(s)do
          e[n]=t
        end
        TppMotherBaseManagement.RegenerateGameObjectStaffParameter(e)
        return
      else
        return
      end
    end
  end
  if e~=NULL_ID then
    TppMotherBaseManagement.RegenerateGameObjectStaffParameter{gameObjectId=e,staffType="Unique",uniqueTypeId=n}
  end
end
function this.IsActiveSoldierInRange(t,e)
  local e={id="IsActiveSoldierInRange",position=t,range=e}
  return SendCommand({type="TppSoldier2"},e)
end
function this._SetOutOfArea(n,t)
  if IsTypeTable(n)then
    for a,n in ipairs(n)do
      this._SetOutOfArea(n,t)
    end
  else
    local e=GetGameObjectId("TppSoldier2",n)table.insert(t,e)
  end
end
function this.SetOutOfArea(i,a)
  local t={}
  this._SetOutOfArea(i,t)
  local e={id="SetOutOfArea",soldiers=t,isOut=a}
  SendCommand({type="TppSoldier2"},e)
end
function this.SetEliminateTargets(t,n)
  mvars.ene_eliminateTargetList={}
  mvars.ene_eliminateHelicopterList={}
  mvars.ene_eliminateVehicleList={}
  mvars.ene_eliminateWalkerGearList={}
  local i={}
  if Tpp.IsTypeTable(n)then
    if Tpp.IsTypeTable(n.exceptMissionClearCheck)then
      for n,e in pairs(n.exceptMissionClearCheck)do
        i[e]=true
      end
    end
  end
  for t,n in pairs(t)do
    local t=GetGameObjectId(n)
    if t~=NULL_ID then
      if Tpp.IsSoldier(t)then
        if not i[n]then
          mvars.ene_eliminateTargetList[t]=n
        end
        this.RegistHoldRecoveredState(n)
        this.SetTargetOption(n)
      elseif Tpp.IsEnemyHelicopter(t)then
        if not i[n]then
          mvars.ene_eliminateHelicopterList[t]=n
        end
      elseif Tpp.IsVehicle(t)then
        if not i[n]then
          mvars.ene_eliminateVehicleList[t]=n
        end
        this.RegistHoldRecoveredState(n)
        this.RegistHoldBrokenState(n)
      elseif Tpp.IsEnemyWalkerGear(t)then
        if not i[n]then
          mvars.ene_eliminateWalkerGearList[t]=n
        end
        this.RegistHoldRecoveredState(n)
      end
      if i[n]then
      end
    end
  end
end
function this.DeleteEliminateTargetSetting(t)
  if not mvars.ene_eliminateTargetList then
    return
  end
  local e=GetGameObjectId(t)
  if e==NULL_ID then
    return
  end
  if mvars.ene_eliminateTargetList[e]then
    mvars.ene_eliminateTargetList[e]=nil
    local e=GetGameObjectId("TppSoldier2",t)
    if e==NULL_ID then
    else
      SendCommand(e,{id="ResetSoldier2Flag"})
    end
  elseif mvars.ene_eliminateHelicopterList[e]then
    mvars.ene_eliminateHelicopterList[e]=nil
  elseif mvars.ene_eliminateVehicleList[e]then
    mvars.ene_eliminateVehicleList[e]=nil
  elseif mvars.ene_eliminateWalkerGearList[e]then
    mvars.ene_eliminateWalkerGearList[e]=nil
  else
    return
  end
  return true
end
function this.SetRescueTargets(t,n)
  mvars.ene_rescueTargetList={}
  mvars.ene_rescueTargetOptions=n or{}
  for t,n in pairs(t)do
    local t=GetGameObjectId(n)
    if t~=NULL_ID then
      mvars.ene_rescueTargetList[t]=n
      this.RegistHoldRecoveredState(n)
    end
  end
end
function this.SetVipHostage(n)
  this.SetRescueTargets(n)
end
function this.SetExcludeHostage(e)
  mvars.ene_excludeHostageGameObjectId=GetGameObjectId(e)
end
function this.GetAllHostages()
  local e={"TppHostage2","TppHostageUnique","TppHostageUnique2"}
  local s=TppGameObject.NPC_STATE_DISABLE
  local o={}
  for e,r in ipairs(e)do
    local t=1
    local i=0
    while i<t do
      local e=GetGameObjectIdByIndex(r,i)
      if e==NULL_ID then
        break
      end
      if t==1 then
        t=SendCommand({type=r},{id="GetMaxInstanceCount"})
        if not t or t<1 then
          break
        end
      end
      local t=true
      if mvars.ene_excludeHostageGameObjectId and mvars.ene_excludeHostageGameObjectId==e then
        t=false
      end
      if t then
        local t=SendCommand(e,{id="GetLifeStatus"})
        local n=SendCommand(e,{id="GetStatus"})
        if(n~=s)and(t~=TppGameObject.NPC_LIFE_STATE_DEAD)then
          table.insert(o,e)
        end
      end
      i=i+1
    end
  end
  return o
end
function this.GetAllActiveEnemyWalkerGear()
  local r={}
  local e=1
  local i=0
  while i<e do
    local t=GetGameObjectIdByIndex("TppCommonWalkerGear2",i)
    if t==NULL_ID then
      break
    end
    if e==1 then
      e=SendCommand({type="TppCommonWalkerGear2"},{id="GetMaxInstanceCount"})
      if not e or e<1 then
        break
      end
    end
    local a=SendCommand(t,{id="IsBroken"})
    local e=SendCommand(t,{id="IsFultonCaptured"})
    if(a==false)and(e==false)then
      table.insert(r,t)
    end
    i=i+1
  end
  return r
end
function this.SetChildTargets(n)
  mvars.ene_childTargetList={}
  for t,n in pairs(n)do
    local t=GetGameObjectId(n)
    if t~=NULL_ID then
      mvars.ene_childTargetList[t]=n
      this.SetTargetOption(n)
    end
  end
end
function this.SetTargetOption(e)
  local e=GetGameObjectId(e)
  if e==NULL_ID then
  else
    SendCommand(e,{id="SetVip"})
    SendCommand(e,{id="SetForceRealize"})
    SendCommand(e,{id="SetIgnoreSupportBlastInUnreal",enabled=true})
  end
end
function this.LetCpHasTarget(e,t)
  local n
  if IsTypeNumber(e)then
    n=e
  elseif IsTypeString(e)then
    n=GetGameObjectId(e)
  else
    return
  end
  if n==NULL_ID then
    return
  end
  SendCommand(n,{id="SetCpMissionTarget",enable=t})
end
function this.GetPhase(e)
  local t=GetGameObjectId(e)
  return SendCommand(t,{id="GetPhase",cpName=e})
end
function this.GetPhaseByCPID(e)
  return SendCommand(e,{id="GetPhase",cpName=mvars.ene_cpList[e]})
end
function this.GetLifeStatus(e)
  if not e then
    return
  end
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  return SendCommand(e,{id="GetLifeStatus"})
end
function this.GetActionStatus(e)
  if not e then
    return
  end
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  return SendCommand(e,{id="GetActionStatus"})
end
function this.GetStatus(t)
  local e
  if IsTypeString(t)then
    e=GetGameObjectId(t)
  else
    e=t
  end
  if e~=NULL_ID then
    return SendCommand(e,{id="GetStatus"})
  else
    return
  end
end
function this.IsEliminated(n)
  local t=this.GetLifeStatus(n)
  local n=this.GetStatus(n)
  return this._IsEliminated(t,n)
end
function this.IsNeutralized(n)
  local t=this.GetLifeStatus(n)
  local n=this.GetStatus(n)
  return this._IsNeutralized(t,n)
end
function this.IsRecovered(n)
  if not mvars.ene_recoverdStateIndexByName then
    return
  end
  local e
  if IsTypeString(n)then
    e=mvars.ene_recoverdStateIndexByName[n]
  elseif IsTypeNumber(n)then
    e=mvars.ene_recoverdStateIndexByGameObjectId[n]
  end
  if e then
    return svars.ene_isRecovered[e]
  end
end
function this.ChangeLifeState(e)
  if not Tpp.IsTypeTable(e)then
    return"Support table only"
  end
  local lifeState=e.lifeState
  local min=0
  local max=4
  if not((lifeState>min)and(lifeState<max))then
    return"lifeState must be index"
    end
  local targetName=e.targetName
  if not IsTypeString(targetName)then
    return"targetName must be string"
    end
  local soldierId=GetGameObjectId(targetName)
  if soldierId~=NULL_ID then
    SendCommand(soldierId,{id="ChangeLifeState",state=lifeState})
  else
    return"Cannot get gameObjectId. targetName = "..tostring(targetName)
  end
end
function this.SetSneakRoute(e,s,t,i)
  if not e then
    return
  end
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  t=t or 0
  local r=false
  if Tpp.IsTypeTable(i)then
    r=i.isRelaxed
  end
  if e~=NULL_ID then
    SendCommand(e,{id="SetSneakRoute",route=s,point=t,isRelaxed=r})
  end
end
function this.UnsetSneakRoute(e)
  if not e then
    return
  end
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  if e~=NULL_ID then
    SendCommand(e,{id="SetSneakRoute",route=""})
  end
end
function this.SetCautionRoute(e,i,t,r)
  if not e then
    return
  end
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  t=t or 0
  if e~=NULL_ID then
    SendCommand(e,{id="SetCautionRoute",route=i,point=t})
  end
end
function this.UnsetCautionRoute(e)
  if not e then
    return
  end
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  if e~=NULL_ID then
    SendCommand(e,{id="SetCautionRoute",route=""})
  end
end
function this.SetAlertRoute(e,i,t,r)
  if not e then
    return
  end
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  t=t or 0
  if e~=NULL_ID then
    SendCommand(e,{id="SetAlertRoute",enabled=true,route=i,point=t})
  end
end
function this.UnsetAlertRoute(e)
  if not e then
    return
  end
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  if e~=NULL_ID then
    SendCommand(e,{id="SetAlertRoute",enabled=false,route=""})
  end
end
function this.RegistRoutePointMessage(e)
  if not IsTypeTable(e)then
    return
  end
  mvars.ene_routePointMessage=mvars.ene_routePointMessage or{}
  mvars.ene_routePointMessage.main=mvars.ene_routePointMessage.main or{}
  mvars.ene_routePointMessage.sequence=mvars.ene_routePointMessage.sequence or{}
  local n={}n[StrCode32"GameObject"]=Tpp.StrCode32Table(e.messages)
  local n=(Tpp.MakeMessageExecTable(n))[StrCode32"GameObject"]
  local e=e.sequenceName
  if e then
    mvars.ene_routePointMessage.sequence[e]=mvars.ene_routePointMessage.sequence[e]or{}
    Tpp.MergeTable(mvars.ene_routePointMessage.sequence[e],n,true)
  else
    Tpp.MergeTable(mvars.ene_routePointMessage.main,n,true)
  end
end
function this.IsBaseCp(e)
  if not mvars.ene_baseCpList then
    return
  end
  return mvars.ene_baseCpList[e]
end
function this.IsOuterBaseCp(e)
  if not mvars.ene_outerBaseCpList then
    return
  end
  return mvars.ene_outerBaseCpList[e]
end
function this.ChangeRouteSets(t,a)
  mvars.ene_routeSetsTemporary=mvars.ene_routeSets
  mvars.ene_routeSetsPriorityTemporary=mvars.ene_routeSetsPriority
  this.MergeRouteSetDefine(t)
  mvars.ene_routeSets={}
  mvars.ene_routeSetsPriority={}
  mvars.ene_routeSetsFixedShiftChange={}
  this.UpdateRouteSet(mvars.ene_routeSetsDefine)
  local t={{{"old","immediately"},{"new","immediately"}}}
  for e,a in pairs(mvars.ene_cpList)do
    SendCommand(e,{id="ChangeRouteSets"})
    SendCommand(e,{id="ShiftChange",schedule=t})
  end
end
function this.InitialRouteSetGroup(e)
  local cpName=GetGameObjectId(e.cpName)
  local groupName=e.groupName
  if not IsTypeTable(e.soldierList)then
    return
  end
  local i={}
  for n,e in pairs(e.soldierList)do
    local e=GetGameObjectId(e)
    if e~=NULL_ID then
      i[n]=e
    end
  end
  if cpName==NULL_ID then
    return
  end
  SendCommand(cpName,{id="AssignSneakRouteGroup",soldiers=i,group=groupName})
end
function this.RegisterHoldTime(e,n)
  local e=GetGameObjectId(e)
  if e==NULL_ID then
    return
  end
  mvars.ene_holdTimes[e]=n
end
function this.ChangeHoldTime(n,t)
  local n=GetGameObjectId(n)
  if n==NULL_ID then
    return
  end
  mvars.ene_holdTimes[n]=t
  this.MakeShiftChangeTable()
end
function this.RegisterSleepTime(e,n)
  local e=GetGameObjectId(e)
  if e==NULL_ID then
    return
  end
  mvars.ene_sleepTimes[e]=n
end
function this.ChangeSleepTime(n,t)
  local n=GetGameObjectId(n)
  if n==NULL_ID then
    return
  end
  mvars.ene_sleepTimes[n]=t
  this.MakeShiftChangeTable()
end
function this.NoShifhtChangeGruopSetting(e,n)
  local e=GetGameObjectId(e)
  if e==NULL_ID then
    return
  end
  mvars.ene_noShiftChangeGroupSetting[e]=mvars.ene_noShiftChangeGroupSetting[e]or{}
  mvars.ene_noShiftChangeGroupSetting[e][StrCode32(n)]=true
end
function this.RegisterCombatSetting(t)
  local function i(t,e)
    local n={}
    for e,a in pairs(e)do
      n[e]=a
      if t[e]then
        n[e]=t[e]
      end
    end
    return n
  end
  if not IsTypeTable(t)then
    return
  end
  for n,e in pairs(t)do
    if e.USE_COMMON_COMBAT and mvars.loc_locationCommonCombat then
      if mvars.loc_locationCommonCombat[n]then
        if e.combatAreaList then
          e.combatAreaList=i(e.combatAreaList,mvars.loc_locationCommonCombat[n].combatAreaList)
        else
          e=mvars.loc_locationCommonCombat[n]
        end
      end
    end
    if e.combatAreaList and IsTypeTable(e.combatAreaList)then
      for t,e in pairs(e.combatAreaList)do
        for t,e in pairs(e)do
          if e.guardTargetName and e.locatorSetName then
            TppCombatLocatorProvider.RegisterCombatLocatorSetToCpforLua{cpName=n,locatorSetName=e.guardTargetName}
            TppCombatLocatorProvider.RegisterCombatLocatorSetToCpforLua{cpName=n,locatorSetName=e.locatorSetName}
          end
        end
      end
      local t={type="TppCommandPost2"}
      local e={id="SetCombatArea",cpName=n,combatAreaList=e.combatAreaList}
      SendCommand(t,e)
    else
      for t,e in ipairs(e)do
        TppCombatLocatorProvider.RegisterCombatLocatorSetToCpforLua{cpName=n,locatorSetName=e}
      end
    end
  end
end
function this.SetEnable(e)
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  if e~=NULL_ID then
    SendCommand(e,{id="SetEnabled",enabled=true})
  end
end
function this.SetDisable(e,t)
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  if e~=NULL_ID then
    SendCommand(e,{id="SetEnabled",enabled=false,noAssignRoute=t})
  end
end
function this.SetEnableRestrictNotice(e)
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  if e~=NULL_ID then
    SendCommand(e,{id="SetRestrictNotice",enabled=true})
  end
end
function this.SetDisableRestrictNotice(e)
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  if e~=NULL_ID then
    SendCommand(e,{id="SetRestrictNotice",enabled=false})
  end
end
function this.RealizeParasiteSquad()
  if not IsTypeTable(mvars.ene_parasiteSquadList)then
    return
  end
  for t,e in pairs(mvars.ene_parasiteSquadList)do
    local e=GetGameObjectId("TppParasite2",e)
    if e~=NULL_ID then
      SendCommand(e,{id="Realize"})
    end
  end
end
function this.UnRealizeParasiteSquad()
  if not IsTypeTable(mvars.ene_parasiteSquadList)then
    return
  end
  for t,e in pairs(mvars.ene_parasiteSquadList)do
    local e=GetGameObjectId("TppParasite2",e)
    if e~=NULL_ID then
      SendCommand(e,{id="Unrealize"})
    end
  end
end
function this.OnAllocate(n)
  this.SetMaxSoldierStateCount(TppDefine.DEFAULT_SOLDIER_STATE_COUNT)
  if n.enemy then
    this.SetMaxSoldierStateCount(n.enemy.MAX_SOLDIER_STATE_COUNT)
  end
  if TppCommandPost2 then
    TppCommandPost2.SetSVarsKeyNames{names="cpNames",flags="cpFlags"}
  end
  TppSoldier2.SetSVarsKeyNames{name="solName",state="solState",flagAndStance="solFlagAndStance",weapon="solWeapon",location="solLocation",marker="solMarker",fovaSeed="solFovaSeed",faceFova="solFaceFova",bodyFova="solBodyFova",cp="solCp",cpRoute="solCpRoute",scriptSneakRoute="solScriptSneakRoute",scriptCautionRoute="solScriptCautionRoute",scriptAlertRoute="solScriptAlertRoute",routeNodeIndex="solRouteNodeIndex",routeEventIndex="solRouteEventIndex",travelName="solTravelName",travelStepIndex="solTravelStepIndex",optionalNamesName="solOptName",optionalParam1Name="solOptParam1",optionalParam2Name="solOptParam2",passengerInfoName="passengerInfoName",passengerFlagName="passengerFlagName",passengerNameName="passengerNameName",noticeObjectType="noticeObjectType",noticeObjectPosition="noticeObjectPosition",noticeObjectOwnerName="noticeObjectOwnerName",noticeObjectOwnerId="noticeObjectOwnerId",noticeObjectAttachId="noticeObjectAttachId",randomSeed="solRandomSeed"}
  if TppSoldierFace~=nil then
    if TppSoldierFace.ConvertFova2PathToFovaFile~=nil then
      TppSoldierFace.ConvertFova2PathToFovaFile()
    end
  end
  if TppHostage2 then
    if TppHostage2.SetSVarsKeyNames2 then
      TppHostage2.SetSVarsKeyNames2{name="hosName",state="hosState",flagAndStance="hosFlagAndStance",weapon="hosWeapon",location="hosLocation",marker="hosMarker",fovaSeed="hosFovaSeed",faceFova="hosFaceFova",bodyFova="hosBodyFova",scriptSneakRoute="hosScriptSneakRoute",routeNodeIndex="hosRouteNodeIndex",routeEventIndex="hosRouteEventIndex",optionalParam1Name="hosOptParam1",optionalParam2Name="hosOptParam2",randomSeed="hosRandomSeed"}
    end
  end
  mvars.ene_disablePowerSettings={}
  mvars.ene_soldierTypes={}
  if n.enemy then
    if n.enemy.syncRouteTable and SyncRouteManager then
      SyncRouteManager.Create(n.enemy.syncRouteTable)
    end
    if n.enemy.OnAllocate then
      n.enemy.OnAllocate()
    end
    mvars.ene_funcRouteSetPriority=n.enemy.GetRouteSetPriority
    if n.enemy.hostageDefine then
      mvars.ene_hostageDefine=n.enemy.hostageDefine
    end
    if n.enemy.vehicleDefine then
      mvars.ene_vehicleDefine=n.enemy.vehicleDefine
    end
    if n.enemy.vehicleSettings then
      this.RegistVehicleSettings(n.enemy.vehicleSettings)
    end
    if IsTypeTable(n.enemy.disablePowerSettings)then
      this.DisablePowerSettings(n.enemy.disablePowerSettings)
    end
    if n.enemy.soldierTypes then
      this.SetUpSoldierTypes(n.enemy.soldierTypes)
    end
  end
  mvars.ene_soldierPowerSettings={}
  mvars.ene_missionSoldierPowerSettings={}
  mvars.ene_missionRequiresPowerSettings={}
  mvars.ene_soldierPersonalAbilitySettings={}
  mvars.ene_missionSoldierPersonalAbilitySettings={}
  mvars.ene_soldier2CommonBlockPackageLabel="default"
  mvars.ene_questTargetList={}
  mvars.ene_questVehicleList={}
  mvars.ene_questGetLoadedFaceTable={}
  mvars.ene_questArmorId=0
  mvars.ene_questBalaclavaId=0
  mvars.ene_isQuestSetup=false
  mvars.ene_isQuestHeli=false
end
function this.DeclareSVars(t)
  local uavCount=0
  local missionId=TppMission.GetMissionID()
  if TppMission.IsFOBMission(missionId)then
    uavCount=TppDefine.MAX_UAV_COUNT
  end
  local cpCount=0
  if t.enemy then
    local soldierDefine=t.enemy.soldierDefine
    if soldierDefine~=nil then
      for cpName,soldierList in pairs(soldierDefine)do
        cpCount=cpCount+1
      end
    end
  end
  if cpCount==1 then
    cpCount=2
  end
  mvars.ene_cpCount=cpCount
  local svarList={
    {name="cpNames",arraySize=cpCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="cpFlags",arraySize=cpCount,type=TppScriptVars.TYPE_UINT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="solName",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="solState",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="solFlagAndStance",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="solWeapon",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="solLocation",arraySize=mvars.ene_maxSoldierStateCount*4,type=TppScriptVars.TYPE_FLOAT,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="solMarker",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
    {name="solFovaSeed",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="solFaceFova",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="solBodyFova",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="solCp",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="solCpRoute",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="solScriptSneakRoute",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="solScriptCautionRoute",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="solScriptAlertRoute",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="solRouteNodeIndex",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="solRouteEventIndex",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="solTravelName",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="solTravelStepIndex",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="solOptName",arraySize=TppDefine.DEFAULT_SOLDIER_OPTION_VARS_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="solOptParam1",arraySize=TppDefine.DEFAULT_SOLDIER_OPTION_VARS_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="solOptParam2",arraySize=TppDefine.DEFAULT_SOLDIER_OPTION_VARS_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="passengerInfoName",arraySize=TppDefine.DEFAULT_PASSAGE_INFO_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="passengerFlagName",arraySize=TppDefine.DEFAULT_PASSAGE_FLAG_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="passengerNameName",arraySize=TppDefine.DEFAULT_PASSAGE_FLAG_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="passengerVehicleNameName",arraySize=TppDefine.DEFAULT_PASSAGE_INFO_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="noticeObjectType",arraySize=TppDefine.DEFAULT_NOTICE_INFO_COUNT,type=TppScriptVars.TYPE_UINT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="noticeObjectPosition",arraySize=TppDefine.DEFAULT_NOTICE_INFO_COUNT*3,type=TppScriptVars.TYPE_FLOAT,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="noticeObjectOwnerName",arraySize=TppDefine.DEFAULT_NOTICE_INFO_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="noticeObjectOwnerId",arraySize=TppDefine.DEFAULT_NOTICE_INFO_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="noticeObjectAttachId",arraySize=TppDefine.DEFAULT_NOTICE_INFO_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="solRandomSeed",arraySize=1,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="hosName",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="hosState",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="hosFlagAndStance",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="hosWeapon",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="hosLocation",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT*4,type=TppScriptVars.TYPE_FLOAT,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="hosMarker",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
{name="hosFovaSeed",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="hosFaceFova",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="hosBodyFova",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="hosScriptSneakRoute",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="hosRouteNodeIndex",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="hosRouteEventIndex",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="hosOptParam1",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="hosOptParam2",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="hosRandomSeed",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="enemyHeliName",arraySize=TppDefine.DEFAULT_ENEMY_HELI_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="enemyHeliLocation",arraySize=TppDefine.DEFAULT_ENEMY_HELI_STATE_COUNT*4,type=TppScriptVars.TYPE_FLOAT,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="enemyHeliCp",arraySize=TppDefine.DEFAULT_ENEMY_HELI_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="enemyHeliFlag",arraySize=TppDefine.DEFAULT_ENEMY_HELI_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="enemyHeliSneakRoute",arraySize=TppDefine.DEFAULT_ENEMY_HELI_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="enemyHeliCautionRoute",arraySize=TppDefine.DEFAULT_ENEMY_HELI_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="enemyHeliAlertRoute",arraySize=TppDefine.DEFAULT_ENEMY_HELI_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="enemyHeliRouteNodeIndex",arraySize=TppDefine.DEFAULT_ENEMY_HELI_STATE_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="enemyHeliRouteEventIndex",arraySize=TppDefine.DEFAULT_ENEMY_HELI_STATE_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="enemyHeliMarker",arraySize=TppDefine.DEFAULT_ENEMY_HELI_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
{name="enemyHeliLife",arraySize=TppDefine.DEFAULT_ENEMY_HELI_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="ene_wkrg_name",arraySize=4,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="ene_wkrg_life",arraySize=4,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="ene_wkrg_partslife",arraySize=4*24,type=TppScriptVars.TYPE_UINT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="ene_wkrg_location",arraySize=4*4,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="ene_wkrg_bulletleft",arraySize=4*2,type=TppScriptVars.TYPE_UINT16,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="ene_wkrg_marker",arraySize=4*2,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
{name="ene_holdRecoveredStateName",arraySize=TppDefine.MAX_HOLD_RECOVERED_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="ene_isRecovered",arraySize=TppDefine.MAX_HOLD_RECOVERED_STATE_COUNT,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="ene_holdBrokenStateName",arraySize=TppDefine.MAX_HOLD_VEHICLE_BROKEN_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="ene_isVehicleBroken",arraySize=TppDefine.MAX_HOLD_VEHICLE_BROKEN_STATE_COUNT,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="liquidLifeStatus",arraySize=1,type=TppScriptVars.TYPE_UINT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="liquidMarker",arraySize=1,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
{name="uavName",arraySize=uavCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="uavIsDead",arraySize=uavCount,type=TppScriptVars.TYPE_UINT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="uavMarker",arraySize=uavCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
{name="uavCp",arraySize=uavCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="uavPatrolRoute",arraySize=uavCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="uavCombatRoute",arraySize=uavCount,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="securityCameraCp",arraySize=TppDefine.MAX_SECURITY_CAMERA_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
{name="securityCameraMarker",arraySize=TppDefine.MAX_SECURITY_CAMERA_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
{name="securityCameraFlag",arraySize=TppDefine.MAX_SECURITY_CAMERA_COUNT,type=TppScriptVars.TYPE_UINT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
nil
}
  if Vehicle.svars then
    local vehicleInstanceCount=Vehicle.instanceCountMax
    if mvars.ene_vehicleDefine and mvars.ene_vehicleDefine.instanceCount then
      vehicleInstanceCount=mvars.ene_vehicleDefine.instanceCount
    end
    Tpp.ApendArray(svarList,Vehicle.svars{instanceCount=vehicleInstanceCount})
  end
  return svarList
end
function this.ResetSoldier2CommonBlockPackageLabel()
  gvars.ene_soldier2CommonPackageLabelIndex=TppDefine.DEFAULT_SOLIDER2_COMMON_PACKAGE
end
function this.RegisterSoldier2CommonMotionPackagePath(n)
  local t=TppDefine.SOLIDER2_COMMON_PACK[n]
  local a=TppDefine.SOLIDER2_COMMON_PACK_PREREQUISITES[n]
  if t then
    if IsTypeString(n)then
      gvars.ene_soldier2CommonPackageLabelIndex=StrCode32(n)
    else
      gvars.ene_soldier2CommonPackageLabelIndex=n
    end
  else
    t=TppDefine.SOLIDER2_COMMON_PACK.default
    a=TppDefine.SOLIDER2_COMMON_PACK_PREREQUISITES.default
    this.ResetSoldier2CommonBlockPackageLabel()
  end
  TppSoldier2CommonBlockController.SetPackagePathWithPrerequisites{path=t,prerequisites=a}
end
function this.IsRequiredToLoadSpecialSolider2CommonBlock()
  if StrCode32(mvars.ene_soldier2CommonBlockPackageLabel)~=TppDefine.DEFAULT_SOLIDER2_COMMON_PACKAGE then
    return true
  else
    return false
  end
end
function this.IsRequiredToLoadDefaultSoldier2CommonPackage()
  local e=StrCode32(mvars.ene_soldier2CommonBlockPackageLabel)
  if(e==TppDefine.DEFAULT_SOLIDER2_COMMON_PACKAGE)then
    return true
  else
    return false
  end
end
function this.IsLoadedDefaultSoldier2CommonPackage()
  if gvars.ene_soldier2CommonPackageLabelIndex==TppDefine.DEFAULT_SOLIDER2_COMMON_PACKAGE then
    return true
  else
    return false
  end
end
function this.LoadSoldier2CommonBlock()
  this.RegisterSoldier2CommonMotionPackagePath(mvars.ene_soldier2CommonBlockPackageLabel)
  while not TppSoldier2CommonBlockController.IsReady()do
    coroutine.yield()
  end
end
function this.UnloadSoldier2CommonBlock()
  TppSoldier2CommonBlockController.SetPackagePathWithPrerequisites{}
end
function this.SetMaxSoldierStateCount(e)
  if Tpp.IsTypeNumber(e)and(e>0)then
    mvars.ene_maxSoldierStateCount=e
  end
end
function this.RestoreOnMissionStart2()
  local t=0
  local a=0
  if EnemyFova~=nil then
    if EnemyFova.INVALID_FOVA_VALUE~=nil then
      t=EnemyFova.INVALID_FOVA_VALUE
      a=EnemyFova.INVALID_FOVA_VALUE
    end
  end
  local n=0
  if mvars.ene_cpList~=nil then
    for t,e in pairs(mvars.ene_cpList)do
      if n<mvars.ene_cpCount then
        svars.cpNames[n]=StrCode32(e)svars.cpFlags[n]=0
        n=n+1
      end
    end
  end
  for e=0,mvars.ene_maxSoldierStateCount-1 do
    svars.solName[e]=0
    svars.solState[e]=0
    svars.solFlagAndStance[e]=0
    svars.solWeapon[e]=0
    svars.solLocation[e*4+0]=0
    svars.solLocation[e*4+1]=0
    svars.solLocation[e*4+2]=0
    svars.solLocation[e*4+3]=0
    svars.solMarker[e]=0
    svars.solFovaSeed[e]=0
    svars.solFaceFova[e]=t
    svars.solBodyFova[e]=a
    svars.solCp[e]=0
    svars.solCpRoute[e]=GsRoute.ROUTE_ID_EMPTY
    svars.solScriptSneakRoute[e]=GsRoute.ROUTE_ID_EMPTY
    svars.solScriptCautionRoute[e]=GsRoute.ROUTE_ID_EMPTY
    svars.solScriptAlertRoute[e]=GsRoute.ROUTE_ID_EMPTY
    svars.solRouteNodeIndex[e]=0
    svars.solRouteEventIndex[e]=0
    svars.solTravelName[e]=0
    svars.solTravelStepIndex[e]=0
  end
  for e=0,TppDefine.DEFAULT_SOLDIER_OPTION_VARS_COUNT-1 do
    svars.solOptName[e]=0
    svars.solOptParam1[e]=0
    svars.solOptParam2[e]=0
  end
  if svars.passengerInfoName~=nil then
    for e=0,TppDefine.DEFAULT_PASSAGE_INFO_COUNT-1 do
      svars.passengerInfoName[e]=0
    end
  end
  if svars.passengerFlagName~=nil then
    for e=0,TppDefine.DEFAULT_PASSAGE_FLAG_COUNT-1 do
      svars.passengerFlagName[e]=0
    end
  end
  if svars.passengerNameName~=nil then
    for e=0,TppDefine.DEFAULT_PASSAGE_FLAG_COUNT-1 do
      svars.passengerNameName[e]=0
    end
  end
  if svars.passengerNameName~=nil then
    for e=0,TppDefine.DEFAULT_PASSAGE_FLAG_COUNT-1 do
      svars.passengerNameName[e]=0
    end
  end
  this._RestoreOnMissionStart_Hostage2()
  for e=0,TppDefine.DEFAULT_ENEMY_HELI_STATE_COUNT-1 do
    svars.enemyHeliName=0
    svars.enemyHeliLocation[0]=0
    svars.enemyHeliLocation[1]=0
    svars.enemyHeliLocation[2]=0
    svars.enemyHeliLocation[3]=0
    svars.enemyHeliCp=0
    svars.enemyHeliFlag=0
    svars.enemyHeliSneakRoute=0
    svars.enemyHeliCautionRoute=0
    svars.enemyHeliAlertRoute=0
    svars.enemyHeliRouteNodeIndex=0
    svars.enemyHeliRouteEventIndex=0
    svars.enemyHeliMarker=0
    svars.enemyHeliLife=0
  end
  for e=0,TppDefine.MAX_SECURITY_CAMERA_COUNT-1 do
    svars.securityCameraCp[e]=0
    svars.securityCameraMarker[e]=0
    svars.securityCameraFlag[e]=0
  end
end
function this.RestoreOnContinueFromCheckPoint2()do
  local e={type="TppCommandPost2"}
  SendCommand(e,{id="RestoreFromSVars"})
end
if GameObject.GetGameObjectIdByIndex("TppSoldier2",0)~=NULL_ID then
  local e={type="TppSoldier2"}
  SendCommand(e,{id="RestoreFromSVars"})
end
this._RestoreOnContinueFromCheckPoint_Hostage2()
if GameObject.GetGameObjectIdByIndex("TppEnemyHeli",0)~=NULL_ID then
  local e={type="TppEnemyHeli"}
  SendCommand(e,{id="RestoreFromSVars"})
end
if GameObject.GetGameObjectIdByIndex("TppVehicle2",0)~=NULL_ID then
  SendCommand({type="TppVehicle2"},{id="RestoreFromSVars"})
end
if GameObject.GetGameObjectIdByIndex("TppCommonWalkerGear2",0)~=NULL_ID then
  SendCommand({type="TppCommonWalkerGear2"},{id="RestoreFromSVars"})
end
if GameObject.GetGameObjectIdByIndex("TppLiquid2",0)~=NULL_ID then
  SendCommand({type="TppLiquid2"},{id="RestoreFromSVars"})
end
if GameObject.GetGameObjectIdByIndex("TppUav",0)~=NULL_ID then
  SendCommand({type="TppUav"},{id="RestoreFromSVars"})
end
if GameObject.GetGameObjectIdByIndex("TppSecurityCamera2",0)~=NULL_ID then
  SendCommand({type="TppSecurityCamera2"},{id="RestoreFromSVars"})
end
end
function this.RestoreOnContinueFromCheckPoint()
  this._RestoreOnContinueFromCheckPoint_Hostage()
end
function this.RestoreOnMissionStart()
  this._RestoreOnMissionStart_Hostage()
end
function this.StoreSVars(i)
  local t=false
  if i then
    t=true
  end
  do
    local e={type="TppCommandPost2"}SendCommand(e,{id="StoreToSVars"})
  end
  if GameObject.GetGameObjectIdByIndex("TppSoldier2",0)~=NULL_ID then
    local e={type="TppSoldier2"}SendCommand(e,{id="StoreToSVars",markerOnly=t})
  end
  this._StoreSVars_Hostage(t)
  if GameObject.GetGameObjectIdByIndex("TppEnemyHeli",0)~=NULL_ID then
    SendCommand({type="TppEnemyHeli"},{id="StoreToSVars"})
  end
  if GameObject.GetGameObjectIdByIndex("TppVehicle2",0)~=NULL_ID then
    SendCommand({type="TppVehicle2"},{id="StoreToSVars"})
  end
  if GameObject.GetGameObjectIdByIndex("TppCommonWalkerGear2",0)~=NULL_ID then
    SendCommand({type="TppCommonWalkerGear2"},{id="StoreToSVars"})
  end
  if GameObject.GetGameObjectIdByIndex("TppLiquid2",0)~=NULL_ID then
    SendCommand({type="TppLiquid2"},{id="StoreToSVars"})
  end
  if GameObject.GetGameObjectIdByIndex("TppUav",0)~=NULL_ID then
    SendCommand({type="TppUav"},{id="StoreToSVars"})
  end
  if GameObject.GetGameObjectIdByIndex("TppSecurityCamera2",0)~=NULL_ID then
    SendCommand({type="TppSecurityCamera2"},{id="StoreToSVars"})
  end
end
function this.PreMissionLoad(missionId,currentMissionId)
  this.InitializeHostage2()
  TppEneFova.PreMissionLoad(missionId,currentMissionId)
end
function this.InitializeHostage2()
  if TppHostage2.ClearHostageType then
    TppHostage2.ClearHostageType()
  end
  if TppHostage2.ClearUniquePartsPath then
    TppHostage2.ClearUniquePartsPath()
  end
end
function this.Init(n)
  mvars.ene_routeAnimationGaniPathTable={{"SoldierLookWatch","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_a.gani"},{"SoldierWipeFace","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_d.gani"},{"SoldierYawn","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_f.gani"},{"SoldierSneeze","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_g.gani"},{"SoldierFootStep","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_h.gani"},{"SoldierCough","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_i.gani"},{"SoldierScratchHead","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_o.gani"},{"SoldierHungry","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_p.gani"},nil}
  mvars.ene_eliminateTargetList={}
  mvars.ene_routeSets={}
  mvars.ene_noShiftChangeGroupSetting={}
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  this.RegistCommonRoutePointMessage()
  if n.enemy then
    if n.enemy.parasiteSquadList then
      mvars.ene_parasiteSquadList=n.enemy.parasiteSquadList
    end
    if n.enemy.USE_COMMON_REINFORCE_PLAN then
      mvars.ene_useCommonReinforcePlan=true
    end
  end
  if mvars.loc_locationCommonTravelPlans then
    mvars.ene_lrrpNumberDefine={}
    for e,n in pairs(mvars.loc_locationCommonTravelPlans.lrrpNumberDefine)do
      mvars.ene_lrrpNumberDefine[e]=n
    end
    mvars.ene_cpLinkDefine=this.MakeCpLinkDefineTable(mvars.ene_lrrpNumberDefine,mvars.loc_locationCommonTravelPlans.cpLinkMatrix)
    mvars.ene_defaultTravelRouteGroup=mvars.loc_locationCommonTravelPlans.defaultTravelRouteGroup
    local e
    if n.enemy and n.enemy.lrrpNumberDefine then
      e=n.enemy.lrrpNumberDefine
    end
    if e then
      for n,e in ipairs(n.enemy.lrrpNumberDefine)do
        local n=#mvars.ene_lrrpNumberDefine+1
        mvars.ene_lrrpNumberDefine[n]=e
        mvars.ene_lrrpNumberDefine[e]=n
      end
    end
    if n.enemy and n.enemy.cpLink then
      local t=n.enemy.cpLink
      for e,n in pairs(t)do
        mvars.ene_cpLinkDefine[e]=mvars.ene_cpLinkDefine[e]or{}
        for a,n in ipairs(mvars.ene_lrrpNumberDefine)do
          mvars.ene_cpLinkDefine[n]=mvars.ene_cpLinkDefine[n]or{}
          if t[e][n]then
            mvars.ene_cpLinkDefine[e][n]=true
            mvars.ene_cpLinkDefine[n][e]=true
          else
            mvars.ene_cpLinkDefine[e][n]=false
            mvars.ene_cpLinkDefine[n][e]=false
          end
        end
      end
    end
  end
  local e
  local n=TppStory.GetCurrentStorySequence()
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA then
    e=true
  else
    e=false
  end
  local n={"TppBossQuiet2","TppParasite2"}
  for t,n in ipairs(n)do
    if GameObject.DoesGameObjectExistWithTypeName(n)then
      GameObject.SendCommand({type=n},{id="SetFultonEnabled",enabled=e})
    end
  end
end
function this.RegistCommonRoutePointMessage()
end
function this.OnReload(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  this.RegistCommonRoutePointMessage()
  if n.enemy then
    this.SetUpCommandPost()
    this.SetUpSwitchRouteFunc()
  end
end
function this.OnMessage(r,o,i,n,a,t,s)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,r,o,i,n,a,t,s)
end
function this.DefineSoldiers(soldierDefine)--NMC: from <location>_enemy.lua?, soldierDefine[cpId]={soldierlist}
  mvars.ene_soldierDefine={}
  Tpp.MergeTable(mvars.ene_soldierDefine,soldierDefine,true)
  mvars.ene_soldierIDList={}
  mvars.ene_cpList={}
  mvars.ene_baseCpList={}
  mvars.ene_outerBaseCpList={}
  mvars.ene_holdTimes={}
  mvars.ene_sleepTimes={}
  mvars.ene_lrrpTravelPlan={}
  mvars.ene_lrrpVehicle={}
  for cpName,soldierList in pairs(soldierDefine)do
    local cpGameId=GetGameObjectId(cpName)
    if cpGameId==NULL_ID then
    else
      mvars.ene_cpList[cpGameId]=cpName
      mvars.ene_holdTimes[cpGameId]=this.DEFAULT_HOLD_TIME
      mvars.ene_sleepTimes[cpGameId]=this.DEFAULT_SLEEP_TIME
      mvars.ene_soldierIDList[cpGameId]={}
      if soldierList.lrrpTravelPlan then
        mvars.ene_lrrpTravelPlan[cpGameId]=soldierList.lrrpTravelPlan
      end
      if soldierList.lrrpVehicle then
        mvars.ene_lrrpVehicle[cpGameId]=soldierList.lrrpVehicle
      end
      for t,soldierName in pairs(soldierList)do
        if IsTypeString(t)then
          if not this.SOLDIER_DEFINE_RESERVE_TABLE_NAME[t]then
          end
        else
          local soldierGameId=GetGameObjectId(soldierName)
          if soldierGameId==NULL_ID then
          else
            mvars.ene_soldierIDList[cpGameId][soldierGameId]=t
          end
        end
      end
    end
  end
end
function this.SetUpSoldiers()
  if not IsTypeTable(mvars.ene_soldierDefine)then
    return
  end
  local missionId=TppMission.GetMissionID()
  for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
    local cpId=GetGameObjectId(cpName)
    if cpId==NULL_ID then
    else
      if string.sub(cpName,-4)=="lrrp"then
        SendCommand(cpId,{id="SetLrrpCp"})
      end
      local cpType=string.sub(cpName,-2)
      if cpType=="ob"then
        SendCommand(cpId,{id="SetOuterBaseCp"})
        mvars.ene_outerBaseCpList[cpId]=true
      end
      if cpType=="cp"then
        local n=true
        if cpName=="mafr_outland_child_cp"then
          n=false
        end
        if n then
          this.AddCpIntelTrapTable(cpName)
          mvars.ene_baseCpList[cpId]=true
        end
      end
      TppEmblem.SetUpCpEmblemTag(cpName,cpId)
      if mvars.loc_locationSiren then
        local locationSiren=mvars.loc_locationSiren[cpName]
        if locationSiren then
          SendCommand(cpId,{id="SetCpSirenType",type=locationSiren.sirenType,pos=locationSiren.pos})
        end
      end
      local command
      if(missionId==10150 or missionId==10151)or missionId==11151 then
        command={id="SetCpType",type=CpType.TYPE_AMERICA}
      elseif TppLocation.IsAfghan()then
        command={id="SetCpType",type=CpType.TYPE_SOVIET}
      elseif TppLocation.IsMiddleAfrica()then
        command={id="SetCpType",type=CpType.TYPE_AFRIKAANS}
      elseif TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
        command={id="SetCpType",type=CpType.TYPE_AMERICA}
      end
      if command then
        SendCommand(cpId,command)
      end
    end
  end
  for t,cpName in pairs(mvars.ene_cpList)do
    if mvars.ene_baseCpList[t]then
      local soldierList=mvars.ene_soldierDefine[cpName]
      for n,soldierName in ipairs(soldierList)do
        local gameId=GetGameObjectId(soldierName)
        if gameId==NULL_ID then
        else
          SendCommand(gameId,{id="AddRouteAssignMember"})
        end
      end
    end
  end
  for i,cpName in pairs(mvars.ene_cpList)do
    if not mvars.ene_baseCpList[i]then
      local soldierList=mvars.ene_soldierDefine[cpName]
      for n,soldierName in ipairs(soldierList)do
        local soldierId=GetGameObjectId(soldierName)
        if soldierId==NULL_ID then
        else
          SendCommand(soldierId,{id="AddRouteAssignMember"})
        end
      end
    end
  end
  this.AssignSoldiersToCP()
end
function this.AssignSoldiersToCP()
  local missionId=TppMission.GetMissionID()
  this._ConvertSoldierNameKeysToId(mvars.ene_soldierTypes)
  mvars.ene_soldierSubType=mvars.ene_soldierSubType or{}
  mvars.ene_soldierLrrp=mvars.ene_soldierLrrp or{}
  local subTypeOfCp=this.subTypeOfCp
  for gameId,t in pairs(mvars.ene_soldierIDList)do
    local cpId=mvars.ene_cpList[gameId]
    local cpSubType=subTypeOfCp[cpId]
    local isChild=false
    for gameId,p in pairs(t)do
      SendCommand(gameId,{id="SetCommandPost",cp=cpId})
      if mvars.ene_lrrpTravelPlan[gameId]then
        SendCommand(gameId,{id="SetLrrp",travelPlan=mvars.ene_lrrpTravelPlan[gameId]})
        mvars.ene_soldierLrrp[gameId]=true
        if mvars.ene_lrrpVehicle[gameId]then
          local vehicleId=GameObject.GetGameObjectId("TppVehicle2",mvars.ene_lrrpVehicle[gameId])
          local command={id="SetRelativeVehicle",targetId=vehicleId,rideFromBeginning=true}
          SendCommand(gameId,command)
        end
      end
      local soldierType=this.GetSoldierType(gameId)
      local command={id="SetSoldier2Type",type=soldierType}
      SendCommand(gameId,command)
      if(soldierType~=EnemyType.TYPE_SKULL and soldierType~=EnemyType.TYPE_CHILD)and cpSubType then
        mvars.ene_soldierSubType[gameId]=cpSubType
      end
      if missionId~=10080 and missionId~=11080 then
        if soldierType==EnemyType.TYPE_CHILD then
          isChild=true
        end
      end
    end
    if isChild then
      SendCommand(gameId,{id="SetChildCp"})
    end
  end
end
function this.InitCpGroups()
  mvars.ene_cpGroups={}
end
function this.RegistCpGroups(n)
  this.SetCommonCpGroups()
  if IsTypeTable(n)then
    for e,n in pairs(n)do
      mvars.ene_cpGroups[e]=mvars.ene_cpGroups[e]or{}
      for t,n in pairs(n)do
        table.insert(mvars.ene_cpGroups[e],n)
      end
    end
  end
end
function this.SetCommonCpGroups()
  if not IsTypeTable(mvars.loc_locationCommonCpGroups)then
    return
  end
  for n,t in pairs(mvars.loc_locationCommonCpGroups)do
    if IsTypeTable(t)then
      mvars.ene_cpGroups[n]={}
      for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
        if t[cpName]then
          table.insert(mvars.ene_cpGroups[n],cpName)
        end
      end
    end
  end
end
function this.SetCpGroups()
  local t={type="TppCommandPost2"}
  local e={id="SetCpGroups",cpGroups=mvars.ene_cpGroups}
  SendCommand(t,e)
end
function this.RegistVehicleSettings(e)
  if not IsTypeTable(e)then
    return
  end
  mvars.ene_vehicleSettings=e
  local n=0
  for e,e in pairs(e)do
    n=n+1
  end
  mvars.ene_vehicleDefine=mvars.ene_vehicleDefine or{}
  mvars.ene_vehicleDefine.instanceCount=n
end
function this.SpawnVehicles(n)
  for t,n in ipairs(n)do
    this.SpawnVehicle(n)
  end
end
function this.SpawnVehicle(e)
  if not IsTypeTable(e)then
    return
  end
  if e.id~="Spawn"then
    e.id="Spawn"end
  local n=e.locator
  if not n then
    return
  end
  local e=SendCommand({type="TppVehicle2"},e)
  if not e then
  end
end
function this.RespawnVehicle(e)
  if not IsTypeTable(e)then
    return
  end
  if e.id~="Respawn"then
    e.id="Respawn"end
  local n=e.name
  if not n then
    return
  end
  local e=SendCommand({type="TppVehicle2"},e)
  if not e then
  end
end
function this.DespawnVehicles(n)
  for t,n in ipairs(n)do
    this.DespawnVehicle(n)
  end
end
function this.DespawnVehicle(e)
  if not IsTypeTable(e)then
    return
  end
  if e.id~="Despawn"then
    e.id="Despawn"end
  local n=e.locator
  if not n then
    return
  end
  local e=SendCommand({type="TppVehicle2"},e)
  if not e then
  end
end
function this.SetUpVehicles()
  if mvars.ene_vehicleSettings==nil then
    return
  end
  for t,e in pairs(mvars.ene_vehicleSettings)do
    if(IsTypeString(t)and IsTypeTable(e))and e.type then
      local t={id="Spawn",locator=t,type=e.type}
      if e.subType then
        t.subType=e.subType
      end
      SendCommand({type="TppVehicle2"},t)
    end
  end
end
function this.AddCpIntelTrapTable(e)
  mvars.ene_cpIntelTrapTable=mvars.ene_cpIntelTrapTable or{}
  mvars.ene_cpIntelTrapTable[e]="trap_intel_"..e
end
function this.GetCpIntelTrapTable()
  return mvars.ene_cpIntelTrapTable
end
function this.GetCurrentRouteSetType(t,i,r)
  local a=function(n,e)
    if not e then
      e=TppClock.GetTimeOfDayIncludeMidNight()
    end
    local e="sneak"..("_"..e)
    if n then
      local n=not next(mvars.ene_routeSets[n].sneak_midnight)
      if e=="sneak_midnight"and n then
        e="sneak_night"end
    end
    return e
  end
  if t==0 then
    t=false
  end
  local n
  if t then
    local t=this.ROUTE_SET_TYPETAG[t]
    if t=="travel"then
      return"travel"end
    if t=="hold"then
      return"hold"end
    if t=="sleep"then
      return"sleep"end
    if i==this.PHASE.SNEAK then
      n=a(r,t)
    else
      n="caution"end
  else
    if i==this.PHASE.SNEAK then
      n=a(r)
    else
      n="caution"end
  end
  return n
end
function this.GetPrioritizedRouteTable(e,n,t,r)
  local i={}
  local a=t[e]
  if not IsTypeTable(a)then
    return
  end
  if mvars.ene_funcRouteSetPriority then
    i=mvars.ene_funcRouteSetPriority(e,n,t,r)
  else
    local t=0
    for a,e in ipairs(a)do
      if n[e]then
        local e=#n[e]
        if e>t then
          t=e
        end
      end
    end
    local e=1
    for r=1,t do
      for a,t in ipairs(a)do
        local n=n[t]
        if n then
          local n=n[r]
          if n and Tpp.IsTypeTable(n)then
            i[e]=n
            e=e+1
          end
        end
      end
    end
    for r=1,t do
      for a,t in ipairs(a)do
        local n=n[t]
        if n then
          local n=n[r]
          if n and not Tpp.IsTypeTable(n)then
            i[e]=n
            e=e+1
          end
        end
      end
    end
  end
  return i
end
function this.RouteSelector(n,i,a)
  local t=mvars.ene_routeSets[n]
  if t==nil then
    return{"dummyRoute"}
  end
  if a==StrCode32"immediately"then
    if i==StrCode32"old"then
      local t=this.GetCurrentRouteSetType(nil,this.GetPhaseByCPID(n),n)
      return this.GetPrioritizedRouteTable(n,mvars.ene_routeSetsTemporary[n][t],mvars.ene_routeSetsPriorityTemporary)
    else
      local a=this.GetCurrentRouteSetType(nil,this.GetPhaseByCPID(n),n)
      return this.GetPrioritizedRouteTable(n,t[a],mvars.ene_routeSetsPriority)
    end
  end
  if a==StrCode32"SYS_Sneak"then
    local i=this.GetCurrentRouteSetType(nil,this.PHASE.SNEAK,n)
    return this.GetPrioritizedRouteTable(n,t[i],mvars.ene_routeSetsPriority,a)
  end
  if a==StrCode32"SYS_Caution"then
    local i=this.GetCurrentRouteSetType(nil,this.PHASE.CAUTION,n)
    return this.GetPrioritizedRouteTable(n,t[i],mvars.ene_routeSetsPriority,a)
  end
  local i=this.GetCurrentRouteSetType(i,this.GetPhaseByCPID(n),n)
  local a=t[i][a]
  if a then
    return a
  else
    if i=="hold"then
      local a=this.GetCurrentRouteSetType(nil,this.GetPhaseByCPID(n),n)
      return this.GetPrioritizedRouteTable(n,t[a],mvars.ene_routeSetsPriority)
    else
      local a=this.GetCurrentRouteSetType(nil,this.GetPhaseByCPID(n),n)
      return this.GetPrioritizedRouteTable(n,t[a],mvars.ene_routeSetsPriority)
    end
  end
end
this.STR32_CAN_USE_SEARCH_LIGHT=StrCode32"CanUseSearchLight"this.STR32_CAN_NOT_USE_SEARCH_LIGHT=StrCode32"CanNotUseSearchLight"this.STR32_IS_GIMMICK_BROKEN=StrCode32"IsGimmickBroken"this.STR32_IS_NOT_GIMMICK_BROKEN=StrCode32"IsNotGimmickBroken"function this.SetUpSwitchRouteFunc()
  if not GameObject.DoesGameObjectExistWithTypeName"TppSoldier2"then
    return
  end
  SendCommand({type="TppSoldier2"},{id="SetSwitchRouteFunc",func=this.SwitchRouteFunc})
end
function this.SwitchRouteFunc(a,n,t,a,a)
  if n==this.STR32_CAN_USE_SEARCH_LIGHT then
    local e=mvars.gim_gimmackNameStrCode32Table[t]
    if TppGimmick.IsBroken{gimmickId=e}then
      return false
    else
      if TppClock.GetTimeOfDay()~="night"then
        return false
      end
      return true
    end
  end
  if n==this.STR32_CAN_NOT_USE_SEARCH_LIGHT then
    local e=mvars.gim_gimmackNameStrCode32Table[t]
    if TppGimmick.IsBroken{gimmickId=e}then
      return true
    else
      if TppClock.GetTimeOfDay()~="night"then
        return true
      end
      return false
    end
  end
  if n==this.STR32_IS_GIMMICK_BROKEN then
    local e=mvars.gim_gimmackNameStrCode32Table[t]
    if TppGimmick.IsBroken{gimmickId=e}then
      return true
    else
      return false
    end
  end
  if n==this.STR32_IS_NOT_GIMMICK_BROKEN then
    local e=mvars.gim_gimmackNameStrCode32Table[t]
    if TppGimmick.IsBroken{gimmickId=e}then
      return false
    else
      return true
    end
  end
  return true
end
function this.SetUpCommandPost()
  if not IsTypeTable(mvars.ene_soldierIDList)then
    return
  end
  for t,a in pairs(mvars.ene_cpList)do
    SendCommand(t,{id="SetRouteSelector",func=this.RouteSelector})
  end
end
function this.RegisterRouteAnimation()
  if TppRouteAnimationCollector then
    TppRouteAnimationCollector.ClearGaniPath()
    TppRouteAnimationCollector.RegisterGaniPath(mvars.ene_routeAnimationGaniPathTable)
  end
end
function this.MergeRouteSetDefine(o)
  local function i(n,t)
    if t.priority then
      mvars.ene_routeSetsDefine[n].priority={}
      mvars.ene_routeSetsDefine[n].fixedShiftChangeGroup={}
      for e=1,#(t.priority)do
        mvars.ene_routeSetsDefine[n].priority[e]=t.priority[e]
      end
    end
    if t.fixedShiftChangeGroup then
      for e=1,#(t.fixedShiftChangeGroup)do
        mvars.ene_routeSetsDefine[n].fixedShiftChangeGroup[e]=t.fixedShiftChangeGroup[e]
      end
    end
    for a,e in pairs(this.ROUTE_SET_TYPES)do
      mvars.ene_routeSetsDefine[n][e]=mvars.ene_routeSetsDefine[n][e]or{}
      if t[e]then
        for t,a in pairs(t[e])do
          mvars.ene_routeSetsDefine[n][e][t]={}
          if IsTypeTable(a)then
            for i,a in ipairs(a)do
              mvars.ene_routeSetsDefine[n][e][t][i]=a
            end
          end
        end
      end
    end
  end
  for e,t in pairs(o)do
    mvars.ene_routeSetsDefine[e]=mvars.ene_routeSetsDefine[e]or{}
    local t=t
    if t.walkergearpark then
      local e=GetGameObjectId(e)
      SendCommand(e,{id="SetWalkerGearParkRoute",routes=t.walkergearpark})
    end
    if mvars.loc_locationCommonRouteSets then
      if mvars.loc_locationCommonRouteSets[e]then
        if mvars.loc_locationCommonRouteSets[e].outofrain then
          local a=GetGameObjectId(e)
          if t.outofrain then
            SendCommand(a,{id="SetOutOfRainRoute",routes=t.outofrain})
          else
            SendCommand(a,{id="SetOutOfRainRoute",routes=mvars.loc_locationCommonRouteSets[e].outofrain})
          end
        end
      end
      if t.USE_COMMON_ROUTE_SETS then
        if mvars.loc_locationCommonRouteSets[e]then
          i(e,mvars.loc_locationCommonRouteSets[e])
        end
      end
    end
    i(e,t)
  end
end
function this.UpdateRouteSet(n)
  for n,t in pairs(n)do
    local n=GetGameObjectId(n)
    if n==NULL_ID then
    else
      mvars.ene_routeSets[n]=mvars.ene_routeSets[n]or{}
      if t.priority then
        mvars.ene_routeSetsPriority[n]={}
        mvars.ene_routeSetsFixedShiftChange[n]={}
        for e=1,#(t.priority)do
          mvars.ene_routeSetsPriority[n][e]=StrCode32(t.priority[e])
        end
      end
      if t.fixedShiftChangeGroup then
        for e=1,#(t.fixedShiftChangeGroup)do
          mvars.ene_routeSetsFixedShiftChange[n][StrCode32(t.fixedShiftChangeGroup[e])]=e
        end
      end
      if mvars.ene_noShiftChangeGroupSetting[n]then
        for t,e in pairs(mvars.ene_noShiftChangeGroupSetting[n])do
          mvars.ene_routeSetsFixedShiftChange[n][t]=e
        end
      end
      for a,e in pairs(this.ROUTE_SET_TYPES)do
        mvars.ene_routeSets[n][e]=mvars.ene_routeSets[n][e]or{}
        if t[e]then
          for t,a in pairs(t[e])do
            mvars.ene_routeSets[n][e][StrCode32(t)]=mvars.ene_routeSets[n][e][StrCode32(t)]or{}
            if type(a)=="number"then
            else
              for a,i in ipairs(a)do
                mvars.ene_routeSets[n][e][StrCode32(t)][a]=i
              end
            end
          end
        end
      end
    end
  end
end
function this.RegisterRouteSet(n)
  mvars.ene_routeSetsDefine={}
  this.MergeRouteSetDefine(n)
  mvars.ene_routeSets={}
  mvars.ene_routeSetsPriority={}
  mvars.ene_routeSetsFixedShiftChange={}
  this.UpdateRouteSet(mvars.ene_routeSetsDefine)
  TppClock.RegisterClockMessage("ShiftChangeAtNight",TppClock.DAY_TO_NIGHT)
  TppClock.RegisterClockMessage("ShiftChangeAtMorning",TppClock.NIGHT_TO_DAY)
  TppClock.RegisterClockMessage("ShiftChangeAtMidNight",TppClock.NIGHT_TO_MIDNIGHT)
end
function this._InsertShiftChangeUnit(t,a,n)
  for e,i in pairs(mvars.ene_shiftChangeTable[t])do
    if n[e]and next(n[e])then
      if n[e].hold then
        mvars.ene_shiftChangeTable[t][e][a*2-1]={n[e].start,n[e].hold,holdTime=n[e].holdTime}
        mvars.ene_shiftChangeTable[t][e][a*2]={n[e].hold,n[e].goal}
      else
        mvars.ene_shiftChangeTable[t][e][a*2-1]={n[e].start,n[e].goal}
        mvars.ene_shiftChangeTable[t][e][a*2]="dummy"end
    end
  end
end
function this._GetShiftChangeRouteGroup(n,r,a,l,p,i,s,t)
  local e=(r-a)+1
  local o=a
  if t[n[a]]then
    e=o
  else
    local i=0
    for a=1,a do
      if t[n[a]]then
        i=i+1
      end
    end
    e=e+i
    local a=0
    for i=e,r do
      if t[n[i]]then
        a=a+1
      end
    end
    e=e-a
    local a=e
    local i=0
    local r=t[n[a]]
    while r do
      i=i+1
      a=a-1
      r=t[n[a]]
    end
    e=e-i
  end
  local a=n[e]
  local t="default"if l[i]then
    t=i
  end
  local e=nil
  if s then
    e="default"if p[i]then
      e=i
    end
  end
  local n=n[o]
  return a,t,e,n
end
function this._MakeShiftChangeUnit(t,a,n,r,o,_,T,d,i,c,l)
  if mvars.ene_noShiftChangeGroupSetting[t]and mvars.ene_noShiftChangeGroupSetting[t][n]then
    return nil
  end
  local n,i,e,a=this._GetShiftChangeRouteGroup(a,d,i,r,_,n,o,l)
  local e={}
  for n,t in pairs(mvars.ene_shiftChangeTable[t])do
    e[n]={}
  end
  if(i~="default")or(IsTypeTable(r[StrCode32"default"])and next(r[StrCode32"default"]))then
    e.shiftAtNight.start={"day",n}
    e.shiftAtNight.hold={"hold",i}
    e.shiftAtNight.holdTime=mvars.ene_holdTimes[t]
    e.shiftAtNight.goal={"night",a}
    e.shiftAtMorning.hold={"hold",i}
    e.shiftAtMorning.holdTime=mvars.ene_holdTimes[t]
    e.shiftAtMorning.goal={"day",a}
  else
    e.shiftAtNight.start={"day",n}
    e.shiftAtNight.goal={"night",a}
    e.shiftAtMorning.goal={"day",a}
  end
  if o then
    e.shiftAtMidNight.start={"night",n}
    e.shiftAtMidNight.hold={"sleep",i}
    e.shiftAtMidNight.holdTime=mvars.ene_sleepTimes[t]
    if T then
      e.shiftAtMidNight.goal={"midnight",a}
    else
      e.shiftAtMidNight.goal={"night",n}
    end
    e.shiftAtMorning.start={"midnight",n}
  else
    e.shiftAtMorning.start={"night",n}
  end
  return e
end
function this.MakeShiftChangeTable()
  mvars.ene_shiftChangeTable={}
  for n,a in pairs(mvars.ene_routeSetsPriority)do
    if not IsTypeTable(a)then
      return
    end
    local i=false
    local o=false
    if next(mvars.ene_routeSets[n].sleep)then
      mvars.ene_shiftChangeTable[n]={shiftAtNight={},shiftAtMorning={},shiftAtMidNight={}}i=true
      if next(mvars.ene_routeSets[n].sneak_midnight)then
        o=true
      end
    else
      mvars.ene_shiftChangeTable[n]={shiftAtNight={},shiftAtMorning={}}
    end
    local p=mvars.ene_routeSets[n].hold
    local s=nil
    if i then
      s=mvars.ene_routeSets[n].sleep
    end
    local t=1
    local l=#a
    for _,d in ipairs(a)do
      local r
      r=this._MakeShiftChangeUnit(n,a,d,p,i,s,o,l,_,t,mvars.ene_routeSetsFixedShiftChange[n])
      if r then
        this._InsertShiftChangeUnit(n,t,r)t=t+1
      end
    end
  end
end
function this.ShiftChangeByTime(t)
  if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
    return
  end
  if not IsTypeTable(mvars.ene_shiftChangeTable)then
    return
  end
  for a,e in pairs(mvars.ene_shiftChangeTable)do
    if e[t]then
      SendCommand(a,{id="ShiftChange",schedule=e[t]})
    end
  end
end
local function IsWithinDistSqr(distanceSqr,position,gameId)
  local gameObjectPosition=SendCommand(gameId,{id="GetPosition"})
  local betweenVector=position-gameObjectPosition
  local lengthSqr=betweenVector:GetLengthSqr()
  if lengthSqr>distanceSqr then
    return false
  else
    return true
  end
end
function this.MakeCpLinkDefineTable(t,e)
  local n={}
  for a=1,#e do
    local i=Tpp.SplitString(e[a],"	")
    local e=t[a]
    if e then
      n[e]=n[e]or{}
      for a,i in pairs(i)do
        local t=t[a]
        if t then
          n[e][t]=n[e][t]or{}
          local a=false
          if tonumber(i)>0 then
            a=true
          end
          n[e][t]=a
        end
      end
    end
  end
  return n
end
function this.MakeReinforceTravelPlan(i,a,s,toCp,n)
  if not Tpp.IsTypeTable(n)then
    return
  end
  local a=a[toCp]
  if a==nil then
    return
  end
  mvars.ene_travelPlans=mvars.ene_travelPlans or{}
  local r=0
  for r,fromCp in pairs(n)do
    if mvars.ene_soldierDefine[fromCp]then
      if a[fromCp]then
        local o=i[toCp]
        local r=i[fromCp]
        local plan="rp_"..(toCp..("_From_"..fromCp))
        mvars.ene_travelPlans[plan]=mvars.ene_travelPlans[plan]or{}
        local p=string.format("rp_%02dto%02d",r,o)
        local lrrpCp=this.GetFormattedLrrpCpNameByLrrpNum(o,r,s,i)
        mvars.ene_travelPlans[plan]={{cp=lrrpCp,routeGroup={"travel",p}},{cp=toCp,finishTravel=true}}
        mvars.ene_reinforcePlans[plan]={{toCp=toCp,fromCp=fromCp,type="respawn"}}
      end
    end
  end
end
function this.MakeTravelPlanTable(T,d,_,t,n,l)
  if((not Tpp.IsTypeTable(n)or not Tpp.IsTypeTable(n[1]))or not Tpp.IsTypeString(t))or(n[1].cp==nil and n[1].base==nil)then
    return
  end
  mvars.ene_travelPlans=mvars.ene_travelPlans or{}
  mvars.ene_travelPlans[t]=mvars.ene_travelPlans[t]or{}
  local s=mvars.ene_travelPlans[t]
  local o=#n
  local r,i
  if(not n.ONE_WAY)and n[#n].base then
    r=n[#n]
  end
  for t=1,o do
    local a
    if n.ONE_WAY and(t==o)then
      a=true
    end
    if n[t].base then
      if t==1 then
        i=n[t]
      else
        r=n[t-1]i=n[t]
      end
      this.AddLinkedBaseTravelCourse(T,d,_,l,s,r,i,a)
    elseif n[t].cp then
      local n=n[t]
      if IsTypeTable(n)then
        this.AddTravelCourse(s,n,a)
      end
    end
  end
end
function this.AddLinkedBaseTravelCourse(l,i,r,p,s,a,t,d)
  local n
  if a and a.base then
    n=a.base
  end
  local a=t.base
  local o=false
  if n then
    o=i[n][a]
  end
  if o then
    local t,n=this.GetFormattedLrrpCpName(n,a,r,l)
    local n={cp=t,routeGroup={"travel",n}}
    this.AddTravelCourse(s,n)
  elseif n==nil then
  end
  local r
  if t.wait then
    r=t.wait
  else
    r=p
  end
  local i
  if t.routeGroup and Tpp.IsTypeTable(t.routeGroup)then
    i={t.routeGroup[1],t.routeGroup[2]}
  else
    local t
    local e=mvars.ene_defaultTravelRouteGroup
    if((e and o)and e[n])and Tpp.IsTypeTable(e[n][a])then
      t=e[n][a]
    end
    if t then
      i={t[1],t[2]}
    else
      i={"travel","lrrpHold"}
    end
  end
  local n={cp=a,routeGroup=i,wait=r}
  this.AddTravelCourse(s,n,d)
end
function this.GetFormattedLrrpCpNameByLrrpNum(n,e,i,t)
  local t,a
  if n<e then
    t=n
    a=e
  else
    t=e
    a=n
  end
  local t=string.format("%s_%02d_%02d_lrrp",i,t,a)
  local e=string.format("lrrp_%02dto%02d",n,e)
  return t,e
end
function this.GetFormattedLrrpCpName(a,t,i,n)
  local a=n[a]
  local t=n[t]
  return this.GetFormattedLrrpCpNameByLrrpNum(a,t,i,n)
end
function this.AddTravelCourse(n,e,t)
  if t then
    e.finishTravel=true
  else
    e.finishTravel=nil
  end
  table.insert(n,e)
end
function this.SetTravelPlans(i)
  mvars.ene_reinforcePlans={}
  mvars.ene_travelPlans={}
  if mvars.loc_locationCommonTravelPlans then
    local n=TppLocation.GetLocationName()
    if n then
      local r=mvars.ene_lrrpNumberDefine
      local a=mvars.ene_cpLinkDefine
      for i,t in pairs(i)do
        this.MakeTravelPlanTable(r,a,n,i,t,this.DEFAULT_TRAVEL_HOLD_TIME)
      end
      local t=mvars.loc_locationCommonTravelPlans.reinforceTravelPlan
      if mvars.ene_useCommonReinforcePlan and t then
        for t,i in pairs(t)do
          if mvars.ene_soldierDefine[t]then
            this.MakeReinforceTravelPlan(r,a,n,t,i)
          end
        end
      end
    end
  else
    mvars.ene_travelPlans=i
  end
  SendCommand({type="TppSoldier2"},{id="SetTravelPlan",travelPlan=mvars.ene_travelPlans})
  if next(mvars.ene_reinforcePlans)then
    SendCommand({type="TppCommandPost2"},{id="SetReinforcePlan",reinforcePlan=mvars.ene_reinforcePlans})
  end
end
function this.RegistHoldBrokenState(n)
  if not IsTypeString(n)then
    return
  end
  local t=GetGameObjectId(n)
  if t==NULL_ID then
    return
  end
  local e=this.AddBrokenStateList(n)
  if not e then
    return
  end
  mvars.ene_vehicleBrokenStateIndexByName=mvars.ene_vehicleBrokenStateIndexByName or{}
  mvars.ene_vehicleBrokenStateIndexByName[n]=e
  mvars.ene_vehicleBrokenStateIndexByGameObjectId=mvars.ene_vehicleBrokenStateIndexByGameObjectId or{}
  mvars.ene_vehicleBrokenStateIndexByGameObjectId[t]=e
end
function this.AddBrokenStateList(n)
  local e
  local a=StrCode32(n)
  for n=0,(TppDefine.MAX_HOLD_VEHICLE_BROKEN_STATE_COUNT-1)do
    local t=svars.ene_holdBrokenStateName[n]
    if(t==0)or(t==a)then
      e=n
      break
    end
  end
  if e then
    svars.ene_holdBrokenStateName[e]=a
    return e
  else
    return
  end
end
function this._OnHeliBroken(t,n)
  if n==StrCode32"Start"then
    this.PlayTargetEliminatedRadio(t)
  end
end
function this._OnVehicleBroken(n,t)
  this.SetVehicleBroken(n)
  if t==StrCode32"End"then
    this.PlayTargetEliminatedRadio(n)
  end
end
function this._OnWalkerGearBroken(n,t)
  if t==StrCode32"End"then
    this.PlayTargetEliminatedRadio(n)
  end
end
function this.SetVehicleBroken(e)
  if not mvars.ene_vehicleBrokenStateIndexByGameObjectId then
    return
  end
  local e=mvars.ene_vehicleBrokenStateIndexByGameObjectId[e]
  if e then
    svars.ene_isVehicleBroken[e]=true
  end
end
function this.IsVehicleBroken(n)
  local e
  if IsTypeString(n)then
    e=mvars.ene_vehicleBrokenStateIndexByName[n]
  elseif IsTypeNumber(n)then
    e=mvars.ene_vehicleBrokenStateIndexByGameObjectId[n]
  end
  if e then
    return svars.ene_isVehicleBroken[e]
  end
end
function this.IsVehicleAlive(t)
  local e
  if IsTypeString(t)then
    e=GetGameObjectId(t)
  elseif IsTypeNumber(t)then
    e=t
  end
  if e==NULL_ID then
    return
  end
  return SendCommand(e,{id="IsAlive"})
end
function this.PlayTargetRescuedRadio(n)
  local t=this.IsEliminateTarget(n)
  local e=this.IsRescueTarget(n)
  if t then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.TARGET_ELIMINATED)
  elseif e then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.TARGET_RECOVERED)
  end
end
function this.PlayTargetEliminatedRadio(n)
  local e=this.IsEliminateTarget(n)
  if e then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.TARGET_ELIMINATED)
  end
end
function this.RegistHoldRecoveredState(n)
  if not IsTypeString(n)then
    return
  end
  local t=GetGameObjectId(n)
  if t==NULL_ID then
    return
  end
  local e=this.AddRecoveredStateList(n)
  if not e then
    return
  end
  mvars.ene_recoverdStateIndexByName=mvars.ene_recoverdStateIndexByName or{}
  mvars.ene_recoverdStateIndexByName[n]=e
  mvars.ene_recoverdStateIndexByGameObjectId=mvars.ene_recoverdStateIndexByGameObjectId or{}
  mvars.ene_recoverdStateIndexByGameObjectId[t]=e
end
function this.AddRecoveredStateList(n)
  local e
  local t=StrCode32(n)
  for a=0,(TppDefine.MAX_HOLD_RECOVERED_STATE_COUNT-1)do
    local n=svars.ene_holdRecoveredStateName[a]
    if(n==0)or(n==t)then
      e=a
      break
    end
  end
  if e then
    svars.ene_holdRecoveredStateName[e]=t
    return e
  else
    return
  end
end
function this.SetRecovered(e)
  if not mvars.ene_recoverdStateIndexByGameObjectId then
    return
  end
  local e=mvars.ene_recoverdStateIndexByGameObjectId[e]
  if e then
    svars.ene_isRecovered[e]=true
  end
end
function this.ExecuteOnRecoveredCallback(n,r,i,t,a,o,s)
  if not mvars.ene_recoverdStateIndexByGameObjectId then
    return
  end
  local e=mvars.ene_recoverdStateIndexByGameObjectId[n]
  if not e then
    return
  end
  local e
  if TppMission.systemCallbacks and TppMission.systemCallbacks.OnRecovered then
    e=TppMission.systemCallbacks.OnRecovered
  end
  if not e then
    return
  end
  if not TppMission.CheckMissionState(true,false,true,false)then
    return
  end
  e(n,r,i,t,a,o,s)
end
local checkDistSqr=10*10
function this.CheckAllVipClear(n)
  return this.CheckAllTargetClear(n)
end
function this.CheckAllTargetClear(n)
  local n=mvars
  local e=this
  local a=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
  TppHelicopter.SetNewestPassengerTable()
  local t={{n.ene_eliminateTargetList,e.CheckSoldierEliminateTarget,"EliminateTargetSoldier"},{n.ene_eliminateHelicopterList,e.CheckHelicopterEliminateTarget,"EliminateTargetHelicopter"},{n.ene_eliminateVehicleList,e.CheckVehicleEliminateTarget,"EliminateTargetVehicle"},{n.ene_eliminateWalkerGearList,e.CheckWalkerGearEliminateTarget,"EliminateTargetWalkerGear"},{n.ene_childTargetList,e.CheckRescueTarget,"childTarget"}}
  if n.ene_rescueTargetOptions then
    if not n.ene_rescueTargetOptions.orCheck then
      table.insert(t,{n.ene_rescueTargetList,e.CheckRescueTarget,"RescueTarget"})
    end
  end
  for e=1,#t do
    local e,n,t=t[e][1],t[e][2],t[e][3]
    if IsTypeTable(e)and next(e)then
      for e,t in pairs(e)do
        if not n(e,a,t)then
          return false
        end
      end
    end
  end
  if n.ene_rescueTargetOptions and n.ene_rescueTargetOptions.orCheck then
    local t=false
    for n,i in pairs(n.ene_rescueTargetList)do
      if e.CheckRescueTarget(n,a,i)then
        t=true
      end
    end
    return t
  end
  return true
end
function this.CheckSoldierEliminateTarget(gameId,position,a)
  local lifeStatus=SendCommand(gameId,{id="GetLifeStatus"})
  local status=SendCommand(gameId,{id="GetStatus"})
  if this._IsEliminated(lifeStatus,status)then
    return true
  elseif this._IsNeutralized(lifeStatus,status)then
    if IsWithinDistSqr(checkDistSqr,position,gameId)then
      return true
    else
      return false
    end
  end
  return false
end
function this.CheckHelicopterEliminateTarget(gameId,n,n)
  local isBroken=SendCommand(gameId,{id="IsBroken"})
  if isBroken then
    return true
  else
    return false
  end
end
function this.CheckVehicleEliminateTarget(gameId,t,t)
  if this.IsRecovered(gameId)then
    return true
  elseif this.IsVehicleBroken(gameId)then
    return true
  else
    return false
  end
end
function this.CheckWalkerGearEliminateTarget(gameId,n,n)
  local isBroken=SendCommand(gameId,{id="IsBroken"})
  if isBroken then
    return true
  elseif SendCommand(gameId,{id="IsFultonCaptured"})then
    return true
  else
    return false
  end
end
function this.CheckRescueTarget(gameId,position,a)
  if this.IsRecovered(gameId)then
    return true
  elseif IsWithinDistSqr(checkDistSqr,position,gameId)then
    return true
  elseif TppHelicopter.IsInHelicopter(gameId)then
    return true
  else
    return false
  end
end
function this.FultonRecoverOnMissionGameEnd()
  if mvars.ene_soldierIDList==nil then
    return
  end
  local i=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
  local n=10
  local missionId=TppMission.GetMissionID()
  if TppMission.IsFOBMission(missionId)then
    n=0
  end
  local a=n*n
  local n
  if Tpp.IsHelicopter(vars.playerVehicleGameObjectId)then
    n=false
  else
    n=true
  end
  local activeWalkerGears=this.GetAllActiveEnemyWalkerGear()
  for t,gameId in pairs(activeWalkerGears)do
    if IsWithinDistSqr(a,i,gameId)then
      local command={id="GetResourceId"}
      local resourceId=SendCommand(gameId,command)
      TppTerminal.OnFulton(gameId,nil,nil,resourceId,true,n,PlayerInfo.GetLocalPlayerIndex())
    end
  end
  TppHelicopter.SetNewestPassengerTable()
  TppTerminal.OnRecoverByHelicopterAlreadyGetPassengerList()
  for r,t in pairs(mvars.ene_soldierIDList)do
    for t,r in pairs(t)do
      if IsWithinDistSqr(a,i,t)and(not this.IsQuestNpc(t))then
        this.AutoFultonRecoverNeutralizedTarget(t,n)
      end
    end
  end
  local t=this.GetAllHostages()
  for r,t in pairs(t)do
    if((not TppHelicopter.IsInHelicopter(t))and IsWithinDistSqr(a,i,t))and(not this.IsQuestNpc(t))then
      local e=TppMotherBaseManagement.GetStaffIdFromGameObject{gameObjectId=t}
      TppTerminal.OnFulton(t,nil,nil,e,true,n,PlayerInfo.GetLocalPlayerIndex())
    end
  end
  TppHelicopter.ClearPassengerTable()
end
function this.AutoFultonRecoverNeutralizedTarget(t,a)
  local n=SendCommand(t,{id="GetLifeStatus"})
  if n==this.LIFE_STATUS.SLEEP or n==this.LIFE_STATUS.FAINT then
    local e
    e=TppMotherBaseManagement.GetStaffIdFromGameObject{gameObjectId=t}
    TppTerminal.OnFulton(t,nil,nil,e,nil,a,PlayerInfo.GetLocalPlayerIndex())
  end
end
function this.CheckQuestTargetOnOutOfActiveArea(n)
  if not IsTypeTable(n)then
    return
  end
  local o=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
  local t=10
  local i=t*t
  local t=false
  for n,n in pairs(n)do
    local n=GetGameObjectId(soliderName)
    if n~=NULL_ID then
      if IsWithinDistSqr(i,o,n)then
        t=true
        this.AutoFultonRecoverNeutralizedTarget(n)
      end
    end
  end
  return t
end
function this.ChangeRouteUsingGimmick(e,a,t,a)
  local a=TppGimmick.GetRouteConnectedGimmickId(e)
  if(a~=nil)and TppGimmick.IsBroken{gimmickId=a}then
    local a
    for n,e in pairs(mvars.ene_soldierIDList)do
      if e[t]then
        a=n
        break
      end
    end
    if a then
      local e={id="SetRouteEnabled",routes={e},enabled=false}SendCommand(a,e)
    end
  else
    mvars.ene_usingGimmickRouteEnemyList=mvars.ene_usingGimmickRouteEnemyList or{}
    mvars.ene_usingGimmickRouteEnemyList[e]=mvars.ene_usingGimmickRouteEnemyList[e]or{}
    mvars.ene_usingGimmickRouteEnemyList[e]=t
    SendCommand(t,{id="SetSneakRoute",route=e})
  end
end
function this.DisableUseGimmickRouteOnShiftChange(a,e)
  if not IsTypeTable(e)then
    return
  end
  if mvars.ene_usingGimmickRouteEnemyList==nil then
    return
  end
  for t,e in pairs(e)do
    local t=StrCode32(e)
    local t=mvars.ene_usingGimmickRouteEnemyList[t]
    if t then
      SendCommand(t,{id="SetSneakRoute",route=""})
    end
    local t=mvars.gim_routeGimmickConnectTable[StrCode32(e)]
    if(t~=nil)and TppGimmick.IsBroken{gimmickId=t}then
      local e={id="SetRouteEnabled",routes={e},enabled=false}SendCommand(a,e)
    end
  end
end
function this.IsEliminateTarget(e)
  local n=mvars.ene_eliminateTargetList and mvars.ene_eliminateTargetList[e]
  local a=mvars.ene_eliminateHelicopterList and mvars.ene_eliminateHelicopterList[e]
  local t=mvars.ene_eliminateVehicleList and mvars.ene_eliminateVehicleList[e]
  local e=mvars.ene_eliminateWalkerGearList and mvars.ene_eliminateWalkerGearList[e]
  local e=((n or a)or t)or e
  return e
end
function this.IsRescueTarget(e)
  local e=mvars.ene_rescueTargetList and mvars.ene_rescueTargetList[e]
  return e
end
function this.IsChildTarget(e)
  local e=mvars.ene_childTargetList and mvars.ene_childTargetList[e]
  return e
end
function this.IsChildHostage(e)
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  local e=GameObject.SendCommand(e,{id="IsChild"})
  return e
end
function this.IsFemaleHostage(e)
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  local e=GameObject.SendCommand(e,{id="isFemale"})
  return e
end
function this.AddTakingOverHostage(t)
  local a=GameObject.GetTypeIndex(t)
  if(a~=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2)then
    return
  end
  if this.IsRecovered(t)then
    return
  end
  if TppHelicopter.IsInHelicopter(t)then
    return
  end
  if mvars.ene_ignoreTakingOverHostage and mvars.ene_ignoreTakingOverHostage[t]then
    return
  end
  if this.IsRescueTarget(t)then
    return
  end
  local n=SendCommand(t,{id="GetMarkerEnabled"})
  if n then
    this._AddTakingOverHostage(t)
  end
end
function this._AddTakingOverHostage(t)
  if gvars.ene_takingOverHostageCount>=TppDefine.MAX_TAKING_OVER_HOSTAGE_COUNT then
    return
  end
  local e=gvars.ene_takingOverHostageCount
  local a=SendCommand(t,{id="GetPosition"})
  local i,r=SendCommand(t,{id="GetStaffId",divided=true})
  local o=SendCommand(t,{id="GetFaceId"})
  local n=SendCommand(t,{id="GetKeepFlagValue"})
  gvars.ene_takingOverHostagePositions[e*3+0]=a:GetX()
  gvars.ene_takingOverHostagePositions[e*3+1]=a:GetY()
  gvars.ene_takingOverHostagePositions[e*3+2]=a:GetZ()
  gvars.ene_takingOverHostageStaffIdsUpper[e]=i
  gvars.ene_takingOverHostageStaffIdsLower[e]=r
  gvars.ene_takingOverHostageFaceIds[e]=o
  gvars.ene_takingOverHostageFlags[e]=n
  gvars.ene_takingOverHostageCount=gvars.ene_takingOverHostageCount+1
end
function this.IsNeedHostageTakingOver(e)
  if TppMission.IsSysMissionId(vars.missionCode)then
    return false
  end
  if TppMission.IsHelicopterSpace(e)then
    return false
  end
  if(TppLocation.IsAfghan()or TppLocation.IsMiddleAfrica())then
    return true
  else
    return false
  end
end
function this.ResetTakingOverHostageInfo()
  gvars.ene_takingOverHostageCount=0
  for e=0,TppDefine.MAX_TAKING_OVER_HOSTAGE_COUNT-1 do
    for n=0,2 do
      gvars.ene_takingOverHostagePositions[e*3+n]=0
    end
    gvars.ene_takingOverHostageStaffIdsUpper[e]=0
    gvars.ene_takingOverHostageStaffIdsLower[e]=0
    gvars.ene_takingOverHostageFaceIds[e]=0
    gvars.ene_takingOverHostageFlags[e]=0
  end
end
function this.SpawnTakingOverHostage(n)
  if not IsTypeTable(n)then
    return
  end
  for n,t in ipairs(n)do
    this._SpawnTakingOverHostage(n-1,t)
  end
end
function this._SpawnTakingOverHostage(t,e)
  local e=GetGameObjectId(e)
  if e==NULL_ID then
    return
  end
  if t<gvars.ene_takingOverHostageCount then
    local i=gvars.ene_takingOverHostageStaffIdsUpper[infoIndex]
    local a=gvars.ene_takingOverHostageStaffIdsLower[infoIndex]SendCommand(e,{id="SetStaffId",divided=true,staffId=i,staffId2=a})
    if TppMission.IsMissionStart()then
      SendCommand(e,{id="SetEnabled",enabled=true})
      local a=Vector3(gvars.ene_takingOverHostagePositions[t*3],gvars.ene_takingOverHostagePositions[t*3+1],gvars.ene_takingOverHostagePositions[t*3+2])SendCommand(e,{id="Warp",position=a})SendCommand(e,{id="SetFaceId",faceId=gvars.ene_takingOverHostageFaceIds[t]})SendCommand(e,{id="SetKeepFlagValue",keepFlagValue=gvars.ene_takingOverHostageFlags[t]})
    end
  else
    SendCommand(e,{id="SetEnabled",enabled=false})
  end
end
function this.SetIgnoreTakingOverHostage(e)
  if not IsTypeTable(e)then
    return
  end
  mvars.ene_ignoreTakingOverHostage=mvars.ene_ignoreTakingOverHostage or{}
  for n,e in ipairs(e)do
    local e=GetGameObjectId(e)
    if e~=NULL_ID then
      mvars.ene_ignoreTakingOverHostage[e]=true
    else
      return
    end
  end
end
function this.SetIgnoreDisableNpc(e,i)
  local t
  if IsTypeNumber(e)then
    t=e
  elseif IsTypeString(e)then
    t=GetGameObjectId(e)
  else
    return
  end
  if t==NULL_ID then
    return
  end
  SendCommand(t,{id="SetIgnoreDisableNpc",enable=i})
  return true
end
function this.NPCEntryPointSetting(e)
  local e=e[gvars.heli_missionStartRoute]
  if not e then
    return
  end
  for e,n in pairs(e)do
    local t,n=n[1],n[2]
    TppBuddyService.SetMissionEntryPosition(e,t)
    TppBuddyService.SetMissionEntryRotationY(e,n)
  end
end
function this.SetupQuestEnemy()
  local t="quest_cp"
  local n="gt_quest_0000"
  if mvars.ene_soldierDefine.quest_cp==nil then
    return
  end
  for n,e in ipairs(mvars.ene_soldierDefine.quest_cp)do
    local e=GameObject.GetGameObjectId("TppSoldier2",e)
    if e~=NULL_ID then
      GameObject.SendCommand(e,{id="SetEnabled",enabled=false})
    end
  end
  TppCombatLocatorProvider.RegisterCombatLocatorSetToCpforLua{cpName=t,locatorSetName=n}
end
function this.OnAllocateQuest(e,n,a)
  local function i(t,n)
    local e="SetNone"if IsTypeTable(n)and IsTypeTable(t)then
      TppSoldierFace.SetAndConvertExtendFova{face=n,body=t}e="SetFaceAndBody"elseif IsTypeTable(n)then
      TppSoldierFace.SetAndConvertExtendFova{face=n}e="SetFace"elseif IsTypeTable(t)then
      TppSoldierFace.SetAndConvertExtendFova{body=t}e="SetBody"end
    return e
  end
  if n==nil and e==nil then
    return
  end
  a=a or false
  if a==false then
    local t
    local a=i(e,n)
    if a=="SetFaceAndBody"then
      t={id="InitializeAndAllocateExtendFova",face=n,body=e}
    elseif a=="SetFace"then
      t={id="InitializeAndAllocateExtendFova",face=n}
    elseif a=="SetBody"then
      t={id="InitializeAndAllocateExtendFova",body=e}
    end
    GameObject.SendCommand({type="TppSoldier2"},t)
    GameObject.SendCommand({type="TppCorpse"},t)
  else
    if e then
      local n={}
      for t,e in ipairs(e)do
        local t=e[1]
        if IsTypeNumber(t)then
          table.insert(n,e[1])
        end
      end
      TppSoldierFace.SetBodyFovaUserType{hostage=hostageBodyTable}
    end
    local t=i(e,n)
    if t=="SetFaceAndBody"then
      TppSoldierFace.ReserveExtendFovaForHostage{face=n,body=e}
    elseif t=="SetFace"then
      TppSoldierFace.ReserveExtendFovaForHostage{face=n}
    elseif t=="SetBody"then
      TppSoldierFace.ReserveExtendFovaForHostage{body=e}
    end
  end
end
function this.OnAllocateQuestFova(n)
  local t={}
  local a={}
  local o=false
  local s=false
  local p=false
  local d=false
  mvars.ene_questArmorId=0
  mvars.ene_questBalaclavaId=0
  if n.isQuestBalaclava==true then
    local e={}
    if TppLocation.IsAfghan()then
      mvars.ene_questBalaclavaId=TppDefine.QUEST_FACE_ID_LIST.AFGH_BALACLAVA
    elseif TppLocation.IsMiddleAfrica()then
      mvars.ene_questBalaclavaId=TppDefine.QUEST_FACE_ID_LIST.MAFR_BALACLAVA
    end
    mvars.ene_questGetLoadedFaceTable=TppSoldierFace.GetLoadedFaceTable{}
    if mvars.ene_questGetLoadedFaceTable~=nil then
      local n=#mvars.ene_questGetLoadedFaceTable
      if mvars.ene_questBalaclavaId~=0 and n>0 then
        e={mvars.ene_questBalaclavaId,TppDefine.QUEST_ENEMY_MAX,0}table.insert(t,e)s=true
      end
    end
  end
  if n.isQuestArmor==true then
    local e={}
    if TppLocation.IsAfghan()then
      mvars.ene_questArmorId=TppDefine.QUEST_BODY_ID_LIST.AFGH_ARMOR
    elseif TppLocation.IsMiddleAfrica()then
      if n.soldierSubType=="PF_A"then
        mvars.ene_questArmorId=TppDefine.QUEST_BODY_ID_LIST.MAFR_ARMOR_CFA
      elseif n.soldierSubType=="PF_B"then
        mvars.ene_questArmorId=TppDefine.QUEST_BODY_ID_LIST.MAFR_ARMOR_ZRS
      elseif n.soldierSubType=="PF_C"then
        mvars.ene_questArmorId=TppDefine.QUEST_BODY_ID_LIST.MAFR_ARMOR_RC
      end
    end
    if mvars.ene_questArmorId~=0 then
      e={mvars.ene_questArmorId,TppDefine.QUEST_ENEMY_MAX,0}table.insert(a,e)o=true
    end
  end
  if(n.enemyList and Tpp.IsTypeTable(n.enemyList))and next(n.enemyList)then
    for n,e in pairs(n.enemyList)do
      if e.enemyName then
        if e.bodyId then
          local n=1
          local e={e.bodyId,n,0}table.insert(a,e)o=true
        end
        if e.faceId then
          local n=1
          local e={e.faceId,n,0}table.insert(t,e)s=true
        end
      end
    end
  end
  if(n.hostageList and Tpp.IsTypeTable(n.hostageList))and next(n.hostageList)then
    for n,e in pairs(n.hostageList)do
      if e.hostageName then
        if e.bodyId then
          local n=1
          local e={e.bodyId,0,n}table.insert(a,e)p=true
        end
        if e.faceId then
          local n=1
          local e={e.faceId,0,n}table.insert(t,e)d=true
        end
        if e.isFaceRandom then
          local e=TppQuest.GetRandomFaceId()
          if e then
            local n=1
            local e={e,0,n}table.insert(t,e)d=true
          end
        end
      end
    end
  end
  if p==true then
    local t={}
    local e=false
    for a,n in ipairs(a)do
      if n[3]>=1 then
        local n=n[1]
        if IsTypeNumber(n)then
          table.insert(t,n)e=true
        end
      end
    end
    if e==true then
      TppSoldierFace.SetBodyFovaUserType{hostage=hostageBodyTable}
    end
  end
  local i="SetNone"if((o==true or s==true)or p==true)or d==true then
    local e=o or p
    local n=s or d
    if e==true and n==true then
      TppSoldierFace.SetAndConvertExtendFova{face=t,body=a}i="SetFaceAndBody"elseif n==true then
      TppSoldierFace.SetAndConvertExtendFova{face=t}i="SetFace"elseif e==true then
      TppSoldierFace.SetAndConvertExtendFova{body=a}i="SetBody"end
  end
  local r
  if o==true or s==true then
    if i=="SetFaceAndBody"then
      r={id="InitializeAndAllocateExtendFova",face=t,body=a}
    elseif i=="SetFace"then
      r={id="InitializeAndAllocateExtendFova",face=t}
    elseif i=="SetBody"then
      r={id="InitializeAndAllocateExtendFova",body=a}
    end
    if r then
      GameObject.SendCommand({type="TppSoldier2"},r)
      GameObject.SendCommand({type="TppCorpse"},r)
    end
  end
  if p==true or d==true then
    if i=="SetFaceAndBody"then
      TppSoldierFace.ReserveExtendFovaForHostage{face=t,body=a}
    elseif i=="SetFace"then
      TppSoldierFace.ReserveExtendFovaForHostage{face=t}
    elseif i=="SetBody"then
      TppSoldierFace.ReserveExtendFovaForHostage{body=a}
    end
  end
  local n=n.heliList
  if(n and Tpp.IsTypeTable(n))and next(n)then
    this.LoadQuestHeli(n[1].coloringType)
  end
end
function this.OnActivateQuest(n)
  if n==nil then
    return
  end
  if mvars.ene_isQuestSetup==false then
    mvars.ene_questTargetList={}
    mvars.ene_questVehicleList={}
  end
  local t=false
  if(n.targetList and Tpp.IsTypeTable(n.targetList))and next(n.targetList)then
    this.SetupActivateQuestTarget(n.targetList)t=true
  end
  if(n.vehicleList and Tpp.IsTypeTable(n.vehicleList))and next(n.vehicleList)then
    this.SetupActivateQuestVehicle(n.vehicleList,n.targetList)t=true
  end
  if(n.heliList and Tpp.IsTypeTable(n.heliList))and next(n.heliList)then
    this.SetupActivateQuestHeli(n.heliList)t=true
  end
  if(n.cpList and Tpp.IsTypeTable(n.cpList))and next(n.cpList)then
    this.SetupActivateQuestCp(n.cpList)t=true
  end
  if(n.enemyList and Tpp.IsTypeTable(n.enemyList))and next(n.enemyList)then
    this.SetupActivateQuestEnemy(n.enemyList)t=true
  end
  if n.isQuestZombie==true then
    local e={type="TppSoldier2"}
    GameObject.SendCommand(e,{id="RegistSwarmEffect"})t=true
  end
  if(n.hostageList and Tpp.IsTypeTable(n.hostageList))and next(n.hostageList)then
    this.SetupActivateQuestHostage(n.hostageList)t=true
  end
  if t==true then
    mvars.ene_isQuestSetup=true
  end
end
function this.SetupActivateQuestTarget(n)
  if mvars.ene_isQuestSetup==false then
    for n,t in pairs(n)do
      local n=t
      if IsTypeString(n)then
        n=GameObject.GetGameObjectId(n)
      end
      if n==NULL_ID then
      else
        this.SetQuestEnemy(n,true)
        TppMarker.SetQuestMarker(t)
      end
    end
  end
end
function this.SetupActivateQuestVehicle(n,t)
  if mvars.ene_isQuestSetup==false then
    mvars.ene_questVehicleList={}
    this.SpawnVehicles(n)
    for a,n in ipairs(n)do
      if n.locator then
        local e={id="Despawn",locator=n.locator}table.insert(mvars.ene_questVehicleList,e)
      end
      for a,t in ipairs(t)do
        if n.locator==t then
          this.SetQuestEnemy(n.locator,true)
          TppMarker.SetQuestMarker(n.locator)
        else
          this.SetQuestEnemy(n.locator,false)
        end
      end
    end
  end
end
function this.SetupActivateQuestHeli(r)
  if mvars.ene_isQuestSetup==false then
    if not this.IsQuestHeli()then
      return
    end
    local t=false
    for n,i in ipairs(r)do
      if i.routeName then
        local n=GameObject.GetGameObjectId(TppReinforceBlock.REINFORCE_HELI_NAME)
        if n==NULL_ID then
        else
          GameObject.SendCommand(n,{id="RequestRoute",route=i.routeName})
          GameObject.SendCommand(n,{id="DisablePullOut"})t=true
          this.SetQuestEnemy(n,false)
        end
      end
    end
    if t==true then
      this.ActivateQuestHeli(r.coloringType)
    end
  end
end
function this.SetupActivateQuestCp(e)
  if mvars.ene_isQuestSetup==false then
    for n,e in pairs(e)do
      if not e.cpName then
      else
        local n=e.cpName
        if IsTypeString(n)then
          n=GameObject.GetGameObjectId(n)
        end
        if n==NULL_ID then
        else
          if e.isNormalCp==true then
            GameObject.SendCommand(n,{id="SetNormalCp"})
          end
          if e.isOuterBaseCp==true then
            GameObject.SendCommand(n,{id="SetOuterBaseCp"})
          end
          if e.isMarchCp==true then
            GameObject.SendCommand(n,{id="SetMarchCp"})
          end
          if((e.cpPosition_x and e.cpPosition_y)and e.cpPosition_z)and e.cpPosition_r then
            GameObject.SendCommand(n,{id="SetCpPosition",x=e.cpPosition_x,y=e.cpPosition_y,z=e.cpPosition_z,r=e.cpPosition_r})
          end
          if e.gtName then
            if((not e.gtPosition_x or not e.gtPosition_y)or not e.gtPosition_z)or not e.gtPosition_r then
            end
            local r={type="TppCommandPost2"}
            local i=e.gtPosition_x or e.cpPosition_x
            local n=e.gtPosition_y or e.cpPosition_y
            local t=e.gtPosition_z or e.cpPosition_z
            local a=e.gtPosition_r or e.cpPosition_r
            GameObject.SendCommand(r,{id="SetLocatorPosition",name=e.gtName,x=i,y=n,z=t,r=a})
          end
        end
      end
    end
  end
end
function this.SetupActivateQuestEnemy(p)
  local i=1
  local function s(n,r)
    local soldierId=n.enemyName
    if IsTypeString(soldierId)then
      soldierId=GameObject.GetGameObjectId(soldierId)
    end
    if soldierId==NULL_ID then
    else
      if r==false then
        if mvars.ene_isQuestSetup==false then
          if n.soldierType then
            this.SetSoldierType(soldierId,n.soldierType)
          end
          if n.soldierSubType then
            this.SetSoldierSubType(soldierId,n.soldierSubType)
          else
            if TppLocation.IsMiddleAfrica()then
            end
          end
          local a=true
          if n.powerSetting then
            for n,e in ipairs(n.powerSetting)do
              if e=="QUEST_ARMOR"then
                if mvars.ene_questArmorId==0 then
                  a=false
                end
              end
            end
          end
          if a==true then
            local loadout=n.powerSetting or{nil}
            this.ApplyPowerSetting(soldierId,loadout)
          else
            this.ApplyPowerSetting(soldierId,{nil})
          end
          if n.cpName then
            GameObject.SendCommand(soldierId,{id="SetCommandPost",cp=n.cpName})
          end
          if(n.staffTypeId or n.skill)or n.uniqueTypeId then
            local a=n.staffTypeId or TppDefine.STAFF_TYPE_ID.NORMAL
            local e=n.skill or false
            local n=n.uniqueTypeId or false
            if e==false and n==false then
              TppMotherBaseManagement.RegenerateGameObjectStaffParameter{gameObjectId=soldierId,staffTypeId=a}
            elseif e~=false and IsTypeString(e)then
              TppMotherBaseManagement.RegenerateGameObjectStaffParameter{gameObjectId=soldierId,staffTypeId=a,skill=e}
            elseif n~=false then
              TppMotherBaseManagement.RegenerateGameObjectStaffParameter{gameObjectId=soldierId,staffType="Unique",uniqueTypeId=n}
            end
          else
            if mvars.ene_questTargetList[soldierId]then
              TppMotherBaseManagement.RegenerateGameObjectQuestStaffParameter{gameObjectId=soldierId}
            end
          end
          if n.voiceType then
            if((n.voiceType=="ene_a"or n.voiceType=="ene_b")or n.voiceType=="ene_c")or n.voiceType=="ene_d"then
              GameObject.SendCommand(soldierId,{id="SetVoiceType",voiceType=n.voiceType})
            end
          else
            local e={"ene_a","ene_b","ene_c","ene_d"}
            local n=math.random(4)
            local e=e[n]
            GameObject.SendCommand(soldierId,{id="SetVoiceType",voiceType=e})
          end
        end
        if n.bodyId or n.faceId then
          local e=n.faceId or false
          local n=n.bodyId or false
          if IsTypeNumber(n)and IsTypeNumber(e)then
            GameObject.SendCommand(soldierId,{id="ChangeFova",bodyId=n,faceId=e})
          elseif IsTypeNumber(e)then
            GameObject.SendCommand(soldierId,{id="ChangeFova",faceId=e})
          elseif IsTypeNumber(n)then
            GameObject.SendCommand(soldierId,{id="ChangeFova",bodyId=n})
          end
        end
        if n.isBalaclava==true then
          if mvars.ene_questGetLoadedFaceTable~=nil then
            local e=mvars.ene_questGetLoadedFaceTable
            local e=#mvars.ene_questGetLoadedFaceTable
            if e>0 and mvars.ene_questBalaclavaId~=0 then
              local e=mvars.ene_questGetLoadedFaceTable[i]
              if mvars.ene_questGetLoadedFaceTable[i+1]then
                i=i+1
              else
                i=1
              end
              if n.soldierSubType=="PF_A"or n.soldierSubType=="PF_C"then
                GameObject.SendCommand(soldierId,{id="ChangeFova",isScarf=true})
              else
                GameObject.SendCommand(soldierId,{id="ChangeFova",balaclavaFaceId=mvars.ene_questBalaclavaId,faceId=e})
              end
            end
          end
        end
        if mvars.ene_isQuestSetup==false then
          if n.route_d then
            this.SetSneakRoute(soldierId,n.route_d)
          end
          if n.route_c then
            this.SetCautionRoute(soldierId,n.route_c)
          end
          if n.route_a then
            this.SetAlertRoute(soldierId,n.route_a)
          end
          if n.rideFromVehicleId then
            local e=n.rideFromVehicleId
            if IsTypeString(e)then
              e=GameObject.GetGameObjectId(e)
            end
            GameObject.SendCommand(soldierId,{id="SetRelativeVehicle",targetId=e,rideFromBeginning=true})
          end
          if n.isZombie then
            GameObject.SendCommand(soldierId,{id="SetZombie",enabled=true,isMsf=false,isZombieSkin=true,isHagure=true})
          end
          if n.isMsf then
            GameObject.SendCommand(soldierId,{id="SetZombie",enabled=true,isMsf=true})
          end
          if n.isZombieUseRoute then
            GameObject.SendCommand(soldierId,{id="SetZombieUseRoute",enabled=true})
          end
          if n.isBalaclava==true then
            GameObject.SendCommand(soldierId,{id="SetSoldier2Flag",flag="highRank",on=true})
          end
          GameObject.SendCommand(soldierId,{id="SetEnabled",enabled=true})
          this.SetQuestEnemy(soldierId,false)
        end
      else
        local e=n.isDisable or false
        if e==true then
          GameObject.SendCommand(soldierId,{id="SetEnabled",enabled=false})
        end
      end
    end
  end
  for n,e in pairs(p)do
    if e.enemyName then
      s(e,false)
    elseif e.setCp then
      local n=GetGameObjectId(e.setCp)
      if n==NULL_ID then
      else
        local n=nil
        for a,t in pairs(mvars.ene_cpList)do
          if t==e.setCp then
            n=a
          end
        end
        if n then
          for n,t in pairs(mvars.ene_soldierIDList[n])do
            local e={enemyName=n,isDisable=e.isDisable}s(e,true)
          end
        end
      end
    end
  end
end
function this.SetupActivateQuestHostage(n)
  local r=TppLocation.IsAfghan()
  local i=TppLocation.IsMiddleAfrica()
  for t,n in pairs(n)do
    if n.hostageName then
      local t=n.hostageName
      if IsTypeString(t)then
        t=GameObject.GetGameObjectId(t)
      end
      if t==NULL_ID then
      else
        if mvars.ene_isQuestSetup==false then
          if(n.staffTypeId or n.skill)or n.uniqueTypeId then
            local a=n.staffTypeId or TppDefine.STAFF_TYPE_ID.NORMAL
            local e=n.skill or false
            local n=n.uniqueTypeId or false
            if e==false and n==false then
              TppMotherBaseManagement.RegenerateGameObjectStaffParameter{gameObjectId=t,staffTypeId=a}
            elseif e~=false and IsTypeString(e)then
              TppMotherBaseManagement.RegenerateGameObjectStaffParameter{gameObjectId=t,staffTypeId=a,skill=e}
            elseif n~=false then
              TppMotherBaseManagement.RegenerateGameObjectStaffParameter{gameObjectId=t,staffType="Unique",uniqueTypeId=n}
            end
          else
            if mvars.ene_questTargetList[t]then
              TppMotherBaseManagement.RegenerateGameObjectQuestStaffParameter{gameObjectId=t}
            end
          end
          if n.voiceType then
            if IsTypeTable(n.voiceType)then
              local e=#n.voiceType
              local e=math.random(e)
              local e=n.voiceType[e]
              if((e=="hostage_a"or e=="hostage_b")or e=="hostage_c")or e=="hostage_d"then
                GameObject.SendCommand(t,{id="SetVoiceType",voiceType=e})
              end
            else
              local e=n.voiceType
              if((e=="hostage_a"or e=="hostage_b")or e=="hostage_c")or e=="hostage_d"then
                GameObject.SendCommand(t,{id="SetVoiceType",voiceType=e})
              end
            end
          else
            local e={"hostage_a","hostage_b","hostage_c","hostage_d"}
            local n=math.random(4)
            local e=e[n]
            GameObject.SendCommand(t,{id="SetVoiceType",voiceType=e})
          end
          if n.langType then
            GameObject.SendCommand(t,{id="SetLangType",langType=n.langType})
          else
            if this.IsFemaleHostage(t)==false then
              if r==true then
                GameObject.SendCommand(t,{id="SetLangType",langType="russian"})
              elseif i==true then
                GameObject.SendCommand(t,{id="SetLangType",langType="afrikaans"})
              end
            else
              GameObject.SendCommand(t,{id="SetLangType",langType="english"})
            end
          end
          if n.path then
            GameObject.SendCommand(t,{id="SpecialAction",action="PlayMotion",path=n.path,autoFinish=false,enableMessage=true,commandId=Fox.StrCode32"CommandA",enableGravity=false,enableCollision=false})
          end
          this.SetQuestEnemy(t,false)
        end
        if(n.bodyId or n.faceId)or n.isFaceRandom then
          local e=n.faceId or false
          local a=n.bodyId or false
          if n.isFaceRandom then
            e=TppQuest.GetRandomFaceId()
          end
          if IsTypeNumber(a)and IsTypeNumber(e)then
            GameObject.SendCommand(t,{id="ChangeFova",bodyId=a,faceId=e})
          elseif IsTypeNumber(e)then
            GameObject.SendCommand(t,{id="ChangeFova",faceId=e})
          elseif IsTypeNumber(a)then
            GameObject.SendCommand(t,{id="ChangeFova",bodyId=a})
          end
        end
      end
    end
  end
end
function this.OnDeactivateQuest(n)
  if mvars.ene_isQuestSetup==true then
    if(n.vehicleList and Tpp.IsTypeTable(n.vehicleList))and next(n.vehicleList)then
      this.SetupDeactivateQuestVehicle(n.vehicleList)
    end
    if(n.heliList and Tpp.IsTypeTable(n.heliList))and next(n.heliList)then
      this.SetupDeactivateQuestQuestHeli(n.heliList)
    end
    if(n.cpList and Tpp.IsTypeTable(n.cpList))and next(n.cpList)then
      this.SetupDeactivateQuestCp(n.cpList)
    end
    if n.isQuestZombie==true then
      local e={type="TppSoldier2"}
      GameObject.SendCommand(e,{id="UnregistSwarmEffect"})
    end
    if(n.enemyList and Tpp.IsTypeTable(n.enemyList))and next(n.enemyList)then
      this.SetupDeactivateQuestEnemy(n.enemyList)
    end
    if(n.hostageList and Tpp.IsTypeTable(n.hostageList))and next(n.hostageList)then
      this.SetupDeactivateQuestHostage(n.hostageList)
    end
    if not mvars.qst_isMissionEnd then
      local e=this.CheckQuestAllTarget(n.questType,nil,nil,true)
      TppQuest.ClearWithSave(e)
    end
  end
end
function this.SetupDeactivateQuestVehicle(e)
end
function this.SetupDeactivateQuestQuestHeli(e)
end
function this.SetupDeactivateQuestCp(e)
end
function this.SetupDeactivateQuestEnemy(n)
  for n,t in pairs(n)do
    if t.enemyName then
      local n=t.enemyName
      if IsTypeString(n)then
        n=GameObject.GetGameObjectId(n)
      end
      if n==NULL_ID then
      else
        local a={type="TppCorpse"}
        if this.CheckQuestDistance(n)then
          if TppMission.CheckMissionState(true,false,true,false)then
            this.AutoFultonRecoverNeutralizedTarget(n,true)
          end
        end
        if t.bodyId or t.faceId then
          local e={id="ChangeFova",faceId=EnemyFova.INVALID_FOVA_VALUE,bodyId=EnemyFova.INVALID_FOVA_VALUE}
          GameObject.SendCommand(n,e)
          local e={id="ChangeFovaCorpse",name=t.enemyName,faceId=EnemyFova.INVALID_FOVA_VALUE,bodyId=EnemyFova.INVALID_FOVA_VALUE}
          GameObject.SendCommand(a,e)
        end
        if this.CheckQuestDistance(n)then
          if TppMission.CheckMissionState(true,false,true,false)then
            GameObject.SendCommand(n,{id="RequestVanish"})
            GameObject.SendCommand(a,{id="RequestDisableWithFadeout",name=t.enemyName})
          end
        end
      end
    elseif t.setCp then
    end
  end
end
function this.SetupDeactivateQuestHostage(n)
  for n,t in pairs(n)do
    if t.hostageName then
      local n=t.hostageName
      if IsTypeString(n)then
        n=GameObject.GetGameObjectId(n)
      end
      if n==NULL_ID then
      else
        if this.CheckQuestDistance(n)then
          if TppMission.CheckMissionState(true,false,true,false)then
            local e=TppMotherBaseManagement.GetStaffIdFromGameObject{gameObjectId=n}
            TppTerminal.OnFulton(n,nil,nil,e,nil,true)
          end
        end
        if t.bodyId or t.faceId then
          local e={id="ChangeFova",faceId=EnemyFova.INVALID_FOVA_VALUE,bodyId=EnemyFova.INVALID_FOVA_VALUE}
          GameObject.SendCommand(n,e)
        end
        if this.CheckQuestDistance(n)then
          if TppMission.CheckMissionState(true,false,true,false)then
            GameObject.SendCommand(n,{id="RequestVanish"})
          end
        end
      end
    end
  end
end
function this.OnTerminateQuest(n)
  if mvars.ene_isQuestSetup==true then
    if(n.vehicleList and Tpp.IsTypeTable(n.vehicleList))and next(n.vehicleList)then
      this.SetupTerminateQuestVehicle(n.vehicleList)
    end
    if(n.heliList and Tpp.IsTypeTable(n.heliList))and next(n.heliList)then
      this.SetupTerminateQuestHeli(n.heliList)
    end
    if(n.cpList and Tpp.IsTypeTable(n.cpList))and next(n.cpList)then
      this.SetupTerminateQuestCp(n.cpList)
    end
    if n.isQuestZombie==true then
      local e={type="TppSoldier2"}
      GameObject.SendCommand(e,{id="UnregistSwarmEffect"})
    end
    if(n.enemyList and Tpp.IsTypeTable(n.enemyList))and next(n.enemyList)then
      if GameObject.GetGameObjectIdByIndex("TppSoldier2",0)~=NULL_ID then
        this.SetupTerminateQuestEnemy(n.enemyList)
      end
    end
    if(n.hostageList and Tpp.IsTypeTable(n.hostageList))and next(n.hostageList)then
      this.SetupTerminateQuestHostage(n.hostageList)
    end
  end
  if GameObject.GetGameObjectIdByIndex("TppSoldier2",0)~=NULL_ID then
    local e={type="TppSoldier2"}
    GameObject.SendCommand(e,{id="FreeExtendFova"})
  end
  if GameObject.GetGameObjectIdByIndex("TppCorpse",0)~=NULL_ID then
    local e={type="TppCorpse"}
    GameObject.SendCommand(e,{id="FreeExtendFova"})
  end
  TppSoldierFace.ClearExtendFova()
  TppSoldierFace.ReserveExtendFovaForHostage{}
  mvars.ene_questTargetList={}
  mvars.ene_questVehicleList={}
  mvars.ene_isQuestSetup=false
end
function this.SetupTerminateQuestVehicle(n)
  this.DespawnVehicles(mvars.ene_questVehicleList)
end
function this.SetupTerminateQuestHeli(n)
  this.DeactivateQuestHeli()
  this.UnloadQuestHeli()
end
function this.SetupTerminateQuestCp(e)
end
function this.SetupTerminateQuestEnemy(i)
  local isAfghan=TppLocation.IsAfghan()
  local isMiddleAfrica=TppLocation.IsMiddleAfrica()
  local function t(n,t)
    local gameId=n.enemyName
    if IsTypeString(gameId)then
      gameId=GameObject.GetGameObjectId(gameId)
    end
    if gameId==NULL_ID then
    else
      if t==false then
        local t={type="TppCorpse"}
        GameObject.SendCommand(gameId,{id="SetEnabled",enabled=false})
        GameObject.SendCommand(gameId,{id="SetCommandPost",cp="quest_cp"})
        GameObject.SendCommand(gameId,{id="SetZombie",enabled=false,isMsf=false,isZombieSkin=true,isHagure=false})
        GameObject.SendCommand(gameId,{id="SetZombieUseRoute",enabled=false})
        GameObject.SendCommand(gameId,{id="SetEverDown",enabled=false})
        GameObject.SendCommand(gameId,{id="SetSoldier2Flag",flag="highRank",on=false})
        GameObject.SendCommand(gameId,{id="Refresh"})
        GameObject.SendCommand(t,{id="RequestVanish",name=n.enemyName})
        if n.powerSetting then
          for i,a in ipairs(n.powerSetting)do
            if a=="QUEST_ARMOR"then
              local a={id="ChangeFova",faceId=EnemyFova.INVALID_FOVA_VALUE,bodyId=EnemyFova.INVALID_FOVA_VALUE}
              GameObject.SendCommand(gameId,a)
              local e={id="ChangeFovaCorpse",name=n.enemyName,faceId=EnemyFova.INVALID_FOVA_VALUE,bodyId=EnemyFova.INVALID_FOVA_VALUE}
              GameObject.SendCommand(t,e)
            end
          end
        end
        if isAfghan==true then
          GameObject.SendCommand(gameId,{id="SetSoldier2Type",type=EnemyType.TYPE_SOVIET})
        elseif isMiddleAfrica==true then
          GameObject.SendCommand(gameId,{id="SetSoldier2Type",type=EnemyType.TYPE_PF})
        end
      else
        local n=n.isDisable or false
        if n==true then
          GameObject.SendCommand(gameId,{id="SetEnabled",enabled=true})
        end
      end
    end
  end
  for n,e in pairs(i)do
    if e.enemyName then
      t(e,false)
      TppUiCommand.UnRegisterIconUniqueInformation(GameObject.GetGameObjectId(e.enemyName))
    elseif e.setCp then
      local n=GetGameObjectId(e.setCp)
      if n==NULL_ID then
      else
        local n=nil
        for a,t in pairs(mvars.ene_cpList)do
          if t==e.setCp then
            n=a
          end
        end
        if n then
          for n,a in pairs(mvars.ene_soldierIDList[n])do
            local e={enemyName=n,isZombie=e.isZombie,isMsf=e.isMsf,isDisable=e.isDisable}
            t(e,true)
          end
        end
      end
    end
  end
end
function this.SetupTerminateQuestHostage(e)
end
function this.CheckQuestDistance(e)
  if Tpp.IsSoldier(e)or Tpp.IsHostage(e)then
    local t=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
    local n=10
    local n=n*n
    if IsWithinDistSqr(n,t,e)then
      return true
    end
  end
  return false
end
function this.CheckQuestNpcLifeStatus(e)
  if e~=nil then
    local e=GameObject.SendCommand(e,{id="GetLifeStatus"})
    if e==TppGameObject.NPC_LIFE_STATE_DEAD then
      return false
    else
      return true
    end
  end
end
function this.IsQuestInHelicopter()
  TppHelicopter.SetNewestPassengerTable()
  for e,n in pairs(mvars.ene_questTargetList)do
    if TppHelicopter.IsInHelicopter(e)then
      return true
    end
  end
  return false
end
function this.IsQuestInHelicopterGameObjectId(n)
  TppHelicopter.SetNewestPassengerTable()
  for e,t in pairs(mvars.ene_questTargetList)do
    if TppHelicopter.IsInHelicopter(e)then
      if e==n then
        return true
      end
    end
  end
  return false
end
function this.IsQuestTarget(e)
  if mvars.ene_isQuestSetup==false then
    return false
  end
  if not next(mvars.ene_questTargetList)then
    return false
  end
  for n,t in pairs(mvars.ene_questTargetList)do
    if t.isTarget==true then
      if e==n then
        return true
      end
    end
  end
  return false
end
function this.IsQuestNpc(n)
  for e,t in pairs(mvars.ene_questTargetList)do
    if n==e then
      return true
    end
  end
  return false
end
function this.GetQuestCount()
  local e=0
  local n=0
  for a,t in pairs(mvars.ene_questTargetList)do
    if t.isTarget==true then
      e=e+1
      if t.messageId~="None"then
        n=n+1
      end
    end
  end
  return n,e
end
function this.SetQuestEnemy(e,n)
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  if e==NULL_ID then
  end
  if not mvars.ene_questTargetList[e]then
    local n={messageId="None",isTarget=n}
    mvars.ene_questTargetList[e]=n
  end
end
function this.CheckDeactiveQuestAreaForceFulton()
  if mvars.ene_isQuestSetup==false then
    return
  end
  if not next(mvars.ene_questTargetList)then
    return
  end
  for n,t in pairs(mvars.ene_questTargetList)do
    if Tpp.IsSoldier(n)or Tpp.IsHostage(n)then
      if this.CheckQuestDistance(n)then
        if this.CheckQuestNpcLifeStatus(n)then
          GameObject.SendCommand(n,{id="RequestForceFulton"})
          TppRadio.Play"f1000_rtrg5140"TppSoundDaemon.PostEvent"sfx_s_rescue_pow"else
          GameObject.SendCommand(n,{id="RequestDisableWithFadeout"})
        end
      end
    end
  end
end
function this.CheckQuestAllTarget(T,f,u,t,a)
  local n=TppDefine.QUEST_CLEAR_TYPE.NONE
  local p=t or false
  local c=a or false
  local l=false
  local r=0
  local a=0
  local s=0
  local o=0
  local _=0
  local i=0
  local t=true
  local d=false
  local S=TppQuest.GetCurrentQuestName()
  if TppQuest.IsEnd(S)then
    return n
  end
  if mvars.ene_questTargetList[u]then
    local e=mvars.ene_questTargetList[u]
    if e.messageId~="None"and e.isTarget==true then
      d=true
    elseif e.isTarget==false then
      d=true
    end
    e.messageId=f or"None"l=true
  end
  if(p==false and c==false)and l==false then
    return n
  end
  for l,n in pairs(mvars.ene_questTargetList)do
    local d=false
    local T=n.isTarget or false
    if p==true then
      if Tpp.IsSoldier(l)or Tpp.IsHostage(l)then
        if this.CheckQuestDistance(l)then
          n.messageId="Fulton"a=a+1
          d=false
          t=true
        end
      end
    end
    if T==true then
      if d==false then
        local e=n.messageId
        if e~="None"then
          if e=="Fulton"then
            a=a+1
            t=true
          elseif e=="InHelicopter"then
            i=i+1
            t=true
          elseif e=="FultonFailed"then
            s=s+1
            t=true
          elseif(e=="Dead"or e=="VehicleBroken")or e=="LostControl"then
            o=o+1
            t=true
          elseif e=="Vanished"then
            _=_+1
            t=true
          end
        end
        if p==true then
          t=false
        end
      end
      r=r+1
    end
  end
  if d==true then
    t=false
  end
  if r>0 then
    if T==TppDefine.QUEST_TYPE.RECOVERED then
      if a+i>=r then
        n=TppDefine.QUEST_CLEAR_TYPE.CLEAR
      elseif s>0 or o>0 then
        n=TppDefine.QUEST_CLEAR_TYPE.FAILURE
      elseif a+i>0 then
        if t==true then
          n=TppDefine.QUEST_CLEAR_TYPE.UPDATE
        end
      end
    elseif T==TppDefine.QUEST_TYPE.ELIMINATE then
      if((a+s)+o)+i>=r then
        n=TppDefine.QUEST_CLEAR_TYPE.CLEAR
      elseif((a+s)+o)+i>0 then
        if t==true then
          n=TppDefine.QUEST_CLEAR_TYPE.UPDATE
        end
      end
    elseif T==TppDefine.QUEST_TYPE.MSF_RECOVERED then
      if a>=r or i>=r then
        n=TppDefine.QUEST_CLEAR_TYPE.CLEAR
      elseif(s>0 or o>0)or _>0 then
        n=TppDefine.QUEST_CLEAR_TYPE.FAILURE
      end
    end
  end
  if c==true then
    if n==TppDefine.QUEST_CLEAR_TYPE.NONE or n==TppDefine.QUEST_CLEAR_TYPE.UPDATE then
      n=TppDefine.QUEST_CLEAR_TYPE.NONE
    end
  end
  return n
end
function this.ReserveQuestHeli()
  local e=GetGameObjectId("TppCommandPost2",_)
  TppRevenge.SetEnabledSuperReinforce(false)
  mvars.ene_isQuestHeli=true
end
function this.UnreserveQuestHeli()
  local e=GetGameObjectId("TppCommandPost2",_)
  TppReinforceBlock.FinishReinforce(e)
  TppReinforceBlock.UnloadReinforceBlock(e)
  TppRevenge.SetEnabledSuperReinforce(true)
  mvars.ene_isQuestHeli=false
end
function this.LoadQuestHeli(n)
  local e=GetGameObjectId("TppCommandPost2",_)
  TppReinforceBlock.LoadReinforceBlock(TppReinforceBlock.REINFORCE_TYPE.HELI,e,n)
end
function this.UnloadQuestHeli()
  local e=GetGameObjectId("TppCommandPost2",_)
  TppReinforceBlock.UnloadReinforceBlock(e)
end
function this.ActivateQuestHeli(n)
  local e=GetGameObjectId("TppCommandPost2",_)
  if not TppReinforceBlock.IsLoaded()then
    TppReinforceBlock.LoadReinforceBlock(TppReinforceBlock.REINFORCE_TYPE.HELI,e,n)
  end
  TppReinforceBlock.StartReinforce(e)
end
function this.DeactivateQuestHeli()
  local e=GetGameObjectId("TppCommandPost2",_)
  TppReinforceBlock.FinishReinforce(e)
end
function this.IsQuestHeli()
  return mvars.ene_isQuestHeli
end
function this.GetDDSuit()
  if InfMain.IsMbPlayTime() then
    if gvars.mbDDSuit>0 then
      return gvars.mbDDSuit
    end
  end

  local fobEventIdArmor=TppDefine.FOB_EVENT_ID_LIST.ARMOR
  if TppMission.IsFOBMission(vars.missionCode) then--tex isolated whole thing for now RETRY:
  local eventId=TppServerManager.GetEventId()
  for a,id in ipairs(fobEventIdArmor)do
    if eventId==id then
      return this.FOB_PF_SUIT_ARMOR
    end
  end
  end
  local SNEAKING_SUIT=this.weaponIdTable.DD.NORMAL.SNEAKING_SUIT
  if SNEAKING_SUIT and SNEAKING_SUIT>0 then
    return this.FOB_DD_SUIT_SNEAKING
  end
  local BATTLE_DRESS=this.weaponIdTable.DD.NORMAL.BATTLE_DRESS
  if BATTLE_DRESS and BATTLE_DRESS>0 then
    return this.FOB_DD_SUIT_BTRDRS
  end
  return this.FOB_DD_SUIT_ATTCKER
  --]]
end
function this.IsHostageEventFOB()
  local eventHostage=TppDefine.FOB_EVENT_ID_LIST.HOSTAGE
  local eventId=TppServerManager.GetEventId()
  for t,id in ipairs(eventHostage)do
    if eventId==id then
      return true
    end
  end
  return false
end
function this._OnDead(gameId,a)
  local i
  if a then
    i=Tpp.IsPlayer(a)
  end
  local a=this.IsEliminateTarget(gameId)
  local r=this.IsRescueTarget(gameId)
  if i then
    if Tpp.IsHostage(gameId)then
      if this.IsChildHostage(gameId)then
        if TppMission.GetMissionID()~=10100 then
          TppMission.ReserveGameOverOnPlayerKillChild(gameId)
        end
      else
        if not a and not r then
          TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.HOSTAGE_DEAD)
        end
      end
    end
  end
  if Tpp.IsSoldier(gameId)then
    local soldierType=this.GetSoldierType(gameId)
    if(soldierType==EnemyType.TYPE_CHILD)then
      TppMission.ReserveGameOverOnPlayerKillChild(gameId)
    end
  end
  if Tpp.IsHostage(gameId)and TppMission.GetMissionID()~=10100 then
    local e=SendCommand(gameId,{id="IsChild"})
    if e then
      TppMission.ReserveGameOverOnPlayerKillChild(gameId)
    end
  end
  this.PlayTargetEliminatedRadio(gameId)
end
function this._OnRecoverNPC(n,t)
  this._PlayRecoverNPCRadio(n)
end
function this._PlayRecoverNPCRadio(n)
  local t=this.IsEliminateTarget(n)
  local a=this.IsRescueTarget(n)
  if Tpp.IsSoldier(n)and not t then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.ENEMY_RECOVERED)
  elseif Tpp.IsHostage(n)and not a then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.HOSTAGE_RECOVERED)
  else
    this.PlayTargetRescuedRadio(n)
  end
end
function this._OnFulton(n,a,a,t)
  this._OnRecoverNPC(n,t)
end
function this._OnDamage(a,n,t)
  if this.IsRescueTarget(a)then
    this._OnDamageOfRescueTarget(n,t)
  end
end
function this._OnDamageOfRescueTarget(e,n)
  if TppDamage.IsActiveByAttackId(e)then
    if Tpp.IsPlayer(n)then
      TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.HOSTAGE_DAMAGED_FROM_PC)
    end
  end
end
function this._PlacedIntoVehicle(t,n,a)
  if Tpp.IsHelicopter(n)then
    this.PlayTargetRescuedRadio(t)
  end
end
function this._RideHelicopterWithHuman(t,n,t)
  this.PlayTargetRescuedRadio(n)
end
function this._AnnouncePhaseChange(cpId,t)
  local cpSubType=this.GetCpSubType(cpId)
  local cpLangId="cmmn_ene_soviet"
  if cpSubType=="SOVIET_A"or cpSubType=="SOVIET_B"then
    cpLangId="cmmn_ene_soviet"
    elseif cpSubType=="PF_A"then
    cpLangId="cmmn_ene_cfa"
    elseif cpSubType=="PF_B"then
    cpLangId="cmmn_ene_zrs"
    elseif cpSubType=="PF_C"then
    cpLangId="cmmn_ene_coyote"
    elseif cpSubType=="DD_A"then
    return
  elseif cpSubType=="DD_PW"then
    cpLangId="cmmn_ene_pf"
    elseif cpSubType=="DD_FOB"then
    cpLangId="cmmn_ene_pf"
    elseif cpSubType=="SKULL_AFGH"then
    cpLangId="cmmn_ene_xof"
    elseif cpSubType=="SKULL_CYPR"then
    return
  elseif cpSubType=="CHILD_A"then
    return
  end
  if t==TppGameObject.PHASE_ALERT then
    TppUiCommand.AnnounceLogViewLangId("announce_phase_to_alert",cpLangId)
  elseif t==TppGameObject.PHASE_EVASION then
    TppUiCommand.AnnounceLogViewLangId("announce_phase_to_evasion",cpLangId)
  elseif t==TppGameObject.PHASE_CAUTION then
    TppUiCommand.AnnounceLogViewLangId("announce_phase_to_caution",cpLangId)
  elseif t==TppGameObject.PHASE_SNEAK then
    TppUiCommand.AnnounceLogViewLangId("announce_phase_to_sneak",cpLangId)
  end
end
function this._IsGameObjectIDValid(e)
  local e=GetGameObjectId(e)
  if(e==NULL_ID)then
    return false
  else
    return true
  end
end
function this._IsRouteSetTypeValid(n)
  if(n==nil or type(n)~="string")then
    return false
  end
  for t,t in paris(this.ROUTE_SET_TYPES)do
    if(n==this.ROUTE_SET_TYPES[i])then
      return true
    end
  end
  return false
end
function this._ShiftChangeByTime(t)
  for e,a in pairs(mvars.ene_cpList)do
    SendCommand(e,{id="ShiftChange",schedule=mvars.ene_shiftChangeTable[e][t]})
  end
end
function this._IsEliminated(t,n)
  if(t==this.LIFE_STATUS.DEAD)or(n==TppGameObject.NPC_STATE_DISABLE)then
    return true
  else
    return false
  end
end
function this._IsNeutralized(n,t)
  if(n>this.LIFE_STATUS.NORMAL)or(t>TppGameObject.NPC_STATE_NORMAL)then
    return true
  else
    return false
  end
end
function this._RestoreOnContinueFromCheckPoint_Hostage()
end
function this._RestoreOnContinueFromCheckPoint_Hostage2()
  if TppHostage2.SetSVarsKeyNames2 then
    local e={"TppHostage2","TppHostageUnique","TppHostageUnique2","TppHostageKaz","TppOcelot2","TppHuey2","TppCodeTalker2","TppSkullFace2","TppMantis2"}
    for t,e in ipairs(e)do
      if GameObject.GetGameObjectIdByIndex(e,0)~=NULL_ID then
        SendCommand({type=e},{id="RestoreFromSVars"})
      end
    end
  end
end
function this._RestoreOnMissionStart_Hostage()
end
function this._RestoreOnMissionStart_Hostage2()
  if TppHostage2.SetSVarsKeyNames2 then
    local n=EnemyFova.INVALID_FOVA_VALUE
    local t=EnemyFova.INVALID_FOVA_VALUE
    for e=0,TppDefine.DEFAULT_HOSTAGE_STATE_COUNT-1 do
      svars.hosName[e]=0
      svars.hosState[e]=0
      svars.hosFlagAndStance[e]=0
      svars.hosWeapon[e]=0
      svars.hosLocation[e*4+0]=0
      svars.hosLocation[e*4+1]=0
      svars.hosLocation[e*4+2]=0
      svars.hosLocation[e*4+3]=0
      svars.hosMarker[e]=0
      svars.hosFovaSeed[e]=0
      svars.hosFaceFova[e]=n
      svars.hosBodyFova[e]=t
      svars.hosScriptSneakRoute[e]=GsRoute.ROUTE_ID_EMPTY
      svars.hosRouteNodeIndex[e]=0
      svars.hosRouteEventIndex[e]=0
      svars.hosOptParam1[e]=0
      svars.hosOptParam2[e]=0
      svars.hosRandomSeed[e]=0
    end
  end
end
function this._StoreSVars_Hostage(t)
  local e={"TppHostage2","TppHostageUnique","TppHostageUnique2","TppHostageKaz","TppOcelot2","TppHuey2","TppCodeTalker2","TppSkullFace2","TppMantis2"}
  if TppHostage2.SetSVarsKeyNames2 then
    for t,e in ipairs(e)do
      if GameObject.GetGameObjectIdByIndex(e,0)~=NULL_ID then
        SendCommand({type=e},{id="ReadyToStoreToSVars"})
      end
    end
  end
  for i,e in ipairs(e)do
    if GameObject.GetGameObjectIdByIndex(e,0)~=NULL_ID then
      SendCommand({type=e},{id="StoreToSVars",markerOnly=t})
    end
  end
end
function this._DoRoutePointMessage(r,o,s,i)
  local n=mvars.ene_routePointMessage
  if not n then
    return
  end
  local t=TppSequence.GetCurrentSequenceName()
  local a=n.sequence[t]
  local t=""if a then
    this.ExecuteRoutePointMessage(a,r,o,s,i,t)
  end
  this.ExecuteRoutePointMessage(n.main,r,o,s,i,t)
end
function this.ExecuteRoutePointMessage(n,i,t,a,e,r)
  local n=n[e]
  if not n then
    return
  end
  Tpp.DoMessageAct(n,TppMission.CheckMessageOption,a,t,i,e,r)
end
return this
