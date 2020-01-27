



local this = BaseFlagMission.CreateInstance( "k40070" )

this.missionDemoBlock = { demoBlockName = "AirTank" }

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId


local memoryBoardIdentifierParam = {
	{
		gimmickId		= "GIM_P_CommonSwitch",
		name			= "ssde_swtc001_bord001_gim_n0001|srt_ssde_swtc001_bord001",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_large/base/afgh_base_gimmick.fox2",
	},
	{
		gimmickId		= "GIM_P_CommonSwitch",
		name			= "ssde_swtc001_bord001_gim_n0002|srt_ssde_swtc001_bord001",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_large/base/afgh_base_gimmick.fox2",
	},
	{
		gimmickId		= "GIM_P_CommonSwitch",
		name			= "ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_small/129/129_146/afgh_129_146_gimmick.fox2",
	},
}


local skillAcquisitionIdentifierParam = {
	gimmickId		= "GIM_P_AI_Skill",
	name			= "com_ai002_gim_n0000|srt_pup0_main0_ssd_v00",
	dataSetName		= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",
}




local tipsMenuList = {
	
	TIPS_FOGAREA = {
		tipsTypes		= {
							{ HelpTipsType.TIPS_23_A, HelpTipsType.TIPS_23_B, HelpTipsType.TIPS_23_C },
						},
	},
	
	TIPS_FOGAREA_RADIO = {
		startRadio		= "f3010_rtrg0316",
		tipsTypes		= {
							{ HelpTipsType.TIPS_23_A, HelpTipsType.TIPS_23_B, HelpTipsType.TIPS_23_C },
						},
	},
	
	TIPS_SKILL = {
		startRadio		= "f3010_rtrg0307",
		tipsTypes		= {
							{ HelpTipsType.TIPS_20_A, HelpTipsType.TIPS_20_B },
						},
		tipsRadio		= "f3010_rtrg0308",
		endFunction		= function() this.EndSkillTips() end,
	},
	
	TIPS_OXYGEN_SUPPLEMENT = {
		startRadio		= "f3010_rtrg0312",
		tipsTypes		= {
							{ HelpTipsType.TIPS_91_A, HelpTipsType.TIPS_91_B, HelpTipsType.TIPS_91_C },
						},
		tipsRadio		= "f3010_rtrg0313",
		endFunction		= function() this.EndOxygenSupplementTips() end,
	},
	
	TIPS_OXYGEN_SUPPLEMENT_AIRTANK = {
		startRadio		= "f3010_rtrg0312",
		tipsTypes		= {
							{ HelpTipsType.TIPS_91_A, HelpTipsType.TIPS_91_B, HelpTipsType.TIPS_91_C },
						},
		tipsRadio		= "f3010_rtrg0313",
		endFunction		= function() this.EndOxygenSupplementTips() end,
	},
	
	TIPS_FOGAREA_OXYGEN = {
		startRadio		= "f3010_rtrg0322",
		tipsTypes		= {
							{ HelpTipsType.TIPS_24_A, HelpTipsType.TIPS_24_B,HelpTipsType.TIPS_24_C },
							{ HelpTipsType.TIPS_25_A, HelpTipsType.TIPS_25_B },
						},
		tipsRadio		= { "f3010_rtrg0323", "f3010_rtrg0324" }
	},
}




local tipsMenuAnnounceList = {
	TIPS_QUEST = {
		tipsTypes = {
			HelpTipsType.TIPS_55_A, HelpTipsType.TIPS_55_B, HelpTipsType.TIPS_55_C,		
		},
	},
	TIPS_STEALTH = {
		tipsTypes = {
			HelpTipsType.TIPS_19_A,		HelpTipsType.TIPS_19_B,	HelpTipsType.TIPS_19_C,		
			HelpTipsType.TIPS_108_A,	HelpTipsType.TIPS_108_B,							
			HelpTipsType.TIPS_32_A,		HelpTipsType.TIPS_32_B,	HelpTipsType.TIPS_32_C,		
		},
	},
	TIPS_WORMHOLE = {
		tipsTypes = {
			HelpTipsType.TIPS_41_A, HelpTipsType.TIPS_41_B, HelpTipsType.TIPS_41_C,		
		},
	},
}


this.missionAreas = {
	{ name = "marker_missionArea01", trapName = "trap_missionArea01", visibleArea = 5, guideLinesId = "guidelines_mission_common_memoryBoard" },
	{ name = "marker_missionArea02", trapName = "trap_missionArea02", visibleArea = 5, guideLinesId = "guidelines_mission_common_memoryBoard" },
	{ name = "marker_missionArea03", trapName = "trap_missionArea03", visibleArea = 8, guideLinesId = "guidelines_mission_common_memoryBoard", hide = true },
}


this.disableEnemy = {
	{ enemyName = "zmb_129_147_0000" },
	{ enemyName = "zmb_129_147_0001" },
	{ enemyName = "zmb_129_147_0005" },
	{ enemyName = "zmb_129_147_0006" },
	{ enemyName = "zmb_129_147_0007" },
	{ enemyName = "zmb_129_147_0008" },
	{ enemyName = "zmb_129_147_0000" },
}


