--InfQuickMenuDefs_User.lua --DEBUGNOW DEBUGNOW

--InfQuickMenuDefs_User.lua doesn't get overwritten on new IH versions,
--but you'll have to check any new InfQuickMenuDefs.lua to see if I've done any changes to the system.

--Quick (incomplete) Buttons/Keys reference.
--Some buttons are combined, and in different ways on keyboard vs gamepad

--InfButton name - <description> - (default key / button)
--InfButton.ACTION - (E key or Y button)
--InfButton.RELOAD - (R key or B button)
--InfButton.EVADE - <Quick dive> - (space key or X button)
--InfButton.HOLD - <Ready weapon> - (Right mouse or Left Trigger)
--InfButton.FIRE - (Left mouse or Right Trigger)
--InfButton.CALL - <Call radio/interrogate> - (Q or Left bumper)
--InfButton.SUBJECT - <Binoculars/scope> - (F or Right bumper)
--InfButton.DASH - (Shift or Left stick click)
--InfButton.ZOOM_CHANGE - (Middle mouse or Right stick click)

--InfButton.UP - (Arrow/Dpad Up)
--InfButton.DOWN - (Arrow/Dpad Down)
--InfButton.RIGHT - (Arrow/Dpad Right)
--InfButton.LEFT - (Arrow/Dpad Left)

--InfButton.LIGHT_SWITCH - (X key,Dpad Right)

local this={}

this.forceEnable=true
this.quickMenuHoldButton=InfButton.CALL

this.inHeliSpace={}

this.inMission={

    -- Player hotkeys
    [InfButton.ACTION]={immediate=true,Command='InfMenuCommands.ToggleFreeCam'},
    [InfButton.STANCE]={immediate=true,Command='InfQuickMenuDefs_User.ShowPosition'},
    [InfButton.EVADE]={immediate=true,Command='InfQuickMenuDefs_User.WarpPlayer'},
    [InfButton.RELOAD]={immediate=true,Command='InfQuickMenuDefs_User.WarpPlayer'},

    -- Enemy hotkeys
    [InfButton.UP]={immediate=true,Command='InfQuickMenuDefs_User.MarkAndSetAllFriendly'},
    [InfButton.DOWN]={immediate=true,Command='InfQuickMenuDefs_User.PrintLatestUserMarker'},
    [InfButton.RIGHT]={immediate=true,Command='InfQuickMenuDefs_User.SpeedUpSoldiers'},
    [InfButton.LEFT]={immediate=true,Command='InfQuickMenuDefs_User.ToggleChangePhase'},

    [InfButton.ZOOM_CHANGE]={immediate=true,Command='InfMenuCommands.LoadExternalModules'},
}

this.positions={}
this.positionsXML={}

this.WarpPlayer = function()
  if Ivars.adjustCameraUpdate:Is(0) then
    InfMenuCommands.WarpToUserMarker()
  else
    InfMenuCommands.WarpToCamPos()
  end
end

this.ShowPosition = function()
  local x,y,z

  if Ivars.adjustCameraUpdate:Is(0) then
    this.PrintQuestArea()
    local offsetY=-0.783
    if PlayerInfo.OrCheckStatus{PlayerStatus.CRAWL} then
      offsetY = offsetY + 0.45
    end

    x,y,z=vars.playerPosX,vars.playerPosY,vars.playerPosZ
    y=y+offsetY

  else
    InfCore.DebugPrint("[Note: Free Cam does not determine location suitability]")
    local currentCamName=InfCamera.GetCurrentCamName()
    local movePosition=InfCamera.ReadPosition(currentCamName)
    x,y,z=movePosition:GetX(),movePosition:GetY(),movePosition:GetZ()
  end

  local rotY=vars.playerCameraRotation[1]
  local positionTable=string.format("{pos={%.3f,%.3f,%.3f},rotY=%.3f,},",x,y,z,rotY)
  table.insert(this.positions,positionTable)
  InfCore.Log("positions:\r\n"..table.concat(this.positions,"\r\n"),false,true)
  InfCore.DebugPrint("Position written to ih_log")
end

