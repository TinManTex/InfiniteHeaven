--InfPuppy.lua
local this={}

--LOCALOPT
local InfMain=InfMain
local SendCommand=GameObject.SendCommand

this.active=Ivars.mbEnablePuppy

this.packages={
  "/Assets/tpp/pack/mission2/ih/ih_puppy.fpk",
}

function this.Init()
  if not this.active:EnabledForMission() then
    return
  end

  if InfGameEvent.IsMbEvent() then
    return
  end

  local fv2Index=Ivars.mbEnablePuppy:Is()-1
  --fv2Index = 0--missing eye
  --fv2Index = 1--normal eyes

  local gameObjectId={type="TppBuddyPuppy",index=0}
  SendCommand(gameObjectId,{id="SetFova",fv2Index=fv2Index})
  SendCommand(gameObjectId,{id="SetFultonEnabled",enabled=false})
end

function this.AddMissionPacks(missionCode,packPaths)
  if not this.active:EnabledForMission(missionCode) then
    return
  end

  if InfGameEvent.IsMbEvent() then
    return
  end

  for i,packPath in ipairs(this.packages) do
    packPaths[#packPaths+1]=packPath
  end
end

return this
