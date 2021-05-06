






CharaTppHeliPilot = {



















dependSyncPoints = {
	"Gr",
	"Geo",
	"Nt",
	"Fx",
	"Sd",
	"Noise",
},







OnCreate = function( chara )

	

	
	local voiceType = "ene_a"

	




	
	chara:AddPlugins {

		
		ChBodyPlugin {
			name			= "Body",
			parts			= "parts",

			animGraphLayer	= "motionGraph",
			script			= "Tpp/Scripts/Characters/Bodies/BodyTppPilot.lua",
			maxMotionPoints = { 2 }, 
		},
		
		
		ChAttachPlugin {
			name			= "Attach",
		},
		
		
		TppMotionAdjustModulePlugin{
			name			= "MotionAdjustModule",
			parent			= "Body",
		},

		
		
		
		
		
		

		
		
		
		

		
		
		
		
		

		
		
		

		
		ChActionRootPlugin {
			name			= "ActionRoot",
		},

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