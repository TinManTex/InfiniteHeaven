





CharaTppHq = {



















dependSyncPoints = {
	"Nt",
	"Sd",
	"Noise",
	"GroupBehavior",
},

pluginIndexEnumInfoName = "TppHqPluginIndexDefine",






OnCreate = function( chara )

	

	local behavior          = ""
	local behaviorGraphName = "Hq"
	if Ai.DoesUseAibFile() then
		behavior          = "behavior"
		behaviorGraphName = ""
	end

	
	chara:AddPlugins{

		
		"HQ_PLG_SQUAD",
		TppSquadTppHqPlugin{
			name			= "Squad",		
		},

		
		"HQ_PLG_GROUP_BEHAVIOR",
		ChGroupBehaviorPlugin{
			name			= "GroupBehavior",
		},

		
		"HQ_PLG_KNOWLEDGE",
		AiKnowledgePlugin{
			name 			= "Knowledge",
		},

		
		"HQ_PLG_PLANNING_OPERATOR",
		AiPlanningOperatorPlugin {
			name			= "GoalPlanning",
			planStepCount		= TppHq.PlanMaxStepCount,
			planValueCount		= TppHq.PlanVaribleSetMaxValueCount,
			behavior		= behavior,
			behaviorGraphName	= behaviorGraphName,
		},

		
		"HQ_PLG_VOICE",
		ChVoicePlugin2{
			name			= "Voice",
			characterType	= "HqSquad",
			basicArgs		= "hqc",
		},
	}
end,

















































}
