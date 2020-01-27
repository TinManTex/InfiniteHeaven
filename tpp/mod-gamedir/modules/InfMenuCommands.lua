--InfMenuCommands.lua
local this={}
--tex lines kinda blurry between Commands and Ivars, currently commands arent saved/have no gvar associated
--NOTE: tablesetup at end sets up every table in this with an OnChange as a menu command
--LOCALOPT:
local InfCore=InfCore
local InfMain=InfMain
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local SendCommand=GameObject.SendCommand

--menu menu items
this.menuOffItem={
  isMenuOff=true,
  OnChange=function()
    InfMenu.MenuOff()
    InfMenu.currentIndex=1
  end,
}
this.resetSettingsItem={
  isMenuOff=true,
  OnChange=function()
    InfMenu.ResetSettingsDisplay()
    InfMenu.MenuOff()
  end,
}
this.resetAllSettingsItem={
  isMenuOff=true,
  OnChange=function()
    InfMenu.PrintLangId"setting_all_defaults"
    InfMenu.ResetSettings()
    IvarProc.PrintNonDefaultVars()
    InfMenu.PrintLangId"done"
    InfMenu.MenuOff()
  end,
}
this.goBackItem={
  settingNames="set_goBackItem",
  OnChange=function()
    InfMenu.GoBackCurrent()
  end,
}

--commands

--profiles
this.applySelectedProfile={
  OnChange=function()
    local profileInfo=Ivars.selectProfile:GetProfileInfo()
    if profileInfo==nil then
      InfMenu.PrintLangId"no_profiles_installed"
      return
    end

    InfMenu.PrintLangId"applying_profile"
    IvarProc.ApplyProfile(profileInfo.profile)
  end,
}

this.resetSelectedProfile={
  OnChange=function()
    local profileInfo=Ivars.selectProfile:GetProfileInfo()
    if profileInfo==nil then
      InfMenu.PrintLangId"no_profiles_installed"
      return
    end

    InfMenu.PrintLangId"applying_profile"
    IvarProc.ResetProfile(profileInfo.profile)
  end,
}

this.viewProfile={
  OnChange=function()
    local profileInfo=Ivars.selectProfile:GetProfileInfo()
    if profileInfo==nil then
      InfMenu.PrintLangId"no_profiles_installed"
      return
    end

    local profileMenu=InfMenu.BuildProfileMenu(profileInfo.profile)
    IvarProc.ApplyProfile(profileInfo.profile)
    InfMenu.GoMenu(profileMenu)
  end,
}

this.revertProfile={
  OnChange=function()
    --tex revertProfile is built in BuildProfileMenu
    IvarProc.ApplyProfile(InfMenu.currentMenu.revertProfile)
    InfMenu.GoBackCurrent()
  end,
}

this.saveToProfile={
  OnChange=function()
    IvarProc.WriteProfile(true,false)
  end
}

this.printFaceInfo={
  OnChange=function()
    InfEneFova.PrintFaceInfo(vars.playerFaceId)
    this.PrintFaceInfo(vars.playerFaceId)
  end,
}

this.positions={}
this.positionsXML={}
this.showPosition={
  OnChange=function()
    if InfUtil.GetLocationName()=="afgh" or InfUtil.GetLocationName()=="mafr" then
      local blockNameStr32=Tpp.GetLoadedLargeBlock()
      local blockName=InfLookup.StrCode32ToString(blockNameStr32) or blockNameStr32
      InfCore.Log("Current large block:"..blockName,false,true)
      local blockIndexX,blockIndexY=Tpp.GetCurrentStageSmallBlockIndex()
      InfCore.Log("Current small block index: x:"..blockIndexX..",y:"..blockIndexY,false,true)
    end
    InfQuest.PrintQuestArea()

    --tex TODO: dump to seperate file
    local offsetY=0-- -0.78
    local x,y,z=vars.playerPosX,vars.playerPosY,vars.playerPosZ
    y=y+offsetY
    local rotY=vars.playerCameraRotation[1]
    local positionTable=string.format("{pos={%.3f,%.3f,%.3f},rotY=%.3f,},",x,y,z,rotY)
    local positionXML=string.format('<value x="%.3f" y="%.3f" z="%.3f" w="0" />',x,y,z)
    table.insert(this.positions,positionTable)
    table.insert(this.positionsXML,positionXML)

    --    InfCore.Log(positionTable)
    --    InfCore.Log(positionXML)
    InfCore.Log("positions:\n"..table.concat(this.positions,"\n"),false,true)
    InfCore.Log("positionsxml:\n"..table.concat(this.positionsXML,"\n"),false,true)
    InfCore.DebugPrint("Position written to ih_log")
  end,
}

this.showFreeCamPosition={
  OnChange=function()
    local currentCamName=InfCamera.GetCurrentCamName()
    local movePosition=InfCamera.ReadPosition(currentCamName)

    --tex TODO: dump to seperate file
    local x,y,z=movePosition:GetX(),movePosition:GetY(),movePosition:GetZ()
    local rotY=vars.playerCameraRotation[1]
    local positionTable=string.format("{pos={%.3f,%.3f,%.3f},rotY=%.3f,},",x,y,z,rotY)
    local positionXML=string.format('<value x="%.3f" y="%.3f" z="%.3f" w="0" />',x,y,z)
    table.insert(this.positions,positionTable)
    table.insert(this.positionsXML,positionXML)

    --    InfCore.Log(positionTable)
    --    InfCore.Log(positionXML)
    InfCore.Log("positions:\n"..table.concat(this.positions,"\n"),false,true)
    InfCore.Log("positionsxml:\n"..table.concat(this.positionsXML,"\n"),false,true)
    InfCore.DebugPrint("Position written to ih_log")
  end,
}

this.showMissionCode={
  OnChange=function()
    TppUiCommand.AnnounceLogView("MissionCode: "..vars.missionCode)--ADDLANG
  end,
}

this.showMbEquipGrade={
  OnChange=function()
    local soldierGrade = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
    local infGrade = InfMain.GetMbsClusterSecuritySoldierEquipGrade()
    TppUiCommand.AnnounceLogView("Security Grade: "..soldierGrade)--ADDLANG
    TppUiCommand.AnnounceLogView("Inf Grade: "..soldierGrade)--ADDLANG
  end,
}

this.showLangCode={
  OnChange=function()
    local languageCode=AssetConfiguration.GetDefaultCategory"Language"
    TppUiCommand.AnnounceLogView(InfMenu.LangString"language_code"..": "..languageCode)
  end,
}

this.showQuietReunionMissionCount={
  OnChange=function()
    TppUiCommand.AnnounceLogView("quietReunionMissionCount: "..gvars.str_quietReunionMissionCount)
  end,
}

this.ogrePointChange=90000
--tex see https://www.gamefaqs.com/boards/718564-metal-gear-solid-v-the-phantom-pain/72466130 for breakdown of the demon points levels.
this.setDemon={
  OnChange=function(self)
    --tex why aren't I using this again? not usable in tpp release build?
    --TppMotherBaseManagement.SetOgrePoint{ogrePoint=99999999}

    TppHero.SetOgrePoint(this.ogrePointChange)
    InfMenu.Print("-"..this.ogrePointChange .. InfMenu.LangString"set_demon")
  end,
}
this.removeDemon={
  OnChange=function(self)
    --TppMotherBaseManagement.SetOgrePoint{ogrePoint=1}
    --TppMotherBaseManagement.SubOgrePoint{ogrePoint=-999999999}
    TppHero.SetOgrePoint(-this.ogrePointChange)
    InfMenu.Print(this.ogrePointChange .. InfMenu.LangString"removed_demon")
  end,
}

this.returnQuiet={
  OnChange=function()
    if not TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)then
      InfMenu.PrintLangId"quiet_already_returned"--"Quiet has already returned."
    else
      InfMenu.PrintLangId"quiet_return"
      --InfPatch.QuietReturn()
      TppStory.RequestReunionQuiet()
    end
  end,
}