this.enemyRouteTable = {
  { enemyName = "zmb_k40070_02_r_0000", routeName = "rt_zmb_k40070_02_r_0000", },
  { enemyName = "zmb_k40070_02_r_0001", routeName = "rt_zmb_k40070_02_r_0001", },
  { enemyName = "zmb_k40070_02_r_0002", routeName = "rt_zmb_k40070_02_r_0002", },
  { enemyName = "zmb_k40070_02_r_0003", routeName = "rt_zmb_k40070_02_r_0003", },
  { enemyName = "zmb_k40070_02_r_0004", routeName = "rt_zmb_k40070_02_r_0004", },
  { enemyName = "zmb_k40070_02_r_0005", routeName = "rt_zmb_k40070_02_r_0005", },
  { enemyName = "zmb_k40070_02_r_0006", routeName = "rt_zmb_k40070_02_r_0006", },
  { enemyName = "zmb_k40070_03_r_0000", routeName = "rt_zmb_k40070_03_r_0000", },
  { enemyName = "zmb_k40070_03_r_0001", routeName = "rt_zmb_k40070_03_r_0001", },
  { enemyName = "zmb_k40070_03_r_0002", routeName = "rt_zmb_k40070_03_r_0002", },
  { enemyName = "zmb_k40070_03_r_0003", routeName = "rt_zmb_k40070_03_r_0003", },
  { enemyName = "zmb_k40070_03_r_0004", routeName = "rt_zmb_k40070_03_r_0004", },
  { enemyName = "zmb_k40070_03_r_0005", routeName = "rt_zmb_k40070_03_r_0005", },
  { enemyName = "zmb_k40070_03_r_0006", routeName = "rt_zmb_k40070_03_r_0006", },
  { enemyName = "zmb_k40070_03_r_0007", routeName = "rt_zmb_k40070_03_r_0007", },
  { enemyName = "zmb_k40070_03_r_0008", routeName = "rt_zmb_k40070_03_r_0008", },
  { enemyName = "zmb_k40070_str_0000", routeName = "rt_zmb_k40070_str_0000", },
  { enemyName = "zmb_k40070_str_0001", routeName = "rt_zmb_k40070_str_0001", },
  { enemyName = "zmb_k40070_str_0002", routeName = "rt_zmb_k40070_str_0002", },
}


this.enemyLevelSettingTable = {
	areaSettingTableList = {
		{
			areaName = "area_03",
			level = 2,
			randomRange = 0,
		},
	},
}

this.ISCOMPLETE_LIST = Tpp.Enum{
	"isMissionArea01Clear",
	"isMissionArea02Clear",
	"isMissionArea03Clear",
	"isMissionArea01AiAccess",
	"isMissionArea02AiAccess",
	"isMissionArea03AiAccess",
	"isMissionArea03Display",
	"isMissionArea01Radio01",
	"isMissionArea01Radio02",
	"isMissionArea02Radio",
	"isMissionArea03Radio",
	"isGetBrokenGasCylinder",
	"isGetMask",
	"isSkillMenu",
	"isTipsTreasure",					
	"isRadioFogAreaState",
	"isWakeCombatAi",
	"isMissionStart",
	"isDemoFogArea",
	"isFogAreaTipsStart",
	"isFogAreaTipsEnd",
	"isSkillTipsStart",
	"isSkillTipsEnd",
	"isMissionArea01StartRadio",
	"isMissionArea02StartRadio",
	"isMissionArea03StartRadio",
}

this.ISCOMPLETE_MAX		= 32


BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "missionArea01Step",										 type = TppScriptVars.TYPE_UINT8,	value = 0,		save = true,	category = TppScriptVars.CATEGORY_MISSION },
		{ name = "missionArea02Step",										 type = TppScriptVars.TYPE_UINT8,	value = 0,		save = true,	category = TppScriptVars.CATEGORY_MISSION },
		{ name = "missionArea03Step",										 type = TppScriptVars.TYPE_UINT8,	value = 0,		save = true,	category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isComplete",			 arraySize = this.ISCOMPLETE_MAX,	 type = TppScriptVars.TYPE_BOOL,	value = false,	save = true,	category = TppScriptVars.CATEGORY_MISSION },
	}
)


this.MissionAreaStepList = {
	{
		"GameArea01_GameMemoryBoard",
		"GameArea01_GameEscape",
	},
	{
		"GameArea02_GameMemoryBoard",
		"GameArea02_GameEscape",
	},
	{
		"GameArea03_GameMemoryBoard",
		"GameArea03_GameEscape",
	},
}

this.MissionAreaStepVars = {
	"missionArea01Step",
	"missionArea02Step",
	"missionArea03Step",
}




this.OnActivate = function()

	local stepIndex				= SsdFlagMission.GetCurrentStepIndex()
	local count					= SsdSbm.GetCountProduction{ id="PRD_SVE_GasCylinder_Lv1", inInventory=true, inWarehouse=true }

	mvars.isDemoStart			= false
	mvars.isRadioFogArea		= false 

	
	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isGetMask ) == true or count > 0 then
		this.SetFlagVars( this.ISCOMPLETE_LIST.isGetMask, true )
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_OXYGEN )
	end

	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01Clear ) == true then
		
		this.DisableMissionArea( "marker_missionArea01" )
	end

	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02Clear ) == true then
		
		this.DisableMissionArea( "marker_missionArea02" )
	end

	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Display ) == true then
		if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Clear ) == false then
			
			this.DisplayMissionArea("marker_missionArea03")
		end
	end

	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isSkillTipsStart ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isSkillTipsEnd ) == true then
		this.SetPowerOffSkillAcquisition( false )
	else
		this.SetPowerOffSkillAcquisition( true )
	end

	
	if this.IsAiAccess() == true then
		mvars.isContinueRadio		= true
		SsdFlagMission.SetNextStep( "GameMain_AiAccess" )
	else
		if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) or stepIndex == SsdFlagMission.GetStepIndex( "GameMain_GameMemoryBoardEnd" ) then
			mvars.isContinueRadio = false
		end
	end

end




