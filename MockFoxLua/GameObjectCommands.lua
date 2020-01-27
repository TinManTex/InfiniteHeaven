--GameObjectCommands.lua
--reference of all GameObject commands(via SendCommand)
--[<GameObjectType>]={
--<messageId>={<param>="<pramType>",returns="<returnType>"}
--or just the command commented out if I haven't sorted it out yet
--types:
--Vector3Table={x,y,z}where x,y,z is float.
--TODO need to note whether command is to specific instance or global/main gameobject for type
--Assume instance unless otherwise noted,should still verify if commands can workon single instance or global

--DEBUGNOW hand compiled from searching for SendCommand
--TODO currently up to (but not started)s10030_enemy
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
  TppBuddyDog2={
  --      local command={id="SetEnabled",enabled=false}
--     local gameId=GameObject.GetGameObjectIdByIndex("TppBuddyDog2",0)
--      SendCommand(gameId,{id="GetPlant",uniqueId=resourceId})
--SendCommand( gameObjectId, { id = "SetMotherBaseCenterAndRadius", center = pos, radius = radius } )
--  command = { id = "LuaAiStayAndSnarl", position=pos1, look=pos2 }
--local command = { id = "SetWarpPosition", pos = Vector3( 540.217, 335.125, 29.102 ), }
  },
  TppBuddyPuppy={
--  local gameObjectId = { type = "TppBuddyPuppy", index = 0 }
--  GameObject.SendCommand( gameObjectId, { id = "SetFova", fv2Index = fv2Index } ) 
--  GameObject.SendCommand( gameObjectId, { id = "SetFultonEnabled", enabled = false } )
--  
  },
  TppBuddyQuiet2={
--      local command={id="SetEnabled",enabled=false}

  },
  TppCommandPost2={
  --noninstance ({type="TppCommandPost2"})
  --{id="RestoreFromSVars"}
  --{id="StoreToSVars"}
  --{id="SetFultonLevel",fultonLevel=this.weaponIdTable.DD.NORMAL.FULTON_LV,isWormHole=this.weaponIdTable.DD.NORMAL.WORMHOLE_FULTON}
  
  --instance
  --{id="SetCpMissionTarget",enable=enable}--for mission bgm aparently
  
  --local phase=SendCommand(cpId,{id="GetPhase",cpName=cpName})
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
  --  SendCommand(cpId,{id="AssignInterrogationWithVoice",soundParameterId=soundParameterId,index=index})
  --  SendCommand(cpId,{id="AssignInterrogation",messageId=messageId,index=index})
  -- SendCommand(cpId,{id="AssignInterrogationCollection"})
  --SendCommand({type="TppCommandPost2"},{id="SetReinforceEnable"})
  --  SendCommand({type="TppCommandPost2"},{id="SetNominateList",driver=driverId,vehicle=vehicleId,sol01=reinforceSoldiers[1],sol02=reinforceSoldiers[2],sol03=reinforceSoldiers[3],sol04=reinforceSoldiers[4]})
  --  SendCommand(soldierId,{id="SetEnabled",enabled=enabled})
  --SendCommand({type="TppCommandPost2"},{id="SetReinforcePrepared"})
  --SendCommand({type="TppCommandPost2"},{id="SetReinforceCount",count=reinforceCount})
--    local gameObjectId   = { type = "TppCommandPost2", index=0 }
--  local command    = { id = "SetRouteExcludeChat", routes = routeTable, enabled = enabled }
--  local gameObjectId = { type="TppCommandPost2", index=0 }
--  local command = { id = "SetFriendlyCp" }
--local command = { id = "SetReinforceTime", time=time }
--local command = { id = "SetLocatorMemberCount", name = value, count = count, front = front, }
--local gameObjectId = { type="TppCommandPost2" } 
--    local command = { id = "SetCombatArea", cpName = mtbs_enemy.cpNameDefine, combatAreaList = combatAreaList }
--  local cpId = { type="TppCommandPost2" } 
--  local command = { id = "SetFOBReinforceCount", count=reinforceCount }
--  local command = { id = "SetIgnoreLookHeli" }
--  local cpId = { type="TppCommandPost2" } 
--local command = { id = "SetKeepCaution", enable=true }
--            local gameObjectId = GameObject.GetGameObjectId( mtbs_enemy.cpNameDefine )
--  local cp = GameObject.GetGameObjectId( mtbs_enemy.cpNameDefine )
--    local command = { id = "RequestNotice", type = 0, targetId = gimmickId, sourceId = playerId }
--  GameObject.SendCommand( cp, { id = "SetPhase", phase=TppGameObject.PHASE_ALERT } )
--    GameObject.SendCommand( cp, { id = "SetFOBPlayerDiscovery" } )
--  local gameObjectId = { type="TppCommandPost2" } 
 -- local command = { id="SetChatEnable", enabled=false } 
 -- GameObject.SendCommand( GameObject.GetGameObjectId( "cypr_cp" ), { id = "SetSkullCp", } )
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
  --  GameObject.SendCommand( GameObject.GetGameObjectId( "TppCorpse", locatorName ), { id = "SetForceUnreal", enabled = true, } )
  --    GameObject.SendCommand( gameObjectId, { id = "SetForceUnreal", enabled = not subEventTable.enable } )
  
  },
  TppDecoySystem={
--     local command={type="TppDecoySystem"}
--    SendCommand(command,{id="StorePlayerDecoyInfos"})
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
--   SendCommand(heliId,{id="RequestReinforce",toCp=cp})
--    SendCommand(heliId,{id="SetCommandPost",cp=cp})--tex i think this is the cause of the heli ! sound on reinforce (because the cp is already at alert when it's assigned), don't know how to supress it, disabling or shifting order prevents reinforce from happening
--      SendCommand(heliId,{id="DisablePullOut"})
--SendCommand(enemyHeli,{id="SetMessagePlayerIsWithinRange",name="CheckRange400",enabled=true,range=400}) --DEBUGNOW what is this?

--  local gameObjectId  = GameObject.GetGameObjectId("EnemyHeli" )
--  local heliBroken  = GameObject.SendCommand( gameObjectId, { id="IsBroken" } )
--    GameObject.SendCommand(gameObjectId, { id="Recover" })
--  GameObject.SendCommand(gameObjectId, { id = "RequestRoute", route = "rt_quest_heli_d_0000" })

--  GameObject.SendCommand( gameObjectId, { id = "SetSneakRoute", enabled = isEnabled, route = routeName } )
--  GameObject.SendCommand( gameObjectId, { id = "SetCautionRoute", enabled = isEnabled, route = routeName } )
--  GameObject.SendCommand( gameObjectId, { id = "SetAlertRoute", enabled = isEnabled, route = routeName } )
--  local command = { id = "SetForceRoute", route = subEventTable.routeName }

  },
  TppHeli2={
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
  --SendCommand({type="TppHeli2",index=0},{id="SetDemoToAfterDropEnabled",enabled=true,route="ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_tkof",isTakeOff=true})
--    local heliRoute=GameObject.SendCommand({type="TppHeli2",index=0},{id="GetUsingRoute"})
  --   GameObject.SendCommand(vehicleId,{id="Seize",options={"Fulton","CheckFultonType","DirectAccount"}})
  --SendCommand({type="TppHeli2",index=0},{id="SetSendDoorOpenManually",enabled=true})
  --SendCommand( { type="TppHeli2", index=0, }, { id="SetAutoWithdrawalEnabled", enabled=false } )
  --SendCommand( gameObjectId, { id = "DisableLandingZone", name = landingZoneName })
  --GameObject.SendCommand( { type="TppHeli2", index=0, }, { id="CreateWormhole", isEnter=true } ) 
--    GameObject.SendCommand(gameObjectId, { id="EnableDescentToLandingZone" })   
--    GameObject.SendCommand(gameObjectId, { id="DisableDescentToLandingZone" })
--GameObject.SendCommand(gameObjectId, { id="EnablePullOut" })    
--  GameObject.SendCommand(gameObjectId, { id="SetSearchLightForcedType", type="Off" } )
--  GameObject.SendCommand( gameObjectId, { id="SetForceRoute", enabled=false })
--  GameObject.SendCommand(gameObjectId, { id="CallToLandingZoneAtName", name="lzs_slopedTown_E_0000" })
--    GameObject.SendCommand(gameObjectId, { id="DisablePullOut" })         
--    GameObject.SendCommand(gameObjectId, { id="DisableDescentToLandingZone" })    
--      local gameObjectId = GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
--      GameObject.SendCommand(gameObjectId, { id="SetCombatEnabled", enabled=false })
--      local gameObjectId = GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
--      GameObject.SendCommand(gameObjectId, { id="DisableDescentToLandingZone" })
 -- GameObject.SendCommand(gameObjectId, { id="Realize" })
--    GameObject.SendCommand(gameObjectId, { id="CallToLandingZoneAtName", name="lzs_villageNorth_N_0000" })
--GameObject.SendCommand(gameObjectId, { id="SetRequestedLandingZoneToCurrent" } ) 
  },
  --Horse --? gameobject class name??
  --SendCommand(vars.playerVehicleGameObjectId,{id="HorseForceStop"})
  TppLiquid2={
  --SendCommand({type="TppLiquid2"},{id="RestoreFromSVars"})
  --SendCommand({type="TppLiquid2"},{id="StoreToSVars"})
--    local gameObjectId = { type="TppLiquid2", index=0 }  
--  GameObject.SendCommand( gameObjectId, { id = "SetMotherbaseMode"} )
--  GameObject.SendCommand( gameObjectId, { id = "InitiateCombat"} )
--  GameObject.SendCommand( gameObjectId, { id = "SetForceUnrealize", forceUnrealize = true } )

  },
  TppBossQuiet2={-- DEBUGNOWbossquietbasedonparasite
  --local quietType=SendCommand({type="TppBossQuiet2"},{id="GetQuietType"})
   -- GameObject.SendCommand( { type="TppBossQuiet2", index=0 }, {id="SetForceUnrealze", flag=deactiveFlag} )
--      command = { id="ShootPlayer" }
--    command = { id="ShootPosition", position="position" }
  },
  TppMarker2LocatorSystem={
--      local e={type="TppMarker2LocatorSystem"}
--    SendCommand(e,{id="RestoreFromSVars"})
--    local e={type="TppMarker2LocatorSystem"}
--    SendCommand(e,{id="StoreToSVars"})
  },
  TppParasite2={
  --{id="Realize"}
  --{id="Unrealize"}
  --SendCommand({type=skullType},{id="SetFultonEnabled",enabled=skullFultonable})
--local parasiteType=SendCommand(gameId,{id="GetParasiteType"}) VERIFY game object class
--  GameObject.SendCommand( { type="TppParasite2" }, { id="SetParameters", params=params } ) 
--  GameObject.SendCommand(
--    { type="TppParasite2" },
--    {
--      id="SetCombatGrade",
--      defenseValueMain = combatGrade.defenseValueMain,
--      defenseValueArmor = combatGrade.defenseValueArmor,
--      defenseValueWall = combatGrade.defenseValueWall,
--      offenseGrade = combatGrade.offenseGrade,
--      defenseGrade = combatGrade.defenseGrade,
--    }
--  )
--
--  
--  local clusterId = MotherBaseStage.GetFirstCluster() + 1
--  local posSpotList, rotSpotY = mtbs_cluster.GetPosAndRotY_FOB( TppDefine.CLUSTER_NAME[o50050_sequence.currentClusterSetting.numClstId], "plnt0", {0,0,0}, 0 )
--  GameObject.SendCommand( { type="TppParasite2" }, { id="StartAppearance", position=Vector3(posSpotList[1],posSpotList[2]+0.0001,posSpotList[3]), radius=15.0 } )
--GameObject.SendCommand( gameObjectId, { id="StartSearch" })
--      GameObject.SendCommand( gameObjectId, { id="StartCombat" })
--  GameObject.SendCommand(GameObject.GetGameObjectId("TppParasite2", "Parasite0"), { id="StartWithdrawal" })
  --  GameObject.SendCommand(GameObject.GetGameObjectId("TppParasite2", "Parasite0"), { id="StartGuard" })
--GameObject.SendCommand( { type="TppParasite2" }, { id="SetFogActionEnabled", enabled=false } )    
--      GameObject.SendCommand( { type="TppParasite2" }, { id="StartTargetKill", targetId=targetId } ) 
--      GameObject.SendCommand( { type="TppParasite2" }, { id="SetParameters", params=params } ) 
--      GameObject.SendCommand( { type="TppParasite2" }, { id="SetFultonEnabled", enabled=true } )
 --GameObject.SendCommand(GameObject.GetGameObjectId("TppParasite2", "Parasite0"), { id="SetDeterrentEnabled" ,enabled="true"})
  --      GameObject.SendCommand( { type="TppParasite2" }, { id="StartTargetKill", targetId=targetId } ) 

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
    --local command={id="WarpAndWaitBlock",pos=pos,rotY=rotY}
    --SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},{id="RequestCarryOff"})
--     local command = { id = "SwitchRoute", route = "" }
--  GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="CreateWormhole", isEnter = true } )
--  local pos = GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex(0) }, { id="GetWormholePosition" } )
--GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="SetWormholePosition", position = Vector3{svars.posAbortWarmhole_x,svars.posAbortWarmhole_y,svars.posAbortWarmhole_z} } )
--  
--  GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="SetWormhole", disp = true } )
--  GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="SetWormholeIcon", enable=true } )
--  GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="SetWormholeIconType", enable = true } )  
 -- GameObject.SendCommand( GameObject.GetGameObjectId( "Player" ), { id = "SetBaseMotionSpeedRate", speedRate = subEventTable.motionSpeed, } )
  --  GameObject.SendCommand( GameObject.GetGameObjectId( "Player" ), { id = "SetSpecialAttackMode", enabled = true, type = "AttackVolgin" } )
  --    GameObject.SendCommand( { type = "TppPlayer2", index = PlayerInfo.GetLocalPlayerIndex() }, { id = "SetSpecialAttackMode", enabled = false, type = "AttackVolgin" } )
  
  },
  TppRat={
--  local tppRat={type="TppRat",index=0}
--      local command={id="Warp",name=name,ratIndex=0,position=ratRouteInfo.pos,degreeRotationY=0,route=ratRouteInfo.name,nodeIndex=0}
  --    local tppRatId={type="TppRat",index=0}
   -- local command={id="SetEnabled",name=name,ratIndex=0,enabled=enabled}
  },
  TppSecurityCamera2={
    --SendCommand({type="TppSecurityCamera2"},{id="RestoreFromSVars"})
    --{id="StoreToSVars"})
    IsGunCamera={returns="bool"},
    --SendCommand( gameObjectId, {id = "SetFriendly"} )
