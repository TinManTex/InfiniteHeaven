



local this = BaseFlagMission.CreateInstance( "k40040" )

local lastAddedStep

local MISSONOBJECTIVE_WATER_ID	= "PRD_FOD_Bottle_Water_Pure"
local MISSONOBJECTIVE_FOOD_ID	= "RES_Meat_A"


this.missionDemoBlock = { demoBlockName = "UpdateInfo" }




local tipsMenuList = {
	
	TIPS_STAMP = {
		startRadio		= "f3010_rtrg0116",
		tipsTypes		= {
							{ HelpTipsType.TIPS_11_A, HelpTipsType.TIPS_11_B },
						},
		endFunction		= function() this.EndTipsStamp( true ) end,
	},
	
	TIPS_INVENTORY_FOOD = {
		startRadio		= "f3010_rtrg0111",
		tipsTypes		= {
							 { HelpTipsType.TIPS_8_A, HelpTipsType.TIPS_8_B, HelpTipsType.TIPS_8_C },
						},
		tipsRadio		= "f3010_rtrg0112",
		endFunction		= function() this.EndTipsInventoryFood() end,
	},
	
	TIPS_INVENTORY_WATER = {
		tipsTypes		= {
							 { HelpTipsType.TIPS_8_A, HelpTipsType.TIPS_8_B, HelpTipsType.TIPS_8_C },
						},
		tipsRadio		= "f3010_rtrg0112",
	}
}




local tipsMenuAnnounceList = {
	
	TIPS_ITEMDETERIORATION = {
		tipsTypes = {
			HelpTipsType.TIPS_50_A, HelpTipsType.TIPS_50_B,
		},
	},
	
	TIPS_STAMP = {
		tipsTypes = {
			HelpTipsType.TIPS_11_A, HelpTipsType.TIPS_11_B,
		},
	},
}



this.missionAreas = {
	{ name = "marker_missionArea", trapName = "trap_missionArea", visibleArea = 3, guideLinesId = "guidelines_mission_common_vitalReaction", hide = true},
}




BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isStampOpend",				 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isStampPressed",				 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isRadioSheep",				 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isTipsWater",					 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION }, 
		{ name = "isMaspOpened",				 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isGetFood",					 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isGetWater",					 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isTipsInventory",				 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isNextStepReturnToBase",		 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isLocationTab",				 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isDisplayMissionArea",		 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isEnableUseMarker",			 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isTrapStamp",					 type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)




this.OnActivate = function()

	local stepIndex = SsdFlagMission.GetCurrentStepIndex()

	if stepIndex >= SsdFlagMission.GetStepIndex( "GameOpening" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameTipsHungry" ) then
		
		ObjectiveIconSystem.Hide{ icon = ObjectiveIconSystem.LOCATION_TAB }
	end

	if stepIndex >= SsdFlagMission.GetStepIndex( "GameOpening" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameMarker" ) then
		
		SsdMbDvc.EnableTutorialMap()
	else
		
		SsdMbDvc.DisableTutorialMap()
	end
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameOpening" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameTipsHungry" ) then
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.SET_MBDVC_FIRST_TUTORIAL )
	else
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.SET_MBDVC_FIRST_TUTORIAL )
	end

	if stepIndex >= SsdFlagMission.GetStepIndex( "GameTipsHungry" ) then
		
		vars.playerDisableActionFlag = bit.band( vars.playerDisableActionFlag, bit.bnot(PlayerDisableAction.MB_TERMINAL) )
	end

	if stepIndex >= SsdFlagMission.GetStepIndex( "GameMap" ) then
		
		ScriptParam.ResetValueToDefault{ category = ScriptParamCategory.PLAYER, paramName = "ignoreHunger" }
		ScriptParam.ResetValueToDefault{ category = ScriptParamCategory.PLAYER, paramName = "ignoreThirst" }
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_HUNGER )
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_THIRST )
	end

	if stepIndex >= SsdFlagMission.GetStepIndex( "GameMapOpen" ) then
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_MBDVC_LOCATION_TAB )
	end

	
	if stepIndex == SsdFlagMission.GetStepIndex( "GameMarker" ) then
		if fvars.isEnableUseMarker == true then
			fvars.isEnableUseMarker = false
		end
		if fvars.isDisplayMissionArea == true then
			fvars.isDisplayMissionArea = false
		end
	end

	if stepIndex >= SsdFlagMission.GetStepIndex( "GameExplor" ) then
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_MBDVC_CLOSE_BY_PAD )
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_MBDVC_PRESS_USER_MARKER )
	end

	if stepIndex >= SsdFlagMission.GetStepIndex( "GameReturnToBase" ) then
		if fvars.isStampOpend == true then
			
			SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_MBDVC_PRESS_STAMP )
		end
	end

	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameOpening" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameExplor" ) then
		
		this.DisplayGuideLine( { "guidelines_mission_ack_water", "guidelines_mission_lack_food" } )
	end
	
	
	if stepIndex == SsdFlagMission.GetStepIndex( "GameExplor" ) then
		
		this.DisplayMissionArea("marker_missionArea")
		
		this.AddDisplayGuideLine( { "guidelines_mission_common_vitalReaction" } )
	end

	
	MissionObjectiveInfoSystem.SetForceOpen( true )

