--IvarsPersist.lua
--tex persistant/across mission vars ala gvars
--live values in igvars{} (global)
local this={
  inf_levelSeed=1,
  mis_isGroundStart=false,
  inf_event=false,--tex used as indicator whether save>ivars should be synced
--DEBUGNOW  
--  mbRepopDiamondCountdown=4,
--  --aacradar countdowns
--  cliffTown_aacr001=8,
--  commFacility_aacr001=8,
--  enemyBase_aacr001=8,
--  field_aacr001=8,
--  fort_aacr001=8,
--  powerPlant_aacr001=8,
--  remnants_aacr001=8,
--  slopedTown_aacr001=8,
--  sovietBase_aacr001=8,
--  tent_aacr001=8,
--  banana_aacr001=8,
--  diamond_aacr001=8,
--  flowStation_aacr001=8,
--  hill_aacr001=8,
--  pfCamp_aacr001=8,
--  savannah_aacr001=8,
--  swamp_aacr001=8,
}

--this.debugModule=true--DEBUGNOW

function this.PostAllModulesLoad()
  InfCore.LogFlow("Adding module persistIvars")
  for i,module in ipairs(InfModules) do
    if module.ivarsPersist then
      for name,default in pairs(module.ivarsPersist)do
        this[name]=default
      end
    end
  end
  --tex kill orphaned values from ih_save
  for name,value in pairs(igvars)do
    if this[name]==nil then
      InfCore.Log("WARNING: IvarsPersist.PostAllModulesLoad: Could not find igvar "..name..", deleting..")
      igvars[name]=nil
    end
  end
  
  if this.debugModule then
    InfCore.PrintInspect(this,"IvarsPersist")
    InfCore.PrintInspect(igvars,"igvars")
  end
end

--CALLER: InfInit --tex due to current execution flow cant have this update on module load since it will overwrite saved.
--CULL
function this.SetupVars()
  InfCore.LogFlow("IvarsPersist.SetupVars")
  for name,defaultValue in pairs(this) do
    if type(defaultValue)~="function" then
      igvars[name]=defaultValue
    end
  end
end

return this
