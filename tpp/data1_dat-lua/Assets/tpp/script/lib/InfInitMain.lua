-- DOBUILD: 1
-- InfInitMain.lua
-- tex loaded in start.lua, as an alternative to Tpp.requires
-- is module since it's Script.LoadLibraryed to break start.luas boxing
local this={}

InfCore.LogFlow("InfInitMain:")

InfCore.LoadLibrary"core/InfButton.lua"
InfCore.LoadLibrary"core/InfModules.lua"
InfCore.LoadLibrary"core/InfMain.lua"

InfMain.LoadExternalModules()
if not InfCore.mainModulesOK then
  InfMain.ModuleErrorMessage()
end
InfCore.doneStartup=true

table.insert(Tpp._requireList,"InfMain")

return this
