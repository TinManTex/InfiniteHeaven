local this = {}

local ApplyCooldown
local TrapHandler
local TransmitState
local BroadcastPeriod = 0.5
local ForceRetransmit = false

local BroadcastTick = 0
this.PlayersInTrap = {}
local Owner = nil  
local Direction = nil
local Capturing = nil
local CaptureValue = 0.0
local flagEnterA = false
local flagEnterB = false
local flagEnterA_OwnerId = nil 
local flagEnterB_OwnerId = nil 


this.AddParm = function(data)
end
 
 
this.RemoveParm = function(data)
end


this.Reset = function( actor )
	
	actor:GetTable().capturePointBackend = this
	
	BroadcastTick = 0
	this.PlayersInTrap = {}
	Owner = nil
	Direction = nil
	Capturing = nil
	CaptureValue = 0.0
	ForceRetransmit = true
	flagEnterA = false
	flagEnterB = false
	flagEnterA_OwnerId = nil
	flagEnterB_OwnerId = nil
	BroadcastPeriod = 0.5
end
this.Construct = this.Reset
this.Reinitialize = this.Reset


this.Destruct = function ( actor )
end
this.Teardown = this.Destruct


this.Activate = function ( actor )
	ForceRetransmit = true
end


this.Deactivate = function ( actor )
	ForceRetransmit = true
end


this.ProcessSignal = function( actor, stream )
end


this.ExecuteHost = function( actor )
	local dt = actor:GetScaledTime()
	local config = actor:GetTable().capturePointConfig
	local prevOwner = Owner
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local capturers = {}

	Capturing = nil
	
	if not actor:IsActive() then
	
		
		if config.cooldownEnabled then
			ApplyCooldown( dt, config.cooldownRate, config.threshold )
		end
		
	else
		
		
		if ruleset == nil or ruleset.GetPlayerFromGameObjectId == nil then
			return
		end
		
		
		local messageValet = actor:GetMessageValet()
		local message = nil
		repeat
			message = messageValet:PopMessage()
			if message then
				local messageType = message:GetType()
				if TrapHandler[messageType] then 
					TrapHandler[messageType] ( actor, message )
				else
					Fox.Error("Unhandled message received from trap.")
				end
			end
		until not message
		
		local isTeamSneak = ( Utils.TeamsneakId == vars.rulesetId or Utils.TeamsneakBaseId == vars.rulesetId )
		if isTeamSneak and Capturing ~= TeamSneak.defender then
			if flagEnterA and flagEnterA_OwnerId ~= nil then
				local player = ruleset:GetPlayerFromGameObjectId( flagEnterA_OwnerId )
				if player == nil then
					GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "neutralizedA" } )
					flagEnterA = false
					flagEnterA_OwnerId = nil
				end
			end
			if flagEnterB and flagEnterB_OwnerId ~= nil then
				local player = ruleset:GetPlayerFromGameObjectId( flagEnterB_OwnerId )
				if player == nil then
					GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "neutralizedB" } )
					flagEnterB = false
					flagEnterB_OwnerId = nil
				end
			end
		end
		
		
		local isContested = false
		local frontEnd = actor:GetTable().capturePointFrontend
		if frontEnd == nil then
			Fox.Error("Failed to get reference to capture point frontend; cannot determine valid capturers in trap.")
		else
			Capturing, capturers, isContested = frontEnd.ValidateCapturers( actor, this.PlayersInTrap, flagEnterA, flagEnterB )
			
			if isTeamSneak and Capturing ~= TeamSneak.defender then
				
				capturers = {}
				if flagEnterA and flagEnterA_OwnerId ~= nil then
					table.insert( capturers, flagEnterA_OwnerId )
				end
				if flagEnterB and flagEnterB_OwnerId ~= nil then
					table.insert( capturers, flagEnterB_OwnerId )
				end
			end
		end
	
		
		local capturerCount = 0
		for i, capturer in ipairs( capturers ) do
			capturerCount = capturerCount + 1
		end

		
		local isFullyCaptured = Direction ~= nil and CaptureValue == config.threshold
		if isFullyCaptured and config.stickyCaptureEnabled then
			
		elseif isContested then
			
		elseif capturerCount > 0 then
			
			local captureDelta = config.captureRate[ capturerCount ] * dt	
			local defense = false
			if isTeamSneak then
				if Capturing ~= TeamSneak.attacker then
					defense = true
				end
			end
			if (Direction == nil or Direction == Capturing) and not defense then
				
				CaptureValue = CaptureValue + captureDelta
			else
				
				
				if capturerCount < 5 then
					captureDelta = config.captureRate[ capturerCount + 1 ] * dt
				end
				CaptureValue = CaptureValue - captureDelta
			end
			
			
			if CaptureValue <= 0.0 then
				CaptureValue = 0.0
				Direction = nil
				Owner = nil
			elseif CaptureValue >= config.threshold then
				CaptureValue = config.threshold
				Direction = Capturing
				Owner = Capturing
			end
			
			
			if Direction == nil then
				Direction = Capturing
			end
		elseif capturerCount <= 0 and config.cooldownEnabled then
			ApplyCooldown( dt, config.cooldownRate, config.threshold )
		end
		
		
		if Owner ~= prevOwner then
			ForceRetransmit = true
		end
		
	end 

	
	BroadcastTick = BroadcastTick - dt
	if ForceRetransmit or BroadcastTick < 0 then
		BroadcastTick = BroadcastPeriod
		ForceRetransmit = false
			
		
		local capturerBitArray = 0x0
		local leadCapturerIndex = -1
		if ruleset ~= nil and ruleset.GetPlayerFromGameObjectId ~= nil then
			for i, capturerGameObjectId in ipairs( capturers ) do
				local capturer = ruleset:GetPlayerFromGameObjectId( capturerGameObjectId )
				if capturer ~= nil then
					local sessionIndex = capturer.sessionIndex
					capturerBitArray = Utils.SetFlag( capturerBitArray, sessionIndex + 1 )
				end
			end
			
			if capturers ~= nil and capturers[1] ~= nil then
				local leadCapturer = ruleset:GetPlayerFromGameObjectId( capturers[1] )
				leadCapturerIndex = leadCapturer.sessionIndex
			end
		end
				
		
		local captureRatio = CaptureValue / config.threshold
		TransmitState( actor, Direction, Owner, Capturing, captureRatio, actor:IsActive(), capturerBitArray, leadCapturerIndex )
	end
