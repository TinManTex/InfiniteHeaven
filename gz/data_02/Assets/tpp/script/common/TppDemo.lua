local this = {}





local onOpeningDemoFadeIn = function()
	TppUI.FadeIn( 60 )
end

local onOpeningDemoStartTransition = function()
	TppUI.ShowTransition( "opening" )
end




this.Messages = {
	Demo = {
		{ message = "Play",			localFunc = "_OnDemoPlay" },
		{ message = "Finish",		localFunc = "_OnDemoEnd" },
		{ message = "Interrupt",	localFunc = "_OnDemoInterrupt" },
		{ message = "Skip",			localFunc = "_OnDemoSkip" },
		{ message = "Disable",		localFunc = "_OnDemoDisable" }, 
	},
	
	Timer = {
		{ message = "OnEnd", data = "_openingDemoFadeIn",			commonFunc = onOpeningDemoFadeIn },
		{ message = "OnEnd", data = "_openingDemoStartTransition",	commonFunc = onOpeningDemoStartTransition },
	},
}






this.Play = function( demoID, funcs, flags )
	
	local demoName = this.m_list[demoID]
	if( demoName == nil ) then



		return
	end

	
	this.m_funcs[demoName] = funcs
	this.m_flags[demoName] = flags
	this.m_playedList[demoName] = true

	local checkFlags = this.m_flags[demoName] or {}

	
	local disableGame = checkFlags.disableGame == nil and true or checkFlags.disableGame
	if( disableGame ) then
		TppGameStatus.Set("TppDemo.lua","S_DISABLE_GAME")
	end

	TppDemoUtility.Play(demoName)
end


this.PlayOpening = function( funcs )
	local demoID = "_openingDemo"
	local demoName = "p31_020000_000_final"
	this.m_list[demoID] = demoName

	local onOpeningDemoStart = function()
		TppUI.FadeOut()
		TppTimer.Start( "_openingDemoFadeIn", 3 )
		TppTimer.Start( "_openingDemoStartTransition", 7.5 )
	end
	local onOpeningDemoEnd = nil
	if( funcs ~= nil ) then
		onOpeningDemoEnd = funcs.onEnd
	end

	this.Play( demoID, { onStart = onOpeningDemoStart, onEnd = onOpeningDemoEnd } )
end






this.Register = function( demoList )
	this.m_list = demoList
end


this.Start = function()
	this.m_manager = DemoDaemon
end


this.OnDemoPlay = function( demoName )

	if this.m_playedList[demoName] == nil then
		return
	end

	local flags = this.m_flags[demoName] or {}

	
	local disableDamageFilter = flags.disableDamageFilter == nil and true or flags.disableDamageFilter
	if( disableDamageFilter ) then
		TppGameStatus.Set("TppDemo.lua","S_DISABLE_FILTER_EFFECTS")
	end

	
	local disableTarget = flags.disableTarget == nil and true or flags.disableTarget
	if( disableTarget ) then
		TppGameStatus.Set("TppDemo.lua","S_DISABLE_TARGET")
	end

	
	local disableTrap = flags.disableTrap == nil and true or flags.disableTrap
	if( disableTrap ) then
		TppGameStatus.Set("TppDemo.lua","S_DISABLE_TRAP")
	end

	
	local disableDemoEnemies = flags.disableDemoEnemies == nil and true or flags.disableDemoEnemies
	if( disableDemoEnemies ) then
		TppGameStatus.Set("TppDemo.lua","S_DISABLE_NPC")
	end

	
	local disableNpcNotice = flags.disableNpcNotice == nil and true or flags.disableNpcNotice
	if( disableNpcNotice ) then
		TppGameStatus.Set("TppDemo.lua","S_DISABLE_NPC_NOTICE")
	end

	
	local disableHelicopter = flags.disableHelicopter == nil and true or flags.disableHelicopter
	if( disableHelicopter ) then
		TppGameStatus.Set("TppDemo.lua","S_DISABLE_SUPPORT_HELICOPTER")
	end

	
	local disableHUD = flags.disableHUD == nil and true or flags.disableHUD
	if( disableHUD ) then
		TppGameStatus.Set("TppDemo.lua","S_DISABLE_HUD")
	end

	
	local disableTerminal = flags.disableTerminal == nil and true or flags.disableTerminal
	if( disableTerminal ) then
		TppGameStatus.Set("TppDemo.lua","S_DISABLE_TERMINAL")
	end

	
	local disableThrowing = flags.disableThrowing == nil and true or flags.disableThrowing
	if( disableThrowing ) then
		TppGameStatus.Set("TppDemo.lua","S_DISABLE_THROWING")
	end

	
	local disablePlacement = flags.disablePlacement == nil and true or flags.disablePlacement
	if( disablePlacement ) then
		TppGameStatus.Set("TppDemo.lua","S_DISABLE_PLACEMENT")
	end

	
	local disablePlayerPad = flags.disablePlayerPad == nil and true or flags.disablePlayerPad
	if( disablePlayerPad ) then
		TppGameStatus.Set("TppDemo.lua","S_DISABLE_PLAYER_PAD")
	end

