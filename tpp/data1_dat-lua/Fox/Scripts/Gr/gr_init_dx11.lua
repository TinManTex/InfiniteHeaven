GrTools:EnableTextureStreaming()
GrTools:SetTexturePackLoadConditioningEnable(true)
GrTools.SetDefaultTextureLoadPath"tmp/"
GrTools.SetReflectionTexture"/Assets/fox/effect/gr_pic/default_reflection.ftex"
GrTools.SetMaterialTexture"/Assets/fox/effect/gr_pic/steam/materials_alp_rgba32_nomip_nrt.ftex"
GrTools.SetMaterialParamBinary"/Assets/fox/effect/gr_pic/steam/material_params.fmtt"
GrTools.SetTerrainMaterialTexture(0,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(1,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain01_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(2,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain02_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(3,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain03_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(4,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain04_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(5,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain05_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(6,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain06_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(7,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain07_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(8,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain08_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(9,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain09_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(10,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain10_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(11,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain11_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(12,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain12_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(13,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain13_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(14,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain14_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
GrTools.SetTerrainMaterialTexture(15,"/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain15_bsm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_nrm.ftex","/Assets/fox/environ/terrain_def_tex/sourceimages/initterrain00_srm.ftex")
local e=true
if not AssetConfiguration.IsDiscOrHddImage()then
e=AssetConfiguration.GetConfigurationFromAssetManager"EnableWindowsDX11Texture"
end
GrTools.SetGen8RenderingMode(e)
local r=true
local i=true
local e=true
if Preference then
local n=Preference.GetPreferenceEntity"DebugDrawSetting"if not Entity.IsNull(n)then
r=n.isEnableDebugPrint
i=n.isEnableDebug2D
e=n.isEnableDebugPrimitive
end
end
GrRenderPlugin.AddPlugin(GrPluginViewCallback{pluginName="VIEW_CALLBACK",priority=0})GrRenderPlugin.AddPlugin(GrPluginModelSetup{pluginName="MODEL_SETUP",priority=1})GrRenderPlugin.AddPlugin(GrPluginOccluder{pluginName="OCCLUDER",priority=6})GrRenderPlugin.AddPlugin(GrPluginPrimitiveUnfiltered{pluginName="PRIMITIVES_UNFILTERED",priority=950,isEnableResolveRenderBuffer=false})GrRenderPlugin.AddPlugin(GrPluginOverlayModel{pluginName="OVERLAY_MODEL",priority=930})GrRenderPlugin.AddPlugin(GrPlugin2D{pluginName="DRAW2D",priority=1573})GrRenderPlugin.AddPlugin(GrPlugin2DFrontmost{pluginName="DRAW2D_FRONTMOST",priority=1e4})GrRenderPlugin.AddPlugin(GrPluginLocelReflection{pluginName="LOCAL_REFLECTION",priority=30})GrRenderPlugin.AddPlugin(GrPluginPostFilter{pluginName="POSTFILTER",priority=900})GrRenderPlugin.AddPlugin(GrPluginTonemap{pluginName="TONEMAP",priority=150,parentPluginName="POSTFILTER"})GrRenderPlugin.AddPlugin(GrPluginDepthOfField{pluginName="DEPTH_OF_FIELD",priority=200,parentPluginName="POSTFILTER"})GrRenderPlugin.AddPlugin(GrPlugin2DShrink{pluginName="DRAW2D_SHRINK",priority=400,parentPluginName="POSTFILTER"})GrRenderPlugin.AddPlugin(GrPluginMotionBlur{pluginName="MOTION_BLUR",priority=500,parentPluginName="POSTFILTER"})GrRenderPlugin.AddPlugin(GrPluginColorCorrection{pluginName="COLOR_CORRECTION",priority=600,parentPluginName="POSTFILTER"})GrRenderPlugin.AddPlugin(GrPluginFxaa{pluginName="FXAA",priority=901,isActive=false})GrRenderPlugin.AddPlugin(GrPluginPrecomputeSky{pluginName="PRECOMPUTE_SKY",priority=7,isActive=true})GrRenderPlugin.AddPlugin(GrPluginDeferredRendering{pluginName="DEFERRED",priority=10})GrRenderPlugin.AddPlugin(GrPluginDeferredGeometry{pluginName="GEOMETRY_PASS",priority=10,parentPluginName="DEFERRED"})GrRenderPlugin.AddPlugin(GrPluginTerrainDepth{pluginName="TERRAIN_DRAW_DEPTH",priority=1,parentPluginName="GEOMETRY_PASS"})GrRenderPlugin.AddPlugin(GrPluginDeferredGeometryOpaque{pluginName="OPAQUE_PASS",priority=5,parentPluginName="GEOMETRY_PASS"})GrRenderPlugin.AddPlugin(GrPluginDeferredGeometryMasked{pluginName="MASK_PASS",priority=10,parentPluginName="GEOMETRY_PASS"})GrRenderPlugin.AddPlugin(GrPluginCloneDeferred{pluginName="DEFERRED_CLONE",priority=15,parentPluginName="GEOMETRY_PASS"})GrRenderPlugin.AddPlugin(GrPluginTerrain{pluginName="TERRAIN_DRAW",priority=20,parentPluginName="GEOMETRY_PASS"})GrRenderPlugin.AddPlugin(GrPluginDeferredGeometryDecal{pluginName="DECAL_PASS",priority=30,parentPluginName="GEOMETRY_PASS"})GrRenderPlugin.AddPlugin(GrPluginDecal{pluginName="DECALS_DEFERRED",priority=100,parentPluginName="GEOMETRY_PASS"})GrRenderPlugin.AddPlugin(GrPluginCloneDeferred{pluginName="DEFERRED_CLONEDECAL",priority=105,parentPluginName="GEOMETRY_PASS",DecalType=1})GrRenderPlugin.AddPlugin(GrPluginRawDecal{pluginName="DEFERRED_RAWDECAL",priority=109,parentPluginName="GEOMETRY_PASS",DecalType=0})GrRenderPlugin.AddPlugin(GrPluginMaterialLayer{pluginName="MATERIAL_LAYER",priority=110,parentPluginName="GEOMETRY_PASS",isActive=true})GrRenderPlugin.AddPlugin(GrPluginDeferredShading{pluginName="SHADING_PASS",priority=20,parentPluginName="DEFERRED"})GrRenderPlugin.AddPlugin(GrPluginSphericalHarmonics{pluginName="PLUGIN_SPHERICALHARMONICS",priority=10,parentPluginName="SHADING_PASS"})GrRenderPlugin.AddPlugin(GrPluginLocalLight{pluginName="LOCAL_LIGHTS",priority=20,parentPluginName="SHADING_PASS"})GrRenderPlugin.AddPlugin(GrPluginShadow{pluginName="SUN_SHADOW",priority=30,parentPluginName="SHADING_PASS"})GrRenderPlugin.AddPlugin(GrPluginSunlight{pluginName="SUNLIGHT",priority=40,parentPluginName="SHADING_PASS"})GrRenderPlugin.AddPlugin(GrPluginSubSurfaceScatter{pluginName="SUBSURFACE_SCATTER",priority=60,parentPluginName="SHADING_PASS"})GrRenderPlugin.AddPlugin(GrPluginLineIntegralSSAO{pluginName="LINEINTEGRAL_SSAO",priority=15,parentPluginName="DEFERRED"})GrRenderPlugin.AddPlugin(GrPluginAmbientObscuranceSSAO{pluginName="AMBIENTOBSCURANCE_SSAO",priority=18,parentPluginName="DEFERRED"})GrRenderPlugin.AddPlugin(GrPluginSky{pluginName="SKY",priority=20,isActive=true})GrRenderPlugin.AddPlugin(GrPluginGlobalVolumetricFog{pluginName="GLOBAL_VOLUMETRIC_FOG",priority=8,isActive=true})GrRenderPlugin.AddPlugin(GrPluginAlphaModel{pluginName="ALPHA_MODEL",priority=28})GrRenderPlugin.AddPlugin(GrPluginWormhole{pluginName="WORMHOLE",priority=29})GrRenderPlugin.AddPlugin(GrPluginPrimitive{pluginName="PRIMITIVES",priority=31,shrinkLevel=1,shrinkFilter="BILATERAL"})GrRenderPlugin.AddPlugin(GrPluginOpticalCamouflage{pluginName="OPTICAL_CAMOUFLAGE",priority=40})GrRenderPlugin.AddPlugin(GrPluginThermography{pluginName="THERMOGRAPHY",priority=45})GrRenderPlugin.AddPlugin(GrPluginScreenCapture{pluginName="SCREEN_CAPTURE",priority=2e4})
if GrPluginDebugView then
GrRenderPlugin.AddPlugin(GrPluginDebugView{pluginName="DEBUGVIEW",priority=3e3})
end
if(GrPluginDebugPrimitive~=nil)then
GrRenderPlugin.AddPlugin(GrPluginDebugPrimitive{pluginName="DEBUG_DRAW",priority=3050,isActive=e})
end
if GrPluginPrimitiveDebug then
GrRenderPlugin.AddPlugin(GrPluginPrimitiveDebug{pluginName="PRIMITIVE_DEBUG",priority=3100,isActive=e,isEnableResolveRenderBuffer=false})
end
if GrPluginModelDebug then
GrRenderPlugin.AddPlugin(GrPluginModelDebug{pluginName="MODEL_DEBUG",priority=3300})
end
if(GrPluginDebug2D~=nil)then
GrRenderPlugin.AddPlugin(GrPluginDebug2D{pluginName="DEBUG_DRAW2D",priority=3400,isActive=i})
end
if Editor then
GrRenderPlugin.AddPlugin(GrPluginViewCallback{pluginName="VIEW_CALLBACK_WIRE",priority=0,execMode="wireframe"})GrRenderPlugin.AddPlugin(GrPluginModelSetup{pluginName="MODEL_SETUP_WIRE",priority=1,execMode="wireframe"})GrRenderPlugin.AddPlugin(GrPluginOccluder{pluginName="OCCLUDER_WIRE",priority=2,execMode="wireframe"})GrRenderPlugin.AddPlugin(GrPluginPrimitive{pluginName="PRIMITIVES_WIRE",priority=800,shrinkLevel=1,shrinkFilter="BILATERAL",execMode="wireframe"})GrRenderPlugin.AddPlugin(GrPluginPrimitiveUnfiltered{pluginName="PRIMITIVES_UNFILTERED_WIRE",priority=950,execMode="wireframe"})GrRenderPlugin.AddPlugin(GrPlugin2D{pluginName="DRAW2D_WIRE",priority=1573,execMode="wireframe"})GrRenderPlugin.AddPlugin(GrPlugin2DFrontmost{pluginName="DRAW2D_FRONTMOST_WIRE",priority=1e4,execMode="wireframe"})GrRenderPlugin.AddPlugin(GrPluginModelWireframe{pluginName="MODEL_WIRE",priority=10,execMode="wireframe"})GrRenderPlugin.AddPlugin(GrPluginCloneWireframe{pluginName="CLONE_WIRE",priority=15,execMode="wireframe"})GrRenderPlugin.AddPlugin(GrPluginTerrainWireframe{pluginName="TERRAIN_WIRE",priority=20,execMode="wireframe"})
if(GrPluginDebugPrimitive~=nil)then
GrRenderPlugin.AddPlugin(GrPluginDebugPrimitive{pluginName="DEBUG_DRAW_WIRE",priority=3200,execMode="wireframe",isActive=e})
end
GrRenderPlugin.AddPlugin(GrPluginModelDebug{pluginName="MODEL_DEBUG_WIRE",priority=3300,execMode="wireframe"})
if(GrPluginDebug2D~=nil)then
GrRenderPlugin.AddPlugin(GrPluginDebug2D{pluginName="DEBUG_DRAW2D_WIRE",priority=3400,execMode="wireframe",isActive=i})
end
GrRenderPlugin.AddPlugin(GrPluginViewCallback{pluginName="VIEW_CALLBACK_PSEUDO",priority=0,execMode="pseudoshade"})GrRenderPlugin.AddPlugin(GrPluginModelSetup{pluginName="MODEL_SETUP_PSEUDO",priority=1,execMode="pseudoshade"})GrRenderPlugin.AddPlugin(GrPluginOccluder{pluginName="OCCLUDER_PSEUDO",priority=2,execMode="pseudoshade"})GrRenderPlugin.AddPlugin(GrPluginPrimitive{pluginName="PRIMITIVES_PSEUDO",priority=800,shrinkLevel=1,shrinkFilter="BILATERAL",execMode="pseudoshade"})GrRenderPlugin.AddPlugin(GrPluginPrimitiveUnfiltered{pluginName="PRIMITIVES_UNFILTERED_PSEUDO",priority=950,execMode="pseudoshade"})GrRenderPlugin.AddPlugin(GrPlugin2D{pluginName="DRAW2D_PSEUDO",priority=1573,execMode="pseudoshade"})GrRenderPlugin.AddPlugin(GrPlugin2DFrontmost{pluginName="DRAW2D_FRONTMOST_PSEUDO",priority=1e4,execMode="pseudoshade"})GrRenderPlugin.AddPlugin(GrPluginModelPseudoshade{pluginName="MODEL_PSEUDO",priority=10,execMode="pseudoshade"})GrRenderPlugin.AddPlugin(GrPluginTerrainPseudeShade{pluginName="TERRAIN_PSEUDO",priority=20,execMode="pseudoshade"})
if(GrPluginDebugPrimitive~=nil)then
GrRenderPlugin.AddPlugin(GrPluginDebugPrimitive{pluginName="DEBUG_DRAW_PSEUDO",priority=3200,execMode="pseudoshade",isActive=e})
end
GrRenderPlugin.AddPlugin(GrPluginModelDebug{pluginName="MODEL_DEBUG_PSEUDO",priority=3300,execMode="pseudoshade"})
if(GrPluginDebug2D~=nil)then
GrRenderPlugin.AddPlugin(GrPluginDebug2D{pluginName="DEBUG_DRAW2D_PSEUDO",priority=3400,execMode="pseudoshade",isActive=i})
end
GrRenderPlugin.AddPlugin(GrPluginViewCallback{pluginName="VIEW_CALLBACK_FWD",priority=0,execMode="forward"})GrRenderPlugin.AddPlugin(GrPluginModelSetup{pluginName="MODEL_SETUP_FWD",priority=1,execMode="forward"})GrRenderPlugin.AddPlugin(GrPluginOccluder{pluginName="OCCLUDER_FWD",priority=2,execMode="forward"})GrRenderPlugin.AddPlugin(GrPluginPrimitive{pluginName="PRIMITIVES_FWD",priority=800,shrinkLevel=1,shrinkFilter="BILATERAL",execMode="forward"})GrRenderPlugin.AddPlugin(GrPluginPrimitiveUnfiltered{pluginName="PRIMITIVES_UNFILTERED_FWD",priority=950,execMode="forward"})GrRenderPlugin.AddPlugin(GrPlugin2D{pluginName="DRAW2D_FWD",priority=1573,execMode="forward"})GrRenderPlugin.AddPlugin(GrPlugin2DFrontmost{pluginName="DRAW2D_FRONTMOST_FWD",priority=1e4,execMode="forward"})GrRenderPlugin.AddPlugin(GrPluginForwardRendering{pluginName="FORWARD",priority=100,execMode="forward"})GrRenderPlugin.AddPlugin(GrPluginShadow{pluginName="SHADOW_DRAW",priority=1,parentPluginName="FORWARD",execMode="forward"})GrRenderPlugin.AddPlugin(GrPluginModel{pluginName="MODEL",priority=10,parentPluginName="FORWARD",execMode="forward"})GrRenderPlugin.AddPlugin(GrPluginDecal{pluginName="DECALS_FORWARD",priority=100,parentPluginName="FORWARD",execMode="forward"})GrRenderPlugin.AddPlugin(GrPluginTerrain{pluginName="TERRAIN_DRAW",788,parentPluginName="FORWARD",execMode="forward"})
if(GrPluginDebugPrimitive~=nil)then
GrRenderPlugin.AddPlugin(GrPluginDebugPrimitive{pluginName="DEBUG_DRAW_FWD",priority=3200,execMode="forward",isActive=e})
end
GrRenderPlugin.AddPlugin(GrPluginModelDebug{pluginName="MODEL_DEBUG_FWD",priority=3300,execMode="forward"})
if(GrPluginDebug2D~=nil)then
GrRenderPlugin.AddPlugin(GrPluginDebug2D{pluginName="DEBUG_DRAW2D_FWD",priority=3400,execMode="forward",isActive=i})
end
end
if GrGraphicsSettingManager then
GrGraphicsSettingManager.SetPluginSettingSelection{allSettings={{settingName="PluginShadow",settingTable={{name="G7",DirectionalLightShadowResolution=1024,SpotLightLightShadowResolution=512,PointLightLightShadowResolution=1024,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},{name="G8E",DirectionalLightShadowResolution=4096,SpotLightLightShadowResolution=2048,PointLightLightShadowResolution=2048,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},{name="Default",DirectionalLightShadowResolution=2048,SpotLightLightShadowResolution=2048,PointLightLightShadowResolution=4096,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},{name="Low",DirectionalLightShadowResolution=1024,SpotLightLightShadowResolution=512,PointLightLightShadowResolution=1024,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},{name="Medium",DirectionalLightShadowResolution=2048,SpotLightLightShadowResolution=1024,PointLightLightShadowResolution=2048,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},{name="High",DirectionalLightShadowResolution=4096,SpotLightLightShadowResolution=2048,PointLightLightShadowResolution=4096,CascadeShadowRangeScale=1,EnableCascadeShadowBlend=0},{name="ExtraHigh",DirectionalLightShadowResolution=8192,SpotLightLightShadowResolution=4096,PointLightLightShadowResolution=8192,CascadeShadowRangeScale=2,EnableCascadeShadowBlend=1}}},{settingName="PluginSphericalHarmonics",settingTable={{name="G7",DrawSphericalHarmonicsMaxCount=64,RejectionLengthBias=0},{name="G8E",DrawSphericalHarmonicsMaxCount=64,RejectionLengthBias=0},{name="Default",DrawSphericalHarmonicsMaxCount=64,RejectionLengthBias=0},{name="Low",DrawSphericalHarmonicsMaxCount=64,RejectionLengthBias=0},{name="High",DrawSphericalHarmonicsMaxCount=96,RejectionLengthBias=0},{name="ExtraHigh",DrawSphericalHarmonicsMaxCount=255,RejectionLengthBias=80}}},{settingName="PluginLocalLight",settingTable={{name="G7",ShadowCastingStaticLocalLightMaxCount=2,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},{name="G8E",ShadowCastingStaticLocalLightMaxCount=4,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},{name="Default",ShadowCastingStaticLocalLightMaxCount=4,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},{name="Low",ShadowCastingStaticLocalLightMaxCount=2,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},{name="High",ShadowCastingStaticLocalLightMaxCount=4,ShadowCastingDynamicLocalLightMaxCount=2,DrawLocalLightMaxCount=64,LocalLightLodLevelBias=0,LocalLightLodMinLevel=0,RejectionLengthBias=0},{name="ExtraHigh",ShadowCastingStaticLocalLightMaxCount=12,ShadowCastingDynamicLocalLightMaxCount=4,DrawLocalLightMaxCount=512,LocalLightLodLevelBias=-.5,LocalLightLodMinLevel=0,RejectionLengthBias=200}}},{settingName="PluginModel",settingTable={{name="G7",RejectionLengthBias=0},{name="G8E",RejectionLengthBias=0},{name="Default",RejectionLengthBias=32},{name="Low",RejectionLengthBias=0},{name="Medium",RejectionLengthBias=16},{name="High",RejectionLengthBias=32},{name="ExtraHigh",RejectionLengthBias=128}}},{settingName="PluginClone",settingTable={{name="G7",RejectionLengthBias=0},{name="G8E",RejectionLengthBias=0},{name="Default",RejectionLengthBias=64},{name="Low",RejectionLengthBias=0},{name="Medium",RejectionLengthBias=32},{name="High",RejectionLengthBias=64},{name="ExtraHigh",RejectionLengthBias=250}}},{settingName="TextureQualitySettings",settingTable={{name="G7",VramMBSize=700,ReduceMipmap=1},{name="Low",VramMBSize=700,ReduceMipmap=1},{name="Medium",VramMBSize=1300,ReduceMipmap=0},{name="Default",VramMBSize=1800,ReduceMipmap=0},{name="High",VramMBSize=1800,ReduceMipmap=0},{name="G8E",VramMBSize=1800,ReduceMipmap=0},{name="ExtraHigh",VramMBSize=3200,ReduceMipmap=0}}},{settingName="PluginDof",settingTable={{name="G7",EnableFilter=1,QualityType=0},{name="G8E",EnableFilter=1,QualityType=0},{name="Default",EnableFilter=1,QualityType=0},{name="Off",EnableFilter=0,QualityType=0},{name="Low",EnableFilter=0,QualityType=0},{name="High",EnableFilter=1,QualityType=0},{name="ExtraHigh",EnableFilter=1,QualityType=1}}},{settingName="PluginFxaa",settingTable={{name="G7",EnableFilter=1},{name="G8E",EnableFilter=1},{name="Default",EnableFilter=1},{name="Off",EnableFilter=0},{name="Low",EnableFilter=0},{name="High",EnableFilter=1},{name="ExtraHigh",EnableFilter=1}}},{settingName="PluginSsao",settingTable={{name="G7",EnableFilter=1},{name="G8E",EnableFilter=1},{name="Default",EnableFilter=1},{name="Off",EnableFilter=0},{name="Low",EnableFilter=0},{name="High",EnableFilter=1},{name="ExtraHigh",EnableFilter=1}}},{settingName="PluginSao",settingTable={{name="G7",EnableFilter=0},{name="G8E",EnableFilter=0},{name="Default",EnableFilter=0},{name="Off",EnableFilter=0},{name="Low",EnableFilter=0},{name="High",EnableFilter=0},{name="ExtraHigh",EnableFilter=1}}},{settingName="PluginMotionBlur",settingTable={{name="G7",EnableFilter=0,BaseAmount=0},{name="G8E",EnableFilter=1,BaseAmount=.01},{name="Default",EnableFilter=1,BaseAmount=.01},{name="Off",EnableFilter=0,BaseAmount=0},{name="Low",EnableFilter=0,BaseAmount=0},{name="High",EnableFilter=1,BaseAmount=.01},{name="ExtraHigh",EnableFilter=1,BaseAmount=.01}}},{settingName="MotionBlurAmount",settingTable={{name="Off",BlurAmount=0},{name="Small",BlurAmount=.25},{name="Medium",BlurAmount=.5},{name="Large",BlurAmount=1}}},{settingName="PluginToneMap",settingTable={{name="G7",EnableBloom=1},{name="G8E",EnableBloom=1},{name="Default",EnableBloom=1},{name="Off",EnableBloom=0},{name="Low",EnableBloom=1},{name="High",EnableBloom=1},{name="ExtraHigh",EnableBloom=1}}},{settingName="PluginLocalReflection",settingTable={{name="G7",EnableFilter=0,FadeOffset=0},{name="G8E",EnableFilter=1,FadeOffset=0},{name="Default",EnableFilter=1,FadeOffset=0},{name="Off",EnableFilter=0,FadeOffset=0},{name="Low",EnableFilter=0,FadeOffset=0},{name="High",EnableFilter=1,FadeOffset=0},{name="ExtraHigh",EnableFilter=1,FadeOffset=.9}}},{settingName="PluginSubsurfaceScatter",settingTable={{name="G7",EnableFilter=0,FadeOffset=0},{name="G8E",EnableFilter=1,FadeOffset=1},{name="Default",EnableFilter=1,FadeOffset=1},{name="Off",EnableFilter=0,FadeOffset=0},{name="Low",EnableFilter=0,FadeOffset=0},{name="High",EnableFilter=1,FadeOffset=1},{name="ExtraHigh",EnableFilter=1,FadeOffset=1}}}}}
end
