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
}
this.MenuOffItem=function()
  InfMenu.MenuOff()
  InfMenu.currentIndex=1
end

this.resetSettingsItem={
  isMenuOff=true,
}
this.ResetSettingsItem=function()
  InfMenu.ResetSettingsDisplay()
  --tex to stop announcelog spam I guess
  if not InfCore.IHExtRunning() then
    InfMenu.MenuOff()
  end
end

this.resetAllSettingsItem={
  isMenuOff=true,
}
this.ResetAllSettingsItem=function()
  InfMenu.PrintLangId"setting_all_defaults"
  InfMenu.ResetSettings()
  IvarProc.PrintNonDefaultVars()
  InfMenu.PrintLangId"done"
  InfMenu.MenuOff()
end

this.GoBackItem=function()
  InfMenu.GoBackCurrent()
end

this.GoBackTopItem=function()
  InfMenu.GoBackTop()
end

this.GeneralHelpItem=function()
  InfMenu.PrintLangId("general_help_cmd")
end
--commands

--IHMenu
this.ShowStyleEditor=function()
  InfCore.MenuCmd'ToggleStyleEditor'
end

this.ShowImguiDemo=function()
  InfCore.MenuCmd'ToggleImguiDemo'
end

--profiles
this.ApplySelectedProfile=function()
  local profileInfo=Ivars.selectProfile:GetProfileInfo()
  if profileInfo==nil then
    InfMenu.PrintLangId"no_profiles_installed"
    return
  end

  InfMenu.PrintLangId"applying_profile"
  IvarProc.ApplyProfile(profileInfo.profile)
end

this.ResetSelectedProfile=function()
  local profileInfo=Ivars.selectProfile:GetProfileInfo()
  if profileInfo==nil then
    InfMenu.PrintLangId"no_profiles_installed"
    return
  end

  InfMenu.PrintLangId"applying_profile"
  IvarProc.ResetProfile(profileInfo.profile)
end

this.ViewProfile=function()
  local profileInfo=Ivars.selectProfile:GetProfileInfo()
  if profileInfo==nil then
    InfMenu.PrintLangId"no_profiles_installed"
    return
  end

  local profileMenu=InfMenu.BuildProfileMenu(profileInfo.profile)
  IvarProc.ApplyProfile(profileInfo.profile)
  InfMenu.GoMenu(profileMenu)
end

this.RevertProfile=function()
  --tex revertProfile is built in BuildProfileMenu
  IvarProc.ApplyProfile(InfMenu.currentMenu.revertProfile)
  InfMenu.GoBackCurrent()
end

this.SaveToProfile=function()
  IvarProc.WriteProfile(true,false)
end
--
--show stuff
this.positions={}
this.positionsXML={}
this.ShowPosition=function()
  if TppLocation.GetLocationName()=="afgh" or TppLocation.GetLocationName()=="mafr" then
    local blockNameStr32=Tpp.GetLoadedLargeBlock()
    local blockName=InfLookup.StrCode32ToString(blockNameStr32) or blockNameStr32 or "nil"
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
end

this.ShowMissionCode=function()
  TppUiCommand.AnnounceLogView("MissionCode: "..vars.missionCode)--ADDLANG
end

this.ShowLangCode=function()
  local languageCode=AssetConfiguration.GetDefaultCategory"Language"
  TppUiCommand.AnnounceLogView(InfLangProc.LangString"language_code"..": "..languageCode)
end
--

--
--this.ResetCameraSettings=function()--CULL
--    InfMain.ResetCamPosition()
--    InfMenu.PrintLangId"cam_settings_reset"
--  end
--

this.SetSelectedCpToMarkerClosestCp=function()
  local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
  if lastMarkerIndex==nil then
    InfCore.DebugPrint("lastMarkerIndex==nil")
    return
  end
  local markerPos=InfUserMarker.GetMarkerPosition(lastMarkerIndex)

  local cpName=InfMain.GetClosestCp{markerPos:GetX(),markerPos:GetY(),markerPos:GetZ()}
  if not cpName then
    InfCore.Log("Could not find cp",false,true)
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
end

