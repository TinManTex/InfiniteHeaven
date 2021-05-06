local this = {}




this.Messages = {
	Radio = {
		{ message = "RadioEventMessage", localFunc = "_MessageHandler" },
		{ message = "EspionageRadioPlayButton", localFunc = "_PlayIntelRadio" },
	},
	Timer = {
		{ data = "debugRadioTimer", message = "OnEnd", localFunc = "_PlayDebugContinue" },
	},
}




this.RadioMessageList = {
	None	= 0,
	Start	= 1,
	End		= 2,
	Request	= 3,
}
this.SFXList = {
	RadioStart	= "Play_sfx_s_codec_NPC_begin",
	RadioEnd	= "Play_sfx_s_codec_NPC_end",
}






this.Play = function( radioTag, funcs, radioType, preDelayTimeAtSec, noiseType )
	local radioType = radioType or "realtime"
	local noiseType = noiseType or "both"

	local radioIDs, numPlay = this._GetRadioIDsAndNumPlay( radioTag, radioType )
	local radioName = this._GetRadioName( radioIDs )

	if( radioName == nil ) then return end
	if( this._DoPlayRadio( radioName, radioIDs, numPlay, radioType ) == false ) then return end

	local radioDaemon = RadioDaemon:GetInstance()
	if ( radioDaemon:IsPlayingRadio() == false ) then

		
		
		
		this.ResetRealTimeRadioSubPriority()
		
		this.ResetEpisonageRadioSubPriority()
		
		this.ResetOptionalRadioSubPriority()
	end

	
	this.m_funcs[radioName] = funcs
	
	this.m_manager:PlayDirectGroupTable{ tableName = radioName, groupName = radioIDs, preDelayTime = preDelayTimeAtSec, noiseType = noiseType }

end









this.PlayStrong = function( radioTag, funcs, radioType, preDelayTimeAtSec, noiseType )
	local radioType = radioType or "realtime"
	local noiseType = noiseType or "both"

	local radioIDs, numPlay = this._GetRadioIDsAndNumPlay( radioTag, radioType )
	local radioName = this._GetRadioName( radioIDs )

	if( radioName == nil ) then return end
	if( this._DoPlayRadio( radioName, radioIDs, numPlay, radioType ) == false ) then return end
	
	if( radioType == "realtime" ) then
		
		SubtitlesCommand:SetSubPriority( "Degault", 6, 5, 10 )
	elseif( radioType == "intel" ) then
		
		SubtitlesCommand:SetSubPriority( "Degault", 9, 5, 10 )
	else
		
		SubtitlesCommand:SetSubPriority( "Degault", 25, 5, 10 )
	end

	
	this.m_funcs[radioName] = funcs
	
	this.m_manager:PlayDirectGroupTable{ tableName = radioName, groupName = radioIDs, preDelayTime = preDelayTimeAtSec, noiseType = noiseType }
end


this.PlayEnqueue = function( radioTag, funcs, radioType, preDelayTimeAtSec, noiseType )
	local radioType = radioType or "realtime"
	local noiseType = noiseType or "both"

	local radioIDs, numPlay = this._GetRadioIDsAndNumPlay( radioTag, radioType )
	local radioName = this._GetRadioName( radioIDs )

	if( radioName == nil ) then return end
	if( this._DoPlayRadio( radioName, radioIDs, numPlay, radioType ) == false ) then return end
	
	
	this.m_funcs[radioName] = funcs

	
	this.m_manager:PlayDirectGroupTableEnqueue{ tableName = radioName, groupName = radioIDs, preDelayTime = preDelayTimeAtSec, noiseType = noiseType }
end


