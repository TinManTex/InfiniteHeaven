--[[
	初期化スクリプト
]]

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

-- アセットコンフィギュレーション
if platform == "Windows" then
	AssetConfiguration.SetDefaultTargetDirectory("#Win")
	if AssetConfiguration.GetConfigurationFromAssetManager("EnableWindowsDX11Texture") then
		AssetConfiguration.SetTargetDirectory("ftex", "#windx11")
		AssetConfiguration.SetTargetDirectory("ftexs", "#windx11")
		Fox.Log("EnableWindowsDX11Texture: True")
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
	AssetConfiguration.SetTargetDirectory("bnk", "#xone")
	AssetConfiguration.SetTargetDirectory("sbp", "#xone")
	AssetConfiguration.SetTargetDirectory("fsm", "#xone")
	AssetConfiguration.SetTargetDirectory("mas", "#xone")
elseif platform == "PS4" then
	AssetConfiguration.SetDefaultTargetDirectory("#Win")
	AssetConfiguration.SetTargetDirectory("ftex", "#windx11")
	AssetConfiguration.SetTargetDirectory("ftexs", "#windx11")
	AssetConfiguration.SetTargetDirectory("bnk", "#ps4")
	AssetConfiguration.SetTargetDirectory("sbp", "#ps4")
	AssetConfiguration.SetTargetDirectory("fsm", "#ps4")
	AssetConfiguration.SetTargetDirectory("mas", "#ps4")
end

-- 言語設定
--dofile( 'Fox/Scripts/Language/LanguageInit.lua' ) --←↓LanguageInit.luaより引っ越してきました。Y.Ogaito 2013.11.20
AssetConfiguration.SetDefaultCategory( "Language", "jpn" )
-- AssetConfiguration.SetDefaultCategory( "Language", "eng" )
-- AssetConfiguration.SetDefaultCategory( "Language", "fre" )
-- AssetConfiguration.SetDefaultCategory( "Language", "ita" )
-- AssetConfiguration.SetDefaultCategory( "Language", "ger" )
-- AssetConfiguration.SetDefaultCategory( "Language", "spa" )
-- AssetConfiguration.SetDefaultCategory( "Language", "por" )
-- AssetConfiguration.SetDefaultCategory( "Language", "rus" )
-- AssetConfiguration.SetDefaultCategory( "Language", "ara" )
----- 字幕音声言語設定
if SubtitlesDaemon then
	SubtitlesDaemon.SetDefaultVoiceLanguage( "jpn" )
	-- SubtitlesDaemon.SetDefaultVoiceLanguage( "eng" )
	-- SubtitlesDaemon.SetDefaultVoiceLanguage( "fre" )
	-- SubtitlesDaemon.SetDefaultVoiceLanguage( "ita" )
	-- SubtitlesDaemon.SetDefaultVoiceLanguage( "ger" )
	-- SubtitlesDaemon.SetDefaultVoiceLanguage( "spa" )
	-- SubtitlesDaemon.SetDefaultVoiceLanguage( "por" )
	-- SubtitlesDaemon.SetDefaultVoiceLanguage( "rus" )
	-- SubtitlesDaemon.SetDefaultVoiceLanguage( "ara" )
end

-- 拡張子ごとにディレクトリを変更する場合の設定
--AssetConfiguration.SetTargetDirectory("ext0", "#PS3_0")
--AssetConfiguration.SetLanguageDirectory("ext1", "#NewLanguage")


-- 拡張子毎の「カテゴリ」指定(ファイル読み込みより前に行っておくこと)
-- 「機種」に依存するファイル
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
-- 「言語」に依存するファイル
AssetConfiguration.RegisterExtensionInfo {
		extensions = { "sad", "evfl" },
		categories = { "Language" }
	}
-- 「機種」「言語」の両方に依存するファイル
AssetConfiguration.RegisterExtensionInfo {
		extensions = { "lng", "sbp", "stm", "mas", "wem", "fsm" },
		categories = { "Target", "Language" }
	}

-- シェーダーバイナリの展開
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

	-- テクスチャストリーミング
	GrTools():EnableTextureStreaming()

	if platform == 'Windows' then
		if device == "directx9" then
			dofile( 'Fox/Scripts/Gr/gr_init.lua' )
		end
		if device == "directx11" then
			dofile( 'Fox/Scripts/Gr/gr_init_dx11.lua' )
		end
	elseif platform == 'Xbox360' then
		dofile('Fox/Scripts/Gr/gr_init_x360.lua')
		GrTools.SetEnablePackedSmallTextureStreaming( true ) 
	elseif platform == 'XboxOne' then
		dofile('Fox/Scripts/Gr/gr_init_xone.lua')
	elseif platform == 'PS3' then
		dofile('Fox/Scripts/Gr/gr_init_ps3.lua')
		GrTools.SetEnablePackedSmallTextureStreaming( true ) 
	elseif platform == 'PS4' then
		dofile('Fox/Scripts/Gr/gr_init_ps4.lua')
	end
	-- テクスチャストリーミング担当外テクスチャの非同期読み込み
