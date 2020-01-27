-- ssd TppPlayer.lua
local this={}
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local StrCode32=Fox.StrCode32
local TimerStart=GkEventTimerManager.Start
local TimerStop=GkEventTimerManager.Stop
local GetTypeIndex=GameObject.GetTypeIndex
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndexWithTypeName=GameObject.GetTypeIndexWithTypeName
local GAME_OBJECT_TYPE_SOLDIER2=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2
local GAME_OBJECT_TYPE_HOSTAGE2=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2
local NULL_ID=GameObject.NULL_ID
local SendCommand=GameObject.SendCommand
this.MISSION_CLEAR_CAMERA_FADE_DELAY_TIME=3
this.MISSION_CLEAR_CAMERA_DELAY_TIME=0
this.PLAYER_FALL_DEAD_DELAY_TIME=.2
this.DisableAbilityList={Stand="DIS_ACT_STAND",Squat="DIS_ACT_SQUAT",Crawl="DIS_ACT_CRAWL",Dash="DIS_ACT_DASH"}
this.ControlModeList={LockPadMode="All",LockMBTerminalOpenCloseMode="MB_Disable",MBTerminalOnlyMode="MB_OnlyMode"}
this.CageRandomTableG1={{1,20},{0,80}}
this.CageRandomTableG2={{2,15},{1,20},{0,65}}
this.CageRandomTableG3={{4,5},{3,10},{2,15},{1,20},{0,50}}
this.RareLevelList={"N","NR","R","SR","SSR"}
function this.RegisterCallbacks(callBacks)
  if IsTypeFunc(callBacks.OnFultonIconDying)then
    mvars.ply_OnFultonIconDying=callBacks.OnFultonIconDying
  end
end
function this.SetStartStatus(status)
  if(status>TppDefine.INITIAL_PLAYER_STATE.MIN)and(status<TppDefine.INITIAL_PLAYER_STATE.MAX)then
    gvars.ply_initialPlayerState=status
  end
end
function this.ResetDisableAction()
  vars.playerDisableActionFlag=PlayerDisableAction.NONE
end
function this.GetPosition()
  return{vars.playerPosX,vars.playerPosY,vars.playerPosZ}
end
function this.GetRotation()
  return vars.playerRotY
end
function this.Warp(info)
  if not IsTypeTable(info)then
    return
  end
  local pos=info.pos
  if not IsTypeTable(pos)or(#pos~=3)then
    return
  end
  local rotY=foxmath.NormalizeRadian(foxmath.DegreeToRadian(info.rotY or 0))
  local playerId
  if info.fobRespawn==true then
    playerId={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}
  else
    playerId={type="TppPlayer2",index=0}
  end
  local unrealize=info.unrealize
  local command={id="WarpAndWaitBlock",pos=pos,rotY=rotY,unrealize=unrealize}
  GameObject.SendCommand(playerId,command)
end
function this.ResetAroundCameraRotation(rotY)
  Player.RequestToSetCameraRotation{rotX=10,rotY=rotY or vars.playerRotY,interpTime=0}
end
function this.ResetPlayerForReturnBaseCamp()
  if not TppGameStatus.IsSet("","S_IN_BASE_CHECKPOINT")then
  end
  local pos,rotY
  if TppLocation.IsAfghan()then
    pos,rotY=Tpp.GetLocator("DataIdentifier_afgh_common_fasttravel","fast_afgh_basecamp")
  elseif TppLocation.IsMiddleAfrica()then
    pos,rotY=Tpp.GetLocator("DataIdentifier_mafr_common_fasttravel","fast_mafr_basecamp")
  end
  if pos then
    pos[2]=pos[2]+.8
    this.Warp{pos=pos,rotY=rotY}
  end
  this.ResetAroundCameraRotation(rotY)
end
function this.OnEndWarp()
  if mvars.ply_requestedRevivePlayer then
    mvars.ply_requestedRevivePlayer=false
    if not TppMission.IsMultiPlayMission(vars.missionCode)then
      TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"EndRevivePlayer",TppUI.FADE_PRIORITY.SYSTEM)
    end
  elseif mvars.ply_deliveryWarpState then
    this.OnEndWarpByFastTravel()
  end
end
function this.Revive()
  mvars.ply_requestedRevivePlayer=true
  GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="Revive",revivalType="Item"})
end
function this.SetForceFultonPercent(gameId,percentage)
  if not Tpp.IsTypeNumber(gameId)then
    return
  end
  if not Tpp.IsTypeNumber(percentage)then
    return
  end
  if(gameId<0)or(gameId>=NULL_ID)then
    return
  end
  if(percentage<0)or(percentage>100)then
    return
  end
  mvars.ply_forceFultonPercent=mvars.ply_forceFultonPercent or{}
  mvars.ply_forceFultonPercent[gameId]=percentage
end
function this.ForceChangePlayerToSnake(basic)
  vars.playerType=PlayerType.SNAKE
  if basic then
    vars.playerPartsType=PlayerPartsType.NORMAL
    vars.playerCamoType=PlayerCamoType.OLIVEDRAB
    vars.playerFaceEquipId=0
  else
    vars.playerPartsType=vars.sortiePrepPlayerSnakePartsType
    vars.playerCamoType=vars.sortiePrepPlayerSnakeCamoType
    vars.playerFaceEquipId=vars.sortiePrepPlayerSnakeFaceEquipId
  end
  Player.SetItemLevel(TppEquip.EQP_SUIT,vars.sortiePrepPlayerSnakeSuitLevel)
end
function this.CheckRotationSetting(a)
  if not IsTypeTable(a)then
    return
  end
  local mvars=mvars
  mvars.ply_checkDirectionList={}
  mvars.ply_checkRotationResult={}
  local function n(a,t,e)
    if e>=-180 and e<180 then
      a[t]=e
    end
  end
  for a,t in pairs(a)do
    if IsTypeFunc(t.func)then
      mvars.ply_checkDirectionList[a]={}
      mvars.ply_checkDirectionList[a].func=t.func
      local r=t.directionX or 0
      local o=t.directionY or 0
      local l=t.directionRangeX or 0
      local t=t.directionRangeY or 0
      n(mvars.ply_checkDirectionList[a],"directionX",r)
      n(mvars.ply_checkDirectionList[a],"directionY",o)
      n(mvars.ply_checkDirectionList[a],"directionRangeX",l)
      n(mvars.ply_checkDirectionList[a],"directionRangeY",t)
    else
      return
    end
  end
end
function this.CheckRotation()
  local mvars=mvars
  if mvars.ply_checkDirectionList==nil then
    return
  end
  for t,n in pairs(mvars.ply_checkDirectionList)do
    local e=this._CheckRotation(n.directionX,n.directionRangeX,n.directionY,n.directionRangeY,t)
    if e~=mvars.ply_checkRotationResult[t]then
      mvars.ply_checkRotationResult[t]=e
      mvars.ply_checkDirectionList[t].func(e)
    end
  end
end
function this.IsFastTraveling()
  if mvars.ply_deliveryWarpState then
    return true
  else
    return false
  end
end
function this.IsFastTravelingAndWarpEnd()
  if mvars.ply_deliveryWarpState and mvars.ply_deliveryWarpState<this.DELIVERY_WARP_STATE.START_FADE_IN then
    return true
  else
    return false
  end
end
function this.GetStationUniqueId(e)
  if not IsTypeString(e)then
    return
  end
  local e="col_stat_"..e
  return TppCollection.GetUniqueIdByLocatorName(e)
end
function this.SetMissionStartPositionToCurrentPosition()
  gvars.ply_useMissionStartPos=true
  gvars.ply_missionStartPos[0]=vars.playerPosX
  gvars.ply_missionStartPos[1]=vars.playerPosY+.5
  gvars.ply_missionStartPos[2]=vars.playerPosZ
  gvars.ply_missionStartRot=vars.playerRotY
  gvars.mis_orderBoxName=0
  this.SetInitialPositionFromMissionStartPosition()
end
function this.SetNoOrderBoxMissionStartPosition(pos,rotY)
  gvars.ply_useMissionStartPosForNoOrderBox=true
  gvars.ply_missionStartPosForNoOrderBox[0]=pos[1]
  gvars.ply_missionStartPosForNoOrderBox[1]=pos[2]
  gvars.ply_missionStartPosForNoOrderBox[2]=pos[3]
  gvars.ply_missionStartRotForNoOrderBox=rotY
end
function this.SetNoOrderBoxMissionStartPositionToCurrentPosition()
  gvars.ply_useMissionStartPosForNoOrderBox=true
  gvars.ply_missionStartPosForNoOrderBox[0]=vars.playerPosX
  gvars.ply_missionStartPosForNoOrderBox[1]=vars.playerPosY+.5
  gvars.ply_missionStartPosForNoOrderBox[2]=vars.playerPosZ
  gvars.ply_missionStartRotForNoOrderBox=vars.playerRotY
end
function this.SetMissionStartPositionToBaseFastTravelPoint()
  if TppLocation.IsAfghan()then
    this.SetMissionStartPosition({-453.189,288.312,2231.18},62.5757)
    this.SetInitialPositionFromMissionStartPosition()
  elseif TppLocation.IsMiddleAfrica()then
    this.SetMissionStartPosition({2865.74,102.611,-911.52},89.5129)
    this.SetInitialPositionFromMissionStartPosition()
  else
    this.ResetMissionStartPosition()
  end
end
function this.SetMissionStartPosition(pos,rotY)
  gvars.ply_useMissionStartPos=true
  gvars.ply_missionStartPos[0]=pos[1]
  gvars.ply_missionStartPos[1]=pos[2]
  gvars.ply_missionStartPos[2]=pos[3]
  gvars.ply_missionStartRot=rotY
end
function this.ResetMissionStartPosition()
  gvars.ply_useMissionStartPos=false
  gvars.ply_missionStartPos[0]=0
  gvars.ply_missionStartPos[1]=0
  gvars.ply_missionStartPos[2]=0
  gvars.ply_missionStartRot=0
end
function this.ResetNoOrderBoxMissionStartPosition()
  gvars.ply_useMissionStartPosForNoOrderBox=false
  gvars.ply_missionStartPosForNoOrderBox[0]=0
  gvars.ply_missionStartPosForNoOrderBox[1]=0
  gvars.ply_missionStartPosForNoOrderBox[2]=0
  gvars.ply_missionStartRotForNoOrderBox=0
end
function this.SetMissionStartPositionFromNoOrderBoxPosition()
  if gvars.ply_useMissionStartPosForNoOrderBox then
    gvars.ply_useMissionStartPos=true
    gvars.ply_missionStartPos[0]=gvars.ply_missionStartPosForNoOrderBox[0]
    gvars.ply_missionStartPos[1]=gvars.ply_missionStartPosForNoOrderBox[1]
    gvars.ply_missionStartPos[2]=gvars.ply_missionStartPosForNoOrderBox[2]
    gvars.ply_missionStartRot=gvars.ply_missionStartRotForNoOrderBox
    this.ResetNoOrderBoxMissionStartPosition()
  end
end
function this.DEBUG_CheckNearMissionStartPositionToRealizePosition()
  if gvars.ply_useMissionStartPos then
    local e
    if TppLocation.IsMotherBase()then
      e=1e3*1e3
    else
      e=64*64
    end
    local t=gvars.ply_missionStartPos[0]-vars.playerPosX
    local a=gvars.ply_missionStartPos[2]-vars.playerPosZ
    local a=(t*t)+(a*a)
    if(a>e)then
      return true
    else
      return false
    end
  else
    return false
  end
