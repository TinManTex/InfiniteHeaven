






if DEBUG then
	local pref = Preference.GetPreferenceEntity("TppWeaponPreference")
	if not Entity.IsNull(pref) then
		if pref.useTempParameterTable then
			TppVehicleMaterialInfoManager.ClearVehicleMaterialInfoTable()
			

			if TppVehicleMaterialInfoManager.LoadVehicleMaterialInfoTable( "/Assets/tpp/level_asset/vehicle/ParameterTables/VehicleMaterialInfo_temp.json" ) then



			else
				TppVehicleMaterialInfoManager.LoadVehicleMaterialInfoTable( "/Assets/tpp/level_asset/vehicle/ParameterTables/VehicleMaterialInfo.json" )
			end
			return
		end
	end
end

TppVehicleMaterialInfoManager.ClearVehicleMaterialInfoTable()
TppVehicleMaterialInfoManager.LoadVehicleMaterialInfoTable( "/Assets/tpp/level_asset/vehicle/ParameterTables/VehicleMaterialInfo.json" )

