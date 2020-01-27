-- InfModules.lua
-- tex lists references to the modules (that succesfully loaded) via InfMain.LoadExternalModules/moduleNames table
-- see InfMain.LoadExternalModules to see how this is set up, and other references to InfModules to see how it's used
local this={}
this.moduleNames={
  "InfLookup",
  "Ivars",
  "InfMenuCommands",
  "InfQuickMenuCommands",
  "InfLang",
  "InfMenuDefs",
  "InfQuickMenuDefs",
  "InfEquip",
  "InfQuest",
  "InfHelicopter",
  "InfEnemyPhase",
  "InfCamera",
  "InfWarp",
  "InfVehicle",
  "InfNPC",
  "InfNPCOcelot",
  "InfPuppy",
  "InfNPCHeli",
  "InfWalkerGear",
  "InfMBVisit", 
  "InfBuddy",
  "InfParasite",
  "InfInterrogation",
  "InfResources",
  "InfUserMarker",
} 
return this
