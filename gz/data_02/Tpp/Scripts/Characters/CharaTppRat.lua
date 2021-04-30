


CharaTppRat = {



















dependSyncPoints = {
	"Gr",
	"Geo",
	"Fx",
	"Nt",
	"Sd",
	"Noise",
},

pluginIndexEnumInfoName = "TppRatPluginDefine",


__OnCreate = function( chara )

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
            geoAttributes = { "ENEMY" },
			maxMotionJoints = {17},
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

		
		"PLG_RAT_ACTION",
                TppRatActionPlugin
		{
			name			=	"BasicAction",
			parent			=	"ActionRoot",
			bodyPlugin		=	"Body",
			layerName		=	"Full",
			priority		=	"BasicAction",
		},

        "PLG_ROUTE",
        AiRoutePlugin
        {
          name = "Route",
        },
	}

end,

}
