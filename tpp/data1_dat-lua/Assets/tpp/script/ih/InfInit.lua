-- DOBUILD: 1
-- InfInit.lua
-- tex loaded in init.lua
-- is module since it's Script.LoadLibraryed to break init.luas boxing
-- this does lead to an unknown since (in release build) it will be Script.LoadLibrarying more modules below while the module itself hasn't finished it's loading via Script.LoadLibrary
-- see also InfInitMain
local this={}

if IHH then
  IHH.Init()
end

--OUT/SIDE: InfCore
--function this.LoadCoreExternal()
--  InfCore=require"mod/Assets/tpp/script/ih/InfCore"--GOTCHA modPath. relying on default package.paths having game dir
--end
--tex try external first
--DEBUGNOW a way to output err (if IHH then you can just log it)
--local ok,err=pcall(this.LoadCoreExternal())--DEBUGNOW pcall not working
--if err then
--  Script.LoadLibrary"/Assets/tpp/script/ih/InfCore.lua"
--end

--tex haven't been able to get a fallback wokeing, so will just hardcode to a bool for now
local loadExternal=true
if loadExternal then
  InfCore=require"mod/Assets/tpp/script/ih/InfCore"--GOTCHA modPath. relying on default package.paths having game dir
else
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
