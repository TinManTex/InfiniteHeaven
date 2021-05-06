










local subtitlesDaemon = SubtitlesDaemon.GetInstance()
if SubtitlesCommand then
	dofile( "/Assets/tpp/ui/Subtitles/script/priorityTable.lua")




end





if TppGameSequence.GetGameTitleName() == "GZ" then
	StoryFlags.SetScript( "/Assets/tpp/level/all_load/gzStoryFlag.lua" )




end
StoryFlags.Initialize()
StoryFlags.SetUsingCheckpointMode( true )


PlayerManager:SetUpTable("Tpp/Scripts/Characters/Player/PlayerTypeTable.lua")
TppPlayerUtility.Initialize()
TppEquipmentParameterManager:SetupTable("Tpp/Scripts/NewCollectibles/MotionInfoTableForTest.lua")
TppCollectibleDataManager:SetupTable("Tpp/Scripts/NewCollectibles/CollectibleIdTable.lua")
dofile( "Tpp/Scripts/NewCollectibles/ParameterTableLoaderAllIn.lua" )


TppGameSequence.LoadResidentBlock("/Assets/tpp/pack/resident/resident01.fpk" ) 
TppPlayerBlockControllerService:RequestLoadResidentBlock("/Assets/tpp/pack/player/resident/pl_resident.fpk")	


dofile( '/Assets/tpp/sound/scripts/motion/setup.lua' )





