local a={}
local e=EnemyFova.MAX_REALIZED_COUNT
local n=0
local l=1
local d=2
local c=3
local i=4
local p=5
local r=6
local T="/Assets/tpp/parts/chara/prs/prs2_main0_def_v00.parts"
local f="/Assets/tpp/parts/chara/prs/prs5_main0_def_v00.parts"
local F="/Assets/tpp/parts/chara/prs/prs3_main0_def_v00.parts"
local y="/Assets/tpp/parts/chara/prs/prs6_main0_def_v00.parts"
local _="/Assets/tpp/parts/chara/dds/dds5_main0_def_v00.parts"
local m={[10010]=1,[10020]=1,[10030]=1,[10054]=1,[11054]=1,[10070]=1,[10080]=1,[11080]=1,[10100]=1,[10110]=1,[10120]=1,[10130]=1,[11130]=1,[10140]=1,[11140]=1,[10150]=1,[10200]=1,[11200]=1,[10280]=1,[30010]=1,[30020]=1}
local s={[10081]={TppDefine.AFR_ARMOR.TYPE_RC},[10082]={TppDefine.AFR_ARMOR.TYPE_CFA},[11082]={TppDefine.AFR_ARMOR.TYPE_CFA},[10085]={TppDefine.AFR_ARMOR.TYPE_RC},[11085]={TppDefine.AFR_ARMOR.TYPE_RC},[10086]={TppDefine.AFR_ARMOR.TYPE_CFA},[10090]={TppDefine.AFR_ARMOR.TYPE_CFA},[11090]={TppDefine.AFR_ARMOR.TYPE_CFA},[10091]={TppDefine.AFR_ARMOR.TYPE_CFA},[11091]={TppDefine.AFR_ARMOR.TYPE_CFA},[10093]={TppDefine.AFR_ARMOR.TYPE_ZRS},[10121]={TppDefine.AFR_ARMOR.TYPE_CFA},[11121]={TppDefine.AFR_ARMOR.TYPE_CFA},[10171]={TppDefine.AFR_ARMOR.TYPE_CFA},[11171]={TppDefine.AFR_ARMOR.TYPE_CFA},[10195]={TppDefine.AFR_ARMOR.TYPE_CFA},[11195]={TppDefine.AFR_ARMOR.TYPE_CFA},[10211]={TppDefine.AFR_ARMOR.TYPE_CFA},[11211]={TppDefine.AFR_ARMOR.TYPE_CFA}}
local t={[10020]={count=0},[10030]={count=0},[10033]={count=1,lang=d},[11033]={count=1,lang=d},[10036]={count=0},[11036]={count=0},[10040]={count=1,lang=i},[10041]={count=2,lang=d},[11041]={count=2,lang=d},[10043]={count=2,lang=i},[11043]={count=2,lang=i},[10044]={count=1,lang=d,overlap=true},[11044]={count=1,lang=d,overlap=true},[10045]={count=2,lang=d},[10050]={count=0},[11050]={count=0},[10052]={count=6,lang=r,overlap=true,ignoreList={40,41,42,43,44,45,46,47,48,49},modelNum=5},[11052]={count=6,lang=r,overlap=true,ignoreList={40,41,42,43,44,45,46,47,48,49},modelNum=5},[10054]={count=4,lang=l,overlap=true},[11054]={count=4,lang=l,overlap=true},[10070]={count=0},[10080]={count=0},[11080]={count=0},[10081]={count=0},[10082]={count=2,lang=p,overlap=true},[11082]={count=2,lang=p,overlap=true},[10085]={count=0},[11085]={count=0},[10086]={count=0},[10090]={count=0},[11090]={count=0},[10091]={count=1,lang=l,useHair=true,overlap=true},[11091]={count=1,lang=l,useHair=true,overlap=true},[10093]={count=0},[10100]={count=0},[10110]={count=0},[10115]={count=0},[11115]={count=0},[10120]={count=1,lang=l,overlap=true},[10121]={count=0},[11121]={count=0},[10130]={count=0},[11130]={count=0},[10140]={count=0},[11140]={count=0},[10145]={count=0},[10150]={count=0},[10151]={count=0},[11151]={count=0},[10171]={count=0},[11171]={count=0},[10156]={count=1,lang=d,overlap=true},[10195]={count=1,lang=p},[11195]={count=1,lang=p},[10200]={count=1,lang=p},[11200]={count=1,lang=p},[10240]={count=0},[10211]={count=4,lang=c,overlap=true},[11211]={count=4,lang=i,overlap=true},[10260]={count=0},[10280]={count=0}}a.S10030_FaceIdList={78,200,283,30,88,124,138,169,213,222,243,264,293,322,343}a.S10030_useBalaclavaNum=3
a.S10240_FemaleFaceIdList={394,351,373,456,463,455,511,502}a.S10240_MaleFaceIdList={195,144,214,6,217,83,273,60,87,71,256,201,290,178,102,255,293,165,85,18,228,12,65,134,31,132,161,342,107,274,184,226,153,247,344,242,56,183,54,126,223}
local n={}
local function o(a)
function a:case(a,n)
local e=self[a]or self.default
if e then
e(a,n)
end
end
return a
end
function a.IsNotRequiredArmorSoldier(e)
if m[e]~=nil then
return true
end
return false
end
function a.CanUseArmorType(n,t)
local e={PF_A=TppDefine.AFR_ARMOR.TYPE_CFA,PF_B=TppDefine.AFR_ARMOR.TYPE_ZRS,PF_C=TppDefine.AFR_ARMOR.TYPE_RC}
local e=e[t]
if e==nil then
return true
end
local a=a.GetArmorTypeTable(n)
for n,a in ipairs(a)do
if a==e then
return true
end
end
return false
end
function a.GetHostageCountAtMissionId(e)
local a=0
if t[e]~=nil then
local e=t[e]
if e~=nil then
if e.count~=nil then
return e.count
else
return a
end
else
return a
end
end
return a
end
function a.GetHostageLangAtMissionId(e)
local a=l
if t[e]~=nil then
local e=t[e]
if e~=nil then
if e.lang~=nil then
return e.lang
end
end
end
return a
end
function a.GetHostageUseHairAtMissionId(e)
local a=false
if t[e]~=nil then
local e=t[e]
if e~=nil then
if e.useHair~=nil then
return e.useHair
end
end
end
return a
end
function a.GetHostageIsFaceModelOverlap(e)
local a=false
if t[e]~=nil then
local e=t[e]
if e~=nil then
if e.overlap~=nil then
return e.overlap
end
end
end
return a
end
function a.GetHostageFaceModelCount(e)
local a=2
if t[e]~=nil then
local e=t[e]
if e~=nil then
if e.modelNum~=nil then
return e.modelNum
end
end
end
return a
end
function a.GetHostageIgnoreFaceList(e)
local a={}
if t[e]~=nil then
local e=t[e]
if e~=nil then
if e.ignoreList~=nil then
return e.ignoreList
end
end
end
return a
end
function a.GetArmorTypeTable(e)
if a.IsNotRequiredArmorSoldier(e)then
return{}
end
if not TppLocation.IsMiddleAfrica()then
return{}
end
local a={TppDefine.AFR_ARMOR.TYPE_ZRS}
if s[e]~=nil then
local e=s[e]
if e~=nil then
return e
end
end
return a
end
function a.SetHostageFaceTable(o)
local s=a.GetHostageCountAtMissionId(o)
local t=a.GetHostageLangAtMissionId(o)
local f=0
if s>0 then
local n={}
if t==l then
table.insert(n,3)
local e=bit.rshift(gvars.hosface_groupNumber,8)%100
if e<40 then
table.insert(n,0)
end
elseif t==d then
table.insert(n,0)
elseif t==p then
table.insert(n,2)
local e=bit.rshift(gvars.hosface_groupNumber,8)%100
if e<10 then
table.insert(n,0)
end
elseif t==r then
table.insert(n,0)table.insert(n,1)f=1
elseif t==i then
table.insert(n,1)
elseif t==c then
table.insert(n,2)
else
if TppLocation.IsAfghan()then
table.insert(n,0)
elseif TppLocation.IsMiddleAfrica()then
table.insert(n,2)
elseif TppLocation.IsMotherBase()then
table.insert(n,0)
elseif TppLocation.IsMBQF()then
table.insert(n,0)
elseif TppLocation.IsCyprus()then
table.insert(n,0)
end
end
local T=a.GetHostageIsFaceModelOverlap(o)
local r=a.GetHostageIgnoreFaceList(o)
local _=a.GetHostageFaceModelCount(o)
local r=TppSoldierFace.CreateFaceTable{race=n,needCount=s,maxUsedFovaCount=_,faceModelOverlap=T,ignoreFaceList=r,raceHalfMode=f}
if r~=nil then
local d={}
local t={}
local n=#r
local a=e
if s<=n then
a=1
end
if(n>0)and(n<s)then
a=math.floor(s/n)+1
end
if a<=0 then
a=e
end
for n,e in ipairs(r)do
table.insert(d,{e,0,0,a})table.insert(t,e)
end
local e=#t
if e>0 then
local e=gvars.hosface_groupNumber
TppSoldierFace.SetPoolTable{hostageFace=t,randomSeed=e}
end
TppSoldierFace.OverwriteMissionFovaData{face=d}
else
local a={}
local n=gvars.hosface_groupNumber%9
if t==l then
table.insert(a,{25+n,0,0,e})
elseif t==d then
table.insert(a,{100+n,0,0,e})
elseif t==p then
table.insert(a,{210+n,0,0,e})
elseif t==i then
table.insert(a,{9+n,0,0,e})
elseif t==c then
table.insert(a,{260+n,0,0,e})
else
table.insert(a,{55+n,0,0,e})
end
TppSoldierFace.OverwriteMissionFovaData{face=a}
end
local e=a.GetHostageUseHairAtMissionId(o)
if e==true then
TppSoldierFace.SetHostageUseHairFova(true)
end
end
end
function a.GetFaceGroupTableAtGroupType(e)
local t=TppEnemyFaceGroup.GetFaceGroupTable(e)
local a={}
local e=EnemyFova.MAX_REALIZED_COUNT
for t,n in pairs(t)do
table.insert(a,{n,e,e,0})
end
return a
end
n[10200]=function(d,t)a.SetHostageFaceTable(t)
local e={{TppEnemyBodyId.chd0_v00,e},{TppEnemyBodyId.chd0_v01,e},{TppEnemyBodyId.chd0_v02,e},{TppEnemyBodyId.chd0_v03,e},{TppEnemyBodyId.chd0_v04,e},{TppEnemyBodyId.chd0_v05,e},{TppEnemyBodyId.chd0_v06,e},{TppEnemyBodyId.chd0_v07,e},{TppEnemyBodyId.chd0_v08,e},{TppEnemyBodyId.chd0_v09,e},{TppEnemyBodyId.chd0_v10,e},{TppEnemyBodyId.chd0_v11,e},{TppEnemyBodyId.prs5_main0_v00,e}}
TppSoldierFace.OverwriteMissionFovaData{body=e}
TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs5_main0_v00}}
TppHostage2.SetDefaultBodyFovaId{parts=f,bodyId=TppEnemyBodyId.prs5_main0_v00}
end
n[11200]=n[10200]n[10120]=function(d,t)a.SetHostageFaceTable(t)
local e={{TppEnemyBodyId.chd0_v00,e},{TppEnemyBodyId.chd0_v01,e},{TppEnemyBodyId.chd0_v02,e},{TppEnemyBodyId.chd0_v03,e},{TppEnemyBodyId.chd0_v04,e},{TppEnemyBodyId.chd0_v05,e},{TppEnemyBodyId.chd0_v06,e},{TppEnemyBodyId.chd0_v07,e},{TppEnemyBodyId.chd0_v08,e},{TppEnemyBodyId.chd0_v09,e},{TppEnemyBodyId.chd0_v10,e},{TppEnemyBodyId.chd0_v11,e},{TppEnemyBodyId.prs5_main0_v00,e}}
TppSoldierFace.OverwriteMissionFovaData{body=e}
TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs5_main0_v00}}
TppHostage2.SetDefaultBodyFovaId{parts=f,bodyId=TppEnemyBodyId.prs5_main0_v00}
end
n[10040]=function(a,e)
local a=o(n)a:case("Afghan",e)
TppSoldierFace.SetUseZombieFova{enabled=true}
end
n[10045]=function(e,a)
local e=o(n)e:case("Afghan",a)
local e={}
for a=0,9 do
table.insert(e,a)
end
for a=20,39 do
table.insert(e,a)
end
for a=50,81 do
table.insert(e,a)
end
for a=93,199 do
table.insert(e,a)
end
local a=#e
local a=gvars.hosface_groupNumber%a
local e=e[a]
local a={{TppEnemyFaceId.svs_balaclava,1,1,0},{e,1,1,0}}
TppSoldierFace.OverwriteMissionFovaData{face=a,additionalMode=true}
local a=274
TppSoldierFace.SetSpecialFovaId{face={e},body={a}}
local e={{a,1}}
TppSoldierFace.OverwriteMissionFovaData{body=e,additionalMode=true}
end
n[10052]=function(e,a)
local e=o(n)e:case("Afghan",a)
TppSoldierFace.SetSplitRaceForHostageRandomFaceId{enabled=true}
end
n[11052]=n[10052]n[10090]=function(a,e)
local a=o(n)a:case("Africa",e)
TppSoldierFace.SetUseZombieFova{enabled=true}
end
n[11090]=n[10090]n[10091]=function(e,a)
local e=o(n)e:case("Africa",a)
local e={}
for a=0,9 do
table.insert(e,a)
end
for a=20,39 do
table.insert(e,a)
end
for a=50,81 do
table.insert(e,a)
end
for a=93,199 do
table.insert(e,a)
end
local t=#e
local d=gvars.solface_groupNumber%t
local a=gvars.hosface_groupNumber%t
if d==a then
a=(a+1)%t
end
local d=e[d]
local t=e[a]
local e={{TppEnemyFaceId.pfs_balaclava,2,2,0},{d,1,1,0},{t,1,1,0}}
TppSoldierFace.OverwriteMissionFovaData{face=e,additionalMode=true}
local a=265
local e=266
TppSoldierFace.SetSpecialFovaId{face={d,t},body={a,e}}
local e={{a,1},{e,1}}
TppSoldierFace.OverwriteMissionFovaData{body=e,additionalMode=true}
end
n[11091]=n[10091]n[10080]=function(a,t)
local a=o(n)a:case("Africa",t)
if TppPackList.IsMissionPackLabel"afterPumpStopDemo"then
else
TppSoldier2.SetExtendPartsInfo{type=2,path="/Assets/tpp/parts/chara/chd/chd0_main0_def_v00.parts"}
local e={{TppEnemyBodyId.chd0_v00,e},{TppEnemyBodyId.chd0_v01,e},{TppEnemyBodyId.chd0_v02,e},{TppEnemyBodyId.chd0_v03,e},{TppEnemyBodyId.chd0_v04,e},{TppEnemyBodyId.chd0_v05,e},{TppEnemyBodyId.chd0_v06,e},{TppEnemyBodyId.chd0_v07,e},{TppEnemyBodyId.chd0_v08,e},{TppEnemyBodyId.chd0_v09,e},{TppEnemyBodyId.chd0_v10,e},{TppEnemyBodyId.chd0_v11,e}}
TppSoldierFace.OverwriteMissionFovaData{body=e}
end
end
n[11080]=n[10080]n[10115]=function(a,a)
local a={}
for e=0,9 do
table.insert(a,e)
end
for e=20,39 do
table.insert(a,e)
end
for e=50,81 do
table.insert(a,e)
end
for e=93,199 do
table.insert(a,e)
end
local t=gvars.hosface_groupNumber
TppSoldierFace.SetPoolTable{face=a,randomSeed=t}
TppSoldierFace.SetSoldierNoFaceResourceMode(true)
TppSoldierFace.SetUseFaceIdListMode{enabled=true,staffCheck=true}
local e={{140,e},{141,e},{TppEnemyBodyId.dds5_main0_v00,e}}
TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.dds5_main0_v00}}
TppHostage2.SetDefaultBodyFovaId{parts=_,bodyId=TppEnemyBodyId.dds5_main0_v00}
TppSoldierFace.OverwriteMissionFovaData{body=e}
end
n[11115]=n[10115]n[10130]=function(a,e)
local a=o(n)a:case("Africa",e)
TppSoldierFace.SetUseZombieFova{enabled=true}
end
n[11130]=n[10130]n[10140]=function(e,a)
local e=o(n)e:case("Africa",a)
TppSoldierFace.SetUseZombieFova{enabled=true}
end
n[11140]=n[10140]n[10150]=function(a,a)
local a={}
for e=0,9 do
table.insert(a,e)
end
for e=20,39 do
table.insert(a,e)
end
for e=50,81 do
table.insert(a,e)
end
for e=93,199 do
table.insert(a,e)
end
local t=gvars.hosface_groupNumber
TppSoldierFace.SetPoolTable{face=a,randomSeed=t}
TppSoldierFace.SetSoldierNoFaceResourceMode(true)
TppSoldierFace.SetUseFaceIdListMode{enabled=true,staffCheck=true}
local e={{TppEnemyBodyId.wss4_main0_v00,e}}
TppSoldierFace.OverwriteMissionFovaData{body=e}
end
n[10151]=function(e,e)
end
n[11151]=n[10151]n[30010]=function(a,t)
local a=o(n)a:case("Afghan",t)
TppSoldierFace.SetUseZombieFova{enabled=true}
local e={{TppEnemyBodyId.prs3_main0_v00,e}}
TppSoldierFace.OverwriteMissionFovaData{body=e}
TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs3_main0_v00}}
TppHostage2.SetDefaultBodyFovaId{parts=F,bodyId=TppEnemyBodyId.prs3_main0_v00}
end
n[30020]=function(t,a)
local n=o(n)n:case("Africa",a)
TppSoldierFace.SetUseZombieFova{enabled=true}
local e={{TppEnemyBodyId.prs6_main0_v00,e}}
TppSoldierFace.OverwriteMissionFovaData{body=e}
TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs6_main0_v00}}
TppHostage2.SetDefaultBodyFovaId{parts=y,bodyId=TppEnemyBodyId.prs6_main0_v00}
end
function n.Afghan(n,t)
if t==10010 then
return
end
local d=0
if TppSoldierFace.IsMoreVariationMode~=nil then
d=TppSoldierFace.IsMoreVariationMode()
end
local o=15
local n=gvars.solface_groupNumber%o
local l=TppEnemyFaceGroupId.AFGAN_GRP_00+n
local l=a.GetFaceGroupTableAtGroupType(l)
TppSoldierFace.OverwriteMissionFovaData{face=l}
if d>0 then
for e=1,2 do
n=n+2
local e=(n%o)*2
local e=TppEnemyFaceGroupId.AFGAN_GRP_00+(e)
local e=a.GetFaceGroupTableAtGroupType(e)
TppSoldierFace.OverwriteMissionFovaData{face=e}
end
end
TppSoldierFace.SetUseFaceIdListMode{enabled=true,staffCheck=true}a.SetHostageFaceTable(t)
local n={{0,e},{1,e},{2,e},{5,e},{6,e},{7,e},{10,e},{11,e},{20,e},{21,e},{22,e},{25,e},{26,e},{27,e},{30,e},{31,e},{TppEnemyBodyId.prs2_main0_v00,e}}
if not a.IsNotRequiredArmorSoldier(t)then
local e={TppEnemyBodyId.sva0_v00_a,e}table.insert(n,e)
end
TppSoldierFace.OverwriteMissionFovaData{body=n}
TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs2_main0_v00}}
TppHostage2.SetDefaultBodyFovaId{parts=T,bodyId=TppEnemyBodyId.prs2_main0_v00}
end
function n.Africa(n,p)
local l=0
if TppSoldierFace.IsMoreVariationMode~=nil then
l=TppSoldierFace.IsMoreVariationMode()
end
local t=30
local n=gvars.solface_groupNumber
local d=(n%t)*2
local o=TppEnemyFaceGroupId.AFRICA_GRP000_B+(d)
local i=a.GetFaceGroupTableAtGroupType(o)
TppSoldierFace.OverwriteMissionFovaData{face=i}
if l>0 then
for e=1,2 do
n=n+2
local e=(n%t)*2
local e=TppEnemyFaceGroupId.AFRICA_GRP000_B+(e)
local e=a.GetFaceGroupTableAtGroupType(e)
TppSoldierFace.OverwriteMissionFovaData{face=e}
end
end
t=30
n=gvars.solface_groupNumber
d=(n%t)*2
o=TppEnemyFaceGroupId.AFRICA_GRP000_W+(d)
local d=a.GetFaceGroupTableAtGroupType(o)
TppSoldierFace.OverwriteMissionFovaData{face=d}
if l>0 then
for e=1,2 do
n=n+2
local e=(n%t)*2
local e=TppEnemyFaceGroupId.AFRICA_GRP000_W+(e)
local e=a.GetFaceGroupTableAtGroupType(e)
TppSoldierFace.OverwriteMissionFovaData{face=e}
end
end
a.SetHostageFaceTable(p)
TppSoldierFace.SetUseFaceIdListMode{enabled=true,staffCheck=true,raceSplit=60}
local n={{50,e},{51,e},{55,e},{60,e},{61,e},{70,e},{71,e},{75,e},{80,e},{81,e},{90,e},{91,e},{95,e},{100,e},{101,e},{TppEnemyBodyId.prs5_main0_v00,e}}
local a=a.GetArmorTypeTable(p)
if a~=nil then
local t=#a
if t>0 then
for t,a in ipairs(a)do
if a==TppDefine.AFR_ARMOR.TYPE_ZRS then
table.insert(n,{TppEnemyBodyId.pfa0_v00_a,e})
elseif a==TppDefine.AFR_ARMOR.TYPE_CFA then
table.insert(n,{TppEnemyBodyId.pfa0_v00_b,e})
elseif a==TppDefine.AFR_ARMOR.TYPE_RC then
table.insert(n,{TppEnemyBodyId.pfa0_v00_c,e})
else
table.insert(n,{TppEnemyBodyId.pfa0_v00_a,e})
end
end
end
end
TppSoldierFace.OverwriteMissionFovaData{body=n}
TppSoldierFace.SetBodyFovaUserType{hostage={TppEnemyBodyId.prs5_main0_v00}}
TppHostage2.SetDefaultBodyFovaId{parts=f,bodyId=TppEnemyBodyId.prs5_main0_v00}
end
function n.Mbqf(n,n)
TppSoldierFace.SetSoldierOutsideFaceMode(false)
TppSoldier2.SetDisableMarkerModelEffect{enabled=true}
local t={}
local n={}
if TppStory.GetCurrentStorySequence()<TppDefine.STORY_SEQUENCE.CLEARD_MURDER_INFECTORS then
local e,a=TppMotherBaseManagement.GetStaffsS10240()
for a,e in pairs(e)do
local e=TppMotherBaseManagement.StaffIdToFaceId{staffId=e}
if n[e]==nil then
n[e]=2
else
n[e]=n[e]+1
end
end
for a,e in pairs(a)do
local e=TppMotherBaseManagement.StaffIdToFaceId{staffId=e}
if n[e]==nil then
n[e]=2
else
n[e]=n[e]+1
end
end
else
for e,t in ipairs(a.S10240_MaleFaceIdList)do
local e=a.S10240_MaleFaceIdList[e]
if n[e]==nil then
n[e]=2
else
n[e]=n[e]+1
end
end
for e,t in ipairs(a.S10240_FemaleFaceIdList)do
local e=a.S10240_FemaleFaceIdList[e]
if n[e]==nil then
n[e]=2
else
n[e]=n[e]+1
end
end
end
for a,e in pairs(n)do
table.insert(t,{a,e,e,0})
end
table.insert(t,{623,1,1,0})table.insert(t,{TppEnemyFaceId.dds_balaclava2,10,10,0})table.insert(t,{TppEnemyFaceId.dds_balaclava6,2,2,0})table.insert(t,{TppEnemyFaceId.dds_balaclava7,2,2,0})
local e={{146,e},{147,e},{148,e},{149,e},{150,e},{151,1},{152,e},{153,e},{154,e},{155,e},{156,e},{157,e},{158,e}}
TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/dds/ddr1_main0_def_v00.parts"}
TppSoldierFace.OverwriteMissionFovaData{face=t,body=e}
TppSoldierFace.SetSoldierUseHairFova(true)
end
function n.Mb(n,d)
if TppMission.IsHelicopterSpace(d)then
return
end
TppSoldierFace.SetSoldierOutsideFaceMode(false)
local t={}
local o=TppEnemy.GetDDSuit()
if TppMission.IsFOBMission(d)then
local l=TppMotherBaseManagement.GetStaffsFob()
local d=36
local p=100
local n={}
local i={}do
for a,e in pairs(l)do
local e=TppMotherBaseManagement.StaffIdToFaceId{staffId=e}
if n[e]==nil then
n[e]=1
else
n[e]=n[e]+1
end
if a==d then
break
end
end
if#l==0 then
for e=1,d do
n[e]=1
end
end
for a,e in pairs(n)do
table.insert(t,{a,e,e,0})
end
end
do
for e=d+1,d+p do
local a=l[e]
if a==nil then
break
end
local a=TppMotherBaseManagement.StaffIdToFaceId{staffId=a}
if n[a]==nil then
i[a]=1
end
if e==p then
break
end
end
for e,a in pairs(i)do
table.insert(t,{e,0,0,0})
end
end
local n={}
if o==TppEnemy.FOB_DD_SUIT_SNEAKING then
TppSoldier2.SetDefaultPartsPath"/Assets/tpp/parts/chara/sna/sna4_enem0_def_v00.parts"table.insert(n,{TppEnemyFaceId.dds_balaclava0,e,e,0})table.insert(n,{TppEnemyFaceId.dds_balaclava1,e,e,0})table.insert(n,{TppEnemyFaceId.dds_balaclava12,e,e,0})table.insert(n,{TppEnemyFaceId.dds_balaclava3,e,e,0})table.insert(n,{TppEnemyFaceId.dds_balaclava4,e,e,0})table.insert(n,{TppEnemyFaceId.dds_balaclava14,e,e,0})
elseif o==TppEnemy.FOB_DD_SUIT_BTRDRS then
TppSoldier2.SetDefaultPartsPath"/Assets/tpp/parts/chara/sna/sna5_enem0_def_v00.parts"table.insert(n,{TppEnemyFaceId.dds_balaclava0,e,e,0})table.insert(n,{TppEnemyFaceId.dds_balaclava1,e,e,0})table.insert(n,{TppEnemyFaceId.dds_balaclava12,e,e,0})table.insert(n,{TppEnemyFaceId.dds_balaclava3,e,e,0})table.insert(n,{TppEnemyFaceId.dds_balaclava4,e,e,0})table.insert(n,{TppEnemyFaceId.dds_balaclava14,e,e,0})
elseif o==TppEnemy.FOB_PF_SUIT_ARMOR then
TppSoldier2.SetDefaultPartsPath"/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts"else
TppSoldier2.SetDefaultPartsPath"/Assets/tpp/parts/chara/dds/dds5_enem0_def_v00.parts"table.insert(n,{TppEnemyFaceId.dds_balaclava0,e,e,0})table.insert(n,{TppEnemyFaceId.dds_balaclava2,e,e,0})table.insert(n,{TppEnemyFaceId.dds_balaclava3,e,e,0})table.insert(n,{TppEnemyFaceId.dds_balaclava5,e,e,0})
end
if a.IsUseGasMaskInFOB()then
n={{TppEnemyFaceId.dds_balaclava8,e,e,0},{TppEnemyFaceId.dds_balaclava9,e,e,0},{TppEnemyFaceId.dds_balaclava10,e,e,0},{TppEnemyFaceId.dds_balaclava11,e,e,0},{TppEnemyFaceId.dds_balaclava13,e,e,0},{TppEnemyFaceId.dds_balaclava15,e,e,0}}
end
for a,e in ipairs(n)do
table.insert(t,e)
end
else
if d==30050 then
elseif d==30150 then
elseif d==30250 then
local a=TppMotherBaseManagement.GetOutOnMotherBaseStaffs{sectionId=TppMotherBaseManagementConst.SECTION_SECURITY}
local e=#a
local e={}
for n,a in pairs(a)do
local a=TppMotherBaseManagement.StaffIdToFaceId{staffId=a}
if e[a]==nil then
e[a]=1
else
e[a]=e[a]+1
end
if n==7 then
break
end
end
for a,e in pairs(e)do
table.insert(t,{a,e,e,0})
end
table.insert(t,{TppEnemyFaceId.dds_balaclava6,7,7,0})
elseif d==10240 then
t={{1,e,e,0},{2,e,e,0},{3,e,e,0},{4,e,e,0},{5,e,e,0},{6,e,e,0},{7,e,e,0},{8,e,e,0},{9,e,e,0},{14,e,e,0},{15,e,e,0},{16,e,e,0},{17,e,e,0},{18,e,e,0}}table.insert(t,{TppEnemyFaceId.dds_balaclava6,e,e,0})
elseif d==10030 then
for a,e in ipairs(a.S10030_FaceIdList)do
table.insert(t,{e,1,1,0})
end
table.insert(t,{TppEnemyFaceId.dds_balaclava0,a.S10030_useBalaclavaNum,a.S10030_useBalaclavaNum,0})
else
for a=0,35 do
table.insert(t,{a,e,e,0})
end
table.insert(t,{TppEnemyFaceId.dds_balaclava0,e,e,0})table.insert(t,{TppEnemyFaceId.dds_balaclava1,e,e,0})table.insert(t,{TppEnemyFaceId.dds_balaclava2,e,e,0})
end
end
TppSoldierFace.OverwriteMissionFovaData{face=t}
local a={}
if TppMission.IsFOBMission(d)then
if o==TppEnemy.FOB_DD_SUIT_SNEAKING then
a={{TppEnemyBodyId.dds4_enem0_def,e},{TppEnemyBodyId.dds4_enef0_def,e}}
elseif o==TppEnemy.FOB_DD_SUIT_BTRDRS then
a={{TppEnemyBodyId.dds5_enem0_def,e},{TppEnemyBodyId.dds5_enef0_def,e}}
elseif o==TppEnemy.FOB_PF_SUIT_ARMOR then
a={{TppEnemyBodyId.pfa0_v00_a,e}}
else
a={{TppEnemyBodyId.dds5_main0_v00,e},{TppEnemyBodyId.dds6_main0_v00,e}}
end
else
a={{TppEnemyBodyId.dds3_main0_v00,e},{TppEnemyBodyId.dds8_main0_v00,e}}
end
TppSoldierFace.OverwriteMissionFovaData{body=a}
if not(d==10030 or d==10240)then
if TppMission.IsFOBMission(d)then
if o==TppEnemy.FOB_DD_SUIT_SNEAKING then
TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/sna/sna4_enef0_def_v00.parts"}
elseif o==TppEnemy.FOB_DD_SUIT_BTRDRS then
TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/sna/sna5_enef0_def_v00.parts"}
elseif o==TppEnemy.FOB_PF_SUIT_ARMOR then
else
TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/dds/dds6_enef0_def_v00.parts"}
end
elseif d~=10115 and d~=11115 then
TppSoldier2.SetExtendPartsInfo{type=1,path="/Assets/tpp/parts/chara/dds/dds8_main0_def_v00.parts"}
end
end
TppSoldierFace.SetSoldierUseHairFova(true)
end
function n.Cyprus(a,a)
local a={}
for e=0,5 do
table.insert(a,e)
end
TppSoldierFace.SetPoolTable{face=a}
TppSoldierFace.SetSoldierNoFaceResourceMode(true)
local e={{TppEnemyBodyId.wss0_main0_v00,e}}
TppSoldierFace.OverwriteMissionFovaData{body=e}
end
function n.default(n,a)
TppSoldierFace.SetMissionFovaData{face={},body={}}
if a>6e4 then
local e={{30,e,e,e}}
TppSoldierFace.OverwriteMissionFovaData{face=e}
end
end
function a.AddTakingOverHostagePack()
local e={}
for n,t in ipairs(TppEnemy.TAKING_OVER_HOSTAGE_LIST)do
local a=n-1
if a>=gvars.ene_takingOverHostageCount then
break
end
local a={type="hostage",name=t,faceId=gvars.ene_takingOverHostageFaceIds[a]}table.insert(e,a)
end
a.AddUniqueSettingPackage(e)
end
function a.PreMissionLoad(e,a)
TppSoldier2.SetEnglishVoiceIdTable{voice={}}
TppSoldierFace.SetMissionFovaData{face={},body={}}
TppSoldierFace.ResetForPreMissionLoad()
TppSoldier2.SetDisableMarkerModelEffect{enabled=false}
TppSoldier2.SetDefaultPartsPath()
TppSoldier2.SetExtendPartsInfo{}
TppHostage2.ClearDefaultBodyFovaId()
if TppLocation.IsMotherBase()or TppLocation.IsMBQF()then
local e=TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
local a=TppMotherBaseManagement.GetMbsClusterSecurityIsNoKillMode()
TppEnemy.PrepareDDParameter(e,a)
end
local a=o(n)
if n[e]==nil then
if TppMission.IsHelicopterSpace(e)then
a:case("default",e)
elseif TppLocation.IsAfghan()then
a:case("Afghan",e)
elseif TppLocation.IsMiddleAfrica()then
a:case("Africa",e)
elseif TppLocation.IsMBQF()then
a:case("Mbqf",e)
elseif TppLocation.IsMotherBase()then
a:case("Mb",e)
elseif TppLocation.IsCyprus()then
a:case("Cyprus",e)
else
a:case("default",e)
end
else
a:case(e,e)
end
end
local c={}
local o={}
local l={}
local t={}
local d=0
local i=0
local s=0
local p=0
local r=0
local m=15
local T=16
local _=32
local f=0
function a.InitializeUniqueSetting()c={}o={}l={}t={}d=0
i=0
s=0
p=0
r=0
local n=GameObject.NULL_ID
local a=EnemyFova.NOT_USED_FOVA_VALUE
for e=0,TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT-1 do
gvars.ene_fovaUniqueTargetIds[e]=n
gvars.ene_fovaUniqueFaceIds[e]=a
gvars.ene_fovaUniqueBodyIds[e]=a
gvars.ene_fovaUniqueBodyIds[e]=a
if gvars.ene_fovaUniqueFlags then
gvars.ene_fovaUniqueFlags[e]=0
end
end
end
function a.GetStaffIdForDD(e,n)
local a=f
if e==10081 then
a=TppMotherBaseManagement.GetStaffS10081()
elseif e==10091 or e==11091 then
local e=TppMotherBaseManagement.GetStaffsS10091()
if e and n<#e then
a=e[n+1]
end
elseif e==10115 or e==11115 then
local e=TppMotherBaseManagement.GetStaffsS10115()
if e and n<#e then
a=e[n+1]
end
end
return a
end
function a.GetFaceIdForDdHostage(e)
local n=d
d=d+1
local a=a.GetStaffIdForDD(e,n)
local t=bit.bor(T,n)
if a~=f then
local a=TppMotherBaseManagement.StaffIdToFaceId{staffId=a}
if e==10081 then
s=a
elseif e==10091 or e==11091 then
if n>0 then
r=a
else
p=a
end
end
return a,t
end
local a=(gvars.hosface_groupNumber+n)%30
local a=50+a
if TppSoldierFace.GetRandomFaceId~=nil then
local e=gvars.solface_groupNumber+n
a=TppSoldierFace.GetRandomFaceId{race={0,2,3},gender=0,useIndex=e}
end
if e==10081 then
s=a
elseif e==10091 or e==11091 then
if n>0 then
r=a
else
p=a
end
end
return a,t
end
function a.GetFaceId_s10081()
return s
end
function a.GetFaceId_s10091_0()
return p
end
function a.GetFaceId_s10091_1()
return r
end
function a.GetFaceIdForFemaleHostage(e)
local n=_
if e==10086 then
return 613,n
end
local t=i
i=i+1
local a={}table.insert(a,0)
if TppLocation.IsAfghan()then
table.insert(a,3)
elseif TppLocation.IsMiddleAfrica()then
table.insert(a,2)table.insert(a,3)
end
local d=gvars.solface_groupNumber+t
local e=EnemyFova.INVALID_FOVA_VALUE
if TppSoldierFace.GetRandomFaceId~=nil then
e=TppSoldierFace.GetRandomFaceId{race=a,gender=1,useIndex=d}
if e~=EnemyFova.INVALID_FOVA_VALUE then
return e,n
else
local a=(gvars.hosface_groupNumber+t)%50
e=350+a
end
else
local a=(gvars.hosface_groupNumber+t)%50
e=350+a
end
return e,n
end
function a.GetFaceIdAndFlag(n,e)
local t=EnemyFova.NOT_USED_FOVA_VALUE
if e=="female"then
if n=="hostage"then
return a.GetFaceIdForFemaleHostage(vars.missionCode)
else
return t,0
end
elseif e=="dd"then
if n=="hostage"then
return a.GetFaceIdForDdHostage(vars.missionCode)
else
return t,0
end
end
return e,0
end
function a.RegisterUniqueSetting(d,i,p,n)
local e=EnemyFova.NOT_USED_FOVA_VALUE
local a,p=a.GetFaceIdAndFlag(d,p)
if a==nil then
a=e
end
if n==nil then
n=e
end
table.insert(c,{name=i,faceId=a,bodyId=n,flag=p})do
local p=1
local l=2
local t=3
local n=4
local e=nil
for t,n in ipairs(o)do
if n[p]==a then
e=n
end
end
if not e then
e={a,0,0,0}table.insert(o,e)
end
if d=="enemy"then
e[l]=e[l]+1
e[t]=e[t]+1
elseif d=="hostage"then
e[n]=e[n]+1
end
end
do
local p=1
local o=2
local e=nil
for t,a in ipairs(l)do
if a[p]==n then
e=a
end
end
if not e then
e={n,0}table.insert(l,e)
end
e[o]=e[o]+1
if d=="hostage"then
local e=n
for t,a in ipairs(t)do
if a==n then
e=nil
break
end
end
if e then
table.insert(t,e)
end
end
end
end
function a.AddUniqueSettingPackage(e)
if e and type(e)=="table"then
for n,e in ipairs(e)do
a.RegisterUniqueSetting(e.type,e.name,e.faceId,e.bodyId,e.missionCode)
end
end
TppSoldierFace.OverwriteMissionFovaData{face=o,body=l,additionalMode=true}if#t>0 then
TppSoldierFace.SetBodyFovaUserType{hostage=t}
end
end
function a.AddUniquePackage(e)
TppSoldierFace.OverwriteMissionFovaData{face=e.face,body=e.body,additionalMode=true}
if e.body and e.type=="hostage"then
local a={}
for n,e in ipairs(e.body)do
table.insert(a,e[1])
end
if#a>0 then
TppSoldierFace.SetBodyFovaUserType{hostage=a}
end
end
end
function a.ApplyUniqueSetting()
local t=GameObject.NULL_ID
local e=EnemyFova.NOT_USED_FOVA_VALUE
if gvars.ene_fovaUniqueTargetIds[0]==t then
local e=0
for n,a in ipairs(c)do
local n=GameObject.GetGameObjectId(a.name)
if n~=t then
if e<TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT then
gvars.ene_fovaUniqueTargetIds[e]=n
gvars.ene_fovaUniqueFaceIds[e]=a.faceId
gvars.ene_fovaUniqueBodyIds[e]=a.bodyId
if gvars.ene_fovaUniqueFlags then
gvars.ene_fovaUniqueFlags[e]=a.flag
end
end
e=e+1
end
end
end
local d=bit.band
for n=0,TppDefine.ENEMY_FOVA_UNIQUE_SETTING_COUNT-1 do
local e=gvars.ene_fovaUniqueTargetIds[n]
if e==t then
break
end
local t={id="ChangeFova",faceId=gvars.ene_fovaUniqueFaceIds[n],bodyId=gvars.ene_fovaUniqueBodyIds[n]}
GameObject.SendCommand(e,t)
local t=0
if gvars.ene_fovaUniqueFlags then
t=gvars.ene_fovaUniqueFlags[n]
end
if d(t,T)~=0 then
local n=vars.missionCode
local t=d(t,m)
local a=a.GetStaffIdForDD(n,t)
if a~=f then
local a={id="SetStaffId",staffId=a}
GameObject.SendCommand(e,a)
end
local a={id="SetHostage2Flag",flag="dd",on=true}
GameObject.SendCommand(e,a)
elseif d(t,_)~=0 then
local a={id="SetHostage2Flag",flag="female",on=true}
GameObject.SendCommand(e,a)
end
end
end
function a.ApplyMTBSUniqueSetting(e,d,l,i)
local t=0
local n=EnemyFova.INVALID_FOVA_VALUE
local p=TppEnemy.GetDDSuit()
local function o(e)
local e=TppSoldierFace.CheckFemale{face={e}}
return e and e[1]==1
end
if TppMission.IsFOBMission(vars.missionCode)then
if p==TppEnemy.FOB_DD_SUIT_SNEAKING then
if((TppEnemy.weaponIdTable.DD.NORMAL.SNEAKING_SUIT and TppEnemy.weaponIdTable.DD.NORMAL.SNEAKING_SUIT>=3)and TppMotherBaseManagement.GetMbsNvgSneakingLevel)and TppMotherBaseManagement.GetMbsNvgSneakingLevel()>0 then
TppEnemy.AddPowerSetting(e,{"NVG"})
end
if o(d)==true then
t=TppEnemyBodyId.dds4_enef0_def
local a={id="UseExtendParts",enabled=true}
GameObject.SendCommand(e,a)
if TppEnemy.IsHelmet(e)then
if TppEnemy.IsNVG(e)then
n=TppEnemyFaceId.dds_balaclava14
else
n=TppEnemyFaceId.dds_balaclava3
end
else
n=TppEnemyFaceId.dds_balaclava4
end
else
t=TppEnemyBodyId.dds4_enem0_def
local a={id="UseExtendParts",enabled=false}
GameObject.SendCommand(e,a)
if TppEnemy.IsHelmet(e)then
if TppEnemy.IsNVG(e)then
n=TppEnemyFaceId.dds_balaclava12
else
n=TppEnemyFaceId.dds_balaclava0
end
else
n=TppEnemyFaceId.dds_balaclava1
end
end
elseif p==TppEnemy.FOB_DD_SUIT_BTRDRS then
if((TppEnemy.weaponIdTable.DD.NORMAL.BATTLE_DRESS and TppEnemy.weaponIdTable.DD.NORMAL.BATTLE_DRESS>=3)and TppMotherBaseManagement.GetMbsNvgBattleLevel)and TppMotherBaseManagement.GetMbsNvgBattleLevel()>0 then
TppEnemy.AddPowerSetting(e,{"NVG"})
end
if o(d)==true then
t=TppEnemyBodyId.dds5_enef0_def
local a={id="UseExtendParts",enabled=true}
GameObject.SendCommand(e,a)
if TppEnemy.IsHelmet(e)then
if TppEnemy.IsNVG(e)then
n=TppEnemyFaceId.dds_balaclava14
else
n=TppEnemyFaceId.dds_balaclava3
end
elseif l then
n=TppEnemyFaceId.dds_balaclava4
end
else
t=TppEnemyBodyId.dds5_enem0_def
local a={id="UseExtendParts",enabled=false}
GameObject.SendCommand(e,a)
if TppEnemy.IsHelmet(e)then
if TppEnemy.IsNVG(e)then
n=TppEnemyFaceId.dds_balaclava12
else
n=TppEnemyFaceId.dds_balaclava0
end
elseif l then
n=TppEnemyFaceId.dds_balaclava1
end
end
elseif p==TppEnemy.FOB_PF_SUIT_ARMOR then
if not o(d)==true then
t=TppEnemyBodyId.pfa0_v00_a
local a={id="UseExtendParts",enabled=false}
GameObject.SendCommand(e,a)
TppEnemy.AddPowerSetting(e,{"ARMOR"})
end
else
if o(d)==true then
t=TppEnemyBodyId.dds6_main0_v00
local a={id="UseExtendParts",enabled=true}
GameObject.SendCommand(e,a)
if l then
if TppEnemy.IsHelmet(e)then
n=TppEnemyFaceId.dds_balaclava3
else
n=TppEnemyFaceId.dds_balaclava5
end
end
else
t=TppEnemyBodyId.dds5_main0_v00
local a={id="UseExtendParts",enabled=false}
GameObject.SendCommand(e,a)
if l then
if TppEnemy.IsHelmet(e)then
n=TppEnemyFaceId.dds_balaclava0
else
n=TppEnemyFaceId.dds_balaclava2
end
end
end
end
if a.IsUseGasMaskInFOB()and p~=TppEnemy.FOB_PF_SUIT_ARMOR then
if o(d)then
if TppEnemy.IsHelmet(e)then
if TppEnemy.IsNVG(e)then
n=TppEnemyFaceId.dds_balaclava15
else
n=TppEnemyFaceId.dds_balaclava11
end
else
n=TppEnemyFaceId.dds_balaclava10
end
else
if TppEnemy.IsHelmet(e)then
if TppEnemy.IsNVG(e)then
n=TppEnemyFaceId.dds_balaclava13
else
n=TppEnemyFaceId.dds_balaclava9
end
else
n=TppEnemyFaceId.dds_balaclava8
end
end
TppEnemy.AddPowerSetting(e,{"GAS_MASK"})
end
else
if o(d)then
t=TppEnemyBodyId.dds8_main0_v00
local t={id="UseExtendParts",enabled=true}
GameObject.SendCommand(e,t)
if l then
n=TppEnemyFaceId.dds_balaclava5
end
if a.IsUseGasMaskInMBFree()then
n=TppEnemyFaceId.dds_balaclava7
TppEnemy.AddPowerSetting(e,{"GAS_MASK"})
end
else
t=TppEnemyBodyId.dds3_main0_v00
local t={id="UseExtendParts",enabled=false}
GameObject.SendCommand(e,t)
if l then
n=TppEnemyFaceId.dds_balaclava2
end
if a.IsUseGasMaskInMBFree()then
n=TppEnemyFaceId.dds_balaclava6
TppEnemy.AddPowerSetting(e,{"GAS_MASK"})
end
end
end
if i then
n=EnemyFova.NOT_USED_FOVA_VALUE
end
local a={id="ChangeFova",faceId=d,bodyId=t,balaclavaFaceId=n}
GameObject.SendCommand(e,a)
end
function a.IsUseGasMaskInMBFree(e)
local a=TppMotherBaseManagement.IsPandemicEventMode()
local e=mvars.f30050_currentFovaClusterId~=TppDefine.CLUSTER_DEFINE.Command
return a and e
end
function a.IsUseGasMaskInFOB()
local a,a,e=a.GetUavSetting()
return e
end
function a.GetUavSetting()
local d=TppMotherBaseManagement.GetMbsUavLevel{}
local p=TppMotherBaseManagement.GetMbsUavSmokeGrenadeLevel{}
local T=TppMotherBaseManagement.GetMbsUavSleepingGusGrenadeLevel{}
local a=TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
local f=TppMotherBaseManagement.GetMbsClusterSecurityIsNoKillMode()
local l=TppUav.DEVELOP_LEVEL_LMG_0
local t=false
local c=false
local e=0
local n=0
local s=0
local o=100
local _=7
local i=4
local r=3
local r=3
local m=3
if a<r then
e=o
elseif d>0 then
if d==1 then
e=TppUav.DEVELOP_LEVEL_LMG_0
elseif d==2 then
if a>=((d+r)-1)then
e=TppUav.DEVELOP_LEVEL_LMG_1
else
e=TppUav.DEVELOP_LEVEL_LMG_0
end
elseif d==3 then
if a>=((d+r)-1)then
e=TppUav.DEVELOP_LEVEL_LMG_2
elseif a>=((2+r)-1)then
e=TppUav.DEVELOP_LEVEL_LMG_1
else
e=TppUav.DEVELOP_LEVEL_LMG_0
end
end
end
if a<i then
n=o
elseif d>0 then
if p==1 then
n=TppUav.DEVELOP_LEVEL_SMOKE_0
elseif p==2 then
if a>=((p+i)-1)then
n=TppUav.DEVELOP_LEVEL_SMOKE_1
else
n=TppUav.DEVELOP_LEVEL_SMOKE_0
end
elseif p==3 then
if a>=((p+i)-1)then
n=TppUav.DEVELOP_LEVEL_SMOKE_2
elseif a>=((2+i)-1)then
n=TppUav.DEVELOP_LEVEL_SMOKE_1
else
n=TppUav.DEVELOP_LEVEL_SMOKE_0
end
end
end
if a<_ then
s=o
else
if T==1 then
s=TppUav.DEVELOP_LEVEL_SLEEP_0
end
end
if d==0 then
t=false
else
if f==true then
if s~=o then
l=s
t=true
c=true
elseif n~=o then
l=n
t=true
c=true
elseif e~=o then
l=e
t=true
else
t=false
end
else
if e~=o then
l=e
t=true
else
t=false
end
end
end
return t,l,c
end
return a
