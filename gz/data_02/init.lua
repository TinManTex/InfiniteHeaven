



local platform = Fox.GetPlatformName()
local device = ""
if GrTools then
	device = GrTools.GetDeviceName()
end

Fox.Log("init.lua")

if DEBUG then
	local debugInitLuaPath = "Debug/debug_init.lua"
	local file = io.open( debugInitLuaPath, "r" )
	if file ~= nil then
		io.close( file )
		Fox.Log( "debug_init.lua" )
		dofile( debugInitLuaPath )
	end	
end


if platform == "Windows" then
	AssetConfiguration.SetDefaultTargetDirectory("#Win")
	if AssetConfiguration.GetConfigurationFromAssetManager("EnableWindowsDX11Texture") then
		AssetConfiguration.SetTargetDirectory("ftex", "#windx11")
		AssetConfiguration.SetTargetDirectory("ftexs", "#windx11")
		AssetConfiguration.SetTargetDirectory("ffnt", "#windx11")
		AssetConfiguration.SetTargetDirectory("fnt", "#windx11")
		AssetConfiguration.SetTargetDirectory("fpk", "#windx11")
		AssetConfiguration.SetTargetDirectory("fpkd", "#windx11")
		AssetConfiguration.SetTargetDirectory("pftxs", "#windx11")
	elseif AssetConfiguration.GetConfigurationFromAssetManager("EnableSteamWindowsMode") then
		AssetConfiguration.SetTargetDirectory("ftex", "#steam")
		AssetConfiguration.SetTargetDirectory("ftexs", "#steam")
		AssetConfiguration.SetTargetDirectory("ffnt", "#windx11")
		AssetConfiguration.SetTargetDirectory("fnt", "#windx11")
		AssetConfiguration.SetTargetDirectory("fpk", "#steam")
		AssetConfiguration.SetTargetDirectory("fpkd", "#steam")
		AssetConfiguration.SetTargetDirectory("pftxs", "#steam")
		Fox.Log("EnableSteamWindowsMode: True")
	else
		AssetConfiguration.SetTargetDirectory("ftex", "#Win")
		AssetConfiguration.SetTargetDirectory("ftexs", "#Win")
	end


elseif platform == "Xbox360" then
	AssetConfiguration.SetDefaultTargetDirectory("#Xbox")
elseif platform == "PS3" then
	AssetConfiguration.SetDefaultTargetDirectory("#PS3")
elseif platform == 'XboxOne' then
	AssetConfiguration.SetDefaultTargetDirectory("#Win")
	AssetConfiguration.SetTargetDirectory("ftex", "#windx11")
	AssetConfiguration.SetTargetDirectory("ftexs", "#windx11")
	AssetConfiguration.SetTargetDirectory("ffnt", "#windx11")
	AssetConfiguration.SetTargetDirectory("fnt", "#windx11")
	AssetConfiguration.SetTargetDirectory("pftxs", "#xone")
	AssetConfiguration.SetTargetDirectory("fpk", "#xone")
	AssetConfiguration.SetTargetDirectory("fpkd", "#xone")
	AssetConfiguration.SetTargetDirectory("bnk", "#xone")
	AssetConfiguration.SetTargetDirectory("sbp", "#xone")
	AssetConfiguration.SetTargetDirectory("fsm", "#xone")
	AssetConfiguration.SetTargetDirectory("mas", "#xone")
elseif platform == "PS4" then
	AssetConfiguration.SetDefaultTargetDirectory("#Win")
	AssetConfiguration.SetTargetDirectory("ftex", "#windx11")
	AssetConfiguration.SetTargetDirectory("ftexs", "#windx11")
	AssetConfiguration.SetTargetDirectory("ffnt", "#windx11")
	AssetConfiguration.SetTargetDirectory("fnt", "#windx11")
	AssetConfiguration.SetTargetDirectory("pftxs", "#ps4")
	AssetConfiguration.SetTargetDirectory("fpk", "#ps4")
	AssetConfiguration.SetTargetDirectory("fpkd", "#ps4")
	AssetConfiguration.SetTargetDirectory("bnk", "#ps4")
	AssetConfiguration.SetTargetDirectory("sbp", "#ps4")
	AssetConfiguration.SetTargetDirectory("fsm", "#ps4")
	AssetConfiguration.SetTargetDirectory("mas", "#ps4")
