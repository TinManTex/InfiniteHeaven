local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local sequences = {}
















function this.OnLoad()
	Fox.Log("#### OnLoad ####")

	TppSequence.RegisterSequences{
		


		
		"Seq_Game_MainGame",
		"Seq_Game_MissionClear",
		nil
	}
	TppSequence.RegisterSequenceTable(sequences)
end
































































function this.MissionPrepare()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " MissionPrepare ***")

	
	
		
		
		
	
	
	local systemCallbackTable ={
		OnEstablishMissionClear = function()
			TppMission.MissionFinalize{ isFadeOut = true }
		end,
		OnEndMissionCredit = function()
			TppMission.MissionFinalize{ isFadeOut = true }
		end,
		OnEndMissionReward = function()
			TppMission.MissionFinalize{ isFadeOut = true }
		end,
		OnGameOver = function()
		end,
		nil
	}
	
	TppMission.RegiserMissionSystemCallback(systemCallbackTable)

end




function this.OnRestoreSVars()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " OnRestoreSVars ***")
end








function this.Messages()
	return
	StrCode32Table {
	
		
		Terminal = {
			{ msg = "MbDvcActAcceptMissionList", func = function( arg0, arg1 ) Fox.Log(arg0) Fox.Log(arg1) end, }
		},
		
	}
end





sequences.Seq_Demo_Opening = {

	OnEnter = function ()
	end,

	OnLeave = function ()
	end,

}

sequences.Seq_Game_MainGame = {


	OnEnter = function ()
	end,

	OnLeave = function ()
		
		TppMission.UpdateCheckPoint("CHK_TargetDown")
	end,

}



sequences.Seq_Game_MissionClear = {

	OnEnter = function ()
		
		
		local requestedMission = 10033	

		TppMission.ReserveMissionClear{
		nextMissionId = requestedMission ,
		missionClearType = TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER
		}
	end,
	OnLeave = function ()
	end,
}




return this