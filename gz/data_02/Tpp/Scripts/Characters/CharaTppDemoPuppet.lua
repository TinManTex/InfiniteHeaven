




CharaTppDemoPuppet = {



















dependSyncPoints = {
	"Gr",
	"Geo",
	"Sd",
	"Fx",
},

pluginIndexEnumInfoName = "TppDemoPuppetPluginDefine",






OnCreate = function( chara )
	chara:InitPluginPriorities {
		"Body",
	}
	
	
	chara:AddPlugins{

		
		"PLG_BODY",
		ChBodyPlugin{
			name 			= "MainBody",
			parts			= "parts",
			motionLayers 	= {"Lower",},
			hasGravity		= false,
			useCharacterController = false,
			hasScaleAnimation	= true,
			hasTranslations = { true },
			maxMotionJoints = {21},
			maxMotionPoints = {21},
			priority		= "Body",
		},

		
		"PLG_ATTACH",
		ChAttachPlugin {
			name = "Attach",
		},
		
		
		"PLG_ACTION_ROOT",
		ChActionRootPlugin{
			name			= "ActionRoot",
		},

		
		"PLG_FACIAL",
		ChFacialPlugin {
			name		= "Facial",
			parent		= "MainBody",
			maxMotionJoints     = { 39, 20 },
			maxShaderNodes      = { 7, 7 },
			maxShaderAnimations = { 2, 2 },
			interpTime	= 60.0,
		},

		
		"PLG_EFFECT",
		ChEffectPlugin {
			name 		= "Effect",
			parent		= "MainBody",
		},
	}

end,







OnReset = function( chara )
	
end,
}
