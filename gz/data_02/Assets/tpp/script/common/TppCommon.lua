local this = {}




this.RequiredFiles = {
	"/Assets/tpp/script/common/TppClock.lua",
	"/Assets/tpp/script/common/TppData.lua",

	"/Assets/tpp/script/common/TppDemo.lua",
	"/Assets/tpp/script/common/TppEffect.lua",
	"/Assets/tpp/script/common/TppEnemy.lua",
	"/Assets/tpp/script/common/TppGimmick.lua",
	"/Assets/tpp/script/common/TppHelicopter.lua",
	"/Assets/tpp/script/common/TppLocation.lua",
	"/Assets/tpp/script/common/TppMarker.lua",
	"/Assets/tpp/script/common/TppMission.lua",
	"/Assets/tpp/script/common/TppPlayer.lua",
	"/Assets/tpp/script/common/TppRadio.lua",
	"/Assets/tpp/script/common/TppSequence.lua",
	"/Assets/tpp/script/common/TppSound.lua",
	"/Assets/tpp/script/common/TppStaticModel.lua",
	"/Assets/tpp/script/common/TppTerminal.lua",
	"/Assets/tpp/script/common/TppTimer.lua",
	"/Assets/tpp/script/common/TppUI.lua",
	"/Assets/tpp/script/common/TppUtility.lua",
	"/Assets/tpp/script/common/TppWeather.lua",
}






this.Register = function( script, manager, type )
	type = type or "mission"

	
	TppSequence.Register( script, manager, type )
	TppTerminal.Start()

	
	if( type == "location" ) then
		TppLocation.Register( script )

	
	elseif( type == "mission" ) then
		TppDemo.Register( script.DemoList )
		TppMission.Register( script.missionID, script.MissionFlagList )
		TppRadio.Register( script.RadioList, script.OptionalRadioList, script.IntelRadioList )

		
		TppDemo.Start()
		TppMission.Start()
		TppRadio.Start()
		TppSound.Start()
		TppUI.Start()
	end
end


this.ShowDeprecatedFunctionErrors = false
this.DeprecatedFunction = function( useFunc )
	if( not DEBUG ) then return end
	if( this.ShowDeprecatedFunctionErrors == false ) then return end

	



	local level = 2
	while( true ) do
		local info = debug.getinfo( level )
		if( info == nil ) then break end

		if( info.what == "C" ) then
			print( "Calling function: C function" )
		else
			local gTable = TppUtility.SplitString( info.source, "/" )
			gTable = gTable[#gTable]
			gTable = TppUtility.SplitString( gTable, "%." )
			gTable = gTable[1]
			local name = info.name
			if( name ~= nil ) then



			else



			end
		end
		level = level + 1
	end



end




return this
