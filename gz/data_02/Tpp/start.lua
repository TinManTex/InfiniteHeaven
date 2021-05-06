





UiDaemon.SetPrefetchTexture( "/Assets/tpp/ui/ModelAsset/cmn_loadmark/Pictures/cmn_loadmark_logo_mini_nmp.ftex" )
UiDaemon.SetPrefetchTexture( "/Assets/tpp/ui/ModelAsset/cmn_loadmark/Pictures/cmn_loadmark_logo_mini.ftex" )













		
		FoxGameFrame.SetGameFrameWaitType ("VirtualVsync");




































AssetConfiguration.RegisterExtensionInfo{
		extensions = {
			"tetl", "tmss", "tmsl", "tlsp", "tmsu", "tmsf", "twpf", "adm", "tevt", "vpc","ends",
		},
		categories = { "Target" }
	}


if TppGameSequence then
    local   gameSequenceController = TppGameSequence:GetInstance()
	
	gameSequenceController:SetPhaseController( TppPhaseController.Create() )
end

if TppHighSpeedCameraManager then
	
	local manager = TppHighSpeedCameraManager.CreateInstance()
end


local checkpointDaemon = CheckpointDaemon{ name = "CheckpointDaemon" }












if GkNoiseSystem then
	
	GkNoiseSystem.InitNoiseSet( "Tpp/Scripts/Noises/TppNoiseDefinitions.lua" )
end


if ChVoiceTaskOrganizer then
	ChVoiceTaskOrganizer.PrepareTaskPool( "Player", 1 )		
	ChVoiceTaskOrganizer.PrepareTaskPool( "Enemy", 8 )		
	ChVoiceTaskOrganizer.PrepareTaskPool( "HqSquad", 1 )	
end

if ChVoiceTaskOrganizer2 then
	ChVoiceTaskOrganizer2.PrepareTaskPool( "Player", 1 )		
	ChVoiceTaskOrganizer2.PrepareTaskPool( "Enemy", 8 )		
	ChVoiceTaskOrganizer2.PrepareTaskPool( "HqSquad", 1 )	
end




TppPlayerDesc.RegisterLifeNames{
	mainLives = { "Life", },
}


TppPadOperatorUtility.Init()

































































if TppCoverPointProvider then



	TppCoverPointProvider.Create()
end





















if GrDaemon then



















			GrTools.LoadShaderPack("shaders/dx11/TppShaders_dx11.fsop")
			dofile( 'shaders/dx11/TppShadersNoLnm_dx11.lua' )
















end



if ChCameraPlugin then
	ChCameraPlugin.SetUpDepthOfField()
end


TppFadeOutEffectHolder.Create()




















if FxDaemon then
	
	
	FxDaemon:InitializeReserveObject( "TppShaderPool" );
	FxDaemon:InitializeReserveObject( "TppTexturePoolManager" );
	
	



		FxSystemConfig.SetLimitInstanceMemorySize( 1024 * 1024 * 24 )
		FxSystemConfig.SetLimitInstanceMemoryDefaultSize( 1024 * 1024 * 24 )






	
end


AssetConfiguration.SetLanguageGroupExtention{
	group = { "Sound" },
	extensions = {
		"mas", "fsm", "sbp", "wem", "evf", "sani", "sad", "stm"
	},
}




















	
	if (TppGameSequence.IsJapanese() == true ) then
		
		AssetConfiguration.SetGroupCurrentLanguage( "Sound", "jpn" )
	else
		
		AssetConfiguration.SetGroupCurrentLanguage( "Sound", "eng" )
	end





if ( TppGameSequence.IsJapanese() == true ) then
	
	SubtitlesCommand.SetVoiceLanguage( "jpn" )
	SubtitlesCommand.SetLanguage( "jpn" )
else
	
	SubtitlesCommand.SetVoiceLanguage( "eng" )
	SubtitlesCommand.SetLanguage( "eng" )
end








	SoundCoreDaemon.SetAssetPath( "/Assets/tpp/sound/asset/" )




SoundCoreDaemon.SetInterferenceRTPCName( "obstruction_rtpc", "occlusion_rtpc" )	
SoundCoreDaemon.SetDopplerRTPCName( "doppler" )		
SoundCoreDaemon.SetRearParameter( "rear_rtpc", 5.0 )	



if TppSoundDaemon then
	local	tppSoundDaemon = TppSoundDaemon{}

	if TppSoundEditorDaemon then
		local	tppSoundEditorDaemon = TppSoundEditorDaemon{}
	end