this.DelayPlay = function( radioTag, delayTime, noiseType, funcs, radioType )
	local radioType = radioType or "realtime"
	local noiseType = noiseType or "both"

	local radioIDs, numPlay = this._GetRadioIDsAndNumPlay( radioTag, radioType )
	local radioName = this._GetRadioName( radioIDs )

	if( radioName == nil ) then return end
	if( this._DoPlayRadio( radioName, radioIDs, numPlay, radioType ) == false ) then return end

	local radioDaemon = RadioDaemon:GetInstance()
	if ( radioDaemon:IsPlayingRadio() == false ) then
		
		
		
		this.ResetRealTimeRadioSubPriority()
		
		this.ResetEpisonageRadioSubPriority()
		
		this.ResetOptionalRadioSubPriority()
	end
	
	
	this.m_funcs[radioName] = funcs

	
	local preDelayTimeAtSec
	if( type( delayTime ) == "string" ) then
		
		local times = {
			short	= { 0.4, 0.8 },
			mid		= { 1.3, 1.9 },
			long	= { 2.6, 3.2 },
		}
		if( times[delayTime] == nil ) then



		end
		local minTime = times[delayTime][1] * 10
		local maxTime = times[delayTime][2] * 10
		preDelayTimeAtSec = ( math.random( minTime, maxTime ) / 10 )
	elseif( type( delayTime ) == "number" ) then
		preDelayTimeAtSec = delayTime
	end

	
	this.m_manager:PlayDirectGroupTable{ tableName = radioName, groupName = radioIDs, preDelayTime = preDelayTimeAtSec, noiseType = noiseType }
end


this.DelayPlayEnqueue = function( radioTag, delayTime, noiseType, funcs, radioType )
	local radioType = radioType or "realtime"
	local noiseType = noiseType or "both"

	local radioIDs, numPlay = this._GetRadioIDsAndNumPlay( radioTag, radioType )
	local radioName = this._GetRadioName( radioIDs )

	if( radioName == nil ) then return end
	if( this._DoPlayRadio( radioName, radioIDs, numPlay, radioType ) == false ) then return end
	
	
	this.m_funcs[radioName] = funcs

	
	local preDelayTimeAtSec
	if( type( delayTime ) == "string" ) then
		
		local times = {
			short	= { 0.4, 0.8 },
			mid		= { 1.3, 1.9 },
			long	= { 2.6, 3.2 },
		}
		if( times[delayTime] == nil ) then



		end
		local minTime = times[delayTime][1] * 10
		local maxTime = times[delayTime][2] * 10
		preDelayTimeAtSec = ( math.random( minTime, maxTime ) / 10 )
	elseif( type( delayTime ) == "number" ) then
		preDelayTimeAtSec = delayTime
	end

	
	this.m_manager:PlayDirectGroupTableEnqueue{ tableName = radioName, groupName = radioIDs, preDelayTime = preDelayTimeAtSec, noiseType = noiseType }
end


this.PlayDebug = function( radioTag, funcs )
	if( radioTag == nil or this.m_radioList[radioTag] == nil ) then



		return
	end

	this.m_debugRadioID = radioTag
	this.m_funcs[this.m_debugRadioID] = funcs
	this._PlayDebugStart()
end


this.ResetRealTimeRadioSubPriority = function( optionalRadioID, radioData, index )
	SubtitlesCommand:ResetSubPriority( 6 )
end

this.ResetEpisonageRadioSubPriority = function( optionalRadioID, radioData, index )
	SubtitlesCommand:ResetSubPriority( 9 )
end

this.ResetOptionalRadioSubPriority = function( optionalRadioID, radioData, index )
	SubtitlesCommand:ResetSubPriority( 25 )
end


this.RegisterOptionalRadio = function( optionalRadioID )
	
	local optionalRadioName = this.m_optionalRadioList[optionalRadioID]
	if( optionalRadioName == nil ) then



		return
	end

	this.m_manager:RegisterRadioGroupSetOverwrite( optionalRadioName )
end


this.InsertOptionalRadio = function( optionalRadioID, radioData, index )
	local optionalRadioName = this.m_optionalRadioList[optionalRadioID]
	if( optionalRadioName == nil ) then



		return
	end

	if( index == nil ) then
		this.m_manager:RegisterRadioGroupToRadioGroupSetPushback( radioData, optionalRadioName )
	else
		this.m_manager:RegisterRadioGroupToRadioGroupSetInsert( radioData, optionalRadioName, index )
	end
end


this.DeleteOptionalRadio = function( optionalRadioID, radioData )
	local optionalRadioName = this.m_optionalRadioList[optionalRadioID]
	if( optionalRadioName == nil ) then



		return
	end

	this.m_manager:UnregisterRadioGroupFromRadioGroupSet( radioData, optionalRadioName )
end


