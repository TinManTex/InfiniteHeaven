-- DOBUILD: 1
-- InfInit.lua
local this={}

if IHH then
  IHH.Init()
end

InfCore=require"mod/core/InfCore"--GOTCHA modPath
if InfCore and not InfCore.modDirFail then
  InfCore.LoadLibrary"core/InfInspect.lua"
  InfCore.LoadLibrary"core/InfUtil.lua"
  InfCore.LoadLibrary"core/InfTppUtil.lua"

  --STATE GLOBAL
  ivars={}
  evars={}
  igvars={}
  ih_save={}

  InfCore.LoadLibrary"core/IvarProc.lua"

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
  --tex needs to be up for Soldier2FaceAndBodyData
  InfCore.LoadLibrary"core/InfModelProc.lua"

  InfCore.PCall(InfModelProc.LoadFovaInfo)

  InfCore.Log"InfInit.lua done"
end

return this