end




this.messageTable = {
	Terminal = {
		{	
			msg = "MbTerminalStampPressed",
			func = function( stampId )
				if fvars.isStampOpend == true and fvars.isStampPressed == false and stampId ~= 400 then
					TppRadio.Play( "f3010_rtrg0118" )
					fvars.isStampPressed = true
				end
			end
		},
		{	
			msg = "MbTerminalOpened",
			func = function()
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex >= SsdFlagMission.GetStepIndex( "GameMap" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameMarker" ) then
					
					
					SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_MBDVC_CLOSE_BY_PAD )
				end
			end
		},
	},
	GameObject = {
		{	
			msg = "OnGetItem",
			func = function( resourceIdCode, inventoryItemType, type, num )
				this.OnGetItem( resourceIdCode, false )
			end
		},
	},
	Sbm = {
		{	
			msg = "OnGetItem",
			func = function( resourceIdCode, inventoryItemType, type, num )
				this.OnGetItem( resourceIdCode, false )
			end
		},
	},
	Timer = {
		{	
			msg = "Finish",
			sender = { "TimerTipsInventoryWater", "TimerWaitTipsInventoryWater" },
			func = function()
				this.StartHelpTipsMenuInventory()
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			msg = "Finish",
			sender = { "TimerTipsInventoryFood", "TimerWaitTipsInventoryFood" },
			func = function()
				this.StartHelpTipsMenuInventory( true )
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			msg = "Finish",
			sender = "TimerStampTips",
			func = function()
				this.StartHelpTipsMenuStamp( false )
			end,
			option = { isExecFastTravel = true, },
		},
	},
	Trap = {
		{	
			sender = "trap_stamp",
			msg = "Enter",
			func = function()
				this.StartHelpTipsMenuStamp( false )
			end,
			option = { isExecFastTravel = true, },
		},
	},
}






this.StartTimerHelpTipsMenuInventory = function( isFood )
	if fvars.isTipsInventory == false then
		
		if isFood == true then
			GkEventTimerManager.Start( "TimerTipsInventoryFood", 2 )
		else
			GkEventTimerManager.Start( "TimerTipsInventoryWater", 3 )
		end
		fvars.isTipsInventory = true
	end
end


this.StartHelpTipsMenuInventory = function( isFood )
	if not TppTutorial.IsHelpTipsMenu() then
		if isFood == true then
			TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_INVENTORY_FOOD )
		else
			TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_INVENTORY_WATER )
		end
	else
		GkEventTimerManager.Start( "TimerWaitTipsInventory", 1 )
	end
end