end
function this.SetInitialPositionToCurrentPosition()
  vars.initialPlayerFlag=PlayerFlag.USE_VARS_FOR_INITIAL_POS
  vars.initialPlayerPosX=vars.playerPosX
  vars.initialPlayerPosY=vars.playerPosY+.5
  vars.initialPlayerPosZ=vars.playerPosZ
  vars.initialPlayerRotY=vars.playerRotY
end
function this.SetInitialPosition(pos,rotY)
  vars.initialPlayerFlag=PlayerFlag.USE_VARS_FOR_INITIAL_POS
  vars.initialPlayerPosX=pos[1]
  vars.initialPlayerPosY=pos[2]
  vars.initialPlayerPosZ=pos[3]
  vars.initialPlayerRotY=rotY
end
function this.SetInitialPositionFromMissionStartPosition()
  if gvars.ply_useMissionStartPos then
    vars.initialPlayerFlag=PlayerFlag.USE_VARS_FOR_INITIAL_POS
    vars.initialPlayerPosX=gvars.ply_missionStartPos[0]
    vars.initialPlayerPosY=gvars.ply_missionStartPos[1]
    vars.initialPlayerPosZ=gvars.ply_missionStartPos[2]
    vars.initialPlayerRotY=gvars.ply_missionStartRot
    vars.playerCameraRotation[0]=0
    vars.playerCameraRotation[1]=gvars.ply_missionStartRot
  end
end
function this.ResetInitialPosition()
  vars.initialPlayerFlag=0
  vars.initialPlayerPosX=0
  vars.initialPlayerPosY=0
  vars.initialPlayerPosZ=0
  vars.initialPlayerRotY=0
end
function this.StoreTempInitialPosition()
  gvars.sav_continueForOutOfBaseArea=true
  gvars.ply_startPosTempForBaseDefense[0]=vars.playerPosX
  gvars.ply_startPosTempForBaseDefense[1]=vars.playerPosY
  gvars.ply_startPosTempForBaseDefense[2]=vars.playerPosZ
  gvars.ply_startPosTempForBaseDefense[3]=vars.playerRotY
end
function this.RestoreTempInitialPosition()
  vars.playerPosX=gvars.ply_startPosTempForBaseDefense[0]
  vars.playerPosY=gvars.ply_startPosTempForBaseDefense[1]
  vars.playerPosZ=gvars.ply_startPosTempForBaseDefense[2]
  vars.playerRotY=gvars.ply_startPosTempForBaseDefense[3]
  gvars.sav_continueForOutOfBaseArea=false
  gvars.ply_startPosTempForBaseDefense[0]=0
  gvars.ply_startPosTempForBaseDefense[1]=0
  gvars.ply_startPosTempForBaseDefense[2]=0
  gvars.ply_startPosTempForBaseDefense[3]=0
  this.SetInitialPositionToCurrentPosition()
end
function this.FailSafeInitialPositionForFreePlay()
  if not((vars.missionCode==30010)or(vars.missionCode==30020))then
    return
  end
  if vars.initialPlayerFlag~=PlayerFlag.USE_VARS_FOR_INITIAL_POS then
    return
  end
  if(((vars.initialPlayerPosX>3500)or(vars.initialPlayerPosX<-3500))or(vars.initialPlayerPosZ>3500))or(vars.initialPlayerPosZ<-3500)then
    local failSafePositions={
      [30010]={1448.61,337.787,1466.4},
      [30020]={-510.73,5.09,1183.02}
    }
    local position=failSafePositions[vars.missionCode]
    vars.initialPlayerPosX,vars.initialPlayerPosY,vars.initialPlayerPosZ=position[1],position[2],position[3]
  end
end
function this.RegisterTemporaryPlayerType(playerSetting)
  if not IsTypeTable(playerSetting)then
    return
  end
  mvars.ply_isExistTempPlayerType=true
  local camoType=playerSetting.camoType
  local partsType=playerSetting.partsType
  local playerType=playerSetting.playerType
  local handEquip=playerSetting.handEquip
  local faceEquipId=playerSetting.faceEquipId
  if partsType then
    mvars.ply_tempPartsType=partsType
  end
  if camoType then
    mvars.ply_tempCamoType=camoType
  end
  if playerType then
    mvars.ply_tempPlayerType=playerType
  end
  if handEquip then
    mvars.ply_tempPlayerHandEquip=handEquip
  end
  if faceEquipId then
    mvars.ply_tempPlayerFaceEquipId=faceEquipId
  end
end
function this.SaveCurrentPlayerType()
  if not gvars.ply_isUsingTempPlayerType then
    if DebugMenu then
      if vars.playerCamoType==PlayerCamoType.HOSPITAL then
        TppGameSequence.GetPauseMenu():DebugPause()
      end
    end
    gvars.ply_lastPlayerPartsTypeUsingTemp=vars.playerPartsType
    gvars.ply_lastPlayerCamoTypeUsingTemp=vars.playerCamoType
    gvars.ply_lastPlayerHandTypeUsingTemp=vars.handEquip
    gvars.ply_lastPlayerTypeUsingTemp=vars.playerType
    gvars.ply_lastPlayerFaceIdUsingTemp=vars.playerFaceId
    gvars.ply_lastPlayerFaceEquipIdUsingTemp=vars.playerFaceEquipId
  end
  gvars.ply_isUsingTempPlayerType=true
end
function this.ApplyTemporaryPlayerType()
  if mvars.ply_tempPartsType then
    vars.playerPartsType=mvars.ply_tempPartsType
  end
  if mvars.ply_tempCamoType then
    vars.playerCamoType=mvars.ply_tempCamoType
  end
  if mvars.ply_tempPlayerType then
    vars.playerType=mvars.ply_tempPlayerType
  end
  if mvars.ply_tempPlayerHandEquip then
    vars.handEquip=mvars.ply_tempPlayerHandEquip
  end
  if mvars.ply_tempPlayerFaceEquipId then
    vars.playerFaceEquipId=mvars.ply_tempPlayerFaceEquipId
  end
end
function this.RestoreTemporaryPlayerType()
  if gvars.ply_isUsingTempPlayerType then
    if DebugMenu then
      if gvars.ply_lastPlayerCamoTypeUsingTemp==PlayerCamoType.HOSPITAL then
        TppGameSequence.GetPauseMenu():DebugPause()
      end
    end
    vars.playerPartsType=gvars.ply_lastPlayerPartsTypeUsingTemp
    vars.playerCamoType=gvars.ply_lastPlayerCamoTypeUsingTemp
    vars.playerType=gvars.ply_lastPlayerTypeUsingTemp
    vars.playerFaceId=gvars.ply_lastPlayerFaceIdUsingTemp
    vars.playerFaceEquipId=gvars.ply_lastPlayerFaceEquipIdUsingTemp
    vars.handEquip=gvars.ply_lastPlayerHandTypeUsingTemp
    gvars.ply_lastPlayerPartsTypeUsingTemp=PlayerPartsType.NORMAL_SCARF
    gvars.ply_lastPlayerCamoTypeUsingTemp=PlayerCamoType.OLIVEDRAB
    gvars.ply_lastPlayerTypeUsingTemp=PlayerType.SNAKE
    gvars.ply_lastPlayerFaceIdUsingTemp=0
    gvars.ply_lastPlayerFaceEquipIdUsingTemp=0
    gvars.ply_isUsingTempPlayerType=false
    gvars.ply_lastPlayerHandTypeUsingTemp=TppEquip.EQP_HAND_NORMAL
  end
end
function this.SupplyAllAmmoFullOnMissionFinalize()
end
function this.SupplyWeaponAmmoFull(slot)
end
function this.SupplySupportWeaponAmmoFull(weaponId)
end
function this.SupplyAmmoByBulletId(ammoId,defaultAmmo)
end
function this.SavePlayerCurrentAmmoCount()
end
function this.SetMissionStartAmmoCount()
end
function this.SetEquipMissionBlockGroupSize()
  local size=mvars.ply_equipMissionBlockGroupSize
  if size>0 then
    TppEquip.CreateEquipMissionBlockGroup{size=size}
  end
end
function this.SetMaxPickableLocatorCount()
  if mvars.ply_maxPickableLocatorCount>0 then
    TppPickable.OnAllocate{locators=mvars.ply_maxPickableLocatorCount,svarsName="ply_pickableLocatorDisabled"}
  end
end
function this.SetMaxPlacedLocatorCount()
  if mvars.ply_maxPlacedLocatorCount>0 then
    TppPlaced.OnAllocate{locators=mvars.ply_maxPlacedLocatorCount,svarsName="ply_placedLocatorDisabled"}
  end
end
function this.IsDecoy(equipId)
  local supportWeaponTypeId=TppEquip.GetSupportWeaponTypeId(equipId)
  local decoyTypes={[TppEquip.SWP_TYPE_Decoy]=true,[TppEquip.SWP_TYPE_ActiveDecoy]=true,[TppEquip.SWP_TYPE_ShockDecoy]=true}
  if decoyTypes[supportWeaponTypeId]then
    return true
  else
    return false
  end
end
function this.IsMine(equipId)
  local supportWeaponTypeId=TppEquip.GetSupportWeaponTypeId(equipId)
  local mineTypes={
    [TppEquip.SWP_TYPE_DMine]=true,
    [TppEquip.SWP_TYPE_SleepingGusMine]=true,
    [TppEquip.SWP_TYPE_AntitankMine]=true,
    [TppEquip.SWP_TYPE_ElectromagneticNetMine]=true
  }
  if mineTypes[supportWeaponTypeId]then
    return true
  else
    return false
  end
end
function this.AddTrapSettingForIntel(trapInfo)
  local trapName=trapInfo.trapName
  local direction=trapInfo.direction or 0
  local directionRange=trapInfo.directionRange or 60
  local intelName=trapInfo.intelName
  local autoIcon=trapInfo.autoIcon
  local gotFlagName=trapInfo.gotFlagName
  local markerTrapName=trapInfo.markerTrapName
  local markerObjectiveName=trapInfo.markerObjectiveName
  local identifierName=trapInfo.identifierName
  local locatorName=trapInfo.locatorName
  if not IsTypeString(trapName)then
    return
  end
  mvars.ply_intelTrapInfo=mvars.ply_intelTrapInfo or{}
  if intelName then
    mvars.ply_intelTrapInfo[intelName]={trapName=trapName}
  else
    return
  end
  mvars.ply_intelNameReverse=mvars.ply_intelNameReverse or{}
  mvars.ply_intelNameReverse[StrCode32(intelName)]=intelName
  mvars.ply_intelFlagInfo=mvars.ply_intelFlagInfo or{}
  if gotFlagName then
    mvars.ply_intelFlagInfo[intelName]=gotFlagName
    mvars.ply_intelFlagInfo[StrCode32(intelName)]=gotFlagName
    mvars.ply_intelTrapInfo[intelName].gotFlagName=gotFlagName
  end
  mvars.ply_intelMarkerObjectiveName=mvars.ply_intelMarkerObjectiveName or{}
  if markerObjectiveName then
    mvars.ply_intelMarkerObjectiveName[intelName]=markerObjectiveName
    mvars.ply_intelMarkerObjectiveName[StrCode32(intelName)]=markerObjectiveName
    mvars.ply_intelTrapInfo[intelName].markerObjectiveName=markerObjectiveName
  end
  mvars.ply_intelMarkerTrapList=mvars.ply_intelMarkerTrapList or{}
  mvars.ply_intelMarkerTrapInfo=mvars.ply_intelMarkerTrapInfo or{}
  if markerTrapName then
    table.insert(mvars.ply_intelMarkerTrapList,markerTrapName)
    mvars.ply_intelMarkerTrapInfo[StrCode32(markerTrapName)]=intelName
    mvars.ply_intelTrapInfo[intelName].markerTrapName=markerTrapName
  end
  mvars.ply_intelTrapList=mvars.ply_intelTrapList or{}
  if autoIcon then
    table.insert(mvars.ply_intelTrapList,trapName)
    mvars.ply_intelTrapInfo[StrCode32(trapName)]=intelName
    mvars.ply_intelTrapInfo[intelName].autoIcon=true
  end
  if identifierName and locatorName then
    local pos,rot=Tpp.GetLocator(identifierName,locatorName)
    if pos and rot then
      direction=rot
    end
  end
  mvars.ply_intelTrapInfo[intelName].direction=direction
  mvars.ply_intelTrapInfo[intelName].directionRange=directionRange
  Player.AddTrapDetailCondition{trapName=trapName,condition=PlayerTrap.FINE,action=(PlayerTrap.NORMAL+PlayerTrap.BEHIND),stance=(PlayerTrap.STAND+PlayerTrap.SQUAT),direction=direction,directionRange=directionRange}
