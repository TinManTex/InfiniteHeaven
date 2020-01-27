--InfMBAssets.lua
local this={}

function this.AddMissionPacks(missionCode,packPaths)
  if not Ivars.mbShowShips:EnabledForMission(missionCode) then
    return
  end

  packPaths[#packPaths+1]="/Assets/tpp/pack/mission2/ih/ih_ships.fpk"
end

return this