this.SetSelectedCpToMarkerObjectCp=function()
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

--stageblock
this.ResetStageBlockPosition=function()
  StageBlockCurrentPositionSetter.SetEnable(false)
end

this.SetStageBlockPositionToMarkerClosest=function()
  local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
  if lastMarkerIndex==nil then
    InfCore.DebugPrint("lastMarkerIndex==nil")
    return
  end

  local lastMarkerIndex=InfUserMarker.GetLastAddedUserMarkerIndex()
  if lastMarkerIndex==nil then
    InfCore.DebugPrint("lastMarkerIndex==nil")
  else
    --InfUserMarker.PrintUserMarker(lastMarkerIndex)
    local x=vars.userMarkerPosX[lastMarkerIndex]
    local z=vars.userMarkerPosZ[lastMarkerIndex]
    StageBlockCurrentPositionSetter.SetEnable(true)
    StageBlockCurrentPositionSetter.SetPosition(x,z)
    InfCore.Log("StageBlockCurrentPositionSetter.SetPosition("..x..","..z..")",true,true)
  end
end
this.SetStageBlockPositionToFreeCam=function()
  local currentCamName=InfCamera.GetCurrentCamName()
  local movePosition=InfCamera.ReadPosition(currentCamName)
  local x,y,z=movePosition:GetX(),movePosition:GetY(),movePosition:GetZ()
  StageBlockCurrentPositionSetter.SetEnable(true)
  StageBlockCurrentPositionSetter.SetPosition(x,z)
  InfCore.Log("StageBlockCurrentPositionSetter.SetPosition("..x..","..z..")",true,true)
end

--DEBUGNOW jam somewhere
this.RefreshPlayer=function()
  InfCore.DebugPrint("RefreshPlayer")
  Player.SetWetEffect()
  Player.ResetDirtyEffect()
  vars.passageSecondsSinceOutMB=0
end

local buddyIndex=1
this.DEBUG_buddyCycle=function()
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

this.ForceRegenSeed=function()
  InfMain.RegenSeed(40010)
end

this.log=""
this.DEBUG_RandomizeAllIvars=function()
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
      if not ivar.range or not ivar.settings then
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
      local min,max=IvarProc.GetRange(ivar)
      ivar:Set(math.random(min,max))

      --if ivar.setting~=ivar.default then
      log=log..name.."\n"

      --end
    end
  end
  InfCore.DebugPrint(tostring(log))
end

this.DEBUG_SetIvarsToNonDefault=function()
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
      if not ivar.range or not ivar.settings then
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

--SYNC run PrintIvars on main.
this.DEBUG_SetIvarsToDefault=function()
  InfCore.DebugPrint"DEBUG_SetIvarsToDefault"

  local ivarNames={}

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
--

this.DEBUG_DropItem=function()

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

this.DEBUG_PrintVarsClock=function()
  InfCore.DebugPrint("vars.clock:"..vars.clock)
end

this.DEBUG_InspectAllMenus=function()
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
end

this.DEBUG_ClearAnnounceLog=function()
  --TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")--pretty sure this is disable
  TppUiStatusManager.ClearStatus"AnnounceLog"
end

this.currentWarpIndex=1
local singleStep=false
this.DEBUG_WarpToObject=function()
  --local objectList=InfMainTpp.reserveSoldierNames
  --        local travelPlan="travelArea2_01"
  --         local objectList=InfVehicle.inf_patrolVehicleConvoyInfo[travelPlan]
  local objectList=InfSoldier.ene_wildCardNames
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
end

this.DEBUG_PrintObjectListPosition=function()
  local objectList=InfMainTpp.reserveSoldierNames
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
end

this.loadExternalModules={
  isMenuOff=true,
}
this.LoadExternalModules=function()
  InfMenu.MenuOff()
  InfMain.LoadExternalModules(true)
end

this.CopyLogToPrev=function()
  local fileName=InfCore.logFileName
  InfCore.CopyFileToPrev(InfCore.paths.mod,fileName,".txt")
  InfCore.ClearFile(InfCore.paths.mod,fileName,".txt")
end

this.SetAllFriendly=function()
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
end