end



AssetConfiguration.SetDefaultCategory( "Language", "jpn" )









if SubtitlesDaemon then
	SubtitlesDaemon.SetDefaultVoiceLanguage( "jpn" )
	
	
	
	
	
	
	
	
end








AssetConfiguration.RegisterExtensionInfo {
		extensions = {
			"bnk", "col", "demo", "demox", "dfrm", "evb", "fclo", "fcnp", "fdes", "fmdl",
			"fpk", "fpkd", "frdv", "frig", "fstb", "ftex", "ftexs", "gani", "lani", "mtar",
			"geom", "gskl", "mtrg", "nav", "nav2", "sani", "mog",
			"cani", "fmtt", "lpsh", "ffnt", "fova", "pftxs", "frt", "atsh",
			"uia", "uif", "uilb", "uigb", "fnt", "rdf", "nta", "subp", "lba"
		},
		categories = { "Target" }
	}

AssetConfiguration.RegisterExtensionInfo {
		extensions = { "sad", "evfl" },
		categories = { "Language" }
	}

AssetConfiguration.RegisterExtensionInfo {
		extensions = { "lng", "sbp", "stm", "mas", "wem", "fsm" },
		categories = { "Target", "Language" }
	}


if GrDaemon then
	if platform == 'Windows' then
		if device == 'directx9' then
			GrTools.LoadShaderPack("shaders/win32/GrSystemShaders_win32.fsop")
			GrTools.LoadShaderPack("shaders/win32/GrModelShaders_win32.fsop")
			GrTools.LoadShaderPack("shaders/win32/FxShaders_win32.fsop")
		end
		if device == 'directx11' then
			GrTools.LoadShaderPack("shaders/dx11/GrSystemShaders_dx11.fsop")
			GrTools.LoadShaderPack("shaders/dx11/GrModelShaders_dx11.fsop")
			GrTools.LoadShaderPack("shaders/dx11/FxShaders_dx11.fsop")
		end
	elseif platform == 'Xbox360' then
		GrTools.LoadShaderPack("shaders\\xbox360\\GrSystemShaders_x360.fsop")
		GrTools.LoadShaderPack("shaders\\xbox360\\GrModelShaders_x360.fsop")
		GrTools.LoadShaderPack("shaders\\xbox360\\FxShaders_x360.fsop")
	elseif platform == 'XboxOne' then
		GrTools.LoadShaderPack("shaders\\xboxone\\GrSystemShaders_xone.fsop")
		GrTools.LoadShaderPack("shaders\\xboxone\\GrModelShaders_xone.fsop")
		GrTools.LoadShaderPack("shaders\\xboxone\\FxShaders_xone.fsop")
	elseif platform == 'PS3' then
		GrTools.LoadShaderPack("shaders/ps3/GrSystemShaders_ps3.fsop.sdat")
		GrTools.LoadShaderPack("shaders/ps3/GrModelShaders_ps3.fsop.sdat")
		GrTools.LoadShaderPack("shaders/ps3/FxShaders_ps3.fsop.sdat")
	elseif platform == 'PS4' then
		GrTools.LoadShaderPack("shaders/ps4/GrSystemShaders_ps4.fsop")
		GrTools.LoadShaderPack("shaders/ps4/GrModelShaders_ps4.fsop")
		GrTools.LoadShaderPack("shaders/ps4/FxShaders_ps4.fsop")
	end

	GrTools.SetupSystemShaderResources()
end

