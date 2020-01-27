-- ih_save.lua
-- Save file for IH options
-- While this file is editable, editing an inMission save is likely to cause issues, and it's preferable that you use InfProfiles.lua instead.
-- See Readme for more info
local this={}
this.ihVer=214
this.saveTime=1502482643
this.inMission=false
this.loadToACC=false
this.evars={
	debugMessages=1,
	debugOnUpdate=1,
	debugMode=1,
	debugFlow=1,
}
this.igvars={
}
this.questStates={
}
return this