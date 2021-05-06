local this = {}






this.GetCurrentSequence = function( esmType )
	TppCommon.DeprecatedFunction( "manager:GetCurrentSequence()" )
	esmType = esmType or "mission"
	return this.GetManager( esmType ):GetCurrentSequence()
end


this.ChangeSequence = function( seqName, esmType )
	TppCommon.DeprecatedFunction( "manager:GoNextSequence( seqName )" )
	esmType = esmType or "mission"
	if( this._IsSequenceValid( seqName, esmType ) == false ) then return end
	this.GetManager( esmType ):GoNextSequence( seqName )
end


this.IsGreaterThan = function( seq1, seq2, esmType )
	TppCommon.DeprecatedFunction( "manager:IsLargerThan( seq1, seq2 )" )
	esmType = esmType or "mission"
	return this.GetManager( esmType ):IsLargerThan( seq1, seq2 )
end


this.IsCurrentSequenceAtoB = function( seq1, seq2, esmType )

	local currentSeq = this.GetCurrentSequence(esmType)

	if ( this.IsGreaterThan( currentSeq, seq1 ) and this.IsGreaterThan( seq2, currentSeq ) ) then
		return true
	else
		return false
	end
end






this.Register = function( script, manager, esmType )
	esmType = esmType or "mission"

	
	for i = 1, #this.esmData do
		if( esmType == this.esmData[i].esmType ) then
			this.esmData[i].manager = manager
			this.esmData[i].script = script
			return
		end
	end

	local temp = {}
	temp.script = script
	temp.manager = manager
	temp.esmType = esmType

	table.insert( this.esmData, temp )
end


this.GetData = function( keyName, esmType )
	esmType = esmType or "mission"

	local data = this.GetManager( esmType ):GetDataBodyFromEntityLink( keyName )
	if( data == nil or data == Entity.Null() ) then



		return nil
	end
	return data
end


this.GetManager = function( esmType )
	if( this._IsTypeValid( esmType ) == false ) then return nil end
	for i = 1, #this.esmData do
		if( esmType == this.esmData[i].esmType ) then
			return this.esmData[i].manager
		end
	end



	return nil
end


