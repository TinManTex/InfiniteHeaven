-- InfUAV.lua
local this={}

this.packages={
  "/Assets/tpp/pack/mission2/ih/ih_uav.fpk",
}

function this.AddMissionPacks(missionCode,packPaths)
  if not Ivars.enableUAVMB:EnabledForMission() then
    return
  end

  for i,packPath in ipairs(this.packages) do
    packPaths[#packPaths+1]=packPath
  end
end

return this
