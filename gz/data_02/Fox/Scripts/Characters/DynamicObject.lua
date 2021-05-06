




DynamicObject = {



















dependSyncPoints = {
	"Gr",
	"Geo",
	"Sd",
	"Noise",
},







OnCreate = function( chara )

	chara:InitPluginPriorities {
		"Body",
		
		"DemoAction",
		"NormalAction",
	}

	
	chara:AddPlugins{

		
		ChBodyPlugin{
			parts			= "parts",
			damageSet		= "damageSet",
			
			motionLayers 	= {"Full",},
			hasGravity = false,
			useCharacterController = false,
			
			priority		= "Body",
		},

		













		
		
		

		
		ChActionRootPlugin{
			name			= "ActionRoot",
		},
		
		
		ChDemoActionPlugin{
			
			parent			= "ActionRoot",
			bodyPlugin		= "MainBody",
			
			priority		= "DemoAction",
			tags			= { "Editor", },
			
			isSleepStart		= true,
		},
		
		
		ChActionPlugin{
			name			= "BasicAction",
			parent			= "ActionRoot",
			priority		= "NormalAction",
		},

	}

end,







OnReset = function( chara )

	local plgBody = chara:FindPlugin( "ChBodyPlugin" )
	

	if not Entity.IsNull( plgBody ) then

		local locator = chara:GetLocatorHandle()
		local fileResources = locator.params.fileResources

		local motion = ""
		local motionKey = "motion"

		if fileResources.resources[ motionKey ] ~= nil
		and fileResources.resources[ motionKey ] ~= ""
		and fileResources.resources[ motionKey ] ~= "Null File" then
			motion = motionKey
			plgBody:SetMotion( "Full", motion )
		end

		
		
		
		
	end

end,

}
