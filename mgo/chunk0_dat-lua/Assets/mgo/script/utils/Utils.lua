local e={}
local p
if(Fox.GetDebugLevel()==Fox.DEBUG_LEVEL_QA_RELEASE)then
p=true
end
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
e.SAB_D_WinBonusPerMin=350
e.SAB_D_LossBonusPerMin=300
e.SAB_A_WinBonusPerMin=300
e.SAB_A_LossBonusPerMin=250
e.TS_D_WinBonusPerMin=400
e.TS_D_LossBonusPerMin=200
e.EXPECTED_XP_PER_SEC=500/60
e.ASCENSION_LOSS_PENALTY=0
e.GEARPOINTS={WINNER=300,LOSER=100,TIE=200}
function e.IsBaseRuleset(e)
return 100<=e
end
function e.IsRuleset(p,e)
return MpRulesetManager.GetRulesetScriptVarsValueById(p)==e
end
function e.DisplayError(p)
e.LastLogYLocation=e.LastLogYLocation+e.LogLineHeight
if e.LastLogYLocation>e.LogLineMaxY then
e.LastLogYLocation=e.LogLineMinY
end
end
function e.DisplayLog(p,_,i,n,T,o)
e.DisplayLogColor(p,_,i,n,T,o,Color{0,0,0,1})
end
function e.DisplayLogColor(o,T,p,n,_,i,o)
local o=60
if p~=nil then
o=p
end
local p=6
if i~=nil then
p=i
end
local p=true
local o=e.LogLineX
local i=e.LastLogYLocation
if n~=nil then
o=n
p=false
end
if _~=nil then
i=_
p=false
end
if p then
e.LastLogYLocation=e.LastLogYLocation+e.LogLineHeight
if e.LastLogYLocation>e.LogLineMaxY then
e.LastLogYLocation=e.LogLineMinY
end
end
if T then
end
end
function e.StringArrayToCSV(p)
local e=""local _=false
for i=1,#p do
local p=p[i]
if p~=nil then
if _==false then
e=e..p
_=true
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
for _=1,#p do
if e.StringStartsWith(p[_],"GENERIC_")then
return p[_]
end
end
return nil
end
function e.RemoveStringFromStringArray(e,i)
for _,p in ipairs(e)do
if p==i then
table.remove(e,_)
return
end
end
end
function e.FindInArray(e,p)
for _,e in ipairs(e)do
if e==p then
return _
end
end
return 0
end
function e.InsertArrayUniqueInArray(_,p)
for i=1,#_ do
local _=_[i]
if e.FindInArray(p,_)==0 then
p[#p+1]=_
end
end
end
function e.SetWeatherInterval(o,T,i,a,_,n)
for p=1,e.WEATHER_CHANGE_COUNT_MAX do
if e.weatherStartIds[p]then
Util.ClearInterval(e.weatherStartIds[p])
end
if e.weatherEndIds[p]then
Util.ClearInterval(e.weatherEndIds[p])
end
end
for p=1,#i do
e.weatherStartIds[p]=Util.SetInterval(i[p]*1e3,false,"Utils","SyncWeather",T,_/n)
e.weatherEndIds[p]=Util.SetInterval(((i[p]+a)+_)*1e3,false,"Utils","SyncWeather",o,_/n)
end
end
function e.SyncWeather(e,p)
local p=p*1e3
local _=MpRulesetManager.GetActiveRuleset()
if e=="clear"then
_:RequestWeather(0,p)
elseif e=="cloudy"then
_:RequestWeather(1,p)
elseif e=="rainy"then
_:RequestWeather(2,p)
elseif e=="sandstorm"then
_:RequestWeather(3,p)
elseif e=="foggy"then
_:RequestWeather(4,p)
end
end
function e.TriggerEffect(_,i,e,p)
for e=i,e do
if e<10 then
TppDataUtility.SetVisibleEffectFromId(_..("0"..tostring(e)),p)
else
TppDataUtility.SetVisibleEffectFromId(_..tostring(e),p)
end
end
end
function e.SetupEffects(_,p)
if vars.isGameplayHost==1 then
e.WeatherRequest(_,p,false)
end
if _==103 then
if p then
end
elseif _==101 then
if p then
end
elseif _==102 then
if p then
end
elseif _==104 then
if p then
end
elseif _==105 then
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
function e.WeatherRequest(i,n,o)
local p={}
if math.random(2)==1 then
p={180}
end
if MgoMatchMakingManager.GetWeatherChangeState~=nil then
local _=MgoMatchMakingManager.GetWeatherChangeState()
if _==0 then
p={}
elseif _==2 then
local _=math.random(20,80)p={}while#p<e.WEATHER_CHANGE_COUNT_MAX and _<(vars.roundTimeLimit-30)do
table.insert(p,_)_=(_+math.random(120,240))+(vars.roundTimeLimit/30)
end
end
end
local _=false
if o and#p>0 then
_=true
end
if i==103 then
if n then
e.SyncWeather("rainy",0)WeatherManager.SetCurrentClock("1","00")
else
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("13","00")
if _ then
e.SetWeatherInterval("clear","rainy",p,30,20,2)
end
end
elseif i==101 then
if n then
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("1","00")
if _ then
e.SetWeatherInterval("clear","cloudy",p,30,20,1)
end
else
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("15","00")
if _ then
e.SetWeatherInterval("clear","cloudy",p,30,20,1)
end
end
elseif i==102 then
if n then
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("1","00")
if _ then
e.SetWeatherInterval("clear","sandstorm",p,30,20,2)
end
else
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("06","12")
if _ then
e.SetWeatherInterval("clear","sandstorm",p,30,20,2)
end
end
elseif i==104 then
if n then
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("1","00")
if _ then
e.SetWeatherInterval("clear","rainy",p,30,20,2)
end
else
e.SyncWeather("cloudy",0)WeatherManager.SetCurrentClock("06","30")
if _ then
e.SetWeatherInterval("cloudy","rainy",p,30,20,1)
end
end
elseif i==105 then
if n then
e.SyncWeather("cloudy",0)WeatherManager.SetCurrentClock("1","00")
if _ then
e.SetWeatherInterval("cloudy","rainy",p,30,20,1)
end
else
e.SyncWeather("cloudy",0)WeatherManager.SetCurrentClock("17","30")
if _ then
e.SetWeatherInterval("cloudy","rainy",p,30,20,1)
end
end
elseif(i==111 or i==114)or i==115 then
if n then
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("1","00")
if _ then
e.SetWeatherInterval("clear","cloudy",p,30,20,1)
end
else
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("13","00")
if _ then
e.SetWeatherInterval("clear","cloudy",p,30,20,1)
end
end
elseif i==112 then
if n then
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("1","00")
if _ then
e.SetWeatherInterval("clear","cloudy",p,30,20,1)
end
else
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("13","00")
if _ then
e.SetWeatherInterval("clear","cloudy",p,30,20,1)
end
end
elseif i==113 then
if n then
e.SyncWeather("cloudy",0)WeatherManager.SetCurrentClock("1","00")
if _ then
e.SetWeatherInterval("clear","cloudy",p,30,20,1)
end
else
e.SyncWeather("cloudy",0)WeatherManager.SetCurrentClock("17","30")
if _ then
e.SetWeatherInterval("clear","cloudy",p,30,20,1)
end
end
else
if n then
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("1","00")
if _ then
e.SetWeatherInterval("clear","cloudy",p,30,20,1)
end
else
e.SyncWeather("clear",0)WeatherManager.SetCurrentClock("15","00")
if _ then
e.SetWeatherInterval("clear","cloudy",p,30,20,1)
end
end
end
return
end
function e.AssignWeaponsLoadout(p,T,a,n,o)
local _=(p)*3
local i=(p)*18
for p,e in pairs(T)do
local p=e.slot
local _=p+_
local p=p+i
vars.weapons[_]=e.equip
vars.ammoInWeapons[_]=e.ammo
vars.ammoStockIds[p]=e.bulletId
vars.ammoStockCounts[p]=e.ammoMax
end
local _=(p)*4
for p,e in pairs(a)do
local p=e.slot
local _=(p-TppDefine.WEAPONSLOT.SUPPORT_0)+_
local p=p+i
vars.supportWeapons[_]=e.equip
vars.ammoStockIds[p]=e.bulletId
vars.ammoStockCounts[p]=e.ammoMax
end
local _=(p)*8
for e=0,7,1 do
vars.items[e+_]=TppEquip.EQP_None
end
if n~=nil then
for p,e in pairs(n)do
local i=e.equipId
local e=(p+_)-1
vars.items[e]=i
end
end
local p=p*8
for e=1,8 do
vars.upgrades[(e+p)-1]=TppEquip.UPG_None
end
if o~=nil then
for _,e in pairs(o)do
local e=e.upgradeId
local p=(_+p)-1
vars.upgrades[p]=e
end
end
end
e.CommonAvailableLoadouts={{DisplayName="mgo_default_loadout_assault",attackerLoadout=false,compatibleClasses={MGOPlayer.CLS_INFILTRATOR},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_ar00_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_30304},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg00_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_MolotovCocktail}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_InterrogationPlus_1"},{id="Skill_WeaponsPlus_1"},{id="Skill_TacticalPlus_1"},{id="Skill_LethalMarksmanPlus_1"}}},{DisplayName="mgo_default_loadout_nonlethal",attackerLoadout=true,compatibleClasses={MGOPlayer.CLS_INFILTRATOR},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_StunGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_FultonPlus_2"},{id="Skill_WeaponsPlus_1"},{id="Skill_NonLethalMarksmanPlus_1"}}},{DisplayName="mgo_default_loadout_suppressed",attackerLoadout=nil,compatibleClasses={MGOPlayer.CLS_INFILTRATOR},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_sm02_v00,parts={TppEquip.MO_20204,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_DirtyMag}},itemConfig={{id=TppEquip.EQP_IT_MGO_PersonalCamo},{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Camo_1"},{id="Skill_FultonPlus_1"},{id="Skill_LethalMarksmanPlus_2"}}},{DisplayName="mgo_default_loadout_cqc",attackerLoadout=nil,compatibleClasses={MGOPlayer.CLS_INFILTRATOR},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_sg00_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SmokeGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_CQC_StealthPlus_2"},{id="Skill_InterrogationPlus_1"},{id="Skill_TacticalPlus_1"}}},{DisplayName="mgo_default_loadout_assault",attackerLoadout=false,compatibleClasses={MGOPlayer.CLS_RECON},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_ar00_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_30114,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg00_v00,parts={TppEquip.MO_10026,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Grenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_AntiMarking_1"},{id="Skill_Intel_1"},{id="Skill_WeaponsPlus_1"},{id="Skill_LethalMarksmanPlus_1"}}},{DisplayName="mgo_default_loadout_nonlethal",attackerLoadout=true,compatibleClasses={MGOPlayer.CLS_RECON},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_TagGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Intel_2"},{id="Skill_WeaponsPlus_1"},{id="Skill_NonLethalMarksmanPlus_1"}}},{DisplayName="mgo_default_loadout_ranged",attackerLoadout=nil,compatibleClasses={MGOPlayer.CLS_RECON},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr00_v00,parts={TppEquip.MO_30205,TppEquip.ST_60303,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_DirtyMag}},itemConfig={{id=TppEquip.EQP_IT_Nvg},{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Sniper_2"},{id="Skill_Optics_1"},{id="Skill_TacticalPlus_1"}}},{DisplayName="mgo_default_loadout_suppressed",attackerLoadout=nil,compatibleClasses={MGOPlayer.CLS_RECON},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr01_v00,parts={TppEquip.MO_30102,TppEquip.ST_60303,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg04_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Decoy}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Sniper_1"},{id="Skill_AntiMarking_2"},{id="Skill_WeaponsPlus_1"}}},{DisplayName="mgo_default_loadout_assault",attackerLoadout=false,compatibleClasses={MGOPlayer.CLS_TECHNICAL},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_ar01_v00,parts={TppEquip.MO_30205,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg00_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Grenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_FieldReport_1"},{id="Skill_WeaponsPlus_1"},{id="Skill_LethalMarksmanPlus_1"},{id="Skill_TacticalPlus_1"}}},{DisplayName="mgo_default_loadout_nonlethal",attackerLoadout=true,compatibleClasses={MGOPlayer.CLS_TECHNICAL},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SleepingGusGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Tank_2"},{id="Skill_TacticalPlus_1"},{id="Skill_NonLethalMarksmanPlus_1"}}},{DisplayName="mgo_default_loadout_splash",attackerLoadout=nil,compatibleClasses={MGOPlayer.CLS_TECHNICAL},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_SLD_SV},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg03_v00,parts={TppEquip.MO_None,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Grenade},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_C4}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_TacticalPlus_2"},{id="Skill_Demolition_1"},{id="Skill_Shield_1"}}},{DisplayName="mgo_default_loadout_coverfire",attackerLoadout=nil,compatibleClasses={MGOPlayer.CLS_TECHNICAL},weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_mg00_v00,parts={TppEquip.MO_30205,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SmokeGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_FieldReport_1"},{id="Skill_Tank_1"},{id="Skill_LethalMarksmanPlus_2"}}}}
function e.DBEUG_LookupObjectiveMessage(_,p)
for e,i in pairs(e.ObjectiveMessage)do
if(p==_:DEBUG_GetStringId(e))then
return v
end
end
return""end
e.Team={SOLID=0,LIQUID=1,BOTH=2}
e.ObjectiveMessage={NONE={name="NONE",debug=""},MP_OBJ={name="MP_OBJ",debug="Objective",langTag="mgo_UI_Briefing_Tips1_DOM"},MP_INFO={name="MP_INFO",debug="Information",langTag="mgo_idt_information"},MP_OBJ_MODE_DM={name="MP_OBJ_MODE_DM",debug="Bounty",langTag="mgo_idt_TDM"},MP_OBJ_MODE_DOM={name="MP_OBJ_MODE_DOM",debug="Domination",langTag="mgo_idt_DOM"},MP_OBJ_MODE_TS={name="MP_OBJ_MODE_TS",debug="Team Sneak",langTag="mgo_idt_TS"},MP_OBJ_MODE_AD={name="MP_OBJ_MODE_AD",debug="Sabotage",langTag="mgo_idt_SAB"},MP_OBJ_MODE_DMBASE={name="MP_OBJ_MODE_DMBASE",debug="Bounty Blitz",langTag="mgo_idt_TDM"},MP_OBJ_MODE_DOMBASE={name="MP_OBJ_MODE_DOMBASE",debug="Domination Blitz",langTag="mgo_idt_DOM"},MP_OBJ_MODE_TSBASE={name="MP_OBJ_MODE_TSBASE",debug="Team Sneak Blitz",langTag="mgo_idt_TS"},MP_OBJ_MODE_ADBASE={name="MP_OBJ_MODE_ADBASE",debug="Sabotage Blitz",langTag="mgo_idt_SAB"},MP_OBJ_NOTIFY={name="MP_OBJ_NOTIFY",debug="Buddy Status",langTag=""},MP_OBJ_OVERTIME={name="MP_OBJ_OVERTIME",debug="Overtime",langTag="mgo_ui_obj_overtime_elim"},MP_OBJ_TS_ATTACK={name="MP_OBJ_TS_ATTACK",debug="Steal an enemy data disc",langTag="mgo_ui_obj_TS_Attack"},MP_OBJ_TS_DEFEND={name="MP_OBJ_TS_DEFEND",debug="Defend the data discs",langTag="mgo_ui_announcer_TS_DiscDf2"},MP_OBJ_TS_RETURN={name="MP_OBJ_TS_RETURN",debug="Deliver disc to evac point",langTag="mgo_ui_announcer_TS_Obj"},MP_OBJ_TS_PROTECT={name="MP_OBJ_TS_PROTECT",debug="Stop the enemy from reaching evac point",langTag="mgo_ui_announcer_TS_Protect"},MP_OBJ_TS_ATTACK_DEAD={name="MP_OBJ_TS_ATTACK_DEAD",debug="Attackers are dead",langTag="mgo_ui_obj_TS_Attack_Dead"},MP_OBJ_TS_DEFEND_DEAD={name="MP_OBJ_TS_DEFEND_DEAD",debug="Defenders are dead",langTag="mgo_ui_obj_TS_Defend_Dead"},MP_OBJ_TS_ATTACK_WIN={name="MP_OBJ_TS_ATTACK_WIN",debug="Attackers escaped with the data disc",langTag="mgo_ui_obj_TS_Attack_Win"},MP_OBJ_TS_ATTACK_LOSE={name="MP_OBJ_TS_ATTACK_LOSE",debug="Time over, Defenders win",langTag="mgo_ui_obj_Attack_Lose"},MP_OBJ_DM={name="MP_OBJ_DM",debug="Eliminate or Fulton the opposing team",langTag="mgo_ui_announcer_DM"},MP_OBJ_DM_WIN_TIX={name="MP_OBJ_DM_WIN_TIX",debug="The enemy team ran out of tickets.",langTag="mgo_ui_obj_bounty_noticket_enemy"},MP_OBJ_DM_LOSS_TIX={name="MP_OBJ_DM_LOSS_TIX",debug="Your team ran out of tickets.",langTag="mgo_ui_obj_bounty_noticket_ally"},MP_OBJ_DM_OT_WIN={name="MP_OBJ_DM_OT_WIN",debug="Enemy player eliminated during overtime.",langTag="mgo_ui_obj_bounty_overtime_enemy"},MP_OBJ_DM_OT_LOSS={name="MP_OBJ_DM_OT_LOSS",debug="Allied player eliminated during overtime.",langTag="mgo_ui_obj_bounty_overtime_ally"},MP_OBJ_DM_WIN_TIME={name="MP_OBJ_DM_WIN_TIME",debug="Time expired. Your team has the highest score.",langTag="mgo_ui_obj_bounty_timeup_winbyscore"},MP_OBJ_DM_LOSS_TIME={name="MP_OBJ_DM_LOSS_TIME",debug="Time expired. The enemy team has the highest score.",langTag="mgo_ui_obj_bounty_timeup_lostbyscore"},MP_OBJ_DM_WIN_TIE={name="MP_OBJ_DM_WIN_TIE",debug="Wins by top player.",langTag="mgo_idt_win_top_player"},MP_OBJ_DM_WIN_TIME_TIX={name="MP_OBJ_DM_WIN_TIME_TIX",debug="Time expired. Your team has the most tickets.",langTag="mgo_ui_obj_bounty_timeup_winbyticket"},MP_OBJ_DM_LOSS_TIME_TIX={name="MP_OBJ_DM_LOSS_TIME_TIX",debug="Time expired. The enemy team has the most tickets.",langTag="mgo_ui_obj_bounty_timeup_lostbyticket"},MP_OBJ_DOM={name="MP_OBJ_DOM",debug="Capture and hold the comm links to defeat the enemy",langTag="mgo_ui_announcer_DOM"},MP_OBJ_DOM_ATK={name="MP_OBJ_DOM_ATK",debug="Capture a comm link to stop the enemy",langTag="mgo_ui_obj_DOM_Attack"},MP_OBJ_DOM_DEF={name="MP_OBJ_DOM_DEF",debug="Defend the comm links to survive",langTag="mgo_ui_obj_DOM_Defend"},MP_OBJ_DOM_ATTACK_WIN={name="MP_OBJ_DOM_ATTACK_WIN",debug="Attackers took down the comm system",langTag="mgo_ui_obj_comm_system"},MP_OBJ_ATK_ATTACK={name="MP_OBJ_ATK_ATTACK",debug="Tag enemy intel or interrogate the enemy",langTag="mgo_ui_announcer_SAB_Attack"},MP_OBJ_ATK_DEFEND={name="MP_OBJ_ATK_DEFEND",debug="Protect the intel and avoid interrogation",langTag="mgo_ui_announcer_SAB_Defend"},MP_OBJ_ATK_INTEL={name="MP_OBJ_ATK_INTEL",debug="Intel piece gathered",langTag="mgo_ui_obj_SAB_intel_piece"},MP_OBJ_ATK_FAKE_INTEL={name="MP_OBJ_ATK_FAKE_INTEL",debug="OH NO ITS A FAKE",langTag="mgo_ui_obj_SAB_counter_intel"},MP_OBJ_ATK_FAKE_INTERROGATE={name="MP_OBJ_ATK_FAKE_INTERROGATE",debug="Interrogated revealed A FAKE",langTag="mgo_ui_obj_SAB_counter_intel_expose"},MP_OBJ_ATK_ATK_P2={name="MP_OBJ_ATK_ATK_P2",debug="Login received. Access enemy terminal",langTag="mgo_ui_obj_SAB_after_login"},MP_OBJ_ATK_ATK_P2DELAY={name="MP_OBJ_ATK_ATK_P2DELAY",debug="Intel gathered. Stand by for terminal login",langTag="mgo_ui_obj_SAB_after_intel"},MP_OBJ_ATK_DEF_P2={name="MP_OBJ_ATK_DEF_P2",debug="Guard the terminals",langTag="mgo_ui_obj_SAB_Defend_P2"},MP_OBJ_ATK_ATK_P3DELAY={name="MP_OBJ_ATK_ATK_P3DELAY",debug="Terminal hacked. Get in position to assault the missile",langTag="mgo_ui_obj_SAB_after_hack"},MP_OBJ_ATK_ATK_P3={name="MP_OBJ_ATK_ATK_P3",debug="Defenses deactivated.  Destroy the missile.",langTag="mgo_ui_announcer_SAB_Fulton"},MP_OBJ_ATK_DEF_P3={name="MP_OBJ_ATK_DEF_P3",debug="Protect the missile",langTag="mgo_ui_obj_SAB_Defend_P3"},MP_OBJ_MFULTON={name="MP_OBJ_MFULTON",debug="Fulton attached to missile",langTag="mgo_ui_obj_SAB_fulton_attach"},MP_OBJ_ATK_ATTACK_WIN={name="MP_OBJ_ATK_ATTACK_WIN",debug="Attackers destroyed the missile!",langTag="mgo_ui_obj_SAB_Attack_Win"},MP_OBJ_ATK_DEFEND_WIN={name="MP_OBJ_ATK_DEFEND_WIN",debug="Missile launched! Defenders win",langTag="mgo_ui_obj_SAB_Defend_Win"},MP_OBJ_ATK_ATK_FULTON={name="MP_OBJ_ATK_ATK_FULTON",debug="Attackers fultoned the missile!",langTag="mgo_ui_obj_fultoned_missile"},MP_OBJ_SAB_ATK_START={name="MP_OBJ_SAB_ATK_START",debug="mgo_ui_obj_SAB_Attack_Destroy_or_fulton",langTag="mgo_ui_obj_SAB_Attack_Destroy_or_Fulton"},MP_OBJ_SAB_DEF_START={name="MP_OBJ_SAB_DEF_START",debug="mgo_ui_obj_SAB_Attack_Destroy_or_fulton",langTag="mgo_ui_obj_SAB_Protect_Missile"},MP_OBJ_SAB_ATK_SHIELD_DEACTIVE={name="MP_OBJ_SAB_ATK_SHIELD_DEACTIVE",debug="mgo_ui_obj_SAB_Attack_Shield_Deactive",langTag="mgo_ui_obj_SAB_Attack_Shield_Deactive"},MP_OBJ_SAB_DEF_SHIELD_DEACTIVE={name="MP_OBJ_SAB_DEF_SHIELD_DEACTIVE",debug="mgo_ui_obj_SAB_Defend_Shield_Deactive",langTag="mgo_ui_obj_SAB_Defend_Shield_Deactive"},MP_OBJ_SAB_ATK_TERMINAL={name="MP_OBJ_SAB_ATK_TERMINAL",debug="mgo_ui_obj_SAB_Attack_Terminal",langTag="mgo_ui_obj_SAB_Attack_Terminal"},MP_OBJ_SAB_DEF_TERMINAL={name="MP_OBJ_SAB_DEF_TERMINAL",debug="mgo_ui_obj_SAB_Defend_Terminal",langTag="mgo_ui_obj_SAB_Defend_Terminal"},MP_OBJ_SAB_ATK_SHIELD_ACTIVE={name="MP_OBJ_SAB_ATK_SHIELD_ACTIVE",debug="mgo_ui_obj_SAB_Attack_Shield_Active",langTag="mgo_ui_obj_SAB_Attack_Shield_Active"},MP_OBJ_SAB_DEF_SHIELD_ACTIVE={name="MP_OBJ_SAB_DEF_SHIELD_ACTIVE",debug="mgo_ui_obj_SAB_Defend_Shield_Active",langTag="mgo_ui_obj_SAB_Defend_Shield_Active"},MP_OBJ_NOTIFY_NEAREND={name="MP_OBJ_NOTIFY_NEAREND",debug="Round Ending Soon",langTag="mgo_ui_obj_roundend_soon"},MP_OBJ_NOTIFY_WON={name="MP_OBJ_NOTIFY_WON",debug="Your team won!",langTag="mgo_ui_obj_teamwon"},MP_OBJ_NOTIFY_LOST={name="MP_OBJ_NOTIFY_LOST",debug="Your team lost.",langTag="mgo_ui_obj_teamlost"},MP_OBJ_NOTIFY_WON_ENEMY_ABANDONED={name="MP_OBJ_NOTIFY_WON_ENEMY_ABANDONED",debug="The enemy team has abandoned the match.",langTag="mgo_log_enemy_team_abandon"}}
e.ObjectiveSounds={NONE="",MP_SFX_TDM_INITIAL="sfx_s_mission_qualify",MP_SFX_TDM_OVERTIME="sfx_s_sideops_sted",MP_SFX_DOM_INITIAL="sfx_s_mission_qualify",MP_SFX_DOM_ENE_CAP="sfx_enemy_captured_point",MP_SFX_DOM_ENE_CAP_ALL="sfx_enemy_captured_all_points",MP_SFX_DOM_ALY_CAP="sfx_friendly_captured_point",MP_SFX_DOM_ALY_CAP_ALL="sfx_friendly_captured_all_points",MP_SFX_DOM_NEUTRALIZE="sfx_point_neutralized",MP_SFX_TSNE_INITIAL="sfx_s_mission_qualify",MP_SFX_TSNE_GOOD="sfx_friendly_captured_point",MP_SFX_TSNE_BAD="sfx_enemy_captured_point",MP_SFX_TSNE_GOOD_END="",MP_SFX_TSNE_BAD_END="",MP_SFX_TSNE_PICKUP="sfx_s_fob_emergency",MP_SFX_TSNE_DROPPED="sfx_UI_Disc_Dropped",MP_SFX_TSNE_CAPTURE="sfx_UI_Uploading_Complete_Sting",MP_SFX_SAB_PHASE2="sfx_UI_Phase_Doc_2_Terminal",MP_SFX_SAB_PHASE3="sfx_UI_Phase_Term_2_Missile",MP_SFX_SAB_SCAN="sfx_UI_Document_Scan_Complete",MP_SFX_SAB_BUZZER="sfx_s_terminal_buzzer"}
e.NotificationSounds={NONE="",MP_SFX_NOTIFY="sfx_s_title_slct_mission",MP_SFX_CONTRACT_GIVEN="sfx_s_title_slct_mission",MP_SFX_CONTRACT_PROGRESS="sfx_s_title_slct_mission",MP_SFX_CONTRACT_COMPLETE="sfx_stinger_subobjective"}
function e.DBEUG_LookupObjectiveMessage(_,i)
for e,p in pairs(e.ObjectiveMessage)do
local e=_:DEBUG_GetStringId(e)
if(i==e)then
return p.debug
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
local _=MpRulesetManager.HasMapBlock()
local p=true
if _ then
p=MpRulesetManager.IsMapBlockLoaded()
end
local i=MpRulesetManager.HasDynamicBlock()
local _=true
if i then
_=MpRulesetManager.IsDynamicBlockLoaded()
end
return(e and p)and _
end
function e.GetActivePlayerSessionIndicesOnTeam(p,_)
local e={}
local i=p:GetActivePlayerCountByTeamIndex(_)
for i=0,i-1 do
local p=p:GetPlayerFromTeamIndex(_,i)
if p~=nil then
local p=p.sessionIndex
table.insert(e,p)
end
end
return e
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
function e.TryNotifyBuddyChange(p,e,_,i)
if SpawnHelpers.initialTeamAssignmentHasHappened==true and p.currentState~="RULESET_STATE_BRIEFING"then
TppNetworkUtil.SyncedExecuteSessionIndex(_,"Utils","announceBuddyLink",e)
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
function e.SetFlag(e,p)
local p=2^(p-1)
local _=e%(p*2)
if _>=p then
return e
end
return e+p
end
function e.ClearFlag(_,p)
local p=2^(p-1)
local i=_%(p*2)
if i>=p then
return _-p
end
return _
end
e.SpecialRoleLoadouts={{DisplayName="mgo_default_loadout_snakeex",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_ar00_v00,parts={TppEquip.MO_None,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_50102},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg04_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Grenade}},handConfig={{id=TppEquip.EQP_HAND_KILL_ROCKET}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_snakenonlethal",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr02_v00,parts={TppEquip.MO_30102,TppEquip.ST_60304,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SmokeGrenade},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_DirtyMag}},handConfig={{id=TppEquip.EQP_HAND_STUNARM}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_snakecamo",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_C4},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_Magazine}},handConfig={{id=TppEquip.EQP_HAND_STUN_ROCKET}},itemConfig={{id=TppEquip.EQP_IT_MGO_PersonalCamo},{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_snakeload",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_mg00_v00,parts={TppEquip.MO_30205,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg00_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_FultonTrap},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_MolotovCocktail}},handConfig={{id=TppEquip.EQP_HAND_KILL_ROCKET}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_snakeex",tsne_only=true,attackerLoadout=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_ar00_v00,parts={TppEquip.MO_None,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_50102},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg04_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Grenade}},handConfig={{id=TppEquip.EQP_HAND_KILL_ROCKET}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_snakenonlethal",tsne_only=true,attackerLoadout=true,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr02_v00,parts={TppEquip.MO_30102,TppEquip.ST_60304,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SmokeGrenade},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_DirtyMag}},handConfig={{id=TppEquip.EQP_HAND_STUNARM}},itemConfig={{id=TppEquip.EQP_IT_CBox},{id=TppEquip.EQP_None},{id=TppEquip.EQP_IT_MGO_StealthCamo}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_snakecamo",tsne_only=true,attackerLoadout=true,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_StunGrenade},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_Magazine}},handConfig={{id=TppEquip.EQP_HAND_STUN_ROCKET}},itemConfig={{id=TppEquip.EQP_IT_CBox},{id=TppEquip.EQP_None},{id=TppEquip.EQP_IT_MGO_StealthCamo}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_snakeload",tsne_only=true,attackerLoadout=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_SNAKE,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_mg00_v00,parts={TppEquip.MO_30205,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg00_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Claymore},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_MolotovCocktail}},handConfig={{id=TppEquip.EQP_HAND_KILL_ROCKET}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Snake_4"}}},{DisplayName="mgo_default_loadout_ocegun",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg03_v01,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_MolotovCocktail}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_ocenonlethal",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_sg02_v00,parts={TppEquip.MO_40104,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_30304},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SleepingGusMine},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_StunGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_ocelethal",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_sg01_v00,parts={TppEquip.MO_None,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg03_v00,parts={TppEquip.MO_10026,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_DirtyMag_G01},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_Claymore}},itemConfig={{id=TppEquip.EQP_IT_Nvg},{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_oceshield",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_SLD_SV},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg03_v01,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_TagGrenade},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_FultonTrap}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_ocegun",tsne_only=true,attackerLoadout=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg03_v01,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_MolotovCocktail}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_ocenonlethal",tsne_only=true,attackerLoadout=true,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_sg02_v00,parts={TppEquip.MO_40104,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_30304},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SleepingGusMine},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_StunGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox},{id=TppEquip.EQP_None},{id=TppEquip.EQP_IT_MGO_StealthCamo}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_ocelethal",tsne_only=true,attackerLoadout=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_WP_pvp_sg01_v00,parts={TppEquip.MO_None,TppEquip.ST_30114,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg03_v00,parts={TppEquip.MO_10026,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_C4},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_Claymore}},itemConfig={{id=TppEquip.EQP_IT_CBox},{id=TppEquip.EQP_IT_Nvg}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_oceshield",tsne_only=true,attackerLoadout=true,SpecialRole=MpRulesetManager.SPECIAL_ROLE_OCELOT,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_SLD_SV},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_TagGrenade},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,id=TppEquip.EQP_SWP_FultonTrap}},itemConfig={{id=TppEquip.EQP_IT_CBox},{id=TppEquip.EQP_None},{id=TppEquip.EQP_IT_MGO_StealthCamo}},skillConfig={{id="Skill_Ocelot_4"}}},{DisplayName="mgo_default_loadout_quietlethal",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_QUIET,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr00_v00,parts={TppEquip.MO_30102,TppEquip.ST_60304,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg04_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Grenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Quiet_4"}}},{DisplayName="mgo_default_loadout_quietnonlethal",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_QUIET,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr02_v00,parts={TppEquip.MO_30102,TppEquip.ST_60304,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_StunGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Quiet_4"}}},{DisplayName="mgo_default_loadout_quietassassin",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_QUIET,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr01_v00,parts={TppEquip.MO_30102,TppEquip.ST_60304,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Grenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Quiet_4"}}},{DisplayName="mgo_default_loadout_quietsneak",tsne_only=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_QUIET,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr02_v00,parts={TppEquip.MO_30102,TppEquip.ST_60304,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg00_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SmokeGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Quiet_4"}}},{DisplayName="mgo_default_loadout_quietlethal",tsne_only=true,attackerLoadout=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_QUIET,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr00_v00,parts={TppEquip.MO_30102,TppEquip.ST_60304,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg04_v00,parts={TppEquip.MO_None,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_20004,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Grenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Quiet_4"}}},{DisplayName="mgo_default_loadout_quietnonlethal",tsne_only=true,attackerLoadout=true,SpecialRole=MpRulesetManager.SPECIAL_ROLE_QUIET,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr02_v00,parts={TppEquip.MO_30102,TppEquip.ST_60304,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_StunGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox},{id=TppEquip.EQP_None},{id=TppEquip.EQP_IT_MGO_StealthCamo}},skillConfig={{id="Skill_Quiet_4"}}},{DisplayName="mgo_default_loadout_quietassassin",tsne_only=true,attackerLoadout=false,SpecialRole=MpRulesetManager.SPECIAL_ROLE_QUIET,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr01_v00,parts={TppEquip.MO_30102,TppEquip.ST_60304,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg00_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_Grenade}},itemConfig={{id=TppEquip.EQP_IT_CBox}},skillConfig={{id="Skill_Quiet_4"}}},{DisplayName="mgo_default_loadout_quietsneak",tsne_only=true,attackerLoadout=true,SpecialRole=MpRulesetManager.SPECIAL_ROLE_QUIET,weaponsConfig={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,id=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.PRIMARY_BACK,id=TppEquip.EQP_WP_pvp_sr02_v00,parts={TppEquip.MO_30102,TppEquip.ST_60304,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LS_30104,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}},{slot=TppDefine.WEAPONSLOT.SECONDARY,id=TppEquip.EQP_WP_pvp_hg01_v00,parts={TppEquip.MO_10101,TppEquip.ST_None,TppEquip.ST_None,TppEquip.LT_None,TppEquip.LT_None,TppEquip.UB_None},color={TppEquip.WEAPON_PAINT_DEFAULT,0}}},supportWeaponsConfig={{slot=TppDefine.WEAPONSLOT.SUPPORT_0,id=TppEquip.EQP_SWP_SmokeGrenade}},itemConfig={{id=TppEquip.EQP_IT_CBox},{id=TppEquip.EQP_None},{id=TppEquip.EQP_IT_MGO_StealthCamo}},skillConfig={{id="Skill_Quiet_4"}}}}
function e.GetSpecialRoleLoadouts(_)
local p={}
local i=MpRulesetManager.GetActiveRuleset():GetLocalPlayerTeam()
if e.TeamsneakId==vars.rulesetId or e.TeamsneakBaseId==vars.rulesetId then
for n=1,#e.SpecialRoleLoadouts do
local e=e.SpecialRoleLoadouts[n]
if e.SpecialRole==_ and e.tsne_only then
if(TeamSneak.attacker==i and e.attackerLoadout)or(TeamSneak.attacker~=i and not e.attackerLoadout)then
table.insert(p,e)
end
end
end
else
for i=1,#e.SpecialRoleLoadouts do
local e=e.SpecialRoleLoadouts[i]
if e.SpecialRole==_ and not e.tsne_only then
table.insert(p,e)
end
end
end
return{loadouts=p}
end
function e.AssignSpecialRoles(e,_)
if 0==vars.specialRole then
return
end
local e=_:GetAllActivePlayers().array
local i={{},{}}
for p=1,#e do
local p=e[p]_:SetSpecialRole(p.sessionIndex,MpRulesetManager.SPECIAL_ROLE_NONE)
if not _:IsDedicatedHost(p.sessionIndex)then
local e=p.teamIndex
if e==0 or e==1 then
e=e+1
table.insert(i[e],p)
end
end
end
local e={}
local n=vars.uniqueCharacterSelect%16
local p=(vars.uniqueCharacterSelect-(vars.uniqueCharacterSelect%16))/16
table.insert(e,n)table.insert(e,p)
for p=1,2 do
local n=e[p]
local p=i[p]
local e=#p
if e>0 then
local e=math.random(e)
local e=p[e]_:SetSpecialRole(e.sessionIndex,n)
end
end
end
function e.TryReassignSpecialRole(i,p,e,o)
if SpawnHelpers.initialTeamAssignmentHasHappened==false then
return
end
local e=p:GetAllActivePlayers().array
if#e==1 then
SpawnHelpers.Reset()
return
end
if 0==vars.specialRole then
return
end
local _={}
local n=vars.uniqueCharacterSelect%16
local T=(vars.uniqueCharacterSelect-(vars.uniqueCharacterSelect%16))/16
local n={n,T}
local n=n[i+1]
for n=1,#e do
local e=e[n]
if e.teamIndex==i and e~=o then
if not p:IsDedicatedHost(e.sessionIndex)then
local p=p:GetSpecialRole(e.sessionIndex)
if p~=MpRulesetManager.SPECIAL_ROLE_NONE then
return
end
table.insert(_,e)
end
end
end
local e=#_
if e>0 then
local e=math.random(e)
local e=_[e]p:SetSpecialRole(e.sessionIndex,n)
end
end
function e.StopWeatherClock()
end
function e.SerializeEvent(e,o,i,_,p)
local n=e:SerializeBoolean(p~=nil)
local o=e:SerializeInteger(o)
local i=e:SerializeInteger(i)
local T=e:SerializeInteger(_)
local _=-1
if n then
_=e:SerializeInteger(p)
end
return o,i,T,_
end
function e.POIinitialize(_,e)
local p=_:GetTransform()
local p=p:GetTranslation()
local _=_:GetGameObjectId()
e.gameObjectId=_:GetId()
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
function e.DetermineMatchWinner(T,i,o,n,_)
local p=0
SpawnHelpers.Reset()
if o==i then
p=i
elseif n>_ then
p=e.Team.SOLID
elseif n<_ then
p=e.Team.LIQUID
else
local e=e.BreakTie(T,false)
if e==0 then
p=1
else
p=0
end
end
return p
end
function e.BreakTie(n,a)
local T
local o=-1
local _
local i=-1
local p
local e=n:GetAllActivePlayers().array
for p=1,#e do
local e=e[p]
if not n:IsDedicatedHost(e.sessionIndex)then
local p
if a==true then
p=n:GetStatByPlayerIndex(e.sessionIndex,MgoStat.STAT_TEAM_POINTS)
else
p=n:GetTotalStatByPlayerIndex(e.sessionIndex,MgoStat.STAT_TEAM_POINTS)
end
if p>o then
o=p
T=e.sessionIndex
_=e.teamIndex
i=-1
elseif p==o then
if _~=e.teamIndex then
i=e.sessionIndex
end
end
end
end
if i==-1 then
if _==Utils.Team.SOLID then
p=Utils.Team.LIQUID
else
p=Utils.Team.SOLID
end
else
if T<i then
if _==Utils.Team.SOLID then
p=Utils.Team.LIQUID
else
p=Utils.Team.SOLID
end
else
if _==Utils.Team.SOLID then
p=Utils.Team.SOLID
else
p=Utils.Team.LIQUID
end
end
end
return p
end
function e.AwardGearPointsToAllPlayers(p,n)
for _,i in pairs(SpawnHelpers.teamRoster)do
if not p:IsDedicatedHost(_)then
if i==n then
p:IncrementStatByPlayerIndex(_,MgoStat.STAT_GEAR_POINTS,e.GEARPOINTS.WINNER)
else
p:IncrementStatByPlayerIndex(_,MgoStat.STAT_GEAR_POINTS,e.GEARPOINTS.LOSER)
end
end
end
end
function e.InitTutorial()
e.TutorialPhase=0
e.TutorialTime=0
end
function e.DrawTutorial(p,_)
local i=p.currentState
if vars.gamePlayTutorialCount>=10 then
return
end
if _~=1 then
return
end
if i~="RULESET_STATE_ROUND_REGULAR_PLAY"then
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
function e.SetStaminaConfig(p)
local e={Stamina={UnconsciousStaminaRegenRate=.35,BasicActionStaminaRegenRate=1,ComplexActionStaminaRegenRate=1,ButtonMashModifier=.75}}p:ReloadRulesetConfig(e)
end
return e
