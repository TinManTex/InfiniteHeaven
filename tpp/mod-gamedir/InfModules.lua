-- InfModules.lua
-- tex lists references to the modules (that succesfully loaded) via InfMain.LoadExternalModules/moduleNames table
-- see InfMain.LoadExternalModules to see how this is set up
local this={}
this.moduleNames={
  "InfLookup",
  "Ivars",
  "InfMenuCommands",
  "InfQuickMenuCommands",
  "InfLang",
  "InfMenuDefs",
  "InfQuickMenuDefs",
  "InfHelicopter",
  "InfEnemyPhase",
  "InfCamera",
  "InfWarp",
  "InfNPC",
  "InfNPCOcelot",
  "InfNPCHeli",
  "InfWalkerGear",
  "InfMBVisit", 
  "InfBuddy",
  "InfParasite",
  "InfInterrogation",
} 
return this
