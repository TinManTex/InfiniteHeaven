local e={}
--local hh=SplashScreen.Create("hh","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5008_l_alp.ftex",1280,640)  
--SplashScreen.Show(hh,0,0.5,0)--tex octopus
local s=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local n=IsTable
local l=Tpp.IsTypeString
local a=Fox.StrCode32
local r=GkEventTimerManager.Start
local p=GkEventTimerManager.Stop
local t=GameObject.GetTypeIndex
local i=GameObject.GetGameObjectId
local m=GameObject.GetTypeIndexWithTypeName
local t=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2
local t=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2
local t=GameObject.NULL_ID
local o=GameObject.SendCommand
local this=e--tex CULL: once deminified
e.MISSION_CLEAR_CAMERA_FADE_DELAY_TIME=3
e.MISSION_CLEAR_CAMERA_DELAY_TIME=0
e.PLAYER_FALL_DEAD_DELAY_TIME=.2
e.DisableAbilityList={Stand="DIS_ACT_STAND",Squat="DIS_ACT_SQUAT",Crawl="DIS_ACT_CRAWL",Dash="DIS_ACT_DASH"}
e.ControlModeList={LockPadMode="All",LockMBTerminalOpenCloseMode="MB_Disable",MBTerminalOnlyMode="MB_OnlyMode"}
e.CageRandomTableG1={{1,20},{0,80}}
e.CageRandomTableG2={{2,15},{1,20},{0,65}}
e.CageRandomTableG3={{4,5},{3,10},{2,15},{1,20},{0,50}}
e.RareLevelList={"N","NR","R","SR","SSR"}
function this.RegisterCallbacks(e)
  if s(e.OnFultonIconDying)then
    mvars.ply_OnFultonIconDying=e.OnFultonIconDying
  end
end
function this.SetStartStatus(e)
  if(e>TppDefine.INITIAL_PLAYER_STATE.MIN)and(e<TppDefine.INITIAL_PLAYER_STATE.MAX)then
    gvars.ply_initialPlayerState=e
  end
end
function this.SetStartStatusRideOnHelicopter()
  e.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)
  e.ResetInitialPosition()
  e.ResetMissionStartPosition()
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
function this.Warp(e)
  if not n(e)then
    return
  end
  local a=e.pos
  if not n(a)or(#a~=3)then
    return
  end
  local n=foxmath.NormalizeRadian(foxmath.DegreeToRadian(e.rotY or 0))
  local t
  if e.fobRespawn==true then
    t={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}
  else
    t={type="TppPlayer2",index=0}
  end
  local e={id="WarpAndWaitBlock",pos=a,rotY=n}
  GameObject.SendCommand(t,e)
end
function this.SetForceFultonPercent(e,a)
  if not Tpp.IsTypeNumber(e)then
    return
  end
  if not Tpp.IsTypeNumber(a)then
    return
  end
  if(e<0)or(e>=t)then
    return
  end
  if(a<0)or(a>100)then
    return
  end
  mvars.ply_forceFultonPercent=mvars.ply_forceFultonPercent or{}
  mvars.ply_forceFultonPercent[e]=a
end
function this.ForceChangePlayerToSnake(e)
  vars.playerType=PlayerType.SNAKE
  if e then
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
  if not n(a)then
    return
  end
  local e=mvars
  e.ply_checkDirectionList={}
  e.ply_checkRotationResult={}
  local function n(a,t,e)
    if e>=-180 and e<180 then
      a[t]=e
    end
  end
  for t,a in pairs(a)do
    if s(a.func)then
      e.ply_checkDirectionList[t]={}
      e.ply_checkDirectionList[t].func=a.func
      local r=a.directionX or 0
      local i=a.directionY or 0
      local o=a.directionRangeX or 0
      local a=a.directionRangeY or 0
      n(e.ply_checkDirectionList[t],"directionX",r)
      n(e.ply_checkDirectionList[t],"directionY",i)
      n(e.ply_checkDirectionList[t],"directionRangeX",o)
      n(e.ply_checkDirectionList[t],"directionRangeY",a)
    else
      return
    end
  end
end
function this.CheckRotation()
  local a=mvars
  if a.ply_checkDirectionList==nil then
    return
  end
  for n,t in pairs(a.ply_checkDirectionList)do
    local e=e._CheckRotation(t.directionX,t.directionRangeX,t.directionY,t.directionRangeY,n)
    if e~=a.ply_checkRotationResult[n]then
      a.ply_checkRotationResult[n]=e
      a.ply_checkDirectionList[n].func(e)
    end
  end
end
function this.IsDeliveryWarping()
  if mvars.ply_deliveryWarpState then
    return true
  else
    return false
  end
end
function this.GetStationUniqueId(e)
  if not l(e)then
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
  e.SetInitialPositionFromMissionStartPosition()
end
function this.SetNoOrderBoxMissionStartPosition(e,a)
  gvars.ply_useMissionStartPosForNoOrderBox=true
  gvars.ply_missionStartPosForNoOrderBox[0]=e[1]
  gvars.ply_missionStartPosForNoOrderBox[1]=e[2]
  gvars.ply_missionStartPosForNoOrderBox[2]=e[3]
  gvars.ply_missionStartRotForNoOrderBox=a
end
function this.SetNoOrderBoxMissionStartPositionToCurrentPosition()
  gvars.ply_useMissionStartPosForNoOrderBox=true
  gvars.ply_missionStartPosForNoOrderBox[0]=vars.playerPosX
  gvars.ply_missionStartPosForNoOrderBox[1]=vars.playerPosY+.5
  gvars.ply_missionStartPosForNoOrderBox[2]=vars.playerPosZ
  gvars.ply_missionStartRotForNoOrderBox=vars.playerRotY
end
function this.SetMissionStartPosition(e,a)
  gvars.ply_useMissionStartPos=true
  gvars.ply_missionStartPos[0]=e[1]
  gvars.ply_missionStartPos[1]=e[2]
  gvars.ply_missionStartPos[2]=e[3]
  gvars.ply_missionStartRot=a
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
    e.ResetNoOrderBoxMissionStartPosition()
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
    local a=gvars.ply_missionStartPos[0]-vars.playerPosX
    local t=gvars.ply_missionStartPos[2]-vars.playerPosZ
    local a=(a*a)+(t*t)
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
function this.SetInitialPosition(e,a)
  vars.initialPlayerFlag=PlayerFlag.USE_VARS_FOR_INITIAL_POS
  vars.initialPlayerPosX=e[1]
  vars.initialPlayerPosY=e[2]
  vars.initialPlayerPosZ=e[3]
  vars.initialPlayerRotY=a
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
function this.RegisterTemporaryPlayerType(playerSettings)
  if not IsTable(playerSettings)then
    return
  end
  mvars.ply_isExistTempPlayerType=true
  local camoType=playerSettings.camoType
  local partsType=playerSettings.partsType
  local playerType=playerSettings.playerType
  local handEquip=playerSettings.handEquip
  local faceEquipId=playerSettings.faceEquipId
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
function this.SetWeapons(a)
  e._SetWeapons(a,"weapons")
end
function this.SetInitWeapons(a)
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
    e.SaveWeaponsToUsingTemp(a)
  end
  e._SetWeapons(a,"initWeapons")
end
function this._SetWeapons(l,c)
  if not n(l)then
    return
  end
  local t=TppDefine.WEAPONSLOT.SUPPORT_0-1
  local a,i,r,n,o
  for s,l in pairs(l)do
    a,t,i,r,n,o=e.GetWeaponSlotInfoFromWeaponSet(l,t)
    local e=TppEquip[i]
    if e==nil then
    else
      local l,p,s,i,d,m=TppEquip.GetAmmoInfo(e)
      if a then
        vars[c][a]=e
        local e,t
        if r then
          e=r*p
        elseif n then
          e=n
        else
          e=s
        end
        gvars.initAmmoStockIds[a]=l
        gvars.initAmmoStockCounts[a]=e
        gvars.initAmmoInWeapons[a]=p
        if(i~=TppEquip.BL_None)then
          if o then
            t=o
          else
            t=m
          end
          gvars.initAmmoStockIds[a+TppDefine.WEAPONSLOT.MAX]=i
          gvars.initAmmoStockCounts[a+TppDefine.WEAPONSLOT.MAX]=t
          gvars.initAmmoSubInWeapons[a]=d
        end
        if c=="initWeapons"then
          vars.isInitialWeapon[a]=1
        end
      elseif t>=TppDefine.WEAPONSLOT.SUPPORT_0 and t<=TppDefine.WEAPONSLOT.SUPPORT_7 then
        local a=t-TppDefine.WEAPONSLOT.SUPPORT_0
        vars.initSupportWeapons[a]=e
        gvars.initAmmoStockIds[t]=l
        local e
        if n then
          e=n
        else
          e=s
        end
        gvars.initAmmoStockCounts[t]=e
      end
    end
  end
end
function this.GetWeaponSlotInfoFromWeaponSet(e,r)
  local o,a,n,t,i
  if e.primaryHip then
    o=TppDefine.WEAPONSLOT.PRIMARY_HIP
    a=e.primaryHip
    n=e.magazine
    t=e.ammo
    i=e.underBarrelAmmo
  elseif e.primaryBack then
    o=TppDefine.WEAPONSLOT.PRIMARY_BACK
    a=e.primaryBack
    n=e.magazine
    t=e.ammo
  elseif e.secondary then
    o=TppDefine.WEAPONSLOT.SECONDARY
    a=e.secondary
    n=e.magazine
    t=e.ammo
  elseif e.support then
    r=r+1
    a=e.support
    t=e.ammo
  end
  return o,r,a,n,t,i
end
function this.SaveWeaponsToUsingTemp(o)
  if gvars.ply_isUsingTempWeapons then
    return
  end
  if not n(o)then
    return
  end
  for i=0,11 do
    gvars.ply_lastWeaponsUsingTemp[i]=TppEquip.EQP_None
  end
  local t
  local a=TppDefine.WEAPONSLOT.SUPPORT_0-1
  for o,n in pairs(o)do
    t,a=e.GetWeaponSlotInfoFromWeaponSet(n,a)
    if t then
      gvars.ply_lastWeaponsUsingTemp[t]=vars.initWeapons[t]
    elseif a>=TppDefine.WEAPONSLOT.SUPPORT_0 and a<=TppDefine.WEAPONSLOT.SUPPORT_7 then
      local e=a-TppDefine.WEAPONSLOT.SUPPORT_0
      gvars.ply_lastWeaponsUsingTemp[a]=vars.initSupportWeapons[e]
    end
  end
  gvars.ply_isUsingTempWeapons=true
end
function this.RestoreWeaponsFromUsingTemp()
  if not gvars.ply_isUsingTempWeapons then
    return
  end
  for a=0,11 do
    if gvars.ply_lastWeaponsUsingTemp[a]~=TppEquip.EQP_None then
      if a>=TppDefine.WEAPONSLOT.SUPPORT_0 and a<=TppDefine.WEAPONSLOT.SUPPORT_7 then
        local e=a-TppDefine.WEAPONSLOT.SUPPORT_0
        vars.initSupportWeapons[e]=gvars.ply_lastWeaponsUsingTemp[a]
      else
        vars.initWeapons[a]=gvars.ply_lastWeaponsUsingTemp[a]
      end
      local i,r,l,n,o,t=TppEquip.GetAmmoInfo(gvars.ply_lastWeaponsUsingTemp[a])
      e.SupplyAmmoByBulletId(i,l)
      gvars.initAmmoInWeapons[a]=r
      e.SupplyAmmoByBulletId(n,t)
      gvars.initAmmoSubInWeapons[a]=o
    end
  end
  for e=0,11 do
    gvars.ply_lastWeaponsUsingTemp[e]=TppEquip.EQP_None
  end
  gvars.ply_isUsingTempWeapons=false
  return true
end
function this.SetItems(a)
  if not n(a)then
    return
  end
  for t,a in ipairs(a)do
    if TppEquip[a]==nil then
      return
    end
  end
  e._SetItems(a,"items")
end
function this.SetInitItems(a)
  if not n(a)then
    return
  end
  for a,e in ipairs(a)do
    if TppEquip[e]==nil then
      return
    end
  end
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
    e.SaveItemsToUsingTemp(a)
  end
  e._SetItems(a,"initItems")
end
function this._SetItems(a,e)
  vars[e][0]=TppEquip.EQP_None
  for a,t in pairs(a)do
    vars[e][a]=TppEquip[t]
  end
end
function this.SaveItemsToUsingTemp(e)
  if gvars.ply_isUsingTempItems then
    return
  end
  for e=0,7 do
    gvars.ply_lastItemsUsingTemp[e]=TppEquip.EQP_None
  end
  for e,a in pairs(e)do
    if e<8 then
      gvars.ply_lastItemsUsingTemp[e]=vars.initItems[e]
    end
  end
  gvars.ply_isUsingTempItems=true
end
function this.RestoreItemsFromUsingTemp()
  if not gvars.ply_isUsingTempItems then
    return
  end
  for e=1,7 do
    if gvars.ply_lastItemsUsingTemp[e]~=TppEquip.EQP_None then
      vars.initItems[e]=gvars.ply_lastItemsUsingTemp[e]
    end
  end
  for e=0,7 do
    gvars.ply_lastItemsUsingTemp[e]=TppEquip.EQP_None
  end
  gvars.ply_isUsingTempItems=false
end
function this.InitItemStockCount()
  if TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT==nil then
    return
  end
  for e=AmmoStockIndex.ITEM,AmmoStockIndex.ITEM_END-1 do
    vars.ammoStockIds[e]=0
    vars.ammoStockCounts[e]=0
  end
end
function this.GetBulletNum(a)
  for e=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
    if(a~=nil and a==vars.ammoStockIds[e])then
      return vars.ammoStockCounts[e]
    end
  end
  return 0
end
function this.SavePlayerCurrentWeapons()
  if not vars.initWeapons then
    return
  end
  vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]=vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]
  if TppDefine.HONEY_BEE_EQUIP_ID~=vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]then
    vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]=vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]
  else
    vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]=TppEquip.EPQ_None
  end
  vars.initWeapons[TppDefine.WEAPONSLOT.SECONDARY]=vars.weapons[TppDefine.WEAPONSLOT.SECONDARY]
  vars.initHandEquip=vars.handEquip
  for a=0,7 do
    vars.initSupportWeapons[a]=vars.supportWeapons[a]
  end
  e.SaveChimeraWeaponParameter()