this.resetPaz={
  OnChange=function()
    gvars.pazLookedPictureCount=0
    gvars.pazEventPhase=0

    local demoNames = {
      "PazPhantomPain1",
      "PazPhantomPain2",
      "PazPhantomPain3",
      "PazPhantomPain4",
      "PazPhantomPain4_jp",
    }
    for i,demoName in ipairs(demoNames)do
      TppDemo.ClearPlayedMBEventDemoFlag(demoName)
    end
    InfMenu.PrintLangId"paz_reset"
  end
}

this.resetRevenge={
  OnChange=function()
    TppRevenge.ResetRevenge()
    TppRevenge._SetUiParameters()
    InfMenu.PrintLangId"revenge_reset"
  end,
}

this.pullOutHeli={
  OnChange=function()
    local gameObjectId=GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=GameObject.NULL_ID then
      GameObject.SendCommand(gameObjectId,{id="PullOut",forced=true})
    end
  end
}

--game progression unlocks

this.unlockPlayableAvatar={
  OnChange=function()
    if vars.isAvatarPlayerEnable==1 then
      InfMenu.PrintLangId"allready_unlocked"
    else
      vars.isAvatarPlayerEnable=1
    end
  end,
}
this.unlockWeaponCustomization={
  OnChange=function()
    if vars.mbmMasterGunsmithSkill==1 then
      InfMenu.PrintLangId"allready_unlocked"
    else
      vars.mbmMasterGunsmithSkill=1
    end
  end,
}

--
--this.resetCameraSettings={--CULL
--  OnChange=function()
--    InfMain.ResetCamPosition()
--    InfMenu.PrintLangId"cam_settings_reset"
--  end,
--}
--
this.doEnemyReinforce={--WIP
  OnChange=function()
  --TODO: GetClosestCp
  --  _OnRequestLoadReinforce(reinforceCpId)--NMC game message "RequestLoadReinforce"

  --or

  --  TppReinforceBlock.LoadReinforceBlock(reinforceType,reinforceCpId,reinforceColoringType)
  end,
}

--
this.printSightFormParameter={
  OnChange=function()
    InfSoldierParams.ApplySightIvarsToSoldierParams()
    InfSoldierParams.PrintSightForm()
  end,
}

this.printHearingTable={
  OnChange=function()
    InfSoldierParams.ApplyHearingIvarsToSoldierParams()
    InfCore.PrintInspect(InfSoldierParams.soldierParameters.hearingRangeParameter,{varName="hearingRangeParameter",announceLog=true,force=true})
  end,
}

this.printHealthTableParameter={
  OnChange=function()
    InfSoldierParams.ApplyHealthIvarsToSoldierParams()
    InfCore.PrintInspect(InfSoldierParams.lifeParameterTable,{varName="lifeParameterTable",announceLog=true,force=true})
  end,
}

this.printCustomRevengeConfig={
  OnChange=function()
    local revengeConfig=InfRevenge.CreateCustomRevengeConfig()
    InfCore.PrintInspect(revengeConfig,{varName="revengeConfig",announceLog=true,force=true})
  end
}

--debug commands

this.printCurrentAppearance={
  OnChange=function()
    InfMenu.Print("playerType: " .. tostring(vars.playerType))
    InfMenu.Print("playerCamoType: " .. tostring(vars.playerCamoType))
    InfMenu.Print("playerPartsType: " .. tostring(vars.playerPartsType))
    InfMenu.Print("playerFaceEquipId: " .. tostring(vars.playerFaceEquipId))
    InfMenu.Print("playerFaceId: " .. tostring(vars.playerFaceId))
    InfMenu.Print("playerHandType: " .. tostring(vars.playerHandType))
  end,
}

--quest TODO should probably put in infquest
this.forceAllQuestOpenFlagFalse={
  OnChange=function()
    for n,questIndex in ipairs(TppDefine.QUEST_INDEX)do
      gvars.qst_questOpenFlag[questIndex]=false
      gvars.qst_questActiveFlag[questIndex]=false
    end
    TppQuest.UpdateActiveQuest()
    InfMenu.PrintLangId"done"
  end,
}

this.rerollQuestSelection={
  OnChange=function()
    InfMain.RegenSeed(vars.missionCode,vars.missionCode)

    InfQuest.UpdateActiveQuest()
  end
}

--
this.warpToCamPos={
  OnChange=function()
    local warpPos=InfCamera.ReadPosition"FreeCam"
    InfCore.DebugPrint("warp pos:".. warpPos:GetX()..",".. warpPos:GetY().. ","..warpPos:GetZ())
    TppPlayer.Warp{pos={warpPos:GetX(),warpPos:GetY(),warpPos:GetZ()},rotY=vars.playerCameraRotation[1]}
  end,
}

this.warpToUserMarker={
  OnChange=function()
    if vars.playerVehicleGameObjectId~=NULL_ID then
      return
    end

    -- InfCore.DebugPrint"Warping to newest marker"
    local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
    if lastMarkerIndex==nil then
      --InfCore.DebugPrint("lastMarkerIndex==nil")
      InfMenu.PrintLangId"no_marker_found"
    else
      InfUserMarker.PrintUserMarker(lastMarkerIndex)
      InfUserMarker.WarpToUserMarker(lastMarkerIndex)
    end
  end
}

this.printUserMarkers={
  OnChange=function()InfUserMarker.PrintUserMarkers() end,
}

this.printLatestUserMarker={
  OnChange=function()
    local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
    if lastMarkerIndex==nil then
      InfCore.DebugPrint("lastMarkerIndex==nil")
    else
      InfUserMarker.PrintUserMarker(lastMarkerIndex)
      InfUserMarker.PrintMarkerGameObject(lastMarkerIndex)
    end
  end
}

this.setSelectedCpToMarkerObjectCp={
  OnChange=function()
    local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
    if lastMarkerIndex==nil then
      InfCore.DebugPrint("lastMarkerIndex==nil")
      return
    end
    --      InfMain.PrintUserMarker(lastMarkerIndex)
    --      InfMain.PrintMarkerGameObject(lastMarkerIndex)
    local gameId=vars.userMarkerGameObjId[lastMarkerIndex]

    if gameId==nil then
      InfCore.DebugPrint"gameId==nil"
      return
    end
    local soldierName,cpName=InfLookup.ObjectNameForGameId(gameId)
    if cpName==nil then
      InfCore.DebugPrint"cpName==nil"
      return
    end

    for cpId,currentName in pairs(mvars.ene_cpList)do
      --InfCore.DebugPrint(tostring(n).." "..tostring(currentName))
      if currentName==cpName then
        Ivars.selectedCp:Set(cpId)
        InfCore.DebugPrint("selectedCp set to "..cpId..":"..cpName)
        return
      end
    end

    InfCore.DebugPrint(cpName.." not found in ene_cpList")
    InfCore.PrintInspect(mvars.ene_cpList,{varName="mvars.ene_cpList",announceLog=true,force=true})
  end
}
function this.QuietMoveToLastMarker()
  if vars.buddyType~=BuddyType.QUIET then
    InfMenu.Print(InfMenu.LangString"current_buddy_not"..InfMenu.LangString"buddy_quiet")
    return
  end

  local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
  if lastMarkerIndex==nil then
    InfMenu.PrintLangId"no_marker_found"
  else
    local moveToPosition=InfUserMarker.GetMarkerPosition(lastMarkerIndex)
    local rotationY=TppMath.DegreeToRadian(vars.playerRotY)
    local gameId={type="TppBuddyQuiet2",index=0}
    if gameId==NULL_ID then
      InfMenu.PrintLangId"cant_find_quiet"
    else
      SendCommand(gameId,{id="MoveToPosition",position=moveToPosition,rotationY=rotationY})--,index=99,disableAim=true})
    end
  end
end
this.quietMoveToLastMarker={
  isMenuOff=true,
  OnChange=function()
    this.QuietMoveToLastMarker()

    InfMenu.MenuOff()
  end
}
--
this.ApplyFaceFova={
  OnChange=function()
    InfEneFova.ApplyFaceFova()
  end
}

