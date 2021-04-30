







missionClearByHelicopter = {





events = {
	DEMO = { PlayEnd="OnDemoEnd" }, 
},



Init = function( data, body )
end,



SetMessageBoxes = function( data, body )



end,


AddDynamicPropertiesToData = function( data, body )

	
	if data.variables.DEMO == NULL then
		data.variables.DEMO = nil
	end

	
	data:AddProperty( 'EntityLink', "Heli_Locator" )

	
	data:AddProperty( 'EntityLink', "Heli_Route" )
end,




OnDemoEnd = function( data, body, sender, id, arg1, arg2, arg3, arg4 )



	body.messageBox:SendMessageToSubscribers( "PlayEnd" )

	local route =  data.Heli_Route
	
	TppSupportHelicopterService.SetUpHelicopterFreePlay(route)
	
end,

}
