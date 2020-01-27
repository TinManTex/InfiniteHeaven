local this={}
if NpcFova==nil then
  NpcFova=EnemyFova
end
local StrCode32=Fox.StrCode32
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local IsTypeNumber=Tpp.IsTypeNumber
local GetGameObjectId=GameObject.GetGameObjectId
local GetGameObjectIdByIndex=GameObject.GetGameObjectIdByIndex
local NULL_ID=GameObject.NULL_ID
local SendCommand=GameObject.SendCommand
local DEBUG_StrCode32ToString=Tpp.DEBUG_StrCode32ToString
local function d(t)
  local e={}
  for n,r in ipairs(t)do
    if IsTypeTable(r)then
      e[n]=d(r)
    else
      local t=GetGameObjectId(t[n])
      if t and t~=NULL_ID then
        e[t]=n
      end
    end
  end
  return e
end
function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="Dead",func=this._OnDead},
      {msg="Damage",func=this._OnDamage},
      {msg="RoutePoint2",func=this._DoRoutePointMessage},
      {msg="ChangePhaseForAnnounce",func=this._AnnouncePhaseChange},
      {msg="NpcActivated",func=this._OnNpcActivated,option={isExecDemoPlaying=true,isExecMissionPrepare=true,isExecFastTravel=true,isExecMissionClear=true,isExecGameOver=true}}},
    Weather={
      {msg="Clock",sender="ShiftChangeAtNight",func=function(n,n)
        this.ShiftChangeByTime"shiftAtNight"
      end},
      {msg="Clock",sender="ShiftChangeAtMorning",func=function(n,n)
        this.ShiftChangeByTime"shiftAtMorning"
      end},
      {msg="Clock",sender="ShiftChangeAtMidNight",func=function(n,n)
        this.ShiftChangeByTime"shiftAtMidNight"
      end}}
  }
end
this.POWER_SETTING={"NO_KILL_WEAPON","ARMOR","SOFT_ARMOR","SNIPER","SHIELD","MISSILE","MG","SHOTGUN","SMG","HELMET","NVG","GAS_MASK","GUN_LIGHT","STRONG_WEAPON","STRONG_PATROL","STRONG_NOTICE_TRANQ","FULTON_SPECIAL","FULTON_HIGH","FULTON_LOW","COMBAT_SPECIAL","COMBAT_HIGH","COMBAT_LOW","STEALTH_SPECIAL","STEALTH_HIGH","STEALTH_LOW","HOLDUP_SPECIAL","HOLDUP_HIGH","HOLDUP_LOW"}
this.PHASE={SNEAK=0,CAUTION=1,EVASION=2,ALERT=3,MAX=4}
this.ROUTE_SET_TYPES={"sneak_day","sneak_night","caution","hold","travel","sneak_midnight","sleep"}
this.LIFE_STATUS={NORMAL=0,DEAD=1,DYING=2,SLEEP=3,FAINT=4}
this.ACTION_STATUS={NORMAL=0,FULTON_RECOVERD=1,HOLD_UP_STAND=2,HOLD_UP_CROWL=3,NOW_CARRYING=4}
this.SOLDIER_DEFINE_RESERVE_TABLE_NAME=Tpp.Enum{"lrrpTravelPlan"}
this.TAKING_OVER_HOSTAGE_LIST={"hos_takingOver_0000","hos_takingOver_0001","hos_takingOver_0002","hos_takingOver_0003"}
this.ROUTE_SET_TYPETAG={}
this.subTypeOfCpTable={SOVIET_A={afgh_field_cp=true,afgh_remnants_cp=true,afgh_tent_cp=true,afgh_fieldEast_ob=true,afgh_fieldWest_ob=true,afgh_remnantsNorth_ob=true,afgh_tentEast_ob=true,afgh_tentNorth_ob=true,afgh_01_16_lrrp=true,afgh_29_20_lrrp=true,afgh_29_16_lrrp=true,afgh_village_cp=true,afgh_slopedTown_cp=true,afgh_commFacility_cp=true,afgh_enemyBase_cp=true,afgh_commWest_ob=true,afgh_ruinsNorth_ob=true,afgh_slopedWest_ob=true,afgh_villageEast_ob=true,afgh_villageEast_ob=true,afgh_villageNorth_ob=true,afgh_villageWest_ob=true,afgh_enemyEast_ob=true,afgh_01_13_lrrp=true,afgh_02_14_lrrp=true,afgh_32_01_lrrp=true,afgh_32_04_lrrp=true,afgh_32_14_lrrp=true,afgh_34_02_lrrp=true,afgh_34_13_lrrp=true,afgh_35_02_lrrp=true,afgh_35_14_lrrp=true,afgh_35_15_lrrp=true,afgh_36_04_lrrp=true,afgh_36_15_lrrp=true,afgh_36_06_lrrp=true},SOVIET_B={afgh_bridge_cp=true,afgh_fort_cp=true,afgh_cliffTown_cp=true,afgh_bridgeNorth_ob=true,afgh_bridgeWest_ob=true,afgh_cliffEast_ob=true,afgh_cliffSouth_ob=true,afgh_cliffWest_ob=true,afgh_enemyNorth_ob=true,afgh_fortSouth_ob=true,afgh_fortWest_ob=true,afgh_slopedEast_ob=true,afgh_powerPlant_cp=true,afgh_sovietBase_cp=true,afgh_plantSouth_ob=true,afgh_plantWest_ob=true,afgh_sovietSouth_ob=true,afgh_waterwayEast_ob=true,afgh_citadel_cp=true,afgh_citadelSouth_ob=true},PF_A={mafr_outland_cp=true,mafr_outlandEast_ob=true,mafr_outlandNorth_ob=true,mafr_01_20_lrrp=true,mafr_03_20_lrrp=true,mafr_flowStation_cp=true,mafr_swamp_cp=true,mafr_pfCamp_cp=true,mafr_savannah_cp=true,mafr_swampEast_ob=true,mafr_swampWest_ob=true,mafr_swampSouth_ob=true,mafr_pfCampEast_ob=true,mafr_pfCampNorth_ob=true,mafr_savannahEast_ob=true,mafr_chicoVilWest_ob=true,mafr_hillSouth_ob=true,mafr_02_21_lrrp=true,mafr_02_22_lrrp=true,mafr_05_23_lrrp=true,mafr_06_16_lrrp=true,mafr_06_22_lrrp=true,mafr_06_24_lrrp=true,mafr_13_15_lrrp=true,mafr_13_16_lrrp=true,mafr_13_24_lrrp=true,mafr_15_16_lrrp=true,mafr_15_23_lrrp=true,mafr_16_23_lrrp=true,mafr_16_24_lrrp=true,mafr_23_33_lrrp=true},PF_B={mafr_factory_cp=true,mafr_lab_cp=true,mafr_labWest_ob=true,mafr_19_29_lrrp=true},PF_C={mafr_banana_cp=true,mafr_diamond_cp=true,mafr_hill_cp=true,mafr_savannahNorth_ob=true,mafr_savannahWest_ob=true,mafr_bananaEast_ob=true,mafr_bananaSouth_ob=true,mafr_hillNorth_ob=true,mafr_hillWest_ob=true,mafr_hillWestNear_ob=true,mafr_factorySouth_ob=true,mafr_factoryWest_ob=true,mafr_diamondNorth_ob=true,mafr_diamondSouth_ob=true,mafr_diamondWest_ob=true,mafr_07_09_lrrp=true,mafr_07_24_lrrp=true,mafr_08_10_lrrp=true,mafr_08_25_lrrp=true,mafr_09_25_lrrp=true,mafr_10_11_lrrp=true,mafr_10_18_lrrp=true,mafr_10_26_lrrp=true,mafr_11_10_lrrp=true,mafr_11_12_lrrp=true,mafr_11_26_lrrp=true,mafr_12_14_lrrp=true,mafr_14_27_lrrp=true,mafr_17_27_lrrp=true,mafr_18_26_lrrp=true,mafr_27_30_lrrp=true}}
this.subTypeOfCp={}
for t,n in pairs(this.subTypeOfCpTable)do
  for n,a in pairs(n)do
    this.subTypeOfCp[n]=t
  end
