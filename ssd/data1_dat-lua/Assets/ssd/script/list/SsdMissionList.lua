-- DOBUILD: 1
-- SsdMissionList.lua
local this={}
local missionTypes={STORY=1,FLAG=2,DEF=3,FREE=4,COOP=5,EVENT=6,NORMAL=6,INIT=7,TITLE=8,MATCHING=9,EXTRA=10,SYSTEM=10,DEBUG=11}
this.LOCAL_MISSION_LIST={}this.MISSION_LIST={}
this.MISSION_ENUM={}
this.MISSION_LIST_FOR_LOCATION={}
this.MISSION_LIST_FOR_IGNORE_MISSION_LIST_UI={}
this.FLAG_MISSION_LIST={}
this.BASE_DEFENSE_LIST={}
this.LOCATION_BY_MISSION_CODE={}
this.NO_ORDER_BOX_MISSION_LIST={}
this.NO_ORDER_BOX_MISSION_ENUM={}
local locationNames={"INIT","SSD_AFGH","MAFR","SSD_OMBS","SBRI","SPFC","SSAV","AFTR","DEBUG","SSD_AFGH2"}--RETAILPATCH: 1.0.9.0 OMBS to SSD_OMBS
local locationEnums=TppDefine.Enum(locationNames)
local locationPackTable={}
locationPackTable[TppDefine.LOCATION_ID.INIT]={"/Assets/ssd/pack/location/init/init.fpk"}
locationPackTable[TppDefine.LOCATION_ID.AFGH]={"/Assets/tpp/pack/location/afgh/afgh.fpk"}
locationPackTable[TppDefine.LOCATION_ID.MAFR]={"/Assets/ssd/pack/location/mafr/mafr.fpk"}
locationPackTable[TppDefine.LOCATION_ID.AFTR]={"/Assets/ssd/pack/location/afgh/aftr.fpk"}
locationPackTable[TppDefine.LOCATION_ID.SSD_AFGH]={"/Assets/ssd/pack/location/afgh/afgh.fpk"}
locationPackTable[TppDefine.LOCATION_ID.SSD_OMBS]={"/Assets/ssd/pack/location/ombs/ombs.fpk"}
locationPackTable[TppDefine.LOCATION_ID.SSD_AFGH2]={"/Assets/ssd/pack/location/afgh2/afgh2.fpk"}
locationPackTable[TppDefine.LOCATION_ID.SBRI]={"/Assets/ssd/pack/location/sbri/sbri.fpk"}
locationPackTable[TppDefine.LOCATION_ID.SPFC]={"/Assets/ssd/pack/location/spfc/spfc.fpk"}
locationPackTable[TppDefine.LOCATION_ID.SSAV]={"/Assets/ssd/pack/location/ssav/ssav.fpk"}
local missionSmallPackTable={
  [0]={
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/135/afgh_path_135_147.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/135/afgh_path_135_148.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/135/afgh_path_135_149.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/135/afgh_path_135_150.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/135/afgh_path_135_151.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/136/afgh_path_136_147.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/136/afgh_path_136_148.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/136/afgh_path_136_149.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/136/afgh_path_136_150.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/136/afgh_path_136_151.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/137/afgh_path_137_147.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/137/afgh_path_137_148.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/137/afgh_path_137_149.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/137/afgh_path_137_150.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/137/afgh_path_137_151.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/138/afgh_path_138_147.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/138/afgh_path_138_148.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/138/afgh_path_138_149.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/138/afgh_path_138_150.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/138/afgh_path_138_151.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/139/afgh_path_139_147.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/139/afgh_path_139_148.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/139/afgh_path_139_149.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/139/afgh_path_139_150.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/139/afgh_path_139_151.fpk"},
  [1]={
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/135/afgh_path_135_139.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/135/afgh_path_135_140.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/135/afgh_path_135_141.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/135/afgh_path_135_142.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/135/afgh_path_135_143.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/136/afgh_path_136_139.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/136/afgh_path_136_140.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/136/afgh_path_136_141.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/136/afgh_path_136_142.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/136/afgh_path_136_143.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/137/afgh_path_137_139.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/137/afgh_path_137_140.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/137/afgh_path_137_141.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/137/afgh_path_137_142.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/137/afgh_path_137_143.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/138/afgh_path_138_139.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/138/afgh_path_138_140.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/138/afgh_path_138_141.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/138/afgh_path_138_142.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/138/afgh_path_138_143.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/139/afgh_path_139_139.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/139/afgh_path_139_140.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/139/afgh_path_139_141.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/139/afgh_path_139_142.fpk",
    "/Assets/ssd/pack/location/afgh/pack_extraSmall/139/afgh_path_139_143.fpk"},
  [2]={
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/141/mafr_path_141_118.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/141/mafr_path_141_119.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/141/mafr_path_141_120.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/141/mafr_path_141_121.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/141/mafr_path_141_122.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/142/mafr_path_142_118.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/142/mafr_path_142_119.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/142/mafr_path_142_122.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/143/mafr_path_143_118.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/143/mafr_path_143_119.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/143/mafr_path_143_122.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/144/mafr_path_144_118.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/144/mafr_path_144_119.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/144/mafr_path_144_120.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/144/mafr_path_144_121.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/144/mafr_path_144_122.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/145/mafr_path_145_118.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/145/mafr_path_145_119.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/145/mafr_path_145_120.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/145/mafr_path_145_121.fpk",
    "/Assets/ssd/pack/location/mafr/pack_extraSmall/145/mafr_path_145_122.fpk"}}
this.MISSION_DEFINE_LIST={
  {type=missionTypes.FREE,name="f30010",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCommonMissionPack(s,"free","f30010")
      TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.SSD_AFGH_SPAWN_POINT)
      TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.SSD_PLAYER_EMOTION)
      TppPackList.AddMissionPack"/Assets/ssd/pack/collectible/rewardCbox/rewardCbox.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/ui/ssd_ui_base_defense.fpk"
    end},
  {type=missionTypes.STORY,name="s10010",location=locationEnums.SSD_OMBS,
    pack=function(s)
      this._AddCommonMissionPack(s,"story","s10010")
      TppPackList.AddAvatarEditPack()
    end},
  {type=missionTypes.FLAG,name="k40040",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40050",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40060",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40070",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40010",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40025",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40015",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40020",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40030",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40035",location=locationEnums.SSD_AFGH},
  {type=missionTypes.STORY,name="s10020",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40075",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40077",location=locationEnums.SSD_AFGH},
  {type=missionTypes.COOP,name="c20010",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_script_c01.fpk"
    end},
  {type=missionTypes.COOP,name="c20020",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_digger_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_script_c01.fpk"
    end},
  {type=missionTypes.COOP,name="c20030",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_digger_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/field/afgh_field_script_c01.fpk"
    end},
  {type=missionTypes.FLAG,name="k40080",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40090",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40130",location=locationEnums.SSD_AFGH},
  {type=missionTypes.STORY,name="s10030",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40145",location=locationEnums.SSD_AFGH},
  {type=missionTypes.COOP,name="c20110",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_script_c01.fpk"
    end},
  {type=missionTypes.COOP,name="c20120",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_digger_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_script_c01.fpk"
    end},
  {type=missionTypes.COOP,name="c20130",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_digger_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_script_c01.fpk"
    end},
  {type=missionTypes.FLAG,name="k40140",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40150",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40155",location=locationEnums.SSD_AFGH},
  {type=missionTypes.STORY,name="s10035",location=locationEnums.SSD_AFGH,pack=function(s)--RETAILPATCH: 1.0.5.0 added packs
    this._AddCommonMissionPack(s,"story","s10035")
    TppPackList.AddMissionPack"/Assets/ssd/pack/mission/story/s10035/s10035_sound.fpk"
    TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/animal/anml_afgh_01_00_asset_ground.fpk"--RETAILPATCH: 1.0.8.0
  end},--<
  {type=missionTypes.FREE,name="f30020",location=locationEnums.MAFR,
    pack=function(s)
      this._AddCommonMissionPack(s,"free","f30020")
      TppPackList.AddMissionPack(TppDefine.MISSION_COMMON_PACK.SSD_PLAYER_EMOTION)
      TppPackList.AddMissionPack"/Assets/ssd/pack/collectible/rewardCbox/rewardCbox.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/ui/ssd_ui_base_defense.fpk"
    end},
  {type=missionTypes.FLAG,name="k40160",location=locationEnums.MAFR},
  {type=missionTypes.FLAG,name="k40180",location=locationEnums.MAFR},
  {type=missionTypes.FLAG,name="k40170",location=locationEnums.MAFR},
  {type=missionTypes.STORY,name="s10040",location=locationEnums.MAFR},
  {type=missionTypes.COOP,name="c20210",location=locationEnums.MAFR,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_script_c01.fpk"
    end},
  {type=missionTypes.COOP,name="c20220",location=locationEnums.MAFR,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_digger_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_script_c01.fpk"
    end},
  {type=missionTypes.COOP,name="c20230",location=locationEnums.MAFR,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_digger_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/mafr/pack_mission/large/diamond/mafr_diamond_script_c01.fpk"
    end},
  {type=missionTypes.FLAG,name="k40220",location=locationEnums.MAFR},
  {type=missionTypes.FLAG,name="k40230",location=locationEnums.MAFR},
  {type=missionTypes.STORY,name="s10050",location=locationEnums.SSD_AFGH,pack=function(s)
    --RETAILPATCH: 1.0.8.0>
    this._AddCommonMissionPack(s,"story","s10050")
    TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/animal/anml_afgh_01_00_asset_ground.fpk"
    --<
  end},
  {type=missionTypes.FLAG,name="k40250",location=locationEnums.MAFR},
  {type=missionTypes.FLAG,name="k40260",location=locationEnums.SSD_AFGH},
  {type=missionTypes.FLAG,name="k40270",location=locationEnums.SSD_AFGH},
  {type=missionTypes.STORY,name="s10060",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCommonMissionPack(s,"story","s10060")
      TppPackList.AddMissionPack"/Assets/ssd/pack/ui/ssd_ui_main_staff_defeat_end.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/ui/ssd_ui_staff_roll_defeat_end.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/ui/ssd_ui_staff_roll_return_end.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/ui/ssd_init_mission_ui.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/animal/anml_afgh_01_00_asset_ground.fpk"--RETAILPATCH: 1.0.8.0
    end},
  {type=missionTypes.FLAG,name="k40310",location=locationEnums.MAFR},
  {type=missionTypes.FLAG,name="k40320",location=locationEnums.MAFR},
  {type=missionTypes.COOP,name="c20610",location=locationEnums.SPFC,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_path.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_script_c01.fpk"
    end},
  {type=missionTypes.COOP,name="c20620",location=locationEnums.SPFC,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_path.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_digger_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_script_c01.fpk"
    end},
  {type=missionTypes.COOP,name="c20630",location=locationEnums.SPFC,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_path.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_digger_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/spfc/pack_mission/large/pfCamp/spfc_pfCamp_script_c01.fpk"
    end},
  {type=missionTypes.COOP,name="c20710",location=locationEnums.SSAV,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_path.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_script_c01.fpk"
    end},
  {type=missionTypes.COOP,name="c20720",location=locationEnums.SSAV,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_path.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_digger_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_script_c01.fpk"
    end},
  {type=missionTypes.COOP,name="c20730",location=locationEnums.SSAV,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_path.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_digger_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_digger_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_spawn_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_gimmick_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_stealthArea_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_stealthArea_c02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_walkerGear_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_script_c01.fpk"
    end},
  --RETAILPATCH: 1.0.5.0>
  {type=missionTypes.COOP,name="c20105",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_script_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_digger_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_digger_r03.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_spawn_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_walkerGear_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_gimmick_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_gimmick_r02.fpk"
    end},
  {type=missionTypes.COOP,name="c20115",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_script_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_digger_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_digger_r02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_spawn_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_walkerGear_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_gimmick_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_gimmick_r03.fpk"
    end},
  {type=missionTypes.COOP,name="c20125",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_script_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_digger_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_digger_r02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_spawn_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_walkerGear_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_gimmick_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/afgh/pack_mission/large/village/afgh_village_gimmick_r03.fpk"
    end},
  {type=missionTypes.COOP,name="c20725",location=locationEnums.SSAV,
    pack=function(s)
      this._AddCoopCommonMissionPack(s)
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_path.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_plant_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_range_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_script_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_wormhole_c01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_digger_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_digger_r02.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_spawn_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_walkerGear_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_gimmick_r01.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/location/ssav/pack_mission/large/savannah/ssav_savannah_gimmick_r02.fpk"
    end},
  --<
  {type=missionTypes.INIT,name="s00001",location=locationEnums.INIT,pack={
    "/Assets/ssd/pack/ui/ssd_init_mission_ui.fpk",
    "/Assets/ssd/pack/ui/ssd_option_menu_ui.fpk",
    "/Assets/ssd/pack/mission/init/init.fpk"}},
  {type=missionTypes.TITLE,name="s00005",location=locationEnums.INIT,
    pack=function(s)
      local e=not TppPackList.IsMissionPackLabel"StagingArea"TppPackList.AddTitleMissionPack(s,e)
      this._AddCommonMissionPack(21010,"coop","c21010")
    end},
  {type=missionTypes.MATCHING,name="c21000",location=locationEnums.INIT,
    pack=function(s)
      TppPackList.AddTitleMissionPack(s,false)
      this._AddCommonMissionPack(s,"coop","c21010")
    end},
  {type=missionTypes.MATCHING,name="c21005",location=locationEnums.SSD_AFGH},
  {type=missionTypes.MATCHING,name="c21010",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCommonMissionPack(s,"coop","c21010")
    end},
  {type=missionTypes.MATCHING,name="c21020",location=locationEnums.MAFR,
    pack=function(s)
      this._AddCommonMissionPack(s,"coop","c21010")
    end},
  {type=missionTypes.MATCHING,name="c21019",location=locationEnums.SPFC,
    pack=function(s)
      this._AddCommonMissionPack(s,"coop","c21010")
    end},
  {type=missionTypes.MATCHING,name="c21025",location=locationEnums.SSAV,
    pack=function(s)
      this._AddCommonMissionPack(s,"coop","c21010")
    end},
  {type=missionTypes.EXTRA,name="e01010",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCommonMissionPack(s,"extra","e01010")
      TppPackList.AddAvatarEditPack()
    end},
  {type=missionTypes.EXTRA,name="e01020",location=locationEnums.MAFR,
    pack=function(s)
      this._AddCommonMissionPack(s,"extra","e01010")
      TppPackList.AddAvatarEditPack()
    end},
  {type=missionTypes.DEBUG,name="s12010",location=locationEnums.SSD_AFGH},
  {type=missionTypes.DEBUG,name="s12020",location=locationEnums.SSD_AFGH},
  {type=missionTypes.DEBUG,name="s12030",location=locationEnums.SSD_AFGH},
  {type=missionTypes.DEBUG,name="f32010",location=locationEnums.SSD_AFGH2,
    pack=function(s)
      this._AddCommonMissionPack(s,"free","f32010")
    end},
  {type=missionTypes.DEBUG,name="e60010",location=locationEnums.SSD_AFGH},
  {type=missionTypes.DEBUG,name="e60011",location=locationEnums.SSD_AFGH},
  {type=missionTypes.DEBUG,name="e60012",location=locationEnums.SSD_AFGH},
  {type=missionTypes.DEBUG,name="e60013",location=locationEnums.SSD_AFGH},
  {type=missionTypes.DEBUG,name="e60014",location=locationEnums.SSD_AFGH},
  {type=missionTypes.DEBUG,name="e65010",location=locationEnums.SSD_AFGH},
  {type=missionTypes.DEBUG,name="e65020",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCommonMissionPack(s,"extra","e65020")
    end},
  {type=missionTypes.DEBUG,name="e65030",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCommonMissionPack(s,"extra","e65030")
    end},
  {type=missionTypes.DEBUG,name="e65040",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCommonMissionPack(s,"extra","e65040")
    end},
  {type=missionTypes.DEBUG,name="e65050",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCommonMissionPack(s,"extra","e65050")
    end},
  {type=missionTypes.DEBUG,name="e65060",location=locationEnums.SSD_AFGH,
    pack=function(s)
      this._AddCommonMissionPack(s,"extra","e65060")
    end},
  {type=missionTypes.DEBUG,name="e62010",location=locationEnums.INIT,
    pack=function(a)
      TppPackList.AddMissionPack"/Assets/ssd/pack/ui/ssd_ui_main_staff_defeat_end.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/ui/ssd_ui_staff_roll_defeat_end.fpk"
      TppPackList.AddMissionPack"/Assets/ssd/pack/ui/ssd_ui_staff_roll_return_end.fpk"
    end}}
this.ZOMBIE_PACK_LIST={
  afgh={
    {loadCondition=function(s,a)
      return a==20010
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    {loadCondition=function(s,a)
      return a==20020
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    {loadCondition=function(s,a)
      return a==20030
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_BOSS_3,"Gluttony","GluttonyNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_BOSS_1,"Aerial","AerialNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_gluttony.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_aerial.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    {loadCondition=function(s,a)
      return a==29010
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    {loadCondition=function(s,a)
      return a==20110
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    {loadCondition=function(s,a)
      return a==20120
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    {loadCondition=function(s,a)
      return a==20130
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_BOSS_3,"Gluttony","GluttonyNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_BOSS_1,"Aerial","AerialNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_gluttony.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_aerial.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    --RETAILPATCH: 1.0.5.0>
    {loadCondition=function(s,a)
      return a==20105
    end,
    npcs={{
      TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_BOSS_1,"Aerial","AerialNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_aerial.fpk"}},
    {loadCondition=function(s,a)
      return a==20115
    end,
    npcs={{
      TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_BOSS_1,"Aerial","AerialNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_aerial.fpk"}},
    {loadCondition=function(s,a)
      return a==20125
    end,
    npcs={{
      TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
    {TppGameObject.GAME_OBJECT_TYPE_BOSS_1,"Aerial","AerialNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_aerial.fpk"}},
    --<
    {loadCondition=function(s,a)
      return TppMission.IsMultiPlayMission(a)
    end},
    {loadCondition=function(a,s)
      if TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST<=a then
        return true
      end
      return false
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider.fpk"}},
    {loadCondition=function(s,a)
      return a==10060
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider.fpk"}},
    {loadCondition=function(s,a)
      return a==10050
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieSeth","ZombieSethNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider.fpk"}},
    {loadCondition=function(a,s)
      if TppDefine.STORY_SEQUENCE.BEFORE_RETURN_TO_AFGH<=a then
        return true
      end
      return false
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_KAIJU,"Kaiju","KaijuNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_kaiju.fpk"}},
    {loadCondition=function(s,a)
      return a==10035
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera.fpk"}},
    {loadCondition=function(a,s)
      if TppDefine.STORY_SEQUENCE.BEFORE_k40040<=a then
        return true
      end
      return false
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_KAIJU,"Kaiju","KaijuNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_kaiju.fpk"}},
    {loadCondition=function(a,a)
      return true
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie.fpk"}}},
  mafr={
    {loadCondition=function(s,a)
      return a==20210
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    {loadCondition=function(s,a)
      return a==20220
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    {loadCondition=function(s,a)
      return a==20230
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_BOSS_3,"Gluttony","GluttonyNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_BOSS_1,"Aerial","AerialNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_gluttony.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_aerial.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    {loadCondition=function(s,a)
      return TppMission.IsMultiPlayMission(a)
    end},
    {loadCondition=function(a,a)
      return true
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic.fpk"}}},
  ombs={},
  spfc={
    {loadCondition=function(s,a)
      return a==20610
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    {loadCondition=function(s,a)
      return a==20620
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    {loadCondition=function(s,a)
      return a==20630
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_BOSS_3,"Gluttony","GluttonyNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_BOSS_1,"Aerial","AerialNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_gluttony.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_aerial.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}}},
  ssav={
    {loadCondition=function(s,a)
      return a==20710
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    {loadCondition=function(s,a)
      return a==20720
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    {loadCondition=function(s,a)
      return a==20730
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_BOSS_3,"Gluttony","GluttonyNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_BOSS_1,"Aerial","AerialNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_DESTROYER,"Destroyer","RayNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_gluttony.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_aerial.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_ray.fpk"}},
    --RETAILPATCH: 1.0.5.0>
    {loadCondition=function(s,a)
      return a==20725
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,"ZombieBom","ZombieBomNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,"ZombieDash","ZombieDashNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,"ZombieShell","ZombieShellNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,"ZombieArmor","ZombieArmorNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_PACK,"ZombiePack","ZombiePackNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_1,"SirenCamera","SirenCameraNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_2,"Spider","SpiderNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_INSECT_3,"Mimic","MimicNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_BOSS_3,"Gluttony","GluttonyNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_BOSS_1,"Aerial","AerialNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie_64c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiebom_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiedash_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieshell_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiearmor_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombiepack_4c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_camera_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_spider_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_mimic_8c.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_gluttony.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_aerial.fpk"}}},
  --<
  aftr={
    {loadCondition=function(a,a)
      return true
    end,
    npcs={
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,"Zombie","ZombieNormal"},
      {TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_EVENT,"ZombieXOF","ZombieXOFNormal"}},
    pack={
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombie.fpk",
      "/Assets/ssd/pack/npc/gameobject/npc_gameobject_zombieXOF.fpk"}}}}
local missionPackTable={}
local npcsMissionPackTable={}
function this._MakeFlagAndDefMissionPackPath(a,e)
  if e==missionTypes.FLAG then
    local a="/Assets/ssd/pack/mission/flag/"..(a..("/"..(a..".fpk")))
    return a
  else
    return
  end
end
function this._MakeMissionPackPathInfo(p,e)
  if not p then
    return
  end
  if e==missionTypes.FLAG or e==missionTypes.DEF then
    return this._MakeFlagAndDefMissionPackPath(p,e)
  elseif e==missionTypes.EVENT then
    return
  end
  local c
  if e==missionTypes.STORY then
    c="story"elseif e==missionTypes.FREE then
    c="free"elseif e==missionTypes.MATCHING then
    c="coop"elseif e==missionTypes.COOP then
    c="coop"elseif e==missionTypes.EXTRA then
    c="extra"elseif e==missionTypes.DEBUG then
    c="debug"else
    return
  end
  local a=function(s)
    this._AddCommonMissionPack(s,c,p)end
  return a
end
for p,c in pairs(locationEnums)do
  local s=true
  if c==locationEnums.DEBUG then
    s=false
  end
  if Tpp.IsMaster()and c>=locationEnums.DEBUG then
    s=false
  end
  if s then
    this.MISSION_LIST_FOR_LOCATION[p]={}
  end
end
for p,c in ipairs(this.MISSION_DEFINE_LIST)do
  local _=c.type
  if(not Tpp.IsMaster())or(Tpp.IsMaster()and _~=missionTypes.DEBUG)then
    local p=string.sub(c.name,-5)
    local d=tonumber(p)
    local o=c.location
    local t=c.pack
    local k=c.npcs
    if not t then
      t=this._MakeMissionPackPathInfo(c.name,_)
    end
    missionPackTable[d]=t
    if k~=nil then
      npcsMissionPackTable[d]=k
    end
    if _<=missionTypes.NORMAL then
      table.insert(this.MISSION_LIST,p)
      table.insert(this.LOCAL_MISSION_LIST,p)
    end
    local i=(_==missionTypes.FLAG)
    local n=(_==missionTypes.DEF)
    if i or n then
      local p
      if o==locationEnums.SSD_AFGH then
        p="afgh"
      elseif o==locationEnums.MAFR then
        p="mafr"
      elseif o==locationEnums.SBRI then
        p="sbri"
      end
      if p then
        local s={}s.name=c.name
        s.pack=t
        s.location=p
        if i then
          table.insert(this.FLAG_MISSION_LIST,s)
        else
          table.insert(this.BASE_DEFENSE_LIST,s)
        end
      end
    end
    local s=(_==missionTypes.EVENT)
    if not s then
      local s=locationNames[o+1]
      table.insert(this.MISSION_LIST_FOR_LOCATION[s],p)
    end
    if ignoreMissionList then
      this.MISSION_LIST_FOR_IGNORE_MISSION_LIST_UI[p]=true
    end
    if not i and not n then
      if not c.useOrderBox then
        table.insert(this.NO_ORDER_BOX_MISSION_LIST,p)
      end
    end
    if not s then
      local s
      if o==locationEnums.SSD_AFGH then
        s="afgh"
        --RETAILPATCH: 1.0.9.0>
      elseif p==locationEnums.SSD_OMBS then
        s="ombs"
        --<
      else
        s=string.lower(locationNames[o+1])
      end
      this.LOCATION_BY_MISSION_CODE[p]=s
    end
  end
end
this.MISSION_DEFINE_LIST={}
this.MISSION_ENUM=TppDefine.Enum(this.MISSION_LIST)
if Mission.RegisterMissionCodeList then
  Mission.RegisterMissionCodeList{codeList=this.MISSION_LIST}
end
this.NO_ORDER_BOX_MISSION_ENUM=TppDefine.Enum(this.NO_ORDER_BOX_MISSION_LIST)
if Mission.SetCoopLobbyEnableStorySequence then
  Mission.SetCoopLobbyEnableStorySequence(TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL)
end
if Mission.SetStorySequenceCoopTutorialEnd then
  Mission.SetStorySequenceCoopTutorialEnd(TppDefine.STORY_SEQUENCE.CLEARED_k40070)
end
if Mission.RegisterShowC20010SequenceIndex then
  Mission.RegisterShowC20010SequenceIndex(TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL)
end
if Mission.RegisterCoopDlcMissionOpenSequenceIndex then
  Mission.RegisterCoopDlcMissionOpenSequenceIndex(TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST)
end
function this.GetLocationPackagePath(locationId)
  InfCore.LogFlow("TppMissionList.GetLocationPackagePath "..locationId)--tex
  local packPath=locationPackTable[locationId]
  if packPath then
  end
  InfCore.PrintInspect(packPath,"locationPackPaths")--tex DEBUG
  return packPath
end
function this.GetMissionPackagePath(missionCode)
  InfCore.LogFlow("TppMissionList.GetMissionPackagePath "..missionCode)--tex
  TppCrew.StartMission(missionCode)
  local packPaths
  if missionPackTable[missionCode]==nil then
    packPaths=TppPackList.MakeMissionPackList(missionCode,TppPackList.MakeDefaultMissionPackList)
  elseif Tpp.IsTypeFunc(missionPackTable[missionCode])then
    packPaths=TppPackList.MakeMissionPackList(missionCode,missionPackTable[missionCode])
  elseif Tpp.IsTypeTable(missionPackTable[missionCode])then
    packPaths=missionPackTable[missionCode]
  end
  this.ResetAssinedDefaultInfosFromGameObjectType()
  this.AssignDefaultInfosToGameObjectTypeForZombie()
  this.AssignDefaultInfosToGameObjectTypeForAnimal()
  local zombiePackPaths=this.GetZombiePackagePath(missionCode)
  if zombiePackPaths then
    for i,packPath in ipairs(zombiePackPaths)do
      table.insert(packPaths,packPath)
    end
  end
  local npcPackInfo=npcsMissionPackTable[missionCode]
  if npcPackInfo~=nil then
    this.AssignNpcInfosToGameObjectType(npcPackInfo)
    local npcPackPaths=this.GetNpcPackagePathList(npcPackInfo)
    if npcPackPaths then
      for i,packPath in ipairs(npcPackPaths)do
        table.insert(packPaths,packPath)
      end
    end
  else
    this.AssignDefaultInfosToGameObjectType()
  end
  InfMain.AddMissionPacks(missionCode,packPaths)--tex
  InfCore.PrintInspect(packPaths,"missionPackPaths")--tex DEBUG
  return packPaths
end
function this.GetZombiePackagePath(missionCode)
  local locationName=TppLocation.GetLocationName()
  if not locationName then
    return
  end
  local s=this.ZOMBIE_PACK_LIST[locationName]
  if not s then
    return
  end
  local c={}
  local o=TppStory.GetCurrentStorySequence()
  for s,e in ipairs(s)do
    if e.loadCondition and e.loadCondition(o,missionCode)then
      local s=e.pack
      if Tpp.IsTypeString(s)then
        s={s}
      end
      if Tpp.IsTypeTable(s)then
        for s,a in ipairs(s)do
          table.insert(c,a)
        end
      end
      local s=e.npcs
      if s~=nil then
        this.AssignNpcInfosToGameObjectType(s)
        local a=this.GetNpcPackagePathList(s)
        if a then
          for s,a in ipairs(a)do
            table.insert(c,a)
          end
        end
      end
      break
    end
  end
  return c
end
function this.AssignDefaultInfosToGameObjectType()
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_INSECT_1,npcType="SirenCamera",partsType="SirenCameraNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_INSECT_2,npcType="Spider",partsType="SpiderNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_INSECT_3,npcType="Mimic",partsType="MimicNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_BOSS_1,npcType="Aerial",partsType="AerialNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_BOSS_3,npcType="Gluttony",partsType="GluttonyNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_KAIJU,npcType="Kaiju",partsType="KaijuNormal"}
end
function this.ResetAssinedDefaultInfosFromGameObjectType()
  SsdNpc.ResetAssignedInfosFromGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_INSECT_1}
  SsdNpc.ResetAssignedInfosFromGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_INSECT_2}
  SsdNpc.ResetAssignedInfosFromGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_INSECT_3}
  SsdNpc.ResetAssignedInfosFromGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_BOSS_1}
  SsdNpc.ResetAssignedInfosFromGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_BOSS_2}
  SsdNpc.ResetAssignedInfosFromGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_BOSS_3}
end
function this.AssignDefaultInfosToGameObjectTypeForZombie()
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_ZOMBIE,npcType="Zombie",partsType="ZombieNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM,npcType="ZombieBom",partsType="ZombieBomNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH,npcType="ZombieDash",partsType="ZombieDashNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL,npcType="ZombieShell",partsType="ZombieShellNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR,npcType="ZombieArmor",partsType="ZombieArmorNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_EVENT,npcType="ZombieXOF",partsType="ZombieXOFNormal"}
end
function this.AssignDefaultInfosToGameObjectTypeForAnimal()
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_ZEBRA,npcType="Zebra",partsType="ZebraNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_DONKEY,npcType="Donkey",partsType="DonkeyNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_OKAPI,npcType="Okapi",partsType="OkapiNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_GOAT,npcType="Goat",partsType="GoatNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_SHEEP,npcType="Sheep",partsType="SheepNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_NUBIAN,npcType="Nubian",partsType="NubianNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_BOER,npcType="Boer",partsType="BoerNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_BEAR,npcType="Bear",partsType="BearNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_KASHMIR_BEAR,npcType="KashmirBear",partsType="KashmirBearNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_WOLF,npcType="Wolf",partsType="WolfNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_JACKAL,npcType="Jackal",partsType="JackalNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_LYCAON,npcType="Lycaon",partsType="LycaonNormal"}
  SsdNpc.AssignInfosToGameObjectType{gameObjectType=TppGameObject.GAME_OBJECT_TYPE_ANUBIS,npcType="Anubis",partsType="AnubisNormal"}
end
function this.AssignNpcInfosToGameObjectType(a)
  for s,a in ipairs(a)do
    SsdNpc.AssignInfosToGameObjectType{gameObjectType=a[1],npcType=a[2],partsType=a[3]}
  end
end
function this.GetNpcPackagePathList(s)
  local a={}
  for e,s in ipairs(s)do
    local s=SsdNpc.GetGameObjectPackFilePathsFromPartsType{partsType=s[3]}
    for e,s in ipairs(s)do
      table.insert(a,s)
    end
  end
  return a
end
function this._AddCommonMissionPack(a,s,e)
  TppPackList.AddLocationCommonScriptPack(a)
  TppPackList.AddLocationCommonMissionAreaPack(a)
  if s=="coop"then
    TppPackList.AddCoopCommonPack(a)
  end
  if s=="free"then
    TppPackList.AddFreeCommonPack(a)
  end
  if TppMission.IsMatchingRoom(a)then
    TppPackList.AddRobbyStagePack(a)
  else
    TppPackList.AddZombieCommonPack(a)
  end
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/common/mis_com_quest.fpk"
  local a="/Assets/ssd/pack/mission/"..(s..("/"..(e..("/"..(e..".fpk")))))
  TppPackList.AddMissionPack(a)
end
function this._AddExtraSmallPack(a)
  local a=missionSmallPackTable[a]
  if Tpp.IsTypeTable(a)then
    for s,a in ipairs(a)do
      TppPackList.AddMissionPack(a)
    end
  end
end
function this._AddCoopCommonMissionPack(s)
  if not Tpp.IsTypeNumber(s)then
    return
  end
  this._AddCommonMissionPack(s,"coop","c"..s)
  TppPackList.AddMissionPack"/Assets/ssd/pack/collectible/rewardCbox/rewardCbox.fpk"
  TppPackList.AddMissionPack"/Assets/ssd/pack/mission/common/mis_com_walkergear.fpk"
  this._AddExtraSmallPack(math.floor((s/100)%100))
end
if Mission.SetLocationPackagePathFunc then
  Mission.SetLocationPackagePathFunc(this.GetLocationPackagePath)
end
if Mission.SetMissionPackagePathFunc then
  Mission.SetMissionPackagePathFunc(this.GetMissionPackagePath)
end
function this.UpdateMissionListForDlcMission()
  this.MISSION_LIST={}
  Tpp.ApendArray(this.MISSION_LIST,this.LOCAL_MISSION_LIST)
  local s=Mission.GetDlcMissionCodeList()
  for e,s in ipairs(s)do
    table.insert(this.MISSION_LIST,tostring(s))
  end
  this.MISSION_ENUM=TppDefine.Enum(this.MISSION_LIST)
  if Mission.RegisterMissionCodeList then
    Mission.RegisterMissionCodeList{codeList=this.MISSION_LIST}
  end
end
return this
