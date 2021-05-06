




TppTrapExecMissionClear = {

	Exec = function( info )

		
		if info.trapFlagString == "GEO_TRAP_S_ENTER" then

			local lm = TppLocationManager:GetInstance()
			local value = lm:GetEventFlagValue("missionEventFlag_readyToClear")

			if value == 1 then



				local missionManager = TppMissionManager:GetInstance()
				missionManager:RequestMissionClear()

			end
		end
		return 1

	end,

}