this.messageTable = {
	GameObject = {
		{	
			msg = "ChangeFogAreaState",
			func = function()
				
				local count = SsdSbm.GetCountProduction{ id="PRD_SVE_GasCylinder_Lv1", inInventory=true, inWarehouse=true }
				
				if TppGameStatus.IsSet("", "S_FOG_PASSAGE") then
					local isPageOpened = HelpTipsMenuSystem.IsPageOpened( HelpTipsType.TIPS_23_A )
					
					if count == 0 then
						if mvars.isRadioFogArea == false then
							if isPageOpened == false then
								
								TppTutorial.ResetHelpTipsSettings()
								
								TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_FOGAREA_RADIO )
							else
								TppRadio.Play( "f3010_rtrg0316" )
							end
							mvars.isRadioFogArea = true
						end
					
					else
						if isPageOpened == false then
							
							TppTutorial.ResetHelpTipsSettings()
							
							TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_FOGAREA )
						end
						if this.GetFlagVars( this.ISCOMPLETE_LIST.isDemoFogArea ) == false then
							
							Player.SetDisableAttachMask( true )
						end
					end
				
				elseif TppGameStatus.IsSet("", "S_FOG_AREA") then
					
					if count > 0 then
						if this.GetFlagVars( this.ISCOMPLETE_LIST.isDemoFogArea ) == false then
							
							mvars.isDemoStart = true
							
							TppUI.FadeOut( TppUI.FADE_SPEED.FADE_HIGHESTSPEED, "EndFadeOut_DemoFogArea", nil, nil )
						end
					end
				
				elseif TppGameStatus.IsSet("", "S_NO_FOG_AREA") then
					
					if this.GetFlagVars( this.ISCOMPLETE_LIST.isDemoFogArea ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isRadioFogAreaState ) == false then
						TppRadio.Play("f3010_rtrg0326")
						this.SetFlagVars( this.ISCOMPLETE_LIST.isRadioFogAreaState, true )
					end
					if this.GetFlagVars( this.ISCOMPLETE_LIST.isDemoFogArea ) == false then
						
						Player.SetDisableAttachMask( false )
					end
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			msg = "WakeCombatAi",
			func = function( gameObjectId )
				Fox.Log( "k40070.Messages(): GameObject: msg:WakeCombatAi, gameObjectId:" .. tostring( gameObjectId ) )
				if this.GetFlagVars( this.ISCOMPLETE_LIST.isWakeCombatAi ) == false then
					if gameObjectId == GetGameObjectId( "zmb_s_k40070_01_0000") then
						
						local zombieList01 = {
							"zmb_s_k40070_01_0001",
							"zmb_s_k40070_01_0002",
							"zmb_s_k40070_01_0003",
							"zmb_s_k40070_01_0004",
							"zmb_s_k40070_01_0005",
							"zmb_s_k40070_01_0006",
							"zmb_s_k40070_01_0007",
							"zmb_s_k40070_01_0008",
						}
						
						local zombieList02 = {
							"zmb_s_k40070_01_0021",
							"zmb_s_k40070_01_0022",
							"zmb_s_k40070_01_0023",
							"zmb_s_k40070_01_0024",
							"zmb_s_k40070_01_0025",
							"zmb_s_k40070_01_0026",
							"zmb_s_k40070_01_0027",
							"zmb_s_k40070_01_0028",
						}
						for i, locatorName in pairs( zombieList01 ) do
							this.SetZombieForceWakeUp02( locatorName, { -632.628, 287.660, 2153.664 } )
						end
						for i, locatorName in pairs( zombieList02 ) do
							this.SetZombieForceWakeUp02( locatorName, { -652.733, 284.846, 2143.133 } )
						end
						this.SetFlagVars( this.ISCOMPLETE_LIST.isWakeCombatAi, true )
					end
				end
			end
		},
	},
	Trap = {
		{	
			sender = "trap_missionArea01_radio0000",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01Radio01 ) == false then
					TppRadio.Play( "f3000_rtrg0254" )
					this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01Radio01, true )
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_missionArea01_radio0001",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01Radio02 ) == false and this.GetFlagVars( this.ISCOMPLETE_LIST.isGetBrokenGasCylinder ) == true then
					TppRadio.Play( "f3010_rtrg0306" )
					this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01Radio02, true )
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_missionArea02_radio",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02Radio ) == false then
					TppRadio.Play( "f3000_rtrg0254" )
					this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02Radio, true )
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_missionArea03_radio",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				
				if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Display ) == true then
					if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Radio ) == false then
						TppRadio.Play( "f3000_rtrg0254" )
						this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Radio, true )
					end
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = { "trap_missionArea01", "trap_missionArea02", "trap_missionArea03" },
			msg = "Exit",
			func = function( trapName, gameObjectId )
				
				this.SetStepGameMain()
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_missionArea01",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01Clear ) == false then
					if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01StartRadio ) == false then
						TppRadio.Play( "f3010_rtrg0304" )
						this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01StartRadio, true )
					end
					SsdFlagMission.SetNextStep( this.GetMissionAreaStepName(1) )
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_missionArea02",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02Clear ) == false then
					if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02StartRadio ) == false then
						TppRadio.Play( "f3010_rtrg0302" )
						this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02StartRadio, true )
					end
					SsdFlagMission.SetNextStep( this.GetMissionAreaStepName(2) )
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_missionArea02_tips",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				
				TppTutorial.StartHelpTipsMenuOnlyAnnounce( tipsMenuAnnounceList.TIPS_STEALTH )
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_missionArea03",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				
				if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Display ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Clear ) == false then
					if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03StartRadio ) == false then
						TppRadio.Play( "f3010_rtrg0318" )
						this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03StartRadio, true )
					end
					SsdFlagMission.SetNextStep( this.GetMissionAreaStepName(3) )
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_missionArea03_tips",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				
				TppTutorial.StartHelpTipsMenuOnlyAnnounce( tipsMenuAnnounceList.TIPS_WORMHOLE )
			end,
			option = { isExecFastTravel = true, },
		},

	},
	Sbm = {
		{	
			msg = "OnGetItem",
			func = function( resourceIdCode, inventoryItemType, type, num )
				
				if resourceIdCode == Fox.StrCode32( "RES_BrokenGasCylinder" ) then
					if this.GetFlagVars( this.ISCOMPLETE_LIST.isGetBrokenGasCylinder ) == false then
						this.SetGetBrokenGasCylinderZombie( "zmb_s_k40070_01_0000" )
						this.SetFlagVars( this.ISCOMPLETE_LIST.isGetBrokenGasCylinder, true )
					end
				end
			end,
		},
		{	
			msg = "OnCraft",
			func = function( itemName )
				if itemName == Fox.StrCode32("PRD_SVE_GasCylinder_Lv1") then
					SsdSbm.OpenGasCylinder()
				end
			end
		},
		{	
			msg = "OnSetToPlayerSurvivalSlot",
			func = function( productionIdCode, equipTypeId, playerSlotTypeSsd )
				if productionIdCode == Fox.StrCode32( "PRD_SVE_GasCylinder_Lv1" ) then
					
					if this.GetFlagVars( this.ISCOMPLETE_LIST.isGetMask ) == false then
						this.SetFlagVars( this.ISCOMPLETE_LIST.isGetMask, true )
						
						this.UpdateGuidelines()
						
						mvars.isDemoStart = true
						
						TppUI.FadeOut( TppUI.FADE_SPEED.FADE_HIGHESTSPEED, "EndFadeOut_DemoAirTank", nil, nil )
					end
				end
			end,
		},
	},
	UI = {
		{	
			msg = "SkillMenuOpened",
			func = function()
				if this.GetFlagVars( this.ISCOMPLETE_LIST.isSkillMenu ) == false then
					this.SetFlagVars( this.ISCOMPLETE_LIST.isSkillMenu, true )
					
					this.UpdateGuidelines()
				end
			end
		},
		{	
			sender = "EndFadeOut_DemoAirTank",
			msg = "EndFadeOut",
			func = function()
				
				SsdBuildingMenuSystem.CloseBuildingMenu()
				SsdUiSystem.RequestForceCloseForMissionClear()
				
				GkEventTimerManager.Start( "TimerEndWaitDemoAirTank", 1 )
			end,
		},
		{	
			sender = "EndFadeOut_DemoSkillTracer",
			msg = "EndFadeOut",
			func = function()
				
				SsdBuildingMenuSystem.CloseBuildingMenu()
				SsdUiSystem.RequestForceCloseForMissionClear()
				
				this.StartDemoSkillTracer{
					onInit = function()
						
						this.SetInvisibleSkillAcquisition( true )
					end,
					onSkip = function()
						
						this.SetInvisibleSkillAcquisition( false )
						
						this.SetPowerOffSkillAcquisition( false )
					end,
					onEnd = function()
						
						mvars.isDemoStart = false
						
						this.SetStepGameMain()
					end,
				}
			end,
		},
		{	
			sender = "EndFadeOut_DemoFogArea",
			msg = "EndFadeOut",
			func = function()
				
				this.StartDemoGasMask{
					onSkip = function()
						
						Player.SetDisableAttachMask( false )
						
						Player.SetAttachMaskState()
					end,
					onEnd = function()
						
						mvars.isDemoStart = false
						
						TppTutorial.ResetHelpTipsSettings()
						
						TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_FOGAREA_OXYGEN )
					end,
				}
				this.SetFlagVars( this.ISCOMPLETE_LIST.isDemoFogArea, true )
			end,
		},
	},
	Demo = {
		{	
			msg = "p01_000100_pup_on",
			func = function()
				
				this.SetInvisibleSkillAcquisition( false )
				
				this.SetPowerOffSkillAcquisition( false )
			end,
			option = { isExecDemoPlaying = true },
		},
		{	
			msg = "p01_000070_maskOn",
			func = function()
				
				Player.SetDisableAttachMask( false )
				
				Player.SetAttachMaskState()
			end,
			option = { isExecDemoPlaying = true },
		},
	},
	Timer = {
		{	
			msg = "Finish",
			sender = "TimerEndAiAccessAirTank",
			func = function()
				this.TimerEndAiAccessAirTank()
			end
		},
		{	
			msg = "Finish",
			sender = "TimerWaitOxygenSupplementTips",
			func = function()
				this.StartOxygenSupplementTips()
			end
		},
		{	
			msg = "Finish",
			sender = "TimerWaitSkillTips",
			func = function()
				this.StartSkillTips()
			end
		},
		{	
			msg = "Finish",
			sender = "TimerEndWaitDemoAirTank",
			func = function()
				
				if TppTutorial.IsHelpTipsMenu() then
					
					TppTutorial.ResetHelpTipsSettings()
				end
				
				this.StartDemoAirTank{
					onEnd = function()
						
						mvars.isDemoStart = false
						
						SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_OXYGEN )
						
						TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_OXYGEN_SUPPLEMENT )
					end,
				}
			end
		},
		{	
			msg = "Finish",
			sender = "TimerEndUpdateMisionObjective",
			func = function()
				this.UpdateMisionObjective( false, true, false )
			end
		},
	},
	Radio = {
		{
			msg = "Finish",
			func = function( radioName )
				
				if radioName == Fox.StrCode32( "f3010_rtrg0300" ) then
					
					TppTutorial.StartHelpTipsMenuOnlyAnnounce( tipsMenuAnnounceList.TIPS_QUEST )
				end
			end
		},
	},

}