--      local gameObjectId = { type="TppSecurityCamera2"}
--    GameObject.SendCommand( gameObjectId, { id="SetFreePositionCamera" } )
--    
  },
  
  TppSoldier2={
  --    local command = { id = "ChangeLifeState", state = TppGameObject.NPC_LIFE_STATE_DEAD, }
  --    local command = { id = "SetEnableDyingState", enabled = false }
--    GameObject.SendCommand( GameObject.GetGameObjectId("TppSoldier2", "sol_p21_010490_0001" ), { id="SetCommandAi", commandType = CommandAi.SHOOT_PRACTICE, commandIndex = 0, } )
--              GameObject.SendCommand( GameObject.GetGameObjectId("TppSoldier2", "sol_p21_010490_0002" ), { id="SetCommandAi", commandType = CommandAi.SHOOT_PRACTICE, commandIndex = 1, } )     
 --GameObject.SendCommand( gameObjectId, { id = "SetIgnoreDisableNpc", enable = true, } )
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
  --  local command = { id="SetHostage2Flag", flag="disableVoice", on=false }
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
--    local isZombieOrMsf=SendCommand(gameId,{id="IsZombieOrMsf"})
--  local isChild=SendCommand(gameId,{id="IsChild"})
--       loca isDoneHoldup= SendCommand(gameId,{id="IsDoneHoldup"})then        
--            SendCommand(gameId,{id="SetDoneHoldup"})
--local isDD= SendCommand(gameId,{id="IsDD"}
--SendCommand({type="TppSoldier2"},{id="CreateFaceIdList"})
--SendCommand({type="TppSoldier2"},{id="SetMbInterrogate",enableMask=enableMask})
--SendCommand(soldierId,{id="RegenerateStaffIdForReinforce"})
 --local command={id="SetToHeliRecoveredComplete"}
 --SendCommand( gameObjectId, { id = "RequestForceFulton" } )
--    local command = { id = "GetStaffId" }
--    local staffId = SendCommand( GameObject.GetGameObjectId(soldierName), command )
--  local gameObjectId = { type="TppSoldier2" }
--  local command = { id = "SetEmblemType", type = 1 }
--  GameObject.SendCommand( gameObjectId, command )
--  local gameObjectId = { type="TppSoldier2" }
--  local command = { id="SetFriendly", enabled=true }
--  GameObject.SendCommand( gameObjectId, command )
--SendCommand( gameObjectId, { id = "SetEnabled", enabled = false, } )
--local type = GameObject.SendCommand( gameObjectId, { id = "GetSoldier2Type" } )
--    GameObject.SendCommand( gameObjectId,
--      {
--        id        = "SpecialAction",
--        action      = "PlayMotion",
--        path      = path,
--        autoFinish    = false,
--        enableMessage = true,
--        commandId   = StrCode32("CommandA"),
--        enableGravity = false,
--        enableCollision = false,
--        enableGroupRate = enableDelayMotion,
--      }
--    )
--  local command = { id="SetSaluteMoraleDisable", enabled=true }
--local command = { id = "SetNoBloodMode", enabled=true }
--      GameObject.SendCommand( gameObjectId, { id = "SetZombie", enabled = true, isMsf = false, isZombieSkin = true, isHagure = false } )
--      GameObject.SendCommand( gameObjectId, { id = "SetZombie", enabled = false } )
--      GameObject.SendCommand( gameObjectId, { id = "SetEverDown", enabled = true } )
--msfzombie/wandersoldier mode
--    local gameObjectId = { type="TppSoldier2" } 
--      local command = { id = "SetMsfCombatLevel", level = 0 }
--    local gameObjectId = { type="TppSoldier2" }
--  local command = { id = "SetEscapePosition", posList = EscapePosList }
--  local command = { id = "ClearEscapePosition" }
 -- local soldiers = GameObject.SendCommand( { type = "TppSoldier2" }, { id = "GetGameObjectIdUsingRoute", route = routeName } )
--  local command = { id = "CallConversation", label = speechLabel, friend = friendGameObjectId, }
--  GameObject.SendCommand( speakerGameObjectId, command )
--GameObject.SendCommand( GameObject.GetGameObjectId( "sol_p21_010440_0001" ), { id="SetEquipId", tertiary=TppEquip.EQP_WP_East_ms_010 } )
--  GameObject.SendCommand( gameObjectId, { id = "SetEnabled", enabled = false, } )
--      GameObject.SendCommand( gameObjectId, { id = "SetPuppet", enabled = true, } )
--local command = { id="AddDamage", attackId = TppDamage.ATK_10004, ownerGameObjectId = 0, isOneHitKill = true, isHeadShot = true, }
--      GameObject.SendCommand( gameObjectId, { id = "SetForceRealize", forceRealize = enable, } )
--        GameObject.SendCommand( gameObjectId, { id = "SetGunLightSwitch", isOn = light, useCastShadow = castShadow, } )
--        GameObject.SendCommand( gameObjectId, { id = "SetVisibleSuppressor", isVisible = suppressor, } )    
--        GameObject.SendCommand( gameObjectId, { id = "SetSkull", enabled = true, } )    
--        GameObject.SendCommand( gameObjectId, { id = "SetChickenwingGunAim", enabled = true, } )
--    GameObject.SendCommand( gameObjectId, { id = "SetCommandAi", commandType = CommandAi.FORCE_SHOOT, } )
          --  GameObject.SendCommand( gameObjectId, { id = "SetDiscoveryPlayer", } )
--          local ability = {
--        shot    = "low",
--        grenade = "low",
--        hp      = "low",
--        cure    = "low",
--        speed   = "low",
--        notice  = "low",
--        reflex  = "low",
--        reload  = "low",
--        holdup  = "low",
--      }
--      local command = { id = "SetPersonalAbility", ability=ability }
--      GameObject.SendCommand( gameObjectId, command )
--local relation_command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false }
 --GameObject.SendCommand( gameObjectId, { id = "StartTravel", travelPlan = "travelVehicle" } )
  },
  TppSupplyCboxSystem={
  --    local e={type="TppSupplyCboxSystem"}
   -- SendCommand(e,{id="RestoreRequest"})
--       local e={type="TppSupplyCboxSystem"}
--    SendCommand(e,{id="StoreRequest"})
  },
  TppSupportAttackSystem={
--      local e={type="TppSupportAttackSystem"}
--    SendCommand(e,{id="RestoreRequest"})
--    local e={type="TppSupportAttackSystem"}
--    SendCommand(e,{id="StoreRequest"})
  },
  --DEBUGNOWhostagetypes?
  --local restoreGameIdTypes={
  --"TppHostage2",
  --"TppHostageUnique",
  --"TppHostageUnique2",
  --"TppHostageKaz",
  TppOcelot2={
--          local tppOcelot={type="TppOcelot2",index=0}
--        local command={id="ChangeFova",faceId=EnemyFova.INVALID_FOVA_VALUE,bodyId=371}
--        GameObject.SendCommand(tppOcelot,command)
--local command={id="SetEnabled",enabled=false}
--  local gameObjectId = { type="TppOcelot2", index=0 }
--    local command = { id = "Warp", degRotationY = rotY, position = translation + Vector3(0,0.8,0) }
--  local command = { id = "GetPosition" }
--  local ocelotPosition = GameObject.SendCommand( gameObjectId, command )
--  local gameObjectId = GameObject.GetGameObjectId( "ocelot" )
--      GameObject.SendCommand( gameObjectId, { id = "SetDemoToRideHorse", horseId = GameObject.GetGameObjectId( "ocelot_horse" ), } )

  },
  --"TppHuey2",
  --"TppCodeTalker2",
  --"TppSkullFace2",
  --"TppMantis2"
  --}
  --TppPaz?
  --SendCommand(this.GetPazGameObjectId(),{id="IsReal"})
  --SendCommand(this.GetPazGameObjectId(),{id="Warp",position=position,rotationY=rotationY})
  -- SendCommand(this.GetPazGameObjectId(),{id="SpecialAction",action=action[1],path=path,state=path,autoFinish=false,enableMessage=true,commandId=StrCode32(commandId),enableGravity=false,enableCollision=false,interpFrame=interpFrame})
  -- SendCommand(this.GetPazGameObjectId(),{id="CallMonologue",label=label,reset=true})
