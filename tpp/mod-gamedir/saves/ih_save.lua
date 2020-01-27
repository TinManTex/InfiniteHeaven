-- ih_save.lua
-- Save file for IH options
-- While this file is editable, editing an inMission save is likely to cause issues, and it's preferable that you use InfProfiles.lua instead.
-- See Readme for more info
local this={}
this.loadToACC=false
this.ihVer=230
this.saveTime=1525676191
this.inMission=true
this.evars={
	mbEnableFultonAddStaff=1,
	soldierParamsProfile=1,
	mbWarGamesProfile=2,
	soldierHearingDistScale=50,
	soldierSightDistScale=20,
	enableHelp=1,
	customSoldierTypeMB_ALL=24,
	cam_disableCameraAnimations=1,
	mbHostileSoldiers=1,
	cam_offsetPosY=14,
	cam_offsetPosX=14.2,
	cam_isFollowRot=1,
	debugMessages=1,
	cam_followTime=10000,
	mbEnableBirds=1,
	attackHeliPatrolsMB=4,
	mbEnemyHeli=1,
	sys_increaseMemoryAlloc=1,
	mbNonStaff=1,
	enableQuickMenu=1,
	mbEnableLethalActions=1,
	debugFlow=1,
	debugOnUpdate=1,
	enableIHExt=1,
	cam_isCollisionCheck=1,
	cam_timeToSleep=10000,
	startOnFootMB_ALL=2,
	startOnFootFREE=2,
	cam_isFollowPos=1,
	debugMode=1,
}
this.igvars={
	mis_isGroundStart=true,
	inf_event=false,
	name=IvarsPersist,
	mbRepopDiamondCountdown=4,
	inf_levelSeed=-1782830216,
}
this.questStates={
	ih_quest_q30100=9,
	ih_quest_q30104=9,
	ih_quest_q30155=9,
	ih_quest_q30205=17,
	ih_quest_q30101=17,
	ih_quest_q30102=17,
}
return this