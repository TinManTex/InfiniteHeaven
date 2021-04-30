


CharaTppDog = {



















dependSyncPoints = {
	"Gr",
	"Geo",
	"Fx",
	"Nt",
	"Sd",
	"Noise",
},

pluginIndexEnumInfoName = "TppDogPluginDefine",

OnCreate = function( chara )

	chara:InitPluginPriorities {
		"DemoAction",
		"TailAction",
		"BasicAction",
	}

	chara:AddPlugins {
	
		
		"PLG_BODY",
		ChBodyPlugin{
			name = "Body",
			parts = "parts",
			animGraphLayer	= "motionGraph",
			script			= "Tpp/Scripts/Characters/Bodies/BodyTppDog.lua",
			maxMotionPoints = { 2, 2, 2 },
			extraScaleJoints = 1,
		},

		
		"PLG_EFFECT",
		ChEffectPlugin {
			name			= "Effect",
			bodyPluginName	= "Body",
		},

		
		"PLG_MOTION_SPEED",
		TppCharacterMotionSpeedPlugin {
			name = "TppCharacterMotionSpeed",
			bodyPluginName = "Body"
		},		

		
		
		

		"PLG_ACTION_ROOT",
		ChActionRootPlugin {
			name = "ActionRoot",
		},

		
		"PLG_DEMO_ACTION",
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
		
		"PLG_BASIC_ACTION",

		TppDogBasicActionPlugin {
			name			=	"BasicAction",
			script			=	"Tpp/Scripts/Characters/Actions/ActionTppDogBasic.lua",
			parent			=	"ActionRoot",
			bodyPlugin		=	"Body",
			layerName		=	"Lower",
			priority		=	"BasicAction",
			exclusiveGroups	=	{ TppPluginExclusiveGroup.Lower },
		},

		"PLG_TAIL_ACTION",

		TppDogTailActionPlugin {
			name			=	"TailAction",
			script			=	"Tpp/Scripts/Characters/Actions/ActionTppDogTail.lua",
			parent			=	"ActionRoot",
			bodyPlugin		=	"Body",
			layerName		=	"Tail",
			priority		=	"TailAction",
			exclusiveGroups	=	{ TppPluginExclusiveGroup.Upper },
		}
	}

	
	
	
	
	
	local fxObj = TppAnimalEffectObject {
		objectName = "TppDogEffect",
		effectName = "Dummy",
		animalKind = "Dog",
		effectKind = "FootSmokeStrict",
	}
	local plgEffect = chara:FindPlugin( "ChEffectPlugin" )
	if plgEffect then
	    plgEffect:CallEffect( fxObj )
	    
	end

end,


OnRelease = function( chara )

	
	local plgEffect = chara:FindPlugin( "ChEffectPlugin" )
	if plgEffect then
	    plgEffect:StopEffect( "TppDogEffect" )
	    
	end
	
end,

}
