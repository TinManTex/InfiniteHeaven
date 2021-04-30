


CharaTppSubSquad = {



















dependSyncPoints = {
	"Nt",
	"Nav",
	"GroupBehavior",
},

pluginIndexEnumInfoName = "TppSquadPluginIndexDefine",







__OnCreate = function( chara )

	

	local behavior          = ""
	local behaviorGraphName = "SubSquad"
	if Ai.DoesUseAibFile() then
		behavior          = "Tpp/Scripts/Characters/AiBehavior/SubSquad/AiBehaviorTppSubSquad.aib"
		behaviorGraphName = ""
	end

	
	chara:AddPlugins{

		
		"SQUAD_PLG_SQUAD",
		TppSquadSubSquadPlugin{
			name			= "Squad",

		},

		
		"SQUAD_PLG_PLANNING_OPERATOR",
		AiPlanningOperatorPlugin{
			name				= "Planning",
			planStepCount		= TppSquad.PlanMaxStepCount,
			planValueCount		= TppSquad.PlanVaribleSetMaxValueCount,
			behavior			= behavior,
			behaviorGraphName	= behaviorGraphName,
			exclusiveGroups		= { TppPluginExclusiveGroup.Operator },
			blackboard			= TppSquadAiBlackboard(),
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

		}
	end

	
	chara:AddPlugins{
		
		
		"SQUAD_PLG_GROUP_BEHAVIOR",
		ChGroupBehaviorPlugin{},
		
		
		
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
		
		
		"SQUAD_PLG_ROUTE",
		AiRoutePlugin{
			name			= "Route",
		},
		
		
		"SQUAD_PLG_SUB_SQUAD_MOVE",
		TppSubSquadMovePlugin{
			name			= "SubSquadMove",
			isSleepStart	= true,
		},
		
		
		"SQUAD_PLG_SUB_SQUAD_ROUTE_MOVE",
		TppSubSquadRouteMovePlugin{
			name			= "SubSquadRouteMove",
			isSleepStart	= true,
		},
		
	}

	
	local desc = GkBasicTacticalSensorLayoutDesc{}
end,


















__OnRealize = function( chara )
	
	local params = chara:GetParams()
	
	
	params.dictateGrenadeWaitMin = 10.0
	params.probDictateGrenadeMin = 0.3
	params.dictateGrenadeWaitMax = 30.0
	params.checkGrenadeWaitTime = 1.0
	params.enableThrowGrenadeLength = 40.0
	params.isUseAroundBhdShift = true
	params.aroundBhdShiftStartWait = 1.0
	
	
	local gameDefaultData = TppDefaultParameter.GetDataFromGroupName( "TppEnemyCombatDefaultParameter" )
	if gameDefaultData ~= NULL and gameDefaultData ~= nil then
		local gameDefaultParams = gameDefaultData:GetParam( "params" )
		if gameDefaultParams ~= NULL then
			params.isThrowGrenade = gameDefaultParams.isThrowGrenade
			params.dictateGrenadeWaitMin = gameDefaultParams.dictateGrenadeWaitMin
			params.probDictateGrenadeMin = gameDefaultParams.probDictateGrenadeMin
			params.dictateGrenadeWaitMax = gameDefaultParams.dictateGrenadeWaitMax
			params.checkGrenadeWaitTime = gameDefaultParams.checkGrenadeWaitTime
			params.enableThrowGrenadeLength = gameDefaultParams.enableThrowGrenadeLength
			params.isUseAroundBhdShift = gameDefaultParams.isUseAroundBhdShift
			params.aroundBhdShiftStartWait = gameDefaultParams.aroundBhdShiftStartWait
		end
	end
end,



























}
