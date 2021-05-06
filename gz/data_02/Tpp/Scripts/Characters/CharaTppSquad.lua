


CharaTppSquad = {



















dependSyncPoints = {
	"Nt",
	"Nav",
},

pluginIndexEnumInfoName = "TppSquadPluginIndexDefine",







__OnCreate = function( chara )

	
	local aib = "behavior"
	


		aib = "Tpp/Scripts/Characters/AiBehavior/Squad/AiBehaviorTppSquad.aib"


	

	
	chara:AddPlugins{

		
		"SQUAD_PLG_SQUAD",
		TppSquadBaseSquadPlugin{
			name			= "Squad",
			subSquadScript	= "Tpp/Scripts/Characters/CharaTppSubSquad.lua",
			isActiveInCharaStopping = true,
		},

		
		"SQUAD_PLG_PLANNING_OPERATOR",
		AiPlanningOperatorPlugin{
			name			= "Planning",
			planStepCount		= TppSquad.PlanMaxStepCount,
			planValueCount		= TppSquad.PlanVaribleSetMaxValueCount,
		
		
			behaviorGraphName = "Squad",
			exclusiveGroups	= { TppPluginExclusiveGroup.Operator },
			blackboard		= TppSquadAiBlackboard(),
			enableReserveHistory = true,
			reserveHistoryNum = 10,
		},

	}

	
	local plgPlan = chara:FindPlugin("AiPlanningOperatorPlugin")
	local bb = plgPlan:GetPlanExecuter():GetBlackboard()
	if not bb.useOrderFact then
		chara:AddPlugins{

			
			"SQUAD_PLG_KNOWLEDGE",
			AiKnowledgePlugin{
				name 			= "Knowledge",
			},

			
			"SQUAD_PLG_NOTICE",
			AiNoticePlugin{
				name			= "Notice",
			},

		}
	end

	
	chara:AddPlugins{

		
		"SQUAD_PLG_NAVIGATION",
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
	
	
	if DEBUG then

		
		
		chara:AddPlugins{
	
			
			AiRoutePlugin{
				name			= "Route",
			},
		}
		
	end
end,







__OnReset = function( chara )

	










end,







__OnRealize = function( chara )
	
	local params = chara:GetParams()

	if Entity.IsNull(params) then



		return
	end
	
	
	params.dictateGrenadeWaitMin = 10.0
	params.probDictateGrenadeMin = 0.3
	params.dictateGrenadeWaitMax = 30.0
	params.checkGrenadeWaitTime = 1.0
	params.isUseAroundBhdShift = true
	params.aroundBhdShiftStartWait = 1.0
	
	
	local gameDefaultData = TppDefaultParameter.GetDataFromGroupName( "TppEnemyCombatDefaultParameter" )
	if gameDefaultData ~= NULL and gameDefaultData ~= nil then
		local gameDefaultParams = gameDefaultData:GetParam( "params" )
		if gameDefaultParams ~= NULL then
			params.dictateGrenadeWaitMin = gameDefaultParams.dictateGrenadeWaitMin
			params.probDictateGrenadeMin = gameDefaultParams.probDictateGrenadeMin
			params.dictateGrenadeWaitMax = gameDefaultParams.dictateGrenadeWaitMax
			params.checkGrenadeWaitTime = gameDefaultParams.checkGrenadeWaitTime
			params.isUseAroundBhdShift = gameDefaultParams.isUseAroundBhdShift
			params.aroundBhdShiftStartWait = gameDefaultParams.aroundBhdShiftStartWait
		end
	end

	if DEBUG then
		










		
		if Entity.IsNull(params.squad) then
			
			
			
		end
	end
end,




















}
