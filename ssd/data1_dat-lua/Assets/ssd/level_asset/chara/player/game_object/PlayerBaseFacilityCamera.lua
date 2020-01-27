local this={}
local StrCode32=Fox.StrCode32
function this.QuatToRotX(e)
  local e=e:Rotate(Vector3(0,1,0))
  local e=foxmath.Atan2(e:GetZ(),e:GetY())
  return TppMath.RadianToDegree(e)
end
function this.QuatToRotY(e)
  local e=e:Rotate(Vector3(0,0,1))
  local e=foxmath.Atan2(e:GetX(),e:GetZ())
  return TppMath.RadianToDegree(e)
end
function this.WarpPlayer()
  local e,a=Tpp.GetLocator("SsdPlayerCameraIdentifier","PlayerPosition")
  TppPlayer.Warp{pos=e,rotY=a}
end
function this.WarpToStage()
  this.WarpPlayer()
  this.SetCameraStageCenter()
end
function this.SetCameraStageCenter()
  this.UpdateCameraParameterInterp("Player",true,false)
end
function this.WarpFromStage()
  Player.SetAroundCameraManualMode(false)
end
local l={
 [Fox.StrCode32"PlayerCommon"]={locName="SSD_Camera_Player_Common",distance=3.5,interpTime=.3,lock=false,minX=-40,maxX=40,rotateY=false,attachBone=0,aperture=.5,focusDistance=3.5},
[Fox.StrCode32"PlayerCraftingCommon"]={locName="SSD_Camera_Player_Crafting_Common",distance=2,interpTime=.3,lock=false,minX=-5,maxX=5,rotateY=false,attachBone=0,aperture=1,focusDistance=2},
[Fox.StrCode32"PlayerCraftingHead"]={locName="SSD_Camera_Player_Crafting_Head",distance=1.95,interpTime=.3,lock=false,minX=-5,maxX=5,rotateY=false,attachBone=4,aperture=3,focusDistance=.9},--RETAILPATCH: 1.0.9.0 updated
[Fox.StrCode32"PlayerCraftingExHead"]={locName="SSD_Camera_Player_Crafting_ExHead",distance=2.1,interpTime=.3,lock=false,minX=-5,maxX=5,rotateY=false,attachBone=4,aperture=3,focusDistance=1.1},--RETAILPATCH: 1.0.9.0 added
[Fox.StrCode32"PlayerCraftingChest"]={locName="SSD_Camera_Player_Crafting_Chest",distance=2.1,interpTime=.3,lock=false,minX=-5,maxX=5,rotateY=false,attachBone=2,aperture=3,focusDistance=1.1},--RETAILPATCH: 1.0.9.0 updated
[Fox.StrCode32"PlayerCraftingArm"]={locName="SSD_Camera_Player_Crafting_Arm",distance=2,interpTime=.3,lock=false,minX=-5,maxX=5,rotateY=false,attachBone=11,aperture=2,focusDistance=1.2},--RETAILPATCH: 1.0.9.0 updated
[Fox.StrCode32"PlayerCraftingLeg"]={locName="SSD_Camera_Player_Crafting_Leg",distance=2.3,interpTime=.3,lock=false,minX=0,maxX=5,rotateY=false,attachBone=0,aperture=1.3,focusDistance=1.9},--RETAILPATCH: 1.0.9.0 updated
[Fox.StrCode32"PlayerCraftingPreview"]={locName="SSD_Camera_Player_Crafting_Preview",distance=3.5,interpTime=.3,lock=false,minX=-5,maxX=5,rotateY=true,attachBone=0,aperture=.5,focusDistance=3.5},
[Fox.StrCode32"PlayerWarehouseCommon"]={locName="SSD_Camera_Player_Warehouse_Common",distance=2.75,interpTime=.3,lock=false,minX=-5,maxX=5,rotateY=false,attachBone=0,aperture=1,focusDistance=2.75},  [Fox.StrCode32"FacilityCommon"]={locName="SSD_Camera_Facility_Common",distance=2,interpTime=0,lock=false,minX=-90,maxX=90,rotateY=false,attachBone=0,aperture=1,focusDistance=2},
  [Fox.StrCode32"FacilityAI"]={locName="SSD_Camera_Facility_AI",distance=2.75,interpTime=0,lock=false,minX=-90,maxX=90,rotateY=false,attachBone=0,aperture=1,focusDistance=2.75},
  [Fox.StrCode32"FacilitySkill"]={locName="SSD_Camera_Facility_Skill",distance=2.75,interpTime=0,lock=false,minX=-90,maxX=90,rotateY=false,attachBone=0,aperture=1,focusDistance=2.75},
  [Fox.StrCode32"FacilitySkillInner"]={locName="SSD_Camera_Facility_Skill_Inner",distance=0,interpTime=0,lock=false,minX=-90,maxX=90,rotateY=false,attachBone=0,aperture=1,focusDistance=0},
  [Fox.StrCode32"FacilityPortal"]={locName="SSD_Camera_Facility_Portal",distance=3.25,interpTime=0,lock=false,minX=-90,maxX=90,rotateY=false,attachBone=0,aperture=1,focusDistance=3.25},
  [Fox.StrCode32"FacilityMiningMachine"]={locName="SSD_Camera_Facility_MiningMachine",distance=3.25,interpTime=0,lock=false,minX=-90,maxX=90,rotateY=false,attachBone=0,aperture=1,focusDistance=3.25},
  [Fox.StrCode32"FacilityAccessGate"]={locName="SSD_Camera_Facility_AccessGate",distance=3.25,interpTime=0,lock=false,minX=-90,maxX=90,rotateY=false,attachBone=0,aperture=1,focusDistance=3.25}
}
function this.UpdateCameraParameter(a)
  this.UpdateCameraParameterInterp(a,false,false)
