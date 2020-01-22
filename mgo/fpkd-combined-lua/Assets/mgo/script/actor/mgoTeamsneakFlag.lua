local this = {}
this.pushToParent = {}


local SignalTypeEnum = {
	HOST_STATE = 0,
	INTERACTION = 1,
}


local PartsFile = "/Assets/mgo/parts/objective/floppy_disk.parts"
local VFXPlayerConnectionPoint = "CNP_HEAD"
local VFXPlayerOffset = Vector3{ 0.0, 0.15, 0.0 }


local Flag_Type_Teamsneak_Disk = 0x01
local Own_Flag_Neutral = 0x10
local Own_Flag_Friendly = 0x20
local Own_Flag_Enemy = 0x40


local FlagResetTime = 30
local BroadcastPeriod = 1.5
local ForceRetransmit = true
local BroadcastTick = 0
local PositionOnGround = Vector3{ 0.0, 0.0, 0.0 }
local FlagResetTimer = -1
local flagEnter = false


local POI = nil
local PartsIndex = nil
local AttachmentParameters = {}


local ClientIsActive = false
local ClientAttachedToPlayerIndex = -1


local UpdateUI
local UpdateActorAttachmentState
local UpdateButtonPromptState
local TransmitState
local FindGroundResult

local lastOptionShowMissionInfo

this.AddParm = function(data)
    data:AddDynamicProperty("String", "MarkerName")
    data.MarkerName = "A"
	data:AddDynamicProperty("String", "GenericPOITag")
    data.GenericPOITag = "GENERIC_01"
end


this.RemoveParm = function(data)
    data:RemoveDynamicProperty("MarkerName")
	data:RemoveDynamicProperty("GenericPOITag")
end


this.Construct = function( actor )
	
	if not POI then
		local genericPOITag = actor:GetParm().GenericPOITag
		local POIParm =	{
			type = TppPoi.POI_TYPE_GENERIC,
			tags = {
				"OBJECTIVE",
				genericPOITag
			}
		}
		POI = Utils.POIinitialize( actor, POIParm )
	end
	
	
	BroadcastTick = 0
	BroadcastPeriod = 1.5
	FlagResetTimer = -1
	FlagResetTime = 30
	flagEnter = false
	actor:GetTable().AttachedToPlayerIndex = -1
	ForceRetransmit = true
	ClientIsActive = false
	ClientAttachedToPlayerIndex = -1
	
	
	local initialTransform = actor:GetInitialTransform()
	actor:SetTransform( initialTransform )
	PositionOnGround = initialTransform:GetTranslation()
	
	
	if PartsIndex == nil then
		actor:DetachAndTearDownAllParts()
		local success = nil
		success, PartsIndex = MgoParts.Realize( PartsFile, 1, 1 )
		if not success then
			PartsIndex = nil
			Fox.Error( "mgoFlag:Construct(): Failed to realize parts " .. PartsFile )
		else
			
			actor:AttachParts( PartsIndex )	
			MgoParts.SetVisibility( PartsIndex, true )
		end
	end
	
	
	AttachmentParameters = {
		attachmentPoint = VFXPlayerConnectionPoint,
		attachmentBone = "SKL_004_HEAD",  
		localMatrix = Matrix4.Translation( VFXPlayerOffset ),
	}
	
	
	actor:SetActive( true )
	
	
	UpdateButtonPromptState( actor, actor:IsActive(), actor:GetTable().AttachedToPlayerIndex )

	lastOptionShowMissionInfo = vars.optionShowMissionInfo
end
this.Reset = this.Construct
this.Reinitialize = this.Construct


this.Destruct = function ( actor )
	
	Utils.POIdestruct( actor, POI )
	POI = nil
	
	
	if PartsIndex then
		MgoParts.StopEffect( PartsIndex, "Icon" )
		MgoParts.SetVisibility( PartsIndex, false )
	end
	actor:DetachAndTearDownAllParts()
	actor:GetTable().AttachedToPlayerIndex = -1
	
	
	actor:DisableMarker()

	
	actor:SetActive( false )
		
	
	UpdateButtonPromptState( actor, actor:IsActive(), actor:GetTable().AttachedToPlayerIndex )
end
this.Teardown = this.Destruct


this.Activate = function ( actor )
	ForceRetransmit = true