end
function this.ShowIconForIntel(messageArg,dontShow)
  if not IsTypeString(messageArg)then
    return
  end
  local trapName
  if mvars.ply_intelTrapInfo and mvars.ply_intelTrapInfo[messageArg]then
    trapName=mvars.ply_intelTrapInfo[messageArg].trapName
  end
  local intelFlagInfo=mvars.ply_intelFlagInfo[messageArg]
  if intelFlagInfo then
    if svars[intelFlagInfo]~=nil then
      dontShow=svars[intelFlagInfo]
    end
  end
  if not dontShow then
    if Tpp.IsNotAlert()then
      Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL,message=Fox.StrCode32"GetIntel",messageInDisplay=Fox.StrCode32"IntelIconInDisplay",messageArg=messageArg}
    elseif trapName then
      Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL_NG,message=Fox.StrCode32"NGIntel",messageInDisplay=Fox.StrCode32"IntelIconInDisplay",messageArg=messageArg}
      if not TppRadio.IsPlayed(TppRadio.COMMON_RADIO_LIST[TppDefine.COMMON_RADIO.CANNOT_GET_INTEL_ON_ALERT])then
        TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.CANNOT_GET_INTEL_ON_ALERT)
      end
    end
  end
end
function this.GotIntel(intelNameHash)
  local gotIntelName=mvars.ply_intelFlagInfo[intelNameHash]
  if not gotIntelName then
    return
  end
  if svars[gotIntelName]~=nil then
    svars[gotIntelName]=true
  end
  local intelMarkerObjectiveName=mvars.ply_intelMarkerObjectiveName[intelNameHash]
  if intelMarkerObjectiveName then
    local objectiveDefine=TppMission.GetParentObjectiveName(intelMarkerObjectiveName)
    local objectives={}
    for a,t in pairs(objectiveDefine)do
      table.insert(objectives,a)
    end
    TppMission.UpdateObjective{objectives=objectives}
  end
end
function this.HideIconForIntel()
  Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL}
  Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL_NG}
end
function this.DisableSwitchIcon()
  GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="SetDisableSearchSwitch",disable=true})
end
function this.EnableSwitchIcon()
  GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="SetDisableSearchSwitch",disable=false})
end
function this.AddTrapSettingForQuest(quest)
  local trapName=quest.trapName
  local direction=quest.direction or 0
  local directionRange=quest.directionRange or 180
  local questName=quest.questName
  if not IsTypeString(trapName)then
    return
  end
  mvars.ply_questStartTrapInfo=mvars.ply_questStartTrapInfo or{}
  if questName then
    mvars.ply_questStartTrapInfo[questName]={trapName=trapName}
  else
    return
  end
  mvars.ply_questNameReverse=mvars.ply_questNameReverse or{}
  mvars.ply_questNameReverse[StrCode32(questName)]=questName
  mvars.ply_questStartFlagInfo=mvars.ply_questStartFlagInfo or{}
  mvars.ply_questStartFlagInfo[questName]=false
  mvars.ply_questTrapList=mvars.ply_questTrapList or{}
  table.insert(mvars.ply_questTrapList,trapName)
  mvars.ply_questStartTrapInfo[StrCode32(trapName)]=questName
  Player.AddTrapDetailCondition{trapName=trapName,condition=PlayerTrap.FINE,action=PlayerTrap.NORMAL,stance=(PlayerTrap.STAND+PlayerTrap.SQUAT),direction=direction,directionRange=directionRange}
end
function this.ShowIconForQuest(messageArg,dontShow)
  if not IsTypeString(messageArg)then
    return
  end
  local trapInfo
  if mvars.ply_questStartTrapInfo and mvars.ply_questStartTrapInfo[messageArg]then
    trapInfo=mvars.ply_questStartTrapInfo[messageArg].trapName
  end
  if mvars.ply_questStartFlagInfo[messageArg]~=nil then
    dontShow=mvars.ply_questStartFlagInfo[messageArg]
  end
  if not dontShow then
    Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.TRAINING,message=Fox.StrCode32"QuestStarted",messageInDisplay=Fox.StrCode32"QuestIconInDisplay",messageArg=messageArg}
  end
end
function this.QuestStarted(questNameS32)
  local questName=mvars.ply_questNameReverse[questNameS32]
  if mvars.ply_questStartFlagInfo[questName]~=nil then
    mvars.ply_questStartFlagInfo[questName]=true
  end
  this.HideIconForQuest()
end
function this.HideIconForQuest()
  Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.TRAINING}
end
function this.ResetIconForQuest(iconType)
  mvars.ply_questStartFlagInfo.ShootingPractice=false
end
function this.AppearHorseOnMissionStart(identifier,key)
  local pos,rot=Tpp.GetLocator(identifier,key)
  if pos then
    vars.buddyType=BuddyType.HORSE
    vars.initialBuddyPos[0]=pos[1]
    vars.initialBuddyPos[1]=pos[2]
    vars.initialBuddyPos[2]=pos[3]
  end
end
function this.StartGameOverCamera(gameObjectId,startTimerName,announceLog,fadeInName)
  if mvars.ply_gameOverCameraGameObjectId~=nil then
    return
  end
  mvars.ply_gameOverCameraGameObjectId=gameObjectId
  mvars.ply_gameOverCameraStartTimerName=startTimerName
  mvars.ply_gameOverCameraAnnounceLog=announceLog
  mvars.ply_gameOverCameraFadeInName=fadeInName
  TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  TppSound.PostJingleOnGameOver()
  TppSoundDaemon.PostEvent"sfx_s_force_camera_out"
  vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
  TimerStart("Timer_StartGameOverCamera",.25)
end
function this._StartGameOverCamera(e,e)
  TppUiStatusManager.ClearStatus"AnnounceLog"FadeFunction.SetFadeColor(64,0,0,255)
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,mvars.ply_gameOverCameraStartTimerName,TppUI.FADE_PRIORITY.DEMO,{exceptGameStatus={AnnounceLog=false}})
  Player.RequestToSetCameraFocalLengthAndDistance{focalLength=16,interpTime=TppUI.FADE_SPEED.FADE_HIGHSPEED}
end
function this.PrepareStartGameOverCamera()
  FadeFunction.ResetFadeColor()
  local exceptGameStatus={}
  for uiName,statusType in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
    exceptGameStatus[uiName]=false
  end
  for uiName,statusType in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
    exceptGameStatus[uiName]=false
  end
  exceptGameStatus.S_DISABLE_NPC=nil
  exceptGameStatus.AnnounceLog=nil
  TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,mvars.ply_gameOverCameraFadeInName,TppUI.FADE_PRIORITY.DEMO,{exceptGameStatus=exceptGameStatus})
  Player.RequestToStopCameraAnimation{}
  if mvars.ply_gameOverCameraAnnounceLog then
    TppUiStatusManager.ClearStatus"AnnounceLog"
    TppUI.ShowAnnounceLog(mvars.ply_gameOverCameraAnnounceLog)
  end
end
function this.SetTargetDeadCamera(params)
  local gameObjectName
  local gameObjectId
  local announceLog
  if IsTypeTable(params)then
    gameObjectName=params.gameObjectName or""
    gameObjectId=params.gameObjectId
    announceLog=params.announceLog or"target_extract_failed"
  end
  gameObjectId=gameObjectId or GetGameObjectId(gameObjectName)
  if gameObjectId==NULL_ID then
    return
  end
  this.StartGameOverCamera(gameObjectId,"EndFadeOut_StartTargetDeadCamera",announceLog,"EndFadeIn_StartTargetDeadCamera")
end
function this._SetTargetDeadCamera()
  this.PrepareStartGameOverCamera()
  Player.RequestToPlayCameraNonAnimation{characterId=mvars.ply_gameOverCameraGameObjectId,isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,candidateRots={{10,0},{10,45},{10,90},{10,135},{10,180},{10,225},{10,270}},skeletonNames={"SKL_004_HEAD","SKL_011_LUARM","SKL_021_RUARM","SKL_032_LFOOT","SKL_042_RFOOT"},skeletonCenterOffsets={Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0)},skeletonBoundings={Vector3(0,.45,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,-.3,0),Vector3(0,-.3,0)},offsetPos=Vector3(.3,.2,-4.6),focalLength=21,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.001,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=16}
end
function this.ReserveTargetDeadCameraGameObjectId(gameObjectId)
  mvars.ply_reserveDeadTargetGameObjectId=gameObjectId
end
function this.SetTargetDeadCameraIfReserved()
  if mvars.ply_reserveDeadTargetGameObjectId then
    this.SetTargetDeadCamera{gameObjectId=mvars.ply_reserveDeadTargetGameObjectId}
    return true
  end
end
function this.SetDefenseTargetBrokenCamera(params)
  local announceLog
  if not IsTypeTable(params)then
    return
  end
  if not params.gimmickPosition then
    return
  end
  if not params.cameraRotation then
    return
  end
  if not params.cameraDistance then
    return
  end
  if params.announceLog then
    announceLog=params.announceLog
  end
  mvars.ply_gameOverCameraGimmickInfo=params
  this.StartGameOverCamera(NULL_ID,"EndFadeOut_StartDefenseTargetBrokenCamera",announceLog)
end
function this._SetDefenseTargetBrokenCamera()
  if not mvars.ply_gameOverCameraGimmickInfo then
    return
  end
  local a=mvars.ply_gameOverCameraGimmickInfo.gimmickPosition
  local t=mvars.ply_gameOverCameraGimmickInfo.cameraRotation
  local n=mvars.ply_gameOverCameraGimmickInfo.cameraDistance
  this.PrepareStartGameOverCamera()
  local e=a+Vector3(0,1.7,0)
  local a=e+t:Rotate(Vector3(.064699664,.107832773,-.992061513)*n)
  Player.RequestToPlayCameraNonAnimation{isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,positionAndTargetMode=true,position=a,target=e,isCollisionCheck=false,focalLength=18,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.001,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=16}
