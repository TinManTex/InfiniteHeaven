--GameObjectCommands.lua
--referenceofallGameObjectcommands(viaSendCommand)
--[<GameObjectType>]={
--<messageId>={<param>="<pramType>",returns="<returnType>"}
--orjustthecommandcommentedoutifIhaven'tsorteditoutyet
--types:
--Vector3Table={x,y,z}wherex,y,zisfloat.
--TODOneedtonotewhethercommandistospecificinstanceorglobal/maingameobjectfortype
--Assumeinstanceunlessotherwisenoted,shouldstillverifyifcommandscanworkonsingleinstanceorglobal

--DEBUGNOWhandcompiledfromsearchingforSendCommand
--TODOcurrentlyupto(butnotstarted)TppHero
local this={
  --DEBUGNOW
  --animals
  --"TppBear",
  --"TppCritterBird",
  --"TppEagle",
  --"TppGoat",
  --"TppJackal",
  --"TppNubian",
  --"TppRat",
  --"TppStork",
  --"TppWolf",
  --"TppZebra",
  ["Animal"]={--DEBUGNOW
    SetEnabled={name="string",enabled="bool"},
    --{id="SetEnabled",name=birdInfo.name,birdIndex=0,enabled=true}
    SetRoute={name="string",route="string"},--name=animalnameingroup,route=stringorstr32??
    --{id="SetHerdEnabledCommand",type="Route",name=name,instanceIndex=0,route=route}
    --{id="SetKind",name=name,fv2Index=fv2Index}
    --{id="SetFovaInfo",name=name,color=color,isMale=true,isSetAll=true}
    --{id="SetFovaInfo",name=name,seed=seed}
    --{id="SetNoticeEnabled",name=name,enabled=enabled}--texoneofthesewillbeanimalignoresnoticingthings,theotherwillbeothersignorenoticinganimal
    --{id="SetIgnoreNotice",isPlayer=enable,isSoldier=enable}
    --{id="SetStatus",status="Sleep",set=enable}
    --{id="SetAnimalId",name=name,animalId=animalId}
    ChangeDeadState={position="Vector3",degRotationY="number"},
  },
  --bird
  --{id="ChangeFlyingZone",name=birdInfo.name,center=birdInfo.center,radius=birdInfo.radius,height=birdInfo.height}
  --{id="SetLandingPoint",birdIndex=0,name=birdInfo.name,groundPos=birdInfo.ground}
  --{id="SetAutoLanding",name=birdInfo.name}
  TppCommandPost2={
  --local tppCommandPost2={type="TppCommandPost2"}
  --SendCommand(tppCommandPost2,{id="RestoreFromSVars"})
  --local tppCommandPost={type="TppCommandPost2"}
  --SendCommand(tppCommandPost,{id="StoreToSVars"})
  --{type="TppCommandPost2"},{id="SetFultonLevel",fultonLevel=this.weaponIdTable.DD.NORMAL.FULTON_LV,isWormHole=this.weaponIdTable.DD.NORMAL.WORMHOLE_FULTON}
  --{id="SetCpMissionTarget",enable=enable}
  --returnSendCommand(cpId,{id="GetPhase",cpName=cpName})
  --{id="ChangeRouteSets"})
  --{id="ShiftChange",schedule=schedule})
  --{id="AssignSneakRouteGroup",soldiers=soldiers,group=groupName}
  --{id="SetCombatArea",cpName=cpName,combatAreaList=cpCombatSetting.combatAreaList}
  --{id="SetLrrpCp"}
  --{id="SetOuterBaseCp"}
  --{id="SetNormalCp"}
  --{id="SetMarchCp"}
  --{id="SetCpSirenType",type=locationSiren.sirenType,pos=locationSiren.pos}
  --{id="SetCpType",type=CpType.TYPE_AMERICA}
  --{id="SetChildCp"}
  --{type="TppCommandPost2"},{id="SetCpGroups",cpGroups=mvars.ene_cpGroups}
  --{id="SetRouteSelector",func=this.RouteSelector}
  --{id="SetWalkerGearParkRoute",routes=_routeSet.walkergearpark}
  --{id="SetOutOfRainRoute",routes=_routeSet.outofrain}
  --{id="ShiftChange",schedule=schedules[shiftName]}
  --{type="TppCommandPost2"},{id="SetReinforcePlan",reinforcePlan=mvars.ene_reinforcePlans}
  --{id="SetRouteEnabled",routes={route},enabled=false}
  --{id="SetCpPosition",x=listItem.cpPosition_x,y=listItem.cpPosition_y,z=listItem.cpPosition_z,r=listItem.cpPosition_r}
  --{type="TppCommandPost2"},{id="SetLocatorPosition",name=listItem.gtName,x=xPos,y=yPos,z=zPos,r=rot})
  --local tppCommandPost={type="TppCommandPost2"}
  --local command={id="SetPowerSourceGimmick",cpName=cpName,gimmicks=gimmickInfo,areaName=areaName}
  --SendCommand(tppCommandPost,command)
  --local tppCommandPost={type="TppCommandPost2"}
  --local command={id="SetCommunicateGimmick",cpName=cpName,isCommunicateBase=isCommunicateBase,gimmicks=gimmicks,groupName=groupName}
  --SendCommand(tppCommandPost,command)
  },
  TppCommonWalkerGear2={
  --SendCommand({type="TppCommonWalkerGear2"},{id="RestoreFromSVars"})
  --{id="StoreToSVars"})
  --maxInstances=SendCommand({type="TppCommonWalkerGear2"},{id="GetMaxInstanceCount"})
  --local isBroken=SendCommand(walkerGearId,{id="IsBroken"})
  --local isFultonCaptured=SendCommand(walkerGearId,{id="IsFultonCaptured"})
  --{id="IsBroken"}
  --{id="IsFultonCaptured"}
  --local resourceId={id="GetResourceId"}
  },
  TppCorpse={
  --{type="TppCorpse"},{id="InitializeAndAllocateExtendFova",face=face,body=body}
  --{type="TppCorpse"},{id="FreeExtendFova"}
  --{type="TppCorpse"},{id="ChangeFovaCorpse",name=enemyInfo.enemyName,faceId=EnemyFova.INVALID_FOVA_VALUE,bodyId=EnemyFova.INVALID_FOVA_VALUE}
  --{type="TppCorpse"},{id="RequestDisableWithFadeout",name=enemyInfo.enemyName}
  --{type="TppCorpse"},{id="RequestDisableWithFadeout",name=enemyInfo.enemyName}
  },
  TppEnemyHeli={
  --local typeHeli={type="TppEnemyHeli"}
  --SendCommand(typeHeli,{id="RestoreFromSVars"})
  --{id="StoreToSVars"})
  --{id="SetPosition",position=position,rotY=0}--VERIFYthatitsnotjustacopypaste
  --{id="IsBroken"}
  --{id="RequestRoute",route=listItem.routeName}
  --{id="DisablePullOut"}
  --SendCommand({type="TppEnemyHeli",index=0},{id="SetColoring",coloringType=heliColoringType,fova=heliColors[heliColoringType].fova})
  },
  TppHeli2={

  --return
  --local gameId=GetGameObjectId("TppHeli2","SupportHeli")
  --SendCommand(gameId,{id="CallToLandingZoneAtName",name=landingZoneName})
  --SendCommand(gameId,{id="DisablePullOut"})
  --SendCommand(gameId,{id="EnableDescentToLandingZone"})
  --SendCommand(gameId,{id="EnableLandingZone",name=landingZoneName})
  --SendCommand(heliId,{id="DoesLandingZoneExists",name=landingZoneName})
  --passengerIds=SendCommand(heliId,{id="GetPassengerIdsStaffOnly"})
  --SendCommand(mvars.hel_passengerListGameObjectId,{id="InitializePassengers"})
  --SendCommand({type="TppHeli2",index=0},{id="PullOut",forced=true})
  --SendCommand(heliId,{id="Realize"})
  --SendCommand(heliId,{id="SendPlayerAtRouteReady",route=gvars.heli_missionStartRoute})
  --SendCommand(heliId,{id="SetTakeOffWaitTime",time=5})
  --SendCommand(heliId,{id="SendPlayerAtRouteStart",isAssault=TppLandingZone.IsAssaultDropLandingZone(gvars.heli_missionStartRoute)})
  },
  TppLiquid2={
  --SendCommand({type="TppLiquid2"},{id="RestoreFromSVars"})
  --SendCommand({type="TppLiquid2"},{id="StoreToSVars"})
  },
  --TppBossQuiet2DEBUGNOWbossquietbasedonparasite
  TppParasite2={
  --{id="Realize"}
  --{id="Unrealize"}
  --SendCommand({type=skullType},{id="SetFultonEnabled",enabled=skullFultonable})

  },
  TppPlayer2={
    --SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="CreateWormhole",isEnter=true})
    --{id="DEBUG_ChangeChimeraWeapon",chimeraInfo=chimeraInfo}
    --{id="DEBUG_ChangeEquip",equipId=TppEquip.EQP_HAND_KILL_ROCKET}
    --local pos=SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex(0)},{id="GetWormholePosition"})
    --SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="RequestCarryOff"})
    --SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="SetHesitatingFire",enabled=true})
    --SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="SetWormholePosition",position=Vector3{svars.posAbortWarmhole_x,svars.posAbortWarmhole_y,svars.posAbortWarmhole_z}})
    --SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="SetWormhole",disp=true})
    --SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="SetWormholeIcon",enable=true})
    --SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="SetWormholeIconType",enable=true})
    --SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="SetSpecialAttackMode",enabled=false,type="AttackVolgin"})
    --SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="SetSpecialAttackMode",enabled=true,type="KillQuiet"})
    --local param={
    --id="SetSpecialAttackMode",
    --enabled=true,
    --type="KillSkullFace",
    --sequence=mvars.shotCount%3,
    --sequenceWaitTime=0.0,
    --cockingWaitTime=0.5,
    --}
    --SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},param)
    --local param={
    --id="SetSpecialAttackMode",
    --enabled=true,
    --type="KillSkullFace",
    --sequence=0,
    --}
    --SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="SetSpecialAttackMode",enabled=true,type="MissionPrepare",sequence=PlayerMissionPrepareAction.READY,})
    --SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="SetStandMoveSpeedLimit",speedRateLimit=0.5})
    --SendCommand({type="TppPlayer2",index=0},{id="Warp",pos=subEventTable.position,rotY=TppMath.DegreeToRadian(subEventTable.rotationY),})
    WarpAndWaitBlock={pos="Vector3Table",rotY="number"},
  --local command={id="WarpToStation",stationId=mvars.ply_selectedCboxDeliveryUniqueId}
  },
  TppSecurityCamera2={
    --SendCommand({type="TppSecurityCamera2"},{id="RestoreFromSVars"})
    --{id="StoreToSVars"})
    IsGunCamera={returns="bool"},
  },
  TppSoldier2={
    --local stateFlag=SendCommand(gameId,{id="GetStateFlag"})
    --if(band(stateFlag,StateFlag.DYING_LIFE)~=0)then
    --local tppSoldier2={type="TppSoldier2"}
    --SendCommand(tppSoldier2,{id="RestoreFromSVars"})
    --local tppSoldier={type="TppSoldier2"}
    --SendCommand(tppSoldier,{id="StoreToSVars",markerOnly=markerOnly})
    SetEnabled={enabled="bool"},
  --{id="SetEnabled",enabled=false,noAssignRoute=noAssignRoute}
  --{id="SetSneakRoute",route=route,point=point}
  --{id="SetSneakRoute",route=route,point=point,isRelaxed=isRelaxed})--VERIFYisrelaxedVERIFYHOSTAGEtoo
  --{id="SetCautionRoute",route=route,point=point}
  --{id="SetAlertRoute",enabled=true,route=route,point=point}
  --{id="SetAlertRoute",enabled=false,route="",point=point}
  --{id="SetRestrictNotice",enabled=true}
  --{type="TppSoldier2"},{id="RegistGrenadeId",grenadeId=grenadeId,stunId=stunId}
  --{id="SetEquipId",primary=primaryId,secondary=secondaryId,tertiary=tertiaryId}
  --{id="SetWearEquip",flag=wearEquipFlag}--texsetsequipfovasithink
  --{id="ChangeFova",faceId=gvars.ene_fovaUniqueFaceIds[n],bodyId=gvars.ene_fovaUniqueBodyIds[n]}
  --{id="ChangeFova",faceId=faceId,bodyId=bodyId,balaclavaFaceId=balaclavaFaceId,isScarf=true}
  --{id="SetStaffId",staffId=staffId}
  --{id="SetHostage2Flag",flag="dd",on=true}
  --{id="SetHostage2Flag",flag="female",on=true}
  --{id="UseExtendParts",enabled=isFemale}
  --{id="SetSoldier2Type",type=soldierType}
  --{id="SetSoldier2SubType",type=enemySubTypeForSubTypeName[subTypeName]}
  --{id="SetPersonalAbility",ability=abilitySettings}
  --{id="SetConversationList",list=conversationList}
  --{id="SetSaluteVoiceList",list=saluteVoiceList}
  --{type="TppSoldier2"},{id="IsActiveSoldierInRange",position=pos,range=range}
  --{type="TppSoldier2"},{id="SetOutOfArea",soldiers=soldiers,isOut=isOut}
  --{id="ResetSoldier2Flag"}
  --lifeStatus=SendCommand(gameId,{id="GetLifeStatus"})
  --return SendCommand(gameId,{id="GetActionStatus"})--VERIFY,thisorhostageorboth?
  --return SendCommand(gameId,{id="GetStatus"})--VERIFY,thisorhostageorboth?
  --{id="ChangeLifeState",state=lifeState}))--VERIFY,thisorhostageorboth?
  --{id="AddRouteAssignMember"}
  --{id="SetCommandPost",cp=cp}
  --{id="SetLrrp",travelPlan=mvars.ene_lrrpTravelPlan[cpId]}
  --{id="SetRelativeVehicle",targetId=lrrpVehicle,rideFromBeginning=true}
  --{type="TppSoldier2"},{id="SetSwitchRouteFunc",func=this.SwitchRouteFunc}
  --Vector3position={id="GetPosition"}
  --{type="TppSoldier2"},{id="SetTravelPlan",travelPlan=mvars.ene_travelPlans}
  --{type="TppSoldier2"},{id="InitializeAndAllocateExtendFova",face=face,body=body}
  --{type="TppSoldier2"},{id="FreeExtendFova"}
  --{type="TppSoldier2"},{id="RegistSwarmEffect"}--zombieparasiteeffect
  --{type="TppSoldier2"},{id="UnregistSwarmEffect"}
  --{id="SetVoiceType",voiceType=enemyDef.voiceType}
  --{id="SetLangType",langType=hostageInfo.langType}
  --{id="SetZombie",enabled=true,isMsf=false,isZombieSkin=true,isHagure=true}
  --{id="SetZombieUseRoute",enabled=true}
  --{id="SetEverDown",enabled=false}--zombie
  --{id="SetSoldier2Flag",flag="highRank",on=true}
  --{id="RequestVanish"}
  --{id="Refresh"}
  },
  --DEBUGNOWhostagetypes?
  --local restoreGameIdTypes={
  --"TppHostage2",
  --"TppHostageUnique",
  --"TppHostageUnique2",
  --"TppHostageKaz",
  --"TppOcelot2",
  --"TppHuey2",
  --"TppCodeTalker2",
  --"TppSkullFace2",
  --"TppMantis2"
  --}
  Hostage={--DEBUGNOW
  --SendCommand({type=hostageObjectType},{id="RestoreFromSVars"})
  --SendCommand({type=hostageType},{id="ReadyToStoreToSVars"})
  --SendCommand({type=hostageType},{id="StoreToSVars",markerOnly=markerOnly})
  --max=SendCommand({type=hostageObjectType},{id="GetMaxInstanceCount"})
  --local lifeStatus=SendCommand(gameId,{id="GetLifeStatus"})
  --local status=SendCommand(gameId,{id="GetStatus"})
  --{id="isFemale"}
  --{id="GetStaffId",divided=true}
  --{id="GetFaceId"}
  --{id="GetKeepFlagValue"}
  --{id="SetStaffId",divided=true,staffId=staffId,staffId2=staffId2}
  --{id="SetEnabled",enabled=true})
  --{id="Warp",position=position})--Vector3
  --{id="SetFaceId",faceId=gvars.ene_takingOverHostageFaceIds[t]})
  --{id="SetKeepFlagValue",keepFlagValue=gvars.ene_takingOverHostageFlags[t]}
  --{id="SetVoiceType",voiceType=enemyDef.voiceType}
  --{id="SetLangType",langType=hostageInfo.langType}
  --{id="SpecialAction",action="PlayMotion",path=hostageInfo.path,autoFinish=false,enableMessage=true,commandId=StrCode32"CommandA",enableGravity=false,enableCollision=false})
  --{id="ChangeFova",bodyId=bodyId,faceId=faceId}
  --{id="RequestVanish"}
  },
  --??hostage?soldier??both??
  --SendCommand(gameId,{id="SetVip"})
  --SendCommand(gameId,{id="SetForceRealize"})
  --SendCommand(gameId,{id="SetIgnoreSupportBlastInUnreal",enabled=true})
  --{id="IsChild"}
  --{id="GetMarkerEnabled"}
  --{id="GetPosition"}
  --{id="SetIgnoreDisableNpc",enable=enable}
  --{id="RequestForceFulton"}
  --{id="RequestDisableWithFadeout"}

  TppVehicle2={
  --SendCommand({type="TppVehicle2"},{id="RestoreFromSVars"})
  --{id="StoreToSVars"})
  --{type="TppVehicle2"},{id="Spawn",locator="veh_s10054_0000",type=Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE,class=Vehicle.class.DEFAULT,},
  --{type="TppVehicle2"},{id="Despawn",locator="veh_s10054_0008",type=Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE,subType=Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY,class=Vehicle.class.DEFAULT,},
  --{type="TppVehicle2"},{id="Respawn",name=name,type=9,subType=subType,paintType=paintType,class=class}--alsowithspecificinstance??
  --{id="IsAlive"}
  },
  TppUav={
  --SendCommand({type="TppUav"},{id="RestoreFromSVars"})
  --{id="StoreToSVars"})
  },
}



return this