--    local command = {
--    id = "CallMonologue",
--    label = speechSetTable.speechLabel,
--    carry = carryFlag,
--  }
--  GameObject.SendCommand( gameObjectId, command )
  --SendCommand(this.GetPazGameObjectId(),{id="GetPosition"})
  --SendCommand(this.GetPazGameObjectId(),{id="GetRotationY"})
  --local command = { id="SetEnabled", enabled=isEnable }
  --},
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
  --local isChild=SendCommand(gameId,{id="IsChild"})
  --local isDD= SendCommand(gameId,{id="IsDD"}
  -- local isFemale=GameObject.SendCommand(gameId,{id="IsFemale"})
--    GameObject.SendCommand( gameObjectId, { id = "SetHostage2Flag", flag="demoUnlock", on=false } )
--  GameObject.SendCommand( gameObjectId, { id = "SetHostage2Flag", flag= "disableMarker", on=true } )
--    local gameObjectId = GameObject.GetGameObjectId( "child_quest_0000" )
--      GameObject.SendCommand( gameObjectId, { id = "SetHostage2Flag", flag = "unlocked", on = true, } )
--    local command = { id = "SetHostage2Flag", flag = "silent", on = true }
--  local command = { id="SetHostage2Flag", flag="forceRealize", on=true }
--    local command = { id = "SetHostage2Flag", flag = "commonNpc", on = true, }  
--  GameObject.SendCommand( gameObjectId, { id = "SetHostage2Flag", flag = "commonNpc", on = true, } )
--        GameObject.SendCommand( gameObjectId, { id = "SetHostage2Flag", flag = "disableDamageReaction", on = true, } )
--        GameObject.SendCommand( gameObjectId, { id = "SetVoiceType", voiceType = "Ishmael", } )
--    
--    
--    local cmdHosState = {
--        id = "SetHostage2Flag",
--        flag = "disableFulton", 
--        on = true,
--    }
--    GameObject.SendCommand( gameObjectId, cmdHosState )
--  GameObject.SendCommand( gameObjectId, { id = "SetDisableDamage", life = true, faint = true, sleep = true } )
--  local command = { id="Warp", degRotationY=-92.8, position=Vector3(-18.6,-3.22,-0.5) }
--    GameObject.SendCommand( gameObjectId, { id="CallVoice", dialogueName="DD_Huey", parameter="HYV_1010" } )
--    GameObject.SendCommand( gameObjectId, {
--      id="SpecialAction",
--      action="PlayMotion",
--      path="/Assets/tpp/motion/SI_game/fani/bodies/hyui/hyui/hyui_s_sna_look_act1.gani",
--      autoFinish=true,
--      enableMessage=true,
--      commandId=StrCode32("FinishLookSnake"),
--      enableGravity=false,
--      enableCollision=false,
--    } )
--  GameObject.SendCommand(
--    gameObjectId,
--    {
--      id = "SpecialAction",
--      action = "PlayMotion",
--      path = motionPath,
--      startPosition = Vector3(-0.610663,1197.717,2.788802),
--      override = overrideflag,
--      autoFinish = false,
--      enableMessage = true,
--      commandId = StrCode32("CommandA"),
--      enableGravity = false,
--      enableCollision = false,
--    }
--  )
--local command = { id="SetEnabled", enabled=false }
--local command2 = {  id = "SetForceScared", scared=true, ever=true }
    --GameObject.SendCommand( GameObject.GetGameObjectId( "ishmael" ), { id = "SetDisableDamage", life = true, faint = true, sleep = true, } )
    --    GameObject.SendCommand( gameObjectId, { id = "SetFaceBloodMode", enabled = false, } )
--      GameObject.SendCommand( gameObjectId, { id = "SetDisableDamage", life = true, faint = true, sleep = true, } )
--    GameObject.SendCommand( gameObjectId, { id = "SetHostage2Flag", flag = "disableDamageReaction", on = true, } )
--  GameObject.SendCommand( gameObjectId, { id = "ChangeFova", faceId = faceId, bodyId = bodyId, } )
      --  GameObject.SendCommand( gameObjectId, { id = "Warp", degRotationY = rotationY, position = position, demoEnd = true, interpTime = 0.1, control = charaControl, } )
    --local position = GameObject.SendCommand( gameObjectId, { id = "GetPosition", } )
--    local command_Lock = {
--      id = "SetHostage2Flag",
--      flag = "disableUnlock",       
--      on = true,
--  } 
--  GameObject.SendCommand( gameObjectId, command_Lock )  
--    local command_UnLock = {
--      id = "SetHostage2Flag",
--      flag = "unlocked",       
--      on = true,
--  }     
--  local isInRangeflag = GameObject.SendCommand( gameObjectId, {
--    id="IsInRange",
--    range = CheckRange,
--    target = { vars.playerPosX, vars.playerPosY, vars.playerPosZ },
--  } ) 
--local command = { id = "SetEnemyDamageRate", rate= damageRate }
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
  TppSecurityCamera2={
--    GameObject.SendCommand({type="TppSecurityCamera2"},{id="SetEnabled",enabled=enable})
--    GameObject.SendCommand({type="TppSecurityCamera2"},{id="SetGunCamera"})
--    GameObject.SendCommand({type="TppSecurityCamera2"},{id="SetNormalCamera"})
 --     GameObject.SendCommand( gameObjectId, {id = "SetCommandPost", cp=mtbs_enemy.cpNameDefine } )
  },
  TppVehicle2={
  --SendCommand({type="TppVehicle2"},{id="RestoreFromSVars"})
  --{id="StoreToSVars"})
  --{type="TppVehicle2"},{id="Spawn",locator="veh_s10054_0000",type=Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE,class=Vehicle.class.DEFAULT,},
  --{type="TppVehicle2"},{id="Despawn",locator="veh_s10054_0008",type=Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE,subType=Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY,class=Vehicle.class.DEFAULT,},
  --{type="TppVehicle2"},{id="Respawn",name=name,type=9,subType=subType,paintType=paintType,class=class}--alsowithspecificinstance??
  --{id="IsAlive"}
  -- local vehicleType=SendCommand(vehicleId,{id="GetVehicleType"})?
  --SendCommand(vehicleId,{id="ForceStop",enabled=true})
  --SendCommand(vehicleId,{id="IsAlive"})then
  --local resourceId=GameObject.SendCommand(vehicleId,{id="GetResourceId"}) --posibly support heli too
--      local command={id="Respawn",name=name,type=9,subType=subType,paintType=paintType,class=class}
--    SendCommand(vehicleId,command)
--  else
--    SendCommand(vehicleId,{id="Despawn",name=name,type=9})
  --SendCommand( vars.playerVehicleGameObjectId, { id="SetPosition", position=Vector3(9,0.8,-42), rotY=0, } )
--    if  ( GameObject.SendCommand( vehicleId, { id="IsAlive", } ) ) then
--    GameObject.SendCommand( vehicleId, { id="SetBodyDamageRate", rate=100.0, } )
--    GameObject.SendCommand( vehicleId, { id="ForceStop", enabled=true, } )  

--{ type="TppVehicle2", }
--  { id = "Spawn", locator = "Vehicle2Locator0000", type = Vehicle.type.WESTERN_TRUCK, subType = Vehicle.subType.WESTERN_TRUCK_CARGO_ITEM_BOX, paintType=Vehicle.paintType.FOVA_0, },
--  { id = "Spawn", locator = "Vehicle2Locator0001", type = Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0, },
--  { id = "Spawn", locator = "Vehicle2Locator0002", type = Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0, },
  --
  },
  TppUav={
  --SendCommand({type="TppUav"},{id="RestoreFromSVars"})
  --{id="StoreToSVars"})
  --SendCommand( gameObjectId, {id = "SetFriendly"} )
  },
  TppMbQuiet={
  --SendCommand( { type="TppMbQuiet", index=0 }, { id="StartWakeUp", isLoop=true, isAll=false } )
  },
}

