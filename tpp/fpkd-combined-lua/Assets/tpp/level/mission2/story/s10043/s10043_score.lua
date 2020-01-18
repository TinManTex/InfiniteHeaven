
local this = {}

if vars.missionCode == 10043 then
    this.missionScoreTable = {
        baseTime = {
            S = 480, A = 576, B = 720, C = 1644, D = 2328, E = 3492
        },
        tacticalTakeDownPoint = { countLimit = 38 },
    }
else
    this.missionScoreTable = {
        baseTime = {
            S = 1200, A = 1500, B = 1950, C = 4080, D = 5460, E = 8190
        },
        tacticalTakeDownPoint = { countLimit = 38 },
    }
end

return this