end
function this.RestorePlayerWeaponsOnMissionStart()
  if not vars.initWeapons then
    return
  end
  vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]=vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]
  vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]=vars.initWeapons[TppDefine.WEAPONSLOT.PRIMARY_BACK]
  vars.weapons[TppDefine.WEAPONSLOT.SECONDARY]=vars.initWeapons[TppDefine.WEAPONSLOT.SECONDARY]
  vars.handEquip=vars.initHandEquip
  for e=0,7 do
    vars.supportWeapons[e]=vars.initSupportWeapons[e]
  end
end
function this.SaveChimeraWeaponParameter()
  if not vars.initCustomizedWeapon then
    return
  end
  for e=0,2 do
    vars.initCustomizedWeapon[e]=vars.customizedWeapon[e]
  end
  for e=0,32 do
    vars.initChimeraParts[e]=vars.chimeraParts[e]
  end
end
function this.RestoreChimeraWeaponParameter()
  if not vars.initCustomizedWeapon then
    return
  end
  for e=0,2 do
    vars.customizedWeapon[e]=vars.initCustomizedWeapon[e]
  end
  for e=0,32 do
    vars.chimeraParts[e]=vars.initChimeraParts[e]
  end
end
function this.SavePlayerCurrentItems()
  for e=0,7 do
    vars.initItems[e]=vars.items[e]
  end
end
function this.RestorePlayerItemsOnMissionStart()
  for e=0,7 do
    vars.items[e]=vars.initItems[e]
  end
end
function this.ForceSetAllInitialWeapon()
  vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_HIP]=1
  vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_BACK]=1
  vars.isInitialWeapon[TppDefine.WEAPONSLOT.SECONDARY]=1
end
function this.SupplyAllAmmoFullOnMissionFinalize()
  local a={TppDefine.WEAPONSLOT.PRIMARY_HIP,TppDefine.WEAPONSLOT.PRIMARY_BACK,TppDefine.WEAPONSLOT.SECONDARY}
  for t,a in ipairs(a)do
    e.SupplyWeaponAmmoFull(a)
  end
  for a=0,3 do
    local a=vars.initSupportWeapons[a]
    if a~=TppEquip.EQP_None then
      e.SupplySupportWeaponAmmoFull(a)
    end
  end
end
function this.SupplyWeaponAmmoFull(a)
  local t=vars.initWeapons[a]
  if t==TppEquip.EQP_None then
    return
  end
  local n,t,o,i,r,l=TppEquip.GetAmmoInfo(t)
  e.SupplyAmmoByBulletId(n,o)
  gvars.initAmmoInWeapons[a]=t
  e.SupplyAmmoByBulletId(i,l)
  gvars.initAmmoSubInWeapons[a]=r
end
function this.SupplySupportWeaponAmmoFull(a)
  local t,n,a,n,n,n=TppEquip.GetAmmoInfo(a)
  e.SupplyAmmoByBulletId(t,a)
end
function this.SupplyAmmoByBulletId(a,n)
  if a==TppEquip.BL_None then
    return
  end
  local e
  for t=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
    if gvars.initAmmoStockIds[t]==a then
      e=t
      break
    end
  end
  if not e then
    for t=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
      if gvars.initAmmoStockIds[t]==TppEquip.BL_None then
        gvars.initAmmoStockIds[t]=a
        e=t
        break
      end
    end
  end
  if not e then
    return
  end
  gvars.initAmmoStockCounts[e]=n
end
function this.SavePlayerCurrentAmmoCount()
  for e=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
    gvars.initAmmoStockIds[e]=vars.ammoStockIds[e]
    gvars.initAmmoStockCounts[e]=vars.ammoStockCounts[e]
  end
  local e={TppDefine.WEAPONSLOT.PRIMARY_HIP,TppDefine.WEAPONSLOT.PRIMARY_BACK,TppDefine.WEAPONSLOT.SECONDARY}
  for a,e in ipairs(e)do
    gvars.initAmmoInWeapons[e]=vars.ammoInWeapons[e]
    gvars.initAmmoSubInWeapons[e]=vars.ammoSubInWeapons[e]
  end
end
function this.SetMissionStartAmmoCount()
  for e=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
    vars.ammoStockIds[e]=gvars.initAmmoStockIds[e]
    vars.ammoStockCounts[e]=gvars.initAmmoStockCounts[e]
  end
  local e={TppDefine.WEAPONSLOT.PRIMARY_HIP,TppDefine.WEAPONSLOT.PRIMARY_BACK,TppDefine.WEAPONSLOT.SECONDARY}
  for a,e in ipairs(e)do
    vars.ammoInWeapons[e]=gvars.initAmmoInWeapons[e]
    vars.ammoSubInWeapons[e]=gvars.initAmmoSubInWeapons[e]
  end
end
function this.SetEquipMissionBlockGroupSize()
  local e=mvars.ply_equipMissionBlockGroupSize
  if e>0 then
    TppEquip.CreateEquipMissionBlockGroup{size=e}
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
function this.IsDecoy(e)
  local e=TppEquip.GetSupportWeaponTypeId(e)
  local a={[TppEquip.SWP_TYPE_Decoy]=true,[TppEquip.SWP_TYPE_ActiveDecoy]=true,[TppEquip.SWP_TYPE_ShockDecoy]=true}
  if a[e]then
    return true
  else
    return false
  end
end
function this.IsMine(e)
  local e=TppEquip.GetSupportWeaponTypeId(e)
  local a={[TppEquip.SWP_TYPE_DMine]=true,[TppEquip.SWP_TYPE_SleepingGusMine]=true,[TppEquip.SWP_TYPE_AntitankMine]=true,[TppEquip.SWP_TYPE_ElectromagneticNetMine]=true}
  if a[e]then
    return true
  else
    return false
  end
