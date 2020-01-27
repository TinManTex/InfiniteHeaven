mbdvc_map_location_parameter={
  GetLocationParameter=function(locationId)
    if locationId==0 then
return{}
    elseif locationId==101 then
      return{
        stageSize=556*1,
        scrollMaxLeftUpPosition=Vector3(-255,0,-275),
        scrollMaxRightDownPosition=Vector3(255,0,275),
        highZoomScale=2,
        middleZoomScale=1,
        lowZoomScale=.5,
        locationNameLangId="mgo_idt_Jungle",
        stageRotate=0,
        heightMapTexturePath="/Assets/mgo/ui/texture/map/afc0/afc0_iDroid_clp.ftex",
        photoRealMapTexturePath="/Assets/mgo/ui/texture/map/afc0/afc0_jungle_sat_clp.ftex"
      }
    elseif locationId==104 then
      return{
        stageSize=276*1,
        scrollMaxLeftUpPosition=Vector3(-128,0,-128),
        scrollMaxRightDownPosition=Vector3(138,0,128),
        highZoomScale=2,
        middleZoomScale=1,
        lowZoomScale=.5,
        locationNameLangId="mgo_idt_Africa",
        stageRotate=0,
        heightMapTexturePath="/Assets/mgo/ui/texture/map/afc1/afc1_iDroid_clp.ftex",
        photoRealMapTexturePath="/Assets/mgo/ui/texture/map/afc1/afc1_indus_sat_clp.ftex"
      }
    elseif locationId==103 then
      return{
        stageSize=336*1,
        scrollMaxLeftUpPosition=Vector3(-138,0,-155),
        scrollMaxRightDownPosition=Vector3(168,0,151),
        highZoomScale=2,
        middleZoomScale=1,
        lowZoomScale=.5,
        locationNameLangId="mgo_idt_Dam",
        stageRotate=0,
        heightMapTexturePath="/Assets/mgo/ui/texture/map/afda/afda_iDroid_clp.ftex",
        photoRealMapTexturePath="/Assets/mgo/ui/texture/map/afda/afda_dam_sat_clp.ftex"
      }
    elseif locationId==102 then
      return{
        stageSize=582*1,
        scrollMaxLeftUpPosition=Vector3(-291,0,-202.5),
        scrollMaxRightDownPosition=Vector3(44.5,0,133),
        highZoomScale=2,
        middleZoomScale=1,
        lowZoomScale=.5,
        locationNameLangId="mgo_idt_Hill",
        stageRotate=0,
        heightMapTexturePath="/Assets/mgo/ui/texture/map/afn0/afn0_iDroid_clp.ftex",
        photoRealMapTexturePath="/Assets/mgo/ui/texture/map/afn0/afn0_hill_sat_clp.ftex"
      }
    elseif locationId==105 then
      return{
        stageSize=491*1,
        scrollMaxLeftUpPosition=Vector3(-47.35,0,-206),
        scrollMaxRightDownPosition=Vector3(227,0,67.5),
        highZoomScale=2,
        middleZoomScale=1,
        lowZoomScale=.5,
        locationNameLangId="mgo_idt_Guantanamo",
        stageRotate=0,
        heightMapTexturePath="/Assets/mgo/ui/texture/map/cuba/cuba_iDroid_clp.ftex",
        photoRealMapTexturePath="/Assets/mgo/ui/texture/map/cuba/cuba_gz_sat_clp.ftex"
      }
    elseif locationId==111 then
      return{
        stageSize=512*1,
        scrollMaxLeftUpPosition=Vector3(-256,0,-320),
        scrollMaxRightDownPosition=Vector3(256,0,192),
        highZoomScale=2,
        middleZoomScale=1,
        lowZoomScale=.5,
        locationNameLangId="mgo_idt_MB",
        stageRotate=0,
        heightMapTexturePath="/Assets/mgo/ui/texture/map/mba0/mba0_clp.ftex",
        photoRealMapTexturePath="/Assets/mgo/ui/texture/map/mba0/mba0_sat_clp.ftex"
      }
    elseif locationId==113 then
      return{
        stageSize=512*1,
        scrollMaxLeftUpPosition=Vector3(512,0,-2176),
        scrollMaxRightDownPosition=Vector3(1024,0,-1664),
        highZoomScale=2,
        middleZoomScale=1,
        lowZoomScale=.5,
        locationNameLangId="mgo_idt_Remnant",
        stageRotate=0,
        heightMapTexturePath="/Assets/mgo/ui/texture/map/rma0/rma0_clp.ftex",
        photoRealMapTexturePath="/Assets/mgo/ui/texture/map/rma0/rma0_sat_clp.ftex"
      }
    elseif locationId==112 then
      return{
        stageSize=512*1,
        scrollMaxLeftUpPosition=Vector3(-1216,0,-64),
        scrollMaxRightDownPosition=Vector3(-704,0,448),
        highZoomScale=2,
        middleZoomScale=1,
        lowZoomScale=.5,
        locationNameLangId="mgo_idt_Savannah",
        stageRotate=0,
        heightMapTexturePath="/Assets/mgo/ui/texture/map/sva0/sva0_clp.ftex",
        photoRealMapTexturePath="/Assets/mgo/ui/texture/map/sva0/sva0_sat_clp.ftex"
      }
end
    return{
      stageSize=4096*2,
      scrollMaxLeftUpPosition=Vector3(-4096,0,-4096),
      scrollMaxRightDownPosition=Vector3(4096,0,4096),
      highZoomScale=4.8,
      middleZoomScale=2.34,
      lowZoomScale=.7,
      heightMapTexturePath="/Assets/tpp/common_source/ui/common_texture/cm_wht_64.ftex",
      photoRealMapTexturePath="/Assets/tpp/common_source/ui/common_texture/cm_wht_64.ftex"
    }
  end,
  GetGlobalLocationParameter=function()
return{}
  end,
  GetLocationOfMissions=function()
    local locationOfMissions={}
    for locationName,missionList in pairs(TppDefine.LOCATION_HAVE_MISSION_LIST)do
      for index,missionId in pairs(missionList)do
        locationOfMissions[missionId]=TppDefine.LOCATION_ID[locationName]
      end
end
    return locationOfMissions
end
}
