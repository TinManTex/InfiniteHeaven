local this = {}

this.playerInJammingZone = false

this.AddParm = function(data)
    data:AddDynamicProperty("int8", "MarkerNum")
    data.MarkerNum = 0
end
 
this.RemoveParm = function(data)
    data:RemoveDynamicProperty("MarkerNum")
end


this.UpdateOwnership = function(index, ownerTeamIndex)
	
	if this.playerInJammingZone == false then
		return
	end
	
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local teamIndex = ruleset:GetLocalPlayerTeam()
	
	
	if ownerTeamIndex == nil then
		MgoMap.UnJam()
	elseif teamIndex == ownerTeamIndex then
		MgoMap.UnJam()
	else
		MgoMap.Jam()			
	end
end


this.MessageHandler = 
{
	
	Enter = function( actor, message )
		
		this.playerInJammingZone = true
		
		local ruleset = MpRulesetManager.GetActiveRuleset()			
		local teamIndex = ruleset:GetLocalPlayerTeam()
		
		if Domination_Exfil.currentOwnerTeam[actor:GetParm().MarkerNum] ~= nil then
			
			if Domination_Exfil.currentOwnerTeam[actor:GetParm().MarkerNum] ~= teamIndex then	
				MgoMap.Jam()
			else
				
				MgoMap.UnJam()
			end
		else
			
			MgoMap.UnJam()
		end
	end,

	Exit = function( actor, message )
		this.playerInJammingZone = false
		
		
		MgoMap.UnJam()
	end
}



local function ProcessMessages ( actor, messageHandler )

	local messageValet = actor:GetMessageValet()
	
	local message = messageValet:PopMessage()
	while message do

		local messageType = message:GetType()
		if messageHandler[messageType] then 
			messageHandler[messageType] ( actor, message )
		else
			Fox.Log("Unhandled message... ")
		end

		message = messageValet:PopMessage()
	end

end



this.Initialize = function( actor )
	
end
this.Construct = this.Reset
this.Reinitialize = this.Reset


this.Destruct = function ( actor )
end
this.Teardown = this.Destruct


this.Activate = function ( actor )
end


this.Deactivate = function ( actor )
end


this.Reset = function( actor )

end



this.ExecuteHost = function( actor )

	ProcessMessages( actor, this.MessageHandler )
	
end



this.ExecuteClient = function( actor )

	ProcessMessages( actor, this.MessageHandler )
	
end

this.ExecuteScript = function( actor, execParms )
	
	if execParms.command == "UpdateOwnership" then
		
		if actor:GetParm().MarkerNum == execParms.domPtIndex then
			this.UpdateOwnership(execParms.domPtIndex, execParms.teamIndex)
		end
	else
		local trap = GeoTrapBody.GetByName( "dom_map_scramble_trap000" .. execParms.command)
		trap.enable = false
		Util.SetInterval(2000, false, "mgoMapScramble", "EnableTrap", trap)
	end	
end

this.EnableTrap = function(trap)
	trap.enable = true
end



return this