--DEBUG CULL
function this.DEBUG_BuddyCycleVar(commandInfo)
  if vars.buddyType~=commandInfo.buddyType then
    InfMenu.Print(InfMenu.LangString"current_buddy_not"..InfMenu.LangString(commandInfo.nameLangId))
    return
  end

  local buddyGameId=GameObject.GetGameObjectIdByIndex(commandInfo.objectType,0)
  InfBuddy.buddyPosition=GameObject.SendCommand(buddyGameId,{id="GetPosition"})
  if InfBuddy.buddyPosition==nil then
    InfCore.DebugPrint("buddy GetPosition()==nil")--DEBUG
    InfBuddy.buddyPosition=Vector3(vars.playerPosX,vars.playerPosY+0.05,vars.playerPosZ)
  end
  InfBuddy.buddyType=commandInfo.buddyType

  TppBuddy2BlockController.CallBuddy(BuddyType.NONE,Vector3(0,0,0),0)

  local buddyVarTypeMax=5--DEBUG

  local function AdvanceType(varType)
    varType=varType+1
    if varType>buddyVarTypeMax then
      varType=0
    end
    return varType
  end

  local varType=AdvanceType(vars[commandInfo.varName])

  InfCore.DebugPrint("changed vars."..commandInfo.varName.." to "..varType)--DEBUG

  vars[commandInfo.varName]=varType

  GkEventTimerManager.Start("Timer_CycleBuddyReturn",0.3)
end

this.DEBUG_buddyCycleVar={
  isMenuOff=true,
  OnChange=function()
    this.DEBUG_BuddyCycleVar(InfBuddy.walkerGearChangeMainWeaponVar)
  end
}

local buddyIndex=1
this.DEBUG_buddyCycle={
  OnChange=function()
    local position=Vector3(vars.playerPosX,vars.playerPosY+1,vars.playerPosZ)
    local buddyTypes={
      --BuddyType.NONE,
      BuddyType.QUIET,
      BuddyType.HORSE,
      BuddyType.DOG,
      BuddyType.WALKER_GEAR,
    }
    local buddyType=buddyTypes[buddyIndex]
    TppBuddyService.UnsetDisableCallBuddyType(buddyType)
    TppBuddy2BlockController.CallBuddy(buddyType,position,0)

    buddyIndex=buddyIndex+1
    if buddyIndex>#buddyTypes then
      buddyIndex=1
    end
  end
}

local parasiteToggle=false
this.DEBUG_ToggleParasiteEvent={
  OnChange=function()
    parasiteToggle=not parasiteToggle
    if parasiteToggle then
      InfParasite.InitEvent()
      InfParasite.StartEvent()
    else
      InfParasite.EndEvent()
    end
  end
}

this.requestHeliLzToLastMarker={
  isMenuOff=true,
  OnChange=function()
    local locationName=InfUtil.GetLocationName()
    if locationName~="afgh" and locationName~="mafr" then
      InfMenu.PrintLangId"not_for_location"
      return
    end

    local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
    if lastMarkerIndex==nil then
      InfMenu.PrintLangId"no_marker_found"
    else
      local markerPostion=InfUserMarker.GetMarkerPosition(lastMarkerIndex)
      markerPostion={markerPostion:GetX(),markerPostion:GetY(),markerPostion:GetZ()}

      local closestRoute=InfMain.GetClosestLz(markerPostion)
      if closestRoute==nil then
        InfMenu.PrintLangId"no_lz_found"
        return
      end

      --closestRoute=InfLZ.str32LzToLz[closestRoute]--CULL
      if not TppLandingZone.assaultLzs[locationName] then
        InfCore.DebugPrint"WARNING: TppLandingZone.assaultLzs[locationName]==nil"--DEBUG
      end
      local lzName=TppLandingZone.assaultLzs[locationName][closestRoute] or TppLandingZone.missionLzs[locationName][closestRoute]
      --InfCore.DebugPrint("Pos Lz Name:"..tostring(closestRoute).." ArpName for lz name:"..tostring(aprRoute))--DEBUG

      local heliId=GetGameObjectId("TppHeli2","SupportHeli")
      if heliId==NULL_ID then
        --InfCore.DebugPrint"heliId==NULL_ID"--DEBUG
        return
      end
      SendCommand(heliId,{id="CallToLandingZoneAtName",name=lzName})
    end

    InfMenu.MenuOff()
  end
}

--WIP
local forceRouteOn=false
this.requestHeliLzToLastMarkerAlt={
  isMenuOff=true,
  OnChange=function()
    --TODO bail if not in heli

    local heliId=GetGameObjectId("TppHeli2","SupportHeli")
    if heliId==NULL_ID then
      InfCore.Log("WARNING: SupportHeli heliId==NULL_ID",true)--DEBUG
      return
    end

    local locationName=InfUtil.GetLocationName()
    if locationName~="afgh" and locationName~="mafr" then
      InfMenu.PrintLangId"not_for_location"
      return
    end

    local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
    local closestRoute
    if lastMarkerIndex==nil then
      InfMenu.PrintLangId"no_marker_found"
      return
    else
      local markerPostion=InfUserMarker.GetMarkerPosition(lastMarkerIndex)
      markerPostion={markerPostion:GetX(),markerPostion:GetY(),markerPostion:GetZ()}

      closestRoute=InfMain.GetClosestLz(markerPostion)
    end

    --if not forceRouteOn then
    if closestRoute==nil then
      InfMenu.PrintLangId"no_lz_found"
      return
    end

    local lzName=TppLandingZone.assaultLzs[locationName][closestRoute] or TppLandingZone.missionLzs[locationName][closestRoute]
    if lzName==nil then
      InfMenu.PrintLangId"no_lz_found"
      InfCore.Log("lzName==nil")
      return
    end

    InfCore.Log("Pos Lz Name:"..tostring(closestRoute).." ArpName for lz name:"..tostring(lzName),true)--DEBUGNOW
    local lzInfo=InfLZ.lzInfo[lzName]
    if not lzInfo then
      InfCore.Log("no lzInfo for "..tostring(lzName))
    else
      closestRoute=lzInfo.returnRoute
      --closestRoute=lzInfo.approachRoute
      --closestRoute=lzInfo.dropRoute
    end


    SendCommand(heliId,{id="CallToLandingZoneAtName",name=lzName})--tex will only update if player not in heli and heli not forceroute

    --tex if no point (route node index) is supplied it will path to the nearest point
    --this is an issue if thats past the node at the lz
    --point 0 is first node, which can be an issue for dropRoute,approachRoute which has a starting point away from lz
    --but good for returnRoute which starts at lz
    --can use warp to figure out where the points are
    SendCommand(heliId,{id="SetForceRoute",route=closestRoute,point=0})--,warp=true})--DEBUG

    --SendCommand(heliId,{id="CallToLandingZoneAtName",name=lzName})

    forceRouteOn=not forceRouteOn

    InfMenu.MenuOff()
  end
}


this.forceExitHeli={
  isMenuOff=true,
  OnChange=function()
    if not Tpp.IsHelicopter(vars.playerVehicleGameObjectId)then
      InfMenu.PrintLangId"not_in_heli"
    else
      Player.HeliSideToFOBStartPos()
      InfMenu.MenuOff()
    end
  end
}

--WIP
this.forceExitHeliAlt={
  isMenuOff=true,
  OnChange=function()
    if not Tpp.IsHelicopter(vars.playerVehicleGameObjectId)then
      InfMenu.PrintLangId"not_in_heli"
    else
      Player.RequestToPlayDirectMotion{
        "nothing",
        {
          "",
          false,
          "",
          "",
          "",
          false
        }
      }

      --tex TODO need to wait for RequestToPlayDirectMotion to stop before can warp

      local currentPos={vars.playerPosX,vars.playerPosY,vars.playerPosZ}
      local closestRoute,closestDist,closestPos=InfMain.GetClosestLz(currentPos)
      TppPlayer.Warp{pos=closestPos,rotY=vars.playerCameraRotation[1]}
      InfMenu.MenuOff()
    end
  end
}

this.forceGameEvent={
  OnChange=function()
    InfGameEvent.ForceEvent()
  end
}

this.forceRegenSeed={
  OnChange=function()
    InfMain.RegenSeed(40010)
  end
}

