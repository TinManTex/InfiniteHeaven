local e={}
local r=Tpp.IsTypeTable
local i=GameObject.SendCommand
local t=GameObject.GetGameObjectId
local t=GameObject.NULL_ID
local T=500
local p=1e3
local a=4
e.GMP_POSTER=500
e.FOB_TUTORIAL_STATE={INIT=0,INTRODUCTION_CONSTRUCT_FOB=1,CONSTRUCT_FOB=2,INTRODUCTION_FOB_MISSIONS=3,FOB_MISSIONS=4,FINISH=127}
e.unitLvAnnounceLogTable={[Fox.StrCode32"Combat"]={up="unitLvUpCombat",down="unitLvDownCombat"},[Fox.StrCode32"Develop"]={up="unitLvUpRd",down="unitLvDownRd"},[Fox.StrCode32"Support"]={up="unitLvUpSupport",down="unitLvDownSupport"},[Fox.StrCode32"Medical"]={up="unitLvUpMedical",down="unitLvDownMedical"},[Fox.StrCode32"Spy"]={up="unitLvUpIntel",down="unitLvDownIntel"},[Fox.StrCode32"PrantDev"]={up="unitLvUpBaseDev",down="unitLvDownBaseDev"},[Fox.StrCode32"Security"]={up="unitLvUpSecurity",down="unitLvDownSecurity"}}e.keyItemAnnounceLogTable={[TppMotherBaseManagementConst.DESIGN_3011]="key_item_3011",[TppMotherBaseManagementConst.DESIGN_3012]="key_item_3012",[TppMotherBaseManagementConst.DESIGN_3006]="key_item_3006",[TppMotherBaseManagementConst.DESIGN_3005]="key_item_3005",[TppMotherBaseManagementConst.DESIGN_3000]="key_item_3000",[TppMotherBaseManagementConst.DESIGN_3009]="key_item_3009",[TppMotherBaseManagementConst.DESIGN_3002]="key_item_3002",[TppMotherBaseManagementConst.DESIGN_3007]="key_item_3007",[TppMotherBaseManagementConst.DESIGN_3001]="key_item_3001"}e.keyItemRewardTable={[TppMotherBaseManagementConst.DESIGN_3013]="key_item_3013",[TppMotherBaseManagementConst.DESIGN_3003]="key_item_3003",[TppMotherBaseManagementConst.DESIGN_3008]="key_item_3008",[TppMotherBaseManagementConst.DESIGN_3014]="key_item_3014",[TppMotherBaseManagementConst.DESIGN_3015]="key_item_3015",[TppMotherBaseManagementConst.DESIGN_3016]="key_item_3016",[TppMotherBaseManagementConst.DESIGN_3017]="key_item_3017",[TppMotherBaseManagementConst.DESIGN_3018]="key_item_3018",[TppMotherBaseManagementConst.DESIGN_3019]="key_item_3019",[TppMotherBaseManagementConst.DESIGN_3007]="key_item_3007",[TppMotherBaseManagementConst.DESIGN_3010]="key_item_3010",[TppMotherBaseManagementConst.DESIGN_3020]="key_item_3020"}e.parasiteSquadFultonResouceId={[Fox.StrCode32"Cam"]={TppMotherBaseManagementConst.RESOURCE_ID_PARASITE_CAMOFLA,5},[Fox.StrCode32"Fog"]={TppMotherBaseManagementConst.RESOURCE_ID_PARASITE_FOG,5},[Fox.StrCode32"Metal"]={TppMotherBaseManagementConst.RESOURCE_ID_PARASITE_CURING,5}}
e.MOTHER_BASE_SECTION_LIST={"Combat","BaseDev","Spy","Medical","Security","Hospital","Prison","Separation"}
local t=TppMotherBaseManagementConst or{}
local E={Combat={DispatchSoldier=t.SECTION_FUNC_ID_COMBAT_DEPLOY,DispatchFobDefence=t.SECTION_FUNC_ID_COMBAT_DEFENCE},Develop={Weapon=t.SECTION_FUNC_ID_DEVELOP_WEAPON,SupportHelicopter=t.SECTION_FUNC_ID_DEVELOP_HELI,Quiet=t.SECTION_FUNC_ID_DEVELOP_QUIET,D_Dog=t.SECTION_FUNC_ID_DEVELOP_D_DOG,D_Horse=t.SECTION_FUNC_ID_DEVELOP_D_HORSE,D_Walker=t.SECTION_FUNC_ID_DEVELOP_D_WALKER,BattleGear=t.SECTION_FUNC_ID_DEVELOP_BATTLE_GEAR,SecurityDevice=t.SECTION_FUNC_ID_DEVELOP_SECURITY_DEVICE},BaseDev={Mining=t.SECTION_FUNC_ID_BASE_DEV_RESOURCE_MINING,Processing=t.SECTION_FUNC_ID_BASE_DEV_RESOURCE_PROCESSING,Extention=t.SECTION_FUNC_ID_BASE_DEV_PLATFORM_EXTENTION,Construct=t.SECTION_FUNC_ID_BASE_DEV_FOB_CONSTRUCT,NuclearDevelop=t.SECTION_FUNC_ID_BASE_DEV_NUCLEAR_DEVELOP},Support={Fulton=t.SECTION_FUNC_ID_SUPPORT_FULTON,Supply=t.SECTION_FUNC_ID_SUPPORT_SUPPLY,Battle=t.SECTION_FUNC_ID_SUPPORT_BATTLE,BattleArtillery=t.SECTION_FUNC_ID_SUPPORT_STRIKE,BattleSmoke=t.SECTION_FUNC_ID_SUPPORT_SMOKE,BattleSleepGas=t.SECTION_FUNC_ID_SUPPORT_SLEEP_GAS,BattleChaff=t.SECTION_FUNC_ID_SUPPORT_CHAFF,BattleWeather=t.SECTION_FUNC_ID_SUPPORT_WEATHER,TranslationRussian=t.SECTION_FUNC_ID_SUPPORT_RUSSIAN_TRANSLATE,TranslationAfrikaans=t.SECTION_FUNC_ID_SUPPORT_AFRIKAANS_TRANSLATE,TranslationKikongo=t.SECTION_FUNC_ID_SUPPORT_KIKONGO_TRANSLATE,TranslationPashto=t.SECTION_FUNC_ID_SUPPORT_PASHTO_TRANSLATE},Spy={Information=t.SECTION_FUNC_ID_SPY_MISSION_INFO_COLLECTING,Scouting=t.SECTION_FUNC_ID_SPY_ENEMY_SEARCH,SearchResource=t.SECTION_FUNC_ID_SPY_RESOURCE_SEARCH,WeatherInformation=t.SECTION_FUNC_ID_SPY_WEATHER_INFO},Medical={Emergency=t.SECTION_FUNC_ID_MEDICAL_STAFF_EMERGENCY,Treatment=t.SECTION_FUNC_ID_MEDICAL_STAFF_TREATMENT},Security={BaseDefence=t.SECTION_FUNC_ID_SECURITY_BASE_DEFENCE_STAFF,MachineDefence=t.SECTION_FUNC_ID_SECURITY_BASE_DEFENCE_MACHINE,BaseBlockade=t.SECTION_FUNC_ID_SECURITY_BASE_BLOCKADE,SecurityInfo=t.SECTION_FUNC_ID_SPY_SECURITY_INFO}}
e.setUpMenuList={}
e.MBDVCMENU={ALL="all",
MBM="MBM",
MBM_REWORD="MBM_REWORD",
MBM_CUSTOM="MBM_CUSTOM",
MBM_CUSTOM_WEAPON="MBM_CUSTOM_WEAPON",
MBM_CUSTOM_ARMS="MBM_CUSTOM_ARMS",
MBM_CUSTOM_ARMS_HELI="MBM_CUSTOM_ARMS_HELI",
MBM_CUSTOM_ARMS_VEHICLE="MBM_CUSTOM_ARMS_VEHICLE",
MBM_CUSTOM_BUDDY="MBM_CUSTOM_BUDDY",
MBM_CUSTOM_BUDDY_HORSE="MBM_CUSTOM_BUDDY_HORSE",
MBM_CUSTOM_BUDDY_DOG="MBM_CUSTOM_BUDDY_DOG",
MBM_CUSTOM_BUDDY_QUIET="MBM_CUSTOM_BUDDY_QUIET",
MBM_CUSTOM_BUDDY_WALKER="MBM_CUSTOM_BUDDY_WALKER",
MBM_CUSTOM_BUDDY_BATTLE="MBM_CUSTOM_BUDDY_BATTLE",
MBM_CUSTOM_DESIGN="MBM_CUSTOM_DESIGN",
MBM_CUSTOM_DESIGN_EMBLEM="MBM_CUSTOM_DESIGN_EMBLEM",
MBM_CUSTOM_DESIGN_BASE="MBM_CUSTOM_DESIGN_BASE",
MBM_CUSTOM_AVATAR="MBM_CUSTOM_AVATAR",
MBM_DEVELOP="MBM_DEVELOP",
MBM_DEVELOP_WEAPON="MBM_DEVELOP_WEAPON",
MBM_DEVELOP_ARMS="MBM_DEVELOP_ARMS",
MBM_RESOURCE="MBM_RESOURCE",
MBM_STAFF="MBM_STAFF",
MBM_COMBAT="MBM_COMBAT",
MBM_BASE="MBM_BASE",
MBM_BASE_SECURITY="MBM_BASE_SECURITY",
MBM_BASE_EXPANTION="MBM_BASE_EXPANTION",
MBM_DB="MBM_DB",
MBM_DB_ENCYCLOPEDIA="MBM_DB_ENCYCLOPEDIA",
MBM_DB_KEYITEM="MBM_DB_KEYITEM",
MBM_DB_CASSETTE="MBM_DB_CASSETTE",
MBM_DB_PFRATING="MBM_DB_PFRATING",
MBM_LOG="MBM_LOG",
MSN="MSN",
MSN_EMERGENCIE_N="MSN_EMERGENCIE_N",
MSN_EMERGENCIE_F="MSN_EMERGENCIE_F",
MSN_DROP="MSN_DROP",
MSN_DROP_BULLET="MSN_DROP_BULLET",
MSN_DROP_WEAPON="MSN_DROP_WEAPON",
MSN_DROP_LOADOUT="MSN_DROP_LOADOUT",
MSN_DROP_VEHICLE="MSN_DROP_VEHICLE",
MSN_BUDDY="MSN_BUDDY",
MSN_BUDDY_HORSE="MSN_BUDDY_HORSE",
MSN_BUDDY_HORSE_DISMISS="MSN_BUDDY_HORSE_DISMISS",
MSN_BUDDY_DOG="MSN_BUDDY_DOG",
MSN_BUDDY_DOG_DISMISS="MSN_BUDDY_DOG_DISMISS",
MSN_BUDDY_QUIET_SCOUT="MSN_BUDDY_QUIET_SCOUT",
MSN_BUDDY_QUIET_ATTACK="MSN_BUDDY_QUIET_ATTACK",
MSN_BUDDY_QUIET_DISMISS="MSN_BUDDY_QUIET_DISMISS",
MSN_BUDDY_WALKER="MSN_BUDDY_WALKER",
MSN_BUDDY_WALKER_DISMISS="MSN_BUDDY_WALKER_DISMISS",
MSN_BUDDY_BATTLE="MSN_BUDDY_BATTLE",
MSN_BUDDY_BATTLE_DISMISS="MSN_BUDDY_BATTLE_DISMISS",
MSN_BUDDY_EQUIP="MSN_BUDDY_EQUIP",
MSN_ATTACK="MSN_ATTACK",
MSN_ATTACK_ARTILLERY="MSN_ATTACK_ARTILLERY",
MSN_ATTACK_SMOKE="MSN_ATTACK_SMOKE",
MSN_ATTACK_SLEEP="MSN_ATTACK_SLEEP",
MSN_ATTACK_CHAFF="MSN_ATTACK_CHAFF",
MSN_ATTACK_WEATHER="MSN_ATTACK_WEATHER",
MSN_ATTACK_WEATHER_SANDSTORM="MSN_ATTACK_WEATHER_SANDSTORM",
MSN_ATTACK_WEATHER_STORM="MSN_ATTACK_WEATHER_STORM",
MSN_ATTACK_WEATHER_CLEAR="MSN_ATTACK_WEATHER_CLEAR",
MSN_HELI="MSN_HELI",
MSN_HELI_RENDEZVOUS="MSN_HELI_RENDEZVOUS",
MSN_HELI_ATTACK="MSN_HELI_ATTACK",
MSN_HELI_DISMISS="MSN_HELI_DISMISS",
MSN_MISSIONLIST="MSN_MISSIONLIST",
MSN_SIDEOPSLIST="MSN_SIDEOPSLIST",
MSN_LOCATION="MSN_LOCATION",
MSN_RETURNMB="MSN_RETURNMB",
MSN_FOB="MSN_FOB",
MSN_FRIEND="MSN_FRIEND",
MSN_LOG="MSN_LOG"}
e.BUDDY_MB_DVC_MENU={
  [BuddyType.QUIET]={{menu=e.MBDVCMENU.MSN_BUDDY_QUIET_SCOUT,active=true},{menu=e.MBDVCMENU.MSN_BUDDY_QUIET_ATTACK,active=true},{menu=e.MBDVCMENU.MSN_BUDDY_QUIET_DISMISS,active=true}},
  [BuddyType.DOG]={{menu=e.MBDVCMENU.MSN_BUDDY_DOG,active=true},{menu=e.MBDVCMENU.MSN_BUDDY_DOG_DISMISS,active=true}},
  [BuddyType.HORSE]={{menu=e.MBDVCMENU.MSN_BUDDY_HORSE,active=true},{menu=e.MBDVCMENU.MSN_BUDDY_HORSE_DISMISS,active=true}},
  [BuddyType.WALKER_GEAR]={{menu=e.MBDVCMENU.MSN_BUDDY_WALKER,active=true},{menu=e.MBDVCMENU.MSN_BUDDY_WALKER_DISMISS,active=true}},
  [BuddyType.BATTLE_GEAR]={{menu=e.MBDVCMENU.MSN_BUDDY_BATTLE,active=true},{menu=e.MBDVCMENU.MSN_BUDDY_BATTLE_DISMISS,active=true}}}