if GrDaemon then

	
	GrTools():EnableTextureStreaming()

	if platform == 'Windows' then
		if device == "directx9" then
			dofile( 'Fox/Scripts/Gr/gr_init.lua' )
			GrTools.SetEnablePackedSmallTextureStreaming( false ) 
		end
		if device == "directx11" then
			dofile( 'Fox/Scripts/Gr/gr_init_dx11.lua' )
			GrTools.SetEnablePackedSmallTextureStreaming( true ) 
		end
	elseif platform == 'Xbox360' then
		dofile('Fox/Scripts/Gr/gr_init_x360.lua')
		GrTools.SetEnablePackedSmallTextureStreaming( true ) 
	elseif platform == 'XboxOne' then
		dofile('Fox/Scripts/Gr/gr_init_xone.lua')
		GrTools.SetEnablePackedSmallTextureStreaming( true ) 
	elseif platform == 'PS3' then
		dofile('Fox/Scripts/Gr/gr_init_ps3.lua')
		GrTools.SetEnablePackedSmallTextureStreaming( true ) 
	elseif platform == 'PS4' then
		dofile('Fox/Scripts/Gr/gr_init_ps4.lua')
		GrTools.SetEnablePackedSmallTextureStreaming( true ) 
	end
	


	
	if platform == 'Windows' or platform == 'XboxOne' or platform == 'PS4' then
		GrTools.FontSystemInit( ( (1024*1024*2) + (1024*200) ) );
	else
		GrTools.FontSystemInit( ( (1024*1024*1) + (1024*700) ) );
	end
	GrTools.FontSystemLoad( "FontSystem_DebugFont","/Assets/fox/font/DebugFont.ffnt");
	
	if AssetConfiguration.GetConfigurationFromAssetManager("EnableWindowsDX11Texture") or AssetConfiguration.GetConfigurationFromAssetManager("EnableSteamWindowsMode") then
		GrTools.SetEnableLnmForTerrainNormal( false );
		GrTools.SetEnableLnmForDecalNormal( false );
	else
		GrTools.SetEnableLnmForTerrainNormal( true );
		GrTools.SetEnableLnmForDecalNormal( true );
	end

	
	if platform == 'XboxOne' or platform =='PS4' then
		GrTools.SetEnableLnmForTerrainNormal( false );
		GrTools.SetEnableLnmForDecalNormal( false );
	end
end


local	app = Application{ name = "MainApplication" }

local	game
local	editor
if Editor then
	
	game	= Editor{ name="MainEditor" }
	editor	= game
elseif EditorBase then
	game = EditorBase{ name="MainEditor" }
	editor	= game
else
	
	game	= Game{ name="MainGame" }
end
app:AddGame( game )
app:SetMainGame( game )

local	mainScene	= game:CreateScene( "MainScene" )

local	mainBucket	= game:CreateBucket( "MainBucket", mainScene )
game:SetMainBucket( mainBucket )






PathMapper.Add("AiSampleGame", "Fox/Tests/Scripts/Character")


if EditableBlockPackage then
	EditableBlockPackage.RegisterPackageExtensionInfo( {
			{ "fmdl", false },	
			{ "geom", false },	
			{ "gskl", false },
			{ "fcnp", false },
			{ "frdv", false },
			{ "fdes", false },
			{ "gani", false },
			{ "lani", false },
			{ "sani", false },
			{ "evb", false },
			{ "mtar", false },
			{ "uif", false },
			{ "uia", false },
			{ "uilb", false },
			{ "uigb", false },
			{ "mog", false },
			{ "fclo", false },
			{ "rdf", false },
			{ "lba", false }, 
			{ "dmy", false },	

			{ "lua", true },	
			{ "sdf", true },
			{ "fsd", true },
			{ "lad", true },
			{ "sim", true },
			{ "ph", true },
			{ "phsd", true },
			{ "tgt", true },
			{ "bnd", true },
			{ "des", true },
			{ "path", true },
			{ "veh", true },
			{ "clo", true },	
			{ "fcnpx", true },	
			{ "vfxlf", true },
			{ "vfx", true },	
			{ "parts", true },	
			{ "evf", true },
			{ "fsml", true },
			{ "fage", true },	
			{ "fago", true },	
			{ "fag", true },	
			{ "fagx", true },	
			{ "aibc", true },	
			{ "aib", true },	
			{ "uil", true },	
			{ "uig", true },	
			{ "testd", true },	
			{ "fox2", true },	
			{ "fxp2", true }	
			} )
