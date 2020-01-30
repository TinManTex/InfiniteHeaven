-- ih_save.lua
-- Save file for IH options
-- While this file is editable, editing an inMission save is likely to cause issues, and it's preferable that you use InfProfiles.lua instead.
-- See Readme for more info
local this={}
this.loadToACC=false
this.ihVer=234
this.saveTime=1580414060
this.inMission=false
this.evars={
	forceDemoAllowAction=1,
	mbNpc_KAZ=1,
	cam_offsetTargetX=0.871561,
	mbNpc_NURSE_3_FEMALE=1,
	mbNpc_DDS_GROUNDCREW=1,
	cam_isFollowPos=1,
	cam_focalLength=20.0695,
	cam_offsetPosY=1.14872,
	cam_offsetPosX=1.94359,
	mbNpc_DDS_RESEARCHER=1,
	debugMessages=1,
	cam_offsetPosZ=0.51,
	debugFlow=1,
	mbSelectedDemo=14,
	debugOnUpdate=1,
	enableQuickMenu=1,
	enableIHExt=1,
	cam_offsetTargetY=-0.19,
	cam_focusDistance=2.44312,
	mbNpc_CHILD_0=1,
	mbNpc_DOCTOR_0=1,
	mbDemoSelection=1,
	mbNpc_DDS_RESEARCHER_FEMALE=1,
	debugMode=1,
}
this.igvars={
	mis_isGroundStart=false,
	inf_event=false,
	name="IvarsPersist",
	bodyType="",
	bodyTypeExtend="",
	mbRepopDiamondCountdown=4,
	inf_levelSeed=-1794954746,
}
return this