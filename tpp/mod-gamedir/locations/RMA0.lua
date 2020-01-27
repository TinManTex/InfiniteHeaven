local this={
  description="Rust Palace",
  locationName="RMA0",
  locationId=113,
  packs={"/Assets/mgo/pack/location/rma0/rma0.fpk"},
  locationMapParams={
    stageSize=512*1,
   --DEBUGNOW scrollMaxLeftUpPosition=Vector3(512,0,-2176),
   --DEBUGNOW scrollMaxRightDownPosition=Vector3(1024,0,-1664),
    scrollMaxLeftUpPosition=Vector3(-138,0,-155),
    scrollMaxRightDownPosition=Vector3(168,0,151),
   
    highZoomScale=2,
    middleZoomScale=1,
    lowZoomScale=.5,
    locationNameLangId="mgo_idt_Remnant",
    stageRotate=0,
    heightMapTexturePath="/Assets/mgo/ui/texture/map/rma0/rma0_clp.ftex",
    photoRealMapTexturePath="/Assets/mgo/ui/texture/map/rma0/rma0_sat_clp.ftex"
  },
}

return this
