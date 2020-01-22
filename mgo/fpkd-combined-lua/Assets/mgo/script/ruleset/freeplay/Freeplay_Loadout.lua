local this = {}



this.pushToParent = {}
this.resetFPSattackMode = false

this.Init = function( rulesetData, ruleset )
	return true
end

this.pushToParent.GetLoadoutProcessingFlags = function ( teamIndex )
	return TppMpBaseRuleset.LOADOUT_FLAG_USE_OVERRIDES + TppMpBaseRuleset.LOADOUT_FLAG_ADD_RULESET
end

this.pushToParent.FixupClassLoadout = function( teamId, classType, fixupId, slotType, slotIndex )
	return fixupId
end





this.pushToParent.GetClassLoadouts = function( playerClass, teamIndex )
	local loadouts = {}
	local availableLoadouts = {}
	
	for k,v in ipairs( this.RulesetLoadouts ) do
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
	{
		DisplayName = "mgo_default_loadout_assault",
		attackerLoadout = false,
		compatibleClasses = { MGOPlayer.CLS_INFILTRATOR },
		weaponsConfig = {
			{ slot = TppDefine.WEAPONSLOT.PRIMARY_HIP,	id = TppEquip.EQP_WP_pvp_ar00_v00 },
			{ slot = TppDefine.WEAPONSLOT.PRIMARY_BACK,	id = TppEquip.EQP_None },
			{ slot = TppDefine.WEAPONSLOT.SECONDARY, 	id = TppEquip.EQP_WP_pvp_hg01_v00, 
				parts = { TppEquip.MO_10101, TppEquip.ST_None, TppEquip.ST_None, TppEquip.LT_None, TppEquip.LT_None, TppEquip.UB_None }, 
				color = { TppEquip.WEAPON_PAINT_DEFAULT, 0 } },
		},
		supportWeaponsConfig = {
		},
		itemConfig = {
			{ id = TppEquip.EQP_IT_CBox, },
		},
		skillConfig = {
		},
	},
	{
		DisplayName = "mgo_default_loadout_assault",
		attackerLoadout = false,
		compatibleClasses = { MGOPlayer.CLS_RECON },
		weaponsConfig = {
			{ slot = TppDefine.WEAPONSLOT.PRIMARY_HIP,	id = TppEquip.EQP_WP_pvp_ar00_v00 },
			{ slot = TppDefine.WEAPONSLOT.PRIMARY_BACK,	id = TppEquip.EQP_None },
			{ slot = TppDefine.WEAPONSLOT.SECONDARY, 	id = TppEquip.EQP_WP_pvp_hg01_v00, 
				parts = { TppEquip.MO_10101, TppEquip.ST_None, TppEquip.ST_None, TppEquip.LT_None, TppEquip.LT_None, TppEquip.UB_None }, 
				color = { TppEquip.WEAPON_PAINT_DEFAULT, 0 } },
		},
		supportWeaponsConfig = {
		},
		itemConfig = {
			{ id = TppEquip.EQP_IT_CBox, },
		},
		skillConfig = {
		},
	},
	{
		DisplayName = "mgo_default_loadout_assault",
		attackerLoadout = false,
		compatibleClasses = { MGOPlayer.CLS_TECHNICAL },
		weaponsConfig = {
			{ slot = TppDefine.WEAPONSLOT.PRIMARY_HIP,	id = TppEquip.EQP_WP_pvp_ar00_v00 },
			{ slot = TppDefine.WEAPONSLOT.PRIMARY_BACK,	id = TppEquip.EQP_None },
			{ slot = TppDefine.WEAPONSLOT.SECONDARY, 	id = TppEquip.EQP_WP_pvp_hg01_v00, 
				parts = { TppEquip.MO_10101, TppEquip.ST_None, TppEquip.ST_None, TppEquip.LT_None, TppEquip.LT_None, TppEquip.UB_None }, 
				color = { TppEquip.WEAPON_PAINT_DEFAULT, 0 } },
		},
		supportWeaponsConfig = {
		},
		itemConfig = {
			{ id = TppEquip.EQP_IT_CBox, },
		},
		skillConfig = {
		},
	},
}





this.pushToParent.SetupPlayerLoadout = function( rulesetData, ruleset, playerInstanceIndex, loadoutId, playerClassId )
	
	if not this.resetFPSattackMode then
			
		vars.fpsAttackMode = 0
		this.resetFPSattackMode = true
	end
end

return this
