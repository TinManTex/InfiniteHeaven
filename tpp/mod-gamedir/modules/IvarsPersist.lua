--IvarsPersist.lua
--tex persistant/across mission vars ala gvars
--live values in igvars{} (global)
--DEBUGNOW: BuildSaveText doesnt support strings? (needs to add quotes)
local this={
  inf_levelSeed=1,
  mis_isGroundStart=false,
  inf_event=false,--tex used as indicator whether save>ivars should be synced
  bodyType="",
  bodyTypeExtend="",
}

--this.debugModule=false--GOTCHA since vars are at module level it will see this as a persistvar 

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

  --tex populate igvars if the var isn't already there
  for name,value in pairs(this)do
    if type(value)~="function" then
      if igvars[name]==nil then
        igvars[name]=value
      end
    end
  end

  if this.debugModule then
    InfCore.PrintInspect(this,"IvarsPersist")
    InfCore.PrintInspect(igvars,"igvars")
  end
end

--CULL
--CALLER: InfInit --tex due to current execution flow cant have this update on module load since it will overwrite saved.
--function this.SetupVars()
--  InfCore.LogFlow("IvarsPersist.SetupVars")
--  for name,defaultValue in pairs(this) do
--    if type(defaultValue)~="function" then
--      igvars[name]=defaultValue
--    end
--  end
--end

return this
