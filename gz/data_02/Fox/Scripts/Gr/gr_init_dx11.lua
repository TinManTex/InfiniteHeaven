




GrTools:EnableTextureStreaming()


GrTools:SetTexturePackLoadConditioningEnable(true)



GrTools.SetDefaultTextureLoadPath( "tmp/")

GrTools.SetReflectionTexture("/Assets/fox/effect/gr_pic/default_reflection.ftex")

GrTools.SetMaterialTexture("/Assets/fox/effect/gr_pic/materials_alp_rgba32_nomip_nrt.ftex")
GrTools.SetMaterialParamBinary("/Assets/fox/effect/gr_pic/material_params.fmtt")


GrTools.SetTerrainMaterialTexture(0
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(1
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain01_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(2
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain02_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(3
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain03_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(4
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain04_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(5
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain05_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(6
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain06_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(7
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain07_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(8
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain08_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(9
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain09_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(10
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain10_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(11
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain11_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(12
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain12_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(13
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain13_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(14
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain14_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )
GrTools.SetTerrainMaterialTexture(15
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain15_bsm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex"
								, "/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex" )



local isEnableDebugPrint      = true 
local isEnableDebug2D         = true 
local isEnableDebugPrimitive  = true 
if Preference then
local edGrDebugDrawSetting = Preference.GetPreferenceEntity("DebugDrawSetting")
if not Entity.IsNull(edGrDebugDrawSetting) then
    isEnableDebugPrint      = edGrDebugDrawSetting.isEnableDebugPrint    
    isEnableDebug2D         = edGrDebugDrawSetting.isEnableDebug2D       
    isEnableDebugPrimitive  = edGrDebugDrawSetting.isEnableDebugPrimitive
end
end





GrRenderPlugin.AddPlugin( GrPluginViewCallback{ pluginName="VIEW_CALLBACK", priority = 0 } )

GrRenderPlugin.AddPlugin( GrPluginModelSetup{ pluginName = "MODEL_SETUP", priority = 1 } )

GrRenderPlugin.AddPlugin( GrPluginOccluder{ pluginName="OCCLUDER", priority = 6 } )

GrRenderPlugin.AddPlugin( GrPluginPrimitiveUnfiltered{ pluginName = "PRIMITIVES_UNFILTERED", priority = 950, isEnableResolveRenderBuffer = false } )

GrRenderPlugin.AddPlugin( GrPluginOverlayModel{ pluginName= "OVERLAY_MODEL", priority=930 } )

GrRenderPlugin.AddPlugin( GrPlugin2D{ pluginName = "DRAW2D", priority = 1573 } )

GrRenderPlugin.AddPlugin( GrPlugin2DFrontmost{ pluginName = "DRAW2D_FRONTMOST", priority = 10000 } )

GrRenderPlugin.AddPlugin( GrPluginLocelReflection { pluginName="LOCAL_REFLECTION", priority=870} )






GrRenderPlugin.AddPlugin( GrPluginPostFilter{ pluginName= "POSTFILTER", priority=900 } )

	
	GrRenderPlugin.AddPlugin( GrPluginTonemap{ pluginName="TONEMAP", priority=150, parentPluginName="POSTFILTER"} )

	
	GrRenderPlugin.AddPlugin( GrPlugin2DShrink{ pluginName = "DRAW2D_SHRINK", priority=400, parentPluginName="POSTFILTER" } )
	
	GrRenderPlugin.AddPlugin( GrPluginMotionBlur{ pluginName= "MOTION_BLUR", priority=500, parentPluginName="POSTFILTER" } )
	
	GrRenderPlugin.AddPlugin( GrPluginColorCorrection{ pluginName="COLOR_CORRECTION", priority=600, parentPluginName="POSTFILTER"} )


GrRenderPlugin.AddPlugin( GrPluginFxaa{ pluginName= "FXAA", priority=901} )



GrRenderPlugin.AddPlugin( GrPluginPrecomputeSky{ pluginName="PRECOMPUTE_SKY", priority=7, isActive=true } )




GrRenderPlugin.AddPlugin( GrPluginDeferredRendering{ pluginName = "DEFERRED", priority = 10 } ) 

	
	GrRenderPlugin.AddPlugin( GrPluginDeferredGeometry{ pluginName="GEOMETRY_PASS", priority=10, parentPluginName ="DEFERRED" } ) 
		
		GrRenderPlugin.AddPlugin( GrPluginTerrainDepth{ pluginName="TERRAIN_DRAW_DEPTH", priority=1, parentPluginName="GEOMETRY_PASS" } )
		
		GrRenderPlugin.AddPlugin( GrPluginDeferredGeometryOpaque{ pluginName="OPAQUE_PASS", priority=5, parentPluginName="GEOMETRY_PASS"} )
		
		GrRenderPlugin.AddPlugin( GrPluginDeferredGeometryMasked{ pluginName="MASK_PASS", priority=10, parentPluginName="GEOMETRY_PASS"} )
		
		GrRenderPlugin.AddPlugin( GrPluginCloneDeferred{ pluginName="DEFERRED_CLONE", priority=15, parentPluginName="GEOMETRY_PASS" } ) 
		
		GrRenderPlugin.AddPlugin( GrPluginTerrain{ pluginName="TERRAIN_DRAW", priority=20, parentPluginName="GEOMETRY_PASS" } )
		
		GrRenderPlugin.AddPlugin( GrPluginDeferredGeometryDecal{ pluginName="DECAL_PASS", priority=30, parentPluginName="GEOMETRY_PASS"} )
		
		GrRenderPlugin.AddPlugin( GrPluginDecal{ pluginName= "DECALS_DEFERRED", priority=100, parentPluginName="GEOMETRY_PASS" } )
		
		
		GrRenderPlugin.AddPlugin( GrPluginCloneDeferred{ pluginName="DEFERRED_CLONEDECAL", priority=105, parentPluginName="GEOMETRY_PASS", DecalType=1 } ) 
		
		GrRenderPlugin.AddPlugin( GrPluginMaterialLayer{ pluginName= "MATERIAL_LAYER", priority=110, parentPluginName="GEOMETRY_PASS" , isActive=true } )

	
	
	
	
	GrRenderPlugin.AddPlugin( GrPluginDeferredShading{ pluginName="SHADING_PASS", priority=20, parentPluginName="DEFERRED" } )
		
		GrRenderPlugin.AddPlugin( GrPluginSphericalHarmonics{ pluginName="PLUGIN_SPHERICALHARMONICS", priority=10, parentPluginName="SHADING_PASS" })
		
		GrRenderPlugin.AddPlugin( GrPluginLocalLight{ pluginName="LOCAL_LIGHTS", priority=20, parentPluginName="SHADING_PASS" } ) 
		
		GrRenderPlugin.AddPlugin( GrPluginShadow{ pluginName= "SUN_SHADOW", priority=30, parentPluginName="SHADING_PASS" } )
		
		GrRenderPlugin.AddPlugin( GrPluginSunlight{ pluginName="SUNLIGHT", priority=40, parentPluginName="SHADING_PASS" } ) 
		
		

	
	
	
	GrRenderPlugin.AddPlugin( GrPluginLineIntegralSSAO{ pluginName="LINEINTEGRAL_SSAO", priority=15, parentPluginName="DEFERRED" } )
	
	
	
	GrRenderPlugin.AddPlugin( GrPluginAmbientObscuranceSSAO{ pluginName="AMBIENTOBSCURANCE_SSAO", priority=18, parentPluginName="DEFERRED" } )




	
	GrRenderPlugin.AddPlugin( GrPluginSky{ pluginName="SKY", priority=20, isActive=true } )
	
	GrRenderPlugin.AddPlugin( GrPluginGlobalVolumetricFog{ pluginName="GLOBAL_VOLUMETRIC_FOG", priority=8, isActive=true } )
	
	GrRenderPlugin.AddPlugin( GrPluginAlphaModel{ pluginName= "ALPHA_MODEL", priority=28 } )
	
	GrRenderPlugin.AddPlugin( GrPluginPrimitive{ pluginName = "PRIMITIVES", priority = 30, shrinkLevel = 1, shrinkFilter="BILATERAL" } )
	
	
	
	
	
	GrRenderPlugin.AddPlugin( GrPluginThermography{ pluginName="THERMOGRAPHY", priority=45 } )
	
	GrRenderPlugin.AddPlugin( GrPluginScreenCapture{ pluginName="SCREEN_CAPTURE", priority=20000 } )






if (GrPluginDebugView ~= nil) then
	GrRenderPlugin.AddPlugin( GrPluginDebugView{ pluginName="DEBUGVIEW", priority=999 } )
end


if (GrPluginPrimitiveDebug ~= nil) then
	GrRenderPlugin.AddPlugin( GrPluginPrimitiveDebug{ pluginName = "PRIMITIVE_DEBUG", priority = 3100, isActive = isEnableDebugPrimitive, isEnableResolveRenderBuffer = false } )
end


if (GrPluginDebugPrimitive ~= nil) then
	GrRenderPlugin.AddPlugin( GrPluginDebugPrimitive{ pluginName="DEBUG_DRAW", priority=1000, isActive=isEnableDebugPrimitive } )
end


if (GrPluginModelDebug ~= nil) then
	GrRenderPlugin.AddPlugin( GrPluginModelDebug{ pluginName = "MODEL_DEBUG", priority=3300 } ) 
end


if (GrPluginDebug2D ~= nil) then
	GrRenderPlugin.AddPlugin( GrPluginDebug2D{ pluginName = "DEBUG_DRAW2D", priority=3400, isActive=isEnableDebug2D } )
end
	
if DEBUG then

	
	
	
	GrRenderPlugin.AddPlugin( GrPluginViewCallback{ pluginName="VIEW_CALLBACK_WIRE", priority = 0, execMode="wireframe" } )
	GrRenderPlugin.AddPlugin( GrPluginModelSetup{ pluginName = "MODEL_SETUP_WIRE", priority = 1, execMode="wireframe" } )
	GrRenderPlugin.AddPlugin( GrPluginOccluder{ pluginName="OCCLUDER_WIRE", priority = 2, execMode="wireframe" } )
	GrRenderPlugin.AddPlugin( GrPluginPrimitive{ pluginName = "PRIMITIVES_WIRE", priority = 800, shrinkLevel = 1, shrinkFilter="BILATERAL", execMode="wireframe" } )
	GrRenderPlugin.AddPlugin( GrPluginPrimitiveUnfiltered{ pluginName = "PRIMITIVES_UNFILTERED_WIRE", priority = 950, execMode="wireframe" } )
	GrRenderPlugin.AddPlugin( GrPlugin2D{ pluginName = "DRAW2D_WIRE", priority = 1573, execMode="wireframe" } )
	GrRenderPlugin.AddPlugin( GrPlugin2DFrontmost{ pluginName = "DRAW2D_FRONTMOST_WIRE", priority = 10000, execMode="wireframe" } )
	GrRenderPlugin.AddPlugin( GrPluginModelWireframe{ pluginName = "MODEL_WIRE", priority = 10, execMode="wireframe" } )
	GrRenderPlugin.AddPlugin( GrPluginTerrainWireframe{ pluginName="TERRAIN_WIRE", priority = 20, execMode="wireframe" } )
	if DEBUG then
		GrRenderPlugin.AddPlugin( GrPluginDebugPrimitive{ pluginName="DEBUG_DRAW_WIRE", priority=3200, execMode="wireframe", isActive=isEnableDebugPrimitive } )
	end
	GrRenderPlugin.AddPlugin( GrPluginModelDebug{ pluginName = "MODEL_DEBUG_WIRE", priority=3300, execMode="wireframe" } ) 
	GrRenderPlugin.AddPlugin( GrPluginDebug2D{ pluginName = "DEBUG_DRAW2D_WIRE", priority=3400, execMode="wireframe", isActive=isEnableDebug2D } )


	
	
	
	GrRenderPlugin.AddPlugin( GrPluginViewCallback{ pluginName="VIEW_CALLBACK_PSEUDO", priority = 0, execMode="pseudoshade" } )
	GrRenderPlugin.AddPlugin( GrPluginModelSetup{ pluginName = "MODEL_SETUP_PSEUDO", priority = 1, execMode="pseudoshade" } )
	GrRenderPlugin.AddPlugin( GrPluginOccluder{ pluginName="OCCLUDER_PSEUDO", priority = 2, execMode="pseudoshade" } )
	GrRenderPlugin.AddPlugin( GrPluginPrimitive{ pluginName = "PRIMITIVES_PSEUDO", priority = 800, shrinkLevel = 1, shrinkFilter="BILATERAL", execMode="pseudoshade" } )
	GrRenderPlugin.AddPlugin( GrPluginPrimitiveUnfiltered{ pluginName = "PRIMITIVES_UNFILTERED_PSEUDO", priority = 950, execMode="pseudoshade" } )
	GrRenderPlugin.AddPlugin( GrPlugin2D{ pluginName = "DRAW2D_PSEUDO", priority = 1573, execMode="pseudoshade" } )
	GrRenderPlugin.AddPlugin( GrPlugin2DFrontmost{ pluginName = "DRAW2D_FRONTMOST_PSEUDO", priority = 10000, execMode="pseudoshade" } )
	GrRenderPlugin.AddPlugin( GrPluginModelPseudoshade{ pluginName = "MODEL_PSEUDO", priority = 10, execMode="pseudoshade" } )
	GrRenderPlugin.AddPlugin( GrPluginTerrainPseudeShade{ pluginName = "TERRAIN_PSEUDO", priority = 20, execMode = "pseudoshade" } )
	if DEBUG then
		GrRenderPlugin.AddPlugin( GrPluginDebugPrimitive{ pluginName="DEBUG_DRAW_PSEUDO", priority=3200, execMode="pseudoshade", isActive=isEnableDebugPrimitive } )
	end
	GrRenderPlugin.AddPlugin( GrPluginModelDebug{ pluginName = "MODEL_DEBUG_PSEUDO", priority=3300, execMode="pseudoshade" } ) 
	GrRenderPlugin.AddPlugin( GrPluginDebug2D{ pluginName = "DEBUG_DRAW2D_PSEUDO", priority=3400, execMode="pseudoshade", isActive=isEnableDebug2D } )

	
	
	GrRenderPlugin.AddPlugin( GrPluginViewCallback{ pluginName="VIEW_CALLBACK_FWD", priority = 0, execMode="forward" } )
	GrRenderPlugin.AddPlugin( GrPluginModelSetup{ pluginName = "MODEL_SETUP_FWD", priority = 1, execMode="forward" } )
	GrRenderPlugin.AddPlugin( GrPluginOccluder{ pluginName="OCCLUDER_FWD", priority = 2, execMode="forward" } )
	GrRenderPlugin.AddPlugin( GrPluginPrimitive{ pluginName = "PRIMITIVES_FWD", priority = 800, shrinkLevel = 1, shrinkFilter="BILATERAL", execMode="forward" } )
	GrRenderPlugin.AddPlugin( GrPluginPrimitiveUnfiltered{ pluginName = "PRIMITIVES_UNFILTERED_FWD", priority = 950, execMode="forward" } )
	GrRenderPlugin.AddPlugin( GrPlugin2D{ pluginName = "DRAW2D_FWD", priority = 1573, execMode="forward" } )
	GrRenderPlugin.AddPlugin( GrPlugin2DFrontmost{ pluginName = "DRAW2D_FRONTMOST_FWD", priority = 10000, execMode="forward" } )
	GrRenderPlugin.AddPlugin( GrPluginForwardRendering{ pluginName= "FORWARD", priority=100, execMode="forward" } )
	  
	  GrRenderPlugin.AddPlugin( GrPluginShadow{ pluginName= "SHADOW_DRAW", priority=1, parentPluginName="FORWARD", execMode="forward" } )
	  
	  GrRenderPlugin.AddPlugin( GrPluginModel{ pluginName= "MODEL", priority=10, parentPluginName="FORWARD", execMode="forward" } )
	  
	  GrRenderPlugin.AddPlugin( GrPluginDecal{ pluginName="DECALS_FORWARD", priority=100, parentPluginName="FORWARD", execMode="forward" } )
	  
		GrRenderPlugin.AddPlugin( GrPluginTerrain{ pluginName="TERRAIN_DRAW", 788, parentPluginName="FORWARD", execMode="forward" } )
	if DEBUG then
		GrRenderPlugin.AddPlugin( GrPluginDebugPrimitive{ pluginName="DEBUG_DRAW_FWD", priority=3200, execMode="forward", isActive=isEnableDebugPrimitive } )
	end
	GrRenderPlugin.AddPlugin( GrPluginModelDebug{ pluginName = "MODEL_DEBUG_FWD", priority=3300, execMode="forward" } ) 

	GrRenderPlugin.AddPlugin( GrPluginDebug2D{ pluginName = "DEBUG_DRAW2D_FWD", priority=3400, execMode="forward", isActive=isEnableDebug2D } )

end 


GrGraphicsSettingManager.SetPluginSettingSelection( 
	{
		allSettings = {
			
			{
				settingName = "PluginShadow",
				settingTable = {
					{ name = "G7"       , DirectionalLightShadowResolution=1024, 
                                          SpotLightLightShadowResolution=512, PointLightLightShadowResolution=1024, CascadeShadowRangeScale=1.0 },
					{ name = "Default"  , DirectionalLightShadowResolution=2048, 
                                          SpotLightLightShadowResolution=512, PointLightLightShadowResolution=1024, CascadeShadowRangeScale=1.0 },
					{ name = "Low"	    , DirectionalLightShadowResolution=1024, 
                                          SpotLightLightShadowResolution=512, PointLightLightShadowResolution=1024, CascadeShadowRangeScale=1.0 },
					{ name = "Midium"   , DirectionalLightShadowResolution=2048,
                                          SpotLightLightShadowResolution=1024, PointLightLightShadowResolution=2048, CascadeShadowRangeScale=1.0 },
					{ name = "High"     , DirectionalLightShadowResolution=4096,
                                           SpotLightLightShadowResolution=2048, PointLightLightShadowResolution=4096, CascadeShadowRangeScale=1.0 },
					{ name = "ExtraHigh", DirectionalLightShadowResolution=8192, 
					   SpotLightLightShadowResolution=4096, PointLightLightShadowResolution=8192, CascadeShadowRangeScale=3.0 }
				},
			},

			
			{
				settingName = "PluginSphericalHarmonics",
				settingTable =  {
					{ name = "G7"       , DrawSphericalHarmonicsMaxCount=64, RejectionLengthBias=0.0 },
					{ name = "Default"  , DrawSphericalHarmonicsMaxCount=64, RejectionLengthBias=0.0 },
					{ name = "Low"      , DrawSphericalHarmonicsMaxCount=64, RejectionLengthBias=0.0 },
					{ name = "High"     , DrawSphericalHarmonicsMaxCount=64, RejectionLengthBias=0.0 },
					{ name = "ExtraHigh", DrawSphericalHarmonicsMaxCount=127, RejectionLengthBias=50.0 },
				},
			},
			{
				settingName = "PluginLocalLight",
				settingTable =  {
					{ name = "G7"       , ShadowCastingStaticLocalLightMaxCount=2, ShadowCastingDynamicLocalLightMaxCount=2,
					  DrawLocalLightMaxCount = 64, LocalLightLodLevelBias=0.0, LocalLightLodMinLevel=0, RejectionLengthBias=0.0 },
					{ name = "Default"  , ShadowCastingStaticLocalLightMaxCount=4, ShadowCastingDynamicLocalLightMaxCount=2,
					  DrawLocalLightMaxCount = 64, LocalLightLodLevelBias=0.0, LocalLightLodMinLevel=0, RejectionLengthBias=0.0 },
					{ name = "Low"      , ShadowCastingStaticLocalLightMaxCount=2, ShadowCastingDynamicLocalLightMaxCount=2,
					  DrawLocalLightMaxCount = 64, LocalLightLodLevelBias=0.0, LocalLightLodMinLevel=0, RejectionLengthBias=0.0 },
					{ name = "High"     , ShadowCastingStaticLocalLightMaxCount=4, ShadowCastingDynamicLocalLightMaxCount=2,
					  DrawLocalLightMaxCount = 64, LocalLightLodLevelBias=0.0, LocalLightLodMinLevel=0, RejectionLengthBias=0.0 },
					{ name = "ExtraHigh", ShadowCastingStaticLocalLightMaxCount=8, ShadowCastingDynamicLocalLightMaxCount=4,
					  DrawLocalLightMaxCount = 128, LocalLightLodLevelBias=-0.5, LocalLightLodMinLevel=0, RejectionLengthBias=200.0 },
				},
			},

			
			{
				settingName = "PluginModel",
				settingTable =  {
					{ name = "G7"       , RejectionLengthBias=0.0 },
					{ name = "Default"  , RejectionLengthBias=0.0 },
					{ name = "Low"      , RejectionLengthBias=0.0 },
					{ name = "Midium"   , RejectionLengthBias=0.0 },
					{ name = "High"     , RejectionLengthBias=0.0 },
					{ name = "ExtraHigh", RejectionLengthBias=64.0 },
				},
			},
			{
				settingName = "PluginClone",
				settingTable =  {
					{ name = "G7"       , RejectionLengthBias=0.0 },
					{ name = "Default"  , RejectionLengthBias=0.0 },
					{ name = "Low"      , RejectionLengthBias=0.0 },
					{ name = "Midium"   , RejectionLengthBias=0.0 },
					{ name = "High"     , RejectionLengthBias=0.0 },
					{ name = "ExtraHigh", RejectionLengthBias=250.0 },
				},
			},
			
			{
			    settingName = "TextureQualitySettings",
				settingTable = {
					{name = "G7"        ,mode=1, VramMBSize=400  ,AdaptorFactor=0.2  ,LargeRatio= 0,MiddleRatio=95,SmallRatio=25},
					{name = "Low"       ,mode=1, VramMBSize=400  ,AdaptorFactor=0.2  ,LargeRatio= 0,MiddleRatio=95,SmallRatio=25},
					{name = "Midium"    ,mode=0, VramMBSize=800  ,AdaptorFactor=0.5  ,LargeRatio=50,MiddleRatio=45,SmallRatio=25},
					{name = "High"      ,mode=0, VramMBSize=1280 ,AdaptorFactor=0.75 ,LargeRatio=90,MiddleRatio= 5,SmallRatio=25},
					{name = "Default"   ,mode=0, VramMBSize=1280 ,AdaptorFactor=0.75 ,LargeRatio=90,MiddleRatio= 5,SmallRatio=25},
					{name = "ExtraHigh" ,mode=1, VramMBSize=1600 ,AdaptorFactor=0.85 ,LargeRatio=90,MiddleRatio= 5,SmallRatio=25},
				}
			},
			
			{
				settingName = "PluginDof",
				settingTable =  {
					{ name = "G7"       , EnableFilter=1, QuarityType=0 },
					{ name = "Default"  , EnableFilter=1, QuarityType=0 },
					{ name = "Off"      , EnableFilter=0, QuarityType=0 },
					{ name = "Low"      , EnableFilter=0, QuarityType=0 },
					{ name = "High"     , EnableFilter=1, QuarityType=0 },
					{ name = "ExtraHigh", EnableFilter=1, QuarityType=1 },
				},
			},
			{
				settingName = "PluginFxaa",
				settingTable =  {
					{ name = "G7"       , EnableFilter=1 },
					{ name = "Default"  , EnableFilter=1 },
					{ name = "Off"      , EnableFilter=0 },
					{ name = "Low"      , EnableFilter=0 },
					{ name = "High"     , EnableFilter=1 },
					{ name = "ExtraHigh", EnableFilter=1 },
				},
			},
			{
				settingName = "PluginSsao",
				settingTable =  {
					{ name = "G7"       , EnableFilter=1 },
					{ name = "Default"  , EnableFilter=1 },
					{ name = "Off"      , EnableFilter=0 },
					{ name = "Low"      , EnableFilter=0 },
					{ name = "High"     , EnableFilter=1 },
					{ name = "ExtraHigh", EnableFilter=1 },
				},
			},
			{
				settingName = "PluginSao",
				settingTable =  {
					{ name = "G7"       , EnableFilter=0 },
					{ name = "Default"  , EnableFilter=0 },
					{ name = "Off"      , EnableFilter=0 },
					{ name = "Low"      , EnableFilter=0 },
					{ name = "High"     , EnableFilter=0 },
					{ name = "ExtraHigh", EnableFilter=1 },
				},
			},
			{
				settingName = "PluginMotionBlur",
				settingTable =  {
					{ name = "G7"       , EnableFilter=0 },
					{ name = "Default"  , EnableFilter=1 },
					{ name = "Off"      , EnableFilter=0 },
					{ name = "Low"      , EnableFilter=0 },
					{ name = "High"     , EnableFilter=1 },
					{ name = "ExtraHigh", EnableFilter=1 },
				},
			},
			{
				settingName = "PluginToneMap",
				settingTable =  {
					{ name = "G7"       , EnableBloom=1 },
					{ name = "Default"  , EnableBloom=1 },
					{ name = "Off"      , EnableBloom=0 },
					{ name = "Low"      , EnableBloom=1 },
					{ name = "High"     , EnableBloom=1 },
					{ name = "ExtraHigh", EnableBloom=1 },
				},
			},
			{
				settingName = "PluginLocalReflection",
				settingTable =  {
					{ name = "G7"       , EnableFilter=0 },
					{ name = "Default"  , EnableFilter=0 },
					{ name = "Off"      , EnableFilter=0 },
					{ name = "Low"      , EnableFilter=0 },
					{ name = "High"     , EnableFilter=0 },
					{ name = "ExtraHigh", EnableFilter=1 },
				},
			},
		}
	}
 )