this.StartDemoAirTank = function( funcs )
	TppDemo.Play( "AirTank", funcs, { useDemoBlock = true, waitBlockLoadEndOnDemoSkip = false, } )
end


this.StartDemoGasMask = function( funcs )
	
	local translation	= GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="GetFloorPosition", } )
	local rotQuat		= Quat.RotationY( TppMath.DegreeToRadian(vars.playerRotY) )
	TppDemo.SetDemoTransform( "GasMask", { translation = translation, rotQuat = rotQuat } )
	TppDemo.Play( "GasMask", funcs, { useDemoBlock = true, waitBlockLoadEndOnDemoSkip = false, } )
end


this.StartDemoSkillTracer = function( funcs )
	TppDemo.Play( "SkillTracer", funcs, { useDemoBlock = true, waitBlockLoadEndOnDemoSkip = false, } )
end






this.UpdateGuidelines = function()
	local guideLineTable = {}
	
	SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{ guidelineIDs = {} }
	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01Clear ) == false then
		table.insert( guideLineTable, "guidelines_mission_common_memoryBoard" )
	end
	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02Clear ) == false then
		table.insert( guideLineTable, "guidelines_mission_common_memoryBoard" )
	end
	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Clear ) == false and this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Display ) == true then
		table.insert( guideLineTable, "guidelines_mission_common_memoryBoard" )
	end
	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01Clear ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01AiAccess ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isGetMask ) == false then
		table.insert( guideLineTable, "guidelines_mission_40070_01" )
	end
	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02Clear ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02AiAccess ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isSkillMenu ) == false then
		table.insert( guideLineTable, "guidelines_mission_40060_01" )
	end
	
	SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{ guidelineIDs = guideLineTable }
