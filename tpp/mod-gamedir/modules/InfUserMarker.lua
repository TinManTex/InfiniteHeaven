--InfUserMarker.lua
--tex GOTCHA user marker has been changed a fair deal in SSD, only rough support here for the moment
--currently only seems to be 1 saved marker per location (and only mafr and ??)
--unless I want to use the stamps instead/aswell.
--Other GOTCHA user marker vars only seems to update on save instead of instant like TPP
local this={}
--localopt
local NULL_ID=GameObject.NULL_ID
local GetTypeIndex=GameObject.GetTypeIndex

this.MAXMARKERS=5
if InfCore.gameId=="SSD" then
  this.MAXMARKERS=1
end

--REF TPP
--  userMarkerLocationId
--  userMarkerSaveCount
--  local x=vars.userMarkerPosX[index]
--  local y=vars.userMarkerPosY[index]
--  local z=vars.userMarkerPosZ[index]
--  local addFlag=vars.userMarkerAddFlag[index]
--  local gameId=vars.userMarkerGameObjId[index]

--REF ssd
-- ssdMarker_User_flag = {[0] = 0},... all same count, MAXMARKERS 1?
--  ssdMarker_User_flag_mafr --?
--  ssdMarker_User_markerType --?
--  ssdMarker_User_markerType_mafr
--  ssdMarker_User_posX
--  ssdMarker_User_posX_mafr
--  ssdMarker_User_posY
--  ssdMarker_User_posY_mafr
--  ssdMarker_User_posZ
--  ssdMarker_User_posZ_mafr

--stamps are above with Stamp instead of user, MAXMARKERS 64

this.registerMenus={
  'userMarkerMenu',
}
this.userMarkerMenu={
  options={
    "InfUserMarker.WarpToLastUserMarker",
    "InfUserMarker.PrintLatestUserMarker",
    "InfUserMarker.PrintUserMarkers",
    "InfPositions.AddMarkerPositions",
    "InfPositions.WritePositions",
    "InfPositions.ClearPositions",
    --    "InfMenuCommands.SetSelectedCpToMarkerObjectCp",--DEBUG
    --    "Ivars.selectedCp",--DEBUG
  }
}
--< menu defs
this.langStrings={
  eng={
    userMarkerMenu="User marker menu",
    warpToLastUserMarker="Warp to latest marker",
    printLatestUserMarker="Print latest marker",
    printUserMarkers="Print all markers",
    warped_to_marker="Warped to marker",
  },
}
--<

--Commands
this.WarpToLastUserMarker=function()
  if vars.playerVehicleGameObjectId~=NULL_ID then
    return
  end

  -- InfCore.DebugPrint"Warping to newest marker"
  local lastMarkerIndex=this.GetLastAddedUserMarkerIndex()
  if lastMarkerIndex==nil then
    --InfCore.DebugPrint("lastMarkerIndex==nil")
    InfMenu.PrintLangId"no_marker_found"
  else
    this.PrintUserMarker(lastMarkerIndex)
    this.WarpToUserMarker(lastMarkerIndex)
  end
end


function this.PrintUserMarkers()
  --NMC 5 user markers, 0 indexed, compacted on adds and removes ('unset' have valid zeroed/default values) so max is vars.userMarkerSaveCount
  --userMarkerAddFlag maps to alphabet from 1 and is reused/wraps
  for index=0,this.MAXMARKERS-1 do
    this.PrintUserMarker(index)
  end

  if vars.userMarkerLocationId then
    InfCore.Log("userMarkerLocationId:"..vars.userMarkerLocationId,true)
  end
  if vars.userMarkerSaveCount then
    InfCore.Log("userMarkerSaveCount:"..vars.userMarkerSaveCount,true)
  end
end
this.PrintLatestUserMarker=function()
  local lastMarkerIndex=this.GetLastAddedUserMarkerIndex()
  if lastMarkerIndex==nil then
    InfCore.DebugPrint("lastMarkerIndex==nil")
  else
    this.PrintUserMarker(lastMarkerIndex)
    this.PrintMarkerGameObject(lastMarkerIndex)
  end
end

--
local alphaTable={"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"}
function this.PrintUserMarker(index)
  --NMC 5 user markers, 0 indexed, compacted on adds and removes ('unset' have valid zeroed/default values) so max is vars.userMarkerSaveCount
  --userMarkerAddFlag maps to alphabet from 1 and is reused/wraps

  local markerPos=this.GetMarkerPosition(index)
  local x=markerPos:GetX()
  local y=markerPos:GetY()
  local z=markerPos:GetZ()
  local letter="A"
  local addFlag=nil
  if vars.userMarkerAddFlag then
    addFlag=vars.userMarkerAddFlag[index]
    letter=alphaTable[addFlag]
  end
  local gameId=nil
  if vars.userMarkerGameObjId then
    gameId=vars.userMarkerGameObjId[index]
  end
  local closestCp=InfMain.GetClosestCp{x,y,z}
  local posString=string.format("%.2f,%.2f,%.2f",x,y,z)
  local message="userMarker "..index.." : pos="..posString..", addFlag="..tostring(addFlag)..", letter="..tostring(letter)..", gameId="..tostring(gameId).." closestCp:"..tostring(closestCp)
  InfCore.Log(message)
  InfCore.DebugPrint(message)
  --InfCore.DebugPrint("userMarker "..index.." : pos="..tostring(x)..","..tostring(y)..","..tostring(z)..", addFlag="..tostring(addFlag)..", letter="..tostring(letter)..", gameId="..tostring(gameId))
