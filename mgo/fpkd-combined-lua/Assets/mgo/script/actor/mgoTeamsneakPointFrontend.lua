local this = {}


local Flag_Type_Teamsneak = 0x04
local Own_Flag_Conflict = 0x08
local Own_Flag_Neutral = 0x10
local Own_Flag_Friendly = 0x20
local Own_Flag_Enemy = 0x40
local Capturing_Flag_Friendly = 0x400
local Capturing_Flag_Enemy = 0x800
local Capturing_Flag_Self = 0x1000


local POI = nil
local CommittedOwner = nil
local Ratio = 0.0
local soundPlaying = false


local UpdateSFX


this.AddParm = function(data)
    data:AddDynamicProperty("String", "MarkerName")
    data.MarkerName = "A"
	data:AddDynamicProperty("String", "GenericPOITag")
    data.GenericPOITag = "GENERIC_01"
    data:AddDynamicProperty("EntityLink", "SoundObject")
    data.SoundObject = nil
end

 
this.RemoveParm = function(data)
    data:RemoveDynamicProperty("MarkerName")
	data:RemoveDynamicProperty("GenericPOITag")
	data:RemoveDynamicProperty("SoundObject")
end


this.Construct = function( actor )

	
	actor:GetTable().capturePointFrontend = this
	
	
	actor:GetTable().capturePointConfig = {
		threshold = 120,
		captureRate = {
			[1] = 20,
			[2] = 120, 
			[3] = 120,
			[4] = 120,
			[5] = 120,
			[6] = 120,
			[7] = 120,
			[8] = 120,
		},
		stickyCaptureEnabled = true,	
		cooldownEnabled = true,			
		cooldownRate = 6,
	}
	
	
	if not POI then
		local genericPOITag = actor:GetParm().GenericPOITag
		local POIParm =	{
			type = TppPoi.POI_TYPE_GENERIC,
			tags = {
				"CONTROL_POINT",
				genericPOITag
			}
		}
		POI = Utils.POIinitialize( actor, POIParm )
	end
	
	
	CommittedOwner = nil
	Ratio = 0.0
	local soundPlaying = false
	local owner = nil
	local isActive = false
	
	
	UpdateUI( actor, owner, false, false, Ratio, isActive )
	this.UpdateSoundFx( actor, nil, Ratio )
	
	
	actor:SetActive( true )
end
this.Reset = this.Construct
this.Reinitialize = this.Construct
 

this.Destruct = function ( actor )
	
	Utils.POIdestruct( actor, POI )
	POI = nil
	
	
	actor:GetTable().capturePointFrontend = nil
	actor:GetTable().capturePointConfig = nil

	
	actor:SetActive( false )
end
this.Teardown = this.Destruct


this.Activate = function ( actor )
end


this.Deactivate = function ( actor )
end


this.ProcessSignal = function( actor, stream )
end


this.ExecuteIdle = function( actor )
end


this.ExecuteHost = function( actor )
end


this.ExecuteClient = function( actor )
end


this.ExecuteScript = function( actor, execParms )
end


this.ProcessSignal = function( actor, stream )
	
	local debugActorId = actor:GetGameObjectId():GetId()
	
	local isActive = false
	local owner = nil
	local prevCommittedOwner = CommittedOwner
	local capturing = nil
	local isCapturingSelf = false
	local isCapturing = false
	local capturerBitArray = 0x0
	local leadCapturerIndex = nil
	if stream == nil then
		owner = nil
		CommittedOwner = nil
		Ratio = 0.0
	else
		stream:SetMode("R")
		isActive = stream:SerializeBoolean( isActive )
		capturerBitArray = stream:SerializeInteger( capturerBitArray )
		leadCapturerIndex = stream:SerializeInteger( leadCapturerIndex )
		CommittedOwner = stream:SerializeNumber( CommittedOwner )
		owner = stream:SerializeNumber( owner )
		capturing = stream:SerializeNumber( capturing )
		Ratio = stream:SerializeNumber( Ratio )
		if leadCapturerIndex == -1 then
			leadCapturerIndex = nil
		end
		if owner == -1 then
			owner = nil
		end
		if CommittedOwner == -1 then
			CommittedOwner = nil
		end
	end

	local ruleset = MpRulesetManager.GetActiveRuleset()
	if ruleset == nil or ruleset.GetLocalPlayerSessionIndex == nil then
		Fox.Error( "ProcessSignal: Failed to get reference to ruleset." )
		return
	end
	local localPlayerIndex = ruleset:GetLocalPlayerSessionIndex()
	
	for sessionIndex = 0, 15 do
		if Utils.TestFlag( capturerBitArray, sessionIndex + 1 ) then
			if sessionIndex == localPlayerIndex then
				isCapturingSelf = true
			end
			isCapturing = true
		end
	end	

	
	
	
	UpdateUI( actor, TeamSneak.attacker, isCapturingSelf, isCapturing, Ratio, isActive )
	if ruleset.currentState ~= "RULESET_STATE_ROUND_REGULAR_PLAY"
		and ruleset.currentState ~= "RULESET_STATE_ROUND_OVERTIME"
		and ruleset.currentState ~= "RULESET_STATE_ROUND_SUDDEN_DEATH"
	then
		this.UpdateSoundFx( actor, capturing, 0 )
	else
		this.UpdateSoundFx( actor, capturing, Ratio )
	end
		
	
	local wasJustNeutralized = (Ratio == 0.0 and capturing == TeamSneak.defender and capturerBitArray ~= 0x0)
	local wasJustCaptured = (CommittedOwner ~= prevCommittedOwner and CommittedOwner ~= nil and Ratio == 1.0)
	if Mgo.IsHost() and (wasJustNeutralized or wasJustCaptured) then
		
		
		local capturers = {}
		if ruleset == nil or ruleset.GetPlayerBySessionIndex == nil then
			Fox.Error( "ProcessSignal: Failed to get reference to ruleset." )
			return
		end
		for sessionIndex = 0, 15 do
			if Utils.TestFlag( capturerBitArray, sessionIndex + 1 ) then
				local player = ruleset:GetPlayerBySessionIndex( sessionIndex )
				if player ~= nil then
					table.insert( capturers, player )
				end
			end
		end
		
		
		local leadCapturerGameObjectId = nil
		local leadCapturerTeamIndex = nil
		if leadCapturerIndex ~= nil then
			local leadCapturer = ruleset:GetPlayerBySessionIndex( leadCapturerIndex )
			leadCapturerGameObjectId = ruleset:GetGameObjectIdFromPlayer( leadCapturer ):GetId()
			leadCapturerTeamIndex = leadCapturer.teamIndex
		end
		
		
		local eventName = "Neutral"
		if wasJustCaptured then
			eventName = "Captured"
		elseif wasJustNeutralized then
			local backEnd = actor:GetTable().capturePointBackend
			backEnd.wasNeutralized()
		end
		local actorGameObjectId = actor:GetGameObjectId():GetId()
		local eventStream = MgoSerialize.NewStream(48)
		eventStream:SetMode("W")
		Utils.SerializeEvent( eventStream, actorGameObjectId, Fox.StrCode32(eventName), leadCapturerTeamIndex, leadCapturerGameObjectId )
		MgoSignal.SendSignal( ruleset:GetRulesetGameObjectId(), Fox.StrCode32("HOST"), eventStream )
	end