e.RESOURCE_INFORMATION_TABLE={
[TppCollection.TYPE_MATERIAL_CM_0]={resourceName="CommonMetal",count=100},
[TppCollection.TYPE_MATERIAL_CM_1]={resourceName="CommonMetal",count=100},
[TppCollection.TYPE_MATERIAL_CM_2]={resourceName="CommonMetal",count=100},
[TppCollection.TYPE_MATERIAL_CM_3]={resourceName="CommonMetal",count=100},
[TppCollection.TYPE_MATERIAL_CM_4]={resourceName="CommonMetal",count=100},
[TppCollection.TYPE_MATERIAL_CM_5]={resourceName="CommonMetal",count=100},
[TppCollection.TYPE_MATERIAL_CM_6]={resourceName="CommonMetal",count=100},
[TppCollection.TYPE_MATERIAL_CM_7]={resourceName="CommonMetal",count=100},
[TppCollection.TYPE_MATERIAL_MM_0]={resourceName="MinorMetal",count=50},
[TppCollection.TYPE_MATERIAL_MM_1]={resourceName="MinorMetal",count=50},
[TppCollection.TYPE_MATERIAL_MM_2]={resourceName="MinorMetal",count=50},
[TppCollection.TYPE_MATERIAL_MM_3]={resourceName="MinorMetal",count=50},
[TppCollection.TYPE_MATERIAL_MM_4]={resourceName="MinorMetal",count=50},
[TppCollection.TYPE_MATERIAL_MM_5]={resourceName="MinorMetal",count=50},
[TppCollection.TYPE_MATERIAL_MM_6]={resourceName="MinorMetal",count=50},
[TppCollection.TYPE_MATERIAL_MM_7]={resourceName="MinorMetal",count=50},
[TppCollection.TYPE_MATERIAL_PM_0]={resourceName="PreciousMetal",count=10},
[TppCollection.TYPE_MATERIAL_PM_1]={resourceName="PreciousMetal",count=10},
[TppCollection.TYPE_MATERIAL_PM_2]={resourceName="PreciousMetal",count=10},
[TppCollection.TYPE_MATERIAL_PM_3]={resourceName="PreciousMetal",count=10},
[TppCollection.TYPE_MATERIAL_PM_4]={resourceName="PreciousMetal",count=10},
[TppCollection.TYPE_MATERIAL_PM_5]={resourceName="PreciousMetal",count=10},
[TppCollection.TYPE_MATERIAL_PM_6]={resourceName="PreciousMetal",count=10},
[TppCollection.TYPE_MATERIAL_PM_7]={resourceName="PreciousMetal",count=10},
[TppCollection.TYPE_MATERIAL_FR_0]={resourceName="FuelResource",count=100},
[TppCollection.TYPE_MATERIAL_FR_1]={resourceName="FuelResource",count=100},
[TppCollection.TYPE_MATERIAL_FR_2]={resourceName="FuelResource",count=100},
[TppCollection.TYPE_MATERIAL_FR_3]={resourceName="FuelResource",count=100},
[TppCollection.TYPE_MATERIAL_FR_4]={resourceName="FuelResource",count=100},
[TppCollection.TYPE_MATERIAL_FR_5]={resourceName="FuelResource",count=100},
[TppCollection.TYPE_MATERIAL_FR_6]={resourceName="FuelResource",count=100},
[TppCollection.TYPE_MATERIAL_FR_7]={resourceName="FuelResource",count=100},
[TppCollection.TYPE_MATERIAL_BR_0]={resourceName="BioticResource",count=100},
[TppCollection.TYPE_MATERIAL_BR_1]={resourceName="BioticResource",count=100},
[TppCollection.TYPE_MATERIAL_BR_2]={resourceName="BioticResource",count=100},
[TppCollection.TYPE_MATERIAL_BR_3]={resourceName="BioticResource",count=100},
[TppCollection.TYPE_MATERIAL_BR_4]={resourceName="BioticResource",count=100},
[TppCollection.TYPE_MATERIAL_BR_5]={resourceName="BioticResource",count=100},
[TppCollection.TYPE_MATERIAL_BR_6]={resourceName="BioticResource",count=100},
[TppCollection.TYPE_MATERIAL_BR_7]={resourceName="BioticResource",count=100},
[TppCollection.TYPE_HERB_G_CRESCENT]={resourceName="Plant2000",count=10},
[TppCollection.TYPE_HERB_A_PEACH]={resourceName="Plant2001",count=10},
[TppCollection.TYPE_HERB_DIGITALIS_P]={resourceName="Plant2002",count=10},
[TppCollection.TYPE_HERB_DIGITALIS_R]={resourceName="Plant2003",count=10},
[TppCollection.TYPE_HERB_B_CARROT]={resourceName="Plant2004",count=10},
[TppCollection.TYPE_HERB_WORM_WOOD]={resourceName="Plant2005",count=10},
[TppCollection.TYPE_HERB_TARRAGON]={resourceName="Plant2006",count=10},
[TppCollection.TYPE_HERB_HAOMA]={resourceName="Plant2007",count=10},
[TppCollection.TYPE_POSTER_SOL_AFGN]={resourceName="Poster1000",count=1},
[TppCollection.TYPE_POSTER_SOL_MAFR]={resourceName="Poster1001",count=1},
[TppCollection.TYPE_POSTER_SOL_ZRS]={resourceName="Poster1002",count=1},
[TppCollection.TYPE_POSTER_GRAVURE_V]={resourceName="Poster1003",count=1},
[TppCollection.TYPE_POSTER_GRAVURE_H]={resourceName="Poster1004",count=1},
[TppCollection.TYPE_POSTER_MOE_V]={resourceName="Poster1005",count=1},
[TppCollection.TYPE_POSTER_MOE_H]={resourceName="Poster1006",count=1}}
e.BLUE_PRINT_LOCATOR_TABLE={col_develop_Revolver_Shotgun=t.DESIGN_2002,col_develop_Highprecision_SMG=t.DESIGN_2006,col_develop_HighprecisionAR=t.DESIGN_2007,col_develop_HighprecisionAR_s10033_0000=t.DESIGN_2007,col_develop_BullpupAR=t.DESIGN_2008,col_develop_LongtubeShotgun=t.DESIGN_2009,col_develop_RevolverGrenade0001=t.DESIGN_2011,col_develop_RevolverGrenade0002=t.DESIGN_2011,col_develop_RevolverGrenade0003=t.DESIGN_2011,col_develop_RevolverGrenade0004=t.DESIGN_2011,col_develop_Semiauto_SR=t.DESIGN_2013,col_develop_Semiauto_SR_s10070_0000=t.DESIGN_2013,col_develop_Antimaterial=t.DESIGN_2015,col_develop_EuropeSMG0001=t.DESIGN_2016,col_develop_EuropeSMG0002=t.DESIGN_2016,col_develop_EuropeSMG0003=t.DESIGN_2016,col_develop_EuropeSMG0004=t.DESIGN_2016,col_develop_Stungrenade=t.DESIGN_2019,col_develop_Stungun=t.DESIGN_2020,col_develop_Infraredsensor=t.DESIGN_2021,col_develop_Theftprotection=t.DESIGN_2022,col_develop_Emergencyrescue=t.DESIGN_3001,col_develop_FLamethrower=t.DESIGN_2026,col_develop_Shield=t.DESIGN_2025,col_develop_Shield0000=t.DESIGN_2025,col_develop_Shield0001=t.DESIGN_2025,col_develop_Shield0002=t.DESIGN_2025,col_develop_GunCamera=t.DESIGN_2023,col_develop_UAV=t.DESIGN_2024,col_develop_q60115=t.DESIGN_2027}e.BLUE_PRINT_LANG_ID={[t.DESIGN_2002]="key_bprint_2002",[t.DESIGN_2006]="key_bprint_2006",[t.DESIGN_2007]="key_bprint_2007",[t.DESIGN_2008]="key_bprint_2008",[t.DESIGN_2009]="key_bprint_2009",[t.DESIGN_2011]="key_bprint_2011",[t.DESIGN_2013]="key_bprint_2013",[t.DESIGN_2015]="key_bprint_2015",[t.DESIGN_2016]="key_bprint_2016",[t.DESIGN_2019]="key_bprint_2019",[t.DESIGN_2020]="key_bprint_2020",[t.DESIGN_2021]="key_bprint_2021",[t.DESIGN_2022]="key_bprint_2022",[t.DESIGN_2023]="key_bprint_2023",[t.DESIGN_2024]="key_bprint_2024",[t.DESIGN_2025]="key_bprint_2025",[t.DESIGN_2026]="key_bprint_2026",[t.DESIGN_2027]="key_bprint_2027",[t.DESIGN_3001]="key_item_3001"}
e.EMBLEM_LOCATOR_TABLE={["ly003_cl00_collct0000|cl00pl0_uq_0000_collct|col_develop_MTBS_0000"]="front8",["ly003_cl00_collct0000|cl00pl0_uq_0000_collct|col_develop_MTBS_0001"]="front10",["ly003_cl00_collct0000|cl00pl0_uq_0000_collct|col_develop_MTBS_0002"]="front15",["ly003_cl00_collct0000|cl00pl0_uq_0000_collct|col_develop_MTBS_0003"]="front16",["ly003_cl04_collct0000|cl04pl0_uq_0040_collct|col_emblem_quiet"]="front9",col_develop_MTBS_30150_0000="front11",col_develop_MTBS_30250_0000="front7"}
local n={}
if TppDefine.GMP_COST_TYPE then
  n[TppDefine.GMP_COST_TYPE.FULTON]="gmpCostFulton"
  n[TppDefine.GMP_COST_TYPE.SUPPORT_SUPPLY]="gmpCostSupply"
  n[TppDefine.GMP_COST_TYPE.SUPPORT_ATTACK]="gmpCostAttack"
  n[TppDefine.GMP_COST_TYPE.CALL_HELLI]="gmpCostHeli"
  n[TppDefine.GMP_COST_TYPE.BUDDY]="gmpCostOps"
  n[TppDefine.GMP_COST_TYPE.CLEAR_SIDE_OPS]="gmpGet"
  n[TppDefine.GMP_COST_TYPE.DESTROY_SUPPORT_HELI]="add_alt_machine"
end
function e.UpdateGMP(e)
  if not TppMotherBaseManagement.AddGmp then
    return
  end
  if not r(e)then
    return
  end
  local t=e.gmp
  local a=math.abs(t)
  local r=e.withOutAnnouceLog
  if t>0 then
    TppMotherBaseManagement.AddGmp{gmp=t}
  else
    TppMotherBaseManagement.SubGmp{gmp=a}
  end
  if not r then
    if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER and e.gmpCostType then
      local e=n[e.gmpCostType]if e then
        TppUI.ShowAnnounceLog(e,a)
      end
    end
  end
end
function e.CorrectGMP(e)
  if not TppMotherBaseManagement.CorrectGmp then
    return
  end
  if not r(e)then
    return
  end
  local e=e.gmp
  if not e then
    return e
  end
  return TppMotherBaseManagement.CorrectGmp{gmp=e}
end
function e.AddStaffsFromTempBuffer(t,n)
  if(vars.fobSneakMode==FobMode.MODE_SHAM)then
    return
  end
  local o=TppMotherBaseManagement.IsExistTempStaff{skill="TranslateRussian"}
  local r=TppMotherBaseManagement.IsExistStaff{skill="TranslateRussian"}
  if o and not r then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.RECOVERED_RUSSIAN_INTERPRETER)
  end
  for e=0,(a-1)do
    if svars.trm_isBuddyRecovered[e]then
      TppBuddyService.SetObtainedBuddyType(e)
      if e==BuddyType.QUIET then
      end
      if e==BuddyType.DOG then
        TppEmblem.Add("word146",false,true)
        if(TppBuddyService.IsBuddyDogGot()==false)then
          TppBuddyService.SetBuddyDogGot()
        elseif(TppBuddyService.IsBuddyDogSecondGot()==false)then
          TppBuddyService.IsBuddyDogSecondGot()
        end
        TppBuddyService.UnsetDeadBuddyType(BuddyType.DOG)
      end
    end
  end
  if mvars.trm_needHeliSoundOnAddStaffsFromTempBuffer then
    TppSound.PostEventForFultonRecover()
  end
  mvars.trm_needHeliSoundOnAddStaffsFromTempBuffer=false
  TppMotherBaseManagement.AddStaffsFromTempStaffBuffer()
  if not n then
    if t then
      TppMotherBaseManagement.StartSyncControl{readOnly=t}
    else
      e.ReserveMissionStartMbSync()
    end
  end
  TppUiCommand.AddAnimalEmblemTextureByDataBase()
end
function e.ReserveMissionStartMbSync()
  gvars.reservedMissionStartMbSync=true
end
function e.StartSyncMbManagementOnMissionStart()
  if gvars.reservedMissionStartMbSync then
    TppMotherBaseManagement.ProcessBeforeSync()
    TppMotherBaseManagement.StartSyncControl{}
    TppSave.SaveGameData(nil,nil,nil,true)
  end
end
function e.VarSaveMbMissionStartSyncEnd()
  if gvars.reservedMissionStartMbSync then
    gvars.reservedMissionStartMbSync=false
    TppSave.VarSaveMbMangement()
  end
