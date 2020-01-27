-- ssd InfInit.lua
local this={}

InfCore=require"mod/core/InfCore"--GOTCHA modPath
if InfCore and not InfCore.modDirFail then
  InfCore.LoadLibrary"core/InfInspect.lua"
  InfCore.LoadLibrary"core/InfUtil.lua"

  InfCore.LoadLibrary"core/IvarProc.lua"

  --STATE GLOBAL
  ivars={}
  evars={}
  igvars={}
  ih_save={}

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

  InfCore.LogFlow"InfInit.lua done"
end

return this