end
function this.AddTrapSettingForIntel(t)
  local n=t.trapName
  local s=t.direction or 0
  local p=t.directionRange or 60
  local e=t.intelName
  local d=t.autoIcon
  local i=t.gotFlagName
  local r=t.markerTrapName
  local o=t.markerObjectiveName
  local c=t.identifierName
  local t=t.locatorName
  if not l(n)then
    return
  end
  mvars.ply_intelTrapInfo=mvars.ply_intelTrapInfo or{}
  if e then
    mvars.ply_intelTrapInfo[e]={trapName=n}
  else
    return
  end
  mvars.ply_intelNameReverse=mvars.ply_intelNameReverse or{}
  mvars.ply_intelNameReverse[a(e)]=e
  mvars.ply_intelFlagInfo=mvars.ply_intelFlagInfo or{}
  if i then
    mvars.ply_intelFlagInfo[e]=i
    mvars.ply_intelFlagInfo[a(e)]=i
    mvars.ply_intelTrapInfo[e].gotFlagName=i
  end
  mvars.ply_intelMarkerObjectiveName=mvars.ply_intelMarkerObjectiveName or{}
  if o then
    mvars.ply_intelMarkerObjectiveName[e]=o
    mvars.ply_intelMarkerObjectiveName[a(e)]=o
    mvars.ply_intelTrapInfo[e].markerObjectiveName=o
  end
  mvars.ply_intelMarkerTrapList=mvars.ply_intelMarkerTrapList or{}
  mvars.ply_intelMarkerTrapInfo=mvars.ply_intelMarkerTrapInfo or{}
  if r then
    table.insert(mvars.ply_intelMarkerTrapList,r)
    mvars.ply_intelMarkerTrapInfo[a(r)]=e
    mvars.ply_intelTrapInfo[e].markerTrapName=r
  end
  mvars.ply_intelTrapList=mvars.ply_intelTrapList or{}
  if d then
    table.insert(mvars.ply_intelTrapList,n)
    mvars.ply_intelTrapInfo[a(n)]=e
    mvars.ply_intelTrapInfo[e].autoIcon=true
  end
  if c and t then
    local a,e=Tpp.GetLocator(c,t)
    if a and e then
      s=e
    end
  end
  mvars.ply_intelTrapInfo[e].direction=s
  mvars.ply_intelTrapInfo[e].directionRange=p
  Player.AddTrapDetailCondition{trapName=n,condition=PlayerTrap.FINE,action=(PlayerTrap.NORMAL+PlayerTrap.BEHIND),stance=(PlayerTrap.STAND+PlayerTrap.SQUAT),direction=s,directionRange=p}
end
function this.ShowIconForIntel(e,n)
  if not l(e)then
    return
  end
  local t
  if mvars.ply_intelTrapInfo and mvars.ply_intelTrapInfo[e]then
    t=mvars.ply_intelTrapInfo[e].trapName
  end
  local a=mvars.ply_intelFlagInfo[e]
  if a then
    if svars[a]~=nil then
      n=svars[a]
    end
  end
  if not n then
    if Tpp.IsNotAlert()then
      Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL,message=Fox.StrCode32"GetIntel",messageInDisplay=Fox.StrCode32"IntelIconInDisplay",messageArg=e}
    elseif t then
      Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL_NG,message=Fox.StrCode32"NGIntel",messageInDisplay=Fox.StrCode32"IntelIconInDisplay",messageArg=e}
      if not TppRadio.IsPlayed(TppRadio.COMMON_RADIO_LIST[TppDefine.COMMON_RADIO.CANNOT_GET_INTEL_ON_ALERT])then
        TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.CANNOT_GET_INTEL_ON_ALERT)
      end
    end
  end
end
function this.GotIntel(a)
  local e=mvars.ply_intelFlagInfo[a]
  if not e then
    return
  end
  if svars[e]~=nil then
    svars[e]=true
  end
  local e=mvars.ply_intelMarkerObjectiveName[a]
  if e then
    local a=TppMission.GetParentObjectiveName(e)
    local e={}
    for a,t in pairs(a)do
      table.insert(e,a)
    end
    TppMission.UpdateObjective{objectives=e}
  end
end
function this.HideIconForIntel()
Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL}
Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL_NG}
end
function this.AddTrapSettingForQuest(e)
  local t=e.trapName
  local n=e.direction or 0
  local o=e.directionRange or 180
  local e=e.questName
  if not l(t)then
    return
  end
  mvars.ply_questStartTrapInfo=mvars.ply_questStartTrapInfo or{}
  if e then
    mvars.ply_questStartTrapInfo[e]={trapName=t}
  else
    return
  end
  mvars.ply_questNameReverse=mvars.ply_questNameReverse or{}
  mvars.ply_questNameReverse[a(e)]=e
  mvars.ply_questStartFlagInfo=mvars.ply_questStartFlagInfo or{}
  mvars.ply_questStartFlagInfo[e]=false
  mvars.ply_questTrapList=mvars.ply_questTrapList or{}table.insert(mvars.ply_questTrapList,t)
  mvars.ply_questStartTrapInfo[a(t)]=e
  Player.AddTrapDetailCondition{trapName=t,condition=PlayerTrap.FINE,action=PlayerTrap.NORMAL,stance=(PlayerTrap.STAND+PlayerTrap.SQUAT),direction=n,directionRange=o}
end
function this.ShowIconForQuest(e,a)
  if not l(e)then
    return
  end
  local t
  if mvars.ply_questStartTrapInfo and mvars.ply_questStartTrapInfo[e]then
    t=mvars.ply_questStartTrapInfo[e].trapName
  end
  if mvars.ply_questStartFlagInfo[e]~=nil then
    a=mvars.ply_questStartFlagInfo[e]
  end
  if not a then
    Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.TRAINING,message=Fox.StrCode32"QuestStarted",messageInDisplay=Fox.StrCode32"QuestIconInDisplay",messageArg=e}
  end
end
function this.QuestStarted(a)
  local a=mvars.ply_questNameReverse[a]
  if mvars.ply_questStartFlagInfo[a]~=nil then
    mvars.ply_questStartFlagInfo[a]=true
  end
  e.HideIconForQuest()
end
function this.HideIconForQuest()Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.TRAINING}
end
function this.ResetIconForQuest(e)
  mvars.ply_questStartFlagInfo.ShootingPractice=false
end
function this.AppearHorseOnMissionStart(e,a)
  local e,a=Tpp.GetLocator(e,a)
  if e then
    vars.buddyType=BuddyType.HORSE
    vars.initialBuddyPos[0]=e[1]
    vars.initialBuddyPos[1]=e[2]
    vars.initialBuddyPos[2]=e[3]
  end
end
function this.StartGameOverCamera(t,a,e)
  if mvars.ply_gameOverCameraGameObjectId~=nil then
    return
  end
  mvars.ply_gameOverCameraGameObjectId=t
  mvars.ply_gameOverCameraStartTimerName=a
  mvars.ply_gameOverCameraAnnounceLog=e
  TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  TppSound.PostJingleOnGameOver()
  TppSoundDaemon.PostEvent"sfx_s_force_camera_out"
  vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
  r("Timer_StartGameOverCamera",.25)
end
function this._StartGameOverCamera(e,e)
  TppUiStatusManager.ClearStatus"AnnounceLog"
  FadeFunction.SetFadeColor(64,0,0,255)
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,mvars.ply_gameOverCameraStartTimerName,nil,{exceptGameStatus={AnnounceLog=false}})Player.RequestToSetCameraFocalLengthAndDistance{focalLength=16,interpTime=TppUI.FADE_SPEED.FADE_HIGHSPEED}
end
function this.PrepareStartGameOverCamera()
  FadeFunction.ResetFadeColor()
  local e={}
  for a,t in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
    e[a]=false
  end
  for a,t in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
    e[a]=false
  end
  e.S_DISABLE_NPC=nil
  e.AnnounceLog=nil
  TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,nil,nil,{exceptGameStatus=e})
  Player.RequestToStopCameraAnimation{}
  if mvars.ply_gameOverCameraAnnounceLog then
    TppUiStatusManager.ClearStatus"AnnounceLog"
    TppUI.ShowAnnounceLog(mvars.ply_gameOverCameraAnnounceLog)
  end
end
function this.FOBStartGameOverCamera(e,t,a)
  if mvars.ply_gameOverCameraGameObjectId~=nil then
    return
  end
  mvars.ply_gameOverCameraGameObjectId=e
  mvars.ply_gameOverCameraStartTimerName=t
  mvars.ply_gameOverCameraAnnounceLog=a
  TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
  r("Timer_StartGameOverCamera",.25)
end
function this.SetTargetDeadCamera(o)
  local r
  local a
  local l
  if n(o)then
    r=o.gameObjectName or""a=o.gameObjectId
    l=o.announceLog or"target_extract_failed"
  end
  a=a or i(r)
  if a==t then
    return
  end
  e.StartGameOverCamera(a,"EndFadeOut_StartTargetDeadCamera",l)
end
function this._SetTargetDeadCamera()
  e.PrepareStartGameOverCamera()
  Player.RequestToPlayCameraNonAnimation{characterId=mvars.ply_gameOverCameraGameObjectId,isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,candidateRots={{10,0},{10,45},{10,90},{10,135},{10,180},{10,225},{10,270}},skeletonNames={"SKL_004_HEAD","SKL_011_LUARM","SKL_021_RUARM","SKL_032_LFOOT","SKL_042_RFOOT"},skeletonCenterOffsets={Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0)},skeletonBoundings={Vector3(0,.45,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,-.3,0),Vector3(0,-.3,0)},offsetPos=Vector3(.3,.2,-4.6),focalLength=21,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.001,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=16}
end
function this.SetTargetHeliCamera(o)
  local r
  local a
  local l
  if n(o)then
    r=o.gameObjectName or""a=o.gameObjectId
    l=o.announceLog or"target_eliminate_failed"
  end
  a=a or i(r)
  if a==t then
    return
  end
  e.StartGameOverCamera(a,"EndFadeOut_StartTargetHeliCamera",l)
end
function this._SetTargetHeliCamera()
  e.PrepareStartGameOverCamera()Player.RequestToPlayCameraNonAnimation{characterId=mvars.ply_gameOverCameraGameObjectId,isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,candidateRots={{10,0}},skeletonNames={"SKL_011_RLWDOOR"},skeletonCenterOffsets={Vector3(0,0,0)},skeletonBoundings={Vector3(0,.45,0)},offsetPos=Vector3(.3,.2,-4.6),focalLength=21,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.01,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=999999}
end
function this.SetTargetTruckCamera(o)
  local r
  local a
  local l
  if n(o)then
    r=o.gameObjectName or""a=o.gameObjectId
    l=o.announceLog or"target_extract_failed"
  end
  a=a or i(r)
  if a==t then
    return
  end
  e.StartGameOverCamera(a,"EndFadeOut_StartTargetTruckCamera",l)
end
function this._SetTargetTruckCamera(a)
  e.PrepareStartGameOverCamera()Player.RequestToPlayCameraNonAnimation{characterId=mvars.ply_gameOverCameraGameObjectId,isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,candidateRots={{10,0},{10,45},{10,90},{10,135},{10,180},{10,225},{10,270}},skeletonNames={"SKL_005_WIPERC"},skeletonCenterOffsets={Vector3(0,-.75,-2)},skeletonBoundings={Vector3(1.5,2,4)},offsetPos=Vector3(2.5,3,7.5),focalLength=21,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.01,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=999999}
end
function this.SetPlayerKilledChildCamera()
  if mvars.mis_childGameObjectIdKilledPlayer then
    local a=nil
    if not TppEnemy.IsRescueTarget(mvars.mis_childGameObjectIdKilledPlayer)then
      a="boy_died"
    end
    e.SetTargetDeadCamera{gameObjectId=mvars.mis_childGameObjectIdKilledPlayer,announceLog=a}
  end