end
function e.AcquireKeyItem(n)
  local t=n.dataBaseId
  local a=n.isShowAnnounceLog
  local n=n.pushReward
  if(TppMotherBaseManagement.IsGotDataBase{dataBaseId=t}==false)then
    TppMotherBaseManagement.DirectAddDataBase{dataBaseId=t,isNew=true}
    if a then
      local e=e.keyItemAnnounceLogTable[t]
      if e then
        TppUI.ShowAnnounceLog("find_keyitem",e)
      end
    elseif n then
      local e=e.keyItemRewardTable[t]
      if e then
        TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId=e,rewardType=TppReward.TYPE.KEY_ITEM}
      end
    end
  end
end
function e.ReserveHelicopterSoundOnMissionGameEnd()
  mvars.trm_needHeliSoundOnAddStaffsFromTempBuffer=true
end
function e.AddVolunteerStaffs()
  local e=TppStory.GetCurrentStorySequence()
  if e<TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE then
    return
  end
  local e={[10010]=true,[10030]=true,[10240]=true,[10280]=true,[30050]=true,[30150]=true,[30250]=true,[50050]=true}
  if e[vars.missionCode]then
    return
  end
  local e=TppMission.IsHelicopterSpace(vars.missionCode)
  if e then
    return
  end
  local t=svars.killCount
  local e=(svars.scoreTime/1e3)/60
  local e={missionId=vars.missionCode,clearTimeMinute=e,killCount=t}
  if(vars.missionCode~=30010)and(vars.missionCode~=30020)then
    TppMotherBaseManagement.AddVolunteerStaffs(e)
  else
    TppMotherBaseManagement.AddOgreUserVolunteerStaffs(e)
  end
  if TppMotherBaseManagement.AddMinimumSecurityStaffs then
    TppMotherBaseManagement.AddMinimumSecurityStaffs()
  end
end
function e.UnSetUsageRestriction(t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_REWORD,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_DEVELOP,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_STAFF,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_COMBAT,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_BASE,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_BASE_EXPANTION,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_BASE_SECURITY,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_RESOURCE,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_DB,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_DB_PFRATING,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_DB_CASSETTE,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_CUSTOM,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_EMERGENCIE_F,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_EMERGENCIE_N,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_SIDEOPSLIST,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_LOCATION,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_RETURNMB,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_DROP,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_BUDDY,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_ATTACK,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_HELI,t)
end
function e.UnSetUsageRestrictionOnFOB(t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_REWORD,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_DEVELOP,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_STAFF,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_COMBAT,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_BASE,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_BASE_EXPANTION,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_BASE_SECURITY,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_RESOURCE,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_DB,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_DB_PFRATING,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_DB_CASSETTE,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MBM_CUSTOM,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_EMERGENCIE_F,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_EMERGENCIE_N,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_SIDEOPSLIST,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_LOCATION,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_RETURNMB,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_DROP,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_BUDDY,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_ATTACK,t)
  TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.MSN_HELI,t)
end
function e.SetDevelpedByDevelopIdList(e)
  for t,e in ipairs(e)do
    TppMotherBaseManagement.SetEquipDeveloped{equipDevelopID=e}
  end
end
function e.IsNeedPlayPandemicTutorialRadio()
  if gvars.trm_donePandemicEvent then
    return false
  end
  if gvars.trm_donePandemicTutorial then
    return false
  end
  if(not TppMission.IsHelicopterSpace(vars.missionCode))then
    return false
  end
  return e.PandemicTutorialStoryCondition()
end
function e.PandemicTutorialStoryCondition()
  if TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_AFTER_WHITE_MAMBA then
    return true
  end
  return false
end
function e.StartPandemicEvent()
  if gvars.trm_donePandemicEvent then
    return
  end
  if not TppMotherBaseManagement.IsPandemicEventMode()then
    TppUiCommand.RequestMbDvcOpenCondition{isTopModeMotherBase=true}
    TppMotherBaseManagement.StartPandemicEventMode()
  end
end
function e.IsNeedStartPandemicTutorial()
  if not TppMotherBaseManagement.IsPandemicEventMode()then
    return false
  end
  if gvars.trm_donePandemicEvent then
    return false
  end
  if gvars.trm_donePandemicTutorial then
    return false
  end
  return true
end
function e.FinishPandemicTutorial()
  if gvars.trm_donePandemicTutorial then
    return
  end
  gvars.trm_donePandemicTutorial=true
end
function e.IsPandemicTutorialFinished()
  return gvars.trm_donePandemicTutorial
end
function e.CheckPandemicEventFinish()
  if TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA then
    return true
  end
end
function e.FinishPandemicEvent()
  TppMotherBaseManagement.DisableKikongoFirst()
  if gvars.trm_donePandemicEvent then
    return
  end
  if TppMotherBaseManagement.IsPandemicEventMode()then
    TppMotherBaseManagement.EndPandemicEventMode()gvars.trm_donePandemicEvent=true
  end
end
function e.UpdatePandemicEventBingoCount()
  local e,t=TppMotherBaseManagement.GetPandemicBingoCount()gvars.trm_lastPandemicBingoCount=gvars.trm_currentPandemicBingoCount
  gvars.trm_currentPandemicBingoCount=e
  gvars.trm_currentPandemicRestCount=t
end
function e.GetPandemicBingoCount()
  local e=gvars.trm_lastPandemicBingoCount
  if e<1 then
    e=1
  end
  local t=gvars.trm_currentPandemicBingoCount/e
  local e=gvars.trm_currentPandemicBingoCount+gvars.trm_currentPandemicRestCount
  if e<1 then
    e=1
  end
  local e=gvars.trm_currentPandemicBingoCount/e
  return gvars.trm_currentPandemicBingoCount,t,e
end
local r={GROUP_A={storySequence=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,missionList={10033,10043,10036},proceedCount=1,privilegeNameList={"RESCUE_HOSTAGE_E20010_001","RESCUE_HOSTAGE_E20010_002","RESCUE_HOSTAGE_E20010_003","RESCUE_HOSTAGE_E20010_004","RESCUE_FRIENDMAN"},dlcItem={STAFF_STAFF1_FOX={"STAFF_STAFF1_FOX_01","STAFF_STAFF1_FOX_02"}}},GROUP_B={storySequence=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON,privilegeNameList={"RESCUE_SP_HOSTAGE","RESCUE_HOSTAGE_E20020_000","RESCUE_HOSTAGE_E20020_001","RESCUE_ENEMY_US_MISSION_TARGET_CENTER000","RESCUE_ENEMY_US_MISSION_TARGET_SQUAD000"},dlcItem={STAFF_STAFF2_MSF={"STAFF_STAFF2_MSF_01","STAFF_STAFF2_MSF_02"}}},GROUP_C={storySequence=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON,missionList={10041,10044,10052,10054},proceedCount=2,privilegeNameList={"RESCUE_HOSTAGE_E20030_000","RESCUE_HOSTAGE_E20030_001","RESCUE_HOSTAGE_E20030_002","RESCUE_E20030_BETRAYER","RESCUE_E20030_MASTERMIND"},dlcItem={STAFF_STAFF3_DD={"STAFF_STAFF3_DD_01","STAFF_STAFF3_DD_02"}}},GROUP_D={storySequence=TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY,privilegeNameList={"RESCUE_HOSTAGE_E20050_000","RESCUE_HOSTAGE_E20050_001","RESCUE_HOSTAGE_E20050_002","RESCUE_HOSTAGE_E20050_003","RESCUE_GENOME_SOILDER_SAVE"},dlcItem={STAFF_STAFF4_FOX_HOUND={"STAFF_STAFF4_FOX_HOUND_01","STAFF_STAFF4_FOX_HOUND_02"}}}}
function e.AcquirePrivilegeStaff()
  if(vars.missionCode==10030)or(TppMission.IsFOBMission(vars.missionCode))then
    return
  end
  local n=TppStory.GetCurrentStorySequence()
  for a,t in pairs(r)do
    if t.storySequence<=n then
      local a=true
      local n=t.missionList
      if n then
        local e=TppStory.GetClearedMissionCount(n)
        if e<t.proceedCount then
          a=false
        end
      end
      if a then
        for n,t in ipairs(t.privilegeNameList)do
          e.AcquireGzPrivilege(t,e._AcquireGzPrivilegeStaff)
        end
        for t,n in pairs(t.dlcItem)do
          local t=DlcItem[t]if t then
            e.AcquireDlcItem(t,e._AcquireDlcItemStaff,n)
          end
        end
      end
    end
  end
end
function e._AcquireGzPrivilegeStaff(t)
  return e._AcquirePrivilegeStaff(t,"fromGZ")
end
function e._AcquireDlcItemStaff(n,t)
  for n,t in ipairs(t)do
    local e=e._AcquirePrivilegeStaff(t,"fromExtra")
    if not e then
      return
    end
  end
  return true
end
function e._AcquirePrivilegeStaff(t,n)
  local t=TppDefine.UNIQUE_STAFF_TYPE_ID[t]
  if not t then
    return
  end
  return e._AddUniqueVolunteerStaff(t,n)
end
function e.AcquirePrivilegeInTitleScreen()
  e.AcquireGzPrivilegeKeyItem()
  e.AcquireDlcItemKeyItem()
  e.AcquireDlcItemEmblem()
end
function e.AcquireGzPrivilegeKeyItem()
  local t={SAVEDATA_EXIST=t.EXTRA_4011,CLEAR_MISSION_20060=t.EXTRA_4012}
  local function n(e)
    local e=t[e]
    TppMotherBaseManagement.DirectAddDataBase{dataBaseId=e,isNew=true}
    return true
  end
  for t,a in pairs(t)do
    e.AcquireGzPrivilege(t,n)
  end
end
function e.AcquireDlcItemKeyItem()
  local t={WEAPON_MACHT_P5_WEISS=t.EXTRA_4000,WEAPON_RASP_SB_SG_GOLD=t.EXTRA_4001,WEAPON_PB_SHIELD_SIL=t.EXTRA_4002,WEAPON_PB_SHIELD_OD=t.EXTRA_4003,WEAPON_PB_SHIELD_WHT=t.EXTRA_4004,WEAPON_PB_SHIELD_GLD=t.EXTRA_4005,ITEM_CBOX_APD=t.EXTRA_4006,ITEM_CBOX_RT=t.EXTRA_4007,ITEM_CBOX_WET=t.EXTRA_4008,SUIT_FATIGUES_APD=t.EXTRA_4015,SUIT_FATIGUES_GRAY_URBAN=t.EXTRA_4016,SUIT_FATIGUES_BLUE_URBAN=t.EXTRA_4017,SUIT_FATIGUES_BLACK_OCELOT=t.EXTRA_4018,WEAPON_ADAM_SKA_SP=t.EXTRA_4024,WEAPON_WU_S333_CB_SP=t.EXTRA_4025,SUIT_MGS3_NORMAL=t.EXTRA_4019,SUIT_MGS3_SNEAK=t.EXTRA_4022,SUIT_MGS3_TUXEDO=t.EXTRA_4023,SUIT_THE_BOSS=t.EXTRA_4026,SUIT_EVA=t.EXTRA_4027,HORSE_WESTERN=t.EXTRA_4028,HORSE_PARADE=t.EXTRA_4009}
  local function a(n,e)
    local e=t[e]
    TppMotherBaseManagement.DirectAddDataBase{dataBaseId=e,isNew=true}
    return true
  end
  for n,t in pairs(t)do
    local t=DlcItem[n]
    if t then
      e.AcquireDlcItem(t,a,n)
    end
  end
end
function e.AcquireDlcItemEmblem()
  local t={EMBLEM_FRONT_VENOM_SNAKE="front85"}
  local function a(t,e)
    return TppEmblem.Add(e)
  end
  for t,n in pairs(t)do
    local t=DlcItem[t]if t then
      e.AcquireDlcItem(t,a,n)
    end
  end
end
function e.AcquireGzPrivilege(e,t)
  if not TppUiCommand.CheckGzSaveDataFlag(e)then
    return
  end
  if TppUiCommand.CheckGzPrivilegeAcquiredFlag(e)then
    return
  end
  if not Tpp.IsTypeFunc(t)then
    return
  end
  local t=t(e)
  if t then
    TppUiCommand.SetGzPrivilegeAcquired(e)
  end
end
function e.AcquireDlcItem(e,t,n)
  if not TppUiCommand.CheckDlcFlag(e)then
    return
  end
  if TppUiCommand.CheckDlcAcquiredFlag(e)then
    return
  end
  if not Tpp.IsTypeFunc(t)then
    return
  end
  local t=t(e,n)
  if t then
    TppUiCommand.SetDlcAcquired(e)
  end
end
local n={
  [t.STAFF_UNIQUE_TYPE_ID_OCELOT]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,
  [t.STAFF_UNIQUE_TYPE_ID_MILLER]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,
  [t.STAFF_UNIQUE_TYPE_ID_HEUY]=TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY,
  [t.STAFF_UNIQUE_TYPE_ID_CODE_TALKER]=TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA
}
function e.AddUniqueCharactor()
  local e=TppStory.GetCurrentStorySequence()
  for t,n in pairs(n)do
    if n<=e then
      local e=TppMotherBaseManagement.GenerateStaffParameter{staffType="Unique",uniqueTypeId=t}
      if not TppMotherBaseManagement.IsExistStaff{staffId=e}then
        TppMotherBaseManagement.DirectAddStaff{staffId=e}
      end
    end
  end
end
function e.GetFobStatus()
  if gvars.ini_isTitleMode then
    return
  end
  TppServerManager.GetFobStatus()
end
function e.OnNoticeFobSneaked(t,n)
  if e.IsDisableNoticeFobSneaked()then
    return
  end
  local n={[FobMode.MODE_ACTUAL]="fobNoticeIntruder",[FobMode.MODE_SHAM]="fobReqPractice",[FobMode.MODE_VISIT]="fobVisitFob"}
  local t=n[t]if t then
    TppMotherBaseManagement.SetMyFobEmergency{emergency=true}e.ShowNoticeFobSneaked(t)
  end
end
function e.OnNoticeSupporterFobSneaked()
  if e.IsDisableNoticeFobSneaked()then
    return
  end
  TppMotherBaseManagement.SetFollowerFobEmergency{emergency=true}e.ShowNoticeFobSneaked"fobReqHelp"
