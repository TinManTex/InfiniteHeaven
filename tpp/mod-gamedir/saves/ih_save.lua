-- ih_save.lua
-- Save file for IH options
-- While this file is editable, editing an inMission save is likely to cause issues, and it's preferable that you use InfProfiles.lua instead.
-- See Readme for more info
local this={}
this.ihVer=225
this.saveTime=1520368126
this.inMission=false
this.loadToACC=false
this.evars={
	debugMessages=1,
	debugOnUpdate=1,
	debugFlow=1,
	enableQuickMenu=1,
	debugMode=1,
}
this.igvars={
	mis_isGroundStart=false,
	inf_event=false,
	name=IvarsPersist,
	mbRepopDiamondCountdown=4,
	inf_levelSeed=1,
}
this.questStates={
	ih_quest_q30100=0,
	ih_quest_q30155=0,
	ih_quest_q30205=0,
	ih_quest_q30101=0,
	ih_quest_q30102=0,
}
return this