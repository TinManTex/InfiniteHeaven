
































ProDemoSequence = {






events = {
	DEMO_DAEMON = { SetDefaultValue = "OnSetDefaultValue" },

	LAST_GAMESCRIPT = { PlayEnd = "OnPlayEnd" },
},



Init = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemoSequence.Init()" )

	local storage = body.storage

	
	

	
	storage:AddProperty( "int32", "MAX_FIRST_DEMO_COUNT" )
	storage.MAX_FIRST_DEMO_COUNT = 8

	
	storage:AddProperty( "int32", "MAX_SYNC_GAMESCRIPT_COUNT" )
	storage.MAX_SYNC_GAMESCRIPT_COUNT = 4

	
	storage:AddProperty( "int32", "MAX_DEMO_COUNT" )
	storage.MAX_DEMO_COUNT = 16

	
	

	
	storage:AddProperty( "bool", "isPlayEnd" )

	
	ProDemoSequence.SetDefaultValue( data, body )

end,



SetMessageBoxes = function( data, body )

	Fox.Log( "[" .. data.name .. "] ProDemoSequence.SetMessageBoxes()" )

	
	local fromMessageBox = ProDemoSequence.GetDemoDaemonMessageBox()
	body:AddMessageBox( "DEMO_DAEMON", fromMessageBox )

end,







OnSetDefaultValue = function( data, body, sender, id, arg1, arg2, arg3 )

	Fox.Log( "[" .. data.name .. "] ProDemoSequence.OnSetDefaultValue()" )

	ProDemoSequence.SetDefaultValue( data, body )

end,



OnPlayEnd = function( data, body, sender, id, arg1, arg2, arg3 )

	Fox.Log( "[" .. data.name .. "] ProDemoSequence.OnPlayEnd()" )

	
	local storage = body.storage
	storage.isPlayEnd = true

	
	body.messageBox:SendMessageToSubscribers( "PlayEnd" )

end,







SetDefaultValue = function( data, body )

	

	local storage = body.storage
	storage.isPlayEnd = false		

end,



GetDemoDaemonMessageBox = function()

	local fromMessageBox = DemoDaemon.GetInstance().messageBox
	if fromMessageBox == NULL then
		Fox.Warning( "[" .. data.name .. "] ProDemoSequence.SetMessageBoxes() : DemoDaemon messageBox is NULL." )
		return NULL
	end
	if not fromMessageBox:IsKindOf( MessageBox ) then
		Fox.Warning( "[" .. data.name .. "] ProDemoSequence.SetMessageBoxes() : DemoDeamon messageBox is not MessageBox. [" .. tostring(fromMessageBox) .. "]" )
		return NULL
	end

	return fromMessageBox

end,

}