end
function e.IsDisableNoticeFobSneaked()
  local t=false
  local n={[10010]=true,[10030]=true,[10115]=true,[10150]=true,[10151]=true,[10240]=true,[10260]=true,[10280]=true,[11151]=true}
  local e=vars.missionCode
  if n[e]and(not TppStory.IsMissionCleard(e))then
    t=true
  end
  if TppMission.IsFOBMission(e)then
    t=true
  end
  return t
end
function e.ShowNoticeFobSneaked(e)
  TppUI.ShowEmergencyAnnounceLog(true)
  TppUiCommand.ShowMissionIcon("urgent_time",6,TppUI.ANNOUNCE_LOG_TYPE[e])
end
function e.OnAllocate(e)
  mvars.trm_fultonInfo={}
end
function e.Init(t)
  TppClock.RegisterClockMessage("TerminalVoiceOnSunSet",TppClock.DAY_TO_NIGHT)
  TppClock.RegisterClockMessage("TerminalVoiceOnSunRise",TppClock.NIGHT_TO_DAY)
  TppClock.RegisterClockMessage("WolfHowl","00:00:00")
  if t.sequence then
    if t.sequence.ALLWAYS_DIRECT_ADD_STAFF then
      mvars.trm_isAlwaysDirectAddStaff=true
    end
    if t.sequence.SKIP_ADD_STAFF_TO_TEMP_BUFFER then
      mvars.trm_isAlwaysDirectAddStaff=true
    end
    if t.sequence.SKIP_ADD_RESOURCE_TO_TEMP_BUFFER then
      mvars.trm_isSkipAddResourceToTempBuffer=true
    end
    if vars.missionCode==30150 or vars.missionCode==30250 then
      mvars.trm_isAlwaysDirectAddStaff=true
      mvars.trm_isSkipAddResourceToTempBuffer=true
    end
  end
  mvars.trm_voiceDisabled=mvars.trm_voiceDisabled or false
  e.SetUp()
  e.ReleaseMbSection()
  e.ReleaseFunctionOfMbSection()
  e.ReleaseFreePlay()
  e.InitNuclearAbolitionCount()
  e.RemoveStaffsAfterS10240()
  TppUiCommand.SetTutorialMode(false)
  TppUiCommand.SetAllInvalidMbSoundControllerVoice(false)
  mvars.trm_EmblemLocatorIdTable={}
  for e,t in pairs(e.EMBLEM_LOCATOR_TABLE)do
    local e=TppCollection.GetUniqueIdByLocatorName(e)
    mvars.trm_EmblemLocatorIdTable[e]=t
  end
  TppUiCommand.ClearMbDvcOpenConditionRequest()
end
function e.MakeMessage()
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnReload(t)
e.Init(t)
e.MakeMessage()
end
function e.OnMissionGameStart(e)
  if not mvars.trm_currentIntelCpName then    
    TppUiCommand.DeactivateSpySearchForCP()
    TppUiCommand.ActivateSpySearchForField()
  end
end
function e.DeclareSVars()
  return{
  {name="trm_missionFultonCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},
  {name="trm_isBuddyRecovered",type=TppScriptVars.TYPE_BOOL,arraySize=a,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MB_MANAGEMENT},
  nil}
end
function e.Messages()
  local a=TppEnemy.GetCpIntelTrapTable()
  local n
  if a and next(a)then
    n={}
    for a,t in pairs(a)do
      local r={msg="Enter",sender=t,
      func=function(t,t)
        e.OnEnterCpIntelTrap(a)
        if TppSequence.IsMissionPrepareFinished()then
          e.ShowLocationAndBaseTelop()
        end
      end,
      option={isExecMissionPrepare=true}}
      table.insert(n,r)
      local e={msg="Exit",sender=t,
      func=function(t,t)
        e.OnExitCpIntelTrap(a)
      end,
      option={isExecMissionPrepare=true}}
      table.insert(n,e)
    end
    table.insert(n,{msg="Enter",sender="trap_intel_afgh_waterway_cp",func=function(t,t)
      e.SetBaseTelopName"afgh_waterWay_cp"
      if TppSequence.IsMissionPrepareFinished()then
        e.ShowLocationAndBaseTelop()
      end
    end,option={isExecMissionPrepare=true}})
    table.insert(n,{msg="Exit",sender="trap_intel_afgh_waterway_cp",func=function(t,t)
      e.ClearBaseTelopName()
    end,option={isExecMissionPrepare=true}})
    table.insert(n,{msg="Enter",sender="trap_intel_afgh_ruins_cp",func=function(t,t)
      e.SetBaseTelopName"afgh_ruins_cp"
      if TppSequence.IsMissionPrepareFinished()then
        e.ShowLocationAndBaseTelop()
      end
    end,option={isExecMissionPrepare=true}})
    table.insert(n,{msg="Exit",sender="trap_intel_afgh_ruins_cp",func=function(t,t)
      e.ClearBaseTelopName()
    end,option={isExecMissionPrepare=true}})
  end
  return Tpp.StrCode32Table{
    GameObject={
      {msg="Fulton",func=function(t,a,r,n)
        if not TppMission.IsFOBMission(vars.missionCode)then
          e.OnFultonMessage(t,a,r,n)
        end
      end,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="FultonInfo",func=function(n,t)
        if not TppMission.IsFOBMission(vars.missionCode)then
          e.OnFultonInfoMessage(n,t)
        end
      end,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="FultonFailedEnd",func=e.OnFultonFailedEnd},{msg="HeliDoorClosed",func=e.OnRecoverByHelicopter,option={isExecDemoPlaying=true}},
      {msg="Returned",func=e.OnRecoverByHelicopter,option={isExecDemoPlaying=true}}
    },
    MotherBaseManagement={
      {msg="AssignedStaff",func=function(n,e)
        if(n==t.SECTION_SEPARATION)and(e>0)then
          gvars.trm_doneIsolateByManual=true
          if(TppMission.IsFreeMission(vars.missionCode)or TppMission.IsHelicopterSpace(vars.missionCode))and TppRadio.IsRadioPlayable()then
            TppFreeHeliRadio._PlayRadio(TppFreeHeliRadio.PANDEMIC_RADIO.ON_ISOLATE_STAFF)
          end
        end
      end}
    },
    Weather={
      {msg="WeatherForecast",func=e.TerminalVoiceWeatherForecast},
      {msg="Clock",sender="TerminalVoiceOnSunSet",func=e.TerminalVoiceOnSunSet},
      {msg="Clock",sender="TerminalVoiceOnSunRise",func=e.TerminalVoiceOnSunRise},
      {msg="Clock",sender="WolfHowl",func=function()
        if TppLocation.GetLocationName()=="afgh"then
          if not TppMission.IsHelicopterSpace(vars.missionCode)then
            TppSoundDaemon.PostEvent"sfx_s_mdnt_date_cng"
          end
        end
      end}
    },
    Terminal={
      {msg="MbDvcActCallBuddy",func=function(e,t)
        TppUI.SetSupportCallBuddyType(e)
        TppUI.ShowCallSupportBuddyAnnounceLog()
      end}
    },
    Trap=n,
    Network={
      {msg="NoticeSneakMotherBase",func=e.OnNoticeFobSneaked},
      {msg="NoticeSneakSupportedMotherBase",func=e.OnNoticeSupporterFobSneaked}
    }
  }
end

function e.OnMessage(M,_,o,r,n,a,t)
  Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,M,_,o,r,n,a,t)
end
function e.OnFultonMessage(e,a,n,t)mvars.trm_fultonInfo=mvars.trm_fultonInfo or{}mvars.trm_fultonInfo[e]={e,a,n,t}
end
function e.OnFultonInfoMessage(n,a)mvars.trm_fultonInfo=mvars.trm_fultonInfo or{}
  local t=mvars.trm_fultonInfo[n]if t then
    e.OnFulton(t[1],t[2],t[3],t[4],nil,nil,a)mvars.trm_fultonInfo[n]=nil
  end
  mvars.trm_fultonFaileEndInfo=mvars.trm_fultonFaileEndInfo or{}
  local t=mvars.trm_fultonFaileEndInfo[n]if t then
    e._OnFultonFailedEnd(t[1],t[2],t[3],t[4],a)mvars.trm_fultonFaileEndInfo[n]=nil
  end
end
function e.SetUp()
  if gvars.str_storySequence<=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
    local t=TppMission.IsHelicopterSpace(vars.missionCode)
    if t then
      e.SetUpStoryBeforeCleardRescueMillerOnHelicopter()
    else
      e.SetUpStoryBeforeCleardRescueMiller()
    end
  elseif gvars.str_storySequence<=TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
    e.SetUpStoryCleardRescueMiller()
  elseif gvars.str_storySequence<=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE then
    e.SetUpStoryCleardToMotherBase()
  elseif gvars.str_storySequence<=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
    e.SetUpStoryCleardHoneyBee()
  elseif gvars.str_storySequence<=TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION then
    e.SetUpStoryCleardPitchDark()
  else
    e.SetUpStoryAfterCleardPitchDark()
  end
  if e.IsReleaseSection"Combat"then
    e.EnableDvcMenuByList{{menu=e.MBDVCMENU.MBM_COMBAT,active=true}}
  end
  if e.IsReleaseSection"Security"then
    TppUiStatusManager.UnsetStatus("MbOceanAreaSell","INVALID")
  else
    TppUiStatusManager.SetStatus("MbOceanAreaSell","INVALID")
  end
  if TppStory.IsMissionCleard(10033)then
    TppUiStatusManager.UnsetStatus("CommonTab","BLOCK_ARTIFICIAL_ARM_TAB")
  else
    TppUiStatusManager.SetStatus("CommonTab","BLOCK_ARTIFICIAL_ARM_TAB")
  end
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
    TppUiStatusManager.SetStatus("MbMotherBaseInfo","INVALID")
    TppUiStatusManager.SetStatus("MbTop","BLOCK_FULTON_VIEW")
    TppUiStatusManager.SetStatus("CommonTab","BLOCK_ANIMAL_TAB")
    TppUiStatusManager.SetStatus("MbPauseHelp","IS_KAZ_MISSION")
  else
    TppUiStatusManager.UnsetStatus("MbMotherBaseInfo","INVALID")
    TppUiStatusManager.UnsetStatus("MbTop","BLOCK_FULTON_VIEW")
    TppUiStatusManager.UnsetStatus("CommonTab","BLOCK_ANIMAL_TAB")
    TppUiStatusManager.UnsetStatus("MbPauseHelp","IS_KAZ_MISSION")
  end
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY then
    TppUiStatusManager.SetStatus("CommonTab","BLOCK_MAFR_TAB")
    TppUiStatusManager.SetStatus("CommonTab","BLOCK_RESOURCE_WALKER_GEAR_TAB")
  else
    TppUiStatusManager.UnsetStatus("CommonTab","BLOCK_MAFR_TAB")
    TppUiStatusManager.UnsetStatus("CommonTab","BLOCK_RESOURCE_WALKER_GEAR_TAB")
  end
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA then
    TppUiStatusManager.SetStatus("CommonTab","BLOCK_PARASITE_TAB")
    TppUiStatusManager.SetStatus("MbMap","BLOCK_OKB_ZERO")
  else
    TppUiStatusManager.UnsetStatus("CommonTab","BLOCK_PARASITE_TAB")
    TppUiStatusManager.UnsetStatus("MbMap","BLOCK_OKB_ZERO")
  end
  e.SetUpArmsMBDVCMenu()
  e.SetUpBuddyMBDVCMenu()
  e.SetUpCustomWeaponMBDVCMenu()

  if TppMission.IsSubsistenceMission()then
    local dvcMenu={{menu=e.MBDVCMENU.MSN_DROP,active=false},{menu=e.MBDVCMENU.MSN_BUDDY,active=false},{menu=e.MBDVCMENU.MSN_ATTACK,active=false},{menu=e.MBDVCMENU.MSN_HELI_ATTACK,active=false}}
    if gvars.isManualSubsistence==TppMain.SUBSISTENCE_BOUND then--tex allow Buddy Support menu when Buddy Subsistence mode
     dvcMenu[2].active=true
    end
    e.EnableDvcMenuByList(dvcMenu)
    TppUiStatusManager.SetStatus("Subjective","SUPPORT_NO_USE")
  else
    TppUiStatusManager.UnsetStatus("Subjective","SUPPORT_NO_USE")
  end
end
function e.SetUpArmsMBDVCMenu()
  if e.IsOpenMBDvcArmsMenu()then
    e.EnableDvcMenuByList{{menu=e.MBDVCMENU.MBM_DEVELOP_ARMS,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_ARMS,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_ARMS_HELI,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_ARMS_VEHICLE,active=true}}
  end
end
function e.SetUpCustomWeaponMBDVCMenu()
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION then
    return
  end
  do
    e.EnableDvcMenuByList{{menu=e.MBDVCMENU.MBM_CUSTOM_WEAPON,active=true}}
  end
end
function e.SetUpBuddyMBDVCMenu()
  if gvars.str_storySequence<=TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
    return
  end
  e.EnableDvcMenuByList{{menu=e.MBDVCMENU.MSN_BUDDY,active=true}}
  e.EnableDvcMenuByList{{menu=e.MBDVCMENU.MSN_BUDDY_EQUIP,active=true}}
  local t={HORSE=BuddyType.HORSE,DDOG=BuddyType.DOG,QUIET=BuddyType.QUIET,WALKER_GEAR=BuddyType.WALKER_GEAR,BATTLE_GEAR=BuddyType.BATTLE_GEAR}
  for n,t in pairs(t)do
    local n=TppBuddyService.CanSortieBuddyType(t)
    if n then
      local t=e.BUDDY_MB_DVC_MENU[t]
      if t then
        e.EnableDvcMenuByList(t)
      end
    end
  end