end


this.Deactivate = function ( actor )
	ForceRetransmit = true
end


this.ExecuteIdle = function( actor )
	
	UpdateUI( actor, ClientIsActive, ClientAttachedToPlayerIndex )
end


this.ExecuteHost = function( actor )
	local dt = actor:GetScaledTime()
	local ruleset = MpRulesetManager.GetActiveRuleset()
	
	
	if actor:GetTable().AttachedToPlayerIndex < 0 and FlagResetTimer > 0 then
		FlagResetTimer = FlagResetTimer - dt
		if FlagResetTimer <= 0 and flagEnter == false then
			
			FlagResetTimer = -1
			local initialTransform = actor:GetInitialTransform()
			PositionOnGround = initialTransform:GetTranslation()
			this.LineChecker.OnResultReady( actor, true, PositionOnGround, nil )
			
			
			local actorGameObjectId = actor:GetGameObjectId():GetId()
			local eventStream = MgoSerialize.NewStream( 33 )
			eventStream:SetMode( "W" )
			Utils.SerializeEvent( eventStream, actorGameObjectId, Fox.StrCode32( "flagreturn" ))
			MgoSignal.SendSignal( ruleset:GetRulesetGameObjectId(), Fox.StrCode32( "LOCAL" ), eventStream )
		end
	else
		FlagResetTimer = -1
	end

	
	BroadcastTick = BroadcastTick - dt
	if ForceRetransmit or BroadcastTick < 0 then
		BroadcastTick = BroadcastPeriod
		ForceRetransmit = false
		local attachedToPlayerIndex = actor:GetTable().AttachedToPlayerIndex
		TransmitState( actor, actor:IsActive(), attachedToPlayerIndex, PositionOnGround )
	end
	
	
	UpdateUI( actor, ClientIsActive, ClientAttachedToPlayerIndex )
end


this.ExecuteClient = function( actor )
	
	UpdateUI( actor, ClientIsActive, ClientAttachedToPlayerIndex )
end


this.ExecuteScript = function( actor, execParms )
end


this.ProcessSignal = function( actor, stream )
	if stream == nil then
		return
	end
	stream:SetMode("R")
	local signalType = nil
	signalType = stream:SerializeInteger( signalType )
	
	if Mgo.IsHost() and signalType == SignalTypeEnum.INTERACTION then
		local ruleset = MpRulesetManager.GetActiveRuleset()
		local playerIndex = nil
		local actionType = nil
		playerIndex = stream:SerializeInteger( playerIndex )
		actionType = stream:SerializeInteger( actionType )
	
		
		
		local playerGameObjectId = MgoActor.GetPlayerGameObjectId( playerIndex )
		local playerHasFlag, attachmentID = MgoActor.FindAttachedTo( playerGameObjectId )
		
		ForceRetransmit = true

		
		if actionType == MgoActor.ACTOR_PLAYER_ACTION_PICKUP and not playerHasFlag and actor:GetTable().AttachedToPlayerIndex == -1 
			and not PlayerInfo.OrCheckStatus( playerIndex, { PlayerStatus.CHARMED, PlayerStatus.UNCONSCIOUS } ) then
			actor:GetTable().AttachedToPlayerIndex = playerIndex

			
			local actorGameObjectId = actor:GetGameObjectId():GetId()
			local eventStream = MgoSerialize.NewStream(33)
			eventStream:SetMode("W")

			Utils.SerializeEvent( eventStream, actorGameObjectId, Fox.StrCode32("flagPickup"), -1, attachedToId )
			MgoSignal.SendSignal( ruleset:GetRulesetGameObjectId(), Fox.StrCode32("LOCAL"), eventStream )
			if actor:GetParm().MarkerName == "A" then
				GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "FlagPickupA", flagId = actorGameObjectId, idx = playerIndex } )
			else
				GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "FlagPickupB", flagId = actorGameObjectId, idx = playerIndex } )
			end
			
			if playerIndex == 0 then
				if vars.optionShowMissionInfo == 0 then
					MgoParts.CreateEffect( PartsIndex, "Icon" )
				end
			end
			
			TeamSneak.OnFlagStateChange( actor, true, actor:GetParm().MarkerName )
		elseif actionType == MgoActor.ACTOR_PLAYER_ACTION_DROP then
			
			MgoParts.StopEffect( PartsIndex, "Icon" )
			local worldPos = actor:GetTransform():GetTranslation()
			local lineTo = Vector3.Add( worldPos, Vector3.Scale( 10, Vector3( 0, -1, 0 ) ) )
			this.LineChecker.RequestLineCheck( actor, FindGroundResult, worldPos, lineTo, MgoActor.GEO_COL_F_CHK_ALL, MgoActor.CATEGORY_CHARA, MgoActor.GEO_COL_ATR_PLAYER )
		end
		
	elseif signalType == SignalTypeEnum.HOST_STATE then
		
		local groundPosition = nil
		ClientIsActive = stream:SerializeBoolean( ClientIsActive )	
		ClientAttachedToPlayerIndex = stream:SerializeInteger( ClientAttachedToPlayerIndex )
		groundPosition = stream:SerializeVector3( groundPosition )
		
		
		UpdateActorAttachmentState( actor, ClientIsActive, ClientAttachedToPlayerIndex, groundPosition )
		
		
		UpdateButtonPromptState( actor, ClientIsActive, ClientAttachedToPlayerIndex )
	end