this.EndTipsInventoryFood = function()
	
	TppTutorial.StartHelpTipsMenuOnlyAnnounce( tipsMenuAnnounceList.TIPS_ITEMDETERIORATION )
end






this.StartHelpTipsMenuStamp = function( isDB )
	
	if fvars.isTrapStamp == false then
		fvars.isTrapStamp = true
	end
	if isDB == false then
		if fvars.isStampOpend == false then
			if not TppTutorial.IsHelpTipsMenu() then
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex >= SsdFlagMission.GetStepIndex( "GameReturnToBase" ) then
					
					TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_STAMP )
					fvars.isStampOpend = true
				end
			else
				GkEventTimerManager.Start( "TimerStampTips", 1 )
			end
		end
	else
		if fvars.isStampOpend == false and fvars.isTrapStamp == true then
			
			TppTutorial.StartHelpTipsMenuOnlyAnnounce( tipsMenuAnnounceList.TIPS_STAMP )
			
			this.EndTipsStamp( false )
		end
	end
end


this.EndTipsStamp = function( isShowControlGuide )
	
	SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_MBDVC_PRESS_STAMP )
	if isShowControlGuide == true then
		
		TppUI.ShowControlGuide{ actionName = "MB_DEVICE", continue = false, isOnce = false }
	end
end


this.OnGetItemFood = function( isCheck )
	fvars.isGetFood = true
	TppMarker.Disable( "marker_sheep", nil, true )
	if isCheck == true then
		GkEventTimerManager.Start( "TimerMissionObjectiveCheckFood", 8 )
	else
		GkEventTimerManager.Start( "TimerMissionObjectiveCheckFood", 0.5 )
	end
end


this.OnGetItemWater = function( isCheck )
	fvars.isGetWater = true
	TppMarker.Disable( "marker_water", nil, true )
	if isCheck == true then
		GkEventTimerManager.Start( "TimerMissionObjectiveCheckWater", 8 )
	else
		GkEventTimerManager.Start( "TimerMissionObjectiveCheckWater", 0.5 )
	end
end


this.OnGetItem = function( resourceIdCode, isCheck )
	local isFood	= fvars.isGetFood
	local isWater	= fvars.isGetWater

	
	if resourceIdCode == nil and isCheck == true then
		
		local foodCount = SsdSbm.GetCountResource{ id=MISSONOBJECTIVE_FOOD_ID, inInventory=true, inWarehouse=true }
		if foodCount > 0 then
			this.OnGetItemFood( isCheck )
		end
		
		local waterCount = SsdSbm.GetCountProduction{ id=MISSONOBJECTIVE_WATER_ID, inInventory=true, inWarehouse=true }
		if waterCount > 0 then
			this.OnGetItemWater( isCheck )
		end
	end
	
	if resourceIdCode == Fox.StrCode32( MISSONOBJECTIVE_FOOD_ID ) then
		if fvars.isGetFood == false then
			if fvars.isTipsInventory == true then
				TppRadio.Play( "f3010_rtrg0111" )
			end
			this.OnGetItemFood( isCheck )
			this.StartTimerHelpTipsMenuInventory( true )
		end
	
	elseif resourceIdCode == Fox.StrCode32( MISSONOBJECTIVE_WATER_ID ) then
		if fvars.isGetWater == false then
			this.OnGetItemWater( isCheck )
			this.StartTimerHelpTipsMenuInventory( false )
		end
	end
	
	if fvars.isGetWater == true and fvars.isGetFood == true then
		if not GkEventTimerManager.IsTimerActive( "TimerNextStepReturnToBase" ) then
			local stepIndex = SsdFlagMission.GetCurrentStepIndex()
			if stepIndex == SsdFlagMission.GetStepIndex( "GameExplor" ) then
				
				if isFood == true and isWater == false then
					GkEventTimerManager.Start( "TimerNextStepReturnToBase", 3 )		
				
				elseif isFood == false and isWater == true then
					GkEventTimerManager.Start( "TimerNextStepReturnToBase", 13 )	
				
				else
					GkEventTimerManager.Start( "TimerNextStepReturnToBase", 10 )	
				end
			end
		end
	end
