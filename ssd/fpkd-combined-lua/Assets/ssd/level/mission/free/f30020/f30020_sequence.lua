


local this = BaseFreeMissionSequence.CreateInstance( "f30020" )
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {
	"/Assets/ssd/level/mission/free/f30020/f30020_orderBoxList.lua",
}

this.INITIAL_CAMERA_ROTATION = { 4.7780094146729, 84.010185241699, }












this.missionObjectiveDefine = {
	marker_roam_location_mafr_s10050 = {
		gameObjectName = "marker_roam_location_mafr", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", announceLog = "updateMap", guidelinesId = "guidelines_mission_10050_01",
	},
	marker_roam_location_mafr_k40260 = {
		gameObjectName = "marker_roam_location_mafr", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", announceLog = "updateMap", guidelinesId = "guidelines_mission_40260_01",
	},
	marker_roam_location_mafr_k40270 = {
		gameObjectName = "marker_roam_location_mafr", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", announceLog = "updateMap", guidelinesId = "guidelines_mission_common_wormhole",
	},
	marker_roam_location_mafr_base_defense = {
		gameObjectName = "marker_roam_location_mafr", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", announceLog = "updateMap", guidelinesId = "guidelines_mission_50500",
	},
}

this.missionObjectiveTree = {
	marker_roam_location_mafr_s10050 = {},
	marker_roam_location_mafr_k40260 = {},
	marker_roam_location_mafr_k40270 = {},
	marker_roam_location_mafr_base_defense = {},
}

this.missionObjectiveEnum = Tpp.Enum{
	"marker_roam_location_mafr_s10050",
	"marker_roam_location_mafr_k40260",
	"marker_roam_location_mafr_k40270",
	"marker_roam_location_mafr_base_defense",
}




this.STORY_SEQUENCE_ON_ENTER_TABLE = {}


this.STORY_SEQUENCE_ON_ENTER_TABLE[TppDefine.STORY_SEQUENCE.BEFORE_s10050] = function( self, storySequence )
	Fox.Log( "f30020_sequence: storySequenceOnEnter : " .. tostring( TppStory.GetStorySequenceName(storySequence) ) )
	local isPageOpened = HelpTipsMenuSystem.IsPageOpened( HelpTipsType.TIPS_51_A )
	if isPageOpened == false then
		
		TppTutorial.StartHelpTipsMenu{
			tipsTypes = { HelpTipsType.TIPS_51_A, HelpTipsType.TIPS_51_B, },
			endFunction = function()
				
				TppMission.UpdateObjective{ objectives = { "marker_roam_location_mafr_s10050", }, radio = nil }
				
				TppRadio.Play( "f3010_rtrg2200", { delayTime = "mid" } )
			end,
		}
	else
		
		TppMission.UpdateObjective{ objectives = { "marker_roam_location_mafr_s10050", }, radio = nil }
		
		TppRadio.Play( "f3010_rtrg2200", { delayTime = "mid" } )
	end
end


this.STORY_SEQUENCE_ON_ENTER_TABLE[TppDefine.STORY_SEQUENCE.BEFORE_k40260] = function( self, storySequence )
	Fox.Log( "f30020_sequence: storySequenceOnEnter : " .. tostring( TppStory.GetStorySequenceName(storySequence) ) )
	
	
	TppRadio.Play( "f3010_rtrg2300", { delayTime = "mid" } )
	
	TppMission.UpdateObjective{ objectives = { "marker_roam_location_mafr_k40260", }, radio = nil }
end


this.STORY_SEQUENCE_ON_ENTER_TABLE[TppDefine.STORY_SEQUENCE.BEFORE_k40270] = function( self, storySequence )
	Fox.Log( "f30020_sequence: storySequenceOnEnter : " .. tostring( TppStory.GetStorySequenceName(storySequence) ) )
	
	TppMission.UpdateObjective{ objectives = { "marker_roam_location_mafr_k40270", }, radio = nil }
end


this.STORY_SEQUENCE_ON_ENTER_TABLE[TppDefine.STORY_SEQUENCE.BEFORE_BASE_DEFENSE_TUTORIAL] = function( self, storySequence )
	Fox.Log( "f30020_sequence: storySequenceOnEnter : " .. tostring( TppStory.GetStorySequenceName(storySequence) ) )
	
	TppMission.UpdateObjective{ objectives = { "marker_roam_location_mafr_base_defense", }, radio = nil }
	
	TppRadio.Play( "f3010_rtrg2601", { delayTime = "mid" } )
end


this.STORY_SEQUENCE_ON_ENTER_TABLE[TppDefine.STORY_SEQUENCE.STORY_FINISH] = function( self, storySequence )
	Fox.Log( "f30020_sequence: storySequenceOnEnter : " .. tostring( TppStory.GetStorySequenceName(storySequence) ) )
	
	TppRadio.Play( "f3010_rtrg2900", { delayTime = "mid" } )
end


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
