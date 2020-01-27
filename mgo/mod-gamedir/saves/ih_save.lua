-- ih_save.lua
-- Save file for IH options
-- While this file is editable, editing an inMission save is likely to cause issues, and it's preferable that you use InfProfiles.lua instead.
-- See Readme for more info
local this={}
this.ihVer=224
this.saveTime=1518856906
this.inMission=false
this.loadToACC=false
this.evars={
	enableIHExt=1,
	enableQuickMenu=1,
	debugFlow=1,
	debugMessages=1,
	debugOnUpdate=1,
	debugMode=1,
}
this.igvars={
	commFacility_aacr001=8,
	field_aacr001=8,
	inf_event=false,
	swamp_aacr001=8,
	powerPlant_aacr001=8,
	fort_aacr001=8,
	inf_levelSeed=1,
	mis_isGroundStart=false,
	banana_aacr001=8,
	tent_aacr001=8,
	remnants_aacr001=8,
	enemyBase_aacr001=8,
	diamond_aacr001=8,
	mbRepopDiamondCountdown=4,
	savannah_aacr001=8,
	cliffTown_aacr001=8,
	slopedTown_aacr001=8,
	sovietBase_aacr001=8,
	hill_aacr001=8,
	flowStation_aacr001=8,
	pfCamp_aacr001=8,
}
return this