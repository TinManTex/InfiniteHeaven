-- InfInitMain.lua
-- tex loaded in TppVarInit, as an alternative to Tpp.requires
-- would be own module and loadlibaried (ala IH/Tpp) but cant currently add own internal scripts to ssd
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