end


this.OnMissionAreaTagetMarker = function( enabled )
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	if stepIndex == SsdFlagMission.GetStepIndex( "GameExplor" ) then
		if fvars.isGetFood == false then
			if enabled == true then
				TppMarker.Enable( "marker_sheep", 0, "moving", "all", 0, true, true )
			else
				TppMarker.Disable( "marker_sheep", nil, true )
			end
		end
		if fvars.isGetWater == false then
			if enabled == true then
				TppMarker.Enable( "marker_water", 0, "moving", "all", 0, true, true )
			else
				TppMarker.Disable( "marker_water", nil, true )
			end
		end
	end
end


this.OnMissionAreaRadio = function()
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	if stepIndex == SsdFlagMission.GetStepIndex( "GameExplor" ) then
		if fvars.isGetFood == false and fvars.isRadioSheep == false then
			TppRadio.Play("f3010_rtrg0110")
			fvars.isRadioSheep = true
		end
	end
end








lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameOpening",
	OnEnter = function( self )
		
		SsdMbDvc.EnableTutorialMap()
		
		this.DisplayGuideLine( { "guidelines_mission_ack_water", "guidelines_mission_lack_food" } )
		
		GkEventTimerManager.Start( "TimerUnsetMbDevice", 10 )
		
		mvars.ReleaseMbDevice = false
	end,
	clearConditionTable = {
	},
	options = {
		radio = "f3010_rtrg0100",
		checkObjectiveIfCleared = "mission_40040_objective_01",
		nextStepDelay = {
			{ type = "Delay", delayTimeSec = 2.0, },
		},
	},
}

this.flagStep.GameOpening.messageTable = {
	Terminal = {
		{	
			msg = "MbTerminalOpened",
			func = function()
				this.SetNextStepGameOpening()
			end,
		},
	},
	Radio = {
		{	
			msg = "Finish",
			func = function( radioName )
				if radioName == Fox.StrCode32( "f3010_rtrg0100" ) then
					
					this.UnsetMbDevice()
				end
			end,
			option = { isExecFastTravel = true, }
		},
	},
	Timer = {
		{
			msg = "Finish",
			sender = "TimerUnsetMbDevice",
			func = function()
				
				if TppRadioCommand.IsPlayingRadio() then
					GkEventTimerManager.Start( "TimerUnsetMbDevice", 1 )
				else
					
					this.UnsetMbDevice()
				end
			end,
			option = { isExecFastTravel = true, }
		},
		{
			msg = "Finish",
			sender = "TimerTutorialHelpTipsMenu",
			func = function()
				this.SetNextStepGameOpening()
			end,
			option = { isExecFastTravel = true, }
		},
	},
}


this.SetNextStepGameOpening = function()
	if not TppTutorial.IsHelpTipsMenu() then
		local stepIndex = SsdFlagMission.GetCurrentStepIndex()
		if stepIndex == SsdFlagMission.GetStepIndex( "GameOpening" ) then
			this.flagStep.GameOpening:GoToNextStepIfConditionCleared( nil )
		end
	else
		GkEventTimerManager.Start( "TimerTutorialHelpTipsMenu", 1 )
	end
end


this.UnsetMbDevice = function()
	if mvars.ReleaseMbDevice == false then
		mvars.ReleaseMbDevice = true
		
		this.StartGameOpeningMissionObjective()
		
		vars.playerDisableActionFlag = bit.band( vars.playerDisableActionFlag, bit.bnot(PlayerDisableAction.MB_TERMINAL) )
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.SET_MBDVC_FIRST_TUTORIAL )
		
		TppUI.ShowControlGuide{ actionName = "MB_DEVICE", continue = false, isOnce = false }
	end
end