this.ChangeMissionState = function( missionManager, state, stateMessage, flags )
	local seqManager = this.GetManager( "mission" )
	local currentState = MissionManager.GetMissionState()
	if stateMessage == nil then
		stateMessage = ""
	end

	local request = false

	
	if( state == "exec" ) then
		seqManager:ExitMissionStatePrepareRestore()
		seqManager:WaitMissionStateToExec()

	
	elseif( state == "clear" ) then
		if( currentState == "ST_PREPARE" ) then
			seqManager:ExitMissionStatePrepareRestore()
		elseif( currentState == "ST_EXEC" ) then
			request = missionManager.RequestMissionClear(stateMessage)
		end
		seqManager:WaitMissionStateToClear()

	
	elseif( state == "failed" ) then
		if( currentState == "ST_PREPARE" ) then
			seqManager:ExitMissionStatePrepareRestore()
		elseif( currentState == "ST_EXEC" ) then
			request = missionManager.RequestMissionFailure(stateMessage)
		end
		seqManager:WaitMissionStateToFailed()

	
	elseif( state == "abort" ) then
		if( currentState == "ST_PREPARE" ) then
			seqManager:ExitMissionStatePrepareRestore()
		elseif( currentState == "ST_EXEC" ) then
			request = missionManager.RequestMissionAbort(stateMessage)
		end
		seqManager:WaitMissionStateToAbort()

	
	elseif( state == "gameOver" ) then
		if( currentState == "ST_PREPARE" ) then
			seqManager:ExitMissionStatePrepareRestore()
		elseif( currentState == "ST_EXEC" ) then
			request = missionManager.RequestMissionFailure(stateMessage)
		elseif( currentState == "ST_FAILED" ) then
			seqManager:ExitMissionStateFailed()
		end
		seqManager:WaitMissionStateToGameOver()

	
	elseif( state == "end" ) then
		if( currentState == "ST_CLEAR" ) then
			seqManager:ExitMissionStateClear()
		elseif( currentState == "ST_FAILED" ) then
			seqManager:ExitMissionStateFailed()
		elseif( currentState == "ST_ABORT" ) then
			seqManager:ExitMissionStateAbort()
		elseif( currentState == "ST_GAMEOVER" ) then
			seqManager:ExitMissionStateGameOver()
		end

	else



	end

	if (request == true) then
		local checkFlags = flags or {}
		
		local disableGame = checkFlags.disableGame == nil and true or checkFlags.disableGame
		if( disableGame ) then
			TppGameStatus.Set("MissionManager","S_DISABLE_TARGET")
			TppGameStatus.Set("MissionManager","S_DISABLE_TRAP")
			TppGameStatus.Set("MissionManager","S_DISABLE_PLAYER_PAD")
			TppGameStatus.Set("MissionManager","S_DISABLE_TERMINAL")
			TppGameStatus.Set("MissionManager","S_DISABLE_HUD")
			TppGameStatus.Set("MissionManager","S_DISABLE_SYSTEM_UI_PAD")
		end
		
		local disableTarget = checkFlags.disableTarget == nil and true or checkFlags.disableTarget
		if( disableTarget ) then
			TppGameStatus.Set("MissionManager","S_DISABLE_TARGET")
		end
		
		local disableTrap = checkFlags.disableTrap == nil and true or checkFlags.disableTrap
		if( disableTrap ) then
			TppGameStatus.Set("MissionManager","S_DISABLE_TRAP")
		end
		
		local disablePlayerPad = checkFlags.disablePlayerPad == nil and true or checkFlags.disablePlayerPad
		if( disablePlayerPad ) then
			TppGameStatus.Set("MissionManager","S_DISABLE_PLAYER_PAD")
		end
		
		local disableTerminal = checkFlags.disableTerminal == nil and true or checkFlags.disableTerminal
		if( disableTerminal ) then
			TppGameStatus.Set("MissionManager","S_DISABLE_TERMINAL")
		end
		
		local disableHUD = checkFlags.disableHUD == nil and true or checkFlags.disableHUD
		if( disableHUD ) then
			TppGameStatus.Set("MissionManager","S_DISABLE_HUD")
		end
		
		local disableSystemUIPad = checkFlags.disableSystemUIPad == nil and true or checkFlags.disableSystemUIPad
		if( disableSystemUIPad ) then
			TppGameStatus.Set("MissionManager","S_DISABLE_SYSTEM_UI_PAD")
		end
	end
end






this._IsTypeValid = function( esmType )
	local esmTypes = {
		"location",
		"mission",
	}
	for i = 1, #esmTypes do
		if( esmType == esmTypes[i] ) then
			return true
		end
	end



	return false
end


this._IsSequenceValid = function( seqName, esmType )
	local script = this._GetScript( esmType )
	if( script == nil ) then return end

	
	local function IsInSequences( name )
		for i = 1, #script.Sequences do
			if( name == script.Sequences[i][1] ) then
				return true
			end
		end
		return false
	end

	
	local function IsExist( name )
		local path = nil
		for i = 1, #script.Sequences do
			if( name == script.Sequences[i][1] ) then
				path = script.Sequences[i][2]
			end
		end

		if( path == nil ) then
			if( script[name] == nil ) then
				return false
			end
			return true
		else
			
			
			return true
		end
	end

	if( IsInSequences( seqName ) == false ) then



		return false
	end

	if( IsExist( seqName ) == false ) then



		return false
	end

	return true
end


this._GetScript = function( esmType )
	if( this._IsTypeValid( esmType ) == false ) then return nil end

	for i = 1, #this.esmData do
		if( esmType == this.esmData[i].esmType ) then
			return this.esmData[i].script
		end
	end



	return nil
end




this.esmData = {}




return this