function this.PrintQuestArea()
  if vars.missionCode==30050 then
    local clusterId=MotherBaseStage.GetCurrentCluster()
    if clusterId==nil then
      InfCore.Log("InfQuest.PrintQuestArea: WARNING: GetCurrentCluster==nil")
    else
      local clusterName=TppDefine.CLUSTER_NAME[clusterId+1]
      if clusterName==nil then
        InfCore.Log("InfQuest.PrintQuestArea: WARNING: clusterName==nil")
      else
        InfCore.Log("Quest Area: Mtbs"..clusterName)
      end
    end
    return
  end

  local areaTypes={
    loadArea=false,
    invokeArea=false,
    activeArea=false,
  }

  local blockIndexX,blockIndexY=Tpp.GetCurrentStageSmallBlockIndex()

  local numAreas=#mvars.qst_questList
  for i=1,numAreas do
    local areasQuestInfo=mvars.qst_questList[i]

    for areaType,inArea in pairs(areaTypes)do
      areaTypes[areaType]=TppQuest.IsInsideArea(areaType,areasQuestInfo,blockIndexX,blockIndexY)
    end

    local inAnyArea=false
    for areaType,inArea in pairs(areaTypes)do
      if areaTypes[areaType]==true then
        inAnyArea=true
        break
      end
    end

    if inAnyArea then
      local areaInfoMessage="Quest Area: "..areasQuestInfo.areaName..", activeArea = "..tostring(areaTypes.activeArea)
      if(areaTypes.activeArea == true) then
        areaInfoMessage = areaInfoMessage.." | Location is suitable for Side Ops."
      else
        InfCore.DebugPrint("[Warning: Location is not suitable for Side Ops]")
      end
      InfCore.Log(areaInfoMessage,false,true)
    end
  end
end

this.PrintLatestUserMarker=function()
  local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
  if lastMarkerIndex==nil then
    InfCore.DebugPrint("lastMarkerIndex==nil")
  else
    local gameId=vars.userMarkerGameObjId[lastMarkerIndex]
    local x=vars.userMarkerPosX[lastMarkerIndex]
    local y=vars.userMarkerPosY[lastMarkerIndex]
    local z=vars.userMarkerPosZ[lastMarkerIndex]
    local closestCp=InfMain.GetClosestCp{x,y,z}

    if gameId==NULL_ID then
      InfCore.DebugPrint("gameId==NULL_ID")
      return
    end
    local soldierName=InfLookup.ObjectNameForGameId(gameId) or "Object name not found"
    InfCore.DebugPrint("Marked Soldier Name: "..tostring(soldierName))
    InfCore.DebugPrint("Nearest CP Name: "..tostring(closestCp))
    InfCore.Log("Marked Soldier Name: "..tostring(soldierName).."Nearest CP: "..tostring(closestCp))
  end
end

this.SpeedUpSoldiers=function()

  HighSpeedCamera.RequestEvent{continueTime=25,worldTimeRate=9,localPlayerTimeRate=1,timeRateInterpTimeAtStart=0,timeRateInterpTimeAtEnd=0,cameraSetUpTime=0,noDustEffect=true}

end

this.MarkAndSetAllFriendly=function()
  local function Vec3ToString(vec3)
    return vec3:GetX()..","..vec3:GetY()..","..vec3:GetZ()
  end
  local function PrintSoldierInfo(gameId,index)
    local pos=GameObject.SendCommand(gameId,{id="GetPosition"})
    local posString=Vec3ToString(pos)
    local name=InfLookup.ObjectNameForGameId(gameId)
    InfCore.Log("Soldier index "..index..": gameId:"..gameId.." name:"..tostring(name).." pos:"..posString)
  end

  local function SetFriendly(gameId)
    GameObject.SendCommand(gameId,{id="SetFriendly",enabled=true})
    TppMarker.Enable(gameId,0,"defend","map_and_world_only_icon",0,false,true)
  end

  local function SetHeliNoNotice(gameId)
    GameObject.SendCommand(gameId,{id="SetEyeMode",mode="Close"})
    GameObject.SendCommand(gameId,{id="SetRestrictNotice",enabled=true})
    GameObject.SendCommand(gameId,{id="SetCombatEnabled",enabled=false})
  end

  InfTppUtil.RunOnAllObjects("TppSoldier2",350,SetFriendly)
  local heliInstances=1

  if Ivars.attackHeliPatrolsFREE:Is()>0 then
    heliInstances=5
  end
  InfTppUtil.RunOnAllObjects("TppEnemyHeli",heliInstances,SetHeliNoNotice)

  for cpId,cpName in pairs(mvars.ene_cpList)do
    local command={id="SetFriendlyCp"}
    GameObject.SendCommand(cpId,command)
  end

  InfCore.DebugPrint("Soldiers set to Friendly")
end

this.ToggleChangePhase=function()

  if (vars.playerPhase == TppGameObject.PHASE_SNEAK) then
    for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
      InfEnemyPhase.ChangePhase(cpName,TppGameObject.PHASE_CAUTION)
    end
    InfCore.DebugPrint("Phase set to Caution")
  else
    for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
      InfEnemyPhase.ChangePhase(cpName,TppGameObject.PHASE_SNEAK)
    end
    InfCore.DebugPrint("Phase set to Sneak")
  end
end

this.inDemo={}

return this
