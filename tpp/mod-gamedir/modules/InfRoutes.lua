--InfRoutes.lua
--Commands to manage route name list used for other commands as well as saving and loading from file.
local this={}

--STATE
this.routeNames={}
local list=this.routeNames

local fileName="routes_list.txt"

this.registerMenus={
  'routesMenu',
}

this.routesMenu={
  parentRefs={"InfMenuDefs.inMissionMenu"},
  options={
    "InfRoutes.ClearRoutes",
    "InfRoutes.WriteRoutes",
    "InfRoutes.LoadRouteNames",
    --"Ivars.selectListRoute",
    "Ivars.setMarkerSneakRoute",
  },
}
--< menu defs
this.langStrings={
  eng={
    routesMenu="Routes menu",
    writeRoutes="Write Routes List",
    loadRouteNames="Load Routes List",
    clearRoutes="Clear Routes List",
    selectListRoute="Browse route list",
    addLookupList="Add lookup list",
  },
  help={
    eng={
      routesMenu="For adding route names in the game to a Routes List, and writing/loading them to files.",
      writeRoutes="Writes Routes List to file in MGS_TPP\\mod\\",
      loadRouteNames="Loads routes list from file in MGS_TPP\\mod\\",
      clearRoutes="Clears Routes List",
      --selectListRoute="Select route name, mostly just used to browse route names list at the moment.",--DEBUGNOW
    },
  },
}
--<

this.registerIvars={
  "selectListRoute",
  "setMarkerSneakRoute",
}

this.selectListRoute={
  settings={},--DYNAMIC
  GetSettingText=function(self,setting)
    if self.settings==0 then
      return InfLangProc.LangString"list_empty"
    end
    local routeName=self.settings[setting+1]
    return routeName
  end,
  OnSelect=function(self)
    IvarProc.SetSettings(self,this.routeNames)
  end,
}

this.setMarkerSneakRoute={
  settings={},--DYNAMIC
  GetSettingText=function(self,setting)
    if self.settings==0 then
      return InfLangProc.LangString"list_empty"
    end
    local routeName=self.settings[setting+1]
    return routeName
  end,
  OnSelect=function(self)
    IvarProc.SetSettings(self,this.routeNames)
  end,
  OnActivate=function(self,setting)
    if self.settings==0 then 
      InfMenu.PrintLangId"list_empty"
      return
    end
    local routeName=self.settings[setting+1]
    local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
    local gameId=vars.userMarkerGameObjId[lastMarkerIndex]
    if lastMarkerIndex==nil then
      InfMenu.PrintLangId"no_marker_found"
      return
    end

    if gameId==GameObject.NULL_ID then
      InfCore.DebugPrint"gameId==NULL_ID"--DEBUGNOW ADDLANG
      return
    end
    
    --DEBUGNOW
    --if not object that can have route set warn and return
    
    GameObject.SendCommand(gameId,{id="SetSneakRoute",route=routeName})
  end,
}

function this.ClearRoutes()
  InfUtil.ClearArray(this.routeNames)
end

function this.WriteRoutes()
  InfCore.Log("InfRoutes.WriteRoutes:")

  local list=this.routeNames

  local filePath=InfCore.paths.mod..fileName
  InfCore.WriteStringTable(filePath,list)

  InfCore.Log(#list..[[ entries written to MGS_TPP\mod\]]..fileName,true,true)
end

function this.LoadRouteNames()
  InfCore.Log("InfRoutes.LoadRouteNames:")

  local filePath=InfCore.paths.mod..fileName
  local lines=InfCore.GetLines(filePath)
  if lines==nil then
    InfCore.DebugPrint("Could not load "..fileName)--DEBUGNOW ADDLANG
    return
  end

  if #lines==0 then
    InfMenu.PrintLangId"list_empty"
    return
  end

  this.routeNames=lines

  InfCore.Log(#lines.." entries loaded from "..fileName,true,true)
end

return this
