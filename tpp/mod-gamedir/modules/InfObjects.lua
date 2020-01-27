--InfObjects.lua
--Commands to manage gameobject name list used for other commands as well as saving and loading from file.
local this={}

--STATE
this.objectNames={}

this.registerMenus={
  'objectsMenu',
}

this.objectsMenu={
  parentRefs={"InfMenuDefs.inMissionMenu"},
  options={
    "InfObjects.AddMarkerObjects",
    "InfObjects.ClearObjects",
    "InfObjects.WriteObjects",
    "InfObjects.LoadObjectNames",
    "Ivars.selectListObject",
  },
}
--< menu defs
this.langStrings={
  eng={
    objectsMenu="Objects menu",
    addMarkerObjects="Add marked objects to list",
    writeObjects="Write Objects List",
    loadObjectNames="Load Objects List",
    clearObjects="Clear Objects List",
    selectListObject="Select object name",
  },
  help={
    eng={
      objectsMenu="For adding game object names in the game to a Objects List, and writing/loading them to files.",
      addMarkerObjects="Adds current marked game object names to objects list, objects list can be written to file with Write Objects List command.",
      writeObjects="Writes Objects List to file in MGS_TPP\\mod\\",
      loadObjectNames="Loads objects list from file in MGS_TPP\\mod\\",
      clearObjects="Clears Objects List",
      selectListObject="Select game object name, mostly just used to browse object names list at the moment.",--DEBUGNOW
    },
  },
}
--<

this.registerIvars={
  "selectListObject",
}

this.selectListObject={
  inMission=true,
  range={max=0},--DYNAMIC
  GetSettingText=function(self,setting)
    local objectName=this.objectNames[setting+1]
    if objectName==nil then
      return InfLangProc.LangString"list_empty"
    end

    local gameObjectId=GameObject.GetGameObjectId(objectName)
    if gameObjectId==GameObject.NULL_ID then
      return objectName.."==NULL_ID"
    end

    return objectName
  end,
  OnSelect=function(self)
    IvarProc.SetMaxToList(self,this.objectNames)
  end,
}

--Commands
function this.AddMarkerObjects()
  local addedCount=0
  for index=0,InfUserMarker.MAXMARKERS-1 do
    local addFlag=vars.userMarkerAddFlag and vars.userMarkerAddFlag[index] or nil
    if addFlag==nil or addFlag~=0 then
      local gameId=vars.userMarkerGameObjId[index]
      if gameId==GameObject.NULL_ID then
        --DEBUGNOW InfMenu.PrintLangId"soldier_not_marked"
        InfCore.Log("gameId==NULL_ID  "..gameId)--DEBUGNOW
      else

        local gameObjectName=InfLookup.ObjectNameForGameId(gameId)
        if gameObjectName==nil then
          --DEBUGNOW InfMenu.PrintLangId"soldier_not_marked"
          InfCore.Log("No name found for gameobject "..gameId,true)--DEBUGNOW
        else
          --TODO: better
          local add=true
          for i,objectName in ipairs(this.objectNames) do
            if gameObjectName==objectName then
              add=false
              break
            end
          end

          if add then
            addedCount=addedCount+1
            this.objectNames[#this.objectNames+1]=gameObjectName
          end
        end--if name not nil
      end--if not NULL_ID
    end--if addflag
  end--for markers

  local addedString = addedCount.." objects added to list"
  local sizeString = "list now has "..#this.objectNames.." positions"
  InfCore.Log("InfObjects:AddMarkerObjects: "..addedString)
  InfCore.DebugPrint(addedString)
  InfCore.Log("InfObjects:AddMarkerObjects: "..sizeString)
  InfCore.DebugPrint(sizeString)
end

function this.ClearObjects()
  this.objectNames={"Player"}
end

function this.WriteObjects()
  InfCore.Log("InfPositions.WritePositions:")

  local writeTypes={
    objects_lua={
      header='local objectNames={',
      fmt='"%s",',
      footer='} return objectNames',
    },
  }

  for writeType,writeInfo in pairs(writeTypes)do
    local writeStrings={}
    writeStrings[#writeStrings+1]=writeInfo.header
    for i,objectName in ipairs(this.objectNames)do
      writeStrings[#writeStrings+1]=string.format(writeInfo.fmt,objectName)
    end
    writeStrings[#writeStrings+1]=writeInfo.footer

    local filePath=InfCore.paths.mod..writeType..".txt"
    InfCore.Log(filePath)
    InfCore.WriteStringTable(filePath,writeStrings)
  end

  InfCore.Log(#this.objectNames..[[ object names written to MGS_TPP\mod\]],true,true)
end

function this.LoadObjectNames()
  InfCore.Log("InfPositions.LoadObjectNames:")

  local fileName="objects_lua.txt"

  local objectNames=InfCore.LoadSimpleModule(InfCore.paths.mod,fileName)
  if #objectNames==0 then
    InfMenu.PrintLangId"list_empty"
    return
  end

  this.objectNames=objectNames

  InfCore.Log(#this.objectNames.." object names loaded from "..fileName,true,true)
end
--<

function this.GetObjectInfoOrPos(index)--DEBUGNOW
  local objectList=this.objectNames

  if objectList==nil then
    return nil,"objectList nil"
  end

  if #objectList==0 then
    return nil,"objectList empty"
  end

  local objectName=objectList[index]
  if objectName==nil then
    return nil,"objectName==nil for index "..index,nil
  end
  local gameId=objectName
  if type(objectName)=="string" then
    gameId=GameObject.GetGameObjectId(objectName)
  end
  if gameId==nil then
    return objectName,objectName.." nil"
  end
  if gameId==GameObject.NULL_ID then
    return objectName,objectName.." NULL_ID"
  end

  local position=GameObject.SendCommand(gameId,{id="GetPosition"})
  if position==nil then
    return objectName,objectName.." nil for GetPosition"
  end

  position={position:GetX(),position:GetY(),position:GetZ()}

  return objectName,"",position
end

function this.PostAllModulesLoad(prevModule)
  this.ClearObjects()
end

return this
