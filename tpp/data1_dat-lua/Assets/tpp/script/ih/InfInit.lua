-- DOBUILD: 1
-- InfInit.lua
local this={}

if IHH then
  IHH.Init()
end

--tex try external first
InfCore=require"mod/Assets/tpp/script/ih/InfCore"--GOTCHA modPath. relying on default package.paths having game dir
if InfCore==nil then
  Script.LoadLibrary"/Assets/tpp/script/ih/InfCore.lua"
end

if InfCore and not InfCore.modDirFail then
  InfCore.LoadLibrary"/Assets/tpp/script/ih/InfInspect.lua"
  InfCore.LoadLibrary"/Assets/tpp/script/ih/InfUtil.lua"
  InfCore.LoadLibrary"/Assets/tpp/script/ih/InfTppUtil.lua"

  --STATE GLOBAL
  ivars={}
  evars={}
  igvars={}
  ih_save={}

  InfCore.LoadLibrary"/Assets/tpp/script/ih/IvarProc.lua"

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
  InfCore.LoadLibrary"/Assets/tpp/script/ih/InfModelProc.lua"

  InfCore.PCall(InfModelProc.LoadFovaInfo)

  InfCore.Log"InfInit.lua done"
end

return this