end
local a={
  [Fox.StrCode32"com_ai001_gim_n0000|srt_aip0_main0_def"]=4.2,
  [Fox.StrCode32"com_ai002_gim_n0000|srt_pup0_main0_ssd_v00"]=4.2,
  [Fox.StrCode32"com_ai003_gim_n0000|srt_ssde_swtc001"]=3.6,
  [Fox.StrCode32"whm0_gim_n0000|srt_whm0_main0_def_v00"]=8.5,
  [Fox.StrCode32"com_portal001_gim_n0000|srt_ftp0_main0_def_v00"]=8
}
local c={
  [Fox.StrCode32"whm0_gim_n0000|srt_whm0_main0_def_v00"]={foxmath.DegreeToRadian(300)},
  [Fox.StrCode32"com_portal001_gim_n0000|srt_ftp0_main0_def_v00"]={foxmath.DegreeToRadian(210),[Gimmick.GetDataSetCode"/Assets/ssd/level/location/afgh/block_extraLarge/south/afgh_south_gimmick.fox2"]=foxmath.DegreeToRadian(45)},
  [Fox.StrCode32"com_ai003_gim_n0000|srt_ssde_swtc001"]={foxmath.DegreeToRadian(215)}
}
local l={
  [Fox.StrCode32"whm0_gim_n0000|srt_whm0_main0_def_v00"]=Vector3(0,2,0),
  [Fox.StrCode32"com_portal001_gim_n0000|srt_ftp0_main0_def_v00"]=Vector3(0,10,0)
}
function this.GetDefenseTargetBrokenCameraInfo(r,o,e,t)
  local camDistance=4.2
  if e and a[e]then
    camDistance=a[e]
  end
  local angleRad=foxmath.DegreeToRadian(150)
  if c[e]then
    local e=c[e]
    if e[t]then
      angleRad=e[t]
    else
      angleRad=e[1]
    end
    if not angleRad then
      return
    end
  end
  local rotY=o*Quat.RotationY(angleRad)
  local a=Vector3(0,1,0)
  if l[e]then
    a=l[e]
  end
  local pos=r-a
  local camInfo={gimmickPosition=pos,cameraRotation=rotY,cameraDistance=camDistance}
  return camInfo
end
function this.ReserveDefenseTargetBrokenCamera(e)
  local a
  if not IsTypeTable(e)then
    return
  end
  if not e.gimmickPosition then
    return
  end
  if not e.cameraRotation then
    return
  end
  if not e.cameraDistance then
    return
  end
  if e.announceLog then
    a=e.announceLog
  end
  mvars.ply_reserveGameOverCameraGimmickInfo=e
end
function this.SetDefenseTargetBrokenCameraIfReserved()
  if mvars.ply_reserveGameOverCameraGimmickInfo then
    this.SetDefenseTargetBrokenCamera(mvars.ply_reserveGameOverCameraGimmickInfo)
    return true
  end
end
function this.SetPressStartCamera()
  local characterId=GetGameObjectId"Player"
  if characterId==NULL_ID then
    return
  end
  Player.RequestToStopCameraAnimation{}
  Player.RequestToPlayCameraNonAnimation{characterId=characterId,isFollowPos=true,isFollowRot=true,followTime=0,followDelayTime=0,candidateRots={{0,185}},skeletonNames={"SKL_004_HEAD"},skeletonCenterOffsets={Vector3(-.5,-.15,0)},skeletonBoundings={Vector3(.5,.45,.1)},offsetPos=Vector3(-.8,0,-1.4),focalLength=21,aperture=1.875,timeToSleep=0,fitOnCamera=false,timeToStartToFitCamera=0,fitCameraInterpTime=0,diffFocalLengthToReFitCamera=0}
end
function this.SetTitleCamera()
  local e=GetGameObjectId"Player"
  if e==NULL_ID then
    return
  end
  Player.RequestToStopCameraAnimation{}
  Player.RequestToPlayCameraNonAnimation{characterId=e,isFollowPos=true,isFollowRot=true,followTime=0,followDelayTime=0,candidateRots={{0,185}},skeletonNames={"SKL_004_HEAD"},skeletonCenterOffsets={Vector3(-.5,-.15,.1)},skeletonBoundings={Vector3(.5,.45,.9)},offsetPos=Vector3(-.8,0,-1.8),focalLength=21,aperture=1.875,timeToSleep=0,fitOnCamera=false,timeToStartToFitCamera=0,fitCameraInterpTime=0,diffFocalLengthToReFitCamera=0}
end
function this.SetSearchTarget(targetGameObjectName,gameObjectType,name,skeletonName,offset,targetFox2Name,doDirectionCheck,wideCheckRange)
  if(targetGameObjectName==nil or gameObjectType==nil)then
    return
  end
  local l=GetTypeIndexWithTypeName(gameObjectType)
  if l==NULL_ID then
    return
  end
  if doDirectionCheck==nil then
    doDirectionCheck=true
  end
  if offset==nil then
    offset=Vector3(0,.25,0)
  end
  if wideCheckRange==nil then
    wideCheckRange=.03
  end
  local e={name=name,targetGameObjectTypeIndex=l,targetGameObjectName=targetGameObjectName,offset=offset,centerRange=.3,lookingTime=1,distance=200,doWideCheck=true,wideCheckRadius=.15,wideCheckRange=wideCheckRange,doDirectionCheck=false,directionCheckRange=100,doCollisionCheck=true}
  if(skeletonName~=nil)then
    e.skeletonName=skeletonName
  end
  if(targetFox2Name~=nil)then
    e.targetFox2Name=targetFox2Name
  end
  Player.AddSearchTarget(e)
end
function this.IsSneakPlayerInFOB(e)
  if e==0 then
    return true
  else
    return false
  end
end
function this.PlayMissionClearCamera()
  local status=this.SetPlayerStatusForMissionEndCamera()
  if not status then
    return
  end
  TimerStart("Timer_StartPlayMissionClearCameraStep1",.25)
end
function this.SetPlayerStatusForMissionEndCamera()
  Player.SetPadMask{settingName="MissionClearCamera",except=true}
  vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
  return true
end
function this.ResetMissionEndCamera()
  Player.ResetPadMask{settingName="MissionClearCamera"}
  Player.RequestToStopCameraAnimation{}
end
function this.PlayCommonMissionEndCamera(HorseCamFunc,VehicleCamFuncs,WalkerGearCamFunc,MissionClearOnFootCamFunc,step,unkp6)
  local playMissionClearTime
  local vehicleId=vars.playerVehicleGameObjectId
  if Tpp.IsHorse(vehicleId)then
    GameObject.SendCommand(vehicleId,{id="HorseForceStop"})
    playMissionClearTime=HorseCamFunc(vehicleId,step,unkp6)
  elseif Tpp.IsVehicle(vehicleId)then
    local r=GameObject.SendCommand(vehicleId,{id="GetVehicleType"})
    GameObject.SendCommand(vehicleId,{id="ForceStop",enabled=true})
    local r=VehicleCamFuncs[r]
    if r then
      playMissionClearTime=r(vehicleId,step,unkp6)
    end
  elseif(Tpp.IsPlayerWalkerGear(vehicleId)or Tpp.IsEnemyWalkerGear(vehicleId))then
    GameObject.SendCommand(vehicleId,{id="ForceStop",enabled=true})
    playMissionClearTime=WalkerGearCamFunc(vehicleId,step,unkp6)
  elseif Tpp.IsHelicopter(vehicleId)then
  else
    playMissionClearTime=MissionClearOnFootCamFunc(step,unkp6)
  end
  if playMissionClearTime then
    local timerName="Timer_StartPlayMissionClearCameraStep"..tostring(step+1)
    TimerStart(timerName,playMissionClearTime)
  end
end
function this._PlayMissionClearCamera(step,unkp2)
  if step==1 then
    TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_common_jingle_clear")
  end
  this.PlayCommonMissionEndCamera(this.PlayMissionClearCameraOnRideHorse,this.VEHICLE_MISSION_CLEAR_CAMERA,this.PlayMissionClearCameraOnWalkerGear,this.PlayMissionClearCameraOnFoot,step,unkp2)
end
function this.RequestMissionClearMotion()
  Player.RequestToPlayDirectMotion{"missionClearMotion",{"/Assets/ssd/motion/SI_game/fani/bodies/snap/snapnon/snapnon_f_idl7.gani",false,"","","",false}}
end
function this.PlayMissionClearCameraOnFoot(unkp1,unkp2)
  if PlayerInfo.AndCheckStatus{PlayerStatus.NORMAL_ACTION}then
    if PlayerInfo.OrCheckStatus{PlayerStatus.STAND,PlayerStatus.SQUAT}then
      if PlayerInfo.AndCheckStatus{PlayerStatus.CARRY}then
        mvars.ply_requestedMissionClearCameraCarryOff=true
        GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="RequestCarryOff"})
      else
        this.RequestMissionClearMotion()
      end
    end
  end
  local skeletonNames={"SKL_004_HEAD","SKL_002_CHEST"}
  local skeletonCenterOffsets={Vector3(0,0,.05),Vector3(.15,0,0)}
  local skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
  local offsetPos=Vector3(0,0,-4.5)
  local interpTimeAtStart=.3
  local unkl6
  local callSeOfCameraInterp=false
  local timeToSleep=20
  local useLastSelectedIndex=false
  if unkp1==1 then
    skeletonNames={"SKL_004_HEAD","SKL_002_CHEST"}
    skeletonCenterOffsets={Vector3(0,0,.05),Vector3(.15,0,0)}
    skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
    offsetPos=Vector3(0,0,-1.5)
    interpTimeAtStart=.3
    unkl6=1
    callSeOfCameraInterp=true
  elseif unkp2 then
    skeletonNames={"SKL_004_HEAD"}
    skeletonCenterOffsets={Vector3(0,0,.05)}
    skeletonBoundings={Vector3(.1,.125,.1)}
    offsetPos=Vector3(0,-.5,-3.5)
    interpTimeAtStart=3
    timeToSleep=4
  else
    skeletonNames={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"}
    skeletonCenterOffsets={Vector3(0,0,.05),Vector3(.15,0,0),Vector3(-.15,0,0)}
    skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)}
    offsetPos=Vector3(0,0,-3.2)
    interpTimeAtStart=3
    useLastSelectedIndex=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{1,168},{1,-164}},skeletonNames=skeletonNames,skeletonCenterOffsets=skeletonCenterOffsets,skeletonBoundings=skeletonBoundings,offsetPos=offsetPos,focalLength=28,aperture=1.875,timeToSleep=timeToSleep,interpTimeAtStart=interpTimeAtStart,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=callSeOfCameraInterp,useLastSelectedIndex=useLastSelectedIndex}
  return unkl6
end
function this.PlayMissionClearCameraOnRideHorse(e,c,p)
  local r={"SKL_004_HEAD","SKL_002_CHEST"}
  local n={Vector3(0,0,.05),Vector3(.15,0,0)}
  local a={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
  local t=Vector3(0,0,-3.2)
  local e=.2
  local i
  local s=false
  local l=20
  local o=false
  if p then
    l=4
  end
  if c==1 then
    r={"SKL_004_HEAD","SKL_002_CHEST"}
    n={Vector3(0,-.125,.05),Vector3(.15,-.125,0)}
    a={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
    t=Vector3(0,0,-3.2)
    e=.2
    i=1
    s=true
  else
    r={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"}
    n={Vector3(0,-.125,.05),Vector3(.15,-.125,0),Vector3(-.15,-.125,0)}
    a={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)}
    t=Vector3(0,0,-4.5)
    e=3
    o=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{0,160},{0,-160}},skeletonNames=r,skeletonCenterOffsets={Vector3(0,-.125,.05),Vector3(.15,-.125,0),Vector3(-.15,-.125,0)},skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)},skeletonCenterOffsets=n,skeletonBoundings=a,offsetPos=t,focalLength=28,aperture=1.875,timeToSleep=l,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=s,useLastSelectedIndex=o}
  return i
end
function this.PlayMissionClearCameraOnRideLightVehicle(e,i,s)
  local e=Vector3(-.35,.6,.7)
  local a=Vector3(0,0,-2.25)
  local t=.2
  local r
  local n=false
  local o=20
  local l=false
  if s then
    o=4
  end
  if i==1 then
    e=Vector3(-.35,.6,.7)
    a=Vector3(0,0,-2.25)
    t=.2
    r=.5
    n=true
  else
    e=Vector3(-.35,.4,.7)
    a=Vector3(0,0,-4)
    t=.75
    l=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{3,160},{3,-160}},offsetTarget=e,offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=t,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=n,useLastSelectedIndex=l}
  return r