this.printBodyInfo={
  OnChange=function()
    InfFova.GetCurrentFovaTable(true)
  end
}

this.DEBUG_PrintInterrogationInfo={
  OnChange=function()
    --tex roll back one since warpto advances after it's done
    local index= this.currentWarpIndex-1
    if index==0 then--tex except if there's only 1 in the object list
      index=this.currentWarpIndex
    end
    local objectName=this.warpObjecList[index]
    local gameId=objectName
    if type(objectName)=="string" then
      gameId=GameObject.GetGameObjectId(objectName)
    end
    if gameId==nil or gameId==GameObject.NULL_ID then
      InfCore.DebugPrint"gameId== nil or NULL_ID"
      return
    end

    local soldierICPQId=InfInterrogation.GetInterCpQuestId(gameId)
    if soldierICPQId==nil then
      InfCore.DebugPrint"cannot find cpQuestId for soldier"--DEBUG
      return
    end

    local cpName=InfInterrogation.interCpQuestSoldiersCps[soldierICPQId]
    if cpName==nil then
      InfCore.DebugPrint"cpName==nil"--DEBUG
      return
    end
    InfCore.DebugPrint("quest cpName:"..cpName)
  end
}

local toggle1=false
local index1Min=1
local index1Max=4
local index1=index1Min
local count=0
this.log=""
this.DEBUG_SomeShiz={
  OnChange=function()
    count=count+1
    InfCore.Log("---------------------DEBUG_SomeShiz---------------------"..count)

    InfCore.DebugPrint("index1:"..index1)
    index1=index1+1
    if index1>index1Max then
      index1=index1Min
    end
    toggle1=not toggle1
  end
}

local index2Min=300
local index2Max=334
local index2=index2Min
this.DEBUG_SomeShiz2={
  OnChange=function()
    InfCore.Log("---DEBUG_SomeShiz2---")

    InfCore.DebugPrint("index2:"..index2)
    index2=index2+1
    if index2>index2Max then
      index2=index2Min
    end
  end
}

local index3Min=1
local index3Max=10
local index3=index3Min
local toggle3=false
this.DEBUG_SomeShiz3={
  OnChange=function()
    InfCore.Log("---DEBUG_SomeShiz3---")

    InfCore.DebugPrint("index3:"..index3)
    index3=index3+1
    if index3>index3Max then
      index3=index3Min
    end
    toggle3=not toggle3
  end
}

this.log=""
this.DEBUG_RandomizeAllIvars={
  OnChange=function()
    --tex randomize (most)all ivars
    local skipIvars={
      debugMode=true,

      abortMenuItemControl=true,

      mbDemoSelection=true,

      warpPlayerUpdate=true,
      adjustCameraUpdate=true,
      --non user
      mbHostileSoldiers=true,
      mbEnableLethalActions=true,
      mbNonStaff=true,
      mbZombies=true,
      mbEnemyHeli=true,
      npcUpdate=true,
      heliUpdate=true,

      --WIP/OFF
      disableTranslators=true,
      vehiclePatrolPaintType=true,
      vehiclePatrolEmblemType=true,
      mbShowQuietCellSigns=true,
      manualMissionCode=true,
      playerHandEquip=true,
      cpAlertOnVehicleFulton=true,
      enableGetOutHeli=true,
      forceSoldierSubType=true,
      setTakeOffWaitTime=true,
      disableNoRevengeMissions=true,
    }

    local log=""

    local ivarNames={}
    local function IsIvar(ivar)--TYPEID
      return type(ivar)=="table" and (ivar.range or ivar.settings)
    end
    for name,ivar in pairs(Ivars) do
      if IsIvar(ivar) then
        if not ivar.range or not ivar.range.max then
          InfCore.DebugPrint("WARNING: ivar "..name.." hase no range set")
        elseif not skipIvars[name] and ivar.save then
          table.insert(ivarNames,name)
        end
      end
    end

    --divide and conquor
    local fraction=math.ceil(#ivarNames/4)

    local start=0
    local finish=#ivarNames--110

    --      local start=fraction--55
    --      local finish=fraction*2--110
    --      local start=80--55
    --      local finish=110--110
    --
    --      local start=80
    --      local finish=100
    --
    --      local start=80
    --      local finish=90
    --
    --      local start=80
    --      local finish=85

    --      local start=80
    --      local finish=83

    --        local start=84
    --        local finish=85

    InfCore.DebugPrint("start: "..start.." finish: "..finish)

    for i,name in ipairs(ivarNames) do
      if i>finish then
        break
      end
      if i>=start then

        local ivar=Ivars[name]
        ivar:Set(math.random(ivar.range.min,ivar.range.max))

        --if ivar.setting~=ivar.default then
        log=log..name.."\n"

        --end
      end
    end
    InfCore.DebugPrint(tostring(log))
  end
}

this.DEBUG_SetIvarsToNonDefault={
  OnChange=function()
    --tex randomize (most)all ivars
    local skipIvars={
      debugMode=true,

      abortMenuItemControl=true,

      mbDemoSelection=true,

      warpPlayerUpdate=true,
      adjustCameraUpdate=true,
      --non user
      mbHostileSoldiers=true,
      mbEnableLethalActions=true,
      mbNonStaff=true,
      mbZombies=true,
      mbEnemyHeli=true,
      npcUpdate=true,
      heliUpdate=true,

      --WIP/OFF
      disableTranslators=true,
      vehiclePatrolPaintType=true,
      vehiclePatrolEmblemType=true,
      mbShowQuietCellSigns=true,
      manualMissionCode=true,
      playerType=true,
      playerCamoType=true,
      playerPartsType=true,
      playerFaceEquipIdApearance=true,
      playerFaceIdApearance=true,
      playerHandEquip=true,
      cpAlertOnVehicleFulton=true,
      enableGetOutHeli=true,
      forceSoldierSubType=true,
      setTakeOffWaitTime=true,
      disableNoRevengeMissions=true,
    }

    local ivarNames={}
    local function IsIvar(ivar)--TYPEID
      return type(ivar)=="table" and (ivar.range or ivar.settings)
    end
    for name,ivar in pairs(Ivars) do
      if IsIvar(ivar) then
        if not ivar.range or not ivar.range.max then
          InfCore.DebugPrint("WARNING: ivar "..name.." hase no range set")
        elseif not skipIvars[name] and ivar.save then
          table.insert(ivarNames,name)
        end
      end
    end

    for i,name in ipairs(ivarNames) do
      local ivar=Ivars[name]
      local value=ivar.default+ivar.range.increment
      if value>ivar.range.max then
        value=ivar.default-ivar.range.increment
      end

      ivar:Set(value)
    end
  end
}

--SYNC run PrintIvars on main.
this.DEBUG_SetIvarsToDefault={
  OnChange=function()
    InfCore.DebugPrint"DEBUG_SetIvarsToDefault"

    local ivarNames={
      }

    for i,ivarName in pairs(ivarNames) do
      local ivar=Ivars[ivarName]
      local currentSetting=ivars[ivarName]
      if ivar==nil then
        InfCore.Log(ivarName.."==nil")

      elseif not ivar.save then
      --InfCore.DebugPrint(ivarName.." save not set")
      elseif currentSetting~=ivar.default then
        InfCore.Log(ivarName..":"..tostring(currentSetting).." not default:"..tostring(ivar.default)..", resetting")
        IvarProc.SetSetting(ivar,ivar.default)
      end
    end
  end
}
--higspeedcamera / slowmo
local highSpeedCamToggle=false
local highSpeedCamStartTime=0
this.highSpeedCameraToggle={
  OnChange=function()
    --GOTCHA: toggle could fail on reload or other cam requestcancel with a long continuetime/highSpeedCamStartTime
    --      local elapsedTime=Time.GetRawElapsedTimeSinceStartUp()
    --      if elapsedTime>highSpeedCamStartTime then--cam timed out
    --        highSpeedCamToggle=true
    --      else
    --        highSpeedCamToggle=false
    --      end

    highSpeedCamToggle=not highSpeedCamToggle

    if highSpeedCamToggle then
      local continueTime=Ivars.speedCamContinueTime:Get()
      local worldTimeRate=Ivars.speedCamWorldTimeScale:Get()
      local localPlayerTimeRate=Ivars.speedCamPlayerTimeScale:Get()
      local timeRateInterpTimeAtStart=0
      local timeRateInterpTimeAtEnd=0
      local cameraSetUpTime=0
      local noDustEffect=Ivars.speedCamNoDustEffect:Is(1)

      --highSpeedCamStartTime=elapsedTime+continueTime

      HighSpeedCamera.RequestEvent{continueTime=continueTime,worldTimeRate=worldTimeRate,localPlayerTimeRate=localPlayerTimeRate,timeRateInterpTimeAtStart=timeRateInterpTimeAtStart,timeRateInterpTimeAtEnd=timeRateInterpTimeAtEnd,cameraSetUpTime=cameraSetUpTime,noDustEffect=noDustEffect}

      --InfMenu.PrintLangId"highspeedcam_on"--DEBUG
    else
      highSpeedCamStartTime=0

      HighSpeedCamera.RequestToCancel()

      InfMenu.PrintLangId"highspeedcam_cancel"
    end
  end
}

this.clearLog={
  OnChange=function()
    InfCore.ClearLog()
  end
}
--
this.DEBUG_PrintRevengePoints={
  OnChange=function()
    --tex from TppRevenge. , cutting out dummy, max, and reordering to ui order
    local REVENGE_TYPE_NAME={"FULTON","HEAD_SHOT","STEALTH","COMBAT","NIGHT_S","NIGHT_C","LONG_RANGE","VEHICLE","TRANQ","SMOKE","M_STEALTH","M_COMBAT"}

    --      InfCore.DebugPrint"Revenge Levels"
    local revengeLevelsStr=""
    --      for i,revengeTypeName in ipairs(REVENGE_TYPE_NAME)do
    --        revengeLevelsStr=revengeLevelsStr..revengeTypeName..":"..tostring(TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE[revengeTypeName]))
    --        revengeLevelsStr=revengeLevelsStr.." "
    --      end
    --      InfCore.DebugPrint(revengeLevelsStr)

    InfCore.DebugPrint"Revenge points:"
    InfCore.Log("Revenge points:",false,true)
    local revengeLevelsStr=""
    for i,revengeTypeName in ipairs(REVENGE_TYPE_NAME)do
      revengeLevelsStr=revengeLevelsStr..revengeTypeName..":"..tostring(TppRevenge.GetRevengePoint(TppRevenge.REVENGE_TYPE[revengeTypeName]))
      revengeLevelsStr=revengeLevelsStr.." "
    end
    InfCore.DebugPrint(revengeLevelsStr)
    InfCore.Log(revengeLevelsStr,false,true)
  end
}

