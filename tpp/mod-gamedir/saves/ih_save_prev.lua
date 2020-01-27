-- ih_save.lua
-- Save file for IH options
-- While this file is editable, editing an inMission save is likely to cause issues, and it's preferable that you use InfProfiles.lua instead.
-- See Readme for more info
local this={}
this.ihVer=209
this.saveTime=1500248939
this.inMission=true
this.loadToACC=false
this.evars={
	enableWildCardFreeRoam=1,
	mbUnlockGoalDoors=1,
	disableGameOver=1,
	mbWalkerGearsColor=7,
	repopulateRadioTapes=1,
	defaultHeliDoorOpenTime=0,
	postExtCommands=1,
	mbShowCodeTalker=1,
	selectEvent=7,
	additionalMineFields=1,
	resourceScalePoster=1000,
	heliPatrolsFREE=1,
	handLevelPhysical=2,
	mbPrioritizeFemale=3,
	speedCamWorldTimeScale=0.2,
	mbCollectionRepop=1,
	customWeaponTableMB_ALL=1,
	mbEnableOcelot=1,
	enableIRSensorsMB=1,
	mbEnableBuddies=1,
	sideOpsSelectionMode=16,
	mbEnableLethalActions=1,
	mbMoraleBoosts=1,
	allowHeadGearCombo=1,
	enableParasiteEvent=1,
	weaponTableStrength=2,
	enableWalkerGearsMB=1,
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
	enableResourceScale=1,
	setLandingZoneWaitHeightTop=10,
	disableNoStealthCombatRevengeMission=1,
	mbWargameFemales=40,
	clockTimeScale=24,
	handLevelPrecision=2,
	debugMessages=1,
	debugOnUpdate=1,
	mbEnableBirds=1,
	mbShowSahelan=1,
	mbAdditionalNpcs=1,
	debugMode=1,
	itemDropChance=80,
	customSoldierTypeMB_ALL=23,
	speedCamPlayerTimeScale=14,
	debugFlow=1,
	enableLrrpFreeRoam=1,
	gameEventChanceMB=30,
	soldierHealthScale=120,
	mbEnemyHeliColor=4,
	mbqfEnableSoldiers=1,
	fovaPlayerPartsType=1,
	soldierParamsProfile=1,
	putEquipOnTrucks=1,
	speedCamNoDustEffect=1,
	allowMissileWeaponsCombo=1,
	mbNpcRouteChange=1,
	vehiclePatrolClass=5,
	enableMgVsShotgunVariation=1,
	heliPatrolsMB=3,
	useSoldierForDemos=1,
	enableQuickMenu=1,
	mbAdditionalSoldiers=1,
	vehiclePatrolProfile=2,
	enableInfInterrogation=1,
	parasitePeriod_MIN=15,
	skipLogos=1,
	revengeDecayOnLongMbVisit=1,
	customSoldierTypeFemaleMB_ALL=1,
	gameEventChanceFREE=5,
	setInvincibleHeli=1,
	enableWalkerGearsFREE=1,
	startOnFootMB_ALL=1,
	maleFaceId=338,
	startOnFootFREE=1,
	resourceScalePlant=1000,
	moveScale=5.5107,
	resourceScaleContainer=1000,
	forceSuperReinforce=2,
	applyPowersToOuterBase=1,
	mbSoldierEquipRange=2,
}
this.igvars={
	mis_isGroundStart=true,
	inf_event=false,
	mbRepopDiamondCountdown=2,
	inf_levelSeed=-1924326758,
}
this.questStates={
	ih_quest_q30106=1,
	ih_quest_q30120=17,
	ih_quest_q30100=17,
	ih_quest_q30105=1,
	ih_quest_q30143=1,
	ih_quest_q30138=17,
	ih_quest_q30155=1,
	ih_quest_q30149=1,
	ih_quest_q30153=17,
	ih_quest_q30104=1,
	ih_quest_q30125=17,
	ih_quest_q30152=17,
	ih_quest_q30109=1,
	ih_quest_q30110=1,
	ih_quest_q30150=1,
	ih_quest_q30133=1,
	ih_quest_q30107=1,
	ih_quest_q30147=17,
	ih_quest_q30123=1,
	ih_quest_q30134=1,
	ih_quest_q30146=1,
	ih_quest_q30145=1,
	ih_quest_q30144=17,
	ih_quest_q30142=17,
	ih_quest_q30141=17,
	ih_quest_q30122=17,
	ih_quest_q30137=1,
	ih_quest_q30139=1,
	ih_quest_q30111=1,
	ih_quest_q30136=1,
	ih_quest_q30135=1,
	ih_quest_q30118=1,
	ih_quest_q30126=1,
	ih_quest_q30116=1,
	ih_quest_q30131=1,
	ih_quest_q30128=17,
	ih_quest_q30140=1,
	ih_quest_q30112=17,
	ih_quest_q30127=1,
	ih_quest_q30148=1,
	ih_quest_q30130=1,
	ih_quest_q30119=17,
	ih_quest_q30108=1,
	ih_quest_q30121=1,
	ih_quest_q30101=17,
	ih_quest_q30114=17,
	ih_quest_q30129=1,
	ih_quest_q30124=1,
	ih_quest_q30113=1,
	ih_quest_q30117=1,
	ih_quest_q30102=17,
	ih_quest_q30151=1,
	ih_quest_q30132=1,
	ih_quest_q30115=1,
}
return this