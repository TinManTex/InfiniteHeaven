local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local sequences = {}

this.SKIP_TEXTURE_LOADING_WAIT = true
this.NO_RESULT = true

function this.OnLoad()
	Fox.Log("#### OnLoad ####")
	local sequenceList = {}
	sequenceList = title_sequence.AddTitleSequences(sequenceList)
	TppSequence.RegisterSequences( sequenceList )
	sequences = title_sequence.AddTitleSequenceTable(sequences)
	TppSequence.RegisterSequenceTable(sequences)
end

function this.MissionPrepare()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** s00005 MissionPrepare ***")
	title_sequence.MissionPrepare()
	
	title_sequence.RegisterGameStatusFunction( this.EnableGameStatusFunction, this.DisableGameStatusFunction )
	title_sequence.RegisterTitleModeOnEnterFunction( this.TitleModeOnEnterFunction )
end

this.EnableGameStatusFunction = function()
	Fox.Log("Current mission is title! Do Nothing")
end

this.DisableGameStatusFunction = function()
	Fox.Log("Current mission is title! Do Nothing")
end

this.TitleModeOnEnterFunction = function()
	Fox.Log("Current mission is title! Do Nothing")
end

return this