end


UpdateUI = function( actor, isActive, attachedToPlayerIndex )
	local isFlagCarried = ( attachedToPlayerIndex ~= -1 )

	if isActive then
		local ruleset = MpRulesetManager.GetActiveRuleset()
		local localTeam = nil
		if ruleset ~= nil and ruleset.GetLocalPlayerTeam ~= nil then
			localTeam = ruleset:GetLocalPlayerTeam()
		end
		
		
		local markerData = {}
		markerData.data = math.floor( 0.5 + (0.5 * 255) ) 
		if localTeam == TeamSneak.attacker then
			if isFlagCarried then
				markerData.flags = Flag_Type_Teamsneak_Disk + Own_Flag_Friendly
			else
				markerData.flags = Flag_Type_Teamsneak_Disk + Own_Flag_Enemy
			end
		else
			if isFlagCarried then
				markerData.flags = Flag_Type_Teamsneak_Disk + Own_Flag_Enemy
			else
				markerData.flags = Flag_Type_Teamsneak_Disk + Own_Flag_Friendly
			end
		end
		
		








		
		actor:UpdateMarker( markerData )
		
		if isFlagCarried and localTeam == TeamSneak.defender then
			actor:DisableMarker(true)
		else
			if ruleset:GetLocalPlayerSessionIndex() == attachedToPlayerIndex then
				actor:DisableMarker(true)
			else
				actor:EnableMarker( actor:GetParm().MarkerName )
			end
		end

		local optionChanged = false
		if lastOptionShowMissionInfo ~= vars.optionShowMissionInfo then
			lastOptionShowMissionInfo = vars.optionShowMissionInfo
			optionChanged = true
		end

		if optionChanged then
			if vars.optionShowMissionInfo == 1 or not isFlagCarried then
				MgoParts.StopEffect( PartsIndex, "Icon" )
			else
				if localTeam == TeamSneak.defender then
					MgoParts.CreateEffect( PartsIndex, "Icon" )
					if MgoParts.SendMessageVector4 then
						MgoParts.SendMessageVector4( PartsIndex, "Icon", "color", Vector4(1, 0.024, 0, 1) )
					end
				elseif ruleset:GetLocalPlayerSessionIndex() == attachedToPlayerIndex then
					MgoParts.CreateEffect( PartsIndex, "Icon" )
				end
			end
		end
	else
		actor:DisableMarker()
	end
end


