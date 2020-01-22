local e={}
e.LastLogYLocation=200
e.LogLineHeight=8
e.LogLineMinY=200
e.LogLineMaxY=600
e.LogLineX=50
e.DomId=1
e.DomBaseId=101
e.DeathmatchId=2
e.DeathmatchBaseId=102
e.TeamsneakId=3
e.TeamsneakBaseId=103
e.AttackId=8
e.AttackBaseId=108
e.FreeplayId=4
e.TextureLoadWaitRatio=.35
e.TextureLoadWaitTimeout=45
e.despawnDelay=15e3
e.TutorialPhase=0
e.TutorialTime=0
e.weatherStartIds={}
e.weatherEndIds={}
e.WEATHER_CHANGE_COUNT_MAX=8
e.TDM_WinBonusPerMin=300
e.TDM_LossBonusPerMin=150
e.DOM_WinBonusPerMin=300
e.DOM_LossBonusPerMin=150
e.TS_D_WinBonusPerMin=400
e.TS_D_LossBonusPerMin=200
e.EXPECTED_XP_PER_SEC=500/60
e.ASCENSION_LOSS_PENALTY=0
e.GEARPOINTS={WINNER=300,LOSER=100,TIE=200}
function e.IsBaseRuleset(e)
return 100<=e
end
function e.IsRuleset(e,p)
return MpRulesetManager.GetRulesetScriptVarsValueById(e)==p
end
function e.DisplayError(p)
e.LastLogYLocation=e.LastLogYLocation+e.LogLineHeight
if e.LastLogYLocation>e.LogLineMaxY then
e.LastLogYLocation=e.LogLineMinY
end
end
function e.DisplayLog(_,p,i,o,n,a)
e.DisplayLogColor(_,p,i,o,n,a,Color{0,0,0,1})
end
function e.DisplayLogColor(a,_,p,n,i,o,a)
local a=60
if p~=nil then
a=p
end
local p=6
if o~=nil then
p=o
end
local p=true
local a=e.LogLineX
local o=e.LastLogYLocation
if n~=nil then
a=n
p=false
end
if i~=nil then
o=i
p=false
end
if p then
e.LastLogYLocation=e.LastLogYLocation+e.LogLineHeight
if e.LastLogYLocation>e.LogLineMaxY then
e.LastLogYLocation=e.LogLineMinY
end
end
if _ then
end
end
function e.StringArrayToCSV(p)
local e=""local i=false
for n=1,#p do
local p=p[n]
if p~=nil then
if i==false then
e=e..p
i=true
else
e=e..(", "..p)
end
end
end
return e
end
function e.GetTeamTag(p)
local e="TEAM_"if p<10 then
e=e.."0"end
e=e..tostring(p+1)
return e
end
function e.GetInstanceTag(p)
local e="GENERIC_"if p<10 then
e=e.."0"end
e=e..tostring(p)
return e
end
function e.StringStartsWith(p,e)
return string.sub(p,1,string.len(e))==e
end
function e.ExtractInstanceTag(p)
for i=1,#p do
if e.StringStartsWith(p[i],"GENERIC_")then
return p[i]
end
end
return nil
end
function e.RemoveStringFromStringArray(e,i)
for p,n in ipairs(e)do
if n==i then
table.remove(e,p)
return
end
end
end
function e.FindInArray(p,e)
for p,i in ipairs(p)do
if i==e then
return p
end
end
return 0
end
function e.InsertArrayUniqueInArray(i,p)
for n=1,#i do
local i=i[n]
if e.FindInArray(p,i)==0 then
p[#p+1]=i
end
end
end
function e.SetWeatherInterval(T,_,i,a,n,o)
for p=1,e.WEATHER_CHANGE_COUNT_MAX do
if e.weatherStartIds[p]then
Util.ClearInterval(e.weatherStartIds[p])
end
if e.weatherEndIds[p]then
Util.ClearInterval(e.weatherEndIds[p])
end
end
for p=1,#i do
e.weatherStartIds[p]=Util.SetInterval(i[p]*1e3,false,"Utils","SyncWeather",_,n/o)
e.weatherEndIds[p]=Util.SetInterval(((i[p]+a)+n)*1e3,false,"Utils","SyncWeather",T,n/o)
end
end
function e.SyncWeather(p,e)
local i=e*1e3
local e=MpRulesetManager.GetActiveRuleset()
if p=="clear"then
e:RequestWeather(0,i)
elseif p=="cloudy"then
e:RequestWeather(1,i)
elseif p=="rainy"then
e:RequestWeather(2,i)
elseif p=="sandstorm"then
e:RequestWeather(3,i)
elseif p=="foggy"then
e:RequestWeather(4,i)
end
end
function e.TriggerEffect(i,e,n,p)
for e=e,n do
if e<10 then
TppDataUtility.SetVisibleEffectFromId(i..("0"..tostring(e)),p)
else
TppDataUtility.SetVisibleEffectFromId(i..tostring(e),p)
end
end
end
function e.SetupEffects(i,p)
if vars.isGameplayHost==1 then
e.WeatherRequest(i,p,false)
end
if i==103 then
if p then
end
elseif i==101 then
if p then
end
elseif i==102 then
if p then
end
elseif i==104 then
if p then
end
elseif i==105 then
end
if p then
TppDataUtility.SetVisibleEffectFromGroupId("FxLocatorGroup_NightTimeOnly",true)
TppDataUtility.SetVisibleEffectFromGroupId("FxLocatorGroup_DaytimeOnly",false)
else
TppDataUtility.SetVisibleEffectFromGroupId("FxLocatorGroup_NightTimeOnly",false)
TppDataUtility.SetVisibleEffectFromGroupId("FxLocatorGroup_DaytimeOnly",true)
end
return
end
function e.WeatherRequest(o,n,_)
local p={}
if math.random(2)==1 then
p={180}
end
if MgoMatchMakingManager.GetWeatherChangeState~=nil then
local i=MgoMatchMakingManager.GetWeatherChangeState()
if i==0 then
p={}
elseif i==2 then
local i=math.random(20,80)p={}while#p<e.WEATHER_CHANGE_COUNT_MAX and i<(vars.roundTimeLimit-30)do
table.insert(p,i)i=(i+math.random(120,240))+(vars.roundTimeLimit/30)
end
end
end
local i=false
if _ and#p>0 then
i=true
end
if o==103 then
if n then
e.SyncWeather("rainy",0)WeatherManager.SetCurrentClock("1","00")
else
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("13","00")
if i then
e.SetWeatherInterval("clear","rainy",p,30,20,2)
end
end
elseif o==101 then
if n then
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("1","00")
if i then
e.SetWeatherInterval("clear","cloudy",p,30,20,1)
end
else
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("15","00")
if i then
e.SetWeatherInterval("clear","cloudy",p,30,20,1)
end
end
elseif o==102 then
if n then
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("1","00")
if i then
e.SetWeatherInterval("clear","sandstorm",p,30,20,2)
end
else
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("06","12")
if i then
e.SetWeatherInterval("clear","sandstorm",p,30,20,2)
end
end
elseif o==104 then
if n then
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("1","00")
if i then
e.SetWeatherInterval("clear","rainy",p,30,20,2)
end
else
e.SyncWeather("cloudy",0)WeatherManager.SetCurrentClock("06","30")
if i then
e.SetWeatherInterval("cloudy","rainy",p,30,20,1)
end
end
elseif o==105 then
if n then
e.SyncWeather("cloudy",0)WeatherManager.SetCurrentClock("1","00")
if i then
e.SetWeatherInterval("cloudy","rainy",p,30,20,1)
end
else
e.SyncWeather("cloudy",0)WeatherManager.SetCurrentClock("17","30")
if i then
e.SetWeatherInterval("cloudy","rainy",p,30,20,1)
end
end
end
return
end
function e.AssignWeaponsLoadout(p,a,T,o,n)
local i=(p)*3
local _=(p)*18
for p,e in pairs(a)do
local p=e.slot
local i=p+i
local p=p+_
vars.weapons[i]=e.equip
vars.ammoInWeapons[i]=e.ammo
vars.ammoStockIds[p]=e.bulletId
vars.ammoStockCounts[p]=e.ammoMax
end
local i=(p)*4
for p,e in pairs(T)do
local p=e.slot
local i=(p-TppDefine.WEAPONSLOT.SUPPORT_0)+i
local p=p+_
vars.supportWeapons[i]=e.equip
vars.ammoStockIds[p]=e.bulletId
vars.ammoStockCounts[p]=e.ammoMax
end
local i=(p)*8
for e=0,7,1 do
vars.items[e+i]=TppEquip.EQP_None
end
if o~=nil then
for e,p in pairs(o)do
local p=p.equipId
local e=(e+i)-1
vars.items[e]=p
end
end
local p=p*8
for e=1,8 do
vars.upgrades[(e+p)-1]=TppEquip.UPG_None
end
if n~=nil then
for e,i in pairs(n)do
local i=i.upgradeId
local e=(e+p)-1
vars.upgrades[e]=i
end
end
end
e.CommonAvailableLoadouts={{DisplayName="mgo_default_loadout_assault",attackerLoadout=false,compatibleClasses={MGOPlayer.CLS_INFILTRATOR},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_ar00_v00,parts={TppEquip.MO_30205,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_30304},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg00_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_MolotovCocktail}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_InterrogationPlus_1"},{id="Skill_WeaponsPlus_1"},{id="Skill_TacticalPlus_1"},{id="Skill_LethalMarksmanPlus_1"}}},{DisplayName="mgo_default_loadout_nonlethal",attackerLoadout=true,compatibleClasses={MGOPlayer.CLS_INFILTRATOR},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_StunGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_FultonPlus_2"},{id="Skill_WeaponsPlus_1"},{id="Skill_NonLethalMarksmanPlus_1"}}},{DisplayName="mgo_default_loadout_suppressed",attackerLoadout=nil,compatibleClasses={MGOPlayer.CLS_INFILTRATOR},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_sm02_v00,parts={TppEquip.MO_20204,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_DirtyMag}},itemConfig={{id=TppEquip.EQP_IT_MGO_PersonalCamo}},skillConfig={{id="Skill_Camo_2"},{id="Skill_FultonPlus_2"}}},{DisplayName="mgo_default_loadout_cqc",attackerLoadout=nil,compatibleClasses={MGOPlayer.CLS_INFILTRATOR},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_sg01_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SmokeGrenade}},itemConfig={{id=TppEquip.EQP_IT_MGO_PersonalCamo}},skillConfig={{id="Skill_CQC_StealthPlus_2"},{id="Skill_Camo_1"},{id="Skill_InterrogationPlus_1"}}},{DisplayName="mgo_default_loadout_assault",attackerLoadout=false,compatibleClasses={MGOPlayer.CLS_RECON},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_ar00_v00,parts={TppEquip.MO_None,TppEquip.ST_30202,TppEquip.ST_30114,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg00_v00,parts={TppEquip.MO_10026,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Grenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_AntiMarking_1"},{id="Skill_Intel_1"},{id="Skill_WeaponsPlus_1"},{id="Skill_LethalMarksmanPlus_1"}}},{DisplayName="mgo_default_loadout_nonlethal",attackerLoadout=true,compatibleClasses={MGOPlayer.CLS_RECON},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_TagGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Intel_2"},{id="Skill_WeaponsPlus_1"},{id="Skill_NonLethalMarksmanPlus_1"}}},{DisplayName="mgo_default_loadout_ranged",attackerLoadout=nil,compatibleClasses={MGOPlayer.CLS_RECON},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr00_v00,parts={TppEquip.MO_30205,TppEquip.ST_60303,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_DirtyMag}},itemConfig={{id=TppEquip.EQP_IT_Nvg}},skillConfig={{id="Skill_Sniper_2"},{id="Skill_Optics_2"}}},{DisplayName="mgo_default_loadout_suppressed",attackerLoadout=nil,compatibleClasses={MGOPlayer.CLS_RECON},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr01_v00,parts={TppEquip.MO_30102,TppEquip.ST_60303,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg04_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Decoy}},itemConfig={{id=TppEquip.EQP_IT_Nvg}},skillConfig={{id="Skill_AntiMarking_2"},{id="Skill_Optics_1"},{id="Skill_Intel_1"}}},{DisplayName="mgo_default_loadout_assault",attackerLoadout=false,compatibleClasses={MGOPlayer.CLS_TECHNICAL},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_ar01_v00,parts={TppEquip.MO_None,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_30304},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg00_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Grenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_FieldReport_1"},{id="Skill_WeaponsPlus_1"},{id="Skill_LethalMarksmanPlus_1"},{id="Skill_TacticalPlus_1"}}},{DisplayName="mgo_default_loadout_nonlethal",attackerLoadout=true,compatibleClasses={MGOPlayer.CLS_TECHNICAL},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SleepingGusGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Tank_2"},{id="Skill_TacticalPlus_1"},{id="Skill_NonLethalMarksmanPlus_1"}}},{DisplayName="mgo_default_loadout_splash",attackerLoadout=nil,compatibleClasses={MGOPlayer.CLS_TECHNICAL},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_SLD_SV},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg03_v00,parts={TppEquip.MO_None,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Grenade},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_C4}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_TacticalPlus_2"},{id="Skill_Demolition_1"},{id="Skill_Shield_1"}}},{DisplayName="mgo_default_loadout_coverfire",attackerLoadout=nil,compatibleClasses={MGOPlayer.CLS_TECHNICAL},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_mg01_v00,parts={TppEquip.MO_None,TppEquip.ST_30305,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_30304},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SmokeGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_WeaponsPlus_2"},{id="Skill_Tank_1"},{id="Skill_LethalMarksmanPlus_1"}}}}
function e.DBEUG_LookupObjectiveMessage(i,p)
for e,n in pairs(e.ObjectiveMessage)do
if(p==i:DEBUG_GetStringId(e))then
return v
end
end
return""end
e.Team={SOLID=0,LIQUID=1,BOTH=2}
e.ObjectiveMessage={NONE={name="NONE",debug=""},MP_OBJ={name="MP_OBJ",debug="Objective",langTag="mgo_UI_Briefing_Tips1_DOM"},MP_INFO={name="MP_INFO",debug="Information",langTag="mgo_idt_information"},MP_OBJ_MODE_DM={name="MP_OBJ_MODE_DM",debug="Bounty",langTag="mgo_idt_TDM"},MP_OBJ_MODE_DOM={name="MP_OBJ_MODE_DOM",debug="Domination",langTag="mgo_idt_DOM"},MP_OBJ_MODE_TS={name="MP_OBJ_MODE_TS",debug="Team Sneak",langTag="mgo_idt_TS"},MP_OBJ_MODE_AD={name="MP_OBJ_MODE_AD",debug="Sabotage",langTag="mgo_idt_SAB"},MP_OBJ_MODE_DMBASE={name="MP_OBJ_MODE_DMBASE",debug="Bounty Blitz",langTag="mgo_idt_TDM"},MP_OBJ_MODE_DOMBASE={name="MP_OBJ_MODE_DOMBASE",debug="Domination Blitz",langTag="mgo_idt_DOM"},MP_OBJ_MODE_TSBASE={name="MP_OBJ_MODE_TSBASE",debug="Team Sneak Blitz",langTag="mgo_idt_TS"},MP_OBJ_MODE_ADBASE={name="MP_OBJ_MODE_ADBASE",debug="Sabotage Blitz",langTag="mgo_idt_SAB"},MP_OBJ_NOTIFY={name="MP_OBJ_NOTIFY",debug="Buddy Status",langTag=""},MP_OBJ_OVERTIME={name="MP_OBJ_OVERTIME",debug="Overtime",langTag="mgo_ui_obj_overtime_elim"},MP_OBJ_TS_ATTACK={name="MP_OBJ_TS_ATTACK",debug="Steal an enemy data disc",langTag="mgo_ui_obj_TS_Attack"},MP_OBJ_TS_DEFEND={name="MP_OBJ_TS_DEFEND",debug="Defend the data discs",langTag="mgo_ui_announcer_TS_DiscDf2"},MP_OBJ_TS_RETURN={name="MP_OBJ_TS_RETURN",debug="Deliver disc to evac point",langTag="mgo_ui_announcer_TS_Obj"},MP_OBJ_TS_PROTECT={name="MP_OBJ_TS_PROTECT",debug="Stop the enemy from reaching evac point",langTag="mgo_ui_announcer_TS_Protect"},MP_OBJ_TS_ATTACK_DEAD={name="MP_OBJ_TS_ATTACK_DEAD",debug="Attackers are dead",langTag="mgo_ui_obj_TS_Attack_Dead"},MP_OBJ_TS_DEFEND_DEAD={name="MP_OBJ_TS_DEFEND_DEAD",debug="Defenders are dead",langTag="mgo_ui_obj_TS_Defend_Dead"},MP_OBJ_TS_ATTACK_WIN={name="MP_OBJ_TS_ATTACK_WIN",debug="Attackers escaped with the data disc",langTag="mgo_ui_obj_TS_Attack_Win"},MP_OBJ_TS_ATTACK_LOSE={name="MP_OBJ_TS_ATTACK_LOSE",debug="Time over, Defenders win",langTag="mgo_ui_obj_Attack_Lose"},MP_OBJ_DM={name="MP_OBJ_DM",debug="Eliminate or Fulton the opposing team",langTag="mgo_ui_announcer_DM"},MP_OBJ_DM_WIN_TIX={name="MP_OBJ_DM_WIN_TIX",debug="The enemy team ran out of tickets.",langTag="mgo_ui_obj_bounty_noticket_enemy"},MP_OBJ_DM_LOSS_TIX={name="MP_OBJ_DM_LOSS_TIX",debug="Your team ran out of tickets.",langTag="mgo_ui_obj_bounty_noticket_ally"},MP_OBJ_DM_OT_WIN={name="MP_OBJ_DM_OT_WIN",debug="Enemy player eliminated during overtime.",langTag="mgo_ui_obj_bounty_overtime_enemy"},MP_OBJ_DM_OT_LOSS={name="MP_OBJ_DM_OT_LOSS",debug="Allied player eliminated during overtime.",langTag="mgo_ui_obj_bounty_overtime_ally"},MP_OBJ_DM_WIN_TIME={name="MP_OBJ_DM_WIN_TIME",debug="Time expired. Your team has the highest score.",langTag="mgo_ui_obj_bounty_timeup_winbyscore"},MP_OBJ_DM_LOSS_TIME={name="MP_OBJ_DM_LOSS_TIME",debug="Time expired. The enemy team has the highest score.",langTag="mgo_ui_obj_bounty_timeup_lostbyscore"},MP_OBJ_DM_WIN_TIE={name="MP_OBJ_DM_WIN_TIE",debug="Wins by top player.",langTag="mgo_idt_win_top_player"},MP_OBJ_DM_WIN_TIME_TIX={name="MP_OBJ_DM_WIN_TIME_TIX",debug="Time expired. Your team has the most tickets.",langTag="mgo_ui_obj_bounty_timeup_winbyticket"},MP_OBJ_DM_LOSS_TIME_TIX={name="MP_OBJ_DM_LOSS_TIME_TIX",debug="Time expired. The enemy team has the most tickets.",langTag="mgo_ui_obj_bounty_timeup_lostbyticket"},MP_OBJ_DOM={name="MP_OBJ_DOM",debug="Capture and hold the comm links to defeat the enemy",langTag="mgo_ui_announcer_DOM"},MP_OBJ_DOM_ATK={name="MP_OBJ_DOM_ATK",debug="Capture a comm link to stop the enemy",langTag="mgo_ui_obj_DOM_Attack"},MP_OBJ_DOM_DEF={name="MP_OBJ_DOM_DEF",debug="Defend the comm links to survive",langTag="mgo_ui_obj_DOM_Defend"},MP_OBJ_DOM_ATTACK_WIN={name="MP_OBJ_DOM_ATTACK_WIN",debug="Attackers took down the comm system",langTag="mgo_ui_obj_comm_system"},MP_OBJ_NOTIFY_NEAREND={name="MP_OBJ_NOTIFY_NEAREND",debug="Round Ending Soon",langTag="mgo_ui_obj_roundend_soon"},MP_OBJ_NOTIFY_WON={name="MP_OBJ_NOTIFY_WON",debug="Your team won!",langTag="mgo_ui_obj_teamwon"},MP_OBJ_NOTIFY_LOST={name="MP_OBJ_NOTIFY_LOST",debug="Your team lost.",langTag="mgo_ui_obj_teamlost"},MP_OBJ_NOTIFY_WON_ENEMY_ABANDONED={name="MP_OBJ_NOTIFY_WON_ENEMY_ABANDONED",debug="The enemy team has abandoned the match.",langTag="mgo_log_enemy_team_abandon"}}
e.ObjectiveSounds={NONE="",MP_SFX_TDM_INITIAL="sfx_s_mission_qualify",MP_SFX_TDM_OVERTIME="sfx_s_sideops_sted",MP_SFX_DOM_INITIAL="sfx_s_mission_qualify",MP_SFX_DOM_ENE_CAP="sfx_enemy_captured_point",MP_SFX_DOM_ENE_CAP_ALL="sfx_enemy_captured_all_points",MP_SFX_DOM_ALY_CAP="sfx_friendly_captured_point",MP_SFX_DOM_ALY_CAP_ALL="sfx_friendly_captured_all_points",MP_SFX_DOM_NEUTRALIZE="sfx_point_neutralized",MP_SFX_TSNE_INITIAL="sfx_s_mission_qualify",MP_SFX_TSNE_GOOD="sfx_friendly_captured_point",MP_SFX_TSNE_BAD="sfx_enemy_captured_point",MP_SFX_TSNE_GOOD_END="",MP_SFX_TSNE_BAD_END="",MP_SFX_TSNE_PICKUP="sfx_s_fob_emergency",MP_SFX_TSNE_DROPPED="sfx_UI_Disc_Dropped",MP_SFX_TSNE_CAPTURE="sfx_UI_Uploading_Complete_Sting"}
e.NotificationSounds={NONE="",MP_SFX_NOTIFY="sfx_s_title_slct_mission",MP_SFX_CONTRACT_GIVEN="sfx_s_title_slct_mission",MP_SFX_CONTRACT_PROGRESS="sfx_s_title_slct_mission",MP_SFX_CONTRACT_COMPLETE="sfx_stinger_subobjective"}
function e.DBEUG_LookupObjectiveMessage(n,i)
for p,e in pairs(e.ObjectiveMessage)do
local p=n:DEBUG_GetStringId(p)
if(i==p)then
return e.debug
end
end
return""end
function e.AllRulesetBlocksAreLoaded()
local e=MpRulesetManager.HasBlockController()
if not e then
return false
end
local p=MpRulesetManager.HasCommonBlock()
local e=true
if p then
e=MpRulesetManager.IsCommonBlockLoaded()
end
local p=MpRulesetManager.HasMapBlock()
local i=true
if p then
i=MpRulesetManager.IsMapBlockLoaded()
end
local n=MpRulesetManager.HasDynamicBlock()
local p=true
if n then
p=MpRulesetManager.IsDynamicBlockLoaded()
end
return(e and i)and p
end
function e.GetActivePlayerSessionIndicesOnTeam(p,e)
local i={}
local n=p:GetActivePlayerCountByTeamIndex(e)
for n=0,n-1 do
local e=p:GetPlayerFromTeamIndex(e,n)
if e~=nil then
local e=e.sessionIndex
table.insert(i,e)
end
end
return i
end
function e.IsSleepIcon(p)
if(((p==TppDamage.ATK_10101 or p==TppDamage.ATK_60001)or p==TppDamage.ATK_10107)or p==TppDamage.ATK_SleepingGusGrenade)or p==TppDamage.ATK_SleepingGusMine then
return true
end
return false
end
e.CombatMsg={}
e.CombatMsg.Icon={OFF=0,PISTOL=1,SMG=2,ASSAULT_RIFLE=3,ASSAULT_RIFLE2=4,SNIPER_RIFLE=5,ROCKET_LAUNCHER=6,GRENADE=7,C4=8,FULTON=9,STUN=10,PLAYER_JOIN=11,PLAYER_LEAVE=12,PLAYER_ASSIST=13,CQC=14,CQC_CHOKE=15,CQC_INTERROGATION=16,CQC_KILL=17,MACHINE_GUN=18,SHOT_GUN=19,CRUSHED=20}
e.CombatMsg.IconMod={NONE=0,HEAD_SHOT=1,MOD_SCORE=2,MOD_DROP=3,MOD_ZZZ=4,MOD_STUN=5}
e.CombatMsg.TextColor={RED=0,WHITE=1,BLUE=2}
e.CombatMsg.Flag={NONE=0,DOM=1,FLOPPY=2,ANTENNA=3,DESTINATION=4}
e.CombatMsg.Player={INVALID=-1}
function e.GetAtkIcon(p)
if((p==TppDamage.ATK_30102 or p==TppDamage.ATK_30001)or p==TppDamage.ATK_30201)or p==TppDamage.ATK_30303 then
return e.CombatMsg.Icon.ASSAULT_RIFLE
elseif((((((((((((p==TppDamage.ATK_Magazine or p==TppDamage.ATK_Grenade)or p==TppDamage.ATK_GrenadeHit)or p==TppDamage.ATK_StunGrenade)or p==TppDamage.ATK_StunGrenadeGrazed)or p==TppDamage.ATK_SleepingGusGrenade)or p==TppDamage.ATK_SleepGus)or p==TppDamage.ATK_SleepGusOccurred)or p==TppDamage.ATK_MolotovCocktail)or p==TppDamage.ATK_MolotovCocktailHit)or p==TppDamage.ATK_MolotovCocktailFire)or p==TppDamage.ATK_NormalFlame)or p==TppDamage.ATK_DecoyHit)or p==TppDamage.ATK_DecoyRaise then
return e.CombatMsg.Icon.GRENADE
elseif(((p==TppDamage.ATK_C4 or p==TppDamage.ATK_Claymore)or p==TppDamage.ATK_AntitankMine)or p==TppDamage.ATK_SleepingGusMine)or p==TppDamage.ATK_VehicleBlast then
return e.CombatMsg.Icon.C4
elseif p==TppDamage.ATK_FultonTrap then
return e.CombatMsg.Icon.FULTON
elseif(((((p==TppDamage.ATK_10101 or p==TppDamage.ATK_10001)or p==TppDamage.ATK_10503)or p==TppDamage.ATK_10403)or p==TppDamage.ATK_10405)or p==TppDamage.ATK_10302)or p==TppDamage.ATK_10107 then
return e.CombatMsg.Icon.PISTOL
elseif((p==TppDamage.ATK_60303 or p==TppDamage.ATK_60102)or p==TppDamage.ATK_60001)or p==TppDamage.ATK_60415 then
return e.CombatMsg.Icon.SNIPER_RIFLE
elseif(p==TppDamage.ATK_20002 or p==TppDamage.ATK_20103)or p==TppDamage.ATK_20203 then
return e.CombatMsg.Icon.SMG
elseif(((p==TppDamage.ATK_40102 or p==TppDamage.ATK_40042)or p==TppDamage.ATK_40203)or p==TppDamage.ATK_40306)or p==TppDamage.ATK_40105 then
return e.CombatMsg.Icon.SHOT_GUN
elseif(((((p==TppDamage.ATK_70002 or p==TppDamage.ATK_70203)or p==TppDamage.ATK_70103)or p==TppDamage.ATK_WalkerGear_MiniGun)or p==TppDamage.ATK_Turret)or p==TppDamage.ATK_Nad)or p==TppDamage.ATK_Sad then
return e.CombatMsg.Icon.MACHINE_GUN
elseif((((p==TppDamage.ATK_80002 or p==TppDamage.ATK_80103)or p==TppDamage.ATK_50303)or p==TppDamage.ATK_50202)or p==TppDamage.ATK_50102)or p==TppDamage.ATK_KillRocket then
return e.CombatMsg.Icon.ROCKET_LAUNCHER
elseif p==TppDamage.ATK_CqcKill or p==TppDamage.ATK_Fall then
return e.CombatMsg.Icon.CQC_KILL
elseif p==TppDamage.ATK_CqcChoke then
return e.CombatMsg.Icon.CQC_CHOKE
elseif((((((((((((p==TppDamage.ATK_CqcFinish or p==TppDamage.ATK_CqcHit)or p==TppDamage.ATK_CqcHitFinish)or p==TppDamage.ATK_CqcThrow)or p==TppDamage.ATK_CqcThrowBehind)or p==TppDamage.ATK_StunArm)or p==TppDamage.ATK_StunArmThunder)or p==TppDamage.ATK_WalkerGear_Kick)or p==TppDamage.ATK_CBoxBodyAttack)or p==TppDamage.ATK_Punch2)or p==TppDamage.ATK_WarHead)or p==TppDamage.ATK_CqcDashPunch)or p==TppDamage.ATK_CqcShieldBash)or p==TppDamage.ATK_StunArm_G1 then
return e.CombatMsg.Icon.CQC
elseif p==TppDamage.ATK_GimmickFultonFall then
return e.CombatMsg.Icon.CRUSHED
else
return e.CombatMsg.Icon.ASSAULT_RIFLE
end
end
function e.OneMinuteLeft()
TppUiCommand.AnnounceLogViewLangId"mgo_announce_generic_one_min"end
function e.TryNotifyBuddyChange(p,e,n,i)
if SpawnHelpers.initialTeamAssignmentHasHappened==true and p.currentState~="RULESET_STATE_BRIEFING"then
TppNetworkUtil.SyncedExecuteSessionIndex(n,"Utils","announceBuddyLink",e)
TppNetworkUtil.SyncedExecuteSessionIndex(i,"Utils","announceBuddyLink",e)
end
end
function e.announceBuddyLink(e)
if e then
TppUiCommand.AnnounceLogViewLangId"mgo_announce_buddy_link_start"else
TppUiCommand.AnnounceLogViewLangId"mgo_announce_buddy_link_end"end
end
function e.ClientAnnounceBuddyLink()
TppUiCommand.AnnounceLogViewLangId"mgo_announce_buddy_link_start"end
function e.HandleSessionDisconnect(e,e)
if(not MgoMatchMakingManager.IsActualMatchmake())then
TppNetworkUtil.StopDebugSession()
TppNetworkUtil.StartDebugSession{}
vars.locationCode=TppDefine.LOCATION_ID.INIT
vars.missionCode=TppDefine.SYS_MISSION_ID.INIT
TppMission.Load(vars.locationCode)
else
MgoMatchMakingManager.ExitRoom()
end
TppSimpleGameSequenceSystem.SetShowLoadScreen(1)
end
function e.TestFlag(p,e)
local e=2^(e-1)
local p=p%(e*2)
return p>=e
end
function e.SetFlag(p,e)
local e=2^(e-1)
local i=p%(e*2)
if i>=e then
return p
end
return p+e
end
function e.ClearFlag(p,i)
local i=2^(i-1)
local n=p%(i*2)
if n>=i then
return p-i
end
return p
end
e.SpecialRoleLoadouts={{DisplayName="mgo_default_loadout_snakeex",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_ar00_v00,parts={TppEquip.MO_None,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_50102},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg04_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Grenade}},handConfig={{id=TppEquip.EQP_HAND_KILL_ROCKET}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_snakenonlethal",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr02_v00,parts={TppEquip.MO_30102,TppEquip.ST_60304,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SmokeGrenade},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_DirtyMag}},handConfig={{id=TppEquip.EQP_HAND_STUNARM}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_snakecamo",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_C4},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_Magazine}},handConfig={{id=TppEquip.EQP_HAND_STUN_ROCKET}},itemConfig={{id=TppEquip.EQP_IT_MGO_PersonalCamo},{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_snakeload",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_mg00_v00,parts={TppEquip.MO_30205,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg00_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_FultonTrap},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_MolotovCocktail}},handConfig={{id=TppEquip.EQP_HAND_KILL_ROCKET}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_snakeex",tsne_only=true,attackerLoadout=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_ar00_v00,parts={TppEquip.MO_None,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_50102},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg04_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Grenade}},handConfig={{id=TppEquip.EQP_HAND_KILL_ROCKET}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_snakenonlethal",tsne_only=true,attackerLoadout=true,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr02_v00,parts={TppEquip.MO_30102,TppEquip.ST_60304,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SmokeGrenade},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_DirtyMag}},handConfig={{id=TppEquip.EQP_HAND_STUNARM}},itemConfig={{id=TppEquip.EQP_IT_CBox},{id=TppEquip.EQP_None},{id=TppEquip.EQP_IT_MGO_StealthCamo}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_snakecamo",tsne_only=true,attackerLoadout=true,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_StunGrenade},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_Magazine}},handConfig={{id=TppEquip.EQP_HAND_STUN_ROCKET}},itemConfig={{id=TppEquip.EQP_IT_CBox},{id=TppEquip.EQP_None},{id=TppEquip.EQP_IT_MGO_StealthCamo}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_snakeload",tsne_only=true,attackerLoadout=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_mg00_v00,parts={TppEquip.MO_30205,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg00_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Claymore},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_MolotovCocktail}},handConfig={{id=TppEquip.EQP_HAND_KILL_ROCKET}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_ocegun",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg03_v01,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_MolotovCocktail}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_ocenonlethal",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_sg02_v00,parts={TppEquip.MO_40104,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_30304},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SleepingGusMine},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_StunGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_ocelethal",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_sg01_v00,parts={TppEquip.MO_None,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg03_v00,parts={TppEquip.MO_10026,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_DirtyMag_G01},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_Claymore}},itemConfig={{id=TppEquip.EQP_IT_Nvg},{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_oceshield",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_SLD_SV},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg03_v01,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_TagGrenade},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_FultonTrap}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_ocegun",tsne_only=true,attackerLoadout=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg03_v01,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_MolotovCocktail}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_ocenonlethal",tsne_only=true,attackerLoadout=true,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_sg02_v00,parts={TppEquip.MO_40104,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_30304},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SleepingGusMine},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_StunGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox},{id=TppEquip.EQP_None},{id=TppEquip.EQP_IT_MGO_StealthCamo}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_ocelethal",tsne_only=true,attackerLoadout=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_sg01_v00,parts={TppEquip.MO_None,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg03_v00,parts={TppEquip.MO_10026,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_C4},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_Claymore}},itemConfig={{id=TppEquip.EQP_IT_CBox},{id=TppEquip.EQP_IT_Nvg}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_oceshield",tsne_only=true,attackerLoadout=true,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_SLD_SV},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_TagGrenade},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_FultonTrap}},itemConfig={{id=TppEquip.EQP_IT_CBox},{id=TppEquip.EQP_None},{id=TppEquip.EQP_IT_MGO_StealthCamo}},skillConfig={{id="Skill_Ocelot_4"}}}}
function e.GetSpecialRoleLoadouts(n)
local p={}
local i=MpRulesetManager.GetActiveRuleset():GetLocalPlayerTeam()
if e.TeamsneakId==vars.rulesetId or e.TeamsneakBaseId==vars.rulesetId then
for o=1,#e.SpecialRoleLoadouts do
local e=e.SpecialRoleLoadouts[o]
if e.SpecialRole==n and e.tsne_only then
if(TeamSneak.attacker==i and e.attackerLoadout)or(TeamSneak.attacker~=i and not e.attackerLoadout)then
table.insert(p,e)
end
end
end
else
for i=1,#e.SpecialRoleLoadouts do
local e=e.SpecialRoleLoadouts[i]
if e.SpecialRole==n and not e.tsne_only then
table.insert(p,e)
end
end
end
return{loadouts=p}
end
function e.AssignSpecialRoles(e,p)
if 0==vars.specialRole then
return
end
local e=p:GetAllActivePlayers().array
local n={{},{}}
for i=1,#e do
local i=e[i]
local e=i.teamIndex
p:SetSpecialRole(i.sessionIndex,MpRulesetManager.SPECIAL_ROLE_NONE)
if e==0 or e==1 then
e=e+1
table.insert(n[e],i)
end
end
local i={MpRulesetManager.SPECIAL_ROLE_SNAKE,MpRulesetManager.SPECIAL_ROLE_OCELOT}
for e=1,2 do
local o=i[e]
local e=n[e]
local i=#e
if i>0 then
local i=math.random(i)
local e=e[i]p:SetSpecialRole(e.sessionIndex,o)
end
end
end
function e.TryReassignSpecialRole(n,i,e,o)
if SpawnHelpers.initialTeamAssignmentHasHappened==false then
return
end
local e=i:GetAllActivePlayers().array
if#e==1 then
SpawnHelpers.Reset()
return
end
if 0==vars.specialRole then
return
end
local p={}
local _={MpRulesetManager.SPECIAL_ROLE_SNAKE,MpRulesetManager.SPECIAL_ROLE_OCELOT}
local a=_[n+1]
for _=1,#e do
local e=e[_]
if e.teamIndex==n and e~=o then
local i=i:GetSpecialRole(e.sessionIndex)
if i==0 or i==1 then
return
end
table.insert(p,e)
end
end
local e=#p
if e>0 then
local e=math.random(e)
local e=p[e]i:SetSpecialRole(e.sessionIndex,a)
end
end
function e.StopWeatherClock()
end
function e.SerializeEvent(e,n,_,i,p)
local a=e:SerializeBoolean(p~=nil)
local o=e:SerializeInteger(n)
local _=e:SerializeInteger(_)
local n=e:SerializeInteger(i)
local i=-1
if a then
i=e:SerializeInteger(p)
end
return o,_,n,i
end
function e.POIinitialize(i,e)
local p=i:GetTransform()
local p=p:GetTranslation()
local i=i:GetGameObjectId()
e.gameObjectId=i:GetId()
e.transform={posX=p:GetX(),posY=p:GetY(),posZ=p:GetZ(),rotY=0}
local p=GameObject.GetGameObjectIdByIndex("TppPoiSystem",0)
local e=GameObject.SendCommand(p,{id="Add",poi=e})
if e==TppPoi.POI_HANDLE_INVALID then
e=nil
end
return e
end
function e.POIdestruct(p,e)
if not e then
return
end
local p=GameObject.GetGameObjectIdByIndex("TppPoiSystem",0)
GameObject.SendCommand(p,{id="Remove",params={poiHandles={e}}})
end
function e.FixUpSupportWeaponPlushySnare(p)
if e.Team.LIQUID==p then
return TppEquip.EQP_SWP_DirtyMag_G01
elseif e.Team.SOLID==p then
return TppEquip.EQP_SWP_DirtyMag
else
return TppEquip.EQP_SWP_DirtyMag
end
end
function e.DetermineMatchWinner(_,i,a,n,o)
local p=0
SpawnHelpers.Reset()
if a==i then
p=i
elseif n>o then
p=e.Team.SOLID
elseif n<o then
p=e.Team.LIQUID
else
local e=e.BreakTie(_,false)
if e==0 then
p=1
else
p=0
end
end
return p
end
function e.BreakTie(o,T)
local a
local _=-1
local i
local n=-1
local e
local p=o:GetAllActivePlayers().array
for e=1,#p do
local e=p[e]
local p
if T==true then
p=o:GetStatByPlayerIndex(e.sessionIndex,MgoStat.STAT_TEAM_POINTS)
else
p=o:GetTotalStatByPlayerIndex(e.sessionIndex,MgoStat.STAT_TEAM_POINTS)
end
if p>_ then
_=p
a=e.sessionIndex
i=e.teamIndex
n=-1
elseif p==_ then
if i~=e.teamIndex then
n=e.sessionIndex
end
end
end
if n==-1 then
if i==Utils.Team.SOLID then
e=Utils.Team.LIQUID
else
e=Utils.Team.SOLID
end
else
if a<n then
if i==Utils.Team.SOLID then
e=Utils.Team.LIQUID
else
e=Utils.Team.SOLID
end
else
if i==Utils.Team.SOLID then
e=Utils.Team.SOLID
else
e=Utils.Team.LIQUID
end
end
end
return e
end
function e.AwardGearPointsToAllPlayers(p,n)
for i,o in pairs(SpawnHelpers.teamRoster)do
if o==n then
p:IncrementStatByPlayerIndex(i,MgoStat.STAT_GEAR_POINTS,e.GEARPOINTS.WINNER)
else
p:IncrementStatByPlayerIndex(i,MgoStat.STAT_GEAR_POINTS,e.GEARPOINTS.LOSER)
end
end
end
function e.InitTutorial()
e.TutorialPhase=0
e.TutorialTime=0
end
function e.DrawTutorial(p,i)
local n=p.currentState
if vars.gamePlayTutorialCount>=10 then
return
end
if i~=1 then
return
end
if n~="RULESET_STATE_ROUND_REGULAR_PLAY"then
return
end
if e.TutorialPhase==0 then
local p=p:GetTimeSpentInCurrentState()
if p>5 then
return
end
e.TutorialPhase=1
e.TutorialTime=p
elseif e.TutorialPhase==1 then
local p=p:GetTimeSpentInCurrentState()
if TppUiCommand.IsMbDvcTerminalOpened()or TppUiCommand.IsOpenCustomizeMenu()then
e.TutorialTime=p-5
else
if p-e.TutorialTime>8 then
TppUiCommand.CallButtonGuide"tutorial_link_action"e.TutorialPhase=2
e.TutorialTime=p
end
end
elseif e.TutorialPhase==2 then
local p=p:GetTimeSpentInCurrentState()
if TppUiCommand.IsMbDvcTerminalOpened()or TppUiCommand.IsOpenCustomizeMenu()then
e.TutorialTime=p-5
else
if p-e.TutorialTime>8 then
TppUiCommand.CallButtonGuide"tutorial_score_board"e.TutorialPhase=3
e.TutorialTime=p
end
end
elseif e.TutorialPhase==3 then
local p=p:GetTimeSpentInCurrentState()
if TppUiCommand.IsMbDvcTerminalOpened()or TppUiCommand.IsOpenCustomizeMenu()then
e.TutorialTime=p-5
else
if p-e.TutorialTime>8 then
TppUiCommand.CallButtonGuide"tutorial_shortcut_radio"e.TutorialPhase=4
e.TutorialTime=p
vars.gamePlayTutorialCount=vars.gamePlayTutorialCount+1
end
end
end
end
function e.SetStaminaConfig(e)
local p={Stamina={UnconsciousStaminaRegenRate=.35,BasicActionStaminaRegenRate=1,ComplexActionStaminaRegenRate=1,ButtonMashModifier=.75}}e:ReloadRulesetConfig(p)
end
return e