end





this.ValidateCapturers = function( actor, playersInTrap, flagEnterA, flagEnterB )
	local ruleset = MpRulesetManager.GetActiveRuleset()
	if ruleset == nil or ruleset.GetPlayerFromGameObjectId == nil then
		return nil, {}, false
	end	

	local capturingTeam = nil
	if flagEnterA or flagEnterB then
		capturingTeam = TeamSneak.attacker
	end
	local capturers = {}
	local isContested = false
	local attackerPresent = false
	local defenderPresent = false

	
	
	for i, playerGameObjectId in ipairs( playersInTrap ) do
		local player = ruleset:GetPlayerFromGameObjectId( playerGameObjectId )
		if player ~= nil and player.teamIndex ~= nil then		
			if flagEnterA or flagEnterB then
				table.insert( capturers, playerGameObjectId )
				if capturingTeam ~= player.teamIndex then
					defenderPresent = true
				else
					attackerPresent = true
				end
			end
		end
	end
	
	if defenderPresent and attackerPresent then
		isContested = true
	elseif defenderPresent then
		capturingTeam = TeamSneak.defender
	end
	
	return capturingTeam, capturers, isContested
end


UpdateUI = function( actor, owner, isCapturingSelf, isCapturing, ratio, isActive )
 	if isActive then
		local ruleset = MpRulesetManager.GetActiveRuleset()
		local localTeam = nil
		if ruleset ~= nil and ruleset.GetLocalPlayerTeam ~= nil then
			localTeam = ruleset:GetLocalPlayerTeam()
		end

		local markerData = {}
		markerData.data = math.floor( 0.5 + (ratio * 255) )
		local ownFlag = Own_Flag_Enemy
		local capturingFlag = 0
		if Entity.IsNull( ruleset ) or owner == nil or localTeam == nil then
			ownFlag = Own_Flag_Neutral
		elseif owner == localTeam then
			ownFlag = Own_Flag_Friendly
		end
		if isCapturingSelf then
			capturingFlag = Capturing_Flag_Self
		elseif isCapturing then
			if owner == localTeam then
				capturingFlag = Capturing_Flag_Friendly
			else
				capturingFlag = Capturing_Flag_Enemy
			end
		end
		markerData.flags = Flag_Type_Teamsneak + ownFlag + capturingFlag
	
		actor:EnableMarker( actor:GetParm().MarkerName )
		actor:UpdateMarker( markerData )
	else
		actor:DisableMarker()
	end
end

this.UpdateSoundFx = function( actor, direction, ratio )
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local localTeam = nil
	if ruleset ~= nil and ruleset.GetLocalPlayerTeam ~= nil then
		localTeam = ruleset:GetLocalPlayerTeam()
	end

	local soundObject = actor:GetParm().SoundObject
	if not Entity.IsNull( soundObject ) then
		local sourceBody = soundObject:GetDataBody()
		if not Entity.IsNull( sourceBody ) and ratio > 0 and ratio < 1 and soundPlaying == false then
			soundPlaying = true
			sourceBody:PostEvent("sfx_UI_Uploading_LP")
		elseif ratio <= 0 then
			soundPlaying = false
			sourceBody:StopEvent()
		elseif ratio >= 1 and soundPlaying == true then
			soundPlaying = false
			sourceBody:StopEvent()
			sourceBody:PostEvent("sfx_UI_Uploading_Complete_Sting")
		end
		if sourceBody:IsPlaying() then
			sourceBody:SetRTPC( "meters_pitch", ratio, 0 )
		end
	else
		Fox.Error( "No SoundObject is associated with this domination capture point; will not play capture point sounds." )
	end
end


return this