UpdateActorAttachmentState = function( actor, isActive, newAttachedToPlayerIndex, groundPosition )
	local ruleset = MpRulesetManager.GetActiveRuleset()
	if ruleset == nil then
		return
	end
	
	local curAttachedToGameObject = actor:GetAttachedToGameObject()
	local newAttachedToGameObject = nil
	if newAttachedToPlayerIndex >= 0 then
		newAttachedToGameObject = MgoActor.GetPlayerGameObjectId( newAttachedToPlayerIndex )
	end
	
	
	if ( newAttachedToGameObject == nil or not newAttachedToGameObject:IsSet() ) and curAttachedToGameObject:IsSet() then
		
		actor:Detach()
	elseif ( newAttachedToGameObject ~= nil and newAttachedToGameObject:IsSet() ) and not curAttachedToGameObject:IsSet() then
		
		actor:AttachToGameObject( newAttachedToGameObject:GetId(), AttachmentParameters )
	elseif ( newAttachedToGameObject ~= nil and newAttachedToGameObject:IsSet() ) and curAttachedToGameObject:GetId() ~= newAttachedToGameObject:GetId() then
		
		actor:Detach()
		actor:AttachToGameObject( newAttachedToGameObject:GetId(), AttachmentParameters )
	end
	
	
	if ( newAttachedToGameObject == nil or not newAttachedToGameObject:IsSet() ) then
		local transform = actor:GetInitialTransform():Translate( groundPosition )
		actor:SetTransform( transform )
		MgoParts.SetVisibility( PartsIndex, true )
		MgoParts.StopEffect( PartsIndex, "Icon" )
	else
		MgoParts.SetVisibility( PartsIndex, false )
		local localTeam = nil
		if ruleset ~= nil and ruleset.GetLocalPlayerTeam ~= nil then
			localTeam = ruleset:GetLocalPlayerTeam()
		end
		if vars.optionShowMissionInfo == 0 then
			if localTeam == TeamSneak.defender then
				MgoParts.CreateEffect( PartsIndex, "Icon" )
				if MgoParts.SendMessageVector4 then
					MgoParts.SendMessageVector4( PartsIndex, "Icon", "color", Vector4(1, 0.024, 0, 1) )
				end
			elseif ruleset:GetLocalPlayerSessionIndex() == newAttachedToPlayerIndex then
				MgoParts.CreateEffect( PartsIndex, "Icon" )
			end
		end
	end
end


UpdateButtonPromptState = function( actor, isActive, attachedToPlayerIndex )
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local localTeam = nil
	local localPlayerIndex = nil
	if ruleset ~= nil and ruleset.GetLocalPlayerTeam ~= nil then
		localTeam = ruleset:GetLocalPlayerTeam()
		localPlayerIndex = ruleset:GetLocalPlayerSessionIndex()
	end
	
	
	
	local localPlayerGameObjectId = MgoActor.GetPlayerGameObjectId( localPlayerIndex )
	local localPlayerHasFlag, attachmentID = MgoActor.FindAttachedTo( localPlayerGameObjectId )

	
	actor:RemoveActionForPlayer()
	if not isActive or localTeam == nil or localPlayerIndex == nil or PlayerInfo.OrCheckStatus( localPlayerIndex, { PlayerStatus.CHARMED, PlayerStatus.UNCONSCIOUS } ) then
		
	elseif attachedToPlayerIndex == localPlayerIndex then
		actor:AddActionForPlayer( MgoActor.ACTOR_PLAYER_ACTION_DROP, 8192, MgoActor.ACTOR_PLAYER_ACTION_PERMISSION_ALLOW_TEAM, TeamSneak.attacker )
	elseif not localPlayerHasFlag and localTeam == TeamSneak.attacker and attachedToPlayerIndex == -1 and not PlayerInfo.AndCheckStatus( localPlayerIndex, { PlayerStatus.UNCONSCIOUS } ) then
		actor:AddActionForPlayer( MgoActor.ACTOR_PLAYER_ACTION_PICKUP, 2, MgoActor.ACTOR_PLAYER_ACTION_PERMISSION_ALLOW_TEAM, TeamSneak.attacker )
	end
end


TransmitState = function( actor, isActive, attachedToPlayerIndex, groundPosition )
	local stream = MgoSerialize.NewStream( 29 )
	stream:SetMode("W")
	stream:SerializeInteger( SignalTypeEnum.HOST_STATE )
	stream:SerializeBoolean( isActive )					
	stream:SerializeInteger( attachedToPlayerIndex )	
	stream:SerializeVector3( groundPosition )			
	MgoSignal.SendSignal( actor:GetGameObjectId(), Fox.StrCode32("ALL"), stream )
end


this.HandlePlayerAction = function( actor, playerInstanceIndex, actionType )
	local stream = MgoSerialize.NewStream( 24 )
	stream:SetMode("W")
	stream:SerializeInteger( SignalTypeEnum.INTERACTION )
	stream:SerializeInteger( playerInstanceIndex )
	stream:SerializeInteger( actionType )
	MgoSignal.SendSignal( actor:GetGameObjectId(), Fox.StrCode32("HOST"), stream )
