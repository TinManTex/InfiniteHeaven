


CharaTppBird = {

  WakeUpStates = {
    "*",
  },


















dependSyncPoints = {
	"Gr",
	"Geo",
	"Fx",
	"Nt",
	"Sd",
	"Noise",
},

pluginIndexEnumInfoName = "TppBirdPluginDefine",

OnCreate = function( chara )

	chara:InitPluginPriorities {
		"BasicAction",
	}

	chara:AddPlugins {
	
		
		"PLG_BODY",
		ChBodyPlugin{
			name = "Body",
			parts = "parts",
			animGraphLayer	= "motionGraph",
            hasTurnXYZ = true,
            hasGravity = false,
			maxMotionJoints = {32},
			hasTranslations = { true },
			maxMtarFiles = 1,
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

		
		"PLG_BIRD_ACTION",
                TppBirdActionPlugin
		{
			name			=	"BasicAction",
			parent			=	"ActionRoot",
			bodyPlugin		=	"Body",
			layerName		=	"Full",
			priority		=	"BasicAction",
		},
	}

end,

}
