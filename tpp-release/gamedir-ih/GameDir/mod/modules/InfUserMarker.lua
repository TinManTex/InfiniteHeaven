--InfUserMarker.lua
--tex various feature using usermarkers 
--description of in game usermarkers feature/behaviour: 
--the square map markers that a player can place up to on a map, 
--when there's 5 the 'oldest' gets removed.
--they are labeled A-Z, wrapping back to A after Z has been placed.
--player can remove a user marker by clicking on it, therefore they aren't a contiguous set
--can either be at a static map position - even though they're placed via a 2d map the vertical value is accurate  RESEARCH how accurate is this, I guess it's a collision line trace so pretty good)
--or on a game object such as enemy or vehicle (in which it will update as it moves)
--they are saved/loaded (ie they will still be there on a new session, however they remain the same on a checkpoint /mission restart)
--they are cleared on returning to ACC, however remain if placed in acc on the current location (acc actually has afgh mafr and mb locations)
--RESEARCH: do they remain on free roam to mission and visa versa
--RESEARCH: a way to test maybe would be to go from free roam to mission without changing and seeing if markers still there, then doing that again after manually setting userMarkerLocationId to something 
--the data for them seem to be in vars.userMarker*
--the arrays are [maxUserMarkers - 5] elements
--arrays are 0 indexed, compacted on removes (ie later elements are moved up), 
--so current max index is vars.userMarkerSaveCount-1
--and it's also the most recently added (I'm pretty sure? lol)
--'unset'/removed entries have valid zeroed/default values
--userMarkerAddFlag[] - number - a flag to track when it was added?
--RETAILBUG: maybe (or there's actual reason for the differing behaviour).
--When usermarkers are placed via binoculars then this increments up to 26 (0 = marker not set) then wraps.
--kind of makes sense, means addFlag maps to letter, prevents eventual overflow, 
--QUESTION: but then how do they figure out what the oldest marker was (when then need to remove it).
--When usermarkers are placed via the map addFlag just keeps getting incremented without wrapping *shrug*
--QUESTION: then how do they figure out the letter for the marker?
--QUESTION: why this behaviour would be different between binoc placement and map placement?
--userMarkerGameObjId[] - gameId if was placed on a game object or GameObject.NULL_ID if not
--userMarkerPosX[]
--userMarkerPosY[]
--userMarkerPosZ[]
--userMarkerSaveCount - how many usermarkers are currently on the map
--userMarkerLocationId - possibly how they track when to clear
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
  "userMarkerMenu",
}

