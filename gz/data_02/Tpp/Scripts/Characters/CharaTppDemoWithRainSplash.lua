


CharaTppDemoWithRainSplash = {



















dependSyncPoints = {
	"Gr",
	"Geo",
	"Nt",
	"Fx",
},






OnCreate = function( chara )

	local params = chara:GetParams()
	local partsPath = params.partsPath




	
	chara:InitPluginPriorities{
		"DemoAction",
	}

	chara:AddPlugins{
		
		ChBodyPlugin{
			name = "Body",
			noControlHeightWithNoMotion = true,
			parts = partsPath,

			isSleepStart = true,
			useCharacterController = false,
			tags = { "Editor", },
			formVariation	= params.formVariationKeyName,	
		},

		
		ChActionRootPlugin{
			name			= "ActionRoot",
			tags			= { "Editor", },
		},

		
		ChDemoActionPlugin{
			script			= "Fox/Scripts/Characters/DemoCharacterAction.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",

			priority		= "DemoAction",
			isSleepStart	= true,
			tags			= { "Editor", },
		},

		
		ChEffectPlugin {
			name			= "Effect",
			bodyPluginName	= "Body",
		},
	}

	
	
	
	
	
	local fxCharaRainSplash = TppCharaRainSplash {
		objectName	      = "TppCharaRainSplash" .. chara:GetLocatorHandle().name, 
		effectName        = "dummy",
		effectBuilderName = "RainSplash",
		effectKindName    = "RainSplashDemoChara",
		isNotUnregisteredWhenUnrealize = true,
	}

	local plgEffect = chara:FindPlugin( "ChEffectPlugin" )
	if plgEffect then
		plgEffect:CallEffect( "TppCharaRainSplash" .. chara:GetLocatorHandle().name, fxCharaRainSplash )
	end

end,





OnRelease = function( chara )

	
	local plgEffect = chara:FindPlugin( "ChEffectPlugin" )
	if plgEffect then
		plgEffect:StopEffect( "TppCharaRainSplash" .. chara:GetLocatorHandle().name )



	end
end,


}