end
function this.SetPressStartCamera()
  local e=i"Player"
  if e==t then
    return
  end
  Player.RequestToStopCameraAnimation{}Player.RequestToPlayCameraNonAnimation{characterId=e,isFollowPos=true,isFollowRot=true,followTime=0,followDelayTime=0,candidateRots={{0,185}},skeletonNames={"SKL_004_HEAD"},skeletonCenterOffsets={Vector3(-.5,-.15,0)},skeletonBoundings={Vector3(.5,.45,.1)},offsetPos=Vector3(-.8,0,-1.4),focalLength=21,aperture=1.875,timeToSleep=0,fitOnCamera=false,timeToStartToFitCamera=0,fitCameraInterpTime=0,diffFocalLengthToReFitCamera=0}
end
function this.SetTitleCamera()
  local e=i"Player"
  if e==t then
    return
  end
  Player.RequestToStopCameraAnimation{}Player.RequestToPlayCameraNonAnimation{characterId=e,isFollowPos=true,isFollowRot=true,followTime=0,followDelayTime=0,candidateRots={{0,185}},skeletonNames={"SKL_004_HEAD"},skeletonCenterOffsets={Vector3(-.5,-.15,.1)},skeletonBoundings={Vector3(.5,.45,.9)},offsetPos=Vector3(-.8,0,-1.8),focalLength=21,aperture=1.875,timeToSleep=0,fitOnCamera=false,timeToStartToFitCamera=0,fitCameraInterpTime=0,diffFocalLengthToReFitCamera=0}
end
function this.SetSearchTarget(o,i,s,l,e,r,n,a)
  if(o==nil or i==nil)then
    return
  end
  local i=m(i)
  if i==t then
    return
  end
  if n==nil then
    n=true
  end
  if e==nil then
    e=Vector3(0,.25,0)
  end
  if a==nil then
    a=.03
  end
  local e={name=s,targetGameObjectTypeIndex=i,targetGameObjectName=o,offset=e,centerRange=.3,lookingTime=1,distance=200,doWideCheck=true,wideCheckRadius=.15,wideCheckRange=a,doDirectionCheck=false,directionCheckRange=100,doCollisionCheck=true}
  if(l~=nil)then
    e.skeletonName=l
  end
  if(r~=nil)then
    e.targetFox2Name=r
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
  local e=e.SetPlayerStatusForMissionEndCamera()
  if not e then
    return
  end
  r("Timer_StartPlayMissionClearCameraStep1",.25)
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
function this.PlayCommonMissionEndCamera(i,o,s,l,t,n)
  local a
  local e=vars.playerVehicleGameObjectId
  if Tpp.IsHorse(e)then
    GameObject.SendCommand(e,{id="HorseForceStop"})
    a=i(e,t,n)
  elseif Tpp.IsVehicle(e)then
    local r=GameObject.SendCommand(e,{id="GetVehicleType"})
    GameObject.SendCommand(e,{id="ForceStop",enabled=true})
    local o=o[r]
    if o then
      a=o(e,t,n)
    end
  elseif(Tpp.IsPlayerWalkerGear(e)or Tpp.IsEnemyWalkerGear(e))then
    GameObject.SendCommand(e,{id="ForceStop",enabled=true})
    a=s(e,t,n)
  elseif Tpp.IsHelicopter(e)then
  else
    a=l(t,n)
  end
  if a then
    local e="Timer_StartPlayMissionClearCameraStep"..tostring(t+1)
    r(e,a)
  end
end
function this._PlayMissionClearCamera(a,t)
  if a==1 then
    TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_common_jingle_clear")
  end
  e.PlayCommonMissionEndCamera(e.PlayMissionClearCameraOnRideHorse,e.VEHICLE_MISSION_CLEAR_CAMERA,e.PlayMissionClearCameraOnWalkerGear,e.PlayMissionClearCameraOnFoot,a,t)
end
function this.RequestMissionClearMotion()
  Player.RequestToPlayDirectMotion{"missionClearMotion",{"/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_f_idl7.gani",false,"","","",false}}
end
function this.PlayMissionClearCameraOnFoot(p,c)
  if PlayerInfo.AndCheckStatus{PlayerStatus.NORMAL_ACTION}then
    if PlayerInfo.OrCheckStatus{PlayerStatus.STAND,PlayerStatus.SQUAT}then
      if PlayerInfo.AndCheckStatus{PlayerStatus.CARRY}then
        mvars.ply_requestedMissionClearCameraCarryOff=true
        GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="RequestCarryOff"})
      else
        e.RequestMissionClearMotion()
      end
    end
  end
  local e={"SKL_004_HEAD","SKL_002_CHEST"}
  local o={Vector3(0,0,.05),Vector3(.15,0,0)}
  local n={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
  local a=Vector3(0,0,-4.5)
  local t=.3
  local i
  local r=false
  local l=20
  local s=false
  if p==1 then
    e={"SKL_004_HEAD","SKL_002_CHEST"}
    o={Vector3(0,0,.05),Vector3(.15,0,0)}
    n={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
    a=Vector3(0,0,-1.5)t=.3
    i=1
    r=true
  elseif c then
    e={"SKL_004_HEAD"}o={Vector3(0,0,.05)}
    n={Vector3(.1,.125,.1)}
    a=Vector3(0,-.5,-3.5)t=3
    l=4
  else
    e={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"}
    o={Vector3(0,0,.05),Vector3(.15,0,0),Vector3(-.15,0,0)}
    n={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)}
    a=Vector3(0,0,-3.2)t=3
    s=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{1,168},{1,-164}},skeletonNames=e,skeletonCenterOffsets=o,skeletonBoundings=n,offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=l,interpTimeAtStart=t,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=r,useLastSelectedIndex=s}
  return i
end
function this.PlayMissionClearCameraOnRideHorse(e,c,p)
  local n={"SKL_004_HEAD","SKL_002_CHEST"}
  local o={Vector3(0,0,.05),Vector3(.15,0,0)}
  local e={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
  local t=Vector3(0,0,-3.2)
  local a=.2
  local r
  local i=false
  local s=20
  local l=false
  if p then
    s=4
  end
  if c==1 then
    n={"SKL_004_HEAD","SKL_002_CHEST"}
    o={Vector3(0,-.125,.05),Vector3(.15,-.125,0)}
    e={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
    t=Vector3(0,0,-3.2)
    a=.2
    r=1
    i=true
  else
    n={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"}
    o={Vector3(0,-.125,.05),Vector3(.15,-.125,0),Vector3(-.15,-.125,0)}
    e={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)}
    t=Vector3(0,0,-4.5)
    a=3
    l=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{0,160},{0,-160}},skeletonNames=n,skeletonCenterOffsets={Vector3(0,-.125,.05),Vector3(.15,-.125,0),Vector3(-.15,-.125,0)},skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)},skeletonCenterOffsets=o,skeletonBoundings=e,offsetPos=t,focalLength=28,aperture=1.875,timeToSleep=s,interpTimeAtStart=a,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=i,useLastSelectedIndex=l}
  return r
end
function this.PlayMissionClearCameraOnRideLightVehicle(e,l,s)
  local a=Vector3(-.35,.6,.7)
  local t=Vector3(0,0,-2.25)
  local e=.2
  local i
  local o=false
  local r=20
  local n=false
  if s then
    r=4
  end
  if l==1 then
    a=Vector3(-.35,.6,.7)
    t=Vector3(0,0,-2.25)e=.2
    i=.5
    o=true
  else
    a=Vector3(-.35,.4,.7)
    t=Vector3(0,0,-4)e=.75
    n=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{3,160},{3,-160}},offsetTarget=a,offsetPos=t,focalLength=28,aperture=1.875,timeToSleep=r,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=o,useLastSelectedIndex=n}
  return i
end
function this.PlayMissionClearCameraOnRideTruck(e,s,l)
  local a=Vector3(-.35,1.3,1)
  local e=Vector3(0,0,-2)
  local t=.2
  local n
  local o=false
  local r=20
  local i=false
  if l then
    r=4
  end
  if s==1 then
    a=Vector3(-.35,1.3,1)e=Vector3(0,0,-3)t=.2
    n=.5
    o=true
  else
    a=Vector3(-.35,1,1)e=Vector3(0,0,-6)t=.75
    i=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{3,160},{3,-160}},offsetTarget=a,offsetPos=e,focalLength=28,aperture=1.875,timeToSleep=r,interpTimeAtStart=t,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=o,useLastSelectedIndex=i}
  return n
end
function this.PlayMissionClearCameraOnRideCommonArmoredVehicle(a,s,e,l)
  local t=Vector3(.05,-.5,-2.2)
  if e==1 then
    t=Vector3(.05,-.5,-2.2)
  else
    t=Vector3(-.05,-1,0)
  end
  local a=Vector3(0,0,-7.5)
  local e=.2
  local r
  local i=false
  local n=20
  local o=false
  if l then
    n=4
  end
  if s==1 then
    a=Vector3(0,0,-7.5)e=.2
    r=.5
    i=true
  else
    a=Vector3(0,0,-13.25)e=.75
    o=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{8,165},{8,-165}},offsetTarget=t,offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=n,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=i,useLastSelectedIndex=o}
  return r
end
function this.PlayMissionClearCameraOnRideEasternArmoredVehicle(t,n,o)
  local a
  a=e.PlayMissionClearCameraOnRideCommonArmoredVehicle(t,n,1,o)
  return a
end
function this.PlayMissionClearCameraOnRideWesternArmoredVehicle(t,n)
  local a
  a=e.PlayMissionClearCameraOnRideCommonArmoredVehicle(t,n,2,isQuest)
  return a
end
function this.PlayMissionClearCameraOnRideTank(e,l,i)
  local a=Vector3(0,0,-6.5)
  local e=.2
  local o
  local r=false
  local t=20
  local n=false
  if i then
    t=4
  end
  if l==1 then
    a=Vector3(0,0,-6.5)e=.2
    o=.5
    r=true
  else
    a=Vector3(0,0,-9)e=.75
    n=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{9,165},{9,-165}},offsetTarget=Vector3(0,-.85,3.25),offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=t,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=r,useLastSelectedIndex=n}
  return o
end
function this.PlayMissionClearCameraOnWalkerGear(a,p,s)
  local n=Vector3(0,.55,.35)
  local a=Vector3(0,0,-3.65)
  local t=.2
  local l
  local i=false
  local o=20
  local r=false
  if s then
    o=4
  end
  if p==1 then
    n=Vector3(0,.55,.35)a=Vector3(0,0,-3.65)t=.2
    l=1
    i=true
  else
    n=Vector3(0,.4,.35)a=Vector3(0,0,-4.95)t=3
    r=true
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{7,165},{7,-165}},offsetTarget=n,offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=t,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=i,useLastSelectedIndex=r}
  return l