this.StartGameOpeningMissionObjective = function()
	MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_40040_objective_01", }
	MissionObjectiveInfoSystem.Open()
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameTipsHungry",
	clearConditionTable = {
		tips = {
			tipsRadio		= "f3010_rtrg0101",
			tipsTypes		= { HelpTipsType.TIPS_4_A, HelpTipsType.TIPS_4_B, HelpTipsType.TIPS_4_C },
		},
	},
	options = {
		nextStepDelay = {
			{ type = "Delay", delayTimeSec = 1.0, },
		},
	}
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameMap",
	OnEnter = function( self )
		
		ScriptParam.ResetValueToDefault{ category = ScriptParamCategory.PLAYER, paramName = "ignoreHunger" }
		ScriptParam.ResetValueToDefault{ category = ScriptParamCategory.PLAYER, paramName = "ignoreThirst" }
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_HUNGER )
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_THIRST )
		
		GkEventTimerManager.Start( "TimerLocationTab", 2 )
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_MBDVC_CLOSE_BY_PAD )
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.SET_MBDVC_FIRST_TUTORIAL )
	end,
	clearConditionTable = {
	},
	options = {
		radio = "f3010_rtrg0102",
		objective				= "mission_common_objective_openMAP",
		checkObjectiveIfCleared	= "mission_common_objective_openMAP",
		nextStepDelay = {
			{ type = "Delay", delayTimeSec = 1.0, },
		},
	}
}




this.flagStep.GameMap.messageTable = {
	Terminal = {
		{	
			msg = "MbTerminalOpened",
			func = function()
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex == SsdFlagMission.GetStepIndex( "GameMap" ) then
					if fvars.isLocationTab == false then
						
						this.SetLocationTab()
					end
				end
			end
		},
		{	
			msg = "MbTerminalMapOpened",
			func = function()
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex == SsdFlagMission.GetStepIndex( "GameMap" ) then
					this.flagStep.GameMap:GoToNextStepIfConditionCleared( nil )
				end
			end
		},
	},
	Timer = {
		{
			msg = "Finish",
			sender = "TimerLocationTab",
			func = function()
				
				if TppRadioCommand.IsPlayingRadio() then
					GkEventTimerManager.Start( "TimerLocationTab", 1 )
				else
					
					this.SetLocationTab()
				end
			end,
			option = { isExecFastTravel = true, }
		},
	},
}


this.SetLocationTab = function()
	
	fvars.isLocationTab = true
	
	SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_MBDVC_LOCATION_TAB )
	
	ObjectiveIconSystem.Show{ icon = ObjectiveIconSystem.LOCATION_TAB }
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameMapOpen",
	OnEnter = function( self )
		
		GkEventTimerManager.Start( "TimerGameMap", 37 )
		
		ObjectiveIconSystem.Hide{ icon = ObjectiveIconSystem.LOCATION_TAB }
	end,
	clearConditionTable = {
	},
	options = {
		radio = { "f3010_rtrg0103", "f3010_rtrg0104" },
	}
}

this.flagStep.GameMapOpen.messageTable = {
	Terminal = {
		{	
			msg = "MbTerminalOpened",
			func = function()
				this.NextStepGameMapOpen()
			end
		},
	},
	Radio = {
		{
			msg = "Finish",
			func = function( radioName )
				if radioName == Fox.StrCode32( "f3010_rtrg0104" ) then
					this.NextStepGameMapOpen()
				end
			end,
			option = { isExecFastTravel = true, }
		},
	},
	Timer = {
		{
			msg = "Finish",
			sender = "TimerGameMap",
			func = function()
				
				if TppRadioCommand.IsPlayingRadio() then
					GkEventTimerManager.Start( "TimerGameMap", 1 )
				else
					this.NextStepGameMapOpen()
				end
			end,
			option = { isExecFastTravel = true, }
		},
	},
}


