







if DEBUG then
	local pref = Preference.GetPreferenceEntity("TppWeaponPreference")
	if not Entity.IsNull(pref) then
		if pref.useTempRecoilParameterTable then
			TppRecoilMaterialParameterManager.ClearRecoilMaterialParameterTable()
			

			if TppRecoilMaterialParameterManager.LoadRecoilMaterialParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/RecoilMaterialParameter_temp.json" ) then



			else
				TppRecoilMaterialParameterManager.LoadRecoilMaterialParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/RecoilMaterialParameter.json" )
			end
			return
		end
	end
end

TppRecoilMaterialParameterManager.ClearRecoilMaterialParameterTable()
TppRecoilMaterialParameterManager.LoadRecoilMaterialParameterTable( "/Assets/tpp/level_asset/weapon/ParameterTables/RecoilMaterialParameter.json" )

