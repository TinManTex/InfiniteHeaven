--InfPositions.lua
local this={}

--STATE
this.positions={}


this.registerMenus={
  'positionsMenu',
}

this.positionsMenu={
  parentRefs={"InfMenuDefs.inMissionMenu"},
  options={
    "InfPositions.AddPosition",
    "InfPositions.AddMarkerPositions",--DEBUGNOW TODO: where to have this
    "InfPositions.WritePositions",
    "InfPositions.ClearPositions",
  },
}
--< menu defs
this.langStrings={
  eng={
    positionsMenu="Positions menu",
    addPosition="Add current position to Positions List",
    addMarkerPositions="Add markers to Positions List",
    writePositions="Write Positions List",
    clearPositions="Clear Positions List",
  },
  help={
    eng={
      positionsMenu="For adding positions in the game to a Positions List, and writing them to files.",
      addPosition="Add current player or freecam position to Positions List, positions list can be written to file with Write Positons List command.",
      addMarkerPositions="Adds current user markers to positions list, positions list can be written to file with Write Positons List command.",
      writePositions="Writes Positions List to files in MGS_TPP\\mod\\",
      clearPositions="Clears Positions List",
    },
  },
}
--<

--Commands
--tex adds player or camera position (if freecam) to this.positions
function this.AddPosition()
  local offsetY=0
  if Ivars.adjustCameraUpdate:Is(0) then--tex freecam not on
    offsetY=-0.783
    if PlayerInfo.OrCheckStatus{PlayerStatus.CRAWL} then
      offsetY = offsetY + 0.45
    end
  end

  local position={vars.playerPosX, vars.playerPosY+offsetY, vars.playerPosZ, vars.playerCameraRotation[1]}
  table.insert(this.positions,position)
  InfCore.Log(#this.positions..[[ positions in list]],true,true)
end

--tex adds current user marker positions to InfPositions.positions
function this.AddMarkerPositions()
  local addedCount=0
  for index=0,InfUserMarker.MAXMARKERS-1 do
    local markerPos=this.GetMarkerPosition(index)
    local x=markerPos:GetX()
    local y=markerPos:GetY()
    local z=markerPos:GetZ()
    local addFlag=vars.userMarkerAddFlag and vars.userMarkerAddFlag[index] or nil
    if addFlag==nil or addFlag~=0 then
      addedCount=addedCount+1
      --local letter=alphaTable[addFlag]
      table.insert(this.positions,{x,y,z})
    end
  end

  local addedString = addedCount.." positions added to list"
  local sizeString = "list now has "..#this.positions.." positions"
  InfCore.Log("InfUserMarker:AddPositions: "..addedString)
  InfCore.DebugPrint(addedString)
  InfCore.Log("InfUserMarker:AddPositions: "..sizeString)
  InfCore.DebugPrint(sizeString)
end

function this.ClearPositions()
  this.positions={}
end

function this.WritePositions()
  InfCore.Log("InfPositions.WritePositions:")

  local writeTypes={
    positions_plain={fmt='%.3f,%.3f,%.3f,%3f,'},
    positions_lua={
      header='local positions={',
      fmt='{pos={%.3f,%.3f,%.3f},rotY=%.3f,},',
      footer='} return positions',
    },
    positions_xml={fmt='<value x="%.3f" y="%.3f" z="%.3f" w="0" />'},
    positions_json={
      header='{"Positions" : [{',
      fmt='"Position": {"X": %.3f,"Y": %.3f,"Z": %.3f},',
      footer='}]}',
    },
  }

  for writeType,writeInfo in pairs(writeTypes)do
    local writeStrings={}
    writeStrings[#writeStrings+1]=writeInfo.header
    for i,position in ipairs(this.positions)do
      writeStrings[#writeStrings+1]=string.format(writeInfo.fmt,position[1],position[2],position[3],position[4] or 0)
    end
    writeStrings[#writeStrings+1]=writeInfo.footer

    local filePath=InfCore.paths.mod..writeType..".txt"
    InfCore.Log(filePath)
    InfCore.WriteStringTable(filePath,writeStrings)
  end

  InfCore.Log(#this.positions..[[ positions written to MGS_TPP\mod\]],true,true)
end
--<

return this