this.NextStepGameMapOpen = function()
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	if stepIndex == SsdFlagMission.GetStepIndex( "GameMapOpen" ) then
		this.flagStep.GameMapOpen:GoToNextStepIfConditionCleared( nil )
	end
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameMarker",
	OnEnter = function( self )
		
		GkEventTimerManager.Start( "TimerGameEnableUseMarker", 10 )
		
		GkEventTimerManager.Start( "TimerGameEnableMissionArea", 10 )
	end,
	clearConditionTable = {
	},
	options = {
		radio = "f3010_rtrg0106",
		nextStepDelay = {
			{ type = "Delay", delayTimeSec = 1.0, },
		},
		checkObjectiveIfCleared = "mission_40040_objective_08",
	}
}

this.flagStep.GameMarker.messageTable = {
	Terminal = {
		{	
			msg = "MbTerminalOpened",
			func = function()
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex == SsdFlagMission.GetStepIndex( "GameMarker" ) then
					
					this.EnableUseMarker()
					
					this.EnableMissionArea()
				end
			end
		},
		{	
			msg = "MbTerminalUserMarkerPressed",
			func = function( stampId, posX, posY, isTargetMarker )
				
				if isTargetMarker == 1 then
					local stepIndex = SsdFlagMission.GetCurrentStepIndex()
					if stepIndex == SsdFlagMission.GetStepIndex( "GameMarker" ) then
						this.flagStep.GameMarker:GoToNextStepIfConditionCleared( nil )
					end
				end
			end
		},
	},
	Radio = {
		{	
			msg = "Finish",
			func = function( radioName )
				if radioName == Fox.StrCode32( "f3010_rtrg0106" ) then
					this.EnableUseMarker()
				end
			end
		},
	},
	Timer = {
		{	
			msg = "Finish",
			sender = "TimerGameEnableUseMarker",
			func = function()
				
				if TppRadioCommand.IsPlayingRadio() then
					GkEventTimerManager.Start( "TimerGameEnableUseMarker", 1 )
				else
					this.EnableUseMarker()
				end
			end,
			option = { isExecFastTravel = true, }
		},
		{	
			msg = "Finish",
			sender = "TimerGameEnableMissionArea",
			func = function()
				
				this.EnableMissionArea()
			end,
			option = { isExecFastTravel = true, }
		},
	},
}


this.EnableUseMarker = function()
	if fvars.isEnableUseMarker == false then
		fvars.isEnableUseMarker = true
		
		MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_40040_objective_08", }
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_MBDVC_PRESS_USER_MARKER )
	end
end


this.EnableMissionArea = function()
	if fvars.isDisplayMissionArea == false then
		fvars.isDisplayMissionArea = true
		
		this.DisplayMissionArea("marker_missionArea")
		
		this.AddDisplayGuideLine( { "guidelines_mission_common_vitalReaction" } )
	end
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameExplor",
	OnEnter = function( self )
		
		SsdMbDvc.DisableTutorialMap()
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_MBDVC_CLOSE_BY_PAD )
		
		this.OnGetItem( nil, true )
	end,
	clearConditionTable = {
	},
	options = {
		radio = "f3010_rtrg0108",
		objective = {
			"mission_40040_objective_07", 
			"mission_40040_objective_03", 
		},
	}
}

