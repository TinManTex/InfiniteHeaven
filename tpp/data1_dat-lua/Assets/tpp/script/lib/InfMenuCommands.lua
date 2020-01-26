-- DOBUILD: 1
--InfMenuCommands.lua
local this={}
--tex lines kinda blurry between Commands and Ivars, currently commands arent saved/have no gvar associated
--NOTE: tablesetup at end sets up every table in this with an OnChange as a menu command
--localopt
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
    Ivars.PrintNonDefaultVars()
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
this.showPosition={
  OnChange=function()
    TppUiCommand.AnnounceLogView(string.format("%.3f,%.3f,%.3f | %.3f",vars.playerPosX,vars.playerPosY,vars.playerPosZ,vars.playerCameraRotation[1]))
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

this.loadMission={
  OnChange=function()
    local settingStr=Ivars.manualMissionCode.settings[Ivars.manualMissionCode:Get()+1]
    InfMenu.DebugPrint("TppMission.Load "..settingStr)
    --TppMission.Load( tonumber(settingStr), vars.missionCode, { showLoadingTips = false } )
    --TppMission.RequestLoad(tonumber(settingStr),vars.missionCode,{force=true,showLoadingTips=true})--,ignoreMtbsLoadLocationForce=mvars.mis_ignoreMtbsLoadLocationForce})
    --TppMission.RequestLoad(10036,vars.missionCode,{force=true,showLoadingTips=true})--,ignoreMtbsLoadLocationForce=mvars.mis_ignoreMtbsLoadLocationForce})
    gvars.mis_nextMissionCodeForMissionClear=tonumber(settingStr)
    mvars.mis_showLoadingTipsOnMissionFinalize=false
    --mvars.heli_missionStartRoute
    --mvars.mis_nextLayoutCode
    --mvars.mis_nextClusterId
    --mvars.mis_ignoreMtbsLoadLocationForce

    TppMission.ExecuteMissionFinalize()
  end,
}

this.ogrePointChange=999999
this.setDemon={
  OnChange=function(self)
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
  settingNames="set_do",
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
    --local sightFormStr=InfInspect.Inspect(InfSoldierParams.soldierParameters.sightFormParameter)
    --InfMenu.DebugPrint(sightFormStr)
    InfSoldierParams.PrintSightForm()
  end,
}

this.printHearingTable={
  OnChange=function()
    InfSoldierParams.ApplyHearingIvarsToSoldierParams()
    local ins=InfInspect.Inspect(InfSoldierParams.soldierParameters.hearingRangeParameter)
    InfMenu.DebugPrint(ins)
  end,
}

this.printHealthTableParameter={
  OnChange=function()
    InfSoldierParams.ApplyHealthIvarsToSoldierParams()
    local sightFormStr=InfInspect.Inspect(InfSoldierParams.lifeParameterTable)
    InfMenu.DebugPrint(sightFormStr)
  end,
}

this.printCustomRevengeConfig={
  OnChange=function()
    local revengeConfig=InfRevenge.CreateCustomRevengeConfig()
    local ins=InfInspect.Inspect(revengeConfig)
    InfMenu.DebugPrint(ins)
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

--
this.warpToCamPos={
  OnChange=function()
    local warpPos=InfCamera.ReadPosition"FreeCam"
    InfMenu.DebugPrint("warp pos:".. warpPos:GetX()..",".. warpPos:GetY().. ","..warpPos:GetZ())
    TppPlayer.Warp{pos={warpPos:GetX(),warpPos:GetY(),warpPos:GetZ()},rotY=vars.playerCameraRotation[1]}
  end,
}

this.warpToUserMarker={
  OnChange=function()
    InfInspect.TryFunc(function()
      -- InfMenu.DebugPrint"Warping to newest marker"
      local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
      if lastMarkerIndex==nil then
        --InfMenu.DebugPrint("lastMarkerIndex==nil")
        InfMenu.PrintLangId"no_marker_found"
      else
        InfUserMarker.PrintUserMarker(lastMarkerIndex)
        InfUserMarker.WarpToUserMarker(lastMarkerIndex)
      end
    end)
  end
}

this.printUserMarkers={
  OnChange=function()InfUserMarker.PrintUserMarkers() end,
}

this.printLatestUserMarker={
  OnChange=function()
    InfInspect.TryFunc(function()
      local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
      if lastMarkerIndex==nil then
        InfMenu.DebugPrint("lastMarkerIndex==nil")
      else
        InfUserMarker.PrintUserMarker(lastMarkerIndex)
        InfUserMarker.PrintMarkerGameObject(lastMarkerIndex)
      end
    end)
  end
}


this.setSelectedCpToMarkerObjectCp={
  OnChange=function()
    InfInspect.TryFunc(function()
      local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
      if lastMarkerIndex==nil then
        InfMenu.DebugPrint("lastMarkerIndex==nil")
        return
      end
      --      InfMain.PrintUserMarker(lastMarkerIndex)
      --      InfMain.PrintMarkerGameObject(lastMarkerIndex)
      local gameId=vars.userMarkerGameObjId[lastMarkerIndex]

      if gameId==nil then
        InfMenu.DebugPrint"gameId==nil"
        return
      end
      local soldierName,cpName=InfMain.ObjectNameForGameId(gameId)
      if cpName==nil then
        InfMenu.DebugPrint"cpName==nil"
        return
      end

      for n,currentName in pairs(mvars.ene_cpList)do
        --InfMenu.DebugPrint(tostring(n).." "..tostring(currentName))
        if currentName==cpName then
          Ivars.selectedCp:Set(n)
          InfMenu.DebugPrint("selectedCp set to "..n..":"..cpName)
          return
        end
      end

      InfMenu.DebugPrint(cpName.." not found in ene_cpList")
      local ins=InfInspect.Inspect(mvars.ene_cpList)
      InfMenu.DebugPrint(ins)

    end)
  end
}

function this.QuietMoveToLastMarker()
  if vars.buddyType~=BuddyType.QUIET then
    InfMenu.PrintLangId"buddy_not_quiet"
    return
  end

  local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
  if lastMarkerIndex==nil then
    InfMenu.PrintLangId"no_marker_found"
  else
    local moveToPosition=InfUserMarker.GetMarkerPosition(lastMarkerIndex)
    local gameId={type="TppBuddyQuiet2",index=0}
    if gameId==NULL_ID then
      InfMenu.PrintLangId"cant_find_quiet"
    else
      SendCommand(gameId,{id="MoveToPosition",position=moveToPosition,rotationY=0})--,index=99,disableAim=true})
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

