local locationPackTable={}
locationPackTable[TppDefine.LOCATION_ID.INIT]={"/Assets/mgo/pack/location/empty/empty.fpk"}
locationPackTable[101]={"/Assets/mgo/pack/location/afc0/afc0.fpk"}
locationPackTable[102]={"/Assets/mgo/pack/location/afn0/afn0.fpk"}
locationPackTable[103]={"/Assets/mgo/pack/location/afda/afda.fpk"}
locationPackTable[104]={"/Assets/mgo/pack/location/afc1/afc1.fpk"}
locationPackTable[105]={"/Assets/mgo/pack/location/cuba/cuba.fpk"}
locationPackTable[111]={"/Assets/mgo/pack/location/mba0/mba0.fpk"}
locationPackTable[112]={"/Assets/mgo/pack/location/sva0/sva0.fpk"}
locationPackTable[113]={"/Assets/mgo/pack/location/rma0/rma0.fpk"}
locationPackTable[114]={"/Assets/mgo/pack/location/mba1/mba1.fpk"}
locationPackTable[115]={"/Assets/mgo/pack/location/mba2/mba2.fpk"}
locationPackTable[116]={"/Assets/mgo/pack/location/mba3/mba3.fpk"}
locationPackTable[149]={"/Assets/mgo/pack/location/afnt/afnt.fpk"}
locationPackTable[150]={"/Assets/mgo_sandbox/pack/location/test/jonathan/js_test_4x4/test/test.fpk"}
locationPackTable[200]={"/Assets/mgo/pack/location/store/store_in_freeplay.fpk"}
local missionPackTable={}
missionPackTable[TppDefine.SYS_MISSION_ID.INIT]={"/Assets/mgo/pack/mission/init_mission.fpk"}
missionPackTable[2]={"/Assets/mgo/pack/mission/dummy_sp.fpk"}
missionPackTable[6]={"/Assets/mgo/pack/mission/mission_ruleset_2.fpk"}
missionPackTable[7]={"/Assets/mgo/pack/mission/store_mission.fpk"}
local function GetLocationPackagePath(locationId)
  return locationPackTable[locationId]
end
local function GetMissionPackagePath(missionCode)
  return missionPackTable[missionCode]
end
if Mission.SetLocationPackagePathFunc then
  Mission.SetLocationPackagePathFunc(GetLocationPackagePath)
end
if Mission.SetMissionPackagePathFunc then
  Mission.SetMissionPackagePathFunc(GetMissionPackagePath)
end
return{}
