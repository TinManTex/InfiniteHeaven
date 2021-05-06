


CharaTppHostage = {



















dependSyncPoints = {
	"Gr",
	"Geo",
	"Nt",
	"Fx",
	"GroupBehavior",
	"Noise",
	"Sd",
},




pluginIndexEnumInfoName = "TppHostagePluginDefine",

AddTppPlugins = function( chara )

	chara:AddPlugins{
		
		"PLG_SPECIAL_ACTION",
		ChSpecialActionPlugin{
			script			= "MgsConception/Scripts/Characters/Actions/ActSpecial.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			layerName		= "Lower",
			priority		= "SpecialAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Lower, TppPluginExclusiveGroup.Upper },
			isSleepStart	= true,
		},

		
		"PLG_FULTON_REVOCERD_ACTION",
		TppFultonRecoveredActionPlugin {
			name			= "FultonRecoveredAction",
			script			= "Tpp/Scripts/Characters/Actions/ActionTppFultonRecovered.lua",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			layerName		= "Lower",
			priority		= "FultonRecoveredAction",
			exclusiveGroups	= { TppPluginExclusiveGroup.Lower },
			isSleepStart	= true,
		},
	}

end,

}
