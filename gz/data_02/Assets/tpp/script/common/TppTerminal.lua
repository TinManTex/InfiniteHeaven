local this = {}




this.TerminalMenu = {
	
	MotherBase							= "top_motherbase",
	MissionList							= "top_missionlist",
	DataBase							= "mb_database",

	
	MotherBase_Staff					= "mb_staff",
	MotherBase_Develop					= "mb_develop",
	MotherBase_CombatDeployment			= "cmd_combatdeployment",
	MotherBase_Support					= "mb_support",
	MotherBase_Security					= "cmd_security",
	MotherBase_Union					= "mb_union",

	DataBase_PlayerData					= "dbs_playerdata",
	DataBase_MotherBaseData				= "dbs_motherbasedata",
	DataBase_Information				= "dbs_information",

	
	MotherBase_Develop_Weapon			= "dev_weapon",
	MotherBase_Develop_SupportWeapon	= "dev_supportweapon",
	MotherBase_Develop_Bullet			= "dev_bullet",
	MotherBase_Develop_Item				= "dev_item",
	MotherBase_Develop_Suits			= "dev_suits",
	MotherBase_Develop_Mecha			= "dev_mecha",



	MotherBase_Develop_Plant			= "dev_plant",

	MotherBase_Support_Goods			= "spt_goods",
	MotherBase_Support_Weapon			= "spt_weapon",
	MotherBase_Support_SupportWeapon	= "spt_supportweapon",
	MotherBase_Support_Vehicle			= "spt_vehicle",
	MotherBase_Support_Unmanned			= "spt_unmanned",

	MotherBase_Union_Rental				= "stf_rental",

	
	Strike								= "mb_strike",
	Order								= "top_call",

	
	Strike_ArtilleryRequest				= "str_artilleryrequest",
	Strike_SmokeRequest					= "str_smokerequest",
	Strike_SupplyRequest				= "str_supplyrequest",
	Strike_VehicleRequest				= "str_vehiclerequest",
	Strike_JammingRequest				= "str_jammingrequest",

	Order_Helicopter					= "cll_retreat",
	Order_Quiet							= "cll_quiet",
	Order_DDog							= "cll_ddog",
}

this.MotherBaseUnitList = {
	All				= "MB_UNIT_ID_ALL",

	Unit_Combat		= "MB_UNIT_ID_COMBAT",
	Unit_Develop	= "MB_UNIT_ID_DEVELOP",
	Unit_Intel		= "MB_UNIT_ID_INTELLIGENCE",
	Unit_Medical	= "MB_UNIT_ID_MEDICAL",
	Unit_Support	= "MB_UNIT_ID_SUPPORT",
	Unit_MBDevelop	= "MB_UNIT_ID_BASE_DEV",
	Unit_Security	= "MB_UNIT_ID_SECURITY",

	Room_Waiting	= "MB_UNIT_ID_WAITING",
	Room_Hospital	= "MB_UNIT_ID_PLACE_MEDICAL",
	Room_Isolation	= "MB_UNIT_ID_ISOLATION",
	Room_Jail		= "MB_UNIT_ID_GUARD_HOUSE",
	Room_Trade		= "MB_UNIT_ID_TRADE",
}

this.ControlModeList = {
	LockCloseByCancellingMode	= 0,
}






this.Setup = function()
	
	TppMotherBaseManager:GetInstance():ResetIntelligenceUnitSearchCp()
end


this.ShowMenu = function( menuID )
	TppCommon.DeprecatedFunction( "UiCommonDataManager:GetInstance():GetUiLuaExportCommonData():SetTopMenuItemVisible( menuID, true )" )
	this._DoMenu( menuID, "show", true )
end


this.HideMenu = function( menuID )
	TppCommon.DeprecatedFunction( "UiCommonDataManager:GetInstance():GetUiLuaExportCommonData():SetTopMenuItemVisible( menuID, false )" )
	this._DoMenu( menuID, "show", false )
end


this.ActivateMenu = function( menuID )
	TppCommon.DeprecatedFunction( "UiCommonDataManager:GetInstance():GetUiLuaExportCommonData():SetTopMenuItemActive( menuID, true )" )
	this._DoMenu( menuID, "activate", true )
end


this.DeactivateMenu = function( menuID )
	TppCommon.DeprecatedFunction( "UiCommonDataManager:GetInstance():GetUiLuaExportCommonData():SetTopMenuItemActive( menuID, false )" )
	this._DoMenu( menuID, "activate", false )
end


this.EnableUnit = function( unitID )
	TppCommon.DeprecatedFunction( "TppMotherBaseManager:GetInstance():GetCoreContainer():SetUnitActive( unitID, true )" )
	this._DoUnit( unitID, "enable", true )
end


this.DisableUnit = function( unitID )
	TppCommon.DeprecatedFunction( "TppMotherBaseManager:GetInstance():GetCoreContainer():SetUnitActive( unitID, false )" )
	this._DoUnit( unitID, "enable", false )
end


this.EnableDevelopWeapon = function( weaponID )
	TppCommon.DeprecatedFunction( "UiCommonDataManager:GetInstance():GetUiLuaExportCommonData():SetActiveTestDevelopWeapon( weaponID, true )" )
	this._DoDevelopWeapon( weaponID, "enable", true )