end





this.UpdateMisionObjective = function( isClear, isComplete, isAiAccess )
	
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	local isObjectiveIntegration = false
	local isMissionArea01AiAccess = false
	
	
	if isClear == true then
		
		MissionObjectiveInfoSystem.Clear()
	end
	
	
	MissionObjectiveInfoSystem.SetForceOpen( true )
	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Display ) == false then
		
		if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01Clear ) == false then
			MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_common_objective_getMemoryBoard", }
		elseif this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01AiAccess ) == false then
			isObjectiveIntegration = true
			if stepIndex == SsdFlagMission.GetStepIndex( "GameMain_AiAccess" ) then
				if isAiAccess == false then
					if isComplete == true then
						
						MissionObjectiveInfoSystem.Check{ langId = "mission_common_objective_returnToBase", checked = true, }
					end
					MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_common_objective_accessToAI", }
				else
					
					MissionObjectiveInfoSystem.Check{ langId = "mission_common_objective_accessToAI", checked = true, }
				end
			else
				if isComplete == true then
					
					MissionObjectiveInfoSystem.Check{ langId = "mission_common_objective_getMemoryBoard", checked = true, }
				end
				MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_common_objective_returnToBase", }
			end
		else
			isMissionArea01AiAccess = true
		end
		
		local index = 1
		if isMissionArea01AiAccess == true then
			index = 0
		end
		
		if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02Clear ) == false then
			MissionObjectiveInfoSystem.SetParam{ index = index, langId = "mission_common_objective_getMemoryBoard_40070_2", }
		elseif this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02AiAccess ) == false then
			if isObjectiveIntegration == false then
				if stepIndex == SsdFlagMission.GetStepIndex( "GameMain_AiAccess" ) then
					if isAiAccess == false then
						if isComplete == true then
							
							MissionObjectiveInfoSystem.Check{ langId = "mission_common_objective_returnToBase_40070_2", checked = true, }
						end
						MissionObjectiveInfoSystem.SetParam{ index = index, langId = "mission_common_objective_accessToAI_40070_2", }
					else
						
						MissionObjectiveInfoSystem.Check{ langId = "mission_common_objective_accessToAI_40070_2", checked = true, }
					end
				else
					if isComplete == true then
						
						MissionObjectiveInfoSystem.Check{ langId = "mission_common_objective_getMemoryBoard_40070_2", checked = true, }
					end
					MissionObjectiveInfoSystem.SetParam{ index = index, langId = "mission_common_objective_returnToBase_40070_2", }
				end
			else
				if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02AiAccess ) == false then
					if stepIndex == SsdFlagMission.GetStepIndex( "GameMain_AiAccess" ) then
					else
						if isComplete == true then
							
							MissionObjectiveInfoSystem.Check{ langId = "mission_common_objective_getMemoryBoard_40070_2", checked = true, }
						end
					end
				end
				MissionObjectiveInfoSystem.SetParam{ index = index }
			end
		end
	
	else
		if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Clear ) == false then
			MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_common_objective_getMemoryBoard_40070_3", }
		elseif this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03AiAccess ) == false then
			if stepIndex == SsdFlagMission.GetStepIndex( "GameMain_AiAccess" ) then
				if isAiAccess == false then
					if isComplete == true then
						
						MissionObjectiveInfoSystem.Check{ langId = "mission_common_objective_returnToBase_40070_3", checked = true, }
					end
					MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_common_objective_accessToAI_40070_3", }
				else
					
					MissionObjectiveInfoSystem.Check{ langId = "mission_common_objective_accessToAI_40070_3", checked = true, }
				end
			else
				if isComplete == true then
					
					MissionObjectiveInfoSystem.Check{ langId = "mission_common_objective_getMemoryBoard_40070_3", checked = true, }
				end
				MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_common_objective_returnToBase_40070_3", }
			end
		end
	end
end






this.SetFlagVars = function( index, enabled )
	fvars.isComplete[index] = enabled
end


this.GetFlagVars = function( index )
	return fvars.isComplete[index]
end


this.GetMissionAreaStepName = function( areaIndex )
	local missionAreaStepTable	= this.MissionAreaStepList[areaIndex]
	local missionAreaStepVars	= this.MissionAreaStepVars[areaIndex]
	return ( missionAreaStepTable[ fvars[missionAreaStepVars] + 1 ] )
end


this.SetStepGameMain = function( isForceStepGameMain )
	
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) then
		return
	end

	if isForceStepGameMain == true then
		SsdFlagMission.SetNextStep( "GameMain" )
	else
		
		if this.IsAiAccess() == true and TppGameStatus.IsSet( "", "S_IN_BASE_CHECKPOINT" ) then
			if stepIndex  == SsdFlagMission.GetStepIndex( "GameMain_AiAccess" ) then
				return
			else
				SsdFlagMission.SetNextStep( "GameMain_AiAccess" )
			end
		else
			SsdFlagMission.SetNextStep( "GameMain" )
		end
	end