end


TppRadioObjectCreator.Create()
TppRadioCommand.RegisterTppCommonConditionCheckFunc()





TppRadioConditionUtility.RegisterRadioCommonConditionCheckFunc()






VoiceCommand:SetVoiceTypePriority( 0, 100, 100 )	
VoiceCommand:SetVoiceTypePriority( 1, 1, 0 )	
VoiceCommand:SetVoiceTypePriority( 15, 5, 50 )	
VoiceCommand:SetVoiceTypePriority( 3, 15, 90 )	
VoiceCommand:SetVoiceTypePriority( 6, 12, 20 )	
VoiceCommand:SetVoiceTypePriority( 2, 15, 50 )	
VoiceCommand:SetVoiceTypePriority( 5, 15, 50 )	
VoiceCommand:SetVoiceTypePriority( 14, 47, 50 )	
VoiceCommand:SetVoiceTypePriority( 4, 55, 60 )	
VoiceCommand:SetVoiceTypePriority( 7, 65, 70 )	
VoiceCommand:SetVoiceTypePriority( 8, 65, 70 )	
VoiceCommand:SetVoiceTypePriority( 9, 65, 80 )	
VoiceCommand:SetVoiceTypePriority( 13, 75, 80 )	
VoiceCommand:SetVoiceTypePriority( 10, 75, 90 )	
VoiceCommand:SetVoiceTypePriority( 11, 75, 90 )	
VoiceCommand:SetVoiceTypePriority( 12, 85, 90 )	


VoiceCommand:SetVoiceEventType( 1, "DD_gameover" )	
VoiceCommand:SetVoiceEventType( 2, "DD_ESR" )	
VoiceCommand:SetVoiceEventType( 5, "radio_defo" )	
VoiceCommand:SetVoiceEventType( 6, "DD_Intelmen" ) 
VoiceCommand:SetVoiceEventType( 5, "DD_RTR" )	
VoiceCommand:SetVoiceEventType( 5, "DD_OPR" )	
VoiceCommand:SetVoiceEventType( 5, "DD_TUTR" )	
VoiceCommand:SetVoiceEventType( 5, "DD_missionUQ" )	
VoiceCommand:SetVoiceEventType( 4, "DD_vox_SH_radio" )	 
VoiceCommand:SetVoiceEventType( 4, "DD_vox_SH_voice" )	 
VoiceCommand:SetVoiceEventType( 7, "DD_vox_ene_ld" )	
VoiceCommand:SetVoiceEventType( 7, "DD_vox_cp_radio" )	
VoiceCommand:SetVoiceEventType( 10, "DD_hostage" )	
VoiceCommand:SetVoiceEventType( 10, "DD_Chico" )	
VoiceCommand:SetVoiceEventType( 10, "DD_Paz" )	
VoiceCommand:SetVoiceEventType( 10, "DD_vox_kaz_rt_ld" )	



VoiceCommand:SetVoiceEventType( 13, "DD_vox_ene_conversation" ) 


TppGadgetManager.InitSound()


if Bush then
	Bush.SetParameters {
		
		
		
		rotSpeedMax = foxmath.DegreeToRadian( 1 ),
		
		alphaDistanceMin=1,  alphaDistanceMax=3,
	}
end






	Fox.SetActMode( "GAME" )





Ai.RegisterKnowledgeTags {
	"Character",
	"Player",
	"Enemy",
	"Target",
	"Noise",
	"Damage",
	"TacticalPoint",
	"NoticeObject",
	"NeedTrace",
	"Hurry",
	"OpenAreaClearingInfo",
	"CheckedByComradeDamageS",
	"CheckedByComradeDying",
	"CheckedByComradeFaint",
	"CheckedByComradeEnableImprison",
	"CheckedByComradeLie",
	"CheckedByComradeLieOutOfReach",
	"CheckedByComradeSleep",
	"CheckedByFindFarObject",
	"CheckedByFindFarShadow",
	"CheckedByGrenade",
	"CheckedByNoiseFoot",
	"CheckedByReceivedAttack",
	"CheckedByLostPrisoner",
	"Clearing",
	"GroupSquad",
	"WarningFlare",
	"GroupWarningFlare",
	"RescueHeli",
}