end


this.ExecuteScript = function( actor, execParms )
	if not Mgo.IsHost() then
		return
	end

	
	if "dropFlag" == execParms.command then
		if actor:GetTable().AttachedToPlayerIndex == execParms.playerIndex then
			this.HandlePlayerAction( actor, execParms.playerIndex, MgoActor.ACTOR_PLAYER_ACTION_DROP )
		end
	elseif "flagEnterA" == execParms.command then
		if actor:GetParm().MarkerName == "A" then
		flagEnter = true
		end
	elseif "flagEnterB" == execParms.command then
		if actor:GetParm().MarkerName == "B" then
			flagEnter = true
		end
	elseif "flagExitA" == execParms.command then
		if actor:GetParm().MarkerName == "A" then
		flagEnter = false
		if actor:GetTable().AttachedToPlayerIndex == -1 then
			FlagResetTimer = FlagResetTime
			ForceRetransmit = true
		end
		end
	elseif "flagExitB" == execParms.command then
		if actor:GetParm().MarkerName == "B" then
			flagEnter = false
			if actor:GetTable().AttachedToPlayerIndex == -1 then
				FlagResetTimer = FlagResetTime
				ForceRetransmit = true
			end
		end
	elseif "neutralizedA" == execParms.command then
		if actor:GetParm().MarkerName == "A" then
			FlagResetTimer = 0.5 
			flagEnter = false
		end
	elseif "neutralizedB" == execParms.command then
		if actor:GetParm().MarkerName == "B" then
			FlagResetTimer = 0.5 
			flagEnter = false
		end
	end
end





this.LineChecker = {
    lineCheckIdInternal = MgoActor.INVALID_LINE_CHECK_ID,
    callbackMethodInternal = nil,
     
    RequestLineCheck = function( actor, callbackMethod, lineFrom, lineTo, collisionFlag, collisionCategory, includedAttributes, excludedAttributes, needAttributes )       
         
        if this.LineChecker.lineCheckIdInternal ~= MgoActor.INVALID_LINE_CHECK_ID then
            return false
        end
         
        this.LineChecker.callbackMethodInternal = callbackMethod 
        this.LineChecker.lineCheckIdInternal = actor:RequestLineCheck( lineFrom, lineTo, collisionFlag, collisionCategory, includedAttributes, excludedAttributes, needAttributes )
         
        return this.LineChecker.lineCheckIdInternal ~= MgoActor.INVALID_LINE_CHECK_ID
    end,
     
    OnResultReady = function( actor, isHit, hitPos, hitNormal )       
        
        if this.LineChecker.callbackMethodInternal ~= nil then
            this.LineChecker.callbackMethodInternal( actor, isHit, hitPos, hitNormal )
        end
         
        
        this.LineChecker.lineCheckIdInternal = MgoActor.INVALID_LINE_CHECK_ID
        this.LineChecker.callbackMethodInternal = nil
    end,
}


this.HandleCollisionResult = function( actor, lineCheckId, isHit, hitPos, hitNormal )
    if lineCheckId == this.LineChecker.lineCheckIdInternal then
        this.LineChecker.OnResultReady( actor, isHit, hitPos, hitNormal )
    end
end


FindGroundResult = function( actor, isHit, hitPos, hitNormal )
	
	actor:GetTable().AttachedToPlayerIndex = -1
	if FlagResetTimer < 0 then
		FlagResetTimer = FlagResetTime
	end
	ForceRetransmit = true
	
	
	if isHit then
		PositionOnGround = hitPos
	else
		PositionOnGround = actor:GetTransform():GetTranslation()
	end
				
	
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local actorGameObjectId = actor:GetGameObjectId():GetId()
	local eventStream = MgoSerialize.NewStream(48)
	eventStream:SetMode("W")
	Utils.SerializeEvent( eventStream, actorGameObjectId, Fox.StrCode32("flagDrop"), -1, attachedToId )
	MgoSignal.SendSignal( ruleset:GetRulesetGameObjectId(), Fox.StrCode32("LOCAL"), eventStream )
	
	
	TeamSneak.OnFlagStateChange( actor, false, actor:GetParm().MarkerName )
end


return this