end


this.OnDemoEnd = function( demoName )
	if this.m_playedList[demoName] == nil then
		return
	end

	local flags = this.m_flags[demoName] or {}

	
	local enableGame = flags.disableGame == nil and true or flags.disableGame
	if( enableGame ) then
		TppGameStatus.Reset("TppDemo.lua","S_DISABLE_GAME")
	end

	
	local enableDamageFilter = flags.disableDamageFilter == nil and true or flags.disableDamageFilter
	if( enableDamageFilter ) then
		TppGameStatus.Reset("TppDemo.lua","S_DISABLE_FILTER_EFFECTS")
	end

	
	local enableTarget = flags.disableTarget == nil and true or flags.disableTarget
	if( enableTarget ) then
		TppGameStatus.Reset("TppDemo.lua", "S_DISABLE_TARGET")
	end

	
	local enableTrap = flags.disableTrap == nil and true or flags.disableTrap
	if( enableTrap ) then
		TppGameStatus.Reset("TppDemo.lua", "S_DISABLE_TRAP")
	end

	
	local enableDemoEnemies = flags.disableDemoEnemies == nil and true or flags.disableDemoEnemies
	if( enableDemoEnemies ) then
		TppGameStatus.Reset("TppDemo.lua","S_DISABLE_NPC")
	end

	
	local enableNpcNotice = flags.disableNpcNotice == nil and true or flags.disableNpcNotice
	if( enableNpcNotice ) then
		TppGameStatus.Reset("TppDemo.lua","S_DISABLE_NPC_NOTICE")
	end

	
	local enableHelicopter = flags.disableHelicopter == nil and true or flags.disableHelicopter
	if( enableHelicopter ) then
		TppGameStatus.Reset("TppDemo.lua","S_DISABLE_SUPPORT_HELICOPTER")
	end

	
	local enableHUD = flags.disableHUD == nil and true or flags.disableHUD
	if( enableHUD ) then
		TppGameStatus.Reset("TppDemo.lua","S_DISABLE_HUD")
	end

	
	local enableTerminal = flags.disableTerminal == nil and true or flags.disableTerminal
	if( enableTerminal ) then
		TppGameStatus.Reset("TppDemo.lua","S_DISABLE_TERMINAL")
	end

	
	local enableThrowing = flags.disableTerminal == nil and true or flags.disableTerminal
	if( enableThrowing ) then
		TppGameStatus.Reset("TppDemo.lua","S_DISABLE_THROWING")
	end

	
	local enablePlacement = flags.disablePlacement == nil and true or flags.disablePlacement
	if( enablePlacement ) then
		TppGameStatus.Reset("TppDemo.lua","S_DISABLE_PLACEMENT")
	end

	
	local enablePlayerPad = flags.disablePlayerPad == nil and true or flags.disablePlayerPad
	if( enablePlayerPad ) then
		TppGameStatus.Reset("TppDemo.lua","S_DISABLE_PLAYER_PAD")
	end

end


this.OnDemoInterrupt = function( demoName )
	if this.m_playedList[demoName] == nil then
		return
	end
	this.OnDemoEnd( demoName ) 
end


this.OnDemoSkip = function( demoName )
	if this.m_playedList[demoName] == nil then
		return
	end
end


this.OnDemoDisable = function( demoName )
	if this.m_playedList[demoName] == nil then
		return
	end
	this.OnDemoEnd( demoName ) 
end






this._OnDemoPlay = function( manager, message, demoName )
	this.OnDemoPlay( demoName )
	this._DoMessage( demoName, "onStart" )
end


this._OnDemoEnd = function( manager, message, demoName )
	this.OnDemoEnd( demoName )
	this._DoMessage( demoName, "onEnd" )
	this.m_playedList[demoName] = nil
end


this._OnDemoInterrupt = function( manager, message, demoName )
	this.OnDemoInterrupt( demoName )
	this._DoMessage( demoName, "onInterrupt" )
end


this._OnDemoSkip = function( manager, message, demoName )
	this.OnDemoSkip( demoName )
	this._DoMessage( demoName, "onSkip" )
end


this._OnDemoDisable = function( manager, message, demoName )
	this.OnDemoDisable( demoName )
	this._DoMessage( demoName, "onDisable" )
	this.m_playedList[demoName] = nil
end


this._DoMessage = function( demoName, funcName )
	if( this.m_funcs == nil or this.m_funcs[demoName] == nil or this.m_funcs[demoName][funcName] == nil ) then return end
	this.m_funcs[demoName][funcName]()
end




this.m_manager = nil
this.m_list = nil
this.m_funcs = {}
this.m_flags = {}
this.m_playedList = {}




return this
