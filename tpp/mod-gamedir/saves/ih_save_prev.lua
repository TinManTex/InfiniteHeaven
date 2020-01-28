-- ih_save.lua
-- Save file for IH options
-- While this file is editable, editing an inMission save is likely to cause issues, and it's preferable that you use InfProfiles.lua instead.
-- See Readme for more info
local this={}
this.loadToACC=false
this.ihVer=234
this.saveTime=1580236105
this.inMission=true
this.evars={
	enableWildCardFreeRoam=1,
	ihSideopsPercentageCount=1,
	customWeaponTableMB_ALL=1,
	enableWalkerGearsFREE=1,
	soldierNightSightDistScale=70,
	customSoldierTypeFREE=16,
	allowHeadGearCombo=1,
	unlockSideOps=2,
	soldierHearingDistScale=85,
	applyPowersToLrrp=1,
	randomizeMineTypes=1,
	revengeModeMB_ALL=1,
	skipLogos=1,
	reinforceLevel_MIN=1,
	disableNoStealthCombatRevengeMission=1,
	balanceHeadGear=1,
	enableMgVsShotgunVariation=1,
	debugMessages=1,
	customWeaponTableFREE=1,
	revengeModeFREE=2,
	itemDropChance=50,
	debugFlow=1,
	enableLrrpFreeRoam=1,
	enableIHExt=1,
	fovaPlayerPartsType=1,
	debugMode=1,
	putEquipOnTrucks=1,
	attackHeliPatrolsMB=4,
	attackHeliPatrolsFREE=5,
	allowMissileWeaponsCombo=1,
	vehiclePatrolClass=1,
	additionalMineFields=1,
	enableSoldiersWithVehicleReinforce=1,
	vehiclePatrolProfile=2,
	customWeaponTableMISSION=1,
	revengeModeMISSION=2,
	enableQuickMenu=1,
	showAllOpenSideopsOnUi=1,
	debugOnUpdate=1,
	enableInfInterrogation=1,
	startOffline=1,
	sideOpsSelectionMode=16,
	enableParasiteEvent=1,
	enableWalkerGearsMB=1,
	mbEnemyHeliColor=1,
	forceSuperReinforce=1,
}
this.igvars={
	mis_isGroundStart=false,
	bodyType="SOVIET_ALL",
	name="IvarsPersist",
	inf_event=false,
	bodyTypeExtend="",
	mbRepopDiamondCountdown=2,
	inf_levelSeed=-740317249,
}
return this