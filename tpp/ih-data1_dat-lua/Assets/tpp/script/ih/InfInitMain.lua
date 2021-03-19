-- DOBUILD: 1
-- InfInitMain.lua
-- tex loaded in start.lua, as an alternative to Tpp.requires
-- is module since it's Script.LoadLibraryed to break start.luas boxing
-- DEBUGNOW this does lead to an unknown since (in release build) it will be Script.LoadLibrarying more modules below while the module itself hasn't finished it's loading via Script.LoadLibrary
local this={}

InfCore.Log("InfInitMain:")
if IHH then
  IHH.InitMain()
end

InfCore.LoadLibrary"/Assets/tpp/script/ih/InfButton.lua"
InfCore.LoadLibrary"/Assets/tpp/script/ih/InfModules.lua"
InfCore.LoadLibrary"/Assets/tpp/script/ih/InfMain.lua"

InfMain.LoadExternalModules()
if not InfCore.mainModulesOK then
  InfMain.ModuleErrorMessage()
end
InfCore.doneStartup=true

table.insert(Tpp._requireList,"InfMain")

return this
