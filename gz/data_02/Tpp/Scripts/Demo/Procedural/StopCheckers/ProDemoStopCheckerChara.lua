




















ProDemoStopCheckerChara = {






events = {
	CHARACTER1  = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER2  = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER3  = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER4  = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER5  = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER6  = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER7  = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER8  = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER9  = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER10 = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER11 = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER12 = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER13 = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER14 = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER15 = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
	CHARACTER16 = { EnemyDead = "OnStopRequest", EnemySleep = "OnStopRequest", EnemyFaint = "OnStopRequest", EnemyFulton = "OnStopRequest", EnemyDying = "OnStopRequest" },
},



Init = function( data, body )





	local storage = body.storage

	
	

	
	storage:AddProperty( "int32", "MAX_CHARACTER_COUNT" )
	storage.MAX_CHARACTER_COUNT = 16

	ProDemoStopCheckerChara.DebugDump( data, body )

end,







OnStopRequest = function( data, body, sender, id, arg1, arg2, arg3 )





	
	body.messageBox:SendMessageToSubscribers( "Stop" )

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

		
		local characterMessageBox = NULL
		if characterLocatorBody ~= NULL then
			characterMessageBox = characterLocatorBody.messageBox
		end




	end

end,

}