this.DEBUG_PrintHeliPos={
  OnChange=function()
    InfNPCHeli.PrintHeliPos()
  end
}

local routeIndex=1
this.heliRoute=nil
local heliRoutes={}
this.DEBUG_CycleHeliRoutes={
  OnChange=function()
    local StrCode32=Fox.StrCode32
    local heliName="SupportHeli"--EnemyHeli0000"
    local heliIndex=1
    local heliObjectId = GetGameObjectId(heliName)
    if heliObjectId==NULL_ID then
    --InfCore.DebugPrint(heliName.."==NULL_ID")--DEBUG
    else
      if #heliRoutes==0 then
        --heliRoutes=this.ResetLzPool()
        heliRoutes=InfUtil.CopyList(InfNPCHeli.heliRoutes.afgh)
      end
      --InfCore.PrintInspect(heliRoutes)--DEBUG
      this.heliRoute=StrCode32(heliRoutes[routeIndex])
      routeIndex=routeIndex+1
      if routeIndex>#heliRoutes then
        routeIndex=1
      end

      InfNPCHeli.SetRoute(this.heliRoute,heliIndex)
      --InfCore.DebugPrint(heliName.." setting route: "..tostring(InfLookup.str32LzToLz[this.heliRoute]))--DEBUG
      --GameObject.SendCommand(heliObjectId,{id="SetForceRoute",route=this.heliRoute,point=0,warp=true})
    end
    local groundStartPosition=InfLZ.GetGroundStartPosition(this.heliRoute)
    if groundStartPosition==nil then
      InfCore.DebugPrint" groundStartPosition==nil"
    else
      InfCore.DebugPrint("warped to "..tostring(InfLookup.str32LzToLz[this.heliRoute]))--DEBUG
      TppPlayer.Warp{pos={groundStartPosition.pos[1],groundStartPosition.pos[2],groundStartPosition.pos[3]},rotY=vars.playerCameraRotation[1]}
    end
  end
}

local fovaIndex=1
this.DEBUG_FovaTest={
  OnChange=function()
    Player.SetPartsInfoAtInstanceIndex("/Assets/tpp/parts/chara/sna/sna1_main0_def_v00.parts")
    --Player.RequestToUnloadAllPartsBlock()
    --Player.RequestToLoadPartsBlock("PLTypeHospital")
  end
}

this.DEBUG_DropItem={
  OnChange=function()

    local downposition=Vector3(vars.playerPosX,vars.playerPosY+1,vars.playerPosZ)
    --  TppPickable.DropItem{
    --    equipId =  TppEquip.EQP_IT_DevelopmentFile,
    --    number = TppMotherBaseManagementConst.DESIGN_2006,
    --    position = downposition,
    --    rotation = Quat.RotationY( 0 ),
    --    linearVelocity = Vector3(0,2,0),--Vector3( 0, 2, 0 ),
    --    angularVelocity = Vector3(0,2,0),--Vector3( 0, 2, 0 )
    --  }

    local linearMax=2
    local angularMax=14
    TppPickable.DropItem{
      equipId =  TppEquip.EQP_SWP_SmokeGrenade_G01,--EQP_SWP_C4_G04,
      number = 65535,
      position = downposition,
      rotation = Quat.RotationY( 0 ),
      linearVelocity = Vector3(math.random(-linearMax,linearMax),math.random(-linearMax,linearMax),math.random(-linearMax,linearMax)),
      angularVelocity = Vector3(math.random(-angularMax,angularMax),math.random(-angularMax,angularMax),math.random(-angularMax,angularMax)),
    }

  end
}

this.DEBUG_PrintVarsClock={
  OnChange=function()
    InfCore.DebugPrint("vars.clock:"..vars.clock)
  end,
}

this.DEBUG_PrintFultonSuccessInfo={
  OnChange=function()
    local mbFultonRank=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_FULTON}
    local mbSectionSuccess=TppPlayer.mbSectionRankSuccessTable[mbFultonRank]or 0

    InfCore.DebugPrint("mbFultonRank:"..mbFultonRank.." mbSectionSuccess:"..mbSectionSuccess)

    --  local doFuncSuccess=TppTerminal.DoFuncByFultonTypeSwitch(gameId,RENAMEanimalId,r,staffOrReourceId,nil,nil,nil,this.GetSoldierFultonSucceedRatio,this.GetVolginFultonSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio)
    --
    --  if doFuncSuccess==nil then
    --    InfCore.DebugPrint"doFuncSuccess nil, bumped to 100"
    --    doFuncSuccess=100
    --  end
    --  InfCore.DebugPrint("doFuncSuccess:"..doFuncSuccess)

  end,
}

this.DEBUG_ShowRevengeConfig={
  OnChange=function()
    --InfCore.DebugPrint("RevRandomValue: "..gvars.rev_revengeRandomValue)
    InfCore.DebugPrint("RevengeType:")
    InfCore.PrintInspect(mvars.revenge_revengeType,{varName="mvars.revenge_revengeType"})

    InfCore.DebugPrint("RevengeConfig:")
    InfCore.PrintInspect(mvars.revenge_revengeConfig,{varName="mvars.revenge_revengeConfig"})
  end,
}

this.DEBUG_PrintSoldierDefine={
  OnChange=function()
    InfCore.PrintInspect(mvars.ene_soldierDefine,{varName="mvars.ene_soldierDefine"})
  end,
}


this.DEBUG_PrintSoldierIDList={
  OnChange=function()
    InfCore.PrintInspect(mvars.ene_soldierIDList,{varName="mvars.ene_soldierIDList"})
  end,
}