end



if GrDaemon then
	local graphicsDaemon = GrDaemon{ name="GrDaemon" }
end


if GrDaemon then
	if platform == 'Windows' then
		if device == 'directx9' then
			if AssetConfiguration.GetConfigurationFromAssetManager("EnableWindowsDX11Texture") then
				dofile( 'shaders/win32/GrSystemShadersNoLnm_win32.lua' )
				dofile( 'shaders/win32/GrModelShadersNoLnm_win32.lua' )
				dofile( 'shaders/win32/FxShadersNoLnm_win32.lua' )
			else
				dofile( 'shaders/win32/GrSystemShaders_win32.lua' )
				dofile( 'shaders/win32/GrModelShaders_win32.lua' )
				dofile( 'shaders/win32/FxShaders_win32.lua' )
			end
		end
		if device == 'directx11' then
			dofile( 'shaders/dx11/GrSystemShadersNoLnm_dx11.lua' )
			dofile( 'shaders/dx11/GrModelShadersNoLnm_dx11.lua' )
			dofile( 'shaders/dx11/FxShadersNoLnm_dx11.lua' )
		end
	elseif platform == 'Xbox360' then
		dofile( 'shaders/xbox360/GrSystemShaders_x360.lua' )
		dofile( 'shaders/xbox360/GrModelShaders_x360.lua' )
		dofile( 'shaders/xbox360/FxShaders_x360.lua' )
	elseif platform == 'XboxOne' then
		dofile( 'shaders/xboxone/GrSystemShadersNoLnm_xone.lua' )
		dofile( 'shaders/xboxone/GrModelShadersNoLnm_xone.lua' )
		dofile( 'shaders/xboxone/FxShadersNoLnm_xone.lua' )
	elseif platform == 'PS3' then
		dofile( 'shaders/ps3/GrSystemShaders_ps3.lua' )
		dofile( 'shaders/ps3/GrModelShaders_ps3.lua' )
		dofile( 'shaders/ps3/FxShaders_ps3.lua' )
	elseif platform == 'PS4' then
		dofile( 'shaders/ps4/GrSystemShadersNoLnm_ps4.lua' )
		dofile( 'shaders/ps4/GrModelShadersNoLnm_ps4.lua' )
		dofile( 'shaders/ps4/FxShadersNoLnm_ps4.lua' )
	end
end



if SoundCoreDaemon then
	SoundCoreDaemon.Create()

	if SoundDaemon then
		SoundDaemon.Create()

		if SoundEditorDaemon then
			local	soundEditorDaemon = SoundEditorDaemon{}
		end
	end
end


if LipSyncDaemon then
	
	
	local LipSyncDaemon = LipSyncDaemon{ name = "LipSyncDaemon", scene = "MainScene" }
end


if EdRbCommand then
	
	EdRbCommand{ }
end


if FxDaemon then
	FxDaemon.Initialize();
	FxDaemon.InitializeReserveObject( "FxShaderPool" );
	FxDaemon.InitializeReserveObject( "FxMaterialManager" );
	FxDaemon.InitializeReserveObject( "FxTextureManager" );
	FxDaemon.InitializeReserveObject( "FxDecalSurfaceManager" );
	FxDaemon.InitializeReserveObject( "FxBlowOutEffectManager" );
end



if CameraPriority then
	CameraPriority.RegisterPriorities{ "Debug", "Editor", "Demo", "Game", "GameWeakest" };
end


if CameraSelector then
	local	cameraSelector	= CameraSelector{ name="MainCameraSelector", scene="MainScene",
			viewport="MainViewport", priorities={ "Debug", "Editor", "Demo", "Game", "GameWeakest" },
			listener="MainListener", rumble={ 0, 1, 2, 3 } }
	cameraSelector:SetMainListener()
	CameraSelector.SetMainInstance( cameraSelector )