end
local n=TppEnemyBodyId or{}
this.childBodyIdTable={n.chd0_v00,n.chd0_v01,n.chd0_v02,n.chd0_v03,n.chd0_v05,n.chd0_v06,n.chd0_v07,n.chd0_v08,n.chd0_v09,n.chd0_v10,n.chd0_v11}
this.bodyIdTable={SOVIET_A={ASSAULT={n.svs0_rfl_v00_a,n.svs0_rfl_v00_a,n.svs0_rfl_v01_a,n.svs0_mcg_v00_a},ASSAULT_OB={n.svs0_rfl_v02_a,n.svs0_mcg_v02_a},SNIPER={n.svs0_snp_v00_a},SHOTGUN={n.svs0_rfl_v00_a,n.svs0_rfl_v01_a},SHOTGUN_OB={n.svs0_rfl_v02_a},MG={n.svs0_mcg_v00_a,n.svs0_mcg_v01_a},MG_OB={n.svs0_mcg_v02_a},MISSILE={n.svs0_rfl_v00_a},SHIELD={n.svs0_rfl_v00_a},ARMOR={n.sva0_v00_a},RADIO={n.svs0_rdo_v00_a}},SOVIET_B={ASSAULT={n.svs0_rfl_v00_b,n.svs0_rfl_v00_b,n.svs0_rfl_v01_b,n.svs0_mcg_v00_b},ASSAULT_OB={n.svs0_rfl_v02_b,n.svs0_mcg_v02_b},SNIPER={n.svs0_snp_v00_b},SHOTGUN={n.svs0_rfl_v00_b,n.svs0_rfl_v01_b},SHOTGUN_OB={n.svs0_rfl_v02_b},MG={n.svs0_mcg_v00_b,n.svs0_mcg_v01_b},MG_OB={n.svs0_mcg_v02_b},MISSILE={n.svs0_rfl_v00_b},SHIELD={n.svs0_rfl_v00_b},ARMOR={n.sva0_v00_a},RADIO={n.svs0_rdo_v00_b}},PF_A={ASSAULT={n.pfs0_rfl_v00_a,n.pfs0_mcg_v00_a},ASSAULT_OB={n.pfs0_rfl_v00_a,n.pfs0_rfl_v01_a,n.pfs0_mcg_v00_a},SNIPER={n.pfs0_snp_v00_a},SHOTGUN={n.pfs0_rfl_v00_a},SHOTGUN_OB={n.pfs0_rfl_v00_a,n.pfs0_rfl_v01_a},MG={n.pfs0_mcg_v00_a},MISSILE={n.pfs0_rfl_v00_a},SHIELD={n.pfs0_rfl_v00_a},ARMOR={n.pfa0_v00_b},RADIO={n.pfs0_rdo_v00_a}},PF_B={ASSAULT={n.pfs0_rfl_v00_b,n.pfs0_mcg_v00_b},ASSAULT_OB={n.pfs0_rfl_v00_b,n.pfs0_rfl_v01_b,n.pfs0_mcg_v00_b},SNIPER={n.pfs0_snp_v00_b},SHOTGUN={n.pfs0_rfl_v00_b},SHOTGUN_OB={n.pfs0_rfl_v00_b,n.pfs0_rfl_v01_b},MG={n.pfs0_mcg_v00_b},MISSILE={n.pfs0_rfl_v00_b},SHIELD={n.pfs0_rfl_v00_b},ARMOR={n.pfa0_v00_a},RADIO={n.pfs0_rdo_v00_b}},PF_C={ASSAULT={n.pfs0_rfl_v00_c,n.pfs0_mcg_v00_c},ASSAULT_OB={n.pfs0_rfl_v00_c,n.pfs0_rfl_v01_c,n.pfs0_mcg_v00_c},SNIPER={n.pfs0_snp_v00_c},SHOTGUN={n.pfs0_rfl_v00_c},SHOTGUN_OB={n.pfs0_rfl_v00_c,n.pfs0_rfl_v01_c},MG={n.pfs0_mcg_v00_c},MISSILE={n.pfs0_rfl_v00_c},SHIELD={n.pfs0_rfl_v01_c},ARMOR={n.pfa0_v00_c},RADIO={n.pfs0_rdo_v00_c}},DD_A={ASSAULT={n.dds3_main0_v00}},DD_FOB={ASSAULT={n.dds5_main0_v00}},DD_PW={ASSAULT={n.dds0_main1_v00}},SKULL_CYPR={ASSAULT={n.wss0_main0_v00}},SKULL_AFGH={ASSAULT={n.wss4_main0_v00}},CHILD={ASSAULT=this.childBodyIdTable}}
this.weaponIdTable={SOVIET_A={NORMAL={HANDGUN=TppEquip.EQP_WP_East_hg_010,SMG=TppEquip.EQP_WP_East_sm_010,ASSAULT=TppEquip.EQP_WP_East_ar_010,SNIPER=TppEquip.EQP_WP_East_sr_011,SHOTGUN=TppEquip.EQP_WP_Com_sg_011,MG=TppEquip.EQP_WP_East_mg_010,MISSILE=TppEquip.EQP_WP_East_ms_010,SHIELD=TppEquip.EQP_SLD_SV},STRONG={HANDGUN=TppEquip.EQP_WP_East_hg_010,SMG=TppEquip.EQP_WP_East_sm_020,ASSAULT=TppEquip.EQP_WP_East_ar_030,SNIPER=TppEquip.EQP_WP_East_sr_020,SHOTGUN=TppEquip.EQP_WP_Com_sg_020,MG=TppEquip.EQP_WP_East_mg_010,MISSILE=TppEquip.EQP_WP_Com_ms_010,SHIELD=TppEquip.EQP_SLD_SV}},PF_A={NORMAL={HANDGUN=TppEquip.EQP_WP_West_hg_010,SMG=TppEquip.EQP_WP_West_sm_010,ASSAULT=TppEquip.EQP_WP_West_ar_010,SNIPER=TppEquip.EQP_WP_West_sr_011,SHOTGUN=TppEquip.EQP_WP_Com_sg_011,MG=TppEquip.EQP_WP_West_mg_010,MISSILE=TppEquip.EQP_WP_West_ms_010,SHIELD=TppEquip.EQP_SLD_PF_01},STRONG={HANDGUN=TppEquip.EQP_WP_West_hg_010,SMG=TppEquip.EQP_WP_West_sm_020,ASSAULT=TppEquip.EQP_WP_West_ar_020,SNIPER=TppEquip.EQP_WP_West_sr_020,SHOTGUN=TppEquip.EQP_WP_Com_sg_020,MG=TppEquip.EQP_WP_West_mg_010,MISSILE=TppEquip.EQP_WP_Com_ms_010,SHIELD=TppEquip.EQP_SLD_PF_01}},PF_B={NORMAL={HANDGUN=TppEquip.EQP_WP_West_hg_010,SMG=TppEquip.EQP_WP_West_sm_010,ASSAULT=TppEquip.EQP_WP_West_ar_010,SNIPER=TppEquip.EQP_WP_West_sr_011,SHOTGUN=TppEquip.EQP_WP_Com_sg_011,MG=TppEquip.EQP_WP_West_mg_010,MISSILE=TppEquip.EQP_WP_West_ms_010,SHIELD=TppEquip.EQP_SLD_PF_00},STRONG={HANDGUN=TppEquip.EQP_WP_West_hg_010,SMG=TppEquip.EQP_WP_West_sm_020,ASSAULT=TppEquip.EQP_WP_West_ar_020,SNIPER=TppEquip.EQP_WP_West_sr_020,SHOTGUN=TppEquip.EQP_WP_Com_sg_020,MG=TppEquip.EQP_WP_West_mg_010,MISSILE=TppEquip.EQP_WP_Com_ms_010,SHIELD=TppEquip.EQP_SLD_PF_00}},PF_C={NORMAL={HANDGUN=TppEquip.EQP_WP_West_hg_010,SMG=TppEquip.EQP_WP_West_sm_010,ASSAULT=TppEquip.EQP_WP_West_ar_010,SNIPER=TppEquip.EQP_WP_West_sr_011,SHOTGUN=TppEquip.EQP_WP_Com_sg_011,MG=TppEquip.EQP_WP_West_mg_010,MISSILE=TppEquip.EQP_WP_West_ms_010,SHIELD=TppEquip.EQP_SLD_PF_02},STRONG={HANDGUN=TppEquip.EQP_WP_West_hg_010,SMG=TppEquip.EQP_WP_West_sm_020,ASSAULT=TppEquip.EQP_WP_West_ar_020,SNIPER=TppEquip.EQP_WP_West_sr_020,SHOTGUN=TppEquip.EQP_WP_Com_sg_020,MG=TppEquip.EQP_WP_West_mg_010,MISSILE=TppEquip.EQP_WP_Com_ms_010,SHIELD=TppEquip.EQP_SLD_PF_02}},DD=nil,SKULL_CYPR={NORMAL={HANDGUN=TppEquip.EQP_WP_West_hg_020,SMG=TppEquip.EQP_WP_East_sm_030}},SKULL={NORMAL={HANDGUN=TppEquip.EQP_WP_West_hg_020,SMG=TppEquip.EQP_WP_West_sm_020,ASSAULT=TppEquip.EQP_WP_West_ar_030,SNIPER=TppEquip.EQP_WP_West_sr_020,SHOTGUN=TppEquip.EQP_WP_Com_sg_011,MG=TppEquip.EQP_WP_West_mg_020,MISSILE=TppEquip.EQP_WP_West_ms_010,SHIELD=TppEquip.EQP_SLD_PF_02},STRONG={HANDGUN=TppEquip.EQP_WP_West_hg_020,SMG=TppEquip.EQP_WP_West_sm_020,ASSAULT=TppEquip.EQP_WP_West_ar_030,SNIPER=TppEquip.EQP_WP_West_sr_020,SHOTGUN=TppEquip.EQP_WP_Com_sg_020,MG=TppEquip.EQP_WP_West_mg_020,MISSILE=TppEquip.EQP_WP_Com_ms_010,SHIELD=TppEquip.EQP_SLD_PF_02}},CHILD={NORMAL={HANDGUN=TppEquip.EQP_WP_East_hg_010,ASSAULT=TppEquip.EQP_WP_East_ar_020}}}
local n=MbsDevelopedEquipType or{}
this.DDWeaponIdInfo={
  HANDGUN={{equipId=TppEquip.EQP_WP_West_hg_010}},
  SMG={
    {equipId=TppEquip.EQP_WP_East_sm_047,isNoKill=true,developedEquipType=n.SM_2040_NOKILL,developId=2044},
    {equipId=TppEquip.EQP_WP_East_sm_045,isNoKill=true,developedEquipType=n.SM_2040_NOKILL,developId=2043},
    {equipId=TppEquip.EQP_WP_East_sm_044,isNoKill=true,developedEquipType=n.SM_2040_NOKILL,developId=2042},
    {equipId=TppEquip.EQP_WP_East_sm_043,isNoKill=true,developedEquipType=n.SM_2040_NOKILL,developId=2041},
    {equipId=TppEquip.EQP_WP_East_sm_042,isNoKill=true,developedEquipType=n.SM_2040_NOKILL,developId=2040},
    {equipId=TppEquip.EQP_WP_West_sm_017,developedEquipType=n.SM_2014,developId=2014},
    {equipId=TppEquip.EQP_WP_West_sm_016,developedEquipType=n.SM_2010,developId=2013},
    {equipId=TppEquip.EQP_WP_West_sm_015,developedEquipType=n.SM_2010,developId=2012},
    {equipId=TppEquip.EQP_WP_West_sm_014,developedEquipType=n.SM_2010,developId=2011},
    {equipId=TppEquip.EQP_WP_West_sm_010,developedEquipType=n.SM_2010,developId=2010}
  },
  SHOTGUN={
    {equipId=TppEquip.EQP_WP_Com_sg_038,isNoKill=true,developedEquipType=n.SG_4027_NOKILL,developId=4028},
    {equipId=TppEquip.EQP_WP_Com_sg_030,isNoKill=true,developedEquipType=n.SG_4027_NOKILL,developId=4027},
    {equipId=TppEquip.EQP_WP_Com_sg_025,isNoKill=true,developedEquipType=n.SG_4035_NOKILL,developId=4037},
    {equipId=TppEquip.EQP_WP_Com_sg_024,isNoKill=true,developedEquipType=n.SG_4035_NOKILL,developId=4036},
    {equipId=TppEquip.EQP_WP_Com_sg_023,isNoKill=true,developedEquipType=n.SG_4035_NOKILL,developId=4035},
    {equipId=TppEquip.EQP_WP_Com_sg_018,developedEquipType=n.SG_4040,developId=4044},
    {equipId=TppEquip.EQP_WP_Com_sg_016,developedEquipType=n.SG_4040,developId=4043},
    {equipId=TppEquip.EQP_WP_Com_sg_015,developedEquipType=n.SG_4040,developId=4042},
    {equipId=TppEquip.EQP_WP_Com_sg_020,developedEquipType=n.SG_4040,developId=4041},
    {equipId=TppEquip.EQP_WP_Com_sg_013,developedEquipType=n.SG_4040,developId=4040},
    {equipId=TppEquip.EQP_WP_Com_sg_011,developedEquipType=n.SG_4020,developId=4020}
  },
  ASSAULT={
    {equipId=TppEquip.EQP_WP_West_ar_077,isNoKill=true,developedEquipType=n.AR_3060_NOKILL,developId=3064},
    {equipId=TppEquip.EQP_WP_West_ar_075,isNoKill=true,developedEquipType=n.AR_3060_NOKILL,developId=3063},
    {equipId=TppEquip.EQP_WP_West_ar_070,isNoKill=true,developedEquipType=n.AR_3060_NOKILL,developId=3062},
    {equipId=TppEquip.EQP_WP_West_ar_063,isNoKill=true,developedEquipType=n.AR_3060_NOKILL,developId=3061},
    {equipId=TppEquip.EQP_WP_West_ar_060,isNoKill=true,developedEquipType=n.AR_3060_NOKILL,developId=3060},
    {equipId=TppEquip.EQP_WP_West_ar_057,developedEquipType=n.AR_3036,developId=3042},
    {equipId=TppEquip.EQP_WP_West_ar_050,developedEquipType=n.AR_3036,developId=3038},
    {equipId=TppEquip.EQP_WP_West_ar_055,developedEquipType=n.AR_3036,developId=3037},
    {equipId=TppEquip.EQP_WP_West_ar_010,developedEquipType=n.AR_3036,developId=3036},
    {equipId=TppEquip.EQP_WP_West_ar_042,developedEquipType=n.AR_3030,developId=3031},
    {equipId=TppEquip.EQP_WP_West_ar_040}},SNIPER={{equipId=TppEquip.EQP_WP_West_sr_048,isNoKill=true,developedEquipType=n.SR_6037_NOKILL,developId=6039},
    {equipId=TppEquip.EQP_WP_West_sr_047,isNoKill=true,developedEquipType=n.SR_6037_NOKILL,developId=6038},
    {equipId=TppEquip.EQP_WP_West_sr_037,isNoKill=true,developedEquipType=n.SR_6037_NOKILL,developId=6037},
    {equipId=TppEquip.EQP_WP_East_sr_034,isNoKill=true,developedEquipType=n.SR_6005_NOKILL,developId=6006},
    {equipId=TppEquip.EQP_WP_East_sr_033,isNoKill=true,developedEquipType=n.SR_6005_NOKILL,developId=6008},
    {equipId=TppEquip.EQP_WP_East_sr_032,isNoKill=true,developedEquipType=n.SR_6005_NOKILL,developId=6005},
    {equipId=TppEquip.EQP_WP_West_sr_027,developedEquipType=n.SR_6030,developId=6033},
    {equipId=TppEquip.EQP_WP_West_sr_020,developedEquipType=n.SR_6030,developId=6032},
    {equipId=TppEquip.EQP_WP_West_sr_014,developedEquipType=n.SR_6030,developId=6031},
    {equipId=TppEquip.EQP_WP_West_sr_013,developedEquipType=n.SR_6030,developId=6030},
    {equipId=TppEquip.EQP_WP_West_sr_011,developedEquipType=n.SR_6010,developId=6010}
    },
    MG={
      {equipId=TppEquip.EQP_WP_West_mg_037,developedEquipType=n.MG_7000,developId=7004},
      {equipId=TppEquip.EQP_WP_West_mg_030,developedEquipType=n.MG_7000,developId=7003},
      {equipId=TppEquip.EQP_WP_West_mg_024,developedEquipType=n.MG_7000,developId=7002},
      {equipId=TppEquip.EQP_WP_West_mg_023,developedEquipType=n.MG_7000,developId=7001},
      {equipId=TppEquip.EQP_WP_West_mg_020,developedEquipType=n.MG_7000,developId=7e3}},
    MISSILE={
      {equipId=TppEquip.EQP_WP_West_ms_020,isNoKill=true,developedEquipType=n.MS_8013_NOKILL,developId=8013},
      {equipId=TppEquip.EQP_WP_Com_ms_026,developedEquipType=n.MS_8020,developId=8023},
      {equipId=TppEquip.EQP_WP_Com_ms_020,developedEquipType=n.MS_8020,developId=8022},
      {equipId=TppEquip.EQP_WP_Com_ms_024,developedEquipType=n.MS_8020,developId=8021},
      {equipId=TppEquip.EQP_WP_Com_ms_023,developedEquipType=n.MS_8020,developId=8020}},
    SHIELD={
      {equipId=TppEquip.EQP_SLD_DD,developedEquipType=n.SD_9000,developId=9e3}
    },
    GRENADE={
      {equipId=TppEquip.EQP_SWP_Grenade_G05,developedEquipType=n.GRENADE,developId=10045},
      {equipId=TppEquip.EQP_SWP_Grenade_G04,developedEquipType=n.GRENADE,developId=10044},
      {equipId=TppEquip.EQP_SWP_Grenade_G03,developedEquipType=n.GRENADE,developId=10043},
      {equipId=TppEquip.EQP_SWP_Grenade_G02,developedEquipType=n.GRENADE,developId=10042},
      {equipId=TppEquip.EQP_SWP_Grenade_G01,developedEquipType=n.GRENADE,developId=10041},
      {equipId=TppEquip.EQP_SWP_Grenade}
    },
    STUN_GRENADE={
      {equipId=TppEquip.EQP_SWP_StunGrenade_G03,isNoKill=true,developedEquipType=n.STUN_GRENADE,developId=10063},
      {equipId=TppEquip.EQP_SWP_StunGrenade_G02,isNoKill=true,developedEquipType=n.STUN_GRENADE,developId=10062},
      {equipId=TppEquip.EQP_SWP_StunGrenade_G01,isNoKill=true,developedEquipType=n.STUN_GRENADE,developId=10061},
      {equipId=TppEquip.EQP_SWP_StunGrenade,isNoKill=true,developedEquipType=n.STUN_GRENADE,developId=10060}
    },
    SNEAKING_SUIT={
      {equipId=6,isNoKill=true,developedEquipType=n.SNEAKING_SUIT,developId=19042},
      {equipId=5,isNoKill=true,developedEquipType=n.SNEAKING_SUIT,developId=19057},
      {equipId=4,isNoKill=true,developedEquipType=n.SNEAKING_SUIT,developId=19056},
      {equipId=3,isNoKill=true,developedEquipType=n.SNEAKING_SUIT,developId=19052},
      {equipId=2,isNoKill=true,developedEquipType=n.SNEAKING_SUIT,developId=19051},
      {equipId=1,isNoKill=true,developedEquipType=n.SNEAKING_SUIT,developId=19050}
    },
    BATTLE_DRESS={
      {equipId=6,developedEquipType=n.BATTLE_DRESS,developId=19043},
      {equipId=5,developedEquipType=n.BATTLE_DRESS,developId=19059},
      {equipId=4,developedEquipType=n.BATTLE_DRESS,developId=19058},
      {equipId=3,developedEquipType=n.BATTLE_DRESS,developId=19055},
      {equipId=2,developedEquipType=n.BATTLE_DRESS,developId=19054},
      {equipId=1,developedEquipType=n.BATTLE_DRESS,developId=19053}
    }
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
function this._ConvertSoldierNameKeysToId(e)
end
function this._SetUpSoldierTypes(t,n)
  for a,n in ipairs(n)do
    if IsTypeTable(n)then
      this._SetUpSoldierTypes(t,n)
    else
      mvars.ene_soldierTypes[n]=EnemyType["TYPE_"..t]
    end
  end
end
function this.SetUpSoldierTypes(n)
  for t,n in pairs(n)do
    this._SetUpSoldierTypes(t,n)
  end
end
function this._SetUpSoldierSubTypes(e,e)
end
function this.SetUpSoldierSubTypes(n)
  for t,n in pairs(n)do
    this._SetUpSoldierSubTypes(t,n)
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
function this.SetSoldierType(e,n)
  mvars.ene_soldierTypes[e]=n
  GameObject.SendCommand(e,{id="SetSoldier2Type",type=n})
end
function this.GetSoldierType(e)
  local n=TppMission.GetMissionID()
  if e==nil or e==NULL_ID then
    for n,e in pairs(mvars.ene_soldierTypes)do
      if e then
        return e
      end
    end
  else
    if mvars.ene_soldierTypes then
      local e=mvars.ene_soldierTypes[e]
      if e then
        return e
      end
    end
  end
  local e=EnemyType.TYPE_SOVIET
  if TppLocation.IsAfghan()then
    e=EnemyType.TYPE_SOVIET
  elseif TppLocation.IsMiddleAfrica()then
    e=EnemyType.TYPE_PF
  end
  return e
end
function this.SetSoldierSubType(e,n)
  mvars.ene_soldierSubType[e]=n
end
function this.GetSoldierSubType(n,e)
  local e=nil
  if mvars.ene_soldierSubType then
    e=mvars.ene_soldierSubType[n]
  end
  return e
end
function this.GetCpSubType(t)
  if mvars.ene_soldierIDList then
    local n=mvars.ene_soldierIDList[t]
    if n~=nil then
      for n,t in pairs(n)do
        return this.GetSoldierSubType(n)
      end
    end
  end
  if mvars.ene_cpList then
    local n=mvars.ene_cpList[t]
    local e=this.subTypeOfCp[n]
    if e~=nil then
      return e
    end
  end
  return this.GetSoldierSubType(nil)
end
function this._CreateDDWeaponIdTable(s,i,o)
  local r={NORMAL={}}
  local n=r.NORMAL
  mvars.ene_ddWeaponCount=0
  n.IS_NOKILL={}
  local e=this.DDWeaponIdInfo
  for a,e in pairs(e)do
    for t,e in ipairs(e)do
      local t=false
      local r=e.developedEquipType
      if r==nil then
        t=true
      elseif e.isNoKill and not o then
        t=false
      else
        local e=e.developId
        local e=TppMotherBaseManagement.GetEquipDevelopRank(e)
        if(i>=e and s[r]>=e)then
          t=true
        end
      end
      if t then
        mvars.ene_ddWeaponCount=mvars.ene_ddWeaponCount+1
        if n[a]then
        else
          n[a]=e.equipId
          if e.isNoKill then
            n.IS_NOKILL[a]=true
          end
        end
      end
    end
  end
  return r
end
function this.GetDDWeaponCount()
  return mvars.ene_ddWeaponCount
end
function this.ClearDDParameter()
  this.weaponIdTable.DD=nil
end
function this.PrepareDDParameter(t,a)
  if TppMotherBaseManagement.GetMbsDevelopedEquipGradeTable==nil then
    this.weaponIdTable.DD={NORMAL={HANDGUN=TppEquip.EQP_WP_West_hg_010,ASSAULT=TppEquip.EQP_WP_West_ar_040}}
    return
  end
  local r=TppMotherBaseManagement.GetMbsDevelopedEquipGradeTable()t=t or 9999
  if gvars.ini_isTitleMode then
    this.ClearDDParameter()
  end
  if this.weaponIdTable.DD~=nil then
  else
    this.weaponIdTable.DD=this._CreateDDWeaponIdTable(r,t,a)
  end
  local a=r[n.FULTON_16001]
  local r=r[n.FULTON_16008]
  if a>t then
    a=t
  end
  if r>t then
    r=t
  end
  local n=0
  if a>=4 then
    n=3
  elseif a>=3 then
    n=2
  elseif a>=1 then
    n=1
  end
  local t=false
  if r~=0 then
    t=true
  end
  this.weaponIdTable.DD.NORMAL.FULTON_LV=n
  this.weaponIdTable.DD.NORMAL.WORMHOLE_FULTON=t
end
function this.SetUpDDParameter()
end
function this.GetBodyId(t,o,i,a)
  local r
  local n={}
  if o==EnemyType.TYPE_SOVIET then
    n=this.bodyIdTable.SOVIET_A
    if i=="SOVIET_B"then
      n=this.bodyIdTable.SOVIET_B
    end
  elseif o==EnemyType.TYPE_PF then
    n=this.bodyIdTable.PF_A
    if i=="PF_B"then
      n=this.bodyIdTable.PF_B
    elseif i=="PF_C"then
      n=this.bodyIdTable.PF_C
    end
  elseif o==EnemyType.TYPE_DD then
    n=this.bodyIdTable.DD_A
    if i=="DD_FOB"then
      n=this.bodyIdTable.DD_FOB
    elseif i=="DD_PW"then
      n=this.bodyIdTable.DD_PW
    end
  elseif o==EnemyType.TYPE_SKULL then
    if this.bodyIdTable[i]then
      n=this.bodyIdTable[i]
    else
      n=this.bodyIdTable.SKULL_AFGH
    end
  elseif o==EnemyType.TYPE_CHILD then
    n=this.bodyIdTable.CHILD
  else
    n=this.bodyIdTable.SOVIET_A
  end
  if n==nil then
    return nil
  end
  local e=function(n,e)if#e==0 then
    return e[1]
  end
  return e[(n%#e)+1]
  end
  if a.ARMOR and n.ARMOR then
    return e(t,n.ARMOR)
  end
  if(mvars.ene_soldierLrrp[t]or a.RADIO)and n.RADIO then
    return e(t,n.RADIO)
  end
  if a.MISSILE and n.MISSILE then
    return e(t,n.MISSILE)
  end
  if a.SHIELD and n.SHIELD then
    return e(t,n.SHIELD)
  end
  if a.SNIPER and n.SNIPER then
    r=e(t,n.SNIPER)
  elseif a.SHOTGUN and n.SHOTGUN then
    if a.OB and n.SHOTGUN_OB then
      r=e(t,n.SHOTGUN_OB)
    else
      r=e(t,n.SHOTGUN)
    end
  elseif a.MG and n.MG then
    if a.OB and n.MG_OB then
      r=e(t,n.MG_OB)
    else
      r=e(t,n.MG)
    end
  elseif n.ASSAULT then
    if a.OB and n.ASSAULT_OB then
      r=e(t,n.ASSAULT_OB)
    else
      r=e(t,n.ASSAULT)
    end
  end
  return r
end
function this.GetFaceId(n,e,n,n)
  if e==EnemyType.TYPE_SKULL then
    return NpcFova.INVALID_FOVA_VALUE
  elseif e==EnemyType.TYPE_DD then
    return NpcFova.INVALID_FOVA_VALUE
  elseif e==EnemyType.TYPE_CHILD then
    return 630
  end
  return nil
end
function this.GetBalaclavaFaceId(t,e,t,n)
  if e==EnemyType.TYPE_SKULL then
    return NpcFova.NOT_USED_FOVA_VALUE
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
function this.CanUseArmor(e)
  if TppEneFova==nil then
    return false
  end
  local n=TppMission.GetMissionID()
  if e then
    return TppEneFova.CanUseArmorType(n,e)
  end
  return true
end
function this.SetSoldier2CommonPackageLabel(e)
  mvars.ene_soldier2CommonBlockPackageLabel=e
end
function this.AssignUniqueStaffType(e)
  if not IsTypeTable(e)then
    return
  end
  local r=e.locaterName
  local t=e.gameObjectId
  local n=e.uniqueStaffTypeId
  local i=e.alreadyExistParam
  if not IsTypeNumber(n)then
    return
  end
  if(not IsTypeNumber(t))and(not IsTypeString(r))then
    return
  end
  local e
  if IsTypeNumber(t)then
    e=t
  elseif IsTypeString(r)then
    e=GetGameObjectId(r)
  end
  if not TppDefine.IGNORE_EXIST_STAFF_CHECK[n]then
    if TppMotherBaseManagement.IsExistStaff{uniqueTypeId=n}then
      if i then
        local e={gameObjectId=e}
        for n,t in pairs(i)do
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
function this.IsActiveSoldierInRange(e,e)
  return false
end
function this._SetOutOfArea(e,e)
end
function this.SetOutOfArea(e,e)
end
function this.SetEliminateTargets(t,n)
  mvars.ene_eliminateTargetList={}
  local r={}
  if Tpp.IsTypeTable(n)then
    if Tpp.IsTypeTable(n.exceptMissionClearCheck)then
      for n,e in pairs(n.exceptMissionClearCheck)do
        r[e]=true
      end
    end
  end
  for t,n in pairs(t)do
    local t=GetGameObjectId(n)
    if t~=NULL_ID then
      if Tpp.IsSoldier(t)then
        if not r[n]then
          mvars.ene_eliminateTargetList[t]=n
        end
        this.RegistHoldRecoveredState(n)
        this.SetTargetOption(n)
      end
      if r[n]then
      end
    end
  end
end
function this.DeleteEliminateTargetSetting(e)
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
  return{}
end
function this.GetAllActiveEnemyWalkerGear()
  local i={}
  local e=1
  local r=0
  while r<e do
    local n=GetGameObjectIdByIndex("TppCommonWalkerGear2",r)
    if n==NULL_ID then
      break
    end
    if e==1 then
      e=SendCommand({type="TppCommonWalkerGear2"},{id="GetMaxInstanceCount"})
      if not e or e<1 then
        break
      end
    end
    local a=SendCommand(n,{id="IsBroken"})
    local e=SendCommand(n,{id="IsFultonCaptured"})
    if(a==false)and(e==false)then
      table.insert(i,n)
    end
    r=r+1
  end
  return i
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
    SendCommand(e,{id="SetVip"})SendCommand(e,{id="SetForceRealize"})SendCommand(e,{id="SetIgnoreSupportBlastInUnreal",enabled=true})
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
  GameObject.SendCommand(n,{id="SetCpMissionTarget",enable=t})
end
function this.GetPhase(e)
  local n=GetGameObjectId(e)
  return SendCommand(n,{id="GetPhase",cpName=e})
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
function this.GetStatus(n)
  local e
  if IsTypeString(n)then
    e=GetGameObjectId(n)
  else
    e=n
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
function this.IsRecovered(e)
  if not mvars.ene_recoverdStateIndexByName then
    return
  end
  local n
  if IsTypeString(e)then
    n=mvars.ene_recoverdStateIndexByName[e]
  elseif IsTypeNumber(e)then
    n=mvars.ene_recoverdStateIndexByGameObjectId[e]
  end
  if n then
    return svars.ene_isRecovered[n]
  end
end
function this.ChangeLifeState(e)
  if not Tpp.IsTypeTable(e)then
    return"Support table only"end
  local n=e.lifeState
  local t=0
  local r=4
  if not((n>t)and(n<r))then
    return"lifeState must be index"end
  local e=e.targetName
  if not IsTypeString(e)then
    return"targetName must be string"end
  local t=GetGameObjectId(e)
  if t~=NULL_ID then
    GameObject.SendCommand(t,{id="ChangeLifeState",state=n})
  else
    return"Cannot get gameObjectId. targetName = "..tostring(e)
  end
end
function this.SetSneakRoute(e,o,n,r)
  if not e then
    return
  end
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  n=n or 0
  local i=false
  if Tpp.IsTypeTable(r)then
    i=r.isRelaxed
  end
  if e~=NULL_ID then
    SendCommand(e,{id="SetSneakRoute",route=o,point=n,isRelaxed=i})
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
function this.SetCautionRoute(e,r,n,i)
  if not e then
    return
  end
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  n=n or 0
  if e~=NULL_ID then
    SendCommand(e,{id="SetCautionRoute",route=r,point=n})
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
function this.SetAlertRoute(e,r,n,i)
  if not e then
    return
  end
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  n=n or 0
  if e~=NULL_ID then
    SendCommand(e,{id="SetAlertRoute",enabled=true,route=r,point=n})
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
function this.ChangeRouteSets(n,a)
  mvars.ene_routeSetsTemporary=mvars.ene_routeSets
  mvars.ene_routeSetsPriorityTemporary=mvars.ene_routeSetsPriority
  this.MergeRouteSetDefine(n)
  mvars.ene_routeSets={}
  mvars.ene_routeSetsPriority={}
  mvars.ene_routeSetsFixedShiftChange={}
  this.UpdateRouteSet(mvars.ene_routeSetsDefine)
  local n={{{"old","immediately"},{"new","immediately"}}}
  for e,a in pairs(mvars.ene_cpList)do
    SendCommand(e,{id="ChangeRouteSets"})SendCommand(e,{id="ShiftChange",schedule=n})
  end
end
function this.InitialRouteSetGroup(e)
  local r=GetGameObjectId(e.cpName)
  local i=e.groupName
  if not IsTypeTable(e.soldierList)then
    return
  end
  local n={}
  for t,e in pairs(e.soldierList)do
    local e=GetGameObjectId(e)
    if e~=NULL_ID then
      n[t]=e
    end
  end
  if r==NULL_ID then
    return
  end
  SendCommand(r,{id="AssignSneakRouteGroup",soldiers=n,group=i})
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
function this.RegisterCombatSetting(a)
  local function r(t,e)
    local n={}
    for e,a in pairs(e)do
      n[e]=a
      if t[e]then
        n[e]=t[e]
      end
    end
    return n
  end
  if not IsTypeTable(a)then
    return
  end
  for n,e in pairs(a)do
    if e.USE_COMMON_COMBAT and mvars.loc_locationCommonCombat then
      if mvars.loc_locationCommonCombat[n]then
        if e.combatAreaList then
          e.combatAreaList=r(e.combatAreaList,mvars.loc_locationCommonCombat[n].combatAreaList)
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
      GameObject.SendCommand(t,e)
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
function this.SetDisable(e,n)
  if IsTypeString(e)then
    e=GameObject.GetGameObjectId(e)
  end
  if e~=NULL_ID then
    SendCommand(e,{id="SetEnabled",enabled=false,noAssignRoute=n})
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
function this.OnAllocate(n)
  this.SetMaxSoldierStateCount(TppDefine.DEFAULT_SOLDIER_STATE_COUNT)
  if n.enemy then
    this.SetMaxSoldierStateCount(n.enemy.MAX_SOLDIER_STATE_COUNT)
  end
  if TppCommandPost2 then
    TppCommandPost2.SetSVarsKeyNames{names="cpNames",flags="cpFlags"}
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
  mvars.ene_soldier2CommonBlockPackageLabel="default"end
function this.DeclareSVars(n)
  local e=0
  if n.enemy then
    local n=n.enemy.soldierDefine
    if n~=nil then
      for n,n in pairs(n)do
        e=e+1
      end
    end
  end
  if e==1 then
    e=2
  end
  mvars.ene_cpCount=e
  local e={{name="cpNames",arraySize=e,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="cpFlags",arraySize=e,type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solName",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solState",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solFlagAndStance",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solWeapon",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT16,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solLocation",arraySize=mvars.ene_maxSoldierStateCount*4,type=TppScriptVars.TYPE_FLOAT,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solMarker",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},{name="solFovaSeed",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solFaceFova",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT16,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solBodyFova",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT16,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solCp",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solCpRoute",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solScriptSneakRoute",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solScriptCautionRoute",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solScriptAlertRoute",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solRouteNodeIndex",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT16,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solRouteEventIndex",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT16,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solTravelName",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solTravelStepIndex",arraySize=mvars.ene_maxSoldierStateCount,type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solOptName",arraySize=TppDefine.DEFAULT_SOLDIER_OPTION_VARS_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solOptParam1",arraySize=TppDefine.DEFAULT_SOLDIER_OPTION_VARS_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solOptParam2",arraySize=TppDefine.DEFAULT_SOLDIER_OPTION_VARS_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="noticeObjectType",arraySize=TppDefine.DEFAULT_NOTICE_INFO_COUNT,type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="noticeObjectPosition",arraySize=TppDefine.DEFAULT_NOTICE_INFO_COUNT*3,type=TppScriptVars.TYPE_FLOAT,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="noticeObjectOwnerName",arraySize=TppDefine.DEFAULT_NOTICE_INFO_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="noticeObjectOwnerId",arraySize=TppDefine.DEFAULT_NOTICE_INFO_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="noticeObjectAttachId",arraySize=TppDefine.DEFAULT_NOTICE_INFO_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="solRandomSeed",arraySize=1,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hosName",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hosState",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hosFlagAndStance",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hosWeapon",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hosLocation",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT*4,type=TppScriptVars.TYPE_FLOAT,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hosMarker",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},{name="hosFovaSeed",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hosFaceFova",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hosBodyFova",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hosScriptSneakRoute",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hosRouteNodeIndex",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hosRouteEventIndex",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT16,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hosOptParam1",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hosOptParam2",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hosRandomSeed",arraySize=TppDefine.DEFAULT_HOSTAGE_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="ene_holdRecoveredStateName",arraySize=TppDefine.MAX_HOLD_RECOVERED_STATE_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="ene_isRecovered",arraySize=TppDefine.MAX_HOLD_RECOVERED_STATE_COUNT,type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
  return e
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
  SsdNpcHumanCommonBlockController.SetPackagePathWithPrerequisites{path=t,prerequisites=a}
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
  while not SsdNpcHumanCommonBlockController.IsReady()do
    coroutine.yield()
  end
end
function this.UnloadSoldier2CommonBlock()SsdNpcHumanCommonBlockController.SetPackagePathWithPrerequisites{}
end
function this.SetMaxSoldierStateCount(e)
  if Tpp.IsTypeNumber(e)and(e>0)then
    mvars.ene_maxSoldierStateCount=e
  end
end
function this.RestoreOnMissionStart2()
  local n=0
  local t=0
  if NpcFova~=nil then
    if NpcFova.INVALID_FOVA_VALUE~=nil then
      n=NpcFova.INVALID_FOVA_VALUE
      t=NpcFova.INVALID_FOVA_VALUE
    end
  end
  local e=0
  if mvars.ene_cpList~=nil then
    for t,n in pairs(mvars.ene_cpList)do
      if e<mvars.ene_cpCount then
        svars.cpNames[e]=StrCode32(n)svars.cpFlags[e]=0
        e=e+1
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
    svars.solFaceFova[e]=n
    svars.solBodyFova[e]=t
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
end
function this.RestoreOnContinueFromCheckPoint2()do
  local e={type="TppCommandPost2"}SendCommand(e,{id="RestoreFromSVars"})
end
end
function this.RestoreOnContinueFromCheckPoint()
  this._RestoreOnContinueFromCheckPoint_Hostage()
end
function this.RestoreOnMissionStart()
  this._RestoreOnMissionStart_Hostage()
end
function this.StoreSVars(n)
  local e=false
  if n then
    e=true
  end
  do
    local e={type="TppCommandPost2"}SendCommand(e,{id="StoreToSVars"})
  end
end
function this.PreMissionLoad(e,n)
  TppEneFova.PreMissionLoad(e,n)
end
function this.Init(n)
  mvars.ene_routeAnimationGaniPathTable={{"SoldierLookWatch","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_a.gani"},{"SoldierWipeFace","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_d.gani"},{"SoldierYawn","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_f.gani"},{"SoldierSneeze","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_g.gani"},{"SoldierFootStep","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_h.gani"},{"SoldierCough","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_i.gani"},{"SoldierScratchHead","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_o.gani"},{"SoldierHungry","/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_p.gani"},nil}
  mvars.ene_eliminateTargetList={}
  mvars.ene_routeSets={}
  mvars.ene_noShiftChangeGroupSetting={}
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  this.RegistCommonRoutePointMessage()
  if n.enemy then
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
      for n,e in pairs(t)do
        mvars.ene_cpLinkDefine[n]=mvars.ene_cpLinkDefine[n]or{}
        for a,e in ipairs(mvars.ene_lrrpNumberDefine)do
          mvars.ene_cpLinkDefine[e]=mvars.ene_cpLinkDefine[e]or{}
          if t[n][e]then
            mvars.ene_cpLinkDefine[n][e]=true
            mvars.ene_cpLinkDefine[e][n]=true
          else
            mvars.ene_cpLinkDefine[n][e]=false
            mvars.ene_cpLinkDefine[e][n]=false
          end
        end
      end
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
function this.OnMessage(a,t,n,i,r,o,s)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,a,t,n,i,r,o,s)
end
function this.DefineSoldiers(n)
  mvars.ene_soldierDefine={}
  Tpp.MergeTable(mvars.ene_soldierDefine,n,true)
  mvars.ene_soldierIDList={}
  mvars.ene_cpList={}
  mvars.ene_baseCpList={}
  mvars.ene_outerBaseCpList={}
  mvars.ene_holdTimes={}
  mvars.ene_sleepTimes={}
  mvars.ene_lrrpTravelPlan={}
  for r,t in pairs(n)do
    local n=GetGameObjectId(r)
    if n==NULL_ID then
    else
      mvars.ene_cpList[n]=r
      mvars.ene_holdTimes[n]=this.DEFAULT_HOLD_TIME
      mvars.ene_sleepTimes[n]=this.DEFAULT_SLEEP_TIME
      mvars.ene_soldierIDList[n]={}
      if t.lrrpTravelPlan then
        mvars.ene_lrrpTravelPlan[n]=t.lrrpTravelPlan
      end
      for t,r in pairs(t)do
        if IsTypeString(t)then
          if not this.SOLDIER_DEFINE_RESERVE_TABLE_NAME[t]then
          end
        else
          local e=GetGameObjectId(r)
          if e==NULL_ID then
          else
            mvars.ene_soldierIDList[n][e]=t
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
  local n=TppMission.GetMissionID()
  for r,n in pairs(mvars.ene_soldierDefine)do
    local n=GetGameObjectId(r)
    if n==NULL_ID then
    else
      if string.sub(r,-4)=="lrrp"then
        SendCommand(n,{id="SetLrrpCp"})
      end
      local a=string.sub(r,-2)
      if a=="ob"then
        GameObject.SendCommand(n,{id="SetOuterBaseCp"})
        mvars.ene_outerBaseCpList[n]=true
      end
      if a=="cp"then
        local t=true
        if r=="mafr_outland_child_cp"then
          t=false
        end
        if t then
          this.AddCpIntelTrapTable(r)
          mvars.ene_baseCpList[n]=true
        end
      end
      if mvars.loc_locationSiren then
        local e=mvars.loc_locationSiren[r]
        if e then
          SendCommand(n,{id="SetCpSirenType",type=e.sirenType,pos=e.pos})
        end
      end
    end
  end
  for e,n in pairs(mvars.ene_cpList)do
    if mvars.ene_baseCpList[e]then
      local e=mvars.ene_soldierDefine[n]
      for n,e in ipairs(e)do
        local e=GetGameObjectId(e)
        if e==NULL_ID then
        else
          SendCommand(e,{id="AddRouteAssignMember"})
        end
      end
    end
  end
  for n,r in pairs(mvars.ene_cpList)do
    if not mvars.ene_baseCpList[n]then
      local e=mvars.ene_soldierDefine[r]
      for n,e in ipairs(e)do
        local e=GetGameObjectId(e)
        if e==NULL_ID then
        else
          SendCommand(e,{id="AddRouteAssignMember"})
        end
      end
    end
  end
  this.AssignSoldiersToCP()
end
function this.AssignSoldiersToCP()
  local r=TppMission.GetMissionID()
  this._ConvertSoldierNameKeysToId(mvars.ene_soldierTypes)
  mvars.ene_soldierSubType=mvars.ene_soldierSubType or{}
  mvars.ene_soldierLrrp=mvars.ene_soldierLrrp or{}
  local i=this.subTypeOfCp
  for a,n in pairs(mvars.ene_soldierIDList)do
    local o=mvars.ene_cpList[a]
    local i=i[o]
    local s=false
    for n,l in pairs(n)do
      SendCommand(n,{id="SetCommandPost",cp=o})
      if mvars.ene_lrrpTravelPlan[a]then
        SendCommand(n,{id="SetLrrp",travelPlan=mvars.ene_lrrpTravelPlan[a]})
        mvars.ene_soldierLrrp[n]=true
      end
      local t
      local e=this.GetSoldierType(n)t={id="SetSoldier2Type",type=e}
      GameObject.SendCommand(n,t)
      if(e~=EnemyType.TYPE_SKULL and e~=EnemyType.TYPE_CHILD)and i then
        mvars.ene_soldierSubType[n]=i
      end
      if r~=10080 and r~=11080 then
        if e==EnemyType.TYPE_CHILD then
          s=true
        end
      end
    end
    if s then
      SendCommand(a,{id="SetChildCp"})
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
  for e,n in pairs(mvars.loc_locationCommonCpGroups)do
    if IsTypeTable(n)then
      mvars.ene_cpGroups[e]={}
      for t,a in pairs(mvars.ene_soldierDefine)do
        if n[t]then
          table.insert(mvars.ene_cpGroups[e],t)
        end
      end
    end
  end
end
function this.SetCpGroups()
  local e={type="TppCommandPost2"}
  local n={id="SetCpGroups",cpGroups=mvars.ene_cpGroups}SendCommand(e,n)
end
function this.AddCpIntelTrapTable(e)
  mvars.ene_cpIntelTrapTable=mvars.ene_cpIntelTrapTable or{}
  mvars.ene_cpIntelTrapTable[e]="trap_intel_"..e
end
function this.GetCpIntelTrapTable()
  return mvars.ene_cpIntelTrapTable
end
function this.GetCurrentRouteSetType(t,i,a)
  local r=function(n,e)
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
      n=r(a,t)
    else
      n="caution"end
  else
    if i==this.PHASE.SNEAK then
      n=r(a)
    else
      n="caution"end
  end
  return n
end
function this.GetPrioritizedRouteTable(e,n,t,i)
  local r={}
  local a=t[e]
  if not IsTypeTable(a)then
    return
  end
  if mvars.ene_funcRouteSetPriority then
    r=mvars.ene_funcRouteSetPriority(e,n,t,i)
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
    for i=1,t do
      for a,t in ipairs(a)do
        local n=n[t]
        if n then
          local n=n[i]
          if n and Tpp.IsTypeTable(n)then
            r[e]=n
            e=e+1
          end
        end
      end
    end
    for i=1,t do
      for a,t in ipairs(a)do
        local n=n[t]
        if n then
          local n=n[i]
          if n and not Tpp.IsTypeTable(n)then
            r[e]=n
            e=e+1
          end
        end
      end
    end
  end
  return r
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
    local r=this.GetCurrentRouteSetType(nil,this.PHASE.SNEAK,n)
    return this.GetPrioritizedRouteTable(n,t[r],mvars.ene_routeSetsPriority,a)
  end
  if a==StrCode32"SYS_Caution"then
    local r=this.GetCurrentRouteSetType(nil,this.PHASE.CAUTION,n)
    return this.GetPrioritizedRouteTable(n,t[r],mvars.ene_routeSetsPriority,a)
  end
  local r=this.GetCurrentRouteSetType(i,this.GetPhaseByCPID(n),n)
  local a=t[r][a]
  if a then
    return a
  else
    if r=="hold"then
      local a=this.GetCurrentRouteSetType(nil,this.GetPhaseByCPID(n),n)
      return this.GetPrioritizedRouteTable(n,t[a],mvars.ene_routeSetsPriority)
    else
      local a=this.GetCurrentRouteSetType(nil,this.GetPhaseByCPID(n),n)
      return this.GetPrioritizedRouteTable(n,t[a],mvars.ene_routeSetsPriority)
    end
  end
end
this.STR32_CAN_USE_SEARCH_LIGHT=StrCode32"CanUseSearchLight"this.STR32_CAN_NOT_USE_SEARCH_LIGHT=StrCode32"CanNotUseSearchLight"this.STR32_IS_GIMMICK_BROKEN=StrCode32"IsGimmickBroken"this.STR32_IS_NOT_GIMMICK_BROKEN=StrCode32"IsNotGimmickBroken"function this.SetUpSwitchRouteFunc()
end
function this.SwitchRouteFunc(a,t,n,a,a)
  if t==this.STR32_CAN_USE_SEARCH_LIGHT then
    local e=mvars.gim_gimmackNameStrCode32Table[n]
    if TppGimmick.IsBroken{gimmickId=e}then
      return false
    else
      if TppClock.GetTimeOfDay()~="night"then
        return false
      end
      return true
    end
  end
  if t==this.STR32_CAN_NOT_USE_SEARCH_LIGHT then
    local e=mvars.gim_gimmackNameStrCode32Table[n]
    if TppGimmick.IsBroken{gimmickId=e}then
      return true
    else
      if TppClock.GetTimeOfDay()~="night"then
        return true
      end
      return false
    end
  end
  if t==this.STR32_IS_GIMMICK_BROKEN then
    local e=mvars.gim_gimmackNameStrCode32Table[n]
    if TppGimmick.IsBroken{gimmickId=e}then
      return true
    else
      return false
    end
  end
  if t==this.STR32_IS_NOT_GIMMICK_BROKEN then
    local e=mvars.gim_gimmackNameStrCode32Table[n]
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
  for n,a in pairs(mvars.ene_cpList)do
    SendCommand(n,{id="SetRouteSelector",func=this.RouteSelector})
  end
end
function this.RegisterRouteAnimation()
  if TppRouteAnimationCollector then
    TppRouteAnimationCollector.ClearGaniPath()
    TppRouteAnimationCollector.RegisterGaniPath(mvars.ene_routeAnimationGaniPathTable)
  end
end
function this.MergeRouteSetDefine(i)
  local function a(n,t)
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
        for a,t in pairs(t[e])do
          mvars.ene_routeSetsDefine[n][e][a]={}
          if IsTypeTable(t)then
            for r,t in ipairs(t)do
              mvars.ene_routeSetsDefine[n][e][a][r]=t
            end
          end
        end
      end
    end
  end
  for e,n in pairs(i)do
    mvars.ene_routeSetsDefine[e]=mvars.ene_routeSetsDefine[e]or{}
    local n=n
    if n.walkergearpark then
      local e=GetGameObjectId(e)SendCommand(e,{id="SetWalkerGearParkRoute",routes=n.walkergearpark})
    end
    if mvars.loc_locationCommonRouteSets then
      if mvars.loc_locationCommonRouteSets[e]then
        if mvars.loc_locationCommonRouteSets[e].outofrain then
          local a=GetGameObjectId(e)
          if n.outofrain then
            SendCommand(a,{id="SetOutOfRainRoute",routes=n.outofrain})
          else
            SendCommand(a,{id="SetOutOfRainRoute",routes=mvars.loc_locationCommonRouteSets[e].outofrain})
          end
        end
      end
      if n.USE_COMMON_ROUTE_SETS then
        if mvars.loc_locationCommonRouteSets[e]then
          a(e,mvars.loc_locationCommonRouteSets[e])
        end
      end
    end
    a(e,n)
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
        for e,t in pairs(mvars.ene_noShiftChangeGroupSetting[n])do
          mvars.ene_routeSetsFixedShiftChange[n][e]=t
        end
      end
      for a,e in pairs(this.ROUTE_SET_TYPES)do
        mvars.ene_routeSets[n][e]=mvars.ene_routeSets[n][e]or{}
        if t[e]then
          for t,a in pairs(t[e])do
            mvars.ene_routeSets[n][e][StrCode32(t)]=mvars.ene_routeSets[n][e][StrCode32(t)]or{}
            if type(a)=="number"then
            else
              for i,a in ipairs(a)do
                mvars.ene_routeSets[n][e][StrCode32(t)][i]=a
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
  for e,r in pairs(mvars.ene_shiftChangeTable[t])do
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
function this._GetShiftChangeRouteGroup(n,i,r,s,p,a,l,t)
  local e=(i-r)+1
  local o=r
  if t[n[r]]then
    e=o
  else
    local a=0
    for r=1,r do
      if t[n[r]]then
        a=a+1
      end
    end
    e=e+a
    local a=0
    for r=e,i do
      if t[n[r]]then
        a=a+1
      end
    end
    e=e-a
    local a=e
    local r=0
    local i=t[n[a]]
    while i do
      r=r+1
      a=a-1
      i=t[n[a]]
    end
    e=e-r
  end
  local r=n[e]
  local t="default"if s[a]then
    t=a
  end
  local e=nil
  if l then
    e="default"if p[a]then
      e=a
    end
  end
  local n=n[o]
  return r,t,e,n
end
function this._MakeShiftChangeUnit(n,a,t,o,l,i,d,p,_,f,u)
  if mvars.ene_noShiftChangeGroupSetting[n]and mvars.ene_noShiftChangeGroupSetting[n][t]then
    return nil
  end
  local t,i,e,a=this._GetShiftChangeRouteGroup(a,p,_,o,i,t,l,u)
  local e={}
  for n,t in pairs(mvars.ene_shiftChangeTable[n])do
    e[n]={}
  end
  if(i~="default")or(IsTypeTable(o[StrCode32"default"])and next(o[StrCode32"default"]))then
    e.shiftAtNight.start={"day",t}
    e.shiftAtNight.hold={"hold",i}
    e.shiftAtNight.holdTime=mvars.ene_holdTimes[n]
    e.shiftAtNight.goal={"night",a}
    e.shiftAtMorning.hold={"hold",i}
    e.shiftAtMorning.holdTime=mvars.ene_holdTimes[n]
    e.shiftAtMorning.goal={"day",a}
  else
    e.shiftAtNight.start={"day",t}
    e.shiftAtNight.goal={"night",a}
    e.shiftAtMorning.goal={"day",a}
  end
  if l then
    e.shiftAtMidNight.start={"night",t}
    e.shiftAtMidNight.hold={"sleep",i}
    e.shiftAtMidNight.holdTime=mvars.ene_sleepTimes[n]
    if d then
      e.shiftAtMidNight.goal={"midnight",a}
    else
      e.shiftAtMidNight.goal={"night",t}
    end
    e.shiftAtMorning.start={"midnight",t}
  else
    e.shiftAtMorning.start={"night",t}
  end
  return e
end
function this.MakeShiftChangeTable()
  mvars.ene_shiftChangeTable={}
  for n,a in pairs(mvars.ene_routeSetsPriority)do
    if not IsTypeTable(a)then
      return
    end
    local r=false
    local o=false
    if next(mvars.ene_routeSets[n].sleep)then
      mvars.ene_shiftChangeTable[n]={shiftAtNight={},shiftAtMorning={},shiftAtMidNight={}}r=true
      if next(mvars.ene_routeSets[n].sneak_midnight)then
        o=true
      end
    else
      mvars.ene_shiftChangeTable[n]={shiftAtNight={},shiftAtMorning={}}
    end
    local _=mvars.ene_routeSets[n].hold
    local s=nil
    if r then
      s=mvars.ene_routeSets[n].sleep
    end
    local t=1
    local d=#a
    for p,l in ipairs(a)do
      local i
      i=this._MakeShiftChangeUnit(n,a,l,_,r,s,o,d,p,t,mvars.ene_routeSetsFixedShiftChange[n])
      if i then
        this._InsertShiftChangeUnit(n,t,i)t=t+1
      end
    end
  end
end
function this.ShiftChangeByTime(n)
  if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
    return
  end
  if not IsTypeTable(mvars.ene_shiftChangeTable)then
    return
  end
  for a,e in pairs(mvars.ene_shiftChangeTable)do
    if e[n]then
      SendCommand(a,{id="ShiftChange",schedule=e[n]})
    end
  end
end
local function d(a,n,e)
  local e=SendCommand(e,{id="GetPosition"})
  local e=n-e
  local e=e:GetLengthSqr()
  if e>a then
    return false
  else
    return true
  end
end
function this.MakeCpLinkDefineTable(t,a)
  local e={}
  for n=1,#a do
    local a=Tpp.SplitString(a[n],"	")
    local n=t[n]
    if n then
      e[n]=e[n]or{}
      for a,r in pairs(a)do
        local t=t[a]
        if t then
          e[n][t]=e[n][t]or{}
          local a=false
          if tonumber(r)>0 then
            a=true
          end
          e[n][t]=a
        end
      end
    end
  end
  return e
end
function this.MakeReinforceTravelPlan(r,a,s,n,t)
  if not Tpp.IsTypeTable(t)then
    return
  end
  local a=a[n]
  if a==nil then
    return
  end
  mvars.ene_travelPlans=mvars.ene_travelPlans or{}
  local i=0
  for i,t in pairs(t)do
    if mvars.ene_soldierDefine[t]then
      if a[t]then
        local o=r[n]
        local i=r[t]
        local a="rp_"..(n..("_From_"..t))
        mvars.ene_travelPlans[a]=mvars.ene_travelPlans[a]or{}
        local l=string.format("rp_%02dto%02d",i,o)
        local e=this.GetFormattedLrrpCpNameByLrrpNum(o,i,s,r)
        mvars.ene_travelPlans[a]={{cp=e,routeGroup={"travel",l}},{cp=n,finishTravel=true}}
        mvars.ene_reinforcePlans[a]={{toCp=n,fromCp=t,type="respawn"}}
      end
    end
  end
end
function this.MakeTravelPlanTable(p,_,d,t,n,u)
  if((not Tpp.IsTypeTable(n)or not Tpp.IsTypeTable(n[1]))or not Tpp.IsTypeString(t))or(n[1].cp==nil and n[1].base==nil)then
    return
  end
  mvars.ene_travelPlans=mvars.ene_travelPlans or{}
  mvars.ene_travelPlans[t]=mvars.ene_travelPlans[t]or{}
  local o=mvars.ene_travelPlans[t]
  local l=#n
  local r,i
  if(not n.ONE_WAY)and n[#n].base then
    r=n[#n]
  end
  for t=1,l do
    local a
    if n.ONE_WAY and(t==l)then
      a=true
    end
    if n[t].base then
      if t==1 then
        i=n[t]
      else
        r=n[t-1]i=n[t]
      end
      this.AddLinkedBaseTravelCourse(p,_,d,u,o,r,i,a)
    elseif n[t].cp then
      local n=n[t]
      if IsTypeTable(n)then
        this.AddTravelCourse(o,n,a)
      end
    end
  end
end
function this.AddLinkedBaseTravelCourse(p,d,o,r,s,a,t,l)
  local n
  if a and a.base then
    n=a.base
  end
  local a=t.base
  local i=false
  if n then
    i=d[n][a]
  end
  if i then
    local t,n=this.GetFormattedLrrpCpName(n,a,o,p)
    local n={cp=t,routeGroup={"travel",n}}
    this.AddTravelCourse(s,n)
  elseif n==nil then
  end
  local o
  if t.wait then
    o=t.wait
  else
    o=r
  end
  local r
  if t.routeGroup and Tpp.IsTypeTable(t.routeGroup)then
    r={t.routeGroup[1],t.routeGroup[2]}
  else
    local t
    local e=mvars.ene_defaultTravelRouteGroup
    if((e and i)and e[n])and Tpp.IsTypeTable(e[n][a])then
      t=e[n][a]
    end
    if t then
      r={t[1],t[2]}
    else
      r={"travel","lrrpHold"}
    end
  end
  local n={cp=a,routeGroup=r,wait=o}
  this.AddTravelCourse(s,n,l)
end
function this.GetFormattedLrrpCpNameByLrrpNum(e,n,r,t)
  local t,a
  if e<n then
    t=e
    a=n
  else
    t=n
    a=e
  end
  local t=string.format("%s_%02d_%02d_lrrp",r,t,a)
  local e=string.format("lrrp_%02dto%02d",e,n)
  return t,e
end
function this.GetFormattedLrrpCpName(t,a,i,n)
  local r=n[t]
  local t=n[a]
  return this.GetFormattedLrrpCpNameByLrrpNum(r,t,i,n)
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
      for t,i in pairs(i)do
        this.MakeTravelPlanTable(r,a,n,t,i,this.DEFAULT_TRAVEL_HOLD_TIME)
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
  if next(mvars.ene_reinforcePlans)then
    SendCommand({type="TppCommandPost2"},{id="SetReinforcePlan",reinforcePlan=mvars.ene_reinforcePlans})
  end
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
  for n=0,(TppDefine.MAX_HOLD_RECOVERED_STATE_COUNT-1)do
    local a=svars.ene_holdRecoveredStateName[n]
    if(a==0)or(a==t)then
      e=n
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
function this.ExecuteOnRecoveredCallback(n,o,s,i,r,a,t)
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
  e(n,o,s,i,r,a,t)
end
local _=10*10
function this.CheckAllVipClear(n)
  return this.CheckAllTargetClear(n)
end
function this.CheckAllTargetClear(n)
  local n=mvars
  local t=this
  local a=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
  local e={{n.ene_eliminateTargetList,t.CheckSoldierEliminateTarget,"EliminateTargetSoldier"}}
  if n.ene_rescueTargetOptions then
    if not n.ene_rescueTargetOptions.orCheck then
      table.insert(e,{n.ene_rescueTargetList,t.CheckRescueTarget,"RescueTarget"})
    end
  end
  for n=1,#e do
    local e,n,t=e[n][1],e[n][2],e[n][3]
    if IsTypeTable(e)and next(e)then
      for e,t in pairs(e)do
        if not n(e,a,t)then
          return false
        end
      end
    end
  end
  if n.ene_rescueTargetOptions and n.ene_rescueTargetOptions.orCheck then
    local e=false
    for n,r in pairs(n.ene_rescueTargetList)do
      if t.CheckRescueTarget(n,a,r)then
        e=true
      end
    end
    return e
  end
  return true
end
function this.CheckSoldierEliminateTarget(n,r,a)
  local a=SendCommand(n,{id="GetLifeStatus"})
  local t=SendCommand(n,{id="GetStatus"})
  if this._IsEliminated(a,t)then
    return true
  elseif this._IsNeutralized(a,t)then
    if d(_,r,n)then
      return true
    else
      return false
    end
  end
  return false
end
function this.FultonRecoverOnMissionGameEnd()
  if mvars.ene_soldierIDList==nil then
    return
  end
  local t=Vector3(vars.playerPosX,vars.playerPosY,vars.playerPosZ)
  local n=10
  local r=n*n
  local a=false
  for i,n in pairs(mvars.ene_soldierIDList)do
    for n,i in pairs(n)do
      if d(r,t,n)then
        this.AutoFultonRecoverNeutralizedTarget(n,a)
      end
    end
  end
  local e=this.GetAllHostages()
  for n,e in pairs(e)do
    if d(r,t,e)then
      local n=TppMotherBaseManagement.GetStaffIdFromGameObject{gameObjectId=e}
      TppTerminal.OnFulton(e,nil,nil,n,true,a,PlayerInfo.GetLocalPlayerIndex())
    end
  end
end
function this.AutoFultonRecoverNeutralizedTarget(n,a)
  local t=SendCommand(n,{id="GetLifeStatus"})
  if t==this.LIFE_STATUS.SLEEP or t==this.LIFE_STATUS.FAINT then
    local e
    e=TppMotherBaseManagement.GetStaffIdFromGameObject{gameObjectId=n}
    TppTerminal.OnFulton(n,nil,nil,e,nil,a,PlayerInfo.GetLocalPlayerIndex())
  end
end
function this.ChangeRouteUsingGimmick(e,a,n,a)
  local a=TppGimmick.GetRouteConnectedGimmickId(e)
  if(a~=nil)and TppGimmick.IsBroken{gimmickId=a}then
    local a
    for t,e in pairs(mvars.ene_soldierIDList)do
      if e[n]then
        a=t
        break
      end
    end
    if a then
      local e={id="SetRouteEnabled",routes={e},enabled=false}SendCommand(a,e)
    end
  else
    mvars.ene_usingGimmickRouteEnemyList=mvars.ene_usingGimmickRouteEnemyList or{}
    mvars.ene_usingGimmickRouteEnemyList[e]=mvars.ene_usingGimmickRouteEnemyList[e]or{}
    mvars.ene_usingGimmickRouteEnemyList[e]=n
    SendCommand(n,{id="SetSneakRoute",route=e})
  end
end
function this.DisableUseGimmickRouteOnShiftChange(a,e)
  if not IsTypeTable(e)then
    return
  end
  if mvars.ene_usingGimmickRouteEnemyList==nil then
    return
  end
  for n,e in pairs(e)do
    local n=StrCode32(e)
    local n=mvars.ene_usingGimmickRouteEnemyList[n]
    if n then
      SendCommand(n,{id="SetSneakRoute",route=""})
    end
    local n=mvars.gim_routeGimmickConnectTable[StrCode32(e)]
    if(n~=nil)and TppGimmick.IsBroken{gimmickId=n}then
      local e={id="SetRouteEnabled",routes={e},enabled=false}SendCommand(a,e)
    end
  end
end
function this.IsEliminateTarget(e)
  local e=mvars.ene_eliminateTargetList and mvars.ene_eliminateTargetList[e]
  local e=e
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
function this.AddTakingOverHostage(e)
end
function this._AddTakingOverHostage(n)
  if gvars.ene_takingOverHostageCount>=TppDefine.MAX_TAKING_OVER_HOSTAGE_COUNT then
    return
  end
  local e=gvars.ene_takingOverHostageCount
  local a=SendCommand(n,{id="GetPosition"})
  local i,r=SendCommand(n,{id="GetStaffId",divided=true})
  local o=SendCommand(n,{id="GetFaceId"})
  local n=SendCommand(n,{id="GetKeepFlagValue"})
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
function this._SpawnTakingOverHostage(n,e)
  local e=GetGameObjectId(e)
  if e==NULL_ID then
    return
  end
  if n<gvars.ene_takingOverHostageCount then
    local a=gvars.ene_takingOverHostageStaffIdsUpper[infoIndex]
    local r=gvars.ene_takingOverHostageStaffIdsLower[infoIndex]SendCommand(e,{id="SetStaffId",divided=true,staffId=a,staffId2=r})
    if TppMission.IsMissionStart()then
      SendCommand(e,{id="SetEnabled",enabled=true})
      local a=Vector3(gvars.ene_takingOverHostagePositions[n*3],gvars.ene_takingOverHostagePositions[n*3+1],gvars.ene_takingOverHostagePositions[n*3+2])SendCommand(e,{id="Warp",position=a})SendCommand(e,{id="SetFaceId",faceId=gvars.ene_takingOverHostageFaceIds[n]})SendCommand(e,{id="SetKeepFlagValue",keepFlagValue=gvars.ene_takingOverHostageFlags[n]})
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
function this.SetIgnoreDisableNpc(n,r)
  local e
  if IsTypeNumber(n)then
    e=n
  elseif IsTypeString(n)then
    e=GetGameObjectId(n)
  else
    return
  end
  if e==NULL_ID then
    return
  end
  SendCommand(e,{id="SetIgnoreDisableNpc",enable=r})
  return true
end
function this.GetDDSuit()
  local n=TppDefine.FOB_EVENT_ID_LIST.ARMOR
  local t=TppServerManager.GetEventId()
  for a,n in ipairs(n)do
    if t==n then
      return this.FOB_PF_SUIT_ARMOR
    end
  end
  local n=this.weaponIdTable.DD.NORMAL.SNEAKING_SUIT
  if n and n>0 then
    return this.FOB_DD_SUIT_SNEAKING
  end
  local n=this.weaponIdTable.DD.NORMAL.BATTLE_DRESS
  if n and n>0 then
    return this.FOB_DD_SUIT_BTRDRS
  end
  return this.FOB_DD_SUIT_ATTCKER
end
function this.SetRespawnFlagAllForEnemyNpcs()
  for t,n in ipairs(TppDefine.ENEMY_TYPE_LIST)do
    this._SetRespawnFlagAllForGameObjectType(n)
  end
end
function this.RespawnAllForEnemyNpcs()
  for t,n in ipairs(TppDefine.ENEMY_TYPE_LIST)do
    this._RespawnAllForGameObjectType(n)
  end
end
function this.StartWave(t,i,a)
  local o=t.."_01"local r=TppMission.GetWaveLimitTime(t)
  if not r then
    return
  end
  local n
  if IsTypeTable(a)then
    n=a.useSpecifiedAreaEnemy
  end
  if n then
    for t,n in ipairs(n)do
      this.SetWaveAttacker(n)
    end
  end
  if i then
    this.EnableWaveSpawnPointEffect(t)Mission.EnableWaveEffect()
  end
  Mission.StartWave{waveName=o,waveLimitTime=r}
  return true
end
function this.SetWaveAttacker(e)
  if not IsTypeTable(e)then
    return
  end
  if not e.pos then
    return
  end
  if not e.radius then
    return
  end
  local t=e.pos
  local n=e.radius
  for a,e in ipairs(TppDefine.WAVE_ENEMY_TYPE_LIST)do
    if GameObject.GetGameObjectIdByIndex(e,0)~=GameObject.NULL_ID then
      GameObject.SendCommand({type=e},{id="SetWaveAttacker",pos=t,radius=n})
    end
  end
end
function this.SetUnrealAllFreeZombie(n)
  for t,e in ipairs(TppDefine.ZOMBIE_TYPE_LIST)do
    if GameObject.GetGameObjectIdByIndex(e,0)~=GameObject.NULL_ID then
      GameObject.SendCommand({type=e},{id="SetUnrealWithFree",unreal=n})
    end
  end
end
function this.StartWaveInterval(n)
  this.KillWaveEnemy{effectName="explosion_d50010",soundName="sfx_s_waveend_plasma"}
  GameObject.SendCommand({type="TppCommandPost2"},{id="EndWave"})
  this.EnableWaveSpawnPointEffect(n)
end
function this.MakeSpawnSettingTable(n,r,i)
  local a={}
  local t={}
  for o,n in ipairs(n)do
    local r=r[n]
    this._MakeSpawnSettingTable(n,i,a,r,t)
  end
  return a,t
end
function this._MakeSpawnSettingTable(n,t,_,e,a)
  if not e then
    return
  end
  for d,e in ipairs(e)do
    local e,o,i,s,u,l=e[2],e[3],e[4],e[5],e[6],e[7]
    local t=t[e]
    if t then
      local e=t.radius
      local r=6
      if IsTypeNumber(e)then
        if(e>r)then
          e=nil
        elseif(e<=0)then
          e=nil
        end
      end
      e=e or r
      local r=string.format("spawn_"..(n.."_%04d"),d)_[r]={locatorSet=t,enemySet={{type=o,count=i,radius=e,groupId=Fox.StrCode32(n),level=s,speedType=u,useRouteSpeed=l}}}
      local e=t.spawnLocator
      a[n]=a[n]or{}a[n][e]=true
    end
  end
end
function this.MakeWaveSettingTable(e,n)
  local a={}
  for t,e in ipairs(e)do
    local t=n[e]
    if t then
      for n,r in ipairs(t)do
        local i=string.format(e.."_%02d",n)
        local o=string.format("spawn_"..(e.."_%04d"),n)
        local r,e=r[1],string.format(e.."_%02d",n+1)
        if not t[n+1]then
          e=nil
        end
        a[i]={type="auto",spawnTableName=o,waitTime=r,nextWave=e}
      end
    end
  end
  return a
end
function this.RegisterWaveSpawnPointList(e)
  if not Tpp.IsTypeTable(e)then
    return
  end
  mvars.ene_waveSpawnPointList=e
end
function this.EnableWaveSpawnPointEffect(e)
  mvars.ene_waveNameForOldEnableWaveEffect=e
  if Mission.SetWaveNameForOldStartWave then
    Mission.SetWaveNameForOldStartWave(e)
  end
end
function this._EnableWaveSpawnPointEffect(e)
  if not mvars.ene_waveSpawnPointList then
    return
  end
  local e=mvars.ene_waveSpawnPointList[e]
  if not e then
    return
  end
  local n={}
  for e,t in pairs(e)do
    table.insert(n,e)
    GameObject.SendCommand({type="TppCommandPost2"},{id="EnableWaveEffect",locatorName=e,enabled=true})
  end
end
function this.SetVisibleEnemyLane(e)
  local n={}
  for t=1,#e do
    table.insert(n,{routeName=e[t],width=2})
  end
  MapInfoSystem.SetVisibleEnemyRouteInfos(n)
  TppEffectUtility.CreateEnemyRootView()
end
function this.SetEnemyLevelForBaseDefense()
  local n,t=TppStory.GetMissionEnemyLevel()
  if n<0 then
    n=0
  end
  t=0
  for r,a in ipairs(TppDefine.ENEMY_TYPE_LIST)do
    this._SetEnemyLevel(a,n,t)
  end
  Mission.SetBaseEnemyLevel(n,t)
end
--RETAILPATCH: 1.0.5.0 reworked
function this.SetEnemyLevelForBaseDefense()
  local currentMissionCodeForBase=BaseDefenseManager.GetCurrentMissionCode()
  local enemyBaseLevel=BaseDefenseManager.GetEnemyBaseLevel(currentMissionCodeForBase)
  if enemyBaseLevel==nil then
    enemyBaseLevel=21
  end
  local unkP2=0
  for i,unkI2 in ipairs(TppDefine.ENEMY_TYPE_LIST)do
    this._SetEnemyLevel(unkI2,enemyBaseLevel,unkP2)
  end
  Mission.SetBaseEnemyLevel(enemyBaseLevel,unkP2)
end
function this.SetEnemyLevelCreatureBlock(a,t,n,r)
  if r then
    t,n=TppStory.GetMissionEnemyLevel()
  end
  if not Tpp.IsTypeTable(a)then
    return
  end
  for r,a in ipairs(a)do
    this._SetEnemyLevel(a,t,n)
  end
  Mission.SetBaseEnemyLevel(t,n)
end
function this.SetEnemyLevelBySequence(r)
  local t,n=TppStory.GetMissionEnemyLevel()
  if t<0 then
    t=0
  end
  if n<0 then
    n=0
  end
  local a=0
  if r>=TppDefine.STORY_SEQUENCE.STORY_FINISH then
    local e=t+n
    a=SsdSbm.GetPlayerLevel()-e
    if(a>0)then
      n=n+a
    end
  end
  local r=TppStory.GetRegionEnemyLevel()
  for i,a in ipairs(TppDefine.ENEMY_TYPE_LIST)do
    this._SetEnemyLevel(a,t,n,r)
  end
  Mission.SetBaseEnemyLevel(t,n)
end
function this.SetEnemyLevelByRegion(r,t)
  local e=TppLocation.GetLocationName()
  if not e then
    return
  end
  local n=TppDefine.ENEMY_REGION_DEFINE[e]
  if not n then
    return
  end
  local e=t[e]
  if not e then
    return
  end
  for n,t in ipairs(n)do
    local a=false
    local e=e[t]
    if e then
      if IsTypeNumber(e.level)then
        a=true
        local n={id="SetAreaLv"}n.level=e.level
        n.randVal=e.randomRange
        n.areaName=t
        GameObject.SendCommand(r,n)
      elseif IsTypeNumber(e.fixLevel)then
        a=true
        local n={id="SetLevel"}n.level=e.fixLevel
        n.randVal=e.randomRange
        n.areaName=t
        GameObject.SendCommand(r,n)
      end
    end
    if not a then
      GameObject.SendCommand(r,{id="ResetAreaLv",areaName=t})
    end
  end
end
function this.SetEnemyLevelByEnemyType(n)
  if not Tpp.IsTypeTable(n)then
    return
  end
  local r=n.groupLocatorNameList
  if not Tpp.IsTypeTable(r)then
    return
  end
  n.groupLocatorNameList=nil
  local e={id="SetLevel"}
  local i={id="ReloadLevel"}
  local function o(t,n)
    if not Tpp.IsTypeTable(n)then
      return
    end
    if(GameObject.GetGameObjectIdByIndex(t,0)==NULL_ID)then
      return
    end
    local t={type=t}
    e.level=n.level or 0
    e.randVal=n.randomRange or 0
    for a,n in ipairs(r)do
      e.areaName=n
      GameObject.SendCommand(t,e)
    end
    GameObject.SendCommand(t,i)
  end
  for n,e in pairs(n)do
    o(n,e)
  end
end
function this._SetEnemyLevel(t,n,a,r)
  if not n then
    return
  end
  if GameObject.GetGameObjectIdByIndex(t,0)==GameObject.NULL_ID then
    return
  end
  local t={type=t}
  local n={id="SetMissionLv",level=n}
  GameObject.SendCommand(t,n)
  if a then
    n={id="SetRandLv",level=a}
    GameObject.SendCommand(t,n)
  end
  if r then
    this.SetEnemyLevelByRegion(t,r)
  end
  n={id="ReloadLevel"}
  GameObject.SendCommand(t,n)
end
function this._OnDead(e,n)
  local e=GameObject.GetTypeIndex(e)
  if(e==GameObject.GetTypeIndexWithTypeName"SsdBoss1"or e==GameObject.GetTypeIndexWithTypeName"SsdBoss2")or e==GameObject.GetTypeIndexWithTypeName"SsdBoss3"then
    TppMusicManager.PostJingleEvent2("SingleShot","WaveEndDefeatedBoss")
  end
end
function this._OnRecoverNPC(n,t)
  this._PlayRecoverNPCRadio(n)
end
function this._PlayRecoverNPCRadio(n)
  local a=this.IsEliminateTarget(n)
  local t=this.IsRescueTarget(n)
  if Tpp.IsSoldier(n)and not a then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.ENEMY_RECOVERED)
  elseif Tpp.IsHostage(n)and not t then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.HOSTAGE_RECOVERED)
  else
    this.PlayTargetRescuedRadio(n)
  end
end
function this._OnFulton(t,a,a,n)
  this._OnRecoverNPC(t,n)
end
function this._OnDamage(gameObjectId,attackId,attackerId)
  if this.IsRescueTarget(gameObjectId)then
    this._OnDamageOfRescueTarget(attackId,attackerId)
  end
end
function this._OnDamageOfRescueTarget(attackId,attackerId)
  if TppDamage.IsActiveByAttackId(attackId)then
    if Tpp.IsPlayer(attackerId)then
      TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.HOSTAGE_DAMAGED_FROM_PC)
    end
  end
end
function this._AnnouncePhaseChange(n,t)
  local e=this.GetCpSubType(n)
  local n="cmmn_ene_soviet"
  if e=="SOVIET_A"or e=="SOVIET_B"then
    n="cmmn_ene_soviet"
  elseif e=="PF_A"then
    n="cmmn_ene_cfa"
  elseif e=="PF_B"then
    n="cmmn_ene_zrs"
  elseif e=="PF_C"then
    n="cmmn_ene_coyote"
  elseif e=="DD_A"then
    return
  elseif e=="DD_PW"then
    n="cmmn_ene_pf"
  elseif e=="DD_FOB"then
    n="cmmn_ene_pf"
  elseif e=="SKULL_AFGH"then
    n="cmmn_ene_xof"
  elseif e=="SKULL_CYPR"then
    return
  elseif e=="CHILD_A"then
    return
  end
  if t==TppGameObject.PHASE_ALERT then
    TppUiCommand.AnnounceLogViewLangId("announce_phase_to_alert",n)
  elseif t==TppGameObject.PHASE_EVASION then
    TppUiCommand.AnnounceLogViewLangId("announce_phase_to_evasion",n)
  elseif t==TppGameObject.PHASE_CAUTION then
    TppUiCommand.AnnounceLogViewLangId("announce_phase_to_caution",n)
  elseif t==TppGameObject.PHASE_SNEAK then
    TppUiCommand.AnnounceLogViewLangId("announce_phase_to_sneak",n)
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
--NMC no references
function this._IsRouteSetTypeValid(n)
  if(n==nil or type(n)~="string")then
    return false
  end
  for t,t in paris(this.ROUTE_SET_TYPES)do--RETAILBUG: type
    if(n==this.ROUTE_SET_TYPES[i])then--RETAILBUG: bad index
      return true
  end
  end
  return false
end
function this._ShiftChangeByTime(n)
  for e,a in pairs(mvars.ene_cpList)do
    SendCommand(e,{id="ShiftChange",schedule=mvars.ene_shiftChangeTable[e][n]})
  end
end
function this._IsEliminated(t,n)
  if(t==this.LIFE_STATUS.DEAD)or(n==TppGameObject.NPC_STATE_DISABLE)then
    return true
  else
    return false
  end
end
function this._IsNeutralized(t,n)
  if(t>this.LIFE_STATUS.NORMAL)or(n>TppGameObject.NPC_STATE_NORMAL)then
    return true
  else
    return false
  end
end
function this._RestoreOnContinueFromCheckPoint_Hostage()
end
function this._RestoreOnContinueFromCheckPoint_Hostage2()
end
function this._RestoreOnMissionStart_Hostage()
end
function this._RestoreOnMissionStart_Hostage2()
end
function this._StoreSVars_Hostage(e)
end
function this._DoRoutePointMessage(a,t,r,i)
  local n=mvars.ene_routePointMessage
  if not n then
    return
  end
  local o=TppSequence.GetCurrentSequenceName()
  local s=n.sequence[o]
  local o=""
  if s then
    this.ExecuteRoutePointMessage(s,a,t,r,i,o)
  end
  this.ExecuteRoutePointMessage(n.main,a,t,r,i,o)
end
function this.ExecuteRoutePointMessage(e,a,t,i,n,r)
  local e=e[n]
  if not e then
    return
  end
  Tpp.DoMessageAct(e,TppMission.CheckMessageOption,i,t,a,n,r)
end
function this._SetRespawnFlagAllForGameObjectType(e)
  if GameObject.DoesGameObjectExistWithTypeName(e)then
    GameObject.SendCommand({type=e},{id="SetRespawnFlagAll"})
  end
end
function this._RespawnAllForGameObjectType(e)
  if GameObject.DoesGameObjectExistWithTypeName(e)then
    GameObject.SendCommand({type=e},{id="RespawnAll"})
  end
end
function this.KillWaveEnemy(n)
  Mission.DiggerShockWave{type=TppDefine.DIGGER_SHOCK_WAVE_TYPE.FINISH_WAVE}
  GameObject.SendCommand({type="TppCommandPost2"},{id="KillWaveEnemy"})
  for n,e in ipairs(TppDefine.WAVE_ENEMY_TYPE_LIST)do
    if GameObject.DoesGameObjectExistWithTypeName(e)then
      GameObject.SendCommand({type=e},{id="ResetWaveAttacker"})
    end
  end
  if Tpp.IsTypeTable(n)then
    local e=n.soundName
    if Tpp.IsTypeString(e)then
      TppSoundDaemon.PostEvent(e)
    end
  end
end
function this._OnNpcActivated(n,npcTypeS32)
  local missionCode=vars.missionCode
  if not TppMission.IsCoopMission(missionCode)then
    if(npcTypeS32==Fox.StrCode32"Gluttony")or(npcTypeS32==Fox.StrCode32"Aerial")then
      if mvars.loc_stealthAreaNameTable then
        local e=mvars.loc_stealthAreaNameTable[npcTypeS32]
        if e then
          SendCommand(n,{id="SetStealthArea",name=e})
        end
      end
      if mvars.loc_aerialRouteTable then
        SendCommand(n,{id="SetHuntDownRoute",routes=mvars.loc_aerialRouteTable})
      end
    end
  end
end
function this.SetZombieSneakRoute(a,n,r,e,i)
  if not Tpp.IsTypeString(a)then
    return
  end
  e=e or 0
  n=n or"SsdZombie"
  SendCommand({type=n},{id="SetSneakRoute",name=a,route=r,point=e})
end
function this.SetBreakBody(o,a,n,e,i,r)
  if not Tpp.IsTypeString(o)then
    return
  end
  a=a or"SsdZombie"n=n or 0
  e=e or 0
  i=i or 0
  r=r or 0
  SendCommand({type=a},{id="SetBreakBody",locatorName=o,armR=n,armL=e,legR=i,legL=r})
end
function this.SetZombieWaveWalkSpeed(n,e,t)
  if not Tpp.IsTypeString(n)then
    return
  end
  e=e or"SsdZombie"
  GameObject.SendCommand({type=e},{id="SetWaveWalkSpeed",speed=t,locatorName=n})
end
function this.SetWaveByName(t,e,r,a,n)
  if not Tpp.IsTypeString(t)then
    return
  end
  e=e or"SsdZombie"n=n or true
  GameObject.SendCommand({type=e},{id="SetWaveByName",locatorName=t,spawnLocator=r,relayLocator1=a,ignoreWave=n})
end
function this.SetInsectSneakRoute(t,e,r,n,i)
  if not Tpp.IsTypeString(t)then
    return
  end
  n=n or 0
  e=e or"SsdInsect1"
  local e=GameObject.GetGameObjectId(e,t)
  if(e==NULL_ID)then
    return
  end
  GameObject.SendCommand(e,{id="SetSneakRoute",route=r,name=t,point=n})
end
function this.SetEnablePermanent(n,e)
  if not Tpp.IsTypeString(n)then
    return
  end
  e=e or"SsdZombie"
  GameObject.SendCommand({type=e},{id="SetEnabledWithLocator",name=n,enabled=true,permanent=false})
end
function this.SetDisablePermanent(n,e)
  if not Tpp.IsTypeString(n)then
    return
  end
  e=e or"SsdZombie"
  GameObject.SendCommand({type=e},{id="SetEnabledWithLocator",name=n,enabled=false,permanent=true})
end
local n={"SsdKaiju1GameObjectLocator","SsdKaiju2GameObjectLocator","SsdKaiju3GameObjectLocator","SsdKaiju4GameObjectLocator"}
function this.SetKaijuRail(e)
  if not Tpp.IsTypeString(e)then
    return
  end
  if GameObject.GetGameObjectIdByIndex("SsdKaiju",0)==GameObject.NULL_ID then
    return
  end
  for t,n in pairs(n)do
    local n=GameObject.GetGameObjectId("SsdKaiju",n)
    GameObject.SendCommand(n,{id="SetRail",rail=e})
  end
end
function this.SetKaijuRailOneArmed(e)
  if not Tpp.IsTypeString(e)then
    return
  end
  if GameObject.GetGameObjectIdByIndex("SsdKaiju",0)==GameObject.NULL_ID then
    return
  end
  for t,n in pairs(n)do
    local n=GameObject.GetGameObjectId("SsdKaiju",n)
    GameObject.SendCommand(n,{id="SetRail",rail=e,isOneArmed=true})
  end
end
function this.SetKaijuRailOneArmedStartPosition(e,t)
  if not Tpp.IsTypeString(e)then
    return
  end
  if GameObject.GetGameObjectIdByIndex("SsdKaiju",0)==GameObject.NULL_ID then
    return
  end
  for a,n in pairs(n)do
    local n=GameObject.GetGameObjectId("SsdKaiju",n)
    GameObject.SendCommand(n,{id="SetRail",rail=e,isOneArmed=true,startPosition=t})
  end
end
function this.SetKaijuRailStartPosition(e,t)
  if not Tpp.IsTypeString(e)then
    return
  end
  if GameObject.GetGameObjectIdByIndex("SsdKaiju",0)==GameObject.NULL_ID then
    return
  end
  for a,n in pairs(n)do
    local n=GameObject.GetGameObjectId("SsdKaiju",n)
    GameObject.SendCommand(n,{id="SetRail",rail=e,startPosition=t})
  end
end
function this.SetEnableKaiju()
  if GameObject.GetGameObjectIdByIndex("SsdKaiju",0)==GameObject.NULL_ID then
    return
  end
  for n,e in pairs(n)do
    local e=GameObject.GetGameObjectId("SsdKaiju",e)
    GameObject.SendCommand(e,{id="SetEnabled",enabled=true})
  end
end
function this.SetDisableKaiju()
  if GameObject.GetGameObjectIdByIndex("SsdKaiju",0)==GameObject.NULL_ID then
    return
  end
  for n,e in pairs(n)do
    local e=GameObject.GetGameObjectId("SsdKaiju",e)
    GameObject.SendCommand(e,{id="SetFadeOut"})--RETAILPATCH: 1.0.5.0 was {id="SetEnabled",enabled=false})
  end
end
function this.SetEnableKaijuPredacious()
  if GameObject.GetGameObjectIdByIndex("SsdKaiju",0)==GameObject.NULL_ID then
    return
  end
  for n,e in pairs(n)do
    local e=GameObject.GetGameObjectId("SsdKaiju",e)
    GameObject.SendCommand(e,{id="SetFlag",isPredacious=true})
  end
end
function this.SetDisableKaijuPredacious()
  if GameObject.GetGameObjectIdByIndex("SsdKaiju",0)==GameObject.NULL_ID then
    return
  end
  for n,e in pairs(n)do
    local e=GameObject.GetGameObjectId("SsdKaiju",e)
    GameObject.SendCommand(e,{id="SetFlag",isPredacious=false})
  end
end
if(Tpp.IsQARelease()or nil)then
  function this.QARELEASE_DEBUG_Init()
    local e
    if DebugMenu then
      e=DebugMenu
    else
      return
    end
  end
  function this.QAReleaseDebugUpdate()
  end
end
return this