end


this.SetPowerOffSkillAcquisition = function( powerOff )
	Gimmick.SetSsdPowerOff{
		gimmickId		= skillAcquisitionIdentifierParam.gimmickId,
		name			= skillAcquisitionIdentifierParam.name,
		dataSetName		= skillAcquisitionIdentifierParam.dataSetName,
		powerOff		= powerOff,
	}
end


this.SetInvisibleSkillAcquisition = function( enabled )
	Gimmick.InvisibleGimmick(
		0,
		skillAcquisitionIdentifierParam.name,
		skillAcquisitionIdentifierParam.dataSetName,
		enabled,
		{
			gimmickId = skillAcquisitionIdentifierParam.gimmickId,
		}
	)
end


this.SetZombieForceWakeUp02 = function( locatorName, pos )
	local gameObjectId = { type="SsdZombie" }
	local command = { id = "SetForceWakeUp", locatorName=locatorName, pos=pos }
	GameObject.SendCommand( gameObjectId, command )
end


this.SetZombieForceWakeUp01 = function( locatorName )
	local gameObjectId = { type="SsdZombie" }
	local command = { id = "SetForceWakeUp", locatorName=locatorName, pos={-655.846, 284.209, 2137.947} }
	GameObject.SendCommand( gameObjectId, command )
end


this.SetSleepZombie = function( locatorName )
	local gameObjectId = GameObject.GetGameObjectId( "SsdZombie", locatorName )
	local command = { id = "SetSleepZombie", pos={ -651.549, 285.032, 2144.315 }, rollY=225.0, crawl=1, wake=0 }
	GameObject.SendCommand( gameObjectId, command )
end


this.SetGetBrokenGasCylinderZombie = function( locatorName )
	this.SetSleepZombie( locatorName )
	this.SetZombieForceWakeUp01( locatorName )
end



this.IsAiAccess = function()
	local index = false
	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01Clear ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01AiAccess ) == false then
		index = true
	end
	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02Clear ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02AiAccess ) == false then
		index = true
	end
	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Clear ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03AiAccess ) == false then
		index = true
	end
	return index
end








BaseFlagMission.AddStep(
	this,
	"GameMain",
	nil,
	nil,
	{
		
		
		repopResourceIfMateialInsufficient = {
			checkMaterialList = {
				{ id = "RES_Stainless_Steel", count = 1 },
			},
			checkFunction = function()
				
				if ( SsdSbm.GetCountProduction{ id="PRD_SVE_GasCylinder_Lv1", inInventory=true, inWarehouse=true } == 0 ) then
					return true
				else
					return false
				end
			end,
			repopSettingList = {
				{
					gimmickId = "GIM_P_TreasurePoint",
					locatorName = "com_treasure_null001_gim_n0001|srt_gim_null_treasure",
					datasetName = "/Assets/ssd/level/location/afgh/block_small/128/128_148/afgh_128_148_gimmick.fox2",
				},
			},
		}
	}
)


this.flagStep.GameMain.OnEnter = function( self )
	BaseFlagMission.baseStep.OnEnter( self )
	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Display ) == false then
		if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01AiAccess ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02AiAccess ) == true then
			TppRadio.Play( "f3010_rtrg0314" )
			this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Display, true )
			
			this.DisplayMissionArea("marker_missionArea03")
		end
	end
	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionStart ) == false then
		
		SsdSbm.AddRecipe( "RCP_DEF_Scaffold_A" )
		
		SsdSbm.AddRecipe( "RCP_EQP_SWP_Magazine" )
		
		SsdSbm.AddRecipe( "RCP_SVE_Fulton" )
		
		TppRadio.Play( { "f3010_rtrg0300", "f3010_rtrg0301" } )
		
		this.UpdateMisionObjective( true, false, false )
		
		this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionStart, true )
		
		mvars.isContinueRadio = true
	else
		
		this.UpdateMisionObjective( false, false, false )
	end
	
	this.UpdateGuidelines()
	
	if mvars.isContinueRadio == false then
		if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Display ) == false then
			
			if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01Clear ) == true or this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02Clear ) == true then
				TppRadio.Play( "f3010_rtrg0330" )
			else
				TppRadio.Play( "f3010_rtrg0300" )
			end
		else
			TppRadio.Play( "f3010_rtrg0314" )
		end
		mvars.isContinueRadio = true
	end
end

this.flagStep.GameMain.messageTable = {
	GameObject = {
		{	
			msg = "EnterBaseCheckpoint",
			func = function()
				if this.IsAiAccess() == true then
					SsdFlagMission.SetNextStep( "GameMain_AiAccess" )
				end
			end,
			option = { isExecFastTravel = true, },
		},
	},
}




BaseFlagMission.AddStep(
	this,
	"GameMain_AiAccess",
	nil,
	nil,
	{
		radio = "f3000_rtrg0257",
	}
)

this.flagStep.GameMain_AiAccess.OnEnter = function( self )
	BaseFlagMission.baseStep.OnEnter( self )
	
	this.UpdateMisionObjective( false, true, false )
	
	SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
	
	TppMarker.Enable( "marker_ai", 0, "moving", "all", 0, true, true )
end

this.flagStep.GameMain_AiAccess.OnLeave = function( self )
	BaseFlagMission.baseStep.OnLeave( self )
	
	SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
	
	TppMarker.Disable( "marker_ai" )
end

