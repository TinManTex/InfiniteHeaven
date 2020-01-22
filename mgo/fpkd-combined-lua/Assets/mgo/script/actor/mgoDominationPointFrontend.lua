local this = {}


local Flag_Type_Domination = 0x02
local Own_Flag_Conflict = 0x08
local Own_Flag_Neutral = 0x10
local Own_Flag_Friendly = 0x20
local Own_Flag_Enemy = 0x40
local Direction_Flag_Friendly = 0x100
local Direction_Flag_Enemy = 0x200
local Capturing_Flag_Friendly = 0x400
local Capturing_Flag_Enemy = 0x800
local Capturing_Flag_Self = 0x1000


local POI = nil
local Owner = nil
local Ratio = 0.0
local TimeDelta = 0
local OFF_DELTA = 0.01
local ON_DELTA = 0.02

local LastSmokeColerList = {}
local NeedUpdateSmokeList = {}


local UpdateUI
local UpdateSmokeFx
local UpdateSoundFx


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
			[1] = 10,
			[2] = 18,
			[3] = 24,
			[4] = 29,
			[5] = 33,
			[6] = 33,
			[7] = 33,
			[8] = 33,
		},
		stickyCaptureEnabled = false,	
		cooldownEnabled = true,			
		cooldownRate = 6,
	}
	
	
	if not POI then
		local genericPOITag = actor:GetParm().GenericPOITag
		local POIParm =	{
			type = TppPoi.POI_TYPE_GENERIC,
			tags = {
				"DOMINATION",
				"CONTROL_POINT",
				genericPOITag
			}
		}
		POI = Utils.POIinitialize( actor, POIParm )
	end
	
	
	Owner = nil
	Ratio = 0.0
	TimeDelta = 0
	local direction = nil
	local capturing = nil
	local isCapturingSelf = false
	local isActive = false
	
	
	UpdateUI( actor, Owner, direction, capturing, isCapturingSelf, Ratio, isActive )
	UpdateSmokeFx( actor, Owner, isActive, Ratio )
	NeedUpdateSmokeList[actor:GetParm().MarkerName] = false	
	UpdateSoundFx( actor, direction, Ratio )
	
	
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

this.ExecuteIdle = function( actor )
end


this.ExecuteHost = function( actor )
end


this.ExecuteClient = function( actor )
end


this.ExecuteScript = function( actor, execParms )
end


this.ProcessSignal = function( actor, stream )
	
	local isActive = false
	local direction = nil
	local capturing = nil
	local isCapturingSelf = false
	local prevOwner = Owner
	local capturerBitArray = 0x0
	local leadCapturerIndex = nil
	if stream == nil then
		direction = nil
		Owner = nil
		Ratio = 0.0
	else
		stream:SetMode("R")
		isActive = stream:SerializeBoolean( isActive )
		capturerBitArray = stream:SerializeInteger( capturerBitArray )
		leadCapturerIndex = stream:SerializeInteger( leadCapturerIndex )
		Owner = stream:SerializeNumber( Owner )
		direction = stream:SerializeNumber( direction )
		capturing = stream:SerializeNumber( capturing )
		Ratio = stream:SerializeNumber( Ratio )
		if leadCapturerIndex == -1 then
			leadCapturerIndex = nil
		end
		if direction == -1 then
			direction = nil
		end
		if Owner == -1 then
			Owner = nil
		end
		if capturing == -1 then
			capturing = nil
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
		end
	end

	
	UpdateUI( actor, Owner, direction, capturing, isCapturingSelf, Ratio, isActive )
	UpdateSmokeFx( actor, Owner, isActive, Ratio )
	UpdateSoundFx( actor, direction, Ratio )
		
	
	local wasJustNeutralized = (Owner ~= prevOwner and Owner == nil)
	local wasJustCaptured = (Owner ~= prevOwner and Owner ~= nil and Ratio == 1.0)
	if Mgo.IsHost() then
		
		
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
		
		
		local eventName = "Capturing"
		if(wasJustNeutralized) then
			eventName = "Neutral"
		elseif wasJustCaptured then
			eventName = "Captured"
		end
		local actorGameObjectId = actor:GetGameObjectId():GetId()
		local eventStream = MgoSerialize.NewStream(48)
		eventStream:SetMode("W")
		Utils.SerializeEvent( eventStream, actorGameObjectId, Fox.StrCode32(eventName), capturing, capturerBitArray )
		MgoSignal.SendSignal( ruleset:GetRulesetGameObjectId(), Fox.StrCode32("HOST"), eventStream )
	end
end





this.ValidateCapturers = function( actor, playersInTrap )
	local ruleset = MpRulesetManager.GetActiveRuleset()
	if ruleset == nil or ruleset.GetPlayerFromGameObjectId == nil then
		return nil, {}, false
	end	

	local capturingTeam = nil
	local capturers = {}
	local isContested = false
	local team1Count = 0
	local team2Count = 0

	
	for i, playerGameObjectId in ipairs( playersInTrap ) do
		local player = ruleset:GetPlayerFromGameObjectId( playerGameObjectId )
		if player ~= nil and player.teamIndex ~= nil then		
			if not PlayerInfo.OrCheckStatus( player.sessionIndex, { PlayerStatus.UNCONSCIOUS, PlayerStatus.CQC_HOLD_BY_ENEMY } ) then
				table.insert( capturers, playerGameObjectId )
				local playerTeamIndex = player.teamIndex 
				if playerTeamIndex == Utils.Team.SOLID then
					team1Count = team1Count + 1
				else
					team2Count = team2Count + 1
				end
			end
		end
	end
	
	if team1Count > 0 and team2Count > 0 then
		isContested = true
	end
	
	if team2Count > 0 then
		capturingTeam = Utils.Team.LIQUID
	elseif team1Count > 0 then
		capturingTeam = Utils.Team.SOLID
	end
	
	return capturingTeam, capturers, isContested