end
function this.PlayMissionClearCameraOnRideTruck(e,i,s)
  local t=Vector3(-.35,1.3,1)
  local a=Vector3(0,0,-2)
  local e=.2
  local n
  local o=false
  local l=20
  local r=false
  if s then
    l=4
  end
  if i==1 then
    t=Vector3(-.35,1.3,1)
    a=Vector3(0,0,-3)
    e=.2
    n=.5
    o=true
  else
    t=Vector3(-.35,1,1)
    a=Vector3(0,0,-6)
    e=.75
    r=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{3,160},{3,-160}},offsetTarget=t,offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=l,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=o,useLastSelectedIndex=r}
  return n
end
function this.PlayMissionClearCameraOnRideCommonArmoredVehicle(a,s,e,i)
  local a=Vector3(.05,-.5,-2.2)
  if e==1 then
    a=Vector3(.05,-.5,-2.2)
  else
    a=Vector3(-.05,-1,0)
  end
  local t=Vector3(0,0,-7.5)
  local e=.2
  local n
  local r=false
  local o=20
  local l=false
  if i then
    o=4
  end
  if s==1 then
    t=Vector3(0,0,-7.5)
    e=.2
    n=.5
    r=true
  else
    t=Vector3(0,0,-13.25)
    e=.75
    l=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{8,165},{8,-165}},offsetTarget=a,offsetPos=t,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=r,useLastSelectedIndex=l}
  return n
end
function this.PlayMissionClearCameraOnRideEasternArmoredVehicle(r,n,t)
  local a
  a=this.PlayMissionClearCameraOnRideCommonArmoredVehicle(r,n,1,t)
  return a
end
function this.PlayMissionClearCameraOnRideWesternArmoredVehicle(t,n)
  local a
  a=this.PlayMissionClearCameraOnRideCommonArmoredVehicle(t,n,2,isQuest)
  return a
end
function this.PlayMissionClearCameraOnRideTank(e,l,i)
  local a=Vector3(0,0,-6.5)
  local e=.2
  local o
  local r=false
  local n=20
  local t=false
  if i then
    n=4
  end
  if l==1 then
    a=Vector3(0,0,-6.5)
    e=.2
    o=.5
    r=true
  else
    a=Vector3(0,0,-9)
    e=.75
    t=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{9,165},{9,-165}},offsetTarget=Vector3(0,-.85,3.25),offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=n,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=r,useLastSelectedIndex=t}
  return o
end
function this.PlayMissionClearCameraOnWalkerGear(a,s,p)
  local t=Vector3(0,.55,.35)
  local n=Vector3(0,0,-3.65)
  local a=.2
  local r
  local l=false
  local o=20
  local i=false
  if p then
    o=4
  end
  if s==1 then
    t=Vector3(0,.55,.35)
    n=Vector3(0,0,-3.65)
    a=.2
    r=1
    l=true
  else
    t=Vector3(0,.4,.35)
    n=Vector3(0,0,-4.95)a=3
    i=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{7,165},{7,-165}},offsetTarget=t,offsetPos=n,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=a,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=l,useLastSelectedIndex=i}
  return r
end
this.VEHICLE_MISSION_CLEAR_CAMERA={[Vehicle.type.EASTERN_LIGHT_VEHICLE]=this.PlayMissionClearCameraOnRideLightVehicle,[Vehicle.type.EASTERN_TRACKED_TANK]=this.PlayMissionClearCameraOnRideTank,[Vehicle.type.EASTERN_TRUCK]=this.PlayMissionClearCameraOnRideTruck,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=this.PlayMissionClearCameraOnRideEasternArmoredVehicle,[Vehicle.type.WESTERN_LIGHT_VEHICLE]=this.PlayMissionClearCameraOnRideLightVehicle,[Vehicle.type.WESTERN_TRACKED_TANK]=this.PlayMissionClearCameraOnRideTank,[Vehicle.type.WESTERN_TRUCK]=this.PlayMissionClearCameraOnRideTruck,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=this.PlayMissionClearCameraOnRideWesternArmoredVehicle}
function this.PlayMissionAbortCamera()
  local e=this.SetPlayerStatusForMissionEndCamera()
  if not e then
    return
  end
  TimerStart("Timer_StartPlayMissionAbortCamera",.25)
end
function this._PlayMissionAbortCamera()
  TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_common_jingle_failed")
  this.PlayCommonMissionEndCamera(this.PlayMissionAbortCameraOnRideHorse,this.VEHICLE_MISSION_ABORT_CAMERA,this.PlayMissionAbortCameraOnWalkerGear,this.PlayMissionAbortCameraOnFoot)
end
function this.PlayMissionAbortCameraOnFoot()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{6,10},{6,-10}},skeletonNames={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"},skeletonCenterOffsets={Vector3(0,.2,0),Vector3(-.15,0,0),Vector3(-.15,0,0)},skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)},offsetPos=Vector3(0,0,-3),focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function this.PlayMissionAbortCameraOnRideHorse(e)
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{6,20},{6,-20}},skeletonNames={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"},skeletonCenterOffsets={Vector3(0,.2,0),Vector3(-.15,0,0),Vector3(-.15,0,0)},skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)},offsetPos=Vector3(0,0,-3),focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function this.PlayMissionAbortCameraOnRideLightVehicle(e)
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{10,30},{10,-30}},offsetTarget=Vector3(-.35,.3,0),offsetPos=Vector3(0,0,-4),focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function this.PlayMissionAbortCameraOnRideTruck(e)
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{8,75},{8,-55}},offsetTarget=Vector3(-.35,1,1),offsetPos=Vector3(0,0,-5),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function this.PlayMissionAbortCameraOnRideCommonArmoredVehicle(e,a)
  local e=Vector3(.05,-.5,-2.2)
  if a==1 then
    e=Vector3(.05,-.5,-2.2)
  else
    e=Vector3(-.65,-1,0)
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{8,30},{8,-30}},offsetTarget=e,offsetPos=Vector3(0,0,-9),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function this.PlayMissionAbortCameraOnRideEasternArmoredVehicle(a)
  this.PlayMissionAbortCameraOnRideCommonArmoredVehicle(a,1)
end
function this.PlayMissionAbortCameraOnRideWesternArmoredVehicle(a)
  this.PlayMissionAbortCameraOnRideCommonArmoredVehicle(a,2)
end
function this.PlayMissionAbortCameraOnRideTank(e)
  local e=Vector3(0,-.5,0)
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{8,25},{8,-25}},offsetTarget=e,offsetPos=Vector3(0,0,-10),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function this.PlayMissionAbortCameraOnWalkerGear(a)
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{7,15},{7,-15}},offsetTarget=Vector3(0,.8,0),offsetPos=Vector3(0,.5,-3.5),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
this.VEHICLE_MISSION_ABORT_CAMERA={[Vehicle.type.EASTERN_LIGHT_VEHICLE]=this.PlayMissionAbortCameraOnRideLightVehicle,[Vehicle.type.EASTERN_TRACKED_TANK]=this.PlayMissionAbortCameraOnRideTank,[Vehicle.type.EASTERN_TRUCK]=this.PlayMissionAbortCameraOnRideTruck,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=this.PlayMissionAbortCameraOnRideEasternArmoredVehicle,[Vehicle.type.WESTERN_LIGHT_VEHICLE]=this.PlayMissionAbortCameraOnRideLightVehicle,[Vehicle.type.WESTERN_TRACKED_TANK]=this.PlayMissionAbortCameraOnRideTank,[Vehicle.type.WESTERN_TRUCK]=this.PlayMissionAbortCameraOnRideTruck,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=this.PlayMissionAbortCameraOnRideWesternArmoredVehicle}
function this.PlayFallDeadCamera(a)
  mvars.ply_fallDeadCameraTimeToSleep=20
  if a and Tpp.IsTypeNumber(a.timeToSleep)then
    mvars.ply_fallDeadCameraTimeToSleep=a.timeToSleep
  end
  mvars.ply_fallDeadCameraTargetPlayerIndex=PlayerInfo.GetLocalPlayerIndex()HighSpeedCamera.RequestEvent{continueTime=.03,worldTimeRate=.1,localPlayerTimeRate=.1}
  this.PlayCommonMissionEndCamera(this.PlayFallDeadCameraOnRideHorse,this.VEHICLE_FALL_DEAD_CAMERA,this.PlayFallDeadCameraOnWalkerGear,this.PlayFallDeadCameraOnFoot)
end
function this.SetLimitFallDeadCameraOffsetPosY(e)
  mvars.ply_fallDeadCameraPosYLimit=e
end
function this.ResetLimitFallDeadCameraOffsetPosY()
  mvars.ply_fallDeadCameraPosYLimit=nil
end
function this.GetFallDeadCameraOffsetPosY()
  local a=vars.playerPosY
  local e=.5
  if mvars.ply_fallDeadCameraPosYLimit then
    local t=a+e
    if t<mvars.ply_fallDeadCameraPosYLimit then
      e=mvars.ply_fallDeadCameraPosYLimit-a
    end
  end
  return e
end
function this.PlayFallDeadCameraOnFoot()
  local e=this.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-2.5,(e+1),-2.5),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideHorse(a)
  local e=this.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-2.5,(e+1),-2.5),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideLightVehicle(a)
  local e=this.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideTruck(a)
  local e=this.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideArmoredVehicle(a)
  local e=this.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideTank(a)
  local e=this.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnWalkerGear(a)
  local a=this.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(a+1),-8),focalLength=21,aperture=1.875,timeToSleep=mvars.ply_fallDeadCameraTimeToSleep,interpTimeAtStart=0,fitOnCamera=false}
end
this.VEHICLE_FALL_DEAD_CAMERA={[Vehicle.type.EASTERN_LIGHT_VEHICLE]=this.PlayFallDeadCameraOnRideLightVehicle,[Vehicle.type.EASTERN_TRACKED_TANK]=this.PlayFallDeadCameraOnRideTank,[Vehicle.type.EASTERN_TRUCK]=this.PlayFallDeadCameraOnRideTruck,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=this.PlayFallDeadCameraOnRideArmoredVehicle,[Vehicle.type.WESTERN_LIGHT_VEHICLE]=this.PlayFallDeadCameraOnRideLightVehicle,[Vehicle.type.WESTERN_TRACKED_TANK]=this.PlayFallDeadCameraOnRideTank,[Vehicle.type.WESTERN_TRUCK]=this.PlayFallDeadCameraOnRideTruck,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=this.PlayFallDeadCameraOnRideArmoredVehicle}
if DebugMenu then
  local tryEquipTypes={OneHandSwing=true,TwoHandSwing=true}
  local countForType={OneHandSwing=1,TwoHandSwing=1,TwoHandHeavy=1,Thrust=1,Bow=1,Arrow=100,Gun=1,Item=4}
  local prodInfo={id="PRD_*",tryEquip=true}
  function this.DEBUG_ProductAndEquipWithTable(products)
    local tryEquipTypeToggle=false
    for productType,id in pairs(products)do
      prodInfo.id=id
      prodInfo.count=countForType[productType]or 1
      if productType=="Item"then
        prodInfo.toInventory=true
      else
        prodInfo.toInventory=nil
      end
      if tryEquipTypes[productType]then
        if tryEquipTypeToggle then
          prodInfo.tryEquip=nil
          prodInfo.tryEquip2=true
        else
          prodInfo.tryEquip=true
          prodInfo.tryEquip2=nil
        end
        tryEquipTypeToggle=not tryEquipTypeToggle
      else
        prodInfo.tryEquip=true
        prodInfo.tryEquip2=nil
      end
      SsdSbm.AddProduction(prodInfo)
    end
  end
  function this.DEBUG_GetSkills(skills)
    for a,skillLevel in pairs(skills)do
      if Tpp.IsTypeTable(skillLevel)then
        SsdSbm.SetSkillLevel(skillLevel)
      end
    end
  end
  local resInfo={id="RES_*",count=1}
  function this.DEBUG_GetResource(resources)
    for id,count in pairs(resources)do
      resInfo.id=id
      resInfo.count=count
      SsdSbm.AddResource(resInfo)
    end
  end
