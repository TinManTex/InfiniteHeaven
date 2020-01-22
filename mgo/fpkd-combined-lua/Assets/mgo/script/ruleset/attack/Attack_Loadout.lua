local this = {}



this.pushToParent = {}
this.resetFPSattackMode = false

this.Init = function( rulesetData, ruleset )
	return true
end

this.pushToParent.GetLoadoutProcessingFlags = function ( teamId )
	return TppMpBaseRuleset.LOADOUT_FLAG_USE_OVERRIDES + TppMpBaseRuleset.LOADOUT_FLAG_ADD_RULESET + TppMpBaseRuleset.LOADOUT_FLAG_VALIDATE_SAVED
end

this.pushToParent.ValidateCustomLoadout = function( teamId, fixupId, slotType, slotIndex )
	
	return true
end

this.pushToParent.FixupClassLoadout = function( teamId, classType, fixupId, slotType, slotIndex )
	if TppEquip.EQP_SWP_DirtyMag == fixupId or TppEquip.EQP_SWP_DirtyMag_G01 == fixupId then
		fixupId = Utils.FixUpSupportWeaponPlushySnare( teamId )
	end

	return fixupId
end

this.pushToParent.GetSpecialRoleLoadouts = function( specialRole )
	return Utils.GetSpecialRoleLoadouts( specialRole )
end

this.pushToParent.GetClassLoadouts = function( playerClass, teamIndex )
	local loadouts = {}
	local availableLoadouts = {}
	
	for k,v in ipairs( this.RulesetLoadouts ) do
		table.insert( availableLoadouts, v )
	end
	for k,v in ipairs( Utils.CommonAvailableLoadouts ) do
		table.insert( availableLoadouts, v )
	end
	
	for loadoutId = 1, #availableLoadouts do
		local loadout = availableLoadouts[ loadoutId ]
		for index,class in ipairs( loadout.compatibleClasses ) do
			if class == playerClass then
				table.insert( loadouts, loadout )
				break
			end
		end
	end

	return { ["loadouts"] = loadouts }
end


this.RulesetLoadouts = {
}





this.pushToParent.FetchLoadoutSkills = function( loadoutId )

	











	if loadoutId <= #this.AvailableLoadouts then
		local loadout = this.AvailableLoadouts[ loadoutId ]

		local skills = {}
		skills.skillConfig = loadout.skillConfig
		return skills
	else
		Fox.Error( "Invalid loadout ID " .. tostring( loadoutId ) .. " is sent to FetchLoadoutSkills." )
	end
end





this.pushToParent.SetupPlayerLoadout = function( rulesetData, ruleset, playerInstanceIndex, loadoutId, playerClassId )
	
	if not this.resetFPSattackMode then
			
		vars.fpsAttackMode = 0
		this.resetFPSattackMode = true
	end
end


return this
