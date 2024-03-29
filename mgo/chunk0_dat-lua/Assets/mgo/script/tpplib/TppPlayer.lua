local e={}
local s=Tpp.IsTypeFunc
local t=Tpp.IsTypeTable
local l=Tpp.IsTypeString
local a=Fox.StrCode32
local o=GkEventTimerManager.Start
local m=GkEventTimerManager.Stop
local n=GameObject.GetTypeIndex
local i=GameObject.GetGameObjectId
local d=GameObject.GetTypeIndexWithTypeName
local n=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2
local n=TppGameObject.GAME_OBJECT_TYPE_HOSTAGE2
local n=GameObject.NULL_ID
local r=GameObject.SendCommand
e.MISSION_CLEAR_CAMERA_FADE_DELAY_TIME=3
e.MISSION_CLEAR_CAMERA_DELAY_TIME=0
e.PLAYER_FALL_DEAD_DELAY_TIME=.2
e.DisableAbilityList={Stand="DIS_ACT_STAND",Squat="DIS_ACT_SQUAT",Crawl="DIS_ACT_CRAWL",Dash="DIS_ACT_DASH"}
e.ControlModeList={LockPadMode="All",LockMBTerminalOpenCloseMode="MB_Disable",MBTerminalOnlyMode="MB_OnlyMode"}
e.CageRandomTableG1={{1,20},{0,80}}
e.CageRandomTableG2={{2,15},{1,20},{0,65}}
e.CageRandomTableG3={{4,5},{3,10},{2,15},{1,20},{0,50}}
e.RareLevelList={"N","NR","R","SR","SSR"}
function e.RegisterCallbacks(e)
if s(e.OnFultonIconDying)then
mvars.ply_OnFultonIconDying=e.OnFultonIconDying
end
end
function e.SetStartStatus(e)
if(e>TppDefine.INITIAL_PLAYER_STATE.MIN)and(e<TppDefine.INITIAL_PLAYER_STATE.MAX)then
gvars.ply_initialPlayerState=e
end
end
function e.SetStartStatusRideOnHelicopter()
e.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)
e.ResetInitialPosition()
e.ResetMissionStartPosition()
end
function e.ResetDisableAction()
vars.playerDisableActionFlag=PlayerDisableAction.NONE
end
function e.GetPosition()
return{vars.playerPosX,vars.playerPosY,vars.playerPosZ}
end
function e.GetRotation()
return vars.playerRotY
end
function e.Warp(e)
if not t(e)then
return
end
local n=e.pos
if not t(n)or(#n~=3)then
return
end
local t=foxmath.NormalizeRadian(foxmath.DegreeToRadian(e.rotY or 0))
local a
if e.fobRespawn==true then
a={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}
else
a={type="TppPlayer2",index=0}
end
local e={id="WarpAndWaitBlock",pos=n,rotY=t}
GameObject.SendCommand(a,e)
end
function e.SetForceFultonPercent(a,e)
if not Tpp.IsTypeNumber(a)then
return
end
if not Tpp.IsTypeNumber(e)then
return
end
if(a<0)or(a>=n)then
return
end
if(e<0)or(e>100)then
return
end
mvars.ply_forceFultonPercent=mvars.ply_forceFultonPercent or{}
mvars.ply_forceFultonPercent[a]=e
end
function e.ForceChangePlayerToSnake(e)
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
function e.CheckRotationSetting(a)
if not t(a)then
return
end
local e=mvars
e.ply_checkDirectionList={}
e.ply_checkRotationResult={}
local function n(t,a,e)
if e>=-180 and e<180 then
t[a]=e
end
end
for t,a in pairs(a)do
if s(a.func)then
e.ply_checkDirectionList[t]={}
e.ply_checkDirectionList[t].func=a.func
local i=a.directionX or 0
local r=a.directionY or 0
local o=a.directionRangeX or 0
local a=a.directionRangeY or 0
n(e.ply_checkDirectionList[t],"directionX",i)n(e.ply_checkDirectionList[t],"directionY",r)n(e.ply_checkDirectionList[t],"directionRangeX",o)n(e.ply_checkDirectionList[t],"directionRangeY",a)
else
return
end
end
end
function e.CheckRotation()
local a=mvars
if a.ply_checkDirectionList==nil then
return
end
for t,n in pairs(a.ply_checkDirectionList)do
local e=e._CheckRotation(n.directionX,n.directionRangeX,n.directionY,n.directionRangeY,t)
if e~=a.ply_checkRotationResult[t]then
a.ply_checkRotationResult[t]=e
a.ply_checkDirectionList[t].func(e)
end
end
end
function e.IsDeliveryWarping()
if mvars.ply_deliveryWarpState then
return true
else
return false
end
end
function e.GetStationUniqueId(e)
if not l(e)then
return
end
local e="col_stat_"..e
return TppCollection.GetUniqueIdByLocatorName(e)
end
function e.SetMissionStartPositionToCurrentPosition()
gvars.ply_useMissionStartPos=true
gvars.ply_missionStartPos[0]=vars.playerPosX
gvars.ply_missionStartPos[1]=vars.playerPosY+.5
gvars.ply_missionStartPos[2]=vars.playerPosZ
gvars.ply_missionStartRot=vars.playerRotY
gvars.mis_orderBoxName=0
e.SetInitialPositionFromMissionStartPosition()
end
function e.SetNoOrderBoxMissionStartPosition(e,a)
gvars.ply_useMissionStartPosForNoOrderBox=true
gvars.ply_missionStartPosForNoOrderBox[0]=e[1]
gvars.ply_missionStartPosForNoOrderBox[1]=e[2]
gvars.ply_missionStartPosForNoOrderBox[2]=e[3]
gvars.ply_missionStartRotForNoOrderBox=a
end
function e.SetNoOrderBoxMissionStartPositionToCurrentPosition()
gvars.ply_useMissionStartPosForNoOrderBox=true
gvars.ply_missionStartPosForNoOrderBox[0]=vars.playerPosX
gvars.ply_missionStartPosForNoOrderBox[1]=vars.playerPosY+.5
gvars.ply_missionStartPosForNoOrderBox[2]=vars.playerPosZ
gvars.ply_missionStartRotForNoOrderBox=vars.playerRotY
end
function e.SetMissionStartPosition(e,a)
gvars.ply_useMissionStartPos=true
gvars.ply_missionStartPos[0]=e[1]
gvars.ply_missionStartPos[1]=e[2]
gvars.ply_missionStartPos[2]=e[3]
gvars.ply_missionStartRot=a
end
function e.ResetMissionStartPosition()
gvars.ply_useMissionStartPos=false
gvars.ply_missionStartPos[0]=0
gvars.ply_missionStartPos[1]=0
gvars.ply_missionStartPos[2]=0
gvars.ply_missionStartRot=0
end
function e.ResetNoOrderBoxMissionStartPosition()
gvars.ply_useMissionStartPosForNoOrderBox=false
gvars.ply_missionStartPosForNoOrderBox[0]=0
gvars.ply_missionStartPosForNoOrderBox[1]=0
gvars.ply_missionStartPosForNoOrderBox[2]=0
gvars.ply_missionStartRotForNoOrderBox=0
end
function e.SetMissionStartPositionFromNoOrderBoxPosition()
if gvars.ply_useMissionStartPosForNoOrderBox then
gvars.ply_useMissionStartPos=true
gvars.ply_missionStartPos[0]=gvars.ply_missionStartPosForNoOrderBox[0]
gvars.ply_missionStartPos[1]=gvars.ply_missionStartPosForNoOrderBox[1]
gvars.ply_missionStartPos[2]=gvars.ply_missionStartPosForNoOrderBox[2]
gvars.ply_missionStartRot=gvars.ply_missionStartRotForNoOrderBox
e.ResetNoOrderBoxMissionStartPosition()
end
end
function e.DEBUG_CheckNearMissionStartPositionToRealizePosition()
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
function e.SetInitialPositionToCurrentPosition()
vars.initialPlayerFlag=PlayerFlag.USE_VARS_FOR_INITIAL_POS
vars.initialPlayerPosX=vars.playerPosX
vars.initialPlayerPosY=vars.playerPosY+.5
vars.initialPlayerPosZ=vars.playerPosZ
vars.initialPlayerRotY=vars.playerRotY
end
function e.SetInitialPosition(e,a)
vars.initialPlayerFlag=PlayerFlag.USE_VARS_FOR_INITIAL_POS
vars.initialPlayerPosX=e[1]
vars.initialPlayerPosY=e[2]
vars.initialPlayerPosZ=e[3]
vars.initialPlayerRotY=a
end
function e.SetInitialPositionFromMissionStartPosition()
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
function e.ResetInitialPosition()
vars.initialPlayerFlag=0
vars.initialPlayerPosX=0
vars.initialPlayerPosY=0
vars.initialPlayerPosZ=0
vars.initialPlayerRotY=0
end
function e.RegisterTemporaryPlayerType(e)
if not t(e)then
return
end
mvars.ply_isExistTempPlayerType=true
local n=e.camoType
local r=e.partsType
local t=e.playerType
local a=e.handEquip
local e=e.faceEquipId
if r then
mvars.ply_tempPartsType=r
end
if n then
mvars.ply_tempCamoType=n
end
if t then
mvars.ply_tempPlayerType=t
end
if a then
mvars.ply_tempPlayerHandEquip=a
end
if e then
mvars.ply_tempPlayerFaceEquipId=e
end
end
function e.SaveCurrentPlayerType()
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
function e.ApplyTemporaryPlayerType()
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
function e.RestoreTemporaryPlayerType()
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
function e.SetWeapons(a)
e._SetWeapons(a,"weapons")
end
function e.SetInitWeapons(a)
if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
e.SaveWeaponsToUsingTemp(a)
end
e._SetWeapons(a,"initWeapons")
end
function e._SetWeapons(l,i)
if not t(l)then
return
end
local t=TppDefine.WEAPONSLOT.SUPPORT_0-1
local a,s,o,n,r
for p,l in pairs(l)do
a,t,s,o,n,r=e.GetWeaponSlotInfoFromWeaponSet(l,t)
local e=TppEquip[s]
if e==nil then
else
local l,p,s,c,d,m=TppEquip.GetAmmoInfo(e)
if a then
vars[i][a]=e
local e,t
if o then
e=o*p
elseif n then
e=n
else
e=s
end
gvars.initAmmoStockIds[a]=l
gvars.initAmmoStockCounts[a]=e
gvars.initAmmoInWeapons[a]=p
if(c~=TppEquip.BL_None)then
if r then
t=r
else
t=m
end
gvars.initAmmoStockIds[a+TppDefine.WEAPONSLOT.MAX]=c
gvars.initAmmoStockCounts[a+TppDefine.WEAPONSLOT.MAX]=t
gvars.initAmmoSubInWeapons[a]=d
end
if i=="initWeapons"then
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
function e.GetWeaponSlotInfoFromWeaponSet(e,o)
local r,a,n,t,i
if e.primaryHip then
r=TppDefine.WEAPONSLOT.PRIMARY_HIP
a=e.primaryHip
n=e.magazine
t=e.ammo
i=e.underBarrelAmmo
elseif e.primaryBack then
r=TppDefine.WEAPONSLOT.PRIMARY_BACK
a=e.primaryBack
n=e.magazine
t=e.ammo
elseif e.secondary then
r=TppDefine.WEAPONSLOT.SECONDARY
a=e.secondary
n=e.magazine
t=e.ammo
elseif e.support then
o=o+1
a=e.support
t=e.ammo
end
return r,o,a,n,t,i
end
function e.SaveWeaponsToUsingTemp(n)
if gvars.ply_isUsingTempWeapons then
return
end
if not t(n)then
return
end
for e=0,11 do
gvars.ply_lastWeaponsUsingTemp[e]=TppEquip.EQP_None
end
local t
local a=TppDefine.WEAPONSLOT.SUPPORT_0-1
for r,n in pairs(n)do
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
function e.RestoreWeaponsFromUsingTemp()
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
local r,o,n,t,l,i=TppEquip.GetAmmoInfo(gvars.ply_lastWeaponsUsingTemp[a])
e.SupplyAmmoByBulletId(r,n)
gvars.initAmmoInWeapons[a]=o
e.SupplyAmmoByBulletId(t,i)
gvars.initAmmoSubInWeapons[a]=l
end
end
for e=0,11 do
gvars.ply_lastWeaponsUsingTemp[e]=TppEquip.EQP_None
end
gvars.ply_isUsingTempWeapons=false
return true
end
function e.SetItems(a)
if not t(a)then
return
end
for t,a in ipairs(a)do
if TppEquip[a]==nil then
return
end
end
e._SetItems(a,"items")
end
function e.SetInitItems(a)
if not t(a)then
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
function e._SetItems(a,e)vars[e][0]=TppEquip.EQP_None
for t,a in pairs(a)do
vars[e][t]=TppEquip[a]
end
end
function e.SaveItemsToUsingTemp(e)
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
function e.RestoreItemsFromUsingTemp()
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
function e.InitItemStockCount()
if TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT==nil then
return
end
for e=AmmoStockIndex.ITEM,AmmoStockIndex.ITEM_END-1 do
vars.ammoStockIds[e]=0
vars.ammoStockCounts[e]=0
end
end
function e.GetBulletNum(e)
for a=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
if(e~=nil and e==vars.ammoStockIds[a])then
return vars.ammoStockCounts[a]
end
end
return 0
end
function e.SavePlayerCurrentWeapons()
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
function e.RestorePlayerWeaponsOnMissionStart()
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
function e.SaveChimeraWeaponParameter()
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
function e.RestoreChimeraWeaponParameter()
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
function e.SavePlayerCurrentItems()
for e=0,7 do
vars.initItems[e]=vars.items[e]
end
end
function e.RestorePlayerItemsOnMissionStart()
for e=0,7 do
vars.items[e]=vars.initItems[e]
end
end
function e.ForceSetAllInitialWeapon()
vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_HIP]=1
vars.isInitialWeapon[TppDefine.WEAPONSLOT.PRIMARY_BACK]=1
vars.isInitialWeapon[TppDefine.WEAPONSLOT.SECONDARY]=1
end
function e.SupplyAllAmmoFullOnMissionFinalize()
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
function e.SupplyWeaponAmmoFull(a)
local t=vars.initWeapons[a]
if t==TppEquip.EQP_None then
return
end
local l,n,r,i,o,t=TppEquip.GetAmmoInfo(t)
e.SupplyAmmoByBulletId(l,r)
gvars.initAmmoInWeapons[a]=n
e.SupplyAmmoByBulletId(i,t)
gvars.initAmmoSubInWeapons[a]=o
end
function e.SupplySupportWeaponAmmoFull(a)
local a,n,t,n,n,n=TppEquip.GetAmmoInfo(a)
e.SupplyAmmoByBulletId(a,t)
end
function e.SupplyAmmoByBulletId(t,n)
if t==TppEquip.BL_None then
return
end
local e
for a=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
if gvars.initAmmoStockIds[a]==t then
e=a
break
end
end
if not e then
for a=0,TppScriptVars.PLAYER_AMMO_STOCK_TYPE_COUNT-1 do
if gvars.initAmmoStockIds[a]==TppEquip.BL_None then
gvars.initAmmoStockIds[a]=t
e=a
break
end
end
end
if not e then
return
end
gvars.initAmmoStockCounts[e]=n
end
function e.SavePlayerCurrentAmmoCount()
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
function e.SetMissionStartAmmoCount()
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
function e.SetEquipMissionBlockGroupSize()
local e=mvars.ply_equipMissionBlockGroupSize
if e>0 then
TppEquip.CreateEquipMissionBlockGroup{size=e}
end
end
function e.SetMaxPickableLocatorCount()
if mvars.ply_maxPickableLocatorCount>0 then
TppPickable.OnAllocate{locators=mvars.ply_maxPickableLocatorCount,svarsName="ply_pickableLocatorDisabled"}
end
end
function e.SetMaxPlacedLocatorCount()
if mvars.ply_maxPlacedLocatorCount>0 then
TppPlaced.OnAllocate{locators=mvars.ply_maxPlacedLocatorCount,svarsName="ply_placedLocatorDisabled"}
end
end
function e.IsDecoy(e)
local e=TppEquip.GetSupportWeaponTypeId(e)
local a={[TppEquip.SWP_TYPE_Decoy]=true,[TppEquip.SWP_TYPE_ActiveDecoy]=true,[TppEquip.SWP_TYPE_ShockDecoy]=true}
if a[e]then
return true
else
return false
end
end
function e.IsMine(e)
local a=TppEquip.GetSupportWeaponTypeId(e)
local e={[TppEquip.SWP_TYPE_DMine]=true,[TppEquip.SWP_TYPE_SleepingGusMine]=true,[TppEquip.SWP_TYPE_AntitankMine]=true,[TppEquip.SWP_TYPE_ElectromagneticNetMine]=true}
if e[a]then
return true
else
return false
end
end
function e.AddTrapSettingForIntel(t)
local n=t.trapName
local s=t.direction or 0
local p=t.directionRange or 60
local e=t.intelName
local m=t.autoIcon
local o=t.gotFlagName
local r=t.markerTrapName
local i=t.markerObjectiveName
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
if o then
mvars.ply_intelFlagInfo[e]=o
mvars.ply_intelFlagInfo[a(e)]=o
mvars.ply_intelTrapInfo[e].gotFlagName=o
end
mvars.ply_intelMarkerObjectiveName=mvars.ply_intelMarkerObjectiveName or{}
if i then
mvars.ply_intelMarkerObjectiveName[e]=i
mvars.ply_intelMarkerObjectiveName[a(e)]=i
mvars.ply_intelTrapInfo[e].markerObjectiveName=i
end
mvars.ply_intelMarkerTrapList=mvars.ply_intelMarkerTrapList or{}
mvars.ply_intelMarkerTrapInfo=mvars.ply_intelMarkerTrapInfo or{}
if r then
table.insert(mvars.ply_intelMarkerTrapList,r)
mvars.ply_intelMarkerTrapInfo[a(r)]=e
mvars.ply_intelTrapInfo[e].markerTrapName=r
end
mvars.ply_intelTrapList=mvars.ply_intelTrapList or{}
if m then
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
function e.ShowIconForIntel(e,t)
if not l(e)then
return
end
local n
if mvars.ply_intelTrapInfo and mvars.ply_intelTrapInfo[e]then
n=mvars.ply_intelTrapInfo[e].trapName
end
local a=mvars.ply_intelFlagInfo[e]
if a then
if svars[a]~=nil then
t=svars[a]
end
end
if not t then
if Tpp.IsNotAlert()then
Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL,message=Fox.StrCode32"GetIntel",messageInDisplay=Fox.StrCode32"IntelIconInDisplay",messageArg=e}
elseif n then
Player.RequestToShowIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL_NG,message=Fox.StrCode32"NGIntel",messageInDisplay=Fox.StrCode32"IntelIconInDisplay",messageArg=e}
if not TppRadio.IsPlayed(TppRadio.COMMON_RADIO_LIST[TppDefine.COMMON_RADIO.CANNOT_GET_INTEL_ON_ALERT])then
TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.CANNOT_GET_INTEL_ON_ALERT)
end
end
end
end
function e.GotIntel(a)
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
function e.HideIconForIntel()Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL}Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.INTEL_NG}
end
function e.AddTrapSettingForQuest(e)
local t=e.trapName
local n=e.direction or 0
local r=e.directionRange or 180
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
mvars.ply_questTrapList=mvars.ply_questTrapList or{}
table.insert(mvars.ply_questTrapList,t)
mvars.ply_questStartTrapInfo[a(t)]=e
Player.AddTrapDetailCondition{trapName=t,condition=PlayerTrap.FINE,action=PlayerTrap.NORMAL,stance=(PlayerTrap.STAND+PlayerTrap.SQUAT),direction=n,directionRange=r}
end
function e.ShowIconForQuest(e,a)
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
function e.QuestStarted(a)
local a=mvars.ply_questNameReverse[a]
if mvars.ply_questStartFlagInfo[a]~=nil then
mvars.ply_questStartFlagInfo[a]=true
end
e.HideIconForQuest()
end
function e.HideIconForQuest()Player.RequestToHideIcon{type=ActionIcon.ACTION,icon=ActionIcon.TRAINING}
end
function e.ResetIconForQuest(e)
mvars.ply_questStartFlagInfo.ShootingPractice=false
end
function e.AppearHorseOnMissionStart(e,a)
local e,a=Tpp.GetLocator(e,a)
if e then
vars.buddyType=BuddyType.HORSE
vars.initialBuddyPos[0]=e[1]
vars.initialBuddyPos[1]=e[2]
vars.initialBuddyPos[2]=e[3]
end
end
function e.StartGameOverCamera(e,a,t)
if mvars.ply_gameOverCameraGameObjectId~=nil then
return
end
mvars.ply_gameOverCameraGameObjectId=e
mvars.ply_gameOverCameraStartTimerName=a
mvars.ply_gameOverCameraAnnounceLog=t
TppSound.PostJingleOnGameOver()
TppSoundDaemon.PostEvent"sfx_s_force_camera_out"vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
o("Timer_StartGameOverCamera",.25)
end
function e._StartGameOverCamera(e,e)FadeFunction.SetFadeColor(64,0,0,255)
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,mvars.ply_gameOverCameraStartTimerName,nil,{exceptGameStatus={AnnounceLog=false}})Player.RequestToSetCameraFocalLengthAndDistance{focalLength=16,interpTime=TppUI.FADE_SPEED.FADE_HIGHSPEED}
end
function e.PrepareStartGameOverCamera()FadeFunction.ResetFadeColor()
local e={}
for a,t in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
e[a]=false
end
for a,t in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
e[a]=false
end
e.S_DISABLE_NPC=nil
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,nil,nil,{exceptGameStatus=e})Player.RequestToStopCameraAnimation{}
if mvars.ply_gameOverCameraAnnounceLog then
TppUI.ShowAnnounceLog(mvars.ply_gameOverCameraAnnounceLog)
end
end
function e.FOBStartGameOverCamera(e,a,t)
if mvars.ply_gameOverCameraGameObjectId~=nil then
return
end
mvars.ply_gameOverCameraGameObjectId=e
mvars.ply_gameOverCameraStartTimerName=a
mvars.ply_gameOverCameraAnnounceLog=t
vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
o("Timer_StartGameOverCamera",.25)
end
function e.SetTargetDeadCamera(r)
local l
local a
local o
if t(r)then
l=r.gameObjectName or""a=r.gameObjectId
o=r.announceLog or"target_extract_failed"end
a=a or i(l)
if a==n then
return
end
e.StartGameOverCamera(a,"EndFadeOut_StartTargetDeadCamera",o)
end
function e._SetTargetDeadCamera()
e.PrepareStartGameOverCamera()Player.RequestToPlayCameraNonAnimation{characterId=mvars.ply_gameOverCameraGameObjectId,isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,candidateRots={{10,0},{10,45},{10,90},{10,135},{10,180},{10,225},{10,270}},skeletonNames={"SKL_004_HEAD","SKL_011_LUARM","SKL_021_RUARM","SKL_032_LFOOT","SKL_042_RFOOT"},skeletonCenterOffsets={Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,0,0)},skeletonBoundings={Vector3(0,.45,0),Vector3(0,0,0),Vector3(0,0,0),Vector3(0,-.3,0),Vector3(0,-.3,0)},offsetPos=Vector3(.3,.2,-4.6),focalLength=21,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.001,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=16}
end
function e.SetTargetHeliCamera(r)
local l
local a
local o
if t(r)then
l=r.gameObjectName or""a=r.gameObjectId
o=r.announceLog or"target_eliminate_failed"end
a=a or i(l)
if a==n then
return
end
e.StartGameOverCamera(a,"EndFadeOut_StartTargetHeliCamera",o)
end
function e._SetTargetHeliCamera()
e.PrepareStartGameOverCamera()Player.RequestToPlayCameraNonAnimation{characterId=mvars.ply_gameOverCameraGameObjectId,isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,candidateRots={{10,0}},skeletonNames={"SKL_011_RLWDOOR"},skeletonCenterOffsets={Vector3(0,0,0)},skeletonBoundings={Vector3(0,.45,0)},offsetPos=Vector3(.3,.2,-4.6),focalLength=21,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.01,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=999999}
end
function e.SetTargetTruckCamera(r)
local l
local a
local o
if t(r)then
l=r.gameObjectName or""a=r.gameObjectId
o=r.announceLog or"target_extract_failed"end
a=a or i(l)
if a==n then
return
end
e.StartGameOverCamera(a,"EndFadeOut_StartTargetTruckCamera",o)
end
function e._SetTargetTruckCamera(a)
e.PrepareStartGameOverCamera()Player.RequestToPlayCameraNonAnimation{characterId=mvars.ply_gameOverCameraGameObjectId,isFollowPos=false,isFollowRot=true,followTime=7,followDelayTime=.1,candidateRots={{10,0},{10,45},{10,90},{10,135},{10,180},{10,225},{10,270}},skeletonNames={"SKL_005_WIPERC"},skeletonCenterOffsets={Vector3(0,-.75,-2)},skeletonBoundings={Vector3(1.5,2,4)},offsetPos=Vector3(2.5,3,7.5),focalLength=21,aperture=1.875,timeToSleep=10,fitOnCamera=true,timeToStartToFitCamera=.01,fitCameraInterpTime=.24,diffFocalLengthToReFitCamera=999999}
end
function e.SetPlayerKilledChildCamera()
if mvars.mis_childGameObjectIdKilledPlayer then
local a=nil
if not TppEnemy.IsRescueTarget(mvars.mis_childGameObjectIdKilledPlayer)then
a=""end
e.SetTargetDeadCamera{gameObjectId=mvars.mis_childGameObjectIdKilledPlayer,announceLog=a}
end
end
function e.SetPressStartCamera()
local e=i"Player"if e==n then
return
end
Player.RequestToStopCameraAnimation{}Player.RequestToPlayCameraNonAnimation{characterId=e,isFollowPos=true,isFollowRot=true,followTime=0,followDelayTime=0,candidateRots={{0,185}},skeletonNames={"SKL_004_HEAD"},skeletonCenterOffsets={Vector3(-.5,-.15,0)},skeletonBoundings={Vector3(.5,.45,.1)},offsetPos=Vector3(-.8,0,-1.4),focalLength=21,aperture=1.875,timeToSleep=0,fitOnCamera=false,timeToStartToFitCamera=0,fitCameraInterpTime=0,diffFocalLengthToReFitCamera=0}
end
function e.SetTitleCamera()
local e=i"Player"if e==n then
return
end
Player.RequestToStopCameraAnimation{}Player.RequestToPlayCameraNonAnimation{characterId=e,isFollowPos=true,isFollowRot=true,followTime=0,followDelayTime=0,candidateRots={{0,185}},skeletonNames={"SKL_004_HEAD"},skeletonCenterOffsets={Vector3(-.5,-.15,.1)},skeletonBoundings={Vector3(.5,.45,.9)},offsetPos=Vector3(-.8,0,-1.8),focalLength=21,aperture=1.875,timeToSleep=0,fitOnCamera=false,timeToStartToFitCamera=0,fitCameraInterpTime=0,diffFocalLengthToReFitCamera=0}
end
function e.SetSearchTarget(l,t,s,i,a,o,r,e)
if(l==nil or t==nil)then
return
end
local t=d(t)
if t==n then
return
end
if r==nil then
r=true
end
if a==nil then
a=Vector3(0,.25,0)
end
if e==nil then
e=.03
end
local e={name=s,targetGameObjectTypeIndex=t,targetGameObjectName=l,offset=a,centerRange=.3,lookingTime=1,distance=200,doWideCheck=true,wideCheckRadius=.15,wideCheckRange=e,doDirectionCheck=false,directionCheckRange=100,doCollisionCheck=true}
if(i~=nil)then
e.skeletonName=i
end
if(o~=nil)then
e.targetFox2Name=o
end
Player.AddSearchTarget(e)
end
function e.IsSneakPlayerInFOB(e)
if e==0 then
return true
else
return false
end
end
function e.PlayMissionClearCamera()
local e=e.SetPlayerStatusForMissionEndCamera()
if not e then
return
end
o("Timer_StartPlayMissionClearCameraStep1",.25)
end
function e.SetPlayerStatusForMissionEndCamera()Player.SetPadMask{settingName="MissionClearCamera",except=true}
vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
return true
end
function e.ResetMissionEndCamera()Player.ResetPadMask{settingName="MissionClearCamera"}Player.RequestToStopCameraAnimation{}
end
function e.PlayCommonMissionEndCamera(r,s,l,i,t,n)
local a
local e=vars.playerVehicleGameObjectId
if Tpp.IsHorse(e)then
GameObject.SendCommand(e,{id="HorseForceStop"})a=r(e,t,n)
elseif Tpp.IsVehicle(e)then
local r=GameObject.SendCommand(e,{id="GetVehicleType"})
GameObject.SendCommand(e,{id="ForceStop",enabled=true})
local r=s[r]
if r then
a=r(e,t,n)
end
elseif(Tpp.IsPlayerWalkerGear(e)or Tpp.IsEnemyWalkerGear(e))then
GameObject.SendCommand(e,{id="ForceStop",enabled=true})a=l(e,t,n)
elseif Tpp.IsHelicopter(e)then
else
a=i(t,n)
end
if a then
local e="Timer_StartPlayMissionClearCameraStep"..tostring(t+1)o(e,a)
end
end
function e._PlayMissionClearCamera(a,t)
if a==1 then
TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_common_jingle_clear")
end
e.PlayCommonMissionEndCamera(e.PlayMissionClearCameraOnRideHorse,e.VEHICLE_MISSION_CLEAR_CAMERA,e.PlayMissionClearCameraOnWalkerGear,e.PlayMissionClearCameraOnFoot,a,t)
end
function e.RequestMissionClearMotion()Player.RequestToPlayDirectMotion{"missionClearMotion",{"/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_f_idl7.gani",false,"","","",false}}
end
function e.PlayMissionClearCameraOnFoot(p,c)
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
local n={"SKL_004_HEAD","SKL_002_CHEST"}
local r={Vector3(0,0,.05),Vector3(.15,0,0)}
local t={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
local e=Vector3(0,0,-4.5)
local a=.3
local l
local o=false
local i=20
local s=false
if p==1 then
n={"SKL_004_HEAD","SKL_002_CHEST"}r={Vector3(0,0,.05),Vector3(.15,0,0)}t={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}e=Vector3(0,0,-1.5)a=.3
l=1
o=true
elseif c then
n={"SKL_004_HEAD"}r={Vector3(0,0,.05)}t={Vector3(.1,.125,.1)}e=Vector3(0,-.5,-3.5)a=3
i=4
else
n={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"}r={Vector3(0,0,.05),Vector3(.15,0,0),Vector3(-.15,0,0)}t={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)}e=Vector3(0,0,-3.2)a=3
s=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{1,168},{1,-164}},skeletonNames=n,skeletonCenterOffsets=r,skeletonBoundings=t,offsetPos=e,focalLength=28,aperture=1.875,timeToSleep=i,interpTimeAtStart=a,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=o,useLastSelectedIndex=s}
return l
end
function e.PlayMissionClearCameraOnRideHorse(e,p,c)
local e={"SKL_004_HEAD","SKL_002_CHEST"}
local a={Vector3(0,0,.05),Vector3(.15,0,0)}
local t={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
local n=Vector3(0,0,-3.2)
local r=.2
local o
local i=false
local l=20
local s=false
if c then
l=4
end
if p==1 then
e={"SKL_004_HEAD","SKL_002_CHEST"}a={Vector3(0,-.125,.05),Vector3(.15,-.125,0)}t={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}n=Vector3(0,0,-3.2)r=.2
o=1
i=true
else
e={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"}a={Vector3(0,-.125,.05),Vector3(.15,-.125,0),Vector3(-.15,-.125,0)}t={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)}n=Vector3(0,0,-4.5)r=3
s=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{0,160},{0,-160}},skeletonNames=e,skeletonCenterOffsets={Vector3(0,-.125,.05),Vector3(.15,-.125,0),Vector3(-.15,-.125,0)},skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)},skeletonCenterOffsets=a,skeletonBoundings=t,offsetPos=n,focalLength=28,aperture=1.875,timeToSleep=l,interpTimeAtStart=r,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=i,useLastSelectedIndex=s}
return o
end
function e.PlayMissionClearCameraOnRideLightVehicle(e,l,s)
local t=Vector3(-.35,.6,.7)
local a=Vector3(0,0,-2.25)
local e=.2
local n
local r=false
local o=20
local i=false
if s then
o=4
end
if l==1 then
t=Vector3(-.35,.6,.7)a=Vector3(0,0,-2.25)e=.2
n=.5
r=true
else
t=Vector3(-.35,.4,.7)a=Vector3(0,0,-4)e=.75
i=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{3,160},{3,-160}},offsetTarget=t,offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=r,useLastSelectedIndex=i}
return n
end
function e.PlayMissionClearCameraOnRideTruck(e,s,l)
local t=Vector3(-.35,1.3,1)
local a=Vector3(0,0,-2)
local e=.2
local i
local o=false
local n=20
local r=false
if l then
n=4
end
if s==1 then
t=Vector3(-.35,1.3,1)a=Vector3(0,0,-3)e=.2
i=.5
o=true
else
t=Vector3(-.35,1,1)a=Vector3(0,0,-6)e=.75
r=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{3,160},{3,-160}},offsetTarget=t,offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=n,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=o,useLastSelectedIndex=r}
return i
end
function e.PlayMissionClearCameraOnRideCommonArmoredVehicle(a,l,e,s)
local t=Vector3(.05,-.5,-2.2)
if e==1 then
t=Vector3(.05,-.5,-2.2)
else
t=Vector3(-.05,-1,0)
end
local a=Vector3(0,0,-7.5)
local e=.2
local n
local r=false
local o=20
local i=false
if s then
o=4
end
if l==1 then
a=Vector3(0,0,-7.5)e=.2
n=.5
r=true
else
a=Vector3(0,0,-13.25)e=.75
i=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{8,165},{8,-165}},offsetTarget=t,offsetPos=a,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=e,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=r,useLastSelectedIndex=i}
return n
end
function e.PlayMissionClearCameraOnRideEasternArmoredVehicle(r,n,t)
local a
a=e.PlayMissionClearCameraOnRideCommonArmoredVehicle(r,n,1,t)
return a
end
function e.PlayMissionClearCameraOnRideWesternArmoredVehicle(t,n)
local a
a=e.PlayMissionClearCameraOnRideCommonArmoredVehicle(t,n,2,isQuest)
return a
end
function e.PlayMissionClearCameraOnRideTank(e,i,l)
local e=Vector3(0,0,-6.5)
local a=.2
local r
local t=false
local o=20
local n=false
if l then
o=4
end
if i==1 then
e=Vector3(0,0,-6.5)a=.2
r=.5
t=true
else
e=Vector3(0,0,-9)a=.75
n=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=5,followDelayTime=0,candidateRots={{9,165},{9,-165}},offsetTarget=Vector3(0,-.85,3.25),offsetPos=e,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=a,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=t,useLastSelectedIndex=n}
return r
end
function e.PlayMissionClearCameraOnWalkerGear(a,s,p)
local n=Vector3(0,.55,.35)
local t=Vector3(0,0,-3.65)
local a=.2
local l
local i=false
local o=20
local r=false
if p then
o=4
end
if s==1 then
n=Vector3(0,.55,.35)t=Vector3(0,0,-3.65)a=.2
l=1
i=true
else
n=Vector3(0,.4,.35)t=Vector3(0,0,-4.95)a=3
r=true
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{7,165},{7,-165}},offsetTarget=n,offsetPos=t,focalLength=28,aperture=1.875,timeToSleep=o,interpTimeAtStart=a,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=i,useLastSelectedIndex=r}
return l
end
e.VEHICLE_MISSION_CLEAR_CAMERA={[Vehicle.type.EASTERN_LIGHT_VEHICLE]=e.PlayMissionClearCameraOnRideLightVehicle,[Vehicle.type.EASTERN_TRACKED_TANK]=e.PlayMissionClearCameraOnRideTank,[Vehicle.type.EASTERN_TRUCK]=e.PlayMissionClearCameraOnRideTruck,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=e.PlayMissionClearCameraOnRideEasternArmoredVehicle,[Vehicle.type.WESTERN_LIGHT_VEHICLE]=e.PlayMissionClearCameraOnRideLightVehicle,[Vehicle.type.WESTERN_TRACKED_TANK]=e.PlayMissionClearCameraOnRideTank,[Vehicle.type.WESTERN_TRUCK]=e.PlayMissionClearCameraOnRideTruck,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=e.PlayMissionClearCameraOnRideWesternArmoredVehicle}
function e.FOBPlayMissionClearCamera()
local e=e.SetPlayerStatusForMissionEndCamera()
if not e then
return
end
o("Timer_FOBStartPlayMissionClearCameraStep1",.25)
end
function e._FOBPlayMissionClearCamera(a)
e.FOBPlayCommonMissionEndCamera(e.FOBPlayMissionClearCameraOnFoot,a)
end
function e.FOBPlayCommonMissionEndCamera(t,a)
local e
e=t(a)
if e then
local a="Timer_FOBStartPlayMissionClearCameraStep"..tostring(a+1)o(a,e)
end
end
function e.FOBRequestMissionClearMotion()Player.RequestToPlayDirectMotion{"missionClearMotionFob",{"/Assets/tpp/motion/SI_game/fani/bodies/snap/snapnon/snapnon_s_win_idl.gani",false,"","","",false}}
end
function e.FOBPlayMissionClearCameraOnFoot(l)Player.SetCurrentSlot{slotType=PlayerSlotType.ITEM,subIndex=0}
if PlayerInfo.OrCheckStatus{PlayerStatus.STAND,PlayerStatus.SQUAT,PlayerStatus.CRAWL}then
if PlayerInfo.AndCheckStatus{PlayerStatus.CARRY}then
mvars.ply_requestedMissionClearCameraCarryOff=true
GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="RequestCarryOff"})
elseif PlayerInfo.OrCheckStatus{PlayerStatus.SQUAT,PlayerStatus.CRAWL}then
Player.RequestToSetTargetStance(PlayerStance.STAND)o("Timer_FOBWaitStandStance",1)
else
e.FOBRequestMissionClearMotion()
end
end
local e={"SKL_004_HEAD","SKL_002_CHEST"}
local a={Vector3(0,.1,0),Vector3(0,-.05,0)}
local t={Vector3(.1,.125,.1),Vector3(.15,.1,.05)}
local r=Vector3(0,0,-4.5)
local n=.3
local o
local i=false
if l==1 then
e={"SKL_004_HEAD","SKL_002_CHEST"}a={Vector3(0,.25,0),Vector3(0,-.05,0)}t={Vector3(.1,.125,.1),Vector3(.1,.125,.1)}r=Vector3(0,0,-1)n=.3
o=1
i=true
else
e={"SKL_004_HEAD","SKL_002_CHEST"}a={Vector3(0,.15,0),Vector3(0,-.05,0)}t={Vector3(.1,.125,.1),Vector3(.1,.125,.1)}r=Vector3(0,0,-1.5)n=3
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{-10,170},{-10,-170}},skeletonNames=e,skeletonCenterOffsets=a,skeletonBoundings=t,offsetPos=r,focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=n,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16,callSeOfCameraInterp=i}
return o
end
function e.PlayMissionAbortCamera()
local e=e.SetPlayerStatusForMissionEndCamera()
if not e then
return
end
o("Timer_StartPlayMissionAbortCamera",.25)
end
function e._PlayMissionAbortCamera()
TppMusicManager.PostJingleEvent("SingleShot","Play_bgm_common_jingle_failed")
e.PlayCommonMissionEndCamera(e.PlayMissionAbortCameraOnRideHorse,e.VEHICLE_MISSION_ABORT_CAMERA,e.PlayMissionAbortCameraOnWalkerGear,e.PlayMissionAbortCameraOnFoot)
end
function e.PlayMissionAbortCameraOnFoot()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{6,10},{6,-10}},skeletonNames={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"},skeletonCenterOffsets={Vector3(0,.2,0),Vector3(-.15,0,0),Vector3(-.15,0,0)},skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)},offsetPos=Vector3(0,0,-3),focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function e.PlayMissionAbortCameraOnRideHorse(e)Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=4,followDelayTime=.1,candidateRots={{6,20},{6,-20}},skeletonNames={"SKL_004_HEAD","SKL_031_LLEG","SKL_041_RLEG"},skeletonCenterOffsets={Vector3(0,.2,0),Vector3(-.15,0,0),Vector3(-.15,0,0)},skeletonBoundings={Vector3(.1,.125,.1),Vector3(.15,.1,.05),Vector3(.15,.1,.05)},offsetPos=Vector3(0,0,-3),focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function e.PlayMissionAbortCameraOnRideLightVehicle(e)Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{10,30},{10,-30}},offsetTarget=Vector3(-.35,.3,0),offsetPos=Vector3(0,0,-4),focalLength=28,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function e.PlayMissionAbortCameraOnRideTruck(e)Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{8,75},{8,-55}},offsetTarget=Vector3(-.35,1,1),offsetPos=Vector3(0,0,-5),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function e.PlayMissionAbortCameraOnRideCommonArmoredVehicle(e,a)
local e=Vector3(.05,-.5,-2.2)
if a==1 then
e=Vector3(.05,-.5,-2.2)
else
e=Vector3(-.65,-1,0)
end
Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{8,30},{8,-30}},offsetTarget=e,offsetPos=Vector3(0,0,-9),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function e.PlayMissionAbortCameraOnRideEasternArmoredVehicle(a)
e.PlayMissionAbortCameraOnRideCommonArmoredVehicle(a,1)
end
function e.PlayMissionAbortCameraOnRideWesternArmoredVehicle(a)
e.PlayMissionAbortCameraOnRideCommonArmoredVehicle(a,2)
end
function e.PlayMissionAbortCameraOnRideTank(e)
local e=Vector3(0,-.5,0)Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{8,25},{8,-25}},offsetTarget=e,offsetPos=Vector3(0,0,-10),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
function e.PlayMissionAbortCameraOnWalkerGear(a)Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",0),isFollowPos=true,isFollowRot=true,followTime=3,followDelayTime=.1,candidateRots={{7,15},{7,-15}},offsetTarget=Vector3(0,.8,0),offsetPos=Vector3(0,.5,-3.5),focalLength=35,aperture=1.875,timeToSleep=20,interpTimeAtStart=.5,fitOnCamera=false,timeToStartToFitCamera=1,fitCameraInterpTime=.3,diffFocalLengthToReFitCamera=16}
end
e.VEHICLE_MISSION_ABORT_CAMERA={[Vehicle.type.EASTERN_LIGHT_VEHICLE]=e.PlayMissionAbortCameraOnRideLightVehicle,[Vehicle.type.EASTERN_TRACKED_TANK]=e.PlayMissionAbortCameraOnRideTank,[Vehicle.type.EASTERN_TRUCK]=e.PlayMissionAbortCameraOnRideTruck,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=e.PlayMissionAbortCameraOnRideEasternArmoredVehicle,[Vehicle.type.WESTERN_LIGHT_VEHICLE]=e.PlayMissionAbortCameraOnRideLightVehicle,[Vehicle.type.WESTERN_TRACKED_TANK]=e.PlayMissionAbortCameraOnRideTank,[Vehicle.type.WESTERN_TRUCK]=e.PlayMissionAbortCameraOnRideTruck,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=e.PlayMissionAbortCameraOnRideWesternArmoredVehicle}
function e.PlayFallDeadCamera()
mvars.ply_fallDeadCameraTargetPlayerIndex=PlayerInfo.GetLocalPlayerIndex()HighSpeedCamera.RequestEvent{continueTime=.03,worldTimeRate=.1,localPlayerTimeRate=.1}
e.PlayCommonMissionEndCamera(e.PlayFallDeadCameraOnRideHorse,e.VEHICLE_FALL_DEAD_CAMERA,e.PlayFallDeadCameraOnWalkerGear,e.PlayFallDeadCameraOnFoot)
end
function e.SetLimitFallDeadCameraOffsetPosY(e)
mvars.ply_fallDeadCameraPosYLimit=e
end
function e.ResetLimitFallDeadCameraOffsetPosY()
mvars.ply_fallDeadCameraPosYLimit=nil
end
function e.GetFallDeadCameraOffsetPosY()
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
function e.PlayFallDeadCameraOnFoot()
local e=e.GetFallDeadCameraOffsetPosY()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-2.5,(e+1),-2.5),focalLength=21,aperture=1.875,timeToSleep=20,interpTimeAtStart=0,fitOnCamera=false}
end
function e.PlayFallDeadCameraOnRideHorse(a)
local e=e.GetFallDeadCameraOffsetPosY()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-2.5,(e+1),-2.5),focalLength=21,aperture=1.875,timeToSleep=20,interpTimeAtStart=0,fitOnCamera=false}
end
function e.PlayFallDeadCameraOnRideLightVehicle(a)
local e=e.GetFallDeadCameraOffsetPosY()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=20,interpTimeAtStart=0,fitOnCamera=false}
end
function e.PlayFallDeadCameraOnRideTruck(a)
local e=e.GetFallDeadCameraOffsetPosY()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=20,interpTimeAtStart=0,fitOnCamera=false}
end
function e.PlayFallDeadCameraOnRideArmoredVehicle(a)
local e=e.GetFallDeadCameraOffsetPosY()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=20,interpTimeAtStart=0,fitOnCamera=false}
end
function e.PlayFallDeadCameraOnRideTank(a)
local e=e.GetFallDeadCameraOffsetPosY()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(e+1),-8),focalLength=21,aperture=1.875,timeToSleep=20,interpTimeAtStart=0,fitOnCamera=false}
end
function e.PlayFallDeadCameraOnWalkerGear(a)
local a=e.GetFallDeadCameraOffsetPosY()Player.RequestToPlayCameraNonAnimation{characterId=GameObject.GetGameObjectIdByIndex("TppPlayer2",mvars.ply_fallDeadCameraTargetPlayerIndex),isFollowPos=false,isFollowRot=true,followTime=.8,followDelayTime=0,candidateRots={{-60,-25},{-60,25},{-60,-115},{-60,115},{5,-25},{5,25},{5,-115},{5,115}},offsetTarget=Vector3(0,0,0),offsetPos=Vector3(-4,(a+1),-8),focalLength=21,aperture=1.875,timeToSleep=20,interpTimeAtStart=0,fitOnCamera=false}
end
e.VEHICLE_FALL_DEAD_CAMERA={[Vehicle.type.EASTERN_LIGHT_VEHICLE]=e.PlayFallDeadCameraOnRideLightVehicle,[Vehicle.type.EASTERN_TRACKED_TANK]=e.PlayFallDeadCameraOnRideTank,[Vehicle.type.EASTERN_TRUCK]=e.PlayFallDeadCameraOnRideTruck,[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE]=e.PlayFallDeadCameraOnRideArmoredVehicle,[Vehicle.type.WESTERN_LIGHT_VEHICLE]=e.PlayFallDeadCameraOnRideLightVehicle,[Vehicle.type.WESTERN_TRACKED_TANK]=e.PlayFallDeadCameraOnRideTank,[Vehicle.type.WESTERN_TRUCK]=e.PlayFallDeadCameraOnRideTruck,[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE]=e.PlayFallDeadCameraOnRideArmoredVehicle}
function e.Messages()
local n=Tpp.StrCode32Table{Player={{msg="CalcFultonPercent",func=function(r,o,n,a,t)
e.MakeFultonRecoverSucceedRatio(r,o,n,a,t,false)
end},{msg="CalcDogFultonPercent",func=function(a,n,o,r,t)
e.MakeFultonRecoverSucceedRatio(a,n,o,r,t,true)
end},{msg="RideHelicopter",func=e.SetHelicopterInsideAction},{msg="PlayerFulton",func=e.OnPlayerFulton},{msg="OnPickUpCollection",func=e.OnPickUpCollection},{msg="OnPickUpPlaced",func=e.OnPickUpPlaced},{msg="OnPickUpWeapon",func=e.OnPickUpWeapon},{msg="WarpEnd",func=e.OnEndWarpByCboxDelivery},{msg="LandingFromHeli",func=function()
e.UpdateCheckPointOnMissionStartDrop()
end},{msg="EndCarryAction",func=function()
if mvars.ply_requestedMissionClearCameraCarryOff then
if PlayerInfo.AndCheckStatus{PlayerStatus.STAND}then
e.RequestMissionClearMotion()
end
end
end,option={isExecMissionClear=true}},{msg="IntelIconInDisplay",func=e.OnIntelIconDisplayContinue},{msg="QuestIconInDisplay",func=e.OnQuestIconDisplayContinue},{msg="PlayerShowerEnd",func=function()
TppUI.ShowAnnounceLog"refresh"end}},GameObject={{msg="RideHeli",func=e.QuietRideHeli}},UI={{msg="EndFadeOut",sender="OnSelectCboxDelivery",func=e.WarpByCboxDelivery},{msg="EndFadeIn",sender="OnEndWarpByCboxDelivery",func=e.OnEndFadeInWarpByCboxDelivery},{msg="EndFadeOut",sender="EndFadeOut_StartTargetDeadCamera",func=e._SetTargetDeadCamera,option={isExecGameOver=true}},{msg="EndFadeOut",sender="EndFadeOut_StartTargetHeliCamera",func=e._SetTargetHeliCamera,option={isExecGameOver=true}},{msg="EndFadeOut",sender="EndFadeOut_StartTargetTruckCamera",func=e._SetTargetTruckCamera,option={isExecGameOver=true}}},Terminal={{msg="MbDvcActSelectCboxDelivery",func=e.OnSelectCboxDelivery}},Timer={{msg="Finish",sender="Timer_StartPlayMissionClearCameraStep1",func=function()
e._PlayMissionClearCamera(1)
end,option={isExecMissionClear=true}},{msg="Finish",sender="Timer_StartPlayMissionClearCameraStep2",func=function()
e._PlayMissionClearCamera(2)
end,option={isExecMissionClear=true}},{msg="Finish",sender="Timer_FOBStartPlayMissionClearCameraStep1",func=function()
e._FOBPlayMissionClearCamera(1)
end,option={isExecMissionClear=true}},{msg="Finish",sender="Timer_FOBStartPlayMissionClearCameraStep2",func=function()
e._FOBPlayMissionClearCamera(2)
end,option={isExecMissionClear=true}},{msg="Finish",sender="Timer_StartPlayMissionAbortCamera",func=e._PlayMissionAbortCamera,option={isExecGameOver=true}},{msg="Finish",sender="Timer_DeliveryWarpSoundCannotCancel",func=e.OnDeliveryWarpSoundCannotCancel},{msg="Finish",sender="Timer_StartGameOverCamera",func=e._StartGameOverCamera,option={isExecGameOver=true}},{msg="Finish",sender="Timer_FOBWaitStandStance",func=function()
e.FOBRequestMissionClearMotion()
end,option={isExecMissionClear=true}}},Trap={{msg="Enter",sender="trap_TppSandWind0000",func=function()
TppEffectUtility.SetSandWindEnable(true)
end,option={isExecMissionPrepare=true}},{msg="Exit",sender="trap_TppSandWind0000",func=function()
TppEffectUtility.SetSandWindEnable(false)
end,option={isExecMissionPrepare=true}},{msg="Enter",sender="fallDeath_camera",func=function()
e.SetLimitFallDeadCameraOffsetPosY(-18)
end,option={isExecMissionPrepare=true}},{msg="Exit",sender="fallDeath_camera",func=e.ResetLimitFallDeadCameraOffsetPosY,option={isExecMissionPrepare=true}}}}
if t(mvars.ply_intelMarkerTrapList)and next(mvars.ply_intelMarkerTrapList)then
n[a"Trap"]=n[a"Trap"]or{}
table.insert(n[a"Trap"],Tpp.StrCode32Table{msg="Enter",sender=mvars.ply_intelMarkerTrapList,func=e.OnEnterIntelMarkerTrap,option={isExecMissionPrepare=true}})
end
if t(mvars.ply_intelTrapList)and next(mvars.ply_intelTrapList)then
n[a"Trap"]=n[a"Trap"]or{}
table.insert(n[a"Trap"],Tpp.StrCode32Table{msg="Enter",sender=mvars.ply_intelTrapList,func=e.OnEnterIntelTrap})
table.insert(n[a"Trap"],Tpp.StrCode32Table{msg="Exit",sender=mvars.ply_intelTrapList,func=e.OnExitIntelTrap})
end
return n
end
function e.DeclareSVars()
return{{name="ply_pickableLocatorDisabled",arraySize=mvars.ply_maxPickableLocatorCount,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="ply_placedLocatorDisabled",arraySize=mvars.ply_maxPlacedLocatorCount,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="ply_isUsedPlayerInitialAction",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function e.OnAllocate(e)
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
function e.SetInitialPlayerState(a)
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
function e.MissionStartPlayerTypeSetting()
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
function e.Init(a)
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
vars.currentItemIndex=e
end
if(gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)and(svars.ply_isUsedPlayerInitialAction==false)then
local e=i("TppHeli2","SupportHeli")
if e~=n then
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
TppEffectUtility.SetSandWindEnable(false)
end
function e.SetSelfSubsistenceOnHardMission()
if TppMission.IsSubsistenceMission()then
e.SetInitWeapons(TppDefine.CYPR_PLAYER_INITIAL_WEAPON_TABLE)
e.SetInitItems(TppDefine.CYPR_PLAYER_INITIAL_ITEM_TABLE)
e.RegisterTemporaryPlayerType{partsType=PlayerPartsType.NORMAL,camoType=PlayerCamoType.OLIVEDRAB,handEquip=TppEquip.EQP_HAND_NORMAL,faceEquipId=0}
end
end
function e.OnReload()
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnMessage(a,t,n,o,l,i,r)
Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,a,t,n,o,l,i,r)
end
function e.Update()
e.UpdateDeliveryWarp()
end
local a={[TppDefine.WEATHER.SUNNY]=0,[TppDefine.WEATHER.CLOUDY]=-10,[TppDefine.WEATHER.RAINY]=-30,[TppDefine.WEATHER.FOGGY]=-50,[TppDefine.WEATHER.SANDSTORM]=-70}
function e.MakeFultonRecoverSucceedRatio(a,e,a,a,a,a)Player.SetFultonIconPercentage{percentage=100,targetId=e}
end
function e.GetSoldierFultonSucceedRatio(t)
local e=0
local n=0
local a=r(t,{id="GetLifeStatus"})
local o=GameObject.SendCommand(t,{id="GetStateFlag"})
if(bit.band(o,StateFlag.DYING_LIFE)~=0)then
e=-70
elseif(a==TppGameObject.NPC_LIFE_STATE_SLEEP)or(a==TppGameObject.NPC_LIFE_STATE_FAINT)then
e=0
if mvars.ply_OnFultonIconDying then
mvars.ply_OnFultonIconDying()
end
elseif(a==TppGameObject.NPC_LIFE_STATE_DEAD)then
return
end
local a={[TppMotherBaseManagementConst.SECTION_FUNC_RANK_S]=60,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_A]=50,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_B]=40,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_C]=30,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_D]=20,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_E]=10,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_F]=0,[TppMotherBaseManagementConst.SECTION_FUNC_RANK_NONE]=0}
local o=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_MEDICAL_STAFF_EMERGENCY}
local a=a[o]or 0
e=e+a
if e>0 then
e=0
end
local a=r(t,{id="GetStatus"})
if a==EnemyState.STAND_HOLDUP then
n=-10
end
return(e+n)
end
function e.GetDefaultSucceedRatio(e)
return 0
end
function e.GetVolginFultonSucceedRatio(e)
return 100
end
function e.SetHelicopterInsideAction()Player.SetHeliToInsideParam{canClearMission=svars.mis_canMissionClear}
end
function e.OnPlayerFulton(e,n)
if e~=PlayerInfo.GetLocalPlayerIndex()then
return
end
local r=300
local e=1e4
local a=1e4
local t=5e3
local t={[TppGameObject.GAME_OBJECT_TYPE_WALKERGEAR2]=e,[TppGameObject.GAME_OBJECT_TYPE_COMMON_WALKERGEAR2]=e,[TppGameObject.GAME_OBJECT_TYPE_BATTLEGEAR]=e,[TppGameObject.GAME_OBJECT_TYPE_VEHICLE]=a,[TppGameObject.GAME_OBJECT_TYPE_FULTONABLE_CONTAINER]=a,[TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN]=a,[TppGameObject.GAME_OBJECT_TYPE_MORTAR]=t,[TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN]=t}
local e
local a=GameObject.GetTypeIndex(n)e=t[a]or r
TppTerminal.UpdateGMP{gmp=-e,gmpCostType=TppDefine.GMP_COST_TYPE.FULTON}svars.supportGmpCost=svars.supportGmpCost+e
end
function e.QuietRideHeli(e)
if e==GameObject.GetGameObjectIdByIndex("TppBuddyQuiet2",0)then
Player.RequestToPlayCameraNonAnimation{characterId=e,isFollowPos=false,isFollowRot=false,followTime=1,followDelayTime=.1,candidateRots={{-4,45},{-4,-45},{-8,0}},offsetPos=Vector3(0,-.2,-2.5),offsetTarget=Vector3(0,2,0),focalLength=21,aperture=1.875,timeToSleep=2,enableOverride=true}
end
end
function e.SetRetryFlag()
vars.playerRetryFlag=PlayerRetryFlag.RETRY
end
function e.SetRetryFlagWithChickCap()
vars.playerRetryFlag=PlayerRetryFlag.RETRY_WITH_CHICK_CAP
end
function e.UnsetRetryFlag()
vars.playerRetryFlag=0
end
function e.ResetStealthAssistCount()
vars.stealthAssistLeftCount=0
end
function e.OnPickUpCollection(o,t,a,i)
local o=255
TppCollection.RepopCountOperation("SetAt",t,o)
TppTerminal.AddPickedUpResourceToTempBuffer(a,i)
local o={[TppCollection.TYPE_POSTER_SOL_AFGN]="key_poster_3500",[TppCollection.TYPE_POSTER_SOL_MAFR]="key_poster_3501",[TppCollection.TYPE_POSTER_GRAVURE_V]="key_poster_3502",[TppCollection.TYPE_POSTER_GRAVURE_H]="key_poster_3503",[TppCollection.TYPE_POSTER_MOE_V]="key_poster_3504",[TppCollection.TYPE_POSTER_MOE_H]="key_poster_3505"}
local o=o[a]
if o~=nil then
TppUI.ShowAnnounceLog("getPoster",o,TppTerminal.GMP_POSTER)
end
local o
if TppTerminal.RESOURCE_INFORMATION_TABLE[a]and TppTerminal.RESOURCE_INFORMATION_TABLE[a].count then
o=TppTerminal.RESOURCE_INFORMATION_TABLE[a].count
end
if TppCollection.IsHerbByType(a)then
local e=GameObject.GetGameObjectIdByIndex("TppBuddyDog2",0)
if e~=n then
r(e,{id="GetPlant",uniqueId=t})
end
end
if TppCollection.IsMaterialByType(a)then
TppUI.ShowAnnounceLog("find_processed_res",i,o)
end
if a==TppCollection.TYPE_DIAMOND_SMALL then
TppUI.ShowAnnounceLog("find_diamond",TppDefine.SMALL_DIAMOND_GMP)
end
if a==TppCollection.TYPE_DIAMOND_LARGE then
TppUI.ShowAnnounceLog("find_diamond",TppDefine.LARGE_DIAMOND_GMP)
end
local a=mvars.ply_locationStationTable[t]
if a then
TppUI.ShowAnnounceLog"get_invoice"TppUI.ShowAnnounceLog"add_delivery_point"TppCollection.SetValidStation(a)
e.CheckAllStationPickedUp()
end
TppTerminal.PickUpBluePrint(t)
TppTerminal.PickUpEmblem(t)
end
function e.CheckAllStationPickedUp()
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
function e.OnPickUpPlaced(e,e,a)
local e=GameObject.GetGameObjectIdByIndex("TppBuddyDog2",0)
if e~=n then
r(e,{id="GetPlacedItem",index=a})
end
end
function e.OnPickUpWeapon(t,a,e)
if a==TppEquip.EQP_IT_Cassette then
TppCassette.AcquireOnPickUp(e)
end
end
function e.RestoreSupplyCbox()
if e.IsExistSupplyCboxSystem()then
local e={type="TppSupplyCboxSystem"}r(e,{id="RestoreRequest"})
end
end
function e.StoreSupplyCbox()
if e.IsExistSupplyCboxSystem()then
local e={type="TppSupplyCboxSystem"}r(e,{id="StoreRequest"})
end
end
function e.IsExistSupplyCboxSystem()
if GameObject.GetGameObjectIdByIndex("TppSupplyCboxSystem",0)~=n then
return true
else
return false
end
end
function e.RestoreSupportAttack()
if e.IsExistSupportAttackSystem()then
local e={type="TppSupportAttackSystem"}r(e,{id="RestoreRequest"})
end
end
function e.StoreSupportAttack()
if e.IsExistSupportAttackSystem()then
local e={type="TppSupportAttackSystem"}r(e,{id="StoreRequest"})
end
end
function e.IsExistSupportAttackSystem()
if GameObject.GetGameObjectIdByIndex("TppSupportAttackSystem",0)~=n then
return true
else
return false
end
end
function e.StorePlayerDecoyInfos()
if e.IsExistDecoySystem()then
local e={type="TppDecoySystem"}r(e,{id="StorePlayerDecoyInfos"})
end
end
function e.IsExistDecoySystem()
if GameObject.GetGameObjectIdByIndex("TppDecoySystem",0)~=n then
return true
else
return false
end
end
local a=7.5
local t=3.5
e.DELIVERY_WARP_STATE=Tpp.Enum{"START_FADE_OUT","START_WARP","END_WARP","START_FADE_IN"}
function e.OnSelectCboxDelivery(a)Player.SetPadMask{settingName="CboxDelivery",except=true}
mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.START_FADE_OUT
mvars.ply_selectedCboxDeliveryUniqueId=a
mvars.ply_playingDeliveryWarpSoundHandle=TppSoundDaemon.PostEventAndGetHandle("Play_truck_transfer","Loading")
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"OnSelectCboxDelivery",nil,{setMute=true})
end
function e.WarpByCboxDelivery()
if not mvars.ply_selectedCboxDeliveryUniqueId then
return
end
TppGameStatus.Set("TppPlayer.WarpByCboxDelivery","S_IS_BLACK_LOADING")
if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
TppQuest.DeactivateCurrentQuestBlock()
TppQuest.ClearBlockStateRequest()
end
mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.START_WARP
o("Timer_DeliveryWarpSoundCannotCancel",a)
local a={type="TppPlayer2",index=0}
local e={id="WarpToStation",stationId=mvars.ply_selectedCboxDeliveryUniqueId}
GameObject.SendCommand(a,e)
end
function e.OnEndWarpByCboxDelivery()
if mvars.ply_deliveryWarpState==e.DELIVERY_WARP_STATE.START_WARP then
mvars.ply_deliveryWarpState=e.DELIVERY_WARP_STATE.END_WARP
end
end
function e.OnDeliveryWarpSoundCannotCancel()
mvars.ply_deliveryWarpSoundCannotCancel=true
end
function e.UpdateDeliveryWarp()
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
TppSoundDaemon.PostEventAndGetHandle("Stop_truck_transfer","Loading")m"Timer_DeliveryWarpSoundCannotCancel"return
end
if mvars.ply_playingDeliveryWarpSoundHandle then
local e=TppSoundDaemon.IsEventPlaying("Play_truck_transfer",mvars.ply_playingDeliveryWarpSoundHandle)
if(e==false)then
TppSoundDaemon.ResetMute"Loading"mvars.ply_playingDeliveryWarpSoundHandle=nil
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
TppSoundDaemon.ResetMute"Loading"TppGameStatus.Reset("TppPlayer.WarpByCboxDelivery","S_IS_BLACK_LOADING")
if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
TppQuest.InitializeQuestLoad()
TppQuest.InitializeQuestActiveStatus()
end
TppMission.ExecuteSystemCallback("OnEndDeliveryWarp",mvars.ply_selectedCboxDeliveryUniqueId)
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMAL,"OnEndWarpByCboxDelivery")
end
end
function e.OnEndFadeInWarpByCboxDelivery()
mvars.ply_selectedCboxDeliveryUniqueId=nil
mvars.ply_deliveryWarpState=nil
mvars.ply_deliveryWarpSoundCannotCancel=nil
m"Timer_DeliveryWarpSoundCannotCancel"Player.ResetPadMask{settingName="CboxDelivery"}
end
function e.OnEnterIntelMarkerTrap(e,a)
local e=mvars.ply_intelMarkerTrapInfo[e]
local a=mvars.ply_intelFlagInfo[e]
if a then
if svars[a]then
return
end
else
return
end
local e=mvars.ply_intelMarkerObjectiveName[e]
if e then
TppMission.UpdateObjective{objectives={e}}
end
end
function e.OnEnterIntelTrap(a,t)
local a=mvars.ply_intelTrapInfo[a]
e.ShowIconForIntel(a)
end
function e.OnExitIntelTrap(a,a)
e.HideIconForIntel()
end
function e.OnIntelIconDisplayContinue(a,t,t)
local a=mvars.ply_intelNameReverse[a]
e.ShowIconForIntel(a)
end
function e.OnEnterQuestTrap(a,t)
local a=mvars.ply_questStartTrapInfo[a]
e.ShowIconForQuest(a)
local e=mvars.ply_questStartFlagInfo[a]
if e~=nil and e==false then
TppSoundDaemon.PostEvent"sfx_s_ifb_mbox_arrival"end
end
function e.OnExitQuestTrap(a,a)
e.HideIconForQuest()
end
function e.OnQuestIconDisplayContinue(a,t,t)
local a=mvars.ply_questNameReverse[a]
e.ShowIconForQuest(a)
end
function e.UpdateCheckPointOnMissionStartDrop()
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
function e.IsAlreadyDropped()
return mvars.ply_doneUpdateCheckPointOnMissionStartDrop
end
function e.EvaluateAllCaptureCage()
if mvars.loc_locationAnimalSettingTable==nil then
return
end
if CaptureCage~=nil then
e.SaveCaptureAnimal()
e.AggregateCaptureAnimal()
else
local n=TppPlaced.GetCaptureCageInfo()
local a=0
local t=0
for r,n in pairs(n)do
local n,e,r,r=e.EvaluateCaptureCage(n.x,n.z,n.grade)
if e~=0 then
TppMotherBaseManagement.DirectAddDataBaseAnimal{dataBaseId=e,areaName=n,isNew=true}
local r,n=TppMotherBaseManagement.GetAnimalHeroicPointAndGmp{dataBaseId=e}a=a+r
t=t+n
TppUiCommand.ShowBonusPopupAnimal(e,"regist")
end
end
if a>0 or t>0 then
TppMotherBaseManagement.AddHeroicPointAndGmpByCageAnimal{heroicPoint=a,gmp=t}
end
TppPlaced.DeleteAllCaptureCage()
end
end
function e.SaveCaptureAnimal()
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
function e.AggregateCaptureAnimal()
local a=0
local e=0
local t=CaptureCage.GetCaptureAnimalList()
for t,n in pairs(t)do
local t=n.animalId
local n=n.areaName
TppMotherBaseManagement.DirectAddDataBaseAnimal{dataBaseId=t,areaNameHash=n,isNew=true}
local n,r=TppMotherBaseManagement.GetAnimalHeroicPointAndGmp{dataBaseId=t}a=a+n
e=e+r
TppUiCommand.ShowBonusPopupAnimal(t,"regist")
end
if a>0 or e>0 then
TppMotherBaseManagement.AddHeroicPointAndGmpByCageAnimal{heroicPoint=a,gmp=e}
end
end
function e.CheckCaptureCage(a,r)
if mvars.loc_locationAnimalSettingTable==nil then
return
end
if a<2 or a>4 then
return
end
local t={}
local n=5
local o=r/n
for r=1,o do
if a==2 then
Player.DEBUG_PlaceAround{radius=5,count=n,equipId=TppEquip.EQP_SWP_CaptureCage}
elseif a==3 then
Player.DEBUG_PlaceAround{radius=5,count=n,equipId=TppEquip.EQP_SWP_CaptureCage_G01}
elseif a==4 then
Player.DEBUG_PlaceAround{radius=5,count=n,equipId=TppEquip.EQP_SWP_CaptureCage_G02}
end
for e=1,n do
coroutine.yield()
end
local a=TppPlaced.GetCaptureCageInfo()
for n,a in pairs(a)do
local n,a,r,e=e.EvaluateCaptureCage(a.x,a.z,a.grade,a.material)
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
local e=(e/r)*100
end
end
function e.GetCaptureAnimalSE(t)
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
function e._IsStartStatusValid(a)
if(e.StartStatusList[a]==nil)then
return false
end
return true
end
function e._IsAbilityNameValid(a)
if(e.DisableAbilityList[a]==nil)then
return false
end
return true
end
function e._IsControlModeValid(a)
if(e.ControlModeList[a]==nil)then
return false
end
return true
end
function e._CheckRotation(e,a,n,o,t)
local t=mvars
local t=vars.playerCameraRotation[0]
local r=vars.playerCameraRotation[1]
local e=foxmath.DegreeToRadian(t-e)e=foxmath.NormalizeRadian(e)
local t=foxmath.RadianToDegree(e)
local e=foxmath.DegreeToRadian(r-n)e=foxmath.NormalizeRadian(e)
local e=foxmath.RadianToDegree(e)
if(foxmath.Absf(t)<a)and(foxmath.Absf(e)<o)then
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
local function c(e,a)
for t,e in pairs(e)do
if e==a then
return true
end
end
return false
end
function e.EvaluateCaptureCage(a,o,i,p)
local t=mvars
local r=t.loc_locationAnimalSettingTable
local l=r.captureCageAnimalAreaSetting
local t="wholeArea"for n,e in pairs(l)do
if((a>=e.activeArea[1]and a<=e.activeArea[3])and o>=e.activeArea[2])and o<=e.activeArea[4]then
t=e.areaName
break
end
end
local a=0
if i==2 then
a=n(e.CageRandomTableG3)
elseif i==1 then
a=n(e.CageRandomTableG2)
else
a=n(e.CageRandomTableG1)
end
local e=r.captureAnimalList
local l=r.animalRareLevel
local s=r.animalInfoList
local n={}
if e[t]==nil then
t="wholeArea"end
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
t="wholeArea"while a>=0 do
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
local i=r.animalMaterial
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
local a=math.random(1,l)e=n[a]
end
if#r==0 then
local n=""return t,e,a,n
end
if i~=nil then
local t=i[e]
if t~=nil then
if c(t,p)==false then
local t=math.random(1,#r)e=r[t]a=o
end
end
end
local n=""if s~=nil then
if e~=0 then
n=s[e].name
end
end
return t,e,a,n
end
function e.Refresh(e)
if e then
Player.ResetDirtyEffect()
end
vars.passageSecondsSinceOutMB=0
end
return e