end
function e.DoFuncByFultonTypeSwitch(e,t,n,a,o,r,M,_,u,i,E,T,s,c,d,p,S)
  if Tpp.IsSoldier(e)then
    return M(e,t,n,a,o,r)
  elseif Tpp.IsVolgin(e)then
    return _(e)
  elseif Tpp.IsHostage(e)then
    return u(e,t,n,a,o,r)
  elseif Tpp.IsVehicle(e)then
    return i(e,t,n,a,nil,r)
  elseif Tpp.IsFultonContainer(e)then
    return E(e,t,n,a,nil,r)
  elseif Tpp.IsFultonableGimmick(e)then
    return T(e,t,n,a,nil,r)
  elseif Tpp.IsEnemyWalkerGear(e)then
    return c(e,t,n,a,nil,r)
  elseif Tpp.IsAnimal(e)then
    return d(e,t,n,a,nil,r)
  elseif Tpp.IsBossQuiet(e)then
    return p(e,t,n,a,o,r)
  elseif Tpp.IsParasiteSquad(e)then
    return S(e,t,n,a,nil,r)
  else
    local o=Tpp.GetBuddyTypeFromGameObjectId(e)
    if o then
      return s(e,t,n,a,o,r)
    end
  end
end
function e.OnFulton(t,a,n,o,_,M,r)
  if M then
    mvars.trm_needHeliSoundOnAddStaffsFromTempBuffer=true
  end
  TppEnemy.SetRecovered(t)
  TppEnemy.ExecuteOnRecoveredCallback(t,a,n,o,_,M,r)
  if Tpp.IsLocalPlayer(r)then
    TppEnemy._OnFulton(t,a,n,o)
  end
  e.DoFuncByFultonTypeSwitch(t,a,n,o,_,r,e.OnFultonSoldier,e.OnFultonVolgin,e.OnFultonHostage,e.OnFultonVehicle,e.OnFultonContainer,e.OnFultonGimmickCommon,e.OnFultonBuddy,e.OnFultonEnemyWalkerGear,e.OnFultonAnimal,e.OnFultonBossQuiet,e.OnFultonParasiteSquad)
end
function e.IncrementFultonCount()
svars.trm_missionFultonCount=svars.trm_missionFultonCount+1
end
function e.GetMissionHumanFultonCount()
  return svars.trm_missionFultonCount
end
function e.IncrementRecoveredSoldierCount()gvars.trm_recoveredSoldierCount=gvars.trm_recoveredSoldierCount+1
  e.GetFultonCountKeyItem()
end
function e.GetRecoveredSoldierCount()
  return gvars.trm_recoveredSoldierCount
end
function e.IncrementRecoveredHostageCount()gvars.trm_recoveredHostageCount=gvars.trm_recoveredHostageCount+1
  e.GetFultonCountKeyItem()
end
function e.GetRecoveredHostageCount()
  return gvars.trm_recoveredHostageCount
end
function e.GetFultonCountKeyItem()
  local n=gvars.trm_recoveredSoldierCount+gvars.trm_recoveredHostageCount
  if n>=T then
    e.AcquireKeyItem{dataBaseId=t.DESIGN_3006,isShowAnnounceLog=true}
  end
  if n>=p then
    e.AcquireKeyItem{dataBaseId=t.DESIGN_3005,isShowAnnounceLog=true}
  end
end
function e.OnFultonSoldier(t,n,n,r,a,o)
  if a then
    local e={id="SetToHeliRecoveredComplete"}
    GameObject.SendCommand(t,e)
  end
  local M=TppMotherBaseManagement.GetTempStaffStatusFromGameObject{gameObjectId=t}
  local n
  if r then
    n=r
  else
    n=TppMotherBaseManagement.GetStaffIdFromGameObject{gameObjectId=t}
  end
  if Tpp.IsLocalPlayer(o)then
    TppHero.OnFultonSoldier(t,a)
    e.IncrementFultonCount()
    if not a then
      e.IncrementRecoveredSoldierCount()
      local e=TppEnemy.GetSoldierType(t)
      if e~=EnemyType.TYPE_DD then
        TppTrophy.Unlock(29)
      end
    end
    PlayRecord.RegistPlayRecord"SOLDIER_RESCUE"
    Tpp.IncrementPlayData"totalRescueCount"
  end
  e.AddTempStaffFulton{staffId=n,gameObjectId=t,tempStaffStatus=M,fultonedPlayer=o}
end
function e.OnFultonVolgin(e)
  if mvars.trm_isSkipAddResourceToTempBuffer then
    return
  end
  TppMotherBaseManagement.AddTempCorpse()
end
function e.OnFultonHostage(t,n,n,a,r,o)
  local M=TppMotherBaseManagement.GetTempStaffStatusFromGameObject{gameObjectId=t}
  local n
  if a then
    n=a
  else
    n=TppMotherBaseManagement.GetStaffIdFromGameObject{gameObjectId=t}
  end
  if Tpp.IsLocalPlayer(o)then
    TppHero.OnFultonHostage(t,r)
    e.IncrementFultonCount()
    if not r then
      e.IncrementRecoveredHostageCount()
    end
    PlayRecord.RegistPlayRecord"HOSTAGE_RESCUE"
    Tpp.IncrementPlayData"totalRescueCount"
    local e=GameObject.SendCommand(t,{id="IsFemale"})
    if e then
      TppTrophy.Unlock(31)
    end
  end
  e.AddTempStaffFulton{staffId=n,gameObjectId=t,tempStaffStatus=M,fultonedPlayer=o}
end
function e.OnFultonVehicle(a,a,a,t,a,n)
  if mvars.trm_isSkipAddResourceToTempBuffer then
    return
  end
  e.AddTempResource(t,nil,n)
end
function e.OnFultonContainer(a,t,n,o,o,r)
  if mvars.trm_isSkipAddResourceToTempBuffer then
    return
  end
  if TppMission.IsFOBMission(vars.missionCode)then
    if not e.CheckAddTempBuffer(r)then
      return
    end
    local e,n,t=MotherBaseConstructConnector.GetContainerResourceId(t,n)
    if e==nil then
      e=0
    end
    TppMotherBaseManagement.AddTempResource{resourceId=e,count=1,visual=n,owner=t}
  else
    local e=TppGimmick.GetGimmickID(a,t,n)
    if not e then
      e="commFacility_cntn001"
    end
    Gimmick.CallFindContainerResourceLog(e)
    TppMotherBaseManagement.AddTempGimmickResource{gimmickName=e}
  end
end
e.GIMMICK_RESOURCE_ID_TABLE={[1845465265]=t.RESOURCE_ID_EMPLACEMENT_GUN_EAST,[2207998916]=t.RESOURCE_ID_EMPLACEMENT_GUN_WEST,[1187982616]=t.RESOURCE_ID_MORTAR_NORMAL,[3601635493]=t.RESOURCE_ID_ANTI_AIR_GATLING_GUN_EAST,[20562949]=t.RESOURCE_ID_ANTI_AIR_GATLING_GUN_WEST}
function e.OnFultonGimmickCommon(t,t,t,n,t,a)
  if mvars.trm_isSkipAddResourceToTempBuffer then
    return
  end
  local t=e.GIMMICK_RESOURCE_ID_TABLE[n]if t then
    e.AddTempResource(t,nil,a)
  else
    e.AddTempResource(n,nil,a)
  end
end
function e.OnFultonBuddy(t,t,t,t,e,t)
  if mvars.trm_isSkipAddResourceToTempBuffer then
    return
  end
  svars.trm_isBuddyRecovered[e]=true
  if e==BuddyType.QUIET then
    TppMotherBaseManagement.AddTempBuddy()
  end
  if e==BuddyType.DOG then
    TppMotherBaseManagement.AddTempPuppy()
  end
end
function e.OnFultonEnemyWalkerGear(n,n,n,t,n,n)
  if mvars.trm_isSkipAddResourceToTempBuffer then
    return
  end
  e.AddTempResource(t)
end
function e.OnFultonAnimal(a,n)
  if mvars.trm_isSkipAddResourceToTempBuffer then
    return
  end
  local n=TppAnimal.GetDataBaseIdFromAnimalId(n)
  if e.IsAnimalDog(n)then
    e.AddAnimalRecoverHistory(t.ANIMAL_TYPE_DOG)
  elseif e.IsAnimalHorse(n)then
    e.AddAnimalRecoverHistory(t.ANIMAL_TYPE_HORSE)
  elseif e.IsAnimalBear(n)then
    e.AddAnimalRecoverHistory(t.ANIMAL_TYPE_BEAR)
  elseif e.IsAnimalGoat(n)then
    e.AddAnimalRecoverHistory(t.ANIMAL_TYPE_GOAT)
  else
    local t=0
    e.AddAnimalRecoverHistory(t)
  end
  local a=TppMotherBaseManagement.DataBaseIdToAnimalGroup{dataBaseId=n}
  if(a==t.ANIMAL_GROUP_1900)or(a==t.ANIMAL_GROUP_1920)then
    gvars.trm_recoveredAfghGoatCount=gvars.trm_recoveredAfghGoatCount+1
  elseif(a==t.ANIMAL_GROUP_1940)or(a==t.ANIMAL_GROUP_1960)then
    gvars.trm_recoveredMafrGoatCount=gvars.trm_recoveredMafrGoatCount+1
  elseif(n==t.ANIMAL_200)then
    gvars.trm_recoveredDonkeyCount=gvars.trm_recoveredDonkeyCount+1
  elseif(n==t.ANIMAL_210)then
    gvars.trm_recoveredZebraCount=gvars.trm_recoveredZebraCount+1
  elseif(n==t.ANIMAL_220)then
    gvars.trm_recoveredOkapiCount=gvars.trm_recoveredOkapiCount+1
  end
  PlayRecord.RegistPlayRecord"ANIMAL_RESCUE"
  e.AddTempDataBaseAnimal(n,tostring(mvars.animalBlockAreaName))
end
function e.GetRecoveredAfghGoatCount()
  return gvars.trm_recoveredAfghGoatCount
end
function e.GetRecoveredMafrGoatCount()
  return gvars.trm_recoveredMafrGoatCount
end
function e.GetRecoveredDonkeyCount()
  return gvars.trm_recoveredDonkeyCount
end
function e.GetRecoveredZebraCount()
  return gvars.trm_recoveredZebraCount
end
function e.GetRecoveredOkapiCount()
  return gvars.trm_recoveredOkapiCount
end
function e.IsRecoveredCompleatedGoat()
  return(((((((((TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1900}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1901})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1902})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1903})and(((TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1910}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1911})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1912})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1913}))and(((TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1920}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1921})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1922})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1923}))and(((TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1930}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1931})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1932})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1933}))and(((((((TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1940}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1941})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1942})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1943})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1944})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1945})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1946})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1947}))and(((((((TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1950}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1951})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1952})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1953})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1954})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1955})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1956})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1957}))and(((((((TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1960}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1961})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1962})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1963})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1964})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1965})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1966})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1967}))and(((((((TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1970}or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1971})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1972})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1973})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1974})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1975})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1976})or TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_1977})
end
function e.IsRecoveredCompleatedHorse()
  return(TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_200}and TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_210})and TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_220}
end
function e.IsRecoveredCompleatedDog()
  return(TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_100}and TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_110})and TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_120}
end
function e.IsRecoveredCompleatedBear()
  return TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_600}and TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.ANIMAL_610}
end
function e.GetAnimalTypeCountFromRecoveredHistory(n)
  local e=0
  for t=0,(TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE-1)do
    if gvars.trm_animalRecoverHistory[t]==n then
      e=e+1
    end
  end
  return e
end
function e.AddAnimalRecoverHistory(t)
  local e=gvars.trm_animalRecoverHistorySize
  if e<TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE then
    gvars.trm_animalRecoverHistory[e]=t
    gvars.trm_animalRecoverHistorySize=e+1
  else
    for e=1,(TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE-1)do
      gvars.trm_animalRecoverHistory[e-1]=gvars.trm_animalRecoverHistory[e]end
    gvars.trm_animalRecoverHistory[TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE-1]=t
    gvars.trm_animalRecoverHistorySize=TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE
  end
end
function e.OnFultonBossQuiet(t,t,t,t)
  local t=i({type="TppBossQuiet2"},{id="GetQuietType"})
  local t=e.parasiteSquadFultonResouceId[t]if t then
    e._OnFultonParasiteSquad(t)
  end
end
function e.OnFultonParasiteSquad(t,n,n,n)
  local t=i(t,{id="GetParasiteType"})
  local t=e.parasiteSquadFultonResouceId[t]if t then
    e._OnFultonParasiteSquad(t)
  end
end
function e._OnFultonParasiteSquad(t)
  local n,t=t[1],t[2]e.AddTempResource(n,t)
  TppHero.SetAndAnnounceHeroicOgrePoint(TppHero.FULTON_PARASITE)
end
function e.IsAnimalDog(e)
  return TppMotherBaseManagement.IsAnimalType{dataBaseId=e,animalType=t.ANIMAL_TYPE_DOG}
end
function e.IsAnimalHorse(e)
  return TppMotherBaseManagement.IsAnimalType{dataBaseId=e,animalType=t.ANIMAL_TYPE_HORSE}
end
function e.IsAnimalBear(e)
  return TppMotherBaseManagement.IsAnimalType{dataBaseId=e,animalType=t.ANIMAL_TYPE_BEAR}
end
function e.IsAnimalGoat(e)
  return TppMotherBaseManagement.IsAnimalType{dataBaseId=e,animalType=t.ANIMAL_TYPE_GOAT}
end
function e.OnRecoverByHelicopter()
  TppHelicopter.SetNewestPassengerTable()
  e.OnRecoverByHelicopterAlreadyGetPassengerList()
  TppHelicopter.ClearPassengerTable()
