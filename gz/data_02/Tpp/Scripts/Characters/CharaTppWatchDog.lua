





CharaTppWatchDog = {



















dependSyncPoints = {
	"Gr",
	"Geo",
	"Nt",
	"Fx",
	"Sd",
	"Noise",
	"Nav",
},

pluginIndexEnumInfoName = "TppWatchDogPluginDefine",







__OnCreate = function( chara )
	

	chara:InitPluginPriorities{
		"DamageAction",
		"DownAction",
		"NoticeAction",
		"NormalAction",
	}

	
	
	chara:AddPlugins{

		
		"PLG_WATCHDOG_BODY",
		ChBodyPlugin{
			name			= "Body",
			parts			= "parts",
			animGraphLayer	= "motionGraph",
			script			= "Tpp/Scripts/Characters/Bodies/BodyTppWatchDog.lua",
			maxMotionPoints	= { 2, 2, 2 },
			maxMtarFiles    = 1,
			extraScaleJoints = 1,
			useTwoStepAnim	= true,
			hasTrap			= false,
		},

		
		"PLG_WATCHDOG_EFFECT",
		ChEffectPlugin {
			name			= "Effect",
			bodyPluginName	= "Body",
		},

		
		
		
		
		"PLG_WATCHDOG_NAVIGATION",
		ChNavigationPlugin{
			name			= "Nav",
			sceneName		= "MainScene",
			worldName		= "",
			typeName		= "BasicController",
			turningRadii	= {0.5,1.0},
			radius			= 0.45,
			attribute		= {0,0,0,0},
			
		},

		
		"PLG_WATCHDOG_ROUTE",
		AiRoutePlugin{
			name			= "Route",
		},

		
		"PLG_WATCHDOG_MOTION_SPEED",
		TppCharacterMotionSpeedPlugin {
			name = "TppCharacterMotionSpeed",
			bodyPluginName = "Body"
		},
		
		
		

		
		"PLG_WATCHDOG_ACTION_ROOT",
		ChActionRootPlugin{
			name			= "ActionRoot",
		},

		
		"PLG_WATCHDOG_DAMAGE_ACTION",
		TppWatchDogDamageActionPlugin{
			name			= "DamageAction",
			script			= "Tpp/Scripts/Characters/Actions/ActionTppWatchDogDamage.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			layerName		= "Full",
			priority		= "DamageAction",
			exclusiveGroups = { TppPluginExclusiveGroup.Lower },
			isSleepStart	= true,
		},

		
		"PLG_WATCHDOG_KNOWLEDGE",
		AiKnowledgePlugin{
			name		= "Knowledge",
		},

		
		"PLG_WATCHDOG_EYE",
		TppWatchDogEyePlugin{
			name			= "Eye",
			paramComponent	= TppWatchDogEyeParameterUpdateComponent{ eyeCnp="CNP_EYE", },
			defaultRange			= 20,						
			defaultAngleLeftRight	= ( ( 3.14 / 180 ) * 40 ),	
			defaultAngleUpDown		= ( ( 3.14 / 180 ) * 40 ),	
			params	= {
				"Discovery", GkConeSightCheckParam(),				
			},
			isSightCheckIncludeAttributeAll = false,
		},

		
		"PLG_WATCHDOG_BASIC_ACTION",
		TppWatchDogBasicActionPlugin{
			name			= "BasicAction",
			script			= "Tpp/Scripts/Characters/Actions/ActionTppWatchDogBasic.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			layerName		= { "Full" ,"Neck" },
			priority		= "NormalAction",
			exclusiveGroups = { TppPluginExclusiveGroup.Lower },
			isAlwaysAwake	= true,
		},

		
		"PLG_WATCHDOG_MOTION_ADJUST_MODULE",
		TppMotionAdjustModulePlugin{
			name			= "MotionAdjustModule",
			parent			= "Body",
		},

	}

end,

}
