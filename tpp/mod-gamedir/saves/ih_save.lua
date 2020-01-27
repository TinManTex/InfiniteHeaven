-- ih_save.lua
-- Save file for IH options
-- While this file is editable, editing an inMission save is likely to cause issues, and it's preferable that you use InfProfiles.lua instead.
-- See Readme for more info
local this={}
this.ihVer=211
this.saveTime=1501588192
this.inMission=false
this.loadToACC=false
this.evars={
	enableWildCardFreeRoam=1,
	mbUnlockGoalDoors=1,
	disableGameOver=1,
	mbWalkerGearsColor=7,
	repopulateRadioTapes=1,
	defaultHeliDoorOpenTime=0,
	postExtCommands=1,
	selectEvent=7,
	additionalMineFields=1,
	resourceScalePoster=1000,
	handLevelPhysical=2,
	mbPrioritizeFemale=3,
	speedCamWorldTimeScale=0.2,
	mbCollectionRepop=1,
	enableInfInterrogation=1,
	customWeaponTableMB_ALL=1,
	mbEnableOcelot=1,
	enableWalkerGearsFREE=1,
	enableIRSensorsMB=1,
	mbEnableBuddies=1,
	sideOpsSelectionMode=16,
	soldierParamsProfile=1,
	mbMoraleBoosts=1,
	allowHeadGearCombo=1,
	enableParasiteEvent=1,
	weaponTableStrength=2,
	armorParasiteEnabled=0,
	unlockSideOps=1,
	resourceScaleMaterial=1000,
	playerHealthScale=120,
	resourceScaleDiamond=1000,
	dontOverrideFreeLoadout=1,
	applyPowersToLrrp=1,
	hideAAGatlingsMB=1,
	speedCamContinueTime=1000,
	mbShowShips=1,
	randomizeMineTypes=1,
	revengeModeMB_ALL=2,
	disableOutOfBoundsChecks=1,
	skipLogos=1,
	setLandingZoneWaitHeightTop=10,
	disableNoStealthCombatRevengeMission=1,
	mbWargameFemales=40,
	clockTimeScale=24,
	handLevelPrecision=2,
	debugMessages=1,
	debugOnUpdate=1,
	mbEnableBirds=1,
	mbShowSahelan=1,
	speedCamNoDustEffect=1,
	mbAdditionalNpcs=1,
	debugMode=1,
	mbSoldierEquipRange=2,
	itemDropChance=80,
	speedCamPlayerTimeScale=14,
	debugFlow=1,
	enableLrrpFreeRoam=1,
	mbEnemyHeliColor=4,
	soldierHealthScale=120,
	mbqfEnableSoldiers=1,
	fovaPlayerPartsType=1,
	putEquipOnTrucks=1,
	moveScale=1.2057,
	allowMissileWeaponsCombo=1,
	mbNpcRouteChange=1,
	enableHeliReinforce=1,
	enableWalkerGearsMB=1,
	vehiclePatrolClass=5,
	mbShowCodeTalker=1,
	heliPatrolsMB=3,
	enableQuickMenu=1,
	useSoldierForDemos=1,
	mbEnableLethalActions=1,
	vehiclePatrolProfile=2,
	setInvincibleHeli=1,
	parasitePeriod_MIN=15,
	mbAdditionalSoldiers=1,
	revengeDecayOnLongMbVisit=1,
	customSoldierTypeFemaleMB_ALL=7,
	heliPatrolsFREE=1,
	gameEventChanceFREE=5,
	enableMgVsShotgunVariation=1,
	startOnFootMB_ALL=1,
	maleFaceId=338,
	startOnFootFREE=1,
	resourceScalePlant=1000,
	resourceScaleContainer=1000,
	forceSuperReinforce=2,
	customSoldierTypeMB_ALL=7,
	applyPowersToOuterBase=1,
	enableResourceScale=1,
}
this.igvars={
	mis_isGroundStart=false,
	inf_event=false,
	mbRepopDiamondCountdown=2,
	inf_levelSeed=-688542229,
}
this.questStates={
	ih_quest_q30100=25,
	ih_quest_q30155=17,
	ih_quest_q30101=17,
	ih_quest_q30102=17,
}
return this