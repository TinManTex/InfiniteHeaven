
local this = {}

if vars.missionCode == 10010 then
	this.missionScoreTable = {
		baseTime = {
			S = 1800, A = 4500, B = 5400, C = 10380, D = 13560, E = 20340,
		},
		tacticalTakeDownPoint = { countLimit = 40, },
	}
else
	this.missionScoreTable = {
		baseTime = {
			S = 1680, A = 1884, B = 2190, C = 4080, D = 5460, E = 8190,
		},
		tacticalTakeDownPoint = { countLimit = 40, },
	}
end

return this