--BIRD TODO bird class types
--function this._WarpBird(baseName)
--  for index,birdInfo in ipairs(mvars.rat_bird_birdList)do
--    local birdTypeTppObject={type=birdInfo.birdType,index=0}
--      local command={id="ChangeFlyingZone",name=birdInfo.name,center=flyZone.center,radius=flyZone.radius,height=flyZone.height}
--            command={id="SetLandingPoint",birdIndex=birdIndex,name=birdInfo.name,groundPos=flyZone.ground[birdIndex+1]}
--      local command={id="SetAutoLanding",name=birdInfo.name}
--end
--    local command={id="SetEnabled",name=birdInfo.name,birdIndex=i,enabled=enable}--RETAILBUG: see above

--REF CALLER
--GameObject={
--      {msg="TapHeadShotFar",func=function(gameId)--RETAILPATCH 1070 params added to all OnTacticalActionPoint calls-v-
--        this.OnTacticalActionPoint(gameId,"TapHeadShotFar")
--      end},
--function this.OnTacticalActionPoint(gameId,tacticalTakedownType)
--TODO: find out game object type
--every other has SendCommand(int gameId or table gameId decription, command)
--this is SendCommand(int gameId, string param for command?, command)
--uhh, no I fucked this up, recheck the fixed OnTacticalActionPoint
--the params were added during 1070 so maybe it was just developer incompetence not realizing that commands can take parameters?
--  if SendCommand(gameId,{id="IsDoneTacticalTakedown"})then
--  else
--    SendCommand(gameId,{id="SetTacticalTakedown"})
--end

--Huuey
--  local gameObjectId = GameObject.GetGameObjectId( "TppHuey2GameObjectLocator" )
 -- local command = { id="Warp", degRotationY=-92.8, position=Vector3(-18.6,-3.22,-0.5) }
 
 --?
--  local gameObjectId = { type = animalSetupTable.type, index = 0 }
--  if gameObjectId == NULL_ID then
--    Fox.Error("Cannot find gameObjectId.")
--    return
--  end
--  
--  local locatorFormat = animalSetupTable.locatorFormat
--  local routeFormat = animalSetupTable.routeFormat
--
--  local groupNumber = animalSetting.groupNumber
--  for groupIndex = 0, ( groupNumber - 1 ) do
--    local locatorName = string.format( locatorFormat , groupIndex )
--    local routeName = string.format( routeFormat , groupIndex )
--    
--    local command = {
--      id        = "SetRoute",       
--      name      = locatorName,        
--      ratIndex    = 0,            
--      nodeIndex   = 0,            
--      route     =  routeName,       
--    }
--    Fox.Log( "_SetRatRoute locatorName:" ..tostring( locatorName ) .. " routeName:" ..tostring( routeName ) )
--    GameObject.SendCommand( gameObjectId, command )

--BIRD
--  if animalKey ~= "Bird" then
--    return
--  end
--
--  
--  local gameObjectId = { type = animalType, index = 0 }
--  local command = {
--      id = "SetParameter",
--      name = locatorName,
--      maxSpeed = 35.0,
--      minSpeed = 18.0,
--      flyTime = 20.0,         
--      idleTime = 100.0,        
--  }
--  GameObject.SendCommand( gameObjectId, command )
--  
--  local perchCommand = {
--    id = "WarpOnPerch",
--    name = locatorName,
--  }
--  GameObject.SendCommand( gameObjectId, perchCommand )

--
--  local animalTypeList = {
--    "TppWolf",
--    "TppJackal",
--    "TppZebra",
--    "TppBear",
--    "TppGoat",
--    "TppNubian",
--  }
--  
--  for i, animalType in ipairs( animalTypeList ) do
--    local gameObjectId = { type = animalType, index = 0 }
--    local command = {
--      id      = "SetIgnoreNotice",
--      isPlayer  = true
--    }
--    GameObject.SendCommand( gameObjectId, command )

--
--local gameObjectId = { type = "TppNubian", index = 0 }
--  local command = { id = "SetNoticeDistance", name = "anml_quest_00", distance = 2.0, isForce = forceFlag }

--  local gameObjectId = {type="TppBear", group=0, index=0}
--  local command = {
--      id="SetRoute",
--      name=locatorName, 
--      route=routeName   
--  }
--  GameObject.SendCommand( gameObjectId, command )

--ishmel
--GameObject.SendCommand( GameObject.GetGameObjectId( "ishmael" ), { id = "SetTargetId", targetId = GameObject.GetGameObjectId( "TppSoldier2", "sol_p21_010490_0000" ), headShot = true, } )--DEBUGNOW anything fun can be done with this??
--    GameObject.SendCommand( { type = "TppPlayerHorse2forVr", group = 0, index = 0}, { id = "RequestHandsGunToPlayer" } )
      
      --west heli
      --  GameObject.SendCommand( gameObjectId, { id = "SetMeshType", typeName = "uth_v00", } )
      --  GameObject.SendCommand( gameObjectId, { id = "SetRotorSoundEnabled", enabled = false } )  
       --   GameObject.SendCommand( gameObjectId, { id = "CallSound", eventName = "sfx_m_cypr_heli" } ) 
      --  GameObject.SendCommand( gameObjectId, { id = "SetEnabled", enabled = enable, } )
      
--      TppHorse2={
--            local gameObjectId    = {type="TppHorse2", group=0, index=0}
--        local command       = { id = "GetRidePlayer", }
--        local ridePlayer    = GameObject.SendCommand( gameObjectId, command )
  --    },
--          local gameObjectId = {type="TppHorse2", group=0, index=0}
--        local command = {
--          id = "SetCallHorse",
--          startPosition = Vector3( 856.598, 316.444, -45.575 ),   
--          goalPosition = Vector3( 843.663, 312.744, -20.053 )   
--        }
--      
      
      --horse?
       -- GameObject.SendCommand( gameObjectId, { id = "SetRoute", route = subEventTable.routeName, warp = warp, } )
     
     --volgin
--      GameObject.SendCommand( gameObjectId, { id = "SetForceRealize", forceRealize = realize, } )
--      GameObject.SendCommand( gameObjectId, { id = "SetForceUnrealize", forceUnrealize = not realize, } )
--     GameObject.SendCommand( gameObjectId, { id = "Warp", position = translation, rotationY = Tpp.GetRotationY( rotQuat ), } )
--    GameObject.SendCommand( { type = "TppVolgin2", index = 0, }, { id = "SetCyprusMode", })  
--    GameObject.SendCommand( { type = "TppVolgin2", index = 0, }, { id = "EnableCombat", } )
--    GameObject.SendCommand( { type = "TppVolgin2", index = 0, }, { id = "SetChasePlayerMode", chasePlayer = true, } )
--  volginvr
--    GameObject.SendCommand( GameObject.GetGameObjectId( "volgin_vr" ), { id = "RequestAttack", attackType = StrCode32( "ChargeAttack" ), } )
        --  GameObject.SendCommand( GameObject.GetGameObjectId( "volgin_vr" ), { id = "SetEnableAiAttacking", enable = false, } )
--      local command = { id = "SetInvincibleMode", enable = true, }
--              GameObject.SendCommand( GameObject.GetGameObjectId( "volgin_vr" ), command )
--  GameObject.SendCommand( { type = "TppVolgin2forVr", group = 0, index = 0, }, { id = "EnableFinalScream", } )
--          GameObject.SendCommand( volginGameObjectId, { id = "SetFirewallInfo", firewallInfo= fireWallInfo, } )
--    GameObject.SendCommand( volginGameObjectId, { id = "RequestAttack", attackType = StrCode32( "FirewallAttack"), } )
--        

--              GameObject.SendCommand( GameObject.GetGameObjectId( "volgin_horse" ), command )
--          
--  
  
      --westheli local position = GameObject.SendCommand( gameObjectId, { id = "GetPosition", } )--DEBUGNOW try on all gameobjects
      --westheli      GameObject.SendCommand( gameObjectId, { id = "SetActionCommandFireToPlayer", time = 3 } )
--      local gameObjectId = GameObject.GetGameObjectId( "WestHeli" )
--    local position = GameObject.SendCommand( gameObjectId, { id = "GetPosition", } )

--ishmael
--    local gameObjectId = GameObject.GetGameObjectId( "ishmael" )
--    local result, targetId = Gimmick.GetGameObjectId( TppGameObject.GAME_OBJECT_TYPE_DOOR, "cypr_crtn001_vrtn015_gim_n0001|srt_cypr_crtn001_vrtn015", "/Assets/tpp/level/location/cypr/block_small/02/cypr_02_asset.fox2" )
--    GameObject.SendCommand( gameObjectId, { id = "SetTargetId", targetId = targetId, curtain = true, } )

return this
