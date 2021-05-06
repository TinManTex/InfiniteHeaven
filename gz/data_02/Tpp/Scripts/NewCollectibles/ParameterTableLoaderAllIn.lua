












local isLoaded = false
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



			isLoaded = true
		end
	end
end
if not isLoaded then
	TppDamageUtility.ClearAttackDamageTable()
	TppDamageUtility.LoadAttackDamageTable( "/Assets/tpp/level_asset/weapon/ParameterTables/AttackDamage.json" )
	TppDamageUtility.LoadAttackDamageTable( "/Assets/tpp/level_asset/weapon/ParameterTables/WeaponDamage.json" )
end



isLoaded = false
if DEBUG then
	local pref = Preference.GetPreferenceEntity("TppWeaponPreference")
	if not Entity.IsNull(pref) then
		if pref.useTempParameterTable then
			TppEquipmentParameterManager.ClearAllParameterTable()
			

			if TppEquipmentParameterManager.LoadGunBasicParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/GunBasicParameter_temp.json" ) then



			else
				TppEquipmentParameterManager.LoadGunBasicParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/GunBasicParameter.json" )
			end

			if TppEquipmentParameterManager.LoadBulletParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/BulletParameter_temp.json" ) then



			else
				TppEquipmentParameterManager.LoadBulletParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/BulletParameter.json" )
			end

			if TppEquipmentParameterManager.LoadReceiverParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/ReceiverParameter_temp.json" ) then



			else
				TppEquipmentParameterManager.LoadReceiverParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/ReceiverParameter.json" )
			end

			if TppEquipmentParameterManager.LoadMagazineParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/MagazineParameter_temp.json" ) then



			else
				TppEquipmentParameterManager.LoadMagazineParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/MagazineParameter.json" )
			end

			if TppEquipmentParameterManager.LoadBarrelParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/BarrelParameter_temp.json" ) then



			else
				TppEquipmentParameterManager.LoadBarrelParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/BarrelParameter.json" )
			end

			if TppEquipmentParameterManager.LoadScopeParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/ScopeParameter_temp.json" ) then



			else
				TppEquipmentParameterManager.LoadScopeParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/ScopeParameter.json" )
			end

			if TppEquipmentParameterManager.LoadShellParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/ShellParameter_temp.json" ) then



			else
				TppEquipmentParameterManager.LoadShellParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/ShellParameter.json" )
			end

			if TppEquipmentParameterManager.LoadBlastParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/BlastParameter_temp.json" ) then



			else
				TppEquipmentParameterManager.LoadBlastParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/BlastParameter.json" )
			end

			if TppEquipmentParameterManager.LoadSupportWeaponParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/SupportWeaponParameter_temp.json" ) then



			else
				TppEquipmentParameterManager.LoadSupportWeaponParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/SupportWeaponParameter.json" )
			end

			if TppEquipmentParameterManager.LoadWobblingParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/WobblingParameter_temp.json" ) then



			else
				TppEquipmentParameterManager.LoadWobblingParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/WobblingParameter.json" )
			end
			isLoaded = true
		end
	end
end
if not isLoaded then
	TppEquipmentParameterManager.ClearAllParameterTable()
	TppEquipmentParameterManager.LoadGunBasicParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/GunBasicParameter.json" )
	TppEquipmentParameterManager.LoadBulletParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/BulletParameter.json" )
	TppEquipmentParameterManager.LoadReceiverParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/ReceiverParameter.json" )
	TppEquipmentParameterManager.LoadMagazineParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/MagazineParameter.json" )
	TppEquipmentParameterManager.LoadBarrelParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/BarrelParameter.json" )
	TppEquipmentParameterManager.LoadScopeParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/ScopeParameter.json" )
	TppEquipmentParameterManager.LoadShellParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/ShellParameter.json" )
	TppEquipmentParameterManager.LoadBlastParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/BlastParameter.json" )
	TppEquipmentParameterManager.LoadSupportWeaponParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/SupportWeaponParameter.json" )
	TppEquipmentParameterManager.LoadWobblingParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/WobblingParameter.json" )
end



isLoaded = false
if DEBUG then
	local pref = Preference.GetPreferenceEntity("TppWeaponPreference")
	if not Entity.IsNull(pref) then
		if pref.useTempRecoilParameterTable then
			TppRecoilMaterialParameterManager.ClearRecoilMaterialParameterTable()
			

			if TppRecoilMaterialParameterManager.LoadRecoilMaterialParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/RecoilMaterialParameter_temp.json" ) then



			else
				TppRecoilMaterialParameterManager.LoadRecoilMaterialParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/RecoilMaterialParameter.json" )
			end
			isLoaded = true
		end
	end
end
if not isLoaded then
	TppRecoilMaterialParameterManager.ClearRecoilMaterialParameterTable()
	TppRecoilMaterialParameterManager.LoadRecoilMaterialParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/RecoilMaterialParameter.json" )
end



isLoaded = false
if DEBUG then
	local pref = Preference.GetPreferenceEntity("TppWeaponPreference")
	if not Entity.IsNull(pref) then
		if pref.useTempParameterTable then
			TppVehicleMaterialInfoManager.ClearVehicleMaterialInfoTable()
			

			if TppVehicleMaterialInfoManager.LoadVehicleMaterialInfoTable( "/Assets/tpp/level_asset/vehicle/ParameterTables/VehicleMaterialInfo_temp.json" ) then



			else
				TppVehicleMaterialInfoManager.LoadVehicleMaterialInfoTable( "/Assets/tpp/level_asset/vehicle/ParameterTables/VehicleMaterialInfo.json" )
			end

			isLoaded = true
		end
	end
end
if not isLoaded then
	TppVehicleMaterialInfoManager.ClearVehicleMaterialInfoTable()
	TppVehicleMaterialInfoManager.LoadVehicleMaterialInfoTable( "/Assets/tpp/level_asset/vehicle/ParameterTables/VehicleMaterialInfo.json" )
end