this.DEBUG_PrintReinforceVars={
  OnChange=function()
    InfCore.DebugPrint("reinforce_activated: "..tostring(mvars.reinforce_activated))
    InfCore.DebugPrint("reinforceType: "..mvars.reinforce_reinforceType)
    InfCore.DebugPrint("reinforceCpId: "..mvars.reinforce_reinforceCpId)
    InfCore.DebugPrint("isEnabledSoldiers: "..tostring(mvars.reinforce_isEnabledSoldiers))
    InfCore.DebugPrint("isEnabledVehicle: "..tostring(mvars.reinforce_isEnabledVehicle))
  end,
}

this.DEBUG_PrintVehicleTypes={
  OnChange=function()
    InfCore.DebugPrint("Vehicle.type.EASTERN_LIGHT_VEHICLE="..Vehicle.type.EASTERN_LIGHT_VEHICLE)
    InfCore.DebugPrint("Vehicle.type.WESTERN_LIGHT_VEHICLE="..Vehicle.type.WESTERN_LIGHT_VEHICLE)
    InfCore.DebugPrint("Vehicle.type.EASTERN_TRUCK="..Vehicle.type.EASTERN_TRUCK)
    InfCore.DebugPrint("Vehicle.type.WESTERN_TRUCK="..Vehicle.type.WESTERN_TRUCK)
    InfCore.DebugPrint("Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE="..Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE)
    InfCore.DebugPrint("Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE="..Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE)
    InfCore.DebugPrint("Vehicle.type.EASTERN_TRACKED_TANK="..Vehicle.type.EASTERN_TRACKED_TANK)
    InfCore.DebugPrint("Vehicle.type.WESTERN_TRACKED_TANK="..Vehicle.type.WESTERN_TRACKED_TANK)
  end,
}

this.DEBUG_PrintVehiclePaint={
  OnChange=function()
    InfCore.DebugPrint("Vehicle.class.DEFAULT="..Vehicle.class.DEFAULT)
    InfCore.DebugPrint("Vehicle.class.DARK_GRAY="..Vehicle.class.DARK_GRAY)
    InfCore.DebugPrint("Vehicle.class.OXIDE_RED="..Vehicle.class.OXIDE_RED)
    InfCore.DebugPrint("Vehicle.paintType.NONE="..Vehicle.paintType.NONE)
    InfCore.DebugPrint("Vehicle.paintType.FOVA_0="..Vehicle.paintType.FOVA_0)
    InfCore.DebugPrint("Vehicle.paintType.FOVA_1="..Vehicle.paintType.FOVA_1)
    InfCore.DebugPrint("Vehicle.paintType.FOVA_2="..Vehicle.paintType.FOVA_2)
  end,
}

this.DEBUG_RandomizeCp={--CULL only for debug purpose with a print in the function
  OnChange=function()
    InfMain.RandomizeCpSubTypeTable()
  end,
}

this.DEBUG_PrintRealizedCount={
  OnChange=function()
    InfCore.DebugPrint("MAX_REALIZED_COUNT:"..EnemyFova.MAX_REALIZED_COUNT)
  end,
}
this.DEBUG_PrintEnemyFova={
  OnChange=function()
    InfCore.PrintInspect(EnemyFova)
    InfCore.PrintInspect(getmetatable(EnemyFova))
  end,
}

this.DEBUG_PrintPowersCount={
  OnChange=function()
    --InfCore.PrintInspect(mvars.ene_soldierPowerSettings)
    local totalPowerSettings={}

    local totalSoldierCount=0
    local armorCount=0
    local lrrpCount=0
    for soldierId, powerSettings in pairs(mvars.ene_soldierPowerSettings) do
      totalSoldierCount=totalSoldierCount+1
      for powerType,setting in pairs(powerSettings)do
        if totalPowerSettings[powerType]==nil then
          totalPowerSettings[powerType]=0
        end

        totalPowerSettings[powerType]=totalPowerSettings[powerType]+1
      end
    end
    InfCore.DebugPrint("totalSoldierCount:"..totalSoldierCount)
    InfCore.PrintInspect(totalPowerSettings)
  end
}

this.DEBUG_PrintCpPowerSettings={
  OnChange=function()
    --InfCore.PrintInspect(mvars.ene_soldierPowerSettings)
    if Ivars.selectedCp:Is()>0 then
      local soldierList=mvars.ene_soldierIDList[Ivars.selectedCp:Get()]
      if soldierList then
        for soldierId,n in pairs(soldierList)do
          InfCore.PrintInspect(mvars.ene_soldierPowerSettings[soldierId])
        end
      end
    end
  end
}

this.DEBUG_PrintCpSizes={
  OnChange=function()
    local cpTypesCount={
      cp=0,
      ob=0,
      lrrp=0,
    }
    local cpTypesTotal={
      cp=0,
      ob=0,
      lrrp=0,
    }
    local cpTypesAverage={
      cp=0,
      ob=0,
      lrrp=0,
    }

    local cpSizes={}
    for cpName,cpDefine in pairs(mvars.ene_soldierDefine)do
      local soldierCount=0


      for key,value in ipairs(cpDefine)do
        if type(value)=="string" then
          soldierCount=soldierCount+1
        end
      end

      if soldierCount~=0 then
        if string.find(cpName, "_cp")~=nil then
          cpTypesCount.cp=cpTypesCount.cp+1
          cpTypesTotal.cp=cpTypesTotal.cp+soldierCount
        elseif string.find(cpName, "_ob")~=nil then
          cpTypesCount.ob=cpTypesCount.cp+1
          cpTypesTotal.ob=cpTypesTotal.ob+soldierCount
        elseif string.find(cpName, "_lrrp")~=nil then
          cpTypesCount.lrrp=cpTypesCount.lrrp+1
          cpTypesTotal.lrrp=cpTypesTotal.lrrp+soldierCount
        end

        cpSizes[cpName]=soldierCount
      end
    end

    for cpType,total in pairs(cpTypesTotal)do
      if cpTypesCount[cpType]~=0 then
        cpTypesAverage[cpType]=total/cpTypesCount[cpType]
      end
    end

    InfCore.PrintInspect(cpSizes)
    InfCore.PrintInspect(cpTypesAverage)
  end
}

this.DEBUG_ChangePhase={
  OnChange=function()
    InfCore.DebugPrint("Changephase b")
    for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
      InfMain.ChangePhase(cpName,Ivars.maxPhase:Get())
    end
    InfCore.DebugPrint("Changephase e")
  end
}

this.DEBUG_KeepPhaseOn={
  OnChange=function()
    InfCore.DebugPrint("DEBUG_KeepPhaseOn b")
    for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
      InfMain.SetKeepAlert(cpName,true)
    end
    InfCore.DebugPrint("DEBUG_KeepPhaseOn e")
  end
}

this.DEBUG_KeepPhaseOff={
  OnChange=function()
    InfCore.DebugPrint("DEBUG_KeepPhaseOff b")
    for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
      InfMain.SetKeepAlert(cpName,false)
    end
    InfCore.DebugPrint("DEBUG_KeepPhaseOff e")
  end
}

this.printPlayerPhase={
  OnChange=function()
    InfCore.DebugPrint("vars.playerPhase=".. vars.playerPhase ..":".. Ivars.phaseSettings[vars.playerPhase+1])
  end,
}

this.DEBUG_SetPlayerPhaseToIvar={
  OnChange=function()
    vars.playerPhase=Ivars.maxPhase:Get()
  end,
}

this.DEBUG_ShowPhaseEnums={
  OnChange=function()
    for n, phaseName in ipairs(Ivars.maxPhase.settings) do
      InfCore.DebugPrint(phaseName..":".. Ivars.maxPhase.settingsTable[n])
    end
  end,
}


