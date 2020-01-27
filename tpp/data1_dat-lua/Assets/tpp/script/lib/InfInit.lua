-- DOBUILD: 1
-- InfInit.lua
local this={}
InfCore.LogFlow"Load InfInit.lua"

--STATE GLOBAL --TODO put declaration somewhere clearer, infcore?
ivars={}
evars={}
igvars={}
ih_save={}

--EXEC
if not InfCore.modDirFail then
  InfCore.LoadExternalModule"Ivars"
  InfCore.LoadExternalModule"IvarsPersist"
  if Ivars==nil then
    InfCore.Log"Ivars==nil"--DEBUG
  else
    --CULL IvarsPersist.SetupVars()
    IvarProc.LoadEvars()
    if ivars.enableIHExt==1 then
      InfCore.StartIHExt()
    end
  end

  --InfCore.PrintInspect(evars)--DEBUG
end

InfCore.LogFlow"InfInit.lua done"
return this