end
e.VEHICLE_MISSION_CLEAR_CAMERA={[Vehicle.type.EASTERN_LIGHT_VEHICLE]=e.PlayMissionClearCameraOnRideLightVehicle,[Vehicle.type.EASTERN_TRACKED_TANK]=e.PlayMissionClearCameraOnRideTank,[Vehicle.type.EASTERN_TRUCK]=e.PlayMissionClearCameraOnRideTruck,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=e.PlayMissionClearCameraOnRideEasternArmoredVehicle,[Vehicle.type.WESTERN_LIGHT_VEHICLE]=e.PlayMissionClearCameraOnRideLightVehicle,[Vehicle.type.WESTERN_TRACKED_TANK]=e.PlayMissionClearCameraOnRideTank,[Vehicle.type.WESTERN_TRUCK]=e.PlayMissionClearCameraOnRideTruck,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=e.PlayMissionClearCameraOnRideWesternArmoredVehicle}
function this.FOBPlayMissionClearCamera()
  local e=e.SetPlayerStatusForMissionEndCamera()
  if not e then
    return
  end
  r("Timer_FOBStartPlayMissionClearCameraStep1",.25)
end
function this._FOBPlayMissionClearCamera(a)
  e.FOBPlayCommonMissionEndCamera(e.FOBPlayMissionClearCameraOnFoot,a)
end
function this.FOBPlayCommonMissionEndCamera(t,a)
  local e
  e=t(a)
  if e then
    local a="Timer_FOBStartPlayMissionClearCameraStep"..tostring(a+1)r(a,e)
  end
end
function this.FOBRequestMissionClearMotion()
  Player.RequestToPlayDirectMotion{"missionClearMotionFob",{"/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_s_win_idl.gani",false,"","","",false}}
end
function this.FOBPlayMissionClearCameraOnFoot(l)
  Player.SetCurrentSlot{slotType=PlayerSlotType.ITEM,subIndex=0}
  if PlayerInfo.OrCheckStatus{PlayerStatus.STAND,PlayerStatus.SQUAT,PlayerStatus.CRAWL}then
    if PlayerInfo.AndCheckStatus{PlayerStatus.CARRY}then
      mvars.ply_requestedMissionClearCameraCarryOff=true
      GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="RequestCarryOff"})
    elseif PlayerInfo.OrCheckStatus{PlayerStatus.SQUAT,PlayerStatus.CRAWL}then
      Player.RequestToSetTargetStance(PlayerStance.STAND)r("Timer_FOBWaitStandStance",1)
    else
      e.FOBRequestMissionClearMotion()
    end
  end
  local n={"SKL_004_HEAD","SKL_002_CHEST"}
  local a={Vector3(0,.1,0),Vector3(0,-.05,0)}
  local o={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
  local t=Vector3(0,0,-4.5)
  local e=.3
  local i
  local r=false
  if l==1 then
    n={"SKL_004_HEAD","SKL_002_CHEST"}a={Vector3(0,.25,0),Vector3(0,-.05,0)}o={Vector3(.1,.125,.1),Vector3(.1,.125,.1)}t=Vector3(0,0,-1)e=.3
    i=1
    r=true
  else
    n={"SKL_004_HEAD","SKL_002_CHEST"}a={Vector3(0,.15,0),Vector3(0,-.05,0)}o={Vector3(.1,.125,.1),Vector3(.1,.125,.1)}t=Vector3(0,0,-1.5)e=3
  end
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{-10,170},{-10,-170}},skeletonNames=n,skeletonCenterOffsets=a,skeletonBoundings=o,offsetPos=t,focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=r}
  return i
end
function this.PlayMissionAbortCamera()
  local e=e.SetPlayerStatusForMissionEndCamera()
  if not e then
    return
  end
  r("Timer_StartPlayMissionAbortCamera",.25)
end
function this._PlayMissionAbortCamera()
  TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_common_jingle_failed")
  e.PlayCommonMissionEndCamera(e.PlayMissionAbortCameraOnRideHorse,e.VEHICLE_MISSION_ABORT_CAMERA,e.PlayMissionAbortCameraOnWalkerGear,e.PlayMissionAbortCameraOnFoot)
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
  e.PlayMissionAbortCameraOnRideCommonArmoredVehicle(a,1)
end
function this.PlayMissionAbortCameraOnRideWesternArmoredVehicle(a)
  e.PlayMissionAbortCameraOnRideCommonArmoredVehicle(a,2)
end
function this.PlayMissionAbortCameraOnRideTank(e)
  local e=Vector3(0,-.5,0)
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{8,25},{8,-25}},offsetTarget=e,offsetPos=Vector3(0,0,-10),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function this.PlayMissionAbortCameraOnWalkerGear(a)
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{7,15},{7,-15}},offsetTarget=Vector3(0,.8,0),offsetPos=Vector3(0,.5,-3.5),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
e.VEHICLE_MISSION_ABORT_CAMERA={[Vehicle.type.EASTERN_LIGHT_VEHICLE]=e.PlayMissionAbortCameraOnRideLightVehicle,[Vehicle.type.EASTERN_TRACKED_TANK]=e.PlayMissionAbortCameraOnRideTank,[Vehicle.type.EASTERN_TRUCK]=e.PlayMissionAbortCameraOnRideTruck,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=e.PlayMissionAbortCameraOnRideEasternArmoredVehicle,[Vehicle.type.WESTERN_LIGHT_VEHICLE]=e.PlayMissionAbortCameraOnRideLightVehicle,[Vehicle.type.WESTERN_TRACKED_TANK]=e.PlayMissionAbortCameraOnRideTank,[Vehicle.type.WESTERN_TRUCK]=e.PlayMissionAbortCameraOnRideTruck,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=e.PlayMissionAbortCameraOnRideWesternArmoredVehicle}
function this.PlayFallDeadCamera()
  mvars.ply_fallDeadCameraTargetPlayerIndex=PlayerInfo.GetLocalPlayerIndex()
  HighSpeedCamera.RequestEvent{continueTime=.03,worldTimeRate=.1,localPlayerTimeRate=.1}
  e.PlayCommonMissionEndCamera(e.PlayFallDeadCameraOnRideHorse,e.VEHICLE_FALL_DEAD_CAMERA,e.PlayFallDeadCameraOnWalkerGear,e.PlayFallDeadCameraOnFoot)
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
  local e=e.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-2.5,(e+1),-2.5),focalLength=21,aperture=1.875,timeToSleep=20,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideHorse(a)
  local e=e.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-2.5,(e+1),-2.5),focalLength=21,aperture=1.875,timeToSleep=20,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideLightVehicle(a)
  local e=e.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=20,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideTruck(a)
  local e=e.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=20,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideArmoredVehicle(a)
  local e=e.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=20,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnRideTank(a)
  local e=e.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=20,interpTimeAtStart=0,fitOnCamera=false}
end
function this.PlayFallDeadCameraOnWalkerGear(a)
  local a=e.GetFallDeadCameraOffsetPosY()
  Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(a+1),-8),focalLength=21,aperture=1.875,timeToSleep=20,interpTimeAtStart=0,fitOnCamera=false}