this.DEBUG_Item2={
  OnChange=function()
    InfCore.DebugPrint("EnemyTypes:")
    InfCore.DebugPrint("TYPE_DD:"..EnemyType.TYPE_DD)
    InfCore.DebugPrint("TYPE_SKULL:"..EnemyType.TYPE_SKULL )
    InfCore.DebugPrint("TYPE_SOVIET:"..EnemyType.TYPE_SOVIET)
    InfCore.DebugPrint("TYPE_PF:"..EnemyType.TYPE_PF )
    InfCore.DebugPrint("TYPE_CHILD:".. EnemyType.TYPE_CHILD )
    --InfCore.PrintInspect(gvars.soldierTypeForced)
  end,
}

this.DEBUG_InspectAllMenus={
  OnChange=function()
    --InfCore.PrintInspect(InfMenuDefs.allMenus)
    for n,menu in ipairs(InfMenuDefs.allMenus) do
      if menu==nil then
        InfCore.DebugPrint("menu==nil at index "..n)
      elseif menu.name==nil then
        InfCore.DebugPrint("menu.name==nil at index "..n)
      else
        InfMenu.PrintLangId(menu.name)
      end
    end
  end,
}

this.DEBUG_ClearAnnounceLog={
  OnChange=function()
    --TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")--pretty sure this is disable
    TppUiStatusManager.ClearStatus"AnnounceLog"
  end,
}

this.currentWarpIndex=1
local singleStep=false
this.DEBUG_WarpToObject={
  OnChange=function()
    local objectList=InfMain.reserveSoldierNames
    --        local travelPlan="travelArea2_01"
    --         local objectList=InfVehicle.inf_patrolVehicleConvoyInfo[travelPlan]
    --local objectList=InfSoldier.ene_wildCardNames
    --local objectList=InfParasite.parasiteNames.CAMO
    --local objectList=InfLookup.truckNames
    --local objectList={"veh_trc_0000"}
    --local objectList=InfLookup.jeepNames
    --local objectList={TppReinforceBlock.REINFORCE_DRIVER_SOLDIER_NAME}
    --local objectList=TppReinforceBlock.REINFORCE_SOLDIER_NAMES
    --local objectList=InfInterrogation.interCpQuestSoldiers
    --local objectList=InfWalkerGear.walkerNames
    --local objectList=InfNPCHeli.heliList

    if objectList==nil then
      InfCore.DebugPrint"objectList nil"
      return
    end
    this.warpObjecList=objectList

    if #objectList==0 then
      InfCore.DebugPrint"objectList empty"
      return
    end

    local stepCount=0
    local warpPos=Vector3(0,0,0)
    local objectName="NULL"
    local function Step()
      objectName=objectList[this.currentWarpIndex]
      local gameId=objectName
      if type(objectName)=="string" then
        gameId=GameObject.GetGameObjectId(objectName)
      end
      if gameId==nil or gameId==GameObject.NULL_ID then
        InfCore.Log(objectName.." gameId==NULL_ID")
        warpPos=Vector3(0,0,0)
      else
        warpPos=GameObject.SendCommand(gameId,{id="GetPosition"})
        if warpPos==nil then
          InfCore.Log("GetPosition nil for "..objectName,true)
          return
        else
          InfCore.Log(this.currentWarpIndex..":"..objectName.." pos:".. warpPos:GetX()..",".. warpPos:GetY().. ","..warpPos:GetZ(),true)
        end
      end
      this.currentWarpIndex=this.currentWarpIndex+1
      if this.currentWarpIndex>#objectList then
        this.currentWarpIndex=1
      end
      stepCount=stepCount+1
    end

    while (warpPos:GetX()==0 and warpPos:GetY()==0 and warpPos:GetZ()==0) and stepCount<=#objectList do
      Step()
      if singleStep then
        break
      end
    end

    if warpPos:GetX()~=0 or warpPos:GetY()~=0 or warpPos:GetZ()~=0 then
      InfCore.DebugPrint(objectName.." pos:".. warpPos:GetX()..",".. warpPos:GetY().. ","..warpPos:GetZ())
      TppPlayer.Warp{pos={warpPos:GetX(),warpPos:GetY()+1,warpPos:GetZ()},rotY=vars.playerCameraRotation[1]}
    end
  end,
}

this.DEBUG_WarpToReinforceVehicle={
  OnChange=function()
    local vehicleId=GameObject.GetGameObjectId("TppVehicle2",TppReinforceBlock.REINFORCE_VEHICLE_NAME)
    local driverId=GameObject.GetGameObjectId("TppSoldier2",TppReinforceBlock.REINFORCE_DRIVER_SOLDIER_NAME)

    if vehicleId==GameObject.NULL_ID then
      InfCore.DebugPrint"vehicleId==NULL_ID"
      return
    end
    local warpPos=GameObject.SendCommand(vehicleId,{id="GetPosition"})
    InfCore.DebugPrint("reinforce vehicle pos:".. warpPos:GetX()..",".. warpPos:GetY().. ","..warpPos:GetZ())
    TppPlayer.Warp{pos={warpPos:GetX(),warpPos:GetY(),warpPos:GetZ()},rotY=vars.playerCameraRotation[1]}
  end,
}

this.DEBUG_PrintObjectListPosition={
  OnChange=function()
    local objectList=InfMain.reserveSoldierNames
    --        local travelPlan="travelArea2_01"
    --         local objectList=InfVehicle.inf_patrolVehicleConvoyInfo[travelPlan]
    --local objectList=InfMain.ene_wildCardNames
    --local objectList=InfParasite.parasiteNames.CAMO
    --local objectList=InfLookup.truckNames
    --local objectList={"veh_trc_0000"}
    --local objectList=InfLookup.jeepNames
    --local objectList={TppReinforceBlock.REINFORCE_DRIVER_SOLDIER_NAME}
    --local objectList=TppReinforceBlock.REINFORCE_SOLDIER_NAMES
    --local objectList=InfInterrogation.interCpQuestSoldiers
    --local objectList=InfWalkerGear.walkerNames
    --local objectList=InfNPCHeli.heliList

    if objectList==nil then
      InfCore.DebugPrint"objectList nil"
      return
    end
    this.warpObjecList=objectList

    if #objectList==0 then
      InfCore.DebugPrint"objectList empty"
      return
    end

    local stepCount=0
    local pos=Vector3(0,0,0)
    local objectName="NULL"
    local function Step()
      objectName=objectList[this.currentWarpIndex]
      local gameId=objectName
      if type(objectName)=="string" then
        gameId=GameObject.GetGameObjectId(objectName)
      end
      if gameId==nil or gameId==GameObject.NULL_ID then
        InfCore.Log(objectName.." gameId==NULL_ID")
        pos=Vector3(0,0,0)
      else
        pos=GameObject.SendCommand(gameId,{id="GetPosition"})
        if pos==nil then
          InfCore.Log("GetPosition nil for "..objectName,true)
          return
        else
          InfCore.Log(this.currentWarpIndex..":"..objectName.." pos:".. pos:GetX()..",".. pos:GetY().. ","..pos:GetZ(),true)
        end
      end
      this.currentWarpIndex=this.currentWarpIndex+1
      if this.currentWarpIndex>#objectList then
        this.currentWarpIndex=1
      end
      stepCount=stepCount+1
    end

    while (pos:GetX()==0 and pos:GetY()==0 and pos:GetZ()==0) and stepCount<=#objectList do
      Step()
      if singleStep then
        break
      end
    end
  end,
}

this.DEBUG_PrintNonDefaultVars={
  OnChange=function()
    IvarProc.PrintNonDefaultVars()
  end,
}

this.DEBUG_PrintSaveVarCount={
  OnChange=function()
    IvarProc.PrintSaveVarCount()
  end,
}

this.DEBUG_DumpValidStrCode={
  OnChange=function()
    InfLookup.DumpValidStrCode()
  end
}


