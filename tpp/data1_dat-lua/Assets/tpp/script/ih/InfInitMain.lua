-- DOBUILD: 1
-- InfInitMain.lua
-- tex loaded in start.lua, as an alternative to Tpp.requires
-- is module since it's Script.LoadLibraryed to break start.luas boxing
local this={}

InfCore.Log("InfInitMain:")

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
