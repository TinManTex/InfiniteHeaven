


CharaTppSupportHelicopter = {



















dependSyncPoints = {
	"Gr",
	"Geo",
	"Nt",
	"Fx",
	"Sd",
	"Noise",
	"Nav",
},

pluginIndexEnumInfoName = "TppHelicopterPluginDefine",


__OnCreate = function( chara )

	local resourceList = {
		parts="parts",
		motionGraph="motionGraph",
		damageSet="damageSet",
		behavior="behavior"
	}
	local locator = chara:GetLocatorHandle()
	if Entity.IsNull(locator) then
		resourceList.parts="/Assets/tpp/parts/mecha/uth/uth0_main0_def.parts"
		resourceList.motionGraph="/Assets/tpp/motion/motion_graph/helicopter/TppHelicopter_layers.fagx"
		resourceList.damageSet="/Assets/tpp/parts/mecha/uth/uth0_main0_def.fdmg"
		resourceList.behavior="Tpp/Scripts/Characters/AiBehavior/SupportHelicopter/AiBehaviorTppSupportHelicopter.aib"
	end
	

	local behavior          = ""
	local behaviorGraphName = "SupportHelicopter"
	if Ai.DoesUseAibFile() then
		behavior          = resourceList.behavior
		behaviorGraphName = ""
	end

	local isSleepPlgPlan = false
	if DEBUG then
		local pref = Preference.GetPreferenceEntity("TppHelicopterPreference")
		if not Entity.IsNull(pref) then
			isSleepPlgPlan = pref.noPlanningMode
		end
	end
	
	local charaObj = chara:GetCharacterObject()
	
	chara:InitPluginPriorities {
		"DemoAction",
		"BasicAction",
		"LightAction",
		"DamageAction",
		"HoveringAction",
		"MoveAction",
		"AttackAction",
	}
	
	chara:AddPlugins{
		
		"PLG_BODY",
		ChBodyPlugin{
			name	= "Body",
			script = "Tpp/Scripts/Characters/Bodies/BodyTppHelicopter.lua",
			parts = resourceList.parts,
			animGraphLayer	= resourceList.motionGraph,
			hasGravity = false,
			
			useCharacterController = false,
			
			maxMotionJoints = { 21, 21, 21, 21 },
			hasTranslations = { true, true, true, true },
			maxMtarFiles = 1,
		},

		
		"PLG_VOICE2",
		ChVoicePlugin2{
			name				= "Voice",
			characterType		= "HqSquad",
			basicArgs			= "PILOT",
		
		
			plgFacial           = false,
		},
		
		
		"PLG_ROUTE",
		AiRoutePlugin{
			name	= "Route",
		},
		
		
		"PLG_NEW_INVENTORY",
		TppHeliInventoryPlugin {
			name			= "NewInventory",
			
			
		},
		
		
		"PLG_PLANNING_OPERATOR",
		AiPlanningOperatorPlugin{
			name			= "PlanningOperator",
			planStepCount		= TppSh.PlanMaxStepCount,
			planValueCount		= TppSh.PlanVaribleSetMaxValueCount,
			behavior		= behavior,
			behaviorGraphName	= behaviorGraphName,
			priority		= "AiOperation",
			exclusiveGroups	= { TppPluginExclusiveGroup.Operator },
			blackboard 		= TppSupportHelicopterAiBlackboard(),
			isSleepStart	= isSleepPlgPlan,
			enableReserveHistory = true,
			reserveHistoryNum = 10,
		},

		
		"PLG_PASSENGER_MANAGE",
		TppPassengerManagePlugin {
			name						= "PassengerManage",
			isPossibleGettingOnInit		= false,
			isPossibleGettingOffInit	= false,
		},
		
		
		"PLG_NAVIGATION",
		ChNavigationPlugin{
			name			= "Navigation",
			sceneName		= "MainScene",
			worldName		= "sky",
			typeName		= "SkyController",
			radius			= 0.5,
			
		},
		
		
		"PLG_SUPPORT_HELICOPTER",
		TppSupportHelicopterPlugin{
			name			= "SupportHelicopter",
		},
		
		
		
		
		
		
		"PLG_ACTION_ROOT",
		ChActionRootPlugin {
			name = "ActionRoot",
		},
		
		












		
		"PLG_LIGHT_ACTION",
		TppHelicopterLightActionPlugin {
			name			=	"LightAction",
			parent			=	"ActionRoot",
			bodyPlugin		=	"Body",
			priority		=	"LightAction",
			layerName		=	{ "Full", "LandingGear", "RightDoor", "LeftDoor" },
			isSleepStart	=	true,
		},

		
		"PLG_MOVE_ACTION",
		TppHelicopterMoveActionPlugin {
			name			=	"MoveAction",
			parent			=	"ActionRoot",
			bodyPlugin		=	"Body",
			priority		=	"MoveAction",
			exclusiveGroups	=	{ TppPluginExclusiveGroup.Move },
			isSleepStart	=  true,
		},
		
		
		"PLG_HOVERING_ACTION",
		TppHelicopterHoveringActionPlugin {
			name			=	"HoveringAction",
			parent			=	"ActionRoot",
			bodyPlugin		=	"Body",
			priority		=	"HoveringAction",
			exclusiveGroups	=	{ TppPluginExclusiveGroup.Move },
			isSleepStart	= true,
		},
		
		
		"PLG_ATTACK_ACTION",
		TppHelicopterAttackActionPlugin {
			name			=	"AttackAction",
			parent			=	"ActionRoot",
			bodyPlugin		=	"Body",
			priority		=	"AttackAction",
			exclusiveGroups	=	{ TppPluginExclusiveGroup.Attack },
		},
		
		
		"PLG_DAMAGE_ACTION",
		TppHelicopterDamageActionPlugin {
			name			= "DamageAction",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			priority		= "DamageAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Attack, TppPluginExclusiveGroup.Move },
			isSleepStart	= true,
		},
		
		
		"PLG_DEMO_ACTION",
		ChDemoActionPlugin{
			name			= "DemoAction",
			script			= "Tpp/Scripts/Characters/Actions/ActionTppDemo.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			priority		= "DemoAction",
			layerName		=	{ "Full", "RightDoor", "LeftDoor", "LandingGear" },
			exclusiveGroups	= { TppPluginExclusiveGroup.Basic, TppPluginExclusiveGroup.Attack, TppPluginExclusiveGroup.Move },
			isSleepStart	= true,
		},
	}
	
	local charaParams = chara:GetParams()
	
	if charaParams.mainRotorBoneName ~= "SKL_003_MAINROTOR" then
		chara:AddPlugins{
			
			"PLG_BASIC_ACTION",
			TppHelicopterBasicActionPlugin {
				name			=	"BasicAction",
				parent			=	"ActionRoot",
				bodyPlugin		=	"Body",
				priority		=	"BasicAction",
				layerName		=	{ "Full", "LandingGear", "RightDoor", "LeftDoor" },
				exclusiveGroups	=	{ TppPluginExclusiveGroup.Basic },
				isSleepStart = true,
			},
		}
	else
		chara:AddPlugins{			
			
			"PLG_BASIC_ACTION",
			TppHelicopterBasicActionPlugin {
				name			=	"BasicAction",
				parent			=	"ActionRoot",
				bodyPlugin		=	"Body",
				priority		=	"BasicAction",
				layerName		=	{ "Full", "RightDoor", "LeftDoor" },
				exclusiveGroups	=	{ TppPluginExclusiveGroup.Basic },
				isSleepStart = true,
			},
		}
	end
end,


__OnReset = function( chara )

	
	local plgPlan = chara:FindPlugin("AiPlanningOperatorPlugin")
	local planExecuter = plgPlan:GetPlanExecuter()
	local bb = planExecuter:GetBlackboard()
	if bb.calledPointPosition == nil then
		bb:AddProperty("Vector3", "calledPointPosition", 1)
	end
	bb.calledPointPosition = Vector3(0,0,0)
	
	
	
	local params = chara:GetParams()
	if params.mainRotorBoneName ~= "SKL_003_MAINROTOR" then
		local plgAction = chara:FindPlugin("TppHelicopterBasicActionPlugin")
		plgAction:SendActionRequest( ChDirectChangeStateActionRequest{ groupName = "stateTakeIn", layerName="LandingGear" } )
		
		
	end
	
	
	local plgNav = chara:FindPlugin("ChNavigationPlugin")
	plgNav:SetUpdateDistance(2)

end,






__OnUpdateDebug = function( chara, desc )

	local pref = Preference.GetPreferenceEntity("TppHelicopterPreference")
	local y = 150
	
	
	if pref.viewAttackActionInfo then
		local plgAttack = chara:FindPlugin("TppHelicopterAttackActionPlugin")
		plgAttack:DebugView(20, y, 15)
		y = y + 150
	end
	
end,

}