GeoPathService.RegisterPathTag( "Elude", 0 )
GeoPathService.RegisterPathTag( "Jump", 1 )
GeoPathService.RegisterPathTag( "Fence", 2 )
GeoPathService.RegisterPathTag( "StepOn", 3 )
GeoPathService.RegisterPathTag( "Behind", 4 )
GeoPathService.RegisterPathTag( "Urgent", 5 )
GeoPathService.RegisterPathTag( "Pipe", 6 )
GeoPathService.RegisterPathTag( "Climb", 7 )
GeoPathService.RegisterPathTag( "Rail", 8 )
GeoPathService.RegisterPathTag( "ForceFallDown", 9 )



GeoPathService.RegisterEdgeTag( "Stand", 0 )
GeoPathService.RegisterEdgeTag( "Squat", 1 )
GeoPathService.RegisterEdgeTag( "BEHIND_LOW", 2 )
GeoPathService.RegisterEdgeTag( "FenceElude", 3 )
GeoPathService.RegisterEdgeTag( "Elude", 4 )
GeoPathService.RegisterEdgeTag( "Jump", 5 )
GeoPathService.RegisterEdgeTag( "Fence", 6 )
GeoPathService.RegisterEdgeTag( "StepOn", 7 )
GeoPathService.RegisterEdgeTag( "Behind", 8 )
GeoPathService.RegisterEdgeTag( "Urgent", 9 )
GeoPathService.RegisterEdgeTag( "NoEnd", 10 )
GeoPathService.RegisterEdgeTag( "NoStart", 11 )
GeoPathService.RegisterEdgeTag( "FenceJump", 12 )
GeoPathService.RegisterEdgeTag( "Wall", 13 )
GeoPathService.RegisterEdgeTag( "NoWall", 14 )
GeoPathService.RegisterEdgeTag( "ToIdle", 15 )
GeoPathService.RegisterEdgeTag( "EnableFall", 16 )


GeoPathService.RegisterNodeTag( "Edge", 0 )
GeoPathService.RegisterNodeTag( "Cover", 1 )
GeoPathService.RegisterNodeTag( "BEHIND_LOOK_IN", 2 )

GeoPathService.RegisterNodeTag( "CHANGE_TO_60", 3 )

GeoPathService.RegisterNodeTag( "NoTurn", 4 )

GeoPathService.RegisterNodeTag( "BEHIND_STOP", 5 )


GeoPathService.RegisterNodeTag( "NoOut", 6 )

GeoPathService.BindEdgeTag( "Elude", "Wall" )
GeoPathService.BindEdgeTag( "Elude", "NoWall" )
GeoPathService.BindEdgeTag( "Elude", "NoEnd" )
GeoPathService.BindEdgeTag( "Elude", "Urgent" )
GeoPathService.BindEdgeTag( "Elude", "FenceElude" )
GeoPathService.BindEdgeTag( "Elude", "EnableFall" )

GeoPathService.BindEdgeTag( "Urgent", "Wall" )
GeoPathService.BindEdgeTag( "Urgent", "NoEnd" )
GeoPathService.BindEdgeTag( "Urgent", "Urgent" )
GeoPathService.BindEdgeTag( "Urgent", "FenceElude" )

GeoPathService.BindNodeTag( "Behind", "BEHIND_LOOK_IN" )
GeoPathService.BindNodeTag( "Behind", "BEHIND_STOP" )
GeoPathService.BindEdgeTag( "Behind", "BEHIND_LOW" )

GeoPathService.BindEdgeTag( "Jump", "FenceJump" )

GeoPathService.BindNodeTag( "Climb", "Edge" )

GeoPathService.BindNodeTag( "Pipe", "NoTurn" )
GeoPathService.BindNodeTag( "Pipe", "NoOut" )
GeoPathService.BindEdgeTag( "Pipe", "NoEnd" )
GeoPathService.BindEdgeTag( "Pipe", "NoStart" )

GeoPathService.BindEdgeTag( "Fence", "ToIdle" )
GeoPathService.BindEdgeTag( "Fence", "EnableFall" )











local phdaemon = PhDaemon.GetInstance();

PhDaemon.SetUpdateDtMax(1.0/15.0)
PhDaemon.SetWorldMin(Vector3(-4000.0,-1000.0,-4000.0))
PhDaemon.SetWorldMax(Vector3( 4000.0, 3000.0, 4000.0))

phdaemon.SetCollisionGroupState(1,3,false)
phdaemon.SetCollisionGroupState(1,4,true) 
phdaemon.SetCollisionGroupState(1,6,true) 


phdaemon.SetCollisionGroupState(3,3,true) 
phdaemon.SetCollisionGroupState(3,4,true) 
phdaemon.SetCollisionGroupState(3,5,true) 
phdaemon.SetCollisionGroupState(3,6,true) 