end


this.ExecuteIdle = function( actor )
	if Mgo.IsHost() then
		
		this.ExecuteHost( actor )
	end
end


this.ExecuteClient = function( actor )
	
	local messageValet = actor:GetMessageValet()
	local message = nil
	repeat
		message = messageValet:PopMessage()
	until not message
end

this.wasNeutralized = function()
	if flagEnterA == true then
		GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "neutralizedA" } )
	end
	if flagEnterB == true then
		GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "neutralizedB" } )
	end
	flagEnterA = false
	flagEnterB = false
	flagEnterA_OwnerId = nil
	flagEnterB_OwnerId = nil
end

this.ExecuteScript = function( actor, execParms )
	
	if execParms.command == "SetOwnerTeam" then
		if execParms.ownerTeam == nil then
			Direction = nil
			Owner = nil
			CaptureValue = 0.0
		else
			local config = actor:GetTable().capturePointConfig
			Direction = execParms.ownerTeam
			Owner = Direction
			CaptureValue = config.threshold
		end
		BroadcastTick = 0.0
	elseif "neutralized" == execParms.command then
		flagEnterA = false
		flagEnterB = false
		flagEnterA_OwnerId = nil
		flagEnterB_OwnerId = nil
	elseif "FlagPickupA" == execParms.command then
		flagEnterA = false
		flagEnterA_OwnerId = nil
		local ruleset = MpRulesetManager.GetActiveRuleset()
		for i, playerGameObjectId in ipairs( this.PlayersInTrap ) do
			local player = ruleset:GetPlayerFromGameObjectId( playerGameObjectId )
			if execParms.idx == player.sessionIndex then 
				flagEnterA = true
				flagEnterA_OwnerId = playerGameObjectId
			end
		end	
	elseif "FlagPickupB" == execParms.command then
		flagEnterB = false
		flagEnterB_OwnerId = nil
		local ruleset = MpRulesetManager.GetActiveRuleset()
		for i, playerGameObjectId in ipairs( this.PlayersInTrap ) do
			local player = ruleset:GetPlayerFromGameObjectId( playerGameObjectId )
			if execParms.idx == player.sessionIndex then 
				flagEnterB = true
				flagEnterB_OwnerId = playerGameObjectId
			end
		end	
	end