--	GrTools():EnableTextureLoadQueue()

	-- フォントシステム初期化
--	GrTools.FontSystemInit( ( (1024*1024*2) + (1024*300) ) );
	GrTools.FontSystemInit( ( (1024*1024*1) + (1024*700) ) );
	GrTools.FontSystemLoad( "FontSystem_DebugFont","/Assets/fox/font/DebugFont.ffnt");
	
	if AssetConfiguration.GetConfigurationFromAssetManager("EnableWindowsDX11Texture") then
		GrTools.SetEnableLnmForTerrainNormal( false );
		GrTools.SetEnableLnmForDecalNormal( false );
	else
		GrTools.SetEnableLnmForTerrainNormal( true );
		GrTools.SetEnableLnmForDecalNormal( true );
	end

	-- XboxOne ではアセットマネージャの設定によらず強制的に Lnm を無効にする
	if platform == 'XboxOne' or platform =='PS4' then
		GrTools.SetEnableLnmForTerrainNormal( false );
		GrTools.SetEnableLnmForDecalNormal( false );
	end
end

-- ゲームオブジェクトを作成する
local	app = Application{ name = "MainApplication" }

local	game
local	editor
if Editor then
	-- エディタインスタンスを作成する
	game	= Editor{ name="MainEditor" }
	editor	= game
elseif EditorBase then
	game = EditorBase{ name="MainEditor" }
	editor	= game
else
	-- ゲームインスタンスを作成する
	game	= Game{ name="MainGame" }
end
app:AddGame( game )
app:SetMainGame( game )

local	mainScene	= game:CreateScene( "MainScene" )

local	mainBucket	= game:CreateBucket( "MainBucket", mainScene )
game:SetMainBucket( mainBucket )

-- アセットコマンダー
--local	assetCommander	= AssetCommander{ name="AssetCommander", scene="MainScene" }

-- パスマッパー
-- 一旦一括でフォルダ移動。使用している箇所は徐々に置換していく。
PathMapper.Add("AiSampleGame", "Fox/Tests/Scripts/Character")

-- パッケージ作成用の拡張子情報を登録する
if EditableBlockPackage then
	EditableBlockPackage.RegisterPackageExtensionInfo( {
			{ "fmdl", false },	-- 描画用モデルデータファイル
			{ "geom", false },	-- アタリデータファイル
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
			{ "lba", false }, --locater binary array
			{ "dmy", false },	-- ダミーファイル

			{ "lua", true },	-- Lua スクリプトファイル
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
			{ "clo", true },	-- クロス設定ファイル
			{ "fcnpx", true },	-- パーツビルダー・拡張コネクトポイントファイル
			{ "vfxlf", true },
			{ "vfx", true },	-- エフェクト・定義ファイル
			{ "parts", true },	-- パーツビルダー・定義ファイル
			{ "evf", true },
			{ "fsml", true },
			{ "fage", true },	-- モーショングラフ・グラフピースファイル
			{ "fago", true },	-- モーショングラフ
			{ "fag", true },	-- モーショングラフ・ルートグラフファイル
			{ "fagx", true },	-- モーショングラフ・レイヤー定義ファイル
			{ "aibc", true },	-- AIビヘイビア・カテゴリファイル
			{ "aib", true },	-- AIビヘイビア・定義ファイル
			{ "uil", true },	-- Ui Layout ファイル
			{ "uig", true },	-- UiGraph ファイル
			{ "testd", true },	-- テスト用ファイル
			{ "fox2", true },	-- オブジェクト配置・プロパティデータファイル
			{ "fxp2", true }	-- 未使用
			} )
end

-- 描画システム初期化
-- デーモン起動
if GrDaemon then
	local graphicsDaemon = GrDaemon{ name="GrDaemon" }
end

-- シェーダー関連初期化
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
			dofile( 'shaders/dx11/GrSystemShaders_dx11.lua' )
			dofile( 'shaders/dx11/GrModelShaders_dx11.lua' )
			--dofile( 'shaders/dx11/FxShaders_dx11.lua' )
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
		-- todo:ps4 dofile( 'shaders/ps4/FxShadersNoLnm_ps4.lua' )
	end