this.RegisterIntelRadio = function( intelRadioID, radioData, isSave )
	this.m_intelRadioList[intelRadioID] = radioData
	if( isSave == true ) then
		GzRadioSaveData.SetSaveEspionageId( intelRadioID, radioData )
	end
end


this.RestoreIntelRadio = function()
	if( this.m_intelRadioList == nil ) then
		return
	end

	for key, id in pairs(this.m_intelRadioList) do
		local radioID = GzRadioSaveData.GetEspionageRadioId( key )
		if( radioID ~= 0 ) then
			this.m_intelRadioList[key] = radioID
		end
	end
end


this.EnableIntelRadio = function( locatorID )
	if( this._IsRadioLocatorIDValid( locatorID ) == false ) then return end
	TppPlayerUtility.SetPlayerSightSearchInfoRadioEnable( locatorID, true )
end


this.DisableIntelRadio = function( locatorID )
	if( this._IsRadioLocatorIDValid( locatorID ) == false ) then return end
	TppPlayerUtility.SetPlayerSightSearchInfoRadioEnable( locatorID, false )
end


this.EnableIntelRadioCharacterType = function( characterType )
	TppPlayerUtility.SetPlayerSightSearchInfoRadioEnable{ type = characterType, enable = true }
end


this.DisableIntelRadioCharacterType = function( characterType )
	TppPlayerUtility.SetPlayerSightSearchInfoRadioEnable{ type = characterType, enable = false }
end

this.SetAllSaveRadioId = function()
	if( this.m_radioList == nil ) then



		return
	end

	for key, id in pairs(this.m_radioList) do
		if( type(id) == "table" ) then
			GzRadioSaveData.SetSaveRadioId( id[1] )
		end
	end
end



this.IdRadioPlayable = function()
	
	local isPlayable = true

	
	if ( SubtitlesCommand.IsPlayingSubtitles() ) then
		isPlayable = false
	end

	return isPlayable
end






this.Register = function( radioList, optionalRadioList, intelRadioList )
	this.m_radioList = radioList
	this.m_optionalRadioList = optionalRadioList
	this.m_intelRadioList = intelRadioList
end


this.Start = function()
	this.m_manager = RadioDaemon:GetInstance()
end


this.OnRadioPlay = function()
end


this.OnRadioEnd = function()
end


this.OnRadioRequest = function()
end






this._GetDataFromName = function( radioName, radioType )
	local radioID
	if( radioType == "realtime" ) then
		radioID = this.m_radioList[radioName]
	elseif( radioType == "intel" ) then
		radioID = this.m_intelRadioList[radioName]
	end

	if( radioID == nil ) then



		return nil
	end

	local numPlay = nil
	if( type( radioID ) == "table" ) then
		numPlay = radioID[2]
		radioID = radioID[1]
	end
	return { radioID }, numPlay
end


this._GetDataFromTable = function( radioGroup, radioType )
	local radioIDs = {}
	local numPlay = nil

	if( type( radioGroup[1] ) == "string" ) then
		for i = 1, #radioGroup do
			local radioID = this._GetDataFromName( radioGroup[i], radioType )
			if( radioID == nil ) then return end
			table.insert( radioIDs, radioID[1] )
		end
	elseif( type( radioGroup[1] ) == "table" ) then
		for i = 1, #radioGroup[1] do
			local radioID = this._GetDataFromName( radioGroup[1][i], radioType )
			if( radioID == nil ) then return end
			table.insert( radioIDs, radioID[1] )
		end
		numPlay = radioGroup[2]
	end
	return radioIDs, numPlay
end


this._GetRadioIDsAndNumPlay = function( radioTag, radioType )
	if( type( radioTag ) == "string" ) then
		return this._GetDataFromName( radioTag, radioType )
	elseif( type( radioTag ) == "table" ) then
		return this._GetDataFromTable( radioTag, radioType )
	else



		return nil
	end
end


this._GetRadioName = function( radioIDs )
	if( radioIDs == nil ) then return nil end
	return radioIDs[1]
end


this._DoPlayRadio = function( radioName, radioIDs, numPlay, radioType )
	if( numPlay == nil ) then return true end

	
	if( this.m_numPlay[radioName] == nil ) then
		this.m_numPlay[radioName] = 0
	end
	
	if( this.m_manager:IsRadioGroupMarkAsRead( radioIDs[1] ) == true ) then
		
		return false
	end

	





	return true