end
function e.OnRecoverByHelicopterOnCheckPoint()
  TppHelicopter.SetNewestPassengerTable()
  local t=TppHelicopter.GetPassengerlist()
  if t then
    TppHelicopter.ForcePullOut()
  end
  e.OnRecoverByHelicopterAlreadyGetPassengerList()
  TppHelicopter.ClearPassengerTable()
end
function e.OnRecoverByHelicopterAlreadyGetPassengerList()
  local t=TppHelicopter.GetPassengerlist()
  if t==nil then
    TppHelicopter.ClearPassengerTable()
    return
  end
  for n,t in ipairs(t)do
    if not Tpp.IsPlayer(t)then
      e.OnFulton(t,nil,nil,nil,true,false,PlayerInfo.GetLocalPlayerIndex())
    end
  end
end
function e.CheckAddTempBuffer(e)
  if TppMission.IsFOBMission(vars.missionCode)then
    if TppServerManager.FobIsSneak()then
      if e==0 then
        return true
      else
        return false
      end
    else
      return false
    end
  else
    return true
  end
end
function e.AddTempStaffFulton(t)
  if mvars.trm_isAlwaysDirectAddStaff~=true then
    local n=t.fultonedPlayer or 0
    if e.CheckAddTempBuffer(n)then
      TppMotherBaseManagement.AddTempStaffFulton(t)
    end
  end
end
function e.AddTempResource(t,a,n)
  local n=n or 0
  if not e.CheckAddTempBuffer(n)then
    return
  end
  local e=a or 1
  TppMotherBaseManagement.AddTempResource{resourceId=t,count=e}
end
function e.AddTempDataBase(e)
  TppMotherBaseManagement.AddTempDataBase{dataBaseId=e}
end
function e.AddTempDataBaseAnimal(e,t)
  TppMotherBaseManagement.AddTempDataBaseAnimal{dataBaseId=e,areaName=t}
end
local n=4
local n=1.67
function e.AddPickedUpResourceToTempBuffer(t,a)
  if not e.RESOURCE_INFORMATION_TABLE[t]then
    return
  end
  local n=e.RESOURCE_INFORMATION_TABLE[t].resourceName
  local e=e.RESOURCE_INFORMATION_TABLE[t].count
  if TppCollection.IsHerbByType(t)then
    local t=Player.GetRateOfGettingHarb()e=e*t
    TppUI.ShowAnnounceLog("find_plant",a,e)
  end
  if t>=TppCollection.TYPE_POSTER_SOL_AFGN and t<=TppCollection.TYPE_POSTER_MOE_H then
    TppMotherBaseManagement.DirectAddResource{resource=n,count=e,isNew=true}
  else
    TppMotherBaseManagement.AddTempResource{resource=n,count=e}
  end
end
function e.SetUpOnHelicopterSpace()
  e.SetUp()
end
function e.SetUpStoryBeforeCleardRescueMiller()
  e._SetUpDvcMenu{{menu=e.MBDVCMENU.MSN,active=true},{menu=e.MBDVCMENU.MSN_EMERGENCIE_N,active=true},{menu=e.MBDVCMENU.MSN_EMERGENCIE_F,active=true},{menu=e.MBDVCMENU.MSN_LOG,active=true},{menu=e.MBDVCMENU.MBM_REWORD,active=true},{menu=e.MBDVCMENU.MBM_DB_CASSETTE,active=true}}
end
function e.SetUpStoryBeforeCleardRescueMillerOnHelicopter()
  e._SetUpDvcMenu{{menu=e.MBDVCMENU.MSN,active=true},{menu=e.MBDVCMENU.MSN_EMERGENCIE_N,active=true},{menu=e.MBDVCMENU.MSN_EMERGENCIE_F,active=true},{menu=e.MBDVCMENU.MSN_LOG,active=true},{menu=e.MBDVCMENU.MBM_REWORD,active=true},{menu=e.MBDVCMENU.MBM_DB_CASSETTE,active=true}}
end
function e.SetUpStoryCleardRescueMiller()
  e._SetUpDvcMenu{{menu=e.MBDVCMENU.MBM,active=true},{menu=e.MBDVCMENU.MSN,active=true},{menu=e.MBDVCMENU.MBM_REWORD,active=true},{menu=e.MBDVCMENU.MBM_STAFF,active=true},{menu=e.MBDVCMENU.MBM_DEVELOP,active=true},{menu=e.MBDVCMENU.MBM_DEVELOP_WEAPON,active=true},{menu=e.MBDVCMENU.MBM_BASE,active=true},{menu=e.MBDVCMENU.MBM_LOG,active=true},{menu=e.MBDVCMENU.MSN_DROP,active=true},{menu=e.MBDVCMENU.MSN_DROP_BULLET,active=true},{menu=e.MBDVCMENU.MSN_DROP_LOADOUT,active=true},{menu=e.MBDVCMENU.MSN_DROP_VEHICLE,active=true},{menu=e.MBDVCMENU.MSN_HELI,active=true},{menu=e.MBDVCMENU.MSN_HELI_RENDEZVOUS,active=true},{menu=e.MBDVCMENU.MSN_HELI_ATTACK,active=true},{menu=e.MBDVCMENU.MSN_HELI_DISMISS,active=true},{menu=e.MBDVCMENU.MSN_EMERGENCIE_N,active=true},{menu=e.MBDVCMENU.MSN_EMERGENCIE_F,active=true},{menu=e.MBDVCMENU.MSN_LOG,active=true},{menu=e.MBDVCMENU.MSN_LOCATION,active=true},{menu=e.MBDVCMENU.MSN_RETURNMB,active=true},{menu=e.MBDVCMENU.MBM_DB,active=true},{menu=e.MBDVCMENU.MBM_DB_ENCYCLOPEDIA,active=true},{menu=e.MBDVCMENU.MBM_DB_KEYITEM,active=true},{menu=e.MBDVCMENU.MBM_DB_CASSETTE,active=true}}
end
function e.SetUpStoryCleardToMotherBase()
  local t={{menu=e.MBDVCMENU.MBM,active=true},{menu=e.MBDVCMENU.MSN,active=true},{menu=e.MBDVCMENU.MBM_REWORD,active=true},{menu=e.MBDVCMENU.MBM_STAFF,active=true},{menu=e.MBDVCMENU.MBM_DEVELOP,active=true},{menu=e.MBDVCMENU.MBM_DEVELOP_WEAPON,active=true},{menu=e.MBDVCMENU.MBM_BASE,active=true},{menu=e.MBDVCMENU.MBM_BASE_EXPANTION,active=true},{menu=e.MBDVCMENU.MBM_RESOURCE,active=true},{menu=e.MBDVCMENU.MBM_LOG,active=true},{menu=e.MBDVCMENU.MSN_DROP,active=true},{menu=e.MBDVCMENU.MSN_DROP_BULLET,active=true},{menu=e.MBDVCMENU.MSN_DROP_WEAPON,active=true},{menu=e.MBDVCMENU.MSN_DROP_LOADOUT,active=true},{menu=e.MBDVCMENU.MSN_DROP_VEHICLE,active=true},{menu=e.MBDVCMENU.MSN_HELI,active=true},{menu=e.MBDVCMENU.MSN_HELI_RENDEZVOUS,active=true},{menu=e.MBDVCMENU.MSN_HELI_ATTACK,active=true},{menu=e.MBDVCMENU.MSN_HELI_DISMISS,active=true},{menu=e.MBDVCMENU.MSN_EMERGENCIE_N,active=true},{menu=e.MBDVCMENU.MSN_EMERGENCIE_F,active=true},{menu=e.MBDVCMENU.MSN_MISSIONLIST,active=true},{menu=e.MBDVCMENU.MSN_SIDEOPSLIST,active=TppQuest.CanOpenSideOpsList()},{menu=e.MBDVCMENU.MSN_LOG,active=true},{menu=e.MBDVCMENU.MSN_LOCATION,active=true},{menu=e.MBDVCMENU.MSN_RETURNMB,active=true},{menu=e.MBDVCMENU.MBM_DB,active=true},{menu=e.MBDVCMENU.MBM_DB_ENCYCLOPEDIA,active=true},{menu=e.MBDVCMENU.MBM_DB_KEYITEM,active=true},{menu=e.MBDVCMENU.MBM_DB_CASSETTE,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_DESIGN,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_DESIGN_EMBLEM,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_DESIGN_BASE,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_AVATAR,active=true}}e._SetUpDvcMenu(t)
end
function e.IsOpenMBDvcArmsMenu()
  if(gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE)and(TppStory.GetClearedMissionCount{10033,10036,10043}>=1)then
    return true
  else
    return false
  end
end
function e.SetUpStoryCleardHoneyBee()
  local t={{menu=e.MBDVCMENU.MBM,active=true},{menu=e.MBDVCMENU.MSN,active=true},{menu=e.MBDVCMENU.MBM_REWORD,active=true},{menu=e.MBDVCMENU.MBM_STAFF,active=true},{menu=e.MBDVCMENU.MBM_DEVELOP,active=true},{menu=e.MBDVCMENU.MBM_DEVELOP_WEAPON,active=true},{menu=e.MBDVCMENU.MBM_DEVELOP_ARMS,active=true},{menu=e.MBDVCMENU.MBM_BASE,active=true},{menu=e.MBDVCMENU.MBM_BASE_EXPANTION,active=true},{menu=e.MBDVCMENU.MBM_RESOURCE,active=true},{menu=e.MBDVCMENU.MBM_LOG,active=true},{menu=e.MBDVCMENU.MSN_DROP,active=true},{menu=e.MBDVCMENU.MSN_DROP_BULLET,active=true},{menu=e.MBDVCMENU.MSN_DROP_WEAPON,active=true},{menu=e.MBDVCMENU.MSN_DROP_LOADOUT,active=true},{menu=e.MBDVCMENU.MSN_DROP_VEHICLE,active=true},{menu=e.MBDVCMENU.MSN_ATTACK,active=true},{menu=e.MBDVCMENU.MSN_ATTACK_ARTILLERY,active=true},{menu=e.MBDVCMENU.MSN_HELI,active=true},{menu=e.MBDVCMENU.MSN_HELI_RENDEZVOUS,active=true},{menu=e.MBDVCMENU.MSN_HELI_ATTACK,active=true},{menu=e.MBDVCMENU.MSN_HELI_DISMISS,active=true},{menu=e.MBDVCMENU.MSN_EMERGENCIE_N,active=true},{menu=e.MBDVCMENU.MSN_EMERGENCIE_F,active=true},{menu=e.MBDVCMENU.MSN_MISSIONLIST,active=true},{menu=e.MBDVCMENU.MSN_SIDEOPSLIST,active=true},{menu=e.MBDVCMENU.MSN_LOG,active=true},{menu=e.MBDVCMENU.MSN_LOCATION,active=true},{menu=e.MBDVCMENU.MSN_RETURNMB,active=true},{menu=e.MBDVCMENU.MBM_DB,active=true},{menu=e.MBDVCMENU.MBM_DB_ENCYCLOPEDIA,active=true},{menu=e.MBDVCMENU.MBM_DB_KEYITEM,active=true},{menu=e.MBDVCMENU.MBM_DB_CASSETTE,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_DESIGN,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_DESIGN_EMBLEM,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_DESIGN_BASE,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_AVATAR,active=true}}e._SetUpDvcMenu(t)
