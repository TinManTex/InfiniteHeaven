-- ih_save.lua
-- Save file for IH options
-- While this file is editable, editing an inMission save is likely to cause issues, and it's preferable that you use InfProfiles.lua instead.
-- See Readme for more info
local this={}
this.loadToACC=false
this.ihVer=234
this.saveTime=1580773826
this.inMission=false
this.evars={
	vehiclePatrolProfile=2,
	forceDemoAllowAction=1,
	mbNpc_KAZ=1,
	cam_offsetTargetX=0.871561,
	sideOpsSelectionMode=12,
	mbNpc_DDS_GROUNDCREW=1,
	vehiclePatrolLvEnable=0,
	vehiclePatrolTruckEnable=0,
	cam_isFollowPos=1,
	cam_focalLength=20.0695,
	cam_offsetPosY=1.14872,
	cam_offsetPosX=1.94359,
	mbNpc_DDS_RESEARCHER=1,
	weather_fogDensity=0,
	debugMessages=1,
	vehiclePatrolTankEnable=0,
	vehiclePatrolWavEnable=0,
	cam_offsetTargetY=-0.19,
	cam_offsetPosZ=0.51,
	mbSelectedDemo=14,
	vehiclePatrolClass=5,
	debugOnUpdate=1,
	enableQuickMenu=1,
	mbNpc_CHILD_0=1,
	mbNpc_NURSE_3_FEMALE=1,
	cam_focusDistance=2.44312,
	debugFlow=1,
	debugMode=1,
	mbDemoSelection=1,
	startOnFootFREE=1,
	mbNpc_DOCTOR_0=1,
	enableIHExt=1,
	mbNpc_DDS_RESEARCHER_FEMALE=1,
}
this.igvars={
	mis_isGroundStart=true,
	inf_event=false,
	name="IvarsPersist",
	bodyType="",
	bodyTypeExtend="",
	mbRepopDiamondCountdown=4,
	inf_levelSeed=-1941366638,
}
this.questStates={
	ih_quest_q30100=17,
	ih_quest_q30101=17,
	ih_quest_q30102=17,
}
return this