phdaemon.SetCollisionGroupState(7,1,false)
phdaemon.SetCollisionGroupState(7,2,false)
phdaemon.SetCollisionGroupState(7,3,false)
phdaemon.SetCollisionGroupState(7,4,false)
phdaemon.SetCollisionGroupState(7,5,false)
phdaemon.SetCollisionGroupState(7,6,false)




dofile( "Tpp/Scripts/Ui/TppUiBootInit.lua" )



TppMotherBaseManager.Create()

















TppCassetteTapeInfo.Setup()
































	TppGameSequence.SetSystemBlockSize(1*1024*1024+10*1024,40.5*1024*1024) 



MissionManager.CreateMissionBlockGroup(30.5*1024*1024)

















	MissionManager.SetDefaultEnemyMotionPackagePath("/Assets/tpp/pack/soldier/motion/TppSoldierGzMotion.fpk")









	
	LocationManager.RegisterLocationInformation(39,3,"/Assets/tpp/pack/ui/gz/title_datas.fpk") 
	LocationManager.RegisterLocationInformation(38,3,"/Assets/tpp/pack/ui/gz/title_datas.fpk") 
	LocationManager.RegisterLocationInformation(40,1,"/Assets/tpp/pack/location/gntn/gntn.fpk") 
	LocationManager.RegisterLocationInformation(45,1,"/Assets/tpp/pack/location/ombs/ombs.fpk")
























	TppPlayerBlockControllerService:SetResidentPackPath("/Assets/tpp/pack/player/resident/pl_resident.fpk")
	TppPlayerBlockControllerService:SetResidentBlockSize(300*1024) 
	TppPlayerBlockControllerService:SetPartsBlockSize(1.8*1024*1024) 
	TppPlayerBlockControllerService:SetMotionBlockSize(15*1024*1024) 
	TppPlayerBlockControllerService:SetMotionPackPath("/Assets/tpp/pack/player/motion/plmot_base_gz.fpk") 
	TppPlayerBlockControllerService:CreateResidentBlockGroup()
	TppPlayerBlockControllerService:CreatePartsBlockGroup(0) 
	TppPlayerBlockControllerService:CreateMotionBlockGroup()







if Player then
	Player.RegisterCommonMotionPackagePath( "DefaultCommonMotion", "/Assets/tpp/pack/player/motion/player2_common_motion.fpk", "/Assets/tpp/motion/motion_graph/player2/TppPlayer2_layers.mog" )
	Player.RegisterCommonMtarPath( "/Assets/tpp/motion/mtar/player2/TppPlayer2_layers.mtar" )
	Player.RegisterPartsPackagePath( "PLTypeNormal", "/Assets/tpp/pack/player/parts/plparts_normal.fpk", "/Assets/tpp/parts/chara/sna/sna0_main0_def_v00.parts" )
	Player.RegisterPartsPackagePath( "PLTypeNormalScarf", "/Assets/tpp/pack/player/parts/plparts_normal_scarf.fpk", "/Assets/tpp/parts/chara/sna/sna0_main1_def_v00.parts" )
	Player.RegisterPartsPackagePath( "PLTypeSneakingSuit", "/Assets/tpp/pack/player/parts/plparts_sneaking_suit.fpk", "/Assets/tpp/parts/chara/sna/sna2_main0_def_v00.parts" )
	Player.RegisterPartsPackagePath( "PLTypeHospital", "/Assets/tpp/pack/player/parts/plparts_hospital.fpk", "/Assets/tpp/parts/chara/sna/sna1_main0_def_v00.parts" )
	Player.RegisterPartsPackagePath( "PLTypeRider", "/Assets/tpp/pack/player/parts/plparts_rider.fpk", "/Assets/tpp/parts/chara/sna/sna3_main0_def_v00.parts" )
	Player.RegisterPartsPackagePath( "PLTypeMGS1", "/Assets/tpp/pack/player/parts/plparts_mgs1.fpk", "/Assets/tpp/parts/chara/sna/sna6_main0_def_v00.parts" )
end


if TppEquipSystem then
	TppEquipSystem.Initialize{
		equipObjectMaxCount = 120,
		equipObjectRealizedMaxCount = 80,
	}
end

