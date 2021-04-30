






CharaTppMob = {



















dependSyncPoints = {
	"Gr",
	"Geo",
	"Nt",
	"Fx",
	"Sd",
	"Noise",
	"Nav",
},

pluginIndexEnumInfoName = "TppMobPluginIndexDefine",






OnCreate = function( chara )

	

	
	local voiceType = "ene_a"

	chara:InitPluginPriorities{
		"SpecialAction",
		"DemoAction",
		"BasicAction",
	}

	
	chara:AddPlugins{

		
		"MOB_PLG_BODY",
		ChBodyPlugin{
			name			= "Body",
			parts			= "parts",
			animGraphLayer	= "motionGraph",
			maxMotionPoints	= { 7 },
			geoAttributes	= { "ENEMY" },
		},

		
		"MOB_PLG_ATTACH",
		ChAttachPlugin {
			name = "Attach",
		},
		
		
		"MOB_PLG_PLANNING_OPERATOR",
		AiPlanningOperatorPlugin {
			name			= "Planning",
			behavior		= "behavior",
			exclusiveGroups = { TppPluginExclusiveGroup.Operator }
		},

		
		"MOB_PLG_NAVIGATION",
		ChNavigationPlugin{
			name			= "Nav",
			sceneName		= "MainScene",
			worldName		= "",
			typeName		= "BasicController",
			radius			= 0.45,
			attribute		= {0,0,0,0},
			
		},

		
		"MOB_PLG_KNOWLEDGE",
		TppHumanEnemyKnowledgePlugin{
			name			= "Knowledge",
		},

		
		"MOB_PLG_ROUTE",
		AiRoutePlugin{
			name			= "Route",
		},

		
		"MOB_PLG_HUMAN_ADJUST",
		ChHumanAdjustPlugin{
			name			= "Adjust",
		},

		
		"MOB_PLG_VOICE",
		ChVoicePlugin2{
			name				= "Voice",
			characterType		= "Enemy",
			basicArgs			= voiceType,
			connectPointName	= "CNP_MOUTH",
		},		

		
		"MOB_PLG_EFFECT",
		ChEffectPlugin {
			name			= "Effect",
			bodyPluginName	= "Body",
		},

		
		
		

		
		"MOB_PLG_ACTION_ROOT",
		ChActionRootPlugin{
			name			= "ActionRoot",
		},

		
		"MOB_PLG_DEMO_ACTION",
		ChDemoActionPlugin{
			name			= "DemoAction",
			script			= "Tpp/Scripts/Characters/Actions/ActionTppDemo.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			layerName		= "Lower",
			priority		= "DemoAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Lower, TppPluginExclusiveGroup.Upper },
			isSleepStart	= true,
		},

		
		"MOB_PLG_SPECIAL_ACTION",
		ChSpecialActionPlugin{
			script			= "MgsConception/Scripts/Characters/Actions/ActSpecial.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			layerName		= "Lower",
			priority		= "SpecialAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Lower, TppPluginExclusiveGroup.Upper },
			isSleepStart	= true,
		},

		
		"MOB_PLG_BASIC_ACTION",
		TppBasicActionPlugin {
			name			= "BasicAction",
			script			= "Tpp/Scripts/Characters/Actions/ActionTppMobBasic.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			layerName		= "Lower",
			priority		= "BasicAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Lower },
			isAlwaysAwake	= true,
		},
	}

	
	local desc = chara:GetCharacterDesc()
	desc:SetEnemyType( "Mob" )

	
	local charaObject = chara:GetCharacterObject()
	charaObject:SetupSoundComponent{
		eventConvertScript = "/Assets/tpp/sound/scripts/chara/SoundTppSoldier.lua", 
	}

end,






OnReset = function( chara )
	
end,





OnRelease = function( chara )
	
end,





OnUpdateDebug = function( chara, desc )

	
	TppNpcDebugUtility.UpdateDebugEnemyDesc( chara, desc )

end,

}