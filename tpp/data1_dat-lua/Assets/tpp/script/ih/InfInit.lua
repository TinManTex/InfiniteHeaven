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

--tex try loading external first. messy, but it's chicken and egg, once InfCore is up and running it has tidier functions to use
local sucess,ret=pcall(require,"mod/Assets/tpp/script/ih/InfCore")--GOTCHA modPath. relying on default package.paths having game dir DEBUGNOW if IHH then could use gamepath
if sucess then
  InfCore=ret
else
  --TODO I don't think there's really any option here to log if InfCore fails and IHHook isn't installed.
  --also, this is only really an error if -v- InfCore doesn't exist internally
  --does loadlibrary raise errors that we can catch?
  if IHH then
    --IHH.Log(5,ret)--level_critical
  end
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
