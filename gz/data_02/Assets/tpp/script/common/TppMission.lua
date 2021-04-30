local this = {}




this.Messages = {
	Mission = {
		{ message = "CrossOfInnerArea", localFunc = "_execInnerCrossing" },
		{ message = "CrossOfOuterArea", localFunc = "_execOuterCrossing" },
	},
	Timer = {
		{ data = "_whileInsideBaseTimer", message = "OnEnd", localFunc = "OnEnterClearAreaTrap" },
		{ data = "_whileOutsideBaseTimer", message = "OnEnd", localFunc = "_onEndEndingSequence" },
	},
}






this.Setup = function()
	
	TppEnemy.Setup()
	TppMarker.Setup()
	TppTerminal.Setup()
	TppTimer.Setup()

	
	this.m_endingSequenceParams = nil

	
	this.m_doOnInnerCrossing = nil
	this.m_doOnOuterCrossing = nil
end


this.GetMissionID = function()
	return this.m_missionID
end


this.GetMissionName = function()
	return this.m_missionName
end


this.ChangeState = function( state, stateMessage, flags )
	TppSequence.ChangeMissionState( this.m_manager, state, stateMessage, flags )
end


this.SetFlag = function( flagID, value )
	TppCommon.DeprecatedFunction( "MissionManager.SetFlag( flagID, value )" )
	this.m_manager.SetFlag( flagID, value )
end


this.GetFlag = function( flagID )
	TppCommon.DeprecatedFunction( "MissionManager.GetFlag( flagID )" )
	return this.m_manager.GetFlag( flagID )
end


this.RegisterVipRestorePoint = function( characterId, keyName )
	
	MissionManager.RegisterVipRestorePoint( characterId, "id_vipRestorePoint", keyName )
end


this.UnregisterVipRestorePoint = function( characterId )
	
	MissionManager.UnregisterVipRestorePoint( characterId )
end


this.EnableAcceptMission = function()
	TppCommon.DeprecatedFunction( "MissionManager.SetEnableAcceptOnNormalMission()" )
	this.m_manager.SetEnableAcceptOnNormalMission()
end


this.LoadDemoBlock = function( path )
	TppCommon.DeprecatedFunction( "MissionManager.RequestLoadBlockAndWaitState()" )
	this.m_manager.RequestLoadDemoBlockLua( path )
end


this.IsDemoBlockActive = function()
	TppCommon.DeprecatedFunction( "MissionManager.IsDemoBlockActive()" )
	return this.m_manager.IsDemoBlockActiveLua()
end


this.LoadEventBlock = function( path )
	TppCommon.DeprecatedFunction( "MissionManager.RequestLoadBlockAndWaitState()" )
	this.m_manager.RequestLoadEventBlockLua( path )
end


this.IsEventBlockActive = function()
	TppCommon.DeprecatedFunction( "MissionManager.IsEventBlockActive()" )
	return this.m_manager.IsEventBlockActiveLua()
end


this.SetInGame = function( inGame )
	
	
end


this.OnLeaveInnerArea = function( doFunc )
	if( type( doFunc ) ~= "function" ) then



		return
	end
	this.m_doOnInnerCrossing = doFunc
end


this.OnLeaveOuterArea = function( doFunc )
	if( type( doFunc ) ~= "function" ) then



		return
	end
	this.m_doOnOuterCrossing = doFunc
end


this.StartEndingSequence = function( params )
	this.m_endingSequenceParams = params or {}

	if( TppLocation.GetFlag( "_isPlayerInClearAreaTrap" ) == true ) then
		if( this.m_endingSequenceParams.onInsideBase ~= nil ) then
			this.m_endingSequenceParams.onInsideBase()
		end
		local insideTime = this.m_endingSequenceParams.insideTime or 1
		GkEventTimerManager.Start( "_whileInsideBaseTimer", insideTime )
	else
		local phase = TppEnemy.GetPhase()
		if( phase == "neutral" or phase == "sneak" ) then
			if( this.m_endingSequenceParams.onOutsideBase_Sneak ~= nil ) then
				this.m_endingSequenceParams.onOutsideBase_Sneak()
			end
		else
			if( this.m_endingSequenceParams.onOutsideBase_Alert ~= nil ) then
				this.m_endingSequenceParams.onOutsideBase_Alert()
			end
		end
		local outsideTime = this.m_endingSequenceParams.outsideTime or 1
		GkEventTimerManager.Start( "_whileOutsideBaseTimer", outsideTime )
	end
end






this.Register = function( missionID, missionFlagList )
	this.m_missionID = missionID
	this.m_missionName = this._CreateMissionName( missionID )
	this.m_flagList = missionFlagList
end


this.Start = function()
	this.m_manager = MissionManager

	
	local seqManager = TppSequence.GetManager( "mission" )
	this.m_manager.RegisterFlags( this.m_flagList, seqManager )
end


this.GetCurrentState = function()
	TppCommon.DeprecatedFunction( "MissionManager.GetMissionState()" )
	return this.m_manager.GetMissionState()
end


this.OnEnterClearAreaTrap = function()
	GkEventTimerManager.Stop( "_whileOutsideBaseTimer" )
	if( this.m_endingSequenceParams == nil ) then return end

	if( this.m_endingSequenceParams.onEnterBase ~= nil ) then
		this.m_endingSequenceParams.onEnterBase()

		local insideTime = this.m_endingSequenceParams.insideTime or 1
		GkEventTimerManager.Start( "_whileInsideBaseTimer", insideTime )
	end
end


this.OnExitClearAreaTrap = function()
	GkEventTimerManager.Stop( "_whileInsideBaseTimer" )
	if( this.m_endingSequenceParams == nil ) then return end

	local phase = TppEnemy.GetPhase()
	if( phase == "neutral" or phase == "sneak" ) then
		if( this.m_endingSequenceParams.onExitBase_Sneak ~= nil ) then
			this.m_endingSequenceParams.onExitBase_Sneak()
		end
	else
		if( this.m_endingSequenceParams.onExitBase_Alert ~= nil ) then
			this.m_endingSequenceParams.onExitBase_Alert()
		end
	end

	local outsideTime = this.m_endingSequenceParams.outsideTime or 1
	GkEventTimerManager.Start( "_whileOutsideBaseTimer", outsideTime )
end






this._CreateMissionName = function( missionID )
	local missionTypeNum = string.sub( tostring( missionID ), 1, 1 )
	local missionType

	if( missionTypeNum == "1" ) then
		missionType = "s"
	elseif( missionTypeNum == "2" ) then
		missionType = "e"
	elseif( missionTypeNum == "3" ) then
		missionType = "f"
	elseif( missionTypeNum == "4" ) then
		missionType = "h"
	else



		return nil
	end

	return missionType .. missionID
end


this._execInnerCrossing = function()
	if( this.m_doOnInnerCrossing ~= nil ) then
		this.m_doOnInnerCrossing()
	end
end


this._execOuterCrossing = function()
	if( this.m_doOnOuterCrossing ~= nil ) then
		this.m_doOnOuterCrossing()
	end
end


this._onEndEndingSequence = function()
	if( this.m_endingSequenceParams == nil ) then return end

	if( this.m_endingSequenceParams.onEnd ~= nil ) then
		this.m_endingSequenceParams.onEnd()
	end
end




this.m_manager = nil
this.m_missionID = nil
this.m_missionName = nil
this.m_flagList = nil
this.m_doOnInnerCrossing = nil
this.m_doOnOuterCrossing = nil
this.m_endingSequenceParams = nil




return this