end
function this.Messages()
  local messageTable=Tpp.StrCode32Table{
    GameObject={
      {msg="RevivePlayer",func=function()
        if TppMission.IsMultiPlayMission(vars.missionCode)then
          this.Revive()
        else
          local exceptGameStatus={S_DISABLE_THROWING=false,S_DISABLE_PLACEMENT=false}
          TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"StartRevivePlayer",TppUI.FADE_PRIORITY.SYSTEM,{exceptGameStatus=exceptGameStatus})
        end
      end}},
    Player={
      {msg="CalcFultonPercent",func=function(a,n,t,r,o)
        this.MakeFultonRecoverSucceedRatio(a,n,t,r,o,false)
      end},
      {msg="CalcDogFultonPercent",func=function(o,r,t,n,a)
        this.MakeFultonRecoverSucceedRatio(o,r,t,n,a,true)
      end},
      {msg="PlayerFulton",func=this.OnPlayerFulton},
      {msg="OnPickUpCollection",func=this.OnPickUpCollection},
      {msg="OnPickUpPlaced",func=this.OnPickUpPlaced},
      {msg="WarpEnd",func=this.OnEndWarp,option={isExecFastTravel=true}},
      {msg="EndCarryAction",func=function()
        if mvars.ply_requestedMissionClearCameraCarryOff then
          if PlayerInfo.AndCheckStatus{PlayerStatus.STAND}then
            this.RequestMissionClearMotion()
          end
        end
      end,option={isExecMissionClear=true}},
      {msg="IntelIconInDisplay",func=this.OnIntelIconDisplayContinue},
      {msg="QuestIconInDisplay",func=this.OnQuestIconDisplayContinue},
      {msg="PlayerShowerEnd",func=function()
        TppUI.ShowAnnounceLog"refresh"end}},
    UI={
      {msg="BedMenuSleepSelected",func=this.OnSelectSleepInBed},
      {msg="FastTravelMenuPointSelected",func=this.OnSelectFastTravelByMenu},
      {msg="EndFadeOut",sender="OnSelectFastTravel",func=this.WarpByFastTravel,option={isExecFastTravel=true}},
      {msg="EndFadeIn",sender="OnEndWarpByFastTravel",func=this.OnEndFadeInWarpByFastTravel,option={isExecFastTravel=true}},
      {msg="EndFadeOut",sender="OnSelectSleepInBed",func=this.PassTimeBySleeping},
      {msg="EndFadeIn",sender="OnEndSleepInBed",func=this.OnEndFadeInSleepInBed},
      {msg="EndFadeOut",sender="EndFadeOut_StartTargetDeadCamera",func=this._SetTargetDeadCamera,option={isExecGameOver=true}},
      {msg="EndFadeOut",sender="EndFadeOut_StartDefenseTargetBrokenCamera",func=this._SetDefenseTargetBrokenCamera,option={isExecGameOver=true}},
      {msg="EndFadeOut",sender="StartRevivePlayer",func=function()
        this.Revive()
      end}},
    Timer={
      {msg="Finish",sender="Timer_StartPlayMissionClearCameraStep1",func=function()
        this._PlayMissionClearCamera(1)
      end,option={isExecMissionClear=true}},
      {msg="Finish",sender="Timer_StartPlayMissionAbortCamera",func=this._PlayMissionAbortCamera,option={isExecGameOver=true}},
      {msg="Finish",sender="Timer_DeliveryWarpSoundCannotCancel",func=this.OnDeliveryWarpSoundCannotCancel,option={isExecFastTravel=true}},
      {msg="Finish",sender="Timer_StartGameOverCamera",func=this._StartGameOverCamera,option={isExecGameOver=true}},
      {msg="Finish",sender="Timer_SleepInBed",func=function()
        TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMAL,"OnEndSleepInBed",TppUI.FADE_PRIORITY.MISSION)
      end}},
    Trap={
      {msg="Enter",sender="fallDeath_camera",func=function()
        this.SetLimitFallDeadCameraOffsetPosY(-18)
      end,option={isExecMissionPrepare=true}},
      {msg="Exit",sender="fallDeath_camera",func=this.ResetLimitFallDeadCameraOffsetPosY,option={isExecMissionPrepare=true}}
    }
  }
  if IsTypeTable(mvars.ply_intelMarkerTrapList)and next(mvars.ply_intelMarkerTrapList)then
    messageTable[StrCode32"Trap"]=messageTable[StrCode32"Trap"]or{}
    table.insert(messageTable[StrCode32"Trap"],Tpp.StrCode32Table{msg="Enter",sender=mvars.ply_intelMarkerTrapList,func=this.OnEnterIntelMarkerTrap,option={isExecMissionPrepare=true}})
  end
  if IsTypeTable(mvars.ply_intelTrapList)and next(mvars.ply_intelTrapList)then
    messageTable[StrCode32"Trap"]=messageTable[StrCode32"Trap"]or{}
    table.insert(messageTable[StrCode32"Trap"],Tpp.StrCode32Table{msg="Enter",sender=mvars.ply_intelTrapList,func=this.OnEnterIntelTrap})
    table.insert(messageTable[StrCode32"Trap"],Tpp.StrCode32Table{msg="Exit",sender=mvars.ply_intelTrapList,func=this.OnExitIntelTrap})
  end
  return messageTable
end
function this.DeclareSVars()
  return{{name="ply_pickableLocatorDisabled",arraySize=mvars.ply_maxPickableLocatorCount,type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="ply_placedLocatorDisabled",arraySize=mvars.ply_maxPlacedLocatorCount,type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="ply_isUsedPlayerInitialAction",type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function this.OnAllocate(missionTable)
  if(missionTable and missionTable.sequence)and missionTable.sequence.EQUIP_MISSION_BLOCK_GROUP_SIZE then
    mvars.ply_equipMissionBlockGroupSize=missionTable.sequence.EQUIP_MISSION_BLOCK_GROUP_SIZE
  else
    mvars.ply_equipMissionBlockGroupSize=TppDefine.DEFAULT_EQUIP_MISSION_BLOCK_GROUP_SIZE
  end
  if(missionTable and missionTable.sequence)and missionTable.sequence.MAX_PICKABLE_LOCATOR_COUNT then
    mvars.ply_maxPickableLocatorCount=missionTable.sequence.MAX_PICKABLE_LOCATOR_COUNT
  else
    mvars.ply_maxPickableLocatorCount=TppDefine.PICKABLE_MAX
  end
  if(missionTable and missionTable.sequence)and missionTable.sequence.MAX_PLACED_LOCATOR_COUNT then
    mvars.ply_maxPlacedLocatorCount=missionTable.sequence.MAX_PLACED_LOCATOR_COUNT
  else
    mvars.ply_maxPlacedLocatorCount=TppDefine.PLACED_MAX
  end
  Mission.SetRevivalDisabled(false)
end
function this.SetInitialPlayerState(missionTable)
  local helicopterRouteList
  if(missionTable.sequence and missionTable.sequence.missionStartPosition)and missionTable.sequence.missionStartPosition.helicopterRouteList then
    if not Tpp.IsTypeFunc(missionTable.sequence.missionStartPosition.IsUseRoute)or missionTable.sequence.missionStartPosition.IsUseRoute()then
      helicopterRouteList=missionTable.sequence.missionStartPosition.helicopterRouteList
    end
  end
  if helicopterRouteList==nil then
    if gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER then
    end
    this.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
  end
end
function this.MissionStartPlayerTypeSetting()
  if not mvars.ply_isExistTempPlayerType then
    this.RestoreTemporaryPlayerType()
  end
  if mvars.ply_isExistTempPlayerType then
    this.SaveCurrentPlayerType()
    this.ApplyTemporaryPlayerType()
  end
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  if gvars.ini_isTitleMode then
    vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_HIP]=1
    vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_BACK]=1
    vars.isInitialWeapon[TppDefine.WEAPONSLOT.SECONDARY]=1
  end
  if missionTable.sequence and missionTable.sequence.ALLWAYS_100_PERCENT_FULTON then
    mvars.ply_allways_100percent_fulton=true
  end
  if TppMission.IsMissionStart()then
    local initialHandEquip
    if missionTable.sequence and missionTable.sequence.INITIAL_HAND_EQUIP then
      initialHandEquip=missionTable.sequence.INITIAL_HAND_EQUIP
    end
    if initialHandEquip then
    end
    local initialCameraRotation
    if missionTable.sequence and missionTable.sequence.INITIAL_CAMERA_ROTATION then
      initialCameraRotation=missionTable.sequence.INITIAL_CAMERA_ROTATION
    end
    if initialCameraRotation then
      vars.playerCameraRotation[0]=initialCameraRotation[1]
      vars.playerCameraRotation[1]=initialCameraRotation[2]
      mvars.ply_setInitialCameraRotation=true
    end
  end
  if missionTable.sequence and missionTable.sequence.INITIAL_INFINIT_OXYGEN then
    ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteOxygen",value=missionTable.sequence.INITIAL_INFINIT_OXYGEN}
  else
    ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteOxygen",value=false}
  end
  if missionTable.sequence and missionTable.sequence.INITIAL_IGNORE_HUNGER then
    ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreHunger",value=missionTable.sequence.INITIAL_IGNORE_HUNGER}
  else
    ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreHunger",value=false}
  end
  if missionTable.sequence and missionTable.sequence.INITIAL_IGNORE_THIRST then
    ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreThirst",value=missionTable.sequence.INITIAL_IGNORE_THIRST}
  else
    ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreThirst",value=false}
  end
  if missionTable.sequence and missionTable.sequence.INITIAL_IGNORE_FATIGUE then
    ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreFatigue",value=missionTable.sequence.INITIAL_IGNORE_THIRST}
  else
    ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="ignoreFatigue",value=false}
  end
  if missionTable.sequence and missionTable.sequence.INITIAL_INFINITE_STAMINA then
    ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteStamina",value=missionTable.sequence.INITIAL_INFINITE_STAMINA}
  else
    ScriptParam.SetValue{category=ScriptParamCategory.PLAYER,paramName="infiniteStamina",value=false}
  end
  Player.SetUseBlackDiamondEmblem(false)
  local currentItemIndex=0
  if TppMission.IsMissionStart()then
    vars.currentItemIndex=currentItemIndex
  end
  if(gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)and(svars.ply_isUsedPlayerInitialAction==false)then
    local heliId=GetGameObjectId("TppHeli2","SupportHeli")
    if heliId~=NULL_ID then
      vars.initialPlayerAction=PlayerInitialAction.FROM_HELI_SPACE
      vars.initialPlayerPairGameObjectId=heliId
    end
  else
    if TppMission.IsMissionStart()then
      local initialPlayerAction
      if missionTable.sequence and missionTable.sequence.MISSION_START_INITIAL_ACTION then
        initialPlayerAction=missionTable.sequence.MISSION_START_INITIAL_ACTION
      end
      if initialPlayerAction then
        vars.initialPlayerAction=initialPlayerAction
      end
    end
  end
  mvars.ply_locationStationTable={}
  mvars.ply_stationLocatorList={}