end
function this.UpdateCameraParameterInterp(a,m,c)
  local n=Fox.StrCode32(a)
  local t=l[n]
  if not t then
    return
  end
  local o,i=Tpp.GetLocatorByTransform("SsdPlayerCameraIdentifier",t.locName)
  local r,a=Tpp.GetLocatorByTransform("SsdPlayerCameraIdentifier","PlayerPosition")
  local a={
    distance=t.distance,
    target=r,
    offset=Vector3(o:GetX()-r:GetX(),o:GetY()-r:GetY(),o:GetZ()-r:GetZ()),
    aperture=100,
    targetInterpTime=t.interpTime,
    ignoreCollisionGameObjectId=ignoreCollision,--ORPHAN
    targetIsPlayer=false,
    rotationBasedOnPlayer=false,
    attachBone=t.attachBone,
    rotateY=t.rotateY
  }
  if t.lock then
    a.target=o
    a.offset=Vector3(0,0,0)
  end
  if m then
    a.targetInterpTime=0
  end
  if c then
    a.offset=Vector3(0,o:GetY()-r:GetY(),o:GetZ()-r:GetZ())
  end
  local r=0
  local o=0
  if t.lock then
    a.rotationLimitMinY=180
    a.rotationLimitMaxY=180
    a.rotationLimitMinX=0
    a.rotationLimitMaxX=0
  else
    r=this.QuatToRotX(i)a.rotationLimitMinX=r+t.minX
    a.rotationLimitMaxX=r+t.maxX
    o=this.QuatToRotY(i)
  end
  Player.SetAroundCameraManualMode(true)
  Player.SetAroundCameraManualModeParams(a)
  Player.UpdateAroundCameraManualModeParams()
  Player.RequestToSetCameraRotation{rotX=r,rotY=o,interpTime=a.targetInterpTime}
  Player.RequestToSetCameraStock{direction="right"}
  local e={setterName=n,aperture=t.aperture,focusDistance=t.focusDistance,interpTime=a.targetInterpTime}
  Player.RequestToSetCameraDof(e)
end
function this.UpdateCameraParameterInterpForFacility(a,n,c,t)
  local o=Fox.StrCode32(a)
  local t=l[o]
  if not t then
    return
  end
  local r,i=Tpp.GetLocatorByTransform("SsdPlayerCameraIdentifier",t.locName)
  local a,l=Tpp.GetLocatorByTransform("SsdPlayerCameraIdentifier","PlayerPosition")
  local a={
    distance=t.distance,
    target=c,
    offset=Vector3(r:GetX()-a:GetX(),r:GetY()-a:GetY(),r:GetZ()-a:GetZ()),
    aperture=100,
    targetInterpTime=t.interpTime,
    ignoreCollisionGameObjectId=ignoreCollision,--ORPHAN
    targetIsPlayer=false,
    rotationBasedOnPlayer=false,
    attachBone=0,
    rotateY=t.rotateY
  }
  if t.lock then
    a.target=r
    a.offset=Vector3(0,0,0)
  end
  if n then
    a.targetInterpTime=0
  end
  local r=0
  local n=0
  if t.lock then
    a.rotationLimitMinY=180
    a.rotationLimitMaxY=180
    a.rotationLimitMinX=0
    a.rotationLimitMaxX=0
  else
    r=this.QuatToRotX(i)a.rotationLimitMinX=r+t.minX
    a.rotationLimitMaxX=r+t.maxX
    n=this.QuatToRotY(i)
  end
  Player.SetAroundCameraManualMode(true)
  Player.SetAroundCameraManualModeParams(a)
  Player.UpdateAroundCameraManualModeParams()
  Player.RequestToSetCameraRotation{rotX=r,rotY=n,interpTime=a.targetInterpTime}
  Player.RequestToSetCameraStock{direction="right"}
  local e={setterName=o,aperture=t.aperture,focusDistance=t.focusDistance,interpTime=a.targetInterpTime}
  Player.RequestToSetCameraDof(e)
end
function this.ResetPlayerRotation(e)
  local a,e=Tpp.GetLocatorByTransform("SsdPlayerCameraIdentifier","PlayerPosition")
  Player.WarpToRotation{rotQ=e}
end
return this
