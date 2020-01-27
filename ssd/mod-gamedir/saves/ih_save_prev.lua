-- ih_save.lua
-- Save file for IH options
-- While this file is editable, editing an inMission save is likely to cause issues, and it's preferable that you use InfProfiles.lua instead.
-- See Readme for more info
local this={}
this.ihVer=224
this.saveTime=1520148115
this.inMission=false
this.loadToACC=false
this.evars={
	enableQuickMenu=1,
	debugFlow=1,
	enableIHExt=1,
	debugMessages=1,
	debugOnUpdate=1,
	debugMode=1,
}
this.igvars={
}
return this