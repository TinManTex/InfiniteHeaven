











































ProDemo = {






events = {
	DEMO_DAEMON = { 
		SetDefaultValue = "OnSetDefaultValue", 
		Play = "OnPlay", 
		StopToPlay = "OnStopToPlay", 
		BreakToPlay = "OnBreakToPlay", 
		Stop = "OnStop", 
		FinalStop = "OnFinalStop", 
		Break = "OnBreak", 
		FinalBreak = "OnFinalBreak", 
		DebugDumpAll = "OnDebugDumpAll" },

	SEQUENCE_GAMESCRIPT1  = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT2  = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT3  = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT4  = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT5  = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT6  = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT7  = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT8  = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT9  = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT10 = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT11 = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT12 = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT13 = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT14 = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT15 = { PlayEnd = "OnSequencePlayEnd" },
	SEQUENCE_GAMESCRIPT16 = { PlayEnd = "OnSequencePlayEnd" },

	BREAK_CHECKER_GAMESCRIPT1 = { Break = "OnBreak", Continue = "OnContinue" },
	BREAK_CHECKER_GAMESCRIPT2 = { Break = "OnBreak", Continue = "OnContinue" },
	BREAK_CHECKER_GAMESCRIPT3 = { Break = "OnBreak", Continue = "OnContinue" },
	BREAK_CHECKER_GAMESCRIPT4 = { Break = "OnBreak", Continue = "OnContinue" },

	STOP_CHECKER_GAMESCRIPT1  = { Stop = "OnStop" },
	STOP_CHECKER_GAMESCRIPT2  = { Stop = "OnStop" },
	STOP_CHECKER_GAMESCRIPT3  = { Stop = "OnStop" },
	STOP_CHECKER_GAMESCRIPT4  = { Stop = "OnStop" },
	STOP_CHECKER_GAMESCRIPT5  = { Stop = "OnStop" },
	STOP_CHECKER_GAMESCRIPT6  = { Stop = "OnStop" },
	STOP_CHECKER_GAMESCRIPT7  = { Stop = "OnStop" },
	STOP_CHECKER_GAMESCRIPT8  = { Stop = "OnStop" },
},



Init = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemo.Init()" )

	local storage = body.storage

	
	

	
	storage:AddProperty( "int32", "MAX_CHARACTER_COUNT" )
	storage.MAX_CHARACTER_COUNT = 16

	
	storage:AddProperty( "int32", "MAX_SEQUENCE_COUNT" )
	storage.MAX_SEQUENCE_COUNT = 16

	
	storage:AddProperty( "int32", "MAX_BREAK_CHECKER_COUNT" )
	storage.MAX_BREAK_CHECKER_COUNT = 4

	
	storage:AddProperty( "int32", "MAX_STOP_CHECKER_COUNT" )
	storage.MAX_STOP_CHECKER_COUNT = 8

	
	

	
	storage:AddProperty( "String", "status" )

	
	ProDemo.SetDefaultValue( data, body )

end,



SetMessageBoxes = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemo.SetMessageBoxes()" )

	
	local fromMessageBox = ProDemo.GetDemoDaemonMessageBox()
	body:AddMessageBox( "DEMO_DAEMON", fromMessageBox )

end,







OnSetDefaultValue = function( data, body, sender, id, arg1, arg2, arg3 )

	Fox.Log( "[" .. data.name .. "] ProDemo.OnSetDefaultValue()" )

	ProDemo.SetDefaultValue( data, body )

end,



OnPlay = function( data, body, sender, id, arg1, arg2, arg3 )

	Fox.Log( "[" .. data.name .. "] ProDemo.OnPlay()" )
	ProDemo.DebugDump( data, body )

	local storage = body.storage

	
	if storage.status ~= "Stop" and storage.status ~= "Break" then
		Fox.Warning( "[" .. data.name .. "] Now playing. data[" .. data.name .. "] status[" .. storage.status .. "]" )
		return
	end

	
	ProDemo.Play( data, body )

end,



OnStop = function( data, body, sender, id, arg1, arg2, arg3 )

	Fox.Log( "[" .. data.name .. "] ProDemo.OnStop()" )

	local storage = body.storage

	
	if storage.status ~= "Play" and storage.status ~= "Break" then
		Fox.Warning( "[" .. data.name .. "] It stops now. data[" .. data.name .. "] status[" .. storage.status .. "]" )
		return
	end

	
	ProDemo.SetCheckerEnable( data, body, false )

	
	ProDemo.RequestCharacterDemoStop( data, body )

	
	local fromMessageBox = body.messageBoxes.DEMO_DAEMON
	local toMessageBox = body.messageBox
	fromMessageBox:SendMessageTo( toMessageBox, "FinalStop" )

end,



OnFinalStop = function( data, body, sender, id, arg1, arg2, arg3 )

	Fox.Log( "[" .. data.name .. "] ProDemo.OnFinalStop()" )

	local storage = body.storage

	
	ProDemo.StopAllDemoData( data, body )

	
	storage.status = "Stop"

	
	body.messageBox:SendMessageToSubscribers( "Stop" )

end,



OnBreak = function( data, body, sender, id, arg1, arg2, arg3 )

	Fox.Log( "[" .. data.name .. "] ProDemo.OnBreak()" )

	local storage = body.storage

	
	if storage.status ~= "Play" then
		Fox.Warning( "[" .. data.name .. "] Break failed. not play now. data[" .. data.name .. "] status[" .. storage.status .. "]" )
		return
	end

	
	ProDemo.RequestCharacterDemoStop( data, body )

	
	local fromMessageBox = body.messageBoxes.DEMO_DAEMON
	local toMessageBox = body.messageBox
	fromMessageBox:SendMessageTo( toMessageBox, "FinalBreak" )

end,



OnFinalBreak = function( data, body, sender, id, arg1, arg2, arg3 )

	Fox.Log( "[" .. data.name .. "] ProDemo.OnFinalBreak()" )

	local storage = body.storage

	
	ProDemo.StopAllDemoData( data, body )

	
	storage.status = "Break"

	
	body.messageBox:SendMessageToSubscribers( "Break" )

end,



OnContinue = function( data, body, sender, id, arg1, arg2, arg3 )

	Fox.Log( "[" .. data.name .. "] ProDemo.OnContinue()" )

	local storage = body.storage

	
	if storage.status ~= "Break" then
		Fox.Log( "Continue Failed. not break now. status[" .. storage.status .. "]" )
		return
	end
	Fox.Log( "Continue Success. status[" .. storage.status .. "]" )

	
	ProDemo.Play( data, body )

end,



OnSequencePlayEnd = function( data, body, sender, id, arg1, arg2, arg3 )

	Fox.Log( "[" .. data.name .. "] ProDemo.OnSequencePlayEnd()" )

	local storage = body.storage

	
	local nextSequenceGameScriptData = ProDemo.GetNextSequence( data, body )

	
	if nextSequenceGameScriptData == NULL then

		
		ProDemo.SetCheckerEnable( data, body, false )

		
	

		
	
	
	

		
		storage.status = "Stop"

		
		body.messageBox:SendMessageToSubscribers( "PlayEnd" )

		return
	end

	
	ProDemo.PlaySequence( data, body, nextSequenceGameScriptData )

end,



OnStopToPlay = function( data, body, sender, id, arg1, arg2, arg3 )

	Fox.Log( "[" .. data.name .. "] ProDemo.OnStopToPlay()" )

	local storage = body.storage

	
	local nextSequenceGameScriptData = data.variables.SEQUENCE_GAMESCRIPT1
	if ProDemo.GetGameScriptBody( data, body, nextSequenceGameScriptData ) == NULL then
		Fox.Warning( "[" .. data.name .. "] variables.SEQUENCE_GAMESCRIPT1 is error." )
		return
	end

	
	ProDemo.PlaySequence( data, body, nextSequenceGameScriptData )

	
	storage.status = "Play"

end,



OnBreakToPlay = function( data, body, sender, id, arg1, arg2, arg3 )

	Fox.Log( "[" .. data.name .. "] ProDemo.OnBreakToPlay()" )

	local storage = body.storage

	
	local nextSequenceGameScriptData = ProDemo.GetNextSequence( data, body )
	if nextSequenceGameScriptData == NULL then
		Fox.Warning( "[" .. data.name .. "] not next sequence." )
		return
	end

	
	ProDemo.PlaySequence( data, body, nextSequenceGameScriptData )

	
	storage.status = "Play"

end,







SetDefaultValue = function( data, body )

	local storage = body.storage

	
	storage.status = "Stop"

	
	ProDemo.SetCheckerEnable( data, body, false )

end,



Play = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemo.Play()" )

	local storage = body.storage

	
	ProDemo.RequestSetDefaultValueSyncGameScript( data, body )

	
	if storage.status == "Stop" then
		
		ProDemo.SetCheckerEnable( data, body, true )

		
		ProDemo.RequestSetDefaultValueSequence( data, body )
		
		ProDemo.RequestSetDefaultValueChecker( data, body )

		
		local fromMessageBox = body.messageBoxes.DEMO_DAEMON
		local toMessageBox = body.messageBox
		fromMessageBox:SendMessageTo( toMessageBox, "StopToPlay" )

		return
	end

	

	
	local fromMessageBox = body.messageBoxes.DEMO_DAEMON
	local toMessageBox = body.messageBox
	fromMessageBox:SendMessageTo( toMessageBox, "BreakToPlay" )

end,



PlayDemoData = function( data, body, demoData )

	Fox.Log( "[" .. data.name .. "] ProDemo.PlayDemoData()" )

	
	local demoBody = ProDemo.GetDemoBody( data, body, demoData )
	if demoBody == NULL then
		Fox.Warning( "[" .. data.name .. "] demoData[" .. tostring(demoData) .. "] is error." )
		return
	end

	Fox.Log( " start demoData[" .. demoData.name .. "]" )
	demoBody:Start()

end,



PlaySequence = function( data, body, sequenceGameScriptData )

	Fox.Log( "[" .. data.name .. "] ProDemo.PlaySequence()" )

	local sequenceGameScriptBody = ProDemo.GetGameScriptBody( data, body, sequenceGameScriptData )
	if sequenceGameScriptBody == NULL then
		Fox.Warning( "[" .. data.name .. "] body not found. [" .. tostring(sequenceGameScriptData) .. "]" )
		return false
	end

	
	for i = 1, sequenceGameScriptBody.storage.MAX_FIRST_DEMO_COUNT do

		
		local keyName = "FIRST_DEMO" .. i
		local demoData = sequenceGameScriptData.variables[ keyName ]
		if demoData == NULL then
			break	
		end

		
		ProDemo.PlayDemoData( data, body, demoData )

	end

end,




GetNextSequence = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemo.GetNextSequence()" )

	local storage = body.storage

	
	for i = 1, storage.MAX_SEQUENCE_COUNT do

		
		local keyName = "SEQUENCE_GAMESCRIPT" .. i
		local sequenceGameScriptData = data.variables[ keyName ]
		if sequenceGameScriptData == NULL then
			break	
		end

		
		if ProDemo.IsPlayableSequence( data, body, sequenceGameScriptData ) then
			return sequenceGameScriptData
		end

	end

	
	return NULL
end,




IsPlayableSequence = function( data, body, sequenceGameScriptData )

	local sequenceGameScriptBody = ProDemo.GetGameScriptBody( data, body, sequenceGameScriptData )
	if sequenceGameScriptBody == NULL then
		Fox.Warning( "[" .. data.name .. "] body not found. [" .. tostring(sequenceGameScriptData) .. "]" )
		return false
	end

	
	local isPlayEnd = sequenceGameScriptBody.storage.isPlayEnd
	if isPlayEnd then
		return false
	end

	return true

end,



RequestCharacterDemoStop = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemo.RequestCharacterDemoStop()" )

	local storage = body.storage

	
	for i = 1, storage.MAX_CHARACTER_COUNT do

		
		local keyName = "CHARACTER" .. i
		local characterLocatorData = data.variables[ keyName ]
		if characterLocatorData == NULL then
			break	
		end

		
		local message = ChStopProceduralDemoRequest()
		ProDemo.SendMessageToCharacter( data, body, characterLocatorData, message )

	end

end,



GetCharacterLocatorBodyByData = function( data, body, characterLocatorData, message )

	local characterLocatorBody = characterLocatorData:GetDataBodyWithReferrer( body )
	if characterLocatorBody == NULL or not characterLocatorBody:IsKindOf( ChCharacterLocator ) then
		Fox.Warning( "[" .. data.name .. "] ChCharacterLocator not found. data[" .. tostring(characterLocatorData) .. "]" )
		return NULL
	end

	return characterLocatorBody
end,



SendMessageToCharacter = function( data, body, characterLocatorData, message )

	if message == NULL then
		Fox.Warning( "[" .. data.name .. "] message is NULL." )
		return
	end

	local characterLocatorBody = ProDemo.GetCharacterLocatorBodyByData( data, body, characterLocatorData )
	if characterLocatorBody == NULL then
		return
	end

	local charaObj = characterLocatorBody:GetCharacterObject()
	if charaObj == NULL then
		Fox.Warning( "[" .. data.name .. "] ChCharacterObject not found. data[" .. tostring(characterLocatorData) .. "]" )
		return
	end

	local chara = charaObj:GetCharacter()
	if chara == NULL then
		Fox.Warning( "[" .. data.name .. "] ChCharacter not found. data[" .. tostring(characterLocatorData) .. "]" )
		return
	end

	
	chara:SendMessage( message )

end,




GetGameScriptBody = function( data, body, gameScriptData )

	if gameScriptData == NULL then
		Fox.Warning( "[" .. data.name .. "] ProDemo.GetGameScriptBody() : data is NULL." )
		return NULL
	end

	local gameScriptBody = gameScriptData:GetDataBodyWithReferrer( body )
	if gameScriptBody == NULL then
		Fox.Warning( "[" .. data.name .. "] ProDemo.GetGameScriptBody() : Body not found." )
		return NULL
	end
	if not gameScriptBody:IsKindOf( GameScriptBody ) then
		Fox.Warning( "[" .. data.name .. "] ProDemo.GetGameScriptBody() : body is not GameScriptBody. [" .. tostring(gameScriptBody) .. "]" )
		return NULL
	end

	return gameScriptBody
end,



GetDemoDaemonMessageBox = function()

	local fromMessageBox = DemoDaemon.GetInstance().messageBox
	if fromMessageBox == NULL then
		Fox.Warning( "[" .. data.name .. "] ProDemo.SetMessageBoxes() : DemoDaemon messageBox is NULL." )
		return NULL
	end
	if not fromMessageBox:IsKindOf( MessageBox ) then
		Fox.Warning( "[" .. data.name .. "] ProDemo.SetMessageBoxes() : DemoDeamon messageBox is not MessageBox. [" .. tostring(fromMessageBox) .. "]" )
		return NULL
	end

	return fromMessageBox

end,



RequestSetDefaultValueSyncGameScriptBySequence = function( data, body, gameScriptData )

	
	local gameScriptBody = ProDemo.GetGameScriptBody( data, body, gameScriptData )
	if gameScriptBody == NULL then
		Fox.Warning( "[" .. data.name .. "] gameScriptData[" .. tostring(gameScriptData) .. "] is error." )
		return
	end

	
	for i = 1, gameScriptBody.storage.MAX_SYNC_GAMESCRIPT_COUNT do

		
		local keyName = "SYNC_GAMESCRIPT" .. i
		local syncGameScriptData = gameScriptData.variables[ keyName ]
		if syncGameScriptData == NULL then
			break	
		end

		
		ProDemo.SendMessageToGameScript( data, body, syncGameScriptData, "SetDefaultValue" )
	end

end,



RequestSetDefaultValueSyncGameScript = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemo.RequestSetDefaultValueSyncGameScript()" )

	local storage = body.storage

	
	for i = 1, storage.MAX_SEQUENCE_COUNT do

		
		local keyName = "SEQUENCE_GAMESCRIPT" .. i
		local gameScriptData = data.variables[ keyName ]
		if gameScriptData == NULL then
			break	
		end

		ProDemo.RequestSetDefaultValueSyncGameScriptBySequence( data, body, gameScriptData )
	end

end,



RequestSetDefaultValueSequence = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemo.RequestSetDefaultValueSequence()" )

	local storage = body.storage

	
	for i = 1, storage.MAX_SEQUENCE_COUNT do

		
		local keyName = "SEQUENCE_GAMESCRIPT" .. i
		local gameScriptData = data.variables[ keyName ]
		if gameScriptData == NULL then
			break	
		end

		
		ProDemo.SendMessageToGameScript( data, body, gameScriptData, "SetDefaultValue" )

	end

end,



RequestSetDefaultValueChecker = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemo.RequestSetDefaultValueChecker()" )

	local storage = body.storage

	
	for i = 1, storage.MAX_BREAK_CHECKER_COUNT do

		
		local keyName = "BREAK_CHECKER_GAMESCRIPT" .. i
		local gameScriptData = data.variables[ keyName ]
		if gameScriptData == NULL then
			break	
		end

		
		ProDemo.SendMessageToGameScript( data, body, gameScriptData, "SetDefaultValue" )

	end

	
	for i = 1, storage.MAX_STOP_CHECKER_COUNT do

		
		local keyName = "STOP_CHECKER_GAMESCRIPT" .. i
		local gameScriptData = data.variables[ keyName ]
		if gameScriptData == NULL then
			break	
		end

		
		ProDemo.SendMessageToGameScript( data, body, gameScriptData, "SetDefaultValue" )

	end

end,



SendMessageToGameScript = function( data, body, gameScriptData, messageName )

	

	
	local gameScriptBody = ProDemo.GetGameScriptBody( data, body, gameScriptData )
	if gameScriptBody == NULL then
		Fox.Warning( "[" .. data.name .. "] gameScriptData[" .. tostring(gameScriptData) .. "] is error." )
		return
	end

	
	local fromMessageBox = body.messageBoxes.DEMO_DAEMON
	local toMessageBox = gameScriptBody.messageBox
	fromMessageBox:SendMessageTo( toMessageBox, messageName )

end,



SetCheckerEnable = function( data, body, boolFlag )

	Fox.Log( "[" .. data.name .. "] ProDemo.SetCheckerEnable() [" .. tostring(boolFlag) .. "]" )

	local storage = body.storage

	
	for i = 1, storage.MAX_BREAK_CHECKER_COUNT do

		
		local keyName = "BREAK_CHECKER_GAMESCRIPT" .. i
		local gameScriptData = data.variables[ keyName ]
		if gameScriptData == NULL then
			break	
		end

		
		ProDemo.SetGameScriptEnable( body, gameScriptData, boolFlag )

	end

	
	for i = 1, storage.MAX_STOP_CHECKER_COUNT do

		
		local keyName = "STOP_CHECKER_GAMESCRIPT" .. i
		local gameScriptData = data.variables[ keyName ]
		if gameScriptData == NULL then
			break	
		end

		
		ProDemo.SetGameScriptEnable( body, gameScriptData, boolFlag )

	end

end,



SetGameScriptEnable = function( body, gameScriptData, boolFlag )

	

	
	local gameScriptBody = ProDemo.GetGameScriptBody( data, body, gameScriptData )
	if gameScriptBody == NULL then
		Fox.Warning( "[" .. data.name .. "] gameScriptData[" .. tostring(gameScriptData) .. "] is error." )
		return
	end

	gameScriptBody.enable = boolFlag

end,



StopAllDemoData = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemo.StopAllDemoData()" )

	local storage = body.storage

	
	for i = 1, storage.MAX_SEQUENCE_COUNT do

		
		local keyName = "SEQUENCE_GAMESCRIPT" .. i
		local gameScriptData = data.variables[ keyName ]
		if gameScriptData == NULL then
			break	
		end

		
		ProDemo.StopAllDemoDataInSequence( data, body, gameScriptData )
	end

end,



StopAllDemoDataInSequence = function( data, body, gameScriptData )

	Fox.Log( "[" .. data.name .. "] ProDemo.StopAllDemoDataInSequence() sequence[" .. gameScriptData.name .. "]" )

	
	local gameScriptBody = ProDemo.GetGameScriptBody( data, body, gameScriptData )
	if gameScriptBody == NULL then
		Fox.Warning( "[" .. data.name .. "] gameScriptData[" .. tostring(gameScriptData) .. "] is error." )
		return
	end

	
	for i = 1, gameScriptBody.storage.MAX_DEMO_COUNT do

		
		local keyName = "DEMO" .. i
		local demoData = gameScriptData.variables[ keyName ]
		if demoData == NULL then
			Fox.Log( "[" .. data.name .. "]  DEMO count[" .. i-1 .. "]" )
			break	
		end

		
		ProDemo.StopDemoData( data, body, demoData )
	end

end,



StopDemoData = function( data, body, demoData )

	Fox.Log( "[" .. data.name .. "] ProDemo.StopDemoData()" )

	
	local demoBody = ProDemo.GetDemoBody( data, body, demoData )
	if demoBody == NULL then
		Fox.Warning( "[" .. data.name .. "] demoData[" .. tostring(demoData) .. "] is error." )
		return
	end

	Fox.Log( "[" .. data.name .. "]  Stop DemoData[" .. demoData.name .. "]" )
	demoBody:Stop()

end,




GetDemoBody = function( data, body, demoData )

	if demoData == NULL then
		Fox.Warning( "[" .. data.name .. "] demoData is NULL." )
		return
	end

	local demoBody = demoData:GetDataBodyWithReferrer( body )

	if demoBody == NULL then
		Fox.Warning( "[" .. data.name .. "] demoBody is NULL." )
		return NULL
	end

	if not demoBody:IsKindOf( DemoDataBody ) then
		Fox.Warning( "[" .. data.name .. "] DemoDataBody is not found. data[" .. tostring(demoData) .. "]" )
		return NULL
	end

	return demoBody

end,







OnDebugDumpAll = function( data, body, sender, id, arg1, arg2, arg3 )

	Fox.Log( "[" .. data.name .. "] ProDemo.OnDebugDumpAll()" )

	local storage = body.storage
	local fromMessageBox = body.messageBoxes.DEMO_DAEMON

	
	ProDemo.DebugDump( data, body )

	
	for i = 1, storage.MAX_BREAK_CHECKER_COUNT do
		
		local keyName = "BREAK_CHECKER_GAMESCRIPT" .. i
		local gameScriptData = data.variables[ keyName ]
		if gameScriptData == NULL then
			break	
		end

		
		ProDemo.SendMessageToGameScript( data, body, gameScriptData, "DebugDump" )
	end

end,



DebugDump = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemo.DebugDump()" )

	local storage = body.storage

	Fox.Log( "[" .. data.name .. "]  status[" .. storage.status .. "]" )




	
	for i = 1, storage.MAX_SEQUENCE_COUNT do
		
		local keyName = "SEQUENCE_GAMESCRIPT" .. i
		local sequenceGameScriptData = data.variables[ keyName ]
		if sequenceGameScriptData == NULL then
			break	
		end

		
		local sequenceGameScriptBody = ProDemo.GetGameScriptBody( data, body, sequenceGameScriptData )

		
		local isPlayEnd = false
		if sequenceGameScriptBody ~= NULL then
			isPlayEnd = sequenceGameScriptBody.storage.isPlayEnd
		end

		
		Fox.Log( "[" .. data.name .. "]  " .. keyName .. " : isPlayEnd[" .. tostring(isPlayEnd) .. "] data[" .. tostring(sequenceGameScriptData) .. "] body[" .. tostring(sequenceGameScriptBody) .. "]" )
	end

end,

}

