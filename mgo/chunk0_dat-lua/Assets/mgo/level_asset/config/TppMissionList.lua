local s={}
s[TppDefine.LOCATION_ID.INIT]={"/Assets/mgo/pack/location/empty/empty.fpk"}
s[101]={"/Assets/mgo/pack/location/afc0/afc0.fpk"}
s[102]={"/Assets/mgo/pack/location/afn0/afn0.fpk"}
s[103]={"/Assets/mgo/pack/location/afda/afda.fpk"}
s[104]={"/Assets/mgo/pack/location/afc1/afc1.fpk"}
s[105]={"/Assets/mgo/pack/location/cuba/cuba.fpk"}
s[111]={"/Assets/mgo/pack/location/mba0/mba0.fpk"}
s[112]={"/Assets/mgo/pack/location/sva0/sva0.fpk"}
s[113]={"/Assets/mgo/pack/location/rma0/rma0.fpk"}
s[114]={"/Assets/mgo/pack/location/mba1/mba1.fpk"}
s[115]={"/Assets/mgo/pack/location/mba2/mba2.fpk"}
s[116]={"/Assets/mgo/pack/location/mba3/mba3.fpk"}
s[149]={"/Assets/mgo/pack/location/afnt/afnt.fpk"}
s[150]={"/Assets/mgo_sandbox/pack/location/test/jonathan/js_test_4x4/test/test.fpk"}
s[200]={"/Assets/mgo/pack/location/store/store_in_freeplay.fpk"}
local a={}
a[TppDefine.SYS_MISSION_ID.INIT]={"/Assets/mgo/pack/mission/init_mission.fpk"}
a[2]={"/Assets/mgo/pack/mission/dummy_sp.fpk"}
a[6]={"/Assets/mgo/pack/mission/mission_ruleset_2.fpk"}
a[7]={"/Assets/mgo/pack/mission/store_mission.fpk"}
local function o(a)
return s[a]
end
local function s(s)
return a[s]
end
if Mission.SetLocationPackagePathFunc then
Mission.SetLocationPackagePathFunc(o)
end
if Mission.SetMissionPackagePathFunc then
Mission.SetMissionPackagePathFunc(s)
end
return{}