end


UpdateUI = function( actor, owner, direction, capturing, isCapturingSelf, ratio, isActive )
	if isActive then
		local ruleset = MpRulesetManager.GetActiveRuleset()
		local localTeam = nil
		if ruleset ~= nil and ruleset.GetLocalPlayerTeam ~= nil then
			localTeam = ruleset:GetLocalPlayerTeam()
		end

		local markerData = {}
		markerData.data = math.floor( 0.5 + (ratio * 255) )
		local ownFlag = Own_Flag_Enemy
		local directionFlag = Direction_Flag_Enemy
		local capturingFlag = Capturing_Flag_Enemy
		local capturingSelfFlag = 0
		if Entity.IsNull( ruleset ) or owner == nil or localTeam == nil then
			ownFlag = Own_Flag_Neutral
		elseif owner == localTeam then
			ownFlag = Own_Flag_Friendly
		end
		if Entity.IsNull( ruleset ) or direction == nil or localTeam == nil then
			directionFlag = 0
		elseif direction == localTeam then
			directionFlag = Direction_Flag_Friendly
		end
		if Entity.IsNull( ruleset ) or capturing == nil or localTeam == nil then
			capturingFlag = 0
		elseif capturing == localTeam then
			capturingFlag = Capturing_Flag_Friendly
		end
		if isCapturingSelf then
			capturingSelfFlag = Capturing_Flag_Self
		end

		markerData.flags = Flag_Type_Domination + ownFlag + directionFlag + capturingFlag + capturingSelfFlag
		if actor:GetParm().MarkerName == 'A' then
			markerData.goalType = 0
		elseif actor:GetParm().MarkerName == 'B' then
			markerData.goalType = 1
		elseif actor:GetParm().MarkerName == 'C' then
			markerData.goalType = 2
		end

		actor:EnableMarker( actor:GetParm().MarkerName )
		actor:UpdateMarker( markerData )
	else
		actor:DisableMarker()
	end
end


UpdateSoundFx = function( actor, direction, ratio )
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local localTeam = nil
	if ruleset ~= nil and ruleset.GetLocalPlayerTeam ~= nil then
		localTeam = ruleset:GetLocalPlayerTeam()
	end

	local soundObject = actor:GetParm().SoundObject
	if not Entity.IsNull( soundObject ) then
		local sourceBody = soundObject:GetDataBody()
		if not Entity.IsNull( sourceBody ) then
			if sourceBody:IsPlaying() then
				if direction == nil or direction == localTeam then
					sourceBody:SetSwitch( "DOMINATION_TEAM_OWNER", "FRIENDLY", 0 )
				else
					sourceBody:SetSwitch( "DOMINATION_TEAM_OWNER", "ENEMY", 0 )
				end
				sourceBody:SetRTPC( "DOMINATION_CAPTURE_RATIO", ratio, 0 )
			end
		end
	else
		Fox.Error( "No SoundObject is associated with this domination capture point; will not play capture point sounds." )
	end
end



UpdateSmokeFx = function( actor, owner, isActive, ratio )
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local localTeam = nil
	local updateColor = nil
	if ruleset ~= nil and ruleset.GetLocalPlayerTeam ~= nil then
		localTeam = ruleset:GetLocalPlayerTeam()
	else
		return
	end
	
	TimeDelta = TimeDelta + actor:GetScaledTime()
	
	if TimeDelta > OFF_DELTA and TimeDelta < ON_DELTA and ratio < 1 and ratio > 0 then
			TppDataUtility.SetVisibleEffectFromGroupId("domLightBlue_" .. actor:GetParm().MarkerName, false)
			TppDataUtility.SetVisibleEffectFromGroupId("domLightRed_" .. actor:GetParm().MarkerName, false)
			TppDataUtility.SetVisibleEffectFromGroupId("domLightWhite_" .. actor:GetParm().MarkerName, false)
			NeedUpdateSmokeList[actor:GetParm().MarkerName] = true
	else
		
		if owner ~= nil and owner == localTeam then
			updateColor = "domLightBlue_"
		elseif owner ~= nil and owner ~= localTeam then
			updateColor = "domLightRed_"
		elseif owner == nil or localTeam == nil then
			updateColor = "domLightWhite_"
		end
		
		if LastSmokeColerList[actor:GetParm().MarkerName] == nil then
			NeedUpdateSmokeList[actor:GetParm().MarkerName] = true
		end
		
		if updateColor ~= LastSmokeColerList[actor:GetParm().MarkerName] or NeedUpdateSmokeList[actor:GetParm().MarkerName] == true then
			
			if LastSmokeColerList[actor:GetParm().MarkerName] then
				TppDataUtility.SetVisibleEffectFromGroupId("domLightBlue_" .. actor:GetParm().MarkerName, false)
				TppDataUtility.SetVisibleEffectFromGroupId("domLightRed_" .. actor:GetParm().MarkerName, false)
				TppDataUtility.SetVisibleEffectFromGroupId("domLightWhite_" .. actor:GetParm().MarkerName, false)
			end
			LastSmokeColerList[actor:GetParm().MarkerName] = updateColor
			updateColor = updateColor..actor:GetParm().MarkerName
			TppDataUtility.SetVisibleEffectFromGroupId(updateColor, isActive)
			NeedUpdateSmokeList[actor:GetParm().MarkerName] = false
		else
			
		end
	end
	
	
	





























	
	if TimeDelta > ON_DELTA then
		TimeDelta = 0
	end
end


return this