end
e.VEHICLE_FALL_DEAD_CAMERA={
  [Vehicle.type.EASTERN_LIGHT_VEHICLE]=e.PlayFallDeadCameraOnRideLightVehicle,
  [Vehicle.type.EASTERN_TRACKED_TANK]=e.PlayFallDeadCameraOnRideTank,
  [Vehicle.type.EASTERN_TRUCK]=e.PlayFallDeadCameraOnRideTruck,
  [Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=e.PlayFallDeadCameraOnRideArmoredVehicle,
  [Vehicle.type.WESTERN_LIGHT_VEHICLE]=e.PlayFallDeadCameraOnRideLightVehicle,
  [Vehicle.type.WESTERN_TRACKED_TANK]=e.PlayFallDeadCameraOnRideTank,
  [Vehicle.type.WESTERN_TRUCK]=e.PlayFallDeadCameraOnRideTruck,
  [Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=e.PlayFallDeadCameraOnRideArmoredVehicle
}
function this.Messages()
  local t=Tpp.StrCode32Table{
    Player={
      {msg="CalcFultonPercent",func=function(t,n,r,a,o)
        e.MakeFultonRecoverSucceedRatio(t,n,r,a,o,false)
      end},
      {msg="CalcDogFultonPercent",func=function(o,n,r,a,t)
        e.MakeFultonRecoverSucceedRatio(o,n,r,a,t,true)
      end},
      {msg="RideHelicopter",func=e.SetHelicopterInsideAction},
      {msg="PlayerFulton",func=e.OnPlayerFulton},
      {msg="OnPickUpCollection",func=e.OnPickUpCollection},
      {msg="OnPickUpPlaced",func=e.OnPickUpPlaced},
      {msg="OnPickUpWeapon",func=e.OnPickUpWeapon},
      {msg="WarpEnd",func=e.OnEndWarpByCboxDelivery},
      {msg="LandingFromHeli",func=function()
        e.UpdateCheckPointOnMissionStartDrop()
        if TppMission.IsManualSubsistenceMission() then--tex force sieze vehicle on subs mission start, RETRY: do earlier or prevent spawn completely (ideal, set relief vehicle to none in mis prep UI). see inf heaven txt 'force no vehicle drop'.
          TppMission.SeizeReliefVehicleOnClear()  
        end--
      end},
      {msg="EndCarryAction",func=function()
        if mvars.ply_requestedMissionClearCameraCarryOff then
          if PlayerInfo.AndCheckStatus{PlayerStatus.STAND}then
            e.RequestMissionClearMotion()
          end
        end
      end,
      option={isExecMissionClear=true}},
      {msg="IntelIconInDisplay",func=e.OnIntelIconDisplayContinue},
      {msg="QuestIconInDisplay",func=e.OnQuestIconDisplayContinue},
      {msg="PlayerShowerEnd",func=function()
        TppUI.ShowAnnounceLog"refresh"
      end}
    },
    GameObject={{msg="RideHeli",func=e.QuietRideHeli}},
    UI={
      {msg="EndFadeOut",sender="OnSelectCboxDelivery",func=e.WarpByCboxDelivery},
      {msg="EndFadeIn",sender="OnEndWarpByCboxDelivery",func=e.OnEndFadeInWarpByCboxDelivery},
      {msg="EndFadeOut",sender="EndFadeOut_StartTargetDeadCamera",func=e._SetTargetDeadCamera,option={isExecGameOver=true}},
      {msg="EndFadeOut",sender="EndFadeOut_StartTargetHeliCamera",func=e._SetTargetHeliCamera,option={isExecGameOver=true}},
      {msg="EndFadeOut",sender="EndFadeOut_StartTargetTruckCamera",func=e._SetTargetTruckCamera,option={isExecGameOver=true}}
    },
    Terminal={{msg="MbDvcActSelectCboxDelivery",func=e.OnSelectCboxDelivery}},
    Timer={
      {msg="Finish",sender="Timer_StartPlayMissionClearCameraStep1",func=function()
        e._PlayMissionClearCamera(1)
      end,option={isExecMissionClear=true}},
      {msg="Finish",sender="Timer_StartPlayMissionClearCameraStep2",func=function()
        e._PlayMissionClearCamera(2)
      end,option={isExecMissionClear=true}},
      {msg="Finish",sender="Timer_FOBStartPlayMissionClearCameraStep1",func=function()
        e._FOBPlayMissionClearCamera(1)
      end,option={isExecMissionClear=true}},
      {msg="Finish",sender="Timer_FOBStartPlayMissionClearCameraStep2",func=function()
        e._FOBPlayMissionClearCamera(2)
      end,option={isExecMissionClear=true}},
      {msg="Finish",sender="Timer_StartPlayMissionAbortCamera",func=e._PlayMissionAbortCamera,option={isExecGameOver=true}},
      {msg="Finish",sender="Timer_DeliveryWarpSoundCannotCancel",func=e.OnDeliveryWarpSoundCannotCancel},
      {msg="Finish",sender="Timer_StartGameOverCamera",func=e._StartGameOverCamera,option={isExecGameOver=true}},
      {msg="Finish",sender="Timer_FOBWaitStandStance",
        func=function()
          e.FOBRequestMissionClearMotion()
        end,
        option={isExecMissionClear=true}}
    },
    Trap={{msg="Enter",sender="trap_TppSandWind0000",
      func=function()
        TppEffectUtility.SetSandWindEnable(true)
      end,
      option={isExecMissionPrepare=true}},
    {msg="Exit",sender="trap_TppSandWind0000",func=function()
      TppEffectUtility.SetSandWindEnable(false)
    end,
    option={isExecMissionPrepare=true}},
    {msg="Enter",sender="fallDeath_camera",func=function()
      e.SetLimitFallDeadCameraOffsetPosY(-18)
    end,
    option={isExecMissionPrepare=true}},
    {msg="Exit",sender="fallDeath_camera",func=e.ResetLimitFallDeadCameraOffsetPosY,option={isExecMissionPrepare=true}}
    }
  }

  if n(mvars.ply_intelMarkerTrapList)and next(mvars.ply_intelMarkerTrapList)then
    t[a"Trap"]=t[a"Trap"]or{}
    table.insert(t[a"Trap"],Tpp.StrCode32Table{msg="Enter",sender=mvars.ply_intelMarkerTrapList,func=e.OnEnterIntelMarkerTrap,option={isExecMissionPrepare=true}})
  end
  if n(mvars.ply_intelTrapList)and next(mvars.ply_intelTrapList)then
    t[a"Trap"]=t[a"Trap"]or{}
    table.insert(t[a"Trap"],Tpp.StrCode32Table{msg="Enter",sender=mvars.ply_intelTrapList,func=e.OnEnterIntelTrap})
    table.insert(t[a"Trap"],Tpp.StrCode32Table{msg="Exit",sender=mvars.ply_intelTrapList,func=e.OnExitIntelTrap})
  end
  return t
end
function this.DeclareSVars()
  return{
    {name="ply_pickableLocatorDisabled",arraySize=mvars.ply_maxPickableLocatorCount,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="ply_placedLocatorDisabled",arraySize=mvars.ply_maxPlacedLocatorCount,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="ply_isUsedPlayerInitialAction",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    nil
  }
end
function this.OnAllocate(e)
  if(e and e.sequence)and e.sequence.EQUIP_MISSION_BLOCK_GROUP_SIZE then
    mvars.ply_equipMissionBlockGroupSize=e.sequence.EQUIP_MISSION_BLOCK_GROUP_SIZE
  else
    mvars.ply_equipMissionBlockGroupSize=TppDefine.DEFAULT_EQUIP_MISSION_BLOCK_GROUP_SIZE
  end
  if(e and e.sequence)and e.sequence.MAX_PICKABLE_LOCATOR_COUNT then
    mvars.ply_maxPickableLocatorCount=e.sequence.MAX_PICKABLE_LOCATOR_COUNT
  else
    mvars.ply_maxPickableLocatorCount=TppDefine.PICKABLE_MAX
  end
  if(e and e.sequence)and e.sequence.MAX_PLACED_LOCATOR_COUNT then
    mvars.ply_maxPlacedLocatorCount=e.sequence.MAX_PLACED_LOCATOR_COUNT
  else
    mvars.ply_maxPlacedLocatorCount=TppDefine.PLACED_MAX
  end
end
function this.SetInitialPlayerState(a)
  local t
  if(a.sequence and a.sequence.missionStartPosition)and a.sequence.missionStartPosition.helicopterRouteList then
    if not Tpp.IsTypeFunc(a.sequence.missionStartPosition.IsUseRoute)or a.sequence.missionStartPosition.IsUseRoute()then
      t=a.sequence.missionStartPosition.helicopterRouteList
    end
  end
  if t==nil then
    if gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER then
    end
    e.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
  end
end
function this.MissionStartPlayerTypeSetting()
  if not mvars.ply_isExistTempPlayerType then
    e.RestoreTemporaryPlayerType()
  end
  if TppStory.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
    vars.playerType=PlayerType.SNAKE
    vars.playerPartsType=PlayerPartsType.NORMAL_SCARF
    vars.playerCamoType=PlayerCamoType.TIGERSTRIPE
    vars.playerHandType=PlayerHandType.NORMAL
  end
  if mvars.ply_isExistTempPlayerType then
    e.SaveCurrentPlayerType()
    e.ApplyTemporaryPlayerType()
  end
  if(vars.missionCode~=10010)and(vars.missionCode~=10280)then
    if vars.playerCamoType==PlayerCamoType.HOSPITAL then
      vars.playerCamoType=PlayerCamoType.OLIVEDRAB
    end
    if vars.playerPartsType==PlayerPartsType.HOSPITAL then
      vars.playerPartsType=PlayerPartsType.NORMAL
    end
  end
end
function this.Init(a)
  e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
  if gvars.ini_isTitleMode then
    vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_HIP]=1
    vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_BACK]=1
    vars.isInitialWeapon[TppDefine.WEAPONSLOT.SECONDARY]=1
  end
  if a.sequence and a.sequence.ALLWAYS_100_PERCENT_FULTON then
    mvars.ply_allways_100percent_fulton=true
  end
  if TppMission.IsMissionStart()then
    local e
    if a.sequence and a.sequence.INITIAL_HAND_EQUIP then
      e=a.sequence.INITIAL_HAND_EQUIP
    end
    if e then
    end
    local e
    if a.sequence and a.sequence.INITIAL_CAMERA_ROTATION then
      e=a.sequence.INITIAL_CAMERA_ROTATION
    end
    if e then
      vars.playerCameraRotation[0]=e[1]
      vars.playerCameraRotation[1]=e[2]
    end
  end
  if gvars.s10240_isPlayedFuneralDemo then
    Player.SetUseBlackDiamondEmblem(true)
  else
    Player.SetUseBlackDiamondEmblem(false)
  end
  local e=0
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    vars.currentItemIndex=e
    vars.initialPlayerAction=PlayerInitialAction.HELI_SPACE
    return
  end
  if TppMission.IsMissionStart()then
    if((vars.missionCode==30010)or(vars.missionCode==30020))and(Player.IsVarsCurrentItemCBox())then
    else
      vars.currentItemIndex=e
    end
  end
  if(gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)and(svars.ply_isUsedPlayerInitialAction==false)then
    local e=i("TppHeli2","SupportHeli")
    if e~=t then
      vars.initialPlayerAction=PlayerInitialAction.FROM_HELI_SPACE
      vars.initialPlayerPairGameObjectId=e
    end
  else
    if TppMission.IsMissionStart()then
      local e
      if a.sequence and a.sequence.MISSION_START_INITIAL_ACTION then
        e=a.sequence.MISSION_START_INITIAL_ACTION
      end
      if e then
        vars.initialPlayerAction=e
      end
    end
  end
  mvars.ply_locationStationTable={}
  mvars.ply_stationLocatorList={}
  local e=TppLocation.GetLocationName()
  if e=="afgh"or e=="mafr"then
    local a=TppDefine.STATION_LIST[e]
    if a and TppCollection.GetUniqueIdByLocatorName then
      for e,a in ipairs(a)do
        local e="col_labl_"..a
        local a="col_stat_"..a
        local t=TppCollection.GetUniqueIdByLocatorName(e)
        mvars.ply_locationStationTable[t]=a
        if TppCollection.RepopCountOperation("GetAt",e)>0 then
          TppCollection.SetValidStation(a)
        end
      end
    end
    local e=TppDefine.STATION_LIST[e]
    if e then
      for a,e in ipairs(e)do
        local e="col_labl_"..e
        table.insert(mvars.ply_stationLocatorList,e)
      end
    end
  end
  TppEffectUtility.SetSandWindEnable(false)
end
function this.SetSelfSubsistenceOnHardMission()--tex reworked SUPERDEBUG:
  local loadout = gvars.subsistenceLoadout
  if TppMission.IsSubsistenceMission() and loadout==0 then
    loadout=1
  end
  if loadout > 0 and loadout < #TppMain.subsistenceLoadouts  then
    this.SetInitWeapons(TppMain.subsistenceLoadouts[loadout])--tex subs loadouts, lua index from 1
  end
  if TppMission.IsSubsistenceMission() then
    this.SetInitItems(TppDefine.CYPR_PLAYER_INITIAL_ITEM_TABLE)
    local playerSettings={handEquip=TppEquip.EQP_HAND_NORMAL}--tex subs settings, moved and broken up from retail which put table straight in regtempplayer
    if gvars.isManualSubsistence==1 then--tex 'pure' profile (currently same as game issub missions)
      playerSettings={partsType=PlayerPartsType.NORMAL,camoType=PlayerCamoType.OLIVEDRAB,handEquip=TppEquip.EQP_HAND_NORMAL,faceEquipId=0}
    end--   
    this.RegisterTemporaryPlayerType(playerSettings)
  end
end
--[[function this.SetSelfSubsistenceOnHardMission()--tex ORIG:
  if TppMission.IsSubsistenceMission()then
    e.SetInitWeapons(TppDefine.CYPR_PLAYER_INITIAL_WEAPON_TABLE)
    e.SetInitItems(TppDefine.CYPR_PLAYER_INITIAL_ITEM_TABLE)
    e.RegisterTemporaryPlayerType{partsType=PlayerPartsType.NORMAL,camoType=PlayerCamoType.OLIVEDRAB,handEquip=TppEquip.EQP_HAND_NORMAL,faceEquipId=0}
  end
end--]]
function this.OnReload()
  e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function this.OnMessage(l,i,t,n,r,o,a)
  Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,l,i,t,n,r,o,a)