end

local GetPlayerIndexInTable = function( searchPlayer, table )
	
	for i, player in ipairs( table ) do
		if searchPlayer == player then
			return i
		end
	end
	
	
	return nil
end


ApplyCooldown = function( dt, cooldownRate, threshold )
	
	local cooldownDelta = cooldownRate * dt
	if Owner == nil or Owner ~= Direction then
		CaptureValue = CaptureValue - cooldownDelta
	else
		CaptureValue = CaptureValue + cooldownDelta
	end
	
	
	if CaptureValue <= 0.0 then
		CaptureValue = 0.0
		Direction = nil
		Owner = nil
	elseif CaptureValue >= threshold then
		CaptureValue = threshold
	end
end


TrapHandler = {
	Enter = function( actor, message )
		local playerGameObjectId = message:GetTriggerSource()
		local hasFlag, attachedActor = MgoActor.FindAttachedTo( playerGameObjectId )
		if GetPlayerIndexInTable( playerGameObjectId, this.PlayersInTrap ) ~= nil then
			Fox.Error( "TrapHandler[Enter]: Player already in trap." )
		elseif hasFlag then
			if attachedActor:GetParm().MarkerName == "A" then
				flagEnterA = true
				flagEnterA_OwnerId = playerGameObjectId
				GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "flagEnterA" } )
			else
				flagEnterB = true
				flagEnterB_OwnerId = playerGameObjectId
				GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "flagEnterB" } )
			end
			table.insert( this.PlayersInTrap, playerGameObjectId )
		else
			table.insert( this.PlayersInTrap, playerGameObjectId )
		end
	end,

	Exit = function( actor, message )
		local playerGameObjectId = message:GetTriggerSource()
		local index = GetPlayerIndexInTable( playerGameObjectId, this.PlayersInTrap );
		local hasFlag, attachedActor = MgoActor.FindAttachedTo( playerGameObjectId )
		
		if index == nil then
			Fox.Error( "TrapHandler[Exit]: Player not in trap." )
		elseif hasFlag then
			if attachedActor:GetParm().MarkerName == "A" then
				flagEnterA = false
				flagEnterA_OwnerId = nil
				GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "flagExitA" } )
			else
				flagEnterB = false
				flagEnterB_OwnerId = nil
				GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "flagExitB" } )
			end
			table.remove( this.PlayersInTrap, index )
		else
			table.remove( this.PlayersInTrap, index )
		end
	end,
}


TransmitState = function( actor, direction, owner, capturing, captureRatio, isActive, capturerIndexBitArray, leadCapturerIndex )
	local directionSerialize = direction
	local ownerSerialize = owner
	local capturingSerialize = capturing
	if directionSerialize == nil then
		directionSerialize = -1
	end
	if ownerSerialize == nil then
		ownerSerialize = -1
	end
	if capturingSerialize == nil then
		capturingSerialize = -1
	end
	local stream = MgoSerialize.NewStream( 49 )
	stream:SetMode("W")
	stream:SerializeBoolean( isActive )               
	stream:SerializeInteger( capturerIndexBitArray )  
	stream:SerializeInteger( leadCapturerIndex )      
	stream:SerializeNumber( ownerSerialize )          
	stream:SerializeNumber( directionSerialize )      
	stream:SerializeNumber( capturingSerialize )      
	stream:SerializeNumber( captureRatio )            
	MgoSignal.SendSignal( actor:GetGameObjectId(), Fox.StrCode32("ALL"), stream )	
end


return this