this.SetAllZombie=function()
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

  InfTppUtil.RunOnAllObjects("TppSoldier2",350,SetZombie)
end

this.CheckPointSave=function()
  --TppCheckPoint.Update{atCurrentPosition=true}
  TppCheckPoint.Update{safetyCurrentPosition=true}
end

--LEGACY for SOC quickmenu
this.ToggleFreeCam=function()
  InfCamera.ToggleFreeCam()
end
--< menu commands

function this.PostAllModulesLoad()
  this.BuildCommandItems()
end
--TABLESETUP: MenuCommands
--tex commands are just functions, but the menu system currently only works on options, so build out options for commands
--TODO: have menu system work off commands direct
this.commandItems={}

local OPTIONTYPE_COMMAND="COMMAND"
local IsTable=function(checkType)return type(checkType)=="table" end--tex removed dependancy on Tpp.IsTypeTable
local IsFunction=function(checkType)return type(checkType)=="function" end
local switchRange={max=1,min=0,increment=1}
--tex add menu items for plain functions

function this.ItemNameForFunctionName(name)
  --tex menu item name is function name with lowercase 1st char
  return name:sub(1,1):lower()..name:sub(2,name:len())
end

--build out full item definition
--OUT/SIDE ivars
function this.BuildCommandItem(Command,name)
  --tex menu item name is function name with lowercase 1st char
  local itemName=this.ItemNameForFunctionName(name)
  local menuItem=this[itemName] or {}
  if not IsTable(menuItem) then
    InfCore.Log("WARNING:"..itemName.."is not a table")
  else
    menuItem.optionType=OPTIONTYPE_COMMAND
    menuItem.name=itemName
    menuItem.default=0
    ivars[itemName]=menuItem.default--tex DEBUGNOW TODO remove command dependancy on ivar/switching
    menuItem.range=switchRange--DEBUGNOW settings-no-range
    menuItem.OnChange=Command
  end
  return menuItem,itemName
end

--IN/SIDE: InfMenuDefs
--OUT/SIDE: this.commandItems
function this.BuildCommandItems()
  InfCore.LogFlow("InfMenuCommands.BuildCommandItems")
  InfUtil.ClearTable(this.commandItems)

  --tex TODO: have InfMenuDefs use module.registerMenus too?
  for name,item in pairs(InfMenuDefs) do
    if IsTable(item) and item.options then
      --InfCore.Log("item:"..name)--DEBUG
      for i,optionRef in ipairs(item.options)do
        --InfCore.Log("optionRef:"..optionRef)--DEBUG
        local Command,refName=InfCore.GetStringRef(optionRef)
        if Command and IsFunction(Command) then
          --InfCore.Log("refName:"..refName)--DEBUG
          local menuItem,itemName=this.BuildCommandItem(Command,refName)
          --InfCore.Log("itemName:"..itemName)--DEBUG
          this.commandItems[itemName]=menuItem
        end
      end
    end
  end

  for i,module in ipairs(InfModules) do
    if module.registerMenus and module~=InfMenuDefs then
      if this.debugModule then
        InfCore.PrintInspect(module.registerMenus,module.name..".registerMenus")
      end
      for j,name in ipairs(module.registerMenus)do
        local menuDef=module[name]
        if not menuDef then
          InfCore.Log("WARNING: InfMenuCommands.BuildCommandItems: could not find "..name.." in "..module.name)
        else
          if menuDef.options then
            for i,optionRef in ipairs(menuDef.options)do
              --InfCore.Log("optionRef:"..optionRef)--DEBUG
              local Command,refName=InfCore.GetStringRef(optionRef)
              if Command and IsFunction(Command) then
                --InfCore.Log("refName:"..refName)--DEBUG
                local menuItem,itemName=this.BuildCommandItem(Command,refName)
                --InfCore.Log("itemName:"..itemName)--DEBUG
                this.commandItems[itemName]=menuItem
              end
            end
          end
        end
      end--for registermenu
    end--if registermenu
  end--for infmodules

  --InfCore.PrintInspect(this.commandItems,"commandItems")--DEBUG
end

return this
