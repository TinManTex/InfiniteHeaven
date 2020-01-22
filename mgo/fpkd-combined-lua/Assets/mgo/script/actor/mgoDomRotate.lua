local this = {}

this.RequestQueue = {}

this.REFRESH_DELTA		= 15
this.elapsedTime		= 0

local SignalTypeEnum = {
	HOST_STATE = 0,
}

this.partsIndex 			= nil

local function BroadcastRotation( actor, rotation )
	local stream = MgoSerialize.NewStream (32)
	
	stream:SetMode ("W")
	stream:SerializeInteger( SignalTypeEnum.HOST_STATE )
	stream:SerializeNumber( rotation )

	MgoSignal.SendSignal( actor:GetGameObjectId(), Fox.StrCode32 ("ALL"), stream )
end

this.ProcessSignal = function( actor, stream )
	stream:SetMode("R")
	local messageId = stream:SerializeInteger(this.MSG_ID_ROTATION)

	if SignalTypeEnum.HOST_STATE == messageId then
		this.rot = stream:SerializeNumber(rotation)
	end
end

this.Construct = function( actor )

	this.RequestQueue = {}
	
	if this.partsIndex == nil then
		local added, partsIndex = MgoParts.Realize( "/Assets/mgo/parts/objective/antenna.parts", 1, 1, 0, 1 )
		if added then
			this.partsIndex = partsIndex
			this.ResetParts( actor )
		end
	end
	
	actor:SetActive(true)
end

this.Reset = function( actor )	
	actor:SetActive(false)
end

this.Activate = function ( actor )
	actor:SetActive(true)
end

this.Deactivate = function ( actor )	
	this.RequestQueue = {}
	actor:SetActive(false)
end

this.Destruct = function ( actor )

	actor:DetachAndTearDownAllParts()
	actor:SetActive( false )

end

this.Reinitialize = this.Construct
this.Teardown = this.Destruct

this.ExecuteIdle = function( actor )
	if this.partsIndex ~= nil then
		this.rot = this.rot + 0.01
		if this.rot > 360 then
			this.rot = 0
		end
		actor:SetTransform(Matrix4.RotTranslation(Quat.RotationY(this.rot), this.worldPos ) )
	end
end

this.worldPos	= Vector3( 0, 0, 0 )
this.rot 		= 0

this.ExecuteHost = function( actor )
	if (actor:IsActive() == false) then
		return
	end
	
	if this.partsIndex ~= nil then
		this.rot = this.rot + 0.01
		if this.rot > 360 then
			this.rot = 0
		end
		actor:SetTransform(Matrix4.RotTranslation(Quat.RotationY(this.rot), this.worldPos ) )
	end
	
	










end




this.ExecuteClient = function( actor )
	if actor:IsActive() == false then
		return
	end
	
	if this.partsIndex ~= nil then
		this.rot = this.rot + 0.01
		if this.rot > 360 then
			this.rot = 0
		end
		actor:SetTransform(Matrix4.RotTranslation(Quat.RotationY(this.rot), this.worldPos ) )
	end
end

this.ExecuteScript = function( actor, execParms )

end

this.ResetParts = function( actor, lw )

	if this.partsIndex ~= nil then
		if lw == nil then
			lw = actor:GetInitialTransform()
		end	
		actor:SetTransform( lw )
		actor:AttachParts( this.partsIndex )
		local actorPos = lw:GetTranslation()
		this.worldPos = actorPos
	end

end

return this