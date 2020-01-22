local s={}
s[TppDefine.LOCATION_ID.INIT]={"/Assets/mgo/pack/location/empty/empty.fpk"}
s[101]={"/Assets/mgo/pack/location/afc0/afc0.fpk"}
s[102]={"/Assets/mgo/pack/location/afn0/afn0.fpk"}
s[103]={"/Assets/mgo/pack/location/afda/afda.fpk"}
s[104]={"/Assets/mgo/pack/location/afc1/afc1.fpk"}
s[105]={"/Assets/mgo/pack/location/cuba/cuba.fpk"}
s[149]={"/Assets/mgo/pack/location/afnt/afnt.fpk"}
s[150]={"/Assets/mgo_sandbox/pack/location/test/jonathan/js_test_4x4/test/test.fpk"}
s[200]={"/Assets/mgo/pack/location/store/store_in_freeplay.fpk"}
local o={}
o[TppDefine.SYS_MISSION_ID.INIT]={"/Assets/mgo/pack/mission/init_mission.fpk"}
o[2]={"/Assets/mgo/pack/mission/dummy_sp.fpk"}
o[6]={"/Assets/mgo/pack/mission/mission_ruleset_2.fpk"}
o[7]={"/Assets/mgo/pack/mission/store_mission.fpk"}
local function a(o)
  return s[o]
end
local function s(s)
  return o[s]
end
if Mission.SetLocationPackagePathFunc then
  Mission.SetLocationPackagePathFunc(a)
end
if Mission.SetMissionPackagePathFunc then
  Mission.SetMissionPackagePathFunc(s)
end
return{}
