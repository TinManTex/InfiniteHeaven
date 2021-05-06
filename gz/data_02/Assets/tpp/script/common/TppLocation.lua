local this = {}





local onEnterClearAreaTrap = function()
	local trapName = TppEventSequenceManagerCollector.GetMessageArg( 3 )
	if( TppUtility.IsIncluded( this.m_clearAreaTraps, trapName ) == false ) then return end

	this.SetFlag( "_isPlayerInClearAreaTrap", true )
	TppMission.OnEnterClearAreaTrap()
end

local onExitClearAreaTrap = function()
	local trapName = TppEventSequenceManagerCollector.GetMessageArg( 3 )
	if( TppUtility.IsIncluded( this.m_clearAreaTraps, trapName ) == false ) then return end

	this.SetFlag( "_isPlayerInClearAreaTrap", false )
	TppMission.OnExitClearAreaTrap()
end

local onEnterIntelSearchAreaTrap = function()
	local trapName = TppEventSequenceManagerCollector.GetMessageArg( 3 )
	if( TppUtility.IsIncluded( this.m_intelSearchAreaTraps, trapName ) == false ) then return end

	
	local baseName = TppUtility.SplitString( trapName, "_" )
	local baseType = baseName[2]
	baseType = TppUtility.SplitString( baseType, "IntelSearchArea" )
	baseType = baseType[1]
	baseName = baseName[#baseName]
	local ID = this.m_name .. "_" .. baseName .. "_" .. baseType

	if( Ch.FindCharacterObjectByCharacterId( ID ) == nil ) then return end
	TppMotherBaseManager:GetInstance():SetIntelligenceUnitSearchCp( ID )
end

local onExitIntelSearchAreaTrap = function()
	local trapName = TppEventSequenceManagerCollector.GetMessageArg( 3 )
	if( TppUtility.IsIncluded( this.m_intelSearchAreaTraps, trapName ) == false ) then return end

	TppMotherBaseManager:GetInstance():ResetIntelligenceUnitSearchCp()
end





this.Messages = {
	Trap = {
		
		{ message = "Enter", commonFunc = onEnterClearAreaTrap },
		{ message = "Exit", commonFunc = onExitClearAreaTrap },
		
		{ message = "Enter", commonFunc = onEnterIntelSearchAreaTrap },
		{ message = "Exit", commonFunc = onExitIntelSearchAreaTrap },
	},
}






this.Setup = function()
	
	local times = this.m_times or {}
	if( times.day ~= nil ) then
		TppClock.RegisterClockMessage( times.day, "_locationDayTime", "location" )
	end
	if( times.night ~= nil ) then
		TppClock.RegisterClockMessage( times.night, "_locationNightTime", "location" )
	end

	
	for i = 1, #this.m_cpNames do
		local trapName = "trap_cpClearArea_" .. this.m_cpNames[i]
		table.insert( this.m_clearAreaTraps, trapName )

		trapName = "trap_cpIntelSearchArea_" .. this.m_cpNames[i]
		table.insert( this.m_intelSearchAreaTraps, trapName )
	end

	
	for i = 1, #this.m_obNames do
		local trapName = "trap_obClearArea_" .. this.m_obNames[i]
		table.insert( this.m_clearAreaTraps, trapName )

		trapName = "trap_obIntelSearchArea_" .. this.m_obNames[i]
		table.insert( this.m_intelSearchAreaTraps, trapName )
	end
end


this.GetLocationName = function()
	return this.m_name
end


this.GetTimes = function()
	return this.m_times
end


this.GetCommandPostNames = function()
	return this.m_cpNames
end


this.GetCommandPostIDs = function()
	return this.m_cpIDs
end


this.GetOuterBaseNames = function()
	return this.m_obNames
end


this.GetOuterBaseIDs = function()
	return this.m_obIDs
end


this.GetDefaultRouteSets = function()
	return this.m_defaultRouteSets
end


this.GetFlag = function( flagName )
	return this.m_flagList[flagName]
end


this.SetFlag = function( flagName, value )
	this.m_flagList[flagName] = value
end


this.AddClearAreaTrap = function( trapName )
	table.insert( this.m_clearAreaTraps, trapName )
end


this.DeleteClearAreaTrap = function( trapName )
	local index = TppUtility.GetValueIndex( this.m_clearAreaTraps, trapName )
	if( index == nil ) then



		return
	end
	table.remove( this.m_clearAreaTraps, index )
end


this.AddIntelSearchAreaTrap = function( trapName )
	table.insert( this.m_intelSearchAreaTraps, trapName )
end


this.DeleteIntelSearchAreaTrap = function( trapName )
	local index = TppUtility.GetValueIndex( this.m_intelSearchAreaTraps, trapName )
	if( index == nil ) then



		return
	end
	table.remove( this.m_intelSearchAreaTraps, index )
end





this.Register = function( script )
	this.m_name = script.LocationName
	this.m_times = script.Times

	
	this.m_cpNames = script.CommandPostNames
	for i = 1, #this.m_cpNames do
		local cp = this.m_name .. "_" .. this.m_cpNames[i] .. "_cp"
		table.insert( this.m_cpIDs, cp )
	end

	
	this.m_obNames = script.OuterBaseNames
	for i = 1, #this.m_obNames do
		local ob = this.m_name .. "_" .. this.m_obNames[i] .. "_ob"
		table.insert( this.m_obIDs, ob )
	end

	this.m_defaultRouteSets = script.DefaultRouteSets
	this.m_flagList = script.LocationFlagList
end




this.m_name = nil
this.m_times = {}

this.m_cpNames = {}
this.m_cpIDs = {}

this.m_obNames = {}
this.m_obIDs = {}

this.m_defaultRouteSets = {}
this.m_flagList = {}
this.m_clearAreaTraps = {}
this.m_intelSearchAreaTraps = {}




return this
