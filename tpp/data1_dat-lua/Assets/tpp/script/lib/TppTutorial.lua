local e={}
local T=Fox.StrCode32
local O=Tpp.IsTypeTable
local t=Tpp.IsTypeString
local S=Tpp.IsTypeNumber
local p="EnemyHeli"e.TipsExceptTime={[TppDefine.TIPS.CQC_INTERROGATION]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.HOLD_UP_INTERROGATION]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.FULTON_CLASS_FUNCTION_STOP]={isOnceThisGame=true,isAlways=false},[TppDefine.TIPS.HORSE_HIDEACTION]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.ACTION_MAKENOISE]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.WEAPON_RANGE]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.RADIO_ESPIONAGE]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.COMOF_STANCE]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.BINO_MARKING]={isOnceThisGame=false,isAlways=true}}
e.ControlExceptTime={[TppDefine.CONTROL_GUIDE.DRIVE_COMMON_VEHICLE]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.DRIVE_WALKER_GEAR]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.RIDE_HORSE]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.SNIPER_RIFLE]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.ATTACK_VEHICLE_SHOOT]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.ATTACK_VEHICLE_CAMERA]={isOnceThisGame=true,isAlways=false}}
e.TipsAllPhase={[TppDefine.TIPS.HOLD_UP]=true,[TppDefine.TIPS.SNIPER_RIFLE]=true,[TppDefine.TIPS.UNDER_BARREL]=true,[TppDefine.TIPS.BULLET_REFILL]=true,[TppDefine.TIPS.COMMUNICATOR]=true,[TppDefine.TIPS.SUPPRESSOR]=true,[TppDefine.TIPS.SUPPORT_HELI]=true,[TppDefine.TIPS.BULLET_PENETRATE]=true,[TppDefine.TIPS.BULLET_PENETRATE_FAIL]=true,[TppDefine.TIPS.CQC_INTERROGATION]=true,[TppDefine.TIPS.HOLD_UP_INTERROGATION]=true,[TppDefine.TIPS.RELOAD]=true,[TppDefine.TIPS.COVER]=true,[TppDefine.TIPS.HORSE_HIDEACTION]=true,[TppDefine.TIPS.ACTION_MAKENOISE]=true,[TppDefine.TIPS.WEAPON_RANGE]=true,[TppDefine.TIPS.RADIO_ESPIONAGE]=true,[TppDefine.TIPS.COMOF_STANCE]=true,[TppDefine.TIPS.BINO_MARKING]=true}
e.ControlAllPhase={[TppDefine.CONTROL_GUIDE.RELOAD]=true,[TppDefine.CONTROL_GUIDE.MACHINEGUN]=true,[TppDefine.CONTROL_GUIDE.MORTAR]=true,[TppDefine.CONTROL_GUIDE.ANTI_AIRCRAFT]=true,[TppDefine.CONTROL_GUIDE.SHIELD]=true,[TppDefine.CONTROL_GUIDE.C4_EXPLODING]=true,[TppDefine.CONTROL_GUIDE.BOOSTER_SCOPE]=true,[TppDefine.CONTROL_GUIDE.SNIPER_RIFLE]=true,[TppDefine.CONTROL_GUIDE.UNDER_BARREL]=true,[TppDefine.CONTROL_GUIDE.DRIVE_COMMON_VEHICLE]=true,[TppDefine.CONTROL_GUIDE.DRIVE_WALKER_GEAR]=true,[TppDefine.CONTROL_GUIDE.RIDE_HORSE]=true,[TppDefine.CONTROL_GUIDE.ATTACK_VEHICLE_SHOOT]=true,[TppDefine.CONTROL_GUIDE.ATTACK_VEHICLE_CAMERA]=true}
e.TipsStoryFlag={[TppDefine.TIPS.STEALTH_MODE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.ROLLING]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.REFLEX_MODE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.TRASH]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.TOILET]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.TRANQUILIZER]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.TAKE_DOWN]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.GUN_LIGHT]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.CRACK_CLIMB]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.ELUDE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.LOG]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.THROW_EQUIP]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.CARRY_WEAPON_LIMIT]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.HOLD_UP]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.SNIPER_RIFLE]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.UNDER_BARREL]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.BULLET_REFILL]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.SAVE_ANIMAL]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.PLANT]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.FULTON_CONTAINER]=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON,[TppDefine.TIPS.MATERIAL]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.DIAMOND]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.DEV_DOCUMENT]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.EMBLEM]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.BOX_MOVE]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.BUDDY_HORSE]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.BUDDY_DOG]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.BUDDY_QUIET]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.BUDDY_WALKER]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.COMMUNICATOR]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.ELECTRICITY]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.RADAR]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.TACTICAL_BUDDY]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.SUPPRESSOR]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.COMOF_NIGHT]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.DAY_NIGHT_SHIFT]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.SAND_STORM]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.FOG]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.RAIN]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.PHANTOM_CIGAR_TOILET]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.FREE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.SUPPORT_HELI]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.BULLET_PENETRATE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.BUDDY_COMMAND]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.SEARCH_LIGHT]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.FULTON_MACHINEGUN]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.FULTON_MORTAR]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.FULTON_ANTI_AIRCRAFT]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.PHANTOM_CIGAR_TRASH]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.FULTON_COMMON_VEHICLE]=TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON,[TppDefine.TIPS.BULLET_PENETRATE_FAIL]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.MORALE]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.ANIMAL_CAGE]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.CQC_INTERROGATION]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.HOLD_UP_INTERROGATION]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.SHOWER_ROOM]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.FULTON_CLASS_FUNCTION_STOP]=TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,[TppDefine.TIPS.HORSE_HIDEACTION]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.ACTION_MAKENOISE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.WEAPON_RANGE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.RADIO_ESPIONAGE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.COMOF_STANCE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.BINO_MARKING]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.ACTIVE_SONAR]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,[TppDefine.TIPS.FOB_WORM_HOLE]=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL}
e.ControlStoryFlag={TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL,TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL}
e.IgnoredTipsGuideInMission={[TppDefine.TIPS.SAVE_ANIMAL]={[10020]=true},[TppDefine.TIPS.FOG]={[10020]=true,[10040]=true,[10090]=true,[10110]=true,[10130]=true,[10140]=true},[TppDefine.TIPS.MATERIAL]={[10020]=true},[TppDefine.TIPS.DEV_DOCUMENT]={[10020]=true},[TppDefine.TIPS.DIAMOND]={[10020]=true},[TppDefine.TIPS.PLANT]={[10020]=true},[TppDefine.TIPS.CRACK_CLIMB]={[10020]=true},[TppDefine.TIPS.BULLET_REFILL]={[10020]=true},[TppDefine.TIPS.LOG]={[10020]=true},[TppDefine.TIPS.SUPPORT_HELI]={[10020]=true},[TppDefine.TIPS.SAVE_ANIMAL]={[10020]=true},[TppDefine.TIPS.ANIMAL_CAGE]={[10020]=true},[TppDefine.TIPS.FULTON_CONTAINER]={[10020]=true},[TppDefine.TIPS.FULTON_COMMON_VEHICLE]={[10020]=true},[TppDefine.TIPS.BULLET_REFILL]={[10020]=true,[10115]=true,[11043]=true,[11044]=true,[10280]=true,[50050]=true}}
e.IgnoredControlGuideInMission={}
e.NoGuideMission={[10030]=true,[10050]=true,[11050]=true,[11151]=true,[10140]=true,[11140]=true,[10150]=true,[10151]=true,[10240]=true,[50050]=true}
e.NoIntelRadioMission={[10010]=true,[11151]=true,[10150]=true,[10151]=true,[10240]=true,[10280]=true,[50050]=true}
function e._CheckLocation_AFGH_MAFR()
if TppLocation.IsAfghan()or TppLocation.IsMiddleAfrica()then
return true
end
return false
end
function e._CheckLocation_MTBS()
return TppLocation.IsMotherBase()
end
function e._IsEnabledToShowTipsFOB()
if not TppMission.IsFOBMission(vars.missionCode)then
return true
end
if vars.fobSneakMode==FobMode.MODE_VISIT then
return true
end
return false
end
function e._IsEnabledPlayTutorialRadioFOB()
if vars.fobSneakMode==FobMode.MODE_VISIT then
return false
end
return true
end
e.TipsLocation={[TppDefine.TIPS.SAND_STORM]=e._CheckLocation_AFGH_MAFR,[TppDefine.TIPS.FOG]=e._CheckLocation_AFGH_MAFR,[TppDefine.TIPS.RAIN]=e._CheckLocation_AFGH_MAFR,[TppDefine.TIPS.COMOF_NIGHT]=e._CheckLocation_AFGH_MAFR,[TppDefine.TIPS.DAY_NIGHT_SHIFT]=TppLocation.IsAfghan,[TppDefine.TIPS.MORALE]=e._CheckLocation_MTBS}
e.TipsAvailableInHeli={LOG=true,SUPPORT_HELI=true,BUDDY_HORSE=true,BUDDY_DOG=true,BUDDY_COMMAND=true,BUDDY_QUIET=true,TACTICAL_BUDDY=true,FREE=true,ACTIVE_SONAR=true,BUDDY_WALKER=true}
e.ControlGuideAvailableInHeli={MOVE_IN_HELI=true}
e.WeatherTipsGuideMatchTable={[TppDefine.WEATHER.SANDSTORM]="SAND_STORM",[TppDefine.WEATHER.FOGGY]="FOG",[TppDefine.WEATHER.RAINY]="RAIN"}
e.FultonTipsGuideMatchTable={[TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER]="FULTON_CONTAINER",[TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN]="FULTON_MACHINEGUN",[TppGameObject.GAME_OBJECT_TYPE_MORTAR]="FULTON_MORTAR",[TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN]="FULTON_ANTI_AIRCRAFT",[TppGameObject.GAME_OBJECT_TYPE_VEHICLE]="FULTON_COMMON_VEHICLE"}
e.AttackVehicleTable={[Vehicle.type.EASTERN_TRACKED_TANK]=true,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=true,[Vehicle.type.WESTERN_TRACKED_TANK]=true,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=true}
e.DISPLAY_OPTION={TIPS=1,CONTROL=2,TIPS_CONTROL=3,PAUSE_CONTROL=4,TIPS_IGONORE_RADIO=5,CONTROL_IGONORE_RADIO=6,TIPS_IGONORE_DISPLAY=7}
e.DISPLAY_TIME={DEFAULT=15,LONG=9,LONGER=11}
e.TipsGuideRadioList={[TppDefine.TIPS.DAY_NIGHT_SHIFT]="f1000_rtrg0160",[TppDefine.TIPS.COMOF_NIGHT]="f1000_rtrg2980",[TppDefine.TIPS.RAIN]="f1000_rtrg0180",[TppDefine.TIPS.FOG]="f1000_rtrg0190",[TppDefine.TIPS.SAND_STORM]="f1000_rtrg0210",[TppDefine.TIPS.CRACK_CLIMB]="f1000_rtrg4470",[TppDefine.TIPS.PHANTOM_CIGAR_TOILET]="f1000_rtrg4480",[TppDefine.TIPS.PHANTOM_CIGAR_TRASH]="f1000_rtrg4480",[TppDefine.TIPS.BULLET_REFILL]="f1000_rtrg4490",[TppDefine.TIPS.DEV_DOCUMENT]="f1000_rtrg4080",[TppDefine.TIPS.TRASH]="f1000_rtrg4500",[TppDefine.TIPS.TOILET]="f1000_rtrg4510",[TppDefine.TIPS.DIAMOND]="f1000_rtrg0560",[TppDefine.TIPS.SAVE_ANIMAL]="f1000_rtrg0615",[TppDefine.TIPS.ELECTRICITY]="f1000_rtrg4530",[TppDefine.TIPS.FULTON_CONTAINER]="f1000_rtrg0570",[TppDefine.TIPS.MATERIAL]="f1000_rtrg0580",[TppDefine.TIPS.PLANT]="f1000_rtrg4090",[TppDefine.TIPS.BULLET_PENETRATE]="f1000_rtrg3640",[TppDefine.TIPS.BULLET_PENETRATE_FAIL]="f1000_rtrg3650",[TppDefine.TIPS.ANIMAL_CAGE]={"f1000_rtrg0615","f1000_rtrg0625"}}
e.IntelRadioSetting={type_translate="f1000_esrg1110",type_antenna="f1000_esrg1110",type_eleGenerator="f1000_esrg2200",type_switchboard="f1000_esrg2200",type_searchradar="f1000_esrg1180",type_redSensor="f1000_esrg2140",type_burglar_alarm="f1000_esrg2450",type_gunMount="f1000_esrg1120",type_mortar="f1000_esrg0040",type_antiAirGun="f1000_esrg0990",type_searchlight="f1000_esrg0950",type_trash="f1000_esrg1070",type_drumcan="f1000_esrg1000",type_toilet="f1000_esrg2210",type_shower="f1000_esrg2460",type_camera="f1000_esrg2150",type_gun_camera="f1000_esrg2160",type_uav="f1000_esrg2170",type_light_vehicle="f1000_esrg1010",type_truck="f1000_esrg1020",type_armored_vehicle="f1000_esrg1030",type_tank="f1000_esrg1040",type_walkergear="f1000_esrg0070",type_walkergear_used="f1000_esrg0060",type_enemy_soviet="f1000_esrg0420",type_enemy_cfa="f1000_esrg0730",type_enemy_coyote="f1000_esrg0740",type_enemy_security="f1000_esrg0460",type_enemy_xof="f1000_esrg2410",type_garbillinae="f1000_esrg0150",type_hamiechinus="f1000_esrg0160",type_ochotona_rufescens="f1000_esrg0170",type_raven="f1000_esrg0080",type_hornbill="f1000_esrg0100",type_ciconia_nigra="f1000_esrg0110",type_jehuty="f1000_esrg0120",type_gyps_fulvus="f1000_esrg0130",type_torgos_tracheliotos="",type_polemaetus_bellicosus="f1000_esrg0140",type_goat="f1000_esrg0190",type_sheep="f1000_esrg0180",type_nubian="f1000_esrg0200",type_bore="f1000_esrg0210",type_donkey="f1000_esrg0220",type_zebra="f1000_esrg0230",type_okapi="f1000_esrg0240",type_wolf="f1000_esrg0250",type_lycaon="f1000_esrg0260",type_jackal="f1000_esrg0270",type_anubis="f1000_esrg0280",type_ursus_arctos="f1000_esrg0290",type_kashmiri_ursus_arctos="f1000_esrg0290"}
e.IntelTypeTipsMatchTable={type_translate="COMMUNICATOR",type_antenna="COMMUNICATOR",type_searchradar="RADAR",type_eleGenerator="ELECTRICITY",type_switchboard="ELECTRICITY"}
e.RadioTipsMatchTable={[T"f1000_esrg2190"]="COMMUNICATOR",[T"f1000_esrg2440"]="RADAR",[T"f1000_esrg2200"]="ELECTRICITY",[T"f1000_oprg1600"]="LOG",[T"f1000_oprg1320"]="HOLD_UP",[T"f1000_oprg1610"]="SUPPORT_HELI",[T"f1000_oprg1460"]="BUDDY_HORSE",[T"f2000_rtrg1410"]="BUDDY_DOG",[T"f1000_rtrg4570"]="BUDDY_COMMAND",[T"f1000_rtrg4590"]="BUDDY_QUIET",[T"f1000_rtrg4560"]="TACTICAL_BUDDY",[T"f2000_rtrg0010"]="FREE",[T"f1000_rtrg4550"]="ACTIVE_SONAR",[T"f1000_oprg1470"]="BUDDY_WALKER",[T(TppRadio.COMMON_RADIO_LIST[TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN])]="SUPPRESSOR"}
e.ControlGuideRadioList={[TppDefine.CONTROL_GUIDE.PIPE_UP]="f1000_rtrg4630"}
e.PlantRadioMatchTable={[TppCollection.TYPE_HERB_G_CRESCENT]="f1000_rtrg5010",[TppCollection.TYPE_HERB_A_PEACH]="f1000_rtrg5012",[TppCollection.TYPE_HERB_DIGITALIS_P]="f1000_rtrg5013",[TppCollection.TYPE_HERB_DIGITALIS_R]="f1000_rtrg5013",[TppCollection.TYPE_HERB_B_CARROT]="f1000_rtrg5016",[TppCollection.TYPE_HERB_WORM_WOOD]="f1000_rtrg5014",[TppCollection.TYPE_HERB_TARRAGON]="f1000_rtrg5015",[TppCollection.TYPE_HERB_HAOMA]="f1000_rtrg5011"}
function e.Messages()
return Tpp.StrCode32Table{Player={{msg="FinishReflexMode",func=function()
e.DispGuide("REFLEX_MODE",e.DISPLAY_OPTION.TIPS)
end},{msg="IconCrawlStealthShown",func=function()
e.DispGuide("STEALTH_MODE",e.DISPLAY_OPTION.TIPS)
end},{msg="IconClimbOnShown",func=e.OnIconClimbOnShown},{msg="IconSwitchShown",func=e.OnIconSwitchShown},{msg="OnPlayerElude",func=function()
e.DispGuide("ELUDE",e.DISPLAY_OPTION.TIPS)
end},{msg="OnPlayerMachineGun",func=function()
e.DispGuide("MACHINEGUN",e.DISPLAY_OPTION.CONTROL)
end},{msg="OnPlayerMortar",func=function()
e.DispGuide("MORTAR",e.DISPLAY_OPTION.CONTROL)
end},{msg="OnPlayerGatling",func=function()
e.DispGuide("ANTI_AIRCRAFT",e.DISPLAY_OPTION.CONTROL)
end},{msg="OnPlayerSearchLight",func=function()
e.DispGuide("SEARCH_LIGHT",e.DISPLAY_OPTION.TIPS_CONTROL)
end},{msg="IconFultonShown",func=e.OnIconFultonShown},{msg="IconTBoxOnShown",func=function()
e.DispGuide("TRASH",e.DISPLAY_OPTION.TIPS)
end},{msg="IconToiletOnShown",func=function()
e.DispGuide("TOILET",e.DISPLAY_OPTION.TIPS)
end},{msg="OnVehicleDrive",func=e.OnVehicleDrive},{msg="OnWalkerGearDrive",func=function()
e.DispGuide("DRIVE_WALKER_GEAR",e.DISPLAY_OPTION.PAUSE_CONTROL)
end},{msg="OnCrawl",func=function()
e.DispGuide("ROLLING",e.DISPLAY_OPTION.TIPS_CONTROL)
end},{msg="StartCarryIdle",func=e.OnStartCarryIdle},{msg="OnPickUpCollection",func=e.OnPickUpCollection},{msg="PlayerHoldWeapon",func=e.OnPlayerHoldWeapon},{msg="OnPlayerUseBoosterScope",func=e.OnPlayerUseBoosterScope},{msg="OnEquipItem",func=e.OnEquipItem},{msg="OnEquipHudClosed",func=e.OnEquipHudClosed},{msg="OnAmmoLessInMagazine",func=function()
e.DispGuide("RELOAD",e.DISPLAY_OPTION.TIPS_CONTROL)
end},{msg="WeaponPutPlaced",func=e.OnWeaponPutPlaced},{msg="OnAmmoStackEmpty",func=e.OnAmmoStackEmpty},{msg="OnPlayerHeliHatchOpen",func=function()
e.DispGuide("MOVE_IN_HELI",e.DISPLAY_OPTION.CONTROL)
end},{msg="OnPlayerPipeAction",func=function()
e.DispGuide("PIPE_UP",e.DISPLAY_OPTION.CONTROL)
end},{msg="OnPlayerToilet",func=function()
e.DispGuide_PhatomCigar("PHANTOM_CIGAR_TOILET",e.DISPLAY_OPTION.TIPS)
end},{msg="OnPlayerTrashBox",func=function()
e.DispGuide_PhatomCigar("PHANTOM_CIGAR_TRASH",e.DISPLAY_OPTION.TIPS)
end},{msg="PlayerHeliGetOff",func=e.OnPlayerHeliGetOff},{msg="NotHaveStaffToReceiveFulton",func=function()
e.DispGuide("FULTON_CLASS_FUNCTION_STOP",e.DISPLAY_OPTION.TIPS)
end},{msg="SuppressorIsBroken",func=e.OnSuppressorIsBroken},{msg="IconWormholeOnShown",func=function()
e.DispGuide("FOB_WORM_HOLE",e.DISPLAY_OPTION.TIPS)
end}},GameObject={{msg="StartInvestigate",func=e.StartInvestigate},{msg="EndInvestigate",func=e.EndInvestigate},{msg="BulletGuardArmor",func=e.OnBulletGuardArmor},{msg="Fulton",func=e.OnFultonRecovered},{msg="SaluteRaiseMorale",func=function()
e.DispGuide("MORALE",e.DISPLAY_OPTION.TIPS)
end},{msg="InAnimalLocator",func=e.InAnimalLocator},{msg="DiscoveredBySniper",func=e.OnDiscoveredBySniper},{msg="DiscoveredObject",func=e.OnDiscoveredObject},{msg="PlayerIsWithinRange",func=e.OnPlayerIsWithinRange}},Trap={{msg="Enter",sender="trap_Tips_CarryOverThrow_swamp",func=e.DispGuide_TrapCarryThrow},{msg="Enter",sender="trap_Tips_CarryOverThrow_tent0001",func=e.DispGuide_TrapCarryThrow},{msg="Enter",sender="trap_Tips_CarryOverThrow_tent0002",func=e.DispGuide_TrapCarryThrow},{msg="Enter",sender="trap_Tips_CarryOverThrow_tent0003",func=e.DispGuide_TrapCarryThrow},{msg="Enter",sender="trap_Tips_CarryOverThrow_tent0004",func=e.DispGuide_TrapCarryThrow},{msg="Enter",sender="trap_Tips_CarryOverThrow_tent0005",func=e.DispGuide_TrapCarryThrow}},Marker={{msg="ChangeToEnable",func=e.OnMarking}},Weather={{msg="ChangeWeather",func=e.DispGuide_Weather}},Radio={{msg="EspionageRadioPlay",func=e._UnregisterIntelRadioAfterPlayed},{msg="Start",func=e.OnRadioStart}},nil}
end
function e.DispGuide_TrapCarryThrow()
if PlayerInfo.AndCheckStatus{PlayerStatus.CARRY}then
local e=TppDefine.CONTROL_GUIDE.SHOULDER_THROW
local e=TppDefine.CONTROL_GUIDE_LANG_ID_LIST[e]
TppUiCommand.CallButtonGuide(e)
end
end
function e.DispGuide(n,i,_)
local T=TppStory.GetCurrentStorySequence()
local E=not Tpp.IsNotAlert()
if i==e.DISPLAY_OPTION.TIPS then
e.DispTipsGuide(n,T,E,_)
elseif i==e.DISPLAY_OPTION.CONTROL then
e.DispControlGuide(n,T,E,_)
elseif i==e.DISPLAY_OPTION.TIPS_CONTROL then
e.DispControlGuide(n,T,E)
e.DispTipsGuide(n,T,E)
elseif i==e.DISPLAY_OPTION.PAUSE_CONTROL then
e.DispControlGuide(n,T,E,nil,true)
elseif i==e.DISPLAY_OPTION.TIPS_IGONORE_RADIO then
e.DispTipsGuide(n,T,E,_,false,true)
elseif i==e.DISPLAY_OPTION.CONTROL_IGONORE_RADIO then
e.DispControlGuide(n,T,E,_,false,true)
elseif i==e.DISPLAY_OPTION.TIPS_IGONORE_DISPLAY then
e.DispTipsGuide(n,T,E,_,false,false,true)
end
end
function e.DispTipsGuide(n,i,S,O,T,_,p)
local T=TppDefine.TIPS[n]
if not T then
return
end
local E=e.TipsStoryFlag[T]
if E then
if i<E then
return
end
end
if TppMission.IsHelicopterSpace(vars.missionCode)then
if not e.TipsAvailableInHeli[n]then
return
end
else
if e._CheckLocation_MTBS()then
if not e._IsEnabledToShowTipsFOB()then
return
end
end
local E=e.TipsLocation[T]
if E then
if not E()then
return
end
end
if not TppMission.IsFreeMission(vars.missionCode)then
if e.NoGuideMission[vars.missionCode]then
return
end
local n=e.IgnoredTipsGuideInMission[T]
if n then
for e,T in pairs(n)do
if vars.missionCode==e then
return
end
end
end
if TppMission.IsBossBattle()then
if not e.TipsAllPhase[T]then
return
end
end
end
if S then
if not e.TipsAllPhase[T]then
return
end
end
if e.IsRideHelicopter()and not e.TipsAvailableInHeli[n]then
return
end
end
local i=true
local E=false
local e=e.TipsExceptTime[T]
if e then
i=e.isOnce
E=e.isOnceThisGame
end
local e=O
TppUI.ShowTipsGuide{contentName=n,isOnce=i,isOnceThisGame=E,time=e,ignoreRadio=_,ignoreDisplay=p}
end
function e.DispControlGuide(n,_,i,p,O,S)
local T=TppDefine.CONTROL_GUIDE[n]
if not T then
return
end
local E=e.ControlStoryFlag[T]
if E then
if _<E then
return
end
end
if TppMission.IsHelicopterSpace(vars.missionCode)then
if not e.ControlGuideAvailableInHeli[n]then
return
end
else
if e._CheckLocation_MTBS()then
if not e._IsEnabledToShowTipsFOB()then
return
end
end
if not TppMission.IsFreeMission(vars.missionCode)then
if e.NoGuideMission[vars.missionCode]then
return
end
local n=e.IgnoredControlGuideInMission[T]
if n then
for e,T in pairs(n)do
if vars.missionCode==e then
return
end
end
end
if TppMission.IsBossBattle()then
if not e.ControlAllPhase[T]then
return
end
end
end
if i then
if not e.ControlAllPhase[T]then
return
end
end
if e.IsRideHelicopter()and not e.ControlGuideAvailableInHeli[n]then
return
end
end
local i=true
local E=false
local e=e.ControlExceptTime[T]
if e then
i=e.isOnce
E=e.isOnceThisGame
end
local e=p
TppUI.ShowControlGuide{actionName=n,isOnce=i,isOnceThisGame=E,time=e,pauseControl=O,ignoreRadio=S}
end
function e.IsRideHelicopter()
if Tpp.IsHelicopter(vars.playerVehicleGameObjectId)then
return true
end
return false
end
function e.OnIconFultonShown(E,T,n)
local T=GameObject.GetTypeIndex(T)
if e.FultonTipsGuideMatchTable[T]then
if T~=TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER then
e.DispGuide(e.FultonTipsGuideMatchTable[T],e.DISPLAY_OPTION.TIPS)
else
if n==1 then
e.DispGuide(e.FultonTipsGuideMatchTable[T],e.DISPLAY_OPTION.TIPS)
end
end
end
end
function e.OnVehicleDrive(n,T)
local T=GameObject.SendCommand(T,{id="GetVehicleType"})
if e.AttackVehicleTable[T]then
e.DispGuide("ATTACK_VEHICLE_SHOOT",e.DISPLAY_OPTION.CONTROL)
e.DispGuide("ATTACK_VEHICLE_CAMERA",e.DISPLAY_OPTION.CONTROL)
end
e.DispGuide("DRIVE_COMMON_VEHICLE",e.DISPLAY_OPTION.PAUSE_CONTROL)
end
function e.OnStartCarryIdle()
e.DispGuide("SHOULDER",e.DISPLAY_OPTION.CONTROL)
e.DispGuide("SHOULDER_THROW",e.DISPLAY_OPTION.CONTROL)
e.DispGuide("CARRY_WEAPON_LIMIT",e.DISPLAY_OPTION.TIPS)
end
function e.OnPickUpCollection(n,n,T)
if T==TppCollection.TYPE_DIAMOND_SMALL or T==TppCollection.TYPE_DIAMOND_LARGE then
e.DispGuide("DIAMOND",e.DISPLAY_OPTION.TIPS)
elseif TppCollection.IsHerbByType(T)then
e.DispGuide("PLANT",e.DISPLAY_OPTION.TIPS)
if not TppUiCommand.IsDispGuide"TipsGuide"then
local T=e.PlantRadioMatchTable[T]
if T then
e.PlayTutorialRadioOnly(T,{delayTime="mid"})
end
end
elseif T==TppCollection.TYPE_DEVELOPMENT_FILE then
e.DispGuide("DEV_DOCUMENT",e.DISPLAY_OPTION.TIPS)
elseif T==TppCollection.TYPE_EMBLEM then
e.DispGuide("EMBLEM",e.DISPLAY_OPTION.TIPS)
elseif T==TppCollection.TYPE_SHIPPING_LABEL then
e.DispGuide("BOX_MOVE",e.DISPLAY_OPTION.TIPS)
elseif T>=TppCollection.TYPE_MATERIAL_CM_0 and T<=TppCollection.TYPE_MATERIAL_BR_7 then
e.DispGuide("MATERIAL",e.DISPLAY_OPTION.TIPS)
end
end
local _=function(T)
local e={TppEquip.EQP_WP_10101,TppEquip.EQP_WP_10102,TppEquip.EQP_WP_10103,TppEquip.EQP_WP_10104,TppEquip.EQP_WP_10105,TppEquip.EQP_WP_10107,TppEquip.EQP_WP_10116,TppEquip.EQP_WP_10125,TppEquip.EQP_WP_10134,TppEquip.EQP_WP_10136,TppEquip.EQP_WP_10214,TppEquip.EQP_WP_10216,TppEquip.EQP_WP_60013,TppEquip.EQP_WP_60015,TppEquip.EQP_WP_60016,TppEquip.EQP_WP_60114,TppEquip.EQP_WP_60115,TppEquip.EQP_WP_60116,TppEquip.EQP_WP_60117,TppEquip.EQP_WP_60325,TppEquip.EQP_WP_60326,TppEquip.EQP_WP_60327}
for n,e in pairs(e)do
if e==T then
return true
end
end
end
function e.OnPlayerHoldWeapon(i,E,n,T)
if T==1 then
e.DispGuide("SHIELD",e.DISPLAY_OPTION.CONTROL)
end
if E==TppEquip.EQP_TYPE_Sniper then
e.DispGuide("SNIPER_RIFLE",e.DISPLAY_OPTION.TIPS_CONTROL)
end
if _(i)then
e.DispGuide("TRANQUILIZER",e.DISPLAY_OPTION.TIPS)
end
if n==1 then
e.DispGuide("GUN_LIGHT",e.DISPLAY_OPTION.TIPS)
end
end
function e.OnPlayerUseBoosterScope()
e.DispGuide("BOOSTER_SCOPE",e.DISPLAY_OPTION.CONTROL)
end
function e.OnEquipItem(e,e)
end
function e.OnEquipHudClosed(n,E,T)
if T==TppEquip.EQP_TYPE_Throwing then
e.DispGuide("THROW_EQUIP",e.DISPLAY_OPTION.TIPS)
elseif T==TppEquip.EQP_TYPE_Placed then
local T=TppEquip.GetSupportWeaponTypeId(E)
if T==TppEquip.SWP_TYPE_CaptureCage then
e.DispGuide("ANIMAL_CAGE",e.DISPLAY_OPTION.TIPS)
end
else
local n
local _
local i
local T
local p
local S
n,_,i,T,p,S=TppEquip.GetAmmoInfo(E)
if n~=0 and T~=0 then
e.DispGuide("UNDER_BARREL",e.DISPLAY_OPTION.TIPS_CONTROL)
end
end
end
function e.OnWeaponPutPlaced(n,T)
local T=TppEquip.GetSupportWeaponTypeId(T)
if T==TppEquip.SWP_TYPE_C4 then
e.DispGuide("C4_EXPLODING",e.DISPLAY_OPTION.CONTROL)
end
end
function e.OnAmmoStackEmpty(n,n,T)
if Player.IsEnableAmmoSupply(T)then
e.DispGuide("BULLET_REFILL",e.DISPLAY_OPTION.TIPS)
end
end
function e.OnPlayerHeliGetOff()
if not e._IsMBFree()then
return
end
e.DispGuide("SHOWER_ROOM",e.DISPLAY_OPTION.TIPS)
end
function e.OnSuppressorIsBroken()
if TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON<=TppStory.GetCurrentStorySequence()then
return
end
if e._IsMBFree()then
return
end
TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN,true)
end
function e.StartInvestigate(n,T,n)
if T==0 then
return
end
e.PlayTutorialRadioOnly("f1000_rtrg4450",{delayTime="long"})
end
function e.EndInvestigate(n,T,n)
if T==0 then
return
end
e.PlayTutorialRadioOnly("f1000_rtrg4460",{delayTime="long"})
end
function e._IsMBFree()
if vars.missionCode==TppDefine.SYS_MISSION_ID.MTBS_FREE then
return true
end
return false
end
local n=function(T)
local e=PlayerConstants.ITEM_COUNT-1
for e=0,e do
if vars.items[e]==T then
return true
end
end
return false
end
function e.DispGuide_PhatomCigar(T)
if not n(TppEquip.EQP_IT_TimeCigarette)then
return
end
if vars.playerPhase<TppGameObject.PHASE_ALERT and vars.playerPhase>TppGameObject.PHASE_SNEAK then
e.DispGuide(T,e.DISPLAY_OPTION.TIPS)
end
end
function e.DispGuide_Weather(T)
if e.WeatherTipsGuideMatchTable[T]then
e.DispGuide(e.WeatherTipsGuideMatchTable[T],e.DISPLAY_OPTION.TIPS)
end
end
function e.DispGuide_Comufrage()
if Tpp.IsVehicle(vars.playerVehicleGameObjectId)then
e.DispGuide("VEHICLE_LIGHT",e.DISPLAY_OPTION.CONTROL)
end
e.DispGuide("COMOF_NIGHT",e.DISPLAY_OPTION.TIPS)
end
function e.DispGuide_DayAndNight()
e.DispGuide("DAY_NIGHT_SHIFT",e.DISPLAY_OPTION.TIPS)
end
function e.InAnimalLocator()
e.DispGuide("SAVE_ANIMAL",e.DISPLAY_OPTION.TIPS)
end
function e.OnDiscoveredBySniper()
if e.IsRideHelicopter()then
return
end
TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.DISCOVERED_BY_SNIPER,true)
end
function e.OnDiscoveredObject(T,n)
if e.IsRideHelicopter()then
return
end
if T~=GameObject.GetGameObjectId(p)then
return
end
TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.DISCOVERED_BY_ENEMY_HELI,true)
end
function e.OnPlayerIsWithinRange(T,n)
if e.IsRideHelicopter()then
return
end
if T~=GameObject.GetGameObjectId(p)then
return
end
TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.PLAYER_NEAR_ENEMY_HELI,true)
end
function e.SetEnemyHeliMessageWithinRange()
local e=GameObject.GetGameObjectId(p)
if e~=GameObject.NULL_ID then
GameObject.SendCommand(e,{id="SetMessagePlayerIsWithinRange",name="CheckRange400",enabled=true,range=400})
end
end
function e.OnIconSwitchShown(i,E,T,n)
local T=TppGimmick.GetGimmickID(E,T,n)
if not T then
return
end
local T=mvars.gim_connectPowerCutAreaTable[T]
if T then
e.DispGuide("ELECTRICITY",e.DISPLAY_OPTION.TIPS)
end
end
function e.OnIconClimbOnShown(n,T)
if T==1 then
e.DispGuide("CRACK_CLIMB",e.DISPLAY_OPTION.TIPS)
end
end
function e.OnBulletGuardArmor(n,i,n,T)
if BulletGuardArmorMessageFlag==nil then
return
end
local n=BulletGuardArmorMessageFlag.BROKEN_HELMET
local E=BulletGuardArmorMessageFlag.IS_HIT_ARMOR
if bit.band(T,n)==n then
e.DispGuide("BULLET_PENETRATE",e.DISPLAY_OPTION.TIPS)
elseif bit.band(T,E)==E then
if not TppDamage.IsActiveByAttackId(i)then
e.DispGuide("BULLET_PENETRATE_FAIL",e.DISPLAY_OPTION.TIPS)
end
end
end
function e.OnMarking(i,i,n,E)
if E~=T"Player"then
return
end
if Tpp.IsSecurityCamera(n)then
if Tpp.IsGunCamera(n)then
e.PlayTutorialRadioOnly"f1000_rtrg4610"else
e.PlayTutorialRadioOnly"f1000_rtrg4600"end
elseif Tpp.IsUAV(n)then
e.PlayTutorialRadioOnly"f1000_rtrg4620"end
end
function e.OnFultonRecovered(T)
local n=GameObject.GetTypeIndex(T)
if n==TppGameObject.GAME_OBJECT_TYPE_VEHICLE then
if T~=GameObject.CreateGameObjectId("TppVehicle2",0)then
e.PlayTutorialRadioOnly("f1000_rtrg4540",{delayTime="long"})
end
end
end
function e.OnRadioStart(T)
local T=e.RadioTipsMatchTable[T]
if T then
e.DispGuide(T,e.DISPLAY_OPTION.TIPS_IGONORE_RADIO)
end
end
function e._UnregisterIntelRadioAfterPlayed(E)
if TppMission.IsFreeMission(vars.missionCode)then
return
end
for n,e in pairs(e.IntelRadioSetting)do
if T(e)==E then
local e={}e[n]="Invalid"TppRadio.ChangeIntelRadio(e)break
end
end
end
function e.OpenTipsOnStory(E)
if not Tpp.IsTypeNumber(E)then
return
end
local T=1
local e=true
for n=0,#TppDefine.STORY_SEQUENCE_LIST do
if n<=E then
e=true
else
e=false
end
T=tostring(n)
TppUiCommand.EnableTipsGroup(T,e)
end
end
function e.OpenTipsOnCurrentStory()
local T=TppStory.GetCurrentStorySequence()
e.OpenTipsOnStory(T)
end
function e.SetIgnoredControlGuideInMission(n,T,E)
local T=TppDefine.CONTROL_GUIDE[T]
if not T then
return
end
if E then
if not e.IgnoredControlGuideInMission[T]then
e.IgnoredControlGuideInMission[T]={}
end
e.IgnoredControlGuideInMission[T][n]=true
else
if e.IgnoredControlGuideInMission[T]and e.IgnoredControlGuideInMission[T][n]then
e.IgnoredControlGuideInMission[T][n]=nil
end
end
end
function e.SetIgnoredGuideInMission(T,n,E)
if not S(T)or not t(n)then
return
end
e.SetIgnoredTipsGuideInMission(T,n,E)
e.SetIgnoredControlGuideInMission(T,n,E)
end
function e.SetNoGuideMission(T,n)
if not S(T)then
return
end
if n then
e.NoGuideMission[T]=true
else
if e.NoGuideMission[T]then
e.NoGuideMission[T]=nil
end
end
end
function e.SetIgnoredTipsGuideInMission(n,T,E)
local T=TppDefine.TIPS[T]
if not T then
return
end
if E then
if not e.IgnoredTipsGuideInMission[T]then
e.IgnoredTipsGuideInMission[T]={}
end
e.IgnoredTipsGuideInMission[T][n]=true
else
if e.IgnoredTipsGuideInMission[T]and e.IgnoredTipsGuideInMission[T][n]then
e.IgnoredTipsGuideInMission[T][n]=nil
end
end
end
function e.PlayTutorialRadioOnly(T,n)
if not TppUI.IsEnableToShowGuide()then
return
end
if e.NoGuideMission[vars.missionCode]then
return
end
if not e._IsEnabledPlayTutorialRadioFOB()then
return
end
e.PlayRadio(T,n)
end
function e.PlayRadio(e,n)
local T={delayTime="short"}
if n then
T=n
end
if O(e)then
local n={}
for T,e in pairs(e)do
if not TppRadio.IsPlayed(e)then
table.insert(n,e)
end
end
TppRadio.Play(n,T)
else
if not TppRadio.IsPlayed(e)then
TppRadio.Play(e,T)
end
end
end
function e.SetIntelRadio()
if e.NoIntelRadioMission[vars.missionCode]or not e._IsEnabledPlayTutorialRadioFOB()then
return
end
local e=e.IntelRadioSetting
if not TppMission.IsFreeMission(vars.missionCode)then
for T,n in pairs(e)do
if TppRadio.IsPlayed(n)then
table.remove(e,T)
end
end
end
TppRadio.ChangeIntelRadio(e)
end
function e.MakeMessageExecTable()
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnReload(T)
e.MakeMessageExecTable()
e.OpenTipsOnCurrentStory()
end
function e.OnMessage(E,i,S,T,n,_,p)
Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,E,i,S,T,n,_,p)
end
function e.Init(T)
e.MakeMessageExecTable()
e.OpenTipsOnCurrentStory()
e.SetEnemyHeliMessageWithinRange()
end
return e
