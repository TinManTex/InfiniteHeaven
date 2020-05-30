-- InfModules.lua
-- tex lists references to the modules (that succesfully loaded) via InfMain.LoadExternalModules/moduleNames table
-- see InfMain.LoadExternalModules to see how this is set up, and other references to InfModules to see how it's used
local this={}

--STATE
this.moduleNames={}
--tex also modules in load order as this[n]=module

--tex while most modules are just loaded in whatever order dir > returns, still need to handle order of these -v- since there's some depenancies between them
this.coreModules={
  "Ivars",
  "IvarsPersist",
  "InfLangProc",
  "InfLang",
  "InfMenu",
  "InfMenuDefs",
  "InfMenuCommands",
  "InfQuickMenuDefs",
}

--TABLESETUP
this.isCoreModule={}
for i,moduleName in ipairs(this.coreModules)do
  this.isCoreModule[moduleName]=true
end

return this
