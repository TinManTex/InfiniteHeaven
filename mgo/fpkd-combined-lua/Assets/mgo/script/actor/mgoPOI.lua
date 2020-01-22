
local this = {}











this.Initialize = function( actor, poiParm )

	local actorTransform = actor:GetTransform()
	local actorPos = actorTransform:GetTranslation()
	local actorId = actor:GetGameObjectId()
	
	poiParm.gameObjectId = actorId:GetId()
	poiParm.transform = {
		posX    = actorPos:GetX(),
		posY    = actorPos:GetY(),
		posZ    = actorPos:GetZ(),
		rotY    = 0
	}

	local poiSystemId = GameObject.GetGameObjectIdByIndex( "TppPoiSystem", 0 )
	local poiHandle = GameObject.SendCommand( poiSystemId, { id = "Add", poi = poiParm } )

	if poiHandle == TppPoi.POI_HANDLE_INVALID then
		poiHandle = nil
	end

	return poiHandle

end






this.Destruct = function( actor, poiHandle )

	if not poiHandle then
		return 
	end

	local poiSystemId = GameObject.GetGameObjectIdByIndex( "TppPoiSystem", 0 )
	GameObject.SendCommand( poiSystemId, { id = "Remove", params = { poiHandles = { poiHandle } } })
end







return this