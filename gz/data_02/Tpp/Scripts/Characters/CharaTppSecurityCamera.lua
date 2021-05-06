





CharaTppSecurityCamera = {

















dependSyncPoints = {
	"Gr",
	"Geo",
	"Nt",
	"Fx",
	"Sd",
	"Noise",
},

pluginIndexEnumInfoName = "TppSecurityCameraPluginIndexDefine",






OnCreate = function( chara )
	

	chara:InitPluginPriorities{
		"DamageAction",
		"DemoAction",
		"NoticeAction",
		"NormalAction",
	}

	
	
	chara:AddPlugins{

		
		"PLG_BODY",
		ChBodyPlugin{
			name			= "Body",
			parts			= "parts",
			asStaticModel		= true,
			useCharacterController = false,
			maxMotionJoints = {5},
			hasGravity = false,
		},

		
		"PLG_EFFECT",
		ChEffectPlugin {
			name			= "Effect",
			bodyPluginName	= "Body",
			components = {
			}
		},


		
		
		

		
		"PLG_ROUTE",
		AiRoutePlugin{
			name			= "Route",
		},
		
		
		"PLG_DAMAGE_MODULE",
		TppDamageModulePlugin{
			name			= "DamageModule",
			parent			= "Body",
		},

		
		
		
		
		
		"PLG_ACTION_ROOT",
		ChActionRootPlugin{
			name			= "ActionRoot",
		},
		
		"PLG_KNOWLEDGE",
		AiKnowledgePlugin{
			name		= "Knowledge",
		},

		
		"PLG_EYE",
		TppSecurityCameraEyePlugin{
			name			= "Eye",
			paramComponent	= TppSecurityCameraEyeParameterUpdateComponent{ eyeCnp="CNP_LIGHT", },
			defaultRange			= 20,						
			defaultAngleLeftRight	= ( ( 3.14 / 180 ) * 40 ),	
			defaultAngleUpDown		= ( ( 3.14 / 180 ) * 40 ),	
			params	= {
				"Discovery", GkConeSightCheckParam(),				
			},
			isSightCheckIncludeAttributeAll = false,
		},

		
		"PLG_BASIC_ACTION",
		TppSecurityCameraBasicActionPlugin{
			name			= "BasicAction",
			parent			= "ActionRoot",
			bodyPlugin		= "Body",
			priority		= "NormalAction",
			headName		= "CNP_LIGHT",
			boneNameDirection	= "SKL_001_branch",
			boneNameAngle		= "SKL_002_head",
			isAlwaysAwake	= true,
		},
	
	}
	
	
	CharaTppSecurityCamera.SetLifePlugin( chara )

	if DEBUG then

		chara:AddPlugins{

			
			
			ChAroundCameraPlugin{
				name			= "AroundCamera",
				distance		= 5.5,									
				focalLength		= 19.2,									
				isShake			= true,
				cameraPriority	= "Demo",
				exclusiveGroups	= { TppPluginExclusiveGroup.Camera },
				priority		= "AroundCamera",
				isSleepStart	= true,
			},
		}

	end	
	
end,





OnRealize = function( chara )
end,





OnRelease = function( chara )
	

	
	
end,





OnUpdateDebug = function( chara, desc )

end,




SetLifePlugin = function( chara )
	if chara == nil then
		Ch.Log( chara,  "[SetLifePlugin] chara is nil" )
		return
	end
	
	
	local lifeMax = 1000
	local lifeInitial = lifeMax
	
	chara:AddPlugins
	{
		
		"PLG_LIFE",
		TppSecurityCameraLifePlugin{
			name		= "LifePlugin",
			values		= {
						"Life", ChLifeValue{ max = lifeMax, initial = lifeInitial },	
			},
		},
	}
	
end,


}