end
function this.Update()
  e.UpdateDeliveryWarp()
end
local i={[TppDefine.WEATHER.SUNNY]=0,[TppDefine.WEATHER.CLOUDY]=-10,[TppDefine.WEATHER.RAINY]=-30,[TppDefine.WEATHER.FOGGY]=-50,[TppDefine.WEATHER.SANDSTORM]=-70}
function this.MakeFultonRecoverSucceedRatio(t,a,o,r,l,p)
  local c={[TppMotherBaseManagementConst.SECTION_FUNC_RANK_S]=60,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_A]=50,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_B]=40,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_C]=30,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_D]=20,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_E]=10,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_F]=0,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_NONE]=0}
  local t=a
  local a=0
  local s=100
  local n=0
  n=TppTerminal.DoFuncByFultonTypeSwitch(t,o,r,l,nil,nil,e.GetSoldierFultonSucceedRatio,e.GetVolginFultonSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio,e.GetDefaultSucceedRatio)
  if n==nil then
    n=100
  end
  local e=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_FULTON}
  local o=c[e]or 0
  local e=i[vars.weather]or 0
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
  if p then
    Player.SetDogFultonIconPercentage{percentage=a,targetId=t}
  else
    Player.SetFultonIconPercentage{percentage=a,targetId=t}
  end
end
function this.GetSoldierFultonSucceedRatio(a)
  local e=0
  local n=0
  local t=o(a,{id="GetLifeStatus"})
  local r=GameObject.SendCommand(a,{id="GetStateFlag"})
  if(bit.band(r,StateFlag.DYING_LIFE)~=0)then
    e=-70
  elseif(t==TppGameObject.NPC_LIFE_STATE_SLEEP)or(t==TppGameObject.NPC_LIFE_STATE_FAINT)then
    e=0
    if mvars.ply_OnFultonIconDying then
      mvars.ply_OnFultonIconDying()
    end
  elseif(t==TppGameObject.NPC_LIFE_STATE_DEAD)then
    return
  end
  local r={
    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_S]=60,
    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_A]=50,
    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_B]=40,
    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_C]=30,
    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_D]=20,
    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_E]=10,
    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_F]=0,
    [TppMotherBaseManagementConst.SECTION_FUNC_RANK_NONE]=0
  }
  local t=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_MEDICAL_STAFF_EMERGENCY}
  local t=r[t]or 0
  e=e+t
  if e>0 then
    e=0
  end
  local a=o(a,{id="GetStatus"})
  if a==EnemyState.STAND_HOLDUP then
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
function this.SetHelicopterInsideAction()
  Player.SetHeliToInsideParam{canClearMission=svars.mis_canMissionClear}
end
function this.OnPlayerFulton(e,n)
  if e~=PlayerInfo.GetLocalPlayerIndex()then
    return
  end
  local o=300
  local a=1e4
  local e=1e4
  local t=5e3
  local t={[TppGameObject.GAME_OBJECT_TYPE_WALKERGEAR2]=a,[TppGameObject.GAME_OBJECT_TYPE_COMMON_WALKERGEAR2]=a,[TppGameObject.GAME_OBJECT_TYPE_BATTLEGEAR]=a,[TppGameObject.GAME_OBJECT_TYPE_VEHICLE]=e,[TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER]=e,[TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN]=e,[TppGameObject.GAME_OBJECT_TYPE_MORTAR]=t,[TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN]=t}
  local e
  local a=GameObject.GetTypeIndex(n)e=t[a]or o
  TppTerminal.UpdateGMP{gmp=-e,gmpCostType=TppDefine.GMP_COST_TYPE.FULTON}
  svars.supportGmpCost=svars.supportGmpCost+e
end
function this.QuietRideHeli(e)
  if e==GameObject.GetGameObjectIdByIndex("TppBuddyQuiet2",0)then
    Player.RequestToPlayCameraNonAnimation{characterId=e,isFollowPos=false,isFollowRot=false,followTime=1,followDelayTime=.1,candidateRots={{-4,45},{-4,-45},{-8,0}},offsetPos=Vector3(0,-.2,-2.5),offsetTarget=Vector3(0,2,0),focalLength=21,aperture=1.875,timeToSleep=2,enableOverride=true}
  end
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
function this.OnPickUpCollection(r,n,a,i)
  local r=255
  TppCollection.RepopCountOperation("SetAt",n,r)
  TppTerminal.AddPickedUpResourceToTempBuffer(a,i)
  local r={
  [TppCollection.TYPE_POSTER_SOL_AFGN]="key_poster_3500",
  [TppCollection.TYPE_POSTER_SOL_MAFR]="key_poster_3501",
  [TppCollection.TYPE_POSTER_GRAVURE_V]="key_poster_3502",
  [TppCollection.TYPE_POSTER_GRAVURE_H]="key_poster_3503",
  [TppCollection.TYPE_POSTER_MOE_V]="key_poster_3504",
  [TppCollection.TYPE_POSTER_MOE_H]="key_poster_3505"}
  local r=r[a]
  if r~=nil then
    TppUI.ShowAnnounceLog("getPoster",r,TppTerminal.GMP_POSTER)
  end
  local r
  if TppTerminal.RESOURCE_INFORMATION_TABLE[a]and TppTerminal.RESOURCE_INFORMATION_TABLE[a].count then
    r=TppTerminal.RESOURCE_INFORMATION_TABLE[a].count
  end
  if TppCollection.IsHerbByType(a)then
    local e=GameObject.GetGameObjectIdByIndex("TppBuddyDog2",0)
    if e~=t then
      o(e,{id="GetPlant",uniqueId=n})
    end
  end
  if TppCollection.IsMaterialByType(a)then
    TppUI.ShowAnnounceLog("find_processed_res",i,r)
  end
  if a==TppCollection.TYPE_DIAMOND_SMALL then
    TppUI.ShowAnnounceLog("find_diamond",TppDefine.SMALL_DIAMOND_GMP)
  end
  if a==TppCollection.TYPE_DIAMOND_LARGE then
    TppUI.ShowAnnounceLog("find_diamond",TppDefine.LARGE_DIAMOND_GMP)
  end
  local a=mvars.ply_locationStationTable[n]
  if a then
    TppUI.ShowAnnounceLog"get_invoice"
    TppUI.ShowAnnounceLog"add_delivery_point"
    TppCollection.SetValidStation(a)
    e.CheckAllStationPickedUp()
  end
  TppTerminal.PickUpBluePrint(n)
  TppTerminal.PickUpEmblem(n)
end
function this.CheckAllStationPickedUp()
  local e=true
  for t,a in ipairs(mvars.ply_stationLocatorList)do
    local a=TppCollection.RepopCountOperation("GetAt",a)
    if a then
      if a<1 then
        e=false
        break
      end
    end
  end
  if e then
    TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3011,isShowAnnounceLog=true}
    if TppLocation.IsAfghan()then
      gvars.ply_isAllGotStation_Afgh=true
    elseif TppLocation.IsMiddleAfrica()then
      gvars.ply_isAllGotStation_Mafr=true
    end
    if gvars.ply_isAllGotStation_Afgh and gvars.ply_isAllGotStation_Mafr then
      TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3012,isShowAnnounceLog=true}
    end
  end
end
function this.OnPickUpPlaced(e,e,a)
  local e=GameObject.GetGameObjectIdByIndex("TppBuddyDog2",0)
  if e~=t then
    o(e,{id="GetPlacedItem",index=a})
  end
end
function this.OnPickUpWeapon(t,a,e)
  if a==TppEquip.EQP_IT_Cassette then
    TppCassette.AcquireOnPickUp(e)
  end
end
function this.RestoreSupplyCbox()
  if e.IsExistSupplyCboxSystem()then
    local e={type="TppSupplyCboxSystem"}
    o(e,{id="RestoreRequest"})
  end
end
function this.StoreSupplyCbox()
  if e.IsExistSupplyCboxSystem()then
    local e={type="TppSupplyCboxSystem"}
    o(e,{id="StoreRequest"})
  end
end
function this.IsExistSupplyCboxSystem()
  if GameObject.GetGameObjectIdByIndex("TppSupplyCboxSystem",0)~=t then
    return true
  else
    return false
  end
end
function this.RestoreSupportAttack()
  if e.IsExistSupportAttackSystem()then
    local e={type="TppSupportAttackSystem"}
    o(e,{id="RestoreRequest"})
  end
end
function this.StoreSupportAttack()
  if e.IsExistSupportAttackSystem()then
    local e={type="TppSupportAttackSystem"}
    o(e,{id="StoreRequest"})
  end
end
function this.IsExistSupportAttackSystem()
  if GameObject.GetGameObjectIdByIndex("TppSupportAttackSystem",0)~=t then
    return true
  else
    return false
  end
end
function this.StorePlayerDecoyInfos()
  if e.IsExistDecoySystem()then
    local e={type="TppDecoySystem"}
    o(e,{id="StorePlayerDecoyInfos"})
  end
end
function this.IsExistDecoySystem()
  if GameObject.GetGameObjectIdByIndex("TppDecoySystem",0)~=t then
    return true
  else
    return false
  end
end
local t=7.5
local a=3.5
e.DELIVERY_WARP_STATE=Tpp.Enum{"START_FADE_OUT","START_WARP","END_WARP","START_FADE_IN"}
function this.OnSelectCboxDelivery(a)
  Player.SetPadMask{settingName="CboxDelivery",except=true}
  mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.START_FADE_OUT
  mvars.ply_selectedCboxDeliveryUniqueId=a
  mvars.ply_playingDeliveryWarpSoundHandle=TppSoundDaemon.PostEventAndGetHandle("Play_truck_transfer","Loading")
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"OnSelectCboxDelivery",nil,{setMute=true})
end
function this.WarpByCboxDelivery()
  if not mvars.ply_selectedCboxDeliveryUniqueId then
    return
  end
  TppGameStatus.Set("TppPlayer.WarpByCboxDelivery","S_IS_BLACK_LOADING")
  if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
    TppQuest.DeactivateCurrentQuestBlock()
    TppQuest.ClearBlockStateRequest()
  end
  mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.START_WARP
  r("Timer_DeliveryWarpSoundCannotCancel",t)
  local e={type="TppPlayer2",index=0}
  local a={id="WarpToStation",stationId=mvars.ply_selectedCboxDeliveryUniqueId}
  GameObject.SendCommand(e,a)
