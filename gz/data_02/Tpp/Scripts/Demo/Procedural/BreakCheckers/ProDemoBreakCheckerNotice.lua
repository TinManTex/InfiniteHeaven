































ProDemoBreakCheckerNotice = {






events = {
	DEMO_DAEMON = { SetDefaultValue = "OnSetDefaultValue", DebugDump = "OnDebugDump" },

	CHARACTER1  = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER2  = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER3  = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER4  = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER5  = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER6  = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER7  = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER8  = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER9  = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER10 = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER11 = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER12 = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER13 = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER14 = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER15 = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
	CHARACTER16 = { StartNotice = "OnStartNotice", StartPatrolRoute = "OnStartPatrolRoute" },
},



Init = function( data, body )





	local storage = body.storage

	
	

	
	storage:AddProperty( "int32", "MAX_CHARACTER_COUNT" )
	storage.MAX_CHARACTER_COUNT = 16

	
	

	
	storage:AddProperty( "bool", "breakFlag" )

	
	storage:AddProperty( "bool", "characterBreakFlags", storage.MAX_CHARACTER_COUNT )

	
	ProDemoBreakCheckerNotice.SetDefaultValue( data, body )

	ProDemoBreakCheckerNotice.DebugDump( data, body )

end,



SetMessageBoxes = function( data, body )





	
	local fromMessageBox = ProDemoBreakCheckerNotice.GetDemoDaemonMessageBox()
	body:AddMessageBox( "DEMO_DAEMON", fromMessageBox )

end,







OnSetDefaultValue = function( data, body, sender, id, arg1, arg2, arg3 )





	ProDemoBreakCheckerNotice.SetDefaultValue( data, body )

end,



OnStartNotice = function( data, body, sender, id, arg1, arg2, arg3 )





	local storage = body.storage

	
	ProDemoBreakCheckerNotice.SetCharacterBreakFlag( data, body, sender.owner, true )

	
	if not ProDemoBreakCheckerNotice.BreakCheck( data, body ) then



		return
	end

	



	body.messageBox:SendMessageToSubscribers( "Break" )

	

	
	storage.breakFlag = true

end,



OnStartPatrolRoute = function( data, body, sender, id, arg1, arg2, arg3 )





	local storage = body.storage

	
	ProDemoBreakCheckerNotice.SetCharacterBreakFlag( data, body, sender.owner, false )

	
	if not ProDemoBreakCheckerNotice.ContinueCheck( data, body ) then



		return
	end

	



	body.messageBox:SendMessageToSubscribers( "Continue" )

	
	storage.breakFlag = false

end,







SetDefaultValue = function( data, body )





	local storage = body.storage

	storage.breakFlag = false

	for i = 1, storage.MAX_CHARACTER_COUNT do
		storage.characterBreakFlags[i] = false
	end

end,




BreakCheck = function( data, body )





	local storage = body.storage

	
	if storage.breakFlag then
		return false
	end

	return true

end,




ContinueCheck = function( data, body )





	local storage = body.storage

	
	if not storage.breakFlag then
		return false
	end

	
	for i = 1, storage.MAX_CHARACTER_COUNT do

		local characterLocatorData = data.variables["CHARACTER" .. i]
		if characterLocatorData == NULL then
			break	
		end

		
		if storage.characterBreakFlags[i] then
			return false
		end
	end

	
	return true
end,



SetCharacterBreakFlag = function( data, body, senderCharacterLocatorBody, boolFlag )

	local storage = body.storage

	for i = 1, storage.MAX_CHARACTER_COUNT do

		local characterLocatorData = data.variables["CHARACTER" .. i]
		if characterLocatorData == NULL then
			break	
		end

		
		if ProDemoBreakCheckerNotice.IsMatchCharacter( data, body, characterLocatorData, senderCharacterLocatorBody ) then
			storage.characterBreakFlags[i] = boolFlag
		end
	end

	ProDemoBreakCheckerNotice.DebugDump( data, body )

end,




IsMatchCharacter = function( data, body, characterLocatorDataA, characterLocatorBodyB )

	
	local characterLocatorBodyA = characterLocatorDataA:GetDataBodyWithReferrer( body )
	if characterLocatorBodyA == NULL or not characterLocatorBodyA:IsKindOf( ChCharacterLocator ) then



		return false
	end

	
	if characterLocatorBodyA ~= characterLocatorBodyB then
		return false
	end

	return true
end,



GetDemoDaemonMessageBox = function()

	local fromMessageBox = DemoDaemon.GetInstance().messageBox
	if fromMessageBox == NULL then



		return NULL
	end
	if not fromMessageBox:IsKindOf( MessageBox ) then



		return NULL
	end

	return fromMessageBox

end,







OnDebugDump = function( data, body, sender, id, arg1, arg2, arg3 )





	ProDemoBreakCheckerNotice.DebugDump( data, body )

end,



DebugDump = function( data, body )





	local storage = body.storage

	




	for i = 1, storage.MAX_CHARACTER_COUNT do
		local keyName = "CHARACTER" .. i
		local characterLocatorData = data.variables[ keyName ]
		if characterLocatorData == NULL then
			break
		end

		local characterLocatorBody = characterLocatorData:GetDataBodyWithReferrer( body )

		local breakFlag = storage.characterBreakFlags[i]



	end

end,

}

