























ProDemoSyncPlayEnd = {






events = {
	DEMO_DAEMON = { SetDefaultValue = "OnSetDefaultValue" },

	PREV_PRO_DEMO_GAMESCRIPT1 = { PlayEnd = "OnProDemoPlayEnd" },
	PREV_PRO_DEMO_GAMESCRIPT2 = { PlayEnd = "OnProDemoPlayEnd" },
	PREV_PRO_DEMO_GAMESCRIPT3 = { PlayEnd = "OnProDemoPlayEnd" },
	PREV_PRO_DEMO_GAMESCRIPT4 = { PlayEnd = "OnProDemoPlayEnd" },
},



Init = function( data, body )
	Fox.Log( "[" .. data.name .. "] ProDemoSyncPlayEnd.Init()" )

	local storage = body.storage

	
	

	
	storage:AddProperty( "int32", "MAX_PREV_PRO_DEMO_GAMESCRIPT_COUNT" )
	storage.MAX_PREV_PRO_DEMO_GAMESCRIPT_COUNT = 4

	
	storage:AddProperty( "int32", "MAX_NEXT_PRO_DEMO_GAMESCRIPT_COUNT" )
	storage.MAX_NEXT_PRO_DEMO_GAMESCRIPT_COUNT = 4

	
	

	
	storage:AddProperty( "bool", "prevProDemoEndFlags", storage.MAX_PREV_PRO_DEMO_GAMESCRIPT_COUNT )

	
	storage:AddProperty( "bool", "nextProDemoPlayFlag" )

	
	ProDemoSyncPlayEnd.SetDefaultValue( data, body )

	ProDemoSyncPlayEnd.DebugDump( data, body )
end,



SetMessageBoxes = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemoSyncPlayEnd.SetMessageBoxes()" )

	
	local fromMessageBox = ProDemoSyncPlayEnd.GetDemoDaemonMessageBox()
	body:AddMessageBox( "DEMO_DAEMON", fromMessageBox )

end,








OnSetDefaultValue = function( data, body, sender, id, arg1, arg2, arg3 )

	Fox.Log( "[" .. data.name .. "] ProDemoSyncPlayEnd.OnSetDefaultValue()" )

	ProDemoSyncPlayEnd.SetDefaultValue( data, body )

end,



OnProDemoPlayEnd = function( data, body, sender, id, arg1, arg2, arg3, arg4 )

	Fox.Log( "[" .. data.name .. "] ProDemoSyncPlayEnd.OnProDemoPlayEnd()" )

	local storage = body.storage

	
	ProDemoSyncPlayEnd.SetProDemoEndFlag( data, body, sender.owner, true )

	
	if ProDemoSyncPlayEnd.CheckNext( data, body ) == false then
		return
	end

	
	ProDemoSyncPlayEnd.Next( data, body )
end,




SetDefaultValue = function( data, body )

	local storage = body.storage

	
	for i = 1, storage.MAX_PREV_PRO_DEMO_GAMESCRIPT_COUNT do
		storage.prevProDemoEndFlags[i] = false
	end

	
	storage.nextProDemoPlayFlag = false

end,



Next = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemoSyncPlayEnd.Next()" )

	local storage = body.storage

	
	for i = 1, storage.MAX_NEXT_PRO_DEMO_GAMESCRIPT_COUNT do

		
		local keyName = "NEXT_PRO_DEMO_GAMESCRIPT" .. i
		local gameScriptData = data.variables[ keyName ]
		if gameScriptData == NULL then
			break	
		end

		
		ProDemoSyncPlayEnd.PlayProDemo( data, body, gameScriptData )
	end

	storage.nextProDemoPlayFlag = true

end,



PlayProDemo = function( data, body, proDemoGameScriptData )

	Fox.Log( "[" .. data.name .. "] ProDemoSyncPlayEnd.PlayProDemo()" )

	
	local messageName = "Play"
	ProDemoSyncPlayEnd.SendMessageToGameScript( data, body, proDemoGameScriptData, messageName )

end,



SendMessageToGameScript = function( data, body, gameScriptData, messageName )

	Fox.Log( "[" .. data.name .. "] ProDemoSyncPlayEnd.SendMessageToGameScript()" )

	
	local gameScriptBody = ProDemoSyncPlayEnd.GetGameScriptBody( body, gameScriptData )
	if gameScriptBody == NULL then
		Fox.Warning( "[" .. data.name .. "] gameScriptData[" .. tostring(gameScriptData) .. "] is error." )
		return
	end

	
	local fromMessageBox = body.messageBoxes.DEMO_DAEMON
	local toMessageBox = gameScriptBody.messageBox
	fromMessageBox:SendMessageTo( toMessageBox, messageName )

end,




GetGameScriptBody = function( body, gameScriptData )

	if gameScriptData == NULL then
		Fox.Warning( "[" .. data.name .. "] ProDemoSyncPlayEnd.GetGameScriptBody() : data is NULL." )
		return NULL
	end

	local gameScriptBody = gameScriptData:GetDataBodyWithReferrer( body )
	if gameScriptBody == NULL then
		Fox.Warning( "[" .. data.name .. "] ProDemoSyncPlayEnd.GetGameScriptBody() : Body not found." )
		return NULL
	end
	if not gameScriptBody:IsKindOf( GameScriptBody ) then
		Fox.Warning( "[" .. data.name .. "] ProDemoSyncPlayEnd.GetGameScriptBody() : body is not GameScriptBody. [" .. tostring(gameScriptBody) .. "]" )
		return NULL
	end

	return gameScriptBody
end,



SetProDemoEndFlag = function( data, body, targetGameScriptBody, boolFlag )

	Fox.Log( "[" .. data.name .. "] ProDemoSyncPlayEnd.SetProDemoEndFlag()" )

	local storage = body.storage

	
	for i = 1, storage.MAX_PREV_PRO_DEMO_GAMESCRIPT_COUNT do

		
		local keyName = "PREV_PRO_DEMO_GAMESCRIPT" .. i
		local gameScriptData = data.variables[ keyName ]
		if gameScriptData == NULL then
			break	
		end

		
		if ProDemoSyncPlayEnd.IsMatchGameScript( body, gameScriptData, targetGameScriptBody ) then
			
			storage.prevProDemoEndFlags[i] = boolFlag
			break
		end
	end

	ProDemoSyncPlayEnd.DebugDump( data, body )

end,




IsMatchGameScript = function( body, gameScriptDataA, gameScriptBodyB )

	
	local gameScriptBodyA = ProDemoSyncPlayEnd.GetGameScriptBody( body, gameScriptDataA )
	if gameScriptBodyA == NULL then
		Fox.Warning( "[" .. data.name .. "] gameScriptData[" .. tostring(gameScriptDataA) .. "] is error." )
		return false
	end

	
	if gameScriptBodyA ~= gameScriptBodyB then
		return false
	end

	return true
end,





CheckNext = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemoSyncPlayEnd.CheckNext()" )

	local storage = body.storage

	
	if storage.nextProDemoPlayFlag then
		return false
	end

	
	for i = 1, storage.MAX_PREV_PRO_DEMO_GAMESCRIPT_COUNT do

		local keyName = "PREV_PRO_DEMO_GAMESCRIPT" .. i
		local gameScriptData = data.variables[ keyName ]
		if gameScriptData == NULL then
			break
		end

		local prevDemoEndFlag = storage.prevProDemoEndFlags[i]
		if prevDemoEndFlag == false then
			return false
		end
	end

	return true

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






DebugDump = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemoSyncPlayEnd.DebugDump()" )

	local storage = body.storage

	
	for i = 1, storage.MAX_PREV_PRO_DEMO_GAMESCRIPT_COUNT do

		
		local keyName = "PREV_PRO_DEMO_GAMESCRIPT" .. i
		local gameScriptData = data.variables[ keyName ]
		if gameScriptData == NULL then
			break	
		end

		
		local gameScriptBody = ProDemoSyncPlayEnd.GetGameScriptBody( body, gameScriptData )

		
		local prevDemoEndFlag = storage.prevProDemoEndFlags[i]

		
		Fox.Log( "[" .. data.name .. "]  " .. keyName .. " : data[" .. tostring(gameScriptData) .. "] body[" .. tostring(gameScriptBody) .. "] prevDemoEndFlag[" .. tostring(prevDemoEndFlag) .. "]" )
	end

	
	for i = 1, storage.MAX_NEXT_PRO_DEMO_GAMESCRIPT_COUNT do

		
		local keyName = "NEXT_PRO_DEMO_GAMESCRIPT" .. i
		local gameScriptData = data.variables[ keyName ]
		if gameScriptData == NULL then
			break	
		end

		
		local gameScriptBody = ProDemoSyncPlayEnd.GetGameScriptBody( body, gameScriptData )

		
		Fox.Log( "[" .. data.name .. "]  " .. keyName .. " : data[" .. tostring(gameScriptData) .. "] body[" .. tostring(gameScriptBody) .. "]" )
	end

	
	Fox.Log( "[" .. data.name .. "]  nextProDemoPlayFlag[" .. tostring(storage.nextProDemoPlayFlag) .. "]" )

end,

} 