this.userMarkerMenu={
  parentRefs={"InfMenuDefs.objectListsMenu"},
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
  InfCore.Log("PrintLatestUserMarker")
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

  local markerPos=this.GetMarkerPosition(index)
  local x=markerPos:GetX()
  local y=markerPos:GetY()
  local z=markerPos:GetZ()
  local letter="A"
  local addFlag=nil
  if vars.userMarkerAddFlag then
    addFlag=vars.userMarkerAddFlag[index]
    letter=alphaTable[addFlag]--tex GOTCHA: only really works if only adding markers using binocs, see header userMarkerAddFlag explanation
  end
  local gameId=nil
  if vars.userMarkerGameObjId then
    gameId=vars.userMarkerGameObjId[index]
  end
  local closestCp=InfMain.GetClosestCp{x,y,z}
  local posString=string.format("%.2f,%.2f,%.2f",x,y,z)
  local message="userMarker "..index.." : letter="..tostring(letter)..", pos="..posString..", addFlag="..tostring(addFlag)..", gameId="..tostring(gameId).." closestCp:"..tostring(closestCp)
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
  local objectName=InfLookup.ObjectNameForGameId(gameId) or "Object name not found"
  InfCore.Log(objectName,true)
  InfCore.Log(gameId.."="..typeStr,true)

  local objectPos=GameObject.SendCommand(gameId,{id="GetPosition"})
  if objectPos==nil then
    InfCore.Log("GetPosition nil for "..objectName,true)
  else
    InfCore.Log(objectName.." pos:".. objectPos:GetX()..",".. objectPos:GetY().. ","..objectPos:GetZ(),true)
  end


  if typeIndex==TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    --InfCore.Log("cpName:"..tostring(cpName),true)--DEBUGNOW TODO
    
    --TODO: InfLookup
    --REF
    --TppGameObject.
    --  NPC_STATE_DISABLE = 0,
    --  NPC_STATE_NORMAL = 1,
    --  2--??
    --  NPC_STATE_CARRIED = 4,
    --REF
    --EnemyState.
    --NORMAL = 1,
    --STAND_HOLDUP = 2,
    --3?? is supine_holdup?
    --CARRIED = 4,
    local status=GameObject.SendCommand(gameId,{id="GetStatus"})
    --REF
    --TppGameObject.
    --  NPC_LIFE_STATE_NORMAL
    --  NPC_LIFE_STATE_DEAD
    --  NPC_LIFE_STATE_DYING
    --  NPC_LIFE_STATE_SLEEP
    --  NPC_LIFE_STATE_FAINT
    --REF
    --TppEnemy.LIFE_STATUS.*,
    --  NORMAL=0,
    --  DEAD=1,
    --  DYING=2,
    --  SLEEP=3,
    --  FAINT=4
    local lifeStatus=GameObject.SendCommand(gameId,{id="GetLifeStatus"})
    InfCore.Log("status:"..tostring(status).." lifeStatus:"..tostring(lifeStatus))
    --tex state bitflag (not just an enum) so use bitops bit. lib
    --REF
    --StateFlag.DYING_LIFE
      --DYING_LIFE = 1,
      --2??
      --ZOMBIE = 4,
    local stateFlag=GameObject.SendCommand(gameId,{id="GetStateFlag"})
    InfCore.Log("stateFlag:"..tostring(stateFlag))

    if objectName~=nil then
      local svarIndex=InfLookup.SoldierSvarIndexForName(objectName)
      if svarIndex==nil then
        InfCore.Log("Could not find svarIndex")
      else
        local soldierSvarName={
          "solName",
          "solState",
          "solFlagAndStance",
          "solWeapon",
          "solLocation",
          "solMarker",
          "solFovaSeed",
          "solFaceFova",
          "solBodyFova",
          "solCp",
          "solCpRoute",
          "solScriptSneakRoute",
          "solScriptCautionRoute",
          "solScriptAlertRoute",
          "solRouteNodeIndex",
          "solRouteEventIndex",
          "solTravelName",
          "solTravelStepIndex",
        }--soldierSvarName
    
--DEBUGNOW these are seperate? have to iterate to find matching solOptName?
--    {name="solOptName",arraySize=TppDefine.DEFAULT_SOLDIER_OPTION_VARS_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
--    {name="solOptParam1",arraySize=TppDefine.DEFAULT_SOLDIER_OPTION_VARS_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
--    {name="solOptParam2",arraySize=TppDefine.DEFAULT_SOLDIER_OPTION_VARS_COUNT,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
   
        InfCore.Log("Soldier svar index:"..tostring(svarIndex))
        InfCore.Log("solCpRoute:"..InfLookup.StrCode32ToString(svars.solCpRoute[svarIndex]))
        InfCore.Log("solScriptSneakRoute:"..InfLookup.StrCode32ToString(svars.solScriptSneakRoute[svarIndex]))--tex DEBUGNOW not sure why these arent finding their strings
        InfCore.Log("solScriptCautionRoute:"..InfLookup.StrCode32ToString(svars.solScriptCautionRoute[svarIndex]))
        InfCore.Log("solScriptAlertRoute:"..InfLookup.StrCode32ToString(svars.solScriptAlertRoute[svarIndex]))
        InfCore.Log("solRouteNodeIndex:"..svars.solRouteNodeIndex[svarIndex])
        InfCore.Log("solRouteEventIndex:"..svars.solRouteEventIndex[svarIndex])
      end
    end
  end
end--PrintMarkerGameObject

function this.GetLastAddedUserMarkerIndex()
  if vars.userMarkerSaveCount==nil or vars.userMarkerSaveCount==0 then
    return nil
  end

  return vars.userMarkerSaveCount-1
end

--tex CULL from when my brain was broken to how usermarkers worked, or maybe I did this madness for ssd? look back through past versions around ssd/lost heaven release to see I guess
--function this.GetLastAddedUserMarkerIndexOld()
--  if vars.userMarkerSaveCount==nil or vars.userMarkerSaveCount==0 then
--    return 0
--  end
--  
--  --tex find 'last added' in repect to how userMarker works described in above notes
--  --there may be a better way to do this, but I b bad math
--  --grab all the markerFlags
--  local addMarkerFlags={}
--  for index=0,vars.userMarkerSaveCount-1 do
--    local addFlag=vars.userMarkerAddFlag[index]
--    addMarkerFlags[#addMarkerFlags+1]={addFlag=addFlag,index=index}
--  end
--
--  --sort
--  local SortFunc=function(a,b)
--    if a.addFlag<b.addFlag then
--      return true
--    end
--    return false
--  end
--  table.sort(addMarkerFlags,SortFunc)
--
--
--  --figure this shit out
--  local highestMarkerIndex=nil
--
--  local flagMax=26--tex maps to alphabet so Z=26
--
--  local startFlag=addMarkerFlags[1].addFlag
--  local endFlag=addMarkerFlags[#addMarkerFlags].addFlag
--
--  if vars.userMarkerSaveCount==1 then
--    return addMarkerFlags[1].index
--  elseif endFlag==flagMax and startFlag==1 then--tex a marker hit the end and markers have wrapped, only works if all markers were placed in binoc (see RETAILBUG in header)
--    local previousFlag=startFlag
--    for n,info in ipairs(addMarkerFlags)do
--      if info.addFlag~=previousFlag and info.addFlag-1~=previousFlag then --tex GOTCHA(not actually) this method would fail if number of markers was max, think of a snake earing it's tail (snake? snake? snaaake!), but imagine trying to use 26 markers lol
--        highestMarkerIndex=addMarkerFlags[n-1].index
--        break
--      else
--        previousFlag=info.addFlag
--      end
--    end
--  else
--    highestMarkerIndex=addMarkerFlags[#addMarkerFlags].index
--  end
--
--  return highestMarkerIndex
--end

function this.GetMarkerPosition(index)
  if vars.userMarkerSaveCount==0 then
    return
  end
  if index>=vars.userMarkerSaveCount then
    return
  end

  local markerPos

  if vars.userMarkerGameObjId then
    local gameId=vars.userMarkerGameObjId[index]
    if gameId~=NULL_ID then
      markerPos=GameObject.SendCommand(gameId,{id="GetPosition"})
    end

    if markerPos==nil then
      if gameId~=NULL_ID then
        InfCore.Log("InfUserMarker.GetMarkerPosition: GetPosition==nil for gameObject "..gameId)
      end
      markerPos=Vector3(vars.userMarkerPosX[index],vars.userMarkerPosY[index]+1,vars.userMarkerPosZ[index])
    end
  elseif InfCore.gameId=="SSD" then
    local locationSuffix=""

    local locationName=TppLocation.GetLocationName()
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
  if markerPos:GetX()==0 and markerPos:GetY()==0 and markerPos:GetZ()==0 then
    InfCore.Log("WARNING: InfUserMarker.WarpToUserMarker: markerPos=0,0,0",true)--DEBUGNOW
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

  InfCore.DebugPrint(InfLangProc.LangString"warped_to_marker".." "..index..":".. markerPos:GetX()..",".. markerPos:GetY().. ","..markerPos:GetZ())
  TppPlayer.Warp{pos={markerPos:GetX(),markerPos:GetY()+offSetUp,markerPos:GetZ()},rotY=vars.playerCameraRotation[1]}
end

function this.Init()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.OnReload(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this.Messages()
  return Tpp.StrCode32Table{
    Terminal={
      --SSD
      {msg="MbTerminalUserMarkerPressed",
        func=function(stampId,posX,posY,isTargetMarker)

        end},
    },
  }
end

return this