end
function e.SetUpStoryCleardPitchDark()
e._SetUpDvcMenu{{menu=e.MBDVCMENU.MBM,active=true},{menu=e.MBDVCMENU.MSN,active=true},{menu=e.MBDVCMENU.MBM_REWORD,active=true},{menu=e.MBDVCMENU.MBM_STAFF,active=true},{menu=e.MBDVCMENU.MBM_DEVELOP,active=true},{menu=e.MBDVCMENU.MBM_DEVELOP_WEAPON,active=true},{menu=e.MBDVCMENU.MBM_DEVELOP_ARMS,active=true},{menu=e.MBDVCMENU.MBM_COMBAT,active=true},{menu=e.MBDVCMENU.MBM_BASE,active=true},{menu=e.MBDVCMENU.MBM_BASE_EXPANTION,active=true},{menu=e.MBDVCMENU.MBM_RESOURCE,active=true},{menu=e.MBDVCMENU.MBM_LOG,active=true},{menu=e.MBDVCMENU.MSN_DROP,active=true},{menu=e.MBDVCMENU.MSN_DROP_BULLET,active=true},{menu=e.MBDVCMENU.MSN_DROP_WEAPON,active=true},{menu=e.MBDVCMENU.MSN_DROP_LOADOUT,active=true},{menu=e.MBDVCMENU.MSN_DROP_VEHICLE,active=true},{menu=e.MBDVCMENU.MSN_ATTACK,active=true},{menu=e.MBDVCMENU.MSN_ATTACK_ARTILLERY,active=true},{menu=e.MBDVCMENU.MSN_HELI,active=true},{menu=e.MBDVCMENU.MSN_HELI_RENDEZVOUS,active=true},{menu=e.MBDVCMENU.MSN_HELI_ATTACK,active=true},{menu=e.MBDVCMENU.MSN_HELI_DISMISS,active=true},{menu=e.MBDVCMENU.MSN_EMERGENCIE_N,active=true},{menu=e.MBDVCMENU.MSN_EMERGENCIE_F,active=true},{menu=e.MBDVCMENU.MSN_MISSIONLIST,active=true},{menu=e.MBDVCMENU.MSN_SIDEOPSLIST,active=true},{menu=e.MBDVCMENU.MSN_LOG,active=true},{menu=e.MBDVCMENU.MSN_LOCATION,active=true},{menu=e.MBDVCMENU.MSN_RETURNMB,active=true},{menu=e.MBDVCMENU.MBM_DB,active=true},{menu=e.MBDVCMENU.MBM_DB_ENCYCLOPEDIA,active=true},{menu=e.MBDVCMENU.MBM_DB_KEYITEM,active=true},{menu=e.MBDVCMENU.MBM_DB_CASSETTE,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_DESIGN,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_DESIGN_EMBLEM,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_DESIGN_BASE,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_AVATAR,active=true}}
end
function e.SetUpStoryAfterCleardPitchDark()
e._SetUpDvcMenu{{menu=e.MBDVCMENU.MBM,active=true},{menu=e.MBDVCMENU.MSN,active=true},{menu=e.MBDVCMENU.MBM_REWORD,active=true},{menu=e.MBDVCMENU.MBM_STAFF,active=true},{menu=e.MBDVCMENU.MBM_DEVELOP,active=true},{menu=e.MBDVCMENU.MBM_DEVELOP_WEAPON,active=true},{menu=e.MBDVCMENU.MBM_DEVELOP_ARMS,active=true},{menu=e.MBDVCMENU.MBM_COMBAT,active=true},{menu=e.MBDVCMENU.MBM_BASE,active=true},{menu=e.MBDVCMENU.MBM_BASE_SECURITY,active=true},{menu=e.MBDVCMENU.MBM_BASE_EXPANTION,active=true},{menu=e.MBDVCMENU.MBM_RESOURCE,active=true},{menu=e.MBDVCMENU.MBM_LOG,active=true},{menu=e.MBDVCMENU.MSN_DROP,active=true},{menu=e.MBDVCMENU.MSN_DROP_BULLET,active=true},{menu=e.MBDVCMENU.MSN_DROP_WEAPON,active=true},{menu=e.MBDVCMENU.MSN_DROP_LOADOUT,active=true},{menu=e.MBDVCMENU.MSN_DROP_VEHICLE,active=true},{menu=e.MBDVCMENU.MSN_ATTACK,active=true},{menu=e.MBDVCMENU.MSN_ATTACK_ARTILLERY,active=true},{menu=e.MBDVCMENU.MSN_ATTACK_SMOKE,active=true},{menu=e.MBDVCMENU.MSN_ATTACK_SLEEP,active=true},{menu=e.MBDVCMENU.MSN_ATTACK_CHAFF,active=true},{menu=e.MBDVCMENU.MSN_ATTACK_WEATHER,active=true},{menu=e.MBDVCMENU.MSN_ATTACK_WEATHER_SANDSTORM,active=true},{menu=e.MBDVCMENU.MSN_ATTACK_WEATHER_STORM,active=true},{menu=e.MBDVCMENU.MSN_ATTACK_WEATHER_CLEAR,active=true},{menu=e.MBDVCMENU.MSN_HELI,active=true},{menu=e.MBDVCMENU.MSN_HELI_RENDEZVOUS,active=true},{menu=e.MBDVCMENU.MSN_HELI_ATTACK,active=true},{menu=e.MBDVCMENU.MSN_HELI_DISMISS,active=true},{menu=e.MBDVCMENU.MSN_EMERGENCIE_N,active=true},{menu=e.MBDVCMENU.MSN_EMERGENCIE_F,active=true},{menu=e.MBDVCMENU.MSN_MISSIONLIST,active=true},{menu=e.MBDVCMENU.MSN_SIDEOPSLIST,active=true},{menu=e.MBDVCMENU.MSN_FOB,active=true},{menu=e.MBDVCMENU.MSN_FRIEND,active=true},{menu=e.MBDVCMENU.MSN_LOG,active=true},{menu=e.MBDVCMENU.MSN_LOCATION,active=true},{menu=e.MBDVCMENU.MSN_RETURNMB,active=true},{menu=e.MBDVCMENU.MBM_DB,active=true},{menu=e.MBDVCMENU.MBM_DB_ENCYCLOPEDIA,active=true},{menu=e.MBDVCMENU.MBM_DB_KEYITEM,active=true},{menu=e.MBDVCMENU.MBM_DB_CASSETTE,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_BUDDY,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_BUDDY_HORSE,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_BUDDY_DOG,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_BUDDY_QUIET,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_BUDDY_WALKER,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_BUDDY_BATTLE,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_DESIGN,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_DESIGN_EMBLEM,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_DESIGN_BASE,active=true},{menu=e.MBDVCMENU.MBM_CUSTOM_AVATAR,active=true}}
end
function e.StopChangeDayTerminalAnnounce()
mvars.trm_stopChangeDayTerminalAnnounce=true
end
function e.StartChangeDayTerminalAnnounce()
mvars.trm_stopChangeDayTerminalAnnounce=nil
end
function e.TerminalVoiceWeatherForecast(t)
  local n={[TppDefine.WEATHER.SUNNY]="VOICE_WEATHER_CLAER",[TppDefine.WEATHER.CLOUDY]=nil,[TppDefine.WEATHER.RAINY]=nil,[TppDefine.WEATHER.SANDSTORM]="VOICE_WEATHER_SANDSTORM",[TppDefine.WEATHER.FOGGY]=nil}
  local a={[TppDefine.WEATHER.SUNNY]="weather_sunny",[TppDefine.WEATHER.CLOUDY]="weather_cloudy",[TppDefine.WEATHER.RAINY]="weather_rainy",[TppDefine.WEATHER.SANDSTORM]="weather_sandstorm",[TppDefine.WEATHER.FOGGY]="weather_foggy"}
  local n=n[t]local t=a[t]if n then
    e.PlayTerminalVoice(n)
  end
  if t then
    TppUI.ShowAnnounceLog(t)
  end
end
function e.TerminalVoiceOnSunSet()
  if mvars.trm_stopChangeDayTerminalAnnounce then
    return
  end
  e.PlayTerminalVoice"VOICE_SUN_SET"TppUI.ShowAnnounceLog"sunset"
  TppTutorial.DispGuide_Comufrage()
end
function e.TerminalVoiceOnSunRise()
  if mvars.trm_stopChangeDayTerminalAnnounce then
    return
  end
  e.PlayTerminalVoice"VOICE_SUN_RISE"TppUI.ShowAnnounceLog"sunrise"
  TppTutorial.DispGuide_DayAndNight()
end
function e.TerminalVoiceOnSupportFireIncoming()
  e.PlayTerminalVoice"VOICE_SUPPORT_FIRE_INCOMING"
end
function e.SetBaseTelopName(e)
  mvars.trm_baseTelopCpName=e
end
function e.ClearBaseTelopName()
  mvars.trm_baseTelopCpName=nil
end
function e.GetLocationAndBaseTelop()
  return mvars.trm_currentIntelCpName or mvars.trm_baseTelopCpName
end
function e.ShowLocationAndBaseTelop()
  if TppUiCommand.IsStartTelopCast and TppUiCommand.IsStartTelopCast()then
    return
  end
  TppUiCommand.RegistInfoTypingText("location",1)
  local e=e.GetLocationAndBaseTelop()
  if e then
    TppUiCommand.RegistInfoTypingText("cpname",2,e)
  end
  TppUiCommand.ShowInfoTypingText()
end
function e.ShowLocationAndBaseTelopForStartFreePlay()
  TppUiCommand.RegistInfoTypingText("gametime",1)
  TppUiCommand.RegistInfoTypingText("location",2)
  local e=e.GetLocationAndBaseTelop()
  if e then
    TppUiCommand.RegistInfoTypingText("cpname",3,e)
  end
  TppUiCommand.ShowInfoTypingText()
end
function e.ShowLocationAndBaseTelopForContinue()
  if TppMission.IsFreeMission(vars.missionCode)then
    e.ShowLocationAndBaseTelopForStartFreePlay()
  else
    TppUiCommand.RegistInfoTypingText("episode",1)
    TppUiCommand.RegistInfoTypingText("mission",2)
    TppUiCommand.RegistInfoTypingText("gametime",3)
    TppUiCommand.RegistInfoTypingText("location",4)
    local e=e.GetLocationAndBaseTelop()
    if e then
      TppUiCommand.RegistInfoTypingText("cpname",5,e)
    end
    TppUiCommand.ShowInfoTypingText()
  end
end
function e.OnEnterCpIntelTrap(e)
  mvars.trm_currentIntelCpName=e
  TppUiCommand.ActivateSpySearchForCP{cpName=e}
  TppUiCommand.DeactivateSpySearchForField()
  TppFreeHeliRadio.OnEnterCpIntelTrap(e)
  if Player.OnEnterBase~=nil then
    Player.OnEnterBase()
  end
end
function e.OnExitCpIntelTrap(e)
  mvars.trm_currentIntelCpName=nil
  TppUiCommand.DeactivateSpySearchForCP()
  TppUiCommand.ActivateSpySearchForField()
  TppFreeHeliRadio.OnExitCpIntelTrap(e)
  TppRevenge.ClearLastRevengeMineBaseName()
  if Player.OnExitBase~=nil then
    Player.OnExitBase()
  end
end
function e.IsReleaseMedicalSection()
  if(gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON)and(TppStory.GetClearedMissionCount{10041,10044,10052,10054}>=1)then
    return true
  else
    return false
  end
end
e.SectionOpenCondition={Combat=function()
  if(gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON)and(TppStory.GetClearedMissionCount{10041,10044,10052,10054}>=2)then
    return true
  else
    return false
  end
end,BaseDev=function()
  if(gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE)and(TppStory.GetClearedMissionCount{10033,10036,10043}>=2)then
    return true
  else
    return false
  end
end,Spy=function()
  if(gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON)then
    return true
  else
    return false
  end
end,Medical=e.IsReleaseMedicalSection,Security=function()
  if e.IsCleardRetakeThePlatform()then
    return true
  else
    return false
  end
end,Hospital=function()
  if e.IsReleaseMedicalSection()then
    return TppMotherBaseManagement.IsBuiltMbMedicalClusterSpecialPlatform()
  else
    return false
  end
end,Prison=function()
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE then
    return true
  else
    return false
  end
end,Separation=function()
  if gvars.trm_isPushRewardSeparationPlatform and(not e.CheckPandemicEventFinish())then
    return true
  else
    return false
  end
end}
function e.IsReleaseSection(t)
  local e=e.SectionOpenCondition[t]
  if e then
    return e()
  end
end
function e.ReleaseMbSection()
  for n,t in ipairs(e.MOTHER_BASE_SECTION_LIST)do
    local e=e.IsReleaseSection(t)
    if e~=nil then
      TppMotherBaseManagement.OpenedSection{section=t,opened=e}
    end
  end
end
function e.OpenAllSection()
  for t,e in ipairs(e.MOTHER_BASE_SECTION_LIST)do
    TppMotherBaseManagement.OpenedSection{section=e,opened=true}
  end
end
function e.OnEstablishMissionClear()
  if(gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON)and(TppStory.GetClearedMissionCount{10041,10044,10052,10054}>=1)then
    local t=1
    e.ForceStartBuildPlatform("Medical",t)e.ForceStartBuildPlatform("Develop",t)
  end
  e.PushRewardOnMbSectionOpen()
  if e.IsBuiltAnimalPlatform()and(not gvars.trm_isPushRewardAnimalPlatform)then
    gvars.trm_isPushRewardAnimalPlatform=true
    TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_107",rewardType=TppReward.TYPE.COMMON}
  end
  if e.IsReleaseSection"Security"then
    if not gvars.trm_isPushRewardOpenFob then
      gvars.trm_isPushRewardOpenFob=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_109",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if e.IsConstructedFirstFob()then
    if not gvars.trm_isPushConstructedFirstFob then
      gvars.trm_isPushConstructedFirstFob=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_110",rewardType=TppReward.TYPE.COMMON}
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_111",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if TppStory.IsMissionCleard(10033)then
    if not gvars.trm_isPushRewardCanDevArm then
      gvars.trm_isPushRewardCanDevArm=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_300",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if e.IsOpenMBDvcArmsMenu()and(not gvars.trm_isPushRewardOpenMBDvcArmsMenu)then
    gvars.trm_isPushRewardOpenMBDvcArmsMenu=true
    TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_301",rewardType=TppReward.TYPE.COMMON}
    TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_302",rewardType=TppReward.TYPE.COMMON}
    TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_401",rewardType=TppReward.TYPE.COMMON}
  end
  local n=TppStory.GetCurrentStorySequence()
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA then
    if not gvars.trm_isPushRewardCanDevParasiteSuit then
      gvars.trm_isPushRewardCanDevParasiteSuit=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_307",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if vars.mbmMasterGunsmithSkill==1 then
    if not gvars.trm_isPushRewardOpenWeaponCustomize then
      gvars.trm_isPushRewardOpenWeaponCustomize=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_400",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if not gvars.trm_isPushRewardCanCustomVehicle then
    if e.HasVehicle()==true then
      gvars.trm_isPushRewardCanCustomVehicle=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_402",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION then
    TppBuddyService.SetObtainedBuddyType(BuddyType.WALKER_GEAR)
    TppBuddyService.SetSortieBuddyType(BuddyType.WALKER_GEAR)
    if not gvars.trm_isPushRewardCanDevDWalker then
      gvars.trm_isPushRewardCanDevDWalker=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_305",rewardType=TppReward.TYPE.COMMON}
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_405",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if TppStory.CanPlayDemoOrRadio"CompliteDevelopBattleGear"or TppStory.GetBattleGearDevelopLevel()==5 then
    if not gvars.trm_isPushRewardBattleGearDevelopComplete then
      gvars.trm_isPushRewardBattleGearDevelopComplete=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_115",rewardType=TppReward.TYPE.COMMON}
      TppMotherBaseManagement.SetDeployableBattleGear{deployable=true}
    end
  end
  if e.PandemicTutorialStoryCondition()then
    if not gvars.trm_isPushRewardSeparationPlatform then
      gvars.trm_isPushRewardSeparationPlatform=true
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_112",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
    if not gvars.trm_isPushRewardCanDevNuclear then
      gvars.trm_isPushRewardCanDevNuclear=true
      vars.mbmIsEnableNuclearDevelop=1
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_113",rewardType=TppReward.TYPE.COMMON}
    end
  end
  if TppQuest.IsCleard"mtbs_q99011"then
    if not gvars.trm_isPushRewardCanDevQuietEquip then
      TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="reward_304",rewardType=TppReward.TYPE.COMMON}
      gvars.trm_isPushRewardCanDevQuietEquip=true
    end
    TppEmblem.Add("front9",true,false)
  end
  local a={BuddyCommand.HORSE_SHIT,BuddyCommand.DOG_BARKING,BuddyCommand.QUIET_AIM_TARGET,BuddyCommand.QUIET_COMBAT_START,BuddyCommand.QUIET_SHOOT_THIS}
  local r={"reward_500","reward_501","reward_502","reward_503","reward_504"}
  for e,t in ipairs(a)do
    if TppBuddyService.IsEnableBuddyCommand(t)then
      local t=e-1
      if not gvars.trm_isPushRewardBuddyCommand[t]then
        gvars.trm_isPushRewardBuddyCommand[t]=true
        local e=r[e]TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId=e,rewardType=TppReward.TYPE.COMMON}
      end
    end
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY then
    TppMotherBaseManagement.EnableStaffInitLangKikongo()
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
    local t={t.DEPLOY_MISSION_ID_SEQ_1001,t.DEPLOY_MISSION_ID_SEQ_1002,t.DEPLOY_MISSION_ID_SEQ_1003,t.DEPLOY_MISSION_ID_SEQ_1004,t.DEPLOY_MISSION_ID_SEQ_1005,t.DEPLOY_MISSION_ID_SEQ_1006,t.DEPLOY_MISSION_ID_SEQ_1007}e.OpenDeployMission(t)
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY then
    local t={t.DEPLOY_MISSION_ID_SEQ_1008,t.DEPLOY_MISSION_ID_SEQ_1009,t.DEPLOY_MISSION_ID_SEQ_1010,t.DEPLOY_MISSION_ID_SEQ_1011}e.OpenDeployMission(t)
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_TAKE_OUT_THE_CONVOY then
    local t={t.DEPLOY_MISSION_ID_SEQ_1012}e.OpenDeployMission(t)
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_DEATH_FACTORY then
    local t={t.DEPLOY_MISSION_ID_SEQ_1013,t.DEPLOY_MISSION_ID_SEQ_1014}e.OpenDeployMission(t)
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_WHITE_MAMBA then
    if not gvars.trm_doneUpdatePandemicLimit then
      gvars.trm_doneUpdatePandemicLimit=true
      TppMotherBaseManagement.UpdatePandemicEventLimit()
    end
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
    local t={t.DEPLOY_MISSION_ID_SEQ_1015,t.DEPLOY_MISSION_ID_SEQ_1016,t.DEPLOY_MISSION_ID_SEQ_1017,t.DEPLOY_MISSION_ID_SEQ_1018,t.DEPLOY_MISSION_ID_SEQ_1019,t.DEPLOY_MISSION_ID_SEQ_1020}e.OpenDeployMission(t)
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
    TppServerManager.StartFobPickup()
  end
  if n>=TppDefine.STORY_SEQUENCE.CLEARD_THE_TRUTH then
    vars.isAvatarPlayerEnable=1
  end
  e.AddUniqueCharactor()
