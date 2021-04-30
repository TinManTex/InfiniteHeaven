




CharaTppEquipmentForDemo = {



















dependSyncPoints = {
	"Gr",
	"Geo",
	"Nt",
	"Fx",
	"Sd",
	"Noise",
},

pluginIndexEnumInfoName = "TppEquipmentPluginDefine",

OnCreate = function( chara )

	

	chara:AddPlugins {

		
		"PLG_BODY",
		ChBodyPlugin{
			name			= "Body",
			motionLayers 	= { "Full", },
			useCharacterController	= false,
		},

		
		"PLG_ATTACH",
		TppAttachmentAttachPlugin {
			name		= "Attach",
		},

		
		"PLG_ACTION_ROOT",
		ChActionRootPlugin{
			name			= "ActionRoot",
		},

		
		"PLG_DEMO_ACTION",
		ChDemoActionPlugin{
			parent			= "ActionRoot",
			bodyPlugin		= "Body",

			isSleepStart		= true,
			tags			= { "Editor", },
		},

		
		"PLG_GUN_ACTION",
		TppNewGunActionPlugin {
			name			= "GunAction",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			isSleepStart		= true,
			reticleUiGraphName	= "/Assets/tpp/ui/GraphAsset/StageGame/Weapon/Reticle/reticle_base.uig"
		},

	}

	chara:SetUpdateDescWhenStoppingFlag( true )

end,

}