this.flagStep.GameExplor.messageTable = {
	Trap = {
		{	
			sender = "trap_missionArea",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				
				this.OnMissionAreaTagetMarker( true )
				
				this.OnMissionAreaRadio()
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_missionArea",
			msg = "Exit",
			func = function( trapName, gameObjectId )
				this.OnMissionAreaTagetMarker( false )
			end,
			option = { isExecFastTravel = true, },
		},
	},
	Sbm = {
		{	
			msg = "OnGetItem",
			func = function( resourceIdCode, inventoryItemType, type, num )
				this.OnGetItem( resourceIdCode, false )
			end
		},
	},
	Timer = {
		{	
			msg = "Finish",
			sender = "TimerNextStepReturnToBase",
			func = function()
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex == SsdFlagMission.GetStepIndex( "GameExplor" ) then
					if TppRadioCommand.IsPlayingRadio() then
						GkEventTimerManager.Start( "TimerNextStepReturnToBase", 1 )
					else
						this.flagStep.GameExplor:GoToNextStepIfConditionCleared( nil )
					end
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			msg = "Finish",
			sender = "TimerMissionObjectiveCheckFood",
			func = function()
				MissionObjectiveInfoSystem.Check{ langId = "mission_40040_objective_07", checked = true, }
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			msg = "Finish",
			sender = "TimerMissionObjectiveCheckWater",
			func = function()
				MissionObjectiveInfoSystem.Check{ langId = "mission_40040_objective_03", checked = true, }
			end,
			option = { isExecFastTravel = true, },
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameReturnToBase",
	OnEnter = function( self )
		
		this.DisableMissionArea( "marker_missionArea" )
		
		this.DisableGuideLine()
		
		if TppGameStatus.IsSet( "", "S_IN_BASE_CHECKPOINT" ) then
			GkEventTimerManager.Start( "TimerResultUiEnd", 5 )
		end
	end,
	clearConditionTable = {
	},
	options = {
		radio = "f3010_rtrg0114",
		objective				= "mission_common_objective_returnToBase",
		checkObjectiveIfCleared = "mission_common_objective_returnToBase",
		nextStepDelay = {
			{ type = "Delay", delayTimeSec = 1.0, },
		},
	}
}

this.flagStep.GameReturnToBase.messageTable = {
	UI = {
		{	
			msg = "BaseResultUiSequenceDaemonEnd",
			func = function()
				this.SetNextStepTipsStorage()
			end,
			option = { isExecFastTravel = true, },
		},
	},
	GameObject = {
		{	
			msg = "EnterBaseCheckpoint",
			func = function ()
				
				GkEventTimerManager.Start( "TimerResultUiEnd", 10 )
			end,
			option = { isExecFastTravel = true, },
		},
	},
	Timer = {
		{	
			msg = "Finish",
			sender = "TimerResultUiEnd",
			func = function()
				this.SetNextStepTipsStorage()
			end,
			option = { isExecFastTravel = true, },
		},
	},
}


this.SetNextStepTipsStorage = function()
	if SsdFlagMission.GetCurrentStepIndex() <= SsdFlagMission.GetStepIndex( "GameReturnToBase" ) then
		if not TppTutorial.IsHelpTipsMenu() and not TppRadioCommand.IsPlayingRadio() then
			this.flagStep.GameReturnToBase:GoToNextStepIfConditionCleared( nil )
		else
			GkEventTimerManager.Start( "TimerResultUiEnd", 1 )
		end
	end
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameTipsStorage",
	clearConditionTable = {
		tips = {
			tipsRadio		= "f3010_rtrg0120",
			tipsTypes		= { HelpTipsType.TIPS_9_A, HelpTipsType.TIPS_9_B },
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameAiAccess",
	OnEnter = function( self )
		
		TppMarker.Enable( "marker_ai", 0, "moving", "all", 0, true, true )
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
		
		this.StartHelpTipsMenuStamp( true )
	end,
	clearConditionTable = {
		switch = {
			{
				gimmickId	= "GIM_P_AI",
				locatorName = "com_ai001_gim_n0000|srt_aip0_main0_def",
				datasetName = "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",
			},
		},
	},
	options = {
		radio = "f3000_rtrg0252",
		objective				= "mission_common_objective_accessToAI",
		checkObjectiveIfCleared = "mission_common_objective_accessToAI",
	}
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameClear",
	clearConditionTable = {
		clearStage = {
			demo = {
				
				demoName = "p01_000011",
				options = { useDemoBlock = true },
			},
			fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED,
		}
	},
}




this.blackRadioOnEnd = "S10010_0030"




this.releaseAnnounce = { "AddRecipeNormalFence", "OpenStagingArea", "CanJoinCoopMission", "EnableCreateCoop", "OpenNewCoopMission", }--RETAILPATCH: 1.0.12 everything but AddRecipeNormalFence added

return this
