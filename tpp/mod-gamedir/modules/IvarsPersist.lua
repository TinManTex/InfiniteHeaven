--IvarsPersist.lua
--tex persistant/across mission vars ala gvars
--live values in igvars{} (global)
local this={
  inf_levelSeed=1,
  mis_isGroundStart=false,
  inf_event=false,--tex used as indicator whether save>ivars should be synced
  mbRepopDiamondCountdown=4,
}

--CALLER: InfInit --tex due to current execution flow cant have this update on module load since it will overwrite saved.
function this.SetupVars()
  InfCore.LogFlow("IvarsPersist.SetupVars")
  for name,defaultValue in pairs(this) do
    if type(defaultValue)~="function" then
      igvars[name]=defaultValue
    end
  end
end

return this