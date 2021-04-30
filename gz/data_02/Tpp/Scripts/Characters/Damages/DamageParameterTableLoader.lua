







if DEBUG then
	local pref = Preference.GetPreferenceEntity("TppWeaponPreference")
	if not Entity.IsNull(pref) then
		if pref.useTempDamageTable then
			TppDamageUtility.ClearAttackDamageTable()
			
			if not TppDamageUtility.LoadAttackDamageTable( "/Assets/tpp/level_asset/weapon/ParameterTables/AttackDamage_temp.json" ) then
				TppDamageUtility.LoadAttackDamageTable( "/Assets/tpp/level_asset/weapon/ParameterTables/AttackDamage.json" )
			end
			if not TppDamageUtility.LoadAttackDamageTable( "/Assets/tpp/level_asset/weapon/ParameterTables/WeaponDamage_temp.json" ) then
				TppDamageUtility.LoadAttackDamageTable( "/Assets/tpp/level_asset/weapon/ParameterTables/WeaponDamage.json" )
			end



			return
		end
	end
end

TppDamageUtility.ClearAttackDamageTable()
TppDamageUtility.LoadAttackDamageTable( "/Assets/tpp/level_asset/weapon/ParameterTables/AttackDamage.json" )
TppDamageUtility.LoadAttackDamageTable( "/Assets/tpp/level_asset/weapon/ParameterTables/WeaponDamage.json" )

