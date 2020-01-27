-- ih_save.lua
-- Save file for IH options
-- While this file is editable, editing an inMission save is likely to cause issues, and it's preferable that you use InfProfiles.lua instead.
-- See Readme for more info
local this={}
this.ihVer=4
this.saveTime=1522616065
this.inMission=false
this.loadToACC=false
this.evars={
	avatar_enableGenderSelect=1,
	speedCamPlayerTimeScale=1.5,
	disableGameOver=1,
	debugFlow=1,
	disableCommonRadio=1,
	disableOutOfBoundsChecks=1,
	dust_requireOxygenMask=0,
	speedCamContinueTime=1000,
	debugMode=1,
	gear_Inner=8,
	gear_Helmet=29,
	enableHelp=1,
	dust_forceWeather=3,
	dust_wallVisible=0,
	enableQuickMenu=1,
	gear_Arm=11,
	debugMessages=1,
	debugOnUpdate=1,
	enableIHExt=1,
	speedCamWorldTimeScale=0.2,
}
this.igvars={
	mis_isGroundStart=false,
	inf_event=false,
	name=IvarsPersist,
	inf_levelSeed=1,
}
return this