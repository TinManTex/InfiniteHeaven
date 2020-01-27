local e={}
local n=Fox.StrCode32
local r=Tpp.IsTypeTable
local o=Tpp.IsTypeString
local _=Tpp.IsTypeNumber
local s=Tpp.IsTypeFunc
e.TipsExceptTime={[TppDefine.TIPS.CQC_INTERROGATION]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.HOLD_UP_INTERROGATION]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.FULTON_CLASS_FUNCTION_STOP]={isOnceThisGame=true,isAlways=false},[TppDefine.TIPS.HORSE_HIDEACTION]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.ACTION_MAKENOISE]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.WEAPON_RANGE]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.RADIO_ESPIONAGE]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.COMOF_STANCE]={isOnceThisGame=false,isAlways=true},[TppDefine.TIPS.BINO_MARKING]={isOnceThisGame=false,isAlways=true}}
e.ControlExceptTime={[TppDefine.CONTROL_GUIDE.DRIVE_COMMON_VEHICLE]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.DRIVE_WALKER_GEAR]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.RIDE_HORSE]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.SNIPER_RIFLE]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.ATTACK_VEHICLE_SHOOT]={isOnceThisGame=true,isAlways=false},[TppDefine.CONTROL_GUIDE.ATTACK_VEHICLE_CAMERA]={isOnceThisGame=true,isAlways=false}}
e.TipsAllPhase={[TppDefine.TIPS.HOLD_UP]=true,[TppDefine.TIPS.SNIPER_RIFLE]=true,[TppDefine.TIPS.UNDER_BARREL]=true,[TppDefine.TIPS.BULLET_REFILL]=true,[TppDefine.TIPS.COMMUNICATOR]=true,[TppDefine.TIPS.SUPPRESSOR]=true,[TppDefine.TIPS.SUPPORT_HELI]=true,[TppDefine.TIPS.BULLET_PENETRATE]=true,[TppDefine.TIPS.BULLET_PENETRATE_FAIL]=true,[TppDefine.TIPS.CQC_INTERROGATION]=true,[TppDefine.TIPS.HOLD_UP_INTERROGATION]=true,[TppDefine.TIPS.RELOAD]=true,[TppDefine.TIPS.COVER]=true,[TppDefine.TIPS.HORSE_HIDEACTION]=true,[TppDefine.TIPS.ACTION_MAKENOISE]=true,[TppDefine.TIPS.WEAPON_RANGE]=true,[TppDefine.TIPS.RADIO_ESPIONAGE]=true,[TppDefine.TIPS.COMOF_STANCE]=true,[TppDefine.TIPS.BINO_MARKING]=true}
e.ControlAllPhase={[TppDefine.CONTROL_GUIDE.RELOAD]=true,[TppDefine.CONTROL_GUIDE.MACHINEGUN]=true,[TppDefine.CONTROL_GUIDE.MORTAR]=true,[TppDefine.CONTROL_GUIDE.ANTI_AIRCRAFT]=true,[TppDefine.CONTROL_GUIDE.SHIELD]=true,[TppDefine.CONTROL_GUIDE.C4_EXPLODING]=true,[TppDefine.CONTROL_GUIDE.BOOSTER_SCOPE]=true,[TppDefine.CONTROL_GUIDE.SNIPER_RIFLE]=true,[TppDefine.CONTROL_GUIDE.UNDER_BARREL]=true,[TppDefine.CONTROL_GUIDE.DRIVE_COMMON_VEHICLE]=true,[TppDefine.CONTROL_GUIDE.DRIVE_WALKER_GEAR]=true,[TppDefine.CONTROL_GUIDE.RIDE_HORSE]=true,[TppDefine.CONTROL_GUIDE.ATTACK_VEHICLE_SHOOT]=true,[TppDefine.CONTROL_GUIDE.ATTACK_VEHICLE_CAMERA]=true}
e.TipsStoryFlag={[TppDefine.TIPS.STEALTH_MODE]=TppDefine.STORY_SEQUENCE.STORY_START}
e.ControlStoryFlag={TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL}
e.IgnoredTipsGuideInMission={[TppDefine.TIPS.SAVE_ANIMAL]={[10020]=true},[TppDefine.TIPS.FOG]={[10020]=true,[10040]=true,[10090]=true,[10110]=true,[10130]=true,[10140]=true},[TppDefine.TIPS.MATERIAL]={[10020]=true},[TppDefine.TIPS.DEV_DOCUMENT]={[10020]=true},[TppDefine.TIPS.DIAMOND]={[10020]=true},[TppDefine.TIPS.PLANT]={[10020]=true},[TppDefine.TIPS.CRACK_CLIMB]={[10020]=true},[TppDefine.TIPS.BULLET_REFILL]={[10020]=true},[TppDefine.TIPS.LOG]={[10020]=true},[TppDefine.TIPS.SUPPORT_HELI]={[10020]=true},[TppDefine.TIPS.SAVE_ANIMAL]={[10020]=true},[TppDefine.TIPS.ANIMAL_CAGE]={[10020]=true},[TppDefine.TIPS.FULTON_CONTAINER]={[10020]=true},[TppDefine.TIPS.FULTON_COMMON_VEHICLE]={[10020]=true},[TppDefine.TIPS.BULLET_REFILL]={[10020]=true,[10115]=true,[11043]=true,[11044]=true,[10280]=true,[50050]=true}}
e.IgnoredControlGuideInMission={}
e.NoGuideMission={[10020]=true,[20010]=true,[21010]=true,[30010]=true,[32010]=true,[65030]=true,[65040]=true,[65060]=true}
e.NoIntelRadioMission={[10020]=true,[20010]=true,[21010]=true,[30010]=true,[32010]=true,[65030]=true,[65040]=true,[65060]=true}
function e._CheckLocation_AFGH_MAFR()
if TppLocation.IsAfghan()or TppLocation.IsMiddleAfrica()then
return true
end
return false
end
function e._CheckLocation_MTBS()
return TppLocation.IsMotherBase()
end
e.TipsLocation={[TppDefine.TIPS.SAND_STORM]=e._CheckLocation_AFGH_MAFR,[TppDefine.TIPS.FOG]=e._CheckLocation_AFGH_MAFR,[TppDefine.TIPS.RAIN]=e._CheckLocation_AFGH_MAFR,[TppDefine.TIPS.COMOF_NIGHT]=e._CheckLocation_AFGH_MAFR,[TppDefine.TIPS.DAY_NIGHT_SHIFT]=TppLocation.IsAfghan,[TppDefine.TIPS.MORALE]=e._CheckLocation_MTBS}
e.WeatherTipsGuideMatchTable={[TppDefine.WEATHER.SANDSTORM]="SAND_STORM",[TppDefine.WEATHER.FOGGY]="FOG",[TppDefine.WEATHER.RAINY]="RAIN"}
e.FultonTipsGuideMatchTable={[TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER]="FULTON_CONTAINER",[TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN]="FULTON_MACHINEGUN",[TppGameObject.GAME_OBJECT_TYPE_MORTAR]="FULTON_MORTAR",[TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN]="FULTON_ANTI_AIRCRAFT",[TppGameObject.GAME_OBJECT_TYPE_VEHICLE]="FULTON_COMMON_VEHICLE"}
e.AttackVehicleTable={[Vehicle.type.EASTERN_TRACKED_TANK]=true,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=true,[Vehicle.type.WESTERN_TRACKED_TANK]=true,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=true}
e.DISPLAY_OPTION={TIPS=1,CONTROL=2,TIPS_CONTROL=3,PAUSE_CONTROL=4,TIPS_IGONORE_RADIO=5,CONTROL_IGONORE_RADIO=6,TIPS_IGONORE_DISPLAY=7}
e.DISPLAY_TIME={DEFAULT=15,LONG=9,LONGER=11}
e.TipsGuideRadioList={[TppDefine.TIPS.DAY_NIGHT_SHIFT]="f1000_rtrg0160",[TppDefine.TIPS.COMOF_NIGHT]="f1000_rtrg2980",[TppDefine.TIPS.RAIN]="f1000_rtrg0180",[TppDefine.TIPS.FOG]="f1000_rtrg0190",[TppDefine.TIPS.SAND_STORM]="f1000_rtrg0210",[TppDefine.TIPS.CRACK_CLIMB]="f1000_rtrg4470",[TppDefine.TIPS.PHANTOM_CIGAR_TOILET]="f1000_rtrg4480",[TppDefine.TIPS.PHANTOM_CIGAR_TRASH]="f1000_rtrg4480",[TppDefine.TIPS.BULLET_REFILL]="f1000_rtrg4490",[TppDefine.TIPS.DEV_DOCUMENT]="f1000_rtrg4080",[TppDefine.TIPS.TRASH]="f1000_rtrg4500",[TppDefine.TIPS.TOILET]="f1000_rtrg4510",[TppDefine.TIPS.DIAMOND]="f1000_rtrg0560",[TppDefine.TIPS.SAVE_ANIMAL]="f1000_rtrg0615",[TppDefine.TIPS.ELECTRICITY]="f1000_rtrg4530",[TppDefine.TIPS.FULTON_CONTAINER]="f1000_rtrg0570",[TppDefine.TIPS.MATERIAL]="f1000_rtrg0580",[TppDefine.TIPS.PLANT]="f1000_rtrg4090",[TppDefine.TIPS.BULLET_PENETRATE]="f1000_rtrg3640",[TppDefine.TIPS.BULLET_PENETRATE_FAIL]="f1000_rtrg3650",[TppDefine.TIPS.ANIMAL_CAGE]={"f1000_rtrg0615","f1000_rtrg0625"}}
e.IntelRadioSetting={type_translate="f1000_esrg1110",type_antenna="f1000_esrg1110",type_eleGenerator="f1000_esrg2200",type_switchboard="f1000_esrg2200",type_searchradar="f1000_esrg1180",type_redSensor="f1000_esrg2140",type_burglar_alarm="f1000_esrg2450",type_gunMount="f1000_esrg1120",type_mortar="f1000_esrg0040",type_antiAirGun="f1000_esrg0990",type_searchlight="f1000_esrg0950",type_trash="f1000_esrg1070",type_drumcan="f1000_esrg1000",type_toilet="f1000_esrg2210",type_shower="f1000_esrg2460",type_camera="f1000_esrg2150",type_gun_camera="f1000_esrg2160",type_uav="f1000_esrg2170",type_light_vehicle="f1000_esrg1010",type_truck="f1000_esrg1020",type_armored_vehicle="f1000_esrg1030",type_tank="f1000_esrg1040",type_walkergear="f1000_esrg0070",type_walkergear_used="f1000_esrg0060",type_enemy_soviet="f1000_esrg0420",type_enemy_cfa="f1000_esrg0730",type_enemy_coyote="f1000_esrg0740",type_enemy_security="f1000_esrg0460",type_enemy_xof="f1000_esrg2410",type_garbillinae="f1000_esrg0150",type_hamiechinus="f1000_esrg0160",type_ochotona_rufescens="f1000_esrg0170",type_raven="f1000_esrg0080",type_hornbill="f1000_esrg0100",type_ciconia_nigra="f1000_esrg0110",type_jehuty="f1000_esrg0120",type_gyps_fulvus="f1000_esrg0130",type_torgos_tracheliotos="",type_polemaetus_bellicosus="f1000_esrg0140",type_goat="f1000_esrg0190",type_sheep="f1000_esrg0180",type_nubian="f1000_esrg0200",type_bore="f1000_esrg0210",type_donkey="f1000_esrg0220",type_zebra="f1000_esrg0230",type_okapi="f1000_esrg0240",type_wolf="f1000_esrg0250",type_lycaon="f1000_esrg0260",type_jackal="f1000_esrg0270",type_anubis="f1000_esrg0280",type_ursus_arctos="f1000_esrg0290",type_kashmiri_ursus_arctos="f1000_esrg0290"}
e.IntelTypeTipsMatchTable={type_translate="COMMUNICATOR",type_antenna="COMMUNICATOR",type_searchradar="RADAR",type_eleGenerator="ELECTRICITY",type_switchboard="ELECTRICITY"}
e.RadioTipsMatchTable={[n"f1000_esrg2190"]="COMMUNICATOR",[n"f1000_esrg2440"]="RADAR",[n"f1000_esrg2200"]="ELECTRICITY",[n"f1000_oprg1600"]="LOG",[n"f1000_oprg1320"]="HOLD_UP",[n"f1000_oprg1610"]="SUPPORT_HELI",[n"f1000_oprg1460"]="BUDDY_HORSE",[n"f2000_rtrg1410"]="BUDDY_DOG",[n"f1000_rtrg4570"]="BUDDY_COMMAND",[n"f1000_rtrg4590"]="BUDDY_QUIET",[n"f1000_rtrg4560"]="TACTICAL_BUDDY",[n"f2000_rtrg0010"]="FREE",[n"f1000_rtrg4550"]="ACTIVE_SONAR",[n"f1000_oprg1470"]="BUDDY_WALKER",[n(TppRadio.COMMON_RADIO_LIST[TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN])]="SUPPRESSOR"}
e.ControlGuideRadioList={[TppDefine.CONTROL_GUIDE.PIPE_UP]="f1000_rtrg4630"}
e.PlantRadioMatchTable={[TppCollection.TYPE_HERB_G_CRESCENT]="f1000_rtrg5010",[TppCollection.TYPE_HERB_A_PEACH]="f1000_rtrg5012",[TppCollection.TYPE_HERB_DIGITALIS_P]="f1000_rtrg5013",[TppCollection.TYPE_HERB_DIGITALIS_R]="f1000_rtrg5013",[TppCollection.TYPE_HERB_B_CARROT]="f1000_rtrg5016",[TppCollection.TYPE_HERB_WORM_WOOD]="f1000_rtrg5014",[TppCollection.TYPE_HERB_TARRAGON]="f1000_rtrg5015",[TppCollection.TYPE_HERB_HAOMA]="f1000_rtrg5011"}
function e.DispGuide_TrapCarryThrow()
if PlayerInfo.AndCheckStatus{PlayerStatus.CARRY}then
local e=TppDefine.CONTROL_GUIDE.SHOULDER_THROW
local e=TppDefine.CONTROL_GUIDE_LANG_ID_LIST[e]
TppUiCommand.CallButtonGuide(e)
end
end
function e.DispGuide(n,T,p)
local t=TppStory.GetCurrentStorySequence()
local i=not Tpp.IsNotAlert()
if T==e.DISPLAY_OPTION.TIPS then
e.DispTipsGuide(n,t,i,p)
elseif T==e.DISPLAY_OPTION.CONTROL then
e.DispControlGuide(n,t,i,p)
elseif T==e.DISPLAY_OPTION.TIPS_CONTROL then
e.DispControlGuide(n,t,i)
e.DispTipsGuide(n,t,i)
elseif T==e.DISPLAY_OPTION.PAUSE_CONTROL then
e.DispControlGuide(n,t,i,nil,true)
elseif T==e.DISPLAY_OPTION.TIPS_IGONORE_RADIO then
e.DispTipsGuide(n,t,i,p,false,true)
elseif T==e.DISPLAY_OPTION.CONTROL_IGONORE_RADIO then
e.DispControlGuide(n,t,i,p,false,true)
elseif T==e.DISPLAY_OPTION.TIPS_IGONORE_DISPLAY then
e.DispTipsGuide(n,t,i,p,false,false,true)
end
end
function e.DispTipsGuide(n,t,p,T,i,i,i)
local n=TppDefine.TIPS[n]
if not n then
return
end
local i=e.TipsStoryFlag[n]
if i then
if t<i then
return
end
end
local i=e.TipsLocation[n]
if i then
if not i()then
return
end
end
if e.NoGuideMission[vars.missionCode]then
return
end
local i=e.IgnoredTipsGuideInMission[n]
if i then
for e,n in pairs(i)do
if vars.missionCode==e then
return
end
end
end
if TppMission.IsBossBattle()then
if not e.TipsAllPhase[n]then
return
end
end
if p then
if not e.TipsAllPhase[n]then
return
end
end
local t=true
local i=false
local e=e.TipsExceptTime[n]
if e then
t=e.isOnce
i=e.isOnceThisGame
end
local e=T
end
function e.DispControlGuide(T,t,o,_,r,p)
local n=TppDefine.CONTROL_GUIDE[T]
if not n then
return
end
local i=e.ControlStoryFlag[n]
if i then
if t<i then
return
end
end
if not TppMission.IsFreeMission(vars.missionCode)then
if e.NoGuideMission[vars.missionCode]then
return
end
local i=e.IgnoredControlGuideInMission[n]
if i then
for e,n in pairs(i)do
if vars.missionCode==e then
return
end
end
end
if TppMission.IsBossBattle()then
if not e.ControlAllPhase[n]then
return
end
end
end
if o then
if not e.ControlAllPhase[n]then
return
end
end
local t=true
local i=false
local e=e.ControlExceptTime[n]
if e then
t=e.isOnce
i=e.isOnceThisGame
end
local e=_
TppUI.ShowControlGuide{actionName=T,isOnce=t,isOnceThisGame=i,time=e,pauseControl=r,ignoreRadio=p}
end
function e.OnIconFultonShown(t,n,i)
local n=GameObject.GetTypeIndex(n)
if e.FultonTipsGuideMatchTable[n]then
if n~=TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER then
e.DispGuide(e.FultonTipsGuideMatchTable[n],e.DISPLAY_OPTION.TIPS)
else
if i==1 then
e.DispGuide(e.FultonTipsGuideMatchTable[n],e.DISPLAY_OPTION.TIPS)
end
end
end
end
function e.OnVehicleDrive(i,n)
local n=GameObject.SendCommand(n,{id="GetVehicleType"})
if e.AttackVehicleTable[n]then
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
function e.OnPickUpCollection(i,i,n)
if n==TppCollection.TYPE_DIAMOND_SMALL or n==TppCollection.TYPE_DIAMOND_LARGE then
e.DispGuide("DIAMOND",e.DISPLAY_OPTION.TIPS)
elseif TppCollection.IsHerbByType(n)then
e.DispGuide("PLANT",e.DISPLAY_OPTION.TIPS)
if not TppUiCommand.IsDispGuide"TipsGuide"then
local n=e.PlantRadioMatchTable[n]
if n then
e.PlayTutorialRadioOnly(n,{delayTime="mid"})
end
end
elseif n==TppCollection.TYPE_DEVELOPMENT_FILE then
e.DispGuide("DEV_DOCUMENT",e.DISPLAY_OPTION.TIPS)
elseif n==TppCollection.TYPE_EMBLEM then
e.DispGuide("EMBLEM",e.DISPLAY_OPTION.TIPS)
elseif n==TppCollection.TYPE_SHIPPING_LABEL then
e.DispGuide("BOX_MOVE",e.DISPLAY_OPTION.TIPS)
elseif n>=TppCollection.TYPE_MATERIAL_CM_0 and n<=TppCollection.TYPE_MATERIAL_BR_7 then
e.DispGuide("MATERIAL",e.DISPLAY_OPTION.TIPS)
end
end
local t=function(n)
local e={TppEquip.EQP_WP_10101,TppEquip.EQP_WP_10102,TppEquip.EQP_WP_10103,TppEquip.EQP_WP_10104,TppEquip.EQP_WP_10105,TppEquip.EQP_WP_10107,TppEquip.EQP_WP_10116,TppEquip.EQP_WP_10125,TppEquip.EQP_WP_10134,TppEquip.EQP_WP_10136,TppEquip.EQP_WP_10214,TppEquip.EQP_WP_10216,TppEquip.EQP_WP_60013,TppEquip.EQP_WP_60015,TppEquip.EQP_WP_60016,TppEquip.EQP_WP_60114,TppEquip.EQP_WP_60115,TppEquip.EQP_WP_60116,TppEquip.EQP_WP_60117,TppEquip.EQP_WP_60325,TppEquip.EQP_WP_60326,TppEquip.EQP_WP_60327}
for i,e in pairs(e)do
if e==n then
return true
end
end
end
function e.OnPlayerHoldWeapon(n,i,p,T)
if T==1 then
e.DispGuide("SHIELD",e.DISPLAY_OPTION.CONTROL)
end
if i==TppEquip.EQP_TYPE_Sniper then
e.DispGuide("SNIPER_RIFLE",e.DISPLAY_OPTION.TIPS_CONTROL)
end
if t(n)then
e.DispGuide("TRANQUILIZER",e.DISPLAY_OPTION.TIPS)
end
if p==1 then
e.DispGuide("GUN_LIGHT",e.DISPLAY_OPTION.TIPS)
end
end
function e.OnPlayerUseBoosterScope()
e.DispGuide("BOOSTER_SCOPE",e.DISPLAY_OPTION.CONTROL)
end
function e.OnEquipItem(e,e)
end
function e.OnEquipHudClosed(t,i,n)
if n==TppEquip.EQP_TYPE_Throwing then
e.DispGuide("THROW_EQUIP",e.DISPLAY_OPTION.TIPS)
elseif n==TppEquip.EQP_TYPE_Placed then
local n=TppEquip.GetSupportWeaponTypeId(i)
if n==TppEquip.SWP_TYPE_CaptureCage then
e.DispGuide("ANIMAL_CAGE",e.DISPLAY_OPTION.TIPS)
end
else
local n
local _
local p
local t
local T
local r
n,_,p,t,T,r=TppEquip.GetAmmoInfo(i)
if n~=0 and t~=0 then
e.DispGuide("UNDER_BARREL",e.DISPLAY_OPTION.TIPS_CONTROL)
end
end
end
function e.OnWeaponPutPlaced(i,n)
local n=TppEquip.GetSupportWeaponTypeId(n)
if n==TppEquip.SWP_TYPE_C4 then
e.DispGuide("C4_EXPLODING",e.DISPLAY_OPTION.CONTROL)
end
end
function e.OnAmmoStackEmpty(e,e,e)
end
function e.OnSuppressorIsBroken()
TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN,true)
end
function e.StartInvestigate(i,n,i)
if n==0 then
return
end
e.PlayTutorialRadioOnly("f1000_rtrg4450",{delayTime="long"})
end
function e.EndInvestigate(i,n,i)
if n==0 then
return
end
e.PlayTutorialRadioOnly("f1000_rtrg4460",{delayTime="long"})
end
local i=function(n)
local e=PlayerConstants.ITEM_COUNT-1
for e=0,e do
if vars.items[e]==n then
return true
end
end
return false
end
function e.DispGuide_PhatomCigar(n)
if not i(TppEquip.EQP_IT_TimeCigarette)then
return
end
if vars.playerPhase<TppGameObject.PHASE_ALERT and vars.playerPhase>TppGameObject.PHASE_SNEAK then
e.DispGuide(n,e.DISPLAY_OPTION.TIPS)
end
end
function e.DispGuide_Weather(n)
if e.WeatherTipsGuideMatchTable[n]then
e.DispGuide(e.WeatherTipsGuideMatchTable[n],e.DISPLAY_OPTION.TIPS)
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
TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.DISCOVERED_BY_SNIPER,true)
end
function e.OnIconSwitchShown(T,t,n,i)
local n=TppGimmick.GetGimmickID(t,n,i)
if not n then
return
end
local n=mvars.gim_connectPowerCutAreaTable[n]
if n then
e.DispGuide("ELECTRICITY",e.DISPLAY_OPTION.TIPS)
end
end
function e.OnIconClimbOnShown(i,n)
if n==1 then
e.DispGuide("CRACK_CLIMB",e.DISPLAY_OPTION.TIPS)
end
end
function e.OnBulletGuardArmor(i,T,i,n)
if BulletGuardArmorMessageFlag==nil then
return
end
local t=BulletGuardArmorMessageFlag.BROKEN_HELMET
local i=BulletGuardArmorMessageFlag.IS_HIT_ARMOR
if bit.band(n,t)==t then
e.DispGuide("BULLET_PENETRATE",e.DISPLAY_OPTION.TIPS)
elseif bit.band(n,i)==i then
if not TppDamage.IsActiveByAttackId(T)then
e.DispGuide("BULLET_PENETRATE_FAIL",e.DISPLAY_OPTION.TIPS)
end
end
end
function e.OnMarking(T,T,i,t)
if t~=n"Player"then
return
end
if Tpp.IsSecurityCamera(i)then
if Tpp.IsGunCamera(i)then
e.PlayTutorialRadioOnly"f1000_rtrg4610"else
e.PlayTutorialRadioOnly"f1000_rtrg4600"end
elseif Tpp.IsUAV(i)then
e.PlayTutorialRadioOnly"f1000_rtrg4620"end
end
function e.OnFultonRecovered(n)
local i=GameObject.GetTypeIndex(n)
if i==TppGameObject.GAME_OBJECT_TYPE_VEHICLE then
if n~=GameObject.CreateGameObjectId("TppVehicle2",0)then
e.PlayTutorialRadioOnly("f1000_rtrg4540",{delayTime="long"})
end
end
end
function e.OnRadioStart(n)
local n=e.RadioTipsMatchTable[n]
if n then
e.DispGuide(n,e.DISPLAY_OPTION.TIPS_IGONORE_RADIO)
end
end
function e._UnregisterIntelRadioAfterPlayed(t)
if TppMission.IsFreeMission(vars.missionCode)then
return
end
for i,e in pairs(e.IntelRadioSetting)do
if n(e)==t then
local e={}e[i]="Invalid"TppRadio.ChangeIntelRadio(e)break
end
end
end
function e.OpenTipsOnCurrentStory()
end
function e.SetIgnoredControlGuideInMission(i,n,t)
local n=TppDefine.CONTROL_GUIDE[n]
if not n then
return
end
if t then
if not e.IgnoredControlGuideInMission[n]then
e.IgnoredControlGuideInMission[n]={}
end
e.IgnoredControlGuideInMission[n][i]=true
else
if e.IgnoredControlGuideInMission[n]and e.IgnoredControlGuideInMission[n][i]then
e.IgnoredControlGuideInMission[n][i]=nil
end
end
end
function e.SetIgnoredGuideInMission(i,n,t)
if not _(i)or not o(n)then
return
end
e.SetIgnoredTipsGuideInMission(i,n,t)
e.SetIgnoredControlGuideInMission(i,n,t)
end
function e.SetNoGuideMission(n,i)
if not _(n)then
return
end
if i then
e.NoGuideMission[n]=true
else
if e.NoGuideMission[n]then
e.NoGuideMission[n]=nil
end
end
end
function e.SetIgnoredTipsGuideInMission(i,n,t)
local n=TppDefine.TIPS[n]
if not n then
return
end
if t then
if not e.IgnoredTipsGuideInMission[n]then
e.IgnoredTipsGuideInMission[n]={}
end
e.IgnoredTipsGuideInMission[n][i]=true
else
if e.IgnoredTipsGuideInMission[n]and e.IgnoredTipsGuideInMission[n][i]then
e.IgnoredTipsGuideInMission[n][i]=nil
end
end
end
function e.PlayTutorialRadioOnly(i,n)
if not TppUI.IsEnableToShowGuide()then
return
end
if e.NoGuideMission[vars.missionCode]then
return
end
e.PlayRadio(i,n)
end
function e.PlayRadio(e,i)
local n={delayTime="short"}
if i then
n=i
end
if r(e)then
local i={}
for n,e in pairs(e)do
if not TppRadio.IsPlayed(e)then
table.insert(i,e)
end
end
TppRadio.Play(i,n)
else
if not TppRadio.IsPlayed(e)then
TppRadio.Play(e,n)
end
end
end
function e.SetIntelRadio()
if e.NoIntelRadioMission[vars.missionCode]then
return
end
local e=e.IntelRadioSetting
if not TppMission.IsFreeMission(vars.missionCode)then
for i,n in pairs(e)do
if TppRadio.IsPlayed(n)then
table.remove(e,i)
end
end
end
TppRadio.ChangeIntelRadio(e)
end
function e.StartHelpTipsMenuOnlyAnnounce(e)
if not e then
return
end
if not e.tipsTypes then
return
elseif not r(e.tipsTypes)then
return
end
if e.startRadio and o(e.startRadio)then
TppRadio.Play(e.startRadio)
end
HelpTipsMenuSystem.SetPageOpenedWithAnnounce(e.tipsTypes)
end
function e.StartHelpTipsMenu(n)
if not SsdHelpTipsManager.IsIdle()then
return
end
if not n then
return
end
if not n.tipsTypes then
return
elseif not r(n.tipsTypes)then
return
end
e._RequestOpenHelpTips(n.startRadio,n.tipsRadio,n.tipsTypes,n.endFunction)
end
function e.IsHelpTipsMenu()
if SsdHelpTipsManager.IsIdle()then
return false
end
return true
end
function e.ResetHelpTipsSettings()
end
function e._RequestOpenHelpTips(i,t,T,n)
local e={}
e.startRadio={}
e.tipsRadio={}
e.tipsTypes={}
e.onEnd=nil
if i then
local n,i=TppRadio.GetRadioNameAndRadioIDs(i)
e.startRadio.radioName=n
e.startRadio.groupName=i
e.startRadio.delayTime=0
end
if t then
local n,i=TppRadio.GetRadioNameAndRadioIDs(t)
e.tipsRadio.radioName=n
e.tipsRadio.groupName=i
e.tipsRadio.delayTime=0
end
e.tipsTypes=T
if n and s(n)then
e.onEnd=n
end
Tpp.DEBUG_DumpTable(e)SsdHelpTipsManager.RequestOpen(e)
end
function e.OnReload(n)
e.OpenTipsOnCurrentStory()
end
function e.Init(n)
e.OpenTipsOnCurrentStory()
end
return e