end
function this.OnEndWarpByCboxDelivery()
  if mvars.ply_deliveryWarpState==e.DELIVERY_WARP_STATE.START_WARP then
    mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.END_WARP
  end
end
function this.OnDeliveryWarpSoundCannotCancel()
  mvars.ply_deliveryWarpSoundCannotCancel=true
end
function this.UpdateDeliveryWarp()
  if not mvars.ply_deliveryWarpState then
    return
  end
  if(mvars.ply_deliveryWarpState==e.DELIVERY_WARP_STATE.START_WARP)then
    TppUI.ShowAccessIconContinue()
  end
  if(mvars.ply_deliveryWarpState~=e.DELIVERY_WARP_STATE.END_WARP)then
    return
  end
  if not TppMission.CheckMissionState()then
    mvars.ply_playingDeliveryWarpSoundHandle=nil
    mvars.ply_selectedCboxDeliveryUniqueId=nil
    mvars.ply_deliveryWarpState=nil
    mvars.ply_deliveryWarpSoundCannotCancel=nil
    TppSoundDaemon.PostEventAndGetHandle("Stop_truck_transfer","Loading")p"Timer_DeliveryWarpSoundCannotCancel"
    return
  end
  if mvars.ply_playingDeliveryWarpSoundHandle then
    local e=TppSoundDaemon.IsEventPlaying("Play_truck_transfer",mvars.ply_playingDeliveryWarpSoundHandle)
    if(e==false)then
      TppSoundDaemon.ResetMute"Loading"
      mvars.ply_playingDeliveryWarpSoundHandle=nil
    else
      TppUI.ShowAccessIconContinue()
    end
  end
  if(mvars.ply_playingDeliveryWarpSoundHandle and(not mvars.ply_deliveryWarpSoundCannotCancel))and(bit.band(PlayerVars.scannedButtonsDirect,PlayerPad.STANCE)==PlayerPad.STANCE)then
    mvars.ply_deliveryWarpSoundCannotCancel=true
    TppSoundDaemon.ResetMute"Loading"TppSoundDaemon.PostEventAndGetHandle("Stop_truck_transfer","Loading")
  end
  if(not mvars.ply_playingDeliveryWarpSoundHandle)then
    mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.START_FADE_IN
    TppSoundDaemon.ResetMute"Loading"
    TppGameStatus.Reset("TppPlayer.WarpByCboxDelivery","S_IS_BLACK_LOADING")
    if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
      TppQuest.InitializeQuestLoad()
      TppQuest.InitializeQuestActiveStatus()
    end
    TppMission.ExecuteSystemCallback("OnEndDeliveryWarp",mvars.ply_selectedCboxDeliveryUniqueId)
    TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMAL,"OnEndWarpByCboxDelivery")
  end
end
function this.OnEndFadeInWarpByCboxDelivery()
  mvars.ply_selectedCboxDeliveryUniqueId=nil
  mvars.ply_deliveryWarpState=nil
  mvars.ply_deliveryWarpSoundCannotCancel=nil
  p"Timer_DeliveryWarpSoundCannotCancel"
  Player.ResetPadMask{settingName="CboxDelivery"}
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
  e.ShowIconForIntel(a)
end
function this.OnExitIntelTrap(a,a)
  e.HideIconForIntel()
end
function this.OnIntelIconDisplayContinue(a,t,t)
  local a=mvars.ply_intelNameReverse[a]
  e.ShowIconForIntel(a)
end
function this.OnEnterQuestTrap(a,t)
  local a=mvars.ply_questStartTrapInfo[a]
  e.ShowIconForQuest(a)
  local e=mvars.ply_questStartFlagInfo[a]
  if e~=nil and e==false then
    TppSoundDaemon.PostEvent"sfx_s_ifb_mbox_arrival"
  end
end
function this.OnExitQuestTrap(a,a)
  e.HideIconForQuest()
end
function this.OnQuestIconDisplayContinue(a,t,t)
  local a=mvars.ply_questNameReverse[a]
  e.ShowIconForQuest(a)
end
function this.UpdateCheckPointOnMissionStartDrop()
  if not TppSequence.IsHelicopterStart()then
    return
  end
  if TppMission.IsEmergencyMission()then
    return
  end
  if not mvars.ply_doneUpdateCheckPointOnMissionStartDrop then
    TppMission.UpdateCheckPointAtCurrentPosition()
    mvars.ply_doneUpdateCheckPointOnMissionStartDrop=true
  end
end
function this.IsAlreadyDropped()
  return mvars.ply_doneUpdateCheckPointOnMissionStartDrop
end
function this.SaveCaptureAnimal()
  if mvars.loc_locationAnimalSettingTable==nil then
    return
  end
  local a=TppPlaced.GetCaptureCageInfo()
  for t,a in pairs(a)do
    local a,e,t,t=e.EvaluateCaptureCage(a.x,a.z,a.grade,a.material)
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
    local o,n=TppMotherBaseManagement.GetAnimalHeroicPointAndGmp{dataBaseId=t}e=e+o
    a=a+n
    TppUiCommand.ShowBonusPopupAnimal(t,"regist")
  end
  if e>0 or a>0 then
    TppMotherBaseManagement.AddHeroicPointAndGmpByCageAnimal{heroicPoint=e,gmp=a,isAnnounce=true}
  end
end
function this.CheckCaptureCage(n,o)
  if mvars.loc_locationAnimalSettingTable==nil then
    return
  end
  if n<2 or n>4 then
    return
  end
  local t={}
  local a=5
  local r=o/a
  for o=1,r do
    if n==2 then
      Player.DEBUG_PlaceAround{radius=5,count=a,equipId=TppEquip.EQP_SWP_CaptureCage}
    elseif n==3 then
      Player.DEBUG_PlaceAround{radius=5,count=a,equipId=TppEquip.EQP_SWP_CaptureCage_G01}
    elseif n==4 then
      Player.DEBUG_PlaceAround{radius=5,count=a,equipId=TppEquip.EQP_SWP_CaptureCage_G02}
    end
    for e=1,a do
      coroutine.yield()
    end
    local a=TppPlaced.GetCaptureCageInfo()
    for n,a in pairs(a)do
      local n,a,o,e=e.EvaluateCaptureCage(a.x,a.z,a.grade,a.material)
      if a~=0 then
        TppMotherBaseManagement.DirectAddDataBaseAnimal{dataBaseId=a,areaName=n,isNew=true}
        if t[e]==nil then
          t[e]=1
        else
          t[e]=t[e]+1
        end
      end
    end
    TppPlaced.DeleteAllCaptureCage()
  end
  for a,e in pairs(t)do
    local e=(e/o)*100
  end
end
function this.GetCaptureAnimalSE(a)
  local e="sfx_s_captured_nom"
  local t=mvars.loc_locationAnimalSettingTable
  if t==nil then
    return e
  end
  local t=t.animalRareLevel
  if t[a]==nil then
    return e
  end
  local a=t[a]
  if a==TppMotherBaseManagementConst.ANIMAL_RARE_SR then
    e="sfx_s_captured_super"
  elseif a==TppMotherBaseManagementConst.ANIMAL_RARE_R then
    e="sfx_s_captured_rare"
  else
    e="sfx_s_captured_nom"
  end
  return e
end
function this._IsStartStatusValid(a)
  if(e.StartStatusList[a]==nil)then
    return false
  end
  return true
end
function this._IsAbilityNameValid(a)
  if(e.DisableAbilityList[a]==nil)then
    return false
  end
  return true
end
function this._IsControlModeValid(a)
  if(e.ControlModeList[a]==nil)then
    return false
  end
  return true
end
function this._CheckRotation(a,n,o,r,e)
  local e=mvars
  local e=vars.playerCameraRotation[0]
  local t=vars.playerCameraRotation[1]
  local e=foxmath.DegreeToRadian(e-a)e=foxmath.NormalizeRadian(e)
  local a=foxmath.RadianToDegree(e)
  local e=foxmath.DegreeToRadian(t-o)e=foxmath.NormalizeRadian(e)
  local e=foxmath.RadianToDegree(e)
  if(foxmath.Absf(a)<n)and(foxmath.Absf(e)<r)then
    return true
  else
    return false
  end
end
local function n(t)
  local n=math.random(0,99)
  local e=0
  local a=-1
  for o,t in pairs(t)do
    e=e+t[2]
    if n<e then
      a=t[1]break
    end
  end
  return a
end
local function p(e,a)
  for t,e in pairs(e)do
    if e==a then
      return true
    end
  end
  return false
end
function this.EvaluateCaptureCage(i,a,r,c)
  local t=mvars
  local o=t.loc_locationAnimalSettingTable
  local l=o.captureCageAnimalAreaSetting
  local t="wholeArea"
  for n,e in pairs(l)do
    if((i>=e.activeArea[1]and i<=e.activeArea[3])and a>=e.activeArea[2])and a<=e.activeArea[4]then
      t=e.areaName
      break
    end
  end
  local a=0
  if r==2 then
    a=n(e.CageRandomTableG3)
  elseif r==1 then
    a=n(e.CageRandomTableG2)
  else
    a=n(e.CageRandomTableG1)
  end
  local e=o.captureAnimalList
  local l=o.animalRareLevel
  local s=o.animalInfoList
  local n={}
  if e[t]==nil then
    t="wholeArea"
  end
  local i=false
  for t,e in pairs(e[t])do
    local t=l[e]
    if t>=TppMotherBaseManagementConst.ANIMAL_RARE_SR and r==2 then
      if not TppMotherBaseManagement.IsGotDataBase{dataBaseId=e}then
        table.insert(n,e)a=t
        i=true
        break
      end
    end
  end
  if not i then
    local o=a
    while a>=0 do
      for t,e in pairs(e[t])do
        if l[e]==a then
          table.insert(n,e)
        end
      end
      if table.maxn(n)>0 then
        break
      end
      a=a-1
    end
    if a<0 then
      a=o
      t="wholeArea"
      while a>=0 do
        for t,e in pairs(e[t])do
          if l[e]==a then
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
  local i=o.animalMaterial
  local r={}
  local o=a
  if i~=nil then
    while o>=0 do
      for a,e in pairs(e.wholeArea)do
        if i[e]==nil and l[e]==o then
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
  local l=table.maxn(n)
  if l==1 then
    e=n[1]
  elseif l>1 then
    local a=math.random(1,l)
    e=n[a]
  end
  if#r==0 then
    local n=""
    return t,e,a,n
  end
  if i~=nil then
    local t=i[e]
    if t~=nil then
      if p(t,c)==false then
        local t=math.random(1,#r)
        e=r[t]a=o
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
function this.Refresh(e)
  if e then
    Player.ResetDirtyEffect()
  end
  vars.passageSecondsSinceOutMB=0
end
return this