this.flagStep.GameMain_AiAccess.messageTable = {
	GameObject = {
		{
			msg = "SwitchGimmick",
			func = function( gameObjectId, locatorName, upperLocatorName, on )
				local gimmickGameObjectId
				gimmickGameObjectId = Gimmick.SsdGetGameObjectId{
					gimmickId		= "GIM_P_AI",
					name			= "com_ai001_gim_n0000|srt_aip0_main0_def",
					dataSetName		= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",
				}
				if gameObjectId == gimmickGameObjectId then
					
					this.UpdateMisionObjective( false, false, true )
					
					TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "EndFadeOut_AiAccess", nil, nil )
				end
			end
		},
	},
	UI = {
		{
			sender = "EndFadeOut_AiAccess",
			msg = "EndFadeOut",
			func = function()
				
				if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01Clear ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01AiAccess ) == false then
					this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01AiAccess, true )
				end
				
				if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02Clear ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02AiAccess ) == false then
					this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02AiAccess, true )
				end
				
				if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Clear ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03AiAccess ) == false then
					this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03AiAccess, true )
				end
				
				if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03AiAccess ) == true then
					SsdFlagMission.SetNextStep( "GameMain_GameClear" )
				
				elseif ( this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01AiAccess ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isFogAreaTipsStart ) == false ) or ( this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02AiAccess ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isSkillTipsStart ) == false ) then
					SsdFlagMission.SetNextStep( "GameMain_DemoMemoryBoard" )
				end
			end,
		},
	},
}




BaseFlagMission.AddStep(
	this,
	"GameMain_DemoMemoryBoard",
	"GameMain_GameMemoryBoardEnd",
	{
		demo = {
			demoName = "p01_000010",
		},
	},
	{
		nextStepDelay = {
			{ type = "Delay", delayTimeSec = 2.5, },
		},
	}
)




BaseFlagMission.AddStep(
	this,
	"GameMain_GameMemoryBoardEnd",
	nil,
	nil,
	nil
)

this.flagStep.GameMain_GameMemoryBoardEnd.OnEnter = function( self )
	BaseFlagMission.baseStep.OnEnter( self )
	
	this.UpdateMisionObjective( true, false, false )
	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01AiAccess ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isFogAreaTipsStart ) == false then
		this.SetFlagVars( this.ISCOMPLETE_LIST.isFogAreaTipsStart, true )
	end
	
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02AiAccess ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isSkillTipsStart ) == false then
		this.SetFlagVars( this.ISCOMPLETE_LIST.isSkillTipsStart, true )
	end
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isFogAreaTipsStart ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isFogAreaTipsEnd ) == false then
		
		SsdSbm.AddRecipe( "RCP_SVE_GasCylinder_Lv1" )
		
		TppRadio.Play( "f3010_rtrg0310" )
		
		GkEventTimerManager.Start( "TimerEndAiAccessAirTank", 12 )
		
		this.SetFlagVars( this.ISCOMPLETE_LIST.isFogAreaTipsEnd, true )
	elseif this.GetFlagVars( this.ISCOMPLETE_LIST.isSkillTipsStart ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isSkillTipsEnd ) == false then
		
		this.StartSkillTips()
	else
		
		this.SetStepGameMain()
	end
end


this.TimerEndAiAccessAirTank = function()
	
	local count = SsdSbm.GetCountProduction{ id="PRD_SVE_GasCylinder_Lv1", inInventory=true, inWarehouse=true }
	if count > 0 then
		this.StartOxygenSupplementTips()
	else
		
		this.EndOxygenSupplementTips()
	end
end


this.StartOxygenSupplementTips = function()
	if not TppTutorial.IsHelpTipsMenu() then
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_OXYGEN )
		
		TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_OXYGEN_SUPPLEMENT_AIRTANK )
	else
		GkEventTimerManager.Start( "TimerWaitOxygenSupplementTips", 1 )
	end
end


this.EndOxygenSupplementTips = function()
	if this.GetFlagVars( this.ISCOMPLETE_LIST.isSkillTipsStart ) == true and this.GetFlagVars( this.ISCOMPLETE_LIST.isSkillTipsEnd ) == false then
		
		this.StartSkillTips()
	else
		
		this.SetStepGameMain()
	end
end


this.StartSkillTips = function()
	if mvars.isDemoStart == true then
		return
	end
	if not TppTutorial.IsHelpTipsMenu() then
		
		TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_SKILL )
		
		SsdSbm.AddRecipe( "RCP_EQP_WP_Machete_A" )
		
		SsdSbm.AddRecipe( "RCP_EQP_SWP_Flag" )
	else
		
		GkEventTimerManager.Start( "TimerWaitSkillTips", 1 )
	end
end


this.EndSkillTips = function()
	
	this.SetFlagVars( this.ISCOMPLETE_LIST.isSkillTipsEnd, true )
	
	mvars.isDemoStart = true
	
	TppUI.FadeOut( TppUI.FADE_SPEED.FADE_HIGHESTSPEED, "EndFadeOut_DemoSkillTracer", nil, nil )
end




BaseFlagMission.AddStep(
	this,
	"GameMain_GameClear",
	nil,
	{
		clearStage = {
			demo = "p01_000010",
			fadeSpeed = TppUI.FADE_SPEED.FADE_MOMENT,
		},
	}
)




this.blackRadioOnEnd = "K40070_0020"






this.afterDemoFunc01 = function()
	
	SsdSbm.AddArchive{ id = { "ARCHIVE_A_002", "ARCHIVE_B_002" } }
end




