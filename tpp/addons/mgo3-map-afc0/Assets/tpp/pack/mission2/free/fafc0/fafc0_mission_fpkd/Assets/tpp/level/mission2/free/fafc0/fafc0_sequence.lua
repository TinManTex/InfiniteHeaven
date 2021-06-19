local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local GetGameObjectId = GameObject.GetGameObjectId
local SendCommand = GameObject.SendCommand
local NULL_ID = GameObject.NULL_ID

this.NO_RESULT = true

local sequences = {}

function this.OnUpdate()

end

function this.OnLoad()
	Fox.Log("#### OnLoad ####")

	local sequenceNameList = {
		"Seq_Game_Setup",
		"Seq_Game_MainGame",
	}

	
	TppSequence.RegisterSequences(sequenceNameList)
	TppSequence.RegisterSequenceTable(sequences)
end

this.saveVarsList = {
}

this.baseList = {
	nil
}

function this.MissionPrepare()
	do 
		local missionName = TppMission.GetMissionName()
		InfCore.Log("*** " .. tostring(missionName) .. " MissionPrepare ***")--tex DEBUG
	end
	
	local systemCallbackTable ={
		OnEstablishMissionClear = function( missionClearType )
			TppMission.MissionGameEnd()
		end,
		OnDisappearGameEndAnnounceLog = function()
			Player.SetPause()
			TppMission.ShowMissionReward()
		end,
		OnEndMissionReward = function()
				TppMission.MissionFinalize{ isNoFade = true }
		end,
	}

	
	TppMission.RegisterMissionSystemCallback(systemCallbackTable)
end

function this.OnEndMissionPrepareSequence()

end

function this.OnRestoreSVars()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " OnRestoreSVars ***")
end

function this.Messages()
	return
	StrCode32Table {
	}
end

sequences.Seq_Game_Setup = {
	OnEnter = function()

	end,
	OnUpdate = function()
			TppSequence.SetNextSequence("Seq_Game_MainGame")
	end,
	OnLeave = function()
			TppMain.EnableAllGameStatus()
			TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "OnEndGameStartFadeIn" )
	end,
}


sequences.Seq_Game_MainGame = {
	Messages = function( self ) 
		return
		StrCode32Table {
		}
	end,
	OnEnter = function()
		InfCore.Log("Seq_Game_MainGame OnEnter")--tex DEBUG
	end,
	OnUpdate = function()
		
	end,
	OnLeave = function()

	end,
}

return this
