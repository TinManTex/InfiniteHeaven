





CharaTppCommandPost = {



















dependSyncPoints = {
	"Nt",
	"Sd",
	"Noise",
	"Nav",
	"GroupBehavior",
},

pluginIndexEnumInfoName = "TppCommandPostPluginIndexDefine",







__OnCreate = function( chara )

	

	local behavior          = ""
	local behaviorGraphName = "CommandPost"
	if Ai.DoesUseAibFile() then
		behavior          = "behavior"
		behaviorGraphName = ""
	end

	
	chara:AddPlugins{

		
		"CP_PLG_SQUAD",
		TppSquadCpPlugin{
			name			= "Squad",		
			isActiveInCharaStopping = true,
		},

		
		"CP_PLG_GROUP_BEHAVIOR",
		ChGroupBehaviorPlugin{
			name			= "GroupBehavior",
		},

		
		"CP_PLG_KNOWLEDGE",
		AiKnowledgePlugin{
			name			= "Knowledge",
		},

		
		"CP_PLG_PLANNING_OPERATOR",
		AiPlanningOperatorPlugin {
			name			= "GoalPlanning",
			planStepCount		= TppCommandPost.PlanMaxStepCount,
			planValueCount		= TppCommandPost.PlanVaribleSetMaxValueCount,
			behavior		= behavior,
			behaviorGraphName	= behaviorGraphName,
		
			blackboard		= TppCommandPostAiBlackboard(),
		
		
		},

		
		"CP_PLG_VOICE2",
		ChVoicePlugin2{
			name			= "Voice",
			characterType	= "HqSquad",
		},

		
		"CP_PLG_NAVIGATION",
		ChNavigationPlugin{
			name			= "Nav",
			sceneName		= "MainScene",
			worldName		= "",
			typeName		= "BasicController",
			turningRadii	= {0.5,1.0},
			radius			= 0.45,
			attribute		= {0,0,0,0},
			
		},
	}

	Ch.Log( chara,  "##### SquadHQ OK #####" );

end,







__OnReset = function( chara )
	local plgKnow = chara:FindPlugin( "AiKnowledgePlugin" )
	plgKnow:SetKnowledge( "IsSetClearing", AiKnowledgeValue{ value=false } )

	
	
	if chara.captionLife == nil then
		chara:AddProperty( "uint32", "captionLife", 1 )
	end
	chara.captionLife = 0

end,







__OnRealize = function( chara )
	
	local params = chara:GetParams()

	if Entity.IsNull(params) then



		return
	end

	
	local plgVoice2 = chara:FindPlugin("ChVoicePlugin2")
	if not Entity.IsNull(plgVoice2) then
		local voiceType = "cp_a"
		if params.voiceType ~= nil then
			if params.voiceType ~= "" then
				voiceType = params.voiceType
			end
		end
		plgVoice2:SetVoiceType( voiceType )
	end

	if DEBUG then
		
		local behavior = chara:GetParams():GetFile("behavior")
		if Entity.IsNull(behavior) then



		end
	end
end,






__OnRelease = function( chara )
	
	local phaseManager = TppSystemUtility.GetPhaseController()
	phaseManager:SetMinPhaseName("")
	chara:GetCharacterObject():GetPhaseController():SetMinPhaseName("")
end,






__OnUpdateDesc = function( chara, desc )

	
	
	if chara.captionLife > 0 then
		chara.captionLife = chara.captionLife - 1
		
	else
		
	end




end,






__OnUpdateDebug = function( chara, desc )
	TppNpcDebugUtility.UpdateDebugAi( chara )

	
	if DEBUG then
		local preference = Preference.GetPreferenceEntity("TppEnemyPreference")
		if preference then

			
			if preference.viewLastPosition == true then
				local cpObj = chara:GetCharacterObject()
				cpObj:DebugDrawLastPositions()	
			
			end

		end

		local cpPref = Preference.GetPreferenceEntity("TppCommandPostPreference")
		if cpPref then
			
			local cpObj = chara:GetCharacterObject()
			if cpPref.displayBasicInfo then
				cpObj:DebugDisplayBasicInfo()
			end
			
			
			if cpPref.displayRadioInfo then
				if cpObj:DebugIsClosestCpToCamera() then
					cpObj:DebugDisplayRadioGimmickInfo()
				end
			end
			
			
			if cpPref.displaySquadInfo then
				cpObj:DebugDisplaySquadInfo()
			end
		end
	end
end,

}