end


this.DisableDevelopWeapon = function( weaponID )
	TppCommon.DeprecatedFunction( "UiCommonDataManager:GetInstance():GetUiLuaExportCommonData():SetActiveTestDevelopWeapon( weaponID, false )" )
	this._DoDevelopWeapon( weaponID, "enable", false )
end


this.EnableControlMode = function( controlMode )
	TppCommon.DeprecatedFunction( "UiCommonDataManager:GetInstance():GetUiLuaExportCommonData():SetEnableMenuCancelClose( true )" )
	this._DoControlMode( controlMode, "enable", false )
end


this.DisableControlMode = function( controlMode )
	TppCommon.DeprecatedFunction( "UiCommonDataManager:GetInstance():GetUiLuaExportCommonData():SetEnableMenuCancelClose( false )" )
	this._DoControlMode( controlMode, "enable", true )
end


this.AddStaff = function( staffNum, unitID )
	TppCommon.DeprecatedFunction( "TppMotherBaseManager:GetInstance():AddDefaultStaff( staffNum, unitID )" )
	unitID = unitID or "All"
	if( this._IsValid( "MotherBaseUnitList", unitID ) == false ) then return end
	local unit = this.MotherBaseUnitList[unitID]
	this.m_mbManager:AddDefaultStaff( staffNum, unit )
end


this.DeleteAllStaff = function()
	TppCommon.DeprecatedFunction( "TppMotherBaseManager:GetInstance():DeleteAllStaffs()" )
	this.m_mbManager:DeleteAllStaffs()
end


this.StartIntelEnemySearch = function( cpID )
	TppCommon.DeprecatedFunction( "TppMotherBaseManager:GetInstance():SetIntelligenceUnitSearchCp( cpID )" )
	this.m_mbManager:SetIntelligenceUnitSearchCp( cpID )
end


this.StopIntelEnemySearch = function()
	TppCommon.DeprecatedFunction( "TppMotherBaseManager:GetInstance():ResetIntelligenceUnitSearchCp()" )
	this.m_mbManager:ResetIntelligenceUnitSearchCp()
end






this.Start = function()
	
	this.m_mbManager = TppMotherBaseManager:GetInstance()
	if( this.m_mbManager == NULL ) then



		return
	end

	this.m_mbContainer = this.m_mbManager:GetCoreContainer()
	if( this.m_mbContainer == NULL ) then



		return
	end

	
	this.m_cdManager = UiCommonDataManager:GetInstance()
	if( this.m_cdManager == NULL ) then



		return
	end

	this.m_luaData = this.m_cdManager:GetUiLuaExportCommonData()
	if( this.m_luaData == NULL ) then



		return
	end
end






this._IsValid = function( checkTable, checkID )
	if( this[checkTable][checkID] == nil ) then



		return false
	end
	return true
end


this._DoMenu = function( menuID, action, isDo )
	
	if( menuID == "AllMenu" ) then
		
		
		local doFunc
		if( action == "show" ) then
			doFunc = this.m_luaData.InitAllTopMenuItemVisible
		elseif( action == "activate" ) then
			doFunc = this.m_luaData.InitAllTopMenuItemActive
		else



			return
		end

		doFunc( this.m_luaData, isDo )

	
	else
		if( this._IsValid( "TerminalMenu", menuID ) == false ) then return end

		
		local doFunc
		if( action == "show" ) then
			doFunc = this.m_luaData.SetTopMenuItemVisible
		elseif( action == "activate" ) then
			doFunc = this.m_luaData.SetTopMenuItemActive
		else



			return
		end

		doFunc( this.m_luaData, this.TerminalMenu[menuID], isDo )
	end
end


this._DoUnit = function( unitID, action, isDo )
	
	if( unitID == "AllUnit" ) then
		unitID = "All"
	end

	
	if( this._IsValid( "MotherBaseUnitList", unitID ) == false ) then return end

	
	local doFunc
	if( action == "enable" ) then
		doFunc = this.m_mbContainer.SetUnitActive
	else



		return
	end

	local unit = this.MotherBaseUnitList[unitID]
	doFunc( this.m_mbContainer, unit, isDo )
end


this._DoDevelopWeapon = function( weaponID, action, isDo )
	
	if( weaponID == "AllWeapon" ) then
		
		
		local doFunc
		if( action == "enable" ) then
			doFunc = this.m_luaData.SetActiveAllTestDevelopWeapon
		else



			return
		end

		doFunc( this.m_luaData, isDo )

	
	else
		if( weaponID == nil ) then return end

		
		local doFunc
		if( action == "enable" ) then
			doFunc = this.m_luaData.SetActiveTestDevelopWeapon
		else



			return
		end

		doFunc( this.m_luaData, weaponID, true )
	end
end


this._DoControlMode = function( controlMode, action, isDo )
	if( this._IsValid( "ControlModeList", controlMode ) == false ) then return end

	
	local doFunc
	if( action == "enable" ) then
		doFunc = this.m_luaData.SetEnableMenuCancelClose
	else



		return
	end

	doFunc( this.m_luaData, isDo )
end




this.m_mbManager = nil
this.m_mbContainer = nil
this.m_cdManager = nil
this.m_luaData = nil




return this
