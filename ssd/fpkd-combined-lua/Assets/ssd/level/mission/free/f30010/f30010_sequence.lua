


local this = BaseFreeMissionSequence.CreateInstance( "f30010" )
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {
	"/Assets/ssd/level/mission/free/f30010/f30010_orderBoxList.lua",
}

this.INITIAL_CAMERA_ROTATION = { 0.83203142881393, -92.580276489258, }








this.missionObjectiveDefine = {
	marker_roam_location_afgh_k40220 = {
		gameObjectName = "marker_roam_location_afgh", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", announceLog = "updateMap", guidelinesId = "guidelines_mission_common_memoryBoard",
	},
	marker_roam_location_afgh_k40250 = {
		gameObjectName = "marker_roam_location_afgh", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", announceLog = "updateMap", guidelinesId = "guidelines_mission_common_coop",
	},
	marker_baseDefenseDiggerSwitch = {
		gameObjectName = "marker_baseDefenseDiggerSwitch", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", announceLog = "updateMap", guidelinesId = "guidelines_mission_50500",
	},
	marker_roam_location_afgh_k40320 = {
		gameObjectName = "marker_roam_location_afgh", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", announceLog = "updateMap", guidelinesId = "guidelines_mission_common_signal",
	},
	marker_roam_location_afgh_k40310 = {
		gameObjectName = "marker_roam_location_afgh", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", announceLog = "updateMap", guidelinesId = "guidelines_mission_common_memoryBoard",
	},
	disable_marker_baseDefenseDiggerSwitch = {},
}

this.missionObjectiveTree = {
	marker_roam_location_afgh_k40220 = {},
	marker_roam_location_afgh_k40250 = {},
	marker_roam_location_afgh_k40320 = {},
	marker_roam_location_afgh_k40310 = {},
	
	disable_marker_baseDefenseDiggerSwitch = {
		marker_baseDefenseDiggerSwitch = {},
	},
}

this.missionObjectiveEnum = Tpp.Enum{
	"marker_roam_location_afgh_k40220",
	"marker_roam_location_afgh_k40250",
	"marker_roam_location_afgh_k40320",
	"marker_roam_location_afgh_k40310",
	"marker_baseDefenseDiggerSwitch",
	"disable_marker_baseDefenseDiggerSwitch",
}




this.STORY_SEQUENCE_ON_ENTER_TABLE = {}


this.STORY_SEQUENCE_ON_ENTER_TABLE[TppDefine.STORY_SEQUENCE.BEFORE_k40220] = function( self, storySequence )
	Fox.Log( "f30010_sequence: storySequenceOnEnter : " .. tostring( TppStory.GetStorySequenceName(storySequence) ) )
	
	TppMission.UpdateObjective{ objectives = { "marker_roam_location_afgh_k40220", }, radio = nil }
	
	local recipeList = {
		"RCP_BLD_WeaponPlant_C",		
		"RCP_BLD_GadgetPlant_C",		
		"RCP_BLD_AccessoryPlant_C",		
		"RCP_BLD_DirtyWaterTank_B",		
		"RCP_BLD_RadioStation_A",		
		"RCP_BLD_RadioTower_A",			
		"RCP_BLD_MedicalPlant_B",		
	}
	for _, recipeName in ipairs( recipeList ) do
		SsdSbm.AddRecipe( recipeName )
	end

	TppRadio.Play( "f3010_rtrg1900", { delayTime = "mid" } )
end


this.STORY_SEQUENCE_ON_ENTER_TABLE[TppDefine.STORY_SEQUENCE.BEFORE_k40250] = function( self, storySequence )
	Fox.Log( "f30010_sequence: storySequenceOnEnter : " .. tostring( TppStory.GetStorySequenceName(storySequence) ) )
	
	TppMission.UpdateObjective{ objectives = { "marker_roam_location_afgh_k40250", }, radio = nil }
end


this.STORY_SEQUENCE_ON_ENTER_TABLE[TppDefine.STORY_SEQUENCE.BEFORE_BASE_DEFENSE_TUTORIAL] = function( self, storySequence )
	Fox.Log( "f30010_sequence: storySequenceOnEnter : " .. tostring( TppStory.GetStorySequenceName(storySequence) ) )
	
	TppMission.UpdateObjective{ objectives = { "marker_baseDefenseDiggerSwitch", }, radio = nil }

	
	local recipeList = {
		"RCP_BLD_Shelter_C",			
		"RCP_BLD_DirtyWaterTank_C",		
		"RCP_BLD_WaterTank_C",			
		"RCP_BLD_FoodStorage_B",		
		"RCP_BLD_MedicalStorage_B",		
		"RCP_BLD_VegetableFarm_C",		
		"RCP_BLD_HerbFarm_C",			
	}
	for _, recipeName in ipairs( recipeList ) do
		SsdSbm.AddRecipe( recipeName )
	end

	local isPageOpened = HelpTipsMenuSystem.IsPageOpened( HelpTipsType.TIPS_43_A )
	if isPageOpened == false then
		TppRadio.Play( { "f3010_rtrg2600" }, { delayTime = "mid" } )	
	else
		TppRadio.Play( "f3010_rtrg2601", { delayTime = "mid" } )
	end

end


this.STORY_SEQUENCE_ON_ENTER_TABLE[TppDefine.STORY_SEQUENCE.BEFORE_k40320] = function( self, storySequence )
	Fox.Log( "f30010_sequence: storySequenceOnEnter : " .. tostring( TppStory.GetStorySequenceName(storySequence) ) )
	
	TppMission.UpdateObjective{ objectives = { "disable_marker_baseDefenseDiggerSwitch", }, radio = nil }
	
	TppMission.UpdateObjective{ objectives = { "marker_roam_location_afgh_k40320", }, radio = nil }
	
	TppRadio.Play( "f3010_rtrg2702", { delayTime = "mid" } )
end


this.STORY_SEQUENCE_ON_ENTER_TABLE[TppDefine.STORY_SEQUENCE.BEFORE_k40310] = function( self, storySequence )
	Fox.Log( "f30010_sequence: storySequenceOnEnter : " .. tostring( TppStory.GetStorySequenceName(storySequence) ) )
	
	TppMission.UpdateObjective{ objectives = { "marker_roam_location_afgh_k40310", }, radio = nil }
	
	TppRadio.Play( "f3010_rtrg2802", { delayTime = "mid" } )
end


this.STORY_SEQUENCE_ON_ENTER_TABLE[TppDefine.STORY_SEQUENCE.STORY_FINISH] = function( self, storySequence )
	Fox.Log( "f30010_sequence: storySequenceOnEnter : " .. tostring( TppStory.GetStorySequenceName(storySequence) ) )
	
	TppRadio.Play( "f3010_rtrg2900", { delayTime = "mid" } )
end




this.AddOnTerminateFunction(
	function()
		
		
		TppWeather.ForceRequestWeather( TppDefine.WEATHER.SUNNY, 0.00 )
	end
)




this.sequences.Seq_Game_MainGame.OnEnter = function( self )
	Fox.Log( tostring( this.missionName ) .. ".sequences.Seq_Game_MainGame.OnEnter()" )
	
	self.OnEnterCommon( self )
	local storySequence = TppStory.GetCurrentStorySequence()
	local storySequenceOnEnter = this.STORY_SEQUENCE_ON_ENTER_TABLE[storySequence]
	if storySequenceOnEnter then
		storySequenceOnEnter( self, storySequence )
	end
end

return this