end


this._MessageHandler = function( manager, data, radioName, message )
	if( message == this.RadioMessageList.Start ) then
		this._OnRadioPlay( radioName )
	elseif( message == this.RadioMessageList.End ) then
		this._OnRadioEnd( radioName )
	elseif( message == this.RadioMessageList.Request ) then
		this._OnRadioRequest( radioName )
	end
end


this._OnRadioPlay = function( radioName )
	this.OnRadioPlay()
	this._DoMessage( radioName, "onStart" )
end


this._OnRadioEnd = function( radioName )
	this.OnRadioEnd()
	this._DoMessage( radioName, "onEnd" )
end


this._OnRadioRequest = function( radioName )
	this.OnRadioRequest()
	this._DoMessage( radioName, "onRequest" )
end


this._DoMessage = function( radioName, funcName )
	if( this.m_funcs == nil or this.m_funcs[radioName] == nil or this.m_funcs[radioName][funcName] == nil ) then return end
	this.m_funcs[radioName][funcName]()
end


this._PlayDebugStart = function()
	if( TppTimer.IsTimerActive( "debugRadioTimer" ) == true ) then return end

	
	this.m_debugRadioFlag = 1
	if( DEBUG ) then
		SoundCommand.PostEvent( this.SFXList.RadioStart )
	end
	this._OnRadioPlay( this.m_debugRadioID )
	this._PlayDebugContinue()
end


this._PlayDebugContinue = function()
	
	if( this.m_debugRadioFlag <= #this.m_radioList[this.m_debugRadioID] ) then
		local line = this.m_radioList[this.m_debugRadioID][this.m_debugRadioFlag]
		
		









		local displayTime = math.ceil( string.len( line ) / 3 ) * 0.2
		displayTime = math.max( displayTime, 0.8 )
		this._PlayDebugLine( line, displayTime )

		
		local spacerTime = 0.2
		TppTimer.Start( "debugRadioTimer", displayTime + spacerTime )

		this.m_debugRadioFlag = this.m_debugRadioFlag + 1

	
	else
		if( DEBUG ) then
			SoundCommand.PostEvent( this.SFXList.RadioEnd )
		end
		this._OnRadioEnd( this.m_debugRadioID )
	end
end


this._PlayDebugLine = function( text, time )
	
	SubtitlesCommand.DisplayText( text, "Default", time * 1000 )
end


this._IsRadioLocatorIDValid = function( radioLocatorID )
	for _radioLocatorID, data in pairs( this.m_intelRadioList ) do
		if( radioLocatorID == _radioLocatorID ) then
			return true
		end
	end
	return false
end


this._PlayIntelRadio = function()
	local radioType = "intel"
	local radioLocatorID = TppData.GetArgument( 1 )
	if( this._IsRadioLocatorIDValid( radioLocatorID ) == false ) then return end
	
	
	local radioData = this.m_intelRadioList[radioLocatorID]
	local radioName = nil
	local numPlay = nil

	if( type( radioData ) == "string" ) then
		radioName = radioData
	elseif( type( radioData ) == "number" ) then
		radioName = radioData
	elseif( type( radioData ) == "table" ) then
		radioName = radioData[1]
		numPlay = radioData[2]
	end

	
	if( this.m_numPlay[radioName] == nil ) then
		this.m_numPlay[radioName] = 0
	end

	
	local onIntelRadioStart = function()
		print( "start intel radio." )
		
	end
	local onIntelRadioEnd = nil
	if( numPlay == nil or ( numPlay - 1 ) > this.m_numPlay[radioName] ) then
		onIntelRadioEnd = function()
			print( "end intel radio." )
			
		end
	end

	
	TppRadio.Play( radioLocatorID, { onStart = onIntelRadioStart, onEnd = onIntelRadioEnd }, radioType )
end




this.m_manager = nil
this.m_radiolist = nil
this.m_optionalRadioList = nil
this.m_intelRadioList = nil
this.m_funcs = {}
this.m_numPlay = {}

this.m_debugRadioID = nil
this.m_debugRadioFlag = 1




return this