end
function this.OnReload()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMissionCanStart()
  if not Player.IsInstanceValid()then
    return
  end
  if mvars.ply_setInitialCameraRotation then
    return
  end
  Player.RequestToSetCameraRotation{rotX=10,rotY=vars.playerRotY,interpTime=0}
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.Update()
  this.UpdateFastTravelWarp()
end
local c={[TppDefine.WEATHER.SUNNY]=0,[TppDefine.WEATHER.CLOUDY]=-10,[TppDefine.WEATHER.RAINY]=-30,[TppDefine.WEATHER.FOGGY]=-50,[TppDefine.WEATHER.SANDSTORM]=-70}
function this.MakeFultonRecoverSucceedRatio(t,a,i,l,o,r)
  local p={[TppMotherBaseManagementConst.SECTION_FUNC_RANK_S]=60,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_A]=50,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_B]=40,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_C]=30,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_D]=20,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_E]=10,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_F]=0,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_NONE]=0}
  local t=a
  local a=0
  local s=100
  local n=0
  n=TppTerminal.DoFuncByFultonTypeSwitch(t,i,l,o,nil,nil,nil,this.GetSoldierFultonSucceedRatio,this.GetVolginFultonSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio,this.GetDefaultSucceedRatio)
  if n==nil then
    n=100
  end
  local e=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_FULTON}
  local o=p[e]or 0
  local e=c[vars.weather]or 0
  e=e+o
  if e>0 then
    e=0
  end
  a=(s+n)+e
  if mvars.ply_allways_100percent_fulton then
    a=100
  end
  if TppEnemy.IsRescueTarget(t)then
    a=100
  end
  local e
  if mvars.ply_forceFultonPercent then
    e=mvars.ply_forceFultonPercent[t]
  end
  if e then
    a=e
  end
  if r then
    Player.SetDogFultonIconPercentage{percentage=a,targetId=t}
  else
    Player.SetFultonIconPercentage{percentage=a,targetId=t}
  end
end
function this.GetSoldierFultonSucceedRatio(t)
  local e=0
  local n=0
  local a=SendCommand(t,{id="GetLifeStatus"})
  local r=GameObject.SendCommand(t,{id="GetStateFlag"})
  if(bit.band(r,StateFlag.DYING_LIFE)~=0)then
    e=-70
  elseif(a==TppGameObject.NPC_LIFE_STATE_SLEEP)or(a==TppGameObject.NPC_LIFE_STATE_FAINT)then
    e=0
    if mvars.ply_OnFultonIconDying then
      mvars.ply_OnFultonIconDying()
    end
  elseif(a==TppGameObject.NPC_LIFE_STATE_DEAD)then
    return
  end
  local r={[TppMotherBaseManagementConst.SECTION_FUNC_RANK_S]=60,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_A]=50,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_B]=40,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_C]=30,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_D]=20,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_E]=10,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_F]=0,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_NONE]=0}
  local a=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_MEDICAL_STAFF_EMERGENCY}
  local a=r[a]or 0
  e=e+a
  if e>0 then
    e=0
  end
  local a=SendCommand(t,{id="GetStatus"})
  if a==TppGameObject.NPC_STATE_STAND_HOLDUP then
    n=-10
  end
  return(e+n)
end
function this.GetDefaultSucceedRatio(e)
  return 0
end
function this.GetVolginFultonSucceedRatio(e)
  return 100
end
function this.OnPlayerFulton(e,e)
end
function this.SetRetryFlag()
  vars.playerRetryFlag=PlayerRetryFlag.RETRY
end
function this.SetRetryFlagWithChickCap()
  vars.playerRetryFlag=PlayerRetryFlag.RETRY_WITH_CHICK_CAP
end
function this.UnsetRetryFlag()
  vars.playerRetryFlag=0
end
function this.ResetStealthAssistCount()
  vars.stealthAssistLeftCount=0
end
function this.OnPickUpCollection(t,a,e,n)
  local t=255
  TppCollection.RepopCountOperation("SetAt",a,t)
  TppTerminal.AddPickedUpResourceToTempBuffer(e,n)
  local t={[TppCollection.TYPE_POSTER_SOL_AFGN]="key_poster_3500",[TppCollection.TYPE_POSTER_SOL_MAFR]="key_poster_3501",[TppCollection.TYPE_POSTER_GRAVURE_V]="key_poster_3502",[TppCollection.TYPE_POSTER_GRAVURE_H]="key_poster_3503",[TppCollection.TYPE_POSTER_MOE_V]="key_poster_3504",[TppCollection.TYPE_POSTER_MOE_H]="key_poster_3505"}
  local t=t[e]
  if t~=nil then
    TppUI.ShowAnnounceLog("getPoster",t,TppTerminal.GMP_POSTER)
  end
  local t
  if TppTerminal.RESOURCE_INFORMATION_TABLE[e]and TppTerminal.RESOURCE_INFORMATION_TABLE[e].count then
    t=TppTerminal.RESOURCE_INFORMATION_TABLE[e].count
  end
  if TppCollection.IsHerbByType(e)then
    local e=GameObject.GetGameObjectIdByIndex("TppBuddyDog2",0)
    if e~=NULL_ID then
      SendCommand(e,{id="GetPlant",uniqueId=a})
    end
  end
  if TppCollection.IsMaterialByType(e)then
    TppUI.ShowAnnounceLog("find_processed_res",n,t)
  end
  if e==TppCollection.TYPE_DIAMOND_SMALL then
    TppUI.ShowAnnounceLog("find_diamond",TppDefine.SMALL_DIAMOND_GMP)
  end
  if e==TppCollection.TYPE_DIAMOND_LARGE then
    TppUI.ShowAnnounceLog("find_diamond",TppDefine.LARGE_DIAMOND_GMP)
  end
  TppTerminal.PickUpBluePrint(a)
end
function this.OnPickUpPlaced(e,e,a)
  local e=GameObject.GetGameObjectIdByIndex("TppBuddyDog2",0)
  if e~=NULL_ID then
    SendCommand(e,{id="GetPlacedItem",index=a})
  end
end
function this.StorePlayerDecoyInfos()
  if this.IsExistDecoySystem()then
    local e={type="TppDecoySystem"}SendCommand(e,{id="StorePlayerDecoyInfos"})
  end
end
function this.IsExistDecoySystem()
  if GameObject.GetGameObjectIdByIndex("TppDecoySystem",0)~=NULL_ID then
    return true
  else
    return false
  end
end
local r=7.5
local a=3.5
this.DELIVERY_WARP_STATE=Tpp.Enum{"START_FADE_OUT","START_WARP","END_WARP","START_FADE_IN"}
function this.OnSelectFastTravelByMenu(a,t)
  if mvars.ply_unexecFastTravelByMenu then
    return
  end
  this.OnSelectFastTravel(a,t)
end
function this.OnSelectFastTravel(t,a)
  if mvars.ply_requestedRevivePlayer then
    return
  end
  mvars.ply_deliveryWarpState=this.DELIVERY_WARP_STATE.START_FADE_OUT
  local e,a=SsdFastTravel.GetFastTravelPointName(a)
  if not e then
    return
  end
  if not a then
    return
  end
  Player.SetPadMask{settingName="FastTravel",except=true}
  local n=mvars.ply_fastTravelOption
  local t=false
  if n then
    t=n.noSound
  end
  local e,n=Tpp.GetLocatorByTransform(e,a)
  if e then
    e=e+Vector3(0,.8,0)
  end
  mvars.ply_selectedFastTravelPointName=a
  mvars.ply_selectedFastTravelPosition=e
  mvars.ply_selectedFastTravelRotY=Tpp.GetRotationY(n)
  if not t then
    mvars.ply_playingDeliveryWarpSoundHandle=TppSoundDaemon.PostEventAndGetHandle("Play_truck_transfer","Loading")
  else
    mvars.ply_playingDeliveryWarpSoundHandle=nil
  end
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"OnSelectFastTravel",TppUI.FADE_PRIORITY.MISSION,{setMute=true})
  TppGameStatus.Set("TppPlayer.lua","S_IS_FAST_TRAVEL")
  TppGameStatus.Set("TppPlayer.lua","S_DISABLE_TARGET")
end
function this.WarpByFastTravel()
  if mvars.ply_deliveryWarpState==this.DELIVERY_WARP_STATE.START_WARP then
    return
  end
  TppGameStatus.Set("TppPlayer.WarpByFastTravel","S_IS_BLACK_LOADING")
  local a=mvars.ply_fastTravelOption
  local t=false
  if a then
    if a.surviveBox then
      SsdSbm.CreateSurviveCbox()
    end
    if a.resetState then
      t=a.resetState
    end
  end
  TppRadio.Stop()
  mvars.ply_deliveryWarpState=this.DELIVERY_WARP_STATE.START_WARP
  TimerStart("Timer_DeliveryWarpSoundCannotCancel",r)
  local e={type="TppPlayer2",index=0}
  local a={id="WarpAndWaitBlock",pos=mvars.ply_selectedFastTravelPosition,rotY=TppMath.DegreeToRadian(mvars.ply_selectedFastTravelRotY),resetState=t}
  GameObject.SendCommand(e,a)
end
function this.OnEndWarpByFastTravel()
  TppGameStatus.Reset("TppPlayer.lua","S_DISABLE_TARGET")
  TppGameStatus.Reset("TppPlayer.lua","S_IS_FAST_TRAVEL")
  TppGameStatus.Reset("TppPlayer.WarpByFastTravel","S_IS_BLACK_LOADING")
  if mvars.ply_deliveryWarpState==this.DELIVERY_WARP_STATE.START_WARP then
    mvars.ply_deliveryWarpState=this.DELIVERY_WARP_STATE.END_WARP
  end
end
function this.UpdateFastTravelWarp()
  if not mvars.ply_deliveryWarpState then
    return
  end
  if(mvars.ply_deliveryWarpState==this.DELIVERY_WARP_STATE.START_WARP)then
    TppUI.ShowAccessIconContinue()
  end
  if(mvars.ply_deliveryWarpState~=this.DELIVERY_WARP_STATE.END_WARP)then
    return
  end
  if not TppMission.CheckMissionState(false,false,false,false,true)then
    TppSoundDaemon.PostEventAndGetHandle("Stop_truck_transfer","Loading")
    this.OnEndFadeInWarpByFastTravel()
    return
  end
  if mvars.ply_playingDeliveryWarpSoundHandle then
    local e=TppSoundDaemon.IsEventPlaying("Play_truck_transfer",mvars.ply_playingDeliveryWarpSoundHandle)
    if(e==false)then
      mvars.ply_playingDeliveryWarpSoundHandle=nil
      return
    else
      TppUI.ShowAccessIconContinue()
    end
  end
  if(mvars.ply_playingDeliveryWarpSoundHandle and(not mvars.ply_deliveryWarpSoundCannotCancel))and(bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.STANCE)==PlayerPad.STANCE)then
    mvars.ply_deliveryWarpSoundCannotCancel=true
    TppSoundDaemon.ResetMute"Loading"TppSoundDaemon.PostEventAndGetHandle("Stop_truck_transfer","Loading")
  end
  if TppSave.IsSaving()then
    return
  end
  if not mvars.ply_playingDeliveryWarpSoundHandle then
    mvars.ply_deliveryWarpState=this.DELIVERY_WARP_STATE.START_FADE_IN
    TppSoundDaemon.ResetMute"Loading"TppMission.ExecuteSystemCallback("OnEndDeliveryWarp",mvars.ply_selectedFastTravelPointName)
    Player.RequestToSetCameraRotation{rotX=10,rotY=mvars.ply_selectedFastTravelRotY}
    local a=mvars.ply_fastTravelOption
    if a and a.noFadeIn then
      this.OnEndFadeInWarpByFastTravel()
    else
      TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMAL,"OnEndWarpByFastTravel",TppUI.FADE_PRIORITY.DEMO)
    end
  end
