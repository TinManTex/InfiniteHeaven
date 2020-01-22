local this = {}



this.pushToParent = {}
this.resetFPSattackMode = false

this.Init = function( rulesetData, ruleset )
	return true
end

this.pushToParent.GetLoadoutProcessingFlags = function ( teamIndex )
	return TppMpBaseRuleset.LOADOUT_FLAG_ADD_RULESET + TppMpBaseRuleset.LOADOUT_FLAG_USE_OVERRIDES + TppMpBaseRuleset.LOADOUT_FLAG_VALIDATE_SAVED
end

this.pushToParent.FixupClassLoadout = function( teamId, classType, fixupId, slotType, slotIndex )
	if "Primary1" == slotType or "Primary2" == slotType or "Secondary" == slotType or "Support" == slotType then
		local ruleset = MpRulesetManager.GetActiveRuleset()
		local lethal = ruleset:IsWeaponLethal( fixupId )

		if (lethal == false and teamId == TeamSneak.defender) or (lethal == true and teamId == TeamSneak.attacker) then
			fixupId = TppEquip.EQP_None
		end
	end

	if "Support" == slotType and TppEquip.EQP_SWP_DirtyMag == fixupId or TppEquip.EQP_SWP_DirtyMag_G01 == fixupId then
		fixupId = Utils.FixUpSupportWeaponPlushySnare( teamId )
	end
	
	if "Item" == slotType and teamId == TeamSneak.attacker and TppEquip.EQP_IT_MGO_PersonalCamo == fixupId then
		fixupId = TppEquip.EQP_None
	end
	
	if "Item" == slotType and slotIndex == 3 and teamId == TeamSneak.attacker then
		fixupId = TppEquip.EQP_IT_MGO_StealthCamo
	end

	return fixupId
end

this.pushToParent.GetSpecialRoleLoadouts = function( specialRole )
	return Utils.GetSpecialRoleLoadouts( specialRole )
end


this.pushToParent.GetClassLoadouts = function( playerClass, teamIndex )
	local loadouts = {}
	local availableLoadouts = {}
	
	for k,v in ipairs( Utils.CommonAvailableLoadouts ) do
		table.insert( availableLoadouts, v )
	end
	
	for loadoutId = 1, #availableLoadouts do
		local loadout = availableLoadouts[ loadoutId ]
		if ( this.owner.attacker == teamIndex and loadout.attackerLoadout ~= false ) or ( this.owner.attacker ~= teamIndex and loadout.attackerLoadout ~= true ) then
			for index,class in ipairs( loadout.compatibleClasses ) do
				if class == playerClass then
					table.insert( loadouts, loadout )
					break
				end
			end
		end
	end

	return { ["loadouts"] = loadouts }
end






this.pushToParent.SetupPlayerLoadout = function( rulesetData, ruleset, playerInstanceIndex, loadoutId, playerClassId )
	if not this.resetFPSattackMode then
			
		vars.fpsAttackMode = 0
		this.resetFPSattackMode = true
	end
end
	
return this