end


-- サウンドシステム初期化
if SoundCoreDaemon then
	SoundCoreDaemon.Create()

	if SoundDaemon then
		SoundDaemon.Create()

		if SoundEditorDaemon then
			local	soundEditorDaemon = SoundEditorDaemon{}
		end
	end
end

-- LipSync用Daemon作成
if LipSyncDaemon then
	-- サウンドDaemonがないと動かないのでサウンドの後ろに書く
	-- 完全にサウンド依存だけど、いいのか？
	local LipSyncDaemon = LipSyncDaemon{ name = "LipSyncDaemon", scene = "MainScene" }
end

-- レコードバンク初期化
if EdRbCommand then
	-- 生成
	EdRbCommand{ }
end

-- Fx エフェクトシステムの初期化
if FxDaemon then
	FxDaemon.Initialize();
	FxDaemon.InitializeReserveObject( "FxShaderPool" );
	FxDaemon.InitializeReserveObject( "FxMaterialManager" );
	FxDaemon.InitializeReserveObject( "FxTextureManager" );
	FxDaemon.InitializeReserveObject( "FxDecalSurfaceManager" );
	FxDaemon.InitializeReserveObject( "FxBlowOutEffectManager" );
end


-- カメラプライオリティ設定
if CameraPriority then
	CameraPriority.RegisterPriorities{ "Debug", "Editor", "Demo", "Game", "GameWeakest" };
end

-- カメラセレクタ起動
if CameraSelector then
	local	cameraSelector	= CameraSelector{ name="MainCameraSelector", scene="MainScene",
			viewport="MainViewport", priorities={ "Debug", "Editor", "Demo", "Game", "GameWeakest" },
			listener="MainListener", rumble={ 0, 1, 2, 3 } }
	cameraSelector:SetMainListener()
	CameraSelector.SetMainInstance( cameraSelector )
end

if editor then
	-- エディタのセットアップ処理を行う
	editor:Setup()
	-- 設定データの読み込みを行う
	if Editor then
		Editor.Setting( editor )
	end
	-- データセット用バケットを作成する
	local	bucket	= editor:CreateNewEditableBucket( "NewBucket" )
	editor:SetCurrentEditableBucket( bucket )

  -- ブロックパッケージ用
	if platform == 'Windows' then
		Fox.ExportSerializeInfo()
    end
  
	-- サンプルエディタを起動する
	-- ここでやるのはどうかと思うがエディタの初期化はLuaでしかできない
--[[
	do
		local	editor	= Editor{ name="SampleEditor" }
		app:AddGame( editor )
		local	scene	= editor:CreateScene( "SampleScene" )
		local	bucket	= editor:CreateBucket( "MainBucket", scene )
		editor:SetMainBucket( bucket )
		editor:Setup()
	end
]]
end

-- パッド初期化
if Pad2 then
	Pad2.Init{ logCount = 60 }
end

-- パッドアサイン設定
if Pad then
	Pad.ConfigDefaultAssigns()
end

-- パッドマッピング生成
if PadMapping then
	local padMapping = PadMapping()
end

-- リプレイサービス開始
if ReplayService then
    ReplayService.Boot()
end

-- Nav設定
--[[
local nav = NavDaemon{ name = "NavDaemon" }
local unit = 1.0
nav:SetUnitSize( unit )
nav:SetThredSize( 1 )
nav:SetPathFindExecutorCapacity( 1 )
mainScene:AddActor( nav )
]]--

if NavWorldDaemon then
	NavWorldDaemon.AddScene("MainScene")
	--local navWorldDaemon = NavWorldDaemon{}
end

--[[
local navDrawer = NavxDrawer{ name = "NavxDrawer" }
mainScene:AddActor( navDrawer )

local meshGenerator = NavxMeshGenerator{ name = "NavxMeshGenerator" }
mainScene:AddActor( meshGenerator )
--meshGenerator:SetVoxelParameter(Vector3(-29.54066, -1.961283, -30.38156), Vector3(60*unit, 20*unit, 60*unit), 0.25*unit)
meshGenerator:SetVoxelParameter(Vector3(-29.54066, -5.593952, -33.25865), Vector3(60*unit, 20*unit, 60*unit), 0.25*unit)
meshGenerator:AddNavigableParameter( "Stand", true, 0.45*unit, 2.0*unit, 0.25*unit, 1*unit )
meshGenerator:AddNavigableParameter( "Stoop", true, 0.45*unit, 1.0*unit, 0.25*unit, 1*unit )
meshGenerator:AddNavigableParameter( "Creep", true, 0.45*unit, 0.5*unit, 0.25*unit, 1*unit )
]]--