end
function this.OnEndFadeInWarpByFastTravel()
  mvars.ply_selectedFastTravelPointName=nil
  mvars.ply_selectedFastTravelPosition=nil
  mvars.ply_selectedFastTravelRotY=nil
  mvars.ply_deliveryWarpState=nil
  mvars.ply_deliveryWarpSoundCannotCancel=nil
  mvars.ply_fastTravelOption=nil
  if mvars.ply_endFastTravelCallback then
    mvars.ply_endFastTravelCallback()
  end
  mvars.ply_endFastTravelCallback=nil
  TimerStop"Timer_DeliveryWarpSoundCannotCancel"Player.ResetPadMask{settingName="FastTravel"}
end
function this.OnDeliveryWarpSoundCannotCancel()
  mvars.ply_deliveryWarpSoundCannotCancel=true
end
function this.StartFastTravel(o,r,t,a)
  mvars.ply_endFastTravelCallback=nil
  mvars.ply_fastTravelOption=nil
  if IsTypeFunc(t)then
    mvars.ply_endFastTravelCallback=t
  end
  if IsTypeTable(a)then
    mvars.ply_fastTravelOption=a
  end
  this.OnSelectFastTravel(o,r)
end
function this.StartFastTravelByReturnBase()
  local a="fast_afgh_basecamp"if TppLocation.IsMiddleAfrica()then
    a="fast_mafr_basecamp"end
  this.StartFastTravel(nil,StrCode32(a),nil,{surviveBox=true,resetState=true,noSound=true})
end
function this.AddFastTravelOption(a)
  if not IsTypeTable(a)then
    return
  end
  if not this.IsFastTraveling()then
    return
  end
  mvars.ply_fastTravelOption=mvars.ply_fastTravelOption or{}
  for e,a in pairs(a)do
    mvars.ply_fastTravelOption[e]=a
  end
end
function this.OnEnterIntelMarkerTrap(e,a)
  local a=mvars.ply_intelMarkerTrapInfo[e]
  local e=mvars.ply_intelFlagInfo[a]
  if e then
    if svars[e]then
      return
    end
  else
    return
  end
  local e=mvars.ply_intelMarkerObjectiveName[a]
  if e then
    TppMission.UpdateObjective{objectives={e}}
  end
end
function this.OnEnterIntelTrap(a,t)
  local a=mvars.ply_intelTrapInfo[a]
  this.ShowIconForIntel(a)
end
function this.OnExitIntelTrap(a,a)
  this.HideIconForIntel()
end
function this.OnIntelIconDisplayContinue(a,t,t)
  local a=mvars.ply_intelNameReverse[a]
  this.ShowIconForIntel(a)
end
function this.OnEnterQuestTrap(a,t)
  local a=mvars.ply_questStartTrapInfo[a]
  this.ShowIconForQuest(a)
  local e=mvars.ply_questStartFlagInfo[a]
  if e~=nil and e==false then
    TppSoundDaemon.PostEvent"sfx_s_ifb_mbox_arrival"end
end
function this.OnExitQuestTrap(a,a)
  this.HideIconForQuest()
end
function this.OnQuestIconDisplayContinue(a,t,t)
  local a=mvars.ply_questNameReverse[a]
  this.ShowIconForQuest(a)
end
function this.SaveCaptureAnimal()
  if mvars.loc_locationAnimalSettingTable==nil then
    return
  end
  local a=TppPlaced.GetCaptureCageInfo()
  for t,a in pairs(a)do
    local a,e,t,t=this.EvaluateCaptureCage(a.x,a.z,a.grade,a.material)
    if e~=0 then
      CaptureCage.RegisterCaptureAnimal(e,a)
    end
  end
  TppPlaced.DeleteAllCaptureCage()
end
function this.AggregateCaptureAnimal()
  local e=0
  local a=0
  local t=CaptureCage.GetCaptureAnimalList()
  for t,n in pairs(t)do
    local t=n.animalId
    local n=n.areaName
    TppMotherBaseManagement.DirectAddDataBaseAnimal{dataBaseId=t,areaNameHash=n,isNew=true}
    local n,r=TppMotherBaseManagement.GetAnimalHeroicPointAndGmp{dataBaseId=t}e=e+n
    a=a+r
    TppUiCommand.ShowBonusPopupAnimal(t,"regist")
  end
  if e>0 or a>0 then
    TppMotherBaseManagement.AddHeroicPointAndGmpByCageAnimal{heroicPoint=e,gmp=a,isAnnounce=true}
  end
end
function this.CheckCaptureCage(t,r)
  if mvars.loc_locationAnimalSettingTable==nil then
    return
  end
  if t<2 or t>4 then
    return
  end
  local n={}
  local a=5
  local o=r/a
  for r=1,o do
    if t==2 then
      Player.DEBUG_PlaceAround{radius=5,count=a,equipId=TppEquip.EQP_SWP_CaptureCage}
    elseif t==3 then
      Player.DEBUG_PlaceAround{radius=5,count=a,equipId=TppEquip.EQP_SWP_CaptureCage_G01}
    elseif t==4 then
      Player.DEBUG_PlaceAround{radius=5,count=a,equipId=TppEquip.EQP_SWP_CaptureCage_G02}
    end
    for e=1,a do
      coroutine.yield()
    end
    local a=TppPlaced.GetCaptureCageInfo()
    for t,a in pairs(a)do
      local t,a,r,e=this.EvaluateCaptureCage(a.x,a.z,a.grade,a.material)
      if a~=0 then
        TppMotherBaseManagement.DirectAddDataBaseAnimal{dataBaseId=a,areaName=t,isNew=true}
        if n[e]==nil then
          n[e]=1
        else
          n[e]=n[e]+1
        end
      end
    end
    TppPlaced.DeleteAllCaptureCage()
  end
  for a,e in pairs(n)do
    local e=(e/r)*100
  end
end
function this.GetCaptureAnimalSE(t)
  local e="sfx_s_captured_nom"local a=mvars.loc_locationAnimalSettingTable
  if a==nil then
    return e
  end
  local a=a.animalRareLevel
  if a[t]==nil then
    return e
  end
  local a=a[t]
  if a==TppMotherBaseManagementConst.ANIMAL_RARE_SR then
    e="sfx_s_captured_super"elseif a==TppMotherBaseManagementConst.ANIMAL_RARE_R then
    e="sfx_s_captured_rare"else
    e="sfx_s_captured_nom"end
  return e
end
function this.OnSelectSleepInBed(e)
  Player.SetPadMask{settingName="SleepInBed",except=true}
  mvars.ply_sleepTimeHour=e
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"OnSelectSleepInBed",TppUI.FADE_PRIORITY.MISSION)
end
function this.PassTimeBySleeping()
  WeatherManager.AddTimeToCurrentClock{hour=mvars.ply_sleepTimeHour}Player.OnSleepInBedLocal(mvars.ply_sleepTimeHour)
  TimerStart("Timer_SleepInBed",2)
end
function this.OnEndFadeInSleepInBed()
  Player.ResetPadMask{settingName="SleepInBed"}
  mvars.ply_sleepTimeHour=nil
  TppQuest.UpdateActiveQuest()
  TppMission.UpdateCheckPointAtCurrentPosition()
end
function this._IsStartStatusValid(a)
  if(this.StartStatusList[a]==nil)then
    return false
  end
  return true
end
function this._IsAbilityNameValid(a)
  if(this.DisableAbilityList[a]==nil)then
    return false
  end
  return true
end
function this._IsControlModeValid(a)
  if(this.ControlModeList[a]==nil)then
    return false
  end
  return true
end
function this._CheckRotation(e,t,n,r,a)
  local a=mvars
  local a=vars.playerCameraRotation[0]
  local o=vars.playerCameraRotation[1]
  local e=foxmath.DegreeToRadian(a-e)
  e=foxmath.NormalizeRadian(e)
  local a=foxmath.RadianToDegree(e)
  local e=foxmath.DegreeToRadian(o-n)
  e=foxmath.NormalizeRadian(e)
  local e=foxmath.RadianToDegree(e)
  if(foxmath.Absf(a)<t)and(foxmath.Absf(e)<r)then
    return true
  else
    return false
  end
end
local function n(a)
  local n=math.random(0,99)
  local e=0
  local t=-1
  for r,a in pairs(a)do
    e=e+a[2]
    if n<e then
      t=a[1]break
    end
  end
  return t
end
local function p(e,a)
  for t,e in pairs(e)do
    if e==a then
      return true
    end
  end
  return false
end
function this.EvaluateCaptureCage(l,a,o,c)
  local t=mvars
  local r=t.loc_locationAnimalSettingTable
  local i=r.captureCageAnimalAreaSetting
  local t="wholeArea"for n,e in pairs(i)do
    if((l>=e.activeArea[1]and l<=e.activeArea[3])and a>=e.activeArea[2])and a<=e.activeArea[4]then
      t=e.areaName
      break
    end
  end
  local a=0
  if o==2 then
    a=n(this.CageRandomTableG3)
  elseif o==1 then
    a=n(this.CageRandomTableG2)
  else
    a=n(this.CageRandomTableG1)
  end
  local e=r.captureAnimalList
  local i=r.animalRareLevel
  local s=r.animalInfoList
  local n={}
  if e[t]==nil then
    t="wholeArea"
  end
  local l=false
  for t,e in pairs(e[t])do
    local t=i[e]
    if t>=TppMotherBaseManagementConst.ANIMAL_RARE_SR and o==2 then
      if not TppMotherBaseManagement.IsGotDataBase{dataBaseId=e}then
        table.insert(n,e)
        a=t
        l=true
        break
      end
    end
  end
  if not l then
    local r=a
    while a>=0 do
      for t,e in pairs(e[t])do
        if i[e]==a then
          table.insert(n,e)
        end
      end
      if table.maxn(n)>0 then
        break
      end
      a=a-1
    end
    if a<0 then
      a=r
      t="wholeArea"
      while a>=0 do
        for t,e in pairs(e[t])do
          if i[e]==a then
            table.insert(n,e)
          end
        end
        if table.maxn(n)>0 then
          break
        end
        a=a-1
      end
    end
  end
  local l=r.animalMaterial
  local r={}
  local o=a
  if l~=nil then
    while o>=0 do
      for a,e in pairs(e.wholeArea)do
        if l[e]==nil and i[e]==o then
          table.insert(r,e)
        end
      end
      if table.maxn(r)>0 then
        break
      end
      o=o-1
    end
  end
  local e=0
  local i=table.maxn(n)
  if i==1 then
    e=n[1]
  elseif i>1 then
    local a=math.random(1,i)
    e=n[a]
  end
  if#r==0 then
    local n=""
    return t,e,a,n
  end
  if l~=nil then
    local t=l[e]
    if t~=nil then
      if p(t,c)==false then
        local t=math.random(1,#r)e=r[t]a=o
      end
    end
  end
  local n=""
  if s~=nil then
    if e~=0 then
      n=s[e].name
    end
  end
  return t,e,a,n
end
function this.Refresh(resetDirty)
  if resetDirty then
    Player.ResetDirtyEffect()
  end
  vars.passageSecondsSinceOutMB=0
end
return this