this.HeliMenuOnTest={--CULL: UI system overrides it :(
  OnChange=function()
    local dvcMenu={
      {menu=TppTerminal.MBDVCMENU.MSN_HELI,active=true},
      {menu=TppTerminal.MBDVCMENU.MSN_HELI_RENDEZVOUS,active=true},
      {menu=TppTerminal.MBDVCMENU.MSN_HELI_ATTACK,active=true},
      {menu=TppTerminal.MBDVCMENU.MSN_HELI_DISMISS,active=true},
    }
    InfCore.DebugPrint("blih")--DEBUG
    TppTerminal.EnableDvcMenuByList(dvcMenu)
    InfCore.DebugPrint("bleh")--DEBUG
  end,
}

this.changeToIdleStateHeli={--tex seems to set heli into 'not called'/invisible/wherever it goes after it's 'left'
  OnChange=function()
    local gameObjectId=GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=GameObject.NULL_ID then
      GameObject.SendCommand(gameObjectId,{id="ChangeToIdleState"})
    end
  end
}

this.loadExternalModules={
  OnChange=function()
    InfMain.LoadExternalModules(true)
  end
}

this.copyLogToPrev={
  OnChange=function()
    local fileName=InfCore.logFileName
    InfCore.CopyFileToPrev(InfCore.paths.mod,fileName,".txt")
    InfCore.ClearFile(InfCore.paths.mod,fileName,".txt")
  end
}

this.dropCurrentEquip={
  OnChange=function()
    if vars.playerVehicleGameObjectId~=NULL_ID and not InfMain.IsGameObjectType(vars.playerVehicleGameObjectId,TppGameObject.GAME_OBJECT_TYPE_HORSE2) then
      return
    end

    local slotType=vars.currentInventorySlot
    local subIndex=nil
    --tex NOTE: currentInventorySlot doesn't seem to ever be set to PlayerSlotType.ITEM
    if slotType==PlayerSlotType.ITEM then
      subIndex=vars.currentItemIndex
    elseif slotType==PlayerSlotType.SUPPORT then
      subIndex=vars.currentSupportWeaponIndex
    elseif slotType==PlayerSlotType.STOLE then
    -- return --tex allow it since
    elseif slotType==PlayerSlotType.HAND then
    -- return --tex think I'll allow it so user can quick dump hand to default
    end

    InfCore.Log("dropCurrentEquip currentInventorySlot"..vars.currentInventorySlot.."currentItemIndex "..vars.currentItemIndex.." currentSupportWeaponIndex "..vars.currentSupportWeaponIndex)

    Player.UnsetEquip{
      slotType=slotType,
      subIndex=subIndex,
      dropPrevEquip=true,
    }
  end
}

--DEBUG
--tex loops at 512
--    local count=1100
--    local objectType="TppSoldier2"
--    for index=0,count-1 do
--      local gameId=GameObject.GetGameObjectIdByIndex(objectType,index)
--      --tex GetGameObjectIdByIndex errors on index > instance count: 'instance index range error. index n is larger than maxInstanceCount n.'
--      if gameId==NULL_ID then
--        --tex shouldnt happen
--        InfCore.Log("object index "..index.." ==NULL_ID")
--      else
--        local name=InfLookup.ObjectNameForGameId(gameId)
--        InfCore.Log("Soldier index "..index..": gameId:"..gameId.." name:"..tostring(name))
--        --tex return an 'instance index range error. index <GetGameObjectIdByIndex index> is larger than maxInstanceCount <instance count>.'
--        --which makes little sense since the gameId is the same/is not the index.
--        --errors/non errors seem to loop too (getting out of sync with the actual inputted index)
--        --ex:
----        |765.58408987113|Soldier index 842: gameId:1354 name:nil << tex fine even though index is over instance count
----        |765.58408987113|ERROR:C:/GamesSD/MGS_TPP/mod/InfMenuCommands.lua:770: instance index range error. index 330 is larger than maxInstanceCount 330. << not even reporting correct index
----        |765.58408987113|Soldier index 843: gameId:1355 name:nil
--        some other commands seem to be less safe and will hang or crash the game past max index
--        so will have to either be dead accurate with the max index you supply, reply on GetPosition as a canary/break on error for those gameobjects that support it
--        local pos=InfCore.PCall(function()GameObject.SendCommand(gameId,{id="GetPosition"})end)
--      end
--    end

--GOTCHA: there's some funkyness to GetGameObjectIdByIndex.
--GetMaxInstanceCount only works on a couple of gameobjects, hostages and walker gears (more frustrating kjp inconsistancy)
--GetGameObjectIdByIndex itself doesn't seem to care about inputting index > instance count, it will loop the returned gameobject eturning the same gameobjectids
--but running GameObject.SendCommand on a gameid from an index > instance count will return an 'instance index range error. index <GetGameObjectIdByIndex> is larger than maxInstanceCount <instance count>.'
--which doesn't really make sense, it suggests that the gameid has the index, even though on inspection it seems exactly the same/repeated < index gameid
--and it's only for some commands, others will hang or crash the game (again, this wouldn't be an issue if GetGameObjectIdByIndex didn't have a (seeminly) unsafe implmentation.
function this.RunOnAllObjects(objectType,instanceCount,RunFunc)
  local count=SendCommand({type=objectType},{id="GetMaxInstanceCount"})
  InfCore.Log(objectType.." maxInstanceCount:"..tostring(count))--DEBUG
  if count==nil then
    count=instanceCount--SYNC soldier max instance/totalCount
  end
  if count and count>0 then
    for index=0,count-1 do
      local gameId=GameObject.GetGameObjectIdByIndex(objectType,index)
      --tex GetGameObjectIdByIndex errors on index > instance count: 'instance index range error. index n is larger than maxInstanceCount n.'
      if gameId==NULL_ID then
        --tex shouldnt happen
        InfCore.Log("object index "..index.." ==NULL_ID")
      else
        local success,ret=pcall(RunFunc,gameId,index)
        if not success then
          InfCore.Log("RunOnAllObjects GetGameObjectIdByIndex > instance count at index "..index..", breaking")
          break
        end
      end
    end
  end
end

this.setAllFriendly={
  OnChange=function()
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
      SendCommand(gameId,{id="SetFriendly",enabled=true})
    end

    local function SetHeliNoNotice(gameId)
      SendCommand(gameId,{id="SetEyeMode",mode="Close"})
      SendCommand(gameId,{id="SetRestrictNotice",enabled=true})
      SendCommand(gameId,{id="SetCombatEnabled",enabled=false})
    end

    this.RunOnAllObjects("TppSoldier2",350,SetFriendly)
    local heliInstances=1

    if Ivars.heliPatrolsFREE:Is()>0 then
      heliInstances=5
    end
    this.RunOnAllObjects("TppEnemyHeli",heliInstances,SetHeliNoNotice)

    for cpId,cpName in pairs(mvars.ene_cpList)do
      local command={id="SetFriendlyCp"}
      GameObject.SendCommand(cpId,command)
    end
  end
}

this.setAllZombie={
  OnChange=function()
    local function SetZombie(gameObjectId)

      local disableDamage=false
      local isHalf=false
      local isMsf=false

      local life=300
      local stamina=200

      isHalf=isHalf or false

      SendCommand(gameObjectId,{id="SetZombie",enabled=true,isHalf=isHalf,isZombieSkin=true,isHagure=true,isMsf=isMsf})
      SendCommand(gameObjectId,{id="SetMaxLife",life=life,stamina=stamina})
      SendCommand(gameObjectId,{id="SetZombieUseRoute",enabled=false})
      if disableDamage==true then
        SendCommand(gameObjectId,{id="SetDisableDamage",life=false,faint=true,sleep=true})
      end
      if isHalf then
        local ignoreFlag=0
        SendCommand(gameObjectId,{id="SetIgnoreDamageAction",flag=ignoreFlag})
      end
    end

    this.RunOnAllObjects("TppSoldier2",350,SetZombie)
  end
}

this.checkPointSave={
  OnChange=function()
    --TppCheckPoint.Update{atCurrentPosition=true}
    TppCheckPoint.Update{safetyCurrentPosition=true}
  end
}

--TABLESETUP: MenuCommands
local optionType="COMMAND"
local IsTable=Tpp.IsTypeTable
local switchRange={max=1,min=0,increment=1}
for name,item in pairs(this) do
  if IsTable(item) then
    if item.OnChange then--TYPEID
      item.optionType=optionType
      item.name=name
      item.default=item.default or 0
      ivars[name]=item.default
      item.range=item.range or switchRange
      item.settingNames=item.settingNames or "set_do"
    end
  end
end

return this