end
function e.AddUniqueVolunteerStaff(t)
  local n={{186},{209},{210,211},{212},{213},{214},{215},{216,217},{218},{187},{185},{188,189,190,191,192,193},{194,195,196,197,198,199}}
  local a={[10033]=1,[10036]=1,[10043]=1,[10080]=2,[10086]=3,[10082]=4,[10091]=5,[10195]=6,[10100]=7,[10110]=8,[10121]=9,[10070]=10,[10090]=11,[10151]=12,[10280]=13}
  local t=a[t]if t then
    local t=n[t]for n,t in ipairs(t)do
      e._AddUniqueVolunteerStaff(t)
    end
  end
end
function e._AddUniqueVolunteerStaff(t,n)
  if TppMotherBaseManagement.IsExistStaff{uniqueTypeId=t}then
    return
  end
  local e=false
  if n~=nil then
    e=true
  end
  local t=TppMotherBaseManagement.GenerateStaffParameter{staffType="Unique",uniqueTypeId=t}
  TppMotherBaseManagement.DirectAddStaff{staffId=t,section="Wait",isNew=true,specialContract=e}
  TppUiCommand.ShowBonusPopupStaff(t,n)
  return true
end
function e.ForceStartBuildPlatform(e,n)
  local t=TppMotherBaseManagement.GetClusterGrade{base="MotherBase",category=e}
  if t<n then
    local t=TppMotherBaseManagement.GetClusterBuildStatus{base="MotherBase",category=e}
    if t=="Completed"then
      TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category=e,grade=0,buildStatus="Building",timeMinute=0,isNew=true}
    end
  end
end
function e.OpenDeployMission(t)
  for t,e in ipairs(t)do
    TppMotherBaseManagement.SetSequentialMissionIdLimit{deployMissionId=e}
  end
end
e.RewardLangIdTable={Combat={"reward_105","reward_106"},BaseDev={"reward_100","reward_101"},Spy={"reward_102"},Medical={"reward_103"},Security={"reward_108"},Hospital={"reward_104"}}
function e.PushRewardOnMbSectionOpen()
  for n,a in ipairs(e.MOTHER_BASE_SECTION_LIST)do
    local t=e.RewardLangIdTable[a]
    local e=e.IsReleaseSection(a)
    if e~=nil and t then
      if e then
        if not gvars.trm_isPushRewardOpenSection[n]then
          gvars.trm_isPushRewardOpenSection[n]=true
          for t,e in ipairs(t)do
            TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId=e,rewardType=TppReward.TYPE.COMMON}
          end
        end
      end
    end
  end
end
function e.IsCleardRetakeThePlatform()
  return TppStory.IsMissionCleard(10115)
end
function e.IsFailedRetakeThePlatform()
  local e=TppStory.GetElapsedMissionCount(TppDefine.ELAPSED_MISSION_EVENT.FAILED_RETAKE_THE_PLATFORM)
  if e==TppDefine.ELAPSED_MISSION_COUNT.INIT then
    return false
  else
    return true
  end
end
function e.CanConstructFirstFob()
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_DEATH_FACTORY then
    if e.IsCleardRetakeThePlatform()then
      return true
    end
  end
  return false
end
function e.IsConstructedFirstFob()
  if TppMotherBaseManagement.IsBuiltFirstFob then
    return TppMotherBaseManagement.IsBuiltFirstFob()
  else
    return true
  end
end
function e.IsReleaseFunctionBattle()
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
    return true
  else
    return false
  end
end
function e.IsReleaseFunctionNuclearDevelop()
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
    return true
  else
    return false
  end
end
e.SectionFuncOpenCondition={
  Combat={DispatchSoldier=true,DispatchFobDefence=e.IsCleardRetakeThePlatform},
  Develop={Weapon=true,SupportHelicopter=e.IsOpenMBDvcArmsMenu,
    Quiet=function()
      return TppBuddyService.CanSortieBuddyType(BuddyType.QUIET)
    end,
    D_Dog=function()
      return TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
    end,
    D_Horse=e.IsOpenMBDvcArmsMenu,D_Walker=function()
      return TppBuddyService.CanSortieBuddyType(BuddyType.WALKER_GEAR)
    end,
    BattleGear=function()
      return TppBuddyService.CanSortieBuddyType(BuddyType.BATTLE_GEAR)
    end,
    SecurityDevice=e.IsConstructedFirstFob},
  BaseDev={Mining=true,Processing=true,Extention=true,Construct=e.IsCleardRetakeThePlatform,NuclearDevelop=e.IsReleaseFunctionNuclearDevelop},
  Support={Fulton=true,Supply=true,Battle=e.IsReleaseFunctionBattle,BattleArtillery=e.IsReleaseFunctionBattle,BattleSmoke=e.IsReleaseFunctionBattle,BattleSleepGas=e.IsReleaseFunctionBattle,BattleChaff=e.IsReleaseFunctionBattle,BattleWeather=e.IsReleaseFunctionBattle},
  Spy={Information=true,Scouting=true,SearchResource=true,WeatherInformation=true},
  Medical={Emergency=true,Treatment=true},Security={BaseDefence=true,MachineDefence=e.IsConstructedFirstFob,BaseBlockade=e.IsConstructedFirstFob,SecurityInfo=e.IsConstructedFirstFob}
}
function e.ReleaseFunctionOfMbSection()
  local a=TppMotherBaseManagement.OpenedSectionFunc
  for n,t in pairs(E)do
    for o,r in pairs(t)do
      local t
      if e.SectionFuncOpenCondition[n]then
        t=e.SectionFuncOpenCondition[n][o]end
      if(t==true)then
        a{sectionFuncId=r,opened=true}
      elseif t then
        if t(n)then
          a{sectionFuncId=r,opened=true}
        else
          a{sectionFuncId=r,opened=false}
        end
      end
    end
  end
end
function e.ReleaseFreePlay()
  TppUiCommand.ClearAllChangeLocationMenu()
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE then
    TppUiCommand.EnableChangeLocationMenu{locationId=10,missionId=30010}
  end
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_DESTROY_THE_FLOW_STATION then
    TppUiCommand.EnableChangeLocationMenu{locationId=20,missionId=30020}
  end
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE then
    TppUiCommand.EnableChangeLocationMenu{locationId=50,missionId=30050}
  end
  if e.IsBuiltAnimalPlatform()then
    TppUiCommand.EnableChangeLocationMenu{locationId=50,missionId=30150}
  end
  if gvars.trm_isPushRewardSeparationPlatform then
    TppUiCommand.EnableChangeLocationMenu{locationId=50,missionId=30250}
  end
end
function e.IsBuiltAnimalPlatform()
  local e=gvars.trm_animalRecoverHistorySize
  if((gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON)and(TppStory.GetClearedMissionCount{10041,10044,10052,10054}>=3))and(e>5)then
    return true
  else
    return false
  end
end
function e.InitNuclearAbolitionCount()
  if not gvars.f30050_isInitNuclearAbolitionCount then
    if TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARD_OKB_ZERO then
      local e=TppServerManager.GetNuclearAbolitionCount()
      if e>=0 then
        gvars.f30050_NuclearAbolitionCount=e
        gvars.f30050_isInitNuclearAbolitionCount=true
      end
    end
  end
end
function e.RemoveStaffsAfterS10240()
  if TppStory.IsMissionCleard(10240)then
    TppMotherBaseManagement.RemoveStaffsS10240()
  end
end
function e.PickUpBluePrint(a,n)
  local t=nil
  if n then
    t=n
  else
    t=mvars.trm_bluePrintLocatorIdTable[a]
  end
  if not t then
    return
  end
  e.AddTempDataBase(t)
  local e=e.BLUE_PRINT_LANG_ID[t]
  TppUI.ShowAnnounceLog("get_blueprint",e)
end
function e.InitializeBluePrintLocatorIdTable()
  mvars.trm_bluePrintLocatorIdTable={}
  for t,e in pairs(e.BLUE_PRINT_LOCATOR_TABLE)do
    local t=TppCollection.GetUniqueIdByLocatorName(t)
    mvars.trm_bluePrintLocatorIdTable[t]=e
  end
end
function e.GetBluePrintKeyItemId(e)
  return mvars.trm_bluePrintLocatorIdTable[e]
  end
function e.PickUpEmblem(e)
  local e=mvars.trm_EmblemLocatorIdTable[e]
  if not e then
    return
  end
  TppEmblem.Add(e,false,true)
end
function e.EnableTerminalVoice(e)
  mvars.trm_voiceDisabled=not e
end
function e.PlayTerminalVoice(t,e,n)
  if mvars.trm_voiceDisabled and e~=false then
    return
  end
  TppUiCommand.RequestMbSoundControllerVoice(t,e,n)
end
function e.OnFultonFailedEnd(e,t,a,n)
  mvars.trm_fultonFaileEndInfo=mvars.trm_fultonFaileEndInfo or{}
  mvars.trm_fultonFaileEndInfo[e]={e,t,a,n}
end
function e._OnFultonFailedEnd(t,t,t,t,e)
  if Tpp.IsLocalPlayer(e)then
    TppUI.ShowAnnounceLog"extractionFailed"
  end
end
function e.HasVehicle()
  local e=TppMotherBaseManagement.GetTempResourceBufferVehicleIncrementCount()
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="4wdEast"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="4wdWest"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="TruckEast"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="TruckWest"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="ArmoredVehicleEast"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="ArmoredVehicleWest"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="WheeledArmoredVehicleWest"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="TankEast"}
  if e>0 then
    return true
  end
  local e=TppMotherBaseManagement.GetResourceUsableCount{resource="TankWest"}
  if e>0 then
    return true
  end
  return false
end
function e._SetUpDvcMenu(t)
  if not Tpp.IsTypeTable(t)then
    return
  end
  TppUiCommand.InitAllMbTopMenuItemVisible(false)
  TppUiCommand.InitAllMbTopMenuItemActive(true)
  e.EnableDvcMenuByList(t)
end
function e.EnableDvcMenuByList(e)
  for t=1,table.getn(e)do
    if e[t]==nil then
      return
    else
      TppUiCommand.SetMbTopMenuItemVisible(e[t].menu,true)
      if e[t].active~=nil then
        TppUiCommand.SetMbTopMenuItemActive(e[t].menu,e[t].active)
      end
    end
  end
end
function e.SetUpDvcMenuAll()
  TppUiCommand.InitAllMbTopMenuItemVisible(true)
  TppUiCommand.InitAllMbTopMenuItemActive(true)
end
function e.SetActiveTerminalMenu(t)
  if not Tpp.IsTypeTable(t)then
    return
  end
  if t[1]==e.MBDVCMENU.ALL then
    TppUiCommand.InitAllMbTopMenuItemActive(true)
  else
    TppUiCommand.InitAllMbTopMenuItemActive(false)
    for e=1,table.getn(t)do
      if t[e]==nil then
        return
      else
        TppUiCommand.SetMbTopMenuItemActive(t[e],true)
      end
    end
  end
end
return e