if TppRouteAnimationCollector then
	TppRouteAnimationCollector.RegisterGaniPath( "SoldierLookWatch",	"/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_a.gani" );
	TppRouteAnimationCollector.RegisterGaniPath( "SoldierWipeFace",		"/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_d.gani" );
	TppRouteAnimationCollector.RegisterGaniPath( "SoldierYawn",			"/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_f.gani" );
	TppRouteAnimationCollector.RegisterGaniPath( "SoldierSneeze",		"/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_g.gani" );
	TppRouteAnimationCollector.RegisterGaniPath( "SoldierFootStep",		"/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_h.gani" );
	TppRouteAnimationCollector.RegisterGaniPath( "SoldierCough",		"/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_i.gani" );
	TppRouteAnimationCollector.RegisterGaniPath( "SoldierScratchHead",	"/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_o.gani" );
	TppRouteAnimationCollector.RegisterGaniPath( "SoldierHungry",		"/Assets/tpp/motion/SI_game/fani/bodies/enem/enemasr/enemasr_s_pat_idl_act_p.gani" );
end


TppVehicleBlockControllerService:SetHorseBlockSize(3.5*1024*1024)
TppVehicleBlockControllerService:SetHorseBlockPath("/Assets/tpp/pack/horse/horse_block.fpk")
TppVehicleBlockControllerService:SetHorseLocatorBlockSize(16*1024)
TppVehicleBlockControllerService:SetHorseLocatorBlockPath("/Assets/tpp/pack/horse/horse_locator.fpk")
TppVehicleBlockControllerService:SetVehicleBlockSize(4*1024*1024)
TppVehicleBlockControllerService:SetHeliBlockSize(1.90*1024*1024)  
TppVehicleBlockControllerService:SetHeliBlockDefaultPath("/Assets/tpp/pack/heli/support_heli.fpk")



TppCollectibleBlockControllerService:SetBlockInfo( TppCollectibleBlock.BLOCK_COMMON, 1, 1760*1024 )
TppCollectibleBlockControllerService:SetBlockInfo( TppCollectibleBlock.BLOCK_PLAYER_PRIMARY_WEAPON, 1, 0.5*1024*1024 )
TppCollectibleBlockControllerService:SetBlockInfo( TppCollectibleBlock.BLOCK_PLAYER_PRIMARY2_WEAPON, 1, 0.5*1024*1024 )
TppCollectibleBlockControllerService:SetBlockInfo( TppCollectibleBlock.BLOCK_PLAYER_SECONDARY_WEAPON, 1, 0.5*1024*1024 )
TppCollectibleBlockControllerService:SetBlockInfo( TppCollectibleBlock.BLOCK_PLAYER_ITEM, 5, 128*1024 )
TppCollectibleBlockControllerService:SetBlockInfo( TppCollectibleBlock.BLOCK_MISSION_WEAPON, 8, 0.5*1024*1024 )
TppCollectibleBlockControllerService:SetBlockInfo( TppCollectibleBlock.BLOCK_SUPPORT_WEAPON, 6, 0.2*1024*1024 )
TppCollectibleBlockControllerService:SetBlockInfo( TppCollectibleBlock.BLOCK_PLAYER_MOTION, 3, 640*1024 )




















local gameFlags = {
	e20010_cassette = false,
	e20010_xof = false,
	hardmode = false,
	titleBlackOut = false,
	isSkin1Enabled = false,
	isSkin2Enabled = false,
	isLowSkin1Enabled = false,
	isLowSkin2Enabled = false,
	playerSkinMode = 0,
	e20010_beforeBestRank = 0,
	trialOpen = 0,
	rewardNumOfMissionStart = 0,
}

TppGameSequence.RegisterGameFlags( gameFlags )




	MissionManager.RegisterResidentMissionInfo( 20000, 0, "/Assets/tpp/pack/ui/gz/title_datas.fpk", 4, 0xc )

	
	MissionManager.RegisterResidentMissionInfo( 20001, 0, "/Assets/tpp/pack/ui/gz/title_install.fpk", 4, 0xc )
	TppGameSequence.RegisterTitleInformation(3,"",39)














if NavWorldDaemon then



		
		NavWorldDaemon.AddWorld("MainScene", "", 60) 
		NavWorldDaemon.AddWorld("MainScene", "sky" , 1) 








end

































































			
			local uiCommonData = UiCommonDataManager.GetInstance()
			local isLogoSKip = false
			uiCommonData:GzTitlePreSetting( isLogoSKip )

			
			TppGameSequence.RegisterTitleInformation(1,"",39)
			uiCommonData:CreateInstallCheckJob()































TppNewCollectibleModule.InitializeWhenStartLua()