end

if editor then
	
	editor:Setup()
	
	if Editor then
		Editor.Setting( editor )
	end
	
	local	bucket	= editor:CreateNewEditableBucket( "NewBucket" )
	editor:SetCurrentEditableBucket( bucket )

  
	if platform == 'Windows' then
		Fox.ExportSerializeInfo()
    end
  
	
	










end


if Pad2 then
	Pad2.Init{ logCount = 60 }
end


if Pad then
	Pad.ConfigDefaultAssigns()
end


if PadMapping then
	local padMapping = PadMapping()
end


if ReplayService then
    ReplayService.Boot()
end











if NavWorldDaemon then
	NavWorldDaemon.AddScene("MainScene")
	
end















if PhDaemon then
	
	PhDaemon.SetMemorySize(2560,1536,1024)
	PhDaemon.SetMaxRigidBodyNum(500);
	local physics = PhDaemon()
end


if SimDaemon then
	local sim = SimDaemon()
	sim.defaultViewPort = "MainViewport"
end


if DesDaemon then
	local destruction = DesDaemon()
end


if NtDaemon then
	NtDaemon.Create()
end


if UiDaemon then
	local ui = UiDaemon{ name="UiDaemon" }
end


if LangDaemon then
	local lang = LangDaemon{ name="LangDaemon" }
end

if SubtitlesDaemon then
	local subtitles = SubtitlesDaemon{ name="SubtitlesDaemon" }
end

if SubtitlesCommand then
	local voiceLang = SubtitlesDaemon.GetDefaultVoiceLanguage()
	SubtitlesCommand.SetVoiceLanguage( voiceLang )
	local useLang = AssetConfiguration.GetDefaultCategory( "Language" )
	SubtitlesCommand.SetLanguage( useLang );
end


if RadioDaemon then
	local radio = RadioDaemon { name="RadioDaemon" }
end


if PreviewDaemon then
	local preview = PreviewDaemon{}
end


if EnvironmentDaemon then
	local	envDaemon = EnvironmentDaemon{}

	if WindManager then
		local	windManager = WindManager{}
	end
end


if PerformanceViewer then
	local	performanceViewer	= PerformanceViewer{ name="PerformanceViewer" }
	performanceViewer:Invisible()
	mainScene:AddActor( performanceViewer )
end


if MemoryViewer then
	local	memoryViewer	= MemoryViewer{ name="MemoryViewer" }
	memoryViewer:Invisible()
	mainScene:AddActor( memoryViewer )
end


if MiniPerfView then
	MiniPerfView.SetEnable(true);
end


if BlockSizeView then
	BlockSizeView.SetEnable(true);
end



if SyncEditor then
	
	
	if platform == 'Windows' then
		SyncEditor{ name="syncEditor", scene="MainScene" }
	end
end


if ConnectionPrintInfo then
	ConnectionPrintInfo{ name="ConnectionPrintInfo" }
end


if SoundCommand then
	local	soundCommand = SoundCommand{}
end


if Editor then
	Fox.SetActMode( "EDIT" )
end


if platform == 'Windows' and device == 'directx9' then
	if GrxLightCapture then
		GrxLightCapture():InitInstance()
	end
end



if FoxFadeIo then
	FoxFadeIo.Create()
end


if Editor then
	package.path = package.path .. ";/Assets/fox/editor_scripts/?.lua"
end


if Editor then
	EdDemoEditBlockController.AddToolsBlockPath("/Assets/fox/demo/event/info/EdDemoEditTools.fpk")
end

if GsRouteDataNodeEvent then
	
	GsRouteDataNodeEvent.SetEventDefinitionPath( "DummyRoute", "Fox/Scripts/RouteEvents/AiRtEvDummyRoute.lua" )
	GsRouteDataEdgeEvent.SetEventDefinitionPath( "DummyRoute", "Fox/Scripts/RouteEvents/AiRtEvDummyRoute.lua" )
end


if DEBUG then
else
Fox.SetLogLevelFilter( 1 );
end