BaseFlagMission.AddStep(
	this,
	"GameArea01_GameMemoryBoard",
	"GameArea01_GameEscape",
	{
		switch = {
			{
				gimmickId			= memoryBoardIdentifierParam[1].gimmickId,
				locatorName			= memoryBoardIdentifierParam[1].name,
				datasetName			= memoryBoardIdentifierParam[1].dataSetName,
				isPowerOn			= true,
				isAlertLockType		= true,
				memoryBoardDemo = {
					identifier = "GetIntelIdentifier_k40070_sequence",
					key = "GetIntel_MemoryBoard01",
					afterDemoFunc = this.afterDemoFunc01,
				},
			},
		},
	},
	{
		marker = {
			{ name = "marker_area01", areaName = "marker_missionArea01", },
		},
		breakBody = {
			
			{ enemyName = "zmb_s_k40070_01_0000", legL = 1, },
			
			{ enemyName = "zmb_s_k40070_01_0001", armR = 1, },
			{ enemyName = "zmb_s_k40070_01_0002", legR = 1, legL = 1 },
			{ enemyName = "zmb_s_k40070_01_0003", legR = 1, legL = 1 },
			{ enemyName = "zmb_s_k40070_01_0004", legL = 1	},
			{ enemyName = "zmb_s_k40070_01_0005", legR = 1, legL = 1 },
			{ enemyName = "zmb_s_k40070_01_0006", legR = 1, },
			{ enemyName = "zmb_s_k40070_01_0007", legR = 1	},
			{ enemyName = "zmb_s_k40070_01_0008", legR = 1, legL = 1 },
			
			{ enemyName = "zmb_s_k40070_01_0021", legR = 1, legL = 1 },
			{ enemyName = "zmb_s_k40070_01_0022", armL = 1, },
			{ enemyName = "zmb_s_k40070_01_0023", legR = 1, },
			{ enemyName = "zmb_s_k40070_01_0024", legR = 1, },
			{ enemyName = "zmb_s_k40070_01_0025", legR = 1, legL = 1 },
			{ enemyName = "zmb_s_k40070_01_0026", legR = 1, legL = 1 },
			{ enemyName = "zmb_s_k40070_01_0027", legR = 1, legL = 1 },
			{ enemyName = "zmb_s_k40070_01_0028", legR = 1, legL = 1 },
		},
	}
)




BaseFlagMission.AddStep(
	this,
	"GameArea01_GameEscape",
	nil,
	nil,
	{
		radio = "f3000_rtrg0256",
	}
)

this.flagStep.GameArea01_GameEscape.OnEnter = function( self )
	BaseFlagMission.baseStep.OnEnter( self )
	
	this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionArea01Clear, true )
	
	this.UpdateGuidelines()
	
	GkEventTimerManager.Start( "TimerEndUpdateMisionObjective", 1 )
	
	this.DisableMissionArea( "marker_missionArea01" )
end






this.afterDemoFunc02 = function()
	
	SsdSbm.AddArchive{ id = { "ARCHIVE_A_003","ARCHIVE_B_003" } }
end




BaseFlagMission.AddStep(
	this,
	"GameArea02_GameMemoryBoard",
	"GameArea02_GameEscape",
	{
		switch = {
			{
				gimmickId			= memoryBoardIdentifierParam[2].gimmickId,
				locatorName			= memoryBoardIdentifierParam[2].name,
				datasetName			= memoryBoardIdentifierParam[2].dataSetName,
				isPowerOn			= true,
				isAlertLockType		= true,
				memoryBoardDemo = {
					identifier = "GetIntelIdentifier_k40070_sequence",
					key = "GetIntel_MemoryBoard02",
					afterDemoFunc = this.afterDemoFunc02,
				},
			},
		},
	},
	{
		marker = {
			{ name = "marker_area02", areaName = "marker_missionArea02", },
		},
	}
)




BaseFlagMission.AddStep(
	this,
	"GameArea02_GameEscape",
	nil,
	nil,
	{
		radio = "f3000_rtrg0256",
	}
)

this.flagStep.GameArea02_GameEscape.OnEnter = function( self )
	BaseFlagMission.baseStep.OnEnter( self )
	
	this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionArea02Clear, true )
	
	this.UpdateGuidelines()
	
	GkEventTimerManager.Start( "TimerEndUpdateMisionObjective", 1 )
	
	this.DisableMissionArea( "marker_missionArea02" )
end






this.afterDemoFunc03 = function()
	
	SsdSbm.AddArchive{ id = { "ARCHIVE_A_004", "ARCHIVE_B_004" } }
end




BaseFlagMission.AddStep(
	this,
	"GameArea03_GameMemoryBoard",
	"GameArea03_GameEscape",
	{
		switch = {
			{
				gimmickId			= memoryBoardIdentifierParam[3].gimmickId,
				locatorName			= memoryBoardIdentifierParam[3].name,
				datasetName			= memoryBoardIdentifierParam[3].dataSetName,
				isPowerOn			= true,
				isAlertLockType		= true,
				memoryBoardDemo = {
					identifier = "GetIntelIdentifier_k40070_sequence",
					key = "GetIntel_MemoryBoard03",
					afterDemoFunc = this.afterDemoFunc03,
				},
			},
		},
	},
	{
		marker = {
			{ name = "marker_area03", areaName = "marker_missionArea03", },
		},
		breakBody = {
			{ enemyName = "zmb_s_k40070_03_0000", legR = 1, legL = 1 },
			{ enemyName = "zmb_s_k40070_03_0001", legR = 1, legL = 1 },
			{ enemyName = "zmb_s_k40070_03_0002", legR = 1, legL = 1 },
			{ enemyName = "zmb_s_k40070_03_0003", armL = 1,  },
		},
	}
)




BaseFlagMission.AddStep(
	this,
	"GameArea03_GameEscape",
	nil,
	nil,
	{
		radio = "f3000_rtrg0256",
	}
)

this.flagStep.GameArea03_GameEscape.OnEnter = function( self )
	BaseFlagMission.baseStep.OnEnter( self )
	
	this.SetFlagVars( this.ISCOMPLETE_LIST.isMissionArea03Clear, true )
	
	this.UpdateGuidelines()
	
	GkEventTimerManager.Start( "TimerEndUpdateMisionObjective", 1 )
	
	this.DisableMissionArea( "marker_missionArea03" )
end




this.releaseAnnounce = { "OpenStagingArea", "CanJoinCoopMission", }

return this