-- 物理デーモン生成
if PhDaemon then
	-- 常駐メモリサイズ設定
	PhDaemon.SetMemorySize(2560,1536,1024)
	PhDaemon.SetMaxRigidBodyNum(500);
	local physics = PhDaemon()
end

-- ゆれものデーモン生成
if SimDaemon then
	local sim = SimDaemon()
	sim.defaultViewPort = "MainViewport"
end

-- 破壊デーモン生成
if DesDaemon then
	local destruction = DesDaemon()
end

-- Network デーモン生成
if NtDaemon then
	NtDaemon.Create()
end

-- FoxTest LuaUnit 登録
if FoxTestLuaActor then
	if FoxTestLuaActor then
		FoxTestLuaActor.ExecGlobal('dofile("script/luaunit.lua")')
	end
end

-- Uiデーモン生成
if UiDaemon then
	local ui = UiDaemon{ name="UiDaemon" }
end

-- Langデーモン生成
if LangDaemon then
	local lang = LangDaemon{ name="LangDaemon" }
end
-- 字幕デーモン生成
if SubtitlesDaemon then
	local subtitles = SubtitlesDaemon{ name="SubtitlesDaemon" }
end
-- 字幕言語設定
if SubtitlesCommand then
	local voiceLang = SubtitlesDaemon.GetDefaultVoiceLanguage()
	SubtitlesCommand.SetVoiceLanguage( voiceLang )
	local useLang = AssetConfiguration.GetDefaultCategory( "Language" )
	SubtitlesCommand.SetLanguage( useLang );
end

-- 無線デーモン生成
if RadioDaemon then
	local radio = RadioDaemon { name="RadioDaemon" }
end

-- Previewデーモン生成
if PreviewDaemon then
	local preview = PreviewDaemon{}
end

-- 環境関連起動
if EnvironmentDaemon then
	local	envDaemon = EnvironmentDaemon{}

	if WindManager then
		local	windManager = WindManager{}
	end
end

-- パフォーマンスビューア起動
if PerformanceViewer then
	local	performanceViewer	= PerformanceViewer{ name="PerformanceViewer" }
	performanceViewer:Invisible()
	mainScene:AddActor( performanceViewer )
end

-- メモリビューア起動
if MemoryViewer then
	local	memoryViewer	= MemoryViewer{ name="MemoryViewer" }
	memoryViewer:Invisible()
	mainScene:AddActor( memoryViewer )
end

-- ミニパフォーマンスビュー起動
if MiniPerfView then
	MiniPerfView.SetEnable(true);
end

-- BlockSizeView起動
if BlockSizeView then
	BlockSizeView.SetEnable(true);
end


-- editor 同期処理
if SyncEditor then
	-- init時にエディタ同期を起動させるのは、Windows(ホスト側)のみ
	-- 他プラットフォーム時は、デバグセレクターなどから明示的に起動させる
	if platform == 'Windows' then
		SyncEditor{ name="syncEditor", scene="MainScene" }
	end
end

-- connection 接続情報表示
if ConnectionPrintInfo then
	ConnectionPrintInfo{ name="ConnectionPrintInfo" }
end

-- サウンドデバッグコマンド起動
if SoundCommand then
	local	soundCommand = SoundCommand{}
end

-- Actorモード設定
if Editor then
	Fox.SetActMode( "EDIT" )
end

-- LightCapture用のインスタンス初期化
if platform == 'Windows' and device == 'directx9' then
	if GrxLightCapture then
		GrxLightCapture():InitInstance()
	end
end
--Fox.SetBreakIgnore(true)

-- FadeIoインスタンス生成
if FoxFadeIo then
	FoxFadeIo.Create()
end

-- エディタ用スクリプト置き場の登録
if Editor then
	package.path = package.path .. ";/Assets/fox/editor_scripts/?.lua"
end

-- デモエディット用パッケージの指定
if Editor then
	EdDemoEditBlockController.AddToolsBlockPath("/Assets/fox/demo/event/info/EdDemoEditTools.fpk")
end

if GsRouteDataNodeEvent then
	-- Route 仮敵君
	GsRouteDataNodeEvent.SetEventDefinitionPath( "DummyRoute", "Fox/Scripts/RouteEvents/AiRtEvDummyRoute.lua" )
	GsRouteDataEdgeEvent.SetEventDefinitionPath( "DummyRoute", "Fox/Scripts/RouteEvents/AiRtEvDummyRoute.lua" )
end