this.requestHeliLzToLastMarker={
  isMenuOff=true,
  OnChange=function()
    InfInspect.TryFunc(function()--DEBUGNOW
      local locationName=InfMain.GetLocationName()
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
          InfMenu.DebugPrint"WARNING: TppLandingZone.assaultLzs[locationName]==nil"--DEBUG
        end
        local aprRoute=TppLandingZone.assaultLzs[locationName][closestRoute] or TppLandingZone.missionLzs[locationName][closestRoute]
        --InfMenu.DebugPrint("Pos Lz Name:"..tostring(closestRoute).." ArpName for lz name:"..tostring(aprRoute))--DEBUG

        local heliId=GetGameObjectId("TppHeli2","SupportHeli")
        if heliId==NULL_ID then
          --InfMenu.DebugPrint"heliId==NULL_ID"--DEBUG
          return
        end
        SendCommand(heliId,{id="CallToLandingZoneAtName",name=aprRoute})
      end

      InfMenu.MenuOff()
    end)--
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

this.forceGameEvent={
  OnChange=function()
    InfGameEvent.ForceEvent()
  end
}

this.printBodyInfo={
  OnChange=function()
    InfFova.GetCurrentFovaTable(true)
  end
}

this.DEBUG_PrintMenu={
  OnChange=function()
    InfMenu.PrintMenu()
  end
}

this.DEBUG_PrintInterrogationInfo={
  OnChange=function()
    InfInspect.TryFunc(function()
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
        InfMenu.DebugPrint"gameId== nil or NULL_ID"
        return
      end

      local soldierICPQId=InfInterrogation.GetInterCpQuestId(gameId)
      if soldierICPQId==nil then
        InfMenu.DebugPrint"cannot find cpQuestId for soldier"--DEBUG
        return
      end

      local cpName=InfInterrogation.interCpQuestSoldiersCps[soldierICPQId]
      if cpName==nil then
        InfMenu.DebugPrint"cpName==nil"--DEBUG
        return
      end
      InfMenu.DebugPrint("quest cpName:"..cpName)
    end)
  end
}

---
local toggle1=false
local index1Min=1
local index1Max=10
local index1=index1Min
this.log=""
this.DEBUG_SomeShiz={
  OnChange=function()
    InfInspect.TryFunc(function()
      --DEBUGNOW
      --TppUiCommand.AnnounceLogView("anlogdoop")
       local fogDensity=math.random(0.001,0.9)
  TppWeather.ForceRequestWeather(TppDefine.WEATHER.FOGGY,6,{fogDensity=fogDensity})

  local parasiteAppearTime=math.random(8,10)
  GkEventTimerManager.Start("Timer_ParasiteAppear",parasiteAppearTime)
     
      InfMenu.MenuOff()
      --
      --        end
      --      end

      --InfEquip.CheckTppEquipTable()
      ----------------
      if true then return end--DEBUG
      ------------------

      local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
      if lastMarkerIndex==nil then
        InfMenu.DebugPrint("lastMarkerIndex==nil")
      else
        local position=InfUserMarker.GetMarkerPosition(lastMarkerIndex)

        local moveType=PlayerMoveType.WALK
        local direction=vars.playerCameraRotation[1]
        local timeOut=120
        local onlyInterpPosition=nil--if true slide player along quickly instead of animating walk
        Player.RequestToMoveToPosition{
          name="MoveToMarkerPosition",
          position=position,
          direction=direction,
          moveType=moveType,
          timeout=timeOut,
          onlyInterpPosition=onlyInterpPosition,
        }

      end

      --        --tex Player.RequestToMoveToPosition sets up a msg callback with name as sender
      --        local StrCode32=Fox.StrCode32
      --        local MOVE_TO_POSITION_RESULT={
      --          [StrCode32"success"]="success",
      --          [StrCode32"failure"]="failure",
      --          [StrCode32"timeout"]="timeout"
      --        }

      --        Player = {
      --          {
      --            msg="FinishMovingToPosition",
      --            sender="SomeMoveToPositionName",--sender for messages is optional but useful to narrow down things
      --            func = function(str32Name,moveResultStr32)
      --
      --            end,
      --          },
      --        },



      ----------
      --    local statuses={
      --      {CallMenu="INVALID"},
      --      {PauseMenu="INVALID"},
      --      {EquipHud="INVALID"},
      --      {EquipPanel="INVALID"},
      --      {CqcIcon="INVALID"},
      --      {ActionIcon="INVALID"},
      --      {AnnounceLog="SUSPEND_LOG"},
      --      {AnnounceLog="INVALID_LOG"},
      --      {BaseName="INVALID"},
      --      {Damage="INVALID"},
      --      {Notice="INVALID"},
      --      {HeadMarker="INVALID"},
      --      {WorldMarker="INVALID"},
      --      {HudText="INVALID"},
      --      {GmpInfo="INVALID"},
      --      {AtTime="INVALID"},
      --      {InfoTypingText="INVALID"},
      --      {ResourcePanel="SHOW_IN_HELI"}
      --    }
      --    for o,status in pairs(statuses)do
      --      for name,statusType in pairs(status)do
      --        if(TppUiStatusManager.CheckStatus(name,statusType)==true)then
      --          InfMenu.DebugPrint(string.format(" UI = %s, Status = %s",name,statusType))
      --        end
      --      end
      --    end


    end)
    InfMenu.DebugPrint("index1:"..index1)
    index1=index1+1
    if index1>index1Max then
      index1=index1Min
    end
  end
}


local index2=0
local index2Min=index2
local index2Max=1
this.DEBUG_SomeShiz2={
  OnChange=function()
    InfInspect.TryFunc(function()
      InfParasite.EndEvent()

      if true then return end

      local position={vars.playerPosX,vars.playerPosY,vars.playerPosZ}

      local closestLz,lzDistance=InfMain.ClosestLz(position)

      if closestLz==nil then
        InfMenu.PrintLangId"no_lz_found"
      end

      InfMenu.DebugPrint(InfLZ.str32LzToLz[closestLz]..":"..math.sqrt(lzDistance))

      local closestCp,cpDistance=InfMain.GetClosestCp(position)


      if true then return end--DEBUGNOW
      local route="lz_drp_field_I0000|rt_drp_field_I_0000"

      local gameObjectId=GameObject.GetGameObjectId("SupportHeli")
      --GameObject.SendCommand(gameObjectId,{id="SendPlayerAtRoute",route=route})
      GameObject.SendCommand(gameObjectId,{id="SendPlayerAtRouteReady",route=route})
      GameObject.SendCommand(gameObjectId,{id="SendPlayerAtRouteStart",isAssault=false})

      -- InfMain.GetClosestCp()

      --        --InfMenu.DebugPrint(this.stringTest)
      --
      --        local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
      --        if lastMarkerIndex==nil then
      --          InfMenu.DebugPrint("lastMarkerIndex==nil")
      --        else
      --          local moveToPosition=InfUserMarker.GetMarkerPosition(lastMarkerIndex)
      --
      --          local buddyHorseId=GameObject.GetGameObjectIdByIndex("TppHorse2",0)
      --          if buddyHorseId==GameObject.NULL_ID then
      --          else
      --
      --            local horsePos = GameObject.SendCommand(buddyHorseId,{id="GetPosition"})
      --
      --            local command={id="SetCallHorse",
      --              startPosition=horsePos,
      --              goalPosition=moveToPosition
      --            }
      --            GameObject.SendCommand(buddyHorseId,command)
      --          end
      --        end



    end)
    InfMenu.DebugPrint("index2:"..index2)
    index2=index2+1
    if index2>index2Max then
      index2=index2Min
    end
  end
}

local index3=0
local index3Min=index3
local index3Max=1000
this.DEBUG_SomeShiz3={
  OnChange=function()
    InfInspect.TryFunc(function()

    end)
    index3=index3+1
    if index3>index3Max then
      index3=index3Min
    end
  end
}

this.log=""
this.DEBUG_RandomizeAllIvars={
  OnChange=function()
    InfInspect.TryFunc(function()
      --tex randomize (most)all ivars
      local skipIvars={
        debugMode=true,

        abortMenuItemControl=true,

        mbDemoSelection=true,

        warpPlayerUpdate=true,
        adjustCameraUpdate=true,
        --non user
        inf_event=true,
        mis_isGroundStart=true,
        inf_levelSeed=true,
        mbHostileSoldiers=true,
        mbEnableLethalActions=true,
        mbNonStaff=true,
        mbZombies=true,
        mbEnemyHeli=true,
        npcUpdate=true,
        heliUpdate=true,

        --WIP/OFF
        blockFobTutorial=true,
        setFirstFobBuilt=true,
        disableTranslators=true,
        vehiclePatrolPaintType=true,
        vehiclePatrolEmblemType=true,
        mbShowQuietCellSigns=true,
        manualMissionCode=true,
        playerType=true,
        playerCammoTypes=true,
        playerPartsType=true,
        playerFaceEquipIdApearance=true,
        playerFaceIdApearance=true,
        playerHandEquip=true,
        cpAlertOnVehicleFulton=true,
        disableQuietHumming=true,
        enableGetOutHeli=true,
        selectedChangeWeapon=true,
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
            InfMenu.DebugPrint("WARNING: ivar "..name.." hase no range set")
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

      InfMenu.DebugPrint("start: "..start.." finish: "..finish)

      for i,name in ipairs(ivarNames) do
        if i>finish then
          break
        end
        if i>=start then

          local ivar=Ivars[name]
          ivar:Set(math.random(ivar.range.min,ivar.range.max),true)

          --if ivar.setting~=ivar.default then
          log=log..name.."\n"

          --end
        end
      end
      InfMenu.DebugPrint(tostring(log))
    end)--
  end
}

--SYNC run PrintIvars on main.
this.DEBUG_SetIvarsToDefault={
  OnChange=function()
    InfInspect.TryFunc(
      function()
        local ivarNames={
        "debugMode",
     
        }

        for i,ivarName in pairs(ivarNames) do
          local ivar=Ivars[ivarName]
          if ivar==nil then
            InfMenu.DebugPrint(ivarName.."==nil")

          elseif not ivar.save then
          --InfMenu.DebugPrint(ivarName.." save not set")
          elseif ivar.setting~=ivar.default then
            InfMenu.DebugPrint(ivarName.." not default, resetting")
            InfMenu.SetSetting(ivar,ivar.default,true)
          end
        end
      end
    )
  end
}
--higspeedcamera / slowmo
local highSpeedCamToggle=false
local highSpeedCamStartTime=0
this.highSpeedCameraToggle={
  OnChange=function()
    --InfInspect.TryFunc(function()--DEBUG
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

      --highSpeedCamStartTime=elapsedTime+continueTime

      HighSpeedCamera.RequestEvent{continueTime=continueTime,worldTimeRate=worldTimeRate,localPlayerTimeRate=localPlayerTimeRate,timeRateInterpTimeAtStart=timeRateInterpTimeAtStart,timeRateInterpTimeAtEnd=timeRateInterpTimeAtEnd,cameraSetUpTime=cameraSetUpTime}

      --InfMenu.PrintLangId"highspeedcam_on"--DEBUG
    else
      highSpeedCamStartTime=0

      HighSpeedCamera.RequestToCancel()

      InfMenu.PrintLangId"highspeedcam_cancel"
    end
    --end)--
  end
}
--
this.DEBUG_PrintRevengePoints={
  OnChange=function()
    InfInspect.TryFunc(function()
      --tex from TppRevenge. , cutting out dummy, max, and reordering to ui order
      local REVENGE_TYPE_NAME={"FULTON","HEAD_SHOT","STEALTH","COMBAT","NIGHT_S","NIGHT_C","LONG_RANGE","VEHICLE","TRANQ","SMOKE","M_STEALTH","M_COMBAT"}

      --      InfMenu.DebugPrint"Revenge Levels"
      local revengeLevelsStr=""
      --      for i,revengeTypeName in ipairs(REVENGE_TYPE_NAME)do
      --        revengeLevelsStr=revengeLevelsStr..revengeTypeName..":"..tostring(TppRevenge.GetRevengeLv(TppRevenge.REVENGE_TYPE[revengeTypeName]))
      --        revengeLevelsStr=revengeLevelsStr.." "
      --      end
      --      InfMenu.DebugPrint(revengeLevelsStr)

      InfMenu.DebugPrint"Revenge points"
      local revengeLevelsStr=""
      for i,revengeTypeName in ipairs(REVENGE_TYPE_NAME)do
        revengeLevelsStr=revengeLevelsStr..revengeTypeName..":"..tostring(TppRevenge.GetRevengePoint(TppRevenge.REVENGE_TYPE[revengeTypeName]))
        revengeLevelsStr=revengeLevelsStr.." "
      end
      InfMenu.DebugPrint(revengeLevelsStr)

    end)
  end
}

this.DEBUG_PrintHeliPos={
  OnChange=function()
    InfInspect.TryFunc(function()
      InfNPCHeli.PrintHeliPos()
    end)
  end
}

local routeIndex=1
this.heliRoute=nil
local heliRoutes={}
this.DEBUG_CycleHeliRoutes={
  OnChange=function()
    local StrCode32=Fox.StrCode32
    InfInspect.TryFunc(function()
      local heliName="SupportHeli"--EnemyHeli0000"
      local heliIndex=1
      local heliObjectId = GetGameObjectId(heliName)
      if heliObjectId==NULL_ID then
      --InfMenu.DebugPrint(heliName.."==NULL_ID")--DEBUG
      else
        if #heliRoutes==0 then
          --heliRoutes=this.ResetLzPool()
          heliRoutes=InfMain.ResetPool(InfNPCHeli.heliRoutes.afgh)
        end
        --InfInspect.PrintInspect(heliRoutes)--DEBUG
        this.heliRoute=StrCode32(heliRoutes[routeIndex])
        routeIndex=routeIndex+1
        if routeIndex>#heliRoutes then
          routeIndex=1
        end

        InfNPCHeli.SetRoute(this.heliRoute,heliIndex)
        --InfMenu.DebugPrint(heliName.." setting route: "..tostring(InfLZ.str32LzToLz[this.heliRoute]))--DEBUG
        --GameObject.SendCommand(heliObjectId,{id="SetForceRoute",route=this.heliRoute,point=0,warp=true})
      end
      local groundStartPosition=InfLZ.GetGroundStartPosition(this.heliRoute)
      if groundStartPosition==nil then
        InfMenu.DebugPrint" groundStartPosition==nil"
      else
        InfMenu.DebugPrint("warped to "..tostring(InfLZ.str32LzToLz[this.heliRoute]))--DEBUG
        TppPlayer.Warp{pos={groundStartPosition.pos[1],groundStartPosition.pos[2],groundStartPosition.pos[3]},rotY=vars.playerCameraRotation[1]}
      end
    end)
  end
}

local fovaIndex=1
this.DEBUG_FovaTest={
  OnChange=function()
    InfInspect.TryFunc(function()
      Player.SetPartsInfoAtInstanceIndex("/Assets/tpp/parts/chara/sna/sna1_main0_def_v00.parts")
      --Player.RequestToUnloadAllPartsBlock()
      --Player.RequestToLoadPartsBlock("PLTypeHospital")
    end)
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
    InfMenu.DebugPrint("vars.clock:"..vars.clock)
  end,
}

this.DEBUG_PrintFultonSuccessInfo={
  OnChange=function()
    local mbFultonRank=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_FULTON}
    local mbSectionSuccess=TppPlayer.mbSectionRankSuccessTable[mbFultonRank]or 0

    InfMenu.DebugPrint("mbFultonRank:"..mbFultonRank.." mbSectionSuccess:"..mbSectionSuccess)

    --  local doFuncSuccess=TppTerminal.DoFuncByFultonTypeSwitch(gameId,RENAMEanimalId,r,staffOrReourceId,nil,nil,nil,this.GetSoldierFultonSucceedRatio,this.GetVolginFultonSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio)
    --
    --  if doFuncSuccess==nil then
    --    InfMenu.DebugPrint"doFuncSuccess nil, bumped to 100"
    --    doFuncSuccess=100
    --  end
    --  InfMenu.DebugPrint("doFuncSuccess:"..doFuncSuccess)

  end,
}

this.DEBUG_ShowRevengeConfig={
  OnChange=function()
    --InfMenu.DebugPrint("RevRandomValue: "..gvars.rev_revengeRandomValue)
    InfMenu.DebugPrint("RevengeType:")
    local revengeType=InfInspect.Inspect(mvars.revenge_revengeType)
    InfMenu.DebugPrint(revengeType)

    InfMenu.DebugPrint("RevengeConfig:")
    local revengeConfig=InfInspect.Inspect(mvars.revenge_revengeConfig)
    InfMenu.DebugPrint(revengeConfig)
  end,
}

this.DEBUG_PrintSoldierDefine={
  OnChange=function()
    InfMenu.DebugPrint("SoldierDefine:")
    local soldierDefine=InfInspect.Inspect(mvars.ene_soldierDefine)
    InfMenu.DebugPrint(soldierDefine)
  end,
}


this.DEBUG_PrintSoldierIDList={
  OnChange=function()
    InfMenu.DebugPrint("SoldierIdList:")
    local soldierIdList=InfInspect.Inspect(mvars.ene_soldierIDList)
    InfMenu.DebugPrint(soldierIdList)
  end,
}


this.DEBUG_PrintReinforceVars={
  OnChange=function()
    InfMenu.DebugPrint("reinforce_activated: "..tostring(mvars.reinforce_activated))
    InfMenu.DebugPrint("reinforceType: "..mvars.reinforce_reinforceType)
    InfMenu.DebugPrint("reinforceCpId: "..mvars.reinforce_reinforceCpId)
    InfMenu.DebugPrint("isEnabledSoldiers: "..tostring(mvars.reinforce_isEnabledSoldiers))
    InfMenu.DebugPrint("isEnabledVehicle: "..tostring(mvars.reinforce_isEnabledVehicle))
  end,
}

this.DEBUG_PrintVehicleTypes={
  OnChange=function()
    InfMenu.DebugPrint("Vehicle.type.EASTERN_LIGHT_VEHICLE="..Vehicle.type.EASTERN_LIGHT_VEHICLE)
    InfMenu.DebugPrint("Vehicle.type.WESTERN_LIGHT_VEHICLE="..Vehicle.type.WESTERN_LIGHT_VEHICLE)
    InfMenu.DebugPrint("Vehicle.type.EASTERN_TRUCK="..Vehicle.type.EASTERN_TRUCK)
    InfMenu.DebugPrint("Vehicle.type.WESTERN_TRUCK="..Vehicle.type.WESTERN_TRUCK)
    InfMenu.DebugPrint("Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE="..Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE)
    InfMenu.DebugPrint("Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE="..Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE)
    InfMenu.DebugPrint("Vehicle.type.EASTERN_TRACKED_TANK="..Vehicle.type.EASTERN_TRACKED_TANK)
    InfMenu.DebugPrint("Vehicle.type.WESTERN_TRACKED_TANK="..Vehicle.type.WESTERN_TRACKED_TANK)
  end,
}

this.DEBUG_PrintVehiclePaint={
  OnChange=function()
    InfMenu.DebugPrint("Vehicle.class.DEFAULT="..Vehicle.class.DEFAULT)
    InfMenu.DebugPrint("Vehicle.class.DARK_GRAY="..Vehicle.class.DARK_GRAY)
    InfMenu.DebugPrint("Vehicle.class.OXIDE_RED="..Vehicle.class.OXIDE_RED)
    InfMenu.DebugPrint("Vehicle.paintType.NONE="..Vehicle.paintType.NONE)
    InfMenu.DebugPrint("Vehicle.paintType.FOVA_0="..Vehicle.paintType.FOVA_0)
    InfMenu.DebugPrint("Vehicle.paintType.FOVA_1="..Vehicle.paintType.FOVA_1)
    InfMenu.DebugPrint("Vehicle.paintType.FOVA_2="..Vehicle.paintType.FOVA_2)
  end,
}

this.DEBUG_RandomizeCp={--CULL only for debug purpose with a print in the function
  OnChange=function()
    InfMain.RandomizeCpSubTypeTable()
  end,
}

this.DEBUG_PrintRealizedCount={
  OnChange=function()
    InfMenu.DebugPrint("MAX_REALIZED_COUNT:"..EnemyFova.MAX_REALIZED_COUNT)
  end,
}
this.DEBUG_PrintEnemyFova={
  OnChange=function()
    local infene=InfInspect.Inspect(EnemyFova)
    InfMenu.DebugPrint(infene)
    local infenemeta=InfInspect.Inspect(getmetatable(EnemyFova))
    InfMenu.DebugPrint(infenemeta)
  end,
}

this.DEBUG_PrintPowersCount={
  OnChange=function()
    --local ins=InfInspect.Inspect(mvars.ene_soldierPowerSettings)
    --InfMenu.DebugPrint(ins)
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
    InfMenu.DebugPrint("totalSoldierCount:"..totalSoldierCount)
    local ins=InfInspect.Inspect(totalPowerSettings)
    InfMenu.DebugPrint(ins)
  end
}

this.DEBUG_PrintCpPowerSettings={
  OnChange=function()
    --local ins=InfInspect.Inspect(mvars.ene_soldierPowerSettings)
    -- InfMenu.DebugPrint(ins)
    if Ivars.selectedCp:Is()>0 then
      local soldierList=mvars.ene_soldierIDList[Ivars.selectedCp:Get()]
      if soldierList then
        for soldierId,n in pairs(soldierList)do
          local ins=InfInspect.Inspect(mvars.ene_soldierPowerSettings[soldierId])
          InfMenu.DebugPrint(ins)
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

    local ins=InfInspect.Inspect(cpSizes)
    InfMenu.DebugPrint(ins)

    local ins=InfInspect.Inspect(cpTypesAverage)
    InfMenu.DebugPrint(ins)
  end
}

this.DEBUG_ChangePhase={
  OnChange=function()
    InfMenu.DebugPrint("Changephase b")
    for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
      InfMain.ChangePhase(cpName,Ivars.maxPhase:Get())
    end
    InfMenu.DebugPrint("Changephase e")
  end
}

this.DEBUG_KeepPhaseOn={
  OnChange=function()
    InfMenu.DebugPrint("DEBUG_KeepPhaseOn b")
    for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
      InfMain.SetKeepAlert(cpName,true)
    end
    InfMenu.DebugPrint("DEBUG_KeepPhaseOn e")
  end
}

this.DEBUG_KeepPhaseOff={
  OnChange=function()
    InfMenu.DebugPrint("DEBUG_KeepPhaseOff b")
    for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
      InfMain.SetKeepAlert(cpName,false)
    end
    InfMenu.DebugPrint("DEBUG_KeepPhaseOff e")
  end
}

this.printPlayerPhase={
  OnChange=function()
    InfMenu.DebugPrint("vars.playerPhase=".. vars.playerPhase ..":".. Ivars.phaseSettings[vars.playerPhase+1])
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
      InfMenu.DebugPrint(phaseName..":".. Ivars.maxPhase.settingsTable[n])
    end
  end,
}


this.DEBUG_Item2={
  OnChange=function()
    InfMenu.DebugPrint("EnemyTypes:")
    InfMenu.DebugPrint("TYPE_DD:"..EnemyType.TYPE_DD)
    InfMenu.DebugPrint("TYPE_SKULL:"..EnemyType.TYPE_SKULL )
    InfMenu.DebugPrint("TYPE_SOVIET:"..EnemyType.TYPE_SOVIET)
    InfMenu.DebugPrint("TYPE_PF:"..EnemyType.TYPE_PF )
    InfMenu.DebugPrint("TYPE_CHILD:".. EnemyType.TYPE_CHILD )
    --InfMenu.DebugPrint("bef")
    -- local strout=InfInspect.Inspect(gvars.soldierTypeForced)
    -- InfMenu.DebugPrint(strout)
    -- InfMenu.DebugPrint("aft")
  end,
}

this.DEBUG_InspectAllMenus={
  OnChange=function()
    --local instr=InfInspect.Inspect(InfMenuDefs.allMenus)
    --InfMenu.DebugPrint(instr)
    for n,menu in ipairs(InfMenuDefs.allMenus) do
      if menu==nil then
        InfMenu.DebugPrint("menu==nil at index "..n)
      elseif menu.name==nil then
        InfMenu.DebugPrint("menu.name==nil at index "..n)
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
    InfInspect.TryFunc(function()

        --local objectList=InfMain.reserveSoldierNames
        local objectList={"veh_lv_0003"}

        --DEBUGNOW
        local objectList={
          "Parasite0",
          "Parasite1",
          "Parasite2",
          "Parasite3",
        }

        --local objectList=InfMain.ene_wildCardSoldiers

        --local objectList=InfMain.truckNames
        --local objectList={"veh_trc_0000"}
        --local objectList=InfMain.jeepNames

        --    local objectList={
        --      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000",
        --      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0001",
        --      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0002",
        --      "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0003",
        --    }
        --local objectList={"sol_field_0002"}



        --local objectList={TppReinforceBlock.REINFORCE_DRIVER_SOLDIER_NAME}
        --local objectList=TppReinforceBlock.REINFORCE_SOLDIER_NAMES



        --local objectList={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppOcelot2GameObjectLocator"}
        --local objectList={"WestHeli0001","WestHeli0000","WestHeli0002"}
        --local objectList={"EnemyHeli"}
        --local objectList={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|sol_plnt0_0000"}

        --local objectList={"ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|TppLiquid2GameObjectLocator"}

        --    local objectList={
        --      "veh_cl01_cl00_0000",
        --      "veh_cl02_cl00_0000",
        --      "veh_cl03_cl00_0000",
        --      "veh_cl04_cl00_0000",
        --      "veh_cl05_cl00_0000",
        --      "veh_cl06_cl00_0000",
        --      "veh_cl00_cl04_0000",
        --      "veh_cl00_cl02_0000",
        --      "veh_cl00_cl03_0000",
        --      "veh_cl00_cl01_0000",
        --      "veh_cl00_cl05_0000",
        --      "veh_cl00_cl06_0000",
        --    }

        --    local objectList={
        --      --  "WestHeli0000",
        --      --  "WestHeli0001",
        --      --  "WestHeli0002",
        --      --  "EnemyHeli",
        --      "EnemyHeli0000",
        --      "EnemyHeli0001",
        --      "EnemyHeli0002",
        --      "EnemyHeli0003",
        --      "EnemyHeli0004",
        --      "EnemyHeli0005",
        --      "EnemyHeli0006",
        --    }


        --local objectList=InfInterrogation.interCpQuestSoldiers

        --local objectList=InfWalkerGear.walkerList


        if objectList==nil then
          InfMenu.DebugPrint"objectList nil"
          return
        end
        this.warpObjecList=objectList

        if #objectList==0 then
          InfMenu.DebugPrint"objectList empty"
          return
        end



        local count=0
        local warpPos=Vector3(0,0,0)
        local objectName="NULL"
        local function Step()
          objectName=objectList[this.currentWarpIndex]
          local gameId=objectName
          if type(objectName)=="string" then
            gameId=GameObject.GetGameObjectId(objectName)
          end
          if gameId==nil or gameId==GameObject.NULL_ID then
            InfMenu.DebugPrint"gameId==NULL_ID"
            warpPos=Vector3(0,0,0)
          else
            warpPos=GameObject.SendCommand(gameId,{id="GetPosition"})
            --InfMenu.DebugPrint(this.currentWarpIndex..":"..objectName.." pos:".. warpPos:GetX()..",".. warpPos:GetY().. ","..warpPos:GetZ())
          end
          this.currentWarpIndex=this.currentWarpIndex+1
          if this.currentWarpIndex>#objectList then
            this.currentWarpIndex=1
          end
          count=count+1
        end

        Step()

        while not singleStep and (warpPos:GetX()==0 and warpPos:GetY()==0 and warpPos:GetZ()==0) and count<=#objectList do
          Step()
          --coroutine.yeild()
        end

        if warpPos:GetX()~=0 or warpPos:GetY()~=0 or warpPos:GetZ()~=0 then
          InfMenu.DebugPrint(objectName.." pos:".. warpPos:GetX()..",".. warpPos:GetY().. ","..warpPos:GetZ())
          TppPlayer.Warp{pos={warpPos:GetX(),warpPos:GetY()+1,warpPos:GetZ()},rotY=vars.playerCameraRotation[1]}
        end
    end)
  end,
}

this.DEBUG_WarpToReinforceVehicle={
  OnChange=function()
    local vehicleId=GameObject.GetGameObjectId("TppVehicle2",TppReinforceBlock.REINFORCE_VEHICLE_NAME)
    local driverId=GameObject.GetGameObjectId("TppSoldier2",TppReinforceBlock.REINFORCE_DRIVER_SOLDIER_NAME)

    if vehicleId==GameObject.NULL_ID then
      InfMenu.DebugPrint"vehicleId==NULL_ID"
      return
    end
    local warpPos=GameObject.SendCommand(vehicleId,{id="GetPosition"})
    InfMenu.DebugPrint("reinforce vehicle pos:".. warpPos:GetX()..",".. warpPos:GetY().. ","..warpPos:GetZ())
    TppPlayer.Warp{pos={warpPos:GetX(),warpPos:GetY(),warpPos:GetZ()},rotY=vars.playerCameraRotation[1]}
  end,
}

this.DEBUG_PrintNonDefaultVars={
  OnChange=function()
    InfInspect.TryFunc(function()
    Ivars.PrintNonDefaultVars()
    end)
  end,
}

this.DEBUG_PrintSaveVarCount={
  OnChange=function()
    InfInspect.TryFunc(function()
      Ivars.PrintSaveVarCount()
    end)
  end,
}


this.HeliMenuOnTest={--CULL: UI system overrides it :(
  OnChange=function()
    local dvcMenu={
      {menu=TppTerminal.MBDVCMENU.MSN_HELI,active=true},
      {menu=TppTerminal.MBDVCMENU.MSN_HELI_RENDEZVOUS,active=true},
      {menu=TppTerminal.MBDVCMENU.MSN_HELI_ATTACK,active=true},
      {menu=TppTerminal.MBDVCMENU.MSN_HELI_DISMISS,active=true},
    }
    InfMenu.DebugPrint("blih")--DEBUG
    TppTerminal.EnableDvcMenuByList(dvcMenu)
    InfMenu.DebugPrint("bleh")--DEBUG
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
      item.setting=item.default
      item.range=item.range or switchRange
      item.settingNames=item.settingNames or "set_do"
    end
  end
end

return this
