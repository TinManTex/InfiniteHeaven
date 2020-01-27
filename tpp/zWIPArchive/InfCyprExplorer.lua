--InfCyprExplorer.lua--DEBUGNOW
local this={}

this.registerIvars={
  "misc_loadCyprStep",
}

--DEBUGNOW

this.misc_loadCyprStep={
  save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=35},
  OnActivate=function(self,setting)
  --DEBUGNOW TODO: location not cypr, missioncode not cypr free?
    local step=setting
    InfCore.DebugPrint("step:"..step)
    TppCyprusBlockControl.SetCyprusStep(step)
    if cypr_mission_block then
    cypr_mission_block.SetLoadStep(step)
    end 
  end,
}

this.registerMenus={
  "cyprExplorerMenu",
}

this.cyprExplorerMenu={
  parentRefs={"InfMenuDefs.inMissionMenu"},
  options={
    "Ivars.misc_loadCyprStep",
  }
}

return this