end
function this.PrintMarkerGameObject(index)
  if vars.userMarkerGameObjId==nil then
    return "vars.userMarkerGameObjId==nil"
  end

  local gameId=vars.userMarkerGameObjId[index]
  if gameId==NULL_ID then
    InfCore.DebugPrint"gameId==NULL_ID"
    return
  end
  local typeIndex=GetTypeIndex(gameId)
  local typeStr=InfLookup.TppGameObject.typeIndex[typeIndex]
  local objectName,cpName=InfLookup.ObjectNameForGameId(gameId) or "Object name not found"
  InfCore.Log(objectName,true)
  InfCore.Log(gameId.."="..typeStr,true)
  if typeIndex==TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    InfCore.Log("cpName:"..tostring(cpName),true)--DEBUGNOW TODO
    if objectName~=nil then
      local svarIndex=InfLookup.SoldierSvarIndexForName(objectName)
      if svarIndex==nil then
        InfCore.Log("Could not find svarIndex")
      else
        InfCore.Log("Soldier svar index:"..tostring(svarIndex))
        InfCore.Log("Soldier svars:"..svarIndex)
        InfCore.Log("cpRoute:"..svars[svarIndex].solCpRoute)
        InfCore.Log("solScriptSneakRoute:"..svars[svarIndex].solScriptSneakRoute)
        InfCore.Log("solScriptCautionRoute:"..svars[svarIndex].solScriptCautionRoute)
        InfCore.Log("solScriptAlertRoute:"..svars[svarIndex].solScriptAlertRoute)
        InfCore.Log("solRouteNodeIndex:"..svars[svarIndex].solRouteNodeIndex)
        InfCore.Log("solRouteEventIndex:"..svars[svarIndex].solRouteEventIndex)
      end
    end
  end
end
function this.GetLastAddedUserMarkerIndex()
  if vars.userMarkerSaveCount==nil or vars.userMarkerSaveCount==0 then
    return 0
  end

  --tex find 'last added' in repect to how userMarker works described in above notes
  --there may be a better way to do this, but I b bad math
  --grab all the markerFlags
  local addMarkerFlags={}
  for index=0,vars.userMarkerSaveCount-1 do
    local addFlag=vars.userMarkerAddFlag[index]
    addMarkerFlags[#addMarkerFlags+1]={addFlag=addFlag,index=index}
  end

  --sort
  local SortFunc=function(a,b)
    if a.addFlag<b.addFlag then
      return true
    end
    return false
  end
  table.sort(addMarkerFlags,SortFunc)


  --figure this shit out
  local highestMarkerIndex=nil

  local flagMax=26--tex maps to alphabet so Z=26

  local startFlag=addMarkerFlags[1].addFlag
  local endFlag=addMarkerFlags[#addMarkerFlags].addFlag

  if vars.userMarkerSaveCount==1 then
    return addMarkerFlags[1].index
  elseif endFlag==flagMax and startFlag==1 then--tex a marker hit the end and markers have wrapped
    local previousFlag=startFlag
    for n,info in ipairs(addMarkerFlags)do
      if info.addFlag~=previousFlag and info.addFlag-1~=previousFlag then --tex GOTCHA(not actually) this method would fail if number of markers was max, think of a snake earing it's tail (snake? snake? snaaake!), but imagine trying to use 26 markers lol
        highestMarkerIndex=addMarkerFlags[n-1].index
        break
      else
        previousFlag=info.addFlag
      end
    end
  else
    highestMarkerIndex=addMarkerFlags[#addMarkerFlags].index
  end

  return highestMarkerIndex
end

function this.GetMarkerPosition(index)
  if vars.userMarkerSaveCount==nil then
    index=0
  elseif vars.userMarkerSaveCount==0 then
    return
  end

  local markerPos=Vector3(0,0,0)

  if vars.userMarkerGameObjId then
    local gameId=vars.userMarkerGameObjId[index]
    if gameId==NULL_ID then
      markerPos=Vector3(vars.userMarkerPosX[index],vars.userMarkerPosY[index]+1,vars.userMarkerPosZ[index])
    else
      markerPos=GameObject.SendCommand(gameId,{id="GetPosition"})
    end
  elseif InfCore.gameId=="SSD" then
    local locationSuffix=""

    local locationName=TppLocation.GetLocationName()--TODO: update InfUtil.GetLocationName()
    if locationName=="mafr" then
      locationSuffix="_mafr"
    end

    local x=vars["ssdMarker_User_posX"..locationSuffix][index]
    local y=vars["ssdMarker_User_posY"..locationSuffix][index]
    local z=vars["ssdMarker_User_posZ"..locationSuffix][index]
    markerPos=Vector3(x,y,z)
  end

  return markerPos
end


function this.WarpToUserMarker(index)
  if vars.userMarkerSaveCount==0 then
    return
  end

  local offSetUp=1.5

  local markerPos=this.GetMarkerPosition(index)
  if markerPos==nil then
    InfCore.Log("WARNING: InfUserMarker.WarpToUserMarker: could not find marker")--DEBUGNOW
    return
  end
  if vars.userMarkerGameObjId~=nil then
    local gameId=vars.userMarkerGameObjId[index]
    if gameId~=NULL_ID then
      --InfCore.DebugPrint("gameId~=NULL_ID")--DEBUG

      local typeIndex=GameObject.GetTypeIndex(gameId)
      if typeIndex==TppGameObject.GAME_OBJECT_TYPE_VEHICLE then
        offSetUp=3
      end
    end
  end

  InfCore.DebugPrint(InfMenu.LangString"warped_to_marker".." "..index..":".. markerPos:GetX()..",".. markerPos:GetY().. ","..markerPos:GetZ())
  TppPlayer.Warp{pos={markerPos:GetX(),markerPos:GetY()+offSetUp,markerPos:GetZ()},rotY=vars.playerCameraRotation[1]}
end

return this
