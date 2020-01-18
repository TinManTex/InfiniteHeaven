

local this = {}

if vars.missionCode == 10140 then
	this.missionScoreTable = {
		baseTime = {
			
			
			
			
			S = 540, A = 600, B = 690, C = 780, D = 900, E = 1800, 		
		},
		tacticalTakeDownPoint = { countLimit = 15 },
	}
else
	this.missionScoreTable = {
		baseTime = {
			
			
			
			
			
			S = 840, A = 860, B = 890, C = 980, D = 1100, E = 2000, 
		},
		tacticalTakeDownPoint = { countLimit = 15 },
	}
end


return this
